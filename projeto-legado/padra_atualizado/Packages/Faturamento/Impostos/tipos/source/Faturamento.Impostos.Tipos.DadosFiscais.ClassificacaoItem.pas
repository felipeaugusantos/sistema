unit Faturamento.Impostos.Tipos.DadosFiscais.ClassificacaoItem;

interface

uses Faturamento.Impostos.Interfaces.DadosFiscais.ClassificacaoItem, Shared.Functions.Types;

type
  TParametrosDadosFiscaisClassificacaoItem = class(TInterfacedObject, IParametrosDadosFiscaisClassificacaoItem)
  private
    FClienteEstado                                 : String;
    FInscricaoEstadual                             : String;
    FMicroEmpreendedor                             : Boolean;
    FEmpresaEstado                                 : String;
    FDocumentoDeVenda                              : Boolean;
    FDentroDoEstadoCFOP                            : Boolean;
    FAtividadeConstrutora                          : Boolean;
    FClienteConsumidorFinal                        : Boolean;
    FNotaDevolucao                                 : Boolean;
    FCfopDevolucao                                 : String;
    FOpcaoDocumento                                : String;
    FVendaPresencial 			                         : Boolean;
    FClassificacaoNotaEspiritoSanto                : String;
    FClassificacaoNfeComplemento                   : String;
    FClassificacaoFiscal2                          : String;
    FClassificacaoFiscal3                          : String;
    FConsertoDeEquipamento                         : Boolean;
    FDocumentoDeComplementoDeValores               : Boolean;
    FClienteFilialEmpresaLogada                    : Boolean;
    FNCFornecedor                                  : Boolean;
    FNfeComplementoMatrizPreenchida                : Boolean;
    FNotaDeComplementoDeClienteComplementandoValor : Boolean;
  public
    function ClienteEstado : String; overload;
    function ClienteEstado(AValue: String): IParametrosDadosFiscaisClassificacaoItem; overload;

    function InscricaoEstadual: String; overload;
    function InscricaoEstadual(AValue: String): IParametrosDadosFiscaisClassificacaoItem; overload;

    function MicroEmpreendedor: Boolean;  overload;
    function MicroEmpreendedor(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    function EmpresaEstado : String; overload;
    function EmpresaEstado(AValue: String): IParametrosDadosFiscaisClassificacaoItem; overload;

    function DocumentoDeVenda : Boolean; overload;
    function DocumentoDeVenda(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    function DentroDoEstadoCFOP : Boolean; overload;
    function DentroDoEstadoCFOP(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    function AtividadeConstrutora: Boolean; overload;
    function AtividadeConstrutora(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    function NotaDevolucao: Boolean; overload;
    function NotaDevolucao(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    function CfopDevolucao: String; overload;
    function CfopDevolucao(AValue: String): IParametrosDadosFiscaisClassificacaoItem; overload;

    function OpcaoDocumento : String; overload;
    function OpcaoDocumento(AValue: String): IParametrosDadosFiscaisClassificacaoItem; overload;

    function VendaPresencial : Boolean; overload;
    function VendaPresencial(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    function ClassificacaoNotaEspiritoSanto : String; overload;
    function ClassificacaoNotaEspiritoSanto(AValue: String): IParametrosDadosFiscaisClassificacaoItem; overload;

    function ClassificacaoNfeComplemento : String;	overload;
    function ClassificacaoNfeComplemento(AValue: String): IParametrosDadosFiscaisClassificacaoItem; overload;

    function ConsertoDeEquipamento: Boolean; overload;
    function ConsertoDeEquipamento(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    function ClassificacaoFiscal2: String;	overload;
    function ClassificacaoFiscal2(AValue: String): IParametrosDadosFiscaisClassificacaoItem; overload;

    function ClassificacaoFiscal3: String;	overload;
    function ClassificacaoFiscal3(AValue: String): IParametrosDadosFiscaisClassificacaoItem; overload;

    function DocumentoDeComplementoDeValores: Boolean; overload;
    function DocumentoDeComplementoDeValores(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    function ClienteFilialEmpresaLogada: Boolean; overload;
    function ClienteFilialEmpresaLogada(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    function NCFornecedor: Boolean; overload;
    function NCFornecedor(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    function NfeComplementoMatrizPreenchida: Boolean; overload;
    function NfeComplementoMatrizPreenchida(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    function NotaDeComplementoDeClienteComplementandoValor: Boolean; overload;
    function NotaDeComplementoDeClienteComplementandoValor(AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem; overload;

    class function New(): IParametrosDadosFiscaisClassificacaoItem;
  end;

type
  TResultadoDadosFiscaisClassificacaoItem = class(TInterfacedObject, IResultadoDadosFiscaisClassificacaoItem)
  private
	  FClassificacaoFiscal1 : String;
	  FClassificacaoFiscal2 : String;
	  FClassificacaoFiscal3 : String;
  public
    function ClassificacaoFiscal1: String; overload;
    function ClassificacaoFiscal1(AValue: String): IResultadoDadosFiscaisClassificacaoItem; overload;

    function ClassificacaoFiscal2: String; overload;
    function ClassificacaoFiscal2(AValue: String): IResultadoDadosFiscaisClassificacaoItem; overload;

    function ClassificacaoFiscal3: String; overload;
    function ClassificacaoFiscal3(AValue: String): IResultadoDadosFiscaisClassificacaoItem; overload;
	
    class function New(): IResultadoDadosFiscaisClassificacaoItem;
  end;

implementation

{ TParametrosDadosFiscaisClassificacaoItem }

function TParametrosDadosFiscaisClassificacaoItem.AtividadeConstrutora: Boolean;
begin
  Result := FAtividadeConstrutora;
end;

function TParametrosDadosFiscaisClassificacaoItem.AtividadeConstrutora(
  AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FAtividadeConstrutora := AValue;
end;

function TParametrosDadosFiscaisClassificacaoItem.CfopDevolucao: String;
begin
  Result := FCfopDevolucao;
end;

function TParametrosDadosFiscaisClassificacaoItem.CfopDevolucao(
  AValue: String): IParametrosDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FCfopDevolucao := AValue;
end;

function TParametrosDadosFiscaisClassificacaoItem.ClassificacaoFiscal2: String;
begin
  Result := FClassificacaoFiscal2;
end;

function TParametrosDadosFiscaisClassificacaoItem.ClassificacaoFiscal2(
  AValue: String): IParametrosDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FClassificacaoFiscal2 := AValue;
end;

function TParametrosDadosFiscaisClassificacaoItem.ClassificacaoFiscal3: String;
begin
  Result := FClassificacaoFiscal3;
end;

function TParametrosDadosFiscaisClassificacaoItem.ClassificacaoFiscal3(
  AValue: String): IParametrosDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FClassificacaoFiscal3 := AValue;
end;

function TParametrosDadosFiscaisClassificacaoItem.ClassificacaoNfeComplemento(
  AValue: String): IParametrosDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FClassificacaoNfeComplemento := AValue;
end;

function TParametrosDadosFiscaisClassificacaoItem.ClassificacaoNfeComplemento: String;
begin
  Result := FClassificacaoNfeComplemento;
end;

function TParametrosDadosFiscaisClassificacaoItem.ClassificacaoNotaEspiritoSanto: String;
begin
  Result := FClassificacaoNotaEspiritoSanto;
end;

function TParametrosDadosFiscaisClassificacaoItem.ClassificacaoNotaEspiritoSanto(
  AValue: String): IParametrosDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FClassificacaoNotaEspiritoSanto := AValue;
end;

function TParametrosDadosFiscaisClassificacaoItem.ClienteConsumidorFinal: Boolean;
begin
  Result := FClienteConsumidorFinal;
end;

function TParametrosDadosFiscaisClassificacaoItem.ClienteConsumidorFinal(
  AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FClienteConsumidorFinal := AValue;
end;

function TParametrosDadosFiscaisClassificacaoItem.ClienteEstado(
  AValue: String): IParametrosDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FClienteEstado := AValue;
end;

function TParametrosDadosFiscaisClassificacaoItem.ClienteEstado: String;
begin
  Result := FClienteEstado;
end;

function TParametrosDadosFiscaisClassificacaoItem.ClienteFilialEmpresaLogada: Boolean;
begin
  Result := FClienteFilialEmpresaLogada;
end;

function TParametrosDadosFiscaisClassificacaoItem.ClienteFilialEmpresaLogada(
  AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FClienteFilialEmpresaLogada := AValue;
end;

function TParametrosDadosFiscaisClassificacaoItem.ConsertoDeEquipamento: Boolean;
begin
  Result := FConsertoDeEquipamento;
end;

function TParametrosDadosFiscaisClassificacaoItem.ConsertoDeEquipamento(
  AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FConsertoDeEquipamento := AValue;
end;

function TParametrosDadosFiscaisClassificacaoItem.DentroDoEstadoCFOP: Boolean;
begin
  Result := FDentroDoEstadoCFOP;
end;

function TParametrosDadosFiscaisClassificacaoItem.DentroDoEstadoCFOP(
  AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FDentroDoEstadoCFOP := AValue;
end;

function TParametrosDadosFiscaisClassificacaoItem.DocumentoDeVenda: Boolean;
begin
  Result := FDocumentoDeVenda;
end;

function TParametrosDadosFiscaisClassificacaoItem.DocumentoDeComplementoDeValores: Boolean;
begin
  Result := FDocumentoDeComplementoDeValores;
end;

function TParametrosDadosFiscaisClassificacaoItem.DocumentoDeComplementoDeValores(
  AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FDocumentoDeComplementoDeValores := AValue;
end;

function TParametrosDadosFiscaisClassificacaoItem.DocumentoDeVenda(
  AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FDocumentoDeVenda := AValue;
end;

function TParametrosDadosFiscaisClassificacaoItem.EmpresaEstado(
 AValue: String): IParametrosDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FEmpresaEstado := AValue;
end;

function TParametrosDadosFiscaisClassificacaoItem.EmpresaEstado: String;
begin
  Result := FEmpresaEstado;
end;

function TParametrosDadosFiscaisClassificacaoItem.InscricaoEstadual(
  AValue: String): IParametrosDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FInscricaoEstadual := AValue;
end;

function TParametrosDadosFiscaisClassificacaoItem.InscricaoEstadual: String;
begin
  Result := FInscricaoEstadual;
end;

function TParametrosDadosFiscaisClassificacaoItem.MicroEmpreendedor(
  AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FMicroEmpreendedor := AValue;
end;

function TParametrosDadosFiscaisClassificacaoItem.MicroEmpreendedor: Boolean;
begin
  Result := FMicroEmpreendedor;
end;

function TParametrosDadosFiscaisClassificacaoItem.NCFornecedor: Boolean;
begin
  Result := FNCFornecedor;
end;

function TParametrosDadosFiscaisClassificacaoItem.NCFornecedor(
  AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FNCFornecedor := AValue;
end;

function TParametrosDadosFiscaisClassificacaoItem.NotaDeComplementoDeClienteComplementandoValor: Boolean;
begin
  Result := FNotaDeComplementoDeClienteComplementandoValor;
end;

function TParametrosDadosFiscaisClassificacaoItem.NotaDeComplementoDeClienteComplementandoValor(
  AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FNotaDeComplementoDeClienteComplementandoValor := AValue;
end;

class function TParametrosDadosFiscaisClassificacaoItem.New: IParametrosDadosFiscaisClassificacaoItem;
begin
  Result := Self.Create;
end;
function TParametrosDadosFiscaisClassificacaoItem.NfeComplementoMatrizPreenchida: Boolean;
begin
  Result := FNfeComplementoMatrizPreenchida;
end;

function TParametrosDadosFiscaisClassificacaoItem.NfeComplementoMatrizPreenchida(
  AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FNfeComplementoMatrizPreenchida := AValue;
end;

function TParametrosDadosFiscaisClassificacaoItem.NotaDevolucao: Boolean;
begin
  Result := FNotaDevolucao;
end;

function TParametrosDadosFiscaisClassificacaoItem.NotaDevolucao(
  AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FNotaDevolucao := AValue;
end;

function TParametrosDadosFiscaisClassificacaoItem.OpcaoDocumento: String;
begin
  Result := FOpcaoDocumento;
end;

function TParametrosDadosFiscaisClassificacaoItem.OpcaoDocumento(
  AValue: String): IParametrosDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FOpcaoDocumento := AValue;
end;

function TParametrosDadosFiscaisClassificacaoItem.VendaPresencial(
  AValue: Boolean): IParametrosDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FVendaPresencial := AValue;
end;

function TParametrosDadosFiscaisClassificacaoItem.VendaPresencial: Boolean;
begin
  Result := FVendaPresencial;
end;

{ TResultadoDadosFiscaisClassificacaoItem }


function TResultadoDadosFiscaisClassificacaoItem.ClassificacaoFiscal1: String;
begin
  REsult := FClassificacaoFiscal1;
end;

function TResultadoDadosFiscaisClassificacaoItem.ClassificacaoFiscal1(
  AValue: String): IResultadoDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FClassificacaoFiscal1 := AValue;
end;

function TResultadoDadosFiscaisClassificacaoItem.ClassificacaoFiscal2(
  AValue: String): IResultadoDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FClassificacaoFiscal2 := AValue;
end;

function TResultadoDadosFiscaisClassificacaoItem.ClassificacaoFiscal2: String;
begin
  Result := FClassificacaoFiscal2;
end;

function TResultadoDadosFiscaisClassificacaoItem.ClassificacaoFiscal3: String;
begin
  Result := FClassificacaoFiscal3;
end;

function TResultadoDadosFiscaisClassificacaoItem.ClassificacaoFiscal3(
  AValue: String): IResultadoDadosFiscaisClassificacaoItem;
begin
  Result := Self;
  FClassificacaoFiscal3 := AValue;
end;


class function TResultadoDadosFiscaisClassificacaoItem.New: IResultadoDadosFiscaisClassificacaoItem;
begin
  Result := Self.Create;
end;


end.
