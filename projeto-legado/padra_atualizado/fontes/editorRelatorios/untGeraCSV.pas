unit untGeraCSV;

interface

uses
  Classes, SysUtils, Variants, untTypesSistema,
  Controls, StdCtrls, StrUtils, Printers,
  frxClass, frxDBSet, frxDesgn, frxDMPExport,
  Uni, DB, untFuncoesSimples, untRelFrx, frxDMPClass,
  cxProgressBar, Forms,
  untFuncEditorRel, untZClient, Math, untGeraFR3;

type
  TGeraCSV = class(TComponent)
    private
      FLinhas: TStringList;

      FArquivoAberto: String;
      FTextFile: TextFile;

      FNroRel,
      FNroCam: Integer;

      FNomArq,
      FPasta,
      FLinha: String;

      FNomeArquivo: Boolean;

      FGeraGR3: TGeraFR3;

      FGeraTitulos,
      FGeraNomeColunas,
      FComAspas,
      FDelAspas,
      FChildQuebra,
      FChildRelatorio,
      FApenasPrincipal: Boolean;

      intDecUni,
      intDECQTD,
      intEstDec,
      intDeqTpc: Integer;

      Function fAbreArquivo(strNomeArquivo: String; blnLimpaArquivo: Boolean = True): Boolean;

      Function fGeraTitulo(objGeraFr3P: TGeraFR3; blnInicial: Boolean): Boolean;
      Function fGeraCabec(objGeraFr3P: TGeraFR3; blnExprValida: Boolean = False): Boolean;
      Function fGeraLinhas(objGeraFr3P: TGeraFR3; blnExprValida: Boolean = False; blnTemChild: Boolean = False): Boolean;
      Function fGeraArquivo(Progress : TcxProgressBar): Boolean;

      Function fEstaQuebrando(objGeraFr3P: TGeraFR3; strCampo: String; blnExprValida: Boolean): Boolean;

      Procedure pCampoToString(filCampo: TField; intNroDec: Integer);
      Function fCampoToString(filCampo: TField; intNroDec: Integer): String;

      Procedure pGeraQuebras(objGeraFr3P: TGeraFR3; blnExprValida: Boolean; var strCamposQuebra: string; var strValoresQuebra: string);
      Procedure pGeraCampos(objGeraFr3P: TGeraFR3; blnExprValida: Boolean = False);

    public

      constructor Create(AOwner: TComponent);  Reintroduce;
      destructor Destroy; override;

       Function fGeraCSV(blnNomeArquivo: Boolean; strNomArq: String; strPasta: String; blnComTitulo, blnComNomeColuna, blnComAspas, blnChildQuebra, blnChildRelatorio, blnDelAspas: Boolean; blnApenasPrincipal: Boolean = False): Boolean;

    published

       Property objGeraGR3: TGeraFR3 Read FGeraGR3 Write FGeraGR3;

  end;

implementation

Uses
  untGravando, untRelatorio, untInterfaceRelatorio;

constructor TGeraCSV.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FArquivoAberto := '';

  FLinhas := TStringList.Create;

  FNroRel := 0;

  FApenasPrincipal := False;

  intDecUni := fCfgSis('DECUNI', varInteger);
  intDECQTD := fCfgSis('DECQTD', varInteger);
  intEstDec := fCfgSis('ESTDEC', varInteger);
  intDeqTpc := fCfgSis('DEQTPC', varInteger);
end;

destructor TGeraCSV.Destroy;
begin
  inherited;

  FLinhas.Clear;
  FreeAndNil(FLinhas);
end;

Function TGeraCSV.fGeraCSV(blnNomeArquivo: Boolean; strNomArq: String; strPasta: String; blnComTitulo, blnComNomeColuna, blnComAspas, blnChildQuebra, blnChildRelatorio, blnDelAspas: Boolean; blnApenasPrincipal: Boolean = False): Boolean;
Begin
  Try
    FGeraTitulos     := blnComTitulo;
    FGeraNomeColunas := blnComNomeColuna;
    FComAspas        := blnComAspas;
    FDelAspas        := blnDelAspas;
    FChildQuebra     := blnChildQuebra;
    FChildRelatorio  := blnChildRelatorio;
    FApenasPrincipal := blnApenasPrincipal;

    FPasta := strPasta;
    FNomArq := strNomArq;

    FNomeArquivo := blnNomeArquivo;

    pCriarFormularios(TfrmGravando, frmGravando);

    frmGravando.lblGravando.Caption := 'Gerando arquivo CSV...';
    frmGravando.fExecutarAcao := fGeraArquivo;
    frmGravando.ShowModal;

    Result := frmGravando.blnConfirma;

    pFreeAndNil(frmGravando);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TGeraCSV.fGeraCSV');
      Result := True;
    End;
  End;
