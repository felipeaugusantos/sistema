unit untMovCdb;

interface

Uses
  Classes, UniClientDataSet, DB, SysUtils, Forms, Windows, Controls, Uni,
  untFuncoesSimples;

Type

  TCodigoBarras = Class(TObject)

  Private
    cdsMovCdb: TUniClientDataSet;

    Procedure pCriaMovCdb;

  Public

    Constructor Create;
    Destructor Destroy; Override;

    Procedure pAddCodBar(strCodBar, strCodIte: String; fltQtdIte:Double);
    Procedure pDelCodBar(strCodIte: String);
    Procedure pGravaMovCdb(strCodIte, strAutIncDet: String);

    Function fCodBarPreenchido: Boolean;
    Function fRetornaQtdIte(strAutIncDet: String) : Double;

  End;

implementation

{ TMovCdb }

constructor TCodigoBarras.Create;
begin
  pCriaMovCdb;
end;

destructor TCodigoBarras.Destroy;
begin
  cdsMovCdb.EmptyDataset;
  cdsMovCdb.Close;

  FreeAndNil(cdsMovCdb);
  inherited;
end;

function TCodigoBarras.fCodBarPreenchido: Boolean;
begin
  Result := Not cdsMovCdb.IsEmpty;
end;

function TCodigoBarras.fRetornaQtdIte(strAutIncDet: String): Double;
Var
  qryAux : TUniQuery;
begin

  qryAux := fCriaQuery;

  Try

    qryAux.Close;

    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT DET_QTDITE FROM MOVDET WHERE AUTOINCREM = :AUTINC');
    qryAux.ParamByName('AUTINC').AsString := strAutIncDet;
    qryAux.Open;

    Result := IIF(Not qryAux.IsEmpty, qryAux.FieldByName('DET_QTDITE').AsFloat, 0);

  Finally
    FreeAndNil(qryAux);
  End;

End;

procedure TCodigoBarras.pCriaMovCdb;
begin
  cdsMovCdb := TUniClientDataSet.Create(Nil);

  With cdsMovCdb.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CDB_CODBAR';
    DataType := ftString;
    Size     := 20;
  End;

  With cdsMovCdb.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CDB_CODITE';
    DataType := ftString;
    Size     := fTamCodIte;
  End;

  With cdsMovCdb.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CDB_QTDITE';
    DataType := ftString;
    Size     := 8;
  End;

  With cdsMovCdb.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CDB_GRAVAD';
    DataType := ftString;
    Size     := 1;
  End;

  cdsMovCdb.CreateDataSet;
  cdsMovCdb.IndexFieldNames := 'CDB_CODBAR';
end;

procedure TCodigoBarras.pDelCodBar(strCodIte: String);
begin
  With cdsMovCdb Do
  Begin
    If Locate('CDB_CODITE', strCodIte, []) Then
    Begin
      Filtered := False;
      Filter   := ' CDB_CODITE = ' + QuotedStr(strCodIte);
      Filtered := True;

      Delete;

      Filtered := False;
    End;
  End;
end;

procedure TCodigoBarras.pGravaMovCdb(strCodIte, strAutIncDet: String);
Var
  qryAux    : TUniQuery;
  fltQtdIte : Double;
begin

  If Not Assigned(cdsMovCdb) Then
    Exit;

  If (cdsMovCdb.FindField('CDB_CODBAR') = Nil) Or
     (cdsMovCdb.FindField('CDB_CODITE') = Nil) Or
     (cdsMovCdb.FindField('CDB_QTDITE') = Nil) Then
    Exit;

  Try

    qryAux := fCriaQuery;

    Try

      With cdsMovCdb Do
      Begin

        If Locate('CDB_CODITE', strCodIte, []) Then
        Begin

          Filtered := False;
          Filter   := ' CDB_CODITE = ' + QuotedStr(strCodIte);
          Filtered := True;

          fltQtdIte := fRetornaQtdIte(strAutIncDet);

          First;
          While Not EOF Do
          Begin

            If (FieldByName('CDB_GRAVAD').AsString = 'S') Then
            Begin
              Next;
              Continue;
            End;

            If (fFormataFloat(fltQtdIte, fCfgSis('DECQTD', VarInteger)) = fFormataFloat(cdsMovCdb.FieldByName('CDB_QTDITE').AsFloat, fCfgSis('DECQTD', VarInteger))) Then
            Begin

              With qryAux Do
              Begin

                SQL.Clear;
                SQL.Add('INSERT INTO MOVCDB ');
                SQL.Add(' (AUTOINCREM, ');
                SQL.Add('  CDB_SEQDET, ');
                SQL.Add('  CDB_CODBAR, ');
                SQL.Add('  CDB_QTDITE) ');
                SQL.Add('  VALUES      ');
                SQL.Add(' (:AUTINC,    ');
                SQL.Add('  :SEQDET,    ');
                SQL.Add('  :CODBAR,    ');
                SQL.Add('  :QTDITE)    ');

                ParamByName('AUTINC').AsString := fRetAutoIncrem('MOVCDB', VS_strCodEmp);
                ParamByName('SEQDET').AsString := strAutIncDet;
                ParamByName('CODBAR').AsString := cdsMovCdb.FieldByName('CDB_CODBAR').AsString;
                ParamByName('QTDITE').AsFloat  := cdsMovCdb.FieldByName('CDB_QTDITE').AsFloat;

                ExecSQL;

                cdsMovCdb.Edit;
                cdsMovCdb.FieldByName('CDB_GRAVAD').AsString := 'S';
                cdsMovCdb.Post;

                Exit;

              End;

            End;

            Next;

          End;

          Filtered := False;

        End;

      End;

    Except
      On E: Exception Do
      Begin
        qryAux.Cancel;
        pMensagensErro(E.Message, '[pGravaMovCdb]');
      End;
    End;

  Finally
    FreeAndNil(qryAux);
  End;
End;

procedure TCodigoBarras.pAddCodBar(strCodBar, strCodIte: String; fltQtdIte: Double);
begin

  With cdsMovCdb Do
  Begin

    Append;
    FieldByName('CDB_QTDITE').AsFloat  := fltQtdIte;
    FieldByName('CDB_CODBAR').AsString := strCodBar;
    FieldByName('CDB_CODITE').AsString := strCodIte;
    FieldByName('CDB_GRAVAD').AsString := 'N';
    Post;

  End;

end;

End.