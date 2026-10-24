unit untCarnePagto;

interface

uses Classes, Uni, untImpGerencial, untFuncoesSimples, untTypesSistema;

type
  TOpcaoContrato = (ContratoVenda, ContratoReparcelamento);

type
  TRecDuplicatas = record
    strSequen,
    strNumDup,
    strEspDoc,
    strParcel,
    strDtaVen,
    strValDup,
    strDtaRec,
    strValRec,
    strDtaCad: String;
  end;

type
  TArrDuplicatas = Array of TRecDuplicatas;

type
  TCarnePagamento = class(TComponent)
    private
      FBarCon: String;
      FCodCli: String;
      FCodEmp: String;
      FNomCli: String;
      FLimCre: Double;
      FTotDeb: Double;
      FTotDup: Double;
      FTotRec: Double;
      FNomVen: String;
      FDtaCom: String;
      FTemDup: Boolean;
      FDuplic: TArrDuplicatas;
      FDupRep: TArrDuplicatas; // Duplicatas que foram reparceladas
      FOpcCon: TOpcaoContrato;
      FImpGerencial: TImprimeGerencial;
      FstlMenPed : TStringList;

      function fTotalDebitos: Double;
      function fLimiteDisponivel: Double;
      function fGetSqlDuplicatasContrato: string;
      function fGetSqlFromDuplicatas(strTabela: String): String;
      function fgetSqlDuplicatasReparceladas(const strNumAgr: String): String;

      procedure pCarregaDadosContrato;
      procedure pCarregaDuplicatas(var arrDuplic: TArrDuplicatas; qryDuplic: TUniQuery);

      procedure pCarregarMsgPedidoDaDuplicata(strNumDup, strEspDoc, strCodEmp, strCodCli: String);
      function getMenPed: String;
      function fRetLayoutProprio(TipoDoc: TTipoEtiqueta): Boolean;
      procedure pImprimeLayOutContratoDuplic(strTipo, strNumDoc, strEspDoc, strCodCli: string);

    public
      constructor Create(AOwner: TComponent; strCodigoContrato: String); reintroduce;
      destructor Destroy; override;

      function fImprimirContratoOuCarneReciboParaNF(blnTemLayoutProprio: Boolean): Boolean;
      function fImprimirContrato(): Boolean;
      function fImprimirCarneRecibo(): Boolean;

      class function fNovoNumeroContrato(contrato: TOpcaoContrato): String;
      property strMenPed: String read getMenPed;
    end;

Const
  INT_CARAC_NOR = 48;
  INT_CARAC_EXP = 24;
  IDE_CONTRATO_VENDA = '1';
  IDE_CONTRATO_REPARCELAMENTO = '2';

implementation

uses SysUtils, StrUtils, untFiscal, Data.DB, untQckFatImpNFCe, untEditorFastImpressao, TypesRel;

{ TCarnePagamento }

constructor TCarnePagamento.Create(AOwner: TComponent;
  strCodigoContrato: String);
begin
  FBarCon := strCodigoContrato;

  If Not fEmptyStr(FBarCon) Then
  Begin
    Case FBarCon[1] Of
      IDE_CONTRATO_VENDA          : FOpcCon := ContratoVenda;
      IDE_CONTRATO_REPARCELAMENTO : FOpcCon := ContratoReparcelamento;
    end;
  End;

  FstlMenPed := TStringList.Create;

  pCarregaDadosContrato;

  FImpGerencial := TImprimeGerencial.Create(Self);
end;

procedure TCarnePagamento.pCarregaDadosContrato;
  var
    qryGen: TUniQuery;
    intAux: Integer;
