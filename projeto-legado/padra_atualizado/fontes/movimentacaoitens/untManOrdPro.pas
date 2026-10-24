{*********************************************************}
{* MANUTENÇÃO DE ORDEM DE PRODUÇÃO                       *}
{*                                                       *}
{* DATA......: 17/10/2007                                *}
{* AUTOR.....: ALEXANDRE OLIVEIRA FERRI "FALTA MUITO???" *}
{*                                                       *}
{******************************************************AF*}
unit untManOrdPro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, DBEditFocus, untOrdPro, DB, EditFocus, Uni, AppEvnts, untTLock,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, strUtils, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, untZClient;

type
  TfrmManOrdPro = class(TfrmPaiCad)
    pnlFundo: TPanel;
    bvlCodigo: TBevel;
    dbeCodigo: TDBEditFocus;
    lblCodigo: TLabel;
    dtsOrdPro: TDataSource;
    lblCadastro: TLabel;
    dbeDtaCad: TDBEditFocus;
    lblBaixa: TLabel;
    dbeDtaBai: TDBEditFocus;
    btnImprimir: TBitBtnLocked;
    pnlObs: TPanel;
    lblObserv: TLabel;
    dbeObs001: TDBEditFocus;
    dbeObs002: TDBEditFocus;
    pnlDados: TPanel;
    lblProduto: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    dbeCodPro: TDBEditFocus;
    edtDesProduto: TEditFocus;
    dbeQtdApr: TDBEditFocus;
    dbeDtaPro: TDBEditFocus;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtEmpDoc: TEditFocus;
    pnlSequen: TPanel;
    Label6: TLabel;
    dbeSequen: TDBEditFocus;
    btnConsultaOrdens: TBitBtnLocked;
    btnExibir: TBitBtnLocked;
    lblCodFabrica: TLabel;
    edtCodFab: TEditFocus;
    tbsFases: TTabSheet;
    cxgCadFas: TcxGrid;
    cxgCadFasView: TcxGridDBTableView;
    cxgCadFasCODIGO: TcxGridDBColumn;
    cxgCadFasDESFAS: TcxGridDBColumn;
    cxgCadFasSEQUEN: TcxGridDBColumn;
    cxgCadFasSTATUS: TcxGridDBColumn;
    cxgCadFasLevel1: TcxGridLevel;
    ChkDataPrev: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure dbeCodProKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpDocKeyPress(Sender: TObject; var Key: Char);
    procedure btnConsultaOrdensClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnExibirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure dbeDtaProEnter(Sender: TObject);
    procedure dbeCodProExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    objLock: TLock;
    objOrdPro: TOrdPro;
    strCodIte: String;
    blnValidouQuantidade,
    blnSalvandoItens: Boolean;
    DataPrev: TDate;
    OldQuant: Currency;
    bStatusEdit: Boolean;
    cdsCadFas: TZClient;
    blnMONFAS: Boolean;

    function fOrdemProducaoSendoUsada: Boolean;
    procedure pCarregaProduto;
    procedure pAfterScroll(DataSet: TDataSet);
    function fVerificaSeHouveBaixaParcial: Boolean;
    function fCarregaItensTmp(strCodIte, strDesIte: String; blnApenasValida : boolean = False; blnApenasCarregaOrdPro: Boolean = False) : Boolean;
    procedure pLimpaPedido;
    procedure pSetPedido;
    function fGetSQLFases: String;
    function fCarregaFases(AStrCodIte, AStrCodOrd: String): Boolean;

  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
    procedure pOnStateChange;override;
    procedure pSetFgo;
  end;

implementation

uses untfuncoesSimples, untPai, untTypesSistema, untOrdProItensEstrut, untOpcImpOrdPro,
  untConsultas, TypesRel, untExibeArvoreOrdProd,  untIFatReservaSaldo,
  untTFatReservaSaldo, untFuncoesRel, untFuncoesRel2;

