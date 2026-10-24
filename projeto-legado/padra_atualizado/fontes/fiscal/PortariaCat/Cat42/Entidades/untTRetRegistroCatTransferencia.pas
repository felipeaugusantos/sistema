unit untTRetRegistroCatTransferencia;

interface

uses untTDadosAberturaExportacaoCat42,
     System.Generics.Collections,
     untTItemNotaUtilizadoCat,
     untTItemNotaFiscal,
     untTEnquadramento,
     untTRegistroCat,
     untTNotaFiscal,
     SysUtils,
     StrUtils,
     Data.DB,
     Uni;

type

  TRetRegistroCatTransferencia = class
  private
    FAbertura: TDadosAberturaExportacaoCat42;

    function fRetCodigoEmpresaNfTransferida(itemNf: TItemNotaFiscal): string;
    function fRetSQLRetido: string;
    function fRetSQLRetidoSaida(strCodIte: string): string;


  public
    function fRetRegistro(itemTransf: TItemNotaFiscal): TRegistroCat;
    function fRetRegistroSaida(strCodIte: string): string;

    property abertura: TDadosAberturaExportacaoCat42 read FAbertura write FAbertura;
  end;

implementation

uses untFuncoes;

{ TRetRegistroCatTransferencia }

function TRetRegistroCatTransferencia.fRetSQLRetidoSaida(strCodIte: string): string;
  var
    qryAux: TUniQuery;
begin
  Result := '';

  qryAux := fCriaQuery;
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;

      SQL.Text := 'SELECT ' +
                  '  FIS_NUMDOC, ' +
                  '  FIS_CODEMP, ' +
                  '  FIS_DTAENT, ' +
                  '  FIS_ACESSO ' +
                  ' FROM ' +
                  '  CADFIS ' +
                  '  LEFT JOIN MOVDET D ' +
                  '    ON D.DET_NUMDOC = FIS_NUMDOC ' +
                  '    AND D.DET_ESPDOC = FIS_ESPDOC ' +
                  '    AND D.DET_CODEMP = FIS_CODEMP ' +
                  '    AND IFNULL(D.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "") ' +
                  '    AND IF( ' +
                  '      FIS_TIP_FC = "C", ' +
                  '      D.DET_CODCLI, ' +
                  '      D.DET_CODFOR ' +
                  '    ) = FIS_FORCLI ' +
                  '  LEFT JOIN MOVTRI T ' +
                  '    ON T.DET_SEQGER = D.AUTOINCREM ' +
                  '  LEFT JOIN GERELE GLE ' +
                  '    ON GLE.B08_NNF = FIS_NUMDOC ' +
                  '    AND IFNULL(GLE.B07_SERIE, "") = IFNULL(FIS_SERIE_, "") ' +
                  '    AND GLE.GER_CODFOR = FIS_FORCLI ' +
                  '  LEFT JOIN DETELE DLE ' +
                  '    ON DLE.DET_SEQGER = GLE.AUTOINCREM ' +
                  '    AND DLE.DET_CODITE = D.DET_CODITE ' +
                  'WHERE FIS_DTAENT <= :DTAFIN ' +
                  '  AND FIS_CODEMP =  :CODEMP ' +
                  '  AND D.DET_CODITE = :CODITE ' +
                  '  AND D.DET_CLAFIS IN (1409, 2409) ' +
                  'ORDER BY FIS_DTAENT DESC ' +
                  'LIMIT 1 ';

      ParamByName('DTAFIN').AsDateTime := abertura.dtaDataFinal;
      ParamByName('CODEMP').AsString := abertura.empresa.strCodigo;
      ParamByName('CODITE').AsString := strCodIte;

      Open;
      Result := FieldByName('FIS_ACESSO').AsString;

    end;
  finally
    qryAux.Free;
  end;
end;

function TRetRegistroCatTransferencia.fRetRegistroSaida(strCodIte: string): string;
  var
    strChaveAcesso: string;
    qryAux: TUniQuery;
