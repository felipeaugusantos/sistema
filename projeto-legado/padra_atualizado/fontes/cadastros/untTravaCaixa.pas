unit untTravaCaixa;

interface

uses Uni;

type

  TStatusCaixa = Record
    CodigoCaixa  : String;
    CaixaFechado : Boolean;
    CaixaDiaAnteriorAberto : Boolean;
  End;

  TCaixas = Array of TStatusCaixa;

  TStatusGeral = Record
    TemCaixaAberto  : Boolean;
    TemCaixaDiaAnteriorAberto : Boolean;
  End;

  TTravaCaixa = Class
  private

    FOpcDoc           : String;
    FModoSemMensagens : Boolean;
    FDataDoCaixa      : TDateTime;
    FDataDeFechamento : TDateTime;

    FApenasEmissaoDeDocumentosAPrazo : Boolean;
    FApenasEmissaoDePD_OR_AVista     : Boolean;
    FGravarComo                      : Boolean;
    FTravar                          : Boolean;
    FCodigoCaixa                     : String;
    FMensagemDaTrava                 : String;
    FArrCai                          : TCaixas;
    FStatus                          : TStatusGeral;

    function  fGetData : TDateTime;

    procedure pExecRegras;
    procedure pExecRegrasFechamentoTotal;
    procedure pExecRegrasFechamentoCaixas;

    function fRetornarStatusGeral(AArrCai : TCaixas) : TStatusGeral;
    procedure pExecMensagem(AMensagem : String);

    procedure pTravar;
    function fCaixaFechaUmaUnicaVezNoDia: Boolean;
    procedure pDefineSeEmissaoDeDocumentosAPrazo(var AModoSemMensagens: Boolean);
    function fEmissaoDePedidoOrcamento: Boolean;

    function fUtilizaResumoDeCaixa : Boolean;
    function fPermiteEmissaoDePedidoOrcamentoAVistaComCaixaFechado                    : Boolean;
    function fPermiteEmissaoDePedidoOrcamentoAVistaComCaixaDoDiaAnteriorNaoFechado    : Boolean;
    function fPermiteEmissaoDePedidoOrcamentoAPrazoIndependenteDaSituacaoDoFechamento : Boolean;

    function fCaixaFechado(const ADataFechamento: TDateTime): Boolean;
    function fCaixaFechadoEBloqueadoParaEmissao(const ADataFechamento: TDateTime; const AApenasEmissaoDeDocumentosAPrazo, AModoSemMensagens: Boolean; var ATravar, AApenasEmissaoDePD_OR_AVista: Boolean): Boolean;
  public

    constructor New(AOpcDoc           : String;
                    AModoSemMensagens : Boolean   = False;
                    ADtaCai           : TDateTime = 0;
                    ACodCaixa         : String = '');

    property blnApenasEmissaoDeDocumentosAPrazo : Boolean   read FApenasEmissaoDeDocumentosAPrazo;
    property blnApenasEmissaoDePD_OR_AVista     : Boolean   read FApenasEmissaoDePD_OR_AVista;
    property blnGravarComo                      : Boolean   read FGravarComo;
    property blnTravar                          : Boolean   read FTravar;
    property dtaDataDeFechamento                : TDateTime read FDataDeFechamento;
    property strMensagemDaTrava                 : String    read FMensagemDaTrava;

    function fCaixaDoDiaFechadoOuCaixaDoDiaAnteriorAindaNaoFechado : Boolean;

  end;

const
  MSG_O_FECHAMENTO_REF_DIA_JA_EFETUADO = 'O fechamento referente ao dia: #DIA já foi efetuado!';
  MSG_CAIXA_PENDENTE_DE_FECHAMENTO = 'O caixa do dia anterior esta pendente de fechamento!';

  MSG_SOMENTE_A_PRAZO = 'Só é permitido emitir documento com condição de pagamento à prazo!' + #13 +
                        'O caixa já foi fechado ou caixa do dia anterior ainda não foi fechado.';

  MSG_SOMENTE_A_VISTA = 'Só é permitido emitir documento com condição de pagamento à vista!' + #13 +
                        'O caixa já foi fechado ou caixa do dia anterior ainda não foi fechado.';

  MSG_SELECAO_SOMENTE_A_PRAZO = 'Só é permitido selecionar documento com condição de pagamento à prazo!' + #13 +
                                'O caixa já foi fechado ou caixa do dia anterior ainda não foi fechado.';

  APRESENTAR_MSG_DA_TRAVA     = True;
  NAO_APRESENTAR_MSG_DA_TRAVA = False;

