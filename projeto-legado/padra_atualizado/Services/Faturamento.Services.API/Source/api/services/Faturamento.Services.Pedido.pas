unit Faturamento.Services.Pedido;

interface

uses
{$I '..\..\..\core\services.core.uses.inc'},
  Uni,
  Shared.Core,
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  untTypesSistema,
  untFuncoesGenerica,
  untFuncFatTypes,
  Shared.Functions.DataSet,
  Faturamento.Services.Pedido.Types,
  Faturamento.Classes.TFatVendaBase;

type
  TFatPedidoService = class(TComponent)
  private const
    TipoDocumento = 'PD';
  strict private
    FObjVenda: TFatVendaBase;
    FDadosItem: IMyCampoTabela;
    INFO_PROCESSAMENTO: string;
  strict private
    function fGetIcmsSaida: Double;
    function fGetDescricaoItemNormal: string;
  strict private
    procedure pOnProcessaItem(const item: TDadosFechamento;
      index, count: Integer; AInfo: String = '');
    procedure pCalculaPrecoCustoItemNormal(fltUnitar: Double; item: TPedidoItemBasic);
    procedure pCriarObjetoVenda;
    procedure pCarregaItem(codigoItem: string);
    procedure pInserirProduto(item: TPedidoItemBasic);
  private
    procedure pIniciarPedido(Pedido: TPedidoBasic);
    procedure pInserirProdutos(Pedido: TPedidoBasic);
    function fCalcularImpostos: TPedidoCalculado;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    class function fCalcularPedido(Pedido: TPedidoBasic): TPedidoCalculado;
  end;

implementation

uses Data.DB, untParCalculaPrecoCusto, untTConfiguracao, untConstantes,
  System.SyncObjs, Services.ConsultarPreco.Tinta;

{ TFatPedidoService }

constructor TFatPedidoService.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TFatPedidoService.pCriarObjetoVenda;
begin
  WriteLog('Criando dataset de venda');
  TFatVendaBase.pCriarCdsVenda(Self);
  WriteLog('Criando objeto de venda');
  FObjVenda := TFatVendaBase.CreateInstance(TipoDocumento, False);
  FObjVenda.strNomeForm := 'frmFatVendas';
  FObjVenda.strOpcDocTrue := 'PS';
  FObjVenda.strEspDoc := TipoDocumento;
  FObjVenda.blnImprimeDocs := False;
  WriteLog('Criando query de produtos');
  FObjVenda.qryConIte := fCriarQueryIteGer(FObjVenda);
end;

procedure TFatPedidoService.pIniciarPedido(Pedido: TPedidoBasic);
begin
  WriteLog('TFatPedidoService.pIniciarPedido');

  pCriarObjetoVenda;

  FObjVenda.cdsVenda.EmptyDataSet;

  WriteLog('Carregando dados do cliente ' + Pedido.codigoCliente);
  FObjVenda.pCarregaDadosClienteBaixa(Pedido.codigoCliente);

  WriteLog('Carregando aliquotas de retencao');
  FObjVenda.pCarregaAliquotasRetencao;

  WriteLog('Carregando classificacoes de transferencia');
  FObjVenda.pAtualizaClassTransferencias;

  WriteLog('Carregando informacoes da condicao de pagamento');
  FObjVenda.pAtualizaInformacoesCondPagamento;
  FObjVenda.intPrzMed := fFloatToInt(fCalcMediaPagto(FObjVenda.strConPag));

  WriteLog('Carregando vendedor');
  FObjVenda.strCodVen := strLoginUsuarioLogado;
  FObjVenda.strCodDig := strLoginUsuarioLogado;

  WriteLog('Carregando tipo de operacao');
  FObjVenda.blnVendaPresencial := Pedido.vendaPresencial;
  FObjVenda.pSetTipoOperacao(Pedido.tipoOperacao);

  WriteLog('Carregando endereco de entrega');
  if not fEmptyStr(Pedido.enderecoEntregaID) then
  begin
    FObjVenda.strAutEnt := Pedido.enderecoEntregaID;
    FObjVenda.objEndEnt.pRetEnderecoEntrega(FObjVenda.strAutEnt,
      FObjVenda.strCodCli);
    FObjVenda.objEndEnt.recEndere.blnAltera := True;
    FObjVenda.pEnderecoToFatVenda;
  end;

  WriteLog('Carregando despesas, descontos e frete');
  FObjVenda.strTipPed := 'A';
  FObjVenda.fltDesEsp := Pedido.descontoEspecial;
  FObjVenda.fltDesAce := Pedido.despesasAcessorias;
  FObjVenda.fltValFre := Pedido.valorFrete;
