unit untEntMercadoriasAutomatizada;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untEntradaAutomatizada, EditFocus, Vcl.Mask, UniClientDataSet,
  MaskEditFocus, QColorLabel, Vcl.ComCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCitel, cxClasses, cxGridLevel, cxGrid, cxCurrencyEdit, cxMaskEdit, MaskUtils,
  Vcl.DBCtrls, DBEditFocus,
  untTypesSistema, cxDBLookupComboBox,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  untFrameCentroCustoEditFocus, Math, Vcl.CheckLst, Uni, MemoFocus, untLiberacao,
  ComboBoxFocus, cxTextEdit, cxDropDownEdit, cxInplaceContainer, cxVGrid, cxDBVGrid;

type
  TfrmEntMercadoriasAutomatizada = class(TfrmPaiConfirma)
    pgcAbas: TPageControl;
    tbsItens: TTabSheet;
    tbsLivro: TTabSheet;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lblCliFor: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblCgcCpf: TLabel;
    mskDtaEnt: TMaskEditFocus;
    edtNumDoc: TEditFocus;
    edtSerie: TEditFocus;
    mskDtaDoc: TMaskEditFocus;
    edtEspDoc: TEditFocus;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtCgcCpf: TEditFocus;
    cxgItensLevel1: TcxGridLevel;
    cxvItens: TcxGridDBTableViewCitel;
    cxgItens: TcxGridCitel;
    cxvItensCODBAR: TcxGridDBColumn;
    cxvItensDESITE: TcxGridDBColumn;
    cxvItensQTDITE: TcxGridDBColumn;
    cxvItensUNITAR: TcxGridDBColumn;
    cxvItensVALTOT: TcxGridDBColumn;
    cxvItensCODCTU: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxvItensDESCTA: TcxGridDBColumn;
    Panel1: TPanel;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label32: TLabel;
    edtDesEsp: TEditFocus;
    Label11: TLabel;
    Label12: TLabel;
    edtTotIte: TEditFocus;
    pnlDetalhes: TPanel;
    vgrDetalhes: TcxDBVerticalGrid;
    rowTitulos: TcxDBMultiEditorRow;
    rowClfSc: TcxDBMultiEditorRow;
    rowVlCon: TcxDBMultiEditorRow;
    rowDAces: TcxDBMultiEditorRow;
    rowBasIc: TcxDBMultiEditorRow;
    rowAlqIc: TcxDBMultiEditorRow;
    rowVlrIc: TcxDBMultiEditorRow;
    rowOutra: TcxDBMultiEditorRow;
    rowIsent: TcxDBMultiEditorRow;
    rowBcRet: TcxDBMultiEditorRow;
    rowRetId: TcxDBMultiEditorRow;
    rowBasAn: TcxDBMultiEditorRow;
    rowAntIc: TcxDBMultiEditorRow;
    rowBaeRe: TcxDBMultiEditorRow;
    rowVaeRe: TcxDBMultiEditorRow;
    rowBasIp: TcxDBMultiEditorRow;
    rowVlrIp: TcxDBMultiEditorRow;
    rowBaeIp: TcxDBMultiEditorRow;
    rowVaeIp: TcxDBMultiEditorRow;
    rowBFCPS: TcxDBMultiEditorRow;
    rowVFCPS: TcxDBMultiEditorRow;
    rowBcCbs: TcxDBMultiEditorRow;
    rowVlCbs: TcxDBMultiEditorRow;
    rowBcIbs: TcxDBMultiEditorRow;
    rowVlIbs: TcxDBMultiEditorRow;
    rowBc_Is: TcxDBMultiEditorRow;
    rowVl_Is: TcxDBMultiEditorRow;
    rowQBCMo: TcxDBMultiEditorRow;
    rowValMo: TcxDBMultiEditorRow;
    cxStyleRepositoryDetalhes: TcxStyleRepository;
    cxsTituloDetalhes: TcxStyle;
    dtsCadFis: TDataSource;
    DBEditFocus1: TDBEditFocus;
    DBEditFocus2: TDBEditFocus;
    DBEditFocus3: TDBEditFocus;
    DBEditFocus4: TDBEditFocus;
    DBEditFocus5: TDBEditFocus;
    DBEditFocus6: TDBEditFocus;
    DBEditFocus7: TDBEditFocus;
    tbsCtaPag: TTabSheet;
    Panel2: TPanel;
    Label33: TLabel;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    DBEditFocus8: TDBEditFocus;
    Label36: TLabel;
    DBEditFocus9: TDBEditFocus;
    pnlCtaPag: TPanel;
    pnlEventos: TPanel;
    Panel4: TPanel;
    btnExcEve: TBitBtnLocked;
    Panel5: TPanel;
    Label34: TLabel;
    edtValEve: TEditFocus;
    cxgEventos: TcxGridCitel;
    cxvEventos: TcxGridDBTableViewCitel;
    cxvEventosCODEVE: TcxGridDBColumn;
    cxvEventosVALEVE: TcxGridDBColumn;
    cxgEventosLevel1: TcxGridLevel;
    Panel7: TPanel;
    cxgParcelas: TcxGridCitel;
    cxvParcelas: TcxGridDBTableViewCitel;
    cxvParcelasDTAVEN: TcxGridDBColumn;
    cxvParcelasVALDUP: TcxGridDBColumn;
    cxgParcelasLevel1: TcxGridLevel;
    Panel3: TPanel;
    btnAlterar: TBitBtnLocked;
    lblCondPgto: TLabel;
    mskCndPag: TMaskEditFocus;
    cxvItensVLRCON: TcxGridDBColumn;
    fraCentroCusto: TfraCentroCustoEditFocus;
    chkPgoAnt: TCheckBox;
    lblTemPgtoAntecipado: TLabel;
    btnPgoAnt: TBitBtnLocked;
    pnlEmpresasRateioDespesas: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Label39: TLabel;
    lstEmpRateioDespesa: TCheckListBox;
    Label40: TLabel;
    edtHistor: TMemoFocus;
    chkGerarFinanceiro: TCheckBox;
    chkVeioBo: TCheckBox;
    chkDeposi: TCheckBox;
    chkImprCP: TCheckBox;
    cbxBcoFor: TComboBoxFocus;
    lblBcoFor: TLabel;
    bbtnDesmembrarValores: TBitBtnLocked;
    cbxCODMOD: TComboBoxFocus;
    lblCODMOD: TLabel;
    cxvItensNROITE: TcxGridDBColumn;
    cxvItensCODCST: TcxGridDBColumn;
    cxvItensCDCFOP: TcxGridDBColumn;
    cxvItensNatOpe: TcxGridDBColumn;
    btnReplica: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure cxvItensEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure cxvItensCODCTUGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxvItensCODCTAPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvItensEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorExit(Sender: TObject);
    procedure btnExcEveClick(Sender: TObject);
    procedure edtValEveEnter(Sender: TObject);
    procedure cxvEventosVALEVEPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
    procedure mskCndPagExit(Sender: TObject);
    procedure cxvEventosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxvItensKeyPress(Sender: TObject; var Key: Char);
    procedure fraCentroCustoedtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure btnPgoAntClick(Sender: TObject);

    procedure chkPgoAntClick(Sender: TObject);
    procedure pGetDisplayTextTitulo(Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: String);
    procedure pGetDisplayTextValor(Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: String);
    procedure pGetDisplayTextClaFis(Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: String);
    procedure pGetContentStyleDetalhes(Sender: TObject; AEditProp: TcxCustomEditorRowProperties;
      AFocused: Boolean; ARecordIndex: Integer; var AStyle: TcxStyle);
    procedure vgrDetalhesEditing(Sender: TObject; ARowProperties: TcxCustomEditorRowProperties;
      var Allow: Boolean);
    procedure vgrDetalhesEdited(Sender: TObject; ARowProperties: TcxCustomEditorRowProperties);
    procedure tbsLivroShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure chkGerarFinanceiroClick(Sender: TObject);
    procedure chkVeioBoClick(Sender: TObject);
    procedure cbxBcoForChange(Sender: TObject);
    procedure cbxBcoForDropDown(Sender: TObject);
    procedure cbxBcoForEnter(Sender: TObject);
    procedure cbxBcoForExit(Sender: TObject);
    procedure cbxBcoForKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkDeposiClick(Sender: TObject);
    procedure pgcAbasChange(Sender: TObject);
    procedure bbtnDesmembrarValoresClick(Sender: TObject);
    procedure cxvItensCODCSTPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvItensCDCFOPPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvItensCDCFOPPropertiesEditValueChanged(Sender: TObject);
    procedure cxgItensExit(Sender: TObject);
    procedure cxvItensEditChanged(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem);
    procedure cxvItensNatOpeGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure btnReplicaClick(Sender: TObject);
    procedure cxvItensCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);

  private
    { Private declarations }
    arrPortador: TConsultasArray;
    OldCfop,
    strCfop, strNatOp: String;
    objLiberacao  : TLiberacao;
    blnPortadorObrigatorioContasPagar: Boolean;
    intIdxBcoForAnt: Integer;
    lstBcoFor: TStringList;
    strCndAnt: String;
    blnUtilizaFluxoCompraItensConsumo: Boolean;
    blnIncluirHistoricoContasPagar: Boolean;
    cdsNatOpe: TUniClientDataSet;
    FblnEditandoCfop: Boolean;
    procedure pAjustaDecimais;
    function fRetVlrContabilCadFis: Double;
    function fCampoDetalhes(const ARowProperties: TcxCustomEditorRowProperties): String;
    procedure pConfirmaTrocaCfop(const AstrCfop: String);
    procedure pAjustaLinhasDetalhes;
    procedure pAjustarFundoTema;
    procedure pMostraDadosCabecalho;
    procedure pMostraDadosCabecalhoFiscal;
    procedure pMostraDadosCtaPag;
    procedure pAjustaTelaPgoAntecipado;
    procedure pCarregaLstEmpresa;
    procedure pDesmembrarValores;

    procedure pCarregaDadosBancariosFornecedor(const strCodFor: String);
    function fGetBcoFor: String;

    procedure pInserirDocumentoHistoricoContasPagar;
    function fConfirmarAnularDesdobramento: Boolean;
    function fLiberarValorBoleto: Boolean;
    function fTotalBoleto: Currency;
    function fGetModDocumentocbxCODMOD: String;
    function fValidaCST(ACodCST, ACodCFOP: String; AShwMsg: Boolean = True): Boolean;

    procedure pCarregaCacheNaturezaOperacao;
    procedure pReplicaNatOp;
  public
    { Public declarations }
    objEntrada: TEntradaAutomatizada;
    fltValorDocumento: Double;
    procedure pSetaModelo;
    procedure pCarregaModFis(strChave: String = '');


    property strBcoFor: String read fGetBcoFor;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

