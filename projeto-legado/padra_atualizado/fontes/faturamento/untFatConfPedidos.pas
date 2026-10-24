{***************************}
{* qryConCli -> CADCLI     *}
{************************JB*}

unit untFatConfPedidos;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Mask, MaskEditFocus, EditFocus, Uni,
  Grids, DBGridCitel, DBGrids, Menus, ComCtrls, Buttons, ExtCtrls, DB, untFuncFat, untZClient,
  cxProgressBar, StrUtils, AppEvnts, BitBtnLockedIncrem, UniClientDataSet,
  frxClass, frxExportCSVTestabilidade, ComboBoxFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, untFuncoesComodatoCilindroVasilhame,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxTextEdit,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, cxGridCitel;

type
  TfrmFatConfPedidos = class(TfrmPaiSimples)
    pnlAux2: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtCodCli: TEditFocus;
    pnlBotoesBaixa: TPanel;
    btnItensDoc: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnSairConf: TBitBtnLocked;
    pnlAux1: TPanel;
    pnlDadosDup: TPanel;
    pnlInformativos: TPanel;
    Label16: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label11: TLabel;
    Label6: TLabel;
    Label17: TLabel;
    edtQtdDoc: TEditFocus;
    edtTotLiq: TEditFocus;
    edtQtdDocSel: TEditFocus;
    edtTotLiqSel: TEditFocus;
    edtNomCli: TEditFocus;
    pnlItens: TPanel;
    dbgItens: TDBGridCitel;
    pnlTotais: TPanel;
    Label32: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    lblTotSerDoc: TLabel;
    edtTotGerDoc: TEditFocus;
    edtDesEspDoc: TEditFocus;
    edtTotLiqDoc: TEditFocus;
    edtTotSerDoc: TEditFocus;
    pnlItensDoc: TPanel;
    gpbLegenda: TGroupBox;
    Shape1: TShape;
    Label7: TLabel;
    Shape2: TShape;
    Label8: TLabel;
    Label9: TLabel;
    Shape3: TShape;
    pnlDadosOS: TPanel;
    pnlFiltroEndereco: TPanel;
    lblEnderecoEntrega: TLabel;
    cmbClienteEnderecos: TComboBoxFocus;
    pnlCliFat: TPanel;
    Label10: TLabel;
    edtCliFat: TEditFocus;
    edtNomCliFat: TEditFocus;
    pnlPedOSG: TPanel;
    chkPedOSG: TCheckBox;
    cxgDocumentos: TcxGridCitel;
    cxgDocumentosTBV: TcxGridDBTableView;
    cxgDocumentosTBVTMP_DTAENT: TcxGridDBColumn;
    cxgDocumentosTBVTMP_CODVEN: TcxGridDBColumn;
    cxgDocumentosTBVTMP_NUMDOC: TcxGridDBColumn;
    cxgDocumentosTBVTMP_NUMOSE: TcxGridDBColumn;
    cxgDocumentosTBVTMP_ESPDOC: TcxGridDBColumn;
    cxgDocumentosTBVTMP_CODEMP: TcxGridDBColumn;
    cxgDocumentosTBVTMP_PORDES: TcxGridDBColumn;
    cxgDocumentosTBVTMP_VLRCON: TcxGridDBColumn;
    cxgDocumentosTBVTMP_ITEDOC: TcxGridDBColumn;
    cxgDocumentosTBVTMP_MARDES: TcxGridDBColumn;
    cxgDocumentosTBVTMP_TIPDOC: TcxGridDBColumn;
    cxgDocumentosLevel1: TcxGridLevel;
    cxgDocumentosTBVTMP_CILVAS: TcxGridDBColumn;
    shpLegendaComodato: TShape;
    lblLegendaComodato: TLabel;
    pnlPedOSC: TPanel;
    chkPedOSC: TCheckBox;
    procedure btnSairConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnItensDocClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmbClienteEnderecosSelect(Sender: TObject);
    procedure edtCliFatKeyPress(Sender: TObject; var Key: Char);
    procedure chkPedOSGClick(Sender: TObject);
    procedure cxgDocumentosTBVCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgDocumentosTBVCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgDocumentosTBVKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    strEspecie   : String;
    qryConCli    : TUniQuery;
    qryCliFat    : TUniQuery;
    blnFecharForm: Boolean;
    blnTemFinanc : Boolean;

    intItensDocs,
    intQtdSer: Integer;

    cdsItens: TZClient;
    fltPorDes: Double;
    strEmiSel: String;
    strPrevSel : String;
    strOrgPub: String;
    UFEndEnt : String;

    function fCriaTemporaria(pgbProgresso: TcxProgressBar = nil):Boolean;
    procedure pDeletaTemporaria;
    procedure pAtualizaTemporaria;
    procedure pCarregaCliente;

    function fGetSqlItens(blnVazio: Boolean = False): String;
    procedure pCarregaCdsItens(pgbStatus: TcxProgressBar = Nil);
    function fCarregaCdsItens(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pAfterScrollDocumentos(DataSet: TDataSet);

    procedure pCarregaItensDocumento;
    procedure pMarcaDocumento(blnMarcar: Boolean);
    procedure pCalculaTotais(blnFechouForm: Boolean = False);

    procedure pDeletaDocDesmarcados;
    procedure pPegaDoctoComProfis;
    procedure pAddPedidoHistCadRec(strNumDoc: String; strEspDoc: String; strCodEmp: String);

    function fCarregaPedidosConfirmados: Boolean;

    procedure pSetaInformacoesPedido(qryTemp: TUniQuery);
    procedure pSetaInformacoesCnd(strCodCnd: String);
    procedure pSetaInformacoesFpg(strConPagRef: String; dtaUltDtaAlt: TDateTime; dtaDtaEnt, dtaPrevis: TDateTime; strCodCnd, strCodFpg, strConPag, strIncGor: String);
    function fConPagPed(strConPagRef: String; dtaUltDtaAlt: TDateTime; strCodCnd: String; dtaDtaEnt, dtaPrevis: TDateTime): String;

    Function fTrataSaldo(strNumDoc, strEspDoc, strCodEmp: String): Boolean;

    function fCarregaNovoCliente: Boolean;
    function fVerificaTrocaCliente: Boolean;

    function fProducaoForaDeLoja(strNumDoc, strCodEmp, strCodCli: String): Boolean;
    function fDocsSelecionadosProducaoForaDeLoja: Boolean;
    function fPermiteProducaoForaDeLoja(strNumDoc, strCodEmp, strCodCli: String): Boolean;
    function fExisteDocSelecionado: Boolean;
    function fResolveTransportadorCondicao(strCampo: String; blnPermiteContinuar: Boolean = True): Boolean;
    function fTemp(strCampo: String; blnComTmp: Boolean = True): TField;
    procedure pCarregarInformacoesOrdemServico(DataSet: TDataSet);
    procedure pCarregarEnderecosEntrega;

    function fVerificaConPagMaiorPrazo(const ADataSet: TDataSet; const ATotGer: Double; var ACodCnd, AConPag, ACodFpg: String): Boolean;

    function fValidaInformacaoComodato: Boolean;

    function fValidarAbastecimentoDeposito():Boolean;
    function fPermiteMarcarPDOSGarantiaLoja(AGarantia: String): Boolean;
    function fEhAgrupamentoDePedidosPeloF11 : Boolean;
    function fPermiteMarcarPedido(const strNumDoc, strEspDoc, strCodEmp : String; const blnPedTemAdto : Boolean; const strCodCli : String) : Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    fatVenda : TFatVenda;
    strTemAdt: String;
    strTemSer: String;
    strSomSer: String;
    strIndCom: String;
    strCliCon: String;
    strTpOper: String;
    strCodFaz: String;
    strCodEmb: String;
    strCodPor: String;
    strTipOpe: String;
    strTipPed: String;
    strVenPre: String;
    strBEnFut: String;
    strRegDes: String;
    strFatSsa: String;
    strOpeExp: String;
    strSepExp: String;
    blnDeuErro   : Boolean;
    blnPedFabOSG : Boolean;

    pAlterarClienteConfirmacaoPedido: procedure(strCliOri, strCodCli: String) of object;
  end;

var
  frmFatConfPedidos: TfrmFatConfPedidos;

implementation

uses  untFuncoes, untfuncoesSimples, untPesqAux, untConsultas,
      untFatMostraProdConfirmacao, untFatMostraProdSemSaldo,
      untCadLote, untProdAcabado, untGravando, untAdiantamentoCliente,
      untFatResolveConflitoPedidos, untTypesSistema, untConstantes,
      untMsgLiberacao, untIFatReservaSaldo, untTFatReservaSaldo, untLiberacao,
      untIFatEntregaFutura, untTFatEntregaFutura, untFuncoesGenerica,
      untAdiantamentoClienteGenerico, untTEntCli,
      untFuncoesRel, untFuncoesRel2, untFatGor, untTPixDao, untTiposPix,
      untLinkPagamentoCitelUtil, Yapay.Api.Facade;

{$R *.dfm}

procedure TfrmFatConfPedidos.btnSairConfClick(Sender: TObject);
begin
  inherited;

  pCalculaTotais(True);
  Close;
end;

procedure TfrmFatConfPedidos.chkPedOSGClick(Sender: TObject);
begin
  chkPedOSG.OnClick := nil;
  chkPedOSC.OnClick := nil;

  try
    if (Sender = chkPedOSG) and chkPedOSG.Checked then
      chkPedOSC.Checked := False
    else if (Sender = chkPedOSC) and chkPedOSC.Checked then
      chkPedOSG.Checked := False;

    cxgDocumentosTBV.DataController.DataSource := Nil;
    fChamaTelaGravando(fCriaTemporaria, 'Aguarde, Carregando Documentos...');
    cxgDocumentosTBV.DataController.DataSource := fatVenda.dtsTemporariaConfirmacao;
  finally
    chkPedOSG.OnClick := chkPedOSGClick;
    chkPedOSC.OnClick := chkPedOSGClick;
  end;
end;

procedure TfrmFatConfPedidos.cmbClienteEnderecosSelect(Sender: TObject);
begin
  cxgDocumentosTBV.DataController.DataSource := Nil;
  fChamaTelaGravando(fCriaTemporaria, 'Aguarde, Carregando Documentos...');
  cxgDocumentosTBV.DataController.DataSource := fatVenda.dtsTemporariaConfirmacao;
  pSetFocus(cmbClienteEnderecos);
end;

procedure TfrmFatConfPedidos.cxgDocumentosTBVCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pMarcaDocumento(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString <> 'M');
end;

procedure TfrmFatConfPedidos.cxgDocumentosTBVCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if not fatVenda.qryTemporariaConfirmacao.Active then
    Exit;

  if (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgDocumentosTBVTMP_MARDES.Index]) = 'M') then
    ACanvas.Font.Color := clBlue
  else if (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgDocumentosTBVTMP_TIPDOC.Index]) = 'OS') then
    ACanvas.Font.Color := clGreen
  Else If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgDocumentosTBVTMP_CILVAS.Index]) = 'S') Then
    ACanvas.Font.Color := clPurple;
end;

procedure TfrmFatConfPedidos.cxgDocumentosTBVKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if (Key = VK_Escape) then
  begin
    if fMensagem('', 'Abandona?', ['&Sim', '&Não']) = 1 then
    begin
      pCalculaTotais(True);
      pDeletaTemporaria;
      Close;
    end;
  end
  else if (Key = VK_Return) then
    pMarcaDocumento(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString <> 'M')
  else if (Key = VK_F5) then
    btnItensDoc.Click
  else if (Key = VK_F10) then
  begin
    Key := 0;
    btnConfirma.Click;
  end;
end;

