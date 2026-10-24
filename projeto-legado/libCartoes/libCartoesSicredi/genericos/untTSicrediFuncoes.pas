unit untTSicrediFuncoes;

interface

uses System.StrUtils, System.SysUtils, System.Variants, WinApi.Windows,
     System.Classes, Vcl.Dialogs, Vcl.StdActns, Vcl.StdCtrls,
     Vcl.Forms, System.ZLib, System.Win.Registry, System.Hash,
     System.IOUtils, WinApi.ShellAPI, WinApi.ShlObj, Data.DB,
     System.Rtti, Vcl.Themes, Vcl.Styles, Vcl.SysStyles, System.DateUtils,
     System.Json, REST.Json, Vcl.DBCtrls, Vcl.Mask, Vcl.Controls,
     Winapi.Messages, WinApi.PsAPI,

     untISicrediIntegracaoLibCartoes, untSicrediTipos,
     untLibCartoesInterfacesTipos,
     untILibCartoesWrapper, untTLibCartoesFuncoes,

     frxExportPDF, frxClass, frxPreview, IdCompressorZlib, dxCore, EditFocus,
     Uni, cxCheckComboBox, cxDropDownEdit, cxCalendar;

Type
  TSicrediFuncoes = class(TLibCartoesFuncoes)
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

    class function RetornaNomeEmpresaEstabelecimento(ACodEmp: String): String;

    class procedure pExibirRelatorio(strNomPro, strDesPro: String; AReport: IReport);

    class procedure VerificaEstrutraTabelas(ALayoutArquivo: Boolean);

    class function fIPesqEmpresa(ASelf    : TForm;                           {* Formulário                                  *}
                                 edtCodigo: TCustomEdit;                     {* Edit do Código                              *}
                                 edtNomEmp: TEditFocus;                      {* Edit do Nome da Empresa                     *}
                                 Var chrKey: Char): Boolean;


    class procedure ImportarCartoesArquivo(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String);
end;

Var
  VS_FuncoesExternas: ILibCartoes;

  VS_PastaConciliacao,
  VS_PastaAutcom: String;

  VS_ListaEstabelecimentos: TStringList;

  VS_AutcomModoClassico: Boolean;

  VS_TimeZone: Integer;

  FEmpresaLogada: string;
  FEmpresaCalculandoImpostos: string;

Implementation

Uses untSicredi;

class procedure TSicrediFuncoes.Aguarde(msecs: Integer);
var
  FirstTickCount: LongInt;
begin
  FirstTickCount := GetTickCount;
  repeat
    Application.ProcessMessages;
  until ((LongInt(GetTickCount) - LongInt(FirstTickCount)) >= LongInt(msecs));
end;

class procedure TSicrediFuncoes.CarregaEstiloAutcom;
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

class function TSicrediFuncoes.fArquivoFolder(ASalvar: Boolean): String;
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

class function TSicrediFuncoes.fConverteParaAcento(strLinha: String): String;
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

class function TSicrediFuncoes.fIPesqEmpresa(ASelf: TForm;
  edtCodigo: TCustomEdit; edtNomEmp: TEditFocus; var chrKey: Char): Boolean;
Var
  arrEmp: TConsultasArray;
begin
  Result := True;

  If MetodoExisteNaInterface(VS_FuncoesExternas, 'fIPesqEmpresa') Then
    Result := VS_FuncoesExternas.fIPesqEmpresa(conEmpSimples, ASelf, edtCodigo, edtNomEmp,Nil, chrKey, arrEmp);
end;

class procedure TSicrediFuncoes.GravarEstabelecimentos(ALayoutAPI: Boolean = False);
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

class procedure TSicrediFuncoes.ImportarCaminhoPastaDosArquivos;
Var
  LTabelaArqCon: TUniQuery;
  LArquivo: TStringList;
  LArquivoItem,
  LCaminhoArquivos: String;
begin
  LTabelaArqCon := Nil;
  Try
    LTabelaArqCon := VS_FuncoesExternas.fICriaQuery;
    Try
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

class procedure TSicrediFuncoes.ImportarCartoesArquivo(AAplicacao: HWND;
  APastaAutcom, ANomeEmpresa: String);
Var
  LImportacao: TSicredi;
Begin
  LImportacao := TSicredi.Create(Application);
  Try
    VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(False);
    LImportacao.Aplicacao := AAplicacao;
    LImportacao.Empresa := LeftStr(ANomeEmpresa,3);
    VS_PastaAutcom := APastaAutcom;
    LImportacao.pSelecionaFonte;
  Finally
    VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(True);
    FreeAndNil(LImportacao);
  End;
end;