begin
  Result := '';

  strChaveAcesso := fRetSQLRetidoSaida(strCodIte);

  qryAux := fCriaQuery;
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;

      SQL.Text := 'SELECT ' +
                  '  FIS_CODEMP, ' +
                  '  FIS_ACESSO, ' +
                  '  FIS_NUMDOC, ' +
                  '  FIS_DTAENT ' +
                  'FROM ' +
                  '  CADFIS ' +
                  '  LEFT JOIN MOVDET D ' +
                  '    ON D.DET_NUMDOC = FIS_NUMDOC ' +
                  '    AND D.DET_ESPDOC = FIS_ESPDOC ' +
                  '    AND D.DET_CODEMP = FIS_CODEMP ' +
                  '    AND IFNULL(D.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "") ' +
                  '    AND IF( ' +
                  '      FIS_TIP_FC = "C", ' +
                  '      D.DET_CODCLI, ' +
                  '      D.DET_CODFOR ' +
                  '    ) = FIS_FORCLI ' +
                  '  LEFT JOIN NOTDET N ' +
                  '    ON N.DET_NUMDOC = FIS_NUMDOC ' +
                  '    AND N.DET_ESPDOC = FIS_ESPDOC ' +
                  '    AND N.DET_CODEMP = FIS_CODEMP ' +
                  '    AND IFNULL(N.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "") ' +
                  '    AND IF( ' +
                  '      FIS_TIP_FC = "C", ' +
                  '      N.DET_CODCLI, ' +
                  '      N.DET_CODFOR ' +
                  '    ) = FIS_FORCLI ' +
                  'WHERE FIS_ACESSO = :ACESSO ' +
                  '  AND FIS_DTAENT <= :DTAFIN ' +
                  '  AND D.DET_CODITE = :CODITE ' +
                  '  AND D.DET_CLAFIS IN ("5409","6409") ' +
                  'ORDER BY FIS_DTAENT DESC ' +
                  'LIMIT 1; ';

      ParamByName('DTAFIN').AsDateTime := abertura.dtaDataFinal;
      ParamByName('ACESSO').AsString := strChaveAcesso;
      ParamByName('CODITE').AsString := strCodIte;
      Open;

      Result := FieldByName('FIS_CODEMP').AsString;
    end;
  finally
    qryAux.Free;
  end;

end;

function TRetRegistroCatTransferencia.fRetCodigoEmpresaNfTransferida(itemNf: TItemNotaFiscal): string;
  var
    qryAux: TUniQuery;
begin
  Result := '';

  qryAux := fCriaQuery;
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT ' +
                  '  FIS_CODEMP '+
                  'FROM ' +
                  '  CADFIS ' +

                  '  LEFT JOIN MOVDET D '+
                  '   ON D.DET_NUMDOC = FIS_NUMDOC '+
                  '   AND D.DET_ESPDOC = FIS_ESPDOC '+
                  '   AND D.DET_CODEMP = FIS_CODEMP '+
                  '   AND IFNULL(D.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "") '+
                  '   AND IF(FIS_TIP_FC = "C", D.DET_CODCLI, D.DET_CODFOR) = FIS_FORCLI '+

                  '  LEFT JOIN NOTDET N '+
                  '   ON N.DET_NUMDOC = FIS_NUMDOC '+
                  '   AND N.DET_ESPDOC = FIS_ESPDOC '+
                  '   AND N.DET_CODEMP = FIS_CODEMP '+
                  '   AND IFNULL(N.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "") '+
                  '   AND IF(FIS_TIP_FC = "C", N.DET_CODCLI, N.DET_CODFOR) = FIS_FORCLI '+

                  'WHERE FIS_ACESSO = :ACESSO ' +
                  '  AND IFNULL(D.DET_CODITE, N.DET_CODITE) = :CODITE ' +
                  '  AND FIS_CLFSC1 > 5000 ';

      ParamByName('ACESSO').AsString := itemNf.strChaveAcesso;
      ParamByName('CODITE').AsString := itemNf.strCodIte;
      Open;

      Result := FieldByName('FIS_CODEMP').AsString;
    end;
  finally
    qryAux.Free;
  end;
end;

function TRetRegistroCatTransferencia.fRetRegistro(itemTransf: TItemNotaFiscal): TRegistroCat;
  var
    strEmpresaNfTransf: string;
    qryAux: TUniQuery;