end;

procedure TFatPedidoService.pInserirProdutos(Pedido: TPedidoBasic);
var
  LItem: TPedidoItemBasic;
begin
  WriteLog(Format('Aguarde, Adicionando %d produto(s) ...',
    [Pedido.Items.count]));

  INFO_PROCESSAMENTO := 'Aguarde, Carregando produto %s ...';

  for LItem in Pedido.Items do
    Self.pCarregaItem(LItem.codigoItem);

  for LItem in Pedido.Items do
    Self.pInserirProduto(LItem);
end;

procedure TFatPedidoService.pInserirProduto(item: TPedidoItemBasic);
const
  strEntRet = 'E';
  strPromoc = 'N';
var
  LMadeira: TDadosMadeira;
  LTinta: TConsultarPrecoTinta;
  LDesOri: String;
  LDescri: String;
  LRefere: String;
  LCodUni: String;
  LCalcularComissao: Boolean;
  LCalcularImpostos: Boolean;
  LMargemLucro: Double;
begin
  WriteLog(Format(INFO_PROCESSAMENTO, [item.codigoItem]));

  LTinta := TConsultarPrecoTinta.Create(FObjVenda, item.siglaTinta, item.hashMD5Tinta, item.tabPreco, item.embalagemProduzida, item.modoVenda);

  if (item.siglaTinta <> EmptyStr) and (item.siglaTinta <> 'NOR') then
  begin
    FObjVenda.strIdePro := item.siglaTinta;
    FObjVenda.strIteTin := item.hashMD5Tinta;

    LTinta.pCarregarDadosTinta;

    item.codigoItem := LTinta.FCodIte;

    pCarregaItem(item.codigoItem);

    LDesOri := LTinta.FDesIte;
    LDescri := LTinta.FDesIte;
    LRefere := LTinta.FRefere;
    LCodUni := LTinta.FUnidad;

    FObjVenda.fltUniOri := LTinta.FPreVen;
    FObjVenda.fltUniVis := LTinta.FPreVen;

    FObjVenda.fltCusIte := LTinta.FPreCus;
    FObjVenda.fltPreCus := LTinta.FPreCus;
    FObjVenda.fltPreCu2 := LTinta.FPreCu2;

    FObjVenda.fltPreVe1 := LTinta.FPreVe1;
    FObjVenda.fltPreVe2 := LTinta.FPreVe2;
    FObjVenda.fltPreVe3 := LTinta.FPreVe3;
    FObjVenda.fltPreVe4 := LTinta.FPreVe4;
    FObjVenda.fltPreVe5 := LTinta.FPreVe5;
    FObjVenda.fltPreVe6 := LTinta.FPreVe6;
    FObjVenda.fltPreVe7 := LTinta.FPreVe7;

    FObjVenda.fltOutVal := LTinta.FOutVal;
    FObjVenda.fltIcmSai := LTinta.FIcmSai;
    FObjVenda.fltImpFed := LTinta.FImpFed;
    FObjVenda.fltDesOpe := LTinta.FDesOpe;
    FObjVenda.fltPreMed := LTinta.FPreMed;
    FObjVenda.fltImpUlt := LTinta.FImpUlt;
    FObjVenda.fltPreUlt := LTinta.FPreUlt;

    FObjVenda.fltPesBru := LTinta.FPesBru;
    FObjVenda.fltPesLiq := LTinta.FPesLiq;
  end
  else
  begin
    pCarregaItem(item.codigoItem);

    FObjVenda.strIdePro := 'NOR';
    FObjVenda.strIteTin := EmptyStr;

    LDesOri := FDadosItem.FieldByName('ITE_DESITE').Asstring;
    LDescri := fGetDescricaoItemNormal;
    LRefere := FDadosItem.FieldByName('ITE_REFERE').Asstring;
    LCodUni := FDadosItem.FieldByName('ITE_CODUNI').Asstring;

    FObjVenda.fltCusIte := FDadosItem.FieldByName('ITE_PRECUS').AsFloat;

    pCalculaPrecoCustoItemNormal(item.precoUnitario, item);

    FObjVenda.fltUniOri := FDadosItem.FieldByName('ITE_PREVE' + FObjVenda.strTabPre).AsFloat;
    FObjVenda.fltUniVis := FDadosItem.FieldByName('ITE_PREVE' + FObjVenda.strTabPre).AsFloat;

    FObjVenda.fltPreVe1 := FDadosItem.FieldByName('ITE_PREVE1').AsFloat;
    FObjVenda.fltPreVe2 := FDadosItem.FieldByName('ITE_PREVE2').AsFloat;
    FObjVenda.fltPreVe3 := FDadosItem.FieldByName('ITE_PREVE3').AsFloat;
    FObjVenda.fltPreVe4 := FDadosItem.FieldByName('ITE_PREVE4').AsFloat;
    FObjVenda.fltPreVe5 := FDadosItem.FieldByName('ITE_PREVE5').AsFloat;
    FObjVenda.fltPreVe6 := FDadosItem.FieldByName('ITE_PREVE6').AsFloat;
    FObjVenda.fltPreVe7 := FDadosItem.FieldByName('ITE_PREVE7').AsFloat;

    FObjVenda.fltOutVal := FDadosItem.FieldByName('ITE_OUTVAL').AsFloat;
    FObjVenda.fltIcmSai := FDadosItem.FieldByName('ITE_ICMSAI').AsFloat;
    FObjVenda.fltImpFed := FDadosItem.FieldByName('ITE_IMPFED').AsFloat;
    FObjVenda.fltDesOpe := FDadosItem.FieldByName('ITE_DESOPE').AsFloat;
    FObjVenda.fltPreMed := FDadosItem.FieldByName('ITE_PREMED').AsFloat;
    FObjVenda.fltImpUlt := FDadosItem.FieldByName('ITE_IMPULT').AsFloat;
    FObjVenda.fltPreUlt := FDadosItem.FieldByName('ITE_PREULT').AsFloat;

    FObjVenda.fltPesBru := FDadosItem.FieldByName('ITE_PESOIT').AsFloat;
    FObjVenda.fltPesLiq := FDadosItem.FieldByName('ITE_PESLIQ').AsFloat;
  end;

  LCalcularComissao := False;//Calcular comissao prejudica a performance
  LCalcularImpostos := False;//Calcular impostos prejudica a performance

  LMargemLucro := fCalculaPrecoVenda(2, FObjVenda.fRetPreCus(FObjVenda.fltCusIte) + FObjVenda.fRetOutVal(FObjVenda.fltOutVal),
                                     item.precoUnitario,
                                     0,
                                     FObjVenda.fRetIcmSai(fGetIcmsSaida),
                                     FObjVenda.fRetImpFed(FObjVenda.fltImpFed),
                                     FObjVenda.fRetDesOpe(FObjVenda.fltDesOpe) + FObjVenda.fltDesOpeCli,
                                     FDadosItem.FieldByName('ITE_COMTB' + FObjVenda.strTabPre).AsFloat,
                                     FObjVenda.VS_strMARMKP);

  FObjVenda.pAdicionaRegistroTemporaria(
    FObjVenda.cdsVenda,
    nil,
    FObjVenda.strIdePro,
    FDadosItem.FieldByName('ITE_CODGRU').Asstring,
    item.codigoItem,
    LDesOri,
    LDescri,
    FDadosItem.FieldByName('ITE_DESFAB').Asstring,
    LCodUni,
    LCodUni,
    FDadosItem.FieldByName('ITE_CODMAR').Asstring,
    FDadosItem.FieldByName('ITE_CODFOR').Asstring,
    LRefere,
    FObjVenda.fltUniOri,
    FObjVenda.fltUniVis,
    item.precoUnitario,
    item.precoUnitario,
    0.00,{fltDesCon}
    item.quantidade,
    item.quantidade * item.precoUnitario,
    'S',
    FObjVenda.fltPreCus,
    FObjVenda.fltPreCus * item.quantidade,
    FDadosItem.FieldByName('ITE_COMLUB').Asstring,
    FDadosItem.FieldByName('ITE_IPISAI').AsFloat,
    FDadosItem.FieldByName('ITE_DESMAX').AsFloat,

    FObjVenda.fltPreVe1,
    FObjVenda.fltPreVe2,
    FObjVenda.fltPreVe3,
    FObjVenda.fltPreVe4,
    FObjVenda.fltPreVe5,
    FObjVenda.fltPreVe6,
    FObjVenda.fltPreVe7,
    LMargemLucro,
    FDadosItem.FieldByName('ITE_SALDOS').AsFloat,
    FDadosItem.FieldByName('ITE_INCPIS').Asstring,
    FDadosItem.FieldByName('ITE_COMVAR').AsFloat,
    FDadosItem.FieldByName('ITE_COMATA').AsFloat,
    FDadosItem.FieldByName('ITE_COMDIS').AsFloat,
    EmptyStr,
    EmptyStr,
    EmptyStr,
    0.0,
    0.0,
    EmptyStr,
    FObjVenda.fltPreUlt * item.quantidade,
    FObjVenda.fltImpUlt,
    FObjVenda.fltPreUlt,
    FObjVenda.fltPreMed,
    FDadosItem.FieldByName('ITE_CLAIPI').Asstring,
    EmptyStr,{strIteCha}
    item.hashMD5Tinta,{strIteTin}
    LTinta.FDesCor,
    LTinta.FTipPre,
    LTinta.FLazQua,
    LTinta.FTipEmb,
    LTinta.FQtdEmb,
    LTinta.FPreEmb,
    LTinta.FPrvTin,
    LTinta.FPrcTin,
    LTinta.FFatTin,
    'N',
    LTinta.FCodEmb,
    0.0,
    0.0,
    FDadosItem.FieldByName('ITE_CODABF').Asstring,
    FObjVenda.fltPesBru,
    FObjVenda.fltPesLiq,
    strPromoc,
    0.0,
    0.0,
    0.0,
    0.0,
    EmptyStr,{strTipTin}
    fRetPerComGrupo(FDadosItem.FieldByName('ITE_CODGRU').AsString),
    FDadosItem.FieldByName('ITE_CODFAB').Asstring,
    FObjVenda.cdsVenda.RecordCount + 1,
    0.0,
    EmptyStr,
    EmptyStr,
    EmptyStr,
    FDadosItem.FieldByName('ITE_MARMIN').AsFloat,
    FDadosItem.FieldByName('ITE_MARMSG').AsFloat,
    FDadosItem.FieldByName('ITE_MARMGE').AsFloat,
    fCadIte(item.codigoItem).FieldByName('MAR_DESMAR'),
    FObjVenda.strStatus,
    0.0,
    0.0,
    EmptyStr,
    LTinta.FCatali,
    LTinta.FLinTin,
    FDadosItem.FieldByName('ITE_EMBALA').AsFloat,
    EmptyStr,{strDesNes}
    EmptyStr,
    EmptyStr,
    FDadosItem.FieldByName('ITE_PRECOM').AsFloat,
    item.precoUnitario,
    FDadosItem.FieldByName('ITE_QTPPRO').AsFloat,
    EmptyStr,
    EmptyStr,
    FDadosItem.FieldByName('ITE_OBRCPF').Asstring,
    LTinta.FMontad,
    LTinta.FA_n_o_,
    fRetSiglaUnidade(LCodUni),
    LTinta.FVolPro,
    FObjVenda.cdsVenda.RecNo+1,
    LTinta.FChaFor,
    '',    {strCodAca}
    '',    {strEmpAca}
    False, {blnProAca}
    EmptyStr,
    EmptyStr,
    EmptyStr,
    FObjVenda.fRetOutVal(FObjVenda.fltOutVal),
    FDadosItem.FieldByName('ITE_COMTB' + FObjVenda.strTabPre).AsFloat,
    FObjVenda.fRetDesOpe(FObjVenda.fltDesOpe),
    FObjVenda.fRetIcmSai(fGetIcmsSaida),
    FObjVenda.fRetImpFed(FObjVenda.fltImpFed),
    FDadosItem.FieldByName('ITE_DESMGE').AsFloat,
    EmptyStr,
    EmptyStr,
    EmptyStr,
    FObjVenda.strTabPre,
    FDadosItem.FieldByName('ITE_IPIENT').AsFloat,
    FDadosItem.FieldByName('ITE_FREENT').AsFloat,
    LTinta.FCodDil,
    LTinta.FPorDil,
    LTinta.FDilCon,
    LTinta.FPorCat,
    strEntRet,
    EmptyStr,
    'N', {strEntFut}
    EmptyStr,
    IIF(strEntRet = 'E', FObjVenda.dtaPreVis, 0),
    item.quantidade,
    0,
    0,
    FDadosItem.FieldByName('ITE_IMPDIR').Asstring,
    FDadosItem.FieldByName('ITE_LOCFIS').Asstring,
    FObjVenda.fltPreCu2,
    FObjVenda.fltPreCu2 * item.quantidade,
    0,
    0,
    0,
    0,
    0,
    0,
    LTinta.FForTin,
    EmptyStr,
    EmptyStr,
    EmptyStr,
    EmptyStr,
    EmptyStr,
    False,
    'N',
    'NOR',
    0,
    EmptyStr,
    FDadosItem.FieldByName('ITE_CODBAR').Asstring,
    EmptyStr,
    0,
    0,
    0,
    EmptyStr,
    1,
    True,
    EmptyStr,
    EmptyStr,
    EmptyStr,
    0,
    FObjVenda.fRetPreCus(FObjVenda.fltCusIte),
    FDadosItem.FieldByName('ITE_DESSIM').Asstring,
    EmptyStr,
    LMadeira,
    FObjVenda.fltImpUlt * item.quantidade,
    0,
    0,
    EmptyStr,
    0,
    EmptyStr,
    EmptyStr,
    0,
    0,
    EmptyStr,
    EmptyStr,
    item.id,
    EmptyStr,
    'N',
    0,
    0,
    0,
    False,
    False,
    'N',
    EmptyStr,
    0,
    LTinta.FDesOpeTin,
    EmptyStr,
    'N',
    0,
    EmptyStr,
    EmptyStr,
    EmptyStr,
    EmptyStr,
    FDadosItem.FieldByName('ITE_EXCIPI').AsString,
    FDadosItem.FieldByName('ITE_DESMSU').AsFloat,
    EmptyStr,
    EmptyStr,
    EmptyStr,
    'S',
    'N',
    EmptyStr,
    EmptyStr,
    EmptyStr,
    EmptyStr,
    False,
    -1,
    -1,
    'N',{Pegou?}
    EmptyStr,
    'N',
    0,
    0,
    0,
    EmptyStr,
    0,
    0,
    0,
    EmptyStr,
    0,
    0,
    0,
    EmptyStr,
    EmptyStr,
    0,
    0,
    0,
    False,
    EmptyStr,
    EmptyStr,
    EmptyStr,
    EmptyStr,
    EmptyStr,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    EmptyStr,
    EmptyStr,
    0,
    0,
    EmptyStr,
    LTinta.FPorper,
    'N',
    'N',
    EmptyStr,
    0,
    0,
    EmptyStr,
    EmptyStr,
    EmptyStr,
    EmptyStr,
    EmptyStr,
    EmptyStr,
    EmptyStr,
    EmptyStr,
    EmptyStr,
    FDadosItem.FieldByName('ITE_DESMVM').AsFloat,
    FDadosItem.FieldByName('ITE_DESMSM').AsFloat,
    FDadosItem.FieldByName('ITE_DESMGM').AsFloat,
    FDadosItem.FieldByName('ITE_MARMMV').AsFloat,
    FDadosItem.FieldByName('ITE_MARMMS').AsFloat,
    FDadosItem.FieldByName('ITE_MARMMG').AsFloat,
    0,
    EmptyStr,
    'S',
    EmptyStr,
    0,
    EmptyStr,
    0,
    0,
    EmptyStr,
    False,
    0,
    EmptyStr,
    EmptyStr,
    EmptyStr,
    EmptyStr,
    0,
    False,
    0,
    0,
    LCalcularComissao,//Calcular comissao prejudica a performance
    LCalcularImpostos,//Calcular impostos prejudica a performance
    FDadosItem.FieldByName('ITE_CILVAS').Asstring);

  If Assigned(LTinta.FForTin.Formulas) And (FObjVenda.strIdePro <> 'NOR') Then
    FObjVenda.dicFormulas.AdicionarObjeto(FObjVenda.cdsVenda.FieldByName('AUTOINCREM').AsString, LTinta.FForTin.Formulas);
