unit untConcilAPIPgto;

interface
uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls,
     Dialogs, Forms, untTConcil, System.Generics.Collections, Json;

Type
  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrEstruturaConcilAPIPgto = Array Of TEstruturaPgto;

  TConcilAPIPgto = Class(TInterfacedObject, ICartoes)
  Private
    FConcilRegistrosPgto: TList<TConcilRegistroPgto>;
    FConcilRegistrosAjuste: TList<TConcilRegistroAjuste>;
    FProximaPagina: String;
    FImportouRegistro,
    FImportouPagamento: Boolean;
    FEstabelecimentoAtual,
    FTipoDoArquivo: String;
    FTipoExtrato: String;

    function CorrigeDadosBanco(AValor: Variant;
                               ACampoData: Boolean = False): Variant;
    function RetornaValorJson(AObjeto: TJsonObject; ANomeCampo: String; AIsFloat: Boolean = False): String;
    procedure ImportaPagamentos(strString: String);
    procedure ImportaAjustes(strString: String);
    function RetornaListaDeCampos(AObjetoCampos: TArrEstruturaConcilAPIPgto): TStringList;

  Public
    constructor Create;
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);
    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaConcilAPIPgto;
    property ProximaPagina: String read FProximaPagina;
    property ImportouRegistro: Boolean read FImportouRegistro;
    property ImportouPagamento: Boolean read FImportouPagamento;
    property EstabelecimentoAtual: String read FEstabelecimentoAtual write FEstabelecimentoAtual;
    property TipoDoArquivo: String read FTipoDoArquivo write FTipoDoArquivo;
    property TipoExtrato: String read FTipoExtrato write FTipoExtrato;
  End;

  Var
    FNomeArquivo,
    FDataArquivo: String;

Const
  NOMTAB = 'CON_APPGTO';
  INICAM = 'CON_';

implementation

uses untFuncoes, untIDataSet;

{ TConcilAPIPgto }

function TConcilAPIPgto.CorrigeDadosBanco(AValor: Variant;
                                            ACampoData: Boolean = False): Variant;
begin
  Result := Null;
  If Not fEmptyStr(AValor) Then
  Begin
    Result := AValor;
  End;
end;

constructor TConcilAPIPgto.Create;
begin
  FImportouRegistro := False;
  FImportouPagamento := False;

  FConcilRegistrosPgto := TList<TConcilRegistroPgto>.Create;
  FConcilRegistrosAjuste := TList<TConcilRegistroAjuste>.Create;
end;

