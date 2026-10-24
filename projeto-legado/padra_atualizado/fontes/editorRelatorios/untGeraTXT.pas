unit untGeraTXT;

interface

uses
  Classes, SysUtils, Variants, untTypesSistema,
  Controls, StdCtrls, StrUtils, Printers,
  frxClass, frxDBSet, frxDesgn, frxDMPExport,
  Uni, DB, untFuncoesSimples, untRelFrx, frxDMPClass,
  cxProgressBar, Forms,
  untFuncEditorRel, untZClient, Math, untGeraFR3,
  System.IOUtils;

type
  TGeraTXT = class(TComponent)
    private
      FLinhas: TStringList;

      FArquivoAberto: String;
      FTextFile: TextFile;

      FNroRel,
      FNroCam: Integer;

      FPasta,
      FLinha: String;

      FGeraGR3: TGeraFR3;

      intDecUni,
      intDECQTD,
      intEstDec,
      intDeqTpc: Integer;

      FGravaDireto,
      FChildQuebra,
      FChildRelatorio: Boolean;
      FApenasPrincipal: Boolean;
      FArquivoBackup: Boolean;
      FEnviarSpool: Boolean;

      Function fAbreArquivo(strNomeArquivo: String): Boolean;

      Function fGravaArquivoAuxiliar(strNomArq: String; blnGerarSeVazio: Boolean): Boolean;

      Function fGeraXMLPafCte(strNomArq: String): Boolean;

      Procedure pGeraLinhaQuebra(objGeraFr3P: TGeraFR3; strNomeQuebra: String; blnExprValida: Boolean; Var stlLinhaQuebraAnterior: TStringList);

      Function fNumeroDecimais(objGeraFr3P: TGeraFR3): Integer;

      Function fEstaQuebrando(objGeraFr3P: TGeraFR3; strCampo: String): Boolean;

      Function fGeraArquivo(Progress : TcxProgressBar): Boolean;

      Function fGeraLinhas(strNomArq: String; objGeraFr3P: TGeraFR3; blnExprValida: Boolean = False; blnTemChild: Boolean = False): Boolean;

      Procedure pGeraCampos(objGeraFr3P: TGeraFR3; blnExprValida: Boolean = False);
      Function fCampoToString(filCampo: TField; intNroDec, intTamanho: Integer): String;
      Function fCampoToStringSemLimite(filCampo: TField; intNroDec: Integer): String;

      Procedure pAdicionaCampoNaLinha(filCampo: TField; intNroDec, intTamanho: Integer);

      Procedure pGeraQuebras(objGeraFr3P: TGeraFR3; blnExprValida: Boolean; var strCamposQuebra: string;
                             var strValoresQuebra: string;
                             Var stlLinhaQuebraAnterior: TStringList);

      function fRetornaFiltroConcat(sltFiltros: TStringList): string;
      function fTemChilds: Boolean;
      function fGravaArquivo(blnGerarSeVazio: Boolean): Boolean;
      function fResetaArquivo(strCodRel: String): Boolean;
      procedure pAssinarDigitalmente(strNomeArquivo: AnsiString);
      procedure pCarregarSignBema;
      function fEnviarTXTPontoImpressao(Progress : TcxProgressBar):Boolean;
    public

      constructor Create(AOwner: TComponent);  Reintroduce;
      destructor Destroy; override;

      Function fGeraTXT(strPasta: String;
                        blnChildQuebra,
                        blnChildRelatorio: Boolean;
                        blnApenasPrincipal: Boolean = False;
                        blnArquivoBackup: Boolean = False;
                        blnEnviarSpool: Boolean = False): Boolean;

    published

       Property objGeraGR3: TGeraFR3 Read FGeraGR3 Write FGeraGR3;

  end;

Var
  HandleSignBema: Cardinal;
  generateEAD: function( cNomeArquivo: AnsiString; cChavePublica: AnsiString; cChavePrivada: AnsiString; cEAD:AnsiString; iSign: Integer): integer; stdcall;

implementation

Uses
  untGravando, untRelatorio, untInterfaceRelatorio,
  untGeraXMLPAF, untConstantes, Windows, untSpoolImpressao;

constructor TGeraTXT.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FArquivoAberto := '';

  FLinhas := TStringList.Create;

  FNroRel := 0;

  FGravaDireto := False;

  FApenasPrincipal := False;
  FArquivoBackup := False;
  FEnviarSpool := False;

  intDecUni := fCfgSis('DECUNI', varInteger);
  intDECQTD := fCfgSis('DECQTD', varInteger);
  intEstDec := fCfgSis('ESTDEC', varInteger);
  intDeqTpc := fCfgSis('DEQTPC', varInteger);