begin
  qryGen := fCriaQuery(Self);

  With qryGen, SQL Do
  Begin
    Add(fGetSqlDuplicatasContrato);
    Open;

    FTemDup := Not IsEmpty;

    If FTemDup Then
    Begin
      FCodCli := FieldByName('CODCLI').AsString;
      FCodEmp := FieldByName('CODEMP').AsString;
      FNomCli := FieldByName('NOMCLI').AsString;
      FLimCre := FieldByName('LIMCRE').AsFloat;

      FDtaCom := FormatDateTime('dd/MM/yyyy', FieldByName('DTACAD').AsDateTime);

      FTotDeb := fTotalDebitos;

      FNomVen := FieldByName('NOMVEN').AsString;

      FTotDup := 0;
      FTotRec := 0;

      pCarregaDuplicatas(FDuplic, qryGen);

      For intAux := 0 To Length(FDuplic) -1 Do
      Begin
        FTotDup := FTotDup + fStrToFloat(FDuplic[intAux].strValDup);
        FTotRec := FTotRec + fStrToFloat(FDuplic[intAux].strValRec);        
      End;

      If FOpcCon = ContratoReparcelamento Then
      Begin
        Close;
        Clear;
        Add(fgetSqlDuplicatasReparceladas(FDuplic[0].strNumDup));
        Open;

        pCarregaDuplicatas(FDupRep, qryGen);

        If fCfgSis('CREMSG', varBoolean) Then
        Begin
          For intAux := Low(FDupRep) To High(FDupRep) Do
          Begin
            pCarregarMsgPedidoDaDuplicata(FDupRep[intAux].strNumDup, FDupRep[intAux].strEspDoc, FCodEmp, FCodCli);
            If (FstlMenPed.Count > 0) Then
              Break;
          End;
        End;
      End
      Else
      Begin
        If fCfgSis('CREMSG', varBoolean) Then
          pCarregarMsgPedidoDaDuplicata(FDuplic[0].strNumDup, FDuplic[0].strEspDoc, FCodEmp, FCodCli);
      End;

    End;
  End;

  FreeAndNil(qryGen);
end;

procedure TCarnePagamento.pCarregaDuplicatas(var arrDuplic: TArrDuplicatas; qryDuplic: TUniQuery);
begin
  With qryDuplic Do
  Begin
    First;

    SetLength(arrDuplic, RecordCount);

    While Not Eof Do
    Begin
      arrDuplic[RecNo -1].strSequen := fStrZero(IntToStr(RecNo), 3);

      arrDuplic[RecNo -1].strNumDup := FieldByName('NUMDUP').AsString;
      arrDuplic[RecNo -1].strEspDoc := FieldByName('ESPDOC').AsString;
      arrDuplic[RecNo -1].strParcel := FieldByName('PARCEL').AsString;

      arrDuplic[RecNo -1].strDtaVen := FormatDateTime('dd/MM/yy', FieldByName('DTAVEN').AsDateTime);
      arrDuplic[RecNo -1].strValDup := FloatToStrF(FieldByName('VALDUP').AsFloat, ffNumber, 12, 2);

      arrDuplic[RecNo -1].strDtaRec := '';
      arrDuplic[RecNo -1].strValRec := '';

      arrDuplic[RecNo -1].strDtaCad := FormatDateTime('dd/MM/yy', FieldByName('DTACAD').AsDateTime);

      If Not FieldByName('DTAREC').IsNull Then
      Begin
        arrDuplic[RecNo -1].strDtaRec := FormatDateTime('dd/MM/yy', FieldByName('DTAREC').AsDateTime);
        arrDuplic[RecNo -1].strValRec := FloatToStrF(FieldByName('VALREC').AsFloat, ffNumber, 12, 2);
      End;

      Next;
    End;
  End;

end;

procedure TCarnePagamento.pCarregarMsgPedidoDaDuplicata(strNumDup, strEspDoc,
  strCodEmp, strCodCli: String);
  Var
    intCnt : Integer;
    qryDocume : TUniQuery;
    qryFatGor : TUniQuery;
    stlMensag : TStringList;
