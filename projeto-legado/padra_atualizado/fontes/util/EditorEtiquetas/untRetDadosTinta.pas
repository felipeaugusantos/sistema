unit untRetDadosTinta;

interface

uses
  untFuncoesSimples, Uni, UniClientDataSet, Classes, StrUtils, Forms, SysUtils, Data.DB;

Var
  strSQL: String;
  qryDados: TUniQuery;

//Imobiliarias & Industriais
  procedure RetornaDadosTintaSuvinil(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaBautech(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaCoralImobiliaria(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaFutura(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaSherwinWilliams(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaCiaCollor(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaQualyVinil(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaDacar(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaDacasa(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaLuztol(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaAnjoImobiliaria(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaRennerImobiliaria(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaMontana(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaMegaTintas(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaAlterPlus(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaAlessiImobiliaria(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaSparlack(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaJotun(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaFalcao(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaBrasimixImobiliaria(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaEucatexImobiliaria(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaMazaImobiliaria(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaMaestria(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaVelutexImobiliaria(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaUniverso(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaHydronorthImobiliaria(const strItetin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaLiko(const strItetin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaLeinertex(const strItetin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaIquine(const strItetin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaRecoa(const strItetin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaCalamar(const strItetin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaKilling(const strItetin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaAnnetta(const strItetin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaInternational(const strItetin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaLukscolor(const strItetin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaBellaCor(const strItetin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaGlobalColor(const strItetin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaAnjoSintetica(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaRennerIndustrial(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaResicolor(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaSayerlack(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaSinteplast(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaWeg(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaAdvance(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaAdvanceTintoSystem(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaAdvanceStr(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaGrafftex(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaSherwinWilliams2(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaGlobalBsn(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaGlobalBc(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaBellaCorTintavel(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaTexturaCia(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaChreon(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaGlobalCsn(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaGlobalCc11(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaLukscolor2(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaColorbraz(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaInkor(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaKresil(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaMaxVinil(const strIteTin: String; const dicRetorno: TDicionario);

  //Tintas Automotivas
  procedure RetornaDadosTintaLazzumix(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaAxalta(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaMazaIndustrial(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaMazaAutomotiva(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaStarmixWeb(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaGeneral(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaColorPro(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaAnjoAutomotiva(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaAutoluks(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaTopCoat(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaBrasimixAutomotiva(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaBrazilianColorAutomotiva(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaFarbenAutomotiva(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaDuxone(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaDuxone2(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaSkyMixAutomotiva(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaPpg(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaStandox(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaNexa(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaStarmix(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaPpgNexa(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaLechler(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaRennerPerformance(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaMiniFabrica(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaSalcomix(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaGlasurit(const strIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaKillingIndustrial(const steIteTin: String; const dicRetorno: TDicionario);
  procedure RetornaDadosTintaRoberloAutomotiva(const strIteTin: String; const dicRetorno: TDicionario);


  ////////////////////////////////////////////////
  /// Calcular Quantidades Tintas Imobiliarias ///
  //////////////////////////////////////////////RG

  function fGetQuantidadeGramaMl(const fltValor, Fator: Double; strFormula, strIdePro: String): Double;
  function GetQuantidadeOncaPulsoMl(const fltPulsos: Double; var intParteInteira: Integer; var fltParteFracao: Double; strIdePro: String; strFormul: String = ''): String;
  function GetQuantidadeMlPulso(const fltValor: Double; intDecFor: Integer; strIdePro: String; strFormul: String): String;




implementation

procedure RetornaDadosTintaSuvinil(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   SUV_DESCRI               ' +
              ' FROM                       ' +
              '   SUV_CADSUV               ' +
              ' WHERE SUV_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
    Begin
      qryDados.Close;

      strSQL := ' SELECT           ' +
                '   *              ' +
                ' FROM             ' +
                '   SUV_CADSUV     ' +
                ' WHERE CONCAT(    ' +
                '     SUV_REFERE   ' +
                '     , " "        ' +
                '     , SUV_CODBAS ' +
                '     , " "        ' +
                '     , SUV_CODFML ' +
                '     , SUV_CODUNI ' +
                '     , SUV_DESCRI ' +
                '   ) = :ITETIN    ';

      qryDados.SQL.Clear;
      qryDados.SQL.Add(strSQL);
      qryDados.ParamByName('ITETIN').AsString := strIteTin;
      qryDados.Open;

      If qryDados.IsEmpty Then
      Begin
        qryDados.Close;

        strSQL := ' SELECT           ' +
                  '   *              ' +
                  ' FROM             ' +
                  '   SUV_CADSUV     ' +
                  ' WHERE CONCAT(    ' +
                  '     SUV_REFERE   ' +
                  '     , SUV_CODUNI ' +
                  '     , SUV_DESCRI ' +
                  '   ) = :ITETIN    ';

        qryDados.SQL.Clear;
        qryDados.SQL.Add(strSQL);
        qryDados.ParamByName('ITETIN').AsString := strIteTin;
        qryDados.Open;

        If qryDados.IsEmpty Then
        Begin
          qryDados.Close;

          strSQL := ' SELECT           ' +
                    '   *              ' +
                    ' FROM             ' +
                    '   SUV_CADSUV     ' +
                    ' WHERE CONCAT(    ' +
                    '     SUV_DESCRI   ' +
                    '     , " "        ' +
                    '     , SUV_CODBAS ' +
                    '     , " "        ' +
                    '     , SUV_CODFML ' +
                    '     , SUV_CODUNI ' +
                    '     , SUV_REFERE ' +
                    '   ) = :ITETIN    ';

          qryDados.SQL.Clear;
          qryDados.SQL.Add(strSQL);
          qryDados.ParamByName('ITETIN').AsString := strIteTin;
          qryDados.Open;
        End;
      End;
    End;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('SUV_DESCRI').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaBautech(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   BAU_DESCRI               ' +
              ' FROM                       ' +
              '   BAU_CADBAU               ' +
              ' WHERE BAU_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
    Begin
      qryDados.Close;

      strSQL := ' SELECT           ' +
                '   *              ' +
                ' FROM             ' +
                '   BAU_CADBAU     ' +
                ' WHERE CONCAT(    ' +
                '     BAU_CODBAS   ' +
                '     , " "        ' +
                '     , BAU_UNIDAD ' +
                '     , BAU_DESCRI ' +
                '   ) = :ITETIN    ';

      qryDados.SQL.Clear;
      qryDados.SQL.Add(strSQL);
      qryDados.ParamByName('ITETIN').AsString := strIteTin;
      qryDados.Open;

      If qryDados.IsEmpty Then
      Begin
        qryDados.Close;

        strSQL := ' SELECT           ' +
                  '   *              ' +
                  ' FROM             ' +
                  '   BAU_CADBAU     ' +
                  ' WHERE CONCAT(    ' +
                  '       BAU_UNIDAD ' +
                  '     , BAU_DESCRI ' +
                  '   ) = :ITETIN    ';

        qryDados.SQL.Clear;
        qryDados.SQL.Add(strSQL);
        qryDados.ParamByName('ITETIN').AsString := strIteTin;
        qryDados.Open;

        If qryDados.IsEmpty Then
        Begin
          qryDados.Close;

          strSQL := ' SELECT           ' +
                    '   *              ' +
                    ' FROM             ' +
                    '   BAU_CADBAU     ' +
                    ' WHERE CONCAT(    ' +
                    '     BAU_DESCRI   ' +
                    '     , " "        ' +
                    '     , BAU_CODBAS ' +
                    '     , " "        ' +
                    '     , BAU_UNIDAD ' +
                    '   ) = :ITETIN    ';

          qryDados.SQL.Clear;
          qryDados.SQL.Add(strSQL);
          qryDados.ParamByName('ITETIN').AsString := strIteTin;
          qryDados.Open;
        End;
      End;
    End;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('BAU_DESCRI').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaCoralImobiliaria(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   COR_DESCRI,              ' +
              '   COR_COLID1,              ' +
              '   COR_COLID2,              ' +
              '   COR_DESPRO               ' +
              ' FROM                       ' +
              '   CORIMO_CADCOR            ' +
              ' WHERE COR_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
    Begin
      qryDados.Close;

      strSQL := ' SELECT                         ' +
                '   COR_DESCRI,                  ' +
                '   COR_COLID1,                  ' +
                '   COR_COLID2,                  ' +
                '   COR_DESPRO                   ' +
                ' FROM                           ' +
                '   CORIMO_CADCOR                ' +
                ' WHERE CONCAT(                  ' +
                '     IFNULL(COR_DESCRI, '''')   ' +
                '     , IFNULL(COR_CODIGO, '''') ' +
                '     , IFNULL(COR_UNIDAD, '''') ' +
                '     , IFNULL(COR_COLID1, '''') ' +
                '     , IFNULL(COR_COLID2, '''') ' +
                '     , IFNULL(COR_DESPRO, '''') ' +
                '     , IFNULL(COR_CODBAS, '''') ' +
                '     , IFNULL(COR_CODEMB, '''') ' +
                '     , IFNULL(COR_CODUNI, '''') ' +
                '     , IFNULL(COR_UNIVER, '''') ' +
                '   ) = :ITETIN                  ';

      qryDados.SQL.Clear;
      qryDados.SQL.Add(strSQL);
      qryDados.ParamByName('ITETIN').AsString := strIteTin;
      qryDados.Open;

      If qryDados.IsEmpty Then
      Begin
        qryDados.Close;

        strSQL := ' SELECT                         ' +
                  '   COR_DESCRI,                  ' +
                  '   COR_COLID1,                  ' +
                  '   COR_COLID2,                  ' +
                  '   COR_DESPRO                   ' +
                  ' FROM                           ' +
                  '   CORIMO_CADCOR                ' +
                  ' WHERE CONCAT(                  ' +
                  '     IFNULL(COR_COLID1, '''')   ' +
                  '     , IFNULL(COR_COLID2, '''') ' +
                  '     , IFNULL(COR_DESPRO, '''') ' +
                  '     , IFNULL(COR_CODBAS, '''') ' +
                  '     , IFNULL(COR_CODIGO, '''') ' +
                  '     , IFNULL(COR_UNIDAD, '''') ' +
                  '   ) = :ITETIN                  ';

        qryDados.SQL.Clear;
        qryDados.SQL.Add(strSQL);
        qryDados.ParamByName('ITETIN').AsString := strIteTin;
        qryDados.Open;

        If qryDados.IsEmpty Then
        Begin
          qryDados.Close;

          strSQL := ' SELECT                     ' +
                    '   COR_DESCRI,              ' +
                    '   COR_COLID1,              ' +
                    '   COR_COLID2,              ' +
                    '   COR_DESPRO               ' +
                    ' FROM                       ' +
                    '   CORIMO_CADCOR            ' +
                    ' WHERE COR_CODSEQ = :ITETIN ';

          qryDados.SQL.Clear;
          qryDados.SQL.Add(strSQL);
          qryDados.ParamByName('ITETIN').AsString := strIteTin;
          qryDados.Open;
        End;
      End;
    End;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('COR_COLID1').AsString + '/' +
                              qryDados.FieldByName('COR_COLID2').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('COR_DESPRO').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaFutura(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   FUT_CADFUT               ' +
              ' WHERE FUT_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
    Begin
      qryDados.Close;

      strSQL := ' SELECT                           ' +
                '   *                              ' +
                ' FROM                             ' +
                '   FUT_CADFUT                     ' +
                ' WHERE                            ' +
                ' 	CONCAT(IFNULL(FUT_REFERE, ""), ' +
                ' 	       IFNULL(FUT_UNIDAD, ""), ' +
                ' 	       IFNULL(FUT_PRODUT, ""), ' +
                '          IFNULL(FUT_SPRODU, ""), ' +
                ' 	       IFNULL(FUT_CODBAS, "")) = :ITETIN ';

      qryDados.SQL.Clear;
      qryDados.SQL.Add(strSQL);
      qryDados.ParamByName('ITETIN').AsString := strIteTin;
      qryDados.Open;
    End;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('FUT_REFERE').AsString +
                            qryDados.FieldByName('FUT_UNIDAD').AsString +
                            qryDados.FieldByName('FUT_PRODUT').AsString +
                            qryDados.FieldByName('FUT_SPRODU').AsString +
                            qryDados.FieldByName('FUT_CODBAS').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaSherwinWilliams(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   SHE_CADSHE               ' +
              ' WHERE SHE_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
    Begin
      qryDados.Close;

      strSQL := ' SELECT                         ' +
                '   *                            ' +
                ' FROM                           ' +
                '   SHE_CADSHE                   ' +
                ' WHERE                          ' +
                '   CONCAT(SHE_DESCRI, " ", SHE_CODIGO, " ", SHE_CODIG2, " ", SHE_UNIDAD) = :ITETIN ';

      qryDados.SQL.Clear;
      qryDados.SQL.Add(strSQL);
      qryDados.ParamByName('ITETIN').AsString := strIteTin;
      qryDados.Open;
    End;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('SHE_DESCRI').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaCiaCollor(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   CIA_DESCRI               ' +
              ' FROM                       ' +
              '   CIA_CADCIA               ' +
              ' WHERE CIA_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
    Begin
      qryDados.Close;

      strSQL := ' SELECT           ' +
                '   *              ' +
                ' FROM             ' +
                '   CIA_CADCIA     ' +
                ' WHERE CONCAT(    ' +
                '     CIA_CODBAS   ' +
                '     , " "        ' +
                '     , CIA_UNIDAD ' +
                '     , CIA_DESCRI ' +
                '   ) = :ITETIN    ';

      qryDados.SQL.Clear;
      qryDados.SQL.Add(strSQL);
      qryDados.ParamByName('ITETIN').AsString := strIteTin;
      qryDados.Open;

      If qryDados.IsEmpty Then
      Begin
        qryDados.Close;

        strSQL := ' SELECT           ' +
                  '   *              ' +
                  ' FROM             ' +
                  '   CIA_CADCIA     ' +
                  ' WHERE CONCAT(    ' +
                  '       CIA_UNIDAD ' +
                  '     , CIA_DESCRI ' +
                  '   ) = :ITETIN    ';

        qryDados.SQL.Clear;
        qryDados.SQL.Add(strSQL);
        qryDados.ParamByName('ITETIN').AsString := strIteTin;
        qryDados.Open;

        If qryDados.IsEmpty Then
        Begin
          qryDados.Close;

          strSQL := ' SELECT           ' +
                    '   *              ' +
                    ' FROM             ' +
                    '   CIA_CADCIA     ' +
                    ' WHERE CONCAT(    ' +
                    '     CIA_DESCRI   ' +
                    '     , " "        ' +
                    '     , CIA_CODBAS ' +
                    '     , " "        ' +
                    '     , CIA_UNIDAD ' +
                    '   ) = :ITETIN    ';

          qryDados.SQL.Clear;
          qryDados.SQL.Add(strSQL);
          qryDados.ParamByName('ITETIN').AsString := strIteTin;
          qryDados.Open;
        End;
      End;
    End;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('CIA_DESCRI').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaQualyVinil(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   QUA_CADQUA               ' +
              ' WHERE QUA_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('QUA_NOMCOR').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaDacar(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                         ' +
              '   *                            ' +
              ' FROM                           ' +
              '   DAC_CADDAC                   ' +
              ' WHERE DAC_MD5KEY = :ITETIN     ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
    Begin
      qryDados.Close;

      strSQL := ' SELECT                         ' +
                '   *                            ' +
                ' FROM                           ' +
                '   DAC_CADDAC                   ' +
                ' WHERE CONCAT(IFNULL(DAC_DESCRI,""),  ' +
                ' 	IFNULL(DAC_REFERE,""),       ' +
                ' 	IFNULL(DAC_CODUNI,""),       ' +
                ' 	IFNULL(DAC_EMBALA,""),       ' +
                ' 	IFNULL(DAC_PROCOD,""),       ' +
                ' 	IFNULL(DAC_CODBAS,""),       ' +
                ' 	IFNULL(DAC_CODFML,""),       ' +
                ' 	IFNULL(DAC_COLECA,""),       ' +
                ' 	IFNULL(DAC_CODCOR,"")) = :ITETIN; ';

      qryDados.SQL.Clear;
      qryDados.SQL.Add(strSQL);
      qryDados.ParamByName('ITETIN').AsString := strIteTin;
      qryDados.Open;

      If qryDados.IsEmpty Then
      Begin
        qryDados.Close;

        strSQL := ' SELECT       ' +
                  '   *          ' +
                  ' FROM         ' +
                  '   DAC_CADDAC ' +
                  ' WHERE        ' +
                  '  CONCAT(DAC_REFERE, DAC_CODUNI, DAC_DESCRI) = :ITETIN ';

        qryDados.SQL.Clear;
        qryDados.SQL.Add(strSQL);
        qryDados.ParamByName('ITETIN').AsString := strIteTin;
        qryDados.Open;
      End;
    End;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('DAC_DESCRI').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaDacasa(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   DCA_CADDCA               ' +
              ' WHERE DCA_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('DCA_CODIGO').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaLuztol(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   LUZ_CADLUZ               ' +
              ' WHERE LUZ_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('LUZ_CODIGO').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaAnjoImobiliaria(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   ANJ_CADANJ               ' +
              ' WHERE ANJ_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
    Begin
      qryDados.Close;

      strSQL := ' SELECT           ' +
                '   *              ' +
                ' FROM             ' +
                '   ANJ_CADANJ     ' +
                ' WHERE CONCAT(    ' +
                '     ANJ_DESCRI   ' +
                '     , " "        ' +
                '     , ANJ_CODIGO ' +
                '     , " "        ' +
                '     , ANJ_CODIG2 ' +
                '     , " "        ' +
                '     , ANJ_UNIDAD ' +
                '   ) = :ITETIN    ';

      qryDados.Close;
      qryDados.SQL.Clear;
      qryDados.SQL.Add(strSQL);
      qryDados.ParamByName('ITETIN').AsString := strIteTin;
      qryDados.Open;

      If qryDados.IsEmpty Then
      Begin
        qryDados.Close;

        strSQL := ' SELECT                                                                   ' +
                  '   *                                                                      ' +
                  ' FROM                                                                     ' +
                  '   ANJ_CADANJ                                                             ' +
                  ' WHERE UPPER(CAST(MD5(CONCAT(                                             ' +
                  '       CAST(IFNULL(ANJ_DESCRI, "") AS CHAR)                               ' +
                  '       , CAST(IFNULL(ANJ_CODIGO, "") AS CHAR)                             ' +
                  '       , CAST(IFNULL(ANJ_CODIG2, "") AS CHAR)                             ' +
                  '       , CAST(IFNULL(ANJ_UNIDAD, "") AS CHAR)                             ' +
                  '       , CAST(IFNULL(ANJ_PROKEY, "") AS CHAR)                             ' +
                  '       , CAST(IFNULL(ANJ_SUBKEY, "") AS CHAR)                             ' +
                  '       , CAST(IFNULL(ANJ_BASE__, "") AS CHAR)                             ' +
                  '       , CAST(IFNULL(ANJ_FORM01, "") AS CHAR)                             ' +
                  '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB01, 0), 4) AS CHAR), ",", "") ' +
                  '       , CAST(IFNULL(ANJ_FORM02, "") AS CHAR)                             ' +
                  '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB02, 0), 4) AS CHAR), ",", "") ' +
                  '       , CAST(IFNULL(ANJ_FORM03, "") AS CHAR)                             ' +
                  '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB03, 0), 4) AS CHAR), ",", "") ' +
                  '       , CAST(IFNULL(ANJ_FORM04, "") AS CHAR)                             ' +
                  '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB04, 0), 4) AS CHAR), ",", "") ' +
                  '       , CAST(IFNULL(ANJ_FORM05, "") AS CHAR)                             ' +
                  '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB05, 0), 4) AS CHAR), ",", "") ' +
                  '       , CAST(IFNULL(ANJ_FORM06, "") AS CHAR)                             ' +
                  '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB06, 0), 4) AS CHAR), ",", "") ' +
                  '       , CAST(IFNULL(ANJ_FORM07, "") AS CHAR)                             ' +
                  '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB07, 0), 4) AS CHAR), ",", "") ' +
                  '       , CAST(IFNULL(ANJ_FORM08, "") AS CHAR)                             ' +
                  '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB08, 0), 4) AS CHAR), ",", "") ' +
                  '       , CAST(IFNULL(ANJ_FORM09, "") AS CHAR)                             ' +
                  '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB09, 0), 4) AS CHAR), ",", "") ' +
                  '       , CAST(IFNULL(ANJ_FORM10, "") AS CHAR)                             ' +
                  '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB10, 0), 4) AS CHAR), ",", "") ' +
                  '       , CAST(IFNULL(ANJ_FORM11, "") AS CHAR)                             ' +
                  '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB11, 0), 4) AS CHAR), ",", "") ' +
                  '       , CAST(IFNULL(ANJ_FORM12, "") AS CHAR)                             ' +
                  '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB12, 0), 4) AS CHAR), ",", "") ' +
                  '       , CAST(IFNULL(ANJ_FORM13, "") AS CHAR)                             ' +
                  '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB13, 0), 4) AS CHAR), ",", "") ' +
                  '       , CAST(IFNULL(ANJ_FORM14, "") AS CHAR)                             ' +
                  '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB14, 0), 4) AS CHAR), ",", "") ' +
                  '       , CAST(IFNULL(ANJ_FORM15, "") AS CHAR)                             ' +
                  '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB15, 0), 4) AS CHAR), ",", "") ' +
                  '       , CAST(IFNULL(ANJ_FORM16, "") AS CHAR)                             ' +
                  '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB16, 0), 4) AS CHAR), ",", "") ' +
                  '       , CAST(IFNULL(ANJ_FORM17, "") AS CHAR)                             ' +
                  '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB17, 0), 4) AS CHAR), ",", "") ' +
                  '       , CAST(IFNULL(ANJ_FORM18, "") AS CHAR)                             ' +
                  '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB18, 0), 4) AS CHAR), ",", "") ' +
                  '       , CAST(IFNULL(ANJ_FORM19, "") AS CHAR)                             ' +
                  '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB19, 0), 4) AS CHAR), ",", "") ' +
                  '       , CAST(IFNULL(ANJ_FORM20, "") AS CHAR)                             ' +
                  '       , REPLACE(CAST(FORMAT(IFNULL(ANJ_QTDB20, 0), 4) AS CHAR), ",", "") ' +
                  '     )                                                                    ' +
                  '   ) AS CHAR)) = :ITETIN                                                  ';

        qryDados.SQL.Clear;
        qryDados.SQL.Add(strSQL);
        qryDados.ParamByName('ITETIN').AsString := strIteTin;
        qryDados.Open;
      End;
    End;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('ANJ_CODIGO').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaRennerImobiliaria(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT        ' +
              '   REI_DESCRI, ' +
              '   REI_REFERE, ' +
              '   REI_UNIDAD, ' +
              '   REI_DESCOR, ' +
              '   REI_CODPRO, ' +
              '   REI_CODBAS, ' +
              '   REI_DTACAD  ' +
              ' FROM          ' +
              '   REI_CADREI  ' +
              ' WHERE REI_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('REI_DESCRI').AsString +
                            qryDados.FieldByName('REI_REFERE').AsString +
                            qryDados.FieldByName('REI_UNIDAD').AsString +
                            qryDados.FieldByName('REI_DESCOR').AsString +
                            qryDados.FieldByName('REI_CODPRO').AsString +
                            qryDados.FieldByName('REI_CODBAS').AsString +
                            qryDados.FieldByName('REI_DTACAD').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaMontana(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT          ' +
              '      MON_CODSEQ ' +
              '    , MON_CODBAS ' +
              '    , MON_ACABAM ' +
              '    , MON_DESCRI ' +
              '    , MON_DESCOR ' +
              '    , MON_PRODUT ' +
              '    , MON_UNIDAD ' +
              ' FROM ' +
              '   MON_CADMON  ' +
              ' WHERE MON_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('MON_CODSEQ').AsString +
                            qryDados.FieldByName('MON_CODBAS').AsString +
                            qryDados.FieldByName('MON_ACABAM').AsString +
                            qryDados.FieldByName('MON_DESCRI').AsString +
                            qryDados.FieldByName('MON_DESCOR').AsString +
                            qryDados.FieldByName('MON_PRODUT').AsString +
                            qryDados.FieldByName('MON_UNIDAD').AsString ;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaMegaTintas(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   MEG_DESCRI               ' +
              ' FROM                       ' +
              '   MEG_CADMEG               ' +
              ' WHERE MEG_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('MEG_DESCRI').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaAlterPlus(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   ALP_DESCRI               ' +
              ' FROM                       ' +
              '   ALP_CADALP               ' +
              ' WHERE ALP_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('ALP_DESCRI').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaAlessiImobiliaria(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                         ' +
              '   *                            ' +
              ' FROM                           ' +
              '   ALE_CADALE                   ' +
              '   INNER JOIN ALE_CADEMB        ' +
              '     ON ALE_EMBALA = EMB_NOME__ ' +
              ' WHERE ALE_MD5KEY = :ITETIN     ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
    Begin
      qryDados.Close;

      strSQL := ' SELECT                         ' +
                '   *                            ' +
                ' FROM                           ' +
                '   ALE_CADALE                   ' +
                '   INNER JOIN ALE_CADEMB        ' +
                '     ON ALE_EMBALA = EMB_NOME__ ' +
                ' WHERE CONCAT(                  ' +
                '     IFNULL(ALE_PRODUT, "")     ' +
                '     , IFNULL(ALE_BASE__, "")   ' +
                '     , IFNULL(ALE_CODUNI, "")   ' +
                '     , IFNULL(ALE_NOMCOR, "")   ' +
                '     , IFNULL(ALE_NOMLON, "")   ' +
                '     , IFNULL(ALE_CODNFM, "")   ' +
                '   ) = :ITETIN                  ';

      qryDados.SQL.Clear;
      qryDados.SQL.Add(strSQL);
      qryDados.ParamByName('ITETIN').AsString := strIteTin;
      qryDados.Open;

      If qryDados.IsEmpty Then
      Begin
        qryDados.Close;

        strSQL := ' SELECT                                                   ' +
                  '   *                                                      ' +
                  ' FROM                                                     ' +
                  '   ALE_CADALE                                             ' +
                  '   INNER JOIN ALE_CADEMB                                  ' +
                  '     ON ALE_EMBALA = EMB_NOME__                           ' +
                  ' WHERE UPPER(CAST(MD5(CONCAT(                             ' +
                  '           IFNULL(ALE_PRODUT, "")                         ' +
                  '           , IFNULL(ALE_BASE__, "")                       ' +
                  '           , IFNULL(ALE_CODUNI, "")                       ' +
                  '           , IFNULL(ALE_NOMCOR, "")                       ' +
                  '           , IFNULL(ALE_NOMLON, "")                       ' +
                  '           , IFNULL(ALE_CODNFM, ""))) AS CHAR)) = :ITETIN ';

        qryDados.SQL.Clear;
        qryDados.SQL.Add(strSQL);
        qryDados.ParamByName('ITETIN').AsString := strIteTin;
        qryDados.Open;
      End;
    End;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('ALE_PRODUT').AsString +
                            qryDados.FieldByName('ALE_BASE__').AsString +
                            qryDados.FieldByName('EMB_CODUNI').AsString +
                            qryDados.FieldByName('ALE_NOMCOR').AsString +
                            qryDados.FieldByName('ALE_NOMLON').AsString +
                            qryDados.FieldByName('ALE_CODNFM').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaSparlack(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   SPA_CADSPA               ' +
              ' WHERE SPA_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('SPA_CODSPA').AsString +
                            qryDados.FieldByName('SPA_DESCRI').AsString +
                            qryDados.FieldByName('SPA_PRODUT').AsString +
                            qryDados.FieldByName('SPA_CODBAS').AsString +
                            qryDados.FieldByName('SPA_CODUNI').AsString ;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaJotun(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   JOT_DESCRI               ' +
              ' FROM                       ' +
              '   JOT_CADJOT               ' +
              ' WHERE JOT_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('JOT_DESCRI').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaFalcao(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   FAL_CODIGO               ' +
              ' FROM                       ' +
              '   FAL_CADFAL               ' +
              ' WHERE FAL_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('FAL_CODIGO').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaBrasimixImobiliaria(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   BZI_CADBZI               ' +
              ' WHERE BZI_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
    Begin
      qryDados.Close;

      strSQL := ' SELECT       ' +
                '   *          ' +
                ' FROM         ' +
                '   BZI_CADBZI ' +
                ' WHERE        ' +
                '   CONCAT(IFNULL(BZI_CODIGO, ""), ' +
                '          IFNULL(BZI_UNIDAD, ""), ' +
                '          IFNULL(BZI_DESCRI, ""), ' +
                '          IFNULL(BZI_REFERE, "")) = :ITETIN ';

      qryDados.SQL.Clear;
      qryDados.SQL.Add(strSQL);
      qryDados.ParamByName('ITETIN').AsString := strIteTin;
      qryDados.Open;

      If qryDados.IsEmpty Then
      Begin
        qryDados.Close;

        strSQL := ' SELECT       ' +
                  '   *          ' +
                  ' FROM         ' +
                  '   BZI_CADBZI ' +
                  ' WHERE        ' +
                  '   CONCAT(BZI_CODIGO, BZI_UNIDAD) = :ITETIN ';

        qryDados.SQL.Clear;
        qryDados.SQL.Add(strSQL);
        qryDados.ParamByName('ITETIN').AsString := strIteTin;
        qryDados.Open;
      End;
    End;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('BZI_CODIGO').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('BZI_REFERE').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaEucatexImobiliaria(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   EUC_CADEUC               ' +
              ' WHERE EUC_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
    Begin
      qryDados.Close;

      strSQL := ' SELECT       ' +
                '   *          ' +
                ' FROM         ' +
                '   EUC_CADEUC ' +
                ' WHERE        ' +
                '   CONCAT(IFNULL(EUC_CODCOR, ""), ' +
                '          IFNULL(EUC_DESCOR, ""), ' +
                '          IFNULL(EUC_PRODUT, ""), ' +
                '          IFNULL(EUC_DESBAS, ""), ' +
                '          IFNULL(EUC_UNIDAD, ""), ' +
                '          IFNULL(EUC_CODNFM, "")) = :ITETIN ';

      qryDados.SQL.Clear;
      qryDados.SQL.Add(strSQL);
      qryDados.ParamByName('ITETIN').AsString := strIteTin;
      qryDados.Open;
    End;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('EUC_CODCOR').AsString +
                            qryDados.FieldByName('EUC_DESCOR').AsString +
                            qryDados.FieldByName('EUC_PRODUT').AsString +
                            qryDados.FieldByName('EUC_DESBAS').AsString +
                            qryDados.FieldByName('EUC_UNIDAD').AsString +
                            qryDados.FieldByName('EUC_CODNFM').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaMazaImobiliaria(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   MZI_CADMZI               ' +
              ' WHERE MZI_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('MZI_CODMZI').AsString +
                            qryDados.FieldByName('MZI_CODEMP').AsString +
                            qryDados.FieldByName('MZI_CODUNI').AsString +
                            qryDados.FieldByName('MZI_PRODUT').AsString +
                            qryDados.FieldByName('MZI_COLNUM').AsString +
                            qryDados.FieldByName('MZI_CODBAS').AsString ;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaMaestria(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   MAE_CADMAE               ' +
              ' WHERE MAE_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('MAE_CODIGO').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaVelutexImobiliaria(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   VEL_CADVEL               ' +
              ' WHERE VEL_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
    Begin
      qryDados.Close;

      strSQL := ' SELECT       ' +
                '   *          ' +
                ' FROM         ' +
                '   VEL_CADVEL ' +
                ' WHERE        ' +
                '   CONCAT(IFNULL(VEL_CORCOD, ""), ' +
                '          IFNULL(VEL_PRODUT, ""), ' +
                '          IFNULL(VEL_CODBAS, ""), ' +
                '          IFNULL(VEL_CODUNI, ""), ' +
                '          IFNULL(VEL_CODNFM, "")) = :ITETIN ';

      qryDados.SQL.Clear;
      qryDados.SQL.Add(strSQL);
      qryDados.ParamByName('ITETIN').AsString := strIteTin;
      qryDados.Open;
    End;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('VEL_CORCOD').AsString +
                            qryDados.FieldByName('VEL_PRODUT').AsString +
                            qryDados.FieldByName('VEL_CODBAS').AsString +
                            qryDados.FieldByName('VEL_CODUNI').AsString +
                            qryDados.FieldByName('VEL_CODNFM').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaUniverso(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   UNI_CADUNI               ' +
              ' WHERE UNI_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
    Begin
      qryDados.Close;

      strSQL := ' SELECT       ' +
                '   *          ' +
                ' FROM         ' +
                '   UNI_CADUNI ' +
                ' WHERE        ' +
                '   CONCAT(IFNULL(UNI_DESCOR, ""), ' +
                '         (IFNULL(UNI_GRUPO_, ""), ' +
                '          IFNULL(UNI_PRODUT, ""), ' +
                '          IFNULL(UNI_CODBAS, ""), ' +
                '          IFNULL(UNI_CODUNI, ""), ' +
                '          IFNULL(UNI_CODNFM, "")) = :ITETIN ';

      qryDados.SQL.Clear;
      qryDados.SQL.Add(strSQL);
      qryDados.ParamByName('ITETIN').AsString := strIteTin;
      qryDados.Open;
    End;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('UNI_DESCOR').AsString +
                            qryDados.FieldByName('UNI_PRODUT').AsString +
                            qryDados.FieldByName('UNI_CODBAS').AsString +
                            qryDados.FieldByName('UNI_CODUNI').AsString +
                            qryDados.FieldByName('UNI_CODNFM').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaHydronorthImobiliaria(const strItetin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   HYD_CADHYD               ' +
              ' WHERE HYD_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('HYD_COLECA').AsString +
                            qryDados.FieldByName('HYD_PRODUT').AsString +
                            qryDados.FieldByName('HYD_C_O_R_').AsString +
                            qryDados.FieldByName('HYD_CORLON').AsString +
                            qryDados.FieldByName('HYD_BASE__').AsString +
                            qryDados.FieldByName('HYD_CODEMB').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaLiko(const strItetin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL :=  ' SELECT                     ' +
               '    *                       ' +
               ' FROM                       ' +
               '   LIK_CADLIK               ' +
               ' WHERE LIK_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('LIK_DESCRI').AsString +
                            qryDados.FieldByName('LIK_CODIGO').AsString +
                            qryDados.FieldByName('LIK_UNIDAD').AsString +
                            qryDados.FieldByName('LIK_CODBAS').AsString +
                            qryDados.FieldByName('LIK_CODEMB').AsString +
                            qryDados.FieldByName('LIK_CODUNI').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaLeinertex(const strItetin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   LEI_CADLEI               ' +
              ' WHERE LEI_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('LEI_CODIGO').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaIquine(const strItetin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '    *                       ' +
              '   FROM                     ' +
              '   IQU_CADIQU               ' +
              ' WHERE IQU_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('IQU_DESCRI').AsString +
                            qryDados.FieldByName('IQU_CODIGO').AsString +
                            qryDados.FieldByName('IQU_UNIDAD').AsString +
                            qryDados.FieldByName('IQU_CODBAS').AsString +
                            qryDados.FieldByName('IQU_CODEMB').AsString +
                            qryDados.FieldByName('IQU_CODUNI').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaRecoa(const strItetin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   REC_CADREC               ' +
              ' WHERE REC_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('REC_DESCRI').AsString +
                            qryDados.FieldByName('REC_CODIGO').AsString +
                            qryDados.FieldByName('REC_UNIDAD').AsString +
                            qryDados.FieldByName('REC_CODBAS').AsString +
                            qryDados.FieldByName('REC_CODEMB').AsString +
                            qryDados.FieldByName('REC_CODUNI').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaCalamar(const strItetin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   CAL_CADCAL               ' +
              ' WHERE CAL_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('CAL_CODBAS').AsString +
                            qryDados.FieldByName('CAL_CODEMB').AsString +
                            qryDados.FieldByName('CAL_KEY1__').AsString +
                            qryDados.FieldByName('CAL_KEY2__').AsString +
                            qryDados.FieldByName('CAL_KEY3__').AsString +
                            qryDados.FieldByName('CAL_PRODUT').AsString +
                            qryDados.FieldByName('CAL_COLECA').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaKilling(const strItetin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   KILD_CADKIL              ' +
              ' WHERE KIL_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('KIL_CODCOR').AsString +
                            qryDados.FieldByName('KIL_DESCRI').AsString +
                            qryDados.FieldByName('KIL_REFERE').AsString +
                            qryDados.FieldByName('KIL_CODFML').AsString +
                            qryDados.FieldByName('KIL_CODBAS').AsString +
                            qryDados.FieldByName('KIL_CODUNI').AsString ;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaAnnetta(const strItetin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '    *                       ' +
              ' FROM                       ' +
              '   ANN_CADANN               ' +
              ' WHERE ANN_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('ANN_DESCRI').AsString +
                            qryDados.FieldByName('ANN_CODIGO').AsString +
                            qryDados.FieldByName('ANN_UNIDAD').AsString +
                            qryDados.FieldByName('ANN_CODBAS').AsString +
                            qryDados.FieldByName('ANN_CODEMB').AsString +
                            qryDados.FieldByName('ANN_CODUNI').AsString +
                            qryDados.FieldByName('ANN_PRODUT').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaInternational(const strItetin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   INT_CADINT               ' +
              ' WHERE INT_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('INT_LINHA_').AsString +
                            qryDados.FieldByName('INT_DESCOR').AsString +
                            qryDados.FieldByName('INT_CODBAS').AsString +
                            qryDados.FieldByName('INT_CODEMB').AsString +
                            qryDados.FieldByName('INT_CODNFM').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaLukscolor(const strItetin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   LKD_CADLKD               ' +
              ' WHERE LKD_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
    Begin
      qryDados.Close;

      strSQL := ' SELECT              ' +
                '   *                 ' +
                ' FROM                ' +
                '   LKD_CADLKD        ' +
                ' WHERE               ' +
                '  CONCAT(LKD_DESCRI, " ", LKD_CODIGO, " ", LKD_CODIG2) = :ITETIN ';

      qryDados.SQL.Clear;
      qryDados.SQL.Add(strSQL);
      qryDados.ParamByName('ITETIN').AsString := strIteTin;
      qryDados.Open;
    End;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('LKD_DESCRI').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaBellaCor(const strItetin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   BEL_CADBEL               ' +
              ' WHERE BEL_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('BEL_NOMCOR').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaGlobalColor(const strItetin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   GLO_CADGLO               ' +
              ' WHERE GLO_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('GLO_DESCRI').AsString +
                            qryDados.FieldByName('GLO_CODIGO').AsString +
                            qryDados.FieldByName('GLO_UNIDAD').AsString +
                            qryDados.FieldByName('GLO_CODBAS').AsString +
                            qryDados.FieldByName('GLO_CODEMB').AsString +
                            qryDados.FieldByName('GLO_CODUNI').AsString ;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaAnjoSintetica(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL :=  ' SELECT                     ' +
               '   *                        ' +
               ' FROM                       ' +
               '   AJA_CADAJA               ' +
               ' WHERE AJA_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('AJA_DESCRI').AsString +
                            qryDados.FieldByName('AJA_CODIGO').AsString +
                            qryDados.FieldByName('AJA_CODIG2').AsString +
                            qryDados.FieldByName('AJA_UNIDAD').AsString +
                            qryDados.FieldByName('AJA_PROKEY').AsString +
                            qryDados.FieldByName('AJA_SUBKEY').AsString +
                            qryDados.FieldByName('AJA_BASE__').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaRennerIndustrial(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '    *                       ' +
              ' FROM                       ' +
              '   REN_CADREN               ' +
              ' WHERE REN_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('REN_DESCRI').AsString +
                            qryDados.FieldByName('REN_CODIGO').AsString +
                            qryDados.FieldByName('REN_UNIDAD').AsString +
                            qryDados.FieldByName('REN_CODBAS').AsString +
                            qryDados.FieldByName('REN_CODEMB').AsString +
                            qryDados.FieldByName('REN_CODUNI').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaResicolor(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   RSI_CADRSI               ' +
              ' WHERE RSI_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('RSI_DESCRI').AsString +
                            qryDados.FieldByName('RSI_BASE__').AsString +
                            qryDados.FieldByName('RSI_CODIGO').AsString +
                            qryDados.FieldByName('RSI_CODIG2').AsString +
                            qryDados.FieldByName('RSI_PROKEY').AsString +
                            qryDados.FieldByName('RSI_SUBKEY').AsString +
                            qryDados.FieldByName('RSI_UNIDAD').AsString ;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaSayerlack(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   SAY_CADSAY               ' +
              ' WHERE SAY_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('SAY_BASE__').AsString +
                            qryDados.FieldByName('SAY_CODBAS').AsString +
                            qryDados.FieldByName('SAY_PRODUT').AsString +
                            qryDados.FieldByName('SAY_CODIGO').AsString +
                            qryDados.FieldByName('SAY_DESEMB').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaSinteplast(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   SIN_CADSIN               ' +
              ' WHERE SIN_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('SIN_CODIGO').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaWeg(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   WEG_CADWEG               ' +
              ' WHERE WEG_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('WEG_DESCRI').AsString +
                            qryDados.FieldByName('WEG_CODIGO').AsString +
                            qryDados.FieldByName('WEG_CODIG2').AsString +
                            qryDados.FieldByName('WEG_BASE__').AsString +
                            qryDados.FieldByName('WEG_UNIDAD').AsString +
                            qryDados.FieldByName('WEG_PROKEY').AsString +
                            qryDados.FieldByName('WEG_SUBKEY').AsString +
                            qryDados.FieldByName('WEG_NOMCOR').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaAdvance(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   ADVCOR_CADADV            ' +
              ' WHERE ADV_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('ADV_DESCRI').AsString +
                            qryDados.FieldByName('ADV_CODIGO').AsString +
                            qryDados.FieldByName('ADV_CODIG2').AsString +
                            qryDados.FieldByName('ADV_UNIDAD').AsString +
                            qryDados.FieldByName('ADV_BASE__').AsString ;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaAdvanceTintoSystem(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   ADT_CADADT               ' +
              ' WHERE ADT_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('ADT_IDFORM').AsString +
                            qryDados.FieldByName('ADT_CODCOR').AsString +
                            qryDados.FieldByName('ADT_CODTEC').AsString +
                            qryDados.FieldByName('ADT_PRODUT').AsString +
                            qryDados.FieldByName('ADT_CODBAS').AsString +
                            qryDados.FieldByName('ADT_CODEMB').AsString +
                            qryDados.FieldByName('ADT_CODCAT').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaAdvanceStr(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   ADS_CADADS               ' +
              ' WHERE ADS_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('ADS_CODIGO').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaGrafftex(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   GRA_DESCRI               ' +
              ' FROM                       ' +
              '   GRA_CADGRA               ' +
              ' WHERE GRA_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('GRA_DESCRI').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaSherwinWilliams2(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   SHW_CODIGO               ' +
              ' FROM                       ' +
              '   SHW_CADSHW               ' +
              ' WHERE SHW_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('SHW_CODIGO').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaGlobalBsn(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   BSN_CODIGO               ' +
              ' FROM                       ' +
              '   BSN_CADBSN               ' +
              ' WHERE BSN_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('BSN_CODIGO').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaGlobalBc(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   GBC_CODIGO               ' +
              ' FROM                       ' +
              '   GBC_CADGBC               ' +
              ' WHERE GBC_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('GBC_CODIGO').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaBellaCorTintavel(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   BLT_CODIGO               ' +
              ' FROM                       ' +
              '   BLT_CADBLT               ' +
              ' WHERE BLT_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('BLT_CODIGO').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaTexturaCia(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   TEX_CODIGO               ' +
              ' FROM                       ' +
              '   TEX_CADTEX               ' +
              ' WHERE TEX_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('TEX_CODIGO').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaChreon(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   CHR_CODIGO               ' +
              ' FROM                       ' +
              '   CHR_CADCHR               ' +
              ' WHERE CHR_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('CHR_CODIGO').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaGlobalCsn(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   CSN_CODIGO               ' +
              ' FROM                       ' +
              '   CSN_CADCSN               ' +
              ' WHERE CSN_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('CSN_CODIGO').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaGlobalCc11(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   C11_CODIGO               ' +
              ' FROM                       ' +
              '   C11_CADC11               ' +
              ' WHERE C11_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('C11_CODIGO').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaLukscolor2(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   LKC_CADLKC               ' +
              ' WHERE LKC_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('LKC_CODIGO').AsString +
                            qryDados.FieldByName('LKC_CODBAS').AsString +
                            qryDados.FieldByName('LKC_NOMCOR').AsString +
                            qryDados.FieldByName('LKC_PRODUT').AsString +
                            qryDados.FieldByName('LKC_UNIDAD').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaColorbraz(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '   *                        ' +
              ' FROM                       ' +
              '   CLB_CADCLB               ' +
              ' WHERE CLB_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('CLB_CODIGO').AsString +
                            qryDados.FieldByName('CLB_CODBAS').AsString +
                            qryDados.FieldByName('CLB_NOMCOR').AsString +
                            qryDados.FieldByName('CLB_PRODUT').AsString +
                            qryDados.FieldByName('CLB_UNIDAD').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaInkor(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT                     ' +
              '    *                       ' +
              ' FROM                       ' +
              '   INK_CADINK               ' +
              ' WHERE INK_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('INK_CODIGO').AsString +
                            qryDados.FieldByName('INK_BASE__').AsString +
                            qryDados.FieldByName('INK_PRODUT').AsString +
                            qryDados.FieldByName('INK_UNIDAD').AsString +
                            qryDados.FieldByName('INK_DESCRI').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaLazzumix(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '   SELECT *                ' +
             '  FROM LAZ_CADMIX           ' +
             ' WHERE MIX_CODIGO = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('MIX_CODIGO').AsString;
    dicRetorno['montad'] := qryDados.FieldByName('MIX_MONTAD').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('MIX_REFERE').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaAxalta(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT *                    ' +
              '   FROM DUP_CADDUP           ' +
              ' WHERE DUP_MD5KEY = :ITETIN  ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('DUP_CODDUP').AsString;
    dicRetorno['montad'] := qryDados.FieldByName('DUP_MONTAD').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('DUP_LINHA_').AsString;
    dicRetorno['a_n_o_'] := qryDados.FieldByName('DUP_ANOCOR').AsString;
    dicRetorno['catal_'] := qryDados.FieldByName('DUP_CATALI').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaMazaIndustrial(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '  SELECT *                   ' +
              '    FROM MZD_CADMZD          ' +
              '  LEFT JOIN MZD_CADMON ON MON_CODMON = MZD_CODMON '+
              ' WHERE MZD_MD5KEY = :ITETIN  ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
    Begin
      qryDados.Close;

      strSQL := ' SELECT * '+
                ' FROM MZD_CADMZD '+
                ' LEFT JOIN MZD_CADMON ON MON_CODMON = MZD_CODMON '+
                ' WHERE  '+
                '    UPPER(CAST(MD5(CONCAT( '+
                '       IFNULL(MZD_CODIGO, ""),  '+
                '       IFNULL(MZD_VARIAC, ""),  '+
                '       IFNULL(MZD_DESCRI, ""),  '+
                '       IFNULL(MZD_ANOCOR, ""),  '+
                '       IFNULL(MZD_DTAFOR, ""),  '+
                '       IFNULL(MZD_LINHA_, ""),  '+
                '       IFNULL(MZD_CODMON, ""),  '+
                '       IFNULL(MZD_CODNFM, ""),  '+
                '       IFNULL(MZD_UNIVER, "")))AS CHAR)) = :ITETIN ';

      qryDados.SQL.Clear;
      qryDados.SQL.Add(strSQL);
      qryDados.ParamByName('ITETIN').AsString := strIteTin;
      qryDados.Open;
    End;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('MZD_CODIGO').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('MZD_LINHA_').AsString;
    dicRetorno['montad'] := qryDados.FieldByName('MON_DESCRI').AsString;
    dicRetorno['a_n_o_'] := qryDados.FieldByName('MZD_ANOCOR').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaMazaAutomotiva(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '  SELECT *                     ' +
              '    FROM MZA_CADMZA            ' +
              '  LEFT JOIN MZA_CADMON ON MON_CODMON = MZA_CODMON '+
              '    WHERE MZA_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
    Begin
      qryDados.Close;

      strSQL := ' SELECT * '+
                ' FROM MZA_CADMZA '+
                ' LEFT JOIN MZA_CADMON ON MON_CODMON = MZA_CODMON '+
                ' WHERE  '+
                '    UPPER(CAST(MD5(CONCAT( '+
                '       IFNULL(MZA_CODIGO, ""),  '+
                '       IFNULL(MZA_VARIAC, ""),  '+
                '       IFNULL(MZA_DESCRI, ""),  '+
                '       IFNULL(MZA_ANOCOR, ""),  '+
                '       IFNULL(MZA_DTAFOR, ""),  '+
                '       IFNULL(MZA_LINHA_, ""),  '+
                '       IFNULL(MZA_CODMON, ""),  '+
                '       IFNULL(MZA_CODNFM, ""),  '+
                '       IFNULL(MZA_UNIVER, "")))AS CHAR)) = :ITETIN ';

      qryDados.SQL.Clear;
      qryDados.SQL.Add(strSQL);
      qryDados.ParamByName('ITETIN').AsString := strIteTin;
      qryDados.Open;
    End;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('MZA_CODIGO').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('MZA_LINHA_').AsString;
    dicRetorno['montad'] := qryDados.FieldByName('MON_DESCRI').AsString;
    dicRetorno['a_n_o_'] := qryDados.FieldByName('MZA_ANOCOR').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaStarmixWeb(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT STW_UNIVER,          ' +
              '       STW_MONTAD,           ' +
              '       STW_CODLIN            ' +
              '  FROM STW_CADSTW            ' +
              ' WHERE STW_MD5KEY = :ITETIN  ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('STW_UNIVER').AsString;
    dicRetorno['montad'] := qryDados.FieldByName('STW_MONTAD').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('STW_CODLIN').AsString
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaGeneral(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := ' SELECT *                    ' +
              '  FROM GEN_CADGEN            ' +
              '  LEFT JOIN GEN_CADMON ON MON_CODMON = GEN_CODMON '+
              ' WHERE GEN_MD5KEY = :ITETIN  ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('GEN_CODIGO').AsString;
    dicRetorno['montad'] := qryDados.FieldByName('MON_DESCRI').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaColorPro(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '   SELECT *                 ' +
              '  FROM WANPRO_CADWAN        ' +
              ' WHERE WAN_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
    Begin
      qryDados.Close;

      strSQL := '  SELECT *                   ' +
                '    FROM WANPRO_CADWAN       ' +
                '  WHERE                      ' +
                ' 	 UPPER(CAST(MD5(CONCAT(IFNULL(WAN_LINHA_, ""), IFNULL(WAN_CODAKZ, ""), ' +
                ' 	  		                 IFNULL(WAN_ALTERN, ""), IFNULL(WAN_MONTAD, ""), ' +
                ' 		                     IFNULL(WAN_CAMADA, ""))) AS CHAR)) = :ITETIN    ';

      qryDados.SQL.Clear;
      qryDados.SQL.Add(strSQL);
      qryDados.ParamByName('ITETIN').AsString := strIteTin;
      qryDados.Open;
    End;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('WAN_CODAKZ').AsString;
    dicRetorno['montad'] := qryDados.FieldByName('WAN_MONTAD').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('WAN_LINHA_').AsString;
    dicRetorno['catal_'] := qryDados.FieldByName('WAN_CATALI').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaAnjoAutomotiva(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '  SELECT *                   ' +
              '  FROM AJT_CADAJT            ' +
              '  LEFT JOIN AJT_CADMON ON MON_CODMON = AJT_CODMON  ' +
              ' WHERE AJT_MD5KEY = :ITETIN  ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('AJT_CODIGO').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('AJT_PRODUT').AsString;
    dicRetorno['montad'] := qryDados.FieldByName('MON_DESCRI').AsString;
    dicRetorno['a_n_o_'] := qryDados.FieldByName('AJT_ANOINI').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaAutoluks(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '  SELECT *                   ' +
              '  FROM ALK_CADALK            ' +
              ' WHERE ALK_MD5KEY = :ITETIN  ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('ALK_CODIGO').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('ALK_PRODUT').AsString;
    dicRetorno['a_n_o_'] := qryDados.FieldByName('ALK_ANOINI').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaBrasimixAutomotiva(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '  SELECT *                     ' +
              '    FROM BZA_CADBZA            ' +
              '  WHERE BZA_MD5KEY = :ITETIN   ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('BZA_CODSEQ').AsString;
    dicRetorno['montad'] := qryDados.FieldByName('BZA_MONTAD').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('BZA_ARQTXT').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaBrazilianColorAutomotiva(const strIteTin: String; const DicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '   SELECT BZC_CODIGO                 '+
              '     , BZC_CODUNI                    '+
              '     , BZC_DESCRI                    '+
              '     , BZC_A_N_O_                    '+
              '     , BZC_CODMON                    '+
              '     , BZC_LINHA_                    '+
              '     , MON_DESCRI                    '+
              '  FROM BZC_CADBZC                    '+
              '  LEFT JOIN BZC_CADMON               '+
              '         ON BZC_CODMON = MON_CODMON  '+
              ' WHERE BZC_MD5KEY = :ITETIN          ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('BZC_CODIGO').AsString;
    dicRetorno['montad'] := qryDados.FieldByName('MON_DESCRI').AsString;
    dicRetorno['a_n_o_'] := qryDados.FieldByName('BZC_A_N_O_').AsString;
    dicRetorno['linha_'] := qryDados.FieldByName('BZC_LINHA_').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaFarbenAutomotiva(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '  SELECT FAR_CODSEQ                  ' +
              '     , FAR_DESCRI                    ' +
              '     , FAR_A_N_O_                    ' +
              '     , FAR_LINHA_                    ' +
              '     , FAR_CODMON                    ' +
              '     , FAR_DESMON                    ' +
              '     , FAR_CODNFM                    ' +
              '  FROM FAR_CADFAR                    ' +
              '  LEFT JOIN FAR_CADMON               ' +
              '         ON FAR_CODMON = FAR_CODMON  ' +
              '  WHERE FAR_MD5KEY = :ITETIN         ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('FAR_CODSEQ').AsString;
    dicRetorno['montad'] := qryDados.FieldByName('FAR_CODMON').AsString;
    dicRetorno['a_n_o_'] := qryDados.FieldByName('FAR_A_N_O_').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('FAR_LINHA_').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaDuxone(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '  SELECT *                     ' +
              '    FROM DUX_CADDUX            ' +
              ' WHERE DUX_MD5KEY = :ITETIN    ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('DUX_CODDUX').AsString;
    dicRetorno['montad'] := qryDados.FieldByName('DUX_MONTAD').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('DUX_LINHA_').AsString;
    dicRetorno['a_n_o_'] := qryDados.FieldByName('DUX_ANOCOR').AsString;
    dicRetorno['catal_'] := qryDados.FieldByName('DUX_CATALI').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaDuxone2(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '  SELECT *                     ' +
              '    FROM DU2_CADDU2           ' +
              ' WHERE DU2_MD5KEY = :ITETIN    ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('DU2_CODDU2').AsString;
    dicRetorno['montad'] := qryDados.FieldByName('DU2_MONTAD').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('DU2_LINHA_').AsString;
    dicRetorno['a_n_o_'] := qryDados.FieldByName('DU2_ANOCOR').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaSkyMixAutomotiva(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '  SELECT *                                         ' +
              '  FROM SKY_CADSKY                                  ' +
              '  LEFT JOIN SKY_CADMON ON SKY_CODMON = MON_CODMON  ' +
              '  LEFT JOIN SKY_CADGRU ON SKY_CODGRU = GRU_CODGRU  ' +
              '  LEFT JOIN SKY_CADSGR ON SKY_CODSGR = SGR_CODSGR  ' +
              '  WHERE SKY_MD5KEY = :ITETIN                       ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('SKY_CODPRO').AsString;
    dicRetorno['montad'] := qryDados.FieldByName('MON_DESMON').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('GRU_LINHA_').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaPpg(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '  SELECT *                     ' +
              '   FROM PPG_CADPPG             ' +
              '  WHERE CONCAT(                ' +
              '    IFNULL(PPG_DESCOR, ""),    ' +
              '    IFNULL(PPG_VEICUL, ""),    ' +
              '    IFNULL(PPG_MONTAD, ""),    ' +
              '    IFNULL(PPG_TIPO__, ""),    ' +
              '    IFNULL(PPG_A_N_O_, ""),    ' +
              '    IFNULL(PPG_CODCOR, ""),    ' +
              '    IFNULL(PPG_CODATC, ""),    ' +
              '    IFNULL(PPG_CODB01, ""),    ' +
              '    IFNULL(PPG_QTDB01, ""),    ' +
              '    IFNULL(PPG_CODB02, ""),    ' +
              '    IFNULL(PPG_QTDB02, ""),    ' +
              '    IFNULL(PPG_CODB03, ""),    ' +
              '    IFNULL(PPG_QTDB03, ""),    ' +
              '    IFNULL(PPG_CODB04, ""),    ' +
              '    IFNULL(PPG_QTDB04, ""),    ' +
              '    IFNULL(PPG_CODB05, ""),    ' +
              '    IFNULL(PPG_QTDB05, ""),    ' +
              '    IFNULL(PPG_CODB06, ""),    ' +
              '    IFNULL(PPG_QTDB06, ""),    ' +
              '    IFNULL(PPG_CODB07, ""),    ' +
              '    IFNULL(PPG_QTDB07, ""),    ' +
              '    IFNULL(PPG_CODB08, ""),    ' +
              '    IFNULL(PPG_QTDB08, ""),    ' +
              '    IFNULL(PPG_CODB09, ""),    ' +
              '    IFNULL(PPG_QTDB09, ""),    ' +
              '    IFNULL(PPG_CODB10, ""),    ' +
              '    IFNULL(PPG_QTDB10, "")) = :ITETIN;  ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
    Begin
      qryDados.Close;

      strSQL := '';
      strSQL := strSQL + ' SELECT *                     ';
      strSQL := strSQL + ' FROM PPG_CADPPG              ';
      strSQL := strSQL + ' WHERE CAST(MD5(CONCAT(       ';
      strSQL := strSQL + '    IFNULL(PPG_DESCOR, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_VEICUL, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_MONTAD, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_TIPO__, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_A_N_O_, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODCOR, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODATC, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB01, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB01, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB02, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB02, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB03, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB03, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB04, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB04, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB05, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB05, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB06, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB06, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB07, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB07, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB08, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB08, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB09, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB09, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB10, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB10, ""))) AS CHAR) = :ITETIN;  ';

      qryDados.SQL.Clear;
      qryDados.SQL.Add(strSQL);
      qryDados.ParamByName('ITETIN').AsString := strIteTin;
      qryDados.Open;

      If qryDados.IsEmpty Then
      Begin
        qryDados.Close;

        strSQL := '';
        strSQL := strSQL + '  SELECT *                              ';
        strSQL := strSQL + '  FROM PPG_CADPPG                       ';
        strSQL := strSQL + '  WHERE CAST(MD5(CONCAT(                ';
        strSQL := strSQL + '    IFNULL(PPG_DESCOR, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_VEICUL, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_MONTAD, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_TIPO__, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_A_N_O_, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_CODCOR, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_CODATC, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_CODB01, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB01, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_CODB02, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB02, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_CODB03, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB03, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_CODB04, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB04, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_CODB05, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB05, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_CODB06, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB06, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_CODB07, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB07, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_CODB08, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB08, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_CODB09, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB09, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_CODB10, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB10, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_CODB11, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB11, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_CODB12, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB12, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_CODB13, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB13, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_CODB14, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB14, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_CODB15, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB15, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_CODB16, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB16, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_CODB17, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB17, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_CODB18, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB18, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_CODB19, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB19, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_CODB20, ""),             ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB20, ""))) AS CHAR) = :ITETIN;  ';

        qryDados.SQL.Clear;
        qryDados.SQL.Add(strSQL);
        qryDados.ParamByName('ITETIN').AsString := strIteTin;
        qryDados.Open;
      End;
    End;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('PPG_CODCOR').AsString;
    dicRetorno['montad'] := qryDados.FieldByName('PPG_MONTAD').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('PPG_TIPO__').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaStandox(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '  SELECT * FROM DOX_CADDOX       ' +
              ' WHERE DOX_MD5KEY = :ITETIN      ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('DOX_CODDOX').AsString;
    dicRetorno['montad'] := qryDados.FieldByName('DOX_MONTAD').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaNexa(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '  SELECT *                     ' +
              '    FROM NEX_CADNEX            ' +
              '  WHERE CONCAT(                ' +
              '    IFNULL(NEX_DESCOR, ""),    ' +
              '    IFNULL(NEX_VEICUL, ""),    ' +
              '    IFNULL(NEX_MONTAD, ""),    ' +
              '    IFNULL(NEX_TIPO__, ""),    ' +
              '    IFNULL(NEX_A_N_O_, ""),    ' +
              '    IFNULL(NEX_CODCOR, ""),    ' +
              '    IFNULL(NEX_CODATC, ""),    ' +
              '    IFNULL(NEX_CODB01, ""),    ' +
              '    IFNULL(NEX_QTDB01, ""),    ' +
              '    IFNULL(NEX_CODB02, ""),    ' +
              '    IFNULL(NEX_QTDB02, ""),    ' +
              '    IFNULL(NEX_CODB03, ""),    ' +
              '    IFNULL(NEX_QTDB03, ""),    ' +
              '    IFNULL(NEX_CODB04, ""),    ' +
              '    IFNULL(NEX_QTDB04, ""),    ' +
              '    IFNULL(NEX_CODB05, ""),    ' +
              '    IFNULL(NEX_QTDB05, ""),    ' +
              '    IFNULL(NEX_CODB06, ""),    ' +
              '    IFNULL(NEX_QTDB06, ""),    ' +
              '    IFNULL(NEX_CODB07, ""),    ' +
              '    IFNULL(NEX_QTDB07, ""),    ' +
              '    IFNULL(NEX_CODB08, ""),    ' +
              '    IFNULL(NEX_QTDB08, ""),    ' +
              '    IFNULL(NEX_CODB09, ""),    ' +
              '    IFNULL(NEX_QTDB09, ""),    ' +
              '    IFNULL(NEX_CODB10, ""),    ' +
              '    IFNULL(NEX_QTDB10, "")) = :ITETIN;  ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
    Begin
      qryDados.Close;

      strSQL := '';
      strSQL := strSQL + ' SELECT *                     ';
      strSQL := strSQL + ' FROM NEX_CADNEX              ';
      strSQL := strSQL + ' WHERE CAST(MD5(CONCAT(       ';
      strSQL := strSQL + '    IFNULL(NEX_DESCOR, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_VEICUL, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_MONTAD, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_TIPO__, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_A_N_O_, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_CODCOR, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_CODATC, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_CODB01, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_QTDB01, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_CODB02, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_QTDB02, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_CODB03, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_QTDB03, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_CODB04, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_QTDB04, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_CODB05, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_QTDB05, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_CODB06, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_QTDB06, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_CODB07, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_QTDB07, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_CODB08, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_QTDB08, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_CODB09, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_QTDB09, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_CODB10, ""),   ';
      strSQL := strSQL + '    IFNULL(NEX_QTDB10, ""))) AS CHAR) = :ITETIN;  ';

      qryDados.SQL.Clear;
      qryDados.SQL.Add(strSQL);
      qryDados.ParamByName('ITETIN').AsString := strIteTin;
      qryDados.Open;

      If qryDados.IsEmpty Then
      Begin
        qryDados.Close;

        strSQL := '';
        strSQL := strSQL + ' SELECT *                       ';
        strSQL := strSQL + ' FROM NEX_CADNEX                ';
        strSQL := strSQL + ' WHERE CAST(MD5(CONCAT(         ';
        strSQL := strSQL + '    IFNULL(NEX_DESCOR, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_VEICUL, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_MONTAD, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_TIPO__, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_A_N_O_, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_CODCOR, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_CODATC, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_CODB01, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB01, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_CODB02, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB02, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_CODB03, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB03, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_CODB04, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB04, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_CODB05, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB05, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_CODB06, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB06, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_CODB07, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB07, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_CODB08, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB08, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_CODB09, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB09, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_CODB10, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB10, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_CODB11, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB11, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_CODB12, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB12, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_CODB13, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB13, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_CODB14, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB14, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_CODB15, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB15, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_CODB16, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB16, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_CODB17, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB17, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_CODB18, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB18, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_CODB19, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB19, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_CODB20, ""),     ';
        strSQL := strSQL + '    IFNULL(NEX_QTDB20, ""))) AS CHAR) = :ITETIN;  ';

        qryDados.SQL.Clear;
        qryDados.SQL.Add(strSQL);
        qryDados.ParamByName('ITETIN').AsString := strIteTin;
        qryDados.Open;
      End;
    End;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('NEX_CODCOR').AsString;
    dicRetorno['montad'] := qryDados.FieldByName('NEX_MONTAD').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('NEX_TIPO__').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaStarmix(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '  SELECT STA_UNIVER,         ' +
              '    STA_MONTAD,              ' +
              '    STA_CODLIN               ' +
              '  FROM STA_CADSTA            ' +
              ' WHERE STA_MD5KEY = :ITETIN  ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('STA_UNIVER').AsString;
    dicRetorno['montad'] := qryDados.FieldByName('STA_MONTAD').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('STA_CODLIN').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaPpgNexa(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '  SELECT *                     ' +
              '    FROM PPX_CADPPX            ' +
              '  WHERE CONCAT(                ' +
              '    IFNULL(PPX_DESCOR, ""),    ' +
              '    IFNULL(PPX_VEICUL, ""),    ' +
              '    IFNULL(PPX_MONTAD, ""),    ' +
              '    IFNULL(PPX_TIPO__, ""),    ' +
              '    IFNULL(PPX_A_N_O_, ""),    ' +
              '    IFNULL(PPX_CODCOR, ""),    ' +
              '    IFNULL(PPX_CODATC, ""),    ' +
              '    IFNULL(PPX_CODB01, ""),    ' +
              '    IFNULL(PPX_QTDB01, ""),    ' +
              '    IFNULL(PPX_CODB02, ""),    ' +
              '    IFNULL(PPX_QTDB02, ""),    ' +
              '    IFNULL(PPX_CODB03, ""),    ' +
              '    IFNULL(PPX_QTDB03, ""),    ' +
              '    IFNULL(PPX_CODB04, ""),    ' +
              '    IFNULL(PPX_QTDB04, ""),    ' +
              '    IFNULL(PPX_CODB05, ""),    ' +
              '    IFNULL(PPX_QTDB05, ""),    ' +
              '    IFNULL(PPX_CODB06, ""),    ' +
              '    IFNULL(PPX_QTDB06, ""),    ' +
              '    IFNULL(PPX_CODB07, ""),    ' +
              '    IFNULL(PPX_QTDB07, ""),    ' +
              '    IFNULL(PPX_CODB08, ""),    ' +
              '    IFNULL(PPX_QTDB08, ""),    ' +
              '    IFNULL(PPX_CODB09, ""),    ' +
              '    IFNULL(PPX_QTDB09, ""),    ' +
              '    IFNULL(PPX_CODB10, ""),    ' +
              '    IFNULL(PPX_QTDB10, "")) = :ITETIN;       ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
    Begin
      qryDados.Close;

      strSQL := '';
      strSQL := strSQL + ' SELECT *  ';
      strSQL := strSQL + ' FROM PPX_CADPPX  ';
      strSQL := strSQL + ' WHERE CAST(MD5(CONCAT( ';
      strSQL := strSQL + '    IFNULL(PPX_DESCOR, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_VEICUL, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_MONTAD, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_TIPO__, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_A_N_O_, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_CODCOR, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_CODATC, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_CODB01, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_QTDB01, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_CODB02, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_QTDB02, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_CODB03, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_QTDB03, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_CODB04, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_QTDB04, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_CODB05, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_QTDB05, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_CODB06, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_QTDB06, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_CODB07, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_QTDB07, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_CODB08, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_QTDB08, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_CODB09, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_QTDB09, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_CODB10, ""),   ';
      strSQL := strSQL + '    IFNULL(PPX_QTDB10, ""))) AS CHAR) = :ITETIN;  ';

      qryDados.SQL.Clear;
      qryDados.SQL.Add(strSQL);
      qryDados.ParamByName('ITETIN').AsString := strIteTin;
      qryDados.Open;

      If qryDados.IsEmpty Then
      Begin
        qryDados.Close;

        strSQL := '';
        strSQL := strSQL + ' SELECT *  ';
        strSQL := strSQL + ' FROM PPX_CADPPX  ';
        strSQL := strSQL + ' WHERE CAST(MD5(CONCAT( ';
        strSQL := strSQL + '    IFNULL(PPX_DESCOR, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_VEICUL, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_MONTAD, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_TIPO__, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_A_N_O_, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODCOR, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODATC, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB01, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB01, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB02, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB02, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB03, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB03, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB04, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB04, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB05, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB05, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB06, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB06, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB07, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB07, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB08, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB08, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB09, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB09, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB10, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB10, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB11, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB11, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB12, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB12, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB13, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB13, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB14, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB14, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB15, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB15, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB16, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB16, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB17, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB17, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB18, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB18, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB19, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB19, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_CODB20, ""),   ';
        strSQL := strSQL + '    IFNULL(PPX_QTDB20, ""))) AS CHAR) = :ITETIN;  ';

        qryDados.SQL.Clear;
        qryDados.SQL.Add(strSQL);
        qryDados.ParamByName('ITETIN').AsString := strIteTin;
        qryDados.Open;
      End;
    End;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('PPX_CODCOR').AsString;
    dicRetorno['montad'] := qryDados.FieldByName('PPX_MONTAD').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('PPX_TIPO__').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaLechler(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '  SELECT *                   ' +
              '    FROM LEC_CADLEC          ' +
              '  WHERE LEC_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('LEC_CODNFM').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('LEC_CODCOR').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaRennerPerformance(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '  SELECT *                   ' +
              '    FROM REP_CADREP          ' +
              '  WHERE REP_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('REP_CODIGO').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('REP_NOMCOR').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaMiniFabrica(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '  SELECT *                   ' +
              '    FROM MIF_CADMIF          ' +
              '  WHERE MIF_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('MIF_CODIGO').AsString;
    dicRetorno['a_n_o_'] := qryDados.FieldByName('MIF_ANOCOR').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaTopCoat(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '  SELECT *                   ' +
              '    FROM COA_CADCOA          ' +
              '  WHERE COA_MD5KEY = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('COA_CODIGO').AsString;
    dicRetorno['a_n_o_'] := qryDados.FieldByName('COA_ANOCOR').AsString;

  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaKresil(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := 'SELECT * FROM KRE_CADKRE ' +
              ' WHERE KRE_MD5KEY = :ITETIN      ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('KRE_CODIGO').AsString +
                            qryDados.FieldByName('KRE_NOMCOR').AsString +
                            qryDados.FieldByName('KRE_BASE__').AsString +
                            qryDados.FieldByName('KRE_PRODUT').AsString +
                            qryDados.FieldByName('KRE_UNIDAD').AsString +
                            qryDados.FieldByName('KRE_COLECA').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaMaxVinil(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '  SELECT               ' +
              '    *                  ' +
              '  FROM                 ' +
              '    MAX_CADMAX         ' +
              '  WHERE                ' +
              '    MAX_MD5KEY = :ITETIN         ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('MAX_CODIGO').AsString +
                            qryDados.FieldByName('MAX_CODBAS').AsString +
                            qryDados.FieldByName('MAX_PRODUT').AsString +
                            qryDados.FieldByName('MAX_COLECA').AsString +
                            qryDados.FieldByName('MAX_UNIDAD').AsString +
                            qryDados.FieldByName('MAX_NOMCOR').AsString;

  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaSalcomix(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  SAL_CADSAL ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + ' 	UPPER(CAST(MD5(CONCAT(IFNULL(SAL_LINHA_, ''''), IFNULL(SAL_MONTAD, ''''), IFNULL(SAL_DESCRI, ''''), ';
    strSQL := strSQL + ' 			IFNULL(SAL_CODPRO, ''''), IFNULL(SAL_ANOCOR, ''''), IFNULL(SAL_VARIAC, ''''),  ';
    strSQL := strSQL + ' 			IFNULL(SAL_FORM01, ''''), IFNULL(SAL_QTDB01, ''0.0''), IFNULL(SAL_FORM02, ''''),  ';
    strSQL := strSQL + ' 			IFNULL(SAL_QTDB02, ''0.0''), IFNULL(SAL_FORM03, ''''), IFNULL(SAL_QTDB03, ''0.0''),  ';
    strSQL := strSQL + ' 			IFNULL(SAL_FORM04, ''''), IFNULL(SAL_QTDB04, ''0.0''), IFNULL(SAL_FORM05, ''''),  ';
    strSQL := strSQL + ' 			IFNULL(SAL_QTDB05, ''0.0''), IFNULL(SAL_FORM06, ''''), IFNULL(SAL_QTDB06, ''0.0''),  ';
    strSQL := strSQL + ' 			IFNULL(SAL_FORM07, ''''), IFNULL(SAL_QTDB07, ''0.0''), IFNULL(SAL_FORM08, ''''),  ';
    strSQL := strSQL + ' 			IFNULL(SAL_QTDB08, ''0.0''), IFNULL(SAL_FORM09, ''''), IFNULL(SAL_QTDB09, ''0.0''),  ';
    strSQL := strSQL + ' 			IFNULL(SAL_FORM10, ''''), IFNULL(SAL_QTDB10, ''0.0''), IFNULL(SAL_FORM11, ''''),  ';
    strSQL := strSQL + ' 			IFNULL(SAL_QTDB11, ''0.0''), IFNULL(SAL_FORM12, ''''), IFNULL(SAL_QTDB12, ''0.0''),  ';
    strSQL := strSQL + ' 			IFNULL(SAL_FORM13, ''''), IFNULL(SAL_QTDB13, ''0.0''), IFNULL(SAL_FORM14, ''''),  ';
    strSQL := strSQL + ' 			IFNULL(SAL_QTDB14, ''0.0''), IFNULL(SAL_FORM15, ''''), IFNULL(SAL_QTDB15, ''0.0''),  ';
    strSQL := strSQL + ' 			IFNULL(SAL_FORM16, ''''), IFNULL(SAL_QTDB16, ''0.0''), IFNULL(SAL_FORM17, ''''),  ';
    strSQL := strSQL + ' 			IFNULL(SAL_QTDB17, ''0.0''), IFNULL(SAL_FORM18, ''''), IFNULL(SAL_QTDB18, ''0.0''),  ';
    strSQL := strSQL + ' 			IFNULL(SAL_FORM19, ''''), IFNULL(SAL_QTDB19, ''0.0''), IFNULL(SAL_FORM20, ''''),  ';
    strSQL := strSQL + ' 			IFNULL(SAL_QTDB20, ''0.0''))) AS CHAR)) = :ITETIN ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
    Begin
      qryDados.Close;

      strSQL := '  SELECT             ' +
                '    *                ' +
                '  FROM               ' +
                '   SAL_CADSAL        ' +
                '  WHERE              ' +
                '   SAL_CODSEQ = :ITETIN      ';

      qryDados.SQL.Clear;
      qryDados.SQL.Add(strSQL);
      qryDados.ParamByName('ITETIN').AsString := strIteTin;
      qryDados.Open;

      If qryDados.IsEmpty Then
      Begin
        qryDados.Close;

        strSQL := '  SELECT             ' +
                  '    *                ' +
                  '  FROM               ' +
                  '    SAL_CADSAL       ' +
                  '  WHERE              ' +
                  '    SAL_MD5KEY = :ITETIN       ';

        qryDados.SQL.Clear;
        qryDados.SQL.Add(strSQL);
        qryDados.ParamByName('ITETIN').AsString := strIteTin;
        qryDados.Open;
      End;
    End;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('SAL_CODPRO').AsString;
    dicRetorno['montad'] := qryDados.FieldByName('SAL_MONTAD').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('SAL_LINHA_').AsString;
    dicRetorno['variac'] := qryDados.FieldByName('SAL_VARIAC').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaGlasurit(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL :=  '  SELECT                ' +
               '    *                   ' +
               '  FROM                  ' +
               '    GLA_CADGLA          ' +
               '  WHERE                 ' +
               '    CONCAT(             ' +
               '      IFNULL(GLA_LINHA_, ''''),   ' +
               '      IFNULL(GLA_MONTAD, ''''),   ' +
               '      IFNULL(GLA_DESCRI, ''''),   ' +
               '      IFNULL(GLA_CODPRO, ''''),   ' +
               '      IFNULL(GLA_ANOCOR, ''''),   ' +
               '      IFNULL(GLA_VARIAC, ''''),   ' +
               '      IFNULL(GLA_FORM01, ''''),   ' +
               '      IFNULL(GLA_QTDB01, ''0.0''),    ' +
               '      IFNULL(GLA_FORM02, ''''),   ' +
               '      IFNULL(GLA_QTDB02, ''0.0''),    ' +
               '      IFNULL(GLA_FORM03, ''''),   ' +
               '      IFNULL(GLA_QTDB03, ''0.0''),    ' +
               '      IFNULL(GLA_FORM04, ''''),   ' +
               '      IFNULL(GLA_QTDB04, ''0.0''),    ' +
               '      IFNULL(GLA_FORM05, ''''),   ' +
               '      IFNULL(GLA_QTDB05, ''0.0''),    ' +
               '      IFNULL(GLA_FORM06, ''''),   ' +
               '      IFNULL(GLA_QTDB06, ''0.0''),    ' +
               '      IFNULL(GLA_FORM07, ''''),   ' +
               '      IFNULL(GLA_QTDB07, ''0.0''),    ' +
               '      IFNULL(GLA_FORM08, ''''),   ' +
               '      IFNULL(GLA_QTDB08, ''0.0''),    ' +
               '      IFNULL(GLA_FORM09, ''''),   ' +
               '      IFNULL(GLA_QTDB09, ''0.0''),    ' +
               '      IFNULL(GLA_FORM10, ''''),   ' +
               '      IFNULL(GLA_QTDB10, ''0.0''),    ' +
               '      IFNULL(GLA_FORM11, ''''),   ' +
               '      IFNULL(GLA_QTDB11, ''0.0''),    ' +
               '      IFNULL(GLA_FORM12, ''''),   ' +
               '      IFNULL(GLA_QTDB12, ''0.0''),    ' +
               '      IFNULL(GLA_FORM13, ''''),   ' +
               '      IFNULL(GLA_QTDB13, ''0.0''),    ' +
               '      IFNULL(GLA_FORM14, ''''),   ' +
               '      IFNULL(GLA_QTDB14, ''0.0''),    ' +
               '      IFNULL(GLA_FORM15, ''''),   ' +
               '      IFNULL(GLA_QTDB15, ''0.0''),    ' +
               '      IFNULL(GLA_FORM16, ''''),   ' +
               '      IFNULL(GLA_QTDB16, ''0.0''),    ' +
               '      IFNULL(GLA_FORM17, ''''),   ' +
               '      IFNULL(GLA_QTDB17, ''0.0''),    ' +
               '      IFNULL(GLA_FORM18, ''''),   ' +
               '      IFNULL(GLA_QTDB18, ''0.0''),    ' +
               '      IFNULL(GLA_FORM19, ''''),   ' +
               '      IFNULL(GLA_QTDB19, ''0.0''),    ' +
               '      IFNULL(GLA_FORM20, ''''),   ' +
               '      IFNULL(GLA_QTDB20, ''0.0'')) = :ITETIN        ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('GLA_CODPRO').AsString;
    dicRetorno['montad'] := qryDados.FieldByName('GLA_MONTAD').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('GLA_LINHA_').AsString;
    dicRetorno['variac'] := qryDados.FieldByName('GLA_VARIAC').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaKillingIndustrial(const steIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '';
    strSQL := strSQL + '  SELECT            ';
    strSQL := strSQL + '    *               ';
    strSQL := strSQL + '  FROM              ';
    strSQL := strSQL + '    KIN_CADKIN      ';
    strSQL := strSQL + '  LEFT JOIN KIN_CADMON ON MON_CODMON = KIN_CODMON ' +
                       '  LEFT JOIN KIN_CADLIN ON LIN_CODIGO = KIN_LINHA_ ' ;
    strSQL := strSQL + '  WHERE             ';
    strSQL := strSQL + '    KIN_MD5KEY = :ITETIN      ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := steIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('KIN_CODIGO').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('LIN_DESCRI').AsString;
    dicRetorno['montad'] := qryDados.FieldByName('MON_DESCRI').AsString;
    dicRetorno['a_n_o_'] := qryDados.FieldByName('KIN_ANOCOR').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure RetornaDadosTintaRoberloAutomotiva(const strIteTin: String; const dicRetorno: TDicionario);
Begin
  Try
    qryDados := fCriaQuery();

    strSQL := '';
    StrSQL := strSQL + '   SELECT              ';
    strSQL := strSQL + '     *                 ';
    strSQL := strSQL + '   FROM                ';
    strSQL := strSQL + '     ROB_CADROB        ';
    strSQL := strSQL + '   WHERE               ';
    strSQL := strSQL + '     ROB_MD5KEY = :ITETIN          ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('ITETIN').AsString := strIteTin;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    dicRetorno['codtin'] := qryDados.FieldByName('ROB_CODIGO').AsString;
    dicRetorno['martin'] := qryDados.FieldByName('ROB_MARCA_').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
End;

function fGetQuantidadeGramaMl(const fltValor, Fator: Double; strFormula, strIdePro: String): Double;
Var
  fltPeso,
  fltMl: Double;
Begin
  Try
    If strIdePro = 'ADT' Then
    Begin
      Result := fltValor;
      Exit;
    End;

    qryDados := fCriaQuery();

    strSQL := '';
    strSQL := strSQL + '  SELECT                      ';
    strSQL := strSQL + '    COL_PESESP                ';
    strSQL := strSQL + '  FROM                        ';
    strSQL := strSQL + '    ' + strIdePro + '_CADCOL  ';
    strSQL := strSQL + '  WHERE                       ';
    strSQL := strSQL + '    COL_CODCOL = :COLORANTE   ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('COLORANTE').AsString := strFormula;
    qryDados.Open;

    If qryDados.IsEmpty Then
    Begin
      Result := fltValor * Fator;
      Exit;
    End;

    fltPeso := qryDados.FieldByName('COL_PESESP').AsFloat;
    fltMl := fltValor * Fator;
    fltMl := fltMl / fltPeso;

    Result := fltMl;
  Finally
    FreeAndNil(qryDados);
  End;
End;

function GetQuantidadeMlPulso(const fltValor: Double; intDecFor: Integer; strIdePro: String; strFormul: String): String;
Begin
  Result := FloatToStrF(fltValor, ffNumber, 12, intDecFor);

  If Pos(strIdePro, 'BSN_CSN_REC_LKC_DCA_LUZ_') > 0 Then
    Result := FloatToStrF(fltValor / 0.154, ffNumber, 12, intDecFor)
  Else If Pos(strIdePro, 'CHR_') > 0 Then
    Result := FloatToStrF(fltValor / 0.1627, ffNumber, 12, intDecFor)
  Else If Pos(strIdePro, 'GBC_BLT_C11_TEX_LEI_MAE_') > 0 Then
    Result := FloatToStrF(fltValor / 0.308, ffNumber, 12, intDecFor)
  Else If strIdePro = 'SHW' Then
    Result := FloatToStrF(fltValor / 0.924, ffNumber, 12, intDecFor)
  Else If strIdePro = 'LIK' Then
    Result := FloatToStrF(fltValor / 0.3080625, ffNumber, 12, intDecFor)
  Else If strIdePro = 'ADS' Then
  Begin
    qryDados := fCriaQuery();

    strSQL := '';
    strSQL := strSQL + ' SELECT                  ';
    strSQL := strSQL + '   CFG_VALCFG            ';
    strSQL := strSQL + ' FROM                    ';
    strSQL := strSQL + '   CFGTIN                ';
    strSQL := strSQL + ' WHERE                   ';
    strSQL := strSQL + '   CFG_IDEPRO = "ADS" AND        ';
    strSQL := strSQL + '   CFG_CODCFG = "MOVEST" AND     ';
    strSQL := strSQL + '   CFG_CODEMP = "' + VS_strCodEmp + '"   ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.Open;

    If (qryDados.FieldByName('CFG_VALCFG').AsString = 'GR') Or (fEmptyStr(qryDados.FieldByName('CFG_VALCFG').AsString)) Then
      Result := FloatToStrF(fltValor, ffNumber, 12, intDecFor)
    Else
    Begin
      strSQL := '';
      strSQL := strSQL + '  SELECT                      ';
      strSQL := strSQL + '    COL_PESESP                ';
      strSQL := strSQL + '  FROM                        ';
      strSQL := strSQL + '    ' + strIdePro + '_CADCOL  ';
      strSQL := strSQL + '  WHERE                       ';
      strSQL := strSQL + '    COL_CODCOL = :COLORANTE   ';

      qryDados.Close;
      qryDados.SQL.Clear;
      qryDados.SQL.Add(strSQL);
      qryDados.ParamByName('COLORANTE').AsString := strFormul;
      qryDados.Open;

      Result := FloatToStrF(fltValor * qryDados.FieldByName('COL_PESESP').AsFloat, ffNumber, 12, intDecFor)
    End;
  End;
End;

function GetQuantidadeOncaPulsoMl(const fltPulsos: Double; var intParteInteira: Integer; var fltParteFracao: Double;
  strIdePro: String; strFormul: String): String;
Var
  fltValor1 : Double;
  fltValor2 : Double;
  fltInteiro: Double;
  fltFracao : Double;
  fltVlrInt  : Double;
  fltVlrFrac : Double;
  strFracao : String;
  TipoDosadora : String; // 0:Manual/1:Automática
  strDosadora  : String;
  strValor1    : String;
  strValor2    : String;
Begin
  Result := '';

  If Pos(strIdePro, 'SUV_QUA_ANJ_MEG_SPA_VEL_GRA_LKS_ALP_') > 0 Then
  Begin
    intParteInteira := Trunc((fltPulsos / 48) / 4);
    fltParteFracao  :=  (((fltPulsos / 48) / 4) - intParteInteira) * 48;
    Result := Format('%dY%.2f', [intParteInteira, fltParteFracao]);
  End
  Else If Pos(strIdePro, 'CIM_JOT_') > 0 Then
  Begin
    intParteInteira := Trunc(fltPulsos / 96);
    fltParteFracao  :=  ((fltPulsos / 96) - intParteInteira) * 48;
    Result := Format('%dY%.2f', [intParteInteira, fltParteFracao]);
  End
  Else If Pos(strIdePro, 'SHE_') > 0 Then
  Begin
    fltValor1  := (fltPulsos / 32);
    fltInteiro := Trunc(fltValor1);
    fltFracao  := frac(fltValor1);
    fltValor1  := (fltFracao * 32);
    fltVlrInt  := Trunc(fltValor1);
    fltVlrFrac := Trunc((Frac(fltValor1 )) * 100);

    If (fltVlrFrac > 25) And (fltVlrFrac <= 50) Then
      fltVlrFrac := 50
    Else If (fltVlrFrac > 50) And (fltVlrFrac <= 75) Then
      fltVlrFrac := 1
    Else If (fltVlrFrac > 75) Then
    Begin
      fltVlrFrac := 0;
      fltVlrInt  := fltVlrInt + 1;
    End;

    strFracao := (FloatToStr(fltVlrInt) + ',' + FloatToStr(fltVlrFrac));
    Result := FloatToStr(fltInteiro) + 'Y' + strFracao;
  End
  Else If Pos(strIdePro, 'DAC_ALE_') > 0 Then
  Begin
    fltValor1 := ((fltPulsos / 48) / 0.616125);
    intParteInteira := Trunc(fltValor1);
    fltParteFracao := fStrToFloat(FormatFloat('0.00', (fltValor1 - intParteInteira) * 48));
    Result := Format('%dY%.2f', [intParteInteira, fltParteFracao]);
  End
  Else If Pos(strIdePro, 'EUC_') > 0 Then
  Begin
    fltVlrInt  := (fltPulsos * (29.5735295625 / 48));
    fltValor1  := (fltVlrInt / 48) / 0.61611520;
    fltInteiro := Trunc(fltValor1);
    fltFracao  := fStrToFloat(FormatFloat('0.000', (fltValor1 - fltInteiro) * 48));
    Result := Format('%dY%.1f', [Trunc(fltInteiro), fltFracao]);
  End
  Else If Pos(strIdePro, 'FAL_') > 0 Then
  Begin
    qryDados := fCriaQuery();

    strSQL := '';
    strSQL := strSQL + '  SELECT                      ';
    strSQL := strSQL + '    COL_PESESP                ';
    strSQL := strSQL + '  FROM                        ';
    strSQL := strSQL + '    ' + strIdePro + '_CADCOL  ';
    strSQL := strSQL + '  WHERE                       ';
    strSQL := strSQL + '    COL_CODCOL = :COLORANTE   ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.ParamByName('COLORANTE').AsString := strFormul;
    qryDados.Open;

    fltValor1 := qryDados.FieldByName('COL_PESESP').AsFloat;
    fltValor1 := fltPulsos / fltValor1;
    fltValor2 := (fltValor1 / 48) / 0.61611520;
    fltInteiro := Trunc(fltValor2);
    fltFracao  := fStrToFloat(FormatFloat('0.000', (fltValor2 - fltInteiro) * 48));
    Result := Format('%dY%.1f', [Trunc(fltInteiro), fltFracao]);

    qryDados.Close;
    FreeAndNil(qryDados);
  End
  Else If Pos(strIdePro, 'ADS_') > 0 Then
  Begin
    qryDados := fCriaQuery();

    strSQL := '';
    strSQL := strSQL + ' SELECT                  ';
    strSQL := strSQL + '   CFG_VALCFG            ';
    strSQL := strSQL + ' FROM                    ';
    strSQL := strSQL + '   CFGTIN                ';
    strSQL := strSQL + ' WHERE                   ';
    strSQL := strSQL + '   CFG_IDEPRO = "ADS" AND        ';
    strSQL := strSQL + '   CFG_CODCFG = "MOVEST" AND     ';
    strSQL := strSQL + '   CFG_CODEMP = "' + VS_strCodEmp + '"   ';

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);
    qryDados.Open;

    If (qryDados.FieldByName('CFG_VALCFG').AsString = 'GR') Or (fEmptyStr(qryDados.FieldByName('CFG_VALCFG').AsString)) Then
    Begin

      strSQL := '';
      strSQL := strSQL + '  SELECT                      ';
      strSQL := strSQL + '    COL_PESESP                ';
      strSQL := strSQL + '  FROM                        ';
      strSQL := strSQL + '    ' + strIdePro + '_CADCOL  ';
      strSQL := strSQL + '  WHERE                       ';
      strSQL := strSQL + '    COL_CODCOL = :COLORANTE   ';

      qryDados.Close;
      qryDados.SQL.Clear;
      qryDados.SQL.Add(strSQL);
      qryDados.ParamByName('COLORANTE').AsString := strFormul;
      qryDados.Open;

      fltValor1 := qryDados.FieldByName('COL_PESESP').AsFloat;
      fltValor1 := fltPulsos / fltValor1;
      fltValor2 := (fltValor1 / 48) / 0.61611520;
      fltInteiro := Trunc(fltValor2);
      fltFracao  := fStrToFloat(FormatFloat('0.000', (fltValor2 - fltInteiro) * 48));
      Result := Format('%dY%.1f', [Trunc(fltInteiro), fltFracao]);
    End
    Else
    Begin
      fltValor1  := (fltPulsos / 48) / 0.61611520;
      fltInteiro := Trunc(fltValor1);
      fltFracao  := fStrToFloat(FormatFloat('0.000', (fltValor1 - fltInteiro) * 48));
      Result := Format('%dY%.1f', [Trunc(fltInteiro), fltFracao]);
    End;

    qryDados.Close;
    FreeAndNil(qryDados);
  End
  Else If Pos(strIdePro, 'REI_MON_UNI_HYD_MZI_LIK_IQU_REC_CAL_INT_GLO_AJA_RSI_SAY_WEG_ADV_ADT_KRE_LKC_FUT_BAU_BZI_CIA_BSN_CSN_GBC_CLB_BLT_C11_CHR_LEI_MAE_DCA_LUZ_') > 0 Then
  Begin
    fltValor1  := (fltPulsos / 48) / 0.61611520;
    fltInteiro := Trunc(fltValor1);
    fltFracao  := fStrToFloat(FormatFloat('0.000', (fltValor1 - fltInteiro) * 48));
    Result := Format('%dY%.1f', [Trunc(fltInteiro), fltFracao]);
  End
  Else If Pos(strIdePro, 'SIN_') > 0 Then
  Begin
    fltValor1  := ((fltPulsos * 0.616) / 48) / 0.61611520;
    fltInteiro := Trunc(fltValor1);
    fltFracao  := fStrToFloat(FormatFloat('0.000', (fltValor1 - fltInteiro) * 48));
    Result := Format('%dY%.1f', [Trunc(fltInteiro), fltFracao]);
  End
  Else If strIdePro = 'TEX' Then
  Begin
    fltValor1  := (fltPulsos / 48) / 0.61611520;
    fltInteiro := Trunc(fltValor1);
    fltFracao  := fStrToFloat(FormatFloat('0.000', (fltValor1 - fltInteiro) * 48));
    Result := Format('%dY%.2f', [Trunc(fltInteiro), fltFracao]);
  End
  Else If Pos(strIdePro, 'KIL_') > 0 Then
  Begin
    Result := FloatToStr(Int(fltPulsos / 48));
    fltParteFracao := fltPulsos - (Int(fltPulsos / 48) * 48);
    Result := Result + 'Y' + FormatFloat('0.00', fltParteFracao);
  End
  Else If Pos(strIdePro, 'ANN_INK_MAX_') > 0 Then
  Begin
    fltValor1 := (fltPulsos / 48) / 0.61604;
    fltInteiro := Trunc(fltValor1);
    fltParteFracao := fStrToFloat(FormatFloat('0.000', (fltValor1 - fltInteiro) * 48));
    Result := Format('%dY%.1f', [Trunc(fltInteiro), fltParteFracao]);
  End
  Else If Pos(strIdePro, 'REN_') > 0 Then
  Begin
    // 1ª PARTE: DESCOBRIR O 'Y'
    fltValor1 := Trunc((fltPulsos / 0.616) / 48);

    // 2ª PARTE: DESCOBRIR A FRAÇÃO '/48'
    fltFracao := (fltPulsos / 0.616);
    fltVlrFrac := fltValor1 * 48;
    fltValor2 :=(fltFracao - fltVlrFrac);

    // 3ª PARTE: DESCOBRIR A FRAÇÃO '/96'
    fltInteiro := fltPulsos - (fltValor1 * 29.57) - (Trunc(fltValor2) * 0.616);
    fltVlrInt := fltInteiro / 0.308;

    If Trunc(fltValor2) > 0 Then
      strValor2 := FloatToStr(Trunc(fltVAlor2));

    If Trunc(fltVlrInt) > 0 Then
      strDosadora := IntToStr(Trunc(fltVlrInt)) + '/96';

    If fltValor1 > 0 Then
      strValor1 := FloatToStr(fltValor1) + 'Y';

    If Not fEmptyStr(strValor1) Then
      strFracao := strValor1;

    If Not fEmptyStr(strValor2) Then
      strFracao := strFracao + ' ' + strValor2;

    If Not fEmptyStr(strDosadora) Then
      strFracao := strFracao + ' ' + strDosadora;

    Result := strFracao;
  End
  Else If Pos(strIdePro, 'BEL_') > 0 Then
  Begin
     //1ª PARTE: DESCOBRIR O TIPO DA DOSADORA
     strSQL := '';
     strSQL := strSQL + ' SELECT                  ';
     strSQL := strSQL + '   CFG_VALCFG            ';
     strSQL := strSQL + ' FROM                    ';
     strSQL := strSQL + '   CFGTIN                ';
     strSQL := strSQL + ' WHERE                   ';
     strSQL := strSQL + '   CFG_IDEPRO = "BEL" AND        ';
     strSQL := strSQL + '   CFG_CODCFG = "TIPDOS" AND     ';
     strSQL := strSQL + '   CFG_CODEMP = "' + VS_strCodEmp + '"   ';

     qryDados := fCriaQuery();
     qryDados.SQL.Clear;
     qryDados.SQL.Add(strSQL);
     qryDados.Open;

     TipoDosadora := qryDados.FieldByName('CFG_VALCFG').AsString;
     FreeAndNil(qryDados);

    // 2ª PARTE: DESCOBRIR O 'Y' (Valor 1)
    fltValor1 := Trunc((fltPulsos / 0.616) / 48);

    // 3ª PARTE: DESCOBRIR A FRAÇÃO '/48' (valor 2)
    fltFracao :=  (fltPulsos / 0.616);
    fltVlrFrac := fltValor1 * 48;
    fltValor2 := (fltFracao - fltVlrFrac);

    // 4ª PARTE: DESCOBRIR A FRAÇÃO '/96' (DOSADORA AUTOMÁTICA) OU '/384' (DOSADORA MANUAL)
    fltInteiro := fltPulsos - (fltValor1 * 29.57) - (Trunc(fltValor2) * 0.616);

    // NESTE PONTO, O SISTEMA DEVE OLHAR A CONFIGURAÇÃO QUE DETERMINA SE A DOSADORA É MANUAL OU AUTOMÁTICA.
    fltVlrInt := fltInteiro / IIF(TipoDosadora = '0', 0.308, 0.077);

    If Trunc(fltValor2) > 0 Then
      strValor2 := FloatToStr(Trunc(fltValor2)) + '/48';

    If Trunc(fltVlrInt) > 0 Then
      strDosadora := IntToStr(Trunc(fltVlrInt))  + '/' + IIF(TipoDosadora = '0', '96', '384');

    If fltValor1 > 0 Then
      strValor1 := FloatToStr(fltValor1) + 'Y';

    strFracao :=  strValor1 + ' ' + strValor2 + ' ' + strDosadora;

    Result := strFracao;
  End
  Else If Pos(strIdePro, 'SHW_') > 0 Then
  Begin
    fltValor1 := fltPulsos / 0.924;
    Result := FloatToStrF(fltValor1, ffNumber, 12, 2);
  End;
End;


end.
