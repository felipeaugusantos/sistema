unit untMensagemExplicativa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ComCtrls;

type
  TAcaoBotao = procedure(strParam: String) of object;
  TfrmMensagemExplicativa = class(TfrmPai)
    mmoInstru: TMemo;
    RitchObservacao: TRichEdit;
    btnAuxiliar: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pMostrarBotaoAuxiliar(strCaption: String);
    procedure btnAuxiliarClick(Sender: TObject);
  private
    FstrParam: String;
    FprcAcaoBtnAux: TAcaoBotao;
    { Private declarations }
  public
    { Public declarations }
    Class Procedure pMensagem(strMensagem: String; intAltura: Integer = 0; intLargura: Integer = 0);
    property strParam: String read FstrParam write FstrParam;
    property prcAcaoBtnAux: TAcaoBotao read FprcAcaoBtnAux write FprcAcaoBtnAux;
  end;

var
  frmMensagemExplicativa: TfrmMensagemExplicativa;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmMensagemExplicativa.btnAuxiliarClick(Sender: TObject);
begin
  inherited;
  prcAcaoBtnAux(strParam);
end;

procedure TfrmMensagemExplicativa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
    Close;
end;

procedure TfrmMensagemExplicativa.pMostrarBotaoAuxiliar(strCaption: String);
begin
  btnAuxiliar.Caption := strCaption;
  btnAuxiliar.Width   := (Length(strCaption)*7)+10;
  btnAuxiliar.Visible := True;
end;

class procedure TfrmMensagemExplicativa.pMensagem(strMensagem: String;
  intAltura, intLargura: Integer);
begin
  pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);

  frmMensagemExplicativa.Caption := 'Aviso';
  frmMensagemExplicativa.pnlStatus.Visible := False;

  If intAltura > 0 Then
    frmMensagemExplicativa.Height := intAltura;

  If intLargura > 0 Then
    frmMensagemExplicativa.Width := intLargura;

  frmMensagemExplicativa.mmoInstru.Text := strMensagem;

  frmMensagemExplicativa.btnSair.Left := (frmMensagemExplicativa.ClientWidth - frmMensagemExplicativa.btnSair.Width) Div 2;

  frmMensagemExplicativa.ShowModal;
  FreeAndNil(frmMensagemExplicativa);
end;

end.
