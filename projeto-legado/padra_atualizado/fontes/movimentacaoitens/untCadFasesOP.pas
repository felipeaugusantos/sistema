unit untCadFasesOP;

interface

Uses
  Classes, SysUtils, Controls, DB,
  untFuncoesSimples, untZClient, Uni;

  Type
  TCadFasesOP = Class(TZClient)
    Private

      Function fSQLCadFasesOP(blnInclusao: Boolean; blnFormulaEspecial: Boolean = False; strAutInc: String = ''; strAutIncGeiMat: String = ''): String;
      Function fIncluiCadFasesOP(strCodFas, strAutInc: String): Boolean;
      Function fExcluiCadFasesOP(strCodFas, strAutInc: String): Boolean;

    Public

      constructor Create(Owner: TComponent); Reintroduce; Overload;
      Destructor Destroy; override;

      Function fCarregaCadFasesOP(strAutInc: String; blnInclusao: Boolean = False; blnFormulaEspecial: Boolean = False; strAutIncGeiMat: String = ''): Boolean;
      Function fSalvaCadFasesOP(strAutInc: String; strCodIte: String = ''; strCodCor: String = ''; strFormul: String = ''; blnBuscaFasesDaFormula: Boolean = False): Boolean;
      Function fTemFase: Boolean;

      Procedure pMarcaTodas(blnMarcar: Boolean);
  End;

implementation

constructor TCadFasesOP.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, '');
End;

Function TCadFasesOP.fSQLCadFasesOP(blnInclusao: Boolean; blnFormulaEspecial: Boolean = False; strAutInc: String = ''; strAutIncGeiMat: String = ''): String;
Begin
  If blnFormulaEspecial Then
  Begin
    Result := '';
    Result := Result + ' SELECT             ';
    Result := Result + '   CADFAS.FAS_CODFAS, ';
    Result := Result + '   CADFAS.FAS_DESFAS, ';

    If Not(fEmptyStr(strAutInc)) Then
      Result := Result + '   IF(O.FAS_SEQOPI IS NULL, "N", "S") AS FAS_UTILIZ '
    Else
      Result := Result + '   "S" AS FAS_UTILIZ ';

    Result := Result + ' FROM GEIFAS   ';
    Result := Result + '   INNER JOIN GEIMAT ON (GEIMAT.AUTOINCREM = GFA_SEQGER) ';
    Result := Result + '   INNER JOIN CADFAS ON (CADFAS.AUTOINCREM = GFA_FASSEQ) ';

    If Not(fEmptyStr(strAutInc)) Then
    Begin
      Result := Result + '   LEFT JOIN FASOPI O ON (O.FAS_CODFAS = CADFAS.FAS_CODFAS) AND ';
      Result := Result + '                         (O.FAS_SEQOPI = :AUTINC) ';
      Result := Result + '   GROUP BY CADFAS.FAS_CODFAS                         ';
    End
    Else
      Result := Result + ' WHERE GFA_SEQGER = :AUTINC';


    Result := Result + ' ORDER BY GEIFAS.GFA_SEQUEC ';
  End
  Else
  Begin
    Result := '';
    Result := Result + ' SELECT ';
    Result := Result + '   C.FAS_CODFAS, ';
    Result := Result + '   C.FAS_DESFAS,  ';

    If blnInclusao Then
      Result := Result + ' "S" AS FAS_UTILIZ '
    Else
      Result := Result + '   IF(O.FAS_SEQOPI IS NULL, "N", "S") AS FAS_UTILIZ ';

    Result := Result + ' FROM CADFAS C ';
    Result := Result + ' LEFT JOIN FASOPI O ON O.FAS_CODFAS = C.FAS_CODFAS AND ';
    Result := Result + '                       O.FAS_SEQOPI = :AUTINC ';
    Result := Result + ' ORDER BY C.FAS_SEQFAS ';

  End;
End;

Function TCadFasesOP.fCarregaCadFasesOP(strAutInc: String; blnInclusao: Boolean = False; blnFormulaEspecial: Boolean = False; strAutIncGeiMat: String = ''): Boolean;
Begin
  Try
    With qryQuery Do
    Begin
      If blnFormulaEspecial Then
      Begin
        SQL.Text := fSQLCadFasesOP(blnInclusao, True, strAutInc, strAutIncGeiMat);
        If Not(fEmptyStr(strAutInc)) Then
          ParamByName('AUTINC').AsString := strAutInc
        Else
          ParamByName('AUTINC').AsString := strAutIncGeiMat
      End
      Else
      Begin
        SQL.Text := fSQLCadFasesOP(blnInclusao);
        ParamByName('AUTINC').AsString := strAutInc;
      End;

      Result := fAbreClient(True, 'TCadFasesOP.fCarregaCadFasesOP');
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCadFasesOP.fCarregaCadFasesOP]');
    End;
  End;