{$R *.dfm}

procedure TfrmManOrdPro.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmManOrdPro.FormCreate(Sender: TObject);
begin

  inherited;
  objLock   := TLock.Create;
  objOrdPro := TOrdPro.Create(Self, False);
  qryTabela := objOrdPro.qryOrdPro;
  dtsOrdPro.DataSet := qryTabela;
  OldQuant  := 0.00;

  qryTabela.AfterScroll := pAfterScroll;

  if not fCfgSis('SEQORD', varBoolean) then
  begin
    pnlSequen.Visible := False;
    Self.Height := Self.Height - pnlSequen.Height;
  end;

  strNomeTabela := 'MOVPRO';
  strNomeCampo  := 'PRO_CODPRO';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  blnSalvandoItens := False;

  blnMONFAS := fCfgSis('MONFAS', varBoolean);
end;

procedure TfrmManOrdPro.FormDestroy(Sender: TObject);
begin
  If Assigned(objLock) Then
  Begin
    objLock.pDestravarTodos;
    FreeAndNil(objLock);
  End;
  FreeAndNil(objOrdPro);
  If Assigned(cdsCadFas) Then
    FreeAndNil(cdsCadFas);

  inherited;
end;

procedure TfrmManOrdPro.FormShow(Sender: TObject);
begin
  inherited;
  pSetaCodIte( dbeCodPro );
end;

procedure TfrmManOrdPro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key of
  VK_F1: if pnlSequen.Visible then
           btnConsultaOrdens.click;
  end;
end;

procedure TfrmManOrdPro.dbeCodProExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(dbeCodPro.Text) Then
    fValidaCampos(dbeCodPro, True);
end;

procedure TfrmManOrdPro.dbeCodProKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    Try
      fPesqEstrutura(Self, dbeCodPro, nil, Key, arrSel, True);
      fValidaCampos(dbeCodPro, True);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmManOrdPro.dbeCodProKeyPress]');
      End;
    End;
  End;

end;

procedure TfrmManOrdPro.dbeDtaProEnter(Sender: TObject);
begin
  inherited;
  OldQuant:= dbeQtdApr.Field.Value;
end;

procedure TfrmManOrdPro.edtEmpDocKeyPress(Sender: TObject; var Key: Char);
Var
    arrEmp: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtEmpDoc, nil, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtEmpDoc, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmManOrdPro.edtNumDocKeyPress(Sender: TObject; var Key: Char);
var
  qryPedido : TUniQuery;
  arrPedido : TConsultasArray;
begin
  inherited;
  qryPedido := fCriaQuery(nil);
  try
    if fPesqPedOrc(conPedSimpMultEmp, Self, 'PD', '', '' ,edtNumDoc, edtEspDoc, edtEmpDoc, qryPedido, Key, arrPedido) then
    begin
      If fValidaCampos(edtNumDoc, True) Then
        if pnlSequen.Visible then
          pSetFocus(dbeSequen)
        else
          pSetFocus(dbeObs001);
    end;
  finally
    FreeAndNil(qryPedido);
  end;
end;

procedure TfrmManOrdPro.pCarregaProduto;
Begin
  If qryTabela.FieldByName('PRO_PROJEC').AsString <> '' Then
    edtDesProduto.Text := fRetNomProduto(dbeCodPro.Text)
  Else If fItemEstrutura(dbeCodPro.Text) And IsItemAtivo(dbeCodPro.Text) Then
    edtDesProduto.Text := fRetNomProduto(dbeCodPro.Text)
  Else
    edtDesProduto.Clear;

  If Not fEmptyStr(dbeCodPro.Text) Then
    edtCodFab.Text := fRetCodFabrica(dbeCodPro.Text)
  Else
    edtCodFab.Text := '';
End;

