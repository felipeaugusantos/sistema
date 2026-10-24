unit untPafGerais;

interface

uses Windows, SysUtils, Uni, StrUtils;

  procedure pTotalizarPagamentos(dtaDtaMov: TDateTime; strNumSer: String);
  function fRetornaNumSerGT(Var strNumSer: String; Var fltValGT: Double): Boolean;
  procedure pAtualizaGT(fltNovoValGT: Double; strNovoNumSer: String = '');
  function fPafUltNumCRO(strNumSerie: String): String;
  procedure pPafDadosUltReducao(strNumSerie: String; Var strNumCro, strNumCrz: String;
    Var fltVenBru: Double);
  function fComparaNumeroSerieGrandeTotal: Boolean;
  function fSangriaFoiImpressaNoPDV(intSeqCon: Integer; strCodEmp: String; strNumSer: String): Boolean;
  procedure pDeletarSangriaNaoImpressaNoPDV(intSeqCon: Integer; strCodEmp: String; strNumSer: String);
  function fUtilizaImpressaoDeSangriaNoPDV: Boolean;
  procedure pGerarSangriaSuprimento(strNumSer, strDesFpg: String; fltValSan: Double; intSeqCon: Integer; strCreDeb: String);
  function fNumeroSerieImpressora(strCodEmp: String): String;

implementation

uses untFuncoesSimples, untFuncoes, untFiscal, untPafCadIniECF, untFuncoesHash;

procedure pTotalizarPagamentos(dtaDtaMov: TDateTime; strNumSer: String);
  Var
    qryAux: TUniQuery;
    qryPag: TUniQuery;
begin

  qryAux := fCriaQuery;
  qryPag := fCriaQuery;

  qryPag.SQL.Add('SELECT * FROM PAFPAG WHERE FALSE');
  qryPag.Open;

  strNumSer := LeftStr(strNumSer, 20);

  qryAux.SQL.Clear;
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  PAFR07.PAF_NUMSER, ');
  qryAux.SQL.Add('  PAFR07.PAF_DTAEMI, ');
  qryAux.SQL.Add('  PAFR06.PAF_DENOMI, ');
  qryAux.SQL.Add('  PAFR07.PAF_MEIPAG, ');
  qryAux.SQL.Add('  SUM(PAFR07.PAF_VALPAG - PAFR07.PAF_VALEST) AS VALPAG, ');
  qryAux.SQL.Add('  0 ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  PAFR07 ');
  qryAux.SQL.Add('  JOIN PAFR06 ON PAFR06.PAF_NUMSER = PAFR07.PAF_NUMSER AND ');
  qryAux.SQL.Add('                 PAFR06.PAF_MFADIC = PAFR07.PAF_MFADIC AND ');
  qryAux.SQL.Add('                 PAFR06.PAF_MODECF = PAFR07.PAF_MODECF AND ');
  qryAux.SQL.Add('                 PAFR06.PAF_NUMUSU = PAFR07.PAF_NUMUSU AND ');
  qryAux.SQL.Add('                 PAFR06.PAF_NUMCOO = PAFR07.PAF_NUMCOO ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  (NOT (PAFR07.PAF_NUMCCF <> ""   AND ');
  qryAux.SQL.Add('        PAFR07.PAF_NUMGNF <> "")) AND ');
  qryAux.SQL.Add('  PAFR07.PAF_DTAEMI = :DTAEMI AND ');
  qryAux.SQL.Add('  PAFR07.PAF_NUMSER = :NUMSER ');

  qryAux.SQL.Add('GROUP BY ');
  qryAux.SQL.Add('  PAFR07.PAF_NUMSER, PAFR07.PAF_MEIPAG, PAFR06.PAF_DENOMI ');

  qryAux.SQL.Add('HAVING ');
  qryAux.SQL.Add('  ROUND(VALPAG, 2) > 0 ');

  qryAux.SQL.Add('UNION ALL ');

  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  PAFR07.PAF_NUMSER, ');
  qryAux.SQL.Add('  PAFR07.PAF_DTAEMI, ');
  qryAux.SQL.Add('  PAFR06.PAF_DENOMI, ');
  qryAux.SQL.Add('  PAFR07.PAF_MEIPAG, ');
  qryAux.SQL.Add('  SUM(PAFR07.PAF_VALPAG - PAFR07.PAF_VALEST) AS VALPAG, ');
  qryAux.SQL.Add('  0 ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  PAFR07 ');
  qryAux.SQL.Add('  JOIN PAFR06 ON PAFR06.PAF_NUMSER = PAFR07.PAF_NUMSER AND ');
  qryAux.SQL.Add('                 PAFR06.PAF_MFADIC = PAFR07.PAF_MFADIC AND ');
  qryAux.SQL.Add('                 PAFR06.PAF_MODECF = PAFR07.PAF_MODECF AND ');
  qryAux.SQL.Add('                 PAFR06.PAF_NUMUSU = PAFR07.PAF_NUMUSU AND ');
  qryAux.SQL.Add('                 PAFR06.PAF_NUMGNF = PAFR07.PAF_NUMGNF ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  PAFR06.PAF_DENOMI IN ("CC", "RG") AND ');
  qryAux.SQL.Add('  PAFR07.PAF_DTAEMI = :DTAEMI AND ');
  qryAux.SQL.Add('  PAFR07.PAF_NUMSER = :NUMSER ');

  qryAux.SQL.Add('GROUP BY ');
  qryAux.SQL.Add('  PAFR07.PAF_NUMSER, PAFR07.PAF_MEIPAG, PAF_DENOMI ');

  qryAux.SQL.Add('HAVING ');
  qryAux.SQL.Add('  ROUND(VALPAG, 2) > 0 ');

  qryAux.ParamByName('DTAEMI').AsDateTime := dtaDtaMov;
  qryAux.ParamByName('NUMSER').AsString   := strNumSer;
  qryAux.Open;
  
  While (Not qryAux.Eof) Do
  Begin

    fStartTransaction;
    Try
      qryPag.Append;
      qryPag.FieldByName('PAF_NUMSER').AsString   := qryAux.FieldByName('PAF_NUMSER').AsString;
      qryPag.FieldByName('PAF_DTAREF').AsDateTime := qryAux.FieldByName('PAF_DTAEMI').AsDateTime;
      qryPag.FieldByName('PAF_TIPDOC').AsString   := qryAux.FieldByName('PAF_DENOMI').AsString;
      qryPag.FieldByName('PAF_MEIPAG').AsString   := qryAux.FieldByName('PAF_MEIPAG').AsString;
      qryPag.FieldByName('PAF_VALACU').AsFloat    := qryAux.FieldByName('VALPAG').AsFloat;
      qryPag.Post;
      fCommit;
    Except
      fRollBack;
      Raise;
    End;

    qryAux.Next;
  End;

  FreeAndNil(qryPag);

  FreeAndNil(qryAux);
