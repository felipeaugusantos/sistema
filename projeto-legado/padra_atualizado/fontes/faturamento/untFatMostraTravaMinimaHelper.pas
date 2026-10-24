unit untFatMostraTravaMinimaHelper;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  UniClientDataSet, untFuncFat,
{$ENDIF}
  Faturamento.Classes.TFatVendaBase,
  DB, SysUtils, untFuncFatTypes, Classes, Variants;

type
  TrecItem = Record
    strCodIte,
    strIdePro: String;
    fltQtdIte,
    fltPreCus,
    fltPreTab: Double;
end;

type
  TMostraTravaMinimaHelper = Class
  private

  public
    class procedure pCriaClient(Var cdsTravaMinima: TUniClientDataSet; Owner: TComponent);
    class procedure pDestroyClient(cdsTravaMinima: TUniClientDataSet);
    class procedure pAddItemTravaMinima(cdsTravaMinima, cdsItensVenda: TUniClientDataSet;
      fltUniTraPro, fltUniTraProNv2, fltUniTraProNv3, fltUniTraProNv4, fltUniTraProNv5, fltUniTraProNv6: Double; strOpcDoc: String;
      travaMinima: TMostraTravaMinima; fatVenda: TFatVendaBase);
    class procedure pVerificaItensDeletados(cdsItensVenda, cdsTravaMinima: TUniClientDataSet);
    class procedure pAtualizaAutInc(strAutInc, strCodIte: String; cdsTravaMinima: TUniClientDataSet);
    class function fExibeTravaMinima: Boolean;
    {$IFNDEF LINUX}
    class procedure pExibeDados(cdsTravaMinima: TUniClientDataSet; fatVenda: TFatVenda);
    {$ENDIF}
  End;

implementation

uses
{$IFDEF LINUX}
  untFuncoesGenerica,
{$ELSE}
  untFuncoesSimples, untFatMostraTravasMinimas,
{$ENDIF}
  untMargemMinima;

{ TMostraTravaMinimaHelper }

class function TMostraTravaMinimaHelper.fExibeTravaMinima: Boolean;
begin
  Result := (VS_strTRADES = '2') Or (VS_strTRADES = '3');
end;

