unit untRedeCardAPIPgto;

interface
uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls,
     Dialogs, Forms, untTRedeCard, System.Generics.Collections, Json,
     untTConsultaPagamentoDiarioRedeCardOnline;

Type
  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrEstruturaRedeCardAPIPgto = Array Of TEstruturaPgto;

  TRedeCardAPIPgto = Class(TInterfacedObject, ICartoes)
  Private
    FRedeCardRegistrosPgto: TList<TRedeCardRegistroPgto>;

    FRedeCardRegistrosVenda: TList<TRedeCardAPIRegistroVenda>;

    FRedeCardRegistrosVendaParcelada: TList<TRedeCardAPIRegistroVendaParcelada>;

    FRedeCardRegistrosAjuste: TList<TRedeCardAPIRegistroAjuste>;

    FNegociacoesPagamento: TList<TNegociacao>;

    FProximaPagina: String;

    FImportouRegistro,
    FImportouPagamento,
    FImportouVendas: Boolean;

    FEstabelecimentoAtual,
    FTipoDoArquivo : String;
    FProgresso: TProgressBar;

    function CorrigeDadosBanco(AValor: Variant;
                               ACampoData: Boolean = False): Variant;

    function RetornaSQLReplaceTabela(ATabela: String): String;

    function RetornaValorJson(AObjeto: TJsonObject; ANomeCampo: String; ATipoRetorno: TVarType = varString): Variant;

    procedure ImportaPagamentos(strString: String);
    procedure ImportaPagamentosDiario(strString: String);
    procedure ImportaVendas(strString: String);
    procedure ImportaVendasParceladas(strString: String);
    procedure ImportaAjustes(strString: String);
    function Ocorrencias(TextoProcurado: string; Texto: string): integer;
  Public
    constructor Create;

    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaRedeCardAPIPgto;

    property ProximaPagina: String read FProximaPagina;
    property ImportouRegistro: Boolean read FImportouRegistro;
    property ImportouPagamento: Boolean read FImportouPagamento;
    property EstabelecimentoAtual: String read FEstabelecimentoAtual write FEstabelecimentoAtual;
    property TipoDoArquivo: String read FTipoDoArquivo write FTipoDoArquivo;
    property Progresso: TProgressBar read FProgresso write FProgresso;
    property ImportouVendas : Boolean Read FImportouVendas Write FImportouVendas;
  End;

  Var
    NomeArquivo,
    DataArquivo: String;

Const
  NOMTAB = 'RED_APPGTO';
  INICAM = 'RED_';

implementation

uses untFuncoes, untIDataSet;

{ TRedeCardAPIPgto }

function TRedeCardAPIPgto.CorrigeDadosBanco(AValor: Variant;
                                            ACampoData: Boolean = False): Variant;
begin
  Result := Null;
  If Not fEmptyStr(AValor) Then
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

  FRedeCardRegistrosPgto := TList<TRedeCardRegistroPgto>.Create;
  FRedeCardRegistrosVenda := TList<TRedeCardAPIRegistroVenda>.Create;
  FRedeCardRegistrosVendaParcelada := TList<TRedeCardAPIRegistroVendaParcelada>.Create;
  FRedeCardRegistrosAjuste := TList<TRedeCardAPIRegistroAjuste>.Create;
  FNegociacoesPagamento := TList<TNegociacao>.Create;
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

procedure TRedeCardAPIPgto.ImportaAjustes(strString: String);
  Var
    LRegistroAjuste: TRedeCardAPIRegistroAjuste;
    LJsonObject,
    LJsonObjectValue,
    LJsonObjectGroup: TJsonObject;
    LJsonArray: TJSONArray;
    LJsonValue: TJsonValue;
