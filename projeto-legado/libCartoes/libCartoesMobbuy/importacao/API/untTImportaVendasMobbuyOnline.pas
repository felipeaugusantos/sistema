unit untTImportaVendasMobbuyOnline;

interface

uses  System.SysUtils, System.Classes, System.StrUtils, System.Json, Vcl.Forms,
      System.Generics.Collections, System.DateUtils, WinAPI.Windows,
      System.NetEncoding, System.Variants, Data.DB, Vcl.StdCtrls,

      Uni, IdCoder, IdCoder3to4, IdCoderMIME, idHTTP, IdBaseComponent,
      IdComponent, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
      IdSSLOpenSSL, //idAntiFreeze,
      cxProgressBar,

      untLibCartoesGravando, untTMobbuyFuncoes;

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


Type
  TDadosToken = class
  end;

Type
  TImportaVendasMobbuyOnline = class(TObject)
  private
    LDadosToken: TDadosToken;
    FProtocoloSSL: TIdSSLIOHandlerSocketOpenSSL;
    LRequisicao: TidHTTP;
    LPgtoSemVenda: TUniQuery;
    LListaVendasPagamento: TList<TVendasPagamento>;
    FPagina: Integer;

    FDataInicial,
    FDataFinal: TDateTime;
    FEstabelecimento: String;
    FEstabelecimentoPagamento: String;

    procedure CriarProtocoloSSL;
    procedure OnWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure CriarComponenteRequisicao;
    function CriaQueryPagamentosSemVenda: TUniQuery;
    procedure ReimportarVendas;
    function RetornaTotalLiquidoVendas: Double;
    function RetornaTotalLiquidoPagamento: Double;
    procedure ApagarVendasImportadas;
  public
    constructor Create(ADataInicial,ADataFinal: TDateTime; AEstabelecimento: String);
    Destructor Destroy; Override;
  End;

implementation

{ TImportaVendasRedeCardOnline }


procedure TImportaVendasMobbuyOnline.ApagarVendasImportadas;
  Var
    LVendas : TUniQuery;
    LSql : String;
begin

  Try
    LVendas := VS_FuncoesExternas.fICriaQuery;

    LSql := 'DELETE                            '+
            '  [TABELA]                        '+
            'FROM                              '+
            '  [TABELA]                        '+
            '  LEFT JOIN CFGSIS                                                                   '+
            '    ON LOCATE(TRIM(LEADING 0 FROM MOB_NUM_PV), TRIM(LEADING 0 FROM SIS_VALCFG)) > 0  '+
            '    AND SIS_CODCFG IN ("MOB_REDEST")                                   '+
            '  LEFT JOIN CADEMP                                   '+
            '    ON SIS_CODEMP = EMP_CODEMP                       '+
            'WHERE MOB_DTAVCT BETWEEN :DTAINI  '+
            '  AND :DTAFIM                     ';

    If Not TMobbuyFuncoes.fEmptyStr(FEstabelecimento) then
      LSql := LSql + FEstabelecimento;

    LVendas.Close;
    LVendas.Sql.Clear;
    LVendas.Sql.Text :=  StringReplace(LSql, '[TABELA]', 'MOB_APVPAR', [rfReplaceAll]);
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
    FreeAndNil(LVendas);
  End;
end;

constructor TImportaVendasMobbuyOnline.Create(ADataInicial,ADataFinal: TDateTime; AEstabelecimento: String);
begin
  FDataInicial     := ADataInicial;
  FDataFinal       := ADataFinal;
  FEstabelecimento := AEstabelecimento;

  CriarProtocoloSSL;
  CriarComponenteRequisicao;
  LListaVendasPagamento := TList<TVendasPagamento>.Create;
  LPgtoSemVenda := CriaQueryPagamentosSemVenda;
  FPagina := 1;
  FEstabelecimentoPagamento := VS_FuncoesExternas.fICfgSis('MOBPAG');
end;

