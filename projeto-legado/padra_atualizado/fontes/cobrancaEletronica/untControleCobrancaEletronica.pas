unit untControleCobrancaEletronica;

interface

uses
  System.Classes, CobrancaEletronica.Lib.Types, Data.DB;

type
  TControladorCobrancaEletronica = class
  private
    function fGetAutIncrem(const ANumDoc, AEspDoc, ACodEmp: String): String;
    function fGetFilterTypesByApi(const ATipoCobrancaEletronica: TTipoCobrancaEletronica;
      const AApenasComTransacaoOuPagamento: Boolean): String;
    procedure pAtualizaStatusCobrancaEletronica(const ANumDoc, AEspDoc,
      ACodEmp, AStatus: String; const ATipoCobranca: TTipoCobrancaEletronica);
    procedure pRemoveBaixaComCartaoCredito(const ANumDoc, AEspDoc,
      ACodEmp: String; const ATipoCobranca: TTipoCobrancaEletronica);
    procedure pEstornaAdiantamento(const ANumDoc, AEspDoc, ACodEmp, ACodCli: String;
      const AValAdt: Double; const ASeqCon: Integer);

  public
    class function New: TControladorCobrancaEletronica;

    function fExisteCobrancaEletronica(const ANumDoc, AEspDoc, ACodEmp: String;
      const ATipoCobranca: TTipoCobrancaEletronica; out ARetorno: Boolean;
      const AApenasComTransacaoOuPagamento: Boolean): TControladorCobrancaEletronica;

    function fExisteAdiantamentoClienteCobrancaEletronica(const ANumDoc,
      AEspDoc, ACodEmp: String; const ATipoCobranca: TTipoCobrancaEletronica;
      out ARetorno: Boolean): TControladorCobrancaEletronica;

    function fCancelaLinkBaixaPedidoNaoEntregue(const ANumDoc, AEspDoc,
      ACodEmp: String;
      const ATipoCobranca: TTipoCobrancaEletronica): TControladorCobrancaEletronica;
    function fCancelaLinkPagamento(const ANumDoc, AEspDoc, ACodEmp: String;
      const ATipoCobranca: TTipoCobrancaEletronica): TControladorCobrancaEletronica;
    function fCriarNovoLinkPagamento(const ANumDoc, AEspDoc, ACodEmp: String;
      const ATipoCobranca: TTipoCobrancaEletronica): TControladorCobrancaEletronica;
    function fGravarLogCobrancaEletronica(const ANumDoc, AEspDoc, ACodEmp: String;
      const ATipoCobranca: TTipoCobrancaEletronica;
      const AObservacao: String): TControladorCobrancaEletronica;

    function fValidaCadastroCliente(const ACodCli, ACodCnd: String;
      out ARetorno: Boolean; const ATipoCobranca: TTipoCobrancaEletronica): TControladorCobrancaEletronica;

    function fProcessaEstornoAdiantamento(const ANumDoc, AEspDoc, ACodEmp: String;
      const ATipoCobranca: TTipoCobrancaEletronica): TControladorCobrancaEletronica;

  end;

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  untFuncoesSimples, Uni,
{$ENDIF LINUX}
  System.SysUtils, System.StrUtils, untTypesSistema,
  untAdiantamentoClienteGenerico;

{ TControladorCobrancaEletronica }

function TControladorCobrancaEletronica.fCancelaLinkBaixaPedidoNaoEntregue(
  const ANumDoc, AEspDoc, ACodEmp: String;
  const ATipoCobranca: TTipoCobrancaEletronica): TControladorCobrancaEletronica;
begin
  Result := Self;

  pAtualizaStatusCobrancaEletronica(ANumDoc, AEspDoc, ACodEmp,
    API_PAGARME_BAIXA_PEDIDO_NAO_ENTREGUE, ATipoCobranca);
end;

function TControladorCobrancaEletronica.fCancelaLinkPagamento(const ANumDoc,
  AEspDoc, ACodEmp: String;
  const ATipoCobranca: TTipoCobrancaEletronica): TControladorCobrancaEletronica;
