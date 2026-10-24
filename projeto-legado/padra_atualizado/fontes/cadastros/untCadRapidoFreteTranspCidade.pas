unit untCadRapidoFreteTranspCidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, Data.DB,
  Datasnap.DBClient, UniClientDataSet, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, MemDS, DBAccess, Uni,
  cxCurrencyEdit, cxCalc, cxProgressBar, Vcl.ComCtrls, cxGridCitel,
  System.Types, System.Math, QColorLabel, System.StrUtils;

type
  TfrmCadRapidoFreteTranspCidade = class(TfrmPaiConfirma)
    pnlGeral: TPanel;
    gpbCalculoFrete: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    dbeMinFre: TDBEditFocus;
    dbePerTot: TDBEditFocus;
    dbeValKil: TDBEditFocus;
    dbePd100K: TDBEditFocus;
    dbeMinGri: TDBEditFocus;
    dbePerGri: TDBEditFocus;
    dbeValTas: TDBEditFocus;
    cdsTraCid: TUniClientDataSet;
    cdsTraCidCODTRA: TStringField;
    cdsTraCidCODCID: TStringField;
    cdsTraCidVALISE: TFloatField;
    cdsTraCidMINFRE: TFloatField;
    cdsTraCidPERTOT: TFloatField;
    cdsTraCidVALKIL: TFloatField;
    cdsTraCidPD100K: TFloatField;
    cdsTraCidPERGRI: TFloatField;
    cdsTraCidMINGRI: TFloatField;
    cdsTraCidVALTAS: TFloatField;
    dscTraCid: TDataSource;
    Label31: TLabel;
    Label7: TLabel;
    Label20: TLabel;
    lblValIse: TLabel;
    dbeCodTra: TDBEditFocus;
    edtNomTra: TEditFocus;
    dbeCodCid: TDBEditFocus;
    edtCidade: TEditFocus;
    edtEstado: TEditFocus;
    dbeValIse: TDBEditFocus;
    cxFrete: TcxGridCitel;
    cxTblFrete: TcxGridDBTableViewCitel;
    cxFreteLvl: TcxGridLevel;
    cxTblFreteNOMTRA: TcxGridDBColumn;
    cxTblFreteNOMCID: TcxGridDBColumn;
    cxTblFreteVALISE: TcxGridDBColumn;
    cxTblFreteMINFRE: TcxGridDBColumn;
    cxTblFretePERTOT: TcxGridDBColumn;
    cxTblFreteVALKIL: TcxGridDBColumn;
    cxTblFretePD100K: TcxGridDBColumn;
    cxTblFretePERGRI: TcxGridDBColumn;
    cxTblFreteMINGRI: TcxGridDBColumn;
    cxTblFreteVALTAS: TcxGridDBColumn;
    cdsTraCidNOMCID: TStringField;
    cdsTraCidNOMTRA: TStringField;
    cdsTraCidESTADO: TStringField;
    cxTblFreteESTADO: TcxGridDBColumn;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    pnlCabecalho: TPanel;
    lblTraCid: TLabel;
    lblEstadoTraCid: TLabel;
    edtNomTraCid: TEditFocus;
    edtEstadoTraCid: TEditFocus;
    edtCodTraCid: TEditFocus;
    pgcGeral: TPageControl;
    tbsCalculoFrete: TTabSheet;
    tbsFaixaFatDesc: TTabSheet;
    cxgFaixas: TcxGridCitel;
    cxgFaixasTableView: TcxGridDBTableViewCitel;
    cxgFaixasTableViewFATINI: TcxGridDBColumn;
    cxgFaixasTableViewFATFIN: TcxGridDBColumn;
    cxgFaixasTableViewPERDES: TcxGridDBColumn;
    cxgFaixasLevel: TcxGridLevel;
    dtsFaixas: TDataSource;
    cdsFaixas: TUniClientDataSet;
    cdsFaixasCODTRA: TStringField;
    cdsFaixasCODCID: TStringField;
    cdsFaixasFATINI: TFloatField;
    cdsFaixasFATFIN: TFloatField;
    cdsFaixasPERDES: TFloatField;
    cdsTraCidTOMADO: TStringField;
    cdsTraCidCOBVAL: TFloatField;
    cdsTraCidALIQUO: TFloatField;
    pnlFreReg: TPanel;
    lblFreReg: TLabel;
    edtCodFreReg: TEditFocus;
    edtNomFreReg: TEditFocus;
    pnlTomador: TPanel;
    Label37: TLabel;
    ColorLabel1: TColorLabel;
    dbeTomado: TDBEditFocus;
    pnlCobVal: TPanel;
    Label10: TLabel;
    dbeCobVal: TDBEditFocus;
    pnlAliquo: TPanel;
    Label11: TLabel;
    dbeAliquo: TDBEditFocus;
    cxTblFreteCODTRA: TcxGridDBColumn;
    cxTblFreteCODCID: TcxGridDBColumn;
    chkReplicar: TCheckBox;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodTraCidKeyPress(Sender: TObject; var Key: Char);
    procedure cdsTraCidAfterScroll(DataSet: TDataSet);
    procedure btnSairClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure dbeCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbeCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure cdsTraCidNewRecord(DataSet: TDataSet);
    procedure cdsFaixasBeforePost(DataSet: TDataSet);
    procedure cdsFaixasNewRecord(DataSet: TDataSet);
    procedure cxgFaixasTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgFaixasTableViewEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure edtCodFreRegKeyPress(Sender: TObject; var Key: Char);
    procedure cxTblFreteKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkReplicarClick(Sender: TObject);
    procedure cdsTraCidBeforeEdit(DataSet: TDataSet);

  private
    { Private declarations }
    intSavePnt: Int64;
    FstrCodCid: String;
    FstrCodTra: String;
  protected
    procedure pLiberaEdicao(blnLiberaEdicao : Boolean);
    procedure pHabilitaDesabilitaControles;
    procedure pFiltraDataSetFaixas;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fCarregarFretes: Boolean;
    function fCarregarTraCid(pgbStatus: TcxProgressBar = Nil) : Boolean;
    function fGravarFRETRA(pgbStatus: TcxProgressBar = Nil) : Boolean;
    function fValidaFaixas(Out strMensagem: String): Boolean;
    function fGravaItem: Boolean;

    procedure pReplicaDados;

    procedure pHabilitaDesabilitaDBEditFocus(DBEditFocus: TDBEditFocus; blnHabilita: Boolean);
  public
    strOpcTela : String;
    class function fCadRapidoTraCid(strOpcao : String) : Boolean;
  end;