Uses
  cxGridDBDataDefinitions,
  untFuncoesSimples,
  untFuncoes,
  untConsultas,
  untConstantes,
  untFuncoesConsulta,
  StrUtils, untDigCodBarBoleto,
  untFuncIns,
  untCadPag,
  untPcmGer,
  untDuplicatas, Vcl.Themes;

procedure TfrmEntMercadoriasAutomatizada.bbtnDesmembrarValoresClick(
  Sender: TObject);
begin
  inherited;
  pDesmembrarValores;
end;



procedure TfrmEntMercadoriasAutomatizada.btnAlterarClick(Sender: TObject);
begin
  inherited;

  objEntrada.fPedeDuplicatas;
  pCarregaDadosBancariosFornecedor(objEntrada.recDadFor.strCodFor);

end;

procedure TfrmEntMercadoriasAutomatizada.btnConfirmaClick(Sender: TObject);
begin
  if chkVeioBo.Visible then
    objEntrada.recDadNot.strVeioBoleto := ifthen(chkVeioBo.Checked,'S','N');

  if chkDeposi.Visible then
    objEntrada.recDadNot.strDeposi := ifthen(chkDeposi.Checked,'S','N');

  if chkImprCP.Visible then
    objEntrada.recDadNot.blnImprCp := chkImprCP.Checked;

  if cbxBcoFor.Visible then
    objEntrada.recDadNot.strBcoFor := strBcoFor;

  If Not fValidaObrigatoriedadeChaveModelo(objEntrada.recNotEle.str_Chave, fGetModDocumentocbxCODMOD) Then
  Begin
    pMensagemOk('O Modelo selecionado exige a chave de acesso!');
    ModalResult:= 0;
    Exit;
  End;
  objEntrada.recDadNot.strModelo := fGetModDocumentocbxCODMOD;

  If Not(chkGerarFinanceiro.Checked) Then
  Begin
    If Not(fVerificaAcessoSistema('CTPEMC', strLoginUsuarioLogado)) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'CTPEMC';
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('Operador sem permissão para esta operação!');


      If Not(objLiberacao.fLibera) Then
      Begin
        objEntrada.recDadNot.blnGravaCtaPag := True;
        ModalResult:= 0;
        Exit;
      End
      Else
        objEntrada.recDadNot.blnGravaCtaPag := False;

    End
    Else
      objEntrada.recDadNot.blnGravaCtaPag := False;
  End
  Else
  Begin
    objEntrada.recDadNot.blnGravaCtaPag:= objEntrada.fGravaContasPagar(objEntrada.cdsItens.FieldByName('ENT_CLAFIS').AsString, objEntrada.recDadFor.strCodFor);
  End;

  inherited;

end;

procedure TfrmEntMercadoriasAutomatizada.btnExcEveClick(Sender: TObject);
begin
  inherited;
  if Not fConfirmarAnularDesdobramento then
    Exit;

  objEntrada.pExcluiEvento;
end;

procedure TfrmEntMercadoriasAutomatizada.btnPgoAntClick(Sender: TObject);
begin
  inherited;
  objEntrada.pCalculaValorDocumento;
  chkPgoAnt.Checked := objEntrada.objPgoAnt.fSelecionaDuplicatas(objEntrada.fltValorDocumento, 0);

  pAjustaTelaPgoAntecipado;

  SelectNext(ActiveControl, True, True);
end;

procedure TfrmEntMercadoriasAutomatizada.pReplicaNatOp;
begin
  objEntrada.cdsItens.DisableControls;

  try
    objEntrada.cdsItens.First;
    While Not(objEntrada.cdsItens.Eof) do
    Begin
      IF (objEntrada.cdsItens.FieldByName('ENT_CLAFIS').AsString = strCFOP) And
         fEmptyStr(objEntrada.cdsItens.FieldByName('ENT_NATOPE').AsString) Then
      Begin
        objEntrada.cdsItens.Edit;
        objEntrada.cdsItens.FieldByName('ENT_NATOPE').AsString := strNatOp;
        objEntrada.cdsItens.Post;
      End;

      objEntrada.cdsItens.Next;
    End;
  finally
    objEntrada.cdsItens.EnableControls;
  end;

  pMensagemOk('Processo Concluído.');
end;

procedure TfrmEntMercadoriasAutomatizada.btnReplicaClick(Sender: TObject);
begin
  inherited;
  If Not Assigned(objEntrada) Then
    Exit;

  If objEntrada.cdsItens.IsEmpty Then
    Exit;

  If Not fEmptyStr(strNatOp) Then
  Begin
    if fMensagem('',
              'Deseja replicar a Natureza de Operação para todos os '+sLineBreak+
              'Itens que estão em Branco e possuem o CFOP '+strCfop+' ?',
              ['&Sim','&Não']) = 1 then
      pReplicaNatOp;
  End;
end;

procedure TfrmEntMercadoriasAutomatizada.pAjustaTelaPgoAntecipado;
Begin
  If chkPgoAnt.Checked Then
  Begin
    btnPgoAnt.Enabled := True;
    mskCndPag.Enabled := objEntrada.fTemAntecipadoValorMenor;
    mskCndPag.Clear;
    pZeraDigDuplic(objEntrada.arrDuplicata);
    objEntrada.pLimpaCDSDuplicata;

  End Else
  Begin
    btnPgoAnt.Enabled := False;
    mskCndPag.Clear;
    pZeraDigDuplic(objEntrada.arrDuplicata);
    objEntrada.pLimpaCDSDuplicata;
    mskCndPag.Enabled := True;
    objEntrada.objPgoAnt.pSetaListaSelecao(Nil);
  End;
End;

procedure TfrmEntMercadoriasAutomatizada.cbxBcoForChange(Sender: TObject);
begin
  inherited;
  intIdxBcoForAnt := cbxBcoFor.ItemIndex;
end;


procedure TfrmEntMercadoriasAutomatizada.cbxBcoForDropDown(Sender: TObject);
begin
  inherited;
  SendMessage(cbxBcoFor.Handle, CB_SETDROPPEDWIDTH, 315, 0);
end;



procedure TfrmEntMercadoriasAutomatizada.cbxBcoForEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'INSERT para incluir/alterar dados bancários do fornecedor';
end;

procedure TfrmEntMercadoriasAutomatizada.cbxBcoForExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmEntMercadoriasAutomatizada.cbxBcoForKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key =  VK_Insert) Then
  Begin
    pCarregaDadosBancariosFornecedor(objEntrada.recDadFor.strCodFor);
  End;
end;

procedure TfrmEntMercadoriasAutomatizada.chkDeposiClick(Sender: TObject);
begin
  inherited;
  cbxBcoFor.Enabled := chkDeposi.Checked;
  if (chkDeposi.checked) and (chkVeioBo.checked) then
  begin
    chkVeioBo.Checked := False;
    objEntrada.blnVeioBoleto := False;
    objEntrada.intQtdPar     := 0;
  end;

  If Not cbxBcoFor.Enabled Then
    cbxBcoFor.ItemIndex := -1;


