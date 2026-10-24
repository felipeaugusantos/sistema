unit untFuncoesAutocenter;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  UniClientDataSet,
  untFuncoesSimples,
{$ENDIF}
  Classes,
  Uni,
  SysUtils,
  DB,
  TypInfo,
  strUtils,
  Variants,
  untTypesSistema;

  function fExisteMecanico(strCodMec: String): Boolean;
  function fMecanicoInativo(strCodMec: String): Boolean;

  function fGetPerComMecanicoItem(strCodMec, strCodIte: String; intQtdMec: Integer): Double;
  function fGetPerComMecanicoServico(strCodMec, strCodSer: String; intQtdMec: Integer): Double;
  function fGetValComVendedorServico(ftlQtdSer, fltValUniSer: Double; strCodVen, strCodSer: String): Double;

  function fQuantidadeItensPendenteAlmoxarifeAutocenter(strNumDoc, strEspDoc, strCodEmp: String; intSeqInc: Integer = 0): Double;
  function fTemProdutosAguardandoConferenciaAlmoxarifado(strNumDoc, strEspDoc, strCodEmp, strTipPen: String; intSeqInc: Integer = 0): Boolean;

  function fGetPrismasImp(strSeqFgo: String; blnComEnter: Boolean = True; strNomeTabela: string = ''): String;
  function fGetDadosVeiculo(strSeqFgo: String; blnComEnter: Boolean = True; strNomeTabela: string = ''): String;

  procedure pGravaMecanicosItemPD(strAutInc, strMecanicos: String);
  procedure pGravaMecanicosServicoPD(strAutInc, strIdeSer, strMecanicos: String);
  procedure pGravaObservacaoServicoPD(strAutInc, strIdeSer, strObservacao: String);

  procedure pGravaObservacaoServico( strNomTab,
                                     strAutInc,
                                     strIdeSer,
                                     strObservacao: String );

  procedure pApagaMecanicosServico( strNomtab, strAutInc, strIdeSer: String );

  procedure pGravaMecanicosServico( strNomtab,
                                    strAutInc,
                                    strIdeSer,
                                    strCodSer: String;
                                    fltTotSer: Double;
                                    strMecanicos: String;
                                    fltQtdSer: Double );

  procedure pApagaMecanicosItem( strNomtab, strSeqDet: String );

  procedure pGravaMecanicosItem( strNomtab,
                                 strAutInc,
                                 strCodIte: String;
                                 fltTotLiqIte: Double;
                                 strMecanicos: String;
                                 fltQtdIte: Double);

  procedure pIncluiSerMov( strNomTab,
                           strAutInc: String;
                           recServicos: TDadosServicos );

  function fGetUnitComMecanicoItem(strCodMec, strCodIte: String; intQtdMec: Integer; var blnComissaoPorValor: Boolean): Double;
  function fGetUnitComMecanicoServico(strCodMec, strCodSer: String; intQtdMec: Integer; var blnComissaoPorValor: Boolean): Double;

implementation

uses untSQLRepositorio, untFuncFatTypes;

function fExisteMecanico(strCodMec: String): Boolean;
begin
  Result := fCampoTabela('OPE_INTEXT', 'CADOPE', ['OPE_CODOPE'], [strCodMec]) = 'M';
end;

function fMecanicoInativo(strCodMec: String): Boolean;
Begin
  Result := fCampoTabela('OPE_STATUS', 'CADOPE', ['OPE_CODOPE'], [strCodMec]) = 'I';
End;

function fTemProdutosAguardandoConferenciaAlmoxarifado(strNumDoc, strEspDoc, strCodEmp, strTipPen: String; intSeqInc: Integer = 0): Boolean;
  Var
    qryGen: TUniQuery;