end;

destructor TGeraTXT.Destroy;
begin
  inherited;

  FLinhas.Clear;
  FreeAndNil(FLinhas);
end;

Function TGeraTXT.fGravaArquivo(blnGerarSeVazio: Boolean): Boolean;
Begin
  Result := False;
  if FLinhas.Count > 0 then
    Result := True;
  if blnGerarSeVazio then
    Result := True;
  if FGravaDireto then
    Result := True;
End;

Function TGeraTXT.fGeraXMLPafCte(strNomArq: String): Boolean;
  Var
    objGeraXML: TGeraXMLPAF;
Begin
  objGeraXML := TGeraXMLPAF.Create(Self, strNomArq, TInterfaceRelatorio(FGeraGR3.objInterfaceGera));

  Result := objGeraXML.fGeraXMLPaf;

  FreeAndNil(objGeraXML);
End;

Function TGeraTXT.fGravaArquivoAuxiliar(strNomArq: String; blnGerarSeVazio: Boolean): Boolean;
Begin
  Result := fGravaArquivo(blnGerarSeVazio);
  If Result Then
  Begin
    If FGravaDireto Then
    Begin
      If Not FArquivoAberto.IsEmpty Then
      Begin
        Flush(FTextFile);
        Close(FTextFile);
        FArquivoAberto := '';
      End;
    End Else
    Begin
      FLinhas.SaveToFile(Concat(FPasta, strNomArq));
    End;

    If SameText(FGeraGR3.arrCadRel[0].FieldByName('REL_ASSDIG').AsString, 'S') Then
      pAssinarDigitalmente(ShortString(Concat(FPasta, strNomArq)));

    If SameText(FGeraGR3.arrCadRel[0].FieldByName('REL_XMLPAF').AsString, 'S') Then
       Result := fGeraXMLPafCte(Concat(FPasta, strNomArq));
  End;

  FLinhas.Clear;
  FLinha := '';
  FNroCam := 0;
End;

Function TGeraTXT.fGeraTXT(strPasta: String;
                           blnChildQuebra,
                           blnChildRelatorio: Boolean;
                           blnApenasPrincipal: Boolean = False;
                           blnArquivoBackup: Boolean = False;
                           blnEnviarSpool: Boolean = False): Boolean;
Begin
  Try

    FPasta := strPasta;

    FChildQuebra     := blnChildQuebra;
    FChildRelatorio  := blnChildRelatorio;
    FApenasPrincipal := blnApenasPrincipal;
    FArquivoBackup   := blnArquivoBackup;
    FEnviarSpool     := blnEnviarSpool;

    pCriarFormularios(TfrmGravando, frmGravando);

    frmGravando.lblGravando.Caption := 'Gerando arquivo TXT...';
    frmGravando.fExecutarAcao := fGeraArquivo;
    frmGravando.ShowModal;

    Result := frmGravando.blnConfirma;

    pFreeAndNil(frmGravando);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TGeraTXT.fGeraTXT');
      Result := True;
    End;
  End;
End;

function TGeraTXT.fRetornaFiltroConcat(sltFiltros: TStringList): string;
var
  strRetorno: string;
  intContFiltro: Integer;
begin
  if sltFiltros = nil then
    strRetorno := ''
  else
  begin
    sltFiltros.Sorted := True;
    sltFiltros.Duplicates := dupIgnore;
    for intContFiltro := 0 to sltFiltros.Count - 1 do
      strRetorno := strRetorno + IIF(fEmptyStr(strRetorno), '', ' OR ') + '(' + sltFiltros[intContFiltro] + ')';
  end;
  Result := strRetorno;
end;

function TGeraTXT.fTemChilds: Boolean;
var
  intContChilds: Integer;
begin
  Result := False;
  for intContChilds := Low(FGeraGR3.arrControleRel) to High(FGeraGR3.arrControleRel) do
  begin
    if FGeraGR3.arrControleRel[intContChilds].blnChild then
    begin
      Result := True;
      Break;
    end;
  end;
end;

Function TGeraTXT.fResetaArquivo(strCodRel: String): Boolean;
Begin
  Result := False;
  If Assigned(FGeraGR3.objInterfaceGera) And TInterfaceRelatorio(FGeraGR3.objInterfaceGera).cdsComplementos.Locate('REL_CODREL', strCodRel, []) Then
    Result := TInterfaceRelatorio(FGeraGR3.objInterfaceGera).cdsComplementos.FieldByName('REL_NOVPAG').AsString = 'S';
End;

