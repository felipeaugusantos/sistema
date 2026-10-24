unit untTImportaVendasRedeCardOnline;

interface

uses  System.SysUtils, System.Classes, System.StrUtils, System.Json, Vcl.Forms,
      System.Generics.Collections, System.DateUtils, WinAPI.Windows,
      System.NetEncoding, System.Variants, Data.DB, Vcl.StdCtrls,

      Uni, IdCoder, IdCoder3to4, IdCoderMIME, idHTTP, IdBaseComponent,
      IdComponent, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
      IdSSLOpenSSL, idAntiFreeze, cxProgressBar,

      untLibCartoesGravando, untTRedeCardFuncoes;

Type
  TVendasPagamento = Class
    CodigoBandeira,
    CodigoEstabelecimento,
    Flex,
    NumeroCartao,
    CodigoProduto,
    CodigoModalidade,
    Parcela,
    ResumoVenda,
    Tokenizado,
    TotalParcelas,
    Status,
    DataVenda,
    Autorizacao,
    DataVencimento,
    NomeBandeira,
    NSU,
    ModalidadeProduto,
    Modalidade,
    AlteracaoDeValor,
    HashVenda,
    IDPagamento: String;

    TaxaFlex,
    ValorFlex,
    ValorMDR,
    ValorMDROriginal,
    TaxaMDR,
    ValorFlexOriginal,
    QuantiaValorFlex,
    ValorTaxa,
    ValorBruto,
    ValorBrutoOriginal,
    ValorDesconto,
    ValorDescontoOriginal,
    ValorLiquido,
    ValorLiquidoOriginal,
    ValorVenda: Double;
  end;

  TCashbackInfo = class
    IDPagamento: String;
    Estabelecimento: String;
    ValorLiquido: Double;
    TipoAjuste: Integer;
  end;

Type
  TDadosToken = class
  private
    Access_Token : String;
    Expiracao: Integer;
    RefreshTime: TTime;
    Exception : String;
    function GetAccessToken: String;
  Public
    Property AccessToken : String  Read GetAccessToken  Write Access_Token;
  end;

Type
  TImportaVendasRedeCardOnline = class(TObject)
  private
    LDadosToken: TDadosToken;
    FProtocoloSSL: TIdSSLIOHandlerSocketOpenSSL;
    LRequisicao: TidHTTP;
    LPgtoSemVenda: TUniQuery;
    LListaVendasPagamento: TObjectList<TVendasPagamento>;
    LListaCashbacks: TObjectList<TCashbackInfo>;
    LCamposTabelaVenda: String;
    LParametrosTabelaVenda: String;
    FPagina: Integer;

    FDataInicial,
    FDataFinal: TDateTime;
    FEstabelecimento: String;
    FEstabelecimentoPagamento: String;

    procedure GerarToken;
    procedure CriarProtocoloSSL;
    procedure OnWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    function RetornaChaveBasic(AClientID, AClientSecret: String): String;
    procedure CriarComponenteRequisicao;
    function CriaQueryPagamentosSemVenda: TUniQuery;
    function ImportaVendasPagamento(pgbProgresso: TcxProgressBar): Boolean;
    function GravaVendasPagamento(pgbProgresso: TcxProgressBar): Boolean;
    function RetornaLinkConsultaVendaID(AEstabelecimento,AIdPamento,ANextKey:String; var AProgresso: TcxProgressBar): String;
    function RetiraZerosEsquerda(AString: String): String;
    function RetornaValorJson(AObjeto: TJsonObject; ANomeCampo: String; ADouble: Boolean = False): Variant;
    procedure ImportandoVendasDoPagamento;
    function AjusteVendaJaConciliado(AVenda: TVendasPagamento): Boolean;
    procedure GravandoVendasImportadas;
    procedure StepStatus(pgbStatus: TcxProgressBar);
    function CorrigeDadosBanco(AValor: Variant): Variant;
    procedure CarregaEstruturaTabelaVenda;
    function EmpresaPossuiCredenciaisDeAutenticacao:Boolean;
    procedure ReimportarVendas;
    function RetornaTotalLiquidoVendas: Double;
    function RetornaTotalLiquidoPagamento: Double;
    procedure ApagarVendasImportadas;
    function ConsultarVenda(AEstabelecimentoVenda, AIdVenda, ANextKey: String; var AProgresso: TcxProgressBar): String;

    //cashback
    procedure ConsultarCashbacks;
    function ConsultarCashbackPagamento(AEstabelecimento, AIdPagamento: String): String;
    procedure ProcessarRespostaCashback(AEstabelecimento, AIdPagamento, AResposta: String);
    procedure GravarCashbacks;
    function RetornaPagamentosQuePodemTerCashBack: TUniQuery;
    procedure ImportaCashBackPagamentos;
  public
    constructor Create(ADataInicial,ADataFinal: TDateTime; AEstabelecimento: String);
    Destructor Destroy; Override;
    procedure ImportacaoDasVendasFaltantes;
  End;

implementation

{ TImportaVendasRedeCardOnline }

function TImportaVendasRedeCardOnline.AjusteVendaJaConciliado(
  AVenda: TVendasPagamento): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Result := False;
  LConsulta := Nil;
  Try
    Try
      LConsulta := VS_FuncoesExternas.fICriaQuery;
      LConsulta.SQL.Text := 'SELECT                          '+
                            '  RED_CONCIL                    '+
                            'FROM                            '+
                            '  RED_APVPGO                    '+
                            'WHERE RED_NUM_PV = :NUM_PV      '+
                            '  AND RED_DTAVEN = :DTAVEN      '+
                            '  AND RED_CODAUT = :CODAUT      '+
                            '  AND RED_NUMNSU = :NUMNSU      '+
                            '  AND RED_NUM_RV = :NUM_RV      '+
                            '  AND RED_NUMPAR = :NUMPAR      '+
                            '  AND RED_STATUS  IN ("UNBOOK") ';

      LConsulta.ParamByName('NUM_PV').Value := CorrigeDadosBanco(AVenda.CodigoEstabelecimento);
      LConsulta.ParamByName('DTAVEN').Value := CorrigeDadosBanco(AVenda.DataVenda);
      LConsulta.ParamByName('CODAUT').Value := CorrigeDadosBanco(AVenda.Autorizacao);
      LConsulta.ParamByName('NUMNSU').Value := CorrigeDadosBanco(AVenda.NSU);
      LConsulta.ParamByName('NUM_RV').Value := CorrigeDadosBanco(AVenda.ResumoVenda);
      LConsulta.ParamByName('NUMPAR').Value := CorrigeDadosBanco(AVenda.Parcela);

      LConsulta.Open;

      If (LConsulta.FieldByName('RED_CONCIL').AsInteger = 1) Then
        Result := True;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(Concat(E.Message,' [TImportaVendasRedeCardOnline.AjusteVendaJaConciliado'));
      End;
    End;

  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

