unit untEntIcmsAntecipado;

interface

Uses
  Classes,
  ComCtrls,
  SysUtils,
  Forms,
  Uni,
  untZClient,
  Variants,
  untTypesSistema;

Type
  TIcmsAntecipado = Class(TZClient)
    Private
      FAlqFor: Double;
      FEstFor: String;
      FEmpEst: String;
      FCodFor: String;

      FGarantia,
      FRecCliGarantia,
      FContribuinteIPI,
      FUsaLotePrecos: Boolean;

      FConEqu: Boolean;

      FEntMer: TUniQuery;

      Function fSQLItens: String;
      Function fSQLItensVariasNotas: String;
      Function fSQLUpdateEntMer: String;
      Function fSQLMovDet: String;

      Procedure pCalculaIcmsAntecipado;
      Procedure pAtualizaEntrada(fltBasRet, fltValRet, fltBaERet, fltVaERet, fltBasAnt, fltValAnt, fltSubsti: Double; strClaFis, strCodFis: String);
      Procedure pDesmarcaAntecipadoFrete;

    Public

      constructor Create(Owner: TComponent; strCodFor, strEstFor: String;
                                            blnGarantia: Boolean;
                                            blnRecCliGarantia: Boolean;
                                            fltAlqFor: Double;
                                            blnConEqu: Boolean); Overload;

      constructor Create(Owner: TComponent; blnEntMer: Boolean); Overload;

      Function fCalculaIcmsAntecipado(prbProgresso: TProgressBar): Boolean;

      Function fSalvaIcmsAntecipadoFrete(prbProgresso: TProgressBar): Boolean;

      Function fIncluiItensNota(strNumDoc, strEspDoc, strSerie, strCodFor: String; prbProgresso: TProgressBar): Boolean;

      Procedure pExcluiItensNota(strNumDoc, strEspDoc, strSerie, strCodFor: String);

      Procedure pSalvaAntFre;
  End;


implementation

uses untConstantes, untFuncoesSimples, untFuncoes;

Function TIcmsAntecipado.fSQLItens: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';

  strSQL := strSQL + '   T.AUTOINCREM, ';
  strSQL := strSQL + '   ENT_CODITE, ';
  strSQL := strSQL + '   ENT_DESITE, ';
  strSQL := strSQL + '   ENT_REFERE, ';

  strSQL := strSQL + '   UNI_SIGUNI AS ENT_SIGUNI, ';

  strSQL := strSQL + '   ENT_CODFIS, ';

  strSQL := strSQL + '   IF(LOCATE(ENT_CODFIS, ' +  QuotedStr(CST_ANTECIPACAO_ICMS) + ') > 0, "S", "N") AS ENT_ANTPRO, ';
  strSQL := strSQL + '   IF(IFNULL(ENT_ANTFRE, "") NOT IN ("S", "N"), "S", ENT_ANTFRE) AS ENT_ANTFRE, ';

  strSQL := strSQL + '   ENT_BASRET, ';
  strSQL := strSQL + '   ENT_VALRET, ';
  strSQL := strSQL + '   ENT_BAERET, ';
  strSQL := strSQL + '   ENT_VAERET, ';
  strSQL := strSQL + '   ENT_CLAFIS, ';
  strSQL := strSQL + '   ENT_SUBSTI, ';
  strSQL := strSQL + '   ENT_CODABF, ';
  strSQL := strSQL + '   ENT_VLRCON, ';
  strSQL := strSQL + '   ENT_VALIPI  ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   TMP_ENTMER T ';

  strSQL := strSQL + ' LEFT JOIN CADUNI ON UNI_CODUNI = ENT_CODUNI ';

  strSQL := strSQL + ' WHERE ';

  strSQL := strSQL + '   LOCATE(ENT_CODFIS, ' +  QuotedStr(CST_ANTECIPACAO_ICMS + '_' + CST_SUBSTITUICAO) + ') > 0 ';

  Result := strSQL;
End;