begin
  FstlMenPed.Clear;

  qryDocume := fCriaQuery;
  qryFatGor := fCriaQuery;
  stlMensag := TStringList.Create;

  With qryDocume Do
  Begin
    For IntCnt := 1 To 2 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT DET_NUM_PD, DET_ESP_PD, DET_EMP_PD ');
      SQL.Add('   FROM ' + IIF(intCnt = 1, 'MOVDET', 'NOTDET'));
      SQL.Add('  WHERE DET_NUMDOC = :NUMDOC ');
      SQL.Add('    AND DET_ESPDOC = :ESPDOC ');
      SQL.Add('    AND DET_CODEMP = :CODEMP ');
      SQL.Add('    AND DET_CODCLI = :CODCLI ');
      SQL.Add('    AND DET_NUM_PD <> "" ');
      SQL.Add('  ORDER BY DET_DTAENT DESC ');
      SQL.Add('  LIMIT 1 ');
      ParamByName('NUMDOC').AsString := strNumDup;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      Open;

      If Not IsEmpty Then
        Break;
    End;
  End;

  If (Not qryDocume.IsEmpty) Then
  Begin
    With qryFatGor Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT FGO_MEN001, FGO_MEN002 ');
      SQL.Add('   FROM FATGOR ');
      SQL.Add('  WHERE FGO_NUMDOC = :NUMDOC ');
      SQL.Add('    AND FGO_ESPDOC = :ESPDOC ');
      SQL.Add('    AND FGO_CODEMP = :CODEMP ');
      SQL.Add('    AND FGO_CODCLI = :CODCLI ');
      ParamByName('NUMDOC').AsString := qryDocume.FieldByName('DET_NUM_PD').AsString;
      ParamByName('ESPDOC').AsString := qryDocume.FieldByName('DET_ESP_PD').AsString;
      ParamByName('CODEMP').AsString := qryDocume.FieldByName('DET_EMP_PD').AsString;
      ParamByName('CODCLI').AsString := strCodCli;
      Open;

      If Not IsEmpty Then
      Begin
        If Not fEmptyStr(FieldByName('FGO_MEN001').AsString) Then
          stlMensag.Text := WrapText(FieldByName('FGO_MEN001').AsString, #13#10, [' '], INT_CARAC_NOR);

        For intCnt := 0 To stlMensag.Count -1 Do
          FstlMenPed.Add( stlMensag.Strings[intCnt] );

        If Not fEmptyStr(FieldByName('FGO_MEN002').AsString) Then
          stlMensag.Text := WrapText(FieldByName('FGO_MEN002').AsString, #13#10, [' '], INT_CARAC_NOR);

        For intCnt := 0 To stlMensag.Count -1 Do
          FstlMenPed.Add( stlMensag.Strings[intCnt] );
      End;
    End;
  End;

  FreeAndNil(qryDocume);
  FreeAndNil(qryFatGor);
  FreeAndNil(stlMensag);
end;

function TCarnePagamento.fGetSqlFromDuplicatas(strTabela: String): String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   CTR_NUMDUP AS NUMDUP, ';
  Result := Result + '   CTR_ESPDOC AS ESPDOC, ';
  Result := Result + '   CTR_CODEMP AS CODEMP, ';
  Result := Result + '   CTR_PARCEL AS PARCEL, ';
  Result := Result + '   CLI_CODCLI AS CODCLI, ';
  Result := Result + '   CLI_NOMCLI AS NOMCLI, ';
  Result := Result + '   CLI_LIMCRE AS LIMCRE, ';
  Result := Result + '   CTR_DTACAD AS DTACAD, ';
  Result := Result + '   OPE_NOMOPE AS NOMVEN, ';
  Result := Result + '   CTR_DTAVEN AS DTAVEN, ';
  Result := Result + '   IF(CTR_DTAREC IS NULL, CTR_VALDUP, CTR_VALORI) AS VALDUP, ';
  Result := Result + '   CTR_DTAREC AS DTAREC, ';
  Result := Result + '   CTR_VALREC AS VALREC  ';
  Result := Result + ' FROM ';
  Result := Result + '   ' + strTabela;
  Result := Result + '   INNER JOIN CADCLI ON CTR_CODCLI = CLI_CODCLI ';
  Result := Result + '   LEFT  JOIN CADOPE ON CTR_CODVEN = OPE_CODOPE ';
end;

destructor TCarnePagamento.Destroy;
begin
  If Assigned(FImpGerencial) Then
    FreeAndNil(FImpGerencial);
  FreeAndNil(FstlMenPed);
  inherited;
end;

function TCarnePagamento.fGetSqlDuplicatasContrato: string;
begin
  Result := fGetSqlFromDuplicatas('CADREC');

  Result := Result + ' WHERE ';
  Result := Result + '   CTR_BARCON = ' + QuotedStr(FBarCon);

  Result := Result + ' ORDER BY ';
  Result := Result + '   DTAVEN ';
end;


function TCarnePagamento.fgetSqlDuplicatasReparceladas(const strNumAgr: String): String;
begin
  Result := fGetSqlFromDuplicatas('DUPAGR');

  Result := AnsiReplaceStr(Result, 'CTR_DTAREC', 'NULL');
  Result := AnsiReplaceStr(Result, 'CTR_VALREC', 'NULL');

  Result := Result + ' WHERE ';
  Result := Result + '   CTR_NUMAGR = ' + QuotedStr(strNumAgr) + ' AND ';
  Result := Result + '   CTR_CODEMP = ' + QuotedStr(VS_strCodEmp);
  Result := Result + ' ORDER BY ';
  Result := Result + '   DTAVEN ';
end;

function TCarnePagamento.fImprimirContratoOuCarneReciboParaNF(blnTemLayoutProprio: Boolean): Boolean;
begin
  Result := False;

  If (Length(FDuplic) > 0) Then
  Begin
    If (FDuplic[0].strEspDoc = 'NF') Then
    Begin
      Result := (Not FImpGerencial.blnPodeImprimir) Or (blnTemLayoutProprio);
    End;
  End;
end;

function TCarnePagamento.fImprimirContrato: Boolean;
  Var
    stlImpressao: TStringList;
    intDuplicata: Integer;
    blnExpandido: Boolean;
    strDesDoc   : String;
    strDesDocMsg: String;

  procedure pAddLinha(strTexto: String; blnCentralizar: Boolean = False);
  begin
    If blnExpandido Then
      stlImpressao.Add(strTexto)
    Else If blnCentralizar Then
      stlImpressao.Add(fPadC(strTexto, INT_CARAC_NOR))
    Else
      stlImpressao.Add(fPadR(strTexto, INT_CARAC_NOR));
  end;

begin
  Result := False;

  If (fCfgSis('USNFCE', varBoolean)) Or
     (fUsaSat) Or
     (fImprimirContratoOuCarneReciboParaNF(fRetLayoutProprio(tpeCarnePagamento))) Then
  Begin

    If Not fRetLayoutProprio(tpeCarnePagamento) Then
    Begin
      pImprimirContrato(FBarCon, FOpcCon, FDuplic, FDupRep, FCodCli,
        FNomCli, FNomVen, FTotDup, FTotRec, strMenPed, FDtaCom);
      Result := True;
      Exit;
    End
    Else
    Begin
      If Length(FDuplic) > 0 Then
      Begin
        pImprimeLayOutContratoDuplic('DPS', FDuplic[0].strNumDup, FDuplic[0].strEspDoc, FCodCli);
        Exit;
      End;
    End;

  End;

  If Not FImpGerencial.blnPodeImprimir Then
    Exit;

  stlImpressao := TStringList.Create;

  With FImpGerencial Do
  Begin

    blnExpandido := Not SameText(EmptyStr, fFormatarTextoImp(EmptyStr, [fiExpandido]));

    If FTemDup Then
    Begin
      strDesDoc    := 'Cupom Fiscal: ';
      strDesDocMsg := 'Cupom Fiscal';

      If (SameText(FDuplic[0].strEspDoc, 'NF')) Then
      Begin
        strDesDoc    := 'Nota Fiscal.: ';
        strDesDocMsg := 'Nota Fiscal';
      End;

      If (SameText(FDuplic[0].strEspDoc, 'NS')) Then
      Begin
        strDesDoc    := 'NF Servico..: ';
        strDesDocMsg := 'NF Servico';
      End;

      pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));

      pAddLinha(fFormatarTextoImp(fPadC('DUPLICATA', INT_CARAC_EXP), [fiNegrito, fiExpandido]), True);

      pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));

      Case FOpcCon Of
        ContratoVenda          : pAddLinha(fFormatarTextoImp(strDesDoc, [fiNegrito]) + fFormatarTextoImp(FDuplic[0].strNumDup + '-' + FDuplic[0].strEspDoc, [fiNegrito, fiExpandido]));
        ContratoReparcelamento : pAddLinha(fFormatarTextoImp('Documento...: ', [fiNegrito]) + fFormatarTextoImp(FDuplic[0].strNumDup + '-' + FDuplic[0].strEspDoc, [fiNegrito, fiExpandido]));
      End;

      pAddLinha(fFormatarTextoImp('Contrato....: ', [fiNegrito]) + fFormatarTextoImp(FBarCon, [fiNegrito, fiExpandido]));

      If (FOpcCon = ContratoReparcelamento) And (Length(FDupRep) > 0) Then
      Begin
        pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));

        pAddLinha(fFormatarTextoImp('Documentos do Reparcelamento:', [fiNegrito]));

        For intDuplicata := 0 To Length(FDupRep) -1 Do
        Begin
          pAddLinha(fFormatarTextoImp('-Dup: ' + FDupRep[intDuplicata].strNumDup +
                               FDupRep[intDuplicata].strParcel + '-' +
                               FDupRep[intDuplicata].strEspDoc +

                    ' Ven: ' + fPadC(FDupRep[intDuplicata].strDtaVen, 08) +
                    ' Vlr: ' + fPadL(FDupRep[intDuplicata].strValDup, 12), [fiNegrito]));
        End;
      End;

      pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));

      pAddLinha(fFormatarTextoImp('Cliente.....: ' + fPadR(FCodCli + '-' + FNomCli, INT_CARAC_NOR - 14), [fiNegrito]));

      Case FOpcCon Of
        ContratoVenda          : pAddLinha(fFormatarTextoImp('Vendedor....: ' + fPadR(FNomVen, INT_CARAC_NOR - 14), [fiNegrito]));
        ContratoReparcelamento : pAddLinha(fFormatarTextoImp('Operador....: ' + fPadR(fRetNomVendRep(strLoginUsuarioLogado), INT_CARAC_NOR - 14), [fiNegrito]));
      End;

      pAddLinha(fFormatarTextoImp('Valor Compra: ' + fPadL(FloatToStrF(FTotDup, ffNumber, 12, 2), INT_CARAC_NOR - 14), [fiNegrito]));
      pAddLinha(fFormatarTextoImp('Valor Pago..: ' + fPadL(FloatToStrF(FTotRec, ffNumber, 12, 2), INT_CARAC_NOR - 14), [fiNegrito]));

      pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));

      Case FOpcCon Of
        ContratoVenda          : pAddLinha(fFormatarTextoImp(fPadC('DEMONSTRATIVO',  INT_CARAC_EXP), [fiNegrito, fiExpandido]), True);
        ContratoReparcelamento : pAddLinha(fFormatarTextoImp(fPadC('REPARCELAMENTO', INT_CARAC_EXP), [fiNegrito, fiExpandido]), True);
      End;

      pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));

      pAddLinha(fFormatarTextoImp('Par Vencimento    Parcela Dt.Pagto   Vr.Pagto', [fiNegrito]));

      For intDuplicata := 0 To Length(FDuplic) -1 Do
      Begin
        pAddLinha(fFormatarTextoImp(fPadR(FDuplic[intDuplicata].strSequen, 03) + ' ' +
                  fPadC(FDuplic[intDuplicata].strDtaVen, 10) + ' ' +
                  fPadL(FDuplic[intDuplicata].strValDup, 10) + ' ' +
                  fPadC(FDuplic[intDuplicata].strDtaRec, 08) + ' ' +
                  fPadL(FDuplic[intDuplicata].strValRec, 10), [fiNegrito]));
      End;

      pAddLinha(fReplicatorStr(' ', INT_CARAC_NOR));
      pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));

      If fCfgSis('CREMSG', varBoolean) And (FstlMenPed.Count > 0) Then
      Begin
        For intDuplicata := 0 To FstlMenPed.Count-1 Do
          pAddLinha(fPadR(fRemoveAcento(FstlMenPed.Strings[intDuplicata]), INT_CARAC_NOR));
        pAddLinha(fReplicatorStr(' ', INT_CARAC_NOR));
        pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));
      End;

      pAddLinha(fFormatarTextoImp(fPadR('Reconheco como liquida e certa a divida objeto', INT_CARAC_NOR), [fiNegrito]));

      Case FOpcCon Of
        ContratoVenda          : pAddLinha(fFormatarTextoImp(fPadR('deste ' + strDesDocMsg + ' e obrigo-me a paga-la no   ', INT_CARAC_NOR), [fiNegrito]));
        ContratoReparcelamento : pAddLinha(fFormatarTextoImp(fPadR('deste reparcelamento e obrigo-me a paga-la no ', INT_CARAC_NOR), [fiNegrito]));
      End;

      pAddLinha(fFormatarTextoImp(fPadR('valor, prazo e condicoes acima.               ', INT_CARAC_NOR), [fiNegrito]));
      pAddLinha(fPadR(' '                                             , INT_CARAC_NOR));
      pAddLinha(fPadR(' '                                             , INT_CARAC_NOR));
      pAddLinha(fPadR(' '                                             , INT_CARAC_NOR));
      pAddLinha(fFormatarTextoImp(fPadC('__________________________'                    , INT_CARAC_NOR), [fiNegrito]));
      pAddLinha(fFormatarTextoImp(fPadC('Assinatura'                                    , INT_CARAC_NOR), [fiNegrito]));
      pAddLinha(fPadR(' '                                             , INT_CARAC_NOR));

      pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));
      pAddLinha(fReplicatorStr(' ', INT_CARAC_NOR));

      If fAbreRelatorioGerencial Then
      Begin
        Result := True;

        For intDuplicata := 0 To stlImpressao.Count -1 Do
          Result := Result And fRelatorioGerencial(stlImpressao[intDuplicata]);

        fFechaRelatorioGerencial(True);
      End;

    End;
  End;

  FreeAndNil(stlImpressao);
