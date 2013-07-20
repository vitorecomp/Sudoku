%VITOR DE ARAUJO VIEIRA 11/0067151
%MATHEUS ROSENDO PEDREIRA
%PAULO

:- use_module(library(clpfd)).

%Operaçoes da Lista
%Aqui irao contar todos os regras que 
%iram reger o regime de um lista
%como as regras de controle para a cada
%uma das listas
nPossui(_, []).
nPossui(X,[K|Y]) :- nPossui(X, Y), X \= K.

nPossuiRepetidos([]).
nPossuiRepetidos([X|Y]):- 
		nPossui(X, Y), 
		nPossuiRepetidos(Y).

possui(X, [X|_]).
possui(X, [_|Y]):- 
		possui(X, Y).
		
%sudoKu Final
sudoKu(X, R) :-
	verificaTamanho(X, S),
	validaColunas(X, S),
	validaLinhas(X, S),
	controiLista(S, L),
	sudoKu(X, L, P).

%sudoKu Sem Validações
sudoKu(X, T, P) :-
	prencheN(X, P, T),
	verificaLinhas(P),
	verificaBlocos(P),
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

verificaBlocos(_).

%Prenchendo N Listas
%Essa Funçao apenas Prenche N listas sem qualquer
%validaçao ou seja ela apenas remove os zeros das
%listas passadas
prencheN([],P,_ ) :- P = [].
prencheN([X|Y], P, N) :-
	prencheN(Y, Z, N), 
	prenche(X, K, N),
	nPossuiRepetidos(K),
	P = [K|Z].

%Prenchendo uma lista
%Essa Funçao recebe uma lista com uma certa
%guantidade de 0 e retorna todas as possibilidades
%de sustituiçao de zeros desta
prenche([], [], _).
prenche([X|Y], R, T) :- R = [K | P],
		prenche(Y, P, T) ,
		((X = 0 , possui(K, T));
		( X \= 0 , K = X)).


%prenche([], []).
%prenche(X, Y) :- 
%	prenche(X, Y, X),
%	nPossuiRepetidos(Y).


%prenche([X|Y], R, G) :- R = [K | P],
%		prenche(Y, P, G),
%		X \= 0, 
%		K = X.

%