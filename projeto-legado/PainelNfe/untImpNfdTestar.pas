unit untImpNfdTestar;

{
  Testes do editor da impressao dinamica: fr3 com os dados dinamicos, ver dados e
  comparacoes.
}

interface

uses
  SysUtils, Classes, Dialogs;

type
  TImpNfdTestar = class
  private
    class procedure pMostraResultado(const ATitulo: String; ALinhas: TStrings);
    class procedure pDadosNFS(const AProvedor, AChave: String; ADados, AVariaveis, AMensagens: TStrings;
      out AEmpresa: String);
    class procedure pDadosNFe(const AChave: String; ADados, AVariaveis, AMensagens: TStrings;
      out AEmpresa: String);
    class procedure pDadosNFCe(const AChave: String; ADados, AVariaveis, AMensagens: TStrings;
      out AEmpresa: String);
  public
    class procedure pVerDados(const AProvedor, AChave: String);
    class procedure pTestar(const AProvedor, AChave: String);
    // NF-e: AModo R/P/S = abre o fr3 no Designer; C = compara rotina antiga x nova
    class procedure pTestarNFe(const AChave, AModo: String);
    // NFC-e: AModo D = abre o fr3 no Designer; C = compara rotina antiga x nova
    class procedure pTestarNFCe(const AChave, AModo: String);
    // lote de XMLs de NFC-e: nota no banco = comparacao completa; senao so a montagem
    class procedure pCompararLoteNFCe(const APasta: String);
  end;

implementation

uses
  Forms, Controls, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Contnrs, DB, untImpressaoNFe,
  untUtil, untModulo, untConexaoBD, untImpressaoNFCe, untNfceDinamico,
  untNfeDinamico, untNfsDinamico, untUniClientDataSet,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxTextEdit, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid,
  {$IF Defined(LINUX)} FMX.frxClass, {$ELSE} frxClass, {$IFEND}
{$IF Defined(UNIDAC)}
  Uni;
{$ELSE}
  ZDataset;
{$IFEND}

{ TImpNfdTestar }

class procedure TImpNfdTestar.pTestar(const AProvedor, AChave: String);
var
  con: TConexaoBD;
  imp: TImpressaoNfs;
  qry: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strCodEmp, strNumDoc, strEspDoc, strTipFc, strXml: String;
begin
  con := TConexaoBD.Create(frmModulo.Database);
  try
    qry := fCriaQuery(nil);
    try
      qry.SQL.Text :=
        'SELECT FIS_NUMDOC, FIS_ESPDOC, FIS_CODEMP, FIS_TIP_FC ' +
        'FROM CADFIS WHERE FIS_ACESSO = :ACESSO LIMIT 1';
      qry.ParamByName('ACESSO').AsString := AChave;
      qry.Open;
      if qry.IsEmpty then
      begin
        MessageDlg('Chave de acesso nao encontrada em CADFIS.', mtWarning, [mbOk], 0);
        qry.Close;
        Exit;
      end;
      strNumDoc := qry.FieldByName('FIS_NUMDOC').AsString;
      strEspDoc := qry.FieldByName('FIS_ESPDOC').AsString;
      strCodEmp := qry.FieldByName('FIS_CODEMP').AsString;
      strTipFc  := qry.FieldByName('FIS_TIP_FC').AsString;
      qry.Close;
    finally
      FreeAndNil(qry);
    end;

    strXml := con.CarregarXML(AChave);
    if fEmptyStr(strXml) then
    begin
      MessageDlg('Nao foi possivel carregar o XML da nota.', mtWarning, [mbOk], 0);
      Exit;
    end;

    // prepara a base (mesma preparacao da impressao real)
    con.FLayoutDinamico := True;
    try
      con.CarregarConfiguracao(AChave, strCodEmp, 'NFS', 4.00);
    finally
      con.FLayoutDinamico := False;
    end;
    con.pGetDadosNfsBd(strCodEmp, strNumDoc, strEspDoc, strTipFc);

    imp := TImpressaoNfs.Create(con);
    try
      imp.blnDesignReport := True;
      imp.FProvedorDin    := AProvedor;
      imp.FXmlDin         := strXml;
      imp.strChaveAcesso  := AChave;
      imp.pImprimeDanfeNfsDinamica;
    finally
      FreeAndNil(imp);
    end;
  finally
    FreeAndNil(con);
  end;
