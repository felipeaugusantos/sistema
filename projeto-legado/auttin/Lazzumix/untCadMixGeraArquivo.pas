unit untCadMixGeraArquivo;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons,
  ExtCtrls, AppEvnts,  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadMixGeraArquivo = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    pnlProgresso: TPanel;
    pnlCentral: TPanel;
    pnlProgInterno: TPanel;
    tmrProgresso: TTimer;
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    rdgOpcoes: TRadioGroup;
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
  frmCadMixGeraArquivo: TfrmCadMixGeraArquivo;

implementation

uses untPai, untLazzumixAutomotiva, untLazzumixAutomotivaDOS,
     untIConfTinta, untFuncoesSimples, untLazzumixAutomotivaDinamica, untFuncTinta;

{$R *.dfm}

procedure TfrmCadMixGeraArquivo.btnSairGeracaoClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCadMixGeraArquivo.tmrProgressoTimer(Sender: TObject);
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

procedure TfrmCadMixGeraArquivo.FormCreate(Sender: TObject);
begin
  inherited;
  strDirecao := 'D';
end;

procedure TfrmCadMixGeraArquivo.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    blnResult: Boolean;
    conf: IConfTinta;
begin
  inherited;
  If (fMensagem('', 'Confirma geração do arquivo?', ['&Sim', '&Não']) = 1) Then
  Begin
    conf := fGetConfTinta('LAZ');
    pnlInfo.Caption := 'Gerando arquivo (LAZZUMIX), aguarde...';
    Application.ProcessMessages;
    btnConfirmaGeracao.Enabled := False;
    btnSairGeracao.Enabled     := False;

    tmrProgresso.Enabled := True;

    If (conf.fGet('LAZ_SO') = 'W') Then
    Begin
      blnResult := fLazzumixGeraArquivoDinamica(rdgOpcoes.ItemIndex);
    End
    Else
    Begin
      blnResult := fLazzumixGeraArquivoDinamica(rdgOpcoes.ItemIndex);
    End;
    tmrProgresso.Enabled := False;

    If blnResult Then
      fMensagem('', 'Arquivo gerado com sucesso!', ['&O k']);

    pnlInfo.Caption := '';
    Close;
  End;
end;

end.