procedure TImportaVendasRedeCardOnline.ApagarVendasImportadas;
  Var
    LVendas : TUniQuery;
    LSql : String;
begin
  LVendas := Nil;
  Try
    LVendas := VS_FuncoesExternas.fICriaQuery;

    LSql := 'DELETE                            '+
            '  [TABELA]                        '+
            'FROM                              '+
            '  [TABELA]                        '+
            '  LEFT JOIN CFGSIS                                                                   '+
            '    ON LOCATE(TRIM(LEADING 0 FROM RED_NUM_PV), TRIM(LEADING 0 FROM SIS_VALCFG)) > 0  '+
            '    AND SIS_CODCFG IN ("CFG_REDEST", "CFG_REDECO")                                   '+
            '  LEFT JOIN CADEMP                                   '+
            '    ON SIS_CODEMP = EMP_CODEMP                       '+
            'WHERE RED_VEN_RV BETWEEN :DTAINI  '+
            '  AND :DTAFIM                     ';

    If Not TRedeCardFuncoes.fEmptyStr(FEstabelecimento) then
      LSql := LSql + FEstabelecimento;

    LVendas.Close;
    LVendas.Sql.Clear;
    LVendas.Sql.Text :=  StringReplace(LSql, '[TABELA]', 'RED_APVPAR', [rfReplaceAll]);
    LVendas.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', FDataInicial);
    LVendas.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', FDataFinal);
    LVendas.ExecSQL;

    LSql := LSql + ' AND RED_STATUS NOT IN ("UNBOOK") ';

    LVendas.Close;
    LVendas.Sql.Clear;
    LVendas.Sql.Text :=  StringReplace(LSql, '[TABELA]', 'RED_APVPGO', [rfReplaceAll]);
    LVendas.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', FDataInicial);
    LVendas.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', FDataFinal);
    LVendas.ExecSQL;

  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(LVendas);
  End;
end;

procedure TImportaVendasRedeCardOnline.CarregaEstruturaTabelaVenda;
  Var
    LConsulta : TUniQuery;
    LCampo: TField;
begin
  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Clear;
    LConsulta.SQL.Add('SELECT * FROM RED_APVPGO WHERE FALSE');
    LConsulta.Open;


    LCamposTabelaVenda := '';
    LParametrosTabelaVenda := '';

    For LCampo In LConsulta.Fields Do
    Begin
      LCamposTabelaVenda     := LCamposTabelaVenda + LCampo.FieldName + ',';
      LParametrosTabelaVenda := LParametrosTabelaVenda + ':' + LCampo.FieldName + ',';
    End;

    LCamposTabelaVenda     := LeftStr(LCamposTabelaVenda, LCamposTabelaVenda.Length - 1);
    LParametrosTabelaVenda := LeftStr(LParametrosTabelaVenda, LParametrosTabelaVenda.Length - 1);
  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

function TImportaVendasRedeCardOnline.CorrigeDadosBanco(AValor: Variant): Variant;
begin
  Result := Null;
  If Not TRedeCardFuncoes.fEmptyStr(AValor) Then
  Begin
    Result := AValor;
  End;
end;

constructor TImportaVendasRedeCardOnline.Create(ADataInicial,ADataFinal: TDateTime; AEstabelecimento: String);
begin
  FDataInicial     := ADataInicial;
  FDataFinal       := ADataFinal;
  FEstabelecimento := AEstabelecimento;

  CriarProtocoloSSL;
  CriarComponenteRequisicao;
  LListaVendasPagamento := TObjectList<TVendasPagamento>.Create;
  LListaCashbacks := TObjectList<TCashbackInfo>.Create(True);
  LPgtoSemVenda := CriaQueryPagamentosSemVenda;
  FPagina := 1;
  FEstabelecimentoPagamento := VS_FuncoesExternas.fICfgSis('REDPAG');
end;

function TImportaVendasRedeCardOnline.CriaQueryPagamentosSemVenda: TUniQuery;
begin

  ReimportarVendas;

  Try
    Result := VS_FuncoesExternas.fICriaQuery;
    Result.Close;
    Result.Sql.Clear;

    Result.Sql.Text := 'SELECT                                   '+
                       '  *                                      '+
                       'FROM                                     '+
                       '  RED_APPGTO PG                          '+
                       '  LEFT JOIN RED_APVPAR VP                '+
                       '    ON VP.RED_NUM_PV = PG.RED_NUM_PV     '+
                       '    AND VP.RED_NUM_RV = PG.RED_NUM_RV    '+
                       '    AND VP.RED_VEN_RV = PG.RED_DTAPAG    '+
                       '  LEFT JOIN RED_APVPGO VPGO              '+
                       '    ON VPGO.RED_NUM_PV = PG.RED_NUM_PV   '+
                       '    AND VPGO.RED_NUM_RV = PG.RED_NUM_RV  '+
                       '    AND VPGO.RED_VEN_RV = PG.RED_DTAPAG  '+
                       '  LEFT JOIN CFGSIS                                                                      '+
                       '    ON LOCATE(TRIM(LEADING 0 FROM PG.RED_NUM_PV), TRIM(LEADING 0 FROM SIS_VALCFG)) > 0  '+
                       '    AND SIS_CODCFG IN ("CFG_REDEST", "CFG_REDECO")                                      '+
                       '  LEFT JOIN CADEMP                                   '+
                       '    ON SIS_CODEMP = EMP_CODEMP                       '+
                       'WHERE PG.RED_DTAPAG BETWEEN :DTAINI      '+
                       '  AND :DTAFIM                            ';

    If Not TRedeCardFuncoes.fEmptyStr(FEstabelecimento) then
      Result.Sql.Text :=  Result.Sql.Text + StringReplace(FEstabelecimento,'RED_NUM_PV','PG.RED_NUM_PV',[rfReplaceAll]);

     Result.Sql.Text :=  Result.Sql.Text +
                       '  AND VP.RED_NUM_RV IS NULL              '+
                       '  AND VPGO.RED_NUM_RV IS NULL            '+
                       '  GROUP BY PG.RED_PAG_ID                 ';

    Result.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', FDataInicial);
    Result.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', FDataFinal);
    Result.Open;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(Concat(E.Message,' [TImportaVendasRedeCardOnline.CriaQueryPagamentosSemVenda'));
    End;
  End;
