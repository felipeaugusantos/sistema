unit untDocumentos;

interface

uses Classes, SysUtils, Controls, ComCtrls, DB, UniClientDataSet, Uni, Forms,
  StrUtils, Math, frxClass, untFuncoesEditorFast, untFuncoesSimples, untTypesSistema,
  untZClient, UniDataSetProvider, TypesRel, cxProgressBar;

Type
  TDocumentos = Class(TZClient)
  Private
    FNomArq: String;

    stlDocumentos: TStringList;

    stlRegistro: TStringList;

    cdsOpcDoc: TZClient;

    function fSQLDocumentos: String;
    function fSQLOpcoes: String;
    function fRetormaOpcaoDoc(strTipImp: String): Integer;

    procedure pCriaOpcoesDoc;
    Procedure pListaDocumentos;

    Function fExportaDocumentosPrg(prgProgresso: TcxProgressBar): Boolean;
    Function fImportaDocumentosPrg(prgProgresso: TcxProgressBar): Boolean;

  Public

    procedure pIncluiDocumento(blnInclui: Boolean; srTipImp: String);
    procedure pExcluiDocumento;
    procedure pAtualizaNaoPadrao(strCodLay: String; intTipLay: Integer; tpaTipArq: TTipoArquivo);

    procedure pAtualizaDocumento(strCodLay: String; intTipLay: Integer; strPadrao, strGerPDF: String);

    procedure pRefresh(strNumDoc: String);

    constructor Create(Owner: TComponent);
    Destructor  Destroy; Override;

    Function fInList(strAutInc: String): Boolean;
    Function fDocsSelecionados: Boolean;

    Procedure pMarcaDesmarca;
    Procedure pMarcaTodos(blnMarcar: Boolean);

    Function fExportaDocumentos: Boolean;
    Function fImportaDocumentos: Boolean;
  End;

implementation

uses Dialogs,
  untMenuDocumentos, untConstantes, untGravando,
  untEditorEtiquetasPrinc, untModulo;

Function TDocumentos.fSQLOpcoes: String;
Begin
  Result := 'SELECT 0 AS CODCON, 0 AS CODOPC, CAST("" AS CHAR(100)) AS DESOPC ';
End;

Function TDocumentos.fSQLDocumentos: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '   *  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   LAYETI ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '   LAY_TIPREG = 1 ';
  strSQL := strSQL + '   AND LAY_CODEMP = ' + QuotedStr(VS_strCodEmp);
  strSQL := strSQL + ' ORDER BY LAY_CODLAY ';

  Result := strSQL;
End;

constructor TDocumentos.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, fSQLDocumentos);

  AggregatesActive := True;

  pListaDocumentos;

  stlDocumentos        := TStringList.Create;
  stlDocumentos.Sorted := True;

  stlRegistro        := TStringList.Create;

  pCriaOpcoesDoc;
End;

Procedure TDocumentos.pListaDocumentos;
Begin
  fAbreClient(True, 'TDocumentos.Create');
  pAlinhaCampoCentro('LAY_CODLAY');
  pAlinhaCampoCentro('LAY_TIPIMP');
End;

destructor TDocumentos.Destroy;
begin
  stlDocumentos.Clear;
  FreeAndNil(stlDocumentos);

  stlRegistro.Clear;
  FreeAndNil(stlRegistro);

  inherited Destroy;
end;

Procedure TDocumentos.pCriaOpcoesDoc;
  Var
    intContador: TTipoEtiqueta;
Begin
  cdsOpcDoc := TZClient.Create(Self, fSQLOpcoes);

  If cdsOpcDoc.fAbreClient(True, 'TDocumentos.Create') Then
  Begin
    cdsOpcDoc.EmptyDataSet;

    cdsOpcDoc.pAlinhaCampoCentro('DESOPC');

    For intContador := tpeMI To tpeRequisicao Do
    Begin
       If (ARR_TIPO_LAYOUT[intContador] = 97) And (not fCfgSis('MATCON', varBoolean)) Then
         Continue;

       cdsOpcDoc.Append;
       cdsOpcDoc.FieldByName('CODCON').AsInteger := 0;
       cdsOpcDoc.FieldByName('CODOPC').AsInteger := ARR_TIPO_LAYOUT[intContador];
       cdsOpcDoc.FieldByName('DESOPC').AsString  := String(ARR_NOME_ETIQUETA[intContador]);
       cdsOpcDoc.Post;
    End;

    cdsOpcDoc.Append;
    cdsOpcDoc.FieldByName('CODCON').AsInteger := 1;
    cdsOpcDoc.FieldByName('CODOPC').AsInteger := -1;
    cdsOpcDoc.FieldByName('DESOPC').AsString  := 'Sair';
    cdsOpcDoc.Post;

    cdsOpcDoc.IndexFieldNames := 'CODCON;DESOPC';

    cdsOpcDoc.First;
  End;
