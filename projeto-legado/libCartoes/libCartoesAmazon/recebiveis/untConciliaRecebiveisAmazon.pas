unit untConciliaRecebiveisAmazon;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.SysUtils, System.StrUtils,
     System.Variants, Data.DB, Vcl.Graphics, System.Generics.Collections,
     System.DateUtils,

     Uni, UniClientDataSet, cxProgressBar,

     untTAmazonFuncoes, untTLibCartoesMovCar, untLibCartoesInterfacesTipos,
     untAmazonConciliaRecebiveis, untAmazonTipos;


type TConciliaRecebiveisAmazon = class(TConciliaRecebiveisMkt)
  private
    FCartoesParaConciliacao,
     FPeriodoFiltro: String;

    FListaRegistrosConciliar: TStringList;

    FListaArquivos: TStringList;

    FCondicaoAjustes,
    FListaDePedidos: String;

    FPortadorTransferencia,
    FPlanoContasTransferencia,
    FCentroCustosTransferencia,
    FCentroCustosBaixa,
    FPortadorBaixa,
    FPlanoContasBaixa,
    FFornecedorBaixa: String;

    FAutoIncremRelatorio: Integer;

    procedure pFiltraCartoesAMZ;
    procedure pFiltraCartoesBaixadosAMZ;
    procedure pFiltraCancelamentosAMZ(var prgStatus: TcxProgressBar);
    procedure pAdicionaRegistrosDeTransferenciasAmazon;

    function fProcessaAMZPag(pgbStatus: TcxProgressBar): Boolean;
    function fConciliaAMZ(pgbStatus: TcxProgressBar): Boolean;
    function RetornaIDRepassePeriodo: String;
    function RetornaListaDePedidos: String;
    function fBuscaCartaoAMZ: Boolean;
    function fBuscaCartaoBaixadoAMZ: Boolean;
    function RetornaSQLRegistrosImportados: String;
    function RetornaNomeArquivosConciliacao: String;

  public
    constructor Create; overload;
    destructor Destroy; override;

    function fConciliaCartoes(prgStatus: TcxProgressBar): Boolean; override;
    function RetornaEmpresaFiltrada: String;

    property ListaRegistrosConciliar: TStringList read FListaRegistrosConciliar;
    property AutoIncremRelatorio: Integer read FAutoIncremRelatorio;
    property NomeArquivosConciliacao: String read RetornaNomeArquivosConciliacao;
  end;

Const
  INICAM = 'AMZ_';
  NOMTAB = 'AMZ_AMPGTO';

implementation

constructor TConciliaRecebiveisAmazon.Create;
begin
  inherited;
  FListaArquivos := TStringList.Create;
end;

destructor TConciliaRecebiveisAmazon.Destroy;
begin
  FreeAndNil(FListaArquivos);
  inherited;
end;

function TConciliaRecebiveisAmazon.RetornaEmpresaFiltrada: String;
begin
  Result := EmpresasPeriodo[0].strCodigo;
end;

function TConciliaRecebiveisAmazon.RetornaIDRepassePeriodo: String;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := VS_FuncoesExternas.fICriaQuery;
  Try
    LConsulta.SQL.Text := 'SELECT DISTINCT AMZ_SETIDE ' +
                          'FROM AMZ_AMPGTO ' +
                          'WHERE AMZ_DTAPAG BETWEEN "' + FormatDateTime('yyyy-mm-dd', DataInicioPeriodo) + '" ' +
                          '                     AND "' + FormatDateTime('yyyy-mm-dd', DataFinalPeriodo) + '" ' +
                          '  AND AMZ_CODEMP IN ("' + FiltrosRelatorio.ListaEmpresas + '") ';
    LConsulta.Open;

    Result := EmptyStr;
    While Not LConsulta.Eof Do
    Begin
      Result := Result + '"' + LConsulta.FieldByName('AMZ_SETIDE').AsString + '",';
      LConsulta.Next;
    End;

    If Result.IsEmpty Then
      Result := '"",';

    Result := LeftStr(Result, Result.Length - 1);
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;

end;

function TConciliaRecebiveisAmazon.RetornaListaDePedidos: String;
var
  LSQL: String;
  LConsulta: TUniQuery;
