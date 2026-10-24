unit untGeraTransferencia;

interface

uses Classes, SysUtils, Uni, untFuncoesSimples, cxProgressBar, untConstantes, Data.DB;

Type
  TValidaSeItemGeraTE = function(DataSet: TDataSet): Boolean of object;

  TGeraTransferencia = class

  private
    intContador: INteger;
    FAutInc: String;
    FTotGer: Double;
    FTotCus: Double;
    FTotMed: Double;
    FPesLiq: Double;
    FEmpresaDestino: String;
    qryConsulta: TUniQuery;
    FCliFil: String;
    FCndPgo: String;
    FConPagMsk: String;
    FForPag: String;
    strErroProcesso: String;
    FNumDoc: String;
    FEspDoc: String;
    FEmpFat : Boolean;
    FCodTra : string;
    FSomLiq : Boolean;
    FFatLiq : Double;
    FDataSet: TDataSet;
    strEntRet: String;
    FTabPre : String;
    FCliEst : String;
    FPesBru : Double;
    fValidaSeItemGeraTE: TValidaSeItemGeraTE;

    function fCarregarConfigParaGerarOrcamento(var strConPgtMas, strCodConPgt, strForPag: string; strCodCli: string): boolean;
    function fCarregaCliente: Boolean;
    procedure pDefineCondicoesPagamento;
    procedure pDefineForPag;
    function fCondicaoPagamentoIndefinida: Boolean;

    procedure pDefineEntRet;
    Function fCndPagto(strCndPag: String = '01000'): String;
    Function fGeraPedido(): Boolean;
    Function fGravaFatGorTE(): Boolean;
    Function fGravaFatDorTE: Boolean;
    function fRetstrTabPreTBPSUG(strTabCli: String): string;

    Function fRetTabelaPreco(strCodCli: String): String;
    function fGetForPag: String;


    Function fProcessItens: Boolean;
    function fRetdesIte: String;
    function fCarregaItens: Boolean;

    function fRetFAT_TE(strCodSit: String): Double;
    function fRetTEPREV(strTEPREV: String): Double;
    Function fGeraTransfItem: Boolean;

    procedure pSomaPesLiq(fltQtdIte: Double);
    Function fPodeAtualizarCRM: Boolean;

  public
    strFieldQuantidade: String;
    property strEmpresaDestino: String read FEmpresaDestino write FEmpresaDestino;
    constructor Create(DataSet: TDataSet; AValidaSeItemGeraTE: TValidaSeItemGeraTE);
    destructor Destroy; override;
    function fGeraPedidosVenda(var strFalha: String): Boolean;
  End;

implementation

uses
  untGravando, untTSituacaoPedidoVenda, untAtualizaOcorrenciasCRM, untTypesCRM, untTypesSistema, untFuncoesCRM,
  untFatGor;


constructor TGeraTransferencia.Create(DataSet: TDataSet; AValidaSeItemGeraTE: TValidaSeItemGeraTE);
begin
  qryConsulta := fCriaQuery;
  FDataSet := DataSet;
  fValidaSeItemGeraTE := AValidaSeItemGeraTE;
end;


destructor TGeraTransferencia.Destroy;
begin
  FreeAndNil(qryConsulta);
end;

Function TGeraTransferencia.fCndPagto(strCndPag: String = '01000'): String;
Begin

  qryConsulta.Close;
  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('SELECT SQL_NO_CACHE CND_CODIGO FROM CADCND');
  qryConsulta.SQL.Add('WHERE CND_CNDPAG = "' + strCndPag + '" AND LOCATE('+ QuotedStr(VS_strCodEmp) + ', CND_EMPACE)');
  qryConsulta.SQL.Add('ORDER BY CND_CODIGO             ');
  qryConsulta.Open;

  If fCfgSis('USACND', varBoolean) Then
    Result := qryConsulta.FieldByName('CND_CODIGO').AsString
  Else
    Result := '';

End;