end;

procedure TfrmEntMercadoriasAutomatizada.chkGerarFinanceiroClick(
  Sender: TObject);
begin
  inherited;
  objEntrada.recDadNot.blnGravaCtaPag:= chkGerarFinanceiro.Checked;
end;

procedure TfrmEntMercadoriasAutomatizada.chkPgoAntClick(Sender: TObject);
begin
  inherited;
  objEntrada.blnPgoAnt := chkPgoAnt.Checked;
  pAjustaTelaPgoAntecipado;
end;

procedure TfrmEntMercadoriasAutomatizada.chkVeioBoClick(Sender: TObject);
begin
  inherited;
  if (chkDeposi.checked) and (chkVeioBo.checked) then
  begin
    chkDeposi.Checked  := False;
    cbxBcoFor.ItemIndex := -1;
  end;
  objEntrada.blnVeioBoleto := chkVeioBo.Checked;
  If (Not mskCndPag.Enabled) And (Length(objEntrada.arrDuplicata) > 0) And
     ((fCfgSis('CTPBOL', varBoolean)) And (chkVeioBo.Checked) And
      (fTiraCaracEspeciaisPonto(mskCndPag.Text) <> '01000') And
      (Not fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text))) And
      (objEntrada.arrDuplicata[0].strSequen <> '')) Then
   Begin
     pCriarFormularios(TfrmDigCodBarBoleto, frmDigCodBarBoleto);
     frmDigCodBarBoleto.arrLinDigCodbar := objEntrada.arrLinDigCodbar;
     frmDigCodBarBoleto.arrDuplicata := @objEntrada.arrDuplicata;
     Try
       frmDigCodBarBoleto.ShowModal;
     Finally
       Begin
        objEntrada.arrLinDigCodbar      := frmDigCodBarBoleto.arrLinDigCodbar;
        objEntrada.intQtdPar            := frmDigCodBarBoleto.intQtdPar;
        FreeAndNil(frmDigCodBarBoleto);
       End;
     End;
   End;
end;

procedure TfrmEntMercadoriasAutomatizada.cxgItensExit(Sender: TObject);
Var
  LTemDiverg: Boolean;
begin
  inherited;

  strCfop := cxvItens.DataController.DataSet.FieldByName('ENT_CLAFIS').AsString;
  strNatOp := cxvItens.DataController.DataSet.FieldByName('ENT_NATOPE').AsString;

  LTemDiverg := False;

  If (objEntrada.cdsItens.State in [dsEdit]) Then
    objEntrada.cdsItens.Post;

  objEntrada.cdsItens.DisableControls;

  try
    objEntrada.cdsItens.First;
    While Not objEntrada.cdsItens.Eof DO
    Begin
      If (Not fValidaCST(objEntrada.cdsItens.FieldByName('ENT_CODFIS').AsString,
                         objEntrada.cdsItens.FieldByName('ENT_CLAFIS').AsString, False)) Then
      Begin
        LTemDiverg := True;
        Break;
      End;

      objEntrada.cdsItens.Next;
    End;

    If (LTemDiverg) Then
    Begin
      pgcAbas.ActivePage := tbsItens;
      pSetFocus(cxgItens);
      pMensagemOk('Atenção: Existem divergências entre as CSTs informadas!');
    End;

  finally
    objEntrada.cdsItens.EnableControls;
  end;
end;

procedure TfrmEntMercadoriasAutomatizada.cxvEventosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

   Case Key Of
    VK_DELETE: btnExcEve.Click;

    VK_RETURN: If objEntrada.cdsMovEve.State = dsEdit Then
               Begin
                 objEntrada.cdsMovEve.Post;

                 If cxvItensCODCTU.Focused Then
                   cxvItens.NavigatorButtons.Next.Click;
               End;

  End;

end;

procedure TfrmEntMercadoriasAutomatizada.cxvEventosVALEVEPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  If fStrToFloat(DisplayValue) <= 0 Then
  Begin
    pMensagemOk('Informe um valor maior que zero para o Centro de Custo!');
    Error := True;
    ErrorText := '';
  End;
end;

procedure TfrmEntMercadoriasAutomatizada.cxvItensCODCTUGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;

  If Not Assigned(objEntrada) Then
    Exit;

  If objEntrada.cdsItens.IsEmpty Then
    Exit;

  AText := FormatMaskText(MASC_CODCTA, AText) + ' - ' +
           VarToStr(Sender.DataBinding.DataController.Values[ARecord.RecordIndex, cxvItensDESCTA.Index]);
end;

procedure TfrmEntMercadoriasAutomatizada.cxvItensCDCFOPPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  objEntrada.FAtualizaLivroFiscal := True;
  cxvItens.DataController.PostEditingData;
  objEntrada.cdsItens.FieldByName('ENT_NATOPE').Clear;
end;

procedure TfrmEntMercadoriasAutomatizada.cxvItensCDCFOPPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If fEmptyStr(DisplayValue) Then
  Begin
    ErrorText := '';
    Error     := True;
    pMensagemOk('CFOP é obrigatória!');
  End
  Else If (Not EhNumero(DisplayValue)) Then
  Begin
    ErrorText := '';
    Error     := True;
    pMensagemOk('CFOP inválida!');
  End
  Else If (Pos(fCfgSis('COMLUB'), DisplayValue) <= 0 ) And (Not objEntrada.fCFOPPodeSerUtilizada(DisplayValue)) Then
  Begin
    ErrorText := '';
    Error     := True;
    pMensagemOk('CFOP não pode ser utilizada pois ela não pertence a configuração [CFG_CFEAAL].');
  End;

end;

procedure TfrmEntMercadoriasAutomatizada.cxvItensCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  strCfop := cxvItens.DataController.DataSet.FieldByName('ENT_CLAFIS').AsString;
  strNatOp := cxvItens.DataController.DataSet.FieldByName('ENT_NATOPE').AsString;
end;

procedure TfrmEntMercadoriasAutomatizada.cxvItensCODCSTPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If fEmptyStr(DisplayValue) Then
  Begin
    ErrorText := '';
    Error     := True;
    pMensagemOk('CST é obrigatória!');
  End
  Else If (Not EhNumero(DisplayValue)) Or (Length(DisplayValue) < 3) Then
  Begin
    ErrorText := '';
    Error     := True;
    pMensagemOk('CST inválida!');
  End
  Else If (Not fValidaCST(DisplayValue, objEntrada.cdsItens.FieldByName('ENT_CLAFIS').AsString)) Then
  Begin
    ErrorText := '';
    Error     := True;
  End;

end;

function TfrmEntMercadoriasAutomatizada.fValidaCST(ACodCST: String; ACodCFOP: String; AShwMsg: Boolean = True): Boolean;
Var
  LSubstituido: Boolean;
  LCodCSTItem : String;
Begin
  Result := True;

  If fCfgSis('CSTEUC', varInteger) = 0 Then
  Begin
    If (Pos(Copy(ACodCST, 2, 2), '90') <= 0 ) Then
    Begin
      If (AShwMsg) Then
        pMensagemOk('Permitido apenas CST x90 devido configuração [CSTEUC]!');
      Result := False;
    End;
  End
  Else
  Begin

    LCodCSTItem := objEntrada.fGetCodFisItem(objEntrada.cdsItens.FieldByName('ENT_CODABF').AsString,
                                  objEntrada.cdsItens.FieldByName('ENT_CODITE').AsString,
                                  objEntrada.cdsItens.FieldByName('ENT_CODEMP').AsString);

    LSubstituido := Pos(LCodCSTItem, CST_SUBSTITUICAO) > 0;

    If (Pos(ACodCFOP, '1407_2407') > 0) And LSubstituido Then
    Begin
      If (Pos(Copy(ACodCST, 2, 2), '60') <= 0 ) Then
      Begin
        If (AShwMsg) Then
          pMensagemOk('Permitido apenas CST x60 devido configuração [CSTEUC]!');
        Result := False;
      End;
    End
    Else
    Begin
      If (Pos(Copy(ACodCST, 2, 2), '90') <= 0 ) Then
      Begin
        If (AShwMsg) Then
          pMensagemOk('Permitido apenas CST x90 devido configuração [CSTEUC]!');
        Result := False;
      End;
    End;
  End;
End;

procedure TfrmEntMercadoriasAutomatizada.cxvItensCODCTAPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  Var
    strCodCta,
    strDesCta: String;
