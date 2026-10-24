unit untClasseMargemVenda;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  System.Variants, Vcl.Dialogs, System.StrUtils,
  untAbstractConsulta, untIConsulta,
  untAbstractGerarTeste, untIGerarTeste,
  untFuncoes, UniClientDataSet,
  Shared.Functions.Types,
  Uni,
  UniDataSetProvider,
  untICasosTestesLog,
  untCasosTestesLog,
  untModulo,
  Faturamento.Margem.Interfaces.MargemVenda,
  Faturamento.Margem.Tipos.MargemVenda,
  untFatCalcularMargemService,
  // Shared.Functions.Constantes,
 untParametrosComparacaoMargemVenda,
  Data.DB,
  untCasosTestesLogImpl,
  untFatCalcularImpostosService,
  Faturamento.Impostos.Calculos.TesteUnitarioLog,
  Shared.Functions.Configuracoes,
  Vcl.Forms,
  untTypes;



type
  TConsultaMargemVenda = class(TAbstractConsulta)
  private
    function RetornarColunasSQL: string;
    function RetornarTabelasSQL(const ADoctosConfirmacao: boolean): string;
    function RetornarFiltroSQL: string;
    function AjustaTabelasDocumentoConfirmacao(const ASQLTabelas: string): string;

  public
    Class function New : IConsulta;
    function fRetornarSQLMargemVenda : String; override;
  end;

Type
  TGerarTesteMargemVenda = class(TAbstractGerarTeste)
  private
    FQuantidadeRegistro: Integer;
    FResultadoServicosMargemVenda  : TList<IResultadoServicosClasseMargemVenda>;
    FResultadoComparacaoMargemVenda: TResultadoComparacao;

    FQtdeRegistrosMargemVendaProcessados: integer;
    FQtdeRegistrosMargemVendaAcerto     : integer;
    FQtdeRegistrosMargemVendaErro       : integer;
    FQtdeRegistrosMargemVendaDuplicados : Integer;
    FQtdeRegistrosMargemVendaIgnorados  : integer;

    function CalcularMargemVenda(const ADados: TUniClientDataSet): TList<IResultadoServicosClasseMargemVenda>;

    function ResultadoComparacaoMargemVenda(const ADados: TUniClientDataSet): TResultadoComparacao;

    function RetornarResultadoComparacaoMargemVenda(Const ADados : TUniClientDataSet): TResultadoComparacao;

    Procedure pTesteUnitarioLogMargemVenda(AResultadoServicosClasseMargemVenda: IResultadoServicosClasseMargemVenda; ADados: TUniClientDataSet);

    procedure ZerarRegistrosDoProcessamento;

    procedure CasosTestesLogMargemVenda(ACasosTestesLogMargemVenda: ICasosTestesLog; AResultadoComparacaoMargemVenda: TResultadoComparacao;  ADados: TUniClientDataSet);

    function CompararResultadoMargemVenda(const AResultadoCalculoMargemVenda: IResultadoCalculoMargemVenda ; const ADados: TUniClientDataSet) : Boolean;
    function CompararResultadoMargemVendaMkp(const AResultadoCalculoMargemVenda: IResultadoCalculoMargemVenda; const ADados :TUniClientDataSet) : Boolean;
    function CompararResultadoMargemVendaCusto(Const AResultadoCalculoMargemVenda: IResultadoCalculoMargemVenda; const ADados : TUniClientDataSet) : Boolean;
    function CompararResultadoMargemBrutaPraticada(Const AResultadoCalculoMargemVenda: IResultadoCalculoMargemVenda; const ADados : TUniClientDataSet) : Boolean;
    function CompararResultadoMargemLiquidaPraticada(Const AResultadoCalculoMargemVenda: IResultadoCalculoMargemVenda; const ADados : TUniClientDataSet) : Boolean;
    function CompararResultadoMargemProposta(Const AResultadoCalculoMargemVenda: IResultadoCalculoMargemVenda; const ADados : TUniClientDataSet) : Boolean;
    function CompararResultadoMargemComImpostos(Const AResultadoCalculoMargemVenda: IResultadoCalculoMargemVenda; const ADados : TUniClientDataSet) : Boolean;
    function CompararResultadoMargemVendaGeral(Const AResultadoCalculoMargemVenda: IResultadoCalculoMargemVenda; const ADados : TUniClientDataSet) : Boolean;

    procedure InicializarVariaveisRegistros;
    procedure TotalizarRegistrosProcessamento;
    procedure SetarTotaisProcessamento;

  public
    Class function New : IGerarTeste;

    Constructor Create;
    Destructor Destroy; override;

    function fGerarTesteMargemVenda(const ADados: OleVariant): Boolean; override;
  end;

