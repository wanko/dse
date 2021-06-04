depends(T1,T2) :- send(T1,C), read(T2,C).
depends(C1,C2) :- send(T1,C1), read(T2,C1), send(T2,C2).

depends_trans(T1,T2) :- depends(T1,T2).
depends_trans(T1,T3) :- depends_trans(T1,T2), depends(T2,T3).

{priority(TA,TB)} :- TA=task(T1,A1),TB=task(T2,A2), TA < TB, 
                     task(T1,A1), task(T2,A2),
                     bind(_,TA,R), bind(_,TB,R),
                     not depends_trans(TB,TA), not depends_trans(TA,TB).

conflict(comm(T1,T2,A),comm(T1',T2',A')) :- 1 #sum{ 1 : reached(comm(T1,T2,A),R1,R2), reached(comm(T1',T2',A'),R1,R2)},
                                            comm(T1,T2,A), comm(T1',T2',A'), 
                                            (T1,T2,A) < (T1',T2',A'),
                                            not depends_trans(comm(T1,T2,A),comm(T1',T2',A')), 
                                            not depends_trans(comm(T1',T2',A'),comm(T1,T2,A)).
{priority(C1,C2)} :- conflict(C1,C2).     