function TfrmFatConfPedidos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodCli) Then
    Begin

      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do cliente deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaCliente;
        If qryConCli.FieldByName('CLI_CODCLI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtCliFat) And pnlCliFat.Visible Then
    Begin
      If (fEmptyStr(edtCliFat.Text)) Then
      Begin
        edtCliFat.Text := edtCodCli.Text;
        fCarregaNovoCliente;
      End
      Else If (strOrgPub <> fCampoTabela('CLI_ORGPUB', 'CADCLI', ['CLI_CODCLI'], [edtCliFat.Text])) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é possível trocar um cliente "Orgão Publico" para um cliente "Não Orgão Publico"!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        If fCarregaNovoCliente Then
        Begin
          If (qryCliFat.IsEmpty) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End
        Else
          Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmFatConfPedidos.fValidaInformacaoComodato: Boolean;
var
  stlPedidos : TStrings;
  blnAfterScroll: Boolean;
  intRecNo:Integer;
begin
  stlPedidos := TStringList.Create;

  blnAfterScroll := Assigned(fatVenda.qryTemporariaConfirmacao.AfterScroll);
  fatVenda.qryTemporariaConfirmacao.AfterScroll := Nil;
  intRecNo := fatVenda.qryTemporariaConfirmacao.RecNo;
  fatVenda.qryTemporariaConfirmacao.DisableControls;

  Try
    fatVenda.qryTemporariaConfirmacao.First;

    While Not fatVenda.qryTemporariaConfirmacao.Eof Do
    Begin
      stlPedidos.Add(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_AUTINC').AsString);
      fatVenda.qryTemporariaConfirmacao.Next;
    End;

    If (Not fTodosOsFaturamentosIguais(stlPedidos)) Then
    Begin
      Result := False;
      Exit;
    End;

    Result := (Not fExistePedidoNormalComCilindroVasilhameNaoFaturado(stlPedidos));
  Finally
    fatVenda.qryTemporariaConfirmacao.RecNo := intRecNo;
    fatVenda.qryTemporariaConfirmacao.EnableControls;

    If blnAfterScroll Then
    Begin
      pAfterScroll(fatVenda.qryTemporariaConfirmacao);
      fatVenda.qryTemporariaConfirmacao.AfterScroll := pAfterScroll;
    End;

    FreeAndNil(stlPedidos);
  End;
end;

function TfrmFatConfPedidos.fValidarAbastecimentoDeposito(): Boolean;
Var
  intRecNo: Integer;
  blnAbaDep: Boolean;
  blnNaoAbaDep: Boolean;

  function fValidaRegistroPosicionado():Boolean;
  begin
    Result := fEhPedidoAbastecimentoDeposito(fTemp('NUMDOC').AsString, fTemp('ESPDOC').AsString, fTemp('CODEMP').AsString);
  end;

  procedure pProcessaValidacao();
  begin
    If fValidaRegistroPosicionado() Then
      blnAbaDep := True
    Else
      blnNaoAbaDep := True;
  end;
begin
  blnAbaDep := False;
  blnNaoAbaDep := False;

  pProcessaValidacao;

  intRecNo := fatVenda.qryTemporariaConfirmacao.RecNo;
  fatVenda.qryTemporariaConfirmacao.DisableControls;

  Try
    fatVenda.qryTemporariaConfirmacao.First;
    While Not fatVenda.qryTemporariaConfirmacao.Eof Do
    Begin
      If (fTemp('MARDES').AsString = 'M') Then
        pProcessaValidacao;

      If (blnAbaDep And blnNaoAbaDep) Then
        Break;

      fatVenda.qryTemporariaConfirmacao.Next;
    End;

    Result := (Not (blnAbaDep And blnNaoAbaDep));
  Finally
    If intRecNo > 0 Then
      fatVenda.qryTemporariaConfirmacao.RecNo := intRecNo;

    fatVenda.qryTemporariaConfirmacao.EnableControls;
  End;
end;

function TfrmFatConfPedidos.fVerificaConPagMaiorPrazo(const ADataSet: TDataSet; const ATotGer: Double;
  var ACodCnd, AConPag, ACodFpg: String): Boolean;
var
  LQry: TUniQuery;
  RecNoMaior: Integer;
  Maior: Integer;
  Aux: Integer;
  intContador: Integer;
  ValorParcela: Double;
  LRecNo: Integer;
begin
  Result := False;
  Maior := -1;
  RecNoMaior := 0;

  LQry := fCriaQuery;
  try
    LQry.SQL.Add('SELECT FGO_CONPAG, FGO_CODCND, FGO_CODFPG, CND_PARMIN');
    LQry.SQL.Add('FROM FATGOR');
    LQry.SQL.Add('LEFT JOIN CADCND ON CND_CODIGO = FGO_CODCND');
    LQry.SQL.Add('WHERE TRUE');
    LQry.SQL.Add(' AND ');
    LQry.SQL.Add('  (');

    ADataSet.DisableControls;
    LRecNo := ADataSet.RecNo;
    ADataSet.Last;
    intContador := ADataSet.RecNo;
    ADataSet.First;
    while not ADataSet.Eof do
    Begin
      LQry.SQL.Add(' (FGO_NUMDOC = ' + QuotedStr(ADataSet.FieldByName('TMP_NUMDOC').AsString) + ' AND ');
      LQry.SQL.Add('  FGO_ESPDOC = ' + QuotedStr(ADataSet.FieldByName('TMP_ESPDOC').AsString) + ' AND ');
      LQry.SQL.Add('  FGO_CODEMP = ' + QuotedStr(ADataSet.FieldByName('TMP_CODEMP').AsString) + ')    ');

      If intContador > ADataSet.RecNo Then
        LQry.SQL.Add(' OR ');

      ADataSet.Next;
    End;
    LQry.SQL.Add('  )');

    ADataSet.RecNo := LRecNo;
    ADataSet.EnableControls;

    LQry.Open;
    while not LQry.Eof do
    begin
      Aux := StrToInt(Copy(LQry.FieldByName('FGO_CONPAG').AsString, 1, 2));
      if Aux > Maior then
      begin
        Maior := Aux;
        RecNoMaior := LQry.RecNo;
      end;

      LQry.Next;
    end;

    LQry.RecNo := RecNoMaior;

    ValorParcela := ATotGer / Maior;
    if ValorParcela > LQry.FieldByName('CND_PARMIN').AsFloat then
    begin
      Result := True;
      ACodCnd := LQry.FieldByName('FGO_CODCND').AsString;
      AConPag := LQry.FieldByName('FGO_CONPAG').AsString;
      ACodFpg := LQry.FieldByName('FGO_CODFPG').AsString;
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

function TfrmFatConfPedidos.fVerificaTrocaCliente: Boolean;
var
  strCodCid: String;
  strNomCid: String;
  strEstCid: String;
  strCgcCpf: String;
  strNovCli: String;

  objLiberacao: TLiberacao;

  procedure pCarregarCliente(strCodCliente: String);
  begin
    strCodCid := fRetCodCidByCliente(strCodCliente);
    strNomCid := fRetNomCidade(strCodCid);
    strEstCid := fRetNomCidade(strCodCid, 1);
    strCgcCpf := fRetCgcCpf(strCodCliente);
    strCgcCpf := fFormataCpfCgc(strCgcCpf, fSetaPais);
  end;

begin

  strNovCli := fRetNomCliente(edtCliFat.Text);

  If fEmptyStr(strNovCli) Then
  Begin
    Result := True;
    Exit;
  End;

  objLiberacao := TLiberacao.Create;

  pCarregarCliente(edtCodCli.Text);

  objLiberacao.objMsgLibera.pAddSeparador;
  objLiberacao.objMsgLibera.pAddTexto('TROCA DE CLIENTE NA CONFIRMAÇÃO DE PEDIDOS');
  objLiberacao.objMsgLibera.pAddSeparador;
  objLiberacao.objMsgLibera.pAddTextoCaption('Cliente Atual:' , edtCodCli.Text + '-'+edtNomCli.Text, 22);
  objLiberacao.objMsgLibera.pAddTextoCaption('Cidade:'        , strNomCid + ' - ' + strEstCid, 22);
  objLiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ:'      , strCgcCpf, 22);

  objLiberacao.objMsgLibera.pAddQuebra;
  pCarregarCliente(edtCliFat.Text);

  objLiberacao.objMsgLibera.pAddTextoCaption('Novo Cliente:'  , edtCliFat.Text + '-'+ strNovCli, 22);
  objLiberacao.objMsgLibera.pAddTextoCaption('Cidade:'        , strNomCid + ' - ' + strEstCid, 22);
  objLiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ:'      , strCgcCpf, 22);
  objLiberacao.objMsgLibera.pAddSeparador;

  objLiberacao.strDirAce := 'LBTRCP';
  objLiberacao.strMsgSen := 'TROCA DE CLIENTE NA CONFIRMAÇÃO DE PEDIDOS';
  objLiberacao.blnMosMen := True;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;

  Result := objLiberacao.fLibera;

  FreeAndNil(objLiberacao);
end;

procedure TfrmFatConfPedidos.pAtualizaTemporaria;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + fatVenda.strTabelaConfMi;

  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    (FieldByName('TMP_VLRCON') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('TMP_DUPREC') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('TMP_PORDES') As TFloatField).DisplayFormat := '#,##0.00';
  End;

  pSetaInformacoesPedido(fatVenda.qryTemporariaConfirmacao);

end;
function TfrmFatConfPedidos.fCriaTemporaria(pgbProgresso: TcxProgressBar = nil):Boolean;
  Var
    strSQL: String;
    strNumDoc: String;
    intQtdIte: Integer;
    intContador: Integer;
    fltVlrCon: Double;
    qryGenDor: TUniQuery;
    qryGenGor: TUniQuery;
begin
  qryGenDor := fCriaQuery(Self);
  qryGenGor := fCriaQuery(Self);

  pCalculaTotais(True);
  pDeletaTemporaria;

  If fatVenda.strOpcDoc = 'OV' Then
  Begin

    strEspecie := 'OR';
    If (fCfgSis('USAPDV', varBoolean)) Then
    Begin
      If (fMensagem('', 'Escolha: ', ['&Orçamento', '&Pedido']) = 2) Then
        strEspecie := 'PD';
    End;
  End

  Else strEspecie := 'PD';

  {*******************************************}
  {* PEGA OS PEDIDOS AINDA NÃO CONFIRMADOS   *}
  {* DO CLIENTE                              *}
  {****************************************MV*}
  strSQL := '';
  strSQL := strSQL + 'SELECT DISTINCT ';
  strSQL := strSQL + '  FGO_NUMDOC, ';
  strSQL := strSQL + '  FGO_ESPDOC, ';
  strSQL := strSQL + '  FGO_CODEMP, ';
  strSQL := strSQL + '  FGO_CODCLI, ';
  strSQL := strSQL + '  FGO_DTAENT, ';
  strSQL := strSQL + '  FGO_PREVIS, ';
  strSQL := strSQL + '  FGO_JAFATU, ';
  strSQL := strSQL + '  FGO_CODVEN, ';
  strSQL := strSQL + '  FGO_DESESP - FGO_DEESPB AS FGO_DESESP, ';
  strSQL := strSQL + '  FGO_VLRCON, ';

  strSQL := strSQL + '  FGO_CODS01, ';
  strSQL := strSQL + '  FGO_CODS02, ';
  strSQL := strSQL + '  FGO_CODS03, ';
  strSQL := strSQL + '  FGO_CODS04, ';
  strSQL := strSQL + '  FGO_CODS05, ';
  strSQL := strSQL + '  FGO_CODS06, ';
  strSQL := strSQL + '  FGO_CODS07, ';
  strSQL := strSQL + '  FGO_CODS08, ';
  strSQL := strSQL + '  FGO_CODS09, ';
  strSQL := strSQL + '  FGO_CODS10, ';
  strSQL := strSQL + '  FGO_CODS11, ';
  strSQL := strSQL + '  FGO_CODS12, ';
  strSQL := strSQL + '  FGO_CODS13, ';
  strSQL := strSQL + '  FGO_CODS14, ';
  strSQL := strSQL + '  FGO_CODS15, ';
  strSQL := strSQL + '  FGO_CODS16, ';
  strSQL := strSQL + '  FGO_CODS17, ';
  strSQL := strSQL + '  FGO_CODS18, ';
  strSQL := strSQL + '  FGO_CODS19, ';
  strSQL := strSQL + '  FGO_CODS20, ';
  strSQL := strSQL + '  FGO_CODS21, ';
  strSQL := strSQL + '  FGO_CODS22, ';
  strSQL := strSQL + '  FGO_CODS23, ';
  strSQL := strSQL + '  FGO_CODS24, ';
  strSQL := strSQL + '  FGO_CODS25, ';
  strSQL := strSQL + '  FGO_CODS26, ';
  strSQL := strSQL + '  FGO_CODS27, ';
  strSQL := strSQL + '  FGO_CODS28, ';
  strSQL := strSQL + '  FGO_CODS29, ';
  strSQL := strSQL + '  FGO_CODS30, ';

  strSQL := strSQL + '  FGO_DESS01, ';
  strSQL := strSQL + '  FGO_DESS02, ';
  strSQL := strSQL + '  FGO_DESS03, ';
  strSQL := strSQL + '  FGO_DESS04, ';
  strSQL := strSQL + '  FGO_DESS05, ';
  strSQL := strSQL + '  FGO_DESS06, ';
  strSQL := strSQL + '  FGO_DESS07, ';
  strSQL := strSQL + '  FGO_DESS08, ';
  strSQL := strSQL + '  FGO_DESS09, ';
  strSQL := strSQL + '  FGO_DESS10, ';
  strSQL := strSQL + '  FGO_DESS11, ';
  strSQL := strSQL + '  FGO_DESS12, ';
  strSQL := strSQL + '  FGO_DESS13, ';
  strSQL := strSQL + '  FGO_DESS14, ';
  strSQL := strSQL + '  FGO_DESS15, ';
  strSQL := strSQL + '  FGO_DESS16, ';
  strSQL := strSQL + '  FGO_DESS17, ';
  strSQL := strSQL + '  FGO_DESS18, ';
  strSQL := strSQL + '  FGO_DESS19, ';
  strSQL := strSQL + '  FGO_DESS20, ';
  strSQL := strSQL + '  FGO_DESS21, ';
  strSQL := strSQL + '  FGO_DESS22, ';
  strSQL := strSQL + '  FGO_DESS23, ';
  strSQL := strSQL + '  FGO_DESS24, ';
  strSQL := strSQL + '  FGO_DESS25, ';
  strSQL := strSQL + '  FGO_DESS26, ';
  strSQL := strSQL + '  FGO_DESS27, ';
  strSQL := strSQL + '  FGO_DESS28, ';
  strSQL := strSQL + '  FGO_DESS29, ';
  strSQL := strSQL + '  FGO_DESS30, ';

  strSQL := strSQL + '  FGO_QTDS01, ';
  strSQL := strSQL + '  FGO_QTDS02, ';
  strSQL := strSQL + '  FGO_QTDS03, ';
  strSQL := strSQL + '  FGO_QTDS04, ';
  strSQL := strSQL + '  FGO_QTDS05, ';
  strSQL := strSQL + '  FGO_QTDS06, ';
  strSQL := strSQL + '  FGO_QTDS07, ';
  strSQL := strSQL + '  FGO_QTDS08, ';
  strSQL := strSQL + '  FGO_QTDS09, ';
  strSQL := strSQL + '  FGO_QTDS10, ';
  strSQL := strSQL + '  FGO_QTDS11, ';
  strSQL := strSQL + '  FGO_QTDS12, ';
  strSQL := strSQL + '  FGO_QTDS13, ';
  strSQL := strSQL + '  FGO_QTDS14, ';
  strSQL := strSQL + '  FGO_QTDS15, ';
  strSQL := strSQL + '  FGO_QTDS16, ';
  strSQL := strSQL + '  FGO_QTDS17, ';
  strSQL := strSQL + '  FGO_QTDS18, ';
  strSQL := strSQL + '  FGO_QTDS19, ';
  strSQL := strSQL + '  FGO_QTDS20, ';
  strSQL := strSQL + '  FGO_QTDS21, ';
  strSQL := strSQL + '  FGO_QTDS22, ';
  strSQL := strSQL + '  FGO_QTDS23, ';
  strSQL := strSQL + '  FGO_QTDS24, ';
  strSQL := strSQL + '  FGO_QTDS25, ';
  strSQL := strSQL + '  FGO_QTDS26, ';
  strSQL := strSQL + '  FGO_QTDS27, ';
  strSQL := strSQL + '  FGO_QTDS28, ';
  strSQL := strSQL + '  FGO_QTDS29, ';
  strSQL := strSQL + '  FGO_QTDS30, ';

  strSQL := strSQL + '  FGO_UNIS01, ';
  strSQL := strSQL + '  FGO_UNIS02, ';
  strSQL := strSQL + '  FGO_UNIS03, ';
  strSQL := strSQL + '  FGO_UNIS04, ';
  strSQL := strSQL + '  FGO_UNIS05, ';
  strSQL := strSQL + '  FGO_UNIS06, ';
  strSQL := strSQL + '  FGO_UNIS07, ';
  strSQL := strSQL + '  FGO_UNIS08, ';
  strSQL := strSQL + '  FGO_UNIS09, ';
  strSQL := strSQL + '  FGO_UNIS10, ';
  strSQL := strSQL + '  FGO_UNIS11, ';
  strSQL := strSQL + '  FGO_UNIS12, ';
  strSQL := strSQL + '  FGO_UNIS13, ';
  strSQL := strSQL + '  FGO_UNIS14, ';
  strSQL := strSQL + '  FGO_UNIS15, ';
  strSQL := strSQL + '  FGO_UNIS16, ';
  strSQL := strSQL + '  FGO_UNIS17, ';
  strSQL := strSQL + '  FGO_UNIS18, ';
  strSQL := strSQL + '  FGO_UNIS19, ';
  strSQL := strSQL + '  FGO_UNIS20, ';
  strSQL := strSQL + '  FGO_UNIS21, ';
  strSQL := strSQL + '  FGO_UNIS22, ';
  strSQL := strSQL + '  FGO_UNIS23, ';
  strSQL := strSQL + '  FGO_UNIS24, ';
  strSQL := strSQL + '  FGO_UNIS25, ';
  strSQL := strSQL + '  FGO_UNIS26, ';
  strSQL := strSQL + '  FGO_UNIS27, ';
  strSQL := strSQL + '  FGO_UNIS28, ';
  strSQL := strSQL + '  FGO_UNIS29, ';
  strSQL := strSQL + '  FGO_UNIS30, ';

  strSQL := strSQL + '  FGO_VALS01, ';
  strSQL := strSQL + '  FGO_VALS02, ';
  strSQL := strSQL + '  FGO_VALS03, ';
  strSQL := strSQL + '  FGO_VALS04, ';
  strSQL := strSQL + '  FGO_VALS05, ';
  strSQL := strSQL + '  FGO_VALS06, ';
  strSQL := strSQL + '  FGO_VALS07, ';
  strSQL := strSQL + '  FGO_VALS08, ';
  strSQL := strSQL + '  FGO_VALS09, ';
  strSQL := strSQL + '  FGO_VALS10, ';
  strSQL := strSQL + '  FGO_VALS11, ';
  strSQL := strSQL + '  FGO_VALS12, ';
  strSQL := strSQL + '  FGO_VALS13, ';
  strSQL := strSQL + '  FGO_VALS14, ';
  strSQL := strSQL + '  FGO_VALS15, ';
  strSQL := strSQL + '  FGO_VALS16, ';
  strSQL := strSQL + '  FGO_VALS17, ';
  strSQL := strSQL + '  FGO_VALS18, ';
  strSQL := strSQL + '  FGO_VALS19, ';
  strSQL := strSQL + '  FGO_VALS20, ';
  strSQL := strSQL + '  FGO_VALS21, ';
  strSQL := strSQL + '  FGO_VALS22, ';
  strSQL := strSQL + '  FGO_VALS23, ';
  strSQL := strSQL + '  FGO_VALS24, ';
  strSQL := strSQL + '  FGO_VALS25, ';
  strSQL := strSQL + '  FGO_VALS26, ';
  strSQL := strSQL + '  FGO_VALS27, ';
  strSQL := strSQL + '  FGO_VALS28, ';
  strSQL := strSQL + '  FGO_VALS29, ';
  strSQL := strSQL + '  FGO_VALS30, ';

  strSQL := strSQL + '  FGO_DECS01, ';
  strSQL := strSQL + '  FGO_DECS02, ';
  strSQL := strSQL + '  FGO_DECS03, ';
  strSQL := strSQL + '  FGO_DECS04, ';
  strSQL := strSQL + '  FGO_DECS05, ';
  strSQL := strSQL + '  FGO_DECS06, ';
  strSQL := strSQL + '  FGO_DECS07, ';
  strSQL := strSQL + '  FGO_DECS08, ';
  strSQL := strSQL + '  FGO_DECS09, ';
  strSQL := strSQL + '  FGO_DECS10, ';
  strSQL := strSQL + '  FGO_DECS11, ';
  strSQL := strSQL + '  FGO_DECS12, ';
  strSQL := strSQL + '  FGO_DECS13, ';
  strSQL := strSQL + '  FGO_DECS14, ';
  strSQL := strSQL + '  FGO_DECS15, ';
  strSQL := strSQL + '  FGO_DECS16, ';
  strSQL := strSQL + '  FGO_DECS17, ';
  strSQL := strSQL + '  FGO_DECS18, ';
  strSQL := strSQL + '  FGO_DECS19, ';
  strSQL := strSQL + '  FGO_DECS20, ';
  strSQL := strSQL + '  FGO_DECS21, ';
  strSQL := strSQL + '  FGO_DECS22, ';
  strSQL := strSQL + '  FGO_DECS23, ';
  strSQL := strSQL + '  FGO_DECS24, ';
  strSQL := strSQL + '  FGO_DECS25, ';
  strSQL := strSQL + '  FGO_DECS26, ';
  strSQL := strSQL + '  FGO_DECS27, ';
  strSQL := strSQL + '  FGO_DECS28, ';
  strSQL := strSQL + '  FGO_DECS29, ';
  strSQL := strSQL + '  FGO_DECS30, ';

  strSQL := strSQL + '  FGO_IDES01, ';
  strSQL := strSQL + '  FGO_IDES02, ';
  strSQL := strSQL + '  FGO_IDES03, ';
  strSQL := strSQL + '  FGO_IDES04, ';
  strSQL := strSQL + '  FGO_IDES05, ';
  strSQL := strSQL + '  FGO_IDES06, ';
  strSQL := strSQL + '  FGO_IDES07, ';
  strSQL := strSQL + '  FGO_IDES08, ';
  strSQL := strSQL + '  FGO_IDES09, ';
  strSQL := strSQL + '  FGO_IDES10, ';
  strSQL := strSQL + '  FGO_IDES11, ';
  strSQL := strSQL + '  FGO_IDES12, ';
  strSQL := strSQL + '  FGO_IDES13, ';
  strSQL := strSQL + '  FGO_IDES14, ';
  strSQL := strSQL + '  FGO_IDES15, ';
  strSQL := strSQL + '  FGO_IDES16, ';
  strSQL := strSQL + '  FGO_IDES17, ';
  strSQL := strSQL + '  FGO_IDES18, ';
  strSQL := strSQL + '  FGO_IDES19, ';
  strSQL := strSQL + '  FGO_IDES20, ';
  strSQL := strSQL + '  FGO_IDES21, ';
  strSQL := strSQL + '  FGO_IDES22, ';
  strSQL := strSQL + '  FGO_IDES23, ';
  strSQL := strSQL + '  FGO_IDES24, ';
  strSQL := strSQL + '  FGO_IDES25, ';
  strSQL := strSQL + '  FGO_IDES26, ';
  strSQL := strSQL + '  FGO_IDES27, ';
  strSQL := strSQL + '  FGO_IDES28, ';
  strSQL := strSQL + '  FGO_IDES29, ';
  strSQL := strSQL + '  FGO_IDES30, ';

  strSQL := strSQL + '  FGO_BRIS01, ';
  strSQL := strSQL + '  FGO_BRIS02, ';
  strSQL := strSQL + '  FGO_BRIS03, ';
  strSQL := strSQL + '  FGO_BRIS04, ';
  strSQL := strSQL + '  FGO_BRIS05, ';
  strSQL := strSQL + '  FGO_BRIS06, ';
  strSQL := strSQL + '  FGO_BRIS07, ';
  strSQL := strSQL + '  FGO_BRIS08, ';
  strSQL := strSQL + '  FGO_BRIS09, ';
  strSQL := strSQL + '  FGO_BRIS10, ';
  strSQL := strSQL + '  FGO_BRIS11, ';
  strSQL := strSQL + '  FGO_BRIS12, ';
  strSQL := strSQL + '  FGO_BRIS13, ';
  strSQL := strSQL + '  FGO_BRIS14, ';
  strSQL := strSQL + '  FGO_BRIS15, ';
  strSQL := strSQL + '  FGO_BRIS16, ';
  strSQL := strSQL + '  FGO_BRIS17, ';
  strSQL := strSQL + '  FGO_BRIS18, ';
  strSQL := strSQL + '  FGO_BRIS19, ';
  strSQL := strSQL + '  FGO_BRIS20, ';
  strSQL := strSQL + '  FGO_BRIS21, ';
  strSQL := strSQL + '  FGO_BRIS22, ';
  strSQL := strSQL + '  FGO_BRIS23, ';
  strSQL := strSQL + '  FGO_BRIS24, ';
  strSQL := strSQL + '  FGO_BRIS25, ';
  strSQL := strSQL + '  FGO_BRIS26, ';
  strSQL := strSQL + '  FGO_BRIS27, ';
  strSQL := strSQL + '  FGO_BRIS28, ';
  strSQL := strSQL + '  FGO_BRIS29, ';
  strSQL := strSQL + '  FGO_BRIS30, ';

  strSQL := strSQL + '  FGO_PARS01, ';
  strSQL := strSQL + '  FGO_PARS02, ';
  strSQL := strSQL + '  FGO_PARS03, ';
  strSQL := strSQL + '  FGO_PARS04, ';
  strSQL := strSQL + '  FGO_PARS05, ';
  strSQL := strSQL + '  FGO_PARS06, ';
  strSQL := strSQL + '  FGO_PARS07, ';
  strSQL := strSQL + '  FGO_PARS08, ';
  strSQL := strSQL + '  FGO_PARS09, ';
  strSQL := strSQL + '  FGO_PARS10, ';
  strSQL := strSQL + '  FGO_PARS11, ';
  strSQL := strSQL + '  FGO_PARS12, ';
  strSQL := strSQL + '  FGO_PARS13, ';
  strSQL := strSQL + '  FGO_PARS14, ';
  strSQL := strSQL + '  FGO_PARS15, ';
  strSQL := strSQL + '  FGO_PARS16, ';
  strSQL := strSQL + '  FGO_PARS17, ';
  strSQL := strSQL + '  FGO_PARS18, ';
  strSQL := strSQL + '  FGO_PARS19, ';
  strSQL := strSQL + '  FGO_PARS20, ';
  strSQL := strSQL + '  FGO_PARS21, ';
  strSQL := strSQL + '  FGO_PARS22, ';
  strSQL := strSQL + '  FGO_PARS23, ';
  strSQL := strSQL + '  FGO_PARS24, ';
  strSQL := strSQL + '  FGO_PARS25, ';
  strSQL := strSQL + '  FGO_PARS26, ';
  strSQL := strSQL + '  FGO_PARS27, ';
  strSQL := strSQL + '  FGO_PARS28, ';
  strSQL := strSQL + '  FGO_PARS29, ';
  strSQL := strSQL + '  FGO_PARS30, ';

  strSQL := strSQL + '  FGO_TBRS01, ';
  strSQL := strSQL + '  FGO_TBRS02, ';
  strSQL := strSQL + '  FGO_TBRS03, ';
  strSQL := strSQL + '  FGO_TBRS04, ';
  strSQL := strSQL + '  FGO_TBRS05, ';
  strSQL := strSQL + '  FGO_TBRS06, ';
  strSQL := strSQL + '  FGO_TBRS07, ';
  strSQL := strSQL + '  FGO_TBRS08, ';
  strSQL := strSQL + '  FGO_TBRS09, ';
  strSQL := strSQL + '  FGO_TBRS10, ';
  strSQL := strSQL + '  FGO_TBRS11, ';
  strSQL := strSQL + '  FGO_TBRS12, ';
  strSQL := strSQL + '  FGO_TBRS13, ';
  strSQL := strSQL + '  FGO_TBRS14, ';
  strSQL := strSQL + '  FGO_TBRS15, ';
  strSQL := strSQL + '  FGO_TBRS16, ';
  strSQL := strSQL + '  FGO_TBRS17, ';
  strSQL := strSQL + '  FGO_TBRS18, ';
  strSQL := strSQL + '  FGO_TBRS19, ';
  strSQL := strSQL + '  FGO_TBRS20, ';
  strSQL := strSQL + '  FGO_TBRS21, ';
  strSQL := strSQL + '  FGO_TBRS22, ';
  strSQL := strSQL + '  FGO_TBRS23, ';
  strSQL := strSQL + '  FGO_TBRS24, ';
  strSQL := strSQL + '  FGO_TBRS25, ';
  strSQL := strSQL + '  FGO_TBRS26, ';
  strSQL := strSQL + '  FGO_TBRS27, ';
  strSQL := strSQL + '  FGO_TBRS28, ';
  strSQL := strSQL + '  FGO_TBRS29, ';
  strSQL := strSQL + '  FGO_TBRS30, ';

  strSQL := strSQL + '  FGO_VENS01, ';
  strSQL := strSQL + '  FGO_VENS02, ';
  strSQL := strSQL + '  FGO_VENS03, ';
  strSQL := strSQL + '  FGO_VENS04, ';
  strSQL := strSQL + '  FGO_VENS05, ';
  strSQL := strSQL + '  FGO_VENS06, ';
  strSQL := strSQL + '  FGO_VENS07, ';
  strSQL := strSQL + '  FGO_VENS08, ';
  strSQL := strSQL + '  FGO_VENS09, ';
  strSQL := strSQL + '  FGO_VENS10, ';
  strSQL := strSQL + '  FGO_VENS11, ';
  strSQL := strSQL + '  FGO_VENS12, ';
  strSQL := strSQL + '  FGO_VENS13, ';
  strSQL := strSQL + '  FGO_VENS14, ';
  strSQL := strSQL + '  FGO_VENS15, ';
  strSQL := strSQL + '  FGO_VENS16, ';
  strSQL := strSQL + '  FGO_VENS17, ';
  strSQL := strSQL + '  FGO_VENS18, ';
  strSQL := strSQL + '  FGO_VENS19, ';
  strSQL := strSQL + '  FGO_VENS20, ';
  strSQL := strSQL + '  FGO_VENS21, ';
  strSQL := strSQL + '  FGO_VENS22, ';
  strSQL := strSQL + '  FGO_VENS23, ';
  strSQL := strSQL + '  FGO_VENS24, ';
  strSQL := strSQL + '  FGO_VENS25, ';
  strSQL := strSQL + '  FGO_VENS26, ';
  strSQL := strSQL + '  FGO_VENS27, ';
  strSQL := strSQL + '  FGO_VENS28, ';
  strSQL := strSQL + '  FGO_VENS29, ';
  strSQL := strSQL + '  FGO_VENS30, ';

  strSQL := strSQL + '  FGO_VE2S01, ';
  strSQL := strSQL + '  FGO_VE2S02, ';
  strSQL := strSQL + '  FGO_VE2S03, ';
  strSQL := strSQL + '  FGO_VE2S04, ';
  strSQL := strSQL + '  FGO_VE2S05, ';
  strSQL := strSQL + '  FGO_VE2S06, ';
  strSQL := strSQL + '  FGO_VE2S07, ';
  strSQL := strSQL + '  FGO_VE2S08, ';
  strSQL := strSQL + '  FGO_VE2S09, ';
  strSQL := strSQL + '  FGO_VE2S10, ';
  strSQL := strSQL + '  FGO_VE2S11, ';
  strSQL := strSQL + '  FGO_VE2S12, ';
  strSQL := strSQL + '  FGO_VE2S13, ';
  strSQL := strSQL + '  FGO_VE2S14, ';
  strSQL := strSQL + '  FGO_VE2S15, ';
  strSQL := strSQL + '  FGO_VE2S16, ';
  strSQL := strSQL + '  FGO_VE2S17, ';
  strSQL := strSQL + '  FGO_VE2S18, ';
  strSQL := strSQL + '  FGO_VE2S19, ';
  strSQL := strSQL + '  FGO_VE2S20, ';
  strSQL := strSQL + '  FGO_VE2S21, ';
  strSQL := strSQL + '  FGO_VE2S22, ';
  strSQL := strSQL + '  FGO_VE2S23, ';
  strSQL := strSQL + '  FGO_VE2S24, ';
  strSQL := strSQL + '  FGO_VE2S25, ';
  strSQL := strSQL + '  FGO_VE2S26, ';
  strSQL := strSQL + '  FGO_VE2S27, ';
  strSQL := strSQL + '  FGO_VE2S28, ';
  strSQL := strSQL + '  FGO_VE2S29, ';
  strSQL := strSQL + '  FGO_VE2S30, ';

  strSQL := strSQL + '  FGO_NUMPOK, ';
  strSQL := strSQL + '  FGO_PEDSIT, ';
  strSQL := strSQL + '  FGO_LIBERA, ';
  strSQL := strSQL + '  FGO_CODEMP, ';
  strSQL := strSQL + '  FGO_CODFPG, ';
  strSQL := strSQL + '  FGO_CODCND, ';
  strSQL := strSQL + '  FGO_CONPAG, ';
  strSQL := strSQL + '  FGO_CODCLI, ';
  strSQL := strSQL + '  FGO_CODPOR, ';
  strSQL := strSQL + '  FGO_CODFAZ, ';
  strSQL := strSQL + '  FGO_TIPOPE, ';
  strSQL := strSQL + '  FGO_TIPPED, ';
  strSQL := strSQL + '  IF(IFNULL(FGO_INDCOM,"") = "", "C", FGO_INDCOM) AS FGO_INDCOM, ';
  strSQL := strSQL + '  FATGOR.AUTOINCREM AS FGO_AUTINC, ';
  strSQL := strSQL + '  FGO_MENEXP, ';
  strSQL := strSQL + '  FGO_MENEX2, ';
  strSQL := strSQL + '  FGO_MENEX3, ';
  strSQL := strSQL + '  FGO_MENEX4, ';
  strSQL := strSQL + '  FGO_MEN001, ';
  strSQL := strSQL + '  FGO_MEN002, ';
  strSQL := strSQL + '  AG.AUX_MEN003, ';
  strSQL := strSQL + '  AG.AUX_MEN004, ';
  strSQL := strSQL + '  AG.AUX_MEN005, ';
  strSQL := strSQL + '  FGO_VENPRE, ';
  strSQL := strSQL + '  FGO_PORDES, ';
  strSQL := strSQL + '  S.FGO_DISSER AS FGO_DISSER, ';
  strSQL := strSQL + '  FGO_CODTRA, ';
  strSQL := strSQL + '  IF(IFNULL(EQ.EQU_NUMPED, IFNULL(EQ2.EQU_NUMPED, "")) <> "", "OS", FGO_ESPDOC) AS TMP_TIPDOC, ';
  strSQL := strSQL + '  FGO_CODEMB, ';
  strSQL := strSQL + '  FGO_CONSUM, ';
  strSQL := strSQL + '  FGO_TPOPER, ';
  strSQL := strSQL + '  FGO_ULTALT, ';
  strSQL := strSQL + '  FGO_EMPPIX, ';
  strSQL := strSQL + '  FGO_TX_PIX, ';
  strSQL := strSQL + '  FGO_REGDES, ';
  strSQL := strSQL + '  FGO_FATSSA, ';
  strSQL := strSQL + '  IF(FDO_INCFUT IS NOT NULL, "S", "N") AS FDO_INCFUT, ';
  strSQL := strSQL + '  IFNULL(EQ.EQU_NUMOSE, EQ2.EQU_NUMOSE) AS TMP_NUMOSE, ';
  strSQL := strSQL + ' ' + SELECT_STATUS_OS_LEFT + ' AS TMP_STATUS_OS, ';
  strSQL := strSQL + ' ' + SELECT_SUBSTA_OS_LEFT + ' AS TMP_SUBSTA_OS, ';
  strSQL := strSQL + ' ' + SELECT_SITUAC_OS_LEFT + ' AS TMP_SITUAC_OS,  ';
  strSQL := strSQL + '  FGO_CILVAS, ';
  strSQL := strSQL + '  FGO_AUTICV, ';
  strSQL := strSQL + '  FGO_CDCOPO, ';
  strSQL := strSQL + '  FGO_CDCSTA, ';
  strSQL := strSQL + '  FGO_CODTPA, ';
  strSQL := strSQL + '  IF((IFNULL(EQ.EQU_GARANT, IFNULL(EQ2.EQU_GARANT, "N")) = "L"), "S", "N") AS TMP_GARLOJ, ';
  strSQL := strSQL + '  E.FGO_OPEEXP AS FGO_OPEEXP, ';
  strSQL := strSQL + '  E.FGO_SEPEXP AS FGO_SEPEXP  ';
  strSQL := strSQL + 'FROM          ';
  strSQL := strSQL + '  FATGOR      ';
  strSQL := strSQL + '  JOIN CADCLI ON FGO_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  JOIN FATDOR ON FDO_NUMDOC = FGO_NUMDOC AND ';
  strSQL := strSQL + '                 FDO_ESPDOC = FGO_ESPDOC AND ';
  strSQL := strSQL + '                 FDO_CODEMP = FGO_CODEMP AND ';
  strSQL := strSQL + '                 FDO_CODCLI = FGO_CODCLI     ';
  strSQL := strSQL + '  LEFT JOIN EXTDOR ED ON FATDOR.AUTOINCREM = ED.FDO_SEQFDO ';
  strSQL := strSQL + '  LEFT JOIN EXTGOR E ON FATGOR.AUTOINCREM = E.FGO_SEQFGO ';
  strSQL := strSQL + '  LEFT JOIN SERGOR S ON FATGOR.AUTOINCREM = S.FGO_SEQFGO ';

  strSQL := strSQL + '  LEFT JOIN EQUGER EQ ON (EQ.EQU_NUMPED = FATGOR.FGO_NUMDOC AND EQ.EQU_EMPPED = FATGOR.FGO_CODEMP) ';
  strSQL := strSQL + '  LEFT JOIN EQUGOR ON FATGOR.AUTOINCREM = EQUGOR.FGO_SEQFGO ';
  strSQL := strSQL + '  LEFT JOIN EQUGER EQ2 ON (EQ2.AUTOINCREM = EQUGOR.FGO_SEQEQU) ';

  strSQL := strSQL + '  LEFT JOIN AUXGOR AG ON AG.AUX_SEQGER = FATGOR.AUTOINCREM ';

  {Liberação de Pedidos Externos}
  If (strEspecie = 'PD') And fCfgSis('LIBEXT', varBoolean) Then
  Begin
    strSQL := strSQL + '  LEFT JOIN LIBEXT ON (LEX_NUMDOC = FGO_NUMDOC AND ';
    strSQL := strSQL + '                       LEX_ESPDOC = FGO_ESPDOC AND ';
    strSQL := strSQL + '                       LEX_CODEMP = FGO_CODEMP)    ';
  End;

  if not fEmptyStr(cmbClienteEnderecos.Text) then
  begin
    strSQL := strSQL + ' JOIN AUXGOR ON AUXGOR.AUX_SEQGER = FATGOR.AUTOINCREM '+
                       '            AND AUXGOR.AUX_ENTGER = '+
                       QuotedStr(TClienteEnderecoEntregaRepositorio.
                       fGetAutoIncEnderecoEntega(cmbClienteEnderecos));
  end;

  strSQL := strSQL + 'WHERE         ';

  If fatVenda.strOpcDoc <> 'OV' Then
    strSQL := strSQL + '  FGO_CODEMP = :CODEMP AND ';

  strSQL := strSQL + '  FGO_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  FDO_JAFATU = FALSE   AND ';
  strSQL := strSQL + '  FGO_DOCEND IS NULL   AND ';
  strSQL := strSQL + '  FGO_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  IFNULL(E.FGO_LOC_PD, "N") <> "S"   ';

  If strEspecie = 'PD' Then
    strSQL := strSQL + '  AND FGO_LIBERA > 0 ';

  {Liberação de Pedidos Externos - Oculta "Não Liberados" externos (Mobile e Site)}
  If (strEspecie = 'PD') And fCfgSis('LIBEXT', varBoolean) Then
  Begin
    strSQL := strSQL + '  AND (((IFNULL(FGO_NUMPOK, "") <> "") AND (LEX_LIBPOK = "S")) OR (IFNULL(FGO_NUMPOK, "") = "") OR LEX_LIBPOK IS NULL) AND ';
    strSQL := strSQL + '      (((IFNULL(FGO_PEDSIT, "") <> "") AND (LEX_LIBPOK = "S")) OR (IFNULL(FGO_PEDSIT, "") = "") OR LEX_LIBPOK IS NULL) ';
  End;

  if (chkPedOSG.Checked) then
  begin
    strSQL := strSQL + '  AND EQUGOR.FGO_ITEPED = "S" ';
    strSQL := strSQL + '  AND EXISTS (SELECT FOR_CODFOR FROM CADFOR WHERE CADFOR.FOR_CODCLI = FGO_CODCLI) ';
  end;

  if (chkPedOSC.Checked) then
    strSQL := strSQL + '  AND EQUGOR.FGO_ITEPED = "S" AND EQUGOR.FGO_TIPAPR = "B" ';

  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  FGO_NUMDOC, FGO_ESPDOC ';

  qryGenGor.Close;
  qryGenGor.SQL.Clear;
  qryGenGor.SQL.Add(strSQL);
  qryGenGor.ParamByName('ESPDOC').AsString := strEspecie;
  qryGenGor.ParamByName('CODCLI').AsString := edtCodCli.Text;

  If fatVenda.strOpcDoc <> 'OV' Then
    qryGenGor.ParamByName('CODEMP').AsString := VS_strCodEmp;

  qryGenGor.Open;

  strSQL := '';
  strSQL := strSQL + 'SELECT        ';
  strSQL := strSQL + '  FDO_SEQGER, ';
  strSQL := strSQL + '  FDO_NUMDOC, ';
  strSQL := strSQL + '  FDO_ESPDOC, ';
  strSQL := strSQL + '  FDO_CODEMP, ';
  strSQL := strSQL + '  FDO_CODCLI, ';
  strSQL := strSQL + '  (FDO_QTDITE - FDO_QTDBAI) * FDO_UNITAR AS FDO_VLRCON, ';
  strSQL := strSQL + '  FDO_VALIPI,  ';
  strSQL := strSQL + '  (((FDO_QTDITE - FDO_QTDBAI) * FDO_UNITAR) + FDO_VALIPI) AS FDO_VLRTOT ';
  strSQL := strSQL + 'FROM     ';
  strSQL := strSQL + '  FATDOR ';
  strSQL := strSQL + '  JOIN FATGOR ON FDO_NUMDOC = FGO_NUMDOC AND ';
  strSQL := strSQL + '                 FDO_ESPDOC = FGO_ESPDOC AND ';
  strSQL := strSQL + '                 FDO_CODEMP = FGO_CODEMP AND ';
  strSQL := strSQL + '                 FDO_CODCLI = FGO_CODCLI     ';
  strSQL := strSQL + '  LEFT JOIN EXTGOR E ON FATGOR.AUTOINCREM = E.FGO_SEQFGO ';
  strSQL := strSQL + 'WHERE    ';
  strSQL := strSQL + '  FDO_CODCLI = :CODCLI AND ';

  If fatVenda.strOpcDoc <> 'OV' Then
  Begin
    strSQL := strSQL + '  FDO_CODEMP = :CODEMP AND '
  End
  Else
  Begin
    If fClienteFilial(edtCodCli.Text) Then
    Begin
      strSQL := strSQL + '  (FGO_EMP_TE = ' + QuotedStr(VS_strCodEmp) + ' OR FGO_EMP_TE IS NULL) AND '
    End
    Else
    Begin
      If (fCfgSis('OUTPED', varString)) = 'N' Then
      Begin
        strSQL := strSQL + ' IF(IFNULL(FGO_ENT_CD, "") = "S", FGO_EMP_CD, ';                                                  
        strSQL := strSQL + '   IF(IFNULL(FGO_EMP_TE, "") <> "", FGO_EMP_TE, FGO_CODEMP)) = ' + QuotedStr(VS_strCodEmp) + ' AND ';      
      End;
    End;
  End;

  strSQL := strSQL + '  FDO_JAFATU = FALSE   AND ';
  strSQL := strSQL + '  FDO_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  FDO_PROEMB <> "S"    AND ';
  strSQL := strSQL + '  FGO_DOCEND IS NULL   AND ';
  strSQL := strSQL + '  FDO_QTDBAI < FDO_QTDITE  AND ';
  strSQL := strSQL + '  IFNULL(E.FGO_LOC_PD, "N") <> "S"  ';

  If strEspecie = 'PD' Then
    strSQL := strSQL + ' AND FGO_LIBERA > 0    ';

  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  FDO_NUMDOC, FDO_ESPDOC   ';

  qryGenDor.Close;
  qryGenDor.SQL.Clear;
  qryGenDor.SQL.Add(strSQL);
  qryGenDor.ParamByName('CODCLI').AsString := edtCodCli.Text;

  If fatVenda.strOpcDoc <> 'OV' Then
    qryGenDor.ParamByName('CODEMP').AsString := VS_strCodEmp;

  qryGenDor.ParamByName('ESPDOC').AsString := strEspecie;
  qryGenDor.Open;

  pAtualizaTemporaria;

  Try
    fatVenda.qryTemporariaConfirmacao.DisableControls;

    If Assigned(pgbProgresso) Then
      pgbProgresso.Properties.Max := qryGenGor.RecordCount;

    While Not qryGenGor.Eof Do
    Begin
      qryGenDor.Filter := 'FDO_NUMDOC = ' + QuotedStr(qryGenGor.FieldByName('FGO_NUMDOC').AsString) + ' AND ' +
                          'FDO_ESPDOC = ' + QuotedStr(qryGenGor.FieldByName('FGO_ESPDOC').AsString) + ' AND ' +
                          'FDO_CODEMP = ' + QuotedStr(qryGenGor.FieldByName('FGO_CODEMP').AsString) + ' AND ' +
                          'FDO_CODCLI = ' + QuotedStr(qryGenGor.FieldByName('FGO_CODCLI').AsString);
      qryGenDor.Filtered := True;

      If (qryGenDor.IsEmpty) Then
      Begin
        qryGenDor.Filtered := False;
        qryGenDor.Filter   := '';
        qryGenGor.Next;
        Continue;
      End;

      fltVlrCon := 0.0;

      qryGenDor.First;
      While (Not qryGenDor.Eof) Do
      Begin
        fltVlrCon := fltVlrCon + qryGenDor.FieldByName('FDO_VLRTOT').AsFloat;
        qryGenDor.Next;
      End;

      intQtdIte := qryGenDor.RecordCount;

      qryGenDor.Filtered := False;
      qryGenDor.Filter   := '';

      If (strEspecie = 'OR') Or
         ((fCfgSis('LIBPED') <> 'S') Or ((fCfgSis('LIBPED') = 'S') And (qryGenGor.FieldByName('FGO_LIBERA').AsInteger > 0))) Then
      Begin
        fatVenda.qryTemporariaConfirmacao.Append;
        strNumDoc := qryGenGor.FieldByName('FGO_NUMDOC').AsString + IIF(qryGenGor.FieldByName('FGO_JAFATU').AsInteger = 1, 'q', '');

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DTAENT').AsDateTime := qryGenGor.FieldByName('FGO_DTAENT').AsDateTime;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_PREVIS').AsDateTime := qryGenGor.FieldByName('FGO_PREVIS').AsDateTime;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString   := strNumDoc;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString   := qryGenGor.FieldByName('FGO_ESPDOC').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString   := qryGenGor.FieldByName('FGO_CODEMP').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODVEN').AsString   := qryGenGor.FieldByName('FGO_CODVEN').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODVE2').AsString   := fRetVendedor2PedOrc(qryGenGor.FieldByName('FGO_AUTINC').AsString);
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_VLRCON').AsFloat    := fltVlrCon;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DESESP').AsFloat    := qryGenGor.FieldByName('FGO_DESESP').AsFloat;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_PORDES').AsFloat    := qryGenGor.FieldByName('FGO_PORDES').AsFloat;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ITEDOC').AsInteger  := intQtdIte;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DOCQUI').AsString   := IIF(qryGenGor.FieldByName('FGO_JAFATU').AsInteger = 1, 'S', 'N');
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString   := 'D';
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_LIBERA').AsString   := qryGenGor.FieldByName('FGO_LIBERA').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODFPG').AsString   := qryGenGor.FieldByName('FGO_CODFPG').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODCND').AsString   := qryGenGor.FieldByName('FGO_CODCND').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CONPAG').AsString   := qryGenGor.FieldByName('FGO_CONPAG').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODCLI').AsString   := qryGenGor.FieldByName('FGO_CODCLI').AsString;

        For intContador := 1 To 30 Do
        Begin
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODS' + fStrZero(intContador, 2)).AsString := qryGenGor.FieldByName('FGO_CODS' + fStrZero(intContador, 2)).AsString;
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DESS' + fStrZero(intContador, 2)).AsString := qryGenGor.FieldByName('FGO_DESS' + fStrZero(intContador, 2)).AsString;
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_IDES' + fStrZero(intContador, 2)).AsString := qryGenGor.FieldByName('FGO_IDES' + fStrZero(intContador, 2)).AsString;
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_QTDS' + fStrZero(intContador, 2)).AsFloat  := qryGenGor.FieldByName('FGO_QTDS' + fStrZero(intContador, 2)).AsFloat;
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_UNIS' + fStrZero(intContador, 2)).AsFloat  := qryGenGor.FieldByName('FGO_UNIS' + fStrZero(intContador, 2)).AsFloat;
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_VALS' + fStrZero(intContador, 2)).AsFloat  := qryGenGor.FieldByName('FGO_VALS' + fStrZero(intContador, 2)).AsFloat;
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DECS' + fStrZero(intContador, 2)).AsFloat  := qryGenGor.FieldByName('FGO_DECS' + fStrZero(intContador, 2)).AsFloat;
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_BRIS' + fStrZero(intContador, 2)).AsString := qryGenGor.FieldByName('FGO_BRIS' + fStrZero(intContador, 2)).AsString;
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_PARS' + fStrZero(intContador, 2)).AsString := qryGenGor.FieldByName('FGO_PARS' + fStrZero(intContador, 2)).AsString;
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_TBRS' + fStrZero(intContador, 2)).AsString := qryGenGor.FieldByName('FGO_TBRS' + fStrZero(intContador, 2)).AsString;
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_VENS' + fStrZero(intContador, 2)).AsString := qryGenGor.FieldByName('FGO_VENS' + fStrZero(intContador, 2)).AsString;
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_VE2S' + fStrZero(intContador, 2)).AsString := qryGenGor.FieldByName('FGO_VE2S' + fStrZero(intContador, 2)).AsString;
        End;

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_VENPRE').AsString   := IfEmptyStr(qryGenGor.FieldByName('FGO_VENPRE').AsString, 'N');
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_BENFUT').AsString   := qryGenGor.FieldByName('FDO_INCFUT').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_TIPOPE').AsString   := qryGenGor.FieldByName('FGO_TIPOPE').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_TIPPED').AsString   := qryGenGor.FieldByName('FGO_TIPPED').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_TEMSER').AsString   := IIF(fEmptyStr(qryGenGor.FieldByName('FGO_CODS01').AsString), 'N', 'S');
        fatVenda.qryTemporariaConfirmacao.FieldByName('FGO_NUMPOK').AsString   := qryGenGor.FieldByName('FGO_NUMPOK').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('FGO_PEDSIT').AsString   := qryGenGor.FieldByName('FGO_PEDSIT').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_INDCOM').AsString   := qryGenGor.FieldByName('FGO_INDCOM').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODPOR').AsString   := qryGenGor.FieldByName('FGO_CODPOR').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODFAZ').AsString   := qryGenGor.FieldByName('FGO_CODFAZ').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NOMTAB').AsString   := 'FATGOR';
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_AUTINC').AsString   := qryGenGor.FieldByName('FGO_AUTINC').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MENEXP').AsString   := qryGenGor.FieldByName('FGO_MENEXP').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MENEX2').AsString   := qryGenGor.FieldByName('FGO_MENEX2').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MENEX3').AsString   := qryGenGor.FieldByName('FGO_MENEX3').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MENEX4').AsString   := qryGenGor.FieldByName('FGO_MENEX4').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MEN001').AsString   := qryGenGor.FieldByName('FGO_MEN001').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MEN002').AsString   := qryGenGor.FieldByName('FGO_MEN002').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MEN003').AsString   := qryGenGor.FieldByName('AUX_MEN003').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MEN004').AsString   := qryGenGor.FieldByName('AUX_MEN004').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MEN005').AsString   := qryGenGor.FieldByName('AUX_MEN005').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DISSER').AsString   := qryGenGor.FieldByName('FGO_DISSER').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODTRA').AsString   := qryGenGor.FieldByName('FGO_CODTRA').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMB').AsString   := qryGenGor.FieldByName('FGO_CODEMB').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_TIPDOC').AsString   := qryGenGor.FieldByName('TMP_TIPDOC').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMOSE').AsString   := qryGenGor.FieldByName('TMP_NUMOSE').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_GARLOJ').AsString   := qryGenGor.FieldByName('TMP_GARLOJ').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ULTALT').AsString   := qryGenGor.FieldByName('FGO_ULTALT').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CONSUM').AsString   := qryGenGor.FieldByName('FGO_CONSUM').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_TPOPER').AsString   := qryGenGor.FieldByName('FGO_TPOPER').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_EMPPIX').AsString   := qryGenGor.FieldByName('FGO_EMPPIX').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_TX_PIX').AsString   := qryGenGor.FieldByName('FGO_TX_PIX').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_REGDES').AsString   := qryGenGor.FieldByName('FGO_REGDES').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_OPEEXP').AsString   := qryGenGor.FieldByName('FGO_OPEEXP').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_SEPEXP').AsString   := qryGenGor.FieldByName('FGO_SEPEXP').AsString;

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_PDGATE').AsString := 'N';
        If (fCfgSis('GARMAT', varString) = 'S') And (fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MEN001').AsString = 'GARANTIA(TE)') Then
          If (fCfgSis('EMPGAR', varString) <> fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString) Then
            fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_PDGATE').AsString := 'S';

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_STATUS_OS').AsString := qryGenGor.FieldByName('TMP_STATUS_OS').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_SUBSTA_OS').AsString := qryGenGor.FieldByName('TMP_SUBSTA_OS').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_SITUAC_OS').AsString := qryGenGor.FieldByName('TMP_SITUAC_OS').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CILVAS').AsString    := qryGenGor.FieldByName('FGO_CILVAS').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_AUTICV').AsString    := qryGenGor.FieldByName('FGO_AUTICV').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_FATSSA').AsString    := qryGenGor.FieldByName('FGO_FATSSA').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CDCOPO').AsInteger   := qryGenGor.FieldByName('FGO_CDCOPO').AsInteger;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CDCSTA').AsString    := qryGenGor.FieldByName('FGO_CDCSTA').AsString;

        fatVenda.qryTemporariaConfirmacao.Post;
      End;

      qryGenGor.Next;

      If Assigned(pgbProgresso) Then
        pStepStatusGravacao(pgbProgresso);
    End;
  Finally
    fatVenda.qryTemporariaConfirmacao.First;
    fatVenda.qryTemporariaConfirmacao.EnableControls;
  End;

  pCalculaTotais;

  If Not pnlItens.Visible Then
    fatVenda.qryTemporariaConfirmacao.AfterScroll := pAfterScrollDocumentos;

  FreeAndNil(qryGenDor);
  FreeAndNil(qryGenGor);

  Result := True;