class function TConcilAPIPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaConcilAPIPgto;
Begin
  If strTabela = 'CON_APPGTO' Then
  Begin
    SetLength(Result, 41);

    Result[0].strDescri  := INICAM + 'NUM_ID'; Result[0].strTipCmp  := 'VARCHAR(255)';
    Result[1].strDescri  := INICAM + 'NUMPFJ'; Result[1].strTipCmp  := 'VARCHAR(30)';
    Result[2].strDescri  := INICAM + 'BRANCH'; Result[2].strTipCmp  := 'VARCHAR(100)';
    Result[3].strDescri  := INICAM + 'CODEST'; Result[3].strTipCmp  := 'VARCHAR(30)';
    Result[4].strDescri  := INICAM + 'NUMPAR'; Result[4].strTipCmp  := 'VARCHAR(2)';
    Result[5].strDescri  := INICAM + 'TOTPAR'; Result[5].strTipCmp  := 'VARCHAR(2)';
    Result[6].strDescri  := INICAM + 'ID_ADQ'; Result[6].strTipCmp  := 'VARCHAR(10)';
    Result[7].strDescri  := INICAM + 'BRANID'; Result[7].strTipCmp  := 'VARCHAR(10)';
    Result[8].strDescri  := INICAM + 'PRO_ID'; Result[8].strTipCmp  := 'VARCHAR(10)';
    Result[9].strDescri  := INICAM + 'NUMNSU'; Result[9].strTipCmp  := 'VARCHAR(30)';
    Result[10].strDescri  := INICAM + 'CODAUT'; Result[10].strTipCmp  := 'VARCHAR(30)';
    Result[11].strDescri  := INICAM + 'DTAPAG'; Result[11].strTipCmp  := 'DATE';
    Result[12].strDescri  := INICAM + 'STATUS'; Result[12].strTipCmp  := 'VARCHAR(100)';
    Result[13].strDescri  := INICAM + 'STAREC'; Result[13].strTipCmp  := 'VARCHAR(100)';
    Result[14].strDescri  := INICAM + 'NUMFAT'; Result[14].strTipCmp  := 'VARCHAR(255)';
    Result[15].strDescri  := INICAM + 'CODANT'; Result[15].strTipCmp  := 'VARCHAR(100)';
    Result[16].strDescri  := INICAM + 'CODBCO'; Result[16].strTipCmp  := 'VARCHAR(3)';
    Result[17].strDescri  := INICAM + 'NUMAGE'; Result[17].strTipCmp  := 'VARCHAR(20)';
    Result[18].strDescri  := INICAM + 'NUMCTA'; Result[18].strTipCmp  := 'VARCHAR(20)';
    Result[19].strDescri  := INICAM + 'NUMTID'; Result[19].strTipCmp  := 'VARCHAR(100)';
    Result[20].strDescri  := INICAM + 'NUMTER'; Result[20].strTipCmp  := 'VARCHAR(100)';
    Result[21].strDescri  := INICAM + 'CANCAP'; Result[21].strTipCmp  := 'VARCHAR(100)';
    Result[22].strDescri  := INICAM + 'DTAVDA'; Result[22].strTipCmp  := 'DATE';
    Result[23].strDescri  := INICAM + 'NUMCAR'; Result[23].strTipCmp  := 'VARCHAR(100)';
    Result[24].strDescri  := INICAM + 'CLAPAG'; Result[24].strTipCmp  := 'VARCHAR(100)';
    Result[25].strDescri  := INICAM + 'TIPTRA'; Result[25].strTipCmp  := 'VARCHAR(100)';
    Result[26].strDescri  := INICAM + 'NUMRES'; Result[26].strTipCmp  := 'VARCHAR(100)';
    Result[27].strDescri  := INICAM + 'ID_UNI'; Result[27].strTipCmp  := 'VARCHAR(100)';
    Result[28].strDescri  := INICAM + 'DTACRI'; Result[28].strTipCmp  := 'DATE';
    Result[29].strDescri  := INICAM + 'BRUPAR'; Result[29].strTipCmp := 'DECIMAL(15,2)';
    Result[30].strDescri  := INICAM + 'LIQPAR'; Result[30].strTipCmp := 'DECIMAL(15,2)';
    Result[31].strDescri  := INICAM + 'VALBRU'; Result[31].strTipCmp := 'DECIMAL(15,2)';
    Result[32].strDescri  := INICAM + 'VALLIQ'; Result[32].strTipCmp := 'DECIMAL(15,2)';
    Result[33].strDescri  := INICAM + 'TAXADM'; Result[33].strTipCmp := 'DECIMAL(15,2)';
    Result[34].strDescri  := INICAM + 'TAXANT'; Result[34].strTipCmp := 'DECIMAL(15,2)';
    Result[35].strDescri  := INICAM + 'VALDES'; Result[35].strTipCmp := 'DECIMAL(15,2)';
    Result[36].strDescri  := INICAM + 'VALMAR'; Result[36].strTipCmp := 'DECIMAL(15,2)';
    Result[37].strDescri  := INICAM + 'TAXESQ'; Result[37].strTipCmp := 'DECIMAL(15,2)';
    Result[38].strDescri  := INICAM + 'VALINT'; Result[38].strTipCmp := 'DECIMAL(15,2)';
    Result[39].strDescri  := INICAM + 'VALCAR'; Result[39].strTipCmp := 'DECIMAL(15,2)';
    Result[40].strDescri  := INICAM + 'CONCIL'; Result[40].strTipCmp  := 'INT DEFAULT 0';
  End

  Else If strTabela = 'CON_APAJUS' Then
  Begin
    SetLength(Result, 27);

    Result[0].strDescri  := INICAM + 'BRANCH'; Result[0].strTipCmp  := 'VARCHAR(100)';
    Result[1].strDescri  := INICAM + 'CODEST'; Result[1].strTipCmp  := 'VARCHAR(30)';
    Result[2].strDescri  := INICAM + 'NUMPAR'; Result[2].strTipCmp  := 'VARCHAR(2)';
    Result[3].strDescri  := INICAM + 'TOTPAR'; Result[3].strTipCmp  := 'VARCHAR(2)';
    Result[4].strDescri  := INICAM + 'VALAJU'; Result[4].strTipCmp  := 'DECIMAL(15,2)';
    Result[5].strDescri  := INICAM + 'ID_ADQ'; Result[5].strTipCmp  := 'VARCHAR(10)';
    Result[6].strDescri  := INICAM + 'BRANID'; Result[6].strTipCmp  := 'VARCHAR(10)';
    Result[7].strDescri  := INICAM + 'PRO_ID'; Result[7].strTipCmp  := 'VARCHAR(10)';
    Result[8].strDescri  := INICAM + 'NUMNSU'; Result[8].strTipCmp  := 'VARCHAR(30)';
    Result[9].strDescri  := INICAM + 'CODAUT'; Result[9].strTipCmp  := 'VARCHAR(30)';
    Result[10].strDescri  := INICAM + 'DTAVDA'; Result[10].strTipCmp  := 'DATE';
    Result[11].strDescri  := INICAM + 'DTAAJU'; Result[11].strTipCmp  := 'DATE';
    Result[12].strDescri  := INICAM + 'CODBCO'; Result[12].strTipCmp  := 'VARCHAR(3)';
    Result[13].strDescri  := INICAM + 'NUMAGE'; Result[13].strTipCmp  := 'VARCHAR(20)';
    Result[14].strDescri  := INICAM + 'NUMCTA'; Result[14].strTipCmp  := 'VARCHAR(20)';
    Result[15].strDescri  := INICAM + 'NUMTID'; Result[15].strTipCmp  := 'VARCHAR(100)';
    Result[16].strDescri  := INICAM + 'CANCAP'; Result[16].strTipCmp  := 'VARCHAR(100)';
    Result[17].strDescri  := INICAM + 'NUMTER'; Result[17].strTipCmp  := 'VARCHAR(100)';
    Result[18].strDescri  := INICAM + 'NUMCAR'; Result[18].strTipCmp  := 'VARCHAR(100)';
    Result[19].strDescri  := INICAM + 'TIPTRA'; Result[19].strTipCmp  := 'VARCHAR(100)';
    Result[20].strDescri  := INICAM + 'NUMFAT'; Result[20].strTipCmp  := 'VARCHAR(255)';
    Result[21].strDescri  := INICAM + 'NUMPFJ'; Result[21].strTipCmp  := 'VARCHAR(30)';
    Result[22].strDescri  := INICAM + 'CODANT'; Result[22].strTipCmp  := 'VARCHAR(100)';
    Result[23].strDescri  := INICAM + 'NUMRES'; Result[23].strTipCmp  := 'VARCHAR(100)';
    Result[24].strDescri  := INICAM + 'DTACRI'; Result[24].strTipCmp  := 'DATE';
    Result[25].strDescri  := INICAM + 'ID_UNI'; Result[25].strTipCmp  := 'VARCHAR(100)';
    Result[26].strDescri  := INICAM + 'CONCIL'; Result[26].strTipCmp  := 'INT DEFAULT 0';
  End;