function TfrmManOrdPro.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  {**************************************}
  {* VALIDA CODIGO DO PRODUTO           *}
  {***********************************AF*}
  If (Sender = dbeCodPro) Then
  Begin

    If fEmptyStr(dbeCodPro.Text) Then
    Begin
      fMensagem('','O campo código do produto deve ser preenchido!',['&OK']);
      Result := False;
    End
    Else
    Begin
      pCarregaProduto;

      If fEmptyStr(edtDesProduto.Text) Then
      Begin
        fMensagem('','O produto não foi encontrado!',['&OK']);
        Result := False;
      End;

    End;
  End

  {**************************************}
  {* VALIDA QTD A PRODUZIR              *}
  {***********************************AF*}
  Else If (Sender = dbeQtdApr) Then
  Begin

    If fEmptyStr(dbeQtdApr.Text) Then
    Begin
      fMensagem('','O campo quantidade deve ser preenchido!',['&OK']);
      Result := False;
    End

    Else If fStrToFloat(dbeQtdApr.Text) <= 0  Then
    Begin
      fMensagem('','O campo quantidade deve ser maior que zero!',['&OK']);
      Result := False;
    End

    Else If qryTabela.FieldByName('PRO_QTDPRO').AsFloat > fStrToFloat(dbeQtdApr.Text) Then
    Begin
      fMensagem('','O campo quantidade deve ser maior que a quantidade baixada: (' + FloatToStrF(qryTabela.FieldByName('PRO_QTDPRO').AsFloat,ffFixed,12,fCfgSis('DECQTD', varInteger)) + ')!' ,['&OK']);
      Result := False;
    End

    Else If (Not blnSalvandoItens) or (Not blnValidouQuantidade)  then
    Begin


      if blnBuscaPorChave Or (Not blnValidouQuantidade)  then
      begin
        If (Not fEmptyStr(dbeCodPro.Text)) and (not fEmptyStr(edtDesProduto.Text)) and (fStrToFloat(dbeQtdApr.Text) > 0) Then
        begin
          if fCarregaItensTmp(dbeCodPro.Text, edtDesProduto.Text) then
          begin
            blnMudarFoco := False;
            SelectNext(ActiveControl, True, True);
          end
          else
            btnCancela.Click;
          blnValidouQuantidade := True;
        end;
      end;

    End;

  End

  {**************************************}
  {* O CAMPO DATA DE PRODUÇÃO DEVE SER  *}
  {* PREENCHIDO                         *}
  {***********************************AF*}
  Else If (Sender = dbeDtaPro) Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(dbeDtaPro.Text)) Then
    Begin
      fMensagem('','O campo data de produção deve ser preenchido deve ser preenchido!',['&OK']);
      Result := False;
    End

    Else If StrToDateDef(dbeDtaCad.Text,0) > StrToDateDef(dbeDtaPro.Text,0) Then
    Begin
      fMensagem('','O campo data de produção deve ser maior ou igual a data de cadastro!',['&OK']);
      Result := False;
    End

    Else if pnlSequen.visible then
    begin
      if blnBuscaPorChave  then
        if (qryTabela.State in [dsInsert]) or (qryTabela.FieldByName('PRO_DTAPRO').oldValue <> qryTabela.FieldByName('PRO_DTAPRO').AsDateTime) then
          qryTabela.FieldByName('PRO_SEQUEN').AsInteger := StrToIntDef(fCampoTabela('MAX(PRO_SEQUEN)', 'MOVPRO', ['PRO_DTAPRO', 'PRO_CODEMP'], [StrToDate(dbeDtaPro.Text), VS_strCodEmp]), 0) +1
    end;

  End

  Else If (Sender = edtNumDoc) Then
  Begin

    If fEmptyStr(edtNumDoc.Text) Then
    begin
      pLimpaPedido;
      blnMudarFoco := False;
      if pnlSequen.Visible then
        pSetFocus(dbeSequen)
      else
        pSetFocus(dbeObs001);
    end
    else begin
      if fCampoTabela('COUNT(0)', 'FATGOR', ['FGO_NUMDOC'], [edtNumDoc.Text]) = '0' then
      begin
        fMensagem('', 'Número do documento não encontrado!',['&OK']);
        Result := False;
      end
      else
      begin
        edtEspDoc.Text := 'PD';
        if blnBuscaPorChave and fEmptyStr(edtEmpDoc.Text) then
          edtEmpDoc.Text := VS_strCodemp;

        pSetFgo;
        blnMudarFoco := False;
        pSetFocus(edtEmpDoc);
      end;
    end;

  End

  Else If (Sender = edtEmpDoc) Then
  Begin
    If (not fEmptyStr(edtNumDoc.Text)) or (not fEmptyStr(edtEmpDoc.Text)) then
    begin
      if fEmptyStr(edtEmpDoc.Text)Then
      begin
        fMensagem('','O código da empresa do pedido deve ser preenchido!',['&OK']);
        Result := False;
      end
      else
      begin
        pSetFgo;
        if qryTabela.FieldByName('PRO_NUMPED').IsNull or
           qryTabela.FieldByName('PRO_ESPPED').IsNull or
           qryTabela.FieldByName('PRO_EMPPED').IsNull then
        begin
          fMensagem('','Pedido de Venda Inválido!',['&OK']);
          Result := False;
        end;
      end;
    end;

  End

  Else If (Sender = dbeSequen) Then
  Begin
    if pnlSequen.Visible then
    begin
      If fStrToFloat(dbeSequen.Text) <= 0 Then
      begin
        fMensagem('','O campo sequencial de execução deve ser maior que zero!',['&OK']);
        Result := False;
      End
    end;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmManOrdPro.pInicializaIndices;
