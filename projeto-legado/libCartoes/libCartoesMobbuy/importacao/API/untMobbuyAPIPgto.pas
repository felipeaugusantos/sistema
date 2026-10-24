unit untMobbuyAPIPgto;

interface
uses System.Classes, System.StrUtils, System.SysUtils, System.Variants,
     Vcl.ComCtrls, Vcl.Dialogs, Vcl.Forms, System.Generics.Collections,
     System.Json,

     cxProgressBar, Uni,

     untIMobbuyIntegracaoLibCartoes, untMobbuyTipos, untTMobbuyFuncoes,
     untTConsultaPagamentoDiarioMobbuyOnline;

type
  TEstruturaPgto = record
    strDescri: string;
    strTipCmp: string;
  end;

  TArrEstruturaMobbuyAPIPgto = array of TEstruturaPgto;

  TMobbuyAPIPgto = Class(TInterfacedObject, ICartoes)
  Private
    FMobbuyRegistrosPgto: TObjectList<TMobbuyRegistroPgto>;
    FMobbuyRegistrosVenda: TObjectList<TMobbuyRegistroVenda>;
    FMobbuyRegistrosVendaParcelada: TObjectList<TMobbuyRegistroParcela>;
    FMobbuyRegistrosAjuste: TObjectList<TMobbuyRegistroAjuste>;

    FMobbuyRegistrosVendaAnalitica: TObjectList<TVendaAnalitica>;

    FImportouRegistro,
    FImportouPagamento,
    FImportouVendas: Boolean;

    FTipoDoArquivo : string;
    FEstabelecimentoAtual: string;

    FListaDatasVendas: TStringList;

    function CorrigeDadosBanco(AValor: Variant;
                               ACampoData: Boolean = False): Variant;
    function CorrigeDataBanco(const AData: String): Variant;
    procedure CompletaChavePagamento(const ARegistro: TMobbuyRegistroPgto; const ASequencia: Integer);

    function RetornaValorJson(AObjeto: TJsonObject; ANomeCampo: String; ATipoRetorno: TVarType = varString): Variant;

    procedure ImportaPagamentos(strString: string; AProgress: TcxProgressBar);
    procedure GravaRegistrosTabelaPgto(var AProgress: TcxProgressBar);

    procedure ImportaVendasAnalitica(AString: string; AProgress: TcxProgressBar);
    procedure GravaRegistrosTabelaVendaAnalitica(var AProgress: TcxProgressBar);

    procedure GravaRegistrosTabelaVenda(var AProgress: TcxProgressBar);
    procedure GravaRegistrosTabelaParcela(var AProgress: TcxProgressBar);
    procedure GravaRegistrosTabelaAjuste(var AProgress: TcxProgressBar);

    function  Ocorrencias(TextoProcurado: string; Texto: string): integer;
    function  LocalizaBanco(const Nome: string): string;
    function  TipoReg(ATipo, ACessao : string) : string;

    procedure AtualizarCartao(var AProgress: TcxProgressBar);

  Public
    constructor Create;
    destructor Destroy; override;

    procedure pAdicionaLinha(strString: String; pgbProg: TcxProgressBar);
    procedure pGravarRegistros(pgbProg: TcxProgressBar);
    procedure LimparRegistros;

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaMobbuyAPIPgto;

    property ImportouRegistro         : Boolean read FImportouRegistro;
    property ImportouPagamento        : Boolean read FImportouPagamento;
    property ImportouVendas           : Boolean read FImportouVendas;

    property TipoDoArquivo            : String read FTipoDoArquivo write FTipoDoArquivo;
    property EstabelecimentoAtual: String read FEstabelecimentoAtual write FEstabelecimentoAtual;

    property ListaDatasVendas: TStringList read FListaDatasVendas;
  End;

Const
  NOMTAB = 'MOB_APPGTO';
  INICAM = 'MOB_';

implementation

{ TMobbuyAPIPgto }

procedure TMobbuyAPIPgto.AtualizarCartao(var AProgress: TcxProgressBar);
var
   LSQL : String;
   LQuery : TUniQuery;
begin
  LQuery := Nil;
  try
    LQuery := VS_FuncoesExternas.fICriaQuery;
    if Assigned(AProgress) then
    begin
      AProgress.Position := 0;
      AProgress.Properties.Max := 1;
    end;

    LSQL :=
      'UPDATE MOB_APVEND T '+
      'JOIN MOB_APVEND S '+
      '  ON S.MOB_NUM_PV = T.MOB_NUM_PV '+
      ' AND TRIM(LEADING 0 FROM S.MOB_CODAUT) = TRIM(LEADING 0 FROM T.MOB_CODAUT) '+
      ' AND S.MOB_TIPOPE = ''CV'' '+
      ' AND S.MOB_NUMCAR IS NOT NULL AND S.MOB_NUMCAR <> '''' '+
      'SET T.MOB_NUMCAR = S.MOB_NUMCAR '+
      'WHERE (T.MOB_NUMCAR IS NULL OR T.MOB_NUMCAR = '''') '+
      '  AND T.MOB_TIPOPE IN (''CC'');';

    LQuery.Sql.Text := LSQL;
    LQuery.ExecSQL;

    if Assigned(AProgress) then
    begin
      AProgress.Position := 1;
      AProgress.Position := 0;
    end;

  finally
    TMobbuyFuncoes.FreeAndNilDatasets(LQuery);
  end;
end;



function TMobbuyAPIPgto.CorrigeDadosBanco(AValor: Variant;
                                            ACampoData: Boolean = False): Variant;
begin
  Result := Null;
  If Not TMobbuyFuncoes.fEmptyStr(AValor) Then
  Begin
    Result := AValor;

    If ACampoData Then
      Result := LeftStr(Result, 4) + '-' +
                Copy(Result, 5, 2) + '-' +
                RightStr(Result, 2);

  End;
end;

procedure TMobbuyAPIPgto.CompletaChavePagamento(const ARegistro: TMobbuyRegistroPgto; const ASequencia: Integer);
begin
  If ARegistro.Autorizacao.Trim.IsEmpty Then
    ARegistro.Autorizacao := '0';

  If ARegistro.NumNSU.Trim.TrimLeft(['0']).IsEmpty And ARegistro.Autorizacao.Trim.TrimLeft(['0']).IsEmpty Then
    ARegistro.NumNSU := ASequencia.ToString
  Else If ARegistro.NumNSU.Trim.IsEmpty Then
    ARegistro.NumNSU := '0';

  If ARegistro.DataVenda.Trim.IsEmpty Or StartsStr('0000', ARegistro.DataVenda) Then
    ARegistro.DataVenda := ARegistro.DataPagamento;
end;

function TMobbuyAPIPgto.CorrigeDataBanco(const AData: String): Variant;
begin
  If StartsStr('0000', AData) Then
    Exit(Null);

  Result := CorrigeDadosBanco(AData);
end;

constructor TMobbuyAPIPgto.Create;
begin
  FImportouRegistro         := False;
  FImportouPagamento        := False;
  FImportouVendas           := False;
  FTipoDoArquivo := '';

  FMobbuyRegistrosPgto           := TObjectList<TMobbuyRegistroPgto>.Create;
  FMobbuyRegistrosVenda          := TObjectList<TMobbuyRegistroVenda>.Create;
  FMobbuyRegistrosVendaParcelada := TObjectList<TMobbuyRegistroParcela>.Create;
  FMobbuyRegistrosAjuste         := TObjectList<TMobbuyRegistroAjuste>.Create;

  FMobbuyRegistrosVendaAnalitica := TObjectList<TVendaAnalitica>.Create;

  FListaDatasVendas := TStringList.Create;
  FListaDatasVendas.Duplicates := dupIgnore;
  FListaDatasVendas.Sorted := True;
end;

