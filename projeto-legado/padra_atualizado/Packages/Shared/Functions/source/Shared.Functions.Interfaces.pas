unit Shared.Functions.Interfaces;

interface

uses Shared.Functions.Types;

type
  IResultadoDesmembrarSelectParaCampoTabela = interface
    ['{35F0B8BC-BB69-4A86-A9E9-374B62E5F4E1}']

    function CamposSelect: ArrOfString; overload;
    function CamposSelect(AValue: ArrOfString): IResultadoDesmembrarSelectParaCampoTabela; overload;

    function NomeTabela: String; overload;
    function NomeTabela(AValue: String): IResultadoDesmembrarSelectParaCampoTabela; overload;

    function CampoChave: ArrOfString; overload;
    function CampoChave(AValue: ArrOfString): IResultadoDesmembrarSelectParaCampoTabela; overload;
  end;

  IParametrosCalculoPreComMenosDescForn = interface
    ['{90D9D012-055E-41B0-A18B-E643896B55CB}']

    function PrecoDeUltimaCompra: Double; overload;
    function PrecoDeUltimaCompra(AValue: Double): IParametrosCalculoPreComMenosDescForn; overload;

    function PrecoDeCompra: Double; overload;
    function PrecoDeCompra(AValue: Double): IParametrosCalculoPreComMenosDescForn; overload;

    function Desconto01: Double; overload;
    function Desconto01(AValue: Double): IParametrosCalculoPreComMenosDescForn; overload;

    function Desconto02: Double; overload;
    function Desconto02(AValue: Double): IParametrosCalculoPreComMenosDescForn; overload;

    function Desconto03: Double; overload;
    function Desconto03(AValue: Double): IParametrosCalculoPreComMenosDescForn; overload;

    function Desconto04: Double; overload;
    function Desconto04(AValue: Double): IParametrosCalculoPreComMenosDescForn; overload;

    function Desconto05: Double; overload;
    function Desconto05(AValue: Double): IParametrosCalculoPreComMenosDescForn; overload;

    function Desconto06: Double; overload;
    function Desconto06(AValue: Double): IParametrosCalculoPreComMenosDescForn; overload;

    function CalculoSubstituicaoOperacoesProprias: String; overload;
    function CalculoSubstituicaoOperacoesProprias(AValue: String): IParametrosCalculoPreComMenosDescForn; overload;
  end;

  IParametrosDecodificaChaveNota = Interface
    ['{9D027DE7-A95C-4525-A592-B6D38AEC58CE}']
    Function Chave : String; Overload;
    Function Chave(AValue : String) :IParametrosDecodificaChaveNota ; Overload;

    Function TamanhoCampoDocumento: Integer; Overload;
    Function TamanhoCampoDocumento(AValue : Integer) :IParametrosDecodificaChaveNota ; Overload;

  End;

  IResultadoDecodificaChaveNota = Interface
    ['{351916A1-9ED9-4F3A-9BE6-D520A30CEA98}']
    function NumeroDoDocumento : String; overload;
    function NumeroDoDocumento(AValue : String):IResultadoDecodificaChaveNota ; overload;

    function Serie: String; overload;
    function Serie(AValue : String):IResultadoDecodificaChaveNota ; overload;

    function CodigoDoFornecedor: String; overload;
    function CodigoDoFornecedor(AValue : String):IResultadoDecodificaChaveNota ; overload;

    function CodigoDaEmpresa: String; overload;
    function CodigoDaEmpresa(AValue : String):IResultadoDecodificaChaveNota ; overload;

    function EspecieDoDocumento: String; overload;
    function EspecieDoDocumento(AValue : String):IResultadoDecodificaChaveNota ; overload;

  End;

  IParametrosTipoDeAbreviacaoDoCliente = Interface
    ['{5E1F2056-E3B3-4CE8-A2F6-D64B0F6CC10A}']

    function CodigoDoCliente : String; overload;
    function CodigoDoCliente(AValue : String): IParametrosTipoDeAbreviacaoDoCliente; overload;

    function CodigoDaEmpresa: String; overload;
    function CodigoDaEmpresa(AValue : String): IParametrosTipoDeAbreviacaoDoCliente; overload;

    function ClienteConsumidorFinal: Boolean;overload;
    function ClienteConsumidorFinal(AValue : Boolean): IParametrosTipoDeAbreviacaoDoCliente; overload;

    function ClienteIndustria: Boolean; overload;
    function ClienteIndustria(AValue : Boolean): IParametrosTipoDeAbreviacaoDoCliente; overload;

    function InscricaoEstadual : String; overload;
    function InscricaoEstadual(AValue : String): IParametrosTipoDeAbreviacaoDoCliente; overload;

    function ClienteFisicoOuJurico : String; overload;
    function ClienteFisicoOuJurico(AValue : String): IParametrosTipoDeAbreviacaoDoCliente; overload;

    function DocumentoParaFornecedor: Boolean; overload;
    function DocumentoParaFornecedor(AValue : Boolean): IParametrosTipoDeAbreviacaoDoCliente; overload;

    function CodigoDaEmpresaTransferencia: String; overload;
    function CodigoDaEmpresaTransferencia(AValue : String): IParametrosTipoDeAbreviacaoDoCliente; overload;
  End;

  IParametrosMoedaConvertePrecos = interface
    function ValorDolarVenda: Double; overload;
    function ValorDolarVenda(AValue: Double): IParametrosMoedaConvertePrecos; overload;

    function ValorRealVenda: Double; overload;
    function ValorRealVenda(AValue: Double): IParametrosMoedaConvertePrecos; overload;

    function ValorPesoVenda: Double; overload;
    function ValorPesoVenda(AValue: Double): IParametrosMoedaConvertePrecos; overload;

    function ValorEuroVenda: Double; overload;
    function ValorEuroVenda(AValue: Double): IParametrosMoedaConvertePrecos; overload;
  end;

  IParametrosFormulaPrecoCustoSetarValores = Interface
  ['{D9E73321-DC74-4C9F-B614-2EC58DDB0C88}']
    function PrecoDeCompraLiquido: Double; overload;
    function PrecoDeCompraLiquido( AValue : Double) : IParametrosFormulaPrecoCustoSetarValores; overload;

    function IcmEntrada: Double; overload;
    function IcmEntrada( AValue : Double) : IParametrosFormulaPrecoCustoSetarValores; overload;

    function ImpostosFederaisEntrada: Double; overload;
    function ImpostosFederaisEntrada( AValue : Double) : IParametrosFormulaPrecoCustoSetarValores; overload;

    function IpiEntrada: Double; overload;
    function IpiEntrada( AValue : Double) : IParametrosFormulaPrecoCustoSetarValores; overload;

    function FreteEntrada: Double; overload;
    function FreteEntrada( AValue : Double) : IParametrosFormulaPrecoCustoSetarValores; overload;

    function ValorFrete: Double; overload;
    function ValorFrete( AValue : Double) : IParametrosFormulaPrecoCustoSetarValores; overload;

    function AcrescimoFinal: Double; overload;
    function AcrescimoFinal(AValue : Double) : IParametrosFormulaPrecoCustoSetarValores; overload;

    function Substituicao: Double; overload;
    function Substituicao(AValue : Double) : IParametrosFormulaPrecoCustoSetarValores; overload;

    function DescontoAdicionalBoleto: Double; overload;
    function DescontoAdicionalBoleto(AValue : Double) : IParametrosFormulaPrecoCustoSetarValores; overload;

    function OutrosValores: Double; overload;
    function OutrosValores(AValue : Double) : IParametrosFormulaPrecoCustoSetarValores; overload;

    function IcmSaida: Double; overload;
    function IcmSaida(AValue : Double) : IParametrosFormulaPrecoCustoSetarValores; overload;

    function ImpostosFederaisSaida: Double; overload;
    function ImpostosFederaisSaida(AValue : Double) : IParametrosFormulaPrecoCustoSetarValores; overload;

    function DespesaOperacional: Double; overload;
    function DespesaOperacional(AValue : Double) : IParametrosFormulaPrecoCustoSetarValores; overload;

    function TaxaDeControleDeIncentivosFiscaisSuframa: Double; overload;
    function TaxaDeControleDeIncentivosFiscaisSuframa(AValue : Double) : IParametrosFormulaPrecoCustoSetarValores; overload;

    function TaxaDeServicoSuframa: Double; overload;
    function TaxaDeServicoSuframa(AValue : Double) : IParametrosFormulaPrecoCustoSetarValores; overload;

    function DescontoPisCofins: Double; overload;
    function DescontoPisCofins(AValue : Double) : IParametrosFormulaPrecoCustoSetarValores; overload;

    function DescontoICMS: Double; overload;
    function DescontoICMS(AValue : Double) : IParametrosFormulaPrecoCustoSetarValores; overload;

    function FatorRegional: Double; overload;
    function FatorRegional(AValue : Double) : IParametrosFormulaPrecoCustoSetarValores; overload;

  End;


  IParametrosValidaCampoPrecoCusto = Interface
  ['{7D82454E-8B31-4E0A-842B-F2EF08C3CD91}']

    function PosicaoCampo: Integer; overload;
    function PosicaoCampo(AValue: Integer): IParametrosValidaCampoPrecoCusto; overload;

    function CodigoCampo: String; overload;
    function CodigoCampo(AValue: String): IParametrosValidaCampoPrecoCusto; overload;

    function DescricaoCampo: String; overload;
    function DescricaoCampo(AValue: String): IParametrosValidaCampoPrecoCusto; overload;

    function Operador: String; overload;
    function Operador(AValue: String): IParametrosValidaCampoPrecoCusto; overload;

    function FormulaBaseCalculo: String; overload;
    function FormulaBaseCalculo(AValue: String): IParametrosValidaCampoPrecoCusto; overload;

    function NomeDaAliquota: String; overload;
    function NomeDaAliquota(AValue: String): IParametrosValidaCampoPrecoCusto; overload;

    function ValorDaExpressao: String; overload;
    function ValorDaExpressao(AValue: String): IParametrosValidaCampoPrecoCusto; overload;

    function NomeDoCampo: String; overload;
    function NomeDoCampo(AValue: String): IParametrosValidaCampoPrecoCusto; overload;
  End;

implementation

end.

