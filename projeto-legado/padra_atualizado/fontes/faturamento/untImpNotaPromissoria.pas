unit untImpNotaPromissoria;

interface

uses SysUtils, Uni, DB, WinSpool, untImpNaoFiscal, Dialogs, StrUtils,UniDataSetProvider,
  Windows, Forms, Classes, UniClientDataSet, frxClass, untFuncFatTypes, untConsertoEquipamento,
  untFuncoesSimples, untFuncoesGenerica, Math, Graphics, MaskUtils, DateUtils, untImpMatricial,
  untQckNotaPromissoria, untTypesSistema;


Type
  TImpNotaPromissoria = class(TObject)
    protected
      FNomImp: String;
      FNomFrm: String;
      impMatricial: TImpMatricial;
    public
      procedure pImprimePromissoria(qryCadRec: TDataset; fltValMor: Double; strTipBol: String);

      class procedure pImprimeNotaPromissoria(ArrDupCtr: TArrDupCtr;
        strNomFrm, strNomFil: String; qryCadRec: TUniQuery; fltValMor: Double; strTipBol: String);

      Constructor Create(strNomFrm, strNomImp: String; blnConfir: Boolean);
      Destructor Destroy; override;
  end;

implementation

uses untFuncoes, untConstantes, untValorPorExtenso;

{TImpNotaPromissoria}


Constructor TImpNotaPromissoria.Create(strNomFrm, strNomImp: String; blnConfir: Boolean);
begin
  inherited Create;
  FNomImp := strNomImp;
  FNomFrm := strNomFrm;
  impMatricial := TImpMatricial.Create(FNomImp);
end;

destructor TImpNotaPromissoria.Destroy;
begin
  FreeAndNil(impMatricial);

  inherited Destroy;
end;

procedure TImpNotaPromissoria.pImprimePromissoria(qryCadRec: TDataset; fltValMor: Double; strTipBol: String);
  Var
    frmQckNotaPromissoria: TfrmQckNotaPromissoria;

    fltValDup: Double;

    strMesExtV: String;

    dtaDtaVen: TDateTime;
    wrdDiaVen: Word;
    wrdMesVen: Word;
    wrdAnoVen: Word;

    strDataVen: String;

    cdsReport: TUniClientDataSet;

    frxRelatorio: TfrxReport;
    frxComponent: TfrxComponent;

    I: Integer;

  function fLoadLayoutReport(strTipBol: String): TfrxReport;
  Var
    mmsLoad: TStream;
    LayImp: TUniQuery;
  Begin
    Result := Nil;

    LayImp := fCriaQuery(nil);
    Try
      Try
        With LayImp, SQL Do
        Begin
          Close;
          Clear;
          Add('SELECT * FROM ');
          Add('  LAYIMP');
          Add('WHERE');
          Add('  LAY_TIPLAY = :TIPLAY AND ');
          Add('  LAY_CODEMP = :CODEMP AND ');
          Add('  LAY_CODLAY = :CODLAY     ');

          ParamByName('CODEMP').AsString := VS_strCodEmp;
          ParamByName('CODLAY').AsString := IfThen(fCfgSis('NOTPMD') = '1', 'PROM80', 'PROM40');
          ParamByName('TIPLAY').AsString := IfThen(strTipBol = 'J', 'L', strTipBol);

          Add('ORDER BY');
          Add('  LAY_DTAALT DESC,');
          Add('  LAY_HORALT DESC ');
          Add('LIMIT 1');

          Open;

          If Not IsEmpty Then
          Begin
            mmsLoad := CreateBlobStream(FieldByName('LAY_RELFR3'), bmRead);

            If strTipBol = 'M' Then
            Begin
              If (fCfgSis('NOTPMD') = '1') Then
              begin
                frmQckNotaPromissoria.frxPromissoria_M.LoadFromStream(mmsLoad);
                Result := frmQckNotaPromissoria.frxPromissoria_M
              end
              Else
              begin // 40 colunas
                frmQckNotaPromissoria.frxPromissoria40_M.LoadFromStream(mmsLoad);
                Result := frmQckNotaPromissoria.frxPromissoria40_M;
              end;
            End
            Else
            Begin
              If (fCfgSis('NOTPMD') = '1') Then
              begin
                frmQckNotaPromissoria.frxPromissoria_J.LoadFromStream(mmsLoad);
                Result := frmQckNotaPromissoria.frxPromissoria_J
              end
              Else
              begin // 40 colunas
                frmQckNotaPromissoria.frxPromissoria40_J.LoadFromStream(mmsLoad);
                Result := frmQckNotaPromissoria.frxPromissoria40_J;
              end;
            End;

            FreeAndNil(mmsLoad);
          End
          Else
          Begin
            If strTipBol = 'M' Then
            Begin
              If (fCfgSis('NOTPMD') = '1') Then
                Result := frmQckNotaPromissoria.frxPromissoria_M
              Else
                // 40 colunas
                Result := frmQckNotaPromissoria.frxPromissoria40_M;
            End
            Else
            Begin
              If (fCfgSis('NOTPMD') = '1') Then
                Result := frmQckNotaPromissoria.frxPromissoria_J
              Else
                // 40 colunas
                Result := frmQckNotaPromissoria.frxPromissoria40_J;
            End;
          End;

        End;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[fLoadReport]');
        End;

      End;

    Finally
      FreeAndNil(LayImp);
    End;

  End;