end;

function fRetornaNumSerGT(Var strNumSer: String; Var fltValGT: Double): Boolean;
  Var
    arqTxt: TextFile;
    strLinha: String;
    strNomArq: String;
begin

  Result := True;
  strNomArq := fCfgSis('DIRINI') + '\DADOS.ECF';

  If (Not FileExists(strNomArq)) Then
  Begin
    strNumSer := '';
    fltValGT := 0.0;
    Result := False;
  End
  Else
  Begin
    AssignFile(arqTxt, strNomArq);
    Reset(arqTxt);
    Readln(arqTxt, strLinha);
    CloseFile(arqTxt);

    strLinha := String(fDescriptografa(AnsiString(strLinha)));

    strNumSer := Copy(strLinha, 1, Pos('|', strLinha)-1);
    fltValGT  := fStrToFloat(Copy(strLinha, Pos('|', strLinha)+1, MaxInt));
  End;

end;

procedure pAtualizaGT(fltNovoValGT: Double; strNovoNumSer: String = '');
  Var
    strNumSer: String;
    fltValGT: Double;

    strLinha: String;
    arqTxt: TextFile;
    strNomArq: string;
begin

  strNomArq := fCfgSis('DIRINI') + '\DADOS.ECF';

  fRetornaNumSerGT(strNumSer, fltValGT);

  If (Not fEmptyStr(strNovoNumSer)) Then
    strNumSer := strNovoNumSer;

  strLinha := strNumSer + '|' + FloatToStrF(fltNovoValGT, ffNumber, 12, 2);

  strLinha := String(fCriptografa(AnsiString(strLinha)));

  AssignFile(arqTxt, strNomArq);
  Rewrite(arqTxt);
  WriteLn(arqTxt, strLinha);
  Flush(arqTxt);
  CloseFile(arqTxt);
end;