End;

Function TGeraCSV.fGeraArquivo(Progress : TcxProgressBar): Boolean;
  Var
  intContador: Integer;
  intContLinhas: Integer;
  objRelatorio: TRelatorio;
  blnTemChild: Boolean;
  blnLimpaArquivo: Boolean;
  strNomArq: String;

  function fRetornaFiltroConcat(sltFiltros: TStringList): string;
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

  function fTemChilds: Boolean;
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

Begin
  Try
    FNroRel := 0;

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

    Result := fGeraTitulo(FGeraGR3, True);

    blnTemChild := fTemChilds;

    If (Not FGeraGR3.qryDados[0].IsEmpty) And
       ((Not TInterfaceRelatorio(FGeraGR3.objInterfaceGera).blnImpressaoGrid) Or
       (TInterfaceRelatorio(FGeraGR3.objInterfaceGera).intIndexGrid = 0))Then
    Begin
      FGeraGR3.arrControleRel[0].sltFiltros := TStringList.Create;
      Result := Result And fGeraCabec(FGeraGR3, True)  And
                           fGeraLinhas(FGeraGR3, True, ((not FApenasPrincipal) and blnTemChild));

      If FNomeArquivo Then
      Begin
        strNomArq := TInterfaceRelatorio(FGeraGR3.objInterfaceGera).stlArquivos[0];
        Result := fAbreArquivo(Concat(FPasta, strNomArq));
        If Not Result Then
          Exit;
        For intContLinhas := 0 to FLinhas.Count - 1 Do
          Writeln(FTextFile, FLinhas[intContLinhas]);
        If Not FArquivoAberto.IsEmpty Then
        Begin
          Close(FTextFile);
          FArquivoAberto := '';
        End;
      End;

    End;

    If ((not FApenasPrincipal) and Result) Then
    Begin

      For intContador := Succ(Low(FGeraGR3.arrCadRel)) To High(FGeraGR3.arrCadRel) Do
      If (Not FGeraGR3.qryDados[intContador].IsEmpty) And
         ((Not TInterfaceRelatorio(FGeraGR3.objInterfaceGera).blnImpressaoGrid) Or
          (TInterfaceRelatorio(FGeraGR3.objInterfaceGera).intIndexGrid = intContador)) Then
      Begin
        if (not FGeraGR3.arrControleRel[intContador].blnChild) or (FGeraGR3.arrControleRel[intContador].blnChild and FChildRelatorio) then
        begin
          FNroRel := intContador;

          objRelatorio := TRelatorio.Create(Nil, True, SameText(FGeraGR3.arrCadRel[0].FieldByName('REL_CONIND').AsString, 'S'),
                                            TInterfaceRelatorio(FGeraGR3.objInterfaceGera).conConexaoRelatorio);

          objRelatorio.pInicializaRelatorio(objRelatorio, FGeraGR3.arrCadRel[intContador], Nil, FGeraGR3.objInterfaceGera);

          FGeraTitulos     := FGeraGR3.arrCadRel[intContador].FieldByName('REL_CSVTIT').AsString = 'S';
          FGeraNomeColunas := FGeraGR3.arrCadRel[intContador].FieldByName('REL_CSVCOL').AsString = 'S';
          FComAspas        := FGeraGR3.arrCadRel[intContador].FieldByName('REL_CSVASP').AsString = 'S';
          FDelAspas        := FGeraGR3.arrCadRel[intContador].FieldByName('REL_CSVDAS').AsString = 'S';

          objRelatorio.objGeraFr3.pCarregaQuebras;

          objRelatorio.objGeraFr3.strTituloRelatorio := fUpper(FGeraGR3.arrCadRel[intContador].FieldByName('REL_DESCRI').AsString);
          objRelatorio.objGeraFr3.strSubTituloRelatorio := fUpper(FGeraGR3.arrCadRel[intContador].FieldByName('REL_SUBTIT').AsString);

          FLinhas.Add('');
          FLinhas.Add('');

          if FGeraGR3.arrControleRel[intContador].blnChild then
          begin
            FGeraGR3.qryDados[intContador].Filtered := False;
            FGeraGR3.qryDados[intContador].Filter   := fRetornaFiltroConcat(FGeraGR3.arrControleRel[intContador].sltFiltros);
            FGeraGR3.qryDados[intContador].Filtered := True;
          end;

          If FNomeArquivo Then
            FLinhas.Clear;

          Result := Result And fGeraTitulo(objRelatorio.objGeraFr3, False) And
                               fGeraCabec(objRelatorio.objGeraFr3, True) And
                               fGeraLinhas(objRelatorio.objGeraFr3, True, blnTemChild);

          If FNomeArquivo Then
          Begin
            If fEmptyStr(TInterfaceRelatorio(FGeraGR3.objInterfaceGera).stlArquivos[intContador]) Then
              Result := fAbreArquivo(Concat(FPasta, strNomArq), False)
            Else
            Begin
              blnLimpaArquivo := Not (strNomArq = TInterfaceRelatorio(FGeraGR3.objInterfaceGera).stlArquivos[intContador]);
              strNomArq := TInterfaceRelatorio(FGeraGR3.objInterfaceGera).stlArquivos[intContador];
              Result := fAbreArquivo(Concat(FPasta, strNomArq), blnLimpaArquivo);
            End;
            If Not Result Then
              Exit;
            For intContLinhas := 0 to FLinhas.Count - 1 Do
              Writeln(FTextFile, FLinhas[intContLinhas]);
            If Not FArquivoAberto.IsEmpty Then
            Begin
              Close(FTextFile);
              FArquivoAberto := '';
            End;
          End;

          FreeAndNil(objRelatorio);

          If Not Result Then
            Break;
        end;
      End;

    End;

    SetLength(FGeraGR3.FExprValida, 0);

    If Result Then
      If Not FNomeArquivo Then
        FLinhas.SaveToFile(FNomArq);

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

