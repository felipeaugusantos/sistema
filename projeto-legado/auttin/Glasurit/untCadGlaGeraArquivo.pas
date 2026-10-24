unit untCadGlaGeraArquivo;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons,
  ExtCtrls, AppEvnts, untIConfTinta, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadGlaGeraArquivo = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    pnlProgresso: TPanel;
    pnlCentral: TPanel;
    pnlProgInterno: TPanel;
    tmrProgresso: TTimer;
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    rdbGerarBases: TRadioButton;
    rdbGerarCores: TRadioButton;
    btnConfirmaGeracao: TBitBtnLocked;
    btnSairGeracao: TBitBtnLocked;
    procedure btnSairGeracaoClick(Sender: TObject);
    procedure tmrProgressoTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
    strDirecao: String;
    conf: IConfTinta;
  public
    { Public declarations }
  end;

var
  frmCadGlaGeraArquivo: TfrmCadGlaGeraArquivo;

implementation

uses  untPai, untGlasurit, untFuncoesSimples,
      untFuncTinta, untGlasuritDinamica;

{$R *.dfm}

procedure TfrmCadGlaGeraArquivo.btnSairGeracaoClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCadGlaGeraArquivo.tmrProgressoTimer(Sender: TObject);
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

procedure TfrmCadGlaGeraArquivo.FormCreate(Sender: TObject);
begin
  inherited;
  strDirecao := 'D';
  conf       := fGetConfTinta('GLA');

  If (conf.fGet('CALFOR') = '0') Then
  Begin
    rdbGerarBases.Visible := False;
    rdbGerarCores.Visible := False;
    rdbGerarCores.Checked := True;
  End;
end;

procedure TfrmCadGlaGeraArquivo.btnConfirmaGeracaoClick(Sender: TObject);
begin
  inherited;
  If (fMensagem('', 'Confirma geração do arquivo?', ['&Sim', '&Não']) = 1) Then
  Begin
    pnlInfo.Caption := 'Gerando arquivo (GLASURIT), aguarde...';
    Application.ProcessMessages;
    btnConfirmaGeracao.Enabled := False;
    btnSairGeracao.Enabled     := False;

    tmrProgresso.Enabled := True;

    If (rdbGerarCores.Checked) Then
    Begin
      If (fGlasuritGeraArquivoDinamica) Then
        fMensagem('', 'Arquivo gerado com sucesso!', ['&O k']);
    End
    Else
    Begin
      If (fGlasuritGeraBases) Then
        fMensagem('', 'Bases geradas com sucesso!', ['&O k']);
    End;

    tmrProgresso.Enabled := False;

    pnlInfo.Caption := '';
    Close;
  End;
end;

end.
