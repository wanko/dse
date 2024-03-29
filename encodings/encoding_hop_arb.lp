%%%%%%%%%%%%%%%%%
%% ALLOCATION  %%
%%%%%%%%%%%%%%%%%

allocated(R) :- bind(_,T,R), task(T,A).
allocated(R) :- reached(_,_,R,_).
allocated(R) :- reached(_,_,_,R).
allocated(L) :- reached(_,L,R1,R2).


%%%%%%%%%%%%%%%
%%  BINDING  %%
%%%%%%%%%%%%%%%

1 { bind(M,T,R) : map(M,T,R) } 1 :- task(T,_).

%%%%%%%%%%%%%%%
%%  ROUTING  %%
%%%%%%%%%%%%%%%

node(N;N') :- link(_,N,N').
nr_links(NR) :- NR=#count{ link(L,N,N') : link(L,N,N'), link(L,N',N), N<N'; link(L,N,N') : link(L,N,N'), not link(L,N',N) }.

{ reached(C,L,N,N') : link(L,N,N') } 1 :- node(N), comm(C,A).
{ reached(C,L,N,N') : link(L,N,N') } 1 :- node(N'), comm(C,A).

visit(C,R) :- send(T,C), bind(_,T,R).
visit(C,R') :- visit(C,R), reached(C,_,R,R').
:- reached(C,_,_,R), not visit(C,R).
:- read(T,C), bind(_,T,R), not visit(C,R).
	
hops(C,R,0)    :- send(T,C), bind(_,T,R).
hops(C,R',H+1) :- hops(C,R,H), reached(C,_,R,R'), H<NR, nr_links(NR).
hops(C,H)      :- hops(C,R,H), read(T',C), bind(_,T',R).	

%%%%%%%%%%%%%%%%%%
%%  SCHEDULING  %%
%%%%%%%%%%%%%%%%%%

%all starting times are bigger than 0
%T>=0 --> -T<=0 --> 0-T<=0
&diff { 0-T } <= 0 :- task(T,A).

%all tasks have to finish before their deadline
%T<=DL-e(T) --> T-0<=DL-e(T)
&diff { T-0 } <= V :- period(P), bind(M,T,R), executionTime(M,Time), V=P-Time.


%tasks bound onto the same resource have to be scheduled successively   
%T2-T1>=ET_T1 --> -T2+T1<=-ET_T1 --> T1-T2<=-ET_T1
&diff { T1-T2 } <= -Time1 :- task(T1,A1), task(T2,A2), T1<T2,
							                   bind(M1,T1,R), bind(M2,T2,R),
							                   priority(T1,T2),
							                   executionTime(M1,Time1).
&diff { T2-T1 } <= -Time2 :- task(T1,A1), task(T2,A2), T1<T2,
							                   bind(M1,T1,R), bind(M2,T2,R),
							                   not priority(T1,T2),
                                               not depends_trans(T1,T2), 
											   not depends_trans(T2,T1),
							                   executionTime(M2,Time2).
	
	

%communication scheduling
%Start hop
&diff { T1-C } <= -Time :- send(T1,C),
					       bind(M,T1,_),
                           executionTime(M,Time).

%Middle hops			
&diff { C1-C2 } <= -S :- conflict(C1,C2), priority(C1,C2), 
                         hops(C1,N), routingDelay(D), S=N*D.
&diff { C2-C1 } <= -S :- conflict(C1,C2), not priority(C1,C2), 
                         hops(C2,N), routingDelay(D), S=N*D.

%Last hop
&diff { C-T } <= -S :- read(T,C), hops(C,N), routingDelay(D), S=N*D.


#show bind/3.
#show reached/4.
