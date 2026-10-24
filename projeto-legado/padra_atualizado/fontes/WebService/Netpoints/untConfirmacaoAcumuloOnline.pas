// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://homolog.netpoints.com.br/ws/ConfirmacaoAcumuloOnline?wsdl
//  >Import : http://homolog.netpoints.com.br/ws/ConfirmacaoAcumuloOnline?wsdl>0
// Encoding : UTF-8
// Version  : 1.0
// (19/08/2016 18:21:56 - - $Rev: 76228 $)
// ************************************************************************ //

unit untConfirmacaoAcumuloOnline;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_NLBL = $0004;
  IS_UNQL = $0008;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:decimal         - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  acumuloOnlineConfirmacaoResponse = class;     { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  acumuloOnlineResponse = class;                { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  ganheMaisResponse    = class;                 { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  ganheMaisRequest     = class;                 { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  acumuloOnlineRequest = class;                 { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  confirmacaoAcumuloOnlineRequest = class;      { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  Erro2                = class;                 { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  erro                 = class;                 { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblElm] }
  tipoPagamentoAcumuloOnline = class;           { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }

  Array_Of_tipoPagamentoAcumuloOnline = array of tipoPagamentoAcumuloOnline;   { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblUbnd] }


  // ************************************************************************ //
  // XML       : acumuloOnlineConfirmacaoResponse, global, <complexType>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  acumuloOnlineConfirmacaoResponse = class(TRemotable)
  private
    FacumuloOnline: acumuloOnlineResponse;
    FacumuloOnline_Specified: boolean;
    Ferro: Erro2;
    Ferro_Specified: boolean;
    FganheMais: ganheMaisResponse;
    FganheMais_Specified: boolean;
    procedure SetacumuloOnline(Index: Integer; const AacumuloOnlineResponse: acumuloOnlineResponse);
    function  acumuloOnline_Specified(Index: Integer): boolean;
    procedure Seterro(Index: Integer; const AErro2: Erro2);
    function  erro_Specified(Index: Integer): boolean;
    procedure SetganheMais(Index: Integer; const AganheMaisResponse: ganheMaisResponse);
    function  ganheMais_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property acumuloOnline: acumuloOnlineResponse  Index (IS_OPTN or IS_UNQL) read FacumuloOnline write SetacumuloOnline stored acumuloOnline_Specified;
    property erro:          Erro2                  Index (IS_OPTN or IS_UNQL) read Ferro write Seterro stored erro_Specified;
    property ganheMais:     ganheMaisResponse      Index (IS_OPTN or IS_UNQL) read FganheMais write SetganheMais stored ganheMais_Specified;
  end;



  // ************************************************************************ //
  // XML       : acumuloOnlineResponse, global, <complexType>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  acumuloOnlineResponse = class(TRemotable)
  private
    Ferro: Erro2;
    Ferro_Specified: boolean;
    FqtPontos: Integer;
    FqtPontos_Specified: boolean;
    Fstatus: Integer;
    Fstatus_Specified: boolean;
    FtipoTransacao: Integer;
    FtipoTransacao_Specified: boolean;
    procedure Seterro(Index: Integer; const AErro2: Erro2);
    function  erro_Specified(Index: Integer): boolean;
    procedure SetqtPontos(Index: Integer; const AInteger: Integer);
    function  qtPontos_Specified(Index: Integer): boolean;
    procedure Setstatus(Index: Integer; const AInteger: Integer);
    function  status_Specified(Index: Integer): boolean;
    procedure SettipoTransacao(Index: Integer; const AInteger: Integer);
    function  tipoTransacao_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property erro:          Erro2    Index (IS_OPTN or IS_UNQL) read Ferro write Seterro stored erro_Specified;
    property qtPontos:      Integer  Index (IS_OPTN or IS_UNQL) read FqtPontos write SetqtPontos stored qtPontos_Specified;
    property status:        Integer  Index (IS_OPTN or IS_UNQL) read Fstatus write Setstatus stored status_Specified;
    property tipoTransacao: Integer  Index (IS_OPTN or IS_UNQL) read FtipoTransacao write SettipoTransacao stored tipoTransacao_Specified;
  end;



  // ************************************************************************ //
  // XML       : ganheMaisResponse, global, <complexType>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  ganheMaisResponse = class(TRemotable)
  private
    Ferro: Erro2;
    Ferro_Specified: boolean;
    Fstatus: Integer;
    Fstatus_Specified: boolean;
    FtipoTransicao: Integer;
    FtipoTransicao_Specified: boolean;
    procedure Seterro(Index: Integer; const AErro2: Erro2);
    function  erro_Specified(Index: Integer): boolean;
    procedure Setstatus(Index: Integer; const AInteger: Integer);
    function  status_Specified(Index: Integer): boolean;
    procedure SettipoTransicao(Index: Integer; const AInteger: Integer);
    function  tipoTransicao_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property erro:          Erro2    Index (IS_OPTN or IS_UNQL) read Ferro write Seterro stored erro_Specified;
    property status:        Integer  Index (IS_OPTN or IS_UNQL) read Fstatus write Setstatus stored status_Specified;
    property tipoTransicao: Integer  Index (IS_OPTN or IS_UNQL) read FtipoTransicao write SettipoTransicao stored tipoTransicao_Specified;
  end;



  // ************************************************************************ //
  // XML       : ganheMaisRequest, global, <complexType>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  ganheMaisRequest = class(TRemotable)
  private
    Fean: TXSDecimal;
    Fean_Specified: boolean;
    FqtPontos: Integer;
    FqtPontos_Specified: boolean;
    procedure Setean(Index: Integer; const ATXSDecimal: TXSDecimal);
    function  ean_Specified(Index: Integer): boolean;
    procedure SetqtPontos(Index: Integer; const AInteger: Integer);
    function  qtPontos_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property ean:      TXSDecimal  Index (IS_OPTN or IS_UNQL) read Fean write Setean stored ean_Specified;
    property qtPontos: Integer     Index (IS_OPTN or IS_UNQL) read FqtPontos write SetqtPontos stored qtPontos_Specified;
  end;



  // ************************************************************************ //
  // XML       : acumuloOnlineRequest, global, <complexType>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  acumuloOnlineRequest = class(TRemotable)
  private
    FdataPedido: TXSDateTime;
    FdataPedido_Specified: boolean;
    FnsuParceiro: string;
    FnsuParceiro_Specified: boolean;
    FnuPdv: string;
    FnuPdv_Specified: boolean;
    FquantCupom: Integer;
    FquantCupom_Specified: boolean;
    FtipoPagamento: Array_Of_tipoPagamentoAcumuloOnline;
    FtipoPagamento_Specified: boolean;
    FvalorTotal: TXSDecimal;
    FvalorTotal_Specified: boolean;
    procedure SetdataPedido(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  dataPedido_Specified(Index: Integer): boolean;
    procedure SetnsuParceiro(Index: Integer; const Astring: string);
    function  nsuParceiro_Specified(Index: Integer): boolean;
    procedure SetnuPdv(Index: Integer; const Astring: string);
    function  nuPdv_Specified(Index: Integer): boolean;
    procedure SetquantCupom(Index: Integer; const AInteger: Integer);
    function  quantCupom_Specified(Index: Integer): boolean;
    procedure SettipoPagamento(Index: Integer; const AArray_Of_tipoPagamentoAcumuloOnline: Array_Of_tipoPagamentoAcumuloOnline);
    function  tipoPagamento_Specified(Index: Integer): boolean;
    procedure SetvalorTotal(Index: Integer; const ATXSDecimal: TXSDecimal);
    function  valorTotal_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property dataPedido:    TXSDateTime                          Index (IS_OPTN or IS_UNQL) read FdataPedido write SetdataPedido stored dataPedido_Specified;
    property nsuParceiro:   string                               Index (IS_OPTN or IS_UNQL) read FnsuParceiro write SetnsuParceiro stored nsuParceiro_Specified;
    property nuPdv:         string                               Index (IS_OPTN or IS_UNQL) read FnuPdv write SetnuPdv stored nuPdv_Specified;
    property quantCupom:    Integer                              Index (IS_OPTN or IS_UNQL) read FquantCupom write SetquantCupom stored quantCupom_Specified;
    property tipoPagamento: Array_Of_tipoPagamentoAcumuloOnline  Index (IS_OPTN or IS_UNBD or IS_NLBL or IS_UNQL) read FtipoPagamento write SettipoPagamento stored tipoPagamento_Specified;
    property valorTotal:    TXSDecimal                           Index (IS_OPTN or IS_UNQL) read FvalorTotal write SetvalorTotal stored valorTotal_Specified;
  end;



  // ************************************************************************ //
  // XML       : confirmacaoAcumuloOnlineRequest, global, <complexType>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  confirmacaoAcumuloOnlineRequest = class(TRemotable)
  private
    FacumuloOnline: acumuloOnlineRequest;
    FacumuloOnline_Specified: boolean;
    Fatendente: string;
    Fatendente_Specified: boolean;
    Fcnpj: TXSDecimal;
    Fcnpj_Specified: boolean;
    Fcpf: TXSDecimal;
    Fcpf_Specified: boolean;
    FganheMais: ganheMaisRequest;
    FganheMais_Specified: boolean;
    FtipoTransacao: Integer;
    FtipoTransacao_Specified: boolean;
    procedure SetacumuloOnline(Index: Integer; const AacumuloOnlineRequest: acumuloOnlineRequest);
    function  acumuloOnline_Specified(Index: Integer): boolean;
    procedure Setatendente(Index: Integer; const Astring: string);
    function  atendente_Specified(Index: Integer): boolean;
    procedure Setcnpj(Index: Integer; const ATXSDecimal: TXSDecimal);
    function  cnpj_Specified(Index: Integer): boolean;
    procedure Setcpf(Index: Integer; const ATXSDecimal: TXSDecimal);
    function  cpf_Specified(Index: Integer): boolean;
    procedure SetganheMais(Index: Integer; const AganheMaisRequest: ganheMaisRequest);
    function  ganheMais_Specified(Index: Integer): boolean;
    procedure SettipoTransacao(Index: Integer; const AInteger: Integer);
    function  tipoTransacao_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property acumuloOnline: acumuloOnlineRequest  Index (IS_OPTN or IS_UNQL) read FacumuloOnline write SetacumuloOnline stored acumuloOnline_Specified;
    property atendente:     string                Index (IS_OPTN or IS_UNQL) read Fatendente write Setatendente stored atendente_Specified;
    property cnpj:          TXSDecimal            Index (IS_OPTN or IS_UNQL) read Fcnpj write Setcnpj stored cnpj_Specified;
    property cpf:           TXSDecimal            Index (IS_OPTN or IS_UNQL) read Fcpf write Setcpf stored cpf_Specified;
    property ganheMais:     ganheMaisRequest      Index (IS_OPTN or IS_UNQL) read FganheMais write SetganheMais stored ganheMais_Specified;
    property tipoTransacao: Integer               Index (IS_OPTN or IS_UNQL) read FtipoTransacao write SettipoTransacao stored tipoTransacao_Specified;
  end;



  // ************************************************************************ //
  // XML       : Erro, global, <complexType>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  Erro2 = class(TRemotable)
  private
    Fcodigo: Integer;
    Fcategoria: string;
    Fdescricao: string;
  published
    property codigo:    Integer  Index (IS_UNQL) read Fcodigo write Fcodigo;
    property categoria: string   Index (IS_UNQL) read Fcategoria write Fcategoria;
    property descricao: string   Index (IS_UNQL) read Fdescricao write Fdescricao;
  end;



  // ************************************************************************ //
  // XML       : erro, global, <element>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  erro = class(Erro2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : tipoPagamentoAcumuloOnline, global, <complexType>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  tipoPagamentoAcumuloOnline = class(TRemotable)
  private
    FcnpjPagamento: TXSDecimal;
    FcnpjPagamento_Specified: boolean;
    FidPagamento: Integer;
    FidPagamento_Specified: boolean;
    FvalorPagamento: TXSDecimal;
    FvalorPagamento_Specified: boolean;
    procedure SetcnpjPagamento(Index: Integer; const ATXSDecimal: TXSDecimal);
    function  cnpjPagamento_Specified(Index: Integer): boolean;
    procedure SetidPagamento(Index: Integer; const AInteger: Integer);
    function  idPagamento_Specified(Index: Integer): boolean;
    procedure SetvalorPagamento(Index: Integer; const ATXSDecimal: TXSDecimal);
    function  valorPagamento_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property cnpjPagamento:  TXSDecimal  Index (IS_OPTN or IS_UNQL) read FcnpjPagamento write SetcnpjPagamento stored cnpjPagamento_Specified;
    property idPagamento:    Integer     Index (IS_OPTN or IS_UNQL) read FidPagamento write SetidPagamento stored idPagamento_Specified;
    property valorPagamento: TXSDecimal  Index (IS_OPTN or IS_UNQL) read FvalorPagamento write SetvalorPagamento stored valorPagamento_Specified;
  end;


  // ************************************************************************ //
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : ConfirmacaoAcumuloOnlineSoapBinding
  // service   : ConfirmacaoAcumuloOnline
  // port      : ConfirmacaoAcumuloOnlineServiceEndpointImplPort
  // URL       : http://homolog.netpoints.com.br:80/ws/ConfirmacaoAcumuloOnline
  // ************************************************************************ //
  ConfirmacaoAcumuloOnlineServiceEndpoint = interface(IInvokable)
  ['{7E3B441D-941C-7EFC-7316-A87EB5D3382C}']
    function  confirmacaoAcumuloOnline(const confirmacaoAcumuloOnlineRequest: confirmacaoAcumuloOnlineRequest): acumuloOnlineConfirmacaoResponse; stdcall;
  end;

function GetConfirmacaoAcumuloOnlineServiceEndpoint(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ConfirmacaoAcumuloOnlineServiceEndpoint;


implementation
  uses System.SysUtils;

function GetConfirmacaoAcumuloOnlineServiceEndpoint(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): ConfirmacaoAcumuloOnlineServiceEndpoint;
const
  defWSDL = 'http://homolog.netpoints.com.br/ws/ConfirmacaoAcumuloOnline?wsdl';
  defURL  = 'http://homolog.netpoints.com.br:80/ws/ConfirmacaoAcumuloOnline';
  defSvc  = 'ConfirmacaoAcumuloOnline';
  defPrt  = 'ConfirmacaoAcumuloOnlineServiceEndpointImplPort';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as ConfirmacaoAcumuloOnlineServiceEndpoint);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


destructor acumuloOnlineConfirmacaoResponse.Destroy;
begin
  System.SysUtils.FreeAndNil(FacumuloOnline);
  System.SysUtils.FreeAndNil(Ferro);
  System.SysUtils.FreeAndNil(FganheMais);
  inherited Destroy;
end;

procedure acumuloOnlineConfirmacaoResponse.SetacumuloOnline(Index: Integer; const AacumuloOnlineResponse: acumuloOnlineResponse);
begin
  FacumuloOnline := AacumuloOnlineResponse;
  FacumuloOnline_Specified := True;
end;

function acumuloOnlineConfirmacaoResponse.acumuloOnline_Specified(Index: Integer): boolean;
begin
  Result := FacumuloOnline_Specified;
end;

procedure acumuloOnlineConfirmacaoResponse.Seterro(Index: Integer; const AErro2: Erro2);
begin
  Ferro := AErro2;
  Ferro_Specified := True;
end;

function acumuloOnlineConfirmacaoResponse.erro_Specified(Index: Integer): boolean;
begin
  Result := Ferro_Specified;
end;

procedure acumuloOnlineConfirmacaoResponse.SetganheMais(Index: Integer; const AganheMaisResponse: ganheMaisResponse);
begin
  FganheMais := AganheMaisResponse;
  FganheMais_Specified := True;
end;

function acumuloOnlineConfirmacaoResponse.ganheMais_Specified(Index: Integer): boolean;
begin
  Result := FganheMais_Specified;
end;

destructor acumuloOnlineResponse.Destroy;
begin
  System.SysUtils.FreeAndNil(Ferro);
  inherited Destroy;
end;

procedure acumuloOnlineResponse.Seterro(Index: Integer; const AErro2: Erro2);
begin
  Ferro := AErro2;
  Ferro_Specified := True;
end;

function acumuloOnlineResponse.erro_Specified(Index: Integer): boolean;
begin
  Result := Ferro_Specified;
end;

procedure acumuloOnlineResponse.SetqtPontos(Index: Integer; const AInteger: Integer);
begin
  FqtPontos := AInteger;
  FqtPontos_Specified := True;
end;

function acumuloOnlineResponse.qtPontos_Specified(Index: Integer): boolean;
begin
  Result := FqtPontos_Specified;
end;

procedure acumuloOnlineResponse.Setstatus(Index: Integer; const AInteger: Integer);
begin
  Fstatus := AInteger;
  Fstatus_Specified := True;
end;

function acumuloOnlineResponse.status_Specified(Index: Integer): boolean;
begin
  Result := Fstatus_Specified;
end;

procedure acumuloOnlineResponse.SettipoTransacao(Index: Integer; const AInteger: Integer);
begin
  FtipoTransacao := AInteger;
  FtipoTransacao_Specified := True;
end;

function acumuloOnlineResponse.tipoTransacao_Specified(Index: Integer): boolean;
begin
  Result := FtipoTransacao_Specified;
end;

destructor ganheMaisResponse.Destroy;
begin
  System.SysUtils.FreeAndNil(Ferro);
  inherited Destroy;
end;

procedure ganheMaisResponse.Seterro(Index: Integer; const AErro2: Erro2);
begin
  Ferro := AErro2;
  Ferro_Specified := True;
end;

function ganheMaisResponse.erro_Specified(Index: Integer): boolean;
begin
  Result := Ferro_Specified;
end;

procedure ganheMaisResponse.Setstatus(Index: Integer; const AInteger: Integer);
begin
  Fstatus := AInteger;
  Fstatus_Specified := True;
end;

function ganheMaisResponse.status_Specified(Index: Integer): boolean;
begin
  Result := Fstatus_Specified;
end;

procedure ganheMaisResponse.SettipoTransicao(Index: Integer; const AInteger: Integer);
begin
  FtipoTransicao := AInteger;
  FtipoTransicao_Specified := True;
end;

function ganheMaisResponse.tipoTransicao_Specified(Index: Integer): boolean;
begin
  Result := FtipoTransicao_Specified;
end;

destructor ganheMaisRequest.Destroy;
begin
  System.SysUtils.FreeAndNil(Fean);
  inherited Destroy;
end;

procedure ganheMaisRequest.Setean(Index: Integer; const ATXSDecimal: TXSDecimal);
begin
  Fean := ATXSDecimal;
  Fean_Specified := True;
end;

function ganheMaisRequest.ean_Specified(Index: Integer): boolean;
begin
  Result := Fean_Specified;
end;

procedure ganheMaisRequest.SetqtPontos(Index: Integer; const AInteger: Integer);
begin
  FqtPontos := AInteger;
  FqtPontos_Specified := True;
end;

function ganheMaisRequest.qtPontos_Specified(Index: Integer): boolean;
begin
  Result := FqtPontos_Specified;
end;

destructor acumuloOnlineRequest.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FtipoPagamento)-1 do
    System.SysUtils.FreeAndNil(FtipoPagamento[I]);
  System.SetLength(FtipoPagamento, 0);
  System.SysUtils.FreeAndNil(FdataPedido);
  System.SysUtils.FreeAndNil(FvalorTotal);
  inherited Destroy;
end;

procedure acumuloOnlineRequest.SetdataPedido(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FdataPedido := ATXSDateTime;
  FdataPedido_Specified := True;
end;

function acumuloOnlineRequest.dataPedido_Specified(Index: Integer): boolean;
begin
  Result := FdataPedido_Specified;
end;

procedure acumuloOnlineRequest.SetnsuParceiro(Index: Integer; const Astring: string);
begin
  FnsuParceiro := Astring;
  FnsuParceiro_Specified := True;
end;

function acumuloOnlineRequest.nsuParceiro_Specified(Index: Integer): boolean;
begin
  Result := FnsuParceiro_Specified;
end;

procedure acumuloOnlineRequest.SetnuPdv(Index: Integer; const Astring: string);
begin
  FnuPdv := Astring;
  FnuPdv_Specified := True;
end;

function acumuloOnlineRequest.nuPdv_Specified(Index: Integer): boolean;
begin
  Result := FnuPdv_Specified;
end;

procedure acumuloOnlineRequest.SetquantCupom(Index: Integer; const AInteger: Integer);
begin
  FquantCupom := AInteger;
  FquantCupom_Specified := True;
end;

function acumuloOnlineRequest.quantCupom_Specified(Index: Integer): boolean;
begin
  Result := FquantCupom_Specified;
end;

procedure acumuloOnlineRequest.SettipoPagamento(Index: Integer; const AArray_Of_tipoPagamentoAcumuloOnline: Array_Of_tipoPagamentoAcumuloOnline);
begin
  FtipoPagamento := AArray_Of_tipoPagamentoAcumuloOnline;
  FtipoPagamento_Specified := True;
end;

function acumuloOnlineRequest.tipoPagamento_Specified(Index: Integer): boolean;
begin
  Result := FtipoPagamento_Specified;
end;

procedure acumuloOnlineRequest.SetvalorTotal(Index: Integer; const ATXSDecimal: TXSDecimal);
begin
  FvalorTotal := ATXSDecimal;
  FvalorTotal_Specified := True;
end;

function acumuloOnlineRequest.valorTotal_Specified(Index: Integer): boolean;
begin
  Result := FvalorTotal_Specified;
end;

destructor confirmacaoAcumuloOnlineRequest.Destroy;
begin
  System.SysUtils.FreeAndNil(FacumuloOnline);
  System.SysUtils.FreeAndNil(Fcnpj);
  System.SysUtils.FreeAndNil(Fcpf);
  System.SysUtils.FreeAndNil(FganheMais);
  inherited Destroy;
end;

procedure confirmacaoAcumuloOnlineRequest.SetacumuloOnline(Index: Integer; const AacumuloOnlineRequest: acumuloOnlineRequest);
begin
  FacumuloOnline := AacumuloOnlineRequest;
  FacumuloOnline_Specified := True;
end;

function confirmacaoAcumuloOnlineRequest.acumuloOnline_Specified(Index: Integer): boolean;
begin
  Result := FacumuloOnline_Specified;
end;

procedure confirmacaoAcumuloOnlineRequest.Setatendente(Index: Integer; const Astring: string);
begin
  Fatendente := Astring;
  Fatendente_Specified := True;
end;

function confirmacaoAcumuloOnlineRequest.atendente_Specified(Index: Integer): boolean;
begin
  Result := Fatendente_Specified;
end;

procedure confirmacaoAcumuloOnlineRequest.Setcnpj(Index: Integer; const ATXSDecimal: TXSDecimal);
begin
  Fcnpj := ATXSDecimal;
  Fcnpj_Specified := True;
end;

function confirmacaoAcumuloOnlineRequest.cnpj_Specified(Index: Integer): boolean;
begin
  Result := Fcnpj_Specified;
end;

procedure confirmacaoAcumuloOnlineRequest.Setcpf(Index: Integer; const ATXSDecimal: TXSDecimal);
begin
  Fcpf := ATXSDecimal;
  Fcpf_Specified := True;
end;

function confirmacaoAcumuloOnlineRequest.cpf_Specified(Index: Integer): boolean;
begin
  Result := Fcpf_Specified;
end;

procedure confirmacaoAcumuloOnlineRequest.SetganheMais(Index: Integer; const AganheMaisRequest: ganheMaisRequest);
begin
  FganheMais := AganheMaisRequest;
  FganheMais_Specified := True;
end;

function confirmacaoAcumuloOnlineRequest.ganheMais_Specified(Index: Integer): boolean;
begin
  Result := FganheMais_Specified;
end;

procedure confirmacaoAcumuloOnlineRequest.SettipoTransacao(Index: Integer; const AInteger: Integer);
begin
  FtipoTransacao := AInteger;
  FtipoTransacao_Specified := True;
end;

function confirmacaoAcumuloOnlineRequest.tipoTransacao_Specified(Index: Integer): boolean;
begin
  Result := FtipoTransacao_Specified;
end;

destructor tipoPagamentoAcumuloOnline.Destroy;
begin
  System.SysUtils.FreeAndNil(FcnpjPagamento);
  System.SysUtils.FreeAndNil(FvalorPagamento);
  inherited Destroy;
end;

procedure tipoPagamentoAcumuloOnline.SetcnpjPagamento(Index: Integer; const ATXSDecimal: TXSDecimal);
begin
  FcnpjPagamento := ATXSDecimal;
  FcnpjPagamento_Specified := True;
end;

function tipoPagamentoAcumuloOnline.cnpjPagamento_Specified(Index: Integer): boolean;
begin
  Result := FcnpjPagamento_Specified;
end;

procedure tipoPagamentoAcumuloOnline.SetidPagamento(Index: Integer; const AInteger: Integer);
begin
  FidPagamento := AInteger;
  FidPagamento_Specified := True;
end;

function tipoPagamentoAcumuloOnline.idPagamento_Specified(Index: Integer): boolean;
begin
  Result := FidPagamento_Specified;
end;

procedure tipoPagamentoAcumuloOnline.SetvalorPagamento(Index: Integer; const ATXSDecimal: TXSDecimal);
begin
  FvalorPagamento := ATXSDecimal;
  FvalorPagamento_Specified := True;
end;

function tipoPagamentoAcumuloOnline.valorPagamento_Specified(Index: Integer): boolean;
begin
  Result := FvalorPagamento_Specified;
end;

initialization
  { ConfirmacaoAcumuloOnlineServiceEndpoint }
  InvRegistry.RegisterInterface(TypeInfo(ConfirmacaoAcumuloOnlineServiceEndpoint), 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ConfirmacaoAcumuloOnlineServiceEndpoint), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(ConfirmacaoAcumuloOnlineServiceEndpoint), ioDocument);
  { ConfirmacaoAcumuloOnlineServiceEndpoint.confirmacaoAcumuloOnline }
  InvRegistry.RegisterMethodInfo(TypeInfo(ConfirmacaoAcumuloOnlineServiceEndpoint), 'confirmacaoAcumuloOnline', '',
                                 '[ReturnName="return"]', IS_OPTN or IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(ConfirmacaoAcumuloOnlineServiceEndpoint), 'confirmacaoAcumuloOnline', 'confirmacaoAcumuloOnlineRequest', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(ConfirmacaoAcumuloOnlineServiceEndpoint), 'confirmacaoAcumuloOnline', 'return', '',
                                '', IS_UNQL);
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_tipoPagamentoAcumuloOnline), 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'Array_Of_tipoPagamentoAcumuloOnline');
  RemClassRegistry.RegisterXSClass(acumuloOnlineConfirmacaoResponse, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'acumuloOnlineConfirmacaoResponse');
  RemClassRegistry.RegisterXSClass(acumuloOnlineResponse, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'acumuloOnlineResponse');
  RemClassRegistry.RegisterXSClass(ganheMaisResponse, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'ganheMaisResponse');
  RemClassRegistry.RegisterXSClass(ganheMaisRequest, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'ganheMaisRequest');
  RemClassRegistry.RegisterXSClass(acumuloOnlineRequest, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'acumuloOnlineRequest');
  RemClassRegistry.RegisterXSClass(confirmacaoAcumuloOnlineRequest, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'confirmacaoAcumuloOnlineRequest');
  RemClassRegistry.RegisterXSClass(Erro2, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'Erro2', 'Erro');
  RemClassRegistry.RegisterXSClass(erro, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'erro');
  RemClassRegistry.RegisterXSClass(tipoPagamentoAcumuloOnline, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'tipoPagamentoAcumuloOnline');

end.