begin
  Result := False;

  If Not fCfgSis('AUTCEN', varBoolean) Then
    Exit;

  If Not fCfgSis('USAEXS', varBoolean) Then
    Exit;

  If strEspDoc <> 'PD' Then
    Exit;

  qryGen := fCriaQuery;

  qryGen.SQL.Clear;
  qryGen.SQL.Add('  SELECT ');
  qryGen.SQL.Add('    SUM(FDO_QTDITE * IF(FDO_ENTSAI = "S", 1, -1)) AS QTDITE, ');
  qryGen.SQL.Add('    IF(SUM(FDO_QTDITE * IF(FDO_ENTSAI = "S", 1, -1)) < 0, "E", "S") AS TIPPEN ');
  qryGen.SQL.Add('  FROM ');
  qryGen.SQL.Add('    FDOSEP ');
  qryGen.SQL.Add('  WHERE ');
  qryGen.SQL.Add('    FDO_CODEMP = :CODEMP AND ');
  qryGen.SQL.Add('    FDO_NUMDOC = :NUMDOC AND ');
  qryGen.SQL.Add('    FDO_PENDEN = 1');//pendentes na expedicao

  If intSeqInc > 0 Then
    qryGen.SQL.Add('    AND FDO_SEQINC = :SEQINC ');

  qryGen.SQL.Add('  GROUP BY ');
  qryGen.SQL.Add('    FDO_CODITE, ');
  qryGen.SQL.Add('    FDO_SEQINC  ');
  qryGen.SQL.Add('  HAVING QTDITE <> 0 ');

  qryGen.ParamByName('CODEMP').AsString := strCodEmp;
  qryGen.ParamByName('NUMDOC').AsString := strNumDoc;

  If intSeqInc > 0 Then
    qryGen.ParamByName('SEQINC').AsInteger := intSeqInc;

  qryGen.Open;

  Result := qryGen.Locate('TIPPEN', strTipPen, []);

  FreeAndNil(qryGen);
end;

function fQuantidadeItensPendenteAlmoxarifeAutocenter(strNumDoc, strEspDoc, strCodEmp: String; intSeqInc: Integer = 0): Double;
  Var
    qryPed: TUniQuery;
begin
  Result := 0.00;

  If Not fCfgSis('AUTCEN', varBoolean) Then
    Exit;

  If Not fCfgSis('USAEXS', varBoolean) Then
    Exit;

  If strEspDoc <> 'PD' Then
    Exit;

  qryPed := fCriaQuery;
  Try
    qryPed.SQL.Add(' SELECT FDO_CODITE AS CODITE,');
    qryPed.SQL.Add('        SUM(FDO_QTDITE * IF(FDO_ENTSAI = "S", 1, -1)) AS QTDITE');
    qryPed.SQL.Add('   FROM FDOSEP');
    qryPed.SQL.Add('  WHERE FDO_CODEMP = :CODEMP');
    qryPed.SQL.Add('    AND FDO_NUMDOC = :NUMDOC');
    qryPed.SQL.Add('    AND FDO_PENDEN = 0');

    If intSeqInc > 0 Then
      qryPed.SQL.Add('  AND FDO_SEQINC = :SEQINC');

    qryPed.SQL.Add(' GROUP BY FDO_CODITE, FDO_SEQINC ');
    qryPed.SQL.Add(' HAVING QTDITE <> 0');

    qryPed.ParamByName('CODEMP').AsString := strCodEmp;
    qryPed.ParamByName('NUMDOC').AsString := strNumDoc;

    If intSeqInc > 0 Then
      qryPed.ParamByName('SEQINC').AsInteger := intSeqInc;

    Result := 0;

    qryPed.Open;
    qryPed.First;

    While Not qryPed.Eof Do
    Begin
      Result := Result + qryPed.FieldByName('QTDITE').AsFloat;
      qryPed.Next;
    End;

  Finally
    FreeAndNil(qryPed);
  End;
end;

function fGetPrismasImp(strSeqFgo: String; blnComEnter: Boolean = True; strNomeTabela: string = ''): String;
  Var
    qryPrisma: TUniQuery;
    intPri: Integer;
    strTipSer,
    strPrisma: String;
    cdsPrisma: TUniClientDataSet;