destructor TMobbuyAPIPgto.Destroy;
begin
  If Assigned(FMobbuyRegistrosPgto) Then
    FreeAndNil(FMobbuyRegistrosPgto);

  If Assigned(FMobbuyRegistrosVenda) Then
    FreeAndNil(FMobbuyRegistrosVenda);

  If Assigned(FMobbuyRegistrosVendaParcelada) Then
    FreeAndNil(FMobbuyRegistrosVendaParcelada);

  If Assigned(FMobbuyRegistrosAjuste) Then
    FreeAndNil(FMobbuyRegistrosAjuste);

  If Assigned(FListaDatasVendas) Then
    FreeAndNil(FListaDatasVendas);

  If Assigned(FMobbuyRegistrosVendaAnalitica) Then
    FreeAndNil(FMobbuyRegistrosVendaAnalitica);

  inherited;
end;


class function TMobbuyAPIPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaMobbuyAPIPgto;
begin
  If strTabela = 'MOB_APPGTO' Then
  Begin
    SetLength(Result, 26);

    Result[0].strDescri  := INICAM + 'CODAUT' ;  Result[0].strTipCmp  := 'VARCHAR(12)';
    Result[1].strDescri  := INICAM + 'NUMNSU' ;  Result[1].strTipCmp  := 'VARCHAR(15)'  ;
    Result[2].strDescri  := INICAM + 'NUM_PV' ;  Result[2].strTipCmp  := 'VARCHAR(14) NOT NULL'   ;
    Result[3].strDescri  := INICAM + 'DTAPAG' ;  Result[3].strTipCmp  := 'DATE'         ;
    Result[4].strDescri  := INICAM + 'TIPREG' ;  Result[4].strTipCmp  := 'VARCHAR(3)'   ;
    Result[5].strDescri  := INICAM + 'LANCAM' ;  Result[5].strTipCmp  := 'VARCHAR(40)'   ;
    Result[6].strDescri  := INICAM + 'TIPORI' ;  Result[6].strTipCmp  := 'VARCHAR(50)'  ;
    Result[7].strDescri  := INICAM + 'DTTRAN' ;  Result[7].strTipCmp  := 'DATE'         ;
    Result[8].strDescri  := INICAM + 'DTVEND' ;  Result[8].strTipCmp  := 'DATE NOT NULL';
    Result[9].strDescri  := INICAM + 'DTAIMP' ;  Result[9].strTipCmp  := 'DATE'         ;
    Result[10].strDescri := INICAM + 'DESBAN' ;  Result[10].strTipCmp := 'VARCHAR(15)'   ;
    Result[11].strDescri := INICAM + 'VALBRU' ;  Result[11].strTipCmp := 'DECIMAL(15,2)';
    Result[12].strDescri := INICAM + 'VALDES' ;  Result[12].strTipCmp := 'DECIMAL(15,2)';
    Result[13].strDescri := INICAM + 'VALLIQ' ;  Result[13].strTipCmp := 'DECIMAL(15,2)';
    Result[14].strDescri := INICAM + 'CONCIL' ;  Result[14].strTipCmp := 'INT DEFAULT 0';
    Result[15].strDescri := INICAM + 'STATUS' ;  Result[15].strTipCmp := 'VARCHAR(40)';
    Result[16].strDescri := INICAM + 'PARCEL' ;  Result[16].strTipCmp := 'VARCHAR(5)';
    Result[17].strDescri := INICAM + 'CHAVES' ;  Result[17].strTipCmp := 'VARCHAR(40)';
    Result[18].strDescri := INICAM + 'NOMCED' ;  Result[18].strTipCmp := 'VARCHAR(255) DEFAULT NULL';
    Result[19].strDescri := INICAM + 'CODBCO' ;  Result[19].strTipCmp := 'CHAR(3) NOT NULL';
    Result[20].strDescri := INICAM + 'NUMCON' ;  Result[20].strTipCmp := 'VARCHAR(50) NOT NULL ';
    Result[21].strDescri := INICAM + 'CODAGE' ;  Result[21].strTipCmp := 'VARCHAR(50) DEFAULT NULL';
    Result[22].strDescri := INICAM + 'DIGCON' ;  Result[22].strTipCmp := 'VARCHAR(3) DEFAULT NULL';
    Result[23].strDescri := INICAM + 'TOTPAR' ;  Result[23].strTipCmp := 'VARCHAR(3)';
    Result[24].strDescri := INICAM + 'CES_ID' ;  Result[24].strTipCmp := 'VARCHAR(30) NOT NULL ';
    Result[25].strDescri := INICAM + 'CES_NF' ;  Result[25].strTipCmp := 'VARCHAR(30)';
  End
  else
  if strTabela = 'MOB_APVEND' then
  begin
      SetLength(Result, 31);

      Result[0].strDescri  := INICAM + 'TIPREG'   ; Result[0].strTipCmp := 'VARCHAR(3) NOT NULL';   // Produto: C/D  (MovTrnTipPrd) - Produto	C crédito, D débito
      Result[1].strDescri  := INICAM + 'NUM_PV'   ; Result[1].strTipCmp := 'VARCHAR(14) NOT NULL';  // EstCpfCnpj	CNPJ do estabelecimento	MOB_NUM_PV (chave de conciliação).
      Result[2].strDescri  := INICAM + 'MOV_ID'   ; Result[2].strTipCmp := 'VARCHAR(15) NOT NULL';  // MovTrnID	ID interno da transação	Use como chave técnica (ex.: MOB_NUM_RV quando você não tem um RV “oficial”).
      Result[3].strDescri  := INICAM + 'DTVEND'   ; Result[3].strTipCmp := 'DATE NOT NULL';         // CharMovTrnDta (data da venda)
      Result[4].strDescri  := INICAM + 'DTTRAN'   ; Result[4].strTipCmp := 'DATE';                   // data importação / inclusão
      Result[5].strDescri  := INICAM + 'DTAIMP'   ; Result[5].strTipCmp := 'DATE';                  // (opcional) data da transação (espelho/auditoria)
      Result[6].strDescri  := INICAM + 'NUMNSU'   ; Result[6].strTipCmp := 'VARCHAR(15) NOT NULL';  // MovTrnNsu
      Result[7].strDescri  := INICAM + 'CODAUT'   ; Result[7].strTipCmp := 'VARCHAR(12) NOT NULL';  // MovTrnAutCodStr
      Result[8].strDescri  := INICAM + 'TOTPAR'   ; Result[8].strTipCmp := 'VARCHAR(3)';            // MovTrnParQtd
      Result[9].strDescri  := INICAM + 'TIPOPE'   ; Result[9].strTipCmp := 'VARCHAR(3) NOT NULL';   // MovTrnCod (CV/CC/AJ)
      Result[10].strDescri := INICAM + 'CODMOT'   ; Result[10].strTipCmp:= 'VARCHAR(3)';            // AdqAjtMotCod  - 0 = sem ajuste. Se diferente 0, a venda sofreu algum ajuste/estorno
      Result[11].strDescri := INICAM + 'NUMCAR'   ; Result[11].strTipCmp:= 'VARCHAR(22)';           // MovTrnNumCar (mascarado)
      Result[12].strDescri := INICAM + 'VALLIQ'   ; Result[12].strTipCmp:= 'DECIMAL(15,2)';         // MovTrnVlrLiqEst
      Result[13].strDescri := INICAM + 'VBRUTO'   ; Result[13].strTipCmp:= 'DECIMAL(15,2)';         // MovTrnVlr
      Result[14].strDescri := INICAM + 'VALDES'   ; Result[14].strTipCmp:= 'DECIMAL(15,2)';         // MovTrnVlrDesVen (lado adq.)
      Result[15].strDescri := INICAM + 'CODBAN'   ; Result[15].strTipCmp:= 'CHAR(1)';               // MovTrnBan - bandeira (V/M/E/…)
      Result[16].strDescri := INICAM + 'BANDES'   ; Result[16].strTipCmp:= 'VARCHAR(40)';           // (se quiser a descrição)
      Result[17].strDescri := INICAM + 'GBPTAD'   ; Result[17].strTipCmp:= 'DECIMAL(15,2)';         // MovTrnGbpVlrTxaAdm   -ADMINISTRATIVA
      Result[18].strDescri := INICAM + 'GBPTIN'   ; Result[18].strTipCmp:= 'DECIMAL(15,2)';         // MovTrnGbpVlrTxaInt   -juros/intercâmbio
      Result[19].strDescri := INICAM + 'GBPTAN'   ; Result[19].strTipCmp:= 'DECIMAL(15,2)';         // MovTrnGbpVlrTxaAnt   -ANTECIPACAO
      Result[20].strDescri := INICAM + 'PACCOD'   ; Result[20].strTipCmp:= 'INT';                   // MovTrnPacCod
      Result[21].strDescri := INICAM + 'PACNOM'   ; Result[21].strTipCmp:= 'VARCHAR(106)';          // MovTrnPacNom
      Result[22].strDescri := INICAM + 'BFACCA'   ; Result[22].strTipCmp:= 'DECIMAL(15,2)';         // MovTrnBfaVlrCusCap
      Result[23].strDescri := INICAM + 'BFATAD'   ; Result[23].strTipCmp:= 'DECIMAL(15,2)';         // MovTrnBfaVlrTxaAdm
      Result[24].strDescri := INICAM + 'BFATFI'   ; Result[24].strTipCmp:= 'DECIMAL(15,2)';         // MovTrnBfaVlrTxaFin
      Result[25].strDescri := INICAM + 'BFACTR'   ; Result[25].strTipCmp:= 'DECIMAL(15,2)';         // MovTrnBfaVlrCusTrn
      Result[26].strDescri := INICAM + 'BFATCR'   ; Result[26].strTipCmp:= 'DECIMAL(15,2)';         // MovTrnBfaVlrTarCre
      Result[27].strDescri := INICAM + 'BFATAN'   ; Result[27].strTipCmp:= 'DECIMAL(15,2)';         // MovTrnBfaVlrTxaAnt
      Result[28].strDescri := INICAM + 'BFALIQ'   ; Result[28].strTipCmp:= 'DECIMAL(15,2)';         // MovTrnVlrLiqBemFac
      Result[29].strDescri := INICAM + 'POSNUM'   ; Result[29].strTipCmp:= 'VARCHAR(20)';           // MovTrnPosNum
      Result[30].strDescri := INICAM + 'POSSER'   ; Result[30].strTipCmp:= 'VARCHAR(32)';           // MovTrnPosNumSer
  end
  else
  if strTabela = 'MOB_APVPAR' then
  begin
    SetLength(Result, 25);

    Result[0].strDescri  := INICAM + 'NUM_PV' ;   Result[0].strTipCmp  := 'VARCHAR(14) NOT NULL';
    Result[1].strDescri  := INICAM + 'NUMNSU' ;   Result[1].strTipCmp  := 'VARCHAR(15) NOT NULL';
    Result[2].strDescri  := INICAM + 'CODAUT' ;   Result[2].strTipCmp  := 'VARCHAR(12)';
    Result[3].strDescri  := INICAM + 'MOV_ID' ;   Result[3].strTipCmp  := 'VARCHAR(15) NOT NULL';                   //VlpNumLan	ID da parcela (lançamento)	Ótimo como chave técnica em MOB_APVPAR.MOB_MOV_ID.
    Result[4].strDescri  := INICAM + 'DTTRAN' ;   Result[4].strTipCmp  := 'DATE';              // "VlpArbLotNum": 0,
    Result[5].strDescri  := INICAM + 'DTVEND' ;   Result[5].strTipCmp  := 'DATE NOT NULL';
    Result[6].strDescri  := INICAM + 'DTAVCT' ;   Result[6].strTipCmp  := 'DATE';             //VlpDtaVct	Vencimento/recebimento previsto	YYYYMMDD  MOB_DTAVCT (Data prevista de recebimento).
    Result[7].strDescri  := INICAM + 'DTALIQ' ;   Result[7].strTipCmp  := 'DATE';              //VlpDtaLiq	Data da liquidação (quando paga)	Pode vir vazio; quando preenchida, a parcela foi paga/antecipada. MOB_DTALIQ.
    Result[8].strDescri  := INICAM + 'NUMPAR' ;   Result[8].strTipCmp  := 'VARCHAR(3) NOT NULL';      //VlpNumPar	Número da parcela	MOB_NUMPAR.
    Result[9].strDescri  := INICAM + 'TOTPAR' ;   Result[9].strTipCmp  := 'VARCHAR(3)';               ////VlpNumTotPar	Total de parcelas	MOB_TOTPAR (ou derive do cabeçalho).
    Result[10].strDescri := INICAM + 'STATUS' ;   Result[10].strTipCmp := 'VARCHAR(12)';            //VlpStspag	Status numérico da parcela    1= Agendada (sem liquidação ainda)  2 =  Liquidada(Geralmente VlpDtaLiq vem preenchida.) 3 = Antecipad
    Result[11].strDescri := INICAM + 'PARBRU' ;   Result[11].strTipCmp := 'DECIMAL(15,2)';            //VlpVlrParBru	Valor bruto da parcela	MOB_PARBRU.
    Result[12].strDescri := INICAM + 'PAGLIQ' ;   Result[12].strTipCmp := 'DECIMAL(15,2)';            //VlpVlrPagLiq	Valor pago líquido	MOB_PAGLIQ (0 até pagar).
    Result[13].strDescri := INICAM + 'PAGAME' ;   Result[13].strTipCmp := 'DECIMAL(15,2)';           //VlpVlrPag	Valor a pagar (previsto)	MOB_PAG.
    Result[14].strDescri := INICAM + 'TX_ADM' ;   Result[14].strTipCmp := 'DECIMAL(15,2)';           //VlpVlrTaxAdm	Taxa adm. da parcela	MOB_TXADM.
    Result[15].strDescri := INICAM + 'CSTPLN' ;   Result[15].strTipCmp := 'DECIMAL(15,2)';           //VlpVlrCstTrnPln / Est	Custos do plano/estabelecimento	MOB_CSTPLN / MOB_CSTEST.
    Result[16].strDescri := INICAM + 'CSTEST' ;   Result[16].strTipCmp := 'DECIMAL(15,2)';           //VlpVlrCstTrnEst
    Result[17].strDescri := INICAM + 'TX_FIN' ;   Result[17].strTipCmp := 'DECIMAL(15,2)';          //VlpVlrTaxFinBF / VlpVlrTarCreBF	Taxas BFA (financeira/tarifa crédito)	Se você persiste taxas “lado sub”.
    Result[18].strDescri := INICAM + 'ARBLOT' ;   Result[18].strTipCmp := 'INT';                    //VlpArbNum / VlpArbLotNum / VlpArbDetSeq	Referências de arquivo/lote de pagamento	Úteis para rastrear pagamentos da adquirente.
    Result[19].strDescri := INICAM + 'ANPDES' ;   Result[19].strTipCmp := 'VARCHAR(18)';           // VlpAnpTipDsc	Dados de antecipação (nº/descrição)	Preenchidos quando houve antecipação.
    Result[20].strDescri := INICAM + 'ANPNUM' ;   Result[20].strTipCmp := 'VARCHAR(18)';            // VlpAnpNum
    Result[21].strDescri := INICAM + 'TARCRE' ;   Result[21].strTipCmp := 'DECIMAL(15,2)';          // "VlpVlrTarCreBF": "0.00",
    Result[22].strDescri := INICAM + 'ARBSEQ' ;   Result[22].strTipCmp := 'INT';                    //"VlpArbDetSeq": 0,
    Result[23].strDescri := INICAM + 'ARLOT2' ;   Result[23].strTipCmp := 'INT';
    Result[24].strDescri := INICAM + 'CONCIL' ;   Result[24].strTipCmp := 'INT DEFAULT 0';
  end
  else
  if strTabela = 'MOB_APAJUS' then
  begin
    SetLength(Result, 18);

    Result[0].strDescri  := INICAM + 'TIPREG' ; Result[0].strTipCmp  := 'VARCHAR(40) NOT NULL'; // CRE/DEB
    Result[1].strDescri  := INICAM + 'NUM_PV' ; Result[1].strTipCmp  := 'VARCHAR(14) NOT NULL';
    Result[2].strDescri  := INICAM + 'DTAPAG' ; Result[2].strTipCmp  := 'DATE';
    Result[3].strDescri  := INICAM + 'TIPORI' ; Result[3].strTipCmp  := 'VARCHAR(50) NOT NULL';  // AJC/AJD/TXA/EST/ANT…
    Result[4].strDescri  := INICAM + 'VALAJU' ; Result[4].strTipCmp  := 'DECIMAL(15,2) NOT NULL';
    Result[5].strDescri  := INICAM + 'NUMDEB' ; Result[5].strTipCmp  := 'VARCHAR(32) ';
    Result[6].strDescri  := INICAM + 'CNPJET' ; Result[6].strTipCmp  := 'VARCHAR(16)';
    Result[7].strDescri  := INICAM + 'DTVEND' ; Result[7].strTipCmp  := 'DATE';
    Result[8].strDescri  := INICAM + 'NUMNSU' ; Result[8].strTipCmp  := 'VARCHAR(15)';
    Result[9].strDescri  := INICAM + 'CODAUT' ; Result[9].strTipCmp  := 'VARCHAR(12)';
    Result[10].strDescri := INICAM + 'STATUS' ; Result[10].strTipCmp := 'VARCHAR(40)';   // PAID/SCHEDULED/UNBOOK…
    Result[11].strDescri := INICAM + 'MOTCOD' ; Result[11].strTipCmp := 'VARCHAR(16)';   // motivo do ajuste
    Result[12].strDescri := INICAM + 'VALPAG' ; Result[12].strTipCmp := 'DECIMAL(15,2)';
    Result[13].strDescri := INICAM + 'NUMPED' ; Result[13].strTipCmp := 'VARCHAR(32)';
    Result[14].strDescri := INICAM + 'DTAEXP' ; Result[14].strTipCmp := 'DATE';
    Result[15].strDescri := INICAM + 'DTAIMP' ; Result[15].strTipCmp := 'DATE';
    Result[16].strDescri := INICAM + 'DESAJU' ; Result[16].strTipCmp := 'VARCHAR(70)'    ;
    Result[17].strDescri := INICAM + 'CONCIL' ; Result[17].strTipCmp := 'INT DEFAULT 0';    // 0/1

  end;
