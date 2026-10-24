unit untTefCitelComum;

interface

uses untInterfaceTefCitel, SysUtils, Classes;

const
  TEFCitelErro_Log = 'libTefCitelErro.log';
  TituloLogErr     = 'LibTefCitel.dll' ;

  // Ordem/indice segue o ID do campo no protocolo TLV do CliSiTef (1..6);
  // os mesmos 6 atributos existem no retorno do Tech-Scope (NCR), em posicoes
  // fixas de buffer — ver CAMPOS_INFO_HW_NCR em untTefCitelNCR.pas.
  ROTULOS_INFO_PINPAD_COMUM: array[1..6] of String = (
    'Nome do fabricante',
    'Modelo / versao do hardware',
    'Versao do firmware / software basico',
    'Versao da especificacao',
    'Versao da aplicacao basica',
    'Numero de serie'
  );

type
  LibTefDLLException = class(Exception);

  TTefInfo = record
    MacAdress: string;
    IPNumber : string;
    UserName : string;
    ComputerName: string;
    TerminalTEF : string;
  end;

  TRetornoTEFCitel = Class(TInterfacedObject, IRetornoTEFCitel)
  private
    FCupom : TStringList;
    FDadosCartao: TDadosCartao;
    FStatusTEF: TStatusTEFCitel;
    FobjDadosAdicionaisTefTra: IDadosAdicionaisTefTra ;
    FIntervalos: IIntervalosTEF;
    function GetCupom: TStringList;
    function GetDadosCartao: TDadosCartao;
    function GetStatusTEF: TStatusTEFCitel;
  public
    constructor Create();
    destructor Destroy; override;
    property Cupom: TStringList read GetCupom;
    property DadosCartao: TDadosCartao read GetDadosCartao;
    property StatusTef: TStatusTEFCitel read GetStatusTEF;
    function DadosAdicionaisTefTra(): IDadosAdicionaisTefTra ; overload ;
    function DadosAdicionaisTefTra(AValue: IDadosAdicionaisTefTra): IRetornoTEFCitel ; overload ;
    function Intervalos: IIntervalosTEF; overload;
    function Intervalos(AValue: IIntervalosTEF): IRetornoTEFCitel ; overload ;
  End;

  TRetornaTipoOperacao = class
  public
    class function fGet(const AintCodigo: integer): String ;
  end ;

  TProcessaRetornoTefCitel = Class(TInterfacedObject, IProcessaRetornoTEFCitel)
  private
    FResposta : IRetornoTEFCitel;
    const REGISTRO_S : String = 'S';
    const REGISTRO_C : String = 'C';
    const REGISTRO_I : String = 'I';
  public
    constructor Create(ARetorno : IRetornoTEFCitel);
    procedure ProcessarCartao(strCupom : TStringList;
                              strValor : String;
                              strBandeira : String;
                              strNomeRede : String;
                              strAutorizacao : String;
                              strNSU : String;
                              strTipoTransacao : String;
                              strQuantidadeParcelas : String;
                              strNumeroControle : String;
                              strConteudoViaCliente: String;
                              strConteudoViaLojista : String;
                              strDataHoraTrans: String;
                              strChaPix : String;
                              strPixS_N : String;
                              strCodigoCarteiraDigital: String;
                              intPrimeiroVencimento: Integer;
                              intPeriodo: Integer;
                              strControle: String;
                              strTipDeb: Char;
                              objDadosAdicionaisTefTra: IDadosAdicionaisTefTra;
                              strCodigoEstabeleci: String;
                              strPrePago: String;
                              objIntervalos: IIntervalosTEF;
                              strParcAdm: String;
                              strModoEntrada: String;
                              strTipoOperacao: String;
                              strXIdPix: String;
                              strCampoReferenciaPix: String;
                              strQrCodePix: String;
                              strRequestPagamentoPix: String;
                              strResponsePagamentoPix: String;
                              strDadosPagamentoPix: String;
                              strResponseDevolucaoPix: String);
    procedure ProcessarStatus(strStatus,
                              strMensagem: String);
    procedure ProcessarCupom(strConteudo: TStringList);
    procedure LimparRetorno;
  End;

  TInfoRequisicao = record
    strModalidade: String;
    strNumDoc: String;
    intQtdParc: Integer;
    dtaData: TDate;
    hraHora: TTime;
    fltValor: Double;
    dtaDataPreDatado: TDate;
    intQtdParcCdc: Integer;
    intIntervaloParc: Integer;
    intPrimParcAvista: Integer;
    dtaPrimParcela: TDate ;
    intOperacaoTefTra: Integer ;
  end;

  TCartao = record
    strCupom : TStringList;
    strValor : String;
    strBandeira : String;
    strNomeRede : String;
    strAutorizacao : String;
    strNSU : String;
    strTipoTransacao : String;
    strQuantidadeParcelas : String;
    strNumeroControle : String;
    strConteudoViaCliente : String;
    strConteudoViaLojista : String;
    strDataHora : String;
    strDtaTra : String;
    strHraTra : String;
    strNumDoc : String;
    blnCancelado : Boolean;
    strChaPix : String;
    strPixS_N : String;
    strCodigoCarteiraDigital : string;
    strEmbosso : string ;
    intPrimeiroVencimento: Integer;
    intPeriodo: Integer;
    strControle: String;
    strMotivoQuedaConexao: String ;
    strTipDeb: Char ;
    strCodigoEstabeleci: String ;
    strPrePago: String ;
    strParcAdm: String ;
    strModoEntrada: String;
    strTipoOperacao: String ;
    strXIdPix: String;
    strCampoReferenciaPix: String;
    strQrCodePix: String;
    strRequestPagamentoPix: String;
    strResponsePagamentoPix: String;
    strResponseDevolucaoPix: String;
    strDadosPagamentoPix: String;
  end;