Function TGeraCSV.fGeraTitulo(objGeraFr3P: TGeraFR3; blnInicial: Boolean): Boolean;
  Var
    intContador: Integer;
Begin
  With objGeraFr3P Do
  If FGeraTitulos Then
  Begin
    If blnInicial Then
    Begin
      FLinhas.Add(fRetNomeEmpresa);
      FLinhas.Add('');
    End;

    FLinhas.Add(strTituloRelatorio + IfThen(blnInicial, ' ' + FormatDateTime('DD/MM/YYYY HH:NN', VS_Date + fTime()), ''));
    If Not fEmptyStr(strSubTituloRelatorio) Then
      FLinhas.Add(strSubTituloRelatorio + IfThen(blnInicial, ' ' + FormatDateTime('DD/MM/YYYY HH:NN', VS_Date + fTime()), ''));
    FLinhas.Add('');

    if blnInicial then
      if fValidaExpImp(cdsParams) then
        TInterfaceRelatorio(objInterfaceGera).fGeraTitulosFiltros(True);

    If blnInicial And Assigned(stlTituloFiltros) Then
    Begin
      For intContador := 0 To stlTituloFiltros.Count - 1 Do
        FLinhas.Add(stlTituloFiltros[intContador]);

      FLinhas.Add('');
    End;

  End;

  Result := True;
End;

Function TGeraCSV.fEstaQuebrando(objGeraFr3P: TGeraFR3; strCampo: String; blnExprValida: Boolean): Boolean;
Begin
  With objGeraFr3P, cdsQuebras Do
  Begin
    Result := Locate('CAM_NOMCAM', strCampo, []);
    If Result then
      Result := (fEmptyStr(FieldByName('CAM_QUAQUE').AsString) Or fRetornaExpressaBoolean(FieldByName('CAM_QUAQUE').AsString, blnExprValida));
  End;
  End;

