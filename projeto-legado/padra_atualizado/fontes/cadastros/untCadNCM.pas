unit untCadNCM;

interface

uses
  Windows, Classes, Controls, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, EditFocus, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, untCadNCMAbreviacoes, strUtils, System.UITypes,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Mask, DBCtrls, DBEditFocus, UniDataSetProvider, UniClientDataSet, Uni,
  untFuncoesSimples, BitBtnLockedIncrem, cxLookAndFeels, untTypesSistema,
  cxLookAndFeelPainters, cxNavigator, Variants, Vcl.Graphics,
  Provider, frxClass, frxExportCSVTestabilidade, Winapi.Messages,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient,
  RLReport, cxContainer, cxLabel, Vcl.Grids, Vcl.DBGrids, DBGridCitel,
  DBMemoFocus, cxTextEdit, MemoFocus, untDllOpeProdFuncoes, untDllOpeProd, cxDropDownEdit, cxCurrencyEdit;

type
  TfrmCadNCM = class(TfrmPaiCad)
    pnlDados: TPanel;
    Panel1: TPanel;
    dtsIcmAlq: TDataSource;
    Label4: TLabel;
    dbeDescri: TDBMemoFocus;
    Label3: TLabel;
    dbeCodNcm: TDBEditFocus;
    dtsTabela: TDataSource;
    gpbAbfIcm: TGroupBox;
    cxgAbfIcm: TcxGrid;
    cxgAbfIcmView: TcxGridDBTableView;
    cxgAbfIcmCODABF: TcxGridDBColumn;
    cxgAbfIcmDESABF: TcxGridDBColumn;
    cxgAbfIcmLevel: TcxGridLevel;
    pnlExcAbfIcm: TPanel;
    btnExcAbfIcm: TBitBtnLocked;
    gpbAbfPis: TGroupBox;
    cxgAbfPis: TcxGrid;
    cxgAbfPisView: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxgAbfPisLevel: TcxGridLevel;
    Panel2: TPanel;
    btnExcAbfPis: TBitBtnLocked;
    gpbAbfCofins: TGroupBox;
    cxgAbfCofins: TcxGrid;
    cxgAbfCofinsView: TcxGridDBTableView;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxgAbfCofinsLevel: TcxGridLevel;
    Panel3: TPanel;
    btnExcAbfCofins: TBitBtnLocked;
    gpbAbfIPI: TGroupBox;
    cxgAbfIPI: TcxGrid;
    cxgAbfIPIView: TcxGridDBTableView;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxgAbfIPILevel: TcxGridLevel;
    Panel4: TPanel;
    btnExcAbfIpi: TBitBtnLocked;
    Label1: TLabel;
    dbeCodExc: TDBEditFocus;
    Label6: TLabel;
    memDescricaoCompleta: TMemoFocus;
    Label2: TLabel;
    DBEditFocus1: TDBEditFocus;
    dbchkAnvObr: TDBCheckBox;
    btnImportar: TBitBtnLocked;
    gpbCBenef: TGroupBox;
    cxgCBenef: TcxGrid;
    cxgCBenefView: TcxGridDBTableView;
    cxgCBenefViewBEN_CODNCM: TcxGridDBColumn;
    cxgCBenefViewBEN_CODEXC: TcxGridDBColumn;
    cxgCBenefViewBEN_ESTADO: TcxGridDBColumn;
    cxgCBenefViewBEN_CODCST: TcxGridDBColumn;
    cxgCBenefViewBEN_CBENEF: TcxGridDBColumn;
    cxgCBenefViewBEN_CODPRE: TcxGridDBColumn;
    cxgCBenefViewBEN_PERPRE: TcxGridDBColumn;
    cxgCBenefLevel: TcxGridLevel;
    Panel5: TPanel;
    btnExcCBenef: TBitBtnLocked;
    cdsCBenef: TUniClientDataSet;
    cdsCBenefBEN_CODNCM: TStringField;
    cdsCBenefBEN_CODEXC: TStringField;
    cdsCBenefBEN_ESTADO: TStringField;
    cdsCBenefBEN_CODCST: TStringField;
    cdsCBenefBEN_CBENEF: TStringField;
    cdsCBenefBEN_CODPRE: TStringField;
    cdsCBenefBEN_PERPRE: TFloatField;
    dtsCBenef: TDataSource;
    Label5: TLabel;
    DBENCM_ABFTRI: TDBEditFocus;
    edtDesAbfTri: TEditFocus;
    dbchkImpSel: TDBCheckBox;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnExcAbfIcmClick(Sender: TObject);
    procedure btnExcAbfPisClick(Sender: TObject);
    procedure btnExcAbfCofinsClick(Sender: TObject);
    procedure btnExcAbfIpiClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodNcmKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodNcmExit(Sender: TObject);
    procedure dbeCodNcmEnter(Sender: TObject);
    procedure dbeDescriKeyPress(Sender: TObject; var Key: Char);
    procedure dbeDescriChange(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
    procedure cdsCBenefAfterInsert(DataSet: TDataSet);
    procedure btnExcCBenefClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cdsCBenefBeforePost(DataSet: TDataSet);
    procedure DBENCM_ABFTRIKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    objAbfIcms: TCadNcmAbfIcms;
    objAbfPis: TCadNcmAbfPis;
    objAbfCofins: TCadNcmAbfCofins;
    objAbfIpi: TCadNcmAbfIpi;
    FDescricaoCompleta: String;
    blnValidaCBenef: Boolean;
    qryCBenef: TUniquery;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pCarregarAbreviacao();
    procedure pHabilitarAbreviacao(blnHabilita: Boolean);
    procedure pHabilitarCampos;
    procedure pFormatarCodigoNCM;
    procedure CarregaBeneficios;
    function fGravaBeneficio: Boolean;
    procedure pApagaBeneficio;
    procedure pCriaClientDataSetCBenef;
    procedure pGravaBeneficio;
    procedure pLimpaClientDataSetCBenef;
    function fValidaBeneficio: Boolean;

  public
    { Public declarations }
  protected
    { Protected declarations }
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;

implementation

{$R *.dfm}

Uses
  SysUtils, Math, Forms, untConsultas, untConstantes;

procedure TfrmCadNCM.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitarCampos;
end;

procedure TfrmCadNCM.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pHabilitarCampos;
end;

procedure TfrmCadNCM.btnExcAbfCofinsClick(
  Sender: TObject);
begin
  inherited;
  objAbfCofins.pExcluiAbreviacao;
end;

procedure TfrmCadNCM.btnExcAbfIcmClick(
  Sender: TObject);
begin
  inherited;
  objAbfIcms.pExcluiAbreviacao;
end;

procedure TfrmCadNCM.btnExcAbfIpiClick(
  Sender: TObject);
begin
  inherited;
  objAbfIpi.pExcluiAbreviacao;
end;

procedure TfrmCadNCM.btnExcAbfPisClick(
  Sender: TObject);
begin
  inherited;
  objAbfPis.pExcluiAbreviacao;
end;

procedure TfrmCadNCM.btnExcCBenefClick(Sender: TObject);
begin
  inherited;
  If not Assigned(cdsCBenef) Then
    Exit;

  If cdsCBenef.IsEmpty Then
    Exit;

  If fMensagem('', 'Deseja excluir o benefício?', ['&Sim', '&Não']) = 1 Then
    cdsCBenef.Delete;
end;

procedure TfrmCadNCM.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadNCM.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
  Begin
    fCommit;
    pCarregarAbreviacao;
    pHabilitarAbreviacao(False);
    pHabilitarCampos;

  End
  Else
    fRollBack;

end;

procedure TfrmCadNCM.btnGravarClick(Sender: TObject);

  function fTrataCodigoInterno(strValue: String): string;
  Begin
    strValue := strValue.Replace('.', '');
    Result := strValue;
    If Result = '00000000' Then
      Exit;
    While (Result[Length(Result)] = '0') And (Length(Result) > 4) do
    Begin
      Delete(Result,Length(Result),1);
    End;
  End;

begin

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  If Not fValidaBeneficio Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    qryTabela.FieldByName('NCM_CODTRA').AsString := fTrataCodigoInterno(dbeCodNcm.Text);

    inherited;

    If blnGravou Then
    Begin
      If Not objAbfIcms.fSalvaAbreviacao(dbeCodNcm.Text, dbeCodExc.Text)  Then
      Begin
        fRollBack;
        Exit;
      End;

      If Not objAbfPis.fSalvaAbreviacao(dbeCodNcm.Text, dbeCodExc.Text)  Then
      Begin
        fRollBack;
        Exit;
      End;

      If Not objAbfCofins.fSalvaAbreviacao(dbeCodNcm.Text, dbeCodExc.Text)  Then
      Begin
        fRollBack;
        Exit;
      End;

      If Not objAbfIpi.fSalvaAbreviacao(dbeCodNcm.Text, dbeCodExc.Text)  Then
      Begin
        fRollBack;
        Exit;
      End;

      If not fGravaBeneficio Then
      Begin
        fRollBack;
        Exit;
      End;

      fCommit;

      pCarregarAbreviacao;
      pHabilitarAbreviacao(False);
      pHabilitarCampos;
    End
    Else
      fRollBack;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadNCM.btnGravarClick]');
    End;
  End;