End;

Function TDocumentos.fRetormaOpcaoDoc(strTipImp: String): Integer;
Begin
  pCriarFormularios(TfrmMenuDocumentos, frmMenuDocumentos);

  frmMenuDocumentos.cxgItensView.DataController.DataSource := cdsOpcDoc.dtsSource;

  If strTipImp = 'M' Then
    frmMenuDocumentos.Caption := '      Selecione o Tipo de Documento (Matricial)'
  Else
    frmMenuDocumentos.Caption := '      Selecione o Tipo de Documento (Jato)';

  frmMenuDocumentos.ShowModal;

  If frmMenuDocumentos.blnConfirma Then
    Result := cdsOpcDoc.FieldByName('CODOPC').AsInteger
  Else
    Result := -1;

  pFreeAndNil(frmMenuDocumentos);
End;

Procedure TDocumentos.pExcluiDocumento;
  Var
    strMensagem: String;
Begin
  If IsEmpty Then
    Exit;

  If FieldByName('LAY_PADRAO').AsString = 'S' Then
    strMensagem := 'Este layout está como padrão. Confirma a exclusão?'
  Else
    strMensagem := 'Confirma a exclusão do layout?';

  If fPergunta(strMensagem) Then
  Begin
    Delete;
    fSalva;
  End;
End;

Procedure TDocumentos.pIncluiDocumento(blnInclui: Boolean; srTipImp: String);
   Var
     intOpcao: Integer;
     tpeTipEtq: TTipoEtiqueta;
     strNumDoc: String;
     strCodLayDoc: String;
Begin
  Try
    strCodLayDoc := '';

    If blnInclui Then
    Begin
      intOpcao := fRetormaOpcaoDoc(srTipImp);

      If intOpcao = -1 Then
        Exit;

      tpeTipEtq := fCodLayToTipoEtiqueta(intOpcao);

    End Else
    Begin
      If IsEmpty Then
        Exit;

      tpeTipEtq := fCodLayToTipoEtiqueta(FieldByName('LAY_TIPLAY').AsInteger);

    End;

    If Not blnInclui Then
      strCodLayDoc := FieldByName('LAY_CODLAY').AsString;

    pCriarFormularios(TfrmEditorEtiquetasPrinc, frmEditorEtiquetasPrinc);

    frmEditorEtiquetasPrinc.strTipImp := srTipImp;

    With frmEditorEtiquetasPrinc Do
    Begin
      If Not blnInclui Then
        strCodLayDoc := FieldByName('LAY_CODLAY').AsString;

      tpeCodEti    := tpeTipEtq;
      ShowModal;

      strNumDoc := strCodLayDoc;
    End;
    FreeAndNil(frmEditorEtiquetasPrinc);

    pRefresh(strNumDoc);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TDocumentos.pIncluiDocumento]');
    End;
  End;
End;

Procedure TDocumentos.pRefresh(strNumDoc: String);
Begin
  Refresh;
  Locate('LAY_CODLAY', strNumDoc, []);
End;

procedure TDocumentos.pAtualizaNaoPadrao(strCodLay: String; intTipLay: Integer; tpaTipArq: TTipoArquivo);
  Var
    qryLayRel: TUniQuery;
Begin
  qryLayRel := fCriaQuery;
  With qryLayRel, SQL Do
  Begin
    Clear;

    Add('UPDATE LAYETI');

    Case tpaTipArq Of
      tpaNormal: Add('SET LAY_PADRAO = "N"');
      tpaPDF   : Add('SET LAY_GERPDF = "N"');
    End;

    Add('WHERE');
    Add('  LAY_TIPLAY  = :TIPLAY AND ');
    Add('  LAY_CODLAY <> :CODLAY AND ');
    Add('  LAY_CODEMP = ' + QuotedStr(VS_strCodEmp));

    ParamByName('TIPLAY').AsInteger := intTipLay;
    ParamByName('CODLAY').AsString  := strCodLay;

    ExecSQL;
  End;
  FreeAndNil(qryLayRel);
End;

procedure TDocumentos.pAtualizaDocumento(strCodLay: String; intTipLay: Integer;
                                         strPadrao, strGerPDF: String);
  Var
    qryLayRel: TUniQuery;