implementation

{ TConsultaMargemVenda }

function TConsultaMargemVenda.AjustaTabelasDocumentoConfirmacao(
  const ASQLTabelas: string): string;
begin
  result := ASQLTabelas;
  result := AnsiReplaceStr(result, 'MOVDET', 'NOTDET');
end;

function TConsultaMargemVenda.fRetornarSQLMargemVenda: String;
const
  UNION_ALL = ' UNION ALL ';
begin
  Result := EmptyStr;
  Result := result + RetornarColunasSQL;
  Result := result + RetornarTabelasSQL(False);
  Result := result + RetornarFiltroSQL;
  Result := result + UNION_ALL;
  Result := result + RetornarColunasSQL;
  Result := result + RetornarTabelasSQL(True);
  Result := result + RetornarFiltroSQL;

end;

class function TConsultaMargemVenda.New: IConsulta;
begin
  Result := Self.Create;
end;

function TConsultaMargemVenda.RetornarColunasSQL: string;
begin
  result :=
    'SELECT '+
    '   D.DET_NUMDOC, '+
    '   D.DET_ESPDOC, '+
    '   D.DET_CODEMP, '+
    '   D.DET_CODITE, '+
    '   D.DET_CODCLI, '+
    '   D.DET_DTAENT, '+
    '   D.DET_CLAFIS, '+
    '   D.DET_CODFIS, '+
    '   D.DET_ESTADO, '+
    '   D.DET_IDEPRO, '+
    '   ITE_SEQGER, '+
    '   ENT_ITE_CLAFIS, '+
    '   ENT_ITE_PD_OR_ENT_FU, '+
    '   ENT_ITE_IMPFED, '+
    '   ENT_ITE_PREMED, '+
    '   ENT_ITE_CALCST_MARG, '+
    '   ENT_ITE_UNIORI, '+
    '   ENT_ITE_UNITAR, '+
    '   ENT_ITE_ICMCAL, '+
    '   ENT_ITE_BASICM, '+
    '   ENT_ITE_VDIFAL, '+
    '   ENT_ITE_VALFCP, '+
    '   ENT_ITE_DESOPE, '+
    '   ENT_ITE_DESOPE_CLI, '+
    '   ENT_ITE_COMTBL, '+
    '   ENT_ITE_CUSPRA, '+
    '   ENT_ITE_CUSITE, '+
    '   ENT_ITE_OUTVAL, '+
    '   ENT_ITE_IMPULT, '+
    '   ENT_ITE_VAL_ST, '+
    '   ENT_ITE_PREULT, '+
    '   ENT_ITE_ICMPAV_MARG, '+
    '   ENT_ITE_VALOR_CAT17, '+
    '   ENT_ITE_ADICM_MKPMAR, '+
    '   ENT_ITE_CM_PD_MAR, '+
    '   ENT_ITE_CM_PD_MARLIQ, '+
    '   ENT_ITE_ADICM_MARMED, '+
    '   ENT_ITE_ADICM_MARIMP, '+
    '   ENT_ITE_ADICM_MARITE, '+
    '   ENT_ITE_ADICM_MARLUC, '+
    '   ENT_ITE_MARMIN , '+
    '   ENT_ITE_CLC_PRE_IDE, '+
    '   ENT_ITE_VLR_PRE_IDE, '+
    '   ENT_ITE_ICM_PREIDE, '+
    '   SAI_ITE_IDENUM_MAR, '+
    '   SAI_ITE_PRANUM_MAR, '+
    '   SAI_ITE_PRANUM_MAR_S, '+
    '   SAI_ITE_MEDNUM_MAR, '+
    '   SAI_ITE_IMPNUM_MAR, '+
    '   SAI_ITE_PRONUM_MAR, '+
    '   SAI_ITE_MARMIN, '+
    '   SAI_ITE_CUMAZR, '+
    '   SAI_ITE_MARPRA_PRECU, '+
    '   SAI_ITE_MARPRO_PRECU, '+
    '   SAI_ITE_MARPRO_CUSIT, '+
    '   SAI_ITE_MARPRA_CUSIT, '+
    '   SAI_ITE_MARBRU_PREME, '+
    '   SAI_ITE_MARLIQ_PREME, '+
    '   SAI_ITE_MARBRU_PREUL, '+
    '   SAI_ITE_MARLIQ_PREUL, '+
    '   SAI_ITE_MARBRU_IMPUL, '+
    '   SAI_ITE_MARLIQ_IMPUL, '+
    '   SAI_ITE_PRANUM_MKP, '+
    '   SAI_ITE_PRANUM_MKP_S, '+
    '   SAI_ITE_PRONUM_MKP, '+
    '   SAI_ITE_MEDNUM_MKP, '+
    '   SAI_ITE_IMPNUM_MKP, '+
    '   SAI_ITE_MARMED, '+
    '   SAI_ITE_MARIMP, '+
    '   SAI_ITE_MARITE, '+
    '   SAI_ITE_MARLUC, '+
    '   SAI_ITE_MARCAT ';
