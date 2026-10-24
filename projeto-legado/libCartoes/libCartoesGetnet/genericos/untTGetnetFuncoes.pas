unit untTGetnetFuncoes;

interface

uses System.StrUtils, System.SysUtils, System.Variants, WinApi.Windows,
     System.Classes, Vcl.Dialogs, Vcl.StdActns, Vcl.StdCtrls,
     Vcl.Forms, System.ZLib, System.Win.Registry, System.Hash,
     System.IOUtils, WinApi.ShellAPI, WinApi.ShlObj, Data.DB,
     System.Rtti, Vcl.Themes, Vcl.Styles, Vcl.SysStyles, System.DateUtils,
     System.Json, REST.Json, Vcl.DBCtrls, Vcl.Mask, Vcl.Controls,
     Winapi.Messages, WinApi.PsAPI,  Aurelius.Types.Nullable,

     frxExportPDF, frxClass, frxPreview, IdCompressorZlib, dxCore, EditFocus,
     Uni, cxCheckComboBox, cxDropDownEdit, cxCalendar,

     untIGetnetIntegracaoLibCartoes, untGetnetTipos,
     untLibCartoesInterfacesTipos,
     untILibCartoesWrapper, untTLibCartoesFuncoes;

Type
  TGetnetFuncoes = class(TLibCartoesFuncoes)
  private
    class function RetornaEstruturaTabelaCaminhoArquivo: String;
    class procedure ImportarCaminhoPastaDosArquivos;
    class function RetornaCaminhoPastaDosArquivos:String;
    class procedure SalvaCaminhoPastaDosArquivos(ACaminhoArquivos:String);
  public
    class function PrettyJSON(JsonString:String):String;
    class function RetornaCampoDecimalJSON(AValor: String): String;
    class function RetornaSequencial(ATabela: String; ACodEmp: String = ''):String;
    class function fConverteParaAcento(strLinha: String): String; //solução provisória

    class procedure pEnabled(NomeForm:TForm;Habilitar:Boolean);
    class procedure Aguarde(msecs: Integer);

    class procedure CarregaEstiloAutcom;

    class function fArquivoFolder(ASalvar: Boolean = False): String;
    class function SafeFilePath(const FilePath: string): Boolean;
    class procedure pRenomeiaAquivo(strNomVel, strNomNov: String);

    class function RetornaSQLReplace(ANomeTabela: String;
                                     ACamposIgnorados: Array of String): String;

    class function MetodoExisteNaInterface(AInstancia: IInterface; ANomeMetodo: string): Boolean;

    class procedure GravarEstabelecimentos(ALayoutAPI: Boolean = False);

    class procedure pExibirRelatorio(strNomPro, strDesPro: String; AReport: IReport);

    class procedure VerificaEstrutraTabelas(ALayoutArquivo: Boolean);

    class procedure CarregaRegistrosJaImportados(ANomeTabela: String; ACamposChavePrimaria: array of String;
                                                 AValoresChavePrimaria: array of Variant);

    class function fIPesqEmpresa(ASelf    : TForm;                           {* Formulário                                  *}
                                 edtCodigo: TCustomEdit;                     {* Edit do Código                              *}
                                 edtNomEmp: TEditFocus;                      {* Edit do Nome da Empresa                     *}
                                 Var chrKey: Char): Boolean;


    class procedure ImportarCartoesArquivo(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String);
    class function fAcertaDataParaDiaUtil(const dtaOrigem: TDateTime; const strCodCid: String = ''): TDateTime;
    class function fDiaDeFolga(const dtaDta: TDateTime;
                               const blnConsideraSabado: Boolean = True;
                               const strCodCid: String = '';
                               const blnConsideraSabadoAndDomingoComoDiaUtil: Boolean = False;
                               const blnConsideraDomingo: Boolean = False): Boolean;
    class function fEhFeriado(const dtaDta: TDateTime; const strCodCid: String = ''): Boolean;
end;

Var
  VS_FuncoesExternas: ILibCartoes;

  VS_PastaConciliacao,
  VS_PastaAutcom: String;

  VS_ListaEstabelecimentos: TStringList;

  VS_AutcomModoClassico: Boolean;

  VS_TimeZone: Integer;
  VS_RegistrosJaImportados: TUniQuery;

  FEmpresaLogada: string;
  FEmpresaCalculandoImpostos: string;

Implementation

Uses untGetnet;

class procedure TGetnetFuncoes.Aguarde(msecs: Integer);
var
  FirstTickCount: LongInt;