end;

procedure TCarnePagamento.pImprimeLayOutContratoDuplic(strTipo, strNumDoc, strEspDoc, strCodCli: string);
  Var
    objImpressao: TEditorFastImpressao;
begin
  objImpressao := TEditorFastImpressao.Create(Nil);

  With objImpressao Do
  Begin
    recDocume.strNumDoc := strNumDoc;
    recDocume.strEspDoc := strEspDoc;
    recDocume.strCodEmp := FCodEmp;
    recDocume.strCodCli := strCodCli;
    If (strTipo='CPS') Then
      recDocume.blnCarnePagamento := True;
    If (strTipo='DPS') Then
      recDocume.blnDuplicata := True;
    fImprimeDocumento(tpaNormal);
  End;

  FreeAndNil(objImpressao);
End;

function TCarnePagamento.fImprimirCarneRecibo: Boolean;
  Const
    CODIGO_BARRAS = 'CODIGO_BARRAS';

  Var
    stlImpressao: TStringList;
    intDuplicata: Integer;
    blnExpandido: Boolean;
    intContLin: Integer;
    strTextoImp: String;
    blnImpCodBar: Boolean;

  procedure pAddLinha(strTexto: String; blnCentralizar: Boolean = False);
  begin
    If blnExpandido Then
      stlImpressao.Add(strTexto)
    Else If blnCentralizar Then
      stlImpressao.Add(fPadC(strTexto, INT_CARAC_NOR))
    Else
      stlImpressao.Add(fPadR(strTexto, INT_CARAC_NOR));
  end;

