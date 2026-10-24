unit untHistoricoBalanco;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core, untFuncoesGenerica,
{$ELSE}
  cxProgressBar, Forms, untGravando, untFuncoesSimples,
{$ENDIF}
  SysUtils, Classes, Uni, untTypesSistema, untZClient, DB, untCadLote;

Type
  THistoricoBalanco = Class(TComponent)
  Private

    FDados: TZClient;

    objCadLot: TCadLot;

    Function fSQLMapa(intQtdDif: Integer): String;
    Function fCriaTabelaMapa(intQtdDif: Integer): Boolean;

    Function fMontaMapaDiferencaPrg(cxProgressBar: TCxProgressBar): Boolean;

    Procedure pBeforePost(dataSet: TDataSet);

    Procedure pCarregaContagem(strCodIte, strNumLot: String; Var fltSalCon, fltMlgCon: Double);

    Class Function fIniciaAutInc: String;
    Class Function fFinalizaAutInc: String;

  Public
    blnESTEXT,
    blnUsaTmq,
    blnConAcu: Boolean;
    intConEst: Integer;

    cdsMapa: TZClient;
    intMaxContagem: Integer;

    Constructor Create(AOwner: TComponent ); override;

    Class Procedure pIncluiHistorico(strCodEmp, strCodIte, strNumLot, strCodOpe, strIncHis: String;
                                     fltSalCon, fltGmlCon: Double);

    Class Procedure pLimpaHistoricoNaoContados;

    Class Function fDeveGravarHistorico: Boolean;

    Class Procedure pIncluiHistoricoZeraSaldoProduto(strSQLFiltros, strArmazens: String; pSetaParametros: TSetaParametros);

    Class Procedure pLimpaHistoricoSaldoProduto(strSQLFiltros, strCodIte: string; pSetaParametros: TSetaParametros);

    Class Procedure pIncluiHistoricoZeraSaldoLote(strArmazens: string; strCodIte: String;
                                strFilExt: string; pSetaParametros: TSetaParametros);

    Class Procedure pSetaSQLLimpaHistoricoSaldoLote(qryDelete: TUniQuery;strArmazens: string; strCodIte: String; strFilExt: string);

    Class Procedure pLimpaHistoricoSaldoLote(strArmazens: string; strCodIte: String;
                                strFilExt: string; pSetaParametros: TSetaParametros);


    Function fMontaMapaDiferenca(cdsDados: TZClient): Boolean;
  End;

implementation

uses
  StrUtils,
  untBalancoEstoqueAjuste;

constructor THistoricoBalanco.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  blnUsaTmq := fCfgSis('USATMQ', varBoolean);
  blnConAcu := fCfgSis('CONACU', varBoolean);
  intConEst := fCfgSis('CONEST');
  blnESTEXT := fCfgSis('ESTEXT', varBoolean);
end;

Class Procedure THistoricoBalanco.pIncluiHistorico(strCodEmp, strCodIte, strNumLot, strCodOpe, strIncHis: String;
                                     fltSalCon, fltGmlCon: Double);
  Var
    qryHistorico: TUniQuery;
Begin
  If Not fDeveGravarHistorico Then
    Exit;

  qryHistorico := fCriaQuery;

  qryHistorico.SQL.Text := Concat('INSERT INTO HISBAL ',
                                  '(AUTOINCREM, ITE_DTACON, ITE_HORCON, ITE_CODITE, ',
                                  ' ITE_CODEMP, ITE_NUMLOT, ITE_CONTAG, ITE_SALCON, ITE_GMLCON, ITE_CODOPE) VALUES ',
                                  '(:AUTINC, CURDATE(), CURTIME(), :CODITE, ',
                                  ' :CODEMP, :NUMLOT, ',
                                  ' (SELECT IFNULL(MAX(M.ITE_CONTAG), 0) + 1 FROM HISBAL M ',
                                  '  WHERE M.ITE_CODEMP = :CODEMP AND M.ITE_CODITE = :CODITE AND M.ITE_NUMLOT = :NUMLOT),  ',
                                  ' :SALCON, :GMLCON, :CODOPE) ');

  qryHistorico.ParamByName('CODEMP').AsString := strCodEmp;
  qryHistorico.ParamByName('CODITE').AsString := strCodIte;
  qryHistorico.ParamByName('NUMLOT').AsString := strNumLot;
  qryHistorico.ParamByName('CODOPE').AsString := strCodOpe;
  qryHistorico.ParamByName('SALCON').AsFloat  := fltSalCon;
  qryHistorico.ParamByName('GMLCON').AsFloat  := fltGmlCon;

  If strIncHis.IsEmpty Then
    strIncHis := fRetAutoIncrem('HISBAL', VS_strCodEmp);

  qryHistorico.ParamByName('AUTINC').AsString := strIncHis;
  qryHistorico.ExecSQL;

  FreeAndNil(qryHistorico);
