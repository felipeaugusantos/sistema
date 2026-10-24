// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://homolog.netpoints.com.br/ws/AssociadoServiceEndpointImpl?wsdl
//  >Import : http://homolog.netpoints.com.br/ws/AssociadoServiceEndpointImpl?wsdl>0
// Encoding : UTF-8
// Version  : 1.0
// (15/08/2016 16:39:23 - - $Rev: 76228 $)
// ************************************************************************ //

unit untAssociadoServiceEndpointImpl;

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
  // !:long            - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:decimal         - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]

  cadastroAssociadoRequest2 = class;            { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  cadastroAssociadoRequest = class;             { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblElm] }
  consultaSenhaAssociadoRequest = class;        { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  trocaSenhaAssociadoURARequest2 = class;       { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  trocaSenhaAssociadoURARequest = class;        { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblElm] }
  consultaSenhaAssociadoResponse = class;       { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  consultaAssociadoURARequest = class;          { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  consultaAssociadoResponse2 = class;           { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  consultaAssociadoResponse = class;            { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblElm] }
  Erro2                = class;                 { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  erro                 = class;                 { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblElm] }
  cupomOnlineVO        = class;                 { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  cadastroAssociadoResponse2 = class;           { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  cadastroAssociadoResponse = class;            { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblElm] }
  trocaSenhaAssociadoURAResponse = class;       { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  consultaAssociadoRequest = class;             { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  consultaAssociadoURAResponse2 = class;        { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblCplx] }
  consultaAssociadoURAResponse = class;         { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblElm] }

  Array_Of_cupomOnlineVO = array of cupomOnlineVO;   { "http://endpoint.associadoservice.ws.netpoints.com.br/"[GblUbnd] }


  // ************************************************************************ //
  // XML       : cadastroAssociadoRequest, global, <complexType>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  cadastroAssociadoRequest2 = class(TRemotable)
  private
    Fcpf: TXSDecimal;
    Fcnpj: TXSDecimal;
    Ftelefone: TXSDecimal;
    Ftelefone_Specified: boolean;
    FdataNascimento: TXSDateTime;
    FdataNascimento_Specified: boolean;
    FfuncionarioParceiro: string;
    FfuncionarioParceiro_Specified: boolean;
    FnuComprovante: Int64;
    FnuComprovante_Specified: boolean;
    FvrProdutoParceiro: TXSDecimal;
    FvrProdutoParceiro_Specified: boolean;
    procedure Settelefone(Index: Integer; const ATXSDecimal: TXSDecimal);
    function  telefone_Specified(Index: Integer): boolean;
    procedure SetdataNascimento(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  dataNascimento_Specified(Index: Integer): boolean;
    procedure SetfuncionarioParceiro(Index: Integer; const Astring: string);
    function  funcionarioParceiro_Specified(Index: Integer): boolean;
    procedure SetnuComprovante(Index: Integer; const AInt64: Int64);
    function  nuComprovante_Specified(Index: Integer): boolean;
    procedure SetvrProdutoParceiro(Index: Integer; const ATXSDecimal: TXSDecimal);
    function  vrProdutoParceiro_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property cpf:                 TXSDecimal   Index (IS_UNQL) read Fcpf write Fcpf;
    property cnpj:                TXSDecimal   Index (IS_UNQL) read Fcnpj write Fcnpj;
    property telefone:            TXSDecimal   Index (IS_OPTN or IS_UNQL) read Ftelefone write Settelefone stored telefone_Specified;
    property dataNascimento:      TXSDateTime  Index (IS_OPTN or IS_UNQL) read FdataNascimento write SetdataNascimento stored dataNascimento_Specified;
    property funcionarioParceiro: string       Index (IS_OPTN or IS_UNQL) read FfuncionarioParceiro write SetfuncionarioParceiro stored funcionarioParceiro_Specified;
    property nuComprovante:       Int64        Index (IS_OPTN or IS_UNQL) read FnuComprovante write SetnuComprovante stored nuComprovante_Specified;
    property vrProdutoParceiro:   TXSDecimal   Index (IS_OPTN or IS_UNQL) read FvrProdutoParceiro write SetvrProdutoParceiro stored vrProdutoParceiro_Specified;
  end;



  // ************************************************************************ //
  // XML       : cadastroAssociadoRequest, global, <element>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  cadastroAssociadoRequest = class(cadastroAssociadoRequest2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : consultaSenhaAssociadoRequest, global, <complexType>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  consultaSenhaAssociadoRequest = class(TRemotable)
  private
    Fcnpj: TXSDecimal;
    Fcnpj_Specified: boolean;
    Fcpf: TXSDecimal;
    Fcpf_Specified: boolean;
    Fsenha: string;
    Fsenha_Specified: boolean;
    procedure Setcnpj(Index: Integer; const ATXSDecimal: TXSDecimal);
    function  cnpj_Specified(Index: Integer): boolean;
    procedure Setcpf(Index: Integer; const ATXSDecimal: TXSDecimal);
    function  cpf_Specified(Index: Integer): boolean;
    procedure Setsenha(Index: Integer; const Astring: string);
    function  senha_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property cnpj:  TXSDecimal  Index (IS_OPTN or IS_UNQL) read Fcnpj write Setcnpj stored cnpj_Specified;
    property cpf:   TXSDecimal  Index (IS_OPTN or IS_UNQL) read Fcpf write Setcpf stored cpf_Specified;
    property senha: string      Index (IS_OPTN or IS_UNQL) read Fsenha write Setsenha stored senha_Specified;
  end;



  // ************************************************************************ //
  // XML       : trocaSenhaAssociadoURARequest, global, <complexType>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  trocaSenhaAssociadoURARequest2 = class(TRemotable)
  private
    Fbloqueio: Boolean;
    Fcpf: TXSDecimal;
    FsufixoCelular: string;
  public
    destructor Destroy; override;
  published
    property bloqueio:      Boolean     Index (IS_UNQL) read Fbloqueio write Fbloqueio;
    property cpf:           TXSDecimal  Index (IS_UNQL) read Fcpf write Fcpf;
    property sufixoCelular: string      Index (IS_UNQL) read FsufixoCelular write FsufixoCelular;
  end;



  // ************************************************************************ //
  // XML       : trocaSenhaAssociadoURARequest, global, <element>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  trocaSenhaAssociadoURARequest = class(trocaSenhaAssociadoURARequest2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : consultaSenhaAssociadoResponse, global, <complexType>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  consultaSenhaAssociadoResponse = class(TRemotable)
  private
    Ferro: Erro2;
    Ferro_Specified: boolean;
    Fmensagem: string;
    Fmensagem_Specified: boolean;
    Fstatus: Boolean;
    Fstatus_Specified: boolean;
    procedure Seterro(Index: Integer; const AErro2: Erro2);
    function  erro_Specified(Index: Integer): boolean;
    procedure Setmensagem(Index: Integer; const Astring: string);
    function  mensagem_Specified(Index: Integer): boolean;
    procedure Setstatus(Index: Integer; const ABoolean: Boolean);
    function  status_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property erro:     Erro2    Index (IS_OPTN or IS_UNQL) read Ferro write Seterro stored erro_Specified;
    property mensagem: string   Index (IS_OPTN or IS_UNQL) read Fmensagem write Setmensagem stored mensagem_Specified;
    property status:   Boolean  Index (IS_OPTN or IS_UNQL) read Fstatus write Setstatus stored status_Specified;
  end;



  // ************************************************************************ //
  // XML       : consultaAssociadoURARequest, global, <complexType>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  consultaAssociadoURARequest = class(TRemotable)
  private
    Fcpf: TXSDecimal;
    Fcpf_Specified: boolean;
    procedure Setcpf(Index: Integer; const ATXSDecimal: TXSDecimal);
    function  cpf_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property cpf: TXSDecimal  Index (IS_OPTN or IS_UNQL) read Fcpf write Setcpf stored cpf_Specified;
  end;



  // ************************************************************************ //
  // XML       : consultaAssociadoResponse, global, <complexType>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  consultaAssociadoResponse2 = class(TRemotable)
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
    FpreAprovado: Boolean;
    FpreAprovado_Specified: boolean;
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
    procedure SetpreAprovado(Index: Integer; const ABoolean: Boolean);
    function  preAprovado_Specified(Index: Integer): boolean;
    procedure SetsaldoPontosNP(Index: Integer; const AInteger: Integer);
    function  saldoPontosNP_Specified(Index: Integer): boolean;
    procedure Setstatus(Index: Integer; const AInteger: Integer);
    function  status_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property cpf:            TXSDecimal              Index (IS_OPTN or IS_UNQL) read Fcpf write Setcpf stored cpf_Specified;
    property cuponagem:      Boolean                 Index (IS_OPTN or IS_UNQL) read Fcuponagem write Setcuponagem stored cuponagem_Specified;
    property cuponsOnlineVO: Array_Of_cupomOnlineVO  Index (IS_OPTN or IS_UNBD or IS_NLBL or IS_UNQL) read FcuponsOnlineVO write SetcuponsOnlineVO stored cuponsOnlineVO_Specified;
    property dataNascimento: TXSDateTime             Index (IS_OPTN or IS_UNQL) read FdataNascimento write SetdataNascimento stored dataNascimento_Specified;
    property erro:           Erro2                   Index (IS_OPTN or IS_UNQL) read Ferro write Seterro stored erro_Specified;
    property idProposta:     Integer                 Index (IS_OPTN or IS_UNQL) read FidProposta write SetidProposta stored idProposta_Specified;
    property mensagem:       string                  Index (IS_OPTN or IS_UNQL) read Fmensagem write Setmensagem stored mensagem_Specified;
    property nome:           string                  Index (IS_OPTN or IS_UNQL) read Fnome write Setnome stored nome_Specified;
    property preAprovado:    Boolean                 Index (IS_OPTN or IS_UNQL) read FpreAprovado write SetpreAprovado stored preAprovado_Specified;
    property saldoPontosNP:  Integer                 Index (IS_OPTN or IS_UNQL) read FsaldoPontosNP write SetsaldoPontosNP stored saldoPontosNP_Specified;
    property status:         Integer                 Index (IS_OPTN or IS_UNQL) read Fstatus write Setstatus stored status_Specified;
  end;



  // ************************************************************************ //
  // XML       : consultaAssociadoResponse, global, <element>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  consultaAssociadoResponse = class(consultaAssociadoResponse2)
  private
  published
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
  // XML       : cadastroAssociadoResponse, global, <complexType>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  cadastroAssociadoResponse2 = class(TRemotable)
  private
    Fcuponagem: Boolean;
    Fcuponagem_Specified: boolean;
    FcuponsOnlineVO: Array_Of_cupomOnlineVO;
    FcuponsOnlineVO_Specified: boolean;
    Ferro: Erro2;
    Ferro_Specified: boolean;
    Fmensagem: string;
    Fmensagem_Specified: boolean;
    Fstatus: Integer;
    Fstatus_Specified: boolean;
    procedure Setcuponagem(Index: Integer; const ABoolean: Boolean);
    function  cuponagem_Specified(Index: Integer): boolean;
    procedure SetcuponsOnlineVO(Index: Integer; const AArray_Of_cupomOnlineVO: Array_Of_cupomOnlineVO);
    function  cuponsOnlineVO_Specified(Index: Integer): boolean;
    procedure Seterro(Index: Integer; const AErro2: Erro2);
    function  erro_Specified(Index: Integer): boolean;
    procedure Setmensagem(Index: Integer; const Astring: string);
    function  mensagem_Specified(Index: Integer): boolean;
    procedure Setstatus(Index: Integer; const AInteger: Integer);
    function  status_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property cuponagem:      Boolean                 Index (IS_OPTN or IS_UNQL) read Fcuponagem write Setcuponagem stored cuponagem_Specified;
    property cuponsOnlineVO: Array_Of_cupomOnlineVO  Index (IS_OPTN or IS_UNBD or IS_NLBL or IS_UNQL) read FcuponsOnlineVO write SetcuponsOnlineVO stored cuponsOnlineVO_Specified;
    property erro:           Erro2                   Index (IS_OPTN or IS_UNQL) read Ferro write Seterro stored erro_Specified;
    property mensagem:       string                  Index (IS_OPTN or IS_UNQL) read Fmensagem write Setmensagem stored mensagem_Specified;
    property status:         Integer                 Index (IS_OPTN or IS_UNQL) read Fstatus write Setstatus stored status_Specified;
  end;



  // ************************************************************************ //
  // XML       : cadastroAssociadoResponse, global, <element>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  cadastroAssociadoResponse = class(cadastroAssociadoResponse2)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : trocaSenhaAssociadoURAResponse, global, <complexType>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  trocaSenhaAssociadoURAResponse = class(TRemotable)
  private
    Ferro: Erro2;
    Ferro_Specified: boolean;
    Fmensagem: string;
    Fmensagem_Specified: boolean;
    Fstatus: Integer;
    Fstatus_Specified: boolean;
    procedure Seterro(Index: Integer; const AErro2: Erro2);
    function  erro_Specified(Index: Integer): boolean;
    procedure Setmensagem(Index: Integer; const Astring: string);
    function  mensagem_Specified(Index: Integer): boolean;
    procedure Setstatus(Index: Integer; const AInteger: Integer);
    function  status_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property erro:     Erro2    Index (IS_OPTN or IS_UNQL) read Ferro write Seterro stored erro_Specified;
    property mensagem: string   Index (IS_OPTN or IS_UNQL) read Fmensagem write Setmensagem stored mensagem_Specified;
    property status:   Integer  Index (IS_OPTN or IS_UNQL) read Fstatus write Setstatus stored status_Specified;
  end;



  // ************************************************************************ //
  // XML       : consultaAssociadoRequest, global, <complexType>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  consultaAssociadoRequest = class(TRemotable)
  private
    Fcnpj: TXSDecimal;
    Fcnpj_Specified: boolean;
    Fcpf: TXSDecimal;
    Fcpf_Specified: boolean;
    FnuComprovante: Int64;
    FnuComprovante_Specified: boolean;
    FvrProdutoParceiro: TXSDecimal;
    FvrProdutoParceiro_Specified: boolean;
    procedure Setcnpj(Index: Integer; const ATXSDecimal: TXSDecimal);
    function  cnpj_Specified(Index: Integer): boolean;
    procedure Setcpf(Index: Integer; const ATXSDecimal: TXSDecimal);
    function  cpf_Specified(Index: Integer): boolean;
    procedure SetnuComprovante(Index: Integer; const AInt64: Int64);
    function  nuComprovante_Specified(Index: Integer): boolean;
    procedure SetvrProdutoParceiro(Index: Integer; const ATXSDecimal: TXSDecimal);
    function  vrProdutoParceiro_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property cnpj:              TXSDecimal  Index (IS_OPTN or IS_UNQL) read Fcnpj write Setcnpj stored cnpj_Specified;
    property cpf:               TXSDecimal  Index (IS_OPTN or IS_UNQL) read Fcpf write Setcpf stored cpf_Specified;
    property nuComprovante:     Int64       Index (IS_OPTN or IS_UNQL) read FnuComprovante write SetnuComprovante stored nuComprovante_Specified;
    property vrProdutoParceiro: TXSDecimal  Index (IS_OPTN or IS_UNQL) read FvrProdutoParceiro write SetvrProdutoParceiro stored vrProdutoParceiro_Specified;
  end;



  // ************************************************************************ //
  // XML       : consultaAssociadoURAResponse, global, <complexType>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  consultaAssociadoURAResponse2 = class(TRemotable)
  private
    Fcep: string;
    Fcep_Specified: boolean;
    Fcpf: TXSDecimal;
    Fcpf_Specified: boolean;
    FdataNascimento: TXSDateTime;
    FdataNascimento_Specified: boolean;
    FemailSocio: string;
    FemailSocio_Specified: boolean;
    Ferro: Erro2;
    Ferro_Specified: boolean;
    Fnome: string;
    Fnome_Specified: boolean;
    FnuDddFoneCelular1Socio: string;
    FnuDddFoneCelular1Socio_Specified: boolean;
    FnuDddFoneCelular2Socio: string;
    FnuDddFoneCelular2Socio_Specified: boolean;
    FparceiroId: Integer;
    FparceiroId_Specified: boolean;
    FsaldoPontosNP: Integer;
    FsaldoPontosNP_Specified: boolean;
    Fstatus: Integer;
    Fstatus_Specified: boolean;
    procedure Setcep(Index: Integer; const Astring: string);
    function  cep_Specified(Index: Integer): boolean;
    procedure Setcpf(Index: Integer; const ATXSDecimal: TXSDecimal);
    function  cpf_Specified(Index: Integer): boolean;
    procedure SetdataNascimento(Index: Integer; const ATXSDateTime: TXSDateTime);
    function  dataNascimento_Specified(Index: Integer): boolean;
    procedure SetemailSocio(Index: Integer; const Astring: string);
    function  emailSocio_Specified(Index: Integer): boolean;
    procedure Seterro(Index: Integer; const AErro2: Erro2);
    function  erro_Specified(Index: Integer): boolean;
    procedure Setnome(Index: Integer; const Astring: string);
    function  nome_Specified(Index: Integer): boolean;
    procedure SetnuDddFoneCelular1Socio(Index: Integer; const Astring: string);
    function  nuDddFoneCelular1Socio_Specified(Index: Integer): boolean;
    procedure SetnuDddFoneCelular2Socio(Index: Integer; const Astring: string);
    function  nuDddFoneCelular2Socio_Specified(Index: Integer): boolean;
    procedure SetparceiroId(Index: Integer; const AInteger: Integer);
    function  parceiroId_Specified(Index: Integer): boolean;
    procedure SetsaldoPontosNP(Index: Integer; const AInteger: Integer);
    function  saldoPontosNP_Specified(Index: Integer): boolean;
    procedure Setstatus(Index: Integer; const AInteger: Integer);
    function  status_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property cep:                    string       Index (IS_OPTN or IS_UNQL) read Fcep write Setcep stored cep_Specified;
    property cpf:                    TXSDecimal   Index (IS_OPTN or IS_UNQL) read Fcpf write Setcpf stored cpf_Specified;
    property dataNascimento:         TXSDateTime  Index (IS_OPTN or IS_UNQL) read FdataNascimento write SetdataNascimento stored dataNascimento_Specified;
    property emailSocio:             string       Index (IS_OPTN or IS_UNQL) read FemailSocio write SetemailSocio stored emailSocio_Specified;
    property erro:                   Erro2        Index (IS_OPTN or IS_UNQL) read Ferro write Seterro stored erro_Specified;
    property nome:                   string       Index (IS_OPTN or IS_UNQL) read Fnome write Setnome stored nome_Specified;
    property nuDddFoneCelular1Socio: string       Index (IS_OPTN or IS_UNQL) read FnuDddFoneCelular1Socio write SetnuDddFoneCelular1Socio stored nuDddFoneCelular1Socio_Specified;
    property nuDddFoneCelular2Socio: string       Index (IS_OPTN or IS_UNQL) read FnuDddFoneCelular2Socio write SetnuDddFoneCelular2Socio stored nuDddFoneCelular2Socio_Specified;
    property parceiroId:             Integer      Index (IS_OPTN or IS_UNQL) read FparceiroId write SetparceiroId stored parceiroId_Specified;
    property saldoPontosNP:          Integer      Index (IS_OPTN or IS_UNQL) read FsaldoPontosNP write SetsaldoPontosNP stored saldoPontosNP_Specified;
    property status:                 Integer      Index (IS_OPTN or IS_UNQL) read Fstatus write Setstatus stored status_Specified;
  end;



  // ************************************************************************ //
  // XML       : consultaAssociadoURAResponse, global, <element>
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // ************************************************************************ //
  consultaAssociadoURAResponse = class(consultaAssociadoURAResponse2)
  private
  published
  end;


  // ************************************************************************ //
  // Namespace : http://endpoint.associadoservice.ws.netpoints.com.br/
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : AssociadoServiceEndpointImplSoapBinding
  // service   : AssociadoServiceEndpointImpl
  // port      : AssociadoServiceEndpointImplPort
  // URL       : http://homolog.netpoints.com.br:80/ws/AssociadoServiceEndpointImpl
  // ************************************************************************ //
  AssociadoServiceEndpoint = interface(IInvokable)
  ['{8E564850-DAA5-C34C-B322-E76306C0C1DA}']
    function  cadastrarAssociado(const cadastroAssociadoRequest: cadastroAssociadoRequest2): cadastroAssociadoResponse2; stdcall;
    function  consultarStatusAssociadoURA(const consultaAssociadoURARequest: consultaAssociadoURARequest): consultaAssociadoURAResponse2; stdcall;
    function  consultarStatusAssociado(const consultaAssociadoRequest: consultaAssociadoRequest): consultaAssociadoResponse2; stdcall;
    function  consultarSenhaAssociado(const consultaSenhaAssociadoRequest: consultaSenhaAssociadoRequest): consultaSenhaAssociadoResponse; stdcall;
    function  trocarSenhaAssociadoURA(const trocaSenhaAssociadoURARequest: trocaSenhaAssociadoURARequest2): trocaSenhaAssociadoURAResponse; stdcall;
  end;

function GetAssociadoServiceEndpoint(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): AssociadoServiceEndpoint;


implementation
  uses System.SysUtils;

function GetAssociadoServiceEndpoint(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): AssociadoServiceEndpoint;
const
  defWSDL = 'http://homolog.netpoints.com.br/ws/AssociadoServiceEndpointImpl?wsdl';
  defURL  = 'http://homolog.netpoints.com.br:80/ws/AssociadoServiceEndpointImpl';
  defSvc  = 'AssociadoServiceEndpointImpl';
  defPrt  = 'AssociadoServiceEndpointImplPort';
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
    Result := (RIO as AssociadoServiceEndpoint);
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


destructor cadastroAssociadoRequest2.Destroy;
begin
  System.SysUtils.FreeAndNil(Fcpf);
  System.SysUtils.FreeAndNil(Fcnpj);
  System.SysUtils.FreeAndNil(Ftelefone);
  System.SysUtils.FreeAndNil(FdataNascimento);
  System.SysUtils.FreeAndNil(FvrProdutoParceiro);
  inherited Destroy;
end;

procedure cadastroAssociadoRequest2.Settelefone(Index: Integer; const ATXSDecimal: TXSDecimal);
begin
  Ftelefone := ATXSDecimal;
  Ftelefone_Specified := True;
end;

function cadastroAssociadoRequest2.telefone_Specified(Index: Integer): boolean;
begin
  Result := Ftelefone_Specified;
end;

procedure cadastroAssociadoRequest2.SetdataNascimento(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FdataNascimento := ATXSDateTime;
  FdataNascimento_Specified := True;
end;

function cadastroAssociadoRequest2.dataNascimento_Specified(Index: Integer): boolean;
begin
  Result := FdataNascimento_Specified;
end;

procedure cadastroAssociadoRequest2.SetfuncionarioParceiro(Index: Integer; const Astring: string);
begin
  FfuncionarioParceiro := Astring;
  FfuncionarioParceiro_Specified := True;
end;

function cadastroAssociadoRequest2.funcionarioParceiro_Specified(Index: Integer): boolean;
begin
  Result := FfuncionarioParceiro_Specified;
end;

procedure cadastroAssociadoRequest2.SetnuComprovante(Index: Integer; const AInt64: Int64);
begin
  FnuComprovante := AInt64;
  FnuComprovante_Specified := True;
end;

function cadastroAssociadoRequest2.nuComprovante_Specified(Index: Integer): boolean;
begin
  Result := FnuComprovante_Specified;
end;

procedure cadastroAssociadoRequest2.SetvrProdutoParceiro(Index: Integer; const ATXSDecimal: TXSDecimal);
begin
  FvrProdutoParceiro := ATXSDecimal;
  FvrProdutoParceiro_Specified := True;
end;

function cadastroAssociadoRequest2.vrProdutoParceiro_Specified(Index: Integer): boolean;
begin
  Result := FvrProdutoParceiro_Specified;
end;

destructor consultaSenhaAssociadoRequest.Destroy;
begin
  System.SysUtils.FreeAndNil(Fcnpj);
  System.SysUtils.FreeAndNil(Fcpf);
  inherited Destroy;
end;

procedure consultaSenhaAssociadoRequest.Setcnpj(Index: Integer; const ATXSDecimal: TXSDecimal);
begin
  Fcnpj := ATXSDecimal;
  Fcnpj_Specified := True;
end;

function consultaSenhaAssociadoRequest.cnpj_Specified(Index: Integer): boolean;
begin
  Result := Fcnpj_Specified;
end;

procedure consultaSenhaAssociadoRequest.Setcpf(Index: Integer; const ATXSDecimal: TXSDecimal);
begin
  Fcpf := ATXSDecimal;
  Fcpf_Specified := True;
end;

function consultaSenhaAssociadoRequest.cpf_Specified(Index: Integer): boolean;
begin
  Result := Fcpf_Specified;
end;

procedure consultaSenhaAssociadoRequest.Setsenha(Index: Integer; const Astring: string);
begin
  Fsenha := Astring;
  Fsenha_Specified := True;
end;

function consultaSenhaAssociadoRequest.senha_Specified(Index: Integer): boolean;
begin
  Result := Fsenha_Specified;
end;

destructor trocaSenhaAssociadoURARequest2.Destroy;
begin
  System.SysUtils.FreeAndNil(Fcpf);
  inherited Destroy;
end;

destructor consultaSenhaAssociadoResponse.Destroy;
begin
  System.SysUtils.FreeAndNil(Ferro);
  inherited Destroy;
end;

procedure consultaSenhaAssociadoResponse.Seterro(Index: Integer; const AErro2: Erro2);
begin
  Ferro := AErro2;
  Ferro_Specified := True;
end;

function consultaSenhaAssociadoResponse.erro_Specified(Index: Integer): boolean;
begin
  Result := Ferro_Specified;
end;

procedure consultaSenhaAssociadoResponse.Setmensagem(Index: Integer; const Astring: string);
begin
  Fmensagem := Astring;
  Fmensagem_Specified := True;
end;

function consultaSenhaAssociadoResponse.mensagem_Specified(Index: Integer): boolean;
begin
  Result := Fmensagem_Specified;
end;

procedure consultaSenhaAssociadoResponse.Setstatus(Index: Integer; const ABoolean: Boolean);
begin
  Fstatus := ABoolean;
  Fstatus_Specified := True;
end;

function consultaSenhaAssociadoResponse.status_Specified(Index: Integer): boolean;
begin
  Result := Fstatus_Specified;
end;

destructor consultaAssociadoURARequest.Destroy;
begin
  System.SysUtils.FreeAndNil(Fcpf);
  inherited Destroy;
end;

procedure consultaAssociadoURARequest.Setcpf(Index: Integer; const ATXSDecimal: TXSDecimal);
begin
  Fcpf := ATXSDecimal;
  Fcpf_Specified := True;
end;

function consultaAssociadoURARequest.cpf_Specified(Index: Integer): boolean;
begin
  Result := Fcpf_Specified;
end;

destructor consultaAssociadoResponse2.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FcuponsOnlineVO)-1 do
    System.SysUtils.FreeAndNil(FcuponsOnlineVO[I]);
  System.SetLength(FcuponsOnlineVO, 0);
  System.SysUtils.FreeAndNil(Fcpf);
  System.SysUtils.FreeAndNil(FdataNascimento);
  System.SysUtils.FreeAndNil(Ferro);
  inherited Destroy;
end;

procedure consultaAssociadoResponse2.Setcpf(Index: Integer; const ATXSDecimal: TXSDecimal);
begin
  Fcpf := ATXSDecimal;
  Fcpf_Specified := True;
end;

function consultaAssociadoResponse2.cpf_Specified(Index: Integer): boolean;
begin
  Result := Fcpf_Specified;
end;

procedure consultaAssociadoResponse2.Setcuponagem(Index: Integer; const ABoolean: Boolean);
begin
  Fcuponagem := ABoolean;
  Fcuponagem_Specified := True;
end;

function consultaAssociadoResponse2.cuponagem_Specified(Index: Integer): boolean;
begin
  Result := Fcuponagem_Specified;
end;

procedure consultaAssociadoResponse2.SetcuponsOnlineVO(Index: Integer; const AArray_Of_cupomOnlineVO: Array_Of_cupomOnlineVO);
begin
  FcuponsOnlineVO := AArray_Of_cupomOnlineVO;
  FcuponsOnlineVO_Specified := True;
end;

function consultaAssociadoResponse2.cuponsOnlineVO_Specified(Index: Integer): boolean;
begin
  Result := FcuponsOnlineVO_Specified;
end;

procedure consultaAssociadoResponse2.SetdataNascimento(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FdataNascimento := ATXSDateTime;
  FdataNascimento_Specified := True;
end;

function consultaAssociadoResponse2.dataNascimento_Specified(Index: Integer): boolean;
begin
  Result := FdataNascimento_Specified;
end;

procedure consultaAssociadoResponse2.Seterro(Index: Integer; const AErro2: Erro2);
begin
  Ferro := AErro2;
  Ferro_Specified := True;
end;

function consultaAssociadoResponse2.erro_Specified(Index: Integer): boolean;
begin
  Result := Ferro_Specified;
end;

procedure consultaAssociadoResponse2.SetidProposta(Index: Integer; const AInteger: Integer);
begin
  FidProposta := AInteger;
  FidProposta_Specified := True;
end;

function consultaAssociadoResponse2.idProposta_Specified(Index: Integer): boolean;
begin
  Result := FidProposta_Specified;
end;

procedure consultaAssociadoResponse2.Setmensagem(Index: Integer; const Astring: string);
begin
  Fmensagem := Astring;
  Fmensagem_Specified := True;
end;

function consultaAssociadoResponse2.mensagem_Specified(Index: Integer): boolean;
begin
  Result := Fmensagem_Specified;
end;

procedure consultaAssociadoResponse2.Setnome(Index: Integer; const Astring: string);
begin
  Fnome := Astring;
  Fnome_Specified := True;
end;

function consultaAssociadoResponse2.nome_Specified(Index: Integer): boolean;
begin
  Result := Fnome_Specified;
end;

procedure consultaAssociadoResponse2.SetpreAprovado(Index: Integer; const ABoolean: Boolean);
begin
  FpreAprovado := ABoolean;
  FpreAprovado_Specified := True;
end;

function consultaAssociadoResponse2.preAprovado_Specified(Index: Integer): boolean;
begin
  Result := FpreAprovado_Specified;
end;

procedure consultaAssociadoResponse2.SetsaldoPontosNP(Index: Integer; const AInteger: Integer);
begin
  FsaldoPontosNP := AInteger;
  FsaldoPontosNP_Specified := True;
end;

function consultaAssociadoResponse2.saldoPontosNP_Specified(Index: Integer): boolean;
begin
  Result := FsaldoPontosNP_Specified;
end;

procedure consultaAssociadoResponse2.Setstatus(Index: Integer; const AInteger: Integer);
begin
  Fstatus := AInteger;
  Fstatus_Specified := True;
end;

function consultaAssociadoResponse2.status_Specified(Index: Integer): boolean;
begin
  Result := Fstatus_Specified;
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

destructor cadastroAssociadoResponse2.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(FcuponsOnlineVO)-1 do
    System.SysUtils.FreeAndNil(FcuponsOnlineVO[I]);
  System.SetLength(FcuponsOnlineVO, 0);
  System.SysUtils.FreeAndNil(Ferro);
  inherited Destroy;
end;

procedure cadastroAssociadoResponse2.Setcuponagem(Index: Integer; const ABoolean: Boolean);
begin
  Fcuponagem := ABoolean;
  Fcuponagem_Specified := True;
end;

function cadastroAssociadoResponse2.cuponagem_Specified(Index: Integer): boolean;
begin
  Result := Fcuponagem_Specified;
end;

procedure cadastroAssociadoResponse2.SetcuponsOnlineVO(Index: Integer; const AArray_Of_cupomOnlineVO: Array_Of_cupomOnlineVO);
begin
  FcuponsOnlineVO := AArray_Of_cupomOnlineVO;
  FcuponsOnlineVO_Specified := True;
end;

function cadastroAssociadoResponse2.cuponsOnlineVO_Specified(Index: Integer): boolean;
begin
  Result := FcuponsOnlineVO_Specified;
end;

procedure cadastroAssociadoResponse2.Seterro(Index: Integer; const AErro2: Erro2);
begin
  Ferro := AErro2;
  Ferro_Specified := True;
end;

function cadastroAssociadoResponse2.erro_Specified(Index: Integer): boolean;
begin
  Result := Ferro_Specified;
end;

procedure cadastroAssociadoResponse2.Setmensagem(Index: Integer; const Astring: string);
begin
  Fmensagem := Astring;
  Fmensagem_Specified := True;
end;

function cadastroAssociadoResponse2.mensagem_Specified(Index: Integer): boolean;
begin
  Result := Fmensagem_Specified;
end;

procedure cadastroAssociadoResponse2.Setstatus(Index: Integer; const AInteger: Integer);
begin
  Fstatus := AInteger;
  Fstatus_Specified := True;
end;

function cadastroAssociadoResponse2.status_Specified(Index: Integer): boolean;
begin
  Result := Fstatus_Specified;
end;

destructor trocaSenhaAssociadoURAResponse.Destroy;
begin
  System.SysUtils.FreeAndNil(Ferro);
  inherited Destroy;
end;

procedure trocaSenhaAssociadoURAResponse.Seterro(Index: Integer; const AErro2: Erro2);
begin
  Ferro := AErro2;
  Ferro_Specified := True;
end;

function trocaSenhaAssociadoURAResponse.erro_Specified(Index: Integer): boolean;
begin
  Result := Ferro_Specified;
end;

procedure trocaSenhaAssociadoURAResponse.Setmensagem(Index: Integer; const Astring: string);
begin
  Fmensagem := Astring;
  Fmensagem_Specified := True;
end;

function trocaSenhaAssociadoURAResponse.mensagem_Specified(Index: Integer): boolean;
begin
  Result := Fmensagem_Specified;
end;

procedure trocaSenhaAssociadoURAResponse.Setstatus(Index: Integer; const AInteger: Integer);
begin
  Fstatus := AInteger;
  Fstatus_Specified := True;
end;

function trocaSenhaAssociadoURAResponse.status_Specified(Index: Integer): boolean;
begin
  Result := Fstatus_Specified;
end;

destructor consultaAssociadoRequest.Destroy;
begin
  System.SysUtils.FreeAndNil(Fcnpj);
  System.SysUtils.FreeAndNil(Fcpf);
  System.SysUtils.FreeAndNil(FvrProdutoParceiro);
  inherited Destroy;
end;

procedure consultaAssociadoRequest.Setcnpj(Index: Integer; const ATXSDecimal: TXSDecimal);
begin
  Fcnpj := ATXSDecimal;
  Fcnpj_Specified := True;
end;

function consultaAssociadoRequest.cnpj_Specified(Index: Integer): boolean;
begin
  Result := Fcnpj_Specified;
end;

procedure consultaAssociadoRequest.Setcpf(Index: Integer; const ATXSDecimal: TXSDecimal);
begin
  Fcpf := ATXSDecimal;
  Fcpf_Specified := True;
end;

function consultaAssociadoRequest.cpf_Specified(Index: Integer): boolean;
begin
  Result := Fcpf_Specified;
end;

procedure consultaAssociadoRequest.SetnuComprovante(Index: Integer; const AInt64: Int64);
begin
  FnuComprovante := AInt64;
  FnuComprovante_Specified := True;
end;

function consultaAssociadoRequest.nuComprovante_Specified(Index: Integer): boolean;
begin
  Result := FnuComprovante_Specified;
end;

procedure consultaAssociadoRequest.SetvrProdutoParceiro(Index: Integer; const ATXSDecimal: TXSDecimal);
begin
  FvrProdutoParceiro := ATXSDecimal;
  FvrProdutoParceiro_Specified := True;
end;

function consultaAssociadoRequest.vrProdutoParceiro_Specified(Index: Integer): boolean;
begin
  Result := FvrProdutoParceiro_Specified;
end;

destructor consultaAssociadoURAResponse2.Destroy;
begin
  System.SysUtils.FreeAndNil(Fcpf);
  System.SysUtils.FreeAndNil(FdataNascimento);
  System.SysUtils.FreeAndNil(Ferro);
  inherited Destroy;
end;

procedure consultaAssociadoURAResponse2.Setcep(Index: Integer; const Astring: string);
begin
  Fcep := Astring;
  Fcep_Specified := True;
end;

function consultaAssociadoURAResponse2.cep_Specified(Index: Integer): boolean;
begin
  Result := Fcep_Specified;
end;

procedure consultaAssociadoURAResponse2.Setcpf(Index: Integer; const ATXSDecimal: TXSDecimal);
begin
  Fcpf := ATXSDecimal;
  Fcpf_Specified := True;
end;

function consultaAssociadoURAResponse2.cpf_Specified(Index: Integer): boolean;
begin
  Result := Fcpf_Specified;
end;

procedure consultaAssociadoURAResponse2.SetdataNascimento(Index: Integer; const ATXSDateTime: TXSDateTime);
begin
  FdataNascimento := ATXSDateTime;
  FdataNascimento_Specified := True;
end;

function consultaAssociadoURAResponse2.dataNascimento_Specified(Index: Integer): boolean;
begin
  Result := FdataNascimento_Specified;
end;

procedure consultaAssociadoURAResponse2.SetemailSocio(Index: Integer; const Astring: string);
begin
  FemailSocio := Astring;
  FemailSocio_Specified := True;
end;

function consultaAssociadoURAResponse2.emailSocio_Specified(Index: Integer): boolean;
begin
  Result := FemailSocio_Specified;
end;

procedure consultaAssociadoURAResponse2.Seterro(Index: Integer; const AErro2: Erro2);
begin
  Ferro := AErro2;
  Ferro_Specified := True;
end;

function consultaAssociadoURAResponse2.erro_Specified(Index: Integer): boolean;
begin
  Result := Ferro_Specified;
end;

procedure consultaAssociadoURAResponse2.Setnome(Index: Integer; const Astring: string);
begin
  Fnome := Astring;
  Fnome_Specified := True;
end;

function consultaAssociadoURAResponse2.nome_Specified(Index: Integer): boolean;
begin
  Result := Fnome_Specified;
end;

procedure consultaAssociadoURAResponse2.SetnuDddFoneCelular1Socio(Index: Integer; const Astring: string);
begin
  FnuDddFoneCelular1Socio := Astring;
  FnuDddFoneCelular1Socio_Specified := True;
end;

function consultaAssociadoURAResponse2.nuDddFoneCelular1Socio_Specified(Index: Integer): boolean;
begin
  Result := FnuDddFoneCelular1Socio_Specified;
end;

procedure consultaAssociadoURAResponse2.SetnuDddFoneCelular2Socio(Index: Integer; const Astring: string);
begin
  FnuDddFoneCelular2Socio := Astring;
  FnuDddFoneCelular2Socio_Specified := True;
end;

function consultaAssociadoURAResponse2.nuDddFoneCelular2Socio_Specified(Index: Integer): boolean;
begin
  Result := FnuDddFoneCelular2Socio_Specified;
end;

procedure consultaAssociadoURAResponse2.SetparceiroId(Index: Integer; const AInteger: Integer);
begin
  FparceiroId := AInteger;
  FparceiroId_Specified := True;
end;

function consultaAssociadoURAResponse2.parceiroId_Specified(Index: Integer): boolean;
begin
  Result := FparceiroId_Specified;
end;

procedure consultaAssociadoURAResponse2.SetsaldoPontosNP(Index: Integer; const AInteger: Integer);
begin
  FsaldoPontosNP := AInteger;
  FsaldoPontosNP_Specified := True;
end;

function consultaAssociadoURAResponse2.saldoPontosNP_Specified(Index: Integer): boolean;
begin
  Result := FsaldoPontosNP_Specified;
end;

procedure consultaAssociadoURAResponse2.Setstatus(Index: Integer; const AInteger: Integer);
begin
  Fstatus := AInteger;
  Fstatus_Specified := True;
end;

function consultaAssociadoURAResponse2.status_Specified(Index: Integer): boolean;
begin
  Result := Fstatus_Specified;
end;

initialization
  { AssociadoServiceEndpoint }
  InvRegistry.RegisterInterface(TypeInfo(AssociadoServiceEndpoint), 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(AssociadoServiceEndpoint), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(AssociadoServiceEndpoint), ioDocument);
  { AssociadoServiceEndpoint.cadastrarAssociado }
  InvRegistry.RegisterMethodInfo(TypeInfo(AssociadoServiceEndpoint), 'cadastrarAssociado', '',
                                 '[ReturnName="return"]', IS_OPTN or IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(AssociadoServiceEndpoint), 'cadastrarAssociado', 'cadastroAssociadoRequest', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(AssociadoServiceEndpoint), 'cadastrarAssociado', 'return', '',
                                '', IS_UNQL);
  { AssociadoServiceEndpoint.consultarStatusAssociadoURA }
  InvRegistry.RegisterMethodInfo(TypeInfo(AssociadoServiceEndpoint), 'consultarStatusAssociadoURA', '',
                                 '[ReturnName="return"]', IS_OPTN or IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(AssociadoServiceEndpoint), 'consultarStatusAssociadoURA', 'consultaAssociadoURARequest', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(AssociadoServiceEndpoint), 'consultarStatusAssociadoURA', 'return', '',
                                '', IS_UNQL);
  { AssociadoServiceEndpoint.consultarStatusAssociado }
  InvRegistry.RegisterMethodInfo(TypeInfo(AssociadoServiceEndpoint), 'consultarStatusAssociado', '',
                                 '[ReturnName="return"]', IS_OPTN or IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(AssociadoServiceEndpoint), 'consultarStatusAssociado', 'consultaAssociadoRequest', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(AssociadoServiceEndpoint), 'consultarStatusAssociado', 'return', '',
                                '', IS_UNQL);
  { AssociadoServiceEndpoint.consultarSenhaAssociado }
  InvRegistry.RegisterMethodInfo(TypeInfo(AssociadoServiceEndpoint), 'consultarSenhaAssociado', '',
                                 '[ReturnName="return"]', IS_OPTN or IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(AssociadoServiceEndpoint), 'consultarSenhaAssociado', 'consultaSenhaAssociadoRequest', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(AssociadoServiceEndpoint), 'consultarSenhaAssociado', 'return', '',
                                '', IS_UNQL);
  { AssociadoServiceEndpoint.trocarSenhaAssociadoURA }
  InvRegistry.RegisterMethodInfo(TypeInfo(AssociadoServiceEndpoint), 'trocarSenhaAssociadoURA', '',
                                 '[ReturnName="return"]', IS_OPTN or IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(AssociadoServiceEndpoint), 'trocarSenhaAssociadoURA', 'trocaSenhaAssociadoURARequest', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(AssociadoServiceEndpoint), 'trocarSenhaAssociadoURA', 'return', '',
                                '', IS_UNQL);
  RemClassRegistry.RegisterXSInfo(TypeInfo(Array_Of_cupomOnlineVO), 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'Array_Of_cupomOnlineVO');
  RemClassRegistry.RegisterXSClass(cadastroAssociadoRequest2, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'cadastroAssociadoRequest2', 'cadastroAssociadoRequest');
  RemClassRegistry.RegisterXSClass(cadastroAssociadoRequest, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'cadastroAssociadoRequest');
  RemClassRegistry.RegisterXSClass(consultaSenhaAssociadoRequest, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'consultaSenhaAssociadoRequest');
  RemClassRegistry.RegisterXSClass(trocaSenhaAssociadoURARequest2, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'trocaSenhaAssociadoURARequest2', 'trocaSenhaAssociadoURARequest');
  RemClassRegistry.RegisterXSClass(trocaSenhaAssociadoURARequest, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'trocaSenhaAssociadoURARequest');
  RemClassRegistry.RegisterXSClass(consultaSenhaAssociadoResponse, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'consultaSenhaAssociadoResponse');
  RemClassRegistry.RegisterXSClass(consultaAssociadoURARequest, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'consultaAssociadoURARequest');
  RemClassRegistry.RegisterXSClass(consultaAssociadoResponse2, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'consultaAssociadoResponse2', 'consultaAssociadoResponse');
  RemClassRegistry.RegisterXSClass(consultaAssociadoResponse, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'consultaAssociadoResponse');
  RemClassRegistry.RegisterXSClass(Erro2, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'Erro2', 'Erro');
  RemClassRegistry.RegisterXSClass(erro, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'erro');
  RemClassRegistry.RegisterXSClass(cupomOnlineVO, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'cupomOnlineVO');
  RemClassRegistry.RegisterXSClass(cadastroAssociadoResponse2, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'cadastroAssociadoResponse2', 'cadastroAssociadoResponse');
  RemClassRegistry.RegisterXSClass(cadastroAssociadoResponse, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'cadastroAssociadoResponse');
  RemClassRegistry.RegisterXSClass(trocaSenhaAssociadoURAResponse, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'trocaSenhaAssociadoURAResponse');
  RemClassRegistry.RegisterXSClass(consultaAssociadoRequest, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'consultaAssociadoRequest');
  RemClassRegistry.RegisterXSClass(consultaAssociadoURAResponse2, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'consultaAssociadoURAResponse2', 'consultaAssociadoURAResponse');
  RemClassRegistry.RegisterXSClass(consultaAssociadoURAResponse, 'http://endpoint.associadoservice.ws.netpoints.com.br/', 'consultaAssociadoURAResponse');

end.