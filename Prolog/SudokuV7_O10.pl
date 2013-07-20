%VITOR DE ARAUJO VIEIRA 11/0067151
%MATHEUS ROSENDO PEDREIRA
%PAULO

:- use_module(library(clpfd)).
:- use_module(library(lists)).

%Testes


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

%sudoKu Final
sudoKu(X, R) :-
	verificaTamanho(X, S),
	validaColunas(X, S),
	validaLinhas(X, S),
	constroiLista(S, L, 1),
	sudoKu(S, X, L, R).
 
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

%sudoKu Sem Validações
sudoKu(S, X, T, P) :-
	prencheN(X, P, T),
	verificaLinhas(P),
    verificaBlocos(S, P),
	verificaColunas(P).

%Funçoes Verificadoras
%Essas sao as funçoes responsaveis
%pela validaçao do sudoku
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


%Prenchendo N Listas
%Essa Funçao apenas Prenche N listas sem qualquer
%validaçao ou seja ela apenas remove os zeros das
%listas passadas
prencheN(L, P, N) :- prencheN(L, 0, N, L, _, P).
prencheN(NM, _, _, [],T,NM) :- transpose(NM, T).
prencheN(NM, I, N, [X|Y],T, R) :-
    I1 is I+1,
	prencheN(NM, I1, N, Y, TR, RI),
	removeL1deL2(X, N, LnPrechidos),
	prenche(TR, X, LnPrechidos, K),
	addOnList(RI, K, I, R),
	transpose(R, T).

removeL1deL2(_, [], []).
removeL1deL2([X], N, R):- delete(N, X, R).
removeL1deL2([X|Y], N, R):-
	removeL1deL2(Y, N, R2),
	delete(R2, X, R).

%Prenchendo uma lista
%Essa Funçao recebe uma lista com uma certa
%guantidade de 0 e retorna todas as possibilidades
%de sustituiçao de zeros desta
prenche(_, [], _, []).
prenche([TX|TY],[X|Y], T, [K|P]) :- 
		((X = 0 , member(K, T),\+member(K, TX), delete(T,K,T1) ,prenche(TY, Y, T1, P));
		( X \= 0 , K = X, prenche(TY, Y, T, P))).


%Operaçoes da Lista
%Aqui irao contar todos os regras que 
%iram reger o regime de um lista
%como as regras de controle para a cada
%uma das listas
nPossuiRepetidos([]).
nPossuiRepetidos([X|Y]):- 
		\+member(X, Y), 
		nPossuiRepetidos(Y).
