unit Shared.Functions.Tipos;

interface

uses Shared.Functions.Interfaces, Shared.Functions.Types;

type
  TResultadoDesmembrarSelectParaCampoTabela = class(TInterfacedObject, IResultadoDesmembrarSelectParaCampoTabela)
  private
    FCamposSelect: ArrOfString;
    FNomeTabela: String;
    FCampoChave: ArrOfString;
  public
    function CamposSelect: ArrOfString; overload;
    function CamposSelect(AValue: ArrOfString): IResultadoDesmembrarSelectParaCampoTabela; overload;

    function NomeTabela: String; overload;
    function NomeTabela(AValue: String): IResultadoDesmembrarSelectParaCampoTabela; overload;

    function CampoChave: ArrOfString; overload;
    function CampoChave(AValue: ArrOfString): IResultadoDesmembrarSelectParaCampoTabela; overload;

    class function New(): IResultadoDesmembrarSelectParaCampoTabela;
  end;

type
  TParametrosCalculoPreComMenosDescForn = class(TInterfacedObject, IParametrosCalculoPreComMenosDescForn)
  private
    FPrecoDeUltimaCompra: Double;
    FPrecoDeCompra: Double;
    FDesconto01: Double;
    FDesconto02: Double;
    FDesconto03: Double;
    FDesconto04: Double;
    FDesconto05: Double;
    FDesconto06: Double;
    FCalculoSubstituicaoOperacoesProprias: String;
  public
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

    class function New(): IParametrosCalculoPreComMenosDescForn;
  end;

Type
  TParametrosDecodificaChaveNota = class(TInterfacedObject, IParametrosDecodificaChaveNota)
  private
    FChave: String;
    FTamanhoCampoDocumento : Integer;
  public
    Function Chave: String; Overload;
    Function Chave(AValue : String) :IParametrosDecodificaChaveNota ; Overload;

    Function TamanhoCampoDocumento: Integer; Overload;
    Function TamanhoCampoDocumento(AValue : Integer) :IParametrosDecodificaChaveNota ; Overload;

    class function New(): IParametrosDecodificaChaveNota;
  end;

Type
  TResultadoDecodificaChaveNota = class(TInterfacedObject, IResultadoDecodificaChaveNota)
  private
    FNumeroDoDocumento  : String;
    FSerie              : String;
    FCodigoDoFornecedor : String;
    FCodigoDaEmpresa    : String;
    FEspecieDoDocumento : String;
  public
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

    class function New(): IResultadoDecodificaChaveNota;

  end;

Type
  TParametrosTipoDeAbreviacaoDoCliente = Class(TInterfacedObject, IParametrosTipoDeAbreviacaoDoCliente)
  private
    FCodigoDoCliente        : String;
    FCodigoDaEmpresa        : String;
    FClienteConsumidorFinal : Boolean;
    FClienteIndustria       : Boolean;
    FInscricaoEstadual      : String;
    FClienteFisicoOuJurico  : String;
    FDocumentoParaFornecedor : Boolean;
    FCodigoDaEmpresaTransferencia: String;
  public
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

    function DocumentoParaFornecedor: Boolean;overload;
    function DocumentoParaFornecedor(AValue : Boolean): IParametrosTipoDeAbreviacaoDoCliente; overload;

    function CodigoDaEmpresaTransferencia: String; overload;
    function CodigoDaEmpresaTransferencia(AValue : String): IParametrosTipoDeAbreviacaoDoCliente; overload;

    class function New(): IParametrosTipoDeAbreviacaoDoCliente;

  End;

