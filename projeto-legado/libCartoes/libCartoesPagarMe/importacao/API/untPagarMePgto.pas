unit untPagarMePgto;

interface
uses System.Classes, System.StrUtils, System.SysUtils, System.Variants,
     Vcl.ComCtrls, Vcl.Forms, System.Generics.Collections, System.Json,
     System.Math,

     Uni, cxProgressBar,

     untIPagarMeIntegracaoLibCartoes, untTPagarMeFuncoes, untPagarMeTipos;

Type
  TPagarMePgto = Class(TInterfacedObject, ICartoesPagarMe)
  Private
    FPagarMeRegistrosPgto: TObjectList<TPagarMeRegistroPgto>;
    FPagarMeRegistrosVendas: TObjectList<TPagarMeRegistroVendas>;
    FPagarMeRegistrosCobranca: TObjectList<TPagarMeRegistroCobranca>;
    FPagarMeRegistrosRecebiveis: TObjectList<TPagarMeRegistroRecebiveis>;
    FPagarMeRegistrosTransferencias: TObjectList<TPagarMeRegistroTransferencia>;

    FImportouRegistro,
    FImportouPagamento,
    FImportouRecebiveis,
    FImportouCobrancas: Boolean;
    LKeyApi: String;
    LCodEmpresa: String;
    LModeloAtualizado: Boolean;

    FTipoDoArquivo: String;
    FImportouTransferencias: Boolean;

    function CorrigeDadosBanco(AValor: Variant; varTipVar: TVarType = varString): Variant;

    function RetornaValorJson(AObjeto: TJsonObject; ANomeCampo: String): String; Overload;
    function PrettyJSON(AJsonValue: TJsonValue): string;

    procedure ImportaTransacoes(strString: String; pgbProg: TcxProgressBar);
    procedure ImportaVendas(strString: String;pgbProg: TcxProgressBar);
    procedure ImportaCobranca(strString: String; pgbProg: TcxProgressBar);
    procedure AdicionarParcelas(APagarMeRegistroCobranca: TPagarMeRegistroCobranca);
    function RetornaValorBrutoParcela(APagarMeRegistroCobranca: TPagarMeRegistroCobranca): Double;
    function RetornaValorLiquidoParcela(APagarMeRegistroCobranca: TPagarMeRegistroCobranca): Double;
    procedure ImportarRecebiveis(strString: String; pgbProg: TcxProgressBar);
    procedure GravarRecebiveis(var ADataSet: TUniQuery; pgbProg: TcxProgressBar);
    function RetornarValorPagoDaParcela(ARecebivel: TPagarMeRegistroRecebiveis): Double;
    procedure ImportarTransferencias(AJson: String; pgbProg: TcxProgressBar);
    procedure GravarTransferencias(var ADataSet: TUniQuery; pgbProg: TcxProgressBar);
  Public
    constructor Create;
    destructor Destroy; override;

    function RetornarIdCobrancasNaoEncontradas(ADataInicial, ADataFinal: TDateTime;
      AKeyApi: String): TStringList;

    procedure pAdicionaLinha(strString: String; pgbProg: TcxProgressBar);
    procedure pGravarRegistros(var pgbProg: TcxProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaPagarMePgto;

    property ImportouRegistro : Boolean                     Read FImportouRegistro;
    property ListaDePagamentos: TObjectList<TPagarMeRegistroPgto> Read FPagarMeRegistrosPgto;
    property ImportouPagamento: Boolean                     Read FImportouPagamento;
    property ImportouRecebiveis:Boolean                     Read FImportouRecebiveis;
    property ImportouCobrancas: Boolean                     Read FImportouCobrancas;
    property ImportouTransferencias: Boolean read FImportouTransferencias;
    property TipoDoArquivo    : String                      Read FTipoDoArquivo Write FTipoDoArquivo;
    property KeyApi           : String                      Read LKeyApi Write LKeyApi;
    property CodEmpresa       : String                      Read LCodEmpresa Write LCodEmpresa;
    property ModeloAtualizado : Boolean                     Read LModeloAtualizado Write LModeloAtualizado;
  End;

  Var
    NomeArquivo,
    DataArquivo: String;

implementation

{ TPagarMePgto }

procedure TPagarMePgto.AdicionarParcelas(APagarMeRegistroCobranca: TPagarMeRegistroCobranca);
  Var
    LRegistro: TPagarMeRegistroCobranca;
    LContador : Integer;
    LTotalParcelas: Integer;
begin
  LTotalParcelas := StrToInt(APagarMeRegistroCobranca.FTotalParcelas);

  If (LTotalParcelas = 1) Then
    Exit;

  For LContador := 2 To LTotalParcelas Do
  Begin
    LRegistro := TPagarMeRegistroCobranca.Create;

    LRegistro.FCobranca_ID  := APagarMeRegistroCobranca.FCobranca_ID;
    LRegistro.FGateway_ID   := APagarMeRegistroCobranca.FGateway_ID;
    LRegistro.FTipoRegistro := APagarMeRegistroCobranca.FTipoRegistro;
    LRegistro.FTotalParcelas := APagarMeRegistroCobranca.FTotalParcelas;
    LRegistro.FNumeroNSU := APagarMeRegistroCobranca.FNumeroNSU;
    LRegistro.FParcela :=  IntToStr(LContador);
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
    LRegistro.FOrderIntegrador := APagarMeRegistroCobranca.FOrderIntegrador;
    LRegistro.FOrderId := APagarMeRegistroCobranca.FOrderId;
    LRegistro.FCustomerId := APagarMeRegistroCobranca.FCustomerId;
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
                    If Not TPagarMeFuncoes.fEmptyStr(AValor) Then
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
                    If Not TPagarMeFuncoes.fEmptyStr(AValor) Then
                      Result := (TPagarMeFuncoes.fStrToFloat(AnsiReplaceStr(AValor, '.', ','))/100)
                    Else
                      Result := 0.00;
                  Except
                    Result := Null;
                  End;
                End;

      varDate:
                Begin
                  Try
                    If Not TPagarMeFuncoes.fEmptyStr(AValor) Then
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

  FPagarMeRegistrosPgto           := TObjectList<TPagarMeRegistroPgto>.Create;
  FPagarMeRegistrosVendas         := TObjectList<TPagarMeRegistroVendas>.Create;
  FPagarMeRegistrosCobranca       := TObjectList<TPagarMeRegistroCobranca>.Create;
  FPagarMeRegistrosRecebiveis     := TObjectList<TPagarMeRegistroRecebiveis>.Create;
  FPagarMeRegistrosTransferencias := TObjectList<TPagarMeRegistroTransferencia>.Create;
end;

destructor TPagarMePgto.Destroy;
begin
  FreeAndNil(FPagarMeRegistrosPgto);
  FreeAndNil(FPagarMeRegistrosVendas);
  FreeAndNil(FPagarMeRegistrosCobranca);
  FreeAndNil(FPagarMeRegistrosRecebiveis);
  FreeAndNil(FPagarMeRegistrosTransferencias);
  inherited;
end;

class function TPagarMePgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaPagarMePgto;
Begin
  If strTabela.Equals('PGM_PMCOBR') Then
  Begin
    SetLength(Result, 22);
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
    Result[21].strDescri  := 'PGM_ORDINT'; Result[21].strTipCmp  := 'VARCHAR(60)';
  end
  Else If strTabela.Equals('PGM_PMPGTO') Then
  Begin
    SetLength(Result, 28);

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

    Result[24].strDescri  := 'PGM_JSOREC'; Result[24].strTipCmp  := 'TEXT';
    Result[25].strDescri  := 'PGM_DTAIMP'; Result[25].strTipCmp  := 'DATE';
    Result[26].strDescri  := 'PGM_KEYAPI'; Result[26].strTipCmp  := 'TEXT';
    Result[27].strDescri  := 'PGM_IMPREC'; Result[27].strTipCmp  := 'VARCHAR(1)';

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

procedure TPagarMePgto.GravarRecebiveis(var ADataSet: TUniQuery; pgbProg: TcxProgressBar);
var
  LRegistroRecebivel: TPagarMeRegistroRecebiveis;
  LSQL: String;
begin
  LSQL := TPagarMeFuncoes.RetornaSQLReplace('PGM_PMRECE', ['PGM_CONCIL']);

  ADataSet.Close;
  ADataSet.SQL.Text := LSQL;

  pgbProg.Position := 0;
  pgbProg.Properties.Max := FPagarMeRegistrosRecebiveis.Count;
  TPagarMeFuncoes.pStepStatusGravacao(pgbProg, 'Aguarde... Gravando registros de recebíveis.', False);

  try
    For LRegistroRecebivel In FPagarMeRegistrosRecebiveis Do
    Begin
      FImportouRecebiveis := True;

      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_ID_REC', CorrigeDadosBanco(LRegistroRecebivel.FRecebivel_ID));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_GATWAY', CorrigeDadosBanco(LRegistroRecebivel.FGateWay_ID));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_ID_COB', CorrigeDadosBanco(LRegistroRecebivel.FCobranca_ID));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_TIPREC', CorrigeDadosBanco(LRegistroRecebivel.FTipoRecebimento));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_STATUS', CorrigeDadosBanco(LRegistroRecebivel.FStatus));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_NUMPAR', CorrigeDadosBanco(LRegistroRecebivel.FNumeroParcela, varInteger));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_VALPAR', CorrigeDadosBanco(LRegistroRecebivel.FValorParcela, varDouble));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_TAXPAR', CorrigeDadosBanco(LRegistroRecebivel.FTaxaParcela, varDouble));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_TAXANT', CorrigeDadosBanco(LRegistroRecebivel.FTaxaAntecipacao, varDouble));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_ID_ANT', CorrigeDadosBanco(LRegistroRecebivel.FAntecipacao_ID));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_TAXFRA', CorrigeDadosBanco(LRegistroRecebivel.FTaxaAntiFraude, varDouble));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_DTACAD', CorrigeDadosBanco(LRegistroRecebivel.FDataCadastro, varDate));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_DTAVEN', CorrigeDadosBanco(LRegistroRecebivel.FDataVencimento, varDate));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_RECEBE', CorrigeDadosBanco(LRegistroRecebivel.FRecebedor));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_METPAG', CorrigeDadosBanco(LRegistroRecebivel.FMetodoPagamento));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_JSOREC', CorrigeDadosBanco(LRegistroRecebivel.FJsonRecebido));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_KEYAPI', CorrigeDadosBanco(LRegistroRecebivel.FKeyApi));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_DTAIMP', CorrigeDadosBanco(VS_FuncoesExternas.fIGetVS_Date));

      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_DTAPAG', Null);
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_VALPAG', 0.00);
      if LRegistroRecebivel.FStatus = 'paid' then
      begin
        TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_DTAPAG', CorrigeDadosBanco(LRegistroRecebivel.FDataPagamento, varDate));
        TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_VALPAG', RetornarValorPagoDaParcela(LRegistroRecebivel));
      end;

      ADataSet.ExecSQL;
      TPagarMeFuncoes.pStepStatusGravacao(pgbProg);
    End;
    FPagarMeRegistrosRecebiveis.Clear;

  Except
    FImportouRecebiveis := False;
    Raise;
  End;