end;

procedure TfrmFatConfPedidos.pDeletaTemporaria;
begin

  If (Not fTabelaExiste(fatVenda.strTabelaConfMi)) Then
    Exit;

  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM ' + fatVenda.strTabelaConfMi);
    ExecSQL;
    Close;
  End;

end;

procedure TfrmFatConfPedidos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  fatVenda.qryTemporariaConfirmacao.AfterScroll := nil;
end;

procedure TfrmFatConfPedidos.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma   := False;
  blnFecharForm := False;
  blnTemFinanc  := False;
  blnDeuErro    := False;
  blnPedFabOSG  := False;
  strTemAdt     := '';
  intQtdSer     := 0;
  strTemSer     := '';
  strSomSer     := '';
  UFEndEnt      := '';

  cdsItens := TZClient.Create(Self, fGetSqlItens(True));

  With cdsItens Do
  Begin
    If Not fAbreClient(True, 'TfrmFatConfPedidos.FormCreate') Then
    Begin
      blnDeuErro := True;
      Exit;
    End;
    TFloatField(FieldByName('ITE_QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    TFloatField(FieldByName('ITE_UNITAR')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
    TFloatField(FieldByName('ITE_TOTITE')).DisplayFormat := '#,##0.00';
  End;
  
  qryConCli     := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
end;

procedure TfrmFatConfPedidos.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text);
  edtNomCli.Text := qryConCli.FieldbyName('CLI_NOMCLI').AsString;
end;

procedure TfrmFatConfPedidos.edtCliFatKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCliFat, edtNomCliFat, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCliFat, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatConfPedidos.pMarcaDocumento(blnMarcar: Boolean);
  Var
    blnSomenteServ: Boolean;
    blnPossuiServ : Boolean;
    blnValidaServ : Boolean;
    blnPedTemAdto : Boolean;
    strPdGaTe     : String;
    strInformacao : String;
    intSerDoc     : Integer;
    strNumOs      : String;
    stlItensOS    : TStringList;
    arrMensagem   : TStringArray;
    intCont       : Integer;
    strEquip      : String;
    LstrDoc, LstrEsp, LstrEmp : string ;
    blnAfterScroll: Boolean;
    LUFEndEnt     : String;

    function EstadoEntregaPedidoOriginal : String;
    var LAutoIncremFatGor,
        LAuxEntGer,
        LCodCid,
        LUF : string;

    begin
      LAutoIncremFatGor := fCampoTabela('AUTOINCREM', 'FATGOR', ['FGO_CODEMP','FGO_NUMDOC','FGO_ESPDOC'], [fTemp('CODEMP').AsString,fTemp('NUMDOC').AsString,fTemp('ESPDOC').AsString], False);
      LAuxEntGer       := fCampoTabela('AUX_ENTGER', 'AUXGOR', ['AUX_SEQGER'], [LAutoIncremFatGor], False);
      if not fEmptyStr(LAuxEntGer) then
      begin
        LCodCid := fCampoTabela('ETC_CIDENT', 'ENTCLI', ['AUTOINCREM'], [LAuxEntGer], False);
        LUF     := fCampoTabela('CID_ESTADO', 'CADCID', ['CID_CODCID'], [LCodCid], False);
      end
      else
      begin
        LCodCid := fCampoTabela('CLI_CODCID', 'CADCLI', ['CLI_CODCLI'], [fTemp('CODCLI').AsString], False);
        LUF     := fCampoTabela('CID_ESTADO', 'CADCID', ['CID_CODCID'], [LCodCid], False);
      end;
      Result := LUF;
    end;


    function fTentandoMarcarPedidosComServicoMasVendedoresDifrerentes: String;
      Var
        qryAux: TUniQuery;
    begin
      qryAux := fCriaQuery(Nil);
      Try
        qryAux.SQL.Text := ' SELECT GROUP_CONCAT(CONCAT(" ", TMP_NUMDOC, " VEN.:", TMP_CODVEN)) FROM '+fatVenda.strTabelaConfMi
                          +' WHERE TMP_MARDES = "M" AND TMP_CODVEN <> "'+fTemp('CODVEN').AsString+'" '
                          +IIF((fTemp('TEMSER').AsString = 'S'), '', ' AND TMP_TEMSER = "S" ');
        qryAux.Open;
        Result := qryAux.Fields[0].AsString;
      Finally
        FreeAndNil(qryAux);
      End;
    end;

    function fValidaItemEspecial(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
    begin

      Result := False;

      If (Pos(strEspDoc, 'OR_PD_') > 0) And (Not fPermiteItemEspecial('VN')) Then
      Begin

        Result := fncExecutaRelatorio(201, 7578, [],
                          ['NUMDOC','ESPDOC','CODEMP'],
                          [strNumDoc,
                          strEspDoc,
                          strCodEmp],
                          nil,
                          nil,
                          True,
                          False);

        if Result then
        Begin
          fMensagem('', 'Existem Itens Especiais no Orçamento/Pedido. Verifique!', ['&O k']);
        End;

        pnlInfo.Caption := '';

      End;

    End;

begin
  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    blnPossuiServ := False;

    blnPedTemAdto := TAdiantamento.fGetTotaisAdiantamento(fTemp('NUMDOC').AsString,
                                                          fTemp('ESPDOC').AsString,
                                                          fTemp('CODEMP').AsString).fltValLan > 0;

    If (blnMarcar) And (Not fPermiteMarcarPedido(fTemp('NUMDOC').AsString,
                                                 fTemp('ESPDOC').AsString,
                                                 fTemp('CODEMP').AsString,
                                                 blnPedTemAdto,
                                                 fTemp('CODCLI').AsString)) Then
      Exit;
    If blnMarcar And Not fEmptyStr(strTemAdt) Then
    Begin
      If (strTemAdt = 'N') And blnPedTemAdto Then
      Begin
        pMensagemOk('Não é permitido selecionar pedidos com adiantamento com pedidos sem adiantamento!');
        Exit;
      End
      Else If (strTemAdt = 'S') And Not blnPedTemAdto Then
      Begin
        pMensagemOk('Não é permitido selecionar pedidos sem adiantamento com pedidos com adiantamento!');
        Exit;
      End
      Else If (strTemAdt = 'S') And blnPedTemAdto Then
      Begin
        pMensagemOk('Não é permitido selecionar mais de um pedido com adiantamento!');
        Exit;
      End;
    End;

    If blnMarcar Then
    Begin
      If StrToIntDef(edtQtdDocSel.Text, 0) <= 0 Then
        UFEndEnt := EstadoEntregaPedidoOriginal
      Else
      Begin
        LUFEndEnt := EstadoEntregaPedidoOriginal;
        If UFEndEnt <> LUFEndEnt Then
        Begin
          fMensagem('ATENÇÃO!', 'Já foi selecionado pedido(s) com endereço de entrega do estado ' + ''''+UFEndEnt+'''' + ', portanto só poderão ser selecionados pedidos que o endereço de entrega pertençam ao estado de ' + ''''+UFEndEnt+'''.'+ #10#13 +
                                'Estado do endereço de entrega do pedido selecionado ' + '''' + LUFEndEnt + '''' +  '!', ['&Ok']);
          Exit;
        End;
      End;

      If fPedidoBaixaEntregaFutura(fTemp('NUMDOC').AsString,
                                   fTemp('ESPDOC').AsString,
                                   fTemp('CODEMP').AsString) Then
      Begin
        pMensagemOk('Pedidos de Baixa de Entrega Futura devem ser faturados pela rotina de Expedição!');
        Exit;
      End;

      If fItemPendenteSeparacaoAutoCenter(fTemp('CODEMP').AsString, fTemp('NUMDOC').AsString, fTemp('ESPDOC').AsString) Then
      Begin
        pMensagemOk('Existem produtos pendentes na Expedição de Serviço que precisam ser regularizados. '
                  + 'O pedido não poderá ser faturado com esta pendência. '
                  + 'Entre em contato com o setor responsável!');
        Exit;
      End;

      If fServicoPendenteAutoCenter(fTemp('CODEMP').AsString, fTemp('NUMDOC').AsString, fTemp('ESPDOC').AsString) Then
      Begin
        pMensagemOk('Existem serviços não finalizados no Acompanhamento de Serviços. '
                  + 'O pedido não poderá ser faturado com esta pendência. '
                  + 'Entre em contato com o setor responsável!');
        Exit;
      End;

      if (Not fCfgSis('FTPDOS', varBoolean)) then
      Begin
        if (Not fOSFinalizada(fTemp('NUMDOC').AsString,
                              fTemp('ESPDOC').AsString,
                              fTemp('CODEMP').AsString,
                              strNumOs)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este Pedido de Venda é oriundo da Ordem de Serviço ' + strNumOs + #13 +
                                'e a mesma ainda não foi finalizada. Procure o responsável' + #13 +
                                'pela rotina de Conserto de Equipamentos para realizar' + #13 +
                                'este procedimento e liberar o faturamento deste Pedido.', ['&O k']);
          Exit;
        End;
      End;

      if (not fOSFinalizadaArmazenada(fTemp('NUMDOC').AsString,
                                      fTemp('ESPDOC').AsString,
                                      fTemp('CODEMP').AsString,
                                      strNumOs, strEquip)) then
      begin
        fMensagem('ATENÇÃO!', 'Este pedido de venda é oriundo de Conserto de Equipamento através da Ordem de Serviço ' + strNumOs + '.' + #13 +
                              'Para permitir seu faturamento, é necessário que o Armazenamento do Equipamento tenha ' +
                              'sido realizado e esteja pronto pra ser retirado, porém isso ainda não ocorreu.' + #13 +
                              'Entre em contato com o departamento de Assitência Técnica para solicitar que isso seja feito.' + #13 +
                              'Equipamento: ' + strEquip, ['&OK'], 1, False, 1, 0, False, 0, False, False, False, 230, 560);
        Exit;
      end;

      stlItensOS := TStringList.Create;

      try
        if (fatVenda.strOpcDoc = 'OV')
          and (fOSItensNaoReservados(fTemp('NUMDOC').AsString,
                                     fTemp('ESPDOC').AsString,
                                     fTemp('CODEMP').AsString,
                                     '',
                                     strNumOs,
                                     stlItensOS)) then
        begin
          SetLength(arrMensagem, 0);

          pAddDados(arrMensagem, fPadR('-', 58, '-'));
          pAddDados(arrMensagem, fPadR('|Cód.Item|Descrição', 57) + '|');
          pAddDados(arrMensagem, fPadR('-', 58, '-'));

          for intCont := 0 to Pred(stlItensOS.Count) do
          begin
            pAddDados(arrMensagem, '|' + fPadR(Copy(stlItensOS[intCont], 1, 56), 56) + '|');
          end;

          fMensagemTabela('ATENÇÃO!',
                          'Produtos',
                          arrMensagem,
                          'Não é permitido faturar o pedido ' + fTemp('NUMDOC').AsString + '-PD-' + fTemp('CODEMP').AsString +
                            ' pois ele possui produtos que não estão reservando estoque (OS).' + #13 + #13 +
                            'OS: ' + strNumOs + #13 +
                            'Acesse a rotina "Liberação de Reserva de Estoque Itens de Pedido de Venda - OS", ' +
                            'realize a liberação da reserva do estoque e depois, tente novamente.',
                          ['&Ok'],
                          1,
                          False,
                          1,
                          0,
                          False,
                          0,
                          False,
                          False,
                          False,
                          400,
                          100);

          Exit;
        end;
      finally
        FreeAndNil(stlItensOS);
      end;

      If TAdiantamentoGenerico.fRetornaValorBoletosAdiantamento(
                            fTemp('NUMDOC').AsString,
                            fTemp('ESPDOC').AsString,
                            fTemp('CODEMP').AsString,
                            fTemp('CODCLI').AsString) > 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse pedido possui ' +
                              'boleto de adiantamento '+
                              'que ainda não foi baixado pela '+
                              'remessa bancária.' + #13#10 +
                              'Utilizar rotina de Expedição para Faturar o mesmo!', ['&OK']);
        Exit;
      End;

      If fEhPedidoOriginadoPelaConsignacao(fTemp('NUMDOC').AsString, fTemp('ESPDOC').AsString, fTemp('CODEMP').AsString) Then
      Begin
        fMensagem('ATENÇÃO!', 'Pedido criado a partir da rotina de envio de consignação. '+
        'Utilizar rotina de Expedição para Faturar o mesmo!', ['&OK']);
        Exit;
      End;

      If MatchStr(TPixDao.RetornaStatusSePedidoPossuirPix(fTemp('EMPPIX').AsString,
                                                          fTemp('TX_PIX').AsString), STATUS_PIX_ATIVO) Then
      Begin
        fMensagem('ATENÇÃO!', 'Pedido possui um registro de Pix ativo. ' +
                  'Deve ser realizado o pagamento do Pix ou alterar a condição de pagamento para confirmá-lo!', ['&OK']);
        Exit;
      End;

      If MatchStr(TPixDao.RetornaStatusSePedidoPossuirPix(fTemp('EMPPIX').AsString,
                                                          fTemp('TX_PIX').AsString), STATUS_PIX_PAGO) Then
      Begin
        If TAdiantamento.AdiantamentoRealizadoPorPixDeFormaParcial(fatVenda.qryTemporariaConfirmacao) Then
          Exit;
      End;

      If fCfgSis('PEDUCO', varBoolean) Then
      Begin
        If SameText(fTemp('TIPOPE').AsString, 'U') Then
        Begin
          fMensagem('ATENÇÃO!', 'Pedidos de Tipo de Operação: U - Uso e Consumo, devem ser faturados pela rotina de Expedição!', ['&Ok']);
          Exit;
        End;
      End;

    End;

    intSerDoc := 0;

    If fCfgSis('USASER', varBoolean) Then
      intSerDoc := fQtdServicos(fTemp('NUMDOC').AsString,
                                fTemp('ESPDOC').AsString,
                                fTemp('CODEMP').AsString);

    If fCfgSis('USASER', varBoolean) And (fCfgSis('TIPNFS') = '2') Then
    Begin
      blnValidaServ := True;
      strTemSer     := fatVenda.fRetServDocMarcados;
      blnPossuiServ := fDocumentoPossuiServicos(fTemp('NUMDOC').AsString,
                                                fTemp('ESPDOC').AsString,
                                                fTemp('CODEMP').AsString,
                                                blnSomenteServ, True);
    End
    Else
    Begin
      fDocumentoPossuiServicos(fTemp('NUMDOC').AsString,
                               fTemp('ESPDOC').AsString,
                               fTemp('CODEMP').AsString,
                               blnSomenteServ, True);

      If (blnSomenteServ) Then
        strSomSer := strSomSer + 'S'
      Else
        strSomSer := strSomSer + 'N';

      strTemSer     := '';
      blnValidaServ := False;
    End;

    If blnMarcar And fCfgSis('INDCOM', varBoolean) Then
    Begin
      strIndCom := fCampoTabela('DISTINCT(TMP_INDCOM)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);

      If (Not fEmptyStr(strIndCom)) And (strIndCom <> fTemp('INDCOM').AsString) Then
      Begin
        If strIndCom = 'S' Then
          fMensagem('','Não é possível selecionar um pedido de Industrialização. ' + #13#10 +
                       'Já foram selecionados pedidos de Comercialização!', ['&Ok'])
        Else
          fMensagem('','Não é possível selecionar um pedido de Comercialização. ' + #13#10 +
                       'Já foram selecionados pedidos de Industrialização!', ['&Ok']);
        Exit;
      End;

    End;

    If blnMarcar And fCfgSis('USOREV', varBoolean) Then
    Begin
      strCliCon := fCampoTabela('DISTINCT(TMP_CONSUM)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);
      strTpOper := fCampoTabela('DISTINCT(TMP_TPOPER)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);

      If (Not fEmptyStr(strCliCon)) And (strCliCon <> fTemp('CONSUM').AsString) Then
      Begin
        If (strCliCon = 'S') Then
          fMensagem('','Não é possível selecionar um pedido gravado como Revenda.' + #13#10 +
                       'Já foram selecionados pedidos gravados como Uso/Consumo!', ['&Ok'])
        Else
          fMensagem('','Não é possível selecionar um pedido gravado como Uso/Consumo.' + #13#10 +
                       'Já foram selecionados pedidos gravados como Revenda!', ['&Ok']);
        Exit;
      End;

      If (Not fEmptyStr(strTpOper)) And (strTpOper <> fTemp('TPOPER').AsString) Then
      Begin
        fMensagem('','Não é possível selecionar um pedido com tipo de operação diferentes.' + #13#10 +
                     'USO/CONSUMO, REVENDA e INDUSTRIALIZAÇÃO!', ['&Ok']);
        Exit;
      End;
    End;

    If (blnMarcar) Then
    Begin
      strPdGaTe := fCampoTabela('DISTINCT(TMP_PDGATE)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);
      If (strPdGaTe = 'S') And (fTemp('PDGATE').AsString = 'N') Then
      Begin
        fMensagem('Atenção','Não é permitido selecionar pedido de Garantia de Transferência com pedido Convencional' + #13#10 +
                            'Já selecionado (Pedido de Garantia de Transferência)!', ['&Ok']);
        Exit;
      End
      Else If (fTemp('PDGATE').AsString = 'S') And (strPdGaTe = 'N') Then
      Begin
        fMensagem('Atenção','Não é permitido selecionar pedido de Garantia de Transferência com pedido Convencional' + #13#10 +
                            'Já selecionado (Pedido Normal)!', ['&Ok']);
        Exit;
      End
    End;

    If (blnMarcar) And (fTemp('TIPOPE').AsString = 'B') And
       (fatVenda.fTravaDocumentoBonificado(fTemp('NUMDOC').AsString,
                                           fTemp('ESPDOC').AsString,
                                           fTemp('CODEMP').AsString)) Then
      Exit;

    If blnMarcar And fCfgSis('PORPED', varBoolean) Then
    Begin
      strCodPor := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_CODPOR)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);

      If (Not fEmptyStr(strCodPor)) And (strCodPor <> fTemp('CODPOR').AsString) Then
      Begin
        fMensagem('','Portadores diferentes, não será possível selecionar este pedido de venda!' + #13#10 +
                     'Já selecionado: (' + strCodPor + ')' + #13#10 +
                     'Selecionando: (' + fTemp('CODPOR').AsString + ')', ['&Ok']);
        Exit;
      End;

    End;

    If blnMarcar And fCfgSis('CADFAZ', varBoolean) And (strToIntDef(edtQtdDocSel.Text, 0) > 0) Then
    Begin
      strCodFaz := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_CODFAZ)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);

      If strCodFaz <> fTemp('CODFAZ').AsString Then
      Begin
        fMensagem('','Não é possível selecionar pedidos de Fazendas diferentes. ' + #13#10 +
                     'Já selecionado: (' + strCodFaz + ')' + #13#10 +
                     'Selecionando: (' + fTemp('CODFAZ').AsString + ')', ['&Ok']);
        Exit;
      End;
    End;

    If blnMarcar And fCfgSis('CADEMB', varBoolean) And (strToIntDef(edtQtdDocSel.Text, 0) > 0) Then
    Begin
      strCodEmb := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_CODEMB)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);

      If (Pos(fTemp('CODEMB').AsString, strCodEmb) <= 0)  Then
      Begin
        If not (fEmptyStr(strCodEmb) And fEmptyStr(fTemp('CODEMB').AsString)) Then
        Begin
          fMensagem('','Não é possível selecionar pedidos de Embarcações diferentes. ' + #13#10 +
                       'Já selecionado: (' + fRedCodEmb(AnsiReplaceStr(strCodEmb, ',', '')) + ')' + #13#10 +
                       'Selecionando: (' +   fRedCodEmb(fTemp('CODEMB').AsString) + ')', ['&Ok']);
          Exit;
        End;
      End;
    End;

    If (Not fatVenda.blnAgrupamentoPedidos) And blnMarcar Then
    Begin
      If (fCfgSis('TREXCP') = 'N' {Não permitir}) Then
        If Not fResolveTransportadorCondicao('CODTRA', False) Then
          Exit;

      If (fCfgSis('CNDICP') = 'N' {Não permitir}) Then
      Begin
        If Not fResolveTransportadorCondicao('CONPAG', False) Then
          Exit;

        If Not fResolveTransportadorCondicao('CODFPG', False) Then
          Exit;
      End;
    End;

    If (blnMarcar) And ((fCfgSis('TREXCP') = 'S' {Pedir senha}) Or (fatVenda.blnAgrupamentoPedidos)) Then
    Begin
      If Not fResolveTransportadorCondicao('CODTRA') Then
        Exit;
    End;

    If (blnMarcar) And ((fCfgSis('CNDICP') = 'S' {Pedir senha}) Or (fatVenda.blnAgrupamentoPedidos)) Then
    Begin
      If Not fResolveTransportadorCondicao('CONPAG') Then
        Exit;

      If Not fResolveTransportadorCondicao('CODFPG') Then
        Exit;
    End;

    if (blnMarcar) and (not fPermiteMarcarPDOSGarantiaLoja(fTemp('GARLOJ').AsString)) then
    begin
      fMensagem('ATENÇÃO!', 'Configurado para realizar a baixa automática do Contas a Receber do financeiro de Ordem de Serviço - Garantia Loja - [CFG_OSGLC]. ' +
                            'Não é permitido selecionar Pedido desta situção com outros Pedidos!', ['&Ok']);
      Exit;
    end;

    If (blnMarcar) And (fExisteDocumentoContaOrdemComRemessaNaoFaturada(fTemp('AUTINC').AsString)) Then
      Exit;

    If blnMarcar Then
    Begin
      strVenPre := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_VENPRE)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);

      If (Not fEmptyStr(strVenPre)) And (strVenPre <> (fTemp('VENPRE').AsString)) Then
      Begin
        fMensagem('','Existem pedidos com venda presencial e outros não, por isso não será possível selecionar este pedido de venda!', ['&Ok']);
        Exit;
      End;

      strBEnFut :=  fCampoTabela('GROUP_CONCAT(DISTINCT TMP_BENFUT)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);

      If (Not fEmptyStr(strBEnFut)) And (strBEnFut <> (fTemp('BENFUT').AsString)) Then
      Begin
        fMensagem('','Existem pedidos com baixa de entrega futura e outros não, por isso não será possível selecionar este pedido de venda!', ['&OK']);
        Exit;
      End;

      If fCfgSis('USASER', varBoolean) Then
      Begin
        If (Not fEmptyStr(fTentandoMarcarPedidosComServicoMasVendedoresDifrerentes)) And (Not fCfgSis('VNDSPD', varBoolean)) Then
        Begin
          fMensagem('','O documento: '+IIF((fTemp('TEMSER').AsString = 'S'), 'com serviço ', '')+
                        fTemp('NUMDOC').AsString+' VEN.:'+fTemp('CODVEN').AsString+' não pode ser confirmardo juntamente com os já selecionados documentos'+IIF((fTemp('TEMSER').AsString = 'S'), ' ', ' com serviço ')+'de outros vendedores:'+
                        fTentandoMarcarPedidosComServicoMasVendedoresDifrerentes, ['&OK']);
          Exit;
        End;

        If ((intQtdSer + intSerDoc) > fCfgSis('LINSER',varInteger)) and (not chkPedOSG.Checked) Then
        Begin
          fMensagem('ATENÇÃO!', 'A quantidade de serviços selecionados ultrapassou o limite permitido!', ['&Ok']);
          Exit;
        End
        Else
          intQtdSer := intQtdSer + intSerDoc;
      End;

      If (fCfgSis('TPDCEX', varString) = '1') And (Pos(VS_strTipExp, '3_4_5_') > 0) And (fatVenda.blnAgrupamentoPedidos) Then
      Begin
        strTipPed := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_TIPPED)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);

        If (Not fEmptyStr(strTipPed)) And (strTipPed <> fTemp('TIPPED').AsString) Then
        Begin
          fMensagem('','Tipos de faturamentos diferentes, não será possível selecionar este pedido!' + #13#10 +
                       'Já selecionado: (' + strTipPed + ')' + #13#10 +
                       'Selecionando: (' + fTemp('TIPPED').AsString + ')', ['&Ok']);
          Exit;
        End;
      End;

      strTipOpe := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_TIPOPE)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);

      If (Not fEmptyStr(strTipOpe)) And (strTipOpe <> fTemp('TIPOPE').AsString) Then
      Begin
        fMensagem('','Tipos de operações diferentes, não será possível selecionar este pedido!' + #13#10 +
                     'Já selecionado: (' + strTipOpe + ')' + #13#10 +
                     'Selecionando: (' + fTemp('TIPOPE').AsString + ')', ['&Ok']);
        Exit;
      End;

      If fAlgumaEmpresaUtilizaRegimeEspecial Then
      Begin
        strRegDes := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_REGDES)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);

        If (Not fEmptyStr(strRegDes)) And (strRegDes <> fTemp('REGDES').AsString) Then
        Begin
          fMensagem('','Não é possível selecionar pedidos com Desmembramento de Regime Especial diferentes!' + sLineBreak +
                       'Já selecionado: (' + strRegDes + ')' + sLineBreak +
                       'Selecionando: (' + fTemp('REGDES').AsString + ')', ['&Ok']);
          Exit;
        End;
      End;

      If fCfgSis('FATSSA', varBoolean) Then
      Begin
        strFatSsa := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_FATSSA)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);

        If (Not fEmptyStr(strFatSsa)) And (strFatSsa <> fTemp('FATSSA').AsString) Then
        Begin
          fMensagem('','Não é possível selecionar pedidos com Empresa de Faturamento sem Estoque diferentes!' + sLineBreak +
                       'Já selecionado: (' + strFatSsa + ')' + sLineBreak +
                       'Selecionando: (' + fTemp('FATSSA').AsString + ')', ['&Ok']);
          Exit;
        End;
      End;

      If (VS_strTipExp = '4') And (fCfgSis('CAPSCI', VarString) = 'S') Then
      Begin
        strOpeExp := fCampoTabela('DISTINCT(TMP_OPEEXP)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);
        If (Not fEmptyStr(strOpeExp)) And (strOpeExp <> fTemp('OPEEXP').AsString) Then
        Begin
          pMensagemOK('Este pedido tem Conferente: ' + fTemp('OPEEXP').AsString + ' diferente do Conferente: ' + strOpeExp + ' dos pedidos selecionados e sendo ' +
                      'assim não podem ser selecionado junto porque impacta diretamente nos relatórios de separação e conferência. Existe uma configuração ' +
                      'para isso: CFG_CAPSCI.');
          Exit;
        End;

        strSepExp := fCampoTabela('DISTINCT(TMP_SEPEXP)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);
        If (Not fEmptyStr(strSepExp)) And (strSepExp <> fTemp('SEPEXP').AsString) Then
        Begin
          pMensagemOK('Este pedido tem Separador: ' + fTemp('SEPEXP').AsString + ' diferente do Separador: ' + strSepExp + ' dos pedidos selecionados e sendo ' +
                      'assim não podem ser selecionado junto porque impacta diretamente nos relatórios de separação e conferência. Existe uma configuração ' +
                      'para isso: CFG_CAPSCI.');
          Exit;
        End;
      End;

      {***************************************************************************************}
      {* UTILIZA A DATA DA EMISSÃO DO PEDIDO COMO BASE PARA CALCULO DA CONDIÇÃO DE PAGAMENTO *}
      {************************************************************************************PZ*}
      LstrDoc := fTemp('NUMDOC').AsString ;
      LstrEsp := fTemp('ESPDOC').AsString ;
      LstrEmp := fTemp('CODEMP').AsString ;
      If fUtilizarComoDataBaseCtrDataEmissaoPedido(True, fatVenda.fUtilizarDataEmissaoCalcularDiaVencimento(LstrDoc, LstrEsp, LstrEmp)) Then
      Begin
        {**********************************************************************************************}
        {* CASO O PEDIDO ESTEJA SENDO FATURADO ANTECIPADAMENTE À DATA DE PREVISÃO, UTILIZAR ESSA DATA *}
        {*******************************************************************************************KM*}
        If (fUtilizarComoDataBaseCtrDataPrevisaoPedido(True)) Then
        Begin
          strPrevSel := fCampoTabela('DISTINCT TMP_PREVIS', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);

          If (Not fEmptyStr(strPrevSel)) Then
          Begin
            strPrevSel := formatDateTime('DD/MM/YYYY', strToDateDef(strPrevSel, 0));
            If (strPrevSel = '30/12/1899') Then
              strPrevSel := '';
          End;

          If (Not fEmptyDate(strPrevSel)) And
             (strToDateDef(strPrevSel, 0) <> fTemp('PREVIS').AsDateTime) Then
          Begin
            fMensagem('ATENÇÃO!','Não é permitido selecionar dois pedidos com datas de previsões diferentes, pois o sistema está configurado para utilizar esta data para calcular os vencimentos das duplicatas (CFG_CNDPRV)!' + #13#10 +
                      'Já selecionado: (' + formatDateTime('DD/MM/YYYY', strToDateDef(strPrevSel, 0)) + ')' + #13#10 +
                      'Selecionando: (' + formatDateTime('DD/MM/YYYY', fTemp('PREVIS').AsDateTime) + ')', ['&Ok']);
            Exit;
          End;
        End
        Else
        Begin
          strEmiSel := fCampoTabela('DISTINCT TMP_DTAENT', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);

          If (Not fEmptyStr(strEmiSel)) Then
          Begin
            strEmiSel := formatDateTime('DD/MM/YYYY', strToDateDef(strEmiSel, 0));
            If (strEmiSel = '30/12/1899') Then
              strEmiSel := '';
          End;

          If (Not fEmptyDate(strEmiSel))                                And
             (strToDateDef(strEmiSel, 0) <> fTemp('DTAENT').AsDateTime) Then
          Begin
            fMensagem('ATENÇÃO!','Não é permitido selecionar dois pedidos com datas de emissões diferentes, pois o sistema está configurado para utilizar esta data para calcular os vencimentos das duplicatas (CFG_DTPDCR)!' + #13#10 +
                      'Já selecionado: (' + formatDateTime('DD/MM/YYYY', strToDateDef(strEmiSel, 0)) + ')' + #13#10 +
                      'Selecionando: (' + formatDateTime('DD/MM/YYYY', fTemp('DTAENT').AsDateTime) + ')', ['&Ok']);
            Exit;
          End;
        End;
      End;

      {**************************************************************}
      {* NÃO PERMITIR SELECIONAR PEDIDOS COM O FGO_PORDES DIFERENTE *}
      {* PARA QUE O CALCULO FIQUE CORRETO AO CONFIRMAR OS PEDIDOS.  *}
      {* CASO ALTERAR ESTA REGRA, ATENÇÃO PARA O CALCULO DO JUROS.  *}
      {**********************************************************PZ**}
      If (fstrToFloat(edtQtdDocSel.Text) > 0) Then
      Begin
        fltPorDes := fatVenda.fRetPorDesDocMarcados;

        If  (fltPorDes <> fTemp('PORDES').AsFloat) Then
        Begin
          fMensagem('','Percentual de Desconto diferentes, não será possível selecionar este pedido!' + #13#10 +
                       'Já selecionado: (' + FormatFloat('#,##0.00', fltPorDes) + ')' + #13#10 +
                       'Selecionando: (' + FormatFloat('#,##0.00', fTemp('PORDES').AsFloat) + ')', ['&Ok']);
          Exit;
        End;
      End;

      If fDocumentoPossuiItemConcreto(fTemp('NUMDOC').AsString,
                                      fTemp('ESPDOC').AsString,
                                      fTemp('CODEMP').AsString) Then
      Begin
        fMensagem('ATENÇÃO!', 'Este documento possui itens concreto, ' +
                              'somente é permitido faturar o mesmo pela Venda Normal!', ['&Ok']);
        Exit;
      End;

      If fCfgSis('USAFPG', varBoolean) Then
      Begin

        If blnTemFinanc Then
        Begin
          fMensagem('ATENÇÃO!', 'Já foi selecionado um pedido com Financiamento. Não é permitido selecionar mais pedidos!', ['&Ok']);
          Exit;
        End;

        If (StrToIntDef(edtQtdDocSel.Text, 0) > 0) And
           SameText(fTemp('CODFPG').AsString, '016') Then
        Begin
          fMensagem('ATENÇÃO!', 'Pedidos com Financiamento não podem ser confirmados com outros pedidos!', ['&Ok']);
          Exit;
        End;

        blnTemFinanc := SameText(fTemp('CODFPG').AsString, '016');
      End;

      If fCfgSis('EMPFAT', varBoolean) Then
      Begin
        If fEhPedOrcMultiloja(fTemp('NUMDOC').AsString,
                              fTemp('ESPDOC').AsString,
                              fTemp('CODEMP').AsString) Then
        Begin
          fMensagem('ATENÇÃO!', 'Pedido Multiloja. Desmembre-o antes de faturar!', ['&Ok']);
          Exit;
        End;
      End;

      If fTemp('ESPDOC').AsString.Equals('PD') And (Not fPermiteFaturamentoPedidoComItemEstruturaSemOrdemProducao(fTemp('NUMDOC').AsString, fTemp('CODEMP').AsString)) Then
        Exit;

      If fValidaItemEspecial(fTemp('NUMDOC').AsString, fTemp('ESPDOC').AsString, fTemp('CODEMP').AsString) Then
      Begin

        Exit;

      End
      Else If blnValidaServ And blnPossuiServ And (Not blnSomenteServ) Then
      Begin

        fMensagem('','O documento possui produtos e serviços, portanto não é possível selecionar o mesmo!', ['&OK']);

      End
      Else If blnValidaServ And (Not fEmptyStr(strTemSer)) And (fTemp('TEMSER').AsString <> strTemSer) Then
      Begin

        If strTemSer = 'S' Then
          fMensagem('','Já existem documentos selecionados com serviços, portanto não é possível selecionar documento com produtos!', ['&OK'])
        Else
          fMensagem('','Já existem documentos selecionados com produtos, portanto não é possível selecionar documento com serviços!', ['&OK']);

      End
      {***************************************************}
      {* SE O TIPO DE EXPEDIÇÃO FOR POR PEDIDO(OPÇÃO 4)  *}
      {* E O PEDIDO NÃO FOI EXPEDIDO, NÃO DEIXA FATURAR. *}
      {************************************************PZ*}
      Else If (VS_strTipExp = '4') And
              (fTemp('TIPOPE').AsString <> 'R') And
              (Not fPedidoFoiExpedido(fTemp('NUMDOC').AsString,
                                      fTemp('CODEMP').AsString,
                                      fTemp('CODCLI').AsString)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O pedido deve ser expedido antes de faturar!', ['&O k']);
      End

      Else If fatVenda.fUltrapassouLimiteItensNFe(intItensDocs + fTemp('ITEDOC').AsInteger, '', strInformacao) Then
      Begin
        pMensagemSonora(strInformacao);
      End

      Else If (Not fPermiteProducaoForaDeLoja(fTemp('NUMDOC').AsString,
                                              fTemp('CODEMP').AsString,
                                              fTemp('CODCLI').AsString)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Na confirmação de pedidos poderão ser selecionados : ' + #13#10 +
                              'Pedidos de Produção Fora de Loja ou Pedidos Sem Produção fora de loja.', ['&O k']);
      End

      Else If (fatVenda.strOpcDoc <> 'OV') Or
              fTrataSaldo(fTemp('NUMDOC').AsString, fTemp('ESPDOC').AsString, fTemp('CODEMP').AsString) Then
      Begin

        blnAfterScroll := Assigned(fatVenda.qryTemporariaConfirmacao.AfterScroll);
        fatVenda.qryTemporariaConfirmacao.AfterScroll := Nil;

        Edit;
        fTemp('MARDES').AsString := 'M';
        Post;

        If blnAfterScroll Then
        Begin
          pAfterScroll(fatVenda.qryTemporariaConfirmacao);
          fatVenda.qryTemporariaConfirmacao.AfterScroll := pAfterScroll;
        End;

        If blnValidaServ And fEmptyStr(strTemSer) Then
          strTemSer := fTemp('TEMSER').AsString;

        strTemAdt  := IIF(blnPedTemAdto, 'S', 'N');
        strIndCom  := fCampoTabela('DISTINCT(TMP_INDCOM)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);
        strCliCon  := fCampoTabela('DISTINCT(TMP_CONSUM)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);
        strTpOper  := fCampoTabela('DISTINCT(TMP_TPOPER)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);
        strCodPor  := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_CODPOR)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);
        strCodFaz  := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_CODFAZ)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);
        strTipOpe  := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_TIPOPE)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);
        strVenPre  := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_VENPRE)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);
        strBEnFut  := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_BENFUT)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);
        strEmiSel  := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_DTAENT)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);
        strPrevSel := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_PREVIS)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);
        strCodEmb := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_CODEMB)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);
        strOpeExp := fCampoTabela('GROUP_CONCAT(DISTINCT IF(TMP_OPEEXP = "", NULL, TMP_OPEEXP))', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);
        strSepExp := fCampoTabela('GROUP_CONCAT(DISTINCT IF(TMP_SEPEXP = "", NULL, TMP_SEPEXP))', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);
      End;

      If (fatVenda.blnAgrupamentoPedidos) And (Not fValidarAbastecimentoDeposito()) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é possível agrupar pedidos que são de abastecimento ' +
                              'por depósito com pedidos que não são de abastecimento por depósito.', ['&Ok']);
        Exit;
      End

    End
    Else
    Begin
      If fCfgSis('USASER', varBoolean) Then
        intQtdSer := intQtdSer - intSerDoc;

      blnAfterScroll := Assigned(fatVenda.qryTemporariaConfirmacao.AfterScroll);
      fatVenda.qryTemporariaConfirmacao.AfterScroll := Nil;

      Edit;
      fTemp('MARDES').AsString := 'D';
      Post;

      If blnAfterScroll Then
      Begin
        pAfterScroll(fatVenda.qryTemporariaConfirmacao);
        fatVenda.qryTemporariaConfirmacao.AfterScroll := pAfterScroll;
      End;

      blnTemFinanc := False;
    End;

    If SameText(fTemp('MARDES').AsString, 'M') Then
    Begin
      If Not fatVenda.objLock.fLock_Unlock('FATGOR' +
                                     fTemp('NUMDOC').AsString +
                                     fTemp('ESPDOC').AsString +
                                     fTemp('CODEMP').AsString, True, False) Then
      Begin
        Screen.Cursor := crDefault;

        fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' +
                      fGetHostLock('FATGOR' + fTemp('NUMDOC').AsString + fTemp('ESPDOC').AsString + fTemp('CODEMP').AsString)  + '!', ['&Ok']);
        Exit;
      End;

      If Not fatVenda.objLock.fLock_Unlock('CADREC' +
                                     fTemp('NUMDOC').AsString +
                                     fTemp('ESPDOC').AsString +
                                     fTemp('CODEMP').AsString +
                                     fTemp('CODCLI').AsString, True, False) Then
      Begin
        Screen.Cursor := crDefault;

        fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' +
                      fGetHostLock('CADREC' + fTemp('NUMDOC').AsString + fTemp('ESPDOC').AsString + fTemp('CODEMP').AsString + fTemp('CODCLI').AsString)  + '!', ['&Ok']);
        Exit;
      End;
    End
    Else
    Begin
      fatVenda.objLock.fLock_Unlock( 'FATGOR' +
                               fTemp('NUMDOC').AsString +
                               fTemp('ESPDOC').AsString +
                               fTemp('CODEMP').AsString, False, False );

      fatVenda.objLock.fLock_Unlock( 'CADREC' +
                               fTemp('NUMDOC').AsString +
                               fTemp('ESPDOC').AsString +
                               fTemp('CODEMP').AsString +
                               fTemp('CODCLI').AsString, False, False );
    End;

  End;

  pCalculaTotais;

  If StrToIntDef(edtQtdDocSel.Text, 0) = 0 Then
    strTemAdt := '';