End;

Function TCadFasesOP.fIncluiCadFasesOP(strCodFas, strAutInc: String): Boolean;
  Var
    qryFasOpi: TUniQuery;
Begin
  Try
    qryFasOpi := fCriaQuery;

    With qryFasOpi, SQL Do
    Begin
      Add('REPLACE INTO FASOPI');
      Add('(FAS_SEQOPI, FAS_CODFAS) VALUES');
      Add('(:SEQOPI, :CODFAS)');

      ParamByName('SEQOPI').AsString := strAutInc;
      ParamByName('CODFAS').AsString := strCodFas;

      ExecSQL;
    End;

    Result := True;

    FreeAndNil(qryFasOpi)

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCadFasesOP.fIncluiCadFasesOP]');
    End;
  End;
End;

Function TCadFasesOP.fExcluiCadFasesOP(strCodFas, strAutInc: String): Boolean;
  Var
    qryFasOpi: TUniQuery;
Begin
  Try

    qryFasOpi := fCriaQuery;

    With qryFasOpi, SQL Do
    Begin
      Add('DELETE FROM FASOPI');
      Add('WHERE');
      Add('  FAS_SEQOPI = :SEQOPI AND FAS_CODFAS = :CODFAS');

      ParamByName('SEQOPI').AsString := strAutInc;
      ParamByName('CODFAS').AsString := strCodFas;

      ExecSQL;
    End;

    Result := True;

    FreeAndNil(qryFasOpi)

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCadFasesOP.fExcluiCadFasesOP]');
    End;
  End;
End;

Function TCadFasesOP.fTemFase: Boolean;
Begin
  Result := Locate('FAS_UTILIZ', 'S', []) or (Not fCfgSis('TERFAS', varBoolean));
End;

Function TCadFasesOP.fSalvaCadFasesOP(strAutInc: String; strCodIte: String = ''; strCodCor: String = ''; strFormul: String = ''; blnBuscaFasesDaFormula: Boolean = False): Boolean;
CONST
  CONSULTA_FASES_FORMULA = ' SELECT D.DMT_CODFAS FROM GEIMAT G                   '+
                           '               INNER JOIN DEIMAT D ON (D.DMT_SEQGER = G.AUTOINCREM) '+
                           '                 WHERE D.DMT_CODFAS IS NOT NULL AND  '+
                           '                       G.GMT_CODITE = :CODITE AND    '+
                           '                       G.GMT_CODCOR = :CODCOR AND    '+
                           '                       G.GMT_FORMUL = :FORMUL AND    '+
                           '                       G.GMT_STATUS = "A"            '+
                           '                 GROUP BY D.DMT_CODFAS               ';
Var
  qryBusca: TUniQuery;
Begin
  Try
    Result := True;

    DisableControls;

    Try
      qryBusca:= fCriaQuery();

      If blnBuscaFasesDaFormula Then
      Begin
        qryBusca.SQL.Add(CONSULTA_FASES_FORMULA);
        qryBusca.ParamByName('CODITE').AsString:= strCodIte;
        qryBusca.ParamByName('CODCOR').AsString:= strCodCor;
        qryBusca.ParamByName('FORMUL').AsString:= strFormul;
        qryBusca.Open;

       qryBusca.First;
       While not qryBusca.Eof do
       Begin
         If Locate('FAS_CODFAS', qryBusca.FieldByName('DMT_CODFAS').AsString, []) Then
         Begin
           Edit;
           FieldByName('FAS_UTILIZ').AsString:= 'S';
           Post;
         End;

         qryBusca.Next;

        End;

      End;


      First;

      While Not Eof Do
      Begin
        If FieldByName('FAS_UTILIZ').AsString = 'S' Then
          Result := fIncluiCadFasesOP(FieldByName('FAS_CODFAS').AsString, strAutInc)
        Else
          Result := fExcluiCadFasesOP(FieldByName('FAS_CODFAS').AsString, strAutInc);

        if Not Result then
          Break;

        Next;
      End;

    Finally
      FreeAndNil(qryBusca);
    End;



  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCadFasesOP.fSalvaCadFasesOP]');
    End;
  End;

  EnableControls;
End;

Destructor TCadFasesOP.Destroy;
Begin
  Inherited;

End;

Procedure TCadFasesOP.pMarcaTodas(blnMarcar: Boolean);
Begin
  Try
    DisableControls;
    First;

    While Not Eof Do
    Begin
      Edit;
      if blnMarcar then
        FieldByName('FAS_UTILIZ').AsString := 'S'
      Else
        FieldByName('FAS_UTILIZ').AsString := 'N';
      Post;

      Next;
    End;

  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message, '[TCadFasesOP.pMarcaTodas]');
    End;
  End;

  EnableControls;
End;

end.