implementation

uses
  untFuncoesSimples, untTypesSistema, untConsultas, untGravando;

{$R *.dfm}

{ TfrmCadRapidoFreteTranspCidade }

procedure TfrmCadRapidoFreteTranspCidade.btnAlterarClick(Sender: TObject);
begin
  inherited;
  If cdsTraCid.Active And (Not cdsTraCid.IsEmpty) Then
  Begin
    {***************************************************}
    {* Adicionado por causa do atalho do botão (Alt+A) *}
    {* Dava erro: Dataset not in edit or insert mode.  *}
    {*REQ.174180*************************************RP*}
    pSetFocus(btnAlterar);

    cdsTraCid.Edit;
    pHabilitaDesabilitaControles;

    intSavePnt := cdsFaixas.SavePoint;

    pgcGeral.ActivePage := tbsCalculoFrete;

    If (strOpcTela = 'T') Then
      pSetFocus(dbeCodCid)
    Else
      pSetFocus(dbeCodTra);
  End;
end;

procedure TfrmCadRapidoFreteTranspCidade.btnCancelaClick(Sender: TObject);
begin
  inherited;
  If cdsTraCid.Active And (Not cdsTraCid.IsEmpty) And (cdsTraCid.State in [dsInsert, dsEdit]) Then
  Begin
    cdsTraCid.Cancel;
    cdsFaixas.SavePoint := intSavePnt;
    pHabilitaDesabilitaControles;

    if chkReplicar.Checked Then
      chkReplicar.Checked := False;

    pSetFocus(cxFrete);
  End;
end;

procedure TfrmCadRapidoFreteTranspCidade.btnConfirmaClick(Sender: TObject);
var
  frmAguarde: TfrmGravando;
  blnGravou : Boolean;
begin

  If Not fVerificaCampos Then
    Exit;

  If cdsTraCid.State In [dsInsert, dsEdit] Then
  Begin
    If Not fGravaItem Then
      Exit;
  End;

  If cdsTraCid.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhuma '+ IIF(strOpcTela = 'T', 'cidade', 'transportadora') +' foi informada, verifique!', ['&Ok']);
    Exit;
  End;

  If fPergunta('Deseja realmente atualizar essas informações?') Then
  Begin
    Try

      Try
        pCriarFormularios(TfrmGravando, frmAguarde);
        frmAguarde.fExecutarAcao := fGravarFRETRA;
        frmAguarde.ShowModal;
        blnGravou := frmAguarde.blnConfirma;
      Except
        On E: Exception Do
        Begin
          blnGravou := False;
          pMensagensErro(E.Message, '');
        End;
      End;

    Finally
      pFreeAndNil(frmAguarde);
    End;

    If (blnGravou) Then
      ModalResult := mrOk
    Else
      ModalResult := mrCancel;
  End;

end;

procedure TfrmCadRapidoFreteTranspCidade.btnExcluirClick(Sender: TObject);
begin
  inherited;
  If cdsTraCid.Active And (Not cdsTraCid.IsEmpty) Then
    If fPergunta('Deseja realmente excluir este registro?') Then
      cdsTraCid.Delete;
end;

procedure TfrmCadRapidoFreteTranspCidade.btnGravarClick(Sender: TObject);
begin

  inherited;

  fGravaItem;

end;

procedure TfrmCadRapidoFreteTranspCidade.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If cdsTraCid.Active Then
  Begin
    {***************************************************}
    {* Adicionado por causa do atalho do botão (Alt+I) *}
    {* Dava erro: Dataset not in edit or insert mode.  *}
    {*REQ.174180*************************************RP*}
    pSetFocus(btnIncluir);

    cdsTraCid.Append;
    pHabilitaDesabilitaControles;

    pgcGeral.ActivePage := tbsCalculoFrete;

    If (strOpcTela = 'T') Then
    Begin
      cdsTraCidCODTRA.AsString := edtCodTraCid.Text;
      cdsTraCidNOMTRA.AsString := fRetNomTransportadora(cdsTraCidCODTRA.AsString);
      edtNomTra.Text := cdsTraCidNOMTRA.AsString;

      pSetFocus(dbeCodCid);
    End
    Else
    If (strOpcTela = 'C') Then
    Begin
      cdsTraCidCODCID.AsString := edtCodTraCid.Text;
      cdsTraCidNOMCID.AsString := fRetNomCidade(cdsTraCidCODCID.AsString, 0);
      cdsTraCidESTADO.AsString := fRetNomCidade(cdsTraCidCODCID.AsString, 1);
      edtCidade.Text := cdsTraCidNOMCID.AsString;
      edtEstado.Text := cdsTraCidESTADO.AsString;

      pSetFocus(dbeCodTra);
    End;

    pFiltraDataSetFaixas;
  End;
end;

procedure TfrmCadRapidoFreteTranspCidade.btnSairClick(Sender: TObject);
begin

  If Not (pnlCabecalho.Enabled) Then
    pLiberaEdicao(False)
  Else
    Close;

end;

procedure TfrmCadRapidoFreteTranspCidade.cdsFaixasBeforePost(DataSet: TDataSet);
begin
  inherited;
  If cdsFaixasFATINI.IsNull Then
    cdsFaixasFATINI.AsFloat := 0;

  If cdsFaixasFATFIN.IsNull Then
    cdsFaixasFATFIN.AsFloat := 0;

  If cdsFaixasPERDES.IsNull Then
    cdsFaixasPERDES.AsFloat := 0;
