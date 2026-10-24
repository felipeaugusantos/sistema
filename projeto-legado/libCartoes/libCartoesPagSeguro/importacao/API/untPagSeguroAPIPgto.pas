unit untPagSeguroAPIPgto;

interface
uses System.Classes, System.StrUtils, System.SysUtils, System.Variants,
     Vcl.ComCtrls, Vcl.Forms, System.Generics.Collections, System.Json,
     Data.DB,

     cxProgressBar, Uni,

     untPagSeguroTipos, untIPagSeguroIntegracaolibCartoes, untTPagSeguroFuncoes;

Type
  TArrEstruturaPagSeguroAPIPgto = Array Of TEstruturaPgto;

  TPagSeguroAPIPgto = Class(TInterfacedObject, ICartoes)
  Private
    FPagSeguroRegistrosPgto: TList<TPagSeguroRegistroPgto>;
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
    function RetornaTipoDoRegistro(ATipoEvento: String; ALiquidoAntecipacao: Double): String;
    function ImportaRegistro(ARegistro: TPagSeguroRegistroPgto): Boolean;
    function RetornaNomeArquivo(LRegistro : TPagSeguroRegistroPgto) : String;
    Function fVerificaRegistro_TF_JaConciliado(ARegistro: TPagSeguroRegistroPgto; ANumnsu, ACodAut : String): Boolean;

  Public
    constructor Create;
    destructor Destroy; override;

    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TcxProgressBar);
    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaPagSeguroAPIPgto;
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
  NOMTAB = 'PAG_APPGTO';
  INICAM = 'PAG_';

implementation

{ TPagSeguroAPIPgto }

function TPagSeguroAPIPgto.CorrigeDadosBanco(AValor: Variant;
                                            ACampoData: Boolean = False): Variant;
begin
  Result := Null;
  If Not TPagSeguroFuncoes.fEmptyStr(AValor) Then
    Result := AValor;
end;

constructor TPagSeguroAPIPgto.Create;
begin
  FImportouRegistro := False;
  FImportouPagamento := False;

  FPagSeguroRegistrosPgto := TList<TPagSeguroRegistroPgto>.Create;
end;

destructor TPagSeguroAPIPgto.Destroy;
begin
  If Assigned(FPagSeguroRegistrosPgto) Then
  Begin
    FPagSeguroRegistrosPgto.Clear;
    FreeAndNil(FPagSeguroRegistrosPgto);
  End;

  inherited;
end;

