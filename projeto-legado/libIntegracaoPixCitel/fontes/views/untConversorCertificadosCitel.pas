unit untConversorCertificadosCitel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, Vcl.Mask, Vcl.DBCtrls, DBEditFocus,
  cxButtons, EditFocus, untTiposPix;

type
  TfrmConversorCertificadosCitel = class(TForm)
    pnlStatus: TPanel;
    pnlNomeForm: TPanel;
    pnlInfo: TPanel;
    pnlBotoesTrace: TPanel;
    btnIniciarTrace: TSpeedButton;
    btnPausarTrace: TSpeedButton;
    btnSalvarTrace: TSpeedButton;
    btnViewerTrace: TSpeedButton;
    pnlBotoes: TPanel;
    FlwBotoes: TFlowPanel;
    btnConfirma: TBitBtnLocked;
    btnSair: TBitBtnLocked;
    pnlFundo: TPanel;
    pnlCertificadoPFX: TPanel;
    lblCertificadoPfx: TLabel;
    edtArquivoPFX: TEditFocus;
    btnArquivoPFX: TcxButton;
    pnlSenhaCertificado: TPanel;
    lblSenhaCertificado: TLabel;
    lblValidadeCertificado: TLabel;
    lblEmpresaCertificadoLabel: TLabel;
    lblEmpresaCertificado: TLabel;
    lblCNPJCertificadoLabel: TLabel;
    lblCNPJCertificado: TLabel;
    edtSenhaCertificado: TEditFocus;
    lblValidadeCertificadoData: TLabel;
    lblChavesDisponiveisLabel: TLabel;
    lblChavesDisponiveis: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnArquivoPFXClick(Sender: TObject);
  private
    FRespostaJson: String;

    procedure LimpaCampos;

    procedure CarregaDadosCertificadoPFX(const ACaminhoArquivo,
                                               ASenhaArquivo: String);

    function RetornarArquivoBase64(const ACaminhoArquivo: String): String;
    function FormataDataCertificado(ADataHoraJson: String): String;
    function RetornaCNPJFormatado(ACNPJCertificado: String): String;
    { Private declarations }
  public
    property RespostaJson: String read FRespostaJson;
  published
    procedure RealizarConversaoSemTela(AArquivoPfx,
                                       ASenhaArquivo: String);
    { Public declarations }
  end;

implementation
Uses IdCoderMIME, System.Json, untTRequisicoesCitelPix, untTFuncoesAuxiliaresPix;
{$R *.dfm}

procedure TfrmConversorCertificadosCitel.btnArquivoPFXClick(Sender: TObject);
  Var
    LCaixaDialogo: TOpenDialog;
begin
  LCaixaDialogo := TOpenDialog.Create(nil);
  try
    LCaixaDialogo.Title := 'Selecione o arquivo PFX';

    LCaixaDialogo.Options := [ofPathMustExist];

    LCaixaDialogo.Filter := 'Certificado PFX|*.pfx';

    If LCaixaDialogo.Execute Then
    Begin
      edtArquivopfx.Text := LCaixaDialogo.FileName;

      CarregaDadosCertificadoPFX(LCaixaDialogo.FileName,
                                 edtSenhaCertificado.Text);
    End;
  finally
    LCaixaDialogo.Free;
  end;
end;

procedure TfrmConversorCertificadosCitel.btnSairClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  Self.Close;
end;

function TfrmConversorCertificadosCitel.FormataDataCertificado(
  ADataHoraJson: String): String;
begin
  Result := ADataHoraJson;

  If Result.Length < 10 Then
    Exit(EmptyStr);

  Result := Copy(Result, 9, 2) + '/' +
            Copy(Result, 6, 2) + '/' +
            Copy(Result, 1, 4);
end;

procedure TfrmConversorCertificadosCitel.FormCreate(Sender: TObject);
begin
  pnlNomeForm.Caption := Self.Name;
  Self.Icon := Application.Icon;

  LimpaCampos;
end;

