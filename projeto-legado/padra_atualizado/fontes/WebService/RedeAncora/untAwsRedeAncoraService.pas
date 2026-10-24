// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://www.redeancoraservices.com.br/homologacao/awsredeancoraservice.aspx?WSDL
//  >Import : http://www.redeancoraservices.com.br/homologacao/awsredeancoraservice.aspx?WSDL>0
// Encoding : utf-8
// Version  : 1.0
// (21/02/2020 10:40:17 - - $Rev: 76228 $)
// ************************************************************************ //

unit untAwsRedeAncoraService;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

const
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  WSRedeAncoraService_ExecuteResponse = class;   { "RedeAncoraServices"[Lit][GblElm] }
  WSRedeAncoraService_Execute = class;          { "RedeAncoraServices"[Lit][GblElm] }



  // ************************************************************************ //
  // XML       : WSRedeAncoraService.ExecuteResponse, global, <element>
  // Namespace : RedeAncoraServices
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  WSRedeAncoraService_ExecuteResponse = class(TRemotable)
  private
    FResult: string;
    FErros: string;
  public
    constructor Create; override;
  published
    property Result: string  read FResult write FResult;
    property Erros:  string  read FErros write FErros;
  end;



  // ************************************************************************ //
  // XML       : WSRedeAncoraService.Execute, global, <element>
  // Namespace : RedeAncoraServices
  // Serializtn: [xoLiteralParam]
  // Info      : Wrapper
  // ************************************************************************ //
  WSRedeAncoraService_Execute = class(TRemotable)
  private
    FIdentification: string;
    FCriterion: string;
  public
    constructor Create; override;
  published
    property Identification: string  read FIdentification write FIdentification;
    property Criterion:      string  read FCriterion write FCriterion;
  end;


  // ************************************************************************ //
  // Namespace : RedeAncoraServices
  // soapAction: RedeAncoraServicesaction/AWSREDEANCORASERVICE.Execute
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : WSRedeAncoraServiceSoapBinding
  // service   : WSRedeAncoraService
  // port      : WSRedeAncoraServiceSoapPort
  // URL       : http://www.redeancoraservices.com.br/homologacao/awsredeancoraservice.aspx
  // ************************************************************************ //
  WSRedeAncoraServiceSoapPort = interface(IInvokable)
  ['{70657A2E-333D-C263-31E1-F593BEDA4B92}']

    // Cannot unwrap: 
    //     - Input element wrapper name does not match operation's name
    //     - More than one strictly out element was found
    function  Execute(const parameters: WSRedeAncoraService_Execute): WSRedeAncoraService_ExecuteResponse; stdcall;
  end;

function GetWSRedeAncoraServiceSoapPort(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): WSRedeAncoraServiceSoapPort;


implementation
  uses System.SysUtils;

function GetWSRedeAncoraServiceSoapPort(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): WSRedeAncoraServiceSoapPort;
const
  defWSDL = 'http://www.redeancoraservices.com.br/homologacao/awsredeancoraservice.aspx?WSDL';
  defURL  = 'http://www.redeancoraservices.com.br/homologacao/awsredeancoraservice.aspx';
  defSvc  = 'WSRedeAncoraService';
  defPrt  = 'WSRedeAncoraServiceSoapPort';
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
    Result := (RIO as WSRedeAncoraServiceSoapPort);
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


constructor WSRedeAncoraService_ExecuteResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor WSRedeAncoraService_Execute.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

initialization
  { WSRedeAncoraServiceSoapPort }
  InvRegistry.RegisterInterface(TypeInfo(WSRedeAncoraServiceSoapPort), 'RedeAncoraServices', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(WSRedeAncoraServiceSoapPort), 'RedeAncoraServicesaction/AWSREDEANCORASERVICE.Execute');
  InvRegistry.RegisterInvokeOptions(TypeInfo(WSRedeAncoraServiceSoapPort), ioDocument);
  InvRegistry.RegisterInvokeOptions(TypeInfo(WSRedeAncoraServiceSoapPort), ioLiteral);
  RemClassRegistry.RegisterXSClass(WSRedeAncoraService_ExecuteResponse, 'RedeAncoraServices', 'WSRedeAncoraService_ExecuteResponse', 'WSRedeAncoraService.ExecuteResponse');
  RemClassRegistry.RegisterSerializeOptions(WSRedeAncoraService_ExecuteResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(WSRedeAncoraService_Execute, 'RedeAncoraServices', 'WSRedeAncoraService_Execute', 'WSRedeAncoraService.Execute');
  RemClassRegistry.RegisterSerializeOptions(WSRedeAncoraService_Execute, [xoLiteralParam]);

end.