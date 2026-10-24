unit untMargemLucro;


interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, untFuncoesGenerica,
{$ELSE}
  UniClientDataSet, untTestabilidade,
{$ENDIF}
  System.StrUtils,
  untEstruturaMargemLucro,
  Shared.Functions.Types, System.SysUtils,
  untIcmsSTParteVenda, untConstantesNFe,
  untFuncFatTypes,
  Data.DB, System.Generics.Collections,
  Faturamento.Margem.Interfaces.MargemVenda,
  Shared.Functions.Core,
  Shared.Functions.Configuracoes,
  Faturamento.Margem.Tipos.MargemVenda,
  untCalcularMargemLucro;

Type
  TFncGetEmpCalculoItem = reference to function (strEmpresaItem: String = ''; strCodEmpDef: String = ''): String;

  TMargemLucro = class
  private
    FCdsItensMargem: TUniClientDataSet;

    function fCodAbf(cdsVendaOri : TUniClientDataSet): String;

    function GetCdsItensMargem: TUniClientDataSet;

    procedure PreencherDataSetMargemLucroCalculada(cdsDados: TUniClientDataSet; AListaResultadosCalculoMargem: TList<IResultadoCalculoMargemVenda>; blnProcessarTodosRegistros: Boolean);
    procedure PreencherDataSetTodosOsRegistros(cdsDados: TUniClientDataSet; AListaResultadosCalculoMargem: TList<IResultadoCalculoMargemVenda>);
    procedure PreencherDataSetApenasUmRegistro(cdsDados: TUniClientDataSet; AListaResultadosCalculoMargem: TList<IResultadoCalculoMargemVenda>);
    procedure AtualizarOsRegistrosDoDataSet(cdsDados: TUniClientDataSet; AListaResultadosCalculoMargem: TList<IResultadoCalculoMargemVenda>; Contador: Integer);

    function ValidarSeUtilizaCotacaoDolar(Const cdsDados: TUniClientDataSet; Const AValorCotacaoDolarVenda : Double ) : Boolean;

    function RetornarValorCotacaoDolar(Const cdsDados: TUniClientDataSet; Const cdsVendaOri: TUniClientDataSet; Const AValorCotacaoDolarVenda : Double ) : Double;

    function RetorarIdePro(Const cdsVendaOri: TUniClientDataSet) : String;

    function ValidarSeAplicaPercentualDeDesconto(Const cdsDados : TUniClientDataSet) : Boolean;
    function RetornarPercentualDeDesconto(Const cdsDados : TUniClientDataSet) : double;

    function RetornarCodSit(Const cdsVendaOri : TUniClientDataSet) : String;

    function RetornarResultadoDoItem(Const cdsDados : TUniClientDataSet) : Double;


  public
    procedure PreencherDataSetComInformacoesDoProduto(cdsDados                : TUniClientDataSet;
                                                      cdsVendaOri             : TUniClientDataSet;
                                                      fltDesOpeCli            : Double;
                                                      strClaFis               : String;
                                                      ADataCotacaoDolarVenda  : TDate;
                                                      AValorCotacaoDolarVenda : Double;
                                                      blnCarregaPedidoOrcamentoEntFut: Boolean;
                                                      AFncGetEmpCalculoItem : TFncGetEmpCalculoItem;
                                                      blnCalcularOutrosValoresComBaseNoValorOriginal : Boolean);

    procedure PreencherDataSetComInformacoesDaMargemLucroCalculada(cdsDados: TUniClientDataSet;
      strClaFis: String; fltDesOpeCli: Double;
      blnProcessarTodosRegistros: Boolean);

    class function fCriaEstruturaDadosMargemLucro: TUniClientDataSet;

    constructor Create;
    destructor Destroy; override;

    property cdsItensMargem: TUniClientDataSet read GetCdsItensMargem;
  End;

implementation

{$IFNDEF LINUX}
uses
  untFuncoesSimples;
{$ENDIF}

{ TMargemLucro }

class function TMargemLucro.fCriaEstruturaDadosMargemLucro: TUniClientDataSet;
begin
  Result := TEstruturaClienteDataSetMargemLucro.fCriaEstruturaDadosMargemLucro;
end;

function TMargemLucro.GetCdsItensMargem: TUniClientDataSet;
begin
  Result := FCdsItensMargem;
end;