Begin
  qryLayRel := fCriaQuery;
  With qryLayRel, SQL Do
  Begin
    Clear;

    Add('UPDATE LAYETI SET ');
    Add('  LAY_PADRAO = :PADRAO, ');
    Add('  LAY_GERPDF = :GERPDF  ');
    Add('WHERE');
    Add('  LAY_TIPLAY = :TIPLAY AND ');
    Add('  LAY_CODLAY = :CODLAY AND ');
    Add('  LAY_CODEMP = ' + QuotedStr(VS_strCodEmp));

    ParamByName('TIPLAY').AsInteger := intTipLay;
    ParamByName('CODLAY').AsString  := strCodLay;
    ParamByName('PADRAO').AsString  := strPadrao;
    ParamByName('GERPDF').AsString  := strGerPDF;

    ExecSQL;
  End;
  FreeAndNil(qryLayRel);
End;

Function TDocumentos.fInList(strAutInc: String): Boolean;
  Var
    intIndex: Integer;
Begin
  Result := stlDocumentos.Find(strAutInc, intIndex);
End;

Procedure TDocumentos.pMarcaDesmarca;
  Var
    intIndex: Integer;
Begin
  If IsEmpty Then
    Exit;

  If stlDocumentos.Find(FieldByName('AUTOINCREM').AsString, intIndex) Then
  Begin
    stlDocumentos.Delete(intIndex);
  End Else
  Begin
    (*
    If fEmptyStr(FieldByName('LAY_CHAVE_').AsString) Then
      pMensagemOk('Registro sem chave de identificação!')
    Else *)
      stlDocumentos.Add(FieldByName('AUTOINCREM').AsString);
  End;
End;

Procedure TDocumentos.pMarcaTodos(blnMarcar: Boolean);
Begin
  stlDocumentos.Clear;

  If blnMarcar Then
  Begin
    First;
    While Not Eof Do
    Begin

      If blnMarcar Then
       // If Not fEmptyStr(FieldByName('LAY_CHAVE_').AsString) Then
          stlDocumentos.Add(FieldByName('AUTOINCREM').AsString);

      Next;
    End;
  End;
End;

Function TDocumentos.fDocsSelecionados: Boolean;
Begin
  Result := stlDocumentos.Count > 0;
End;

Function TDocumentos.fExportaDocumentos: Boolean;
  Var
    svdArquivo: TSaveDialog;
Begin
  Result := False;

  svdArquivo := TSaveDialog.Create(Nil);
  svdArquivo.Filter := 'Arquivo de Layouts|*.lay';
  svdArquivo.DefaultExt := 'lay';

  If svdArquivo.Execute Then
  Try
    FNomArq := svdArquivo.FileName;
    pCriarFormularios(TfrmGravando, frmGravando);

    frmGravando.lblGravando.Caption := 'Exportando arquivos, aguarde...';
    frmGravando.fExecutarAcao := fExportaDocumentosPrg;
    frmGravando.ShowModal;

    Result := frmGravando.blnConfirma;

    pFreeAndNil(frmGravando);

    If Result Then
      pMensagemOk('Layouts exportados com sucesso!');
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TDocumentos.fExportaDocumentos');
    End;
  End;

  FreeAndNil(svdArquivo);
End;

Function TDocumentos.fExportaDocumentosPrg(prgProgresso: TcxProgressBar): Boolean;
  Var
    intContador,
    intCampos: Integer;