Function TIcmsAntecipado.fSQLItensVariasNotas: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';

  strSQL := strSQL + '   "123456789012" AS ENT_NUMDOC, ';
  strSQL := strSQL + '   "NF"           AS ENT_ESPDOC, ';
  strSQL := strSQL + '   "12345678"     AS ENT_CODFOR, ';
  strSQL := strSQL + '   "12345"        AS ENT_SERIE_, ';
  strSQL := strSQL + '   C.AUTOINCREM,                 ';
  strSQL := strSQL + '   C.ITE_CODITE   AS ENT_CODITE, ';
  strSQL := strSQL + '   C.ITE_DESITE   AS ENT_DESITE, ';
  strSQL := strSQL + '   C.ITE_REFERE   AS ENT_REFERE, ';

  strSQL := strSQL + '   UNI_SIGUNI     AS ENT_SIGUNI, ';

  strSQL := strSQL + '   "123456"       AS ENT_CODFIS, ';
  strSQL := strSQL + '   "N"            AS ENT_ANTPRO, ';
  strSQL := strSQL + '   "S"            AS ENT_ANTFRE, ';
  strSQL := strSQL + '   "123456"       AS ENT_CLAFIS, ';
  strSQL := strSQL + '   0.0000         AS ENT_SUBSTI, ';
  strSQL := strSQL + '   "123456"       AS ENT_CODABF, ';
  strSQL := strSQL + '   0.0000         AS ENT_VLRCON, ';
  strSQL := strSQL + '   0.0000         AS ENT_VALIPI  ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADITE C ';

  strSQL := strSQL + ' LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';

  strSQL := strSQL + ' WHERE ';

  strSQL := strSQL + '   FALSE ';

  Result := strSQL;
End;

constructor TIcmsAntecipado.Create(Owner: TComponent; strCodFor,
                                                      strEstFor: String;
                                                      blnGarantia: Boolean;
                                                      blnRecCliGarantia: Boolean;
                                                      fltAlqFor: Double;
                                                      blnConEqu: Boolean);
Begin
  Inherited Create(Owner, fSQLItens);

  FCodFor   := strCodFor;
  FEstFor   := strEstFor;
  FGarantia := blnGarantia;
  FRecCliGarantia := blnRecCliGarantia;
  FConEqu   := blnConEqu;
  FAlqFor   := fltAlqFor;

  FContribuinteIPI := (fCfgSis('CONIPI', varBoolean));
  FUsaLotePrecos   := (fCfgSis('LOTPRE', varBoolean));
  FEmpEst          := fCadEmp('ESTADO');

  fAbreClient(True, 'TIcmsAntecipado.Create');

  pAlinhaCampoCentro('ENT_CODITE');
  pAlinhaCampoCentro('ENT_CODFIS');

  FEntMer := fCriaQuery(Self);
  FEntMer.SQL.Text := fSQLUpdateEntMer;
End;

constructor TIcmsAntecipado.Create(Owner: TComponent; blnEntMer: Boolean);
  Var
    strSQL: String;
Begin
  If blnEntMer Then
    strSQL := fSQLItens
  Else
    strSQL := fSQLItensVariasNotas;

  Inherited Create(Owner, strSQL);

  fAbreClient(True, 'TIcmsAntecipado.Create');

  pAlinhaCampoCentro('ENT_CODITE');
  pAlinhaCampoCentro('ENT_CODFIS');
End;


Function TIcmsAntecipado.fSQLUpdateEntMer: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' UPDATE TMP_ENTMER SET ';

  strSQL := strSQL + '  ENT_ANTPRO = :ANTPRO, ';
  strSQL := strSQL + '  ENT_ANTFRE = :ANTFRE, ';

  strSQL := strSQL + '  ENT_CLAFIS = :CLAFIS, ';
  strSQL := strSQL + '  ENT_CODFIS = :CODFIS, ';
  strSQL := strSQL + '  ENT_SUBSTI = :SUBSTI, ';

  strSQL := strSQL + '  ENT_BASRET = :BASRET, ';
  strSQL := strSQL + '  ENT_VALRET = :VALRET,  ';

  strSQL := strSQL + '  ENT_BAERET = :BAERET, ';
  strSQL := strSQL + '  ENT_VAERET = :VAERET,  ';

  strSQL := strSQL + '  ENT_BASANT = :BASANT, ';
  strSQL := strSQL + '  ENT_VALANT = :VALANT  ';

  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '   AUTOINCREM = :AUTINC ';

  Result := strSQL;