function TGeraTransferencia.fCarregaCliente: Boolean;
Begin
  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('SELECT ');
  qryConsulta.SQL.Add('       CLICND.CND_CODCND, CADCND.CND_CODFPG, ');
  qryConsulta.SQL.Add('       CLICND.CND_CNDPAG');
  qryConsulta.SQL.Add('  FROM CADCLI');
  qryConsulta.SQL.Add('  LEFT JOIN CLICND ON CLI_CODCLI = CND_CODCLI');
  qryConsulta.SQL.Add('  LEFT JOIN CADCND ON CND_CODIGO = CND_CODCND');
  qryConsulta.SQL.Add(' WHERE CLI_CODCLI = :CODCLI');
  qryConsulta.ParamByName('CODCLI').AsString := FCliFil;
  qryConsulta.Open;
  Result := qryConsulta.RecordCount > 0;
End;


procedure TGeraTransferencia.pSomaPesLiq(fltQtdIte: Double);
begin
  If FSomLiq Then
    FPesLiq := FPesLiq + fltQtdIte * FDataSet.FieldByName('ITE_PESLIQ').AsFloat
  Else
    FPesLiq := fFormataFloat(FPesBru * FFatLiq, 3);
End;


function TGeraTransferencia.fRetTEPREV(strTEPREV: String): Double;
begin
  If (strTEPREV = 'IMP') Then
    Result := FDataSet.FieldByName('ITE_IMPULT').AsFloat
  Else If (strTEPREV = 'SIC') Then
    Result := FDataSet.FieldByName('ITE_MEDSIC').AsFloat
  Else
    Result := FDataSet.FieldByName('ITE_PRE' + strTEPREV).AsFloat;
End;


function TGeraTransferencia.fRetFAT_TE(strCodSit: String): Double;
Begin
  If CST_SUBSTITUICAO.Contains(strCodSit) Then
    Result := fRetClienteFilialFatorTE_ST(VS_StrCodEmp, FCliFil)
  Else
    Result := fRetClienteFilialFatorTE(VS_StrCodEmp, FCliFil);
End;


Function TGeraTransferencia.fGeraTransfItem: Boolean;
begin
  If Not Assigned(fValidaSeItemGeraTE) Then
    Exit(True);
 Result := fValidaSeItemGeraTE(FDataSet);
End;

function TGeraTransferencia.fCarregaItens: Boolean;
var strTEPREV: String;
    strCodAbf: String;
    strCodSit: String;
    fltFat_TE : Double;
    fltTEPREV : Double;
    fltQtdIte : Double;
begin
    Result := True;
    FDataSet.First;
    FTotGer := 0;
    FTotCus := 0;
    FTotMed := 0;
    FPesBru := 0;
    FPesLiq := 0;

    FDataSet.First;

    While Not FDataSet.Eof Do
    Begin
        If Not fGeraTransfItem Then
        Begin
          FDataSet.Next;
          Continue;
        End;

      fltQtdIte :=  FDataSet.FieldByName(strFieldQuantidade).AsFloat;

      If fltQtdIte < 0 Then
        fltQtdIte :=  fltQtdIte * -1;

     {Identifica qual preço será utilizado!}
      strTEPREV := fGetTEPREV(VS_strCodEmp, FCliFil);

      strCodAbf := fGetCodAbf(FDataSet.FieldByName('ITE_CODITE').AsString, VS_strCodEmp);

      strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF','ABF_ESTADO'], [strCodAbf, fRetUFEmpresa(VS_strCodEmp)]);

      fltFat_TE := fRetFAT_TE(strCodSit);

      fltTEPREV := fRetTEPREV(strTEPREV);

      If (fltFat_TE > 0) Then
        fltTEPREV := (fltTEPREV * fltFat_TE);

      FTotGer := FTotGer + fltQtdIte * fltTEPREV;
      FTotCus := FTotCus + fltQtdIte * FDataSet.FieldByName('ITE_PRECUS').AsFloat;
      FTotMed := FTotMed + fltQtdIte * FDataSet.FieldByName('ITE_PREMED').AsFloat;
      FPesBru := FPesBru + fltQtdIte * FDataSet.FieldByName('ITE_PESOIT').AsFloat;

      pSomaPesLiq(fltQtdIte);

      FDataSet.Next;
    End;
    FDataSet.First;
end;