begin
  Try
    LJsonObject := TJSONObject.ParseJSONValue(strString) as TJSONObject;

    FProximaPagina := '';
    LJsonObjectValue := LJsonObject.GetValue<TJSONObject>('cursor') as TJSONObject;
    If RetornaValorJson(LJsonObjectValue,'hasNextKey') = 'true' Then
      FProximaPagina := RetornaValorJson(LJsonObjectValue,'nextKey');

    LJsonObjectValue := LJsonObject.GetValue<TJSONObject>('content') as TJSONObject;

    LJsonArray := LJsonObjectValue.GetValue('charges') as TJsonArray;

    FProgresso.Position := 0;
    FProgresso.Max := Ocorrencias('"saleSummaryNumber"',strString);

    For LJsonValue In LJsonArray Do
    Begin
      LJsonObjectValue := TJSONObject.ParseJSONValue(LJSonValue.ToString) as TJSONObject;

      LRegistroAjuste := TRedeCardAPIRegistroAjuste.Create;

      LRegistroAjuste.ValorAjuste       := RetornaValorJson(LJsonObjectValue,'debitCompensatedAmount',varDouble);
      LRegistroAjuste.CodigoAjuste      := RetornaValorJson(LJsonObjectValue, 'adjustmentTypeCode');
      LRegistroAjuste.DescricaoAjuste   := RetornaValorJson(LJsonObjectValue, 'adjustmentTypeDescription');
      LRegistroAjuste.CodigoEstabelecimento := FEstabelecimentoAtual.PadLeft(9, '0');
      LRegistroAjuste.NumeroRV          := RetornaValorJson(LJsonObjectValue, 'saleSummaryNumber');
      LRegistroAjuste.NumeroRV          := IIF(fEmptyStr(LRegistroAjuste.NumeroRV),'0',LRegistroAjuste.NumeroRV);
      LRegistroAjuste.DataPagamento     := RetornaValorJson(LJsonObjectValue, 'paymentDate');
      LRegistroAjuste.DataRV            := RetornaValorJson(LJsonObjectValue, 'compensatedDate');
      LRegistroAjuste.NumeroDebito      := RetornaValorJson(LJsonObjectValue, 'debitNumber');
      LRegistroAjuste.NumeroDebito      := IIF(fEmptyStr(LRegistroAjuste.NumeroDebito),'00000000',LRegistroAjuste.NumeroDebito.PadLeft(8,'0'));
      LRegistroAjuste.NumeroDocumento   := RetornaValorJson(LJsonObjectValue, 'documentNumber');
      LRegistroAjuste.ValorAjusteFuturo := RetornaValorJson(LJsonObjectValue,'debitToBeCompensatedAmount',varDouble);
      LRegistroAjuste.NomeFantasia      := RetornaValorJson(LJsonObjectValue, 'tradeName');

      LJsonObjectGroup := LJsonObjectValue.GetValue('cancellation') as TJSONObject;
      If Assigned(LJsonObjectGroup) Then
        LRegistroAjuste.NumeroAviso := RetornaValorJson(LJsonObjectGroup, 'noticeNumber')
      Else
        LRegistroAjuste.NumeroAviso := '0';

      LRegistroAjuste.ValorPago         := RetornaValorJson(LJsonObjectValue,'debitToBeCompensatedAmount',varDouble);
      LRegistroAjuste.RazaoSocial       := RetornaValorJson(LJsonObjectValue, 'companyName');
      LRegistroAjuste.DataExpiracao     := RetornaValorJson(LJsonObjectValue, 'creditOrderExpirationDate');
      LRegistroAjuste.NumeroPedido      := RetornaValorJson(LJsonObjectValue, 'creditOrderNumber');
      LRegistroAjuste.TipoRegistro      := RetornaValorJson(LJsonObjectValue, 'type');
      LRegistroAjuste.DataImportacao    := DateToStr(Date);

      FRedeCardRegistrosAjuste.Add(LRegistroAjuste);

      If (lstEstabel.IndexOf(LRegistroAjuste.CodigoEstabelecimento) < 0) Then
        lstEstabel.Add(LRegistroAjuste.CodigoEstabelecimento);

      FProgresso.Position := FProgresso.Position + 1;
      Application.ProcessMessages;
    End;
    FProgresso.Position := 0;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
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
    LJsonObjectValue: TJsonObject;
    LJsonArray: TJSONArray;
    LJsonValue: TJsonValue;
begin

  Try
    LJsonObject := TJSONObject.ParseJSONValue(strString) as TJSONObject;

    FProximaPagina := '';
    LJsonObjectValue := LJsonObject.GetValue<TJSONObject>('cursor') as TJSONObject;
    If RetornaValorJson(LJsonObjectValue,'hasNextKey') = 'true' Then
      FProximaPagina := RetornaValorJson(LJsonObjectValue,'nextKey');

    LJsonObjectValue := LJsonObject.GetValue<TJSONObject>('content') as TJSONObject;

    LJsonArray := LJsonObjectValue.GetValue('paymentsCreditOrders') as TJsonArray;

    FProgresso.Position := 0;
    FProgresso.Max := Ocorrencias('"paymentId"',strString);

    For LJsonValue In LJsonArray Do
    Begin
      LJsonObjectValue := TJSONObject.ParseJSONValue(LJSonValue.ToString) as TJSONObject;

      LRegistro := TRedeCardRegistroPgto.Create;
      LRegistro.TipoRegistro := RetornaValorJson(LJsonObjectValue, 'typeCode');
      LRegistro.CodigoEstabelecimento := FEstabelecimentoAtual.PadLeft(9, '0');
      LRegistro.PagamentoID := RetornaValorJson(LJsonObjectValue, 'paymentId');
      LRegistro.DataPagamento := RetornaValorJson(LJsonObjectValue, 'paymentDate');
      LRegistro.NumeroRV := RetornaValorJson(LJsonObjectValue, 'saleSummaryNumber');
      LRegistro.NumeroOrdem := RetornaValorJson(LJsonObjectValue, 'creditOrderNumber');
      LRegistro.CodigoBandeira := RetornaValorJson(LJsonObjectValue, 'brandCode');
      LRegistro.DescricaoTipo := RetornaValorJson(LJsonObjectValue, 'type');
      LRegistro.DataImportacao := DateToStr(Date);

      LRegistro.ValorBruto := RetornaValorJson(LJsonObjectValue,'amount',varDouble);
      LRegistro.ValorDesconto := RetornaValorJson(LJsonObjectValue,'discountAmount',varDouble);
      LRegistro.ValorLiquido := RetornaValorJson(LJsonObjectValue,'netAmount',varDouble);

      FRedeCardRegistrosPgto.Add(LRegistro);

      If (lstEstabel.IndexOf(LRegistro.CodigoEstabelecimento) < 0) Then
        lstEstabel.Add(LRegistro.CodigoEstabelecimento);

      FProgresso.Position := FProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    FProgresso.Position := 0;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TRedeCardAPIPgto.ImportaPagamentosDiario(strString: String);
  Var
    LConsultaPagamentoDiario: TConsultaPagamentoDiarioRedeCardOnline;