end;

function TConsultaMargemVenda.RetornarFiltroSQL: string;
begin
  Result :=
    '  WHERE D.DET_CODEMP = :CODEMP       ' +
    '    AND D.DET_ORIDOC <> "D"          ' +
    '    AND D.DET_DTAENT BETWEEN :DTAINI ' +
    '                         AND :DTAFIM ';
end;

function TConsultaMargemVenda.RetornarTabelasSQL(const ADoctosConfirmacao: boolean): string;
begin
  result := ' FROM ESPELHO_MARGEM_LUCRO '+
            ' INNER JOIN MOVDET D ON D.AUTOINCREM = ITE_SEQGER ';


  if (not ADoctosConfirmacao) then
    Exit;

  result := AjustaTabelasDocumentoConfirmacao(Result);


end;

{ TGerarTestePrecoCusto }

function TGerarTesteMargemVenda.CalcularMargemVenda(
  const ADados: TUniClientDataSet): TList<IResultadoServicosClasseMargemVenda>;
Var
  LParametrosMargemVenda              : IParametrosServicoMargemVenda;
  LListaParametrosServicoCalculoMargem: TList<IParametrosServicoMargemVenda>;
begin
  LParametrosMargemVenda :=
    TParametrosServicoMargemVenda.New
      .ClassificacaoFiscal(ADados.FieldByName('ENT_ITE_CLAFIS').AsString)
      .CarregarPedidoOrcamentoEntradaFutura(ADados.FieldByName('ENT_ITE_PD_OR_ENT_FU').Value)
      .ImpostosFederais(ADados.FieldByName('ENT_ITE_IMPFED').AsFloat)
      .PrecoMedio(ADados.FieldByName('ENT_ITE_PREMED').AsFloat)
      .PrecoUltimaCompra(ADados.FieldByName('ENT_ITE_PREULT').AsFloat)
      .CalcularST(ADados.FieldByName('ENT_ITE_CALCST_MARG').Value)
      .ValorUnitarioOriginal(ADados.FieldByName('ENT_ITE_UNIORI').AsFloat)
      .ValorUnitario(ADados.FieldByName('ENT_ITE_UNITAR').AsFloat)
      .ValorDoIcms(ADados.FieldByName('ENT_ITE_ICMCAL').AsFloat)
      .ValorBaseDoIcms(ADados.FieldByName('ENT_ITE_BASICM').AsFloat)
      .ValorDoDifal(ADados.FieldByName('ENT_ITE_VDIFAL').AsFloat)
      .ValorDoFCP(ADados.FieldByName('ENT_ITE_VALFCP').AsFloat)
      .DespesasOperacionais(ADados.FieldByName('ENT_ITE_DESOPE').AsFloat)
      .DespesaOperacionalCliente(ADados.FieldByName('ENT_ITE_DESOPE_CLI').AsFloat)
      .ValorComissaoTabelaDeitens(ADados.FieldByName('ENT_ITE_COMTBL').AsFloat)
      .ValorDoCustoPraticado(ADados.FieldByName('ENT_ITE_CUSPRA').AsFloat)
      .ValorCustoDoItem(ADados.FieldByName('ENT_ITE_CUSITE').AsFloat)
      .OutrosValores(ADados.FieldByName('ENT_ITE_OUTVAL').AsFloat)
      .ValorUltimaCompraImpostos(ADados.FieldByName('ENT_ITE_IMPULT').AsFloat)
      .ValorDaSubstituicao(ADados.FieldByName('ENT_ITE_VAL_ST').AsFloat)
      .ValorDoIcmsStParteDaVenda(ADados.FieldByName('ENT_ITE_ICMPAV_MARG').AsFloat)
      .ValorCat17(ADados.FieldByName('ENT_ITE_VALOR_CAT17').AsFloat)
      .ValorDaAliquotaDiferencaPrecoDinamicoIcms(ADados.FieldByName('ENT_ITE_ADICM_MKPMAR').AsFloat)
      .ValorDaAliquotaDiferencaPrecoDinamicoMargem(ADados.FieldByName('ENT_ITE_CM_PD_MAR').AsFloat)
      .ValorDaAliquotaDiferencaPrecoDinamicoMargemLiquida(ADados.FieldByName('ENT_ITE_CM_PD_MARLIQ').AsFloat)
      .ValorDaAliquotaDiferencaPrecoDinamicoMargemMedia(ADados.FieldByName('ENT_ITE_ADICM_MARMED').AsFloat)
      .ValorDaAliquotaDiferencaPrecoDinamicoMargemImpostos(ADados.FieldByName('ENT_ITE_ADICM_MARIMP').AsFloat)
      .ValorDaAliquotaDiferencaPrecoDinamicoMargemItem(ADados.FieldByName('ENT_ITE_ADICM_MARITE').AsFloat)
      .ValorDaAliquotaDiferencaPrecoDinamicoMargemLucro(ADados.FieldByName('ENT_ITE_ADICM_MARLUC').AsFloat)
      .ValorUnitarioMargemMinima(ADados.FieldByName('ENT_ITE_MARMIN').AsFloat)
      .CalcularPrecoIdeal(ADados.FieldByName('ENT_ITE_CLC_PRE_IDE').Value)
      .ValorPrecoIdeal(ADados.FieldByName('ENT_ITE_VLR_PRE_IDE').AsFloat)
      .AliquotaIcmsPrecoIdeal(ADados.FieldByName('ENT_ITE_ICM_PREIDE').AsFloat);


  LListaParametrosServicoCalculoMargem := TList<IParametrosServicoMargemVenda>.Create;
  LListaParametrosServicoCalculoMargem.Add(LParametrosMargemVenda);

  Result := GetFaturamentoMargemService.MargemVenda.CalculaMargemVenda(LListaParametrosServicoCalculoMargem);