implementation

uses
  untFuncoesSimples, untCadRcxx, System.SysUtils, System.Math;

{ TTravaCaixa }

function TTravaCaixa.fCaixaFechado(const ADataFechamento: TDateTime): Boolean;
begin
  Result := (ADataFechamento = fGetData);
end;

function TTravaCaixa.fCaixaFechaUmaUnicaVezNoDia: Boolean;
begin
  Result := (fCfgSis('TPFCCX') <> 'C');
end;

function TTravaCaixa.fEmissaoDePedidoOrcamento: Boolean;
begin
  Result := (Pos(FOpcDoc, 'PD_OR_') > 0);
end;

function TTravaCaixa.fGetData: TDateTime;
begin
  Result := IIF(FDataDoCaixa > 0, FDataDoCaixa, VS_Date);
end;

function TTravaCaixa.fPermiteEmissaoDePedidoOrcamentoAPrazoIndependenteDaSituacaoDoFechamento: Boolean;
begin
  Result := fCfgSisL('FATCFE', varBoolean)
end;

function TTravaCaixa.fPermiteEmissaoDePedidoOrcamentoAVistaComCaixaDoDiaAnteriorNaoFechado: Boolean;
begin
  Result := fCfgSis('AVICAB', varBoolean);
end;

function TTravaCaixa.fPermiteEmissaoDePedidoOrcamentoAVistaComCaixaFechado: Boolean;
begin
  Result := fCfgSisL('AVICFE', varBoolean);
end;

function TTravaCaixa.fRetornarStatusGeral(AArrCai: TCaixas): TStatusGeral;
  var
    intIdx : Integer;
begin

  Result.TemCaixaAberto := False;
  Result.TemCaixaDiaAnteriorAberto := False;

  for intIdx := Low(AArrCai) to High(AArrCai) do
  begin

    If (Not AArrCai[intIdx].CaixaFechado) And (Not AArrCai[intIdx].CaixaDiaAnteriorAberto) Then
    Begin
      Result.TemCaixaAberto := True;
      Exit;
    End

    Else If (AArrCai[intIdx].CaixaDiaAnteriorAberto) Then
      Result.TemCaixaDiaAnteriorAberto := True;

  end;

end;

function TTravaCaixa.fUtilizaResumoDeCaixa: Boolean;
begin
  Result := fCfgSis('USARCX', varBoolean);
end;

function TTravaCaixa.fCaixaDoDiaFechadoOuCaixaDoDiaAnteriorAindaNaoFechado: Boolean;
  var
    LDtaLan : TDateTime;
begin
  If fCaixaFechaUmaUnicaVezNoDia Then
  Begin
    Result := (FDataDeFechamento = fGetData) Or (Not fNecessitaFecharCaixa(True, LDtaLan, False));
  End Else
  Begin

    If FStatus.TemCaixaAberto Then
      Exit(False);

    Result := FStatus.TemCaixaDiaAnteriorAberto;

  End;
end;

constructor TTravaCaixa.New(AOpcDoc           : String;
                            AModoSemMensagens : Boolean   = False;
                            ADtaCai           : TDateTime = 0;
                            ACodCaixa         : String = '');
begin

  inherited;

  FOpcDoc           := AOpcDoc;
  FModoSemMensagens := AModoSemMensagens;
  FDataDoCaixa      := ADtaCai;
  FCodigoCaixa      := ACodCaixa;

  FApenasEmissaoDeDocumentosAPrazo := False;
  FApenasEmissaoDePD_OR_AVista     := False;
  FTravar                          := False;

  FMensagemDaTrava := '';
  FGravarComo := True;
  SetLength(FArrCai, 0);

  pExecRegras;

end;

