unit untTRedeCardFuncoes;

interface

uses System.StrUtils, System.SysUtils, System.Variants, WinApi.Windows,
     System.Classes, Vcl.Dialogs, Vcl.StdActns, Vcl.StdCtrls,
     Vcl.Forms, System.ZLib, System.Win.Registry, System.Hash,
     System.IOUtils, WinApi.ShellAPI, WinApi.ShlObj, Data.DB,
     System.Rtti, Vcl.Themes, Vcl.Styles, Vcl.SysStyles, System.DateUtils,
     System.Json, REST.Json, Vcl.DBCtrls, Vcl.Mask, Vcl.Controls,
     Winapi.Messages, WinApi.PsAPI,

     untIRedeCardIntegracaoLibCartoes, untRedeCardTipos, untLibCartoesInterfacesTipos,
     untILibCartoesWrapper, untTLibCartoesFuncoes,

     frxExportPDF, frxClass, frxPreview, IdCompressorZlib, dxCore, EditFocus,
     Uni, cxCheckComboBox, cxDropDownEdit, cxCalendar;

Type
  TRedeCardFuncoes = class(TLibCartoesFuncoes)
  private
    class function RetornaEstruturaTabelaCaminhoArquivo: String;
    class procedure ImportarCaminhoPastaDosArquivos;
    class function RetornaCaminhoPastaDosArquivos:String;
    class procedure SalvaCaminhoPastaDosArquivos(ACaminhoArquivos:String);

    class function fRetornaVersao(strNomArq: String = ''): String;
  public
    class function PrettyJSON(JsonString:String):String;
    class function RetornaCampoDecimalJSON(AValor: String): String;

    class procedure pEnabled(NomeForm:TForm;Habilitar:Boolean);
    class procedure Aguarde(msecs: Integer);
    class function fGetMenu(strTitulo: String;
                            arrOpcoes: Array Of String;
                            intOpcao: Integer;
                            blnSaiComEsc: Boolean = False;
                            blnLibQtd: Boolean = False;
                            intWidth: Integer = 0): Integer;

    class procedure CarregaEstiloAutcom;

    class procedure ValidaLibsWebService;

    class function fArquivoFolder(ASalvar: Boolean = False): String;
    class function SafeFilePath(const FilePath: string): Boolean;
    class procedure pRenomeiaAquivo(strNomVel, strNomNov: String);

    class function RetornaSQLReplace(ANomeTabela: String;
                                     ACamposIgnorados: Array of String): String;

    class function MetodoExisteNaInterface(AInstancia: IInterface; ANomeMetodo: string): Boolean;

    class procedure GravarEstabelecimentos(ALayoutAPI: Boolean = False);

    class function RetornaNomeEmpresaEstabelecimento(ACodEmp: String): String;
    class function RetornadoEstabelecimentoSelecionado(AEstabelecimentos:String):String;

    class procedure pExibirRelatorio(strNomPro, strDesPro: String; AReport: IReport);

    class procedure VerificaEstrutraTabelas(ALayoutArquivo: Boolean);

    class function fIPesqEmpresa(ASelf    : TForm;                           {* Formulário                                  *}
                                 edtCodigo: TCustomEdit;                     {* Edit do Código                              *}
                                 edtNomEmp: TEditFocus;                      {* Edit do Nome da Empresa                     *}
                                 Var chrKey: Char): Boolean;


    class procedure ImportarCartoesArquivo(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String);

    class procedure ImportarCartoesAPI(AAplicacao: HWND; ANomeEmpresa: String);
  end;

Var
  VS_FuncoesExternas: ILibCartoes;

  VS_PastaConciliacao,
  VS_PastaAutcom: String;

  VS_ListaEstabelecimentos: TStringList;

  VS_AutcomModoClassico: Boolean;

  VS_TimeZone: Integer;

Implementation
Uses untRedeCredito, untRedeDebito, untRedeCard, untRedeCardAPI,
     untRedeCardAPIPgto, untLibCartoesGetMenu;
{ TRedeCardFuncoes }

class procedure TRedeCardFuncoes.Aguarde(msecs: Integer);
  var
    FirstTickCount: LongInt;
begin
  FirstTickCount := GetTickCount;
  repeat
    Application.ProcessMessages;
  until ((LongInt(GetTickCount) - LongInt(FirstTickCount)) >= LongInt(msecs));
end;

class procedure TRedeCardFuncoes.CarregaEstiloAutcom;
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