begin
  inherited;
  //
end;

procedure TfrmManOrdPro.pLimpaPedido;
begin
  edtNumDoc.Text := '';
  edtEspDoc.Text := '';
  edtEmpDoc.Text := '';
end;

procedure TfrmManOrdPro.pOnStateChange;
begin
  inherited;
  btnImprimir.Enabled := not (qryTabela.State in DsEditModes);
end;

procedure TfrmManOrdPro.pSetPedido;
 begin

  pLimpaPedido;

  edtNumDoc.Text := qryTabela.FieldByName('PRO_NUMPED').AsString;
  edtEspDoc.Text := qryTabela.FieldByName('PRO_ESPPED').AsString;
  edtEmpDoc.Text := qryTabela.FieldByName('PRO_EMPPED').AsString;

end;

procedure TfrmManOrdPro.pSetFgo;
begin
  If (qryTabela.State = dsInsert) or (qryTabela.State = dsEdit) then
  Begin
    qryTabela.FieldByName('PRO_NUMPED').AsString := edtNumDoc.Text;
    if fEmptyStr(qryTabela.FieldByName('PRO_NUMPED').AsString) then
      qryTabela.FieldByName('PRO_NUMPED').Clear;

    qryTabela.FieldByName('PRO_ESPPED').AsString := edtEspDoc.Text;
    if fEmptyStr(qryTabela.FieldByName('PRO_ESPPED').AsString) then
      qryTabela.FieldByName('PRO_ESPPED').Clear;

    qryTabela.FieldByName('PRO_EMPPED').AsString := edtEmpDoc.Text;
    if fEmptyStr(qryTabela.FieldByName('PRO_EMPPED').AsString) then
      qryTabela.FieldByName('PRO_EMPPED').Clear;
  End;

end;

procedure TfrmManOrdPro.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
    intOpcStatus : integer;
