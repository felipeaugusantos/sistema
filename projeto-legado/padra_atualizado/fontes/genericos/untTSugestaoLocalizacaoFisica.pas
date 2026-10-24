unit untTSugestaoLocalizacaoFisica;

interface

  uses SysUtils, Classes, Data.DB, untFuncoesSimples, untCadLote, Uni,
  UniClientDataSet, System.Math, untConstantes;
  Type
    TOpcCall = (opccPlanoDeRecebimento, opccOPI);
    TSugestaoLocalizacaoFisica = class
      Private
        blnSugerirPicking: Boolean;
        blnSugereLocalizacao: Boolean;
        qryLocFis,
        qryPicking: TUniQuery;
        stlLocSel : TStringList;
        stlLocSelSemPicking : TStringList;
        FOpcCall: TOpcCall;
        function fQuantidadeSugeridaParaLocalizacao(cdsLocSug: TDataSet; strLocFisDes: String): Double;
        function fCriaDataSet: TUniClientDataSet;
      public
        constructor Create(AOpcCall: TOpcCall);
        destructor Destroy; override;
        function fGetLocalSugestao(blnQtdMenorQueLastro: Boolean; strCodite, strNumLot: String) : String;
        class function fVerificaSeTemBufferComDtaDeVencimentoMenor(strCodIte, strCodEmp: String; dtaDataVal: TDate): Boolean;
        class function fGetMedidasItem(ACodIte: String): Double;
        procedure pMontaSugestao(var cdsLocSug: TUniClientDataSet; AChave, ACodIte, ADesIte, ANumLot: string;  AEmbala, fltQuantidade : Double; dtaValidade : TDateTime);
    end;

implementation

{ TSugestaoLocalizacaoFisica }

class function TSugestaoLocalizacaoFisica.fGetMedidasItem(ACodIte: String): Double;
begin
  Result := fCampoTabela('IFNULL(BAR_LASTRO,0) * IFNULL(BAR_CAMADA,0) ', 'ITEBAR', ['BAR_CODITE', 'BAR_COMPRA'], [ACodIte, '1']);
end;

constructor TSugestaoLocalizacaoFisica.Create(AOpcCall: TOpcCall);
begin
  FOpcCall := AOpcCall;
  blnSugerirPicking := IIF(FOpcCall = opccPlanoDeRecebimento, fCfgSis('PLAPIC', varBoolean), fCfgSis('OPIPIC', varBoolean));
  blnSugereLocalizacao := (fCfgSis('TPLREC', varString) = 'L') Or (FOpcCall = opccOPI);
  stlLocSel := TStringList.Create;
  stlLocSelSemPicking := TStringList.Create;
  qryLocFis := fCriaQuery;
end;

destructor TSugestaoLocalizacaoFisica.Destroy;
begin
  FreeAndNil(qryLocFis);
end;

function TSugestaoLocalizacaoFisica.fGetLocalSugestao(blnQtdMenorQueLastro: Boolean; strCodite, strNumLot: String) : String;
  Var
    strLocPic : String;
    strCodLse : String;
    objCadLot : TCadLot;
    intIndex: integer;
