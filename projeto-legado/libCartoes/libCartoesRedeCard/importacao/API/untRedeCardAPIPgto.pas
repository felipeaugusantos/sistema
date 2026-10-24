unit untRedeCardAPIPgto;

interface
uses System.Classes, System.StrUtils, System.SysUtils, System.Variants,
     Vcl.ComCtrls, Vcl.Dialogs, Vcl.Forms, System.Generics.Collections,
     System.Json, Data.DB,

     cxProgressBar, Uni,

     untIRedeCardIntegracaoLibCartoes, untRedeCardTipos, untTRedeCardFuncoes,
     untTConsultaPagamentoDiarioRedeCardOnline;

Type
  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrEstruturaRedeCardAPIPgto = Array Of TEstruturaPgto;

  TRedeCardAPIPgto = Class(TInterfacedObject, ICartoes)
  Private
    FRedeCardRegistrosPgto: TObjectList<TRedeCardRegistroPgto>;

    FRedeCardRegistrosVenda: TObjectList<TRedeCardAPIRegistroVenda>;

    FRedeCardRegistrosVendaParcelada: TObjectList<TRedeCardAPIRegistroVendaParcelada>;

    FRedeCardRegistrosAjuste: TObjectList<TRedeCardAPIRegistroAjuste>;

    FNegociacoesPagamento: TObjectList<TNegociacao>;

    FProximaPagina: String;

    FImportouRegistro,
    FImportouPagamento,
    FImportouVendas: Boolean;

    FEstabelecimentoAtual,
    FTipoDoArquivo : String;
    FProgresso: TcxProgressBar;

    function CorrigeDadosBanco(AValor: Variant;
                               ACampoData: Boolean = False): Variant;

    function RetornaValorJson(AObjeto: TJsonObject; ANomeCampo: String; ATipoRetorno: TVarType = varString): Variant;

    procedure ImportaPagamentos(strString: String);
    procedure ImportaPagamentosDiario(strString: String);
    procedure ImportaVendas(strString: String);
    procedure ImportaVendasParceladas(strString: String);
    procedure ImportaAjustes(strString: String);
    function Ocorrencias(TextoProcurado: string; Texto: string): integer;

    procedure GravaRegistrosTabelaPgto(var AProgress: TcxProgressBar);
    procedure GravaRegistrosTabelaNegociacaoPagamento(var AProgress: TcxProgressBar);
    procedure GravaRegistrosTabelaVenda(var AProgress: TcxProgressBar);
    procedure GravaRegistrosTabelaVendaParcelada(var AProgress: TcxProgressBar);
    procedure GravaRegistrosTabelaAjustes(var AProgress: TcxProgressBar);

    function AjusteJaConciliado(ADataRevisao, ADataExpiracao, ADataPagamento,
                                APontoVenda, AResumoVenda, ANumeroPedido : String;
                                AValorAjuste: Double; ANumeroDebito : String;
                                AValorPago: Double): Boolean;
  Public
    constructor Create;
    destructor Destroy; override;

    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TcxProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaRedeCardAPIPgto;

    property ProximaPagina: String read FProximaPagina;
    property ImportouRegistro: Boolean read FImportouRegistro;
    property ImportouPagamento: Boolean read FImportouPagamento;
    property EstabelecimentoAtual: String read FEstabelecimentoAtual write FEstabelecimentoAtual;
    property TipoDoArquivo: String read FTipoDoArquivo write FTipoDoArquivo;
    property Progresso: TcxProgressBar read FProgresso write FProgresso;
    property ImportouVendas : Boolean Read FImportouVendas Write FImportouVendas;
  End;

  Var
    NomeArquivo,
    DataArquivo: String;

Const
  NOMTAB = 'RED_APPGTO';
  INICAM = 'RED_';

implementation

{ TRedeCardAPIPgto }

function TRedeCardAPIPgto.AjusteJaConciliado(ADataRevisao, ADataExpiracao,
  ADataPagamento, APontoVenda, AResumoVenda, ANumeroPedido : String; AValorAjuste: Double; ANumeroDebito : String; AValorPago: Double): Boolean;
Var
  LQryAjuste : TUniQuery;
begin
  LQryAjuste := Nil;
  Try
    LQryAjuste := VS_FuncoesExternas.fICriaQuery;
    LQryAjuste.Close;
    LQryAjuste.SQL.Text := 'SELECT 1 FROM RED_APAJUS              ' +
                           '  WHERE RED_DTA_RV = :RED_DTA_RV AND  ' +
                           '        RED_DTAEXP = :RED_DTAEXP AND  ' +
                           '        RED_DTAPAG = :RED_DTAPAG AND  ' +
                           '        RED_NUM_PV = :RED_NUM_PV AND  ' +
                           '        RED_NUM_RV = :RED_NUM_RV AND  ' +
                           '        RED_NUMPED = :RED_NUMPED AND  ' +
                           '        RED_VALAJU = :RED_VALAJU AND  ' +
                           '        RED_NUMDEB = :RED_NUMDEB AND  ' +
                           '        RED_VALPAG = :RED_VALPAG AND  ' +
                           '        RED_CONCIL = 1                ';

    LQryAjuste.ParamByName('RED_DTA_RV').Value := ADataRevisao;
    LQryAjuste.ParamByName('RED_DTAEXP').Value := ADataExpiracao;
    LQryAjuste.ParamByName('RED_DTAPAG').Value := ADataPagamento;
    LQryAjuste.ParamByName('RED_NUM_PV').Value := APontoVenda;
    LQryAjuste.ParamByName('RED_NUM_RV').Value := AResumoVenda;
    LQryAjuste.ParamByName('RED_NUMPED').Value := ANumeroPedido;
    LQryAjuste.ParamByName('RED_VALAJU').Value := AValorAjuste;
    LQryAjuste.ParamByName('RED_NUMDEB').Value := ANumeroDebito;
    LQryAjuste.ParamByName('RED_VALPAG').Value := AValorPago;
    LQryAjuste.Open;

    Result := Not LQryAjuste.IsEmpty;
  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(LQryAjuste);
  End;
end;

function TRedeCardAPIPgto.CorrigeDadosBanco(AValor: Variant;
                                            ACampoData: Boolean = False): Variant;
begin
  Result := Null;
  If Not TRedeCardFuncoes.fEmptyStr(AValor) Then
  Begin
    Result := AValor;

    If ACampoData Then
      Result := RightStr(Result, 4) + '-' +
                Copy(Result, 4, 2) + '-' +
                LeftStr(Result, 2);
  End;
end;

constructor TRedeCardAPIPgto.Create;
begin
  FImportouRegistro := False;
  FImportouPagamento := False;
  FImportouVendas := False;

  FRedeCardRegistrosPgto := TObjectList<TRedeCardRegistroPgto>.Create;
  FRedeCardRegistrosVenda := TObjectList<TRedeCardAPIRegistroVenda>.Create;
  FRedeCardRegistrosVendaParcelada := TObjectList<TRedeCardAPIRegistroVendaParcelada>.Create;
  FRedeCardRegistrosAjuste := TObjectList<TRedeCardAPIRegistroAjuste>.Create;
  FNegociacoesPagamento := TObjectList<TNegociacao>.Create;
end;

destructor TRedeCardAPIPgto.Destroy;
begin
  If Assigned(FRedeCardRegistrosPgto) Then
    FreeAndNil(FRedeCardRegistrosPgto);

  If Assigned(FRedeCardRegistrosVenda) Then
    FreeAndNil(FRedeCardRegistrosVenda);

  If Assigned(FRedeCardRegistrosVendaParcelada) Then
    FreeAndNil(FRedeCardRegistrosVendaParcelada);

  If Assigned(FRedeCardRegistrosAjuste) Then
    FreeAndNil(FRedeCardRegistrosAjuste);

  If Assigned(FNegociacoesPagamento) Then
    FreeAndNil(FNegociacoesPagamento);

  inherited;
end;

