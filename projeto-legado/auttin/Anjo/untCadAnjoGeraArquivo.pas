unit untCadAnjoGeraArquivo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadAnjoGeraArquivo = class(TfrmPai)
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;           
    pnlProgresso: TPanel;
    pnlCentral: TPanel;
    pnlProgInterno: TPanel;
    rgbBasesTintas: TRadioGroup;
    tmrProgresso: TTimer;
    btnConfirmaGeracao: TBitBtnLocked;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
    procedure tmrProgressoTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
  private
    { Private declarations }
    strDirecao: String;
  public
    { Public declarations }
  end;

var
  frmCadAnjoGeraArquivo: TfrmCadAnjoGeraArquivo;

implementation

uses untFuncoesSimples , untAnjoDinamica;

{$R *.dfm}

procedure TfrmCadAnjoGeraArquivo.ApplicationEventsMessage(var Msg: tagMSG;
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

procedure TfrmCadAnjoGeraArquivo.btnConfirmaGeracaoClick(Sender: TObject);
Var
    blnGerBas     : Boolean;
    blnGerBasCol  : Boolean;
    Luks  	      : TAnjoDinamica;
begin
  inherited;
  blnGerBas := False;
  If (fMensagem('', 'Confirma geração do arquivo?', ['&Sim', '&Não']) = 1) Then
  Begin
    blnGerBasCol := rgbBasesTintas.ItemIndex = 0;

    If blnGerBasCol Then
      blnGerBas := (fMensagem('', 'Gerar bases?', ['&Sim', '&Não']) = 1);

    pnlInfo.Caption := 'Gerando arquivo (ANJO), aguarde...';
    Application.ProcessMessages;
    btnConfirmaGeracao.Enabled := False;
    btnSair.Enabled            := False;

    tmrProgresso.Enabled := True;

    Luks := TAnjoDinamica.Create(Nil);

    If Luks.fProcessarArquivos(blnGerBas, blnGerBasCol, pnlInfo) Then
      fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok'])
    Else
      fMensagem('', 'Não foi possivel gerar o arquivo', ['&OK']);

    tmrProgresso.Enabled := False;
    Luks.Destroy;
    pnlInfo.Caption := '';
    Close;
  End;
end;

procedure TfrmCadAnjoGeraArquivo.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(rgbBasesTintas.Buttons[1]);
  rgbBasesTintas.ItemIndex := 1;
end;

procedure TfrmCadAnjoGeraArquivo.tmrProgressoTimer(Sender: TObject);
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
  End
end;

end.