type
  TInfoPinPadBuilder = record
  private
    FResult: String;
  public
    procedure Reset;
    procedure AddCampo(const ARotulo, AValor: String);
    function ToString: String;
  end;

function fRetornaSomenteNumeros(const AstrValor: String): String ;
function fTiraCaracEspeciais(strTexto: String): String;
function fFormataMsgExcecao(const AContexto: String; E: Exception): String;

implementation

{TRetornoTEFCitel}

constructor TRetornoTEFCitel.Create;
begin
  FDadosCartao := TDadosCartao.Create;
  FDadosCartao.intPrimeiroVencimento := -1;
  FDadosCartao.intPeriodo := 0;
  FStatusTEF := TStatusTEFCitel.Create;
  FCupom := TStringList.Create;
  FobjDadosAdicionaisTefTra := Nil ;
  FIntervalos := nil;
end;

function TRetornoTEFCitel.DadosAdicionaisTefTra: IDadosAdicionaisTefTra;
begin
  Result := FobjDadosAdicionaisTefTra ;
end;

function TRetornoTEFCitel.DadosAdicionaisTefTra(
  AValue: IDadosAdicionaisTefTra): IRetornoTEFCitel;
begin
  FobjDadosAdicionaisTefTra := AValue ;
  Result := Self ;
end;

destructor TRetornoTEFCitel.Destroy;
begin
  FCupom.Free;
  inherited;
end;

function TRetornoTEFCitel.GetCupom: TStringList;
begin
  Result := FCupom;
end;

function TRetornoTEFCitel.GetDadosCartao: TDadosCartao;
begin
  Result := FDadosCartao;
end;

function TRetornoTEFCitel.GetStatusTEF: TStatusTEFCitel;
begin
  Result := FStatusTEF;
end;

function TRetornoTEFCitel.Intervalos(AValue: IIntervalosTEF): IRetornoTEFCitel;
begin
  FIntervalos := AValue;
  Result := Self;
end;

function TRetornoTEFCitel.Intervalos: IIntervalosTEF;
begin
  Result := FIntervalos;
end;

{TProcessaRetornoTefTCitel}

constructor TProcessaRetornoTefCitel.Create(ARetorno : IRetornoTEFCitel);
begin
  FResposta := ARetorno;
end;

