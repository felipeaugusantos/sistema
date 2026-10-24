{Cash Management}
{Folha de Pagamento}
{Layout de Troca de Arquivos}
{CNAB 240 Posições}
{YLEC_2402 V11/2018}
{Baseado no Lay_out CNAB Febraban v8.9}
{MT- REQ:200368}

unit untTFolhaPagamentoSantanderContasPagar;

interface

uses Classes, SysUtils, Controls, ComCtrls, DB, UniClientDataSet, Uni,
     StrUtils, Math, untFuncoesSimples, Variants,untTypesSistema,
     untFuncAutban;

Type
  TFolhaPagamentoSantanderContasPagar = Class
  private
    LIndLot : Integer;
    LCodSeq : Integer;
    LVlrTot : Double;
    LDadosRemessa : TDadosRemessaContasPagar;
    LGerouRemessa : Boolean;
    function HeaderDeLote(Var ATextFile : TextFile): Boolean;
    function SegmentoA(Var ATextFile : TextFile): Boolean;
    function SegmentoB(Var ATextFile : TextFile): Boolean;
    function TraillerDeLote(Var ATextFile : TextFile): Boolean;
    function RetornaTextoFormatado(ATexto:String): String;
  public
    Constructor Create(ADadosRemessa : TDadosRemessaContasPagar); Reintroduce;
    function GerarRemessaFolhaDePagamentoFuncionario(Var ATextFile : TextFile): Boolean;
    function GetIdentificacaoLote: Integer;
    function GetTotalTransacao: Integer;
    function GetTotalDeLotes: Integer;
  End;

implementation

{ TFolhaPagamentoSantanderContasPagar }

constructor TFolhaPagamentoSantanderContasPagar.Create(ADadosRemessa : TDadosRemessaContasPagar);
begin
  LDadosRemessa := ADadosRemessa;
  LGerouRemessa := False;
  LIndLot := 0;
  LCodSeq := 0;
end;

function TFolhaPagamentoSantanderContasPagar.GerarRemessaFolhaDePagamentoFuncionario(Var ATextFile : TextFile) : Boolean;
begin
  Try
    Result := True;

    LDadosRemessa.LQryRemessa.Filtered := False;
    LDadosRemessa.LQryRemessa.Filter   := 'CODFUN IS NOT NULL';
    LDadosRemessa.LQryRemessa.Filtered := True;

    If Not LDadosRemessa.LQryRemessa.IsEmpty Then
    Begin
      If Not HeaderDeLote(ATextFile) Then Exit(False);
      If Not SegmentoA(ATextFile) Then Exit(False);
      If Not TraillerDeLote(ATextFile) Then Exit(False);
      LGerouRemessa := True;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
		  pMensagensErro(E.Message,  '[untExpArqRemSantanderCta.btnGerarClick]','Ocorreu um erro durante a exportação do arquivo. Para tentar novamente por favor fechar o sistema.');
    End;
  End;

end;

function TFolhaPagamentoSantanderContasPagar.GetIdentificacaoLote: Integer;
begin
  Inc(LIndLot);
  Result := LIndLot;
end;

function TFolhaPagamentoSantanderContasPagar.GetTotalDeLotes: Integer;
begin
  If LGerouRemessa Then Result := 1
  Else Result := 0;
end;

function TFolhaPagamentoSantanderContasPagar.GetTotalTransacao: Integer;
begin
  Result := LCodSeq;
end;

{REGISTRO HEADER DE LOTE – TIPO DE REGISTRO = 1}
function TFolhaPagamentoSantanderContasPagar.HeaderDeLote(Var ATextFile : TextFile): Boolean;
  Var
    LHeaderDeLote : String;
