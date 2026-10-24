unit untTRepositorioDadosBloco1Cat42;

interface

uses System.Generics.Collections, SysUtils, Vcl.Forms, untTDadosAberturaExportacaoCat42, untTDadosBloco1Cat42;

type
  TRepositorioDadosBloco1Cat42 = class
  private
    FDados: TDadosBloco1Cat42;

    function fRetSQLSaldosPeriodo: string;
    function fRetSQLNotasPeriodo: string;
    function fRetModeloDocumento(strCODEMP, strCAT_CAMP03, strCAT_CAMP06, strCAT_CAMP07, strCAT_CAMP08: string): string;

  public
    function fRetDados(abertura: TDadosAberturaExportacaoCat42): TDadosBloco1Cat42;

    constructor create;
    Destructor Destroy; override;
  end;

implementation

uses untFuncoes, Uni, DB;

{ TRepositorioDadosBloco1Cat42 }

constructor TRepositorioDadosBloco1Cat42.create;
begin
  inherited create;

  FDados := TDadosBloco1Cat42.Create;
end;

destructor TRepositorioDadosBloco1Cat42.Destroy;
begin
  FDados.Free;

  inherited;
end;

function TRepositorioDadosBloco1Cat42.fRetDados(abertura: TDadosAberturaExportacaoCat42): TDadosBloco1Cat42;
  var
    dadoNf: TNotaFiscalCat42;
    saldo: TSaldoCat42;
    qryAux: TUniQuery;
    strTipoFCModelo: string;
begin
  Result := FDados;

  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := fRetSQLNotasPeriodo;
      ParamByName('MESANO').AsString := FormatDateTime('MM/YYYY', abertura.dtaDataInicial);
      ParamByName('CODEMP').AsString := abertura.empresa.strCodigo;

      //# SAVE DO SQL PARA ANALISE 19122019 1135
      //# qryAux.SQL.SaveToFile('C:\Users\fabio.silva\Documents\REQUISITOS\SQLDelphi\fRetDadosCAT_42_DADOS.txt');

      Open;

      abertura.lblOperacao.Caption := 'Coletando registro Cat 42 Dados ... ';
      abertura.progressoTela.Max := RecordCount;
      abertura.progressoTela.Position := 0;
      Application.ProcessMessages;

      while Not Eof do
      begin

        strTipoFCModelo := fRetModeloDocumento(abertura.empresa.strCodigo,
                                               FieldByName('ACESSO').AsString,
                                               FieldByName('SERIE').AsString,
                                               FieldByName('DOCUMENTO').AsString,
                                               FieldByName('CODIGO_PARTICIPANTE').AsString);

        //CARREGANDO AS NF UTILIZADAS NO PERÍODO
        dadoNf := TNotaFiscalCat42.Create;
        dadoNf.fltValorTotalIcmsSuportado := FieldByName('TOTAL_ICMS_SUPORTADO').AsFloat;
        dadoNf.strCodigoEnquadramento := FieldByName('CODIGO_ENQUADRAMENTO').AsString;
        dadoNf.intIndicadorOperacao := FieldByName('INDICADOR_OPERACAO').AsInteger;

        if Pos(FieldByName('CODIGO_ENQUADRAMENTO').AsString, '1_3') > 0 then
          dadoNf.fltValorConfronto := FieldByName('CAT_CAMP20').AsFloat
        else if Pos(FieldByName('CODIGO_ENQUADRAMENTO').AsString, '2_4') > 0 then
          dadoNf.fltValorConfronto := FieldByName('CAT_CAMP21').AsFloat
        else
          dadoNf.fltValorConfronto := 0;

        dadoNf.participante.strCodigo := FieldByName('CODIGO_PARTICIPANTE').AsString;
        dadoNf.participante.strCgcCpf := FieldByName('CGCCPF').AsString;
        dadoNf.dtaDataEntrada := FieldByName('DATA_ENTRADA').AsDateTime;
        dadoNf.strCodigoProduto := FieldByName('PRODUTO').AsString;
        dadoNf.fltQuantidade := FieldByName('QUANTIDADE').AsFloat;
        dadoNf.strDocumento := FieldByName('DOCUMENTO').AsString;
        dadoNf.strChaveAcesso := FieldByName('ACESSO').AsString;

        //# dadoNf.strModelo := FieldByName('FIS_DOCMOD').AsString;
        dadoNf.strTipFc := Copy(strTipoFCModelo, 1, 1);
        dadoNf.strModelo := Copy(strTipoFCModelo, 2, 4);

        dadoNf.strNumeroEcf := FieldByName('NUMECF').AsString;
        dadoNf.strSerie := FieldByName('SERIE').AsString;
        dadoNf.strCfop := FieldByName('CFOP').AsString;
        dadoNf.fltSaidasParaOutrosEstados := FieldByName('SAIDAS_PARA_OUTROS_ESTADOS').AsFloat;

        dadoNf.fltCampo14 := FieldByName('CAT_CAMP14').AsFloat;
        dadoNf.fltCampo18 := FieldByName('CAT_CAMP18').AsFloat;
        dadoNf.fltCampo21 := FieldByName('CAT_CAMP21').AsFloat;
        dadoNf.fltCampo25 := FieldByName('CAT_CAMP25').AsFloat;

        FDados.listaNotas.Add(dadoNf);

        abertura.progressoTela.StepBy(1);
        Application.ProcessMessages;

        Next;
      end;

      Close;
      SQL.Clear;
      SQL.Text := fRetSQLSaldosPeriodo;
      ParamByName('MESANO').AsString := FormatDateTime('MM/YYYY', abertura.dtaDataInicial);
      ParamByName('CODEMP').AsString := abertura.empresa.strCodigo;
      Open;

      abertura.lblOperacao.Caption := 'Coletando registro Cat 42 Saldos...';
      abertura.progressoTela.Max := RecordCount;
      abertura.progressoTela.Position := 0;
      Application.ProcessMessages;

      while not Eof do
      begin
        //CARREGANDO OS SALDOS DO PERÍODO
        saldo := TSaldoCat42.Create;
        saldo.strCodigoProduto := FieldByName('CAT_CODITE').AsString;
        saldo.fltQtdIni := FieldByName('CAT_QTDINI').AsFloat;
        saldo.fltQtdFin := FieldByName('CAT_QTDFIN').AsFloat;
        saldo.fltSalIni := FieldByName('CAT_SALINI').AsFloat;
        saldo.fltSalFin := FieldByName('CAT_SALFIN').AsFloat;
        FDados.listaSaldo.Add(saldo);

        abertura.progressoTela.StepBy(1);
        Application.ProcessMessages;
        Next;
      end;
    end;
  finally
    qryAux.Free;
  end;