class function TPagSeguroAPIPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaPagSeguroAPIPgto;
Begin
  If strTabela = 'PAG_APPGTO' Then
  Begin
    SetLength(Result, 34);

    Result[0].strDescri  := INICAM + 'TIPREG'; Result[0].strTipCmp  := 'VARCHAR(2)'   ;
    Result[1].strDescri  := INICAM + 'CODEST'; Result[1].strTipCmp  := 'VARCHAR(15)'  ;
    Result[2].strDescri  := INICAM + 'TIPEVE'; Result[2].strTipCmp  := 'VARCHAR(2)'   ;
    Result[3].strDescri  := INICAM + 'DTATRA'; Result[3].strTipCmp  := 'DATE'         ;
    Result[4].strDescri  := INICAM + 'DTAPAG'; Result[4].strTipCmp  := 'DATE'         ;
    Result[5].strDescri  := INICAM + 'DTAAJU'; Result[5].strTipCmp  := 'DATE'         ;
    Result[6].strDescri  := INICAM + 'CODAUT'; Result[6].strTipCmp  := 'VARCHAR(6)'   ;
    Result[7].strDescri  := INICAM + 'TIPTRA'; Result[7].strTipCmp  := 'VARCHAR(2)'   ;
    Result[8].strDescri  := INICAM + 'NUM_CV'; Result[8].strTipCmp  := 'VARCHAR(32)'  ;
    Result[9].strDescri  := INICAM + 'CODTRA'; Result[9].strTipCmp  := 'VARCHAR(32)'  ;
    Result[10].strDescri := INICAM + 'CODVEN'; Result[10].strTipCmp := 'VARCHAR(20)'  ;
    Result[11].strDescri := INICAM + 'VALBRU'; Result[11].strTipCmp := 'DECIMAL(15,2)';
    Result[12].strDescri := INICAM + 'VALPAR'; Result[12].strTipCmp := 'DECIMAL(15,2)';
    Result[13].strDescri := INICAM + 'TOTPAR'; Result[13].strTipCmp := 'VARCHAR(2)'   ;
    Result[14].strDescri := INICAM + 'NUMPAR'; Result[14].strTipCmp := 'VARCHAR(2)'   ;
    Result[15].strDescri := INICAM + 'VALLIQ'; Result[15].strTipCmp := 'DECIMAL(15,2)';
    Result[16].strDescri := INICAM + 'TAXANT'; Result[16].strTipCmp := 'DECIMAL(15,2)';
    Result[17].strDescri := INICAM + 'LIQANT'; Result[17].strTipCmp := 'DECIMAL(15,2)';
    Result[18].strDescri := INICAM + 'STAPAG'; Result[18].strTipCmp := 'VARCHAR(2)'   ;
    Result[19].strDescri := INICAM + 'MEIPAG'; Result[19].strTipCmp := 'VARCHAR(2)'   ;
    Result[20].strDescri := INICAM + 'NUMNSU'; Result[20].strTipCmp := 'VARCHAR(12)'  ;
    Result[21].strDescri := INICAM + 'NUMCAR'; Result[21].strTipCmp := 'VARCHAR(19)'  ;
    Result[22].strDescri := INICAM + 'NOMARQ'; Result[22].strTipCmp := 'VARCHAR(255)' ;
    Result[23].strDescri := INICAM + 'DTAARQ'; Result[23].strTipCmp := 'DATE'         ;
    Result[24].strDescri := INICAM + 'CONCIL'; Result[24].strTipCmp := 'INT DEFAULT 0';
    Result[25].strDescri := INICAM + 'PAGPRA'; Result[25].strTipCmp := 'VARCHAR(1)'   ;
    Result[26].strDescri := INICAM + 'CANENT'; Result[26].strTipCmp := 'VARCHAR(2)'   ;
    Result[27].strDescri := INICAM + 'MEICAP'; Result[27].strTipCmp := 'VARCHAR(2)'   ;
    Result[28].strDescri := INICAM + 'TAXINT'; Result[28].strTipCmp := 'DECIMAL(15,2)';
    Result[29].strDescri := INICAM + 'TAXPAR'; Result[29].strTipCmp := 'DECIMAL(15,2)';
    Result[30].strDescri := INICAM + 'PLANO_'; Result[30].strTipCmp := 'VARCHAR(2)'   ;
    Result[31].strDescri := INICAM + 'TX_ID_'; Result[31].strTipCmp := 'VARCHAR(50)'  ;
    Result[32].strDescri := INICAM + 'COD_UR'; Result[32].strTipCmp := 'VARCHAR(50)'  ;
    Result[33].strDescri := INICAM + 'ARRUR_'; Result[33].strTipCmp := 'VARCHAR(20)'  ;
  End;
End;

class function TPagSeguroAPIPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
  Var
    arrCampos: TArrEstruturaPagSeguroAPIPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + ' PRIMARY KEY(PAG_CODEST,PAG_TIPREG,PAG_DTAPAG,PAG_TIPEVE,PAG_DTATRA,PAG_CODAUT,PAG_NUMPAR,PAG_NUMNSU)) ENGINE INNODB ' ;
end;


procedure TPagSeguroAPIPgto.ImportaPagamentos(strString: String);
  Var
    LRegistro: TPagSeguroRegistroPgto;
    LJsonObject,
    LJsonObjectValue: TJsonObject;
    LJsonArray: TJSONArray;
    LJsonValue: TJsonValue;
