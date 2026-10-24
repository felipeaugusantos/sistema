{*************************************************************************}
{* The types declared in this file were generated from data read from the*}
{* WSDL File described below:                                            *}
{* WSDL     : https://www.phdrisk.com/padrao/webservice/server.php?wsdl  *}
{*  >Import : https://www.phdrisk.com/padrao/webservice/server.php?wsdl:0*}
{* Encoding : ISO-8859-1                                                 *}
{* Version  : 1.0                                                        *}
{* (08/06/2011 08:18:21 - - $Rev: 10138 $)                               *}
{*************************************************************************}
unit untWebServerPhdrisk;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

{***************************************************************************************}
{* The following types, referred to in the WSDL document are not being represented     *} 
{* in this file. They are either aliases[@] of other types represented or were referred*} 
{* to but never[!] declared in the document. The types from the latter category        *} 
{* typically map to predefined/known XML or Borland types; however, they could also    *} 
{* indicate incorrect WSDL documents that failed to declare or import a schema type.   *} 
{* *************************************************************************************} 
{* !:string          - "http://www.w3.org/2001/XMLSchema"[]                            *} 
{*                                                                                     *} 
{* *************************************************************************************}
{* Name      : WebServer PhdriskPortType                                               *} 
{* Namespace : urn:phdrisk.web01                                                       *} 
{* soapAction: urn:phdrisk.web01#%operationName%                                       *} 
{* transport : http://schemas.xmlsoap.org/soap/http                                    *} 
{* style     : rpc                                                                     *} 
{* binding   : WebServer PhdriskBinding                                                *} 
{* service   : WebServer Phdrisk                                                       *} 
{* port      : WebServer PhdriskPort                                                   *} 
{* URL       : https://www.phdrisk.com:443/padrao/webservice/server.php                *} 
{***************************************************************************************} 
type
  WebServer_PhdriskPortType = interface(IInvokable)
  ['{46BA1418-2464-8086-9476-566311F78349}']
    function  consulta(const login: WideString; const senha: WideString; const string_: WideString): WideString; stdcall;
    function  consultaXML(const string_: WideString): WideString; stdcall;
    function  analise(const login: WideString; const senha: WideString; const string_: WideString): WideString; stdcall;
    function  analiseXML(const string_: WideString): WideString; stdcall;
    function  manutencao(const login: WideString; const senha: WideString; const string_: WideString): WideString; stdcall;
    function  cadastral(const name_: WideString): WideString; stdcall;
    function  creditoConcedido(const login: WideString; const senha: WideString; const string_: WideString): WideString; stdcall;
  end;

function GetWebServer_PhdriskPortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): WebServer_PhdriskPortType;

implementation

function GetWebServer_PhdriskPortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): WebServer_PhdriskPortType;
const
  defWSDL = 'https://www.phdrisk.com/padrao/webservice/server.php?wsdl';
  defURL  = 'https://www.phdrisk.com:443/padrao/webservice/server.php';
  defSvc  = 'WebServer Phdrisk';
  defPrt  = 'WebServer PhdriskPort';
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
    Result := (RIO as WebServer_PhdriskPortType);
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

initialization
  InvRegistry.RegisterInterface        (TypeInfo(WebServer_PhdriskPortType), 'urn:phdrisk.web01', 'ISO-8859-1', '', 'WebServer PhdriskPortType');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(WebServer_PhdriskPortType), 'urn:phdrisk.web01#%operationName%');
  InvRegistry.RegisterExternalParamName(TypeInfo(WebServer_PhdriskPortType), 'consulta', 'string_', 'string');
  InvRegistry.RegisterExternalParamName(TypeInfo(WebServer_PhdriskPortType), 'consultaXML', 'string_', 'string');
  InvRegistry.RegisterExternalParamName(TypeInfo(WebServer_PhdriskPortType), 'analise', 'string_', 'string');
  InvRegistry.RegisterExternalParamName(TypeInfo(WebServer_PhdriskPortType), 'analiseXML', 'string_', 'string');
  InvRegistry.RegisterExternalParamName(TypeInfo(WebServer_PhdriskPortType), 'manutencao', 'string_', 'string');
  InvRegistry.RegisterExternalParamName(TypeInfo(WebServer_PhdriskPortType), 'cadastral', 'name_', 'name');
  InvRegistry.RegisterExternalParamName(TypeInfo(WebServer_PhdriskPortType), 'creditoConcedido', 'string_', 'string');
end.