%VITOR DE ARAUJO VIEIRA 11/0067151
%MATHEUS ROSENDO PEDREIRA
%PAULO

:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- include(funcoesBase).


%sudoKu Final

%Neste Modulo sao feitas as Validaçoes Basicas do
%sistema como tamanho das linhas e de colunas e neste
%tambem e montado a lista com os valores que cada termo
%pode valer

%Arg X - Matriz a Ser Resulvida 0 para blocos Vazios
%Arg Y - Resposta do Sudoku.

sudoKu(X, R) :-
	verificaTamanho(X, S),
	validaColunas(X, S),
	validaLinhas(X, S),
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
	prencheN(X, P, T),
	verificaLinhas(P),
    verificaBlocos(S, P),
	verificaColunas(P).

%prencheN
%sudoKu Sem Validações

%
%
%
%

%Arg S - Ordem do Sudoku
%Arg T - Lista com os Elemetos Possiveis para cada regiao.
%Arg X - Matriz a Ser Resulvida 0 para blocos Vazios
%Arg Y - Resposta do Sudoku.

prencheN(L, P, N) :- prencheN(L, 0, N, L, _, P).
prencheN(NM, _, _, [] ,T,NM) :- transpose(NM, T).
prencheN(NM, I, N, [X|Y],T, R) :-
    I1 is I+1,
	prencheN(NM, I1, N, Y, TR, RI),
	removeL1deL2(X, N, LnPrechidos),
	prenche(TR, X, LnPrechidos, K),
	addOnList(RI, K, I, R),
	transpose(R, T).

%sudoKu Sem Validações

%
%
%
%

%Arg S - Ordem do Sudoku
%Arg T - Lista com os Elemetos Possiveis para cada regiao.
%Arg X - Matriz a Ser Resulvida 0 para blocos Vazios
%Arg Y - Resposta do Sudoku.
prenche(_, [], _, []).
prenche([TX|TY],[X|Y], T, [K|P]) :- 
		((X = 0 , member(K, T),\+member(K, TX), delete(T,K,T1) ,prenche(TY, Y, T1, P));
		( X \= 0 , K = X, prenche(TY, Y, T, P))).