Function TGeraTXT.fGeraArquivo(Progress : TcxProgressBar): Boolean;
  Var
    intContador: Integer;
    objRelatorio: TRelatorio;
    strNomArq: String;
    blnGerarSeVazio,
    blnTemChild,
    blnResult: Boolean;

Begin
  Try
    FNroRel := 0;

    FGravaDireto := FGeraGR3.arrCadRel[0].FieldByName('REL_GRADIR').AsString = 'S';

    If Not FArquivoAberto.IsEmpty Then
    Begin
      Close(FTextFile);
      FArquivoAberto := '';
    End;

    SetLength(FGeraGR3.FExprValida, 0);

    frmGravando.pgbStatus.Properties.Max := 0;

    For intContador := Low(FGeraGR3.qryDados) To IIF(FApenasPrincipal, Low(FGeraGR3.qryDados), High(FGeraGR3.qryDados)) Do
      frmGravando.pgbStatus.Properties.Max := frmGravando.pgbStatus.Properties.Max +
                                              FGeraGR3.qryDados[intContador].RecordCount;

    frmGravando.pgbStatus.Position := 0;

    FGeraGR3.pCarregaQuebras;

    blnTemChild := fTemChilds;

    Result := True;

    blnResult := False;

    strNomArq       := TInterfaceRelatorio(FGeraGR3.objInterfaceGera).stlArquivos[0];
    blnGerarSeVazio := TInterfaceRelatorio(FGeraGR3.objInterfaceGera).stlGerarSeVazio[0] = 'S';

    If FArquivoBackup Then
    Begin
      FPasta := ExtractFilePath(Application.ExeName) + '\EDITOR_RELATORIOS_BACKUP\';

      If Not DirectoryExists(FPasta) then
        If Not CreateDir(FPasta) Then
          FPasta := ExtractFilePath(Application.ExeName);

      strNomArq := FormatDateTime('dd_MM_yyyy_HH_mm_ss_', fNow) + strNomArq;
    End;

    If Not FGeraGR3.qryDados[0].IsEmpty Then
    Begin
      FGeraGR3.arrControleRel[0].sltFiltros := TStringList.Create;
      Result := fGeraLinhas(strNomArq, FGeraGR3, True, blnTemChild);
    End;

    If not FApenasPrincipal then
    For intContador := Succ(Low(FGeraGR3.arrCadRel)) To High(FGeraGR3.arrCadRel) Do
    if (not FGeraGR3.arrControleRel[intContador].blnChild) or (FGeraGR3.arrControleRel[intContador].blnChild and FChildRelatorio) then
    Begin
      FNroRel := intContador;

      objRelatorio := TRelatorio.Create(Nil, True, SameText(FGeraGR3.arrCadRel[0].FieldByName('REL_CONIND').AsString, 'S'),
                                        TInterfaceRelatorio(FGeraGR3.objInterfaceGera).conConexaoRelatorio);

      objRelatorio.pInicializaRelatorio(objRelatorio, FGeraGR3.arrCadRel[intContador], Nil, FGeraGR3.objInterfaceGera);

      objRelatorio.objGeraFr3.pCarregaQuebras;

      If fResetaArquivo(FGeraGR3.arrCadRel[intContador].FieldByName('REL_CODREL').AsString) Then
      Begin
        Result := fGravaArquivoAuxiliar(strNomArq, blnGerarSeVazio);
        strNomArq       := TInterfaceRelatorio(FGeraGR3.objInterfaceGera).stlArquivos[intContador];
        blnGerarSeVazio := TInterfaceRelatorio(FGeraGR3.objInterfaceGera).stlGerarSeVazio[intContador] = 'S';

        If FArquivoBackup Then
        Begin
          strNomArq := FormatDateTime('dd_MM_yyyy_HH_mm_ss_', fNow) + strNomArq;
        End;
      End;

      if FGeraGR3.arrControleRel[intContador].blnChild then
      begin
        FGeraGR3.qryDados[intContador].Filtered := False;
        FGeraGR3.qryDados[intContador].Filter   := fRetornaFiltroConcat(FGeraGR3.arrControleRel[intContador].sltFiltros);
        FGeraGR3.qryDados[intContador].Filtered := True;
      end;

      Result := (Result Or fResetaArquivo(FGeraGR3.arrCadRel[intContador].FieldByName('REL_CODREL').AsString)) And fGeraLinhas(strNomArq, objRelatorio.objGeraFr3, True, blnTemChild);

      If Not blnResult Then
        blnResult := Result;

      FreeAndNil(objRelatorio);

      If Not Result Then
        Break;
    End;

    SetLength(FGeraGR3.FExprValida, 0);

    If Result Then
      Result := fGravaArquivoAuxiliar(strNomArq, blnGerarSeVazio);

    // Se gerou o principal ou pelo menos um complementar, dar mensagem de arquivo Gerado
    Result := Result Or blnResult;

    If (Result) And (FEnviarSpool) and (Length(TInterfaceRelatorio(FGeraGR3.objInterfaceGera).arrArquivosPontoImpressao) > 0) Then
    Begin
      fEnviarTXTPontoImpressao(Progress);
    End;

  Except

    On E: EFCreateError Do
    Begin
      pMensagemOk('Não foi possível salvar, o arquivo já está sendo usado por outro processo.');
      Result := True;
    end;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TGeraCSV.fGeraArquivo');
      Result := True;
    End;
  End;
