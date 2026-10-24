unit untCadLkdGeraArquivo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadLkdGeraArquivo = class(TfrmPai)
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
  frmCadLkdGeraArquivo: TfrmCadLkdGeraArquivo;

implementation

uses untFuncoesSimples,
     untLukscolorImobiliaria;

{$R *.dfm}

procedure TfrmCadLkdGeraArquivo.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    blnGerBas     : Boolean;
    blnGerBasCol  : Boolean;
    Luks	      : TLukscolor;
begin
  inherited;
  blnGerBas := False;
  If (fMensagem('', 'Confirma geração do arquivo?', ['&Sim', '&Não']) = 1) Then
  Begin
    blnGerBasCol := rgbBasesTintas.ItemIndex = 0;

    If blnGerBasCol Then
      blnGerBas := (fMensagem('', 'Gerar bases?', ['&Sim', '&Não']) = 1);

    pnlInfo.Caption := 'Gerando arquivo (LUKSCOLOR), aguarde...';
    Application.ProcessMessages;
    btnConfirmaGeracao.Enabled := False;
    btnSair.Enabled            := False;

    tmrProgresso.Enabled := True;

    Luks := TLukscolor.Create;
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

procedure TfrmCadLkdGeraArquivo.tmrProgressoTimer(Sender: TObject);
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

procedure TfrmCadLkdGeraArquivo.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(rgbBasesTintas.Buttons[1]);
  rgbBasesTintas.ItemIndex := 1;
end;

procedure TfrmCadLkdGeraArquivo.ApplicationEventsMessage(var Msg: tagMSG;
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

