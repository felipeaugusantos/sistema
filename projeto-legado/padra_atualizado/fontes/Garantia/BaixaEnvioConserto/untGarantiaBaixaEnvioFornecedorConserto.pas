unit untGarantiaBaixaEnvioFornecedorConserto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, UniClientDataSet,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls, untGarant,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Vcl.Mask, MaskEditFocus, Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, untTypesSistema, Uni,
  untFuncFat, system.Generics.Collections, uGarantiaBaixaEnvioFornecedorConsertoModel, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxProgressBar, DBGridCitel, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid;

type
  TfrmGarantiaBaixaEnvioFornecedorConserto = class(TfrmPai)
    pnlFiltro: TPanel;
    pnlDados: TPanel;
    pnlBotoesEnt: TPanel;
    btnConfirmar: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnSair_: TBitBtnLocked;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    btnPesquisar: TBitBtnLocked;
    lblFornecedor: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    lblPeriodo: TLabel;
    lblPeriodoAte: TLabel;
    dtsDados: TDataSource;
    pnlMotivo: TPanel;
    lblMotivo: TLabel;
    edtMotivo: TEdit;
    btnInformarMotivo: TBitBtnLocked;
    cdsDados: TUniClientDataSet;
    cdsDadosSELECIONADO: TStringField;
    cdsDadosDTAENV: TDateField;
    cdsDadosFORNECEDOR: TStringField;
    cdsDadosNUMGAR: TStringField;
    cdsDadosCODITE: TStringField;
    cdsDadosDESITE: TStringField;
    cdsDadosCODUNI: TStringField;
    cdsDadosQTDBAI: TFloatField;
    cdsDadosNFENVI: TStringField;
    cdsDadosCLAFIS: TStringField;
    cdsDadosPRECUS: TFloatField;
    cdsDadosUNITAR: TFloatField;
    cdsDadosQTDENV: TFloatField;
    cdsDadosVALITE: TFloatField;
    cdsDadosLOTSAI: TStringField;
    cdsDadosTABPRE: TStringField;
    cdsDadosINCGAE: TStringField;
    cdsDadosAUTOINCREM: TStringField;
    cdsDadosNUMENT: TStringField;
    cdsDadosQTDREF: TFloatField;
    cdsDadosQTDRET: TFloatField;
    cdsDadosSALENV: TFloatField;
    cdsDadosGAE_NUMENV: TStringField;
    cdsDadosGAE_ESPENV: TStringField;
    cdsDadosGAE_EMPENV: TStringField;
    dbgDadosNewDBTableViewCitel1: TcxGridDBTableViewCitel;
    dbgDadosNewLevel1: TcxGridLevel;
    dbgDadosNew: TcxGridCitel;
    dbgDadosNewDBTableViewCitel1DTAENV: TcxGridDBColumn;
    dbgDadosNewDBTableViewCitel1FORNECEDOR: TcxGridDBColumn;
    dbgDadosNewDBTableViewCitel1NUMGAR: TcxGridDBColumn;
    dbgDadosNewDBTableViewCitel1CODITE: TcxGridDBColumn;
    dbgDadosNewDBTableViewCitel1DESITE: TcxGridDBColumn;
    dbgDadosNewDBTableViewCitel1CODUNI: TcxGridDBColumn;
    dbgDadosNewDBTableViewCitel1QTDBAI: TcxGridDBColumn;
    dbgDadosNewDBTableViewCitel1NFENVI: TcxGridDBColumn;
    dbgDadosNewDBTableViewCitel1SALENV: TcxGridDBColumn;
    dbgDadosNewDBTableViewCitel1Selecionado: TcxGridDBColumn;
    PnlOpcao: TPanel;
    pnlRadio: TPanel;
    rdbEntrada: TRadioButton;
    Label1: TLabel;
    rdbCredito: TRadioButton;
    lblInfOperacao: TLabel;


    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);

    procedure cdsDadosQTDBAIValidate(Sender: TField);
    procedure cdsDadosBeforeInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure btnInformarMotivoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mskDtaIniExit(Sender: TObject);
    procedure mskDtaFinExit(Sender: TObject);
    procedure cdsDadosCalcFields(DataSet: TDataSet);
    procedure dbgDadosNewDBTableViewCitel1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgDadosNewDBTableViewCitel1DblClick(Sender: TObject);
    procedure dbgDadosNewDBTableViewCitel1CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure rdbEntradaClick(Sender: TObject);
    procedure rdbCreditoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    {$Region 'CFGs'}
    blnIMPREF: Boolean;
    blnMONDES: Boolean;
    blnEnvDev: Boolean;
    strClaFisConserto: String;
    {$Endregion}
    cdsGroup : TUniClientDataSet;
    fatVenda : TFatVenda;
    blnBloqueioInserirDados: Boolean;

    arrForne : TConsultasArray;

    procedure pMarcarItem(const blnSelecionar: Boolean; blnTodos: Boolean = False);
    procedure pCarregarGarantias;
    function fValidarCamposPesquisa: Boolean;
    procedure pCarregaTabelaProdutos(qryFornec: TUniQuery; cdsProdutos: TUniClientDataSet);
    procedure pCarregarCFGs;
    procedure pConfigurarTela;
    function fFiltrarSelecionados: Boolean;
    function fValidarDadosConfirmacao: Boolean;
    function fItemEnviadoConserto(const strClaFis: String): Boolean;
    procedure pSelecionarItem;
    procedure pConfirmar;
    function fConfirmar(prgProgresso : TcxProgressbar): Boolean;
    procedure pRemoverFiltro;
    function fGerarDocumentoEntrada(objDocBaixa: TDocBaixa): Boolean;
    procedure pCarregarDadosFatVendas;
    function fIncluirItens(fatVenda: TFatVenda; objDocBaixa: TDocBaixa): boolean;
    procedure pCarregaDadosFornecedor(strCodFor:String);
    function fPermiteBaixarMovGae(const fltQtdEnv, flQtdRet, fltQtdRef, fltQtdPre: Double): Boolean;
    function fSqlConsultaNotaEletronica: String;
    function fVerificaSeExisteNotaEletronica(const strMovGae: String): Double;
    function fObterClafis(const strClaFisSaida: String): String;
    function fObterDadosBaixa: TDocBaixa;
    function fAgruparItensIguais(objDocBaixa: TDocBaixa): TListaItensDoc;
    procedure pTransferirDadosCdsParaMovBcd(cdsDados: TUniClientDataSet; objItemDoc: TItemDoc);
    procedure pMensagemInformarQuantidadeBaixa;
    procedure pObterMotivo;
    procedure pEliminarItensProcessados(objDocBaixa: TDocBaixa);
    procedure pLimpar;
    procedure pMensagemDocEmitido(const strNumDoc, strEspDoc, strCodEmp: String);
    procedure pAtualizarLabelInformacaoOperacao;overload;
    procedure pAtualizarLabelInformacaoOperacao(Sender: TObject);overload;
  private Const
    SIM: String = '1';
    NAO: String = '0';
    { Private declarations }
  protected
     function fValidaCampos(Sender : TWinControl; blnBuscaPorChave: Boolean) : Boolean; Override;
    procedure pOnKeyDownEdits(Sender: TObject; var Key: Word; Shift: TShiftState); override;
  public

    procedure AfterConstruction;override;
    { Public declarations }
  end;

