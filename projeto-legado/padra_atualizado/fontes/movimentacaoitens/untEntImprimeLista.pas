unit untEntImprimeLista;

interface

Uses
  Classes,
  SysUtils,
  Controls,
  ComCtrls,
  untZClient,
  untFuncoesSimples,
  Uni,
  Data.DB;

Type
  TEntImprimeLista = Class(TZClient)
  Private
    FIliEmp: Boolean;

  Public

     Function fSQLItens(strItens: String): String;
     Function fGravaLista: Boolean;

     constructor Create(Owner: TComponent; strItens: String); Reintroduce;

     Destructor Destroy; override;

     Procedure pMarcaTodos(strImpLis: String);

     Procedure pMostraItens;

 End;

implementation

Uses
  untEntMostraImprimeLista;

constructor TEntImprimeLista.Create(Owner: TComponent; strItens: String);
Begin
  Inherited Create(Owner, fSQLItens(strItens));

  fAbreClient(True, 'TEntImprimeLista.Create');

  FIliEmp := fCfgSis('ILIEMP', varBoolean);
End;

Destructor TEntImprimeLista.Destroy;
Begin
  Inherited;

End;

Function TEntImprimeLista.fSQLItens(strItens: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT   ';
  strSQL := strSQL + '   I.ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '   C.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '   I.ITE_IMPLIS AS IMPLIS  ';
  strSQL := strSQL + ' FROM     ';
  strSQL := strSQL + '   ITEGER I ';
  strSQL := strSQL + ' INNER JOIN CADITE C ON C.ITE_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '   I.ITE_IMPLIS = "N" AND ';
  strSQL := strSQL + '   I.ITE_CODITE IN (' + strItens + ') AND ';
  strSQL := strSQL + '   I.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  Result := strSQL;
End;


Function TEntImprimeLista.fGravaLista: Boolean;
  Var
    qryIteger: TUniQuery;
Begin
  Try
    fStartTransaction;

    Self.DisableControls;

    qryIteger := fCriaQuery(Self);
    With qryIteger, SQL Do
    Begin
      Clear;
      Add('UPDATE ITEGER ');
      Add('SET ITE_IMPLIS = :IMPLIS');
      Add('WHERE');
      Add('  ITE_CODITE = :CODITE');

      If FIliEmp Then
        Add('  AND ITE_CODEMP = :CODEMP');

      Self.First;
      While Not Self.Eof Do
      Begin
        ParamByName('CODITE').AsString := Self.FieldByName('CODITE').AsString;
        ParamByName('IMPLIS').AsString := Self.FieldByName('IMPLIS').AsString;

        If FIliEmp Then
          ParamByName('CODEMP').AsString := VS_strCodEmp;

        ExecSQL;

        Self.Next;
      End;

    End;
    FreeAndNil(qryIteger);

    fCommit;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[TEntImprimeLista.fGravaLista]');
    End;
  End;

  Self.EnableControls;
End;

Procedure TEntImprimeLista.pMarcaTodos(strImpLis: String);
Begin
  Try
    DisableControls;

    First;
    While Not Eof Do
    Begin
      Edit;
      FieldByName('IMPLIS').AsString := strImpLis;
      Post;

      Next;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TEntImprimeLista.pMarcaTodos]');
    End;
  End;

  EnableControls;
End;

Procedure TEntImprimeLista.pMostraItens;
Begin
  If Not IsEmpty Then
  Begin
    pCriarFormularios(TfrmEntMostraImprimeLista, frmEntMostraImprimeLista);
    frmEntMostraImprimeLista.objImpLis := Self;
    frmEntMostraImprimeLista.ShowModal;
    pFreeAndNil(frmEntMostraImprimeLista);
  End;
End;


end.
