'''
Created on 09.12.2016

@author: kn165
'''
from warnings import warn


def implies(a, b):
	return ~a | b

class QuadTree:
	def __init__(self, vector, decisions=['e1','e2','e3'], dimensions=2, children=[]):
		self.vector = vector[:] 
		self.decision = decisions[:]
		self.dimensions=dimensions
		self.vgl = 0
		self.number_of_children = 2**dimensions
		self.parent = None
		if len(children) != 0 :
				self.children = children[:]
				if len(children) != self.number_of_children:
					warn("Dimensions and Length of children do not fit! This may lead to run time errors.")
		else:
			self.children = []
			for _ in range(0, self.number_of_children):
				self.children.append(None)

	def __str__(self):
		return str(self.vector) #+ str(self.decision)

	def getvgl(self):
		return self.vgl

	def print_tree_indented(self):
		self.print_tree_indented_internal(self)
		print(self.vgl)

	def print_tree_indented_internal(self, tree : 'QuadTree', level=0, index=-1):
		if tree == None: 
			return
		for i in range(int(self.number_of_children/2)):
			self.print_tree_indented_internal(tree.children[i], level+1,i)
		print('--' * level +str(index) + str(tree))
		for i in range(int(self.number_of_children/2), self.number_of_children):
			self.print_tree_indented_internal(tree.children[i], level+1,i)

	def to_unordered_list(self)->list:
		un_list = []
		un_list.append(self.vector)
		for i in range(self.number_of_children):
			if self.children[i] != None:
				un_list+=self.children[i].to_unordered_list()
		return un_list
		
	def test_isdominated(self, newVector:list): #k
		#can't detect if newVector (a) dominates another vector (b) when a_i <= b_i and a_j < b_j
		#doesn't matter, because this will be checked later  
		return_value = 0
		self.vgl += 1
		for dim in range(self.dimensions):
			if newVector[dim] >= self.vector[dim]:
				return_value |= 1 << (self.dimensions - dim - 1)
		return return_value
	
	def test_dominates(self, newVector): #k*
		#this test evaluates a 'newVector' better than existing vectors
		#i.e. the new vector [2,3,4] would dominate the already inserted vector [2,3,4]
		#this is unnecessary and should be avoided
		#BUT: at this point such vectors should already be detected by the test_isdominated test
		return_value = 0
		self.vgl += 1
		for dim in range(self.dimensions):
			if newVector[dim] > self.vector[dim]:
				return_value |= 1 << (self.dimensions - dim - 1)
		return return_value
	
	def dominates(self, insert, newVector, newModel, current:'QuadTree', ancestorsAlive):
		"""Checks and updates the QuadTree, i.e. dominated items are getting deleted.
		The 'ancestorsAlive' parameter provides the information that one (or more) predecessor node was already dominated by 'newVector' (ancestorsAlive=False) or not (ancestorsAlive=True).
		In the former case (ancestorsAlive=False), the 'current' node is added to the returned reinsert list.
		Otherwise, i.e. ancestorsAlive=True, the 'current' node is treated as the new root. 
		
		The 'insert' parameter determines, whether 'newVector' and 'newModel' should be considered to be inserted into the 'current' subtree (insert=True) or not (insert=False). 
		"""
		k_succ = current.test_dominates(newVector)
		reinsert = []	#initialize reinsert list
		if k_succ == 0:
			#root is obviously dominated
			#check all children if they are also dominated
			x = [l_succ for l_succ in range(1, current.number_of_children-1) if (current.children[l_succ] != None)]
			for l_succ in x:
				#insert=False -> it will be inserted here
				#ancestorsAlive=False -> 'current' is dominated and thus, not Pareto optimal anymore 
				reinsert += current.dominates(False, newVector, newModel, current.children[l_succ], False)
				current.children[l_succ] = None
			if ancestorsAlive and insert:
				current.vector = newVector
				current.decision = newModel
				for subtree in reinsert:
					current.insert_subtree(subtree)
				return []
			elif ancestorsAlive and not insert:
				if len(reinsert)>= 1:
					tmp = reinsert.pop()
					current.vector = tmp.vector
					current.decision = tmp.decision
					while len(reinsert) > 0:
						current.insert_subtree(reinsert.pop())
					return []
				else:
					#reinsert is empty. subtree has to be deleted
					current.parent.children[current.parent.children.index(current)] = None
					del current
					return []
			elif not ancestorsAlive and insert:
				#shouldn't happen
				pass
			else: #not ancestorsAlive and not insert
				return reinsert
		else: #k_succ != 0 
			#current is not dominated but incomparable to 'newVector'
			#k_succ children plus l_succ children with l > k AND (k IMP l) & (number of children - 1) = number of children - 1 ( i.e. all ones, i.e. -1) may be dominated by 'newVector' 
			
			if ancestorsAlive:
				#if 'newVector' shall be inserted in this subtree, insert it further into the k_succ subtree
				if current.children[k_succ] != None:
					reinsert += current.dominates(insert, newVector, newModel, current.children[k_succ], True)
					
				elif insert:
					#no vector at position k_succ, so 'newVector' has to be inserted at position k_succ
					current.children[k_succ] = QuadTree(newVector, newModel, len(newVector))
					current.children[k_succ].parent = current
				
				x = [l_succ for l_succ in range(k_succ + 1, current.number_of_children - 1) if (current.children[l_succ] != None) & (implies(k_succ, l_succ) == -1)]
				for l_succ in x:
					#'newVector' won't be inserted into an l_succ (insert=False)
					#ancestorsAlive is inherited
					reinsert += current.dominates(False, newVector, newModel, current.children[l_succ], ancestorsAlive)
					pass
			else: #ancestors are not alive -> all children have to be reinserted
				x = [l_succ for l_succ in range(1, current.number_of_children-1) if (current.children[l_succ] != None)]
				for l_succ in x:
					reinsert += current.dominates(False, newVector, newModel, current.children[l_succ], False)
					current.children[l_succ] = None
				reinsert.append(current)
			return reinsert
				
	def isdominated(self, newVector, root:'QuadTree'):
		k_successor = root.test_isdominated(newVector)
		#at this point, we don't care if 'newVector' dominates the currentVector
		#we only check if newVector is dominated by the tree
		#this is the case if k_succ = number_of_children - 1 (e.g. 0b111 = 0x7 for 3 objectives)
		
        # print "Checking if", newVector, "is dominated by", root.vector, "k_successor:", k_successor
		
		if k_successor == 0:
			return False
		elif k_successor == root.number_of_children - 1:
			return True
		else:
			#newVector is incomparable to current node
			#'newVector' may be dominated by k_succ subtree or l_succ subtree with: l < k AND (l IMP k) & (number of children - 1) = number of children - 1, i.e. all ones, i.e. -1
			if (root.isdominated(newVector, root.children[k_successor]) if root.children[k_successor] != None else False):
				return True
			x = [l_succ for l_succ in range(1, k_successor) if (root.children[l_succ] != None) & (implies(l_succ, k_successor) == -1)]
			for l_succ in x:
				if root.isdominated(newVector, root.children[l_succ]):
					return True
			return False	
			
	def insert_subtree(self, subtree):
		#subtree is incomparable to self and children of self
		vector = subtree.vector
		k_succ = self.test_dominates(vector)
		if self.children[k_succ] == None:
			self.children[k_succ] = subtree
			subtree.parent = self
		else:
			self.children[k_succ].insert_subtree(subtree)
			
	def insert(self, newVector, variables):
		#returns
		#			n if it dominates n vectors
		#			-1 if it is dominated by at least one vector
		#			0 if it has been added/was incomparable
		
		#first, check if 'newVector' is dominated by an element of the tree
		if(self.isdominated(newVector, self)):
			return False
		
		#second, determine the vectors that has to be deleted and reinserted, respectively
		
		self.dominates(True, newVector, variables, self, True)
		return True

# *********************************************
# *********************************************
# ************Helper Functions*****************
# *********************************************
# *********************************************

def is_dominated(vector1, vector2):
	dominated, worse, better = -2, False, False
	for i in range(0, len(vector1)):
		if vector1[i] > vector2[i]:
			worse = True
		elif vector1[i] < vector2[i]:
			better = True
	
	if worse and better:
		dominated = 0
	elif worse:
		dominated = 1
	elif better:
		dominated = -1
			
	return dominated

def check_partiel(newVector, archive):
	#Only tests if the current partial assignement is already dominated
	if archive == None:
		return True
	
	if archive.isdominated(newVector, archive):
		return False
	return True

def check_total(vec, archive : 'QuadTree'):
	#checks the completed solution and inserts it
	if archive == None:
		archive = QuadTree(vec, [], len(vec))
		return True, archive
	return archive.insert(vec, []), archive