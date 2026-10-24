unit untImportaCdsVenda;

interface

uses ImportacaoDados.Interfaces, System.Generics.Collections, Data.DB, Uni,
  Vcl.ComCtrls, Faturamento.Classes.InformacoesPromocaoProduto, untFuncFatTypes,
  cxProgressBar;

type
  TFncPegaPrecoVenda = function(const CdsDaVenda: TDataset) : TPegaPrecoVendaOutput of object;
  TFncUniDigDescontada = function(const fltUniDig, fltTaxJur, fltDescon, fltDesCnd: Double; const strItemPromocao: String): Double of object;
  TFncCalculaPrecosLote = function(const strCodIte, strNumLot, strTabPre, strCodEmp : String; const fltQtdIte: Double; Var fltUnitar: Double) : Boolean of object;
  TFncEmpresaParaFaturamentoUsaWMS = function(strCodEmp: String): Boolean of object;

  TInputImporta = record
    CodigoCliente : String;
    CodigoEmpresa : String;
    TabelaPreco : String;
    SequenciaAutoincrem : Integer;
    TurnoDeEntrega : String;
    CodigoVendedor : String;
    NomeVendedor : String;
    CodigoVendedor2 : String;
    CodigoCondicao : String;
    PrazoDePagamento : Integer;
    CondicaoPagamento : String;
  End;

  TImportaCdsVenda = class
  private
    Type
      TIndiceCampos = record
        CodigoProduto : Integer;
        QuantidadeProduto : Integer;
        EntregaRetira : Integer;
        UnitarioDigitado : Integer;
        Unitario : Integer;
        Desconto : Integer;
        TabelaDePrecoItem : Integer;
        Complemento : Integer;
        CodigoUnidade : Integer;
        EmpresaDeFaturamentoItem : Integer;
        NumeroLote : Integer;
        LocalDeRetira : Integer;
        EntregaFutura : Integer;
        MotivoEntregaFutura : Integer;
        ClienteBusca : Integer;
        DiasEntrega : Integer;
        DataEntrega : Integer;
        Pegou : Integer;
        Brinde : Integer;
      End;
      TValoresLinha = record
        CodigoProduto : String;
        QuantidadeProduto : String;
        EntregaRetira : String;
        UnitarioDigitado : String;
        Unitario : String;
        Desconto : String;
        TabelaDePrecoItem : String;
        Complemento : String;
        CodigoUnidade : String;
        EmpresaDeFaturamentoItem : String;
        NumeroLote : String;
        LocalDeRetira : String;
        EntregaFutura : String;
        MotivoEntregaFutura : String;
        ClienteBusca : String;
        DiasEntrega : String;
        DataEntrega : String;
        Pegou : String;
        Brinde : String;
      End;
      TJaDigitado = record
        Codigo : String;
        Quantidade : Double;
        Promocao : String;
      End;
      TResultPromo = record
        IdItem : Integer;
        Promocao : TInformacoesPromocaoProdutoOutput;
      End;
  private
    FUltimaTemporariaGerada : String;
    FInput : TInputImporta;
    FFncPegaPrecoVenda : TFncPegaPrecoVenda;
    FFncUniDigDescontada : TFncUniDigDescontada;
    FFncCalculaPrecosLote : TFncCalculaPrecosLote;
    FFncEmpresaParaFaturamentoUsaWMS : TFncEmpresaParaFaturamentoUsaWMS;
    function SQLTemporariaDeVenda(const ANomeTemporaria : String): String;
    function GerarNovaTemporaria(const ALinhasImportadas: TList<ILinha>): String; overload;
    function GerarNovaTemporaria: String; overload;
    function PegaProximoNomeTemporaria: String;
    procedure InserirItensTemporaria(const ANomeTabela: String; const ALinhasImportadas: TList<ILinha>);
    function SQLInsertTmp(const ANomeTabela : String; const AValues : String) : String;
    function CriarTemporaria(const ANomeTabela: String): Boolean;
    procedure CopyData(const AOrigem: TDataSet; const ADestino: TDataSet; AProgressBar: TcxProgressBar = Nil);
    procedure Progresso(const AProgress: Integer; const AMax: Integer; const AProgressBar: TcxProgressBar);
    function GetIndiceCampos(const ALinha : ILinha) : TIndiceCampos;
    procedure AtribuiIndice(const ACampo : ICampoLinha; const ANomeCampo : String; var ACampoAtribuicao : Integer; const AIndice : Integer);
    function PegaValorMonetario(const AValor : String) : String;
    procedure ApagarTemporaria(const ANomeTemporaria: String);
    function PegaValoresDaLinha(const ALinha : ILinha; const AIndiceCampos : TIndiceCampos) : TValoresLinha; overload;
    function PegaValoresDaLinha(const ALinha : ILinha; const AIndex : Integer): String; overload;
    function SQLFieldTabelaPreco : String;
    function SQLFieldPrecoDeTabelaEscolhido : String;
    function IfEmptyNull(const AValor : String) : String;
    function CarregarItensQuePodemEstarNaPromocao : TUniQuery;
    procedure TotalizarDigitados(const ACodigoProduto : String; const ALista : TList<TJaDigitado>; var AQtdJaDig, AQtdJaEmPromoc : Double);
    procedure ProcessarItensPromocionais(const AProgressBar: TcxProgressBar; const ACdsVenda : TDataSet);
    procedure ProcessarPrecoDeVendaDosItens(const AProgressBar: TcxProgressBar; const ACdsVenda : TDataSet);
    function ProdutosEmPromocao(AProgressBar : TcxProgressBar) : TList<TResultPromo>;
    procedure AtualizarQuantidadeDiasParaEntrega(const ADataSet : TDataSet);
    procedure AtualizarDataDeEntrega(const ADataSet : TDataSet);
    procedure AtualizaSequencialUnicoAutoCenter(const ADataSet : TDataSet);
    procedure AtualizaLoteADefinir(const ADataSet : TDataSet);
  public
    procedure Importar(const ALinhasImportadas: TList<ILinha>; const ACdsVenda : TDataSet; AProgressBar: TcxProgressBar);
    procedure LancarItem(const ACodIte: String; const AQtdIte, AUnitar,
      APerDes: Double; const ACdsVenda: TDataSet;
      const AProgressBar: TcxProgressBar=nil; const AProcessarPromocao: Boolean=True;
      const AProcessarPrecoVendaItens: Boolean=True);
    constructor Create(const AInput : TInputImporta; const AFncPegaPrecoVenda : TFncPegaPrecoVenda; AFncUniDigDescontada : TFncUniDigDescontada; AFncCalculaPrecosLote : TFncCalculaPrecosLote; AFncEmpresaParaFaturamentoUsaWMS : TFncEmpresaParaFaturamentoUsaWMS);
    destructor Destroy; override;
  End;

implementation

uses System.SysUtils, untFuncoes, untConstantes, untTypesSistema, untGravando,
  System.StrUtils, untFuncoesSimples, System.DateUtils, System.Variants;

{ TImportaCdsVenda }

procedure TImportaCdsVenda.Importar(const ALinhasImportadas: TList<ILinha>; const ACdsVenda : TDataSet; AProgressBar: TcxProgressBar);
  Var
    LQueryVenda : TUniQuery;
begin
  ApagarTemporaria(FUltimaTemporariaGerada);
  FUltimaTemporariaGerada := GerarNovaTemporaria(ALinhasImportadas);
  LQueryVenda := fCriaQuery;
  Try
    LQueryVenda.SQL.Text := SQLTemporariaDeVenda(FUltimaTemporariaGerada);
    LQueryVenda.ParamByName('CODEMP').AsString := FInput.CodigoEmpresa;
    LQueryVenda.ParamByName('CODCLI').AsString := FInput.CodigoCliente;
    LQueryVenda.Open;
    If (LQueryVenda.IsEmpty) Then
      Exit;
    CopyData(LQueryVenda, ACdsVenda, AProgressBar);
    ProcessarItensPromocionais(AProgressBar, ACdsVenda);
    ProcessarPrecoDeVendaDosItens(AProgressBar, ACdsVenda);
  Finally
    FreeAndNil(LQueryVenda);
  End;
end;

function TImportaCdsVenda.GerarNovaTemporaria(const ALinhasImportadas: TList<ILinha>): String;
  Var
    LNomeTabela : String;
begin
  Result := EmptyStr;
  LNomeTabela := PegaProximoNomeTemporaria;
  If Not CriarTemporaria(LNomeTabela) Then
    Exit;
  InserirItensTemporaria(LNomeTabela, ALinhasImportadas);
  Result := LNomeTabela;
end;

function TImportaCdsVenda.PegaProximoNomeTemporaria: String;
  Var
    strSeqTab: String;
begin
  strSeqTab := fRetSequencial('TPIMVN', VS_strCodEmp, 12);
  Result := 'TMP_TPIMVN_' + VS_strCodEmp + '_' + strSeqTab;
end;

function TImportaCdsVenda.SQLTemporariaDeVenda(const ANomeTemporaria : String): String;
  Var
    strSQL : String;