end;

procedure TPagarMePgto.ImportarRecebiveis(strString: String; pgbProg: TcxProgressBar);
Var
  LRegistro: TPagarMeRegistroRecebiveis;
  LJsonRetorno:      TJsonObject;
  LJsonObjectValue:  TJsonObject;
  LJsonArrayContent: TJSONArray;
  LJsonValueContent: TJsonValue;
  LDataVencimento: String;
begin
  LJsonRetorno := Nil;
  LJsonArrayContent := Nil;
  try
    LJsonRetorno := TJSONObject.ParseJSONValue(strString) as TJSONObject;
    If LJsonRetorno = Nil Then
      Exit;

    LJsonArrayContent := TJSONObject.ParseJSONValue(LJsonRetorno.GetValue('data').ToJson) as TJsonArray;

    pgbProg.Position := 0;
    pgbProg.Properties.Max := LJsonArrayContent.Count;

    for LJsonValueContent in LJsonArrayContent do
    begin
      LJsonObjectValue := TJSONObject.ParseJSONValue(LJsonValueContent.ToString.Replace('\ ', '-')) as TJSONObject;
      Try
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
      Finally
        FreeAndNil(LJsonObjectValue);
      End;

      FPagarMeRegistrosRecebiveis.Add(LRegistro);
      pgbProg.Position := pgbProg.Position + 1;
      TForm(pgbProg).Update;
    end;
    pgbProg.Position := 0;
  finally
    TPagarMeFuncoes.FreeAndNilObjeto(LJsonArrayContent);
    TPagarMeFuncoes.FreeAndNilObjeto(LJsonRetorno);
  end;