end;

procedure TfrmCadRapidoFreteTranspCidade.cdsFaixasNewRecord(DataSet: TDataSet);
begin
  inherited;
  If strOpcTela = 'T' Then
    fValidaCampos(dbeCodCid, False)
  Else
    fValidaCampos(dbeCodTra, False);

  cdsFaixasCODTRA.AsString := cdsTraCidCODTRA.AsString;
  cdsFaixasCODCID.AsString := cdsTraCidCODCID.AsString;
end;

procedure TfrmCadRapidoFreteTranspCidade.cdsTraCidAfterScroll(DataSet: TDataSet);
begin
  inherited;
  If cdsTraCid.Active And (Not cdsTraCid.IsEmpty) Then
  Begin
    edtNomTra.Text := cdsTraCidNOMTRA.AsString;
    edtCidade.Text := cdsTraCidNOMCID.AsString;
    edtEstado.Text := cdsTraCidESTADO.AsString;
  End
  Else
  Begin
    edtNomTra.Clear;
    edtCidade.Clear;
    edtEstado.Clear;
  End;

  pFiltraDataSetFaixas;
end;

procedure TfrmCadRapidoFreteTranspCidade.cdsTraCidBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  FstrCodCid := DataSet.FieldByName('CODCID').AsString;
  FstrCodTra := DataSet.FieldByName('CODTRA').AsString;
end;

procedure TfrmCadRapidoFreteTranspCidade.cdsTraCidNewRecord(DataSet: TDataSet);
begin
  inherited;
  cdsTraCidVALISE.AsFloat := 0;
  cdsTraCidMINFRE.AsFloat := 0;
  cdsTraCidPERTOT.AsFloat := 0;
  cdsTraCidVALKIL.AsFloat := 0;
  cdsTraCidPD100K.AsFloat := 0;
  cdsTraCidPERGRI.AsFloat := 0;
  cdsTraCidMINGRI.AsFloat := 0;
  cdsTraCidVALTAS.AsFloat := 0;
  cdsTraCidTOMADO.AsString := '';
  cdsTraCidCOBVAL.AsFloat := 0;
  cdsTraCidALIQUO.AsFloat := 0;
end;

procedure TfrmCadRapidoFreteTranspCidade.chkReplicarClick(Sender: TObject);
begin
  inherited;


  If (strOpcTela = 'C') Then
  Begin
    If chkReplicar.Checked And (FstrCodTra <> cdsTraCid.FieldByName('CODTRA').AsString) then
    Begin

      If fMensagem('Atenção', 'Ao marcar a replicação de dados não é possível alterar a Transportadora. Ao prosseguir, a Transportadora será restaurada! Deseja realmente prosseguir?',['&Sim', '&Não'], 2) = 1 Then
        cdsTraCid.FieldByName('CODTRA').AsString := FstrCodTra
      Else
      Begin
        chkReplicar.Checked := False;
        Exit;
      End;
    End;

    pHabilitaDesabilitaDBEditFocus(dbeCodTra, not chkReplicar.Checked);

  End
  Else
  If (strOpcTela = 'T') Then
  Begin
    If chkReplicar.Checked And (FstrCodCid <> cdsTraCid.FieldByName('CODCID').AsString) then
    Begin

      If fMensagem('Atenção', 'Ao marcar a replicação de dados não é possível alterar a Cidade. Ao prosseguir, a Cidade será restaurada! Deseja realmente prosseguir?',['&Sim', '&Não'], 2) = 1 Then
        cdsTraCid.FieldByName('CODCID').AsString := FstrCodCid
      Else
      Begin
        chkReplicar.Checked := False;
        Exit;
      End;
    End;

    pHabilitaDesabilitaDBEditFocus(dbeCodCid, not chkReplicar.Checked);

  End;

end;

procedure TfrmCadRapidoFreteTranspCidade.cxgFaixasTableViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  cxgFaixasTableViewKeyDown(Sender, Key, Shift);
end;

procedure TfrmCadRapidoFreteTranspCidade.cxgFaixasTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_DOWN Then
  Begin
    If cxgFaixasTableView.Controller.FocusedRowIndex = cxgFaixasTableView.ViewData.RowCount -1 Then
      Key := 0;
  End
  Else If Key = VK_RETURN Then
  Begin
    If cxgFaixasTableView.Controller.FocusedColumnIndex = cxgFaixasTableView.ColumnCount -1 Then
    Begin
      If cxgFaixasTableView.Controller.FocusedRowIndex = cxgFaixasTableView.ViewData.RowCount -1 Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadRapidoFreteTranspCidade.cxTblFreteKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_RETURN) and btnAlterar.Enabled then
    btnAlterar.Click;
end;

procedure TfrmCadRapidoFreteTranspCidade.dbeCodCidKeyPress(Sender: TObject; var Key: Char);
Var
  arrCidade: TConsultasArray;
