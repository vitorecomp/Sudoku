:-include(sudokuMain).
:-include(testBase).
start :-
	test(1).

start(P) :- 
	matriz(P, X),    
	sudoKu(X, Y),
	imprime(Y).


test(1) :- 
	matriz(5, X),    
	sudoKu(X, Y),
	matriz(6, Y),  
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