end;

procedure TPagarMePgto.ImportarTransferencias(AJson: String; pgbProg: TcxProgressBar);
Var
  LRegistro: TPagarMeRegistroTransferencia;
  LJsonRetorno:       TJsonObject;
  LJsonObjectValue:   TJsonObject;
  LJsonArrayContent:  TJSONArray;
  LJsonValueContent:  TJsonValue;
  LMovementObject, LBankAccountObject: TJsonObject;
begin
  LJsonRetorno := Nil;
  LJsonArrayContent := Nil;
  LMovementObject := Nil;
  LBankAccountObject := Nil;
  try
    LJsonRetorno := TJSONObject.ParseJSONValue(AJson) as TJSONObject;
    If LJsonRetorno = Nil Then
      Exit;

    LJsonArrayContent := TJSONObject.ParseJSONValue(LJsonRetorno.GetValue('data').ToJson) as TJsonArray;
    pgbProg.Position := 0;
    pgbProg.Properties.Max := LJsonArrayContent.Count;

    for LJsonValueContent in LJsonArrayContent do
    begin
      Try
        LJsonObjectValue := TJSONObject.ParseJSONValue(LJsonValueContent.ToString.Replace('\ ', '-')) as TJSONObject;
        LRegistro := TPagarMeRegistroTransferencia.Create;
        Try
          LRegistro.FJsonRecebido        := PrettyJSON(LJsonObjectValue);
          LRegistro.FTransferencia_ID    := RetornaValorJson(LJsonObjectValue, 'id');
          LRegistro.FStatus              := RetornaValorJson(LJsonObjectValue, 'status');
          LRegistro.FValorTransferencia  := RetornaValorJson(LJsonObjectValue, 'amount');

          If LModeloAtualizado  Then
          Begin
            LRegistro.FTipoTransferencia   := RetornaValorJson(LJsonObjectValue, 'product');
            LRegistro.FSource_ID           := RetornaValorJson(LJsonObjectValue, 'recipient_id');
            LRegistro.FTargetType          := RetornaValorJson(LJsonObjectValue, 'liquidation_type');
            LRegistro.FDataCadastro        := RetornaValorJson(LJsonObjectValue, 'payment_date');
            LRegistro.FDataCredito         := RetornaValorJson(LJsonObjectValue, 'payment_date');
            LRegistro.FTaxaTransferencia   := '0';
            LRegistro.FDescricao           := '';
            LRegistro.FTitular             := '';
            LRegistro.FCodigoBanco         := '';
            LRegistro.FAgencia             := '';
            LRegistro.FConta               := '';
            LRegistro.FDigitoConta         := '';
            LRegistro.FTipoRegistro        := 'transfer';
          End
          Else
          Begin
            LRegistro.FTipoRegistro      := RetornaValorJson(LJsonObjectValue, 'type');
            LRegistro.FDataCadastro      := RetornaValorJson(LJsonObjectValue, 'created_at');
            LRegistro.FTaxaTransferencia := RetornaValorJson(LJsonObjectValue, 'fee');
            LMovementObject := TJSONObject.ParseJSONValue(LJsonObjectValue.GetValue('movement_object').ToJson) as TJsonObject;
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
              LRegistro.FDataCredito     := RetornaValorJson(LMovementObject,  'payment_date ');
            if LRegistro.FDataCredito.Trim.IsEmpty then
              LRegistro.FDataCredito     := RetornaValorJson(LMovementObject,  'funding_date');
            if LRegistro.FTargetType.Equals('bank_account') then
            begin
              If LMovementObject.GetValue('bank_account') <> Nil Then
              Begin
                LBankAccountObject := TJSONObject.ParseJSONValue(LMovementObject.GetValue('bank_account').ToJson) as TJsonObject;
                LRegistro.FTitular           := RetornaValorJson(LBankAccountObject, 'holder_name');
                LRegistro.FCodigoBanco       := RetornaValorJson(LBankAccountObject, 'bank');
                LRegistro.FAgencia           := RetornaValorJson(LBankAccountObject, 'branch_number');
                LRegistro.FConta             := RetornaValorJson(LBankAccountObject, 'account_number');
                LRegistro.FDigitoConta       := RetornaValorJson(LBankAccountObject, 'account_check_digit');
              End;
            end;
          End;

          LRegistro.FKeyApi := LKeyAPi;
        Except
         FreeAndNil(LRegistro);
         Raise;
        End;
      Finally
        TPagarmeFuncoes.FreeAndNilObjeto(LBankAccountObject);
        TPagarmeFuncoes.FreeAndNilObjeto(LMovementObject);
        TPagarmeFuncoes.FreeAndNilObjeto(LJsonObjectValue);
      End;

      FPagarMeRegistrosTransferencias.Add(LRegistro);
      pgbProg.Position := pgbProg.Position + 1;
      TForm(pgbProg).Update;
    end;
    pgbProg.Position := 0;
  finally
    TPagarmeFuncoes.FreeAndNilObjeto(LJsonArrayContent);
    TPagarmeFuncoes.FreeAndNilObjeto(LJsonRetorno);
  end;