begin
  LJsonObject := Nil;
  LJsonObjectValue := Nil;
  LJsonArray := Nil;
  Try
    LJsonObject := TJSONObject.ParseJSONValue(strString) as TJSONObject;
    If LJsonObject = Nil Then
      Exit;

    FProximaPagina := '';

    If LJsonObject.GetValue('pagination') = Nil Then
      Exit;

    LJsonObjectValue := TJSONObject.ParseJSONValue(LJsonObject.GetValue('pagination').ToJson) as TJSONObject;

    If (LJsonObjectValue.GetValue<Integer>('totalPages') = 0) Then
      Exit;

    If LJsonObjectValue.GetValue<Integer>('page') <> LJsonObjectValue.GetValue<Integer>('totalPages') Then
      FProximaPagina := IntToStr((LJsonObjectValue.GetValue<Integer>('page') + 1));

    LJsonArray := TJSONObject.ParseJSONValue(LJsonObject.GetValue('detalhes').ToJson) as TJsonArray;

    For LJsonValue In LJsonArray Do
    Begin
      TPagSeguroFuncoes.FreeAndNilObjeto(LJsonObjectValue);
      LJsonObjectValue := TJSONObject.ParseJSONValue(LJSonValue.ToString) as TJSONObject;

      LRegistro.strTipEve := RetornaValorJson(LJsonObjectValue, 'tipo_evento').PadLeft(2,'0');
      LRegistro.fltLiqAnt := StrToFloatDef(RetornaValorJson(LJsonObjectValue, 'valor_liquido_antecipacao',True),0);

      LRegistro.strTipReg := RetornaTipoDoRegistro(LRegistro.strTipEve,
                                                   LRegistro.fltLiqAnt);

      LRegistro.strCodEst := RetornaValorJson(LJsonObjectValue, 'estabelecimento');
      LRegistro.strDtaTra := RetornaValorJson(LJsonObjectValue, 'data_inicial_transacao');
      LRegistro.strDtaAju := RetornaValorJson(LJsonObjectValue, 'data_venda_ajuste');
      LRegistro.strTipTra := RetornaValorJson(LJsonObjectValue, 'tipo_transacao').PadLeft(2,'0');
      LRegistro.strCodTra := RetornaValorJson(LJsonObjectValue, 'codigo_transacao');
      LRegistro.strTxId   := RetornaValorJson(LJsonObjectValue, 'tx_id');
      LRegistro.strCodUr  := RetornaValorJson(LJsonObjectValue, 'codigo_ur');
      LRegistro.strArrUr  := RetornaValorJson(LJsonObjectValue, 'arranjo_ur');
      LRegistro.strCodVen := RetornaValorJson(LJsonObjectValue, 'codigo_venda');
      LRegistro.fltValBru := StrToFloatDef(RetornaValorJson(LJsonObjectValue, 'valor_total_transacao',True),0);
      LRegistro.fltValPar := StrToFloatDef(RetornaValorJson(LJsonObjectValue, 'valor_parcela',True),0);

      LRegistro.PagamentoAPrazo := 'M';

      LRegistro.TaxaIntermediacao := 0.00;
      LRegistro.TaxaParcelamento  := 0.00;

      If LRegistro.fltLiqAnt = 0 Then
      Begin
        LRegistro.PagamentoAPrazo := RetornaValorJson(LJsonObjectValue, 'pagamento_prazo');
        LRegistro.Plano := Trim(RetornaValorJson(LJsonObjectValue, 'plano'));
        LRegistro.strNumPar := RetornaValorJson(LJsonObjectValue, 'parcela').PadLeft(2,'0');
        LRegistro.strTotPar := RetornaValorJson(LJsonObjectValue, 'quantidade_parcelas').PadLeft(2,'0');
        LRegistro.strDtaPag := RetornaValorJson(LJsonObjectValue, 'data_movimentacao');
        LRegistro.fltValLiq := StrToFloatDef(RetornaValorJson(LJsonObjectValue, 'valor_liquido_transacao',True),0);
        LRegistro.fltTaxAnt := StrToFloatDef(RetornaValorJson(LJsonObjectValue, 'taxa_antecipacao',True),0);
        LRegistro.strStaPag := RetornaValorJson(LJsonObjectValue, 'status_pagamento');
        LRegistro.strMeiPag := RetornaValorJson(LJsonObjectValue, 'meio_pagamento').PadLeft(2,'0');
        LRegistro.strNumNSU := RetornaValorJson(LJsonObjectValue, 'nsu');
        LRegistro.strNumCar := RetornaValorJson(LJsonObjectValue, 'cartao_bin') + '*********' + RetornaValorJson(LJsonObjectValue, 'cartao_holder');
        LRegistro.strCodAut := RetornaValorJson(LJsonObjectValue, 'codigo_autorizacao');
        LRegistro.strCod_CV := RetornaValorJson(LJsonObjectValue, 'codigo_cv');

        LRegistro.CanalDeEntrada    := RetornaValorJson(LJsonObjectValue, 'canal_entrada');
        LRegistro.MeioDeCaptura     := RetornaValorJson(LJsonObjectValue, 'meio_captura');
        LRegistro.TaxaIntermediacao := StrToFloatDef(RetornaValorJson(LJsonObjectValue, 'taxa_intermediacao',True),0);
        LRegistro.TaxaParcelamento  := StrToFloatDef(RetornaValorJson(LJsonObjectValue, 'taxa_parcela_vendedor',True),0);

        If LRegistro.strTipReg = 'TF' Then
          LRegistro.strNumNSU := RetornaValorJson(LJsonObjectValue, 'codigo_transacao');
      End
      Else
      Begin
        LRegistro.Plano := Trim(RetornaValorJson(LJsonObjectValue,'plano'));
        LRegistro.strNumPar := RetornaValorJson(LJsonObjectValue, 'parcela').PadLeft(2,'0');
        LRegistro.strTotPar := RetornaValorJson(LJsonObjectValue, 'quantidade_parcelas').PadLeft(2,'0');
        LRegistro.strDtaPag := RetornaValorJson(LJsonObjectValue, 'data_movimentacao');
        LRegistro.fltValLiq := StrToFloatDef(RetornaValorJson(LJsonObjectValue, 'valor_liquido_antecipacao',True),0);
        LRegistro.fltTaxAnt := StrToFloatDef(RetornaValorJson(LJsonObjectValue, 'taxa_antecipacao',True),0);
        LRegistro.strStaPag := RetornaValorJson(LJsonObjectValue, 'status_pagamento');
        LRegistro.strMeiPag := '04';
        LRegistro.strNumNSU := RetornaValorJson(LJsonObjectValue, 'nsu');
        LRegistro.strNumCar := RetornaValorJson(LJsonObjectValue, 'cartao_bin') + '*********' + RetornaValorJson(LJsonObjectValue, 'cartao_holder');
        LRegistro.strCodAut := RetornaValorJson(LJsonObjectValue, 'codigo_autorizacao');
        LRegistro.strCod_CV := RetornaValorJson(LJsonObjectValue, 'codigo_cv');

        LRegistro.CanalDeEntrada := '';
        LRegistro.MeioDeCaptura := '';
      End;

      LRegistro.strDtaArq := FormatDateTime('yyyy/mm/dd',Date);
      LRegistro.strNomArq := RetornaNomeArquivo(LRegistro);

      FPagSeguroRegistrosPgto.Add(LRegistro);

      If (VS_ListaEstabelecimentos.IndexOf(LRegistro.strCodEst) < 0) Then
        VS_ListaEstabelecimentos.Add(LRegistro.strCodEst);
    end;

  Finally
    TPagSeguroFuncoes.FreeAndNilObjeto(LJsonObjectValue);
    TPagSeguroFuncoes.FreeAndNilObjeto(LJsonArray);
    TPagSeguroFuncoes.FreeAndNilObjeto(LJsonObject);
  End;
