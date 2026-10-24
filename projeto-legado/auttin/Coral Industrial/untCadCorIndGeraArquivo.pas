unit untCadCorIndGeraArquivo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, AppEvnts,
  BitBtnLockedIncrem;

type
  TfrmCadCorIndGeraArquivo = class(TfrmPai)
    pnlCabecalho: TPanel;
    pnlTopo: TPanel;
    pnlProgresso: TPanel;
    pnlCentral: TPanel;
    pnlProgInterno: TPanel;
    tmrProgresso: TTimer;
    btnConfirmaGeracao: TBitBtnLocked;
    procedure tmrProgressoTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
    strDirecao: String;
  public
    { Public declarations }
  end;

var
  frmCadCorIndGeraArquivo: TfrmCadCorIndGeraArquivo;

implementation

uses  untCoralIndustrial, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadCorIndGeraArquivo.tmrProgressoTimer(Sender: TObject);
begin
  inherited;
  If strDirecao = 'D' Then
  Begin

    pnlProgInterno.Left := pnlProgInterno.Left + 5;

    If pnlProgInterno.Left + pnlProgInterno.Width >= pnlCentral.Width Then
      strDirecao := 'E';

  End
  Else
  Begin
    pnlProgInterno.Left := pnlProgInterno.Left - 5;

    If pnlProgInterno.Left <= 0 Then
      strDirecao := 'D';
  End;
end;

procedure TfrmCadCorIndGeraArquivo.FormCreate(Sender: TObject);
begin
  inherited;
  strDirecao := 'E';
end;

procedure TfrmCadCorIndGeraArquivo.btnConfirmaGeracaoClick(
  Sender: TObject);
  Var
    blnGeraBase: Boolean;
begin
  inherited;
  If (fMensagem('', 'Confirma geração do arquivo?', ['&Sim', '&Não']) = 1) Then
  Begin

    blnGeraBase := (fMensagem('', 'Gera cadastro de bases?', ['&Sim', '&Não']) = 1);

    pnlInfo.Caption := 'Gerando arquivo (CORAL INDUSTRIAL), aguarde...';
    Application.ProcessMessages;
    btnConfirmaGeracao.Enabled := False;
    btnSair.Enabled            := False;

    tmrProgresso.Enabled := True;

    If (fCoralIndustrialGeraArquivo(blnGeraBase)) Then
      fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok']);

    Close;

    tmrProgresso.Enabled := False;

    pnlInfo.Caption := '';

  End;
end;

end.