begin
  Try
    Result := True;
    LIndLot := 1;
    LHeaderDeLote :=  fPadR   ('033'                                     , 003)      + //001 - 003
                      fPadR   (fStrZero(LIndLot,4)                       , 004)      + //004 - 007
                      fPadR   ('1'                                       , 001)      + //008 - 008
                      fPadL   ('C'                                       , 001)      + //009 - 009
                      fPadR   ('30'                                      , 002)      + //010 - 011
                      fPadR   ('01'                                      , 002)      + //012 - 013
                      fPadR   ('031'                                     , 003)      + //014 - 016
                      fPadL   (' '                                       , 001)      + //017 - 017
                      fPadR   (IntToStr(LDadosRemessa.LTipIns)           , 001)      + //018 - 018
                      fPadL   (LDadosRemessa.LCgcEmp                     , 014, '0') + //019 - 032
                      fPadR   (LDadosRemessa.LCodCon                     , 020)      + //033 - 052
                      fPadL   (LDadosRemessa.LCodAge                     , 005, '0') + //053 - 057
                      fPadR   (' '                                       , 001)      + //058 - 058
                      fPadL   (LDadosRemessa.LConCor                     , 012, '0') + //059 - 070
                      fPadR   (LDadosRemessa.LDigCnt                     , 001)      + //071 - 071
                      fPadL   (' '                                       , 001, '0') + //072 - 072
                      fPadR   (LDadosRemessa.LNomEmp                     , 030, ' ') + //073 - 102
                      fPadL   (' '                                       , 040)      + //103 - 142
                      fPadR   (LDadosRemessa.LEndEmp                     , 030, ' ') + //143 - 172
                      fPadL   (LDadosRemessa.LNumEmp                     , 005, '0') + //173 - 177
                      fPadR   (LDadosRemessa.LComEmp                     , 015, ' ') + //178 - 192
                      fPadR   (LDadosRemessa.LCidEmp                     , 020, ' ') + //193 - 212
                      fPadL   (LDadosRemessa.LCepEmp                     , 008, '0') + //213 - 220
                      fPadR   (LDadosRemessa.LEstEmp                     , 002, ' ') + //221 - 222
                      fPadR   (' '                                       , 008)      + //223 - 230
                      fPadL   (' '                                       , 010);       //231 - 240

    {****************************}

    {* ESCREVE O HEADER DO LOTE *}
    {*************************MT*}
    Writeln(ATextFile,RetornaTextoFormatado(LHeaderDeLote));

  Except
    On E: Exception Do
    Begin
      Result := False;
		  pMensagensErro(E.Message,  '[untExpArqRemSantanderCta.btnGerarClick]','Ocorreu um erro durante a exportação do arquivo. Para tentar novamente por favor fechar o sistema.');
    End;
  End;
end;

function TFolhaPagamentoSantanderContasPagar.RetornaTextoFormatado(
  ATexto: String): String;
begin
  Result := ATexto;

  If Not LDadosRemessa.FEnviarCaracterEspecial Then
    Result := untFuncAutban.fRetirarCaracteresEspeciais(Result);
end;

{REGISTRO DE DETALHE – TIPO DE REGISTRO = 3 (SEGMENTO A)}
function TFolhaPagamentoSantanderContasPagar.SegmentoA(var ATextFile: TextFile) : Boolean;
  Var
    LTransacao : String;
    LDtaVen    : String;
    LDtaEmi    : String;
    LDtaPag    : String;