end;

class function TmobbuyAPIPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var
  LarrCampos: TArrEstruturaMobbuyAPIPgto;
  LCont: Integer;
begin
 If strTabela.IsEmpty Then
    Exit('');

  Result := 'CREATE TABLE ' + strTabela + '(';
  Try
    LarrCampos := fRetEstruturaPgto(strTabela);

    For LCont := 0 to Length(LarrCampos) - 1 do
      Result := Result + LarrCampos[LCont].strDescri + ' ' + LarrCampos[LCont].strTipCmp + ', ';

    If strTabela = 'MOB_APPGTO' Then
      Result := Result + ' PRIMARY KEY(MOB_TIPREG,MOB_CODAUT,MOB_NUMNSU,MOB_DTVEND,MOB_NUM_PV,MOB_PARCEL,MOB_CES_ID)) ENGINE INNODB '
    Else If strTabela = 'MOB_APVEND' Then
      Result := Result + ' PRIMARY KEY(MOB_TIPREG,MOB_NUM_PV,MOB_MOV_ID,MOB_DTVEND,MOB_CODAUT,MOB_NUMNSU)) ENGINE INNODB '
    Else If strTabela = 'MOB_APVPAR' Then
      Result := Result + ' PRIMARY KEY(MOB_MOV_ID,MOB_NUM_PV,MOB_DTVEND,MOB_CODAUT,MOB_NUMNSU,MOB_NUMPAR)) ENGINE INNODB '
    else if strTabela = 'MOB_APAJUS' then
      Result := Result + ' PRIMARY KEY(MOB_NUM_PV,MOB_DTVEND,MOB_TIPREG,MOB_VALAJU)) ENGINE INNODB ';
  Finally
    SetLength(LarrCampos, 0);
  End;