end;

procedure TfrmFatConfPedidos.pPegaDoctoComProfis;
  Var
    strValor: String;
    intRecNo: Integer;
    blnAfterScroll: Boolean;

  function fVerificaSeTemProfisNoDocto(strAutInc: String): Boolean;
    Var
      strSQL: String;
      qryTmp: TUniQuery;
  begin
    Result := False;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   COUNT(*) AS QTD ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   DIVFAT ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   DIV_SEQGER = :AUTINC ';

    Try
      qryTmp := fCriaQuery;

      With qryTmp Do
      Begin
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('AUTINC').AsString := strAutInc;
        Open;

        If Not IsEmpty Then
          Result := FieldByName('QTD').AsInteger > 0;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmFatConfPedidos.fVerificaSeTemProfisNoDocto]');
      End;
    End;

    FreeAndNil(qryTmp);
  end;

  function fGetAutIncOrCodDiv(strNumDoc, strEspDoc, strCodEmp: String; blnAutInc: Boolean): String;
    Var
      strSQL: String;
      qryTmp: TUniQuery;
  begin
    Result := '';
    strSQL := '';
    
    strSQL := strSQL + ' SELECT ';

    If blnAutInc Then
      strSQL := strSQL + '   DISTINCT FDO_SEQGER AS CAMPO '
    Else
      strSQL := strSQL + '   DISTINCT FDO_CODDIV AS CAMPO ';

    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   FATDOR ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   FDO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '   FDO_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   FDO_CODEMP = :CODEMP ';

    Try
      qryTmp := fCriaQuery;

      With qryTmp Do
      Begin
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;

        If Not IsEmpty Then
          Result := FieldByName('CAMPO').AsString;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmFatConfPedidos.fGetAutIncOrCodDiv]');
      End;
    End;

    FreeAndNil(qryTmp);
  end;