type
  TParametrosMoedaConvertePrecos = class(TInterfacedObject, IParametrosMoedaConvertePrecos)
  strict private
    FValorDolarVenda: Double;
    FValorRealVenda: Double;
    FValorPesoVenda: Double;
    FValorEuroVenda: Double;
  public
    function ValorDolarVenda: Double; overload;
    function ValorDolarVenda(AValue: Double): IParametrosMoedaConvertePrecos; overload;

    function ValorRealVenda: Double; overload;
    function ValorRealVenda(AValue: Double): IParametrosMoedaConvertePrecos; overload;

    function ValorPesoVenda: Double; overload;
    function ValorPesoVenda(AValue: Double): IParametrosMoedaConvertePrecos; overload;

    function ValorEuroVenda: Double; overload;
    function ValorEuroVenda(AValue: Double): IParametrosMoedaConvertePrecos; overload;

    class function New(): IParametrosMoedaConvertePrecos;
  end;

Type
  TParametrosFormulaPrecoCustoSetarValores = class(TInterfacedObject, IParametrosFormulaPrecoCustoSetarValores)
  private
    FPrecoDeCompraLiquido: Double;
    FIcmEntrada: Double;
    FImpostosFederaisEntrada: Double;
    FIpiEntrada: Double;
    FFreteEntrada: Double;
    FValorFrete: Double;
    FAcrescimoFinal: Double;
    FSubstituicao: Double;
    FDescontoAdicionalBoleto: Double;
    FOutrosValores: Double;
    FIcmSaida: Double;
    FImpostosFederaisSaida: Double;
    FDespesaOperacional: Double;
    FTaxaDeControleDeIncentivosFiscaisSuframa: Double;
    FTaxaDeServicoSuframa: Double;
    FDescontoPisCofins: Double;
    FDescontoICMS: Double;
    FFatorRegional: Double;
  public
    function PrecoDeCompraLiquido: Double; overload;
    function PrecoDeCompraLiquido(AValue: Double): IParametrosFormulaPrecoCustoSetarValores; overload;

    function IcmEntrada: Double; overload;
    function IcmEntrada(AValue: Double): IParametrosFormulaPrecoCustoSetarValores; overload;

    function ImpostosFederaisEntrada: Double; overload;
    function ImpostosFederaisEntrada(AValue: Double): IParametrosFormulaPrecoCustoSetarValores; overload;

    function IpiEntrada: Double; overload;
    function IpiEntrada(AValue: Double): IParametrosFormulaPrecoCustoSetarValores; overload;

    function FreteEntrada: Double; overload;
    function FreteEntrada(AValue: Double): IParametrosFormulaPrecoCustoSetarValores; overload;

    function ValorFrete: Double; overload;
    function ValorFrete(AValue: Double): IParametrosFormulaPrecoCustoSetarValores; overload;

    function AcrescimoFinal: Double; overload;
    function AcrescimoFinal(AValue: Double): IParametrosFormulaPrecoCustoSetarValores; overload;

    function Substituicao: Double; overload;
    function Substituicao(AValue: Double): IParametrosFormulaPrecoCustoSetarValores; overload;

    function DescontoAdicionalBoleto: Double; overload;
    function DescontoAdicionalBoleto(AValue: Double): IParametrosFormulaPrecoCustoSetarValores; overload;

    function OutrosValores: Double; overload;
    function OutrosValores(AValue: Double): IParametrosFormulaPrecoCustoSetarValores; overload;

    function IcmSaida: Double; overload;
    function IcmSaida(AValue: Double): IParametrosFormulaPrecoCustoSetarValores; overload;

    function ImpostosFederaisSaida: Double; overload;
    function ImpostosFederaisSaida(AValue: Double): IParametrosFormulaPrecoCustoSetarValores; overload;

    function DespesaOperacional: Double; overload;
    function DespesaOperacional(AValue: Double): IParametrosFormulaPrecoCustoSetarValores; overload;

    function TaxaDeControleDeIncentivosFiscaisSuframa: Double; overload;
    function TaxaDeControleDeIncentivosFiscaisSuframa(AValue: Double): IParametrosFormulaPrecoCustoSetarValores; overload;

    function TaxaDeServicoSuframa: Double; overload;
    function TaxaDeServicoSuframa(AValue: Double): IParametrosFormulaPrecoCustoSetarValores; overload;

    function DescontoPisCofins: Double; overload;
    function DescontoPisCofins(AValue: Double): IParametrosFormulaPrecoCustoSetarValores; overload;

    function DescontoICMS: Double; overload;
    function DescontoICMS(AValue: Double): IParametrosFormulaPrecoCustoSetarValores; overload;

    function FatorRegional: Double; overload;
    function FatorRegional(AValue: Double): IParametrosFormulaPrecoCustoSetarValores; overload;

    class function New(): IParametrosFormulaPrecoCustoSetarValores;
  end;

