unit untFatDigAssinaturaWacom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Menus, Buttons, ExtCtrls, AppEvnts,
  BitBtnLockedIncrem, Mask, MaskEditFocus, frxClass, System.IOUtils,
  frxExportCSVTestabilidade, untWacomSignature, FLSIGCTLLib_TLB;

type
  TSignature = record
    SignText: String;
    WhoSign: String;
    WhySign: String;
    WhenSign: String;
    ImgSignB64: String;
  end;

  TfrmFatDigAssinaturaWacom = class(TfrmPai)
    pnlGeral: TPanel;
    Label9: TLabel;
    edtWhoSign: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    Panel1: TPanel;
    memDetails: TMemo;
    Panel2: TPanel;
    btnCancel: TSpeedButton;
    btnSign: TSpeedButton;
    lblTopText: TLabel;
    lblWhySign: TLabel;
    Label1: TLabel;
    Panel3: TPanel;
    Shape1: TShape;
    imgSignature: TImage;
    lblWhoSign: TLabel;
    lblWhenSign: TLabel;
    lblWaiting: TLabel;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure edtWhoSignChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSignClick(Sender: TObject);

    procedure Capture_Default;
    procedure Capture_CTL_472;
    procedure ConverteImgBitMapPreto(AFileName : string);

  private
    { Private declarations }
    FWacomSignature: TWacomSignature;
    FSignature: TSignature;
  private
    procedure ProcWacomOnSigned(AWacomSignature: TWacomSignature);
    procedure ProcWacomOnCancel(AWacomSignature: TWacomSignature);
  protected
    function fValidaCampos(Sender: TWinControl; blnPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    class function fColetarAssinatura(ATopText, AWhySign: String; ADetails: TArray<String>;
      Var ASignature: TSignature): Boolean;
  end;

implementation

uses untfuncoesSimples, untFuncoesGenerica, untImagemBase64;

{$R *.dfm}
{ TfrmFatDigAssinaturaWacom }

function TfrmFatDigAssinaturaWacom.fValidaCampos(Sender: TWinControl; blnPorChave: Boolean)
  : Boolean;
begin
  Result := True;
  If (Sender = edtWhoSign) Then
  Begin
    If fEmptyStr(edtWhoSign.Text) Then
    Begin
      fMensagem('Atenção!', 'Informe o nome completo para coletar a assinatura!', ['&Ok']);
      Result := False;
    End;
  End;
end;

procedure TfrmFatDigAssinaturaWacom.ProcWacomOnCancel(AWacomSignature: TWacomSignature);
begin
  imgSignature.Picture.Assign(nil);
  btnConfirmaDados.Enabled := False;
  edtWhoSign.Enabled := True;
  lblWaiting.Visible := False;
  If Not edtWhoSign.Focused Then
    pSetFocus(edtWhoSign);
end;

procedure TfrmFatDigAssinaturaWacom.ProcWacomOnSigned(AWacomSignature: TWacomSignature);
Var
  LReader: IWacomReadSignature;
  LFile: String;
  LSignText: String;
begin
  LSignText := AWacomSignature.SignText;

  Repeat
    LFile := TPath.GetTempPath + '\' + Random(999999999).ToString + '.bmp';
  Until Not FileExists(LFile);

  LReader := TWacomSignature.ReadSignature(LSignText);

  If LReader.RenderBitmap(LFile) Then
  Begin
    btnConfirmaDados.Enabled := True;

    imgSignature.Picture.LoadFromFile(LFile);
    lblWhoSign.Caption := LReader.WhoSign;
    lblWhenSign.Caption := LReader.WhenSign;
    FSignature.SignText := LSignText;
    FSignature.WhoSign := LReader.WhoSign;
    FSignature.WhySign := LReader.WhySign;
    FSignature.WhenSign := LReader.WhenSign;
    FSignature.ImgSignB64 := fBase64FromImg(imgSignature.Picture.Graphic);
    DeleteFile(LFile);
  End;

  lblWaiting.Visible := False;
end;

procedure TfrmFatDigAssinaturaWacom.btnCancelClick(Sender: TObject);
begin
  inherited;
  ProcWacomOnCancel(FWacomSignature);
  If Assigned(FWacomSignature) And FWacomSignature.IsSigning Then
    FWacomSignature.Cancel();
end;

procedure TfrmFatDigAssinaturaWacom.btnConfirmaDadosClick(Sender: TObject);
begin
  If Not btnConfirmaDados.Enabled Then
    Exit;

  inherited;

  Close;
  ModalResult := mrOk;
end;

procedure TfrmFatDigAssinaturaWacom.btnSignClick(Sender: TObject);
begin

  inherited;

  btnConfirmaDados.Enabled := False;
  imgSignature.Picture.Assign(nil);

  If Not fVerificaCampos Then
    Exit;

  If (fCfgSis('WACMOD') = 'CTL-472') Then
  Begin
    Capture_CTL_472;
    Exit;
  End;

  Capture_Default;

end;

procedure TfrmFatDigAssinaturaWacom.Capture_CTL_472;
var
  sigCtl      : TSigCtl;
  res         : CaptureResult;
  sigObj1     : SigObj;
  LReader     : IWacomReadSignature;
  FileName,
  MensErro,
  MensErroDet : string;

begin
  try
    sigCtl := TSigCtl.Create(Self);
  Except
    On E: Exception Do
      raise Exception.Create('Erro ao iniciar objetos do Tablet CTL472.' + #13#10 +
        'Favor verificar se o driver e biblioteca SDK foram instalados corretamente! ' + #13#10 +
        'Error: ' + E.Message);
  End;

  try
    sigCtl.Licence := LITE_LICENSE;
    sigctl.DefaultInterface.InputWho := lblWhoSign.Caption;;
    sigctl.DefaultInterface.InputWhy := lblWhySign.Caption;
    res := sigCtl.Capture(sigctl.DefaultInterface.InputWho, sigctl.DefaultInterface.InputWhy);
    if res = CaptureOK then
    begin
      fileName := TPath.GetTempPath + '\' + 'sig1.bmp';
      sigObj1  := SigObj(sigCtl.Signature);
      sigObj1.RenderBitmap(fileName, 200, 150, 'image/bmp', 0.5, $ff0000, $ffffff, -1.0, -1.0, RenderOutputFilename or RenderColor32BPP or RenderEncodeData);
      LReader := TWacomSignature.ReadSignature(sigObj1.SigText);
      btnConfirmaDados.Enabled := True;
      ConverteImgBitMapPreto(FileName);

      imgSignature.Picture.LoadFromFile(FileName);
      lblWhoSign.Caption    := LReader.WhoSign;
      lblWhenSign.Caption   := LReader.WhenSign;
      FSignature.SignText   := sigObj1.SigText;
      FSignature.WhoSign    := LReader.WhoSign;
      FSignature.WhySign    := LReader.WhySign;
      FSignature.WhenSign   := LReader.WhenSign;
      FSignature.ImgSignB64 := fBase64FromImg(imgSignature.Picture.Graphic);
      DeleteFile(FileName);
      lblWaiting.Visible    := False;
    end
    else
    begin
      MensErro := 'Erro na captura da assinatura. Erro='+IntToStr(res)+#10#13;
      case res of
        CaptureCancel             : begin
                                      MensErroDet := 'Assinatura cancelada.';
                                    end;
        CaptureError              : begin
                                      MensErroDet := 'Serviço de captura não disponível.';
                                    end;
        CapturePadError           : begin
                                      MensErroDet := 'Aparelho de assinatura com erro.';
                                    end;
        CaptureIntegrityKeyInvalid: begin
                                      MensErroDet := 'Chave inválida da integridade da captura.';
                                    end;
        CaptureNotLicensed        : begin
                                      MensErroDet := 'Captura não licenciada.';
                                    end;
        CaptureAbort              : begin
                                      MensErroDet := 'Captura abortada.';
                                    end;
        else                        begin
                                      MensErroDet := 'Código de erro inesperado.';
                                    end;
      end;
      fMensagem('Atenção!',MensErro + MensErroDet, ['&Ok']);
    end;
  finally
    FreeAndNil(SigCtl);
  end;
end;

procedure TfrmFatDigAssinaturaWacom.ConverteImgBitMapPreto(AFileName : string);
var
  ImagOrig    : Tbitmap;
  x,
  y,
  media,
  Valor       : integer;
  PixelColor,
  NovaCor     : TColor;

begin
  ImagOrig := Tbitmap.Create;
  Try
    ImagOrig.LoadFromFile(AfileName);
    DeleteFile(AFileName);

    for y := 0 to ImagOrig.Height -1 do
    begin
      for x := 0 to ImagOrig.Width -1 do
      begin
        PixelColor := ImagOrig.Canvas.Pixels[x,y];
        Valor :=  ColorToRGB(PixelColor);
        media :=  trunc((GetRValue(Valor) + GetGValue(Valor) + GetBValue(Valor)) / 3);
        if media < (fCfgSis('WACRGB', varInteger)) then
          media := 0;
        NovaCor := TColor(RGB(media, media, media));
        ImagOrig.Canvas.Pixels[x,y] := NovaCor;
      end;
    end;

    ImagOrig.SaveToFile(AfileName);
  Finally
    FreeAndNil(ImagOrig);
  End;
end;

procedure TfrmFatDigAssinaturaWacom.Capture_Default;
Var
  LDetail : String;
  LDetails: TArray<String>;
begin

  SetLength(LDetails, 0);

  For LDetail In memDetails.Lines Do
    pAddDados(LDetails, LDetail);

  If Assigned(FWacomSignature) Then
    FreeAndNil(FWacomSignature);

  Try
    FWacomSignature := TWacomSignature.Create(Self);

    FWacomSignature.TopText(lblTopText.Caption)
                   .Details(LDetails)
                   .WhoSign(lblWhoSign.Caption)
                   .WhySign(lblWhySign.Caption)
                   .OnSigned(ProcWacomOnSigned)
                   .OnCancel(ProcWacomOnCancel)
                   .Start;

    If FWacomSignature.IsSigning Then
    Begin
      edtWhoSign.Enabled := False;
      lblWaiting.Visible := True;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagemSonora(E.Message);
    End;
  End;

end;

procedure TfrmFatDigAssinaturaWacom.edtWhoSignChange(Sender: TObject);
begin
  inherited;
  lblWhoSign.Caption := edtWhoSign.Text;
end;

class function TfrmFatDigAssinaturaWacom.fColetarAssinatura(ATopText, AWhySign: String;
  ADetails: TArray<String>; Var ASignature: TSignature): Boolean;
Var
  LForm: TfrmFatDigAssinaturaWacom;
  LDetail: String;
begin
  pCriarFormularios(TfrmFatDigAssinaturaWacom, LForm);
  Try
    LForm.btnConfirmaDados.Enabled := False;
    LForm.imgSignature.Picture.Assign(nil);
    LForm.edtWhoSign.Text := EmptyStr;
    LForm.lblWhoSign.Caption := 'Informar o nome completo';
    LForm.lblWhenSign.Caption := '';
    LForm.lblTopText.Caption := ATopText;
    LForm.lblWhySign.Caption := AWhySign;
    LForm.memDetails.Clear;
    For LDetail In ADetails Do
      LForm.memDetails.Lines.Add(LDetail);
    Result := LForm.ShowModal = mrOk;
    ASignature := LForm.FSignature;
  Finally
    pFreeAndNil(LForm);
  End;
end;

procedure TfrmFatDigAssinaturaWacom.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F3:
      btnCancel.Click;
    VK_F4:
      btnSign.Click;
    VK_F10:
      btnConfirmaDados.Click;
  End;
end;

procedure TfrmFatDigAssinaturaWacom.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtWhoSign);
  FillChar(FSignature, SizeOf(FSignature), #0);
end;

end.