End;

Procedure TIcmsAntecipado.pAtualizaEntrada(fltBasRet, fltValRet, fltBaERet, fltVaERet, fltBasAnt, fltValAnt, fltSubsti: Double; strClaFis, strCodFis: String);
Begin
  FEntMer.Close;

  FEntMer.ParamByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;

  FEntMer.ParamByName('ANTPRO').AsString := FieldByName('ENT_ANTPRO').AsString;
  FEntMer.ParamByName('ANTFRE').AsString := FieldByName('ENT_ANTFRE').AsString;

  FEntMer.ParamByName('CLAFIS').AsString := strClaFis;
  FEntMer.ParamByName('CODFIS').AsString := strCodFis;

  FEntMer.ParamByName('BASRET').AsFloat  := fltBasRet;
  FEntMer.ParamByName('VALRET').AsFloat  := fltValRet;

  FEntMer.ParamByName('BAERET').AsFloat  := fltBaERet;
  FEntMer.ParamByName('VAERET').AsFloat  := fltVaERet;

  FEntMer.ParamByName('SUBSTI').AsFloat  := fltSubsti;
  FEntMer.ParamByName('BASANT').AsFloat  := fltBasAnt;
  FEntMer.ParamByName('VALANT').AsFloat  := fltValAnt;

  FEntMer.ExecSQL;
End;

Procedure TIcmsAntecipado.pCalculaIcmsAntecipado;
  Var
    fltBasAnt,
    fltValAnt,
    fltValIVA,

    fltBasIcm,
    fltAlqIcm,
    fltValIcm,
    fltAlqIcmRed,
    fltPerBas,
    fltPeBaST,
    fltAliSte,
    fltAliFCP,
    fltSubsti,

    fltBasRet,
    fltValRet,
    fltBaERet,
    fltVaERet: Double;

    strTipAbf: String;

    strClaFis,
    strCodFis: String;
    blnComLub,
    blnRedCargaMedia: Boolean;

Begin
  fltBasAnt := 0;
  fltValAnt := 0;

  strClaFis := FieldByName('ENT_CLAFIS').AsString;
  strCodFis := FieldByName('ENT_CODFIS').AsString;
  fltSubsti := FieldByName('ENT_SUBSTI').AsFloat;

  fltBasRet := FieldByName('ENT_BASRET').AsFloat;
  fltValRet := FieldByName('ENT_VALRET').AsFloat;
  fltBaERet := FieldByName('ENT_BAERET').AsFloat;
  fltVaERet := FieldByName('ENT_VAERET').AsFloat;

  strTipAbf := fGetTipoAbfFornecedor(FCodFor);

  If (FieldbyName('ENT_ANTPRO').AsString = 'S') Then
  Begin
    blnComLub := fCampotabela('ITE_COMLUB', 'CADITE', ['ITE_CODITE'], [FieldByname('ENT_CODITE').AsString]) = 'S';

    If fRetornaDadosFiscais(FEmpEst,
                            FContribuinteIPI,
                            FieldbyName('ENT_ANTPRO').AsString = 'S',
                            FieldByName('ENT_CODABF').AsString,
                            FieldByName('ENT_VLRCON').AsFloat,
                            FAlqFor,
                            FEstFor,
                            FCodFor,
                            fItemRevInd(FieldByname('ENT_CODITE').AsString, VS_StrCodEmp) = 'R',
                            strClaFis,
                            strCodFis,
                            fltBasIcm,
                            fltAlqIcm,
                            fltAlqIcmRed,
                            fltValIcm,
                            fltPerBas,
                            fltPeBaST,
                            fltAliSte,
                            fltAliFCP,
                            blnRedCargaMedia,
                            False,
                            True,
                            FGarantia,
                            FRecCliGarantia,
                            False,
                            '',
                            FConEqu,
                            False,
                            Nil,
                            False,
                            blnComLub) Then
     Begin

       fltValIVA := fRetornaPercIVA(FieldByName('ENT_CODABF').AsString, FEstFor, strTipAbf);

       fltBasAnt := fFormataFloat(((((FieldByName('ENT_VALIPI').AsFloat + FieldByName('ENT_VLRCON').AsFloat) * fltPeBaST) / 100) * fltValIVA), 2);

       fltValAnt := fRetornaValRet( FEmpEst, fltBasAnt, fltValIcm, fltAliSte);

       If fltValAnt < 0 Then
       Begin
         fltValAnt := 0;
         fltBasAnt := 0;
       End;

       If FUsaLotePrecos Then
         fltSubsti := fFormataFloat((fltValAnt / FieldByName('ENT_VLRCON').AsFloat * 100), 2);
     End;

    fltBasRet := 0;
    fltValRet := 0;
    fltBaERet := 0;
    fltVaERet := 0;
  End;

  pAtualizaEntrada(fltBasRet, fltValRet, fltBaERet, fltVaERet,
                   fltBasAnt, fltValAnt, fltSubsti, strClaFis, strCodFis);