type
  TParametrosValidaCampoPrecoCusto = class(TInterfacedObject, IParametrosValidaCampoPrecoCusto)
  private
    FPosicaoCampo       : Integer;
    FCodigoCampo        : String;
    FDescricaoCampo     : String;
    FOperador           : String;
    FFormulaBaseCalculo : String;
    FNomeDaAliquota     : String;
    FValorDaExpressao   : String;
    FNomeDoCampo        : String;
  public
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

    class function New(): IParametrosValidaCampoPrecoCusto;

  end;


implementation

{ TResultadoDesmembrarSelectParaCampoTabela }

function TResultadoDesmembrarSelectParaCampoTabela.CampoChave(
  AValue: ArrOfString): IResultadoDesmembrarSelectParaCampoTabela;
begin
  Result := Self;
  FCampoChave := AValue;
end;

function TResultadoDesmembrarSelectParaCampoTabela.CampoChave: ArrOfString;
begin
  Result := FCampoChave;
end;

function TResultadoDesmembrarSelectParaCampoTabela.CamposSelect: ArrOfString;
begin
  Result := FCamposSelect;
end;

function TResultadoDesmembrarSelectParaCampoTabela.CamposSelect(
  AValue: ArrOfString): IResultadoDesmembrarSelectParaCampoTabela;
begin
  Result := Self;
  FCamposSelect := AValue;
end;

class function TResultadoDesmembrarSelectParaCampoTabela.New: IResultadoDesmembrarSelectParaCampoTabela;
begin
  Result := Self.Create;
end;

function TResultadoDesmembrarSelectParaCampoTabela.NomeTabela(
  AValue: String): IResultadoDesmembrarSelectParaCampoTabela;
begin
  Result := Self;
  FNomeTabela := AValue;
end;

function TResultadoDesmembrarSelectParaCampoTabela.NomeTabela: String;
begin
  Result := FNomeTabela;
end;

{ TParametrosCalculoPreComMenosDescForn }

function TParametrosCalculoPreComMenosDescForn.CalculoSubstituicaoOperacoesProprias(
  AValue: String): IParametrosCalculoPreComMenosDescForn;
begin
  Result := Self;
  FCalculoSubstituicaoOperacoesProprias := AValue;
end;

function TParametrosCalculoPreComMenosDescForn.CalculoSubstituicaoOperacoesProprias: String;
begin
  Result := FCalculoSubstituicaoOperacoesProprias;
end;

function TParametrosCalculoPreComMenosDescForn.Desconto01: Double;
begin
  Result := FDesconto01;
end;

function TParametrosCalculoPreComMenosDescForn.Desconto01(
  AValue: Double): IParametrosCalculoPreComMenosDescForn;
begin
  Result := Self;
  FDesconto01 := AValue;
end;

function TParametrosCalculoPreComMenosDescForn.Desconto02: Double;
begin
  Result := FDesconto02;
end;

function TParametrosCalculoPreComMenosDescForn.Desconto02(
  AValue: Double): IParametrosCalculoPreComMenosDescForn;
begin
  Result := Self;
  FDesconto02 := AValue;
end;

function TParametrosCalculoPreComMenosDescForn.Desconto03: Double;
begin
  Result := FDesconto03;
end;

function TParametrosCalculoPreComMenosDescForn.Desconto03(
  AValue: Double): IParametrosCalculoPreComMenosDescForn;
begin
  Result := Self;
  FDesconto03 := AValue;
end;

function TParametrosCalculoPreComMenosDescForn.Desconto04: Double;
begin
  Result := FDesconto04;