class function TRedeCardAPIPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaRedeCardAPIPgto;
Begin
  If strTabela = 'RED_APPGTO' Then
  Begin
    SetLength(Result, 13);

    Result[0].strDescri  := INICAM + 'NUM_PV'; Result[0].strTipCmp  := 'VARCHAR(9)'   ;
    Result[1].strDescri  := INICAM + 'TIPREG'; Result[1].strTipCmp  := 'VARCHAR(3)'   ;
    Result[2].strDescri  := INICAM + 'DTAPAG'; Result[2].strTipCmp  := 'DATE'         ;
    Result[3].strDescri  := INICAM + 'NUM_RV'; Result[3].strTipCmp  := 'VARCHAR(15)'  ;
    Result[4].strDescri  := INICAM + 'NUMORD'; Result[4].strTipCmp  := 'VARCHAR(15)'  ;
    Result[5].strDescri  := INICAM + 'CODBAN'; Result[5].strTipCmp  := 'VARCHAR(3)'   ;
    Result[6].strDescri  := INICAM + 'VALBRU'; Result[6].strTipCmp  := 'DECIMAL(15,2)';
    Result[7].strDescri  := INICAM + 'VALDES'; Result[7].strTipCmp  := 'DECIMAL(15,2)';
    Result[8].strDescri  := INICAM + 'VALLIQ'; Result[8].strTipCmp  := 'DECIMAL(15,2)';
    Result[9].strDescri  := INICAM + 'DESTIP'; Result[9].strTipCmp  := 'VARCHAR(15)'  ;
    Result[10].strDescri := INICAM + 'DTAIMP'; Result[10].strTipCmp := 'DATE'         ;
    Result[11].strDescri := INICAM + 'CONCIL'; Result[11].strTipCmp := 'INT DEFAULT 0';
    Result[12].strDescri := INICAM + 'PAG_ID'; Result[12].strTipCmp := 'VARCHAR(50)'  ;
  End

  Else If strTabela = 'RED_APVEND' Then
  Begin
    SetLength(Result, 35);

    Result[0].strDescri  := INICAM + 'NUM_PV'; Result[0].strTipCmp  := 'VARCHAR(9)'   ;
    Result[1].strDescri  := INICAM + 'TIPREG'; Result[1].strTipCmp  := 'VARCHAR(3)'   ;
    Result[2].strDescri  := INICAM + 'DTA_RV'; Result[2].strTipCmp  := 'DATE'         ;
    Result[3].strDescri  := INICAM + 'NUM_RV'; Result[3].strTipCmp  := 'VARCHAR(15)'  ;
    Result[4].strDescri  := INICAM + 'NUMORD'; Result[4].strTipCmp  := 'VARCHAR(20)'  ;
    Result[5].strDescri  := INICAM + 'CODBAN'; Result[5].strTipCmp  := 'VARCHAR(3)'   ;
    Result[6].strDescri  := INICAM + 'DOCNUM'; Result[6].strTipCmp  := 'VARCHAR(15)'  ;
    Result[7].strDescri  := INICAM + 'RAZSOC'; Result[7].strTipCmp  := 'VARCHAR(30)'  ;
    Result[8].strDescri  := INICAM + 'NOMFAN'; Result[8].strTipCmp  := 'VARCHAR(30)'  ;
    Result[9].strDescri  := INICAM + 'CODAUT'; Result[9].strTipCmp  := 'VARCHAR(6)'   ;
    Result[10].strDescri := INICAM + 'NOMPRO'; Result[10].strTipCmp := 'VARCHAR(15)'  ;
    Result[11].strDescri := INICAM + 'CODPRO'; Result[11].strTipCmp := 'VARCHAR(3)'   ;
    Result[12].strDescri := INICAM + 'TOTPAR'; Result[12].strTipCmp := 'VARCHAR(2)'   ;
    Result[13].strDescri := INICAM + 'NUMNSU'; Result[13].strTipCmp := 'VARCHAR(20)'  ;
    Result[14].strDescri := INICAM + 'NUMTID'; Result[14].strTipCmp := 'VARCHAR(20)'  ;
    Result[15].strDescri := INICAM + 'DTAVEN'; Result[15].strTipCmp := 'DATE'         ;
    Result[16].strDescri := INICAM + 'STATUS'; Result[16].strTipCmp := 'VARCHAR(12)'  ;
    Result[17].strDescri := INICAM + 'CHASTA'; Result[17].strTipCmp := 'VARCHAR(15)'  ;
    Result[18].strDescri := INICAM + 'TIPMAQ'; Result[18].strTipCmp := 'VARCHAR(10)'  ;
    Result[19].strDescri := INICAM + 'CODTER'; Result[19].strTipCmp := 'VARCHAR(10)'  ;
    Result[20].strDescri := INICAM + 'TIPCAP'; Result[20].strTipCmp := 'VARCHAR(50)'  ;
    Result[21].strDescri := INICAM + 'CODCAP'; Result[21].strTipCmp := 'VARCHAR(3)'   ;
    Result[22].strDescri := INICAM + 'VALBRU'; Result[22].strTipCmp := 'DECIMAL(15,2)';
    Result[23].strDescri := INICAM + 'TAXMDR'; Result[23].strTipCmp := 'DECIMAL(15,5)';
    Result[24].strDescri := INICAM + 'VALMDR'; Result[24].strTipCmp := 'DECIMAL(15,2)';
    Result[25].strDescri := INICAM + 'E_FLEX'; Result[25].strTipCmp := 'VARCHAR(1) DEFAULT ''N''';
    Result[26].strDescri := INICAM + 'TAXFLE'; Result[26].strTipCmp := 'DECIMAL(15,5)';
    Result[27].strDescri := INICAM + 'VALFLE'; Result[27].strTipCmp := 'DECIMAL(15,2)';
    Result[28].strDescri := INICAM + 'PERTAX'; Result[28].strTipCmp := 'DECIMAL(15,5)';
    Result[29].strDescri := INICAM + 'VALDES'; Result[29].strTipCmp := 'DECIMAL(15,2)';
    Result[30].strDescri := INICAM + 'VALLIQ'; Result[30].strTipCmp := 'DECIMAL(15,2)';
    Result[31].strDescri := INICAM + 'VALEMB'; Result[31].strTipCmp := 'DECIMAL(15,2)';
    Result[32].strDescri := INICAM + 'NUMCAR'; Result[32].strTipCmp := 'VARCHAR(20)'  ;
    Result[33].strDescri := INICAM + 'ID_ARD'; Result[33].strTipCmp := 'VARCHAR(23)'  ;
    Result[34].strDescri := INICAM + 'DTAIMP'; Result[34].strTipCmp := 'DATE'         ;
  End

  Else If strTabela = 'RED_APVPAR' Then
  Begin
    SetLength(Result, 18);

    Result[0].strDescri  := INICAM + 'NUM_PV'; Result[0].strTipCmp  := 'VARCHAR(9)'   ;
    Result[1].strDescri  := INICAM + 'NUMNSU'; Result[1].strTipCmp  := 'VARCHAR(20)'  ;
    Result[2].strDescri  := INICAM + 'DTA_RV'; Result[2].strTipCmp  := 'DATE'         ;
    Result[3].strDescri  := INICAM + 'NUM_RV'; Result[3].strTipCmp  := 'VARCHAR(15)'  ;
    Result[4].strDescri  := INICAM + 'NUMTID'; Result[4].strTipCmp  := 'VARCHAR(20)'  ;
    Result[5].strDescri  := INICAM + 'DTAVEN'; Result[5].strTipCmp  := 'DATE'         ;
    Result[6].strDescri  := INICAM + 'VEN_RV'; Result[6].strTipCmp  := 'DATE'         ;
    Result[7].strDescri  := INICAM + 'NUMPAR'; Result[7].strTipCmp  := 'VARCHAR(2)'   ;
    Result[8].strDescri  := INICAM + 'TOTPAR'; Result[8].strTipCmp  := 'VARCHAR(2)'   ;
    Result[9].strDescri  := INICAM + 'VALPAR'; Result[9].strTipCmp  := 'DECIMAL(15,2)';
    Result[10].strDescri := INICAM + 'VALDES'; Result[10].strTipCmp := 'DECIMAL(15,2)';
    Result[11].strDescri := INICAM + 'LIQPAR'; Result[11].strTipCmp := 'DECIMAL(15,2)';
    Result[12].strDescri := INICAM + 'BRU_RO'; Result[12].strTipCmp := 'DECIMAL(15,2)';
    Result[13].strDescri := INICAM + 'TAXMDR'; Result[13].strTipCmp := 'DECIMAL(15,5)';
    Result[14].strDescri := INICAM + 'VALMDR'; Result[14].strTipCmp := 'DECIMAL(15,2)';
    Result[15].strDescri := INICAM + 'DTAIMP'; Result[15].strTipCmp := 'DATE'         ;
    Result[16].strDescri := INICAM + 'IMPTOT'; Result[16].strTipCmp := 'INT';
    Result[17].strDescri := INICAM + 'CONCIL'; Result[17].strTipCmp := 'INT DEFAULT 0';
  End

  Else If strTabela = 'RED_APAJUS' Then
  Begin
    SetLength(Result, 19);
    Result[0].strDescri   := INICAM + 'VALAJU'; Result[0].strTipCmp  := 'DECIMAL(15,2)' ;
    Result[1].strDescri   := INICAM + 'CODAJU'; Result[1].strTipCmp  := 'VARCHAR(2)'    ;
    Result[2].strDescri   := INICAM + 'DESAJU'; Result[2].strTipCmp  := 'VARCHAR(70)'   ;
    Result[3].strDescri   := INICAM + 'NUM_PV'; Result[3].strTipCmp  := 'VARCHAR(9)'    ;
    Result[4].strDescri   := INICAM + 'NUM_RV'; Result[4].strTipCmp  := 'VARCHAR(15)DEFAULT "0"'   ;
    Result[5].strDescri   := INICAM + 'DTAPAG'; Result[5].strTipCmp  := 'DATE'          ;
    Result[6].strDescri   := INICAM + 'DTA_RV'; Result[6].strTipCmp  := 'DATE'          ;
    Result[7].strDescri   := INICAM + 'NUMDEB'; Result[7].strTipCmp  := 'VARCHAR(7)'    ;
    Result[8].strDescri   := INICAM + 'DOCNUM'; Result[8].strTipCmp  := 'VARCHAR(15)'   ;
    Result[9].strDescri   := INICAM + 'AJUFUT'; Result[9].strTipCmp  := 'DECIMAL(15,2)' ;
    Result[10].strDescri  := INICAM + 'NOMFAN'; Result[10].strTipCmp  := 'VARCHAR(30)'  ;
    Result[11].strDescri  := INICAM + 'NUMAVI'; Result[11].strTipCmp  := 'VARCHAR(14)'  ;
    Result[12].strDescri  := INICAM + 'VALPAG'; Result[12].strTipCmp  := 'DECIMAL(15,2)';
    Result[13].strDescri  := INICAM + 'RAZSOC'; Result[13].strTipCmp  := 'VARCHAR(30)'  ;
    Result[14].strDescri  := INICAM + 'DTAEXP'; Result[14].strTipCmp  := 'DATE'         ;
    Result[15].strDescri  := INICAM + 'NUMPED'; Result[15].strTipCmp  := 'VARCHAR(5)'   ;
    Result[16].strDescri  := INICAM + 'TIPREG'; Result[16].strTipCmp  := 'VARCHAR(3)'   ;
    Result[17].strDescri  := INICAM + 'DTAIMP'; Result[17].strTipCmp := 'DATE'          ;
    Result[18].strDescri  := INICAM + 'CONCIL'; Result[18].strTipCmp := 'INT DEFAULT 0' ;
  End

  Else If strTabela = 'RED_PGODIR' Then
  Begin
    SetLength(Result, 25);
    Result[0].strDescri  := INICAM + 'CODCED'; Result[0].strTipCmp  := 'VARCHAR(50) DEFAULT NULL';
    Result[1].strDescri  := INICAM + 'PAG_ID'; Result[1].strTipCmp  := 'VARCHAR(50) NOT NULL';
    Result[2].strDescri  := INICAM + 'NOMEMP'; Result[2].strTipCmp  := 'VARCHAR(255) DEFAULT NULL';
    Result[3].strDescri  := INICAM + 'CONINT'; Result[3].strTipCmp  := 'VARCHAR(50) DEFAULT NULL';
    Result[4].strDescri  := INICAM + 'CODMAR'; Result[4].strTipCmp  := 'INT DEFAULT NULL';
    Result[5].strDescri  := INICAM + 'TIPNEG'; Result[5].strTipCmp  := 'VARCHAR(255) DEFAULT NULL';
    Result[6].strDescri  := INICAM + 'NOMCED'; Result[6].strTipCmp  := 'VARCHAR(255) DEFAULT NULL';
    Result[7].strDescri  := INICAM + 'CODBCO'; Result[7].strTipCmp  := 'CHAR(3) NOT NULL';
    Result[8].strDescri  := INICAM + 'TIPPAG'; Result[8].strTipCmp  := 'VARCHAR(50) DEFAULT NULL';
    Result[9].strDescri  := INICAM + 'CODTIP'; Result[9].strTipCmp  := 'VARCHAR(50) DEFAULT NULL';
    Result[10].strDescri  := INICAM + 'NUMDOC'; Result[10].strTipCmp  := 'VARCHAR(50) DEFAULT NULL';
    Result[11].strDescri  := INICAM + 'NUMCON'; Result[11].strTipCmp  := 'VARCHAR(50) NOT NULL ';
    Result[12].strDescri  := INICAM + 'CODSTA'; Result[12].strTipCmp  := 'INT DEFAULT NULL';
    Result[13].strDescri  := INICAM + 'QTDDEP'; Result[13].strTipCmp  := 'INT DEFAULT NULL';
    Result[14].strDescri  := INICAM + 'VALLIQ'; Result[14].strTipCmp  := 'DECIMAL(15,2) DEFAULT NULL';
    Result[15].strDescri  := INICAM + 'VALATU'; Result[15].strTipCmp  := 'TINYINT DEFAULT NULL';
    Result[16].strDescri  := INICAM + 'DOCCED'; Result[16].strTipCmp  := 'VARCHAR(50) DEFAULT NULL';
    Result[17].strDescri  := INICAM + 'STATUS'; Result[17].strTipCmp  := 'VARCHAR(50) NOT NULL ';
    Result[18].strDescri  := INICAM + 'ORDCRE'; Result[18].strTipCmp  := 'VARCHAR(50) DEFAULT NULL';
    Result[19].strDescri  := INICAM + 'NOMCOM'; Result[19].strTipCmp  := 'VARCHAR(255) DEFAULT NULL';
    Result[20].strDescri  := INICAM + 'DTAPAG'; Result[20].strTipCmp  := 'DATE NOT NULL DEFAULT "0000-00-00"';
    Result[21].strDescri  := INICAM + 'CODAGE'; Result[21].strTipCmp  := 'VARCHAR(50) DEFAULT NULL';
    Result[22].strDescri  := INICAM + 'TIPREG'; Result[22].strTipCmp  := 'VARCHAR(50) DEFAULT NULL';
    Result[23].strDescri  := INICAM + 'NUM_PV'; Result[23].strTipCmp  := 'VARCHAR(9) NOT NULL';
    Result[24].strDescri  := INICAM + 'ORICRE'; Result[24].strTipCmp  := 'VARCHAR(255) DEFAULT NULL';
  End;