begin
  inherited;

  strCodCta := fTiraCaracEspeciaisPonto(DisplayValue);

  If btnSair.Focused Then
    Exit;

  If SameText(RightStr(strCodCta, 3), '000') Then
  Begin
    ErrorText := '';
    Error     := True;
    pMensagemOk('Plano de Contas não permitido!');
  End

  Else If (Not fEmptyStr(strCodCta)) Then
  Begin

    strDesCta := fRetDescCentroCusto(strCodCta);

    If fEmptyStr(strDesCta) Then
    Begin
      ErrorText := '';
      Error     := True;
      pMensagemOk('Plano de Contas ' + FormatMaskText(MASC_CODCTA, strCodCta)  + ' não encontrado!');
    End

    Else If objEntrada.cdsItens.State = dsEdit Then
    Begin
      objEntrada.cdsItens.FieldByName('ENT_DESCTA').AsString := strDesCta;
    End;

  End;
end;

procedure TfrmEntMercadoriasAutomatizada.cxvItensEditChanged(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
begin
  inherited;
  if AItem = cxvItensNatOpe then
    objEntrada.FAtualizaLivroFiscal := True;
end;

procedure TfrmEntMercadoriasAutomatizada.cxvItensEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
  Var
    intRecNo: Integer;
begin
  inherited;

  Case Key Of
    VK_RETURN: With objEntrada.cdsItens Do
               If SameText(TcxGridItemDBDataBinding(AItem.DataBinding).FieldName, 'ENT_CODCTU') And
                  (State = dsEdit) Then
               Begin
                 Post;

                 intRecNo := RecNo;

                 cxvItens.NavigatorButtons.Next.Click;

                 If (intRecNo = RecNo) And objEntrada.fValidaCodCtas(False) Then
                   pgcAbas.ActivePageIndex := 1;
               End;
   End;

end;

procedure TfrmEntMercadoriasAutomatizada.cxvItensEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
  Var
    arrPlanoCta: TConsultasArray;
begin
  inherited;

  With objEntrada.cdsItens Do
  If SameText(TcxGridItemDBDataBinding(AItem.DataBinding).FieldName, 'ENT_CODCTU') Then
  Begin

    If fEntraCons(key) And fPesqCentroCusto(Self, Nil, Nil, Nil, Key, arrPlanoCta, False) Then
    Begin
      If State <> dsEdit Then
        Edit;

      FieldByName('ENT_CODCTU').AsString := arrPlanoCta[0].strCodigo;
      FieldByName('ENT_DESCTA').AsString := arrPlanoCta[0].strDescri;

      Post;

      cxvItens.NavigatorButtons.Next.Click;

    End;

  End;
end;

procedure TfrmEntMercadoriasAutomatizada.cxvItensKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrPlanoCta: TConsultasArray;
begin
  inherited;
  With objEntrada.cdsItens Do
  If cxvItensCODCTU.Focused Then
  Begin
    If fEntraCons(key) And fPesqCentroCusto(Self, Nil, Nil, Nil, Key, arrPlanoCta, False) Then
    Begin
      If State <> dsEdit Then
        Edit;

      FieldByName('ENT_CODCTU').AsString := arrPlanoCta[0].strCodigo;
      FieldByName('ENT_DESCTA').AsString := arrPlanoCta[0].strDescri;

      Post;

      cxvItens.NavigatorButtons.Next.Click;

    End;
  End;

end;


procedure TfrmEntMercadoriasAutomatizada.cxvItensNatOpeGetProperties(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
var
  cmbNaturezaDaOperacao: TcxComboBoxProperties;
begin
  inherited;

  if not Assigned(cdsNatOpe) then
    Exit;

  if VarIsNull(ARecord.Values[cxvItensCDCFOP.Index]) then
    Exit;

  cmbNaturezaDaOperacao := TcxComboBoxProperties.Create(Self);

  cdsNatOpe.Filtered := False;
  cdsNatOpe.Filter := 'NAT_CODCFO = '+QuotedStr(ARecord.Values[cxvItensCDCFOP.Index]);
  cdsNatOpe.Filtered := True;

  cdsNatOpe.First;
  while not cdsNatOpe.Eof do
  begin
    cmbNaturezaDaOperacao.Items.Add(cdsNatOpe.FieldByName('NAT_DESCRI').AsString);
    cdsNatOpe.Next;
  end;

  cmbNaturezaDaOperacao.DropDownListStyle := lsFixedList;
  AProperties := cmbNaturezaDaOperacao;

end;

procedure TfrmEntMercadoriasAutomatizada.edtCodPorExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodPor, edtNomPor, arrPortador, Nil, fRetNomPortador, 'do Portador');

end;

procedure TfrmEntMercadoriasAutomatizada.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqPortador(conSimples, Self, edtCodPor, edtNomPor, Nil, Key, arrPortador) then
  Begin
    If fValidaCampos(edtCodPor, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmEntMercadoriasAutomatizada.edtValEveEnter(Sender: TObject);
  Var
    fltVlrCon,
    fltValEve: Double;
begin
  inherited;
  if Not fConfirmarAnularDesdobramento then
    Exit;

  With objEntrada Do
  If Not fEmptyStr(fraCentroCusto.EdtCodEve.Text) Then
  Begin

    If cdsMovEve.FindKey([fraCentroCusto.EdtCodEve.Text]) Then
      edtValEve.Text := FormatFloat('#0.00', cdsMovEve.FieldByName('VALEVE').AsFloat)

    Else If cdsItens.fRetSomaCampo('ENT_VLRCON') - cdsMovEve.fRetSomaCampo('VALEVE') > 0 Then
    Begin
      fltVlrCon := cdsItens.fRetSomaCampo('ENT_VLRCON');
      fltValEve := cdsMovEve.fRetSomaCampo('VALEVE');
      edtValEve.Text := FormatFloat('#0.00', fltVlrCon - fltValEve);
    End;

  End;

end;

function TfrmEntMercadoriasAutomatizada.fConfirmarAnularDesdobramento: Boolean;
begin
  if objEntrada.cdsCtpDet.IsEmpty then
    Exit(True);

  Result := fMensagem('Atenção!',
                      'Existe rateio realizado via rotina de "Desmembramento de Valores" [F8]. '+sLineBreak+
                      'Se continuar este desmembramento será cancelado. Deseja continuar?',
                      ['&Sim','&Não']) = 1;

  if Result then
  begin
    objEntrada.cdsCtpDet.EmptyDataSet;
    objEntrada.blnValoresDesmembradosRotina :=  Not objEntrada.cdsCtpDet.IsEmpty;
  end;
end;

function TfrmEntMercadoriasAutomatizada.fGetBcoFor: String;
begin
  If cbxBcoFor.ItemIndex > -1 Then
    Result := lstBcoFor[cbxBcoFor.ItemIndex]
  Else
    Result := '';
end;

function TfrmEntMercadoriasAutomatizada.fGetModDocumentocbxCODMOD: String;
begin
  if cbxCODMOD.ItemIndex >= 0 then
    Result := cbxCODMOD.Items.Names[cbxCODMOD.ItemIndex]
  else
    Result := EmptyStr;

end;

procedure TfrmEntMercadoriasAutomatizada.FormClose(Sender: TObject;
  var Action: TCloseAction);
  var
    I: Integer;
begin
//  inherited;

  If ModalResult = mrOk Then
  Begin

    If (Not objEntrada.fValidaCodCtas(True)) Then
    Begin
      Action := caNone;
      pgcAbas.ActivePage := tbsItens;
      Exit;
    End;

    If (Not fVerificaCampos) Then
    Begin
      Action := caNone;
      Exit;
    End;

    If Not objEntrada.fValidaValorTotalEventos Then
    Begin
      Action := caNone;
      pgcAbas.ActivePage := tbsCtaPag;
      Exit;
    End;

    If Not objEntrada.fValidaEventos Then
    Begin
      Action := caNone;
      pgcAbas.ActivePage := tbsCtaPag;
      Exit;
    End;

    If Not fPergunta('Confirma a entrada das mercadorias?') Then
    Begin
      Action := caNone;
      Exit;
    End;

    objEntrada.lstEmpRateioDespesa.Clear;
    For I:= 0 to lstEmpRateioDespesa.Items.Count - 1 Do
    Begin
      If lstEmpRateioDespesa.Checked[I] Then
        objEntrada.lstEmpRateioDespesa.Add(Copy( lstEmpRateioDespesa.Items.Strings[I], 1, 3));
    End;

    If objEntrada.lstEmpRateioDespesa.Count = 0 Then
      objEntrada.lstEmpRateioDespesa.Add(VS_strCodEmp);


    objEntrada.recDadNot.strHisCtp := edtHistor.Lines.Text;
    objEntrada.recDadNot.blnGraFin := objEntrada.recDadNot.blnGravaCtaPag;

    If Not fLiberarValorBoleto Then
    Begin
      Action := caNone;
      pgcAbas.ActivePage := tbsCtaPag;
      Exit;
    End;

    If objEntrada.fGravaNota Then
    Begin

    //  pMensagemOk('Entrada efetivada com sucesso!')

    End Else
    Begin
      Action := caNone;
      Exit;
    End;

  End

  Else If Not fPergunta('Deseja abandonar a tarefa?') Then
  Begin
    Action := caNone;
    Exit;
  End;
end;

procedure TfrmEntMercadoriasAutomatizada.FormCreate(Sender: TObject);
begin
  inherited;
  {Se resolução disponível for inferior ou igual à (1366 x 768), maximiza tela!}
  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.WindowState := wsMaximized;

  objLiberacao := TLiberacao.create;
  blnPortadorObrigatorioContasPagar := fCfgSis('CTPOBP', varString) = 'S';

  intIdxBcoForAnt := -1;
  lstBcoFor := TStringList.Create;
  blnUtilizaFluxoCompraItensConsumo := fCfgSis('FLUPDC', varString) = 'S';
  strCndAnt := EmptyStr;
  blnIncluirHistoricoContasPagar  := fCfgSis('HISCTP', varBoolean);
  pAjustarFundoTema;
end;

procedure TfrmEntMercadoriasAutomatizada.FormDestroy(Sender: TObject);
begin
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  if Assigned(cdsNatOpe) then
    FreeAndNil(cdsNatOpe);

  lstBcoFor.Free;
end;


procedure TfrmEntMercadoriasAutomatizada.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: btnConfirma.Click;
    VK_F8: bbtnDesmembrarValores.Click;
  End;

end;

procedure TfrmEntMercadoriasAutomatizada.FormShow(Sender: TObject);
begin
  inherited;

  TcxLookupComboBoxProperties(cxvEventosCODEVE.Properties).ListSource := objEntrada.cdsCadEve.dtsSource;
//  TcxLookupComboBoxProperties(cxvEventosDESEVE.Properties).ListSource := objEntrada.cdsCadEve.dtsSource;

  strCfop := '';
  strNatOp := '';

  pAjustaDecimais;

  pMostraDadosCabecalho;
  pMostraDadosCabecalhoFiscal;
  pMostraDadosCtaPag;

  pgcAbas.ActivePageIndex := 0;

  cxvItens.NavigatorButtons.First.Click;

  pSetFocus(mskDtaEnt);

  objEntrada.pRecriaObjPgoAnt;

  With objEntrada, qryGerEle, recNotEle, recDadFor, recDadNot Do
  Begin
    objEntrada.objPgoAnt.pSetaFornecedor(strCodFor);


    lblTemPgtoAntecipado.Visible := ((Not blnDevolu) and objEntrada.objPgoAnt.fFornecedorTemPagamentoAntecipado(strCodFor));

    objEntrada.objPgoAnt.pSetarDocumentoEntrada(strNumDoc, strSerDoc, 'NF', mskCndPag.Text, TDate(dtaDtaEnt), TDate(dtaDtaDoc), fRetVlrContabilCadFis);
  end;

  pCarregaLstEmpresa;

  pCarregaDadosBancariosFornecedor(objEntrada.recDadFor.strCodFor);

  chkDeposi.Visible := objEntrada.recDadNot.blnGravaCtaPag and blnUtilizaFluxoCompraItensConsumo;
  chkImprCP.Visible := objEntrada.recDadNot.blnGravaCtaPag and blnUtilizaFluxoCompraItensConsumo;
  cbxBcoFor.Visible := objEntrada.recDadNot.blnGravaCtaPag and blnUtilizaFluxoCompraItensConsumo;;
  lblBcoFor.Visible := cbxBcoFor.Visible;

  pCarregaCacheNaturezaOperacao;
end;

procedure TfrmEntMercadoriasAutomatizada.pCarregaCacheNaturezaOperacao;
var
  qryNatCfo: TUniQuery;
begin
  qryNatCfo := fCriaQuery;
  try
    qryNatCfo.Close;
    qryNatCfo.SQL.Text :=
    ' SELECT '+
    '   NAT_CODCFO, '+
    '   NAT_DESCRI  '+
    ' FROM '+
    '   NATCFO ';
    qryNatCfo.Open;

    cdsNatOpe := fCriaClientDatset(qryNatCfo);
  finally
    FreeAndNil(qryNatCfo);
  end;
end;

procedure TfrmEntMercadoriasAutomatizada.pAjustaDecimais;
Begin
  TcxCurrencyEditProperties(cxvItensQTDITE.Properties).DecimalPlaces := objEntrada.intDecQtd;
  TcxCurrencyEditProperties(cxvItensQTDITE.Properties).DisplayFormat := fMskDigitos(objEntrada.intDecQtd);

  TcxCurrencyEditProperties(cxvItensUNITAR.Properties).DecimalPlaces := objEntrada.intDecUni;
  TcxCurrencyEditProperties(cxvItensUNITAR.Properties).DisplayFormat := fMskDigitos(objEntrada.intDecUni);

  TcxCurrencyEditProperties(cxvItensVALTOT.Properties).DisplayFormat := fMskDigitos(2);
End;

procedure TfrmEntMercadoriasAutomatizada.pMostraDadosCabecalho;
Begin

  With objEntrada, qryGerEle, recNotEle, recDadFor, recDadNot Do
  Begin
    mskDtaEnt.Text    := DateToStr(dtaDtaEnt);
    mskDtaDoc.Text    := DateToStr(dtaDtaDoc);
    edtNumDoc.Text    := strNumDoc;
    edtSerie.Text     := strSerDoc;
    edtEspDoc.Text    := 'NF';
    edtCodFor.Text    := strCodFor;
    edtNomFor.Text    := strNomFor;
    edtCgcCpf.Text    := strCgcCpfFormat;
    lblCgcCpf.Caption := strCgcCpfLablel;
  End;

End;

procedure TfrmEntMercadoriasAutomatizada.pMostraDadosCabecalhoFiscal;
Begin

  With objEntrada Do
  Begin
    edtTotIte.Text := FormatFloat(fMskDigitos(2), cdsItens.fRetSomaCampo('ENT_TOTITE'));
    edtDesEsp.Text := FormatFloat(fMskDigitos(2), cdsItens.fRetSomaCampo('ENT_DESESP'));
//    edtTotNot.Text := FormatFloat(fMskDigitos(2), cdsItens.fRetSomaCampo('ENT_VLRCON'));

    (*
    edtBasICM.Text :=
    edtValICM.Text :=
    edtBasSub.Text :=
    edtValSub.Text :=
    edtDesAce.Text :=
    edtValIPI.Text :=
    edtValFre.Text :=
    *)
  End;

End;

procedure TfrmEntMercadoriasAutomatizada.pMostraDadosCtaPag;
Begin
  With objEntrada, recDadNot Do
  mskCndPag.Text := strCndPag;
End;

procedure TfrmEntMercadoriasAutomatizada.pSetaModelo;
begin
  pCarregaModFis(objEntrada.recNotEle.str_Chave);
end;

procedure TfrmEntMercadoriasAutomatizada.pCarregaModFis(strChave: String = '');
  Var
    strModChave: String;
    i: Integer;
    objStrings: TStrings;
Begin
  cbxCodMod.Clear;
  cbxCodMod.Enabled := True;
  objStrings := cbxCodMod.Items;
  fRetornaDadosModFis(strChave, objStrings);
  If cbxCodMod.Items.Count = 1 Then
  Begin
    cbxCodMod.Enabled   := False;
    cbxCodMod.ItemIndex := 0;
  End
  Else If (Not fEmptyStr(strChave)) Then
  begin
    strModChave := Copy(strChave,  21, 2);
    i := cbxCodMod.Items.IndexOfName(strModChave);
    cbxCodMod.ItemIndex := i;
  end;
End;


procedure TfrmEntMercadoriasAutomatizada.fraCentroCustoedtCodEveKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  fraCentroCusto.edtCodEveKeyPress(Sender, Key);

end;

function TfrmEntMercadoriasAutomatizada.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    intCont: Integer;

begin
  Result := True;

  With objEntrada, recDadNot, recNotEle Do
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaEnt) Then
    Begin


      Result := TEntradaAutomatizada.fValidaDataEntrada(mskDtaEnt.Text, False {blnDevolu}, 0 {dtaDtaVen}, 'NF');

      If Result Then
      Begin
        dtaDtaEnt := StrToDate(mskDtaEnt.Text);

        If (Not(objEntrada.cdsCadFis.IsEmpty)) Then
        Begin
          If (Not(objEntrada.cdsCadFis.State in ([DsEdit]))) Then
            objEntrada.cdsCadFis.Edit;

          objEntrada.cdsCadFis.FieldByName('FIS_DTAENT').Value := StrToDate(mskDtaEnt.Text);

          If (objEntrada.cdsCadFis.State in ([DsEdit])) Then
            objEntrada.cdsCadFis.Post;
        End;


      End
      Else
        pgcAbas.ActivePage := tbsItens;


    End
    Else If (Sender = edtCodPor) Then
    Begin

      If blnGravaCtaPag Then
      Begin
        If fEmptyStr(edtCodPor.Text) Then
        begin
          if (fStatusCndPag(mskCndPag.Text) = A_VISTA) or (blnPortadorObrigatorioContasPagar and (Not objEntrada.recDadNot.blnDevolu)) then
          begin
            Result := False;
            pMensagemOk('O código do portador deve ser preenchido!');
            pgcAbas.ActivePage := tbsCtaPag;
		      End;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End;

        If Result Then
          strCodPor := edtCodPor.Text;

      End;

    End
    Else If (Sender = cbxCodMod) And (Sender.Parent.Enabled) And (Sender.Visible)  Then
    Begin
      If cbxCodMod.ItemIndex < 0 Then
      Begin
        Result := False;
        pMensagemOk('O modelo do documento deve ser informado!');
      End;
    End

    Else If (Sender = fraCentroCusto.edtCodEve) Then
    Begin

      edtValEve.Enabled := Not fEmptyStr(fraCentroCusto.edtCodEve.Text);

      If fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      begin
        edtValEve.Clear;
        fraCentroCusto.edtDesEve.Clear;
      End Else
      Begin

        fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve);

        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
        Begin
          Result := False;
          pMensagemOk('Centro de Custos não encontrado!');
         End;

      End;

    End

    Else If (Sender = edtValEve) and (Not objEntrada.blnValoresDesmembradosRotina) Then
    Begin

      If blnBuscaPorChave Then
      Begin

        If (fStrToFloat(edtValEve.Text) > 0) Then
        Begin

          If fValidaCampos(fraCentroCusto.EdtCodEve, True) Then
          Begin
            objEntrada.pIncluiEvento(fraCentroCusto.EdtCodEve.Text, fraCentroCusto.edtDesEve.Text, fStrToFloat(edtValEve.Text));

            fraCentroCusto.EdtCodEve.Clear;
            fraCentroCusto.edtDesEve.Clear;
            edtValEve.Clear;

            blnMudarFoco := False;
            pSetFocus(fraCentroCusto.EdtCodEve);
          End;

        End Else
        Begin
          fraCentroCusto.EdtCodEve.Clear;
          fraCentroCusto.edtDesEve.Clear;
        End;

      End;

    End
    //inicio
    Else If (Sender = mskCndPag) And (Not mskCndPag.Enabled) And (Not fEmptyStr(recNotEle.strAutInc)) And (Length(ArrDuplicata) > 0)
      and blnGravaCtaPag Then
    Begin
      If (fCfgSis('CTPBOL', varBoolean)) And (chkVeioBo.Checked) And
         (fTiraCaracEspeciaisPonto(mskCndPag.Text) <> '01000') And
         (Not fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text))) And
         (ArrDuplicata[0].strSequen <> '') And Result Then
      Begin

        For intCont := 0 To (IIF(intQtdPar > 0,intQtdPar, 12) -1) Do
        Begin
          If fEmptyStr(arrLinDigCodbar[intCont].strCodBar) And fEmptyStr(arrLinDigCodbar[intCont].strLinDig) Then
          Begin
            pMensagemOk('A linha digitável e/ou código de barras deve ser preenchida de todas as parcelas!');
            Result := False;
            Break;
          End
          Else
          Begin
            If Not fEmptyStr(arrLinDigCodbar[intCont].strCodBar) Then
            Begin
              Result := TfrmDigCodBarBoleto.fValidaCodBar(arrLinDigCodbar[intCont].strCodBar,
                                                          arrLinDigCodbar[intCont].strLinDig,
                                                          ArrDuplicata[intCont].curValor,
                                                          ArrDuplicata[intCont].dtaDtaVen);
            End;
            If Not fEmptyStr(arrLinDigCodbar[intCont].strLinDig) And Result Then
            Begin
              Result := TfrmDigCodBarBoleto.fValidaLinDig(arrLinDigCodbar[intCont].strCodBar,
                                                          arrLinDigCodbar[intCont].strLinDig,
                                                          ArrDuplicata[intCont].curValor,
                                                          ArrDuplicata[intCont].dtaDtaVen);
            End;
          End;
        End;

        If Not Result Then
        Begin
          pCriarFormularios(TfrmDigCodBarBoleto, frmDigCodBarBoleto);
          frmDigCodBarBoleto.arrLinDigCodbar := arrLinDigCodbar;
          frmDigCodBarBoleto.arrDuplicata := @arrDuplicata;

          Try

            Try
              frmDigCodBarBoleto.ShowModal;
            Except
            End;

          Finally

            Result := frmDigCodBarBoleto.blnConfirma;
            arrLinDigCodbar      := frmDigCodBarBoleto.arrLinDigCodbar;
            intQtdPar            := frmDigCodBarBoleto.intQtdPar;
            FreeAndNil(frmDigCodBarBoleto);

          End;

          If Not Result Then
            pMensagemOk('É preciso informar os códigos de barra ou a linha digitável!');
        End;
      End;
    End

    Else If (Sender = mskCndPag) And mskCndPag.Enabled And (Sender.Parent.Enabled) AND blnGravaCtaPag Then
    Begin
      strCndAnt := strCndPag;
      If fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If blnConEqu And (fTiraCaracEspeciaisPonto(mskCndPag.Text) <> '01000') Then
      Begin
        fMensagem('ATENÇÃO!', 'A condição de pagamento para a entrada de conserto de equipamento deve ser a vista!', ['&O k']);
        Result := False;
      End
      Else If StrToInt(Copy(mskCndPag.Text, 1, 2)) > 24 Then
      Begin
        fMensagem('', 'Não é permitido mais que 24 parcelas!', ['&O k']);
        Result := False;
      End
      Else If Not fValidaCndPag(mskCndPag.Text, strCndPag, dtaDtaDoc, True) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&O k']);
        Result := False;
      End
      Else If fEmptyStr(strCndPag) Then
      Begin
        Result := False;
      End

      Else If (blnBuscaPorChave)                     Or
              (fEmptyStr(arrDuplicata[0].dtaDtaVen)) Or
              (strCndAnt <> mskCndPag.Text)          Then
      Begin
        Result := fPedeDuplicatas(False);
        Result := Result And objEntrada.fRelacionaCodBar_LinhaDigitavel;
        mskCndPag.Text := strCndPag;
      End

      Else If (fCfgSis('CTPBOL', varBoolean)) And (chkVeioBo.Checked)  And (fTiraCaracEspeciaisPonto(mskCndPag.Text) <> '01000')
          And Not fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text))
            And (ArrDuplicata[0].strSequen <> '') And Result Then
      Begin
        For intCont := 0 To (IIF(intQtdPar > 0,intQtdPar, 12) -1) Do
        Begin
          If fEmptyStr(arrLinDigCodbar[intCont].strCodBar) And fEmptyStr(arrLinDigCodbar[intCont].strLinDig) Then
          Begin
            pMensagemOk('A linha digitável e/ou código de barras deve ser preenchida de todas as parcelas!');
            Result := False;
            Exit;
          End
          Else
          Begin
            If Not fEmptyStr(arrLinDigCodbar[intCont].strCodBar) Then
            Begin
              Result := TfrmDigCodBarBoleto.fValidaCodBar(arrLinDigCodbar[intCont].strCodBar,
                                                          arrLinDigCodbar[intCont].strLinDig,
                                                          ArrDuplicata[intCont].curValor,
                                                          ArrDuplicata[intCont].dtaDtaVen);
            End;
            If Not fEmptyStr(arrLinDigCodbar[intCont].strLinDig) And Result Then
            Begin
              Result := TfrmDigCodBarBoleto.fValidaLinDig(arrLinDigCodbar[intCont].strCodBar,
                                                          arrLinDigCodbar[intCont].strLinDig,
                                                          ArrDuplicata[intCont].curValor,
                                                          ArrDuplicata[intCont].dtaDtaVen);
            End;
          End;
        End;
      End;
    END

    Else If (fCfgSis('CTPBOL', varBoolean)) And (chkVeioBo.Checked)
       And (fTiraCaracEspeciaisPonto(mskCndPag.Text) <> '01000')
       And Not fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text))
       And (ArrDuplicata[0].strSequen <> '') And Result Then
    Begin
      For intCont := 0 To (IIF(intQtdPar > 0,intQtdPar, 12) -1) Do
      Begin
        If fEmptyStr(arrLinDigCodbar[intCont].strCodBar) And fEmptyStr(arrLinDigCodbar[intCont].strLinDig) Then
        Begin
          pMensagemOk('A linha digitável e/ou código de barras deve ser preenchida de todas as parcelas!');
          Result := False;
          Exit;
        End
        Else
        Begin
          If Not fEmptyStr(arrLinDigCodbar[intCont].strCodBar) Then
          Begin
            Result := TfrmDigCodBarBoleto.fValidaCodBar(arrLinDigCodbar[intCont].strCodBar,
                                                        arrLinDigCodbar[intCont].strLinDig,
                                                        ArrDuplicata[intCont].curValor,
                                                        ArrDuplicata[intCont].dtaDtaVen);
          End;
          If Not fEmptyStr(arrLinDigCodbar[intCont].strLinDig) And Result Then
          Begin
            Result := TfrmDigCodBarBoleto.fValidaLinDig(arrLinDigCodbar[intCont].strCodBar,
                                                        arrLinDigCodbar[intCont].strLinDig,
                                                        ArrDuplicata[intCont].curValor,
                                                        ArrDuplicata[intCont].dtaDtaVen);
          End;
        End;
      End;
    end;

  End;

  If Not Result Then
    pSetFocus(Sender);
