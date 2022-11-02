:-  dynamic paciente/3.

paciente:- carrega('paciente.bd'),
                      format('~n*** Paciente ***~n~n'),
                      repeat,
                      nome(Nome),
                      temperatura(Nome),
                      freq_card(Nome),
                      freq_resp(Nome),
                      pa_sistolica(Nome),
                      saturacao(Nome),
                      dispineia(Nome),
                      idade(Nome),
                      comorbidades(Nome),
                      responde(Nome),
                      salva(paciente,'paciente.bd'),
                      continua(Resposta),
                      Resposta = n,
                      !.



carrega(Arquivo) :-
   exists_file(Arquivo),
   consult(Arquivo);
   true.

nome(Nome) :-
  format('~nQual o nome do paciente? '),
  gets(Nome).

temperatura(Nome) :-
   format('~nQual a temperatura de ~w? ', [Nome]),
   gets(Temp),
   asserta(paciente(Nome, temperatura, Temp)).

freq_card(Nome):-
   format('~nQual a frequencia cardiaca de ~w? ', [Nome]),
  gets(FreCard),
  asserta(paciente(Nome, freq_card, FreCard)).

freq_resp(Nome):-
  format('~nQual a frequencia respiratoria de ~w? ', [Nome]),
  gets(FreqResp),
  asserta(paciente(Nome, freq_resp, FreqResp)).

pa_sistolica(Nome):-
  format('~nQual a PA sistolica de ~w? ', [Nome]),
  gets(PreSis),
  asserta(paciente(Nome, pa_sistolica, PreSis)).

saturacao(Nome):-
   format('~nQual a saturação de ~w? ', [Nome]),
   gets(Sa02),
   asserta(paciente(Nome, saturacao, Sa02)).

dispineia(Nome):-
   format('~nPaciente ~w tem dispinéia?(sim ou nao): ', [Nome]),
   gets(Dispi),
   asserta(paciente(Nome, dispineia, Dispi)).

idade(Nome):-
   format('~nQual a idade de ~w? ', [Nome]),
   gets(Idade),
   asserta(paciente(Nome, idade, Idade)).

comorbidades(Nome):-
   format('~n ~w Possui quantas comorbidades ?', [Nome]),
   gets(Comorbi),
   asserta(paciente(Nome, comorbidades, Comorbi)).

salva(P,A) :-
    tell(A),
    listing(P),
    told.

gets(String) :-
    read_line_to_codes(user_input,Char),
    name(String,Char).

responde(Nome) :-
    condicao(Nome, Char),
    !,
    format('A condicao de ~w e ~w.~n',[Nome,Char]).

condicao(Pct, muito_grave) :-
    paciente(Pct,freq_resp,FreqResp), FreqResp > 30;
    paciente(Pct,pa_sistolica,PreSis), PreSis < 90;
    paciente(Pct,saturacao,Sa02), Sa02 < 95;
    paciente(Pct,dispineia,Dispi), Dispi = "sim".

condicao(Pct, grave) :-
    paciente(Pct,temperatura,Temp), Temp > 39;
    paciente(Pct,pa_sistolica,PreSis), PreSis >= 90, PreSis =< 100;
    paciente(Pct,idade,Idade), Idade >= 80;
    paciente(Pct,comorbidade,Comorbi), Comorbi >= 2.

condicao(Pct, medio) :-
    paciente(Pct,temperatura,Temp), (Temp < 35; (Temp > 37, Temp =< 39));
    paciente(Pct,freq_Cardiaca,FreCard), FreCard >= 100;
    paciente(Pct,freq_resp,FreqResq), FreqResq >= 19, FreqResq =< 30;
    paciente(Pct,idade,Idade), Idade >= 60, Idade =< 79;
    paciente(Pct,comorbidade,Comorbi), Comorbi = 1.

condicao(Pct, leve) :-
    paciente(Pct,temperatura,Temp), Temp >= 35, Temp =< 37;
    paciente(Pct,freq_Cardiaca,FreCard), FreCard < 100;
    paciente(Pct,freq_resp,FreqResp), FreqResp =< 18;
    paciente(Pct,pa_sistolica,PreSis), PreSis > 100;
    paciente(Pct,saturacao,Sa02), Sa02 >= 95;
    paciente(Pct,dispineia,Dispi), Dispi = "nao";
    paciente(Pct,idade,Idade), Idade < 60;
    paciente(Pct,comorbidade,Comorbi), Comorbi = 0.

continua(Resposta) :-
    format('~nContinua? [s/n] '),
    get_char(Resposta),
    get_char('\n').