end;


function TPagSeguroAPIPgto.ImportaRegistro(
  ARegistro: TPagSeguroRegistroPgto): Boolean;
begin
  Result := True;

  If ARegistro.strTipEve = '04' Then
    Exit;

  If ARegistro.strTipReg = '' Then
  Begin
    Result := False;
    Exit;
  End;

  If ARegistro.strCodEst = '' Then
  Begin
    Result := False;
    Exit;
  End;

  If ARegistro.strTipTra <> '09' Then
  Begin
    If ARegistro.strMeiPag = '00' Then
    Begin
      Result := False;
      Exit;
    End;
    If ARegistro.strTipTra <> '01' Then
    Begin
      If ARegistro.strCodVen = '' Then
      Begin
        Result := False;
        Exit;
      End;
    End;
  End;
end;

procedure TPagSeguroAPIPgto.pAdicionaLinha(strString: String);
begin

  If strString.Trim.IsEmpty Then
    Exit;

  Try
    If FTipoDoArquivo = 'PAGAMENTOS' Then
    Begin
      ImportaPagamentos(strString);
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

Function TPagSeguroAPIPgto.fVerificaRegistro_TF_JaConciliado(ARegistro: TPagSeguroRegistroPgto; ANumnsu, ACodAut : String) : Boolean;
  Var
    LConsulta: TUniQuery;

    LSQL: String;
