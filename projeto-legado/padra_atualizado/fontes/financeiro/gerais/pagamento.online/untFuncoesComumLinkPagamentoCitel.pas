unit untFuncoesComumLinkPagamentoCitel;

interface

uses
  untInterfaceLinkPagamentoCitel ;

function fRetornaDocumentosByAutoInc(const ArecInfoDoc: TInfoDocumentoLinkPagamentoCitel;
                                     var AstrPrimeiroDocumento, AstrTipLan: String): String ;
function fRetornaTagName(const AstrPrimeiroDocumento, AstrTipLan: String): String ;
function fRetornaCodCliByAutoInc(const ArecInfoDoc: TInfoDocumentoLinkPagamentoCitel): String;
function fRetornaDiasExpiracaoLink(): Integer;

implementation

uses
  Data.DB, MemDS, DBAccess, Uni, System.Types, System.StrUtils,
  {$IFDEF LINUX}
     {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE}
     untFuncoesSimples,
  {$ENDIF}
  System.SysUtils, System.Variants;

function fRetornaDocumentosByAutoInc(
  const ArecInfoDoc: TInfoDocumentoLinkPagamentoCitel;
  var AstrPrimeiroDocumento, AstrTipLan: String): String;
var
  LqryConsulta: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX} ;
  LarrDocs: TStringDynArray ;
  LstrDocs: String ;
  LintCnt: Integer ;
  LstrRetorno: String ;
  LstrPrefixo: String ;
begin
  AstrPrimeiroDocumento := '' ;
  AstrTipLan := '' ;
  LstrDocs := '' ;
  LarrDocs := SplitString(ArecInfoDoc.Documentos, ',') ;
  for LintCnt := Low(LarrDocs) to High(LarrDocs) do
  begin
    LstrDocs := LstrDocs + IfThen(trim(LstrDocs) = '', '', ',') + quotedstr(Trim(LarrDocs[LintCnt])) ;
  end ;

  if trim(LstrDocs) = '' then
    Exit ;

  LqryConsulta := fCriaQuery ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    if ArecInfoDoc.Tipo = 'PD' then
    begin
      LstrPrefixo := 'Pedido(s): ' ;
      LqryConsulta.SQL.Add(' SELECT FGO_NUMDOC AS NUMDOC, FGO_ESPDOC AS ESPDOC, FGO_CODEMP AS CODEMP ') ;
      LqryConsulta.SQL.Add(' FROM FATGOR ') ;
      LqryConsulta.SQL.Add(' WHERE AUTOINCREM IN (' + LstrDocs + ') ') ;
    end
    else //agr
    begin
      LstrPrefixo := 'Agrupamento(s): ' ;
      LqryConsulta.SQL.Add(' SELECT CTR_NUMDUP AS NUMDOC, CTR_ESPDOC AS ESPDOC, CTR_CODEMP AS CODEMP ') ;
      LqryConsulta.SQL.Add(' FROM CADREC ') ;
      LqryConsulta.SQL.Add(' WHERE AUTOINCREM IN (' + LstrDocs + ') ') ;
    end ;
    LqryConsulta.Open ;

    LstrRetorno := '' ;
    LqryConsulta.First ;
    while not LqryConsulta.Eof do
    begin
      if trim(AstrPrimeiroDocumento) = '' then
      begin
        AstrPrimeiroDocumento := LqryConsulta.FieldByName('NUMDOC').AsString ;
        AstrTipLan := ArecInfoDoc.Tipo ;
      end ;

      LstrRetorno := LstrRetorno + IfThen(trim(LstrRetorno) = '', '', ', ') + Format('%s-%s-%s', [LqryConsulta.FieldByName('NUMDOC').AsString,
                                                                                                  LqryConsulta.FieldByName('ESPDOC').AsString,
                                                                                                  LqryConsulta.FieldByName('CODEMP').AsString]) ;

      LqryConsulta.Next ;
    end ;
    Result := LstrPrefixo + LstrRetorno ;
  finally
    {$IFNDEF LINUX} FreeAndNil(LqryConsulta) {$ENDIF LINUX}
  end ;
end;

function fRetornaCodCliByAutoInc(const ArecInfoDoc: TInfoDocumentoLinkPagamentoCitel): String;
var
  LqryConsulta: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX} ;
  LarrDocs: TStringDynArray ;
  LstrDocs: String ;
  LintCnt: Integer ;
begin
  LstrDocs := '' ;
  LarrDocs := SplitString(ArecInfoDoc.Documentos, ',') ;
  for LintCnt := Low(LarrDocs) to High(LarrDocs) do
  begin
    LstrDocs := LstrDocs + IfThen(trim(LstrDocs) = '', '', ',') + quotedstr(Trim(LarrDocs[LintCnt])) ;
  end ;

  if trim(LstrDocs) = '' then
    Exit ;

  LqryConsulta := fCriaQuery ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    if ArecInfoDoc.Tipo = 'PD' then
    begin
      LqryConsulta.SQL.Add(' SELECT DISTINCT FGO_CODCLI AS CODCLI ') ;
      LqryConsulta.SQL.Add(' FROM FATGOR ') ;
      LqryConsulta.SQL.Add(' WHERE AUTOINCREM IN (' + LstrDocs + ') ') ;
    end
    else //agr
    begin
      LqryConsulta.SQL.Add(' SELECT DISTINCT CTR_CODCLI AS CODCLI ') ;
      LqryConsulta.SQL.Add(' FROM CADREC ') ;
      LqryConsulta.SQL.Add(' WHERE AUTOINCREM IN (' + LstrDocs + ') ') ;
    end ;
    LqryConsulta.Open ;
    LqryConsulta.First ;
    Result := LqryConsulta.FieldByName('CODCLI').AsString ;
  finally
    {$IFNDEF LINUX} FreeAndNil(LqryConsulta) {$ENDIF LINUX}
  end ;
end;

function fRetornaDiasExpiracaoLink(): Integer;
var
  LValor: String;
begin
  LValor := VarToString(fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_LNKEXP', VS_strCodEmp], True));
  Result := StrToIntDef(LValor, 1);
end;

function fRetornaTagName(const AstrPrimeiroDocumento,
  AstrTipLan: String): String;
begin
  Result := 'Pedido_'+AstrPrimeiroDocumento ;
  if AstrTipLan = 'AGR' then
    Result := 'Agrupamento_'+AstrPrimeiroDocumento ;
end;

end.
