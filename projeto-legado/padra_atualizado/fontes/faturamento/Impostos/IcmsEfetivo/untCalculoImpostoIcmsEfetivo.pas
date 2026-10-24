unit untCalculoImpostoIcmsEfetivo;

interface

uses untFuncFatTypes, Shared.Functions.Types, untTypesIcmsEfetivo,
  untConsultaModelFaturamento, Shared.Functions.Funcoes.Faturamento,
  Faturamento.Impostos.Interfaces.Model, Shared.Functions.Configuracoes,
  Shared.Functions.DataSet, Shared.Functions.Core, untTypesGenericosImpostos,
  Shared.Functions.Constantes, Shared.Functions.Faturamento.TintaDeMaquina,
  untTypesIPI;

type
  TCalculoImpostoIcmsEfetivo = class
  private
    FTintaDeMaquina: ITintaDeMaquina;
    FConstantes: IConstantesUtils;
    FCore: IFunctionsCore;
    FConnection: IMyConnection;
    FConfiguracoes: IConfiguracoes;
    FConsultaModel: IConsultaModelFaturamento;
    procedure ZerarValoresMatriz(var AMatItens: TMatrizFechamento);
    procedure PreencherVetorItens(var AMatItensIcmsEfetivo: TMatrizFechamentoIcmsEfetivo; AMatItens : TMatrizFechamento);
    function SetarParametrosIcmsEfetivo(AMatItensIcmsEfetivo : TMatrizFechamentoIcmsEfetivo): TParametrosServicoIcmsEfetivo;
    function IgnorarIcmsEfetivoMatrizSemItens(AMatItensIcmsEfetivo: TMatrizFechamentoIcmsEfetivo): Boolean;
    function GetModelClienteFornecedor(AParametros: TParametrosServicoIcmsEfetivo): IResultadoFaturamentoImpostosModelClienteFornecedor;
    function NotaDeImportacao(AParametros: TParametrosServicoIcmsEfetivo): Boolean;
    function DocumentoParaFornecedor(AParametros: TParametrosServicoIcmsEfetivo): Boolean;
    procedure SetarValorFinalMatriz(AResultadoCalculoIcmsEfetivo: TMatrizFechamentoIcmsEfetivo; var AMatItens : TMatrizFechamento);
    function ValidarNormativasIcmsEfetivo(AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor): Boolean;
    function ValidarNormativasParaIcmsEfetivo: Boolean;
    function RetornarResultadoSemCalcular(AParametros: TParametrosServicoIcmsEfetivo): TResultadoServicosClasseIcmsEfetivo;
    function RetornarResultadoCalculoIcmsEfetivo(AParametros: TParametrosServicoIcmsEfetivo; var ADadosDocumento: TResultadoDecodificaChaveNota; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor; var ATipoDeAbreviacaoFiscal : String): TResultadoServicosClasseIcmsEfetivo;
    function VendaDentroDoEstado(AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor): Boolean;
    function RetornarListaDeitens(AParametros: TParametrosServicoIcmsEfetivo): String;
    function RetornarListaFornecedorFilial : String;
    procedure SetarResultadoCalculoIcmsEfetivoNaMatrizDeItens(var AMatItensResultadoIcmsEfetivo: TMatrizFechamentoIcmsEfetivo; const AResultadoCalculoIcmsEfetivo: TResultadoCalculoIcmsEfetivo; AParametros: TParametrosServicoIcmsEfetivo; var AChaveNota: String);
    function GetModelProduto(Const AContador : Integer; AParametros: TParametrosServicoIcmsEfetivo): IResultadoFaturamentoImpostosModelProduto;
    function GetModelAbreviacaoIcms(Const AContador : Integer; AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor; AModelProduto: IResultadoFaturamentoImpostosModelProduto; var ATipoDeAbreviacaoFiscal : String): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
    function ValidarRegrasParaCalcularIcmsEfetivo(Const AContador : Integer; AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor; AModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms): Boolean;
    function SetarItemNaMatrizSemResultado : TResultadoCalculoIcmsEfetivo;
    function RetornarUltimaNotaItem(Const ACodigoDoItem : String; Const ADadosUltimasNotas : IMyQuery): TResultadoDecodificaChaveNota;
    procedure SetarDadosDoDocumentoDaUltimaNota(Const AResultadoUltimaNota: TResultadoDecodificaChaveNota; var ADadosDocumento: TResultadoDecodificaChaveNota);
    procedure SetarDadosDocumento(Const AContador : Integer; var ADadosDocumentoOprPropria : IMyQuery; AParametros: TParametrosServicoIcmsEfetivo; var AQryDadosDocumento: IMyQuery; var ADadosDocumento: TResultadoDecodificaChaveNota);
    function RetornarChaveNota(var AQryDadosDocumento: IMyQuery; var ADadosDocumento: TResultadoDecodificaChaveNota): String;
    function RetornarParametrosCalculoIcmsEfetivo(const APosicaoMatriz: integer; const AEncontrouDocumento: Boolean; AParametros: TParametrosServicoIcmsEfetivo; var ADadosDocumentoOprPropria : IMyQuery; var ADadosDocumento: TResultadoDecodificaChaveNota; var AQryDadosDocumento: IMyQuery; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor; AModelProduto: IResultadoFaturamentoImpostosModelProduto; AModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms; var ATipoDeAbreviacaoFiscal : String): TParametrosCalculoIcmsEfetivo;
    function EncontrouDocumento(var ADadosDocumento: TResultadoDecodificaChaveNota): Boolean;
    function CalcularIcmsEfetivoSemUltimaNota(Const AContador : Integer; AParametros: TParametrosServicoIcmsEfetivo): Boolean;
    function RetornarTrocaUFEndEntrega(AParametros: TParametrosServicoIcmsEfetivo; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor): String;
    function RetornaEstadoParaAbreviacao(AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor): String;
    function TipoDeAbreviacaoFiscal(AParametros: TParametrosServicoIcmsEfetivo; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor): String;
    function TotalDoItemParaCalcIcmEfetivo(const AContador: Integer; AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor): Double;
    function RetornarSituacaoTributaria(Const ACodigoSituacaoInicial : String; AParametros: TParametrosServicoIcmsEfetivo; AModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms): String;
    function ConfiguracaoClassificacaoDeCompra: String;
    function EhTintaAutomotiva(Const AContador : Integer; AParametros: TParametrosServicoIcmsEfetivo): Boolean;
    procedure SetarDadosDocumentoSemUltimaNotaDeTinta(Const AContador : Integer; AParametros: TParametrosServicoIcmsEfetivo; var AQryDadosDocumento: IMyQuery);
    procedure SetarDadosDocumentoSemUltimaNota(Const AContador : Integer; AParametros: TParametrosServicoIcmsEfetivo; var AQryDadosDocumento: IMyQuery);
    function RetornarQuantidade(Const AContador : Integer; AParametros: TParametrosServicoIcmsEfetivo; var ADadosDocumento: TResultadoDecodificaChaveNota; var AQryDadosDocumento: IMyQuery): Double;
    function RetornarPercentualReducaoBase(var ADadosDocumento: TResultadoDecodificaChaveNota; var AQryDadosDocumento: IMyQuery): Double;
    function AliquotaIcmsParaCalcIcmEfetivo(const AContador: Integer; AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor; AModelProduto: IResultadoFaturamentoImpostosModelProduto; AModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms; var ATipoDeAbreviacaoFiscal : String): Double;
    function RetornarRegraDeTributacaoAliquotaIcms(const AContador: Integer; AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor; AModelProduto: IResultadoFaturamentoImpostosModelProduto; AModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms; var ATipoDeAbreviacaoFiscal : String): Double;
    function RetornarValorBaseRetida(var AQryDadosDocumento: IMyQuery; var ADadosDocumento: TResultadoDecodificaChaveNota): Double;
    function RetornarValorRetido(var AQryDadosDocumento: IMyQuery; var ADadosDocumento: TResultadoDecodificaChaveNota): Double;
    function RetornarValorIcmsSubstitutoItem(var AQryDadosDocumento: IMyQuery; var ADadosDocumento: TResultadoDecodificaChaveNota): Double;
    function EhIcmsEfetivoSemUltimaNota(const APosicaoMatriz: integer; var ADadosDocumento: TResultadoDecodificaChaveNota; AParametros: TParametrosServicoIcmsEfetivo): Boolean;
    function CalcularIcmsEfetivo(const AParametros: TParametrosCalculoIcmsEfetivo): Boolean;
    function TotalGeralDoItem(const AContador: integer; AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor): Double;
    function RetornarValorIpi(Const AContador : Integer; AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor) : Double;
    function ParametrosCalculoIPI(Const AContador : Integer; AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor): TParametrosCalculoValorIpi;
    function CalculoValorDaBaseRetida(var AQryDadosDocumento: IMyQuery) : Double;
    function CalculoValorRetido(var AQryDadosDocumento: IMyQuery): Double;
    function DeterminaValorRetido(var AQryDadosDocumento: IMyQuery): Double;
    function DeterminaValorBaseRetida(var AQryDadosDocumento: IMyQuery): Double;
    function ParametrosRegrasTributacao(const AContador: Integer; AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor; AModelProduto: IResultadoFaturamentoImpostosModelProduto; var ATipoDeAbreviacaoFiscal : String): TParametrosRegrasTributacao;
    function DentroDoEstadoCFOP(AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor): Boolean;
    function AtividadeConstrutora(AParametros: TParametrosServicoIcmsEfetivo; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor): Boolean;
    function AlqIcmEstEmpFaturamento(Const AContador : Integer; AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelProduto: IResultadoFaturamentoImpostosModelProduto; var ATipoDeAbreviacaoFiscal : String): Double;
    function RetornarTipoDeAbreviacaoAlqIcmEstEmpFaturamento(Const AContador : Integer; AParametros: TParametrosServicoIcmsEfetivo; var ATipoDeAbreviacaoFiscal : String): String;
    function AlqIcmEstEmpSimples(AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelProduto: IResultadoFaturamentoImpostosModelProduto): Double;
  public
    function CalcularValorIcmsEfetivo(var AMatItens: TMatrizFechamento): TMatrizFechamentoIcmsEfetivo; overload;
    function CalcularValorIcmsEfetivo(AParametros: TParametrosServicoIcmsEfetivo; var ACalculouIcmsEfetivo: Boolean): TResultadoServicosClasseIcmsEfetivo; overload;
    function CalcularValorIcmsEfetivo(AParametros: TParametrosCalculoIcmsEfetivo): TResultadoCalculoIcmsEfetivo; overload;
    constructor Create(ACore: IFunctionsCore; AConnection: IMyConnection; AConfiguracoes: IConfiguracoes;
                       AConsultaModel: IConsultaModelFaturamento; AConstantes: IConstantesUtils; ATintaDeMaquina: ITintaDeMaquina);
    destructor Destroy; override;
  end;