begin
  LConsulta := Nil;

  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LSQL := 'SELECT DISTINCT AMZ_IDEPED FROM AMZ_AMPGTO WHERE ' + FPeriodoFiltro +
            '  AND AMZ_IDEPED IS NOT NULL ' +
            '  AND AMZ_IDEPED <> '''' ' +
            '  AND AMZ_TIPTRA IN (''Order'', ''Refund'', ''other-transaction'', ''Other'') ';
    LConsulta.SQL.Text := LSQL;
    LConsulta.Open;

    Result := EmptyStr;

    While Not LConsulta.Eof Do
    Begin
      Result := Result + '"' + LConsulta.FieldByName('AMZ_IDEPED').AsString + '",';
      LConsulta.Next;
    End;

    If Not Result.IsEmpty Then
      Exit(LeftStr(Result, Result.Length - 1));

    Result := '" "';
  Finally
     TAmazonFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

function TConciliaRecebiveisAmazon.RetornaNomeArquivosConciliacao: String;
  Var
    LNomeArquivo: String;
begin
  Result := EmptyStr;
  If FListaArquivos.Count = 0 Then Exit;
  For LNomeArquivo In FListaArquivos Do
    Result := Result + LNomeArquivo + '_';
end;

function TConciliaRecebiveisAmazon.RetornaSQLRegistrosImportados: String;
begin
  If FPeriodoFiltro.IsEmpty Then
    FPeriodoFiltro := ' AMZ_CODEMP IN ("' + FiltrosRelatorio.ListaEmpresas + '") ' +
                      ' AND (AMZ_SETIDE IN (' + RetornaIDRepassePeriodo + ') OR ' +
                      '      AMZ_DTAPAG BETWEEN "' + FormatDateTime('yyyy-mm-dd', DataInicioPeriodo) + '" ' +
                      '                     AND "' + FormatDateTime('yyyy-mm-dd', DataFinalPeriodo) + '") ';

  Result := '';
  Result := Result + ' SELECT                                                                      ';
  Result := Result + '   P.AMZ_IDEPED,                                                             ';
  Result := Result + '   P.AMZ_CODEMP,                                                            ';
  Result := Result + '   P.AMZ_SETIDE,                                                            ';
  Result := Result + '   P.AMZ_DTAPAG,                                                            ';
  Result := Result + '   P.AMZ_DTATRA,                                                            ';
  Result := Result + '   P.AMZ_NOMARQ,                                                            ';
  Result := Result + '   P.AMZ_TIPFUL,                                                            ';
  Result := Result + '   P.AMZ_CONCIL,                                                            ';
  Result := Result + '   EMP_NOMEMP,                                                              ';
  Result := Result + '   P.AMZ_TIPTRA,                                                              ';
  Result := Result + '   SUM(CASE WHEN P.AMZ_TP_VLR = "ItemPrice"                                 ';
  Result := Result + '        THEN P.AMZ_VALORT ELSE 0 END) AS VALOR_BRUTO,                       ';
  Result := Result + '   SUM(P.AMZ_VALORT) AS VALOR_LIQUIDO,                                      ';
  Result := Result + '   SUM(CASE WHEN P.AMZ_TP_VLR = "ItemPrice"                                 ';
  Result := Result + '             AND P.AMZ_DESCVL = "Shipping"                                  ';
  Result := Result + '        THEN P.AMZ_VALORT ELSE 0 END) AS REGISTROFRETE,                     ';
  Result := Result + '   ABS(SUM(CASE WHEN P.AMZ_TP_VLR = "ItemFees"                              ';
  Result := Result + '                 AND P.AMZ_DESCVL = "Commission"                            ';
  Result := Result + '            THEN P.AMZ_VALORT ELSE 0 END)) AS VALCOMISSAO,                  ';
  Result := Result + '   ABS(SUM(CASE WHEN P.AMZ_TP_VLR = "ItemFees"                              ';
  Result := Result + '                 AND P.AMZ_DESCVL <> "Commission"                           ';
  Result := Result + '            THEN P.AMZ_VALORT ELSE 0 END)) AS VALTAXASADICIONAIS,           ';
  Result := Result + '   ABS(SUM(CASE WHEN P.AMZ_TP_VLR = "Promotion"                             ';
  Result := Result + '            THEN P.AMZ_VALORT ELSE 0 END)) AS CUPOMDESCONTO,                ';
  Result := Result + '   0.00 AS REGISTROAJUSTE,                                                  ';
  Result := Result + '   "01" AS PARCELA,                                                         ';
  Result := Result + '   "01" AS TOTPARC,                                                         ';
  Result := Result + '   CAST("0000-00-00" AS DATE) AS AMZ_DTARET,                               ';
  Result := Result + '   "N" AS MARCADO                                                           ';
  Result := Result + ' FROM AMZ_AMPGTO P                                                          ';
  Result := Result + '   LEFT JOIN CADEMP ON EMP_CODEMP = P.AMZ_CODEMP                           ';
  Result := Result + ' WHERE ' + FPeriodoFiltro;
  Result := Result + '   AND P.AMZ_TIPTRA = "Order"                                               ';
  Result := Result + '   AND P.AMZ_IDEPED IS NOT NULL                                              ';
  Result := Result + '   AND P.AMZ_IDEPED <> ""                                                    ';
  Result := Result + ' GROUP BY                                                                   ';
  Result := Result + '   P.AMZ_IDEPED, P.AMZ_CODEMP, P.AMZ_SETIDE, P.AMZ_TIPTRA ,                  ';
  Result := Result + '   P.AMZ_DTAPAG, P.AMZ_DTATRA, P.AMZ_NOMARQ,                              ';
  Result := Result + '   P.AMZ_TIPFUL, P.AMZ_CONCIL, EMP_NOMEMP                                  ';
  Result := Result + ' HAVING VALOR_BRUTO > 0                                                     ';
  Result := Result + ' ORDER BY AMZ_DTAPAG, AMZ_IDEPED                                            ';
end;

procedure TConciliaRecebiveisAmazon.pFiltraCancelamentosAMZ(var prgStatus: TcxProgressBar);
Var
  LSQL: String;
  LConsultaAjustes: TUniQuery;
  LRegistroRelatorio: TItensRelatorioCartoes;
  LAjusteCredito: Boolean;

  LEmpresaConfiguracao,
  LIdentificador: String;
begin

  LConsultaAjustes := Nil;
  Try
    LConsultaAjustes := VS_FuncoesExternas.fICriaQuery;
    LSQL := ' SELECT                                                                   ';
    LSQL := LSQL + '   AMZ_IDEPED,                                                     ';
    LSQL := LSQL + '   AMZ_CODEMP,                                                    ';
    LSQL := LSQL + '   AMZ_SETIDE,                                                    ';
    LSQL := LSQL + '   AMZ_DTAPAG,                                                    ';
    LSQL := LSQL + '   AMZ_DTATRA,                                                    ';
    LSQL := LSQL + '   AMZ_TIPTRA,                                                     ';
    LSQL := LSQL + '   AMZ_TP_VLR,                                                     ';
    LSQL := LSQL + '   AMZ_DESCVL,                                                    ';
    LSQL := LSQL + '   AMZ_NOMARQ,                                                    ';
    LSQL := LSQL + '   AMZ_CONCIL,                                                    ';
    LSQL := LSQL + '   AMZ_CODEMP AS EMPRESA,                                         ';
    LSQL := LSQL + '   SUM(AMZ_VALORT) AS VALOR_LIQUIDO,                               ';
    LSQL := LSQL + '   IF(SUM(AMZ_VALORT) > 0, SUM(AMZ_VALORT), 0) AS AJUCRE,          ';
    LSQL := LSQL + '   "N" AS MARCADO                                                 ';
    LSQL := LSQL + ' FROM ' + NOMTAB;
    LSQL := LSQL + ' WHERE ' + FCondicaoAjustes;
    LSQL := LSQL + ' GROUP BY AMZ_IDEPED, AMZ_CODEMP, AMZ_SETIDE, AMZ_DTAPAG,         ';
    LSQL := LSQL + '          AMZ_DTATRA, AMZ_TIPTRA, AMZ_TP_VLR, AMZ_DESCVL,          ';
    LSQL := LSQL + '          AMZ_NOMARQ, AMZ_CONCIL                                  ';
    LSQL := LSQL + ' ORDER BY AMZ_IDEPED, AMZ_TIPTRA                                    ';

    LConsultaAjustes.SQL.Text := LSQL;
    LConsultaAjustes.Open;
    cdsAjustes := TAmazonFuncoes.CriarClientDataSet(LConsultaAjustes);
    cdsAjustes.Open;
  Finally
    TAmazonFuncoes.FreeAndNilDatasets(LConsultaAjustes);
  End;

  TAmazonFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Filtrando ajustes Amazon.', False);
  prgStatus.Position := 0;
  prgStatus.Properties.Max := cdsAjustes.RecordCount;

  cdsAjustes.First;
  While Not cdsAjustes.Eof Do
  Begin
    TAmazonFuncoes.pStepStatusGravacao(prgStatus);

    If TAmazonFuncoes.fFormataFloat(cdsAjustes.FieldByName('VALOR_LIQUIDO').AsFloat, 2) = 0.00 Then
    Begin
      cdsAjustes.Next;
      Continue;
    End;

    LRegistroRelatorio := TItensRelatorioCartoes.Create;
    LAjusteCredito := TAmazonFuncoes.fFormataFloat(cdsAjustes.FieldByName('AJUCRE').Value, 2) <> 0;

    LEmpresaConfiguracao := cdsAjustes.FieldByName('EMPRESA').AsString;

    LRegistroRelatorio.ValorBruto   := TAmazonFuncoes.fFormataFloat(cdsAjustes.FieldByName('VALOR_LIQUIDO').AsFloat, 2);
    LRegistroRelatorio.ValorLiquido := TAmazonFuncoes.fFormataFloat(cdsAjustes.FieldByName('VALOR_LIQUIDO').AsFloat, 2);

    If LAjusteCredito Then
    Begin
      LRegistroRelatorio.ValorBruto   := Abs(LRegistroRelatorio.ValorBruto);
      LRegistroRelatorio.ValorLiquido := Abs(LRegistroRelatorio.ValorLiquido);
    End;

    LRegistroRelatorio.Descricao      := 'Cancelamentos/Ajustes';
    LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
    LRegistroRelatorio.TipoCartao     := 'CANCELAMENTOS/AJUSTES';

    If cdsAjustes.FieldByName('AMZ_TIPTRA').AsString = 'Refund' Then
      LRegistroRelatorio.DescricaoAjuste := 'Reembolso - ' + cdsAjustes.FieldByName('AMZ_IDEPED').AsString
    Else If cdsAjustes.FieldByName('AMZ_TIPTRA').AsString = 'Adjustment' Then
      LRegistroRelatorio.DescricaoAjuste := 'Ajuste Manual - ' + cdsAjustes.FieldByName('AMZ_DESCVL').AsString
    Else If cdsAjustes.FieldByName('AMZ_TIPTRA').AsString = 'other-transaction' Then
      LRegistroRelatorio.DescricaoAjuste := 'Easy Ship - ' + cdsAjustes.FieldByName('AMZ_IDEPED').AsString
    Else If cdsAjustes.FieldByName('AMZ_TIPTRA').AsString = 'ServiceFee' Then
      LRegistroRelatorio.DescricaoAjuste := 'Taxa de Serviço Amazon - ' + cdsAjustes.FieldByName('AMZ_DESCVL').AsString
    Else If cdsAjustes.FieldByName('AMZ_TIPTRA').AsString = 'FBAInventoryFee' Then
      LRegistroRelatorio.DescricaoAjuste := 'Taxa Armazenamento FBA - ' + cdsAjustes.FieldByName('AMZ_DESCVL').AsString
    Else If cdsAjustes.FieldByName('AMZ_TIPTRA').AsString = 'FBAFulfillmentFee' Then
      LRegistroRelatorio.DescricaoAjuste := 'Taxa Fulfillment FBA - ' + cdsAjustes.FieldByName('AMZ_DESCVL').AsString
    Else If cdsAjustes.FieldByName('AMZ_TIPTRA').AsString = 'CouponRedemptionFee' Then
      LRegistroRelatorio.DescricaoAjuste := 'Taxa Cupom - ' + cdsAjustes.FieldByName('AMZ_DESCVL').AsString
    Else If cdsAjustes.FieldByName('AMZ_TIPTRA').AsString = 'Liquidations' Then
      LRegistroRelatorio.DescricaoAjuste := 'Liquidação FBA - ' + cdsAjustes.FieldByName('AMZ_DESCVL').AsString
    Else If cdsAjustes.FieldByName('AMZ_TIPTRA').AsString = 'Other' Then
      LRegistroRelatorio.DescricaoAjuste := 'Reembolso Amazon - ' + cdsAjustes.FieldByName('AMZ_IDEPED').AsString
    Else
      LRegistroRelatorio.DescricaoAjuste := cdsAjustes.FieldByName('AMZ_TIPTRA').AsString + ' - ' + cdsAjustes.FieldByName('AMZ_DESCVL').AsString;

    LRegistroRelatorio.CodigoEmpresa         := LEmpresaConfiguracao;
    LRegistroRelatorio.CodigoEstabelecimento := LEmpresaConfiguracao;

    LIdentificador := cdsAjustes.FieldByName('AMZ_IDEPED').AsString;
    If LIdentificador.IsEmpty Then
      LIdentificador := 'Settlement: ' + cdsAjustes.FieldByName('AMZ_SETIDE').AsString;

    LRegistroRelatorio.NumeroNSU         := LIdentificador;
    LRegistroRelatorio.NumeroCartao      := '0000';

    LRegistroRelatorio.CodigoAutorizacao :=cdsAjustes.FieldByName('AMZ_SETIDE').AsString;

    LRegistroRelatorio.Parcela        := '01';
    LRegistroRelatorio.TotalParcelas  := '01';

    LRegistroRelatorio.DataVenda      := cdsAjustes.FieldByName('AMZ_DTATRA').Value;
    LRegistroRelatorio.DataPagamento  := cdsAjustes.FieldByName('AMZ_DTAPAG').Value;

    LRegistroRelatorio.Conciliado  := cdsAjustes.FieldByName('AMZ_CONCIL').AsInteger;
    LRegistroRelatorio.NomeArquivo := cdsAjustes.FieldByName('AMZ_NOMARQ').AsString;

    LRegistroRelatorio.RegistroIncompleto := ConfiguracoesAjustesEstaoIncompletas(LEmpresaConfiguracao);

    GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);
    FListaRegistrosRelatorio.Add(LRegistroRelatorio);

    cdsAjustes.Next;
  End;

end;

procedure TConciliaRecebiveisAmazon.pFiltraCartoesAMZ;
Var
  LSQL: String;

  LConsulta: TUniQuery;
begin
  LSQL := TLibCartoesMovCar.fGetSQLCartoes(objConcil);

  FListaDePedidos := RetornaListaDePedidos;

  LSQL := LSQL + ' AND MCA_CODCAR IN (' + TAmazonFuncoes.fRetStrToSQLIn(FCartoesParaConciliacao) + ') ';
  LSQL := LSQL + ' AND (MCA_NUMCCD IN (' + FListaDePedidos + ') OR ';
  LSQL := LSQL + '      MCA_NUMNSU IN (' + FListaDePedidos + ')) ';

  LSQL := LSQL + ' ORDER BY MCA_NUMCCD, MCA_NUMNSU, MCA_PARCEL, MCA_CODEMP) AS TMP ';

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := LSQL;
    LConsulta.Open;

    cdsBaiCar := TAmazonFuncoes.CriarClientDataSet(LConsulta);
    cdsBaiCar.Open;

    cdsBaiCar.IndexFieldNames := 'MCA_NUMCCD;MCA_NUMNSU;MCA_CODEMP;PARDUP;MCA_DTACUP;MCA_NUMDUP';
  Finally
    TAmazonFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

procedure TConciliaRecebiveisAmazon.pFiltraCartoesBaixadosAMZ;
Var
  strSQL   : String;
  qryBaixad: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT IF(IFNULL(MCA_NUMCCD, "") = "", MCA_NUMNSU, MCA_NUMCCD) AS MCA_NUMCCD, ';
  strSQL := strSQL + '        MCA_PARCEL, MCA_DTAREC, MCA_NUMNSU, MCA_VALREC, ';
  strSQL := strSQL + '        AUTOINCREM, MCA_NUMDUP, MCA_DTACUP, MCA_DTAREC, ';
  strSQL := strSQL + '        IFNULL(MCA_ORDEID, MCA_NUMPOK) AS MCA_ORDEID, ';
  strSQL := strSQL + '        MCA_CODEMP, MCA_DTAVEN, MCA_EMPRCX, MCA_CHACON ';
  strSQL := strSQL + ' FROM MOVCAR ';
  strSQL := strSQL + ' WHERE MCA_CODCAR IN (' + TAmazonFuncoes.fRetStrToSQLIn(FCartoesParaConciliacao) + ') ';

  strSQL := strSQL + '   AND (MCA_NUMCCD IN (' + FListaDePedidos + ') OR ' +
                     '        MCA_NUMNSU IN (' + FListaDePedidos + '))  ';

  strSQL := strSQL + '   AND MCA_DTAREC IS NOT NULL ';
  strSQL := strSQL + 'ORDER BY MCA_NUMCCD, MCA_PARCEL,MCA_CODEMP ';

  qryBaixad := VS_FuncoesExternas.fICriaQuery;

  Try
    qryBaixad.SQL.Text := strSQL;
    qryBaixad.Open;
    cdsBaixad := TAmazonFuncoes.CriarClientDataSet(qryBaixad);
    cdsBaixad.Open;

    cdsBaixad.IndexFieldNames := 'MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP;MCA_CODEMP';
    cdsBaiCar.IndexFieldNames := 'MCA_NUMCCD;PARDUP;EMPLOC;MCA_DTACUP';
  Finally
    qryBaixad.Close;
    FreeAndNil(qryBaixad);
  End;

end;

function TConciliaRecebiveisAmazon.fBuscaCartaoAMZ: Boolean;
begin
  Result := cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_MARDES',
              VarArrayOf([UpperCase(cdsConCar.FieldByName('AMZ_IDEPED').AsString), 'A', 'D']), []);

  If Not Result Then
    Result := cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_MARDES',
                VarArrayOf([UpperCase(cdsConCar.FieldByName('AMZ_IDEPED').AsString), 'A', 'D']), []);
end;

function TConciliaRecebiveisAmazon.fBuscaCartaoBaixadoAMZ: Boolean;
begin
  Result := cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL',
              VarArrayOf([UpperCase(cdsConCar.FieldByName('AMZ_IDEPED').AsString), 'A']), []);

  If Not Result Then
    Result := cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL',
                VarArrayOf([UpperCase(cdsConCar.FieldByName('AMZ_IDEPED').AsString), 'A']), []);

  blnAutomatica := Result And
                   (Not TAmazonFuncoes.fEmptyStr(cdsBaixad.FieldByName('MCA_CHACON').AsString));
end;

procedure TConciliaRecebiveisAmazon.pAdicionaRegistrosDeTransferenciasAmazon;
  Var
    LConsulta: TUniQuery;
    LRegistroRelatorio: TItensRelatorioCartoes;
    LValidaConfiguracoes: String;
    LConfiguracoesValidas: Boolean;
begin
  If objConcil.CfgPortadorTransferencia.IsEmpty Then
    Exit;

  LConsulta := VS_FuncoesExternas.fICriaQuery;
  Try
    LConsulta.SQL.Text :=
      Concat('SELECT CONCILIACAO.AMZ_IDEPED, ',
             '       CONCILIACAO.AMZ_CODEMP, ',
             '       CONCILIACAO.AMZ_SETIDE, ',
             '       CONCILIACAO.AMZ_DTAPAG, ',
             '       CONCILIACAO.AMZ_DTATRA, ',
             '       CONCILIACAO.AMZ_NOMARQ, ',
             '       CONCILIACAO.AMZ_CONCIL, ',
             '       "Transfer" AS AMZ_TIPTRA, ',
             '       SUM(CONCILIACAO.AMZ_VALORT) AS VALOR_TRANSFERENCIA, ',
             '       CONCILIACAO.AMZ_CODEMP AS EMPRESA, ',
             '       POR.SIS_VALCFG AS PORTADOR, ',
             '       CTA.SIS_VALCFG AS PLANODECONTAS, ',
             '       EVE.SIS_VALCFG AS CENTRODECUSTOS ',
             'FROM ', NOMTAB, ' AS CONCILIACAO ',
             'LEFT JOIN CFGSIS AS POR ON POR.SIS_CODEMP = CONCILIACAO.AMZ_CODEMP AND ',
             '                           POR.SIS_CODCFG = "CFG_' + objConcil.CfgPortadorTransferencia + '" ',
             'LEFT JOIN CFGSIS AS CTA ON CTA.SIS_CODEMP = CONCILIACAO.AMZ_CODEMP AND ',
             '                           CTA.SIS_CODCFG = "CFG_' + objConcil.CfgPlanoDeContasTransferencia + '" ',
             'LEFT JOIN CFGSIS AS EVE ON EVE.SIS_CODEMP = CONCILIACAO.AMZ_CODEMP AND ',
             '                           EVE.SIS_CODCFG = "CFG_' + objConcil.CfgCentroDeCustosTransferencia + '" ',
             'WHERE ', FPeriodoFiltro,
             '  AND CONCILIACAO.AMZ_TIPTRA = "Transfer" ',
             'GROUP BY CONCILIACAO.AMZ_IDEPED, CONCILIACAO.AMZ_CODEMP, CONCILIACAO.AMZ_SETIDE, ',
             '         CONCILIACAO.AMZ_DTAPAG, CONCILIACAO.AMZ_DTATRA, CONCILIACAO.AMZ_NOMARQ, ',
             '         CONCILIACAO.AMZ_CONCIL ');

    LConsulta.Open;

    While Not LConsulta.Eof Do
    Begin
      LValidaConfiguracoes := Concat(LConsulta.FieldByName('PORTADOR').AsString,
                                     LConsulta.FieldByName('PLANODECONTAS').AsString,
                                     LConsulta.FieldByName('CENTRODECUSTOS').AsString);

      LConfiguracoesValidas := LValidaConfiguracoes.Length >= 12;
      If VS_FuncoesExternas.fICfgSis('CTPOBE', varBoolean) Then
        LConfiguracoesValidas := LValidaConfiguracoes.Length > 12;

      If Not LConfiguracoesValidas Then
      Begin
        LConsulta.Next;
        Continue;
      End;

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LRegistroRelatorio.ValorBruto   := TAmazonFuncoes.fFormataFloat(LConsulta.FieldByName('VALOR_TRANSFERENCIA').AsFloat, 2);
      LRegistroRelatorio.ValorLiquido := LRegistroRelatorio.ValorBruto;

      LRegistroRelatorio.Descricao      := 'TRANSFERÊNCIAS';
      LRegistroRelatorio.TipoDoRegistro := 'TRANSFERÊNCIA';
      LRegistroRelatorio.TipoCartao     := 'TRANSFERÊNCIAS';
      LRegistroRelatorio.DescricaoAjuste := 'TRANSFERÊNCIA AMAZON - Settlement: ' + LConsulta.FieldByName('AMZ_SETIDE').AsString;

      LRegistroRelatorio.CodigoEmpresa         := LConsulta.FieldByName('EMPRESA').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := LConsulta.FieldByName('EMPRESA').AsString;
      LRegistroRelatorio.NumeroNSU             := LConsulta.FieldByName('IDEPED').AsString;
      LRegistroRelatorio.NumeroCartao          := '0000';

      LRegistroRelatorio.CodigoAutorizacao     := LConsulta.FieldByName('AMZ_SETIDE').AsString;

      LRegistroRelatorio.Parcela       := '01';
      LRegistroRelatorio.TotalParcelas := '01';

      LRegistroRelatorio.DataVenda     := LConsulta.FieldByName('AMZ_DTAPAG').AsDateTime;
      LRegistroRelatorio.DataPagamento := LConsulta.FieldByName('AMZ_DTAPAG').AsDateTime;

      LRegistroRelatorio.RegistroTransferencia          := 'S';
      LRegistroRelatorio.PortadorTransferencia          := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPortadorTransferencia, LConsulta.FieldByName('EMPRESA').AsString);
      LRegistroRelatorio.PlanoContasTransferenciaCredito := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPlanoDeContasTransferencia, LConsulta.FieldByName('EMPRESA').AsString);
      LRegistroRelatorio.CentroCustosTransferencia      := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgCentroDeCustosTransferencia, LConsulta.FieldByName('EMPRESA').AsString);
      LRegistroRelatorio.PortadorCredito                := LRegistroRelatorio.PortadorTransferencia;
      LRegistroRelatorio.PortadorDebito                 := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPortadorAjustes, LConsulta.FieldByName('EMPRESA').AsString);

      LRegistroRelatorio.Conciliado  := LConsulta.FieldByName('AMZ_CONCIL').AsInteger;
      LRegistroRelatorio.NomeArquivo := LConsulta.FieldByName('AMZ_NOMARQ').AsString;

      LRegistroRelatorio.RegistroIncompleto := 'N';

      If Not LRegistroRelatorio.PortadorTransferencia.IsEmpty Then
      Begin
        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, False, LConsulta);
        FListaRegistrosConciliar.Add(fRetornaChaveConciliacao(LConsulta));
      End;

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      LConsulta.Next;
    End;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

function TConciliaRecebiveisAmazon.fProcessaAMZPag(pgbStatus: TcxProgressBar): Boolean;
  Var
    LValorBruto,
    LValorLiquido,
    LValorTaxa,
    LValorFrete,
    LValorCupom: Double;
    LChaveConciliacao,
    LSQL: String;

    LConsulta: TUniQuery;

    LBuscaPedido: Boolean;

    LRegistroRelatorio: TItensRelatorioCartoes;
begin
   Application.ProcessMessages;

  If Assigned(FListaArquivos) Then
    FreeAndNil(FListaArquivos);

  FListaArquivos := TStringList.Create;

  LSQL := RetornaSQLRegistrosImportados;

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SHOW TABLES LIKE "' + NOMTAB + '"';
    LConsulta.Open;
    If LConsulta.IsEmpty Then
    Begin
      TAmazonFuncoes.fMensagem('ATENÇÃO','Não existem arquivos importados para a conciliação do ' + objConcil.NomeConciliacao + '!',['&OK']);
      Exit(False);
    End;

    LConsulta.Close;
    LConsulta.SQL.Text := LSQL;
    LConsulta.Open;
    cdsConCar := TAmazonFuncoes.CriarClientDataSet(LConsulta);
  Finally
    TAmazonFuncoes.FreeAndNilDatasets(LConsulta);
  End;

  FCartoesParaConciliacao := VS_FuncoesExternas.fICfgSis('AMZCAR', varString, RetornaEmpresaFiltrada);

  pCalculaPeriodoFiltro(INICAM + 'DTATRA');

  FRelatorioConciliacao := TRelatorioConciliacao.Create(
                             VS_FuncoesExternas.fIRetOperadorLogado,
                             'AMAZON',
                             'CONCILIACAO',
                             RetornaFiltrosdigitados,
                             TAmazonFuncoes.RetornaDataHoraServidor,
                             TAmazonFuncoes.RetornaHoraServidor);

  pgbStatus.Visible := False;
  TAmazonFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando registros Amazon.', False);

  pFiltraCartoesAMZ;

  pAdicionaRegistrosDeTransferenciasAmazon;

  FCondicaoAjustes := FPeriodoFiltro +
                    ' AND ( AMZ_TIPTRA IN (' +
                    '     "Refund", "Adjustment", "other-transaction",' +
                    '     "ServiceFee", "FBAInventoryFee", "FBAFulfillmentFee",' +
                    '     "CouponRedemptionFee", "Liquidations", "Other" )' +
                    '   OR ( AMZ_TIPTRA = "Order" AND AMZ_IDEPED IN (' +
                    '       SELECT AMZ_IDEPED FROM ' + NOMTAB +
                    '       WHERE AMZ_TIPTRA = "Order" ' +
                    '       GROUP BY AMZ_IDEPED ' +
                    '       HAVING SUM(AMZ_VALORT) < 0 ) )) ';

  TAmazonFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando ajustes Amazon.', False);
  pgbStatus.Visible := True;
  pFiltraCancelamentosAMZ(pgbStatus);

  If cdsConCar.IsEmpty And cdsAjustes.IsEmpty Then
  Begin
    TAmazonFuncoes.fMensagem('ATENÇÃO', 'Não existem arquivos importados no período para a conciliação da AMAZON!', ['&OK']);
    Exit(False);
  End;

  pFiltraCartoesBaixadosAMZ;

  pgbStatus.Visible := True;
  TAmazonFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Processando lançamentos (AMAZON).', False);
  pgbStatus.Position := 0;
  pgbStatus.Properties.Max := cdsConCar.RecordCount;

  cdsConCar.First;
  While Not cdsConCar.EOF Do
  Begin
    TAmazonFuncoes.pStepStatusGravacao(pgbStatus);

    FTextoInconsistencia := EmptyStr;

    If FListaArquivos.IndexOf(cdsConCar.FieldByName('AMZ_NOMARQ').AsString) = -1 Then
      FListaArquivos.Add(cdsConCar.FieldByName('AMZ_NOMARQ').AsString);

    LRegistroRelatorio := TItensRelatorioCartoes.Create;

    LValorBruto   := cdsConCar.FieldByName('VALOR_BRUTO').AsFloat;
    LValorLiquido := cdsConCar.FieldByName('VALOR_LIQUIDO').AsFloat;
    LValorFrete   := TAmazonFuncoes.fFormataFloat(Abs(cdsConCar.FieldByName('REGISTROFRETE').AsFloat), 2);
    LValorTaxa := cdsConCar.FieldByName('VALCOMISSAO').AsFloat +
                  cdsConCar.FieldByName('VALTAXASADICIONAIS').AsFloat;
    LValorCupom   := Abs(cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat);

    LBuscaPedido := fBuscaCartaoAMZ;

    If LBuscaPedido Then
    Begin

      LChaveConciliacao := INICAM + cdsConCar.FieldByName('AMZ_SETIDE').AsString + '_' +
                            cdsConCar.FieldByName('AMZ_IDEPED').AsString + '_' +
                            cdsConCar.FieldByName('AMZ_TIPTRA').AsString + '_' +
                            cdsBaiCar.FieldByName('MCA_CODEMP').AsString + '_' +
                            FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('AMZ_DTATRA').AsDateTime);

      MarcarCartaoEncontradoArquivo(LValorBruto,
                                    LValorLiquido,
                                    LRegistroRelatorio,
                                    LChaveConciliacao,
                                    cdsConCar,
                                    LValorFrete,
                                    Abs(cdsConCar.FieldByName('REGISTROAJUSTE').AsFloat),
                                    Abs(LValorTaxa),
                                    Abs(LValorCupom));

      LRegistroRelatorio.Conciliado := 0;

      If cdsBaiCar.FieldByName('MCA_MARDES').AsString = 'M' Then
      Begin
        If Not FTextoInconsistencia.IsEmpty Then
          LRegistroRelatorio.SomarNoTotal := 'N';

        cdsConCar.Edit;
        cdsConCar.FieldByName('MARCADO').AsString := 'S';
        cdsConCar.Post;

        FListaRegistrosConciliar.Add(fRetornaChaveConciliacao(cdsConCar));
      End;
    End
    Else
    Begin
      If LValorLiquido > 0 Then
        FTextoInconsistencia := 'Vendas não encontradas nos lançamentos do sistema';

      LBuscaPedido := fBuscaCartaoBaixadoAMZ;
      If LBuscaPedido Then
      Begin
        FTextoInconsistencia := 'Vendas já foram baixadas';
        LRegistroRelatorio.InconsistenciaConciliada := 'S';
        LRegistroRelatorio.Conciliado := 1;
        LRegistroRelatorio.AutoIncremMovCar := cdsBaixad.FieldByName('AUTOINCREM').AsString;
      End;
    End;

    FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
    If Not FTextoInconsistencia.IsEmpty Then
    Begin
      LRegistroRelatorio.Descricao := FTextoInconsistencia;
      If Not LRegistroRelatorio.InconsistenciaConciliada.Equals('S') Then
        LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
    End;

    LRegistroRelatorio.NomeArquivo           := cdsConCar.FieldByName('AMZ_NOMARQ').AsString;
    LRegistroRelatorio.CodigoEstabelecimento := cdsConCar.FieldByName('AMZ_CODEMP').AsString;
    LRegistroRelatorio.CodigoEmpresa         := cdsConCar.FieldByName('AMZ_CODEMP').AsString;

    LRegistroRelatorio.NumeroNSU         := cdsConCar.FieldByName('AMZ_IDEPED').AsString;
    LRegistroRelatorio.CodigoAutorizacao := cdsConCar.FieldByName('AMZ_SETIDE').AsString;
    LRegistroRelatorio.ResumoVenda       := '';
    LRegistroRelatorio.NumeroCartao      := '0000';

    LRegistroRelatorio.TipoCartao := 'CRÉDITO ROTATIVO';

    LRegistroRelatorio.Parcela        := '01';
    LRegistroRelatorio.TotalParcelas  := '01';

    LRegistroRelatorio.DataPagamento  := cdsConCar.FieldByName('AMZ_DTAPAG').Value;
    LRegistroRelatorio.DataVenda      := cdsConCar.FieldByName('AMZ_DTATRA').Value;
    LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName('AMZ_DTAPAG').Value;

    LRegistroRelatorio.ValorBruto   := LValorBruto;
    LRegistroRelatorio.ValorLiquido := LValorLiquido;
    LRegistroRelatorio.ValorTaxas   := LValorTaxa;
    LRegistroRelatorio.ValorFrete   := Abs(LValorFrete);
    LRegistroRelatorio.ValorAjustes := Abs(cdsConCar.FieldByName('REGISTROAJUSTE').AsFloat);
    LRegistroRelatorio.ValorCupom   := Abs(cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat);

    LRegistroRelatorio.DescricaoBandeira := objConcil.NomeConciliacao;

    FListaRegistrosRelatorio.Add(LRegistroRelatorio);

    cdsConCar.Next;
  End;

  FreeAndNil(cdsBaixad);
  Result := True;
end;

function TConciliaRecebiveisAmazon.fConciliaAMZ(pgbStatus: TcxProgressBar): Boolean;
begin
  Result := False;
  PossuiInconsistencia := false;

  cdsConCar := Nil;

  FCartoesParaConciliacao := VS_FuncoesExternas.fICfgSis('AMZCAR', varString, RetornaEmpresaFiltrada);
  If FCartoesParaConciliacao.IsEmpty Then
  Begin
    TAmazonFuncoes.fMensagem('ATENÇÃO',
      'Para realizar a baixa de recebíveis, deve selecionar os cartões referentes ' +
      'à Amazon na configuração AMZCAR.', ['&Ok']);
    Exit;
  End;

  Try
    Try
      FListaRegistrosConciliar := TStringList.Create;

      objConcil.TabelaConciliacao         := NOMTAB;
      objConcil.CampoEstabelecimento      := 'AMZ_CODEMP';
      objConcil.NomeConciliacao           := 'AMAZON';
      objConcil.CfgEstabelecimentos       := '';
      objConcil.CampoValorBruto           := 'AMZ_VALBRU';
      objConcil.CampoValorLiquido         := 'AMZ_VALLIQ';
      objConcil.CampoCodigoAutorizacao    := 'AMZ_SETIDE';
      objConcil.CampoNumeroNSU            := 'AMZ_IDEPED';
      objConcil.CampoDataTransacaoVenda   := 'AMZ_DTATRA';
      objConcil.CampoNumeroParcela        := 'AMZ_NUMPAR';
      objConcil.CampoTotalParcelas        := 'AMZ_NUMPAR';
      objConcil.CampoNumeroCartao         := '0000';
      objConcil.CampoDataRecebimento      := 'AMZ_DTAPAG';
      objConcil.CampoTipoRegistro         := 'AMZ_TIPTRA';
      objConcil.CampoTipoTransacao        := 'AMZ_TIPTRA';


      objConcil.CampoDataTransacaoVenda := 'AMZ_DTATRA';

      objConcil.strEventoCancelamentoAjuste    := 'AMZEVE';
      objConcil.CfgPortadorTransferencia       := 'AMZTRF';
      objConcil.CfgPlanoDeContasTransferencia  := 'AMZCTF';
      objConcil.CfgCentroDeCustosTransferencia := 'AMZETF';

      objConcil.CfgPortadorAjustes              := 'AMZPOR';
      objConcil.CfgPlanoDeContasAjustes         := 'AMZCTA';
      objConcil.CfgFornecedorAjustes            := 'AMZFOR';
      objConcil.strEventoCancelamentoAjuste     := 'AMZEVE';
      objConcil.CfgPortadorTransferencia        := 'AMZTRF';
      objConcil.CfgPlanoDeContasTransferencia   := 'AMZCTF';
      objConcil.CfgCentroDeCustosTransferencia  := 'AMZETF';

      objConcil.strChavePrimaria := 'AMZ_SETIDE,AMZ_IDEPED,AMZ_TIPTRA,AMZ_CODEMP,AMZ_DTAPAG';


      FPortadorTransferencia    := VS_FuncoesExternas.fICfgSis(objConcil.CfgPortadorTransferencia,  varString);
      FPlanoContasTransferencia := VS_FuncoesExternas.fICfgSis(objConcil.CfgPlanoDeContasTransferencia, varString);
      FCentroCustosTransferencia := VS_FuncoesExternas.fICfgSis(objConcil.CfgCentroDeCustosTransferencia, varString);
      FCentroCustosBaixa         := VS_FuncoesExternas.fICfgSis(objConcil.strEventoCancelamentoAjuste, varString);
      FPortadorBaixa            := VS_FuncoesExternas.fICfgSis(objConcil.CfgPortadorAjustes,        varString);
      FPlanoContasBaixa         := VS_FuncoesExternas.fICfgSis(objConcil.CfgPlanoDeContasAjustes,   varString);
      FFornecedorBaixa          := VS_FuncoesExternas.fICfgSis(objConcil.CfgFornecedorAjustes,      varString);

      If Not CarregaFiltrosParaBaixaRecebiveis(DataInicioPeriodo, DataFinalPeriodo, EmpresasPeriodo) Then
        Exit(False);

      TAmazonFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Selecionando registros para conciliação (AMAZON)', False);
      Result := fProcessaAMZPag(pgbStatus);

    Except
      On E: Exception Do
      Begin
        Result := False;
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.fConcilia' + StringReplace(objConcil.NomeConciliacao, ' ', EmptyStr, []) + ']');
      End;
    End;

    cdsBaiCar.Filter   := 'MCA_MARDES=' + QuotedStr('M');
    cdsBaiCar.Filtered := True;

    PossuiInconsistencia := False;

    If Not TryStrToInt(FRelatorioConciliacao.AutoIncremRelatorio, FAutoIncremRelatorio) Then
      FAutoIncremRelatorio := 0;

    TAmazonFuncoes.ExecutaAguarde(GravarRegistrosRelatorio, 'Aguarde... Gravando registros do relatório (' + objConcil.NomeConciliacao + ').');

  Finally
    TAmazonFuncoes.FreeAndNilDatasets(cdsConCar);
  End;
end;

function TConciliaRecebiveisAmazon.fConciliaCartoes(prgStatus: TcxProgressBar): Boolean;
begin
  FPeriodoFiltro := EmptyStr;
  Result := fConciliaAMZ(prgStatus);
end;

end.
