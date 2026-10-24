unit untCadSalGeraArquivo;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons,
  ExtCtrls, AppEvnts,  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadSalGeraArquivo = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    pnlProgresso: TPanel;
    pnlCentral: TPanel;
    pnlProgInterno: TPanel;
    tmrProgresso: TTimer;
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    rdbBases: TRadioButton;
    rdbCores: TRadioButton;
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
  frmCadSalGeraArquivo: TfrmCadSalGeraArquivo;

implementation

uses  untPai, untSalcomix, untFuncoesSimples,
     untIConfTinta, untFuncTinta,untSalcomixDinamica;

{$R *.dfm}

procedure TfrmCadSalGeraArquivo.btnSairGeracaoClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCadSalGeraArquivo.tmrProgressoTimer(Sender: TObject);
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

procedure TfrmCadSalGeraArquivo.FormCreate(Sender: TObject);
begin
  inherited;
  strDirecao := 'D';
end;

procedure TfrmCadSalGeraArquivo.btnConfirmaGeracaoClick(Sender: TObject);
Var
  conf: IConfTinta;
begin
  inherited;
  conf := fGetConfTinta('SAL');
  If (fMensagem('', 'Confirma geração do arquivo?', ['&Sim', '&Não']) = 1) Then
  Begin
    pnlInfo.Caption := 'Gerando arquivo (SALCOMIX), aguarde...';
    Application.ProcessMessages;
    btnConfirmaGeracao.Enabled := False;
    btnSairGeracao.Enabled     := False;

    tmrProgresso.Enabled := True;

    If rdbCores.Checked Then
    Begin
      If (fSalcomixGeraArquivoDinamica) Then
        fMensagem('', 'Arquivo gerado com sucesso!', ['&O k']);
    End
    Else
    Begin
      If (fSalcomixGeraBases) Then
        fMensagem('', 'Bases geradas com sucesso!', ['&O k']);
    End;

    tmrProgresso.Enabled := False;

    pnlInfo.Caption := '';
    Close;
  End;
end;

end.