begin
  FirstTickCount := GetTickCount;
  repeat
    Application.ProcessMessages;
  until ((LongInt(GetTickCount) - LongInt(FirstTickCount)) >= LongInt(msecs));
end;

class procedure TGetnetFuncoes.CarregaEstiloAutcom;
begin
  If VS_AutcomModoClassico Then
    Exit;

  Try
    TStyleManager.TrySetStyle(AUTCOM_STYLE_NAME);
    TStyleManager.SystemHooks  := TStyleManager.SystemHooks - [shDialogs];

    TCustomStyleEngine.UnRegisterSysStyleHook('#32768', TSysPopupStyleHook);

    TCustomStyleEngine.UnRegisterSysStyleHook('#32770', TSysDialogStyleHook);

    TCustomStyleEngine.UnRegisterSysStyleHook('ScrollBar', TSysScrollBarStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('Button', TSysButtonStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('Edit', TSysEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('ComboBox', TSysComboBoxStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('Label', TSysComboBoxStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('ListBox', TSysListBoxStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('ComboLBox', TSysListBoxStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('Static', TSysStaticStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('Shape', TSysStaticStyleHook);

    TCustomStyleEngine.UnRegisterSysStyleHook('ToolbarWindow32', TSysToolbarStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('SysListView32', TSysListViewStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('SysTabControl32', TSysTabControlStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('SysTreeView32', TSysTreeViewStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('msctls_progress32', TSysProgressBarStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit20A', TSysRichEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit20W', TSysRichEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit30A', TSysRichEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit30W', TSysRichEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit41A', TSysRichEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit41W', TSysRichEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit50A', TSysRichEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit50W', TSysRichEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RebarWindow32', TSysReBarStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('msctls_statusbar32', TSysStatusBarStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('msctls_trackbar32', TSysTrackBarStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('msctls_updown32', TSysUpDownStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('tooltips_class32', TSysTooltipsStyleHook);
  Except
    VS_AutcomModoClassico := True;
  End;
end;

class function TGetnetFuncoes.fAcertaDataParaDiaUtil(const dtaOrigem: TDateTime;
  const strCodCid: String): TDateTime;
var
  LCodCid: String;
begin
  Result := dtaOrigem;

  if VS_FuncoesExternas.fICfgSis('FEMUCP', varBoolean) then
    LCodCid := strCodCid
  else
    LCodCid := '';

  while fDiaDeFolga(Result, True, LCodCid) do
    Result := Result + 1;
end;

class function TGetnetFuncoes.fArquivoFolder(ASalvar: Boolean): String;
begin
  If ASalvar Then
    SalvaCaminhoPastaDosArquivos(VS_PastaConciliacao);

  Result := RetornaCaminhoPastaDosArquivos;

  If fEmptyStr(Result) Then
  Begin
    VS_PastaConciliacao := ExtractFilePath(Application.ExeName);
    Result := VS_PastaConciliacao;
  End;
end;

class function TGetnetFuncoes.fConverteParaAcento(strLinha: String): String;
 Function fRetiraAspaSimples(strTexto:String):String;
var
  intCont: Integer;
begin
  Result := '';
  For intCont := 1 To Length(strTexto) do
  begin
    If Copy(strTexto, intCont, 1) <> Chr(39) then
      Result := Result + Copy(strTexto, intCont, 1);
  end;
end;

Begin
  Result := fRetiraAspaSimples(strLinha);
  Result := StringReplace(Result, 'Ã§Ã£', 'çã', [rfReplaceAll]);
  Result := StringReplace(Result, 'Ãª', 'ê', [rfReplaceAll]);
  Result := StringReplace(Result, 'Ãº', 'ú', [rfReplaceAll]);
  Result := StringReplace(Result, 'Ã³', 'ó', [rfReplaceAll]);
  Result := StringReplace(Result, 'Ã£', 'ã', [rfReplaceAll]);

  While (Pos('disponÃ', Result) > 0) Do
    Result := Copy(Result, 1, Pos('disponÃ', Result) - 1) + 'disponível' +
              Copy(Result, Pos('vel', Result)  + 3, Length(Result));

end;

class function TGetnetFuncoes.fDiaDeFolga(const dtaDta: TDateTime;
  const blnConsideraSabado: Boolean; const strCodCid: String;
  const blnConsideraSabadoAndDomingoComoDiaUtil,
  blnConsideraDomingo: Boolean): Boolean;
const
  SABADO = 7;
  DOMINGO = 1;
begin
  if blnConsideraSabadoAndDomingoComoDiaUtil then
    Result := fEhFeriado(dtaDta, strCodCid)
  else
  begin
    if blnConsideraSabado then
      Result := (DayOfWeek(dtaDta) in [DOMINGO, SABADO]) or fEhFeriado(dtaDta, strCodCid)
    else if blnConsideraDomingo and (DayOfWeek(dtaDta) = DOMINGO) then
      Result := fEhFeriado(dtaDta, strCodCid)
    else
      Result := (DayOfWeek(dtaDta) = DOMINGO) or fEhFeriado(dtaDta, strCodCid);
  end;
end;

class function TGetnetFuncoes.fEhFeriado(const dtaDta: TDateTime;
  const strCodCid: String): Boolean;
var
  qryAux: TUniQuery;
  strDta: String;
  LintTotal : integer;
begin
  strDta := FormatDateTime('yyyy-mm-dd', dtaDta);

  qryAux := VS_FuncoesExternas.fICriaQuery;
  try
    qryAux.SQL.Text := 'SELECT COUNT(*) AS QTD FROM CADFER WHERE FER_DTAFER = :DTA';
    qryAux.ParamByName('DTA').AsString := strDta;
    qryAux.Open;
    LintTotal := qryAux.FieldByName('QTD').AsInteger;
    qryAux.Close;

    if not fEmptyStr(strCodCid) then
    begin
      qryAux.SQL.Text := 'SELECT COUNT(*) AS QTD FROM FERCID WHERE FCI_DTAFER = :DTA AND FCI_CODCID = :CID';
      qryAux.ParamByName('DTA').AsString := strDta;
      qryAux.ParamByName('CID').AsString := strCodCid;
      qryAux.Open;
      LintTotal := LintTotal + qryAux.FieldByName('QTD').AsInteger;
    end;

    Result := LintTotal > 0;

  finally
    qryAux.Close;
    FreeAndNil(qryAux);
  end;

end;

class function TGetnetFuncoes.fIPesqEmpresa(ASelf: TForm;
  edtCodigo: TCustomEdit; edtNomEmp: TEditFocus; var chrKey: Char): Boolean;
Var
  arrEmp: TConsultasArray;
begin
  Result := True;

  If MetodoExisteNaInterface(VS_FuncoesExternas, 'fIPesqEmpresa') Then
    Result := VS_FuncoesExternas.fIPesqEmpresa(conEmpSimples, ASelf, edtCodigo, edtNomEmp,Nil, chrKey, arrEmp);
end;

class procedure TGetnetFuncoes.GravarEstabelecimentos(ALayoutAPI: Boolean = False);
Var
  LGravacao: TUniQuery;
  LEstabelecimento,
  LConciliacao: String;
begin
  If Not Assigned(VS_ListaEstabelecimentos) Then
    Exit;

  LConciliacao := NOME_CONCILIACAO;
  If ALayoutAPI Then
    LConciliacao := NOME_CONCILIACAO + ' API';

  LGravacao := Nil;
  Try
    LGravacao := VS_FuncoesExternas.fICriaQuery;
    LGravacao.SQL.Text := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, :CONCILIACAO)';
    For LEstabelecimento In VS_ListaEstabelecimentos Do
    Begin
      If LEstabelecimento.IsEmpty Then
        Continue;

      LGravacao.ParamByName('ESTAB').AsString := LEstabelecimento;
      LGravacao.ParamByName('CONCILIACAO').AsString := LConciliacao;
      LGravacao.ExecSQL;
    End;

  Finally
    VS_ListaEstabelecimentos.Clear;
    FreeAndNilDatasets(LGravacao);
  End;
end;

class procedure TGetnetFuncoes.ImportarCaminhoPastaDosArquivos;
Var
  LTabelaArqCon: TUniQuery;
  LArquivo: TStringList;
  LArquivoItem,
  LCaminhoArquivos: String;
begin
  Try
    LTabelaArqCon := Nil;
    Try
      LTabelaArqCon := VS_FuncoesExternas.fICriaQuery;
      LTabelaArqCon.SQL.Text := 'SELECT COUNT(*) AS QTD FROM ARQCON ';
      LTabelaArqCon.Open;

      If (LTabelaArqCon.FieldByName('QTD').AsInteger > 0) Then
        Exit;

      ExecutaSQL('REPLACE INTO TABNRE (NOMTAB) VALUES ("ARQCON")');

      LArquivo := TStringList.Create;
      Try
        If FileExists(VS_PastaAutcom + 'folderconcil.txt') Then
        Begin
          LArquivo.LoadFromFile(VS_PastaAutcom + 'folderconcil.txt');

          For LArquivoItem In LArquivo Do
          Begin
            LCaminhoArquivos := Copy(LArquivoItem, Pos('=', LArquivoItem) + 1, Length(LArquivoItem));

            SalvaCaminhoPastaDosArquivos(LCaminhoArquivos);
          End;
        End;
      Finally
        FreeAndNil(LArquivo);
      End;
    Finally
      FreeAndNilDatasets(LTabelaArqCon);
    End;
  Except
    { se não conseguir importar não faz nada, não pode parar a rotina }
  End;
end;

class procedure TGetnetFuncoes.ImportarCartoesArquivo(AAplicacao: HWND;
  APastaAutcom, ANomeEmpresa: String);
Var
  LImportacao: TGetnet;
Begin
  LImportacao := TGetnet.Create(Application);
  Try
    LImportacao.Aplicacao := AAplicacao;
    LImportacao.Empresa := LeftStr(ANomeEmpresa,3);
    VS_PastaAutcom := APastaAutcom;
    LImportacao.pSelecionaFonte;
  Finally
    FreeAndNil(LImportacao);
  End;
end;

class function TGetnetFuncoes.MetodoExisteNaInterface(AInstancia: IInterface;
  ANomeMetodo: string): Boolean;
var
  LMetodo: TMethod;
begin
  LMetodo.Code := nil;
  LMetodo.Data := nil;

  Result := False;
  if AInstancia.QueryInterface(ILibCartoes, LMetodo.Data) = S_OK then
    Result := Assigned(LMetodo.Code);
end;

class procedure TGetnetFuncoes.pEnabled(NomeForm: TForm; Habilitar: Boolean);
var
  intContador : Integer;
begin
  For intContador := 0 to (NomeForm.ComponentCount - 1) do
  Begin
    If NomeForm.Components[intContador].Tag = 50 Then
      Continue;

    If NomeForm.Components[intContador].ClassNameIs('TEditFocus') Then
    	If TCustomEdit(NomeForm.Components[intContador]).TabStop Then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TDBEditFocus') Then
    	If TCustomEdit(NomeForm.Components[intContador]).TabStop Then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TComboBoxFocus') Then
    	If TCustomEdit(NomeForm.Components[intContador]).TabStop Then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TComboBoxFocus') Then
    	If TCustomEdit(NomeForm.Components[intContador]).TabStop Then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TMaskEditFocus') Then
    	If TCustomEdit(NomeForm.Components[intContador]).TabStop Then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TDBMemoFocus') Then
    	If TCustomEdit(NomeForm.Components[intContador]).TabStop Then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TGroupBox') Then
    	If TCustomEdit(NomeForm.Components[intContador]).TabStop Then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TCheckBox') Then
    	If TCustomEdit(NomeForm.Components[intContador]).TabStop Then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TCustomEdit') Then
    	If TCustomEdit(NomeForm.Components[intContador]).TabStop Then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TCustomComboBox') Then
    	If TCustomComboBox(NomeForm.Components[intContador]).TabStop Then
	    	TCustomComboBox(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TDbLookUpControl') Then
    	If TDbLookUpControl(NomeForm.Components[intContador]).TabStop Then
	    	TDbLookUpControl(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TDbRadioGroup') Then
      If TDbRadioGroup(NomeForm.Components[intContador]).TabStop Then
    	  TDbRadioGroup(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TDbCheckBox') Then
    	If TDbCheckBox(NomeForm.Components[intContador]).TabStop Then
	    	TDbCheckBox(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TcxCheckComboBox') Then
    	If TcxCheckComboBox(NomeForm.Components[intContador]).TabStop Then
	    	TcxCheckComboBox(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TDBLookupComboBox') Then
    	If TDBLookupComboBox(NomeForm.Components[intContador]).TabStop Then
	    	TDBLookupComboBox(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TDBRadioGroup') Then
    	If TDBLookupComboBox(NomeForm.Components[intContador]).TabStop Then
	    	TDBLookupComboBox(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TMaskEdit') Then
    	If TMaskEdit(NomeForm.Components[intContador]).TabStop Then
	    	TMaskEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TcxComboBox') Then
    	If TcxComboBox(NomeForm.Components[intContador]).TabStop Then
	    	TcxComboBox(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TcxDateEdit') Then
    	If TcxDateEdit(NomeForm.Components[intContador]).TabStop Then
	    	TcxDateEdit(NomeForm.Components[intContador]).Enabled := Habilitar;
	End;
end;

class procedure TGetnetFuncoes.pExibirRelatorio(strNomPro, strDesPro: String; AReport: IReport);
begin
  If MetodoExisteNaInterface(VS_FuncoesExternas, 'pIExibirRelatorio') Then
  Begin
    VS_FuncoesExternas.pIExibirRelatorio(strNomPro, strDesPro, AReport);
    Exit;
  End;

  AReport.ShowReport;
end;

class procedure TGetnetFuncoes.pRenomeiaAquivo(strNomVel, strNomNov: String);
begin
  RenameFile(strNomVel, strNomNov);
end;

class function TGetnetFuncoes.PrettyJSON(JsonString: String): String;
Var
  Jdoc:TJSONObject;
begin
  Jdoc := Nil;
  Try
    Jdoc:=TJSONObject.ParseJSONValue(JsonString) as TJSONObject;
    result:= TJSON.Format(Jdoc);
  Finally
    FreeAndNilObjeto(Jdoc);
  End;
end;

class function TGetnetFuncoes.RetornaCaminhoPastaDosArquivos: String;
Var
  LPastaConciliacao: TUniQuery;
begin
  LPastaConciliacao := Nil;
  Try
    LPastaConciliacao := VS_FuncoesExternas.fICriaQuery;
    LPastaConciliacao.Close;
    LPastaConciliacao.SQL.Text := 'SELECT                      '+
                                  '  ARQ_CAMARQ                '+
                                  'FROM                        '+
                                  '  ARQCON                    '+
                                  'WHERE ARQ_NOMCON = :NOMCON  ';

    LPastaConciliacao.ParamByName('NOMCON').AsString := NOME_CONCILIACAO;
    LPastaConciliacao.Open;

    Result := LPastaConciliacao.FieldByName('ARQ_CAMARQ').AsString;

    If Not TryDirectoryExists(Result) Then
      Result := EmptyStr;
  Finally
    FreeAndNilDatasets(LPastaConciliacao);
  End;
end;

class function TGetnetFuncoes.RetornaCampoDecimalJSON(AValor: String): String;
begin
  Result := AValor.Replace('.', EmptyStr);
  Result := Result.Replace(',', '.');
end;

class function TGetnetFuncoes.RetornaEstruturaTabelaCaminhoArquivo: String;
begin
  Result := 'CREATE TABLE ARQCON(                 '+
            '  ARQ_NOMCON VARCHAR(100) NOT NULL,  '+
            '  ARQ_CAMARQ TEXT DEFAULT NULL,      '+
            'PRIMARY KEY(ARQ_NOMCON)              '+
            ') ENGINE=INNODB                      ';
end;

class function TGetnetFuncoes.RetornaSequencial(ATabela,
  ACodEmp: String): String;
var
  LProCod: TUniQuery;
begin
  Result := '1';
  try
    LProCod := VS_FuncoesExternas.fICriaQuery;
    try
      LProCod.SQL.Text := Format(
        'SELECT fRetAutoIncrem("%s", "%s") AS SEQUENCIAL',
        [ATabela, ACodEmp]
      );
      LProCod.Open;

      if not LProCod.FieldByName('SEQUENCIAL').IsNull then
        Result := LProCod.FieldByName('SEQUENCIAL').AsString;
    except
      on E: Exception do
        Result := '1';
    end;
  finally
    if Assigned(LProCod) then
      FreeAndNil(LProCod);
  end;
end;

class function TGetnetFuncoes.RetornaSQLReplace(ANomeTabela: String;
  ACamposIgnorados: Array of String): String;
Var
  LTabela: TUniQuery;
  LCampos,
  LParametros: String;
  LField: TField;
Begin
  LTabela := Nil;
  Try
    LTabela := VS_FuncoesExternas.fICriaQuery;
    LTabela.SQL.Text := 'SELECT * FROM ' + ANomeTabela + ' WHERE FALSE';
    LTabela.Open;

    LCampos := EmptyStr;
    LParametros := EmptyStr;

    Result := 'REPLACE INTO ' + ANomeTabela + ' (';

    For LField In LTabela.Fields Do
    Begin
      If MatchStr(LField.FieldName, ACamposIgnorados) Then
        Continue;

      LCampos := LCampos + LField.FieldName + ',';

      LParametros := LParametros + ':' + LField.FieldName + ',';
    End;

    Result := Result + LeftStr(LCampos, LCampos.Length - 1) + ') VALUES (' +
                       LeftStr(LParametros, LParametros.Length - 1) + ')';
  Finally
    FreeAndNilDatasets(LTabela);
  End;
End;

class function TGetnetFuncoes.SafeFilePath(const FilePath: string): Boolean;
var
  MaxPathLength: Integer;
  FileAttr: Cardinal;
begin
  Result := False;
  MaxPathLength := 255;

  try
    if not TryDirectoryExists(FilePath) then
    begin
      fMensagem('ATENÇÃO','O caminho: ' + FilePath + ' não existe!',['&OK']);
      Exit;
    end;

    if Length(FilePath) > MaxPathLength then
    begin
      fMensagem('ATENÇÃO','O caminho: ' + FilePath + ' é muito longo.',['&OK']);
      Exit;
    end;

    FileAttr := GetFileAttributes(PChar(FilePath));
    if (FileAttr = INVALID_FILE_ATTRIBUTES) then
    begin
      fMensagem('ATENÇÃO','Você não tem permissão para acessar caminho: ' + FilePath + '',['&OK']);
      Exit;
    end;

    Result := True;
  except
    on E: EFileNotFoundException do
      Raise EFileNotFoundException.Create('Arquivo não encontrado. ' + E.Message);
    on E: EInOutError do
      Raise EInOutError.Create('Erro de entrada/saída. ' + E.Message);
    on E: Exception do
      Raise Exception.Create('Erro desconhecido: ' + E.Message);
  end;
end;

class procedure TGetnetFuncoes.SalvaCaminhoPastaDosArquivos(ACaminhoArquivos: String);
Var
  LInserir: TUniQuery;
Begin

  If ACaminhoArquivos.Trim.IsEmpty Then
    ACaminhoArquivos := VS_PastaConciliacao;

  LInserir := Nil;
  Try
    LInserir := VS_FuncoesExternas.fICriaQuery;
    LInserir.SQL.Text := 'REPLACE INTO ARQCON (ARQ_NOMCON, ARQ_CAMARQ) '+
                         'VALUES (:NOMCON, :CAMARQ)                    ';

    LInserir.ParamByName('NOMCON').AsString := NOME_CONCILIACAO;
    LInserir.ParamByName('CAMARQ').AsString := ACaminhoArquivos;
    LInserir.ExecSQL;
  Finally
    FreeAndNilDatasets(LInserir);
  End;
end;

class procedure TGetnetFuncoes.VerificaEstrutraTabelas(ALayoutArquivo: Boolean);
begin
  If Not fTabelaExiste('ARQCON') Then
    ExecutaSQL(RetornaEstruturaTabelaCaminhoArquivo);

  ImportarCaminhoPastaDosArquivos;
end;

class procedure TGetnetFuncoes.CarregaRegistrosJaImportados(
  ANomeTabela: String; ACamposChavePrimaria: array of String;
  AValoresChavePrimaria: array of Variant);
  Var
    LContador: Integer;
Begin
  If Length(ACamposChavePrimaria) <> Length(AValoresChavePrimaria) Then
    Raise Exception.Create('A função CarregaRegistrosJaImportados foi implementada incorretamente.');

  FreeAndNilDatasets(VS_RegistrosJaImportados);
  VS_RegistrosJaImportados := VS_FuncoesExternas.fICriaQuery;
  VS_RegistrosJaImportados.SQL.Text := 'SELECT * FROM ' + ANomeTabela + ' WHERE ';

  For LContador := 0 To Length(ACamposChavePrimaria) - 1 Do
    VS_RegistrosJaImportados.SQL.Text := VS_RegistrosJaImportados.SQL.Text +
                                         ' ' + ACamposChavePrimaria[LContador] +' '+ AValoresChavePrimaria[LContador] + ' AND ';

  VS_RegistrosJaImportados.SQL.Text := LeftStr(Trim(VS_RegistrosJaImportados.SQL.Text), Length(Trim(VS_RegistrosJaImportados.SQL.Text)) - 3);

  VS_RegistrosJaImportados.Open;
End;

initialization
  VS_RegistrosJaImportados := Nil;

Finalization
  TGetnetFuncoes.FreeAndNilDatasets(VS_RegistrosJaImportados);

end.
