unit untSimulaLancamentoItemVenda;

interface

uses
  System.Classes, untFuncFat, Faturamento.Classes.TFatVendaBase, untImportaCdsVenda,
  cxProgressBar;

type
  TSimulaLancamentoItemVenda = class
  private
    FFatVenda             : TFatVenda;
    FOpcDoc               : String;
    FValorIpi             : Double;
    FImpostosFederais     : Double;
    FValorIcms            : Double;
    FDespesasOperacionais : Double;
    FValorST              : Double;
    FOutrosValores        : Double;
    FCustoReal            : Double;

    function fGetInputDadosBaseCdsVenda(const ACodClli: String): TInputImporta;
    procedure pSetarInformacoesBaseFatVenda;
  public
    procedure SimularLancamento(const ACodCli, ACodIte: String; const AQtdIte,
      AUnitar, APreCus, APerDes, APerCom: Double; const ACodAbf, APerAbf, AEstAbf: String;
      const AProgressBar: TcxProgressBar=nil);

    constructor Create(const AOpcDoc: String='VN');
    destructor Destroy; override;

    property ValorST              : Double read FValorST;
    property ValorIpi             : Double read FValorIpi;
    property ValorIcms            : Double read FValorIcms;
    property OutrosValores        : Double read FOutrosValores;
    property ImpostosFederais     : Double read FImpostosFederais;
    property DespesasOperacionais : Double read FDespesasOperacionais;
    property CustoReal            : Double read FCustoReal;
  end;

implementation

uses
  System.SysUtils, untFuncoesSimples, untMargemLucro, UniClientDataSet,
  untFuncFatTypes;

{ TSimulaLancamentoItemVenda }

constructor TSimulaLancamentoItemVenda.Create(const AOpcDoc: String);
begin
  FOpcDoc   := AOpcDoc;
  FFatVenda := TFatVenda.CreateInstance(FOpcDoc);
  cdsVenda  := FFatVenda.fCriaTemporaria(nil);

  pSetarInformacoesBaseFatVenda;
end;

destructor TSimulaLancamentoItemVenda.Destroy;
begin
  FreeAndNil(FFatVenda);
  inherited;
end;

function TSimulaLancamentoItemVenda.fGetInputDadosBaseCdsVenda(
  const ACodClli: String): TInputImporta;