begin
  cdsReport := TUniClientDataSet.Create(Nil);

  for I := 0 to Pred(qryCadRec.Fields.Count) do
    With cdsReport.FieldDefs.AddFieldDef Do
    Begin
      Name := qryCadRec.Fields[I].FieldName;
      DataType := qryCadRec.Fields[I].DataType;
      Size := qryCadRec.Fields[I].Size;
    End;

  With cdsReport.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MemoVencimento';
    DataType := ftString;
    Size := 50;
  End;

  With cdsReport.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MemoValor';
    DataType := ftString;
    Size := 50;
  End;

  With cdsReport.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MemoTexto';
    DataType := ftString;
    Size := 5000;
  End;

  With cdsReport.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MemoTextoComRazaoSocial';
    DataType := ftString;
    Size := 5000;
  End;

  With cdsReport.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MemoObs';
    DataType := ftString;
    Size := 5000;
  End;

  With cdsReport.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTPAR';
    DataType := ftString;
    Size := 2;
  End;

  cdsReport.CreateDataSet;

  qryCadRec.First;
  while not qryCadRec.Eof do
  begin
    cdsReport.Append;

    for I := 0 to Pred(qryCadRec.Fields.Count) do
      cdsReport.FieldByName(qryCadRec.Fields[I].FieldName).Value := qryCadRec.Fields[I].Value;

    //// MemoVencimento ////
    dtaDtaVen := qryCadRec.FieldByName('CTR_DTAVEN').AsDateTime;
    DecodeDate(dtaDtaVen, wrdAnoVen, wrdMesVen, wrdDiaVen);

    strMesExtV := fRetMesExtenso(wrdMesVen);
    strDataVen := IntToStr(wrdDiaVen) + ' DE ' + AnsiUpperCase(strMesExtV) + ' DE ' + IntToStr(wrdAnoVen);

    cdsReport.FieldByName('MemoVencimento').AsString := 'Vencimento: ' + strDataVen;

    //// MemoValor ////
    fltValDup := qryCadRec.FieldByName('CTR_VALDUP').AsFloat;
    cdsReport.FieldByName('MemoValor').AsString := 'R$ ' + FormatFloat('#,##0.00', fltValDup);

    //// MemoTexto ////
    fltValMor := fltValDup * fltValMor / 100;
    cdsReport.FieldByName('MemoTexto').AsString :=
      '               Aos ' + fPadR(strDataVen, 26, '*') + ' pagarei por esta única via de NOTA' +
      ' PROMISSORIA a ' + fPadR(cdsReport.FieldByName('EMP_NOMFAN').AsString, 40, '*') + ', CNPJ: ' + FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), cdsReport.FieldByName('EMP_C_G_C_').AsString) +
      ' ou a sua ordem, a quantia de ' + Copy(fPadR(AnsiUpperCase(fRetExtensoNumero(FloatToStr(fltValDup))), 101, '*'),1, 51) + ' ' +
      Copy(fPadR(AnsiUpperCase(fRetExtensoNumero(FloatToStr(fltValDup))), 101, '*'),52, 101) +
      ' em moeda corrente deste país.';

    cdsReport.FieldByName('MemoTextoComRazaoSocial').AsString :=
      '               Aos ' + fPadR(strDataVen, 26, '*') + ' pagarei por esta única via de NOTA' +
      ' PROMISSORIA a ' + fPadR(cdsReport.FieldByName('EMP_NOMEMP').AsString, 40, '*') + ', CNPJ: ' + FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), cdsReport.FieldByName('EMP_C_G_C_').AsString) +
      ' ou a sua ordem, a quantia de ' + Copy(fPadR(AnsiUpperCase(fRetExtensoNumero(FloatToStr(fltValDup))), 101, '*'),1, 51) + ' ' +
      Copy(fPadR(AnsiUpperCase(fRetExtensoNumero(FloatToStr(fltValDup))), 101, '*'),52, 101) +
      ' em moeda corrente deste país.';

    //// MemoObs ////
    cdsReport.FieldByName('MemoObs').AsString := 'Observação: Cobrar juros de mora: R$ ' + FormatFloat('#,##0.00', fltValMor) + ' ao dia.';

    //// NumeroTotalDeNP ////
    cdsReport.FieldByName('TOTPAR').AsString := FormatFloat('00', qryCadRec.RecordCount);

    cdsReport.Post;

    qryCadRec.Next;
  end;

  cdsReport.First;

  impMatricial.pSetaInfoImpressoraMatricial('Impressão de Nota Promissoria', True, False);

  pCriarFormularios(TfrmQckNotaPromissoria, frmQckNotaPromissoria);

  frmQckNotaPromissoria.frxDatasetDup.DataSet := cdsReport;

  frxRelatorio := fLoadLayoutReport(strTipBol);

  frxComponent := frxRelatorio.FindObject('MasterData1');
  if Assigned(frxComponent) and (frxComponent is TfrxMasterData) then
  begin
    If fCfgSis('LAY_NP', VarString) = '2' Then // FOLHA INTEIRA
      TfrxMasterData(frxComponent).StartNewPage := True
    Else
      TfrxMasterData(frxComponent).StartNewPage := False;
  end;

  frxRelatorio.PrintOptions.Printer      := AnsiReplaceText(FNomImp, '\\' + fRetNomeRede + '\', '');
  frxRelatorio.PrintOptions.ShowDialog   := (FNomImp = '');
  frxRelatorio.PreviewOptions.Buttons    := [pbPrint,pbExport,pbZoom,pbFind,pbOutline,pbPageSetup,pbTools,pbNavigator];

  If frxRelatorio.PrepareReport Then
    pPrintReport(FNomFrm, 'Impressão de Nota Promissória', FNomImp, frxRelatorio);

  FreeAndNil(frmQckNotaPromissoria);

  FreeAndNil(cdsReport);
end;

class procedure TImpNotaPromissoria.pImprimeNotaPromissoria(ArrDupCtr: TArrDupCtr;
  strNomFrm, strNomFil: String; qryCadRec: TUniQuery; fltValMor: Double; strTipBol: String);
Var
  impNotaPromissoria: TImpNotaPromissoria;
  I: Integer;
begin
  qryCadRec.SQL.Clear;

  qryCadRec.SQL.Add('SET @ROW := 0; ');
  qryCadRec.SQL.Add('SELECT DISTINCT (@ROW := @ROW + 1) AS NUMPAR, ');
  qryCadRec.SQL.Add('  CTR_CODCLI, CTR_CODEMP, CTR_NUMDUP, CTR_PARCEL, CTR_ESPDOC, CTR_DTAVEN, CTR_VALDUP, CTR_DTACAD,');
  qryCadRec.SQL.Add('  CLI_NOMCLI, CLI_CGCCPF, CLI_C_G_C_, CLI_ENDERE, CLI_BAIRRO, CLI_C_E_P_, CLI_FONE01, CLI_I_E_S_, CLI_ENDNUM, CLI_NUMR_G,');
  qryCadRec.SQL.Add('  CADCID.CID_NOMCID, CADCID.CID_ESTADO,');
  qryCadRec.SQL.Add('  CTR_CODVEN, OPE_NOMOPE,');
  qryCadRec.SQL.Add('  EMP_NOMEMP, EMP_NOMFAN, EMP_C_G_C_, EMP_FONE01, EMP_ENDERE, EMP_ENDNUM, EMP_BAIRRO, EMP_I_E_S_,');
  qryCadRec.SQL.Add('  CADCIDEMP.CID_NOMCID AS CID_NOMCID_EMP, CADCIDEMP.CID_ESTADO AS CID_ESTADO_EMP, ');
  qryCadRec.SQL.Add('  (SELECT FGO_NUMDOC FROM FATGOR ');
  qryCadRec.SQL.Add('  WHERE FGO_NUMFAT = CTR_NUMDUP ');
  qryCadRec.SQL.Add('    AND FGO_TIPFAT = CTR_ESPDOC ');
  qryCadRec.SQL.Add('    AND FGO_CODEMP = CTR_CODEMP ');
  qryCadRec.SQL.Add('    AND FGO_CODCLI = CTR_CODCLI) AS NUMPED ');
  qryCadRec.SQL.Add('FROM ');
  qryCadRec.SQL.Add('  CADREC  ');
  qryCadRec.SQL.Add('LEFT JOIN MOVGER ON GER_NUMDOC = CTR_NUMDUP AND ');
  qryCadRec.SQL.Add('                    GER_ESPDOC = CTR_ESPDOC AND ');
  qryCadRec.SQL.Add('                    GER_CODEMP = CTR_CODEMP AND ');
  qryCadRec.SQL.Add('                    GER_CODCLI = CTR_CODCLI ');
  qryCadRec.SQL.Add('JOIN CADCLI ON CLI_CODCLI = CTR_CODCLI');
  qryCadRec.SQL.Add('JOIN CADCID ON CID_CODCID = CLI_CODCID');
  qryCadRec.SQL.Add('LEFT JOIN CADOPE ON CTR_CODVEN = OPE_CODOPE');
  qryCadRec.SQL.Add('JOIN CADEMP ON EMP_CODEMP = CTR_CODEMP');
  qryCadRec.SQL.Add('JOIN CADCID AS CADCIDEMP ON CADCIDEMP.CID_CODCID = EMP_CODCID');
  qryCadRec.SQL.Add('WHERE ');

  For I := 0 To Length(ArrDupCtr)-1 Do
  begin
    if I <> 0 then
      qryCadRec.SQL.Add('or');

    qryCadRec.SQL.Add('(');
    qryCadRec.SQL.Add('  CTR_NUMDUP = :NUMDUP' + IntToStr(I) + ' AND ');
    qryCadRec.SQL.Add('  CTR_PARCEL = :PARCEL' + IntToStr(I) + ' AND ');
    qryCadRec.SQL.Add('  CTR_ESPDOC = :ESPDOC' + IntToStr(I) + ' AND ');
    qryCadRec.SQL.Add('  CTR_CODEMP = :CODEMP' + IntToStr(I));
    qryCadRec.SQL.Add(')');
  end;

  For I := 0 To Length(ArrDupCtr)-1 Do
  begin
    qryCadRec.ParamByName('NUMDUP' + IntToStr(I)).AsString := ArrDupCtr[I].strNumDup;
    qryCadRec.ParamByName('PARCEL' + IntToStr(I)).AsString := ArrDupCtr[I].strParcel;
    qryCadRec.ParamByName('ESPDOC' + IntToStr(I)).AsString := ArrDupCtr[I].strEspDoc;
    qryCadRec.ParamByName('CODEMP' + IntToStr(I)).AsString := ArrDupCtr[I].strCodEmp;
  end;

  qryCadRec.Open;

  impNotaPromissoria := TImpNotaPromissoria.Create(strNomFrm, strNomFil, False);
  impNotaPromissoria.pImprimePromissoria(qryCadRec, fltValMor, strTipBol);
  FreeAndNil(impNotaPromissoria);
end;

end.