procedure TMargemLucro.AtualizarOsRegistrosDoDataSet(
  cdsDados: TUniClientDataSet;
  AListaResultadosCalculoMargem: TList<IResultadoCalculoMargemVenda>;
  Contador: Integer);
begin
  cdsDados.FieldByName('ITE_IDENUM_MAR').AsFloat     := AListaResultadosCalculoMargem[Contador].ValorUnitarioMargemPrecoIdeal;
  cdsDados.FieldByName('ITE_PRANUM_MAR').AsFloat     := AListaResultadosCalculoMargem[Contador].ValorUnitarioMargemPraticada;
  cdsDados.FieldByName('ITE_PRANUM_MAR_SDO').AsFloat := AListaResultadosCalculoMargem[Contador].ValorUnitarioMargemPraticadaSemDespesasOperacionais;
  cdsDados.FieldByName('ITE_MEDNUM_MAR').AsFloat     := AListaResultadosCalculoMargem[Contador].ValorUnitarioMargemPrecoMedio;
  cdsDados.FieldByName('ITE_IMPNUM_MAR').AsFloat     := AListaResultadosCalculoMargem[Contador].ValorUnitarioMargemPrecoUltimaCompraComImpostos;

  cdsDados.FieldByName('ITE_PRONUM_MAR').AsFloat     := AListaResultadosCalculoMargem[Contador].ValorUnitarioMargemProposta;
  cdsDados.FieldByName('ITE_MARMIN').AsFloat         := AListaResultadosCalculoMargem[Contador].ValorUnitarioMargemMinima;
  cdsDados.FieldByName('ITE_CUMAZR').AsFloat         := AListaResultadosCalculoMargem[Contador].ValorUnitarioCustoRealComMargemZero;
  cdsDados.FieldByName('ITE_MARPRA_PRECUS').AsFloat  := AListaResultadosCalculoMargem[Contador].ValorUnitarioMargemPraticadaCustoReal;
  cdsDados.FieldByName('ITE_MRPRBT_PRECUS').AsFloat  := AListaResultadosCalculoMargem[Contador].ValorUnitarioMargemPraticadaCustoRealBruta;
  cdsDados.FieldByName('ITE_MARPRO_PRECUS').AsFloat  := AListaResultadosCalculoMargem[Contador].ValorUnitarioMargemPropostaCustoReal;
  cdsDados.FieldByName('ITE_MARPRO_CUSITE').AsFloat  := AListaResultadosCalculoMargem[Contador].ValorUnitarioMargemPropostaCusto;
  cdsDados.FieldByName('ITE_MARPRA_CUSITE').AsFloat  := AListaResultadosCalculoMargem[Contador].ValorUnitarioMargemPraticadaCusto;
  cdsDados.FieldByName('ITE_MARBRU_PREMED').AsFloat  := AListaResultadosCalculoMargem[Contador].ValorUnitarioMargemBrutaPraticadaPrecoMedio;
  cdsDados.FieldByName('ITE_MRPRBT_PREMED').AsFloat  := AListaResultadosCalculoMargem[Contador].ValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta;
  cdsDados.FieldByName('ITE_MARLIQ_PREMED').AsFloat  := AListaResultadosCalculoMargem[Contador].ValorUnitarioMargemLiquidaPraticadaPrecoMedio;

  If (cdsDados.FieldByName('ITE_CUSREA').AsFloat > 0) Then
  Begin
    cdsDados.FieldByName('ITE_MARPRA_PRECUS').AsFloat  := AListaResultadosCalculoMargem[Contador].ValorMargemPraticadaCustoReal;
    cdsDados.FieldByName('ITE_MARPRO_PRECUS').AsFloat  := AListaResultadosCalculoMargem[Contador].ValorMargemPropostaCustoReal;
    cdsDados.FieldByName('ITE_PRANUM_MAR').AsFloat     := AListaResultadosCalculoMargem[Contador].ValorUnitarioMargemPraticadaCustoRealFrete;
    cdsDados.FieldByName('ITE_PRONUM_MAR').AsFloat     := AListaResultadosCalculoMargem[Contador].ValorUnitarioMargemPropostaCustoRealFrete;
  End;

  cdsDados.FieldByName('ITE_MARBRU_PREULT').AsFloat  := AListaResultadosCalculoMargem[Contador].ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra;
  cdsDados.FieldByName('ITE_MARLIQ_PREULT').AsFloat  := AListaResultadosCalculoMargem[Contador].ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra;
  cdsDados.FieldByName('ITE_MARBRU_IMPULT').AsFloat  := AListaResultadosCalculoMargem[Contador].ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos;
  cdsDados.FieldByName('ITE_MARLIQ_IMPULT').AsFloat  := AListaResultadosCalculoMargem[Contador].ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos;

  cdsDados.FieldByName('ITE_PRANUM_MKP').AsFloat     := AListaResultadosCalculoMargem[Contador].ValorUnitarioMarkupPraticado;
  cdsDados.FieldByName('ITE_PRANUM_MKP_SDO').AsFloat := AListaResultadosCalculoMargem[Contador].ValorUnitarioMarkupPraticadoSemDespesasOperacionais;
  cdsDados.FieldByName('ITE_PRONUM_MKP').AsFloat     := AListaResultadosCalculoMargem[Contador].ValorUnitarioMarkupProposto;
  cdsDados.FieldByName('ITE_MEDNUM_MKP').AsFloat     := AListaResultadosCalculoMargem[Contador].ValorUnitarioMarkupPrecoMedio;

  cdsDados.FieldByName('ITE_IMPNUM_MKP').AsFloat     := AListaResultadosCalculoMargem[Contador].ValorUnitarioMarkupPrecoUltimaCompraComImpostos;
  cdsDados.FieldByName('ITE_MARMED').AsFloat         := AListaResultadosCalculoMargem[Contador].ValorUnitarioItemMargemPrecoMedio;
  cdsDados.FieldByName('ITE_MARIMP').AsFloat         := AListaResultadosCalculoMargem[Contador].ValorUnitarioItemMargemPrecoUltimaCompraComImpostos;

  cdsDados.FieldByName('ITE_MARITE').AsFloat         := AListaResultadosCalculoMargem[Contador].ValorUnitarioItemMargemProposta;
  cdsDados.FieldByName('ITE_MARLUC').AsFloat         := AListaResultadosCalculoMargem[Contador].ValorUnitarioItemMargemPraticadaLucro;
  cdsDados.FieldByName('ITE_MARCAT').AsFloat         := AListaResultadosCalculoMargem[Contador].ValorMargemCat17;
