unit untCadSheGeraArquivo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, AppEvnts,
  BitBtnLockedIncrem;

type
  TfrmCadSheGeraArquivo = class(TfrmPai)
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    tmrProgresso: TTimer;
    pnlProgresso: TPanel;
    pnlCentral: TPanel;
    pnlProgInterno: TPanel;
    rgbBasesTintas: TRadioGroup;
    btnConfirmaGeracao: TBitBtnLocked;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
    procedure tmrProgressoTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG;
      var Handled: Boolean);
  private
    { Private declarations }
    strDirecao: String;
  public
    { Public declarations }
  end;

var
  frmCadSheGeraArquivo: TfrmCadSheGeraArquivo;

implementation

uses untFuncoesSimples,
     untSherwinWhilliamsImobiliaria;

{$R *.dfm}

procedure TfrmCadSheGeraArquivo.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    blnGerBas     : Boolean;
    blnGerBasCol  : Boolean;
    SherWin       : TSherwinWhilliams;
begin
  inherited;
  blnGerBas := False;
  If (fMensagem('', 'Confirma geração do arquivo?', ['&Sim', '&Não']) = 1) Then
  Begin
    blnGerBasCol := rgbBasesTintas.ItemIndex = 0;

    If blnGerBasCol Then
      blnGerBas := (fMensagem('', 'Gerar bases?', ['&Sim', '&Não']) = 1);

    pnlInfo.Caption := 'Gerando arquivo (SHERWIN WILLIAMS), aguarde...';
    Application.ProcessMessages;
    btnConfirmaGeracao.Enabled := False;
    btnSair.Enabled            := False;

    tmrProgresso.Enabled := True;

    SherWin := TSherwinWhilliams.Create;
    If SherWin.fProcessarArquivos(blnGerBas, blnGerBasCol, pnlInfo) Then
      fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok'])
    Else
      fMensagem('', 'Não foi possivel gerar o arquivo', ['&OK']);

    tmrProgresso.Enabled := False;
    SherWin.Destroy;
    pnlInfo.Caption := '';
    Close;
  End;
end;

procedure TfrmCadSheGeraArquivo.tmrProgressoTimer(Sender: TObject);
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

procedure TfrmCadSheGeraArquivo.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(rgbBasesTintas.Buttons[1]);
  rgbBasesTintas.ItemIndex := 1;
end;

procedure TfrmCadSheGeraArquivo.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  inherited;
  If rgbBasesTintas.ContainsControl(FindControl(Msg.hwnd)) Then
  begin
    If Msg.message = WM_KEYFIRST Then
    begin
      If Msg.wParam = 13 Then
        btnConfirmaGeracao.Click;
      If Msg.wParam = 27 Then
        btnSair.Click;
    end;
  end;
end;

end.