End;

class function TConcilAPIPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
  Var
    arrCampos: TArrEstruturaConcilAPIPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  If strTabela = 'CON_APPGTO' Then
    Result := Result + ' PRIMARY KEY(CON_NUM_ID,CON_NUMPFJ,CON_CODEST,CON_NUMPAR,CON_CODAUT,CON_NUMNSU,CON_DTAPAG,CON_TIPTRA,CON_ID_UNI,CON_DTAVDA)) ENGINE INNODB '

  Else If strTabela = 'CON_APAJUS' Then
    Result := Result + ' PRIMARY KEY(CON_CODEST,CON_NUMPAR,CON_CODAUT,CON_NUMNSU,CON_DTAAJU,CON_TIPTRA,CON_ID_UNI,CON_DTAVDA)) ENGINE INNODB ';

end;


procedure TConcilAPIPgto.ImportaAjustes(strString: String);
  Var
    LRegistro: TConcilRegistroAjuste;
    LJsonArray: TJSONArray;
    LJsonValue: TJsonValue;
    LJsonObjectValue: TJsonObject;
begin

  Try
    LJsonArray := TJSONObject.ParseJSONValue(strString) as TJsonArray;


    For LJsonValue In LJsonArray Do
    Begin
      LJsonObjectValue := TJSONObject.ParseJSONValue(LJSonValue.ToString) as TJSONObject;


      LRegistro.PFJ                      := RetornaValorJson(LJsonObjectValue, 'pfj');
      LRegistro.Branch                   := RetornaValorJson(LJsonObjectValue, 'branch');
      LRegistro.Estabelecimento          := RetornaValorJson(LJsonObjectValue, 'merchant');
      LRegistro.Parcela                  := RetornaValorJson(LJsonObjectValue, 'installmentIndex');
      LRegistro.TotalParcelas            := RetornaValorJson(LJsonObjectValue, 'installmentCount');
      LRegistro.IDAdquirente             := RetornaValorJson(LJsonObjectValue, 'acquirerId');
      LRegistro.BrandId                  := RetornaValorJson(LJsonObjectValue, 'brandId');
      LRegistro.ProductId                := RetornaValorJson(LJsonObjectValue, 'productId');
      LRegistro.Nsu                      := RetornaValorJson(LJsonObjectValue, 'nsu');
      LRegistro.Autorizacao              := RetornaValorJson(LJsonObjectValue, 'authorization');
      LRegistro.DataAjuste               := RetornaValorJson(LJsonObjectValue, 'adjustmentDate');
      LRegistro.Fatura                   := RetornaValorJson(LJsonObjectValue, 'invoice');
      LRegistro.CodigoAntencipacao       := RetornaValorJson(LJsonObjectValue, 'advanceCode');
      LRegistro.Banco                    := RetornaValorJson(LJsonObjectValue, 'bankCode');
      LRegistro.AgenciaBancaria          := RetornaValorJson(LJsonObjectValue, 'bankAgency');
      LRegistro.ContaBancaria            := RetornaValorJson(LJsonObjectValue, 'bankAccount');
      LRegistro.Tid                      := RetornaValorJson(LJsonObjectValue, 'tid');
      LRegistro.Terminal                 := RetornaValorJson(LJsonObjectValue, 'terminal');
      LRegistro.CanalCaptura             := RetornaValorJson(LJsonObjectValue, 'captureChannel');
      LRegistro.DataDaVenda              := RetornaValorJson(LJsonObjectValue, 'saleDate');
      LRegistro.NumeroCartao             := RetornaValorJson(LJsonObjectValue, 'cardNumber');
      LRegistro.TipoTransacao            := RetornaValorJson(LJsonObjectValue, 'transactionType');
      LRegistro.Resumo                   := RetornaValorJson(LJsonObjectValue, 'summary');
      LRegistro.IdUnico                  := RetornaValorJson(LJsonObjectValue, 'uniqueId');
      LRegistro.DataCriacao              := RetornaValorJson(LJsonObjectValue, 'createdAt');

      LRegistro.ValorAjuste              :=  StrToFloatDef(RetornaValorJson(LJsonObjectValue, 'adjustmentAmount',True),0);

      FConcilRegistrosAjuste.Add(LRegistro);

      If (lstEstabel.IndexOf(LRegistro.Estabelecimento) < 0) Then
        lstEstabel.Add(LRegistro.Estabelecimento);
    end;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TConcilAPIPgto.ImportaPagamentos(strString: String);
  Var
    LRegistro: TConcilRegistroPgto;
    LJsonArray: TJSONArray;
    LJsonValue: TJsonValue;
    LJsonObjectValue: TJsonObject;