var
  frmGarantiaBaixaEnvioFornecedorConserto: TfrmGarantiaBaixaEnvioFornecedorConserto;

implementation
uses
  untFuncFatTypes,
  untFuncoesConsulta,
  untConsultas,
  untFuncoesSimples,
  System.strUtils,
  Math,
  untGarantiaBaixaEnvioFornecedorConsertoMotivo, untFatDadosFiscais,
  untFuncoes,
  untGarantiaLibFuncoesFaturamento, untGravando, untEntMercadorias,
  untGarantiaLibDiversos;

{$R *.dfm}

{ TfrmGarantiaBaixaEnvioFornecedorConserto }

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.AfterConstruction;
begin
  inherited;
  pCarregarCFGs;
  pConfigurarTela;
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  if Not fValidarDadosConfirmacao then
  begin
    pRemoverFiltro;
    cdsDados.EnableControls;
    Exit;
  end;
  pConfirmar;
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarItem(False,True);
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.btnInformarMotivoClick(Sender: TObject);
begin
  inherited;
  pObterMotivo;
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarItem(True,True);
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  pCarregarGarantias;
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.cdsDadosBeforeInsert(DataSet: TDataSet);
begin
  if blnBloqueioInserirDados then
    abort;
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.cdsDadosCalcFields(DataSet: TDataSet);
begin
  inherited;
  cdsDadosSalEnv.AsFloat := cdsDadosQTDENV.AsFloat - (cdsDadosQTDREF.AsFloat + cdsDadosQTDRET.AsFloat);
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.cdsDadosQTDBAIValidate(Sender: TField);
Var
  blnPermitido: Boolean;
begin
  blnPermitido := (Sender.AsFloat >= 0);
  if blnPermitido then
    blnPermitido := (sender.AsFloat <= cdsDadosSALENV.AsFloat);

  if Not blnPermitido  then
  begin
    fMensagem('Atenção', 'A quantidade a baixar deve ser maior ou igual a zero e menor ou igual a quantidade enviada.',['&Ok']);
    Abort;
  end;

  if Sender.AsFloat > 0 then
    cdsDadosSelecionado.AsString := SIM
  else
    cdsDadosSelecionado.AsString := NAO;
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.dbgDadosNewDBTableViewCitel1CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if VarToStrDef(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDadosNewDBTableViewCitel1Selecionado.Index],'0') = SIM then
  begin
    ACanvas.Font.Color := clBlue;
  end;
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.dbgDadosNewDBTableViewCitel1DblClick(Sender: TObject);
Var
  blnMarcar: Boolean;
begin
  inherited;
  if dbgDadosNewDBTableViewCitel1.Controller.FocusedColumn.DataBinding.FilterFieldName <> 'QTDBAI' then
  begin

    if cdsDados.FieldByName('QTDBAI').asfloat = 0 then
    begin
      pMensagemInformarQuantidadeBaixa;
      exit;
    end;

    if Not cdsDados.IsEmpty then
    begin
      blnMarcar := Not (cdsDadosSelecionado.AsString = SIM);
      pMarcarItem(blnMarcar);
    end;
  end;
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.dbgDadosNewDBTableViewCitel1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
Var
  blnTemQuantidade: Boolean;
begin
  inherited;

  blnTemQuantidade := cdsDados.FieldByName('QTDBAI').AsFloat > 0;

  if dbgDadosNewDBTableViewCitel1.Controller.FocusedColumn.DataBinding.FilterFieldName <> 'QTDBAI' then
  begin

    case Key of
      VK_RETURN, VK_SPACE : begin
                              if blnTemQuantidade then
                                pSelecionarItem
                              else
                                pMensagemInformarQuantidadeBaixa;
                            end;
    end;
  end;

end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrForne, fRetNomFornecedor, nil, 'do Fornecedor');
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.edtCodForKeyPress(Sender: TObject; var Key: Char);
  Var
    arrForne: TConsultasArray;
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrForne, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmGarantiaBaixaEnvioFornecedorConserto.fGerarDocumentoEntrada(objDocBaixa: TDocBaixa): Boolean;
Var
  blnConfirma: boolean;
  strEstEmp: String;
begin
  Try
    pCarregarDadosFatVendas;
    pCarregaDadosFornecedor(edtCodFor.Text);
    fatVenda.strClaFis := objDocBaixa.strClaFis;
    fatVenda.strClaFisRecGarantia := objDocBaixa.strClaFis;
    fatVenda.strClaFisRecGarantiaST := objDocBaixa.strClaFis;

    fatVenda.strDesCla := objDocBaixa.fstrDesCla;

    blnConfirma := fIncluirItens(fatVenda, objDocBaixa);
    Try
      If (blnConfirma) then
      Begin
        cdsDados.First;

        fatVenda.pCarregaAliquotasRetencao;

        fatVenda.pPreencheMatrizFechamento;

        fatVenda.pCalculaPesBruLiq;

        fatVenda.pCalculaTotGer(False, False);

        fatVenda.pCalculaTotGer;

        fatVenda.strClaFis := objDocBaixa.strClaFis;
        fatVenda.strDesCla := objDocBaixa.fstrDesCla;

        fatVenda.pDestacaRetencoes;
        fatVenda.pRetemImpostosNoDescontoEspecial;
        fatVenda.pCalculaTotalParaCadRec;

        fatVenda.pRateiaValores;
        fatVenda.pSintetizaClassificacoes;
        fatVenda.blnBaixaEnvioConserto := True;

        If (fatVenda.strEspDoc = 'NF') Then
        Begin
          Try
            pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);

            strEstEmp := fRetUFEmpresa;

            frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text    := fatVenda.strClafis;
            frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Text    := fatVenda.strDesCla;
            frmFatDadosFiscais.fltOUTDesAce      := 0;
            frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled := False;
            frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Enabled := False;
            frmFatDadosFiscais.blnForcaEdiBas    := True;
            frmFatDadosFiscais.fatVenda := fatVenda;

            frmFatDadosFiscais.Caption := frmFatDadosFiscais.Caption;
            frmFatDadosFiscais.ShowModal;

            blnConfirma := frmFatDadosFiscais.blnConfirma;

          Except
            On E: Exception Do
            Begin
              blnConfirma := False;
              pMensagensErro(E.Message, '[TfrmGarantiaBaixaEnvioFornecedorConserto.fGerarDocumentoEntrada]');
            End;
          End;

          pFreeAndNil(frmFatDadosFiscais);
        End;


        if blnConfirma then
        begin
          pCriarFormularios(TfrmGravando,frmGravando);
          fatVenda.cdsMovGad              := cdsDados;
          frmGravando.strChave            := 'FATFATURA';
          frmGravando.fExecutarAcao       := fatVenda.fGravaArquivos;
          frmGravando.lblGravando.Caption := 'Aguarde, Gravando...';
          frmGravando.ShowModal;
          blnConfirma                         := frmGravando.blnConfirma;

          If blnConfirma Then
          Begin
            objDocBaixa.strSeqGer :=  fatVenda.strAutInc;
            objDocBaixa.strNumDoc :=  fatVenda.strNumDoc;
            objDocBaixa.strEspDoc :=  fatVenda.strEspDoc;
          End;

          pFreeAndNil(frmGravando);
        end;
      End;
      Result := blnConfirma;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmGarantiaBaixaEnvioFornecedorConserto.fGerarDocumentoEntrada]');
      End;
    End;
  Finally
    if Assigned(FatVenda) then
      FreeAndNil(FatVenda);
    pFreeCdsVenda;
  End;
