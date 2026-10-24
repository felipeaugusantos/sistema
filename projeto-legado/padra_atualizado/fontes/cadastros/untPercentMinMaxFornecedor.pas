unit untPercentMinMaxFornecedor;

interface

Uses
  Classes,
  untZClient;

Type

  TPercentMinMaxFornecedor  = Class(TZClient)
  Private

     Function fSQLDados: String;

     Procedure pInicializaRegistros(strCodFor: String);

     Procedure pInsertReg(strCodFor, strNivGir, strNivCri: String; fltPerMin, fltPerMax, fltEleCon: Double);

  Public

    constructor Create(Owner: TComponent);

    Function fCarregaDados(strCodFor: String): Boolean;

    Function fSalvaDados(strCodFor: String): Boolean;

  End;


implementation

Uses
  DB,
  untFuncoesSimples;

constructor TPercentMinMaxFornecedor.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, fSQLDados);
End;

Function TPercentMinMaxFornecedor.fCarregaDados(strCodFor: String): Boolean;
Begin
  qryQuery.ParamByName('CODFOR').AsString := strCodFor;

  Result := fLeDados('TPercentMinMaxFornecedor.fCarregaDados');

  If Result Then
  Begin
    If IsEmpty Then
      pInicializaRegistros(strCodFor);

    pAlinhaCampoCentro('FOR_NIVGIR');
    pAlinhaCampoCentro('FOR_NIVCRI');
  End;

End;

Function TPercentMinMaxFornecedor.fSQLDados: String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  strSQL := strSQL + ' SELECT   ';
  strSQL := strSQL + '   *      ';
  strSQL := strSQL + ' FROM     ';
  strSQL := strSQL + '   MINMAX ';
  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '   FOR_CODFOR = :CODFOR ';

  Result := strSQL;
End;


Procedure TPercentMinMaxFornecedor.pInsertReg(strCodFor, strNivGir, strNivCri: String; fltPerMin, fltPerMax, fltEleCon: Double);
Begin
  Insert;

  If Not fEmptyStr(strCodFor) Then
    FieldByName('FOR_CODFOR').AsString := strCodFor;

  FieldByName('FOR_NIVGIR').AsString := strNivGir;
  FieldByName('FOR_NIVCRI').AsString := strNivCri;
  FieldByName('FOR_PERMIN').AsFloat  := fltPerMin;
  FieldByName('FOR_PERMAX').AsFloat  := fltPerMax;
  FieldByName('FOR_ELECON').AsFloat  := fltEleCon;

  Post;
End;

Procedure TPercentMinMaxFornecedor.pInicializaRegistros(strCodFor: String);
Begin
  pInsertReg(strCodFor, 'A', 'X', 0, 0, 0);
  pInsertReg(strCodFor, 'A', 'Y', 0, 0, 0);
  pInsertReg(strCodFor, 'A', 'Z', 0, 0, 0);

  pInsertReg(strCodFor, 'B', 'X', 0, 0, 0);
  pInsertReg(strCodFor, 'B', 'Y', 0, 0, 0);
  pInsertReg(strCodFor, 'B', 'Z', 0, 0, 0);

  pInsertReg(strCodFor, 'C', 'X', 0, 0, 0);
  pInsertReg(strCodFor, 'C', 'Y', 0, 0, 0);
  pInsertReg(strCodFor, 'C', 'Z', 0, 0, 0);
End;

Function TPercentMinMaxFornecedor.fSalvaDados(strCodFor: String): Boolean;
Begin
  DisableControls;

  Try
    First;
    While Not Eof Do
    Begin
      Edit;

      If FieldByName('AUTOINCREM').IsNull Then
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('MINMAX', VS_strCodEmp);

      If FieldByName('FOR_CODFOR').IsNull Then
        FieldByName('FOR_CODFOR').AsString := strCodFor;

      Post;

      Next;
    End;

    Result := fSalva;

  Finally

    EnableControls;

  End;

End;

end.