implementation

uses System.SysUtils, untFaturamentoImpostosFuncoes, Controller.Faturamento.Interfaces.Impostos.Parametros.Comum,
  Shared.Functions.SQL, StrUtils, untCalculoImpostoIPI, untImpostoRegrasTributacao, Shared.Functions.Interfaces,
  Shared.Functions.Utils;

{ TCalculoImpostoIcmsEfetivo }

function TCalculoImpostoIcmsEfetivo.DocumentoParaFornecedor(AParametros: TParametrosServicoIcmsEfetivo): Boolean;
begin
  Result := TFunctionFuncoesFaturamento.fDocumentoParaFornecedor(AParametros.OpcaoDoDocumento,
                                                                 AParametros.NotaComplementoFornecedor,
                                                                 AParametros.NotaEspecialFornecedor,
                                                                 NotaDeImportacao(AParametros),
                                                                 AParametros.CodigoDoCliente,
                                                                 AParametros.CodigoDoFornecedor);
end;

function TCalculoImpostoIcmsEfetivo.NotaDeImportacao(AParametros: TParametrosServicoIcmsEfetivo): Boolean;
begin
  Result := False;

  If AParametros.OpcaoDoDocumento <> 'NC' Then
    Result := SameText(TFaturamentoImpostosFuncoes.RetornarNotaDeImportacao(AParametros.MatItensIcmsEfetivo[0].strClaFis), 'S');
end;

function TCalculoImpostoIcmsEfetivo.GetModelClienteFornecedor(AParametros: TParametrosServicoIcmsEfetivo): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  If DocumentoParaFornecedor(AParametros) Then
    Result := FConsultaModel.ConsultarFornecedor(AParametros.CodigoDoCliente)
  Else
    Result := FConsultaModel.ConsultarCliente(AParametros.CodigoDoCliente, AParametros.SequencialEnderecoEntrega, AParametros.GerandoCasosTestes, AParametros.ClienteConsumidorFinal, AParametros.ParametrosClienteConsumidor);
end;

{
function TFaturamentoImpostosServicosDisponiveisIcmsEfetivo.CalcularValorIcmsEfetivo(
  AParametros: IParametrosServicoIcmsEfetivo): IResultadoServicosClasseIcmsEfetivo;
}
function TCalculoImpostoIcmsEfetivo.CalcularValorIcmsEfetivo(AParametros: TParametrosServicoIcmsEfetivo; var ACalculouIcmsEfetivo: Boolean): TResultadoServicosClasseIcmsEfetivo;
  var
    LModelEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LModelClienteFornecedor : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LTipoDeAbreviacaoFiscal : String;
    LDadosDocumento : TResultadoDecodificaChaveNota;