end;

procedure TfrmCadNCM.btnImportarClick(Sender: TObject);
begin
  inherited;
  pOpeProd(ImportCadNCM);
end;

procedure TfrmCadNCM.btnIncluirClick(Sender: TObject);
begin
  inherited;
  qryTabela.FieldByName('NCM_ANVOBR').AsString := 'N';
  pHabilitarCampos;
end;

procedure TfrmCadNCM.pAfterOpen(DataSet: TDataSet);
begin
//  If DataSet.FindField('NCM_ALQIPI') <> nil Then
//    TFloatField(DataSet.FieldByName('NCM_ALQIPI')).DisplayFormat := '#,##0.00';
  pFormatarCodigoNCM;
end;

procedure TfrmCadNCM.pCarregarAbreviacao();
begin
  objAbfIcms.fCarregaAbreviacao(dbeCodNcm.Text, dbeCodExc.Text);
  objAbfPis.fCarregaAbreviacao(dbeCodNcm.Text, dbeCodExc.Text);
  objAbfCofins.fCarregaAbreviacao(dbeCodNcm.Text, dbeCodExc.Text);
  objAbfIpi.fCarregaAbreviacao(dbeCodNcm.Text, dbeCodExc.Text);
  CarregaBeneficios;
end;

procedure TfrmCadNCM.pFormatarCodigoNCM;
Var
  strMask: String;
  strValor: String;