begin
  FillChar(Result, SizeOf(Result), #0);

  Result.CodigoCliente       := EmptyStr;
  Result.CodigoEmpresa       := VS_strCodEmp;
  Result.TabelaPreco         := '1';
  Result.SequenciaAutoincrem := FFatVenda.fGetMaxAutIncClient(cdsVenda);
  Result.TurnoDeEntrega      := FFatVenda.objTurno.fGetTurno(EmptyStr);
  Result.CodigoVendedor      := strLoginUsuarioLogado;
  Result.NomeVendedor        := fRetNomeOperador(Result.CodigoVendedor);
  Result.CodigoCliente       := ACodClli;
end;

procedure TSimulaLancamentoItemVenda.pSetarInformacoesBaseFatVenda;
begin
  FFatVenda.strTabPre := '1';
end;

procedure TSimulaLancamentoItemVenda.SimularLancamento(const ACodCli,
  ACodIte: String; const AQtdIte, AUnitar, APreCus, APerDes, APerCom: Double;
  const ACodAbf, APerAbf, AEstAbf: String; const AProgressBar: TcxProgressBar);
var
  objLancamentoCdsVenda : TImportaCdsVenda;
  cdsData               : OleVariant;
  cdsItens              : TUniClientDataSet;
  recTotMarLuc          : TRecTotaisMargemLucro;
  recTotMarLucTotIte    : TRecTotaisMargemLucro;
  LCodCli               : String;
  LPreCus               : Double;
  calcCustoReal         : TCalcCustoReal;
begin
  LCodCli := ACodCli;
  If fEmptyStr(LCodCli) Then
    LCodCli := fCfgSis('CLISIM');

  If fEmptyStr(LCodCli) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário que exista um cliente para simulação de '+
                          'lançamento de itens de venda.' + #13#10 +
                          'Preencha a configuração [CFG_CLISIM].', ['&Ok']);
    Exit;
  End;

  objLancamentoCdsVenda := TImportaCdsVenda.Create(fGetInputDadosBaseCdsVenda(LCodCli),
                                                   FFatVenda.fPegaPrecoVenda,
                                                   FFatVenda.fUniDigDescontada,
                                                   FFatVenda.fCalculaPrecosLote,
                                                   FFatVenda.fEmpresaParaFaturamentoUsaWMS);

  cdsItens := TMargemLucro.fCriaEstruturaDadosMargemLucro;
  calcCustoReal := TCalcCustoReal.Create;
  Try
    FValorIpi             := 0;
    FImpostosFederais     := 0;
    FValorIcms            := 0;
    FDespesasOperacionais := 0;
    FValorST              := 0;
    FOutrosValores        := 0;

    FillChar(recTotMarLuc, SizeOf(recTotMarLuc), #0);
    FillChar(recTotMarLucTotIte, SizeOf(recTotMarLucTotIte), #0);

    FFatVenda.pCarregaDadosClienteBaixa(LCodCli);

    objLancamentoCdsVenda.LancarItem(ACodIte, AQtdIte, AUnitar, APerDes,
                                     cdsVenda, AProgressBar, False, False);

    If (Not fEmptyStr(ACodAbf)) And
       (Not fEmptyStr(AEstAbf)) And
       (Not fEmptyStr(APerAbf)) Then
    Begin
      FFatVenda.strCodAbfSimulador := ACodAbf;
      FFatVenda.strPerAbfSimulador := '_SAI_'+Copy(Trim(APerAbf), 1, 3);
      FFatVenda.strEstAbfSimulador := AEstAbf;
    End;

    FFatVenda.pPreencheMatrizFechamento;
    FFatVenda.pCalculaTotGer;
    FFatVenda.pAtualizaTemporariaItens(cdsVenda, False, False, True);
    FFatVenda.fVerificaVrMinimo(FFatVenda.fltTotGer, FFatVenda.fltTotGer, FFatVenda.intPrzMed);

    cdsData := FFatVenda.fCalculaMargemLucro(APerDes <> 0, -1, Nil, True, False);

    cdsItens.Data       := cdsData;
    cdsItens.LogChanges := False;

    FFatVenda.pCalculaTotaisMargemLucro(cdsItens.Data,
                                        recTotMarLuc);

    FFatVenda.pAtualizarCdsComCalculoTotGer(cdsVenda, FFatVenda.arrMatItens[0]);
    FFatVenda.fRecalculaComissao(True, EmptyStr, True, False, APerCom);

    LPreCus := APreCus;
    If LPreCus = 0 Then
      LPreCus := cdsVenda.FieldByName('ITE_PRECUS').AsFloat;

    calcCustoReal.fltUnitar := AUnitar;
    calcCustoReal.fltPreCus := LPreCus;
    calcCustoReal.fltOutVal := cdsVenda.FieldByName('ITE_OUTVAL').AsFloat;
    calcCustoReal.fltIcmSai := cdsVenda.FieldByName('ITE_ICMCAL').AsFloat;
    calcCustoReal.fltImpFed := cdsVenda.FieldByName('ITE_IMPFED').AsFloat;
    calcCustoReal.fltDesOpe := FFatVenda.fProcessarDespesasOperacionaisComplementar(cdsVenda.FieldByName('ITE_DESOPE').AsFloat);
    calcCustoReal.fltDifal  := cdsVenda.FieldByName('ITE_VDIFAL_MARGEM').AsFloat;
    calcCustoReal.fltFcp    := cdsVenda.FieldByName('ITE_VALFCP').AsFloat;

    FCustoReal := FFatVenda.fRetornaPrecoCusto(
                                 Preco_de_Custo_Real,
                                 ACodIte,
                                 VS_strCodEmp,
                                 LPreCus,
                                 EmptyStr,
                                 calcCustoReal);

    FFatVenda.pAtualizarCdsComCalculoTotGer(cdsVenda, FFatVenda.arrMatItens[0]);

    FValorIpi             := cdsVenda.FieldByName('ITE_VALIPI').AsFloat;
    FImpostosFederais     := fFormataFloat(AUnitar * (cdsVenda.FieldByName('ITE_IMPFED').AsFloat/100), 2);
    FValorIcms            := cdsVenda.FieldByName('ITE_VALICM').AsFloat;
    FDespesasOperacionais := fFormataFloat(AUnitar * (cdsVenda.FieldByName('ITE_DESOPE').AsFloat/100), 2);
    FValorST              := cdsVenda.FieldByName('ITE_VAL_ST').AsFloat;
    FOutrosValores        := cdsVenda.FieldByName('ITE_OUTVAL').AsFloat;
  Finally
    If Assigned(AProgressBar) Then
      AProgressBar.Visible := False;

    FreeAndNil(cdsItens);
    FreeAndNil(calcCustoReal);

    FreeAndNil(objLancamentoCdsVenda);
  End;
end;

end.

