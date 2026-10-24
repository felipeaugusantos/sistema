unit untTMobbuyFuncoes;

interface

uses System.StrUtils, System.SysUtils, System.Variants, WinApi.Windows,
     System.Classes, Vcl.Dialogs, Vcl.StdActns, Vcl.StdCtrls,
     Vcl.Forms, System.ZLib, System.Win.Registry, System.Hash,
     System.IOUtils, WinApi.ShellAPI, WinApi.ShlObj, Data.DB,
     System.Rtti, Vcl.Themes, Vcl.Styles, Vcl.SysStyles, System.DateUtils,
     System.Json, REST.Json, Vcl.DBCtrls, Vcl.Mask, Vcl.Controls,
     Winapi.Messages, WinApi.PsAPI,

     untIMobbuyIntegracaoLibCartoes, untMobbuyTipos, untLibCartoesInterfacesTipos,
     untILibCartoesWrapper, untTLibCartoesFuncoes,

     frxExportPDF, frxClass, frxPreview, IdCompressorZlib, dxCore, EditFocus,
     Uni, cxCheckComboBox, cxDropDownEdit, cxCalendar;

Type
  TMobbuyFuncoes = class(TLibCartoesFuncoes)
  private
    class function fRetornaVersao(strNomArq: String = ''): String;
  public
    class procedure CarregaEstiloAutcom;

    class procedure ValidaLibsWebService;

    class function RetornaSQLReplace(ANomeTabela: String;
                                     ACamposIgnorados: Array of String): String;

    class procedure GravarEstabelecimentos(ALayoutAPI: Boolean = False);

    class procedure VerificaEstrutraTabelas(ALayoutArquivo: Boolean);

    class procedure ImportarCartoesAPI(AAplicacao: HWND; ANomeEmpresa: String);
  end;

Var
  VS_FuncoesExternas: ILibCartoes;
  VS_PastaAutcom: String;
  VS_PastaConciliacao : TStringList;


  VS_ListaEstabelecimentos: TStringList;

  VS_AutcomModoClassico: Boolean;

  VS_TimeZone: Integer;

Implementation

Uses
  untLibCartoesGetMenu,untMobbuyAPIPgto,untMobbuyAPI ;

{ TMobbuyFuncoes }

class procedure TMobbuyFuncoes.CarregaEstiloAutcom;
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

class function TmobbuyFuncoes.fRetornaVersao(strNomArq: String): String;
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

end;

class procedure TMobbuyFuncoes.GravarEstabelecimentos(ALayoutAPI: Boolean = False);
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

  LGravacao := nIL;
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

    VS_ListaEstabelecimentos.Clear;
  Finally
    FreeAndNilDatasets(LGravacao);
  End;
end;

class procedure TMobbuyFuncoes.ImportarCartoesAPI(AAplicacao: HWND;
  ANomeEmpresa: String);
  Var
    LMobbuyAPI: TMobbuyAPI;
Begin
  LMobbuyAPI := TMobbuyAPI.Create(Nil);
  Try
    VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(False);
    LMobbuyAPI.Aplicacao := AAplicacao;
    LMobbuyAPI.pSelecionaFonte;
  Finally
    VS_FuncoesExternas.pIModificaStatusTimerTemMensagemPrincipal(True);
    FreeAndNil(LMobbuyAPI);
  End;
end;

class function TMobbuyFuncoes.RetornaSQLReplace(ANomeTabela: String;
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

class procedure TMobbuyFuncoes.ValidaLibsWebService;
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

class procedure TMobbuyFuncoes.VerificaEstrutraTabelas(ALayoutArquivo: Boolean);
begin
  if not fTabelaExiste('MOB_APPGTO') then
    ExecutaSQL(TMobbuyAPIPgto.fRetSQLTabelaRegPgto('MOB_APPGTO')); //(pagamentos/baixas)

  if not fTabelaExiste('MOB_APVEND') then
    ExecutaSQL(TMobbuyAPIPgto.fRetSQLTabelaRegPgto('MOB_APVEND'));  //(vendas / aprovações de venda)

  if not fTabelaExiste('MOB_APVPAR') then                // se houver tratamento distinto
    ExecutaSQL(TMobbuyAPIPgto.fRetSQLTabelaRegPgto('MOB_APVPAR'));  //(vendas parceladas, se separar por convenção)

  if not fTabelaExiste('MOB_APAJUS') then                // ajustes
    ExecutaSQL(TMobbuyAPIPgto.fRetSQLTabelaRegPgto('MOB_APAJUS'));
end;

initialization

end.
