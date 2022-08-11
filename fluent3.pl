
:- multifile prolog_list_goal/1.


avo(X, Y) :-
    masculino(X),
    pais(X, Z),
    pais(Z, Y).

:- multifile prolog_clause_name/2.


meeiro(X, Y) :-
    (   existe_meeiro_universal(X, Y)
    ;   meeiro_parcial(X, Y)
    ;   meeiro_separacao_legal(X, Y),
        fail
    ).

pessoa(marcelo).
pessoa(marta).
pessoa(roberta).
pessoa(andreia).
pessoa(julia).
pessoa(maria).

:- dynamic expand_answer/2.
:- multifile expand_answer/2.


:- dynamic file_search_path/2.
:- multifile file_search_path/2.

file_search_path(library, '/private/var/folders/b9/kxc4lhwj4mqdbpkhp6lndrw40000gn/T/AppTranslocation/69B53A67-D844-49EA-8A6A-6A0161C15B05/d/SWI-Prolog.app/Contents/swipl/library/dialect/hprolog') :-
    hprolog:prolog_load_context(dialect, hprolog).
file_search_path(library, Dir) :-
    library_directory(Dir).
file_search_path(swi, A) :-
    system:current_prolog_flag(home, A).
file_search_path(swi, A) :-
    system:current_prolog_flag(shared_home, A).
file_search_path(library, app_config(lib)).
file_search_path(library, swi(library)).
file_search_path(library, swi(library/clp)).
file_search_path(foreign, swi(A)) :-
    system:
    (   \+ current_prolog_flag(windows, true),
        current_prolog_flag(arch, B),
        atom_concat('lib/', B, A)
    ).
file_search_path(foreign, swi(A)) :-
    system:
    (   (   current_prolog_flag(windows, true)
        ->  A=bin
        ;   A=lib
        )
    ).
file_search_path(path, A) :-
    system:
    (   getenv('PATH', B),
        (   current_prolog_flag(windows, true)
        ->  atomic_list_concat(C, ;, B)
        ;   atomic_list_concat(C, :, B)
        ),
        '$member'(A, C)
    ).
file_search_path(user_app_data, A) :-
    system:'$xdg_prolog_directory'(data, A).
file_search_path(common_app_data, A) :-
    system:'$xdg_prolog_directory'(common_data, A).
file_search_path(user_app_config, A) :-
    system:'$xdg_prolog_directory'(config, A).
file_search_path(common_app_config, A) :-
    system:'$xdg_prolog_directory'(common_config, A).
file_search_path(app_data, user_app_data('.')).
file_search_path(app_data, common_app_data('.')).
file_search_path(app_config, user_app_config('.')).
file_search_path(app_config, common_app_config('.')).
file_search_path(app_preferences, user_app_config('.')).
file_search_path(user_profile, app_preferences('.')).
file_search_path(autoload, swi(library)).
file_search_path(autoload, pce(prolog/lib)).
file_search_path(autoload, app_config(lib)).
file_search_path(pack, app_data(pack)).
file_search_path(library, PackLib) :-
    '$pack':pack_dir(_Name, prolog, PackLib).
file_search_path(foreign, PackLib) :-
    '$pack':pack_dir(_Name, foreign, PackLib).
file_search_path(pce, PceHome) :-
    link_xpce:
    (   current_prolog_flag(xpce, true),
        pcehome_(PceHome)
    ).
file_search_path(library, pce('prolog/lib')).
file_search_path(foreign, pce(ArchLib)) :-
    link_xpce:
    (   current_prolog_flag(arch, Arch),
        atom_concat('lib/', Arch, ArchLib)
    ).
file_search_path(chr, library(chr)).

existe_herdeiro_descendente(X, Y) :-
    descendente(X, Y),
    vivo(X),
    decujus(Y).

decujus(X) :-
    pessoa(X),
    morto(X),
    autor_heranca(X).

