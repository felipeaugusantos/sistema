unit untGarantiaEnvCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids, DB,
  UniClientDataSet, Mask, MaskEditFocus, EditFocus, untGarant, Uni, DBCtrls, DBEditFocus,
  AppEvnts, frxClass, frxDMPExport, frxDBSet, BitBtnLockedIncrem, untZClient, untFuncFat,
  frxExportCSVTestabilidade, Datasnap.DBClient, strUtils, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, cxGridBandedTableView,
  cxProgressBar,
  untTProgressBarFacade,
  System.UITypes,
  untControleChavesGarantia,
  cxGridDBBandedTableView, cxTextEdit;


type
  TfrmGarantiaEnvCliente = class(TfrmPai, IProgressBarGenerico)
    pnlFiltroCliente: TPanel;
    Label1: TLabel;
    cdsProdutos: TUniClientDataSet;
    cdsProdutosCODITE: TStringField;
    cdsProdutosDESITE: TStringField;
    cdsProdutosUNIDAD: TStringField;
    cdsProdutosQTDREQ: TFloatField;
    cdsProdutosQTDRET: TFloatField;
    cdsProdutosQTDDEV_1: TFloatField;
    cdsProdutosQTDPRE_1: TFloatField;
    cdsProdutosQTDREF: TFloatField;
    cdsProdutosAUTINC: TStringField;
    cdsProdutosNUMENT: TStringField;
    cdsProdutosCODVEN: TStringField;
    cdsProdutosCODCLI: TStringField;
    cdsProdutosCODFOR: TStringField;
    cdsProdutosAGG_QTDDEV_1: TAggregateField;
    cdsProdutosAGG_QTDPRE_1: TAggregateField;
    dtsProdutos: TDataSource;
    cdsProdutosQTDDEV: TFloatField;
    cdsProdutosQTDPRE: TFloatField;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    cdsProdutosDTADEV: TDateTimeField;
    cdsProdutosOBSF_1: TStringField;
    cdsProdutosOBSF_2: TStringField;
    cdsProdutosOBSF_3: TStringField;
    cdsProdutosOBSF_4: TStringField;
    cdsProdutosOBSF_5: TStringField;
    pnlObs: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtObsF_2: TDBEditFocus;
    edtObsF_1: TDBEditFocus;
    edtObsF_4: TDBEditFocus;
    edtObsF_3: TDBEditFocus;
    edtObsF_5: TDBEditFocus;
    cdsProdutosREFERE: TStringField;
    frxDBGarantiaEC: TfrxDBDataset;
    frxDocEnvCliJ: TfrxReport;
    frxDocEnvCliM: TfrxReport;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    btnBaixaTotal: TBitBtnLocked;
    btnObs: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    cdsProdutosCODFAB: TStringField;
    cdsProdutosUNITAR: TFloatField;
    cdsProdutosPRECUS: TFloatField;
    cdsProdutosINCORI: TStringField;
    cxgItensDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxgItensDBBandedTableView1: TcxGridDBBandedTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGridCitel;
    cxgItensDBTableViewCitel1CODITE: TcxGridDBBandedColumn;
    cxgItensDBTableViewCitel1DESITE: TcxGridDBBandedColumn;
    cxgItensDBTableViewCitel1UNIDAD: TcxGridDBBandedColumn;
    cxgItensDBTableViewCitel1QTDREQ: TcxGridDBBandedColumn;
    cxgItensDBTableViewCitel1QTDRET: TcxGridDBBandedColumn;
    cxgItensDBTableViewCitel1QTDREF: TcxGridDBBandedColumn;
    cxgItensDBTableViewCitel1QTDDEV: TcxGridDBBandedColumn;
    cxgItensDBTableViewCitel1QTDPRE: TcxGridDBBandedColumn;
    cxgItensDBTableViewCitel1QTDDEV_1: TcxGridDBBandedColumn;
    cxgItensDBTableViewCitel1QTDPRE_1: TcxGridDBBandedColumn;
    cxgItensDBTableViewCitel1DOCUMENTO: TcxGridDBBandedColumn;
    cdsProdutosTEMLOTE: TStringField;
    cdsProdutosLOTEPRINCIPALVENDA: TStringField;
    pnlFiltrosPesq: TPanel;
    pnlRadioOpcaoCliente: TPanel;
    rdbFavorecido: TRadioButton;
    RadioButton1: TRadioButton;
    Label2: TLabel;
    cdsProdutosSALREP: TFloatField;
    cdsProdutosSALPRE: TFloatField;


    cdsProdutosDOCUMENTO: TStringField;
    cdsProdutosQTDCRE_1: TFloatField;
    cdsProdutosAGG_QTDCRE_1: TAggregateField;
    cxgItensDBTableViewCitel1QTDCRE_1: TcxGridDBBandedColumn;
    cxgItensDBTableViewCitel1REPOST: TcxGridDBBandedColumn;
    cdsProdutosUNICRD: TFloatField;
    cdsProdutosORIGEM: TStringField;
    cdsProdutosREPOST: TStringField;
    cdsProdutosCODFAV: TStringField;
    cdsProdutosINCGER: TStringField;
    cxgItensDBTableView1Citel1Origem: TcxGridDBBandedColumn;
    pnlLegenda: TPanel;
    shpLegenda: TShape;
    Label3: TLabel;
    cdsProdutosINCGAG: TStringField;
    cdsProdutosNUMDOC: TStringField;
    cdsProdutosESPDOC: TStringField;
    btnImprimirSep: TBitBtnLocked;
    cdsProdutosLOCFIS: TStringField;
    frxDocSepItem_J: TfrxReport;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodCliExit(Sender: TObject);
    procedure btnObsClick(Sender: TObject);
    procedure btnBaixaTotalClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dtsProdutosDataChange(Sender: TObject; Field: TField);
    procedure FormActivate(Sender: TObject);
    procedure cdsProdutosBeforePost(DataSet: TDataSet);
    procedure cxgItensDBTableViewCitel1EditKeyDown(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
    procedure cxgItensDBTableViewCitel1QTDCRE_1PropertiesValidate(
      Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure btnConfirmarClick(Sender: TObject);
    procedure cxgItensDBBandedTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensDBBandedTableView1EditKeyDown(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnImprimirSepClick(Sender: TObject);
  private
    { Private declarations }
    FblnResult: Boolean;
    FcdsItensProcessar: TUniClientDataSet;
    FpgbProgresso: TcxProgressBar;
    objMovGag: TMovGag;
    strNumRet: String;
    cdsGroup : TUniClientDataSet;
    fatVenda : TFatVenda;
    blnMensagem : Boolean;
    blnInformarEntregaRetiraGC: Boolean;
    FEntregaRetira: TReposicaoEntregaRetira;
    FblnInfCli,
    FblnGeraCreditoNoRecebimento: boolean;
    FblnHabilitarImpressaoSeparacaoAvulsa: Boolean;
    FstrPortad: String;
    procedure pCarregaTabelaProdutos(qryCliente: TUniQuery; cdsProdutos: TUniClientDataSet);
    procedure pImprimeDocumento;
    function fRetSequencial: String;
    function fAtuSequencial(strValor: String): Boolean;
    function fGetTipoFaturamento(fatVendaP: TFatVenda): Boolean;
    procedure pCreateFatVendas;
    function fOutrasSaidasFaturamento: Boolean;
    function fIncluiItens(fatVenda: TFatVenda): Boolean;
    function fGravaArquivos(objfatVenda: TFatVenda): Boolean;
    function fGetCfopEnvioCliente(fatVendaP: TFatVenda): Boolean;
    function fGetTipoClienteFavorecido: Boolean;
    procedure ConfigurarTelaInfCli;
    function fValidarQtdDevolvida: Boolean;
    function fValidarQtdPrejuizo: Boolean;
    function fValidarQtdCredito: Boolean;
    function fConfirmarDevolucao: Boolean;
    function fConfirmarPrejuizo: Boolean;
    function fConfirmarCredito: boolean;
    function fGetSqlCredito: String;
    procedure pCarregarConfiguracoes;
    function fValorTotalCreditoItem: Double;
    procedure pConfirmar;
    function fConfirmar(pgbProgresso: TcxProgressBar): Boolean;
    function fGetProgressBar: TcxProgressBar;
    function fObterCdsItensProcessar: TUniClientDataSet;
    procedure pSepararItensProcessar;
    procedure pLimparTela;
    procedure pCarregaItensDestino(pdsOrigem, pdsDestino: TDataSet);
    procedure pIncluirOrorrenciaCRM(pintOperacao: Integer);
    procedure pImprimirSeparacaoAvulsaItem;
  public

    { Public declarations }

  protected

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pEscapePressed; override;
    procedure pValidaCliente;

  end;

Const
  MSG_IMPRESSINV = 'Houve um erro ao enviar o documento para a impressora.' + #13#10 +
                   'Verifique se a impressora selecionada é válida ou seu nome está digitado corretamente.';

implementation

uses
  untGarantiaRecCliente,
  untFuncoesSimples, untCfgRel, untConsultas, untTypesSistema, untMovGer,
  untFuncFatTypes, untFatTipoFaturamento, untFatDadosFiscais, untFuncoes,
  untControleSepAvulsa,
  untGravando, untCadLote, untFatDigDadosGarantia, untTestabilidade,
  untConstantes, untFatImpressao, untTCRMGarantia;

{$R *.dfm}

{*******************************************}
{* VALIDA CAMPOS                           *}
{****************************************RL*}
function TfrmGarantiaEnvCliente.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA CLIENTE                        *}
    {**************************************RL*}
    If Sender = edtCodCli Then
      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O cliente deve ser preenchido!' , ['&Ok']);
        Result := False;
      End

      Else
      Begin
        edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
        
        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('AVISO', 'Cliente não encontrado!', ['&Ok']);
          pSetFocus(edtCodCli);
          Result := False;
        End

        {*******************************************}
        {* CARREGA PRODUTOS DO CLIENTE             *}
        {****************************************RL*}
        Else
        Begin
          cdsProdutos.EmptyDataSet;
          objMovGag.objMovGad.pCarregaProdutosDevolucao(edtCodCli.Text, fGetTipoClienteFavorecido);

          If objMovGag.objMovGad.qryCliente.IsEmpty Then
          Begin
            fMensagem('', 'Não existem produtos para este cliente!', ['&Ok']);
            Result := False;
          End

          Else
            pCarregaTabelaProdutos(objMovGag.objMovGad.qryCliente, cdsProdutos);
            objMovGag.objMovGad.qryCliente.Close;
            btnBaixaTotal.Enabled := True;
            btnObs.Enabled        := True;
        End;

      End;

  End;

  If Not (Result) Then
    pSetFocus(Sender);

end;

procedure TfrmGarantiaEnvCliente.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext((ActiveControl), True, True);
  End;
end;

procedure TfrmGarantiaEnvCliente.FormCreate(Sender: TObject);
begin
  inherited;

  objMovGag := TMovGag.Create(Self);

  pSetaCodIte(cdsProdutosCODITE);

  cdsProdutos.CreateDataSet;

  cdsGroup           := TUniClientDataSet.Create(Self);
  cdsGroup.FieldDefs := cdsProdutos.FieldDefs;
  cdsGroup.CreateDataSet;
  pCarregarConfiguracoes;
  ConfigurarTelaInfCli;
end;

procedure TfrmGarantiaEnvCliente.FormDestroy(Sender: TObject);
begin
  if Assigned(FcdsItensProcessar) then
    FreeAndNil(FcdsItensProcessar);

  inherited;

end;

procedure TfrmGarantiaEnvCliente.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodCli);
end;

procedure TfrmGarantiaEnvCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  cdsProdutos.Close;
  
end;

{*******************************************}
{* CARREGA TABELA DE PRODUTOS              *}
{****************************************RL*}
procedure TfrmGarantiaEnvCliente.pCarregaTabelaProdutos(
  qryCliente: TUniQuery; cdsProdutos: TUniClientDataSet);
begin

  cdsProdutos.EmptyDataSet;

  With objMovGag.objMovGad.qryCliente Do
    While Not Eof Do
    Begin
      cdsProdutos.Insert;
      pCarregaItensDestino(qryCliente, cdsProdutos);
      cdsProdutos.FieldByName('QTDDEV_1').AsFloat  := 0;
      cdsProdutos.FieldByName('QTDPRE_1').AsFloat  := 0;
      cdsProdutos.FieldByName('QTDCRE_1').AsFloat  := 0;
      cdsProdutos.Post;
      Next;

    End;

  cdsProdutos.First;

end;

procedure TfrmGarantiaEnvCliente.edtCodCliExit(Sender: TObject);
begin
  inherited;

 { If fValidaCampos(edtCodCli, True) Then
  Begin
    btnBaixaTotal.Enabled := True;
    btnObs.Enabled        := True;
  End
  Else
    pSetFocus(edtCodCli);}

end;

procedure TfrmGarantiaEnvCliente.pEscapePressed;
begin
  inherited;

  If ((ActiveControl) = cxgItens) Then
    pSetFocus(cxgItens)
  Else
    inherited;

end;

procedure TfrmGarantiaEnvCliente.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  pConfirmar;
end;

procedure TfrmGarantiaEnvCliente.btnImprimirSepClick(Sender: TObject);
begin
  inherited;
  if FblnHabilitarImpressaoSeparacaoAvulsa Then
    pImprimirSeparacaoAvulsaItem;
end;


procedure TfrmGarantiaEnvCliente.btnObsClick(Sender: TObject);
begin
  inherited;

  If Not pnlObs.Visible Then
    pnlObs.Visible := True
  Else
    pnlObs.Visible := False;

end;

procedure TfrmGarantiaEnvCliente.cxgItensDBTableViewCitel1EditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If ((Key = Vk_Return) Or (Key = VK_TAB)) And (cdsProdutos.State = dsEdit) Then
  Begin

    cdsProdutos.Post;

    {*******************************************}
    {* CONSISTE A QTD. DEVOLVIDA INFORMADA     *}
    {****************************************RL*}
    If cxgItensDBTableViewCitel1QTDDEV_1.Focused Then
    Begin

      With cdsProdutos Do
      Begin

        If (SameText(FieldByName('TEMLOTE').AsString,'S')) And
           (fEmptyStr(FieldByName('LOTEPRINCIPALVENDA').AsString)) Then
        Begin
          fMensagem('ATENÇÃO', 'O item está sem lote principal de venda, ajustar!', ['&Ok']);
          Edit;
          FieldByName('QTDDEV_1').AsFloat := 0;
          Post;
          Exit;
        End
        Else If Not fValidarQtdDevolvida Then
        Begin
          Edit;
          FieldByName('QTDDEV_1').AsFloat := 0;
          Post;
          Exit;
        End;

      End;

    End;

    {*******************************************}
    {* CONSISTE A QTD. DE PREJUÍZO             *}
    {****************************************RL*}
    If cxgItensDBTableViewCitel1QTDPRE_1.Focused Then
    Begin

      With cdsProdutos Do
      Begin
         If (SameText(FieldByName('TEMLOTE').AsString,'S')) And
            (fEmptyStr(FieldByName('LOTEPRINCIPALVENDA').AsString)) Then
        Begin
          fMensagem('ATENÇÃO', 'O item está sem lote principal de venda, ajustar!', ['&Ok']);
          Edit;
          FieldByName('QTDPRE_1').AsFloat := 0;
          Post;
          Exit;
        End
        Else If Not fValidarQtdPrejuizo Then
        Begin
          Edit;
          FieldByName('QTDPRE_1').AsFloat := 0;
          Post;
          Exit;
        End;

      End;

    End;



    {*******************************************}
    {* CONSISTE A QTD. DE PREJUÍZO             *}
    {****************************************RL*}
    If cxgItensDBTableViewCitel1QTDPRE_1.Focused Then
    Begin

      With cdsProdutos Do
      Begin
        If Not fValidarQtdCredito Then
        Begin
          Edit;
          FieldByName('QTDCRE_1').AsFloat := 0;
          Post;
          Exit;
        End;

      End;

    End;

  End

  Else If Key = Vk_Escape Then
    pSetFocus(edtCodCli);

end;

procedure TfrmGarantiaEnvCliente.cxgItensDBTableViewCitel1QTDCRE_1PropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
Var
  lblnAbortar: Boolean;
begin
  inherited;
  lblnAbortar := False;
  Try
    If DisplayValue = '' Then
      DisplayValue := 0

    else if  cxgItensDBBandedTableView1.DataController.DataSet.FieldByName('REPOST').AsString = 'S' then
    begin
      pMensagemOk('Só é permitido gerar crédito para garantia que não foi feita reposição imediata [Reposição = N].');
      lblnAbortar := True;
    end


    else if DisplayValue < 0 then
    begin
      pMensagemOk('A quantidade de crédito não pode ser negativa.');
      lblnAbortar := True;
    end;

    if lblnAbortar then
    begin
      DisplayValue := 0;
      abort;
    end;

  Except
    On E: Exception do
    begin
      DisplayValue := 0;
      pMensagensErro(e.message, '[TfrmGarantiaEnvCliente.cxgItensDBTableViewCitel1QTDCRE_1PropertiesValidate]');
      Abort;
    end;
  End;

end;

procedure TfrmGarantiaEnvCliente.cdsProdutosBeforePost(DataSet: TDataSet);
begin
  inherited;

  blnMensagem := False;
  {$Region 'Consiste a qtd de reposição'}
  With cdsProdutos Do
  Begin
    If Not fValidarQtdDevolvida Then
    Begin
      FieldByName('QTDDEV_1').AsFloat := 0;
      blnMensagem := True;
    End;

  End;
  {$EndRegion}

  {$Region 'Consiste a qtd de prejuízo'}
  {*******************************************}
  {* CONSISTE A QTD. DE PREJUÍZO             *}
  {****************************************RL*}

  With cdsProdutos Do
  Begin
    If Not fValidarQtdPrejuizo Then
    Begin
      FieldByName('QTDPRE_1').AsFloat := 0;
      blnMensagem := True;
    End;
  End;
  {$Endregion}
  Try
    if Not fValidarQtdCredito then
      abort;
  except
    on e: EAbort do
    begin
       abort;
    end;

  end;
  btnImprimirSep.Visible := FblnHabilitarImpressaoSeparacaoAvulsa;
  btnImprimirSep.Enabled := FblnHabilitarImpressaoSeparacaoAvulsa;
end;

procedure TfrmGarantiaEnvCliente.ConfigurarTelaInfCli;
begin
  pnlRadioOpcaoCliente.Visible := FblnInfCli;

  if pnlRadioOpcaoCliente.visible then
    pnlRadioOpcaoCliente.parent.Height := 55
  else
    pnlRadioOpcaoCliente.parent.Height := 40;
end;

{********************************************************************}
{* PREENCHE AUTOMATICAMENTE A QTD. DEVOLVIDA E O PREJUÍZO DIGITADAS *}
{*****************************************************************RL*}

procedure TfrmGarantiaEnvCliente.btnBaixaTotalClick(Sender: TObject);
  Var
    BookMark: TBookMark;
begin
  inherited;

  BookMark := cdsProdutos.GetBookmark;
  cdsProdutos.DisableControls;

  With cdsProdutos Do
  Begin

    First;

    While Not Eof Do
    Begin
      Edit;
      FieldByName('QTDDEV_1').AsFloat := FieldByName('QTDREQ').AsFloat - FieldByName('QTDDEV').AsFloat;
      FieldByName('QTDPRE_1').AsFloat := FieldByName('QTDREF').AsFloat - FieldByName('QTDPRE').AsFloat;
      Post;

      Next;
    End;

  End;

  cdsProdutos.GotoBookmark(BookMark);
  cdsProdutos.FreeBookmark(BookMark);
  cdsProdutos.EnableControls;

end;

procedure TfrmGarantiaEnvCliente.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = Vk_F10) And (btnConfirmar.Enabled) Then
  Begin
    key := 0;
    btnConfirmar.Click;
  End

  Else If (Key = Vk_F8) And (btnBaixaTotal.Enabled) Then
    btnBaixaTotal.Click

  Else If (Key = Vk_F9) And (btnObs.Enabled) Then
    btnObs.Click

  else if (key = VK_F5) and (ssAlt in Shift) then
  begin
    if FblnHabilitarImpressaoSeparacaoAvulsa Then
      pImprimirSeparacaoAvulsaItem;
  end;