end;

procedure TMobbuyAPIPgto.GravaRegistrosTabelaPgto(var AProgress: TcxProgressBar);
var
  LGravacao : TUniQuery;
  LRegistro : TMobbuyRegistroPgto;
  LValDes   : Currency;
begin
  LGravacao := Nil;
  try
    LGravacao := VS_FuncoesExternas.fICriaQuery;
    LGravacao.SQL.Text := TMobbuyFuncoes.RetornaSQLReplace('MOB_APPGTO', ['MOB_CONCIL']);

    AProgress.Position := 0;
    AProgress.Properties.Max := FMobbuyRegistrosPgto.Count;

    for LRegistro in FMobbuyRegistrosPgto do
    begin
      FImportouPagamento := True;
      FImportouRegistro  := True;

      LValDes := LRegistro.ValorBruto - LRegistro.ValorLiquido;

      LGravacao.Close;

      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_NUM_PV', CorrigeDadosBanco(LRegistro.CodigoEstabelecimento));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_TIPREG', CorrigeDadosBanco(LRegistro.TipoRegistro));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_DTTRAN', CorrigeDadosBanco(LRegistro.DataTransacao));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_DTVEND', CorrigeDadosBanco(LRegistro.DataVenda));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_DTAIMP', CorrigeDadosBanco(LRegistro.DataImportacao));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_DTAPAG', CorrigeDadosBanco(LRegistro.DataPagamento));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_NUMNSU', CorrigeDadosBanco(LRegistro.NumNSU));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_DESBAN', CorrigeDadosBanco(LRegistro.DescricaoBandeira));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_VALBRU', CorrigeDadosBanco(LRegistro.ValorBruto));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_VALDES', CorrigeDadosBanco(LValDes));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_VALLIQ', CorrigeDadosBanco(LRegistro.ValorLiquido));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_TIPORI', CorrigeDadosBanco(LRegistro.Tipo));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_LANCAM', CorrigeDadosBanco(LRegistro.Lancamento));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_CODAUT', CorrigeDadosBanco(LRegistro.Autorizacao));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_STATUS', CorrigeDadosBanco(LRegistro.Status));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_PARCEL', CorrigeDadosBanco(LRegistro.Parcela));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_CHAVES', CorrigeDadosBanco(LRegistro.Chave));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_NOMCED', CorrigeDadosBanco(LRegistro.NomeCedente));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_CODBCO', CorrigeDadosBanco(LRegistro.CodigoBanco));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_NUMCON', CorrigeDadosBanco(LRegistro.NumConta));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_CODAGE', CorrigeDadosBanco(LRegistro.CodAgencia));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_DIGCON', CorrigeDadosBanco(LRegistro.DigitoConta));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_TOTPAR', CorrigeDadosBanco(LRegistro.TotalParcelas));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_CES_ID', CorrigeDadosBanco(LRegistro.CessaoId));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_CES_NF', CorrigeDadosBanco(LRegistro.CessaoNF));

      LGravacao.ExecSQL;

      TMobbuyFuncoes.pStepStatusGravacao(AProgress);
    end;
  finally
    TMobbuyFuncoes.FreeAndNilDatasets(LGravacao);
  end;
end;

procedure TMobbuyAPIPgto.GravaRegistrosTabelaVenda(var AProgress: TcxProgressBar);
var
  LGravacao   : TUniQuery;
  LVenda : TMobbuyRegistroVenda;