begin
  Result := Self;

  pAtualizaStatusCobrancaEletronica(ANumDoc, AEspDoc, ACodEmp,
    API_PAGARME_CANCELA_LINK_REMOVE_COBELT, ATipoCobranca);

  fGravarLogCobrancaEletronica(ANumDoc, AEspDoc, ACodEmp, ATipoCobranca,
    'Documento desvinculado da cobrança eletrônica.');
end;

function TControladorCobrancaEletronica.fCriarNovoLinkPagamento(const ANumDoc,
  AEspDoc, ACodEmp: String;
  const ATipoCobranca: TTipoCobrancaEletronica): TControladorCobrancaEletronica;
begin
  Result := Self;

  pAtualizaStatusCobrancaEletronica(ANumDoc, AEspDoc, ACodEmp,
    API_PAGARME_CANCELA_LINK_CRIA_NOVO, ATipoCobranca);

  fGravarLogCobrancaEletronica(ANumDoc, AEspDoc, ACodEmp, ATipoCobranca,
    'Remoção de link de pagamento antigo e geração de uma nova cobrança eletrônica.');
end;

procedure TControladorCobrancaEletronica.pEstornaAdiantamento(const ANumDoc,
  AEspDoc, ACodEmp, ACodCli: String; const AValAdt: Double; const ASeqCon: Integer);
var
  documento         : TDocAdiantamento;
  dadosAdiantamento : TDadosAdiantamento;