end;

procedure TPagarMePgto.GravarTransferencias(var ADataSet: TUniQuery; pgbProg: TcxProgressBar);
var
  LRegistroTransferencia: TPagarMeRegistroTransferencia;
  LSQL: String;
begin
  if FPagarMeRegistrosTransferencias.Count < 1 then
    Exit;

  LSQL := TPagarMeFuncoes.RetornaSQLReplace('PGM_PMTRAN', ['PGM_CONCIL']);

  ADataSet.Close;
  ADataSet.SQL.Text := LSQL;

  pgbProg.Position := 0;
  pgbProg.Properties.Max := FPagarMeRegistrosTransferencias.Count;
  TPagarMeFuncoes.pStepStatusGravacao(pgbProg, 'Aguarde... Gravando registros de transferência.', False);

  try
    For LRegistroTransferencia In FPagarMeRegistrosTransferencias Do
    Begin
      FImportouTransferencias := True;

      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_ID_TRF', CorrigeDadosBanco(LRegistroTransferencia.FTransferencia_ID));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_TIPREG', CorrigeDadosBanco(LRegistroTransferencia.FTipoRegistro));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_STATUS', CorrigeDadosBanco(LRegistroTransferencia.FStatus));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_VALTRF', CorrigeDadosBanco(LRegistroTransferencia.FValorTransferencia, varDouble));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_TAXTRF', CorrigeDadosBanco(LRegistroTransferencia.FTaxaTransferencia, varDouble));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_SOURCE', CorrigeDadosBanco(LRegistroTransferencia.FSource_ID));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_TARGET', CorrigeDadosBanco(LRegistroTransferencia.FTargetType));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_DTATRF', CorrigeDadosBanco(LRegistroTransferencia.FDataCadastro, varDate));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_DTACRE', CorrigeDadosBanco(LRegistroTransferencia.FDataCredito, varDate));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_DESCRI', CorrigeDadosBanco(LRegistroTransferencia.FDescricao));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_TITULA', CorrigeDadosBanco(LRegistroTransferencia.FTitular));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_CODBCO', CorrigeDadosBanco(LRegistroTransferencia.FCodigoBanco));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_AGENCI', CorrigeDadosBanco(LRegistroTransferencia.FAgencia));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_NUMCTA', CorrigeDadosBanco(LRegistroTransferencia.FConta +
                                                                        TPagarMeFuncoes.IIF(LRegistroTransferencia.FDigitoConta.Trim.IsEmpty,
                                                                                            '',
                                                                                            '-' + LRegistroTransferencia.FDigitoConta)));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_JSOREC', CorrigeDadosBanco(LRegistroTransferencia.FJsonRecebido));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_KEYAPI', CorrigeDadosBanco(LRegistroTransferencia.FKeyApi));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_TIPTRF', CorrigeDadosBanco(LRegistroTransferencia.FTipoTransferencia));
      TPagarMeFuncoes.CarregaParametroDataset(ADataSet, 'PGM_DTAIMP', CorrigeDadosBanco(VS_FuncoesExternas.fIGetVS_Date));

      ADataSet.ExecSQL;
      TPagarMeFuncoes.pStepStatusGravacao(pgbProg);
    End;
    FPagarMeRegistrosTransferencias.Clear;

  Except
    FImportouTransferencias := False;
    Raise;
  End;
