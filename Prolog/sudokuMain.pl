%VITOR DE ARAUJO VIEIRA 11/0067151
%MATHEUS ROSENDO PEDREIRA
%PAULO

:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- include(basicFunctions).


%sudoKu Final
%Neste Modulo sao feitas as Validaçoes Basicas do
%sistema como tamanho das linhas e de colunas e neste
%tambem e montado a lista com os valores que cada termo
%pode valer

%Arg X - Matriz a Ser Resulvida 0 para blocos Vazios
%Arg Y - Resposta do Sudoku.

sudoKu(X, R) :-
	verificaTamanho(X, S),
	transpose(X, Y),
	vtColunas(S, X),
	vtColunas(S, Y),
	constroiLista(S, L, 1),
	sudoKu(S, X, L, R).
%sudoKu Sem Validações

%Responsavel por validar se o sudoKu e resoluvel
%Verificando se o Argumento nao possui nenhum
%Elemnto que ja nao satisfaza a ideia do suduku
%como elementos repetidos na coluna.

%Arg S - Ordem do Sudoku
%Arg T - Lista com os Elemetos Possiveis para cada regiao.
%Arg X - Matriz a Ser Resulvida 0 para blocos Vazios
%Arg Y - Resposta do Sudoku.

sudoKu(S, X, T, P) :-
	S1 is round(sqrt(S)),
	transpose(X, Y),
	transforma(S1, X, 0, R),
	vColunas(X),
	vColunas(Y),
	vColunas(R),
	prencheN(S1, X, P, T).


%Funcao PrencheN

%Essa Funcao prenche uma lista de lista com elementos vazios
%ja fazendo as validaçoes do sudoku ou seja nao e possivel 
%que seja inserido um valor em um elemto que ja exista na 
%coluna linha ou bloco

%Arg S1 -  E a ordem do sudoku
%Arg L - A matriz a ser prenchida
%Arg P - Resultado da Funçao
%Arg N - E a lista de termos que podem existir no sudoku

prencheN(S1, L, P, N) :- prencheN(S1, L, 0, N, L, _, P).
prencheN(_, NM, _, _, [] ,T,NM) :- transpose(NM, T).
prencheN(S1, NM, I, N, [X|Y],T, R) :-
    I1 is I+1,
	prencheN(S1, NM, I1, N, Y, TR, RI),
	removeL1deL2(X, N, LnPrechidos),
	prenche(TR, X, LnPrechidos, K),
	addOnList(RI, K, I, R),
	transforma(S1, R, 0, P),
	vColunas(P),
	transpose(R, T).

%Prenche

%E a funçao que recebe dua lista e prenche uma
%os elemtos de uma lista com os valore da outra 
%lista

%Arg X - As linhas da matriz
%Arg L - A lista a ser prenchida
%Arg T - A coluna da matriz
%Arg K - Resposta da Lista.
prenche(_, [], _, []).
prenche([TX|TY],[X|Y], T, [K|P]) :- 
		((X = 0 , member(K, T),\+member(K, TX), delete(T,K,T1) ,prenche(TY, Y, T1, P));
		( X \= 0 , K = X, prenche(TY, Y, T, P))).


%Estado

%Recebe um sudoku e dita o estado para este
%Insoluvel - Ja possui termos que nao podem coexirti no sudoki
%Soluvel - Pode ser resolvido
%Ja Solucionado Nao Possui Zero

%Arg X - O sudoku a ser Analizado
estado(X) :-
	insoluvel(X).

estado(X) :-
	append(X, Y),
	member(0, Y),
	write('Soluvel'),
	soluvel(X).

estado(X) :-
	append(X, Y),
	\+member(0, Y),
	write('Insoluvel'),
	soluvel(X).



%Encontra Vazia

%Recebe um sudoku e retorna a soluçao 
%da primeira celula vazia 

%Arg S - Sudoku
%Arg X - Coordenada X.
%Arg Y - Coordenada Y.
encontraVazia([S|_], X, Y):-
	member(0, S),
	encontraVazia(S, Y),
	X is 0.

encontraVazia([S|SY], X, Y):-
	\+member(0, S),
	encontraVazia(SY, X1, Y),
	X is X1 + 1.

encontraVazia([0|_], P):- P is 0.

encontraVazia([_|Y], P):-
	encontraVazia(Y, P1),
	 P is P1 + 1.




%Altera Valor

%Altera o valor de um termo cujo
%as coordendas forma passadas para 
%um termo que tambem foi passa como argumento


%Arg S - Sudoku
%Arg X - Coordenada X
%Arg Y - Coordenada Y
%Arg NV - Novo valor
%Arg R - Resposta do sudoku
alteraValor(S, X, Y, T, R):-
	addOnListOfLists(S, T, X, Y, R),
	write('Antes'),
	nl,
	imprime(S),
	nl,
	write('Depois'),
	nl,
	imprime(R).


%Insovel

%verifica se o sudoku nao possui uma caracterita que 
%fassa com que esse seja insoluvel

%Arg S - Sudoku
insoluvel(X):- \+soluvel(X), write('INSOLUVEL').

soluvel(X):-
	verificaTamanho(X, S),
	S1 is round(sqrt(S)),
	transpose(X, Y),
	vtColunas(S, X),
	vtColunas(S, Y),	
	transforma(S1, X, 0, R),
	vColunas(X),
	vColunas(Y),
	vColunas(R).