begin
  Try
    Try
      FProximaPagina:= '';
      LConsultaPagamentoDiario := TConsultaPagamentoDiarioRedeCardOnline.Create(strString);
      FNegociacoesPagamento.AddRange(LConsultaPagamentoDiario.NegociacoesGlobais);
      If LConsultaPagamentoDiario.TemProximaChave Then
        FProximaPagina := LConsultaPagamentoDiario.ProximaPagina;
    Finally
      FreeAndNil(LConsultaPagamentoDiario);
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TRedeCardAPIPgto.ImportaVendas(strString: String);
  Var
    LJsonObject,
    LJsonObjectValue,
    LJsonObjectGroup: TJsonObject;
    LJsonArray: TJSONArray;
    LJsonValue: TJsonValue;
    LRegistroVenda: TRedeCardAPIRegistroVenda;
begin

  Try
    LJsonObject := TJSONObject.ParseJSONValue(strString) as TJSONObject;

    FProximaPagina := '';
    LJsonObjectValue := LJsonObject.GetValue<TJSONObject>('cursor') as TJSONObject;
    If RetornaValorJson(LJsonObjectValue,'hasNextKey') = 'true' Then
      FProximaPagina := RetornaValorJson(LJsonObjectValue,'nextKey');

    LJsonObjectValue := LJsonObject.GetValue<TJSONObject>('content') as TJSONObject;

    LJsonArray := LJsonObjectValue.GetValue('transactions') as TJsonArray;

    FProgresso.Position := 0;
    FProgresso.Max := Ocorrencias('"authorizationCode"',strString);

    For LJsonValue In LJsonArray Do
    Begin

      LJsonObjectValue := TJSONObject.ParseJSONValue(LJSonValue.ToString) as TJSONObject;

      If MatchStr(RetornaValorJson(LJsonObjectValue, 'status'), ['REVERSED']) Then
        Continue;

      LRegistroVenda := TRedeCardAPIRegistroVenda.Create;

      LJsonObjectGroup := LJsonObjectValue.GetValue('merchant') as TJSONObject;
      LRegistroVenda.CodigoEstabelecimento := RetornaValorJson(LJsonObjectGroup, 'companyNumber');
      LRegistroVenda.CodigoEstabelecimento :=  LRegistroVenda.CodigoEstabelecimento.PadLeft(9, '0');
      LRegistroVenda.NumeroDocumento := RetornaValorJson(LJsonObjectGroup, 'documentNumber');
      LRegistroVenda.NomeFantasia := RetornaValorJson(LJsonObjectGroup, 'tradeName');
      LRegistroVenda.RazaoSocial := RetornaValorJson(LJsonObjectGroup, 'companyName');

      LRegistroVenda.CodigoBandeira := RetornaValorJson(LJsonObjectValue, 'brandCode');

      LRegistroVenda.Autorizacao := RetornaValorJson(LJsonObjectValue, 'strAuthorizationCode');
      If fEmptyStr(LRegistroVenda.Autorizacao) Then
        LRegistroVenda.Autorizacao := RetornaValorJson(LJsonObjectValue, 'authorizationCode');

      LJsonObjectGroup := LJsonObjectValue.GetValue('modality') as TJSONObject;
      LRegistroVenda.TipoRegistro := RetornaValorJson(LJsonObjectGroup, 'type');
      LRegistroVenda.NomeProduto := RetornaValorJson(LJsonObjectGroup, 'product');
      LRegistroVenda.CodigoProduto := RetornaValorJson(LJsonObjectGroup, 'productCode');

      LRegistroVenda.TotalParcelas := RetornaValorJson(LJsonObjectValue, 'installmentQuantity');
      LRegistroVenda.NSU := RetornaValorJson(LJsonObjectValue, 'nsu');
      LRegistroVenda.TID := RetornaValorJson(LJsonObjectValue, 'tid');
      LRegistroVenda.NumeroRV := RetornaValorJson(LJsonObjectValue, 'saleSummaryNumber');
      LRegistroVenda.NumeroOrdem := RetornaValorJson(LJsonObjectValue, 'orderNumber');
      LRegistroVenda.DataRV := RetornaValorJson(LJsonObjectValue, 'movementDate');
      LRegistroVenda.DataVenda := RetornaValorJson(LJsonObjectValue, 'saleDate');
      LRegistroVenda.Status := RetornaValorJson(LJsonObjectValue, 'status');
      LRegistroVenda.ChargeBackStatus := RetornaValorJson(LJsonObjectValue, 'chargebackStatus');

      LRegistroVenda.TipoMaquina := RetornaValorJson(LJsonObjectValue, 'deviceType');
      LRegistroVenda.CodigoTerminal := RetornaValorJson(LJsonObjectValue, 'device');
      LRegistroVenda.TipoCaptura := RetornaValorJson(LJsonObjectValue, 'captureType');
      LRegistroVenda.Ard := RetornaValorJson(LJsonObjectValue, 'ard');

      LRegistroVenda.DataImportacao := DateToStr(Date);

      LRegistroVenda.ValorBruto := RetornaValorJson(LJsonObjectValue,'amount',varDouble);
      LRegistroVenda.TaxaMDR := RetornaValorJson(LJsonObjectValue,'mdrFee',varDouble);
      LRegistroVenda.ValorMDR := RetornaValorJson(LJsonObjectValue,'mdrAmount',varDouble);

      LRegistroVenda.Flex := 'N';
      If RetornaValorJson(LJsonObjectValue, 'flex') = 'true' Then
        LRegistroVenda.Flex := 'S';

      LRegistroVenda.TaxaFlex := RetornaValorJson(LJsonObjectValue,'flexFee',varDouble);
      LRegistroVenda.ValorFlex := RetornaValorJson(LJsonObjectValue,'flexAmount',varDouble);
      LRegistroVenda.PercentualTaxa := RetornaValorJson(LJsonObjectValue,'feeTotal',varDouble);
      LRegistroVenda.ValorDesconto := RetornaValorJson(LJsonObjectValue,'discountAmount',varDouble);
      LRegistroVenda.ValorLiquido := RetornaValorJson(LJsonObjectValue,'netAmount',varDouble);
      LRegistroVenda.ValorEmbarque := RetornaValorJson(LJsonObjectValue,'boardingFeeAmount',varDouble);

      If RetornaValorJson(LJsonObjectValue, 'tokenized') = 'false' Then
        LRegistroVenda.NumeroCartao := RetornaValorJson(LJsonObjectValue, 'cardNumber')
      Else
        LRegistroVenda.NumeroCartao := RetornaValorJson(LJsonObjectValue, 'tokenNumber');

      FRedeCardRegistrosVenda.Add(LRegistroVenda);

      If (lstEstabel.IndexOf(LRegistroVenda.CodigoEstabelecimento) < 0) Then
        lstEstabel.Add(LRegistroVenda.CodigoEstabelecimento);

      FProgresso.Position := FProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    FProgresso.Position := 0;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

