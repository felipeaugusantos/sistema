unit untCadRegioesDesconto;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, DBEditFocus, Menus, AppEvnts, untCadRegDes, DB, untPaiCad, EditFocus,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadRegioesDesconto = class(TfrmPaiCad)
    pnlFundo: TPanel;
    dtsCadRegDes: TDataSource;
    lbl6: TLabel;
    dbeCodReg: TDBEditFocus;
    edtNomReg: TEditFocus;
    lbl1: TLabel;
    dbeCodFor: TDBEditFocus;
    edtNomFor: TEditFocus;
    lblDescMax: TLabel;
    dbePerDes: TDBEditFocus;
    lblPorDesMax: TLabel;
    lbl2: TLabel;
    dbePerCom: TDBEditFocus;
    lbl3: TLabel;
    btnImportacao: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnImportacaoClick(Sender: TObject);
  private
     { Private declarations }
     objRegDes: TCadRegDes;
     procedure pLimpaEdits;
     procedure pAfterScroll(DataSet: TDataSet);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

implementation

uses untfuncoesSimples, untPai, untImportacaoCadRegioesDesconto;

{$R *.dfm}

procedure TfrmCadRegioesDesconto.FormCreate(Sender: TObject);
begin
  inherited;
  objRegDes     := TCadRegDes.Create(Self, Self);

  strNomeTabela := 'REGDES';
  strNomeCampo  := 'RDS_CODREG';
  qryTabela     := objRegDes.qryRegDes;
  dtsCadRegDes.DataSet := qryTabela;

  qryTabela.AfterScroll := pAfterScroll;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodReg;
  arrCamposChave[1] := dbeCodFor;
end;

procedure TfrmCadRegioesDesconto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If ((ActiveControl) = dbeCodReg) Then
    objRegDes.pKeyDownCodigoRegiao(dbeCodReg, key, Shift, fValidaCampos, SelectNext)

  Else If ((ActiveControl) = dbeCodFor) Then
    objRegDes.pKeyDownCodigoFornecedor(dbeCodFor, key, Shift, fValidaCampos, SelectNext);
end;

procedure TfrmCadRegioesDesconto.pLimpaEdits;
begin
  edtNomReg.Clear;
  edtNomFor.Clear;
end;

function TfrmCadRegioesDesconto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    Try
      If (Sender = dbeCodReg) And dbeCodReg.Enabled Then
      Begin
        objRegDes.strCodReg := dbeCodReg.Text;
        edtNomReg.Text := fRetNomRegiao(dbeCodReg.Text);
      End

      Else If (Sender = dbeCodFor) And dbeCodFor.Enabled Then
      Begin
        objRegDes.strCodFor := dbeCodFor.Text;
        edtNomFor.Text := fRetNomFornecedor(dbeCodFor.Text);

        If fBuscaPorCamposChave Then
        Begin
          blnMudarFoco := False;
          pHabilitaCodigo(dbeCodReg, dbePerDes, False);
          pHabilitaCodigo(dbeCodFor, dbePerDes, False);
        End;
      End

      Else If (Sender = dbePerDes) Then
        objRegDes.strPerDes := dbePerDes.Text

      Else If (Sender = dbePerCom) Then
        objRegDes.strPerCom := dbePerCom.Text;

    Except
      On E: ExceptionRegDes Do
      Begin
        fMensagem('',E.Message,['&OK']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadRegioesDesconto.pAfterScroll(DataSet: TDataSet);
begin
  edtNomReg.Text := fRetNomRegiao(DataSet.FieldByName('RDS_CODREG').AsString);
  edtNomFor.Text := fRetNomFornecedor(DataSet.FieldByName('RDS_CODFOR').AsString);
end;

procedure TfrmCadRegioesDesconto.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
end;

procedure TfrmCadRegioesDesconto.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodReg, dbePerDes, False);
  pHabilitaCodigo(dbeCodFor, dbePerDes, False);
end;

procedure TfrmCadRegioesDesconto.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadRegioesDesconto.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadRegioesDesconto.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadRegioesDesconto.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadRegioesDesconto.btnImportacaoClick(Sender: TObject);
begin
  inherited;
  pCriarForm(TfrmImportacaoCadRegioesDesconto);
end;

procedure TfrmCadRegioesDesconto.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodFor, dbeCodFor, True);
  pHabilitaCodigo(dbeCodReg, dbeCodReg, True);

  pLimpaEdits;
  
  dbePerDes.Field.AsFloat := 0;
  dbePerCom.Field.AsFloat := 0;  
end;

procedure TfrmCadRegioesDesconto.btnPesquisaClick(Sender: TObject);
begin
  //  inherited;
  pLimpaEdits;
  If objRegDes.fPesquisarCadastro And btnAlterar.CanFocus Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadRegioesDesconto.dbeCodRegKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  objRegDes.pKeyPressCodigoRegiao(dbeCodReg,Key,fValidaCampos, SelectNext);
end;

procedure TfrmCadRegioesDesconto.dbeCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  objRegDes.pKeyPressCodigoFornecedor(dbeCodFor, Key, fValidaCampos, SelectNext);
end;

procedure TfrmCadRegioesDesconto.FormShow(Sender: TObject);
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