end;

procedure TfrmGarantiaEnvCliente.FormShow(Sender: TObject);
begin
  inherited;
  if Not FblnGeraCreditoNoRecebimento then
  begin
    cxgItensDBTableViewCitel1QTDCRE_1.Visible := False;
    label3.Caption := 'Item não reposto no recebimento e disponível para reposição (devolver).';
  end;
  btnImprimirSep.Visible := FblnHabilitarImpressaoSeparacaoAvulsa;
  btnImprimirSep.Enabled := FblnHabilitarImpressaoSeparacaoAvulsa;
end;

procedure TfrmGarantiaEnvCliente.dtsProdutosDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;

  {***********************************************}
  {* OS CAMPOS AGGREGATES ESTÃO SENDO UTILIZADOS *}
  {* APENAS PARA HABILITAR / DESABILITAR O BOTÃO *}
  {* DE CONFIRMAR DE ACORDO COM SEU VALOR.       *}
  {********************************************RL*}
  If (TAggregateField(cdsProdutos.FieldByName('AGG_QTDDEV_1')).Value > 0) Or
     (TAggregateField(cdsProdutos.FieldByName('AGG_QTDPRE_1')).Value > 0) Or
     (TAggregateField(cdsProdutos.FieldByName('AGG_QTDCRE_1')).Value > 0) Then
    btnConfirmar.Enabled := True
  Else
    btnConfirmar.Enabled := False;