begin
  Result := nil;

  strEmpresaNfTransf := fRetCodigoEmpresaNfTransferida(itemTransf);

  if not fEmptyStr(strEmpresaNfTransf) then
  begin
    qryAux := fCriaQuery(nil);
    try
      with qryAux do
      begin
        Close;
        SQL.Clear;
        SQL.Text := fRetSQLRetido;

        ParamByName('DTAFIN').AsDateTime := abertura.dtaDataFinal;
        ParamByName('CODEMP').AsString := strEmpresaNfTransf;
        ParamByName('CODITE').AsString := itemTransf.strCodIte;
        Open;

        if not IsEmpty then
        begin
          Result := TRegistroCat.Create;

          Result.dtaDataNotaDadosGerais := itemTransf.dtaDtaEnt;
          Result.strCodigoProduto := itemTransf.strCodIte;
          Result.strEnquadramento := '';
          Result.intOrdemGeracao := 1;

          Result.itemNota.fltValorRetidoNaoCreditado := FieldByName('DET_VAERET_UNIT').AsFloat * itemTransf.fltQuantidade;
          Result.itemNota.participante.strCodigo := itemTransf.participante.strCodigo;
          Result.itemNota.fltValorContabil := itemTransf.fltValorContabil;
          Result.itemNota.strChaveAcesso := itemTransf.strChaveAcesso;
          Result.itemNota.fltQuantidade := itemTransf.fltQuantidade;
          Result.itemNota.strUnidade := itemTransf.strUnidade;
          Result.itemNota.strCodIte := itemTransf.strCodIte;
          Result.itemNota.strDesIte := itemTransf.strDesIte;
          Result.itemNota.dtaDtaEnt := itemTransf.dtaDtaEnt;
          Result.itemNota.strNumDoc := itemTransf.strNumDoc;
          Result.itemNota.strSerie := itemTransf.strSerie;
          Result.itemNota.strCfop := itemTransf.strCfop;
        end
        else
        begin
          Result := TRegistroCat.Create;

          Result.dtaDataNotaDadosGerais := itemTransf.dtaDtaEnt;
          Result.strCodigoProduto := itemTransf.strCodIte;
          Result.strEnquadramento := '';
          Result.intOrdemGeracao := 1;

          Result.itemNota.fltValorRetidoNaoCreditado := itemTransf.fltValorRetidoNaoCreditado;
          Result.itemNota.participante.strCodigo := itemTransf.participante.strCodigo;
          Result.itemNota.fltValorContabil := itemTransf.fltValorContabil;
          Result.itemNota.strChaveAcesso := itemTransf.strChaveAcesso;
          Result.itemNota.fltQuantidade := itemTransf.fltQuantidade;
          Result.itemNota.strUnidade := itemTransf.strUnidade;
          Result.itemNota.strCodIte := itemTransf.strCodIte;
          Result.itemNota.strDesIte := itemTransf.strDesIte;
          Result.itemNota.dtaDtaEnt := itemTransf.dtaDtaEnt;
          Result.itemNota.strNumDoc := itemTransf.strNumDoc;
          Result.itemNota.strSerie := itemTransf.strSerie;
          Result.itemNota.strCfop := itemTransf.strCfop;
        end;
      end;
    finally
      qryAux.Free;
    end;
  end;
end;

function TRetRegistroCatTransferencia.fRetSQLRetido: string;
begin
  Result := Result + 'SELECT ';

  if FAbertura.blnSomarIcmsRetido then
    Result := Result + '  ROUND((IFNULL(T.DET_VLR158, 0) + IFNULL(T.DET_VLGNRE, 0) + IFNULL(DET_VALRET, 0) + IFNULL(T.DET_VAERET, 0) + IFNULL(N17_VICMS, 0)) / D.DET_QTDITE, 2) AS DET_VAERET_UNIT '
  else
    Result := Result + '  ROUND((IFNULL(T.DET_VLR158, 0) + IFNULL(T.DET_VLGNRE, 0) + IFNULL(DET_VALRET, 0) + IFNULL(T.DET_VAERET, 0)) / D.DET_QTDITE ,2) AS DET_VAERET_UNIT ';

  Result := Result + 'FROM ';
  Result := Result + '  CADFIS ';

  Result := Result + '  LEFT JOIN MOVDET D ';
  Result := Result + '    ON D.DET_NUMDOC = FIS_NUMDOC ';
  Result := Result + '   AND D.DET_ESPDOC = FIS_ESPDOC ';
  Result := Result + '   AND D.DET_CODEMP = FIS_CODEMP ';
  Result := Result + '   AND IFNULL(D.DET_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  Result := Result + '   AND IF(FIS_TIP_FC = "C", D.DET_CODCLI, D.DET_CODFOR) = FIS_FORCLI ';

  Result := Result + '  LEFT JOIN MOVTRI T ';
  Result := Result + '    ON T.DET_SEQGER = D.AUTOINCREM ';

  Result := Result + '  LEFT JOIN GERELE GLE ';
  Result := Result + '   ON GLE.B08_NNF = FIS_NUMDOC ';
  Result := Result + '   AND IFNULL(GLE.B07_SERIE, "") = IFNULL(FIS_SERIE_, "") ';
  Result := Result + '   AND GLE.GER_CODFOR = FIS_FORCLI ';

  Result := Result + '  LEFT JOIN DETELE DLE ';
  Result := Result + '   ON DLE.DET_SEQGER = GLE.AUTOINCREM ';
  Result := Result + '   AND DLE.DET_CODITE = D.DET_CODITE ';

  Result := Result + 'WHERE FIS_DTAENT <= :DTAFIN ';
  Result := Result + '  AND FIS_CODEMP = :CODEMP ';
  Result := Result + '  AND D.DET_CLAFIS < 5000 ';
  Result := Result + '  AND D.DET_CODITE = :CODITE ';
  Result := Result + 'HAVING DET_VAERET_UNIT > 0 ';
  Result := Result + 'ORDER BY FIS_DTAENT DESC ';
  Result := Result + 'LIMIT 1 ';
end;

end.
