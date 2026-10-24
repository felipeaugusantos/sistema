unit untFiliasAutonomasFornecedor;

interface

Uses
  Uni, DB, Classes,
  CxProgressBar,
  untZClient;

Type

  TFiliasAutonomasFornecedor = Class(TZClient)
  Private

    Function fSQLAutonomas: String;

    Procedure pCompletaAutonomas(strCodFor: String);

  Public

    constructor Create(Owner: TComponent); Reintroduce;

    Destructor  Destroy; Override;

    Function fCarregaDados(strCodFor: String): Boolean;

    Function fSalvaDados(strCodFor: String): Boolean;

    Procedure pMarcaTodas(blnMarcar: Boolean);


  End;

implementation

Uses
  SysUtils,
  untFuncoesSimples,
  untParametrosEmpresa;

constructor TFiliasAutonomasFornecedor.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, fSQLAutonomas);
End;

Destructor TFiliasAutonomasFornecedor.Destroy;
Begin
  inherited Destroy;
End;

Function TFiliasAutonomasFornecedor.fSQLAutonomas: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT        ';
  strSQL := strSQL + '   A.*,        ';
  strSQL := strSQL + '   EMP_NOMEMP AS NOMEMP, ';
  strSQL := strSQL +     TParametrosEmpresa.fSQLTipoEmpresa + ' AS TIPEMP, ';
  strSQL := strSQL + '   "S" AS AUTONO  ';
  strSQL := strSQL + ' FROM             ';
  strSQL := strSQL + '   AUTFOR A       ';

  strSQL := strSQL + ' LEFT JOIN CADEMP ON EMP_CODEMP = AUT_CODEMP ';
  strSQL := strSQL + ' LEFT JOIN EMPPAR ON PAR_CODEMP = EMP_CODEMP ';

  strSQL := strSQL + ' WHERE         ';
  strSQL := strSQL + '   AUT_CODFOR = :CODFOR ';

  Result := strSQL;
End;

Function TFiliasAutonomasFornecedor.fCarregaDados(strCodFor: String): Boolean;
Begin
  qryQuery.ParamByName('CODFOR').AsString := strCodFor;

  Result := fLeDados('TFiliasAutonomasFornecedor.fCarregaDados');

  If Result Then
  Begin
    IndexFieldNames := 'AUT_CODEMP';
    pCompletaAutonomas(strCodFor);

    pAlinhaCampoCentro('AUT_CODEMP');
    pAlinhaCampoCentro('TIPEMP');
  End;

End;

Procedure TFiliasAutonomasFornecedor.pCompletaAutonomas(strCodFor: String);
  Var
    qryAutonomas: TUniQuery;
    strSQL: String;
Begin
  qryAutonomas := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   EMP_CODEMP, ';
  strSQL := strSQL + '   EMP_NOMEMP, ';
  strSQL := strSQL +     TParametrosEmpresa.fSQLTipoEmpresa + ' AS TIPEMP ';
  strSQL := strSQL + ' FROM        ';
  strSQL := strSQL + '   CADEMP    ';
  strSQL := strSQL + ' INNER JOIN EMPPAR ON PAR_CODEMP = EMP_CODEMP ';
  strSQL := strSQL + ' LEFT  JOIN AUTFOR ON AUT_CODEMP = EMP_CODEMP AND AUT_CODFOR = :CODFOR ';
  strSQL := strSQL + ' WHERE           ';
  strSQL := strSQL + '   PAR_TIPEMP = 2 AND AUT_CODEMP IS NULL';

  qryAutonomas.SQL.Text := strSQL;

  qryAutonomas.ParamByName('CODFOR').AsString := strCodFor;

  qryAutonomas.Open;

  While Not qryAutonomas.Eof Do
  Begin
    Self.Append;

    Self.FieldByName('AUT_CODEMP').AsString := qryAutonomas.FieldByName('EMP_CODEMP').AsString;
    Self.FieldByName('AUT_CODFOR').AsString := strCodFor;
    Self.FieldByName('AUTONO').AsString     := 'N';
    Self.FieldByName('NOMEMP').AsString     := qryAutonomas.FieldByName('EMP_NOMEMP').AsString;
    Self.FieldByName('TIPEMP').AsString     := qryAutonomas.FieldByName('TIPEMP').AsString;

    Self.Post;

    qryAutonomas.Next;
  End;

  FreeAndNil(qryAutonomas);
End;

Function TFiliasAutonomasFornecedor.fSalvaDados(strCodFor: String): Boolean;
Begin
  DisableControls;

  Try
    First;
    While Not Eof Do
    Begin

      If FieldByName('AUTONO').AsString = 'N' Then
      Begin

        Delete;

      End Else
      Begin

        If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
        Begin
          Edit;
          FieldByName('AUT_CODFOR').AsString := strCodFor;
          FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('AUTFOR', VS_strCodEmp);
          Post;
        End;

        Next;

      End;

    End;

    Result := fSalva;

    pCompletaAutonomas(strCodFor);

  Finally
    EnableControls;
  End;
End;

Procedure TFiliasAutonomasFornecedor.pMarcaTodas(blnMarcar: Boolean);
Begin
  DisableControls;

  Try

    First;

    While Not Eof Do
    Begin
      Edit;
      FieldByName('AUTONO').AsString := IIF(blnMarcar, 'S', 'N');
      Post;

      Next;
    End;


  Finally
    EnableControls;
  End;
End;

end.
