unit untFuncoesLibIntegracaoPix;

interface

Uses
 {$IFDEF LINUX}
 {$ELSE}
  untExibicaoQRCodePix, dxCore, Dialogs, untTelasAbertas, Vcl.Forms,
  untConversorCertificadosCitel, Vcl.Controls, {$ENDIF}
  untInterfacesIntegracaoPixCitel, untIDataset, System.SysUtils,
  untInterfacePixTefBridge;

procedure InicializaIntegracaoPixCitel(AIntegracaoPixCitel: IIntegracaoPixCitel); stdcall;
{$IFNDEF LINUX}
procedure InicializaIntegracaoPixCitelV2(AIntegracaoPixCitel: IIntegracaoPixCitel;
  ADisparaWhatsAppAut: TfunDisparaWhatsAppAutomatico = Nil;
  ADisparaEmailAut: TfunDisparaEmailAutomatico = Nil); stdcall;
{$ENDIF}

function RetornaBancosAtivosPIX: String; stdcall;

function CriaObjetoRequisicoesPix(AAutoIncremPix: String): IRequisicoesPix; stdcall;

function CriaObjetoRequisicoesPixEmpresa(AAutoIncremPix, AEmpresaChave: String): IRequisicoesPix; stdcall;

{$IFNDEF LINUX}
function CriaTelaLeituraQRCode(AAutoIncremChavePix,
                               ATxIdPix,
                               ATextoQRCode,
                               AAutoIncremMovPix: String): String; stdcall;

function CriaTelaLeituraQRCodeNovoPix(AAutoIncremChavePix,
                                      ADadosNovoPix,
                                      ADadosPixAlteracao: String): String; stdcall;

function CriaTelaLeituraQRCodeNovoPixCliente(AAutoIncremChavePix,
                                             ADadosNovoPix,
                                             ADadosPixAlteracao,
                                             ACodigoCliente: String): String; stdcall;

function CriaTelaLeituraQRCodeNovoPixClienteV2(AAutoIncremChavePix,
                                               ADadosNovoPix,
                                               ADadosPixAlteracao,
                                               ACodigoCliente,
                                               ATransactionType: String): String; stdcall;

function CriaTelaLeituraQRCodePagueFacil(AAutoIncremChavePix,
                                         ATxIdPix,
                                         ATextoQRCode,
                                         AAutoIncremMovPix: String): String; stdcall;

function CriaTelaLeituraQRCodeNovoPixPagueFacil(AAutoIncremChavePix,
                                                ADadosNovoPix,
                                                ACodigoCliente: String): String; stdcall;

function ConverterCertificadoPfxCitelWebhookItau: String; stdcall;

function ConverterCertificadoPfxCitelWebhookItauSemTela(AArquivoPfx,
                                                        ASenhaArquivo: String): String; stdcall;

{$ENDIF}

procedure dxInitializePix; stdcall;
procedure dxFinalizePix; stdcall;

function RetornaDadosAutorizacaoWebhookItau(ACNPJCliente,
                                            AChavePix,
                                            AAutoIncremChavePix: String): String; stdcall;

function RetornaCertificadosWebhookItau: String; stdcall;

function ImportarCertificadoCitelWebhookSantander(AWorkspace: String): String; stdcall;

procedure AtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); stdcall;

procedure RegistraBridgeTefPix(ABridge: IPixTefBridge); stdcall;
function  LibSuportaPixViaTef: LongBool; stdcall;

function RetornaDadosChavePixTela: String; StdCall;
procedure EnviaDadosDocumentoPixTela(ACodigoCliente, AChaveDocumento: String;
  AValorDocumento: Double); StdCall;
procedure EnviaDadosDocumentoPixTelaV2(ACodigoCliente, AChaveDocumento: String;
  AValorDocumento: Double; AOrigemChamada: String = ''); StdCall;

Var
  VS_TxIdCriadoTela,
  VS_CodigoCliente,
  VS_ChaveDocumento: String;
  VS_OrigemChamadaDLL : String;

  VS_ValorDocumento: Double;

  VS_DxInitialized: Boolean;

implementation

Uses untTRequisicoesPix, untFuncoesSimples, untTRequisicoesCitelPix;

function RetornaBancosAtivosPIX: String; stdcall;
Begin
  Result := '001_';