begin
  strSQL := EmptyStr;
  strSQL := strSQL + ' SELECT "S" AS ITE_ITENOV ';
  strSQL := strSQL + '       ,"S" AS ITE_ENTSAI ';
  strSQL := strSQL + '       ,"S" AS ITE_FDOITERECALC ';
  strSQL := strSQL + '       ,"S" AS ITE_RESERV ';
  strSQL := strSQL + '       ,"S" AS ITE_RATDES ';
  strSQL := strSQL + '       ,TRUE AS ITE_PODALT ';
  strSQL := strSQL + '       ,"N" AS ITE_BASTRO ';
  strSQL := strSQL + '       ,"N" AS ITE_ALTEST ';
  strSQL := strSQL + '       ,"N" AS ITE_RATEST ';
  strSQL := strSQL + '       ,"N" AS ITE_INSERE ';
  strSQL := strSQL + '       ,"N" AS ITE_ALTERA ';
  strSQL := strSQL + '       ,"N" AS ITE_ATIVAC ';
  strSQL := strSQL + '       ,"N" AS ITE_SITUAC ';
  strSQL := strSQL + '       ,"N" AS ITE_PROEMB ';
  strSQL := strSQL + '       ,"N" AS ITE_LIBEST ';
  strSQL := strSQL + '       ,"N" AS ITE_REGESP ';
  strSQL := strSQL + '       ,"N" AS ITE_LIBUNI ';
  strSQL := strSQL + '       ,"N" AS ITE_ALTPCO ';
  strSQL := strSQL + '       ,"N" AS ITE_PIGBAS ';
  strSQL := strSQL + '       ,"N" AS ITE_EXIBSE ';
  strSQL := strSQL + '       ,"N" AS ITE_LCTBAR ';
  strSQL := strSQL + '       ,"N" AS ITE_TEMNSE ';
  strSQL := strSQL + '       ,FALSE AS ITE_ENT_CD ';
  strSQL := strSQL + '       ,FALSE AS ITE_JAFATU ';
  strSQL := strSQL + '       ,FALSE AS ITE_PROACA ';
  strSQL := strSQL + '       ,FALSE AS ITE_ITETRA ';
  strSQL := strSQL + '       ,FALSE AS ITE_UPSEML ';
  strSQL := strSQL + '       ,FALSE AS ITE_EDIPES ';
  strSQL := strSQL + '       ,FALSE AS ITE_MNTPRC ';
  strSQL := strSQL + '       ,"NOR" AS ITE_IDEPRO ';
  strSQL := strSQL + '       ,I.ITE_CODGRU ';
  strSQL := strSQL + '       ,I.ITE_CODITE ';
  strSQL := strSQL + '       ,I.ITE_DESITE AS ITE_DESORI ';
  strSQL := strSQL + '       ,I.ITE_DESITE ';
  strSQL := strSQL + '       ,I.ITE_CEREPI ';
  strSQL := strSQL + '       ,I.ITE_MSGLV1 ';
  strSQL := strSQL + '       ,I.ITE_MSGLV2 ';
  strSQL := strSQL + '       ,I.ITE_DESFAB ';
  strSQL := strSQL + '       ,I.ITE_CODMAR ';
  strSQL := strSQL + '       ,I.ITE_CODFOR ';
  strSQL := strSQL + '       ,I.ITE_REFERE ';
  strSQL := strSQL + '       ,I.ITE_COMLUB ';
  strSQL := strSQL + '       ,I.ITE_CODITE AS ABF_ITEABF ';
  strSQL := strSQL + '       ,I.ITE_PESOIT ';
  strSQL := strSQL + '       ,I.ITE_PESLIQ ';
  strSQL := strSQL + '       ,I.ITE_CODFAB ';
  strSQL := strSQL + '       ,I.ITE_INCPIS ';
  strSQL := strSQL + '       ,I.ITE_EMBALA ';
  strSQL := strSQL + '       ,I.ITE_OBRCPF ';
  strSQL := strSQL + '       ,I.ITE_INFLAM ';
  strSQL := strSQL + '       ,I.ITE_PRDGRU ';
  strSQL := strSQL + '       ,I.ITE_USABON ';
  strSQL := strSQL + '       ,I.ITE_OBRIBA ';
  strSQL := strSQL + '       ,I.ITE_NOTESP ';
  strSQL := strSQL + '       ,I.ITE_APLICA ';
  strSQL := strSQL + '       ,I.ITE_CODBAR ';
  strSQL := strSQL + '       ,I.ITE_EXCIPI ';
  strSQL := strSQL + '       ,I.ITE_PESOIT AS ITE_PESOITCAD ';
  strSQL := strSQL + '       ,I.ITE_PESLIQ AS ITE_PESLIQCAD ';
  strSQL := strSQL + '       ,I.ITE_CLAIPI ';
  strSQL := strSQL + '       ,I.ITE_ATICOM ';
  strSQL := strSQL + '       ,I.ITE_PIIZFM ';
  strSQL := strSQL + '       ,I.ITE_CILVAS ';
  strSQL := strSQL + '       ,I.ITE_USADCE ';
  strSQL := strSQL + '       ,I.ITE_CLADCE ';
  strSQL := strSQL + '       ,ROUND(TMP_QTDITE * G.ITE_PREULT, 2) AS ITE_TOTULT ';
  strSQL := strSQL + '       ,ROUND(TMP_QTDITE * G.ITE_IMPULT, 2) AS ITE_IMPULT ';
  strSQL := strSQL + '       ,ROUND(TMP_QTDITE * G.ITE_IMPULT, 2) AS ITE_TOTIMP ';
  strSQL := strSQL + '       ,ROUND(TMP_QTDITE * G.ITE_PRECUS, 2) AS ITE_TOTCUS ';
  strSQL := strSQL + '       ,TMP_QTDITE AS ITE_QTDITE ';
  strSQL := strSQL + '       ,TMP_QTDITE AS ITE_QTDORI ';
  strSQL := strSQL + '       ,TMP_QTDITE AS ITE_QTDPRI ';
  strSQL := strSQL + '       ,G.ITE_PREULT ';
  strSQL := strSQL + '       ,G.ITE_PRECUS AS ITE_CUSITE ';
  strSQL := strSQL + '       ,G.ITE_PRECUS ';
  strSQL := strSQL + '       ,G.ITE_IPISAI ';
  strSQL := strSQL + '       ,G.ITE_DESMAX ';
  strSQL := strSQL + '       ,G.ITE_PREVE1 ';
  strSQL := strSQL + '       ,G.ITE_PREVE2 ';
  strSQL := strSQL + '       ,G.ITE_PREVE3 ';
  strSQL := strSQL + '       ,G.ITE_PREVE4 ';
  strSQL := strSQL + '       ,G.ITE_PREVE5 ';
  strSQL := strSQL + '       ,G.ITE_PREVE6 ';
  strSQL := strSQL + '       ,G.ITE_PREVE7 ';
  strSQL := strSQL + '       ,G.ITE_COMVAR ';
  strSQL := strSQL + '       ,G.ITE_COMATA ';
  strSQL := strSQL + '       ,G.ITE_COMDIS ';
  strSQL := strSQL + '       ,G.ITE_COMDIG ';
  strSQL := strSQL + '       ,G.ITE_PREMED ';
  strSQL := strSQL + '       ,G.ITE_SALDOS ';
  strSQL := strSQL + '       ,G.ITE_MARMIN ';
  strSQL := strSQL + '       ,G.ITE_MARMSG ';
  strSQL := strSQL + '       ,G.ITE_MARMGE ';
  strSQL := strSQL + '       ,G.ITE_MARMMV ';
  strSQL := strSQL + '       ,G.ITE_MARMMS ';
  strSQL := strSQL + '       ,G.ITE_MARMMG ';
  strSQL := strSQL + '       ,G.ITE_OUTVAL ';
  strSQL := strSQL + '       ,G.ITE_OUTVAL AS SAV_OUTVAL ';
  strSQL := strSQL + '       ,G.ITE_DESOPE ';
  strSQL := strSQL + '       ,G.ITE_ICMSAI ';
  strSQL := strSQL + '       ,G.ITE_IMPFED ';
  strSQL := strSQL + '       ,G.ITE_PRECOM ';
  strSQL := strSQL + '       ,G.ITE_QTPPRO ';
  strSQL := strSQL + '       ,G.ITE_DESMGE ';
  strSQL := strSQL + '       ,G.ITE_DESMVM ';
  strSQL := strSQL + '       ,G.ITE_DESMSM ';
  strSQL := strSQL + '       ,G.ITE_DESMGM ';
  strSQL := strSQL + '       ,G.ITE_IPIENT ';
  strSQL := strSQL + '       ,G.ITE_FREENT ';
  strSQL := strSQL + '       ,G.ITE_DESMSU ';
  strSQL := strSQL + '       ,G.ITE_DTAVAL ';
  strSQL := strSQL + '       ,G.ITE_LOCFIS ';
  strSQL := strSQL + '       ,G.ITE_RECDEV ';
  strSQL := strSQL + '       ,G.ITE_SOBENC ';
  strSQL := strSQL + '       ,G.ITE_IMPULT ';
  strSQL := strSQL + '       ,G.ITE_MEDSIC ';
  If fCfgSis('TIPABF', varString) = '1' Then
    strSQL := strSQL + '     ,I.ITE_CODABF AS ABF_CODABF '
  Else
    strSQL := strSQL + '     ,G.ITE_CODABF AS ABF_CODABF ';
  strSQL := strSQL + '       ,F.FOR_PERCOM AS ITE_COMFOR ';
  strSQL := strSQL + '       ,GRU_PERCOM ';
  strSQL := strSQL + '       ,MAR_DESMAR AS ITE_DESMAR ';
  strSQL := strSQL + '       ,IF(IFNULL(TMP_CODUNI,"") = "", I.ITE_CODUNI, TMP_CODUNI) AS ITE_UNIDAD ';
  strSQL := strSQL + '       ,IF(IFNULL(TMP_CODUNI,"") = "", I.ITE_CODUNI, TMP_CODUNI) AS ITE_CODUNI ';
  strSQL := strSQL + '       ,CADUNI.UNI_SIGUNI AS ITE_SIGUNI ';
  strSQL := strSQL + '       ,CADUNI.UNI_ITEFRA AS ITE_ITEFRA ';
  strSQL := strSQL + '       ,IF(CADUNI.UNI_KILLIT = "L" OR CADUNI.UNI_KILLIT = "", CADUNI.UNI_PESLIT, 0) AS ITE_LITRAG ';
  If (fCfgSis('EMPCAR', varString) = 'S') Then
    strSQL := strSQL + '     ,I.ITE_EMPCAR '
  Else
    strSQL := strSQL + '     ,"N" AS ITE_EMPCAR ';
  If fCfgSis('IMPDIG', varString) = '1' Then
    strSQL := strSQL + '     ,IF(I.ITE_IMPDIR = "", "N", I.ITE_IMPDIR) AS ITE_IMPDIR '
  Else
    strSQL := strSQL + '     ,IF(G.ITE_IMPDIR = "", "N", G.ITE_IMPDIR) AS ITE_IMPDIR ';
  strSQL := strSQL + '       ,CADLOC.LOC_DESCRI AS ITE_DESFIS ';
  If fCfgSis('INDREV') = '1' Then
    strSQL := strSQL + '     ,I.ITE_INDREV '
  Else
    strSQL := strSQL + '     ,G.ITE_INDREV ';
  strSQL := strSQL + '       ,CLIPRO.CLI_COD_NF AS ITE_COD_NF ';
  strSQL := strSQL + '       ,CLIPRO.CLI_CODBAR AS ITE_CLIBAR ';
  strSQL := strSQL + '       ,CLIPRO.CLI_DES_NF AS ITE_DES_NF ';

  strSQL := strSQL + '       ,IF(PROESP.AUTOINCREM IS NULL, "N", "S") AS ITE_PROESP ';
  strSQL := strSQL + '       ,IF(IFNULL(ITEGER_EMPCAR.ITE_CODEMP, "") <> "" AND ITEGER_EMPCAR.ITE_CODEMP <> I.ITE_EMPCAR, ITEGER_EMPCAR.ITE_SALDOS, 0.00) AS ITE_SALCAR ';
  strSQL := strSQL + '       ,TMP_ENTRET AS ITE_ENTRET ';
  strSQL := strSQL + '       ,IF(TMP_ENTRET = "E", "ENT", "RET") AS ITE_ENTDSC ';

  If (fCfgSis('EXITUR', varString) = 'S') Then
    strSQL := strSQL + '     ,IF(TMP_ENTRET = "E", ' + QuotedStr(FInput.TurnoDeEntrega) + ', "     ") AS ITE_TURENT ';

  strSQL := strSQL + '       ,' + QuotedStr(FInput.CodigoVendedor) + ' AS ITE_CODVEN ';
  strSQL := strSQL + '       ,' + QuotedStr(FInput.NomeVendedor) + ' AS ITE_NOMVEN ';
  strSQL := strSQL + '       ,' + QuotedStr(FInput.CodigoVendedor2) + ' AS ITE_CODVE2 ';

  If (fCfgSis('ENTFUT', varString) = 'S') Then
  Begin
    strSQL := strSQL + '     ,IF(IFNULL(TMP_ENTFUT,"") = "", "N", TMP_ENTFUT) AS ITE_ENTFUT ';
    strSQL := strSQL + '     ,TMP_MOTFUT AS ITE_MOTFUT ';
  End
  Else
  Begin
    strSQL := strSQL + '     ,"N" AS ITE_ENTFUT ';
    strSQL := strSQL + '     ,CAST("" AS CHAR(1)) AS ITE_MOTFUT ';
  End;

  If (fCfgSis('LOCRET', varString) = 'S') Then
    strSQL := strSQL + '     ,IF(TMP_ENTRET = "R", TMP_LOCRET, "") AS ITE_LOCRET ';

  strSQL := strSQL + '       ,TMP_DTENTR AS ITE_DTENTR ';

  If (fCfgSis('PCMPRO', varString) <> '1') Then
  Begin
    strSQL := strSQL + '     ,IFNULL((CASE ' + SQLFieldTabelaPreco;
    strSQL := strSQL + '              WHEN "1" THEN G.ITE_COMTB1 ';
    strSQL := strSQL + '              WHEN "2" THEN G.ITE_COMTB2 ';
    strSQL := strSQL + '              WHEN "3" THEN G.ITE_COMTB3 ';
    strSQL := strSQL + '              WHEN "4" THEN G.ITE_COMTB4 ';
    strSQL := strSQL + '              WHEN "5" THEN G.ITE_COMTB5 ';
    strSQL := strSQL + '              WHEN "6" THEN G.ITE_COMTB6 ';
    strSQL := strSQL + '              WHEN "7" THEN G.ITE_COMTB7 ';
    strSQL := strSQL + '           END ), 0) AS ITE_COMTBL ';
  End;

  strSQL := strSQL + '       ,' + SQLFieldTabelaPreco + ' AS ITE_TABANT ';
  strSQL := strSQL + '       ,' + SQLFieldTabelaPreco + ' AS ITE_TABPRE ';

  If (fCfgSis('EMPFAT', varString) = 'S') Then
    strSQL := strSQL + '       ,IF(IFNULL(TMP_EMPFAT,"") = "", ' + QuotedStr(FInput.CodigoEmpresa) + ', TMP_EMPFAT) AS ITE_EMPITE '
  Else
    strSQL := strSQL + '       ,' + QuotedStr(FInput.CodigoEmpresa) + ' AS ITE_EMPITE ';

  strSQL := strSQL + '       ,-1 AS ITE_SEQPER ';
  strSQL := strSQL + '       ,' + SQLFieldPrecoDeTabelaEscolhido + ' AS ITE_PREATU ';
  strSQL := strSQL + '       ,' + SQLFieldPrecoDeTabelaEscolhido + ' AS ITE_PRETAB ';
  strSQL := strSQL + '       ,TMP_IDITEM AS AUTOINCREM ';

  strSQL := strSQL + '       ,"N" AS ITE_PROMOC ';
  strSQL := strSQL + '       ,0.00 AS ITE_PROCUS ';
  strSQL := strSQL + '       ,0.00 AS ITE_PROVEN ';
  strSQL := strSQL + '       ,0.00 AS ITE_PROCVA ';
  strSQL := strSQL + '       ,0.00 AS ITE_PROCAT ';
  strSQL := strSQL + '       ,0.00 AS ITE_PROCDI ';
  strSQL := strSQL + '       ,"P" AS ITE_COMPRO ';
  strSQL := strSQL + '       ,CAST("" AS CHAR(12)) AS ITE_CODPRO ';
  strSQL := strSQL + '       ,0.00 AS ITE_DESF07 ';
  strSQL := strSQL + '       ,CAST("" AS CHAR(80)) AS ITE_DESPRO ';
  strSQL := strSQL + '       ,TMP_DESCON AS ITE_DESCON ';
  strSQL := strSQL + '       ,TMP_COMPLE AS ITE_COMPLE ';
  strSQL := strSQL + '       ,TMP_NUMLOT AS ITE_NUMLOT ';
  strSQL := strSQL + '       ,IF(IFNULL(TMP_CLIBUS,"") = "", "N", TMP_CLIBUS) AS ITE_CLIBUS ';
  strSQL := strSQL + '       ,0 AS ITE_QDENTR ';
  strSQL := strSQL + '       ,IF(IFNULL(TMP_PEGOU_, "") = "", "N", TMP_PEGOU_) AS ITE_PEGOU_ ';
  strSQL := strSQL + '       ,IF(IFNULL(TMP_BRINDE, "") = "", "N", TMP_BRINDE) AS ITE_BRINDE ';
  strSQL := strSQL + '       ,0.00 AS ITE_TOTITE ';
  strSQL := strSQL + '       ,CAST("" AS CHAR(1)) AS FLG_STATUS ';
  strSQL := strSQL + '       ,0.00 AS ITE_UNIORI ';
  strSQL := strSQL + '       ,0.00 AS ITE_UNIVIS ';
  strSQL := strSQL + '       ,0.00 AS ITE_UNILOD ';
  strSQL := strSQL + '       ,0.00 AS ITE_UNIDOL ';
  strSQL := strSQL + '       ,IF(G.ITE_PREDOL = "S", TRUE, FALSE) AS ITE_UTILIZA_PRECO_EM_DOLAR_MARGEM ';
  strSQL := strSQL + '       ,TMP_UNITAR AS ITE_UNITAR ';
  strSQL := strSQL + '       ,TMP_UNIDIG AS ITE_UNIDIG ';
  strSQL := strSQL + '       ,FALSE AS ITE_PROCND ';
  strSQL := strSQL + '       ,FALSE AS ITE_EHEMBA ';
  strSQL := strSQL + '       ,0.00 AS ITE_PEREMB ';
  strSQL := strSQL + '       ,0.00 AS ITE_VLPEMB ';
  strSQL := strSQL + '       ,0.00 AS ITE_VLBEMB ';
  strSQL := strSQL + '       ,0.00 AS ITE_ESTORI ';
  strSQL := strSQL + '       ,0 AS ITE_SEQEST ';
  strSQL := strSQL + '       ,CAST("" AS CHAR(1)) AS ITE_ITEEST ';
  strSQL := strSQL + '       ,0.00 AS ITE_UNIEST ';
  strSQL := strSQL + '       ,0.00 AS ITE_QTDSBI ';
  strSQL := strSQL + '       ,0.00 AS ITE_UNISBI ';
  strSQL := strSQL + '       ,0.00 AS ITE_ESTQTD ';
  strSQL := strSQL + '       ,' + IntToStr(Integer(oaTodos)) + ' AS ITE_OPCABS ';
  strSQL := strSQL + '       ,"N" AS ITE_BXSBIT ';
  strSQL := strSQL + '       ,0 AS ITE_SEQIND ';
  strSQL := strSQL + '   FROM ' + ANomeTemporaria + ' T ';
  strSQL := strSQL + '   JOIN CADITE I ON T.TMP_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '   JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '                AND G.ITE_CODEMP = :CODEMP ';
  strSQL := strSQL + '   JOIN CADGRU ON GRU_CODGRU = I.ITE_CODGRU ';
  strSQL := strSQL + '   LEFT JOIN CADUNI ON UNI_CODUNI = IF(IFNULL(TMP_CODUNI,"") = "", I.ITE_CODUNI, TMP_CODUNI) ';
  strSQL := strSQL + '   LEFT JOIN CADFOR F ON F.FOR_CODFOR = I.ITE_CODFOR ';
  strSQL := strSQL + '   LEFT JOIN CADMAR ON MAR_CODMAR = I.ITE_CODMAR ';
  strSQL := strSQL + '   LEFT JOIN CADLOC ON LOC_CODLOC = G.ITE_LOCFIS ';
  strSQL := strSQL + '                   AND LOC_CODEMP = :CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CLIPRO ON CLIPRO.CLI_CODCLI = :CODCLI ';
  strSQL := strSQL + '                   AND CLIPRO.CLI_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '   LEFT JOIN PROESP ON PROESP.ESP_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '                   AND PROESP.ESP_CODEMP = :CODEMP ';
  strSQL := strSQL + '   LEFT JOIN ITEGER ITEGER_EMPCAR ON ITEGER_EMPCAR.ITE_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '                                 AND ITEGER_EMPCAR.ITE_CODEMP = I.ITE_EMPCAR ';
  strSQL := strSQL + '  WHERE I.ITE_ITEATI = "S" ';
  Result := strSQL;