end;

procedure TfrmGarantiaEnvCliente.pValidaCliente;
begin
  If fValidaCampos(edtCodCli, True) Then
  Begin
    btnBaixaTotal.Enabled := True;
    btnObs.Enabled        := True;
  End
  Else
    pSetFocus(edtCodCli);

end;

procedure TfrmGarantiaEnvCliente.pImprimeDocumento;
  Var
    strNomImp: String;
    strTipImp: String;
    frxDoc: TfrxReport;
    qryCfgRel: TUniQuery;
Begin

  qryCfgRel := fCriaQuery(Self);
  pCarregaConfImpr(qryCfgRel, Self.Name);
  strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  FreeAndNil(qryCfgRel);

  Try
    Try

      cdsProdutos.DisableControls;
      cdsProdutos.Filter   := '(QTDDEV_1 > 0) OR (QTDPRE_1 > 0)';
      cdsProdutos.Filtered := True;

      If strTipImp = 'M' Then
        frxDoc := frxDocEnvCliM
      Else
        frxDoc := frxDocEnvCliJ;

      frxDoc.Script.Variables['NOMEMP'] := fRetNomeEmpresa;
      frxDoc.Script.Variables['TOTQTD'] := IntToStr(cdsProdutos.RecordCount);
      frxDoc.Script.Variables['NOMOPE'] := strDescriUsuarioLogado;
      frxDoc.Script.Variables['NOMCLI'] := Copy(edtNomCli.Text,1,25);
      frxDoc.Script.Variables['NOMFRM'] := Self.Name;
      frxDoc.Script.Variables['NUMRET'] := strNumRet+'-GC';
      frxDoc.Script.Variables['DTADEV'] := VS_Date;

      If Not fEmptyStr(strNomImp) Then
      Begin
        frxDoc.PrintOptions.Printer    := strNomImp;
        frxDoc.PrintOptions.PrintMode  := pmDefault;
        frxDoc.PrintOptions.ShowDialog := False;

        if frxDoc.PrepareReport Then
          pPrintReport(Self.Name, 'Garantia - ' + Self.Caption, strNomImp, frxDoc);
      End
      Else
        pPreviewReport(Self.Name, 'Garantia - ' + Self.Caption, frxDoc);

    Except
      On E: Exception Do
      Begin
				pMensagensErro(E.Message,'[TfrmGarantiaEnvCliente.pImprimeDocumento]');
      End;
    End;

  Finally
    pnlInfo.Caption := '';
    cdsProdutos.Filter   := '';
    cdsProdutos.Filtered := False;
    cdsProdutos.EnableControls;
  End;

End;

procedure TfrmGarantiaEnvCliente.pImprimirSeparacaoAvulsaItem;
Var
  qryCfgRel: TUniQuery;
  strNomeFila: string;
  strTipImp: string;