Function TGeraCSV.fGeraCabec(objGeraFr3P: TGeraFR3; blnExprValida: Boolean = False): Boolean;
Begin
  If FGeraNomeColunas Then
  Begin
    FLinha := '';
    FNroCam := 0;

    With objGeraFr3P, cdsCamposG Do
    Begin
      IndexFieldNames := 'CAM_LINQUE;CAM_POSICA';

      First;

      While Not Eof Do
      Begin

        If fEstaQuebrando(objGeraFr3P, FieldByName('CAM_LISQUE').AsString, blnExprValida) And
           (FieldByName('CAM_LINQUE').AsString <> '') And
           (fEmptyStr(FieldByName('CAM_EXPVIS').AsString) Or
            fRetornaExpressaBoolean(FieldByName('CAM_EXPVIS').AsString, blnExprValida)) Then
        Begin
          Inc(FNroCam);

          If FNroCam > 1 Then
            FLinha := FLinha + ';';

          FLinha := FLinha + fDescricaoCampo(FieldByName('CAM_DESCAM').AsString);

        End;

        Next;
      End;
    End;

    With objGeraFr3P, cdsCamposG Do
    Begin
      IndexFieldNames := 'CAM_POSICA';

      First;

      While Not Eof Do
      Begin

        If fValidaVisibilidade(cdsCamposG, blnExprValida) And
          (FieldByName('CAM_LISTAR').AsString <> '') Then
        Begin
          Inc(FNroCam);

          If FNroCam > 1 Then
            FLinha := FLinha + ';';

          FLinha := FLinha + fDescricaoCampo(FieldByName('CAM_DESCAM').AsString);
        End;

        Next;
      End;
    End;

    FLinhas.Add(FLinha);
  End;

  Result := True;
End;

Function TGeraCSV.fAbreArquivo(strNomeArquivo: String; blnLimpaArquivo: Boolean = True): Boolean;
Begin
  Try
    If SameText(strNomeArquivo, FArquivoAberto) Then
    Begin
      Result := True;
      Exit;
    End;

    AssignFile(FTextFile, strNomeArquivo);
    If blnLimpaArquivo Then
      Rewrite(FTextFile)
    Else
      Append(FTextFile);

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

Function TGeraCSV.fGeraLinhas(objGeraFr3P: TGeraFR3; blnExprValida: Boolean = False; blnTemChild: Boolean = False): Boolean;
Var
  strCamposQuebra,
  strValQuebraAtu,
  strLinhaAnterior: String;
  arrCamQue: array of string;
  arrValAnt: array of string;
  blnPrimeiroRegistro: Boolean;

  procedure pProcessaChild(blnAcabou: Boolean);
  var
    sltCamposQuebra,
    sltValQuebraAtu,
    sltCamLig: TStringList;
    intQuebra,
    intChiRel,
    intContLig,
    intRecNo,
    intNroRel: Integer;
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

      FLinhas.Add('');

      FGeraGR3.qryDados[intContador].Filtered := False;
      FGeraGR3.qryDados[intContador].Filter   := strFiltro;
      FGeraGR3.qryDados[intContador].Filtered := True;

      fGeraCabec(objRelatorio.objGeraFr3, True);
      fGeraLinhas(objRelatorio.objGeraFr3, True, blnTemChild);

      FLinhas.Add('');

      FreeAndNil(objRelatorio);
    end;

    procedure pAdicionaFiltro(intContador: Integer; strFiltro: string);
    begin
      if FGeraGR3.arrControleRel[intContador].sltFiltros = nil then
        FGeraGR3.arrControleRel[intContador].sltFiltros := TStringList.Create;

      FGeraGR3.arrControleRel[intContador].sltFiltros.Add(strFiltro);
    end;

  begin
    if True { FChildQuebra } then
    begin
      if not fEmptyStr(strCamposQuebra) then
      begin
        if blnPrimeiroRegistro then
        begin
          try
            sltCamposQuebra := Split(strCamposQuebra, ';');
            sltValQuebraAtu := Split(strValQuebraAtu, ';');
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
            sltValQuebraAtu := Split(strValQuebraAtu, ';');
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
              arrValAnt[intQuebra] := sltValQuebraAtu[intQuebra];
            end;
          finally
            FreeAndNil(sltValQuebraAtu);
          end;
        end;
      end;
    end;
  end;

Begin
  Result := True;

  blnPrimeiroRegistro := True;
  SetLength(arrValAnt, 0);
  SetLength(arrCamQue, 0);

  With FGeraGR3.qryDados[FNroRel] Do
  Begin
    First;
    While Not Eof Do
    Begin

      FLinha := '';
      FNroCam := 0;

      strCamposQuebra := '';
      strValQuebraAtu := '';
      pGeraQuebras(objGeraFr3P, blnExprValida, strCamposQuebra, strValQuebraAtu);
      pGeraCampos(objGeraFr3P, blnExprValida);

      strLinhaAnterior := FLinha;

      if blnTemChild then
        pProcessaChild(False);

      FLinhas.Add(strLinhaAnterior);

      Next;

      frmGravando.pgbStatus.Position := frmGravando.pgbStatus.Position + 1;
      Application.ProcessMessages;
    End;

    if blnTemChild then
      pProcessaChild(True);
  End;