end;

class procedure TImpNfdTestar.pTestarNFe(const AChave, AModo: String);
var
  con: TConexaoBD;
  imp: TImpressaoNFe;
  strCodEmp: String;
begin
  strCodEmp := '';
  con := TConexaoBD.Create(frmModulo.Database);
  try
    try
      strCodEmp := con.RetornarCodigoEmpresa(AChave);
    except
      on E: Exception do
      begin
        MessageDlg(E.Message, mtWarning, [mbOk], 0);
        Exit;
      end;
    end;
  finally
    FreeAndNil(con);
  end;

  imp := TImpressaoNFe.Create;
  try
    imp.ModoTeste := UpperCase(Trim(AModo));
    try
      imp.Imprimir(strCodEmp, AChave, '');
    except
      on E: Exception do
      begin
        MessageDlg('Nao foi possivel executar o teste da NF-e.' + sLineBreak + E.Message, mtError, [mbOk], 0);
        Exit;
      end;
    end;

    if imp.ResultadoTeste.Count > 0 then
      pMostraResultado(IfThen(imp.ModoTeste = 'C', 'Comparar rotina antiga x rotina nova - NF-e ' + AChave,
        'Testar layout dinamico - NF-e ' + AChave), imp.ResultadoTeste);
  finally
    FreeAndNil(imp);
  end;
end;

class procedure TImpNfdTestar.pTestarNFCe(const AChave, AModo: String);
var
  con: TConexaoBD;
  imp: TImpressaoNFCe;
  strCodEmp: String;
begin
  strCodEmp := '';
  con := TConexaoBD.Create(frmModulo.Database);
  try
    try
      strCodEmp := con.RetornarCodigoEmpresa(AChave);
    except
      on E: Exception do
      begin
        MessageDlg(E.Message, mtWarning, [mbOk], 0);
        Exit;
      end;
    end;
  finally
    FreeAndNil(con);
  end;

  imp := TImpressaoNFCe.Create;
  try
    imp.ModoTeste := UpperCase(Trim(AModo));
    try
      imp.Imprimir(strCodEmp, AChave, '');
    except
      on E: Exception do
      begin
        MessageDlg('Nao foi possivel executar o teste da NFC-e.' + sLineBreak + E.Message, mtError, [mbOk], 0);
        Exit;
      end;
    end;

    if imp.ResultadoTeste.Count > 0 then
      pMostraResultado(IfThen(imp.ModoTeste = 'C', 'Comparar rotina antiga x rotina nova - NFC-e ' + AChave,
        'Testar layout dinamico - NFC-e ' + AChave), imp.ResultadoTeste);
  finally
    FreeAndNil(imp);
  end;
end;

