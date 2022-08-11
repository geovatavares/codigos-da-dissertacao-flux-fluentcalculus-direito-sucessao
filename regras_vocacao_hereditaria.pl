decujus(X):- pessoa(X), morto(X), autor_heranca(X).

herdeiro_descendente(X,Y):- 
    descendente(X,Y), vivo(X), decujus(Y), write(X), write(' e herdeiro(a) de '), write(Y).

herdeiro_conjuge_separacao_convencional(X,Y):- 
    conjuge(X,Y), vivo(X), decujus(Y), comunhao_separacao_convencional(X,Y), write(X), write(' e herdeiro(a) de '), write(Y), write(' se houver descendentes o conjuge concorrera com estes em iguais condicoes, se houver ascedentes mesma regra aplicada, se nao houver nem descendentes nem ascendentes, o conjuge herdara na integralidade os bens.').

herdeiro_conjuge_comunhao_parcial(X,Y):- 
    (conjuge(X,Y), vivo(X), decujus(Y), comunhao_parcial(X,Y)), write(X), write(' e herdeiro(a) de '), write(Y), write(' o conjuge herdeiro concorrera com os demais herdeiros descedentes em iguais condicoes nos bens particulares do de cujus, se houver ascedentes mesma regra aplicada, se nao houver nem descendentes nem ascendentes, o conjuge herdara na integralidade os bens.').

existe_herdeiro_descendente(X,Y):- 
    descendente(X,Y), vivo(X), decujus(Y).

herdeiro_ascendente(X,Y):- 
    \+existe_herdeiro_descendente(X,Y), ascendente(X,Y), vivo(X), decujus(Y), write(X), write(' E herdeiro(a) de '), write(Y), write(' Na falta de descendentes, sao chamados a sucessao os ascendentes, em concorrancia com o conjuge sobrevivente. Base Legal: Art 1.836'). 

herdeiro_pre_morto(X,Y):- 
    descendente(X,Y), morto(X), decujus(Y).

herdeiro_descendente_estirpe(X,Y):- 
    descendente(X,Y), vivo(X), herdeiro_pre_morto(Y,_), write(X), write(' herda por estirpe a parte que cabia a '), write(Y).

comoriencia(X, Y):-
    descendente(X,Y), morto(X), morte_mesmo_momento(X,Y), write('Se considerados simultaneamente mortos entao nao herdam enter si e nao direito de representacao'). 

existe_herdeiro_ascendente(X,Y):- 
    \+existe_herdeiro_descendente(X,Y), ascendente(X,Y), vivo(X), decujus(Y).

existe_herdeiro_conjunge(X,Y):- 
    conjuge(X,Y), vivo(X), decujus(Y).

herdeiro_colateral(X,Y):- 
    \+existe_herdeiro_ascendente(X,Y), 
    \+existe_herdeiro_conjunge(X,Y), 
    \+existe_herdeiro_descendente(X,Y), 
    \+meeiro(X,Y). 

meeiro(X,Y):- 
    (existe_meeiro_universal(X,Y)); 
    (meeiro_parcial(X,Y)); 
    (meeiro_separacao_legal(X,Y)), fail.

existe_meeiro_universal(X,Y):- 
    (conjuge(X,Y), vivo(X), decujus(Y), comunhao_universal(X,Y); write('tituto de meacao')).

meeiro_universal(X,Y):- 
    conjuge(X,Y), vivo(X), decujus(Y), comunhao_universal(X,Y), 
    (\+comunhao_parcial(X,Y); 
    \+comunhao_separacao_legal(X,Y)),  
    write(' e meeiro dos bens de '), write(Y), write(', o meeiro(a) como regra fica com 50% do patrimonio do autor da Heranca devido ao regime de bens definido na constancia do casamento.').

meeiro_parcial(X,Y):- 
    conjuge(X,Y), vivo(X), decujus(Y), comunhao_parcial(X,Y), \+comunhao_separacao_legal(X,Y), \+comunhao_universal(X,Y), write(X), write(' e meeiro(a) dos bens adquiridos após o casamento e evetualmente herda em concorrencia com os demais herdeiros nos bens adquiridos pelo decujus antes do casamento'), write(Y).

meeiro_separacao_legal(X,Y):- 
    conjuge(X,Y), vivo(X), decujus(Y), comunhao_separacao_legal(X,Y), \+comunhao_universal(X,Y), \+comunhao_parcial(X,Y), write(X), write(' e meeiro(a) dos bens adquiridos após o casamento, desde que esses bens tenham sido adquiridos de forma onerosa por ambos e NAO herda em concorrencia com os demais herdeiros nos bens adquiridos pelo decujus antes do casamento. Base legal: Sumula 377 do STF e art. 1829 e 1640 do CC'), write(Y).

herdeiros(X,Y):- 
    (herdeiro_descendente(X,Y); (\+existe_meeiro_universal(X,Y), (herdeiro_conjuge_comunhao_parcial(X,Y); herdeiro_conjuge_separacao_convencional(X,Y))); (herdeiro_ascendente(X,Y)); (herdeiro_descendente_estirpe(X,Y)); (herdeiro_colateral(X,Y))).

vocacao_hereditaria(X, Y):- 
    (nl, write('Sao chamados a partilha dessa sucessao: '); nl, nl, 
    meeiro(X,Y); nl, 
    herdeiros(X,Y); nl).