end;

constructor TMargemLucro.Create;
begin
  FCdsItensMargem := fCriaEstruturaDadosMargemLucro;
end;

destructor TMargemLucro.Destroy;
begin
  If Assigned(FCdsItensMargem) Then FreeAndNil(FCdsItensMargem);

  inherited Destroy;
end;

function TMargemLucro.fCodAbf(cdsVendaOri : TUniClientDataSet): String;
begin
  Result := cdsVendaOri.FieldByName('ITE_CODABF_MARGEM').AsString;
end;

procedure TMargemLucro.PreencherDataSetApenasUmRegistro(
  cdsDados: TUniClientDataSet;
  AListaResultadosCalculoMargem: TList<IResultadoCalculoMargemVenda>);
var
  Contador: Integer;
begin
  Contador := 0;

  AtualizarOsRegistrosDoDataSet(cdsDados, AListaResultadosCalculoMargem, Contador);
end;

procedure TMargemLucro.PreencherDataSetComInformacoesDaMargemLucroCalculada(cdsDados: TUniClientDataSet;
      strClaFis: String; fltDesOpeCli: Double;
      blnProcessarTodosRegistros: Boolean);
var
  LListaResultadosCalculoMargem: TList<IResultadoCalculoMargemVenda>;
begin
  If cdsDados.IsEmpty Then
    Exit;

  //Chamamos o controller
  LListaResultadosCalculoMargem :=
    TCalcularMargemLucro.New(blnProcessarTodosRegistros, fMarMpkParaVenda)
      .MontarListaDeParamatrosParaCalculoDaMargemDeLucro(cdsDados)
    .CalcularMargemDeLucro;

  //Setamos as informacoes
  PreencherDataSetMargemLucroCalculada(cdsDados, LListaResultadosCalculoMargem, blnProcessarTodosRegistros);

  FreeAndNil(LListaResultadosCalculoMargem);
end;

procedure TMargemLucro.PreencherDataSetComInformacoesDoProduto(cdsDados                : TUniClientDataSet;
                                                      cdsVendaOri             : TUniClientDataSet;
                                                      fltDesOpeCli            : Double;
                                                      strClaFis               : String;
                                                      ADataCotacaoDolarVenda  : TDate;
                                                      AValorCotacaoDolarVenda : Double;
                                                      blnCarregaPedidoOrcamentoEntFut: Boolean;
                                                      AFncGetEmpCalculoItem : TFncGetEmpCalculoItem;
                                                      blnCalcularOutrosValoresComBaseNoValorOriginal : Boolean);
  Var
    fltOutValProduto : Double;