End;

Function TIcmsAntecipado.fCalculaIcmsAntecipado(prbProgresso: TProgressBar): Boolean;
Begin
  Try
    DisableControls;

    prbProgresso.Position := 0;
    prbProgresso.Max      := RecordCount;
    prbProgresso.Visible  := True;
    Application.ProcessMessages;

    First;

    While Not Eof Do
    Begin

      pCalculaIcmsAntecipado;

      Next;

      prbProgresso.StepBy(1);
      Application.ProcessMessages;
    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TIcmsAntecipado.fCalculaIcmsAntecipado]');
    End;
  End;

  prbProgresso.Visible := False;
  EnableControls;
End;

Procedure TIcmsAntecipado.pDesmarcaAntecipadoFrete;
  Var
    qryUpdate: TUniQuery;
Begin
  qryUpdate := fCriaQuery(Self);

  With qryUpdate, SQL Do
  Begin
    Clear;
    Add('UPDATE TMP_ENTMER SET');
    Add(' ENT_ANTFRE = "N"');
    ExecSQL;
  End;

  FreeAndNil(qryUpdate);
End;

Function TIcmsAntecipado.fSalvaIcmsAntecipadoFrete(prbProgresso: TProgressBar): Boolean;
  Var
    qryUpdate: TUniQuery;
Begin
  Try
    DisableControls;

    qryUpdate := fCriaQuery(Self);
    With qryUpdate, SQL Do
    Begin
      Clear;
      Add('UPDATE TMP_ENTMER SET');
      Add('  ENT_ANTFRE = :ANTFRE');
      Add('WHERE');
      Add('  AUTOINCREM = :AUTINC');
    End;

    prbProgresso.Position := 0;
    prbProgresso.Max      := RecordCount;
    prbProgresso.Visible  := True;
    Application.ProcessMessages;

    pDesmarcaAntecipadoFrete;

    First;

    While Not Eof Do
    Begin
      qryUpdate.Close;
      qryUpdate.ParamByName('ANTFRE').AsString := FieldByName('ENT_ANTFRE').AsString;
      qryUpdate.ParamByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
      qryUpdate.ExecSQL;

      Next;

      prbProgresso.StepBy(1);
      Application.ProcessMessages;
    End;

    Result := True;


    FreeAndNil(qryUpdate);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TIcmsAntecipado.fCalculaIcmsAntecipado]');
    End;
  End;

  prbProgresso.Visible := False;
  EnableControls;
End;

