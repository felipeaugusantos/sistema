unit Faturamento.Impostos.Servicos.Classe.IcmsEfetivo;

interface

uses
  System.SysUtils, System.StrUtils,
  Shared.Functions.Utils,
  Faturamento.Impostos.Interfaces.Servicos.Classe.IcmsEfetivo,
  Faturamento.Impostos.Interfaces.IcmsEfetivo,
  Faturamento.Impostos.Tipos.IcmsEfetivo,
  Faturamento.Impostos.Calculos.IcmsEfetivo,

  Faturamento.Model.Empresa,
  Faturamento.Model.Cliente,
  Faturamento.Model.Fornecedor,
  Shared.Functions.Core,
  Faturamento.Impostos.Interfaces.Model,
  Faturamento.Impostos.Tipos.Model,

  Faturamento.Model.Produto,
  Faturamento.Model.AbreviacaoIcms,

  Shared.Functions.Funcoes.Faturamento,

  Faturamento.Impostos.Servicos.Classe.Ipi,
  Faturamento.Impostos.Interfaces.Ipi,
  Faturamento.Impostos.Tipos.Ipi,

  Faturamento.Impostos.Interfaces.Tributacao,
  Faturamento.Impostos.Tipos.Tributacao,
  Faturamento.Impostos.Regras.Tributacao,

  Shared.Functions.Configuracoes,
  Shared.Functions.Constantes,
  Shared.Functions.DataSet,
  Shared.Functions.SQL,
  Shared.Functions.Types,
  Shared.Functions.Faturamento.Impostos.Regras,
  Shared.Functions.Faturamento.Impostos.Regras.ZerarImpostos,

  Faturamento.Impostos.Servicos.Funcoes,
  Shared.Functions.Interfaces,
  Shared.Functions.Faturamento.TintaDeMaquina,
  Shared.Functions.Tipos;


type
  TFaturamentoImpostosServicosClasseIcmsEfetivo = class(TInterfacedObject, IFaturamentoImpostosServicosClasseIcmsEfetivo)
  private
    FParametros                  : IParametrosServicoIcmsEfetivo;
    FModelEmpresa                : IResultadoFaturamentoImpostosModelEmpresa;
    FModelClienteFornecedor      : IResultadoFaturamentoImpostosModelClienteFornecedor;
    FModelProduto                : IResultadoFaturamentoImpostosModelProduto;
    FModelAbreviacaoIcms         : IResultadoFaturamentoImpostosModelAbreviacaoIcms;
    FMatItensResultadoIcmsEfetivo: TMatrizFechamentoIcmsEfetivo;
    FDadosUltNotas               : IMyQuery;
    FDadosDocumento              : IMyQuery;
    FDadosDocumentoOprPropria    : IMyQuery;
    FTipoDeAbreviacaoFiscal      : String;
    FDocumentoParaFornecedor     : Boolean;
    FContribuinteDoRioDeJaneiro  : Boolean;
    FNumeroDocumento             : String;
    FEspecieDoDocumento          : String;
    FCodigoDaEmpresa             : String;
    FSerie                       : String;
    FCodigoDoFornecedor          : String;
    FChaveNota                   : String;

    procedure SetarModelEmpresa;
    procedure SetarModelClienteFornecedor;
    procedure SetarModelProduto(Const AContador : Integer) ;
    procedure SetarModelAbreviacaoIcms(Const AContador : Integer);

    function ValidarNormativasParaIcmsEfetivo : Boolean;

    Function ValidarNormativasIcmsEfetivo : Boolean;

    function RetornarChaveNota : String;

    function ValidarRegrasParaCalcularIcmsEfetivo(Const AContador : Integer) : Boolean;

    function RetornarTrocaUFEndEntrega: String;

    function RetornarListaFornecedorFilial: String;
    function RetornarListaDeitens : String;

    function ConfiguracaoClassificacaoDeCompra : String;

    function RetornarUltimaNotaItem(const ACodigoDoItem: String;
      const ADadosUltimasNotas: IMyQuery): IResultadoDecodificaChaveNota;

    function EncontrouDocumento: Boolean;

    function RetornarTipoDeAbreviacaoAlqIcmEstEmpFaturamento(Const AContador : Integer): String;

    procedure SetarDadosDocumento(Const AContador : Integer);

    function ParametrosCalculoIPI(Const AContador : Integer): IParametrosServicoIPI;

    function RetornarQuantidade(Const AContador : Integer) : Double;
    function RetornarPercentualReducaoBase : Double;

    function RetornarValorBaseRetida : Double;
    function CalculoValorDaBaseRetida: Double;

    function TipoDeAbreviacaoFiscal: String;

    function RetornarValorRetido : Double;
    function RetornarValorOperacaoPropriaICMSSaida : Double;
    function CalculoValorRetido: Double;

    Function TotalDoItemParaCalcIcmEfetivo(Const AContador : Integer ) : Double;
    function AliquotaIcmsParaCalcIcmEfetivo(Const AContador : Integer ) : Double;

    function RetornarValorIcmsSubstitutoItem : Double;

    function VendaDentroDoEstado : Boolean;

    function AlqIcmEstEmpSimples: Double;

    function RetornarRegraDeTributacaoAliquotaIcms(Const AContador : Integer): Double;

    function TotalGeralDoItem(const AContador: integer): Double;
    function retornarValorIpi(const AContador: Integer): Double;

    function ParametrosRegrasTributacao(const AContador: Integer): IParametrosRegrasTributacao;
    function NotaDeImportacao: Boolean;
    function DentroDoEstadoCFOP: Boolean;
    function AtividadeConstrutora: Boolean;

    function AlqIcmEstEmpFaturamento(Const AContador : Integer): Double;

    function RetornaEstadoParaAbreviacao: String;

    function RetornarResultadoSemCalcular : IResultadoServicosClasseIcmsEfetivo; Overload;

    function SetarItemNaMatrizSemResultado : IResultadoCalculoIcmsEfetivo;

    function RetornarResultadoCalculoIcmsEfetivo: IResultadoServicosClasseIcmsEfetivo;

    function RetornarSituacaoTributaria(Const ACodigoSituacaoInicial : String) : String;
    procedure SetarDadosDoDocumentoDaUltimaNota(
      const AResultadoUltimaNota: IResultadoDecodificaChaveNota);
    function RetornarParametrosCalculoIcmsEfetivo(const APosicaoMatriz: integer): IParametrosCalculoIcmsEfetivo;
    procedure SetarResultadoCalculoIcmsEfetivoNaMatrizDeItens(const AResultadoCalculoIcmsEfetivo: IResultadoCalculoIcmsEfetivo);

    function IgnorarIcmsEfetivoMatrizSemItens : Boolean;

    function CalcularIcmsEfetivoSemUltimaNota(Const AContador : Integer): Boolean;

    procedure SetarDadosDocumentoSemUltimaNota(Const AContador : Integer);

    procedure SetarDadosDocumentoSemUltimaNotaDeTinta(Const AContador : Integer);

    function EhIcmsEfetivoSemUltimaNota(const APosicaoMatriz: integer): Boolean;

    function EhTintaAutomotiva(Const AContador : Integer): Boolean;
    function DeterminaValorRetido: Double;
    function DeterminaValorBaseRetida: Double;
    function ContribuinteDoRioDeJaneiro(AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa): Boolean;
    function RetornaPrecoDeVendaParaCalculoIcmsProprioOperacaoDeVenda(const AContador : Integer) : String;
  public
    function CalcularValorIcmsEfetivo: IResultadoServicosClasseIcmsEfetivo;

    class function New(AParametros: IParametrosServicoIcmsEfetivo): IFaturamentoImpostosServicosClasseIcmsEfetivo;

    constructor Create(AParametros: IParametrosServicoIcmsEfetivo); overload;
  end;

