unit untLibCartoesMensagem;

interface

uses WinApi.Windows, WinApi.Messages, System.SysUtils, System.Variants,
     System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.ExtCtrls,
     Vcl.StdCtrls, Vcl.Buttons, Vcl.Menus, Vcl.ClipBrd, System.ImageList,
     Vcl.ImgList,

     BitBtnLockedIncrem, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
     cxButtons, cxImageList;

type
  TfrmMensagem = class(TForm)
    pnlPrincipal: TPanel;
    pnlMensagem: TPanel;
    pblTitulo: TPanel;
    pnlBotoes: TPanel;
    imgbotao1: TImage;
    imgbotao2: TImage;
    imgbotao3: TImage;
    lblTitulo: TLabel;
    lblMensagem: TLabel;
    popAreaTransf: TPopupMenu;
    Enviarparareadetransferncia1: TMenuItem;
    btnHlpPro: TBitBtnLocked;
    ImageList: TcxImageList;
    imgBotao4: TImage;
    procedure FormCreate(Sender: TObject);
    procedure pOnClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Enviarparareadetransferncia1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }

    procedure pCentralizarForm(AForm: TForm);
  public
    { Public declarations }
    intRetorno   : Integer;
    intFocus     : Integer;
    blnSaiComEsc : Boolean;
    intSomaTop   : Integer;
    blnObrigaEsc : Boolean;
    blnOcultPainelBtn: Boolean;
  end;

implementation

uses untTLibCartoesFuncoes;

{$R *.dfm}

procedure TfrmMensagem.FormActivate(Sender: TObject);
  Var
    intPosicao: Integer;
begin
  {*****************************************}
  {* COPIADO DO FORMSHOW POIS O PSETFOCUS  *}
  {* EM ALGUNS CASOS EM QUE ALGUMA         *}
  {* CONFIGURAÇÃO SETAVA O FOCO NO SEGUNDO *}
  {* BOTÃO NÃO ESTAVA SENDO RESPEITADO POR *}
  {* CAUSA DO Screen.ActiveForm            *}
  {**************************************JU*}

  For intPosicao := 0 To Self.ComponentCount - 1 Do
  Begin
    If ( Self.Components[intPosicao] Is TBitBtnLocked )      And
       ( Self.Components[intPosicao].Tag = intFocus )  Then
      TLibCartoesFuncoes.pSetFocus(( Self.Components[intPosicao] As TBitBtnLocked ));
  End;

  Top := Top + intSomaTop;

  SetForegroundWindow(Self.Handle);
end;

procedure TfrmMensagem.FormCreate(Sender: TObject);
begin
  If Not VS_FuncoesExternas.fIExecutandoModoClassico Then
  Begin
    If Screen.MonitorCount > 1 Then
      Self.Position := poDesigned;
  End;

  intRetorno := 0;

  If Not Assigned(TLibCartoesFuncoes.FIconeAplicacao) Then
    Self.Icon.LoadFromStream(VS_FuncoesExternas.fIGetIconApplication)
  Else
    Self.Icon.Assign(TLibCartoesFuncoes.FIconeAplicacao);
end;

procedure TfrmMensagem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_Escape) And (blnSaiComEsc) Then
  Begin
    intRetorno := 0;
    Close;
  End;
end;

procedure TfrmMensagem.pCentralizarForm(AForm: TForm);
  Var
    LMonitor: TMonitor;
Begin
  LMonitor   := TMonitor(Screen.MonitorFromWindow(Application.Handle));
  AForm.Left := LMonitor.Left + Round(LMonitor.WorkareaRect.Width / 2) - Round(AForm.Width / 2);
  AForm.Top  := Round(LMonitor.WorkareaRect.Height / 2) - Round(AForm.Height / 2);
End;

procedure TfrmMensagem.pOnClick(Sender: TObject);
begin
  intRetorno := (Sender As TBitBtnLocked).Tag;

  if( blnObrigaEsc = False ) then
    Close;
end;

procedure TfrmMensagem.FormShow(Sender: TObject);
  Var
    intPosicao: Integer;
begin
  For intPosicao := 0 To Self.ComponentCount - 1 Do
  Begin
    If ( Self.Components[intPosicao] Is TBitBtnLocked )      And
       ( Self.Components[intPosicao].Tag = intFocus )  Then
      TLibCartoesFuncoes.pSetFocus(( Self.Components[intPosicao] As TBitBtnLocked ));
  End;

  If Not VS_FuncoesExternas.fIExecutandoModoClassico Then
  Begin
    If Screen.MonitorCount > 1 Then
      pCentralizarForm(Self);
  End;
  
  SetForegroundWindow(Self.Handle);

  if ( blnOcultPainelBtn ) then
    pnlBotoes.Visible := False;

  btnHlpPro.Visible := False;
end;

procedure TfrmMensagem.Enviarparareadetransferncia1Click(Sender: TObject);
begin
  Clipboard.AsText := lblTitulo.Caption + #13#10 + lblMensagem.Caption;
end;

end.