End;

class function TRedeCardAPIPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
  Var
    arrCampos: TArrEstruturaRedeCardAPIPgto;
    intCont  : Integer;
begin
  If strTabela.IsEmpty Then
    Exit('');

  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  If strTabela = 'RED_APPGTO' Then
    Result := Result + ' PRIMARY KEY(RED_TIPREG,RED_NUM_RV,RED_NUMORD,RED_DTAPAG,RED_NUM_PV)) ENGINE INNODB '
  Else If strTabela = 'RED_APVEND' Then
    Result := Result + ' PRIMARY KEY(RED_TIPREG,RED_NUM_PV,RED_NUM_RV,RED_DTA_RV,RED_CODAUT,RED_NUMNSU)) ENGINE INNODB '
  Else If strTabela = 'RED_APVPAR' Then
    Result := Result + ' PRIMARY KEY(RED_NUM_PV,RED_NUM_RV,RED_DTA_RV,RED_NUMNSU,RED_NUMPAR)) ENGINE INNODB '
  Else If strTabela = 'RED_APAJUS' Then
    Result := Result + ' PRIMARY KEY(RED_DTA_RV,RED_DTAEXP,RED_DTAPAG,RED_NUM_PV,RED_NUM_RV,RED_NUMPED,RED_VALAJU,RED_NUMDEB,RED_VALPAG)) ENGINE INNODB '
  Else If strTabela = 'RED_PGODIR' Then
    Result := Result + ' PRIMARY KEY(RED_PAG_ID,RED_CODBCO,RED_NUMCON,RED_STATUS,RED_DTAPAG,RED_NUM_PV)) ENGINE INNODB ' ;

end;

procedure TRedeCardAPIPgto.GravaRegistrosTabelaAjustes(
  var AProgress: TcxProgressBar);
  Var
    LGravacao: TUniQuery;

    LRegistroAjustes: TRedeCardAPIRegistroAjuste;
    LDataExpiracao : String;
    LNumeroPedido : String;