begin
  if cdsProdutos.Isempty then
  begin
    pMensagemOk('Não há dados para imprimir.');
    Exit;
  end;

  cdsProdutos.DisableControls;
  Try
    cdsProdutos.Filtered := False;
    cdsProdutos.Filter := ' QTDDEV_1 > 0';
    cdsProdutos.Filtered := True;

    if cdsProdutosQTDDEV_1.AsFloat <=0 then
    begin
      pMensagemOk('Impressão disponível apenas para item com quantidade a devolver informada e maior que zero.');
      Exit;
    end;

    {$Region 'Gerando impressão impressão listagem'}

    qryCfgRel := fCriaQuery;
    Try
      pCarregaConfImpr(qryCfgRel, 'frmFatVendas_SEP', VS_strCodEmp);
      fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);

      frxDocSepItem_J.PrintOptions.Printer := AnsiReplaceText(strNomeFila,'\\' + fRetNomeRede + '\','');
      frxDocSepItem_J.Script.Variables['NOMFAN']  := fRetFantasiaEmpresa;
      frxDocSepItem_J.Script.Variables['CLIENTE'] := edtCodCli.Text + ' - ' + edtNomCli.Text;
      frxDocSepItem_J.Script.Variables['FAN_CLI'] := fRetFantasiaCliente(edtCodCli.Text);
      frxDocSepItem_J.Script.Variables['OPELOG']  := strLoginUsuarioLogado + '-' + fRetNomVendRep(strLoginUsuarioLogado) ;
      frxDocSepItem_J.Script.Variables['DTAENT']  := VS_Date;
      frxDocSepItem_J.Script.Variables['HORENT']  := fTime();

      If frxDocSepItem_J.PrepareReport Then
      Begin
        frxDocSepItem_J.PrintOptions.ShowDialog := fEmptyStr(strNomeFila);

        If fEmptyStr(strNomeFila) Then
          pPreviewReport('frmFatVendas_SEP', 'Impressão de separação avulsa', frxDocSepItem_J)
        Else
          pPrintReport('frmFatVendas_SEP', 'Impressão de separação avulsa', strNomeFila, frxDocSepItem_J);

      End;

    Finally
      FreeAndNil(qryCfgRel);
    End;

    {$EndRegion 'Gerando impressão impressão listagem'}

  Finally
    cdsProdutos.Filtered := False;
    cdsProdutos.Filter := '';
    cdsProdutos.EnableControls;
  End;

end;

procedure TfrmGarantiaEnvCliente.pIncluirOrorrenciaCRM(pintOperacao: Integer);
Var
  lrecDadosGarantiaCRM: TDadosGarantiaCRM;
  lCRMGarantia: TCRMGarantia;
  lstrCodIte,
  lstrDesIte: String;
  lfltQtdIte: double;
begin
  lCRMGarantia := TCRMGarantia.Create;
  Try
    FcdsItensProcessar.First;
    While Not FcdsItensProcessar.Eof do
    begin
      lrecDadosGarantiaCRM.strCodCli := edtCodCli.Text;
      lrecDadosGarantiaCRM.strCodEmp := VS_strCodEmp;
      lrecDadosGarantiaCRM.strNomCli := edtNomCli.Text;
      lrecDadosGarantiaCRM.strNomFrm := 'TfrmGarantiaEnvCliente';
      lrecDadosGarantiaCRM.strNumEnt := FcdsItensProcessar.FieldByName('NUMDOC').AsString;
      lrecDadosGarantiaCRM.strEspDoc := FcdsItensProcessar.FieldByName('ESPDOC').AsString;
      lrecDadosGarantiaCRM.blnGeraCreditoNoRecebimento := False;
      lrecDadosGarantiaCRM.strCodAde := '';
      lrecDadosGarantiaCRM.strDescri := '';

      lstrCodIte := FcdsItensProcessar.FieldByName('CODITE').AsString;
      lstrDesIte := FcdsItensProcessar.FieldByName('DESITE').AsString;

      IF pintOperacao = 0 then
        lfltQtdIte := FcdsItensProcessar.FieldByName('QTDCRE_1').AsFloat
      else if pintOperacao = 1 then
      begin
        lfltQtdIte := FcdsItensProcessar.FieldByName('QTDDEV_1').AsFloat;
        lrecDadosGarantiaCRM.strDescri := 'Número da NF de Saida: ' + strNumRet;
      end
      else if pintOperacao = 2 then
        lfltQtdIte := FcdsItensProcessar.FieldByName('QTDPRE_1').AsFloat
      else
        lfltQtdIte := 0;

      lCRMGarantia.recDadosGarantia := lrecDadosGarantiaCRM;

      if pintOperacao = 0 then
        lCRMGarantia.pIncluirHistoricoLiberacaoCreditoItem(lstrCodite, lstrDesIte, lfltQtdite)
      else
        lCRMGarantia.pIncluirHistoricoLiberacaoEnvioCliente(lstrCodite, lstrDesIte, lfltQtdite);

      FcdsItensProcessar.Next;
    end;
  Finally
    lCRMGarantia.Free;
  End;
end;

{*****************************************}
{* RETORNA O SEQUENCIAL DE GARANTIA PARA *}
{* O ENVIO DO DOCUMENTO AO CLIENTE       *}
{**************************************IV*}
function TfrmGarantiaEnvCliente.fRetSequencial: String;
  Var
    strSQL   : String;
    qryCadGen: TUniQuery;
begin
  Try
    qryCadGen := fCriaQuery(nil);

    Try
      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   SIS_VALCFG AS VALOR ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   CFGSIS ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   SIS_CODCFG = ' + QuotedStr('CFG_PROGEC') + ' AND ';
      strSQL := strSQL + '   SIS_CODEMP = ' + QuotedStr(VS_strCodEmp);

      With qryCadGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

        If FieldByName('VALOR').IsNull Then
          strSQL := '0'
        Else
          strSQL := FieldByName('VALOR').AsString;

        Close;
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create('Não consegui pegar o proximo sequencial. Tente novamente!');
      End;
    End;

    Result := fStrZero(strSQL, fTamDocCadRec);
    If StrToInt(Result) = 0 Then
      Result := fStrZero(IntToStr(StrToInt(Result)+1), fTamDocCadRec);

    fAtuSequencial(fStrZero(IntToStr(StrToInt(Result)+1), fTamDocCadRec));

  Finally
    FreeAndNil(qryCadGen);
  End;

End;

function TfrmGarantiaEnvCliente.fAtuSequencial(strValor: String): Boolean;
  Var
    strSQL   : String;
    qryGenCfg: TUniQuery;
begin
  Try

    Result := True;

    qryGenCfg := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  CFGSIS ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '   SIS_VALCFG = :VALOR ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   SIS_CODCFG = ' + QuotedStr('CFG_PROGEC') + ' AND ';
    strSQL := strSQL + '   SIS_CODEMP = ' + QuotedStr(VS_strCodEmp);

    Try
      With qryGenCfg Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('VALOR').AsString  := strValor;
        ExecSQL;
        Close;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
      End;
    End;

  Finally
    FreeAndNil(qryGenCfg);
  End;

End;

function TfrmGarantiaEnvCliente.fGetCfopEnvioCliente(
  fatVendaP: TFatVenda): Boolean;
 Var
    blnTemST : Boolean;
    fltPerIcm: Double;
    strCodSit, strPrefix: String;
begin
  Result := True;
  blnTemST := False;

  If (fatVendaP.strEspDoc <> 'NF') Then
  Begin
    fatVendaP.strClaFisRecGarantia   := '5999';
    fatVendaP.strClaFisRecGarantiaST := '5999';
    Exit;
  End;

  Try

    With cdsProdutos Do
    Begin
      First;
      While Not Eof Do
      Begin
        fatVenda.pRetornaAliquotaItem(FieldByName('CODITE').AsString, VS_strCodEmp, fltPerIcm, strCodSit);
        blnTemST := (Pos(strCodSit, (CST_SUBSTITUICAO + CST_ANTECIPACAO_ICMS)) > 0);

        If blnTemST Then
          Break;

        Next;
      End;

      First;
    End;

    Try

      If fCadEmp('ESTADO') = fatVendaP.strCliEst Then
        strPrefix := '5'
      Else
        strPrefix := '6';

      pCriarFormularios(TfrmFatDigDadosGarantia, frmFatDigDadosGarantia);
      frmFatDigDadosGarantia.edtClaFis.Enabled := True;
      frmFatDigDadosGarantia.edtDesCla.Enabled := True;

      If (Length(strPrefix + fCfgSis('CLAECL')) = 4) Then
      Begin
        fatVendaP.strClaFis := (strPrefix+fCfgSis('CLAECL'));
        fatVendaP.strDesCla := fRetDesCla(fatVenda.strClaFis);

        frmFatDigDadosGarantia.edtClaFis.Text := fatVenda.strClaFis;
        frmFatDigDadosGarantia.edtDesCla.Text := fatVenda.strDesCla;
      End;

      If (Length(strPrefix + fCfgSis('CLAECL')) <> 4) Or (blnTemST) Then
      Begin
        frmFatDigDadosGarantia.edtClaFis.Enabled := True;
        frmFatDigDadosGarantia.edtDesCla.Enabled := True;
        frmFatDigDadosGarantia.fatVenda          := fatVendaP;
        frmFatDigDadosGarantia.strOpcDoc         := 'GC';
        frmFatDigDadosGarantia.blnTemST          := blnTemST;

        frmFatDigDadosGarantia.ShowModal;

        Result := frmFatDigDadosGarantia.ModalResult = mrOk;
      End;

      If Result Then
      Begin
        fatVendaP.strClaFisRecGarantia   := fatVendaP.strClaFis;

        If blnTemST Then
          fatVendaP.strClaFisRecGarantiaST := frmFatDigDadosGarantia.edtClaSub.Text;
      End;

    Finally
      pFreeAndNil(frmFatDigDadosGarantia);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

function TfrmGarantiaEnvCliente.fGetTipoClienteFavorecido: Boolean;
begin
  if pnlRadioOpcaoCliente.Visible then
    Result := rdbFavorecido.Checked
  else
    Result := False;
end;

function TfrmGarantiaEnvCliente.fGetTipoFaturamento(fatVendaP: TFatVenda): Boolean;
  Var
    arrOpcoes: TOpcoesFaturamentoArray;
    intPos: Integer;
    frmFatTipoFaturamento : TfrmFatTipoFaturamento;
Begin
  Result := False;

  intPos := 0;
  SetLength(arrOpcoes, 2);

  arrOpcoes[intPos].strDesCri := 'Nota Fiscal (Outras Saídas)';
  arrOpcoes[intPos].strEspDoc := 'NF';
  arrOpcoes[intPos].strOpcLet := 'O';
  arrOpcoes[intPos].strMosMen := 'S';
  Inc(intPos);

  arrOpcoes[intPos].strDesCri := 'Garantia';
  arrOpcoes[intPos].strEspDoc := 'GA';
  arrOpcoes[intPos].strOpcLet := 'G';
  arrOpcoes[intPos].strMosMen := 'S';

  Try
    pCriarFormularios(TfrmFatTipoFaturamento, frmFatTipoFaturamento);
    frmFatTipoFaturamento.Caption   := 'Envio para o cliente';
    frmFatTipoFaturamento.strOpcDoc := 'VN';
    frmFatTipoFaturamento.fatVenda  := fatVendaP;
    frmFatTipoFaturamento.arrOpcoes := arrOpcoes;
    frmFatTipoFaturamento.showModal;

    If frmFatTipoFaturamento.blnConfirma Then
    Begin
      If (arrOpcoes[frmFatTipoFaturamento.intPosAtual].strEspDoc = 'NF') Then
        fatVendaP.strOpcDoc := 'OU';

      fatVendaP.strEspDoc := arrOpcoes[frmFatTipoFaturamento.intPosAtual].strEspDoc;
      fatVendaP.strTipFat := arrOpcoes[frmFatTipoFaturamento.intPosAtual].strDesCri;

      Result := True;

    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmGarantiaRecCliente.fGetTipoFaturamento]');
    End;
  End;

  pFreeAndNil(frmFatTipoFaturamento);

  SetLength(arrOpcoes, 0);
end;

procedure TfrmGarantiaEnvCliente.pCreateFatVendas;
begin
  pCriarCdsVenda(Self);
  fatVenda                := TFatVenda.CreateInstance('VN', False);
  fatVenda.strOpcDocTrue  := 'GC';
  fatVenda.blnVerEstOrc   := False;
  fatVenda.strNomeForm    := 'frmFatVendas';
  fatVenda.blnComTansacao := True;
  fatVenda.strClaFisRecGarantia := '5916';
End;

function TfrmGarantiaEnvCliente.fOutrasSaidasFaturamento: Boolean;
  Var
    blnConfirma: Boolean;