End;

Class Function THistoricoBalanco.fIniciaAutInc: String;
Begin
  Result := 'SET @AUTINC = (SELECT IFNULL(PRO_AUTINC, 1) AS AUTINC FROM PROINC WHERE PRO_NOMARQ = "HISBAL"); ';
End;

Class Function THistoricoBalanco.fFinalizaAutInc: String;
Begin
  Result := 'UPDATE PROINC SET PRO_AUTINC = @AUTINC+1 WHERE PRO_NOMARQ = "HISBAL"; ';
End;

Class Procedure THistoricoBalanco.pIncluiHistoricoZeraSaldoProduto(strSQLFiltros, strArmazens: String; pSetaParametros: TSetaParametros);
  Var
    qryInsert: TUniQuery;
Begin
  If Not fDeveGravarHistorico Then
    Exit;

  qryInsert := fCriaQuery;
  qryInsert.SQL.Text :=
            Concat(fIniciaAutInc,
                   'INSERT INTO HISBAL ',
                   '(AUTOINCREM, ',
                   ' ITE_DTACON, ',
                   ' ITE_HORCON, ',
                   ' ITE_CODITE, ',
                   ' ITE_CODEMP, ',
                   ' ITE_NUMLOT, ',
                   ' ITE_CONTAG, ',
                   ' ITE_SALCON, ',
                   ' ITE_GMLCON, ',
                   ' ITE_CODOPE) ',
                   ' SELECT ',
                   '   CONCAT(:CODEMP, RIGHT(CONCAT("00000000000000", @AUTINC:=(@AUTINC+1)), 14), :CODEMP), ',
                   '   CURDATE(), ',
                   '   CURTIME(), ',
                   '   I.ITE_CODITE, ',
                   '   :CODEMP, ',
                   '   "", ',
                   '   (SELECT IFNULL(MAX(M.ITE_CONTAG), 0) + 1 FROM HISBAL M ',
                                  '  WHERE M.ITE_CODEMP = :CODEMP AND M.ITE_CODITE = I.ITE_CODITE AND M.ITE_NUMLOT = ""), ',
                   '   0, ',
                   '   0, ',
                   '   :CODOPE  ',
                   ' FROM       ',
                   '   ITEGER G ',
                   '   INNER JOIN CADITE I ON G.ITE_CODITE = I.ITE_CODITE    ',
                   ' 	 LEFT JOIN CADLOT ON G.ITE_CODITE = LOT_CODITE  AND    ',
                   ' 	                     G.ITE_CODEMP = LOT_CODEMP         ',
                   ' WHERE                                                   ',
                   '   G.ITE_DIGCON = "N" AND                                ',
                   '   G.ITE_CODEMP = :CODEMP AND                            ',
                   '     LOT_NUMLOT IS NULL                                  ',

                   strSQLFiltros,
                   '; ',
                   fFinalizaAutInc);

  If Not fEmptyStr(strArmazens) Then
    qryInsert.SQL.Add(' AND ((LOT_CODITE IS NULL) OR (LOT_NUMLOT IN (' + strArmazens + '))) ');

  qryInsert.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

  If Assigned(pSetaParametros) Then
    pSetaParametros(qryInsert);

  qryInsert.ExecSQL;

  FreeAndNil(qryInsert);
End;