begin
  fatVenda.strAutIncDiv := '';
  strValor := '';

  blnAfterScroll := Assigned(fatVenda.qryTemporariaConfirmacao.AfterScroll);
  fatVenda.qryTemporariaConfirmacao.AfterScroll := Nil;
  intRecNo := fatVenda.qryTemporariaConfirmacao.RecNo;
  fatVenda.qryTemporariaConfirmacao.DisableControls;

  Try
    fatVenda.qryTemporariaConfirmacao.First;
    
    While Not fatVenda.qryTemporariaConfirmacao.Eof Do
    Begin
      {***************************}
      {* MAIS DE UM PROFISSIONAL *}
      {************************FC*}
      If (fCfgSis('NROPRO') = '3') And fEmptyStr(fatVenda.strAutIncDiv) Then
      Begin
        strValor := fGetAutIncOrCodDiv(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString,
                                       fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString,
                                       fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString,
                                       True);

        If fVerificaSeTemProfisNoDocto(strValor) Then
          fatVenda.strAutIncDiv := strValor;
      End
      {***************************}
      {* SOMENTE UM PROFISSIONAL *}
      {************************FC*}
      Else If (fCfgSis('NROPRO') = '2') Then
      Begin
        If fEmptyStr(strValor) Then
          strValor := fGetAutIncOrCodDiv(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString,
                                         fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString,
                                         fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString,
                                         False);

        If (Not fEmptyStr(strValor)) And
            fEmptyStr(fatVenda.strCodDiv) Then
          fatVenda.strCodDiv := strValor;
      End;

      fatVenda.qryTemporariaConfirmacao.Next;
    End;
  Finally
    fatVenda.qryTemporariaConfirmacao.RecNo := intRecNo;
    fatVenda.qryTemporariaConfirmacao.EnableControls;

    If blnAfterScroll Then
    Begin
      pAfterScroll(fatVenda.qryTemporariaConfirmacao);
      fatVenda.qryTemporariaConfirmacao.AfterScroll := pAfterScroll;
    End;
  End;
end;