end;

procedure TImportaVendasRedeCardOnline.CriarComponenteRequisicao;
begin
  LRequisicao := TIdHTTP.Create(Nil);
  LRequisicao.IOHandler := FProtocoloSSL;
  LRequisicao.Request.Connection := 'keep-alive';
  LRequisicao.Request.ContentType := 'application/json';
  LRequisicao.Response.KeepAlive := True;
  LRequisicao.HTTPOptions := [];
  LRequisicao.OnWork := OnWork;
end;

procedure TImportaVendasRedeCardOnline.CriarProtocoloSSL;
begin
  FProtocoloSSL := TIdSSLIOHandlerSocketOpenSSL.Create(Application);
  FProtocoloSSL.SSLOptions.Mode := sslmUnassigned;
  FProtocoloSSL.SSLOptions.Method := sslvTLSv1_2;
  FProtocoloSSL.SSLOptions.SSLVersions := [sslvTLSv1_2];
end;

destructor TImportaVendasRedeCardOnline.Destroy;
begin
  FreeAndNil(LRequisicao);
  FreeAndNil(FProtocoloSSL);
  FreeAndNil(LListaVendasPagamento);
  FreeAndNil(LListaCashbacks);
  If Assigned(LDadosToken) Then
    FreeAndNil(LDadosToken);
  If Assigned(LPgtoSemVenda) Then
    FreeAndNil(LPgtoSemVenda);

  inherited;
end;

function TImportaVendasRedeCardOnline.EmpresaPossuiCredenciaisDeAutenticacao: Boolean;
begin
  Result := True;
  If TRedeCardFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis('REDUSU')) Then
    Result := False
  Else If TRedeCardFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis('REDSEN')) Then
    Result := False
  Else If TRedeCardFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis('REDCLI')) Then
    Result := False
  Else If TRedeCardFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis('REDSEC')) Then
    Result := False;
end;

procedure TImportaVendasRedeCardOnline.GerarToken;
  Var
    LRequisicao: TidHTTP;
    LParametros: TStringList;
    LResposta: String;
    LJsonObject: TJSONObject;
begin

  If Assigned(LDadosToken) Then
  Begin
    If (LDadosToken.RefreshTime >= TRedeCardFuncoes.fNow) And TRedeCardFuncoes.fEmptyStr(LDadosToken.Exception) Then
    Begin
      Exit;
    End;
    FreeAndNil(LDadosToken);
  End;

  Try
    Try
      LDadosToken := TDadosToken.Create;
      LParametros := TStringList.Create;
      LParametros.Add('grant_type=password');

      LParametros.Add('username=' + VS_FuncoesExternas.fICfgSis('REDUSU'));
      LParametros.Add('password=' + VS_FuncoesExternas.fICfgSis('REDSEN'));

      LRequisicao := TIdHTTP.Create(Nil);
      LRequisicao.OnWork := OnWork;
      LRequisicao.IOHandler := FProtocoloSSL;
      LRequisicao.Request.ContentType := 'application/x-www-form-urlencoded';

      LRequisicao.Request.CustomHeaders.Add('Authorization: ' + RetornaChaveBasic(VS_FuncoesExternas.fICfgSis('REDCLI'),VS_FuncoesExternas.fICfgSis('REDSEC')));

      Application.ProcessMessages;

      LResposta := LRequisicao.Post('https://api.userede.com.br/redelabs/oauth/token', LParametros);

      LJsonObject := TJSONObject.ParseJSONValue(LResposta) as TJSONObject;
      LDadosToken.Access_Token := LJsonObject.GetValue<String>('access_token');
      LDadosToken.Expiracao    := LJsonObject.GetValue<Integer>('expires_in');
      LDadosToken.RefreshTime  := IncSecond(TRedeCardFuncoes.fNow, LJsonObject.GetValue<Integer>('expires_in'));

      LDadosToken.RefreshTime  := IncMinute(LDadosToken.RefreshTime,-2);
    Finally
      If Assigned(LParametros) Then
        FreeAndNil(LRequisicao);

      If Assigned(LParametros) Then
        FreeAndNil(LParametros);

      If Assigned(LJsonObject) Then
        FreeAndNil(LJsonObject);
    End;
  Except

    On E:EIdHTTPProtocolException Do
    Begin
      LDadosToken.Exception :=  'Ocorreu um erro ao realizar a autenticação no servidor da RedeCard.' + #13 +
                                'Verifique se as chaves de autenticação da conta estão liberadas para utilização no ambiente de ' +
                                'PRODUÇÃO. Erro:' + E.ErrorMessage;
    End;

    On E: Exception Do
    Begin
      LDadosToken.Exception := 'Ocorreu um erro ao realizar a autenticação no servidor da RedeCard.' + #13 +
                               'Verifique se as chaves de autenticação da conta estão liberadas para utilização no ambiente de ' +
                               'PRODUÇÃO. Erro:' + E.Message;
    End;

  End;
end;

procedure TImportaVendasRedeCardOnline.GravandoVendasImportadas;
begin
  TRedeCardFuncoes.ExecutaAguarde(GravaVendasPagamento, 'Aguarde... Gravando Vendas Importadas.');
end;

function TImportaVendasRedeCardOnline.GravaVendasPagamento(pgbProgresso: TcxProgressBar): Boolean;
  Var
    LGravaVendasPagamento : TUniQuery;
    LVenda: TVendasPagamento;