class procedure TMostraTravaMinimaHelper.pAddItemTravaMinima(
  cdsTravaMinima, cdsItensVenda: TUniClientDataSet; fltUniTraPro, fltUniTraProNv2,
  fltUniTraProNv3, fltUniTraProNv4, fltUniTraProNv5, fltUniTraProNv6: Double; strOpcDoc: String; travaMinima: TMostraTravaMinima;
  fatVenda: TFatVendaBase);
  Var
    fltPreTab,
    fltPreCus,
    fltTaxJur,
    fltUniVis: Double;
    strPromoc : String;
    strPromocSav: String;
    intDecUni : Integer;
    intDecQtd : Integer;

  function fCalculaMargem(recItem: TrecItem; fltUniTra: Double; intNivel: Integer): Double;
    Var
      strMarMinCmp: String;
  Begin
    If SameText(VS_strTRADES, '2') Then
    Begin
      Result := 0;
      If recItem.fltPreTab <> 0 Then
        Result := (100 - ((fltUniTra / recItem.fltPreTab) * 100));

      Result := fFormataFloat(Result, 2)
    End

    Else If (fUsaTravaPorMargemMinimaLiquida) Then
    Begin
      If (recItem.strIdePro <> 'NOR') And (fAnalisaTodosCompomentesAoTravarUnitarioDeTintaComoProdutoNormal) Then
      Begin
        Result := 0;
        If recItem.fltPreCus <> 0 Then
          Result := (((fltUniTra / recItem.fltPreCus) - 1) * 100);

        Result := fFormataFloat(Result, 4);
      End
      Else
      Begin
        Case intNivel Of
          2:   strMarMinCmp := 'ITE_MARMMV'; //Vendedor Master
          3:   strMarMinCmp := 'ITE_MARMSG'; //Sub-Gerente Júnior
          4:   strMarMinCmp := 'ITE_MARMMS'; //Sub-Gerente Master
          5:   strMarMinCmp := 'ITE_MARMGE'; //Gerente Júnior
          6:   strMarMinCmp := 'ITE_MARMMG'; //Gerente Master
          Else strMarMinCmp := 'ITE_MARMIN'; //Vendedor
        End;

        Result := fCampoTabela(strMarMinCmp, 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [recItem.strCodIte, VS_strCodEmp], False);
      End;
    End

    Else
    Begin
      Result := 0;
      If fltUniTra <> 0 Then
        Result := (100 - ((recItem.fltPreCus / fltUniTra) * 100));

      Result := fFormataFloat(fTruncaFloat(Result, 2), 2);
    End;
  End;

  procedure pProcessaNiveis();
    Var
      recItem: TrecItem;
  begin
    If Assigned(travaMinima) Then
    Begin
      recItem.strCodIte := travaMinima.strCodIte;
      recItem.fltQtdIte := travaMinima.fltQtdIte;
      recItem.strIdePro := travaMinima.strIdePro;
      recItem.fltPreCus := travaMinima.fltPreCus;
      recItem.fltPreTab := travaMinima.fltVlrTab;
    End
    Else
    Begin
      recItem.strCodIte := cdsItensVenda.FieldByName('ITE_CODITE').AsString;
      recItem.fltQtdIte := cdsItensVenda.FieldByName('ITE_QTDITE').AsFloat;
      recItem.strIdePro := cdsItensVenda.FieldByName('ITE_IDEPRO').AsString;
      recItem.fltPreCus := fltPreCus;
      recItem.fltPreTab := fltPreTab;
    End;

    If SameText(VS_strTRADES, '2') Then
    Begin
      cdsTravaMinima.FieldByName('DEMAXV').AsFloat    := fCalculaMargem(recItem, fltUniTraPro, 1);
      cdsTravaMinima.FieldByName('VLMINV').AsFloat    := fltUniTraPro;
      cdsTravaMinima.FieldByName('TOTVLMINV').AsFloat := fFormataFloat(fltUniTraPro * recItem.fltQtdIte, intDecUni);
      // Vendedor Master
      cdsTravaMinima.FieldByName('DEMAVM').AsFloat    := fCalculaMargem(recItem, fltUniTraProNv2, 2);
      cdsTravaMinima.FieldByName('VLMIVM').AsFloat    := fltUniTraProNv2;
      cdsTravaMinima.FieldByName('TOTVLMIVM').AsFloat := fFormataFloat(fltUniTraProNv2 * recItem.fltQtdIte, intDecUni);
      // Sub-Gerente Júnior
      cdsTravaMinima.FieldByName('DEMAXS').AsFloat    := fCalculaMargem(recItem, fltUniTraProNv3, 3);
      cdsTravaMinima.FieldByName('VLMINS').AsFloat    := fltUniTraProNv3;
      cdsTravaMinima.FieldByName('TOTVLMINS').AsFloat := fFormataFloat(fltUniTraProNv3 * recItem.fltQtdIte, intDecUni);
      // Sub-Gerente Master
      cdsTravaMinima.FieldByName('DEMASM').AsFloat    := fCalculaMargem(recItem, fltUniTraProNv4, 4);
      cdsTravaMinima.FieldByName('VLMISM').AsFloat    := fltUniTraProNv4;
      cdsTravaMinima.FieldByName('TOTVLMISM').AsFloat := fFormataFloat(fltUniTraProNv4 * recItem.fltQtdIte, intDecUni);
      // Gerente Júnior
      cdsTravaMinima.FieldByName('DEMAXG').AsFloat    := fCalculaMargem(recItem, fltUniTraProNv5, 5);
      cdsTravaMinima.FieldByName('VLMING').AsFloat    := fltUniTraProNv5;
      cdsTravaMinima.FieldByName('TOTVLMING').AsFloat := fFormataFloat(fltUniTraProNv5 * recItem.fltQtdIte, intDecUni);
      // Gerente Master
      cdsTravaMinima.FieldByName('DEMAGM').AsFloat    := fCalculaMargem(recItem, fltUniTraProNv6, 6);
      cdsTravaMinima.FieldByName('VLMIGM').AsFloat    := fltUniTraProNv6;
      cdsTravaMinima.FieldByName('TOTVLMIGM').AsFloat := fFormataFloat(fltUniTraProNv6 * recItem.fltQtdIte, intDecUni);
    End
    Else
    Begin
      cdsTravaMinima.FieldByName('MRMINV').AsFloat     := fCalculaMargem(recItem, fltUniTraPro, 1);
      cdsTravaMinima.FieldByName('VLMINV_').AsFloat    := fltUniTraPro;
      cdsTravaMinima.FieldByName('TOTVLMINV_').AsFloat := fFormataFloat(fltUniTraPro * recItem.fltQtdIte, intDecUni);
      // Vendedor Master
      cdsTravaMinima.FieldByName('MRMNVM').AsFloat     := fCalculaMargem(recItem, fltUniTraProNv2, 2);
      cdsTravaMinima.FieldByName('VLMINVM').AsFloat    := fltUniTraProNv2;
      cdsTravaMinima.FieldByName('TOTVLMINVM').AsFloat := fFormataFloat(fltUniTraProNv2 * recItem.fltQtdIte, intDecUni);
      // Sub-Gerente Júnior
      cdsTravaMinima.FieldByName('MRMINS').AsFloat     := fCalculaMargem(recItem, fltUniTraProNv3, 3);
      cdsTravaMinima.FieldByName('VLMINS_').AsFloat    := fltUniTraProNv3;
      cdsTravaMinima.FieldByName('TOTVLMINS_').AsFloat := fFormataFloat(fltUniTraProNv3 * recItem.fltQtdIte, intDecUni);
      // Sub-Gerente Master
      cdsTravaMinima.FieldByName('MRMNSM').AsFloat     := fCalculaMargem(recItem, fltUniTraProNv4, 4);
      cdsTravaMinima.FieldByName('VLMINSM').AsFloat    := fltUniTraProNv4;
      cdsTravaMinima.FieldByName('TOTVLMINSM').AsFloat := fFormataFloat(fltUniTraProNv4 * recItem.fltQtdIte, intDecUni);
      // Gerente Júnior
      cdsTravaMinima.FieldByName('MRMING').AsFloat     := fCalculaMargem(recItem, fltUniTraProNv5, 5);
      cdsTravaMinima.FieldByName('VLMING_').AsFloat    := fltUniTraProNv5;
      cdsTravaMinima.FieldByName('TOTVLMING_').AsFloat := fFormataFloat(fltUniTraProNv5 * recItem.fltQtdIte, intDecUni);
      // Gerente Master
      cdsTravaMinima.FieldByName('MRMNGM').AsFloat     := fCalculaMargem(recItem, fltUniTraProNv6, 6);
      cdsTravaMinima.FieldByName('VLMINGM').AsFloat    := fltUniTraProNv6;
      cdsTravaMinima.FieldByName('TOTVLMINGM').AsFloat := fFormataFloat(fltUniTraProNv6 * recItem.fltQtdIte, intDecUni);
    End;
  end;

  function fGetPrecoMedioOperacao(const AField : TField; const ACodIte, ACodEmp : String) : Double;
  begin
    Result := 0;
    If (Assigned(AField)) Then
      Result := AField.AsFloat;
    If (Result <> 0) Then
      Exit;
    Result := fCampoTabela('ITE_PREMED', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [ACodIte, ACodEmp], False);
  end;

  function fPrecoMedioReal(const APrecoMedio, APrecoVenda : Double) : Double;
    Var
      calcCustoReal : TCalcCustoReal;
      strCodSit : String;
      strCodAbf : String;
      strEmpresaItem : String;
  begin
    calcCustoReal := TCalcCustoReal.Create;
    Try
      strEmpresaItem := IIF(cdsItensVenda.FieldByName('ITE_EMPITE').AsString.IsEmpty, VS_strCodEmp, cdsItensVenda.FieldByName('ITE_EMPITE').AsString);

      calcCustoReal.fltUnitar := APrecoVenda;
      calcCustoReal.fltPreCus := APrecoMedio;
      calcCustoReal.fltOutVal := fatVenda.fRetOutVal(cdsItensVenda.FieldByName('ITE_OUTVAL').AsFloat);
      calcCustoReal.fltIcmSai := fatVenda.fRetImpFed(cdsItensVenda.FieldByName('ITE_ICMSAI').AsFloat);
      calcCustoReal.fltImpFed := cdsItensVenda.FieldByName('ITE_IMPFED').AsFloat;
      calcCustoReal.fltDesOpe := fatVenda.fProcessarDespesasOperacionaisComplementar(fatVenda.fRetDesOpe(cdsItensVenda.FieldByName('ITE_DESOPE').AsFloat));

      strCodSit := '';
      strCodAbf := fGetCodAbf(cdsItensVenda.FieldByName('ITE_CODITE').AsString, fatVenda.fGetEmpCalculoItem(strEmpresaItem));
      If (Not fEmptyStr(fatVenda.GetTipAbf(strEmpresaItem))) And (fatVenda.fBuscaAbfIcm(cdsItensVenda.FieldByName('ITE_CODITE').AsString, strEmpresaItem, strCodAbf, fatVenda.fTrocaUFEndEntrega)) Then
        strCodSit := fatVenda.cdsAbfIcm.FieldByName('ABF_CODSIT' + fatVenda.GetTipAbf(strEmpresaItem)).AsString;

      calcCustoReal.fltDifal := fatVenda.fGetAlqDifal(cdsItensVenda.FieldByName('ITE_CODITE').AsString,
                                                      strEmpresaItem,
                                                      strCodAbf,
                                                      strCodSit);

      calcCustoReal.fltFcp   := fatVenda.fGetAlqFcpIcms(cdsItensVenda.FieldByName('ITE_CODITE').AsString,
                                                        strEmpresaItem,
                                                        strCodAbf,
                                                        strCodSit,
                                                        cdsItensVenda.FieldByName('ITE_ICMSAI').AsFloat,
                                                        calcCustoReal.fltUnitar);

      Result := fatVenda.fRetornaPrecoCusto(Preco_de_Custo_Real,
                                            cdsItensVenda.FieldByName('ITE_CODITE').AsString,
                                            strEmpresaItem,
                                            0,
                                            '',
                                            calcCustoReal,
                                            (Pos('ITEM ESPECIAL', cdsItensVenda.FieldByName('ITE_DESITE').AsString) > 0));
    Finally
      FreeAndNil(calcCustoReal);
    End;
  end;