begin
  FillChar(documento,         SizeOf(documento),         #0);
  FillChar(dadosAdiantamento, SizeOf(dadosAdiantamento), #0);

  documento.strNumDoc := ANumDoc;
  documento.strEspDoc := AEspDoc;
  documento.strCodEmp := ACodEmp;
  documento.strCodCli := ACodCli;
  documento.fltValLan := AValAdt;

  dadosAdiantamento.AddDocumento(documento);

  dadosAdiantamento.strTipLan := 'D';
  dadosAdiantamento.dtaDtaLan := VS_Date;
  dadosAdiantamento.horHorLan := fTime();
  dadosAdiantamento.strOpeLan := '999';
  dadosAdiantamento.strEmpLan := ACodEmp;
  dadosAdiantamento.intSeqCon := ASeqCon;
  dadosAdiantamento.strDescri := 'ESTORNO VIA PAGAR.ME,  ADIANTAMENTO PEDIDO: ' + ANumDoc + '-' + AEspDoc + '-' + ACodEmp;
  dadosAdiantamento.fltValDin := 0.00;
  dadosAdiantamento.fltValChV := 0.00;
  dadosAdiantamento.fltValChP := 0.00;
  dadosAdiantamento.fltValOrd := 0.00;
  dadosAdiantamento.fltValFin := 0.00;
  dadosAdiantamento.fltValCre := 0.00;
  dadosAdiantamento.fltValCar := AValAdt;
  dadosAdiantamento.fltValLan := AValAdt;

  TAdiantamentoGenerico.fGravaAdiantamentoCliente(dadosAdiantamento);
end;

function TControladorCobrancaEletronica.fExisteAdiantamentoClienteCobrancaEletronica(
  const ANumDoc, AEspDoc, ACodEmp: String;
  const ATipoCobranca: TTipoCobrancaEletronica;
  out ARetorno: Boolean): TControladorCobrancaEletronica;
var
  LQryDados : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  Result := Self;

  fExisteCobrancaEletronica(ANumDoc, AEspDoc, ACodEmp, ATipoCobranca, ARetorno, False);
  if not ARetorno then
  begin
    ARetorno := True;
    Exit;
  end;

  LQryDados := fCriaQuery(nil);
  try
    LQryDados.Close;
    LQryDados.SQL.Text := 'SELECT * '
                        + '  FROM FATGOR '
                        + ' INNER JOIN ADTCLI ON FATGOR.FGO_NUMDOC = ADTCLI.ADT_NUMDOC '
                        + '                  AND FATGOR.FGO_ESPDOC = ADTCLI.ADT_ESPDOC '
                        + '                  AND FATGOR.FGO_CODEMP = ADTCLI.ADT_CODEMP '
                        + ' INNER JOIN COBELT ON FATGOR.FGO_NUMDOC = COBELT.CBE_NUMDOC '
                        + '                  AND FATGOR.FGO_ESPDOC = COBELT.CBE_ESPDOC '
                        + '                  AND FATGOR.FGO_CODEMP = COBELT.CBE_CODEMP '
                        + ' WHERE FATGOR.FGO_NUMDOC = :NUMDOC '
                        + '   AND FATGOR.FGO_ESPDOC = :ESPDOC '
                        + '   AND FATGOR.FGO_CODEMP = :CODEMP '
                        + '   AND COBELT.CBE_APICOB NOT IN ("PMEC") ';

    LQryDados.ParamByName('NUMDOC').AsString := ANumDoc;
    LQryDados.ParamByName('ESPDOC').AsString := AEspDoc;
    LQryDados.ParamByName('CODEMP').AsString := ACodEmp;
    LQryDados.Open;

    ARetorno := not LQryDados.IsEmpty;
  finally
    {$IFNDEF LINUX}
    FreeAndNil(LQryDados);
    {$ENDIF LINUX}
  end;
end;

function TControladorCobrancaEletronica.fExisteCobrancaEletronica(
  const ANumDoc, AEspDoc, ACodEmp: String;
  const ATipoCobranca: TTipoCobrancaEletronica; out ARetorno: Boolean;
  const AApenasComTransacaoOuPagamento: Boolean): TControladorCobrancaEletronica;
var
  LQryDados : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LAutInc   : String;
  LFiltro   : String;
begin
  Result := Self;

  LQryDados := fCriaQuery(nil);
  try
    LAutInc := fGetAutIncrem(ANumDoc, AEspDoc, ACodEmp);
    LFiltro := fGetFilterTypesByApi(ATipoCobranca, AApenasComTransacaoOuPagamento);

    LQryDados.Close;
    LQryDados.SQL.Text := 'SELECT * FROM EXTGOR '
                        + ' WHERE EXTGOR.FGO_SEQFGO = :SEQFGO '
                        + IfThen(Trim(LFiltro) <> EmptyStr, '   AND ('+LFiltro+')', EmptyStr)
                        + ' LIMIT 1 ';

    LQryDados.ParamByName('SEQFGO').AsString := LAutInc;
    LQryDados.Open;

    ARetorno := not LQryDados.IsEmpty;
  finally
    {$IFNDEF LINUX}
    FreeAndNil(LQryDados);
    {$ENDIF LINUX}
  end;
end;

function TControladorCobrancaEletronica.fGetAutIncrem(const ANumDoc, AEspDoc,
  ACodEmp: String): String;
var
  LQryDados : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LQryDados := fCriaQuery(nil);
  try
    LQryDados.Close;
    LQryDados.SQL.Text := 'SELECT AUTOINCREM FROM FATGOR '
                        + ' WHERE FGO_NUMDOC = :NUMDOC '
                        + '   AND FGO_ESPDOC = :ESPDOC '
                        + '   AND FGO_CODEMP = :CODEMP ';

    LQryDados.ParamByName('NUMDOC').AsString := ANumDoc;
    LQryDados.ParamByName('ESPDOC').AsString := AEspDoc;
    LQryDados.ParamByName('CODEMP').AsString := ACodEmp;
    LQryDados.Open;

    Result := LQryDados.FieldByName('AUTOINCREM').AsString;
  finally
    {$IFNDEF LINUX}
    FreeAndNil(LQryDados);
    {$ENDIF LINUX}
  end;
end;

function TControladorCobrancaEletronica.fGetFilterTypesByApi(
  const ATipoCobrancaEletronica: TTipoCobrancaEletronica;
  const AApenasComTransacaoOuPagamento: Boolean): String;
var
  LIndex : Integer;
begin
  Result := EmptyStr;

  TDicionarioCobrancaEletronica.GetInstance.ApenasComTransacaoOuPagamento := AApenasComTransacaoOuPagamento;
  for LIndex := 0 to Pred(TDicionarioCobrancaEletronica.GetInstance.TipoCobranca.Items[ATipoCobrancaEletronica].Count) do
  begin
    if LIndex > 0 then
      Result := Result
               + ' OR ';

    Result := Result
            + 'EXTGOR.FGO_TIPREC = "'+ TDicionarioCobrancaEletronica.GetInstance.TipoCobranca.Items[ATipoCobrancaEletronica][LIndex] +'"'
  end;

end;

function TControladorCobrancaEletronica.fGravarLogCobrancaEletronica(
  const ANumDoc, AEspDoc, ACodEmp: String;
  const ATipoCobranca: TTipoCobrancaEletronica;
  const AObservacao: String): TControladorCobrancaEletronica;
var
  LQryDados : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LTipRec   : String;
begin
  Result := Self;

  If fEmptyStr(AObservacao) Then
    Exit;

  LTipRec := EmptyStr;
  If ATipoCobranca = tcPagarMe Then
    LTipRec := API_PAGARME;

  LQryDados := fCriaQuery(nil);
  try
    LQryDados.Close;
    LQryDados.SQL.Text := 'INSERT INTO LOGCBE( '
                        + '       LOG_NUMDOC '
                        + '     , LOG_ESPDOC '
                        + '     , LOG_CODEMP '
                        + '     , LOG_TIPREC '
                        + '     , LOG_CODOPE '
                        + '     , LOG_DTAENT '
                        + '     , LOG_HORENT '
                        + '     , LOG_OBSERV '
                        + ') VALUES ( '
                        + '       :NUMDOC '
                        + '     , :ESPDOC '
                        + '     , :CODEMP '
                        + '     , :TIPREC '
                        + '     , :CODOPE '
                        + '     , :DTAENT '
                        + '     , :HORENT '
                        + '     , :OBSERV '
                        + ') ';

    LQryDados.ParamByName('NUMDOC').AsString   := ANumDoc;
    LQryDados.ParamByName('ESPDOC').AsString   := AEspDoc;
    LQryDados.ParamByName('CODEMP').AsString   := ACodEmp;
    LQryDados.ParamByName('TIPREC').AsString   := LTipRec;
    LQryDados.ParamByName('CODOPE').AsString   := strLoginUsuarioLogado;
    LQryDados.ParamByName('DTAENT').AsDateTime := VS_Date;
    LQryDados.ParamByName('HORENT').AsDateTime := fTime();
    LQryDados.ParamByName('OBSERV').AsString   := AObservacao;
    LQryDados.ExecSQL;
  finally
    {$IFNDEF LINUX}
    FreeAndNil(LQryDados);
    {$ENDIF LINUX}
  end;
end;

function TControladorCobrancaEletronica.fValidaCadastroCliente(const ACodCli,
  ACodCnd: String; out ARetorno: Boolean;
  const ATipoCobranca: TTipoCobrancaEletronica): TControladorCobrancaEletronica;
var
  LQryDados   : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LstlMensagem: TStringList;
begin
  Result := Self;
  ARetorno := True;
  LstlMensagem := nil;
  LQryDados    := nil;

  try
    if ATipoCobranca = tcPagarMe then
    begin
      if not fCfgSis('PMEHAB', varBoolean) then
        Exit;
    end;

    if fEmptyStr(ACodCnd) Then
      Exit;

    if fCampoTabela('CND_COBPME', 'CADCND', ['CND_CODIGO'], [ACodCnd]) = 'N' then
      Exit;

    try
      LstlMensagem := TStringList.Create;
      LQryDados := fCriaQuery(nil);

      LQryDados.Close;
      LQryDados.SQL.Text := 'SELECT '
                          + '       CLI_CODCLI '
                          + '     , CLI_NOMCLI '
                          + '     , CLI_C_G_C_ '
                          + '     , CLI_ENDERE '
                          + '     , CLI_ENDNUM '
                          + '     , CID_NOMCID '
                          + '     , CID_ESTADO '
                          + '     , CLI_BAIRRO '
                          + '     , CLI_C_E_P_ '
                          + '     , CLI_CELULA '
                          + '     , CLI_FONE01 '
                          + '     , CLI_NASCIM '
                          + '     , CLI_EMAIL_ '
                          + '  FROM CADCLI '
                          + '  LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID '
                          + ' WHERE CLI_CODCLI = :CODCLI ';
      LQryDados.ParamByName('CODCLI').AsString := ACodCli;
      LQryDados.Open;

      if fEmptyStr(LQryDados.FieldByName('CLI_C_G_C_').AsString) then
        LstlMensagem.Add('- CPF/CNPJ');

      if fEmptyStr(LQryDados.FieldByName('CLI_ENDERE').AsString) then
        LstlMensagem.Add('- Endereço');

      if fEmptyStr(LQryDados.FieldByName('CLI_ENDNUM').AsString) then
        LstlMensagem.Add('- Número Endereço');

      if fEmptyStr(LQryDados.FieldByName('CLI_BAIRRO').AsString) then
        LstlMensagem.Add('- Bairro');

      if fEmptyStr(LQryDados.FieldByName('CID_NOMCID').AsString) then
        LstlMensagem.Add('- Cidade');

      if fEmptyStr(LQryDados.FieldByName('CID_ESTADO').AsString) then
        LstlMensagem.Add('- Estado');

      if fEmptyStr(LQryDados.FieldByName('CLI_C_E_P_').AsString) then
        LstlMensagem.Add('- CEP');

      if fEmptyStr(LQryDados.FieldByName('CLI_EMAIL_').AsString) then
        LstlMensagem.Add('- E-mail');

      if fEmptyStr(LQryDados.FieldByName('CLI_CELULA').AsString) and
         fEmptyStr(LQryDados.FieldByName('CLI_FONE01').AsString) then
        LstlMensagem.Add('- Telefone ou Celular');

      if (LstlMensagem.Count > 0) then
      begin
        ARetorno := False;

        LstlMensagem.Add(EmptyStr);
        LstlMensagem.Add('Para utilizar uma condição de pagamento Pagar.me,');
        LstlMensagem.Add('é necessário o preenchimento dos campos acima');
        LstlMensagem.Add('no cadastro do cliente. Caso os campos não');
        LstlMensagem.Add('estejam preenchidos, o link de pagamento');
        LstlMensagem.Add('não será gerado.');

        {$IFNDEF LINUX}
        fMensagemTabela('AVISO!',
                        'Encontramos os seguintes campos sem preenchimento: ',
                        TStringArray(LstlMensagem.ToStringArray), EmptyStr, ['&Ok']);
        {$ENDIF LINUX}
      end;
    finally
      {$IFNDEF LINUX}
      FreeAndNil(LQryDados);
      {$ENDIF LINUX}
      FreeAndNil(LstlMensagem);
    end;
  except
    on E:Exception Do
    begin
      ARetorno  := False;
      E.Message := 'Erro ao validar o cadastro do cliente '+ACodCli + #13#10 + E.Message;
      raise;
    end;
  end;
end;

function TControladorCobrancaEletronica.fProcessaEstornoAdiantamento(
  const ANumDoc, AEspDoc, ACodEmp: String;
  const ATipoCobranca: TTipoCobrancaEletronica): TControladorCobrancaEletronica;
var
  LqryDados : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  Result := Self;

  LqryDados := nil;
  Try
    LqryDados := fCriaQuery;

    LqryDados.SQL.Clear;
    LqryDados.SQL.Text := 'SELECT * FROM ADTCLI '
                        + ' WHERE ADT_NUMDOC = :NUMDOC '
                        + '   AND ADT_ESPDOC = :ESPDOC '
                        + '   AND ADT_CODEMP = :CODEMP '
                        + '   AND ADT_DESCRI LIKE "%PAGAR.ME%" '
                        + '   AND ADT_TIPLAN = "C" '
                        + ' ORDER BY '
                        + '       AUTOINCREM '
                        + ' LIMIT 1 ';

    LqryDados.ParamByName('NUMDOC').AsString := ANumDoc;
    LqryDados.ParamByName('ESPDOC').AsString := AEspDoc;
    LqryDados.ParamByName('CODEMP').AsString := ACodEmp;
    LqryDados.Open;

    If LqryDados.IsEmpty Then
      Exit;

    fGravarLogCobrancaEletronica(ANumDoc, AEspDoc, ACodEmp, ATipoCobranca,
      'Estorno de adiantamento');

    LqryDados.First;

    If LqryDados.FieldByName('ADT_VALCAR').AsFloat > 0 Then
      pRemoveBaixaComCartaoCredito(ANumDoc, AEspDoc, ACodEmp, ATipoCobranca);

    pEstornaAdiantamento(LqryDados.FieldByName('ADT_NUMDOC').AsString,
                         LqryDados.FieldByName('ADT_ESPDOC').AsString,
                         LqryDados.FieldByName('ADT_CODEMP').AsString,
                         LqryDados.FieldByName('ADT_CODCLI').AsString,
                         LqryDados.FieldByName('ADT_VALLAN').AsFloat,
                         LqryDados.FieldByName('ADT_SEQCON').AsInteger);

  Finally
    {$IFNDEF LINUX}
    FreeAndNil(LqryDados);
    {$ENDIF LINUX}
  End;
end;

class function TControladorCobrancaEletronica.New: TControladorCobrancaEletronica;
begin
  Result := Self.Create;
end;

procedure TControladorCobrancaEletronica.pAtualizaStatusCobrancaEletronica(
  const ANumDoc, AEspDoc, ACodEmp, AStatus: String;
  const ATipoCobranca: TTipoCobrancaEletronica);
var
  LQryDados : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LAutInc   : String;
  LRetorno  : Boolean;
begin
  fExisteCobrancaEletronica(ANumDoc, AEspDoc, ACodEmp, ATipoCobranca, LRetorno, False);

  if not LRetorno Then
    Exit;

  LQryDados := fCriaQuery(nil);
  try
    LAutInc := fGetAutIncrem(ANumDoc, AEspDoc, ACodEmp);

    LQryDados.Close;
    LQryDados.SQL.Text := 'UPDATE EXTGOR '
                        + '   SET FGO_TIPREC = :TIPREC '
                        + ' WHERE EXTGOR.FGO_SEQFGO = :SEQFGO ';

    LQryDados.ParamByName('SEQFGO').AsString := LAutInc;
    LQryDados.ParamByName('TIPREC').AsString := AStatus;
    LQryDados.ExecSQL;
  finally
    {$IFNDEF LINUX}
    FreeAndNil(LQryDados);
    {$ENDIF LINUX}
  end;
end;

procedure TControladorCobrancaEletronica.pRemoveBaixaComCartaoCredito(
  const ANumDoc, AEspDoc, ACodEmp: String;
  const ATipoCobranca: TTipoCobrancaEletronica);
var
  LqryDados,
  LqryDelMovBan: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LqryDados     := nil;
  LqryDelMovBan := nil;
  Try
    LqryDados     := fCriaQuery;
    LqryDelMovBan := fCriaQuery;

    LqryDelMovBan.Close;
    LqryDelMovBan.SQL.Clear;
    LqryDelMovBan.SQL.Text := 'SELECT * FROM MOVBAN '
                            + ' WHERE CTB_SEQTRF = :SEQTRF '
                            + '   AND CTB_ORIGEM = :ORIGEM '
                            + '   AND CTB_CODEMP = :CODEMP ';

    LqryDados.SQL.Clear;
    LqryDados.SQL.Text := 'SELECT * FROM MOVCAR '
                        + ' WHERE MCA_NUMDOC = :NUMDOC '
                        + '   AND MCA_ESPDOC = :ESPDOC '
                        + '   AND MCA_EMPDOC = :CODEMP ';

    LqryDados.ParamByName('NUMDOC').AsString := ANumDoc;
    LqryDados.ParamByName('ESPDOC').AsString := AEspDoc;
    LqryDados.ParamByName('CODEMP').AsString := ACodEmp;
    LqryDados.Open;

    If LqryDados.IsEmpty Then
      Exit;

    LqryDados.First;
    While Not LqryDados.Eof Do
    Begin
      LqryDelMovBan.Close;
      LqryDelMovBan.ParamByName('CODEMP').AsString := ACodEmp;
      LqryDelMovBan.ParamByName('ORIGEM').AsString := 'TRF';
      LqryDelMovBan.ParamByName('SEQTRF').AsString := LqryDados.FieldByName('MCA_SEQCON').AsString;
      LqryDelMovBan.Open;

      If Not LqryDelMovBan.IsEmpty Then
      Begin
        While Not LqryDelMovBan.Eof Do
        Begin
          fVerificaIntegridade('PME - LINK PAGAMENTO', 'MOVBAN', LqryDelMovBan, True);
          LqryDelMovBan.Delete;
        End;
      End;

      fVerificaIntegridade('PME - LINK PAGAMENTO', 'MOVCAR', LqryDados, True);
      LqryDados.Delete;
    End;
  Finally
    {$IFNDEF LINUX}
    FreeAndNil(LqryDados);
    FreeAndNil(LqryDelMovBan);
    {$ENDIF LINUX}
  End;
end;

end.