procedure TfrmFatConfPedidos.pSetaInformacoesCnd(strCodCnd: String);
begin
  fatVenda.strCodCnd := strCodCnd;

  If (Not fEmptyStr(fatVenda.strCodCnd)) And (Not fEmpresaTemAcessoCondicaoPagto(fatVenda.strCodCnd)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar esta condição. Verifique o Cadastro de Condições de Pagamento - Aba "Empresas Acesso".' , ['&O k']);
  End;
end;

procedure TfrmFatConfPedidos.pSetaInformacoesFpg(strConPagRef: String; dtaUltDtaAlt: TDateTime; dtaDtaEnt, dtaPrevis: TDateTime; strCodCnd, strCodFpg, strConPag, strIncGor: String);
  Var
    strTipFor : String;
    strConPagTmp : String;
begin
  fatVenda.dtaGraPed := dtaDtaEnt;
  fatVenda.dtaPrevis := dtaPrevis;

  strTipFor := fRetTipoForaConPag(strCodCnd);

  If (strTipFor = 'OUTROS') And (Not fEmptyStr(strConPag)) Then
    strConPagTmp := strConPag
  Else
    strConPagTmp := fRetConPagCodCnd(strCodCnd);

  fatVenda.pAcertaDataGravacaoDataPrevisao(dtaDtaEnt, dtaPrevis);
  fatVenda.strConPag := fRetCondicao(strConPagRef,
                                     dtaUltDtaAlt,
                                     strCodCnd,
                                     strTipFor,
                                     strConPagTmp,
                                     IIF(fatVenda.dtaPreVis > 0, fatVenda.dtaPreVis, VS_Date),
                                     fatVenda.strOpcDoc,
                                     fatVenda.strCodCid);

  If Not fatVenda.fDocumentoParaFornecedor Then
  Begin
    fatVenda.strConPag := fRetCondicaoDiaFixoCliente(strConPagRef,
                                                     dtaUltDtaAlt,
                                                     fatVenda.strCodCli,
                                                     fatVenda.strConPag,
                                                     IIF(fatVenda.dtaPreVis > 0, fatVenda.dtaPreVis, VS_Date),
                                                     fatVenda.strOpcDoc,
                                                     fatVenda.strCodCid);
  End;

  fatVenda.strConPagOri := strConPag;
  fatVenda.strCodFpg    := strCodFpg;
  If fCfgSis('AJPZDF', VarBoolean) Then
  Begin
    fatVenda.strCodPagOri := strCodCnd;
    fatVenda.dtaUltDtaAlt := dtaUltDtaAlt;
  End;

  fatVenda.objFinanc.pCarregaFinanciamento('FATGOR', strIncGor);

  If (Not fEmptyStr(fatVenda.strCodFpg)) And
     (fRetornaStatusCadastro(fatVenda.strCodFpg, 'FPG', 'CADFPG', 'FPG_CODIGO') <> 'A') Then
  Begin
    fMensagem('ATENÇÃO!', 'A forma de pagamento ' + fatVenda.strCodFpg + '-(' + fFormataCondPag(fatVenda.strConPag) +
                          ') não pode ser utilizada pois está inativa! Favor verificar.', ['&O k']);
  End;
end;

procedure TfrmFatConfPedidos.FormShow(Sender: TObject);
begin
  inherited;

  pnlItens.Visible := False;
  btnItensDoc.Visible := True;

  If fatVenda.strOpcDoc = 'OV' Then
  Begin
    Caption := 'Outras Saídas';
    pnlItens.Visible := True;
    btnItensDoc.Visible := False;

    If (Not fCfgSis('USASER', varBoolean)) Then
    Begin
      lblTotSerDoc.Visible := False;
      edtTotSerDoc.Visible := False;
    End;
  End;  

  fatVenda.strNumPok := '';
  fatVenda.strPedSit := '';

  cxgDocumentosTBV.DataController.DataSource := fatVenda.dtsTemporariaConfirmacao;
  edtCodCli.Text           := fatVenda.strCodCli;
  pCarregaCliente;
  fChamaTelaGravando(fCriaTemporaria, 'Aguarde, Carregando Documentos...');
  strOrgPub := fCampoTabela('CLI_ORGPUB', 'CADCLI', ['CLI_CODCLI'], [fatVenda.strCodCli]);

  {*****************************************}
  {* CASO NÃO TENHA NENHUM DOCUMENTO, SAI  *}
  {**************************************MV*}
  If fatVenda.qryTemporariaConfirmacao.IsEmpty Then
  Begin
    blnFecharForm := True;
  End;

  pCarregarEnderecosEntrega;

  qryCliFat := fCriaQuery(Self);
  qryCliFat.SQL.Add('SELECT SQL_NO_CACHE * FROM CADCLI WHERE CLI_CODCLI = :CODCLI');

  edtCliFat.Text := edtCodCli.Text;
  edtNomCliFat.Text := edtNomCli.Text;

  If (fatVenda.blnAgrupamentoPedidos) Or
     (Not fCfgSis('TRCLCP', varBoolean)) Or
     (Not Assigned(pAlterarClienteConfirmacaoPedido)) Then
  Begin
    pnlCabecalho.Height  := pnlCabecalho.Height - pnlCliFat.Height;
    pnlCliFat.Visible    := False;
  End;

  if (Not fCfgSis('DESOSG', varBoolean)) then
  begin
    pnlCabecalho.Height  := pnlCabecalho.Height - pnlPedOSG.Height;
    pnlPedOSG.Visible    := False;
  end;

  if (Not fCfgSis('DESOSC', varBoolean)) then
  begin
    pnlCabecalho.Height  := pnlCabecalho.Height - pnlPedOSC.Height;
    pnlPedOSC.Visible    := False;
  end;

  if (not fCfgSis('CONEQU', varBoolean)) then
  begin
    pnlAux2.Width := pnlAux2.Width - cxgDocumentosTBVTMP_NUMOSE.Width;
    Self.Width := Self.Width - cxgDocumentosTBVTMP_NUMOSE.Width;
    cxgDocumentosTBVTMP_NUMOSE.Visible := False;
  end;
end;

procedure TfrmFatConfPedidos.pCalculaTotais(blnFechouForm: Boolean = False);
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;
begin
  Try

    qryGenTmp := fCriaQuery(Self);

    If Not blnFechouForm Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  COUNT(*) AS TOTDOC, ';
      strSQL := strSQL + '  SUM(TMP_VLRCON) AS TOTGER ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + fatVenda.strTabelaConfMi;

      With qryGenTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

        edtQtdDoc.Text := FieldByName('TOTDOC').AsString;
        edtTotLiq.Text := FormatFloat('#,##0.00', FieldByName('TOTGER').AsFloat);

        Close;
      End;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  COUNT(*) AS TOTDOC, ';
      strSQL := strSQL + '  SUM(TMP_ITEDOC) AS ITEDOC, ';
      strSQL := strSQL + '  SUM(TMP_VLRCON) AS TOTGER ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + fatVenda.strTabelaConfMi + ' ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  TMP_MARDES = "M" ';

      With qryGenTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

        intItensDocs      := FieldByName('ITEDOC').AsInteger;
        edtQtdDocSel.Text := FieldByName('TOTDOC').AsString;
        edtTotLiqSel.Text := FormatFloat('#,##0.00', FieldByName('TOTGER').AsFloat);

        Close;
      End;

    End
    {**********************************************************************}
    {* DESBLOQUEIA OS PEDIDOS E CADREC SELECIONADOS SE CASO FECHAR O FORM *}
    {*******************************************************************FC*}
    Else
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  TMP_NUMDOC, ';
      strSQL := strSQL + '  TMP_ESPDOC, ';
      strSQL := strSQL + '  TMP_CODEMP, ';
      strSQL := strSQL + '  TMP_CODCLI  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + fatVenda.strTabelaConfMi + ' ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  TMP_MARDES = "M" ';

      With qryGenTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

        If Not IsEmpty Then
        Begin
          First;

          While Not Eof Do
          Begin
            fatVenda.objLock.fLock_Unlock( 'FATGOR' +
                               FieldByName('TMP_NUMDOC').AsString +
                               FieldByName('TMP_ESPDOC').AsString +
                               FieldByName('TMP_CODEMP').AsString, False, False );

            fatVenda.objLock.fLock_Unlock( 'CADREC' +
                               FieldByName('TMP_NUMDOC').AsString +
                               FieldByName('TMP_ESPDOC').AsString +
                               FieldByName('TMP_CODEMP').AsString +
                               FieldByName('TMP_CODCLI').AsString, False, False );

            Next;
          End;
        End;

        Close;
      End;
    End;
  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

procedure TfrmFatConfPedidos.pAfterScroll(DataSet: TDataSet);
begin
  If pnlItens.Visible Then
    pCarregaItensDocumento;

  pCarregarInformacoesOrdemServico(DataSet);
end;

procedure TfrmFatConfPedidos.pAfterScrollDocumentos(DataSet: TDataSet);
begin
  pCarregarInformacoesOrdemServico(DataSet);
end;

procedure TfrmFatConfPedidos.pCarregaCdsItens;
begin
  fChamaTelaGravando(fCarregaCdsItens, 'Aguarde, Carregando produtos ...');
end;

function TfrmFatConfPedidos.fCarregaCdsItens(pgbStatus: TcxProgressBar = Nil): Boolean;
begin
  Result := True;

  If Not pnlItens.Visible Then
    Exit;

  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := fatVenda.qryTemporariaConfirmacao.RecordCount;
  End;

  fatVenda.qryTemporariaConfirmacao.AfterScroll := Nil;

  Try
    fatVenda.qryTemporariaConfirmacao.DisableControls;
    cdsItens.DisableControls;

    fatVenda.qryTemporariaConfirmacao.First;
    While Not fatVenda.qryTemporariaConfirmacao.Eof Do
    Begin
      If Assigned(pgbStatus) Then
        pStepStatusGravacao(pgbStatus);

      pAfterScroll(fatVenda.qryTemporariaConfirmacao);

      fatVenda.qryTemporariaConfirmacao.Next;
    End;
  Finally
    fatVenda.qryTemporariaConfirmacao.First;

    cdsItens.EnableControls;
    fatVenda.qryTemporariaConfirmacao.EnableControls;

    fatVenda.qryTemporariaConfirmacao.AfterScroll := pAfterScroll;
  End;
end;

function TfrmFatConfPedidos.fCarregaNovoCliente: Boolean;
begin
  Result := False;
  If (fCfgSis('LBTRCP', varBoolean))    And
     (edtCliFat.Text <> edtCodCli.Text) Then
  Begin
    If ((Not qryCliFat.isEmpty) And
       (qryCliFat.FieldByName('CLI_CODCLI').AsString <> edtCliFat.Text)) Or
       (qryCliFat.isEmpty) Then
    Begin
      If (Not fVerificaTrocaCliente) Then
        Exit;
    End;
  End;
  qryCliFat.Close;
  qryCliFat.ParamByName('CODCLI').AsString := edtCliFat.Text;
  qryCliFat.Open;
  edtNomCliFat.Text := qryCliFat.FieldByName('CLI_NOMCLI').AsString;
  Result := True;
end;

function TfrmFatConfPedidos.fDocsSelecionadosProducaoForaDeLoja: Boolean;
var
  intRecNo: Integer;
  blnAfterScroll:Boolean;
begin
  Result   := False;
  intRecNo := fatVenda.qryTemporariaConfirmacao.RecNo;
  blnAfterScroll := Assigned(fatVenda.qryTemporariaConfirmacao.AfterScroll);
  fatVenda.qryTemporariaConfirmacao.AfterScroll := Nil;

  Try
    fatVenda.qryTemporariaConfirmacao.DisableControls;

    fatVenda.qryTemporariaConfirmacao.First;
    While Not fatVenda.qryTemporariaConfirmacao.Eof Do
    Begin
      If (fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString = 'M') Then
      Begin
        If fProducaoForaDeLoja(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString,
                               fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString,
                               fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODCLI').AsString) Then
        Begin
          Result := True;
          Exit;
        End;
      End;

      fatVenda.qryTemporariaConfirmacao.Next;
    End;
  Finally
    fatVenda.qryTemporariaConfirmacao.RecNo := intRecNo;
    fatVenda.qryTemporariaConfirmacao.EnableControls;

    If blnAfterScroll Then
    Begin
      pAfterScroll(fatVenda.qryTemporariaConfirmacao);
      fatVenda.qryTemporariaConfirmacao.AfterScroll := pAfterScroll;
    End;
  End;
end;

function TfrmFatConfPedidos.fEhAgrupamentoDePedidosPeloF11: Boolean;
begin
  Result := False;

  If (Not Assigned(fatVenda)) Then
    Exit;

  If (fatVenda.strOriGor <> 'AGRUPAMENTO') Then
    Exit;

  Result := fatVenda.blnAgrupamentoPedidos;
end;

function TfrmFatConfPedidos.fPermiteMarcarPedido(const strNumDoc, strEspDoc, strCodEmp : String; const blnPedTemAdto : Boolean; const strCodCli : String) : Boolean;
begin
  Result := True;

  If Not fEhAgrupamentoDePedidosPeloF11 Then
    Exit;

  If (blnPedTemAdto) Then
  Begin
    pMensagemOk('Não é permitido agrupar pedido com adiantamento!');
    Result := False;
    Exit;
  End;

  If fPedidoVinculadoACobrancaEletronica(strNumDoc, strEspDoc, strCodEmp) Then
  Begin
    pMensagemOk('Não é permitido agrupar pedido vinculado a cobrança eletrônica!');
    Result := False;
    Exit;
  End;

  If TLinkPagamentoCitelClass.fDocumentoLinkPagamentoCitel(strNumDoc, strEspDoc, strCodEmp, strCodCli, strEspDoc) Then
  Begin
    pMensagemOk('Não é permitido agrupar pedido com link de pagamento!');
    Result := False;
    Exit;
  End;

  If TYapayFacade.fPedidoComVinculoYapay(strNumDoc, strEspDoc, strCodEmp) Then
  Begin
    pMensagemOk('Não é permitido agrupar pedido com link de pagamento!');
    Result := False;
    Exit;
  End;

  If (TPixDao.RetornaStatusSePedidoPossuirPix(strNumDoc, strEspDoc, strCodEmp) <> EmptyStr) Then
  Begin
    pMensagemOk('Não é permitido agrupar pedido com PIX!');
    Result := False;
    Exit;
  End;
end;

function TfrmFatConfPedidos.fExisteDocSelecionado: Boolean;
var
  intRecNo: Integer;
  blnAfterScroll: Boolean;
begin
  Result   := False;
  intRecNo := fatVenda.qryTemporariaConfirmacao.RecNo;

  blnAfterScroll := Assigned(fatVenda.qryTemporariaConfirmacao.AfterScroll);
  fatVenda.qryTemporariaConfirmacao.AfterScroll := Nil;

  Try
    fatVenda.qryTemporariaConfirmacao.DisableControls;

    fatVenda.qryTemporariaConfirmacao.First;
    While Not fatVenda.qryTemporariaConfirmacao.Eof Do
    Begin
      If (fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString = 'M') Then
      Begin
        Result := True;
        Exit;
      End;

      fatVenda.qryTemporariaConfirmacao.Next;
    End;
  Finally
    fatVenda.qryTemporariaConfirmacao.RecNo := intRecNo;
    fatVenda.qryTemporariaConfirmacao.EnableControls;

    If blnAfterScroll Then
    Begin
      pAfterScroll(fatVenda.qryTemporariaConfirmacao);
      fatVenda.qryTemporariaConfirmacao.AfterScroll := pAfterScroll;
    End;
  End;
end;

function TfrmFatConfPedidos.fGetSqlItens(blnVazio: Boolean = False): String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  FDO_NUMDOC AS NUMDOC, ';
  Result := Result + '  FDO_ESPDOC AS ESPDOC, ';
  Result := Result + '  FDO_CODEMP AS CODEMP, ';
  Result := Result + '  FDO_CODCLI AS CODCLI, ';
  Result := Result + '  FDO_CODITE AS ITE_CODITE, ';
  Result := Result + '  FDO_DESCRI AS ITE_DESITE, ';
  Result := Result + '  FDO_UNIDAD AS ITE_UNIDAD, ';
  Result := Result + '  FDO_QTDITE - FDO_QTDBAI AS ITE_QTDITE, ';
  Result := Result + '  FDO_UNITAR AS ITE_UNITAR, ';
  Result := Result + '  (FDO_QTDITE - FDO_QTDBAI) * FDO_UNITAR AS ITE_TOTITE, ';
  Result := Result + '  FDO_DESESP AS ITE_DESESP, ';
  Result := Result + '  FDO_CLAFIS AS ITE_CLAFIS, ';
  Result := Result + '  IFNULL(ROUND(FDOREF.REF_CBSVAL * (FDO_QTDITE - FDO_QTDBAI) / FDO_QTDITE, 2), 0) AS ITE_VALCBS, ';
  Result := Result + '  IFNULL(ROUND(FDOREF.REF_VALIBS * (FDO_QTDITE - FDO_QTDBAI) / FDO_QTDITE, 2), 0) AS ITE_VALIBS, ';
  Result := Result + '  IFNULL(ROUND(FDOREF.REF_SELVAL * (FDO_QTDITE - FDO_QTDBAI) / FDO_QTDITE, 2), 0) AS ITE_VAL_IS ';
  Result := Result + 'FROM ';
  Result := Result + '  FATDOR ';
  Result := Result + '  LEFT JOIN FDOREF ON FDOREF.REF_SEQFDO = FATDOR.AUTOINCREM ';
  Result := Result + 'WHERE ';

  If blnVazio Then
    Result := Result + ' FALSE '
  Else
  Begin
    Result := Result + '  FDO_JAFATU = FALSE AND ';
    Result := Result + '  FDO_QTDBAI < FDO_QTDITE AND ';
    Result := Result + '  FDO_NUMDOC = :NUMDOC AND ';
    Result := Result + '  FDO_ESPDOC = :ESPDOC AND ';
    Result := Result + '  FDO_CODCLI = :CODCLI AND ';
    Result := Result + '  FDO_CODEMP = :CODEMP ';
  End;

end;

procedure TfrmFatConfPedidos.pCarregaItensDocumento;
  Var
    fltTotGer: Double;
    fltDesEsp: Double;
    fltTotSer: Double;
    fltTotCBS: Double;
    fltTotIBS: Double;
    fltTotIS: Double;
    intIndCol: Integer;
    qryGenDor: TUniQuery;
    frmFatMostraProdConfirmacao : TfrmFatMostraProdConfirmacao;

  procedure pSetaFiltroDocumento;
  begin
    cdsItens.Filter   := '(1 = 1) ';

    With fatVenda.qryTemporariaConfirmacao Do
    Begin
      cdsItens.Filter := cdsItens.Filter + ' AND NUMDOC = ' + QuotedStr(FieldByName('TMP_NUMDOC').AsString);
      cdsItens.Filter := cdsItens.Filter + ' AND ESPDOC = ' + QuotedStr(FieldByName('TMP_ESPDOC').AsString);
      cdsItens.Filter := cdsItens.Filter + ' AND CODEMP = ' + QuotedStr(FieldByName('TMP_CODEMP').AsString);
      cdsItens.Filter := cdsItens.Filter + ' AND CODCLI = ' + QuotedStr(fatVenda.strCodCli);
    End;
  end;

begin
  cdsItens.Filtered := False;
  pSetaFiltroDocumento;
  cdsItens.Filtered := True;

  If cdsItens.IsEmpty Then
  Begin
    With qryGenDor Do
    Begin
      qryGenDor := fCriaQuery(Self);
          
      Close;
      SQL.Clear;
      SQL.Add(fGetSqlItens);
      ParamByName('NUMDOC').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString;
      ParamByName('ESPDOC').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString;
      ParamByName('CODCLI').AsString := fatVenda.strCodCli;
      ParamByName('CODEMP').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString;
      Open;

      First;

      While Not Eof Do
      Begin
        cdsItens.Append;

        For intIndCol := 0 To Fields.Count -1 Do
          cdsItens.Fields[intIndCol].Value := Fields[intIndCol].Value;
          
        cdsItens.Post;

        Next;        
      End;

      cdsItens.First;

      Close;

      FreeAndNil(qryGenDor);
    End;      
  End;

  {*******************************************}
  {* TOTALIZA O SERVIÇO                      *}
  {****************************************MV*}
  With cdsItens Do
  Begin
    Filtered := False;
    pSetaFiltroDocumento;
    Filter := Filter + ' AND (ITE_CODITE = ' + QuotedStr(fCfgSis('ITESER')) + ' OR ITE_CODITE = ' + QuotedStr(fCfgSis('SERTER')) + ')';
    Filtered := True;

    fltTotGer := 0.0;
    fltDesEsp := 0.0;
    fltTotSer := 0.0;
    fltTotCBS := 0.0;
    fltTotIBS := 0.0;
    fltTotIS  := 0.0;

    First;

    While Not Eof Do
    Begin
      fltTotSer := fltTotSer + FieldByName('ITE_TOTITE').AsFloat;
      Next;
    End;

    Filtered := False;
    pSetaFiltroDocumento;
    Filter   := Filter + ' AND (ITE_CODITE <> ' + QuotedStr(fCfgSis('ITESER')) + ') ';
    Filter   := Filter + ' AND (ITE_CODITE <> ' + QuotedStr(fCfgSis('SERTER')) + ') ';
    Filtered := True;

    First;

    While Not Eof Do
    Begin
      fltTotGer := fltTotGer + FieldByName('ITE_TOTITE').AsFloat;
      fltDesEsp := fltDesEsp + FieldByName('ITE_DESESP').AsFloat;
      fltTotCBS := fltTotCBS + FieldByName('ITE_VALCBS').AsFloat;
      fltTotIBS := fltTotIBS + FieldByName('ITE_VALIBS').AsFloat;
      fltTotIS  := fltTotIS  + FieldByName('ITE_VAL_IS').AsFloat;
      Next;
    End;

    Filtered := False;
    pSetaFiltroDocumento;
    Filtered := True;

    First;

    If pnlItens.Visible Then
    Begin
      Self.dbgItens.DataSource := cdsItens.dtsSource;
      Self.edtTotSerDoc.Text   := FormatFloat('#,##0.00', fltTotSer);
      Self.edtTotGerDoc.Text   := FormatFloat('#,##0.00', fltTotGer);
      Self.edtDesEspDoc.Text   := FormatFloat('#,##0.00', fltDesEsp);
      Self.edtTotLiqDoc.Text   := FormatFloat('#,##0.00', fltTotGer - fltDesEsp + fltTotSer);
      pnlItensDoc.Caption      := 'Produtos do Documento - ' + cdsItens.FieldByName('NUMDOC').AsString + ' - ' +
                                                               cdsItens.FieldByName('ESPDOC').AsString;
    End
    Else
    Begin

      Try
        pCriarFormularios(TfrmFatMostraProdConfirmacao, frmFatMostraProdConfirmacao);

        With frmFatMostraProdConfirmacao Do
        Begin
          dbgItens.DataSource := cdsItens.dtsSource;
          edtTotSer.Text      := FormatFloat('#,##0.00', fltTotSer);
          edtTotGer.Text      := FormatFloat('#,##0.00', fltTotGer);
          edtDesEsp.Text      := FormatFloat('#,##0.00', fltDesEsp);
          edtTotLiq.Text      := FormatFloat('#,##0.00', fltTotGer - fltDesEsp + fltTotSer);
          pExibirNovosImpostos(fltTotCBS, fltTotIBS, fltTotIS);
          Caption             := Caption + cdsItens.FieldByName('NUMDOC').AsString + ' - ' +
                                           cdsItens.FieldByName('ESPDOC').AsString;
          showModal;
        End;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[frmFatConfPedidos.pCarregaItensDocumento]');
        End;
      End;

      pFreeAndNil(frmFatMostraProdConfirmacao);
      
    End;      

  End;

end;

procedure TfrmFatConfPedidos.pCarregarEnderecosEntrega;
begin
  try
    if fClienteConsumidor(edtNomCli.Text) then
    begin
      lblEnderecoEntrega.Visible  := False;
      cmbClienteEnderecos.Visible := False;
      pnlCabecalho.Height         := 38;
    end
    else
      TClienteEnderecoEntregaRepositorio.
        pCarregaEnderecosEntrega(edtCodCli.Text, cmbClienteEnderecos);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[pCarregarEnderecosEntrega]');
  End;
end;

procedure TfrmFatConfPedidos.pCarregarInformacoesOrdemServico(DataSet: TDataSet);
begin
  If (Not Assigned(DataSet)) Or (DataSet.IsEmpty) Then
    Exit;

  pnlDadosOS.Visible := (DataSet.FieldByName('TMP_TIPDOC').AsString = 'OS');

  If (pnlDadosOS.Visible) Then
  Begin
    pnlDadosOS.Caption := '  O.S.: ' + DataSet.FieldByName('TMP_NUMOSE').AsString +
                     ' | Situação: ' + DataSet.FieldByName('TMP_STATUS_OS').AsString +
                       ' | Status: ' + DataSet.FieldByName('TMP_SUBSTA_OS').AsString +
                       ' | Compl.: ' + DataSet.FieldByName('TMP_SITUAC_OS').AsString;
  End;
end;

procedure TfrmFatConfPedidos.pAddPedidoHistCadRec(strNumDoc: String; strEspDoc: String; strCodEmp: String);
  Var
    qryFatGor: TUniQuery;
    strSQL: String;
begin
  qryFatGor := fCriaQuery;
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  FGO_NUMDOC, ';
    strSQL := strSQL + '  FGO_ESPDOC, ';
    strSQL := strSQL + '  FGO_CODEMP, ';
    strSQL := strSQL + '  FGO_OBSL01, ';
    strSQL := strSQL + '  FGO_OBSL02, ';
    strSQL := strSQL + '  FGO_OBSLC1, ';
    strSQL := strSQL + '  FGO_OBSLC2  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  FATGOR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FGO_NUMDOC = ' + QuotedStr(strNumDoc) + ' AND ';
    strSQL := strSQL + '  FGO_ESPDOC = ' + QuotedStr(strEspDoc) + ' AND ';
    strSQL := strSQL + '  FGO_CODEMP = ' + QuotedStr(strCodEmp) + '     ';

    qryFatGor.Close;
    qryFatGor.SQL.Clear;
    qryFatGor.SQL.Add(strSQL);
    qryFatGor.Open;

    fatVenda.pAddPedidoHistCadRec(qryFatGor);
  Finally
    FreeAndNil(qryFatGor);
  End;
End;

function TfrmFatConfPedidos.fCarregaPedidosConfirmados: Boolean;
  Var
    qryGenPedCon: TUniQuery;
    strCodTraSel : String;
    strConPagSel : String;
    strForPagSel : String;
    strCodCndSel : String;
    blnCodTraDif : Boolean;
    blnConPagDif : Boolean;
    blnForPagDif : Boolean;
    blnCodCndDif : Boolean;
    blnResolveuConflitos : Boolean;
    intIdxCmbAux : Integer;
    strCodCnd: String;
    strConPag: String;
    strCodFpg: String;
begin
  Result := True;

  strCodTraSel := '';
  strConPagSel := '';
  strForPagSel := '';
  strCodCndSel := '';

  blnCodTraDif := False;
  blnConPagDif := False;
  blnForPagDif := False;
  blnCodCndDif := False;

  {*************************************************************}
  { ALIMENTA PROPRIEDADE fatvenda.strDocsConfPD PARA UTILIZAÇÃO }
  { NA "CONFIGURAÇÃO DA NOTA FISCAL ELETRÔNICA                  }
  {*********************************************************RL**}
  Try
    qryGenPedCon := fCriaQuery(Self);

    if ( fatVenda.qryTemporariaConfirmacao = Nil ) then
      Exit;

    If (fCfgSis('TREXCP') = 'S' {Pedir senha}) Or
       (AnsiMatchStr(fCfgSis('CNDICP'), ['S', 'C'])) Or
       (fatVenda.blnAgrupamentoPedidos) Then
    Begin
      pCriarFormularios(TfrmFatResolveConflitoPedidos, frmFatResolveConflitoPedidos);
      frmFatResolveConflitoPedidos.fatVenda := fatVenda;
      frmFatResolveConflitoPedidos.strOpcDoc := 'CP';
    End;

    With qryGenPedCon Do
    begin
      Close;
      SQL.Clear;
      SQL.Text := fatVenda.qryTemporariaConfirmacao.SQL.Text;
      Open;

      fatVenda.strDisSer := '';
      fatVenda.strPedidoHistCadRec := '';

      First;
      while not Eof do
      begin
        pAddPedidoHistCadRec(FieldByName('TMP_NUMDOC').AsString,
                              FieldByName('TMP_ESPDOC').AsString,
                              FieldByName('TMP_CODEMP').AsString);

        fatVenda.pAddDocsConfPD(FieldByName('TMP_NUMDOC').AsString + '-' +
                                FieldByName('TMP_ESPDOC').AsString + '-' +
                                FieldByName('TMP_CODEMP').AsString + ',');

        fatVenda.pAddUFsEndEntConfPD(UFEndEnt);

        fatVenda.pAddRotasConfPD(fRetRotasPorPedido(FieldByName('TMP_NUMDOC').AsString,
                                                    FieldByName('TMP_ESPDOC').AsString,
                                                    FieldByName('TMP_CODEMP').AsString));

        fatVenda.pAddRegioesConfPD(fRetRegioesPorPedido(FieldByName('TMP_NUMDOC').AsString,
                                                        FieldByName('TMP_ESPDOC').AsString,
                                                        FieldByName('TMP_CODEMP').AsString));

        If fatVenda.blnAgrupamentoPedidos Then
          fatVenda.blnAbastecimentoDeposito := fEhPedidoAbastecimentoDeposito(FieldByName('TMP_NUMDOC').AsString,
                                                                              FieldByName('TMP_ESPDOC').AsString,
                                                                              FieldByName('TMP_CODEMP').AsString);

        If Not fEmptyStr(FieldByName('TMP_DISSER').AsString) Then
        Begin
          If fEmptyStr(fatVenda.strDisSer) Then
            fatVenda.strDisSer := FieldByName('TMP_DISSER').AsString
          Else
            fatVenda.strDisSer := fatVenda.strDisSer + #13#10 + FieldByName('TMP_DISSER').AsString;
        End;

        If Assigned(frmFatResolveConflitoPedidos) Then
        Begin
          If (RecNo = 1) Then
          Begin
            strCodTraSel := FieldByName('TMP_CODTRA').AsString;
            strConPagSel := FieldByName('TMP_CONPAG').AsString;
            strForPagSel := FieldByName('TMP_CODFPG').AsString;
            strCodCndSel := FieldByName('TMP_CODCND').AsString;
          End
          Else
          Begin
            If (Not blnCodTraDif) Then
            Begin
              If (Not fEmptyStr(strCodTraSel)) And
                 (strCodTraSel <> FieldByName('TMP_CODTRA').AsString) Then
                blnCodTraDif := True;
            End;

            If (Not blnConPagDif) Then
            Begin
              If (Not fEmptyStr(strConPagSel)) And
                 (strConPagSel <> FieldByName('TMP_CONPAG').AsString) Then
                blnConPagDif := True;
            End;

            If (Not blnForPagDif) Then
            Begin
              If (Not fEmptyStr(strForPagSel)) And
                 (strForPagSel <> FieldByName('TMP_CODFPG').AsString) Then
                blnForPagDif := True;
            End;

            If (Not blnCodCndDif) Then
            Begin
              If (Not fEmptyStr(strCodCndSel)) And
                 (strCodCndSel <> FieldByName('TMP_CODCND').AsString) Then
                blnCodCndDif := True;
            End;
          End;

          frmFatResolveConflitoPedidos.pAddDocumentos(FieldByName('TMP_NUMDOC').AsString,
                                                      FieldByName('TMP_ESPDOC').AsString,
                                                      FieldByName('TMP_CODEMP').AsString,
                                                      FieldByName('TMP_CODCLI').AsString);
        End;

        Next;
      end;
    end;
  Finally
    FreeAndNil(qryGenPedCon);
  end;

  fatVenda.blnResolveuConflitoDeTransportadora := False;

  If Assigned(frmFatResolveConflitoPedidos) Then
  Begin
    Try
      If (blnCodTraDif) Or (blnConPagDif) Or (blnForPagDif) Or (blnCodCndDif) Then
      Begin
        blnResolveuConflitos := True;

        If (blnResolveuConflitos) And ((fCfgSis('TREXCP') = 'S' {Pedir senha}) Or (fatVenda.blnAgrupamentoPedidos)) And (blnCodTraDif) Then
        Begin
          frmFatResolveConflitoPedidos.tipConflPedido := cpTransportadora;
          frmFatResolveConflitoPedidos.ShowModal;
          blnResolveuConflitos := frmFatResolveConflitoPedidos.blnConfirma;

          If (blnResolveuConflitos) Then
          Begin
            fatVenda.strCodTra := frmFatResolveConflitoPedidos.edtCodTra.Text;
            fatVenda.blnResolveuConflitoDeTransportadora := True;
          End;
        End;

        If (blnResolveuConflitos) And ((fCfgSis('CNDICP') = 'S' {Pedir senha}) Or (fatVenda.blnAgrupamentoPedidos)) And (blnConPagDif Or blnForPagDif Or blnCodCndDif) Then
        Begin
          frmFatResolveConflitoPedidos.tipConflPedido := cpCondicao;
          frmFatResolveConflitoPedidos.ShowModal;
          blnResolveuConflitos := frmFatResolveConflitoPedidos.blnConfirma;

          If (blnResolveuConflitos) Then
          Begin
            intIdxCmbAux := frmFatResolveConflitoPedidos.cmbConPag.ItemIndex;

            fatVenda.strCodCnd := frmFatResolveConflitoPedidos.arrConflitos[intIdxCmbAux].strCodCnd;
            fatVenda.strConPag := frmFatResolveConflitoPedidos.arrConflitos[intIdxCmbAux].strConPag;
            fatVenda.strCodFpg := frmFatResolveConflitoPedidos.arrConflitos[intIdxCmbAux].strCodFpg;

            If blnConPagDif Then
            Begin
              fatVenda.strConPagResolvidoEmConflito := fatVenda.strConPag;
              fatVenda.strCodCndResolvidoEmConflito := fatVenda.strCodCnd;
            End;

            fatVenda.strConPagOri := fatVenda.strConPag;
          End;
        End
        Else If (blnResolveuConflitos) And (fCfgSis('CNDICP') = 'C' {Permitir maior prazo}) And (blnConPagDif Or blnForPagDif Or blnCodCndDif) Then
        Begin
          if fVerificaConPagMaiorPrazo(fatVenda.dtsTemporariaConfirmacao.DataSet, fStrToFloat(edtTotLiqSel.Text), strCodCnd, strConPag, strCodFpg) then
          begin
            fatVenda.strCodCnd := strCodCnd;
            fatVenda.strConPag := strConPag;
            fatVenda.strCodFpg := strCodFpg;

            If blnConPagDif Then
            Begin
              fatVenda.strConPagResolvidoEmConflito := fatVenda.strConPag;
              fatVenda.strCodCndResolvidoEmConflito := fatVenda.strCodCnd;
            End;

            fatVenda.strConPagOri := fatVenda.strConPag;
          end
          else
          begin
            frmFatResolveConflitoPedidos.tipConflPedido := cpCondicao;
            frmFatResolveConflitoPedidos.ShowModal;
            blnResolveuConflitos := frmFatResolveConflitoPedidos.blnConfirma;

            If (blnResolveuConflitos) Then
            Begin
              intIdxCmbAux := frmFatResolveConflitoPedidos.cmbConPag.ItemIndex;

              fatVenda.strCodCnd := frmFatResolveConflitoPedidos.arrConflitos[intIdxCmbAux].strCodCnd;
              fatVenda.strConPag := frmFatResolveConflitoPedidos.arrConflitos[intIdxCmbAux].strConPag;
              fatVenda.strCodFpg := frmFatResolveConflitoPedidos.arrConflitos[intIdxCmbAux].strCodFpg;

              If blnConPagDif Then
              Begin
                fatVenda.strConPagResolvidoEmConflito := fatVenda.strConPag;
                fatVenda.strCodCndResolvidoEmConflito := fatVenda.strCodCnd;
              End;

              fatVenda.strConPagOri := fatVenda.strConPag;
            End;
          End;
        End;

        If (Not blnResolveuConflitos) Then
        Begin
          fatVenda.blnResolveuConflitoDeTransportadora := False;
          Result := False;
        End;
      End;
    Finally
      pFreeAndNil(frmFatResolveConflitoPedidos);
    End;
  End;
end;

function TfrmFatConfPedidos.fConPagPed(strConPagRef: String; dtaUltDtaAlt: TDateTime; strCodCnd: String; dtaDtaEnt, dtaPrevis: TDateTime): String;
  Var
    dtaGraPedSav : TDateTime;
    dtaPreVisSav : TDateTime;
begin
  dtaGraPedSav := fatVenda.dtaGraPed;
  dtaPreVisSav := fatVenda.dtaPrevis;
  Try
    fatVenda.dtaGraPed := dtaDtaEnt;
    fatVenda.dtaPrevis := dtaPrevis;

    fatVenda.pAcertaDataGravacaoDataPrevisao(dtaDtaEnt, dtaPrevis);

    Result := fRetCondicao(strConPagRef,
                           dtaUltDtaAlt,
                           strCodCnd,
                           fRetTipoForaConPag(strCodCnd),
                           fRetConPagCodCnd(strCodCnd),
                           IIF(fatVenda.dtaPreVis > 0, fatVenda.dtaPreVis, VS_Date),
                           fatVenda.strOpcDoc,
                           fatVenda.strCodCid);

    If Not fatVenda.fDocumentoParaFornecedor Then
    Begin
      Result := fRetCondicaoDiaFixoCliente(strConPagRef,
                                           dtaUltDtaAlt,
                                           fatVenda.strCodCli,
                                           Result,
                                           IIF(fatVenda.dtaPreVis > 0, fatVenda.dtaPreVis, VS_Date),
                                           fatVenda.strOpcDoc,
                                           fatVenda.strCodCid);
    End;
  Finally
    fatVenda.dtaGraPed := dtaGraPedSav;
    fatVenda.dtaPrevis := dtaPreVisSav;
  End;
end;

procedure TfrmFatConfPedidos.btnItensDocClick(Sender: TObject);
begin
  inherited;

  If Not btnItensDoc.Visible Then
    Exit;

  pCarregaItensDocumento;
  pSetFocus(cxgDocumentos);
end;

procedure TfrmFatConfPedidos.btnConfirmaClick(Sender: TObject);
Var
  qryItens : TDataSet;
begin
  inherited;

  If (Not fValidaCampos(edtCliFat, False)) Then
    Exit;

  If Not fatVenda.blnAgrupamentoPedidos Then
  Begin
    If StrToInt(edtQtdDocSel.Text) <= 0 Then
    Begin
      fMensagem('', 'É necessário escolher pelo menos um documento!', ['&O k']);
      pSetFocus(cxgDocumentos);
      Exit;
    End;
  End
  Else
  Begin
    If StrToInt(edtQtdDocSel.Text) <= 1 Then
    Begin
      fMensagem('', 'É necessário escolher pelo menos dois documentos!', ['&O k']);
      pSetFocus(cxgDocumentos);
      Exit;
    End;
  End;

  If (fStrToFloat(edtTotLiqSel.Text) < 0.0) Then
  Begin
    fMensagem('', 'Não é possivel confirmar um valor negativo!', ['&O k']);
    pSetFocus(cxgDocumentos);
    Exit;
  End;

  If fMensagem('', 'Confirma pedidos?', ['&Sim', '&Não']) = 1 Then
  Begin
    pDeletaDocDesmarcados;
    pAtualizaTemporaria;

    fatVenda.blnPedGarTE := (fCampoTabela('DISTINCT(TMP_PDGATE)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']) = 'S');

    If (fCfgSis('CDTCLV', varBoolean)) Then
    Begin
      fatVenda.strAutIcv := EmptyStr;

      If (Not fValidaInformacaoComodato) Then
        Exit;
    End;

    If Assigned(pAlterarClienteConfirmacaoPedido) And pnlCliFat.Visible Then
      pAlterarClienteConfirmacaoPedido(edtCodCli.Text, edtCliFat.Text);

    If Not fCarregaPedidosConfirmados Then
      Exit;

    pPegaDoctoComProfis;

    qryItens := cxgDocumentosTBV.DataController.DataSource.DataSet;
    qryItens.First;

    While (Not qryItens.Eof) Do
    Begin
      If fEmptyStr(fatVenda.strNumPok) And (Not fEmptyStr(qryItens.FieldByName('FGO_NUMPOK').AsString)) Then
      Begin
        fatVenda.strNumPok := qryItens.FieldByName('FGO_NUMPOK').AsString;
      End;

      If fEmptyStr(fatVenda.strPedSit) And (Not fEmptyStr(qryItens.FieldByName('FGO_PEDSIT').AsString)) Then
      Begin
        fatVenda.strPedSit := qryItens.FieldByName('FGO_PEDSIT').AsString;
      End;

      If (Not fEmptyStr(fatVenda.strNumPok)) And (Not fEmptyStr(fatVenda.strPedSit)) Then
      Begin
        Break;
      End;

      qryItens.Next;
    End;

    qryItens.First;

    If (Not fEmptyStr(strSomSer)) And (Not (Pos('N', strSomSer) > 0)) Then
      strTemSer := 'S';

    blnConfirma := True;
    blnPedFabOSG := chkPedOSG.Checked;
    Close;

  End;

end;

{*****************************************}
{* APAGA DOCUMENTOS QUE NAO ESTÃO SELE-  *}
{* CIONADOS                              *}
{**************************************MV*}
procedure TfrmFatConfPedidos.pDeletaDocDesmarcados;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;

begin
  Try

    qryGenTmp := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ' + fatVenda.strTabelaConfMi + ' ';
    strSQL := strSQL + 'WHERE TMP_MARDES <> "M" ';

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

procedure TfrmFatConfPedidos.FormActivate(Sender: TObject);
begin
  inherited;
  pCarregaCdsItens;
  {*****************************************}
  {* CASO NÃO TENHA NENHUM DOCUMENTO, SAI  *}
  {**************************************MV*}
  If blnFecharForm Then
  Begin
    fMensagem('', 'Não há documentos para esse cliente!', ['&O k']);
    Self.Close;
  End;
end;

function TfrmFatConfPedidos.fPermiteMarcarPDOSGarantiaLoja(AGarantia: String): Boolean;
begin
  Result := True;

  if (not fCfgSis('CONEQU', varBoolean)) then
    Exit;

  if (not fCfgSis('OSGLCP', varBoolean)) then
    Exit;

  Result := fCampoTabela('COUNT(1)', fatVenda.strTabelaConfMi, ['TMP_MARDES','TMP_GARLOJ'], ['M', IIF(AGarantia = 'N', 'S', 'N')]) = 0;
end;

function TfrmFatConfPedidos.fPermiteProducaoForaDeLoja(strNumDoc, strCodEmp,
  strCodCli: String): Boolean;
begin
  Result := True;
  Try
    If ((fProducaoForaDeLoja(strNumDoc, strCodEmp, strCodCli) And (Not fDocsSelecionadosProducaoForaDeLoja)) Or
       ((Not fProducaoForaDeLoja(strNumDoc, strCodEmp, strCodCli)) And (fDocsSelecionadosProducaoForaDeLoja))) And fExisteDocSelecionado Then
      Result := False;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fPermiteProducaoForaDeLoja]');
    End;
  End;
end;

function TfrmFatConfPedidos.fProducaoForaDeLoja(strNumDoc, strCodEmp,
  strCodCli: String): Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := false;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                     ' +
        '   COUNT(0) AS QTD          ' +
        ' FROM                       ' +
        '   FATGOR                   ' +
        ' WHERE FGO_NUMDOC = :NUMDOC ' +
        '   AND FGO_CODEMP = :CODEMP ' +
        '   AND FGO_CODCLI = :CODCLI ' +
        '   AND FGO_ESPDOC = "PD"    ' +
        '   AND FGO_OPRFLJ = "S"     ';

      qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
      qryGen.ParamByName('CODEMP').AsString := strCodEmp;
      qryGen.ParamByName('CODCLI').AsString := strCodCli;
      qryGen.Open;

      Result := qryGen.FieldByName('QTD').AsInteger > 0;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

function TfrmFatConfPedidos.fResolveTransportadorCondicao(strCampo: String; blnPermiteContinuar: Boolean = True): Boolean;
  Var
    strTemp : String;
    strDesCampo : String;
begin
  Result := True;

  If (strCampo = 'CODTRA') Then
    strDesCampo := 'transportadora'
  Else If (strCampo = 'CONPAG') Then
    strDesCampo := 'condição'
  Else If (strCampo = 'CODCND') Then
    strDesCampo := 'condição'
  Else If (strCampo = 'CODFPG') Then
    strDesCampo := 'forma de pagamento';

  strTemp := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_' + strCampo + ')', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);

  If (Not fEmptyStr(strTemp)) And (strTemp <> fTemp( strCampo ).AsString) Then
  Begin
    If blnPermiteContinuar Then
      If fMensagem('', 'Este pedido tem ' + strDesCampo + ' diferente da ' + strDesCampo + ' dos pedidos selecionados.' + sLineBreak +
                       'No final, será solicitado senha de liberação, para realização deste procedimento. Confirma?', ['&Sim', '&Não']) = 2 Then
        Result := False;

    If Not blnPermiteContinuar Then
    Begin
      pMensagemOK('Este pedido tem ' + strDesCampo + ' diferente da ' + strDesCampo + ' dos pedidos selecionados.');
      Result := False;
    End;
  End;
