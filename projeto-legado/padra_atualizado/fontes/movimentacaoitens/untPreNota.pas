unit untPreNota;

interface

Uses
  Classes,
  Controls,
  Uni,
  UniClientDataSet,
  Forms,
  Windows,
  DB,
  CxProgressBar,
  SysUtils,
  StrUtils,
  MaskUtils,
  untFuncoesSimples,
  untTypesSistema,
  untZClient,
  DBClient,
  untGravando,
  untLiberacao,
  untMsgLiberacao,
  untFuncoesGenerica,
  untMensagemExplicativa;

Type
  TRecItemNfe = Record
     strAutEle,
     strCodIte,
     strCodFab,
     strRefere,
     strDesIte,
     strSigUni,
     strCodEan,
     strPedNFE,
     strAplica: String;

     fltOrdem,
     fltSaldos,
     fltValIpi,
     fltSubNfe,
     fltValUni,
     fltQtdPro,
     fltQtdRes,
     fltTotGer,
     fltResPed: Double;

     intNroIte: Integer;
  End;

  TPreNota = Class(TZClient)
  Private

    objLiberacao : TLiberacao;

    stlPedidosNFE,
    stlEmpresasNFE,
    stlAutoincNFE: TStringList;

    qryPreBai: TUniQuery;

    cdsCriticas,
    cdsDefBai,
    cdsItemPed: TZClient;

    strCnvEmb,
    strCodFor: String;

    frmSelf: TForm;

    arrTipoFretePed: Array of Array[0..1] of String;

    stlEmpresas: TStringList;
    stlAutoinc: TStringList;

    FMostraItensSoPedido,
    FConverteEmbalagens: Boolean;

    qryEmpresas: TUniQuery;
    cdsPcmger: TZClient;

    cdsEmPreNota: TZClient;

    frmGravando: TfrmGravando;

    strAutIncPedEle : String;
    strEspDoc: String;
    fltTotNF_: Double;

    Function fTravaDestravaPedidos(blnTrava: Boolean = True): Boolean;
    Function fSQLCriticas: String;
    Function fSQLDefBai: String;
    Function fSQLPedidos: String;
    Function fAbreConsulta: Boolean;
    function fAbreConsultaPrg(cxProgresso: TCxProgressBar): Boolean;
    function fCalculaFretePedidos: Double;
    function fTipoFretePedido(strAutInc: String): String;
    Function fSqlItensPedido(blnGrupoPreco: Boolean = False): String;
    Function fCarregaItensNotaEletronica: Boolean;
    Function fCarregaItensPedido: Boolean;
    //Function fRetQtdPed(strCodIte: String): Double;

    Function fChecaPedidosRepetidos(strPedidos: String): Boolean;

    Procedure pAfterScrollPedidos(dataSet: TDataSet);

    Function fSQLPreBai: String;

    Function fPosssuiInconsistencias(prcFiltro: TFilterRecordEvent = Nil; blnGravarItensSeparados: Boolean = False): Boolean;
    function fRetCdsInconsistenciaCadastrais : TUniClientDataSet;

    function fPosssuiInconsistenciasFrete : Boolean;
    function fCnpjTransportadoraDiferente(strNumped: string = ''): Boolean;

    Procedure pIncluiDefBai(strGerEle, strAutEle, strAutPcd, strAutPcg: String; fltQtdBai: Double);

    Procedure pAdicionaPedidosNFE;

    procedure pMostraConPagPedidos;
    Procedure pDeterminaBaixa;
    procedure pInsereItensCdsCriticas(blnGravarItensSeparados: Boolean = False);


    procedure pVerificaItensComProblemasCadastro;

    procedure pIncluiCritica(strCodIte,
                             strDesIte,
                             strDesUni,
                             strCodFab,
                             strLocFis: String;
                             fltQtdPed,
                             fltQtdNfe,
                             fltQtdRes,
                             fltSaldos,
                             fltUniPed,
                             fltUniNfe,
                             fltTotGer,
                             fltIpiPed,
                             fltIpiNfe,
                             fltSubPed,
                             fltSubNfe,
                             fltFrePed,
                             fltFreNfe: Double;
                             strNfeEan,
                             strTraPed,
                             strTraXml,
                             strNFE,
                             strNumPed: String;
                             blnInserirTodosItens: Boolean = False;
                             strOrdNROITE: String = '' );

    procedure OnFilterRecordDifTolerancia(DataSet: TDataSet; var Accept: Boolean);

    procedure pOnFilterRecordDifTolerancia(DataSet: TDataSet; var Accept: Boolean; blnComFrete: Boolean);

    procedure OnFilterRecordErros(DataSet: TDataSet; var Accept: Boolean);
    procedure OnFilterRecordDifToleranciaFrete(DataSet: TDataSet; var Accept: Boolean);

    Procedure pAdicionaItensSoPedido(intNroIte: Integer; blnTodos: Boolean);

    Procedure pIncluiPreBaixaPedido;

    Function fPosssuiInconsistenciaCondPagto: Boolean;

    Procedure pSalvaEmbalagensProduto;
    Function fTemDefinicaoDeBaixa: Boolean;
    Function fTemDefinicaoParaOPedido(strPedido: String): Boolean;

    procedure pMostraMemo(stlIncon: TStrings);

    function fVerificaItensComPrecoDivergentesPedidos: Boolean;

    function fPedidoDeterminadoNoXML(strCodIte: String): Boolean;

    Procedure pAdicionaPedidoNaLista(strNumPed, strEmpres, strAutInc: String);

    function fPedeCotacaoMoeda: Boolean;

    function fDigDadosContaPagar: Boolean;
    Function fValidaGravacaoItens(strAutIncGerele: String; out stlErro: TStringList): Boolean;
    Function fValidaPEDELE(strAutIncGerele: String; out stlErro: TStringList): Boolean;

  Public
    objMotivos: TStringList;

    blnCotDor,
    blnPedidosEmDolar,
    blnTemItemSemPedido,
    blnPedidosPreDefinidos: Boolean;
    blnEXSIDV: Boolean;

    fltFrePed: Double;
    blnLimparLista: Boolean;
    stlPedidos: TStringList;

    cdsPedidos: TZClient;

    recNotEle: TRecInfoNotaEletronica;

    strCTLEST,
    strDecQua,
    strDecUni: String;

    intDecQua,
    intDecUni: Integer;

    fltCotMoe,
    fltOciVlr : Double;
    fltOciQtd : Double;
    blnPedidoGeradoAuto : Boolean;
    arrDuplicata: TarrDuplicata;
    function fAdicionarMotivos(strMotivo: String): TPreNota;
    function fApagarMotivos : TPreNota;
    procedure pCarregaListPedidos(strNumPed: String);

    constructor Create(Owner: TComponent); Reintroduce; Overload;
    class Function fTraduzFrete(strFreNFe : String) : String;

    Destructor Destroy; override;

    Function fValidaEmpresas: Boolean;

    function fCarregaNFE(strAutoincrem: String): boolean;
    Function fSelecionaNFE: Boolean;
    Function fCarregaPedidosNotaEletronica(strAutEle: String): Boolean;

    Function fSelecionaPedidos: Boolean;

    Function fValidaPedido(strNumPed: String;
        blnConverteEmbalagens,
        blnMostraItensSoPedido,
        blnTestarEmpDestino: Boolean;
        Var blnMaisDeUm: boolean): Boolean;

    Function fConfirma: Boolean;
    Function fJaExistePedEleParaANota: Boolean;

    Class Procedure pExcluiPreBaixa(strAutEle: String);
    Class Function fPossuiPreBaixa(strAutEle: String): Boolean;

    Procedure pClose(blnReiniciar: Boolean);
    procedure pMostraCriticas;

    Procedure pConsultaItensPreNota;

    Procedure pVerificaPedidoEmDolar;
  End;

implementation
{$R+}

uses
  Variants,
  untFuncoesConsulta, untConsultas, Math, untTipoFreteAtc, untFuncFat,
  untConstantes, untEntConferenciaFuncoes, untEntConfPedidos,
  untEntPreNotaEntradaMotivoLib, untRelEntCriticasPreNota, untEntDadosFiscaisResumo,
  untFuncoesPedidoSimples, untFuncoes, untSelecionaPedidoRep,
  untTypesCRM, untAtualizaOcorrenciasCRM, untMemo, Graphics, untVinculoBaixaEntregaFuturaEdocVenda,
  untPedeCotacaoMoeda, untFuncoesRel, untFuncoesRel2, untPanelCxPreNota, untPnlDadosPreNota,
  untDefineBaixaPedido;

constructor TPreNota.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, '');
  objMotivos := TStringList.Create;

  blnPedidoGeradoAuto := False;

  blnPedidosEmDolar := False;

  fltCotMoe := 0;

  blnEXSIDV := fCfgSis('EXSIDV', varBoolean);
  blnCotDor := fCfgSis('COTDOR', varBoolean);
  intDecQua := fCfgSis('DEQTPC', varInteger);
  strDecQua := IntToStr(intDecQua);

  intDecUni := fCfgSis('DECUNI', varInteger);
  strDecUni := IntToStr(intDecUni);

  strCtlEst := fCfgSis('CTLEST');

  objLiberacao := TLiberacao.create;

  strCnvEmb := fCfgSis('CNVEMB');

  qryEmpresas := fCriaQuery(Self);
  qryEmpresas.SQL.Text := 'SELECT EMP_CODEMP AS CODEMP FROM CADEMP';

  cdsPcmger := TZClient.Create(Self);

  blnPedidosPreDefinidos := False;
  blnTemItemSemPedido    := False;

  frmSelf := TForm(Owner);

  stlPedidos  := TStringList.Create;
  stlEmpresas := TStringList.Create;
  stlAutoinc  := TStringList.Create;

  stlPedidosNFE  := TStringList.Create;
  stlEmpresasNFE := TStringList.Create;
  stlAutoincNFE  := TStringList.Create;

  cdsPedidos  := TZClient.Create(Self);
  cdsItemPed  := TZClient.Create(Self);
  cdsDefBai   := TZClient.Create(Self, fSQLDefBai);
  cdsDefBai.IndexFieldNames := 'DEF_AUTELE';

  cdsCriticas := TZClient.Create(Self, fSQLCriticas);

  qryPreBai := fCriaQuery;
  qryPreBai.SQL.Text := fSQLPreBai;

  SetLength(arrTipoFretePed, 0);

  blnLimparLista := False;

  fltOciVlr := fCfgSis('OCIVLR', varDouble);
  If not fCfgSis('VALOCI', varBoolean) Then
    fltOciVlr := 0;

  fltOciQtd := fCfgSis('OCIQTD', varDouble);

  cdsEmPreNota := TZClient.Create(Self);
End;

Destructor TPreNota.Destroy;
Begin
  Inherited;

  SetLength(arrTipoFretePed, 0);

  FreeAndNil(objMotivos);
  FreeAndNil(stlPedidos);
  FreeAndNil(stlEmpresas);
  FreeAndNil(stlAutoinc);
  FreeAndNil(objLiberacao);

  FreeAndNil(stlPedidosNFE);
  FreeAndNil(stlEmpresasNFE);
  FreeAndNil(stlAutoincNFE);
  If Assigned(frmVinculoBaixaEntregaFuturaEdocVenda) Then
    FreeAndNil(frmVinculoBaixaEntregaFuturaEdocVenda);

End;

class function TPreNota.fTraduzFrete(strFreNFe: String): String;
begin
       if strFreNfe = '0' Then Result := '1'
  Else if strFreNfe = '1' Then Result := '2'
  Else if strFreNfe = '2' Then Result := '3'
  Else if strFreNfe = '3' Then Result := '4'
  Else if strFreNfe = '4' Then Result := '5'
  Else                         Result := '9';
end;

Function TPreNota.fCarregaNFE(strAutoincrem: String) : boolean;
var
  qryGERELE : TUniQuery;
  stlAliquotas: TStringList;
  intContador: Integer;
