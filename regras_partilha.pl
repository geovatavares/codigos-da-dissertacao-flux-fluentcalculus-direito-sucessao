partilha(X/Y):- patrimonio(X), qnt_herdeiro(Y).

partilha(X/Y):- quinhao is patrimonio(X), qnt_herdeiro(Y).

partilha(patrimonio,X):- X is patrimonio / qnt_herdeiro.


 :- herdeiro_descedente(true), herdeiro
      quinhao_herdeiro_filho(X):- herdeiro_descedente(X), partilha(Y).

inventario(X):- patrimonio(X).