begin
  chrKey := '/';

  intOpcStatus := fMensagem('','Selecione o status da ordem de produção:', ['Abertas', 'Baixadas', 'Todas'], 1);
  fPesqOrdemProd(conSimples,
                 Self,
                 nil,
                 nil,
                 qryTabela,
                 chrKey,
                 arrSel,
                 '',
                 True,
                 'Consulta Ordens de Produção',
                 intOpcStatus);

  edtCodFab.Text := fRetCodFabrica(dbeCodPro.Text);

  If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
    pSetFocus(btnAlterar);
  OldQuant  := 0.00;

  If blnMONFAS Then
    fCarregaFases(dbeCodPro.Text, dbeCodigo.Text);
end;

procedure TfrmManOrdPro.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnValidouQuantidade := False;
  If (qryTabela.State = dsInsert) Then
  Begin
    dbeCodPro.Enabled := True;
    bStatusEdit:= False;
    OldQuant   := 0.00;

    If blnUsaProCodigo Then
      pHabilitaCodigo(dbeCodigo, dbeCodPro, False)
    Else
      pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

    if ChkDataPrev.Checked then
      dbeDtaPro.Field.Value := DataPrev;

    dbeDtaCad.Field.Value := VS_Date;

    dbeQtdApr.Field.Value := 0;

  End;

end;

procedure TfrmManOrdPro.btnAlterarClick(Sender: TObject);
begin
  If fOrdemProducaoSendoUsada Then
    Exit;

  inherited;

  blnValidouQuantidade := False;
  bStatusEdit:= True;
  strCodIte := qryTabela.FieldByName('PRO_CODITE').AsString;
  pHabilitaCodigo(dbeCodigo, dbeQtdApr, False);
  fCarregaItensTmp(dbeCodPro.Text, edtDesProduto.Text, False, True);
end;

procedure TfrmManOrdPro.btnImprimirClick(Sender: TObject);
var
  blnRefere      : Boolean;
  intUltimaLinha : Integer;
begin
  inherited;
  If Not qryTabela.IsEmpty Then
  Begin

    If (not MatchStr(fCfgSis('MLAYOP', varString), ['4','5','6'])) and (fCampoTabela('COUNT(0)', 'LAYGMT', ['LAY_CODITE'], [dbeCodPro.Text]) = 0) and (fCampoTabela('COUNT(0)','LAYETI',['LAY_TIPLAY', 'LAY_PADRAO'],[ARR_TIPO_LAYOUT[tpeOrdPro], 'S']) = 0) Then
    Begin
      pCriarFormularios(TfrmOpcImpOrdPro, frmOpcImpOrdPro);
      frmOpcImpOrdPro.ShowModal;
      If (frmOpcImpOrdPro.ModalResult = mrOk) Then
      Begin
        blnRefere := frmOpcImpOrdPro.rdbReferenc.Checked;
        intUltimaLinha := 0;
        objOrdPro.pImprimeOrdPro(dbeCodigo.Text, intUltimaLinha, blnRefere);
      End;

      pFreeAndNil(frmOpcImpOrdPro);
    End
    Else
    Begin
      intUltimaLinha := 0;
      objOrdPro.pImprimeOrdPro(dbeCodigo.Text, intUltimaLinha, False);
    End;
  End
  Else
    fMensagem('','Não há dados para gerar relatório!',['&OK']);
end;

function TfrmManOrdPro.fVerificaSeHouveBaixaParcial: Boolean;
Begin
  Result:= (qryTabela.FieldByName('PRO_QTDPRO').AsFloat >= 1) AND
           (qryTabela.FieldByName('PRO_QTDPRO').AsFloat < qryTabela.FieldByName('PRO_QTDAPR').AsFloat);
End;