function fPafUltNumCRO(strNumSerie: String): String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  PAF_NUMCRO ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  PAFR02 ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  PAF_NUMSER = :NUMSER ');
  qryAux.SQL.Add('ORDER BY ');
  qryAux.SQL.Add('  PAF_DTAMOV DESC LIMIT 1');

  qryAux.ParamByName('NUMSER').AsString := Trim(strNumSerie);
  qryAux.Open;

  Result := qryAux.FieldByName('PAF_NUMCRO').AsString;

  FreeAndNil(qryAux);
end;

procedure pPafDadosUltReducao(strNumSerie: String; Var strNumCro, strNumCrz: String;
  Var fltVenBru: Double);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  PAF_NUMCRO, ');
  qryAux.SQL.Add('  PAF_NUMCRZ, ');
  qryAux.SQL.Add('  PAF_VENBRU ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  PAFR02 ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  PAF_NUMSER = :NUMSER ');
  qryAux.SQL.Add('ORDER BY ');
  qryAux.SQL.Add('  PAF_DTAMOV DESC LIMIT 1');

  qryAux.ParamByName('NUMSER').AsString := Trim(strNumSerie);
  qryAux.Open;

  strNumCro := qryAux.FieldByName('PAF_NUMCRO').AsString;
  strNumCrz := qryAux.FieldByName('PAF_NUMCRZ').AsString;
  fltVenBru := qryAux.FieldByName('PAF_VENBRU').AsFloat;

  FreeAndNil(qryAux);
end;

function fComparaNumeroSerieGrandeTotal: Boolean;
  Var
    strNumSer: String;
    fltValGT: Double;

    strUltNumCRO: String;
    strUltNumCRZ: String;
    fltUltVenBru: Double;
    drzDadosRed: TDadosReducao;