function TGeraTransferencia.fCarregarConfigParaGerarOrcamento(var strConPgtMas, strCodConPgt, strForPag: string; strCodCli: string): boolean;
  var
    strCliCnd: String;
begin
  Result := False;
//  qryConsulta := fCriaQuery;
  Try
    If (fCfgSis('USACND', varBoolean)) Then
    Begin
      strCliCnd := '';

      if fCarregaCliente Then
      Begin
         strForPag      := qryConsulta.FieldByName('CND_CODFPG').AsString;

        If fEmptyStr(strCliCnd) Then
          strCliCnd := qryConsulta.FieldByName('CND_CODCND').AsString;
      End;

      If not fEmptyStr(strCliCnd) Then
      Begin
        strCodConPgt       := strCliCnd;
        strConPgtMas       := fRetConPagCodCnd(strCliCnd);
        Result := True;
      End;

    End;
  Finally
//    FreeAndNil(qryConsulta);
  End;
end;


procedure TGeraTransferencia.pDefineForPag;
begin
  If fStatusCndPag(FConPagMsk) = A_VISTA Then
    FForPag := '001'
  Else
    FForPag := '008'
End;


function TGeraTransferencia.fCondicaoPagamentoIndefinida: Boolean;
begin
  Result := False;
  If fCfgSis('USACND', varBoolean) Then
    Result := fEmptyStr(FCndPgo);
End;

procedure TGeraTransferencia.pDefineCondicoesPagamento;
begin
  If fEmptyStr(fCfgSis('CNDPTE')) Then
  Begin
    If Not fCarregarConfigParaGerarOrcamento(FConPagMsk, FCndPgo, FForPag, FCliFil) Then
    Begin
      FCndPgo    := fCndPagto;
      FConPagMsk := '01000';
      FForPag    := '001';
    End;

    If fCondicaoPagamentoIndefinida Then
    Begin
       strErroProcesso := 'Não há nenhuma condição de pagamento à vista que a empresa "'+VS_strCodEmp+'" tenha acesso para que o sistema possa gerar os pedidos/orçamentos de transferência de estoque.'+#10#13+
                          'Antes de continuar, acesse o cadastro de condição de pagamento e altere o acesso da empresa a uma condição à vista ou informe uma condição de pagamento válida na configuração: "'+'CFG_CNDPTE - '+fRetNomCfg('CNDPTE')+'"';
       Exit;
    End;
  End
  Else
  Begin
    If fCfgSis('USACND', varBoolean) Then
    Begin
      FCndPgo    := fCfgSis('CNDPTE');
      FConPagMsk := fCampoTabela('CND_CNDPAG', 'CADCND', ['CND_CODIGO'], [FCndPgo], False);
      FForPag    := fCampoTabela('CND_CODFPG', 'CADCND', ['CND_CODIGO'], [FCndPgo], False);
      If fEmptyStr(FForPag) Then
      Begin
        pDefineForPag
      End;
    End
    Else
    Begin
      FCndPgo    := '';
      FConPagMsk := fCfgSis('CNDPTE');
      pDefineForPag;
    End;
  End;
End;


Function TGeraTransferencia.fGeraPedidosVenda(var strFalha: String): Boolean;
Begin
  intContador := 0;
  strErroProcesso := '';
  strFalha := '';

  Try
    FCliFil := fCampoTabela('EMP_CLIFIL', 'CADEMP', ['EMP_CODEMP'], [strEmpresaDestino]);

    If fEmptyStr(fCfgSis('CNDPTE')) Then
    Begin
      If fEmptyStr(FCliFil) Then
         strErroProcesso := 'O "Cliente Filial" da empresa '+strEmpresaDestino+
                               ' não está preenchido corretamente no Cadastro de Empresas!'+#13#10+
                               'Ajuste essa informação para a correta geração do '+IIF(FEspDoc='PD','Pedido','Orçamento')+' de Transferência.';
    End;
    pDefineCondicoesPagamento;
    If strErroProcesso <> '' Then
      Exit(False);

    FEmpFat := fCfgSis('EMPFAT', varBoolean);
    FSomLiq := fCfgSis('PESLIQ') = 'SOMA';
    FFatLiq := fCfgSis('FATPLI', varDouble);
    fCarregaItens;

    Result := fGeraPedido;

  Finally
    strFalha:= strErroProcesso;
  end