begin
  LGravacao := Nil;
  Try
    LGravacao := VS_FuncoesExternas.fICriaQuery;
    LGravacao.SQL.Text := TRedeCardFuncoes.RetornaSQLReplace('RED_APAJUS', ['RED_CONCIL']);

    AProgress.Position := 0;

    AProgress.Properties.Max := FRedeCardRegistrosAjuste.Count;

    For LRegistroAjustes In FRedeCardRegistrosAjuste Do
    Begin
      LDataExpiracao := TRedeCardFuncoes.IIF(TRedeCardFuncoes.fEmptyStr(LRegistroAjustes.DataExpiracao), CorrigeDadosBanco(DateToStr(Date), True), LRegistroAjustes.DataExpiracao);
      LNumeroPedido  := TRedeCardFuncoes.IIF(TRedeCardFuncoes.fEmptyStr(LRegistroAjustes.NumeroPedido), '0', LRegistroAjustes.NumeroPedido);

      If AjusteJaConciliado(LRegistroAjustes.DataRV,
                            LDataExpiracao,
                            LRegistroAjustes.DataPagamento,
                            LRegistroAjustes.CodigoEstabelecimento,
                            LRegistroAjustes.NumeroRV,
                            Copy(LNumeroPedido, 0, 5),
                            LRegistroAjustes.ValorAjuste,
                            LRegistroAjustes.NumeroDebito,
                            LRegistroAjustes.ValorPago) Then
      begin
        Continue;
      end;

      FImportouRegistro := True;

      LGravacao.Close;

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALAJU', CorrigeDadosBanco(LRegistroAjustes.ValorAjuste));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CODAJU', CorrigeDadosBanco(LRegistroAjustes.CodigoAjuste));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DESAJU', CorrigeDadosBanco(LRegistroAjustes.DescricaoAjuste));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUM_PV', CorrigeDadosBanco(LRegistroAjustes.CodigoEstabelecimento));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUM_RV', CorrigeDadosBanco(LRegistroAjustes.NumeroRV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTAPAG', CorrigeDadosBanco(LRegistroAjustes.DataPagamento));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTA_RV', CorrigeDadosBanco(LRegistroAjustes.DataRV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMDEB', CorrigeDadosBanco(LRegistroAjustes.NumeroDebito));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DOCNUM', CorrigeDadosBanco(LRegistroAjustes.NumeroDocumento));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_AJUFUT', CorrigeDadosBanco(LRegistroAjustes.ValorAjusteFuturo));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NOMFAN', CorrigeDadosBanco(LRegistroAjustes.NomeFantasia));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMAVI', CorrigeDadosBanco(LRegistroAjustes.NumeroAviso));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALPAG', CorrigeDadosBanco(LRegistroAjustes.ValorPago));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_RAZSOC', CorrigeDadosBanco(LRegistroAjustes.RazaoSocial));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTAEXP', CorrigeDadosBanco(LDataExpiracao));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMPED', CorrigeDadosBanco(LNumeroPedido));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_TIPREG', CorrigeDadosBanco(LRegistroAjustes.TipoRegistro));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTAIMP', CorrigeDadosBanco(LRegistroAjustes.DataImportacao, True));

      LGravacao.ExecSQL;

      TRedeCardFuncoes.pStepStatusGravacao(AProgress);
    End;
  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(LGravacao);
  End;
end;

procedure TRedeCardAPIPgto.GravaRegistrosTabelaNegociacaoPagamento(
  var AProgress: TcxProgressBar);
  Var
    LGravacao: TUniQuery;

    LRegistroNegociacaoPagamento: TNegociacao;
begin
  LGravacao := Nil;
  Try
    LGravacao := VS_FuncoesExternas.fICriaQuery;
    LGravacao.SQL.Text := TRedeCardFuncoes.RetornaSQLReplace('RED_PGODIR', ['RED_CONCIL']);

    AProgress.Position := 0;

    AProgress.Properties.Max := FNegociacoesPagamento.Count;

    For LRegistroNegociacaoPagamento In FNegociacoesPagamento Do
    Begin
      If Trim(LRegistroNegociacaoPagamento.CodigoBanco) = EmptyStr then
        Continue;

      If LRegistroNegociacaoPagamento.ValorLiquido = 0 Then
        Continue;

      LGravacao.Close;

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CODCED', CorrigeDadosBanco(LRegistroNegociacaoPagamento.CodigoClienteCedente));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_PAG_ID', CorrigeDadosBanco(LRegistroNegociacaoPagamento.IdPagamento));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NOMEMP', CorrigeDadosBanco(LRegistroNegociacaoPagamento.NomeEmpresa));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CONINT', CorrigeDadosBanco(LRegistroNegociacaoPagamento.NumeroContratoInterno));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CODMAR', CorrigeDadosBanco(LRegistroNegociacaoPagamento.CodigoMarca));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_TIPNEG', CorrigeDadosBanco(LRegistroNegociacaoPagamento.TipoNegociacao));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NOMCED', CorrigeDadosBanco(LRegistroNegociacaoPagamento.NomeCedente));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CODBCO', CorrigeDadosBanco(LRegistroNegociacaoPagamento.CodigoBanco));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_TIPPAG', CorrigeDadosBanco(LRegistroNegociacaoPagamento.TipoPagamento));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CODTIP', CorrigeDadosBanco(LRegistroNegociacaoPagamento.CodigoTipo));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMDOC', CorrigeDadosBanco(LRegistroNegociacaoPagamento.NumeroDocumento));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMCON', CorrigeDadosBanco(LRegistroNegociacaoPagamento.NumeroConta));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CODSTA', CorrigeDadosBanco(LRegistroNegociacaoPagamento.CodigoStatus));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_QTDDEP', CorrigeDadosBanco(LRegistroNegociacaoPagamento.ContagemDeposito));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALLIQ', CorrigeDadosBanco(LRegistroNegociacaoPagamento.ValorLiquido));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALATU', CorrigeDadosBanco(LRegistroNegociacaoPagamento.TemValorAtualizado));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DOCCED', CorrigeDadosBanco(LRegistroNegociacaoPagamento.DocumentoCedente));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_STATUS', CorrigeDadosBanco(LRegistroNegociacaoPagamento.Status));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_ORDCRE', CorrigeDadosBanco(LRegistroNegociacaoPagamento.OrdemCreditoPai));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NOMCOM', CorrigeDadosBanco(LRegistroNegociacaoPagamento.NomeComercial));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTAPAG', CorrigeDadosBanco(LRegistroNegociacaoPagamento.DataPagamento));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CODAGE', CorrigeDadosBanco(LRegistroNegociacaoPagamento.CodigoAgenciaBanco));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_TIPREG', CorrigeDadosBanco(LRegistroNegociacaoPagamento.Tipo));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUM_PV', CorrigeDadosBanco(LRegistroNegociacaoPagamento.NumeroEmpresa));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_ORICRE', CorrigeDadosBanco(LRegistroNegociacaoPagamento.OrigemOrdemCredito));

      LGravacao.ExecSQL;

      TRedeCardFuncoes.pStepStatusGravacao(AProgress);
    End;
  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(LGravacao);
  End;
end;

procedure TRedeCardAPIPgto.GravaRegistrosTabelaPgto(var AProgress: TcxProgressBar);
  Var
    LGravacao: TUniQuery;

    LRegistro: TRedeCardRegistroPgto;
begin
  LGravacao := Nil;
  Try
    LGravacao := VS_FuncoesExternas.fICriaQuery;
    LGravacao.SQL.Text := TRedeCardFuncoes.RetornaSQLReplace('RED_APPGTO', ['RED_CONCIL']);

    AProgress.Position := 0;

    AProgress.Properties.Max := FRedeCardRegistrosPgto.Count;

    For LRegistro In FRedeCardRegistrosPgto Do
    Begin
      FImportouPagamento := True;
      FImportouRegistro := True;

      LGravacao.Close;

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_TIPREG', CorrigeDadosBanco(LRegistro.TipoRegistro));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUM_PV', CorrigeDadosBanco(LRegistro.CodigoEstabelecimento));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTAPAG', CorrigeDadosBanco(LRegistro.DataPagamento));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUM_RV', CorrigeDadosBanco(LRegistro.NumeroRV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMORD', CorrigeDadosBanco(LRegistro.NumeroOrdem));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CODBAN', CorrigeDadosBanco(LRegistro.CodigoBandeira));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTAIMP', CorrigeDadosBanco(LRegistro.DataImportacao, True));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_PAG_ID', CorrigeDadosBanco(LRegistro.PagamentoID));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DESTIP', CorrigeDadosBanco(LRegistro.DescricaoTipo));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALBRU', CorrigeDadosBanco(LRegistro.ValorBruto));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALDES', CorrigeDadosBanco(LRegistro.ValorDesconto));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALLIQ', CorrigeDadosBanco(LRegistro.ValorLiquido));

      LGravacao.ExecSQL;

      TRedeCardFuncoes.pStepStatusGravacao(AProgress);
    End;
  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(LGravacao);
  End;