end;

function TfrmGarantiaBaixaEnvioFornecedorConserto.fAgruparItensIguais(objDocBaixa: TDocBaixa): TListaItensDoc;
Var
  aItemDoc: TItemDoc;
  i, n: Integer;
  intIdx: Integer;
  blnAdicionar: Boolean;
begin
  Result := TListaItensDoc.Create;
  Result.Clear;
  for I := 0 to  objDocBaixa.ItensDoc.Count -1 do
  begin
    intIdx := -1;
    if Result.Count > 0 then
    begin
      for n := 0 to Result.count -1 do
      begin
        if  objDocBaixa.ItensDoc[i].strCodIte = Result[n].strCodIte then
        begin
          if objDocBaixa.ItensDoc[i].strLotSai = Result[n].strLotSai then
          begin
            intIdx := n;
            Break;
          end;
        end;
      end;
    end;

    blnAdicionar := intIdx = -1;

    if blnAdicionar then
    begin
      aItemDoc := TItemDoc.Create;
      Result.Add(aItemDoc);
      aItemDoc.strCodIte := objDocBaixa.ItensDoc[i].strCodIte;
      aItemDoc.strCodFor := objDocBaixa.ItensDoc[i].strCodFor;
      aItemDoc.strDesIte := objDocBaixa.ItensDoc[i].strDesIte;
      aItemDoc.strTabPre := objDocBaixa.ItensDoc[i].strTabPre;
      aItemDoc.strLotSai := objDocBaixa.ItensDoc[i].strLotSai;
    end
    else
      aItemDoc := Result[intIdx];

    aItemDoc.fltQtdIte := aItemDoc.fltQtdIte + objDocBaixa.ItensDoc[i].fltQtdIte;
    aItemDoc.fltQtdBai := aItemDoc.fltQtdBai + objDocBaixa.ItensDoc[i].fltQtdBai;
    aItemDoc.fltTotUni := aItemDoc.fltTotUni + objDocBaixa.ItensDoc[i].fltTotUni;
    aItemDoc.fltTotCus := aItemDoc.fltTotCus + objDocBaixa.ItensDoc[i].fltTotcus;
    aItemDoc.fltValIte := aItemDoc.fltValIte + objDocBaixa.ItensDoc[i].fltValIte;
  end;
end;

function TfrmGarantiaBaixaEnvioFornecedorConserto.fConfirmar(prgProgresso: TcxProgressbar): Boolean;
Var
  objDocBaixa: TDocBaixa;

begin
  Result := False;
  objDocBaixa := nil;
  Try
    prgProgresso.properties.Max := 1;
    objDocBaixa := fObterDadosBaixa;

    if Assigned(objDocBaixa) then
      Result := True
    else
      Exit;

    prgProgresso.Position := 1;
    Application.ProcessMessages;

    Try
      fStartTransaction;
      prgProgresso.properties.Max := 3;
      prgProgresso.Position := 0;
      Application.ProcessMessages;

      if objDocBaixa.blnEmitirDocEntradaProprio then
      begin
        If Not fGerarDocumentoEntrada(objDocBaixa) Then
        begin
          Result := False;
          Exit;
        end;
      end;

      prgProgresso.Position := 1;
      Application.ProcessMessages;
      Result := objDocBaixa.fBaixarEnvioFornecedor;
      prgProgresso.Position := 2;
      Application.ProcessMessages;
    Finally
      if Result then
      begin
        fCommit;
        If objDocBaixa.blnEmitirDocEntradaProprio then
        begin
          pMensagemDocEmitido(objDocBaixa.strNumDoc,objDocBaixa.strEspDoc, vs_strCodEmp);
        End;
        pEliminarItensProcessados(objDocBaixa);
        pLimpar;
      end
      else
        fRollBack;

      prgProgresso.Position := 3;
      Application.ProcessMessages;
    End;
  Finally
    if Assigned(objDocBaixa) then
    begin
      objDocBaixa.Free;
    end;
  End;
end;

function TfrmGarantiaBaixaEnvioFornecedorConserto.fFiltrarSelecionados: Boolean;
begin
  if cdsDados.Filtered then
    cdsDados.Filtered := False;

  cdsDados.Filter := 'SELECIONADO = ''1''';
  cdsDados.Filtered := True;
  Result := Not cdsDados.IsEmpty;
  if Not Result then
  begin
    cdsDados.Filter := EmptyStr;
    cdsDados.Filtered := False;
  end;
end;

function TfrmGarantiaBaixaEnvioFornecedorConserto.fIncluirItens(fatVenda: TFatVenda; objDocBaixa: TDocBaixa): boolean;
  Var
    qryGenIte   : TUniQuery;
    intContador : Integer;
    recForTin   : TForTin;
    recMadeira  : TDadosMadeira;
    strIteDes   : String;
    RegTempParametros: TParametrosPAdicionarRegistroTemporaria;
    objItensBaixaAgrupado: TListaItensDoc;
    objItemDoc: TItemDoc;