End;

Function TGeraTransferencia.fProcessItens: Boolean;
begin
  Result := True;

  While Not FDataSet.Eof Do
  Begin

     If fGeraTransfItem Then
       Result := fGravaFatDorTE;

     If Not Result Then
        Break;
    FDataSet.Next;
  End;
End;

Function TGeraTransferencia.fGeraPedido(): Boolean;
Begin
  Try

    FNumDoc := fRetSequencialPedido;
    FEspDoc := 'PD';

    Result := fGravaFatGorTE();

    If Result Then
    Begin
      FDataSet.First;
      Result := fProcessItens;

    End;

    If Result Then
    Begin
      {Atualiza status pedido criado}
      TUpdateStatus.New(TParamStatus.New()
                            .NumDoc(FNumDoc)
                            .EspDoc(FEspDoc)
                            .CodEmp(VS_strCodEmp)).pExecute();

      {Gera ocorrência CRM}
      If (VS_strHabilitarCRM) Then
           TUpdateOccurrenceCRM.New()
              .NumDoc(FNumDoc)
              .EspDoc(FEspDoc)
              .CodEmp(VS_strCodEmp)
              .AcaFat(afcPDTransferenciaGerado)
              .strNomFrm('[TGeraTransferencia.fGeraPedido]')
              .pRun();

    End;


  Except
    On E: Exception Do
    Begin
      Result := False;
      strErroProcesso :=  E.Message
    End;
  End;
End;

Function TGeraTransferencia.fPodeAtualizarCRM: Boolean;
Begin
  Result := False;
  If (VS_strHabilitarCRM) Then
    IF (Not fEmptyStr(fCfgSis('VENORC', varString))) Then
      If (Not fEmptyStr(fCfgSis('VENPED', varString))) Then
        Result := True;
End;

Function TGeraTransferencia.fGravaFatGorTE(): Boolean;
  Var
    strZerTax,
    strTipFre,
    strEntFat,
    strTipPed,
    strMen001,
    strMen002: String;
    recServicos: TDadosServicos;
    objOcoCrm : TAtuOcoCrm;
    arrDuplic : TarrDuplicata;
