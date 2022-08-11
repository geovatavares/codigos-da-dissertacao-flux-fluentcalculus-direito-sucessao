autor_heranca(marcelo).

patrimonio(marcelo, 500).

pessoa(marcelo).
pessoa(marta).
pessoa(roberta).
pessoa(andreia).
pessoa(julia).
pessoa(maria).

person([caio, andre, marcos]).

morto(marcelo).
morto(andreia).
vivo(marta).
vivo(roberta).
vivo(julia).
vivo(maria).
vivo(joao).

masculino(marcelo).
feminino(marta).
feminino(roberta).
feminino(andreia).
feminino(julia).
feminino(maria).

pais(marcelo, roberta).
pais(marcelo, andreia).
pais(marta, roberta).
pais(marta, andreia).
pais(andreia, julia).
pais(andreia, maria).
pais(joao, marcelo).

conjuge(marta, marcelo).

comunhao_universal(marta, marcelo).
comunhao_parcial(s,x).
comunhao_separacao_convencional(S,S).
comunhao_separacao_legal(S,S).

regime_comunhao([universal, parcial, separacao_convencional, separacao_legal]).
