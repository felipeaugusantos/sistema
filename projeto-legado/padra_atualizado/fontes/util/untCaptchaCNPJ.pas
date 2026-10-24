{**************************************}
{* Obtém o captcha para consultar o   *}
{* CNPJ no portal da Receita Federal. *}
{* Adaptado do projeto ACBr           *}
{* https://projetoacbr.com.br         *}
{**************************************}

unit untCaptchaCNPJ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, EditFocus, Mask, MaskEditFocus, untFuncoesSimples, untConsultaCNPJ, 
  untInterfaces, frxClass, frxExportCSVTestabilidade;

type
  TfrmCaptchaCNPJ = class(TfrmPai)
    Label1: TLabel;
    mskCnpj: TMaskEditFocus;
    Label2: TLabel;
    edtCaptcha: TEditFocus;
    btnConfirma: TBitBtnLocked;
    pnlCaptcha: TPanel;
    lblAtualiza: TLabel;
    imgCaptcha: TImage;
    procedure btnConfirmaClick(Sender: TObject);
    procedure lblAtualizaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    objConsulta: TConsultaCnpjReceitaFederal;
  public
    { Public declarations }
    objRetorno: TRetornoConsultaCadastro;
  end;

implementation

{$R *.dfm}

procedure TfrmCaptchaCNPJ.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If Trim(edtCaptcha.Text) = '' Then
  Begin
    pMensagemOk('Informe o captcha!');
    pSetFocus(edtCaptcha);
    Exit;
  End;

  Try
    objRetorno := objConsulta.fConsultaCadastro(mskCnpj.Text, edtCaptcha.Text);

    ModalResult := mrOk;
  Except
    On E: ErroConsultaCadastro Do
      pMensagemOk(E.Message);

    On E: Exception Do
      pMensagensErro(E.Message, 'TfrmCaptchaCNPJ.btnConfirmaClick');
  End;
end;

procedure TfrmCaptchaCNPJ.FormCreate(Sender: TObject);
begin
  inherited;
  objConsulta := TConsultaCnpjReceitaFederal.Create;
end;

procedure TfrmCaptchaCNPJ.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objConsulta);
end;

procedure TfrmCaptchaCNPJ.FormShow(Sender: TObject);
begin
  inherited;
  lblAtualizaClick(Sender);
end;

procedure TfrmCaptchaCNPJ.lblAtualizaClick(Sender: TObject);
  Var
    strArquivo: String;
begin
  inherited;
  edtCaptcha.Clear;
  pSetFocus(edtCaptcha);

  Try
    If objConsulta.fObtemCaptcha Then
    Begin
      strArquivo := fRetTemporaryDir + TMP_CAPTCHA;
      If FileExists(strArquivo) Then
        imgCaptcha.Picture.LoadFromFile(strArquivo);
    End
    Else
      pMensagemOk('Não foi possível obter a imagem, por favor tente novamente.');
  Except
    On E: ErroConsultaCadastro Do
      pMensagemOk(E.Message);

    On E: Exception Do
      pMensagensErro(E.Message, 'TfrmCaptchaCNPJ.lblAtualizaClick');
  End;
end;

end.