implementation

{ TFaturamentoImpostosServicosClasseIcmsEfetivo }


function TFaturamentoImpostosServicosClasseIcmsEfetivo.RetornarListaDeitens: String;
Var
  LItem : TDadosFechamentoIcmsEfetivo;
  strLista: String;
begin
  strLista := '""';

  If (Length(FParametros.MatItensIcmsEfetivo) > 0) Then
  Begin
    strLista := '';
    For LItem In FParametros.MatItensIcmsEfetivo Do
    Begin
      TFunctionFuncoesFaturamento
        .IncrementaListaStr(LItem.strCodIte, strLista, true, true, ',', false, false);
    End;
  End;

  Result := strLista;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.RetornarListaFornecedorFilial : String;
var
  LRetornoForncedorFilial : IMyCampoTabela;
begin
  LRetornoForncedorFilial :=
    objCore.fCampoTabelaDados(TFunctionFuncoesFaturamento.GetSelectFornecedorFilial, [], []);

  Result :=
    TFunctionFuncoesFaturamento.
      RetornarListaDeFornecedorFilial(LRetornoForncedorFilial.Fields(0).AsString, true);
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.RetornarPercentualReducaoBase: Double;
begin
  Result := 0;

  If Not EncontrouDocumento Then
    Exit;

  Result := FDadosDocumento.FieldByName('DET_PERRED').AsFloat;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.RetornarQuantidade(Const AContador : Integer): Double;
begin
  Result := FParametros.MatItensIcmsEfetivo[AContador].fltQtdIte;

  If Not EncontrouDocumento Then
    Exit;

  Result := FDadosDocumento.FieldByName('DET_QTDITE').AsFloat;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.RetornarUltimaNotaItem(Const ACodigoDoItem : String; Const ADadosUltimasNotas : IMyQuery) : IResultadoDecodificaChaveNota;
Var
  LParametrosDecodificacao : IParametrosDecodificaChaveNota;
Begin
  result := Nil;

  ADadosUltimasNotas.Open;

  ADadosUltimasNotas.First;

  While Not ADadosUltimasNotas.Eof Do
  begin
    if ADadosUltimasNotas.FieldByName('ITE_CODITE').AsString <> ACodigoDoItem Then
    begin
      ADadosUltimasNotas.Next;
      Continue;
    end;

    LParametrosDecodificacao :=
        TParametrosDecodificaChaveNota.New
          .Chave(ADadosUltimasNotas.FieldByName('ITE_NOTULT').AsString)
          .TamanhoCampoDocumento( objCore.RetornarTamanhoDoCampoNumeroDoDocumento);

    result := TFunctionFuncoesFaturamento.DecodificaChaveNota(LParametrosDecodificacao);
    Break;
  end;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.DeterminaValorBaseRetida: Double;
begin
  Result := FDadosDocumento.FieldByName('DET_BAERET').AsFloat;

  If objConfiguracoes.fGetValorConfiguracao(CFG_OPCAO_ENVIO_ST_RETIDA_ANTERIORMENTE, VarString) = '1' Then
    Exit;

  If Result > 0 Then
    Exit;

  Result := FDadosDocumento.FieldByName('N26_VBCSTRET').AsFloat;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.DeterminaValorRetido: Double;
begin
  Result := FDadosDocumento.FieldByName('DET_VAERET').AsFloat;

  If FContribuinteDoRioDeJaneiro Then
    Result := Result + FDadosDocumento.FieldByName('DET_VFCPST').AsFloat;

  If objConfiguracoes.fGetValorConfiguracao(CFG_OPCAO_ENVIO_ST_RETIDA_ANTERIORMENTE, VarString) = '1' Then
    Exit;

  If Result > 0 Then
    Exit;

  Result := FDadosDocumento.FieldByName('N27_VICMSSTRET').AsFloat;

  If FContribuinteDoRioDeJaneiro Then
    Result := Result + FDadosDocumento.FieldByName('N23D_FCPST').AsFloat;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.CalculoValorDaBaseRetida : Double;
begin
  Result := FDadosDocumento.FieldByName('COMLIQ_IPI_FRETE_IVA').AsFloat;

  If DeterminaValorRetido = 0 Then
    Exit;

  If FDadosDocumento.FieldByName('DET_QTDITE').AsFloat = 0 Then
    Exit;

  Result := DeterminaValorBaseRetida / FDadosDocumento.FieldByName('DET_QTDITE').AsFloat;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.CalculoValorRetido: Double;
begin
  Result := FDadosDocumento.FieldByName('COMLIQ_IPI_FRETE_IVA').AsFloat * 0.18;

  If DeterminaValorRetido = 0 Then
    Exit;

  If FDadosDocumento.FieldByName('DET_QTDITE').AsFloat = 0 Then
    Exit;

  Result := DeterminaValorRetido / FDadosDocumento.FieldByName('DET_QTDITE').AsFloat;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.RetornarValorBaseRetida: Double;
begin
  Result := FDadosDocumento.FieldByName('COMLIQ_IPI_FRETE_IVA').AsFloat;

  If Not EncontrouDocumento Then
    Exit;

  Result := CalculoValorDaBaseRetida;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.RetornarValorIcmsSubstitutoItem: Double;
