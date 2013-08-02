:- use_module(library(lists)).

%verificaTamanho

%Funcao que retorna o tamanho medio de 
%de uma matriz se for uma matriz quadrada 
%retorna o n

%Arg - X = A matriz que se deseja descobrir o tamanho
%Arg - Ta = O tamanho da matriz passada
verificaTamanho(X, Ta):-
	append(X, Y),
	length(Y, P),
	Ta is round(sqrt(P)).

%vColunas 

%Funcao que valida as colunas essa
%verifica se nao existe nenhum valor 
%repetido na coluna ignorando o zero

%Arg - X = uma matriz com os colunas a serem validadas
vColunas([]).
vColunas([X|Y]) :-
	vColunas(Y),
	delete(X, 0, K),
	nPossuiRepetidos(K).

%vtColunas

%Funçao que valida as colunas essa verifica
%o tamannho de cada coluna e confere com o valor
%passado 

%Arg - S = o tamanho que e esperado
%Arg - X = uma matriz com os colunas a serem validadas
vtColunas(_, []).
vtColunas(S, [X|Y]) :-
	vtColunas(S, Y),
	length(X, S1), S1 = S.

%controi Lisra

%Funcao responsalvel por contruir a lista de valores possiveis 
%para a execuçao do sudoku essa ira variar dependendo da ordem do 
%sudoku

%Arg - S = variavel que diz os quantos termos deve ter a lista
%Arg - L = a lista de retorno
%Arg - X = variavel auxiliar
constroiLista(0 ,L, _):- L = [].
constroiLista(S ,L, X):-
		A is S - 1,	A >= 0,	P is X + 1,
		constroiLista(A ,R, P),
		L = [X|R].

%Add On List of List

%Funcao que aciniona um elemto em uma matriz dado 
%as posiçoes i e J
%

%
%
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

%

%
%
%

%
%
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


%tranforma 

%transforma um matriz de uma representaçao 
%para outra representaçao cartesiana


%Arg I = pos I
%Arg J = pos J
%Arg I1 = nova poos I
%Arg J1 = nova  pos J
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

%Converte

%Converte de um notaçao de coordendas 
%em outro notaçao de coordenadas

%Arg S = tamnanho
%Arg I = pos I
%Arg J = pos J
%Arg I1 = nova poos I
%Arg J1 = nova  pos J
converte(S,I, J, I1, J1) :-
		I1 is div(I, S) + div(J, S)*S, 
		J1 is mod(I, S) + mod(J, S)*S.

%removeL1deL2

%remove os termo de um argumento que 
%sao repetidos no outro argumento


%Arg X = Lista1
%Arg Y = Lista2
%Arg Z = Lista 1 - Lista 2
removeL1deL2(_, [], []).
removeL1deL2([X], N, R):- delete(N, X, R).
removeL1deL2([X|Y], N, R):-
	removeL1deL2(Y, N, R2),
	delete(R2, X, R).

%nPossuiRepetidos

%funcao que verifica se nao existem repetidos em uma lista
%de lista verificando uma a uma


%Arg X = Matriz a ser validada
nPossuiRepetidos([]).
nPossuiRepetidos([X|Y]):- 
		\+member(X, Y), 
		nPossuiRepetidos(Y).

%imprime

%imprime uma matriz n por n com quebra de linha 

%Arg X = Matriz a ser impressa
imprime([]).
imprime([X|XS]):-
	write(X), nl, imprime(XS).