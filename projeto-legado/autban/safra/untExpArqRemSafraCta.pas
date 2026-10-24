unit untExpArqRemSafraCta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.Mask,
  DirectoryEditFocus, Vcl.StdCtrls, EditFocus, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ExtCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untFuncoesBco422, untFuncoesSimples, untFuncoes,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemSafraCta = class(TfrmPai)
    pnlFundo: TPanel;
    lblPathRem: TLabel;
    lblNomArq: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    btnGerar: TBitBtnLocked;
    fraPathRemessa: TfraDirectoryEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
  private
    { Private declarations }
    FstrConfig: String;
  public
    { Public declarations }
    strNomForm : String;

    property strConfig: String read FstrConfig write FstrConfig;
  end;

var
  frmExpArqRemSafraCta: TfrmExpArqRemSafraCta;

implementation

{$R *.dfm}

procedure TfrmExpArqRemSafraCta.btnGerarClick(Sender: TObject);
Var objBco422: TFuncoesBco422;
begin
  inherited;
  If fEmptyStr(fTiraCaracEspeciais(fraPathRemessa.edtDirectory.text)) Then
  Begin
    fMensagem('Path:', 'Diretório p/ geração do arquivo de remessa deve ser informado!', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

  If (Not DirectoryExists(fraPathRemessa.edtDirectory.text)) Or (fraPathRemessa.edtDirectory.text = '\') Then
  Begin
    fMensagem('Path:', 'Diretório inválido p/ geração do arquivo de remessa!', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  If fMensagem('','Confirma a geração do arquivo de remessa?',['&Sim','&Não']) = 2 Then
    Exit;

  Try
    objBco422 := TFuncoesBco422.Create;
    objBco422.fExpArqRemCta(FstrConfig, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
  Finally
    If Assigned(objBco422) Then
      FreeAndNil(objBco422);
  End;
end;

procedure TfrmExpArqRemSafraCta.FormShow(Sender: TObject);
begin
  inherited;
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, FstrConfig , 'PATHREM',''));
  edtNomArquivo.Text  := 'RM' +
                         fStrZero(fGetBancoProxNum(FstrConfig), 06) +
                         '.TXT';
  pSetFocus(fraPathRemessa);

  pnlNomeForm.Caption := strNomForm;
end;

end.
