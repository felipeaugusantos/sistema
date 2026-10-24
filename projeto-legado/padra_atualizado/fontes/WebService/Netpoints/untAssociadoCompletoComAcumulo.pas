// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://homolog.netpoints.com.br/ws/AssociadoCompletoComAcumulo?wsdl
//  >Import : http://homolog.netpoints.com.br/ws/AssociadoCompletoComAcumulo?wsdl>0
// Encoding : UTF-8
// Version  : 1.0
// (17/08/2016 07:56:04 - - $Rev: 76228 $)
// ************************************************************************ //

unit untAssociadoCompletoComAcumulo;

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
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:double          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:decimal         - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]

  consultaAssociadoCompletoComAcumuloRequest = class;   { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  consultaAssociadoCompletoComAcumuloResponse = class;   { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  Erro2                = class;                 { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  erro                 = class;                 { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblElm] }
  acumuloOnlineResponse = class;                { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  acumuloOnlineRequest = class;                 { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  ganheMaisRequest     = class;                 { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  ganheMaisResponse    = class;                 { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  Produto              = class;                 { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  cupomOnlineVO        = class;                 { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  consultaAssociadoCompletoResponse = class;    { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  tipoPagamentoAcumuloOnline = class;           { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }

  Array_Of_tipoPagamentoAcumuloOnline = array of tipoPagamentoAcumuloOnline;   { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblUbnd] }
  Array_Of_cupomOnlineVO = array of cupomOnlineVO;   { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblUbnd] }
  ProdutosResgate = array of Produto;           { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }


  // ************************************************************************ //
  // XML       : consultaAssociadoCompletoComAcumuloRequest, global, <complexType>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  consultaAssociadoCompletoComAcumuloRequest = class(TRemotable)
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
  public
    destructor Destroy; override;
  published
    property acumuloOnline: acumuloOnlineRequest  Index (IS_OPTN or IS_UNQL) read FacumuloOnline write SetacumuloOnline stored acumuloOnline_Specified;
    property atendente:     string                Index (IS_OPTN or IS_UNQL) read Fatendente write Setatendente stored atendente_Specified;
    property cnpj:          TXSDecimal            Index (IS_OPTN or IS_UNQL) read Fcnpj write Setcnpj stored cnpj_Specified;
    property cpf:           TXSDecimal            Index (IS_OPTN or IS_UNQL) read Fcpf write Setcpf stored cpf_Specified;
    property ganheMais:     ganheMaisRequest      Index (IS_OPTN or IS_UNQL) read FganheMais write SetganheMais stored ganheMais_Specified;
  end;



  // ************************************************************************ //
  // XML       : consultaAssociadoCompletoComAcumuloResponse, global, <complexType>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  consultaAssociadoCompletoComAcumuloResponse = class(TRemotable)
  private
    FacumuloOnline: acumuloOnlineResponse;
    FacumuloOnline_Specified: boolean;
    Ferro: Erro2;
    Ferro_Specified: boolean;
    FganheMais: ganheMaisResponse;
    FganheMais_Specified: boolean;
    FresponseAssociado: consultaAssociadoCompletoResponse;
    FresponseAssociado_Specified: boolean;
    procedure SetacumuloOnline(Index: Integer; const AacumuloOnlineResponse: acumuloOnlineResponse);
    function  acumuloOnline_Specified(Index: Integer): boolean;
    procedure Seterro(Index: Integer; const AErro2: Erro2);
    function  erro_Specified(Index: Integer): boolean;
    procedure SetganheMais(Index: Integer; const AganheMaisResponse: ganheMaisResponse);
    function  ganheMais_Specified(Index: Integer): boolean;
    procedure SetresponseAssociado(Index: Integer; const AconsultaAssociadoCompletoResponse: consultaAssociadoCompletoResponse);
    function  responseAssociado_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property acumuloOnline:     acumuloOnlineResponse              Index (IS_OPTN or IS_UNQL) read FacumuloOnline write SetacumuloOnline stored acumuloOnline_Specified;
    property erro:              Erro2                              Index (IS_OPTN or IS_UNQL) read Ferro write Seterro stored erro_Specified;
    property ganheMais:         ganheMaisResponse                  Index (IS_OPTN or IS_UNQL) read FganheMais write SetganheMais stored ganheMais_Specified;
    property responseAssociado: consultaAssociadoCompletoResponse  Index (IS_OPTN or IS_UNQL) read FresponseAssociado write SetresponseAssociado stored responseAssociado_Specified;
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
  // XML       : Produto, global, <complexType>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  Produto = class(TRemotable)
  private
    FcodigoProduto: Integer;
    FvalorPontosNPUnitario: Integer;
    FvalorUnitario: Double;
    FdescricaoProduto: string;
  published
    property codigoProduto:         Integer  Index (IS_UNQL) read FcodigoProduto write FcodigoProduto;
    property valorPontosNPUnitario: Integer  Index (IS_UNQL) read FvalorPontosNPUnitario write FvalorPontosNPUnitario;
    property valorUnitario:         Double   Index (IS_UNQL) read FvalorUnitario write FvalorUnitario;
    property descricaoProduto:      string   Index (IS_UNQL) read FdescricaoProduto write FdescricaoProduto;
  end;



  // ************************************************************************ //
  // XML       : cupomOnlineVO, global, <complexType>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  cupomOnlineVO = class(TRemotable)
  private
    FdsCodigo: string;
    FdsCodigo_Specified: boolean;
    FdsCupomFiscal: string;
    FdsCupomFiscal_Specified: boolean;
    FdsNomeExterna: string;
    FdsNomeExterna_Specified: boolean;
    FdsPremio: string;
    FdsPremio_Specified: boolean;
    FidCampanha: Integer;
    FidCampanha_Specified: boolean;
    procedure SetdsCodigo(Index: Integer; const Astring: string);
    function  dsCodigo_Specified(Index: Integer): boolean;
    procedure SetdsCupomFiscal(Index: Integer; const Astring: string);
    function  dsCupomFiscal_Specified(Index: Integer): boolean;
    procedure SetdsNomeExterna(Index: Integer; const Astring: string);
    function  dsNomeExterna_Specified(Index: Integer): boolean;
    procedure SetdsPremio(Index: Integer; const Astring: string);
    function  dsPremio_Specified(Index: Integer): boolean;
    procedure SetidCampanha(Index: Integer; const AInteger: Integer);
    function  idCampanha_Specified(Index: Integer): boolean;
  published
    property dsCodigo:      string   Index (IS_OPTN or IS_UNQL) read FdsCodigo write SetdsCodigo stored dsCodigo_Specified;
    property dsCupomFiscal: string   Index (IS_OPTN or IS_UNQL) read FdsCupomFiscal write SetdsCupomFiscal stored dsCupomFiscal_Specified;
    property dsNomeExterna: string   Index (IS_OPTN or IS_UNQL) read FdsNomeExterna write SetdsNomeExterna stored dsNomeExterna_Specified;
    property dsPremio:      string   Index (IS_OPTN or IS_UNQL) read FdsPremio write SetdsPremio stored dsPremio_Specified;
    property idCampanha:    Integer  Index (IS_OPTN or IS_UNQL) read FidCampanha write SetidCampanha stored idCampanha_Specified;
  end;



  // ************************************************************************ //
  // XML       : consultaAssociadoCompletoResponse, global, <complexType>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  consultaAssociadoCompletoResponse = class(TRemotable)
  private
    Fcpf: TXSDecimal;
    Fcpf_Specified: boolean;
    Fcuponagem: Boolean;
    Fcuponagem_Specified: boolean;
    FcuponsOnlineVO: Array_Of_cupomOnlineVO;
    FcuponsOnlineVO_Specified: boolean;
    FdataNascimento: TXSDateTime;
    FdataNascimento_Specified: boolean;
    Ferro: Erro2;
    Ferro_Specified: boolean;
    FidProposta: Integer;
    FidProposta_Specified: boolean;
    Fmensagem: string;
    Fmensagem_Specified: boolean;
    Fnome: string;
    Fnome_Specified: boolean;
    Fproduto: Produto;
    Fproduto_Specified: boolean;
    FprodutosResgate: ProdutosResgate;
    FprodutosResgate_Specified: boolean;
    FsaldoPontosNP: Integer;
    FsaldoPontosNP_Specified: boolean;
    Fstatus: Integer;
    Fstatus_Specified: boolean;
    procedure Setcpf(Index: Integer; const ATXSDecimal: TXSDecimal);
    function  cpf_Specified(Index: Integer): boolean;
    procedure Setcuponagem(Index: Integer; const ABoolean: Boolean);
    function  cuponagem_Specified(Index: Integer): boolean;
    procedure SetcuponsOnlineVO(Index: Integer; const AArray_Of_cupomOnlineVO: Array_Of_cupomOnlineVO);
    function  cuponsOnlineVO_Specified(Index: Integer): boolean;
    procedure SetdataNascimento(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  dataNascimento_Specified(Index: Integer): boolean;
    procedure Seterro(Index: Integer; const AErro2: Erro2);
    function  erro_Specified(Index: Integer): boolean;
    procedure SetidProposta(Index: Integer; const AInteger: Integer);
    function  idProposta_Specified(Index: Integer): boolean;
    procedure Setmensagem(Index: Integer; const Astring: string);
    function  mensagem_Specified(Index: Integer): boolean;
    procedure Setnome(Index: Integer; const Astring: string);
    function  nome_Specified(Index: Integer): boolean;
    procedure Setproduto(Index: Integer; const AProduto: Produto);
    function  produto_Specified(Index: Integer): boolean;
    procedure SetprodutosResgate(Index: Integer; const AProdutosResgate: ProdutosResgate);
    function  produtosResgate_Specified(Index: Integer): boolean;
    procedure SetsaldoPontosNP(Index: Integer; const AInteger: Integer);
    function  saldoPontosNP_Specified(Index: Integer): boolean;
    procedure Setstatus(Index: Integer; const AInteger: Integer);
    function  status_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property cpf:             TXSDecimal              Index (IS_OPTN or IS_UNQL) read Fcpf write Setcpf stored cpf_Specified;
    property cuponagem:       Boolean                 Index (IS_OPTN or IS_UNQL) read Fcuponagem write Setcuponagem stored cuponagem_Specified;
    property cuponsOnlineVO:  Array_Of_cupomOnlineVO  Index (IS_OPTN or IS_UNBD or IS_NLBL or IS_UNQL) read FcuponsOnlineVO write SetcuponsOnlineVO stored cuponsOnlineVO_Specified;
    property dataNascimento:  TXSDateTime             Index (IS_OPTN or IS_UNQL) read FdataNascimento write SetdataNascimento stored dataNascimento_Specified;
    property erro:            Erro2                   Index (IS_OPTN or IS_UNQL) read Ferro write Seterro stored erro_Specified;
    property idProposta:      Integer                 Index (IS_OPTN or IS_UNQL) read FidProposta write SetidProposta stored idProposta_Specified;
    property mensagem:        string                  Index (IS_OPTN or IS_UNQL) read Fmensagem write Setmensagem stored mensagem_Specified;
    property nome:            string                  Index (IS_OPTN or IS_UNQL) read Fnome write Setnome stored nome_Specified;
    property produto:         Produto                 Index (IS_OPTN or IS_UNQL) read Fproduto write Setproduto stored produto_Specified;
    property produtosResgate: ProdutosResgate         Index (IS_OPTN or IS_UNQL) read FprodutosResgate write SetprodutosResgate stored produtosResgate_Specified;
    property saldoPontosNP:   Integer                 Index (IS_OPTN or IS_UNQL) read FsaldoPontosNP write SetsaldoPontosNP stored saldoPontosNP_Specified;
    property status:          Integer                 Index (IS_OPTN or IS_UNQL) read Fstatus write Setstatus stored status_Specified;
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
  // binding   : AssociadoCompletoComAcumuloSoapBinding
  // service   : AssociadoCompletoComAcumulo
  // port      : AssociadoCompletoComAcumuloServiceEndpointImplPort
  // URL       : http://homolog.netpoints.com.br:80/ws/AssociadoCompletoComAcumulo
  // ************************************************************************ //
  AssociadoCompletoComAcumuloServiceEndpoint = interface(IInvokable)
  ['{1FFC7E51-8038-BD77-D3B7-0F84F85C3647}']
    function  consultarStatusAssociadoCompletoComAcumulo(const consultaAssociadoCompletoComAcumuloRequest: consultaAssociadoCompletoComAcumuloRequest): consultaAssociadoCompletoComAcumuloResponse; stdcall;
  end;

function GetAssociadoCompletoComAcumuloServiceEndpoint(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): AssociadoCompletoComAcumuloServiceEndpoint;


implementation
  uses System.SysUtils;

function GetAssociadoCompletoComAcumuloServiceEndpoint(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): AssociadoCompletoComAcumuloServiceEndpoint;
const
  defWSDL = 'http://homolog.netpoints.com.br/ws/AssociadoCompletoComAcumulo?wsdl';
  defURL  = 'http://homolog.netpoints.com.br:80/ws/AssociadoCompletoComAcumulo';
  defSvc  = 'AssociadoCompletoComAcumulo';
  defPrt  = 'AssociadoCompletoComAcumuloServiceEndpointImplPort';
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
    Result := (RIO as AssociadoCompletoComAcumuloServiceEndpoint);
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


destructor consultaAssociadoCompletoComAcumuloRequest.Destroy;
begin
  System.SysUtils.FreeAndNil(FacumuloOnline);
  System.SysUtils.FreeAndNil(Fcnpj);
  System.SysUtils.FreeAndNil(Fcpf);
  System.SysUtils.FreeAndNil(FganheMais);
  inherited Destroy;
end;

procedure consultaAssociadoCompletoComAcumuloRequest.SetacumuloOnline(Index: Integer; const AacumuloOnlineRequest: acumuloOnlineRequest);
begin
  FacumuloOnline := AacumuloOnlineRequest;
  FacumuloOnline_Specified := True;
end;

function consultaAssociadoCompletoComAcumuloRequest.acumuloOnline_Specified(Index: Integer): boolean;
begin
  Result := FacumuloOnline_Specified;
end;

procedure consultaAssociadoCompletoComAcumuloRequest.Setatendente(Index: Integer; const Astring: string);
begin
  Fatendente := Astring;
  Fatendente_Specified := True;
end;

function consultaAssociadoCompletoComAcumuloRequest.atendente_Specified(Index: Integer): boolean;
begin
  Result := Fatendente_Specified;
end;

procedure consultaAssociadoCompletoComAcumuloRequest.Setcnpj(Index: Integer; const ATXSDecimal: TXSDecimal);
begin
  Fcnpj := ATXSDecimal;
  Fcnpj_Specified := True;
end;

function consultaAssociadoCompletoComAcumuloRequest.cnpj_Specified(Index: Integer): boolean;
begin
  Result := Fcnpj_Specified;
end;

procedure consultaAssociadoCompletoComAcumuloRequest.Setcpf(Index: Integer; const ATXSDecimal: TXSDecimal);
begin
  Fcpf := ATXSDecimal;
  Fcpf_Specified := True;
end;

function consultaAssociadoCompletoComAcumuloRequest.cpf_Specified(Index: Integer): boolean;
begin
  Result := Fcpf_Specified;
end;

procedure consultaAssociadoCompletoComAcumuloRequest.SetganheMais(Index: Integer; const AganheMaisRequest: ganheMaisRequest);
begin
  FganheMais := AganheMaisRequest;
  FganheMais_Specified := True;
end;

function consultaAssociadoCompletoComAcumuloRequest.ganheMais_Specified(Index: Integer): boolean;
begin
  Result := FganheMais_Specified;
end;

destructor consultaAssociadoCompletoComAcumuloResponse.Destroy;
begin
  System.SysUtils.FreeAndNil(FacumuloOnline);
  System.SysUtils.FreeAndNil(Ferro);
  System.SysUtils.FreeAndNil(FganheMais);
  System.SysUtils.FreeAndNil(FresponseAssociado);
  inherited Destroy;
end;

procedure consultaAssociadoCompletoComAcumuloResponse.SetacumuloOnline(Index: Integer; const AacumuloOnlineResponse: acumuloOnlineResponse);
begin
  FacumuloOnline := AacumuloOnlineResponse;
  FacumuloOnline_Specified := True;
end;

function consultaAssociadoCompletoComAcumuloResponse.acumuloOnline_Specified(Index: Integer): boolean;
begin
  Result := FacumuloOnline_Specified;
end;

procedure consultaAssociadoCompletoComAcumuloResponse.Seterro(Index: Integer; const AErro2: Erro2);
begin
  Ferro := AErro2;
  Ferro_Specified := True;
end;

function consultaAssociadoCompletoComAcumuloResponse.erro_Specified(Index: Integer): boolean;
begin
  Result := Ferro_Specified;
end;

procedure consultaAssociadoCompletoComAcumuloResponse.SetganheMais(Index: Integer; const AganheMaisResponse: ganheMaisResponse);
begin
  FganheMais := AganheMaisResponse;
  FganheMais_Specified := True;
end;

function consultaAssociadoCompletoComAcumuloResponse.ganheMais_Specified(Index: Integer): boolean;
begin
  Result := FganheMais_Specified;
end;

procedure consultaAssociadoCompletoComAcumuloResponse.SetresponseAssociado(Index: Integer; const AconsultaAssociadoCompletoResponse: consultaAssociadoCompletoResponse);
begin
  FresponseAssociado := AconsultaAssociadoCompletoResponse;
  FresponseAssociado_Specified := True;
end;

function consultaAssociadoCompletoComAcumuloResponse.responseAssociado_Specified(Index: Integer): boolean;
begin
  Result := FresponseAssociado_Specified;
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

procedure cupomOnlineVO.SetdsCodigo(Index: Integer; const Astring: string);
begin
  FdsCodigo := Astring;
  FdsCodigo_Specified := True;
end;

function cupomOnlineVO.dsCodigo_Specified(Index: Integer): boolean;
begin
  Result := FdsCodigo_Specified;
end;

procedure cupomOnlineVO.SetdsCupomFiscal(Index: Integer; const Astring: string);
begin
  FdsCupomFiscal := Astring;
  FdsCupomFiscal_Specified := True;
end;

function cupomOnlineVO.dsCupomFiscal_Specified(Index: Integer): boolean;
begin
  Result := FdsCupomFiscal_Specified;
end;

procedure cupomOnlineVO.SetdsNomeExterna(Index: Integer; const Astring: string);
begin
  FdsNomeExterna := Astring;
  FdsNomeExterna_Specified := True;
end;

function cupomOnlineVO.dsNomeExterna_Specified(Index: Integer): boolean;
begin
  Result := FdsNomeExterna_Specified;
end;

procedure cupomOnlineVO.SetdsPremio(Index: Integer; const Astring: string);
begin
  FdsPremio := Astring;
  FdsPremio_Specified := True;
end;

function cupomOnlineVO.dsPremio_Specified(Index: Integer): boolean;
begin
  Result := FdsPremio_Specified;
end;

procedure cupomOnlineVO.SetidCampanha(Index: Integer; const AInteger: Integer);
begin
  FidCampanha := AInteger;
  FidCampanha_Specified := True;
end;

function cupomOnlineVO.idCampanha_Specified(Index: Integer): boolean;
begin
  Result := FidCampanha_Specified;
end;

destructor consultaAssociadoCompletoResponse.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FcuponsOnlineVO)-1 do
    System.SysUtils.FreeAndNil(FcuponsOnlineVO[I]);
  System.SetLength(FcuponsOnlineVO, 0);
  for I := 0 to System.Length(FprodutosResgate)-1 do
    System.SysUtils.FreeAndNil(FprodutosResgate[I]);
  System.SetLength(FprodutosResgate, 0);
  System.SysUtils.FreeAndNil(Fcpf);
  System.SysUtils.FreeAndNil(FdataNascimento);
  System.SysUtils.FreeAndNil(Ferro);
  System.SysUtils.FreeAndNil(Fproduto);
  inherited Destroy;
end;

procedure consultaAssociadoCompletoResponse.Setcpf(Index: Integer; const ATXSDecimal: TXSDecimal);
begin
  Fcpf := ATXSDecimal;
  Fcpf_Specified := True;
end;

function consultaAssociadoCompletoResponse.cpf_Specified(Index: Integer): boolean;
begin
  Result := Fcpf_Specified;
end;

procedure consultaAssociadoCompletoResponse.Setcuponagem(Index: Integer; const ABoolean: Boolean);
begin
  Fcuponagem := ABoolean;
  Fcuponagem_Specified := True;
end;

function consultaAssociadoCompletoResponse.cuponagem_Specified(Index: Integer): boolean;
begin
  Result := Fcuponagem_Specified;
end;

procedure consultaAssociadoCompletoResponse.SetcuponsOnlineVO(Index: Integer; const AArray_Of_cupomOnlineVO: Array_Of_cupomOnlineVO);
begin
  FcuponsOnlineVO := AArray_Of_cupomOnlineVO;
  FcuponsOnlineVO_Specified := True;
end;

function consultaAssociadoCompletoResponse.cuponsOnlineVO_Specified(Index: Integer): boolean;
begin
  Result := FcuponsOnlineVO_Specified;
end;

procedure consultaAssociadoCompletoResponse.SetdataNascimento(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FdataNascimento := ATXSDateTime;
  FdataNascimento_Specified := True;
end;

function consultaAssociadoCompletoResponse.dataNascimento_Specified(Index: Integer): boolean;
begin
  Result := FdataNascimento_Specified;
end;

procedure consultaAssociadoCompletoResponse.Seterro(Index: Integer; const AErro2: Erro2);
begin
  Ferro := AErro2;
  Ferro_Specified := True;
end;

function consultaAssociadoCompletoResponse.erro_Specified(Index: Integer): boolean;
begin
  Result := Ferro_Specified;
end;

procedure consultaAssociadoCompletoResponse.SetidProposta(Index: Integer; const AInteger: Integer);
begin
  FidProposta := AInteger;
  FidProposta_Specified := True;
end;

function consultaAssociadoCompletoResponse.idProposta_Specified(Index: Integer): boolean;
begin
  Result := FidProposta_Specified;
end;

procedure consultaAssociadoCompletoResponse.Setmensagem(Index: Integer; const Astring: string);
begin
  Fmensagem := Astring;
  Fmensagem_Specified := True;
end;

function consultaAssociadoCompletoResponse.mensagem_Specified(Index: Integer): boolean;
begin
  Result := Fmensagem_Specified;
end;

procedure consultaAssociadoCompletoResponse.Setnome(Index: Integer; const Astring: string);
begin
  Fnome := Astring;
  Fnome_Specified := True;
end;

function consultaAssociadoCompletoResponse.nome_Specified(Index: Integer): boolean;
begin
  Result := Fnome_Specified;
end;

procedure consultaAssociadoCompletoResponse.Setproduto(Index: Integer; const AProduto: Produto);
begin
  Fproduto := AProduto;
  Fproduto_Specified := True;
end;

function consultaAssociadoCompletoResponse.produto_Specified(Index: Integer): boolean;
begin
  Result := Fproduto_Specified;
end;

procedure consultaAssociadoCompletoResponse.SetprodutosResgate(Index: Integer; const AProdutosResgate: ProdutosResgate);
begin
  FprodutosResgate := AProdutosResgate;
  FprodutosResgate_Specified := True;
end;

function consultaAssociadoCompletoResponse.produtosResgate_Specified(Index: Integer): boolean;
begin
  Result := FprodutosResgate_Specified;
end;

procedure consultaAssociadoCompletoResponse.SetsaldoPontosNP(Index: Integer; const AInteger: Integer);
begin
  FsaldoPontosNP := AInteger;
  FsaldoPontosNP_Specified := True;
end;

function consultaAssociadoCompletoResponse.saldoPontosNP_Specified(Index: Integer): boolean;
begin
  Result := FsaldoPontosNP_Specified;
end;

procedure consultaAssociadoCompletoResponse.Setstatus(Index: Integer; const AInteger: Integer);
begin
  Fstatus := AInteger;
  Fstatus_Specified := True;
end;

function consultaAssociadoCompletoResponse.status_Specified(Index: Integer): boolean;
begin
  Result := Fstatus_Specified;
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
  { AssociadoCompletoComAcumuloServiceEndpoint }
  InvRegistry.RegisterInterface(TypeInfo(AssociadoCompletoComAcumuloServiceEndpoint), 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(AssociadoCompletoComAcumuloServiceEndpoint), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(AssociadoCompletoComAcumuloServiceEndpoint), ioDocument);
  { AssociadoCompletoComAcumuloServiceEndpoint.consultarStatusAssociadoCompletoComAcumulo }
  InvRegistry.RegisterMethodInfo(TypeInfo(AssociadoCompletoComAcumuloServiceEndpoint), 'consultarStatusAssociadoCompletoComAcumulo', '',
                                 '[ReturnName="return"]', IS_OPTN or IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(AssociadoCompletoComAcumuloServiceEndpoint), 'consultarStatusAssociadoCompletoComAcumulo', 'consultaAssociadoCompletoComAcumuloRequest', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(AssociadoCompletoComAcumuloServiceEndpoint), 'consultarStatusAssociadoCompletoComAcumulo', 'return', '',
                                '', IS_UNQL);
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_tipoPagamentoAcumuloOnline), 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'Array_Of_tipoPagamentoAcumuloOnline');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_cupomOnlineVO), 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'Array_Of_cupomOnlineVO');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ProdutosResgate), 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'ProdutosResgate');
  RemClassRegistry.RegisterXSClass(consultaAssociadoCompletoComAcumuloRequest, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'consultaAssociadoCompletoComAcumuloRequest');
  RemClassRegistry.RegisterXSClass(consultaAssociadoCompletoComAcumuloResponse, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'consultaAssociadoCompletoComAcumuloResponse');
  RemClassRegistry.RegisterXSClass(Erro2, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'Erro2', 'Erro');
  RemClassRegistry.RegisterXSClass(erro, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'erro');
  RemClassRegistry.RegisterXSClass(acumuloOnlineResponse, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'acumuloOnlineResponse');
  RemClassRegistry.RegisterXSClass(acumuloOnlineRequest, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'acumuloOnlineRequest');
  RemClassRegistry.RegisterXSClass(ganheMaisRequest, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'ganheMaisRequest');
  RemClassRegistry.RegisterXSClass(ganheMaisResponse, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'ganheMaisResponse');
  RemClassRegistry.RegisterXSClass(Produto, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'Produto');
  RemClassRegistry.RegisterXSClass(cupomOnlineVO, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'cupomOnlineVO');
  RemClassRegistry.RegisterXSClass(consultaAssociadoCompletoResponse, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'consultaAssociadoCompletoResponse');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(consultaAssociadoCompletoResponse), 'produtosResgate', '[ArrayItemName="produto"]');
  RemClassRegistry.RegisterXSClass(tipoPagamentoAcumuloOnline, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'tipoPagamentoAcumuloOnline');

end.
