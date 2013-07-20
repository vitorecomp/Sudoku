%VITOR DE ARAUJO VIEIRA 11/0067151
%MATHEUS ROSENDO PEDREIRA
%PAULO

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

%sudoKu
sudoKu(X, P) :-
	prencheN(X, P),
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



%Prenchendo N Listas
%Essa Funçao apenas Prenche N listas sem qualquer
%validaçao ou seja ela apenas remove os zeros das
%listas passadas
prencheN([], []).
prencheN([X|Y], P) :-
	prencheN(Y, Z), 
	prenche(X, K),
	nPossuiRepetidos(K),
	P = [K|Z].

%Prenchendo uma lista
%Essa Funçao recebe uma lista com uma certa
%guantidade de 0 e retorna todas as possibilidades
%de sustituiçao de zeros desta
prenche([], []).
prenche([X|Y], R) :- R = [K | P],
		prenche(Y, P),
		((X = 0 , possui(K, [1,2,3,4,5,6,7,8,9]));
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