unit untPagSeguroAPIPgto;

interface
uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls,
     Dialogs, Forms, untTPagSeguro, System.Generics.Collections, Json;

Type
  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

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
    function RetornaListaDeCampos(AObjetoCampos: TArrEstruturaPagSeguroAPIPgto): TStringList;
    function RetornaNomeArquivo(LRegistro : TPagSeguroRegistroPgto) : String;
    Function fVerificaRegistro_TF_JaConciliado(ARegistro: TPagSeguroRegistroPgto; ANumnsu, ACodAut : String): Boolean;

  Public
    constructor Create;
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);
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

uses untFuncoes, untIDataSet;

{ TPagSeguroAPIPgto }

function TPagSeguroAPIPgto.CorrigeDadosBanco(AValor: Variant;
                                            ACampoData: Boolean = False): Variant;
begin
  Result := Null;
  If Not fEmptyStr(AValor) Then
  Begin
    Result := AValor;
  End;
end;

constructor TPagSeguroAPIPgto.Create;
begin
  FImportouRegistro := False;
  FImportouPagamento := False;

  FPagSeguroRegistrosPgto := TList<TPagSeguroRegistroPgto>.Create;
end;

class function TPagSeguroAPIPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaPagSeguroAPIPgto;
Begin
  If strTabela = 'PAG_APPGTO' Then
  Begin
    SetLength(Result, 31);

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

  Try
    LJsonObject := TJSONObject.ParseJSONValue(strString) as TJSONObject;

    FProximaPagina := '';
    LJsonObjectValue := LJsonObject.GetValue<TJSONObject>('pagination') as TJSONObject;

    If (LJsonObjectValue.GetValue<Integer>('totalPages') = 0) Then
      Exit;

    If LJsonObjectValue.GetValue<Integer>('page') <> LJsonObjectValue.GetValue<Integer>('totalPages') Then
      FProximaPagina := IntToStr((LJsonObjectValue.GetValue<Integer>('page') + 1));

    LJsonArray := LJsonObject.GetValue('detalhes') as TJsonArray;

    For LJsonValue In LJsonArray Do
    Begin
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

      If (lstEstabel.IndexOf(LRegistro.strCodEst) < 0) Then
        lstEstabel.Add(LRegistro.strCodEst);
    end;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
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
    LConsulta: IDataSet;
    LSQL: String;
begin
  Result := False;

  // PAG_CODEST,PAG_TIPREG,PAG_DTAPAG,PAG_TIPEVE,PAG_DTATRA,PAG_CODAUT,PAG_NUMPAR,PAG_NUMNSU

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

  LConsulta := objFunctions.fGetDataSet;
  LConsulta.Close;
  LConsulta.SQL := LSQL;

  LConsulta.ParamByName('CODEST').Value := CorrigeDadosBanco(ARegistro.strCodEst);
  LConsulta.ParamByName('TIPREG').Value := CorrigeDadosBanco(ARegistro.strTipReg);
  LConsulta.ParamByName('DTAPAG').Value := CorrigeDadosBanco(ARegistro.strDtaPag, True);
  LConsulta.ParamByName('TIPEVE').Value := CorrigeDadosBanco(ARegistro.strTipEve);
  LConsulta.ParamByName('DTATRA').Value := CorrigeDadosBanco(ARegistro.strDtaTra, True);
  LConsulta.ParamByName('CODAUT').Value := ACodAut;
  LConsulta.ParamByName('NUMPAR').Value := CorrigeDadosBanco(ARegistro.strNumPar);
  LConsulta.ParamByName('NUMNSU').Value := ANumnsu;

  LConsulta.Open;
  If Not LConsulta.IsEmpty Then
     Result  := true
end;

procedure TPagSeguroAPIPgto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    LDados: IDataSet;
    LSQL: String;
    LContador: Integer;
    LRegistro: TPagSeguroRegistroPgto;