begin
  Result := True;

  If (LListaVendasPagamento.Count = 0) Then
    Exit(False);

  LGravaVendasPagamento := VS_FuncoesExternas.fICriaQuery;
  Try
    Try
      CarregaEstruturaTabelaVenda;
      LGravaVendasPagamento.Close;
      LGravaVendasPagamento.SQL.Clear;
      LGravaVendasPagamento.SQL.Text := 'REPLACE INTO RED_APVPGO (' + LCamposTabelaVenda + ') ' +
                                        ' VALUES (' + LParametrosTabelaVenda + ') ';

      pgbProgresso.Position := 0;
      pgbProgresso.Properties.Max := LListaVendasPagamento.Count;
      VS_FuncoesExternas.fIStartTransaction;
      For LVenda In LListaVendasPagamento Do
      Begin
        If LVenda.Status.Equals('UNBOOK') Then
        Begin
          If AjusteVendaJaConciliado(LVenda) Then
           Continue;
        End;

        LGravaVendasPagamento.Close;

        LGravaVendasPagamento.ParamByName('RED_NUM_PV').Value := CorrigeDadosBanco(LVenda.CodigoEstabelecimento);
        LGravaVendasPagamento.ParamByName('RED_CODBAN').Value := CorrigeDadosBanco(LVenda.CodigoBandeira);
        LGravaVendasPagamento.ParamByName('RED_VALTAX').Value := CorrigeDadosBanco(LVenda.ValorTaxa);
        LGravaVendasPagamento.ParamByName('RED_VALMDR').Value := CorrigeDadosBanco(LVenda.ValorMDR);
        LGravaVendasPagamento.ParamByName('RED_STATUS').Value := CorrigeDadosBanco(LVenda.Status);
        LGravaVendasPagamento.ParamByName('RED_DTAVEN').Value := CorrigeDadosBanco(LVenda.DataVenda);
        LGravaVendasPagamento.ParamByName('RED_TAXFLE').Value := CorrigeDadosBanco(LVenda.TaxaFlex);
        LGravaVendasPagamento.ParamByName('RED_CODAUT').Value := CorrigeDadosBanco(LVenda.Autorizacao);
        LGravaVendasPagamento.ParamByName('RED_DESBAN').Value := CorrigeDadosBanco(LVenda.NomeBandeira);
        LGravaVendasPagamento.ParamByName('RED_TOKENI').Value := CorrigeDadosBanco(LVenda.Tokenizado);
        LGravaVendasPagamento.ParamByName('RED_VALFLE').Value := CorrigeDadosBanco(LVenda.ValorFlex);
        LGravaVendasPagamento.ParamByName('RED_VEN_RV').Value := CorrigeDadosBanco(LVenda.DataVencimento);
        LGravaVendasPagamento.ParamByName('RED_BRU_RO').Value := CorrigeDadosBanco(LVenda.ValorVenda);
        LGravaVendasPagamento.ParamByName('RED_NUMNSU').Value := CorrigeDadosBanco(LVenda.NSU);
        LGravaVendasPagamento.ParamByName('RED_TAXMDR').Value := CorrigeDadosBanco(LVenda.TaxaMDR);
        LGravaVendasPagamento.ParamByName('RED_NUMCAR').Value := CorrigeDadosBanco(LVenda.NumeroCartao);
        LGravaVendasPagamento.ParamByName('RED_TOTPAR').Value := CorrigeDadosBanco(LVenda.TotalParcelas);
        LGravaVendasPagamento.ParamByName('RED_CODPRO').Value := CorrigeDadosBanco(LVenda.CodigoProduto);
        LGravaVendasPagamento.ParamByName('RED_TIPREG').Value := CorrigeDadosBanco(LVenda.Modalidade);
        LGravaVendasPagamento.ParamByName('RED_VALBRU').Value := CorrigeDadosBanco(LVenda.ValorBruto);
        LGravaVendasPagamento.ParamByName('RED_BRUPAR').Value := CorrigeDadosBanco(LVenda.ValorBrutoOriginal);
        LGravaVendasPagamento.ParamByName('RED_VALDES').Value := CorrigeDadosBanco(LVenda.ValorDesconto);
        LGravaVendasPagamento.ParamByName('RED_DESPAR').Value := CorrigeDadosBanco(LVenda.ValorDescontoOriginal);
        LGravaVendasPagamento.ParamByName('RED_VALLIQ').Value := CorrigeDadosBanco(LVenda.ValorLiquido);
        LGravaVendasPagamento.ParamByName('RED_LIQPAR').Value := CorrigeDadosBanco(LVenda.ValorLiquidoOriginal);
        LGravaVendasPagamento.ParamByName('RED_MDRPAR').Value := CorrigeDadosBanco(LVenda.ValorMDROriginal);
        LGravaVendasPagamento.ParamByName('RED_VDHASH').Value := CorrigeDadosBanco(LVenda.HashVenda);
        LGravaVendasPagamento.ParamByName('RED_ALTVLR').Value := CorrigeDadosBanco(LVenda.AlteracaoDeValor);
        LGravaVendasPagamento.ParamByName('RED_NUM_RV').Value := CorrigeDadosBanco(LVenda.ResumoVenda);
        LGravaVendasPagamento.ParamByName('RED_VDFLEX').Value := CorrigeDadosBanco(LVenda.Flex);
        LGravaVendasPagamento.ParamByName('RED_CODMOD').Value := CorrigeDadosBanco(LVenda.CodigoModalidade);
        LGravaVendasPagamento.ParamByName('RED_NUMPAR').Value := CorrigeDadosBanco(LVenda.Parcela);
        LGravaVendasPagamento.ParamByName('RED_PAG_ID').Value := CorrigeDadosBanco(LVenda.IDPagamento);
        LGravaVendasPagamento.ParamByName('RED_CONCIL').Value := 0;

        LGravaVendasPagamento.ExecSQL;
        StepStatus(pgbProgresso);
      End;

      VS_FuncoesExternas.fICommit;
    Except
      On E: Exception Do
      Begin
        VS_FuncoesExternas.fIRollBack;
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LGravaVendasPagamento);
  End;
end;

procedure TImportaVendasRedeCardOnline.ImportandoVendasDoPagamento;
begin
  TRedeCardFuncoes.ExecutaAguarde(ImportaVendasPagamento, 'Aguarde... Importando Vendas.');
end;

function TImportaVendasRedeCardOnline.ConsultarVenda(AEstabelecimentoVenda, AIdVenda, ANextKey: String;
  var AProgresso: TcxProgressBar): String;
var
  LLinkConsulta: String;
begin
  LLinkConsulta := RetornaLinkConsultaVendaID(
    AEstabelecimentoVenda,
    AIdVenda,
    ANextKey,
    AProgresso);

  Result := LRequisicao.Get(LLinkConsulta);

  if not TRedeCardFuncoes.fEmptyStr(Result) then
    Exit;

  If FEstabelecimentoPagamento.Trim.IsEmpty Then
    Exit;

  LLinkConsulta := RetornaLinkConsultaVendaID(
    FEstabelecimentoPagamento,
    AIdVenda,
    ANextKey,
    AProgresso);

  Result := LRequisicao.Get(LLinkConsulta);
end;