Begin
  qryPrisma := fCriaQuery;
  cdsPrisma := TUniClientDataSet.Create(Nil);
  Try
    cdsPrisma.FieldDefs.Add('TIPSER', ftString, 40);
    cdsPrisma.FieldDefs.Add('PRISMA', ftString, 100);
    cdsPrisma.CreateDataSet;
    cdsPrisma.Open;

    pSQL(qryPrisma, repServicos, 'GET_PRISMAS_TIPSER', [strSeqFgo], strNomeTabela);
    qryPrisma.Open;

    For intPri := 1 To 30 Do
    Begin
      strTipSer := qryPrisma.FieldByName('TIPS'+ fStrZero(intPri, 2)). AsString;
      strPrisma := qryPrisma.FieldByName('PRIS'+ fStrZero(intPri, 2)). AsString;

      If fEmptyStr(strTipSer) Or fEmptyStr(strPrisma) Then
        Continue;

      If cdsPrisma.Locate('TIPSER', strTipSer, []) Then
        cdsPrisma.Edit
      Else
        cdsPrisma.Append;

      cdsPrisma.FieldByName('TIPSER').AsString := strTipSer;
      cdsPrisma.FieldByName('PRISMA').AsString := cdsPrisma.FieldByName('PRISMA').AsString + IIF(fEmptyStr(cdsPrisma.FieldByName('PRISMA').AsString), '', ', ') + strPrisma;
      cdsPrisma.Post;
    End;

    cdsPrisma.First;
    Result := '';
    While Not cdsPrisma.Eof Do
    Begin
      Result := Result + IIF(fEmptyStr(Result), '', IIF(blnComEnter, #13#10, ', ')) + cdsPrisma.FieldByName('TIPSER').AsString + '['+ cdsPrisma.FieldByName('PRISMA').AsString +']';
      cdsPrisma.Next;
    End;
  Finally
    FreeAndNil(qryPrisma);
    FreeAndNil(cdsPrisma);
  End;
end;

function fGetDadosVeiculo(strSeqFgo: String; blnComEnter: Boolean = True; strNomeTabela: string = ''): String;
  Var
    qryVeiculo: TUniQuery;
Begin
  Result := '';

  Try
    qryVeiculo := fCriaQuery;

    pSQL(qryVeiculo, repFaturamento, 'GET_DADOS_VEICULO', [strSeqFgo], strNomeTabela);
    qryVeiculo.Open;

    If Not qryVeiculo.IsEmpty Then
    Begin
      If blnComEnter Then
        Result := 'Placa.: ' + qryVeiculo.FieldByName('PLAVEI').AsString + #13#10 +
                  'KM....: ' + qryVeiculo.FieldByName('KM_VEI').AsString + #13#10 +
                  'Marca.: ' + qryVeiculo.FieldByName('DESMAR').AsString + #13#10 +
                  'Modelo: ' + qryVeiculo.FieldByName('DESMOD').AsString
      Else
        Result := 'Placa.: ' + qryVeiculo.FieldByName('PLAVEI').AsString + '  ' +
                  'KM....: ' + qryVeiculo.FieldByName('KM_VEI').AsString + '  ' +
                  'Marca.: ' + qryVeiculo.FieldByName('DESMAR').AsString + '  ' +
                  'Modelo: ' + qryVeiculo.FieldByName('DESMOD').AsString
    End;
  Finally
    FreeAndNil(qryVeiculo);
  End;
end;

function fGetPerComMecanicoServico(strCodMec, strCodSer: String; intQtdMec: Integer): Double;
begin
  Result := 0.000;
  If (fCfgSis('OPCMEC', VarString ) = 'CO') Then //Cadastro de Operadores
    Result := fCampoTabela('OPE_MECCSE', 'CADOPE', ['OPE_CODOPE'], [strCodMec])

  Else If (fCfgSis('OPCMEC', VarString ) = 'CPS') Then //Cadastro de Produtos/Servicos
  Begin
    Result := fCampoTabela('SER_COMMEC', 'CADSER', ['SER_CODSER'], [strCodSer]);
    If intQtdMec <> 0 Then
      Result := Result / intQtdMec;
  End;
end;

function fGetPerComMecanicoItem(strCodMec, strCodIte: String; intQtdMec: Integer): Double;
begin
  Result := 0.000;
  If (fCfgSis('OPCMEC', VarString ) = 'CO') Then //Cadastro de Operadores
    Result := fCampoTabela('OPE_MECCIT', 'CADOPE', ['OPE_CODOPE'], [strCodMec])

  Else If (fCfgSis('OPCMEC', VarString ) = 'CPS') Then //Cadastro de Produtos/Servicos
  Begin
    Result := fCampoTabela('ITE_COMMEC', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [strCodIte, VS_strCodEmp]);
    If intQtdMec <> 0 Then
      Result := Result / intQtdMec;
  End;
end;

function fGetValComVendedorServico(ftlQtdSer, fltValUniSer: Double; strCodVen, strCodSer: String): Double;
  Var
    blnPerc: Boolean;
    fltTotSer, fltCom: Double;
begin
  Result := 0.000;

  If (Not fEmptyStr(strCodVen)) And (Not fEmptyStr(strCodSer))
    And (strCodVen <> '000') And (strCodSer <> '00000') Then Begin
    fltCom    := 0;
    blnPerc   := False;
    fltTotSer := (ftlQtdSer * fltValUniSer);

    If (fCfgSis('OPCVEN', VarString ) = 'CO') Then Begin //Cadastro de Operadores
      blnPerc := (fCampoTabela('OPE_TPCOVN', 'CADOPE', ['OPE_CODOPE'], [strCodVen]) = 'P');
      fltCom  := fCampoTabela('OPE_VENCSE', 'CADOPE', ['OPE_CODOPE'], [strCodVen]);
    End Else If (fCfgSis('OPCVEN', VarString ) = 'CPS') Then Begin //Cadastro de Produtos/Servicos
      blnPerc := (fCampoTabela('SER_TPCOMV', 'CADSER', ['SER_CODSER'], [strCodSer]) = 'P');
      fltCom  := fCampoTabela('SER_COMVEN', 'CADSER', ['SER_CODSER'], [strCodSer]);
    End;

    If (blnPerc) Then
      Result := fltTotSer * (fltCom / 100)
    Else
      Result := ftlQtdSer * fltCom;
  End;
end;

procedure pApagaMecanicosItem( strNomtab, strSeqDet: String );
  Var
    qryDel: TUniQuery;
Begin
  strNomtab := AnsiReplaceStr(strNomtab, 'MOV', 'MEC');

  qryDel := fCriaQuery;

  qryDel.SQL.Clear;
  qryDel.SQL.Add('DELETE FROM ' + strNomtab);
  qryDel.SQL.Add(' WHERE DET_SEQDET = :SEQDET');


  qryDel.ParamByName('SEQDET').AsString := strSeqDet;
  qryDel.ExecSQL;

  FreeAndNil(qryDel);

End;

procedure pGravaMecanicosItem( strNomtab,
                               strAutInc,
                               strCodIte: String;
                               fltTotLiqIte: Double;
                               strMecanicos: String;
                               fltQtdIte: Double);
  Var
    qryIns: TUniQuery;  
    strCodMec: String;
    stlMecanicos: TStringList;
    blnComissaoPorValor: Boolean;
begin
  strNomtab := AnsiReplaceStr(strNomtab, 'MOV', 'MEC');

  qryIns := fCriaQuery;

  stlMecanicos := TStringList.Create;
  stlMecanicos.CommaText := strMecanicos;

  Try
    qryIns.SQL.Add('INSERT INTO '+ strNomTab +'(');
    qryIns.SQL.Add('  DET_SEQDET,');
    qryIns.SQL.Add('  DET_CODMEC,');
    qryIns.SQL.Add('  DET_PCOMEC,');
    qryIns.SQL.Add('  DET_VCOMEC,');
    qryIns.SQL.Add('  DET_UNCOMC ');

    qryIns.SQL.Add(') VALUES (');
    qryIns.SQL.Add('  :SEQDET,');
    qryIns.SQL.Add('  :CODMEC,');
    qryIns.SQL.Add('  :PCOMEC,');
    qryIns.SQL.Add('  :VCOMEC,');
    qryIns.SQL.Add('  :UNCOMC ');
    qryIns.SQL.Add(')');

    qryIns.ParamByName('SEQDET').AsString := strAutInc;

    For strCodMec In stlMecanicos Do
    Begin
      qryIns.ParamByName('CODMEC').AsString := strCodMec;
      qryIns.ParamByName('UNCOMC').AsFloat  := fGetUnitComMecanicoItem(strCodMec, strCodIte, stlMecanicos.Count, blnComissaoPorValor);

      If (Not blnComissaoPorValor) Then
      Begin
        qryIns.ParamByName('PCOMEC').AsFloat  := fGetPerComMecanicoItem(strCodMec, strCodIte, stlMecanicos.Count);
        qryIns.ParamByName('VCOMEC').AsFloat  := (qryIns.ParamByName('PCOMEC').AsFloat * fltTotLiqIte / 100);
      End
      Else
      Begin
        qryIns.ParamByName('PCOMEC').AsFloat  := 0.00;
        qryIns.ParamByName('VCOMEC').AsFloat  := qryIns.ParamByName('UNCOMC').AsFloat * fltQtdIte;
      End;

      qryIns.ExecSQL;
    End;

  Finally
    FreeAndNil(qryIns);
    FreeAndNil(stlMecanicos);
  End;
end;

procedure pApagaMecanicosServico( strNomtab, strAutInc, strIdeSer: String );
  Var
    qryDel: TUniQuery;
begin
  strNomtab := AnsiReplaceStr(strNomtab, 'MOV', 'MEC');
  
  qryDel := fCriaQuery;

  qryDel.SQL.Clear;
  qryDel.SQL.Add('DELETE FROM ' + strNomtab);
  qryDel.SQL.Add(' WHERE GER_SEQGER = :SEQGER');
  qryDel.SQL.Add('   AND GER_IDESER = :IDESER');

  qryDel.ParamByName('SEQGER').AsString := strAutInc;
  qryDel.ParamByName('IDESER').AsString := strIdeSer;
  qryDel.ExecSQL;

  FreeAndNil(qryDel);
end;

procedure pGravaMecanicosServico( strNomtab,
                                  strAutInc,
                                  strIdeSer,
                                  strCodSer: String;
                                  fltTotSer: Double;
                                  strMecanicos: String;
                                  fltQtdSer: Double );
  Var
    strCodMec: String;
    stlMecanicos: TStringList;
    qryIns: TUniQuery;
    blnComissaoPorValor: Boolean;
Begin
  strNomtab := AnsiReplaceStr(strNomtab, 'MOV', 'MEC');

  qryIns := fCriaQuery;
  stlMecanicos := TStringList.Create;
  stlMecanicos.CommaText := strMecanicos;

  Try
    qryIns.SQL.Add('INSERT INTO '+ strNomTab +'(');
    qryIns.SQL.Add('  GER_SEQGER,');
    qryIns.SQL.Add('  GER_IDESER,');
    qryIns.SQL.Add('  GER_CODMEC,');
    qryIns.SQL.Add('  GER_PCOMEC,');
    qryIns.SQL.Add('  GER_VCOMEC,');
    qryIns.SQL.Add('  GER_UNCOMC ');
    qryIns.SQL.Add(') VALUES (');
    qryIns.SQL.Add('  :SEQGER,');
    qryIns.SQL.Add('  :IDESER,');
    qryIns.SQL.Add('  :CODMEC,');
    qryIns.SQL.Add('  :PCOMEC,');
    qryIns.SQL.Add('  :VCOMEC,');
    qryIns.SQL.Add('  :UNCOMC ');
    qryIns.SQL.Add(')');

    qryIns.ParamByName('SEQGER').AsString := strAutInc;
    qryIns.ParamByName('IDESER').AsString := strIdeSer;

    For strCodMec In stlMecanicos Do
    Begin
      qryIns.ParamByName('CODMEC').AsString := strCodMec;
      qryIns.ParamByName('UNCOMC').AsFloat  := fGetUnitComMecanicoServico(strCodMec, strCodSer, stlMecanicos.Count, blnComissaoPorValor);

      If (Not blnComissaoPorValor) Then
      Begin
        qryIns.ParamByName('PCOMEC').AsFloat  := fGetPerComMecanicoServico(strCodMec, strCodSer, stlMecanicos.Count);
        qryIns.ParamByName('VCOMEC').AsFloat  := (qryIns.ParamByName('PCOMEC').AsFloat * fltTotSer / 100);
      End
      Else
      Begin
        qryIns.ParamByName('PCOMEC').AsFloat  := 0.00;
        qryIns.ParamByName('VCOMEC').AsFloat  := (qryIns.ParamByName('UNCOMC').AsFloat * fltQtdSer);
      End;

      qryIns.ExecSQL;
    End;

  Finally
    FreeAndNil(qryIns);
    FreeAndNil(stlMecanicos);
  End;

end;

procedure pGravaObservacaoServico(strNomTab, strAutInc, strIdeSer, strObservacao: String);
  Var
    qryIns: TUniQuery;
begin
  If fEmptyStr(strObservacao) Then
    Exit;

  strNomTab := AnsiReplaceStr(strNomTab, 'MOV', 'OBS');

  qryIns := fCriaQuery;
  Try
    qryIns.SQL.Add('INSERT INTO '+ strNomTab +'(');
    qryIns.SQL.Add('  GER_SEQGER,');
    qryIns.SQL.Add('  GER_IDESER,');
    qryIns.SQL.Add('  GER_OBSERV');
    qryIns.SQL.Add(') VALUES (');
    qryIns.SQL.Add('  :SEQGER,');
    qryIns.SQL.Add('  :IDESER,');
    qryIns.SQL.Add('  :OBSERV');
    qryIns.SQL.Add(')');

    qryIns.ParamByName('SEQGER').AsString := strAutInc;
    qryIns.ParamByName('IDESER').AsString := strIdeSer;
    qryIns.ParamByName('OBSERV').AsString := strObservacao;
    qryIns.ExecSQL;
  Finally
    FreeAndNil(qryIns);
  End;
end;

procedure pIncluiSerMov(strNomTab,
                        strAutInc: String;
                        recServicos: TDadosServicos);
  Var
    qrySerMov: TUniQuery;
    intServico: Integer;
    objServicos: TClassDadosServicos;
Begin
  qrySerMov := fCriaQuery(Nil);

  objServicos := TClassDadosServicos.Create(recServicos);

  With qrySerMov, SQL Do
  Begin
    Add('SELECT * FROM SERMOV WHERE FALSE ');

    Open;
    qrySerMov.Insert;

    FieldByName('GER_SEQGER').AsString := strAutInc;

    For intServico := 1 To 30 Do
    Begin
      If intServico >= 7 Then
      Begin
        If fEmptyStr(GetPropValue(objServicos, 'strCodS' + fStrZero(intServico.ToString, 2))) Then
          FieldByName('GER_CODS' + fStrZero(intServico.ToString, 2)).Value:= Null
        Else
          FieldByName('GER_CODS' + fStrZero(intServico.ToString, 2)).AsString := GetPropValue(objServicos, 'strCodS' + fStrZero(intServico.ToString, 2));

        FieldByName('GER_DESS' + fStrZero(intServico.ToString, 2)).AsString := GetPropValue(objServicos, 'strDesS' + fStrZero(intServico.ToString, 2));
        FieldByName('GER_VALS' + fStrZero(intServico.ToString, 2)).AsFloat  := GetPropValue(objServicos, 'fltValS' + fStrZero(intServico.ToString, 2));
      End;

      FieldByName('GER_QTDS' + fStrZero(intServico.ToString, 2)).AsFloat  := GetPropValue(objServicos, 'fltQtdS' + fStrZero(intServico.ToString, 2));
      FieldByName('GER_UNIS' + fStrZero(intServico.ToString, 2)).AsFloat  := GetPropValue(objServicos, 'fltUniS' + fStrZero(intServico.ToString, 2));
      FieldByName('GER_CUSS' + fStrZero(intServico.ToString, 2)).AsFloat  := GetPropValue(objServicos, 'fltCusS' + fStrZero(intServico.ToString, 2));
      FieldByName('GER_DECS' + fStrZero(intServico.ToString, 2)).AsFloat  := GetPropValue(objServicos, 'fltDecS' + fStrZero(intServico.ToString, 2));

      If Not fEmptyStr(GetPropValue(objServicos, 'strStaS' + fStrZero(intServico.ToString, 2))) Then
        FieldByName('GER_STAS' + fStrZero(intServico.ToString, 2)).AsString := GetPropValue(objServicos, 'strStaS' + fStrZero(intServico.ToString, 2));

      FieldByName('GER_BRIS' + fStrZero(intServico.ToString, 2)).AsString := GetPropValue(objServicos, 'strBriS' + fStrZero(intServico.ToString, 2));

      If Not fEmptyStr(GetPropValue(objServicos, 'strParS' + fStrZero(intServico.ToString, 2))) Then
        FieldByName('GER_PARS' + fStrZero(intServico.ToString, 2)).AsString := GetPropValue(objServicos, 'strParS' + fStrZero(intServico.ToString, 2));

      FieldByName('GER_TBRS' + fStrZero(intServico.ToString, 2)).AsString := GetPropValue(objServicos, 'strTBrS' + fStrZero(intServico.ToString, 2));
      FieldByName('GER_PRIS' + fStrZero(intServico.ToString, 2)).AsString := GetPropValue(objServicos, 'strPriS' + fStrZero(intServico.ToString, 2));
      FieldByName('GER_IDES' + fStrZero(intServico.ToString, 2)).AsString := GetPropValue(objServicos, 'strIdeS' + fStrZero(intServico.ToString, 2));

      If Not fEmptyStr(GetPropValue(objServicos, 'strVenS' + fStrZero(intServico.ToString, 2))) Then
        FieldByName('GER_VENS' + fStrZero(intServico.ToString, 2)).AsString := GetPropValue(objServicos, 'strVenS' + fStrZero(intServico.ToString, 2));

      If Not fEmptyStr(GetPropValue(objServicos, 'strVe2S' + fStrZero(intServico.ToString, 2))) Then
        FieldByName('GER_VE2S' + fStrZero(intServico.ToString, 2)).AsString := GetPropValue(objServicos, 'strVe2S' + fStrZero(intServico.ToString, 2));

      FieldByName('GER_CMVS' + fStrZero(intServico.ToString, 2)).AsFloat :=
        fGetValComVendedorServico(GetPropValue(objServicos, 'fltQtdS' + fStrZero(intServico.ToString, 2)),
                                  GetPropValue(objServicos, 'fltUniS' + fStrZero(intServico.ToString, 2)),
                                  GetPropValue(objServicos, 'strVenS' + fStrZero(intServico.ToString, 2)),
                                  GetPropValue(objServicos, 'strCodS' + fStrZero(intServico.ToString, 2)));

      If (fCfgSis('REPVEN', varBoolean)) And (Not fEmptyStr(GetPropValue(objServicos, 'strVe2S' + fStrZero(intServico.ToString, 2)))) Then
      Begin
        FieldByName('GER_CV2S' + fStrZero(intServico.ToString, 2)).AsFloat :=
          FieldByName('GER_CMVS' + fStrZero(intServico.ToString, 2)).AsFloat * (fCfgSis('TAXREP', varDouble) / 100);

        FieldByName('GER_CMVS' + fStrZero(intServico.ToString, 2)).AsFloat :=
          FieldByName('GER_CMVS' + fStrZero(intServico.ToString, 2)).AsFloat - FieldByName('GER_CV2S' + fStrZero(intServico.ToString, 2)).AsFloat;
      End
      Else
        FieldByName('GER_CV2S' + fStrZero(intServico.ToString, 2)).AsFloat := 0;
    End;

    FieldByName('GER_NROPRO').AsInteger := objServicos.intNroPro;

    If objServicos.dtaSerIni > 0 Then
      FieldByName('GER_SERINI').AsDateTime := objServicos.dtaSerIni;

    If objServicos.dtaSerFin > 0 Then
      FieldByName('GER_SERFIN').AsDateTime := objServicos.dtaSerFin;

    If Not fEmptyStr(objServicos.strSerObs) Then
      FieldByName('GER_SEROBS').AsString := objServicos.strSerObs;

    FieldByName('GER_MUNPRE').AsString := objServicos.strMunPre;

    FieldByName('GER_NATSER').AsString := recServicos.strNatSer;

    Post;
  End;

  FreeAndNil(objServicos);
  FreeAndNil(qrySerMov);
End;

procedure pGravaMecanicosItemPD(strAutInc, strMecanicos: String);
  Var
    strCodMec: String;
    stlMecanicos: TStringList;
begin
  stlMecanicos := TStringList.Create;
  stlMecanicos.CommaText := strMecanicos;

  For strCodMec In stlMecanicos Do
    fExecutaSQL('INSERT INTO MECDOR (FDO_SEQFDO, FDO_CODMEC) ' +
                'VALUES (' + QuotedStr(strAutInc) + ',' + QuotedStr(strCodMec) + ')');

  stlMecanicos.Destroy;
end;

procedure pGravaMecanicosServicoPD(strAutInc, strIdeSer, strMecanicos: String);
  Var
    strCodMec: String;
    stlMecanicos: TStringList;
    qryIns: TUniQuery;
begin
  qryIns := fCriaQuery;
  stlMecanicos := TStringList.Create;
  stlMecanicos.CommaText := strMecanicos;
  Try
    qryIns.SQL.Add('INSERT INTO MECGOR(');
    qryIns.SQL.Add('  FGO_SEQFGO,');
    qryIns.SQL.Add('  FGO_IDESER,');
    qryIns.SQL.Add('  FGO_CODMEC');
    qryIns.SQL.Add(') VALUES (');
    qryIns.SQL.Add('  :SEQFGO,');
    qryIns.SQL.Add('  :IDESER,');
    qryIns.SQL.Add('  :CODMEC');
    qryIns.SQL.Add(')');

    qryIns.ParamByName('SEQFGO').AsString := strAutInc;
    qryIns.ParamByName('IDESER').AsString := strIdeSer;

    For strCodMec In stlMecanicos Do
    Begin
      qryIns.ParamByName('CODMEC').AsString := strCodMec;
      qryIns.ExecSQL;
    End;
  Finally
    FreeAndNil(qryIns);
    FreeAndNil(stlMecanicos);
  End;
end;

procedure pGravaObservacaoServicoPD(strAutInc, strIdeSer, strObservacao: String);
  Var
    qryIns: TUniQuery;
begin
  If fEmptyStr(strObservacao) Then
    Exit;

  qryIns := fCriaQuery;
  Try
    qryIns.SQL.Add('INSERT INTO OBSGOR(');
    qryIns.SQL.Add('  FGO_SEQFGO,');
    qryIns.SQL.Add('  FGO_IDESER,');
    qryIns.SQL.Add('  FGO_OBSERV');
    qryIns.SQL.Add(') VALUES (');
    qryIns.SQL.Add('  :SEQFGO,');
    qryIns.SQL.Add('  :IDESER,');
    qryIns.SQL.Add('  :OBSERV');
    qryIns.SQL.Add(')');

    qryIns.ParamByName('SEQFGO').AsString := strAutInc;
    qryIns.ParamByName('IDESER').AsString := strIdeSer;
    qryIns.ParamByName('OBSERV').AsString := strObservacao;
    qryIns.ExecSQL;
  Finally
    FreeAndNil(qryIns);
  End;
end;

function fGetUnitComMecanicoItem(strCodMec, strCodIte: String; intQtdMec: Integer; var blnComissaoPorValor: Boolean): Double;
  Var
    qryIteGer : TUniQuery;
    strOpcMec : String;
begin
  strOpcMec := fCfgSis('OPCMEC', VarString);
  Result := 0.00;
  blnComissaoPorValor := False;

  Try
    qryIteGer := fCriaQuery;

    With qryIteGer Do
    Begin

      If (strOpcMec = 'CO') Then //Cadastro de Operadores
      Begin
        SQL.Add('  SELECT OPE_MECCIT AS UNTCOM ');
        SQL.Add('    FROM CADOPE ');
        SQL.Add('   WHERE OPE_CODOPE = :CODMEC ');
        SQL.Add('     AND OPE_TPCOMC = "V"     ');
        ParamByName('CODMEC').AsString := strCodMec;
      End
      Else If (strOpcMec = 'CPS') Then // Cadastro de Produtos/Serviços
      Begin
        SQL.Add('  SELECT ITE_COMMEC AS UNTCOM ');
        SQL.Add('    FROM ITEGER ');
        SQL.Add('   WHERE ITE_CODITE = :CODITE ');
        SQL.Add('     AND ITE_CODEMP = :CODEMP ');
        SQL.Add('     AND ITE_TPCOMC = "V"     ');
        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
      End;

      Open;

      If (Not IsEmpty) Then
      Begin
        blnComissaoPorValor := True;

        Result := FieldByName('UNTCOM').AsFloat;

        If (strOpcMec = 'CPS') And (intQtdMec <> 0) Then
          Result := (Result / intQtdMec);
      End;
    End;
  Finally
    FreeAndNil(qryIteGer);
  End;
end;

function fGetUnitComMecanicoServico(strCodMec, strCodSer: String; intQtdMec: Integer; var blnComissaoPorValor: Boolean): Double;
  Var
    qryIteGer : TUniQuery;
    strOpcMec : String;
begin
  strOpcMec := fCfgSis('OPCMEC', VarString);
  Result := 0.00;
  blnComissaoPorValor := False;

  Try
    qryIteGer := fCriaQuery;

    With qryIteGer Do
    Begin

      If (strOpcMec = 'CO') Then //Cadastro de Operadores
      Begin
        SQL.Add('  SELECT OPE_MECCSE AS UNTCOM ');
        SQL.Add('    FROM CADOPE ');
        SQL.Add('   WHERE OPE_CODOPE = :CODMEC ');
        SQL.Add('     AND OPE_TPCOMC = "V"     ');
        ParamByName('CODMEC').AsString := strCodMec;
      End
      Else If (strOpcMec = 'CPS') Then // Cadastro de Produtos/Serviços
      Begin
        SQL.Add('  SELECT SER_COMMEC AS UNTCOM ');
        SQL.Add('    FROM CADSER ');
        SQL.Add('   WHERE SER_CODSER = :CODSER ');
        SQL.Add('     AND SER_TPCOMC = "V"     ');
        ParamByName('CODSER').AsString := strCodSer;
      End;

      Open;

      If (Not IsEmpty) Then
      Begin
        blnComissaoPorValor := True;

        Result := FieldByName('UNTCOM').AsFloat;

        If (strOpcMec = 'CPS') And (intQtdMec <> 0) Then
          Result := (Result / intQtdMec);
      End;
    End;
  Finally
    FreeAndNil(qryIteGer);
  End;
end;

end.
