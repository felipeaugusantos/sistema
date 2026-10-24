unit untFuncoes;

interface
type
  TTipoArquivo = (tpaNone, tpaNormal, tpaPDF, tpaExcel, tpaTexto, tpaImagem, tpaXml, tpaDoc);

  TRecArquivosGatilhos = record
    Titulo: String;
    Arquivo: String;
    TipoArquivo: TTipoArquivo;
    Url: String;
    ArmazenadoNoBucket: Boolean;

    constructor Create(ATitulo, AArquivo, AUrl: String; ATipoArquivo: TTipoArquivo = tpaPDF; AArmazenadoNoBucket: Boolean = False);
  end;

  IGeraArquivoAnexoEmailAutomatico = interface
   ['{51B1D432-AB44-465D-9AC8-DE3F02A2F509}']
  end;

  TDestinatarioWhatsapp = Class
  public
  end;

function fRetFilaEContatoEnvio(var strAutIncCtt: String;
                               var strCelular: String;
                               var strFilaEnv: String;
                                   strCodCli,
                                   strNomCli,
                                   strCodigoGatilho,
                                   strCodigoGrupoGatilho: String;
                                   blnAbreTela: Boolean): Boolean;

function fDisparaWhatsappAutomatico(strNumDoc,
                                      strOpcDoc,
                                      strEspDoc,
                                      strNumOrc,
                                      strEspOrc,
                                      strEmpOri,
                                      strCodDes: String;
                                      AQrCodePix: String = '';
                                      const blnAssincrono: boolean = True;
                                      strCodCup: String = '';
                                      objGeraAnexo : IGeraArquivoAnexoEmailAutomatico = Nil;
                                      strAutInc: String = '';
                                      strFisAcesso: String = '';
                                      strSerie_: String = '';
                                      strUnitDisparo: String = '';
                                      strAutIncCtt: String = '';
                                      strCelularEnv: String = '';
                                      strFilaEnv: String = '';
                                      strAutIncNotfic: String = '';
                                      strCodigoDoServico: String = '';
                                      strCodigoStatusServico: String = '';
                                      blnResultTrueCasoCelularEmBranco: Boolean = False;
                                      blnResultTrueCasoGatilhoDesativado: Boolean = False;
                                      DestinatarioWhatsapp: TDestinatarioWhatsapp = nil;
                                      strInfAdi: String = '';
                                      strLinkPagamento: String = '';
                                      recArquivos: TArray<TRecArquivosGatilhos> = nil;
                                      strCodIte: String = ''): Boolean;

implementation

function fRetFilaEContatoEnvio(var strAutIncCtt: String;
                               var strCelular: String;
                               var strFilaEnv: String;
                                   strCodCli,
                                   strNomCli,
                                   strCodigoGatilho,
                                   strCodigoGrupoGatilho: String;
                                   blnAbreTela: Boolean): Boolean;
begin
  Result := False;
end;

function fDisparaWhatsappAutomatico(strNumDoc,
                                      strOpcDoc,
                                      strEspDoc,
                                      strNumOrc,
                                      strEspOrc,
                                      strEmpOri,
                                      strCodDes: String;
                                      AQrCodePix: String = '';
                                      const blnAssincrono: boolean = True;
                                      strCodCup: String = '';
                                      objGeraAnexo : IGeraArquivoAnexoEmailAutomatico = Nil;
                                      strAutInc: String = '';
                                      strFisAcesso: String = '';
                                      strSerie_: String = '';
                                      strUnitDisparo: String = '';
                                      strAutIncCtt: String = '';
                                      strCelularEnv: String = '';
                                      strFilaEnv: String = '';
                                      strAutIncNotfic: String = '';
                                      strCodigoDoServico: String = '';
                                      strCodigoStatusServico: String = '';
                                      blnResultTrueCasoCelularEmBranco: Boolean = False;
                                      blnResultTrueCasoGatilhoDesativado: Boolean = False;
                                      DestinatarioWhatsapp: TDestinatarioWhatsapp = nil;
                                      strInfAdi: String = '';
                                      strLinkPagamento: String = '';
                                      recArquivos: TArray<TRecArquivosGatilhos> = nil;
                                      strCodIte: String = ''): Boolean;
begin
  Result := False;
end;

{ TRecArquivosGatilhos }

constructor TRecArquivosGatilhos.Create(ATitulo, AArquivo, AUrl: String;
  ATipoArquivo: TTipoArquivo; AArmazenadoNoBucket: Boolean);
begin
  Titulo := ATitulo;
  Arquivo := AArquivo;
  TipoArquivo := ATipoArquivo;
  Url := AUrl;
  ArmazenadoNoBucket := AArmazenadoNoBucket;
end;

end.