begin
  Result := True;

  If (Not Assigned(VS_objFiscal)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esta operação requer uma Impressora Fiscal (ECF).' + #13#10 +
                          'Feche o Sistema AUTCOM e tente conectar novamente com a impressora.' + #13#10 +
                          'Caso o problema persista, entre em contato com o responsável.', ['&Ok']);
    Result := False;
    Exit;
  End;

  Try
    pCriarFormularios(TfrmPafCadIniECF, frmPafCadIniECF);
    frmPafCadIniECF.btnExtrairDados.Click;
    frmPafCadIniECF.btnConfirmaDados.Click;
    FreeAndNil(frmPafCadIniECF);
  Except
    On E: Exception Do
    Begin
      fMensagem('', 'Ocorreu um erro ao tentar pegar o GT da impressora: ' + E.Message, ['&Ok']);
      Result := False;
      Exit;
    End;
  End;

  {*****************************************}
  {* CASO ENCONTRE O ARQUIVO, VERIFICA OS  *}
  {* DADOS. CASO CONTRÁRIO, VERIFICA SE    *}
  {* IRÁ GERAR NOVO (INCREMENTO DE CRZ).   *}
  {**************************************MV*}
  If (VS_objFiscal.fStatusImpressora = '1') Then
  Begin
    If fRetornaNumSerGT(strNumSer, fltValGT) Then
    Begin

      If (Trim(strNumSer) <> Trim(VS_objFiscal.fNumeroSerie)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Operação não permitida: número de série incompatível.', ['&Ok']);
        Result := False;
      End
      Else If (fFormataFloat(fltValGT, 2) <> fFormataFloat(VS_objFiscal.fGrandeTotal, 2)) Then
      Begin

        If (Not VS_objFiscal.fUltimoComandoComErro) Then
        Begin

          If (VS_objFiscal.fHouveIncrementoDeCRO) Then
          Begin
            pAtualizaGT(VS_objFiscal.fGrandeTotal);
          End
          Else
          Begin
            fMensagem('ATENÇÃO!', 'Operação não permitida: grande total incompatível.', ['&Ok']);
            Result := False;
          End;

        End
        Else
        Begin
          Result := False;
        End;
      End;

    End
    Else
    Begin

      pPafDadosUltReducao(VS_objFiscal.fNumeroSerie, strUltNumCRO, strUltNumCRZ,
        fltUltVenBru);

      If fEmptyStr(strUltNumCRO) Then
      Begin
        fMensagem('ATENÇÃO!', 'Operação não permitida: é necessário realizar o ' +
                              'cadastramento inicial do ECF.', ['&Ok']);
        Result := False;
      End
      Else
      Begin

        VS_objFiscal.fDadosUltimaReducao(drzDadosRed);

        If (Trim(strUltNumCRO) <> Trim(drzDadosRed.strNumCRO))                            Or
           (Trim(strUltNumCRZ) <> Trim(drzDadosRed.strNumCrz))                            Or
           (fFormataFloat(fltUltVenBru, 2) <> fFormataFloat(VS_objFiscal.fVendaBruta, 2)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Operação não permitida: dados da última redução divergentes.', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          pAtualizaGT(VS_objFiscal.fGrandeTotal, VS_objFiscal.fNumeroSerie);
        End;

      End;

    End;
  End
  Else
  Begin
    Result := False;
    fMensagem('ATENÇÃO!', 'Erro de comunicação com a impressora!', ['&Ok']);
  End;
end;

function fSangriaFoiImpressaNoPDV(intSeqCon: Integer; strCodEmp: String; strNumSer: String): Boolean;
  Var
    qrySangri: TUniQuery;
begin
  qrySangri := fCriaQuery(Nil);
  Try
    With qrySangri Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) CNT    ');
      SQL.Add('  FROM PAF_SANGRIA     ');
      SQL.Add(' WHERE PAF_SEQCON = :SEQCON ');
      SQL.Add('   AND PAF_CODEMP = :CODEMP ');
      SQL.Add('   AND PAF_NUMSER = :NUMSER ');
      SQL.Add('   AND PAF_IMPRES = 1 ');
      ParamByName('SEQCON').AsInteger := intSeqCon;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('NUMSER').AsString := strNumSer;
      Open;
      Result := (FieldByName('CNT').AsInteger > 0);
      Close;
    End;
  Finally
    FreeAndNil(qrySangri);
  End;
end;

procedure pDeletarSangriaNaoImpressaNoPDV(intSeqCon: Integer; strCodEmp: String; strNumSer: String);
  Var
    qrySangri: TUniQuery;
begin
  qrySangri := fCriaQuery(Nil);
  Try
    With qrySangri Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('DELETE   ');
      SQL.Add('  FROM PAF_SANGRIA     ');
      SQL.Add(' WHERE PAF_SEQCON = :SEQCON ');
      SQL.Add('   AND PAF_CODEMP = :CODEMP ');
      SQL.Add('   AND PAF_NUMSER = :NUMSER ');
      SQL.Add('   AND PAF_IMPRES = 0 ');
      ParamByName('SEQCON').AsInteger := intSeqCon;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('NUMSER').AsString := strNumSer;
      ExecSQL;
    End;
  Finally
    FreeAndNil(qrySangri);
  End;
end;

function fUtilizaImpressaoDeSangriaNoPDV: Boolean;
begin
  Result := (fCfgSis('SSNECF', varBoolean)) And // Sair sangria e suprimento no ECF quando emitir LD e LC?
            (fCfgSis('PAFECF', varBoolean)) And // Usa PDV
            (fCfgSis('RCXTCC') = '2'); // Transferência de Cheques e Cartões: (2 - Vinculada aos Documentos)
end;

procedure pGerarSangriaSuprimento(strNumSer, strDesFpg: String; fltValSan: Double; intSeqCon: Integer; strCreDeb: String);
  Var
    qrySangri : TUniQuery;
begin
  qrySangri := fCriaQuery(Nil);
  Try
    With qrySangri Do
    Begin
      Close;
      SQL.Text := 'SELECT * FROM PAF_SANGRIA WHERE FALSE';
      Open;

      Append;
      FieldByName('PAF_NUMSER').AsString := strNumSer;
      FieldByName('PAF_DTAEMI').AsDateTime := VS_Date;
      FieldByName('PAF_VALSAN').AsFloat := fltValSan;
      FieldByName('PAF_IMPRES').AsInteger := 0;
      FieldByName('PAF_SEQCON').AsInteger := intSeqCon;
      FieldByName('PAF_CODOPE').AsString := strLoginUsuarioLogado;
      FieldByName('PAF_CODEMP').AsString := VS_strCodEmp;
      FieldByName('PAF_DESFPG').AsString := strDesFpg;
      FieldByName('PAF_CREDEB').AsString := strCreDeb;
      Post;

      Close;
    End;
  Finally
    FreeAndNil(qrySangri);
  End;
end;

function fNumeroSerieImpressora(strCodEmp: String): String;
begin
  If (Not Assigned(VS_objFiscal)) Then
    Result := fRetNumSerie(strCodEmp)
  Else
    Result := VS_objFiscal.fNumeroSerie;
End;

end.