End;

Function TGeraTXT.fAbreArquivo(strNomeArquivo: String): Boolean;
Begin
  Try
    If SameText(strNomeArquivo, FArquivoAberto) Then
    Begin
      Result := True;
      Exit;
    End;

    AssignFile(FTextFile, strNomeArquivo);
    Rewrite(FTextFile);

    FArquivoAberto := strNomeArquivo;

   Result := True;

  Except

    On E: Exception Do
    Begin
      FArquivoAberto := '';
      pMensagensErro(E.Message, 'TGeraCSV.fAbreArquivo');
      Result := False;
    End;
  End;

End;

Function TGeraTXT.fGeraLinhas(strNomArq: String; objGeraFr3P: TGeraFR3; blnExprValida: Boolean = False; blnTemChild: Boolean = False): Boolean;
  Var
    strCamposQuebra,
    strValoresQuebra,
    strLinhaAnterior: String;
    arrCamQue: array of string;
    arrValAnt: array of string;
    blnPrimeiroRegistro: Boolean;
    stlLinhaQuebraAnterior: TStringList;
    intContador: Integer;

  procedure pProcessaChild(blnAcabou: Boolean);
  var
    sltCamposQuebra,
    sltValQuebraAtu,
    sltCamLig: TStringList;
    intQuebra,
    intChiRel,
    intContLig,
    intRecNo,
    intCampos,
    intNroRel: Integer;
    strCampos,
    strFiltro: string;

    procedure pImprimeChild(intContador: Integer; strFiltro: string);
    var
      objRelatorio: TRelatorio;
    begin
      FNroRel := intContador;

      objRelatorio := TRelatorio.Create(Nil, True, SameText(FGeraGR3.arrCadRel[0].FieldByName('REL_CONIND').AsString, 'S'),
                                        TInterfaceRelatorio(FGeraGR3.objInterfaceGera).conConexaoRelatorio);

      objRelatorio.pInicializaRelatorio(objRelatorio, FGeraGR3.arrCadRel[intContador], Nil, FGeraGR3.objInterfaceGera);

      objRelatorio.objGeraFr3.pCarregaQuebras;

      objRelatorio.objGeraFr3.strTituloRelatorio := fUpper(FGeraGR3.arrCadRel[intContador].FieldByName('REL_DESCRI').AsString);
      objRelatorio.objGeraFr3.strSubTituloRelatorio := fUpper(FGeraGR3.arrCadRel[intContador].FieldByName('REL_SUBTIT').AsString);

      FGeraGR3.qryDados[intContador].Filtered := False;
      FGeraGR3.qryDados[intContador].Filter   := strFiltro;
      FGeraGR3.qryDados[intContador].Filtered := True;

      fGeraLinhas(strNomArq, objRelatorio.objGeraFr3, True, True);

      FreeAndNil(objRelatorio);
    end;

    procedure pAdicionaFiltro(intContador: Integer; strFiltro: string);
    begin
      if FGeraGR3.arrControleRel[intContador].sltFiltros = nil then
        FGeraGR3.arrControleRel[intContador].sltFiltros := TStringList.Create;

      FGeraGR3.arrControleRel[intContador].sltFiltros.Add(strFiltro);
    end;

  begin
    if not fEmptyStr(strCamposQuebra) then
    begin
      if blnPrimeiroRegistro then
      begin
        try
          sltCamposQuebra := Split(strCamposQuebra, ';');
          sltValQuebraAtu := Split(strValoresQuebra, ';');
          for intQuebra := 0 to sltCamposQuebra.Count - 1 do
          begin
            SetLength(arrCamQue, Succ(Length(arrCamQue)));
            arrCamQue[High(arrCamQue)] := sltCamposQuebra[intQuebra];
            SetLength(arrValAnt, Succ(Length(arrValAnt)));
            arrValAnt[High(arrValAnt)] := sltValQuebraAtu[intQuebra];
          end;
          blnPrimeiroRegistro := False;
        finally
          FreeAndNil(sltCamposQuebra);
          FreeAndNil(sltValQuebraAtu);
        end;
      end
      else
      begin
        try
          sltValQuebraAtu := Split(strValoresQuebra, ';');
          for intQuebra := Length(arrCamQue) - 1 downto 0 do
          begin
            if (sltValQuebraAtu[intQuebra] <> arrValAnt[intQuebra]) or blnAcabou then
            begin
              for intChiRel := Succ(FNroRel) to High(FGeraGR3.arrControleRel) do
              begin
                if (FGeraGR3.arrControleRel[intChiRel].blnChild) and
                   (FGeraGR3.arrControleRel[intChiRel].strNomCam = arrCamQue[intQuebra]) and
                   (FGeraGR3.arrControleRel[intChiRel].strMaster = FGeraGR3.arrCadRel[FNroRel].FieldByName('AUTOINCREM').AsString) then
                begin
                  try
                    strFiltro := '';
                    sltCamLig := Split(FGeraGR3.arrControleRel[intChiRel].strCamLig, ',');
                    intRecNo := FGeraGR3.qryDados[FNroRel].RecNo;

                    if not blnAcabou then
                      FGeraGR3.qryDados[FNroRel].Prior;

                    for intContLig := 0 to sltCamLig.Count - 1 do
                    begin
                      If Not Assigned(FGeraGR3.qryDados[intChiRel].FindField(sltCamLig[intContLig])) Then
                      Begin
                        strCampos := '';
                        for intCampos := 0 to FGeraGR3.qryDados[intChiRel].Fields.Count - 1 do
                          strCampos := strCampos + ' ' + FGeraGR3.qryDados[intChiRel].Fields[intCampos].FieldName;

                        Raise Exception.Create(Concat('Campo ', sltCamLig[intContLig], ' não encontrado no Child com campos: ', strCampos));
                      End;

                      if FGeraGR3.qryDados[FNroRel].FieldByName(sltCamLig[intContLig]).DataType in [ftLargeint, ftInteger, ftWord, ftFloat] then
                        strFiltro := strFiltro + IIF(fEmptyStr(strFiltro), '', ' AND ') + sltCamLig[intContLig] + ' = ' + AnsiReplaceStr(FGeraGR3.qryDados[FNroRel].FieldByName(sltCamLig[intContLig]).AsString, ',', '.')
                      else
                        strFiltro := strFiltro + IIF(fEmptyStr(strFiltro), '', ' AND ') + sltCamLig[intContLig] + ' = ' + QuotedStr(FGeraGR3.qryDados[FNroRel].FieldByName(sltCamLig[intContLig]).AsString);
                    end;

                    if FChildQuebra then
                    begin
                      FGeraGR3.qryDados[intChiRel].Filtered := False;
                      FGeraGR3.qryDados[intChiRel].Filter   := strFiltro;
                      FGeraGR3.qryDados[intChiRel].Filtered := True;
                    end;

                    intNroRel := FNroRel;
                    if not FGeraGR3.qryDados[intChiRel].IsEmpty then
                    begin
                      pAdicionaFiltro(intChiRel, strFiltro);
                      if FChildQuebra then
                        pImprimeChild(intChiRel, strFiltro);
                    end;
                    FNroRel := intNroRel;
                    FGeraGR3.qryDados[FNroRel].RecNo := intRecNo;
                  finally
                    FreeAndNil(sltCamLig);
                  end;
                end;
              end;
            end;
            If intQuebra <= High(arrValAnt) Then
              arrValAnt[intQuebra] := sltValQuebraAtu[intQuebra];
          end;
        finally
          FreeAndNil(sltValQuebraAtu);
        end;
      end;
    end;
  end;