end;

function TParametrosCalculoPreComMenosDescForn.Desconto04(
  AValue: Double): IParametrosCalculoPreComMenosDescForn;
begin
  Result := Self;
  FDesconto04 := AValue;
end;

function TParametrosCalculoPreComMenosDescForn.Desconto05: Double;
begin
  Result := FDesconto05;
end;

function TParametrosCalculoPreComMenosDescForn.Desconto05(
  AValue: Double): IParametrosCalculoPreComMenosDescForn;
begin
  Result := Self;
  FDesconto05 := AValue;
end;

function TParametrosCalculoPreComMenosDescForn.Desconto06: Double;
begin
  Result := FDesconto06;
end;

function TParametrosCalculoPreComMenosDescForn.Desconto06(
  AValue: Double): IParametrosCalculoPreComMenosDescForn;
begin
  Result := Self;
  FDesconto06 := AValue;
end;

class function TParametrosCalculoPreComMenosDescForn.New: IParametrosCalculoPreComMenosDescForn;
begin
  Result := Self.Create;
end;

function TParametrosCalculoPreComMenosDescForn.PrecoDeCompra(
  AValue: Double): IParametrosCalculoPreComMenosDescForn;
begin
  Result := Self;
  FPrecoDeCompra := AValue;
end;

function TParametrosCalculoPreComMenosDescForn.PrecoDeCompra: Double;
begin
  Result := FPrecoDeCompra;
end;

function TParametrosCalculoPreComMenosDescForn.PrecoDeUltimaCompra: Double;
begin
  Result := FPrecoDeUltimaCompra;
end;

function TParametrosCalculoPreComMenosDescForn.PrecoDeUltimaCompra(
  AValue: Double): IParametrosCalculoPreComMenosDescForn;
begin
  Result := Self;
  FPrecoDeUltimaCompra := AValue;
end;

{ TParametrosDecodificaChaveNota }

function TParametrosDecodificaChaveNota.Chave: String;
begin
  Result := FChave;
end;

function TParametrosDecodificaChaveNota.Chave(
  AValue: String): IParametrosDecodificaChaveNota;
begin
  Result := Self;
  FChave := AValue;
end;

class function TParametrosDecodificaChaveNota.New: IParametrosDecodificaChaveNota;
begin
  Result := Self.Create;
end;

function TParametrosDecodificaChaveNota.TamanhoCampoDocumento: Integer;
begin
  Result := FTamanhoCampoDocumento;
end;

function TParametrosDecodificaChaveNota.TamanhoCampoDocumento(
  AValue: Integer): IParametrosDecodificaChaveNota;
begin
  Result := Self;
  FTamanhoCampoDocumento := AValue;
end;

{ TResultadoDecodificaChaveNota }

function TResultadoDecodificaChaveNota.CodigoDaEmpresa: String;
begin
  Result := FCodigoDaEmpresa;
end;

function TResultadoDecodificaChaveNota.CodigoDaEmpresa(
  AValue: String): IResultadoDecodificaChaveNota;
begin
  Result := Self;
  FCodigoDaEmpresa := AValue;
end;

function TResultadoDecodificaChaveNota.CodigoDoFornecedor: String;
begin
  Result := FCodigoDoFornecedor;
end;

function TResultadoDecodificaChaveNota.CodigoDoFornecedor(
  AValue: String): IResultadoDecodificaChaveNota;
begin
  Result := Self;
  FCodigoDoFornecedor := AValue;
end;

function TResultadoDecodificaChaveNota.EspecieDoDocumento(
  AValue: String): IResultadoDecodificaChaveNota;
begin
  Result := Self;
  FEspecieDoDocumento := AValue;
end;

function TResultadoDecodificaChaveNota.EspecieDoDocumento: String;
begin
  Result := FEspecieDoDocumento;
end;

class function TResultadoDecodificaChaveNota.New: IResultadoDecodificaChaveNota;
begin
  Result := Self.Create;
end;