begin
  TControleChavesGarantia.pInicializar;
  Try
    blnConfirma := fIncluiItens(fatVenda);

    If (blnConfirma) Then
    Begin
      fatVenda.pCarregaAliquotasRetencao;

      fatVenda.pPreencheMatrizFechamento;

      fatVenda.pCalculaPesBruLiq;

      fatVenda.pCalculaTotGer(False, False);

      If Not (SameText(fatVenda.strCliOrg,'S') And (fatVenda.fltDesEsp > 0)) Then
        fatVenda.fltDesEsp := fatVenda.fltDesEsp + fatVenda.fltIcmOrg;

      fatVenda.pCalculaTotGer(False, False);

      fatVenda.pCalculaTotGer;

      fatVenda.strClaFis := fatVenda.strClaFisRecGarantia;
      fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

      fatVenda.pDestacaRetencoes;
      fatVenda.pRetemImpostosNoDescontoEspecial;
      fatVenda.pCalculaTotalParaCadRec;
      fatVenda.blnEnvioClienteGarantia := True;

      fatVenda.pRateiaValores;

      If (fatVenda.strEspDoc = 'NF') Then
      Begin
        Try
          pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);

          frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text    := fatVenda.strClafis;
          frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Text    := fatVenda.strDesCla;
          frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled := False;
          frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Enabled := (fCfgSis('OPCCFO', varInteger) = 1);
          frmFatDadosFiscais.blnForcaEdiBas    := True;
          frmFatDadosFiscais.fatVenda := fatVenda;

          frmFatDadosFiscais.Caption := frmFatDadosFiscais.Caption;
          frmFatDadosFiscais.ShowModal;

          blnConfirma := frmFatDadosFiscais.blnConfirma;

        Except
          On E: Exception Do
          Begin
            blnConfirma := False;
            pMensagensErro(E.Message, '[TfrmGarantiaRecCliente.fOutrasSaidasFaturamento_1]');
          End;
        End;

        pFreeAndNil(frmFatDadosFiscais);
      End;

    End;
  Except
    On E: Exception Do
    Begin
       blnConfirma := False;
      pMensagensErro(E.Message, '[TfrmGarantiaRecCliente.fOutrasSaidasFaturamento_2]');
    End;
  End;

  Result := blnConfirma;
end;


function TfrmGarantiaEnvCliente.fIncluiItens(fatVenda: TFatVenda): Boolean;
  Var
    qryGenIte   : TUniQuery;
    intContador : Integer;
    recForTin   : TForTin;
    recMadeira  : TDadosMadeira;
    strIteDes   : String;
    strTabPre   : String;
    objCadLot   : TCadLot;
    blnTemLot   : Boolean;
    strNumLotSai: String;
Begin

  Try
    objCadLot := TCadLot.Create(Self);
    strTabPre := fCampoTabela('CLI_TABPRE', 'CADCLI', ['CLI_CODCLI'], [edtCodCli.Text], False);

    If fEmptyStr(strTabPre) And fCfgSis('HIETAB', VarBoolean) Then
      strTabPre := fCampoTabela('OPE_TABPRE', 'CADOPE', ['OPE_CODOPE'], [fatVenda.strCodVen], False);

    qryGenIte := fCriaQuery;
    cdsGroup.EmptyDataSet;

    With FcdsItensProcessar Do
    Begin
      First;

      While Not Eof Do
      Begin
        cdsGroup.Close;
        cdsGroup.Open;

        TControleChavesGarantia
          .pAdicionarChaveGarantia(FcdsItensProcessar.FieldByName('CODITE').AsString,
                                   FcdsItensProcessar.FieldByName('AUTINC').AsString,
                                   FcdsItensProcessar.FieldByName('INCORI').AsString,
                                   FcdsItensProcessar.FieldByName('QTDDEV_1').AsFloat);

        If Not cdsGroup.Locate('CODITE', FieldByName('CODITE').AsString, []) Then
        Begin
          cdsGroup.Insert;
          cdsGroup.FieldByName('CODITE').AsString     := FieldByName('CODITE').AsString;
          cdsGroup.FieldByName('DESITE').AsString     := FieldByName('DESITE').AsString;
          cdsGroup.FieldByName('UNIDAD').AsString     := FieldByName('UNIDAD').AsString;
          cdsGroup.FieldByName('QTDDEV_1').AsFloat    := FieldByName('QTDDEV_1').AsFloat;
          cdsGroup.FieldByName('AUTINC').AsString     := FieldByName('AUTINC').AsString;
          cdsGroup.FieldByName('NUMENT').AsString     := FieldByName('NUMENT').AsString;
          cdsGroup.FieldByName('CODVEN').AsString     := FieldByName('CODVEN').AsString;
          cdsGroup.FieldByName('CODCLI').AsString     := FieldByName('CODCLI').AsString;
          cdsGroup.FieldByName('CODFOR').AsString     := FieldByName('CODFOR').AsString;
          cdsGroup.FieldByName('DTADEV').AsDateTime   := FieldByName('DTADEV').AsDateTime;
          cdsGroup.FieldByName('OBSF_1').AsString     := FieldByName('OBSF_1').AsString;
          cdsGroup.FieldByName('OBSF_2').AsString     := FieldByName('OBSF_2').AsString;
          cdsGroup.FieldByName('OBSF_3').AsString     := FieldByName('OBSF_3').AsString;
          cdsGroup.FieldByName('OBSF_4').AsString     := FieldByName('OBSF_4').AsString;
          cdsGroup.FieldByName('OBSF_5').AsString     := FieldByName('OBSF_5').AsString;
          cdsGroup.FieldByName('REFERE').AsString     := FieldByName('REFERE').AsString;
          cdsGroup.FieldByName('CODFAB').AsString     := FieldByName('CODFAB').AsString;
          cdsGroup.FieldByName('UNITAR').AsFloat      := FieldByName('UNITAR').AsFloat;
          cdsGroup.Post;
        End
        Else
        Begin
          cdsGroup.Edit;
          cdsGroup.FieldByName('QTDDEV_1').AsFloat := cdsGroup.FieldByName('QTDDEV_1').AsFloat +
                                                      FieldByName('QTDDEV_1').AsFloat;
          cdsGroup.Post;
        End;


        Next;
      End;

      EnableControls;
    End;

    With cdsGroup Do
    Begin
      DisableControls;

      fatVenda.fltDesEsp := 0;

      intContador := 0;
      First;

      While Not Eof Do
      Begin
        inc(intContador);

        If (intContador = 1) Then
        Begin
          fatVenda.strCodVen    := strLoginUsuarioLogado;
          fatVenda.strNomVen    := fRetNomVendRep(fatVenda.strCodVen);
        End;

        fGetItem(qryGenIte,FieldByName('CODITE').AsString);

        strIteDes := FieldByName('DESITE').AsString;
        If (fCfgSis('IMPREF', varBoolean)) Then
          If (fCfgSis('MONDES', varString) = '1') Then
            strIteDes := FieldByName('DESITE').AsString +
                         IIF(Not fEmptyStr(FieldByName('REFERE').AsString),' ' + FieldByName('REFERE').AsString, '') +
                         IIF(Not fEmptyStr(FieldByName('CODFAB').AsString),' ' + FieldByName('CODFAB').AsString, '')
          Else
            strIteDes := IIF(Not fEmptyStr(FieldByName('CODFAB').AsString),FieldByName('CODFAB').AsString + ' ', '') +
                         IIF(Not fEmptyStr(FieldByName('REFERE').AsString),FieldByName('REFERE').AsString + ' ', '') +
                         FieldByName('DESITE').AsString;

        blnTemLot := objCadLot.fExisteLote(FieldByName('CODITE').AsString, vs_strCodEmp, '', False, False);
        strNumLotSai := objCadLot.fRetArmazemPrincipalOrcamentoPedidoVenda(FieldByName('CODITE').AsString);
        If (blnTemLot) And (fEmptyStr(strNumLotSai)) Then
        Begin
          pMensagemOk('O Item: '+ FieldByName('CODITE').AsString + '-' + qryGenIte.FieldByName('ITE_DESITE').AsString + ' está sem lote principal de venda, ajustar!');
          Result := False;
          Exit;
        End;
        {$Region 'pAdicionaRegistroTemporaria'}
        fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
                                             Nil,
                                             'NOR',
                                             qryGenIte.FieldByName('ITE_CODGRU').AsString,
                                             FieldByName('CODITE').AsString,
                                             qryGenIte.FieldByName('ITE_DESITE').AsString,
                                             strIteDes,
                                             qryGenIte.FieldByName('ITE_DESFAB').AsString,
                                             qryGenIte.FieldByName('UNI_CODUNI').AsString,
                                             qryGenIte.FieldByName('UNI_CODUNI').AsString,
                                             qryGenIte.FieldByName('ITE_CODMAR').AsString,
                                             qryGenIte.FieldByName('ITE_CODFOR').AsString,
                                             qryGenIte.FieldByName('ITE_REFERE').AsString,
                                             FieldByName('UNITAR').AsFloat, //uniori
                                             FieldByName('UNITAR').AsFloat, //uniVis
                                             FieldByName('UNITAR').AsFloat, //unitar
                                             0.0,
                                             0.0,
                                             FieldByName('QTDDEV_1').AsFloat,
                                             FieldByName('QTDDEV_1').AsFloat * FieldByName('UNITAR').AsFloat, //totite
                                             'S',
                                             FieldByName('PRECUS').AsFloat,
                                             fFormataFloat(FieldByName('PRECUS').AsFloat * FieldByName('QTDDEV_1').AsFloat, 2),
                                             qryGenIte.FieldByName('ITE_COMLUB').AsString,
                                             qryGenIte.FieldByName('ITE_IPISAI').AsFloat,
                                             qryGenIte.FieldByName('ITE_DESMAX').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREVE1').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREVE2').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREVE3').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREVE4').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREVE5').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREVE6').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREVE7').AsFloat,
                                             0.0,
                                             qryGenIte.FieldByName('ITE_SALDOS').AsFloat,
                                             'N',
                                             qryGenIte.FieldByName('ITE_COMVAR').AsFloat,
                                             qryGenIte.FieldByName('ITE_COMATA').AsFloat,
                                             qryGenIte.FieldByName('ITE_COMDIS').AsFloat,
                                             '',
                                             '',
                                             '',
                                             0,
                                             0,
                                             '',
                                             qryGenIte.FieldByName('ITE_PREULT').AsFloat * FieldByName('QTDDEV_1').AsFloat,
                                             qryGenIte.FieldByName('ITE_IMPULT').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREULT').AsFloat,
                                             qryGenIte.FieldByName('ITE_PREMED').AsFloat,
                                             qryGenIte.FieldByName('ITE_CLAIPI').AsString,
                                             '',
                                             '',
                                             '',
                                             '',
                                             0,
                                             '',
                                             0,
                                             0,
                                             0.00,
                                             0.00,
                                             0.00,
                                             'N',
                                             '',
                                             0,
                                             0,
                                             qryGenIte.FieldByName('ABF_CODABF').AsString,
                                             qryGenIte.FieldByName('ITE_PESOIT').AsFloat,
                                             qryGenIte.FieldByName('ITE_PESLIQ').AsFloat,
                                             'N',
                                             0,
                                             0,
                                             0,
                                             0,
                                             '',
                                             fatVenda.fRetPerComGrupo(qryGenIte.FieldByName('ITE_CODGRU').AsString),
                                             qryGenIte.FieldByName('ITE_CODFAB').AsString,
                                             -1,
                                             0,
                                             '',
                                             '',
                                             '',
                                             qryGenIte.FieldByName('ITE_MARMIN').AsFloat,
                                             qryGenIte.FieldByName('ITE_MARMSG').AsFloat,
                                             qryGenIte.FieldByName('ITE_MARMGE').AsFloat,
                                             fRetNomMarca(qryGenIte.FieldByName('ITE_CODMAR').AsString),
                                             '',
                                             0,
                                             0,
                                             '',
                                             '',
                                             '',
                                             0,
                                             '',
                                             '',
                                             '',
                                             qryGenIte.FieldByName('ITE_PRECOM').AsFloat,
                                             FieldByName('UNITAR').AsFloat, //unidig
                                             qryGenIte.FieldByName('ITE_QTPPRO').AsFloat,
                                             '',
                                             '',
                                             qryGenIte.FieldByName('ITE_OBRCPF').AsString,
                                             '',
                                             '',
                                             fRetSiglaUnidade(qryGenIte.FieldByName('UNI_CODUNI').AsString),
                                             0.00,
                                             intContador,
                                             '',
                                             '',
                                             '',
                                             False,
                                             '',
                                             '',
                                             '',
                                             0,
                                             0,
                                             0,
                                             0,
                                             0,
                                             0,
                                             '',
                                             '',
                                             '',
                                             IIF(fEmptyStr(strTabPre),'1', strTabPre),
                                             qryGenIte.FieldByName('ITE_IPIENT').AsFloat,
                                             qryGenIte.FieldByName('ITE_FREENT').AsFloat,
                                             '',
                                             0.0,
                                             '',
                                             0.0,
                                             'R',
                                             '',
                                             'N',
                                             '',
                                             0,
                                             FieldByName('QTDDEV_1').AsFloat,
                                             0.0,
                                             0,
                                             qryGenIte.FieldByName('ITE_IMPDIR').AsString,
                                             '',
                                             0.00,
                                             0.00,
                                             0.00,
                                             0,
                                             0,
                                             0,
                                             0,
                                             0,
                                             recForTin,
                                             '',
                                             '',
                                             IfThen(blnTemLot, strNumLotSai , ''),
                                             '',
                                             '',
                                             False,
                                             'N',
                                             'NOR',
                                             0,
                                             '',
                                             qryGenIte.FieldByName('ITE_CODBAR').AsString,
                                             '',
                                             0,
                                             0,
                                             0,
                                             '',
                                             1,
                                             True,
                                             '',
                                             '',
                                             '',
                                             0,
                                             FieldByName('PRECUS').AsFloat,
                                             '',
                                             '',
                                             recMadeira,
                                             qryGenIte.FieldByName('ITE_IMPULT').AsFloat * FieldByName('QTDDEV_1').AsFloat,
                                             0,
                                             0,
                                             '',
                                             0,
                                             '',
                                             '',
                                             0,
                                             0,
                                             '',
                                             '',
                                             0,
                                             '',
                                             'N',
                                             0,
                                             0,
                                             0,
                                             False,
                                             False,
                                             'N',
                                             '',
                                             0,
                                             0,
                                             '',
                                             'N',
                                             0,
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             0.00,
                                             '',
                                             '',
                                             '',
                                             'S',
                                             'N',
                                             '',
                                             '',
                                             '',
                                             '',
                                             False,
                                             -1,
                                             -1,
                                             'N',
                                             '',
                                             'N',
                                             0,
                                             0,
                                             0,
                                             '',
                                             0,
                                             0,
                                             0,
                                             '',
                                             0,
                                             0,
                                             0,
                                             '',
                                             '',
                                             0,
                                             0,
                                             0,
                                             False,
                                             '',
                                             '',
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
                                             '',
                                             '',
                                             0,
                                             0,
                                             '',
                                             '',
                                             'N',
                                             'N',
                                             '',
                                             0,
                                             0,
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             '',
                                             0,
                                             0,
                                             0,
                                             qryGenIte.FieldByName('ITE_MARMMV').AsFloat,
                                             qryGenIte.FieldByName('ITE_MARMMS').AsFloat,
                                             qryGenIte.FieldByName('ITE_MARMMG').AsFloat);

        {$Endregion}
        Next;

      End;

      EnableControls;
    End;

    Result := TRUE;

    FreeAndNil(qryGenIte);
    FreeAndNil(objCadLot);

  Except

    On E: Exception Do
    Begin
      Result := False;
			pMensagensErro(E.Message,'[TfrmGarantiaRecCliente.fIncluiItens]');
    End;

  End;