End;

procedure TfrmEntMercadoriasAutomatizada.mskCndPagExit(Sender: TObject);
begin
  inherited;
  If (chkGerarFinanceiro.Checked or chkVeioBo.Checked or chkDeposi.Checked) and fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text)) Then
    fValidaCampos(mskCndPag, True);
end;

function TfrmEntMercadoriasAutomatizada.fCampoDetalhes(const ARowProperties: TcxCustomEditorRowProperties): String;
begin
  Result := '';
  If ARowProperties Is TcxDBEditorRowItemProperties Then
    Result := TcxDBEditorRowItemProperties(ARowProperties).DataBinding.FieldName;
end;

procedure TfrmEntMercadoriasAutomatizada.vgrDetalhesEditing(Sender: TObject;
  ARowProperties: TcxCustomEditorRowProperties; var Allow: Boolean);
begin
  inherited;
  { Classificação Fiscal continua editável, como na grade de edits que o vgrDetalhes substituiu:
    guarda o CFOP anterior para trocar nos itens quando a edição for concluída }
  FblnEditandoCfop := StartsText('FIS_CLFSC', fCampoDetalhes(ARowProperties));
  If FblnEditandoCfop Then
  Begin
    OldCfop := objEntrada.cdsCadFis.FieldByName(fCampoDetalhes(ARowProperties)).AsString;
    objEntrada.cdsCadFis.Edit;
  End;