end;

procedure TPagarMePgto.ImportaCobranca(strString: String;pgbProg: TcxProgressBar);
  Var
    LRegistro: TPagarMeRegistroCobranca;
    LJsonObjectValue,
    LJsonObjectLast,
    LJsonRetorno,
    LJsonMetaData,
    LJsonIDs: TJsonObject;
    LJsonArrayContent: TJSONArray;
    LJsonValueContent: TJsonValue;
begin
  LJsonRetorno := Nil;
  LJsonArrayContent := Nil;
  LJsonObjectLast := Nil;
  Try
    LJsonRetorno := TJSONObject.ParseJSONValue(strString) as TJSONObject;
    If LJsonRetorno = Nil Then
      Exit;

    LJsonArrayContent := TJSONObject.ParseJSONValue(LJsonRetorno.GetValue('data').ToJson) as TJsonArray;

    pgbProg.Position := 0;
    pgbProg.Properties.Max := LJsonArrayContent.Count;

    For LJsonValueContent In LJsonArrayContent Do
    Begin
      LJsonObjectValue := TJSONObject.ParseJSONValue(LJsonValueContent.ToString.Replace('\ ', '-')) as TJSONObject;
      Try
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

        if LJsonObjectValue.TryGetValue<TJSONObject>('order', LJsonIds) then
          LRegistro.FOrderId := RetornaValorJson(LJsonIds,'id');

        if LJsonObjectValue.TryGetValue<TJSONObject>('customer', LJsonIds) then
          LRegistro.FCustomerId := RetornaValorJson(LJsonIds,'id');

        if LJsonObjectValue.TryGetValue<TJSONObject>('metadata', LJsonMetaData) then
        Begin
          LRegistro.FOrigem := RetornaValorJson(LJsonMetaData,'platform');
          LRegistro.FOrderIntegrador := RetornaValorJson(LJsonMetaData,'order_id');
        End;

        LJsonObjectLast := TJSONObject.ParseJSONValue(LJsonObjectValue.GetValue('last_transaction').ToJson) as TJSONObject;

        LRegistro.FTotalParcelas :=  RetornaValorJson(LJsonObjectLast,'installments');
        If TPagarMeFuncoes.fEmptyStr(LRegistro.FTotalParcelas) Then
          LRegistro.FTotalParcelas := '01';

        LRegistro.FNumeroNSU := RetornaValorJson(LJsonObjectLast,'acquirer_nsu');
        LRegistro.FParcela := '01';
        LRegistro.FAutorizacao :=  RetornaValorJson(LJsonObjectLast,'acquirer_auth_code');
        LRegistro.FKeyApi := LKeyAPi;
        LRegistro.FMeioPagamento := RetornaValorJson(LJsonObjectLast,'transaction_type');

        If LRegistro.FMeioPagamento = 'credit_card' Then
        Begin
          TPagarMeFuncoes.FreeAndNilObjeto(LJsonObjectValue);
          LJsonObjectValue := TJSONObject.ParseJSONValue(LJsonObjectLast.GetValue('card').ToJson) as TJSONObject;
          LRegistro.FTipoRegistro := RetornaValorJson(LJsonObjectValue,'type');
          LRegistro.FBandeira :=RetornaValorJson(LJsonObjectValue,'brand');
          LRegistro.FCartao := RetornaValorJson(LJsonObjectValue,'first_six_digits') + '*********' +
                               RetornaValorJson(LJsonObjectValue,'last_four_digits');
        End;
      Finally
        TPagarMeFuncoes.FreeAndNilObjeto(LJsonObjectLast);
        TPagarMeFuncoes.FreeAndNilObjeto(LJsonObjectValue);
      End;
      FPagarMeRegistrosCobranca.Add(LRegistro);
      AdicionarParcelas(LRegistro);
      pgbProg.Position := pgbProg.Position + 1;
      TForm(pgbProg).Update;
    End;
    pgbProg.Position := 0;

  Finally
    TPagarMeFuncoes.FreeAndNilObjeto(LJsonArrayContent);
    TPagarMeFuncoes.FreeAndNilObjeto(LJsonRetorno);
  End;