end;

function TImportaCdsVenda.GerarNovaTemporaria: String;
var
  LNomeTabela : String;
begin
  Result      := EmptyStr;
  LNomeTabela := PegaProximoNomeTemporaria;

  If Not CriarTemporaria(LNomeTabela) Then
    Exit;

  Result := LNomeTabela;
end;

function TImportaCdsVenda.GetIndiceCampos(const ALinha : ILinha) : TIndiceCampos;
  Var
    LCampo : Integer;
    LIndex : Integer;
begin
  FillChar(Result, SizeOf(Result), #0);
  For LCampo := 0 To Pred(ALinha.Campos.Count) Do
  Begin
    LIndex := Succ(LCampo);
    AtribuiIndice(ALinha.Campos[LCampo], 'ITE_CODITE', Result.CodigoProduto, LIndex);
    AtribuiIndice(ALinha.Campos[LCampo], 'ITE_QTDITE', Result.QuantidadeProduto, LIndex);
    AtribuiIndice(ALinha.Campos[LCampo], 'ITE_ENTRET', Result.EntregaRetira, LIndex);
    AtribuiIndice(ALinha.Campos[LCampo], 'ITE_UNIDIG', Result.UnitarioDigitado, LIndex);
    AtribuiIndice(ALinha.Campos[LCampo], 'ITE_UNITAR', Result.Unitario, LIndex);
    AtribuiIndice(ALinha.Campos[LCampo], 'ITE_DESCON', Result.Desconto, LIndex);
    AtribuiIndice(ALinha.Campos[LCampo], 'ITE_TABPRE', Result.TabelaDePrecoItem, LIndex);
    AtribuiIndice(ALinha.Campos[LCampo], 'ITE_COMPLE', Result.Complemento, LIndex);
    AtribuiIndice(ALinha.Campos[LCampo], 'ITE_CODUNI', Result.CodigoUnidade, LIndex);
    AtribuiIndice(ALinha.Campos[LCampo], 'ITE_EMPFAT', Result.EmpresaDeFaturamentoItem, LIndex);
    AtribuiIndice(ALinha.Campos[LCampo], 'ITE_NUMLOT', Result.NumeroLote, LIndex);
    AtribuiIndice(ALinha.Campos[LCampo], 'ITE_LOCRET', Result.LocalDeRetira, LIndex);
    AtribuiIndice(ALinha.Campos[LCampo], 'ITE_ENTFUT', Result.EntregaFutura, LIndex);
    AtribuiIndice(ALinha.Campos[LCampo], 'ITE_MOTFUT', Result.MotivoEntregaFutura, LIndex);
    AtribuiIndice(ALinha.Campos[LCampo], 'ITE_CLIBUS', Result.ClienteBusca, LIndex);
    AtribuiIndice(ALinha.Campos[LCampo], 'ITE_QDENTR', Result.DiasEntrega, LIndex);
    AtribuiIndice(ALinha.Campos[LCampo], 'ITE_DTENTR', Result.DataEntrega, LIndex);
    AtribuiIndice(ALinha.Campos[LCampo], 'ITE_PEGOU_', Result.Pegou, LIndex);
    AtribuiIndice(ALinha.Campos[LCampo], 'ITE_BRINDE', Result.Brinde, LIndex);
  End;
end;

procedure TImportaCdsVenda.AtribuiIndice(const ACampo : ICampoLinha; const ANomeCampo : String; var ACampoAtribuicao : Integer; const AIndice : Integer);
begin
  If (ACampo.Propriedades.NomeCampo <> ANomeCampo) Then
    Exit;
  ACampoAtribuicao := AIndice;
end;

function TImportaCdsVenda.PegaValorMonetario(const AValor : String) : String;
begin
  If fEmptyStr(AValor) Then
    Result := '0.00'
  Else
    Result := AnsiReplaceStr(AnsiReplaceStr(AValor, '.', EmptyStr), ',', '.');
end;

function TImportaCdsVenda.PegaValoresDaLinha(const ALinha : ILinha; const AIndiceCampos : TIndiceCampos) : TValoresLinha;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result.CodigoProduto := PegaValoresDaLinha(ALinha, Pred(AIndiceCampos.CodigoProduto));
  Result.QuantidadeProduto := PegaValorMonetario(PegaValoresDaLinha(ALinha, Pred(AIndiceCampos.QuantidadeProduto)));
  Result.EntregaRetira := PegaValoresDaLinha(ALinha, Pred(AIndiceCampos.EntregaRetira));
  Result.UnitarioDigitado := PegaValorMonetario(PegaValoresDaLinha(ALinha, Pred(AIndiceCampos.UnitarioDigitado)));
  Result.Unitario := PegaValorMonetario(PegaValoresDaLinha(ALinha, Pred(AIndiceCampos.Unitario)));
  Result.Desconto := PegaValorMonetario(PegaValoresDaLinha(ALinha, Pred(AIndiceCampos.Desconto)));
  Result.TabelaDePrecoItem := PegaValoresDaLinha(ALinha, Pred(AIndiceCampos.TabelaDePrecoItem));
  Result.Complemento := PegaValoresDaLinha(ALinha, Pred(AIndiceCampos.Complemento));
  Result.CodigoUnidade := PegaValoresDaLinha(ALinha, Pred(AIndiceCampos.CodigoUnidade));
  Result.EmpresaDeFaturamentoItem := PegaValoresDaLinha(ALinha, Pred(AIndiceCampos.EmpresaDeFaturamentoItem));
  Result.NumeroLote := PegaValoresDaLinha(ALinha, Pred(AIndiceCampos.NumeroLote));
  Result.LocalDeRetira := PegaValoresDaLinha(ALinha, Pred(AIndiceCampos.LocalDeRetira));
  Result.EntregaFutura := PegaValoresDaLinha(ALinha, Pred(AIndiceCampos.EntregaFutura));
  Result.MotivoEntregaFutura := PegaValoresDaLinha(ALinha, Pred(AIndiceCampos.MotivoEntregaFutura));
  Result.ClienteBusca := PegaValoresDaLinha(ALinha, Pred(AIndiceCampos.ClienteBusca));
  Result.DiasEntrega := PegaValoresDaLinha(ALinha, Pred(AIndiceCampos.DiasEntrega));
  Result.DataEntrega := PegaValoresDaLinha(ALinha, Pred(AIndiceCampos.DataEntrega));
  Result.Pegou := PegaValoresDaLinha(ALinha, Pred(AIndiceCampos.Pegou));
  Result.Brinde := PegaValoresDaLinha(ALinha, Pred(AIndiceCampos.Brinde));
end;

function TImportaCdsVenda.PegaValoresDaLinha(const ALinha : ILinha; const AIndex : Integer): String;
begin
  Result := EmptyStr;
  If AIndex < 0 Then
    Exit;
  Result := ALinha.Campos[AIndex].Propriedades.Conteudo;
end;

procedure TImportaCdsVenda.InserirItensTemporaria(const ANomeTabela: String; const ALinhasImportadas: TList<ILinha>);
  Var
    LValues : String;
    LCount : Integer;
    LItem : Integer;
    LIdItem : Integer;
    LLinha : ILinha;
    LIndiceCampos : TIndiceCampos;
    LValoresLinha : TValoresLinha;
begin
  LCount := 0;
  LIdItem := 0;
  LValues := EmptyStr;
  FillChar(LIndiceCampos, SizeOf(LIndiceCampos), #0);
  FillChar(LValoresLinha, SizeOf(LValoresLinha), #0);
  For LItem := 0 To Pred(ALinhasImportadas.Count) Do
  Begin
    LLinha :=  ALinhasImportadas[LItem];
    If (LItem = 0) Then
      LIndiceCampos := GetIndiceCampos(LLinha);

    LValoresLinha := PegaValoresDaLinha(LLinha, LIndiceCampos);

    If Not fEmptyStr(LValues) Then
      LValues := LValues + ', ';

    Inc(LIdItem);
    LValues := LValues + '(' + IntToStr(LIdItem) + ',' +
                               QuotedStr(LValoresLinha.CodigoProduto) + ', ' +
                                      LValoresLinha.QuantidadeProduto + ', ' +
                               QuotedStr(LValoresLinha.EntregaRetira) + ', ' +
                                      LValoresLinha.UnitarioDigitado  + ', ' +
                                      LValoresLinha.Unitario          + ', ' +
                                      LValoresLinha.Desconto          + ', ' +
                               QuotedStr(LValoresLinha.TabelaDePrecoItem) + ', ' +
                               QuotedStr(LValoresLinha.Complemento)       + ', ' +
                               QuotedStr(LValoresLinha.CodigoUnidade)     + ', ' +
                               QuotedStr(LValoresLinha.EmpresaDeFaturamentoItem) + ', ' +
                               QuotedStr(LValoresLinha.NumeroLote)        + ', ' +
                               QuotedStr(LValoresLinha.LocalDeRetira)     + ', ' +
                               QuotedStr(LValoresLinha.EntregaFutura)     + ', ' +
                               QuotedStr(LValoresLinha.MotivoEntregaFutura) + ', ' +
                               QuotedStr(LValoresLinha.ClienteBusca)      + ', ' +
                                  IfEmptyNull(LValoresLinha.DiasEntrega)  + ', ' +
                               QuotedStr(LValoresLinha.DataEntrega)       + ', ' +
                               QuotedStr(LValoresLinha.Pegou)             + ', ' +
                               QuotedStr(LValoresLinha.Brinde)            + ')';

    Inc(LCount);
    If (LCount >= 100) Then
    Begin
      If Not fExecutaSQL(SQLInsertTmp(ANomeTabela, LValues), True) Then
        Exit;
      LValues := EmptyStr;
      LCount := 0;
    End;
  End;
  If fEmptyStr(LValues) Then
    Exit;
  fExecutaSQL(SQLInsertTmp(ANomeTabela, LValues), True);
end;

procedure TImportaCdsVenda.LancarItem(const ACodIte: String; const AQtdIte,
  AUnitar, APerDes: Double; const ACdsVenda: TDataSet;
  const AProgressBar: TcxProgressBar;
  const AProcessarPromocao, AProcessarPrecoVendaItens: Boolean);
var
  LQueryVenda   : TUniQuery;
  LValues       : String;
  LIdItem       : Integer;
  LValoresLinha : TValoresLinha;
begin
  ApagarTemporaria(FUltimaTemporariaGerada);
  FUltimaTemporariaGerada := GerarNovaTemporaria;

  LIdItem := 0;
  LValues := EmptyStr;
  FillChar(LValoresLinha, SizeOf(LValoresLinha), #0);

  LValoresLinha.CodigoProduto            := ACodIte;
  LValoresLinha.QuantidadeProduto        := FloatToStr(AQtdIte);
  LValoresLinha.EntregaRetira            := 'R';
  LValoresLinha.UnitarioDigitado         := FloatToStr(AUnitar);
  LValoresLinha.Unitario                 := FloatToStr(AUnitar);
  LValoresLinha.Desconto                 := FloatToStr(APerDes);
  LValoresLinha.TabelaDePrecoItem        := FInput.TabelaPreco;
  LValoresLinha.EmpresaDeFaturamentoItem := FInput.CodigoEmpresa;
  LValoresLinha.ClienteBusca             := FInput.CodigoCliente;

  Inc(LIdItem);
  LValues := LValues + '(' + IntToStr(LIdItem) + ',' +
                             QuotedStr(LValoresLinha.CodigoProduto) + ', ' +
                                    fFloatToSQL(StrToFloat(LValoresLinha.QuantidadeProduto)) + ', ' +
                             QuotedStr(LValoresLinha.EntregaRetira) + ', ' +
                                    fFloatToSQL(fStrToFloat(LValoresLinha.UnitarioDigitado))  + ', ' +
                                    fFloatToSQL(StrToFloat(LValoresLinha.Unitario))          + ', ' +
                                    fFloatToSQL(StrToFloat(LValoresLinha.Desconto))          + ', ' +
                             QuotedStr(LValoresLinha.TabelaDePrecoItem) + ', ' +
                             QuotedStr(LValoresLinha.Complemento)       + ', ' +
                             QuotedStr(LValoresLinha.CodigoUnidade)     + ', ' +
                             QuotedStr(LValoresLinha.EmpresaDeFaturamentoItem) + ', ' +
                             QuotedStr(LValoresLinha.NumeroLote)        + ', ' +
                             QuotedStr(LValoresLinha.LocalDeRetira)     + ', ' +
                             QuotedStr(LValoresLinha.EntregaFutura)     + ', ' +
                             QuotedStr(LValoresLinha.MotivoEntregaFutura) + ', ' +
                             QuotedStr(LValoresLinha.ClienteBusca)      + ', ' +
                                IfEmptyNull(LValoresLinha.DiasEntrega)  + ', ' +
                             QuotedStr(LValoresLinha.DataEntrega)       + ', ' +
                             QuotedStr(LValoresLinha.Pegou)             + ', ' +
                             QuotedStr(LValoresLinha.Brinde)            + ')';

  fExecutaSQL(SQLInsertTmp(FUltimaTemporariaGerada, LValues), True);

  LQueryVenda := fCriaQuery;
  Try
    LQueryVenda.SQL.Text := SQLTemporariaDeVenda(FUltimaTemporariaGerada);
    LQueryVenda.ParamByName('CODEMP').AsString := FInput.CodigoEmpresa;
    LQueryVenda.ParamByName('CODCLI').AsString := FInput.CodigoCliente;
    LQueryVenda.Open;

    If (LQueryVenda.IsEmpty) Then
      Exit;

    CopyData(LQueryVenda, ACdsVenda, AProgressBar);

    If AProcessarPromocao Then
      ProcessarItensPromocionais(AProgressBar, ACdsVenda);

    If AProcessarPrecoVendaItens Then
      ProcessarPrecoDeVendaDosItens(AProgressBar, ACdsVenda);
  Finally
    FreeAndNil(LQueryVenda);
  End;
end;

function TImportaCdsVenda.IfEmptyNull(const AValor : String) : String;
begin
  If fEmptyStr(AValor) Then
    Result := 'NULL'
  Else
    Result := AVAlor;
end;

function TImportaCdsVenda.SQLFieldTabelaPreco: String;
begin
  Result := 'IF(IFNULL(TMP_TABPRE, "") = "", ' + QuotedStr(FInput.TabelaPreco) + ', TMP_TABPRE)';
end;

function TImportaCdsVenda.SQLFieldPrecoDeTabelaEscolhido : String;
begin
  Result := EmptyStr;
  Result := Result + '      IFNULL((CASE ' + SQLFieldTabelaPreco;
  Result := Result + '              WHEN "1" THEN G.ITE_PREVE1 ';
  Result := Result + '              WHEN "2" THEN G.ITE_PREVE2 ';
  Result := Result + '              WHEN "3" THEN G.ITE_PREVE3 ';
  Result := Result + '              WHEN "4" THEN G.ITE_PREVE4 ';
  Result := Result + '              WHEN "5" THEN G.ITE_PREVE5 ';
  Result := Result + '              WHEN "6" THEN G.ITE_PREVE6 ';
  Result := Result + '              WHEN "7" THEN G.ITE_PREVE7 ';
  Result := Result + '           END ), 0) ';
end;

function TImportaCdsVenda.SQLInsertTmp(const ANomeTabela : String; const AValues : String) : String;
begin
  Result := EmptyStr;
  Result := Result + STR_SQL_NAO_REPLICAR;
  Result := Result + ' SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; ';
  Result := Result + ' INSERT INTO ' + ANomeTabela;
  Result := Result + ' ( ';
  Result := Result + '   TMP_IDITEM ';
  Result := Result + '  ,TMP_CODITE ';
  Result := Result + '  ,TMP_QTDITE ';
  Result := Result + '  ,TMP_ENTRET ';
  Result := Result + '  ,TMP_UNIDIG ';
  Result := Result + '  ,TMP_UNITAR ';
  Result := Result + '  ,TMP_DESCON ';
  Result := Result + '  ,TMP_TABPRE ';
  Result := Result + '  ,TMP_COMPLE ';
  Result := Result + '  ,TMP_CODUNI ';
  Result := Result + '  ,TMP_EMPFAT ';
  Result := Result + '  ,TMP_NUMLOT ';
  Result := Result + '  ,TMP_LOCRET ';
  Result := Result + '  ,TMP_ENTFUT ';
  Result := Result + '  ,TMP_MOTFUT ';
  Result := Result + '  ,TMP_CLIBUS ';
  Result := Result + '  ,TMP_QDENTR ';
  Result := Result + '  ,TMP_DTENTR ';
  Result := Result + '  ,TMP_PEGOU_ ';
  Result := Result + '  ,TMP_BRINDE ';
  Result := Result + ' ) ';
  Result := Result + ' VALUES ' + AValues + ' ;';
  Result := Result + DEFAULT_ISOLATION_LEVEL_SQL_INSTRUCTION;
end;

constructor TImportaCdsVenda.Create(const AInput : TInputImporta; const AFncPegaPrecoVenda : TFncPegaPrecoVenda; AFncUniDigDescontada : TFncUniDigDescontada; AFncCalculaPrecosLote : TFncCalculaPrecosLote; AFncEmpresaParaFaturamentoUsaWMS : TFncEmpresaParaFaturamentoUsaWMS);
begin
  FInput := AInput;
  FUltimaTemporariaGerada := EmptyStr;
  FFncPegaPrecoVenda := AFncPegaPrecoVenda;
  FFncUniDigDescontada := AFncUniDigDescontada;
  FFncCalculaPrecosLote := AFncCalculaPrecosLote;
  FFncEmpresaParaFaturamentoUsaWMS := AFncEmpresaParaFaturamentoUsaWMS;
end;

function TImportaCdsVenda.CriarTemporaria(const ANomeTabela: String): Boolean;
  Var
    LSQL : String;
begin
  LSQL := EmptyStr;
  LSQL := LSQL + ' CREATE TABLE ' + ANomeTabela + ' ( ';
  LSQL := LSQL + '   TMP_CODITE VARCHAR(7)         ';
  LSQL := LSQL + '  ,TMP_IDITEM INT ';
  LSQL := LSQL + '  ,TMP_QTDITE DECIMAL(12,4) ';
  LSQL := LSQL + '  ,TMP_ENTRET CHAR(1) ';
  LSQL := LSQL + '  ,TMP_UNIDIG DECIMAL(12,4) ';
  LSQL := LSQL + '  ,TMP_UNITAR DECIMAL(12,4) ';
  LSQL := LSQL + '  ,TMP_DESCON DECIMAL(12,4) ';
  LSQL := LSQL + '  ,TMP_TABPRE CHAR(1) ';
  LSQL := LSQL + '  ,TMP_COMPLE VARCHAR(60) ';
  LSQL := LSQL + '  ,TMP_CODUNI VARCHAR(4) ';
  LSQL := LSQL + '  ,TMP_EMPFAT CHAR(3) ';
  LSQL := LSQL + '  ,TMP_NUMLOT VARCHAR(30) ';
  LSQL := LSQL + '  ,TMP_LOCRET CHAR(2) ';
  LSQL := LSQL + '  ,TMP_MOTFUT CHAR(1) ';
  LSQL := LSQL + '  ,TMP_ENTFUT CHAR(1) ';
  LSQL := LSQL + '  ,TMP_CLIBUS CHAR(1) ';
  LSQL := LSQL + '  ,TMP_QDENTR INT ';
  LSQL := LSQL + '  ,TMP_DTENTR DATE ';
  LSQL := LSQL + '  ,TMP_PEGOU_ CHAR(1) ';
  LSQL := LSQL + '  ,TMP_BRINDE CHAR(1) ';
  LSQL := LSQL + '  ,KEY IDX_' + ANomeTabela + '_01 (TMP_CODITE) ';
  LSQL := LSQL + '  ,KEY IDX_' + ANomeTabela + '_02 (TMP_IDITEM) ';
  LSQL := LSQL + ' ) ENGINE = MEMORY DEFAULT CHARSET=LATIN1 ';
  Result := fExecutaSQL(LSQL, True);
end;

destructor TImportaCdsVenda.Destroy;
begin
  ApagarTemporaria(FUltimaTemporariaGerada);
  inherited;
end;

procedure TImportaCdsVenda.CopyData(const AOrigem: TDataSet; const ADestino: TDataSet; AProgressBar: TcxProgressBar = Nil);
  Var
    LCount : Integer;
    LField : TField;
    LFieldName : String;
    LScrollOrigem: TprcScroll;
    LScrollDestino: TprcScroll;
    LSequence : Integer;
begin
  pInformacao('Carregando registros da Venda.', AProgressBar);
  pDisableControls(AOrigem, LScrollOrigem);
  pDisableControls(ADestino, LScrollDestino);
  Try
    LSequence := FInput.SequenciaAutoincrem;
    AOrigem.First;
    While Not AOrigem.Eof Do
    Begin
      Inc(LSequence);
      Progresso(AOrigem.RecNo, AOrigem.RecordCount, AProgressBar);
      ADestino.Append;
      For LCount := 0 To Pred(AOrigem.Fields.Count) Do
      Begin
        LFieldName := AOrigem.Fields[LCount].FieldName;
        If (LFieldName.IsEmpty) Then
          Continue;
        LField := ADestino.FindField(LFieldName);
        If (LField = Nil) Then
          Continue;
        If (AOrigem.Fields[LCount].IsNull) Then
        Begin
          If (LField.DataType In [ftFloat, ftCurrency, ftBCD]) Then
            LField.AsFloat := 0
          Else If (LField.DataType In [ftInteger]) Then
            LField.AsInteger := 0
          Else If (LField.DataType In [ftDate, ftDateTime, ftTime, ftBlob]) Then
            LField.Value := Null
          Else If (LField.DataType In [ftString, ftMemo]) Then
            LField.AsString := '';
          Continue;
        End;
        LField.Value := AOrigem.Fields[LCount].Value;
      End;
      If Assigned(ADestino.FindField('ITE_ORDITE')) Then
        ADestino.FieldByName('ITE_ORDITE').AsInteger := LSequence;
      AtualizarDataDeEntrega(ADestino);
      AtualizarQuantidadeDiasParaEntrega(ADestino);
      AtualizaSequencialUnicoAutoCenter(ADestino);
      AtualizaLoteADefinir(ADestino);
      ADestino.Post;
      AOrigem.Next;
    End;
  Finally
    pEnableControls(AOrigem, LScrollOrigem);
    pEnableControls(ADestino, LScrollDestino);
  End;
end;

procedure TImportaCdsVenda.ProcessarItensPromocionais(const AProgressBar: TcxProgressBar; const ACdsVenda : TDataSet);
  Var
    LLista : TList<TResultPromo>;
    LCount : Integer;
begin
  pInformacao('Processando itens promocionais.', AProgressBar);
  LLista := ProdutosEmPromocao(AProgressBar);
  Try
    For LCount := 0 To Pred(LLista.Count) Do
    Begin
      Progresso(LCount, LLista.Count, AProgressBar);
      If Not ACdsVenda.Locate('AUTOINCREM', LLista[LCount].IdItem, []) Then
        Continue;
      If (LLista[LCount].Promocao.strPromoc <> 'S') Then
        Continue;
      ACdsVenda.Edit;
      ACdsVenda.FieldByName('ITE_PROMOC').AsString := LLista[LCount].Promocao.strPromoc;
      ACdsVenda.FieldByName('ITE_PROCUS').AsFloat := LLista[LCount].Promocao.fltProCus;
      ACdsVenda.FieldByName('ITE_PROVEN').AsFloat := LLista[LCount].Promocao.fltProVen;
      ACdsVenda.FieldByName('ITE_PROCVA').AsFloat := LLista[LCount].Promocao.fltProCva;
      ACdsVenda.FieldByName('ITE_PROCAT').AsFloat := LLista[LCount].Promocao.fltProCat;
      ACdsVenda.FieldByName('ITE_PROCDI').AsFloat := LLista[LCount].Promocao.fltProCdi;
      ACdsVenda.FieldByName('ITE_COMPRO').AsString := LLista[LCount].Promocao.strComPro;
      ACdsVenda.FieldByName('ITE_CODPRO').AsString := LLista[LCount].Promocao.strCodPro;
      ACdsVenda.FieldByName('ITE_DESF07').AsFloat := LLista[LCount].Promocao.fltDesF07;
      ACdsVenda.FieldByName('ITE_DESPRO').AsString := fRetDescPromocao(LLista[LCount].Promocao.strCodPro);
      ACdsVenda.Post;
    End;
  Finally
    LLista.Clear;
    FreeAndNil(LLista);
  End;
end;

procedure TImportaCdsVenda.ProcessarPrecoDeVendaDosItens(
  const AProgressBar: TcxProgressBar; const ACdsVenda: TDataSet);
  Var
    LPrecoVenda : TPegaPrecoVendaOutput;
    LRecordCount : Integer;
    LPrecoLote : Double;
    LScroll : TprcScroll;
begin
  pInformacao('Processando preço de venda dos itens.', AProgressBar);
  LRecordCount := ACdsVenda.RecordCount;
  pDisableControls(ACdsVenda, LScroll);
  Try
    ACdsVenda.First;
    While Not ACdsVenda.Eof Do
    Begin
      Progresso(ACdsVenda.RecNo, LRecordCount, AProgressBar);
      LPrecoVenda := FFncPegaPrecoVenda(ACdsVenda);
      ACdsVenda.Edit;
      ACdsVenda.FieldByName('ITE_UNIORI').AsFloat := LPrecoVenda.ValorUnitarioOriginal;
      ACdsVenda.FieldByName('ITE_UNIVIS').AsFloat := LPrecoVenda.ValorUnitarioSemJuros;
      ACdsVenda.FieldByName('FLG_STATUS').AsString := LPrecoVenda.StatusDoProduto;

      If (Not fEmptyStr(ACdsVenda.FieldByName('ITE_NUMLOT').AsString)) And (ACdsVenda.FieldByName('ITE_NUMLOT').AsString <> 'A DEFINIR') Then
      Begin
        LPrecoLote := 0;
        If FFncCalculaPrecosLote(ACdsVenda.FieldByName('ITE_CODITE').AsString,
                                 ACdsVenda.FieldByName('ITE_NUMLOT').AsString,
                                 ACdsVenda.FieldByName('ITE_TABPRE').AsString,
                                 ACdsVenda.FieldByName('ITE_EMPITE').AsString,
                                 ACdsVenda.FieldByName('ITE_QTDITE').AsFloat,
                                 LPrecoLote) Then
        Begin
          If (LPrecoLote > 0) Then
          Begin
            ACdsVenda.FieldByName('ITE_PRELOT').AsFloat := LPrecoLote;
            ACdsVenda.FieldByName('ITE_UNIDIG').AsFloat := ACdsVenda.FieldByName('ITE_PRELOT').AsFloat;
            ACdsVenda.FieldByName('ITE_UNITAR').AsFloat := ACdsVenda.FieldByName('ITE_PRELOT').AsFloat;
            ACdsVenda.FieldByName('ITE_DESCON').AsFloat := 0;
            ACdsVenda.FieldByName('ITE_TAXJUR').AsFloat := 0;
          End;
        End;
      End;

      If fDestacarDescontoDaCondicaoPagamentoNoCampoDescontoDosItensEmPromocao Then
      Begin
        ACdsVenda.FieldByName('ITE_PROCND').AsBoolean := False;
        If (ACdsVenda.FieldByName('ITE_PROMOC').AsString = 'S') Then
          ACdsVenda.FieldByName('ITE_PROCND').AsBoolean := IIF(ACdsVenda.FieldByName('ITE_DESCON').AsFloat > 0, True, False);
      End;

      If (ACdsVenda.FieldByName('ITE_UNIDIG').AsFloat > 0) And
         (ACdsVenda.FieldByName('ITE_UNITAR').AsFloat <= 0) Then
      Begin
        ACdsVenda.FieldByName('ITE_UNITAR').AsFloat := FFncUniDigDescontada(ACdsVenda.FieldByName('ITE_UNIDIG').AsFloat,
                                                                            LPrecoVenda.TaxaDeJurosDaCondicao,
                                                                            ACdsVenda.FieldByName('ITE_DESCON').AsFloat,
                                                                            LPrecoVenda.PercentualDescontoCondicaoPagamento,
                                                                            ACdsVenda.FieldByName('ITE_PROMOC').AsString);
      End;

      If (ACdsVenda.FieldByName('ITE_UNITAR').AsFloat > 0) And
         (ACdsVenda.FieldByName('ITE_UNIDIG').AsFloat <= 0) Then
      Begin
        If (fCfgSis('DESCND', varString) = 'S') And (ACdsVenda.FieldByName('ITE_PROMOC').AsString <> 'S') Then
          ACdsVenda.FieldByName('ITE_UNIDIG').AsFloat := ACdsVenda.FieldByName('ITE_UNIORI').AsFloat
        Else If (fCfgSis('DESCND', varString) = 'N') Or (ACdsVenda.FieldByName('ITE_PROMOC').AsString = 'S') Then
          ACdsVenda.FieldByName('ITE_UNIDIG').AsFloat := ACdsVenda.FieldByName('ITE_UNITAR').AsFloat;
      End;

      If (ACdsVenda.FieldByName('ITE_UNIDIG').AsFloat <= 0) Then
        ACdsVenda.FieldByName('ITE_UNIDIG').AsFloat := LPrecoVenda.ValorUnitario;

      If (ACdsVenda.FieldByName('ITE_UNITAR').AsFloat <= 0) Then
        ACdsVenda.FieldByName('ITE_UNITAR').AsFloat := LPrecoVenda.ValorUnitarioLiquido;

      If (ACdsVenda.FieldByName('ITE_PRETAB').AsFloat > 0) Then
        ACdsVenda.FieldByName('ITE_VARTAB').AsFloat := ((ACdsVenda.FieldByName('ITE_UNITAR').AsFloat / ACdsVenda.FieldByName('ITE_PRETAB').AsFloat) - 1) * 100
      Else
        ACdsVenda.FieldByName('ITE_VARTAB').AsFloat := 0;
      ACdsVenda.FieldByName('ITE_UNILOD').AsFloat := ACdsVenda.FieldByName('ITE_UNITAR').AsFloat;
      If (LPrecoVenda.ValorCotacaoDolarVenda > 0) And (ACdsVenda.FieldByName('ITE_UTILIZA_PRECO_EM_DOLAR_MARGEM').AsBoolean) Then
        ACdsVenda.FieldByName('ITE_UNIDOL').AsFloat := ACdsVenda.FieldByName('ITE_UNITAR').AsFloat / LPrecoVenda.ValorCotacaoDolarVenda;

      If (LPrecoVenda.ItemEmbalagemFechada) Then
      Begin
        ACdsVenda.FieldByName('ITE_EHEMBA').AsBoolean := True;
        ACdsVenda.FieldByName('ITE_PEREMB').AsFloat := LPrecoVenda.PercentualDescontoEmbalagemFechada;
        If (fFormataFloat(ACdsVenda.FieldByName('ITE_UNIORI').AsFloat, fCfgSis('DECUNI', varInteger)) <> fFormataFloat(ACdsVenda.FieldByName('ITE_UNIDIG').AsFloat, fCfgSis('DECUNI', varInteger))) Then
          ACdsVenda.FieldByName('ITE_VLPEMB').AsFloat := fFormataFloat((ACdsVenda.FieldByName('ITE_UNIORI').AsFloat - (ACdsVenda.FieldByName('ITE_UNIORI').AsFloat * ACdsVenda.FieldByName('ITE_PEREMB').AsFloat / 100)), fCfgSis('DECUNI', varInteger))
        Else
          ACdsVenda.FieldByName('ITE_VLPEMB').AsFloat := ACdsVenda.FieldByName('ITE_UNIORI').AsFloat;
        ACdsVenda.FieldByName('ITE_PEREMB').AsFloat := fFormataFloat(((1 - (ACdsVenda.FieldByName('ITE_UNITAR').AsFloat / ACdsVenda.FieldByName('ITE_VLPEMB').AsFloat)) * 100), fCfgSis('DECUNI', varInteger));
        ACdsVenda.FieldByName('ITE_VLBEMB').AsFloat := fFormataFloat((ACdsVenda.FieldByName('ITE_QTDITE').AsFloat * ACdsVenda.FieldByName('ITE_VLPEMB').AsFloat), fCfgSis('DECUNI', varInteger));
      End;

      ACdsVenda.Post;
      ACdsVenda.Next;
    End;
  Finally
    pEnableControls(ACdsVenda, LScroll);
  End;
end;

procedure TImportaCdsVenda.Progresso(const AProgress: Integer; const AMax: Integer; const AProgressBar: TcxProgressBar);
begin
  If (Not Assigned(AProgressBar)) Then
    Exit;
  AProgressBar.Visible  := (AProgress + AMax) > 0;
  AProgressBar.Position := AProgress;
  AProgressBar.Properties.Max := AMax;
  pProcessMessages;
end;

procedure TImportaCdsVenda.ApagarTemporaria(const ANomeTemporaria: String);
begin
  Try
    If ANomeTemporaria.IsEmpty Then
      Exit;
    If Not fTabelaExiste(ANomeTemporaria) Then
      Exit;
    fDropTable(ANomeTemporaria);
  Except
  End;
end;

function TImportaCdsVenda.CarregarItensQuePodemEstarNaPromocao : TUniQuery;
begin
  Result := fCriaQuery;
  Result.Close;
  Result.SQL.Clear;
  Result.SQL.Add(' SELECT DISTINCT TMP_CODITE, TMP_QTDITE, TMP_TABPRE, TMP_ENTRET, TMP_ENTFUT, TMP_MOTFUT, TMP_IDITEM ');
  Result.SQL.Add('   FROM CADPRO ');
  Result.SQL.Add('   JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ');
  Result.SQL.Add('   JOIN PROEMP ON CADPRO.AUTOINCREM = PROEMP.PRO_SEQGER ');
  Result.SQL.Add('   JOIN ' + FUltimaTemporariaGerada + ' ON IPR_CODITE = TMP_CODITE ');
  Result.SQL.Add('  WHERE CURRENT_DATE BETWEEN CADPRO.PRO_DTAINI AND CADPRO.PRO_DTAFIN ');
  Result.SQL.Add('    AND PROEMP.PRO_CODEMP = :CODEMP ');
  Result.ParamByName('CODEMP').AsString := FInput.CodigoEmpresa;
  Result.Open;
end;

function TImportaCdsVenda.ProdutosEmPromocao(AProgressBar : TcxProgressBar) : TList<TResultPromo>;
  Var
    LItens : TUniQuery;
    LInput : TInformacoesPromocaoProdutoInput;
    LOutput : TInformacoesPromocaoProdutoOutput;
    LPromocao : TInformacoesPromocaoProduto;
    LJaDigitados : TList<TJaDigitado>;
    LProdutoDigitado : TJaDigitado;
    LQtdJaDig : Double;
    LQtdJaEmPromoc : Double;
    LResultPromocao : TResultPromo;
begin
  Result := TList<TResultPromo>.Create;
  LPromocao := TInformacoesPromocaoProduto.Create;
  LJaDigitados := TList<TJaDigitado>.Create;
  Try
    LItens := CarregarItensQuePodemEstarNaPromocao;
    LItens.First;
    While Not LItens.Eof Do
    Begin
      Progresso(LItens.RecNo, LItens.RecordCount, AProgressBar);
      TotalizarDigitados(LItens.FieldByName('TMP_CODITE').AsString, LJaDigitados, LQtdJaDig, LQtdJaEmPromoc);

      FillChar(LInput, SizeOf(LInput), #0);
      LInput.strCodIte := LItens.FieldByName('TMP_CODITE').AsString;
      LInput.strCodCli := FInput.CodigoCliente;
      LInput.strCodCnd := FInput.CodigoCondicao;
      LInput.strTabPre := IIF(fEmptyStr(LItens.FieldByName('TMP_TABPRE').AsString), FInput.TabelaPreco, LItens.FieldByName('TMP_TABPRE').AsString);
      LInput.fltQtdIte := LItens.FieldByName('TMP_QTDITE').AsFloat;
      LInput.intPrzMed := FInput.PrazoDePagamento;
      LInput.strEntRet := LItens.FieldByName('TMP_ENTRET').AsString;
      LInput.strEntFut := LItens.FieldByName('TMP_ENTFUT').AsString;
      LInput.strMotFut := LItens.FieldByName('TMP_MOTFUT').AsString;
      LInput.fltQtdJaDig := LQtdJaDig;
      LInput.fltQtdJaEmPromoc := LQtdJaEmPromoc;
      LOutput := LPromocao.fGetInformacoesDoProdutoEmPromocao(LInput);
      If (LOutput.strPromoc = 'S') Then
      Begin
        FillChar(LResultPromocao, SizeOf(LResultPromocao), #0);
        LResultPromocao.IdItem := LItens.FieldByName('TMP_IDITEM').AsInteger;
        LResultPromocao.Promocao := LOutput;
        Result.Add(LResultPromocao);
      End;
      FillChar(LProdutoDigitado, SizeOf(LProdutoDigitado), #0);
      LProdutoDigitado.Codigo := LItens.FieldByName('TMP_CODITE').AsString;
      LProdutoDigitado.Quantidade := LItens.FieldByName('TMP_QTDITE').AsFloat;
      LProdutoDigitado.Promocao := LOutput.strPromoc;
      LJaDigitados.Add(LProdutoDigitado);
      LItens.Next;
    End;
  Finally
    FreeAndNil(LPromocao);
    FreeAndNil(LJaDigitados);
  End;
end;

procedure TImportaCdsVenda.TotalizarDigitados(const ACodigoProduto : String; const ALista : TList<TJaDigitado>; var AQtdJaDig, AQtdJaEmPromoc : Double);
  Var
    LJaDigitado : TJaDigitado;
begin
  AQtdJaDig := 0;
  AQtdJaEmPromoc := 0;
  For LJaDigitado In ALista Do
  Begin
    If LJaDigitado.Codigo <> ACodigoProduto Then
      Continue;
    AQtdJaDig := AQtdJaDig + 1;
    If (LJaDigitado.Promocao = 'S') Then
      AQtdJaEmPromoc := AQtdJaEmPromoc + 1;
  End;
end;

procedure TImportaCdsVenda.AtualizarDataDeEntrega(const ADataSet : TDataSet);
begin
  If (Not ADataSet.FieldByName('ITE_DTENTR').IsNull) Then
    Exit;
  If (ADataSet.FieldByName('ITE_ENTRET').AsString = 'E') Or
     ((ADataSet.FieldByName('ITE_ENTFUT').AsString = 'S') And (Pos(ADataSet.FieldByName('ITE_MOTFUT').AsString, '_P_F_') > 0)) Then
  Begin
    ADataSet.FieldByName('ITE_DTENTR').AsDateTime := VS_Date;
  End;
end;

procedure TImportaCdsVenda.AtualizarQuantidadeDiasParaEntrega(const ADataSet : TDataSet);
begin
  If (ADataSet.FieldByName('ITE_ENTRET').AsString = 'E') Or
     ((ADataSet.FieldByName('ITE_ENTFUT').AsString = 'S') And (Pos(ADataSet.FieldByName('ITE_MOTFUT').AsString, '_P_F_') > 0)) Then
  Begin
    ADataSet.FieldByName('ITE_QDENTR').AsInteger := DaysBetween(VS_Date, ADataSet.FieldByName('ITE_DTENTR').AsDateTime);
  End;
  If (ADataSet.FieldByName('ITE_QDENTR').AsInteger < 0) Then
    ADataSet.FieldByName('ITE_QDENTR').AsInteger := 0;
end;

procedure TImportaCdsVenda.AtualizaSequencialUnicoAutoCenter(const ADataSet : TDataSet);
begin
  If (fCfgSis('AUTCEN', varString) = 'N') Then
    Exit;
  ADataSet.FieldByName('ITE_SEQINC').AsInteger := fRetornaSequencialUnico('SINCPD');
end;

procedure TImportaCdsVenda.AtualizaLoteADefinir(const ADataSet : TDataSet);
begin
  If (Not fEmptyStr(ADataSet.FieldByName('ITE_NUMLOT').AsString)) Then
    Exit;
  If (Not FFncEmpresaParaFaturamentoUsaWMS(ADataSet.FieldByName('ITE_EMPITE').AsString)) Then
    Exit;
  ADataSet.FieldByName('ITE_NUMLOT').AsString := 'A DEFINIR';
end;

end.