function TImportaVendasMobbuyOnline.CriaQueryPagamentosSemVenda: TUniQuery;
begin

  ReimportarVendas;

  Try
    Result := VS_FuncoesExternas.fICriaQuery;
    Result.Close;
    Result.Sql.Clear;

    Result.Sql.Text := 'SELECT                                   '+
                       '  *                                      '+
                       'FROM                                     '+
                       '  MOB_APPGTO PG                          '+
                       '  LEFT JOIN MOB_APVPAR VP                '+
                       '    ON VP.MOB_NUM_PV = PG.MOB_NUM_PV     '+
                       '    AND VP.mob_NUM_RV = PG.mob_NUM_RV    '+
                       '    AND VP.MOB_DTALIQ = PG.MOB_DTAPAG    '+
                       '  LEFT JOIN CFGSIS                                                                      '+
                       '    ON LOCATE(TRIM(LEADING 0 FROM PG.MOB_NUM_PV), TRIM(LEADING 0 FROM SIS_VALCFG)) > 0  '+
                       '    AND SIS_CODCFG IN ("CFG_MOBEST")                                      '+
                       '  LEFT JOIN CADEMP                                   '+
                       '    ON SIS_CODEMP = EMP_CODEMP                       '+
                       'WHERE PG.MOB_DTAPAG BETWEEN :DTAINI      '+
                       '  AND :DTAFIM                            ';

    If Not TMobbuyFuncoes.fEmptyStr(FEstabelecimento) then
      Result.Sql.Text :=  Result.Sql.Text + StringReplace(FEstabelecimento,'MOB_NUM_PV','PG.MOB_NUM_PV',[rfReplaceAll]);

     Result.Sql.Text :=  Result.Sql.Text +
                       '  AND VP.MOB_NUM_RV IS NULL              '+
                     '  GROUP BY PG.MOB_NUM_PV, MOB_DTAPAG, MOB_NSU ,MOB_AUT  ';

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

procedure TImportaVendasMobbuyOnline.CriarComponenteRequisicao;
begin
  LRequisicao := TIdHTTP.Create(Nil);
  LRequisicao.IOHandler := FProtocoloSSL;
  LRequisicao.Request.Connection := 'keep-alive';
  LRequisicao.Request.ContentType := 'application/json';
  LRequisicao.Response.KeepAlive := True;
  LRequisicao.HTTPOptions := [];
  LRequisicao.OnWork := OnWork;
end;

procedure TImportaVendasMobbuyOnline.CriarProtocoloSSL;
begin
  FProtocoloSSL := TIdSSLIOHandlerSocketOpenSSL.Create(Application);
  FProtocoloSSL.SSLOptions.Mode := sslmUnassigned;
  FProtocoloSSL.SSLOptions.Method := sslvTLSv1_2;
  FProtocoloSSL.SSLOptions.SSLVersions := [sslvTLSv1_2];
end;

destructor TImportaVendasMobbuyOnline.Destroy;
begin
  FreeAndNil(LRequisicao);
  FreeAndNil(FProtocoloSSL);
  FreeAndNil(LListaVendasPagamento);
  If Assigned(LDadosToken) Then
    FreeAndNil(LDadosToken);
  If Assigned(LPgtoSemVenda) Then
    FreeAndNil(LPgtoSemVenda);

  inherited;
end;