function TImportaVendasRedeCardOnline.ImportaVendasPagamento(pgbProgresso: TcxProgressBar): Boolean;
  Var
    LRetornoGet  : String;
    LNextKey     : String;
    LJsonRetorno : TJSONObject;
    LJsonObjectValue,
    LJsonObjectGroup : TJsonObject;
    LJsonArray: TJSONArray;
    LJsonValue: TJsonValue;
    LVendasPagamento : TVendasPagamento;
begin
  If LPgtoSemVenda.IsEmpty Then
    Exit(False);

  Result := True;
  Try
    TRedeCardFuncoes.AguardeExecutarModalA(GerarToken,'Aguarde, Realizando Autenticação.', '');
    LRequisicao.Request.CustomHeaders.AddValue('authorization', 'Bearer ' + LDadosToken.AccessToken);
    LRequisicao.Request.CustomHeaders.AddValue('Content-Type', 'application/json');
    LRequisicao.Request.Method := 'GET';

    LPgtoSemVenda.First;
    pgbProgresso.Position := 0;
    pgbProgresso.Properties.Max := LPgtoSemVenda.RecordCount;

    Try
      While Not LPgtoSemVenda.Eof Do
      Begin
        LNextKey := '';
        Repeat
          LRetornoGet := ConsultarVenda(LPgtoSemVenda.FieldByName('RED_NUM_PV').AsString,
                                        LPgtoSemVenda.FieldByName('RED_PAG_ID').AsString,
                                        LNextKey,
                                        pgbProgresso);

          LNextKey := '';

          If TRedeCardFuncoes.fEmptyStr(LRetornoGet) Then
            Continue;

          LJsonRetorno := TJSONObject.ParseJSONValue(LRetornoGet) as TJSONObject;
          LJsonObjectValue := LJsonRetorno.GetValue<TJSONObject>('cursor') as TJSONObject;
          If LJsonObjectValue.GetValue<string>('hasNextKey') = 'true' Then
            LNextKey := LJsonObjectValue.GetValue<string>('nextKey');

          LJsonObjectValue := LJsonRetorno.GetValue<TJSONObject>('content') as TJSONObject;
          LJsonArray := LJsonObjectValue.GetValue('installments') as TJsonArray;

          For LJsonValue In LJsonArray Do
          Begin
            LJsonObjectValue := TJSONObject.ParseJSONValue(LJSonValue.ToString) as TJSONObject;
            LVendasPagamento := TVendasPagamento.Create;

            LVendasPagamento.IDPagamento           := LPgtoSemVenda.FieldByName('RED_PAG_ID').AsString;
            LVendasPagamento.CodigoBandeira        := RetornaValorJson(LJsonObjectValue, 'brandCode');
            LVendasPagamento.NumeroCartao          := RetornaValorJson(LJsonObjectValue, 'cardNumber');
            LVendasPagamento.CodigoEstabelecimento := RetornaValorJson(LJsonObjectValue, 'merchantId');
            LVendasPagamento.Flex                  := RetornaValorJson(LJsonObjectValue, 'flex');
            LVendasPagamento.ModalidadeProduto     := RetornaValorJson(LJsonObjectValue, 'modalityProductCode');
            LVendasPagamento.CodigoModalidade      := RetornaValorJson(LJsonObjectValue, 'modalityCode');
            LVendasPagamento.Parcela               := RetornaValorJson(LJsonObjectValue, 'installmentNumber');
            LVendasPagamento.ResumoVenda           := RetornaValorJson(LJsonObjectValue, 'rvNumber');
            LVendasPagamento.ValorMDR              := RetornaValorJson(LJsonObjectValue, 'mdrAmount', True);
            LVendasPagamento.TaxaMDR               := RetornaValorJson(LJsonObjectValue, 'mdrFee', True);
            LVendasPagamento.TaxaFlex              := RetornaValorJson(LJsonObjectValue, 'flexFee',True);
            LVendasPagamento.Tokenizado            := RetornaValorJson(LJsonObjectValue, 'tokenized');
            LVendasPagamento.TotalParcelas         := RetornaValorJson(LJsonObjectValue, 'installmentQuantity');
            LVendasPagamento.Status                := RetornaValorJson(LJsonObjectValue, 'status');
            LVendasPagamento.DataVenda             := RetornaValorJson(LJsonObjectValue, 'saleDate');
            LVendasPagamento.ValorFlexOriginal     := RetornaValorJson(LJsonObjectValue, 'originalFlexAmount',True);
            LVendasPagamento.ValorFlex             := RetornaValorJson(LJsonObjectValue, 'flexAmount',True);
            LVendasPagamento.Autorizacao           := RetornaValorJson(LJsonObjectValue, 'authorizationCode');
            LVendasPagamento.ValorTaxa             := RetornaValorJson(LJsonObjectValue, 'feeTotal',true);
            LVendasPagamento.DataVencimento        := RetornaValorJson(LJsonObjectValue, 'expirationDate');
            LVendasPagamento.NomeBandeira          := RetornaValorJson(LJsonObjectValue, 'brand');
            LVendasPagamento.ModalidadeProduto     := RetornaValorJson(LJsonObjectValue, 'modalityProduct');
            LVendasPagamento.Modalidade            := RetornaValorJson(LJsonObjectValue, 'modality');
            LVendasPagamento.ValorMDROriginal      := RetornaValorJson(LJsonObjectValue, 'originalMdrAmount',True);
            LVendasPagamento.ValorVenda            := RetornaValorJson(LJsonObjectValue, 'saleAmount', True);
            LVendasPagamento.HashVenda             := RetornaValorJson(LJsonObjectValue, 'hashUniqueSale');
            LVendasPagamento.NSU                   := RetornaValorJson(LJsonObjectValue, 'nsu');

            LJsonObjectGroup := LJsonObjectValue.GetValue('amountInfo') as TJSONObject;
            LVendasPagamento.ValorBruto             := RetornaValorJson(LJsonObjectGroup, 'amount',True);
            LVendasPagamento.ValorBrutoOriginal     := RetornaValorJson(LJsonObjectGroup, 'originalAmount',True);
            LVendasPagamento.ValorLiquido           := RetornaValorJson(LJsonObjectGroup, 'netAmount',True);
            LVendasPagamento.ValorLiquidoOriginal   := RetornaValorJson(LJsonObjectGroup, 'originalNetAmount',True);
            LVendasPagamento.ValorDesconto          := RetornaValorJson(LJsonObjectGroup, 'discountAmount',True);
            LVendasPagamento.ValorDescontoOriginal  := RetornaValorJson(LJsonObjectGroup, 'originalDiscountAmount',True);
            LVendasPagamento.AlteracaoDeValor       := RetornaValorJson(LJsonObjectGroup, 'valueChange');

            LVendasPagamento.CodigoEstabelecimento := LVendasPagamento.CodigoEstabelecimento.PadLeft(9, '0');

            LListaVendasPagamento.Add(LVendasPagamento);
            Application.ProcessMessages;

          End;


        Until LNextKey.IsEmpty;

        LPgtoSemVenda.Next;
        StepStatus(pgbProgresso);
      End;
    Finally
      If Assigned(LJsonRetorno) Then
        FreeAndNil(LJsonRetorno);

      If Assigned(LJsonObjectValue) Then
        FreeAndNil(LJsonObjectValue);
    End;
  Except

    On E:EIdHTTPProtocolException Do
    Begin
      Raise Exception.Create(E.ErrorMessage);
    End;

    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