end;

procedure TFatPedidoService.pOnProcessaItem(const item: TDadosFechamento;
  index, count: Integer; AInfo: String);
begin
  if AInfo.IsEmpty then
    AInfo := INFO_PROCESSAMENTO;
  WriteLog(Format(AInfo, [item.strCodIte + ' - ' + item.strDesIte]));
end;

destructor TFatPedidoService.Destroy;
begin
  If Assigned(FObjVenda) Then
    FreeAndNil(FObjVenda);
  TFatVendaBase.pFreeCdsVenda;
  inherited;
end;

class function TFatPedidoService.fCalcularPedido(Pedido: TPedidoBasic)
  : TPedidoCalculado;
var
  LService: TFatPedidoService;
begin
  WriteLog(StringOfChar('-', 100));
  LService := TFatPedidoService.Create(nil);
  try
    try
      LService.pIniciarPedido(Pedido);
      LService.pInserirProdutos(Pedido);
      Result := LService.fCalcularImpostos;
    except
      on E: Exception do
      begin
        WriteError(E.Message);
        Raise;
      end;
    end;
  finally
    LService.Free;
  end;
  WriteLog(StringOfChar('-', 100));
end;

function TFatPedidoService.fCalcularImpostos: TPedidoCalculado;
var
  arrLivFis: TArrLivFis;
