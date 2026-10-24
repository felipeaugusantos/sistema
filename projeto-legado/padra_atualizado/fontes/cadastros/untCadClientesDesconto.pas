unit untCadClientesDesconto;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, DBEditFocus, Menus, AppEvnts, untCadCliDes, DB, untPaiCad, EditFocus,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadClientesDesconto = class(TfrmPaiCad)
    pnlFundo: TPanel;
    dtsCadCliDes: TDataSource;
    lbl6: TLabel;
    dbeCodCli: TDBEditFocus;
    edtNomCli: TEditFocus;
    lbl1: TLabel;
    dbeCodFor: TDBEditFocus;
    edtNomFor: TEditFocus;
    lblDescMax: TLabel;
    dbePerDes: TDBEditFocus;
    lblPorDesMax: TLabel;
    lbl2: TLabel;
    dbePerCom: TDBEditFocus;
    lbl3: TLabel;
    btnImportar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
  private
     { Private declarations }
     objCliDes: TCadCliDes;
     procedure pLimpaEdits;
     procedure pAfterScroll(DataSet: TDataSet);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;


implementation

uses  untfuncoesSimples,  untPai, untImportCadClientesDesconto;

{$R *.dfm}

procedure TfrmCadClientesDesconto.FormCreate(Sender: TObject);
begin
  inherited;
  objCliDes := TCadCliDes.Create(Self, Self);

  strNomeTabela := 'CLIDES';
  strNomeCampo  := 'CDS_CODCLI';
  qryTabela     := objCliDes.qryCliDes;
  dtsCadCliDes.DataSet := qryTabela;

  qryTabela.AfterScroll := pAfterScroll;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodCli;
  arrCamposChave[1] := dbeCodFor;
end;

procedure TfrmCadClientesDesconto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If ((ActiveControl) = dbeCodCli) Then
    objCliDes.pKeyDownCodigoCliente(dbeCodCli, key, Shift, fValidaCampos, SelectNext)

  Else If ((ActiveControl) = dbeCodFor) Then
    objCliDes.pKeyDownCodigoFornecedor(dbeCodFor, key, Shift, fValidaCampos, SelectNext);
end;

procedure TfrmCadClientesDesconto.pLimpaEdits;
begin
  edtNomCli.Clear;
  edtNomFor.Clear;
end;

function TfrmCadClientesDesconto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    Try
      If (Sender = dbeCodCli) And dbeCodCli.Enabled Then
      Begin
        objCliDes.strCodCli := dbeCodCli.Text;
        edtNomCli.Text := fRetNomCliente(dbeCodCli.Text);
      End

      Else If (Sender = dbeCodFor) And dbeCodFor.Enabled Then
      Begin
        objCliDes.strCodFor := dbeCodFor.Text;
        edtNomFor.Text := fRetNomFornecedor(dbeCodFor.Text);

        If fBuscaPorCamposChave Then
        Begin
          blnMudarFoco := False;
          pHabilitaCodigo(dbeCodCli, dbePerDes, False);
          pHabilitaCodigo(dbeCodFor, dbePerDes, False);
        End;
      End

      Else If (Sender = dbePerDes) Then
        objCliDes.strPerDes := dbePerDes.Text

      Else If (Sender = dbePerCom) Then
        objCliDes.strPerCom := dbePerCom.Text;

    Except
      On E: ExceptionCliDes Do
      Begin
        fMensagem('',E.Message,['&OK']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadClientesDesconto.pAfterScroll(DataSet: TDataSet);
begin
  edtNomCli.Text := fRetNomCliente(DataSet.FieldByName('CDS_CODCLI').AsString);
  edtNomFor.Text := fRetNomFornecedor(DataSet.FieldByName('CDS_CODFOR').AsString);
end;

procedure TfrmCadClientesDesconto.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
end;

procedure TfrmCadClientesDesconto.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodCli, dbePerDes, False);
  pHabilitaCodigo(dbeCodFor, dbePerDes, False);
end;

procedure TfrmCadClientesDesconto.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadClientesDesconto.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadClientesDesconto.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadClientesDesconto.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadClientesDesconto.btnImportarClick(Sender: TObject);
  Var
    frmImportCadClientesDesconto : TfrmImportCadClientesDesconto;
begin
  inherited;
  pCriarFormularios(TfrmImportCadClientesDesconto, frmImportCadClientesDesconto);
  Try
    frmImportCadClientesDesconto.ShowModal;
  Finally
    pFreeAndNil(frmImportCadClientesDesconto);
  End;
end;

procedure TfrmCadClientesDesconto.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodFor, dbeCodFor, True);
  pHabilitaCodigo(dbeCodCli, dbeCodCli, True);

  pLimpaEdits;
  
  dbePerDes.Field.AsFloat := 0;
  dbePerCom.Field.AsFloat := 0;  
end;

procedure TfrmCadClientesDesconto.btnPesquisaClick(Sender: TObject);
begin
//  inherited;
  pLimpaEdits;
  If objCliDes.fPesquisarCadastro And btnAlterar.CanFocus Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadClientesDesconto.dbeCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  objCliDes.pKeyPressCodigoCliente(dbeCodCli,Key,fValidaCampos, SelectNext);
end;

procedure TfrmCadClientesDesconto.dbeCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  objCliDes.pKeyPressCodigoFornecedor(dbeCodFor,Key,fValidaCampos, SelectNext);
end;

procedure TfrmCadClientesDesconto.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
  pSetFocus(btnIncluir);
end;

end.