end;

procedure TGerarTesteMargemVenda.CasosTestesLogMargemVenda(ACasosTestesLogMargemVenda: ICasosTestesLog; AResultadoComparacaoMargemVenda: TResultadoComparacao;  ADados: TUniClientDataSet);
begin

  ACasosTestesLogMargemVenda.Add(
    TParametrosCasosTestesLog.New()
      .ResultadoComparacao(AResultadoComparacaoMargemVenda)
      .RetornarNomeOperacao('REGRA_MARGEMVENDA')
      .NumeroDoDocumento(ADados.FieldByName('DET_NUMDOC').AsString)
      .EspecieDoDocumento(ADados.FieldByName('DET_ESPDOC').AsString)
      .CodigoDaEmpresa(ADados.FieldByName('DET_CODEMP').AsString)
      .CodigoDoItem(ADados.FieldByName('DET_CODITE').AsString)
      .CodigoDoCliente(ADados.FieldByName('DET_CODCLI').AsString)
      .OpcaoDocumento('VN')
      .DataEntrada(ADados.FieldByName('DET_DTAENT').AsDateTime)
      .ClassificacaoFiscal(ADados.FieldByName('DET_CLAFIS').AsString)
      .CodigoFiscal(ADados.FieldByName('DET_CODFIS').AsString)
      .EstadoDoDocumento(ADados.FieldByName('DET_ESTADO').AsString)
      .TipoDaAbreviacaoFiscal('')
      .IdentificacaoDoProduto(ADados.FieldByName('DET_IDEPRO').AsString)
      .Log(fGetVariavelLogMargemVenda));

end;

function TGerarTesteMargemVenda.CompararResultadoMargemBrutaPraticada(
  const AResultadoCalculoMargemVenda: IResultadoCalculoMargemVenda;
  const ADados: TUniClientDataSet): Boolean;
