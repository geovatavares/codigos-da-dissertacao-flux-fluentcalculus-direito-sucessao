poss(gerar_decujus(X),Z) :- 
     holds(morto(X), Z), holds(autor_heranca(X), Z).
state_update(Z1, gerar_decujus(X), Z2) :- 
     update(Z1, [], [decujus(X)], Z2).

Z0 = [morto(marcelo), autor_heranca(marcelo)].