function TResultadoDecodificaChaveNota.NumeroDoDocumento(
  AValue: String): IResultadoDecodificaChaveNota;
begin
  Result := Self;
  FNumeroDoDocumento := AValue;
end;

function TResultadoDecodificaChaveNota.NumeroDoDocumento: String;
begin
  Result := FNumeroDoDocumento;
end;

function TResultadoDecodificaChaveNota.Serie(
  AValue: String): IResultadoDecodificaChaveNota;
begin
  Result := Self;
  FSerie := AValue;
end;

function TResultadoDecodificaChaveNota.Serie: String;
begin
  Result := FSerie;
end;

{ TParametrosTipoDeAbreviacaoDoCliente }

function TParametrosTipoDeAbreviacaoDoCliente.ClienteConsumidorFinal: Boolean;
begin
  Result := FClienteConsumidorFinal;
end;

function TParametrosTipoDeAbreviacaoDoCliente.ClienteConsumidorFinal(
  AValue: Boolean): IParametrosTipoDeAbreviacaoDoCliente;
begin
  Result := Self;
  FClienteConsumidorFinal := AValue;
end;

function TParametrosTipoDeAbreviacaoDoCliente.ClienteFisicoOuJurico(
  AValue: String): IParametrosTipoDeAbreviacaoDoCliente;
begin
  Result := Self;
  FClienteFisicoOuJurico := AValue;
end;

function TParametrosTipoDeAbreviacaoDoCliente.ClienteFisicoOuJurico: String;
begin
  Result := FClienteFisicoOuJurico;
end;

function TParametrosTipoDeAbreviacaoDoCliente.ClienteIndustria: Boolean;
begin
  Result := FClienteIndustria;
end;

function TParametrosTipoDeAbreviacaoDoCliente.ClienteIndustria(
  AValue: Boolean): IParametrosTipoDeAbreviacaoDoCliente;
begin
  Result := Self;
  FClienteIndustria := Avalue;
end;

function TParametrosTipoDeAbreviacaoDoCliente.CodigoDaEmpresa: String;
begin
  Result := FCodigoDaEmpresa;
end;

function TParametrosTipoDeAbreviacaoDoCliente.CodigoDaEmpresa(
  AValue: String): IParametrosTipoDeAbreviacaoDoCliente;
begin
  Result := Self;
  FCodigoDaEmpresa := Avalue;
end;

function TParametrosTipoDeAbreviacaoDoCliente.CodigoDaEmpresaTransferencia: String;
begin
  Result := FCodigoDaEmpresaTransferencia;
end;

function TParametrosTipoDeAbreviacaoDoCliente.CodigoDaEmpresaTransferencia(
  AValue: String): IParametrosTipoDeAbreviacaoDoCliente;
begin
  Result := Self;
  FCodigoDaEmpresaTransferencia := Avalue;
end;

function TParametrosTipoDeAbreviacaoDoCliente.CodigoDoCliente: String;
begin
  Result := FCodigoDoCliente;
end;

function TParametrosTipoDeAbreviacaoDoCliente.CodigoDoCliente(
  AValue: String): IParametrosTipoDeAbreviacaoDoCliente;
begin
  Result := Self;
  FCodigoDoCliente := Avalue;
end;

function TParametrosTipoDeAbreviacaoDoCliente.DocumentoParaFornecedor: Boolean;
begin
  Result := FDocumentoParaFornecedor;
end;

function TParametrosTipoDeAbreviacaoDoCliente.DocumentoParaFornecedor(
  AValue: Boolean): IParametrosTipoDeAbreviacaoDoCliente;
begin
  Result := Self;
  FDocumentoParaFornecedor := Avalue;
end;

function TParametrosTipoDeAbreviacaoDoCliente.InscricaoEstadual(
  AValue: String): IParametrosTipoDeAbreviacaoDoCliente;
begin
  Result := Self;
  FInscricaoEstadual := AValue;
end;

class function TParametrosTipoDeAbreviacaoDoCliente.New: IParametrosTipoDeAbreviacaoDoCliente;
begin
  Result := Self.Create;