class procedure TImpNfdTestar.pCompararLoteNFCe(const APasta: String);

  function fLeXml(const AArquivo: String): String;
  var
    lst: TStringList;
  begin
    // texto ANSI: o motor converte o XML UTF-8, como faz com o da XMLNFE
    lst := TStringList.Create;
    try
      {$IF CompilerVersion >= 20}
      lst.LoadFromFile(AArquivo, TEncoding.Default);
      {$ELSE}
      lst.LoadFromFile(AArquivo);
      {$IFEND}
      Result := lst.Text;
    finally
      FreeAndNil(lst);
    end;
  end;

  function fChave(const AXml, AArquivo: String): String;
  var
    intIni, intFim: Integer;
  begin
    Result := '';
    intIni := Pos('<chNFe>', AXml);
    if intIni > 0 then
    begin
      intIni := intIni + Length('<chNFe>');
      intFim := PosEx('</chNFe>', AXml, intIni);
      if intFim > intIni then
        Result := Trim(Copy(AXml, intIni, intFim - intIni));
    end;
    if Result = '' then
      Result := Copy(ChangeFileExt(ExtractFileName(AArquivo), ''), 1, 44);
  end;

  procedure pSoma(ALista: TStringList; const AChave: String);
  var
    intIdx: Integer;
  begin
    intIdx := ALista.IndexOf(AChave);
    if intIdx < 0 then
      intIdx := ALista.AddObject(AChave, TObject(0));
    ALista.Objects[intIdx] := TObject(Integer(ALista.Objects[intIdx]) + 1);
  end;

  procedure pMontaSoXml(const AXml, AChave: String; AErros: TStrings);
  var
    ent: TNfceDinEntrada;
    din: TNfceDinamico;
    rep: TfrxReport;
  begin
    ent := TNfceDinEntrada.Create;
    try
      din := TNfceDinamico.Create(ent);
      try
        rep := TfrxReport.Create(nil);
        try
          ent.strXml    := AXml;
          ent.strAcesso := AChave;
          ent.dsDoc     := nil;
          ent.frxReport := rep;
          ent.lstErros  := AErros;
          din.pCriarEstrutura(rep);
          din.pPreencher;
        finally
          FreeAndNil(rep);
        end;
      finally
        FreeAndNil(din);
      end;
    finally
      FreeAndNil(ent);
    end;
  end;

var
  sr: TSearchRec;
  con: TConexaoBD;
  imp: TImpressaoNFCe;
  lstRes, lstTipos, lstErros: TStringList;
  strPasta, strArq, strXml, strChave, strCodEmp, strLinha, strTipo: String;
  intQtd, intComparadas, intSoXml, intComDiv, intComErro, i, intPos: Integer;
begin
  strPasta := IncludeTrailingPathDelimiter(Trim(APasta));
  intQtd := 0;
  intComparadas := 0;
  intSoXml := 0;
  intComDiv := 0;
  intComErro := 0;

  lstRes := TStringList.Create;
  lstTipos := TStringList.Create;
  lstErros := TStringList.Create;
  con := TConexaoBD.Create(frmModulo.Database);
  Screen.Cursor := crHourGlass;
  try
    if FindFirst(strPasta + '*.xml', faAnyFile, sr) = 0 then
    try
      repeat
        if (sr.Attr and faDirectory) <> 0 then
          Continue;
        Inc(intQtd);
        strArq := strPasta + sr.Name;
        strXml := fLeXml(strArq);
        strChave := fChave(strXml, strArq);

        strCodEmp := '';
        try
          strCodEmp := con.RetornarCodigoEmpresa(strChave);
        except
          strCodEmp := '';
        end;

        if strCodEmp <> '' then
        begin
          // nota no banco: comparacao completa (rotina antiga x nova), XML do arquivo
          Inc(intComparadas);
          imp := TImpressaoNFCe.Create;
          try
            imp.ModoTeste := 'C';
            imp.XmlTeste := strXml;
            try
              imp.Imprimir(strCodEmp, strChave, '');
            except
              on E: Exception do
                imp.ResultadoTeste.Add('[NAO ESPERADA] Erro: ' + E.Message);
            end;
            if imp.NaoEsperadas > 0 then
            begin
              Inc(intComDiv);
              lstRes.Add(strChave + ': ' + IntToStr(imp.NaoEsperadas) + ' divergencia(s) nao esperada(s)');
            end;
            for i := 0 to imp.ResultadoTeste.Count - 1 do
            begin
              strLinha := imp.ResultadoTeste[i];
              if Pos('[NAO ESPERADA]', strLinha) = 0 then
                Continue;
              // tipo = "R.CAMPO" / "V.VARIAVEL" / "O.OBJETO" (antes do "|" ou do ":")
              strTipo := Trim(Copy(strLinha, Pos(']', strLinha) + 1, MaxInt));
              intPos := Pos('|', strTipo);
              if (intPos = 0) or (intPos > Pos(':', strTipo)) then
                intPos := Pos(':', strTipo);
              if intPos > 0 then
                strTipo := Copy(strTipo, 1, intPos - 1);
              pSoma(lstTipos, strTipo);
            end;
          finally
            FreeAndNil(imp);
          end;
        end
        else
        begin
          // nota fora do banco: so a montagem dinamica sobre o XML (sem @DOC)
          Inc(intSoXml);
          lstErros.Clear;
          try
            pMontaSoXml(strXml, strChave, lstErros);
          except
            on E: Exception do
              lstErros.Add('Montagem: ' + E.Message);
          end;
          if lstErros.Count > 0 then
          begin
            Inc(intComErro);
            lstRes.Add(strChave + ' (so XML): ' + lstErros[0]);
            for i := 0 to lstErros.Count - 1 do
              pSoma(lstTipos, 'Erro na montagem: ' + Copy(lstErros[i], 1, 80));
          end;
        end;
        Application.ProcessMessages;
      until FindNext(sr) <> 0;
    finally
      FindClose(sr);
    end;

    lstRes.Insert(0, 'NFC-e em lote: ' + strPasta);
    lstRes.Insert(1, StringOfChar('-', 78));
    lstRes.Insert(2, Format('Arquivos: %d | comparadas (nota no banco): %d, com divergencia nao esperada: %d | ' +
      'so XML (nota fora do banco): %d, com erro: %d', [intQtd, intComparadas, intComDiv, intSoXml, intComErro]));
    lstRes.Insert(3, '');
    lstRes.Add('');
    lstRes.Add('Ocorrencias por tipo:');
    for i := 0 to lstTipos.Count - 1 do
      lstRes.Add(Format('  %6d  %s', [Integer(lstTipos.Objects[i]), lstTipos[i]]));
  finally
    Screen.Cursor := crDefault;
    FreeAndNil(con);
    FreeAndNil(lstErros);
    FreeAndNil(lstTipos);
    try
      if lstRes.Count > 0 then
        pMostraResultado('Comparar NFC-e em lote', lstRes);
    finally
      FreeAndNil(lstRes);
    end;
  end;