Begin
  If (strNumLot <> 'A DEFINIR') And (strNumLot <> '') And (FOpcCall = opccPlanoDeRecebimento) Then
  Begin
    objCadLot := TCadLot.Create(nil);
    Result := objCadLot.fLocalizacaoFisicaLote(strCodIte, VS_strCodEmp, strNumLot);
    FreeAndNil(objCadLot);
    Exit;
  End;

  If blnSugerirPicking and blnSugereLocalizacao and blnQtdMenorQueLastro Then
  Begin
    pGetLocalizacaoFisicaDoPickingDoProduto(strCodIte, qryPicking);
    If qryPicking.IsEmpty Then
      strLocPic := ''
    Else
    Begin
      strLocPic := '';
      strLocPic :=  qryPicking.FieldByName('LOT_LOCFIS').AsString;
    End;
  End
  Else If blnSugerirPicking and blnSugereLocalizacao then
    strLocPic := ''
  Else
    strLocPic := fGetLocalizacaoFisicaDoPickingDoProduto(strCodite);
  strCodLse := fCampoTabela('ITE_CODLSE', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [strCodIte, VS_strCodEmp]);

  qryLocFis.Close;
  qryLocFis.SQL.Clear;

  qryLocFis.SQL.Add(' SELECT LOC_CODLOC,                             ');
  qryLocFis.SQL.Add('        LOC_PICKIN,                             ');
  qryLocFis.SQL.Add('        SUM(IFNULL(LOT_SALDOS,0)) AS SALDO      ');
  qryLocFis.SQL.Add(' FROM CADLOC                                    ');
  qryLocFis.SQL.Add('   LEFT JOIN CADLOT ON LOT_CODEMP = LOC_CODEMP  ');
  qryLocFis.SQL.Add('                   AND LOT_LOCFIS = LOC_CODLOC  ');
  qryLocFis.SQL.Add(' WHERE LOC_CODEMP = :CODEMP                     ');
  qryLocFis.SQL.Add('   AND LOC_ATIVO_ = "S"                         ');
  qryLocFis.SQL.Add('   AND IFNULL(LOC_CRITIC,"N") = "N"             ');
  qryLocFis.SQL.Add('   AND IFNULL(LOC_TRANSI,"N") = "N"             ');

  If fEmptyStr(strLocPic) then
  Begin
   qryLocFis.SQL.Add('   AND IFNULL(LOC_CODLOC, "") <> ""             ');
   qryLocFis.SQL.Add('   AND LOT_NUMLOT NOT IN ("A DEFINIR","GARANTIA")             ');
  End;

  If (stlLocSel.Count > 0) Then
  begin
    If blnSugerirPicking and blnSugereLocalizacao And Assigned(qryPicking) Then
    Begin
      stlLocSelSemPicking.Text := stlLocSel.Text;
      qryPicking.First;
      while not qryPicking.Eof Do
      Begin
        intIndex := stlLocSelSemPicking.IndexOf(qryPicking.FieldByName('LOT_LOCFIS').AsString);
        If intIndex > -1 then
          stlLocSelSemPicking.Delete(intIndex);
        qryPicking.Next;
      End;
      If (stlLocSelSemPicking.Count > 0) Then
        qryLocFis.SQL.Add('   AND LOC_CODLOC NOT IN (' + fCommaText(stlLocSelSemPicking, True) + ')');
    End
    Else
      qryLocFis.SQL.Add('   AND LOC_CODLOC NOT IN (' + fCommaText(stlLocSel, True) + ')');
  End;

  //lotes que estão reservados sem endereçar.
  qryLocFis.SQL.Add('   AND LOC_CODLOC NOT IN (SELECT AIL_LOCFIS                                   ');
  qryLocFis.SQL.Add('                          FROM AGEILO                                         ');
  qryLocFis.SQL.Add('                          INNER JOIN AGEITE ON AGEITE.AUTOINCREM = AIL_SEQITE ');
  qryLocFis.SQL.Add('                          JOIN AGEREC R ON R.AUTOINCREM = AIT_SEQGER WHERE AIL_ENDERE = "N" AND ARC_CODEMP = :CODEMP ) ');

  If not fEmptyStr(strCodLse) Then
    qryLocFis.SQL.Add('   AND ((LOC_CODLSE = :CODLSE) OR (LOC_CODLSE IS NULL)) ');

  If fEmptyStr(strLocPic) then
    qryLocFis.SQL.Add('   AND LOC_PICKIN = "N"                               ')
  Else
    qryLocFis.SQL.Add('   AND ((LOC_PICKIN = "N") OR (LOC_CODLOC = :LOCPIC)) ');

  qryLocFis.SQL.Add('  GROUP BY LOC_CODLOC                                   ');
  qryLocFis.SQL.Add('  HAVING ((SALDO = 0) OR (LOC_CODLOC = :LOCPIC))        ');
  qryLocFis.SQL.Add('  ORDER BY LOC_CODLOC                                   ');

  qryLocFis.ParamByName('CODEMP').AsString := VS_strCodEmp;

  If not fEmptyStr(strCodLse) Then
    qryLocFis.ParamByName('CODLSE').AsString := strCodLse;

  If Not fEmptyStr(strLocPic) then
    qryLocFis.ParamByName('LOCPIC').AsString := strLocPic;

  qryLocFis.Open;

  If Not fEmptyStr(strLocPic) Then
  Begin
    If qryLocFis.RecordCount <= 1 Then
    Begin
      Result := '';
    End
    Else
    Begin
      If qryLocFis.Locate('LOC_CODLOC', strLocPic, []) Then
      Begin
        If qryLocFis.RecordCount = qryLocFis.RecNo Then
        Begin
          qryLocFis.Prior;
          If qryLocFis.FieldByName('LOC_PICKIN').AsString = 'N' Then
            Result := qryLocFis.FieldByName('LOC_CODLOC').AsString
          Else
            Result := '';
        End
        Else
        Begin
          qryLocFis.Next;
          Result := qryLocFis.FieldByName('LOC_CODLOC').AsString;
        End;

      End;
    End;

  End
  Else
    Result := qryLocFis.FieldByName('LOC_CODLOC').AsString;