procedure TfrmManOrdPro.pAfterScroll(DataSet: TDataSet);
Begin

  If Not dbeDtaBai.Field.IsNull Then
  Begin
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End
  Else
  Begin
    btnAlterar.Enabled := True;
     btnExcluir.Enabled := (Not(fVerificaSeHouveBaixaParcial));
  End;

  If fEmptyStr(dbeCodPro.Text) Then
    edtDesProduto.Clear
  Else
    edtDesProduto.Text := fRetNomProduto(dbeCodPro.Text);

  pSetPedido;

   (qryTabela.FieldByName('PRO_QTDAPR') As TFloatField).EditFormat    := fMskDigitos( fCfgSis('DECQTD', varInteger) );
  (qryTabela.FieldByName('PRO_QTDAPR') As TFloatField).DisplayFormat := fMskDigitos( fCfgSis('DECQTD', varInteger) );
  (qryTabela.FieldByName('PRO_DTAPRO') As TDateField).EditMask       := '99/99/9999';

End;

procedure TfrmManOrdPro.btnGravarClick(Sender: TObject);
  Var
    strOrdPro: String;
    strCodEmp: String;
    blnInserindo: Boolean;
begin
  blnSalvandoItens := True;
  blnInserindo := qryTabela.State = dsInsert;
  try
    If Not fValidacoesBotaoGravarPai Then
      Exit;

    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

    If (OldQuant <> dbeQtdApr.Field.Value) or (bStatusEdit) and (OldQuant = 0.00) then
    Begin
      If not fCarregaItensTmp(dbeCodPro.Text, edtDesProduto.Text, True) Then
        Exit;
    End
    Else
    If ((bStatusEdit) and (OldQuant = 0.00)) then
    Begin
      If not fCarregaItensTmp(dbeCodPro.Text, edtDesProduto.Text, True) Then
        Exit;
    End;


    If qryTabela.FieldByName('PRO_QTDPRO').AsFloat = fStrToFloat(dbeQtdApr.Text) Then
    Begin
      If fMensagem('','A ordem de produção será baixada! Continuar?', ['&Sim','&Não']) = 2 Then
        Exit
      Else
        dbeDtaBai.Field.Value := VS_Date;
    End;

    if Not(dbeDtaPro.Field.IsNull) Then
      DataPrev:= dbeDtaPro.Field.Value;

    if blnInserindo And (fEmptyStr(qryTabela.FieldByName('PRO_CODCLI').AsString)) then
    begin
      If fEmptyStr(fCfgSis('CLIOPR', varString)) Then
      Begin
        fMensagem('','A configuração [CFG_CLIOPR] deve estar definida para setar um cliente para esta ordem de produção!',['&OK']);
        Exit;
      End;
      qryTabela.FieldByName('PRO_CODCLI').AsString := fCfgSis('CLIOPR', varString);
    end;

    Try
      If (qryTabela.State = dsEdit) And (strCodIte <> qryTabela.FieldByName('PRO_CODITE').AsString) Then
      Begin
        strOrdPro := qryTabela.FieldByName('PRO_CODPRO').AsString;
        strCodEmp := qryTabela.FieldByName('PRO_CODEMP').AsString;
        qryTabela.FieldByName('PRO_NUMDOC').AsString := '';

        TOrdPro.pLimpaOrdProDoPedido(strOrdPro, '','', strCodEmp);
      End;

      OldQuant  := 0.00;

      if not objOrdPro.fAjustaSequencialDia then
      begin
        fRollBack;
        exit;
      end;

      inherited;

      //*************************************************//
      // EFETUA A GRAVACAO DOS ARQUIVOS DETALHADOS       //
      //**********************************************ED*//
      objOrdPro.fGravaDetOrdPro(qryTabela.FieldByName('AUTOINCREM').AsString);

      ReprocessarItem(qryTabela.FieldByName('PRO_CODITE').AsString, '', False);

      If blnMONFAS And blnInserindo Then
        objOrdPro.fGravarFasesDaOrdem(qryTabela.FieldByName('AUTOINCREM').AsString, qryTabela.FieldByName('PRO_CODITE').AsString);

      If blnGravou Then
        fCommit
      Else
        fRollBack;

    Except
      fRollBack;
    End;

    pAfterScroll(Nil);
  finally
    blnSalvandoItens := False;

    If Not btnGravar.Enabled Then
      objLock.pDestravarTodos;
  end;