neto(X, Y) :-
    feminino(X),
    avo(Y, X).

:- dynamic prolog_exception_hook/4.
:- multifile prolog_exception_hook/4.

prolog_exception_hook(error(E, context(Ctx0, Msg)), error(E, context(prolog_stack(Stack), Msg)), Fr, GuardSpec) :-
    prolog_stack:
    (   current_prolog_flag(backtrace, true),
        \+ is_stack(Ctx0, _Frames),
        (   atom(GuardSpec)
        ->  debug(backtrace,
                  'Got uncaught (guard = ~q) exception ~p (Ctx0=~p)',
                  [GuardSpec, E, Ctx0]),
            stack_guard(GuardSpec),
            Guard=GuardSpec
        ;   prolog_frame_attribute(GuardSpec,
                                   predicate_indicator,
                                   Guard),
            debug(backtrace,
                  'Got exception ~p (Ctx0=~p, Catcher=~p)',
                  [E, Ctx0, Guard]),
            stack_guard(Guard)
        ),
        (   current_prolog_flag(backtrace_depth, Depth)
        ->  Depth>0
        ;   Depth=20
        ),
        get_prolog_backtrace(Depth,
                             Stack0,
                             [frame(Fr), guard(Guard)]),
        debug(backtrace, 'Stack = ~p', [Stack0]),
        clean_stack(Stack0, Stack1),
        join_stacks(Ctx0, Stack1, Stack)
    ).

:- dynamic prolog_load_file/2.
:- multifile prolog_load_file/2.


pais(marcelo, roberta).
pais(marcelo, andreia).
pais(marta, roberta).
pais(marta, andreia).
pais(andreia, julia).
pais(andreia, maria).
pais(joao, marcelo).

:- dynamic message_hook/3.
:- multifile message_hook/3.

message_hook(trace_mode(OnOff), _, _) :-
    chr:
    (   (   OnOff==on
        ->  chr_trace
        ;   chr_notrace
        ),
        fail
    ).

herdeiro_colateral(X, Y) :-
    \+ existe_herdeiro_ascendente(X, Y),
    \+ existe_herdeiro_conjunge(X, Y),
    \+ existe_herdeiro_descendente(X, Y),
    \+ meeiro(X, Y).

:- dynamic expand_query/4.
:- multifile expand_query/4.


herdeiro_ascendente(X, Y) :-
    \+ existe_herdeiro_descendente(X, Y),
    ascendente(X, Y),
    vivo(X),
    decujus(Y),
    write(X),
    write(' E herdeiro(a) de '),
    write(Y),
    write(' Na falta de descendentes, sao chamados a sucessao os ascendentes, em concorrancia com o conjuge sobrevivente. Base Legal: Art 1.836').

irmaos(X, Y) :-
    pai(Z, X),
    pai(Z, Y),
    X\=Y.

vocacao_hereditaria(X, Y) :-
    (   nl,
        write('Sao chamados a partilha dessa sucessao: ')
    ;   nl,
        nl,
        meeiro(X, Y)
    ;   nl,
        herdeiros(X, Y)
    ;   nl
    ).

comunhao_separacao_legal(S, S).

existe_herdeiro_conjunge(X, Y) :-
    conjuge(X, Y),
    vivo(X),
    decujus(Y).

morto(marcelo).
morto(andreia).

herdeiro_conjuge_separacao_convencional(X, Y) :-
    conjuge(X, Y),
    vivo(X),
    decujus(Y),
    comunhao_separacao_convencional(X, Y),
    write(X),
    write(' e herdeiro(a) de '),
    write(Y),
    write(' se houver descendentes o conjuge concorrera com estes em iguais condicoes, se houver ascedentes mesma regra aplicada, se nao houver nem descendentes nem ascendentes, o conjuge herdara na integralidade os bens.').

filha(X, Y) :-
    descendente(X, Y),
    feminino(X).