begin
  Result := False;

  If (fCfgSis('USNFCE', varBoolean)) Or
     (fUsaSat) Or
     (fImprimirContratoOuCarneReciboParaNF(fRetLayoutProprio(tpeDuplicata))) Then
  Begin

    If Not fRetLayoutProprio(tpeDuplicata) Then
    Begin
      pImprimirCarnePagto(FBarCon, fLimiteDisponivel, FCodCli, FNomCli, FNomVen,
        FDtaCom, FDuplic);
      Result := True;
      Exit;
    End
    Else
    Begin
      If Length(FDuplic) > 0 Then
      Begin
        pImprimeLayOutContratoDuplic('CPS', FDuplic[0].strNumDup, FDuplic[0].strEspDoc, FCodCli) ;
        Exit;
      End;
    End;

  End;

  If Not FImpGerencial.blnPodeImprimir Then
    Exit;

  stlImpressao := TStringList.Create;

  With FImpGerencial Do
  Begin
    blnExpandido := Not SameText(EmptyStr, fFormatarTextoImp(EmptyStr, [fiExpandido]));

    If FTemDup Then
    Begin
      pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));

      pAddLinha(fFormatarTextoImp(fPadC('CARNÊ DE PAGAMENTO', INT_CARAC_EXP), [fiNegrito, fiExpandido]), True);

      pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));

      pAddLinha(fFormatarTextoImp('Contrato...: ', [fiNegrito]) + fFormatarTextoImp(FBarCon, [fiNegrito, fiExpandido]));

      pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));

      pAddLinha(fFormatarTextoImp(fPadR('Seu saldo em ' + DateToStr(VS_Date), INT_CARAC_NOR), [fiNegrito]));
      pAddLinha(fFormatarTextoImp(fPadR('para Novas Compras é de ' + FloatToStrF(fLimiteDisponivel, ffNumber, 12, 2), INT_CARAC_NOR), [fiNegrito]));

      pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));

      pAddLinha(fFormatarTextoImp(fPadR('Cliente....: ' + FCodCli + '-' + FNomCli, INT_CARAC_NOR), [fiNegrito]));
      pAddLinha(fFormatarTextoImp(fPadR('Vendedor...: ' + FNomVen, INT_CARAC_NOR), [fiNegrito]));
      pAddLinha(fFormatarTextoImp(fPadR('Data Compra: ' + FDtaCom, INT_CARAC_NOR), [fiNegrito]));

      pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));

      pAddLinha(fFormatarTextoImp(fPadC('VENCIMENTOS DO CARNÊ', INT_CARAC_EXP), [fiNegrito, fiExpandido]), True);

      pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));

      pAddLinha(fFormatarTextoImp('Par Vencimento    Parcela Dt.Pagto   Vr.Pagto', [fiNegrito]));

      For intDuplicata := 0 To Length(FDuplic) -1 Do
      Begin
        pAddLinha(fFormatarTextoImp(fPadR(FDuplic[intDuplicata].strSequen, 03) + ' ' +
                  fPadC(FDuplic[intDuplicata].strDtaVen, 10) + ' ' +
                  fPadL(FDuplic[intDuplicata].strValDup, 10) + ' ' +
                  fPadC(FDuplic[intDuplicata].strDtaRec, 08) + ' ' +
                  fPadL(FDuplic[intDuplicata].strValRec, 10), [fiNegrito]));
      End;

      pAddLinha(fReplicatorStr(' ', INT_CARAC_NOR));

      pAddLinha(CODIGO_BARRAS);

      pAddLinha(fReplicatorStr('-', INT_CARAC_NOR));
      pAddLinha(fReplicatorStr(' ', INT_CARAC_NOR));

      If fAbreRelatorioGerencial Then
      Begin
        Result := True;

        intDuplicata := 0;
        While intDuplicata <= stlImpressao.Count-1 Do
        Begin
          strTextoImp := '';
          blnImpCodBar := False;
          For intContLin := 1 To 5 Do
          Begin
            If Trim(stlImpressao[intDuplicata]) = CODIGO_BARRAS Then
            Begin
              blnImpCodBar := True;
              Break;
            End;

            strTextoImp := strTextoImp + stlImpressao[intDuplicata];
            Inc(intDuplicata);

            If (intContLin < 5) And (intDuplicata > stlImpressao.Count-1) Then
              Break;
          End;

          If Not fEmptyStr(strTextoImp) Then
          Begin
            Result := Result And fRelatorioGerencial(strTextoImp);
          End;

          If blnImpCodBar Then
          Begin
            Result := Result And fImprimirCodigoBarras(cbEAN13, FBarCon, '3', '70');
            Inc(intDuplicata);
          End;
        End;
        fFechaRelatorioGerencial(True);
      End;

    End;
  End;

  FreeAndNil(stlImpressao);