begin
  LGravacao := Nil;
  try
    LGravacao := VS_FuncoesExternas.fICriaQuery;
    LGravacao.SQL.Text := TMobbuyFuncoes.RetornaSQLReplace('MOB_APVEND', ['MOB_CONCIL']); // sem campos excluídos

    AProgress.Position := 0;
    AProgress.Properties.Max := FMobbuyRegistrosVenda.Count;

    for LVenda in FMobbuyRegistrosVenda do
    begin
      FImportouVendas    := True;
      FImportouRegistro  := True;

      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_TIPREG' , CorrigeDadosBanco(LVenda.TipoProduto));          // C/D
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_NUM_PV' , CorrigeDadosBanco(LVenda.CodigoEstabelecimento));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_MOV_ID' , CorrigeDadosBanco(LVenda.MovTrnID));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_DTVEND' , CorrigeDadosBanco(LVenda.DataVenda, True));  // YYYYMMDD -> DATE
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_DTTRAN' , CorrigeDadosBanco(LVenda.DataTransacao, True));  // espelho
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_DTAIMP' , CorrigeDadosBanco(LVenda.DataImportacao, True));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_NUMNSU' , CorrigeDadosBanco(LVenda.NSU));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_CODAUT' , CorrigeDadosBanco(LVenda.Autorizacao));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_TOTPAR' , CorrigeDadosBanco(LVenda.QuantidadeParcelas));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_TIPOPE' , CorrigeDadosBanco(LVenda.CodigoTransacao));      // CV/CC/AJ
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_CODMOT' , CorrigeDadosBanco(LVenda.MotivoAjusteCod));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_NUMCAR' , CorrigeDadosBanco(LVenda.NumeroCartao));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_VALLIQ' , CorrigeDadosBanco(LVenda.ValorLiquidoEst));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_VBRUTO' , CorrigeDadosBanco(LVenda.ValorTransacao));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_VALDES' , CorrigeDadosBanco(LVenda.ValorDescontoVenda));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_CODBAN' , CorrigeDadosBanco(LVenda.BandeiraCodigo));      // V/M/E/…
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_BANDES' , CorrigeDadosBanco(LVenda.DescricaoBandeira));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_GBPTAD' , CorrigeDadosBanco(LVenda.GbpTxaAdm));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_GBPTIN' , CorrigeDadosBanco(LVenda.GbpTxaInt));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_GBPTAN' , CorrigeDadosBanco(LVenda.GbpTxaAnt));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_PACCOD' , CorrigeDadosBanco(LVenda.ParceiroCodigo));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_PACNOM' , CorrigeDadosBanco(LVenda.ParceiroNome));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_BFACCA' , CorrigeDadosBanco(LVenda.BfaCustoCapital));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_BFATAD' , CorrigeDadosBanco(LVenda.BfaTxaAdm));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_BFATFI' , CorrigeDadosBanco(LVenda.BfaTxaFin));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_BFACTR' , CorrigeDadosBanco(LVenda.BfaCustoTransacao));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_BFATCR' , CorrigeDadosBanco(LVenda.BfaTarifaCredito));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_BFATAN' , CorrigeDadosBanco(LVenda.BfaTxaAnt));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_BFALIQ' , CorrigeDadosBanco(LVenda.ValorLiquidoSub));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_POSNUM' , CorrigeDadosBanco(LVenda.PosNumero));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_POSSER' , CorrigeDadosBanco(LVenda.PosNumeroSerie));

      LGravacao.ExecSQL;

      TMobbuyFuncoes.pStepStatusGravacao(AProgress);
    end;
  finally
    TMobbuyFuncoes.FreeAndNilDatasets(LGravacao);
  end;
end;

procedure TMobbuyAPIPgto.GravaRegistrosTabelaVendaAnalitica(
  var AProgress: TcxProgressBar);
  var
    LGravacao,
    LGravacaoParcelas: TUniQuery;

    LVenda: TVendaAnalitica;

    LParcela: TParcelaVenda;
begin
  LGravacao := Nil;
  LGravacaoParcelas := Nil;
  try
    LGravacao := VS_FuncoesExternas.fICriaQuery;
    LGravacao.SQL.Text := TMobbuyFuncoes.RetornaSQLReplace('MOB_APVEND', ['MOB_CONCIL']);

    LGravacaoParcelas := VS_FuncoesExternas.fICriaQuery;
    LGravacaoParcelas.SQL.Text := TMobbuyFuncoes.RetornaSQLReplace('MOB_APVPAR', ['MOB_CONCIL']);

    AProgress.Position := 0;
    AProgress.Properties.Max := FMobbuyRegistrosVendaAnalitica.Count;

    for LVenda in FMobbuyRegistrosVendaAnalitica do
    begin
      FImportouVendas    := True;
      FImportouRegistro  := True;

      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_TIPREG' , CorrigeDadosBanco(LVenda.Produto));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_NUM_PV' , CorrigeDadosBanco(LVenda.CpfCnpjStr));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_MOV_ID' , CorrigeDadosBanco(LVenda.Movimento));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_DTVEND' , CorrigeDadosBanco(LVenda.Data));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_DTTRAN' , CorrigeDadosBanco(LeftStr(LVenda.DthrRegistro,10)));  // espelho
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_DTAIMP' , VS_FuncoesExternas.fIGetVS_Date);
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_NUMNSU' , CorrigeDadosBanco(LVenda.NSU));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_CODAUT' , CorrigeDadosBanco(LVenda.Autorizacao));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_TOTPAR' , CorrigeDadosBanco(TMobbuyFuncoes.fStrZero(LVenda.Parcelas.Count.ToString, 2)));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_TIPOPE' , CorrigeDadosBanco(LVenda.Operacao));      // CV/CC/AJ
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_VALLIQ' , CorrigeDadosBanco(LVenda.LiquidoEC));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_VBRUTO' , CorrigeDadosBanco(LVenda.ValorTransacao));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_VALDES' , CorrigeDadosBanco(LVenda.ValorTransacao - LVenda.LiquidoEC));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_BANDES' , CorrigeDadosBanco(LVenda.Bandeira));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_PACNOM' , CorrigeDadosBanco(LVenda.Parceiro));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_POSNUM' , CorrigeDadosBanco(LVenda.POS));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_POSSER' , CorrigeDadosBanco(LVenda.Serial));

      LGravacao.ExecSQL;

      For LParcela In LVenda.Parcelas Do
      Begin
        TMobbuyFuncoes.CarregaParametroDataset(LGravacaoParcelas, 'MOB_NUM_PV',  CorrigeDadosBanco(LVenda.CpfCnpjStr));
        TMobbuyFuncoes.CarregaParametroDataset(LGravacaoParcelas, 'MOB_NUMNSU',  CorrigeDadosBanco(LVenda.Nsu));
        TMobbuyFuncoes.CarregaParametroDataset(LGravacaoParcelas, 'MOB_CODAUT',  CorrigeDadosBanco(LVenda.Autorizacao));
        TMobbuyFuncoes.CarregaParametroDataset(LGravacaoParcelas, 'MOB_MOV_ID',  CorrigeDadosBanco(LVenda.Movimento));
        TMobbuyFuncoes.CarregaParametroDataset(LGravacaoParcelas, 'MOB_DTVEND',  CorrigeDadosBanco(LVenda.Data));
        TMobbuyFuncoes.CarregaParametroDataset(LGravacaoParcelas, 'MOB_DTTRAN' , CorrigeDadosBanco(LVenda.Data));
        TMobbuyFuncoes.CarregaParametroDataset(LGravacaoParcelas, 'MOB_DTAVCT',  CorrigeDataBanco(LParcela.DataVencimento));
        TMobbuyFuncoes.CarregaParametroDataset(LGravacaoParcelas, 'MOB_DTALIQ',  CorrigeDataBanco(LParcela.DataPagamento));
        TMobbuyFuncoes.CarregaParametroDataset(LGravacaoParcelas, 'MOB_NUMPAR',  CorrigeDadosBanco(LParcela.Parcela));
        TMobbuyFuncoes.CarregaParametroDataset(LGravacaoParcelas, 'MOB_TOTPAR',  CorrigeDadosBanco(LParcela.Plano));
        TMobbuyFuncoes.CarregaParametroDataset(LGravacaoParcelas, 'MOB_STATUS',  CorrigeDadosBanco(LParcela.StatusPagamento));
        TMobbuyFuncoes.CarregaParametroDataset(LGravacaoParcelas, 'MOB_PARBRU',  CorrigeDadosBanco(LParcela.ValorOriginalParcela));
        TMobbuyFuncoes.CarregaParametroDataset(LGravacaoParcelas, 'MOB_PAGLIQ',  CorrigeDadosBanco(LParcela.ValorPagamento));
        TMobbuyFuncoes.CarregaParametroDataset(LGravacaoParcelas, 'MOB_PAGAME',  CorrigeDadosBanco(LParcela.ValorPagamento));
        
        LGravacaoParcelas.ExecSQL;
      End;

      TMobbuyFuncoes.pStepStatusGravacao(AProgress);
    end;
  finally
    TMobbuyFuncoes.FreeAndNilDatasets(LGravacao);
    TMobbuyFuncoes.FreeAndNilDatasets(LGravacaoParcelas);
  end;
