unit untPagarMePgto;

interface
uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls,
     Dialogs, Forms, untTRedeCard, System.Generics.Collections, Json,
     System.Math, untIDataSet;

Type
  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrEstruturaPagarMePgto = Array Of TEstruturaPgto;

  TPagarMeRegistroTransferencia = Class
    FTransferencia_ID,
    FTipoRegistro,
    FDescricao,
    FStatus,
    FValorTransferencia,
    FTaxaTransferencia,
    FTipoTransferencia,
    FSource_ID,
    FTargetType,
    FDataCadastro,
    FDataCredito,
    FTitular,
    FCodigoBanco,
    FAgencia,
    FConta,
    FDigitoConta,
    FJsonRecebido,
    FKeyApi: String;
  end;

  TPagarMeRegistroRecebiveis = Class
    FRecebivel_ID,
    FGateWay_ID,
    FCobranca_ID,
    FTipoRecebimento,
    FStatus,
    FNumeroParcela,
    FValorParcela,
    FTaxaParcela,
    FTaxaAntecipacao,
    FTaxaAntiFraude,
    FValorPago,
    FDataCadastro,
    FDataVencimento,
    FDataPagamento,
    FJsonRecebido,
    FKeyApi,
    FAntecipacao_ID,
    FRecebedor,
    FMetodoPagamento: String;
  end;

  TPagarMeRegistroCobranca = Class
    FCobranca_ID,
    FGateway_ID,
    FTipoRegistro,
    FTotalParcelas,
    FNumeroNSU,
    FParcela,
    FAutorizacao,
    FDataVenda,
    FValorBruto,
    FValorLiquido,
    FCartao,
    FNumPok,
    FBandeira,
    FDataPagamento,
    FMeioPagamento,
    FJson,
    FDataImportacao,
    FKeyApi,
    FStatus,
    FOrigem: String;
  End;


  TPagarMeRegistroPgto = class
    Aobject,
    Astatus,
    Arefuse_reason,
    Astatus_reason,
    Aacquirer_response_code,
    Aacquirer_response_message,
    Aacquirer_name,
    Aacquirer_id,
    Aauthorization_code,
    Asoft_descriptor,
    Atid,
    Ansu,
    Adate_created,
    Adate_updated,
    Aamount,
    Aauthorized_amount,
    Apaid_amount,
    Arefunded_amount,
    Ainstallments,
    Aid,
    Acost,
    Acard_holder_name,
    Acard_last_digits,
    Acard_first_digits,
    Acard_brand,
    Acard_pin_mode,
    Acard_magstripe_fallback,
    Acvm_pin,
    Apostback_url,
    Apayment_method,
    Acapture_method,
    Aantifraud_score,
    Aboleto_url,
    Aboleto_barcode,
    Aboleto_expiration_date,
    Aboleto,
    Areferer,
    Aip,
    Asubscription_id,
    AJson,
    AKeyApi : String;
  End;

  TPagarMeRegistroVendas = class
    Aobject,
    Aid,
    Astatus,
    Aamount,
    Afee,
    Aanticipation_fee,
    Afraud_coverage_fee,
    Ainstallment,
    Atransaction_id,
    Asplit_rule_id,
    Abulk_anticipation_id,
    Aanticipation_id,
    Arecipient_id,
    Aoriginator_model,
    Aoriginator_model_id,
    Apayment_date,
    Aoriginal_payment,
    Atype,
    Apayment_method,
    Aaccrual_date,
    Adate_created,
    Aliquidation_arrangement_id,
    aJson : String;
  End;

  TPagarMePgto = Class(TInterfacedObject, ICartoes)
  Private
    FPagarMeRegistrosPgto: TList<TPagarMeRegistroPgto>;
    FPagarMeRegistrosVendas: TList<TPagarMeRegistroVendas>;
    FPagarMeRegistrosCobranca: TList<TPagarMeRegistroCobranca>;
    FPagarMeRegistrosRecebiveis: TList<TPagarMeRegistroRecebiveis>;
    FPagarMeRegistrosTransferencias: TList<TPagarMeRegistroTransferencia>;

    FImportouRegistro,
    FImportouPagamento,
    FImportouRecebiveis,
    FImportouCobrancas: Boolean;
    LKeyApi: String;


    FTipoDoArquivo: String;
    FImportouTransferencias: Boolean;

    function CorrigeDadosBanco(AValor: Variant; varTipVar: TVarType = varString): Variant;

    function RetornaSQLReplaceTabela(ATabela: String): String;

    function RetornaValorJson(AObjeto: TJsonObject; ANomeCampo: String): String; Overload;
    function PrettyJSON(AJsonValue: TJsonValue): string;

    procedure ImportaTransacoes(strString: String; pgbProg: TProgressBar);
    procedure ImportaVendas(strString: String;pgbProg: TProgressBar);
    procedure ImportaCobranca(strString: String; pgbProg: TProgressBar);
    procedure AdicionarParcelas(APagarMeRegistroCobranca: TPagarMeRegistroCobranca);
    function RetornaValorBrutoParcela(APagarMeRegistroCobranca: TPagarMeRegistroCobranca): Double;
    function RetornaValorLiquidoParcela(APagarMeRegistroCobranca: TPagarMeRegistroCobranca): Double;
    procedure ImportarRecebiveis(strString: String; pgbProg: TProgressBar);
    procedure GravarRecebiveis(var ADataSet: IDataSet; pgbProg: TProgressBar);
    function RetornarValorPagoDaParcela(ARecebivel: TPagarMeRegistroRecebiveis): Double;
    class function RetornaListaDeCampos(AObjetoCampos: TArrEstruturaPagarMePgto): TStringList;
    procedure ImportarTransferencias(AJson: String; pgbProg: TProgressBar);
    procedure GravarTransferencias(var ADataSet: IDataSet;
      pgbProg: TProgressBar);
  Public
    constructor Create;
    destructor Destroy; override;

    function RetornarIdCobrancasNaoEncontradas(ADataInicial, ADataFinal: TDateTime;
      AKeyApi: String): TStringList;

    procedure pAdicionaLinha(strString: String; pgbProg: TProgressBar); Overload;
    procedure pAdicionaLinha(strString: String); Overload;
    procedure pGravarRegistros(pgbProg: TProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaPagarMePgto;

    property ImportouRegistro : Boolean                     Read FImportouRegistro;
    property ListaDePagamentos: TList<TPagarMeRegistroPgto> Read FPagarMeRegistrosPgto;
    property ImportouPagamento: Boolean                     Read FImportouPagamento;
    property ImportouRecebiveis:Boolean                     Read FImportouRecebiveis;
    property ImportouCobrancas: Boolean                     Read FImportouCobrancas;
    property ImportouTransferencias: Boolean read FImportouTransferencias;
    property TipoDoArquivo    : String                      Read FTipoDoArquivo Write FTipoDoArquivo;
    property KeyApi           : String                      Read LKeyApi Write LKeyApi;

  End;

  Var
    NomeArquivo,
    DataArquivo: String;

implementation

uses untFuncoes;

{ TPagarMePgto }

procedure TPagarMePgto.AdicionarParcelas(APagarMeRegistroCobranca: TPagarMeRegistroCobranca);
  Var
    LRegistro: TPagarMeRegistroCobranca;
    I : Integer;
    LTotalParcelas: Integer;
begin

  LTotalParcelas := StrToInt(APagarMeRegistroCobranca.FTotalParcelas);

  If (LTotalParcelas = 1) Then
    Exit;

  For I := 2 To LTotalParcelas Do
  Begin
    LRegistro := TPagarMeRegistroCobranca.Create;

    LRegistro.FCobranca_ID  := APagarMeRegistroCobranca.FCobranca_ID;
    LRegistro.FGateway_ID   := APagarMeRegistroCobranca.FGateway_ID;
    LRegistro.FTipoRegistro := APagarMeRegistroCobranca.FTipoRegistro;
    LRegistro.FTotalParcelas := APagarMeRegistroCobranca.FTotalParcelas;
    LRegistro.FNumeroNSU := APagarMeRegistroCobranca.FNumeroNSU;
    LRegistro.FParcela :=  IntToStr(I);
    LRegistro.FAutorizacao := APagarMeRegistroCobranca.FAutorizacao;
    LRegistro.FDataVenda := APagarMeRegistroCobranca.FDataVenda;
    LRegistro.FValorBruto :=  APagarMeRegistroCobranca.FValorBruto;
    LRegistro.FValorLiquido :=  APagarMeRegistroCobranca.FValorLiquido;
    LRegistro.FCartao := APagarMeRegistroCobranca.FCartao;
    LRegistro.FNumPok := APagarMeRegistroCobranca.FNumPok;
    LRegistro.FBandeira :=  APagarMeRegistroCobranca.FBandeira;
    LRegistro.FDataPagamento := APagarMeRegistroCobranca.FDataPagamento;
    LRegistro.FMeioPagamento := APagarMeRegistroCobranca.FMeioPagamento;
    LRegistro.FJson := APagarMeRegistroCobranca.FJson;
    LRegistro.FDataImportacao :=  APagarMeRegistroCobranca.FDataImportacao;
    LRegistro.FKeyApi := APagarMeRegistroCobranca.FKeyApi;
    LRegistro.FStatus := APagarMeRegistroCobranca.FStatus;
    LRegistro.FOrigem := APagarMeRegistroCobranca.FOrigem;
    FPagarMeRegistrosCobranca.Add(LRegistro);
  End;
end;

function TPagarMePgto.CorrigeDadosBanco(AValor: Variant; varTipVar: TVarType = varString): Variant;
begin
  Result := Null;

  Case varTipVar Of
    varString : Result := AValor;

    varInteger, varSmallint, varSingle, varByte, varShortInt, varInt64:
                Begin
                  Try
                    If Not fEmptyStr(AValor) Then
                      Result := strToInt(AValor)
                    Else
                      Result := 0;
                  Except
                    Result := Null;
                  End;
                End;

    varDouble, varCurrency:
                Begin
                  Try
                    If Not fEmptyStr(AValor) Then
                      Result := (fStrToFloat(AnsiReplaceStr(AValor, '.', ','))/100)
                    Else
                      Result := 0.00;
                  Except
                    Result := Null;
                  End;
                End;

      varDate:
                Begin
                  Try
                    If Not fEmptyStr(AValor) Then
                      Result := LeftStr(AValor,10)
                    Else
                      Result := Null;
                  Except
                    Result := Null;
                  End;
                End;
  End;

end;


constructor TPagarMePgto.Create;
begin
  FImportouRegistro := False;
  FImportouPagamento := False;
  FImportouRecebiveis := False;
  FImportouCobrancas := False;

  FPagarMeRegistrosPgto           := TList<TPagarMeRegistroPgto>.Create;
  FPagarMeRegistrosVendas         := TList<TPagarMeRegistroVendas>.Create;
  FPagarMeRegistrosCobranca       := TList<TPagarMeRegistroCobranca>.Create;
  FPagarMeRegistrosRecebiveis     := TList<TPagarMeRegistroRecebiveis>.Create;
  FPagarMeRegistrosTransferencias := TList<TPagarMeRegistroTransferencia>.Create;
end;

destructor TPagarMePgto.Destroy;
begin
  FPagarMeRegistrosPgto.Free;
  FPagarMeRegistrosVendas.Free;
  FPagarMeRegistrosCobranca.Free;
  FPagarMeRegistrosRecebiveis.Free;
  FPagarMeRegistrosTransferencias.Free;
  inherited;
end;

class function TPagarMePgto.RetornaListaDeCampos(
  AObjetoCampos: TArrEstruturaPagarMePgto): TStringList;
  Var
    LContador: Integer;
begin
  Result := TStringList.Create;

  For LContador := 0 To Length(AObjetoCampos) - 1 Do
    Result.Add(AObjetoCampos[LContador].strDescri);
end;

class function TPagarMePgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaPagarMePgto;
Begin
  If strTabela.Equals('PGM_PMCOBR') Then
  Begin
    SetLength(Result, 21);
    Result[00].strDescri  := 'PGM_ID_COB'; Result[00].strTipCmp  := 'VARCHAR(100)';
    Result[01].strDescri  := 'PGM_GATWAY'; Result[01].strTipCmp  := 'VARCHAR(100)';
    Result[02].strDescri  := 'PGM_TIPREG'; Result[02].strTipCmp  := 'VARCHAR(100)';
    Result[03].strDescri  := 'PGM_TOTPAR'; Result[03].strTipCmp  := 'INT';
    Result[04].strDescri  := 'PGM_NUMNSU'; Result[04].strTipCmp  := 'VARCHAR(14)';
    Result[05].strDescri  := 'PGM_NUMPAR'; Result[05].strTipCmp  := 'INT';
    Result[06].strDescri  := 'PGM_CODAUT'; Result[06].strTipCmp  := 'VARCHAR(40)';
    Result[07].strDescri  := 'PGM_DTACRE'; Result[07].strTipCmp  := 'DATE';
    Result[08].strDescri  := 'PGM_BRUPAR'; Result[08].strTipCmp  := 'DECIMAL(15,2)';
    Result[09].strDescri  := 'PGM_LIQPAR'; Result[09].strTipCmp  := 'DECIMAL(15,2)';
    Result[10].strDescri  := 'PGM_NUMCAR'; Result[10].strTipCmp  := 'VARCHAR(100)';
    Result[11].strDescri  := 'PGM_NUMPOK'; Result[11].strTipCmp  := 'VARCHAR(100)';
    Result[12].strDescri  := 'PGM_BANDEI'; Result[12].strTipCmp  := 'VARCHAR(100)';
    Result[13].strDescri  := 'PGM_DTAPAG'; Result[13].strTipCmp  := 'DATE NOT NULL DEFAULT "0000-00-00"';
    Result[14].strDescri  := 'PGM_METPAG'; Result[14].strTipCmp  := 'VARCHAR(100)';
    Result[15].strDescri  := 'PGM_JSOREC'; Result[15].strTipCmp  := 'TEXT';
    Result[16].strDescri  := 'PGM_DTAIMP'; Result[16].strTipCmp  := 'DATE';
    Result[17].strDescri  := 'PGM_KEYAPI'; Result[17].strTipCmp  := 'VARCHAR(255)';
    Result[18].strDescri  := 'PGM_STATUS'; Result[18].strTipCmp  := 'VARCHAR(100)';
    Result[19].strDescri  := 'PGM_CONCIL'; Result[19].strTipCmp  := 'INT DEFAULT 0';
    Result[20].strDescri  := 'PGM_ORIGEM'; Result[20].strTipCmp  := 'VARCHAR(10) DEFAULT NULL';
  end
  Else If strTabela.Equals('PGM_PMPGTO') Then
  Begin
    SetLength(Result, 27);

    Result[00].strDescri  := 'PGM_OBJECT'; Result[00].strTipCmp  := 'VARCHAR(100)';
    Result[01].strDescri  := 'PGM_STATUS'; Result[01].strTipCmp  := 'VARCHAR(100)';
    Result[02].strDescri  := 'PGM_REFREA'; Result[02].strTipCmp  := 'VARCHAR(100)';
    Result[03].strDescri  := 'PGM_STAREA'; Result[03].strTipCmp  := 'VARCHAR(100)';
    Result[04].strDescri  := 'PGM_ACQCOD'; Result[04].strTipCmp  := 'VARCHAR(100)';

    Result[05].strDescri  := 'PGM_ACQMES'; Result[05].strTipCmp  := 'VARCHAR(100)';
    Result[06].strDescri  := 'PGM_ACQNAM'; Result[06].strTipCmp  := 'VARCHAR(100)';
    Result[07].strDescri  := 'PGM_ACQ_ID'; Result[07].strTipCmp  := 'VARCHAR(100)';
    Result[08].strDescri  := 'PGM_CODAUT'; Result[08].strTipCmp  := 'VARCHAR(40)';
    Result[09].strDescri  := 'PGM_SOFDES'; Result[09].strTipCmp  := 'VARCHAR(100)';

    Result[10].strDescri  := 'PGM_CODTID'; Result[10].strTipCmp  := 'VARCHAR(100)';
    Result[11].strDescri  := 'PGM_NUMNSU'; Result[11].strTipCmp  := 'VARCHAR(14)';
    Result[12].strDescri  := 'PGM_DTACRE'; Result[12].strTipCmp  := 'DATE';
    Result[13].strDescri  := 'PGM_DTAUPD'; Result[13].strTipCmp  := 'DATE';

    Result[14].strDescri  := 'PGM_VALPAG'; Result[14].strTipCmp  := 'DECIMAL(15,2)';
    Result[15].strDescri  := 'PGM_PAGAUT'; Result[15].strTipCmp  := 'DECIMAL(15,2)';
    Result[16].strDescri  := 'PGM_QTDPAG'; Result[16].strTipCmp  := 'DECIMAL(15,2)';
    Result[17].strDescri  := 'PGM_REFPAG'; Result[17].strTipCmp  := 'DECIMAL(15,2)';
    Result[18].strDescri  := 'PGM_TOTPAR'; Result[18].strTipCmp  := 'INT';

    Result[19].strDescri  := 'PGM_TRA_ID'; Result[19].strTipCmp  := 'VARCHAR(100)';
    Result[20].strDescri  := 'PGM_NUMCAR'; Result[20].strTipCmp  := 'VARCHAR(100)';
    Result[21].strDescri  := 'PGM_BANDEI'; Result[21].strTipCmp  := 'VARCHAR(40)';
    Result[22].strDescri  := 'PGM_PAYMET'; Result[22].strTipCmp  := 'VARCHAR(40)';
    Result[23].strDescri  := 'PGM_CAPMET'; Result[23].strTipCmp  := 'VARCHAR(40)';

    Result[24].strDescri  := 'PGM_JSOREC'; Result[24].strTipCmp  := 'TEXT'         ;
    Result[25].strDescri  := 'PGM_DTAIMP'; Result[25].strTipCmp  := 'DATE'         ;
    Result[26].strDescri  := 'PGM_KEYAPI'; Result[26].strTipCmp  := 'TEXT'         ;

  End Else If strTabela.Equals('PGM_PMVEND') Then
  Begin
    SetLength(Result, 23);

    Result[00].strDescri  := 'PGM_OBJECT'; Result[00].strTipCmp  := 'VARCHAR(100)';
    Result[01].strDescri  := 'PGM_VEN_ID'; Result[01].strTipCmp  := 'VARCHAR(100)';
    Result[02].strDescri  := 'PGM_STATUS'; Result[02].strTipCmp  := 'VARCHAR(100)';

    Result[03].strDescri  := 'PGM_VALPAG'; Result[03].strTipCmp  := 'DECIMAL(15,2)';
    Result[04].strDescri  := 'PGM_VALTAX'; Result[04].strTipCmp  := 'DECIMAL(15,2)';
    Result[05].strDescri  := 'PGM_TAXANT'; Result[05].strTipCmp  := 'DECIMAL(15,2)';
    Result[06].strDescri  := 'PGM_TAXFRA'; Result[06].strTipCmp  := 'DECIMAL(15,2)';

    Result[07].strDescri  := 'PGM_NUMPAR'; Result[07].strTipCmp  := 'INT';

    Result[08].strDescri  := 'PGM_TRA_ID'; Result[08].strTipCmp  := 'VARCHAR(100)';
    Result[09].strDescri  := 'PGM_RUL_ID'; Result[09].strTipCmp  := 'VARCHAR(100)';
    Result[10].strDescri  := 'PGM_BANTID'; Result[10].strTipCmp  := 'VARCHAR(100)';
    Result[11].strDescri  := 'PGM_ANT_ID'; Result[11].strTipCmp  := 'VARCHAR(100)';

    Result[12].strDescri  := 'PGM_DES_ID'; Result[12].strTipCmp  := 'VARCHAR(100)';
    Result[13].strDescri  := 'PGM_ORIMOD'; Result[13].strTipCmp  := 'VARCHAR(100)';
    Result[14].strDescri  := 'PGM_MOD_ID'; Result[14].strTipCmp  := 'VARCHAR(100)';
    Result[15].strDescri  := 'PGM_DTAPAG'; Result[15].strTipCmp  := 'DATE';

    Result[16].strDescri  := 'PGM_TIPREG'; Result[16].strTipCmp  := 'VARCHAR(100)';
    Result[17].strDescri  := 'PGM_METPAG'; Result[17].strTipCmp  := 'VARCHAR(100)';
    Result[18].strDescri  := 'PGM_DTAACU'; Result[18].strTipCmp  := 'DATE';
    Result[19].strDescri  := 'PGM_DTACRE'; Result[19].strTipCmp  := 'DATE';
    Result[20].strDescri  := 'PGM_ACO_ID'; Result[20].strTipCmp  := 'VARCHAR(100)';
    Result[21].strDescri  := 'PGM_JSOREC'; Result[21].strTipCmp  := 'TEXT';
    Result[22].strDescri  := 'PGM_CONCIL'; Result[22].strTipCmp  := 'INT DEFAULT 0';

  End
  Else if strTabela.Equals('PGM_PMRECE') then
  begin
    SetLength(Result, 21);

    Result[00].strDescri  := 'PGM_ID_REC'; Result[00].strTipCmp  := 'VARCHAR(100)';    //Identificador de recebivel
    Result[01].strDescri  := 'PGM_GATWAY'; Result[01].strTipCmp  := 'VARCHAR(100)';    //Identificador da cobrança no gateway de pagamento.
    Result[02].strDescri  := 'PGM_ID_COB'; Result[02].strTipCmp  := 'VARCHAR(100)';    //Identificador da cobrança
    Result[03].strDescri  := 'PGM_TIPREC'; Result[03].strTipCmp  := 'VARCHAR(40)';    //Tipo de recebivel
    Result[04].strDescri  := 'PGM_STATUS'; Result[04].strTipCmp  := 'VARCHAR(40)';    //Status do recebivel
    Result[05].strDescri  := 'PGM_NUMPAR'; Result[05].strTipCmp  := 'INT';            //Número da parcela do recebivel
    Result[06].strDescri  := 'PGM_VALPAR'; Result[06].strTipCmp  := 'DECIMAL(15,2)';  //Valor original da parcela
    Result[07].strDescri  := 'PGM_TAXPAR'; Result[07].strTipCmp  := 'DECIMAL(15,2)';  //Taxa cobrada da parcela
    Result[08].strDescri  := 'PGM_TAXANT'; Result[08].strTipCmp  := 'DECIMAL(15,2)';  //Taxa cobrada por antecipação
    Result[09].strDescri  := 'PGM_TAXFRA'; Result[09].strTipCmp  := 'DECIMAL(15,2)';  //Taxa de cobertura do Antifraude
    Result[10].strDescri  := 'PGM_VALPAG'; Result[10].strTipCmp  := 'DECIMAL(15,2)';  //Valor da parcela deduzindo os valores de taxa
    Result[11].strDescri  := 'PGM_DTACAD'; Result[11].strTipCmp  := 'DATE';           //Data de criação do recebivel
    Result[12].strDescri  := 'PGM_DTAVEN'; Result[12].strTipCmp  := 'DATE';           //Data de vencimento do recebivel
    Result[13].strDescri  := 'PGM_DTAPAG'; Result[13].strTipCmp  := 'DATE';           //Data de pagamento do recebivel
    Result[14].strDescri  := 'PGM_JSOREC'; Result[14].strTipCmp  := 'TEXT';           //Json recebido
    Result[15].strDescri  := 'PGM_KEYAPI'; Result[15].strTipCmp  := 'VARCHAR(255)';   //Chave de autenticação utilizada na requisição
    Result[16].strDescri  := 'PGM_CONCIL'; Result[16].strTipCmp  := 'INT DEFAULT 0';
    Result[17].strDescri  := 'PGM_DTAIMP'; Result[17].strTipCmp  := 'DATE';
    Result[18].strDescri  := 'PGM_ID_ANT'; Result[18].strTipCmp  := 'VARCHAR(100)';
    Result[19].strDescri  := 'PGM_RECEBE'; Result[19].strTipCmp  := 'VARCHAR(100)';
    Result[20].strDescri  := 'PGM_METPAG'; Result[20].strTipCmp  := 'VARCHAR(100)';
  end
  else if strTabela.Equals('PGM_PMTRAN') then
  begin
    SetLength(Result, 19);

    Result[00].strDescri  := 'PGM_ID_TRF'; Result[00].strTipCmp  := 'VARCHAR(255)';
    Result[01].strDescri  := 'PGM_STATUS'; Result[01].strTipCmp  := 'VARCHAR(20)';
    Result[02].strDescri  := 'PGM_VALTRF'; Result[02].strTipCmp  := 'DECIMAL(15,2) NOT NULL';
    Result[03].strDescri  := 'PGM_TAXTRF'; Result[03].strTipCmp  := 'DECIMAL(15,2) NOT NULL DEFAULT 0.00';
    Result[04].strDescri  := 'PGM_SOURCE'; Result[04].strTipCmp  := 'VARCHAR(255)';
    Result[05].strDescri  := 'PGM_TARGET'; Result[05].strTipCmp  := 'VARCHAR(50)';
    Result[06].strDescri  := 'PGM_DTATRF'; Result[06].strTipCmp  := 'DATE NOT NULL';
    Result[07].strDescri  := 'PGM_DTACRE'; Result[07].strTipCmp  := 'DATE DEFAULT NULL';
    Result[08].strDescri  := 'PGM_TITULA'; Result[08].strTipCmp  := 'VARCHAR(255)';
    Result[09].strDescri  := 'PGM_CODBCO'; Result[09].strTipCmp  := 'CHAR(3)';
    Result[10].strDescri  := 'PGM_AGENCI'; Result[10].strTipCmp  := 'VARCHAR(10)';
    Result[11].strDescri  := 'PGM_NUMCTA'; Result[11].strTipCmp  := 'VARCHAR(15)';
    Result[12].strDescri  := 'PGM_JSOREC'; Result[12].strTipCmp  := 'TEXT';
    Result[13].strDescri  := 'PGM_KEYAPI'; Result[13].strTipCmp  := 'VARCHAR(255)';
    Result[14].strDescri  := 'PGM_TIPTRF'; Result[14].strTipCmp  := 'VARCHAR(50)';
    Result[15].strDescri  := 'PGM_CONCIL'; Result[15].strTipCmp  := 'INT DEFAULT 0';
    Result[16].strDescri  := 'PGM_DTAIMP'; Result[16].strTipCmp  := 'DATE NOT NULL';
    Result[17].strDescri  := 'PGM_TIPREG'; Result[17].strTipCmp  := 'VARCHAR(20)';
    Result[18].strDescri  := 'PGM_DESCRI'; Result[18].strTipCmp  := 'VARCHAR(255)';
  end;

End;

class function TPagarMePgto.fRetSQLTabelaRegPgto(strTabela: String): String;
  Var
    arrCampos: TArrEstruturaPagarMePgto;
    intCont  : Integer;
begin
  If strTabela.IsEmpty Then
    Exit('');

  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  If strTabela.Equals('PGM_PMPGTO') Then
    Result := Result + ' PRIMARY KEY(PGM_NUMNSU,PGM_CODAUT,PGM_VALPAG,PGM_DTACRE,PGM_TRA_ID)) ENGINE INNODB '
  Else If strTabela.Equals('PGM_PMVEND') Then
    Result := Result + ' PRIMARY KEY(PGM_VEN_ID,PGM_NUMPAR,PGM_TRA_ID,PGM_TIPREG)) ENGINE INNODB '
  Else If strTabela.Equals('PGM_PMCOBR') Then
    Result := Result + ' PRIMARY KEY(PGM_NUMPOK,PGM_NUMPAR,PGM_DTAPAG,PGM_METPAG,PGM_KEYAPI)) ENGINE INNODB '
  Else If strTabela.Equals('PGM_PMRECE') Then
    Result := Result + ' PRIMARY KEY(PGM_ID_REC, PGM_KEYAPI)) ENGINE INNODB '
  else if strTabela.Equals('PGM_PMTRAN') then
    Result := Result + ' PRIMARY KEY(PGM_ID_TRF, PGM_KEYAPI)) ENGINE INNODB '

End;

procedure TPagarMePgto.GravarRecebiveis(var ADataSet: IDataSet; pgbProg: TProgressBar);
var
  LRegistroRecebivel: TPagarMeRegistroRecebiveis;
  LSQL: String;
begin
  LSQL := RetornaSQLReplace('PGM_PMRECE',
                            RetornaListaDeCampos(fRetEstruturaPgto('PGM_PMRECE')),
                            ['PGM_CONCIL']);

  ADataSet := objFunctions.fGetDataSet;
  ADataSet.Close;
  ADataSet.SQL := LSQL;

  pgbProg.Position := 0;
  pgbProg.Max := FPagarMeRegistrosRecebiveis.Count;

  try
    For LRegistroRecebivel In FPagarMeRegistrosRecebiveis Do
    Begin
      FImportouRecebiveis := True;

      ADataSet.ParamByName('PGM_ID_REC').Value := CorrigeDadosBanco(LRegistroRecebivel.FRecebivel_ID);
      ADataSet.ParamByName('PGM_GATWAY').Value := CorrigeDadosBanco(LRegistroRecebivel.FGateWay_ID);
      ADataSet.ParamByName('PGM_ID_COB').Value := CorrigeDadosBanco(LRegistroRecebivel.FCobranca_ID);
      ADataSet.ParamByName('PGM_TIPREC').Value := CorrigeDadosBanco(LRegistroRecebivel.FTipoRecebimento);
      ADataSet.ParamByName('PGM_STATUS').Value := CorrigeDadosBanco(LRegistroRecebivel.FStatus);
      ADataSet.ParamByName('PGM_NUMPAR').Value := CorrigeDadosBanco(LRegistroRecebivel.FNumeroParcela, varInteger);
      ADataSet.ParamByName('PGM_VALPAR').Value := CorrigeDadosBanco(LRegistroRecebivel.FValorParcela, varDouble);
      ADataSet.ParamByName('PGM_TAXPAR').Value := CorrigeDadosBanco(LRegistroRecebivel.FTaxaParcela, varDouble);
      ADataSet.ParamByName('PGM_TAXANT').Value := CorrigeDadosBanco(LRegistroRecebivel.FTaxaAntecipacao, varDouble);
      If ADataSet.SQL.Contains('PGM_ID_ANT') Then
        ADataSet.ParamByName('PGM_ID_ANT').Value := CorrigeDadosBanco(LRegistroRecebivel.FAntecipacao_ID);
      ADataSet.ParamByName('PGM_TAXFRA').Value := CorrigeDadosBanco(LRegistroRecebivel.FTaxaAntiFraude, varDouble);
      ADataSet.ParamByName('PGM_DTACAD').Value := CorrigeDadosBanco(LRegistroRecebivel.FDataCadastro, varDate);
      ADataSet.ParamByName('PGM_DTAVEN').Value := CorrigeDadosBanco(LRegistroRecebivel.FDataVencimento, varDate);
      ADataSet.ParamByName('PGM_RECEBE').Value := CorrigeDadosBanco(LRegistroRecebivel.FRecebedor);
      ADataSet.ParamByName('PGM_METPAG').Value := CorrigeDadosBanco(LRegistroRecebivel.FMetodoPagamento);


      if LRegistroRecebivel.FStatus = 'paid' then
      begin
        ADataSet.ParamByName('PGM_DTAPAG').Value := CorrigeDadosBanco(LRegistroRecebivel.FDataPagamento, varDate);
        ADataSet.ParamByName('PGM_VALPAG').Value := RetornarValorPagoDaParcela(LRegistroRecebivel);
      end
      else
      begin
        ADataSet.ParamByName('PGM_DTAPAG').Value := Null;
        ADataSet.ParamByName('PGM_VALPAG').Value := 0.00;
      end;

      ADataSet.ParamByName('PGM_JSOREC').Value := CorrigeDadosBanco(LRegistroRecebivel.FJsonRecebido);
      ADataSet.ParamByName('PGM_KEYAPI').Value := CorrigeDadosBanco(LRegistroRecebivel.FKeyApi);
      ADataSet.ParamByName('PGM_DTAIMP').AsDateTime := CorrigeDadosBanco(DATE);

      ADataSet.ExecSQL;
      pgbProg.Position := pgbProg.Position + 1;
      Application.ProcessMessages;
    End;
    FPagarMeRegistrosRecebiveis.Clear;

  Except
    On E: Exception Do
    begin
      FImportouRecebiveis := False;
      Raise Exception.Create(E.Message);
    end;
  End;
end;

procedure TPagarMePgto.ImportarRecebiveis(strString: String; pgbProg: TProgressBar);
Var
  LRegistro: TPagarMeRegistroRecebiveis;
  LJsonRetorno:      TJsonObject;
  LJsonObjectValue:  TJsonObject;
  LJsonArrayContent: TJSONArray;
  LJsonValueContent: TJsonValue;
  LDataVencimento: String;
begin
  try
    LJsonRetorno := TJSONObject.ParseJSONValue(strString) as TJSONObject;
    try
      LJsonArrayContent := LJsonRetorno.GetValue('data') as TJsonArray;

      pgbProg.Position := 0;
      pgbProg.Max := LJsonArrayContent.Count;

      for LJsonValueContent in LJsonArrayContent do
      begin
        LJsonObjectValue := TJSONObject.ParseJSONValue(LJsonValueContent.ToString) as TJSONObject;

        LRegistro := TPagarMeRegistroRecebiveis.Create;

        LRegistro.FJsonRecebido     := PrettyJSON(LJsonObjectValue);
        LRegistro.FRecebivel_ID     := RetornaValorJson(LJsonObjectValue,'id');
        LRegistro.FGateWay_ID       := RetornaValorJson(LJsonObjectValue,'gateway_id');
        LRegistro.FCobranca_ID      := RetornaValorJson(LJsonObjectValue,'charge_id');
        LRegistro.FAntecipacao_ID   := RetornaValorJson(LJsonObjectValue,'bulk_anticipation_id');
        LRegistro.FTipoRecebimento  := RetornaValorJson(LJsonObjectValue,'type');
        LRegistro.FStatus           := RetornaValorJson(LJsonObjectValue,'status');
        LRegistro.FNumeroParcela    := RetornaValorJson(LJsonObjectValue,'installment');
        if LRegistro.FNumeroParcela.IsEmpty then
          LRegistro.FNumeroParcela := '1';

        LRegistro.FValorParcela     := RetornaValorJson(LJsonObjectValue,'amount');
        LRegistro.FTaxaParcela      := RetornaValorJson(LJsonObjectValue,'fee');
        LRegistro.FTaxaAntecipacao  := RetornaValorJson(LJsonObjectValue,'anticipation_fee');
        LRegistro.FTaxaAntiFraude   := RetornaValorJson(LJsonObjectValue,'fraud_coverage_fee');
        LRegistro.FDataCadastro     := RetornaValorJson(LJsonObjectValue,'created_at');
        LRegistro.FDataPagamento    := RetornaValorJson(LJsonObjectValue,'payment_date');
        LDataVencimento             := RetornaValorJson(LJsonObjectValue,'original_payment_date');
        LRegistro.FRecebedor        := RetornaValorJson(LJsonObjectValue,'recipient_id');
        LRegistro.FMetodoPagamento  := RetornaValorJson(LJsonObjectValue,'payment_method');


        if Trim(LDataVencimento).IsEmpty then
          LDataVencimento := RetornaValorJson(LJsonObjectValue,'payment_date');

        LRegistro.FDataVencimento := LDataVencimento;
        LRegistro.FKeyApi := LKeyAPi;

        FreeAndNil(LJsonObjectValue);
        FPagarMeRegistrosRecebiveis.Add(LRegistro);
        pgbProg.Position := pgbProg.Position + 1;
      end;
      pgbProg.Position := 0;
    finally
      if Assigned(LJsonRetorno) then
        FreeAndNil(LJsonRetorno);
    end;

  except
    On E:Exception do
      Raise Exception.Create(E.Message);
  end;
end;

procedure TPagarMePgto.ImportarTransferencias(AJson: String; pgbProg: TProgressBar);
Var
  LRegistro: TPagarMeRegistroTransferencia;
  LJsonRetorno:       TJsonObject;
  LJsonObjectValue:   TJsonObject;
  LJsonArrayContent:  TJSONArray;
  LJsonValueContent:  TJsonValue;
  LMovementObject, LBankAccountObject: TJsonObject;
begin
  try
    LJsonRetorno := TJSONObject.ParseJSONValue(AJson) as TJSONObject;
    try
      LJsonArrayContent := LJsonRetorno.GetValue('data') as TJsonArray;

      pgbProg.Position := 0;
      pgbProg.Max := LJsonArrayContent.Count;

      for LJsonValueContent in LJsonArrayContent do
      begin
        LJsonObjectValue := TJSONObject.ParseJSONValue(LJsonValueContent.ToString) as TJSONObject;

        LRegistro := TPagarMeRegistroTransferencia.Create;

        LRegistro.FJsonRecebido        := PrettyJSON(LJsonObjectValue);
        LRegistro.FTransferencia_ID    := RetornaValorJson(LJsonObjectValue, 'id');
        LRegistro.FTipoRegistro        := RetornaValorJson(LJsonObjectValue, 'type');
        LRegistro.FStatus              := RetornaValorJson(LJsonObjectValue, 'status');
        LRegistro.FValorTransferencia  := RetornaValorJson(LJsonObjectValue, 'amount');
        LRegistro.FDataCadastro        := RetornaValorJson(LJsonObjectValue, 'created_at');
        LRegistro.FTaxaTransferencia   := RetornaValorJson(LJsonObjectValue,  'fee');

        LMovementObject := LJsonObjectValue.GetValue<TJSONObject>('movement_object') as TJsonObject;
        LRegistro.FSource_ID         := RetornaValorJson(LMovementObject,  'source_id');
        if LRegistro.FSource_ID.Trim.IsEmpty then
          LRegistro.FSource_ID         := RetornaValorJson(LMovementObject,  'recipient_id');

        LRegistro.FTargetType        := RetornaValorJson(LMovementObject,  'target_type');
        LRegistro.FTipoTransferencia := RetornaValorJson(LMovementObject,  'type');
        if not (LRegistro.FTipoTransferencia.Equals('boleto') and
                LRegistro.FTipoRegistro.Equals('refund'))then
          LRegistro.FTaxaTransferencia := RetornaValorJson(LMovementObject,  'fee');

        LRegistro.FDescricao         := RetornaValorJson(LMovementObject,  'description');
        LRegistro.FDataCredito       := RetornaValorJson(LMovementObject,  'payment_date');
        if LRegistro.FDataCredito.Trim.IsEmpty then
          LRegistro.FDataCredito     := RetornaValorJson(LMovementObject,  'payment_date '); //Alguns registros estão vindo com espaço ao final do payment_date

        if LRegistro.FDataCredito.Trim.IsEmpty then
          LRegistro.FDataCredito     := RetornaValorJson(LMovementObject,  'funding_date');


        if LRegistro.FTargetType.Equals('bank_account') then
        begin
          LBankAccountObject := LMovementObject.GetValue<TJSONObject>('bank_account') as TJsonObject;
          LRegistro.FTitular           := RetornaValorJson(LBankAccountObject, 'holder_name');
          LRegistro.FCodigoBanco       := RetornaValorJson(LBankAccountObject, 'bank');
          LRegistro.FAgencia           := RetornaValorJson(LBankAccountObject, 'branch_number');
          LRegistro.FConta             := RetornaValorJson(LBankAccountObject, 'account_number');
          LRegistro.FDigitoConta       := RetornaValorJson(LBankAccountObject, 'account_check_digit');
        end;

        LRegistro.FKeyApi := LKeyAPi;

        FreeAndNil(LJsonObjectValue);
        FPagarMeRegistrosTransferencias.Add(LRegistro);
        pgbProg.Position := pgbProg.Position + 1;
      end;
      pgbProg.Position := 0;
    finally
      if Assigned(LJsonRetorno) then
        FreeAndNil(LJsonRetorno);
    end;
  except
    On E:Exception do
      Raise Exception.Create(E.Message);
  end;
end;

procedure TPagarMePgto.GravarTransferencias(var ADataSet: IDataSet; pgbProg: TProgressBar);
var
  LRegistroTransferencia: TPagarMeRegistroTransferencia;
  LSQL: String;
begin
  if FPagarMeRegistrosTransferencias.Count < 1 then
    Exit;

  LSQL := RetornaSQLReplace('PGM_PMTRAN',
                            RetornaListaDeCampos(fRetEstruturaPgto('PGM_PMTRAN')),
                            ['PGM_CONCIL']);

  ADataSet := objFunctions.fGetDataSet;
  ADataSet.Close;
  ADataSet.SQL := LSQL;

  pgbProg.Position := 0;
  pgbProg.Max := FPagarMeRegistrosTransferencias.Count;
  try
    For LRegistroTransferencia In FPagarMeRegistrosTransferencias Do
    Begin
      FImportouTransferencias := True;

      ADataSet.ParamByName('PGM_ID_TRF').Value := CorrigeDadosBanco(LRegistroTransferencia.FTransferencia_ID);
      ADataSet.ParamByName('PGM_TIPREG').Value := CorrigeDadosBanco(LRegistroTransferencia.FTipoRegistro);
      ADataSet.ParamByName('PGM_STATUS').Value := CorrigeDadosBanco(LRegistroTransferencia.FStatus);
      ADataSet.ParamByName('PGM_VALTRF').Value := CorrigeDadosBanco(LRegistroTransferencia.FValorTransferencia, varDouble);
      ADataSet.ParamByName('PGM_TAXTRF').Value := CorrigeDadosBanco(LRegistroTransferencia.FTaxaTransferencia, varDouble);
      ADataSet.ParamByName('PGM_SOURCE').Value := CorrigeDadosBanco(LRegistroTransferencia.FSource_ID);
      ADataSet.ParamByName('PGM_TARGET').Value := CorrigeDadosBanco(LRegistroTransferencia.FTargetType);
      ADataSet.ParamByName('PGM_DTATRF').Value := CorrigeDadosBanco(LRegistroTransferencia.FDataCadastro, varDate);
      ADataSet.ParamByName('PGM_DTACRE').Value := CorrigeDadosBanco(LRegistroTransferencia.FDataCredito, varDate);
      ADataSet.ParamByName('PGM_DESCRI').Value := CorrigeDadosBanco(LRegistroTransferencia.FDescricao);
      ADataSet.ParamByName('PGM_TITULA').Value := CorrigeDadosBanco(LRegistroTransferencia.FTitular);
      ADataSet.ParamByName('PGM_CODBCO').Value := CorrigeDadosBanco(LRegistroTransferencia.FCodigoBanco);
      ADataSet.ParamByName('PGM_AGENCI').Value := CorrigeDadosBanco(LRegistroTransferencia.FAgencia);
      ADataSet.ParamByName('PGM_NUMCTA').Value := CorrigeDadosBanco(LRegistroTransferencia.FConta +
                                                                    IIF(LRegistroTransferencia.FDigitoConta.Trim.IsEmpty,
                                                                        '',
                                                                        '-' + LRegistroTransferencia.FDigitoConta));
      ADataSet.ParamByName('PGM_JSOREC').Value := CorrigeDadosBanco(LRegistroTransferencia.FJsonRecebido);
      ADataSet.ParamByName('PGM_KEYAPI').Value := CorrigeDadosBanco(LRegistroTransferencia.FKeyApi);
      ADataSet.ParamByName('PGM_TIPTRF').Value := CorrigeDadosBanco(LRegistroTransferencia.FTipoTransferencia);
      ADataSet.ParamByName('PGM_DTAIMP').Value := CorrigeDadosBanco(DATE);

      ADataSet.ExecSQL;
      pgbProg.Position := pgbProg.Position + 1;
      Application.ProcessMessages;
    End;
    FPagarMeRegistrosTransferencias.Clear;

  Except
    On E: Exception Do
    begin
      FImportouTransferencias := False;
      Raise Exception.Create(E.Message);
    end;
  End;
end;

procedure TPagarMePgto.ImportaCobranca(strString: String;pgbProg: TProgressBar);
  Var
    LRegistro: TPagarMeRegistroCobranca;
    LJsonObjectValue,
    LJsonRetorno,
    LJsonMetaData: TJsonObject;
    LJsonArrayContent: TJSONArray;
    LJsonValueContent: TJsonValue;
begin
  Try
    LJsonRetorno := TJSONObject.ParseJSONValue(strString) as TJSONObject;
    LJsonArrayContent := LJsonRetorno.GetValue('data') as TJsonArray;

    pgbProg.Position := 0;
    pgbProg.Max := LJsonArrayContent.Count;

    For LJsonValueContent In LJsonArrayContent Do
    Begin
      LJsonObjectValue := TJSONObject.ParseJSONValue(LJsonValueContent.ToString) as TJSONObject;

      LRegistro := TPagarMeRegistroCobranca.Create;
      LRegistro.FJson := PrettyJSON(LJsonObjectValue);
      LRegistro.FCobranca_ID := RetornaValorJson(LJsonObjectValue,'id');
      LRegistro.FGateway_ID  := RetornaValorJson(LJsonObjectValue,'gateway_id');
      LRegistro.FDataPagamento :=  RetornaValorJson(LJsonObjectValue,'paid_at');
      LRegistro.FNumPok := RetornaValorJson(LJsonObjectValue,'code');
      LRegistro.FDataVenda := RetornaValorJson(LJsonObjectValue,'created_at');
      LRegistro.FValorBruto := RetornaValorJson(LJsonObjectValue,'amount');
      LRegistro.FValorLiquido := RetornaValorJson(LJsonObjectValue,'paid_amount');
      LRegistro.FStatus := RetornaValorJson(LJsonObjectValue,'status');

      if LJsonObjectValue.TryGetValue<TJSONObject>('metadata', LJsonMetaData) then
       LRegistro.FOrigem := RetornaValorJson(LJsonMetaData,'platform');

      LJsonObjectValue := LJsonObjectValue.GetValue<TJSONObject>('last_transaction') as TJSONObject;

      LRegistro.FTotalParcelas :=  RetornaValorJson(LJsonObjectValue,'installments');
      If FEmptyStr(LRegistro.FTotalParcelas) Then
        LRegistro.FTotalParcelas := '01';

      LRegistro.FNumeroNSU := RetornaValorJson(LJsonObjectValue,'acquirer_nsu');
      LRegistro.FParcela := '01';
      LRegistro.FAutorizacao :=  RetornaValorJson(LJsonObjectValue,'acquirer_auth_code');
      LRegistro.FKeyApi := LKeyAPi;
      LRegistro.FMeioPagamento := RetornaValorJson(LJsonObjectValue,'transaction_type');

      If LRegistro.FMeioPagamento = 'credit_card' Then
      Begin
        LJsonObjectValue := LJsonObjectValue.GetValue<TJSONObject>('card') as TJSONObject;
        LRegistro.FTipoRegistro := RetornaValorJson(LJsonObjectValue,'type');
        LRegistro.FBandeira :=RetornaValorJson(LJsonObjectValue,'brand');
        LRegistro.FCartao := RetornaValorJson(LJsonObjectValue,'first_six_digits') + '*********' +
                             RetornaValorJson(LJsonObjectValue,'last_four_digits');
      End;

      FreeAndNil(LJsonObjectValue);
      FPagarMeRegistrosCobranca.Add(LRegistro);
      AdicionarParcelas(LRegistro);
      pgbProg.Position := pgbProg.Position + 1;
    End;
    pgbProg.Position := 0;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TPagarMePgto.ImportaTransacoes(strString: String;pgbProg: TProgressBar);
  Var
    LRegistro: TPagarMeRegistroPgto;
    LJsonObjectValue: TJsonObject;
    LJsonArrayContent: TJSONArray;
    LJsonValueContent: TJsonValue;
begin

  Try
    LJsonArrayContent := TJSONObject.ParseJSONValue(strString) as TJsonArray;

    pgbProg.Position := 0;
    pgbProg.Max := LJsonArrayContent.Count;

    For LJsonValueContent In LJsonArrayContent Do
    Begin
      LJsonObjectValue := TJSONObject.ParseJSONValue(LJsonValueContent.ToString) as TJSONObject;

      LRegistro := TPagarMeRegistroPgto.Create;
      LRegistro.aJson                      := PrettyJSON(LJsonObjectValue);
      LRegistro.Aobject                    := RetornaValorJson(LJsonObjectValue,'object');
      LRegistro.Astatus                    := RetornaValorJson(LJsonObjectValue,'status');
      LRegistro.Arefuse_reason             := RetornaValorJson(LJsonObjectValue,'refuse_reason');
      LRegistro.Astatus_reason             := RetornaValorJson(LJsonObjectValue,'status_reason');
      LRegistro.Aacquirer_response_code    := RetornaValorJson(LJsonObjectValue,'acquirer_response_code');
      LRegistro.Aacquirer_response_message := RetornaValorJson(LJsonObjectValue,'acquirer_response_message');
      LRegistro.Aacquirer_name             := RetornaValorJson(LJsonObjectValue,'acquirer_name');
      LRegistro.Aacquirer_id               := RetornaValorJson(LJsonObjectValue,'acquirer_id');
      LRegistro.Aauthorization_code        := RetornaValorJson(LJsonObjectValue,'authorization_code');
      LRegistro.Asoft_descriptor           := RetornaValorJson(LJsonObjectValue,'soft_descriptor');
      LRegistro.Atid                       := RetornaValorJson(LJsonObjectValue,'tid');
      LRegistro.Ansu                       := RetornaValorJson(LJsonObjectValue,'nsu');
      LRegistro.Adate_created              := RetornaValorJson(LJsonObjectValue,'date_created');
      LRegistro.Adate_updated              := RetornaValorJson(LJsonObjectValue,'date_updated');
      LRegistro.Aamount                    := RetornaValorJson(LJsonObjectValue,'amount');
      LRegistro.Aauthorized_amount         := RetornaValorJson(LJsonObjectValue,'authorized_amount');
      LRegistro.Apaid_amount               := RetornaValorJson(LJsonObjectValue,'paid_amount');
      LRegistro.Arefunded_amount           := RetornaValorJson(LJsonObjectValue,'refunded_amount');
      LRegistro.Ainstallments              := RetornaValorJson(LJsonObjectValue,'installments');
      LRegistro.Aid                        := RetornaValorJson(LJsonObjectValue,'id');
      LRegistro.Acost                      := RetornaValorJson(LJsonObjectValue,'cost');
      LRegistro.Acard_holder_name          := RetornaValorJson(LJsonObjectValue,'card_holder_name');
      LRegistro.Acard_last_digits          := RetornaValorJson(LJsonObjectValue,'card_last_digits');
      LRegistro.Acard_first_digits         := RetornaValorJson(LJsonObjectValue,'card_first_digits');
      LRegistro.Acard_brand                := RetornaValorJson(LJsonObjectValue,'card_brand');
      LRegistro.Acard_pin_mode             := RetornaValorJson(LJsonObjectValue,'card_pin_mode');
      LRegistro.Acard_magstripe_fallback   := RetornaValorJson(LJsonObjectValue,'card_magstripe_fallback');
      LRegistro.Acvm_pin                   := RetornaValorJson(LJsonObjectValue,'cvm_pin');
      LRegistro.Apostback_url              := RetornaValorJson(LJsonObjectValue,'postback_url');
      LRegistro.Apayment_method            := RetornaValorJson(LJsonObjectValue,'payment_method');
      LRegistro.Acapture_method            := RetornaValorJson(LJsonObjectValue,'capture_method');
      LRegistro.Aantifraud_score           := RetornaValorJson(LJsonObjectValue,'antifraud_score');
      LRegistro.Aboleto_url                := RetornaValorJson(LJsonObjectValue,'antifraud_score');
      LRegistro.Areferer                   := RetornaValorJson(LJsonObjectValue,'referer');
      LRegistro.Aip                        := RetornaValorJson(LJsonObjectValue,'ip');
      LRegistro.Asubscription_id           := RetornaValorJson(LJsonObjectValue,'subscription_id');
      LRegistro.AKeyApi                    := LKeyAPi;
      FreeAndNil(LJsonObjectValue);

      FPagarMeRegistrosPgto.Add(LRegistro);
      pgbProg.Position := pgbProg.Position + 1;
    End;
    pgbProg.Position := 0;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TPagarMePgto.ImportaVendas(strString: String;pgbProg: TProgressBar);
  Var
    LRegistro: TPagarMeRegistroVendas;
    LJsonObjectValue: TJsonObject;
    LJsonArrayContent: TJSONArray;
    LJsonValueContent: TJsonValue;
begin

  Try
    LJsonArrayContent := TJSONObject.ParseJSONValue(strString) as TJsonArray;

    pgbProg.Position := 0;
    pgbProg.Max := LJsonArrayContent.Count;

    For LJsonValueContent In LJsonArrayContent Do
    Begin
      LJsonObjectValue := TJSONObject.ParseJSONValue(LJsonValueContent.ToString) as TJSONObject;

      LRegistro := TPagarMeRegistroVendas.Create;

      LRegistro.aJson                       := PrettyJSON(LJsonObjectValue);
      LRegistro.Aobject                     := RetornaValorJson(LJsonObjectValue,'object');
      LRegistro.Aid                         := RetornaValorJson(LJsonObjectValue,'id');
      LRegistro.Astatus                     := RetornaValorJson(LJsonObjectValue,'status');
      LRegistro.Aamount                     := RetornaValorJson(LJsonObjectValue,'amount');
      LRegistro.Afee                        := RetornaValorJson(LJsonObjectValue,'fee');
      LRegistro.Aanticipation_fee           := RetornaValorJson(LJsonObjectValue,'anticipation_fee');
      LRegistro.Afraud_coverage_fee         := RetornaValorJson(LJsonObjectValue,'fraud_coverage_fee');
      LRegistro.Ainstallment                := RetornaValorJson(LJsonObjectValue,'installment');
      LRegistro.Atransaction_id             := RetornaValorJson(LJsonObjectValue,'transaction_id');
      LRegistro.Asplit_rule_id              := RetornaValorJson(LJsonObjectValue,'split_rule_id');
      LRegistro.Abulk_anticipation_id       := RetornaValorJson(LJsonObjectValue,'bulk_anticipation_id');
      LRegistro.Aanticipation_id            := RetornaValorJson(LJsonObjectValue,'anticipation_id');
      LRegistro.Arecipient_id               := RetornaValorJson(LJsonObjectValue,'recipient_id');
      LRegistro.Aoriginator_model           := RetornaValorJson(LJsonObjectValue,'originator_model');
      LRegistro.Aoriginator_model_id        := RetornaValorJson(LJsonObjectValue,'originator_model_id');
      LRegistro.Apayment_date               := RetornaValorJson(LJsonObjectValue,'payment_date');
      LRegistro.Aoriginal_payment           := RetornaValorJson(LJsonObjectValue,'original_payment');
      LRegistro.Atype                       := RetornaValorJson(LJsonObjectValue,'type');
      LRegistro.Apayment_method             := RetornaValorJson(LJsonObjectValue,'payment_method');
      LRegistro.Aaccrual_date               := RetornaValorJson(LJsonObjectValue,'accrual_date');
      LRegistro.Adate_created               := RetornaValorJson(LJsonObjectValue,'date_created');
      LRegistro.Aliquidation_arrangement_id := RetornaValorJson(LJsonObjectValue,'liquidation_arrangement_id');

      FreeAndNil(LJsonObjectValue);

      FPagarMeRegistrosVendas.Add(LRegistro);
      pgbProg.Position := pgbProg.Position + 1;
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TPagarMePgto.pAdicionaLinha(strString: String; pgbProg: TProgressBar);
begin

  If strString.Trim.IsEmpty Then
    Exit;

  Try

    If MatchStr(FTipoDoArquivo,['Pagamentos','Reembolsos'])  Then
    Begin
      ImportaTransacoes(strString,pgbProg);
    End Else
    If MatchStr(FTipoDoArquivo,['VendasPagas','VendasReembolsadas'])Then
    Begin
      ImportaVendas(strString,pgbProg);
    End
    Else If MatchStr(FTipoDoArquivo,['Cobrancas'])Then
    Begin
      ImportaCobranca(strString,pgbProg);
    End
    Else If MatchStr(FTipoDoArquivo, ['Recebiveis']) Then
    begin
      ImportarRecebiveis(strString, pgbProg);
    end
    else if MatchStr(FTipoDoArquivo, ['Transferencias']) then
    begin
      ImportarTransferencias(strString, pgbProg);
    end;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TPagarMePgto.pAdicionaLinha(strString: String);
begin
 // Interface
end;

procedure TPagarMePgto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    LDados: IDataSet;
    LSQL: String;
    LRegistro: TPagarMeRegistroPgto;
    LRegistroVendas: TPagarMeRegistroVendas;
    LRegistroCobranca: TPagarMeRegistroCobranca;
begin
  LSQL := RetornaSQLReplaceTabela('PGM_PMPGTO');

  LDados := objFunctions.fGetDataSet;
  LDados.Close;
  LDados.SQL := LSQL;

  pgbProg.Position := 0;

  pgbProg.Max := FPagarMeRegistrosPgto.Count;

  For LRegistro In FPagarMeRegistrosPgto Do
  Begin
    Try
      FImportouPagamento := True;
      FImportouRegistro := True;

      LDados.ParamByName('PGM_OBJECT').Value := CorrigeDadosBanco(LRegistro.Aobject);
      LDados.ParamByName('PGM_STATUS').Value := CorrigeDadosBanco(LRegistro.Astatus);
      LDados.ParamByName('PGM_REFREA').Value := CorrigeDadosBanco(LRegistro.Arefuse_reason);
      LDados.ParamByName('PGM_STAREA').Value := CorrigeDadosBanco(LRegistro.Astatus_reason);
      LDados.ParamByName('PGM_ACQCOD').Value := CorrigeDadosBanco(LRegistro.Aacquirer_response_code);

      LDados.ParamByName('PGM_ACQMES').Value := CorrigeDadosBanco(LRegistro.Aacquirer_response_message);
      LDados.ParamByName('PGM_ACQNAM').Value := CorrigeDadosBanco(LRegistro.Aacquirer_name);
      LDados.ParamByName('PGM_ACQ_ID').Value := CorrigeDadosBanco(LRegistro.Aacquirer_id);
      LDados.ParamByName('PGM_CODAUT').Value := CorrigeDadosBanco(LRegistro.Aauthorization_code);
      LDados.ParamByName('PGM_SOFDES').Value := CorrigeDadosBanco(LRegistro.Asoft_descriptor);


      LDados.ParamByName('PGM_CODTID').Value := CorrigeDadosBanco(LRegistro.Atid);
      LDados.ParamByName('PGM_NUMNSU').Value := CorrigeDadosBanco(LRegistro.Ansu);
      LDados.ParamByName('PGM_DTACRE').Value := CorrigeDadosBanco(LRegistro.Adate_created);
      LDados.ParamByName('PGM_DTAUPD').Value := CorrigeDadosBanco(LRegistro.Adate_updated);

      LDados.ParamByName('PGM_VALPAG').Value := CorrigeDadosBanco(LRegistro.Aamount,varDouble);
      LDados.ParamByName('PGM_PAGAUT').Value := CorrigeDadosBanco(LRegistro.Aauthorized_amount,varDouble);
      LDados.ParamByName('PGM_QTDPAG').Value := CorrigeDadosBanco(LRegistro.Apaid_amount,varDouble);
      LDados.ParamByName('PGM_REFPAG').Value := CorrigeDadosBanco(LRegistro.Arefunded_amount,varDouble);
      LDados.ParamByName('PGM_TOTPAR').Value := CorrigeDadosBanco(LRegistro.Ainstallments);

      LDados.ParamByName('PGM_TRA_ID').Value := CorrigeDadosBanco(LRegistro.Atid);
      LDados.ParamByName('PGM_NUMCAR').Value := CorrigeDadosBanco(LRegistro.Acard_first_digits + '*********' + LRegistro.Acard_last_digits);
      LDados.ParamByName('PGM_BANDEI').Value := CorrigeDadosBanco(LRegistro.Acard_brand);
      LDados.ParamByName('PGM_PAYMET').Value := CorrigeDadosBanco(LRegistro.Apayment_method);
      LDados.ParamByName('PGM_CAPMET').Value := CorrigeDadosBanco(LRegistro.Acapture_method);

      LDados.ParamByName('PGM_JSOREC').Value := CorrigeDadosBanco(LRegistro.AJson);
      LDados.ParamByName('PGM_DTAIMP').Value := CorrigeDadosBanco(DATE);
      LDados.ParamByName('PGM_KEYAPI').Value := CorrigeDadosBanco(LRegistro.AKeyApi);

      LDados.ExecSQL;
      pgbProg.Position := pgbProg.Position + 1;
      Application.ProcessMessages;
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  End;


  //***********************************VENDAS*******************************************
  LSQL := RetornaSQLReplaceTabela('PGM_PMVEND');

  LDados := objFunctions.fGetDataSet;
  LDados.Close;
  LDados.SQL := LSQL;

  pgbProg.Position := 0;
  pgbProg.Max := FPagarMeRegistrosVendas.Count;

  For LRegistroVendas In FPagarMeRegistrosVendas Do
  Begin
    Try
      FImportouPagamento := True;
      FImportouRegistro := True;


      LDados.ParamByName('PGM_OBJECT').Value := CorrigeDadosBanco(LRegistroVendas.Aobject);
      LDados.ParamByName('PGM_VEN_ID').Value := CorrigeDadosBanco(LRegistroVendas.Aid);
      LDados.ParamByName('PGM_STATUS').Value := CorrigeDadosBanco(LRegistroVendas.Astatus);

      LDados.ParamByName('PGM_VALPAG').Value := CorrigeDadosBanco(LRegistroVendas.Aamount,varDouble);
      LDados.ParamByName('PGM_VALTAX').Value := CorrigeDadosBanco(LRegistroVendas.Afee,varDouble);
      LDados.ParamByName('PGM_TAXANT').Value := CorrigeDadosBanco(LRegistroVendas.Aanticipation_fee,varDouble);
      LDados.ParamByName('PGM_TAXFRA').Value := CorrigeDadosBanco(LRegistroVendas.Afraud_coverage_fee,varDouble);

      LDados.ParamByName('PGM_NUMPAR').Value := CorrigeDadosBanco(LRegistroVendas.Ainstallment,varInteger);

      LDados.ParamByName('PGM_TRA_ID').Value := CorrigeDadosBanco(LRegistroVendas.Atransaction_id);
      LDados.ParamByName('PGM_RUL_ID').Value := CorrigeDadosBanco(LRegistroVendas.Asplit_rule_id);
      LDados.ParamByName('PGM_BANTID').Value := CorrigeDadosBanco(LRegistroVendas.Abulk_anticipation_id);
      LDados.ParamByName('PGM_ANT_ID').Value := CorrigeDadosBanco(LRegistroVendas.Aanticipation_id);

      LDados.ParamByName('PGM_DES_ID').Value := CorrigeDadosBanco(LRegistroVendas.Arecipient_id);
      LDados.ParamByName('PGM_ORIMOD').Value := CorrigeDadosBanco(LRegistroVendas.Aoriginator_model);
      LDados.ParamByName('PGM_MOD_ID').Value := CorrigeDadosBanco(LRegistroVendas.Aoriginator_model_id);
      LDados.ParamByName('PGM_DTAPAG').Value := CorrigeDadosBanco(LRegistroVendas.Apayment_date);

      LDados.ParamByName('PGM_TIPREG').Value := CorrigeDadosBanco(LRegistroVendas.Atype);
      LDados.ParamByName('PGM_METPAG').Value := CorrigeDadosBanco(LRegistroVendas.Apayment_method);
      LDados.ParamByName('PGM_DTAACU').Value := CorrigeDadosBanco(LRegistroVendas.Aaccrual_date);
      LDados.ParamByName('PGM_DTACRE').Value := CorrigeDadosBanco(LRegistroVendas.Adate_created);
      LDados.ParamByName('PGM_ACO_ID').Value := CorrigeDadosBanco(LRegistroVendas.Aliquidation_arrangement_id);
      LDados.ParamByName('PGM_JSOREC').Value := CorrigeDadosBanco(LRegistroVendas.aJson);

      LDados.ExecSQL;
      pgbProg.Position := pgbProg.Position + 1;
      Application.ProcessMessages;
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  End;

  //***********************************COBRANÇA*******************************************
  LSQL := RetornaSQLReplace('PGM_PMCOBR',
                            RetornaListaDeCampos(fRetEstruturaPgto('PGM_PMCOBR')),
                            ['PGM_CONCIL']);

  LDados := objFunctions.fGetDataSet;
  LDados.Close;
  LDados.SQL := LSQL;

  pgbProg.Position := 0;
  pgbProg.Max := FPagarMeRegistrosCobranca.Count;

  For LRegistroCobranca In FPagarMeRegistrosCobranca Do
  Begin
    Try
      FImportouPagamento := True;
      FImportouRegistro := True;
      FImportouCobrancas := True;

      LDados.ParamByName('PGM_TIPREG').Value := CorrigeDadosBanco(LRegistroCobranca.FTipoRegistro);
      LDados.ParamByName('PGM_TOTPAR').Value := CorrigeDadosBanco(LRegistroCobranca.FTotalParcelas,varInteger);
      LDados.ParamByName('PGM_NUMNSU').Value := CorrigeDadosBanco(LRegistroCobranca.FNumeroNSU);
      LDados.ParamByName('PGM_NUMPAR').Value := CorrigeDadosBanco(LRegistroCobranca.FParcela,varInteger);
      LDados.ParamByName('PGM_CODAUT').Value := CorrigeDadosBanco(LRegistroCobranca.FAutorizacao);
      LDados.ParamByName('PGM_DTACRE').Value := CorrigeDadosBanco(LRegistroCobranca.FDataVenda,varDate);

      LDados.ParamByName('PGM_BRUPAR').Value := RetornaValorBrutoParcela(LRegistroCobranca);

      LDados.ParamByName('PGM_LIQPAR').Value := RetornaValorLiquidoParcela(LRegistroCobranca);

      LDados.ParamByName('PGM_NUMCAR').Value := CorrigeDadosBanco(LRegistroCobranca.FCartao);
      LDados.ParamByName('PGM_NUMPOK').Value := CorrigeDadosBanco(LRegistroCobranca.FNumPok);
      LDados.ParamByName('PGM_BANDEI').Value := CorrigeDadosBanco(LRegistroCobranca.FBandeira);
      LDados.ParamByName('PGM_DTAPAG').Value := LeftStr(LRegistroCobranca.FDataPagamento, 10);
      LDados.ParamByName('PGM_METPAG').Value := CorrigeDadosBanco(LRegistroCobranca.FMeioPagamento);
      LDados.ParamByName('PGM_JSOREC').Value := CorrigeDadosBanco(LRegistroCobranca.FJson);
      LDados.ParamByName('PGM_DTAIMP').Value := CorrigeDadosBanco(DATE);
      LDados.ParamByName('PGM_KEYAPI').Value := CorrigeDadosBanco(LRegistroCobranca.FKeyApi);
      LDados.ParamByName('PGM_STATUS').Value := CorrigeDadosBanco(LRegistroCobranca.FStatus);
      LDados.ParamByName('PGM_ORIGEM').Value := IIF(LRegistroCobranca.FOrigem.Trim.IsEmpty,
                                                    'site',
                                                    LRegistroCobranca.FOrigem);

      If LDados.SQL.Contains('PGM_ID_COB') Then
        LDados.ParamByName('PGM_ID_COB').Value := CorrigeDadosBanco(LRegistroCobranca.FCobranca_ID);
      If LDados.SQL.Contains('PGM_GATWAY') Then
        LDados.ParamByName('PGM_GATWAY').Value := CorrigeDadosBanco(LRegistroCobranca.FGateway_ID);


      LDados.ExecSQL;
      pgbProg.Position := pgbProg.Position + 1;
      Application.ProcessMessages;
    Except
      On E: Exception Do
      begin
        FImportouCobrancas := False;
        Raise Exception.Create(E.Message);
      end;
    End;
  End;
  FPagarMeRegistrosCobranca.Clear;

  //***********************************RECEBÍVEIS*******************************************
  GravarRecebiveis(LDados, pgbProg);

  GravarTransferencias(LDados, pgbProg);
end;

function TPagarMePgto.PrettyJSON(AJsonValue: TJsonValue): string;
var
  s: string;
  c: char;
  EOL: string;
  INDENT: string;
  LIndent: string;
  isEOL: boolean;
  isInString: boolean;
  isEscape: boolean;
begin
  EOL := #13#10;
  INDENT := '  ';
  isEOL := true;
  isInString := false;
  isEscape := false;
  Result := '';
  s := AJsonValue.ToString;
  for c in s do
  begin
    if not isInString and ((c = '{') or (c = '[')) then
    begin
      if not isEOL then
        Result := Result + EOL;
      Result := Result + LIndent + c + EOL;
      LIndent := LIndent + INDENT;
      Result := Result + LIndent;
      isEOL := true;
    end
    else if not isInString and (c = ',') then
    begin
      isEOL := false;
      Result := Result + c + EOL + LIndent;
    end
    else if not isInString and ((c = '}') or (c = ']')) then
    begin
      Delete(LIndent, 1, Length(INDENT));
      if not isEOL then
        Result := Result + EOL;
      Result := Result + LIndent + c + EOL;
      isEOL := true;
    end
    else
    begin
      isEOL := false;
      Result := Result + c;
    end;
    isEscape := (c = '\') and not isEscape;
    if not isEscape and (c = '"') then
      isInString := not isInString;
  end;
end;

function TPagarMePgto.RetornarIdCobrancasNaoEncontradas(ADataInicial, ADataFinal: TDateTime;
  AKeyApi: String): TStringList;
var
  LQuery: IDataSet;
begin
  Result := TStringList.Create;
  LQuery := objFunctions.fGetDataSet;
  try
    LQuery.Close;
    LQuery.SQL := 'SELECT                                      ' +
                  '  REC.PGM_ID_COB                            ' +
                  'FROM                                        ' +
                  '  PGM_PMRECE REC                            ' +
                  '  LEFT JOIN PGM_PMCOBR COB                  ' +
                  '    ON REC.PGM_ID_COB = COB.PGM_ID_COB      ' +
                  '    AND REC.PGM_KEYAPI = COB.PGM_KEYAPI     ' +
                  '    AND REC.PGM_NUMPAR = COB.PGM_NUMPAR     ' +
                  'WHERE IFNULL(REC.PGM_ID_COB, "") <> ""      ' +
                  '  AND REC.PGM_KEYAPI = :KEYAPI              ' +
                  '  AND (                                     ' +
                  '        REC.PGM_DTACAD BETWEEN :DTAINI AND :DTAFIN OR  ' +
                  '        REC.PGM_DTAPAG BETWEEN :DTAINI AND :DTAFIN     ' +
                  '      )                                     ' +
                  '  AND COB.PGM_ID_COB IS NULL                ' +
                  'GROUP BY REC.PGM_ID_COB                     ';

    LQuery.ParamByName('KEYAPI').AsString := AKeyApi;
    LQuery.ParamByName('DTAINI').AsDateTime := ADataInicial;
    LQuery.ParamByName('DTAFIN').AsDateTime := ADataFinal;
    LQuery.Open;
    LQuery.First;

    if LQuery.RecordCount < 1 then
      Exit;

    while not LQuery.EOF do
    begin
      Result.Add(LQuery.FieldByName('PGM_ID_COB').AsString);
      LQuery.Next;
    end;
  except
    On E: Exception do
      raise Exception.Create('Problemas ao buscar cobranças não encontradas. ' + E.Message);
  end;

end;

function TPagarMePgto.RetornarValorPagoDaParcela(
  ARecebivel: TPagarMeRegistroRecebiveis): Double;
begin
  Result := 0.00;

  if Trim(ARecebivel.FStatus) <> 'paid' then
    Exit;

  Result := CorrigeDadosBanco(ARecebivel.FValorParcela, varDouble);
  Result := Result - CorrigeDadosBanco(ARecebivel.FTaxaParcela, varDouble);
  Result := Result - CorrigeDadosBanco(ARecebivel.FTaxaAntecipacao, varDouble);
  Result := Result - CorrigeDadosBanco(ARecebivel.FTaxaAntiFraude, varDouble);
  Result := RoundTo(Result, -2);
end;

function TPagarMePgto.RetornaSQLReplaceTabela(ATabela: String): String;
  Var
    LCampos: TArrEstruturaPagarMePgto;

    LContador: Integer;
begin
  Result := 'REPLACE INTO ' + ATabela + ' (';

  LCampos := fRetEstruturaPgto(ATabela);

  For LContador := 0 to Length(LCampos) - 1 do
  Begin
    If (LCampos[LContador].strDescri <>  'PGM_CONCIL') Then
      Result := Result + LCampos[LContador].strDescri + ',';
  End;

  Result := Copy(Result, 1, Length(Result) - 1) + ') VALUES (';

  For LContador := 0 to Length(LCampos) - 1 do
  Begin
    If (LCampos[LContador].strDescri <> 'PGM_CONCIL') Then
      Result := Result + ':' + LCampos[LContador].strDescri + ',';
  End;
  Result := Copy(Result, 1, Length(Result) - 1) + ')';
end;

function TPagarMePgto.RetornaValorBrutoParcela(APagarMeRegistroCobranca: TPagarMeRegistroCobranca): Double;
  Var
    LValorBrutoVenda : Double;
    LDiferenca: Double;
begin
  Result := RoundTo(CorrigeDadosBanco(APagarMeRegistroCobranca.FValorBruto,varDouble) /
                    CorrigeDadosBanco(APagarMeRegistroCobranca.FTotalParcelas,varInteger),-2);

  LValorBrutoVenda := CorrigeDadosBanco(APagarMeRegistroCobranca.FTotalParcelas,varInteger) * Result;

  LDiferenca := CorrigeDadosBanco(APagarMeRegistroCobranca.FValorBruto,varDouble) - LValorBrutoVenda;

  {* Se tiver diferença, joga a mesma para a primeira parcela *}
  If (RoundTo(LDiferenca, -2) <> 0) Then
  Begin
    If (StrToInt(APagarMeRegistroCobranca.FParcela) = 1) Then
    Begin
      Result := RoundTo(Result + LDiferenca,-2);
    End;
  End;

end;


function TPagarMePgto.RetornaValorLiquidoParcela(APagarMeRegistroCobranca: TPagarMeRegistroCobranca): Double;
  Var
    LValorLiquidoVenda : Double;
    LDiferenca: Double;
begin
  Result := RoundTo(CorrigeDadosBanco(APagarMeRegistroCobranca.FValorLiquido,varDouble) /
                    CorrigeDadosBanco(APagarMeRegistroCobranca.FTotalParcelas,varInteger),-2);

  LValorLiquidoVenda := CorrigeDadosBanco(APagarMeRegistroCobranca.FTotalParcelas,varInteger) *  Result;

  LDiferenca :=  CorrigeDadosBanco(APagarMeRegistroCobranca.FValorLiquido,varDouble) - LValorLiquidoVenda;

  {* Se tiver diferença, joga a mesma para a primeira parcela *}
  If (RoundTo(LDiferenca, -2) <> 0) Then
  Begin
    If (StrToInt(APagarMeRegistroCobranca.FParcela) = 1) Then
    Begin
      Result := RoundTo(Result + LDiferenca,-2);
    End;
  End;

end;

function TPagarMePgto.RetornaValorJson(AObjeto: TJsonObject;
  ANomeCampo: String): String;
begin
  Try
    Result := '';
    If Assigned(AObjeto.GetValue(ANomeCampo)) Then
      Result := AObjeto.GetValue<string>(ANomeCampo);
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;


end.