begin
  objItensBaixaAgrupado := Nil;
  Try
    Try
      objItensBaixaAgrupado := fAgruparItensIguais(objDocBaixa);
      Result := TRUE;
      intContador := 0;
      qryGenIte := fCriaQuery();
      for objItemDoc in objItensBaixaAgrupado do
      begin
        inc(intContador);

        If (intContador = 1) Then
        Begin
          fatVenda.strCodVen    := strLoginUsuarioLogado;
          fatVenda.strNomVen    := fRetNomVendRep(fatVenda.strCodVen);
        End;

        fGetItem(qryGenIte,objItemDoc.strCodite);

        strIteDes := objItemDoc.strDesIte;

        {$REGION 'ADICIONAR TABELA TEMPORARIA'}
        RegTempParametros := TParametrosPAdicionarRegistroTemporaria.Create(cdsVenda, Nil, recMadeira);
        RegTempParametros.cdsDados :=         cdsVenda;
        RegTempParametros.btnAdicionar :=     Nil;
        RegTempParametros.strIdePro :=        'NOR';
        RegTempParametros.strCodIte :=        objItemDoc.strCodIte;
        RegTempParametros.strCodFor :=        objDocBaixa.strCodFor;
        RegTempParametros.fltUniOri :=        objItemDoc.fltUnitar;
        RegTempParametros.fltUniVis :=        objItemDoc.fltUnitar;
        RegTempParametros.fltUniTar :=        objItemDoc.fltUnitar;
        RegTempParametros.fltQtdIte :=        objItemDoc.fltQtdIte;
        RegTempParametros.fltTotIte :=        objItemDoc.fltValite;
        RegTempParametros.fltPreCus :=        objItemDoc.fltPreCus;
        RegTempParametros.strDocDev :=        '';
        RegTempParametros.strEspDev :=        '';
        RegTempParametros.strEmpDev :=        '';
        RegTempParametros.fltUniDig :=        objItemDoc.fltUnitar;
        RegTempParametros.strTabPre :=        objItemDoc.strTabpre;
        RegTempParametros.fltCusIte :=        objItemDoc.fltPrecus;
        RegTempParametros.strCodVenIte :=     objDocBaixa.strCodOpe;
        RegTempParametros.strNumLot :=        objItemDoc.strLotSai;
        RegTempParametros.fltQtdOri :=        objItemDoc.fltQtdIte;
        RegTempParametros.fltTotCus :=        objItemDoc.fCustoToTal;
        RegTempParametros.strEntSai :=        'E';
        RegTempParametros.strCodGru :=        qryGenIte.FieldByName('ITE_CODGRU').AsString;
        RegTempParametros.strDesOri :=        qryGenIte.FieldByName('ITE_DESITE').AsString;
        RegTempParametros.strDesFab :=        qryGenIte.FieldByName('ITE_DESFAB').AsString;
        RegTempParametros.strUnidad :=        qryGenIte.FieldByName('UNI_CODUNI').AsString;
        RegTempParametros.strCodUni :=        qryGenIte.FieldByName('UNI_CODUNI').AsString;
        RegTempParametros.strCodMar :=        qryGenIte.FieldByName('ITE_CODMAR').AsString;
        RegTempParametros.strRefere :=        qryGenIte.FieldByName('ITE_REFERE').AsString;
        RegTempParametros.strComLub :=        qryGenIte.FieldByName('ITE_COMLUB').AsString;
        RegTempParametros.fltIpiSai :=        qryGenIte.FieldByName('ITE_IPISAI').AsFloat;
        RegTempParametros.fltDesMax :=        qryGenIte.FieldByName('ITE_DESMAX').AsFloat;
        RegTempParametros.fltPreVe1 :=        qryGenIte.FieldByName('ITE_PREVE1').AsFloat;
        RegTempParametros.fltPreVe2 :=        qryGenIte.FieldByName('ITE_PREVE2').AsFloat;
        RegTempParametros.fltPreVe3 :=        qryGenIte.FieldByName('ITE_PREVE3').AsFloat;
        RegTempParametros.fltPreVe4 :=        qryGenIte.FieldByName('ITE_PREVE4').AsFloat;
        RegTempParametros.fltPreVe5 :=        qryGenIte.FieldByName('ITE_PREVE5').AsFloat;
        RegTempParametros.fltPreVe6 :=        qryGenIte.FieldByName('ITE_PREVE6').AsFloat;
        RegTempParametros.fltPreVe7 :=        qryGenIte.FieldByName('ITE_PREVE7').AsFloat;
        RegTempParametros.fltSaldos :=        qryGenIte.FieldByName('ITE_SALDOS').AsFloat;
        RegTempParametros.fltComVar :=        qryGenIte.FieldByName('ITE_COMVAR').AsFloat;
        RegTempParametros.fltComAta :=        qryGenIte.FieldByName('ITE_COMATA').AsFloat;
        RegTempParametros.fltComDis :=        qryGenIte.FieldByName('ITE_COMDIS').AsFloat;
        RegTempParametros.fltTotUlt :=        qryGenIte.FieldByName('ITE_PREULT').AsFloat * objItemDoc.fltQtdIte;
        RegTempParametros.fltImpUlt :=        qryGenIte.FieldByName('ITE_IMPULT').AsFloat;
        RegTempParametros.fltPreUlt :=        qryGenIte.FieldByName('ITE_PREULT').AsFloat;
        RegTempParametros.fltPreMed :=        qryGenIte.FieldByName('ITE_PREMED').AsFloat;
        RegTempParametros.strClaIpi :=        qryGenIte.FieldByName('ITE_CLAIPI').AsString;
        RegTempParametros.strCodAbf :=        qryGenIte.FieldByName('ABF_CODABF').AsString;
        RegTempParametros.fltPesoIt :=        qryGenIte.FieldByName('ITE_PESOIT').AsFloat;
        RegTempParametros.fltPesLiq :=        qryGenIte.FieldByName('ITE_PESLIQ').AsFloat;
        RegTempParametros.fltGPeCom :=        fatVenda.fRetPerComGrupo(qryGenIte.FieldByName('ITE_CODGRU').AsString);
        RegTempParametros.strCodFab :=        qryGenIte.FieldByName('ITE_CODFAB').AsString;
        RegTempParametros.fltMarMin :=        qryGenIte.FieldByName('ITE_MARMIN').AsFloat;
        RegTempParametros.fltMarMSG :=        qryGenIte.FieldByName('ITE_MARMSG').AsFloat;
        RegTempParametros.fltMarMGe :=        qryGenIte.FieldByName('ITE_MARMGE').AsFloat;
        RegTempParametros.strMarca :=         fRetNomMarca(qryGenIte.FieldByName('ITE_CODMAR').AsString);
        RegTempParametros.fltPreCom :=        qryGenIte.FieldByName('ITE_PRECOM').AsFloat;
        RegTempParametros.fltQtdPon :=        qryGenIte.FieldByName('ITE_QTPPRO').AsFloat;
        RegTempParametros.strObrCpf :=        qryGenIte.FieldByName('ITE_OBRCPF').AsString;
        RegTempParametros.strSigUni :=        fRetSiglaUnidade(qryGenIte.FieldByName('UNI_CODUNI').AsString);
        RegTempParametros.fltIpiEnt :=        qryGenIte.FieldByName('ITE_IPIENT').AsFloat;
        RegTempParametros.fltFreEnt :=        qryGenIte.FieldByName('ITE_FREENT').AsFloat;
        RegTempParametros.strCodBar :=        qryGenIte.FieldByName('ITE_CODBAR').AsString;
        RegTempParametros.strImpDir :=        qryGenIte.FieldByName('ITE_IMPDIR').AsString;
        RegTempParametros.fltTotImp :=        qryGenIte.FieldByName('ITE_IMPULT').AsFloat * objItemDoc.fltQtdIte;
        RegTempParametros.strDesIte :=        strIteDes;
        RegTempParametros.strIncPis :=        'N';
        RegTempParametros.strEntFut :=        'N';
        RegTempParametros.recForTin :=        recForTin;
        RegTempParametros.blnBxSbIt :=        False;
        RegTempParametros.strPigBas :=        'N';
        RegTempParametros.strIdeDev :=        'NOR';
        RegTempParametros.fltFatAce :=        1;
        RegTempParametros.blnPodAlt :=        True;
        RegTempParametros.dtaEmiDev :=        0;
        RegTempParametros.strAltPCoIte :=     'N';
        RegTempParametros.strCliBus :=        'N';
        RegTempParametros.strLibUni :=        'N';
        RegTempParametros.strClaFis :=        objDocBaixa.strClaFis;
        RegTempParametros.strProEmb :=        'N';
        RegTempParametros.strPromoc :=        'N';
        RegTempParametros.intSeqInd :=        -1;
        RegTempParametros.fltVolPro :=        0.00;
        RegTempParametros.intOrdite :=        intContador;
        RegTempParametros.blnProAca :=        False;
        TParametrosPAdicionarRegistroTemporaria.pAdicionarRegistroTemporaria(fatVenda,RegTempParametros);
        RegTempParametros.Free;
        {$ENDREGION}
      End;

      FreeAndNil(qryGenIte);

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message,'[TfrmGarantiaRecCliente.fIncluiItens]');
      End;
    End;
  Finally
    if Assigned(objItensBaixaAgrupado) then
    begin
      objItensBaixaAgrupado.Clear;
      if Assigned(objItensBaixaAgrupado) then
        objItensBaixaAgrupado.Free;
    end;
  End;
