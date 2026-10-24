unit untCadFatReg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Data.DB, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxTextEdit,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, untCadNCMFatReg, untCalcFatReg, EditFocus;

type
  TfrmCadFatReg = class(TfrmPaiCad)
    pnlPrincipal: TPanel;
    dtsTabela: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbeCodFatReg: TDBEditFocus;
    dbeDesFatReg: TDBEditFocus;
    dbeIvaFatReg: TDBEditFocus;
    Label4: TLabel;
    grbNCM: TGroupBox;
    pnlNCM: TPanel;
    btnExcluiNCM: TBitBtnLocked;
    cxgNCM: TcxGrid;
    cxgNCMView: TcxGridDBTableView;
    cxgFatRegCODNCM: TcxGridDBColumn;
    cxgFatRegDESNCM: TcxGridDBColumn;
    cxgNCMLevel: TcxGridLevel;
    grbFatReg: TGroupBox;
    pnlFatReg: TPanel;
    btnCalculaFatReg: TBitBtnLocked;
    cxgFatReg: TcxGrid;
    cxgFatRegView: TcxGridDBTableView;
    cxgfatRegLevel: TcxGridLevel;
    cxgCalcESTADO: TcxGridDBColumn;
    cxgCalcALQINT: TcxGridDBColumn;
    cxgCalcALQEST: TcxGridDBColumn;
    cxgCalcFATREG: TcxGridDBColumn;
    Label5: TLabel;
    dbeEntAma: TDBEditFocus;
    Label6: TLabel;
    dbeCodTri: TDBEditFocus;
    edtDesTri: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeCodFatRegExit(Sender: TObject);
    procedure btnExcluiNCMClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnCalculaFatRegClick(Sender: TObject);
    procedure dbeCodTriKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    objNCM: TCadNcmFatReg;
    objCalcFatReg: TCalcFatReg;

    procedure pAfterScroll(Dataset: TDataset);
    procedure pCarregarNCM;
    procedure pHabilitarNCM(blnHabilita: Boolean);
    procedure pHabilitarCalcFatReg(blnHabilita: Boolean);
    procedure pHabilitaCampos(blnHabilita: Boolean);
    procedure pCarregaAliquotas;

    procedure pCarregaDadosAdicionais;

  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses
  untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}


procedure TfrmCadFatReg.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodFatReg, dbeDesFatReg, False);
  pHabilitaCampos(True);
end;

procedure TfrmCadFatReg.btnCalculaFatRegClick(Sender: TObject);
begin
  inherited;
  if (not fEmptyStr(dbeCodFatReg.Text)) and (not fEmptyStr(dbeIvaFatReg.Text)) then
  begin
    objCalcFatReg.fAtualizaCalculoFatorRegional(StrToFloatDef(dbeIvaFatReg.Text,0));
  end;
end;

procedure TfrmCadFatReg.btnCancelaClick(Sender: TObject);
begin
  inherited;

  pCarregaDadosAdicionais;
  pHabilitaCampos(False);
end;

procedure TfrmCadFatReg.btnExcluiNCMClick(Sender: TObject);
begin
  inherited;
  objNCM.pExcluiNCM;
end;

procedure TfrmCadFatReg.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFatReg.btnExcluirClick]');
    End;
  End;

  if blnExcluiu then
  begin
    objNCM.EmptyDataSet;
    objCalcFatReg.EmptyDataSet;
    pHabilitaCampos(False);
    fCommit
  end
  else
    fRollBack;
end;

procedure TfrmCadFatReg.pCarregaDadosAdicionais;
Begin
  pCarregarNCM;
  pCarregaAliquotas;
  edtDesTri.Text := fRetSitTributaria(dbeCodTri.Text);
End;

procedure TfrmCadFatReg.btnGravarClick(Sender: TObject);
begin
  If Not fValidacoesBotaoGravarPai Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  blnGravou := False;
  blnUsaVerificaCamposPai := False;

  If fEmptyStr(qryTabela.FieldByName('REG_CODTRI').AsString) Then
    qryTabela.FieldByName('REG_CODTRI').Clear;

  Try
    inherited;

    If blnGravou Then
    Begin
      If Not objNCM.fSalvaNCM(dbeCodFatReg.Text)  Then
      Begin
        fRollBack;
        Exit;
      End;

      fCommit;
      pCarregaDadosAdicionais;
      pHabilitaCampos(False);
    End
    Else
    Begin
      fRollBack;
    End;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFatReg.btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadFatReg.btnIncluirClick(Sender: TObject);
begin
  inherited;
  if objNCM.Active then
  begin
    objNCM.EmptyDataSet;
  end;

  if objCalcFatReg.Active then
  begin
    objCalcFatReg.EmptyDataSet;
  end;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodFatReg, dbeDesFatReg, False)
  Else
    pHabilitaCodigo(dbeCodFatReg, dbeCodFatReg, True);
end;

procedure TfrmCadFatReg.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrAtiv: TConsultasArray;
begin
  inherited;
  chrKey := '/';
  If fPesqFatorRegional(Self, Nil, Nil, qryTabela, chrKey, arrAtiv) Then
  Begin
    pCarregaDadosAdicionais;
    pHabilitaCampos(False);
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadFatReg.dbeCodFatRegExit(Sender: TObject);
begin
  if (dbeCodFatReg.Enabled) then
  begin
    dbeCodFatReg.Field.AsString := fPadL(dbeCodFatReg.Field.AsString, 5, '0');
  end;

  inherited;

  fValidaCampos(dbeCodFatReg, True);
end;

