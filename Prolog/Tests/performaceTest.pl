:- include(sudoku).
:- include(matrizes).


start :-
	test(1).


test(1) :- 
	matriz(5, X),
%    matriz(2, Y),  
	sudoKu(X, Y),
	imprime(Y).

test(2) :- 
	matriz(3, X),
    matriz(4, Y),  
	sudoKu(X, Y),
	imprime(Y).

test(2) :- 
	matriz(5, X),
    matriz(6, Y),  
	sudoKu(X, Y),
	imprime(Y).

imprime([X|XS]):-
	write(X), nl, imprime(XS).
