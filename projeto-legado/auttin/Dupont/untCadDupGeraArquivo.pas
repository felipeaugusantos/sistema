unit untCadDupGeraArquivo;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons,
  ExtCtrls, AppEvnts, BitBtnLockedIncrem;

type
  TfrmCadDupGeraArquivo = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    pnlProgresso: TPanel;
    pnlCentral: TPanel;
    pnlProgInterno: TPanel;
    tmrProgresso: TTimer;
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    rdgGerBas: TRadioButton;
    rdgGerFor: TRadioButton;
    btnConfirmaGeracao: TBitBtnLocked;
    btnSairGeracao: TBitBtnLocked;
    procedure btnSairGeracaoClick(Sender: TObject);
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
  frmCadDupGeraArquivo: TfrmCadDupGeraArquivo;

implementation

uses untPai, untDupont, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadDupGeraArquivo.btnSairGeracaoClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCadDupGeraArquivo.tmrProgressoTimer(Sender: TObject);
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

procedure TfrmCadDupGeraArquivo.FormCreate(Sender: TObject);
begin
  inherited;
  strDirecao := 'D';
end;

procedure TfrmCadDupGeraArquivo.btnConfirmaGeracaoClick(Sender: TObject);
begin
  inherited;
  If (fMensagem('', 'Confirma geração do arquivo?', ['&Sim', '&Não']) = 1) Then
  Begin
    pnlInfo.Caption := 'Gerando arquivo (DUPONT), aguarde...';
    Application.ProcessMessages;
    btnConfirmaGeracao.Enabled := False;
    btnSairGeracao.Enabled     := False;

    tmrProgresso.Enabled := True;
    If (fDupontGeraArquivo(rdgGerBas.Checked)) Then
      fMensagem('', 'Arquivo gerado com sucesso!', ['&O k']);

    tmrProgresso.Enabled := False;

    pnlInfo.Caption := '';
    Close;
  End;
end;

end.
