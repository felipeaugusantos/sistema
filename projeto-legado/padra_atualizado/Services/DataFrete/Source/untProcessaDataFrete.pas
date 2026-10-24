unit untProcessaDataFrete;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types, System.Classes, System.NetEncoding,
  System.JSON, strUtils, Math, System.DateUtils, REST.Authenticator.OAuth, Uni, Data.DB,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest, Services.Core.Task.Lock,
  Services.Core.Types, Services.Core.Task.Monitor, Posix.Unistd;
  {$ELSE }
  untFuncoesSimples, REST.Client, Uni, untUtilMonitor, untFuncFatTypes;
  {$ENDIF LINUX}

type
  TProcessaDataFrete = class sealed(TInterfacedObject, {$IFDEF LINUX}ITaskMonitorProcedure {$ELSE}IMonitorProcedure{$ENDIF LINUX})
  private
    procedure pSalvarCotacao;
    procedure pEnviarXmlNf;
  public
    procedure pExecute;
    procedure pExecuteAll;
    function fExecute : TResultExecute;
  end;

implementation

{ TProcessaDataFrete }

uses untDataFreteImportarNotaFiscalJson,
  untDataFreteSalvarCotacao;

function TProcessaDataFrete.fExecute : TResultExecute;
begin
end;

procedure TProcessaDataFrete.pExecuteAll;
begin
  pExecute;
end;

procedure TProcessaDataFrete.pExecute;
begin
  inherited;
  pSalvarCotacao;
  pEnviarXmlNf;
end;

procedure TProcessaDataFrete.pSalvarCotacao;
var
  qrySalCot: IQuery;
  qryAux: IQuery;

  RetornoDataFreteSalvarCotacao: TRetornoDataFreteSalvarCotacao;
begin
  RetornoDataFreteSalvarCotacao := nil;

  qrySalCot := fCriaQuery;
  qryAux := fCriaQuery;

  qrySalCot.Close;
  qrySalCot.SQL.Text :=
  ' SELECT '+
  '   F.AUTOINCREM AS AUTINC_DTAFRE, '+
  '   F.DTF_CODEMP, '+
  '   F.DTF_CODTAB, '+
  '   F.DTF_COTID_, '+
  '   G.AUTOINCREM AS AUTINC_FATGOR, '+
  '   G.FGO_NUMDOC  '+

  IIF(fCfgSis('DTFSAL') = 'NF',
      ' ,D.DET_NUMDOC '+
      ' ,D.DET_SERIE_ ',
      '')+

  ' FROM '+
  '   DTAFRE F '+
  ' INNER JOIN FATGOR G '+
  '   ON F.DTF_SEQFGO = G.AUTOINCREM '+

  IIF(fCfgSis('DTFSAL') = 'NF',
      ' INNER JOIN MOVDET D '+
      '   ON G.FGO_NUMDOC = D.DET_NUM_PD  AND '+
      '      G.FGO_ESPDOC = D.DET_ESP_PD  AND '+
      '      G.FGO_CODEMP = D.DET_EMP_PD  AND '+
      '      G.FGO_CODCLI = D.DET_CODCLI '+
      ' INNER JOIN MOVGER M '+
      '   ON D.DET_SEQGER = M.AUTOINCREM ',
      '')+

  ' WHERE '+
  '   F.DTF_SALCOT = "N" AND '+
  '   F.DTF_CODEMP = :CODEMP AND '+
  '   IFNULL(F.DTF_COTID_, "") <> "" AND '+
  '   F.DTF_CODTAB > 0 '+

  IIF(fCfgSis('DTFSAL') = 'NF',
      '  AND G.FGO_CODTRA = M.GER_CODTRA '+
      '  AND NOT EXISTS '+
      ' (SELECT '+
      '    1 '+
      '  FROM '+
      '    FATDOR '+
      '  WHERE FATDOR.FDO_SEQGER = F.DTF_SEQFGO '+
      '    AND FATDOR.FDO_JAFATU = 0) ',
      '')+

  ' GROUP BY '+
  '   AUTINC_DTAFRE, '+
  '   F.DTF_CODEMP,  '+
  '   F.DTF_CODTAB,  '+
  '   F.DTF_COTID_,  '+
  '   AUTINC_FATGOR, '+
  '   G.FGO_NUMDOC   '+

  IIF(fCfgSis('DTFSAL') = 'NF',
      ' ,D.DET_NUMDOC '+
      ' ,D.DET_SERIE_ ',
      '');

  qrySalCot.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qrySalCot.Open;

  if qrySalCot.IsEmpty then
    Exit;

  while not qrySalCot.Eof do
  begin
    if fCfgSis('DTFSAL') = 'NF' then
    begin
      RetornoDataFreteSalvarCotacao :=
        TDataFreteSalvarCotacaoNotaFiscal.fNew()
                                           .setCod_tabela(qrySalCot.FieldByName('DTF_CODTAB').AsInteger)
                                           .setCotacao_id(qrySalCot.FieldByName('DTF_COTID_').AsString)
                                           .setNota_fiscal(qrySalCot.FieldByName('DET_NUMDOC').AsString)
                                           .setPedido(qrySalCot.FieldByName('FGO_NUMDOC').AsString)
                                           .setSerie_documento(qrySalCot.FieldByName('DET_SERIE_').AsString)
                                           .fSalvarCotacao(qrySalCot.FieldByName('AUTINC_FATGOR').AsString);
    end
    else
    begin
      RetornoDataFreteSalvarCotacao :=
        TDataFreteSalvarCotacaoPedido.fNew()
                                       .setCod_tabela(qrySalCot.FieldByName('DTF_CODTAB').AsInteger)
                                       .setCotacao_id(qrySalCot.FieldByName('DTF_COTID_').AsString)
                                       .setPedido(qrySalCot.FieldByName('FGO_NUMDOC').AsString)
                                       .fSalvarCotacao(qrySalCot.FieldByName('AUTINC_FATGOR').AsString);
    end;

    if Assigned(RetornoDataFreteSalvarCotacao) then
    begin
      qryAux.Close;
      qryAux.SQL.Text :=
      ' UPDATE '+
      '   DTAFRE '+
      ' SET '+
      '   DTF_SALCOT = "S" '+
      ' WHERE '+
      '   AUTOINCREM = :AUTINC ';

      qryAux.ParamByName('AUTINC').AsString := qrySalCot.FieldByName('AUTINC_DTAFRE').AsString;
      qryAux.ExecSQL;

      FreeAndNil(RetornoDataFreteSalvarCotacao);
    end;

    Sleep(500);
    qrySalCot.Next;
  end;