begin

  Try
    LJsonArray := TJSONObject.ParseJSONValue(strString) as TJsonArray;


    For LJsonValue In LJsonArray Do
    Begin
      LJsonObjectValue := TJSONObject.ParseJSONValue(LJSonValue.ToString) as TJSONObject;


      LRegistro.ID                       := RetornaValorJson(LJsonObjectValue, 'id');
      LRegistro.PFJ                      := RetornaValorJson(LJsonObjectValue, 'pfj');
      LRegistro.Branch                   := RetornaValorJson(LJsonObjectValue, 'branch');
      LRegistro.Estabelecimento          := RetornaValorJson(LJsonObjectValue, 'merchant');
      LRegistro.Parcela                  := RetornaValorJson(LJsonObjectValue, 'installmentIndex');
      LRegistro.TotalParcelas            := RetornaValorJson(LJsonObjectValue, 'installmentCount');
      LRegistro.IDAdquirente             := RetornaValorJson(LJsonObjectValue, 'acquirerId');
      LRegistro.BrandId                  := RetornaValorJson(LJsonObjectValue, 'brandId');
      LRegistro.ProductId                := RetornaValorJson(LJsonObjectValue, 'productId');
      LRegistro.Nsu                      := RetornaValorJson(LJsonObjectValue, 'nsu');
      LRegistro.Autorizacao              := RetornaValorJson(LJsonObjectValue, 'authorization');
      LRegistro.DataPagamento            := RetornaValorJson(LJsonObjectValue, 'paymentDate');
      LRegistro.Status                   := RetornaValorJson(LJsonObjectValue, 'status');
      LRegistro.StatusReconciliacaoVenda := RetornaValorJson(LJsonObjectValue, 'saleReconciliationStatus');
      LRegistro.Fatura                   := RetornaValorJson(LJsonObjectValue, 'invoice');
      LRegistro.CodigoAntencipacao       := RetornaValorJson(LJsonObjectValue, 'advanceCode');
      LRegistro.Banco                    := RetornaValorJson(LJsonObjectValue, 'bankCode');
      LRegistro.AgenciaBancaria          := RetornaValorJson(LJsonObjectValue, 'bankAgency');
      LRegistro.ContaBancaria            := RetornaValorJson(LJsonObjectValue, 'bankAccount');
      LRegistro.Tid                      := RetornaValorJson(LJsonObjectValue, 'tid');
      LRegistro.Terminal                 := RetornaValorJson(LJsonObjectValue, 'terminal');
      LRegistro.CanalCaptura             := RetornaValorJson(LJsonObjectValue, 'captureChannel');
      LRegistro.DataDaVenda              := RetornaValorJson(LJsonObjectValue, 'saleDate');
      LRegistro.NumeroCartao             := RetornaValorJson(LJsonObjectValue, 'cardNumber');
      LRegistro.Classificacao            := RetornaValorJson(LJsonObjectValue, 'classification');
      LRegistro.TipoTransacao            := RetornaValorJson(LJsonObjectValue, 'transactionType');
      LRegistro.Resumo                   := RetornaValorJson(LJsonObjectValue, 'summary');
      LRegistro.IdUnico                  := RetornaValorJson(LJsonObjectValue, 'uniqueId');
      LRegistro.DataCriacao              := RetornaValorJson(LJsonObjectValue, 'createdAt');

      LRegistro.ValorBrutoParcela   :=  StrToFloatDef(RetornaValorJson(LJsonObjectValue, 'installmentAmount',True),0);
      LRegistro.ValorLiquidoPacrela :=  StrToFloatDef(RetornaValorJson(LJsonObjectValue, 'installmentNetAmount',True),0);
      LRegistro.ValorBruto          :=  StrToFloatDef(RetornaValorJson(LJsonObjectValue, 'grossAmount',True),0);
      LRegistro.ValorLiquido        :=  StrToFloatDef(RetornaValorJson(LJsonObjectValue, 'netAmount',True),0);
      LRegistro.TaxaAdministrativa  :=  StrToFloatDef(RetornaValorJson(LJsonObjectValue, 'administrationFee',True),0);
      LRegistro.TaxaAntecipacao     :=  StrToFloatDef(RetornaValorJson(LJsonObjectValue, 'advanceFeeAmount',True),0);
      LRegistro.ValorDesconto       :=  StrToFloatDef(RetornaValorJson(LJsonObjectValue, 'discount',True),0);
      LRegistro.ValorMarcacao       :=  StrToFloatDef(RetornaValorJson(LJsonObjectValue, 'markupAmount',True),0);
      LRegistro.TaxaEsquema         :=  StrToFloatDef(RetornaValorJson(LJsonObjectValue, 'schemeFeeAmount',True),0);
      LRegistro.ValorIntercambio    :=  StrToFloatDef(RetornaValorJson(LJsonObjectValue, 'interchangeAmount',True),0);
      LRegistro.ValorCarga          :=  StrToFloatDef(RetornaValorJson(LJsonObjectValue, 'chargeAmount',True),0);


      FConcilRegistrosPgto.Add(LRegistro);

      If (lstEstabel.IndexOf(LRegistro.Estabelecimento) < 0) Then
        lstEstabel.Add(LRegistro.Estabelecimento);
    end;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;