class function TRedeCardFuncoes.fArquivoFolder(ASalvar: Boolean): String;
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

class function TRedeCardFuncoes.fGetMenu(strTitulo: String;
  arrOpcoes: array of String; intOpcao: Integer; blnSaiComEsc,
  blnLibQtd: Boolean; intWidth: Integer): Integer;
  Var
    LGetMenu: TfrmLibCartoesGetMenu;

    intContador: Integer;
begin

  Result := -1;
  If (Not blnLibQtd) And (Length(arrOpcoes) <= 1) Then
  Begin
    fMensagem('', 'É Necessário escolher ao menos 2 opções', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmLibCartoesGetMenu, LGetMenu);
    SetLength(LGetMenu.arrOpcoes, Length(arrOpcoes));

    For intContador := 0 To Length(arrOpcoes)-1 Do
    Begin
      LGetMenu.arrOpcoes[intContador] := arrOpcoes[intContador];
    End;

    If intOpcao <= 0 Then
      intOpcao := 1;

    Dec(intOpcao);

    LGetMenu.intLinha     := intOpcao;
    LGetMenu.blnSaiComEsc := blnSaiComEsc;
    LGetMenu.Caption      := strTitulo;

    If intWidth > 0 Then
    Begin
      LGetMenu.Width         := LGetMenu.Width + intWidth;
      LGetMenu.stgMenu.Width := LGetMenu.Width;
      LGetMenu.stgMenu.DefaultColWidth := LGetMenu.Width;
    End;

    LGetMenu.showModal;

    If LGetMenu.blnConfirma Then
    Begin
      Result := LGetMenu.intLinha+1;
    End;

  Except
    On E: Exception Do
    Begin
      Result := -1;
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[untFuncoes.fGetMenu]');
    End;
  End;

  FreeAndNil(LGetMenu);
end;

class function TRedeCardFuncoes.fIPesqEmpresa(ASelf: TForm;
  edtCodigo: TCustomEdit; edtNomEmp: TEditFocus; var chrKey: Char): Boolean;
  Var
    arrEmp: TConsultasArray;
begin
  Result := True;

  If MetodoExisteNaInterface(VS_FuncoesExternas, 'fIPesqEmpresa') Then
    Result := VS_FuncoesExternas.fIPesqEmpresa(conEmpSimples, ASelf, edtCodigo, edtNomEmp,Nil, chrKey, arrEmp);
end;

class function TRedeCardFuncoes.fRetornaVersao(strNomArq: String): String;
  var
    _Size: DWORD;
    _VerInfo: Pointer;
    _ValueSize: DWORD;
    _Value: PVSFixedFileInfo;
    _Dummy: DWORD;
    _V1, _V2, _V3, _V4: Word;
