avo(X,Y) :- masculino(X), pais(X,Z),pais(Z,Y).

neto(X,Y) :- feminino(X), avo(Y,X).

pai(X,Y) :- masculino(X), pais(X,Y).

mae(X,Y) :- feminino(X),pais(X,Y).

ascendente(X,Y) :- pais(X,Y).

ascendente(X,Y) :- pais(X,Z),ascendente(Z,Y).

descendente(X,Y) :- ascendente(Y,X).

filha(X,Y) :- descendente(X,Y), feminino(X).

filho(X,Y) :- descedente(X,Y), masculino(X).

irmaos(X,Y) :- pai(Z,X), pai(Z,Y), X\=Y.

esposa(X,Y) :- conjuge(X,Y), feminino(X).

%tios-avós, primos, sobrinhos.
colaterais_quarto_grau(X,Y) :- decujus(Y).