begin
  Result := False;


  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioItemMargemPraticadaLucro, ADados.FieldByName('SAI_ITE_MARLUC').AsFloat) Then
  Begin
    Exit;
  End;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoMedio, ADados.FieldByName('SAI_ITE_MARBRU_PREME').AsFloat) Then
  Begin
    Exit;
  End;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra, ADados.FieldByName('SAI_ITE_MARBRU_PREUL').AsFloat) Then
  Begin
    Exit;
  End;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos, ADados.FieldByName('SAI_ITE_MARBRU_IMPUL').AsFloat) Then
  Begin
    Exit;
  End;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioMargemPraticadaSemDespesasOperacionais, ADados.FieldByName('SAI_ITE_PRANUM_MAR_S').AsFloat) Then
  Begin
    Exit;
  End;

  Result := true;
end;

function TGerarTesteMargemVenda.CompararResultadoMargemComImpostos(
  const AResultadoCalculoMargemVenda: IResultadoCalculoMargemVenda;
  const ADados: TUniClientDataSet): Boolean;
begin
  Result := false;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioMargemPrecoUltimaCompraComImpostos, ADados.FieldByName('SAI_ITE_IMPNUM_MAR').AsFloat) Then
  Begin
    Exit;
  End;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioItemMargemPrecoUltimaCompraComImpostos, ADados.FieldByName('SAI_ITE_MARIMP').AsFloat) Then
  Begin
    Exit;
  End;


  Result := true;
end;

function TGerarTesteMargemVenda.CompararResultadoMargemLiquidaPraticada(
  const AResultadoCalculoMargemVenda: IResultadoCalculoMargemVenda;
  const ADados: TUniClientDataSet): Boolean;
begin
  Result := false;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioMargemPraticada, ADados.FieldByName('SAI_ITE_PRANUM_MAR').AsFloat) Then
  Begin
    Exit;
  End;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoMedio, ADados.FieldByName('SAI_ITE_MARLIQ_PREME').AsFloat) Then
  Begin
    Exit;
  End;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra, ADados.FieldByName('SAI_ITE_MARLIQ_PREUL').AsFloat) Then
  Begin
    Exit;
  End;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos, ADados.FieldByName('SAI_ITE_MARLIQ_IMPUL').AsFloat) Then
  Begin
    Exit;
  End;

  Result := true;
end;

function TGerarTesteMargemVenda.CompararResultadoMargemProposta(
  const AResultadoCalculoMargemVenda: IResultadoCalculoMargemVenda;
  const ADados: TUniClientDataSet): Boolean;
begin
  Result := false;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioMargemProposta, ADados.FieldByName('SAI_ITE_PRONUM_MAR').AsFloat) Then
  Begin
    Exit;
  End;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioItemMargemProposta, ADados.FieldByName('SAI_ITE_MARITE').AsFloat) Then
  Begin
    Exit;
  End;

  Result := true;
end;

function TGerarTesteMargemVenda.CompararResultadoMargemVenda(
  const AResultadoCalculoMargemVenda: IResultadoCalculoMargemVenda;
  const ADados: TUniClientDataSet): Boolean;
begin
  Result := False;

  if Not CompararResultadoMargemVendaGeral(AResultadoCalculoMargemVenda, ADados) Then
  begin
    Exit;
  end;

  if Not CompararResultadoMargemComImpostos(AResultadoCalculoMargemVenda, ADados) Then
  begin
    Exit;
  end;

  if Not CompararResultadoMargemProposta(AResultadoCalculoMargemVenda, ADados) Then
  begin
    Exit;
  end;

  if Not CompararResultadoMargemLiquidaPraticada(AResultadoCalculoMargemVenda, ADados) Then
  begin
    Exit;
  end;

  if Not CompararResultadoMargemBrutaPraticada(AResultadoCalculoMargemVenda, ADados) Then
  begin
    Exit;
  end;

  if Not CompararResultadoMargemVendaCusto(AResultadoCalculoMargemVenda, ADados) then
  begin
    Exit;
  end;

  If Not CompararResultadoMargemVendaMkp(AResultadoCalculoMargemVenda, ADados) then
  Begin
    Exit;
  End;

  Result := True;
end;


function TGerarTesteMargemVenda.CompararResultadoMargemVendaGeral(
  const AResultadoCalculoMargemVenda: IResultadoCalculoMargemVenda;
  const ADados: TUniClientDataSet): Boolean;