end;

class procedure TImpNfdTestar.pVerDados(const AProvedor, AChave: String);

  function fUmaLinha(const ATexto: String): String;
  begin
    Result := StringReplace(ATexto, #13#10, ' | ', [rfReplaceAll]);
    Result := StringReplace(Result, #13, ' | ', [rfReplaceAll]);
    Result := Trim(StringReplace(Result, #10, ' | ', [rfReplaceAll]));
  end;

  procedure pCarregaOrigens(ALista: TStrings);
  var
    qry: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    blnNovo: Boolean;
    strOrigem: String;

    procedure pAdd(const ATexto: String);
    begin
      if strOrigem <> '' then
        strOrigem := strOrigem + ' | ';
      strOrigem := strOrigem + ATexto;
    end;

  begin
    blnNovo := TNfsDinamico.fModeloNovoDisponivel;
    qry := fCriaQuery(nil);
    try
      qry.SQL.Text :=
        'SELECT FLD_CODCDS, FLD_NOME, FLD_CAMINH, FLD_CAMAUX, FLD_AJUSTE' +
        IfThen(blnNovo, ', FLD_COLSEL, FLD_FUNC', '') + ' ' +
        'FROM IMPNFE_FLD WHERE FLD_CODPRV = :PRV';
      qry.ParamByName('PRV').AsString := AProvedor;
      qry.Open;
      while not qry.Eof do
      begin
        strOrigem := '';
        if Trim(qry.FieldByName('FLD_CAMINH').AsString) <> '' then
          pAdd('XML ' + Trim(qry.FieldByName('FLD_CAMINH').AsString));
        if Trim(qry.FieldByName('FLD_CAMAUX').AsString) <> '' then
          pAdd('aux ' + Trim(qry.FieldByName('FLD_CAMAUX').AsString));
        if blnNovo and (Trim(qry.FieldByName('FLD_COLSEL').AsString) <> '') then
          pAdd('apoio ' + Trim(qry.FieldByName('FLD_COLSEL').AsString));
        if Trim(qry.FieldByName('FLD_AJUSTE').AsString) <> '' then
          pAdd('ajuste ' + fUmaLinha(qry.FieldByName('FLD_AJUSTE').AsString));
        if blnNovo and (Trim(qry.FieldByName('FLD_FUNC').AsString) <> '') then
          pAdd('funcao ' + Trim(qry.FieldByName('FLD_FUNC').AsString));
        if strOrigem = '' then
          strOrigem := 'default';
        ALista.Add(UpperCase(qry.FieldByName('FLD_CODCDS').AsString + '.' +
          qry.FieldByName('FLD_NOME').AsString) + '=' + strOrigem);
        qry.Next;
      end;
      qry.Close;
    finally
      FreeAndNil(qry);
    end;
  end;

  function fTabelaCds(AOwner: TComponent; ADados: TDataSet; const ANomCds: String;
    AOrigens: TStrings): TUniClientDataSet;
  var
    f, r: Integer;
    fld: TField;
    strOrigem, strValor: String;
  begin
    Result := TUniClientDataSet.Create(AOwner);
    Result.FieldDefs.Add('REGISTRO', ftInteger);
    Result.FieldDefs.Add('CAMPO', ftString, 60);
    Result.FieldDefs.Add('ORIGEM', ftString, 1000);
    Result.FieldDefs.Add('VALOR', ftString, 4000);
    Result.CreateDataSet;
    Result.FieldByName('REGISTRO').DisplayLabel := 'Registro';
    Result.FieldByName('CAMPO').DisplayLabel    := 'Campo';
    Result.FieldByName('ORIGEM').DisplayLabel   := 'Origem';
    Result.FieldByName('VALOR').DisplayLabel    := 'Valor';

    if (ADados = nil) or (not ADados.Active) then
      Exit;

    r := 0;
    ADados.First;
    while not ADados.Eof do
    begin
      Inc(r);
      for f := 0 to ADados.FieldCount - 1 do
      begin
        fld := ADados.Fields[f];
        strOrigem := AOrigens.Values[UpperCase(ANomCds + '.' + fld.FieldName)];
        if strOrigem = '' then
          strOrigem := 'SELECT do dataset';
        if fld.IsNull then
          strValor := '(nulo)'
        else if fld.DataType in [ftBlob, ftGraphic] then
          strValor := '(binario)'
        else
          strValor := fUmaLinha(fld.AsString);

        Result.Append;
        Result.FieldByName('REGISTRO').AsInteger := r;
        Result.FieldByName('CAMPO').AsString     := Copy(fld.FieldName, 1, 60);
        Result.FieldByName('ORIGEM').AsString    := Copy(strOrigem, 1, 1000);
        Result.FieldByName('VALOR').AsString     := Copy(strValor, 1, 4000);
        Result.Post;
      end;
      ADados.Next;
    end;
    Result.First;
  end;

  function fTabelaVariaveis(AOwner: TComponent; AVariaveis: TStrings): TUniClientDataSet;
  var
    lstCol: TStringList;
    i: Integer;
  begin
    Result := TUniClientDataSet.Create(AOwner);
    Result.FieldDefs.Add('VARIAVEL', ftString, 60);
    Result.FieldDefs.Add('ORIGEM', ftString, 1000);
    Result.FieldDefs.Add('VALOR', ftString, 4000);
    Result.CreateDataSet;
    Result.FieldByName('VARIAVEL').DisplayLabel := 'Variavel';
    Result.FieldByName('ORIGEM').DisplayLabel   := 'Origem';
    Result.FieldByName('VALOR').DisplayLabel    := 'Valor';

    lstCol := TStringList.Create;
    try
      lstCol.Delimiter := #9;
      lstCol.StrictDelimiter := True;
      for i := 0 to AVariaveis.Count - 1 do
      begin
        lstCol.DelimitedText := AVariaveis[i];
        while lstCol.Count < 3 do
          lstCol.Add('');
        Result.Append;
        Result.FieldByName('VARIAVEL').AsString := Copy(lstCol[0], 1, 60);
        Result.FieldByName('ORIGEM').AsString   := Copy(lstCol[1], 1, 1000);
        Result.FieldByName('VALOR').AsString    := Copy(lstCol[2], 1, 4000);
        Result.Post;
      end;
    finally
      FreeAndNil(lstCol);
    end;
    Result.First;
  end;

  procedure pCriaGrade(AParent: TWinControl; ADataSet: TDataSet);
  var
    dts: TDataSource;
    grd: TcxGrid;
    tbv: TcxGridDBTableView;
  begin
    dts := TDataSource.Create(AParent);
    dts.DataSet := ADataSet;

    grd := TcxGrid.Create(AParent);
    grd.Parent := AParent;
    grd.Align  := alClient;
    tbv := grd.CreateView(TcxGridDBTableView) as TcxGridDBTableView;
    grd.Levels.Add.GridView := tbv;
    tbv.DataController.DataSource := dts;
    tbv.DataController.CreateAllItems;
    tbv.OptionsData.Editing         := False;
    tbv.OptionsData.Inserting       := False;
    tbv.OptionsData.Deleting        := False;
    tbv.OptionsView.GroupByBox      := False;
    tbv.OptionsView.ColumnAutoWidth := True;
    tbv.OptionsView.Indicator       := True;
    tbv.FilterRow.Visible           := True;
    tbv.FilterRow.InfoText          := 'Clique aqui para definir um filtro';
    if tbv.ColumnCount = 4 then
    begin
      tbv.Columns[0].Width := 60;
      tbv.Columns[1].Width := 140;
      tbv.Columns[2].Width := 300;
      tbv.Columns[3].Width := 420;
    end
    else if tbv.ColumnCount = 3 then
    begin
      tbv.Columns[0].Width := 140;
      tbv.Columns[1].Width := 320;
      tbv.Columns[2].Width := 460;
    end;
  end;

var
  lstDados, lstVar, lstMsg, lstOrigens: TStringList;
  frm: TForm;
  pnl: TPanel;
  btn: TButton;
  pgc: TPageControl;
  tab: TTabSheet;
  dsDados: TDataSet;
  strEmpresa, strTitulo: String;
  i, intQtd: Integer;
begin
  strEmpresa := '';
  lstDados := TStringList.Create;
  lstVar := TStringList.Create;
  lstMsg := TStringList.Create;
  lstOrigens := TStringList.Create;
  try
    Screen.Cursor := crHourGlass;
    try
      if SameText(AProvedor, cstProvedorNotaFiscal) then
        pDadosNFe(AChave, lstDados, lstVar, lstMsg, strEmpresa)
      else if SameText(AProvedor, cstProvedorCupomFiscal) then
        pDadosNFCe(AChave, lstDados, lstVar, lstMsg, strEmpresa)
      else
        pDadosNFS(AProvedor, AChave, lstDados, lstVar, lstMsg, strEmpresa);
      pCarregaOrigens(lstOrigens);
    finally
      Screen.Cursor := crDefault;
    end;

    strTitulo := 'Ver dados - ' + AProvedor + ' - empresa ' + strEmpresa + ' - chave ' + AChave;

    if (lstDados.Count = 0) and (lstVar.Count = 0) then
    begin
      if lstMsg.Count = 0 then
        lstMsg.Add('Nenhum dado foi montado para o provedor ' + AProvedor + '.');
      pMostraResultado(strTitulo, lstMsg);
      Exit;
    end;

    if lstMsg.Count > 0 then
      pMostraResultado(strTitulo + ' - avisos', lstMsg);

    frm := TForm.CreateNew(nil);
    try
      frm.Caption  := strTitulo;
      frm.Position := poScreenCenter;
      frm.Width    := 1000;
      frm.Height   := 640;

      pnl := TPanel.Create(frm);
      pnl.Parent     := frm;
      pnl.Align      := alBottom;
      pnl.Height     := 44;
      pnl.BevelOuter := bvNone;

      btn := TButton.Create(frm);
      btn.Parent      := pnl;
      btn.Caption     := 'Fechar';
      btn.Width       := 100;
      btn.Height      := 28;
      btn.Top         := 8;
      btn.Left        := pnl.ClientWidth - btn.Width - 8;
      btn.Anchors     := [akTop, akRight];
      btn.ModalResult := mrOk;
      btn.Cancel      := True;

      pgc := TPageControl.Create(frm);
      pgc.Parent := frm;
      pgc.Align  := alClient;

      for i := 0 to lstDados.Count - 1 do
      begin
        dsDados := TDataSet(lstDados.Objects[i]);
        intQtd := 0;
        if (dsDados <> nil) and dsDados.Active then
          intQtd := dsDados.RecordCount;

        tab := TTabSheet.Create(frm);
        tab.PageControl := pgc;
        tab.Caption := lstDados[i] + ' (' + IntToStr(intQtd) + ')';
        pCriaGrade(tab, fTabelaCds(frm, dsDados, lstDados[i], lstOrigens));
      end;

      tab := TTabSheet.Create(frm);
      tab.PageControl := pgc;
      tab.Caption := 'Variaveis (' + IntToStr(lstVar.Count) + ')';
      pCriaGrade(tab, fTabelaVariaveis(frm, lstVar));

      frm.ShowModal;
    finally
      FreeAndNil(frm);
    end;
  finally
    for i := 0 to lstDados.Count - 1 do
      lstDados.Objects[i].Free;
    FreeAndNil(lstOrigens);
    FreeAndNil(lstMsg);
    FreeAndNil(lstVar);
    FreeAndNil(lstDados);
  end;
end;

class procedure TImpNfdTestar.pDadosNFS(const AProvedor, AChave: String; ADados, AVariaveis, AMensagens: TStrings;
  out AEmpresa: String);
var
  con: TConexaoBD;
  qry: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  rep: TfrxReport;
  lstCds: TObjectList;
  cds: TUniClientDataSet;
  strNumDoc, strEspDoc, strXml, strNomCds: String;
begin
  AEmpresa := '';
  con := TConexaoBD.Create(frmModulo.Database);
  try
    qry := fCriaQuery(nil);
    try
      qry.SQL.Text :=
        'SELECT FIS_NUMDOC, FIS_ESPDOC, FIS_CODEMP ' +
        'FROM CADFIS WHERE FIS_ACESSO = :ACESSO LIMIT 1';
      qry.ParamByName('ACESSO').AsString := AChave;
      qry.Open;
      if qry.IsEmpty then
      begin
        AMensagens.Add('Chave de acesso nao encontrada em CADFIS.');
        Exit;
      end;
      strNumDoc := qry.FieldByName('FIS_NUMDOC').AsString;
      strEspDoc := qry.FieldByName('FIS_ESPDOC').AsString;
      AEmpresa  := qry.FieldByName('FIS_CODEMP').AsString;
      qry.Close;
    finally
      FreeAndNil(qry);
    end;

    strXml := con.CarregarXML(AChave);
    if fEmptyStr(strXml) then
    begin
      AMensagens.Add('Nao foi possivel carregar o XML da nota (XMLNFE).');
      Exit;
    end;

    rep := TfrxReport.Create(nil);
    try
      lstCds := TObjectList.Create(True);
      try
        qry := fCriaQuery(nil);
        try
          qry.SQL.Text :=
            'SELECT c.CDS_NOMCDS FROM IMPNFE_CDS c ' +
            'WHERE c.CDS_CODPRV = :PRV ' +
            'AND COALESCE(c.CDS_ORIGEM, ''X'') <> ''A'' ' +
            'ORDER BY (c.CDS_NOMFRX <> ''frxNFS''), c.CDS_NOMCDS';
          qry.ParamByName('PRV').AsString := AProvedor;
          qry.Open;
          while not qry.Eof do
          begin
            strNomCds := qry.FieldByName('CDS_NOMCDS').AsString;
            cds := TUniClientDataSet.Create(nil);
            lstCds.Add(cds);
            try
              TNfsDinamico.pMontarCds(cds, AProvedor, strNomCds, strXml, AChave, AEmpresa);
            except
              on E: Exception do
                AMensagens.Add('Dataset ' + strNomCds + ': ' + E.Message);
            end;
            TNfsDinamico.pAddDadosTeste(strNomCds, cds, ADados);
            qry.Next;
          end;
          qry.Close;
        finally
          FreeAndNil(qry);
        end;

        if lstCds.Count > 0 then
          TNfsDinamico.pCarregaVariaveis(rep, AProvedor, TUniClientDataSet(lstCds[0]),
            AChave, AEmpresa, strNumDoc, strEspDoc);
        TNfsDinamico.pListaVariaveis(rep, AProvedor, AVariaveis);
      finally
        FreeAndNil(lstCds);
      end;
    finally
      FreeAndNil(rep);
    end;
  finally
    FreeAndNil(con);
  end;
end;

class procedure TImpNfdTestar.pDadosNFe(const AChave: String; ADados, AVariaveis, AMensagens: TStrings;
  out AEmpresa: String);
var
  con: TConexaoBD;
  imp: TImpressaoNFe;
begin
  AEmpresa := '';
  con := TConexaoBD.Create(frmModulo.Database);
  try
    try
      AEmpresa := con.RetornarCodigoEmpresa(AChave);
    except
      on E: Exception do
      begin
        AMensagens.Add(E.Message);
        Exit;
      end;
    end;
  finally
    FreeAndNil(con);
  end;

  imp := TImpressaoNFe.Create;
  try
    imp.ModoTeste  := 'V';
    imp.DadosTeste := ADados;
    try
      imp.Imprimir(AEmpresa, AChave, '');
    except
      on E: Exception do
        AMensagens.Add('Nao foi possivel executar o teste da NF-e: ' + E.Message);
    end;
    AMensagens.AddStrings(imp.ResultadoTeste);
    AVariaveis.AddStrings(imp.VariaveisTeste);
  finally
    FreeAndNil(imp);
  end;
end;

class procedure TImpNfdTestar.pDadosNFCe(const AChave: String; ADados, AVariaveis, AMensagens: TStrings;
  out AEmpresa: String);
var
  con: TConexaoBD;
  imp: TImpressaoNFCe;
begin
  AEmpresa := '';
  con := TConexaoBD.Create(frmModulo.Database);
  try
    try
      AEmpresa := con.RetornarCodigoEmpresa(AChave);
    except
      on E: Exception do
      begin
        AMensagens.Add(E.Message);
        Exit;
      end;
    end;
  finally
    FreeAndNil(con);
  end;

  imp := TImpressaoNFCe.Create;
  try
    imp.ModoTeste  := 'V';
    imp.DadosTeste := ADados;
    try
      imp.Imprimir(AEmpresa, AChave, '');
    except
      on E: Exception do
        AMensagens.Add('Nao foi possivel executar o teste da NFC-e: ' + E.Message);
    end;
    AMensagens.AddStrings(imp.ResultadoTeste);
    AVariaveis.AddStrings(imp.VariaveisTeste);
  finally
    FreeAndNil(imp);
  end;
end;

class procedure TImpNfdTestar.pMostraResultado(const ATitulo: String; ALinhas: TStrings);
var
  frm: TForm;
  mmoRes: TMemo;
begin
  // janela simples de resultado (texto somente leitura, para rolar e copiar)
  frm := TForm.CreateNew(nil);
  try
    frm.Caption  := ATitulo;
    frm.Position := poScreenCenter;
    frm.Width    := 960;
    frm.Height   := 600;

    mmoRes := TMemo.Create(frm);
    mmoRes.Parent     := frm;
    mmoRes.Align      := alClient;
    mmoRes.ReadOnly   := True;
    mmoRes.ScrollBars := ssBoth;
    mmoRes.WordWrap   := False;
    mmoRes.Font.Name  := 'Courier New';
    mmoRes.Lines.Assign(ALinhas);

    frm.ShowModal;
  finally
    FreeAndNil(frm);
  end;
end;

end.