Function TIcmsAntecipado.fSQLMovDet: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';

  strSQL := strSQL + '  DET_NUMDOC, ';
  strSQL := strSQL + '  DET_ESPDOC, ';
  strSQL := strSQL + '  DET_CODFOR, ';
  strSQL := strSQL + '  DET_SERIE_, ';

  strSQL := strSQL + '  D.AUTOINCREM, ';
  strSQL := strSQL + '  DET_CODITE, ';
  strSQL := strSQL + '  ITE_DESITE, ';
  strSQL := strSQL + '  ITE_REFERE, ';

  strSQL := strSQL + '  UNI_SIGUNI, ';

  strSQL := strSQL + '  DET_CODFIS, ';
  strSQL := strSQL + '  DET_ANTPRO, ';
  strSQL := strSQL + '  DET_ANTFRE  ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '  MOVDET D ';

  strSQL := strSQL + ' INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';

  strSQL := strSQL + ' LEFT JOIN CADITE ON ITE_CODITE = DET_CODITE ';

  strSQL := strSQL + ' LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';

  strSQL := strSQL + ' WHERE ';

  strSQL := strSQL + '   LOCATE(DET_CODFIS, ' +  QuotedStr(CST_ANTECIPACAO_ICMS + '_' + CST_SUBSTITUICAO) + ') > 0  AND ';

  strSQL := strSQL + '   DET_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '   DET_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '   DET_CODFOR = :CODFOR AND ';
  strSQL := strSQL + '   DET_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '   IFNULL(DET_SERIE_, "") = :SERIE_ ';

  Result := strSQL;
End;

Function TIcmsAntecipado.fIncluiItensNota(strNumDoc, strEspDoc, strSerie, strCodFor: String; prbProgresso: TProgressBar): Boolean;
  Var
    qryMovDet: TUniQuery;
Begin
  qryMovDet := fCriaQuery(Self);

  With qryMovDet Do
  Begin
    SQL.Text := fSQLMovDet;

    ParamByName('SERIE_').AsString := strSerie;
    ParamByName('CODFOR').AsString := strCodFor;
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    While Not Eof Do
    Begin
      Self.Insert;

      Self.FieldByName('ENT_NUMDOC').AsString := FieldByName('DET_NUMDOC').AsString;
      Self.FieldByName('ENT_ESPDOC').AsString := FieldByName('DET_ESPDOC').AsString;
      Self.FieldByName('ENT_CODFOR').AsString := FieldByName('DET_CODFOR').AsString;
      Self.FieldByName('ENT_SERIE_').AsString := FieldByName('DET_SERIE_').AsString;
      Self.FieldByName('AUTOINCREM').AsString := FieldByName('AUTOINCREM').AsString;
      Self.FieldByName('ENT_CODITE').AsString := FieldByName('DET_CODITE').AsString;
      Self.FieldByName('ENT_DESITE').AsString := FieldByName('ITE_DESITE').AsString;
      Self.FieldByName('ENT_REFERE').AsString := FieldByName('ITE_REFERE').AsString;
      Self.FieldByName('ENT_SIGUNI').AsString := FieldByName('UNI_SIGUNI').AsString;
      Self.FieldByName('ENT_CODFIS').AsString := FieldByName('DET_CODFIS').AsString;
      Self.FieldByName('ENT_ANTPRO').AsString := FieldByName('DET_ANTPRO').AsString;
      Self.FieldByName('ENT_ANTFRE').AsString := FieldByName('DET_ANTFRE').AsString;

      Self.Post;

      Next;
    End;
  End;

  FreeAndNil(qryMovDet);

  Result := True;
End;

Procedure TIcmsAntecipado.pExcluiItensNota(strNumDoc, strEspDoc, strSerie, strCodFor: String);
Begin

  While Locate('ENT_NUMDOC;ENT_ESPDOC;ENT_SERIE_;ENT_CODFOR',
               varArrayOf([strNumDoc, strEspDoc, strSerie, strCodFor]), []) Do
    Delete;

End;

Procedure TIcmsAntecipado.pSalvaAntFre;
  Var
    qryUpdate: TUniQuery;
Begin
  qryUpdate := fCriaQuery(Self);
  With qryUpdate, SQL Do
  Begin
    Clear;
    Add('UPDATE MOVTRI ');
    Add('  SET');
    Add('    DET_ANTFRE = :ANTFRE');
    Add('WHERE');
    Add('  DET_SEQGER = :AUTINC');
  End;

  First;
  While Not Eof Do
  Begin
    qryUpdate.Close;
    qryUpdate.ParamByName('ANTFRE').AsString := FieldByName('ENT_ANTFRE').AsString;
    qryUpdate.ParamByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
    qryUpdate.ExecSQL;

    Next;
  End;

  FreeAndNil(qryUpdate);
End;

end.