End;

function TSugestaoLocalizacaoFisica.fQuantidadeSugeridaParaLocalizacao(cdsLocSug: TDataSet; strLocFisDes: String): Double;
begin
  If Not Assigned(cdsLocSug) Then
    Exit(0);

  cdsLocSug.First;
  Result := 0;
  While not cdsLocSug.Eof Do
  Begin
    If cdsLocSug.FieldByName('LOCFIS').AsString = strLocFisDes Then
      Result := Result + cdsLocSug.FieldByName('QTDITE').AsFloat;
    cdsLocSug.Next;
  End;
End;

class function TSugestaoLocalizacaoFisica.fVerificaSeTemBufferComDtaDeVencimentoMenor(strCodIte, strCodEmp: String; dtaDataVal: TDate): Boolean;
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT LOT_LOCFIS, LOT_SALDOS, LOT_DTAVAL');
    qryConsulta.SQL.Add('  FROM CADLOT');
    qryConsulta.SQL.Add('INNER JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS');
    qryConsulta.SQL.Add('                 AND LOC_CODEMP = LOT_CODEMP');
    qryConsulta.SQL.Add('WHERE LOT_CODEMP = "' + strCodEmp + '"');
    qryConsulta.SQL.Add('  AND LOT_CODITE = "' + strCodIte + '"');
    qryConsulta.SQL.Add('  and LOC_PICKIN = "N"');
    qryConsulta.SQL.Add('  AND LOT_SALDOS > 0');
    qryConsulta.SQL.Add('  AND LOT_DTAVAL < :DTAVAL');

    qryConsulta.ParamByName('DTAVAL').AsDate := dtaDataVal;
    qryConsulta.Open;

    result := Not qryConsulta.IsEmpty;

  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TSugestaoLocalizacaoFisica.pMontaSugestao(var cdsLocSug: TUniClientDataSet; AChave, ACodIte, ADesIte, ANumLot: string;  AEmbala, fltQuantidade : Double; dtaValidade : TDateTime);
  Var
    strLocFis : String;
    fltQtdTotVal : Double;
    fltQtdTotUni : Double; // Quando vem item fora da embalagem deve endereçar na ultima localização sugerida.
    fltQtdMax    : Double;
    fltQtdSugest : Double;
    fltQtdJaSug: Double;
    fltQtdjaSugerida: Double;
    intQtdLoc : Integer;
    intIndex  : Integer;
    strBufVen: String;
    blnParcial: Boolean;
    blnLocPicking: Boolean;