End;

Procedure TGeraCSV.pGeraQuebras(objGeraFr3P: TGeraFR3; blnExprValida: Boolean; var strCamposQuebra: string; var strValoresQuebra: string);
Var
  intNroDec: Integer;

  function fQuebraJaFoi(strQuebraAtual, strCamposQueJaForam: string): Boolean;
  var
    blnRetorno: Boolean;
    sltQuebras: TStringList;
    intContQuebras: Integer;
  begin
    blnRetorno := False;
    if not fEmptyStr(strQuebraAtual) then
    begin
      try
        sltQuebras := Split(strCamposQueJaForam, ';');
        for intContQuebras := 0 to sltQuebras.Count - 1 do
        begin
          if sltQuebras[intContQuebras] = strQuebraAtual then
          begin
            blnRetorno := True;
            Break;
          end;
        end;
      finally
        FreeAndNil(sltQuebras);
      end;
    end;
    Result := blnRetorno;
  end;

Begin

  With objGeraFr3P, cdsCamposG Do
  Begin
    IndexFieldNames := 'CAM_LINQUE;CAM_POSICA';

    First;

    While Not Eof Do
    Begin
      If FieldByName('CAM_NRODEC').IsNull Then
        intNroDec := 2
      Else
        Case TInterfaceRelatorio.fDescMascaraToTipo(FieldByName('CAM_MASCAR').AsString) Of
          masDecUni: intNroDec := intDecUni;
          masDecQtd: intNroDec := intDECQTD;
          masEstDec: intNroDec := intEstDec;
          masDeqTpc: intNroDec := intDeqTpc;
          Else       intNroDec := FieldByName('CAM_NRODEC').AsInteger;
        End;

      If fEstaQuebrando(objGeraFr3P, FieldByName('CAM_LISQUE').AsString, blnExprValida) And
         (FieldByName('CAM_LINQUE').AsString <> '') And
         (fEmptyStr(FieldByName('CAM_EXPVIS').AsString) Or
          fRetornaExpressaBoolean(FieldByName('CAM_EXPVIS').AsString, blnExprValida)) Then
      Begin
        pCampoToString(FGeraGR3.qryDados[FNroRel].FieldByName(FieldByName('CAM_NOMCAM').AsString), intNroDec);
        if not fQuebraJaFoi(FieldByName('CAM_LISQUE').AsString, strCamposQuebra) then
        begin
          strCamposQuebra  := strCamposQuebra + IIF(fEmptyStr(strCamposQuebra), '', ';') + FieldByName('CAM_LISQUE').AsString;
          strValoresQuebra := strValoresQuebra + IIF(fEmptyStr(strValoresQuebra), '', ';') + fCampoToString(FGeraGR3.qryDados[FNroRel].FieldByName(FieldByName('CAM_LISQUE').AsString), intNroDec);
        end;
      End;

      Next;
    End;
  End;

End;

Procedure TGeraCSV.pCampoToString(filCampo: TField; intNroDec: Integer);
  function fRemoveDesenhoLinha(strLinha: string): string;
  begin
    Result := strLinha;
    if Pos('<<LINEUP>>', Result) > 0 then
      Result := AnsiReplaceStr(Result, '<<LINEUP>>', '');
    if Pos('<<LINEDOWN>>', Result) > 0 then
      Result := AnsiReplaceStr(Result, '<<LINEDOWN>>', '');
    if Pos('<<LINELEFT>>', Result) > 0 then
      Result := AnsiReplaceStr(Result, '<<LINELEFT>>', '');
    if Pos('<<LINERIGHT>>', Result) > 0 then
      Result := AnsiReplaceStr(Result, '<<LINERIGHT>>', '');
  end;