Begin
  prgProgresso.Properties.Max := stlDocumentos.Count;

  IndexFieldNames := 'AUTOINCREM';
  stlRegistro.Clear;

  stlRegistro.Add(IntToStr(stlDocumentos.Count));

  For intContador := 0 To Fields.Count - 1 Do
    If Pos(Fields[intContador].FieldName, 'LAY_RELFR3-AUTOINCREM-LAY_CODEMP-LAY_CODLAY-LAY_ORDENA') = 0 Then
      stlRegistro.Add(Fields[intContador].FieldName);

  For intContador := 0 To stlDocumentos.Count - 1 Do
  If FindKey([stlDocumentos[intContador]]) Then
  Begin
    stlRegistro.Add('');
    stlRegistro.Add(FieldByName('LAY_CHAVE_').AsString);

    stlRegistro.Add('/LAYOUT');

    stlRegistro.Add(FieldByName('LAY_RELFR3').AsString);
    stlRegistro.Add('\LAYOUT');

    stlRegistro.Add('/ORDENA');
    stlRegistro.Add(FieldByName('LAY_ORDENA').AsString);
    stlRegistro.Add('\ORDENA');

    For intCampos := 0 To Fields.Count - 1 Do
    If Pos(Fields[intCampos].FieldName, 'LAY_RELFR3-AUTOINCREM-LAY_CODEMP-LAY_CODLAY-LAY_ORDENA') = 0 Then
    Begin

      Case Fields[intCampos].DataType Of
        ftInteger: stlRegistro.Add(Fields[intCampos].AsString);
        ftFloat  : stlRegistro.Add(AnsiReplaceStr(Fields[intCampos].AsString, ',', '.'));
        ftDate   : stlRegistro.Add(FormatDateTime('DD/MM/YYYY', Fields[intCampos].Value));
        ftTime   : stlRegistro.Add(FormatDateTime('HH:NN:SS', Fields[intCampos].Value));
        Else       stlRegistro.Add(Fields[intCampos].AsString);
      End;

    End;

    prgProgresso.Position := prgProgresso.Position + 1;
    Application.ProcessMessages;
  End;

  If Not SameText(RightStr(LowerCase(FNomArq), 4), '.lay') Then
    FNomArq := FNomArq + '.lay';

  stlRegistro.SaveToFile(FNomArq);

  Result := True;
End;

Function TDocumentos.fImportaDocumentos: Boolean;
  Var
    opdArquivo: TOpenDialog;
Begin
  Result := False;

  opdArquivo := TOpenDialog.Create(Nil);
  opdArquivo.Filter := 'Arquivo de Layouts|*.lay';
  opdArquivo.DefaultExt := 'lay';

  If opdArquivo.Execute Then
  Try
    FNomArq := opdArquivo.FileName;

    pCriarFormularios(TfrmGravando, frmGravando);

    frmGravando.lblGravando.Caption := 'Importando arquivos, aguarde...';
    frmGravando.fExecutarAcao := fImportaDocumentosPrg;
    frmGravando.ShowModal;

    Result := frmGravando.blnConfirma;

    pListaDocumentos;

    pFreeAndNil(frmGravando);

    If Result Then
      pMensagemOk('Layouts importados com sucesso!');
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TDocumentos.fImportaDocumentos');
    End;
  End;

  FreeAndNil(opdArquivo);
End;

Function TDocumentos.fImportaDocumentosPrg(prgProgresso: TcxProgressBar): Boolean;
  Var
    intQtdLay: Integer;
    intLinhas,
    intCampos: Integer;
    stlCampos: TStringList;
    stlLayfr3: TStringList;
    stlOrdena: TStringList;
    qryLayout: TUniQuery;
    strChave: String;

    Function fIncLinha: Boolean;
    Begin
      Inc(intLinhas);
      Result := intLinhas <= stlRegistro.Count - 1;
    End;