begin
  result := false;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioCustoRealComMargemZero, ADados.FieldByName('SAI_ITE_CUMAZR').AsFloat) Then
  Begin
    Exit;
  End;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioMargemMinima, ADados.FieldByName('SAI_ITE_MARMIN').AsFloat) Then
  Begin
    Exit;
  End;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioMargemPrecoMedio, ADados.FieldByName('SAI_ITE_MEDNUM_MAR').AsFloat) Then
  Begin
    Exit;
  End;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioMargemPrecoIdeal, ADados.FieldByName('SAI_ITE_IDENUM_MAR').AsFloat) Then
  Begin
    Exit;
  End;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorMargemCat17, ADados.FieldByName('SAI_ITE_MARCAT').AsFloat) Then
  Begin
    Exit;
  End;

  result := true;
end;



function TGerarTesteMargemVenda.CompararResultadoMargemVendaCusto(
  const AResultadoCalculoMargemVenda: IResultadoCalculoMargemVenda;
  const ADados: TUniClientDataSet): Boolean;
begin
  Result := false;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioMargemPropostaCustoReal, ADados.FieldByName('SAI_ITE_MARPRO_PRECU').AsFloat) Then
  Begin
    Exit;
  End;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioMargemPropostaCusto, ADados.FieldByName('SAI_ITE_MARPRO_CUSIT').AsFloat) Then
  Begin
    Exit;
  End;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioMargemPraticadaCusto, ADados.FieldByName('SAI_ITE_MARPRA_CUSIT').AsFloat) Then
  Begin
    Exit;
  End;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioMargemPraticadaCustoReal, ADados.FieldByName('SAI_ITE_MARPRA_PRECU').AsFloat) Then
  Begin
    Exit;
  End;

  Result := True;

end;

function TGerarTesteMargemVenda.CompararResultadoMargemVendaMkp(
  const AResultadoCalculoMargemVenda: IResultadoCalculoMargemVenda;
  const ADados: TUniClientDataSet): Boolean;
begin
  Result := False;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioMarkupProposto, ADados.FieldByName('SAI_ITE_PRONUM_MKP').AsFloat) Then
  Begin
    Exit;
  End;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioMarkupPraticado, ADados.FieldByName('SAI_ITE_PRANUM_MKP').AsFloat) Then
  Begin
    Exit;
  End;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioMarkupPraticadoSemDespesasOperacionais, ADados.FieldByName('SAI_ITE_PRANUM_MKP_S').AsFloat) Then
  Begin
    Exit;
  End;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioMarkupPrecoMedio, ADados.FieldByName('SAI_ITE_MEDNUM_MKP').AsFloat) Then
  Begin
    Exit;
  End;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioItemMargemPrecoMedio, ADados.FieldByName('SAI_ITE_MARMED').AsFloat) Then
  Begin
    Exit;
  End;

  If Not CompararValores(AResultadoCalculoMargemVenda.ValorUnitarioMarkupPrecoUltimaCompraComImpostos, ADados.FieldByName('SAI_ITE_IMPNUM_MKP').AsFloat) Then
  Begin
    Exit;
  End;

  Result := true;

end;

constructor TGerarTesteMargemVenda.Create;
begin

end;

destructor TGerarTesteMargemVenda.Destroy;
begin

  inherited;
end;

procedure TGerarTesteMargemVenda.TotalizarRegistrosProcessamento;
begin
  Inc(FQtdeRegistrosMargemVendaProcessados);
  FQtdeRegistrosMargemVendaAcerto     := FQtdeRegistrosMargemVendaAcerto     + frmModulo.RegistrosProcessadosAcerto;
  FQtdeRegistrosMargemVendaErro       := FQtdeRegistrosMargemVendaErro       + frmModulo.RegistrosProcessadosErro;
  FQtdeRegistrosMargemVendaDuplicados := FQtdeRegistrosMargemVendaDuplicados + frmModulo.RegistrosProcessadosDuplicados;
  FQtdeRegistrosMargemVendaIgnorados  := FQtdeRegistrosMargemVendaIgnorados  + frmModulo.RegistrosProcessadosIgnorados;
end;

function TGerarTesteMargemVenda.fGerarTesteMargemVenda(const ADados: OleVariant): Boolean;
var
  LDados                         : TUniClientDataSet;
  LCasosTestesLogMargemVenda     : ICasosTestesLog;
  LResultadoServicoMargemVenda   : IResultadoServicosClasseMargemVenda;

