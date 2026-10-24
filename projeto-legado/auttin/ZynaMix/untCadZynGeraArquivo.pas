unit untCadZynGeraArquivo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, AppEvnts, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmCadZynGeraArquivo = class(TfrmPai)
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    tmrProgresso: TTimer;
    pnlProgresso: TPanel;
    pnlCentral: TPanel;
    pnlProgInterno: TPanel;
    btnConfirmaGeracao: TBitBtnLocked;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
    procedure tmrProgressoTimer(Sender: TObject);
  private
    { Private declarations }
    strDirecao: String;
  public
    { Public declarations }
  end;

var
  frmCadZynGeraArquivo: TfrmCadZynGeraArquivo;

implementation

uses untZynamix,   untIConfTinta,
     untFuncTinta, untFuncoesSimples, untZynamixDinamica;

{$R *.dfm}

procedure TfrmCadZynGeraArquivo.btnConfirmaGeracaoClick(Sender: TObject);
Var
  conf: IConfTinta;
begin
  inherited;
  If (fMensagem('', 'Confirma geração do arquivo?', ['&Sim', '&Não']) = 1) Then
  Begin
    conf            := fGetConfTinta('ZYN');
    pnlInfo.Caption := 'Gerando arquivo (Zynamix), aguarde...';
    Application.ProcessMessages;
    btnConfirmaGeracao.Enabled := False;
    btnSair.Enabled            := False;

    tmrProgresso.Enabled := True;

    If (fZynamixGeraArquivoDinamica) Then
      fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok']);

    tmrProgresso.Enabled := False;

    btnSair.Enabled := True;

    pnlInfo.Caption := '';
    Close;
  End;
end;

procedure TfrmCadZynGeraArquivo.tmrProgressoTimer(Sender: TObject);
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

end.