class function TSicrediFuncoes.MetodoExisteNaInterface(AInstancia: IInterface;
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

class procedure TSicrediFuncoes.pEnabled(NomeForm: TForm; Habilitar: Boolean);
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

class procedure TSicrediFuncoes.pExibirRelatorio(strNomPro, strDesPro: String; AReport: IReport);
begin
  If MetodoExisteNaInterface(VS_FuncoesExternas, 'pIExibirRelatorio') Then
  Begin
    VS_FuncoesExternas.pIExibirRelatorio(strNomPro, strDesPro, AReport);
    Exit;
  End;

  AReport.ShowReport;
end;

class procedure TSicrediFuncoes.pRenomeiaAquivo(strNomVel, strNomNov: String);
begin
  RenameFile(strNomVel, strNomNov);
end;

class function TSicrediFuncoes.PrettyJSON(JsonString: String): String;
Var
  Jdoc:TJSONObject;
begin
  Jdoc := Nil;
  Try
    Jdoc:=TJSONObject.ParseJSONValue(JsonString) as TJSONObject;
    result:= TJSON.Format(Jdoc);
  Finally
    If Assigned(Jdoc) Then
      FreeAndNil(Jdoc);
  End;
end;

class function TSicrediFuncoes.RetornaCaminhoPastaDosArquivos: String;
Var
  LPastaConciliacao: TUniQuery;
begin
  LPastaConciliacao := Nil;
  Try
    LPastaConciliacao := VS_FuncoesExternas.fICriaQuery;
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

class function TSicrediFuncoes.RetornaCampoDecimalJSON(AValor: String): String;
begin
  Result := AValor.Replace('.', EmptyStr);
  Result := Result.Replace(',', '.');
end;

class function TSicrediFuncoes.RetornaEstruturaTabelaCaminhoArquivo: String;
begin
  Result := 'CREATE TABLE ARQCON(                 '+
            '  ARQ_NOMCON VARCHAR(100) NOT NULL,  '+
            '  ARQ_CAMARQ TEXT DEFAULT NULL,      '+
            'PRIMARY KEY(ARQ_NOMCON)              '+
            ') ENGINE=INNODB                      ';
end;

class function TSicrediFuncoes.RetornaNomeEmpresaEstabelecimento(
  ACodEmp: String): String;
Var
  qryDados: TUniQuery;
Begin
  qryDados := Nil;
  Try
    qryDados := VS_FuncoesExternas.fICriaQuery;
    qryDados.SQL.Text := 'SELECT                                                                                '+
                         '  CONCAT(EMP_CODEMP,"-",EMP_NOMEMP) AS EMPRESA                                        '+
                         'FROM                                                                                  '+
                         '  CFGSIS                                                                              '+
                         '  JOIN CADEMP                                                                         '+
                         '    ON EMP_CODEMP = SIS_CODEMP                                                        '+
                         'WHERE SIS_CODCFG IN ("CFG_REDEST", "CFG_REDECO")                                      '+
                         '  AND IFNULL(SIS_VALCFG, "") <> ""                                                    '+
                         '  AND LOCATE(TRIM(LEADING 0 FROM :CODEMP),TRIM(LEADING 0 FROM SIS_VALCFG) ) > 0       ';

    qryDados.ParamByName('CODEMP').AsString := ACodEmp;
    qryDados.Open;

    If (qryDados.IsEmpty) Then
      Exit('');

    Result := qryDados.FieldByName('EMPRESA').AsString;
  Finally
    FreeAndNilDatasets(qryDados);
  End;
End;

class function TSicrediFuncoes.RetornaSequencial(ATabela,
  ACodEmp: String): String;
var
  LProCod: TUniQuery;
begin
  LProCod := Nil;
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
    FreeAndNilDatasets(LProCod);
  end;
end;

class function TSicrediFuncoes.RetornaSQLReplace(ANomeTabela: String;
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

class function TSicrediFuncoes.SafeFilePath(const FilePath: string): Boolean;
var
  MaxPathLength: Integer;
  FileAttr: Cardinal;
begin
  Result := False;
  MaxPathLength := 255;

  try
    if not TryDirectoryExists(FilePath) then
    begin
      TSicrediFuncoes.fMensagem('ATENÇÃO','O caminho: ' + FilePath + ' não existe!',['&OK']);
      Exit;
    end;

    if Length(FilePath) > MaxPathLength then
    begin
      TSicrediFuncoes.fMensagem('ATENÇÃO','O caminho: ' + FilePath + ' é muito longo.',['&OK']);
      Exit;
    end;

    FileAttr := GetFileAttributes(PChar(FilePath));
    if (FileAttr = INVALID_FILE_ATTRIBUTES) then
    begin
      TSicrediFuncoes.fMensagem('ATENÇÃO','Você não tem permissão para acessar caminho: ' + FilePath + '',['&OK']);
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

class procedure TSicrediFuncoes.SalvaCaminhoPastaDosArquivos(ACaminhoArquivos: String);
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

class procedure TSicrediFuncoes.VerificaEstrutraTabelas(ALayoutArquivo: Boolean);
begin
  If Not fTabelaExiste('ARQCON') Then
    ExecutaSQL(RetornaEstruturaTabelaCaminhoArquivo);

  ImportarCaminhoPastaDosArquivos;
end;

initialization

end.