end;

function TfrmGarantiaBaixaEnvioFornecedorConserto.fItemEnviadoConserto(const strClaFis: String): Boolean;
begin
  Result := pos(strClaFis, strClaFisConserto) > 0;
end;

function TfrmGarantiaBaixaEnvioFornecedorConserto.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
Var
  dtaDataAux: TDateTime;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = edtCodFor) Then
    Begin
      if fEmptyStr(edtCodFor.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O fornecedor deve ser preenchido!', ['&Ok']);
        Result := False;
      end
      Else
      Begin
        edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);
        if fEmptyStr(edtNomFor.Text) then
        begin
          fMensagem('AVISO','Fornecedor não encontrado!', ['&O K']);
          pSetFocus(edtCodFor);
          Result := False;
        end;
      End;
    End

    {***********************}
    {* VALIDA DATA INICIAL *}
    {********************RL*}
    Else If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      else if Result then
      begin
        Result := TryStrToDate(mskDtaIni.Text, dtaDataAux);
        if Not Result then
          fMensagem('ATENÇÃO!', 'Data inválida!', ['&Ok']);

      end;

    End

    {*********************}
    {* VALIDA DATA FINAL *}
    {******************RL*}
    Else If (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','A data final deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!','A data inicial deve ser menor que a data final!',['&OK']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmGarantiaBaixaEnvioFornecedorConserto.fValidarCamposPesquisa: Boolean;
begin
  Result := fValidaCampos(edtCodFor, false);
  if Result then
  begin
    Result := fValidaCampos(mskDtaIni, false);
  end;

  if Result then
  begin
    Result := fValidaCampos(mskDtaFin, false);
  end;
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.pCarregaDadosFornecedor(strCodFor: String);
  Var
    strSQL: String;
    qryDados: TUniQuery;
begin
  qryDados := fCriaQuery(Self);

  Try
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   FOR_CODCID, ';
    strSQL := strSQL + '   FOR_I_E_S_, ';
    strSQL := strSQL + '   FOR_CODATI, ';
    strSQL := strSQL + '   FOR_CODFOR, ';
    strSQL := strSQL + '   FOR_CODCID, ';
    strSQL := strSQL + '   FOR_NOMFOR, ';
    strSQL := strSQL + '   FOR_ENDERE, ';
    strSQL := strSQL + '   FOR_ENDNUM, ';
    strSQL := strSQL + '   FOR_ENDCOM, ';
    strSQL := strSQL + '   FOR_BAIRRO, ';
    strSQL := strSQL + '   FOR_C_E_P_, ';
    strSQL := strSQL + '   FOR_CODCID, ';
    strSQL := strSQL + '   FOR_FONE01, ';
    strSQL := strSQL + '   FOR_C_G_C_, ';
    strSQL := strSQL + '   FOR_CGCCPF, ';
    strSQL := strSQL + '   FOR_CGCCPF, ';
    strSQL := strSQL + '   FOR_EMAIL_  ';
    strSQL := strSQL + ' FROM          ';
    strSQL := strSQL + '   CADFOR      ';
    strSQL := strSQL + ' WHERE         ';
    strSQL := strSQL + '   FOR_CODFOR = :CODFOR ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('CODFOR').AsString := strCodFor;
    qryDados.Open;

    fatVenda.strCliEst := fRetNomCidade(qryDados.FieldByName('FOR_CODCID').AsString, 1);
    fatVenda.strCliIes := qryDados.FieldByName('FOR_I_E_S_').AsString;
    fatVenda.strCliAti := qryDados.FieldByName('FOR_CODATI').AsString;
    fatVenda.strCodCli := qryDados.FieldByName('FOR_CODFOR').AsString;
    fatVenda.strCodVen := strLoginUsuarioLogado;
    fatVenda.strCliEst := fRetNomCidade(qryDados.FieldByName('FOR_CODCID').AsString, 1);
    fatVenda.strCliNom := qryDados.FieldByName('FOR_NOMFOR').AsString;
    fatVenda.strCliOri := qryDados.FieldByName('FOR_NOMFOR').AsString;
    fatVenda.strCliEnd := qryDados.FieldByName('FOR_ENDERE').AsString;
    fatVenda.strCliNum := qryDados.FieldByName('FOR_ENDNUM').AsString;
    fatVenda.strCliCom := qryDados.FieldByName('FOR_ENDCOM').AsString;
    fatVenda.strCliBai := qryDados.FieldByName('FOR_BAIRRO').AsString;
    fatVenda.strCliCep := qryDados.FieldByName('FOR_C_E_P_').AsString;
    fatVenda.strCodCid := qryDados.FieldByName('FOR_CODCID').AsString;
    fatVenda.strCliCid := fRetNomCidade(qryDados.FieldByName('FOR_CODCID').AsString, 0);
    fatVenda.strCliEst := fRetNomCidade(qryDados.FieldByName('FOR_CODCID').AsString, 1);
    fatVenda.strCliTel := qryDados.FieldByName('FOR_FONE01').AsString;
    fatVenda.strCliCgc := qryDados.FieldByName('FOR_C_G_C_').AsString;
    fatVenda.intCgcCpf := qryDados.FieldByName('FOR_CGCCPF').AsInteger;
    fatVenda.strCliIes := qryDados.FieldByName('FOR_I_E_S_').AsString;
    fatVenda.strCliEma := qryDados.FieldByName('FOR_EMAIL_').AsString;
    fatVenda.strCliEm2 := '';
    fatVenda.strCliCon := 'N';
    qryDados.Close;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCarregaDadosFornecedor]');
      FreeAndNil(qryDados);
      Exit;
    End;
  End;

  FreeAndNil(qryDados);
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.pCarregarCFGs;
begin
  blnEnvDev := fCfgSis('ENVDEV',varInteger) = 2;
  strClaFisConserto := fCfgSis('CLARGF', varString);
  blnIMPREF  :=  fCfgSis('IMPREF', varBoolean);
  blnMONDES  :=  fCfgSis('MONDES', varString) = 1;
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.pCarregarDadosFatVendas;
begin
  pCriarCdsVenda(Self);
  cdsVenda.EmptyDataSet;
  fatVenda := TFatVenda.CreateInstance('EF');
  fatVenda.strOpcDocTrue := 'FE';
  fatVenda.strMen001 := '';
  fatVenda.strOriDoc := 'V';
  fatVenda.strCodVen := strLoginUsuarioLogado;
  fatVenda.strNomVen := fRetNomVendRep(fatVenda.strCodVen);
  fatVenda.strEspDoc := 'NF';
  fatVenda.strConPag := '01000';
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.pCarregarGarantias;
Var
  objMovGag: TMovGag;
