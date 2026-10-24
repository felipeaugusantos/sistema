unit untCfgBancoDados;

interface

uses
  Windows, Classes, Controls, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  MaskEditFocus, AppEvnts, BitBtnLockedIncrem, Mask;

type
  TfrmCfgBancoDados = class(TfrmPai)
    pnlCentral: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    mskNroIp: TMaskEditFocus;
    edtNomeBanco: TEditFocus;
    btnGravar: TBitBtnLocked;
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure pGravaArqIni;
    procedure pCarregaArqIni;
  public
    { Public declarations }
  end;

var
  frmCfgBancoDados: TfrmCfgBancoDados;

implementation

uses SysUtils, Forms, untFuncoes, untFuncoesSimples;

{$R *.dfm}

{ TfrmCfgBancoDados }

procedure TfrmCfgBancoDados.pCarregaArqIni;
begin
  {*****************************************}
  {* CARREGA DADOS SOBRE O BANCO DE DADOS  *}
  {**************************************MV*}
  mskNroIp.Text     := fArqIni(0, 'BANCO', 'NUMIP', '');
  edtNomeBanco.Text := fArqIni(0, 'BANCO', 'NOMBAN', '');
end;

procedure TfrmCfgBancoDados.pGravaArqIni;
begin
  fArqIni(1, 'BANCO', 'NUMIP', mskNroIp.Text);
  fArqIni(1, 'BANCO', 'NOMBAN', edtNomeBanco.Text);

  If FileExists(ExtractFilePath(Application.ExeName) + '\autban\opcoes.ini') Then
  Begin
    fArqIniGeral(1, 'BANCO', 'NUMIP', mskNroIp.Text, ExtractFilePath(Application.ExeName) + '\autban\');
    fArqIniGeral(1, 'BANCO', 'NOMBAN', edtNomeBanco.Text, ExtractFilePath(Application.ExeName) + '\autban\');
  End;

  If FileExists(ExtractFilePath(Application.ExeName) + '\auttin\opcoes.ini') Then
  Begin
    fArqIniGeral(1, 'BANCO', 'NUMIP', mskNroIp.Text, ExtractFilePath(Application.ExeName) + '\auttin\');
    fArqIniGeral(1, 'BANCO', 'NOMBAN', edtNomeBanco.Text, ExtractFilePath(Application.ExeName) + '\auttin\');
  End;
end;

procedure TfrmCfgBancoDados.btnGravarClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) And (fMensagem('', 'Confirma alterações?', ['&Sim', '&Não']) = 1) Then
  Begin
    pGravaArqIni;
    Close;
    ModalResult := mrOk;
  End;
end;

procedure TfrmCfgBancoDados.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaArqIni;
end;

initialization
  RegisterClass(TfrmCfgBancoDados);
finalization
  UnRegisterClass(TfrmCfgBancoDados);

end.