begin
  result := 0;

  if Not EncontrouDocumento Then
    Exit;

  result := FDadosDocumento.FieldByName('DET_VALICM').AsFloat;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.RetornarValorRetido: Double;
begin
  result := FDadosDocumento.FieldByName('COMLIQ_IPI_FRETE_IVA_ABF').AsFloat;

  if Not EncontrouDocumento Then
    Exit;

  result := CalculoValorRetido;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.RetornarValorOperacaoPropriaICMSSaida : Double;
begin
  Result := 0;

  If Not FDadosDocumento.FieldExists('VALOR_OP_PROPRIA_SAIDA') Then
    Exit;
  Result := FDadosDocumento.FieldByName('VALOR_OP_PROPRIA_SAIDA').AsFloat;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.EncontrouDocumento : Boolean;
begin
  result := FNumeroDocumento <> EmptyStr;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.IgnorarIcmsEfetivoMatrizSemItens: Boolean;
begin
  Result := false;

  If Length(FParametros.MatItensIcmsEfetivo) > 0 Then
    Exit;

  Result := true;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.AliquotaIcmsParaCalcIcmEfetivo(
  const AContador: Integer): Double;
begin
  Result := RetornarRegraDeTributacaoAliquotaIcms(AContador);
end;

procedure TFaturamentoImpostosServicosClasseIcmsEfetivo.SetarDadosDoDocumentoDaUltimaNota(Const AResultadoUltimaNota: IResultadoDecodificaChaveNota);
begin
  If AResultadoUltimaNota = Nil Then
  begin
    FNumeroDocumento     := '';
    FEspecieDoDocumento  := '';
    FCodigoDaEmpresa     := '';
    FSerie               := '';
    FCodigoDoFornecedor  := '';

    Exit;
  end;

  FNumeroDocumento     := AResultadoUltimaNota.NumeroDoDocumento;
  FEspecieDoDocumento  := AResultadoUltimaNota.EspecieDoDocumento;
  FCodigoDaEmpresa     := AResultadoUltimaNota.CodigoDaEmpresa;
  FSerie               := AResultadoUltimaNota.Serie;
  FCodigoDoFornecedor  := AResultadoUltimaNota.CodigoDoFornecedor;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.SetarItemNaMatrizSemResultado : IResultadoCalculoIcmsEfetivo;
begin
   Result :=
     TResultadoCalculoIcmsEfetivo.New
       .PercentualReducaoBaseCalcEfetivaItem(0)
       .ValorBaseCalculoEfetivaItem(0)
       .ValorIcmsEfetivaItem(0)
       .AliquotaIcmsEfetivaItem(0)
       .ValorBaseCalculoIcmsStRetidoItem(0)
       .ValorIcmsStRetidoItem(0)
       .ValorIcmsSubstitutoItem(0)
       .ValorBaseOperacaoPropriaICMSEntrada(0)
       .AliquotaOperacaoPropriaICMSEntrada(0)
       .ValorOperacaoPropriaICMSEntrada(0);
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.RetornarParametrosCalculoIcmsEfetivo(const APosicaoMatriz: integer): IParametrosCalculoIcmsEfetivo;
begin
  Result := TParametrosCalculoIcmsEfetivo.New()
              .EncontrouDocumento(FDadosDocumento.RecordCount > 0)
              .Quantidade(RetornarQuantidade(APosicaoMatriz))
              .QuantidadeItem(FParametros.MatItensIcmsEfetivo[APosicaoMatriz].fltQtdIte)
              .ClienteConsumidorFinal(FParametros.ClienteConsumidorFinal)
              .PercentualReducaoBaseCalcEfetiva(RetornarPercentualReducaoBase)
              .ValorBaseCalculoEfetiva(TotalDoItemParaCalcIcmEfetivo(APosicaoMatriz))
              .AliquotaIcmsEfetiva(AliquotaIcmsParaCalcIcmEfetivo(APosicaoMatriz))
              .ValorBaseRetida(RetornarValorBaseRetida)
              .ValorRetido(RetornarValorRetido)
              .ValorIcmsSubstitutoItem(RetornarValorIcmsSubstitutoItem)
              .IcmsEfetivoSemUltimaNota(EhIcmsEfetivoSemUltimaNota(APosicaoMatriz))
              .ValorBaseOperacaoPropriaICMSEntrada(FDadosDocumentoOprPropria.FieldByName('BASE').AsFloat)
              .AliquotaOperacaoPropriaICMSEntrada(FDadosDocumentoOprPropria.FieldByName('ALIQUOTA').AsFloat)
              .ValorOperacaoPropriaICMSEntrada(FDadosDocumentoOprPropria.FieldByName('VALOR').AsFloat)
              .EncontrouDocumentoOperacaoPropriaICMSEntrada(EncontrouDocumento)
              .ValorOperacaoPropriaICMSSaida(RetornarValorOperacaoPropriaICMSSaida);
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.EhIcmsEfetivoSemUltimaNota(const APosicaoMatriz: integer): Boolean;
begin
  Result := False;

  If EncontrouDocumento Then
    Exit;

  If Not CalcularIcmsEfetivoSemUltimaNota(APosicaoMatriz) Then
    Exit;

  Result := True;
end;

procedure TFaturamentoImpostosServicosClasseIcmsEfetivo.SetarResultadoCalculoIcmsEfetivoNaMatrizDeItens(const AResultadoCalculoIcmsEfetivo: IResultadoCalculoIcmsEfetivo);
Var
  Lcontador : Integer;