end;

function TfrmGarantiaEnvCliente.fGravaArquivos(objfatVenda : TFatVenda): Boolean;
begin
  Try
    objfatVenda.cdsMovGad  := cdsProdutos;

    objfatVenda.blnDTEXREP := True;
    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.strChave            := 'FATFATURA';
    frmGravando.fExecutarAcao       := objfatVenda.fGravaArquivos;
    frmGravando.lblGravando.Caption := 'Aguarde, Gravando Recebimento Cliente (Garantia)...';
    frmGravando.ShowModal;
    Result                          := frmGravando.blnConfirma;

    pFreeAndNil(frmGravando);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fConfirmaVenda - frmGravando]');
      pFreeAndNil(frmGravando);
    End;
  End;

end;

procedure TfrmGarantiaEnvCliente.cxgItensDBBandedTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if Not cdsProdutos.Active then
    Exit;

  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensDBTableView1Citel1Origem.Index]) = '1' Then
  begin
    ACanvas.Brush.Color := shpLegenda.Brush.Color;
    ACanvas.font.Color := clBlack;
  end;
end;

procedure TfrmGarantiaEnvCliente.pConfirmar;
Var
  lfrmGravando: TfrmGravando;
begin
  FblnResult := False;
  If cdsProdutos.State = dsEdit Then
  Begin
    cdsProdutos.Post;
    If blnMensagem Then
      Exit;
  End;

  cdsProdutos.DisableControls;
  Try
    Try
      pCriarFormularios(TfrmGravando,lfrmGravando);
      lfrmGravando.strChave            := '';
      lfrmGravando.fExecutarAcao       := fConfirmar;
      lfrmGravando.lblGravando.Caption := 'Aguarde...';
      lfrmGravando.ShowModal;
      pFreeAndNil(lfrmGravando);
    Except
      On E: Exception do
        pMensagensErro(e.Message, '[TfrmGarantiaEnvCliente.pConfirmar]');
    End;
  Finally
    cdsProdutos.EnableControls;
    if FblnResult then
    begin
      pLimparTela;
      pSetFocus(edtCodCli);
    end;
  End;
end;

function TfrmGarantiaEnvCliente.fConfirmar(pgbProgresso: TcxProgressBar): Boolean;

CONST
  OPERACAO_CREDITO = 0;
  OPERACAO_DEVOLUCAO = 1;
  OPERACAO_PREJUIZO = 2;

Var
  i, n: integer;

  lblnTemOpCredito,
  lblnTemDev,
  lblnTemPre: Boolean;

  lResultCredito,
  lResultDevolucao,
  lblnResultPrejuizo: Boolean;