Begin
  If FGravaDireto Then
  Begin
    Result := fAbreArquivo(Concat(FPasta, strNomArq));

    If Not Result Then
      Exit;
  End;

  blnPrimeiroRegistro := True;
  SetLength(arrValAnt, 0);
  SetLength(arrCamQue, 0);

  stlLinhaQuebraAnterior :=  TStringList.Create;

  FGeraGR3.qryDados[FNroRel].First;
  While Not FGeraGR3.qryDados[FNroRel].Eof Do
  Begin
    FLinha := '';
    FNroCam := 0;

    strCamposQuebra := '';
    strValoresQuebra := '';

    pGeraQuebras(objGeraFr3P, blnExprValida, strCamposQuebra, strValoresQuebra, stlLinhaQuebraAnterior);
    pGeraCampos(objGeraFr3P, blnExprValida);

    strLinhaAnterior := FLinha;

    If blnTemChild then
      pProcessaChild(False);

    For intContador := 0 To stlLinhaQuebraAnterior.Count - 1 Do
      If FGravaDireto Then
        Writeln(FTextFile, stlLinhaQuebraAnterior[intContador])
      Else
        FLinhas.Add(stlLinhaQuebraAnterior[intContador]);

    If FGravaDireto Then
      Writeln(FTextFile, strLinhaAnterior)
    Else
      FLinhas.Add(strLinhaAnterior);

    FGeraGR3.qryDados[FNroRel].Next;

    frmGravando.pgbStatus.Position := frmGravando.pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;

  if blnTemChild then
    pProcessaChild(True);

  FreeAndNil(stlLinhaQuebraAnterior);
  Result := True;