:- dynamic resource/3.
:- multifile resource/3.


herdeiros(X, Y) :-
    (   herdeiro_descendente(X, Y)
    ;   \+ existe_meeiro_universal(X, Y),
        (   herdeiro_conjuge_comunhao_parcial(X, Y)
        ;   herdeiro_conjuge_separacao_convencional(X, Y)
        )
    ;   herdeiro_ascendente(X, Y)
    ;   herdeiro_descendente_estirpe(X, Y)
    ;   herdeiro_colateral(X, Y)
    ).

:- multifile prolog_predicate_name/2.


existe_herdeiro_ascendente(X, Y) :-
    \+ existe_herdeiro_descendente(X, Y),
    ascendente(X, Y),
    vivo(X),
    decujus(Y).

person([caio, andre, marcos]).

herdeiro_conjuge_comunhao_parcial(X, Y) :-
    conjuge(X, Y),
    vivo(X),
    decujus(Y),
    comunhao_parcial(X, Y),
    write(X),
    write(' e herdeiro(a) de '),
    write(Y),
    write(' o conjuge herdeiro concorrera com os demais herdeiros descedentes em iguais condicoes nos bens particulares do de cujus, se houver ascedentes mesma regra aplicada, se nao houver nem descendentes nem ascendentes, o conjuge herdara na integralidade os bens.').

:- dynamic portray/1.
:- multifile portray/1.


filho(X, Y) :-
    descedente(X, Y),
    masculino(X).

ascendente(X, Y) :-
    pais(X, Y).
ascendente(X, Y) :-
    pais(X, Z),
    ascendente(Z, Y).

:- dynamic resource/2.
:- multifile resource/2.


meeiro_universal(X, Y) :-
    conjuge(X, Y),
    vivo(X),
    decujus(Y),
    comunhao_universal(X, Y),
    (   \+ comunhao_parcial(X, Y)
    ;   \+ comunhao_separacao_legal(X, Y)
    ),
    write(' e meeiro dos bens de '),
    write(Y),
    write(', o meeiro(a) como regra fica com 50% do patrimonio do autor da Heranca devido ao regime de bens definido na constancia do casamento.').

comunhao_parcial(s, x).

feminino(marta).
feminino(roberta).
feminino(andreia).
feminino(julia).
feminino(maria).

comoriencia(X, Y) :-
    descendente(X, Y),
    morto(X),
    morte_mesmo_momento(X, Y),
    write('Se considerados simultaneamente mortos entao nao herdam enter si e nao direito de representacao').

:- multifile message_property/2.


:- dynamic goal_expansion/2.
:- multifile goal_expansion/2.

goal_expansion('chr get_mutable'(Val, Var), Var=mutable(Val)).
goal_expansion('chr update_mutable'(Val, Var), setarg(1, Var, Val)).
goal_expansion('chr create_mutable'(Val, Var), Var=mutable(Val)).
goal_expansion('chr default_store'(X), nb_getval(chr_global, X)).
goal_expansion(forall(Element, List, Test), GoalOut) :-
    chr_find:
    (   nonvar(Test),
        Test=..[Functor, Arg],
        Arg==Element,
        GoalOut=once(maplist(Functor, List))
    ).
goal_expansion(arg1(Term, Index, Arg), arg(Index, Term, Arg)).
goal_expansion(wrap_in_functor(Functor, In, Out), Goal) :-
    chr_compiler_utility:
    (   (   atom(Functor),
            var(Out)
        ->  Out=..[Functor, In],
            Goal=true
        ;   Goal=(Out=..[Functor, In])
        )
    ).

descendente(X, Y) :-
    ascendente(Y, X).

flux_version(3.1).

comunhao_separacao_convencional(S, S).

