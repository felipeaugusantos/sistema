unit untCreditosFornecedor;

interface

Uses
  Classes,
  untZClient,
  untFuncoesSimples;

Type
  TCreditosFornecedor = Class(TZClient)
  Private
    FCodFor,
    FCodOpe: String;

    Procedure pSetCodFor(value: String);
    Procedure pSetCodOpe(value: String);

    Procedure pAbreConsulta;

    Function fSQLCreditos: String;
  Public

    constructor Create(Owner: TComponent); Reintroduce;

    Destructor Destroy; override;

    property strCodFor: String Read FCodFor Write pSetCodFor;
    property strCodOpe: String Read FCodOpe Write pSetCodOpe;

    Procedure pMostraCreditos;

  End;

implementation

Uses
  untFuncoesRel, untFuncoesRel2;

constructor TCreditosFornecedor.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, fSQLCreditos);

  FCodOpe := '';
  FCodFor := '';
End;

Destructor TCreditosFornecedor.Destroy;
Begin
  Inherited;

End;

Function TCreditosFornecedor.fSQLCreditos: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT   ';

  strSQL := strSQL + '   CONCAT(CTP_NUMDUP, IFNULL(CTP_PARCEL, ""), IFNULL(CTP_SERIE_, "")) AS NUMDUP, ';
  strSQL := strSQL + '   CTP_CODEMP AS CODEMP, ';
  strSQL := strSQL + '   CTP_DTACAD AS DTACAD, ';
  strSQL := strSQL + '   CTP_DTAVEN AS DTAVEN, ';
  strSQL := strSQL + '   ABS(CTP_VALDUP) AS VALDUP, ';
  strSQL := strSQL + '   CONCAT(CTP_CODCTA, "-", CTA_DESCTA) AS DESCTA ';

  strSQL := strSQL + ' FROM     ';
  strSQL := strSQL + '   CADPAG ';

  strSQL := strSQL + ' LEFT JOIN CADCTA ON CTA_CODCTA = CTP_CODCTA ';

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CTP_DTAPAG IS NULL AND ';
  strSQL := strSQL + '   CTP_VALDUP < 0 AND ';
  strSQL := strSQL + '   CTP_CODFOR = :CODFOR AND ';
  strSQL := strSQL + '   LOCATE(CTP_CODEMP, (SELECT OPE_EMPACE FROM CADOPE WHERE OPE_CODOPE = :CODOPE LIMIT 1)) > 0 ';

  strSQL := strSQL + ' ORDER BY CODEMP, DTACAD, DTAVEN ';

  Result := strSQL;
End;

Procedure TCreditosFornecedor.pAbreConsulta;
Begin
  If fEmptyStr(FCodOpe) Or fEmptyStr(FCodFor) Then
  Begin
    Self.Close;
  End Else
  Begin
    fAbreClient(True, 'TCreditosFornecedor.pAbreConsulta');

    pAlinhaCampoCentro('CODEMP');
    pAlinhaCampoCentro('DTACAD');
    pAlinhaCampoCentro('DTAVEN');
  End;
End;

Procedure TCreditosFornecedor.pSetCodFor(value: String);
Begin
  If Value <> FCodFor Then
  Begin
    FCodFor := Value;
    qryQuery.ParamByName('CODFOR').AsString := FCodFor;

    pAbreConsulta;
  End;
End;

Procedure TCreditosFornecedor.pSetCodOpe(value: String);
Begin
  If Value <> FCodOpe Then
  Begin
    FCodOpe := Value;
    qryQuery.ParamByName('CODOPE').AsString := FCodOpe;

    pAbreConsulta;
  End;
End;

Procedure TCreditosFornecedor.pMostraCreditos;
Begin

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(100, 5691, [],
                        ['CODFOR','CODOPE'],
                        [FCodFor,FCodOpe],
                        nil,
                        nil,
                        True);
  End;

End;


end.