begin
  SetLength(FMatItensResultadoIcmsEfetivo,Length(FMatItensResultadoIcmsEfetivo) + 1);

  LContador := Length(FMatItensResultadoIcmsEfetivo) - 1;

  FMatItensResultadoIcmsEfetivo[LContador].strNotUlt                             := FChaveNota;
  FMatItensResultadoIcmsEfetivo[LContador].intOrdem                              := LContador;
  FMatItensResultadoIcmsEfetivo[LContador].strCodite                             := FParametros.MatItensIcmsEfetivo[LContador].strCodIte;
  FMatItensResultadoIcmsEfetivo[LContador].fltPICMEF                             := AResultadoCalculoIcmsEfetivo.PercentualReducaoBaseCalcEfetivaItem;
  FMatItensResultadoIcmsEfetivo[LContador].fltBICMEF                             := AResultadoCalculoIcmsEfetivo.ValorBaseCalculoEfetivaItem;
  FMatItensResultadoIcmsEfetivo[LContador].fltAICMEF                             := AResultadoCalculoIcmsEfetivo.AliquotaIcmsEfetivaItem;
  FMatItensResultadoIcmsEfetivo[LContador].fltVICMEF                             := AResultadoCalculoIcmsEfetivo.ValorIcmsEfetivaItem;
  FMatItensResultadoIcmsEfetivo[LContador].fltSICMEF                             := AResultadoCalculoIcmsEfetivo.ValorIcmsSubstitutoItem;
  FMatItensResultadoIcmsEfetivo[LContador].fltBSTANT                             := AResultadoCalculoIcmsEfetivo.ValorBaseCalculoIcmsStRetidoItem;
  FMatItensResultadoIcmsEfetivo[LContador].fltVSTANT                             := AResultadoCalculoIcmsEfetivo.ValorIcmsStRetidoItem;
  FMatItensResultadoIcmsEfetivo[LContador].fltBaseOperacaoPropriaICMSEntrada     := AResultadoCalculoIcmsEfetivo.ValorBaseOperacaoPropriaICMSEntrada;
  FMatItensResultadoIcmsEfetivo[LContador].fltAliquotaOperacaoPropriaICMSEntrada := AResultadoCalculoIcmsEfetivo.AliquotaOperacaoPropriaICMSEntrada;
  FMatItensResultadoIcmsEfetivo[LContador].fltValorOperacaoPropriaIMCSEntrada    := AResultadoCalculoIcmsEfetivo.ValorOperacaoPropriaICMSEntrada;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.RetornarResultadoCalculoIcmsEfetivo :IResultadoServicosClasseIcmsEfetivo;
Var
  LResultadoUltimaNota : IResultadoDecodificaChaveNota;
  LContador : Integer;
  LParametrosCalculoIcmsEfetivo: IParametrosCalculoIcmsEfetivo;
  LResultadoCalculoIcmsEfetivo : IResultadoCalculoIcmsEfetivo;
begin
  FDadosUltNotas := objDataSet.CreateQuery;
  FDadosUltNotas.SQL.Text :=
    TFunctionsSQL.GetSQLUltimasNotas(RetornarListaDeitens,
                                     RetornarListaFornecedorFilial,
                                     FParametros.CodigoDaEmpresa);

  FDadosDocumento            := objDataSet.CreateQuery;
  FDadosDocumentoOprPropria  := objDataSet.CreateQuery;

  SetLength(FMatItensResultadoIcmsEfetivo,0);

  For LContador := Low(FParametros.MatItensIcmsEfetivo) To High(FParametros.MatItensIcmsEfetivo) Do
  begin
    SetarModelProduto(LContador);
    SetarModelAbreviacaoIcms(LContador);

    If not ValidarRegrasParaCalcularIcmsEfetivo(LContador) Then
    begin
      FChaveNota := '';
      SetarResultadoCalculoIcmsEfetivoNaMatrizDeItens(SetarItemNaMatrizSemResultado);
      Continue;
    end;

    LResultadoUltimaNota :=
      RetornarUltimaNotaItem(FParametros.MatItensIcmsEfetivo[LContador].strCodIte, FDadosUltNotas);

    SetarDadosDoDocumentoDaUltimaNota(LResultadoUltimaNota);
    SetarDadosDocumento(LContador);

    FChaveNota := RetornarChaveNota;

    LParametrosCalculoIcmsEfetivo := RetornarParametrosCalculoIcmsEfetivo(LContador);

    LResultadoCalculoIcmsEfetivo:=
      TCalculoImpostosIcmsEfetivo.New.
        CalcularValorIcmsEfetivo(LParametrosCalculoIcmsEfetivo);

    SetarResultadoCalculoIcmsEfetivoNaMatrizDeItens(LResultadoCalculoIcmsEfetivo);

    If not EncontrouDocumento Then
    Begin
      If not CalcularIcmsEfetivoSemUltimaNota(LContador) Then
      Begin
        FMatItensResultadoIcmsEfetivo[LContador].strNotUlt := '';
        FMatItensResultadoIcmsEfetivo[LContador].fltPICMEF := 0;
        FMatItensResultadoIcmsEfetivo[LContador].fltBICMEF := 0;
        FMatItensResultadoIcmsEfetivo[LContador].fltAICMEF := 0;
        FMatItensResultadoIcmsEfetivo[LContador].fltVICMEF := 0;
        FMatItensResultadoIcmsEfetivo[LContador].fltSICMEF := 0;
        FMatItensResultadoIcmsEfetivo[LContador].fltBSTANT := 0;
        FMatItensResultadoIcmsEfetivo[LContador].fltVSTANT := 0;
        FMatItensResultadoIcmsEfetivo[LContador].fltBaseOperacaoPropriaICMSEntrada     := 0;
        FMatItensResultadoIcmsEfetivo[LContador].fltAliquotaOperacaoPropriaICMSEntrada := 0;
        FMatItensResultadoIcmsEfetivo[LContador].fltValorOperacaoPropriaIMCSEntrada    := 0;
      End;
    End;

  end;

  Result :=
    TResultadoServicosClasseIcmsEfetivo.New
      .ParametrosCalculoIcmsEfetivo(LParametrosCalculoIcmsEfetivo)
      .ResultadoCalculoIcmsEfetivo(FMatItensResultadoIcmsEfetivo);
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.CalcularValorIcmsEfetivo: IResultadoServicosClasseIcmsEfetivo;
begin
  If IgnorarIcmsEfetivoMatrizSemItens Then
    Exit;

  If Not ValidarNormativasIcmsEfetivo Then
  begin
    Result := RetornarResultadoSemCalcular;
    Exit;
  end;

  Result := RetornarResultadoCalculoIcmsEfetivo;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.CalcularIcmsEfetivoSemUltimaNota(Const AContador : Integer): Boolean;
Begin
  Result := (FParametros.MatItensIcmsEfetivo[AContador].strIdePro = 'NOR');

  If not Result Then
  Begin
    Result := (ObjTintaDeMaquina.fGetTintaImobiliaria(FParametros.MatItensIcmsEfetivo[AContador].strIdePro));
  End;

  If not Result Then
  Begin
    Result := (ObjTintaDeMaquina.fGetTintaAutomotiva(FParametros.MatItensIcmsEfetivo[AContador].strIdePro));
  End;