procedure TConcilAPIPgto.pAdicionaLinha(strString: String);
begin

  If strString.Trim.IsEmpty Then
    Exit;

  Try
    If FTipoDoArquivo = 'PAGAMENTOS' Then
      ImportaPagamentos(strString)
    Else If FTipoDoArquivo = 'AJUSTES' Then
      ImportaAjustes(strString);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TConcilAPIPgto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    LDados: IDataSet;
    LSQL: String;
    LContador: Integer;
    LRegistro: TConcilRegistroPgto;
    LRegistroAjuste: TConcilRegistroAjuste;
begin
  LSQL := RetornaSQLReplace('CON_APPGTO',
                             RetornaListaDeCampos(fRetEstruturaPgto('CON_APPGTO')),
                             ['CON_CONCIL']);

  LDados := objFunctions.fGetDataSet;
  LDados.Close;
  LDados.SQL := LSQL;

  pgbProg.Position := 0;

  pgbProg.Max := FConcilRegistrosPgto.Count;

  For LRegistro In FConcilRegistrosPgto Do
  Begin
    FImportouRegistro := True;
    FImportouPagamento := True;
    LDados.Close;

    Application.ProcessMessages;

    LDados.ParamByName(INICAM + 'NUM_ID').Value   := CorrigeDadosBanco(LRegistro.ID);
    LDados.ParamByName(INICAM + 'NUMPFJ').Value   := CorrigeDadosBanco(LRegistro.PFJ);
    LDados.ParamByName(INICAM + 'BRANCH').Value   := CorrigeDadosBanco(LRegistro.Branch);
    LDados.ParamByName(INICAM + 'CODEST').Value   := CorrigeDadosBanco(LRegistro.Estabelecimento);
    LDados.ParamByName(INICAM + 'NUMPAR').Value   := CorrigeDadosBanco(LRegistro.Parcela);
    LDados.ParamByName(INICAM + 'TOTPAR').Value   := CorrigeDadosBanco(LRegistro.TotalParcelas);
    LDados.ParamByName(INICAM + 'ID_ADQ').Value   := CorrigeDadosBanco(LRegistro.IDAdquirente);
    LDados.ParamByName(INICAM + 'BRANID').Value   := CorrigeDadosBanco(LRegistro.BrandId);
    LDados.ParamByName(INICAM + 'PRO_ID').Value   := CorrigeDadosBanco(LRegistro.ProductId);
    LDados.ParamByName(INICAM + 'NUMNSU').Value   := CorrigeDadosBanco(LRegistro.Nsu);
    LDados.ParamByName(INICAM + 'CODAUT').Value   := CorrigeDadosBanco(LRegistro.Autorizacao);
    LDados.ParamByName(INICAM + 'DTAPAG').Value   := CorrigeDadosBanco(LRegistro.DataPagamento, True);
    LDados.ParamByName(INICAM + 'STATUS').Value   := CorrigeDadosBanco(LRegistro.Status);
    LDados.ParamByName(INICAM + 'STAREC').Value   := CorrigeDadosBanco(LRegistro.StatusReconciliacaoVenda);
    LDados.ParamByName(INICAM + 'NUMFAT').Value   := CorrigeDadosBanco(LRegistro.Fatura);
    LDados.ParamByName(INICAM + 'CODANT').Value   := CorrigeDadosBanco(LRegistro.CodigoAntencipacao);
    LDados.ParamByName(INICAM + 'CODBCO').Value   := CorrigeDadosBanco(LRegistro.Banco);
    LDados.ParamByName(INICAM + 'NUMAGE').Value   := CorrigeDadosBanco(LRegistro.AgenciaBancaria);
    LDados.ParamByName(INICAM + 'NUMCTA').Value   := CorrigeDadosBanco(LRegistro.ContaBancaria);
    LDados.ParamByName(INICAM + 'NUMTID').Value   := CorrigeDadosBanco(LRegistro.Tid);
    LDados.ParamByName(INICAM + 'NUMTER').Value   := CorrigeDadosBanco(LRegistro.Terminal);
    LDados.ParamByName(INICAM + 'CANCAP').Value   := CorrigeDadosBanco(LRegistro.CanalCaptura);
    LDados.ParamByName(INICAM + 'DTAVDA').Value   := CorrigeDadosBanco(LRegistro.DataDaVenda, True);
    LDados.ParamByName(INICAM + 'NUMCAR').Value   := CorrigeDadosBanco(LRegistro.NumeroCartao);
    LDados.ParamByName(INICAM + 'CLAPAG').Value   := CorrigeDadosBanco(LRegistro.Classificacao);
    LDados.ParamByName(INICAM + 'TIPTRA').Value   := CorrigeDadosBanco(LRegistro.TipoTransacao);
    LDados.ParamByName(INICAM + 'NUMRES').Value   := CorrigeDadosBanco(LRegistro.Resumo);
    LDados.ParamByName(INICAM + 'ID_UNI').Value   := CorrigeDadosBanco(LRegistro.IdUnico);
    LDados.ParamByName(INICAM + 'DTACRI').Value   := CorrigeDadosBanco(LRegistro.DataCriacao, True);
    LDados.ParamByName(INICAM + 'BRUPAR').Value   := CorrigeDadosBanco(LRegistro.ValorBrutoParcela);
    LDados.ParamByName(INICAM + 'LIQPAR').Value   := CorrigeDadosBanco(LRegistro.ValorLiquidoPacrela);
    LDados.ParamByName(INICAM + 'VALBRU').Value   := CorrigeDadosBanco(LRegistro.ValorBruto);
    LDados.ParamByName(INICAM + 'VALLIQ').Value   := CorrigeDadosBanco(LRegistro.ValorLiquido);
    LDados.ParamByName(INICAM + 'TAXADM').Value   := CorrigeDadosBanco(LRegistro.TaxaAdministrativa);
    LDados.ParamByName(INICAM + 'TAXANT').Value   := CorrigeDadosBanco(LRegistro.TaxaAntecipacao);
    LDados.ParamByName(INICAM + 'VALDES').Value   := CorrigeDadosBanco(LRegistro.ValorDesconto);
    LDados.ParamByName(INICAM + 'VALMAR').Value   := CorrigeDadosBanco(LRegistro.ValorMarcacao);
    LDados.ParamByName(INICAM + 'TAXESQ').Value   := CorrigeDadosBanco(LRegistro.TaxaEsquema);
    LDados.ParamByName(INICAM + 'VALINT').Value   := CorrigeDadosBanco(LRegistro.ValorIntercambio);
    LDados.ParamByName(INICAM + 'VALCAR').Value   := CorrigeDadosBanco(LRegistro.ValorCarga);

    LDados.ExecSQL;

    pgbProg.Position := pgbProg.Position + 1;
    Application.ProcessMessages;


  End;

  LSQL := RetornaSQLReplace('CON_APAJUS',
                             RetornaListaDeCampos(fRetEstruturaPgto('CON_APAJUS')),
                             ['CON_CONCIL']);

  LDados.Close;
  LDados.SQL := LSQL;
  pgbProg.Position := 0;
  pgbProg.Max := FConcilRegistrosAjuste.Count;

  For LRegistroAjuste In FConcilRegistrosAjuste Do
  Begin
    FImportouRegistro := True;
    LDados.Close;

    Application.ProcessMessages;

    LDados.ParamByName(INICAM + 'NUMPFJ').Value   := CorrigeDadosBanco(LRegistroAjuste.PFJ);
    LDados.ParamByName(INICAM + 'BRANCH').Value   := CorrigeDadosBanco(LRegistroAjuste.Branch);
    LDados.ParamByName(INICAM + 'CODEST').Value   := CorrigeDadosBanco(LRegistroAjuste.Estabelecimento);
    LDados.ParamByName(INICAM + 'NUMPAR').Value   := CorrigeDadosBanco(LRegistroAjuste.Parcela);
    LDados.ParamByName(INICAM + 'TOTPAR').Value   := CorrigeDadosBanco(LRegistroAjuste.TotalParcelas);
    LDados.ParamByName(INICAM + 'ID_ADQ').Value   := CorrigeDadosBanco(LRegistroAjuste.IDAdquirente);
    LDados.ParamByName(INICAM + 'BRANID').Value   := CorrigeDadosBanco(LRegistroAjuste.BrandId);
    LDados.ParamByName(INICAM + 'PRO_ID').Value   := CorrigeDadosBanco(LRegistroAjuste.ProductId);
    LDados.ParamByName(INICAM + 'NUMNSU').Value   := CorrigeDadosBanco(LRegistroAjuste.Nsu);
    LDados.ParamByName(INICAM + 'CODAUT').Value   := CorrigeDadosBanco(LRegistroAjuste.Autorizacao);
    LDados.ParamByName(INICAM + 'DTAAJU').Value   := CorrigeDadosBanco(LRegistroAjuste.DataAjuste, True);
    LDados.ParamByName(INICAM + 'NUMFAT').Value   := CorrigeDadosBanco(LRegistroAjuste.Fatura);
    LDados.ParamByName(INICAM + 'CODANT').Value   := CorrigeDadosBanco(LRegistroAjuste.CodigoAntencipacao);
    LDados.ParamByName(INICAM + 'CODBCO').Value   := CorrigeDadosBanco(LRegistroAjuste.Banco);
    LDados.ParamByName(INICAM + 'NUMAGE').Value   := CorrigeDadosBanco(LRegistroAjuste.AgenciaBancaria);
    LDados.ParamByName(INICAM + 'NUMCTA').Value   := CorrigeDadosBanco(LRegistroAjuste.ContaBancaria);
    LDados.ParamByName(INICAM + 'NUMTID').Value   := CorrigeDadosBanco(LRegistroAjuste.Tid);
    LDados.ParamByName(INICAM + 'NUMTER').Value   := CorrigeDadosBanco(LRegistroAjuste.Terminal);
    LDados.ParamByName(INICAM + 'CANCAP').Value   := CorrigeDadosBanco(LRegistroAjuste.CanalCaptura);
    LDados.ParamByName(INICAM + 'DTAVDA').Value   := CorrigeDadosBanco(LRegistroAjuste.DataDaVenda, True);
    LDados.ParamByName(INICAM + 'NUMCAR').Value   := CorrigeDadosBanco(LRegistroAjuste.NumeroCartao);
    LDados.ParamByName(INICAM + 'TIPTRA').Value   := CorrigeDadosBanco(LRegistroAjuste.TipoTransacao);
    LDados.ParamByName(INICAM + 'NUMRES').Value   := CorrigeDadosBanco(LRegistroAjuste.Resumo);
    LDados.ParamByName(INICAM + 'ID_UNI').Value   := CorrigeDadosBanco(LRegistroAjuste.IdUnico);
    LDados.ParamByName(INICAM + 'DTACRI').Value   := CorrigeDadosBanco(LRegistroAjuste.DataCriacao, True);
    LDados.ParamByName(INICAM + 'VALAJU').Value   := CorrigeDadosBanco(LRegistroAjuste.ValorAjuste);

    LDados.ExecSQL;

    pgbProg.Position := pgbProg.Position + 1;
    Application.ProcessMessages;


  End;


  Try
    LDados.Close;
    LDados.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "Concil API")';
    For LContador := 0 To lstEstabel.Count - 1 Do
    Begin
      LDados.ParamByName('ESTAB').AsString := lstEstabel[LContador];
      LDados.ExecSQL;
    End;
  Except
    Raise Exception.Create('A tabela ESTCAR não foi criada. Entre em contato com a Citel!');
  End;
end;

function TConcilAPIPgto.RetornaListaDeCampos(
  AObjetoCampos: TArrEstruturaConcilAPIPgto): TStringList;
  Var
    LContador: Integer;
begin
  Result := TStringList.Create;

  For LContador := 0 To Length(AObjetoCampos) - 1 Do
    Result.Add(AObjetoCampos[LContador].strDescri);
end;

function TConcilAPIPgto.RetornaValorJson(AObjeto: TJsonObject;
  ANomeCampo: String; AIsFloat: Boolean = False): String;
begin
  Result := '';
  If AObjeto.GetValue(ANomeCampo) <> Nil Then
  Begin
    Result := AObjeto.GetValue<string>(ANomeCampo);
    If AIsFloat Then
      Result := Result.Replace('.',',');
  End
end;

end.