begin
  LSQL := ' SELECT PAG_CONCIL FROM PAG_APPGTO ' +
          '  WHERE ' +
          '        PAG_CODEST = :CODEST ' +
          '    AND PAG_TIPREG = :TIPREG ' +
          '    AND PAG_DTAPAG = :DTAPAG ' +
          '    AND PAG_TIPEVE = :TIPEVE ' +
          '    AND PAG_DTATRA = :DTATRA ' +
          '    AND PAG_CODAUT = :CODAUT ' +
          '    AND PAG_NUMPAR = :NUMPAR ' +
          '    AND PAG_NUMNSU = :NUMNSU ' +
          '    AND PAG_CONCIL = 1 ';

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := LSQL;

    LConsulta.ParamByName('CODEST').Value := CorrigeDadosBanco(ARegistro.strCodEst);
    LConsulta.ParamByName('TIPREG').Value := CorrigeDadosBanco(ARegistro.strTipReg);
    LConsulta.ParamByName('DTAPAG').Value := CorrigeDadosBanco(ARegistro.strDtaPag, True);
    LConsulta.ParamByName('TIPEVE').Value := CorrigeDadosBanco(ARegistro.strTipEve);
    LConsulta.ParamByName('DTATRA').Value := CorrigeDadosBanco(ARegistro.strDtaTra, True);
    LConsulta.ParamByName('CODAUT').Value := ACodAut;
    LConsulta.ParamByName('NUMPAR').Value := CorrigeDadosBanco(ARegistro.strNumPar);
    LConsulta.ParamByName('NUMNSU').Value := ANumnsu;

    LConsulta.Open;
    Result := Not LConsulta.IsEmpty;
  Finally
    TPagSeguroFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

procedure TPagSeguroAPIPgto.pGravarRegistros(pgbProg: TcxProgressBar);
  Var
    LGravacao: TUniQuery;

    LRegistro: TPagSeguroRegistroPgto;