End;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.ConfiguracaoClassificacaoDeCompra: String;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      Transform(objConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACAO_COMPRA, varString),4);
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.NotaDeImportacao : Boolean;
begin
  result := False;

  If FParametros.OpcaoDoDocumento <> 'NC' Then
    Result := SameText(TFaturamentoImpostosServicosFuncoes.RetornarNotaDeImportacao(FParametros.MatItensIcmsEfetivo[0].strClaFis), 'S');
end;

constructor TFaturamentoImpostosServicosClasseIcmsEfetivo.Create(
  AParametros: IParametrosServicoIcmsEfetivo);
begin
  FParametros := AParametros;

  If IgnorarIcmsEfetivoMatrizSemItens Then
    Exit;

  FNumeroDocumento := '';

  FDocumentoParaFornecedor :=
    TFunctionFuncoesFaturamento.
      fDocumentoParaFornecedor(FParametros.OpcaoDoDocumento,
                               FParametros.NotaComplementoFornecedor,
                               FParametros.NotaEspecialFornecedor,
                               NotaDeImportacao,
                               FParametros.CodigoDoCliente,
                               FParametros.CodigoDoFornecedor);

  SetarModelClienteFornecedor;
  SetarModelEmpresa;

  FContribuinteDoRioDeJaneiro := ContribuinteDoRioDeJaneiro(FModelEmpresa);

  FTipoDeAbreviacaoFiscal := TipoDeAbreviacaoFiscal;
end;


class function TFaturamentoImpostosServicosClasseIcmsEfetivo.New(
  AParametros: IParametrosServicoIcmsEfetivo): IFaturamentoImpostosServicosClasseIcmsEfetivo;
begin
  Result := Self.Create(AParametros);
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.DentroDoEstadoCFOP: Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento
      .fDentroDoEstadoCFOP(FParametros.VendaPresencial, FModelClienteFornecedor.ClienteEstado, VendaDentroDoEstado);
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.AtividadeConstrutora: Boolean;
begin
  Result :=
    TFaturamentoImpostosServicosFuncoes
      .AtividadeConstrutora(FModelClienteFornecedor.ClienteAtividade, FParametros.CodigoDaEmpresa);
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.AlqIcmEstEmpFaturamento(Const AContador : Integer): Double;
Var
  LTipoDaAbreviacaoFiscal: String;
  LModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms;
  LParametros: IParametrosFaturamentoImpostosModelAbreviacaoIcms;
begin
  LTipoDaAbreviacaoFiscal := RetornarTipoDeAbreviacaoAlqIcmEstEmpFaturamento(AContador);

  LParametros :=
    TParametrosFaturamentoImpostosModelAbreviacaoIcms.New
       .CodigoDoItem(FParametros.MatItensIcmsEfetivo[AContador].strCodIte)
       .CodigoDaAbreviacaoFiscal(FModelProduto.CodigoDaAbreviacaoFiscal)
       .Estado(FModelEmpresa.EmpresaEstado)
       .CodigoDaEmpresaTE(FParametros.CodigoDaEmpresaTE)
       .CodigoDaEmpresa(FParametros.CodigoDaEmpresa)
       .TipoDaAbreviacaoFiscal(LTipoDaAbreviacaoFiscal);

  LModelAbreviacaoIcms :=
    TFaturamentoImpostosModelAbreviacaoIcms.New.Consultar(LParametros);

  Result := LModelAbreviacaoIcms.AliquotaDeIcms;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.AlqIcmEstEmpSimples: Double;
var
  LSQL: String;
  LDesmembrarSelectParaCampoTabela: IResultadoDesmembrarSelectParaCampoTabela;
begin
  LSQL := TFunctionFuncoesFaturamento.GetSelectAlqIcmEstEmp;

  LDesmembrarSelectParaCampoTabela := TFunctionsUtils.DesmembrarSelectParaCampoTabela(LSQL);

  Result :=
    objCore.fCampoTabela(LDesmembrarSelectParaCampoTabela.CamposSelect,
                         LDesmembrarSelectParaCampoTabela.NomeTabela,
                         LDesmembrarSelectParaCampoTabela.CampoChave,
                         [FModelProduto.CodigoDaAbreviacaoFiscal, FModelEmpresa.EmpresaEstado],
                         False).Fields(0);
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.ParametrosRegrasTributacao(const AContador: Integer): IParametrosRegrasTributacao;
begin
  Result :=
    TParametrosRegrasTributacao.New
      .ModelClienteFornecedor(FModelClienteFornecedor)
      .ModelProduto(FModelProduto)
      .ModelEmpresa(FModelEmpresa)
      .ModelAbreviacaoIcms(FModelAbreviacaoIcms)
      .DentroDoEstado(VendaDentroDoEstado)
      .NotaDeImportacao(NotaDeImportacao)
      .CodigoDaSituacaoTributaria(FParametros.MatItensIcmsEfetivo[AContador].strCodSit)
      .AliquotaDeIcmsDoItem(FParametros.MatItensIcmsEfetivo[AContador].fltAlqIcm)
      .EspecieDoDocumento(FParametros.EspecieDocumento)
      .UtilizaSat(FParametros.UtilizaSat)
      .ClienteComercializacao(FParametros.ClienteComercializacao)
      .CalcularSatEcf(FParametros.CalcularSatEcf)
      .DentroDoEstadoCFOP(DentroDoEstadoCFOP)
      .AtividadeConstrutora(AtividadeConstrutora)
      .TipoOperacaoPedidoVenda(FParametros.TipoOperacaoPedidoVenda)
      .AlqIcmEstEmpFaturamento(AlqIcmEstEmpFaturamento(AContador))
      .ValorDeIpiDoItem(retornarValorIpi(AContador))
      .DocumentoParaFornecedor(FDocumentoParaFornecedor)
	    .TotalGeralDoItem(TotalGeralDoItem(AContador))
      .ImportacaoDiretaDoItem(FModelProduto.ImportacaoDireta)
      .ValorUnitarioDoItem(FParametros.MatItensIcmsEfetivo[AContador].fltTotIte)
      .QuantidadeDoItem(FParametros.MatItensIcmsEfetivo[AContador].fltQtdIte)
      .AlqIcmEstEmpSimples(AlqIcmEstEmpSimples)
      .TipoDaAbreviacaoFiscal(FTipoDeAbreviacaoFiscal)
      .TotalGeralDoItemST_Simulado(TotalGeralDoItem(AContador));
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.RetornarRegraDeTributacaoAliquotaIcms(const AContador: Integer): Double;
begin
  Result :=
    TFaturamentoImpostosRegrasTributacao.New(ParametrosRegrasTributacao(AContador))
      .IniciarAliquotasEPercentuais
      .DentroOuForaDoEstado
      .AliquotaDeIcmsEfetivoDoItem;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.RetornarResultadoSemCalcular: IResultadoServicosClasseIcmsEfetivo;
