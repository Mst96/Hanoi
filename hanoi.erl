-module(hanoi).
-export([create_towers/1, display_towers/1, move/3, moveAll/5, solve/1]).
%method to create the towers
create_towers(N)-> 
      	[{"tower1", lists:seq(1,N)},{"tower2",[]},{"tower3",[]}].%Creates list of three tuples, with the first one having a list of 1 to N.


%method to display towers and the contents of the towers
display_towers([]) -> io:format("~n--------------------------~n"); %separates when finished displaying towers.
display_towers(List) -> 
[Head | Tail] = List, %Splits list into front element and the rest of the list.
io:format("~n ~p: ", [element(1,Head)]), %prints out name of tower
io:format("~p", [lists:reverse(element(2,Head))]), %prints out tower's contents (list)
display_towers(Tail). %calls display again

%method to move top disk from one tower(Source) to another (Destination).
move(Source, Destination, List) -> 
Firsttower = lists:nth(Source,List), %Finds which tower tuple is needed.
Secondtower = lists:nth(Destination,List),
[Head | Tail] = element(2,Firsttower), %Splits list of disks into first element and the rest of the list.

%Newlist is created, this is the same as List but the source tuple is being replaced with a new list without the front element.
Newlist = lists:keyreplace(element(1,Firsttower), 1, List, {element(1,Firsttower),lists:delete(Head, element(2,Firsttower))}), 

%AnotherNewlist is created, this is the same as List but the destination tuple is being replaced with a new list with the new element.
AnotherNewlist = lists:keyreplace(element(1,Secondtower), 1, Newlist, {element(1,Secondtower), [Head|element(2,Secondtower)]}),
display_towers(AnotherNewlist), %towers displayed.
AnotherNewlist. %List with updated towers is returned.

solve([]) -> true;
%Method to solve Tower of Hanoi, when list of towers is passed in as a parameter/
solve(List) when length(List) > 1 -> 
N = length(element(2,lists:nth(1,List))), %Find how many disks there are.
moveAll(N,1, 3, 2,List). %Call recursive function that moves all disks, with the final disk as the destination.

%Method to move all disks from one tower to another using the third spare tower.
moveAll(1,Source,Destination,Othertower,List) -> move(Source,Destination,List); %base case, if 1 then it is the final number on the
moveAll(N,Source,Destination,Othertower,List) ->
	A = moveAll(N-1,Source, Othertower, Destination, List), %Calls itself and nests all the way down to the last disk. Moves disk from source to other tower.
	B = moveAll(1,Source, Destination, Othertower, A), % Then calls base case to call move.
	moveAll(N-1, Othertower, Destination, Source, B). %Moves disks from other tower to final destination tower.