Begin

  If Not Assigned(cdsLocSug) Then
    cdsLocSug := fCriaDataSet;

  fltQtdMax := 0;
  fltQtdSugest := 0;
  blnLocPicking := False;

  //Quantidade total que precisa ser endereçada por data de validade.
  If (FOpcCall =  opccOPI) Then
  Begin
    If AEmbala = 0 Then
      AEmbala := 1;
    fltQtdTotVal := fltQuantidade / AEmbala;
  End
  Else
    fltQtdTotVal := SimpleRoundTo((fltQuantidade / AEmbala), DEC_EMBALAGEM * -1);

  //Quantidade que veio fora de embalagem (DPADRA)
  fltQtdTotUni := SimpleRoundTo((Frac(fltQuantidade / AEmbala) * AEmbala), DEC_EMBALAGEM * -1);

  //Quantidade que cabe na localização fisica
  Try
    fltQtdMax    := TSugestaoLocalizacaoFisica.fGetMedidasItem(ACodIte);
  Except
    pMensagemOK('Verifique o cadastro de embalagens do item: ' + ACodIte + ' é necessário ter uma embalagem principal de compras!');
  End;

  If fltQtdMax <= 0 Then
    fltQtdMax := fltQtdTotVal;

  //Quantidade de Localização necessário para armazenar a quantidade total da validade;
  intQtdLoc := Trunc(fltQtdTotVal / fltQtdMax);
  If (intQtdLoc = 0) then
    intQtdLoc := 1;

  //Se tem resto precisa de outra localização para colocar o resto.
  If (intQtdLoc * fltQtdMax) < fltQtdTotVal Then
    inc(intQtdLoc);

  fltQtdJaSug := 0;
  intIndex := 1;
  strBufVen := 'N';
  while intIndex <= intQtdLoc Do
  Begin
    blnParcial := false;
    If blnSugerirPicking and blnSugereLocalizacao Then
    Begin
      strBufVen := 'N';
      If (fltQtdTotVal - fltQtdJaSug ) > fltQtdMax Then
        fltQtdSugest := fltQtdMax
      Else
        fltQtdSugest := (fltQtdTotVal - fltQtdJaSug);

      strLocFis := fGetLocalSugestao(fltQtdSugest < fltQtdMax, ACodIte, ANumLot);

      If (fltQtdSugest < fltQtdMax) And Assigned(qryPicking) then
      Begin
        qryPicking.First;
        blnParcial := False;
        While not qryPicking.Eof Do
        Begin
          blnLocPicking := True;
          fltQtdjaSugerida := fQuantidadeSugeridaParaLocalizacao(cdsLocSug, qryPicking.FieldByName('LOT_LOCFIS').AsString);
          If (qryPicking.FieldByName('LOT_SALDOS').AsFloat + fltQtdjaSugerida + fltQtdSugest) <= fltQtdMax then
          Begin
            strLocFis := qryPicking.FieldByName('LOT_LOCFIS').AsString;
            strBufVen := IIf(fVerificaSeTemBufferComDtaDeVencimentoMenor(ACodIte, VS_StrCodEmp, dtaValidade), 'S', 'N');
            break;
          End
          Else
          begin If (qryPicking.FieldByName('LOT_SALDOS').AsFloat + fltQtdjaSugerida + fltQtdSugest) > fltQtdMax then
            If fltQtdSugest - ((qryPicking.FieldByName('LOT_SALDOS').AsFloat + fltQtdjaSugerida + fltQtdSugest) - fltQtdMax) > 0 Then
            Begin
              strLocFis := qryPicking.FieldByName('LOT_LOCFIS').AsString;
              fltQtdSugest := fltQtdSugest - ((qryPicking.FieldByName('LOT_SALDOS').AsFloat + fltQtdjaSugerida + fltQtdSugest) - fltQtdMax);
              strBufVen := IIf(fVerificaSeTemBufferComDtaDeVencimentoMenor(ACodIte, VS_StrCodEmp, dtaValidade), 'S', 'N');
              blnParcial := True;
              break;
            End;
          End;
          qryPicking.Next;
        End;
      End;
    End;

    cdsLocSug.Insert;
    cdsLocSug.FieldByName('CHAVE').AsString    := AChave;
    cdsLocSug.FieldByName('LOCFIS').AsString   := strLocFis;
    cdsLocSug.FieldByName('DTAVAL').AsDateTime := dtaValidade;
    cdsLocSug.FieldByName('DESITE').AsString   := ADesIte;
    cdsLocSug.FieldByName('CODITE').AsString   := ACodIte;

    If cdsLocSug.FieldByName('DTAVAL').AsDateTime = 0 Then
      cdsLocSug.FieldByName('DTAVAL').Clear;
    If blnParcial Then
    Begin
      fltQtdJaSug := fltQtdJaSug + fltQtdSugest;
      cdsLocSug.FieldByName('QTDITE').AsFloat := fltQtdSugest;
    End
    Else
    begin
      If (fltQtdTotVal - fltQtdJaSug ) > fltQtdMax Then
      Begin
        cdsLocSug.FieldByName('QTDITE').AsFloat := fltQtdMax;
        fltQtdJaSug := fltQtdJaSug + fltQtdMax;
      End
      Else
        cdsLocSug.FieldByName('QTDITE').AsFloat := (fltQtdTotVal - fltQtdJaSug);
      inc(intIndex);
    End;

    //Quantidade em Uidade de Venda.
    cdsLocSug.FieldByName('QTDVEN').AsFloat := cdsLocSug.FieldByName('QTDITE').AsFloat * AEmbala;
    cdsLocSug.FieldByName('ENDERE').AsString := 'N';
    cdsLocSug.FieldByName('BUFVEN').AsString   := strBufVen;
    cdsLocSug.FieldByName('FISPIC').AsString   := strLocFis;
    cdsLocSug.FieldByName('EMBREC').AsFloat := cdsLocSug.FieldByName('QTDVEN').AsFloat / cdsLocSug.FieldByName('QTDITE').AsFloat;

    If FOpcCall = opccOPI Then
    Begin
      cdsLocSug.FieldByName('TITULO').AsString := 'Lotes x Localizações x Quantidade a serem criados:';
      cdsLocSug.FieldByName('QTDALO').AsFloat := cdsLocSug.FieldByName('QTDVEN').AsFloat;
      cdsLocSug.FieldByName('DTAFAB').AsDateTime := fNow;
      cdsLocSug.FieldByName('STATUS').AsString := 'A';
      cdsLocSug.FieldByName('IDTITULO').AsInteger := 3;
    End
    Else
    Begin
      cdsLocSug.FieldByName('ABPICK').AsString := IIF(blnLocPicking, 'S', 'N');
    End;

    cdsLocSug.Post;

    If (intIndex = intQtdLoc) And (fltQtdTotUni > 0) Then
    Begin
      cdsLocSug.Insert;
      cdsLocSug.FieldByName('CHAVE').AsString    := AChave;
      cdsLocSug.FieldByName('LOCFIS').AsString   := strLocFis;
      cdsLocSug.FieldByName('DTAVAL').AsDateTime := dtaValidade;

      If cdsLocSug.FieldByName('DTAVAL').AsDateTime = 0 Then
        cdsLocSug.FieldByName('DTAVAL').Clear;

      cdsLocSug.FieldByName('QTDITE').AsFloat := 0;
      cdsLocSug.FieldByName('QTDVEN').AsFloat := fltQtdTotUni;
      cdsLocSug.FieldByName('ENDERE').AsString   := 'N';
      cdsLocSug.FieldByName('BUFVEN').AsString   := 'N';
      cdsLocSug.FieldByName('FISPIC').AsString   := strLocFis;
      cdsLocSug.FieldByName('EMBREC').AsFloat := cdsLocSug.FieldByName('QTDVEN').AsFloat / cdsLocSug.FieldByName('QTDITE').AsFloat;

      If FOpcCall = opccOPI Then
      Begin
        cdsLocSug.FieldByName('TITULO').AsString := 'Lotes x Localizações x Quantidade a serem criados:';
        cdsLocSug.FieldByName('QTDALO').AsFloat := cdsLocSug.FieldByName('QTDVEN').AsFloat;
        cdsLocSug.FieldByName('DTAFAB').AsDateTime := fNow;
        cdsLocSug.FieldByName('STATUS').AsString := 'A';
        cdsLocSug.FieldByName('IDTITULO').AsInteger := 3;
        cdsLocSug.FieldByName('CODITE').AsString   := ACodIte;
      End;

      cdsLocSug.Post;
    End;

    If Not fEmptyStr(strLocFis) Then
      stlLocSel.Add(strLocFis);
  End;