Var
  LContador : Integer;
  LParametrosCalculoIcmsEfetivo: IParametrosCalculoIcmsEfetivo;
  LMatItensIcmsEfetivo         : TMatrizFechamentoIcmsEfetivo;
begin
  For LContador := Low(FParametros.MatItensIcmsEfetivo) To High(FParametros.MatItensIcmsEfetivo) Do
  begin
    SetLength(LMatItensIcmsEfetivo,Length(LMatItensIcmsEfetivo) + 1);

    LMatItensIcmsEfetivo[LContador].strNotUlt := '';
    LMatItensIcmsEfetivo[LContador].intOrdem  := LContador;
    LMatItensIcmsEfetivo[LContador].strCodite := FParametros.MatItensIcmsEfetivo[LContador].strCodIte;
    LMatItensIcmsEfetivo[LContador].fltPICMEF := 0;
    LMatItensIcmsEfetivo[LContador].fltBICMEF := 0;
    LMatItensIcmsEfetivo[LContador].fltAICMEF := 0;
    LMatItensIcmsEfetivo[LContador].fltVICMEF := 0;
    LMatItensIcmsEfetivo[LContador].fltSICMEF := 0;
    LMatItensIcmsEfetivo[LContador].fltBSTANT := 0;
    LMatItensIcmsEfetivo[LContador].fltVSTANT := 0;
  end;

  Result :=
    TResultadoServicosClasseIcmsEfetivo.New
      .ParametrosCalculoIcmsEfetivo(LParametrosCalculoIcmsEfetivo)
      .ResultadoCalculoIcmsEfetivo(LMatItensIcmsEfetivo);
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.RetornarSituacaoTributaria(Const ACodigoSituacaoInicial : String): String;
begin
  Result := ACodigoSituacaoInicial;

  If FParametros.GerandoCasosTestes Then
    Result := FModelAbreviacaoIcms.CodigoDaSituacaoTributaria;
end;


function TFaturamentoImpostosServicosClasseIcmsEfetivo.RetornarChaveNota: String;
begin
  Result := '';

  if Not EncontrouDocumento Then
    Exit;

  Result :=
    TFunctionFuncoesFaturamento.
      CodificaChaveNota(FDadosDocumento.FieldByName('DET_NUMDOC').AsString,
                        FDadosDocumento.FieldByName('DET_ESPDOC').AsString,
                        FDadosDocumento.FieldByName('DET_CODEMP').AsString,
                        FDadosDocumento.FieldByName('DET_SERIE_').AsString,
                        FDadosDocumento.FieldByName('DET_CODFOR').AsString);
end;

procedure TFaturamentoImpostosServicosClasseIcmsEfetivo.SetarDadosDocumentoSemUltimaNota(Const AContador : Integer);
begin
  FDadosDocumento.SQL.Text := TFunctionsSQL.GetSQLDocumentosSemUltimaNota(RetornaPrecoDeVendaParaCalculoIcmsProprioOperacaoDeVenda(AContador));
  FDadosDocumento.ParamByName('CODEMP').AsString := FParametros.CodigoDaEmpresa;
  FDadosDocumento.ParamByName('CODITE').AsString := FParametros.MatItensIcmsEfetivo[AContador].strCodIte;
  FDadosDocumento.Open;
end;

procedure TFaturamentoImpostosServicosClasseIcmsEfetivo.SetarDadosDocumentoSemUltimaNotaDeTinta(Const AContador : Integer);
begin
  FDadosDocumento.SQL.Text := TFunctionsSQL.GetSQLDocumentosSemUltimaNotaDeTinta(RetornaPrecoDeVendaParaCalculoIcmsProprioOperacaoDeVenda(AContador));
  FDadosDocumento.ParamByName('CODEMP').AsString := FParametros.CodigoDaEmpresa;
  FDadosDocumento.ParamByName('CODITE').AsString := FParametros.MatItensIcmsEfetivo[AContador].strCodIte;
  FDadosDocumento.ParamByName('COMLIQ').AsFloat  := objCore.fFormataFloat(FParametros.MatItensIcmsEfetivo[AContador].fltComLiq / FParametros.MatItensIcmsEfetivo[AContador].fltQtdIte,2);
  FDadosDocumento.Open;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.EhTintaAutomotiva(Const AContador : Integer): Boolean;
Begin
  Result := False;

  If (FParametros.MatItensIcmsEfetivo[AContador].strIdePro <> 'NOR') Then
  Begin
    Result := (ObjTintaDeMaquina.fGetTintaAutomotiva(FParametros.MatItensIcmsEfetivo[AContador].strIdePro));
  End;
End;