begin
  WriteLog('Aguarde, Calculando impostos ...');

  INFO_PROCESSAMENTO := 'Aguarde, Processando produto %s ...';
  FObjVenda.pPreencheMatrizFechamento('', pOnProcessaItem);

  { nao deve alterar o preco unitario passado no json }
  // FObjVenda.blnDeCndF := (fCfgSis('CNDVEN') = 'F');

  { nao deve alterar o preco unitario passado no json }
  // If FObjVenda.blnTaxVpr Then
  // FObjVenda.pCalculaTaxVpr;

  FObjVenda.pCalculaPesBruLiq;

  FObjVenda.pDestacaRetencoes;
  FObjVenda.pRetemImpostosNoDescontoEspecial;

  INFO_PROCESSAMENTO := 'Aguarde, Calculando produto %s ...';
  FObjVenda.pCalculaTotGer(False, True, pOnProcessaItem);

  FObjVenda.strDesCla := fRetDesCla(FObjVenda.strClaFis);

  FObjVenda.pCalculaTotalParaCadRec;

  FObjVenda.pRateiaValores;

  FObjVenda.pCalculaCadFis(arrLivFis);

  Result := TPedidoCalculado.FromFatVenda(FObjVenda);

  WriteLog('Impostos calculados com sucesso!');