end;

function TParametrosTipoDeAbreviacaoDoCliente.InscricaoEstadual: String;
begin
  Result := FInscricaoEstadual;
end;

{ TParametrosMoedaConvertePrecos }

class function TParametrosMoedaConvertePrecos.New: IParametrosMoedaConvertePrecos;
begin
  Result := Self.Create;
end;

function TParametrosMoedaConvertePrecos.ValorDolarVenda(
  AValue: Double): IParametrosMoedaConvertePrecos;
begin
  Result := Self;
  FValorDolarVenda := AValue;
end;

function TParametrosMoedaConvertePrecos.ValorDolarVenda: Double;
begin
  Result := FValorDolarVenda;
end;

function TParametrosMoedaConvertePrecos.ValorEuroVenda: Double;
begin
  Result := FValorEuroVenda;
end;

function TParametrosMoedaConvertePrecos.ValorEuroVenda(
  AValue: Double): IParametrosMoedaConvertePrecos;
begin
  Result := Self;
  FValorEuroVenda := AValue;
end;

function TParametrosMoedaConvertePrecos.ValorPesoVenda: Double;
begin
  Result := FValorPesoVenda;
end;

function TParametrosMoedaConvertePrecos.ValorPesoVenda(
  AValue: Double): IParametrosMoedaConvertePrecos;
begin
  Result := Self;
  FValorPesoVenda := AValue;
end;

function TParametrosMoedaConvertePrecos.ValorRealVenda(
  AValue: Double): IParametrosMoedaConvertePrecos;
begin
  Result := Self;
  FValorRealVenda := AValue;
end;

function TParametrosMoedaConvertePrecos.ValorRealVenda: Double;
begin
  Result := FValorRealVenda;
end;

{ TParametrosFormulaPrecoCustoSetarValores }

function TParametrosFormulaPrecoCustoSetarValores.PrecoDeCompraLiquido: Double;
begin
  Result := FPrecoDeCompraLiquido;
end;

function TParametrosFormulaPrecoCustoSetarValores.PrecoDeCompraLiquido(AValue: Double): IParametrosFormulaPrecoCustoSetarValores;
begin
  Result := Self;
  FPrecoDeCompraLiquido := AValue;
end;

function TParametrosFormulaPrecoCustoSetarValores.IcmEntrada: Double;
begin
  Result := FIcmEntrada;
end;

function TParametrosFormulaPrecoCustoSetarValores.IcmEntrada(AValue: Double): IParametrosFormulaPrecoCustoSetarValores;
begin
  Result := Self;
  FIcmEntrada := AValue;
end;

function TParametrosFormulaPrecoCustoSetarValores.ImpostosFederaisEntrada: Double;
begin
  Result := FImpostosFederaisEntrada;
end;

function TParametrosFormulaPrecoCustoSetarValores.ImpostosFederaisEntrada(AValue: Double): IParametrosFormulaPrecoCustoSetarValores;
begin
  Result := Self;
  FImpostosFederaisEntrada := AValue;
end;

function TParametrosFormulaPrecoCustoSetarValores.IpiEntrada: Double;
begin
  Result := FIpiEntrada;
end;

function TParametrosFormulaPrecoCustoSetarValores.IpiEntrada(AValue: Double): IParametrosFormulaPrecoCustoSetarValores;
begin
  Result := Self;
  FIpiEntrada := AValue;
end;

function TParametrosFormulaPrecoCustoSetarValores.FreteEntrada: Double;
begin
  Result := FFreteEntrada;
end;

function TParametrosFormulaPrecoCustoSetarValores.FreteEntrada(AValue: Double): IParametrosFormulaPrecoCustoSetarValores;
begin
  Result := Self;
  FFreteEntrada := AValue;
end;

function TParametrosFormulaPrecoCustoSetarValores.ValorFrete: Double;
begin
  Result := FValorFrete;
end;