end;

procedure TPagarMePgto.ImportaTransacoes(strString: String;pgbProg: TcxProgressBar);
  Var
    LRegistro: TPagarMeRegistroPgto;
    LJsonObjectValue: TJsonObject;
    LJsonArrayContent: TJSONArray;
    LJsonValueContent: TJsonValue;
begin
  LJsonArrayContent := Nil;
  Try
    LJsonArrayContent := TJSONObject.ParseJSONValue(strString) as TJsonArray;
    If LJsonArrayContent = Nil Then
      Exit;

    pgbProg.Position := 0;
    pgbProg.Properties.Max := LJsonArrayContent.Count;

    For LJsonValueContent In LJsonArrayContent Do
    Begin
      LJsonObjectValue := TJSONObject.ParseJSONValue(LJsonValueContent.ToString.Replace('\ ', '-')) as TJSONObject;

      Try
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
      Finally
        FreeAndNil(LJsonObjectValue);
      End;

      FPagarMeRegistrosPgto.Add(LRegistro);
      pgbProg.Position := pgbProg.Position + 1;
      TForm(pgbProg).Update;
    End;
    pgbProg.Position := 0;
  Finally
    TPagarmeFuncoes.FreeAndNilObjeto(LJsonArrayContent);
  End;
end;

procedure TPagarMePgto.ImportaVendas(strString: String;pgbProg: TcxProgressBar);
  Var
    LRegistro: TPagarMeRegistroVendas;
    LJsonObjectValue: TJsonObject;
    LJsonArrayContent: TJSONArray;
    LJsonValueContent: TJsonValue;
begin
  LJsonArrayContent := Nil;
  Try
    LJsonArrayContent := TJSONObject.ParseJSONValue(strString) as TJsonArray;
    If LJsonArrayContent = Nil Then
      Exit;

    pgbProg.Position := 0;
    pgbProg.Properties.Max := LJsonArrayContent.Count;

    For LJsonValueContent In LJsonArrayContent Do
    Begin
      LJsonObjectValue := TJSONObject.ParseJSONValue(LJsonValueContent.ToString.Replace('\ ', '-')) as TJSONObject;

      Try
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
      Finally
        FreeAndNil(LJsonObjectValue);
      End;

      FPagarMeRegistrosVendas.Add(LRegistro);
      pgbProg.Position := pgbProg.Position + 1;
      TForm(pgbProg).Update;
    End;
  Finally
    TPagarMeFuncoes.FreeAndNilObjeto(LJsonArrayContent);
  End;
end;

procedure TPagarMePgto.pAdicionaLinha(strString: String; pgbProg: TcxProgressBar);
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
    Raise;
  End;
end;

procedure TPagarMePgto.pGravarRegistros(var pgbProg: TcxProgressBar);
  Var
    LDados: TUniQuery;
    LSQL: String;
    LRegistro: TPagarMeRegistroPgto;
    LRegistroVendas: TPagarMeRegistroVendas;
    LRegistroCobranca: TPagarMeRegistroCobranca;
