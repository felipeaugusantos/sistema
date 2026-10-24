unit untCadSuvGeraArquivo;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons,
  ExtCtrls, AppEvnts, BitBtnLockedIncrem;

type
  TfrmCadSuvGeraArquivo = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    pnlProgresso: TPanel;
    pnlCentral: TPanel;
    pnlProgInterno: TPanel;
    tmrProgresso: TTimer;
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
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
  frmCadSuvGeraArquivo: TfrmCadSuvGeraArquivo;

implementation

uses untSuvinilImobiliaria,  untPai, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadSuvGeraArquivo.btnSairGeracaoClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCadSuvGeraArquivo.tmrProgressoTimer(Sender: TObject);
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

procedure TfrmCadSuvGeraArquivo.FormCreate(Sender: TObject);
begin
  inherited;
  strDirecao := 'D';
end;

procedure TfrmCadSuvGeraArquivo.btnConfirmaGeracaoClick(Sender: TObject);
begin
  inherited;
  If (fMensagem('', 'Confirma geração do arquivo?', ['&Sim', '&Não']) = 1) Then
  Begin
    pnlInfo.Caption := 'Gerando arquivo (SUVINIL), aguarde...';
    Application.ProcessMessages;
    btnConfirmaGeracao.Enabled := False;
    btnSairGeracao.Enabled     := False;

    tmrProgresso.Enabled := True;
    If (fSuvinilGeraArquivo) Then
      fMensagem('', 'Arquivo gerado com sucesso!', ['&O k']);

    tmrProgresso.Enabled := False;

    pnlInfo.Caption := '';
    Close;
  End;
end;

end.