function TParametrosFormulaPrecoCustoSetarValores.ValorFrete(AValue: Double): IParametrosFormulaPrecoCustoSetarValores;
begin
  Result := Self;
  FValorFrete := AValue;
end;

function TParametrosFormulaPrecoCustoSetarValores.AcrescimoFinal: Double;
begin
  Result := FAcrescimoFinal;
end;

function TParametrosFormulaPrecoCustoSetarValores.AcrescimoFinal(AValue: Double): IParametrosFormulaPrecoCustoSetarValores;
begin
  Result := Self;
  FAcrescimoFinal := AValue;
end;

function TParametrosFormulaPrecoCustoSetarValores.Substituicao: Double;
begin
  Result := FSubstituicao;
end;

function TParametrosFormulaPrecoCustoSetarValores.Substituicao(AValue: Double): IParametrosFormulaPrecoCustoSetarValores;
begin
  Result := Self;
  FSubstituicao := AValue;
end;

function TParametrosFormulaPrecoCustoSetarValores.DescontoAdicionalBoleto: Double;
begin
  Result := FDescontoAdicionalBoleto;
end;

function TParametrosFormulaPrecoCustoSetarValores.DescontoAdicionalBoleto(AValue: Double): IParametrosFormulaPrecoCustoSetarValores;
begin
  Result := Self;
  FDescontoAdicionalBoleto := AValue;
end;

function TParametrosFormulaPrecoCustoSetarValores.OutrosValores: Double;
begin
  Result := FOutrosValores;
end;

function TParametrosFormulaPrecoCustoSetarValores.OutrosValores(AValue: Double): IParametrosFormulaPrecoCustoSetarValores;
begin
  Result := Self;
  FOutrosValores := AValue;
end;

function TParametrosFormulaPrecoCustoSetarValores.IcmSaida: Double;
begin
  Result := FIcmSaida;
end;

function TParametrosFormulaPrecoCustoSetarValores.IcmSaida(AValue: Double): IParametrosFormulaPrecoCustoSetarValores;
begin
  Result := Self;
  FIcmSaida := AValue;
end;

function TParametrosFormulaPrecoCustoSetarValores.ImpostosFederaisSaida: Double;
begin
  Result := FImpostosFederaisSaida;
end;

function TParametrosFormulaPrecoCustoSetarValores.ImpostosFederaisSaida(AValue: Double): IParametrosFormulaPrecoCustoSetarValores;
begin
  Result := Self;
  FImpostosFederaisSaida := AValue;
end;

function TParametrosFormulaPrecoCustoSetarValores.DespesaOperacional: Double;
begin
  Result := FDespesaOperacional;
end;

function TParametrosFormulaPrecoCustoSetarValores.DespesaOperacional(AValue: Double): IParametrosFormulaPrecoCustoSetarValores;
begin
  Result := Self;
  FDespesaOperacional := AValue;
end;

function TParametrosFormulaPrecoCustoSetarValores.TaxaDeControleDeIncentivosFiscaisSuframa: Double;
begin
  Result := FTaxaDeControleDeIncentivosFiscaisSuframa;
end;

function TParametrosFormulaPrecoCustoSetarValores.TaxaDeControleDeIncentivosFiscaisSuframa(AValue: Double): IParametrosFormulaPrecoCustoSetarValores;
begin
  Result := Self;
  FTaxaDeControleDeIncentivosFiscaisSuframa:= AValue;
end;

function TParametrosFormulaPrecoCustoSetarValores.TaxaDeServicoSuframa: Double;
begin
  Result := FTaxaDeServicoSuframa;
end;

function TParametrosFormulaPrecoCustoSetarValores.TaxaDeServicoSuframa(AValue: Double): IParametrosFormulaPrecoCustoSetarValores;
begin
  Result := Self;
  FTaxaDeServicoSuframa:= AValue;
end;

function TParametrosFormulaPrecoCustoSetarValores.DescontoPisCofins: Double;
begin
  Result := FDescontoPisCofins;
end;

