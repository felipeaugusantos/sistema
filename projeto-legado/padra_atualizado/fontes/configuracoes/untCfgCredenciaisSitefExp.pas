unit untCfgCredenciaisSitefExp;

interface

uses
  Windows, Classes, Controls, Forms, untPaiSimples, Grids, DBGridCitel, DBGrids, Mask,
  FilenameEditFocus, StdCtrls, EditFocus, AppEvnts, Menus, ComCtrls,
  Buttons, BitBtnLockedIncrem, ExtCtrls, DB, UniClientDataSet, UniDataSetProvider,
  Uni, Provider, frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  Datasnap.DBClient, cxButtonEdit, untTCfgCredenciaisSitefExp;

type
  TModoTela = (modoInserir, modoAlterar);

  TfrmCfgCredenciaisSitefExp = class(TfrmPaiSimples)
    Panel1: TPanel;
    Label1: TLabel;
    edtUrl: TEditFocus;
    btnInserir: TBitBtnLocked;
    Panel2: TPanel;
    BitBtnLocked1: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    dbgCredenciais: TDBGridCitel;
    dtsCredenciais: TDataSource;
    Label2: TLabel;
    edtCodCli: TEditFocus;
    edtUsr: TEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    edtPwd: TEditFocus;
    btnCancelar: TBitBtnLocked;
    procedure btnInserirClick(Sender: TObject);
    procedure dbgCredenciaisKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure dbgCredenciaisDblClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    FCfgCred: TCfgCredenciaisSitefExp;
    FModoTela: TModoTela;

    procedure pSetModoAlterar;
    procedure pSetModoInserir;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses SysUtils, StrUtils, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCfgCredenciaisSitefExp.btnCancelarClick(Sender: TObject);
begin
  inherited;
  pSetModoInserir;
end;

procedure TfrmCfgCredenciaisSitefExp.btnGravarClick(Sender: TObject);
begin
  inherited;

  If FModoTela = modoAlterar then
  begin
    If (fMensagem('ATENÇÃO!','Dados em edição serão perdidos. Deseja continuar ?', ['&Sim','&Não'], 2) <> 1) Then
      Exit;
  end;

  FCfgCred.pGravarCredenciais;
  Close;
end;

procedure TfrmCfgCredenciaisSitefExp.btnInserirClick(Sender: TObject);
begin
  inherited;

  try
    if FModoTela = modoInserir then
    begin
      FCfgCred.pInserir(edtUrl.Text, edtCodCli.Text, edtUsr.Text, edtPwd.Text);
    end;

    if FModoTela = modoAlterar then
    begin
      FCfgCred.pAlterar(edtUrl.Text, edtCodCli.Text, edtUsr.Text, edtPwd.Text);
      pSetModoInserir;
    end;

  except
    on E: Exception do
    begin
      fMensagem('ATENÇÃO!',E.Message,['&O k']);
    end;
  end;
end;

procedure TfrmCfgCredenciaisSitefExp.dbgCredenciaisDblClick(Sender: TObject);
begin
  inherited;
  if not dtsCredenciais.DataSet.IsEmpty then
    pSetModoAlterar;
end;

procedure TfrmCfgCredenciaisSitefExp.dbgCredenciaisKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) And (Not dtsCredenciais.DataSet.IsEmpty) Then
  Begin
    If (fMensagem('ATENÇÃO!','Deseja realmente excluir a credencial selecionada ?', ['&Sim','&Não'], 2) = 1) Then
    Begin
      FCfgCred.pExcluir(dtsCredenciais.DataSet.FieldByName('SEQCRE').AsInteger);
    End;
  End
  Else If (Key = VK_RETURN) And (Not dtsCredenciais.DataSet.IsEmpty) Then
  Begin
    pSetModoAlterar;
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    pSetModoInserir;
  End;
end;

procedure TfrmCfgCredenciaisSitefExp.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(FCfgCred);
end;

procedure TfrmCfgCredenciaisSitefExp.FormCreate(Sender: TObject);
begin
  inherited;
  FCfgCred := TCfgCredenciaisSitefExp.Create;
  dtsCredenciais.DataSet := FCfgCred.fGetDataset;
end;

procedure TfrmCfgCredenciaisSitefExp.FormShow(Sender: TObject);
begin
  inherited;
  pSetModoInserir;
end;

function TfrmCfgCredenciaisSitefExp.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
end;

procedure TfrmCfgCredenciaisSitefExp.pSetModoAlterar;
begin
  edtUrl.Text    := dtsCredenciais.DataSet.FieldByName('URLAPI').AsString;
  edtCodCli.Text := dtsCredenciais.DataSet.FieldByName('CODCLI').AsString;
  edtUsr.Text    := dtsCredenciais.DataSet.FieldByName('USRAUT').AsString;
  edtPwd.Text    := dtsCredenciais.DataSet.FieldByName('PWDAUT').AsString;
  pSetFocus(edtUrl);

  dbgCredenciais.Enabled := False;
  btnCancelar.Visible := True;
  FModoTela := modoAlterar;
end;

procedure TfrmCfgCredenciaisSitefExp.pSetModoInserir;
begin
  edtUrl.Clear;
  edtCodCli.Clear;
  edtUsr.Clear;
  edtPwd.Clear;
  pSetFocus(dbgCredenciais);

  dbgCredenciais.Enabled := True;
  btnCancelar.Visible := False;
  FModoTela := modoInserir;
end;

end.