begin
  lResultCredito := False;
  lResultDevolucao := False;
  lblnResultPrejuizo := False;
  Result := False;
  FpgbProgresso := pgbProgresso;

  TProgressBarFacade.pInfoStatusGravacao(Self, 'Iniciando, aguarde...');
  Try
    lblnTemDev := StrToIntDef(cdsProdutosAGG_QTDDEV_1.AsString,0) > 0;
    lblnTemPre := StrToIntDef(cdsProdutosAGG_QTDPRE_1.AsString,0) > 0;
    lblnTemOpCredito := StrToIntDef(cdsProdutosAGG_QTDCRE_1.AsString,0) > 0;

    n := 0;

    if lblnTemOpCredito then
      inc(n);

    if lblnTemPre then
      inc(n);

    if lblnTemDev then
      inc(n);

    TProgressBarFacade.pDefinir(Self, 0, 0, n);

    Try
      For i := 0 to 2 do
      begin
        if cdsProdutos.Filtered then
          cdsProdutos.Filtered := False;

        case ord(i) of
          {$Region 'Crédito'}
          OPERACAO_CREDITO:
          begin
            if Not lblnTemOpCredito then
              continue;

            TProgressBarFacade.pInfoStatusGravacao(Self, 'Iniciando operação para geração de crédito(s). Aguarde...');

            cdsProdutos.Filter := ' QTDCRE_1 >= 1 ';
            cdsProdutos.Filtered := True;

            if cdsProdutos.IsEmpty then
              continue;

            If fMensagem('', 'Confirma gerar crédito?', ['&Sim', '&Não']) = 2 Then
              Exit;

            pSepararItensProcessar;

            if fConfirmarCredito then
              lResultCredito := True
            else
              raise exception.create('Não foi possível gerar os créditos selecionados. A operação foi cancelada.');
            TProgressBarFacade.pInfoStatusGravacao(Self, 'Geração de crédito concluída....', True);
          end;
          {$Endregion}
          {$Region 'Devolução'}
          OPERACAO_DEVOLUCAO:
          begin
            if Not lblnTemDev then
              continue;

            TProgressBarFacade.pInfoStatusGravacao(Self, 'Iniciando saída (devolução/prejuízo)...', True);

            cdsProdutos.Filter := ' (QTDCRE_1 = 0) AND (QTDDEV_1 > 0) ';
            cdsProdutos.Filtered := True;

            if cdsProdutos.IsEmpty then
              continue;

            If fMensagem('', 'Confirma devolução?', ['&Sim', '&Não']) = 2 Then
              Exit;

            pSepararItensProcessar;

            lResultDevolucao := fConfirmarDevolucao;
            TProgressBarFacade.pInfoStatusGravacao(Self, 'Processo concluído...', True);
          end;
          {$Endregion}
          {$Region 'Prejuízo'}
          OPERACAO_PREJUIZO:
          begin
            if Not lblnTemPre then
              continue;

            TProgressBarFacade.pInfoStatusGravacao(Self, 'Iniciando saída (prejuízo)...', True);

            cdsProdutos.Filter := ' (QTDCRE_1 = 0) AND (QTDPRE_1 > 0) ';
            cdsProdutos.Filtered := True;

            if cdsProdutos.IsEmpty then
              continue;

            If fMensagem('', 'Confirma prejuízo ?', ['&Sim', '&Não']) = 2 Then
              Exit;

            pSepararItensProcessar;

            lblnResultPrejuizo := fConfirmarPrejuizo;
            TProgressBarFacade.pInfoStatusGravacao(Self, 'Processo concluído...', True);
          end;
          {$Endregion}
        end;
        if ((ord(i) =  OPERACAO_CREDITO) And lResultCredito) Or
             ((ord(i) =  OPERACAO_DEVOLUCAO) And lResultDevolucao)  Or
               ((ord(i) =  OPERACAO_PREJUIZO) And lblnResultPrejuizo) then
          pIncluirOrorrenciaCRM(i);
      end;

      Result := lResultCredito Or lResultDevolucao Or lblnResultPrejuizo;
    Except
      on e: Exception do
      begin
        pMensagensErro(e.Message, 'TfrmGarantiaEnvCliente.fConfirmar');
      end;
    End;
  finally
    FblnResult := Result;
    cdsprodutos.Filtered := False;
    cdsprodutos.Filter := EmptyStr;
    cdsProdutos.IndexFieldNames := EmptyStr;
    FpgbProgresso := Nil;
  end;
end;

function TfrmGarantiaEnvCliente.fConfirmarCredito: boolean;
Var
  i: Integer;
  lQry,
  lQryGag: TUniQuery;
  lstrSql,
  lstrIncCTR: String;
  lfltTotCrd: Double;
  lblnFalha,
  lblnQuebra: Boolean;
  lRecParGravaCADREC: TRecParGravaCADREC;
  larrIncGad: array of String;
begin
  lblnFalha := False;
  Result := False;

  //ordenando para gerar crédito aglutinando valores dos itens por documento de recebimento, favorecido e vendedor
  cdsProdutos.IndexFieldNames := 'INCGER;CODFAV;CODVEN';
  Try
    lRecParGravaCADREC.Create('');
    lRecParGravaCADREC.strNomFrmLogCtr := Self.Name;
    lRecParGravaCADREC.pdtaDtaCad := VS_Date;
    lRecParGravaCADREC.strCodDig := strLoginUsuarioLogado;
    lRecParGravaCADREC.strCodPor := FstrPortad;

    {$Region 'Prepara Query de atualização MovGad'}
    lstrSql := fGetSqlCredito;
    lQry := fCriaQuery;
    lQry.Close;
    lQry.Sql.Add(lstrSql);
    lQry.ParambyName('PSCREDI').AsInteger := 2;
    lQry.ParambyName('PDTACRE').AsDateTime := lRecParGravaCADREC.pdtaDtaCad;
    lQry.ParambyName('PHRACRE').AsDateTime := fNow;
    lQry.ParambyName('POPECRE').AsString := lRecParGravaCADREC.strCodDig;

    lQryGag := fCriaQuery;
    lQryGag.Close;
    lQryGag.Sql.Add(' UPDATE MOVGAG SET GAG_NUMCCR = :PNUMCCR WHERE AUTOINCREM = :PAUTINC ');
    {$Endregion}
    fStartTransaction;
    Try
      {Criar uma duplicada para aglutinando os itens por documento origem (incger),
       cliente favorecido (codfav) e vendedor (codven)}

      TProgressBarFacade.pDefinir(Self, 0, 0, cdsProdutos.RecordCount);

      cdsProdutos.First;
      While Not cdsProdutos.Eof do
      begin
        TProgressBarFacade.pInfoStatusGravacao(Self, 'Gerando crédito(s)...');
        lfltTotCrd := 0;
        lblnQuebra := False;

        lRecParGravaCADREC.strCodCli := cdsProdutos.FieldByName('CODFAV').AsString;
        lRecParGravaCADREC.strCodVen := cdsProdutos.FieldByName('CODVEN').AsString;
        lRecParGravaCADREC.strIncGer := cdsProdutos.FieldByName('INCGER').AsString;

        if pos('NF', cdsProdutos.FieldByName('DOCUMENTO').AsString) > 0 Then
        begin
          lRecParGravaCADREC.strEspecie := 'NF';
          lRecParGravaCADREC.strNumDup :=
            copy(cdsProdutos.FieldByName('DOCUMENTO').AsString, 1, 20);
        end
        else
        begin
          lRecParGravaCADREC.strNumDup :=
            untFuncoesSimples.fRetSequencial('PROCCO', VS_strCodEmp, fTamDocCadRec);
          lRecParGravaCADREC.strEspecie := 'CC';
        end;

        lRecParGravaCADREC.Historico1 := 'REF. LANC. CREDITO ( GARANTIA ) ' +
          cdsProdutos.FieldByName('DOCUMENTO').AsString;

        {$Region 'Atualizando MOVGAG'}
        lQryGag.ParambyName('PNUMCCR').AsString := lRecParGravaCADREC.strNumDup;
        lQryGag.ParambyName('PAUTINC').AsString := cdsProdutos.FieldByName('INCGAG').AsString;
        lQryGag.ExecSql;
        {$Endregion}
        SetLength(larrIncGad,0);
        {$Region 'Atualizando MOVGAD e acumulando valor total da duplicata'}
        While Not (cdsProdutos.Eof or lblnQuebra) do
        begin
          {$Region 'Verificando se mudou documento de origem, favorecido ou vendedor'}
          lblnQuebra :=
            (lRecParGravaCADREC.strIncGer <> cdsProdutos.FieldByName('INCGER').AsString) Or
              (lRecParGravaCADREC.strCodCli <> cdsProdutos.FieldByName('CODFAV').AsString) Or
                (lRecParGravaCADREC.strCodVen <> cdsProdutos.FieldByName('CODVEN').AsString);

          if lblnQuebra then
            continue;
          {$Endregion}

          SetLength(larrIncGad,length(larrIncGad)+1);
          larrIncGad[High(larrIncGad)] := cdsProdutos.FieldByName('AUTINC').AsString;
          lQry.ParambyName('PAUTINC').AsString := cdsProdutos.FieldByName('AUTINC').AsString;
          lQry.ExecSql;
          lfltTotCrd := lfltTotCrd + fValorTotalCreditoItem;
          cdsProdutos.Next;
          TProgressBarFacade.pInfoStatusGravacao(Self, 'Gerando crédito(s)...', True);
        end;
        {$Endregion}

        TProgressBarFacade.pInfoStatusGravacao(Self, 'Gravando duplicata...');
        lRecParGravaCADREC.fltValDup := -lfltTotCrd;

        if TfrmGarantiaRecCliente.fGravaCreditoClienteExec(lRecParGravaCADREC, lstrIncCTR) then
        begin
          for i := 0 to Length(larrIncGad) -1 do
          begin
            if Not TMovGag.fVincularCreditoAGarantia(larrIncGad[i], lstrIncCTR) then
              lblnFalha := True;
          end;
        end
        else
          lblnFalha := True;

        if lblnFalha then
          raise exception.Create('ocorreu uma falha e não foi possível criar o crédito para cliente.');
      end;
      fCommit;
      Result := True;
    Except
      On E: Exception do
      begin
        if Result then
          Result := False;
        fRollBack;
        pMensagensErro(e.Message, 'TfrmGarantiaEnvCliente.fConfirmarCredito');
      end;
    End;
  Finally
    if Assigned(lQry) Then
      FreeAndNil(lQry);
    cdsProdutos.IndexFieldNames := '';
    cdsProdutos.Filtered := False;
    cdsProdutos.Filter := '';
  End;