end;

procedure TProcessaDataFrete.pEnviarXmlNf;
var
  qryXml: IQuery;
  qryAux: IQuery;
  strXMLBase64: String;

  RetornoDataFreteImportarNotaFiscalJson: TRetornoDataFreteImportarNotaFiscalJson;
begin
  RetornoDataFreteImportarNotaFiscalJson := nil;

  qryXml := fCriaQuery;
  qryAux := fCriaQuery;

  qryXml.Close;
  qryXml.SQL.Text :=
  ' SELECT '+
  '   F.AUTOINCREM AS AUTINC_DTAFRE, '+
  '   G.FGO_NUMDOC AS NUMERO_PEDIDO, '+
  '   G.AUTOINCREM AS AUTINC_FATGOR, '+
  '   M.AUTOINCREM AS AUTINC_MOVGER, '+
  '   X.NFE_ARQXML '+
  ' FROM '+
  '   DTAFRE F '+
  ' INNER JOIN FATGOR G '+
  '   ON F.DTF_SEQFGO = G.AUTOINCREM '+
  ' INNER JOIN MOVDET D '+
  '   ON G.FGO_NUMDOC = D.DET_NUM_PD  AND '+
  '      G.FGO_ESPDOC = D.DET_ESP_PD  AND '+
  '      G.FGO_CODEMP = D.DET_EMP_PD  AND '+
  '      G.FGO_CODCLI = D.DET_CODCLI '+
  ' INNER JOIN MOVGER M '+
  '   ON D.DET_SEQGER = M.AUTOINCREM '+
  ' INNER JOIN CADFIS I '+
  '   ON M.GER_NUMDOC = I.FIS_NUMDOC  AND '+
  '      M.GER_ESPDOC = I.FIS_ESPDOC  AND '+
  '      M.GER_CODEMP = I.FIS_CODEMP  AND '+
  '      M.GER_CODCLI = I.FIS_FORCLI '+
  ' INNER JOIN XMLNFE X '+
  '   ON I.FIS_ACESSO = X.NFE_ACESSO '+
  ' WHERE '+
  '   F.DTF_CODEMP = :CODEMP         AND '+
  '   F.DTF_SALCOT = "S"             AND '+
  '   F.DTF_ENVXML = "N"             AND '+
  '   G.FGO_CODTRA = M.GER_CODTRA    AND '+
  '   I.FIS_TIP_FC = "C"             AND '+
  '   IFNULL(I.FIS_ACESSO, "") <> "" AND '+
  '   NOT EXISTS (SELECT '+
  '                 1 '+
  '               FROM '+
  '                 FATDOR '+
  '               WHERE '+
  '                 FATDOR.FDO_SEQGER = F.DTF_SEQFGO AND '+
  '                 FATDOR.FDO_JAFATU = 0) '+
  ' GROUP BY '+
  '   AUTINC_MOVGER ';

  qryXml.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryXml.Open;

  if qryXml.IsEmpty then
    Exit;

  while not qryXml.Eof do
  begin
    strXMLBase64 := TNetEncoding.Base64.EncodeBytesToString(TEncoding.UTF8.GetBytes(qryXml.FieldByName('NFE_ARQXML').AsString));

    if not fEmptyStr(strXMLBase64) then
    begin
      RetornoDataFreteImportarNotaFiscalJson :=
        TDataFreteImportarNotaFiscalJson.fNew()
                                          .setXml(strXMLBase64)
                                          .setNumeroPedido(qryXml.FieldByName('NUMERO_PEDIDO').AsString)
                                          .fEnviarXml(qryXml.FieldByName('AUTINC_FATGOR').AsString);

      if Assigned(RetornoDataFreteImportarNotaFiscalJson) then
      begin
        qryAux.Close;
        qryAux.SQL.Text :=
        ' UPDATE '+
        '   DTAFRE '+
        ' SET '+
        '   DTF_ENVXML = "S" '+
        ' WHERE '+
        '   AUTOINCREM = :AUTINC ';

        qryAux.ParamByName('AUTINC').AsString := qryXml.FieldByName('AUTINC_DTAFRE').AsString;
        qryAux.ExecSQL;

        FreeAndNil(RetornoDataFreteImportarNotaFiscalJson);
      end;
    end;

    Sleep(500);
    qryXml.Next;
  end;
end;

end.