begin
  cdsDados.EmptyDataSet;
  if Not fValidarCamposPesquisa then
  begin
    Exit;
  end;

  cdsDados.EmptyDataSet;
  objMovGag := TMovGag.Create(Nil);
  Try
    objMovGag.objMovGad.pCarregaProdutosRetornadosConserto(edtCodFor.Text, StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text));

    If objMovGag.objMovGad.qryFornec.IsEmpty Then
    Begin
      fMensagem('', 'Não existem produtos enviados para este fornecedor no período informado!', ['&Ok']);
      pSetFocus(edtCodFor);
    End
    Else
    Begin
      pCarregaTabelaProdutos(objMovGag.objMovGad.qryFornec, cdsDados);
      if cdsDados.IsEmpty then
        fMensagem('', 'Não existem produtos enviados para este fornecedor no período informado!', ['&Ok']);
      pSetFocus(dbgDadosNew);
    End;

    objMovGag.objMovGad.qryFornec.Close;
  Finally
    if Assigned(objMovGag)  then
      objMovGag.Free;
  End;

end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.pCarregaTabelaProdutos(qryFornec: TUniQuery; cdsProdutos: TUniClientDataSet);
Var
  strAutIncGad: String;
  fltQtdPreNF: Double;
begin
  Try
    blnBloqueioInserirDados := False;

    while Not QryFornec.eof do
    begin
      strAutIncGad := qryFornec.FieldByName('AUTINC').AsString;
      if fItemEnviadoConserto(qryFornec.FieldByName('CLAFIS').AsString) then
      begin
        if Not cdsDados.Locate('AUTOINCREM', strAutIncGad,[]) then
        begin
          fltQtdPreNF := fVerificaSeExisteNotaEletronica(QryFornec.FieldByName('INCGAE').AsString);

          if fPermiteBaixarMovGae(qryFornec.FieldByName('QTDREQ').AsFloat, qryFornec.FieldByName('QTDREF').AsFloat,
                                  qryFornec.FieldByName('QTDRET').AsFloat, fltQtdPreNf) then
          begin
            cdsDados.Append;
            cdsDadosAutoincrem.AsString         := strAutIncGad;
            cdsDadosFORNECEDOR.AsString         := qryFornec.FieldByName('CODFOR').AsString;
            cdsDadosNUMGAR.AsString             := qryFornec.FieldByName('NUMENT').AsString;
            cdsDadosCODITE.AsString             := qryFornec.FieldByName('CODITE').AsString;
            cdsDadosDESITE.AsString             := qryFornec.FieldByName('DESITE').AsString;
            cdsDadosCODUNI.AsString             := qryFornec.FieldByName('UNIDAD').AsString;
            cdsDadosClafis.AsString             := QryFornec.FieldByName('CLAFIS').AsString;
            cdsDadosPrecus.AsFloat              := QryFornec.FieldByName('PRECUS').AsFloat;
            cdsDadosLotSai.AsString             := QryFornec.FieldByName('LOTSAI').AsString;
            cdsDadosVALITE.AsFloat              := QryFornec.FieldByName('VALITE').AsFloat;
            cdsDadosTABPRE.AsString             := QryFornec.FieldByName('TABPRE').AsString;
            cdsDadosUNITAR.AsString             := QryFornec.FieldByName('UNITAR').AsString;
            cdsDadosNumEnt.AsString             := QryFornec.FieldByName('NUMENT').AsString;
            //GAE
            cdsDadosIncGae.AsString             := QryFornec.FieldByName('INCGAE').AsString;
            cdsDadosDTAENV.AsDateTime           := qryFornec.FieldByName('DTAENV').AsDateTime;
            cdsDadosGAE_NUMENV.AsString         := QryFornec.FieldByName('NUMENV').AsString;
            cdsDadosGAE_ESPENV.AsString         := QryFornec.FieldByName('ESPENV').AsString;
            cdsDadosGAE_EMPENV.AsString         := QryFornec.FieldByName('EMPENV').AsString;
            cdsDadosQTDENV.AsFloat              := qryFornec.FieldByName('QTDREQ').AsFloat - fltQtdPreNf;
            cdsDadosQTDREF.AsFloat              := qryFornec.FieldByName('QTDREF').AsFloat;
            cdsDadosQTDRET.AsFloat              := qryFornec.FieldByName('QTDRET').AsFloat;

            cdsDadosNFENVI.AsString             := fConcatenar([cdsDadosGAE_NUMENV.AsString,
                                                                cdsDadosGAE_ESPENV.AsString,
                                                                cdsDadosGAE_EMPENV.AsString],
                                                                '-');

            cdsDadosQTDBAI.AsFloat              := 0;
            cdsDadosSELECIONADO.AsString        := NAO;
            cdsDados.post;
          end;
        end;
      end;
      QryFornec.next;
    end;
    cdsdados.first;
  Finally
    blnBloqueioInserirDados := True;
  End;
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.pConfigurarTela;
begin
  if cdsDados.Active then
  begin
    cdsDados.EmptyDataSet
  end
  else
  begin
    cdsDados.CreateDataSet;
  end;

  cdsGroup           := TUniClientDataSet.Create(Self);
  cdsGroup.FieldDefs := cdsDados.FieldDefs;
  cdsGroup.CreateDataSet;

