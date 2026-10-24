unit untLogFormulaAlterada;

interface

uses classes, System.SysUtils, untFuncoesSimples, UniClientDataSet, Uni,
     System.Variants, FireDAC.Comp.Client, Data.DB;

Type
   TLogFormulaAlterada = Class

   private

     FCodIte  : String;
     FDesSub  : String;
     FCodEmp  : String;
     FForMul  : String;
     FDtaHra  : String;
     FCodOpe  : String;
     FIteSub  : String;
     FInfNov  : String;
     FInfAnt  : String;
     FCodFas  : String;
     FSequen  : String;
     FSubQtd  : String;
     FPerTol  : String;
     FSeqOld  : String;
     FFormat  : String;
     FForEsp  : String;
     FStatus  : String;
     FOBS001  : String;
     FOBS002  : String;
     FOBS003  : String;
     FOBS004  : String;
     FOBS005  : String;
     FOBS006  : String;
     FOBS007  : String;

     FPesRea  : String;

     FCodCor  : String;
     FTabTem  : TFDMemTable;
     FGravaBanco: Boolean;

     FDataSet: TUniClientDataSet;
     FDataSetFormula: TUniQuery;
     FDataSetSeqOriMat : TUniClientDataSet;

   public

     property strCodIte    : String  read FCodIte     write FCodIte;
     property strDesSub    : String  read FDesSub     write FDesSub;
     property strCodEmp    : String  read FCodEmp     write FCodEmp;
     property strForMul    : String  read FForMul     write FForMul;
     property strDtaHra    : String  read FDtaHra     write FDtaHra;
     property strCodOpe    : String  read FCodOpe     write FCodOpe;
     property strIteSub    : String  read FIteSub     write FIteSub;

     property strCodFas    : String  read FCodFas     write FCodFas;
     property strSequen    : String  read FSequen     write FSequen;
     property strSubQtd    : String  read FSubQtd     write FSubQtd;
     property strPerTol    : String  read FPerTol     write FPerTol;

     property strSeqOld    : String  read FSeqOld     write FSeqOld;
     property strForEsp    : String  read FForEsp     write FForEsp;
     property strStatus    : String  read FStatus     write FStatus;
     property strObs001    : String  read FObs001     write FObs001;
     property strObs002    : String  read FObs002     write FObs002;
     property strObs003    : String  read FObs003     write FObs003;
     property strObs004    : String  read FObs004     write FObs004;
     property strObs005    : String  read FObs005     write FObs005;
     property strObs006    : String  read FObs006     write FObs006;
     property strObs007    : String  read FObs007     write FObs007;

     property strPesRea    : String  read FPesRea     write FPesRea;

     property strCodCor    : String  read FCodCor     write FCodCor;

     property blnGravaBanco: Boolean read FGravaBanco write FGravaBanco;

     property dftTabTem: TFDMemTable read FTabTem write FTabTem;

     property cdsDataSet : TUniClientDataSet  read FDataSet  write FDataSet;
     property cdsDataSetFormula: TUniQuery  read FDataSetFormula write FDataSetFormula;
     property cdsDataSetSeqOriMat : TUniClientDataSet  read FDataSetSeqOriMat  write FDataSetSeqOriMat;

     procedure pGravaLogFormula(blnDelete: Boolean = False; blnInclusao: Boolean = False;
                                blnInclusaoFormula: Boolean = False; blnEMateriaPrima: Boolean = False;
                                blnIncComentario: Boolean = False);

     procedure pIncluiRegistroAlterado(strCodCor: String = ''; strCodIte: String = ''; strCodEmp: String = '';
                                       strForMul: String = ''; strDtaHra: String = '';
                                       strCodOpe: String = ''; strIteSub: String = '';
                                       strInfNov: String = ''; strInfAnt: String = '';
                                       strTipo: String = '');

     procedure pIncluiSequenciaOriginalMateriaPrima(strAutInc: String; strIteSub: String = ''; strSequen: String = '';
                                                    strSeqIte: String = ''; blnMovendoItem: boolean = False);
     procedure pLimpaDataSetSequenciaOriginalMateriaPrima;

     procedure pGravaSequenciaTabelaLogTemp;

     constructor Create;

End;

implementation

CONST
  DEC_PERCENTUAL : Integer = 4;