end;

function TCarnePagamento.fLimiteDisponivel: Double;
begin
  Result := FLimCre - FTotDeb;
  If Result < 0 Then
    Result := 0;
end;

function TCarnePagamento.fTotalDebitos: Double;
  Var
    qryDebitos: TUniQuery;
begin
  qryDebitos := fCriaQuery(Nil);

  With qryDebitos, SQL Do
  Begin
    Clear;

    Add(fSqlTotalDebitosClientes(FCodCli));

    Open;

    Result := FieldByName('TOTAL').AsFloat;

    Close;
  End;

  FreeAndNil(qryDebitos);     
end;

function TCarnePagamento.getMenPed: String;
  Var
    intCnt : Integer;
begin
  Result := '';
  If FstlMenPed.Count > 0 Then
  Begin
    For intCnt := 0 To FstlMenPed.Count-1 Do
    Begin
      If Not fEmptyStr(Result) Then
        Result := Result + #13#10;
      Result := Result + FstlMenPed.Strings[intCnt];
    End;
  End;
end;

class function TCarnePagamento.fNovoNumeroContrato(contrato: TOpcaoContrato): String;
  var
    strIdeCon: String;
begin
  Case contrato Of
    ContratoVenda         : strIdeCon := IDE_CONTRATO_VENDA;
    ContratoReparcelamento: strIdeCon := IDE_CONTRATO_REPARCELAMENTO;
  end;

  Result := fGeraCodBarraEAN13(strIdeCon +
    fStrZero(fRetSequencial('SEQCRE', VS_strCodEmp), 8) + VS_strCodEmp);
end;

function TCarnePagamento.fRetLayoutProprio(TipoDoc: TTipoEtiqueta): Boolean;
  Var
    qryLayEti: TUniQuery;
Begin
  Try

    Result := False;
    qryLayEti := fCriaQuery(Nil);

    With qryLayEti, SQL Do
    Begin

      Add('SELECT LAY_PADRAO, LAY_GERPDF ');
      Add('  FROM LAYETI                 ');
      Add(' WHERE LAY_PADRAO = "S"       ');
      Add('   AND LAY_CODEMP = :CODEMP   ');
      Add('   AND LAY_TIPLAY = :TIPLAY   ');

      ParamByName('CODEMP').AsString  := VS_strCodEmp;
      ParamByName('TIPLAY').AsInteger := ARR_CODIGO_ETIQUETA[TipoDoc];

      Open;
      Result := Not IsEmpty;
    End;

  Finally
    FreeAndNil(qryLayEti);
  End;

End;

end.
