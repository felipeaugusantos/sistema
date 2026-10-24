unit untCalcularMargemLucro;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  UniClientDataSet,
{$ENDIF}
  System.Generics.Collections,
  Shared.Functions.Configuracoes,
  Faturamento.Margem.Interfaces.MargemVenda,
  Faturamento.Margem.Tipos.MargemVenda,
  Controller.Faturamento.Margem.MargemVenda,
  System.SysUtils,
  Shared.Functions.Core;

  {untFuncoesSimples}

type
  ICalcularMargemLucro = interface
    ['{C60AEDED-F87A-4591-9741-963E6374EC4D}']

    function MontarListaDeParamatrosParaCalculoDaMargemDeLucro(cdsDados: TUniClientDataSet): ICalcularMargemLucro;

    function CalcularMargemDeLucro: TList<IResultadoCalculoMargemVenda>;
  end;

type
  TCalcularMargemLucro = class sealed(TInterfacedObject, ICalcularMargemLucro)
  private
    FListaParamatrosCalculoMargem: TList<IParametrosServicoMargemVenda>;
    FBlnProcessarTodosRegistros: Boolean;
    FstrConfiguracaoMargemMarkup: String;

    procedure ProcessarTodosOsRegistros(cdsDados: TUniClientDataSet);

    procedure ProcessarApenasUmRegistro(cdsDados: TUniClientDataSet);

    function RetornarOsParametrosServicoMargemVenda(cdsDados: TUniClientDataSet): IParametrosServicoMargemVenda;
  public

    function MontarListaDeParamatrosParaCalculoDaMargemDeLucro(cdsDados: TUniClientDataSet): ICalcularMargemLucro;

    function CalcularMargemDeLucro: TList<IResultadoCalculoMargemVenda>;

    constructor Create(blnProcessarTodosRegistros: Boolean; strConfiguracaoMargemMarkup: String); overload;

    destructor Destroy; override;

    class function New(blnProcessarTodosRegistros: Boolean; strConfiguracaoMargemMarkup: String=''): ICalcularMargemLucro;
  end;

implementation

{ TCalcularMargemLucro }

function TCalcularMargemLucro.CalcularMargemDeLucro: TList<IResultadoCalculoMargemVenda>;
begin
  Result := TControllerFaturamentoMargemVenda.New.CalculaMargemVenda(FListaParamatrosCalculoMargem, FstrConfiguracaoMargemMarkup);
  Exit;
end;

constructor TCalcularMargemLucro.Create(blnProcessarTodosRegistros: Boolean; strConfiguracaoMargemMarkup: String);
begin
  FListaParamatrosCalculoMargem := TList<IParametrosServicoMargemVenda>.Create;
  FBlnProcessarTodosRegistros := blnProcessarTodosRegistros;
  FstrConfiguracaoMargemMarkup := strConfiguracaoMargemMarkup;
end;

destructor TCalcularMargemLucro.Destroy;
begin
  FreeAndNil(FListaParamatrosCalculoMargem);

  inherited;
end;

function TCalcularMargemLucro.MontarListaDeParamatrosParaCalculoDaMargemDeLucro(cdsDados: TUniClientDataSet): ICalcularMargemLucro;
begin
  Result := Self;

  If FBlnProcessarTodosRegistros Then
  Begin
    ProcessarTodosOsRegistros(cdsDados);
    Exit;
  End;

  ProcessarApenasUmRegistro(cdsDados);
end;

class function TCalcularMargemLucro.New(blnProcessarTodosRegistros: Boolean; strConfiguracaoMargemMarkup: String=''): ICalcularMargemLucro;
begin
  Result := Self.Create(blnProcessarTodosRegistros, strConfiguracaoMargemMarkup);
end;

procedure TCalcularMargemLucro.ProcessarApenasUmRegistro(
  cdsDados: TUniClientDataSet);
begin
  FListaParamatrosCalculoMargem.Add(
    RetornarOsParametrosServicoMargemVenda(cdsDados)
  );
end;

procedure TCalcularMargemLucro.ProcessarTodosOsRegistros(
  cdsDados: TUniClientDataSet);
begin
  cdsDados.First;
  While Not cdsDados.Eof Do
  Begin
    FListaParamatrosCalculoMargem.Add(
      RetornarOsParametrosServicoMargemVenda(cdsDados)
    );

    cdsDados.Next;
  End;
end;

function TCalcularMargemLucro.RetornarOsParametrosServicoMargemVenda(
  cdsDados: TUniClientDataSet): IParametrosServicoMargemVenda;
 Var
   LImpostosFederais : Double;
   LOutrosValoresValOri : Double;