{ TLogFormulaAlterada }

constructor TLogFormulaAlterada.Create;
begin
  FCodIte  := '';
  FCodEmp  := '';
  FForMul  := '';
  FDtaHra  := '';
  FCodOpe  := '';
  FIteSub  := '';
  FInfNov  := '';
  FInfAnt  := '';
  FCodFas  := '';
  FSequen  := '';
  FSubQtd  := '';
  FPerTol  := '';
  FSeqOld  := '';
  FCodCor  := '';

  FForEsp  := '';
  FStatus  := '';
  FOBS001  := '';
  FOBS002  := '';
  FOBS003  := '';
  FOBS004  := '';
  FOBS005  := '';
  FOBS006  := '';
  FOBS007  := '';

  FPesRea  := '';

  FDataSet:= Nil;
  FDataSetFormula:= Nil;

  FDataSetSeqOriMat:= TUniClientDataSet.Create(Nil);
  FDataSetSeqOriMat.FieldDefs.Add('DMT_ITESUB', ftString, 7);
  FDataSetSeqOriMat.FieldDefs.Add('DMT_SEQUEN', ftString, 5);
  FDataSetSeqOriMat.FieldDefs.Add('DMT_SEQNEW', ftString, 5);
  FDataSetSeqOriMat.FieldDefs.Add('DMT_SEQITE', ftString, 5);
  FDataSetSeqOriMat.FieldDefs.Add('DMT_SEQITN', ftString, 5);
  FDataSetSeqOriMat.FieldDefs.Add('AUTOINCREM', ftString, 20);

  FDataSetSeqOriMat.CreateDataSet;

  FTabTem:= Nil;

  FFormat := fMskDigitos(DEC_PERCENTUAL);

  FGravaBanco:= False;

end;

procedure TLogFormulaAlterada.pGravaLogFormula(blnDelete: Boolean = False; blnInclusao: Boolean = False;
                                               blnInclusaoFormula: Boolean = False; blnEMateriaPrima: Boolean = False;
                                               blnIncComentario: Boolean = False);