begin
  With cdsVendaOri Do
  Begin
    (************************************************************************)
    (* NAO VAI MAIS MOSTRAR A MARGEM CALCULADA COM O PERCENTUAL DE COMISSAO *)
    (* APENAS PARA QUANDO PCMPRO <> 3 - QUANDO UTILIZA O CAMPO PARA         *)
    (* COMISSAO OU NÃO UTILIZA O CAMPO (KM)                                 *)
    (*********************************************************************LA*)

    cdsDados.FieldByName('ITE_NUMORC').AsString := FieldByName('ITE_NUMORC').AsString;
    cdsDados.FieldByName('ITE_ESPORC').AsString := FieldByName('ITE_ESPORC').AsString;
    cdsDados.FieldByName('ITE_EMPORC').AsString := FieldByName('ITE_EMPORC').AsString;
    cdsDados.FieldByName('ITE_SEQDET').AsString := FieldByName('ITE_SEQDET').AsString;
    cdsDados.FieldByName('ITE_EMPPRD').AsString := FieldByName('ITE_EMPPRD').AsString;
    cdsDados.FieldByName('ITE_CODFAB').AsString := FieldByName('ITE_CODFAB').AsString;

    If (fCfgSis('PCMPRO') <> '3') {$IFNDEF LINUX} And (Not fMostraMargemUtilizaCOMTBX()){$ENDIF} Then
      cdsDados.FieldByName('ITE_COMTBL').AsFloat := 0
    Else
      cdsDados.FieldByName('ITE_COMTBL').AsFloat := FieldByName('ITE_COMTBL').AsFloat;

    cdsDados.FieldByName('ITE_EMPITE').AsString := FieldByName('ITE_EMPITE').AsString;
    cdsDados.FieldByName('ITE_CODITE').AsString := FieldByName('ITE_CODITE').AsString;
    cdsDados.FieldByName('ITE_DESITE').AsString := FieldByName('ITE_DESITE').AsString;
    cdsDados.FieldByName('ITE_CODFOR').AsString := FieldByName('ITE_CODFOR').AsString;
    cdsDados.FieldByName('ITE_CODABF').AsString := fCodAbf(cdsVendaOri);

    cdsDados.FieldByName('ITE_CODSIT').AsString   := RetornarCodSit(cdsVendaOri);
    cdsDados.FieldByName('ITE_SIGUNI').AsString   := FieldByName('ITE_SIGUNI').AsString;
    cdsDados.FieldByName('ITE_DESMAR').AsString   := FieldByName('ITE_DESMAR').AsString;
    cdsDados.FieldByName('ITE_QTDITE').AsFloat    := FieldByName('ITE_QTDITE').AsFloat;

    cdsDados.FieldByName('ITE_BAREMB').AsString   := FieldByName('ITE_BAREMB').AsString;
    cdsDados.FieldByName('ITE_PREULT').AsFloat    := FieldByName('ITE_PREULT').AsFloat;
    cdsDados.FieldByName('ITE_SEQCOM').Value      := FieldByName('ITE_SEQCOM').Value;

    cdsDados.FieldByName('ITE_ATIVAC').AsString   := FieldByName('ITE_ATIVAC').AsString;
    cdsDados.FieldByName('ITE_UNISBI').AsFloat    := FieldByName('ITE_UNISBI').AsFloat;
    cdsDados.FieldByName('ITE_NUMLOT').AsString   := FieldByName('ITE_NUMLOT').AsString;
    cdsDados.FieldByName('ITE_RICMPR').AsString   := FieldByName('ITE_RICMPR').AsString;
    cdsDados.FieldByName('ITE_PERRIC').AsString   := FieldByName('ITE_PERRIC').AsString;

    cdsDados.FieldByName('ITE_VAL_ST').AsFloat    := FieldByName('ITE_VAL_ST').AsFloat;
    cdsDados.FieldByName('ITE_BASICM').AsFloat    := FieldByName('ITE_BASICM').AsFloat;

    cdsDados.FieldByName('ITE_PREINI').AsFloat    := FieldByName('ITE_UNITAR').AsFloat;

    cdsDados.FieldByName('ITE_PERDES').AsFloat    := RetornarPercentualDeDesconto(cdsDados);
    cdsDados.FieldByName('ITE_VLCTVN').AsFloat    := AValorCotacaoDolarVenda;
    cdsDados.FieldByName('ITE_DTCTVN').AsDateTime := ADataCotacaoDolarVenda;

    cdsDados.FieldByName('ITE_UNIDOL').AsFloat := RetornarValorCotacaoDolar(cdsDados, cdsVendaOri, AValorCotacaoDolarVenda);

    cdsDados.FieldByName('ITE_IMPULT').AsFloat := FieldByName('ITE_IMPULT').AsFloat;

    cdsDados.FieldByName('ITE_CALMAR_PREDIN_MAR').AsFloat    := FieldByName('ITE_CALMAR_PREDIN_MAR_MARGEM').AsFloat;
    cdsDados.FieldByName('ITE_CALMAR_PREDIN_MARLIQ').AsFloat := FieldByName('ITE_CALMAR_PREDIN_MARLIQ_MARGEM').AsFloat;

    cdsDados.FieldByName('ITE_VDIFAL').AsFloat := FieldByName('ITE_VDIFAL_MARGEM').AsFloat;

    (************************************************************************)
    (* NAO VAI MAIS MOSTRAR A MARGEM CALCULADA COM O PERCENTUAL DE COMISSAO *)
    (* APENAS PARA QUANDO PCMPRO <> 3 - QUANDO UTILIZA O CAMPO PARA         *)
    (* COMISSAO OU NÃO UTILIZA O CAMPO (KM)                                 *)
    (*********************************************************************LA*)

    If (fCfgSis('PCMPRO') <> '3') {$IFNDEF LINUX} And (Not fMostraMargemUtilizaCOMTBX()){$ENDIF} Then
      cdsDados.FieldByName('ITE_COMTBL').AsFloat := 0
    Else
      cdsDados.FieldByName('ITE_COMTBL').AsFloat := FieldByName('ITE_COMTBL').AsFloat;

    cdsDados.FieldByName('ITE_DESMGE').AsFloat  := FieldByName('ITE_DESMGE').AsFloat;
    cdsDados.FieldByName('ITE_DESMSU').AsFloat  := FieldByName('ITE_DESMSU').AsFloat;
    cdsDados.FieldByName('ITE_DESMAX').AsFloat  := FieldByName('ITE_DESMAX').AsFloat;
    cdsDados.FieldByName('ITE_DESCON').AsFloat  := FieldByName('ITE_DESCON').AsFloat;


    cdsDados.FieldByName('ITE_ENTRET').AsString  := FieldByName('ITE_ENTRET').AsString;
    cdsDados.FieldByName('ITE_MOTFUT').AsString  := FieldByName('ITE_MOTFUT').AsString;
    cdsDados.FieldByName('ITE_ENTFUT').AsString  := FieldByName('ITE_ENTFUT').AsString;
    cdsDados.FieldByName('ITE_LOCRET').AsString  := FieldByName('ITE_LOCRET').AsString;

    cdsDados.FieldByName('ITE_QTDEMB').AsFloat  := FieldByName('ITE_QTDEMB').AsFloat;
    cdsDados.FieldByName('ITE_PREEMB').AsFloat  := FieldByName('ITE_PREEMB').AsFloat;
    cdsDados.FieldByName('ITE_PRCTIN').AsFloat  := FieldByName('ITE_PRCTIN').AsFloat;

    cdsDados.FieldByName('ITE_PRVTIN').AsFloat  := FieldByName('ITE_PRVTIN').AsFloat;
    cdsDados.FieldByName('ITE_UNIDEV').AsFloat  := FieldByName('ITE_UNIDEV').AsFloat;
    cdsDados.FieldByName('ITE_EMBALA').AsFloat  := FieldByName('ITE_EMBALA').AsFloat;
    cdsDados.FieldByName('ITE_PRELOT').AsFloat  := FieldByName('ITE_PRELOT').AsFloat;

    cdsDados.FieldByName('ITE_IMPDIR').AsString := FieldByName('ITE_IMPDIR').AsString;
    cdsDados.FieldByName('ITE_TABPRE').AsString := FieldByName('ITE_TABPRE').AsString;
    cdsDados.FieldByName('ITE_ENTSAI').AsString := FieldByName('ITE_ENTSAI').AsString;
    cdsDados.FieldByName('ITE_BRINDE').AsString := FieldByName('ITE_BRINDE').AsString;

    cdsDados.FieldByName('ITE_IDEPRO').AsString := RetorarIdePro(cdsVendaOri);
    cdsDados.FieldByName('ITE_TIPPRE').AsString := FieldByName('ITE_TIPPRE').AsString;
    cdsDados.FieldByName('ITE_PROMOC').AsString := FieldByName('ITE_PROMOC').AsString;
    cdsDados.FieldByName('ITE_PROVEN').AsString := FieldByName('ITE_PROVEN').AsString;

    cdsDados.FieldByName('ITE_CATALI').AsString := FieldByName('ITE_CATALI').AsString;
    cdsDados.FieldByName('ITE_OBSCOL').AsString := FieldByName('ITE_OBSCOL').AsString;
    cdsDados.FieldByName('ITE_TIPFOR').AsInteger:= FieldByName('ITE_TIPFOR').AsInteger;

    cdsDados.FieldByName('ITE_ITETIN').AsString := FieldByName('ITE_ITETIN').AsString;
    cdsDados.FieldByName('ITE_CODUNI').AsString := FieldByName('ITE_CODUNI').AsString;
    cdsDados.FieldByName('AUTOINCREM').AsInteger:= FieldByName('AUTOINCREM').AsInteger;

    If (cdsDados.FindField('ITE_RESULT') <> Nil) Then
     cdsDados.FieldByName('ITE_RESULT').AsFloat := RetornarResultadoDoItem(cdsDados);

    If (cdsDados.FindField('ITE_OUTVAL_VALORI') <> Nil) Then
    Begin
      If (blnCalcularOutrosValoresComBaseNoValorOriginal) Then
      Begin
        fltOutValProduto := fCampoTabela('ITE_OUTVAL', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [FieldByName('ITE_CODITE').AsString, AFncGetEmpCalculoItem(FieldByName('ITE_EMPITE').AsString)], False);
        cdsDados.FieldByName('ITE_OUTVAL_VALORI').AsFloat := fFormataFloat(FieldByName('ITE_COMTBL').AsFloat * FieldByName('ITE_UNIORI').AsFloat / 100, fCfgSis('DECUNI', varInteger)) + fltOutValProduto;
      End
      Else If Assigned(cdsDados.FindField('ITE_OUTVAL')) Then
        cdsDados.FieldByName('ITE_OUTVAL_VALORI').AsFloat := cdsDados.FieldByName('ITE_OUTVAL').AsFloat
      Else If Assigned(cdsVendaOri.FindField('ITE_OUTVAL')) Then
        cdsDados.FieldByName('ITE_OUTVAL_VALORI').AsFloat := cdsVendaOri.FieldByName('ITE_OUTVAL').AsFloat;
    End;

    cdsDados.FieldByName('ITE_DESOPE_CLI').AsFloat        := fltDesOpeCli;
    cdsDados.FieldByName('ITE_CLAFIS').AsString           := strClaFis;
    cdsDados.FieldByName('PED_ORC_ENT_FUT').AsBoolean     := blnCarregaPedidoOrcamentoEntFut;
    cdsDados.FieldByName('ITE_MARMIN').AsFloat            := FieldByName('ITE_MARMIN').AsFloat;

    cdsDados.FieldByName('ITE_ALQDIFICM_MKPMAR4').AsFloat := FieldByName('ITE_ALQDIF_ICMS_MARGEM').AsFloat;
    cdsDados.FieldByName('ITE_ALQDIFICM_MARMED').AsFloat  := FieldByName('ITE_ALQDIF_ICMS_MARGEM').AsFloat;
    cdsDados.FieldByName('ITE_ALQDIFICM_MARIMP').AsFloat  := FieldByName('ITE_ALQDIF_ICMS_MARGEM_IMPOSTOS').AsFloat;
    cdsDados.FieldByName('ITE_ALQDIFICM_MARITE').AsFloat  := FieldByName('ITE_ALQDIF_ICMS_MARGEM').AsFloat;
    cdsDados.FieldByName('ITE_ALQDIFICM_MARLUC').AsFloat  := FieldByName('ITE_ALQDIF_ICMS_MARGEM').AsFloat;

    cdsDados.FieldByName('ITE_EHEMBA').AsBoolean  := FieldByName('ITE_EHEMBA').AsBoolean;
    cdsDados.FieldByName('ITE_PEREMB').AsFloat    := FieldByName('ITE_PEREMB').AsFloat;
    cdsDados.FieldByName('ITE_VLPEMB').AsFloat    := FieldByName('ITE_VLPEMB').AsFloat;

    If ((fCfgSis('PCMPRO') = 3) And (not fCfgSis('MARIDE', varBoolean))) Then
      cdsDados.FieldByName('ITE_COMTBL').AsFloat := 0;
  End;