begin
  Try
    Result := True;
    LCodSeq := 0;
    LDadosRemessa.LQryRemessa.First;

    While Not LDadosRemessa.LQryRemessa.Eof Do
    Begin
      LDtaVen := FormatDateTime('dd',LDadosRemessa.LQryRemessa.FieldByName('PGI_DTAVEN').AsDateTime) +
                 FormatDateTime('mm',LDadosRemessa.LQryRemessa.FieldByName('PGI_DTAVEN').AsDateTime) +
                 FormatDateTime('yyyy',LDadosRemessa.LQryRemessa.FieldByName('PGI_DTAVEN').AsDateTime);

      LDtaEmi := FormatDateTime('dd',LDadosRemessa.LQryRemessa.FieldByName('PGI_DTACAD').AsDateTime) +
                 FormatDateTime('mm',LDadosRemessa.LQryRemessa.FieldByName('PGI_DTACAD').AsDateTime) +
                 FormatDateTime('yyyy',LDadosRemessa.LQryRemessa.FieldByName('PGI_DTACAD').AsDateTime);

      LDtaPag := FormatDateTime('dd',LDadosRemessa.LQryRemessa.FieldByName('PGI_DTAPAG').AsDateTime) +
                 FormatDateTime('mm',LDadosRemessa.LQryRemessa.FieldByName('PGI_DTAPAG').AsDateTime) +
                 FormatDateTime('yyyy',LDadosRemessa.LQryRemessa.FieldByName('PGI_DTAPAG').AsDateTime);

      LVlrTot := LVlrTot + LDadosRemessa.LQryRemessa.FieldByName('PGI_VALPAG').AsFloat ;

      Inc(LCodSeq);

      LTransacao := '';
      LTransacao := fPadR('033'                                                            , 03)      + //001 - 003 - CÓD. DO BANCO
                    fPadR(fStrZero(LIndLot,4)                                              , 04)      + //004 - 007 - LOTE DE SERVIÇO
                    fPadR('3'                                                              , 01)      + //008 - 008 - TIPO DE REGISTRO
                    fPadL(IntToStr(LCodSeq)                                                , 05, '0') + //009 - 013 - Nº SEQUENCIAL DO REGISTRO NO LOTE
                    fPadR('A'                                                              , 01)      + //014 - 014 - CÓD. DE SEGMENTO NO REG. DETALHE
                 fStrZero('0'                                                              , 01)      + //015 - 015 - TIPO DE MOVIMENTO
                 fStrZero('0'                                                              , 02)      + //016 - 017 - CÓD. DA INSTRUÇÃO P/ MOVIMENTO
                    fPadR(LDadosRemessa.LQryRemessa.FieldByName('CAMCEN').AsString         , 03, '0') + //018 - 020 - CÓD. DA CÂMARA CENTRALIZADORA
                    fPadR(LDadosRemessa.LQryRemessa.FieldByName('CODBCO').AsString         , 03, '0') + //021 - 023 - CÓD. DO BANCO DO FAVORECIDO
                    fPadL(LDadosRemessa.LQryRemessa.FieldByName('CODAGE').AsString         , 05, '0') + //024 - 028 - AG. MANTENEDORA DA CTA. DO FAVOR.
                    fPadL(' '                                                              , 01)      + //029 - 029 - COMPLEMENTO DE REGISTRO
                    fPadL(LDadosRemessa.LQryRemessa.FieldByName('NUMCTA').AsString         , 12, '0') + //030 - 041 - Nº DA CONTA CORRENTE
                    fPadL(' '                                                              , 01)      + //042 - 042 - COMPLEMENTO DE REGISTRO
                    fPadR(LDadosRemessa.LQryRemessa.FieldByName('DIGVER').AsString         , 01, ' ') + //043 - 043 - DÍGITO VERIFICADOR AG/CONTA
                    fPadR(LDadosRemessa.LQryRemessa.FieldByName('FOR_NOMFOR').AsString     , 30, ' ') + //044 - 073 - NOME DO FAVORECIDO
                    fPadL(LDadosRemessa.LQryRemessa.FieldByName('PGI_AUTOIN').AsString     , 20, ' ') + //074 - 093 - Nº DO DOCUMENTO ATRIBUIDO P/ EMPRESA
                    fPadR(LDtaPag                                                          , 08)      + //094 - 101 - DATA DO PAGAMENTO
                    fPadR('BRL'                                                            , 03)      + //102 - 104 - TIPO DA MOEDA
                 fStrZero('0'                                                              , 15)      + //105 - 119 - QUANTIDADE DA MOEDA
              fValNumForm(LDadosRemessa.LQryRemessa.FieldByName('PGI_VALPAG').AsFloat      , 15)      + //120 - 134 - VALOR DO PAGAMENTO
                    fPadL(' '                                                              , 20,' ')  + //135 - 154 - Nº DO DOCUM. ATRIBUIDO PELO BANCO
                    fPadR('0'                                                              , 08,'0')  + //155 - 162 - DATA REAL DA EFETIVAÇÃO DO PAGTO.
              fValNumForm(0                                                                , 15)      + //163 - 177 - VALOR REAL DA EFETIVAÇÃO DO PAGTO.
                    fPadL(' '                                                              , 40,' ')  + //178 - 217 - OUTRAS INFORMAÇÕES
                    fPadR('00'                                                             , 02)      + //218 - 219 - Finalidade do DOC, TED CIP e TED STR
                    fPadR(' '                                                              , 10,' ')  + //220 - 229 - Filler
                    fPadR('0'                                                              , 01)      + //230 - 230 - AVISO AO FAVORECIDO
                    fPadR(' '                                                              , 10,' ');   //231 - 240 - CÓDIGOS DAS OCORRÊNCIAS P/ RETORNO

      {**************************************************}
      {* ESCREVE O REGISTRO DETALHE DA TRANSACAO NO TXT *}
      {***********************************************MT*}
      Writeln(ATextFile,RetornaTextoFormatado(LTransacao));

      If Not SegmentoB(ATextFile) Then
        Result := False;

      LDadosRemessa.LQryRemessa.Next;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
		  pMensagensErro(E.Message,  '[untExpArqRemSantanderCta.btnGerarClick]','Ocorreu um erro durante a exportação do arquivo. Para tentar novamente por favor fechar o sistema.');
    End;
  End;

end;

{REGISTRO DE DETALHE – TIPO DE REGISTRO = 3 (SEGMENTO B)}
function TFolhaPagamentoSantanderContasPagar.SegmentoB(var ATextFile: TextFile): Boolean;
  Var
    LTransacao : String;
    LDtaVen    : String;