end;

procedure TMobbuyAPIPgto.GravaRegistrosTabelaParcela(var AProgress: TcxProgressBar);
var
  LGravacao : TUniQuery;
  LParcela  : TMobbuyRegistroParcela;
begin
  LGravacao := Nil;
  try
    LGravacao := VS_FuncoesExternas.fICriaQuery;
    LGravacao.SQL.Text := TMobbuyFuncoes.RetornaSQLReplace('MOB_APVPAR', ['MOB_CONCIL']);

    AProgress.Position := 0;
    AProgress.Properties.Max := FMobbuyRegistrosVendaParcelada.Count;

    for LParcela in FMobbuyRegistrosVendaParcelada do
    begin
      FImportouRegistro := True;

      LGravacao.Close;

      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_NUM_PV',  CorrigeDadosBanco(LParcela.NumPV));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_NUMNSU',  CorrigeDadosBanco(LParcela.NumNSU));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_CODAUT',  CorrigeDadosBanco(LParcela.CodAut));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_MOV_ID',  CorrigeDadosBanco(LParcela.IdMovimentoParcela)); // BIGINT
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_DTVEND',  CorrigeDadosBanco(LParcela.DataVenda, True)); // DATE NOT NULL
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_DTTRAN' , CorrigeDadosBanco(LParcela.DataTransacao, True));  // espelho
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_DTAVCT',  CorrigeDadosBanco(LParcela.DtaVct, True)); // VARCHAR(10) no layout, mas gravando como data formatada
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_DTALIQ',  CorrigeDadosBanco(LParcela.DtaLiq, True)); // pode vir vazio
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_NUMPAR',  CorrigeDadosBanco(LParcela.NumPar));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_TOTPAR',  CorrigeDadosBanco(LParcela.TotPar));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_STATUS',  CorrigeDadosBanco(LParcela.Status));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_PARBRU',  CorrigeDadosBanco(LParcela.ParBru));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_PAGLIQ',  CorrigeDadosBanco(LParcela.PagLiq));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_PAGAME',  CorrigeDadosBanco(LParcela.Pag));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_TX_ADM',  CorrigeDadosBanco(LParcela.TxAdm));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_CSTPLN',  CorrigeDadosBanco(LParcela.CstPln));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_CSTEST',  CorrigeDadosBanco(LParcela.CstEst));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_TX_FIN',  CorrigeDadosBanco(LParcela.TxFin));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_TARCRE',  CorrigeDadosBanco(LParcela.TarCre));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_ARBLOT',  CorrigeDadosBanco(LParcela.ArbLot));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_ARBSEQ',  CorrigeDadosBanco(LParcela.ArbSeq));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_ARLOT2',  CorrigeDadosBanco(LParcela.ArbLot));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_ANPDES',  CorrigeDadosBanco(LParcela.AnpDesc));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_ANPNUM',  CorrigeDadosBanco(LParcela.AnpNum));

      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_CONCIL',  CorrigeDadosBanco(LParcela.Concil));

      LGravacao.ExecSQL;

      TMobbuyFuncoes.pStepStatusGravacao(AProgress);
    end;
  finally
    TMobbuyFuncoes.FreeAndNilDatasets(LGravacao);
  end;
end;

procedure TMobbuyAPIPgto.GravaRegistrosTabelaAjuste(
  var AProgress: TcxProgressBar);
var
  LGravacao : TUniQuery;
  LAjuste   : TMobbuyRegistroAjuste;
begin
  LGravacao := Nil;
  try
    LGravacao := VS_FuncoesExternas.fICriaQuery;
    LGravacao.SQL.Text := TMobbuyFuncoes.RetornaSQLReplace('MOB_APAJUS', ['MOB_CONCIL']);

    AProgress.Position := 0;
    AProgress.Properties.Max := FMobbuyRegistrosAjuste.Count;

    for LAjuste in FMobbuyRegistrosAjuste do
    begin
      LGravacao.Close;

      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_TIPREG', CorrigeDadosBanco(LAjuste.TipReg)); // CRE/DEB
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_NUM_PV', CorrigeDadosBanco(LAjuste.CodigoEstabelecimento));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_DTVEND', CorrigeDadosBanco(LAjuste.DataVenda));        // DATE
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_DTAPAG', CorrigeDadosBanco(LAjuste.DataPagamento));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_NUMDEB', CorrigeDadosBanco(LAjuste.NumeroDebito));  // id/seq do ajuste
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_CNPJET', CorrigeDadosBanco(LAjuste.CNPJ));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_TIPORI', CorrigeDadosBanco(LAjuste.Tipo));   // AJD/AJC/TXA/CAN/EST/PAC
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_STATUS', CorrigeDadosBanco(LAjuste.Status));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_VALAJU', CorrigeDadosBanco(LAjuste.ValorAjuste));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_VALPAG', CorrigeDadosBanco(LAjuste.ValorPago));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_DTAEXP', CorrigeDadosBanco(LAjuste.DataExpedicao));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_NUMPED', CorrigeDadosBanco(LAjuste.NumeroPedido));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_MOTCOD', CorrigeDadosBanco(LAjuste.MotivoCod));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_CODAUT', CorrigeDadosBanco(LAjuste.Autorizacao));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_NUMNSU', CorrigeDadosBanco(LAjuste.NSU));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_DESAJU', CorrigeDadosBanco(LAjuste.Desaju));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_DTAIMP', CorrigeDadosBanco(LAjuste.DataImportacao, True));
      TMobbuyFuncoes.CarregaParametroDataset(LGravacao, 'MOB_CONCIL', 0);

      LGravacao.ExecSQL;

      TMobbuyFuncoes.pStepStatusGravacao(AProgress);
    end;
  finally
    TMobbuyFuncoes.FreeAndNilDatasets(LGravacao);
  end;
end;

procedure TMobbuyAPIPgto.ImportaPagamentos(strString: String; AProgress: TcxProgressBar);
var
  LRegistro        : TMobbuyRegistroPgto;

  LJsonObject      : TJsonObject;
  LJsonArray       : TJSONArray;
  LJsonValue       : TJsonValue;
  LJsonDia         : TJSONObject;

  LDetalhes        : TJSONArray;
  LDetValue        : TJSONValue;
  LObjDet          : TJSONObject;

  LErroCod         : Integer;
  LSequencia       : Integer;
  LTemDados        : Boolean;