Class Procedure THistoricoBalanco.pLimpaHistoricoSaldoProduto(strSQLFiltros, strCodIte: string; pSetaParametros: TSetaParametros);
  Var
    qryDelete: TUniQuery;
Begin
  If Not fDeveGravarHistorico Then
    Exit;

  qryDelete := fCriaQuery;

  strSQLFiltros := AnsiReplaceStr(strSQLFiltros, 'I.', 'CADITE.');
  strSQLFiltros := AnsiReplaceStr(strSQLFiltros, 'G.', 'ITEGER.');

  qryDelete.SQL.Text := 'DELETE FROM HISBAL ';

  If Not strSQLFiltros.IsEmpty Then
    qryDelete.SQL.Add('USING HISBAL, ITEGER, CADITE');

  qryDelete.SQL.Add('WHERE');

  If strCodIte.IsEmpty Then
  Begin
    qryDelete.SQL.Add('  HISBAL.ITE_CODEMP = :CODEMP');
  End Else
  Begin
    qryDelete.SQL.Add('      HISBAL.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryDelete.SQL.Add('  AND HISBAL.ITE_CODITE = ' + QuotedStr(strCodIte));
  End;

  If Not strSQLFiltros.IsEmpty Then
  Begin
    qryDelete.SQL.Add('  AND HISBAL.ITE_CODEMP = ITEGER.ITE_CODEMP ');
    qryDelete.SQL.Add('  AND HISBAL.ITE_CODITE = ITEGER.ITE_CODITE');

    qryDelete.SQL.Add('  AND HISBAL.ITE_CODITE = CADITE.ITE_CODITE ');
  End;

  qryDelete.SQL.Add(strSQLFiltros);

  If Assigned(pSetaParametros) Then
    pSetaParametros(qryDelete);

  qryDelete.ExecSQL;

  FreeAndNil(qryDelete);
End;

Class Procedure THistoricoBalanco.pLimpaHistoricoNaoContados;
  Var
    qryDelete: TUniQuery;
Begin
  If Not fDeveGravarHistorico Then
    Exit;

  qryDelete := fCriaQuery;

  qryDelete.SQL.Text := 'DELETE FROM HISBAL ';

  qryDelete.SQL.Add('USING HISBAL, ITEGER');

  qryDelete.SQL.Add('WHERE');
  qryDelete.SQL.Add('      HISBAL.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp));
  qryDelete.SQL.Add('  AND HISBAL.ITE_CODEMP = ITEGER.ITE_CODEMP ');
  qryDelete.SQL.Add('  AND HISBAL.ITE_CODITE = ITEGER.ITE_CODITE');
  qryDelete.SQL.Add('  AND ITEGER.ITE_DIGCON = "N"');

  qryDelete.ExecSQL
End;

Class Procedure THistoricoBalanco.pSetaSQLLimpaHistoricoSaldoLote(qryDelete: TUniQuery;strArmazens: string; strCodIte: String; strFilExt: string);
Begin
  qryDelete.SQL.Text := 'DELETE FROM HISBAL ';

  If (Not strFilExt.IsEmpty) Then
    qryDelete.SQL.Add('USING HISBAL, ITEGER, CADITE, CADLOT ');

  qryDelete.SQL.Add(' WHERE  ');

  qryDelete.SQL.Add('       HISBAL.ITE_NUMLOT <> "" ');

  qryDelete.SQL.Add('   AND HISBAL.ITE_CODEMP = :CODEMP ');

  If (Not strFilExt.IsEmpty) Then
  Begin
    qryDelete.SQL.Add('   AND HISBAL.ITE_CODEMP = CADLOT.LOT_CODEMP');
    qryDelete.SQL.Add('   AND HISBAL.ITE_CODITE = CADLOT.LOT_CODITE');
    qryDelete.SQL.Add('   AND HISBAL.ITE_NUMLOT = CADLOT.LOT_NUMLOT');

    qryDelete.SQL.Add('   AND HISBAL.ITE_CODEMP = ITEGER.ITE_CODEMP');
    qryDelete.SQL.Add('   AND HISBAL.ITE_CODITE = ITEGER.ITE_CODITE');

    qryDelete.SQL.Add('   AND HISBAL.ITE_CODITE = CADITE.ITE_CODITE');
  End;

  If Not fEmptyStr(strArmazens) Then
    qryDelete.SQL.Add(' AND HISBAL.ITE_NUMLOT IN (' + strArmazens + ') ');

  If strCodIte <> '' Then
    qryDelete.SQL.Add('  AND HISBAL.ITE_CODITE = :CODITE  ');

  strFilExt := AnsiReplaceStr(strFilExt, 'I.', 'CADITE.');
  strFilExt := AnsiReplaceStr(strFilExt, 'G.', 'ITEGER.');

  qryDelete.SQL.Add(strFilExt);
End;

Class Procedure THistoricoBalanco.pLimpaHistoricoSaldoLote(strArmazens: string; strCodIte: String;
                                strFilExt: string; pSetaParametros: TSetaParametros);
  Var
    qryDelete: TUniQuery;
Begin
  If Not fDeveGravarHistorico Then
    Exit;

  qryDelete := fCriaQuery;

  pSetaSQLLimpaHistoricoSaldoLote(qryDelete, strArmazens, strCodIte, strFilExt);

  qryDelete.ParamByName('CODEMP').AsString := VS_strCodEmp;

  If strCodIte <> '' Then
    qryDelete.ParamByName('CODITE').AsString := strCodIte;

  If Assigned(pSetaParametros) Then
    pSetaParametros(qryDelete);

  qryDelete.ExecSQL;

  FreeAndNil(qryDelete);
End;

Class Procedure THistoricoBalanco.pIncluiHistoricoZeraSaldoLote(strArmazens: string; strCodIte: String;
                                strFilExt: string; pSetaParametros: TSetaParametros);
  Var
    qryInsert: TUniQuery;
Begin
  If Not fDeveGravarHistorico Then
    Exit;

  qryInsert := fCriaQuery;
  qryInsert.SQL.Text :=
            Concat(fIniciaAutInc,
                   'INSERT INTO HISBAL ',
                   '(AUTOINCREM, ITE_DTACON, ITE_HORCON, ITE_CODITE, ',
                   ' ITE_CODEMP, ITE_NUMLOT, ITE_CONTAG, ITE_SALCON, ITE_GMLCON, ITE_CODOPE) ',
                   ' SELECT ',
                   '   CONCAT(:CODEMP, RIGHT(CONCAT("00000000000000", @AUTINC:=(@AUTINC+1)), 14), :CODEMP), ',
                   '   CURDATE(), CURTIME(), I.ITE_CODITE, :CODEMP, LOT_NUMLOT, ',
                   '   (SELECT IFNULL(MAX(M.ITE_CONTAG), 0) + 1 FROM HISBAL M ',
                                  '  WHERE M.ITE_CODEMP = :CODEMP AND M.ITE_CODITE = I.ITE_CODITE AND M.ITE_NUMLOT = ""), ',
                   '   0, 0, :CODOPE  ',
                   ' FROM     ',
                   '   CADLOT  ');

  If Not strFilExt.IsEmpty Then
  Begin
    qryInsert.SQL.Add(' INNER JOIN ITEGER G ON G.ITE_CODEMP = CADLOT.LOT_CODEMP AND G.ITE_CODITE = CADLOT.LOT_CODITE ');

    qryInsert.SQL.Add(' INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ');
  End;

  qryInsert.SQL.Add(' WHERE  LOT_CODEMP = :CODEMP ');

  If Not fEmptyStr(strArmazens) Then
    qryInsert.SQL.Add(' AND LOT_NUMLOT IN (' + strArmazens + ') ');

  If strCodIte <> '' Then
    qryInsert.SQL.Add('  AND LOT_CODITE = ' + QuotedStr(strCodIte))
  Else
    qryInsert.SQL.Add('  AND LOT_DIGCON = "N"');  // APENAS PARA OS NÃO CONTADOS

  qryInsert.SQL.Add(strFilExt);

  qryInsert.SQL.Add('; ');
  qryInsert.SQL.Add(fFinalizaAutInc);

  qryInsert.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
  qryInsert.ParamByName('CODEMP').AsString := VS_strCodEmp;

  If Assigned(pSetaParametros) Then
    pSetaParametros(qryInsert);

  qryInsert.ExecSQL;

  FreeAndNil(qryInsert);
End;

Function THistoricoBalanco.fSQLMapa(intQtdDif: Integer): String;
  Var
    strSQL: String;
    intContador: Integer;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   C.ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(30)) AS NUMLOT, ';
  strSQL := strSQL + '   C.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '   UNI_SIGUNI AS SIGUNI, ';

  strSQL := strSQL + '   ITE_SALDOS AS SALDOS, ';
  strSQL := strSQL + '   CAST(NULL AS DECIMAL(12, 3)) AS RESGAR, ';
  strSQL := strSQL + '   CAST(NULL AS DECIMAL(12, 3)) AS SALMAN, ';
  strSQL := strSQL + '   CAST(NULL AS DECIMAL(12, 3)) AS BEACCS, ';

  If blnUsaTmq Then
    strSQL := strSQL + '   ITE_SAL_ML AS SAL_ML, ';

  For intContador := 1 To intQtdDif  Do
  Begin
    strSQL := strSQL + '   OPE_NOMOPE AS OPERA' + intContador.ToString + ', ';
    strSQL := strSQL + '   OPE_CODOPE AS CODOP' + intContador.ToString + ', ';
    strSQL := strSQL + '   CAST(NULL AS DATE) AS DTACO' + intContador.ToString + ', ';
    strSQL := strSQL + '   CAST(NULL AS TIME) AS HORCO' + intContador.ToString + ', ';

    strSQL := strSQL + '   ITE_SALCON AS CONTA' + intContador.ToString + ', ';

    If blnUsaTmq Then
      strSQL := strSQL + '   ITE_GMLCON AS CONML' + intContador.ToString + ', ';
  End;

  strSQL := strSQL + '   ITE_SALCON AS SALCON, ';

  If blnUsaTmq Then
    strSQL := strSQL + '   ITE_GMLCON AS GMLCON, ';

  strSQL := strSQL + '   ITE_DIFSAL AS DIFSAL ';

  If blnUsaTmq Then
    strSQL := strSQL + ', ITE_DIF_ML AS DIF_ML  ';

  strSQL := strSQL + ' FROM   ';
  strSQL := strSQL + '   CADITE C ';

  strSQL := strSQL + ' INNER JOIN CADOPE O ON FALSE ';

  strSQL := strSQL + ' INNER JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE AND FALSE ';

  strSQL := strSQL + ' INNER JOIN CADUNI ON UNI_CODUNI = C.ITE_CODUNI AND FALSE ';

  strSQL := strSQL + ' WHERE FALSE ';
  Result := strSQL;
End;

function THistoricoBalanco.fCriaTabelaMapa(intQtdDif: Integer): Boolean;
  Var
    intContador: Integer;
Begin
  cdsMapa := TZClient.Create(Self, fSQLMapa(intQtdDif));
  Result := cdsMapa.fLeDados('THistoricoBalanco.fCriaTabelaMapa');

  cdsMapa.pAlinhaCampoCentro('CODITE');
  cdsMapa.pAlinhaCampoCentro('SIGUNI');

  For intContador := 1 To intQtdDif  Do
  Begin
    cdsMapa.pAlinhaCampoCentro('CODOP' + intContador.ToString);
    cdsMapa.pAlinhaCampoCentro('DTACO' + intContador.ToString);
    cdsMapa.pAlinhaCampoCentro('HORCO' + intContador.ToString);
  End;

End;

Function THistoricoBalanco.fMontaMapaDiferenca(cdsDados: TZClient): Boolean;
{$IFDEF LINUX}
begin
  Result := fMontaMapaDiferencaPrg(nil);
{$ELSE}
  Var
    frmGravando: TfrmGravando;
Begin
  FDados := cdsDados;
  Result := TfrmGravando.fExecuta(fMontaMapaDiferencaPrg, frmGravando, 'Carregando contagens, aguarde...');
{$ENDIF}
End;

Function THistoricoBalanco.fMontaMapaDiferencaPrg(cxProgressBar: TCxProgressBar): Boolean;
  Var
    strCodIte: String;
Begin

  Try
    objCadLot := TCadLot.Create(Self);

    intMaxContagem := fIntAggregate(FDados, 'MAX_CONTAG');

    Result := fCriaTabelaMapa(intMaxContagem);

    If Not Result Then
      Exit;

    cxProgressBar.Properties.Max := FDados.RecordCount;

    strCodIte := '';

    FDados.First;

    While Not FDados.Eof Do
    Begin

      If strCodIte <> Concat(FDados.FieldByName('ITE_CODITE').AsString, '-', FDados.FieldByName('ITE_NUMLOT').AsString) Then
      Begin
        cdsMapa.Insert;

        cdsMapa.FieldByName('CODITE').Value := FDados.FieldByName('ITE_CODITE').Value;
        cdsMapa.FieldByName('NUMLOT').Value := FDados.FieldByName('ITE_NUMLOT').Value;
        cdsMapa.FieldByName('DESITE').Value := FDados.FieldByName('ITE_DESITE').Value;
        cdsMapa.FieldByName('SIGUNI').Value := FDados.FieldByName('UNI_SIGUNI').Value;
        cdsMapa.FieldByName('SALDOS').Value := FDados.FieldByName('ITE_SALDOS').Value;  // ESTÁ SOMADO A ENTREGA FUTURA
        cdsMapa.FieldByName('RESGAR').Value := FDados.FieldByName('RESGAR').Value;
        cdsMapa.FieldByName('SALMAN').Value := FDados.FieldByName('SALMAN').Value;
        cdsMapa.FieldByName('BEACCS').Value := FDados.FieldByName('BEACCS').Value;

        If blnUsaTmq Then
          cdsMapa.FieldByName('SAL_ML').Value := FDados.FieldByName('ITE_SAL_ML').Value;

      End Else
      Begin
        cdsMapa.Edit;
      End;

      cdsMapa.FieldByName('SALCON').Value := FDados.FieldByName('SALCON_FINAL').Value;
      cdsMapa.FieldByName('DIFSAL').Value := FDados.FieldByName('ITE_DIFERE').Value;
      cdsMapa.FieldByName('CONTA' + FDados.FieldByName('H_CONTAG').AsString).Value := FDados.FieldByName('H_SALCON').Value;

      If blnUsaTmq Then
      Begin
        cdsMapa.FieldByName('GMLCON').Value := FDados.FieldByName('GMLCON_FINAL').Value;
        cdsMapa.FieldByName('DIF_ML').Value := FDados.FieldByName('ITE_DIFGML').Value;
        cdsMapa.FieldByName('CONML' + FDados.FieldByName('H_CONTAG').AsString).Value := FDados.FieldByName('H_GMLCON').Value;
      End;

      cdsMapa.FieldByName('CODOP' + FDados.FieldByName('H_CONTAG').AsString).Value := FDados.FieldByName('H_CODOPE').Value;
      cdsMapa.FieldByName('OPERA' + FDados.FieldByName('H_CONTAG').AsString).Value := FDados.FieldByName('H_NOMOPE').Value;
      cdsMapa.FieldByName('DTACO' + FDados.FieldByName('H_CONTAG').AsString).Value := FDados.FieldByName('H_DTACON').Value;
      cdsMapa.FieldByName('HORCO' + FDados.FieldByName('H_CONTAG').AsString).Value := FDados.FieldByName('H_HORCON').Value;

      cdsMapa.Post;

      strCodIte := Concat(FDados.FieldByName('ITE_CODITE').AsString, '-', FDados.FieldByName('ITE_NUMLOT').AsString);

      FDados.Next;

      cxProgressBar.Position := cxProgressBar.Position + 1;
      Application.ProcessMessages;
    End;

    cdsMapa.BeforePost := pBeforePost;

    Result := True;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[THistoricoBalanco.fMontaMapaDiferenca(]');
      Result := False;
    End;
  End;
End;

Procedure THistoricoBalanco.pCarregaContagem(strCodIte, strNumLot: String; Var fltSalCon, fltMlgCon: Double);
  Var
    qryLote: TUniQuery;
Begin
  qryLote := fCriaQuery;
  qryLote.SQL.Text := Concat('SELECT SUM(IFNULL(LOT_SALCON, 0)) AS SALCON, SUM(IFNULL(LOT_ML_CON, 0)) AS ML_CON FROM CADLOT ',
                             'WHERE LOT_CODEMP = :CODEMP AND LOT_CODITE = :CODITE AND LOT_NUMLOT <> :NUMLOT ',
                             'AND LOT_STATUS = "S" AND LOT_NUMLOT <> "A DEFINIR"');

  qryLote.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryLote.ParamByName('CODITE').AsString := strCodIte;
  qryLote.ParamByName('NUMLOT').AsString := strNumLot;
  qryLote.Open;

  fltSalCon := qryLote.FieldByName('SALCON').AsFloat;
  fltMlgCon := qryLote.FieldByName('ML_CON').AsFloat;

  FreeAndNil(qryLote);
End;

Procedure THistoricoBalanco.pBeforePost(dataSet: TDataSet);
  Var
    intOrdCon: Integer;
    fltSalCon, fltMlgCon: Double;
Begin
  Try

    dataSet.FieldByName('DIFSAL').AsFloat := dataSet.FieldByName('SALCON').AsFloat + dataSet.FieldByName('RESGAR').AsFloat - dataSet.FieldByName('SALDOS').AsFloat;

    If blnUsaTmq Then
      dataSet.FieldByName('DIF_ML').AsFloat := dataSet.FieldByName('GMLCON').AsFloat - dataSet.FieldByName('SAL_ML').AsFloat;

    If dataSet.FieldByName('NUMLOT').AsString.IsEmpty Then
    Begin
      If Not fSalvaContagem(dataSet.FieldByName('CODITE').AsString,
                     dataSet.FieldByName('SALCON').AsFloat,
                     dataSet.FieldByName('GMLCON').AsFloat,
                     objCadLot.fRetOrdemItem, True, False, blnConAcu,
                     intConEst, strLoginUsuarioLogado, '', Self) Then
       dataSet.Cancel;
    End Else
    Begin

      pCarregaContagem(dataSet.FieldByName('CODITE').AsString,
                       dataSet.FieldByName('NUMLOT').AsString,
                       fltSalCon, fltMlgCon);

      fStartTransaction;

      intOrdCon := objCadLot.fRetOrdemItem;

      If objCadLot.fSalvaContagemLote('',
                                      dataSet.FieldByName('CODITE').AsString,
                                      dataSet.FieldByName('NUMLOT').AsString,
                                      strLoginUsuarioLogado,
                                      '',
                                      dataSet.FieldByName('SALCON').AsFloat,
                                      dataSet.FieldByName('GMLCON').AsFloat,
                                      intOrdCon) And

          fSalvaContagem(dataSet.FieldByName('CODITE').AsString,
                         fltSalCon + dataSet.FieldByName('SALCON').AsFloat,
                         fltMlgCon + dataSet.FieldByName('GMLCON').AsFloat,
                         intOrdCon, True, False, blnConAcu,
                         intConEst, strLoginUsuarioLogado, '', Self) And

         fGravaLogContEst(strLoginUsuarioLogado,
                          dataSet.FieldByName('CODITE').AsString,
                          dataSet.FieldByName('NUMLOT').AsString,
                          dataSet.FieldByName('SALCON').AsFloat,
                          dataSet.FieldByName('GMLCON').AsFloat) Then
      Begin
        fCommit;
      End Else
      Begin
        fRollBack;
        dataSet.Cancel;
      End;

    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, 'THistoricoBalanco.pBeforePost');
    End;
  End;

End;

Class Function THistoricoBalanco.fDeveGravarHistorico: Boolean;
Begin
  Result := False;

  If VS_intConEst <> 1 Then
    Exit;

  If VS_intConAcu <> 2 Then
    Exit;

  Result := True;
End;

end.