begin
  Try
    Result := True;
    LDtaVen := FormatDateTime('dd',LDadosRemessa.LQryRemessa.FieldByName('PGI_DTAVEN').AsDateTime) +
               FormatDateTime('mm',LDadosRemessa.LQryRemessa.FieldByName('PGI_DTAVEN').AsDateTime) +
               FormatDateTime('yyyy',LDadosRemessa.LQryRemessa.FieldByName('PGI_DTAVEN').AsDateTime);

    Inc(LCodSeq);
    LTransacao := '';
    LTransacao := fPadR      ('033'                                                        , 03)      + //001 - 003
                  fPadR      (fStrZero(LIndLot,4)                                          , 04)      + //004 - 007
                  fPadR      ('3'                                                          , 01)      + //008 - 008
                  fPadL      (IntToStr(LCodSeq)                                            , 05,'0')  + //009 - 013
                  fPadR      ('B'                                                          , 01)      + //014 - 014
                  fPadR      (' '                                                          , 03,' ')  + //015 - 017
                  fPadR      ('1'                                                          , 01)      + //018 - 018
                  fPadL      (LDadosRemessa.LQryRemessa.FieldByName('NUMINS').AsString     , 14,'0')  + //019 - 032
                  fPadR      (' '                                                          , 30,' ')  + //033 - 062
                  fStrZero   (0                                                            , 05)      + //063 - 067
                  fPadR      (' '                                                          , 15,' ')  + //068 - 082
                  fPadR      (' '                                                          , 15,' ')  + //083 - 097
                  fPadL      (' '                                                          , 20,' ')  + //098 - 117
                  fStrZero   ('0'                                                          , 08)      + //118 - 125
                  fPadR      (' '                                                          , 02,' ')  + //126 - 127
                  fStrZero   (LDtaVen                                                      , 08)      + //128 - 135
                  fValNumForm(LDadosRemessa.LQryRemessa.FieldByName('PGI_VALDUP').AsFloat  , 15)      + //136 - 150
                  fValNumForm(0                                                            , 15)      + //151 - 165
                  fValNumForm(0                                                            , 15)      + //166 - 180
                  fValNumForm(0                                                            , 15)      + //181 - 195
                  fValNumForm(0                                                            , 15)      + //196 - 210
                  fPadR      ('0'                                                          , 04,'0')  + //211 - 214
                  fPadR      (' '                                                          , 11,' ')  + //215 - 225
                  fStrZero   ('0'                                                          , 05)      + //226 - 230
                  fPadR      (' '                                                          , 10,' ');   //231 - 240


    {******************************}
    {* ESCREVE A TRANSACAO NO TXT *}
    {***************************MT*}
    Writeln(ATextFile,RetornaTextoFormatado(LTransacao));

  Except
    On E: Exception Do
    Begin
      Result := False;
		  pMensagensErro(E.Message,  '[untExpArqRemSantanderCta.btnGerarClick]','Ocorreu um erro durante a exportação do arquivo. Para tentar novamente por favor fechar o sistema.');
    End;
  End;
end;

{REGISTRO DE TRAILLER DE LOTE – TIPO DE REGISTRO = 5}
function TFolhaPagamentoSantanderContasPagar.TraillerDeLote(var ATextFile: TextFile): Boolean;
  Var
    LTraillerDeLote : String;
begin
  Try
    Result := True;
    Inc(LCodSeq);
    Inc(LCodSeq);
    LTraillerDeLote := fPadR      ('033'                  , 003)       + //001 - 003
                       fPadR      (fStrZero(LIndLot,4)    , 004)       + //004 - 007
                       fPadR      ('5'                    , 001)       + //008 - 008
                       fPadR      (' '                    , 009)       + //009 - 017
                       fPadL      (IntToStr(LCodSeq)      , 006, '0')  + //018 - 023
                       fValNumForm(LVlrTot                , 018)       + //024 - 041
                       fStrZero   ('0'                    , 018)       + //042 - 059
                       fStrZero   ('0'                    , 006)       + //060 - 065
                       fPadR      (' '                    , 165)       + //066 - 230
                       fPadR      (' '                    , 010,' ');    //231 - 240

    {************************************}
    {* ESCREVE O TRAILER DO LOTE NO TXT *}
    {*********************************MT*}
    Writeln(ATextFile,RetornaTextoFormatado(LTraillerDeLote));
  Except
    On E: Exception Do
    Begin
      Result := False;
		  pMensagensErro(E.Message,  '[untExpArqRemSantanderCta.btnGerarClick]','Ocorreu um erro durante a exportação do arquivo. Para tentar novamente por favor fechar o sistema.');
    End;
  End;
end;

end.