end;

procedure TfrmFatConfPedidos.pSetaInformacoesPedido(qryTemp: TUniQuery);
  Var
    strSqlBus, strNumPed, strCodEmp : String;
    qryBusca  : TUniQuery;

    strCodCndTmp : String;
    strCodFpgTmp : String;
    strPagOriTmp : String;
    strConPagTmp : String;
    strConPagCur : String;
    blnZerInfCnd : Boolean;
    intCnt : Integer;
    arrDupl: TDoubleArray;
begin
  With qryTemp Do
  Begin
    If qryTemp.RecordCount = 1 Then
    Begin
      strNumPed := FieldByName('TMP_NUMDOC').AsString;
      strCodEmp := FieldByName('TMP_CODEMP').AsString;
    End;
  End;

  If Not fEmptyStr(strNumPed) Then
  Begin
    strSqlBus := '';
    strSqlBus := strSqlBus + ' SELECT                     ';
    strSqlBus := strSqlBus + '   AUTOINCREM,              ';
    strSqlBus := strSqlBus + '   FGO_CODCLI,              ';
    strSqlBus := strSqlBus + '   FGO_CODCND,              ';
    strSqlBus := strSqlBus + '   FGO_CONPAG,              ';
    strSqlBus := strSqlBus + '   FGO_CODFPG,              ';
    strSqlBus := strSqlBus + '   FGO_CODTRA,              ';
    strSqlBus := strSqlBus + '   FGO_TOTFRE,              ';
    strSqlBus := strSqlBus + '   FGO_TIPFRE,              ';
    strSqlBus := strSqlBus + '   FGO_NUMREG,              ';
    strSqlBus := strSqlBus + '   FGO_MEN001,              ';
    strSqlBus := strSqlBus + '   FGO_MEN002,              ';
    {*******************************}
    {* DADOS DO CLIENTE CONSUMIDOR *}
    {****************************RV*}
    strSqlBus := strSqlBus + '   FGO_NOMCON,              ';
    strSqlBus := strSqlBus + '   FGO_ENDCON,              ';
    strSqlBus := strSqlBus + '   FGO_BAICON,              ';
    strSqlBus := strSqlBus + '   FGO_CEPCON,              ';
    strSqlBus := strSqlBus + '   FGO_CIDCON,              ';
    strSqlBus := strSqlBus + '   FGO_TELCON,              ';
    strSqlBus := strSqlBus + '   FGO_NASCON,              ';
    strSqlBus := strSqlBus + '   FGO_CGCCPF,              ';
    strSqlBus := strSqlBus + '   FGO_CGCCON,              ';
    strSqlBus := strSqlBus + '   FGO_IESCON,              ';
    strSqlBus := strSqlBus + '   FGO_R_GCON,              ';
    strSqlBus := strSqlBus + '   FGO_EMLCON,              ';
    strSqlBus := strSqlBus + '   FGO_TIPOPE,              ';
    strSqlBus := strSqlBus + '   FGO_TABPRE,              ';

    strSqlBus := strSqlBus + '   FGO_PEDSIT,              ';
    strSqlBus := strSqlBus + '   FGO_CODFIN,              ';
    strSqlBus := strSqlBus + '   FGO_QTDPAR,              ';
    strSqlBus := strSqlBus + '   FGO_DTAENT,              ';
    strSqlBus := strSqlBus + '   FGO_PREVIS,              ';
    strSqlBus := strSqlBus + '   FGO_CODATI,              ';
    strSqlBus := strSqlBus + '   FGO_EMPPIX,              ';
    strSqlBus := strSqlBus + '   FGO_TX_PIX,              ';
    strSqlBus := strSqlBus + '   FGO_REGDES,              ';
    strSqlBus := strSqlBus + '   FGO_FATSSA,              ';

    For intCnt := 1 To 12 Do
      strSqlBus := strSqlBus + ' FGO_VPAR' + fStrZero(intCnt, 2) + ', ';

    strSqlBus := strSqlBus + '   FGO_DTENTR,              ';
    strSqlBus := strSqlBus + '   FGO_ULTALT,              ';
    strSqlBus := strSqlBus + '   FGO_CILVAS,              ';
    strSqlBus := strSqlBus + '   FGO_AUTICV,              ';
    strSqlBus := strSqlBus + '   FGO_SUPGER,              ';
    strSqlBus := strSqlBus + '   FGO_SUPREG,              ';
    strSqlBus := strSqlBus + '   FGO_CODTPA,              ';
    strSqlBus := strSqlBus + '   FGO_CDCOPO,              ';
    strSqlBus := strSqlBus + '   FGO_CDCSTA               ';
    strSqlBus := strSqlBus + ' FROM                       ';
    strSqlBus := strSqlBus + '   FATGOR                   ';
    strSqlBus := strSqlBus + '   INNER JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM ';
    strSqlBus := strSqlBus + ' WHERE                      ';
    strSqlBus := strSqlBus + '   FGO_NUMDOC =:NUMDOC AND  ';
    strSqlBus := strSqlBus + '   FGO_ESPDOC =:ESPDOC AND  ';
    strSqlBus := strSqlBus + '   FGO_CODEMP =:CODEMP      ';

    qryBusca := fCriaQuery(Nil);

    With qryBusca Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSqlBus);
      ParamByName('NUMDOC').AsString := strNumPed;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('ESPDOC').AsString := strEspecie;
      Open;

      If Not IsEmpty Then
      Begin
        arrDupl := Nil;

        For intCnt := 1 To 12 Do
        Begin
          If (fFormataFloat(qryBusca.FieldByName('FGO_VPAR' + fStrZero(intCnt, 2)).AsFloat, 2) > 0) Then
          Begin
            SetLength(arrDupl, Length(arrDupl) + 1);
            arrDupl[ Length(arrDupl)-1 ] := qryBusca.FieldByName('FGO_VPAR' + fStrZero(intCnt, 2)).AsFloat;
          End;
        End;

        fatVenda.pSalvarDuplicCarrPedido(arrDupl);

        {*****************************************}
        {* VALIDA CONDICAO DE PAGTO CARREGADA    *}
        {**************************************IV*}
        If fCfgSis('USACND', varBoolean) Then
        Begin
          pSetaInformacoesCnd(FieldByName('FGO_CODCND').AsString);
        End;

        {*****************************************}
        {* VALIDA FORMA DE PAGAMENTO CARREGADA   *}
        {**************************************IV*}
        If fCfgSis('USAFPG', varBoolean) Then
        Begin
          pSetaInformacoesFpg(FieldByName('FGO_CONPAG').AsString,
                              FieldByName('FGO_ULTALT').AsDateTime,
                              FieldByName('FGO_DTAENT').AsDateTime,
                              FieldByName('FGO_PREVIS').AsDateTime,
                              FieldByName('FGO_CODCND').AsString,
                              FieldByName('FGO_CODFPG').AsString,
                              FieldByName('FGO_CONPAG').AsString,
                              FieldByName('AUTOINCREM').AsString);
        End;

        fatVenda.strTabPre    := FieldByName('FGO_TABPRE').AsString;
        fatVenda.strTipOpe    := FieldByName('FGO_TIPOPE').AsString;
        fatVenda.strCodTra    := FieldByName('FGO_CODTRA').AsString;
        fatVenda.fltValFre    := FieldByName('FGO_TOTFRE').AsFloat;
        fatVenda.fltFreDig    := FieldByName('FGO_TOTFRE').AsFloat;
        fatVenda.strTipFre    := FieldByName('FGO_TIPFRE').AsString;
        fatVenda.strNumReg    := FieldByName('FGO_NUMREG').AsString;
        fatVenda.strMen001    := FieldByName('FGO_MEN001').AsString;
        fatVenda.strMen002    := FieldByName('FGO_MEN002').AsString;
        fatVenda.strPedSit    := FieldByName('FGO_PEDSIT').AsString;
        fatVenda.dtaDtEntr    := IIF(FieldByName('FGO_DTENTR').AsDateTime < VS_Date, VS_Date, FieldByName('FGO_DTENTR').AsDateTime);
        fatVenda.strCodTpa    := FieldByName('FGO_CODTPA').AsString;
        fatVenda.intCdcOpo    := FieldByName('FGO_CDCOPO').AsInteger;
        fatVenda.strCdcSta    := FieldByName('FGO_CDCSTA').AsString;

        {*******************************}
        {* DADOS DO CLIENTE CONSUMIDOR *}
        {****************************RV*}
        If fClienteConsumidor(fRetNomCliente(FieldByName('FGO_CODCLI').AsString)) Then
        Begin
          fatVenda.strCliNom := FieldByName('FGO_NOMCON').AsString;
          fatVenda.strCliEnd := FieldByName('FGO_ENDCON').AsString;
          fatVenda.strCliBai := FieldByName('FGO_BAICON').AsString;
          fatVenda.strCliCep := FieldByName('FGO_CEPCON').AsString;
          fatVenda.strCodCid := FieldByName('FGO_CIDCON').AsString;
          fatVenda.strCliCid := fRetNomCidade(fatVenda.strCodCid);
          fatVenda.strCliEst := fRetNomCidade(fatVenda.strCodCid, 1);
          fatVenda.strCliTel := FieldByName('FGO_TELCON').AsString;
          fatVenda.dtaNasCon := FieldByName('FGO_NASCON').AsDateTime;
          fatVenda.intCgcCpf := FieldByName('FGO_CGCCPF').AsInteger;
          fatVenda.strCliCgc := FieldByName('FGO_CGCCON').AsString;
          fatVenda.strCliIes := FieldByName('FGO_IESCON').AsString;
          fatVenda.strCli_Rg := FieldByName('FGO_R_GCON').AsString;
          fatVenda.strCliEma := FieldByName('FGO_EMLCON').AsString;
          fatVenda.strCodAti := FieldByName('FGO_CODATI').AsString;
          fatVenda.strNomAti := fRetAtividade(fatVenda.strCodAti);
        End;

        fatVenda.DadosPixDaVenda.EmpresaDoPix := FieldByName('FGO_EMPPIX').AsString;
        fatVenda.DadosPixDaVenda.TxIdPix := FieldByName('FGO_TX_PIX').AsString;
        fatVenda.blnDesmembraPedRegEsp := (FieldByName('FGO_REGDES').AsString = 'S');
        fatVenda.strEmpFatSemSaldo     := FieldByName('FGO_FATSSA').AsString;
        fatVenda.strSupGer             := FieldByName('FGO_SUPGER').AsString;
        fatVenda.strSupReg             := FieldByName('FGO_SUPREG').AsString;
      End;

    End;

    FreeAndNil(qryBusca);

  End
  Else
  Begin
    fatVenda.strTipOpe := strTipOpe;

    If (Not qryTemp.IsEmpty) Then
    Begin
      qryTemp.First;

      strCodCndTmp := qryTemp.FieldByName('TMP_CODCND').AsString;
      strCodFpgTmp := qryTemp.FieldByName('TMP_CODFPG').AsString;
      strPagOriTmp := qryTemp.FieldByName('TMP_CONPAG').AsString;
      strConPagTmp := fConPagPed(qryTemp.FieldByName('TMP_CONPAG').AsString,
                                 qryTemp.FieldByName('TMP_ULTALT').AsDateTime,
                                 qryTemp.FieldByName('TMP_CODCND').AsString,
                                 qryTemp.FieldByName('TMP_DTAENT').AsDateTime,
                                 qryTemp.FieldByName('TMP_PREVIS').AsDateTime);

      blnZerInfCnd := False;

      While Not qryTemp.Eof Do
      Begin

        If (strCodCndTmp <> qryTemp.FieldByName('TMP_CODCND').AsString) Then
        Begin
          blnZerInfCnd := True;
          Break;
        End;

        If (strCodFpgTmp <> qryTemp.FieldByName('TMP_CODFPG').AsString) Then
        Begin
          blnZerInfCnd := True;
          Break;
        End;

        If (strPagOriTmp <> qryTemp.FieldByName('TMP_CONPAG').AsString) Then
        Begin
          blnZerInfCnd := True;
          Break;
        End;

        strConPagCur := fConPagPed(qryTemp.FieldByName('TMP_CONPAG').AsString,
                                   qryTemp.FieldByName('TMP_ULTALT').AsDateTime,
                                   qryTemp.FieldByName('TMP_CODCND').AsString,
                                   qryTemp.FieldByName('TMP_DTAENT').AsDateTime,
                                   qryTemp.FieldByName('TMP_PREVIS').AsDateTime);

        If (strConPagTmp <> strConPagCur) Then
        Begin
          blnZerInfCnd := True;
          Break;
        End;

        qryTemp.Next;
      End;

      If (Not blnZerInfCnd) Then
      Begin
        qryTemp.First;

        If fCfgSis('USACND', varBoolean) Then
        Begin
          pSetaInformacoesCnd(qryTemp.FieldByName('TMP_CODCND').AsString);
        End;

        If fCfgSis('USAFPG', varBoolean) Then
        Begin
          pSetaInformacoesFpg(qryTemp.FieldByName('TMP_CONPAG').AsString,
                              qryTemp.FieldByName('TMP_ULTALT').AsDateTime,
                              qryTemp.FieldByName('TMP_DTAENT').AsDateTime,
                              qryTemp.FieldByName('TMP_PREVIS').AsDateTime,
                              qryTemp.FieldByName('TMP_CODCND').AsString,
                              qryTemp.FieldByName('TMP_CODFPG').AsString,
                              qryTemp.FieldByName('TMP_CONPAG').AsString,
                              qryTemp.FieldByName('TMP_AUTINC').AsString);
        End;
      End
      Else
      Begin
        fatVenda.strCodCnd := '';
        fatVenda.strConPag := '';
        fatVenda.strConPagOri := '';
        fatVenda.strCodFpg := '';
      End;
    End;
  End;