Begin
  Inc(FNroCam);

  If FNroCam > 1 Then
    FLinha := FLinha + ';';

  Case filCampo.DataType Of
    ftTime     : FLinha := FLinha + IfThen(filCampo.IsNull, '', FormatDateTime('HH:NN:SS', filCampo.AsDateTime));
    ftDateTime : FLinha := FLinha + IfThen(filCampo.IsNull, '', FormatDateTime('DD/MM/YYYY HH:NN:SS', filCampo.AsDateTime));
    ftDate     : FLinha := FLinha + IfThen(filCampo.IsNull, '', FormatDateTime('DD/MM/YYYY', filCampo.AsDateTime));
    ftFloat    : FLinha := FLinha + FormatFloat(fMskDigitos(intNroDec), filCampo.AsFloat);
    ftWord,
    ftInteger  : FLinha := FLinha + filCampo.AsString;
    Else         If FComAspas Then
                   FLinha := FLinha + '"' + IIF(FDelAspas, AnsiReplaceStr(fRemoveDesenhoLinha(filCampo.AsString), '"', ' '), fRemoveDesenhoLinha(filCampo.AsString)) + '"'
                 Else
                   FLinha := FLinha + AnsiReplaceStr(fRemoveDesenhoLinha(filCampo.AsString), ';', ' ');
  End;
End;

Function TGeraCSV.fCampoToString(filCampo: TField; intNroDec: Integer): String;
Var
  strRetorno: String;
  function fRemoveDesenhoLinha(strLinha: string): string;
  begin
    Result := strLinha;
    if Pos('<<LINEUP>>', Result) > 0 then
      Result := AnsiReplaceStr(Result, '<<LINEUP>>', '');
    if Pos('<<LINEDOWN>>', Result) > 0 then
      Result := AnsiReplaceStr(Result, '<<LINEDOWN>>', '');
    if Pos('<<LINELEFT>>', Result) > 0 then
      Result := AnsiReplaceStr(Result, '<<LINELEFT>>', '');
    if Pos('<<LINERIGHT>>', Result) > 0 then
      Result := AnsiReplaceStr(Result, '<<LINERIGHT>>', '');
  end;
Begin
  strRetorno := '';

  Case filCampo.DataType Of
    ftTime     : strRetorno := IfThen(filCampo.IsNull, '', FormatDateTime('HH:NN:SS', filCampo.AsDateTime));
    ftDateTime : strRetorno := IfThen(filCampo.IsNull, '', FormatDateTime('DD/MM/YYYY HH:NN:SS', filCampo.AsDateTime));
    ftDate     : strRetorno := IfThen(filCampo.IsNull, '', FormatDateTime('DD/MM/YYYY', filCampo.AsDateTime));
    ftFloat    : strRetorno := FormatFloat(fMskDigitos(intNroDec), filCampo.AsFloat);
    ftWord,
    ftInteger  : strRetorno := filCampo.AsString;
    Else         If FComAspas Then
                   strRetorno := '"' + IIF(FDelAspas, AnsiReplaceStr(fRemoveDesenhoLinha(filCampo.AsString), '"', ' '), fRemoveDesenhoLinha(filCampo.AsString)) + '"'
                 Else
                   strRetorno := AnsiReplaceStr(fRemoveDesenhoLinha(filCampo.AsString), ';', ' ');
  End;

  Result := strRetorno;
End;

Procedure TGeraCSV.pGeraCampos(objGeraFr3P: TGeraFR3; blnExprValida: Boolean = False);
  Var
    intNroDec: Integer;
Begin
  With objGeraFr3P, cdsCamposG Do
  Begin
    IndexFieldNames := 'CAM_POSICA';

    First;

    While Not Eof Do
    Begin
      If FieldByName('CAM_NRODEC').IsNull Then
        intNroDec := 2
      Else
        Case TInterfaceRelatorio.fDescMascaraToTipo(FieldByName('CAM_MASCAR').AsString) Of
          masDecUni: intNroDec := intDecUni;
          masDecQtd: intNroDec := intDECQTD;
          masEstDec: intNroDec := intEstDec;
          masDeqTpc: intNroDec := intDeqTpc;
          Else       intNroDec := FieldByName('CAM_NRODEC').AsInteger;
        End;

      If fValidaVisibilidade(cdsCamposG, blnExprValida) And
         (FieldByName('CAM_LISTAR').AsString <> '') Then
        pCampoToString(FGeraGR3.qryDados[FNroRel].FieldByName(FieldByName('CAM_NOMCAM').AsString), intNroDec);

      Next;
    End;
  End;
End;

end.
