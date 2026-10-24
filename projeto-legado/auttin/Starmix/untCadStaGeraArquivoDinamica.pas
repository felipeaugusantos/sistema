unit untCadStaGeraArquivoDinamica;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, AppEvnts,
  BitBtnLockedIncrem;

type
  TfrmCadStaGeraArquivoDinamica = class(TfrmPai)
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    pnlProgresso: TPanel;
    pnlCentral: TPanel;
    pnlProgInterno: TPanel;
    tmrProgresso: TTimer;
    rdbGerarBases: TRadioButton;
    rdbGerarForm: TRadioButton;
    btnConfirmaGeracao: TBitBtnLocked;
    procedure btnSairClick(Sender: TObject);
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
  frmCadStaGeraArquivoDinamica: TfrmCadStaGeraArquivoDinamica;

implementation

uses untStarmixDinamica,  untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadStaGeraArquivoDinamica.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCadStaGeraArquivoDinamica.tmrProgressoTimer(Sender: TObject);
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

procedure TfrmCadStaGeraArquivoDinamica.FormCreate(Sender: TObject);
begin
  inherited;
  strDirecao := 'D';
end;

procedure TfrmCadStaGeraArquivoDinamica.btnConfirmaGeracaoClick(Sender: TObject);
begin
  inherited;
  If (fMensagem('', 'Confirma geração do arquivo?', ['&Sim', '&Não']) = 1) Then
  Begin
    pnlInfo.Caption := 'Gerando arquivo (STARMIX), aguarde...';
    Application.ProcessMessages;
    btnConfirmaGeracao.Enabled := False;
    btnSair.Enabled     := False;

    tmrProgresso.Enabled := True;

    If (fStarmixDinamicaGeraArquivo(rdbGerarBases.Checked)) Then
      fMensagem('', 'Arquivo gerado com sucesso!', ['&O k']);

    tmrProgresso.Enabled := False;

    pnlInfo.Caption := '';
    Close;
  End;
end;

end.