Begin

  intDecUni := fCfgSis('DECUNI', varInteger);
  intDecQtd := fCfgSis('DECQTD', varInteger);

  If Assigned(travaMinima) Then
  Begin
    With cdsTravaMinima Do
    Begin
      If Locate('AUTINC;CODITE', VarArrayOf([travaMinima.strAutInc, travaMinima.strCodIte]), []) Then
        Edit
      Else
        Append;

      FieldByName('AUTINC').AsString := travaMinima.strAutInc;
      FieldByName('CODITE').AsString := travaMinima.strCodIte;
      FieldByName('EMPITE').AsString := travaMinima.strEmpIte;
      FieldByName('DESITE').AsString := travaMinima.strDesIte;
      FieldByName('UNIDAD').AsString := travaMinima.strUnidad;
      FieldByName('IDEPRO').AsString := travaMinima.strIdePro;
      FieldByName('QTDITE').AsFloat  := fFormataFloat(travaMinima.fltQtdIte,intDecQtd);
      FieldByName('VLRTAB').AsFloat  := fFormataFloat(travaMinima.fltVlrTab,intDecUni);
      FieldByName('TOTVLRTAB').AsFloat := fFormataFloat(travaMinima.fltVlrTab * travaMinima.fltQtdIte,intDecUni);

      pProcessaNiveis();

      Post;
    End;
  End
  Else
  Begin
    strPromoc := 'N';

    If (cdsItensVenda.FindField('ITE_PROMOC') <> Nil) Then
      strPromoc := cdsItensVenda.FieldByName('ITE_PROMOC').AsString;

    With cdsItensVenda Do
    Begin
      If fatVenda.fUtilizaPrecoEmbalagemFechadaComoMinimo(FieldByName('ITE_IDEPRO').AsString,
                                                          FieldByName('ITE_CODITE').AsString,
                                                          FieldByName('ITE_TABPRE').AsString,
                                                          strPromoc,
                                                          FieldByName('ITE_QTDITE').AsFloat) Then
      Begin
        fltPreTab := fatVenda.fGetUnitarioEmbalagemFechada(FieldByName('ITE_CODITE').AsString,
                                                           FieldByName('ITE_TABPRE').AsString,
                                                           FieldByName('ITE_QTDITE').AsFloat,
                                                           FieldByName('ITE_UNIORI').AsFloat);
      End
      Else If fatVenda.fUtilizaPrecoTabelaTravaProdutoEmbalagem(FieldByName('ITE_IDEPRO').AsString,
                                                                FieldByName('ITE_CODITE').AsString,
                                                                FieldByName('ITE_BAREMB').AsString) Then
      Begin
        strPromocSav := fatVenda.strPromoc;
        fatVenda.strPromoc := FieldByName('ITE_PROMOC').AsString;
      
        fltPreTab := fatVenda.fPegaPrecoVenda(cdsItensVenda,
                                              FieldByName('ITE_EMPITE').AsString,
                                              FieldByName('ITE_ENTSAI').AsString,
                                              fatVenda.fltMargem,
                                              (Pos('ITEM ESPECIAL', FieldByName('ITE_DESITE').AsString) > 0),
                                              'NOR',
                                              FieldByName('ITE_TABPRE').AsString,
                                              True,
                                              fltTaxJur,
                                              fltUniVis);

        fatVenda.strPromoc := strPromocSav;                                                                      
      End
      Else
        fltPreTab := IIF(Pos(strOpcDoc, 'DV_PR_DD_CR_') > 0, FieldByName('ITE_UNIDEV').AsFloat, FieldByName('ITE_UNIORI').AsFloat);

      If (fCfgSis('MMPOPM') = 'B') Then
      Begin
        If (TMargemMinima.UsaPrecoMedio) Then
          fltPreCus := fGetPrecoMedioOperacao(cdsItensVenda.FieldByName('ITE_PREMED'), FieldByName('ITE_CODITE').AsString, IIF(FieldByName('ITE_EMPITE').AsString.IsEmpty, VS_strCodEmp, FieldByName('ITE_EMPITE').AsString))
        Else
          fltPreCus := cdsItensVenda.FieldByName('ITE_PRECUS').AsFloat
      End
      Else
      Begin
        If (TMargemMinima.UsaPrecoMedio) Then
          fltPreCus := fPrecoMedioReal(fGetPrecoMedioOperacao(cdsItensVenda.FieldByName('ITE_PREMED'), FieldByName('ITE_CODITE').AsString, IIF(FieldByName('ITE_EMPITE').AsString.IsEmpty, VS_strCodEmp, FieldByName('ITE_EMPITE').AsString)), fltPreTab)
        Else
          fltPreCus := cdsItensVenda.FieldByName('ITE_PRECU2').AsFloat;
      End;

      If Not cdsTravaMinima.Locate('AUTINC;CODITE', VarArrayOf([FieldByName('AUTOINCREM').AsString, FieldByName('ITE_CODITE').AsString]), []) Then
      Begin
        cdsTravaMinima.Append;
        cdsTravaMinima.FieldByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
        cdsTravaMinima.FieldByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
        cdsTravaMinima.FieldByName('EMPITE').AsString := FieldByName('ITE_EMPITE').AsString;
        cdsTravaMinima.FieldByName('DESITE').AsString := FieldByName('ITE_DESITE').AsString;
        cdsTravaMinima.FieldByName('UNIDAD').AsString := FieldByName('ITE_SIGUNI').AsString;
        cdsTravaMinima.FieldByName('IDEPRO').AsString := FieldByName('ITE_IDEPRO').AsString;
        cdsTravaMinima.FieldByName('QTDITE').AsFloat  := fFormataFloat(FieldByName('ITE_QTDITE').AsFloat, intDecQtd);
        cdsTravaMinima.FieldByName('VLRTAB').AsFloat  := fFormataFloat(fltPreTab, intDecUni);
        cdsTravaMinima.FieldByName('TOTVLRTAB').AsFloat := fFormataFloat(fltPreTab * FieldByName('ITE_QTDITE').AsFloat, intDecUni);
      End
      Else
        cdsTravaMinima.Edit;

      pProcessaNiveis();

      cdsTravaMinima.Post;
    End;
  End;