Begin
  Try
    Result := True;

    stlRegistro.LoadFromFile(FNomArq);

    If stlRegistro.Count = 0 Then
    Begin
      Result := False;
      pMensagemOk('Arquivo vazio!');
      Exit;
    End;

    intLinhas := 0;
    intQtdLay := StrToIntdef(stlRegistro[intLinhas], 1);
    prgProgresso.Properties.Max := intQtdLay;

    If Not fIncLinha Then
    Begin
      pMensagemOk('Arquivo de layout incompatível com o sistema!');
      Result := False;
      Exit;
    End;

    stlCampos := TStringList.Create;
    stlLayfr3 := TStringList.Create;
    stlOrdena := TStringList.Create;

    qryLayout := fCriaQuery;

    While Not fEmptyStr(stlRegistro[intLinhas]) Do
    Begin
      stlCampos.Add(stlRegistro[intLinhas]);

      If Not fIncLinha Then
      Begin
        Result := False;
        pMensagemOk('Arquivo de layout incompatível com o sistema!');
        Break;
      End;
    End;

    If Result Then
    Repeat
      If Not fIncLinha Then
        Break;

      strChave := stlRegistro[intLinhas];

      If Not fIncLinha Then
        Break;

      fStartTransaction;

      qryLayout.Close;

      If fEmptyStr(strChave) Then
      Begin
        qryLayout.SQL.Text := 'SELECT * FROM LAYETI WHERE FALSE';
      End Else
      Begin
        qryLayout.SQL.Text := 'SELECT * FROM LAYETI WHERE LAY_CHAVE_ = :CHAVE_ AND LAY_CODEMP = :CODEMP ';
        qryLayout.ParamByName('CHAVE_').AsString := strChave;
        qryLayout.ParamByName('CODEMP').AsString := VS_strCodEmp;
      End;

      qryLayout.Open;

      If qryLayout.IsEmpty Then
      Begin
        qryLayout.Insert;
        qryLayout.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LAYETI', VS_strCodEmp);
        qryLayout.FieldByName('LAY_CODEMP').AsString := VS_strCodEmp;
        qryLayout.FieldByName('LAY_CODLAY').AsString := fAtualizaProCod('LAYETI', 'LAY_CODLAY');
      End Else
      Begin
        qryLayout.Edit;
      End;

      // LAYOUT
      If Not SameText('/LAYOUT', stlRegistro[intLinhas]) Then
      Begin
        Result := False;
        pMensagemOk('Arquivo de Layout fora do padrão!');
        break;
      End;

      If Not fIncLinha Then
        Break;

      stlLayfr3.Clear;
      Repeat
        stlLayfr3.Add(stlRegistro[intLinhas]);

        If Not fIncLinha Then
        Begin
          pMensagemOk('Arquivo de layout incompatível com o sistema!');
          Result := False;
          Break;
        End;

      until (intLinhas = stlRegistro.Count - 1) Or SameText('\LAYOUT', stlRegistro[intLinhas]);

      If Not Result Then
        Break;

      If Not SameText('\LAYOUT', stlRegistro[intLinhas]) Then
      Begin
        Result := False;
        pMensagemOk('Arquivo de Layout fora do padrão!');
        break;
      End;

      qryLayout.FieldByName('LAY_RELFR3').AsString := stlLayfr3.Text;

      // ORDENA
      If Not fIncLinha Then
        Break;

      If Not SameText('/ORDENA', stlRegistro[intLinhas]) Then
      Begin
        Result := False;
        pMensagemOk('Arquivo de Layout fora do padrão!');
        break;
      End;

      If Not fIncLinha Then
        Break;

      stlOrdena.Clear;
      Repeat
        stlOrdena.Add(stlRegistro[intLinhas]);

        If Not fIncLinha Then
        Begin
          pMensagemOk('Arquivo de layout incompatível com o sistema!');
          Result := False;
          Break;
        End;

      until (intLinhas = stlRegistro.Count - 1) Or SameText('\ORDENA', stlRegistro[intLinhas]);

      If Not Result Then
        Break;

      If Not SameText('\ORDENA', stlRegistro[intLinhas]) Then
      Begin
        Result := False;
        pMensagemOk('Arquivo de Layout fora do padrão!');
        break;
      End;

      qryLayout.FieldByName('LAY_ORDENA').AsString := stlOrdena.Text;

      For intCampos := 0 To stlCampos.Count - 1 Do
      Begin
        If Not fIncLinha Then
        Begin
          pMensagemOk('Arquivo de layout incompatível com o sistema!');
          Result := False;
          Break;
        End;

        // arquivo exportado de versao com campo que esta base ainda nao tem (ex.: LAY_REFTRI): ignora o campo
        // Verificar Nota 3 - Req. 462714
        If Not Assigned(qryLayout.FindField(stlCampos[intCampos])) Then
          Continue;

        Case qryLayout.FieldByName(stlCampos[intCampos]).DataType Of
          ftFloat  : qryLayout.FieldByName(stlCampos[intCampos]).AsFloat    := fStrToFloat(stlRegistro[intLinhas]);
          ftDate   : qryLayout.FieldByName(stlCampos[intCampos]).AsDateTime := StrToDateDef(stlRegistro[intLinhas], VS_Date);
          ftTime   : qryLayout.FieldByName(stlCampos[intCampos]).AsDateTime := StrToTimeDef(stlRegistro[intLinhas], fTime());
          Else       qryLayout.FieldByName(stlCampos[intCampos]).AsString   := stlRegistro[intLinhas];
        End;

      End;

      If Not Result Then
        Break;

      qryLayout.FieldByName('LAY_PADRAO').AsString := 'N';
      qryLayout.FieldByName('LAY_GERPDF').AsString := 'N';

      qryLayout.Post;

      fCommit;

      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;

      If Not fIncLinha Then
        Break;

    until intLinhas = stlRegistro.Count - 1;

    If Not Result Then
     fRollBack;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, 'TDocumentos.fImportaDocumentos');
    End;
  End;

  FreeAndNil(qryLayout);
  FreeAndNil(stlCampos);
  FreeAndNil(stlLayfr3);
  FreeAndNil(stlOrdena);
End;

end.