end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.pConfirmar;
var
  frmGravando : TFrmGravando;
  blnConfirmar: Boolean;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := 'Gravando Informações!';
    frmGravando.pgbStatus.Visible := False;
    frmGravando.fExecutarAcao := fConfirmar;
    frmGravando.ShowModal;
    blnConfirmar := frmGravando.blnConfirma;
    if blnConfirmar then
    begin
      fMensagem('Confirmação','Baixa concluída com sucesso.',['&OK']);
      pCarregarGarantias;
    end
    else
    begin
     fMensagem('Atenção!','Processo não concluído.',['&OK']);
    end;
  Finally
    FreeAndNil(frmGravando);
  End;
end;


procedure TfrmGarantiaBaixaEnvioFornecedorConserto.pEliminarItensProcessados(objDocBaixa: TDocBaixa);
Var
  ItemDoc: TItemDoc;
begin
  for ItemDoc in objDocBaixa.ItensDoc do
  begin
    if cdsDados.locate('AUTOINCREM',ItemDoc.strSeqGad,[]) then
    begin
      cdsDados.Delete;
    end;
  end;
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.pRemoverFiltro;
begin
  cdsDados.Filtered := False;
  cdsDados.Filter := '';
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.pMarcarItem(const blnSelecionar : Boolean; blnTodos: Boolean);
begin
  if blnTodos then
  begin
    Try
      cdsDados.DisableControls;
      cdsDados.First;
      While Not cdsDados.Eof Do
      Begin
        pMarcarItem(blnSelecionar);
        cdsDados.Next;
      End;
    Finally
      cdsDados.First;
      cdsDados.EnableControls;
    End;
  end
  else
  begin
    cdsDados.Edit;
    if blnSelecionar then
    begin
      if cdsDadosQTDBAI.AsFloat <= 0 then
        cdsDadosQTDBAI.AsFloat := cdsDadosSALENV.AsFloat;
    end;
    cdsDadosSELECIONADO.AsString := ifthen(blnSelecionar,SIM,NAO);
    cdsDados.post;
  end;
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.pMensagemDocEmitido(const strNumDoc, strEspDoc, strCodEmp: String);
CONST
  MSG: String = 'Documento de baixa de envio (Entrada - EF) emitido: '+slinebreak +
                 'Número: %s '+slineBreak+'Espécie: %s'+slinebreak+'Loja: %s';

Var
  strMsg: String;
begin
  strMsg := format(MSG,[strNumdoc, strEspDoc, strCodEmp]);
  fMensagem('Atenção',strMsg,['&OK']);
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.pMensagemInformarQuantidadeBaixa;
begin
 fMensagem('Atenção','Informe a quantidade que será baixada antes de selecionar.',['&OK']);
end;

function TfrmGarantiaBaixaEnvioFornecedorConserto.fObterDadosBaixa: TDocBaixa;
Var
  objDocBaixa: TDocBaixa;
  objItemDoc: TItemDoc;
begin
  Result := nil;
  Try
    cdsDados.DisableControls;
    fFiltrarSelecionados;
    if cdsDados.IsEmpty then
    begin
      Exit;
    end;

    objDocBaixa := TDocBaixa.Create;
    objDocBaixa.strCodFor := edtCodFor.Text;
    objDocBaixa.strMotBai := edtMotivo.Text;
    objDocBaixa.strCodOpe := strLoginUsuarioLogado;
    objDocBaixa.dtaDtaEmi := VS_Date;
    objDocBaixa.strClaFis := fObterClafis(cdsDados.FieldByName('CLAFIS').AsString);

    if rdbEntrada.Checked then
    begin
      objDocBaixa.blnEmitirDocEntradaProprio := True;
      objDocBaixa.blnAnularEnvio := True;
    end;

    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      If (cdsDadosSELECIONADO.AsString = '1') Then
      begin
        if (cdsDadosQTDBAI.AsFloat > 0) then
        Begin
          objDocBaixa.ItensDoc.Add(TItemDoc.Create);
          objItemDoc := objDocBaixa.ItensDoc.Last;
          pTransferirDadosCdsParaMovBcd(cdsDados,objItemDoc);
        End;
      End;
      cdsDados.Next;
    End;
    Result := objDocBaixa;
  Finally
    pRemoverFiltro;
    cdsDados.EnableControls;
  End;
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.FormCreate(Sender: TObject);
begin
  inherited;
  blnBloqueioInserirDados := True;