end;

procedure TfrmEntMercadoriasAutomatizada.vgrDetalhesEdited(Sender: TObject;
  ARowProperties: TcxCustomEditorRowProperties);
  Var
    strCampo: String;
begin
  inherited;
  { O grid já passou o valor digitado para o campo do cdsCadFis (ainda em edição) }
  strCampo := fCampoDetalhes(ARowProperties);
  If FblnEditandoCfop Then
  Begin
    FblnEditandoCfop := False;
    pConfirmaTrocaCfop(objEntrada.cdsCadFis.FieldByName(strCampo).AsString);
  End
  { Base/Valor FCP ST seguem digitáveis, como na grade anterior (aqueles edits não eram ReadOnly) }
  Else If (Not fEmptyStr(strCampo)) And (objEntrada.cdsCadFis.State In [dsEdit]) Then
    objEntrada.cdsCadFis.Post;
end;

procedure TfrmEntMercadoriasAutomatizada.pConfirmaTrocaCfop(const AstrCfop: String);
begin
  { Mesma regra da saída do CFOP na grade anterior: CFOP válido grava e troca nos itens; inválido desfaz }
  If fExisteCFOP(AstrCfop) And
     objEntrada.fCFOPPodeSerUtilizada(AstrCfop) Then
  Begin
    If objEntrada.cdsCadFis.State In [dsEdit] Then
      objEntrada.cdsCadFis.Post;

    objEntrada.cdsItens.First;
    While Not(objEntrada.cdsItens.Eof) do
    Begin
      IF objEntrada.cdsItens.FieldByName('ENT_CLAFIS').AsString = OldCfop Then
      Begin
        objEntrada.cdsItens.Edit;
        objEntrada.cdsItens.FieldByName('ENT_CLAFIS').AsString:= AstrCfop;
        objEntrada.cdsItens.Post;
      End;
      objEntrada.cdsItens.Next;
    End;

    objEntrada.pDefineSeGravaCTP(AstrCfop, SELF);
  End
  Else
  Begin
    objEntrada.cdsCadFis.Cancel;
    pMensagemOk('CFOP não pode ser utilizada pois ela não pertence a configuração [CFG_CFEAAL].');
  End;

  pAjustaLinhasDetalhes;