end;

procedure TImportaVendasRedeCardOnline.ImportacaoDasVendasFaltantes;
begin
  If EmpresaPossuiCredenciaisDeAutenticacao Then
  Begin

    TRedeCardFuncoes.AguardeExecutarModalA(ImportaCashBackPagamentos,'Aguarde, Consultando Cashbacks.', '');

    If Not LPgtoSemVenda.IsEmpty  Then
    Begin
      ImportandoVendasDoPagamento;
      GravandoVendasImportadas;
    End;
  End;
end;

procedure TImportaVendasRedeCardOnline.ImportaCashBackPagamentos;
begin
  If TRedeCardFuncoes.fTabelaExiste('RED_CASHBK') Then
  Begin
    ConsultarCashbacks;
    GravarCashbacks;
  End;
end;

function TImportaVendasRedeCardOnline.RetornaValorJson(AObjeto: TJsonObject;
  ANomeCampo: String; ADouble: Boolean = False): Variant;
begin
  If ADouble Then
  Begin
    Result := 0;
    If AObjeto.GetValue(ANomeCampo) <> Nil Then
    begin
      if not AObjeto.GetValue(ANomeCampo).Null then
        Result := AObjeto.GetValue<double>(ANomeCampo);
    end;
  End Else
  Begin
    Result := '';
    If AObjeto.GetValue(ANomeCampo) <> Nil Then
      Result := AObjeto.GetValue<string>(ANomeCampo);
  End;
end;