procedure TProcessaRetornoTefCitel.LimparRetorno;
begin
  if Assigned(FResposta.DadosCartao.strCupom) then
    FResposta.DadosCartao.strCupom.Clear ;
  FResposta.DadosCartao.strValor              := '';
  FResposta.DadosCartao.strBandeira           := '';
  FResposta.DadosCartao.strNomeRede           := '';
  FResposta.DadosCartao.strAutorizacao        := '';
  FResposta.DadosCartao.strNSU                := '';
  FResposta.DadosCartao.strTipoTransacao      := '';
  FResposta.DadosCartao.strQuantidadeParcelas := '';
  FResposta.DadosCartao.strNumeroControle     := '';
  FResposta.DadosCartao.strConteudoViaCliente := '';
  FResposta.DadosCartao.strConteudoViaLojista := '';
  FResposta.DadosCartao.strDataHoraTrans      := '';
  FResposta.DadosCartao.strChaPix             := '';
  FResposta.DadosCartao.strPixS_N             := '';
  FResposta.DadosCartao.strCodigoCarteiraDigital := '';
  FResposta.DadosCartao.intPrimeiroVencimento := 0 ;
  FResposta.DadosCartao.intPeriodo := 0 ;
  FResposta.DadosCartao.strControle := '' ;
  FResposta.DadosCartao.strTipDeb := #0 ;
  FResposta.DadosCartao.strCodigoEstabeleci := '';
  FResposta.DadosCartao.strPrePago := '' ;
  FResposta.DadosAdicionaisTefTra(Nil) ;
  FResposta.DadosCartao.strParcAdm := 'N' ;
  FResposta.DadosCartao.strModoEntrada := '';
  FResposta.DadosCartao.strTipoOperacao := '';
end;

procedure TProcessaRetornoTefCitel.ProcessarCartao(strCupom : TStringList;
                                                   strValor : String;
                                                   strBandeira : String;
                                                   strNomeRede : String;
                                                   strAutorizacao : String;
                                                   strNSU : String;
                                                   strTipoTransacao : String;
                                                   strQuantidadeParcelas : String;
                                                   strNumeroControle : String;
                                                   strConteudoViaCliente: String;
                                                   strConteudoViaLojista: String;
                                                   strDataHoraTrans: String;
                                                   strChaPix : String;
                                                   strPixS_N : String;
                                                   strCodigoCarteiraDigital: String;
                                                   intPrimeiroVencimento: Integer;
                                                   intPeriodo: Integer;
                                                   strControle: String;
                                                   strTipDeb: Char;
                                                   objDadosAdicionaisTefTra: IDadosAdicionaisTefTra;
                                                   strCodigoEstabeleci: String;
                                                   strPrePago: String;
                                                   objIntervalos: IIntervalosTEF;
                                                   strParcAdm: String;
                                                   strModoEntrada: String;
                                                   strTipoOperacao: String;
                                                   strXIdPix: String;
                                                   strCampoReferenciaPix: String;
                                                   strQrCodePix: String;
                                                   strRequestPagamentoPix: String;
                                                   strResponsePagamentoPix: String;
                                                   strDadosPagamentoPix: String;
                                                   strResponseDevolucaoPix: String);