end;

procedure TRedeCardAPIPgto.GravaRegistrosTabelaVenda(
  var AProgress: TcxProgressBar);
  Var
    LGravacao: TUniQuery;

    LRegistroVenda: TRedeCardAPIRegistroVenda;
begin
  LGravacao := Nil;
  Try
    LGravacao := VS_FuncoesExternas.fICriaQuery;
    LGravacao.SQL.Text := TRedeCardFuncoes.RetornaSQLReplace('RED_APVEND', ['RED_CONCIL']);

    AProgress.Position := 0;

    AProgress.Properties.Max := FRedeCardRegistrosVenda.Count;

    For LRegistroVenda In FRedeCardRegistrosVenda Do
    Begin
      FImportouRegistro := True;
      FImportouVendas := True;

      LGravacao.Close;

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_TIPREG', CorrigeDadosBanco(LRegistroVenda.TipoRegistro));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUM_PV', CorrigeDadosBanco(LRegistroVenda.CodigoEstabelecimento));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTA_RV', CorrigeDadosBanco(LRegistroVenda.DataRV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUM_RV', CorrigeDadosBanco(LRegistroVenda.NumeroRV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMORD', CorrigeDadosBanco(LRegistroVenda.NumeroOrdem));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CODBAN', CorrigeDadosBanco(LRegistroVenda.CodigoBandeira));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTAIMP', CorrigeDadosBanco(LRegistroVenda.DataImportacao, True));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DOCNUM', CorrigeDadosBanco(LRegistroVenda.NumeroDocumento));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_RAZSOC', CorrigeDadosBanco(LRegistroVenda.RazaoSocial));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NOMFAN', CorrigeDadosBanco(LRegistroVenda.NomeFantasia));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CODAUT', LRegistroVenda.Autorizacao);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NOMPRO', CorrigeDadosBanco(LRegistroVenda.NomeProduto));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CODPRO', CorrigeDadosBanco(LRegistroVenda.CodigoProduto));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_TOTPAR', LRegistroVenda.TotalParcelas);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMNSU', LRegistroVenda.NSU);
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMTID', CorrigeDadosBanco(LRegistroVenda.TID));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTAVEN', CorrigeDadosBanco(LRegistroVenda.DataVenda));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_STATUS', CorrigeDadosBanco(LRegistroVenda.Status));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CHASTA', CorrigeDadosBanco(LRegistroVenda.ChargeBackStatus));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_TIPMAQ', CorrigeDadosBanco(LRegistroVenda.TipoMaquina));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CODTER', CorrigeDadosBanco(LRegistroVenda.CodigoTerminal));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_TIPCAP', CorrigeDadosBanco(LRegistroVenda.TipoCaptura));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_CODCAP', CorrigeDadosBanco(LRegistroVenda.CodigoCaptura));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_E_FLEX', CorrigeDadosBanco(LRegistroVenda.Flex));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_ID_ARD', CorrigeDadosBanco(LRegistroVenda.Ard));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMCAR', CorrigeDadosBanco(LRegistroVenda.NumeroCartao));

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALBRU', CorrigeDadosBanco(LRegistroVenda.ValorBruto));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_TAXMDR', CorrigeDadosBanco(LRegistroVenda.TaxaMDR));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALMDR', CorrigeDadosBanco(LRegistroVenda.ValorMDR));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_TAXFLE', CorrigeDadosBanco(LRegistroVenda.TaxaFlex));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_PERTAX', CorrigeDadosBanco(LRegistroVenda.PercentualTaxa));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALDES', CorrigeDadosBanco(LRegistroVenda.ValorDesconto));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALLIQ', CorrigeDadosBanco(LRegistroVenda.ValorLiquido));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALEMB', CorrigeDadosBanco(LRegistroVenda.ValorEmbarque));

      LGravacao.ExecSQL;

      TRedeCardFuncoes.pStepStatusGravacao(AProgress);
    End;
  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(LGravacao);
  End;
end;

procedure TRedeCardAPIPgto.GravaRegistrosTabelaVendaParcelada(
  var AProgress: TcxProgressBar);
  Var
    LGravacao: TUniQuery;

    LRegistroVendaParcelada: TRedeCardAPIRegistroVendaParcelada;
begin
  LGravacao := Nil;
  Try
    LGravacao := VS_FuncoesExternas.fICriaQuery;
    LGravacao.SQL.Text := TRedeCardFuncoes.RetornaSQLReplace('RED_APVPAR', ['RED_CONCIL']);

    AProgress.Position := 0;

    AProgress.Properties.Max := FRedeCardRegistrosVendaParcelada.Count;

    For LRegistroVendaParcelada In FRedeCardRegistrosVendaParcelada Do
    Begin
      FImportouRegistro := True;

      LGravacao.Close;

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUM_PV', CorrigeDadosBanco(LRegistroVendaParcelada.CodigoEstabelecimento));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTA_RV', CorrigeDadosBanco(LRegistroVendaParcelada.DataRV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUM_RV', CorrigeDadosBanco(LRegistroVendaParcelada.NumeroRV));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMNSU', CorrigeDadosBanco(LRegistroVendaParcelada.NSU));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMTID', CorrigeDadosBanco(LRegistroVendaParcelada.TID));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTAVEN', CorrigeDadosBanco(LRegistroVendaParcelada.DataVenda));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VEN_RV', CorrigeDadosBanco(LRegistroVendaParcelada.DataVencimento));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_NUMPAR', CorrigeDadosBanco(LRegistroVendaParcelada.Parcela));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_TOTPAR', CorrigeDadosBanco(LRegistroVendaParcelada.TotalParcelas));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_DTAIMP', CorrigeDadosBanco(LRegistroVendaParcelada.DataImportacao, True));

      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALPAR', CorrigeDadosBanco(LRegistroVendaParcelada.ValorParcela));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALDES', CorrigeDadosBanco(LRegistroVendaParcelada.ValorDesconto));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_LIQPAR', CorrigeDadosBanco(LRegistroVendaParcelada.ValorLiquido));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_BRU_RO', CorrigeDadosBanco(LRegistroVendaParcelada.ValorVenda));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_TAXMDR', CorrigeDadosBanco(LRegistroVendaParcelada.TaxaMDR));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_VALMDR', CorrigeDadosBanco(LRegistroVendaParcelada.ValorMDR));
      TRedeCardFuncoes.CarregaParametroDataset(LGravacao, 'RED_IMPTOT', 0);

      LGravacao.ExecSQL;

      TRedeCardFuncoes.pStepStatusGravacao(AProgress);
    End;
  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(LGravacao);
  End;
end;

procedure TRedeCardAPIPgto.ImportaAjustes(strString: String);
  Var
    LRegistroAjuste: TRedeCardAPIRegistroAjuste;
    LJsonObject,
    LJsonObjectValue,
    LJsonObjectGroup,
    LJsonObjectValueArray: TJsonObject;
    LJsonArray: TJSONArray;
    LJsonValue: TJsonValue;

    LStringJson: String;