end;

class procedure TMostraTravaMinimaHelper.pAtualizaAutInc(strAutInc,
  strCodIte: String; cdsTravaMinima: TUniClientDataSet);
  Var
    strIndice : String;
begin
  strIndice := cdsTravaMinima.IndexFieldNames;

  With cdsTravaMinima Do
  Begin
    IndexFieldNames := 'CODITE';
    First;
    FindKey([strCodIte]);
    
    While (Not Eof) Do
    Begin
      If (FieldByName('CODITE').AsString = strCodIte) And (fEmptyStr(FieldByName('AUTINC').AsString)) Then
      Begin
        Edit;
        FieldByName('AUTINC').AsString := strAutInc;
        Post;
      End;

      Next;

      If (FieldByName('CODITE').AsString <> strCodIte) Then
        Break;
    End;
  End;

  cdsTravaMinima.IndexFieldNames := strIndice;
end;

class procedure TMostraTravaMinimaHelper.pCriaClient(Var cdsTravaMinima: TUniClientDataSet; Owner: TComponent);
begin
  If Assigned(cdsTravaMinima) Then
    FreeAndNil(cdsTravaMinima);

  cdsTravaMinima := TUniClientDataSet.Create(Owner);

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'AUTINC';
    DataType := ftString;
    Size := 020;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODITE';
    DataType := ftString;
    Size := fTamCodIte;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'EMPITE';
    DataType := ftString;
    Size := 3;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESITE';
    DataType := ftString;
    Size := 060;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'UNIDAD';
    DataType := ftString;
    Size := 002;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'QTDITE';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'IDEPRO';
    DataType := ftString;
    Size := 003;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VLRTAB';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTVLRTAB';
    DataType := ftFloat;
    Required := False;
  End;

  {******************************************}
  {* CAMPOS PARA VISUALIZAR DESCONTO MÁXIMO *}
  {***************************************FC*}
  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DEMAXV';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VLMINV';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTVLMINV';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DEMAXS';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VLMINS';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTVLMINS';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DEMAXG';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VLMING';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTVLMING';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DEMAVM';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VLMIVM';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTVLMIVM';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DEMASM';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VLMISM';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTVLMISM';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DEMAGM';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VLMIGM';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTVLMIGM';
    DataType := ftFloat;
    Required := False;
  End;

  {**********************************************}
  {* CAMPOS PARA VISUALIZAR MARGEM MIN. PRODUTO *}
  {*******************************************FC*}
  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MRMINV';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VLMINV_';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTVLMINV_';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MRMINS';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VLMINS_';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTVLMINS_';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MRMING';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VLMING_';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTVLMING_';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MRMNVM';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VLMINVM';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTVLMINVM';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MRMNSM';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VLMINSM';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTVLMINSM';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MRMNGM';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VLMINGM';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsTravaMinima.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTVLMINGM';
    DataType := ftFloat;
    Required := False;
  End;

  cdsTravaMinima.CreateDataSet;
  cdsTravaMinima.EmptyDataSet;
  cdsTravaMinima.IndexFieldNames := 'AUTINC';
  cdsTravaMinima.LogChanges := False;