procedure TImportaVendasMobbuyOnline.OnWork(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  Application.ProcessMessages;
end;

function TImportaVendasMobbuyOnline.RetornaTotalLiquidoPagamento: Double;
  Var
    LPagamento : TUniQuery;
begin
  Try
    LPagamento := VS_FuncoesExternas.fICriaQuery;

    LPagamento.Close;
    LPagamento.Sql.Clear;
    LPagamento.Sql.Text := 'SELECT                                            '+
                           '   SUM(MOB_VALBRU - MOB_VALTAX) AS TOTAL_LIQUIDO  '+
                           ' FROM                                             '+
                           '   MOB_APPGTO                                     '+
                           '  LEFT JOIN CFGSIS                                                                   '+
                           '    ON LOCATE(TRIM(LEADING 0 FROM MOB_NUM_PV), TRIM(LEADING 0 FROM SIS_VALCFG)) > 0  '+
                           '    AND SIS_CODCFG IN ("CFG_REDEST")                                   '+
                           '  LEFT JOIN CADEMP                                   '+
                           '    ON SIS_CODEMP = EMP_CODEMP                       '+
                           'WHERE MOB_DTAVCT BETWEEN :DTAINI                  '+
                           '  AND :DTAFIM                                     ';

    If Not TMobbuyFuncoes.fEmptyStr(FEstabelecimento) then
      LPagamento.Sql.Text :=  LPagamento.Sql.Text + FEstabelecimento;

    LPagamento.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', FDataInicial);
    LPagamento.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', FDataFinal);
    LPagamento.Open;

    Result := TMobbuyFuncoes.fFormataFloat(LPagamento.FieldByName('TOTAL_LIQUIDO').AsFloat,2);

  Finally
    FreeAndNil(LPagamento);
  End;
end;

procedure TImportaVendasMobbuyOnline.ReimportarVendas;
Var
  LTotalLiquidoPagamentos : Double;
  LTotalLiquidoVendas : Double;
  LDiferenca: Double;
begin
  Try
    LTotalLiquidoPagamentos := RetornaTotalLiquidoPagamento;
    LTotalLiquidoVendas :=  RetornaTotalLiquidoVendas;

    LDiferenca := (LTotalLiquidoPagamentos - LTotalLiquidoVendas);
    If Not ((TMobbuyFuncoes.fFormataFloat(LDiferenca, 2) <= 0.01999) And (TMobbuyFuncoes.fFormataFloat(LDiferenca, 2) >= -0.01999))  Then
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

function TImportaVendasMobbuyOnline.RetornaTotalLiquidoVendas: Double;
  Var
    LVendas : TUniQuery;
begin
  Try
    LVendas := VS_FuncoesExternas.fICriaQuery;

    LVendas.Close;
    LVendas.Sql.Clear;
    LVendas.Sql.Text := 'SELECT                             '+
                        '  SUM(MOB_PAGLIQ) AS TOTAL_LIQUIDO '+
                        'FROM                               '+
                        '  (SELECT                          '+
                        '    MOB_DTAVCT,                    '+
                        '    MOB_NUM_PV,                    '+
                        '    MOB_NUM_RV,                    '+
                        '    MOB_NUMNSU,                    '+
                        '    MOB_NUMPAR,                    '+
                        '    MOB_PAGLIQ                     '+
                        '  FROM                             '+
                        '    MOB_APVPAR                     '+
                        'WHERE MOB_STATUS IN ("Processado","Agendado","") '+
                        ' ) AS VENDA                        '+
                        '  LEFT JOIN CFGSIS                                                                   '+
                        '    ON LOCATE(TRIM(LEADING 0 FROM MOB_NUM_PV), TRIM(LEADING 0 FROM SIS_VALCFG)) > 0  '+
                        '    AND SIS_CODCFG IN ("CFG_MOBEST"")                                   '+
                        '  LEFT JOIN CADEMP                                   '+
                        '    ON SIS_CODEMP = EMP_CODEMP                       '+
                        ' WHERE MOB_DTAVCT BETWEEN :DTAINI  '+
                        '  AND :DTAFIM                      ';

    If Not TMobbuyFuncoes.fEmptyStr(FEstabelecimento) then
      LVendas.Sql.Text := LVendas.Sql.Text + FEstabelecimento;

    LVendas.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', FDataInicial);
    LVendas.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', FDataFinal);
    LVendas.Open;

    Result := TMObbuyFuncoes.fFormataFloat(LVendas.FieldByName('TOTAL_LIQUIDO').AsFloat,2);

  Finally
    FreeAndNil(LVendas);
  End;
end;

end.
