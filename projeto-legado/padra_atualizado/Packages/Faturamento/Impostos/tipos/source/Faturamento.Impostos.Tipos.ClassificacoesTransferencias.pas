unit Faturamento.Impostos.Tipos.ClassificacoesTransferencias;

interface

uses Faturamento.Impostos.Interfaces.ClassificacoesTransferencias;

type
  TParametrosRegraClassificacoesTransferencias = class(TInterfacedObject, IParametrosRegraClassificacoesTransferencias)
  private
    FCodigoDaEmpresaTE: String;
    FCodigoDaEmpresaOrigemTE: String;
    FCstTransfEstoqueEmpresa: Boolean;
    FTipoDeOperacao: String;
    FTransfDeEstoqueClassifIndustrializacaoTributado: String;
    FTransfDeEstoqueClassifIndustrializacaoSubstCombustivelLubrificante: String;
    FTransfDeEstoqueClassifIndustrializacaoSubstDemaisProdutos: String;
    FTransfDeEstoqueClassifVendaTributado: String;
    FTransfDeEstoqueClassifVendaSubstCombustivelLubrificante: String;
    FTransfDeEstoqueClassifVendaSubstDemaisProdutos: String;
    FTransfDeEstoqueCSTDeVendaTributado: String;
    FTransfDeEstoqueCSTDeVendaSubstCombustivelLubrificante: String;
    FTransfDeEstoqueCSTDeVendaSubstDemaisProdutos: String;
    FTransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoTributado: String;
    FTransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoSubstCombustivelLubrificante: String;
    FTransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoSubstDemaisProdutos: String;
    FTransfDeEstoqueClassifTransferenciaTributado: String;
    FTransfDeEstoqueClassifTransferenciaSubstCombustivelLubrificante: String;
    FTransfDeEstoqueClassifTransferenciaSubstDemaisProdutos: String;
    FTransfDeEstoqueCSTDeTransferenciaTributado: String;
    FTransfDeEstoqueCSTDeTransferenciaSubstCombustivelLubrificante: String;
    FTransfDeEstoqueCSTDeTransferenciaSubstDemaisProdutos: String;
    FTransfDeEstoqueClassifVendaSubstImpDireta: String;
    FTransfDeEstoqueClassifTransferenciaDepositoFechadoTributado: String;
    FTransfDeEstoqueClassifTransferenciaDepositoFechadoSubstCombustivelLubrificante: String;
    FTransfDeEstoqueClassifTransferenciaDepositoFechadoSubstDemaisProdutos: String;
    FTransfDeEstoqueDepositoFechadoCSTDeTransferenciaTributado: String;
    FTransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstCombustivelLubrificante: String;
    FTransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstDemaisProdutos: String;
  public
    function CodigoDaEmpresaTE: String; overload;
    function CodigoDaEmpresaTE(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function CodigoDaEmpresaOrigemTE: String; overload;
    function CodigoDaEmpresaOrigemTE(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function CstTransfEstoqueEmpresa: Boolean; overload;
    function CstTransfEstoqueEmpresa(AValue: Boolean): IParametrosRegraClassificacoesTransferencias; overload;

    function TipoDeOperacao: String; overload;
    function TipoDeOperacao(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifIndustrializacaoTributado: String; overload;
    function TransfDeEstoqueClassifIndustrializacaoTributado(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifIndustrializacaoSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueClassifIndustrializacaoSubstCombustivelLubrificante(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifIndustrializacaoSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueClassifIndustrializacaoSubstDemaisProdutos(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifVendaTributado: String; overload;
    function TransfDeEstoqueClassifVendaTributado(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifVendaSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueClassifVendaSubstCombustivelLubrificante(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifVendaSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueClassifVendaSubstDemaisProdutos(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueCSTDeVendaTributado: String; overload;
    function TransfDeEstoqueCSTDeVendaTributado(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueCSTDeVendaSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueCSTDeVendaSubstCombustivelLubrificante(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueCSTDeVendaSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueCSTDeVendaSubstDemaisProdutos(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoTributado: String; overload;
    function TransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoTributado(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoSubstCombustivelLubrificante(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoSubstDemaisProdutos(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifTransferenciaTributado: String; overload;
    function TransfDeEstoqueClassifTransferenciaTributado(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifTransferenciaSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueClassifTransferenciaSubstCombustivelLubrificante(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifTransferenciaSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueClassifTransferenciaSubstDemaisProdutos(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueCSTDeTransferenciaTributado: String; overload;
    function TransfDeEstoqueCSTDeTransferenciaTributado(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueCSTDeTransferenciaSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueCSTDeTransferenciaSubstCombustivelLubrificante(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueCSTDeTransferenciaSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueCSTDeTransferenciaSubstDemaisProdutos(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifVendaSubstImpDireta: String; overload;
    function TransfDeEstoqueClassifVendaSubstImpDireta(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifTransferenciaDepositoFechadoTributado: String; overload;
    function TransfDeEstoqueClassifTransferenciaDepositoFechadoTributado(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstCombustivelLubrificante(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstDemaisProdutos(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueDepositoFechadoCSTDeTransferenciaTributado: String; overload;
    function TransfDeEstoqueDepositoFechadoCSTDeTransferenciaTributado(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstCombustivelLubrificante(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstDemaisProdutos(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    class function New: IParametrosRegraClassificacoesTransferencias;
  end;

type
  TResultadoRegraClassificacoesTransferencias = class(TInterfacedObject, IResultadoRegraClassificacoesTransferencias)
  private
    FTipoDeEmissaoTE: String;
    FTransfDeEstoqueClassifVendaOuTransferenciaTributado: String;
    FTransfDeEstoqueClassifVendaOuTransferenciaSubstCombustivelLubrificante: String;
    FTransfDeEstoqueClassifVendaOuTransferenciaSubstDemaisProdutos: String;
    FTransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoTributado: String;
    FTransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstCombustivelLubrificante: String;
    FTransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstDemaisProdutos: String;
    FTransfDeEstoqueCSTDeVendaOuTransferenciaTributado: String;
    FTransfDeEstoqueCSTDeVendaOuTransferenciaSubstCombustivelLubrificante: String;
    FTransfDeEstoqueCSTDeVendaOuTransferenciaSubstDemaisProdutos: String;
    FTransfDeEstoqueClassifVendaOuTransferenciaSubstImpDireta: String;
    FTransfDeEstoqueClassifTransferenciaDepositoFechadoTributado: String;
    FTransfDeEstoqueClassifTransferenciaDepositoFechadoSubstCombustivelLubrificante: String;
    FTransfDeEstoqueClassifTransferenciaDepositoFechadoSubstDemaisProdutos: String;
    FTransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaTributado: String;
    FTransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaSubstCombustivelLubrificante: String;
    FTransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaSubstDemaisProdutos: String;
  public
    function TipoDeEmissaoTE: String; overload;
    function TipoDeEmissaoTE(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoTributado: String; overload;
    function TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoTributado(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstCombustivelLubrificante(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstDemaisProdutos(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifVendaOuTransferenciaTributado: String; overload;
    function TransfDeEstoqueClassifVendaOuTransferenciaTributado(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifVendaOuTransferenciaSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueClassifVendaOuTransferenciaSubstCombustivelLubrificante(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifVendaOuTransferenciaSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueClassifVendaOuTransferenciaSubstDemaisProdutos(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueCSTDeVendaOuTransferenciaTributado: String; overload;
    function TransfDeEstoqueCSTDeVendaOuTransferenciaTributado(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueCSTDeVendaOuTransferenciaSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueCSTDeVendaOuTransferenciaSubstCombustivelLubrificante(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueCSTDeVendaOuTransferenciaSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueCSTDeVendaOuTransferenciaSubstDemaisProdutos(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifVendaOuTransferenciaSubstImpDireta: String; overload;
    function TransfDeEstoqueClassifVendaOuTransferenciaSubstImpDireta(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifTransferenciaDepositoFechadoTributado: String; overload;
    function TransfDeEstoqueClassifTransferenciaDepositoFechadoTributado(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstCombustivelLubrificante(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstDemaisProdutos(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaTributado: String; overload;
    function TransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaTributado(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaSubstCombustivelLubrificante(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaSubstDemaisProdutos(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    class function New(): IResultadoRegraClassificacoesTransferencias;
  end;

implementation

{ TResultadoRegraClassificacoesTransferencias }

class function TResultadoRegraClassificacoesTransferencias.New: IResultadoRegraClassificacoesTransferencias;
begin
  Result := Self.Create;
end;

function TResultadoRegraClassificacoesTransferencias.TipoDeEmissaoTE: String;
begin
  Result := FTipoDeEmissaoTE;
end;

function TResultadoRegraClassificacoesTransferencias.TipoDeEmissaoTE(
  AValue: String): IResultadoRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTipoDeEmissaoTE := AValue;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstCombustivelLubrificante: String;
begin
  Result := FTransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstCombustivelLubrificante;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstCombustivelLubrificante(
  AValue: String): IResultadoRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstCombustivelLubrificante := AValue;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstDemaisProdutos(
  AValue: String): IResultadoRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstDemaisProdutos := AValue;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstDemaisProdutos: String;
begin
  Result := FTransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstDemaisProdutos;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoTributado(
  AValue: String): IResultadoRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoTributado := AValue;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstCombustivelLubrificante: String;
begin
  Result := FTransfDeEstoqueClassifTransferenciaDepositoFechadoSubstCombustivelLubrificante;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstCombustivelLubrificante(
  AValue: String): IResultadoRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifTransferenciaDepositoFechadoSubstCombustivelLubrificante := AValue;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstDemaisProdutos(
  AValue: String): IResultadoRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifTransferenciaDepositoFechadoSubstDemaisProdutos := AValue;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstDemaisProdutos: String;
begin
  Result := FTransfDeEstoqueClassifTransferenciaDepositoFechadoSubstDemaisProdutos;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueClassifTransferenciaDepositoFechadoTributado(
  AValue: String): IResultadoRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifTransferenciaDepositoFechadoTributado := AValue;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueClassifTransferenciaDepositoFechadoTributado: String;
begin
  Result := FTransfDeEstoqueClassifTransferenciaDepositoFechadoTributado;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoTributado: String;
begin
  Result := FTransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoTributado;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueClassifVendaOuTransferenciaSubstCombustivelLubrificante(
  AValue: String): IResultadoRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifVendaOuTransferenciaSubstCombustivelLubrificante := AValue;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueClassifVendaOuTransferenciaSubstCombustivelLubrificante: String;
begin
  Result := FTransfDeEstoqueClassifVendaOuTransferenciaSubstCombustivelLubrificante;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueClassifVendaOuTransferenciaSubstImpDireta(
  AValue: String): IResultadoRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifVendaOuTransferenciaSubstImpDireta := AValue;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueClassifVendaOuTransferenciaSubstImpDireta: String;
begin
  Result := FTransfDeEstoqueClassifVendaOuTransferenciaSubstImpDireta;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueClassifVendaOuTransferenciaSubstDemaisProdutos: String;
begin
  Result := FTransfDeEstoqueClassifVendaOuTransferenciaSubstDemaisProdutos;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueClassifVendaOuTransferenciaSubstDemaisProdutos(
  AValue: String): IResultadoRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifVendaOuTransferenciaSubstDemaisProdutos := AValue;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueClassifVendaOuTransferenciaTributado: String;
begin
  Result := FTransfDeEstoqueClassifVendaOuTransferenciaTributado;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueClassifVendaOuTransferenciaTributado(
  AValue: String): IResultadoRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifVendaOuTransferenciaTributado := AValue;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueCSTDeVendaOuTransferenciaSubstCombustivelLubrificante(
  AValue: String): IResultadoRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueCSTDeVendaOuTransferenciaSubstCombustivelLubrificante := AValue;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueCSTDeVendaOuTransferenciaSubstCombustivelLubrificante: String;
begin
  Result := FTransfDeEstoqueCSTDeVendaOuTransferenciaSubstCombustivelLubrificante;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueCSTDeVendaOuTransferenciaSubstDemaisProdutos(
  AValue: String): IResultadoRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueCSTDeVendaOuTransferenciaSubstDemaisProdutos := AValue;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueCSTDeVendaOuTransferenciaSubstDemaisProdutos: String;
begin
  Result := FTransfDeEstoqueCSTDeVendaOuTransferenciaSubstDemaisProdutos;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueCSTDeVendaOuTransferenciaTributado(
  AValue: String): IResultadoRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueCSTDeVendaOuTransferenciaTributado := AValue;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaSubstCombustivelLubrificante: String;
begin
  Result := FTransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaSubstCombustivelLubrificante;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaSubstCombustivelLubrificante(
  AValue: String): IResultadoRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaSubstCombustivelLubrificante := AValue;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaSubstDemaisProdutos: String;
begin
  Result := FTransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaSubstDemaisProdutos;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaSubstDemaisProdutos(
  AValue: String): IResultadoRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaSubstDemaisProdutos := AValue;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaTributado: String;
begin
  Result := FTransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaTributado;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaTributado(
  AValue: String): IResultadoRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaTributado := AValue;
end;

function TResultadoRegraClassificacoesTransferencias.TransfDeEstoqueCSTDeVendaOuTransferenciaTributado: String;
begin
  Result := FTransfDeEstoqueCSTDeVendaOuTransferenciaTributado;
end;

{ TParametrosRegraClassificacoesTransferencias }

function TParametrosRegraClassificacoesTransferencias.CodigoDaEmpresaOrigemTE(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FCodigoDaEmpresaOrigemTE := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.CodigoDaEmpresaOrigemTE: String;
begin
  Result := FCodigoDaEmpresaOrigemTE;
end;

function TParametrosRegraClassificacoesTransferencias.CodigoDaEmpresaTE(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FCodigoDaEmpresaTE := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.CstTransfEstoqueEmpresa: Boolean;
begin
  Result := FCstTransfEstoqueEmpresa;
end;

function TParametrosRegraClassificacoesTransferencias.CstTransfEstoqueEmpresa(
  AValue: Boolean): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FCstTransfEstoqueEmpresa := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.CodigoDaEmpresaTE: String;
begin
  Result := FCodigoDaEmpresaTE;
end;

class function TParametrosRegraClassificacoesTransferencias.New: IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self.Create;
end;

function TParametrosRegraClassificacoesTransferencias.TipoDeOperacao(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTipoDeOperacao := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TipoDeOperacao: String;
begin
  Result := FTipoDeOperacao;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifIndustrializacaoSubstCombustivelLubrificante: String;
begin
  Result := FTransfDeEstoqueClassifIndustrializacaoSubstCombustivelLubrificante;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifIndustrializacaoSubstCombustivelLubrificante(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifIndustrializacaoSubstCombustivelLubrificante := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifIndustrializacaoSubstDemaisProdutos: String;
begin
  Result := FTransfDeEstoqueClassifIndustrializacaoSubstDemaisProdutos;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifIndustrializacaoSubstDemaisProdutos(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifIndustrializacaoSubstDemaisProdutos := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifIndustrializacaoTributado: String;
begin
  Result := FTransfDeEstoqueClassifIndustrializacaoTributado;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifIndustrializacaoTributado(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifIndustrializacaoTributado := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstCombustivelLubrificante: String;
begin
  Result := FTransfDeEstoqueClassifTransferenciaDepositoFechadoSubstCombustivelLubrificante;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstCombustivelLubrificante(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifTransferenciaDepositoFechadoSubstCombustivelLubrificante := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstDemaisProdutos(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifTransferenciaDepositoFechadoSubstDemaisProdutos := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstDemaisProdutos: String;
begin
  Result := FTransfDeEstoqueClassifTransferenciaDepositoFechadoSubstDemaisProdutos;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifTransferenciaDepositoFechadoTributado(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifTransferenciaDepositoFechadoTributado := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifTransferenciaDepositoFechadoTributado: String;
begin
  Result := FTransfDeEstoqueClassifTransferenciaDepositoFechadoTributado;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoSubstCombustivelLubrificante(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoSubstCombustivelLubrificante := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoSubstCombustivelLubrificante: String;
begin
  Result := FTransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoSubstCombustivelLubrificante;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoSubstDemaisProdutos: String;
begin
  Result := FTransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoSubstDemaisProdutos;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoSubstDemaisProdutos(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoSubstDemaisProdutos := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoTributado: String;
begin
  Result := FTransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoTributado;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoTributado(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoTributado := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifTransferenciaSubstCombustivelLubrificante: String;
begin
  Result := FTransfDeEstoqueClassifTransferenciaSubstCombustivelLubrificante;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifTransferenciaSubstCombustivelLubrificante(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifTransferenciaSubstCombustivelLubrificante := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifTransferenciaSubstDemaisProdutos: String;
begin
  Result := FTransfDeEstoqueClassifTransferenciaSubstDemaisProdutos;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifTransferenciaSubstDemaisProdutos(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifTransferenciaSubstDemaisProdutos := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifTransferenciaTributado: String;
begin
  Result := FTransfDeEstoqueClassifTransferenciaTributado;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifTransferenciaTributado(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifTransferenciaTributado := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifVendaSubstCombustivelLubrificante: String;
begin
  Result := FTransfDeEstoqueClassifVendaSubstCombustivelLubrificante;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifVendaSubstCombustivelLubrificante(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifVendaSubstCombustivelLubrificante := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifVendaSubstImpDireta: String;
begin
  Result := FTransfDeEstoqueClassifVendaSubstImpDireta;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifVendaSubstImpDireta(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifVendaSubstImpDireta := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifVendaSubstDemaisProdutos(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifVendaSubstDemaisProdutos := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifVendaSubstDemaisProdutos: String;
begin
  Result := FTransfDeEstoqueClassifVendaSubstDemaisProdutos;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifVendaTributado: String;
begin
  Result := FTransfDeEstoqueClassifVendaTributado;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueClassifVendaTributado(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueClassifVendaTributado := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueCSTDeTransferenciaSubstCombustivelLubrificante(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueCSTDeTransferenciaSubstCombustivelLubrificante := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueCSTDeTransferenciaSubstCombustivelLubrificante: String;
begin
  Result := FTransfDeEstoqueCSTDeTransferenciaSubstCombustivelLubrificante;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueCSTDeTransferenciaSubstDemaisProdutos(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueCSTDeTransferenciaSubstDemaisProdutos := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueCSTDeTransferenciaSubstDemaisProdutos: String;
begin
  Result := FTransfDeEstoqueCSTDeTransferenciaSubstDemaisProdutos;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueCSTDeTransferenciaTributado(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueCSTDeTransferenciaTributado := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueCSTDeTransferenciaTributado: String;
begin
  Result := FTransfDeEstoqueCSTDeTransferenciaTributado;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueCSTDeVendaSubstCombustivelLubrificante: String;
begin
  Result := FTransfDeEstoqueCSTDeVendaSubstCombustivelLubrificante;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueCSTDeVendaSubstCombustivelLubrificante(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueCSTDeVendaSubstCombustivelLubrificante := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueCSTDeVendaSubstDemaisProdutos: String;
begin
  Result := FTransfDeEstoqueCSTDeVendaSubstDemaisProdutos;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueCSTDeVendaSubstDemaisProdutos(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueCSTDeVendaSubstDemaisProdutos := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueCSTDeVendaTributado: String;
begin
  Result := FTransfDeEstoqueCSTDeVendaTributado;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueCSTDeVendaTributado(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueCSTDeVendaTributado := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstCombustivelLubrificante: String;
begin
  Result := FTransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstCombustivelLubrificante;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstCombustivelLubrificante(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstCombustivelLubrificante := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstDemaisProdutos: String;
begin
  Result := FTransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstDemaisProdutos;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstDemaisProdutos(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstDemaisProdutos := AValue;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueDepositoFechadoCSTDeTransferenciaTributado: String;
begin
  Result := FTransfDeEstoqueDepositoFechadoCSTDeTransferenciaTributado;
end;

function TParametrosRegraClassificacoesTransferencias.TransfDeEstoqueDepositoFechadoCSTDeTransferenciaTributado(
  AValue: String): IParametrosRegraClassificacoesTransferencias;
begin
  Result := Self;
  FTransfDeEstoqueDepositoFechadoCSTDeTransferenciaTributado := AValue;
end;

end.