begin
  LSQL := RetornaSQLReplace('PAG_APPGTO',
                             RetornaListaDeCampos(fRetEstruturaPgto('PAG_APPGTO')),
                             ['PAG_CONCIL']);

  LDados := objFunctions.fGetDataSet;
  LDados.Close;
  LDados.SQL := LSQL;

  pgbProg.Position := 0;

  pgbProg.Max := FPagSeguroRegistrosPgto.Count;

  For LRegistro In FPagSeguroRegistrosPgto Do
  Begin
    FImportouRegistro := True;

    LDados.Close;

    If ImportaRegistro(LRegistro) Then
    Begin
      Application.ProcessMessages;

      If MatchStr(LRegistro.strTipReg, ['PG', 'AP', 'AJ', 'TF']) Then
        FImportouPagamento := True;

      LDados.ParamByName(INICAM + 'TIPREG').Value   := CorrigeDadosBanco(LRegistro.strTipReg);
      LDados.ParamByName(INICAM + 'CODEST').Value   := CorrigeDadosBanco(LRegistro.strCodEst);
      LDados.ParamByName(INICAM + 'TIPEVE').Value   := CorrigeDadosBanco(LRegistro.strTipEve);
      LDados.ParamByName(INICAM + 'NUM_CV').Value   := CorrigeDadosBanco(LRegistro.strCod_CV);
      LDados.ParamByName(INICAM + 'DTATRA').Value   := CorrigeDadosBanco(LRegistro.strDtaTra, True);
      LDados.ParamByName(INICAM + 'DTAPAG').Value   := CorrigeDadosBanco(LRegistro.strDtaPag, True);
      LDados.ParamByName(INICAM + 'DTAAJU').Value   := CorrigeDadosBanco(LRegistro.strDtaAju, True);
      LDados.ParamByName(INICAM + 'TIPTRA').Value   := CorrigeDadosBanco(LRegistro.strTipTra);
      LDados.ParamByName(INICAM + 'TOTPAR').Value   := CorrigeDadosBanco(LRegistro.strTotPar);
      LDados.ParamByName(INICAM + 'NUMPAR').Value   := CorrigeDadosBanco(LRegistro.strNumPar);
      LDados.ParamByName(INICAM + 'VALPAR').Value   := CorrigeDadosBanco(LRegistro.fltValPar);
      LDados.ParamByName(INICAM + 'CODAUT').Value   := CorrigeDadosBanco(LRegistro.strCodAut);
      LDados.ParamByName(INICAM + 'NUMNSU').Value   := CorrigeDadosBanco(LRegistro.strNumNSU);

      If (Not MatchStr(CorrigeDadosBanco(LRegistro.strMeiPag), ['03', '08', '11'])) Then
      Begin
        If (LRegistro.strCodAut = '') Then
          LDados.ParamByName(INICAM + 'CODAUT').Value   := LeftStr(LRegistro.strCodVen, 6);

        If LRegistro.strNumNsu = '' Then
        Begin
          If (LRegistro.strTipTra <> '09') And (LRegistro.strCodVen <> '') Then
            LDados.ParamByName(INICAM + 'NUMNSU').Value   := LeftStr(LRegistro.strCodVen, 11)
          Else
            LDados.ParamByName(INICAM + 'NUMNSU').Value   := LeftStr(LRegistro.strCodTra, 11);
        End;

        If fEmptyStr(LDados.ParamByName(INICAM + 'CODAUT').AsString) Then
          LDados.ParamByName(INICAM + 'CODAUT').AsString := LDados.ParamByName(INICAM + 'NUMNSU').AsString;
      End
      Else If LRegistro.strMeiPag = '11' Then
      Begin
        LDados.ParamByName(INICAM + 'CODAUT').Value := RightStr(CorrigeDadosBanco(LRegistro.strCodTra), 6);
        LDados.ParamByName(INICAM + 'NUMNSU').Value := RightStr(CorrigeDadosBanco(LRegistro.strCodTra), 11);
      End;

      If LDados.ParamByName(INICAM + 'NUMNSU').AsString = '' Then
        Continue;

      If MatchStr(LRegistro.strTipReg, ['TF']) Then
      Begin
         If fVerificaRegistro_TF_JaConciliado(LRegistro,
                                              LeftStr(LDados.ParamByName(INICAM + 'NUMNSU').Value,12),
                                              LeftStr(LDados.ParamByName(INICAM + 'CODAUT').Value,6)) Then
            Continue;
      End;

      LDados.ParamByName(INICAM + 'NUMCAR').Value   := CorrigeDadosBanco(LRegistro.strNumCar);
      LDados.ParamByName(INICAM + 'CODTRA').Value   := CorrigeDadosBanco(LRegistro.strCodTra);
      LDados.ParamByName(INICAM + 'CODVEN').Value   := CorrigeDadosBanco(LRegistro.strCodVen);
      LDados.ParamByName(INICAM + 'VALBRU').Value   := CorrigeDadosBanco(LRegistro.fltValBru);
      LDados.ParamByName(INICAM + 'VALLIQ').Value   := CorrigeDadosBanco(LRegistro.fltValLiq);
      LDados.ParamByName(INICAM + 'LIQANT').Value   := CorrigeDadosBanco(LRegistro.fltLiqAnt);
      LDados.ParamByName(INICAM + 'TAXANT').Value   := CorrigeDadosBanco(LRegistro.fltTaxAnt);
      LDados.ParamByName(INICAM + 'STAPAG').Value   := CorrigeDadosBanco(LRegistro.strStaPag);
      LDados.ParamByName(INICAM + 'MEIPAG').Value   := CorrigeDadosBanco(LRegistro.strMeiPag);
      LDados.ParamByName(INICAM + 'NOMARQ').Value   := CorrigeDadosBanco(LRegistro.strNomArq);
      LDados.ParamByName(INICAM + 'DTAARQ').Value   := CorrigeDadosBanco(LRegistro.strDtaArq, True);

      LDados.ParamByName(INICAM + 'PAGPRA').Value   := CorrigeDadosBanco(LRegistro.PagamentoAPrazo);
      LDados.ParamByName(INICAM + 'CANENT').Value   := CorrigeDadosBanco(LRegistro.CanalDeEntrada);
      LDados.ParamByName(INICAM + 'MEICAP').Value   := CorrigeDadosBanco(LRegistro.MeioDeCaptura);

      LDados.ParamByName(INICAM + 'TAXINT').Value   := CorrigeDadosBanco(LRegistro.TaxaIntermediacao);
      LDados.ParamByName(INICAM + 'TAXPAR').Value   := CorrigeDadosBanco(LRegistro.TaxaParcelamento);

      If LDados.ParamByName(INICAM + 'PLANO_') <> Nil Then
        LDados.ParamByName(INICAM + 'PLANO_').Value := CorrigeDadosBanco(LRegistro.Plano);

      LDados.ExecSQL;

      pgbProg.Position := pgbProg.Position + 1;
      Application.ProcessMessages;
    End;

  End;


  Try
    LDados.Close;
    LDados.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "PagSeguroAPI")';
    For LContador := 0 To lstEstabel.Count - 1 Do
    Begin
      LDados.ParamByName('ESTAB').AsString := lstEstabel[LContador];
      LDados.ExecSQL;
    End;
  Except
    Raise Exception.Create('A tabela ESTCAR não foi criada. Entre em contato com a Citel!');
  End;
end;

function TPagSeguroAPIPgto.RetornaListaDeCampos(
  AObjetoCampos: TArrEstruturaPagSeguroAPIPgto): TStringList;
  Var
    LContador: Integer;
begin
  Result := TStringList.Create;

  For LContador := 0 To Length(AObjetoCampos) - 1 Do
    Result.Add(AObjetoCampos[LContador].strDescri);
end;

function TPagSeguroAPIPgto.RetornaNomeArquivo(
  LRegistro: TPagSeguroRegistroPgto): String;
begin
  Result := 'PAGSEG_[ESTABELECIMENTO]_[EXTRATO]_[DATAEVENTO]_[DATAPROCESSAMENTO]_3.00';
  Result := Result.Replace('[ESTABELECIMENTO]',LRegistro.strCodEst);
  Result := Result.Replace('[EXTRATO]',IIF(LRegistro.strTipReg.Equals('AP'),'ANT','FIN'));
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