End;

procedure InicializaIntegracaoPixCitel(AIntegracaoPixCitel: IIntegracaoPixCitel); stdcall;
Begin
  VS_FuncoesExternas           := AIntegracaoPixCitel;
{$IFDEF LINUX}
  FormatSettings_ptBR;
{$ENDIF}
End;

{$IFNDEF LINUX}
procedure InicializaIntegracaoPixCitelV2(AIntegracaoPixCitel: IIntegracaoPixCitel;
  ADisparaWhatsAppAut: TfunDisparaWhatsAppAutomatico = Nil;
  ADisparaEmailAut: TfunDisparaEmailAutomatico = Nil); stdcall;
Begin
  InicializaIntegracaoPixCitel(AIntegracaoPixCitel);
  funDisparaWhatsappAutomatico := ADisparaWhatsAppAut;
  funDisparaEmailAutomatico    := ADisparaEmailAut;
End;
{$ENDIF}

function CriaObjetoRequisicoesPix(AAutoIncremPix: String): IRequisicoesPix; stdcall;
Begin
  If AAutoIncremPix.IsEmpty Then
    Result := TRequisicoesPix.Create
  Else
    Result := TRequisicoesPix.Create(AAutoIncremPix);
End;

function CriaObjetoRequisicoesPixEmpresa(AAutoIncremPix, AEmpresaChave: String): IRequisicoesPix; stdcall;
Begin
  Result := TRequisicoesPix.Create(AAutoIncremPix, AEmpresaChave);
End;

{$IFNDEF LINUX}
function CriaTelaLeituraQRCode(AAutoIncremChavePix,
                               ATxIdPix,
                               ATextoQRCode,
                               AAutoIncremMovPix: String): String; stdcall;
Begin
  Try
    frmExibicaoQRCodePix := TfrmExibicaoQRCodePix.Create(Nil);
    frmExibicaoQRCodePix.TxIdPix := ATxIdPix;
    frmExibicaoQRCodePix.TextoQRCode := ATextoQRCode;
    frmExibicaoQRCodePix.AutoIncremChavePix := AAutoIncremChavePix;
    frmExibicaoQRCodePix.AutoIncremMovPix := AAutoIncremMovPix;

    frmExibicaoQRCodePix.ShowModal;

    Result := frmExibicaoQRCodePix.Resposta;
  Finally
    FreeAndNil(frmExibicaoQRCodePix);
  End;
End;
{$ENDIF}

{$IFNDEF LINUX}
function CriaTelaLeituraQRCodePagueFacil(AAutoIncremChavePix,
                                         ATxIdPix,
                                         ATextoQRCode,
                                         AAutoIncremMovPix: String): String; stdcall;
Begin
  Try
    frmExibicaoQRCodePix := TfrmExibicaoQRCodePix.Create(Nil);
    frmExibicaoQRCodePix.TxIdPix := ATxIdPix;
    frmExibicaoQRCodePix.TextoQRCode := ATextoQRCode;
    frmExibicaoQRCodePix.AutoIncremChavePix := AAutoIncremChavePix;
    frmExibicaoQRCodePix.AutoIncremMovPix := AAutoIncremMovPix;
    frmExibicaoQRCodePix.FormStyle := fsStayOnTop;
    frmExibicaoQRCodePix.RecebimentoPagueFacil := True;

    frmExibicaoQRCodePix.ShowModal;

    Result := frmExibicaoQRCodePix.Resposta;
  Finally
    FreeAndNil(frmExibicaoQRCodePix);
  End;
End;
{$ENDIF}

{$IFNDEF LINUX}
function CriaTelaLeituraQRCodeNovoPix(AAutoIncremChavePix,
                                      ADadosNovoPix,
                                      ADadosPixAlteracao: String): String; stdcall;
Begin
  Result := CriaTelaLeituraQRCodeNovoPixClienteV2(AAutoIncremChavePix,
                                                  ADadosNovoPix,
                                                  ADadosPixAlteracao,
                                                  EmptyStr,
                                                  EmptyStr);
End;
{$ENDIF}

{$IFNDEF LINUX}
function CriaTelaLeituraQRCodeNovoPixPagueFacil(AAutoIncremChavePix,
                                                ADadosNovoPix,
                                                ACodigoCliente: String): String; stdcall;