end;

function TRepositorioDadosBloco1Cat42.fRetModeloDocumento(strCODEMP, strCAT_CAMP03, strCAT_CAMP06, strCAT_CAMP07, strCAT_CAMP08: string): string;
  var
    strSQL: string;
    qryAux: TUniQuery;
begin

  //# DESENVOLVIDA FUNÇÃO PARA RECUPERAR O MODELO DO DOCUMENTO

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  IF(((IFNULL(FIS_HISTOR, "") LIKE "%INUTILI%") AND (FIS_ESPDOC IN ("IF", "IV"))), "65",';
  strSQL := strSQL + '  IF(IFNULL(FIS_HISTOR, "") LIKE "%INUTILI%", "55", IF(FIS_SERIE_ BETWEEN 890 AND 899, "55", IF( (FIS_ESPDOC = "NF") AND (IFNULL(FIS_ACESSO,"") = "") , "01", ';
  strSQL := strSQL + '  IF(((FIS_ESPDOC IN ("NF", "NV")) AND (IFNULL(FIS_ACESSO,"") <> "")) OR ';
  strSQL := strSQL + '        (FIS_ESPDOC = "EL"), "55", ';
  strSQL := strSQL + '  IF(FIS_ESPDOC IN ("IF", "IV"), IF(IFNULL(FIS_ACESSO,"")="", "2D", "65"), "01")))))) AS FIS_DOCMOD, ';
  strSQL := strSQL + '  FIS_TIP_FC ';
  strSQL := strSQL + '  FROM CADFIS ';
  strSQL := strSQL + ' WHERE FIS_CODEMP = :CODEMP ';
  strSQL := strSQL + '   AND FIS_FORCLI = :CAMP08 ';
  strSQL := strSQL + '   AND IFNULL(FIS_SERIE_, "") = IFNULL(:CAMP06, "") ';
  strSQL := strSQL + '   AND FIS_ACESSO = :CAMP03 ';
  strSQL := strSQL + '   AND FIS_NUMDOC = :CAMP07 ';

  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := strSQL;
      ParamByName('CODEMP').AsString := strCODEMP;
      ParamByName('CAMP08').AsString := strCAT_CAMP08;
      ParamByName('CAMP06').AsString := strCAT_CAMP06;
      ParamByName('CAMP03').AsString := strCAT_CAMP03;
      ParamByName('CAMP07').AsString := strCAT_CAMP07;
      Open;

      if not IsEmpty then
        Result :=  FieldByName('FIS_TIP_FC').AsString + '' + FieldByName('FIS_DOCMOD').AsString
      else Result := '';

    end;
  finally
    qryAux.Free;
  end;

end;

function TRepositorioDadosBloco1Cat42.fRetSQLNotasPeriodo: string;
begin
  Result := '';
  Result := Result + 'SELECT ';

  Result := Result + '  IF(((CAT_CAMP15 > 0) OR (CAT_CAMP15 < 0)), "1", ';
  Result := Result + '   IF(((CAT_CAMP16 > 0) OR (CAT_CAMP16 < 0)), "2", ';
  Result := Result + '    IF(((CAT_CAMP17 > 0) OR (CAT_CAMP17 < 0)), "3", ';
  Result := Result + '     IF(((CAT_CAMP18 > 0) OR (CAT_CAMP18 < 0)), "4", ';
  Result := Result + '      IF(CAT_CAMP13 <= 0, "0", "0") )))) AS CODIGO_ENQUADRAMENTO, ';

  //# DESENVOLVIDA FUNÇÃO PARA RECUPERAR O MODELO DO DOCUMENTO
  //# Result := Result + '  IF(((IFNULL(FIS_HISTOR, "") LIKE "%INUTILI%") AND (FIS_ESPDOC IN ("IF", "IV"))), "65",';
  //# Result := Result + '  IF(IFNULL(FIS_HISTOR, "") LIKE "%INUTILI%", "55", IF(FIS_SERIE_ BETWEEN 890 AND 899, "55", IF( (FIS_ESPDOC = "NF") AND (IFNULL(FIS_ACESSO,"") = "") , "01", ';
  //# Result := Result + '  IF( ( (FIS_ESPDOC IN ("NF", "NV")) AND (IFNULL(FIS_ACESSO,"") <> "") ) OR ';
  //# Result := Result + '        (FIS_ESPDOC = "EL"), "55", ';
  //# Result := Result + '  IF( FIS_ESPDOC IN ("IF", "IV"), IF(IFNULL(FIS_ACESSO,"")="", "2D", "65"), "01" ) ) ) ) ) ) AS FIS_DOCMOD, ';

  Result := Result + '  IFNULL(CLI_C_G_C_, IFNULL(FOR_C_G_C_, "")) AS CGCCPF, ';
  Result := Result + '  IF(CAT_CAMP13 > 0, 1, 0) AS INDICADOR_OPERACAO, ';
  Result := Result + '  CASE WHEN (CAT_CAMP11 + CAT_CAMP13) > 0 THEN (CAT_CAMP11 + CAT_CAMP13) ELSE (CAT_CAMP11 + CAT_CAMP13)*-1 END AS QUANTIDADE, ';
  Result := Result + '  CASE WHEN CAT_CAMP12 > 0 THEN (CAT_CAMP12) ELSE (CAT_CAMP12)*-1 END AS TOTAL_ICMS_SUPORTADO, ';
  Result := Result + '  CAT_CAMP08 AS CODIGO_PARTICIPANTE, ';
  Result := Result + '  CAT_CAMP02 AS DATA_ENTRADA, ';
  Result := Result + '  CAT_CAMP07 AS DOCUMENTO, ';
  Result := Result + '  CAT_CODITE AS PRODUTO, ';
  Result := Result + '  CAT_CAMP03 AS ACESSO, ';
  Result := Result + '  CAT_CAMP04 AS NUMECF_, ';
  Result := Result + '  CASE WHEN (CAT_CAMP03 <> "" OR CAT_CAMP03 IS NULL) THEN "" ELSE IF(CAT_CAMP09 = "1411", "1441:EC-NFC.E", "") END AS NUMECF, ';
  Result := Result + '  CAT_CAMP06 AS SERIE, ';
  Result := Result + '  CAT_CAMP09 AS CFOP, ';
  Result := Result + '  CASE WHEN CAT_CAMP20 > 0 THEN (CAT_CAMP20) ELSE (CAT_CAMP20)*-1 END AS CAT_CAMP20, ';
  Result := Result + '  CASE WHEN CAT_CAMP21 > 0 THEN (CAT_CAMP21) ELSE (CAT_CAMP21)*-1 END AS CAT_CAMP21, ';
  Result := Result + '  CASE WHEN CAT_CAMP18 > 0 THEN (CAT_CAMP18) ELSE (CAT_CAMP18)*-1 END AS SAIDAS_PARA_OUTROS_ESTADOS, ';

  Result := Result + '  CAT_CAMP01, ';
  Result := Result + '  CAT_CAMP02, ';
  Result := Result + '  CAT_CAMP03, ';
  Result := Result + '  CAT_CAMP04, ';
  Result := Result + '  CAT_CAMP05, ';
  Result := Result + '  CAT_CAMP06, ';
  Result := Result + '  CAT_CAMP07, ';
  Result := Result + '  CAT_CAMP08, ';
  Result := Result + '  CAT_CAMP09, ';
  Result := Result + '  CAT_CAMP10, ';
  Result := Result + '  CAT_CAMP11, ';
  Result := Result + '  CAT_CAMP12, ';
  Result := Result + '  CAT_CAMP13, ';
  Result := Result + '  CAT_CAMP14, ';
  Result := Result + '  CAT_CAMP15, ';
  Result := Result + '  CAT_CAMP16, ';
  Result := Result + '  CAT_CAMP17, ';
  Result := Result + '  CAT_CAMP18, ';
  Result := Result + '  CAT_CAMP19, ';
  Result := Result + '  CAT_CAMP20, ';
  Result := Result + '  CAT_CAMP21, ';
  Result := Result + '  CAT_CAMP22, ';
  Result := Result + '  CAT_CAMP23, ';
  Result := Result + '  CAT_CAMP24, ';
  Result := Result + '  CAT_CAMP25, ';
  Result := Result + '  CAT_CAMP26, ';
  Result := Result + '  CAT_CAMP27, ';
  Result := Result + '  CAT_MESANO, ';
  Result := Result + '  CAT_CODEMP, ';
  Result := Result + '  CAT_CODITE, ';
  Result := Result + '  CAT_INCVEN ';

  Result := Result + 'FROM ';
  Result := Result + '  CAT_42_DADOS ';

  Result := Result + '  LEFT JOIN CADCLI ';
  Result := Result + '    ON CLI_CODCLI = CAT_CAMP08 ';

  Result := Result + '  LEFT JOIN CADFOR ';
  Result := Result + '    ON FOR_CODFOR = CAT_CAMP08 ';

  //# DESENVOLVIDA FUNÇÃO PARA RECUPERAR O MODELO DO DOCUMENTO
  //# Result := Result + '  LEFT JOIN CADFIS ';
  //# Result := Result + '   ON FIS_NUMDOC = CAT_CAMP07 ';
  //# Result := Result + '   AND FIS_FORCLI = CAT_CAMP08 ';
  //# Result := Result + '   AND IFNULL(FIS_SERIE_, "") = IFNULL(CAT_CAMP06, "") ';
  //# Result := Result + '   AND FIS_ACESSO = CAT_CAMP03 ';

  Result := Result + 'WHERE CAT_MESANO = :MESANO ';
  Result := Result + '  AND CAT_CODEMP = :CODEMP ';

  //# PARAMETROS PARA PESQUISA PARA TESTES (**)
  //# Result := Result + '  AND CAT_CAMP07 IN("000000000761","000000000762") ';
  //# Result := Result + '  AND CAT_CODITE IN("15137","30191","30194","30223","73884") ';
  //Result := Result + ' AND CAT_CAMP03 IN ("35230468422419000175550010028141291553573597", "35230468422419000175550010028193741116565146") ';

  Result := Result + 'HAVING QUANTIDADE > 0 ';
end;

function TRepositorioDadosBloco1Cat42.fRetSQLSaldosPeriodo: string;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  T.CAT_CODITE, ';
  Result := Result + '  T.CAT_QTDINI, ';
  Result := Result + '  T.CAT_QTDFIN, ';
  Result := Result + '  T.CAT_SALINI, ';
  Result := Result + '  T.CAT_SALFIN, ';
  Result := Result + '  IFNULL(MOVDAD, 0) AS MOVDAD ';

  Result := Result + 'FROM ';
  Result := Result + '  CAT_42_SALDOS T ';

  Result := Result + 'LEFT JOIN (SELECT CAT_CODITE AS CODITE, ';
  Result := Result + '                  SUM(IF((CAT_CAMP11 < 0), CAT_CAMP11*-1, CAT_CAMP11) + IF((CAT_CAMP13 < 0), CAT_CAMP13*-1, CAT_CAMP13)) MOVDAD ';
	Result := Result + '             FROM CAT_42_DADOS ';
	Result := Result + '            WHERE CAT_MESANO = :MESANO';
	Result := Result + '              AND CAT_CODEMP = :CODEMP ';
  Result := Result + '            GROUP BY CAT_CODITE) TB ON TB.CODITE = T.CAT_CODITE ';


  Result := Result + 'WHERE T.CAT_MESANO = :MESANO ';
  Result := Result + '  AND T.CAT_CODEMP = :CODEMP ';
  Result := Result + '  AND (T.CAT_QTDINI > 0 ';
  Result := Result + '   OR T.CAT_QTDFIN > 0 ';
  Result := Result + '   OR IFNULL(TB.MOVDAD, 0) > 0) ';
end;

end.