End;

Function TGeraTXT.fNumeroDecimais(objGeraFr3P: TGeraFR3): Integer;
Begin
  If objGeraFr3P.cdsCamposG.FieldByName('CAM_NRODEC').IsNull Then
    Result := 2
  Else
    Case TInterfaceRelatorio.fDescMascaraToTipo(objGeraFr3P.cdsCamposG.FieldByName('CAM_MASCAR').AsString) Of
      masDecUni: Result := intDecUni;
      masDecQtd: Result := intDECQTD;
      masEstDec: Result := intEstDec;
      masDeqTpc: Result := intDeqTpc;
      Else       Result := objGeraFr3P.cdsCamposG.FieldByName('CAM_NRODEC').AsInteger;
    End;
End;

Procedure TGeraTXT.pGeraLinhaQuebra(objGeraFr3P: TGeraFR3; strNomeQuebra: String; blnExprValida: Boolean;
                                     Var stlLinhaQuebraAnterior: TStringList);
  Var
    intLinhaQuebra: Integer;
Begin
  FLinha := '';
  FNroCam := 0;

  intLinhaQuebra := 1;

  objGeraFr3P.cdsCamposG.IndexFieldNames := 'CAM_LINQUE;CAM_POSICA';

  objGeraFr3P.cdsCamposG.First;

  While Not objGeraFr3P.cdsCamposG.Eof Do
  Begin

    If SameText(objGeraFr3P.cdsCamposG.FieldByName('CAM_LISQUE').AsString, strNomeQuebra) Then
    If objGeraFr3P.fValidaVisibilidade(objGeraFr3P.cdsCamposG) Then
    Begin
      If (intLinhaQuebra <> StrToIntDef(objGeraFr3P.cdsCamposG.FieldByName('CAM_LINQUE').AsString, -1)) Then
      Begin
        intLinhaQuebra := StrToIntDef(objGeraFr3P.cdsCamposG.FieldByName('CAM_LINQUE').AsString, -1);
        stlLinhaQuebraAnterior.Add(FLinha);
        FLinha := '';
        FNroCam := 0;
      End;

      If fEstaQuebrando(objGeraFr3P, objGeraFr3P.cdsCamposG.FieldByName('CAM_LISQUE').AsString) And
       (objGeraFr3P.cdsCamposG.FieldByName('CAM_LINQUE').AsString <> '') And
       (fEmptyStr(objGeraFr3P.cdsCamposG.FieldByName('CAM_QUAQUE').AsString) Or
          objGeraFr3P.fRetornaExpressaBoolean(objGeraFr3P.cdsCamposG.FieldByName('CAM_QUAQUE').AsString, blnExprValida)) Then
          pAdicionaCampoNaLinha(FGeraGR3.qryDados[FNroRel].FieldByName(objGeraFr3P.cdsCamposG.FieldByName('CAM_NOMCAM').AsString), fNumeroDecimais(objGeraFr3P),
                              Trunc(objGeraFr3P.cdsCamposG.FieldByName('CAM_LARGUR').AsFloat));

    End;

    objGeraFr3P.cdsCamposG.Next;
  End;

  If Not FLinha.IsEmpty Then
    stlLinhaQuebraAnterior.Add(FLinha);

  FLinha := '';
  FNroCam := 0;
End;

Procedure TGeraTXT.pGeraQuebras(objGeraFr3P: TGeraFR3; blnExprValida: Boolean; var strCamposQuebra: string;
                                var strValoresQuebra: string;
                                Var stlLinhaQuebraAnterior: TStringList);
  Var
    strValorQuebra: String;