begin
  LJsonObject := Nil;
  try
    LJsonObject := TJSONObject.ParseJSONValue(strString) as TJSONObject;
    if (LJsonObject = nil) then
      raise Exception.Create('Pagamentos: retorno inválido (JSON nulo).');

    LJsonArray := LJsonObject.GetValue('PagamentosM12SaidaSDT') as TJSONArray;
    if (LJsonArray = nil) then
      Exit;

    LTemDados := (LJsonArray.Count > 0);

    LErroCod := StrToIntDef(RetornaValorJson(LJsonObject, 'ErroCod'), 0);
    if (LErroCod <> 0) and (not LTemDados) then
    begin
      AProgress.Position := 0;
      Exit;
    end;

    if not Assigned(LJsonArray) then
    begin
      AProgress.Position := 0;
      Exit;
    end;

    AProgress.Position := 0;
    AProgress.Properties.Max := Ocorrencias('"Autorizacao"', strString);

    for LJsonValue in LJsonArray do
    begin
      if not (LJsonValue is TJSONObject) then
        Continue;

      LJsonDia := TJSONObject(LJsonValue);

      LDetalhes := LJsonDia.GetValue('Detalhe') as TJSONArray;
      if not Assigned(LDetalhes) then
        Continue;

      LSequencia := 0;
      for LDetValue in LDetalhes do
      begin
        if not (LDetValue is TJSONObject) then
          Continue;

        Inc(LSequencia);
        LObjDet := Nil;
        Try
          LObjDet := TJSONObject.ParseJSONValue(LDetValue.ToJSON) As TJsonObject;

          LRegistro := TMobbuyRegistroPgto.Create;

          LRegistro.Lancamento            := RetornaValorJson(LJsonDia,'Lancamento');
          LRegistro.DataTransacao         := (LJsonDia.GetValue('Data') as TJSONString).Value;
          LRegistro.DataVenda             := RetornaValorJson(LObjDet, 'DataVenda');
          LRegistro.DataPagamento         := RetornaValorJson(LJsonDia, 'Data');
          LRegistro.DataImportacao        := FormatDateTime('YYY-MM-DD', VS_FuncoesExternas.fIGetVS_Date);
          LRegistro.Status                := RetornaValorJson(LJsonDia,'Status');
          LRegistro.NomeCedente           := RetornaValorJson(LJsonDia, 'Banco');
          LRegistro.CodAgencia            := RetornaValorJson(LJsonDia, 'Agencia');
          LRegistro.NumConta              := RetornaValorJson(LJsonDia, 'Conta');
          LRegistro.DigitoConta           := RetornaValorJson(LJsonDia, 'Digito');
          LRegistro.CodigoBanco           := LocalizaBanco(RetornaValorJson(LJsonDia, 'Banco'));
          LRegistro.Autorizacao           := RetornaValorJson(LObjDet, 'Autorizacao');
          LRegistro.Tipo                  := RetornaValorJson(LObjDet, 'Tipo');
          LRegistro.CessaoId              := RetornaValorJson(LObjDet, 'CessaoId');
          LRegistro.CessaoNF              := RetornaValorJson(LObjDet, 'CessaoNF');
          LRegistro.Parcela               := RetornaValorJson(LObjDet, 'Parcela');
          LRegistro.TotalParcelas         := RetornaValorJson(LObjDet, 'Plano');
          LRegistro.Chave                 := RetornaValorJson(LObjDet, 'Chave');
          LRegistro.NumNSU                := RetornaValorJson(LObjDet, 'Nsu');
          LRegistro.CodigoEstabelecimento := RetornaValorJson(LObjDet, 'CpfCnpj');
          LRegistro.DescricaoBandeira     := RetornaValorJson(LObjDet, 'Bandeira');
          LRegistro.ValorBruto            := RetornaValorJson(LObjDet, 'VendaBruta',   varDouble);
          LRegistro.ValorLiquido          := RetornaValorJson(LObjDet, 'VendaLiquida', varDouble);

          LRegistro.TipoRegistro          := TipoReg(LRegistro.Tipo, LRegistro.CessaoId);

          If LRegistro.CessaoId.IsEmpty Then
            LRegistro.CessaoId  := '0';

          CompletaChavePagamento(LRegistro, LSequencia);

          LRegistro.Parcela := TMobbuyFuncoes.fStrZero(LRegistro.Parcela, 2);
          LRegistro.TotalParcelas := TMobbuyFuncoes.fStrZero(LRegistro.TotalParcelas, 2);

          FMobbuyRegistrosPgto.Add(LRegistro);
        Finally
          TMobbuyFuncoes.FreeAndNilObjeto(LObjDet);
        End;

        if VS_ListaEstabelecimentos = nil then
          VS_ListaEstabelecimentos := TStringList.Create;

        if (VS_ListaEstabelecimentos.IndexOf(LRegistro.CodigoEstabelecimento) < 0) then
          VS_ListaEstabelecimentos.Add(LRegistro.CodigoEstabelecimento);

        FListaDatasVendas.Add(LRegistro.DataVenda);

        TMobbuyFuncoes.pStepStatusGravacao(AProgress);
      end;
    End;

    AProgress.Position := 0;

  Finally
    TMobbuyFuncoes.FreeAndNilObjeto(LJsonObject);
  end;
end;

procedure TMobbuyAPIPgto.ImportaVendasAnalitica(AString: string;
  AProgress: TcxProgressBar);
  var
  LRaiz,
  LItem,
  LAnalitico,
  LDetalhe: TJSONObject;

  LArrSaida,
  LArrAnalitico,
  LArrDetalhe: TJSONArray;

  LVenda: TVendaAnalitica;

  LParcela: TParcelaVenda;

  LValor: TJSONValue;

  LContadorItens,
  LContadorAnalitico,
  LContadorParcela: Integer;