end;

procedure TFatPedidoService.pCarregaItem(codigoItem: string);
var
  qryItem: TUniQuery;
begin
  WriteLog(Format(INFO_PROCESSAMENTO, [codigoItem]));
  qryItem := fCriaQuery(Self);
  try
    qryItem.SQL.Add(TFatVendaBase.fGetSQLItem);
    qryItem.ParamByName('CODEMP').Asstring := VS_strCodEmp;
    qryItem.ParamByName('CODITE').Asstring := codigoItem;

    FDadosItem := ExecutarQueryEmCache(qryItem);

    If FDadosItem.FieldByName('ITE_CODITE').AsString.IsEmpty Then
      raise Exception.Create('Produto não existe ' + codigoItem);

    fCadIte(codigoItem);
    fIteGer(codigoItem, VS_strCodEmp);
  finally
    FreeAndNil(qryItem);
  end;
end;

procedure TFatPedidoService.pCalculaPrecoCustoItemNormal(fltUnitar: Double;
  item: TPedidoItemBasic);
Var
  parPreCus: TParCalculaPrecoCusto;
Begin
  parPreCus := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);
  Try
    FObjVenda.pCarregaValoresCusto(item.codigoItem, VS_strCodEmp, FObjVenda.strTabPre);

    FObjVenda.fltPreCus := FObjVenda.fRetPreCus(FObjVenda.fltCusIte);

    FObjVenda.fltPreCu2 :=
      parPreCus.fCalculaPrecoCustoRealVenda(
        fltUnitar,
        FObjVenda.fRetPreCus(FObjVenda.fltCusIte),
        FObjVenda.fRetOutVal(FObjVenda.fltOutVal),
        FObjVenda.fRetIcmSai(fGetIcmsSaida),
        FObjVenda.fRetImpFed(FObjVenda.fltImpFed),
        FObjVenda.fRetDesOpe(FObjVenda.fltDesOpe) +
        FObjVenda.fltDesOpeCli,
        0.0,
        0.0);
  Finally
    FreeAndNil(parPreCus);
  End;
End;

function TFatPedidoService.fGetDescricaoItemNormal: string;
begin
  Result := FDadosItem.FieldByName('ITE_DESITE').Asstring +
    IIF(fCfgSis('IMPREF', varBoolean), ' ' + FDadosItem.FieldByName('ITE_REFERE')
    .Asstring, EmptyStr);
end;

function TFatPedidoService.fGetIcmsSaida: Double;
begin
  If (fCfgSis('IMPCF4') = 'S') And (FObjVenda.strIdePro = 'NOR') Then
    Result := FObjVenda.fCalculaAliquota(FDadosItem.FieldByName('ITE_CODITE')
      .Asstring, FDadosItem.FieldByName('ITE_IMPDIR').Asstring)
  Else
    Result := FObjVenda.fltIcmSai;
end;

end.