procedure TTravaCaixa.pDefineSeEmissaoDeDocumentosAPrazo(var AModoSemMensagens: Boolean);
begin
  If (fCaixaDoDiaFechadoOuCaixaDoDiaAnteriorAindaNaoFechado) Then
    FApenasEmissaoDeDocumentosAPrazo := fPermiteEmissaoDePedidoOrcamentoAPrazoIndependenteDaSituacaoDoFechamento;

  If (FApenasEmissaoDeDocumentosAPrazo) Then
    AModoSemMensagens := True;
end;

procedure TTravaCaixa.pExecMensagem(AMensagem: String);
begin

  FMensagemDaTrava := AMensagem;

  If Not FModoSemMensagens Then
    fMensagem('', FMensagemDaTrava, ['&Ok']);

end;

procedure TTravaCaixa.pExecRegras;
begin

  If Not fUtilizaResumoDeCaixa Then
    Exit;

  If (fCaixaFechaUmaUnicaVezNoDia) Then
    pExecRegrasFechamentoTotal
  Else
    pExecRegrasFechamentoCaixas;

  FGravarComo := Not FTravar;

end;

procedure TTravaCaixa.pExecRegrasFechamentoCaixas;
  const
    SQL_CAIXA  = 'SELECT * FROM CADCAX WHERE CAX_CODEMP = :CODEMP AND CAX_STATUS = "A" AND CAX_CODCAX = :CODCAX';
    SQL_CAIXAS = 'SELECT * FROM CADCAX WHERE CAX_CODEMP = :CODEMP AND CAX_STATUS = "A"';
  var
    LSalFec : Double;
    LDtaFec : TDateTime;
    LDtaLan : TDateTime;

    LQryCai : TUniQuery;
    LCodCai : String;

begin

  LQryCai := fCriaQuery();
  SetLength(FArrCai, 0);

  Try

    LQryCai.Close;
    LQryCai.SQL.Add(IIF(Not FCodigoCaixa.IsEmpty, SQL_CAIXA, SQL_CAIXAS));
    LQryCai.ParamByName('CODEMP').AsString := VS_strCodEmp;

    If Not FCodigoCaixa.IsEmpty Then
      LQryCai.ParamByName('CODCAX').AsString := FCodigoCaixa;

    LQryCai.Open;

    If LQryCai.IsEmpty Then
      Exit;

    LQryCai.First;
    While Not LQryCai.Eof Do
    Begin

      LCodCai := LQryCai.FieldByName('CAX_CODCAX').AsString;
      pRetornaUltimoFechamento(LSalFec, LDtaFec, '', LCodCai);

      SetLength(FArrCai, Succ(Length(FArrCai)));
      FArrCai[High(FArrCai)].CodigoCaixa  := LCodCai;
      FArrCai[High(FArrCai)].CaixaFechado := LDtaFec = fGetData;
      FArrCai[High(FArrCai)].CaixaDiaAnteriorAberto := Not fNecessitaFecharCaixa(True, LDtaLan, False, '', LCodCai);

      LQryCai.Next;
    End

  Finally
    FreeAndNil(LQryCai);
  End;

  FStatus := fRetornarStatusGeral(FArrCai);

  If FStatus.TemCaixaAberto Then
    Exit;

  pDefineSeEmissaoDeDocumentosAPrazo(FModoSemMensagens);

  If FStatus.TemCaixaDiaAnteriorAberto Then
  Begin

    FApenasEmissaoDePD_OR_AVista := fPermiteEmissaoDePedidoOrcamentoAVistaComCaixaDoDiaAnteriorNaoFechado;

    If (Not FApenasEmissaoDeDocumentosAPrazo) And (Not (FApenasEmissaoDePD_OR_AVista And fEmissaoDePedidoOrcamento)) Then
    Begin
      pExecMensagem(MSG_CAIXA_PENDENTE_DE_FECHAMENTO);
      pTravar;
    End;

    Exit;

  End;

  {*** TODOS os caixas fechados ***}
  FApenasEmissaoDePD_OR_AVista := fPermiteEmissaoDePedidoOrcamentoAVistaComCaixaFechado;

  If (Not FApenasEmissaoDeDocumentosAPrazo) And (Not FApenasEmissaoDePD_OR_AVista) Then
  Begin
    pExecMensagem(MSG_O_FECHAMENTO_REF_DIA_JA_EFETUADO.Replace('#DIA', FormatDateTime('dd/mm/yyyy', fGetData)));
    pTravar;
    Exit;
  End