procedure TFaturamentoImpostosServicosClasseIcmsEfetivo.SetarDadosDocumento(Const AContador : Integer);
begin
  if not EncontrouDocumento then
  Begin
    FDadosDocumentoOprPropria.SQL.Clear;
    FDadosDocumentoOprPropria.SQL.Text := TFunctionsSQL.fGetSQLDocumentosOperacaoPropriaSemUltimaNota(FParametros.MatItensIcmsEfetivo[AContador].strIdePro,
      objCore.fFloatToSQL(objCore.fFormataFloat(FParametros.MatItensIcmsEfetivo[AContador].fltComLiq /
      FParametros.MatItensIcmsEfetivo[AContador].fltQtdIte,2)));
    FDadosDocumentoOprPropria.ParamByName('CODEMP').AsString := FParametros.MatItensIcmsEfetivo[AContador].strEmpIte;
    FDadosDocumentoOprPropria.ParamByName('CODITE').AsString := FParametros.MatItensIcmsEfetivo[AContador].strCodIte;
    FDadosDocumentoOprPropria.Open;
  End
  Else
  Begin
    FDadosDocumentoOprPropria.SQL.Clear;
    FDadosDocumentoOprPropria.SQL.Text := TFunctionsSQL.fGetSQLDocumentosOperacaoPropria(ConfiguracaoClassificacaoDeCompra, objConstantes.fGetCstSubstituicao);
    FDadosDocumentoOprPropria.ParamByName('NUMDOC').AsString := FNumeroDocumento;
    FDadosDocumentoOprPropria.ParamByName('ESPDOC').AsString := FEspecieDoDocumento;
    FDadosDocumentoOprPropria.ParamByName('CODEMP').AsString := FCodigoDaEmpresa;
    FDadosDocumentoOprPropria.ParamByName('SERIE_').AsString := FSerie;
    FDadosDocumentoOprPropria.ParamByName('CODFOR').AsString := FCodigoDoFornecedor;
    FDadosDocumentoOprPropria.ParamByName('CODITE').AsString := FParametros.MatItensIcmsEfetivo[AContador].strCodIte;
    FDadosDocumentoOprPropria.Open;
  End;

  If EhTintaAutomotiva(AContador) Then
  Begin
    SetarDadosDoDocumentoDaUltimaNota(nil);
    SetarDadosDocumentoSemUltimaNotaDeTinta(AContador);
    Exit;
  End;

  If Not EncontrouDocumento Then
  begin
    If FParametros.MatItensIcmsEfetivo[AContador].strIdePro = 'NOR' Then
      SetarDadosDocumentoSemUltimaNota(AContador);

    If FParametros.MatItensIcmsEfetivo[AContador].strIdePro <> 'NOR' Then
      SetarDadosDocumentoSemUltimaNotaDeTinta(AContador);

    Exit;

  end;

  FDadosDocumento.SQL.Text := TFunctionsSQL.GetSQLDocumentos(ConfiguracaoClassificacaoDeCompra, objConstantes.fGetCstSubstituicao);
  FDadosDocumento.ParamByName('NUMDOC').AsString := FNumeroDocumento;
  FDadosDocumento.ParamByName('ESPDOC').AsString := FEspecieDoDocumento;
  FDadosDocumento.ParamByName('CODEMP').AsString := FCodigoDaEmpresa;
  FDadosDocumento.ParamByName('SERIE_').AsString := FSerie;
  FDadosDocumento.ParamByName('CODFOR').AsString := FCodigoDoFornecedor;
  FDadosDocumento.ParamByName('CODITE').AsString := FParametros.MatItensIcmsEfetivo[AContador].strCodIte;
  FDadosDocumento.Open;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.ParametrosCalculoIPI(
  Const AContador : Integer): IParametrosServicoIPI;
Begin
  result :=
    TParametrosServicoIPI.New
      .CodigoDoCliente(FParametros.CodigoDoCliente)
      .ClienteConsumidorFinal(FParametros.ClienteConsumidorFinal)
      .CodigoDoProduto(FParametros.MatItensIcmsEfetivo[AContador].strCodIte)
      .CodigoDaEmpresa(FParametros.CodigoDaEmpresa)
      .ClassificacaoFiscalDoItem('')
      .VendaPresencial(false)
      .EspecieDoDocumento('')
      .DesmembrarNotaProdutosServicos(false)
      .OpcaoDoDocumento('')
      .OpcaoDeItemNfEspiritoSanto(opcVazio)
      .DesmembrarMeiaNotaComNotaNormal(false)
      .BaixaDeEntregaFutura(FParametros.BaixaDeEntregaFutura)
      .EntregaFutura(false)
      .MeiaNotaFatorExpedicao(false)
      .TotalGeralDoItem(TotalGeralDoItem(AContador))
      .ValorFreteDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .DescontoEspecial(0)
      .SequencialEnderecoEntrega('')
      .NotaComplementoFornecedor(false)
      .NotaEspecialFornecedor(false)
      .CodigoDoFornecedor('')
      .GerandoCasosTestes(FParametros.GerandoCasosTestes)
      .CodigoDaFazenda('');
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.TipoDeAbreviacaoFiscal: String;
Var
  LParametros : IParametrosTipoDeAbreviacaoDoCliente;
begin
  LParametros :=
    TParametrosTipoDeAbreviacaoDoCliente.New
      .CodigoDoCliente(FParametros.CodigoDoCliente)
      .CodigoDaEmpresa(FParametros.CodigoDaEmpresa)
      .ClienteConsumidorFinal(FParametros.ClienteConsumidorFinal)
      .ClienteIndustria(FParametros.ClienteIndustria)
      .InscricaoEstadual(FModelClienteFornecedor.ClienteInscricaoEstadual)
      .ClienteFisicoOuJurico(FModelClienteFornecedor.ClienteFisJur)
      .DocumentoParaFornecedor(FDocumentoParaFornecedor)
      .CodigoDaEmpresaTransferencia(FModelClienteFornecedor.CodigoDaEmpresaTransferencia);

  Result :=
    TFaturamentoImpostosServicosFuncoes
      .RetornarTipoDeAbreviacaoClienteFornecedor(LParametros);
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.TotalDoItemParaCalcIcmEfetivo(
  const AContador: Integer): Double;
begin
  Result := TotalGeralDoItem(AContador)+ retornarValorIpi(AContador);
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.retornarValorIpi(Const AContador : Integer) : Double;
Var
  LResultadoServicosClasseIPI: IResultadoServicosClasseIPI;
  LParametrosCalculoIPI: IParametrosServicoIPI;
begin
  LParametrosCalculoIPI := ParametrosCalculoIPI(AContador);

  LResultadoServicosClasseIPI :=
    TFaturamentoImpostosServicosClasseIpi.New(LParametrosCalculoIPI).CalcularValorIpi;

  result := LResultadoServicosClasseIPI.ResultadoCalculoIPI.ValorCalculadoIPI;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.RetornarTipoDeAbreviacaoAlqIcmEstEmpFaturamento(Const AContador : Integer): String;
begin
  result :=
    TFaturamentoImpostosServicosFuncoes.
      RetornarTipoDeAbreviacaoNotaEspiritoSanto(FParametros.MatItensIcmsEfetivo[AContador].opcINFesp, FTipoDeAbreviacaoFiscal);
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.RetornarTrocaUFEndEntrega : String;
begin
  Result :=
    TFaturamentoImpostosServicosFuncoes.
      RetornarTrocaUFEndEntrega(FModelClienteFornecedor,
                                FParametros.CodigoDaEmpresa,
                                FParametros.OpcaoDoDocumento,
                                FDocumentoParaFornecedor);
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.RetornaEstadoParaAbreviacao: String;
begin
  result :=
    TFaturamentoImpostosServicosFuncoes.
      RetornaEstadoParaAbreviacao(VendaDentroDoEstado,
                                  FModelEmpresa.EmpresaEstado,
                                  RetornarTrocaUFEndEntrega);
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.RetornaPrecoDeVendaParaCalculoIcmsProprioOperacaoDeVenda(const AContador : Integer) : String;
  Var
    LUnitario : Double;