begin
  LGravacao := Nil;
  Try
    LGravacao := VS_FuncoesExternas.fICriaQuery;
    LGravacao.SQL.Text := TPagSeguroFuncoes.RetornaSQLReplace('PAG_APPGTO', ['PAG_CONCIL']);

    pgbProg.Position := 0;

    If FPagSeguroRegistrosPgto.Count = 0 Then
      Exit;

    pgbProg.Properties.Max := FPagSeguroRegistrosPgto.Count;

    For LRegistro In FPagSeguroRegistrosPgto Do
    Begin
      FImportouRegistro := True;
      LGravacao.Close;

      If Not ImportaRegistro(LRegistro) Then
      Begin
        TPagSeguroFuncoes.pStepStatusGravacao(pgbProg);

        Continue;
      End;

      If MatchStr(LRegistro.strTipReg, ['PG', 'AP', 'AJ', 'TF']) Then
        FImportouPagamento := True;

      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_TIPREG', CorrigeDadosBanco(LRegistro.strTipReg));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_CODEST', CorrigeDadosBanco(LRegistro.strCodEst));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_TIPEVE', CorrigeDadosBanco(LRegistro.strTipEve));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_NUM_CV', CorrigeDadosBanco(LRegistro.strCod_CV));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_DTATRA', CorrigeDadosBanco(LRegistro.strDtaTra, True));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_DTAPAG', CorrigeDadosBanco(LRegistro.strDtaPag, True));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_DTAAJU', CorrigeDadosBanco(LRegistro.strDtaAju, True));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_TIPTRA', CorrigeDadosBanco(LRegistro.strTipTra));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_TOTPAR', CorrigeDadosBanco(LRegistro.strTotPar));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_NUMPAR', CorrigeDadosBanco(LRegistro.strNumPar));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_VALPAR', CorrigeDadosBanco(LRegistro.fltValPar));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_CODAUT', CorrigeDadosBanco(LRegistro.strCodAut));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_NUMNSU', CorrigeDadosBanco(LRegistro.strNumNSU));

      If (Not MatchStr(CorrigeDadosBanco(LRegistro.strMeiPag), ['03', '08', '11'])) Then
      Begin
        If (LRegistro.strCodAut = '') Then
          TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_CODAUT', LeftStr(LRegistro.strCodVen, 6));

         If LRegistro.strNumNsu.Trim.IsEmpty Then
        Begin
          If Not Concat(LRegistro.strTipTra, LRegistro.strCodVen).Equals('09') Then
            TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_NUMNSU', LeftStr(LRegistro.strCodVen, 11))
          Else
            TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_NUMNSU', LeftStr(LRegistro.strCodTra, 11));
        End;

        If LGravacao.ParamByName('PAG_CODAUT').AsString.Trim.isEmpty Then
          TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_CODAUT', LGravacao.ParamByName('PAG_NUMNSU').AsString);
      End
      Else If LRegistro.strMeiPag.Equals('11') Then
      Begin
        TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_CODAUT', RightStr(CorrigeDadosBanco(LRegistro.strCodTra), 6));
        TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_NUMNSU', RightStr(CorrigeDadosBanco(LRegistro.strCodTra), 11));
      End;

      If LGravacao.ParamByName('PAG_NUMNSU').AsString.IsEmpty Then
        Continue;

      If MatchStr(LRegistro.strTipReg, ['TF']) Then
      Begin
        If fVerificaRegistro_TF_JaConciliado(LRegistro,
                                             LeftStr(LGravacao.ParamByName('PAG_NUMNSU').AsString,12),
                                             LeftStr(LGravacao.ParamByName('PAG_CODAUT').AsString,6)) Then
        Begin
          TPagSeguroFuncoes.pStepStatusGravacao(pgbProg);

          Continue;
        End;
      End;

      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_NUMCAR', CorrigeDadosBanco(LRegistro.strNumCar));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_CODTRA', CorrigeDadosBanco(LRegistro.strCodTra));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_CODVEN', CorrigeDadosBanco(LRegistro.strCodVen));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_VALBRU', CorrigeDadosBanco(LRegistro.fltValBru));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_VALLIQ', CorrigeDadosBanco(LRegistro.fltValLiq));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_LIQANT', CorrigeDadosBanco(LRegistro.fltLiqAnt));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_TAXANT', CorrigeDadosBanco(LRegistro.fltTaxAnt));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_STAPAG', CorrigeDadosBanco(LRegistro.strStaPag));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_MEIPAG', CorrigeDadosBanco(LRegistro.strMeiPag));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_NOMARQ', CorrigeDadosBanco(LRegistro.strNomArq));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_DTAARQ', CorrigeDadosBanco(LRegistro.strDtaArq, True));

      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_PAGPRA', CorrigeDadosBanco(LRegistro.PagamentoAPrazo));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_CANENT', CorrigeDadosBanco(LRegistro.CanalDeEntrada));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_MEICAP', CorrigeDadosBanco(LRegistro.MeioDeCaptura));

      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_TAXINT', CorrigeDadosBanco(LRegistro.TaxaIntermediacao));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_TAXPAR', CorrigeDadosBanco(LRegistro.TaxaParcelamento));

      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_PLANO_', CorrigeDadosBanco(LRegistro.Plano));

      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_TX_ID_', CorrigeDadosBanco(LRegistro.strTxId));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_COD_UR', CorrigeDadosBanco(LRegistro.strCodUr));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_ARRUR_', CorrigeDadosBanco(LRegistro.strArrUr));

      LGravacao.ExecSQL;

      TPagSeguroFuncoes.pStepStatusGravacao(pgbProg);
    End;

    TPagSeguroFuncoes.GravarEstabelecimentos(True);

    Application.ProcessMessages;
  Finally
    TPagSeguroFuncoes.FreeAndNilDatasets(LGravacao);
  End;
end;

function TPagSeguroAPIPgto.RetornaNomeArquivo(
  LRegistro: TPagSeguroRegistroPgto): String;
begin
  Result := 'PAGSEG_[ESTABELECIMENTO]_[EXTRATO]_[DATAEVENTO]_[DATAPROCESSAMENTO]_3.00';
  Result := Result.Replace('[ESTABELECIMENTO]',LRegistro.strCodEst);
  Result := Result.Replace('[EXTRATO]', TPagSeguroFuncoes.IIF(LRegistro.strTipReg.Equals('AP'),'ANT','FIN'));
  Result := Result.Replace('[DATAEVENTO]',LRegistro.strDtaTra);
  Result := Result.Replace('[DATAPROCESSAMENTO]',LRegistro.strDtaPag);
end;

function TPagSeguroAPIPgto.RetornaTipoDoRegistro(ATipoEvento: String;
  ALiquidoAntecipacao: Double): String;
begin
  Result := 'PG';

  If (ALiquidoAntecipacao <> 0)  Then
    Result := 'AP'
  Else If MatchStr(ATipoEvento, ['04','17']) Then
    Result := 'TF'
  Else If (ATipoEvento <> '01') Then
    Result := 'AJ';
end;

function TPagSeguroAPIPgto.RetornaValorJson(AObjeto: TJsonObject;
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