end;

procedure TTravaCaixa.pExecRegrasFechamentoTotal;
  var
    LSalFec : Double;
    LDtaFec : TDateTime;
    LDtaLan : TDateTime;
begin

  pRetornaUltimoFechamento(LSalFec, LDtaFec, '');
  FDataDeFechamento := LDtaFec;

  pDefineSeEmissaoDeDocumentosAPrazo(FModoSemMensagens);

  If fCaixaFechadoEBloqueadoParaEmissao(LDtaFec, FApenasEmissaoDeDocumentosAPrazo, FModoSemMensagens, FTravar, FApenasEmissaoDePD_OR_AVista) Then
    Exit;

  {*** Caixa aberto dia anterior ***}
  If FOpcDoc = 'OR' Then
  Begin

    If (Not fNecessitaFecharCaixa(True, LDtaLan, False)) Then
    Begin
      If (fPermiteEmissaoDePedidoOrcamentoAVistaComCaixaDoDiaAnteriorNaoFechado) Then
        FApenasEmissaoDePD_OR_AVista := True
      Else If Not fNecessitaFecharCaixa(True, LDtaLan, IIF(FModoSemMensagens, NAO_APRESENTAR_MSG_DA_TRAVA, APRESENTAR_MSG_DA_TRAVA), '') Then
      Begin
        pTravar;
        Exit;
      End;
    End;
  End
  Else If FOpcDoc = 'PD' Then
  Begin
    If (Not fNecessitaFecharCaixaInterno(True, LDtaLan, FMensagemDaTrava, False, '')) Then
    Begin
      If (fPermiteEmissaoDePedidoOrcamentoAVistaComCaixaDoDiaAnteriorNaoFechado) Then
        FApenasEmissaoDePD_OR_AVista := True
      Else If (Not fNecessitaFecharCaixaInterno(True, LDtaLan, FMensagemDaTrava, IIF(FModoSemMensagens, NAO_APRESENTAR_MSG_DA_TRAVA, APRESENTAR_MSG_DA_TRAVA), '')) Then
      Begin
        pTravar;
        Exit;
      End;
    End;
  End
  Else
  Begin
    If (Not fNecessitaFecharCaixaInterno(True, LDtaLan, FMensagemDaTrava, IIF(FModoSemMensagens, NAO_APRESENTAR_MSG_DA_TRAVA, APRESENTAR_MSG_DA_TRAVA), '')) Then
    Begin
      pTravar;
      Exit;
    End;
  End;

end;

procedure TTravaCaixa.pTravar;
begin
  FTravar := False;

  If (FApenasEmissaoDeDocumentosAPrazo) Then
    Exit;

  FTravar := True;
end;

function TTravaCaixa.fCaixaFechadoEBloqueadoParaEmissao(const ADataFechamento: TDateTime; const AApenasEmissaoDeDocumentosAPrazo, AModoSemMensagens: Boolean; var ATravar, AApenasEmissaoDePD_OR_AVista: Boolean): Boolean;
begin
  Result := False;

  If (fCaixaFechado(ADataFechamento)) Then
  Begin
    If (Not AApenasEmissaoDeDocumentosAPrazo) And (Not (fPermiteEmissaoDePedidoOrcamentoAVistaComCaixaFechado And fEmissaoDePedidoOrcamento)) Then
    Begin
      pExecMensagem(MSG_O_FECHAMENTO_REF_DIA_JA_EFETUADO.Replace('#DIA', FormatDateTime('dd/mm/yyyy', fGetData)));
      ATravar := True;
      Result  := True;
      Exit;
    End
    Else
    Begin
      If fPermiteEmissaoDePedidoOrcamentoAVistaComCaixaFechado Then
        AApenasEmissaoDePD_OR_AVista := True;
    End;
  End;
end;

end.