end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F10 : btnConfirmar.Click;
    VK_F6: btnMarcarTodos.click;
    VK_F7: btnDesmarcarTodos.click;
    VK_F4: btnInformarMotivo.click;
    VK_F5: btnPesquisar.click;
    VK_ESCAPE: btnSair.Click;
  end;
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.FormShow(Sender: TObject);
begin
  inherited;
  pAtualizarLabelInformacaoOperacao;
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.pOnKeyDownEdits(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.pSelecionarItem;
Var
  blnMarcar: Boolean;
begin
  inherited;
  if Not cdsDados.IsEmpty then
  begin
    blnMarcar := Not (cdsDadosSelecionado.AsString = SIM);
    pMarcarItem(blnMarcar);
  end;
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.pTransferirDadosCdsParaMovBcd(cdsDados: TUniClientDataSet; objItemDoc: TItemDoc);
begin
  objItemDoc.strSeqGad := cdsDadosAUTOINCREM.AsString;
  objItemDoc.strSeqGae := cdsDadosINCGAE.AsString;
  objItemDoc.strNumEnv := cdsDadosGAE_NUMENV.AsString;
  objItemDoc.strEspEnv := cdsDadosGAE_ESPENV.AsString;
  objItemDoc.strEmpEnv := cdsDadosGAE_EMPENV.AsString;
  objItemDoc.fltQtdEnv := cdsDadosQTDENV.AsFloat;
  objItemDoc.fltQtdRef := cdsDadosQTDREF.AsFloat;
  objItemDoc.fltQtdRet := cdsDadosQTDRET.AsFloat;
  objItemDoc.fltQtdBai := cdsDadosQTDBAI.AsFloat;
  objItemDoc.strCodIte := cdsDadosCODITE.AsString;
  objItemDoc.strDesIte := cdsDadosDESITE.AsString;
  objItemDoc.fltTotUni := cdsDadosUNITAR.AsFloat * objItemDoc.fltQtdBai;
  objItemDoc.fltQtdIte := objItemDoc.fltQtdBai;
  objItemDoc.fltValite := cdsDadosVALITE.AsFloat;
  objItemDoc.fltTotCus := cdsDadosPRECUS.AsFloat * objItemDoc.fltQtdBai;
  objItemDoc.strLotSai := cdsDadosLOTSAI.AsString;
  objItemDoc.strTabPre := cdsDadosTABPRE.AsString;
  objItemDoc.strNumEnt := cdsDadosNUMENT.AsString;
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.rdbCreditoClick(Sender: TObject);
begin
  inherited;
  pAtualizarLabelInformacaoOperacao(Sender);
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.rdbEntradaClick(Sender: TObject);
begin
  inherited;
  pAtualizarLabelInformacaoOperacao(Sender);
end;

function TfrmGarantiaBaixaEnvioFornecedorConserto.fValidarDadosConfirmacao: Boolean;
begin
  Result := Not cdsDados.IsEmpty;
  if Not Result  then
  begin
    fMensagem('','Localize e selecione uma garantia antes de continuar.',['&Ok']);
  end;

  if Result then
    Result := fFiltrarSelecionados;
  if  Not Result then
  begin
    fMensagem('','Selecione uma garantia antes de continuar.',['&Ok']);
  end;

  if Result then
    Result := Not fEmptyStr(edtMotivo.Text);
  if Not Result  then
  begin
    fMensagem('Atenção','Informe o motivo da baixa.',['&Ok']);
  end;
end;

function TfrmGarantiaBaixaEnvioFornecedorConserto.fSqlConsultaNotaEletronica: String;
begin
 Result :=          ' SELECT PCMGER.AUTOINCREM, PCG_NUMPED, N.B08_NNF, N.DET_CODITE, N.I10_QCOM ';
 Result := Result + ' FROM  MOVGAE ';
 Result := Result + ' INNER JOIN MOVGAD ON MOVGAD.AUTOINCREM = GAE_SEQGAD ';
 Result := Result + ' INNER JOIN PCMGER ON PCG_DOCORI = CONCAT(GAE_NUMENV, GAE_ESPENV, GAE_EMPENV) ';
 Result := Result + ' INNER JOIN PCMDET ON PCD_NUMPED = PCG_NUMPED AND PCD_ESPDOC = PCG_ESPDOC ';
 Result := Result +                      ' AND PCD_CODEMP = PCG_CODEMP AND PCD_NUMCTN = PCG_NUMCTN AND PCD_CODITE = GAD_CODITE ';
 Result := Result + ' INNER JOIN (SELECT PEL_NUMDOC, PEL_CODFOR, PEL_CODEMP, DET_CODITE, B08_NNF, I10_QCOM ';
 Result := Result +             ' FROM  PEDELE ';
 Result := Result +             ' JOIN GERELE ON GERELE.AUTOINCREM = PEDELE.PEL_SEQELE ';
 Result := Result +             ' JOIN DETELE ON  DETELE.DET_SEQGER = GERELE.AUTOINCREM  ) N ';
 Result := Result + ' ON N.PEL_NUMDOC = PCG_NUMPED     AND  N.PEL_CODFOR = PCG_CODFOR  AND N.PEL_CODEMP = PCG_CODEMP  AND N.DET_CODITE = PCD_CODITE ';
 Result := Result + ' WHERE MOVGAE.AUTOINCREM = :INCGAE ';
end;

function TfrmGarantiaBaixaEnvioFornecedorConserto.fVerificaSeExisteNotaEletronica(const strMovGae: String): Double;
Var
  Qry: TUniQuery;
begin
  Qry := Nil;
  Result := 0;
  Try
    Qry := fCriaQuery();
    Qry.Sql.Clear;
    Qry.Sql.Add(fSqlConsultaNotaEletronica);
    Qry.ParamByName('INCGAE').AsString := strMovGae;
    Qry.Open;
    if Not Qry.IsEmpty then
    begin
      Result := Qry.FieldByName('I10_QCOM').AsFloat;
    end;
    if Qry.Active then
      Qry.close;
  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.mskDtaFinExit(Sender: TObject);
begin
  inherited;
 If (ActiveControl) <> btnSair Then
    fValidaCampos(mskDtaFin, True);
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.mskDtaIniExit(Sender: TObject);
begin
  inherited;
 If (ActiveControl) <> btnSair Then
    fValidaCampos(mskDtaIni, True);
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.pObterMotivo;
begin
  Try
    frmGarantiaBaixaEnvioConsertoMotivo := TfrmGarantiaBaixaEnvioConsertoMotivo.Create(Self);
    frmGarantiaBaixaEnvioConsertoMotivo.showModal;
    edtMotivo.Text := frmGarantiaBaixaEnvioConsertoMotivo.strMotivo;
    frmGarantiaBaixaEnvioConsertoMotivo.Release;
  Finally
    if Assigned(frmGarantiaBaixaEnvioConsertoMotivo) then
      FreeAndNil(frmGarantiaBaixaEnvioConsertoMotivo);
  End;
end;

function TfrmGarantiaBaixaEnvioFornecedorConserto.fObterClafis(const strClaFisSaida: String): String;
Var
  strClaFisEnv: String;
begin
  strClaFisEnv := RightStr(strClaFisSaida,3);
  if pos('949',strClaFisEnv,2) > 0 then
    Result := '1949'
  else if pos('915',strClaFisEnv,2) > 0 then
    Result := '1916'
  else
    Result := '1916';
end;

function TfrmGarantiaBaixaEnvioFornecedorConserto.fPermiteBaixarMovGae(const fltQtdEnv, flQtdRet, fltQtdRef, fltQtdPre: Double): Boolean;
begin
  Result := fltQtdEnv - (flQtdRet + fltQtdRef + fltQtdPre) > 0
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.pLimpar;
begin
  edtMotivo.Clear;
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.pAtualizarLabelInformacaoOperacao;
begin
  if rdbEntrada.Checked then
    pAtualizarLabelInformacaoOperacao(rdbEntrada)
  else if rdbCredito.Checked then
    pAtualizarLabelInformacaoOperacao(rdbCredito);
end;

procedure TfrmGarantiaBaixaEnvioFornecedorConserto.pAtualizarLabelInformacaoOperacao(Sender: TObject);
begin
  if (Sender = rdbEntrada) and (rdbEntrada.Checked) then
    lblInfOperacao.Caption := 'A mercadoria irá retornar para estoque (reservado em garantia) e ficará disponível para ser reenviada ao fornecedor.'
  else if (Sender = rdbCredito) and (rdbCredito.Checked) then
    lblInfOperacao.Caption := 'O processo de envio para fornecedor será baixado e poderá optar por gerar título de crédito em contas a pagar.'
  else
    lblInfOperacao.Caption := EmptyStr;
end;

end.