end;


//*************************************************//
// CRIA UMA TEMPORARIA COM OS ITENS DO CAD. ESTRUT //
//**********************************************ED*//
function TfrmManOrdPro.fCarregaItensTmp(strCodIte, strDesIte: String; blnApenasValida : boolean = False; blnApenasCarregaOrdPro: Boolean = False) : Boolean;
  Var
    blnAlteracao: Boolean;
    strCodPro: String;
begin

  Try
    dbeCodPro.Enabled := False;

    If (qryTabela.State <> dsInsert) Then
    Begin
      blnAlteracao := True;
      strCodPro := qryTabela.FieldByName('PRO_CODPRO').AsString;
    End
    Else
    Begin
      blnAlteracao := False;
      strCodPro := dbeCodPro.Text;
    End;

    If not blnApenasValida Then
      objOrdPro.pCriaTemporaria(blnAlteracao, strCodPro);

    pCriarFormularios(tfrmOrdProItensEstrut, frmOrdProItensEstrut);
    frmOrdProItensEstrut.objOrdPro            := objOrdPro;
    frmOrdProItensEstrut.edtProdutos.Text     := strCodIte;
    frmOrdProItensEstrut.edtDesProduto.Text   := strDesIte;
    frmOrdProItensEstrut.edtCodFab.Text       := fRetCodFabrica(strCodIte);
    frmOrdProItensEstrut.edtReferencia.Text   := fRetReferenciaProd(strCodIte);
    frmOrdProItensEstrut.edtUnidade.Text      := fRetUnidadeItem(strCodIte);
    frmOrdProItensEstrut.fltQtdApr            := fStrToFloat(dbeQtdApr.Text);
    frmOrdProItensEstrut.strCodPro            := strCodPro;
    frmOrdProItensEstrut.blnApenasValida      := blnApenasValida;
    frmOrdProItensEstrut.blnStateDataSetInsertEdit:= (qryTabela.State in [dsInsert, DsEdit]);

    If Not blnApenasCarregaOrdPro Then
    Begin
      frmOrdProItensEstrut.pChecaQuantProdutoDisponivel;
      if frmOrdProItensEstrut.PossuiSaldo Then
        frmOrdProItensEstrut.ShowModal;

    End;

    Result := frmOrdProItensEstrut.blnConfirma Or blnApenasCarregaOrdPro;

    If blnMONFAS Then
      Result := Result And fCarregaFases(strCodIte, strCodPro);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[frmManOrdPro.pCarregaItensTmp]');
    End;
  End;

  pFreeAndNil(frmOrdProItensEstrut);

end;

function TfrmManOrdPro.fOrdemProducaoSendoUsada: Boolean;
begin
  Result := False;
  
  If (Not fEmptyStr(dbeCodigo.Text)) Then
  Begin
    If Not objLock.fLock_Unlock('ORDPRO_' + dbeCodigo.Text + '_' + VS_strCodEmp, True, False) Then
    Begin
      fMensagem('', 'Esse documento está sendo utilizado em outra estação por ' +
                    fGetHostLock('ORDPRO_' + dbeCodigo.Text + '_' + VS_strCodEmp) + '!', ['&Ok']);
      Result := True;
    End;
  End;
end;

procedure TfrmManOrdPro.btnCancelaClick(Sender: TObject);
begin
  If (btnGravar.Enabled) And (Assigned(objLock)) Then
    objLock.pDestravarTodos;

  inherited;

  pAfterScroll(qryTabela);
end;