end;

function TfrmGarantiaEnvCliente.fGetSqlCredito: String;
begin
  Result :=          ' UPDATE MOVGAD ';
  Result := Result + ' SET ';
  Result := Result + '  GAD_SCREDI = :PSCREDI, ';
  Result := Result + '  GAD_DTACRE = :PDTACRE, ';
  Result := Result + '  GAD_HRACRE = :PHRACRE, ';
  Result := Result + '  GAD_OPECRE = :POPECRE  ';
  Result := Result + ' WHERE AUTOINCREM = :PAUTINC ';
end;

function TfrmGarantiaEnvCliente.fConfirmarDevolucao: Boolean;
begin
  Result := False;
  pCreateFatVendas;
  pCarregaDadosClienteGarantia(edtCodCli.Text, fatVenda);

  If Not (fGetTipoFaturamento(fatVenda) And
     fGetCfopEnvioCliente(fatVenda)) Then
    Exit;

  Try
    Try
      If fatVenda.strOpcDoc = 'OU' Then
      Begin
        if blnInformarEntregaRetiraGC then
          FEntregaRetira := fReposicaoEntregaRetira
        else
          FEntregaRetira := trRetira;

        cdsVenda.EmptyDataSet;
        fatVenda.strMen001 := '';
        fatVenda.strMen002 := '';
        fatVenda.strEntFat := FEntregaRetira.AsString_S_N;
        If fOutrasSaidasFaturamento Then
        Begin
          Result := fGravaArquivos(fatVenda);
          if Result then
          begin
            strNumRet := fatVenda.strNumDoc;
            objMovGag.objMovGad.fAtualizaProdutosDevolucao(FcdsItensProcessar, fatVenda.strNumDoc, 'NF');
          end
          else
            raise exception.Create('Ocorreu uma falha a operação não foi concluída.')
        End;

      End
      Else
      Begin
        strNumRet := fRetSequencial;

        Result := objMovGag.objMovGad.fAtualizaProdutosDevolucao(FcdsItensProcessar, strNumRet, 'GC');
        If Result Then
        Begin
          If Not fImprimirControleGarantia(strNumRet, 'GC', edtCodCli.Text, nil, TZClient(FcdsItensProcessar), False, tpeContGC) Then
            pImprimeDocumento;
        End;

        TTestabilidade.fGetTestabilidade.NumeroDocumento  := strNumRet;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[TfrmGarantiaEnvCliente.btnConfirmarClick]');
    End;
  Finally
    TControleChavesGarantia.pInicializar;
    pFreeCdsVenda;
    FreeAndNil(fatVenda);
  End;
end;

function TfrmGarantiaEnvCliente.fValidarQtdCredito: Boolean;
Var
  lSaldoARepor,
  lQtdCredito: Double;
begin
 if (cdsProdutos.FieldByName('QTDCRE_1').AsFloat = 0) Then
    Exit(True);

  Result := False;

  if (cdsProdutos.FieldByName('QTDCRE_1').AsFloat <> cdsProdutos.FieldByName('QTDREQ').AsFloat) then
  begin
    fMensagem('ATENÇÃO', 'A quantidade de crédito deve igual a quantidade requisitada', ['&Ok']);
    Exit;
  end;

  lQtdCredito := cdsProdutos.FieldByName('QTDCRE_1').AsFloat;

  lSaldoARepor := cdsProdutos.FieldByName('QTDREQ').AsFloat -
    cdsProdutos.FieldByName('QTDDEV').AsFloat -
      cdsProdutos.FieldByName('QTDDEV_1').AsFloat;

  If lQtdCredito > lSaldoARepor then
    fMensagem('ATENÇÃO', 'Quantidade a crédito informada é maior que a permitida!', ['&Ok'])
  else
    Result := True;

end;

function TfrmGarantiaEnvCliente.fValidarQtdDevolvida: Boolean;
Var
  lSaldoARepor,
  lQtdDevolver: Double;
begin
  Result := False;
  lQtdDevolver := cdsProdutos.FieldByName('QTDDEV_1').AsFloat ;

  lSaldoARepor := cdsProdutos.FieldByName('QTDREQ').AsFloat -
    cdsProdutos.FieldByName('QTDDEV').AsFloat -
      cdsProdutos.FieldByName('QTDCRE_1').AsFloat;

  If lQtdDevolver > lSaldoARepor then
    fMensagem('ATENÇÃO', 'Quantidade a devolver informada é maior que a permitida!', ['&Ok'])
  else
    Result := True;
end;

function TfrmGarantiaEnvCliente.fValidarQtdPrejuizo: Boolean;

begin
  if cdsProdutos.FieldByName('QTDPRE_1').AsFloat >
      (cdsProdutos.FieldByName('QTDREF').AsFloat - cdsProdutos.FieldByName('QTDPRE').AsFloat) then

  Begin
    fMensagem('ATENÇÃO', 'Quantidade de prejuízo informada maior que a permitida!', ['&Ok']);
    Result := False;
  End
  else
    Result := True;
end;

function TfrmGarantiaEnvCliente.fValorTotalCreditoItem: Double;
begin
  Result := cdsProdutos.FieldByName('QTDCRE_1').AsFloat *
    cdsProdutos.FieldByName('UNICRD').AsFloat;
end;


procedure TfrmGarantiaEnvCliente.pCarregarConfiguracoes;
begin
  blnInformarEntregaRetiraGC := fCfgSis('GGCDEF', varString) = 'S';
  FblnInfCli := fCfgSis('INFCLI', VarString) = 'S';
  FblnGeraCreditoNoRecebimento := (fCfgSis('CREGAR', varString) = '1');
  FstrPortad := fCfgSis('PORGAR', varString);
  FblnHabilitarImpressaoSeparacaoAvulsa := fCfgSis('GCHSEP', varString) = 'S';
end;

function TfrmGarantiaEnvCliente.fGetProgressBar: TcxProgressBar;
begin
  Result := FpgbProgresso;
end;



procedure TfrmGarantiaEnvCliente.pLimparTela;
begin
  cdsProdutos.EmptyDataSet;
  edtCodCli.Clear;
  edtNomCli.Clear;
end;

procedure TfrmGarantiaEnvCliente.pSepararItensProcessar;
begin
  FcdsItensProcessar := fObterCdsItensProcessar;
  FcdsItensProcessar.EmptyDataSet;
  cdsProdutos.First;
  While Not cdsProdutos.Eof do
  begin
    FcdsItensProcessar.Append;
    pCarregaItensDestino(cdsProdutos, FcdsItensProcessar);
    FcdsItensProcessar.Post;
    cdsProdutos.Next;
  end;
end;

procedure TfrmGarantiaEnvCliente.cxgItensDBBandedTableView1EditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = VK_RETURN then
  begin
    if cdsProdutos.State in [dsEdit, dsInsert] then
      cdsProdutos.CheckBrowseMode;
  end;
end;

procedure TfrmGarantiaEnvCliente.pCarregaItensDestino(pdsOrigem,
  pdsDestino: TDataSet);
Var
  lField: TField;
begin
  for lField in pdsOrigem.Fields do
  begin
    if Assigned(pdsDestino.FindField(lField.FieldName)) then
     pdsDestino.FieldByName(lField.FieldName).Value := lField.Value;
  end;
end;

function TfrmGarantiaEnvCliente.fConfirmarPrejuizo: Boolean;
begin
  Result := False;

  Try
    strNumRet := fRetSequencial;
    Result := objMovGag.objMovGad.fAtualizaProdutosDevolucao(FcdsItensProcessar, strNumRet, 'GC');

    If Result Then
    Begin
      If Not fImprimirControleGarantia(strNumRet, 'GC', edtCodCli.Text, nil, TZClient(FcdsItensProcessar), False, tpeContGC) Then
        pImprimeDocumento;
    End;

    TTestabilidade.fGetTestabilidade.NumeroDocumento  := strNumRet;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TfrmGarantiaEnvCliente.btnConfirmarClick]');
  End;

end;

function TfrmGarantiaEnvCliente.fObterCdsItensProcessar: TUniClientDataSet;
begin
  if Not Assigned(FcdsItensProcessar) then
  begin
    FcdsItensProcessar := TUniClientDataSet.Create(Self);
    FcdsItensProcessar.FieldDefs := cdsProdutos.FieldDefs;
    FcdsItensProcessar.CreateDataSet;
  end;
  Result := FcdsItensProcessar;
end;

End.