procedure TRedeCardAPIPgto.ImportaVendasParceladas(strString: String);
  Var
    LJsonObject,
    LJsonObjectValue : TJsonObject;
    LJsonArray: TJSONArray;
    LJsonValue: TJsonValue;
    LRegistroVendaParcelada: TRedeCardAPIRegistroVendaParcelada;
begin
  Try
    LJsonObject := TJSONObject.ParseJSONValue(strString) as TJSONObject;

    FProximaPagina := '';
    LJsonObjectValue := LJsonObject.GetValue<TJSONObject>('cursor') as TJSONObject;
    If RetornaValorJson(LJsonObjectValue,'hasNextKey') = 'true' Then
      FProximaPagina := RetornaValorJson(LJsonObjectValue,'nextKey');

    LJsonObjectValue := LJsonObject.GetValue<TJSONObject>('content') as TJSONObject;

    LJsonArray := LJsonObjectValue.GetValue('installments') as TJsonArray;

    FProgresso.Position := 0;
    FProgresso.Max := Ocorrencias('"saleSummaryNumber"',strString);

    For LJsonValue In LJsonArray Do
    Begin
      LJsonObjectValue := TJSONObject.ParseJSONValue(LJSonValue.ToString) as TJSONObject;

      LRegistroVendaParcelada := TRedeCardAPIRegistroVendaParcelada.Create;
      LRegistroVendaParcelada.CodigoEstabelecimento := RetornaValorJson(LJsonObjectValue, 'companyNumber');
      LRegistroVendaParcelada.CodigoEstabelecimento := LRegistroVendaParcelada.CodigoEstabelecimento.PadLeft(9, '0');
      LRegistroVendaParcelada.NSU := RetornaValorJson(LJsonObjectValue, 'nsu');

      LRegistroVendaParcelada.DataRV := RetornaValorJson(LJsonObjectValue, 'movementDate');
      If LRegistroVendaParcelada.DataRV.IsEmpty Then
        LRegistroVendaParcelada.DataRV := RetornaValorJson(LJsonObjectValue, 'saleDate');

      LRegistroVendaParcelada.NumeroRV := RetornaValorJson(LJsonObjectValue, 'saleSummaryNumber');
      LRegistroVendaParcelada.TID := RetornaValorJson(LJsonObjectValue, 'tid');
      LRegistroVendaParcelada.DataVenda := RetornaValorJson(LJsonObjectValue, 'saleDate');
      LRegistroVendaParcelada.DataVencimento := RetornaValorJson(LJsonObjectValue, 'expirationDate');
      LRegistroVendaParcelada.Parcela := RetornaValorJson(LJsonObjectValue, 'installmentNumber');
      LRegistroVendaParcelada.TotalParcelas := RetornaValorJson(LJsonObjectValue, 'installmentQuantity');
      LRegistroVendaParcelada.DataImportacao := DateToStr(Date);

      LRegistroVendaParcelada.ValorParcela := RetornaValorJson(LJsonObjectValue,'amount',varDouble);
      LRegistroVendaParcelada.ValorDesconto := RetornaValorJson(LJsonObjectValue,'discountAmount',varDouble);
      LRegistroVendaParcelada.ValorLiquido := RetornaValorJson(LJsonObjectValue,'netAmount',varDouble);
      LRegistroVendaParcelada.TaxaMDR := RetornaValorJson(LJsonObjectValue,'mdrFee',varDouble);
      LRegistroVendaParcelada.ValorMDR := RetornaValorJson(LJsonObjectValue,'mdrAmount',varDouble);
      LRegistroVendaParcelada.ValorVenda := RetornaValorJson(LJsonObjectValue,'saleAmount',varDouble);

      FRedeCardRegistrosVendaParcelada.Add(LRegistroVendaParcelada);

      If (lstEstabel.IndexOf(LRegistroVendaParcelada.CodigoEstabelecimento) < 0) Then
        lstEstabel.Add(LRegistroVendaParcelada.CodigoEstabelecimento);

      FProgresso.Position := FProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    FProgresso.Position := 0;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
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
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TRedeCardAPIPgto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    LDados: IDataSet;
    LSQL: String;
    LContador: Integer;
    LRegistro: TRedeCardRegistroPgto;
    LRegistroVenda: TRedeCardAPIRegistroVenda;
    LRegistroVendaParcelada: TRedeCardAPIRegistroVendaParcelada;
    LRegistroAjustes: TRedeCardAPIRegistroAjuste;
    LRegistroNegociacaoPagamento: TNegociacao;