Begin
    FInfNov:= '';
    FInfAnt := '';

    If FGravaBanco Then
      pIncluiRegistroAlterado
    Else
    Begin

      If blnInclusao Then
      Begin
        If (blnIncComentario) Then
        Begin
          If strDesSub <> FDataSet.FieldByName('DMT_DESCRI').AsString Then
          Begin
            FInfNov := strDesSub;
            FInfAnt := FDataSet.FieldByName('DMT_DESCRI').AsString;
            pIncluiRegistroAlterado(FCodCor, FCodIte, FCodEmp, FForMul, FDtaHra, FCodOpe, FIteSub, FInfNov, FInfAnt, 'COMENTÁRIO ALTERADO');
          End;
        End
        Else
        Begin
          If Not(FEmptyStr(FIteSub)) Then
            pIncluiRegistroAlterado(FCodCor, FCodIte, FCodEmp, FForMul, FDtaHra, FCodOpe, FIteSub, FInfNov, FInfAnt, 'ITEM INCLUÍDO');
        End;
      End
      Else
      If blnInclusaoFormula Then
      Begin
        pIncluiRegistroAlterado(FCodCor, FCodIte, FCodEmp, FForMul, FDtaHra, FCodOpe, FIteSub, FInfNov, FInfAnt, 'FORMULA INCLUÍDA');
      End
      Else
      If blnDelete Then
      Begin
        If blnEMateriaPrima Then
          pIncluiRegistroAlterado(FCodCor, FCodIte, FCodEmp, FForMul, FDtaHra, FCodOpe, FIteSub, FInfNov, FInfAnt, 'ITEM EXCLUÍDO')
        Else
          pIncluiRegistroAlterado(FCodCor, FCodIte, FCodEmp, FForMul, FDtaHra, FCodOpe, FIteSub, FInfNov, FInfAnt, 'FORMULA EXCLUÍDA');
      End
      Else
      If blnEMateriaPrima Then
      Begin
        If FDataSet.Locate('DMT_ITESUB;DMT_SEQUEN', VarArrayOf([
                             FDataSet.FieldByName('DMT_ITESUB').AsString,
                             FSeqOld]), []) Or
           FDataSet.Locate('DMT_ITESUB;DMT_SEQUEN', VarArrayOf([
                             FDataSet.FieldByName('DMT_ITESUB').AsString,
                             FSequen]), []) Then
        Begin

          If strIteSub <> FDataSet.FieldByName('DMT_ITESUB').AsString Then
          Begin
            FInfNov := strIteSub;
            FInfAnt := FDataSet.FieldByName('DMT_ITESUB').AsString;

            pIncluiRegistroAlterado(FCodCor, FCodIte, FCodEmp, FForMul, FDtaHra, FCodOpe, FIteSub, FInfNov, FInfAnt, 'ALTERAÇÃO DO ITEM');
          End;


          If strCodFas <> FDataSet.FieldByName('DMT_CODFAS').AsString Then
          Begin
            FInfNov := strCodFas;
            FInfAnt := FDataSet.FieldByName('DMT_CODFAS').AsString;

            pIncluiRegistroAlterado(FCodCor, FCodIte, FCodEmp, FForMul, FDtaHra, FCodOpe, FIteSub, FInfNov, FInfAnt, 'FASE');
          End;

          strPerTol := FormatFloat(FFormat, StrToCurr(strPerTol));
          If strPerTol <> FormatFloat(FFormat, StrToCurr(FDataSet.FieldByName('DMT_PERTOL').AsString)) Then
          Begin
            FInfNov := strPerTol;
            FInfAnt := FormatFloat(FFormat, StrToCurr(FDataSet.FieldByName('DMT_PERTOL').AsString));

            pIncluiRegistroAlterado(FCodCor, FCodIte, FCodEmp, FForMul, FDtaHra, FCodOpe, FIteSub, FInfNov, FInfAnt, 'TOLERANCIA');
          End;

          strSubQtd := FormatFloat(FFormat, StrToCurr(strSubQtd));
          If strSubQtd <> FormatFloat(FFormat, StrToCurr(FDataSet.FieldByName('DMT_QTDITE').AsString)) Then
          Begin
            FInfNov := strSubQtd;
            FInfAnt := FormatFloat(FFormat, StrToCurr(FDataSet.FieldByName('DMT_QTDITE').AsString));

            pIncluiRegistroAlterado(FCodCor, FCodIte, FCodEmp, FForMul, FDtaHra, FCodOpe, FIteSub, FInfNov, FInfAnt, 'PERCENTUAL');
          End;

        End;
      End
      Else
      Begin
        If FDataSetFormula.Locate('GMT_CODEMP;GMT_CODITE;GMT_FORMUL', VarArrayOf([
                             FCodEmp,
                             FCodIte,
                             FForMul]), []) Then
        Begin
          If strForEsp <> IIF(FDataSetFormula.FieldByName('GMT_FORESP').AsString = '1', 1, 0) Then
          Begin
            FInfNov := strForEsp;
            FInfAnt := IIF(FDataSetFormula.FieldByName('GMT_FORESP').AsString = '1', 1, 0);

            pIncluiRegistroAlterado(FCodCor, FCodIte, FCodEmp, FForMul, FDtaHra, FCodOpe, FIteSub, FInfNov, FInfAnt, 'FORMULA ESPECIAL');
          End;

          If strStatus <> FDataSetFormula.FieldByName('GMT_STATUS').AsString Then
          Begin
            FInfNov := strStatus;
            FInfAnt := FDataSetFormula.FieldByName('GMT_STATUS').AsString;

            pIncluiRegistroAlterado(FCodCor, FCodIte, FCodEmp, FForMul, FDtaHra, FCodOpe, FIteSub, FInfNov, FInfAnt, 'STATUS');
          End;

          If strObs007 <> FDataSetFormula.FieldByName('GMT_OBS007').AsString Then
          Begin
            FInfNov := strObs007;
            FInfAnt := FDataSetFormula.FieldByName('GMT_OBS007').AsString;

            pIncluiRegistroAlterado(FCodCor, FCodIte, FCodEmp, FForMul, FDtaHra, FCodOpe, FIteSub, FInfNov, FInfAnt, 'OBSERVAÇÃO 007');
          End;

          If strObs006 <> FDataSetFormula.FieldByName('GMT_OBS006').AsString Then
          Begin
            FInfNov := strObs006;
            FInfAnt := FDataSetFormula.FieldByName('GMT_OBS006').AsString;

            pIncluiRegistroAlterado(FCodCor, FCodIte, FCodEmp, FForMul, FDtaHra, FCodOpe, FIteSub, FInfNov, FInfAnt, 'OBSERVAÇÃO 006');
          End;

          If strObs005 <> FDataSetFormula.FieldByName('GMT_OBS005').AsString Then
          Begin
            FInfNov := strObs005;
            FInfAnt := FDataSetFormula.FieldByName('GMT_OBS005').AsString;

            pIncluiRegistroAlterado(FCodCor, FCodIte, FCodEmp, FForMul, FDtaHra, FCodOpe, FIteSub, FInfNov, FInfAnt, 'OBSERVAÇÃO 005');
          End;

          If strObs004 <> FDataSetFormula.FieldByName('GMT_OBS004').AsString Then
          Begin
            FInfNov := strObs004;
            FInfAnt := FDataSetFormula.FieldByName('GMT_OBS004').AsString;

            pIncluiRegistroAlterado(FCodCor, FCodIte, FCodEmp, FForMul, FDtaHra, FCodOpe, FIteSub, FInfNov, FInfAnt, 'OBSERVAÇÃO 004');
          End;

          If strObs003 <> FDataSetFormula.FieldByName('GMT_OBS003').AsString Then
          Begin
            FInfNov := strObs003;
            FInfAnt := FDataSetFormula.FieldByName('GMT_OBS003').AsString;

            pIncluiRegistroAlterado(FCodCor, FCodIte, FCodEmp, FForMul, FDtaHra, FCodOpe, FIteSub, FInfNov, FInfAnt, 'OBSERVAÇÃO 003');
          End;

          If strObs002 <> FDataSetFormula.FieldByName('GMT_OBS002').AsString Then
          Begin
            FInfNov := strObs002;
            FInfAnt := FDataSetFormula.FieldByName('GMT_OBS002').AsString;

            pIncluiRegistroAlterado(FCodCor, FCodIte, FCodEmp, FForMul, FDtaHra, FCodOpe, FIteSub, FInfNov, FInfAnt, 'OBSERVAÇÃO 004');
          End;

          If strObs001 <> FDataSetFormula.FieldByName('GMT_OBS001').AsString Then
          Begin
            FInfNov := strObs001;
            FInfAnt := FDataSetFormula.FieldByName('GMT_OBS001').AsString;

            pIncluiRegistroAlterado(FCodCor, FCodIte, FCodEmp, FForMul, FDtaHra, FCodOpe, FIteSub, FInfNov, FInfAnt, 'OBSERVAÇÃO 001');
          End;

          If strPesRea <> FormatFloat(FFormat, StrToCurr(FDataSetFormula.FieldByName('GMT_PESREA').AsString)) Then
          Begin
            FInfNov := strPesRea;
            FInfAnt := FormatFloat(FFormat, StrToCurr(FDataSetFormula.FieldByName('GMT_PESREA').AsString));

            pIncluiRegistroAlterado(FCodCor, FCodIte, FCodEmp, FForMul, FDtaHra, FCodOpe, FIteSub, FInfNov, FInfAnt, 'PESO REAL');
          End;
        End;
      End;

    End;