end;


procedure TMargemLucro.PreencherDataSetMargemLucroCalculada(cdsDados: TUniClientDataSet; AListaResultadosCalculoMargem: TList<IResultadoCalculoMargemVenda>; blnProcessarTodosRegistros: Boolean);
begin
  If blnProcessarTodosRegistros Then
  Begin
    PreencherDataSetTodosOsRegistros(cdsDados, AListaResultadosCalculoMargem);
    Exit;
  End;

  PreencherDataSetApenasUmRegistro(cdsDados, AListaResultadosCalculoMargem);
end;

procedure TMargemLucro.PreencherDataSetTodosOsRegistros(
  cdsDados: TUniClientDataSet;
  AListaResultadosCalculoMargem: TList<IResultadoCalculoMargemVenda>);
var
  Contador: Integer;
begin
  Contador := 0;

  cdsDados.First;
  While Not cdsDados.Eof Do
  Begin
    cdsDados.Edit;

    AtualizarOsRegistrosDoDataSet(cdsDados, AListaResultadosCalculoMargem, Contador);

    cdsDados.Post;

    cdsDados.Next;
    inc(Contador);
  End;
end;

function TMargemLucro.RetornarResultadoDoItem(
  const cdsDados: TUniClientDataSet): Double;
begin
  Result := (cdsDados.FieldByName('ITE_UNITAR').AsFloat - cdsDados.FieldByName('ITE_PRECUS').AsFloat);