begin
  Result := EmptyStr;

  If objConfiguracoes.fGetValorConfiguracao(CFG_DEDUZIR_ICMS_PROPRIO_COM_BASE_NA_OPERACAO_VENDA_TAG_EFETIVO_VICMSSTRET, VarString) <> 'S' Then
    Exit;

  LUnitario := FParametros.MatItensIcmsEfetivo[AContador].fltTotIte - FParametros.MatItensIcmsEfetivo[AContador].fltDesEsp;

  If (objCore.fFormataFloat(LUnitario, 2) <= 0) Then
    Exit;

  If (objCore.fFormataFloat(FParametros.MatItensIcmsEfetivo[AContador].fltQtdIte, 2) <= 0) Then
    Exit;

  LUnitario := objCore.fFormataFloat(LUnitario / FParametros.MatItensIcmsEfetivo[AContador].fltQtdIte, 2);

  If (objCore.fFormataFloat(LUnitario, 2) <= 0) Then
    Exit;

  Result := objCore.fFloatToSQL(LUnitario);
end;

procedure TFaturamentoImpostosServicosClasseIcmsEfetivo.SetarModelAbreviacaoIcms(Const AContador : Integer);
var
  LParametros: IParametrosFaturamentoImpostosModelAbreviacaoIcms;
begin
  LParametros :=
    TParametrosFaturamentoImpostosModelAbreviacaoIcms.New
       .CodigoDoItem(FParametros.MatItensIcmsEfetivo[AContador].strCodIte)
       .CodigoDaAbreviacaoFiscal(FModelProduto.CodigoDaAbreviacaoFiscal)
       .Estado(RetornaEstadoParaAbreviacao)
       .CodigoDaEmpresaTE(FParametros.CodigoDaEmpresaTE)
       .CodigoDaEmpresa(FParametros.CodigoDaEmpresa)
       .TipoDaAbreviacaoFiscal(FTipoDeAbreviacaoFiscal);

  FModelAbreviacaoIcms :=
    TFaturamentoImpostosModelAbreviacaoIcms.New.Consultar(LParametros);
end;

procedure TFaturamentoImpostosServicosClasseIcmsEfetivo.SetarModelClienteFornecedor;
begin
  if FDocumentoParaFornecedor Then
  begin
    FModelClienteFornecedor :=
      TFaturamentoImpostosModelFornecedor.New.Consultar(FParametros.CodigoDoCliente);
    Exit;
  end;

  FModelClienteFornecedor :=
    TFaturamentoImpostosModelCliente.New
      .Consultar(FParametros.CodigoDoCliente,
                 FParametros.SequencialEnderecoEntrega,
                 FParametros.GerandoCasosTestes,
                 FParametros.ClienteConsumidorFinal,
                 FParametros.ParametrosClienteConsumidor);
end;

procedure TFaturamentoImpostosServicosClasseIcmsEfetivo.SetarModelEmpresa;
begin
  FModelEmpresa :=
    TFaturamentoImpostosModelEmpresa.New.Consultar(FParametros.CodigoDaEmpresa);
end;

procedure TFaturamentoImpostosServicosClasseIcmsEfetivo.SetarModelProduto(Const AContador : Integer);
begin
  FModelProduto :=
    TFaturamentoImpostosModelProduto.New
      .Consultar(FParametros.MatItensIcmsEfetivo[AContador].strCodIte,
                 FParametros.CodigoDaEmpresa,
                 FParametros.CodigoDaEmpresaTE,
                 EmptyStr,
                 FParametros.GerandoCasosTestes);
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.TotalGeralDoItem(
  const AContador: integer): Double;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      TotalGeralItem(FParametros.ClienteConsumidorFinal,
                     FParametros.MatItensIcmsEfetivo[AContador].fltDesEsp,
                     FParametros.MatItensIcmsEfetivo[AContador].fltValFre,
                     FParametros.MatItensIcmsEfetivo[AContador].fltTotIte,
                     FParametros.MatItensIcmsEfetivo[AContador].fltDesAce,
                     FModelClienteFornecedor.OrgaoPublico,
                     FModelClienteFornecedor.ZonaFranca,
                     VendaDentroDoEstado,
                     FParametros.OpcaoDoDocumento,
                     false,
                     false,
                     false);

end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.ValidarNormativasParaIcmsEfetivo: Boolean;
begin
  Result := true;

  If objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZAR_NORMATIVA_48_ESTORNO_ICMS, varBoolean) Then
    Exit;

  If objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZAR_NORMATIVA_48_ICMS_EFETIVO, varBoolean) Then
    Exit;

  If objConfiguracoes.fGetValorConfiguracao(CFG_ENVIAR_REPASSE_ICMS_COBRADO_ANTERIORMENTE_POR_SUBSTITUICAO_TRIBUTARIA, varBoolean) Then
    Exit;

  Result := false;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.ValidarRegrasParaCalcularIcmsEfetivo(Const AContador : Integer): Boolean;
begin
  Result := False;

  If TotalDoItemParaCalcIcmEfetivo(AContador)<= 0 Then
    Exit;

  If (Pos(FParametros.MatItensIcmsEfetivo[AContador].strCodFis, objConstantes.fGetCstSubstituicao) <= 0) Then
    Exit;

  If (RightStr(RetornarSituacaoTributaria(FParametros.MatItensIcmsEfetivo[AContador].strCodSit), 2) <> '60') Then
    Exit;

  Result := true;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.VendaDentroDoEstado: Boolean;
begin
  Result :=
    TFaturamentoImpostosServicosFuncoes.
      VendaDentroDoEstado(RetornarTrocaUFEndEntrega,
                          FModelEmpresa.EmpresaEstado,
                          FParametros.VendaPresencial)
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.ValidarNormativasIcmsEfetivo: Boolean;
begin
  result := false;

  If Not ValidarNormativasParaIcmsEfetivo Then
    Exit;

  If Not VendaDentroDoEstado Then
    Exit;

  result := true;
end;

function TFaturamentoImpostosServicosClasseIcmsEfetivo.ContribuinteDoRioDeJaneiro(AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa): Boolean;
begin
  Result := (AModelEmpresa.EmpresaEstado = 'RJ');
end;

end.
