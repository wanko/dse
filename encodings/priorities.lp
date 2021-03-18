depends(T1,T2) :- send(T1,C), read(T2,C).
depends(C1,C2) :- send(T1,C1), read(T2,C1), send(T2,C2).

depends_trans(T1,T2) :- depends(T1,T2).
depends_trans(T1,T3) :- depends_trans(T1,T2), depends(T2,T3).

{prio(TA,TB)} :- TA=task(T1,A1),TB=task(T2,A2), TA != TB, 
                 task(T1,A1), task(T2,A2),
                 bind(_,TA,R), bind(_,TB,R),
                 not depends_trans(TB,TA), not depends_trans(TA,TB).
prio(TB,TA) :- TA=task(T1,A1),TB=task(T2,A2), TA != TB,
               task(T1,A1), task(T2,A2),
               not prio(TA,TB), bind(_,TA,R), bind(_,TB,R),
               not depends_trans(TA,TB), not depends_trans(TB,TA).
               
%prio_trans(A,B) :- prio(A,B).
%prio_trans(A,C) :- prio_trans(A,B), prio(B,C).
%:- prio_trans(A,A).
#edge (A,B):prio(A,B).

confl(comm(T1,T2,A),comm(T1',T2',A')) :- 1 { reached(comm(T1,T2,A),R1,R2) : 
                                                reached(comm(T1,T2,A),R1,R2), reached(comm(T1',T2',A'),R1,R2)},
                                         comm(T1,T2,A), comm(T1',T2',A'), 
                                         (T1,T2,A) != (T1',T2',A'),
                                         not depends_trans(comm(T1,T2,A),comm(T1',T2',A')), 
                                         not depends_trans(comm(T1',T2',A'),comm(T1,T2,A)).
{prio(C1,C2)} :- confl(C1,C2).
prio(C2,C1) :- confl(C1,C2), not prio(C1,C2).         
