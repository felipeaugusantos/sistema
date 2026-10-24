unit untMensagem;

interface

uses
  {Libc}Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons,  Menus {Qt}, ClipBrd,
  BitBtnLockedIncrem, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  cxButtons, untTypesDLLCartao, cxImageList, System.ImageList, Vcl.ImgList,
  untTelasAbertas, untIIntegracaoCartoes;

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
    procedure btnHlpProClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FTelas: ITelasAbertas;
    procedure pEmpilharTelaAberta;
    procedure pRemoverTelaAberta;
  public
    { Public declarations }
    intRetorno   : Integer;
    intFocus     : Integer;
    blnSaiComEsc : Boolean;
    intSomaTop   : Integer;
    blnObrigaEsc : Boolean;
    blnOcultPainelBtn: Boolean;
    pProcedureAjuda: TProcedureAjuda;
  end;

var
  frmMensagem: TfrmMensagem;

implementation

uses untFuncoesSimples;

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
      pSetFocus(( Self.Components[intPosicao] As TBitBtnLocked ));
  End;

  Top := Top + intSomaTop;

  SetForegroundWindow(Self.Handle);
end;

procedure TfrmMensagem.FormCreate(Sender: TObject);
begin
  intRetorno := 0;
  pProcedureAjuda := nil;
  pEmpilharTelaAberta;
end;

procedure TfrmMensagem.FormDestroy(Sender: TObject);
begin
  pRemoverTelaAberta;
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

procedure TfrmMensagem.pEmpilharTelaAberta;
begin
  FTelas := untTelasAbertas.objTelasAbertas;

  If Assigned(FTelas) Then
    FTelas.AddFormAndSetPopupMode(Self);
end;

procedure TfrmMensagem.pOnClick(Sender: TObject);
begin
  intRetorno := (Sender As TBitBtnLocked).Tag;

  if( blnObrigaEsc = False ) then
    Close;
end;

procedure TfrmMensagem.pRemoverTelaAberta;
begin
  If Assigned(FTelas) Then
    FTelas.RemoveFormParent(Self);
end;

procedure TfrmMensagem.FormShow(Sender: TObject);
  Var
    intPosicao: Integer;
begin

  For intPosicao := 0 To Self.ComponentCount - 1 Do
  Begin
    If ( Self.Components[intPosicao] Is TBitBtnLocked )      And
       ( Self.Components[intPosicao].Tag = intFocus )  Then
      pSetFocus(( Self.Components[intPosicao] As TBitBtnLocked ));
  End;
  
  SetForegroundWindow(Self.Handle);

  if ( blnOcultPainelBtn ) then
    pnlBotoes.Visible := False;

  btnHlpPro.Visible := Assigned(pProcedureAjuda);
end;

procedure TfrmMensagem.btnHlpProClick(Sender: TObject);
begin
  if Assigned(pProcedureAjuda) then
    pProcedureAjuda;
end;

procedure TfrmMensagem.Enviarparareadetransferncia1Click(Sender: TObject);
begin
  Clipboard.AsText := lblTitulo.Caption + #13#10 + lblMensagem.Caption;
end;

end.