begin
  LSQL := TPagarMeFuncoes.RetornaSQLReplace('PGM_PMPGTO', ['PGM_CONCIL']);

  LDados := Nil;
  VS_FuncoesExternas.fIStartTransaction;
  Try
    LDados := VS_FuncoesExternas.fICriaQuery;
    LDados.SQL.Text := LSQL;

    pgbProg.Position := 0;
    pgbProg.Properties.Max := FPagarMeRegistrosPgto.Count;
    TPagarMeFuncoes.pStepStatusGravacao(pgbProg, 'Aguarde... Gravando registros.', False);

    For LRegistro In FPagarMeRegistrosPgto Do
    Begin
      FImportouPagamento := True;
      FImportouRegistro := True;

      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_OBJECT', CorrigeDadosBanco(LRegistro.Aobject));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_STATUS', CorrigeDadosBanco(LRegistro.Astatus));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_REFREA', CorrigeDadosBanco(LRegistro.Arefuse_reason));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_STAREA', CorrigeDadosBanco(LRegistro.Astatus_reason));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_ACQCOD', CorrigeDadosBanco(LRegistro.Aacquirer_response_code));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_ACQMES', CorrigeDadosBanco(LRegistro.Aacquirer_response_message));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_ACQNAM', CorrigeDadosBanco(LRegistro.Aacquirer_name));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_ACQ_ID', CorrigeDadosBanco(LRegistro.Aacquirer_id));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_CODAUT', CorrigeDadosBanco(LRegistro.Aauthorization_code));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_SOFDES', CorrigeDadosBanco(LRegistro.Asoft_descriptor));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_CODTID', CorrigeDadosBanco(LRegistro.Atid));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_NUMNSU', CorrigeDadosBanco(LRegistro.Ansu));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_DTACRE', CorrigeDadosBanco(LRegistro.Adate_created));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_DTAUPD', CorrigeDadosBanco(LRegistro.Adate_updated));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_VALPAG', CorrigeDadosBanco(LRegistro.Aamount,varDouble));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_PAGAUT', CorrigeDadosBanco(LRegistro.Aauthorized_amount,varDouble));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_QTDPAG', CorrigeDadosBanco(LRegistro.Apaid_amount,varDouble));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_REFPAG', CorrigeDadosBanco(LRegistro.Arefunded_amount,varDouble));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_TOTPAR', CorrigeDadosBanco(LRegistro.Ainstallments));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_TRA_ID', CorrigeDadosBanco(LRegistro.Atid));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_NUMCAR', CorrigeDadosBanco(LRegistro.Acard_first_digits + '*********' + LRegistro.Acard_last_digits));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_BANDEI', CorrigeDadosBanco(LRegistro.Acard_brand));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_PAYMET', CorrigeDadosBanco(LRegistro.Apayment_method));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_CAPMET', CorrigeDadosBanco(LRegistro.Acapture_method));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_JSOREC', CorrigeDadosBanco(LRegistro.AJson));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_DTAIMP', CorrigeDadosBanco(VS_FuncoesExternas.fIGetVS_Date));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_KEYAPI', CorrigeDadosBanco(LRegistro.AKeyApi));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_IMPREC', 'S');

      LDados.ExecSQL;
      TPagarMeFuncoes.pStepStatusGravacao(pgbProg);
    End;

    //***********************************VENDAS*******************************************
    LSQL := TPagarMeFuncoes.RetornaSQLReplace('PGM_PMVEND', ['PGM_CONCIL']);

    LDados.Close;
    LDados.SQL.Text := LSQL;

    pgbProg.Position := 0;
    pgbProg.Properties.Max := FPagarMeRegistrosVendas.Count;
    TPagarMeFuncoes.pStepStatusGravacao(pgbProg, 'Aguarde... Gravando registros de vendas.', False);

    For LRegistroVendas In FPagarMeRegistrosVendas Do
    Begin
      FImportouPagamento := True;
      FImportouRegistro := True;

      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_OBJECT', CorrigeDadosBanco(LRegistroVendas.Aobject));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_VEN_ID', CorrigeDadosBanco(LRegistroVendas.Aid));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_STATUS', CorrigeDadosBanco(LRegistroVendas.Astatus));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_VALPAG', CorrigeDadosBanco(LRegistroVendas.Aamount,varDouble));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_VALTAX', CorrigeDadosBanco(LRegistroVendas.Afee,varDouble));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_TAXANT', CorrigeDadosBanco(LRegistroVendas.Aanticipation_fee,varDouble));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_TAXFRA', CorrigeDadosBanco(LRegistroVendas.Afraud_coverage_fee,varDouble));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_NUMPAR', CorrigeDadosBanco(LRegistroVendas.Ainstallment,varInteger));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_TRA_ID', CorrigeDadosBanco(LRegistroVendas.Atransaction_id));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_RUL_ID', CorrigeDadosBanco(LRegistroVendas.Asplit_rule_id));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_BANTID', CorrigeDadosBanco(LRegistroVendas.Abulk_anticipation_id));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_ANT_ID', CorrigeDadosBanco(LRegistroVendas.Aanticipation_id));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_DES_ID', CorrigeDadosBanco(LRegistroVendas.Arecipient_id));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_ORIMOD', CorrigeDadosBanco(LRegistroVendas.Aoriginator_model));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_MOD_ID', CorrigeDadosBanco(LRegistroVendas.Aoriginator_model_id));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_DTAPAG', CorrigeDadosBanco(LRegistroVendas.Apayment_date));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_TIPREG', CorrigeDadosBanco(LRegistroVendas.Atype));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_METPAG', CorrigeDadosBanco(LRegistroVendas.Apayment_method));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_DTAACU', CorrigeDadosBanco(LRegistroVendas.Aaccrual_date));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_DTACRE', CorrigeDadosBanco(LRegistroVendas.Adate_created));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_ACO_ID', CorrigeDadosBanco(LRegistroVendas.Aliquidation_arrangement_id));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_JSOREC', CorrigeDadosBanco(LRegistroVendas.aJson));

      LDados.ExecSQL;
      TPagarMeFuncoes.pStepStatusGravacao(pgbProg);
    End;

    //***********************************COBRANÇA*******************************************
    LSQL := TPagarMeFuncoes.RetornaSQLReplace('PGM_PMCOBR', ['PGM_CONCIL']);

    LDados.Close;
    LDados.SQL.Text := LSQL;

    pgbProg.Position := 0;
    pgbProg.Properties.Max := FPagarMeRegistrosCobranca.Count;
    TPagarMeFuncoes.pStepStatusGravacao(pgbProg, 'Aguarde... Gravando registros de cobranças.', False);

    For LRegistroCobranca In FPagarMeRegistrosCobranca Do
    Begin
      FImportouPagamento := True;
      FImportouRegistro := True;
      FImportouCobrancas := True;

      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_TIPREG', CorrigeDadosBanco(LRegistroCobranca.FTipoRegistro));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_TOTPAR', CorrigeDadosBanco(LRegistroCobranca.FTotalParcelas,varInteger));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_NUMNSU', CorrigeDadosBanco(LRegistroCobranca.FNumeroNSU));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_NUMPAR', CorrigeDadosBanco(LRegistroCobranca.FParcela,varInteger));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_CODAUT', CorrigeDadosBanco(LRegistroCobranca.FAutorizacao));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_DTACRE', CorrigeDadosBanco(LRegistroCobranca.FDataVenda,varDate));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_BRUPAR', RetornaValorBrutoParcela(LRegistroCobranca));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_LIQPAR', RetornaValorLiquidoParcela(LRegistroCobranca));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_NUMCAR', CorrigeDadosBanco(LRegistroCobranca.FCartao));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_NUMPOK', CorrigeDadosBanco(LRegistroCobranca.FNumPok));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_BANDEI', CorrigeDadosBanco(LRegistroCobranca.FBandeira));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_DTAPAG', LeftStr(LRegistroCobranca.FDataPagamento, 10));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_METPAG', CorrigeDadosBanco(LRegistroCobranca.FMeioPagamento));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_JSOREC', CorrigeDadosBanco(LRegistroCobranca.FJson));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_DTAIMP', CorrigeDadosBanco(DATE));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_KEYAPI', CorrigeDadosBanco(LRegistroCobranca.FKeyApi));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_STATUS', CorrigeDadosBanco(LRegistroCobranca.FStatus));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_ORIGEM', TPagarMeFuncoes.IIF(LRegistroCobranca.FOrigem.Trim.IsEmpty,
                                                                                        'site',
                                                                                        LRegistroCobranca.FOrigem));

      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_ID_COB', CorrigeDadosBanco(LRegistroCobranca.FCobranca_ID));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_GATWAY', CorrigeDadosBanco(LRegistroCobranca.FGateway_ID));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_ORDINT', CorrigeDadosBanco(LRegistroCobranca.FOrderIntegrador));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_ORD_ID', CorrigeDadosBanco(LRegistroCobranca.FOrderId));
      TPagarMeFuncoes.CarregaParametroDataset(LDados, 'PGM_CUS_ID', CorrigeDadosBanco(LRegistroCobranca.FCustomerId));

      LDados.ExecSQL;
      TPagarMeFuncoes.pStepStatusGravacao(pgbProg);
    End;
    FPagarMeRegistrosCobranca.Clear;

    //***********************************RECEBÍVEIS*******************************************
    GravarRecebiveis(LDados, pgbProg);

    GravarTransferencias(LDados, pgbProg);

    VS_FuncoesExternas.fICommit;
  Finally
    TPagarMeFuncoes.FreeAndNilDatasets(LDados);
  End;
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
  LQuery: TUniQuery;
begin
  Result := TStringList.Create;

  LQuery := Nil;
  Try
    try
      LQuery := VS_FuncoesExternas.fICriaQuery;
      LQuery.SQL.Text := 'SELECT                                      ' +
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
                         '  AND (COB.PGM_ID_COB IS NULL OR ' +
                         '       COB.PGM_ORDINT IS NULL OR ' +
                         '       COB.PGM_ORD_ID IS NULL OR ' +
                         '       COB.PGM_CUS_ID IS NULL)   ' +
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
  Finally
    TPagarMeFuncoes.FreeAndNilDatasets(LQuery);
  End;
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