end;

function TMargemLucro.RetorarIdePro(
  const cdsVendaOri: TUniClientDataSet): String;
begin
  Result := 'NOR';

  If (cdsVendaOri.FieldByName('ITE_IDEPRO').AsString = '') Then
    Exit;

  Result := cdsVendaOri.FieldByName('ITE_IDEPRO').AsString;
end;

function TMargemLucro.RetornarCodSit(
  const cdsVendaOri: TUniClientDataSet): String;
begin
  Result := cdsVendaOri.FieldByName('ITE_CODFIS_MARGEM').AsString;
end;

function TMargemLucro.RetornarPercentualDeDesconto(
  const cdsDados: TUniClientDataSet): double;
begin
  Result := 0;

  If Not ValidarSeAplicaPercentualDeDesconto(cdsDados) Then
    Exit;

  Result :=
    objCore.
      fFormataFloat(((cdsDados.FieldByName('ITE_UNIORI').AsFloat - cdsDados.FieldByName('ITE_UNITAR').AsFloat)/cdsDados.FieldByName('ITE_UNIORI').AsFloat) * 100, 2);
end;

function TMargemLucro.RetornarValorCotacaoDolar(
  const cdsDados: TUniClientDataSet;
  const cdsVendaOri: TUniClientDataSet;
  const AValorCotacaoDolarVenda: Double): Double;
begin
  Result := 0;

  If Not ValidarSeUtilizaCotacaoDolar(cdsVendaOri, AValorCotacaoDolarVenda) Then
    Exit;

  Result := (cdsDados.FieldByName('ITE_UNITAR').AsFloat / AValorCotacaoDolarVenda);
end;


function TMargemLucro.ValidarSeAplicaPercentualDeDesconto(
  const cdsDados: TUniClientDataSet): Boolean;
begin
  Result := False;

  If Not (cdsDados.FindField('ITE_PERDES') <> Nil) Then
    Exit;

  If Not (objCore.fFormataFloat(cdsDados.FieldByName('ITE_UNIORI').AsFloat, 2) <> 0) Then
    Exit;

  Result := true;
end;

function TMargemLucro.ValidarSeUtilizaCotacaoDolar(
  const cdsDados: TUniClientDataSet;
  const AValorCotacaoDolarVenda: Double): Boolean;
begin
  Result := False;

  If (AValorCotacaoDolarVenda = 0)  Then
    Exit;

  If Not (cdsDados.FieldByName('ITE_UTILIZA_PRECO_EM_DOLAR_MARGEM').AsBoolean) Then
    Exit;

  Result := true;
end;

end.