meeiro_separacao_legal(X, Y) :-
    conjuge(X, Y),
    vivo(X),
    decujus(Y),
    comunhao_separacao_legal(X, Y),
    \+ comunhao_universal(X, Y),
    \+ comunhao_parcial(X, Y),
    write(X),
    write(' e meeiro(a) dos bens adquiridos após o casamento, desde que esses bens tenham sido adquiridos de forma onerosa por ambos e NAO herda em concorrencia com os demais herdeiros nos bens adquiridos pelo decujus antes do casamento. Base legal: Sumula 377 do STF e art. 1829 e 1640 do CC'),
    write(Y).

patrimonio(marcelo, 500).

:- dynamic library_directory/1.
:- multifile library_directory/1.


herdeiro_descendente(X, Y) :-
    descendente(X, Y),
    vivo(X),
    decujus(Y),
    write(X),
    write(' e herdeiro(a) de '),
    write(Y).

pai(X, Y) :-
    masculino(X),
    pais(X, Y).

:- dynamic prolog_file_type/2.
:- multifile prolog_file_type/2.

prolog_file_type(pl, prolog).
prolog_file_type(prolog, prolog).
prolog_file_type(qlf, prolog).
prolog_file_type(qlf, qlf).
prolog_file_type(A, executable) :-
    system:current_prolog_flag(shared_object_extension, A).
prolog_file_type(dylib, executable) :-
    system:current_prolog_flag(apple, true).

:- dynamic term_expansion/4.
:- multifile term_expansion/4.


meeiro_parcial(X, Y) :-
    conjuge(X, Y),
    vivo(X),
    decujus(Y),
    comunhao_parcial(X, Y),
    \+ comunhao_separacao_legal(X, Y),
    \+ comunhao_universal(X, Y),
    write(X),
    write(' e meeiro(a) dos bens adquiridos após o casamento e evetualmente herda em concorrencia com os demais herdeiros nos bens adquiridos pelo decujus antes do casamento'),
    write(Y).

conjuge(marta, marcelo).

vivo(marta).
vivo(roberta).
vivo(julia).
vivo(maria).
vivo(joao).

herdeiro_pre_morto(X, Y) :-
    descendente(X, Y),
    morto(X),
    decujus(Y).

autor_heranca(marcelo).

esposa(X, Y) :-
    conjuge(X, Y),
    feminino(X).

mae(X, Y) :-
    feminino(X),
    pais(X, Y).

regime_comunhao([universal, parcial, separacao_convencional, separacao_legal]).

:- dynamic goal_expansion/4.
:- multifile goal_expansion/4.


comunhao_universal(marta, marcelo).

:- thread_local thread_message_hook/3.
:- dynamic thread_message_hook/3.
:- volatile thread_message_hook/3.


existe_meeiro_universal(X, Y) :-
    (   conjuge(X, Y),
        vivo(X),
        decujus(Y),
        comunhao_universal(X, Y)
    ;   write('tituto de meacao')
    ).

masculino(marcelo).

herdeiro_descendente_estirpe(X, Y) :-
    descendente(X, Y),
    vivo(X),
    herdeiro_pre_morto(Y, _),
    write(X),
    write(' herda por estirpe a parte que cabia a '),
    write(Y).

:- dynamic exception/3.
:- multifile exception/3.

exception(undefined_global_variable, Name, retry) :-
    chr_runtime:
    (   chr_runtime_global_variable(Name),
        chr_init
    ).
exception(undefined_global_variable, Name, retry) :-
    chr_runtime:
    (   chr_runtime_debug_global_variable(Name),
        chr_debug_init
    ).
exception(undefined_global_variable, A, retry) :-
    guard_entailment:
    (   '$chr_prolog_global_variable'(A),
        '$chr_initialization'
    ).
exception(undefined_global_variable, A, retry) :-
    chr_translate:
    (   '$chr_prolog_global_variable'(A),
        '$chr_initialization'
    ).

:- dynamic term_expansion/2.
:- multifile term_expansion/2.


colaterais_quarto_grau(X, Y) :-
    decujus(Y).