begin
  LSQL := RetornaSQLReplaceTabela('RED_APPGTO');

  LDados := objFunctions.fGetDataSet;
  LDados.Close;
  LDados.SQL := LSQL;

  pgbProg.Position := 0;

  pgbProg.Max := FRedeCardRegistrosPgto.Count;

  For LRegistro In FRedeCardRegistrosPgto Do
  Begin
    Try
      FImportouPagamento := True;
      FImportouRegistro := True;

      LDados.Close;

      LDados.ParamByName(INICAM + 'TIPREG').Value := CorrigeDadosBanco(LRegistro.TipoRegistro);
      LDados.ParamByName(INICAM + 'NUM_PV').Value := CorrigeDadosBanco(LRegistro.CodigoEstabelecimento);
      LDados.ParamByName(INICAM + 'DTAPAG').Value := CorrigeDadosBanco(LRegistro.DataPagamento);
      LDados.ParamByName(INICAM + 'NUM_RV').Value := CorrigeDadosBanco(LRegistro.NumeroRV);
      LDados.ParamByName(INICAM + 'NUMORD').Value := CorrigeDadosBanco(LRegistro.NumeroOrdem);
      LDados.ParamByName(INICAM + 'CODBAN').Value := CorrigeDadosBanco(LRegistro.CodigoBandeira);
      LDados.ParamByName(INICAM + 'DTAIMP').Value := CorrigeDadosBanco(LRegistro.DataImportacao, True);
      LDados.ParamByName(INICAM + 'PAG_ID').Value := CorrigeDadosBanco(LRegistro.PagamentoID);
      LDados.ParamByName(INICAM + 'DESTIP').Value := CorrigeDadosBanco(LRegistro.DescricaoTipo);

      LDados.ParamByName(INICAM + 'VALBRU').Value := CorrigeDadosBanco(LRegistro.ValorBruto);
      LDados.ParamByName(INICAM + 'VALDES').Value := CorrigeDadosBanco(LRegistro.ValorDesconto);
      LDados.ParamByName(INICAM + 'VALLIQ').Value := CorrigeDadosBanco(LRegistro.ValorLiquido);

      LDados.ExecSQL;

      pgbProg.Position := pgbProg.Position + 1;
      Application.ProcessMessages;
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  End;


  LSQL := RetornaSQLReplaceTabela('RED_PGODIR');

  LDados := objFunctions.fGetDataSet;
  LDados.Close;
  LDados.SQL := LSQL;

  pgbProg.Position := 0;

  pgbProg.Max := FNegociacoesPagamento.Count;

  For LRegistroNegociacaoPagamento In FNegociacoesPagamento Do
  Begin
    Try
      LDados.Close;

      LDados.ParamByName(INICAM + 'CODCED').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.CodigoClienteCedente);
      LDados.ParamByName(INICAM + 'PAG_ID').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.IdPagamento);
      LDados.ParamByName(INICAM + 'NOMEMP').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.NomeEmpresa);
      LDados.ParamByName(INICAM + 'CONINT').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.NumeroContratoInterno);
      LDados.ParamByName(INICAM + 'CODMAR').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.CodigoMarca);
      LDados.ParamByName(INICAM + 'TIPNEG').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.TipoNegociacao);
      LDados.ParamByName(INICAM + 'NOMCED').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.NomeCedente);
      LDados.ParamByName(INICAM + 'CODBCO').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.CodigoBanco);
      LDados.ParamByName(INICAM + 'TIPPAG').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.TipoPagamento);
      LDados.ParamByName(INICAM + 'CODTIP').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.CodigoTipo);
      LDados.ParamByName(INICAM + 'NUMDOC').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.NumeroDocumento);
      LDados.ParamByName(INICAM + 'NUMCON').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.NumeroConta);
      LDados.ParamByName(INICAM + 'CODSTA').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.CodigoStatus);
      LDados.ParamByName(INICAM + 'QTDDEP').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.ContagemDeposito);
      LDados.ParamByName(INICAM + 'VALLIQ').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.ValorLiquido);
      LDados.ParamByName(INICAM + 'VALATU').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.TemValorAtualizado);
      LDados.ParamByName(INICAM + 'DOCCED').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.DocumentoCedente);
      LDados.ParamByName(INICAM + 'STATUS').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.Status);
      LDados.ParamByName(INICAM + 'ORDCRE').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.OrdemCreditoPai);
      LDados.ParamByName(INICAM + 'NOMCOM').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.NomeComercial);
      LDados.ParamByName(INICAM + 'DTAPAG').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.DataPagamento);
      LDados.ParamByName(INICAM + 'CODAGE').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.CodigoAgenciaBanco);
      LDados.ParamByName(INICAM + 'TIPREG').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.Tipo);
      LDados.ParamByName(INICAM + 'NUM_PV').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.NumeroEmpresa);
      LDados.ParamByName(INICAM + 'ORICRE').Value := CorrigeDadosBanco(LRegistroNegociacaoPagamento.OrigemOrdemCredito);

      LDados.ExecSQL;

      pgbProg.Position := pgbProg.Position + 1;
      Application.ProcessMessages;
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  End;

  LSQL := RetornaSQLReplaceTabela('RED_APVEND');

  LDados := objFunctions.fGetDataSet;
  LDados.Close;
  LDados.SQL := LSQL;

  pgbProg.Position := 0;

  pgbProg.Max := FRedeCardRegistrosVenda.Count;

  For LRegistroVenda In FRedeCardRegistrosVenda Do
  Begin
    Try
      FImportouRegistro := True;
      FImportouVendas := True;

      LDados.Close;

      LDados.ParamByName(INICAM + 'TIPREG').Value := CorrigeDadosBanco(LRegistroVenda.TipoRegistro);
      LDados.ParamByName(INICAM + 'NUM_PV').Value := CorrigeDadosBanco(LRegistroVenda.CodigoEstabelecimento);
      LDados.ParamByName(INICAM + 'DTA_RV').Value := CorrigeDadosBanco(LRegistroVenda.DataRV);
      LDados.ParamByName(INICAM + 'NUM_RV').Value := CorrigeDadosBanco(LRegistroVenda.NumeroRV);
      LDados.ParamByName(INICAM + 'NUMORD').Value := CorrigeDadosBanco(LRegistroVenda.NumeroOrdem);
      LDados.ParamByName(INICAM + 'CODBAN').Value := CorrigeDadosBanco(LRegistroVenda.CodigoBandeira);
      LDados.ParamByName(INICAM + 'DTAIMP').Value := CorrigeDadosBanco(LRegistroVenda.DataImportacao, True);
      LDados.ParamByName(INICAM + 'DOCNUM').Value := CorrigeDadosBanco(LRegistroVenda.NumeroDocumento);
      LDados.ParamByName(INICAM + 'RAZSOC').Value := CorrigeDadosBanco(LRegistroVenda.RazaoSocial);
      LDados.ParamByName(INICAM + 'NOMFAN').Value := CorrigeDadosBanco(LRegistroVenda.NomeFantasia);
      LDados.ParamByName(INICAM + 'CODAUT').AsString := LRegistroVenda.Autorizacao;
      LDados.ParamByName(INICAM + 'NOMPRO').Value := CorrigeDadosBanco(LRegistroVenda.NomeProduto);
      LDados.ParamByName(INICAM + 'CODPRO').Value := CorrigeDadosBanco(LRegistroVenda.CodigoProduto);
      LDados.ParamByName(INICAM + 'TOTPAR').AsString := LRegistroVenda.TotalParcelas;
      LDados.ParamByName(INICAM + 'NUMNSU').Value := LRegistroVenda.NSU;
      LDados.ParamByName(INICAM + 'NUMTID').Value := CorrigeDadosBanco(LRegistroVenda.TID);
      LDados.ParamByName(INICAM + 'DTAVEN').Value := CorrigeDadosBanco(LRegistroVenda.DataVenda);
      LDados.ParamByName(INICAM + 'STATUS').Value := CorrigeDadosBanco(LRegistroVenda.Status);
      LDados.ParamByName(INICAM + 'CHASTA').Value := CorrigeDadosBanco(LRegistroVenda.ChargeBackStatus);
      LDados.ParamByName(INICAM + 'TIPMAQ').Value := CorrigeDadosBanco(LRegistroVenda.TipoMaquina);
      LDados.ParamByName(INICAM + 'CODTER').Value := CorrigeDadosBanco(LRegistroVenda.CodigoTerminal);
      LDados.ParamByName(INICAM + 'TIPCAP').Value := CorrigeDadosBanco(LRegistroVenda.TipoCaptura);
      LDados.ParamByName(INICAM + 'CODCAP').Value := CorrigeDadosBanco(LRegistroVenda.CodigoCaptura);
      LDados.ParamByName(INICAM + 'E_FLEX').Value := CorrigeDadosBanco(LRegistroVenda.Flex);
      LDados.ParamByName(INICAM + 'ID_ARD').Value := CorrigeDadosBanco(LRegistroVenda.Ard);
      LDados.ParamByName(INICAM + 'NUMCAR').Value := CorrigeDadosBanco(LRegistroVenda.NumeroCartao);

      LDados.ParamByName(INICAM + 'VALBRU').Value := CorrigeDadosBanco(LRegistroVenda.ValorBruto);
      LDados.ParamByName(INICAM + 'TAXMDR').Value := CorrigeDadosBanco(LRegistroVenda.TaxaMDR);
      LDados.ParamByName(INICAM + 'VALMDR').Value := CorrigeDadosBanco(LRegistroVenda.ValorMDR);
      LDados.ParamByName(INICAM + 'TAXFLE').Value := CorrigeDadosBanco(LRegistroVenda.TaxaFlex);
      LDados.ParamByName(INICAM + 'PERTAX').Value := CorrigeDadosBanco(LRegistroVenda.PercentualTaxa);
      LDados.ParamByName(INICAM + 'VALDES').Value := CorrigeDadosBanco(LRegistroVenda.ValorDesconto);
      LDados.ParamByName(INICAM + 'VALLIQ').Value := CorrigeDadosBanco(LRegistroVenda.ValorLiquido);
      LDados.ParamByName(INICAM + 'VALEMB').Value := CorrigeDadosBanco(LRegistroVenda.ValorEmbarque);

      LDados.ExecSQL;

      pgbProg.Position := pgbProg.Position + 1;
      Application.ProcessMessages;
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  End;

  LSQL := RetornaSQLReplaceTabela('RED_APVPAR');

  LDados := objFunctions.fGetDataSet;
  LDados.Close;
  LDados.SQL := LSQL;

  pgbProg.Position := 0;

  pgbProg.Max := FRedeCardRegistrosVendaParcelada.Count;

  For LRegistroVendaParcelada In FRedeCardRegistrosVendaParcelada Do
  Begin
    Try
      FImportouRegistro := True;

      LDados.Close;

      LDados.ParamByName(INICAM + 'NUM_PV').Value := CorrigeDadosBanco(LRegistroVendaParcelada.CodigoEstabelecimento);
      LDados.ParamByName(INICAM + 'DTA_RV').Value := CorrigeDadosBanco(LRegistroVendaParcelada.DataRV);
      LDados.ParamByName(INICAM + 'NUM_RV').Value := CorrigeDadosBanco(LRegistroVendaParcelada.NumeroRV);
      LDados.ParamByName(INICAM + 'NUMNSU').Value := CorrigeDadosBanco(LRegistroVendaParcelada.NSU);
      LDados.ParamByName(INICAM + 'NUMTID').Value := CorrigeDadosBanco(LRegistroVendaParcelada.TID);
      LDados.ParamByName(INICAM + 'DTAVEN').Value := CorrigeDadosBanco(LRegistroVendaParcelada.DataVenda);
      LDados.ParamByName(INICAM + 'VEN_RV').Value := CorrigeDadosBanco(LRegistroVendaParcelada.DataVencimento);
      LDados.ParamByName(INICAM + 'NUMPAR').Value := CorrigeDadosBanco(LRegistroVendaParcelada.Parcela);
      LDados.ParamByName(INICAM + 'TOTPAR').Value := CorrigeDadosBanco(LRegistroVendaParcelada.TotalParcelas);
      LDados.ParamByName(INICAM + 'DTAIMP').Value := CorrigeDadosBanco(LRegistroVendaParcelada.DataImportacao, True);
      
      LDados.ParamByName(INICAM + 'VALPAR').Value := CorrigeDadosBanco(LRegistroVendaParcelada.ValorParcela);
      LDados.ParamByName(INICAM + 'VALDES').Value := CorrigeDadosBanco(LRegistroVendaParcelada.ValorDesconto);
      LDados.ParamByName(INICAM + 'LIQPAR').Value := CorrigeDadosBanco(LRegistroVendaParcelada.ValorLiquido);
      LDados.ParamByName(INICAM + 'BRU_RO').Value := CorrigeDadosBanco(LRegistroVendaParcelada.ValorVenda);
      LDados.ParamByName(INICAM + 'TAXMDR').Value := CorrigeDadosBanco(LRegistroVendaParcelada.TaxaMDR);
      LDados.ParamByName(INICAM + 'VALMDR').Value := CorrigeDadosBanco(LRegistroVendaParcelada.ValorMDR);
      LDados.ParamByName(INICAM + 'IMPTOT').Value := 0;

      LDados.ExecSQL;

      pgbProg.Position := pgbProg.Position + 1;
      Application.ProcessMessages;
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  End;


  LSQL := RetornaSQLReplaceTabela('RED_APAJUS');

  LDados := objFunctions.fGetDataSet;
  LDados.Close;
  LDados.SQL := LSQL;

  pgbProg.Position := 0;

  pgbProg.Max := FRedeCardRegistrosAjuste.Count;

  For LRegistroAjustes In FRedeCardRegistrosAjuste Do
  Begin
    Try
      FImportouRegistro := True;

      LDados.Close;
      LDados.ParamByName(INICAM + 'VALAJU').Value := CorrigeDadosBanco(LRegistroAjustes.ValorAjuste);
      LDados.ParamByName(INICAM + 'CODAJU').Value := CorrigeDadosBanco(LRegistroAjustes.CodigoAjuste);
      LDados.ParamByName(INICAM + 'DESAJU').Value := CorrigeDadosBanco(LRegistroAjustes.DescricaoAjuste);
      LDados.ParamByName(INICAM + 'NUM_PV').Value := CorrigeDadosBanco(LRegistroAjustes.CodigoEstabelecimento);
      LDados.ParamByName(INICAM + 'NUM_RV').Value := CorrigeDadosBanco(LRegistroAjustes.NumeroRV);
      LDados.ParamByName(INICAM + 'DTAPAG').Value := CorrigeDadosBanco(LRegistroAjustes.DataPagamento);
      LDados.ParamByName(INICAM + 'DTA_RV').Value := CorrigeDadosBanco(LRegistroAjustes.DataRV);
      LDados.ParamByName(INICAM + 'NUMDEB').Value := CorrigeDadosBanco(LRegistroAjustes.NumeroDebito);
      LDados.ParamByName(INICAM + 'DOCNUM').Value := CorrigeDadosBanco(LRegistroAjustes.NumeroDocumento);
      LDados.ParamByName(INICAM + 'AJUFUT').Value := CorrigeDadosBanco(LRegistroAjustes.ValorAjusteFuturo);
      LDados.ParamByName(INICAM + 'NOMFAN').Value := CorrigeDadosBanco(LRegistroAjustes.NomeFantasia);
      LDados.ParamByName(INICAM + 'NUMAVI').Value := CorrigeDadosBanco(LRegistroAjustes.NumeroAviso);
      LDados.ParamByName(INICAM + 'VALPAG').Value := CorrigeDadosBanco(LRegistroAjustes.ValorPago);
      LDados.ParamByName(INICAM + 'RAZSOC').Value := CorrigeDadosBanco(LRegistroAjustes.RazaoSocial);
      LDados.ParamByName(INICAM + 'DTAEXP').Value := CorrigeDadosBanco(IIF(fEmptyStr(LRegistroAjustes.DataExpiracao),DateToStr(Date),LRegistroAjustes.DataExpiracao),True);
      LDados.ParamByName(INICAM + 'NUMPED').Value := CorrigeDadosBanco(IIF(fEmptyStr(LRegistroAjustes.NumeroPedido),'0',LRegistroAjustes.NumeroPedido));
      LDados.ParamByName(INICAM + 'TIPREG').Value := CorrigeDadosBanco(LRegistroAjustes.TipoRegistro);
      LDados.ParamByName(INICAM + 'DTAIMP').Value := CorrigeDadosBanco(LRegistroAjustes.DataImportacao, True);

      LDados.ExecSQL;

      pgbProg.Position := pgbProg.Position + 1;
      Application.ProcessMessages;
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  End;

  FRedeCardRegistrosPgto.Clear;
  FRedeCardRegistrosVenda.Clear;
  FRedeCardRegistrosVendaParcelada.Clear;
  FRedeCardRegistrosAjuste.Clear;
  FNegociacoesPagamento.Clear;

  Try
    LDados.Close;
    LDados.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "REDECARD API")';
    For LContador := 0 To lstEstabel.Count - 1 Do
    Begin
      LDados.ParamByName('ESTAB').AsString := lstEstabel[LContador];
      LDados.ExecSQL;
    End;
  Except
    Raise Exception.Create('A tabela ESTCAR não foi criada. Entre em contato com a Citel!');
  End;
end;

function TRedeCardAPIPgto.RetornaSQLReplaceTabela(ATabela: String): String;
  Var
    LCampos: TArrEstruturaRedeCardAPIPgto;

    LContador: Integer;
begin
  Result := 'REPLACE INTO ' + ATabela + ' (';

  LCampos := fRetEstruturaPgto(ATabela);

  For LContador := 0 to Length(LCampos) - 1 do
  Begin
    If (LCampos[LContador].strDescri <> INICAM + 'CONCIL') Then
      Result := Result + LCampos[LContador].strDescri + ',';
  End;

  Result := Copy(Result, 1, Length(Result) - 1) + ') VALUES (';

  For LContador := 0 to Length(LCampos) - 1 do
  Begin
    If (LCampos[LContador].strDescri <> INICAM + 'CONCIL') Then
      Result := Result + ':' + LCampos[LContador].strDescri + ',';
  End;
  Result := Copy(Result, 1, Length(Result) - 1) + ')';
end;

function TRedeCardAPIPgto.RetornaValorJson(AObjeto: TJsonObject; ANomeCampo: String; ATipoRetorno: TVarType = varString): Variant;
begin

  case ATipoRetorno of
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