End;

function TSugestaoLocalizacaoFisica.fCriaDataSet: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);
  Result.FieldDefs.Add('CHAVE', ftString, 20);
  Result.FieldDefs.Add('LOCFIS', ftString, 20);
  Result.FieldDefs.Add('DTAVAL', ftDate);
  Result.FieldDefs.Add('QTDITE', ftFloat);
  Result.FieldDefs.Add('QTDVEN', ftFloat);
  Result.FieldDefs.Add('ENDERE', ftString, 1);
  Result.FieldDefs.Add('AUTINC', ftString, 20);
  Result.FieldDefs.Add('BUFVEN', ftString, 1);
  Result.FieldDefs.Add('FISPIC', ftString, 100);
  Result.FieldDefs.Add('EXCESS', ftBoolean);
  Result.FieldDefs.Add('SELECE', ftBoolean);
  Result.FieldDefs.Add('ABPICK', ftString, 1);
  Result.FieldDefs.Add('PICKNG', ftString, 1);
  Result.FieldDefs.Add('CODITE', ftString, 7);
  Result.FieldDefs.Add('AIL_IMPRES', ftString, 1);
  Result.FieldDefs.Add('DESITE', ftString, 70);
  Result.FieldDefs.Add('LOCTIPO', ftString, 50);
  Result.FieldDefs.Add('EMBREC', ftFloat);
  Result.FieldDefs.Add('SEQUEN', ftInteger);

  If FOpcCall = opccOPI Then
  Begin
    Result.FieldDefs.Add('TITULO', ftString, 100);
    Result.FieldDefs.Add('SUBTITULO', ftString, 250);
    Result.FieldDefs.Add('IDTITULO', ftInteger);
    Result.FieldDefs.Add('NUMLOT', ftString, VS_Size_NumLot);
    Result.FieldDefs.Add('STATUS', ftString, 1);
    Result.FieldDefs.Add('DTAFAB', ftDate);
    Result.FieldDefs.Add('QTDALO', ftFloat);
  End;

  Result.CreateDataSet;
  Result.Active := True;
end;

end.