begin
  LImpostosFederais :=  cdsDados.FieldByName('ITE_IMPFED').AsFloat;
  If objConfiguracoes.fGetValorConfiguracao(CFG_DEDUZIR_ICMS_DO_PIS_COFINS_NA_PRECIFICAO, varString) = 'S' Then
    If objConfiguracoes.fGetValorConfiguracao(CFG_DEDUZIR_ICMS_PRODUTO_TRIBUTADO_DA_BASE_DE_CALCULO_DO_DEBITO, varString) = 'S' Then
      LImpostosFederais := (LImpostosFederais * (1 - (cdsDados.FieldByName('ITE_ICMCAL').AsFloat/100)));

  If (Assigned(cdsDados.FindField('ITE_OUTVAL_VALORI'))) Then
    LOutrosValoresValOri := cdsDados.FieldByName('ITE_OUTVAL_VALORI').AsFloat
  Else
    LOutrosValoresValOri := cdsDados.FieldByName('ITE_OUTVAL').AsFloat;

  Result :=
    TParametrosServicoMargemVenda.New
      .ClassificacaoFiscal(cdsDados.FieldByName('ITE_CLAFIS').AsString)
      .CarregarPedidoOrcamentoEntradaFutura(cdsDados.FieldByName('PED_ORC_ENT_FUT').AsBoolean)
      .ImpostosFederais(LImpostosFederais)
      .PrecoMedio(cdsDados.FieldByName('ITE_PREMED').AsFloat)
      .PrecoUltimaCompra(cdsDados.FieldByName('ITE_PREULT').AsFloat)
      .CalcularST(cdsDados.FieldByName('ITE_CALCST_MARGEM').AsBoolean)
      .ValorUnitarioOriginal(cdsDados.FieldByName('ITE_UNIORI').AsFloat)
      .ValorUnitario(cdsDados.FieldByName('ITE_UNITAR').AsFloat)
      .ValorDoIcms(cdsDados.FieldByName('ITE_ICMCAL').AsFloat)
      .ValorBaseDoIcms(cdsDados.FieldByName('ITE_BASICM').AsFloat)
      .ValorDoDifal(cdsDados.FieldByName('ITE_VDIFAL').AsFloat)
      .ValorDoFCP(cdsDados.FieldByName('ITE_VALFCP').AsFloat)
      .DespesasOperacionais(cdsDados.FieldByName('ITE_DESOPE').AsFloat)
      .DespesaOperacionalCliente(cdsDados.FieldByName('ITE_DESOPE_CLI').AsFloat)
      .ValorComissaoTabelaDeitens(cdsDados.FieldByName('ITE_COMTBL').AsFloat)
      .ValorDoCustoPraticado(cdsDados.FieldByName('ITE_CUSPRA').AsFloat)
      .ValorCustoDoItem(cdsDados.FieldByName('ITE_CUSITE').AsFloat)
      .OutrosValores(cdsDados.FieldByName('ITE_OUTVAL').AsFloat)
      .ValorUltimaCompraImpostos(cdsDados.FieldByName('ITE_IMPULT').AsFloat)
      .ValorDaSubstituicao(cdsDados.FieldByName('ITE_VAL_ST').AsFloat)
      .ValorDoIcmsStParteDaVenda(cdsDados.FieldByName('ITE_ICMPAV_MARGEM').AsFloat)
      .ValorCat17(objCore.IIF(cdsDados.FindField('ITE_CUSCAT') <> Nil, cdsDados.FieldByName('ITE_CUSCAT').AsFloat, 0))
      .ValorDaAliquotaDiferencaPrecoDinamicoIcms(cdsDados.FieldByName('ITE_ALQDIFICM_MKPMAR4').AsFloat)
      .ValorDaAliquotaDiferencaPrecoDinamicoMargem(cdsDados.FieldByName('ITE_CALMAR_PREDIN_MAR').AsFloat)
      .ValorDaAliquotaDiferencaPrecoDinamicoMargemLiquida(cdsDados.FieldByName('ITE_CALMAR_PREDIN_MARLIQ').AsFloat)
      .ValorDaAliquotaDiferencaPrecoDinamicoMargemMedia(cdsDados.FieldByName('ITE_ALQDIFICM_MARMED').AsFloat)
      .ValorDaAliquotaDiferencaPrecoDinamicoMargemImpostos(cdsDados.FieldByName('ITE_ALQDIFICM_MARIMP').AsFloat)
      .ValorDaAliquotaDiferencaPrecoDinamicoMargemItem(cdsDados.FieldByName('ITE_ALQDIFICM_MARITE').AsFloat)
      .ValorDaAliquotaDiferencaPrecoDinamicoMargemLucro(cdsDados.FieldByName('ITE_ALQDIFICM_MARLUC').AsFloat)
      .ValorUnitarioMargemMinima(cdsDados.FieldByName('ITE_MARMIN').AsFloat)
      .CalcularPrecoIdeal(cdsDados.FindField('ITE_PREIDE') <> Nil)
      .ValorPrecoIdeal(objCore.IIF(cdsDados.FindField('ITE_PREIDE') <> Nil, cdsDados.FieldByName('ITE_PREIDE').AsFloat, 0))
      .AliquotaIcmsPrecoIdeal(cdsDados.FieldByName('ITE_ICMSAI_PREIDE').AsFloat)
      .PrecoMedioPraticado(cdsDados.FieldByName('ITE_MEDPRA').AsFloat)
      .ValorUltimaCompraImpostosPraticado(cdsDados.FieldByName('ITE_IMPULTPRA').AsFloat)
      .ValorCustoRealPraticado(cdsDados.FieldByName('ITE_CUSREA').AsFloat)
      .MargemMinimaLiquidaPorPrecoMedio(objConfiguracoes.fGetValorConfiguracao('PRCREA', varString) = '4')
      .OutrosValoresValOri(LOutrosValoresValOri);


end;

end.