begin
  LValor := Nil;
  try
    LValor := TJSONObject.ParseJSONValue(AString);
    if not (LValor is TJSONObject) then
      raise Exception.Create('JSON inválido: a raiz não é um objeto.');

    LRaiz := TJSONObject(LValor);
    If Not MatchStr(RetornaValorJson(LRaiz, 'ErroCod'), ['0', '11', '12']) Then
      Raise Exception.Create(RetornaValorJson(LRaiz, 'ErroDesc'));

    if LRaiz.TryGetValue<TJSONArray>('VendasAnaliticasM12SaidaSDT', LArrSaida) then
    Begin
      for LContadorItens := 0 to LArrSaida.Count - 1 do
      begin
        LItem := LArrSaida.Items[LContadorItens] as TJSONObject;

        if not LItem.TryGetValue<TJSONArray>('Analitico', LArrAnalitico) then
          Continue;

        AProgress.Position := 0;
        AProgress.Properties.Max := LArrAnalitico.Count;

        for LContadorAnalitico := 0 to LArrAnalitico.Count - 1 do
        begin
          LAnalitico := LArrAnalitico.Items[LContadorAnalitico] as TJSONObject;

          If RetornaValorJson(LAnalitico, 'Autorizacao') = '' Then
            Continue;

          LVenda := TVendaAnalitica.Create;

          LVenda.Autorizacao := RetornaValorJson(LAnalitico, 'Autorizacao');
          LVenda.Bandeira := RetornaValorJson(LAnalitico, 'Bandeira');
          LVenda.CpfCnpjStr := RetornaValorJson(LAnalitico, 'CpfCnpjStr');
          LVenda.Data := RetornaValorJson(LAnalitico, 'Data');
          LVenda.DthrRegistro := RetornaValorJson(LAnalitico, 'DthrRegistro');
          LVenda.Estabelecimento := RetornaValorJson(LAnalitico, 'Estabelecimento');
          LVenda.Hora := RetornaValorJson(LAnalitico, 'Hora');
          LVenda.LiquidoEC := RetornaValorJson(LAnalitico, 'LiquidoEC', varDouble);
          LVenda.Movimento := RetornaValorJson(LAnalitico, 'Movimento', varInt64);
          LVenda.Nsu := RetornaValorJson(LAnalitico, 'Nsu');
          LVenda.NsuOriginal := RetornaValorJson(LAnalitico, 'NsuOriginal');
          LVenda.Operacao := RetornaValorJson(LAnalitico, 'Operacao');
          LVenda.POS := RetornaValorJson(LAnalitico, 'POS');
          LVenda.Parceiro := RetornaValorJson(LAnalitico, 'Parceiro');
          LVenda.Parcela := TMobbuyFuncoes.fStrZero(RetornaValorJson(LAnalitico, 'Parcela'), 2);
          LVenda.Produto := RetornaValorJson(LAnalitico, 'Produto');
          LVenda.Registro := RetornaValorJson(LAnalitico, 'Registro', varInt64);
          LVenda.Serial := RetornaValorJson(LAnalitico, 'Serial');
          LVenda.Taxa := RetornaValorJson(LAnalitico, 'Taxa', varDouble);
          LVenda.TerminalId := RetornaValorJson(LAnalitico, 'TerminalId');
          LVenda.ValorParcela := RetornaValorJson(LAnalitico, 'ValorParcela', varDouble);
          LVenda.ValorTransacao := RetornaValorJson(LAnalitico, 'ValorTransacao', varDouble);

          if LAnalitico.TryGetValue<TJSONArray>('Detalhe', LArrDetalhe) then
          Begin
            for LContadorParcela := 0 to LArrDetalhe.Count - 1 do
            begin
              LDetalhe := LArrDetalhe.Items[LContadorParcela] as TJSONObject;

              if RetornaValorJson(LDetalhe, 'Parcela', varInteger) <= 0 then
                Continue;

              LParcela := TParcelaVenda.Create;

              LParcela.Parcela := TMobbuyFuncoes.fStrZero(RetornaValorJson(LDetalhe, 'Parcela'), 2);
              LParcela.Plano := TMobbuyFuncoes.fStrZero(RetornaValorJson(LDetalhe, 'Plano'), 2);
              LParcela.Antecipado := RetornaValorJson(LDetalhe, 'Antecipado');
              LParcela.ArquivoPagamento := RetornaValorJson(LDetalhe, 'ArquivoPagamento');
              LParcela.DataPagamento := RetornaValorJson(LDetalhe, 'DataPagamento');
              LParcela.DataVencimento := RetornaValorJson(LDetalhe, 'DataVencimento');
              LParcela.DataVencimentoOriginal := RetornaValorJson(LDetalhe, 'DataVencimentoOriginal');
              LParcela.StatusPagamento := RetornaValorJson(LDetalhe, 'StatusPagamento');
              LParcela.ValorOriginalParcela := RetornaValorJson(LDetalhe, 'ValorOriginalParcela', varDouble);
              LParcela.ValorPagamento := RetornaValorJson(LDetalhe, 'ValorPagamento', varDouble);

              LVenda.Parcelas.Add(LParcela);
            end;
          End;

          FMobbuyRegistrosVendaAnalitica.Add(LVenda);

          TMobbuyFuncoes.pStepStatusGravacao(AProgress);
        end;
      end;
    End;
  Finally
    TMobbuyFuncoes.FreeAndNilObjeto(LValor);
  End;
end;

function TMobbuyAPIPgto.LocalizaBanco(const Nome: string): string;
var
  LBanco: string;
begin
  LBanco := UpperCase(Nome);
  if Pos('ITAÚ', LBanco)       > 0 then Exit('341');
  if Pos('SANTANDER', LBanco)  > 0 then Exit('033');
  if Pos('BRADESCO', LBanco)   > 0 then Exit('237');
  if Pos('BANCO DO BRASIL', LBanco) > 0 then Exit('001');
  if Pos('CAIXA', LBanco)      > 0 then Exit('104');
  if Pos('SAFRA', LBanco)      > 0 then Exit('422');
  if Pos('BANRISUL', LBanco)   > 0 then Exit('041');
  if Pos('SICREDI', LBanco)    > 0 then Exit('748');
  Result := 'OUTRO';
end;

function TMobbuyAPIPgto.Ocorrencias(TextoProcurado, Texto: string): integer;
var
  posicao: integer;
begin
  result := 0;
  posicao := PosEx(TextoProcurado, Texto, 1);
  while posicao > 0 do
  begin
    inc(result);
    posicao := PosEx(TextoProcurado, Texto, posicao + length(TextoProcurado));
  end;
end;

procedure TMobbuyAPIPgto.pAdicionaLinha(strString: String; pgbProg: TcxProgressBar);
begin
  if strString.Trim.IsEmpty then
    Exit;

  try
    if FTipoDoArquivo = 'PAGAMENTOS' then
      ImportaPagamentos(strString, pgbProg)
    else
    if FTipoDoArquivo = 'VENDAS' then
      ImportaVendasAnalitica(strString, pgbProg);
  except
    Raise;
  end;
end;

procedure TMobbuyAPIPgto.LimparRegistros;
begin
  FMobbuyRegistrosPgto.Clear;
  FMobbuyRegistrosVenda.Clear;
  FMobbuyRegistrosVendaParcelada.Clear;
  FMobbuyRegistrosAjuste.Clear;
  FMobbuyRegistrosVendaAnalitica.Clear;
  FListaDatasVendas.Clear;
end;

procedure TMobbuyAPIPgto.pGravarRegistros(pgbProg: TcxProgressBar);
begin
  VS_FuncoesExternas.fIStartTransaction;
  try
    GravaRegistrosTabelaPgto(pgbProg);
    GravaRegistrosTabelaVendaAnalitica(pgbProg);

    GravaRegistrosTabelaVenda(pgbProg);
    GravaRegistrosTabelaParcela(pgbProg);
    GravaRegistrosTabelaAjuste(pgbProg);
    AtualizarCartao(pgbProg);

    LimparRegistros;

    TMobbuyFuncoes.GravarEstabelecimentos(True);
    VS_FuncoesExternas.fICommit;
  except
    on E: Exception do
    begin
      VS_FuncoesExternas.fIRollback;
      raise Exception.Create('Ocorreu um erro ao gravar os registros.'+
                             ' Erro gerado: ' + E.Message);
    end;
  end;

end;

function TMobbuyAPIPgto.RetornaValorJson(AObjeto: TJsonObject; ANomeCampo: String; ATipoRetorno: TVarType = varString): Variant;
begin
  Case ATipoRetorno of
    varInteger: Result := 0;
    varInt64:   Result := Int64(0);
    varBoolean: Result := False;
    varDouble:  Result := 0.0;
    varDate:    Result := 0;
    else        Result := EmptyStr;
  end;

  If AObjeto.GetValue(ANomeCampo) = Nil Then
    Exit;

  Case ATipoRetorno Of
    varInteger: Result := AObjeto.GetValue<Integer>(ANomeCampo);
    varInt64: Result := AObjeto.GetValue<Int64>(ANomeCampo);
    varBoolean: Result := AObjeto.GetValue<Boolean>(ANomeCampo);
    varDouble: Result := AObjeto.GetValue<Double>(ANomeCampo);
    varDate: Result := AObjeto.GetValue<TDate>(ANomeCampo);
    Else Result := AObjeto.GetValue<String>(ANomeCampo);
  End;
end;

function TMobbuyAPIPgto.TipoReg(ATipo, ACessao: string): string;
var
  LTipoTemp: string;
begin
  Result := 'CRE';

  if (Trim(ACessao) <> '') and (Trim(ACessao) <> '0') then
    Exit('ANT');

  LTipoTemp := UpperCase(Trim(TMobbuyFuncoes.fRemoveAcento(ATipo)));

  if Pos('DEBITO', LTipoTemp) > 0 then
    Exit('DEB');

  if Pos('PIX', LTipoTemp) > 0 then
    Exit('PIX');

  if (Pos('CANCELAMENTO', LTipoTemp) > 0) or (Pos('AJUSTE', LTipoTemp) > 0) or
     (Pos('PRESTACAO DE SERVICO', LTipoTemp) > 0) or (Pos('SERVICO', LTipoTemp) > 0) then
        Exit('AJU');
end;

end.