begin
  Result := True;

  LCasosTestesLogMargemVenda:= TCasosTestesLog.New();

  LDados := TUniClientDataSet.Create(Nil);

  InicializarVariaveisRegistros;

  Try
    LDados.Data := ADados;
    LDados.Open;
    LDados.First;

    FQuantidadeRegistro := frmModulo.Registros;

//    frmModulo.Registros(frmModulo.Registros * 2);

    FResultadoServicosMargemVenda := TList<IResultadoServicosClasseMargemVenda>.Create;

    Try
      While Not LDados.Eof Do
      Begin
        pExecutarProgresso(LDados.RecordCount, LDados.RecNo);

        FResultadoServicosMargemVenda := CalcularMargemVenda(LDados);

        FResultadoComparacaoMargemVenda := ResultadoComparacaoMargemVenda(LDados);

        LResultadoServicoMargemVenda := FResultadoServicosMargemVenda[0];

        pTesteUnitarioLogMargemVenda(LResultadoServicoMargemVenda, LDados);

        ZerarRegistrosDoProcessamento;

        CasosTestesLogMargemVenda(LCasosTestesLogMargemVenda, FResultadoComparacaoMargemVenda, LDados);
        TotalizarRegistrosProcessamento;
        ZerarRegistrosDoProcessamento;

        pLimparVariaveisTesteUnitario;

        LDados.Next;
      End;

      frmModulo.Registros(FQuantidadeRegistro);

      SetarTotaisProcessamento;

      LCasosTestesLogMargemVenda.GerarLog('MargemVenda');

    Except
      On E : Exception do
        pFinalizarProcessamentoComErro(LDados, E.Message);
    End;
  Finally
    FreeAndNil(LDados);
  End;


end;



procedure TGerarTesteMargemVenda.InicializarVariaveisRegistros;
begin
  FQuantidadeRegistro := 0;

  FQtdeRegistrosMargemVendaProcessados := 0;
  FQtdeRegistrosMargemVendaAcerto      := 0;
  FQtdeRegistrosMargemVendaErro        := 0;
  FQtdeRegistrosMargemVendaDuplicados  := 0;
  FQtdeRegistrosMargemVendaIgnorados   := 0;
end;

class function TGerarTesteMargemVenda.New: IGerarTeste;
begin
  Result := Self.Create;
end;

procedure TGerarTesteMargemVenda.pTesteUnitarioLogMargemVenda(
  AResultadoServicosClasseMargemVenda: IResultadoServicosClasseMargemVenda;
  ADados: TUniClientDataSet);