begin
  Result := '';

  If (fEmptyStr(strNomArq)) Then
    strNomArq := Application.ExeName;

  If (Not FileExists(strNomArq)) Then
    Exit;

  _Size := GetFileVersionInfoSize(PChar(strNomArq), _Dummy) ;
  GetMem(_VerInfo, _Size);
  GetFileVersionInfo(PChar(strNomArq), 0, _Size, _VerInfo);
  VerQueryValue(_VerInfo, '\', Pointer(_Value), _ValueSize);
  with _Value^ do
  begin
    _V1 := dwFileVersionMS shr 16;
    _V2 := dwFileVersionMS and $FFFF;
    _V3 := dwFileVersionLS shr 16;
    _V4 := dwFileVersionLS and $FFFF;
  end;
  FreeMem(_VerInfo, _Size);
  Result := Copy(IntToStr(100 + _V1), 3, 2) + '.' +
    Copy(IntToStr(100 + _V2), 3, 2) + '.' +
    Copy(IntToStr(100 + _V3), 3, 2) + '.' +
    Copy(IntToStr(100 + _V4), 3, 2);

  //https://www.devmedia.com.br/
end;

class procedure TRedeCardFuncoes.GravarEstabelecimentos(ALayoutAPI: Boolean = False);
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
    FreeAndNilDatasets(LGravacao);
    VS_ListaEstabelecimentos.Clear;
  End;
end;

class procedure TRedeCardFuncoes.ImportarCaminhoPastaDosArquivos;
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
    On E:Exception Do
    Begin
      { se não conseguir importar não faz nada, não pode parar a rotina }
    End;
  End;
end;

class procedure TRedeCardFuncoes.ImportarCartoesAPI(AAplicacao: HWND;
  ANomeEmpresa: String);
  Var
    LRedeCardAPI: TRedeCardAPI;
Begin
  LRedeCardAPI := TRedeCardAPI.Create(Nil);
  Try
    LRedeCardAPI.Aplicacao := AAplicacao;
    LRedeCardAPI.pSelecionaFonte;
  Finally
    FreeAndNil(LRedeCardAPI);
  End;
end;

class procedure TRedeCardFuncoes.ImportarCartoesArquivo(AAplicacao: HWND;
  APastaAutcom, ANomeEmpresa: String);
  Var
    LImportacao: TRedeCard;
Begin
  LImportacao := TRedeCard.Create(Application);
  Try
    LImportacao.Aplicacao := AAplicacao;
    LImportacao.strNomEmp := ANomeEmpresa;
    LImportacao.Empresa := LeftStr(ANomeEmpresa,3);
    LImportacao.SelecionarArquivos := False;
    VS_PastaAutcom := APastaAutcom;
    LImportacao.pSelecionaFonte;
  Finally
    FreeAndNil(LImportacao);
  End;
end;

class function TRedeCardFuncoes.MetodoExisteNaInterface(AInstancia: IInterface;
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

class procedure TRedeCardFuncoes.pEnabled(NomeForm: TForm; Habilitar: Boolean);
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

class procedure TRedeCardFuncoes.pExibirRelatorio(strNomPro, strDesPro: String; AReport: IReport);
begin
  If MetodoExisteNaInterface(VS_FuncoesExternas, 'pIExibirRelatorio') Then
  Begin
    VS_FuncoesExternas.pIExibirRelatorio(strNomPro, strDesPro, AReport);
    Exit;
  End;

  AReport.ShowReport;
end;

class procedure TRedeCardFuncoes.pRenomeiaAquivo(strNomVel, strNomNov: String);
begin
  RenameFile(strNomVel, strNomNov);
end;

class function TRedeCardFuncoes.PrettyJSON(JsonString: String): String;
  Var
    Jdoc:TJSONObject;
begin
  Try
    Jdoc:=TJSONObject.ParseJSONValue(JsonString) as TJSONObject;
    result:= TJSON.Format(Jdoc);
  Finally
    FreeAndNil(Jdoc);
  End;
end;

class function TRedeCardFuncoes.RetornaCaminhoPastaDosArquivos: String;
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

class function TRedeCardFuncoes.RetornaCampoDecimalJSON(AValor: String): String;
begin
  Result := AValor.Replace('.', EmptyStr);
  Result := Result.Replace(',', '.');
end;

class function TRedeCardFuncoes.RetornadoEstabelecimentoSelecionado(
  AEstabelecimentos: String): String;
  Var
    LEstabelecimento: String;

    LListaEstab: TStringList;
    LContador: Integer;
    arrEstabelecimentos  : TStringArray;
    LSelecionado: Integer;
begin

  LListaEstab := TStringList.Create;
  LListaEstab.Delimiter := ',';
  LListaEstab.StrictDelimiter := True;
  LListaEstab.DelimitedText := AEstabelecimentos;
  LContador := 0;

  For LEstabelecimento In LListaEstab Do
  Begin
    SetLength(arrEstabelecimentos, Length(arrEstabelecimentos)+1);
    arrEstabelecimentos[LContador] :=LEstabelecimento;
    Inc(LContador);
  End;

  If (Length(arrEstabelecimentos) > 1) Then
  Begin
    LSelecionado := fGetMenu('Selecione o estabelecimento', arrEstabelecimentos, 0, True);

    If LSelecionado <> -1 Then
    Begin
      Result := arrEstabelecimentos[LSelecionado-1];
    End;
  End
  Else
    Result := AEstabelecimentos;
end;

class function TRedeCardFuncoes.RetornaEstruturaTabelaCaminhoArquivo: String;
begin
  Result := 'CREATE TABLE ARQCON(                 '+
            '  ARQ_NOMCON VARCHAR(100) NOT NULL,  '+
            '  ARQ_CAMARQ TEXT DEFAULT NULL,      '+
            'PRIMARY KEY(ARQ_NOMCON)              '+
            ') ENGINE=INNODB                      ';
end;

class function TRedeCardFuncoes.RetornaNomeEmpresaEstabelecimento(
  ACodEmp: String): String;
  Var
    qryDados: TUniQuery;
Begin
  qryDados := VS_FuncoesExternas.fICriaQuery;
  Try
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
    qryDados.Close;
    FreeAndNil(qryDados);
  End;
End;

class function TRedeCardFuncoes.RetornaSQLReplace(ANomeTabela: String;
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

class function TRedeCardFuncoes.SafeFilePath(const FilePath: string): Boolean;
  var
    MaxPathLength: Integer;
    FileAttr: Cardinal;
begin
  Result := False;
  MaxPathLength := 255; // Limite padrão do Windows

  try
    // Verifica se o caminho é válido e se existe
    if not TryDirectoryExists(FilePath) then
    begin
      fMensagem('ATENÇÃO','O caminho: ' + FilePath + ' não existe!',['&OK']);
      Exit;
    end;

    // Verifica se o caminho é muito longo
    if Length(FilePath) > MaxPathLength then
    begin
      fMensagem('ATENÇÃO','O caminho: ' + FilePath + ' é muito longo.',['&OK']);
      Exit;
    end;

    // Verifica permissões de acesso
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

class procedure TRedeCardFuncoes.SalvaCaminhoPastaDosArquivos(ACaminhoArquivos: String);
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
    FreeAndNilDataSets(LInserir);
  End;
end;

class procedure TRedeCardFuncoes.ValidaLibsWebService;
begin
  if fEmptyStr(fRetornaVersao(ExtractFilePath(Application.ExeName) + 'ssleay32.dll')) then
    raise Exception.Create('O arquivo ssleay32.dll não foi encontrado.' + #13 +
                           'Entre em contato com a Citel para realizar a atualização do arquivo.')
  Else if fEmptyStr(fRetornaVersao(ExtractFilePath(Application.ExeName) + 'libeay32.dll')) then
    raise Exception.Create('O arquivo libeay32.dll não foi encontrado.' + #13 +
                           'Entre em contato com a Citel para realizar a atualização do arquivo.')
  Else If fRetornaVersao(ExtractFilePath(Application.ExeName) + 'libeay32.dll') = '0.9.8.6' then
    raise Exception.Create('A versão do arquivo libeay32.dll está desatualizada.' + #13 +
                           'Entre em contato com a Citel para realizar a atualização do arquivo.');
end;

class procedure TRedeCardFuncoes.VerificaEstrutraTabelas(ALayoutArquivo: Boolean);
begin
  If Not fTabelaExiste('ARQCON') Then
    ExecutaSQL(RetornaEstruturaTabelaCaminhoArquivo);

  ImportarCaminhoPastaDosArquivos;

  If ALayoutArquivo Then
  Begin
    If Not fTabelaExiste('RED_EVDR05') Then
    Begin
      ExecutaSQL(TRedeDebito.fRetSQLTabelaReg5);

      If Not fTabelaExiste('RED_EVCR06') Then
        ExecutaSQL(TRedeCredito.fRetSQLTabelaReg6);

      If Not fTabelaExiste('RED_EVCR08') Then
        ExecutaSQL(TRedeCredito.fRetSQLTabelaReg8);

      If Not fTabelaExiste('RED_EVCR10') Then
        ExecutaSQL(TRedeCredito.fRetSQLTabelaReg10);

      If Not fTabelaExiste('RED_EVCR12') Then
        ExecutaSQL(TRedeCredito.fRetSQLTabelaReg12);

      If Not fTabelaExiste('RED_EVCR14') Then
        ExecutaSQL(TRedeCredito.fRetSQLTabelaReg14);

      If Not fTabelaExiste('RED_EFIR34') Then
        ExecutaSQL(TRedeCredito.fRetSQLTabelaReg34);
    End;

    Exit;
  End;

  If Not fTabelaExiste('RED_APPGTO') Then
  Begin
    ExecutaSQL(TRedeCardAPIPgto.fRetSQLTabelaRegPgto('RED_APPGTO'));

    If Not fTabelaExiste('RED_PGODIR') Then
      ExecutaSQL(TRedeCardAPIPgto.fRetSQLTabelaRegPgto('RED_PGODIR'));

    If Not fTabelaExiste('RED_APVEND') Then
      ExecutaSQL(TRedeCardAPIPgto.fRetSQLTabelaRegPgto('RED_APVEND'));

    If Not fTabelaExiste('RED_APVPAR') Then
      ExecutaSQL(TRedeCardAPIPgto.fRetSQLTabelaRegPgto('RED_APVPAR'));

    If Not fTabelaExiste('RED_APAJUS') Then
      ExecutaSQL(TRedeCardAPIPgto.fRetSQLTabelaRegPgto('RED_APAJUS'));
  End;
end;

initialization

end.