End;

procedure TLogFormulaAlterada.pIncluiRegistroAlterado(strCodCor: String = ''; strCodIte: String = ''; strCodEmp: String = '';
                                       strForMul: String = ''; strDtaHra: String = '';
                                       strCodOpe: String = ''; strIteSub: String = '';
                                       strInfNov: String = ''; strInfAnt: String = '';
                                       strTipo  : String = '');

var
  qryDados:TUniQuery;
Begin
  If FGravaBanco Then
  Begin
    qryDados:= fCriaQuery();
    Try

      qryDados.Close;
      qryDados.SQL.Clear;
      qryDados.SQL.Add(' INSERT INTO LOGFOR(AUTOINCREM, LGF_CODCOR, LGF_CODITE, LGF_CODEMP, LGF_FORMUL, ');
      qryDados.SQL.Add('                    LGF_DTAHRA, LGF_CODOPE, LGF_ITESUB, LGF_INFALT, ');
      qryDados.SQL.Add('                    LGF_VALANT, LGF_VALATU)                         ');
      qryDados.SQL.Add(' VALUES(:AUTINC, :CODCOR, :CODITE, :CODEMP, :FORMUL, :DTAHRA, :CODOPE,       ');
      qryDados.SQL.Add('        :ITESUB, :INFALT, :VALANT, :VALATU)                         ');

      FTabTem.First;
      while Not(FTabTem.Eof) do
      Begin

        qryDados.ParamByName('AUTINC').AsString  := fRetAutoIncrem('LOGFOR', FCodEmp);
        qryDados.ParamByName('CODITE').AsString  := FTabTem.FieldByName('LGF_CODITE').AsString;
        qryDados.ParamByName('CODCOR').AsString  := FTabTem.FieldByName('LGF_CODCOR').AsString;
        qryDados.ParamByName('CODEMP').AsString  := FTabTem.FieldByName('LGF_CODEMP').AsString;
        qryDados.ParamByName('FORMUL').AsString  := FTabTem.FieldByName('LGF_FORMUL').AsString;
        qryDados.ParamByName('DTAHRA').AsDateTime:= FTabTem.FieldByName('LGF_DTAHRA').AsDateTime;
        qryDados.ParamByName('CODOPE').AsString  := FTabTem.FieldByName('LGF_CODOPE').AsString;

        If Not(fEmptyStr(FTabTem.FieldByName('LGF_ITESUB').AsString)) Then
          qryDados.ParamByName('ITESUB').AsString  := FTabTem.FieldByName('LGF_ITESUB').AsString
        Else
          qryDados.ParamByName('ITESUB').Value  := Null;

        qryDados.ParamByName('INFALT').AsString  := FTabTem.FieldByName('LGF_INFALT').AsString;
        qryDados.ParamByName('VALANT').AsString  := FTabTem.FieldByName('LGF_VALANT').AsString;
        qryDados.ParamByName('VALATU').AsString  := FTabTem.FieldByName('LGF_VALATU').AsString;
        qryDados.ExecSQL;

        FTabTem.Next;

      End;

    Finally
      FreeAndNil(qryDados);
    End;
  End
  Else
  Begin

    If Not(FTabTem.Active) Then
      FTabTem.Open;

    FTabTem.Insert;
    FTabTem.FieldByName('LGF_CODITE').AsString  := FCodIte;
    FTabTem.FieldByName('LGF_CODCOR').AsString  := FCodCor;
    FTabTem.FieldByName('LGF_CODEMP').AsString  := FCodEmp;
    FTabTem.FieldByName('LGF_FORMUL').AsString  := FForMul;
    FTabTem.FieldByName('LGF_DTAHRA').AsDateTime:= strToDateTime(FDtaHra);
    FTabTem.FieldByName('LGF_CODOPE').AsString  := FCodOpe;

    If Not(fEmptyStr(FIteSub)) Then
      FTabTem.FieldByName('LGF_ITESUB').AsString  := FIteSub
    Else
      FTabTem.FieldByName('LGF_ITESUB').Value  := Null;

    FTabTem.FieldByName('LGF_INFALT').AsString  := strTipo;
    FTabTem.FieldByName('LGF_VALANT').AsString  := FInfAnt;
    FTabTem.FieldByName('LGF_VALATU').AsString  := FInfNov;
    FTabTem.Post;

  End;


