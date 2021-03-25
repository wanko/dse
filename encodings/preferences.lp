_preference(p1,max).
_preference(p1,(1,1,(M,T,A,R,Time)),1,for(atom(bind(M,task(T,A),R))),(task(T,A),Time,bind(M,task(T,A)))) :- map(M,task(T,A),R), executionTime(M,Time).
_holds(atom(bind(M,task(T,A),R)),0) :- bind(M,task(T,A),R), map(M,task(T,A),R), executionTime(M,Time).

_preference(p2,sum).
_preference(p2,(2,1,(A,P,R,M,T)),1,for(atom(bind(M,task(T,A),R))),(P,bind(M,task(T,A),R))) :- map(M,task(T,A),R), dynamicEnergy(M,P).
_holds(atom(bind(M,task(T,A),R)),0) :- bind(M,task(T,A),R), map(M,task(T,A),R), dynamicEnergy(M,P).
_preference(p2,(2,2,(P,R)),1,for(atom(allocated(R))),(P,allocated(R))) :- staticPower(R,P).
_holds(atom(allocated(R)),0) :- allocated(R), staticPower(R,P).
_preference(p2,(2,3,(P,R1,R2)),1,for(atom(reached(comm(T1,T2,A),R1,R2))),(P,reached(comm(T1,T2,A),R1,R2))) :- link(R1,R2), comm(T1,T2,A), routingEnergy(P).
_holds(atom(reached(comm(T1,T2,A),R1,R2)),0) :- reached(comm(T1,T2,A),R1,R2), link(R1,R2), comm(T1,T2,A), routingEnergy(P).

_preference(p3,sum).
_preference(p3,(3,1,(C,R)),1,for(atom(allocated(R))),(C,allocated(R))) :- resourceCost(R,C).
_holds(atom(allocated(R)),0) :- allocated(R), resourceCost(R,C).