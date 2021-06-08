%%%%%%%%%%%%%%%%%
%% ALLOCATION  %%
%%%%%%%%%%%%%%%%%

allocated(R) :- bind(_,task(T,A),R), task(T,A).
allocated(R) :- reached(_,R,_).
allocated(R) :- reached(_,_,R).
allocated(link(R1,R2)) :- reached(_,R1,R2).

%%%%%%%%%%%%%%%
%%  BINDING  %%
%%%%%%%%%%%%%%%

1 { bind(M,task(T,A),R) : map(M,task(T,A),R) } 1 :- task(T,A).

%%%%%%%%%%%%%%%
%%  ROUTING  %%
%%%%%%%%%%%%%%%

%dimensional ordered rounting
coord(X,Y,Z) :- router(_,X,Y,Z).
next(X,Y,Z,X',Y',Z',X+1,Y,Z) :- coord(X,Y,Z), coord(X',Y',Z'), coord(X+1,Y,Z), X < X'.
next(X,Y,Z,X',Y',Z',X-1,Y,Z) :- coord(X,Y,Z), coord(X',Y',Z'), coord(X-1,Y,Z), X > X'.
next(X,Y,Z,X,Y',Z',X,Y+1,Z) :- coord(X,Y,Z), coord(X,Y',Z'), coord(X,Y+1,Z), Y < Y'.
next(X,Y,Z,X,Y',Z',X,Y-1,Z) :- coord(X,Y,Z), coord(X,Y',Z'), coord(X,Y-1,Z), Y > Y'.
next(X,Y,Z,X,Y,Z',X,Y,Z+1) :- coord(X,Y,Z), coord(X,Y,Z'), coord(X,Y,Z+1), Z < Z'.
next(X,Y,Z,X,Y,Z',X,Y,Z-1) :- coord(X,Y,Z), coord(X,Y,Z'), coord(X,Y,Z-1), Z > Z'.
reached(C,processor(R),router(R);C,router(R'),processor(R')) :- bind(_,T,processor(R)), bind(_,T',processor(R')), R!=R', 
															    send(T,C), read(T',C).
reached(C,router(R),router(R')) :- reached(C,_,router(R)), router(R,X,Y,Z), router(R',X',Y',Z'),
                                   read(T,C), bind(_,T,processor(TR)), router(TR,TX,TY,TZ),
								   next(X,Y,Z,TX,TY,TZ,X',Y',Z').
hops(C,N) :- bind(_,T1,processor(R)), bind(_,T2,processor(R')), R!=R',
			 send(T1,C), read(T2,C),
			 processor(R,X,Y,Z), processor(R',X',Y',Z'),
			 N = |X-X'|+|Y-Y'|+|Z-Z'|+2.	
hops(comm(T,T',A),0) :- bind(_,T1,processor(R)), bind(_,T2,processor(R)),
						send(T1,comm(T,T',A)), read(T2,comm(T,T',A)).	

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
&diff { task(T1,A1)-task(T2,A2) } <= -Time1 :- task(T1,A1), task(T2,A2), (T1,A1)<(T2,A2),
							                   bind(M1,task(T1,A1),R), bind(M2,task(T2,A2),R),
							                   priority(task(T1,A1),task(T2,A2)),
							                   executionTime(M1,Time1).
&diff { task(T2,A2)-task(T1,A1) } <= -Time2 :- task(T1,A1), task(T2,A2), (T1,A1)<(T2,A2),
							                   bind(M1,task(T1,A1),R), bind(M2,task(T2,A2),R),
							                   not priority(task(T1,A1),task(T2,A2)),
                                               not depends_trans(task(T1,A1),task(T2,A2)), 
											   not depends_trans(task(T2,A2),task(T1,A1)),
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
#show reached/3.