function TParametrosFormulaPrecoCustoSetarValores.DescontoPisCofins(AValue: Double): IParametrosFormulaPrecoCustoSetarValores;
begin
  Result := Self;
  FDescontoPisCofins := AValue;
end;

function TParametrosFormulaPrecoCustoSetarValores.DescontoICMS: Double;
begin
  Result := FDescontoICMS;
end;

function TParametrosFormulaPrecoCustoSetarValores.DescontoICMS(AValue: Double): IParametrosFormulaPrecoCustoSetarValores;
begin
  Result := Self;
  FDescontoICMS := AValue;
end;

function TParametrosFormulaPrecoCustoSetarValores.FatorRegional: Double;
begin
  Result := FFatorRegional;
end;

function TParametrosFormulaPrecoCustoSetarValores.FatorRegional(AValue: Double): IParametrosFormulaPrecoCustoSetarValores;
begin
  Result := Self;
  FFatorRegional := AValue;
end;

class function TParametrosFormulaPrecoCustoSetarValores.New: IParametrosFormulaPrecoCustoSetarValores;
begin
  Result := Self.Create
end;

function TParametrosValidaCampoPrecoCusto.PosicaoCampo: Integer;
begin
  Result := FPosicaoCampo;
end;

function TParametrosValidaCampoPrecoCusto.PosicaoCampo(AValue: Integer): IParametrosValidaCampoPrecoCusto;
begin
  Result := Self;
  FPosicaoCampo := AValue;
end;

function TParametrosValidaCampoPrecoCusto.CodigoCampo: String;
begin
  Result := FCodigoCampo;
end;

function TParametrosValidaCampoPrecoCusto.CodigoCampo(AValue: String): IParametrosValidaCampoPrecoCusto;
begin
  Result := Self;
  FCodigoCampo := AValue;
end;


function TParametrosValidaCampoPrecoCusto.DescricaoCampo: String;
begin
  Result := FDescricaoCampo;
end;

function TParametrosValidaCampoPrecoCusto.DescricaoCampo(AValue: String): IParametrosValidaCampoPrecoCusto;
begin
  Result := Self;
  FDescricaoCampo := AValue;
end;

function TParametrosValidaCampoPrecoCusto.Operador: String;
begin
  Result := FOperador;
end;

function TParametrosValidaCampoPrecoCusto.Operador(AValue: String): IParametrosValidaCampoPrecoCusto;
begin
  Result := Self;
  FOperador := AValue;
end;

function TParametrosValidaCampoPrecoCusto.FormulaBaseCalculo: String;
begin
  Result := FFormulaBaseCalculo;
end;

function TParametrosValidaCampoPrecoCusto.FormulaBaseCalculo(AValue: String): IParametrosValidaCampoPrecoCusto;
begin
  Result := Self;
  FFormulaBaseCalculo := AValue;
end;

function TParametrosValidaCampoPrecoCusto.NomeDaAliquota: String;
begin
  Result := FNomeDaAliquota;
end;

function TParametrosValidaCampoPrecoCusto.NomeDaAliquota(AValue: String): IParametrosValidaCampoPrecoCusto;
begin
  Result := Self;
  FNomeDaAliquota := AValue;
end;

function TParametrosValidaCampoPrecoCusto.ValorDaExpressao: String;
begin
  Result := FValorDaExpressao;
end;

function TParametrosValidaCampoPrecoCusto.ValorDaExpressao(AValue: String): IParametrosValidaCampoPrecoCusto;
begin
  Result := Self;
  FValorDaExpressao := AValue;
end;

function TParametrosValidaCampoPrecoCusto.NomeDoCampo: String;
begin
  Result := FNomeDoCampo;
end;

function TParametrosValidaCampoPrecoCusto.NomeDoCampo(AValue: String): IParametrosValidaCampoPrecoCusto;
begin
  Result := Self;
  FNomeDoCampo := AValue;
end;

class function TParametrosValidaCampoPrecoCusto.New: IParametrosValidaCampoPrecoCusto;
begin
  Result := Self.Create
end;

end.