End;

procedure TLogFormulaAlterada.pIncluiSequenciaOriginalMateriaPrima(strAutInc: String; strIteSub: String = ''; strSequen: String = '';
                                                                   strSeqIte: String = ''; blnMovendoItem: boolean = False);
Var
  blnRegistroNovo,
  blnTemRegistro: Boolean;

begin
  If Not(FDataSetSeqOriMat.Active) Then
    FDataSetSeqOriMat.Open;

  blnRegistroNovo := False;
  If Not blnMovendoItem Then
  Begin
    If fEmptyStr(strAutInc) Then
      blnRegistroNovo := (Not(FDataSetSeqOriMat.Locate('DMT_ITESUB;DMT_SEQUEN', varArrayof([strIteSub, strSeqIte]), [])))
    Else
      blnRegistroNovo := (Not(FDataSetSeqOriMat.Locate('AUTOINCREM', strAutInc, [])));
  End;

  If blnRegistroNovo Then
  Begin
    FDataSetSeqOriMat.Insert;
    FDataSetSeqOriMat.FieldByName('DMT_ITESUB').AsString:= strIteSub;
    FDataSetSeqOriMat.FieldByName('DMT_SEQUEN').AsString:= strSequen;
    FDataSetSeqOriMat.FieldByName('DMT_SEQNEW').AsString:= strSequen; //SequenNew
    FDataSetSeqOriMat.FieldByName('DMT_SEQITE').AsString:= strSeqIte;
    FDataSetSeqOriMat.FieldByName('DMT_SEQITN').AsString:= strSeqIte; //SeqItNew
    FDataSetSeqOriMat.FieldByName('AUTOINCREM').AsString:= strAutInc;
    FDataSetSeqOriMat.Post;
  End
  Else
  Begin
    If fEmptyStr(strAutInc) Then
    Begin
      If fEmptyStr(strIteSub) Or fEmptyStr(strSeqIte) Then
        blnTemRegistro := True
      Else
      Begin
        blnTemRegistro := FDataSet.Locate('DMT_ITESUB;DMT_SEQUEN', varArrayof([strIteSub, strSeqIte]), []);
        FDataSetSeqOriMat.Locate('DMT_ITESUB;DMT_SEQUEN', varArrayof([strIteSub, strSeqIte]), []);
      End;
    End
    Else
    Begin
      blnTemRegistro := FDataSet.Locate('AUTOINCREM', strAutInc, []);
      FDataSetSeqOriMat.Locate('AUTOINCREM', strAutInc, []);
    End;

    If blnTemRegistro Then
    Begin

      FDataSetSeqOriMat.Edit;

      If (FDataSet.FieldByName('DMT_SEQUEN').AsString <>
          FDataSetSeqOriMat.FieldByName('DMT_SEQUEN').AsString) Then
        FDataSetSeqOriMat.FieldByName('DMT_SEQNEW').AsString:= FDataSet.FieldByName('DMT_SEQUEN').AsString; //SequenNew

      If (FDataSet.FieldByName('DMT_SEQITE').AsString <>
          FDataSetSeqOriMat.FieldByName('DMT_SEQITE').AsString) Then
        FDataSetSeqOriMat.FieldByName('DMT_SEQITN').AsString:= FDataSet.FieldByName('DMT_SEQITE').AsString; //SeqItNew

      FDataSetSeqOriMat.Post;
    End;
  End;