begin
  Result := False;
  strAutIncPedEle := '';
  strEspDoc := '';
  fltTotNF_ := 0;
  blnPedidosPreDefinidos := False;

  qryGERELE := fCriaQuery(nil);
  try
    qryGERELE.SQL.Add('SELECT                              ');
    qryGERELE.SQL.Add('  *,                                ');
    qryGERELE.SQL.Add(IIF(fSeparaICMDesoneradoDoDesconto, fSQLDescontoNotaXMLSemDesonerado, fSQLDescontoNotaXML) + ' AS DESCONTO, ');
    qryGERELE.SQL.Add(fSQLICMSDesoneradoEstaNoDescontoComercial + ' AS ICMSDesoneradoEstaNoDescontoComercial ');

    qryGERELE.SQL.Add('FROM                                ');
    qryGERELE.SQL.Add('  GERELE                            ');
    qryGERELE.SQL.Add('WHERE                               ');
    qryGERELE.SQL.Add('  AUTOINCREM = :AUTOINCREM          ');

    qryGERELE.ParamByName('AUTOINCREM').AsString := strAutoincrem;
    qryGERELE.Open;


    recNotEle.fltValDes := qryGERELE.FieldByName('DESCONTO').AsFloat;

    recNotEle.fltDesPis := 0;


    if not qryGERELE.isEmpty then
    begin


      recNotEle.fltDesPis := 0;

      If (recNotEle.fltValDes > 0) And fSeparaICMDesoneradoDoDesconto Then
      Begin
        stlAliquotas := TStringList.Create;
        stlAliquotas.Text := AnsiReplaceStr(fCfgSis('PISCOF'), '-', #13#10);

        For intContador := 0 To stlAliquotas.Count - 1 Do
          If RoundTo(recNotEle.fltValDes, -2) >= RoundTo(StrToFloatDef(stlAliquotas[intContador], 0) * qryGERELE.FieldByName('W07_VPROD').AsFloat / 100, -2) Then
          Begin
            recNotEle.fltDesPis := RoundTo(StrToFloatDef(stlAliquotas[intContador], 0) * qryGERELE.FieldByName('W07_VPROD').AsFloat / 100, -2);
            Break;
          End;

        recNotEle.fltValDes := recNotEle.fltValDes - recNotEle.fltDesPis;

        FreeAndNil(stlAliquotas);
      End;
      recNotEle.blnICMSDesoneradoEstaNoDescontoComercial := qryGERELE.FieldByName('ICMSDesoneradoEstaNoDescontoComercial').AsInteger = 1;

      recNotEle.fltICMDes := qryGERELE.FieldByName('W04A_VICMSDESON').AsFloat;

      recNotEle.strAutInc := qryGERELE.FieldByName('AUTOINCREM').AsString;
      recNotEle.strCodFor := qryGERELE.FieldByName('GER_CODFOR').AsString;
      recNotEle.strCodCli := qryGERELE.FieldByName('GER_CODCLI').AsString;
      recNotEle.strTip_FC := qryGERELE.FieldByName('GER_TIP_FC').AsString;
      recNotEle.strNumDoc := qryGERELE.FieldByName('B08_NNF').AsString;
      recNotEle.strSerDoc := qryGERELE.FieldByName('B07_SERIE').AsString;
      recNotEle.fltValFre := qryGERELE.FieldByName('W08_VFRETE').AsFloat;
      recNotEle.fltOutras := qryGERELE.FieldByName('W15_VOUTRO').AsFloat;
      recNotEle.fltValSeg := qryGERELE.FieldByName('W09_VSEG').AsFloat;

      recNotEle.dtaDtaDoc := qryGERELE.FieldByName('B09_DEMI').AsDateTime;
      recNotEle.str_Chave := qryGERELE.FieldByName('PR07_CHNFE').AsString;
      recNotEle.fltPesLiq := qryGERELE.FieldByName('X31_PESOL').AsFloat;
      recNotEle.fltPesBru := qryGERELE.FieldByName('X32_PESOB').AsFloat;
      recNotEle.strConPag := qryGERELE.FieldByName('GER_CONPAG').AsString;
      recNotEle.strModFre := qryGERELE.FieldByName('X33_MODFRETE').AsString;

      recNotEle.TipoCfop := tcCFOPNormal;
      If fRetTemCFO_922(recNotEle.strAutInc, 'DETELE') Then
        recNotEle.TipoCfop := tcCFOP922
      Else If fRetTemCFO_117_116(recNotEle.strAutInc, 'DETELE') Then
        recNotEle.TipoCfop := tcCFOP117;

      recNotEle.fltQtdVol := qryGERELE.FieldByName('X27_QVOL').AsFloat;
      recNotEle.strEspVol := qryGERELE.FieldByName('X28_ESP').AsString;
      recNotEle.fltCotDol := qryGERELE.FieldByName('GER_COTMOE').AsFloat;

      recNotEle.strCnpjTr := qryGERELE.FieldByName('X34_CNPJ').AsString;
      fCarregaTransportadoraPeloCnpj(recNotEle.strCnpjTr, recNotEle.strCodTra, recNotEle.strNomTra);

      recNotEle.strNotas  := qryGERELE.FieldByName('B08_NNF').AsString + ' - ' +
                             qryGERELE.FieldByName('GER_CODFOR').AsString + '-' +
                             fRetNomFornecedor(qryGERELE.FieldByName('GER_CODFOR').AsString);

      recNotEle.finalidadeXML := tpeFinalidadeXML(qryGERELE.FieldByName('GER_TIPXML').AsInteger);
      strEspDoc          := qryGERELE.FieldByName('GER_ESPENT').AsString;
      fltTotNF_          := qryGERELE.FieldByName('W16_VNF').AsFloat;
      recNotEle.blnEhNotaImportacao := fVerificarSeEhNotaImportacao(strAutoincrem);

      If Not fLock_Unlock('NFE' + strAutoincrem, True, False, True) Then
      Begin
        fMensagem('', 'Esse Documento está sendo utilizado em outra Estação por ' +
                      fGetHostLock('NFE' + recNotEle.strAutInc)  + '!', ['&Ok']);

        Result := False;
        Exit;
      End;

      If recNotEle.TipoCfop = tcCFOP117 Then
      begin
        Try
          If Assigned(frmVinculoBaixaEntregaFuturaEdocVenda) Then
            FreeAndNil(frmVinculoBaixaEntregaFuturaEdocVenda);
          Result := False;
          If TfrmVinculoBaixaEntregaFuturaEdocVenda.fVincularX922_x117(recNotEle.strAutInc, (fCfgSis('CNVEMB') <> 'N'), True) Then
            Result := fCarregaPedidosNotaEletronica(recNotEle.strAutInc);
          If not Result Then
          Begin
            FreeAndNil(frmVinculoBaixaEntregaFuturaEdocVenda);
            fMensagem('', 'Os documentos x117 e x116 devem estar atrelados a documentos de entrada x922 ou x933!', ['&Ok']);
            fTravaDestravaPedidos(False);
            Exit;
          End;
          If not Result Then
            fTravaDestravaPedidos(False);
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[TPreNota.fSelecionaNFE]');
            Result := false;
            fTravaDestravaPedidos(False);
          End;
        End;
      End
      Else
        Result := fCarregaPedidosNotaEletronica(recNotEle.strAutInc);
      recNotEle.strTipFre := fTraduzFrete(recNotEle.strModFre);
    end;

  finally
    //fLock_Unlock('NFE' + strAutoincrem, False);

    FreeAndNil(qryGERELE);
  end;
end;

Function TPreNota.fSelecionaNFE: Boolean;
  Var
    chrKey: Char;
    arrPreNota: TConsultasArray;
    strAutoincrem : String;

    objfrmPnl: TPanelCxPreNota;

begin
  Result := False;
  chrKey := '/';
  objfrmPnl := TPanelCxPreNota.Create(TfrmPnlDadosPreNota);
  Try
    FillChar(recNotEle, SizeOf(recNotEle), #0);
    if fPesqGerelePreNotaEntrada(frmSelf,  nil, strAutoincrem, chrKey, arrPreNota, True, False, objfrmPnl) then
      Result := fCarregaNFE(strAutoincrem);
  Finally
    FreeAndNil(objfrmPnl);
  End
end;

Procedure TPreNota.pClose(blnReiniciar: Boolean);
Begin
  Close;

  If blnReiniciar Then
  Begin
    fTravaDestravaPedidos(False);

    FillChar(recNotEle, SizeOf(recNotEle), #0);
    stlPedidos.Clear;
    stlAutoInc.Clear;
    stlEmpresas.Clear;

    stlPedidosNFE.Clear;
    stlAutoIncNFE.Clear;
    stlEmpresasNFE.Clear;

  End;

  pMostraConPagPedidos;
End;

Procedure TPreNota.pVerificaPedidoEmDolar;
Begin
  blnPedidosEmDolar := (stlAutoinc.Count > 0) And blnCotDor And (fCampoTabela('PCG_MOEDA_', 'PCMGER', ['AUTOINCREM'], [stlAutoinc[0]]) = INT_MOEDA_DOLAR);
End;

Function TPreNota.fSelecionaPedidos: Boolean;
  Var
    objConEnt: TConfereEntrada;
    stlRegSel: TStringList;
    frmEntConfPedidos: TfrmEntConfPedidos;
begin
  Result := False;

  stlRegSel := TStringList.Create;
  objConEnt := TConfereEntrada.Create(stlPedidos, stlEmpresas);
  objConEnt.strCodFor := recNotEle.strCodFor;
  pCriarFormularios(TfrmEntConfPedidos, frmEntConfPedidos);

  Try
    frmEntConfPedidos.blnPreNota := True;
    frmEntConfPedidos.blnSalvaFornecedor := False;
    frmEntConfPedidos.strCodFor := recNotEle.strCodFor;
    frmEntConfPedidos.blnSelGarantia := (recNotEle.finalidadeXML = xmlGarantiaRetFornecedor);

    If frmEntConfPedidos.blnSelGarantia Then
       frmEntConfPedidos.blnSelGarantia :=  fCfgSis('REFENT', varBoolean);


    frmEntConfPedidos.objConEnt := objConEnt;
    frmEntConfPedidos.stlRegSel := stlRegSel;

    If frmEntConfPedidos.ShowModal = mrOK Then
    Begin
      stlAutoinc.Text  := frmEntConfPedidos.stlListSelecao.Text;
      stlPedidos.Duplicates := dupIgnore;

      objConEnt.pRetListaPedidos(stlPedidos, stlEmpresas, stlAutoinc, frmEntConfPedidos.cdsConsulta);

      If blnPedidosPreDefinidos Then
        pAdicionaPedidosNFE;

      Result := True;
    End;

  Finally
    FreeAndNil(stlRegSel);
    FreeAndNil(objConEnt);
    FreeAndNil(frmEntConfPedidos);
  End;

end;

Procedure TPreNota.pAdicionaPedidosNFE;
  Var
    intPedSel, intPedNFE: Integer;
    blnAchou: Boolean;
Begin

  For intPedNFE := 0 To stlPedidosNFE.Count - 1 Do
  Begin
    blnAchou := False;

    For intPedSel := 0 To stlPedidos.Count - 1 Do
      If (stlPedidosNFE[intPedNFE]  = stlPedidos[intPedSel]) And
         (stlEmpresasNFE[intPedNFE] = stlEmpresas[intPedSel]) And
         (stlAutoincNFE[intPedNFE]  = stlAutoinc[intPedSel]) Then
      Begin
        blnAchou := True;
        Break;
      End;


    If Not blnAchou Then
    Begin
      stlPedidos.Add(stlPedidosNFE[intPedNFE]);
      stlEmpresas.Add(stlEmpresasNFE[intPedNFE]);
      stlAutoinc.Add(stlAutoincNFE[intPedNFE]);
    End;

  End;

End;


function TPreNota.fAdicionarMotivos(strMotivo: String): TPreNota;
begin
  Result := Self;
  if Not fEmptyStr(strMotivo)  then
    objMotivos.Add(strMotivo);
end;

Procedure TPreNota.pAdicionaPedidoNaLista(strNumPed, strEmpres, strAutInc: String);
  Var
    intPedSel: Integer;
Begin
  For intPedSel := 0 To stlPedidos.Count - 1 Do
    If (strNumPed  = stlPedidos[intPedSel]) And
       (strEmpRes = stlEmpresas[intPedSel]) And
       (strAutInc  = stlAutoinc[intPedSel]) Then
      Exit;

  stlPedidos.Add(strNumPed);
  stlEmpresas.Add(strEmpres);
  stlAutoinc.Add(strAutInc);
 End;


procedure TPreNota.pCarregaListPedidos(strNumPed: String);
var qry: TUniQuery;
begin
  qry := fCriaQuery;
  Try
    qry.SQL.Text :='SELECT  * FROM PCMGER WHERE PCG_NUMPED IN ('+strNumPed+') AND PCG_CODEMP = "'+VS_strCodEmp+'" AND PCG_ESPDOC = "PD"';
    qry.Open;
    while not qry.Eof Do
    Begin
      stlPedidos.Add(qry.FieldByName('PCG_NUMPED').AsString);
      stlEmpresas.Add(qry.FieldByName('PCG_CODEMP').AsString);
      stlAutoinc.Add(qry.FieldByName('AUTOINCREM').AsString);
      qry.Next;
    End;
  Finally
    FreeAndNil(qry);
  End;
End;

function TPreNota.fValidaPEDELE(strAutIncGerele: String; out stlErro: TStringList): Boolean;
  Var
    qryAux: TUniQuery;
Begin
  If fEmptyStr(strAutIncGerele) Then
    Exit(False);

  qryAux := fCriaQuery(Nil);
  try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT COUNT(1) AS QTD ');
    qryAux.SQL.Add('  FROM GERELE ');
    qryAux.SQL.Add(' INNER JOIN PEDELE ON PEL_SEQELE = GERELE.AUTOINCREM ');
    qryAux.SQL.Add(' WHERE TRUE ');
    qryAux.SQL.Add(' AND GERELE.AUTOINCREM = ' + QuotedStr(strAutIncGerele));
    qryAux.Open;

    {se zero, não gerou registro na PEDELE}
    Result := (qryAux.FieldByName('QTD').AsInteger > 0);
    If Not Result Then
    Begin
      stlErro.Add('Houve uma inconsistência na gravação dos vínculos dos pedido de compra com a da Nota Fiscal, entre contato com a Citel!');
      Exit;
    End;

    If Result Then
    Begin
      //VALIDA SE TODOS OS PEDIDOS QUE FORAM GERADOS NA 'DEFBAI' FORAM GERADOS NA 'PEDELE'.
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(' SELECT ');
      qryAux.SQL.Add('   PCMGER.PCG_NUMPED, ');
      qryAux.SQL.Add('   PCMGER.PCG_ESPDOC, ');
      qryAux.SQL.Add('   PCMGER.PCG_CODEMP, ');
      qryAux.SQL.Add('   PCMGER.PCG_CODFOR, ');
      qryAux.SQL.Add('   P.PEL_SEQELE ');
      qryAux.SQL.Add(' FROM ');
      qryAux.SQL.Add('   DEFBAI D ');
      qryAux.SQL.Add(' INNER JOIN PCMGER   ON PCMGER.AUTOINCREM = D.DEF_AUTPCG ');
      qryAux.SQL.Add('  LEFT JOIN PEDELE P ON P.PEL_SEQELE = D.DEF_GERELE AND PEL_NUMDOC = PCMGER.PCG_NUMPED AND PEL_ESPDOC = PCMGER.PCG_ESPDOC AND PEL_CODEMP = PCMGER.PCG_CODEMP AND PEL_CODFOR = PCMGER.PCG_CODFOR ');
      qryAux.SQL.Add(' WHERE ');
      qryAux.SQL.Add('   D.DEF_GERELE = ' + QuotedStr(strAutIncGerele));
      qryAux.SQL.Add('   AND P.AUTOINCREM IS NULL ');
      qryAux.SQL.Add(' GROUP BY ');
      qryAux.SQL.Add('   PCMGER.PCG_NUMPED, PCMGER.PCG_ESPDOC, PCMGER.PCG_CODEMP, PCMGER.PCG_CODFOR; ');
      qryAux.Open;

      // SE RETORNAR VAZIO, TUDO ESTÁ CORRETO. SE RETORNAR UM VALOR, É PORQUE HOUVE UM PEDIDO QUE NÃO GEROU A 'PEDELE'.
      Result := qryAux.IsEmpty;
      if not Result Then
      Begin
        qryAux.First;
        stlErro.Add('Erro ao gerar registros na Pedele.');
        stlErro.Add('O(s) pedido(s) ficaram sem registro. Por favor, entre em contato com a Citel.');
        stlErro.Add('-----------------------------------------------------------------------------');

        while Not qryAux.eof do
        Begin
          stlErro.Add(Format( 'O PEDIDO: %s - %s - %s - Cód. Fornecedor: %s ',
                             [qryAux.FieldByName('PCG_NUMPED').AsString,
                              qryAux.FieldByName('PCG_ESPDOC').AsString,
                              qryAux.FieldByName('PCG_CODEMP').AsString,
                              qryAux.FieldByName('PCG_CODFOR').AsString]));
          qryAux.Next;
        End;
      End;
    End;

  finally
    FreeAndNil(qryAux);
  end;
end;

Function TPreNota.fValidaPedido(strNumPed: String;
        blnConverteEmbalagens,
        blnMostraItensSoPedido,
        blnTestarEmpDestino: Boolean;
        Var blnMaisDeUm: boolean): Boolean;
  Var
    Index,
    intContador: Integer;
    blnBonificacao,
    blnLiberado,
    blnConferido,
    blnBaixado,
    blnOriundo,
    blnImportado,
    blnOriundoImportacaoNotaEletronica: Boolean;
    strEmpDes,
    strEmpres,
    strPreNot,
    strAutInc: String;


   Function fPedidoOk(strNumPed, strCodEmp: String): Boolean;
   Begin
      Result := True;

      If fEhPedidoCompraMultiLoja(strNumPed, 'PD', strCodEmp) Then
      Begin
        If Not fCfgSis('PDCGTR', varBoolean) Then
        Begin
          pMensagemOk('O pedido de compra ' + strNumPed + '-' + strCodEmp + ' é multi-loja e deve ser desmembrado para utilização!');
          Result := FALSE;
        End;
      End

      Else If (strCodFor <> recNotEle.strCodFor) And
              (Not fVeSeAtualizaPedidoCompra(strNumPed, strCodEmp, recNotEle.strCodFor, strCodFor, False)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fornecedor do Pedido e da NFe são diferentes!', ['&O k']);
        Result := FALSE;
      End

      Else If blnConferido Then
      Begin
        fMensagem('ATENÇÃO!', 'O pedido de compra ' + strNumPed + '-' + strCodEmp + ' já foi conferido!', ['&O k']);
        Result := FALSE;
      End

      Else If (Not blnLiberado) And fCfgSis('LIBPCM', varBoolean) Then
      Begin
        fMensagem('ATENÇÃO!', 'O pedido de compra ' + strNumPed + '-' + strCodEmp + ' não está liberado!', ['&O k']);
        Result := FALSE;
      End

      Else If blnBaixado Then
      Begin
        fMensagem('ATENÇÃO!', 'O pedido de compra  ' + strNumPed + '-' + strCodEmp + ' está baixado!', ['&O k']);
        Result := False;
      End

   End;

Begin
  Result := True;

  blnMaisDeUm := False;

  FConverteEmbalagens  := blnConverteEmbalagens;
  FMostraItensSoPedido := blnMostraItensSoPedido;

  blnLimparLista := False;

  cdsPedidos.Close;

  If Not fEmptyStr(strNumPed) Then
  Begin

    If Not fPedidoCompraCadastrado(strNumPed, VS_strCodEmp, 'PD', blnBonificacao,
            blnLiberado, blnConferido, blnBaixado, blnOriundo, blnImportado, blnMaisDeUm,
            strEmpDes, strEmpres, strCodFor, strPreNot, strAutInc, blnOriundoImportacaoNotaEletronica, blnTestarEmpDestino) Then
    Begin
      fMensagem('ATENÇÃO!', 'O pedido de compra ' + strNumPed + '-' + Vs_strCodEmp + ' não está cadastrado!', ['&O k']);
      Result := FALSE;
    End

    Else If (Not fCfgSis('REFENT', varBoolean)) And fPedidoDeCompraOriundoDeGarantia(strNumPed, VS_strCodEmp) Then
    Begin
      fMensagem('ATENÇÃO!', 'O pedido de compra é de garantia - o processo deve ser feito pela rotina "Retorno do Fornecedor"', ['&O k']);
      Result := FALSE;
    End

    Else If blnMaisDeUm Then
    Begin
      Result := FALSE;
    End

    Else Result := fPedidoOk(strNumPed, VS_strCodEmp);

    If Result And (Not blnPedidosPreDefinidos) Then
    Begin
      blnLimparLista := True;
    End;

    If blnPedidosPreDefinidos Then
    Begin
      stlPedidos.Clear;
      stlEmpresas.Clear;
      stlAutoinc.Clear;

      pAdicionaPedidosNFE;
      pAdicionaPedidoNaLista(strNumPed, strEmpres, strAutInc);
    End;

  End

  Else If stlPedidos.Count = 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhum pedido selecionado!', ['&O k']);
    Result := FALSE;
    stlAutoinc.Clear;
  End

  Else If blnPedidosPreDefinidos Then
  Begin

    For intContador := 0 To stlPedidos.Count - 1 Do
    Begin
      If Not fPedidoCompraCadastrado(stlPedidos[intContador],
                                 stlEmpresas[intContador],
                                 'PD', blnBonificacao, blnLiberado, blnConferido, blnBaixado,
                                 blnOriundo, blnImportado, blnMaisDeUm, strEmpDes,
                                 strEmpres, strCodFor, strPreNot, strAutInc, blnOriundoImportacaoNotaEletronica) Then
      Begin
         fMensagem('ATENÇÃO!', 'O pedido de compra ' + stlPedidos[intContador] + '-' + stlEmpresas[intContador] + ' não está cadastrado!', ['&O k']);
         Result := FALSE;
      End

      Else Result := fPedidoOk(stlPedidos[intContador], stlEmpresas[intContador]);

      If Not Result Then
      Begin
        stlPedidosNFE.Find(stlPedidos[intContador], Index);
        If Index >= 0 Then
          stlPedidosNFE.Delete(Index);
        stlPedidos.Delete(intContador);
        stlEmpresas.Delete(intContador);
        Break;
      End;
    End;

  End Else
  Begin
    fPedidoCompraCadastrado(stlPedidos[0], VS_strCodEmp, 'PD', blnBonificacao, blnLiberado, blnConferido, blnBaixado,
                            blnOriundo, blnImportado, blnMaisDeUm, strEmpDes, strEmpres, strCodFor, strPreNot, strAutInc, blnOriundoImportacaoNotaEletronica);
  End;

  If Result Then
  Begin

    If (stlPedidos.Count = 0) Then
    Begin
      stlEmpresas.Clear;
      stlPedidos.Add(strNumPed);
      stlEmpresas.Add(strEmpres);
      stlAutoinc.Add(strAutInc);
    End;

  End;

  fTravaDestravaPedidos(False);

  Result := Result And fTravaDestravaPedidos And fAbreConsulta;

  If Result Then
    pMostraConPagPedidos;
End;

Function TPreNota.fTravaDestravaPedidos(blnTrava: Boolean = True): Boolean;
  Var
    intContador: Integer;
Begin
  Result := True;

  If Not fEmptyStr(recNotEle.strAutInc) Then
    fLock_Unlock('NFE' + recNotEle.strAutInc, blnTrava, False, True);

  For intContador := 0 To stlPedidos.Count - 1Do
    If Not fTravaDestravaPedidoCompra(blnTrava, stlPedidos[intContador], 'PD', stlEmpresas[intContador]) Then
    Begin
      Result := False;
      Exit;
    End;
End;

procedure TPreNota.pMostraConPagPedidos;
Begin
  With cdsPedidos Do
  Begin
    qryQuery.SQL.Text := fSQLPedidos;

    If fEmptyStr(qryQuery.SQL.Text) Then
      Close
    Else
    Begin
      fAbreClient(True, 'TfrmEntPreNotaEntrada.pMostraConPagPedidos');

      pAlinhaCampoCentro('NUMPED');
      pAlinhaCampoCentro('CODEMP');

      While Not Eof Do
      Begin
        Edit;
        FieldByName('PRAMED').AsFloat := fCalcMediaPagto(FieldByName('CONPAG').AsString);
        Post;

        Next;
      End;
    End;

  End;
End;

Function TPreNota.fSQLPedidos: String;

  Function fSQLPedido(strNumPed, strCodEmp: String): String;
  Begin
    Result := '';
    Result := Result + ' SELECT';
    Result := Result + '   PCG_NUMPED AS NUMPED, ';
    Result := Result + '   PCG_CODEMP AS CODEMP, ';
    Result := Result + '   PCG_CONPAG AS CONPAG, ';
    Result := Result + '   0.00       AS PRAMED, ';
    Result := Result + '   TRA_C_G_C_ AS TRAPED, ';
    Result := Result + '   PCG_DTAFAT AS DTAPRE, ';
    Result := Result + '   @DIASDIF := DATEDIFF(PCG_DTAFAT, CURDATE()) AS  DIF, ';
    Result := Result + '   CAST(IF(@DIASDIF > 0, CONCAT("ADIANTADO ", @DIASDIF, " DIA(S)"), ';
    Result := Result + '                    IF(@DIASDIF < 0, CONCAT("ATRASADO ",  @DIASDIF * -1, " DIA(S)"), ';
    Result := Result + '                   "SEM ATRASO")) AS CHAR(255)) AS DIVPRE,  ';
    Result := Result +  fRetSQLDescricaoFrete('PCG_TIPFRE') + ' AS TIPFRE ';
    Result := Result + ' FROM PCMGER ';
    Result := Result + ' LEFT JOIN CADTRA T ON T.TRA_CODTRA = PCG_CODTRA ';
    Result := Result + ' WHERE       ';
    Result := Result + '   PCG_CODEMP = ' + QuotedStr(strCodEmp) + ' AND  ';
    Result := Result + '   PCG_NUMPED = ' + QuotedStr(strNumPed) + ' ';
  End;

  Var
    intContador: Integer;
Begin
  Result := '';
  For intContador := 0 To stlPedidos.Count - 1 Do
  Begin
    If intContador <> 0 Then
      Result := Result + ' UNION ALL ';

    Result := Result + fSQLPedido(stlPedidos[intContador], stlEmpresas[intContador]);
  End;
End;

function TPreNota.fPedeCotacaoMoeda: Boolean;
Begin
  Result := TfrmPedeCotacaoMoeda.fPedeCotacaoMoeda(fltCotMoe, infoNFE);
End;

function TPreNota.fAbreConsulta: Boolean;
Begin
  Result := True;

  Self.DisableControls;

  pVerificaPedidoEmDolar;

  If blnPedidosEmDolar Then
    Result := fPedeCotacaoMoeda;

  Try
    Result := Result And TfrmGravando.fExecuta(fAbreConsultaPrg, frmGravando, 'Aguarde...');

    If Not Result Then
      blnPedidosEmDolar := False;

  Finally
    Self.EnableControls;
  End;

  blnPedidoGeradoAuto := False;

End;

function TPreNota.fAbreConsultaPrg(cxProgresso: TCxProgressBar): Boolean;
  Var
    intIndex : Integer;
Begin

  frmGravando.lblGravando.Caption := 'Verificando divergência de preços entre pedidos...';
  Application.ProcessMessages;

  Result := fCarregaItensNotaEletronica And
            fCarregaItensPedido;

  If Result Then
  Begin
    fltFrePed := fCalculaFretePedidos;

    //Preenche Lista com o Tipo de Frete dos Pedidos.
    SetLength(arrTipoFretePed,0);
    SetLength(arrTipoFretePed, stlPedidos.Count);
    For intIndex := 0 to stlPedidos.Count -1 Do
    Begin
      arrTipoFretePed[intIndex][0] := stlPedidos[intIndex];

      If stlAutoinc.Count > intIndex Then
        arrTipoFretePed[intIndex][1] := fTipoFretePedido(stlAutoinc[intIndex])
      Else
        arrTipoFretePed[intIndex][1] := '';
    End;

    pDeterminaBaixa;

    Result := fVerificaItensComPrecoDivergentesPedidos;
  End;

End;

Function TPreNota.fCarregaItensNotaEletronica: Boolean;
  Var
    strEmbala,
    strSQL: String;
Begin
  Result := False;

  IndexFieldNames := '';

  If fEmptyStr(recNotEle.strAutInc) Then
    Exit;

  frmGravando.lblGravando.Caption := 'Lendo nota eletrônica...';
  Application.ProcessMessages;

  strSQL := '';

  strSQL := strSQL + ' SET @ORDEM  = 1.0000; ';
  strSQL := strSQL + ' SET @NROITE = 0; ';

  strSQL := strSQL + ' SELECT       ';

  strSQL := strSQL + '   (@ORDEM:=(@ORDEM + 1.0000)) AS ORDEM, ';


  strSQL := strSQL + '   D.AUTOINCREM AS AUTELE,    ';
  strSQL := strSQL + '   (@NROITE:=(@NROITE + 1))    AS NROITE, ';
  strSQL := strSQL + '   CONCAT("<",@NROITE, "!>", DET_CODITE) ORD_NROITE,';
  strSQL := strSQL + '   CONCAT(DET_CODITE, "<",@NROITE, "!>") ORD_CODITE,';

  strSQL := strSQL + '   DET_CODITE  AS CODITE,     ';

  If fCfgSis('TABPRF', varBoolean) Then
    strSQL := strSQL + '  F.ITE_CODFAB AS CODFAB, '
  Else
    strSQL := strSQL + '  F.ITE_CODITF AS CODFAB, ';

  strSQL := strSQL + '   C.ITE_CODFAB  AS CFBITE,     ';
  strSQL := strSQL + '   C.ITE_REFERE  AS REFERE,     ';
  strSQL := strSQL + '   ITE_APLICA  AS APLICA,     ';
  strSQL := strSQL + '   ITE_DESITE  AS DESITE,     ';
  strSQL := strSQL + '   ITE_SALDOS  AS SALDOS,     ';
  strSQL := strSQL + '   ITE_LOCFIS  AS LOCFIS,     ';
  strSQL := strSQL + '   UNI_SIGUNI  AS SIGUNI,     ';


  If (fCfgSis('CNVEMB') <> 'N') And FConverteEmbalagens Then
  Begin
    strEmbala := fSQLEmbala('C', 'F', 'GER_CODFOR', True);

    strSQL := strSQL + '   ROUND(O14_VIPI / (I10_QCOM * ' + strEmbala + '),  4)    AS IPINFE,    ';
    strSQL := strSQL + '   ROUND(N23_VICMSST / (I10_QCOM* ' + strEmbala + '), 4) AS SUBNFE,    ';
    strSQL := strSQL + '   ROUND((I11_VPROD - ' + fSQLDescontoXML + ') / I10_QCOM, 4) / ' + strEmbala + ' AS UNINFE,     ';
    strSQL := strSQL + '   (IFNULL(I11_VPROD,0) - IFNULL(I17_VDESC,0) + IFNULL(O14_VIPI,0) + IFNULL(N23_VICMSST,0) + IFNULL(N23D_FCPST,0)) AS TOTGER,     ';
    strSQL := strSQL + '   ROUND(ROUND(I10_QCOM , ' + strDecQua + ') *  ' + strEmbala + ' , ' + strDecQua + ') AS QTDNFE,     ';
    strSQL := strSQL + '   ROUND(ROUND(I10_QCOM , ' + strDecQua + ') *  ' + strEmbala + ' , ' + strDecQua + ') AS QTDNFE_UNI, ';
    strSQL := strSQL + '   ROUND(ROUND(I10_QCOM , ' + strDecQua + ') *  ' + strEmbala + ' , ' + strDecQua + ') AS QTDRES,     ';
  End Else
  Begin
    strSQL := strSQL + '   ROUND(O14_VIPI / I10_QCOM, 4)    AS IPINFE,    ';
    strSQL := strSQL + '   ROUND(N23_VICMSST / I10_QCOM, 4) AS SUBNFE,    ';
    strSQL := strSQL + '   ROUND(I11_VPROD - ' + fSQLDescontoXML + ', 4) / I10_QCOM AS UNINFE,     ';
    strSQL := strSQL + '   (IFNULL(I11_VPROD,0) - IFNULL(I17_VDESC,0) + IFNULL(O14_VIPI,0) + IFNULL(N23_VICMSST,0) + IFNULL(N23D_FCPST,0)) AS TOTGER,     ';
    strSQL := strSQL + '   I10_QCOM    AS QTDNFE,     ';
    strSQL := strSQL + '   I10_QCOM    AS QTDNFE_UNI, ';
    strSQL := strSQL + '   I10_QCOM    AS QTDRES,     ';
  End;

  strSQL := strSQL + '   I03_CEAN    AS NFEEAN,     ';

  strSQL := strSQL + '   IF(IFNULL(XPED, "") = "", "", RIGHT(CONCAT("000000000000", XPED), 12)) AS PEDNFE,  ';

  strSQL := strSQL + '   CAST("" AS CHAR(20)) AS NUMPED,  ';
  strSQL := strSQL + '   CAST("" AS CHAR(20)) AS AUTDET,  ';
  strSQL := strSQL + '   0.0000 AS UNIPED,    ';
  strSQL := strSQL + '   0.0000 AS QTDPED,    ';
  strSQL := strSQL + '   0.0000 AS SELPED,    ';
  strSQL := strSQL + '   0.0000 AS TOTPED,    ';
  strSQL := strSQL + '   0.0000 AS RESPED,    ';

  strSQL := strSQL + '   0.0000 AS IPIPED,    ';
  strSQL := strSQL + '   0.0000 AS SUBPED,    ';

  strSQL := strSQL + '   I.ITE_IMPULT,    ';
  strSQL := strSQL + '   I.ITE_DTAULT,    ';
  strSQL := strSQL + '   I.ITE_FORULT,    ';
  strSQL := strSQL + '   I.ITE_NOTULT     ';

  strSQL := strSQL + ' FROM                         ';
  strSQL := strSQL + '   DETELE D                   ';

  strSQL := strSQL + ' INNER JOIN GERELE G ON G.AUTOINCREM = D.DET_SEQGER ';

  strSQL := strSQL + ' INNER JOIN CADITE C ON C.ITE_CODITE = DET_CODITE ';

  strSQL := strSQL + ' INNER JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE AND ';
  strSQL := strSQL + '                        I.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  strSQL := strSQL + ' LEFT  JOIN CADUNI   ON   UNI_CODUNI = ITE_CODUNI ';

  strSQL := strSQL + '  LEFT JOIN ITEFOR F ON F.ITE_CODITE = C.ITE_CODITE AND ';
  strSQL := strSQL + '                        F.ITE_CODFOR =   GER_CODFOR     ';

  If fCfgSis('TABPRF', varBoolean) Then
  Begin
    strSQL := strSQL + '  AND (SELECT COUNT(*) FROM TABPRE      ';
    strSQL := strSQL + '       WHERE F.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S" ) > 0 ';
  End Else
  Begin
    strSQL := strSQL + '  AND F.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF  ';
    strSQL := strSQL + '                      WHERE FF.ITE_CODITE = I.ITE_CODITE AND    ';
    strSQL := strSQL + '                            FF.ITE_CODFOR = GER_CODFOR)         ';
  End;

  strSQL := strSQL + ' WHERE                        ';
  strSQL := strSQL + '   DET_SEQGER = ' + QuotedStr(recNotEle.strAutInc);

  strSQL := strSQL + ' ORDER BY ';
  strSQL := strSQL + '   D.AUTOINCREM, CODITE, IFNULL(PEDNFE, ""), UNINFE ';

  qryQuery.SQL.Text := strSQL;

  Result := Self.fAbreClient(True, 'fCarregaIensNotaEletronica');

  IndexFieldNames := 'ORDEM';

  pAlinhaCampoCentro('SIGUNI');
  pAlinhaCampoCentro('NUMPED');
  pAlinhaCampoCentro('PEDNFE');
  pAlinhaCampoCentro('NROITE');
  pAlinhaCampoCentro('CODITE');
end;

function TPreNota.fCalculaFretePedidos: Double;
Var
   qryGen: TUniQuery;
Begin

  Result := 0;
  Try
    {******************************************}
    {* CALCULA FRETE DOS PEDIDOS SELECIONADOS *}
    {***************************************CI*}
    qryGen := fCriaQuery;
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT SQL_NO_CACHE    ');
      SQL.Add(' SUM(ROUND(IF(PCG_MOEDA_ = 1, PCG_VALFRE * :COTDOL, PCG_VALFRE),' + strDecUni + ')) AS ITE_FREPED ');
      SQL.Add(' FROM                  ');
      SQL.Add('   PCMGER              ');
      SQL.Add(' WHERE                 ');
      SQL.Add('   PCG_ESPDOC = "PD" AND ');
      SQL.Add('   PCG_NUMCTN = 0 AND ');
      SQL.Add('   (PCG_BAIXAD <> 1 OR PCG_BAIXAD IS NULL) AND ');
      SQL.Add('   PCMGER.AUTOINCREM IN (' +  fCommaText(stlAutoinc, True) + ') ');

      If fltCotMoe <> 0 Then
        ParamByName('COTDOL').AsFloat := fltCotMoe
      Else
        ParamByName('COTDOL').AsFloat := 1;

      Open;

      Result := FieldByName('ITE_FREPED').AsFloat;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fCalculaFretePedidos]');
    End;
  End;

  FreeAndNil(qryGen);

End;

function TPreNota.fTipoFretePedido(strAutInc: String): String;
  Var
    qryGen: TUniQuery;
Begin
  Result := '9';

  Try

    qryGen := fCriaQuery;
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT  ');

      SQL.Add('   IFNULL(PCG_VALFRE, 0) AS PCG_VALFRE, PCG_TIPFRE');

      SQL.Add(' FROM                  ');
      SQL.Add('   PCMGER              ');
      SQL.Add(' WHERE                 ');

      SQL.Add('   PCG_ESPDOC = "PD" AND ');
      SQL.Add('   PCG_NUMCTN = 0 AND ');
      SQL.Add('   (PCG_BAIXAD <> 1 OR PCG_BAIXAD IS NULL) AND ');
      SQL.Add('   PCMGER.AUTOINCREM = ' + QuotedStr(strAutInc)  + ' ');

      Open;

      If Not IsEmpty Then
        Result := FieldByName('PCG_TIPFRE').AsString;

      If (Result = '') And (FieldByName('PCG_VALFRE').AsFloat = 0) Then
        Result := '9';

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fTipoFretePedido]');
    End;
  End;

  FreeAndNil(qryGen);
End;

Function TPreNota.fSqlItensPedido(blnGrupoPreco: Boolean = False): String;
  var 
   strEstEmp,
   strUniPcg, strFatUni, strFatAdi: String;
  Const
    strEMBPED = ' IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA) ';

  Function fSQLPreBaixa: String;
    Var
      strSQL: String;
  Begin
    strSQL := '';
    strSQL := strSQL + ' IFNULL((SELECT SUM(PRE_QTDBAI ';

    If fCfgSis('CNVEMB') <> 'N' Then
      strSQL := strSQL + '  / ' + strEMBPED;

    strSQL := strSQL + '  ) FROM PREBAI   ';
    strSQL := strSQL + '    INNER JOIN GERELE G ON G.AUTOINCREM = PRE_AUTELE ';

    If fConferenciaDepoisDaEntrada Then
    Begin
      strSQL := strSQL + '        AND ((G.GER_DOCENT IS NULL) OR ( ';
      strSQL := strSQL + '                 (SELECT COUNT(*) FROM MOVDET M INNER JOIN MOVTRI T ON T.DET_SEQGER = M.AUTOINCREM ';
      strSQL := strSQL + '                 INNER JOIN DETELE L ON L.AUTOINCREM = T.DET_AUTELE                                ';
      strSQL := strSQL + '                 WHERE L.DET_SEQGER = PRE_AUTELE                                                   ';
      strSQL := strSQL + '                 AND M.DET_DTAENT IS NULL) > 0))                                                   ';
    End Else
    Begin
      strSQL := strSQL + '  AND (G.GER_DOCENT IS NULL) ';
    End;

    strSQL := strSQL + '    WHERE PRE_AUTPED = D.AUTOINCREM), 0) ';

    Result := strSQL;
  End;

Begin
  strUniPcg := fCfgSis('UNIPCG', VarString);
  strFatUni := fSQLFatorDesUni;
  strFatAdi := fSQLFatorDesAdi(strUniPcg);
  Result := '';
  Result := Result + ' SELECT                                    ';
  Result := Result + '   CONCAT(PCD_NUMPED, "-", PCD_CODEMP) AS ITE_NUMPED,             ';
  Result := Result + '   IF(IFNULL(PCG_EMPDES, "") = "", PCG_CODEMP, PCG_EMPDES) AS PCG_EMPDES, ';
  Result := Result + '   IFNULL(PCG_MOEDA_, 0) AS PCG_MOEDA_,        ';

  Result := Result + '   PCD_NUMPED,                                 ';
  Result := Result + '   PCD_CODEMP,                                 ';
  Result := Result + '   PCD_DTAPED,                                 ';

  Result := Result + '   0.0000 AS ITE_SELPED,                       ';
  Result := Result + '   0.0000 AS ITE_UNINFE,                       ';

  Result := Result + '   PCMGER.AUTOINCREM AS AUTPCG,                ';
  Result := Result + '   D.AUTOINCREM,                               ';
  Result := Result + '   PCD_CODITE AS ITE_CODITE,                   ';

  If fCfgSis('CNVEMB') <> 'N' Then
  Begin
    // ASSUME QUE A NFE ESTÁ SEMPRE EM UNIDADE DE COMPRA.
    // SE O PEDIDO ESTIVER EM UNIDADE DE VENDA ENTÃO É NECESSÁRIO CONVERTER PARA UNIDADE DE COMPRA
    Result := Result + '   SUM(ROUND((PCD_QTDITE - PCD_QTDBAI - ' + fSQLPreBaixa + ') * ' + strEMBPED + ',' + strDecQua + ')) AS ITE_QTDPED, ';
    Result := Result + '   SUM(ROUND((PCD_QTDITE - PCD_QTDBAI - ' + fSQLPreBaixa + ') * ' + strEMBPED + ',' + strDecQua + ')) AS ITE_QTDRES, ';
    strEstEmp := fCadEmp('ESTADO');
    If fEhEstadoRegraZonaFranca(strEstEmp) Then
      Result := Result + '   ROUND(ROUND(ROUND((PCD_UNITAR - (PCD_VALICM/(PCD_QTDITE - PCD_QTDBAI))) '
    Else
      Result := Result + '   ROUND(ROUND(ROUND(PCD_UNITAR ';
    Result := Result + '       * ' + strFatUni + ' ';
    Result := Result + '       * (1 - IFNULL(PCD_DESUN2, 0)/100) ';
    Result := Result + '       * (1 - IFNULL(PCD_DESUN3, 0)/100) ';
    Result := Result + '       * (1 - IFNULL(PCD_DESUN4, 0)/100) ';
    Result := Result + '       * (1 - IFNULL(PCD_DESUN5, 0)/100) ';
    Result := Result + '       * (1 - IFNULL(PCD_DESUN6, 0)/100) ';
    Result := Result + '       * ' + strFatAdi + ' ';
    Result := Result + '     , 4) / ' + strEMBPED + ', 4) * :COTDOL, 4) AS ITE_UNIPED,  ';

    Result := Result + '   ROUND(ROUND(((ROUND(PCD_UNITAR * ' + strFatUni + ' ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN2, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN3, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN4, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN5, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN6, 0)/100) ';
    Result := Result + '                    * ' + strFatAdi + ' ';
    Result := Result + '      , 4)+ IF(PCG_IPIFRE = "S", PCD_VALFRE/PCD_QTDITE, 0)) / ' + strEMBPED + ') * (PCD_PERIPI / 100), 4) * :COTDOL, 4) AS ITE_IPIPED, ';

    Result := Result + '   ROUND(ROUND(SUM(PCD_TOTSUB - PCD_SUBBAI) / SUM((PCD_QTDITE - PCD_QTDBAI) * ' + strEMBPED + '), 4) * :COTDOL, 4) AS ITE_SUBPED, ';
  End Else
  Begin
    Result := Result + '   SUM(ROUND(PCD_QTDITE - PCD_QTDBAI - ' + fSQLPreBaixa + ',' + strDecQua + ')) AS ITE_QTDPED, ';
    Result := Result + '   SUM(ROUND(PCD_QTDITE - PCD_QTDBAI - ' + fSQLPreBaixa + ',' + strDecQua + ')) AS ITE_QTDRES, ';

    Result := Result + '   ROUND(ROUND(PCD_UNITAR ';
    Result := Result + '       * ' + strFatUni + ' ';
    Result := Result + '       * (1 - IFNULL(PCD_DESUN2, 0)/100) ';
    Result := Result + '       * (1 - IFNULL(PCD_DESUN3, 0)/100) ';
    Result := Result + '       * (1 - IFNULL(PCD_DESUN4, 0)/100) ';
    Result := Result + '       * (1 - IFNULL(PCD_DESUN5, 0)/100) ';
    Result := Result + '       * (1 - IFNULL(PCD_DESUN6, 0)/100) ';
    Result := Result + '       * ' + strFatAdi + ' ';
    Result := Result + '       , 4) * :COTDOL, 4)  AS ITE_UNIPED,  ';

    Result := Result + '   ROUND(ROUND(ROUND(PCD_UNITAR * ' + strFatUni + ' ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN2, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN3, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN4, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN5, 0)/100) ';
    Result := Result + '                    * (1 - IFNULL(PCD_DESUN6, 0)/100) ';
    Result := Result + '                    * ' + strFatAdi + ' ';
    Result := Result + '                 , 4) * (PCD_PERIPI / 100), 4) * :COTDOL, 4) AS ITE_IPIPED,   ';

    Result := Result + '   ROUND(ROUND(SUM(PCD_TOTSUB - PCD_SUBBAI) / SUM(PCD_QTDITE - PCD_QTDBAI), 4) * :COTDOL, 4) AS ITE_SUBPED, ';
  End;

  If fCfgSis('TABPRF', varBoolean) Then
    Result := Result + '  F.ITE_CODFAB AS CODFAB, '
  Else
    Result := Result + '  F.ITE_CODITF AS CODFAB, ';

  Result := Result + '   I.ITE_CODFAB  AS CFBITE,     ';
  Result := Result + '   I.ITE_CODBAR AS ITE_CODBAR, ';
  Result := Result + '   ITE_DESITE AS ITE_DESITE, ';
  Result := Result + '   I.ITE_REFERE AS ITE_REFERE, ';
  Result := Result + '   ITE_APLICA,                ';

  Result := Result + '   ITE_LOCFIS AS ITE_LOCFIS, ';

  Result := Result + '   UNI_SIGUNI AS ITE_DESUNI,                                      ';
  Result := Result + '   ITE_SALDOS                                      AS ITE_SALDOS  ';
  Result := Result + ' FROM          ';
  Result := Result + '   PCMDET D    ';

  Result := Result + '   INNER JOIN PCMGER   ON PCG_NUMPED = PCD_NUMPED AND ';
  Result := Result + '                          PCG_ESPDOC = PCD_ESPDOC AND ';
  Result := Result + '                          PCG_CODEMP = PCD_CODEMP AND ';
  Result := Result + '                          PCG_NUMCTN = PCD_NUMCTN     ';
  Result := Result + '   INNER JOIN CADITE I ON I.ITE_CODITE = PCD_CODITE ';

  Result := Result + '   INNER JOIN ITEGER G ON G.ITE_CODITE = PCD_CODITE AND ';
  Result := Result + '                          G.ITE_CODEMP = '+ QuotedStr(VS_strCodEmp) + ' ';

  Result := Result + '   LEFT  JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';

  Result := Result + '  LEFT JOIN ITEFOR F ON F.ITE_CODITE = I.ITE_CODITE AND ';
  Result := Result + '                        F.ITE_CODFOR =   PCG_CODFOR     ';

  If fCfgSis('TABPRF', varBoolean) Then
  Begin
    Result := Result + '  AND (SELECT COUNT(*) FROM TABPRE      ';
    Result := Result + '       WHERE F.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S" ) > 0 ';
  End Else
  Begin
    Result := Result + '  AND F.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF  ';
    Result := Result + '                      WHERE FF.ITE_CODITE = I.ITE_CODITE AND    ';
    Result := Result + '                            FF.ITE_CODFOR = PCG_CODFOR)         ';
  End;

  Result := Result + ' WHERE      ';
  Result := Result + '   PCD_ESPDOC = "PD" AND ';
  Result := Result + '   PCD_NUMCTN = 0 AND ';
  Result := Result + '   PCD_BAIXAD = 0 AND ';

  Result := Result + '   ROUND(PCD_QTDITE - PCD_QTDBAI - ' + fSQLPreBaixa + ', ' + strDecQua + ') > 0 AND ';

  Result := Result + '   PCMGER.AUTOINCREM IN (' +  fCommaText(stlAutoinc, True) + ') ';

  Result := Result + ' GROUP BY      ';

  If blnGrupoPreco Then
  Begin

    Result := Result + '   IFNULL(PCG_MOEDA_, 0), ';
    Result := Result + '   PCD_CODITE, ';

    If fCfgSis('CNVEMB') <> 'N' Then
    Begin

      Result := Result + '  ROUND(ROUND(PCD_UNITAR * ' + strFatUni + ' ';
      Result := Result + '                    * (1 - IFNULL(PCD_DESUN2, 0)/100) ';
      Result := Result + '                    * (1 - IFNULL(PCD_DESUN3, 0)/100) ';
      Result := Result + '                    * (1 - IFNULL(PCD_DESUN4, 0)/100) ';
      Result := Result + '                    * (1 - IFNULL(PCD_DESUN5, 0)/100) ';
      Result := Result + '                    * (1 - IFNULL(PCD_DESUN6, 0)/100) ';
      Result := Result + '                    * ' + strFatAdi + ' ';
      Result := Result + '      , 4) / ' + strEMBPED + ', 4) ';

    End Else
    Begin

      Result := Result + '   ROUND(PCD_UNITAR * ' + strFatUni + ' ';
      Result := Result + '                    * (1 - IFNULL(PCD_DESUN2, 0)/100) ';
      Result := Result + '                    * (1 - IFNULL(PCD_DESUN3, 0)/100) ';
      Result := Result + '                    * (1 - IFNULL(PCD_DESUN4, 0)/100) ';
      Result := Result + '                    * (1 - IFNULL(PCD_DESUN5, 0)/100) ';
      Result := Result + '                    * (1 - IFNULL(PCD_DESUN6, 0)/100) ';
      Result := Result + '                    * ' + strFatAdi + ' ';
      Result := Result + '                 , 4)  ';

    End;

  End Else
  Begin

   Result := Result + '   D.AUTOINCREM ';

  End;

  Result := Result + ' ORDER BY ';
  Result := Result + '   PCD_CODITE, PCD_DTAPED, PCD_NUMPED, PCD_CODEMP ';
End;

function TPreNota.fPedidoDeterminadoNoXML(strCodIte: String): Boolean;
  Var
    blnTemPedidoDeterminadoPelaNFE,
    blnTemPedidoNaoDeterminadoPelaNFE: Boolean;
Begin
  Result := False;

  blnTemPedidoDeterminadoPelaNFE    := False;
  blnTemPedidoNaoDeterminadoPelaNFE := False;

  Try
    Self.Filter   := Concat('CODITE = ', QuotedStr(strCodIte));
    Self.Filtered := True;

    Self.First;
    While Not Self.Eof Do
    Begin
      If LeftStr(Self.FieldByName('NUMPED').AsString, 12) = Self.FieldByName('PEDNFE').AsString Then
        blnTemPedidoDeterminadoPelaNFE := True

      Else  If Self.FieldByName('SELPED').AsFloat > 0 Then
        blnTemPedidoNaoDeterminadoPelaNFE := True;

      Self.Next;
    End;

  Finally
    Self.Filtered := False;
  End;

  If blnTemPedidoDeterminadoPelaNFE Then
    If Not blnTemPedidoNaoDeterminadoPelaNFE Then
      Result := True;
End;

function TPreNota.fVerificaItensComPrecoDivergentesPedidos: Boolean;
  var
    qryItens : TUniQuery;
    stlItens : TStringList;
    stlIncon : TStrings;
    intIndex : Integer;
    strUnitar: String;
Begin
  Self.DisableControls;

  Result := True;

  stlIncon := TStringList.Create;

  stlItens := TStringList.Create;
  stlItens.Sorted := True;

  qryItens := fCriaQuery(Self);

  With qryItens, SQL Do
  Begin
    Close;
    Clear;
    Add(fSqlItensPedido(True));

    If Not blnPedidosEmDolar Then
    Begin
      fltCotMoe := 0;
      ParamByName('COTDOL').AsFloat := 1;
    End

    Else ParamByName('COTDOL').AsFloat := fltCotMoe;

    Open;

    First;

    While Not Eof Do
    Begin
      stlItens.Add(FieldByName('ITE_CODITE').AsString);
      Next;
    End;

    First;

    For intIndex := 0 To stlItens.Count - 1 Do
    Begin
      Filtered := False;
      Filter   := 'ITE_CODITE = ' + QuotedStr(stlItens[intIndex]);
      Filtered := True;


      If Recordcount > 1 Then
      Begin

        If Not fPedidoDeterminadoNoXML(stlItens[intIndex]) Then
        Begin

          If stlIncon.Count = 0 Then
          Begin
            stlIncon.Add('-----------------------------------------------------------------------------');
            stlIncon.Add('|            PRODUTOS COM PREÇO UNITÁRIO DIFERENTE NOS PEDIDOS              |');
            stlIncon.Add('-----------------------------------------------------------------------------');
            stlIncon.Add('| CODIGO | DESCRICAO                   |      UNITAR.| PEDIDOS              |');
            stlIncon.Add('-----------------------------------------------------------------------------');
          End;

          First;

          While Not Eof Do
          Begin
            strUnitar := FormatFloat('#,##0.0000', FieldByName('ITE_UNIPED').AsFloat);

            stlIncon.Add('| ' + fPadR(FieldByName('ITE_CODITE').AsString, 07) +
                         '| ' + fPadR(FieldByName('ITE_DESITE').AsString, 28) +
                         '| ' + fPadL(strUnitar,                          12) +
                         '| ' + fPadR(FieldByName('ITE_NUMPED').AsString, 21) + '|');
            Next;
          End;

          stlIncon.Add('-----------------------------------------------------------------------------');

        End;

      End;

    End;

    If stlIncon.Count > 0 Then
    Begin
      stlIncon.Add('* PRESSIONE ESC PARA SAIR');



      pMostraMemo(stlIncon);
    End;

  End;

  FreeAndNil(qryItens);
  FreeAndNil(stlItens);
  FreeAndNil(stlIncon);

  Self.EnableControls;
End;

procedure TPreNota.pMostraMemo(stlIncon: TStrings);
begin
  try
    pCriarFormularios(TfrmMemo, frmMemo);
    frmMemo.cxMemo.Lines := stlIncon;
    frmMemo.cxMemo.Style.Font.Name := 'Courier New';
    frmMemo.cxMemo.Style.BorderColor := clBlack;
    frmMemo.cxMemo.Style.Color := $FFE4D5;
    frmMemo.cxMemo.Style.BorderColor := clBlue;
    frmMemo.cxMemo.Style.Font.Color := clNavy;
    frmMemo.cxMemo.Style.Font.Size := 12;
    frmMemo.Width := 800;
    frmMemo.Height := 600;
    frmMemo.ShowModal;
  except
    on E: Exception do
    begin
      pMensagensErro(E.Message, '[]');
    end;
  end;
  pFreeAndNil(frmMemo);
end;

Function TPreNota.fCarregaItensPedido: Boolean;
Begin
  With cdsItemPed Do
  Begin
    frmGravando.lblGravando.Caption := 'Lendo itens do pedido...';
    Application.ProcessMessages;

    qryQuery.SQL.Text := fSqlItensPedido;

    If Not blnPedidosEmDolar Then
    Begin
      fltCotMoe := 0;
      qryQuery.ParamByName('COTDOL').AsFloat := 1;
    End

    Else qryQuery.ParamByName('COTDOL').AsFloat := fltCotMoe;

    Result := fAbreClient(True, 'fCarregaItensPedido');

    IndexFieldNames := 'ITE_CODITE;PCD_DTAPED';
  End;
End;

Function TPreNota.fSQLDefBai: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT * FROM DEFBAI WHERE FALSE';
  Result := strSQL;
End;

Procedure TPreNota.pIncluiDefBai(strGerEle, strAutEle, strAutPcd, strAutPcg: String; fltQtdBai: Double);
Begin
  With cdsDefBai Do
  Begin
    Insert;
    FieldByName('DEF_GERELE').AsString := strGerEle;
    FieldByName('DEF_AUTELE').AsString := strAutEle;
    FieldByName('DEF_AUTPCD').AsString := strAutPcd;
    FieldByName('DEF_AUTPCG').AsString := strAutPcg;
    FieldByName('DEF_QTDITE').AsFloat  := fltQtdBai;
    Post;
  End;
End;

Procedure TPreNota.pDeterminaBaixa;
  Var
    intNroItemMax: Integer;
    strNumPed: String;

    Procedure pMarcaBaixa(blnTestaValor, blnTestaNroPed: Boolean; strNumPed: String = '');
      Var
        recItemNfe: TRecItemNfe;
    Begin
      // TENTA A BAIXA POR PREÇO
      While (Not cdsItemPed.Eof) And (cdsItemPed.FieldByName('ITE_CODITE').AsString = FieldByName('CODITE').AsString) And
            ((Not blnTestaNroPed) Or (cdsItemPed.FieldByName('PCD_NUMPED').AsString = IIf(strNumPed = '', FieldByName('PEDNFE').AsString, strNumPed))) Do
      Begin

        If (RoundTo(cdsItemPed.FieldByName('ITE_QTDRES').AsFloat, -4) > 0) And
           ((Not blnTestaValor) Or (RoundTo(cdsItemPed.FieldByName('ITE_UNIPED').AsFloat, -4) = RoundTo(FieldByName('UNINFE').AsFloat, -4))) Then
        Begin

          If Not fEmptyStr(FieldByName('NUMPED').AsString) Then
          Begin

            With recItemNfe Do
            Begin
              strAutEle := FieldByName('AUTELE').AsString;
              strCodIte := FieldByName('CODITE').AsString;
              strCodFab := IIF(fEmptyStr(FieldByName('CODFAB').AsString), FieldByName('CFBITE').AsString, FieldByName('CODFAB').AsString);
              strRefere := FieldByName('REFERE').AsString;
              strAplica := FieldByName('APLICA').AsString;
              strDesIte := FieldByName('DESITE').AsString;
              strSigUni := FieldByName('SIGUNI').AsString;
              strCodEan := FieldByName('NFEEAN').AsString;
              strPedNFE := FieldByName('PEDNFE').AsString;

              fltTotGer := FieldByName('TOTGER').AsFloat;
              fltValIpi := FieldByName('IPINFE').AsFloat;
              fltSubNfe := FieldByName('SUBNFE').AsFloat;
              fltValUni := FieldByName('UNINFE').AsFloat;
              fltQtdPro := FieldByName('QTDNFE').AsFloat;
              fltQtdRes := FieldByName('QTDRES').AsFloat;
              fltResPed := FieldByName('RESPED').AsFloat;
              fltSaldos := FieldByName('SALDOS').AsFloat;
              fltOrdem  := FieldByName('ORDEM').AsFloat;

              intNroIte := FieldByName('NROITE').AsInteger;

              Edit;
              FieldByName('QTDRES').AsFloat := 0;
              Post;

              // INSERE UM NOVO REGISTRO PARA A BAIXA POR UM NOVO PEDIDO
              Insert;

              FieldByName('AUTELE').AsString := strAutEle;
              FieldByName('CODITE').AsString := strCodIte;
              FieldByName('CODFAB').AsString := strCodFab;
              FieldByName('REFERE').AsString := strRefere;
              FieldByName('APLICA').AsString := strAplica;
              FieldByName('DESITE').AsString := strDesIte;
              FieldByName('SIGUNI').AsString := strSigUni;
              FieldByName('NFEEAN').AsString := strCodEan;
              FieldByName('PEDNFE').AsString := strPedNFE;

              FieldByName('TOTGER').AsFloat  := fltTotGer;
              FieldByName('IPINFE').AsFloat  := fltValIpi;
              FieldByName('SUBNFE').AsFloat  := fltSubNfe;
              FieldByName('UNINFE').AsFloat  := fltValUni;
              FieldByName('QTDNFE').AsFloat  := fltQtdPro;
              FieldByName('QTDRES').AsFloat  := fltQtdRes;
              FieldByName('RESPED').AsFloat  := fltResPed;
              FieldByName('TOTPED').AsFloat  := 0;

              FieldByName('SALDOS').AsFloat  := fltSaldos;

              FieldByName('ORDEM').AsFloat  := fltOrdem + 0.001;

              FieldByName('NROITE').AsInteger := intNroIte;
              FieldByName('ORD_NROITE').AsString := '<'+intNroIte.ToString+'!>' + strCodIte;
              FieldByName('ORD_CODITE').AsString := strCodIte + '<'+intNroIte.ToString+'!>';


              Post;

            End;

          End;

          Edit;
          cdsItemPed.Edit;

          FieldByName('RESPED').AsFloat := cdsItemPed.FieldByName('ITE_QTDRES').AsFloat;

          If cdsItemPed.FieldByName('ITE_SELPED').AsFloat = 0 Then
            FieldByName('TOTPED').AsFloat := cdsItemPed.FieldByName('ITE_QTDPED').AsFloat;

          If RoundTo(FieldByName('QTDRES').AsFloat, -4) <= RoundTo(cdsItemPed.FieldByName('ITE_QTDRES').AsFloat, -4) Then
          Begin

            cdsItemPed.FieldByName('ITE_QTDRES').AsFloat := cdsItemPed.FieldByName('ITE_QTDRES').AsFloat - FieldByName('QTDRES').AsFloat;
            cdsItemPed.FieldByName('ITE_SELPED').AsFloat := cdsItemPed.FieldByName('ITE_SELPED').AsFloat + FieldByName('QTDRES').AsFloat;

            FieldByName('SELPED').AsFloat := FieldByName('QTDRES').AsFloat;
            FieldByName('QTDRES').AsFloat := 0;

          End Else
          Begin // O PEDIDO NÃO BASTOU - CONSUMIU A QUANTIDADE DO PEDIDO

            FieldByName('SELPED').AsFloat := cdsItemPed.FieldByName('ITE_QTDRES').AsFloat;
            FieldByName('QTDRES').AsFloat := FieldByName('QTDRES').AsFloat - cdsItemPed.FieldByName('ITE_QTDRES').AsFloat;

            cdsItemPed.FieldByName('ITE_SELPED').AsFloat := cdsItemPed.FieldByName('ITE_SELPED').AsFloat + cdsItemPed.FieldByName('ITE_QTDRES').AsFloat;
            cdsItemPed.FieldByName('ITE_QTDRES').AsFloat := 0;

          End;

          cdsItemPed.FieldByName('ITE_UNINFE').AsFloat := FieldByName('UNINFE').AsFloat;

          cdsItemPed.Post;

          If cdsItemPed.FieldByName('ITE_CODITE').AsString <> FieldByName('CODITE').AsString Then
            Raise Exception.Create('Houve um erro ao definir os itens do pedido de compra, entre contato com a Citel! ');

          pIncluiDefBai(recNotEle.strAutInc,
                        FieldByName('AUTELE').AsString,
                        cdsItemPed.FieldByName('AUTOINCREM').AsString,
                        cdsItemPed.FieldByName('AUTPCG').AsString,
                        FieldByName('SELPED').AsFloat);

          FieldByName('NUMPED').AsString := cdsItemPed.FieldByName('ITE_NUMPED').AsString;
          FieldByName('UNIPED').AsFloat  := cdsItemPed.FieldByName('ITE_UNIPED').AsFloat;
          FieldByName('QTDPED').AsFloat  := cdsItemPed.FieldByName('ITE_QTDPED').AsFloat;
          FieldByName('IPIPED').AsFloat  := cdsItemPed.FieldByName('ITE_IPIPED').AsFloat;
          FieldByName('SUBPED').AsFloat  := cdsItemPed.FieldByName('ITE_SUBPED').AsFloat;

          Post;

        End;

        If RoundTo(FieldByName('QTDRES').AsFloat, -4) = 0 Then
          Break;

        cdsItemPed.Next;
      End;

    End;

    Procedure pAdicionaItemSemPedido;
    Begin
      Edit;
      FieldByName('UNIPED').Clear;
      FieldByName('QTDPED').Clear;
      FieldByName('IPIPED').Clear;
      FieldByName('SUBPED').Clear;
      Post;
    End;

Begin
  intNroItemMax := 0;

  If Not cdsDefBai.fAbreClient(True, 'TPreNota.pDeterminaBaixa') Then
    pRaise(cdsDefBai.strMsgErr);

  If blnPedidosPreDefinidos Then
  Begin
    frmGravando.lblGravando.Caption := 'Relacionando nota e pedido...';
    frmGravando.pgbStatus.Position := 0;
    frmGravando.pgbStatus.Properties.Max := Self.RecordCount;
    Application.ProcessMessages;

    cdsItemPed.IndexFieldNames := 'ITE_CODITE;PCD_NUMPED';

    First;

    While Not Eof Do
    Begin

      If RoundTo(FieldByName('QTDRES').AsFloat, -4) > 0 Then
      Begin

        If intNroItemMax < FieldByName('NROITE').AsInteger Then
          intNroItemMax := FieldByName('NROITE').AsInteger;

        cdsItemPed.First;

        If  Assigned(frmVinculoBaixaEntregaFuturaEdocVenda) Then
          strNumPed := frmVinculoBaixaEntregaFuturaEdocVenda.fRetornaPedidoComSaldoAVincular(FieldByName('AUTELE').AsString)
        Else
          strNumPed :=  FieldByName('PEDNFE').AsString;
        If cdsItemPed.Locate('ITE_CODITE;PCD_NUMPED', varArrayOf([FieldByName('CODITE').AsString, strNumPed]), []) Then
        Begin
          pMarcaBaixa(True, True, IIf(Assigned(frmVinculoBaixaEntregaFuturaEdocVenda), strNumPed, ''));
          If RoundTo(FieldByName('QTDRES').AsFloat, -4) > 0 Then
          Begin
            cdsItemPed.First;
            If cdsItemPed.Locate('ITE_CODITE;PCD_NUMPED', varArrayOf([FieldByName('CODITE').AsString, strNumPed]), []) Then
              pMarcaBaixa(False, True, IIf(Assigned(frmVinculoBaixaEntregaFuturaEdocVenda), strNumPed, ''));
          End;

        End;
      End;


      Next;

      frmGravando.pgbStatus.Position := frmGravando.pgbStatus.Position + 1;
      Application.ProcessMessages;
    End;

  End;

  First;

  cdsItemPed.IndexFieldNames := 'ITE_CODITE;PCD_DTAPED';

  frmGravando.pgbStatus.Position := 0;
  frmGravando.pgbStatus.Properties.Max := Self.RecordCount;
  Application.ProcessMessages;

  While Not Eof Do
  Begin

    If RoundTo(FieldByName('QTDRES').AsFloat, -4) > 0 Then
    Begin

      If intNroItemMax < FieldByName('NROITE').AsInteger Then
        intNroItemMax := FieldByName('NROITE').AsInteger;

      cdsItemPed.First;

      If cdsItemPed.Locate('ITE_CODITE', FieldByName('CODITE').AsString, []) Then
      Begin
        pMarcaBaixa(True, False);

        If RoundTo(FieldByName('QTDRES').AsFloat, -4) > 0 Then
        Begin
          cdsItemPed.First;
          If cdsItemPed.Locate('ITE_CODITE', FieldByName('CODITE').AsString, []) Then
            pMarcaBaixa(False, False);
        End;

      End Else
      Begin
        pAdicionaItemSemPedido;
      End;

    End;

    Next;

    frmGravando.pgbStatus.Position := frmGravando.pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;

  pAdicionaItensSoPedido(intNroItemMax, FMostraItensSoPedido);

  blnTemItemSemPedido := Locate('NUMPED', '', []);

  IndexFieldNames := 'NROITE;CODITE;NUMPED';
  First;
End;

Procedure TPreNota.pAdicionaItensSoPedido(intNroIte: Integer; blnTodos: Boolean);
Begin
  With cdsItemPed Do
  Try

    Filter:= '(ITE_QTDRES > 0)';
    Filtered := True;

    If Not IsEmpty Then
    Begin
      frmGravando.lblGravando.Caption := 'Verificando itens do pedido sem nota...';
      Application.ProcessMessages;
      frmGravando.pgbStatus.Position := 0;
      frmGravando.pgbStatus.Properties.Max := cdsItemPed.RecordCount;
    End;

    First;

    While Not Eof Do
    Begin

      If blnTodos Or Self.Locate('CODITE', FieldByName('ITE_CODITE').AsString, []) Then
      Begin
        Inc(intNroIte);

        Self.Append;

        Self.FieldByName('NUMPED').AsString := FieldByName('ITE_NUMPED').AsString;
        Self.FieldByName('UNIPED').AsFloat  := FieldByName('ITE_UNIPED').AsFloat;
        Self.FieldByName('QTDPED').AsFloat  := FieldByName('ITE_QTDPED').AsFloat;
        Self.FieldByName('IPIPED').AsFloat  := FieldByName('ITE_IPIPED').AsFloat;
        Self.FieldByName('SUBPED').AsFloat  := FieldByName('ITE_SUBPED').AsFloat;
        Self.FieldByName('SALDOS').AsFloat  := FieldByName('ITE_SALDOS').AsFloat;
        Self.FieldByName('RESPED').AsFloat  := FieldByName('ITE_QTDRES').AsFloat;

        If FieldByName('ITE_SELPED').AsFloat = 0 Then
          Self.FieldByName('TOTPED').AsFloat  := FieldByName('ITE_QTDPED').AsFloat
        Else
          Self.FieldByName('TOTPED').AsFloat  := 0;

        Self.FieldByName('QTDNFE').AsFloat  := 0;
        Self.FieldByName('SELPED').AsFloat  := 0;

        Self.FieldByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
        Self.FieldByName('CODFAB').AsString := IIF(fEmptyStr(FieldByName('CODFAB').AsString), FieldByName('CFBITE').AsString, FieldByName('CODFAB').AsString);
        Self.FieldByName('REFERE').AsString := FieldByName('ITE_REFERE').AsString;
        Self.FieldByName('APLICA').AsString := FieldByName('ITE_APLICA').AsString;
        Self.FieldByName('DESITE').AsString := FieldByName('ITE_DESITE').AsString;
        Self.FieldByName('SIGUNI').AsString := FieldByName('ITE_DESUNI').AsString;
        Self.FieldByName('NROITE').AsInteger := intNroIte;

        Self.FieldByName('ORD_NROITE').AsString := '<'+intNroIte.ToString+'!>' + FieldByName('ITE_CODITE').AsString;
        Self.FieldByName('ORD_CODITE').AsString := FieldByName('ITE_CODITE').AsString + '<'+intNroIte.ToString+'!>';


        Self.Post;
      End;

      Next;

      frmGravando.pgbStatus.Position := frmGravando.pgbStatus.Position + 1;
      Application.ProcessMessages;
    End;

  Finally
    Filtered := False;
    Filter:= '';
  End;
End;

function TPreNota.fRetCdsInconsistenciaCadastrais: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Self);
  Result.Data := cdsCriticas.Data;
  Result.Filter := 'INFADI <> ' + QuotedStr('') + ' AND CODITE <> ' + StringOfChar('0', fTamCodIte);
  Result.Filtered := True;

  cdsCriticas.Filtered := False;
  cdsCriticas.Filter := ReplaceStr(cdsCriticas.Filter, 'OR (INFADI <> '''')', '' );
  cdsCriticas.Filtered := True;
end;

{Function TPreNota.fRetQtdPed(strCodIte: String): Double;
Begin
  Result := 0;

  With cdsItemPed Do
  Begin
    First;

    If Locate('ITE_CODITE', strCodIte, []) Then
    Begin

      While (Not Eof) And (FieldByName('ITE_CODITE').AsString = strCodIte) Do
      Begin

        Result := Result + FieldByName('ITE_QTDPED').AsFloat;

        Next;
      End;

    End;

  End;
End;}

Procedure TPreNota.pSalvaEmbalagensProduto;
  Var
    qryDetEle: TUniQuery;
    strSQL: String;
Begin
  qryDetEle := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' UPDATE DETELE D ';

  If (fCfgSis('CNVEMB') <> 'N') And FConverteEmbalagens Then
  Begin
    strSQL := strSQL + '  INNER JOIN GERELE G ON G.AUTOINCREM = D.DET_SEQGER    ';

    strSQL := strSQL + '  INNER JOIN CADITE C ON C.ITE_CODITE = D.DET_CODITE    ';

    strSQL := strSQL + '  LEFT JOIN ITEFOR F ON F.ITE_CODITE = C.ITE_CODITE AND ';
    strSQL := strSQL + '                        F.ITE_CODFOR =   GER_CODFOR     ';
    If fCfgSis('TABPRF', varBoolean) Then
    Begin
      strSQL := strSQL + '  AND (SELECT COUNT(*) FROM TABPRE      ';
      strSQL := strSQL + '       WHERE F.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S" ) > 0 ';
    End Else
    Begin
      strSQL := strSQL + '  AND F.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF  ';
      strSQL := strSQL + '                      WHERE FF.ITE_CODITE = C.ITE_CODITE AND    ';
      strSQL := strSQL + '                            FF.ITE_CODFOR = GER_CODFOR)         ';
    End;
  End;

  strSQL := strSQL + '  SET DET_EMBALA = ';

  If (fCfgSis('CNVEMB') <> 'N') And FConverteEmbalagens Then
  Begin
    strSQL := strSQL + fSQLEmbala('C', 'F', 'GER_CODFOR', True);
  End Else
  Begin
    strSQL := strSQL + ' 1 ';
  End;

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   DET_SEQGER = :AUTGER ';

  qryDetEle.SQL.Text := strSQL;
  qryDetEle.ParamByName('AUTGER').AsString := recNotEle.strAutInc;
  qryDetEle.ExecSQL;

  FreeAndNil(qryDetEle);
End;

Function TPreNota.fTemDefinicaoDeBaixa: Boolean;
var strFilter: String;
Begin
  strFilter := cdsItemPed.Filter;
  Try
    cdsItemPed.Filtered := False;
    cdsItemPed.Filter   := 'ITE_SELPED > 0';
    cdsItemPed.Filtered := True;
    Result := Not cdsItemPed.IsEmpty;
  finally
    cdsItemPed.Filtered := False;
    If strFilter <> '' Then
    Begin
      cdsItemPed.Filter   := strFilter;
      cdsItemPed.Filtered := True;
    End;
  End;
End;

Function TPreNota.fTemDefinicaoParaOPedido(strPedido: String): Boolean;
var strFilter: String;
Begin
  strFilter := cdsItemPed.Filter;
  Try
    cdsItemPed.Filtered := False;
    cdsItemPed.Filter   := 'ITE_NUMPED = ' + QuotedStr(strPedido) + ' AND (ITE_SELPED > 0)';
    cdsItemPed.Filtered := True;
    Result := Not cdsItemPed.IsEmpty;
  finally
    cdsItemPed.Filtered := False;
    If strFilter <> '' Then
    Begin
      cdsItemPed.Filter   := strFilter;
      cdsItemPed.Filtered := True;
    End;
  End;
End;

Function TPreNota.fConfirma: Boolean;
  Var
    strOpeLib: String;
    qryUpdate: TUniQuery;
    intPedidos: Integer;
    intAgrupador : integer;
    blnPossuiInconsistencia: Boolean;
    objTabela    : TRegistroMsgLiberaTabela;
    stlErro: TStringList;

  procedure pAddArrMsgLib;
    var
      strCodIte: String;
      blnTem,
      blnQtd, blnUni,
      blnIpi, blnSub : Boolean;
	    objLinha  : TLinhaMsgLibera;
  Begin
    With cdsCriticas do
    begin
      blnQtd := (Abs(FieldByName('QTDNFE').AsFloat - FieldByName('QTDPED').AsFloat) > fltOciQtd);

      blnTem := ((RoundTo(FieldByName('QTDNFE').AsFloat, -4) > 0) And (RoundTo(FieldByName('QTDPED').AsFloat, -4) > 0));

      blnUni := (blnTem And (Abs(FieldByName('UNINFE').AsFloat - FieldByName('UNIPED').AsFloat) > fltOciVlr));

      blnIpi := (blnTem And (Abs(FieldByName('IPINFE').AsFloat - FieldByName('IPIPED').AsFloat) > fltOciVlr));

      blnSub := (blnTem And (Abs(FieldByName('SUBNFE').AsFloat - FieldByName('SUBPED').AsFloat) > fltOciVlr));

      strCodIte := FieldByName('CODITE').AsString;

      if (strCodIte = iif(fTamCodIte = 5, '00000', '0000000')) then
        Exit;

      If (blnEXSIDV And ((Not blnQtd) And (Not blnIpi) And (Not blnUni) And (Not blnSub))) Then
        Exit;

      inc(IntAgrupador);

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.intAgrupador := intAgrupador;
      objLinha.pAddColuna('Cod.'         , strCodIte                                                                         , 7  , alEsquerda);
      objLinha.pAddColuna('Descrição'    , FieldByName('DESITE').AsString                                                    , 93 , alEsquerda);
      objLinha.pAddColuna('Unidade'      , fRetSiglaUni( fCampoTabela('ITE_CODUNI', 'CADITE', ['ITE_CODITE'], [strCodIte]) ) , 18 , alEsquerda, teAmbos, True);
      objTabela.lstLinhas.Add(objLinha);

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.intAgrupador := intAgrupador;
      objLinha.pAddColuna('Cod.Fabrica' , FieldByName('CODFAB').AsString , 122  , alEsquerda, teAmbos, True);
      objTabela.lstLinhas.Add(objLinha);

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.intAgrupador := intAgrupador;
      objLinha.pAddColuna(''             , ''                                                                              , 66 , alEsquerda );
      objLinha.pAddColuna('Quant.Ped.'   , FormatFloat('#,##0.0000', FieldByName('QTDPED').AsFloat) + IIF(blnQtd, '*', '') , 12 , alDireita );
      objLinha.pAddColuna('Quant.NFE.'   , FormatFloat('#,##0.0000', FieldByName('QTDNFE').AsFloat) + IIF(blnQtd, '*', '') , 12 , alDireita );
      objLinha.pAddColuna('Vr.Unit.Ped.' , FormatFloat('#,##0.00'  , FieldByName('UNIPED').AsFloat) + IIF(blnUni, '*', '') , 12 , alDireita  );
      objLinha.pAddColuna('Vr.Unit.NFE.' , FormatFloat('#,##0.00'  , FieldByName('UNINFE').AsFloat) + IIF(blnUni, '*', '') , 12 , alDireita  );
      objTabela.lstLinhas.Add(objLinha);

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.intAgrupador := intAgrupador;
      objLinha.pAddColuna(''            , ''                                                                              , 66 , alEsquerda);
      objLinha.pAddColuna('Vr.IPI  Ped.', FormatFloat('#,##0.00  ', FieldByName('IPIPED').AsFloat) + IIF(blnIpi, '*', '') , 12 , alDireita );
      objLinha.pAddColuna('Vr.IPI  NFE' , FormatFloat('#,##0.00'  , FieldByName('IPINFE').AsFloat) + IIF(blnIpi, '*', '') , 12 , alDireita );
      objLinha.pAddColuna('Vr.ST  Ped.' , FormatFloat('#,##0.00'  , FieldByName('SUBPED').AsFloat) + IIF(blnSub, '*', '') , 12 , alDireita );
      objLinha.pAddColuna('Vr.ST  NFE'  , FormatFloat('#,##0.00'  , FieldByName('SUBNFE').AsFloat) + IIF(blnSub, '*', '') , 12 , alDireita );
      objTabela.lstLinhas.Add(objLinha);

    end;

  end;

  procedure pAddArrMsgLibCadastral(cdsCriCad : TUniClientDataSet);
    Var
      strCodIte : String;
      strDesIte : String;
      strNfeEan : String;
      strCodBar : String;
      strInfAdi : String;
      objLinha  : TLinhaMsgLibera;

  Begin
    With cdsCriCad Do
    Begin
      int(intAgrupador);
      strCodIte := FieldByName('CODITE').AsString;
      strDesIte := FieldByName('DESITE').AsString;
      strNfeEan := FieldByName('NFEEAN').AsString;
      strCodBar := FieldByName('CODBAR').AsString;
      strInfAdi := FieldByName('INFADI').AsString;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.intAgrupador := intAgrupador;
      objLinha.pAddColuna('Cod.'                  , strCodIte , 7  , alEsquerda);
      objLinha.pAddColuna('Descrição'             , strDesIte , 53 , alEsquerda);
      objLinha.pAddColuna('Código de Barras XML'  , strNfeEan , 28 , alEsquerda);
      objLinha.pAddColuna('Código de Barras Cad.' , strCodBar , 28 , alEsquerda);
      objTabela.lstLinhas.Add(objLinha);

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.intAgrupador := intAgrupador;
      objLinha.pAddColuna('Ocorrencias'           , strInfAdi , 122 , alEsquerda);
      objTabela.lstLinhas.Add(objLinha);

    End;
  End;

  Procedure pIncluiInconsistenciaConpag(blnconsis: Boolean);
  var
	  objLinha  : TLinhaMsgLibera;
  Begin
    If blnconsis Then
    Begin
      objLiberacao.objMsgRemota.pAddSeparador(125);
      objLiberacao.objMsgRemota.pAddTexto('DIVERGÊNCIA DA CONDIÇÃO DE PAGAMENTO', alCentro, teAmbos, '', 125);
      objLiberacao.objMsgRemota.pAddSeparador(125);
      objLiberacao.objMsgRemota.pAddTextoCaption('Condição de Pagamento da Nota', FormatMaskText(MASK_CONPAG5, recNotEle.strConPag), 29);
      objLiberacao.objMsgRemota.pAddTextoCaption('Prazo Médio da Nota'          , FormatFloat('#,##0.00', fCalcMediaPagto(recNotEle.strConPag)) , 29);
    End Else
    Begin
      objLiberacao.objMsgRemota.pAddTexto('Pedidos Pré-Nota:');
    End;

    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'Pedido'                , 12 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Condição de Pagamento' , 63 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Prazo Médio'           , 43 , alEsquerda , teAutcom);
    objTabela.lstLinhas.Add(objLinha);


    If Not cdsPedidos.IsEmpty Then
    Begin
      cdsPedidos.First;
      While Not cdsPedidos.Eof Do
      Begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Pedido'                , cdsPedidos.FieldByName('NUMPED').AsString                                                                            , 12 , alEsquerda);
        objLinha.pAddColuna('Condição de Pagamento' , FormatMaskText(MASK_CONPAG5, cdsPedidos.FieldByName('CONPAG').AsString) , 63 , alEsquerda);
        objLinha.pAddColuna('Prazo Médio'           , FloatToStrF(cdsPedidos.FieldByName('PRAMED').AsFloat, ffNumber, 11, 2)                                               , 43 , alEsquerda);
        objTabela.lstLinhas.Add(objLinha);


        cdsPedidos.Next;
      End;
    End;

    objLiberacao.objMsgRemota.lstRegistros.Add(objTabela);
  End;

  function fPedeSenhaLiberacao: Boolean;
    Var
      strLinha     : String;
      strDiverge   : String;
      intIndex     : Integer;
      cdsCriCad    : TUniClientDataSet;
      blnTemQtd    : Boolean;
   	  objLinha     : TLinhaMsgLibera;
  begin
    cdsCriCad := fRetCdsInconsistenciaCadastrais;

    objLiberacao.Clear;
    strDiverge := '';

    objMotivos.Delimiter := '/';
    objLiberacao.strMotivos := 'Motivos ' + objMotivos.DelimitedText.Replace('"','');
    objLiberacao.objMsgLibera.pAddTexto('Liberação de Pré-Nota com inconsistências');
    objLiberacao.objMsgLibera.pAddTextoCaption('Documento'       , recNotEle.strNumDoc                                                                      , 16);
    objLiberacao.objMsgLibera.pAddTextoCaption('Chave de Acesso' , recNotEle.str_Chave                                                                      , 16);
    objLiberacao.objMsgLibera.pAddTextoCaption('Data emissão'    , DateToStr(recNotEle.dtaDtaDoc)                                                           , 16);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cond. Pagamento' , FormatMaskText(MASK_CONPAG5, recNotEle.strConPag) , 16);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cond. Pag. Ped.' , FormatMaskText(MASK_CONPAG5, cdsPedidos.FieldByName('CONPAG').AsString) , 16);
    objLiberacao.objMsgLibera.pAddTextoCaption('Prazo Médio'     , FormatFloat('#,##0.00', fCalcMediaPagto(recNotEle.strConPag))                                  , 16);
    objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor'      , recNotEle.strCodFor + '-' + fRetNomFornecedor(recNotEle.strCodFor)                       , 16);

    If fltFrePed <> recNotEle.fltValFre Then
    Begin
      objLiberacao.objMsgLibera.pAddTextoCaption('Frete Pedido' , FormatFloat('#,##0.00', fltFrePed), 16);
      objLiberacao.objMsgLibera.pAddTextoCaption('Frete NF' , FormatFloat('#,##0.00', recNotEle.fltValFre), 16);
    End;


    pIncluiInconsistenciaConpag(fPosssuiInconsistenciaCondPagto);

    if fPosssuiInconsistenciasFrete Or (RoundTo(fltFrePed, -2) <> RoundTo(recNotEle.fltValFre, -2)) Then
    Begin
      objTabela := TRegistroMsgLiberaTabela.Create;

      For intIndex := 0 to Length(arrTipoFretePed) -1 Do
      Begin
        if arrTipoFretePed[intIndex][1] <> recNotEle.strTipFre Then
        Begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('PEDIDO'            , arrTipoFretePed[intIndex][0]                              , 22 , alEsquerda , teAmbos, True);
          objLinha.pAddColuna('TIPO DO FRETE'     , UpperCase(fDescricaoFrete(arrTipoFretePed[intIndex][1]))  , 46 , alEsquerda , teAmbos, True);
          objLinha.pAddColuna('TIPO DO FRETE NFE' , UpperCase(fDescricaoFrete(recNotEle.strTipFre))           , 50 , alEsquerda , teAmbos, True);
          objTabela.lstLinhas.Add(objLinha);

          strLinha := fPadR('PEDIDO: ' + arrTipoFretePed[intIndex][0] + ' TIPO DO FRETE: ' + UpperCase(fDescricaoFrete(arrTipoFretePed[intIndex][1])) + ' TIPO DO FRETE NFE: ' +  UpperCase(fDescricaoFrete(recNotEle.strTipFre)), 106);
          strDiverge := strDiverge + strLinha + STRING_QUEBRA;
        End;
      End;

      If (RoundTo(fltFrePed, -2) <> RoundTo(recNotEle.fltValFre, -2)) Then
      Begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Vr. Frete Ped' , FormatFloat('#,##0.00', fltFrePed)                        , 39 , alEsquerda , teAmbos, True);
        objLinha.pAddColuna('Vr. Frete NFe' , FormatFloat('#,##0.00', recNotEle.fltValFre)              , 39 , alEsquerda , teAmbos, True);
        objLinha.pAddColuna('Diferença'     , FormatFloat('#,##0.00', fltFrePed - recNotEle.fltValFre)  , 40 , alEsquerda , teAmbos, True);
        objTabela.lstLinhas.Add(objLinha);
      End;

      If (Not cdsCriticas.IsEmpty) Then
      Begin
        cdsCriticas.Filtered := False;
        cdsCriticas.Filter := 'NOT TRAPED = ' + QuotedStr('');
        cdsCriticas.Filtered := True;
        While Not (cdsCriticas.Eof) Do
        Begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('Item' , cdsCriticas.FieldByName('DESITE').AsString , 122 , alEsquerda , teAmbos);
          objTabela.lstLinhas.Add(objLinha);

          cdsCriticas.Next;
        End;

        cdsCriticas.Filtered := False;
        cdsCriticas.Filter := '';
      End;


      objLiberacao.objMsgRemota.lstRegistros.Add(objTabela);

    End;

    if (not cdsCriticas.IsEmpty) Then
    Begin
      objLiberacao.objMsgRemota.pAddSeparador(125);
      objLiberacao.objMsgRemota.pAddTexto('DIVERGÊNCIA DE QUANTIDADES, VALORES E IMPOSTOS', alCentro, teAmbos, '', 125);

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'Cod.'         , 7  , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'Descrição'    , 57 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'Quant.Ped.'   , 12 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'Quant.NFE.'   , 12 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'Vr.Unit.Ped.' , 12 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'Vr.Unit.NFE.' , 12 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , ''             , 66 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'Vr.IPI  Ped.' , 12 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'Vr.IPI  NFE'  , 12 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'Vr.ST  Ped.'  , 12 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'Vr.ST  NFE'   , 12 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);


      With cdsCriticas do
      begin
        intAgrupador := -1;
        First;
        While not Eof do
        Begin
          pAddArrMsgLib;

          strDiverge := strDiverge + FieldByName('DESITE').AsString + STRING_QUEBRA;

          if FieldByName('QTDPED').AsFloat < FieldByName('QTDNFE').AsFloat then
            strDiverge := strDiverge + '  >> QUANTIDADE DO PEDIDO INFERIOR À NOTA FISCAL' + STRING_QUEBRA;

          blnTemQtd := (RoundTo(FieldByName('QTDNFE').AsFloat, -4) > 0) And
                       (RoundTo(FieldByName('QTDPED').AsFloat, -4) > 0);

          if blnTemQtd And (FieldByName('UNIPED').AsFloat < FieldByName('UNINFE').AsFloat) then
            strDiverge := strDiverge + '  >> VALOR UNITÁRIO DO PEDIDO INFERIOR À NOTA FISCAL' + STRING_QUEBRA;

          if blnTemQtd And (FieldByName('IPIPED').AsFloat < FieldByName('IPINFE').AsFloat) then
            strDiverge := strDiverge + '  >> VALOR DE IPI DO PEDIDO INFERIOR À NOTA FISCAL' + STRING_QUEBRA;

          if blnTemQtd And (FieldByName('SUBPED').AsFloat < FieldByName('SUBNFE').AsFloat) then
            strDiverge := strDiverge + '  >> VALOR DA SUBSTITUIÇÃO DO PEDIDO INFERIOR À NOTA FISCAL' + STRING_QUEBRA;

          if FieldByName('FREPED').AsFloat < FieldByName('FRENFE').AsFloat then
            strDiverge := strDiverge + '  >> VALOR DO FRETE DO PEDIDO INFERIOR À NOTA FISCAL' + STRING_QUEBRA;

          If Not fEmptyStr(FieldByName('INFADI').AsString) Then
            strDiverge := strDiverge + '  >> ' + FieldByName('INFADI').AsString + STRING_QUEBRA;

          Next;
        End
      end;

      objLiberacao.objMsgRemota.lstRegistros.Add(objTabela);
    End;

    if (not cdsCriCad.IsEmpty) Then
    Begin
      objLiberacao.objMsgRemota.pAddSeparador(125);
      objLiberacao.objMsgRemota.pAddTexto('DIVERGÊNCIA DE DADOS CADASTRAIS', alCentro, teAmbos, '', 125);


      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'Cod.'                  , 7  , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'Descrição'             , 53 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'Código de Barras XML'  , 28 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'Código de Barras Cad.' , 28 , alEsquerda , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'Ocorrencias'           , 122, alEsquerda , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      With cdsCriCad Do
      Begin
        First;

        intAgrupador := -1;

        While Not Eof Do
        Begin
          pAddArrMsgLibCadastral(cdsCriCad);
          Next;
        End;

      End;

      objLiberacao.objMsgRemota.lstRegistros.Add(objTabela);
    End;

    objLiberacao.strDirAce := 'ENTLPN';
    objLiberacao.strSenLib := fCfgSis('SENLPN');
    objLiberacao.strMsgSen := 'Pré-Nota de Entrada';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;


    Result := objLiberacao.fLibera;

    strOpeLib := objLiberacao.strOperador;


    If Result Then
      Result := TfrmEntPreNotaEntradaMotivoLib.fRegistraMotivo(recNotEle.dtaDtaDoc,
                                                               recNotEle.strNumDoc,
                                                               'NF', //recNotEle.strEspDoc,
                                                               recNotEle.strSerDoc,
                                                               recNotEle.strCodFor,
                                                               VS_strCodEmp,
                                                               'F', //recNotEle.strTipoFc,
                                                               strOpeLib,
                                                               strDiverge);

    FreeAndNil(cdsCriCad);
  End;


  procedure pGravaDadosInconsistencia;
    var
      qryInsertCritica: TUniQuery;
  begin
    If Not cdsCriticas.RecordCount > 0 Then
      Exit;

    //ajusta cdsCriticas para grava separados todos itens conforme solicitado no requisito 279438
    fPosssuiInconsistencias(OnFilterRecordErros, True);

    qryInsertCritica := fCriaQuery;
    Try
      qryInsertCritica.SQL.Add('INSERT INTO PRECRI (');

      qryInsertCritica.SQL.Add('AUTOINCREM, CRI_CODITE, CRI_QTDPED, CRI_QTDNFE, CRI_UNIPED, CRI_UNINFE,');
      qryInsertCritica.SQL.Add('CRI_IPIPED, CRI_IPINFE, CRI_SUBPED, CRI_SUBNFE, CRI_FREPED, CRI_FRENFE,');
      qryInsertCritica.SQL.Add('CRI_INFADI, CRI_NFEEAN, CRI_CODBAR, CRI_TRAPED, CRI_TRAXML, CRI_OPELIB,');
      qryInsertCritica.SQL.Add('CRI_DTALIB, CRI_AUTNFE, CRI_DESITE, CRI_DESUNI, CRI_LOCFIS, CRI_CODFAB, CRI_NUMPED) VALUES ( ');
      qryInsertCritica.SQL.Add(':INCREM, :CODITE, :QTDPED, :QTDNFE, :UNIPED, :UNINFE,');
      qryInsertCritica.SQL.Add(':IPIPED, :IPINFE, :SUBPED, :SUBNFE, :FREPED, :FRENFE,');
      qryInsertCritica.SQL.Add(':INFADI, :NFEEAN, :CODBAR, :TRAPED, :TRAXML, :OPELIB,');
      qryInsertCritica.SQL.Add('CURDATE(), :AUTNFE, :DESITE, :DESUNI, :LOCFIS, :CODFAB, :NUMPED)');

      cdsCriticas.First;

      While Not cdsCriticas.Eof Do
      Begin
        qryInsertCritica.ParamByName('INCREM').AsString  := fRetAutoIncrem('PRECRI', VS_strCodEmp);
        qryInsertCritica.ParamByName('OPELIB').AsString := strOpeLib;
        qryInsertCritica.ParamByName('AUTNFE').Value := recNotEle.strAutInc;
        qryInsertCritica.ParamByName('CODITE').Value := cdsCriticas.FieldByName('CODITE').Value;
        qryInsertCritica.ParamByName('QTDPED').Value := cdsCriticas.FieldByName('QTDPED').Value;
        qryInsertCritica.ParamByName('QTDNFE').Value := cdsCriticas.FieldByName('QTDNFE').Value;
        qryInsertCritica.ParamByName('UNIPED').Value := cdsCriticas.FieldByName('UNIPED').Value;
        qryInsertCritica.ParamByName('UNINFE').Value := cdsCriticas.FieldByName('UNINFE').Value;
        qryInsertCritica.ParamByName('IPIPED').Value := cdsCriticas.FieldByName('IPIPED').Value;
        qryInsertCritica.ParamByName('IPINFE').Value := cdsCriticas.FieldByName('IPINFE').Value;
        qryInsertCritica.ParamByName('SUBPED').Value := cdsCriticas.FieldByName('SUBPED').Value;
        qryInsertCritica.ParamByName('SUBNFE').Value := cdsCriticas.FieldByName('SUBNFE').Value;
        qryInsertCritica.ParamByName('FREPED').Value := cdsCriticas.FieldByName('FREPED').Value;
        qryInsertCritica.ParamByName('FRENFE').Value := cdsCriticas.FieldByName('FRENFE').Value;
        qryInsertCritica.ParamByName('INFADI').Value := cdsCriticas.FieldByName('INFADI').Value;
        qryInsertCritica.ParamByName('NFEEAN').Value := cdsCriticas.FieldByName('NFEEAN').Value;
        qryInsertCritica.ParamByName('CODBAR').Value := cdsCriticas.FieldByName('CODBAR').Value;
        qryInsertCritica.ParamByName('TRAPED').Value := cdsCriticas.FieldByName('TRAPED').Value;
        qryInsertCritica.ParamByName('TRAXML').Value := cdsCriticas.FieldByName('TRAXML').Value;
        qryInsertCritica.ParamByName('DESITE').Value := cdsCriticas.FieldByName('DESITE').Value;
        qryInsertCritica.ParamByName('DESUNI').Value := cdsCriticas.FieldByName('DESUNI').Value;
        qryInsertCritica.ParamByName('LOCFIS').Value := cdsCriticas.FieldByName('LOCFIS').Value;
        qryInsertCritica.ParamByName('CODFAB').Value := cdsCriticas.FieldByName('CODFAB').Value;
        qryInsertCritica.ParamByName('NUMPED').Value := cdsCriticas.FieldByName('NUMPED').Value;
        qryInsertCritica.ExecSQL;
        cdsCriticas.Next;
      End;
    Finally
      FreeAndNil(qryInsertCritica);
    end;
  end;

Begin
  Result := False;

  stlErro := TStringList.Create;
  Try
    If fJaExistePedEleParaANota Then
    Begin
      fMensagem('', 'Já existe pré-nota para esta nota!', ['&OK']);
      Exit;
    End;


    If (Not Active) Or IsEmpty Then
    Begin
      fMensagem('', 'Selecione a nota eletrônica e também o pedido de compra para continuar!', ['&OK']);
      Exit;
    End;


    If Not fTemDefinicaoDeBaixa Then
    Begin
      fMensagem('', 'Não foi possível encontrar saldo para baixar os pedidos para esta nota!', ['&OK']);
      Exit;
    End;

    blnPossuiInconsistencia := fPosssuiInconsistencias(OnFilterRecordErros);

    If (Not blnPossuiInconsistencia) Or fPedeSenhaLiberacao Then
    Begin

      If fEmptyStr(strOpeLib) Then
        strOpeLib := strLoginUsuarioLogado;


      If Not fDigDadosContaPagar Then
      Begin
        fMensagem('', 'A CFG_UTDCPP está ativada, os dados do Contas a Pagar devem ser informados na rotina de Pré-Nota', ['&OK']);
        Exit;
      End;

      fStartTransaction;


      qryUpdate := fCriaQuery(Self);

      With qryUpdate, SQL Do
      Begin
        Close;
        Clear;

        Add('UPDATE GERELE');
        Add('SET GER_DTALIB = :DTALIB,');
        Add('    GER_HORLIB = :HORLIB,');
        Add('    GER_OPELIB = :OPELIB, ');
        Add('    GER_UNICOM = :UNICOM, ');
        Add('    GER_COTMOE = :COTMOE  ');
        Add('WHERE AUTOINCREM = :AUTINC');

        ParamByName('DTALIB').AsDate   := VS_Date;
        ParamByName('HORLIB').AsTime   := fTime();
        ParamByName('OPELIB').AsString := strOpeLib;
        ParamByName('AUTINC').AsString := recNotEle.strAutInc;
        ParamByName('COTMOE').AsFloat  := fltCotMoe;

        If FConverteEmbalagens Then
          ParamByName('UNICOM').AsString := 'S'
        Else
          ParamByName('UNICOM').AsString := 'N';

        ExecSQL;

        pSalvaEmbalagensProduto;

        Close;
        Clear;

        Add('INSERT INTO PEDELE');
        Add('            (AUTOINCREM,');
        Add('             PEL_SEQELE,');
        Add('             PEL_NUMDOC,');
        Add('             PEL_ESPDOC,');
        Add('             PEL_CODEMP,');
        Add('             PEL_CODFOR)');
        Add('VALUES (:AUTINC,');
        Add('        :SEQELE,');
        Add('        :NUMDOC,');
        Add('        :ESPDOC,');
        Add('        :CODEMP,');
        Add('        :CODFOR)');

        For intPedidos := 0 to stlPedidos.Count - 1 Do
        Begin
          If Not fTemDefinicaoParaOPedido(stlPedidos[intPedidos]+'-'+stlEmpresas[intPedidos]) Then
            continue;
          strAutIncPedEle := fRetAutoIncrem('PEDELE', VS_strCodEmp);
          ParamByName('AUTINC').AsString := strAutIncPedEle;
          ParamByName('SEQELE').AsString := recNotEle.strAutInc;
          ParamByName('NUMDOC').AsString := stlPedidos[intPedidos];
          ParamByName('ESPDOC').AsString := 'PD';
          ParamByName('CODEMP').AsString := stlEmpresas[intPedidos];
          ParamByName('CODFOR').AsString := recNotEle.strCodFor;
          If Not fVerificaSePedidoExiste(stlPedidos[intPedidos], stlEmpresas[intPedidos], 'PD') Then
          Begin
            fRollback;
            pMensagemOk('O Pedido ' + stlPedidos[intPedidos] + ' - ' + stlEmpresas[intPedidos] + ' PD não foi encontrado no sistem.');
            Exit;
          End;

          ExecSQL;

          If (VS_strHabilitarCRM) Then
          Begin
            TUpdateOccurrenceCRM.New()
              .NumDoc(stlPedidos[intPedidos])
              .EspDoc('PD')
              .CodEmp(stlEmpresas[intPedidos])
              .AcaFat(afcPedidoInclusaoPreNota)
              .strNomFrm('[TPreNota.fConfirma]')
              .pRun();
          End;

        End;

      End;

      pIncluiPreBaixaPedido;

      If Assigned(frmVinculoBaixaEntregaFuturaEdocVenda) Then
        frmVinculoBaixaEntregaFuturaEdocVenda.fGravaVinculosNoBanco(strAutIncPedEle);

      Result := cdsDefBai.fSalva;

      TDefineBaixaPedido.ProcessaStatusPedidoRequisicaoConferencia(recNotEle.strAutInc);

      If blnPossuiInconsistencia Then
        pGravaDadosInconsistencia;

      Result := Result And fValidaPEDELE(recNotEle.strAutInc, stlErro);
      Result := Result And fValidaGravacaoItens(recNotEle.strAutInc, stlErro);

      If Result Then
      Begin
        fCommit;

        fTravaDestravaPedidos(False);

        pMensagemOk('Liberação efetuada com sucesso!');
      End Else
      Begin
        fRollBack;

        If stlErro.Count > 0 Then
        Begin
          pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
          Try

            frmMensagemExplicativa.Caption := 'Gravação pré-nota';
            frmMensagemExplicativa.Width   := 800;
            frmMensagemExplicativa.Height  := 550;
            frmMensagemExplicativa.RitchObservacao.Visible:= True;
            frmMensagemExplicativa.RitchObservacao.BringToFront;
            frmMensagemExplicativa.RitchObservacao.Lines.Text := stlErro.Text;
            frmMensagemExplicativa.ShowModal;
          Finally
            pFreeAndNil(frmMensagemExplicativa);
          End;
        End;
      End;

      FreeAndNil(qryUpdate);
    End;

    strAutIncPedEle := '';

  Except
    On E: Exception Do
    Begin
      Result := False;
      strAutIncPedEle := '';

      fRollBack;
      pMensagensErro(E.Message,'');
    End;
  End;
  blnPedidoGeradoAuto := False;

  FreeAndNil(stlErro);

End;

function TPreNota.fDigDadosContaPagar: Boolean;
var
  frmEntDadosFiscaisResumo : TfrmEntDadosFiscaisResumo;
  stlPedidos: TStringList;
begin
  frmEntDadosFiscaisResumo := nil;

  pZeraDigDuplic(arrDuplicata);
  stlPedidos := TStringList.Create;

  If (Not fCfgSis('UTDCPP', varBoolean)) Or (blnPedidoGeradoAuto) Then
  Begin
    FreeAndNil(stlPedidos);
    Exit(True);
  End
  Else
  Begin

    Try
      Try
      pCriarFormularios(TfrmEntDadosFiscaisResumo, frmEntDadosFiscaisResumo);
      frmEntDadosFiscaisResumo.FblnAcessadoViaPrenota   := True;
      frmEntDadosFiscaisResumo.arrDuplicata             := @Self.arrDuplicata;
      frmEntDadosFiscaisResumo.mskCompet.Text           := FormatDateTime('mm/YYYY',VS_Date);
      frmEntDadosFiscaisResumo.pnlCabecalho.Visible     := False;
      frmEntDadosFiscaisResumo.pnlDetalhes.Visible      := False;
      frmEntDadosFiscaisResumo.btnOutDes.Visible        := False;
      frmEntDadosFiscaisResumo.btnImpEspelho.Visible    := False;
      frmEntDadosFiscaisResumo.btnConFre.Visible        := False;
      frmEntDadosFiscaisResumo.btnConfDigitacao.Visible := False;
      frmEntDadosFiscaisResumo.btnGnreST.Visible        := False;
      frmEntDadosFiscaisResumo.btnGnreTribut.Visible    := False;
      frmEntDadosFiscaisResumo.btnTCIF.Visible          := False;
      frmEntDadosFiscaisResumo.btnTS.Visible            := False;
      frmEntDadosFiscaisResumo.lblCodOpe.Visible        := False;
      frmEntDadosFiscaisResumo.edtCodOpe.Visible        := False;
      frmEntDadosFiscaisResumo.edtNomOpe.Visible        := False;
      frmEntDadosFiscaisResumo.lblModFre.Visible        := False;
      frmEntDadosFiscaisResumo.cbxModFre.Visible        := False;
      frmEntDadosFiscaisResumo.lblQtdVol.Visible        := False;
      frmEntDadosFiscaisResumo.edtQtdVol.Visible        := False;
      frmEntDadosFiscaisResumo.lblEspVol.Visible        := False;
      frmEntDadosFiscaisResumo.edtEspVol.Visible        := False;
      frmEntDadosFiscaisResumo.lblPesLiq.Visible        := False;
      frmEntDadosFiscaisResumo.edtPesLiq.Visible        := False;
      frmEntDadosFiscaisResumo.lblPesBru.Visible        := False;
      frmEntDadosFiscaisResumo.edtPesBru.Visible        := False;
      frmEntDadosFiscaisResumo.lblChaNFE.Visible        := False;
      frmEntDadosFiscaisResumo.edtChaNFE.Visible        := False;
      frmEntDadosFiscaisResumo.lblCODMOD.Visible        := False;
      frmEntDadosFiscaisResumo.cbxCODMOD.Visible        := False;
      frmEntDadosFiscaisResumo.chkAtuPre.Visible        := False;
      frmEntDadosFiscaisResumo.lblHistorioLivroFiscal.Visible := False;
      frmEntDadosFiscaisResumo.edtHistorioLivroFiscal.Visible := False;

      frmEntDadosFiscaisResumo.Height := frmEntDadosFiscaisResumo.Height -
                                         frmEntDadosFiscaisResumo.pnlCabecalho.Height -
                                         frmEntDadosFiscaisResumo.pnlDetalhes.Height +
                                         frmEntDadosFiscaisResumo.pnlCheckBox.Height +
                                         frmEntDadosFiscaisResumo.pnlBotoesEnt.Height;

      frmEntDadosFiscaisResumo.fltCotDol                := fltCotMoe;
      frmEntDadosFiscaisResumo.recNotEle                := recNotEle;
      frmEntDadosFiscaisResumo.strNumDoc                := recNotEle.strNumDoc;
      frmEntDadosFiscaisResumo.strSerie                 := recNotEle.strSerDoc;
      frmEntDadosFiscaisResumo.strEspDoc                := strEspDoc;
      frmEntDadosFiscaisResumo.strCodFor                := recNotEle.strCodFor;
      frmEntDadosFiscaisResumo.dtaDtaDoc                := recNotEle.dtaDtaDoc;
      frmEntDadosFiscaisResumo.dtaDtaent                := VS_Date;
      frmEntDadosFiscaisResumo.stlPedidos               := stlPedidos;
      frmEntDadosFiscaisResumo.fltTotIte                := fltTotNF_;
      frmEntDadosFiscaisResumo.edtVlrCon.Text           := FloatToStrF(fltTotNF_, ffFixed, 12, 2);
      frmEntDadosFiscaisResumo.blnNotaImp               := recNotEle.blnEhNotaImportacao;

      frmEntDadosFiscaisResumo.showModal;
      Result := frmEntDadosFiscaisResumo.blnConfirma;
    Finally
      pFreeAndNil(frmEntDadosFiscaisResumo);
      FreeAndNil(stlPedidos);
    End;


    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[frmEntDadosFiscais.btnConfirmaClick]');
      End;
    End;
  End;

end;

function TPreNota.fJaExistePedEleParaANota: Boolean;
var
  qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD FROM PEDELE WHERE PEL_SEQELE = "'+recNotEle.strAutInc+'"');
    qryConsulta.Open;
    Result := qryConsulta.FieldByName('QTD').AsInteger > 0;
  Finally
    FreeAndNil(qryConsulta)
  End;
end;

Function TPreNota.fSQLPreBai: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' INSERT INTO PREBAI ';
  strSQL := strSQL + ' (PRE_AUTPED, PRE_AUTELE, PRE_QTDBAI, PRE_UNIBAI) VALUES ';
  strSQL := strSQL + ' (:AUTPED, :AUTELE, :QTDBAI, :UNIBAI)';

  Result := strSQL;
End;

Procedure TPreNota.pIncluiPreBaixaPedido;
  Var
    stlListaPedidos: TStringList;
    intContador: Integer;
Begin
  With cdsItemPed Do
  Try
    stlListaPedidos            := TStringList.Create;
    stlListaPedidos.Sorted     := True;
    stlListaPedidos.Duplicates := dupIgnore;

    Filter   := 'ITE_SELPED > 0';
    Filtered := True;

    First;
    While Not Eof Do
    Begin

      qryPreBai.Close;
      qryPreBai.ParamByName('AUTPED').AsString := FieldByName('AUTOINCREM').AsString;
      qryPreBai.ParamByName('AUTELE').AsString := recNotEle.strAutInc;
      qryPreBai.ParamByName('QTDBAI').AsFloat  := FieldByName('ITE_SELPED').AsFloat;
      qryPreBai.ParamByName('UNIBAI').AsFloat  := FieldByName('ITE_UNINFE').AsFloat;
      qryPreBai.ExecSQL;

      stlListaPedidos.Add(FieldByName('AUTPCG').AsString);

      Next;
    End;

    For intContador := 0 To stlListaPedidos.Count - 1 Do
      fAtualizaFornecedorPedido(stlListaPedidos[intContador], recNotEle.strCodFor);

    FreeAndNil(stlListaPedidos);

  Finally
    Filtered := False;
  End;
End;

Function TPreNota.fSQLCriticas: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   C.ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '   CAST("" AS CHAR(150)) AS DESITE, ';
  strSQL := strSQL + '   UNI_SIGUNI AS DESUNI, ';
  strSQL := strSQL + '   ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '   ITE_LOCFIS AS LOCFIS, ';
  strSQL := strSQL + '   ITE_SALDOS AS SALDOS, ';
  strSQL := strSQL + '   C.ITE_CODBAR AS NFEEAN, ';
  strSQL := strSQL + '   C.ITE_CODBAR AS CODBAR, ';

  strSQL := strSQL + '   0.0000     AS QTDPED, ';
  strSQL := strSQL + '   0.0000     AS QTDNFE, ';
  strSQL := strSQL + '   0.0000     AS QTDRES, ';

  strSQL := strSQL + '   0.0000     AS UNIPED, ';
  strSQL := strSQL + '   0.0000     AS UNINFE, ';
  strSQL := strSQL + '   0.0000     AS TOTGER, ';

  strSQL := strSQL + '   0.0000     AS IPIPED, ';
  strSQL := strSQL + '   0.0000     AS IPINFE, ';

  strSQL := strSQL + '   0.0000     AS SUBPED, ';
  strSQL := strSQL + '   0.0000     AS SUBNFE, ';

  strSQL := strSQL + '   0.0000     AS FREPED, ';
  strSQL := strSQL + '   0.0000     AS FRENFE, ';
  strSQL := strSQL + '   CAST("" AS CHAR(20)) AS AUTNFE, ';

  strSQL := strSQL + '   CAST("" AS CHAR(255)) AS INFADI, ';
  strSQL := strSQL + '   CAST("" AS CHAR(030)) AS TRAPED, ';
  strSQL := strSQL + '   CAST("" AS CHAR(030)) AS TRAXML, ';
  strSQL := strSQL + '   CAST("" AS CHAR(030)) AS NUMPED, ';
  strSQL := strSQL + '   CAST("" AS CHAR(030)) AS ORD_NROITE  ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADITE C ';
  strSQL := strSQL + ' INNER JOIN ITEGER G ON G.ITE_CODITE = C.ITE_CODITE AND FALSE AND ';
  strSQL := strSQL + '                        G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) ;

  strSQL := strSQL + ' LEFT JOIN CADUNI ON UNI_CODUNI = C.ITE_CODUNI ';

  strSQL := strSQL + ' WHERE FALSE ';

  Result := strSQL;
End;

procedure TPreNota.pVerificaItensComProblemasCadastro;
  var
    qryItem  : TUniQuery;
    strInfAdi: String;
Begin
  qryItem := fCriaQuery(Self);

  With qryItem, SQL Do
  Begin
    Close;
    Clear;

    Add('SELECT');
    Add('  SQL_NO_CACHE');
    Add('  CONCAT(ITE_CODBAR, " ", GROUP_CONCAT(IFNULL(BAR_CODBAR, "") SEPARATOR " ")) AS ITE_CODBAR, ');
    Add('  ITE_UNICOM,');
    Add('  ITE_EMBALA,');
    Add('  ITE_BAREMB');
    Add('FROM');
    Add('  CADITE');
    Add('  LEFT JOIN ITEBAR ON ITEBAR.BAR_CODITE = ITE_CODITE ');
    Add('WHERE');
    Add('  ITE_CODITE = :CODITE');

  End;

  With cdsCriticas Do
  Begin
    First;

    While Not Eof Do
    Begin
      If cdsCriticas.FieldByName('CODITE').AsString = iif(fTamCodIte = 5,'00000', '0000000') Then
      Begin
        Next;
        Continue;
      End;

      qryItem.Close;
      qryItem.ParamByName('CODITE').AsString := cdsCriticas.FieldByName('CODITE').AsString;
      qryItem.Open;

      Edit;

      FieldByName('CODBAR').AsString := qryItem.FieldByName('ITE_CODBAR').AsString;

      strInfAdi := '';
      FieldByName('INFADI').AsString := '';

      If fEmptyStr(qryItem.FieldByName('ITE_CODBAR').AsString) Then
        FieldByName('INFADI').AsString :=
          FieldByName('INFADI').AsString + 'Código de Barras não cadastrado / '

      Else If (Not fEmptyStr(cdsCriticas.FieldByName('NFEEAN').AsString)) And (Pos(FieldByName('NFEEAN').AsString, qryItem.FieldByName('ITE_CODBAR').AsString) = 0) Then
        FieldByName('INFADI').AsString :=
          cdsCriticas.FieldByName('INFADI').AsString + 'Código de Barras cadastrado Diferente do Contido no XML / ';

      If (strCnvEmb <> 'N') And (qryItem.FieldByName('ITE_EMBALA').AsFloat > 0) Then
      Begin
        If fEmptyStr(qryItem.FieldByName('ITE_BAREMB').AsString) Then
          FieldByName('INFADI').AsString :=
            FieldByName('INFADI').AsString + 'Código de Barras Emb. não cadastrado / ';

         If fEmptyStr(qryItem.FieldByName('ITE_UNICOM').AsString) Then
            FieldByName('INFADI').AsString :=
              FieldByName('INFADI').AsString + 'Unidade de compra não cadastrada / ';
      End;

      strInfAdi := Trim(cdsCriticas.FieldByName('INFADI').AsString);

      If (Not fEmptyStr(strInfAdi)) And (strInfAdi[Length(strInfAdi)] = '/') Then
      Begin
        FieldByName('INFADI').AsString := LeftStr(strInfAdi, Length(strInfAdi) - 1);
      End;

      Post;

      Next;
    End;

    First;

  End;

  FreeAndNil(qryItem);
End;

procedure TPreNota.OnFilterRecordErros(DataSet: TDataSet;  var Accept: Boolean);
Begin
  Accept := ( ( DataSet.FieldByName('QTDNFE').AsFloat - DataSet.FieldByName('QTDPED').AsFloat ) > fltOciQtd ) Or

            ( DataSet.FieldByName('QTDRES').AsFloat  > fltOciQtd ) Or

            ( (RoundTo(DataSet.FieldByName('QTDNFE').AsFloat, -4) > 0) And
              (RoundTo(DataSet.FieldByName('QTDPED').AsFloat, -4) > 0) And

              (( Abs( RoundTo(DataSet.FieldByName('UNINFE').AsFloat - DataSet.FieldByName('UNIPED').AsFloat , -4)) > fltOciVlr ) Or
               ( Abs( RoundTo(DataSet.FieldByName('IPINFE').AsFloat - DataSet.FieldByName('IPIPED').AsFloat , -4)) > fltOciVlr ) Or
               ( Abs( RoundTo(DataSet.FieldByName('SUBNFE').AsFloat - DataSet.FieldByName('SUBPED').AsFloat , -4)) > fltOciVlr ))) Or

            ( Abs( RoundTo(DataSet.FieldByName('FRENFE').AsFloat - DataSet.FieldByName('FREPED').AsFloat, intDecUni * -1)) > fltOciVlr ) Or
            ( not fEmptyStr(DataSet.FieldByName('INFADI').AsString));

End;

procedure TPreNota.pOnFilterRecordDifTolerancia(DataSet: TDataSet; var Accept: Boolean; blnComFrete: Boolean);
Begin

  Accept := ( Abs( DataSet.FieldByName('QTDPED').AsFloat - DataSet.FieldByName('QTDNFE').AsFloat ) > fltOciQtd ) Or

            ( DataSet.FieldByName('QTDRES').AsFloat  > fltOciQtd ) Or

            ( (RoundTo(DataSet.FieldByName('QTDNFE').AsFloat, -4) > 0) And
              (RoundTo(DataSet.FieldByName('QTDPED').AsFloat, -4) > 0) And

              (( Abs( RoundTo(DataSet.FieldByName('UNIPED').AsFloat - DataSet.FieldByName('UNINFE').AsFloat , -4)) > fltOciVlr ) Or
               ( Abs( RoundTo(DataSet.FieldByName('IPIPED').AsFloat - DataSet.FieldByName('IPINFE').AsFloat , -4)) > fltOciVlr ) Or
               ( Abs( RoundTo(DataSet.FieldByName('SUBPED').AsFloat - DataSet.FieldByName('SUBNFE').AsFloat , -4)) > fltOciVlr ))) Or

            ( Abs( RoundTo(DataSet.FieldByName('FREPED').AsFloat - DataSet.FieldByName('FRENFE').AsFloat , intDecUni * -1)) > fltOciVlr ) Or
            ( not fEmptyStr(DataSet.FieldByName('INFADI').AsString));

  If blnComFrete Then
    Accept := Accept Or (DataSet.FieldByName('CODITE').AsString = StringOfChar('0', fTamCodIte));
End;

procedure TPreNota.OnFilterRecordDifTolerancia(DataSet: TDataSet; var Accept: Boolean);
Begin
  pOnFilterRecordDifTolerancia(DataSet, Accept, False);
End;

procedure TPreNota.OnFilterRecordDifToleranciaFrete(DataSet: TDataSet;  var Accept: Boolean);
Begin
  pOnFilterRecordDifTolerancia(DataSet, Accept, True);
End;

Function TPreNota.fPosssuiInconsistenciaCondPagto: Boolean;
  Var
    fltPraNot: Double;
Begin
  fltPraNot := fCalcMediaPagto(recNotEle.strConPag);
  Result := False;

  If Not cdsPedidos.IsEmpty Then
  Begin
    cdsPedidos.First;
    While Not cdsPedidos.Eof Do
    Begin
      If RoundTo(cdsPedidos.FieldByName('PRAMED').AsFloat, -2) > RoundTo(fltPraNot, -2) Then
      Begin
        Result := True;
        Break;
      End;

      cdsPedidos.Next;
    End;
  End;
End;

Function TPreNota.fPosssuiInconsistencias(prcFiltro: TFilterRecordEvent = Nil; blnGravarItensSeparados: Boolean = False): Boolean;
Begin
  Result := False;

  If blnPedidoGeradoAuto Then
    Exit;

  If cdsCriticas.fAbreClient(True, 'TPreNota.fPosssuiInconsistencias') Then
  Begin

    cdsCriticas.Filtered := False;

    pInsereItensCdsCriticas(blnGravarItensSeparados);

    pVerificaItensComProblemasCadastro;

    if Assigned(prcFiltro) Then
      cdsCriticas.OnFilterRecord := prcFiltro
    Else
      cdsCriticas.OnFilterRecord := OnFilterRecordDifTolerancia;

    cdsCriticas.Filtered := True;
    Result := (Not cdsCriticas.IsEmpty) or fPosssuiInconsistenciasFrete Or
              fPosssuiInconsistenciaCondPagto;
  End;
End;

function TPreNota.fPosssuiInconsistenciasFrete: Boolean;
  Var
    intIndex : Integer;
begin
  Result := False;
  For intIndex := 0 to Length(arrTipoFretePed) -1 Do
  Begin
    if arrTipoFretePed[intIndex][1] <> recNotEle.strTipFre Then
    Begin
      Result := True;
      Break;
    End;
  End;

  If (Not Result) And (recNotEle.strTipFre = '2') Then
    Result := fCnpjTransportadoraDiferente;
end;

function TPreNota.fCnpjTransportadoraDiferente(strNumped: string = ''): Boolean;

  function fValida: boolean;
  Begin
     Result := (LeftStr(cdspedidos.FieldByName('TRAPED').AsString, 8) <> LeftStr(recNotEle.strCnpjTr, 8));
  End;

begin
  //Se a base do cnpj do pedido diferento da base de cnpj da nota gera critica
  // proucura divergencia
  Result := False;

  If Not cdsPedidos.IsEmpty Then
  Begin
    cdsPedidos.First;

    If strNumped <> '' Then
    Begin
      If cdsPedidos.Locate('NUMPED', strNumPed, []) Then
        Result := fValida;
    End
    Else
    Begin
      While not cdsPedidos.EoF do
      Begin
        Result := fValida;
        If Result Then
          Break;
        cdsPedidos.Next
      End;
    end;

  End;

End;

procedure TPreNota.pIncluiCritica(strCodIte,
                                  strDesIte,
                                  strDesUni,
                                  strCodFab,
                                  strLocFis: String;
                                  fltQtdPed,
                                  fltQtdNfe,
                                  fltQtdRes,
                                  fltSaldos,
                                  fltUniPed,
                                  fltUniNfe,
                                  fltTotGer,
                                  fltIpiPed,
                                  fltIpiNfe,
                                  fltSubPed,
                                  fltSubNfe,
                                  fltFrePed,
                                  fltFreNfe: Double;
                                  strNfeEan,
                                  strTraPed,
                                  strTraXml,
                                  strNFE,
                                  strNumPed: String;
                                  blnInserirTodosItens: Boolean = False;
                                  strOrdNROITE: String = '');

Begin
  With cdsCriticas Do
  Begin

    If blnInserirTodosItens Then
      Insert
    Else
    Begin
      If (strCodIte <> StringOfChar('0', fTamCodIte)) And
         Locate('CODITE', strCodIte, []) Then
      Begin
        Edit
      End Else
      Begin
        Insert;
      End;
    End;

    FieldByName('CODITE').AsString := strCodIte;
    FieldByName('DESITE').AsString := strDesIte;
    FieldByName('CODFAB').AsString := strCodFab;
    FieldByName('LOCFIS').AsString := strLocFis;
    FieldByName('DESUNI').AsString := strDesUni;

    FieldByName('QTDPED').AsFloat  := FieldByName('QTDPED').AsFloat + RoundTo(fltQtdPed,-4);
    If (cdsCriticas.State = dsInsert) Or ((cdsCriticas.State = dsEdit) and (cdsCriticas.FieldByName('ORD_NROITE').AsString <> strOrdNROITE)) Then
      FieldByName('QTDNFE').AsFloat  := FieldByName('QTDNFE').AsFloat + RoundTo(fltQtdNfe,-4);

    If cdsCriticas.State = dsInsert Then
    Begin
      FieldByName('QTDRES').AsFloat  := RoundTo(fltQtdRes,-4);
      FieldByName('UNIPED').AsFloat  := RoundTo(fltUniPed,-4);
      FieldByName('UNINFE').AsFloat  := RoundTo(fltUniNfe,-4);
      FieldByName('TOTGER').AsFloat  := RoundTo(fltTotGer,-4);
      FieldByName('IPIPED').AsFloat  := RoundTo(fltIpiPed,-4);
      FieldByName('IPINFE').AsFloat  := RoundTo(fltIpiNfe,-4);
      FieldByName('SUBPED').AsFloat  := RoundTo(fltSubPed,-4);
      FieldByName('SUBNFE').AsFloat  := RoundTo(fltSubNfe,-4);
      FieldByName('FREPED').AsFloat  := RoundTo(fltFrePed,-4);
      FieldByName('FRENFE').AsFloat  := RoundTo(fltFreNfe,-4);
    End;
    FieldByName('SALDOS').AsFloat  := fltSaldos;
    FieldByName('NFEEAN').AsString := strNfeEan;
    FieldByName('AUTNFE').AsString := strNFE;

    if strCodIte = StringOfChar('0', fTamCodIte) Then
    Begin
      FieldbyName('TRAPED').AsString := strTraPed;
      FieldbyName('TRAXML').AsString := strTraXml;

      FieldByName('QTDPED').Clear;
      FieldByName('QTDNFE').Clear;
      FieldByName('QTDRES').Clear;
      FieldByName('UNIPED').Clear;
      FieldByName('UNINFE').Clear;
      FieldByName('TOTGER').Clear;
      FieldByName('IPIPED').Clear;
      FieldByName('IPINFE').Clear;
      FieldByName('SUBPED').Clear;
      FieldByName('SUBNFE').Clear;
      FieldByName('FREPED').Clear;
      FieldByName('FRENFE').Clear;
      FieldByName('SALDOS').Clear;
    End;

    If Not fEmptyStr(strNumPed) Then
      FieldByName('NUMPED').AsString := strNumPed
    Else
      FieldByName('NUMPED').Clear;

    cdsCriticas.FieldByName('ORD_NROITE').AsString := strOrdNROITE;

    Post;
  End;
End;

procedure TPreNota.pInsereItensCdsCriticas(blnGravarItensSeparados: Boolean = False);
  Var
    intIndex : Integer;
Begin
  if fPosssuiInconsistenciasFrete Then
  Begin

    For intIndex := 0 to Length(arrTipoFretePed) -1 Do
    Begin
      if arrTipoFretePed[intIndex][1] <> recNotEle.strTipFre Then
      Begin
        pIncluiCritica('00000',
                       '  - PEDIDO: ' + arrTipoFretePed[intIndex][0] + ' TIPO DO FRETE: ' + UpperCase(fDescricaoFrete(arrTipoFretePed[intIndex][1])) + ' TIPO DO FRETE NFE: ' +  UpperCase(fDescricaoFrete(recNotEle.strTipFre)),
                       '',
                       '',
                       '',
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       '',
                       '',
                       '',
                       recNotEle.strAutInc,
                       '');
      End;

      //Quando o tipo frete for Destinatario (FOB) Criticar a transportadora
      If (recNotEle.strTipFre = '2') and fCnpjTransportadoraDiferente(arrTipoFretePed[intIndex][0]) Then
      Begin
        pIncluiCritica('00000',
                       ' - PEDIDO: ' + arrTipoFretePed[intIndex][0] + ' TRANSPORTADORA DIVERGENTE: [PEDIDO = ' + cdsPedidos.FieldByName('TRAPED').AsString + '] [' + 'NOTA = ' + string(recNotEle.strCnpjTr) + ']',
                       '',
                       '',
                       '',
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       0,
                       '',
                       cdsPedidos.FieldByName('TRAPED').AsString,
                       recNotEle.strCnpjTr,
                       recNotEle.strAutInc,
                       '');
      End;


    End;

  End;

  DisableControls;

  IndexFieldNames := 'NROITE;CODITE;NUMPED';

  First;
  While Not Eof Do
  Begin
    pIncluiCritica(FieldByName('CODITE').AsString,
                   FieldByName('DESITE').AsString,
                   FieldByName('SIGUNI').AsString,
                   IIF(fEmptyStr(FieldByName('CODFAB').AsString), FieldByName('CFBITE').AsString, FieldByName('CODFAB').AsString),
                   FieldByName('LOCFIS').AsString,
                   FieldByName('TOTPED').AsFloat, //fRetQtdPed(FieldByName('CODITE').AsString), { FieldByName('QTDPED').AsFloat}
                   FieldByName('QTDNFE').AsFloat, // QTDNFE_UNI FieldByName('QTDNFE').AsFloat,
                   FieldByName('QTDRES').AsFloat,
                   FieldByName('SALDOS').AsFloat,
                   FieldByName('UNIPED').AsFloat,
                   FieldByName('UNINFE').AsFloat,
                   FieldByName('TOTGER').AsFloat,
                   FieldByName('IPIPED').AsFloat,
                   FieldByName('IPINFE').AsFloat,
                   FieldByName('SUBPED').AsFloat,
                   FieldByName('SUBNFE').AsFloat,
                   fltFrePed,
                   recNotEle.fltValFre,
                   FieldByName('NFEEAN').AsString,
                   '',
                   '',
                   recNotEle.strAutInc,
                   FieldByName('NUMPED').AsString,
                   blnGravarItensSeparados,
                   FieldByName('ORD_NROITE').AsString);
    Next;
  End;

  EnableControls;

end;

procedure TPreNota.pMostraCriticas;
  Var
    qryEditor: TUniQuery;
    strSQL: String;
    strNomeTabela: String;

  function fRetCompradores: String;
    var
      blnCriouQuery: Boolean;
      qryConsulta: TUniQuery;
  begin
    blnCriouQuery := False;
    If Not Assigned(qryConsulta) Then
    Begin
      qryConsulta := fCriaQuery;
      blnCriouQuery := True;
    End;

    Try
      qryConsulta.SQl.Clear;
      qryConsulta.SQL.Add('SELECT  GROUP_CONCAT(DISTINCT PCG_CODCMP, " - ", OPE_NOMOPE) AS COMPRADOR');
      qryConsulta.SQL.Add('  FROM PCMGER ');
      qryConsulta.SQL.Add('  LEFT JOIN CADOPE ON OPE_CODOPE = PCG_CODCMP ');
      qryConsulta.SQL.Add('  WHERE PCG_NUMPED IN ('+ fCommaText(stlPedidos, True) +')');
      qryConsulta.SQL.Add('  AND PCG_ESPDOC = "PD"');
      qryConsulta.SQL.Add('  AND IFNULL(PCG_EMPDES, PCG_CODEMP) = "'+VS_StrCodEmp + '"');
      qryConsulta.SQL.Add('  AND IFNULL(PCG_CODCMP, "") <> ""');

      qryConsulta.Open;

      Result := qryConsulta.FieldByName('COMPRADOR').AsString;
    Finally
      If blnCriouQuery Then
        FreeAndNil(qryConsulta);
    End;

    {}
  end;


begin
  If (Not Active) Then
    Exit;

  If Not fPosssuiInconsistencias Then
  Begin
    fMensagem('', 'Não há inconsistências no Pedido!', ['&Ok']);
    Exit;
  end;

  Try
    cdsCriticas.Filtered := False;
    cdsCriticas.IndexFieldNames := 'DESITE';
    cdsCriticas.OnFilterRecord := OnFilterRecordDifToleranciaFrete;
    cdsCriticas.Filtered := True;

    cdsCriticas.Filtered := False;
    cdsCriticas.Filter := ReplaceStr(cdsCriticas.Filter, 'OR (INFADI <> '''')', '' );
    cdsCriticas.Filtered := True;

    qryEditor := fCriaQuery(nil);

    strSQL := '';
    strSQL := strSQL + 'SET @PEDIDO := :PEDIDO; ';
    strSQL := strSQL + 'SET @COMPRADOR := :COMPRADOR; ';
    strSQL := strSQL + 'SET @NFE := :NFE; ';
    strSQL := strSQL + 'SET @LOJA := :LOJA; ';
    strSQL := strSQL + 'SET @FORNECEDOR := :FORNECEDOR; ';
    strSQL := strSQL + 'SET @CND_NFE := :CND_NFE; ';
    strSQL := strSQL + 'SET @DEQTPC := :DEQTPC; ';
    qryEditor.SQL.Text := strSQL;
    qryEditor.ParamByName('PEDIDO').AsString := stlPedidos.CommaText;
    qryEditor.ParamByName('COMPRADOR').AsString := fRetCompradores;
    qryEditor.ParamByName('NFE').AsString := recNotEle.strNotas;
    qryEditor.ParamByName('LOJA').AsString := VS_strCodEmp + ' - ' + fRetNomeEmpresa;
    qryEditor.ParamByName('FORNECEDOR').AsString := strCodFor + '-' + fRetNomFornecedor(strCodFor);
    qryEditor.ParamByName('CND_NFE').AsString := FormatMaskText(MASK_CONPAG5, recNotEle.strConPag);
    qryEditor.ParamByName('DEQTPC').AsString := '* Configuração CFG_DEQTPC: Quantidade de casas decimais para quantidade do produto - PEDIDO DE COMPRA = ' + fCfgSis('DEQTPC');
    qryEditor.ExecSQL;

    strNomeTabela := 'TMP_REL_CRITICAS_PRE_NOTA';
    pGerandoTemporariaAtravesDataSet(strNomeTabela, cdsCriticas);

    if Assigned(prcExecutaRelatorio) then
      prcExecutaRelatorio(454, 28803, [],
                          [],
                          [],
                          nil);

    FreeAndNil(qryEditor);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[]');
    End;
  End;

end;

Class Procedure TPreNota.pExcluiPreBaixa(strAutEle: String);
  Var
    qryCanc: TUniQuery;
Begin
  qryCanc := fCriaQuery(Nil);

  qryCanc.SQL.Clear;
  qryCanc.SQL.Add('DELETE FROM PREBAI WHERE PRE_AUTELE = ' + QuotedStr(strAutEle));
  qryCanc.ExecSQL;

  qryCanc.SQL.Clear;
  qryCanc.SQL.Add('DELETE FROM DEFBAI WHERE DEF_GERELE = ' + QuotedStr(strAutEle));
  qryCanc.ExecSQL;

  FreeAndNil(qryCanc);
End;

Class Function TPreNota.fPossuiPreBaixa(strAutEle: String): Boolean;
  Var
    qryPreBai: TUniQuery;
Begin
  If fEmptyStr(strAutEle) Then
  Begin
    Result := False;
    Exit;
  End;

  qryPreBai := fCriaQuery(Nil);

  With qryPreBai Do
  Begin
    SQL.Add('SELECT COUNT(*) AS QTD FROM PREBAI WHERE PRE_AUTELE = ' + QuotedStr(strAutEle));
    Open;

    Result := FieldByName('QTD').AsInteger > 0;
  End;

  FreeAndNil(qryPreBai);
End;

Procedure TPreNota.pAfterScrollPedidos(dataSet: TDataSet);

  Function fRetFiltro(strEmpresas: String): String;
    Var
      sltEmps: TStringList;
      intContador: Integer;
  Begin
    sltEmps := TStringList.Create;
    sltEmps.CommaText := strEmpresas;

    Result := '';

    For intContador := 0 To sltEmps.Count - 1 Do
    Begin
      If Not fEmptyStr(Result) Then
        Result := Result + ' OR ';

      Result := Result + ' CODEMP = ' + QuotedStr(sltEmps[intContador]);
    End;

    FreeAndNil(sltEmps);
  End;

Begin
  With DataSet Do
  Begin
    qryEmpresas.Filter   := fRetFiltro(dataSet.FieldByName('EMPRESAS').AsString);
    qryEmpresas.Filtered := True;
  End;
End;
function TPreNota.fApagarMotivos: TPreNota;
begin
  Result := Self;
  objMotivos.Clear;
end;

Function TPreNota.fChecaPedidosRepetidos(strPedidos: String): Boolean;
  Var
    frmSelecionaPedidoRep: TfrmSelecionaPedidoRep;
Begin
  Result := True;

  qryEmpresas.Close;
  qryEmpresas.Open;

  With cdsPcmger, qryQuery.SQL Do
  Begin
    Clear;

    Add('SELECT');
    Add('  PCG_NUMPED AS NUMPED,');
    Add('  CAST(NULL AS CHAR(3)) AS CODEMP,');
    Add('  GROUP_CONCAT(PCG_CODEMP) AS EMPRESAS');

    Add('FROM PCMGER ');

    Add('WHERE PCG_NUMPED IN (' + strPedidos + ')');
    Add('  AND IFNULL(PCG_EMPDES, PCG_CODEMP) = :CODEMP');
    Add('  AND PCG_NUMCTN = 0');
    Add('  AND PCG_BAIXAD = 0');

    Add(' GROUP BY PCG_NUMPED');

    Add(' HAVING LENGTH(EMPRESAS) > 3');

    Add(' ORDER BY NUMPED');

    cdsPcmger.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;

    fAbreClient(True, 'fChecaPedidosRepetidos');

    cdsPcmger.AfterScroll     := pAfterScrollPedidos;
    cdsPcmger.IndexFieldNames := 'NUMPED;CODEMP';

    pAlinhaCampoCentro('NUMPED');
    pAlinhaCampoCentro('CODEMP');

    If Not IsEmpty Then
    Begin
      pCriarFormularios(TfrmSelecionaPedidoRep, frmSelecionaPedidoRep);

      With frmSelecionaPedidoRep Do
      Begin
        objPreNota := Self;
        dtsEmpresas.DataSet := qryEmpresas;
        cxvItensPed.DataController.DataSource := dtsSource;

        frmSelecionaPedidoRep.ShowModal;
        Result := frmSelecionaPedidoRep.ModalResult = mrOk;
      End;

      FreeAndNil(frmSelecionaPedidoRep);
    End;

  End;

End;

Function TPreNota.fValidaEmpresas: Boolean;
Begin
  Result := True;

  With cdsPcmger Do
  Begin
    First;

    While Not Eof Do
    Begin
      If FieldByName('CODEMP').IsNull Then
      Begin
        Result := False;
        pMensagemOk('Informe a empresa do pedido de compra!');
        Exit;
      End;

      Next;
    End;

  End;

End;

function TPreNota.fValidaGravacaoItens(strAutIncGerele: String; out stlErro: TStringList): Boolean;
  Var
    qryAux: TUniQuery;
Begin
  If fEmptyStr(strAutIncGerele) Then
    Exit(False);

  qryAux := fCriaQuery(Nil);
  try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT COUNT(1) AS QTD' );
    qryAux.SQL.Add(' FROM DETELE ');
    qryAux.SQL.Add('   INNER JOIN GERELE ON GERELE.AUTOINCREM = DETELE.DET_SEQGER ');
    qryAux.SQL.Add('   INNER JOIN DEFBAI ON DEF_AUTELE = DETELE.AUTOINCREM ');
    qryAux.SQL.Add('   INNER JOIN PCMDET ON DEF_AUTPCD = PCMDET.AUTOINCREM ');
    qryAux.SQL.Add(' WHERE TRUE ');
    qryAux.SQL.Add('   AND PCD_CODITE <> DET_CODITE ');
    qryAux.SQL.Add('   AND DET_SEQGER = ' + QuotedStr(strAutIncGerele));

    qryAux.Open;

    {se diferente de zero, gravou errado o vínculo do item na DEFBAI}
    Result := qryAux.FieldByName('QTD').AsInteger = 0;

    If Not Result Then
      stlErro.Add('Houve uma inconsistência na gravação do vínculos dos itens da nota com os itens do pedido de compra, entre contato com a Citel!');

  finally
    FreeAndNil(qryAux);
  end;
end;

Function TPreNota.fCarregaPedidosNotaEletronica(strAutEle: String): Boolean;
  Var
    cdsDetEle: TZClient;
    sltPedXML: TStringList;
Begin
  Result := True;

  stlPedidosNFE.Clear;
  stlEmpresasNFE.Clear;
  stlAutoincNFE.Clear;

  blnPedidosPreDefinidos := False;

  sltPedXML := TStringList.Create;
  cdsDetEle  := TZClient.Create(Self);

  With cdsDetEle, qryQuery.SQL Do
  Begin
    Clear;
    sltPedXML.CommaText := '';
    If Assigned(frmVinculoBaixaEntregaFuturaEdocVenda) Then
    Begin
      sltPedXML.CommaText := frmVinculoBaixaEntregaFuturaEdocVenda.fGetPedidosDefinidosNa922;
    End
    Else
    Begin
      Add('SELECT GROUP_CONCAT(DISTINCT(RIGHT(CONCAT("000000000000", XPED), 12))) AS PEDIDOS FROM DETELE');
      Add('WHERE DET_SEQGER = :AUTELE');
      Add('ORDER BY XPED');

      qryQuery.ParamByName('AUTELE').AsString := strAutEle;

      fAbreClient(True, 'TPreNota.fCarregaPedidosNotaEletronica');

      sltPedXML.CommaText := FieldByName('PEDIDOS').AsString;
    End;

    If sltPedXML.Count > 0 Then
    Begin

      Clear;
      Add('SELECT');
      Add('  AUTOINCREM AS AUTINC,');
      Add('  0          AS REPETE,');
      Add('  PCG_CODEMP AS CODEMP,');
      Add('  PCG_NUMPED AS NUMPED,');
      Add('  PCG_EMPDES AS EMPDES,');
      Add('  PCG_DTAENT AS DTAENT ');

      Add('FROM PCMGER ');
      If Assigned(frmVinculoBaixaEntregaFuturaEdocVenda) Then
        Add('WHERE PCMGER.AUTOINCREM IN (' + fCommaText(sltPedXML, True) + ')')
      Else
        Add('WHERE PCG_NUMPED IN (' + fCommaText(sltPedXML, True) + ')');
      Add('  AND IFNULL(PCG_EMPDES, PCG_CODEMP) = :CODEMP');
      Add('  AND PCG_NUMCTN = 0');
      Add('  AND PCG_BAIXAD = 0');

      Add(' ORDER BY PCG_NUMPED, PCG_CODEMP');

      qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;

      fAbreClient(True, 'TPreNota.fCarregaPedidosNotaEletronica');

      If Not IsEmpty Then
      Begin
        stlPedidos.Clear;
        stlEmpresas.Clear;
        stlAutoinc.Clear;
        If Not Assigned(frmVinculoBaixaEntregaFuturaEdocVenda) Then
          Result := fChecaPedidosRepetidos(fCommaText(sltPedXML, True));

        If Not Result Then
          Exit;

        First;
        If Not Assigned(frmVinculoBaixaEntregaFuturaEdocVenda) Then
        Begin

          While Not Eof Do
          Begin

            If cdsPcmger.Locate('NUMPED', FieldByName('NUMPED').AsString, []) Then
            Begin
              Edit;
              FieldByName('REPETE').AsInteger := 1;
              Post;
            End;

            Next;
          End;


          First;
          While Not Eof Do
          Begin

            If (FieldByName('REPETE').AsInteger = 1) And
               (Not cdsPcmger.Locate('NUMPED;CODEMP',
                 VarArrayOf([FieldByName('NUMPED').AsString, FieldByName('CODEMP').AsString]), [])) Then
              cdsDetEle.Delete
            Else
              Next;

          End;
        End;

        First;
        While Not Eof Do
        Begin

          stlPedidos.Add(FieldByName('NUMPED').AsString);
          stlEmpresas.Add(FieldByName('CODEMP').AsString);
          stlAutoinc.Add(FieldByName('AUTINC').AsString);

          Next;
        End;

        blnPedidosPreDefinidos := True;

      End;

    End;

  End;

  stlPedidosNFE.Text  := stlPedidos.Text;
  stlEmpresasNFE.Text := stlEmpresas.Text;
  stlAutoincNFE.Text  := stlAutoinc.Text;

  FreeAndNil(cdsDetEle);
  FreeAndNil(sltPedXML);
End;

Procedure TPreNota.pConsultaItensPreNota;
Begin

  If fEmptyStr(recNotEle.strAutInc) Then
  Begin
    pMensagemOk('Informe a nota eletrônica!');
    Exit;
  End;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(116, 6000, [],
                        ['ESPDOC','CODFOR'],
                        ['PD', recNotEle.strCodFor],
                        nil,
                        nil,
                        True);
  End;

End;

end.