begin
// -- begin create

  ACalculouIcmsEfetivo := False;

  FillChar(Result, SizeOf(Result), #0);

  If IgnorarIcmsEfetivoMatrizSemItens(AParametros.MatItensIcmsEfetivo) Then
    Exit;

  FillChar(LDadosDocumento, SizeOf(LDadosDocumento), #0);

  LModelClienteFornecedor := GetModelClienteFornecedor(AParametros);
  LModelEmpresa := FConsultaModel.ConsultarEmpresa(AParametros.CodigoDaEmpresa);
  LTipoDeAbreviacaoFiscal := TipoDeAbreviacaoFiscal(AParametros, LModelClienteFornecedor);

// -- end create

  ACalculouIcmsEfetivo := True;

// -- begin function CalcularValorIcmsEfetivo: IResultadoServicosClasseIcmsEfetivo;

//  If IgnorarIcmsEfetivoMatrizSemItens(AParametros.MatItensIcmsEfetivo) Then
//    Exit;

  If Not ValidarNormativasIcmsEfetivo(AParametros, LModelEmpresa, LModelClienteFornecedor) Then
  begin
    Result := RetornarResultadoSemCalcular(AParametros);
    Exit;
  end;

  Result := RetornarResultadoCalculoIcmsEfetivo(AParametros, LDadosDocumento, LModelEmpresa, LModelClienteFornecedor, LTipoDeAbreviacaoFiscal);

// -- end function CalcularValorIcmsEfetivo: IResultadoServicosClasseIcmsEfetivo;
end;

function TCalculoImpostoIcmsEfetivo.IgnorarIcmsEfetivoMatrizSemItens(AMatItensIcmsEfetivo: TMatrizFechamentoIcmsEfetivo): Boolean;
begin
  Result := false;

  If Length(AMatItensIcmsEfetivo) > 0 Then
    Exit;

  Result := true;
end;

procedure TCalculoImpostoIcmsEfetivo.SetarValorFinalMatriz(AResultadoCalculoIcmsEfetivo: TMatrizFechamentoIcmsEfetivo; var AMatItens : TMatrizFechamento);
  Var
    LContador : Integer;
begin
  For LContador := Low(AResultadoCalculoIcmsEfetivo) To High(AResultadoCalculoIcmsEfetivo) Do
  begin
    AMatItens[LContador].strNotUlt                             := AResultadoCalculoIcmsEfetivo[LContador].strNotUlt;
    AMatItens[LContador].fltPICMEF                             := AResultadoCalculoIcmsEfetivo[LContador].fltPICMEF;
    AMatItens[LContador].fltBICMEF                             := AResultadoCalculoIcmsEfetivo[LContador].fltBICMEF;
    AMatItens[LContador].fltAICMEF                             := AResultadoCalculoIcmsEfetivo[LContador].fltAICMEF;
    AMatItens[LContador].fltVICMEF                             := AResultadoCalculoIcmsEfetivo[LContador].fltVICMEF;
    AMatItens[LContador].fltSICMEF                             := AResultadoCalculoIcmsEfetivo[LContador].fltSICMEF;
    AMatItens[LContador].fltBSTANT                             := AResultadoCalculoIcmsEfetivo[LContador].fltBSTANT;
    AMatItens[LContador].fltVSTANT                             := AResultadoCalculoIcmsEfetivo[LContador].fltVSTANT;
    AMatItens[LContador].fltBaseOperacaoPropriaICMSEntrada     := AResultadoCalculoIcmsEfetivo[LContador].fltBaseOperacaoPropriaICMSEntrada;
    AMatItens[LContador].fltAliquotaOperacaoPropriaICMSEntrada := AResultadoCalculoIcmsEfetivo[LContador].fltAliquotaOperacaoPropriaICMSEntrada;
    AMatItens[LContador].fltValorOperacaoPropriaIMCSEntrada    := AResultadoCalculoIcmsEfetivo[LContador].fltValorOperacaoPropriaIMCSEntrada;
  end;
end;

function TCalculoImpostoIcmsEfetivo.CalcularValorIcmsEfetivo(var AMatItens: TMatrizFechamento): TMatrizFechamentoIcmsEfetivo;
  Var
    LMatItensIcmsEfetivo : TMatrizFechamentoIcmsEfetivo;
    LParametrosServicoIcmsEfetivo : TParametrosServicoIcmsEfetivo;
    LResultadoMatrizIcmsEfetivo: TResultadoServicosClasseIcmsEfetivo;
    LContador : Integer;
    LCalculouIcmsEfetivo : Boolean;
begin
  ZerarValoresMatriz(AMatItens);
  PreencherVetorItens(LMatItensIcmsEfetivo, AMatItens);
  FillChar(LParametrosServicoIcmsEfetivo, SizeOf(LParametrosServicoIcmsEfetivo), #0);
  LParametrosServicoIcmsEfetivo := SetarParametrosIcmsEfetivo(LMatItensIcmsEfetivo);

  FillChar(LResultadoMatrizIcmsEfetivo, SizeOf(LResultadoMatrizIcmsEfetivo), #0);
  LCalculouIcmsEfetivo := False;
  LResultadoMatrizIcmsEfetivo := CalcularValorIcmsEfetivo(LParametrosServicoIcmsEfetivo, LCalculouIcmsEfetivo);

{
function TImpostosFatControllerIcmsEfetivo.CalculouIcmsEfetivo(Const AResultado : IResultadoServicosClasseIcmsEfetivo) : Boolean;
begin
  Result := (AResultado <> Nil) ;
end;
}
  If Not LCalculouIcmsEfetivo Then
    Exit;

  For LContador := Low(LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo) To High(LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo) Do
  begin
    SetLength(Result, Length(Result) + 1);

    Result[LContador].fltPICMEF                             := LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo[LContador].fltPICMEF;
    Result[LContador].fltBICMEF                             := LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo[LContador].fltBICMEF;
    Result[LContador].fltAICMEF                             := LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo[LContador].fltAICMEF;
    Result[LContador].fltVICMEF                             := LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo[LContador].fltVICMEF;
    Result[LContador].fltBSTANT                             := LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo[LContador].fltBSTANT;
    Result[LContador].fltVSTANT                             := LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo[LContador].fltVSTANT;
    Result[LContador].fltSICMEF                             := LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo[LContador].fltSICMEF;
    Result[LContador].fltBaseOperacaoPropriaICMSEntrada     := LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo[LContador].fltBaseOperacaoPropriaICMSEntrada;
    Result[LContador].fltAliquotaOperacaoPropriaICMSEntrada := LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo[LContador].fltAliquotaOperacaoPropriaICMSEntrada;
    Result[LContador].fltValorOperacaoPropriaIMCSEntrada    := LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo[LContador].fltValorOperacaoPropriaIMCSEntrada;

    SetarValorFinalMatriz(LResultadoMatrizIcmsEfetivo.ResultadoCalculoIcmsEfetivo, AMatItens);
  end;
end;

function TCalculoImpostoIcmsEfetivo.SetarParametrosIcmsEfetivo(AMatItensIcmsEfetivo : TMatrizFechamentoIcmsEfetivo): TParametrosServicoIcmsEfetivo;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result.MatItensIcmsEfetivo := AMatItensIcmsEfetivo;
  Result.CodigoDoCliente := GetImpostosFatParametrosComum.CodigoDoCliente;
  Result.OpcaoDoDocumento := GetImpostosFatParametrosComum.OpcaoDoDocumento;
  Result.CodigoDaEmpresa := GetImpostosFatParametrosComum.CodigoDaEmpresa;
  Result.CodigoDoFornecedor := GetImpostosFatParametrosComum.CodigoDoFornecedor;
  Result.ClienteConsumidorFinal := GetImpostosFatParametrosComum.ClienteConsumidorFinal;

  If Assigned(GetImpostosFatParametrosComum.ParametrosClienteConsumidor) Then
  Begin
    Result.ParametrosClienteConsumidor.ClienteEstado := GetImpostosFatParametrosComum.ParametrosClienteConsumidor.ClienteEstado;
    Result.ParametrosClienteConsumidor.ClienteFisicoOuJuridico := GetImpostosFatParametrosComum.ParametrosClienteConsumidor.ClienteFisicoOuJuridico;
    Result.ParametrosClienteConsumidor.ClienteInscricaoEstadual := GetImpostosFatParametrosComum.ParametrosClienteConsumidor.ClienteInscricaoEstadual;
    Result.ParametrosClienteConsumidor.ClienteAtividade := GetImpostosFatParametrosComum.ParametrosClienteConsumidor.ClienteAtividade;
    Result.ParametrosClienteConsumidor.CalcularDescontoIcmsOrgaoPublico := GetImpostosFatParametrosComum.ParametrosClienteConsumidor.CalcularDescontoIcmsOrgaoPublico;
    Result.ParametrosClienteConsumidor.CodigoDaEmpresaTransferencia := GetImpostosFatParametrosComum.ParametrosClienteConsumidor.CodigoDaEmpresaTransferencia;
  End;

  Result.SequencialEnderecoEntrega := GetImpostosFatParametrosComum.SequencialEnderecoEntrega;
  Result.NotaComplementoFornecedor := GetImpostosFatParametrosComum.NotaComplementoFornecedor;
  Result.NotaEspecialFornecedor := GetImpostosFatParametrosComum.NotaEspecialFornecedor;
  Result.VendaPresencial := GetImpostosFatParametrosComum.VendaPresencial;
  Result.BaixaDeEntregaFutura := GetImpostosFatParametrosComum.BaixaDeEntregaFutura;
  Result.ClienteIndustria := GetImpostosFatParametrosComum.ClienteIndustria;
  Result.ClienteComercializacao := GetImpostosFatParametrosComum.ClienteComercializacao;
  Result.EspecieDocumento := GetImpostosFatParametrosComum.EspecieDoDocumento;
  Result.TipoOperacaoPedidoVenda := GetImpostosFatParametrosComum.TipoOperacaoPedidoVenda;
  Result.CalcularSatEcf := GetImpostosFatParametrosComum.CalcularSatEcf;
  Result.UtilizaSat := GetImpostosFatParametrosComum.UtilizaSat;
end;

procedure TCalculoImpostoIcmsEfetivo.ZerarValoresMatriz(var AMatItens: TMatrizFechamento);
  Var
    LContador : Integer;
begin
  For LContador := Low(AMatItens) To High(AMatItens) Do
  Begin
    AMatItens[LContador].fltPICMEF                             := 0.00;
    AMatItens[LContador].fltBICMEF                             := 0.00;
    AMatItens[LContador].fltAICMEF                             := 0.00;
    AMatItens[LContador].fltVICMEF                             := 0.00;
    AMatItens[LContador].fltBSTANT                             := 0.00;
    AMatItens[LContador].fltVSTANT                             := 0.00;
    AMatItens[LContador].fltSICMEF                             := 0.00;
    AMatItens[LContador].fltBaseOperacaoPropriaICMSEntrada     := 0.00;
    AMatItens[LContador].fltAliquotaOperacaoPropriaICMSEntrada := 0.00;
    AMatItens[LContador].fltValorOperacaoPropriaIMCSEntrada    := 0.00;
  End;
end;

constructor TCalculoImpostoIcmsEfetivo.Create(ACore: IFunctionsCore; AConnection: IMyConnection; AConfiguracoes: IConfiguracoes;
                       AConsultaModel: IConsultaModelFaturamento; AConstantes: IConstantesUtils; ATintaDeMaquina: ITintaDeMaquina);
begin
  FConstantes := AConstantes;
  FCore := ACore;
  FConnection := AConnection;
  FConfiguracoes := AConfiguracoes;
  FConsultaModel := AConsultaModel;
  FTintaDeMaquina := ATintaDeMaquina;
end;

destructor TCalculoImpostoIcmsEfetivo.Destroy;
begin
  inherited;
end;

procedure TCalculoImpostoIcmsEfetivo.PreencherVetorItens(var AMatItensIcmsEfetivo: TMatrizFechamentoIcmsEfetivo; AMatItens : TMatrizFechamento);
  Var
    LContador : Integer;
begin
  For LContador := Low(AMatItens) To High(AMatItens) Do
  begin
    SetLength(AMatItensIcmsEfetivo, Length(AMatItensIcmsEfetivo) + 1);

    AMatItensIcmsEfetivo[LContador].strCodFis                             := AMatItens[LContador].strCodFis;
    AMatItensIcmsEfetivo[LContador].strCodSit                             := AMatItens[LContador].strCodSit;
    AMatItensIcmsEfetivo[LContador].strCodIte                             := AMatItens[LContador].strCodIte;
    AMatItensIcmsEfetivo[LContador].strNotUlt                             := AMatItens[LContador].strNotUlt;
    AMatItensIcmsEfetivo[LContador].fltPICMEF                             := AMatItens[LContador].fltPICMEF;
    AMatItensIcmsEfetivo[LContador].fltBICMEF                             := AMatItens[LContador].fltBICMEF;
    AMatItensIcmsEfetivo[LContador].fltAICMEF                             := AMatItens[LContador].fltAICMEF;
    AMatItensIcmsEfetivo[LContador].fltVICMEF                             := AMatItens[LContador].fltVICMEF;
    AMatItensIcmsEfetivo[LContador].fltSICMEF                             := AMatItens[LContador].fltSICMEF;
    AMatItensIcmsEfetivo[LContador].fltBSTANT                             := AMatItens[LContador].fltBSTANT;
    AMatItensIcmsEfetivo[LContador].fltVSTANT                             := AMatItens[LContador].fltVSTANT;
    AMatItensIcmsEfetivo[LContador].fltQtdIte                             := AMatItens[LContador].fltQtdIte;
    AMatItensIcmsEfetivo[LContador].strClaFis                             := AMatItens[LContador].strClaFis;
    AMatItensIcmsEfetivo[LContador].fltTotIte                             := AMatItens[LContador].fltTotIte;
    AMatItensIcmsEfetivo[LContador].fltAlqIcm                             := AMatItens[LContador].fltAlqIcm;
    AMatItensIcmsEfetivo[LContador].fltDesEsp                             := AMatItens[LContador].fltDesEsp;
    AMatItensIcmsEfetivo[LContador].fltValFre                             := AMatItens[LContador].fltValFre;
    AMatItensIcmsEfetivo[LContador].fltDesAce                             := AMatItens[LContador].fltDesAce;
    AMatItensIcmsEfetivo[LContador].opcINFesp                             := AMatItens[LContador].opcINFesp;
    AMatItensIcmsEfetivo[LContador].strIdePro                             := AMatItens[LContador].strIdePro;
    AMatItensIcmsEfetivo[LContador].fltComLiq                             := AMatItens[LContador].fltComLiq;
    AMatItensIcmsEfetivo[LContador].fltBaseOperacaoPropriaICMSEntrada     := AMatItens[LContador].fltBaseOperacaoPropriaICMSEntrada;
    AMatItensIcmsEfetivo[LContador].fltAliquotaOperacaoPropriaICMSEntrada := AMatItens[LContador].fltAliquotaOperacaoPropriaICMSEntrada;
    AMatItensIcmsEfetivo[LContador].fltValorOperacaoPropriaIMCSEntrada    := AMatItens[LContador].fltValorOperacaoPropriaIMCSEntrada;
    AMatItensIcmsEfetivo[LContador].strEmpIte                             := AMatItens[LContador].strEmpIte;
  end;
end;

function TCalculoImpostoIcmsEfetivo.ValidarNormativasIcmsEfetivo(AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor): Boolean;
begin
  Result := False;

  If Not ValidarNormativasParaIcmsEfetivo Then
    Exit;

  If FConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, VarString) <> '1' Then
    Exit;

  If Not VendaDentroDoEstado(AParametros, AModelEmpresa, AModelClienteFornecedor) Then
    Exit;

  Result := True;
end;

function TCalculoImpostoIcmsEfetivo.ValidarNormativasParaIcmsEfetivo: Boolean;
begin
  Result := True;

  If FConfiguracoes.fGetValorConfiguracao(CFG_UTILIZAR_NORMATIVA_48_ESTORNO_ICMS, varBoolean) Then
    Exit;

  If FConfiguracoes.fGetValorConfiguracao(CFG_UTILIZAR_NORMATIVA_48_ICMS_EFETIVO, varBoolean) Then
    Exit;

  Result := False;
end;

function TCalculoImpostoIcmsEfetivo.RetornarResultadoSemCalcular(AParametros: TParametrosServicoIcmsEfetivo): TResultadoServicosClasseIcmsEfetivo;
  Var
    LContador : Integer;
    LParametrosCalculoIcmsEfetivo: TParametrosCalculoIcmsEfetivo;
    LMatItensIcmsEfetivo         : TMatrizFechamentoIcmsEfetivo;
begin
  FillChar(LParametrosCalculoIcmsEfetivo, SizeOf(LParametrosCalculoIcmsEfetivo), #0);

  For LContador := Low(AParametros.MatItensIcmsEfetivo) To High(AParametros.MatItensIcmsEfetivo) Do
  begin
    SetLength(LMatItensIcmsEfetivo,Length(LMatItensIcmsEfetivo) + 1);

    LMatItensIcmsEfetivo[LContador].strNotUlt := '';
    LMatItensIcmsEfetivo[LContador].intOrdem  := LContador;
    LMatItensIcmsEfetivo[LContador].strCodite := AParametros.MatItensIcmsEfetivo[LContador].strCodIte;
    LMatItensIcmsEfetivo[LContador].fltPICMEF := 0;
    LMatItensIcmsEfetivo[LContador].fltBICMEF := 0;
    LMatItensIcmsEfetivo[LContador].fltAICMEF := 0;
    LMatItensIcmsEfetivo[LContador].fltVICMEF := 0;
    LMatItensIcmsEfetivo[LContador].fltSICMEF := 0;
    LMatItensIcmsEfetivo[LContador].fltBSTANT := 0;
    LMatItensIcmsEfetivo[LContador].fltVSTANT := 0;
  end;

  FillChar(Result, SizeOf(Result), #0);
  Result.ParametrosCalculoIcmsEfetivo := LParametrosCalculoIcmsEfetivo;
  Result.ResultadoCalculoIcmsEfetivo := LMatItensIcmsEfetivo;
end;

function TCalculoImpostoIcmsEfetivo.RetornarResultadoCalculoIcmsEfetivo(AParametros: TParametrosServicoIcmsEfetivo; var ADadosDocumento: TResultadoDecodificaChaveNota; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor; var ATipoDeAbreviacaoFiscal : String): TResultadoServicosClasseIcmsEfetivo;
  Var
    LResultadoUltimaNota : TResultadoDecodificaChaveNota;
    LContador : Integer;
    LParametrosCalculoIcmsEfetivo: TParametrosCalculoIcmsEfetivo;
    LResultadoCalculoIcmsEfetivo : TResultadoCalculoIcmsEfetivo;
    LDadosUltNotas : IMyQuery;
    LQryDadosDocumento : IMyQuery;
    LDadosDocumentoOprPropria : IMyQuery;
    LMatItensResultadoIcmsEfetivo: TMatrizFechamentoIcmsEfetivo;
    LChaveNota : String;
    LModelProduto : IResultadoFaturamentoImpostosModelProduto;
    LModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  LDadosUltNotas := FConnection.CreateQuery;
  LDadosUltNotas.SQL.Text :=
    TFunctionsSQL.GetSQLUltimasNotas(RetornarListaDeitens(AParametros),
                                     RetornarListaFornecedorFilial,
                                     AParametros.CodigoDaEmpresa);

  LQryDadosDocumento            := FConnection.CreateQuery;
  LDadosDocumentoOprPropria  := FConnection.CreateQuery;

  SetLength(LMatItensResultadoIcmsEfetivo,0);

  For LContador := Low(AParametros.MatItensIcmsEfetivo) To High(AParametros.MatItensIcmsEfetivo) Do
  begin
    LModelProduto := GetModelProduto(LContador, AParametros);
    LModelAbreviacaoIcms := GetModelAbreviacaoIcms(LContador, AParametros, AModelEmpresa, AModelClienteFornecedor, LModelProduto, ATipoDeAbreviacaoFiscal);

    If not ValidarRegrasParaCalcularIcmsEfetivo(LContador, AParametros, AModelEmpresa, AModelClienteFornecedor, LModelAbreviacaoIcms) Then
    begin
      LChaveNota := '';
      SetarResultadoCalculoIcmsEfetivoNaMatrizDeItens(LMatItensResultadoIcmsEfetivo, SetarItemNaMatrizSemResultado, AParametros, LChaveNota);
      Continue;
    end;

    FillChar(LResultadoUltimaNota, SizeOf(LResultadoUltimaNota), #0);
    LResultadoUltimaNota := RetornarUltimaNotaItem(AParametros.MatItensIcmsEfetivo[LContador].strCodIte, LDadosUltNotas);

    SetarDadosDoDocumentoDaUltimaNota(LResultadoUltimaNota, ADadosDocumento);
    SetarDadosDocumento(LContador, LDadosDocumentoOprPropria, AParametros, LQryDadosDocumento, ADadosDocumento);

    LChaveNota := RetornarChaveNota(LQryDadosDocumento, ADadosDocumento);

    FillChar(LParametrosCalculoIcmsEfetivo, SizeOf(LParametrosCalculoIcmsEfetivo), #0);
    LParametrosCalculoIcmsEfetivo := RetornarParametrosCalculoIcmsEfetivo(LContador, LQryDadosDocumento.RecordCount > 0, AParametros, LDadosDocumentoOprPropria, ADadosDocumento, LQryDadosDocumento, AModelEmpresa, AModelClienteFornecedor, LModelProduto, LModelAbreviacaoIcms, ATipoDeAbreviacaoFiscal);

    FillChar(LResultadoCalculoIcmsEfetivo, SizeOf(LResultadoCalculoIcmsEfetivo), #0);
    LResultadoCalculoIcmsEfetivo := Self.CalcularValorIcmsEfetivo(LParametrosCalculoIcmsEfetivo); // debugar, sair em @323

    SetarResultadoCalculoIcmsEfetivoNaMatrizDeItens(LMatItensResultadoIcmsEfetivo, LResultadoCalculoIcmsEfetivo, AParametros, LChaveNota);

    If not EncontrouDocumento(ADadosDocumento) Then
    Begin
      If not CalcularIcmsEfetivoSemUltimaNota(LContador, AParametros) Then
      Begin
        LMatItensResultadoIcmsEfetivo[LContador].strNotUlt := '';
        LMatItensResultadoIcmsEfetivo[LContador].fltPICMEF := 0;
        LMatItensResultadoIcmsEfetivo[LContador].fltBICMEF := 0;
        LMatItensResultadoIcmsEfetivo[LContador].fltAICMEF := 0;
        LMatItensResultadoIcmsEfetivo[LContador].fltVICMEF := 0;
        LMatItensResultadoIcmsEfetivo[LContador].fltSICMEF := 0;
        LMatItensResultadoIcmsEfetivo[LContador].fltBSTANT := 0;
        LMatItensResultadoIcmsEfetivo[LContador].fltVSTANT := 0;
        LMatItensResultadoIcmsEfetivo[LContador].fltBaseOperacaoPropriaICMSEntrada     := 0;
        LMatItensResultadoIcmsEfetivo[LContador].fltAliquotaOperacaoPropriaICMSEntrada := 0;
        LMatItensResultadoIcmsEfetivo[LContador].fltValorOperacaoPropriaIMCSEntrada    := 0;
      End;
    End;
  end;

  FillChar(Result, SizeOf(Result), #0);
  Result.ParametrosCalculoIcmsEfetivo := LParametrosCalculoIcmsEfetivo;
  Result.ResultadoCalculoIcmsEfetivo := LMatItensResultadoIcmsEfetivo;
end;

function TCalculoImpostoIcmsEfetivo.VendaDentroDoEstado(AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor): Boolean;
begin
  Result := TFaturamentoImpostosFuncoes.VendaDentroDoEstado(RetornarTrocaUFEndEntrega(AParametros, AModelClienteFornecedor), AModelEmpresa.EmpresaEstado, AParametros.VendaPresencial);
end;

function TCalculoImpostoIcmsEfetivo.RetornarListaDeitens(AParametros: TParametrosServicoIcmsEfetivo): String;
Var
  LItem : TDadosFechamentoIcmsEfetivo;
  strLista: String;
begin
  strLista := '""';

  If (Length(AParametros.MatItensIcmsEfetivo) > 0) Then
  Begin
    strLista := '';
    For LItem In AParametros.MatItensIcmsEfetivo Do
    Begin
      TFunctionFuncoesFaturamento
        .IncrementaListaStr(LItem.strCodIte, strLista, true, true, ',', false, false);
    End;
  End;

  Result := strLista;
end;

function TCalculoImpostoIcmsEfetivo.RetornarListaFornecedorFilial : String;
  Var
    LRetornoForncedorFilial : IMyCampoTabela;
begin
  LRetornoForncedorFilial :=
    FCore.fCampoTabelaDados(TFunctionFuncoesFaturamento.GetSelectFornecedorFilial, [], []);

  Result :=
    TFunctionFuncoesFaturamento.
      RetornarListaDeFornecedorFilial(LRetornoForncedorFilial.Fields(0).AsString, true);
end;

procedure TCalculoImpostoIcmsEfetivo.SetarResultadoCalculoIcmsEfetivoNaMatrizDeItens(var AMatItensResultadoIcmsEfetivo: TMatrizFechamentoIcmsEfetivo; const AResultadoCalculoIcmsEfetivo: TResultadoCalculoIcmsEfetivo; AParametros: TParametrosServicoIcmsEfetivo; var AChaveNota: String);
  Var
    Lcontador : Integer;
begin
  SetLength(AMatItensResultadoIcmsEfetivo,Length(AMatItensResultadoIcmsEfetivo) + 1);

  LContador := Length(AMatItensResultadoIcmsEfetivo) - 1;

  AMatItensResultadoIcmsEfetivo[LContador].strNotUlt                             := AChaveNota;
  AMatItensResultadoIcmsEfetivo[LContador].intOrdem                              := LContador;
  AMatItensResultadoIcmsEfetivo[LContador].strCodite                             := AParametros.MatItensIcmsEfetivo[LContador].strCodIte;
  AMatItensResultadoIcmsEfetivo[LContador].fltPICMEF                             := AResultadoCalculoIcmsEfetivo.PercentualReducaoBaseCalcEfetivaItem;
  AMatItensResultadoIcmsEfetivo[LContador].fltBICMEF                             := AResultadoCalculoIcmsEfetivo.ValorBaseCalculoEfetivaItem;
  AMatItensResultadoIcmsEfetivo[LContador].fltAICMEF                             := AResultadoCalculoIcmsEfetivo.AliquotaIcmsEfetivaItem;
  AMatItensResultadoIcmsEfetivo[LContador].fltVICMEF                             := AResultadoCalculoIcmsEfetivo.ValorIcmsEfetivaItem;
  AMatItensResultadoIcmsEfetivo[LContador].fltSICMEF                             := AResultadoCalculoIcmsEfetivo.ValorIcmsSubstitutoItem;
  AMatItensResultadoIcmsEfetivo[LContador].fltBSTANT                             := AResultadoCalculoIcmsEfetivo.ValorBaseCalculoIcmsStRetidoItem;
  AMatItensResultadoIcmsEfetivo[LContador].fltVSTANT                             := AResultadoCalculoIcmsEfetivo.ValorIcmsStRetidoItem;
  AMatItensResultadoIcmsEfetivo[LContador].fltBaseOperacaoPropriaICMSEntrada     := AResultadoCalculoIcmsEfetivo.ValorBaseOperacaoPropriaICMSEntrada;
  AMatItensResultadoIcmsEfetivo[LContador].fltAliquotaOperacaoPropriaICMSEntrada := AResultadoCalculoIcmsEfetivo.AliquotaOperacaoPropriaICMSEntrada;
  AMatItensResultadoIcmsEfetivo[LContador].fltValorOperacaoPropriaIMCSEntrada    := AResultadoCalculoIcmsEfetivo.ValorOperacaoPropriaICMSEntrada;
end;

function TCalculoImpostoIcmsEfetivo.GetModelProduto(Const AContador : Integer; AParametros: TParametrosServicoIcmsEfetivo): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := FConsultaModel.ConsultarProduto(AParametros.MatItensIcmsEfetivo[AContador].strCodIte,
                                            AParametros.CodigoDaEmpresa,
                                            AParametros.CodigoDaEmpresaTE,
                                            EmptyStr,
                                            AParametros.GerandoCasosTestes);
end;

function TCalculoImpostoIcmsEfetivo.GetModelAbreviacaoIcms(Const AContador : Integer; AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor; AModelProduto: IResultadoFaturamentoImpostosModelProduto; var ATipoDeAbreviacaoFiscal : String): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := FConsultaModel.ConsultarAbreviacaoIcms(AParametros.MatItensIcmsEfetivo[AContador].strCodIte,
                                                   AModelProduto.CodigoDaAbreviacaoFiscal,
                                                   RetornaEstadoParaAbreviacao(AParametros, AModelEmpresa, AModelClienteFornecedor),
                                                   AParametros.CodigoDaEmpresaTE,
                                                   AParametros.CodigoDaEmpresa,
                                                   ATipoDeAbreviacaoFiscal,
                                                   EmptyStr);
end;

function TCalculoImpostoIcmsEfetivo.ValidarRegrasParaCalcularIcmsEfetivo(Const AContador : Integer; AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor; AModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms): Boolean;
begin
  Result := False;

  If TotalDoItemParaCalcIcmEfetivo(AContador, AParametros, AModelEmpresa, AModelClienteFornecedor) <= 0 Then
    Exit;

  If (Pos(AParametros.MatItensIcmsEfetivo[AContador].strCodFis, FConstantes.fGetCstSubstituicao) <= 0) Then
    Exit;

  If (RightStr(RetornarSituacaoTributaria(AParametros.MatItensIcmsEfetivo[AContador].strCodSit, AParametros, AModelAbreviacaoIcms), 2) <> '60') Then
    Exit;

  Result := true;
end;

function TCalculoImpostoIcmsEfetivo.SetarItemNaMatrizSemResultado : TResultadoCalculoIcmsEfetivo;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result.PercentualReducaoBaseCalcEfetivaItem := 0;
  Result.ValorBaseCalculoEfetivaItem := 0;
  Result.ValorIcmsEfetivaItem := 0;
  Result.AliquotaIcmsEfetivaItem := 0;
  Result.ValorBaseCalculoIcmsStRetidoItem := 0;
  Result.ValorIcmsStRetidoItem := 0;
  Result.ValorIcmsSubstitutoItem := 0;
  Result.ValorBaseOperacaoPropriaICMSEntrada := 0;
  Result.AliquotaOperacaoPropriaICMSEntrada := 0;
  Result.ValorOperacaoPropriaICMSEntrada := 0;
end;

function TCalculoImpostoIcmsEfetivo.RetornarUltimaNotaItem(Const ACodigoDoItem : String; Const ADadosUltimasNotas : IMyQuery): TResultadoDecodificaChaveNota;
Var
  LParametrosDecodificacao : TParametrosDecodificaChaveNota;
Begin
  FillChar(Result, SizeOf(Result), #0);

  ADadosUltimasNotas.Open;

  ADadosUltimasNotas.First;

  While Not ADadosUltimasNotas.Eof Do
  begin
    if ADadosUltimasNotas.FieldByName('ITE_CODITE').AsString <> ACodigoDoItem Then
    begin
      ADadosUltimasNotas.Next;
      Continue;
    end;

    FillChar(LParametrosDecodificacao, SizeOf(LParametrosDecodificacao), #0);
    LParametrosDecodificacao.Chave := ADadosUltimasNotas.FieldByName('ITE_NOTULT').AsString;
    LParametrosDecodificacao.TamanhoCampoDocumento := FCore.RetornarTamanhoDoCampoNumeroDoDocumento;

    Result := TFaturamentoImpostosFuncoes.DecodificaChaveNota(LParametrosDecodificacao);
    Break;
  end;
end;

procedure TCalculoImpostoIcmsEfetivo.SetarDadosDoDocumentoDaUltimaNota(Const AResultadoUltimaNota: TResultadoDecodificaChaveNota; var ADadosDocumento: TResultadoDecodificaChaveNota);
begin
  If (AResultadoUltimaNota.NumeroDoDocumento.IsEmpty) Then // Testar: If AResultadoUltimaNota = Nil Then
  begin
    ADadosDocumento.NumeroDoDocumento := '';
    ADadosDocumento.EspecieDoDocumento := '';
    ADadosDocumento.CodigoDaEmpresa := '';
    ADadosDocumento.Serie := '';
    ADadosDocumento.CodigoDoFornecedor := '';

    Exit;
  end;

  ADadosDocumento.NumeroDoDocumento := AResultadoUltimaNota.NumeroDoDocumento;
  ADadosDocumento.EspecieDoDocumento := AResultadoUltimaNota.EspecieDoDocumento;
  ADadosDocumento.CodigoDaEmpresa := AResultadoUltimaNota.CodigoDaEmpresa;
  ADadosDocumento.Serie := AResultadoUltimaNota.Serie;
  ADadosDocumento.CodigoDoFornecedor := AResultadoUltimaNota.CodigoDoFornecedor;
end;

procedure TCalculoImpostoIcmsEfetivo.SetarDadosDocumento(Const AContador : Integer; var ADadosDocumentoOprPropria : IMyQuery; AParametros: TParametrosServicoIcmsEfetivo; var AQryDadosDocumento: IMyQuery; var ADadosDocumento: TResultadoDecodificaChaveNota);
begin
  if not EncontrouDocumento(ADadosDocumento) then
  Begin
    ADadosDocumentoOprPropria.SQL.Clear;
    ADadosDocumentoOprPropria.SQL.Text := TFunctionsSQL.fGetSQLDocumentosOperacaoPropriaSemUltimaNota(AParametros.MatItensIcmsEfetivo[AContador].strIdePro,
      FCore.fFloatToSQL(FCore.fFormataFloat(AParametros.MatItensIcmsEfetivo[AContador].fltComLiq /
      AParametros.MatItensIcmsEfetivo[AContador].fltQtdIte,2)));
    ADadosDocumentoOprPropria.ParamByName('CODEMP').AsString := AParametros.MatItensIcmsEfetivo[AContador].strEmpIte;
    ADadosDocumentoOprPropria.ParamByName('CODITE').AsString := AParametros.MatItensIcmsEfetivo[AContador].strCodIte;
    ADadosDocumentoOprPropria.Open;
  End
  Else
  Begin
    ADadosDocumentoOprPropria.SQL.Clear;
    ADadosDocumentoOprPropria.SQL.Text := TFunctionsSQL.fGetSQLDocumentosOperacaoPropria(ConfiguracaoClassificacaoDeCompra, FConstantes.fGetCstSubstituicao);
    ADadosDocumentoOprPropria.ParamByName('NUMDOC').AsString := ADadosDocumento.NumeroDoDocumento;
    ADadosDocumentoOprPropria.ParamByName('ESPDOC').AsString := ADadosDocumento.EspecieDoDocumento;
    ADadosDocumentoOprPropria.ParamByName('CODEMP').AsString := ADadosDocumento.CodigoDaEmpresa;
    ADadosDocumentoOprPropria.ParamByName('SERIE_').AsString := ADadosDocumento.Serie;
    ADadosDocumentoOprPropria.ParamByName('CODFOR').AsString := ADadosDocumento.CodigoDoFornecedor;
    ADadosDocumentoOprPropria.ParamByName('CODITE').AsString := AParametros.MatItensIcmsEfetivo[AContador].strCodIte;
    ADadosDocumentoOprPropria.Open;
  End;

  If EhTintaAutomotiva(AContador, AParametros) Then
  Begin
    SetarDadosDocumentoSemUltimaNotaDeTinta(AContador, AParametros, AQryDadosDocumento);
    Exit;
  End;

  If Not EncontrouDocumento(ADadosDocumento) Then
  begin
    If AParametros.MatItensIcmsEfetivo[AContador].strIdePro = 'NOR' Then
      SetarDadosDocumentoSemUltimaNota(AContador, AParametros, AQryDadosDocumento);

    If AParametros.MatItensIcmsEfetivo[AContador].strIdePro <> 'NOR' Then
      SetarDadosDocumentoSemUltimaNotaDeTinta(AContador, AParametros, AQryDadosDocumento);

    Exit;

  end;

  AQryDadosDocumento.SQL.Text := TFunctionsSQL.GetSQLDocumentos(ConfiguracaoClassificacaoDeCompra, FConstantes.fGetCstSubstituicao);
  AQryDadosDocumento.ParamByName('NUMDOC').AsString := ADadosDocumento.NumeroDoDocumento;
  AQryDadosDocumento.ParamByName('ESPDOC').AsString := ADadosDocumento.EspecieDoDocumento;
  AQryDadosDocumento.ParamByName('CODEMP').AsString := ADadosDocumento.CodigoDaEmpresa;
  AQryDadosDocumento.ParamByName('SERIE_').AsString := ADadosDocumento.Serie;
  AQryDadosDocumento.ParamByName('CODFOR').AsString := ADadosDocumento.CodigoDoFornecedor;
  AQryDadosDocumento.ParamByName('CODITE').AsString := AParametros.MatItensIcmsEfetivo[AContador].strCodIte;
  AQryDadosDocumento.Open;
end;

function TCalculoImpostoIcmsEfetivo.RetornarChaveNota(var AQryDadosDocumento: IMyQuery; var ADadosDocumento: TResultadoDecodificaChaveNota): String;
begin
  Result := '';

  if Not EncontrouDocumento(ADadosDocumento) Then
    Exit;

  Result :=
    TFunctionFuncoesFaturamento.
      CodificaChaveNota(AQryDadosDocumento.FieldByName('DET_NUMDOC').AsString,
                        AQryDadosDocumento.FieldByName('DET_ESPDOC').AsString,
                        AQryDadosDocumento.FieldByName('DET_CODEMP').AsString,
                        AQryDadosDocumento.FieldByName('DET_SERIE_').AsString,
                        AQryDadosDocumento.FieldByName('DET_CODFOR').AsString);
end;

function TCalculoImpostoIcmsEfetivo.RetornarParametrosCalculoIcmsEfetivo(const APosicaoMatriz: integer; const AEncontrouDocumento: Boolean; AParametros: TParametrosServicoIcmsEfetivo; var ADadosDocumentoOprPropria : IMyQuery; var ADadosDocumento: TResultadoDecodificaChaveNota; var AQryDadosDocumento: IMyQuery; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor; AModelProduto: IResultadoFaturamentoImpostosModelProduto; AModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms; var ATipoDeAbreviacaoFiscal : String): TParametrosCalculoIcmsEfetivo;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result.EncontrouDocumento := AEncontrouDocumento;
  Result.Quantidade := RetornarQuantidade(APosicaoMatriz, AParametros, ADadosDocumento, AQryDadosDocumento);
  Result.QuantidadeItem := AParametros.MatItensIcmsEfetivo[APosicaoMatriz].fltQtdIte;
  Result.ClienteConsumidorFinal := AParametros.ClienteConsumidorFinal;
  Result.PercentualReducaoBaseCalcEfetiva := RetornarPercentualReducaoBase(ADadosDocumento, AQryDadosDocumento);
  Result.ValorBaseCalculoEfetiva := TotalDoItemParaCalcIcmEfetivo(APosicaoMatriz, AParametros, AModelEmpresa, AModelClienteFornecedor);
  Result.AliquotaIcmsEfetiva := AliquotaIcmsParaCalcIcmEfetivo(APosicaoMatriz, AParametros, AModelEmpresa, AModelClienteFornecedor, AModelProduto, AModelAbreviacaoIcms, ATipoDeAbreviacaoFiscal);
  Result.ValorBaseRetida := RetornarValorBaseRetida(AQryDadosDocumento, ADadosDocumento);
  Result.ValorRetido := RetornarValorRetido(AQryDadosDocumento, ADadosDocumento);
  Result.ValorIcmsSubstitutoItem := RetornarValorIcmsSubstitutoItem(AQryDadosDocumento, ADadosDocumento);
  Result.IcmsEfetivoSemUltimaNota := EhIcmsEfetivoSemUltimaNota(APosicaoMatriz, ADadosDocumento, AParametros);
  Result.ValorBaseOperacaoPropriaICMSEntrada := ADadosDocumentoOprPropria.FieldByName('BASE').AsFloat;
  Result.AliquotaOperacaoPropriaICMSEntrada := ADadosDocumentoOprPropria.FieldByName('ALIQUOTA').AsFloat;
  Result.ValorOperacaoPropriaICMSEntrada := ADadosDocumentoOprPropria.FieldByName('VALOR').AsFloat;
  Result.EncontrouDocumentoOperacaoPropriaICMSEntrada := EncontrouDocumento(ADadosDocumento);
end;

function TCalculoImpostoIcmsEfetivo.CalcularValorIcmsEfetivo(AParametros: TParametrosCalculoIcmsEfetivo): TResultadoCalculoIcmsEfetivo;
Var
  LValorIcmsEfetiva                 : Double;
  LPercentualReducaoBaseCalcEfetiva : Double;
  LValorBaseCalculoEfetiva          : Double;
  LAliquotaIcmsEfetiva              : Double;
  LValorBaseRetida                  : Double;
  LValorRetido                      : Double;
  LValorBaseCalculoIcmsStRetido     : Double;
  LValorIcmsStRetido                : Double;
  LValorIcmsSubstituto              : Double;
  LfltBaseOperacaoPropriaICMSEntrada,
  LfltAliquotaOperacaoPropriaICMSEntrada,
  LfltValorOperacaoPropriaIMCSEntrada : Double;
begin//@323
  LPercentualReducaoBaseCalcEfetiva      := 0;
  LValorBaseCalculoEfetiva               := 0;
  LAliquotaIcmsEfetiva                   := 0;
  LValorIcmsEfetiva                      := 0;
  LValorBaseCalculoIcmsStRetido          := 0;
  LValorIcmsStRetido                     := 0;
  LfltBaseOperacaoPropriaICMSEntrada     := 0;
  LfltAliquotaOperacaoPropriaICMSEntrada := 0;
  LfltValorOperacaoPropriaIMCSEntrada    := 0;

  LValorIcmsSubstituto := AParametros.ValorIcmsSubstitutoItem;

  If CalcularIcmsEfetivo(AParametros) Then
  Begin

    If (AParametros.ClienteConsumidorFinal) Then
    Begin
      LPercentualReducaoBaseCalcEfetiva := AParametros.PercentualReducaoBaseCalcEfetiva;
      LValorBaseCalculoEfetiva          := FCore.fFormataFloat(AParametros.ValorBaseCalculoEfetiva,2);
      LAliquotaIcmsEfetiva              := AParametros.AliquotaIcmsEfetiva;
      LValorIcmsEfetiva                 := FCore.fFormataFloat(LValorBaseCalculoEfetiva * LAliquotaIcmsEfetiva / 100, 2);
    End
    Else
    Begin
      LValorBaseRetida              := FCore.fFormataFloat(AParametros.ValorBaseRetida,2);
      LValorRetido                  := FCore.fFormataFloat(AParametros.ValorRetido ,2);

      LValorBaseCalculoIcmsStRetido := LValorBaseRetida * AParametros.QuantidadeItem;
      LValorIcmsStRetido            := LValorRetido * AParametros.QuantidadeItem;;

      LValorIcmsSubstituto          := FCore.fFormataFloat(LValorIcmsSubstituto / AParametros.Quantidade,2);
      LValorIcmsSubstituto          := LValorIcmsSubstituto * AParametros.QuantidadeItem;
    End;
  End;

  If (AParametros.ClienteConsumidorFinal) Then
  Begin
    LfltBaseOperacaoPropriaICMSEntrada     := AParametros.ValorBaseOperacaoPropriaICMSEntrada;
    LfltAliquotaOperacaoPropriaICMSEntrada := AParametros.AliquotaOperacaoPropriaICMSEntrada;
    LfltValorOperacaoPropriaIMCSEntrada    := AParametros.ValorOperacaoPropriaICMSEntrada;

    if AParametros.EncontrouDocumentoOperacaoPropriaICMSEntrada then
    Begin
      LfltBaseOperacaoPropriaICMSEntrada     := AParametros.ValorBaseOperacaoPropriaICMSEntrada * AParametros.QuantidadeItem;
      LfltAliquotaOperacaoPropriaICMSEntrada := AParametros.AliquotaOperacaoPropriaICMSEntrada;
      LfltValorOperacaoPropriaIMCSEntrada    := AParametros.ValorOperacaoPropriaICMSEntrada * AParametros.QuantidadeItem;
    End;
  End;

  FillChar(Result, SizeOf(Result), #0);
  Result.PercentualReducaoBaseCalcEfetivaItem := LPercentualReducaoBaseCalcEfetiva;
  Result.ValorBaseCalculoEfetivaItem := LValorBaseCalculoEfetiva;
  Result.ValorIcmsEfetivaItem := LValorIcmsEfetiva;
  Result.AliquotaIcmsEfetivaItem := LAliquotaIcmsEfetiva;
  Result.ValorBaseCalculoIcmsStRetidoItem := LValorBaseCalculoIcmsStRetido;
  Result.ValorIcmsStRetidoItem := LValorIcmsStRetido;
  Result.ValorIcmsSubstitutoItem := LValorIcmsSubstituto;
  Result.ValorBaseOperacaoPropriaICMSEntrada := LfltBaseOperacaoPropriaICMSEntrada;
  Result.AliquotaOperacaoPropriaICMSEntrada := LfltAliquotaOperacaoPropriaICMSEntrada;
  Result.ValorOperacaoPropriaICMSEntrada := LfltValorOperacaoPropriaIMCSEntrada;
end;

function TCalculoImpostoIcmsEfetivo.EncontrouDocumento(var ADadosDocumento: TResultadoDecodificaChaveNota): Boolean;
begin
  Result := ADadosDocumento.NumeroDoDocumento <> EmptyStr;
end;

function TCalculoImpostoIcmsEfetivo.CalcularIcmsEfetivoSemUltimaNota(Const AContador : Integer; AParametros: TParametrosServicoIcmsEfetivo): Boolean;
Begin
  Result := (AParametros.MatItensIcmsEfetivo[AContador].strIdePro = 'NOR');

  If not Result Then
  Begin
    Result := (FTintaDeMaquina.fGetTintaImobiliaria(AParametros.MatItensIcmsEfetivo[AContador].strIdePro));
  End;

  If not Result Then
  Begin
    Result := (FTintaDeMaquina.fGetTintaAutomotiva(AParametros.MatItensIcmsEfetivo[AContador].strIdePro));
  End;
End;

function TCalculoImpostoIcmsEfetivo.RetornarTrocaUFEndEntrega(AParametros: TParametrosServicoIcmsEfetivo; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor): String;
begin
  Result := TFaturamentoImpostosFuncoes.RetornarTrocaUFEndEntrega(AModelClienteFornecedor,
                                                                  AParametros.CodigoDaEmpresa,
                                                                  AParametros.OpcaoDoDocumento,
                                                                  DocumentoParaFornecedor(AParametros));
end;

function TCalculoImpostoIcmsEfetivo.RetornaEstadoParaAbreviacao(AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor): String;
begin
  Result := TFaturamentoImpostosFuncoes.RetornaEstadoParaAbreviacao(VendaDentroDoEstado(AParametros, AModelEmpresa, AModelClienteFornecedor), AModelEmpresa.EmpresaEstado, RetornarTrocaUFEndEntrega(AParametros, AModelClienteFornecedor));
end;

function TCalculoImpostoIcmsEfetivo.TipoDeAbreviacaoFiscal(AParametros: TParametrosServicoIcmsEfetivo; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor): String;
  Var
    LParametros : TParametrosTipoDeAbreviacaoDoCliente;
begin
  FillChar(LParametros, SizeOf(LParametros), #0);
  LParametros.CodigoDoCliente := AParametros.CodigoDoCliente;
  LParametros.CodigoDaEmpresa := AParametros.CodigoDaEmpresa;
  LParametros.ClienteConsumidorFinal := AParametros.ClienteConsumidorFinal;
  LParametros.ClienteIndustria := AParametros.ClienteIndustria;
  LParametros.InscricaoEstadual := AModelClienteFornecedor.ClienteInscricaoEstadual;
  LParametros.ClienteFisicoOuJurico := AModelClienteFornecedor.ClienteFisJur;
  LParametros.DocumentoParaFornecedor := DocumentoParaFornecedor(AParametros);
  LParametros.CodigoDaEmpresaTransferencia := AModelClienteFornecedor.CodigoDaEmpresaTransferencia;
  Result := TFaturamentoImpostosFuncoes.RetornarTipoDeAbreviacaoClienteFornecedor(LParametros);
end;

function TCalculoImpostoIcmsEfetivo.TotalDoItemParaCalcIcmEfetivo(const AContador: Integer; AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor): Double;
begin
  Result := TotalGeralDoItem(AContador, AParametros, AModelEmpresa, AModelClienteFornecedor) + RetornarValorIpi(AContador, AParametros, AModelEmpresa, AModelClienteFornecedor);
end;

function TCalculoImpostoIcmsEfetivo.RetornarSituacaoTributaria(Const ACodigoSituacaoInicial : String; AParametros: TParametrosServicoIcmsEfetivo; AModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms): String;
begin
  Result := ACodigoSituacaoInicial;

  If AParametros.GerandoCasosTestes Then
    Result := AModelAbreviacaoIcms.CodigoDaSituacaoTributaria;
end;

function TCalculoImpostoIcmsEfetivo.ConfiguracaoClassificacaoDeCompra: String;
begin
  Result := TFunctionFuncoesFaturamento.Transform(FConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACAO_COMPRA, varString),4);
end;

function TCalculoImpostoIcmsEfetivo.EhTintaAutomotiva(Const AContador : Integer; AParametros: TParametrosServicoIcmsEfetivo): Boolean;
Begin
  Result := False;

  If (AParametros.MatItensIcmsEfetivo[AContador].strIdePro <> 'NOR') Then
  Begin
    Result := (FTintaDeMaquina.fGetTintaAutomotiva(AParametros.MatItensIcmsEfetivo[AContador].strIdePro));
  End;
End;

procedure TCalculoImpostoIcmsEfetivo.SetarDadosDocumentoSemUltimaNotaDeTinta(Const AContador : Integer; AParametros: TParametrosServicoIcmsEfetivo; var AQryDadosDocumento: IMyQuery);
begin
  AQryDadosDocumento.SQL.Text := TFunctionsSQL.GetSQLDocumentosSemUltimaNotaDeTinta;
  AQryDadosDocumento.ParamByName('CODEMP').AsString := AParametros.CodigoDaEmpresa;
  AQryDadosDocumento.ParamByName('CODITE').AsString := AParametros.MatItensIcmsEfetivo[AContador].strCodIte;
  AQryDadosDocumento.ParamByName('COMLIQ').AsFloat  := FCore.fFormataFloat(AParametros.MatItensIcmsEfetivo[AContador].fltComLiq / AParametros.MatItensIcmsEfetivo[AContador].fltQtdIte,2);
  AQryDadosDocumento.Open;
end;

procedure TCalculoImpostoIcmsEfetivo.SetarDadosDocumentoSemUltimaNota(Const AContador : Integer; AParametros: TParametrosServicoIcmsEfetivo; var AQryDadosDocumento: IMyQuery);
begin
  AQryDadosDocumento.SQL.Text := TFunctionsSQL.GetSQLDocumentosSemUltimaNota;
  AQryDadosDocumento.ParamByName('CODEMP').AsString := AParametros.CodigoDaEmpresa;
  AQryDadosDocumento.ParamByName('CODITE').AsString := AParametros.MatItensIcmsEfetivo[AContador].strCodIte;
  AQryDadosDocumento.Open;
end;

function TCalculoImpostoIcmsEfetivo.RetornarQuantidade(Const AContador : Integer; AParametros: TParametrosServicoIcmsEfetivo; var ADadosDocumento: TResultadoDecodificaChaveNota; var AQryDadosDocumento: IMyQuery): Double;
begin
  Result := AParametros.MatItensIcmsEfetivo[AContador].fltQtdIte;

  If Not EncontrouDocumento(ADadosDocumento) Then
    Exit;

  Result := AQryDadosDocumento.FieldByName('DET_QTDITE').AsFloat;
end;

function TCalculoImpostoIcmsEfetivo.RetornarPercentualReducaoBase(var ADadosDocumento: TResultadoDecodificaChaveNota; var AQryDadosDocumento: IMyQuery): Double;
begin
  Result := 0;

  If Not EncontrouDocumento(ADadosDocumento) Then
    Exit;

  Result := AQryDadosDocumento.FieldByName('DET_PERRED').AsFloat;
end;

function TCalculoImpostoIcmsEfetivo.AliquotaIcmsParaCalcIcmEfetivo(const AContador: Integer; AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor; AModelProduto: IResultadoFaturamentoImpostosModelProduto; AModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms; var ATipoDeAbreviacaoFiscal : String): Double;
begin
  Result := RetornarRegraDeTributacaoAliquotaIcms(AContador, AParametros, AModelEmpresa, AModelClienteFornecedor, AModelProduto, AModelAbreviacaoIcms, ATipoDeAbreviacaoFiscal);
end;

function TCalculoImpostoIcmsEfetivo.RetornarRegraDeTributacaoAliquotaIcms(const AContador: Integer; AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor; AModelProduto: IResultadoFaturamentoImpostosModelProduto; AModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms; var ATipoDeAbreviacaoFiscal : String): Double;
begin
  Result :=
    TImpostoRegrasTributacao.New(ParametrosRegrasTributacao(AContador, AParametros, AModelEmpresa, AModelClienteFornecedor, AModelProduto, ATipoDeAbreviacaoFiscal), FConfiguracoes, FCore, AModelClienteFornecedor, AModelProduto, AModelEmpresa, AModelAbreviacaoIcms)
      .IniciarAliquotasEPercentuais
      .DentroOuForaDoEstado
      .AliquotaDeIcmsEfetivoDoItem;
end;

function TCalculoImpostoIcmsEfetivo.RetornarValorBaseRetida(var AQryDadosDocumento: IMyQuery; var ADadosDocumento: TResultadoDecodificaChaveNota): Double;
begin
  Result := AQryDadosDocumento.FieldByName('COMLIQ_IPI_FRETE_IVA').AsFloat;

  If Not EncontrouDocumento(ADadosDocumento) Then
    Exit;

  Result := CalculoValorDaBaseRetida(AQryDadosDocumento);
end;

function TCalculoImpostoIcmsEfetivo.RetornarValorRetido(var AQryDadosDocumento: IMyQuery; var ADadosDocumento: TResultadoDecodificaChaveNota): Double;
begin
  Result := AQryDadosDocumento.FieldByName('COMLIQ_IPI_FRETE_IVA_ABF').AsFloat;

  If Not EncontrouDocumento(ADadosDocumento) Then
    Exit;

  Result := CalculoValorRetido(AQryDadosDocumento);
end;

function TCalculoImpostoIcmsEfetivo.RetornarValorIcmsSubstitutoItem(var AQryDadosDocumento: IMyQuery; var ADadosDocumento: TResultadoDecodificaChaveNota): Double;
begin
  result := 0;

  if Not EncontrouDocumento(ADadosDocumento) Then
    Exit;

  result := AQryDadosDocumento.FieldByName('DET_VALICM').AsFloat;
end;

function TCalculoImpostoIcmsEfetivo.EhIcmsEfetivoSemUltimaNota(const APosicaoMatriz: integer; var ADadosDocumento: TResultadoDecodificaChaveNota; AParametros: TParametrosServicoIcmsEfetivo): Boolean;
begin
  Result := False;

  If EncontrouDocumento(ADadosDocumento) Then
    Exit;

  If Not CalcularIcmsEfetivoSemUltimaNota(APosicaoMatriz, AParametros) Then
    Exit;

  Result := True;
end;

function TCalculoImpostoIcmsEfetivo.CalcularIcmsEfetivo(const AParametros: TParametrosCalculoIcmsEfetivo): Boolean;
begin
  Result := false;

  If Not (AParametros.EncontrouDocumento) Then
    Exit;

  If (AParametros.Quantidade <= 0) Then
    Exit;

  Result := True;
end;

function TCalculoImpostoIcmsEfetivo.TotalGeralDoItem(const AContador: integer; AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor): Double;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      TotalGeralItem(AParametros.ClienteConsumidorFinal,
                     AParametros.MatItensIcmsEfetivo[AContador].fltDesEsp,
                     AParametros.MatItensIcmsEfetivo[AContador].fltValFre,
                     AParametros.MatItensIcmsEfetivo[AContador].fltTotIte,
                     AParametros.MatItensIcmsEfetivo[AContador].fltDesAce,
                     AModelClienteFornecedor.OrgaoPublico,
                     AModelClienteFornecedor.ZonaFranca,
                     VendaDentroDoEstado(AParametros, AModelEmpresa, AModelClienteFornecedor),
                     AParametros.OpcaoDoDocumento,
                     false,
                     false,
                     false);
end;

function TCalculoImpostoIcmsEfetivo.RetornarValorIpi(Const AContador : Integer; AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor) : Double;
  Var
    LParametrosCalculoValorIPI: TParametrosCalculoValorIpi;
    LCalculoImpostoIPI : TCalculoImpostoIPI;
    LResultadoCalculoIPI : TResultadoCalculoIPI;
begin
  FillChar(LParametrosCalculoValorIPI, SizeOf(LParametrosCalculoValorIPI), #0);
  FillChar(LResultadoCalculoIPI, SizeOf(LResultadoCalculoIPI), #0);

  LCalculoImpostoIPI := TCalculoImpostoIPI.Create(FCore, FConfiguracoes, FConsultaModel);
  Try
    LParametrosCalculoValorIPI := ParametrosCalculoIPI(AContador, AParametros, AModelEmpresa, AModelClienteFornecedor);
    LResultadoCalculoIPI := LCalculoImpostoIPI.CalcularValorIPI(LParametrosCalculoValorIPI);
    Result := LResultadoCalculoIPI.ValorCalculadoIPI;
  Finally
    FreeAndNil(LCalculoImpostoIPI);
  End;
end;

function TCalculoImpostoIcmsEfetivo.ParametrosCalculoIPI(Const AContador : Integer; AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor): TParametrosCalculoValorIpi;
Begin
  FillChar(Result, SizeOf(Result), #0);
  Result.CodigoDoCliente := AParametros.CodigoDoCliente;
  Result.CodigoDoProduto := AParametros.MatItensIcmsEfetivo[AContador].strCodIte;
  Result.CodigoDaEmpresa := AParametros.CodigoDaEmpresa;
  Result.TotalGeralDoItem := TotalGeralDoItem(AContador, AParametros, AModelEmpresa, AModelClienteFornecedor);
  Result.BaixaDeEntregaFutura := AParametros.BaixaDeEntregaFutura;
  Result.ClienteConsumidorFinal := AParametros.ClienteConsumidorFinal;
end;

function TCalculoImpostoIcmsEfetivo.CalculoValorDaBaseRetida(var AQryDadosDocumento: IMyQuery) : Double;
begin
  Result := AQryDadosDocumento.FieldByName('COMLIQ_IPI_FRETE_IVA').AsFloat;

  If DeterminaValorRetido(AQryDadosDocumento) = 0 Then
    Exit;

  If AQryDadosDocumento.FieldByName('DET_QTDITE').AsFloat = 0 Then
    Exit;

  Result := DeterminaValorBaseRetida(AQryDadosDocumento) / AQryDadosDocumento.FieldByName('DET_QTDITE').AsFloat;
end;

function TCalculoImpostoIcmsEfetivo.CalculoValorRetido(var AQryDadosDocumento: IMyQuery): Double;
begin
  Result := AQryDadosDocumento.FieldByName('COMLIQ_IPI_FRETE_IVA').AsFloat * 0.18;

  If DeterminaValorRetido(AQryDadosDocumento) = 0 Then
    Exit;

  If AQryDadosDocumento.FieldByName('DET_QTDITE').AsFloat = 0 Then
    Exit;

  Result := DeterminaValorRetido(AQryDadosDocumento) / AQryDadosDocumento.FieldByName('DET_QTDITE').AsFloat;
end;

function TCalculoImpostoIcmsEfetivo.DeterminaValorRetido(var AQryDadosDocumento: IMyQuery): Double;
begin
  Result := AQryDadosDocumento.FieldByName('DET_VAERET').AsFloat;

  If FConfiguracoes.fGetValorConfiguracao(CFG_OPCAO_ENVIO_ST_RETIDA_ANTERIORMENTE, VarString) = '1' Then
    Exit;

  If Result > 0 Then
    Exit;

  Result := AQryDadosDocumento.FieldByName('N27_VICMSSTRET').AsFloat;
end;

function TCalculoImpostoIcmsEfetivo.DeterminaValorBaseRetida(var AQryDadosDocumento: IMyQuery): Double;
begin
  Result := AQryDadosDocumento.FieldByName('DET_BAERET').AsFloat;

  If FConfiguracoes.fGetValorConfiguracao(CFG_OPCAO_ENVIO_ST_RETIDA_ANTERIORMENTE, VarString) = '1' Then
    Exit;

  If Result > 0 Then
    Exit;

  Result := AQryDadosDocumento.FieldByName('N26_VBCSTRET').AsFloat;
end;

function TCalculoImpostoIcmsEfetivo.ParametrosRegrasTributacao(const AContador: Integer; AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor; AModelProduto: IResultadoFaturamentoImpostosModelProduto; var ATipoDeAbreviacaoFiscal : String): TParametrosRegrasTributacao;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result.DentroDoEstado := VendaDentroDoEstado(AParametros, AModelEmpresa, AModelClienteFornecedor);
  Result.NotaDeImportacao := NotaDeImportacao(AParametros);
  Result.CodigoDaSituacaoTributaria := AParametros.MatItensIcmsEfetivo[AContador].strCodSit;
  Result.AliquotaDeIcmsDoItem := AParametros.MatItensIcmsEfetivo[AContador].fltAlqIcm;
  Result.EspecieDoDocumento := AParametros.EspecieDocumento;
  Result.UtilizaSat := AParametros.UtilizaSat;
  Result.ClienteComercializacao := AParametros.ClienteComercializacao;
  Result.CalcularSatEcf := AParametros.CalcularSatEcf;
  Result.DentroDoEstadoCFOP := DentroDoEstadoCFOP(AParametros, AModelEmpresa, AModelClienteFornecedor);
  Result.AtividadeConstrutora := AtividadeConstrutora(AParametros, AModelClienteFornecedor);
  Result.TipoOperacaoPedidoVenda := AParametros.TipoOperacaoPedidoVenda;
  Result.AlqIcmEstEmpFaturamento := AlqIcmEstEmpFaturamento(AContador, AParametros, AModelEmpresa, AModelProduto, ATipoDeAbreviacaoFiscal);
  Result.ValorDeIpiDoItem := RetornarValorIpi(AContador, AParametros, AModelEmpresa, AModelClienteFornecedor);
  Result.DocumentoParaFornecedor := DocumentoParaFornecedor(AParametros);
	Result.TotalGeralDoItem := TotalGeralDoItem(AContador, AParametros, AModelEmpresa, AModelClienteFornecedor);
  Result.ImportacaoDiretaDoItem := AModelProduto.ImportacaoDireta;
  Result.ValorUnitarioDoItem := AParametros.MatItensIcmsEfetivo[AContador].fltTotIte;
  Result.QuantidadeDoItem := AParametros.MatItensIcmsEfetivo[AContador].fltQtdIte;
  Result.AlqIcmEstEmpSimples := AlqIcmEstEmpSimples(AModelEmpresa, AModelProduto);
  Result.TipoDaAbreviacaoFiscal := ATipoDeAbreviacaoFiscal;
  Result.TotalGeralDoItemST_Simulado := TotalGeralDoItem(AContador, AParametros, AModelEmpresa, AModelClienteFornecedor);
end;

function TCalculoImpostoIcmsEfetivo.DentroDoEstadoCFOP(AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor): Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento
      .fDentroDoEstadoCFOP(AParametros.VendaPresencial, AModelClienteFornecedor.ClienteEstado, VendaDentroDoEstado(AParametros, AModelEmpresa, AModelClienteFornecedor));
end;

function TCalculoImpostoIcmsEfetivo.AtividadeConstrutora(AParametros: TParametrosServicoIcmsEfetivo; AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor): Boolean;
begin
  Result :=
    TFaturamentoImpostosFuncoes
      .AtividadeConstrutora(AModelClienteFornecedor.ClienteAtividade, AParametros.CodigoDaEmpresa);
end;

function TCalculoImpostoIcmsEfetivo.AlqIcmEstEmpFaturamento(Const AContador : Integer; AParametros: TParametrosServicoIcmsEfetivo; AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelProduto: IResultadoFaturamentoImpostosModelProduto; var ATipoDeAbreviacaoFiscal : String): Double;
  Var
    LTipoDaAbreviacaoFiscal: String;
    LModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  LTipoDaAbreviacaoFiscal := RetornarTipoDeAbreviacaoAlqIcmEstEmpFaturamento(AContador, AParametros, ATipoDeAbreviacaoFiscal); // testar bem aqui

  LModelAbreviacaoIcms := FConsultaModel.ConsultarAbreviacaoIcms(AParametros.MatItensIcmsEfetivo[AContador].strCodIte,
                                                                 AModelProduto.CodigoDaAbreviacaoFiscal,
                                                                 AModelEmpresa.EmpresaEstado,
                                                                 AParametros.CodigoDaEmpresaTE,
                                                                 AParametros.CodigoDaEmpresa,
                                                                 LTipoDaAbreviacaoFiscal,
                                                                 EmptyStr);

  Result := LModelAbreviacaoIcms.AliquotaDeIcms;
end;

function TCalculoImpostoIcmsEfetivo.RetornarTipoDeAbreviacaoAlqIcmEstEmpFaturamento(Const AContador : Integer; AParametros: TParametrosServicoIcmsEfetivo; var ATipoDeAbreviacaoFiscal : String): String;
begin
  result :=
    TFaturamentoImpostosFuncoes.
      RetornarTipoDeAbreviacaoNotaEspiritoSanto(AParametros.MatItensIcmsEfetivo[AContador].opcINFesp, ATipoDeAbreviacaoFiscal);
end;

function TCalculoImpostoIcmsEfetivo.AlqIcmEstEmpSimples(AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa; AModelProduto: IResultadoFaturamentoImpostosModelProduto): Double;
  Var
    LSQL: String;
    LDesmembrarSelectParaCampoTabela: IResultadoDesmembrarSelectParaCampoTabela;
begin
  LSQL := TFunctionFuncoesFaturamento.GetSelectAlqIcmEstEmp;

  LDesmembrarSelectParaCampoTabela := TFunctionsUtils.DesmembrarSelectParaCampoTabela(LSQL);

  Result :=
    FCore.fCampoTabela(LDesmembrarSelectParaCampoTabela.CamposSelect,
                       LDesmembrarSelectParaCampoTabela.NomeTabela,
                       LDesmembrarSelectParaCampoTabela.CampoChave,
                       [AModelProduto.CodigoDaAbreviacaoFiscal, AModelEmpresa.EmpresaEstado],
                       False).Fields(0);
end;

end.