end;

procedure TfrmEntMercadoriasAutomatizada.tbsLivroShow(Sender: TObject);
begin
  inherited;
  pAjustaLinhasDetalhes;
end;

function TfrmEntMercadoriasAutomatizada.fRetVlrContabilCadFis: Double;
begin
  { Arredonda por FormatFloat, como a leitura anterior do valor total já formatado em 2 casas.
    RoundTo diverge nos meios exatos (ex.: ,125) e mudaria o centavo enviado ao pagamento antecipado. }
  Result := 0;
  If Assigned(dtsCadFis.DataSet) And dtsCadFis.DataSet.Active Then
    Result := fStrToFloat(FormatFloat('0.00', dtsCadFis.DataSet.FieldByName('FIS_VLCONT').AsFloat));
end;

procedure TfrmEntMercadoriasAutomatizada.pGetDisplayTextTitulo(Sender: TcxCustomEditorRowProperties;
  ARecord: Integer; var AText: String);
begin
  { Editores sem campo em vgrDetalhes: exibem o próprio Caption (título da linha ou da coluna) }
  AText := Sender.Caption;
end;

procedure TfrmEntMercadoriasAutomatizada.pGetDisplayTextValor(Sender: TcxCustomEditorRowProperties;
  ARecord: Integer; var AText: String);
begin
  { Classificação sem uso deixa o campo null; na tela aparece 0,00. O dataset continua null,
    porque o cdsCadFis é gravado no CADFIS e lá null e zero não são a mesma coisa. }
  If fEmptyStr(AText) Then
    AText := FormatFloat('#,##0.00', 0);
end;

procedure TfrmEntMercadoriasAutomatizada.pGetDisplayTextClaFis(Sender: TcxCustomEditorRowProperties;
  ARecord: Integer; var AText: String);
begin
  { Só exibição: classificação vazia aparece como '-'; o campo continua vazio no dataset }
  If fEmptyStr(Trim(AText)) Then
    AText := '-';
end;

procedure TfrmEntMercadoriasAutomatizada.pAjustaLinhasDetalhes;
  Var
    blnReforma: Boolean;

  procedure pOcultaValorSemBase(const AstrCampoBase: String; ArowValor: TcxDBMultiEditorRow);
    Var
      intColuna: Integer;
  Begin
    ArowValor.Visible := False;
    For intColuna := 1 To 5 Do
      If dtsCadFis.DataSet.FieldByName(AstrCampoBase + IntToStr(intColuna)).AsFloat > 0 Then
      Begin
        ArowValor.Visible := True;
        Exit;
      End;
  End;

begin
  { O cdsCadFis só é ligado ao dtsCadFis na carga da nota }
  If (Not Assigned(dtsCadFis.DataSet)) Or (Not dtsCadFis.DataSet.Active) Then
    Exit;

  { Mesma regra de TfrmCadLivroFiscal.pJustaCamposImpostos (fTemValorBase): a linha do valor só
    aparece se alguma classificação tiver base maior que zero; a linha da base fica sempre. }
  pOcultaValorSemBase('FIS_BCRET', rowRetId);
  pOcultaValorSemBase('FIS_BASAN', rowAntIc);
  pOcultaValorSemBase('FIS_BAERE', rowVaeRe);
  pOcultaValorSemBase('FIS_BASIP', rowVlrIp);
  pOcultaValorSemBase('FIS_BAEIP', rowVaeIp);
  pOcultaValorSemBase('FIS_BFCPS', rowVFCPS);
  pOcultaValorSemBase('FIS_QBCMO', rowValMo);

  { Bloco da Reforma só existe com a configuração ligada, como o pnlContainerReforma do livro
    fiscal; dentro dele vale a mesma regra base/valor dos demais pares }
  blnReforma := fSomarNovosImpostosDaReformaAoValorContabil;
  rowBcCbs.Visible := blnReforma;
  rowBcIbs.Visible := blnReforma;
  rowBc_Is.Visible := blnReforma;
  pOcultaValorSemBase('FIS_BCCBS', rowVlCbs);
  pOcultaValorSemBase('FIS_BCIBS', rowVlIbs);
  pOcultaValorSemBase('FIS_BC_IS', rowVl_Is);
  rowVlCbs.Visible := rowVlCbs.Visible And blnReforma;
  rowVlIbs.Visible := rowVlIbs.Visible And blnReforma;
  rowVl_Is.Visible := rowVl_Is.Visible And blnReforma;