Begin
  stlLinhaQuebraAnterior.Clear;

  objGeraFr3P.cdsQuebras.First;
  While Not objGeraFr3P.cdsQuebras.Eof Do
  Begin
    strValorQuebra := FGeraGR3.qryDados[FNroRel].FieldByName(objGeraFr3P.cdsQuebras.FieldByName('CAM_NOMCAM').AsString).AsString;

    If Not SameText(strValorQuebra, objGeraFr3P.cdsQuebras.FieldByName('VALQUE').AsString) Then
    Begin
      objGeraFr3P.cdsQuebras.Edit;
      objGeraFr3P.cdsQuebras.FieldByName('VALQUE').AsString := strValorQuebra;
      objGeraFr3P.cdsQuebras.Post;

      pGeraLinhaQuebra(objGeraFr3P, objGeraFr3P.cdsQuebras.FieldByName('CAM_NOMCAM').AsString, blnExprValida,
                       stlLinhaQuebraAnterior);

      strCamposQuebra  := strCamposQuebra + IIF(fEmptyStr(strCamposQuebra), '', ';') + objGeraFr3P.cdsQuebras.FieldByName('CAM_NOMCAM').AsString;
      strValoresQuebra := strValoresQuebra + IIF(fEmptyStr(strValoresQuebra), '', ';') + strValorQuebra;

    End;

    objGeraFr3P.cdsQuebras.Next;
  End;

End;

Function TGeraTXT.fEstaQuebrando(objGeraFr3P: TGeraFR3; strCampo: String): Boolean;
Begin
  Result := objGeraFr3P.cdsQuebras.Locate('CAM_NOMCAM', strCampo, []);
End;

Procedure TGeraTXT.pGeraCampos(objGeraFr3P: TGeraFR3; blnExprValida: Boolean = False);
Begin
  objGeraFr3P.cdsCamposG.IndexFieldNames := 'CAM_POSICA';

  objGeraFr3P.cdsCamposG.First;

  While Not objGeraFr3P.cdsCamposG.Eof Do
  Begin
    If objGeraFr3P.fValidaVisibilidade(objGeraFr3P.cdsCamposG, blnExprValida) And
       (objGeraFr3P.cdsCamposG.FieldByName('CAM_LISTAR').AsString <> '') Then
      pAdicionaCampoNaLinha(FGeraGR3.qryDados[FNroRel].FieldByName(objGeraFr3P.cdsCamposG.FieldByName('CAM_NOMCAM').AsString), fNumeroDecimais(objGeraFr3P),
                     Trunc(objGeraFr3P.cdsCamposG.FieldByName('CAM_LARGUR').AsFloat));

    objGeraFr3P.cdsCamposG.Next;
  End;
End;

Procedure TGeraTXT.pAdicionaCampoNaLinha(filCampo: TField; intNroDec, intTamanho: Integer);
Begin
  Inc(FNroCam);
  if SameText(FGeraGR3.arrCadRel[0].FieldByName('REL_PRELIM').AsString, 'S') then
    FLinha := FLinha + fCampoToString(filCampo, intNroDec, intTamanho)
  else
    FLinha := FLinha + fCampoToStringSemLimite(filCampo, intNroDec);
End;

Function TGeraTXT.fCampoToString(filCampo: TField; intNroDec, intTamanho: Integer): String;
Begin

  Case filCampo.DataType Of
    ftTime     : result := LeftStr(IfThen(filCampo.IsNull, '', FormatDateTime('HH:NN:SS', filCampo.AsDateTime)), intTamanho).PadRight(intTamanho);
    ftDateTime : result := LeftStr(IfThen(filCampo.IsNull, '', FormatDateTime('DD/MM/YYYY HH:NN:SS', filCampo.AsDateTime)), intTamanho).PadRight(intTamanho);
    ftDate     : result := LeftStr(IfThen(filCampo.IsNull, '', FormatDateTime('DD/MM/YYYY', filCampo.AsDateTime)), intTamanho).PadRight(intTamanho);
    ftFloat    : result := LeftStr(FormatFloat(fMskDigitos(intNroDec), filCampo.AsFloat), intTamanho).PadLeft(intTamanho);
    ftWord,
    ftInteger  : result := LeftStr(filCampo.AsString, intTamanho).PadLeft(intTamanho);
    Else         result := LeftStr(filCampo.AsString, intTamanho).PadRight(intTamanho);
  End;

End;