end;

procedure TLogFormulaAlterada.pGravaSequenciaTabelaLogTemp;
Begin
  FDataSetSeqOriMat.First;
  While Not (FDataSetSeqOriMat.Eof) do
  Begin
    FIteSub:= FDataSetSeqOriMat.FieldByName('DMT_ITESUB').AsString;

    If FDataSetSeqOriMat.FieldByName('DMT_SEQUEN').AsString <>
       FDataSetSeqOriMat.FieldByName('DMT_SEQNEW').AsString Then
    Begin
      FInfNov := FDataSetSeqOriMat.FieldByName('DMT_SEQNEW').AsString;
      FInfAnt := FDataSetSeqOriMat.FieldByName('DMT_SEQUEN').AsString;

      pIncluiRegistroAlterado(FCodCor, FCodIte, FCodEmp, FForMul, FDtaHra, FCodOpe, FIteSub, FInfNov, FInfAnt, 'SEQUENCIA GERAL');
    End;

    If FDataSetSeqOriMat.FieldByName('DMT_SEQITE').AsString <>
       FDataSetSeqOriMat.FieldByName('DMT_SEQITN').AsString Then
    Begin
      FInfNov := FDataSetSeqOriMat.FieldByName('DMT_SEQITN').AsString;
      FInfAnt := FDataSetSeqOriMat.FieldByName('DMT_SEQITE').AsString;

      pIncluiRegistroAlterado(FCodCor, FCodIte, FCodEmp, FForMul, FDtaHra, FCodOpe, FIteSub, FInfNov, FInfAnt, 'SEQUENCIA DO ITEM');
    End;

    FDataSetSeqOriMat.Next;
  End;

End;

procedure TLogFormulaAlterada.pLimpaDataSetSequenciaOriginalMateriaPrima;
Begin
  FDataSetSeqOriMat.EmptyDataSet;
End;

end.