procedure TImportaVendasRedeCardOnline.StepStatus(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

procedure TImportaVendasRedeCardOnline.OnWork(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  Application.ProcessMessages;
end;


procedure TImportaVendasRedeCardOnline.ReimportarVendas;
  Var
    LTotalLiquidoPagamentos : Double;
    LTotalLiquidoVendas : Double;
    LDiferenca: Double;
begin
  Try
    LTotalLiquidoPagamentos := RetornaTotalLiquidoPagamento;
    LTotalLiquidoVendas :=  RetornaTotalLiquidoVendas;

    LDiferenca := (LTotalLiquidoPagamentos - LTotalLiquidoVendas);
    If Not ((TRedeCardFuncoes.fFormataFloat(LDiferenca, 2) <= 0.01999) And (TRedeCardFuncoes.fFormataFloat(LDiferenca, 2) >= -0.01999))  Then
    Begin
      ApagarVendasImportadas;
    End;

  Except
    On E: Exception Do
    Begin
      Raise  Exception.Create(E.Message);
    End;
  End;
end;

function TImportaVendasRedeCardOnline.RetiraZerosEsquerda(AString: String): String;
begin
  While AString[1] = '0' do
    Delete(AString,1,1);

  Result := AString;
end;

function TImportaVendasRedeCardOnline.RetornaChaveBasic(AClientID,AClientSecret: String): String;
  Var
    LBase64: TBase64Encoding;
begin
  Result := '';

  If AClientID.IsEmpty Then
    Exit;

  If AClientSecret.IsEmpty Then
    Exit;

  Try
    LBase64 := TBase64Encoding.Create(0);

    Result := 'Basic ' + LBase64.Encode(AClientID + ':' + AClientSecret);
  Finally
    FreeAndNil(LBase64);
  End;

end;

function TImportaVendasRedeCardOnline.RetornaLinkConsultaVendaID(AEstabelecimento, AIdPamento,ANextKey: String; var AProgresso: TcxProgressBar): String;
begin
  Result := 'https://api.userede.com.br/redelabs/merchant-statement/v2/payments/installments/[ESTABELECIMENTO]/[ID_PAGAMENTO]?size=100' ;
  Result := StringReplace(Result, '[ESTABELECIMENTO]', RetiraZerosEsquerda(AEstabelecimento), [rfReplaceAll]);
  Result := StringReplace(Result, '[ID_PAGAMENTO]',AIdPamento, [rfReplaceAll]);

  If Not ANextKey.IsEmpty Then
  Begin
    Result := Result + '&pageKey=' + ANextKey;
    Inc(FPagina);
  End
  Else
    FPagina := 1;

  TLabel(AProgresso.Parent.FindComponent('lblGravando')).Caption := 'Aguarde... Importando Vendas (Página ' + FPagina.ToString + ')';
end;

function TImportaVendasRedeCardOnline.RetornaTotalLiquidoPagamento: Double;
  Var
    LPagamento : TUniQuery;
begin
  Try
    LPagamento := VS_FuncoesExternas.fICriaQuery;

    LPagamento.Close;
    LPagamento.Sql.Clear;
    LPagamento.Sql.Text := 'SELECT                                            '+
                           '   SUM(RED_VALBRU - RED_VALDES) AS TOTAL_LIQUIDO  '+
                           ' FROM                                             '+
                           '   RED_APPGTO                                     '+
                           '  LEFT JOIN CFGSIS                                                                   '+
                           '    ON LOCATE(TRIM(LEADING 0 FROM RED_NUM_PV), TRIM(LEADING 0 FROM SIS_VALCFG)) > 0  '+
                           '    AND SIS_CODCFG IN ("CFG_REDEST", "CFG_REDECO")                                   '+
                           '  LEFT JOIN CADEMP                                   '+
                           '    ON SIS_CODEMP = EMP_CODEMP                       '+
                           'WHERE RED_DTAPAG BETWEEN :DTAINI                  '+
                           '  AND :DTAFIM                                     ';

    If Not TRedeCardFuncoes.fEmptyStr(FEstabelecimento) then
      LPagamento.Sql.Text :=  LPagamento.Sql.Text + FEstabelecimento;

    LPagamento.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', FDataInicial);
    LPagamento.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', FDataFinal);
    LPagamento.Open;

    Result := TRedeCardFuncoes.fFormataFloat(LPagamento.FieldByName('TOTAL_LIQUIDO').AsFloat,2);

  Finally
    FreeAndNil(LPagamento);
  End;
end;

function TImportaVendasRedeCardOnline.RetornaTotalLiquidoVendas: Double;
  Var
    LVendas : TUniQuery;
begin
  Try
    LVendas := VS_FuncoesExternas.fICriaQuery;

    LVendas.Close;
    LVendas.Sql.Clear;
    LVendas.Sql.Text := 'SELECT                             '+
                        '  SUM(RED_LIQPAR) AS TOTAL_LIQUIDO '+
                        'FROM                               '+
                        '  (SELECT                          '+
                        '    VP.RED_VEN_RV,                 '+
                        '    VP.RED_NUM_PV,                 '+
                        '    VP.RED_NUM_RV,                 '+
                        '    VP.RED_NUMNSU,                 '+
                        '    VP.RED_NUMPAR,                 '+
                        '    VP.RED_LIQPAR                  '+
                        '  FROM                             '+
                        '    RED_APVPAR VP                  '+
                        '  INNER JOIN RED_APVEND V             '+
                        '    ON VP.RED_NUM_PV = V.RED_NUM_PV   '+
                        '    AND VP.RED_NUM_RV = V.RED_NUM_RV  '+
                        '    AND VP.RED_NUMNSU = V.RED_NUMNSU  '+
                        '    AND VP.RED_DTAVEN = V.RED_DTAVEN  '+
                        '  UNION                               '+
                        '  SELECT                           '+
                        '    RED_VEN_RV,                    '+
                        '    RED_NUM_PV,                    '+
                        '    RED_NUM_RV,                    '+
                        '    RED_NUMNSU,                    '+
                        '    RED_NUMPAR,                    '+
                        '    RED_VALLIQ AS RED_LIQPAR       '+
                        '  FROM                             '+
                        '   RED_APVPGO                      '+
                        'WHERE RED_STATUS IN ("PAID","ANTICIPATED","SCHEDULLED") '+
                        ' ) AS VENDA                        '+
                        '  LEFT JOIN CFGSIS                                                                   '+
                        '    ON LOCATE(TRIM(LEADING 0 FROM RED_NUM_PV), TRIM(LEADING 0 FROM SIS_VALCFG)) > 0  '+
                        '    AND SIS_CODCFG IN ("CFG_REDEST", "CFG_REDECO")                                   '+
                        '  LEFT JOIN CADEMP                                   '+
                        '    ON SIS_CODEMP = EMP_CODEMP                       '+
                        ' WHERE RED_VEN_RV BETWEEN :DTAINI  '+
                        '  AND :DTAFIM                      ';

    If Not TRedeCardFuncoes.fEmptyStr(FEstabelecimento) then
      LVendas.Sql.Text := LVendas.Sql.Text + FEstabelecimento;

    LVendas.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', FDataInicial);
    LVendas.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', FDataFinal);
    LVendas.Open;

    Result := TRedeCardFuncoes.fFormataFloat(LVendas.FieldByName('TOTAL_LIQUIDO').AsFloat,2);

  Finally
    FreeAndNil(LVendas);
  End;
end;

{ TDadosToken }

function TDadosToken.GetAccessToken: String;
begin
  If Not TRedeCardFuncoes.fEmptyStr(Self.Exception) Then
    Raise System.SysUtils.Exception.Create(Self.Exception)
  Else
    Result := Self.Access_Token;
end;


function TImportaVendasRedeCardOnline.RetornaPagamentosQuePodemTerCashBack: TUniQuery;
begin
  Result := Nil;
  Try
    Result := VS_FuncoesExternas.fICriaQuery;
    Result.Close;
    Result.Sql.Clear;

    Result.Sql.Text :=
      'SELECT                                                                                  ' +
      '  DISTINCT                                                                             ' +
      '  PG.RED_NUM_PV,                                                                       ' +
      '  PG.RED_PAG_ID                                                                        ' +
      'FROM                                                                                   ' +
      '  RED_APPGTO PG                                                                        ' +
      '  INNER JOIN CFGSIS CFG                                                                ' +
      '    ON LOCATE(TRIM(LEADING "0" FROM PG.RED_NUM_PV), TRIM(LEADING "0" FROM CFG.SIS_VALCFG)) > 0  ' +
      '    AND CFG.SIS_CODCFG IN ("CFG_REDEST", "CFG_REDECO")                                 ' +
      '  INNER JOIN CADEMP EMP                                                                ' +
      '    ON CFG.SIS_CODEMP = EMP.EMP_CODEMP                                                 ' +
      '  LEFT JOIN RED_CASHBK CB                                                              ' +
      '    ON CB.RED_PAG_ID = PG.RED_PAG_ID                                                   ' +
      '    AND CB.RED_NUM_PV = PG.RED_NUM_PV                                                  ' +
      'WHERE                                                                                  ' +
      '  PG.RED_DTAPAG BETWEEN :DTAINI                                                        ' +
      '  AND :DTAFIM                                                                          ' +
      '  AND PG.RED_VALDES = 0                                                                ' +
      '  AND PG.RED_PAG_ID IS NOT NULL                                                        ' +
      '  AND PG.RED_PAG_ID <> ""                                                              ' +
      '  AND CB.RED_PAG_ID IS NULL                                                            ' ;

    If Not TRedeCardFuncoes.fEmptyStr(FEstabelecimento) then
      Result.Sql.Text := Result.Sql.Text + StringReplace(FEstabelecimento, 'RED_NUM_PV', 'PG.RED_NUM_PV', [rfReplaceAll, rfIgnoreCase]);

    Result.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', FDataInicial);
    Result.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', FDataFinal);
    Result.Open;

  Except
    On E: Exception Do
    Begin
      TRedeCardFuncoes.FreeAndNilDatasets(Result);
      Raise Exception.Create(Concat(E.Message,' [TImportaVendasRedeCardOnline.ConsultarPagamentosSemDesconto'));
    End;
  End;
end;

procedure TImportaVendasRedeCardOnline.ConsultarCashbacks;
var
  LQuery: TUniQuery;
  LEstabelecimento, LIdPagamento: String;
  LResposta: String;
begin
  LListaCashbacks.Clear;

  LQuery := Nil;
  Try
    LQuery := RetornaPagamentosQuePodemTerCashBack;
    If LQuery.IsEmpty Then
      Exit;

    // Gera token se necessário
    TRedeCardFuncoes.AguardeExecutarModalA(GerarToken,'Aguarde, Realizando Autenticação.', '');

    LRequisicao.Request.CustomHeaders.Clear;
    LRequisicao.Request.CustomHeaders.AddValue('authorization', 'Bearer ' + LDadosToken.AccessToken);
    LRequisicao.Request.CustomHeaders.AddValue('Content-Type', 'application/json');
    LRequisicao.Request.Method := 'GET';

    LQuery.First;
    While Not LQuery.Eof Do
    Begin
      LEstabelecimento := LQuery.FieldByName('RED_NUM_PV').AsString;
      LIdPagamento := LQuery.FieldByName('RED_PAG_ID').AsString;

      LResposta := ConsultarCashbackPagamento(LEstabelecimento, LIdPagamento);

      If Not TRedeCardFuncoes.fEmptyStr(LResposta) Then
      Begin
        ProcessarRespostaCashback(LEstabelecimento, LIdPagamento, LResposta);
      End;

      LQuery.Next;
    End;
  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(LQuery);
  End;
end;

function TImportaVendasRedeCardOnline.ConsultarCashbackPagamento(AEstabelecimento, AIdPagamento: String): String;
  var
    LUrl: String;

  LJsonObject,
  LJsonCashback: TJSONObject;
  LJsonArray: TJSONArray;
begin
  Result := '';
  LJsonObject := Nil;
  Try
    AEstabelecimento := RetiraZerosEsquerda(AEstabelecimento);
    LURL := 'https://api.userede.com.br/redelabs/merchant-statement/v1/payments/cashbacks/' + AIdPagamento;
    LRequisicao.Request.CustomHeaders.Values['Merchant-Id'] := AEstabelecimento;

    Result := LRequisicao.Get(LURL);

    If Result.IsEmpty Then
    Begin
      LJsonObject := TJSONObject.Create;
      Try
        LJsonArray := TJSONArray.Create;
        LJsonCashback := TJSONObject.Create;
        LJsonCashback.AddPair('netAmount', TJSONNumber.Create(0.0));
        LJsonCashback.AddPair('adjustmentTypeCode', TJSONNumber.Create(0));
        LJsonArray.AddElement(LJsonCashback);
        LJsonObject.AddPair('cashbacks', LJsonArray);

        Result := LJsonObject.ToString;
      Finally
        TRedeCardFuncoes.FreeAndNilObjeto(LJsonObject);
      End;
    End;

  Except
    On E: EIdHTTPProtocolException Do
    Begin
      If E.ErrorCode <> 204 Then
        Raise Exception.Create('Erro ao consultar cashback para pagamento ' + AIdPagamento + ': ' + E.ErrorMessage);
    End;

    On E: Exception Do
    Begin
      Raise Exception.Create('Erro ao consultar cashback para pagamento ' + AIdPagamento + ': ' + E.Message);
    End;
  End;
end;

procedure TImportaVendasRedeCardOnline.ProcessarRespostaCashback(AEstabelecimento, AIdPagamento, AResposta: String);
var
  LJsonObject: TJSONObject;
  LJsonArray: TJSONArray;
  LJsonValue: TJSONValue;
  LJsonItem: TJSONObject;
  LCashback: TCashbackInfo;
begin
  LJsonObject := Nil;
  LJsonArray := Nil;
  LJsonItem := Nil;
  Try
    LJsonObject := TJSONObject.ParseJSONValue(AResposta) as TJSONObject;
    If Not Assigned(LJsonObject) Then
      Exit;

    If LJsonObject.GetValue('cashbacks') = Nil Then
      Exit;

    LJsonArray := TJSONObject.ParseJSONValue(LJsonObject.GetValue('cashbacks').ToJson) as TJSONArray;
    If Not Assigned(LJsonArray) Then
      Exit;

    For LJsonValue In LJsonArray Do
    Begin
      Try
        LJsonItem := TJSONObject.ParseJSONValue(LJsonValue.ToJSON) as TJSONObject;

        LCashback := TCashbackInfo.Create;
        LCashback.IDPagamento := AIdPagamento;
        LCashback.Estabelecimento := AEstabelecimento;
        LCashback.ValorLiquido := LJsonItem.GetValue<Double>('netAmount');
        LCashback.TipoAjuste := LJsonItem.GetValue<Integer>('adjustmentTypeCode');

        LListaCashbacks.Add(LCashback);
      Finally
        TRedeCardFuncoes.FreeAndNilObjeto(LJsonItem);
      End;
    End;

  Finally
    TRedeCardFuncoes.FreeAndNilObjeto(LJsonArray);
    TRedeCardFuncoes.FreeAndNilObjeto(LJsonObject);
  End;
end;

procedure TImportaVendasRedeCardOnline.GravarCashbacks;
var
  LQuery: TUniQuery;
  LCashback: TCashbackInfo;
begin
  If LListaCashbacks.Count = 0 Then
    Exit;

   LQuery := Nil;
  Try
    LQuery := VS_FuncoesExternas.fICriaQuery;
    Try
      VS_FuncoesExternas.fIStartTransaction;

      For LCashback In LListaCashbacks Do
      Begin
        LQuery.Close;
        LQuery.SQL.Clear;
        LQuery.SQL.Text := 'INSERT INTO RED_CASHBK (RED_NUM_PV, RED_PAG_ID, RED_VALLIQ, RED_TIPAJU) ' +
                           'VALUES (:RED_NUM_PV, :RED_PAG_ID, :RED_VALLIQ, :RED_TIPAJU) ' +
                           'ON DUPLICATE KEY UPDATE ' +
                           'RED_VALLIQ = VALUES(RED_VALLIQ), ' +
                           'RED_TIPAJU = VALUES(RED_TIPAJU)';

        LQuery.ParamByName('RED_NUM_PV').Value := LCashback.Estabelecimento;
        LQuery.ParamByName('RED_PAG_ID').Value := LCashback.IDPagamento;
        LQuery.ParamByName('RED_VALLIQ').Value := LCashback.ValorLiquido;
        LQuery.ParamByName('RED_TIPAJU').Value := LCashback.TipoAjuste;

        LQuery.ExecSQL;
      End;

      VS_FuncoesExternas.fICommit;

    Except
      On E: Exception Do
      Begin
        VS_FuncoesExternas.fIRollBack;
        Raise Exception.Create('Erro ao gravar cashbacks: ' + E.Message);
      End;
    End;
  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(LQuery);
  End;
end;

end.