begin
  LJsonObject := Nil;
  LJsonObjectValue := Nil;
  LJsonObjectGroup := Nil;
  LJsonObjectValueArray := Nil;
  LJsonArray := Nil;
  Try
    LJsonObject := TJSONObject.ParseJSONValue(strString) as TJSONObject;
    If LJsonObject = Nil Then
      Exit;

    FProximaPagina := '';
    LStringJson := LJsonObject.GetValue('cursor').ToJson;
    LJsonObjectValue := TJSONObject.ParseJSONValue(LStringJson) as TJSONObject;
    If RetornaValorJson(LJsonObjectValue,'hasNextKey') = 'true' Then
      FProximaPagina := RetornaValorJson(LJsonObjectValue,'nextKey');

    TRedeCardFuncoes.FreeAndNilObjeto(LJsonObjectValue);
    LStringJson := LJsonObject.GetValue('content').ToJson;
    LJsonObjectValue := TJSONObject.ParseJSONValue(LStringJson) as TJSONObject;

    LStringJson := LJsonObjectValue.GetValue('charges').ToJson;
    LJsonArray := TJSONObject.ParseJSONValue(LStringJson) as TJsonArray;

    FProgresso.Position := 0;
    FProgresso.Properties.Max := Ocorrencias('"saleSummaryNumber"',strString);

    For LJsonValue In LJsonArray Do
    Begin
      Try
        LJsonObjectValueArray := TJSONObject.ParseJSONValue(LJSonValue.ToString) as TJSONObject;

        LRegistroAjuste := TRedeCardAPIRegistroAjuste.Create;

        LRegistroAjuste.ValorAjuste       := RetornaValorJson(LJsonObjectValueArray,'debitCompensatedAmount',varDouble);
        LRegistroAjuste.CodigoAjuste      := RetornaValorJson(LJsonObjectValueArray, 'adjustmentTypeCode');
        LRegistroAjuste.DescricaoAjuste   := RetornaValorJson(LJsonObjectValueArray, 'adjustmentTypeDescription');
        LRegistroAjuste.CodigoEstabelecimento := FEstabelecimentoAtual.PadLeft(9, '0');
        LRegistroAjuste.NumeroRV          := RetornaValorJson(LJsonObjectValueArray, 'saleSummaryNumber');
        LRegistroAjuste.NumeroRV          := TRedeCardFuncoes.IIF(TRedeCardFuncoes.fEmptyStr(LRegistroAjuste.NumeroRV),'0',LRegistroAjuste.NumeroRV);
        LRegistroAjuste.DataPagamento     := RetornaValorJson(LJsonObjectValueArray, 'paymentDate');
        LRegistroAjuste.DataRV            := RetornaValorJson(LJsonObjectValueArray, 'compensatedDate');
        LRegistroAjuste.NumeroDebito      := RetornaValorJson(LJsonObjectValueArray, 'debitNumber');
        LRegistroAjuste.NumeroDebito      := TRedeCardFuncoes.IIF(TRedeCardFuncoes.fEmptyStr(LRegistroAjuste.NumeroDebito),'00000000',LRegistroAjuste.NumeroDebito.PadLeft(8,'0'));
        LRegistroAjuste.NumeroDocumento   := RetornaValorJson(LJsonObjectValueArray, 'documentNumber');
        LRegistroAjuste.ValorAjusteFuturo := RetornaValorJson(LJsonObjectValueArray,'debitToBeCompensatedAmount',varDouble);
        LRegistroAjuste.NomeFantasia      := RetornaValorJson(LJsonObjectValueArray, 'tradeName');

        If LJsonObjectValueArray.GetValue('cancellation') <> Nil Then
        Begin
          LStringJson := LJsonObjectValueArray.GetValue('cancellation').ToJson;
          LJsonObjectGroup := TJSONObject.ParseJSONValue(LJSonValue.ToString) as TJSONObject;
        End;

        If Assigned(LJsonObjectGroup) Then
          LRegistroAjuste.NumeroAviso := RetornaValorJson(LJsonObjectGroup, 'noticeNumber')
        Else
          LRegistroAjuste.NumeroAviso := '0';

        LRegistroAjuste.ValorPago         := RetornaValorJson(LJsonObjectValueArray,'debitToBeCompensatedAmount',varDouble);
        LRegistroAjuste.RazaoSocial       := RetornaValorJson(LJsonObjectValueArray, 'companyName');
        LRegistroAjuste.DataExpiracao     := RetornaValorJson(LJsonObjectValueArray, 'creditOrderExpirationDate');
        LRegistroAjuste.NumeroPedido      := RetornaValorJson(LJsonObjectValueArray, 'creditOrderNumber');
        LRegistroAjuste.TipoRegistro      := RetornaValorJson(LJsonObjectValueArray, 'type');
        LRegistroAjuste.DataImportacao    := DateToStr(Date);

        FRedeCardRegistrosAjuste.Add(LRegistroAjuste);

        If (VS_ListaEstabelecimentos.IndexOf(LRegistroAjuste.CodigoEstabelecimento) < 0) Then
          VS_ListaEstabelecimentos.Add(LRegistroAjuste.CodigoEstabelecimento);
      Finally
        TRedeCardFuncoes.FreeAndNilObjeto(LJsonObjectGroup);
        TRedeCardFuncoes.FreeAndNilObjeto(LJsonObjectValueArray);
      End;
      TRedeCardFuncoes.pStepStatusGravacao(FProgresso);
    End;
    FProgresso.Position := 0;
  Finally
    TRedeCardFuncoes.FreeAndNilObjeto(LJsonArray);
    TRedeCardFuncoes.FreeAndNilObjeto(LJsonObjectValue);
    TRedeCardFuncoes.FreeAndNilObjeto(LJsonObject);
  End;

end;

function TRedeCardAPIPgto.Ocorrencias(TextoProcurado: string; Texto: string): integer;
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

procedure TRedeCardAPIPgto.ImportaPagamentos(strString: String);
  Var
    LRegistro: TRedeCardRegistroPgto;
    LJsonObject,
    LJsonObjectValue,
    LJsonObjectValueArray: TJsonObject;
    LJsonArray: TJSONArray;
    LJsonValue: TJsonValue;

    LJsonString: String;
begin
  LJsonObject := Nil;
  LJsonObjectValue := Nil;
  LJsonObjectValueArray := Nil;
  LJsonArray := Nil;
  Try
    LJsonObject := TJSONObject.ParseJSONValue(strString) as TJSONObject;
    If LJsonObject = Nil Then
      Exit;

    FProximaPagina := '';

    LJsonString := LJsonObject.GetValue('cursor').ToJson;
    LJsonObjectValue := TJSONObject.ParseJSONValue(LJsonString) as TJSONObject;
    If RetornaValorJson(LJsonObjectValue,'hasNextKey') = 'true' Then
      FProximaPagina := RetornaValorJson(LJsonObjectValue,'nextKey');

    TRedeCardFuncoes.FreeAndNilObjeto(LJsonObjectValue);
    LJsonString := LJsonObject.GetValue('content').ToJson;
    LJsonObjectValue := TJSONObject.ParseJSONValue(LJsonString) as TJSONObject;

    LJsonString := LJsonObjectValue.GetValue('paymentsCreditOrders').ToJson;
    LJsonArray := TJSONObject.ParseJSONValue(LJsonString) as TJsonArray;

    FProgresso.Position := 0;
    FProgresso.Properties.Max := Ocorrencias('"paymentId"',strString);

    For LJsonValue In LJsonArray Do
    Begin
      Try
        LJsonObjectValueArray := TJSONObject.ParseJSONValue(LJSonValue.ToString) as TJSONObject;

        LRegistro := TRedeCardRegistroPgto.Create;
        LRegistro.TipoRegistro := RetornaValorJson(LJsonObjectValueArray, 'typeCode');
        LRegistro.CodigoEstabelecimento := FEstabelecimentoAtual.PadLeft(9, '0');
        LRegistro.PagamentoID := RetornaValorJson(LJsonObjectValueArray, 'paymentId');
        LRegistro.DataPagamento := RetornaValorJson(LJsonObjectValueArray, 'paymentDate');
        LRegistro.NumeroRV := RetornaValorJson(LJsonObjectValueArray, 'saleSummaryNumber');
        LRegistro.NumeroOrdem := RetornaValorJson(LJsonObjectValueArray, 'creditOrderNumber');
        LRegistro.CodigoBandeira := RetornaValorJson(LJsonObjectValueArray, 'brandCode');
        LRegistro.DescricaoTipo := RetornaValorJson(LJsonObjectValueArray, 'type');
        LRegistro.DataImportacao := DateToStr(Date);

        LRegistro.ValorBruto := RetornaValorJson(LJsonObjectValueArray,'amount',varDouble);
        LRegistro.ValorDesconto := RetornaValorJson(LJsonObjectValueArray,'discountAmount',varDouble);
        LRegistro.ValorLiquido := RetornaValorJson(LJsonObjectValueArray,'netAmount',varDouble);

        FRedeCardRegistrosPgto.Add(LRegistro);

        If (VS_ListaEstabelecimentos.IndexOf(LRegistro.CodigoEstabelecimento) < 0) Then
          VS_ListaEstabelecimentos.Add(LRegistro.CodigoEstabelecimento);
      Finally
        TRedeCardFuncoes.FreeAndNilObjeto(LJsonObjectValueArray);
      End;
      TRedeCardFuncoes.pStepStatusGravacao(FProgresso);
    End;

    FProgresso.Position := 0;
  Finally
    TRedeCardFuncoes.FreeAndNilObjeto(LJsonArray);
    TRedeCardFuncoes.FreeAndNilObjeto(LJsonObjectValue);
    TRedeCardFuncoes.FreeAndNilObjeto(LJsonObject);
  End;