end;

// Com skin, o TfrmPai troca o azul $00FFE4D5 do pnlDetalhes pela cor de painel do estilo, mas não
// alcança o TcxStyle dos títulos nem o fundo vazio e as linhas das células do grid, que continuariam azuis.
procedure TfrmEntMercadoriasAutomatizada.pAjustarFundoTema;
begin
  If blnUsuarioLogadoUtilizaModoClassico Then
    Exit;

  If TStyleManager.ActiveStyle.Name <> AUTCOM_STYLE_NAME Then
    Exit;

  cxsTituloDetalhes.Color := TStyleManager.ActiveStyle.GetStyleColor(scPanel);
  vgrDetalhes.OptionsView.GridLineColor := cxsTituloDetalhes.Color;
end;

procedure TfrmEntMercadoriasAutomatizada.pGetContentStyleDetalhes(Sender: TObject;
  AEditProp: TcxCustomEditorRowProperties; AFocused: Boolean; ARecordIndex: Integer;
  var AStyle: TcxStyle);
begin
  { Editor sem campo é título (linha ou coluna) ou espaçador entre colunas, que faz o papel da
    linha vertical: com o cabeçalho oculto o grid não desenha divisor entre os editores }
  If (AEditProp Is TcxDBEditorRowItemProperties) And
     fEmptyStr(TcxDBEditorRowItemProperties(AEditProp).DataBinding.FieldName) Then
    AStyle := cxsTituloDetalhes;
end;

procedure TfrmEntMercadoriasAutomatizada.pCarregaDadosBancariosFornecedor(
  const strCodFor: String);
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;

  Try
    cbxBcoFor.Clear;
    lstBcoFor.Clear;
    qryGen.Sql.Clear;
    qryGen.Sql.Add(getSQLDadosBancariosFornecedor);
    qryGen.ParamByName('CODFOR').AsString := strCodFor;
    qryGen.Open;

    While Not qryGen.Eof Do
    Begin
      cbxBcoFor.Items.Add(Trim(qryGen.FieldByName('DESC_CONTA').AsString));
      lstBcoFor.Add(qryGen.FieldByName('AUTOINCREM').AsString);
      qryGen.Next;
    End;

    qryGen.Close;

  Finally
    If Pred(cbxBcoFor.Items.Count) >= intIdxBcoForAnt Then
      cbxBcoFor.ItemIndex := intIdxBcoForAnt;
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmEntMercadoriasAutomatizada.pCarregaLstEmpresa;
Var
  qryGen: TUniQuery;
  intBusca : Integer;
Begin
  Try

    qryGen := fCriaQuery;
    Begin
      lstEmpRateioDespesa.Items.Clear;
      qryGen.SQL.Clear;
      qryGen.SQL.Add('SELECT CONCAT(EMP_CODEMP," - ", EMP_NOMEMP) AS EMPNOM FROM CADEMP ORDER BY EMP_CODEMP');
      qryGen.Open;
      qryGen.First;
      While Not qryGen.Eof Do
      Begin
        lstEmpRateioDespesa.Items.Add(qryGen.FieldByName('EMPNOM').AsString);
        qryGen.Next;
      End;
      qryGen.Close;
    End;

    intBusca := lstEmpRateioDespesa.Items.IndexOf(VS_strCodEmp + ' - ' + VS_strRazSoc);
    if intBusca >= 0 then
    begin
      lstEmpRateioDespesa.ItemIndex:=intBusca;
      lstEmpRateioDespesa.Checked[intBusca]:= True;
    end;

  Finally
    FreeAndNil(qryGen);
  End;

End;



procedure TfrmEntMercadoriasAutomatizada.pgcAbasChange(Sender: TObject);
begin
  inherited;
  if pgcAbas.ActivePage = tbsCtaPag then
    pInserirDocumentoHistoricoContasPagar;
end;

procedure TfrmEntMercadoriasAutomatizada.pInserirDocumentoHistoricoContasPagar;
  var
    strDocumentoHistCtp: String;
begin
  if blnIncluirHistoricoContasPagar and tbsCtaPag.Visible then
  begin
    strDocumentoHistCtp := objEntrada.fDocumentoHistoricoContasPagar;
    If edtHistor.lines.Count = 0 then
      edtHistor.lines.Add(strDocumentoHistCtp)
    else begin
      if pos(strDocumentoHistCtp, edtHistor.Lines.Text) = 0 then
      begin
        if edtHistor.lines.Strings[0] <> EmptyStr then
          edtHistor.lines.Strings[0] := sLineBreak+edtHistor.lines.Strings[0];
        edtHistor.lines.Strings[0] := strDocumentoHistCtp + sLineBreak;
      end;
    end;
  end;
end;

procedure TfrmEntMercadoriasAutomatizada.pDesmembrarValores;
  Var
    i: Integer;
begin

  objEntrada.lstEmpRateioDespesa.Clear;
  For I:= 0 to lstEmpRateioDespesa.Items.Count - 1 Do
  Begin
    If lstEmpRateioDespesa.Checked[I] Then
      objEntrada.lstEmpRateioDespesa.Add(Copy( lstEmpRateioDespesa.Items.Strings[I], 1, 3));
  End;

  If objEntrada.lstEmpRateioDespesa.Count = 0 Then
    objEntrada.lstEmpRateioDespesa.Add(VS_strCodEmp);

  objEntrada.pDesmembrarValoresCadPag(Nil, True);
end;

function TfrmEntMercadoriasAutomatizada.fLiberarValorBoleto: Boolean;
Var
  objLiberacao: TLiberacao;
  intCont: Integer;
  strLin: String;
  curTotBol: Currency;
  curTotDoc: Currency;
Begin
  Result := True;

  curTotBol := fTotalBoleto + objEntrada.objPgoAnt.fltTotUso;
  curTotDoc := dtsCadFis.DataSet.FieldByName('FIS_VLCONT').AsCurrency;

  objLiberacao := TLiberacao.Create;
  Try
    If (curTotBol > 0) And (curTotBol <> curTotDoc) Then
    Begin
      objLiberacao.objMsgLibera.pAddTexto('VALOR DOS BOLETOS DIFERENTE DO VALOR CONTABIL DA NOTA FISCAL');
      objLiberacao.objMsgLibera.pAddSeparador(65);

      objLiberacao.objMsgLibera.pAddTextoCaption('Documento:'  , edtNumDoc.Text + 'NF' + edtSerie.Text, 20);
      objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor:' ,edtCodFor.Text + '-' + edtNomFor.Text, 13);
      objLiberacao.objMsgLibera.pAddSeparador(65);
      objLiberacao.objMsgLibera.pAddTextoCaption('Vr.Contabil:' ,  FormatFloat('#,##0.00', curTotDoc) , 13);
      objLiberacao.objMsgLibera.pAddTextoCaption('Soma das Parcelas:', FormatFloat('#,##0.00', fTotalBoleto) , 13);
      If objEntrada.objPgoAnt.fltTotUso > 0 Then
        objLiberacao.objMsgLibera.pAddTextoCaption('Total de Adiantamento:', FormatFloat('#,##0.00', objEntrada.objPgoAnt.fltTotUso) , 13);
      objLiberacao.objMsgLibera.pAddSeparador(65);
      objLiberacao.objMsgLibera.pAddTextoCaption('Parcelas:'  ,'' ,10);

      For intCont := 0 To High(objEntrada.arrDuplicata) Do
      Begin
        if fEmptyStr(objEntrada.arrDuplicata[intCont].dtaDtaVen) Then
          Break;

        strLin := FormatDateTime('dd/mm/yyyy', StrToDate(objEntrada.arrDuplicata[intCont].dtaDtaVen)) + ' ' +
          fPadL(FormatFloat('#,##0.00', objEntrada.arrDuplicata[intCont].curValor),10);

        If ((intCont + 1) mod 3 = 0) Then
        Begin
          objLiberacao.objMsgLibera.pAddTextoCaption(strLin ,'' ,65);
          strLin := '';
        End;
      End;
      objLiberacao.objMsgLibera.pAddTextoCaption(strLin ,'' ,65);
      objLiberacao.strDirAce := 'LBRBOL';
      objLiberacao.strMsgSen := 'VALOR DOS BOLETOS DIFERENTE DO VALOR CONTABIL DA NOTA FISCAL s';
      Result :=  objLiberacao.fLibera;
    End;
  Finally
    FreeAndNil(objLiberacao);
  End;
End;

function TfrmEntMercadoriasAutomatizada.fTotalBoleto: Currency;
Var
  intContador: integer;
Begin
  Result := 0;
  For intContador := 0 To Length(objEntrada.arrDuplicata) -1 Do
    Result := Result + objEntrada.arrDuplicata[intContador].curValor;
End;


end.