Begin
  Try
    frmExibicaoQRCodePix := TfrmExibicaoQRCodePix.Create(Nil);
    frmExibicaoQRCodePix.AutoIncremChavePix := AAutoIncremChavePix;
    frmExibicaoQRCodePix.DadosNovoPix := ADadosNovoPix;
    frmExibicaoQRCodePix.DadosPixAlteracao := EmptyStr;
    frmExibicaoQRCodePix.CodigoCLiente := ACodigoCliente;
    frmExibicaoQRCodePix.CriarNovoPix := True;
    frmExibicaoQRCodePix.FormStyle := fsStayOnTop;
    frmExibicaoQRCodePix.RecebimentoPagueFacil := True;
    frmExibicaoQRCodePix.ChaveDocumento := VS_ChaveDocumento;
    frmExibicaoQRCodePix.ValorDocumento := VS_ValorDocumento;

    If Not VS_CodigoCliente.isEmpty Then
      frmExibicaoQRCodePix.CodigoCLiente := VS_CodigoCliente;

    frmExibicaoQRCodePix.ShowModal;

    Result := frmExibicaoQRCodePix.Resposta;
  Finally
    FreeAndNil(frmExibicaoQRCodePix);
  End;
End;
{$ENDIF}

{$IFNDEF LINUX}
function CriaTelaLeituraQRCodeNovoPixCliente(AAutoIncremChavePix, ADadosNovoPix, ADadosPixAlteracao, ACodigoCliente: String): String; StdCall;
begin
  Result := CriaTelaLeituraQRCodeNovoPixClienteV2(AAutoIncremChavePix, ADadosNovoPix, ADadosPixAlteracao, ACodigoCliente, '');
end;

function CriaTelaLeituraQRCodeNovoPixClienteV2(AAutoIncremChavePix,
                                               ADadosNovoPix,
                                               ADadosPixAlteracao,
                                               ACodigoCliente,
                                               ATransactionType: String): String; stdcall;
Begin
  Try
    frmExibicaoQRCodePix := TfrmExibicaoQRCodePix.Create(Nil);
    frmExibicaoQRCodePix.AutoIncremChavePix := AAutoIncremChavePix;
    frmExibicaoQRCodePix.DadosNovoPix := ADadosNovoPix;
    frmExibicaoQRCodePix.DadosPixAlteracao := ADadosPixAlteracao;
    frmExibicaoQRCodePix.CodigoCLiente := ACodigoCliente;
    frmExibicaoQRCodePix.TransactionType := ATransactionType;
    frmExibicaoQRCodePix.CriarNovoPix := True;
    frmExibicaoQRCodePix.ChaveDocumento := VS_ChaveDocumento;
    frmExibicaoQRCodePix.ValorDocumento := VS_ValorDocumento;
    frmExibicaoQRCodePix.OrigemChamada := VS_OrigemChamadaDLL;

    If Not VS_CodigoCliente.isEmpty Then
      frmExibicaoQRCodePix.CodigoCLiente := VS_CodigoCliente;


    frmExibicaoQRCodePix.ShowModal;

    VS_TxIdCriadoTela := frmExibicaoQRCodePix.TxIdPix;

    Result := frmExibicaoQRCodePix.Resposta;
  Finally
    FreeAndNil(frmExibicaoQRCodePix);
  End;
End;
{$ENDIF}

procedure AtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); stdcall;
Begin
{$IFNDEF LINUX}
  untTelasAbertas.objTelasAbertas := ATelaAbertas;
{$ENDIF}
End;

procedure RegistraBridgeTefPix(ABridge: IPixTefBridge); stdcall;
Begin
{$IFNDEF LINUX}
  untInterfacePixTefBridge.objBridgeTef := ABridge;
{$ENDIF}
End;

function LibSuportaPixViaTef: LongBool; stdcall;
Begin
{$IFNDEF LINUX}
  Result := True;
{$ELSE}
  Result := False;
{$ENDIF}
End;

function RetornaDadosAutorizacaoWebhookItau(ACNPJCliente,
                                            AChavePix,
                                            AAutoIncremChavePix: String): String; stdcall;
Begin
  Result := TRequisicoesCitelPix.RetornaDadosAutorizacaoWebhookItau(ACNPJCliente,
                                                                    AChavePix,
                                                                    AAutoIncremChavePix);