end;

procedure TRedeCardAPIPgto.ImportaPagamentosDiario(strString: String);
  Var
    LConsultaPagamentoDiario: TConsultaPagamentoDiarioRedeCardOnline;
begin
  LConsultaPagamentoDiario := Nil;
  Try
    FProximaPagina:= '';
    LConsultaPagamentoDiario := TConsultaPagamentoDiarioRedeCardOnline.Create(strString);
    LConsultaPagamentoDiario.CopiaItensnegociacoesGlobais(FNegociacoesPagamento);
    If LConsultaPagamentoDiario.TemProximaChave Then
      FProximaPagina := LConsultaPagamentoDiario.ProximaPagina;
  Finally
    If Assigned(LConsultaPagamentoDiario) Then
      FreeAndNil(LConsultaPagamentoDiario);
  End;
end;

procedure TRedeCardAPIPgto.ImportaVendas(strString: String);
  Var
    LJsonObject,
    LJsonObjectValue,
    LJsonObjectGroup,
    LJsonObjectValueArray: TJsonObject;
    LJsonArray: TJSONArray;
    LJsonValue: TJsonValue;
    LRegistroVenda: TRedeCardAPIRegistroVenda;

    LJsonString: String;
begin
  LJsonObject := Nil;
  LJsonObjectValue := Nil;
  LJsonObjectGroup := Nil;
  LJsonObjectValueArray := Nil;
  LJsonArray := Nil;
  Try
    LJsonObject := TJSONObject.ParseJSONValue(strString) as TJSONObject;
    If LJsonObject = Nil Then
      Exit;

    FProximaPagina := '';
    LJsonString := LJsonObject.GetValue('cursor').ToJson;
    LJsonObjectValue := TJSONObject.ParseJSONValue(LJsonString) as TJSONObject;
    If RetornaValorJson(LJsonObjectValue,'hasNextKey') = 'true' Then
      FProximaPagina := RetornaValorJson(LJsonObjectValue,'nextKey');

    TRedeCardFuncoes.FreeAndNilObjeto(LJsonObjectValue);
    LJsonString := LJsonObject.GetValue('content').ToJson;
    LJsonObjectValue := TJSONObject.ParseJSONValue(LJsonString) as TJSONObject;

    LJsonString := LJsonObjectValue.GetValue('transactions').ToJson;
    LJsonArray := TJSONObject.ParseJSONValue(LJsonString) as TJsonArray;

    FProgresso.Position := 0;
    FProgresso.Properties.Max := Ocorrencias('"authorizationCode"',strString);

    For LJsonValue In LJsonArray Do
    Begin
      Try
        LJsonObjectValueArray := TJSONObject.ParseJSONValue(LJSonValue.ToString) as TJSONObject;

        If MatchStr(RetornaValorJson(LJsonObjectValueArray, 'status'), ['REVERSED']) Then
          Continue;

        LRegistroVenda := TRedeCardAPIRegistroVenda.Create;

        If LJsonObjectValueArray.GetValue('merchant') <> Nil Then
        Begin
          LJsonString := LJsonObjectValueArray.GetValue('merchant').ToJson;
          LJsonObjectGroup := TJSONObject.ParseJSONValue(LJsonString) as TJSONObject;
          LRegistroVenda.CodigoEstabelecimento := RetornaValorJson(LJsonObjectGroup, 'companyNumber');
          LRegistroVenda.CodigoEstabelecimento :=  LRegistroVenda.CodigoEstabelecimento.PadLeft(9, '0');
          LRegistroVenda.NumeroDocumento := RetornaValorJson(LJsonObjectGroup, 'documentNumber');
          LRegistroVenda.NomeFantasia := RetornaValorJson(LJsonObjectGroup, 'tradeName');
          LRegistroVenda.RazaoSocial := RetornaValorJson(LJsonObjectGroup, 'companyName');
        End;

        LRegistroVenda.CodigoBandeira := RetornaValorJson(LJsonObjectValueArray, 'brandCode');

        LRegistroVenda.Autorizacao := RetornaValorJson(LJsonObjectValueArray, 'strAuthorizationCode');
        If TRedeCardFuncoes.fEmptyStr(LRegistroVenda.Autorizacao) Then
          LRegistroVenda.Autorizacao := RetornaValorJson(LJsonObjectValueArray, 'authorizationCode');

        TRedeCardFuncoes.FreeAndNilObjeto(LJsonObjectGroup);
        If LJsonObjectValueArray.GetValue('modality') <> Nil Then
        Begin
          LJsonString := LJsonObjectValueArray.GetValue('modality').ToJson;
          LJsonObjectGroup := TJSONObject.ParseJSONValue(LJsonString) as TJSONObject;
          LRegistroVenda.TipoRegistro := RetornaValorJson(LJsonObjectGroup, 'type');
          LRegistroVenda.NomeProduto := RetornaValorJson(LJsonObjectGroup, 'product');
          LRegistroVenda.CodigoProduto := RetornaValorJson(LJsonObjectGroup, 'productCode');
        End;

        LRegistroVenda.TotalParcelas := RetornaValorJson(LJsonObjectValueArray, 'installmentQuantity');
        LRegistroVenda.NSU := RetornaValorJson(LJsonObjectValueArray, 'nsu');
        LRegistroVenda.TID := RetornaValorJson(LJsonObjectValueArray, 'tid');
        LRegistroVenda.NumeroRV := RetornaValorJson(LJsonObjectValueArray, 'saleSummaryNumber');
        LRegistroVenda.NumeroOrdem := RetornaValorJson(LJsonObjectValueArray, 'orderNumber');
        LRegistroVenda.DataRV := RetornaValorJson(LJsonObjectValueArray, 'movementDate');
        LRegistroVenda.DataVenda := RetornaValorJson(LJsonObjectValueArray, 'saleDate');
        LRegistroVenda.Status := RetornaValorJson(LJsonObjectValueArray, 'status');
        LRegistroVenda.ChargeBackStatus := RetornaValorJson(LJsonObjectValueArray, 'chargebackStatus');

        LRegistroVenda.TipoMaquina := RetornaValorJson(LJsonObjectValueArray, 'deviceType');
        LRegistroVenda.CodigoTerminal := RetornaValorJson(LJsonObjectValueArray, 'device');
        LRegistroVenda.TipoCaptura := RetornaValorJson(LJsonObjectValueArray, 'captureType');
        LRegistroVenda.Ard := RetornaValorJson(LJsonObjectValueArray, 'ard');

        LRegistroVenda.DataImportacao := DateToStr(Date);

        LRegistroVenda.ValorBruto := RetornaValorJson(LJsonObjectValueArray,'amount',varDouble);
        LRegistroVenda.TaxaMDR := RetornaValorJson(LJsonObjectValueArray,'mdrFee',varDouble);
        LRegistroVenda.ValorMDR := RetornaValorJson(LJsonObjectValueArray,'mdrAmount',varDouble);

        LRegistroVenda.Flex := 'N';
        If RetornaValorJson(LJsonObjectValueArray, 'flex') = 'true' Then
          LRegistroVenda.Flex := 'S';

        LRegistroVenda.TaxaFlex := RetornaValorJson(LJsonObjectValueArray,'flexFee',varDouble);
        LRegistroVenda.ValorFlex := RetornaValorJson(LJsonObjectValueArray,'flexAmount',varDouble);
        LRegistroVenda.PercentualTaxa := RetornaValorJson(LJsonObjectValueArray,'feeTotal',varDouble);
        LRegistroVenda.ValorDesconto := RetornaValorJson(LJsonObjectValueArray,'discountAmount',varDouble);
        LRegistroVenda.ValorLiquido := RetornaValorJson(LJsonObjectValueArray,'netAmount',varDouble);
        LRegistroVenda.ValorEmbarque := RetornaValorJson(LJsonObjectValueArray,'boardingFeeAmount',varDouble);

        If RetornaValorJson(LJsonObjectValueArray, 'tokenized') = 'false' Then
          LRegistroVenda.NumeroCartao := RetornaValorJson(LJsonObjectValueArray, 'cardNumber')
        Else
          LRegistroVenda.NumeroCartao := RetornaValorJson(LJsonObjectValueArray, 'tokenNumber');

        FRedeCardRegistrosVenda.Add(LRegistroVenda);

        If (VS_ListaEstabelecimentos.IndexOf(LRegistroVenda.CodigoEstabelecimento) < 0) Then
          VS_ListaEstabelecimentos.Add(LRegistroVenda.CodigoEstabelecimento);

      Finally
        TRedeCardFuncoes.FreeAndNilObjeto(LJsonObjectGroup);
        TRedeCardFuncoes.FreeAndNilObjeto(LJsonObjectValueArray);
      End;
      TRedeCardFuncoes.pStepStatusGravacao(FProgresso);
    End;

    FProgresso.Position := 0;
  Finally
    TRedeCardFuncoes.FreeAndNilObjeto(LJsonArray);
    TRedeCardFuncoes.FreeAndNilObjeto(LJsonObjectValue);
    TRedeCardFuncoes.FreeAndNilObjeto(LJsonObject);
  End;