begin

  inherited;

  If dbeCodCid.ReadOnly Then
    Exit;

  If fPesqCidade(Self, dbeCodCid, edtCidade, edtEstado, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(dbeCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadRapidoFreteTranspCidade.dbeCodTraKeyPress(Sender: TObject; var Key: Char);
Var
  arrTransp: TConsultasArray;
begin

  inherited;

  If dbeCodTra.ReadOnly Then
    Exit;

  If fPesqTransportadora(conTraSimples, Self, dbeCodTra, edtNomTra, Nil, Key, arrTransp) Then
  Begin
    If fValidaCampos(dbeCodTra, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadRapidoFreteTranspCidade.edtCodFreRegKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFreteRegiao(Self, edtCodFreReg, edtNomFreReg, Nil, Key) Then
    If fValidaCampos(edtCodFreReg, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadRapidoFreteTranspCidade.edtCodTraCidKeyPress(Sender: TObject; var Key: Char);
Var
  arrTransp: TConsultasArray;
  arrCidade: TConsultasArray;
begin

  If (strOpcTela = 'T') Then
  Begin
    If fPesqTransportadora(conTraSimples, Self, edtCodTraCid, edtNomTraCid, Nil, Key, arrTransp) Then
    Begin
      fValidaCampos(edtCodTraCid, True);
    End;
  End
  Else
  If (strOpcTela = 'C') Then
  Begin
    If fPesqCidade(Self, edtCodTraCid, edtNomTraCid, edtEstadoTraCid, Nil, Key, arrCidade) Then
    Begin
      fValidaCampos(edtCodTraCid, True);
    End;
  End;

end;

class function TfrmCadRapidoFreteTranspCidade.fCadRapidoTraCid(strOpcao : String) : Boolean;
var
  frmCadRapidoFreteTranspCidade: TfrmCadRapidoFreteTranspCidade;
begin

  Result := False;

  frmCadRapidoFreteTranspCidade := TfrmCadRapidoFreteTranspCidade.Create(Nil);

  Try

    With frmCadRapidoFreteTranspCidade Do
    Begin

      strOpcTela := strOpcao;
      lblTraCid.Caption := IIF(strOpcao = 'T', 'Transportadora', 'Cidade');

      cxTblFreteNOMTRA.Visible := IIF(strOpcao = 'C', True, False);
      cxTblFreteNOMCID.Visible := IIF(strOpcao = 'T', True, False);
      cxTblFreteESTADO.Visible := IIF(strOpcao = 'T', True, False);

      If (cxTblFreteNOMTRA.Visible) Then
        cxTblFreteNOMTRA.Width := cxTblFreteNOMTRA.Width * 2;

      If (cxTblFreteNOMCID.Visible) Then
        cxTblFreteNOMCID.Width := cxTblFreteNOMCID.Width * 2;

      If (strOpcao = 'T') Then
      Begin
        dbeCodTra.Color       := $00FFDFB8;
        dbeCodTra.NormalColor := $00FFDFB8;
        dbeCodTra.ReadOnly := True;
        dbeCodTra.TabStop  := False;
      End
      Else
      If (strOpcao = 'C') Then
      Begin
        dbeCodCid.Color       := $00FFDFB8;
        dbeCodCid.NormalColor := $00FFDFB8;
        dbeCodCid.ReadOnly := True;
        dbeCodCid.TabStop  := False;
      End;

      pHabilitaDesabilitaControles;

      If ShowModal = mrOk Then
        Result := True;

    End;

  Finally
    pFreeAndNil(frmCadRapidoFreteTranspCidade);
  End;

end;

procedure TfrmCadRapidoFreteTranspCidade.FormCreate(Sender: TObject);
begin
  inherited;
  cdsTraCid.CreateDataSet;
  cdsTraCid.EmptyDataSet;
  cdsFaixas.CreateDataSet;
  blnFecharComEscape := False;

  cdsTraCidVALISE.DisplayFormat := '#,##0.00';
  cdsTraCidMINFRE.DisplayFormat := '#,##0.00';
  cdsTraCidPERTOT.DisplayFormat := '#,##0.00';
  cdsTraCidVALKIL.DisplayFormat := '#,##0.0000';
  cdsTraCidPD100K.DisplayFormat := '#,##0.00';
  cdsTraCidPERGRI.DisplayFormat := '#,##0.00';
  cdsTraCidMINGRI.DisplayFormat := '#,##0.00';
  cdsTraCidVALTAS.DisplayFormat := '#,##0.00';
  cdsTraCidCOBVAL.DisplayFormat := '#,##0.000';
  cdsTraCidALIQUO.DisplayFormat := '#,##0.00';

  cdsFaixasFATINI.DisplayFormat := ',#0.00';
  cdsFaixasFATFIN.DisplayFormat := ',#0.00';
  cdsFaixasPERDES.DisplayFormat := ',#0.00%';
  cdsFaixasFATINI.EditFormat    := '#0.00';
  cdsFaixasFATFIN.EditFormat    := '#0.00';
  cdsFaixasPERDES.EditFormat    := '#0.00';
end;

procedure TfrmCadRapidoFreteTranspCidade.FormShow(Sender: TObject);
begin
  inherited;

  edtEstadoTraCid.Visible := IIF(strOpcTela = 'T', False, True);
  lblEstadoTraCid.Visible := IIF(strOpcTela = 'T', False, True);

  cxTblFreteCODTRA.Visible := IIF(strOpcTela = 'T', False, True);
  cxTblFreteCODCID.Visible := IIF(strOpcTela = 'C', False, True);

  pnlFreReg.Visible := fCfgSis('FREREG', varBoolean);
  if pnlFreReg.Visible and (not lblEstadoTraCid.Visible) then
    pnlFreReg.Left := lblEstadoTraCid.Left;


  if not fCfgSis('UTICTE', varBoolean) then
  begin
    pnlTomador.Visible := False;
    pnlCobVal.Visible  := False;
    pnlAliquo.Visible  := False;
  end;

  pgcGeral.ActivePage := tbsCalculoFrete;

  {*REQ.159829**********RP*}
  cxTblFreteVALISE.Visible   := fCfgSis('ISETRC') = '1';
  dbeValIse.Visible          := cxTblFreteVALISE.Visible;
  lblValIse.Visible          := cxTblFreteVALISE.Visible;
  tbsFaixaFatDesc.TabVisible := Not cxTblFreteVALISE.Visible;

  pSetFocus(edtCodTraCid);

  Self.WindowState := wsMaximized;

end;

function TfrmCadRapidoFreteTranspCidade.fGravaItem: Boolean;
  Var
    strMensagem: String;
begin
  If Not fVerificaCampos Then
    Exit(False);

  If cdsFaixas.State In [dsInsert, dsEdit] Then
    cdsFaixas.Post;

  If Not fValidaFaixas(strMensagem) Then
  Begin
    pgcGeral.ActivePage := tbsFaixaFatDesc;
    pSetFocus(cxgFaixas);
    pMensagemOk(strMensagem);
    Exit(False);
  End;

  If cdsTraCid.Active And (cdsTraCid.State in [dsInsert, dsEdit]) Then
  Begin
    cdsTraCid.Post;

    if chkReplicar.Checked Then
      pReplicaDados;

    pHabilitaDesabilitaControles;
  End;

  Result := True;
  pSetFocus(cxFrete);
end;

function TfrmCadRapidoFreteTranspCidade.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin

    If (Sender = edtCodTraCid) And (pnlCabecalho.Enabled) Then
    Begin

      If fEmptyStr(edtCodTraCid.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "'+ IIF(strOpcTela = 'T', 'Transportadora', 'Cidade') +'" é obrigatório!', ['&Ok']);
        Result := False;
      End
      Else
      Begin

        {Transportadora}
        If (strOpcTela = 'T') Then
        Begin

          edtNomTraCid.Text := fRetNomTransportadora(edtCodTraCid.Text);

          If fEmptyStr(edtNomTraCid.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa transportadora não está cadastrada!', ['&Ok']);
            Result := False;
          End;

        End
        Else
        {Cidade}
        If (strOpcTela = 'C') Then
        Begin

          edtNomTraCid.Text    := fRetNomCidade(edtCodTraCid.Text, 0);
          edtEstadoTraCid.Text := fRetNomCidade(edtCodTraCid.Text, 1);

          If fEmptyStr(edtNomTraCid.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
            Result := False;
          End;

        End;

        If (Result) And (not pnlFreReg.Visible) then
          Result := fCarregarFretes;
      End;

    End
    Else
    If (Sender = edtCodFreReg) And (pnlFreReg.Visible) And (pnlCabecalho.Enabled) Then
    Begin

      if not fEmptyStr(edtCodFreReg.Text) then
      begin
        edtNomFreReg.Text := fRetNomFreteRegiao(edtCodFreReg.Text);

        If fEmptyStr(edtNomFreReg.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Frete Região não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      end
      else
        edtNomFreReg.Clear;

      If (Result) Then
        Result := fCarregarFretes;

    End
    Else
    If (Sender = dbeCodTra) And (Sender.Enabled) Then
    Begin

      If fEmptyStr(dbeCodTra.Text) Then
      Begin
        pgcGeral.ActivePage := tbsCalculoFrete;
        fMensagem('ATENÇÃO!', 'O campo "Transportadora" é obrigatório!', ['&Ok']);
        Result := False;
      End
      Else
      Begin

        If (cdsTraCid.Active) And (cdsTraCid.State in [dsInsert, dsEdit]) Then
        Begin

          edtNomTra.Text := fRetNomTransportadora(dbeCodTra.Text);
          cdsTraCidNOMTRA.AsString := edtNomTra.Text;

          If fEmptyStr(edtNomTra.Text) Then
          Begin
            pgcGeral.ActivePage := tbsCalculoFrete;
            fMensagem('ATENÇÃO!', 'Essa transportadora não está cadastrada!', ['&Ok']);
            Result := False;
          End;

          If blnBuscaPorChave Then
            pFiltraDataSetFaixas;
        End;

      End;

    End
    Else
    If (Sender = dbeCodCid) And (Sender.Enabled) Then
    Begin

      If fEmptyStr(dbeCodCid.Text) Then
      Begin
        pgcGeral.ActivePage := tbsCalculoFrete;
        fMensagem('ATENÇÃO!', 'O campo "Cidade" é obrigatório!', ['&Ok']);
        Result := False;
      End
      Else
      Begin

        If (cdsTraCid.Active) And (cdsTraCid.State in [dsInsert, dsEdit]) Then
        Begin

          edtCidade.Text := fRetNomCidade(dbeCodCid.Text, 0);
          edtEstado.Text := fRetNomCidade(dbeCodCid.Text, 1);
          cdsTraCidNOMCID.AsString := edtCidade.Text;
          cdsTraCidESTADO.AsString := edtEstado.Text;

          If fEmptyStr(edtCidade.Text) Then
          Begin
            pgcGeral.ActivePage := tbsCalculoFrete;
            fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
            Result := False;
          End;

          If blnBuscaPorChave Then
            pFiltraDataSetFaixas;
        End;

      End;

    End
    Else
    If (Sender = dbeTomado) and (Sender.Enabled) and (pnlTomador.Visible) Then
    Begin
      If fEmptyStr(dbeTomado.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Frete por Conta do deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (not AnsiMatchStr(dbeTomado.Text, ['E', 'D'])) Then
        Result := False;
    End
    Else
    If (Sender Is TDBEditFocus) And (Sender.Enabled) And (TDBEditFocus(Sender).Field is TFloatField) Then
    Begin

      If fEmptyStr(TDBEditFocus(Sender).Text) Then
        TDBEditFocus(Sender).Field.AsFloat := 0;

      If fStrToFloat(TDBEditFocus(Sender).Text) < 0 Then
      Begin
        pgcGeral.ActivePage := tbsCalculoFrete;
        fMensagem('ATENÇÃO!', 'O valor deve ser maior ou igual a Zero.', ['&Ok']);
        Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmCadRapidoFreteTranspCidade.fValidaFaixas(Out strMensagem: String): Boolean;
  Var
    cdsClone: TUniClientDataSet;
begin
  Result := True;
  cdsClone := TUniClientDataSet.Create(Nil);
  cdsClone.CloneCursor(cdsFaixas, False, True);
  cdsClone.IndexFieldNames := 'FATFIN';

  cdsFaixas.DisableControls;
  Try
    cdsFaixas.First;
    While Not cdsFaixas.Eof Do
    Begin
      If cdsFaixasFATINI.AsFloat < 0 Then
      Begin
        strMensagem := 'O Faturamento inicial não pode ser menor que zero!';
        Result := False;
        Break;
      End;

      If cdsFaixasFATFIN.AsFloat < 0 Then
      Begin
        strMensagem := 'O Faturamento final não pode ser menor que zero!';
        Result := False;
        Break;
      End;

      If CompareValue(cdsFaixasFATFIN.AsFloat, cdsFaixasFATINI.AsFloat) = LessThanValue Then
      Begin
        strMensagem := 'O Faturamento final não pode ser menor que o Faturamento inicial!';
        Result := False;
        Break;
      End;

      If cdsFaixasPERDES.AsFloat < 0 Then
      Begin
        strMensagem := 'O Desconto não pode ser menor que zero!';
        Result := False;
        Break;
      End;

      If cdsFaixasPERDES.AsFloat > 100 Then
      Begin
        strMensagem := 'O Desconto não pode ser maior que 100!';
        Result := False;
        Break;
      End;

      cdsClone.SetRange([cdsFaixasFATINI.AsFloat],[cdsFaixasFATFIN.AsFloat]);

      If cdsClone.RecordCount > 1 Then
      Begin
        strMensagem := 'O valor informado já está sendo utilizado em outra faixa. Favor verificar!';
        Result := False;
        Break;
      End;

      cdsFaixas.Next;
    End;
  Finally
    cdsFaixas.EnableControls;
    FreeAndNil(cdsClone);
  End;
end;

function TfrmCadRapidoFreteTranspCidade.fCarregarFretes: Boolean;
var
  frmAguarde: TfrmGravando;
begin
  Try
    blnMudarFoco := False;
    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fCarregarTraCid;
    frmAguarde.ShowModal;
    Result := frmAguarde.blnConfirma;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  pFreeAndNil(frmAguarde);
end;

procedure TfrmCadRapidoFreteTranspCidade.pFiltraDataSetFaixas;
begin
  cdsFaixas.Filtered := False;
  cdsFaixas.Filter   := 'CODTRA = '+ QuotedStr(cdsTraCidCODTRA.AsString) +' AND CODCID = '+ QuotedStr(cdsTraCidCODCID.AsString);
  cdsFaixas.Filtered := True;
end;

procedure TfrmCadRapidoFreteTranspCidade.pHabilitaDesabilitaControles;
begin
  btnIncluir.Enabled := cdsTraCid.State = dsBrowse;
  btnGravar.Enabled  := cdsTraCid.State In [dsInsert, dsEdit];
  btnAlterar.Enabled := cdsTraCid.State = dsBrowse;
  btnExcluir.Enabled := cdsTraCid.State = dsBrowse;
  btnCancela.Enabled := cdsTraCid.State In [dsInsert, dsEdit];
  cxFrete.Enabled    := cdsTraCid.State = dsBrowse;
  cxgFaixas.Enabled  := cdsTraCid.State In [dsInsert, dsEdit];

  chkReplicar.Enabled := cdsTraCid.State In [dsEdit];
  pEnableConjuntoControles(gpbCalculoFrete,
                           cdsTraCid.State In [dsInsert, dsEdit],
                           [TDBEditFocus, TEditFocus], []);
end;

procedure TfrmCadRapidoFreteTranspCidade.pHabilitaDesabilitaDBEditFocus(
  DBEditFocus: TDBEditFocus; blnHabilita: Boolean);
begin
  If blnHabilita Then
  Begin
    DBEditFocus.Color       := clWindow;
    DBEditFocus.NormalColor := clWindow;
  End
  Else
  Begin
    DBEditFocus.Color       := $00FFDFB8;
    DBEditFocus.NormalColor := $00FFDFB8;
  End;

  DBEditFocus.ReadOnly := not blnHabilita;
  DBEditFocus.TabStop  := blnHabilita;
end;

procedure TfrmCadRapidoFreteTranspCidade.pLiberaEdicao(blnLiberaEdicao: Boolean);
begin
  If (blnLiberaEdicao) Then
  Begin
    pnlCabecalho.Enabled := False;
    pnlGeral.Enabled     := True;
  End
  Else
  Begin
    btnCancela.Click;

    cdsTraCid.EmptyDataSet;
    pnlCabecalho.Enabled := True;
    pnlGeral.Enabled     := False;

    pSetFocus(edtCodTraCid);

  End;
end;

procedure TfrmCadRapidoFreteTranspCidade.pReplicaDados;
var
  cdsClone: TUniClientDataSet;
  intRecNo: Integer;
  intIdx: Integer;
begin
  cdsClone := TUniClientDataSet.Create(Nil);
  try
    cdsClone.CloneCursor(cdsTraCid, False, True);

    cdsClone.RecNo := cdsTraCid.RecNo;

    intRecNo := cdsTraCid.RecNo;
    cdsTraCid.DisableControls;
    cdsTraCid.First;
    try
      While Not cdsTraCid.Eof Do
      Begin
        cdsTraCid.Edit;
        for intIdx := 0 to Pred(cdsTraCid.Fields.Count) do
          if cdsClone.Fields[intIdx].OldValue <> cdsClone.Fields[intIdx].NewValue then
            cdsTraCid.Fields[intIdx].Value := cdsClone.Fields[intIdx].Value;

        cdsTraCid.Post;

        cdsTraCid.Next;
      End;

    finally
      cdsTraCid.RecNo := intRecNo;
      cdsTraCid.EnableControls;
    end;

  finally
    FreeAndNil(cdsClone);
  end;

  chkReplicar.Checked := False;
end;

function TfrmCadRapidoFreteTranspCidade.fCarregarTraCid(pgbStatus: TcxProgressBar = Nil) : Boolean;
const
  strSQL_TRA = 'SELECT F.*, C.CID_NOMCID, C.CID_ESTADO FROM FRETRA F INNER JOIN CADCID C ON C.CID_CODCID = F.FRE_CODCID WHERE F.FRE_CODTRA = :COD';
  strSQL_CID = 'SELECT F.*, T.TRA_NOMTRA FROM FRETRA F INNER JOIN CADTRA T ON T.TRA_CODTRA = F.FRE_CODTRA WHERE F.FRE_CODCID = :COD';
  strSQL_FAI = 'SELECT * FROM FREFAI JOIN FRETRA ON FRETRA.AUTOINCREM = FAI_SEQFRE';
var
  qryAux, qryFaixas: TUniQuery;
  intContador : Integer;
begin
  pInformacao('Carregando ' + IIF(strOpcTela = 'T', 'Cidades', 'Transportadoras') + ', Aguarde...', pgbStatus);
  Result := True;

  Try
    If Not fEmptyStr(edtCodTraCid.Text) Then
    Begin
      cdsTraCid.EmptyDataSet;
      cdsFaixas.EmptyDataSet;

      qryAux := fCriaQuery;
      qryFaixas := fCriaQuery;
      qryFaixas.SQL.Add(strSQL_FAI);

      Try
        qryAux.Close;
        qryAux.SQL.Clear;

        If (strOpcTela = 'T') Then
        Begin
          qryAux.SQL.Add(strSQL_TRA);
          qryFaixas.SQL.Add('WHERE FRE_CODTRA = :COD');
        End
        Else
        Begin
          qryAux.SQL.Add(strSQL_CID);
          qryFaixas.SQL.Add('WHERE FRE_CODCID = :COD');
        End;

        if pnlFreReg.Visible and (not fEmptyStr(edtCodFreReg.Text)) then
          qryAux.SQL.Add('  AND FRE_FREREG = :FREREG');

        qryAux.ParamByName('COD').AsString := edtCodTraCid.Text;
        if pnlFreReg.Visible and (not fEmptyStr(edtCodFreReg.Text)) then
          qryAux.ParamByName('FREREG').AsString := edtCodFreReg.Text;

        qryAux.Open;

        If Not qryAux.IsEmpty Then
        Begin
          cdsTraCid.DisableControls;
          Try
            intContador := 0;
            qryAux.First;
            While Not qryAux.Eof Do
            Begin
              cdsTraCid.Append;

              If (strOpcTela = 'T') Then
              Begin
                cdsTraCidCODTRA.AsString := edtCodTraCid.Text;
                cdsTraCidNOMTRA.AsString := edtNomTraCid.Text;
                cdsTraCidCODCID.AsString := qryAux.FieldByName('FRE_CODCID').AsString;
                cdsTraCidNOMCID.AsString := qryAux.FieldByName('CID_NOMCID').AsString;
                cdsTraCidESTADO.AsString := qryAux.FieldByName('CID_ESTADO').AsString;
              End
              Else
              If (strOpcTela = 'C') Then
              Begin
                cdsTraCidCODTRA.AsString := qryAux.FieldByName('FRE_CODTRA').AsString;
                cdsTraCidNOMTRA.AsString := qryAux.FieldByName('TRA_NOMTRA').AsString;
                cdsTraCidCODCID.AsString := edtCodTraCid.Text;
                cdsTraCidNOMCID.AsString := edtNomTraCid.Text;
                cdsTraCidESTADO.AsString := edtEstadoTraCid.Text;
              End;

              cdsTraCidVALISE.AsFloat  := qryAux.FieldByName('FRE_VALISE').AsFloat;
              cdsTraCidMINFRE.AsFloat  := qryAux.FieldByName('FRE_MINFRE').AsFloat;
              cdsTraCidPERTOT.AsFloat  := qryAux.FieldByName('FRE_PERTOT').AsFloat;
              cdsTraCidVALKIL.AsFloat  := qryAux.FieldByName('FRE_VALKIL').AsFloat;
              cdsTraCidPD100K.AsFloat  := qryAux.FieldByName('FRE_PD100K').AsFloat;
              cdsTraCidPERGRI.AsFloat  := qryAux.FieldByName('FRE_PERGRI').AsFloat;
              cdsTraCidMINGRI.AsFloat  := qryAux.FieldByName('FRE_MINGRI').AsFloat;
              cdsTraCidVALTAS.AsFloat  := qryAux.FieldByName('FRE_VALTAS').AsFloat;
              cdsTraCidTOMADO.AsString  := qryAux.FieldByName('FRE_TOMADO').AsString;
              cdsTraCidCOBVAL.AsFloat  := qryAux.FieldByName('FRE_COBVAL').AsFloat;
              cdsTraCidALIQUO.AsFloat  := qryAux.FieldByName('FRE_ALIQUO').AsFloat;
              cdsTraCid.Post;

              qryAux.Next;

              Inc(intContador);
              pProgresso(intContador, qryAux.RecordCount, pgbStatus);
            End;

            cdsTraCid.First;
          Finally
            cdsTraCid.EnableControls;
          End;
        End;

        {*REQ.159829**********RP*}
        If fCfgSis('ISETRC') = '2' Then
        Begin
          qryFaixas.ParamByName('COD').AsString := edtCodTraCid.Text;
          qryFaixas.Open;

          qryFaixas.First;
          While Not qryFaixas.Eof Do
          Begin
            cdsFaixas.Append;
            cdsFaixasCODTRA.AsString := qryFaixas.FieldByName('FRE_CODTRA').AsString;
            cdsFaixasCODCID.AsString := qryFaixas.FieldByName('FRE_CODCID').AsString;
            cdsFaixasFATINI.AsFloat  := qryFaixas.FieldByName('FAI_FATINI').AsFloat;
            cdsFaixasFATFIN.AsFloat  := qryFaixas.FieldByName('FAI_FATFIN').AsFloat;
            cdsFaixasPERDES.AsFloat  := qryFaixas.FieldByName('FAI_PERDES').AsFloat;
            cdsFaixas.Post;

            qryFaixas.Next;
          End;

          cdsFaixas.First;
        End;

        pLiberaEdicao(True);

        If cdsTraCid.IsEmpty Then
          btnIncluirClick(Self)
        Else
          pSetFocus(cxFrete);
      Finally
        FreeAndNil(qryAux);
        FreeAndNil(qryFaixas);
      End;
    End;
  Except
    Result := False;
  End;
end;

function TfrmCadRapidoFreteTranspCidade.fGravarFRETRA(pgbStatus: TcxProgressBar): Boolean;
const
  strSQL_TRA = 'DELETE FROM FRETRA WHERE FRE_CODTRA = :COD';
  strSQL_CID = 'DELETE FROM FRETRA WHERE FRE_CODCID = :COD';
  strInsert_FRETRA = 'INSERT INTO FRETRA (FRE_CODTRA, ' +
                     '                    FRE_CODCID, ' +
                     '                    FRE_VALISE, ' +
                     '                    FRE_MINFRE, ' +
                     '                    FRE_PERTOT, ' +
                     '                    FRE_VALKIL, ' +
                     '                    FRE_PD100K, ' +
                     '                    FRE_PERGRI, ' +
                     '                    FRE_MINGRI, ' +
                     '                    FRE_VALTAS, ' +
                     '                    AUTOINCREM, ' +
                     '                    FRE_TOMADO, ' +
                     '                    FRE_COBVAL, ' +
                     '                    FRE_ALIQUO) VALUES ' +
                     '                   (:CODTRA,    ' +
                     '                    :CODCID,    ' +
                     '                    :VALISE,    ' +
                     '                    :MINFRE,    ' +
                     '                    :PERTOT,    ' +
                     '                    :VALKIL,    ' +
                     '                    :PD100K,    ' +
                     '                    :PERGRI,    ' +
                     '                    :MINGRI,    ' +
                     '                    :VALTAS,    ' +
                     '                    :AUTINC,    ' +
                     '                    :TOMADO,    ' +
                     '                    :COBVAL,    ' +
                     '                    :ALIQUO)    ';
  strInsert_FREFAI = 'INSERT INTO FREFAI (AUTOINCREM, ' +
                     '                    FAI_SEQFRE, ' +
                     '                    FAI_FATINI, ' +
                     '                    FAI_FATFIN, ' +
                     '                    FAI_PERDES) VALUES ' +
                     '                   (:AUTOIN,    ' +
                     '                    :SEQFRE,    ' +
                     '                    :FATINI,    ' +
                     '                    :FATFIN,    ' +
                     '                    :PERDES)    ';

var
  qryAux, qryFaixas: TUniQuery;
  strAutoinc: String;
begin

  Result := True;
  If (cdsTraCid.Active) And (Not cdsTraCid.IsEmpty) Then
  Begin

    fStartTransaction();

    Try

      qryAux := fCriaQuery;
      qryFaixas := fCriaQuery;

      Try

        {DELETE}
        qryAux.Close;
        qryAux.SQL.Clear;

        //*tabela FREFAI: FK delete cascade
        If (strOpcTela = 'T') Then
          qryAux.SQL.Add(strSQL_TRA)
        Else
          qryAux.SQL.Add(strSQL_CID);

        qryAux.ParamByName('COD').AsString := edtCodTraCid.Text;
        qryAux.ExecSQL;

        {INSERT}
        cdsTraCid.First;
        While Not cdsTraCid.Eof Do
        Begin

          qryAux.Close;
          qryAux.SQL.Clear;
          qryAux.SQL.Add(strInsert_FRETRA);

          strAutoinc := fRetAutoIncrem('FRETRA', VS_strCodEmp);

          qryAux.ParamByName('CODTRA').AsString := cdsTraCidCODTRA.AsString;
          qryAux.ParamByName('CODCID').AsString := cdsTraCidCODCID.AsString;
          qryAux.ParamByName('VALISE').AsFloat  := cdsTraCidVALISE.AsFloat;
          qryAux.ParamByName('MINFRE').AsFloat  := cdsTraCidMINFRE.AsFloat;
          qryAux.ParamByName('PERTOT').AsFloat  := cdsTraCidPERTOT.AsFloat;
          qryAux.ParamByName('VALKIL').AsFloat  := cdsTraCidVALKIL.AsFloat;
          qryAux.ParamByName('PD100K').AsFloat  := cdsTraCidPD100K.AsFloat;
          qryAux.ParamByName('PERGRI').AsFloat  := cdsTraCidPERGRI.AsFloat;
          qryAux.ParamByName('MINGRI').AsFloat  := cdsTraCidMINGRI.AsFloat;
          qryAux.ParamByName('VALTAS').AsFloat  := cdsTraCidVALTAS.AsFloat;
          qryAux.ParamByName('AUTINC').AsString := strAutoinc;
          qryAux.ParamByName('TOMADO').AsString  := cdsTraCidTOMADO.AsString;
          qryAux.ParamByName('COBVAL').AsFloat  := cdsTraCidCOBVAL.AsFloat;
          qryAux.ParamByName('ALIQUO').AsFloat  := cdsTraCidALIQUO.AsFloat;

          qryAux.ExecSQL;

          {*REQ.159829**********RP*}
          If fCfgSis('ISETRC') = '2' Then
          Begin
            cdsFaixas.First;
            While Not cdsFaixas.Eof Do
            Begin
              qryFaixas.Close;
              qryFaixas.SQL.Clear;
              qryFaixas.SQL.Add(strInsert_FREFAI);

              qryFaixas.ParamByName('AUTOIN').AsString := fRetAutoIncrem('FREFAI', VS_strCodEmp);
              qryFaixas.ParamByName('SEQFRE').AsString := strAutoinc;
              qryFaixas.ParamByName('FATINI').AsFloat  := cdsFaixasFATINI.AsFloat;
              qryFaixas.ParamByName('FATFIN').AsFloat  := cdsFaixasFATFIN.AsFloat;
              qryFaixas.ParamByName('PERDES').AsFloat  := cdsFaixasPERDES.AsFloat;
              qryFaixas.ExecSQL;

              cdsFaixas.Next;
            End;
          End;

          cdsTraCid.Next;
        End;


      Finally
        FreeAndNil(qryAux);
        FreeAndNil(qryFaixas);
      End;

      fCommit();

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmCadRapidoFreteTranspCidade.fGravarFRETRA]');
      End;
    End;

  End;

end;

end.