begin
  If qryTabela.FindField('NCM_CODNCM') = nil Then
    Exit;

  strValor := qryTabela.FieldByName('NCM_CODNCM').AsString;

  strMask := '';

  If (Length(strValor) > 4) Then
    strMask := '9999.99;0;_';

  If (Length(strValor) > 6) Then
    strMask := '9999.99.99;0;_';

  TStringField(qryTabela.FieldByName('NCM_CODNCM')).EditMask := strMask;
end;

procedure TfrmCadNCM.pHabilitarAbreviacao(blnHabilita: Boolean);
begin
  If Length(dbeCodNcm.Text) <> 8 Then
    blnHabilita := False;

  gpbAbfIcm.Enabled := blnHabilita;
  btnExcAbfIcm.Enabled := blnHabilita;
  gpbAbfPis.Enabled := blnHabilita;
  btnExcAbfPis.Enabled := blnHabilita;
  gpbAbfCofins.Enabled := blnHabilita;
  btnExcAbfCofins.Enabled := blnHabilita;
  gpbAbfIpi.Enabled := blnHabilita;
  btnExcAbfIpi.Enabled := blnHabilita;
  gpbCBenef.Enabled := blnHabilita;
  btnExcCBenef.Enabled := blnHabilita;
end;

procedure TfrmCadNCM.pHabilitarCampos;
begin
  If qryTabela.State = dsInsert Then
  Begin
    pHabilitaCodigo(dbeCodExc, dbeCodExc, True);
    pHabilitaCodigo(dbeCodNcm, dbeCodNcm, True);
    pCarregarAbreviacao;
    pHabilitarAbreviacao(True);
    memDescricaoCompleta.Clear;
    FDescricaoCompleta := '';
  End
  Else If qryTabela.State = dsEdit Then
  Begin
    pHabilitaCodigo(dbeCodNcm, dbeDescri, False);
    pHabilitaCodigo(dbeCodExc, dbeDescri, False);
    pCarregarAbreviacao;
    pHabilitarAbreviacao(True);
    FDescricaoCompleta := fRetDescricaoNcm(dbeCodNcm.Text, dbeCodExc.Text);
    memDescricaoCompleta.Text := FDescricaoCompleta;
  End
  Else
  Begin
    pHabilitaCodigo(dbeCodNcm, dbeDescri, False);
    pHabilitaCodigo(dbeCodExc, dbeDescri, False);
    pCarregarAbreviacao();
    pHabilitarAbreviacao(False);
    FDescricaoCompleta := fRetDescricaoNcm(dbeCodNcm.Text, dbeCodExc.Text);
    memDescricaoCompleta.Text := FDescricaoCompleta;
  End;