end;

procedure TRedeCardAPIPgto.ImportaVendasParceladas(strString: String);
  Var
    LJsonObject,
    LJsonObjectValue,
    LJsonObjectValueArray: TJsonObject;
    LJsonArray: TJSONArray;
    LJsonValue: TJsonValue;
    LRegistroVendaParcelada: TRedeCardAPIRegistroVendaParcelada;

    LJsonString: String;
begin
  LJsonObject := Nil;
  LJsonObjectValue := Nil;
  LJsonObjectValueArray := Nil;
  LJsonArray := Nil;
  Try
    LJsonObject := TJSONObject.ParseJSONValue(strString) as TJSONObject;
    If LJsonObject = Nil Then
      Exit;

    FProximaPagina := '';
    LJsonString := LJsonObject.GetValue('cursor').ToJson;
    LJsonObjectValue := TJSONObject.ParseJSONValue(LJsonString) as TJSONObject;
    If RetornaValorJson(LJsonObjectValue,'hasNextKey') = 'true' Then
      FProximaPagina := RetornaValorJson(LJsonObjectValue,'nextKey');

    TRedeCardFuncoes.FreeAndNilObjeto(LJsonObjectValue);
    LJsonString := LJsonObject.GetValue('content').ToJson;
    LJsonObjectValue := TJSONObject.ParseJSONValue(LJsonString) as TJSONObject;

    LJsonString := LJsonObjectValue.GetValue('installments').ToJson;
    LJsonArray := TJSONObject.ParseJSONValue(LJsonString) as TJsonArray;

    FProgresso.Position := 0;
    FProgresso.Properties.Max := Ocorrencias('"saleSummaryNumber"',strString);

    For LJsonValue In LJsonArray Do
    Begin
      Try
        LJsonObjectValueArray := TJSONObject.ParseJSONValue(LJSonValue.ToString) as TJSONObject;

        LRegistroVendaParcelada := TRedeCardAPIRegistroVendaParcelada.Create;
        LRegistroVendaParcelada.CodigoEstabelecimento := RetornaValorJson(LJsonObjectValueArray, 'companyNumber');
        LRegistroVendaParcelada.CodigoEstabelecimento := LRegistroVendaParcelada.CodigoEstabelecimento.PadLeft(9, '0');
        LRegistroVendaParcelada.NSU := RetornaValorJson(LJsonObjectValueArray, 'nsu');

        LRegistroVendaParcelada.DataRV := RetornaValorJson(LJsonObjectValueArray, 'movementDate');
        If LRegistroVendaParcelada.DataRV.IsEmpty Then
          LRegistroVendaParcelada.DataRV := RetornaValorJson(LJsonObjectValueArray, 'saleDate');

        LRegistroVendaParcelada.NumeroRV := RetornaValorJson(LJsonObjectValueArray, 'saleSummaryNumber');
        LRegistroVendaParcelada.TID := RetornaValorJson(LJsonObjectValueArray, 'tid');
        LRegistroVendaParcelada.DataVenda := RetornaValorJson(LJsonObjectValueArray, 'saleDate');
        LRegistroVendaParcelada.DataVencimento := RetornaValorJson(LJsonObjectValueArray, 'expirationDate');
        LRegistroVendaParcelada.Parcela := RetornaValorJson(LJsonObjectValueArray, 'installmentNumber');
        LRegistroVendaParcelada.TotalParcelas := RetornaValorJson(LJsonObjectValueArray, 'installmentQuantity');
        LRegistroVendaParcelada.DataImportacao := DateToStr(Date);

        LRegistroVendaParcelada.ValorParcela := RetornaValorJson(LJsonObjectValueArray,'amount',varDouble);
        LRegistroVendaParcelada.ValorDesconto := RetornaValorJson(LJsonObjectValueArray,'discountAmount',varDouble);
        LRegistroVendaParcelada.ValorLiquido := RetornaValorJson(LJsonObjectValueArray,'netAmount',varDouble);
        LRegistroVendaParcelada.TaxaMDR := RetornaValorJson(LJsonObjectValueArray,'mdrFee',varDouble);
        LRegistroVendaParcelada.ValorMDR := RetornaValorJson(LJsonObjectValueArray,'mdrAmount',varDouble);
        LRegistroVendaParcelada.ValorVenda := RetornaValorJson(LJsonObjectValueArray,'saleAmount',varDouble);

        FRedeCardRegistrosVendaParcelada.Add(LRegistroVendaParcelada);

        If (VS_ListaEstabelecimentos.IndexOf(LRegistroVendaParcelada.CodigoEstabelecimento) < 0) Then
          VS_ListaEstabelecimentos.Add(LRegistroVendaParcelada.CodigoEstabelecimento);

      Finally
        TRedeCardFuncoes.FreeAndNilObjeto(LJsonObjectValueArray);
      End;
      TRedeCardFuncoes.pStepStatusGravacao(FProgresso);
    End;

    FProgresso.Position := 0;
  Finally
    TRedeCardFuncoes.FreeAndNilObjeto(LJsonArray);
    TRedeCardFuncoes.FreeAndNilObjeto(LJsonObjectValue);
    TRedeCardFuncoes.FreeAndNilObjeto(LJsonObject);
  End;
end;

procedure TRedeCardAPIPgto.pAdicionaLinha(strString: String);
begin

  If strString.Trim.IsEmpty Then
    Exit;

  Try
    If FTipoDoArquivo = 'PAGAMENTOS' Then
    Begin
      ImportaPagamentos(strString);
    End

    Else If FTipoDoArquivo = 'PAGAMENTOS DIARIOS' Then
    Begin
      ImportaPagamentosDiario(strString);
    End

    Else If FTipoDoArquivo = 'VENDAS' Then
    Begin
      ImportaVendas(strString);
    End

    Else If FTipoDoArquivo = 'VENDAS PARCELADAS' Then
    Begin
      ImportaVendasParceladas(strString);
    End

    Else If FTipoDoArquivo = 'AJUSTES' Then
    Begin
      ImportaAjustes(strString);
    End;

  Except
    Raise;
  End;
end;

procedure TRedeCardAPIPgto.pGravarRegistros(pgbProg: TcxProgressBar);
begin
  VS_FuncoesExternas.fIStartTransaction;
  Try
    GravaRegistrosTabelaPgto(pgbProg);

    GravaRegistrosTabelaNegociacaoPagamento(pgbProg);

    GravaRegistrosTabelaVenda(pgbProg);

    GravaRegistrosTabelaVendaParcelada(pgbProg);

    GravaRegistrosTabelaAjustes(pgbProg);

    FRedeCardRegistrosPgto.Clear;
    FRedeCardRegistrosVenda.Clear;
    FRedeCardRegistrosVendaParcelada.Clear;
    FRedeCardRegistrosAjuste.Clear;
    FNegociacoesPagamento.Clear;

    TRedeCardFuncoes.GravarEstabelecimentos(True);

    VS_FuncoesExternas.fICommit;
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.fIRollback;

      Raise Exception.Create('Ocorreu um erro ao gravar os registros.' +
                             'Erro gerado: ' + E.Message);
    End;
  End;
end;

function TRedeCardAPIPgto.RetornaValorJson(AObjeto: TJsonObject; ANomeCampo: String; ATipoRetorno: TVarType = varString): Variant;
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

end.