end;

class procedure TMostraTravaMinimaHelper.pDestroyClient(
  cdsTravaMinima: TUniClientDataSet);
begin
  If Assigned(cdsTravaMinima) Then
    FreeAndNil(cdsTravaMinima);
end;

{$IFNDEF LINUX}
class procedure TMostraTravaMinimaHelper.pExibeDados(cdsTravaMinima: TUniClientDataSet;
  fatVenda: TFatVenda);
  Var
    frmFatMostraTravasMinimas: TfrmFatMostraTravasMinimas;
begin
  If fExibeTravaMinima Then
  Begin
    If fCfgSis('VMNSEM', varBoolean) Or
       fVerificaAcessoSistema('VEMIN', strLoginUsuarioLogado)  Or
       fVerificaAcessoSistema('VEMIN2', strLoginUsuarioLogado) Or
       fVerificaAcessoSistema('VEMIN3', strLoginUsuarioLogado) Or
       fVerificaAcessoSistema('VEMIN4', strLoginUsuarioLogado) Or
       fVerificaAcessoSistema('VEMIN5', strLoginUsuarioLogado) Or
       fVerificaAcessoSistema('VEMIN6', strLoginUsuarioLogado) Then
    Begin
      Try
        pCriarFormularios(TfrmFatMostraTravasMinimas, frmFatMostraTravasMinimas);

        If fatVenda <> Nil Then
        Begin
          If Not cdsVenda.IsEmpty Then
          Begin
            fatVenda.fVerificaVrMinimo(fatVenda.fltTotGer,
                                       fatVenda.fltTotGer,
                                       fatVenda.intPrzMed,
                                       '',
                                       False,
                                       False);

            frmFatMostraTravasMinimas.cdsDados := cdsTravaMinima;
            frmFatMostraTravasMinimas.ShowModal;
          End;
        End
        Else
        Begin
          frmFatMostraTravasMinimas.cdsDados := cdsTravaMinima;
          frmFatMostraTravasMinimas.ShowModal;
        End;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TMostraTravaMinimaHelper.mnuMostraTravasMinimasClick]');
      End;

      pFreeAndNil(frmFatMostraTravasMinimas);
    End
    Else
      fMensagem('ATENÇÃO!', 'O usuário logado não possui permissão para visualizar estes dados!', ['&0 K']);
  End;