end;

procedure TfrmCadNCM.pInicializaIndices;
begin
  inherited;
end;

procedure TfrmCadNCM.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrSel: TConsultasArray;
begin
  inherited;
  chrKey := '?';
  If fPesqNCM(Self.Name, qryTabela, chrKey, arrSel) Then
  Begin
    pCarregarAbreviacao;
    fValidaCampos(DBENCM_ABFTRI);
    pHabilitarAbreviacao(False);
    pHabilitarCampos;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadNCM.dbeCodNcmEnter(Sender: TObject);
begin
  inherited;
  TStringField(qryTabela.FieldByName('NCM_CODNCM')).EditMask := '';
end;

procedure TfrmCadNCM.dbeCodNcmExit(Sender: TObject);
begin
  inherited;
  pFormatarCodigoNCM;
end;

procedure TfrmCadNCM.dbeCodNcmKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If Not CharInSet(Key, ['0' .. '9', #13, #8]) Then
    Key := #0;
end;

procedure TfrmCadNCM.dbeDescriChange(Sender: TObject);
begin
  inherited;
  If qryTabela.State = dsEdit Then
  Begin
    memDescricaoCompleta.Text := AnsiReplaceStr(FDescricaoCompleta,
      VarToStr(qryTabela.FieldByName('NCM_DESCRI').OldValue), dbeDescri.Text);
  End;
end;

procedure TfrmCadNCM.dbeDescriKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If Key = #13 Then Key := #0;
end;

procedure TfrmCadNCM.DBENCM_ABFTRIKeyPress(Sender: TObject; var Key: Char);
var  arrSel: TConsultasArray;
begin
  inherited;
  If fPesqAbreviacaoReformaTributaria(Self,  DBENCM_ABFTRI,  edtDesAbfTri,  nil, Key, arrSel) Then
    If fValidaCampos(DBENCM_ABFTRI) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadNCM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If Assigned(cdsCBenef) Then
    FreeAndNil(cdsCBenef);
end;

procedure TfrmCadNCM.FormCreate(Sender: TObject);
begin
  inherited;
  {Se resolução disponível for inferior ou igual à (1366 x 768), posiciona a tela!}
  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.Position := poScreenCenter;

  strNomeTabela := 'CADNCM';
  strNomeCampo := 'NCM_CODNCM';

  qryTabela := fCriarQuery('SELECT * FROM CADNCM WHERE FALSE', Self);
  qryTabela.AfterOpen := pAfterOpen;
  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodNcm;
  arrCamposChave[1] := dbeCodExc;

  dbeDescri.OnKeyDown := pOnKeyDownEdits;

  objAbfIcms := TCadNcmAbfIcms.Create(Self, cxgAbfIcmView);
  cxgAbfIcmView.DataController.DataSource := objAbfIcms.dtsSource;

  objAbfPis := TCadNcmAbfPis.Create(Self, cxgAbfPisView);
  cxgAbfPisView.DataController.DataSource := objAbfPis.dtsSource;

  objAbfCofins := TCadNcmAbfCofins.Create(Self, cxgAbfCofinsView);
  cxgAbfCofinsView.DataController.DataSource := objAbfCofins.dtsSource;

  objAbfIpi := TCadNcmAbfIpi.Create(Self, cxgAbfIpiView);
  cxgAbfIpiView.DataController.DataSource := objAbfIpi.dtsSource;

  pCriaClientDataSetCBenef;

  gpbCBenef.Visible := fCfgSis('CREPRE', varBoolean);

  pCarregarAbreviacao;
  pHabilitarAbreviacao(False);

  btnImportar.Visible := fVerificaAcessoSistema('frmImportCadNCM');
end;

procedure TfrmCadNCM.FormShow(Sender: TObject);
begin
  inherited;
  If not gpbCBenef.Visible Then
    Self.Height := Self.Height - gpbCBenef.Height;
end;

function TfrmCadNCM.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeCodNcm) Then
    Begin
      If (fEmptyStr(dbeCodNcm.Text)) And (dbeCodNcm.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código NCM deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeCodExc) Then
    Begin
      If blnBuscaPorChave Then
      Begin
        If fBuscaPorCamposChave() Then
        Begin
          btnAlterar.Click;
          blnMudarFoco := False;
        End
        Else
          pLimparCampos;
      End;
    End
    Else If (Sender = DBENCM_ABFTRI) Then
    Begin
      If fEmptyStr(DBENCM_ABFTRI.Text) Then
      begin
        fMensagem('ATENÇÃO!', 'A Abreviação da Reforma Tributária deve ser informada!', ['&Ok']);
        Result := False;
      end
      Else
      Begin
        edtDesAbfTri.Text := fRetDescricaoAbfReformaTributaria(DBENCM_ABFTRI.Text);
        If fEmptyStr(edtDesAbfTri.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Abreviação da Reforma Tributária não cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
    End
    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('', 'Informe a descrição!', ['&Ok']);
        Result := False;
      End;
    End

//    Else If (Sender = dbeAlqIpi) Then
//    Begin
//      If fEmptyStr(dbeAlqIpi.Text) Then
//      Begin
//        fMensagem('', 'Informe a alíquota de IPI!', ['&Ok']);
//        Result := False;
//      End
//      Else If fStrToFloat(dbeAlqIpi.Text) < 0 Then
//      Begin
//        fMensagem('', 'A alíquota de IPI não pode ser negativa!', ['&Ok']);
//        Result := False;
//      End
//      Else If fStrToFloat(dbeAlqIpi.Text) > 100 Then
//      Begin
//        fMensagem('', 'A alíquota de IPI não pode ser maior que 100!', ['&Ok']);
//        Result := False;
//      End;
//    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

  If qryTabela.State In ([dsInsert, dsEdit]) Then
    pHabilitarAbreviacao(True);
end;

procedure TfrmCadNCM.pCriaClientDataSetCBenef;
begin
  cdsCBenef.CreateDataSet;
  dtsCBenef.DataSet := cdsCBenef;
  cxgCBenefView.DataController.DataSource := dtsCBenef;
end;

procedure TfrmCadNCM.pLimpaClientDataSetCBenef;
begin
  If Assigned(cdsCBenef) Then
    cdsCBenef.EmptyDataSet;
end;

procedure TfrmCadNCM.CarregaBeneficios;
begin

  If not fCfgSis('CREPRE', varBoolean) Then
    Exit;

  pLimpaClientDataSetCBenef;

  qryCBenef := fCriaQuery(Self);

  cdsCBenef.DisableControls;

  blnValidaCBenef := False;

  Try
    qryCBenef := fCriaQuery(Self);
    qryCBenef.Close;
    qryCBenef.SQL.Add('SELECT ');
    qryCBenef.SQL.Add('  BEN_CODNCM, ');
    qryCBenef.SQL.Add('  BEN_CODEXC, ');
    qryCBenef.SQL.Add('  BEN_ESTADO, ');
    qryCBenef.SQL.Add('  BEN_CODCST, ');
    qryCBenef.SQL.Add('  BEN_CBENEF, ');
    qryCBenef.SQL.Add('  BEN_CODPRE, ');
    qryCBenef.SQL.Add('  BEN_PERPRE ');
    qryCBenef.SQL.Add('FROM BENPRE ');
    qryCBenef.SQL.Add('WHERE BEN_CODNCM = :CODNCM ');
    qryCBenef.SQL.Add('  AND BEN_CODEXC = :CODEXC ');
    qryCBenef.SQL.Add('ORDER BY BEN_ESTADO, BEN_CODCST ');
    qryCBenef.ParamByName('CODNCM').AsString := dbeCodNcm.Text;
    qryCBenef.ParamByName('CODEXC').AsString := dbeCodExc.Text;
    qryCBenef.Open;

    qryCBenef.First;

    While not qryCBenef.eof Do
    Begin
      cdsCBenef.Append;
      cdsCBenef.FieldByName('BEN_CODNCM').AsString := qryCBenef.FieldByName('BEN_CODNCM').AsString;
      cdsCBenef.FieldByName('BEN_CODEXC').AsString := qryCBenef.FieldByName('BEN_CODEXC').AsString;
      cdsCBenef.FieldByName('BEN_ESTADO').AsString := qryCBenef.FieldByName('BEN_ESTADO').AsString;
      cdsCBenef.FieldByName('BEN_CODCST').AsString := qryCBenef.FieldByName('BEN_CODCST').AsString;
      cdsCBenef.FieldByName('BEN_CBENEF').AsString := qryCBenef.FieldByName('BEN_CBENEF').AsString;
      cdsCBenef.FieldByName('BEN_CODPRE').AsString := qryCBenef.FieldByName('BEN_CODPRE').AsString;
      cdsCBenef.FieldByName('BEN_PERPRE').AsFloat  := qryCBenef.FieldByName('BEN_PERPRE').AsFloat;
      cdsCBenef.Post;

      qryCBenef.Next;
    End;
  Finally
    blnValidaCBenef := True;
    cdsCBenef.First;
    cdsCBenef.EnableControls;
    FreeAndNil(qryCBenef);
  End;
end;

procedure TfrmCadNCM.cdsCBenefAfterInsert(DataSet: TDataSet);
begin
  inherited;
  cdsCBenef.FieldByName('BEN_CODNCM').AsString := dbeCodNcm.Text;
  cdsCBenef.FieldByName('BEN_CODEXC').AsString := dbeCodExc.Text;
  cdsCBenef.FieldByName('BEN_PERPRE').AsFloat  := 0;
end;

procedure TfrmCadNCM.cdsCBenefBeforePost(DataSet: TDataSet);
begin
  If not blnValidaCBenef Then
    Exit;

  If fEmptyStr(cdsCBenef.FieldByName('BEN_ESTADO').AsString) Then
  Begin
    fMensagem('ATENÇÃO!', 'O campo "Estado" deve ser preenchido!', ['&Ok']);
    Abort;
  End;

  If fEmptyStr(cdsCBenef.FieldByName('BEN_CODCST').AsString) Then
  Begin
    fMensagem('ATENÇÃO!', 'O campo "CST" deve ser preenchido!', ['&Ok']);
    Abort;
  End;

  If fEmptyStr(cdsCBenef.FieldByName('BEN_CBENEF').AsString) Then
  Begin
    fMensagem('ATENÇÃO!', 'O campo "Cód. Benefício Fiscal" deve ser preenchido!', ['&Ok']);
    Abort;
  End;

  If (cdsCBenef.FieldByName('BEN_PERPRE').AsFloat < 0) Or (cdsCBenef.FieldByName('BEN_PERPRE').AsFloat > 100) Then
  Begin
    fMensagem('ATENÇÃO!', 'Campo "Percentual de Crédito Presumido" inválido!', ['&Ok']);
    Abort;
  End;

  inherited;
end;

procedure TfrmCadNCM.pApagaBeneficio;
var
  qryDelete: TUniQuery;
begin
  qryDelete := fCriaQuery(Nil);

  Try
    qryDelete.Close;
    qryDelete.SQL.Clear;
    qryDelete.SQL.Add(' DELETE FROM BENPRE ');
    qryDelete.SQL.Add(' WHERE BEN_CODNCM = :CODNCM ');
    qryDelete.SQL.Add('   AND BEN_CODEXC = :CODEXC ');
    qryDelete.ParamByName('CODNCM').AsString := dbeCodNcm.Text;
    qryDelete.ParamByName('CODEXC').AsString := dbeCodExc.Text;
    qryDelete.ExecSQL;
  Finally
    FreeAndNil(qryDelete);
  End;
end;

procedure TfrmCadNCM.pGravaBeneficio;
var
  qryInsert: TUniQuery;
begin
  qryInsert := fCriaQuery(Nil);

  Try
    qryInsert.Close;
    qryInsert.Sql.Text := 'SELECT * FROM BENPRE WHERE FALSE ';
    qryInsert.Open;

    cdsCBenef.DisableControls;
    cdsCBenef.First;

    Try
      While not cdsCBenef.eof Do
      Begin
        qryInsert.Insert;
        qryInsert.FieldByName('BEN_CODNCM').AsString := cdsCBenef.FieldByName('BEN_CODNCM').AsString;
        qryInsert.FieldByName('BEN_CODEXC').AsString := cdsCBenef.FieldByName('BEN_CODEXC').AsString;
        qryInsert.FieldByName('BEN_ESTADO').AsString := cdsCBenef.FieldByName('BEN_ESTADO').AsString;
        qryInsert.FieldByName('BEN_CODCST').AsString := cdsCBenef.FieldByName('BEN_CODCST').AsString;
        qryInsert.FieldByName('BEN_CBENEF').AsString := cdsCBenef.FieldByName('BEN_CBENEF').AsString;
        qryInsert.FieldByName('BEN_CODPRE').AsString := cdsCBenef.FieldByName('BEN_CODPRE').AsString;
        qryInsert.FieldByName('BEN_PERPRE').AsFloat  := cdsCBenef.FieldByName('BEN_PERPRE').AsFloat;
        qryInsert.Post;

        cdsCBenef.Next;
      End;
    Except
      On E: Exception Do
      begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmCadNCM.pGravaBeneficio]')
      end;
    End;

  Finally
    FreeAndNil(qryInsert);
    cdsCBenef.EnableControls;
  End;
end;

function TfrmCadNCM.fValidaBeneficio: Boolean;
var
  cdsCBenefCop :TUniClientDataSet;
begin
  cdsCBenefCop := TUniClientDataSet.Create(nil);
  cdsCBenefCop.Data := cdsCBenef.Data;

  Result := True;

  cdsCBenef.DisableControls;
  cdsCBenef.First;

  Try
    While not cdsCBenef.eof Do
    Begin
      cdsCBenefCop.Filtered := False;
      cdsCBenefCop.Filter := 'BEN_ESTADO = '+QuotedStr(cdsCBenef.FieldByName('BEN_ESTADO').AsString)+' AND '+
                             'BEN_CODCST = '+QuotedStr(cdsCBenef.FieldByName('BEN_CODCST').AsString);
      cdsCBenefCop.Filtered := True;

      If cdsCBenefCop.RecordCount > 1 Then
      Begin
        fMensagem('ATENÇÃO!', 'Existe benefício duplicado. Verifique o Estado e a CST!', ['&Ok']);
        Result := False;
        Break;
      End;

      cdsCBenef.Next;
    End;
  Finally
    cdsCBenef.EnableControls;
    FreeAndNil(cdsCBenefCop);
  End;
end;

function TfrmCadNCM.fGravaBeneficio: Boolean;
begin
  Result := True;

  Try
    pApagaBeneficio;
    pGravaBeneficio;
  Except
    Result := False;
  End;
end;

end.