procedure TfrmConversorCertificadosCitel.LimpaCampos;
begin
  edtSenhaCertificado.Clear;
  edtArquivoPFX.Clear;

  lblValidadeCertificadoData.Caption := EmptyStr;
  lblEmpresaCertificado.Caption := EmptyStr;
  lblCNPJCertificado.Caption := EmptyStr;
  lblChavesDisponiveis.Caption := EmptyStr;
end;

procedure TfrmConversorCertificadosCitel.CarregaDadosCertificadoPFX(const ACaminhoArquivo,
  ASenhaArquivo: String);
  Var
    LDadosRetorno: String;

    LObjetoCertificado: TJsonObject;
begin
  Try
    LDadosRetorno := TRequisicoesCitelPix.DadosCertificadoPfxWebServiceCitel(RetornarArquivoBase64(ACaminhoArquivo),
                                                                             ASenhaArquivo);

    LObjetoCertificado := TJSONObject.ParseJSONValue(LDadosRetorno) As TJsonObject;

    FRespostaJson := LDadosRetorno;

    If Not TFuncoesPix.RetornaValorCampoJson('codigo', LDadosRetorno).ToLowerInvariant.IsEmpty Then
      Exit;

    lblValidadeCertificadoData.Caption := FormataDataCertificado(TFuncoesPix.RetornaValorJson(LObjetoCertificado, 'dataValidade'));
    lblEmpresaCertificado.Caption := TFuncoesPix.RetornaValorJson(LObjetoCertificado, 'nomeEmpresa');
    lblCNPJCertificado.Caption := RetornaCNPJFormatado(TFuncoesPix.RetornaValorJson(LObjetoCertificado, 'cnpjEmpresa'));

    lblChavesDisponiveis.Caption := 'Chave Pública, Chave Privada';
    If Not TFuncoesPix.RetornaValorJson(LObjetoCertificado, 'certificadoRaiz').IsEmpty Then
      lblChavesDisponiveis.Caption := lblChavesDisponiveis.Caption + ', ' + #13 + 'Certificado Raiz';
    If Not TFuncoesPix.RetornaValorJson(LObjetoCertificado, 'intermediario01').IsEmpty Then
      lblChavesDisponiveis.Caption := lblChavesDisponiveis.Caption + ', ' + #13 + 'Certificado Intermediario 01';
    If Not TFuncoesPix.RetornaValorJson(LObjetoCertificado, 'intermediario02').IsEmpty Then
      lblChavesDisponiveis.Caption := lblChavesDisponiveis.Caption + ', Certificado Intermediario 02';
    If Not TFuncoesPix.RetornaValorJson(LObjetoCertificado, 'intermediario03').IsEmpty Then
      lblChavesDisponiveis.Caption := lblChavesDisponiveis.Caption + ', Certificado Intermediario 03';

    LObjetoCertificado.AddPair('base64', RetornarArquivoBase64(ACaminhoArquivo));
    LObjetoCertificado.AddPair('senhaCertificado', edtSenhaCertificado.Text);

    FRespostaJson := LObjetoCertificado.ToJson;

    FreeAndNil(LObjetoCertificado);
  Except
    On E: Exception Do
      FRespostaJson := E.Message;
  End;
end;

procedure TfrmConversorCertificadosCitel.RealizarConversaoSemTela(
  AArquivoPfx, ASenhaArquivo: String);
begin
  CarregaDadosCertificadoPFX(AArquivoPfx, ASenhaArquivo);
end;

function TfrmConversorCertificadosCitel.RetornaCNPJFormatado(
  ACNPJCertificado: String): String;
begin
  Result := ACNPJCertificado;

  If Result.Length < 14 Then
    Exit;

  Insert('.', Result, 3);
  Insert('.', Result, 7);
  Insert('/', Result, 11);
  Insert('-', Result, 16);
end;

function TfrmConversorCertificadosCitel.RetornarArquivoBase64(const ACaminhoArquivo: String): String;
  Var
    LArquivo: TFilestream;
Begin
  Try
    LArquivo := TFileStream.Create(ACaminhoArquivo, fmOpenRead);
    Result := TIdEncoderMIME.EncodeStream(LArquivo);
  Finally
    FreeAndNil(LArquivo);
  End;
End;

end.
