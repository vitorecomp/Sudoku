:- use_module(library(lists)).

%Add On List of List Pass Cordanates
addOnListOfLists([], T, 0, J ,[R]):-
		addOnList([], T, J, R).

addOnListOfLists([X|Y], T, 0, J, [R|Y]):-
		addOnList(X, T, J, R).

addOnListOfLists([], T, I, J, [[]|R]):-
		I1 is I - 1,
		I1 >= 0,
		addOnListOfLists([], T, I1, J, R).

addOnListOfLists([X|Y], T, I, J, [X|R]) :-
		I1 is I - 1,
		I1 >= 0,
		addOnListOfLists(Y, T, I1, J, R).

%Add on List / ModiFy
addOnList([], P, 0, [P]).

addOnList([_|Y], T, 0, [T|Y]).

addOnList([], P, K, [[]|J]) :-
		T is K - 1,
		K >= 0,
		addOnList([], P, T, J).

addOnList([X|Y], P, K, [X|J]) :-
		T is K - 1,
		T >= 0,
		addOnList(Y, P, T, J).


constroiLista(0 ,L, _):- L = [].
constroiLista(S ,L, X):-
		A is S - 1,
		A >= 0,
		P is X + 1,
		constroiLista(A ,R, P),
		L = [X|R].

validaLinhas(X, S):-
	transpose(X, P),
	validaColunas(P, S).

verificaTamanho(X, S):-
	append(X, Y),
	length(Y, P),
	Unround is sqrt(P),
	S is round(Unround).

validaColunas([], _).
validaColunas([X|Y], S) :- 
	length(X, S),
	validaColunas(Y, S).


verificaColunas([]).
verificaColunas([X|Y]) :-
	verificaColunas(Y),
	nPossuiRepetidos(X).

verificaLinhas([]).
verificaLinhas(X) :- 
		transpose(X, P),
		verificaColunas(P).

verificaBlocos(S, X) :-
	S1 is round(sqrt(S)),
	transforma(S1, X,0,P),
	verificaColunas(P).

transforma(_, [], _, []).
transforma(S, [X|Y], I, R):-
	T is I + 1,
	transforma(S, Y, T, P),
	transforma(S, X, I, 0, P, R).

transforma(_, [], _, _, P, P).

transforma(S, [X|Y], I, J ,P, R):-
	T is J + 1,
	transforma(S, Y, I, T , P, K),
	converte(S, I, J, I1, J1),
	addOnListOfLists(K, X, I1, J1, R).

converte(S,I, J, I1, J1) :-
		I1 is div(I, S) + div(J, S)*S, 
		J1 is mod(I, S) + mod(J, S)*S.


removeL1deL2(_, [], []).
removeL1deL2([X], N, R):- delete(N, X, R).
removeL1deL2([X|Y], N, R):-
	removeL1deL2(Y, N, R2),
	delete(R2, X, R).

nPossuiRepetidos([]).
nPossuiRepetidos([X|Y]):- 
		\+member(X, Y), 
		nPossuiRepetidos(Y).

%nPossuiRepetidos([0|Y]):-
%		nPossuiRepetidos(Y).