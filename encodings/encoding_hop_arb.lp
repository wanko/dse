%%%%%%%%%%%%%%%%%
%% ALLOCATION  %%
%%%%%%%%%%%%%%%%%

allocated(R) :- bind(_,task(T,A),R), task(T,A).
allocated(R) :- sink(_,R).

%%%%%%%%%%%%%%%
%%  BINDING  %%
%%%%%%%%%%%%%%%

%for the sake of binding, fifos are also tasks
1 { bind(M,task(T,A),R) : map(M,task(T,A),R) } 1 :- task(T,A).

%%%%%%%%%%%%%%%
%%  ROUTING  %%
%%%%%%%%%%%%%%%

%NOTE: This is different to Andres et al. as we require unicast instead of multicast communication between tasks
root(C,R) :- send(task(T,A),C), bind(_,task(T,A),R), task(T,A).
% resources of communication task per target
sink(C,R) :- read(T,C), bind(_,T,R).
sink(C,R) :- sink(C,S), reached(C,R,S).
% reach communication root resource
:- read(T,C), root(C,R), not sink(C,R).
% backward hops of communication task 
1 { reached(C,R,S) : link(R,S) } 1 :- sink(C,S), not root(C,S). 

%%%%%%%%%%%%%%%%%%
%%  SCHEDULING  %%
%%%%%%%%%%%%%%%%%%
%all starting times are bigger than 0
%T>=0 --> -T<=0 --> 0-T<=0
&diff { 0-task(T,A) } <= 0 :- task(T,A).

%all tasks have to finish before their deadline
%T<=DL-e(T) --> T-0<=DL-e(T)
&diff { T-0 } <= V :- period(P), bind(M,T,R), executionTime(M,Time), V=P-Time.


%tasks bound onto the same resource have to be scheduled successively   
%T2-T1>=ET_T1 --> -T2+T1<=-ET_T1 --> T1-T2<=-ET_T1
seq(task(T1,A1),task(T2,A2),Time1) :- task(T1,A1), task(T2,A2), 
                                      prio(task(T1,A1),task(T2,A2)),
                                      executionTime(M1,Time1), executionTime(M2,Time2),
                                      bind(M1,task(T1,A1),R), bind(M2,task(T2,A2),R).
&diff { T1-T2 } <= -Time :- seq(T1,T2,Time).
	
	

%communication scheduling
%Start hop
&diff { T1-C } <= -Time :- send(T1,C), read(T2,C),
					       bind(M,T1,_),
                           executionTime(M,Time).

%Middle hops
hops(comm(T,T',A),N) :- N=#count { reached(comm(T,T',A),R1,R2):  reached(comm(T,T',A),R1,R2) }, comm(T,T',A).				
&diff { C1-C2 } <= -S :- confl(C1,C2), prio(C1,C2), 
                         hops(C1,N), routingDelay(D), S=N*D.

%Last hop
&diff { C-T } <= -S :- read(T,C), hops(C,N), routingDelay(D), S=N*D.


#show bind/3.
#show reached/3.
&show_assignment{}.