procedure TfrmManOrdPro.btnConsultaOrdensClick(Sender: TObject);
begin

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(83, 5386, [],
                        ['CODEMP'],
                        [VS_strCodEmp],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmManOrdPro.btnExcluirClick(Sender: TObject);
  Var
    strCodPro: String;
    strCodEmp: String;
begin
  If Not btnExcluir.Visible Then
    Exit;

  If qryTabela.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If fOrdemProducaoSendoUsada Then
    Exit;

  If fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 2 Then
    Exit;

  strCodPro := qryTabela.FieldByName('PRO_CODPRO').AsString;
  strCodEmp := qryTabela.FieldByName('PRO_CODEMP').AsString;

  Try
    qryTabela.Close;

    fStartTransaction;
    TOrdPro.fExcluirOrdemProducao(strCodPro, strCodEmp, Self.Name, strLoginUsuarioLogado);
    fCommit;

    qryTabela.Open;
    pCarregaProduto;
    pSetPedido;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '');
    End;
  End;

end;

procedure TfrmManOrdPro.btnExibirClick(Sender: TObject);
begin
  if not fEmptyStr(qryTabela.FieldByName('PRO_CODPRO').AsString) then
    TfrmExibeArvoreOrdProd.pExibeArvore(qryTabela.FieldByName('PRO_CODPRO').AsString)
  Else
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
end;

function TfrmManOrdPro.fGetSQLFases: String;
begin
  Result := '';
  Result := Result + 'SELECT                                                                ';
  Result := Result + ' FASGER.AUTOINCREM,                                                   ';
  Result := Result + ' FAS_CODIGO,                                                          ';
  Result := Result + ' FAS_SEQUEN,                                                          ';
  Result := Result + ' FAS_DESFAS,                                                          ';
  Result := Result + ' (CASE                                                                ';
  Result := Result + '   WHEN MNTORD.AUTOINCREM IS NULL THEN "Não iniciada"                 ';
  Result := Result + '   WHEN (MNT_DTAINI IS NOT NULL) AND (MNT_DTAFIN IS NULL) THEN "Não finalizada" ';
  Result := Result + '   ELSE "Finalizada"                                                  ';
  Result := Result + '  END) AS FAS_STATUS                                                  ';
  Result := Result + ' FROM FASMAT                                                          ';
  Result := Result + '  INNER JOIN FASGER ON MAT_SEQFAS = FASGER.AUTOINCREM                 ';
  Result := Result + '  INNER JOIN GERMAT ON MAT_SEQMAT = GERMAT.AUTOINCREM                 ';
  Result := Result + '                   AND GMT_CODITE = :CODITE                           ';
  Result := Result + '  LEFT JOIN MOVPRO ON PRO_CODPRO = :CODORD                            ';
  Result := Result + '  LEFT JOIN MNTORD ON MNT_SEQFAS = FASGER.AUTOINCREM                  ';
  Result := Result + '                  AND MNT_SEQORD = MOVPRO.AUTOINCREM                  ';
  Result := Result + ' WHERE TRUE                                                           ';
  Result := Result + '   AND MAT_CODEMP = :CODEMP                                           ';
  Result := Result + ' GROUP BY FASGER.AUTOINCREM                                           ';
  Result := Result + ' ORDER BY FAS_SEQUEN                                                  ';
end;

function TfrmManOrdPro.fCarregaFases(AStrCodIte, AStrCodOrd: String): boolean;
begin
  cdsCadFas := TZClient.Create(Self, fGetSQLFases);
  cdsCadFas.qryQuery.ParamByName('CODITE').AsString := AStrCodIte;
  cdsCadFas.qryQuery.ParamByName('CODORD').AsString := AStrCodOrd;
  cdsCadFas.qryQuery.ParamByName('CODEMP').AsString := VS_StrCodEmp;
  Result := cdsCadFas.fAbreClient(True, 'TfrmManOrdPro.fCarregaFases');
  cdsCadFas.IndexFieldNames := 'FAS_SEQUEN';

  cxgCadFasView.DataController.DataSource := cdsCadFas.dtsSource;

  tbsFases.TabVisible := Not cdsCadFas.isEmpty;
end;

end.