begin

  SetarResultadosComparacao(AResultadoServicosClasseMargemVenda.ResultadoCalculoMargemVenda);

  SetarParametrosComparacao(
    TParametrosComparacaoMargemVenda.New
      .ValorUnitarioMargemMinima(ADados.FieldByName('SAI_ITE_MARMIN').AsFloat)
      .ValorUnitarioCustoRealComMargemZero(ADados.FieldByName('SAI_ITE_CUMAZR').AsFloat)
      .ValorUnitarioMargemPraticadaCustoReal(ADados.FieldByName('SAI_ITE_MARPRA_PRECU').AsFloat)
      .ValorUnitarioMargemPropostaCustoReal(ADados.FieldByName('SAI_ITE_MARPRO_PRECU').AsFloat)
      .ValorUnitarioMargemPropostaCusto(ADados.FieldByName('SAI_ITE_MARPRO_CUSIT').AsFloat)
      .ValorUnitarioMargemPraticadaCusto(ADados.FieldByName('SAI_ITE_MARPRA_CUSIT').AsFloat)
      .ValorUnitarioMargemBrutaPraticadaPrecoMedio(ADados.FieldByName('SAI_ITE_MARBRU_PREME').AsFloat)
      .ValorUnitarioMargemLiquidaPraticadaPrecoMedio(ADados.FieldByName('SAI_ITE_MARLIQ_PREME').AsFloat)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra(ADados.FieldByName('SAI_ITE_MARBRU_PREUL').AsFloat)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra(ADados.FieldByName('SAI_ITE_MARLIQ_PREUL').AsFloat)
      .ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos(ADados.FieldByName('SAI_ITE_MARBRU_IMPUL').AsFloat)
      .ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos(ADados.FieldByName('SAI_ITE_MARLIQ_IMPUL').AsFloat)
      .ValorUnitarioMargemPraticada(ADados.FieldByName('SAI_ITE_PRANUM_MAR').AsFloat)
      .ValorUnitarioMargemPraticadaSemDespesasOperacionais(ADados.FieldByName('SAI_ITE_PRANUM_MAR_S').AsFloat)
      .ValorUnitarioMargemPrecoMedio(ADados.FieldByName('SAI_ITE_MEDNUM_MAR').AsFloat)
      .ValorUnitarioMargemPrecoUltimaCompraComImpostos(ADados.FieldByName('SAI_ITE_IMPNUM_MAR').AsFloat)
      .ValorUnitarioMargemProposta(ADados.FieldByName('SAI_ITE_PRONUM_MAR').AsFloat)
      .ValorMargemCat17(ADados.FieldByName('SAI_ITE_MARCAT').AsFloat)
      .ValorUnitarioMarkupProposto(ADados.FieldByName('SAI_ITE_PRONUM_MKP').AsFloat)
      .ValorUnitarioMarkupPraticado(ADados.FieldByName('SAI_ITE_PRANUM_MKP').AsFloat)
      .ValorUnitarioMarkupPraticadoSemDespesasOperacionais(ADados.FieldByName('SAI_ITE_PRANUM_MKP_S').AsFloat)
      .ValorUnitarioMarkupPrecoMedio(ADados.FieldByName('SAI_ITE_MEDNUM_MKP').AsFloat)
      .ValorUnitarioItemMargemPrecoMedio(ADados.FieldByName('SAI_ITE_MARMED').AsFloat)
      .ValorUnitarioItemMargemPrecoUltimaCompraComImpostos(ADados.FieldByName('SAI_ITE_MARIMP').AsFloat)
      .ValorUnitarioItemMargemProposta(ADados.FieldByName('SAI_ITE_MARITE').AsFloat)
      .ValorUnitarioItemMargemPraticadaLucro(ADados.FieldByName('SAI_ITE_MARLUC').AsFloat)
      .ValorUnitarioMargemPrecoIdeal(ADados.FieldByName('SAI_ITE_IDENUM_MAR').AsFloat)
      .ValorUnitarioMarkupPrecoUltimaCompraComImpostos(ADados.FieldByName('SAI_ITE_IMPNUM_MKP').AsFloat));


  pGerarLogTesteUnitario((AResultadoServicosClasseMargemVenda.ParametrosCalculoMargemVenda as TObject),
                         (AResultadoServicosClasseMargemVenda.ResultadoCalculoMargemVenda as TObject), Nil, 'CalculaMargemVenda');
end;

function TGerarTesteMargemVenda.ResultadoComparacaoMargemVenda(
  const ADados: TUniClientDataSet): TResultadoComparacao;
begin
  Result := RetornarResultadoComparacaoMargemVenda(ADados);
end;

function TGerarTesteMargemVenda.RetornarResultadoComparacaoMargemVenda(
  const ADados: TUniClientDataSet): TResultadoComparacao;
Var
  LResultadoServicosCalculoMargemVenda : IResultadoServicosClasseMargemVenda;
begin
  Result := rcoFalse;

  LResultadoServicosCalculoMargemVenda:= FResultadoServicosMargemVenda[0];

  If Not CompararResultadoMargemVenda(LResultadoServicosCalculoMargemVenda.ResultadoCalculoMargemVenda , ADados) Then
    Exit;

  Result := rcoTrue;

end;


procedure TGerarTesteMargemVenda.SetarTotaisProcessamento;
begin
  frmModulo.RegistrosProcessados(FQtdeRegistrosMargemVendaProcessados);
  frmModulo.RegistrosProcessadosAcerto(FQtdeRegistrosMargemVendaAcerto);
  frmModulo.RegistrosProcessadosErro(FQtdeRegistrosMargemVendaErro);
  frmModulo.RegistrosProcessadosIgnorados(FQtdeRegistrosMargemVendaIgnorados);
  frmModulo.RegistrosProcessadosDuplicados(FQtdeRegistrosMargemVendaDuplicados);
end;

procedure TGerarTesteMargemVenda.ZerarRegistrosDoProcessamento;
begin
  frmModulo.RegistrosProcessadosAcerto(0);
  frmModulo.RegistrosProcessadosErro(0);
  frmModulo.RegistrosProcessadosDuplicados(0);
  frmModulo.RegistrosProcessadosIgnorados(0);
end;

end.