begin
  FResposta.DadosCartao.strCupom              := strCupom;
  FResposta.DadosCartao.strValor              := strValor;
  FResposta.DadosCartao.strBandeira           := strBandeira;
  FResposta.DadosCartao.strNomeRede           := strNomeRede;
  FResposta.DadosCartao.strAutorizacao        := strAutorizacao;
  FResposta.DadosCartao.strNSU                := strNSU;
  FResposta.DadosCartao.strTipoTransacao      := strTipoTransacao;
  if strQuantidadeParcelas = '0' then
    strQuantidadeParcelas := '1';
  FResposta.DadosCartao.strQuantidadeParcelas := strQuantidadeParcelas;
  FResposta.DadosCartao.strNumeroControle     := strNumeroControle;
  FResposta.DadosCartao.strConteudoViaCliente := strConteudoViaCliente;
  FResposta.DadosCartao.strConteudoViaLojista := strConteudoViaLojista;
  FResposta.DadosCartao.strDataHoraTrans      := strDataHoraTrans;
  FResposta.DadosCartao.strChaPix             := strChaPix;
  FResposta.DadosCartao.strPixS_N             := strPixS_N;
  FResposta.DadosCartao.strCodigoCarteiraDigital := strCodigoCarteiraDigital;
  FResposta.DadosCartao.intPrimeiroVencimento := intPrimeiroVencimento ;
  FResposta.DadosCartao.intPeriodo := intPeriodo ;
  FResposta.DadosCartao.strControle := strControle ;
  FResposta.DadosCartao.strTipDeb := strTipDeb ;
  FResposta.DadosCartao.strCodigoEstabeleci := strCodigoEstabeleci;
  FResposta.DadosCartao.strPrePago := strPrePago;
  FResposta.DadosAdicionaisTefTra(objDadosAdicionaisTefTra) ;
  FResposta.Intervalos(objIntervalos);
  FResposta.DadosCartao.strParcAdm := strParcAdm ;
  FResposta.DadosCartao.strModoEntrada := strModoEntrada;
  FResposta.DadosCartao.strTipoOperacao := strTipoOperacao;
  FResposta.DadosCartao.strXIdPix := strXIdPix;
  FResposta.DadosCartao.strCampoReferenciaPix := strCampoReferenciaPix;
  FResposta.DadosCartao.strQrCodePix := strQrCodePix;
  FResposta.DadosCartao.strRequestPagamentoPix := strRequestPagamentoPix;
  FResposta.DadosCartao.strResponsePagamentoPix := strResponsePagamentoPix;
  FResposta.DadosCartao.strDadosPagamentoPix := strDadosPagamentoPix;
  FResposta.DadosCartao.strResponseDevolucaoPix := strResponseDevolucaoPix;
end;

procedure TProcessaRetornoTefCitel.ProcessarCupom(strConteudo: TStringList);
begin
  FResposta.Cupom.Text := '1'
end;

procedure TProcessaRetornoTefCitel.ProcessarStatus(strStatus,
  strMensagem: String);
begin
  FResposta.StatusTEF.strStatus   := strStatus;
  FResposta.StatusTEF.strMensagem := strMensagem;
end;

function fRetornaSomenteNumeros(const AstrValor: String): String;
var
  LintCnt: Integer ;
begin
  Result := '' ;
  for LintCnt := 1 to Length(AstrValor) do
  begin
    if CharInSet(AstrValor[LintCnt], ['0'..'9']) then
      Result := Result + AstrValor[LintCnt] ;
  end ;
end;

function fTiraCaracEspeciais(strTexto: String): String;
const
  strCaracNorm = 'aeiouaeiouaeiouaoaeiouAEIOUAEIOUAEIOUAOAEIOU';
  strCaracEsp  = 'àèìòùáéíóúâêîôûãõäëïöüÀÈÌÒÙÁÉÍÓÚÂÊÎÔÛÃÕÄËÏÖÜ';
var
  intContador: Integer;
  intPosicao: Integer;
begin
  Result := '';

  For intContador := 1 To Length(strTexto) Do
  Begin
    intPosicao := Pos(strTexto[intContador], strCaracEsp);
    If intPosicao > 0 Then
      Result := Result + strCaracNorm[intPosicao]
    Else
      Result := Result + strTexto[intContador];

  End;
end;

function fFormataMsgExcecao(const AContexto: String; E: Exception): String;
begin
  Result := Format('[%s] %s: %s', [AContexto, E.ClassName, E.Message]);
end;

{ TRetornaTipoOperacao }

class function TRetornaTipoOperacao.fGet(const AintCodigo: integer): String;
begin
  Result := '' ;
  case AintCodigo of
    2   : Result := 'D' ;
    3   : Result := 'C' ;
    122 : Result := 'D' ;
  end ;
end;

{ TInfoPinPadBuilder }

procedure TInfoPinPadBuilder.AddCampo(const ARotulo, AValor: String);
begin
  if FResult <> '' then
    FResult := FResult + ' | ';
  FResult := FResult + ARotulo + ' = ' + AValor;
end;

procedure TInfoPinPadBuilder.Reset;
begin
  FResult := '';
end;

function TInfoPinPadBuilder.ToString: String;
begin
  Result := FResult;
end;

end.