end;

Function TfrmFatConfPedidos.fTrataSaldo(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  Var
    strSQL: String;
    strCodigo: String;
    blnMostraItens: Boolean;

    fltSaldoRes: Double;
    fltSaldoVer: Double;
    fltQtdIte  : Double;
    fltSaldoMatriz: Double;

    qryGenDor : TUniQuery;

    stlItens : TStringList;
    objDicQtd: TDicionario;
    objDicSal: TDicionario;

    intContador : Integer;

    blnItemNormalSemEstoque: Boolean;

    objCadLot: TCadLot;
    blnEmpFat: Boolean;
    blnSaldoMatriz: Boolean;
    strNTrava,
    strItens: String;

    blnIteEntFut,
    blnTravarItemNormal: Boolean;
    strEmpMat: String;

    objMsg : TMensagemLiberacao;
    objTabela: TRegistroMsgLiberaTabela;
    objLinha: TLinhaMsgLibera;

    frmFatMostraProdSemSaldo: TfrmFatMostraProdSemSaldo;
begin
  Result := True;

  blnEmpFat := False;

  objCadLot := TCadLot.Create(Self);
  blnItemNormalSemEstoque := False;

  qryGenDor := fCriaQuery;

  objDicQtd := TDicionario.Create;
  objDicSal := TDicionario.Create;
  stlItens  := TStringList.Create;

  blnMostraItens := False;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   I.ITE_DESITE, ';
  strSQL := strSQL + '   G.ITE_SALDOS, ';
  strSQL := strSQL + '   FATDOR.*,     ';
  strSQL := strSQL + '   FGO_CONENT,   ';
  strSQL := strSQL + '   FGO_ENT_CD    ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FATDOR ';

  strSQL := strSQL + '  INNER JOIN CADITE I ON I.ITE_CODITE = FDO_CODITE     ';
  strSQL := strSQL + '  INNER JOIN ITEGER G ON G.ITE_CODITE = FDO_CODITE AND ';
  strSQL := strSQL + '                         G.ITE_CODEMP =  ' + QuotedStr(VS_strCodEmp);

  strSQL := strSQL + '  JOIN FATGOR ON FATGOR.AUTOINCREM = FDO_SEQGER ';
  strSQL := strSQL + '  LEFT JOIN FORTIN ON FATDOR.FDO_CODACA = FORTIN.FOR_CODACA AND FORTIN.FOR_EMPACA = FATDOR.FDO_EMPACA ';
  strSQL := strSQL + '  JOIN CADGRU ON GRU_CODGRU = ITE_CODGRU ';
  strSQL := strSQL + '  LEFT JOIN CADLOT ON  FDO_CODITE = LOT_CODITE AND ';
  strSQL := strSQL +    QuotedStr(VS_strCodEmp) +     ' = LOT_CODEMP AND ';
  strSQL := strSQL + '                       FDO_NUMLOT = LOT_NUMLOT     ';
  strSQL := strSQL + '  LEFT JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FDO_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  FDO_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  FDO_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  FDO_PROEMB <> "S" AND ';
  strSQL := strSQL + '  FDO_CODITE <> ' + QuotedStr(fCfgSis('ITESER')) + ' AND ';
  strSQL := strSQL + '  FDO_CODITE <> ' + QuotedStr(fCfgSis('SERTER')) + ' ';
  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  FATDOR.AUTOINCREM ';

  With qryGenDor Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;

    Open;

    {*****************************************}
    {* LIMPA PARA USAR NO FILTRO DO CLIENT.  *}
    {**************************************AF*}

    blnTravarItemNormal := False;

    strSQL := '';
    While Not Eof Do
    Begin
      blnSaldoMatriz := False;
      
      fltQtdIte := FieldByName('FDO_QTDITE').AsFloat - FieldByName('FDO_QTDBAI').AsFloat;

      If (Not fEmptyStr(FieldByName('FDO_NUMLOT').AsString)) And
         objCadLot.fExisteLote(FieldByName('FDO_CODITE').AsString,
                               IIF(blnEmpFat And (Not FieldByName('FDO_EMPITE').IsNull),
                                     FieldByName('FDO_EMPITE').AsString,
                                     FieldByName('FDO_CODEMP').AsString),
                               FieldByName('FDO_NUMLOT').AsString) Then
        fltSaldoVer := objCadLot.qryCadLot.FieldByName('LOT_SALDOS').AsFloat
      Else
      Begin
        If blnEmpFat And (Not FieldByName('FDO_EMPITE').IsNull) Then
          fltSaldoVer := fRetSaldosEmpresa(FieldByName('FDO_CODITE').AsString,
                                           FieldByName('FDO_EMPITE').AsString)
        Else
          fltSaldoVer := FieldByName('ITE_SALDOS').AsFloat;
      End;

      If (FieldByName('FGO_ENT_CD').AsString = 'S') Then
      Begin
        strEmpMat := fCfgSis('EMP_CD');
        blnSaldoMatriz := True;
      End;

      If (FieldByName('FGO_CONENT').AsString = 'S') Then
      Begin
        strEmpMat := fCfgSis('EMPMAT');
        blnSaldoMatriz := True;
      End;

      If blnSaldoMatriz Then
      Begin
        pCarregaEstoqueMatrizAux(objCadLot, FieldByName('FDO_CODITE').AsString,
          FieldByName('FDO_NUMLOT').AsString, strEmpMat, fltSaldoMatriz);

        fltSaldoVer := fltSaldoMatriz;
      End;

      If fUsaQtdPendenteEntregaFutura Then
      Begin                                       
        If blnSaldoMatriz Then
          fltSaldoVer := fltSaldoVer +  TEntregaFutura.New(
                                          TParamEF.New()
                                            .CodIte(FieldByName('FDO_CODITE').AsString)
                                            .CodEmp(strEmpMat)
                                            .Faturamento(True)
                                          ).Total()
        Else
          fltSaldoVer := fltSaldoVer + TEntregaFutura.New(
                                         TParamEF.New()
                                           .CodIte(FieldByName('FDO_CODITE').AsString)
                                           .CodEmp(VS_strCodEmp)
                                           .Faturamento(True)
                                         ).Total();
      End;

      If (FieldByName('FDO_PROACA').AsString = 'S') Then
      Begin
        fltSaldoVer := TProdAcabado.fRetornaSaldo(FieldByName('FDO_CODACA').AsString,
                                                  FieldByName('FDO_EMPACA').AsString,
                                                  FieldByName('FDO_CODEMP').AsString);
      End;

      If (fltQtdIte <= 0.0) Then
      Begin
        Next;
        Continue;
      End;

      strCodigo := FieldByName('FDO_CODITE').AsString +
                   FieldByName('FDO_ENTFUT').AsString +
                   FieldByName('FDO_NUMLOT').AsString;

      If ((FieldByName('FDO_ENTFUT').AsString <> 'S') Or (FieldByName('FDO_MOTFUT').AsString <> 'F')) And
         (Pos('ITEM ESPECIAL', FieldByName('ITE_DESITE').AsString) <= 0) Then
      Begin
        If FieldByName('FDO_IDEPRO').AsString = 'NOR' Then
        Begin
          fltSaldoRes := TSaldoReservado.New(
                           TReservaParametros.New()
                             .EmpresaItem(IIF(blnEmpFat, FieldByName('FDO_EMPITE').AsString, ''))
                             .CodigoItem(AnsiLeftStr(strCodigo, 5))
                             .CodEmpresa(VS_strCodEmp)
                             .CodItemAcabado(FieldByName('FDO_CODACA').AsString)
                             .EmpItemAcabado(FieldByName('FDO_EMPACA').AsString)
                             .NumeroLote(FieldByName('FDO_NUMLOT').AsString)
                             .NumeroDocumento(strNumDoc)
                             .TipoFiltroDocumento(tfdIgnorarDocumento)
                           ).fGetQuantidade();

          objDicSal[strCodigo] := fltSaldoVer - fltSaldoRes;

          If stlItens.IndexOf(strCodigo) = -1 Then
          Begin
            stlItens.Add(strCodigo);
            objDicQtd[strCodigo] := fltQtdIte;
          End
          Else
            objDicQtd[strCodigo] := objDicQtd[strCodigo] + fltQtdIte;
        End;

      End;

      Next;
    End;

    strItens := '';
    For intContador := 0 To stlItens.Count - 1 Do
    Begin
      blnIteEntFut := stlItens[intContador][6] = 'S';

      If Pos(fTravaSaldoVN(False, blnIteEntFut), 'A_T_') > 0 Then
      Begin

        If objDicQtd[stlItens[intContador]] > objDicSal[stlItens[intContador]] Then
        Begin
          If not (blnIteEntFut) Then
            blnTravarItemNormal := True;

          blnMostraItens := True;
          strItens := strItens + '_' + stlItens[intContador];
        End;
      End;

    End;

  End;

  If blnMostraItens Then
  With qryGenDor Do
  Begin

    IndexFieldNames := 'FDO_CODITE;FDO_NUMLOT';

    Try
      pCriarFormularios(TfrmFatMostraProdSemSaldo, frmFatMostraProdSemSaldo);
      frmFatMostraProdSemSaldo.pAbreClientItens;
      blnItemNormalSemEstoque := True;

      objTabela := TRegistroMsgLiberaTabela.Create;

      First;
      While Not Eof Do
      Begin

        strCodigo := FieldByName('FDO_CODITE').AsString + FieldByName('FDO_NUMLOT').AsString;

        If Pos(strCodigo, strItens) > 0 Then
        Begin
          If objTabela.isEmpty then
          Begin
            objLinha := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlCabecalho;
            objLinha.pAddColuna('', 'Código'     , 7 , alEsquerda, teAutcom);
            objLinha.pAddColuna('', 'Descrição'  , 40, alEsquerda, teAutcom);
            objLinha.pAddColuna('', 'Quantidade' , 12, alEsquerda, teAutcom);
            objLinha.pAddColuna('', 'Saldo Disp.', 12, alEsquerda, teAutcom);
            objTabela.lstLinhas.Add(objLinha);
          End;

          objLinha := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('Código'     , FieldByName('FDO_CODITE').AsString, 7 , alCentro  , teAmbos);
          objLinha.pAddColuna('Descrição'  , FieldByName('ITE_DESITE').AsString, 40, alEsquerda, teAmbos);
          objLinha.pAddColuna('Quantidade' , FormatFloat('#,##0.00', FieldByName('FDO_QTDITE').AsFloat - FieldByName('FDO_QTDBAI').AsFloat), 12, alDireita , teAmbos);
          objLinha.pAddColuna('Saldo Disp.', FormatFloat('#,##0.00', IfNull(objDicSal[FieldByName('FDO_CODITE').AsString + FieldByName('FDO_NUMLOT').AsString], 0)), 12, alDireita , teAmbos);
          objTabela.lstLinhas.Add(objLinha);

          If frmFatMostraProdSemSaldo.cdsItens.Locate('ITE_CODITE;ITE_NUMLOT',
                VarArrayOf([FieldByName('FDO_CODITE').AsString, FieldByName('FDO_NUMLOT').AsString]), []) Then
          Begin
            frmFatMostraProdSemSaldo.cdsItens.Edit;
            frmFatMostraProdSemSaldo.cdsItens.FieldByName('ITE_QTDITE').AsFloat :=
              frmFatMostraProdSemSaldo.cdsItens.FieldByName('ITE_QTDITE').AsFloat +
              FieldByName('FDO_QTDITE').AsFloat - FieldByName('FDO_QTDBAI').AsFloat;
          End Else
          Begin
            frmFatMostraProdSemSaldo.cdsItens.Append;
            frmFatMostraProdSemSaldo.cdsItens.FieldByName('ITE_CODITE').AsString := FieldByName('FDO_CODITE').AsString;
            frmFatMostraProdSemSaldo.cdsItens.FieldByName('ITE_DESITE').AsString := FieldByName('ITE_DESITE').AsString;
            frmFatMostraProdSemSaldo.cdsItens.FieldByName('ITE_NUMLOT').AsString := FieldByName('FDO_NUMLOT').AsString;
            frmFatMostraProdSemSaldo.cdsItens.FieldByName('ITE_SALDOS').Value    := objDicSal[FieldByName('FDO_CODITE').AsString +
                                                                                    FieldByName('FDO_NUMLOT').AsString];

            frmFatMostraProdSemSaldo.cdsItens.FieldByName('ITE_QTDITE').AsFloat :=
              FieldByName('FDO_QTDITE').AsFloat - FieldByName('FDO_QTDBAI').AsFloat;
          End;

          frmFatMostraProdSemSaldo.cdsItens.Post;
        End;

        Next;
      End;

      frmFatMostraProdSemSaldo.showModal;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmFatConfPedidos.fTrataSaldo]');
    End;

    pFreeAndNil(frmFatMostraProdSemSaldo);

    If (blnItemNormalSemEstoque)  Then
    Begin
      If (fTravaSaldoVN(False, Not blnTravarItemNormal) = 'T') And    
         (Not (fCfgSis('VSEORC', varBoolean) And (fatVenda.strOpcDoc = 'VN'))) Then
      Begin
        objMsg := TMensagemLiberacao.Create(Self);
        try
          objMsg.pAddTexto('Produto(s) sem saldo disponível');

          If Not objTabela.isEmpty Then
            objMsg.lstRegistros.Add(objTabela)
          Else
            FreeAndNil(objTabela);

          If (Not fSenhaLiberacaoSemSaldoVN('', '', strNtrava, Nil, objMsg, '', TRUE, 'OU', False, False)) Then
            Result := False;
        finally
          FreeAndNil(objMsg);
        end;
      End;

    End;

  End;

  FreeAndNil(stlItens);
  FreeAndNil(objDicQtd);
  FreeAndNil(objDicSal);
  FreeAndNil(qryGenDor);
  FreeAndNil(objCadLot);
end;

function TfrmFatConfPedidos.fTemp(strCampo: String; blnComTmp: Boolean = True): TField;
begin
  Result := fatVenda.qryTemporariaConfirmacao.FieldByName(IIF(blnComTmp, 'TMP_','') + strCampo);
end;

end.