Function TGeraTXT.fCampoToStringSemLimite(filCampo: TField; intNroDec: Integer): String;
Begin

  Case filCampo.DataType Of
    ftTime     : result := IfThen(filCampo.IsNull, '', FormatDateTime('HH:NN:SS', filCampo.AsDateTime));
    ftDateTime : result := IfThen(filCampo.IsNull, '', FormatDateTime('DD/MM/YYYY HH:NN:SS', filCampo.AsDateTime));
    ftDate     : result := IfThen(filCampo.IsNull, '', FormatDateTime('DD/MM/YYYY', filCampo.AsDateTime));
    ftFloat    : result := FormatFloat(fMskDigitos(intNroDec), filCampo.AsFloat);
    ftWord,
    ftInteger  : result := filCampo.AsString;
    Else         result := filCampo.AsString;
  End;

End;

procedure TGeraTXT.pAssinarDigitalmente(strNomeArquivo: AnsiString);
  Var
    strEad: AnsiString;
begin
  If fCfgSis('CASGBM', varBoolean) Then
  Begin
    pCarregarSignBema;
  End
  Else
  Begin
    If Not Assigned(generateEAD) Then
      pCarregarSignBema;
  End;

  SetLength(strEad, 256);
  generateEAD(strNomeArquivo, CHAVE_PUBLICA, CHAVE_PRIVADA, strEad, 1);
end;

procedure TGeraTXT.pCarregarSignBema;
  Var
    strDllSignBema: String;
    intNumTent: Integer;
  Const
    MAX_TENTATIVAS = 5;
begin

  If Assigned(generateEAD) Then
  Begin
    FreeLibrary(HandleSignBema);
    HandleSignBema := 0;
  End;

  strDllSignBema := ExtractFilePath(Application.ExeName) + 'sign_bema.dll';
  intNumTent := 0;

  If FileExists( strDllSignBema ) Then
  Begin
    While (intNumTent < MAX_TENTATIVAS) And (HandleSignBema <= 0) Do
    Begin
      HandleSignBema := LoadLibrary(PChar(strDllSignBema));
      Sleep(200);
      Inc(intNumTent);
    End;

    If HandleSignBema = 0 Then
      fMensagem('ATENÇÃO!', 'Não foi possível carregar a dll sign_bema.dll.' + #13#10 + 'Verifique se o .Net Framework está atualizado.', ['&Ok']);

    generateEAD := GetProcAddress(HandleSignBema, pChar('generateEAD'));
  End
  Else
  Begin
    HandleSignBema := 0;
    fMensagem('ATENÇÃO!', 'Não foi possível encontrar a dll sign_bema.dll.', ['&Ok']);
  End;
end;

function TGeraTXT.fEnviarTXTPontoImpressao(Progress : TcxProgressBar):Boolean;
var
  strControle,
  strAtual: String;
  lstArquivos: TStringList;
  lstPontos: TStringList;
  I: Integer;
begin
  try
    strControle := '_';
    lstArquivos := TStringList.Create;
    lstPontos := TStringList.Create;

    For I := 0 to Length(TInterfaceRelatorio(FGeraGR3.objInterfaceGera).arrArquivosPontoImpressao) - 1 do
    Begin
      strAtual := TInterfaceRelatorio(FGeraGR3.objInterfaceGera).arrArquivosPontoImpressao[I].strArquivo +
                  TInterfaceRelatorio(FGeraGR3.objInterfaceGera).arrArquivosPontoImpressao[I].strPontoImpressao;

      If (Pos(strAtual, strControle) = 0) Then
      Begin
        strControle := strControle + strAtual + '_';
        lstArquivos.Add(TInterfaceRelatorio(FGeraGR3.objInterfaceGera).arrArquivosPontoImpressao[I].strArquivo);
        lstPontos.Add(TInterfaceRelatorio(FGeraGR3.objInterfaceGera).arrArquivosPontoImpressao[I].strPontoImpressao);
      End;
    End;

    if (lstArquivos.Count = 0) Then
      Exit(False);

    if Assigned(Progress) then
    begin
      Progress.Properties.Max := lstArquivos.Count;
      Progress.Position       := 0;
    end;
    Application.ProcessMessages;

    for I := 0 to lstArquivos.Count - 1 do
    begin
      TSpoolImpressaoCitel.fEnviarTextoParaImpressao(FGeraGR3.arrCadRel[0].FieldByName('REL_DESCRI').AsString,
                                                     ExtractFileName(lstArquivos[I]),
                                                     lstPontos[I],
                                                     TFile.ReadAllText(lstArquivos[I], TEncoding.ANSI));

      if Assigned(Progress) then
        Progress.Position := Progress.Position + 1;

      Application.ProcessMessages;
    end;

    Result := True;

  finally
    FreeAndNil(lstArquivos);
    FreeAndNil(lstPontos);
  end;
end;

end.