End;

function RetornaCertificadosWebhookItau: String; stdcall;
Begin
  Result := TRequisicoesCitelPix.RetornaCertificadosWebhookItau;
End;

function ImportarCertificadoCitelWebhookSantander(AWorkspace: String): String; stdcall;
Begin
  Result := TRequisicoesCitelPix.ImportarCertificadoCitelWebhookSantander(AWorkspace);
End;

{$IFNDEF LINUX}
function ConverterCertificadoPfxCitelWebhookItau: String; stdcall;
  Var
    LConversorCertificadosCitel: TfrmConversorCertificadosCitel;
Begin
  Result := EmptyStr;

  Try
    LConversorCertificadosCitel := TfrmConversorCertificadosCitel.Create(Nil);
    LConversorCertificadosCitel.ShowModal;

    If LConversorCertificadosCitel.ModalResult = mrOk Then
      Result := LConversorCertificadosCitel.RespostaJson;
  Finally
    FreeAndNil(LConversorCertificadosCitel);
  End;
End;

function ConverterCertificadoPfxCitelWebhookItauSemTela(AArquivoPfx,
  ASenhaArquivo: String): String; stdcall;
  Var
    LConversorCertificadosCitel: TfrmConversorCertificadosCitel;
Begin
  Result := EmptyStr;

  Try
    LConversorCertificadosCitel := TfrmConversorCertificadosCitel.Create(Nil);
    LConversorCertificadosCitel.RealizarConversaoSemTela(AArquivoPfx, ASenhaArquivo);

    If Not LConversorCertificadosCitel.RespostaJson.IsEmpty Then
      Result := LConversorCertificadosCitel.RespostaJson;
  Finally
    FreeAndNil(LConversorCertificadosCitel);
  End;
End;
{$ENDIF}

function RetornaDadosChavePixTela: String; StdCall;
Begin
  If VS_TxIdCriadoTela.IsEmpty Then
    Exit(EmptyStr);

  Result := VS_TxIdCriadoTela;
  VS_TxIdCriadoTela := EmptyStr;
End;

procedure EnviaDadosDocumentoPixTela(ACodigoCliente, AChaveDocumento: String;
  AValorDocumento: Double); StdCall;
Begin
  VS_CodigoCliente := ACodigoCliente;
  VS_ChaveDocumento := AChaveDocumento;
  VS_ValorDocumento := AValorDocumento;
End;

procedure EnviaDadosDocumentoPixTelaV2(ACodigoCliente, AChaveDocumento: String;
  AValorDocumento: Double; AOrigemChamada: String = ''); StdCall;
Begin
  EnviaDadosDocumentoPixTela(ACodigoCliente, AChaveDocumento, AValorDocumento);
  VS_OrigemChamadaDLL := AOrigemChamada;
End;

procedure dxInitializePix;
Begin
  {$IFNDEF LINUX}
  If Not VS_DxInitialized Then
  Begin
    dxCore.dxInitialize;
    VS_DxInitialized := True;
  End;
  {$ENDIF}
End;

procedure dxFinalizePix;
Begin
{$IFNDEF LINUX}
  If VS_DxInitialized Then
  Begin
    dxCore.dxFinalize;
    VS_DxInitialized := False;
  End;
{$ENDIF}
End;

Initialization
  VS_TxIdCriadoTela := EmptyStr;
  VS_CodigoCliente := EmptyStr;
  VS_ChaveDocumento := EmptyStr;
  VS_ValorDocumento := 0.00;

  VS_DxInitialized := False;

  {$IFNDEF LINUX}
  dxCore.dxInitialize;
  VS_DxInitialized := True;
  {$ENDIF}

Finalization
  VS_TxIdCriadoTela := EmptyStr;
  VS_CodigoCliente := EmptyStr;
  VS_ChaveDocumento := EmptyStr;
  VS_ValorDocumento := 0.00;

  VS_FuncoesExternas := Nil;
 {$IFNDEF LINUX}
  objTelasAbertas := Nil;
  untInterfacePixTefBridge.objBridgeTef := Nil;

  If VS_DxInitialized Then
    dxCore.dxFinalize;
  VS_DxInitialized := False;
 {$ENDIF}

end.