Begin
  FillChar(arrDuplic, Sizeof(arrDuplic) , #0);
  strMen001 := '';
  strMen002 := '';

  FTabPre := fRetTabelaPreco(FCliFil);
  FCliEst := fRetEstadoCliente(FCliFil);

  strTipFre := '9';
  strTipPed := 'A';
  strEntFat := 'S';
  strZerTax := 'S';

  FillChar(recServicos, Sizeof(recServicos) , #0);

  FPesBru := fFormataFloat(FPesBru, 3);

  If fPodeAtualizarCRM Then
    objOcoCrm := fAtualizaInformacoesCRM(FNumDoc, FEspDoc, VS_strCodEmp, FCliFil,'','',strLoginUsuarioLogado,IIF(FEspDoc = 'OR',afcOrcamento,afcPedido))
  Else
    objOcoCrm := Nil;

  If Assigned(objOcoCrm) Then
    objOcoCrm.strNomFrm := '[TGeraTransferencia.fGravaFatGorTE]';

  {ATUALIZANDO A TRANSPORTADORA - KM}
  FCodTra := fRetTransportadoraEntregaAtiva(FCliFil);

  If fEmptyStr(FCodTra) Then
    FCodTra := fCfgSis('TRASUG');

  Result := fGravaFatGor(FAutInc,
                     VS_strCodEmp,
                     FNumDoc,
                     FEspDoc,
                     FCliFil,
                     strLoginUsuarioLogado,
                     FCodTra,
                     '',
                     VS_Date,
                     fTime(),
                     FConPagMsk,
                     FCliEst,
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     0,
                     '',
                     '',
                     '',
                     '',
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     FTotGer,
                     FTotGer,
                     FTotCus,
                     FTotMed,
                     IIF(FEspDoc = 'OR', '1', strTipFre),
                     0,
                     FTotGer,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     FPesBru,
                     FPesLiq,
                     0,
                     arrDuplic,
                     '',
                     '',
                     strMen001,
                     strMen002,
                     False,
                     '',
                     '',
                     '',
                     0,
                     '',
                     '',
                     0.0,
                     0.0,
                     strLoginUsuarioLogado,
                     FCndPgo,
                     fGetForPag,
                     recServicos,
                     'N',
                     VS_Date,
                     0,
                     VS_Date,
                     '',
                     strTipPed,
                     '',
                     0,
                     strEntFat,
                     0,
                     FTabPre,
                     'N',
                     0.0,
                     '',
                     '',
                     False,
                     'N',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     False,
                     VS_Date,
                     strZerTax,
                     'V',
                     VS_Date,
                     'P',
                     0,
                     '',
                     '',
                     '',
                     False,
                     '',
                     Nil,
                     VS_strCodEmp,
                     VS_strCodEmp,
                     0,
                     0,
                     0,
                     '',
                     objOcoCrm,
                     '',
                     0,
                     0,
                     '',
                     '',
                     0,
                     '',
                     0,
                     '',
                     '',
                     '',
                     'N');

End;

procedure TGeraTransferencia.pDefineEntRet;
begin
  If fCfgSis('UTIROM', varString) = 'S' Then
  Begin
    If fCfgSis('SUG_TE', varBoolean) Then
      strEntRet := 'E'  // Entrega
    Else
      strEntRet := 'R'; // Retira
  End
  Else
    strEntRet:=  IIf(VS_strExpRetiraEntregaDocFat = 'T', 'E', VS_strExpRetiraEntregaDocFat);
End;

function TGeraTransferencia.fRetdesIte: String;
begin
  Result := FDataSet.FieldByName('ITE_DESITE').AsString;

  If (fCfgSis('IMPREF', varBoolean)) Then
  Begin
    If (fCfgSis('MONDES', varString) = '1') Then
      Result :=  Result +
                   IIF(Not fEmptyStr(FDataSet.FieldByName('ITE_REFERE').AsString), ' ' + FDataSet.FieldByName('ITE_REFERE').AsString, '')
    Else
      Result := IIF(Not fEmptyStr(FDataSet.FieldByName('ITE_REFERE').AsString), FDataSet.FieldByName('ITE_REFERE').AsString + ' ', '') +
                   Result;
  End;
End;



Function TGeraTransferencia.fGravaFatDorTE: Boolean;
  Var
    strAutIncFdo: String;
    fltTotPes,
    fltTotGer,
    fltTotCus,
    fltTotMed,
    fltQtdIte,
    fltTEPREV,
    fltFat_TE : Double;

    strDesIte,
    strTEPREV,
    strCodAbf,
    strCodSit: String;
Begin
  inc(intContador);

  fltQtdIte := FDataSet.FieldByName(strFieldQuantidade).AsFloat;
  If fltQtdIte < 0 Then
     fltQtdIte := fltQtdIte * -1;

  pDefineEntRet;
  {Identifica qual preço será utilizado!}
  strTEPREV := fGetTEPREV(VS_StrCodEmp, FCliFil);

  strCodAbf := fGetCodAbf(FDataSet.FieldByName('ITE_CODITE').AsString, VS_strCodEmp);

  strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF','ABF_ESTADO'], [strCodAbf, fRetUFEmpresa(VS_strCodEmp)]);


  fltFat_TE := fRetFAT_TE(strCodSit);

  fltTEPREV := fRetTEPREV(strTEPREV);

  If (fltFat_TE > 0) Then
    fltTEPREV := (fltTEPREV * fltFat_TE);

  fltTotGer := (fltQtdIte * fltTEPREV);
  fltTotCus := (fltQtdIte * FDataSet.FieldByName('ITE_PRECUS').AsFloat);
  fltTotMed := (fltQtdIte * FDataSet.FieldByName('ITE_PREMED').AsFloat);
  fltTotPes := (fltQtdIte * FDataSet.FieldByName('ITE_PESOIT').AsFloat);

  strDesIte := fRetDesIte;

  strAutIncFdo := '';
  Result := fGravaFatDor(strAutIncFdo,
                         FAutInc,
                         VS_strCodEmp,
                         FCliFil,
                         strLoginUsuarioLogado,
                         FDataSet.FieldByName('ITE_CODITE').AsString,
                         FDataSet.FieldByName('ITE_CODMAR').AsString,
                         '',
                         FNumDoc,
                         FEspDoc,
                         '',
                         VS_Date,
                         fTime(),
                         FConPagMsk,
                         FCliEst,
                         strDesIte,
                         FDataSet.FieldByName('ITE_REFERE').AsString,
                         FDataSet.FieldByName('ITE_CODUNI').AsString,
                         FDataSet.FieldByName('ITE_CODFOR').AsString,
                         fltQtdIte,
                         fltTEPREV,
                         fltTEPREV,
                         fltTEPREV,
                         fltTotGer,
                         fltTotGer,
                         fltTotCus,
                         fltTotMed,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         strLoginUsuarioLogado,
                         '',
                         0.0,
                         0.0,
                         0.0,
                         copy(VS_strClaVen,1,4),
                         '000',
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         fltTotGer,
                         0.0,
                         0.0,
                         0.0,
                         fltTotPes,
                         0.0,
                         0.0,
                         False,
                         '',
                         '',
                         '',
                         0,
                         '',
                         '',
                         0.0,
                         'NOR',
                         FDataSet.FieldByName('ITE_INCPIS').AsString,
                         strLoginUsuarioLogado,
                         FCndPgo,
                         '',
                         fGetForPag,
                         '',
                         '',
                         '',
                         '',
                         0.0,
                         0.0,
                         '',
                         0.0,
                         0.0,
                         0.0,
                         '',
                         '',
                         0,
                         'N',
                         '',
                         0.0,
                         intContador,
                         0.0,
                         fltTEPREV,
                         '',
                         0.0,
                         '',
                         '',
                         FALSE,
                         FTabPre,
                         '',
                         '',
                         '',
                         0.0,
                         '',
                         0.0,
                         strEntRet, //IIf(VS_strExpRetiraEntregaDocFat = 'T', 'E', VS_strExpRetiraEntregaDocFat),
                         '',
                         'N',
                         '',
                         0,
                         fltTotCus,
                         0,
                         0,
                         '',
                         '',
                         '',
                         False,
                         IIF(FEmpFat, VS_strCodEmp, ''),
                         '',
                         '',
                         '',
                         '',
                         '',
                         0,
                         0,
                         '',
                         '',
                         0,
                         '',
                         '',
                         0,
                         0,
                         FDataSet.FieldByName('ITE_PESOIT').AsFloat);

End;

function TGeraTransferencia.fRetstrTabPreTBPSUG(strTabCli: String): string;
var strTabSuj: String;
begin
  strTabSuj := fCfgSis('TBPSUG');

  If strTabSuj <> '0' Then
    Result := strTabSuj
  Else If Not fEmptyStr(strTabCli) Then
    Result := strTabCli
  Else If (fEmptyStr(strTabCli)) Then
  Begin
    If (Not fEmptyStr(fCfgSis('TBPRPD', varString))) Then
      Result := fCfgSis('TBPRPD', varString);
  End;
End;

Function TGeraTransferencia.fRetTabelaPreco(strCodCli: String): String;
  Var
    strTabPre,
    strTabCli: String;
Begin
  strTabPre := '1';
  strTabCli := fCampoTabela('CLI_TABPRE', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);

  If (fCfgSis('UTAPTB') <> '0') Then
    strTabPre := fCfgSis('UTAPTB')
  Else If fCfgSis('SUGTBP', varBoolean) Then
    strTabPre := fRetstrTabPreTBPSUG(strTabCli)
  Else If Not fEmptyStr(strTabCli) Then
    strTabPre := strTabCli
  Else If (fEmptyStr(strTabCli)) Then
  Begin
    If (Not fEmptyStr(fCfgSis('TBPRPD', varString))) Then
      strTabPre := fCfgSis('TBPRPD', varString);
  End;

  Result := strTabPre;
End;

function TGeraTransferencia.fGetForPag: String;
begin
  Result := IIF(fCfgSis('USAFPG', varBoolean), IIF(fEmptyStr(FForPag), '001', FForPag), '');
end;



end.
