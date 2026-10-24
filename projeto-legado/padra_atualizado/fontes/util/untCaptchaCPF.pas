unit untCaptchaCPF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, EditFocus, Mask, MaskEditFocus, untFuncoesSimples, untConsultaCPF,
  untInterfaces, frxClass, frxExportCSVTestabilidade;

type
  TfrmCaptchaCPF = class(TfrmPai)
    Label1: TLabel;
    mskCpf: TMaskEditFocus;
    Label2: TLabel;
    edtCaptcha: TEditFocus;
    btnConfirma: TBitBtnLocked;
    pnlCaptcha: TPanel;
    lblAtualiza: TLabel;
    imgCaptcha: TImage;
    mskDataNasc: TMaskEditFocus;
    Label3: TLabel;
    procedure btnConfirmaClick(Sender: TObject);
    procedure lblAtualizaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    objConsulta: TConsultaCpfReceitaFederal;
  public
    { Public declarations }
    objRetorno: TRetornoConsultaCadastro;
  end;

implementation

{$R *.dfm}

procedure TfrmCaptchaCPF.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If Trim(edtCaptcha.Text) = '' Then
  Begin
    pMensagemOk('Informe o captcha!');
    pSetFocus(edtCaptcha);
    Exit;
  End;

  Try
    objRetorno := objConsulta.fConsultaCadastro(mskCpf.Text, mskDataNasc.Text, edtCaptcha.Text);

    ModalResult := mrOk;
  Except
    On E: ErroConsultaCadastro Do
      pMensagemOk(E.Message);

    On E: Exception Do
      pMensagensErro(E.Message, 'TfrmCaptchaCPF.btnConfirmaClick');
  End;
end;

procedure TfrmCaptchaCPF.FormCreate(Sender: TObject);
begin
  inherited;
  objConsulta := TConsultaCpfReceitaFederal.Create;
end;

procedure TfrmCaptchaCPF.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objConsulta);
end;

procedure TfrmCaptchaCPF.FormShow(Sender: TObject);
begin
  inherited;
  lblAtualizaClick(Sender);
end;

procedure TfrmCaptchaCPF.lblAtualizaClick(Sender: TObject);
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
      pMensagensErro(E.Message, 'TfrmCaptchaCPF.lblAtualizaClick');
  End;
end;

end.
