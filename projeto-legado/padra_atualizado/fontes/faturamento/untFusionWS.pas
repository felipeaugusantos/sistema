// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://int.fusiondms.com.br/clientws/clientws.wsdl
// Version  : 1.0
// (12/06/2023 16:08:51 - - $Rev: 76228 $)
// ************************************************************************ //

unit untFusionWS;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:integer         - "http://www.w3.org/2001/XMLSchema"[]
  // !:decimal         - "http://www.w3.org/2001/XMLSchema"[]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[]


  // ************************************************************************ //
  // Namespace : urn:myInputNamespace
  // soapAction: urn:%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // use       : encoded
  // binding   : MyBinding
  // service   : FusiontrakWSService
  // port      : MyPort
  // URL       : https://int.fusiondms.com.br/clientws/clientws.php
  // ************************************************************************ //
  samplePortType = interface(IInvokable)
  ['{6095F7B8-A73F-FFB7-1997-1573AF1B3525}']
    function  getIntErp(const login: string; const senha: string; const limite_padrao: string): string; stdcall;
    function  setIntErp(const login: string; const senha: string; const int_id: string; const retorno_carga: string; const carga: string; const lista_int: string;
                        const atualizaCargaDaEntrega: string): string; stdcall;
    function  setIntErpFiliais(const login: string; const senha: string; const int_id: string; const retorno_carga: string; const carga: string; const filial: string
                               ): string; stdcall;
    function  getIntErpFilial(const login: string; const senha: string; const filial: string; const limite_padrao: string): string; stdcall;
    function  obtemDesvios(const login: string; const senha: string; const paginacao: string): string; stdcall;
    function  obtemDadosBi(const login: string; const senha: string; const array_dados: string): string; stdcall;
    function  atualizarEntregaCarga(const login: string; const senha: string; const array_dados: string): string; stdcall;
    function  sendMotoristas(const login: string; const senha: string; const array_dados: string): string; stdcall;
    function  sendEvents(const login: string; const password: string; const jsonData: string): string; stdcall;
    function  atualizaCarga(const login: string; const password: string; const jsonData: string): string; stdcall;
    function  atualizaVeiculoCarga(const login: string; const password: string; const jsonData: string): string; stdcall;
    function  cancelaCarga(const login: string; const password: string; const jsonData: string; const LimpaCargaDaEntrega: string): string; stdcall;
    function  listaCargas(const login: string; const senha: string; const data_ini: string; const data_fin: string; const status: string): string; stdcall;
    function  detalheCarga(const login: string; const senha: string; const carga: string; const sn_romaneio: string; const data_inicio: string; const data_fim: string
                           ): string; stdcall;
    function  detalheEntrega(const login: string; const senha: string; const pedido_erp: string): string; stdcall;
    function  obtemEventos(const login: string; const senha: string; const idInicial: string): string; stdcall;
    function  obtemEventosItensDevolvidos(const login: string; const senha: string; const idEvento: string): string; stdcall;
    function  savePontoReferencia(const login: string; const senha: string; const array_dados: string): string; stdcall;
    function  saveEntregaServico(const login: string; const senha: string; const array_dados: string): string; stdcall;
    function  saveNFEntrega(const login: string; const senha: string; const array_dados: string): string; stdcall;
    function  saveDiasCompensacoes(const login: string; const senha: string; const array_dados: string): string; stdcall;
    function  saveCarga(const login: string; const senha: string; const array_dados: string): string; stdcall;
    function  saveCargaEntregasInt(const login: string; const senha: string; const array_dados: string): string; stdcall;
    function  sendClientes(const login: string; const senha: string; const array_dados: string): string; stdcall;
    function  sendClientesPorRota(const login: string; const senha: string; const array_dados: string): string; stdcall;
    function  sendVeiculos(const login: string; const senha: string; const array_dados: string): string; stdcall;
    function  atualizaSituVeic(const login: string; const senha: string; const pSitu: string; const pVeic: string): string; stdcall;
    function  saveCombustivel(const login: string; const senha: string; const kilometragem: TXSDecimal; const placa: string; const litros: TXSDecimal; const valor_litro: TXSDecimal;
                              const tanque_empresa: string; const motorista: string; const tipo_abastecimento: string; const entrada_saida: string; const tanque: Int64;
                              const nome_conferente: string): string; stdcall;
    function  obtemTanquesCombustivel(const login: string; const senha: string): string; stdcall;
    function  obtemDespesas(const login: string; const senha: string; const romaneio_id: string; const periodo_inicial: string; const periodo_final: string; const motorista_codigo_erp: string;
                            const veiculo_codigo_erp: string): string; stdcall;
    function  consultarTodosVeiculos(const login: string; const senha: string; const array_dados: string): string; stdcall;
    function  consultarVeiculo(const login: string; const senha: string; const placaOuId: string): string; stdcall;
    function  atualizarVeiculo(const login: string; const senha: string; const placaOuId: string; const status: string; const km: string; const consumoMedio: string
                               ): string; stdcall;
    function  obtemAbastecimentoVeiculo(const login: string; const senha: string; const data_inicio: string; const data_fim: string): string; stdcall;
    function  obtemMediaAbastecimentoVeiculo(const login: string; const senha: string; const data_inicio: string; const data_fim: string): string; stdcall;
    function  atualizaValorAdicional(const login: string; const senha: string; const tipo_atualizacao: string; const array_dados: string): string; stdcall;
    function  atualizaSeqRomaneio(const login: string; const senha: string; const id_romaneio: string): string; stdcall;
    function  obtemTrajeto(const login: string; const senha: string; const romaneio_id: string; const tipo_pontos: string): string; stdcall;
    function  obtemEntregasNaoAtendidas(const login: string; const senha: string; const data_inicio: string; const data_fim: string; const filial_log: string): string; stdcall;
    function  marcarEntregasNaoAtendidasIntegradas(const login: string; const senha: string; const data_inicio: string; const data_fim: string; const id_justificativa_entrega: string): string; stdcall;
  end;

function GetsamplePortType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): samplePortType;


implementation
  uses System.SysUtils;

function GetsamplePortType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): samplePortType;
const
  defWSDL = 'http://int.fusiondms.com.br/clientws/clientws.wsdl';
  defURL  = 'https://int.fusiondms.com.br/clientws/clientws.php';
  defSvc  = 'FusiontrakWSService';
  defPrt  = 'MyPort';
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
    Result := (RIO as samplePortType);
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
  { samplePortType }
  InvRegistry.RegisterInterface(TypeInfo(samplePortType), 'urn:myInputNamespace', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(samplePortType), 'urn:%operationName%');

end.