end;
{$ENDIF}

class procedure TMostraTravaMinimaHelper.pVerificaItensDeletados(cdsItensVenda, cdsTravaMinima: TUniClientDataSet);
  Var
    cdsDados: TUniClientDataSet;
begin
  cdsDados := TUniClientDataSet.Create(nil);
  pCloneDataSet(cdsDados, cdsItensVenda);

  {**************************************************}
  {* VERIFICA SE NENHUM PRODUTO FOI EXCLUI DA VENDA *}
  {* E TIRA DO DATASET DE TRAVAS MINIMAS            *}
  {***********************************************FC*}
  cdsTravaMinima.First;

  While Not cdsTravaMinima.Eof Do
  begin
    If fEmptyStr(cdsTravaMinima.FieldByName('AUTINC').AsString) Then
      cdsTravaMinima.Delete
    Else
    Begin
      If Not cdsDados.Locate('AUTOINCREM;ITE_CODITE', VarArrayOf([cdsTravaMinima.FieldByName('AUTINC').AsString, cdsTravaMinima.FieldByName('CODITE').AsString]), []) Then
        cdsTravaMinima.Delete
      Else
      Begin
        If cdsTravaMinima.FieldByName('QTDITE').AsFloat <> cdsDados.FieldByName('ITE_QTDITE').AsFloat Then
        Begin
          cdsTravaMinima.Edit;
          cdsTravaMinima.FieldByName('QTDITE').AsFloat := cdsDados.FieldByName('ITE_QTDITE').AsFloat;
          cdsTravaMinima.Post;
        End;
        cdsTravaMinima.Next;
      End;        
    End;
  End;

  FreeAndNil(cdsDados);
end;

end.