procedure TfrmCadFatReg.dbeCodTriKeyPress(Sender: TObject; var Key: Char);
  var
    arrSitTrib: TConsultasArray;
begin
  inherited;

  If fPesqSitTributaria(Self, dbeCodTri, edtDesTri, Nil, Key, arrSitTrib) And
     fValidaCampos(dbeCodTri, True) Then
      SelectNext(ActiveControl, True, True);

end;

procedure TfrmCadFatReg.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadFatReg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If (Action <> CaNone) Then
    qryTabela.AfterScroll := Nil;
end;

procedure TfrmCadFatReg.FormCreate(Sender: TObject);
begin
  inherited;
  {Se resolução disponível for inferior ou igual à (1366 x 768), ajusta a tela!}
  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.Position := poScreenCenter;

  strNomeTabela := 'FATREG';
  strNomeCampo := 'REG_CODIGO';

  qryTabela := fCriarQuery('SELECT * FROM FATREG WHERE FALSE', Self);
  dtsTabela.DataSet := qryTabela;
  qryTabela.AfterScroll := pAfterScroll;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodFatReg;

  objNCM := TCadNcmFatReg.Create(Self, cxgNCMView);
  cxgNCMView.DataController.DataSource := objNCM.dtsSource;

  objCalcFatReg := TCalcFatReg.Create(Self, cxgFatRegView);
  cxgFatRegView.DataController.DataSource := objCalcFatReg.dtsSource;

  pCarregaDadosAdicionais;
  pHabilitaCampos(False);
end;

function TfrmCadFatReg.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodFatReg) Then
    Begin
      if (fEmptyStr(dbeCodFatReg.Text)) and (dbeCodFatReg.Enabled) then
      begin
        fMensagem('ATENÇÃO!', 'O Código do Fator Regional deve ser preenchido!', ['&Ok']);
        Result := False;
      end;
    End

    Else If (Sender = dbeDesFatReg) Then
    Begin
      if (fEmptyStr(dbeDesFatReg.Text)) then
      begin
        fMensagem('ATENÇÃO!', 'A descrição do Fator Regional deve ser preenchido!', ['&Ok']);
        Result := False;
      end;
    End

    Else If (Sender = dbeIvaFatReg) Then
    Begin
      if (fEmptyStr(dbeIvaFatReg.Text)) then
      begin
        fMensagem('ATENÇÃO!', 'O IVA original do Fator Regional deve ser preenchido!', ['&Ok']);
        Result := False;
      end
      else
      if (StrToFloatDef(dbeIvaFatReg.Text,0) <= 0) or (StrToFloatDef(dbeIvaFatReg.Text,0) > 100) then
      begin
        fMensagem('ATENÇÃO!', 'O IVA original deve ser entre 0.01 e 100.00 !', ['&Ok']);
        Result := False;
      end;
    End

    Else If (Sender = dbeEntAma) Then
    Begin

      If fEmptyStr(dbeEntAma.Text) Then
      Begin
        pMensagemOk('Informe o Código de Entrada no Amazonas!');
        Result := False;
      End;

    End

    Else If (Sender = dbeCodTri) Then
    Begin

      If fEmptyStr(dbeCodTri.Text) Then
      Begin
        edtDesTri.Clear;
      End Else
      Begin
        edtDesTri.Text := fRetSitTributaria(dbeCodTri.Text);

        If fEmptyStr(edtDesTri.Text) Then
        Begin
          pMensagemOk('Código da Situação Tributária não cadastrado!');
          Result := False;
        End;

      End;

    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
  If qryTabela.State In ([dsInsert, dsEdit]) Then
  Begin
    pCarregaAliquotas;
    pHabilitaCampos(True);
  End;
end;

procedure TfrmCadFatReg.pAfterScroll(Dataset: TDataset);
begin
  TFloatField(Dataset.FieldByName('REG_IVAORI')).DisplayFormat := '#,##0.00';
  TFloatField(Dataset.FieldByName('REG_IVAORI')).EditFormat    := '#,##0.00';
end;

procedure TfrmCadFatReg.pCarregaAliquotas;
begin
  if (not fEmptyStr(dbeCodFatReg.Text)) and (not fEmptyStr(dbeIvaFatReg.Text)) then
  begin
    objCalcFatReg.fCarregaAliquota(dbeCodFatReg.Text, StrToFloatDef(dbeIvaFatReg.Text, 0));
  end;
end;

procedure TfrmCadFatReg.pCarregarNCM;
begin
  objNCM.fCarregaNCM(dbeCodFatReg.Text);
end;

procedure TfrmCadFatReg.pHabilitaCampos(blnHabilita: Boolean);
begin
  pHabilitarNCM(blnHabilita);
  pHabilitarCalcFatReg(blnHabilita);
end;

procedure TfrmCadFatReg.pHabilitarCalcFatReg(blnHabilita: Boolean);
begin
  btnCalculaFatReg.Enabled := blnHabilita;
  cxgCalcALQINT.Options.Editing := blnHabilita;
  cxgCalcALQEST.Options.Editing := blnHabilita;
end;

procedure TfrmCadFatReg.pHabilitarNCM(blnHabilita: Boolean);
begin
  grbNCM.Enabled := blnHabilita;
  btnExcluiNCM.Enabled  := blnHabilita;
end;

procedure TfrmCadFatReg.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('REG_CODIGO');
  stlCampos.Add('REG_DESCRI');
  stlCampos.Add('REG_IVAORI');
  stlCampos.Add('REG_CODEMP');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('REG_CODIGO');
  stlCamInd.Add('REG_DESCRI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

end.
