unit untFuncoesConsulta;

interface

uses
     untTypesSistema,
     System.IniFiles,
     {$IFDEF MSWINDOWS}
     untClassPanelCx,
     UniClientDataSet,
     Winapi.Windows,
     MaskEditFocus,
     Vcl.StdCtrls,
     EditFocus,
     {$ENDIF}
     SysUtils,
     StrUtils,
     IoUtils,
     Uni;

type
  TTipoConsulta = (tpcVazio, tcpPrimeira, tcpOrdemFiltro);
  {$IFDEF MSWINDOWS}
  TGenericProcedureWithClientParam = procedure(cdsConsulta: TUniClientDataSet);

  function fConsulta(arrSql,
                     arrCampos,
                     arrOrdenacao: Array Of String;
                     strCampoChave,
                     strTabela,
                     strNomForm,
                     strTitulo: String;
                     qryAux: TUniQuery;
                     objFrmPnl: TPanelCx;
                     blnSimples: Boolean;
                     Var arrSelec: TConsultasArray;
                     strCodBusca: String = 'AUTOINCREM';
                     objConsulta: Pointer = Nil;
                     blnTablet: Boolean = False;
                     blnConIte: Boolean = False;
                     strCampoChave2 : String = '';
                     pAfterAtualiza: TGenericProcedureWithClientParam = Nil;
                     blnRefresh: Boolean = True;
                     blnConfirma: boolean = True;
                     blnConCon: Boolean = True;
                     fChamaCadastro : TBooleanFunctionWithBooleanParam = Nil;
                     objPnlBanner: TPanelCx = Nil): Boolean;


  function fConsultaNova(arrSql,
                         arrCampos,
                         arrOrdenacao: array of string;
                         strCampoChave,
                         strTabela,
                         strNomForm,
                         strTitulo: string;
                         qryAux: TUniQuery;
                         objFrmPnl: TPanelCx;
                         blnSimples: boolean;
                         var arrSelec: TConsultasArray;
                         strCodBusca: string = 'AUTOINCREM';
                         objConsulta: Pointer = nil;
                         blnTablet: Boolean = false;
                         blnConIte: Boolean = false;
                         strCampoChave2: string = '';
                         pAfterAtualiza: TGenericProcedureWithClientParam = nil;
                         blnRefresh: boolean = true;
                         blnConfirma: boolean = true;
                         blnConCon: Boolean = true): boolean;
  {$ENDIF}

  function fStrLocateLinGru(arrLinha: TConsultasArray; strNomCampo,
    strNomPar: String; blnSemAND: Boolean = False; blnNegar: Boolean = False;
    strCodigo: String = ''; blnAndFinal: Boolean = False): String;
  function fStrLocateLinGruCodigo(arrLinha: TConsultasArray): String;

  {$IFDEF MSWINDOWS}
  function fConsultaComConfiguracaoNova(arrSql,
                                        arrCampos,
                                        arrOrdenacao: Array Of String;
                                        strCampoChave,
                                        strTabela,
                                        strNomForm,
                                        strTitulo: String;
                                        qryAux: TUniQuery;
                                        objFrmPnl: TPanelCx;
                                        blnSimples: Boolean;
                                        Var arrSelec: TConsultasArray;
                                        strCodBusca: String = 'AUTOINCREM';
                                        objConsulta: Pointer = Nil;
                                        blnTablet: Boolean = False;
                                        blnConIte: Boolean = False;
                                        strCampoChave2 : String = '';
                                        pAfterAtualiza: TGenericProcedureWithClientParam = Nil;
                                        blnRefresh : Boolean = True;
                                        blnConfirma: boolean = True;
                                        blnConCon: Boolean = True;
                                        fChamaCadastro : TBooleanFunctionWithBooleanParam = Nil;
                                        objPnlBanner: TPanelCx = Nil): Boolean;
  {$ENDIF}

  function fStrSQLOR(strCampo : String;
                     strParam : String;
                     arrLinha : TConsultasArray;
                     blnSemAND: Boolean = True;
                     blnNegar : Boolean = False): String;

  procedure pSetaParamOR(arrLinha : TConsultasArray;
                         strParam : String;
                         qryTabela: TUniQuery);

  function fGetPathTempOpcoesLocais: String;

implementation

uses
  {$IFDEF MSWINDOWS}
  untConsultaCxGridNova,
  {$ENDIF}
  untFuncoes;

{$IFDEF MSWINDOWS}
function fConsulta(arrSql,
                   arrCampos,
                   arrOrdenacao: Array Of String;
                   strCampoChave,
                   strTabela,
                   strNomForm,
                   strTitulo: String;
                   qryAux: TUniQuery;
                   objFrmPnl: TPanelCx;
                   blnSimples: Boolean;
                   Var arrSelec: TConsultasArray;
                   strCodBusca: String = 'AUTOINCREM';
                   objConsulta: Pointer = Nil;
                   blnTablet: Boolean = False;
                   blnConIte: Boolean = False;
                   strCampoChave2 : String = '';
                   pAfterAtualiza: TGenericProcedureWithClientParam = Nil;
                   blnRefresh: Boolean = True;
                   blnConfirma: boolean = True;
                   blnConCon: Boolean = True;
                   fChamaCadastro : TBooleanFunctionWithBooleanParam = Nil;
                   objPnlBanner: TPanelCx = Nil): Boolean;
Begin

  Try
    If fEmptyStr(strCampoChave) Then
      strCampoChave := 'AUTOINCREM';

    If fEmptyStr(strCampoChave2) Then
      strCampoChave2 := strCampoChave;

    If Not blnTablet Then
    Begin
      Result := fConsultaComConfiguracaoNova(arrSql,
                                             arrCampos,
                                             arrOrdenacao,
                                             strCampoChave,
                                             strTabela,
                                             strNomForm,
                                             strTitulo,
                                             qryAux,
                                             objFrmPnl,
                                             blnSimples,
                                             arrSelec,
                                             strCodBusca,
                                             objConsulta,
                                             blnTablet,
                                             blnConIte,
                                             strCampoChave2,
                                             pAfterAtualiza,
                                             blnRefresh,
                                             blnConfirma,
                                             blnConCon,
                                             fChamaCadastro,
                                             objPnlBanner);

    End

    Else Result := False;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pErro(E.Message);
    End;
  End;
End;

function fConsultaNova(arrSql,
                       arrCampos,
                       arrOrdenacao: array of string;
                       strCampoChave,
                       strTabela,
                       strNomForm,
                       strTitulo: string;
                       qryAux: TUniQuery;
                       objFrmPnl: TPanelCx;
                       blnSimples: Boolean;
                       var arrSelec: TConsultasArray;
                       strCodBusca: string = 'AUTOINCREM';
                       objConsulta: Pointer = nil;
                       blnTablet: Boolean = false;
                       blnConIte: Boolean = false;
                       strCampoChave2 : string = '';
                       pAfterAtualiza: TGenericProcedureWithClientParam = nil;
                       blnRefresh: Boolean = true;
                       blnConfirma: boolean = true;
                       blnConCon: Boolean = true): boolean;
begin
  try
    if fEmptyStr(strCampoChave) then
      strCampoChave := 'AUTOINCREM';

    if fEmptyStr(strCampoChave2) then
      strCampoChave2 := strCampoChave;

    if not blnTablet then
    begin
      Result := fConsultaComConfiguracaoNova(arrSql,
                                             arrCampos,
                                             arrOrdenacao,
                                             strCampoChave,
                                             strTabela,
                                             strNomForm,
                                             strTitulo,
                                             qryAux,
                                             objFrmPnl,
                                             blnSimples,
                                             arrSelec,
                                             strCodBusca,
                                             objConsulta,
                                             blnTablet,
                                             blnConIte,
                                             strCampoChave2,
                                             pAfterAtualiza,
                                             blnRefresh,
                                             blnConfirma,
                                             blnConCon);

    end
    else
      Result := False;
  except
    on E: Exception do
    begin
      Result := False;
      pErro(E.Message);
    end;
  end;
End;
{$ENDIF}

function fStrLocateLinGru(arrLinha: TConsultasArray; strNomCampo,
  strNomPar: String; blnSemAND: Boolean = False; blnNegar: Boolean = False;
  strCodigo: String = ''; blnAndFinal: Boolean = False): String;
  var
    intContador: Integer;
Begin
  Result := '';

  if Length(arrLinha) > 1 then
  begin
    Result := '(';
    for intContador := Low(arrLinha) To High(arrLinha) do
    begin
      if Length(arrLinha[intContador].strCodigo) = 4 then
      begin
        if RightStr(arrLinha[intContador].strCodigo, 3) = '00' then
          Result := Result + ' (LEFT(' + strNomCampo + ', 2) = ' +  QuotedStr(LeftStr(arrLinha[intContador].strCodigo, 2)) + ') '
        else
          Result := Result + ' (' + strNomCampo + ' = ' + QuotedStr(arrLinha[intContador].strCodigo) + ') ';

        if intContador <> High(arrLinha) Then
          Result := Result + ' OR ';
      end
      else
      begin
        if RightStr(arrLinha[intContador].strCodigo, 3) = '000' then
          Result := Result + ' (LEFT(' + strNomCampo + ', 3) = ' +  QuotedStr(LeftStr(arrLinha[intContador].strCodigo, 3)) + ') '
        else
          Result := Result + ' (' + strNomCampo + ' = ' + QuotedStr(arrLinha[intContador].strCodigo) + ') ';

        if intContador <> High(arrLinha) Then
          Result := Result + ' OR ';
      end;
    end;

    Result := Result + ' ) ';
  end
  else
  begin
    if Length(arrLinha[0].strCodigo) = 4 then
    begin
      if RightStr(arrLinha[0].strCodigo, 2) = '00' then
        Result := Result + ' (LEFT(' + strNomCampo + ', 2) = LEFT(:' + strNomPar + ', 2)) '
      else
        Result := Result + strNomCampo + ' = :' + strNomPar + ' ';
    end
    else
    begin
      if RightStr(arrLinha[0].strCodigo, 3) = '000' then
        Result := Result + ' (LEFT(' + strNomCampo + ', 3) = LEFT(:' + strNomPar + ', 3)) '
      else
        Result := Result + strNomCampo + ' = :' + strNomPar + ' ';
    end;

  end;

  if blnNegar then
    Result := ' (NOT ( ' + Result + ' )) ';

  if (not blnSemAND) and (not fEmptyStr(Result)) then
  begin
    if blnAndFinal then
      Result :=  Result + '  AND '
    else
      Result := '  AND ' + Result;
  end;
End;

function fStrLocateLinGruCodigo(arrLinha: TConsultasArray): String;
  var
    intContador: Integer;
Begin
  Result := '';

  if Length(arrLinha) > 1 then
  begin
    for intContador := Low(arrLinha) To High(arrLinha) do
    begin
      if Length(arrLinha[intContador].strCodigo) = 4 then
      begin
        if RightStr(arrLinha[intContador].strCodigo, 3) = '00' then
          Result := Result + LeftStr(arrLinha[intContador].strCodigo, 2) + ', '
        else
          Result := Result + arrLinha[intContador].strCodigo + ', ';
      end
      else
      begin
        if RightStr(arrLinha[intContador].strCodigo, 3) = '000' then
          Result := Result + LeftStr(arrLinha[intContador].strCodigo, 3) + ', '
        else
          Result := Result + arrLinha[intContador].strCodigo + ', ';
      end;
    end;

    Result := Copy(Result, 0, length(Result)-2) + '.';
  end;
End;

{$IFDEF MSWINDOWS}
function fConsultaComConfiguracaoNova(arrSql,
                                      arrCampos,
                                      arrOrdenacao: Array Of String;
                                      strCampoChave,
                                      strTabela,
                                      strNomForm,
                                      strTitulo: String;
                                      qryAux: TUniQuery;
                                      objFrmPnl: TPanelCx;
                                      blnSimples: Boolean;
                                      Var arrSelec: TConsultasArray;
                                      strCodBusca: String = 'AUTOINCREM';
                                      objConsulta: Pointer = Nil;
                                      blnTablet: Boolean = False;
                                      blnConIte: Boolean = False;
                                      strCampoChave2 : String = '';
                                      pAfterAtualiza: TGenericProcedureWithClientParam = Nil;
                                      blnRefresh : Boolean = True;
                                      blnConfirma: Boolean = True;
                                      blnConCon: Boolean = True;
                                      fChamaCadastro : TBooleanFunctionWithBooleanParam = Nil;
                                      objPnlBanner: TPanelCx = Nil): Boolean;
  Var
    intCon  : Integer;
    strSimilar,
    strSQLRetorno: String;
    frmConsulta: TfrmConsultaCxGridNova;
Begin
  pCriarFormularios(TfrmConsultaCxGridNova, frmConsulta);

  frmConsulta.pAfterAtualiza := pAfterAtualiza;
  frmConsulta.strNomForm  := Trim(strNomForm);
  frmConsulta.strCodBusca := Trim(strCodBusca);
  frmConsulta.Caption     := Trim(strTitulo);
  frmConsulta.strTitPesq  := Trim(strTitulo);
  frmConsulta.blnSimples  := blnSimples;
  frmConsulta.objConsulta := objConsulta;
  frmConsulta.blnRefresh  := blnRefresh;

  frmConsulta.pSetaOrdenacao(arrOrdenacao);
  frmConsulta.pSetaCampos(arrCampos);
  frmConsulta.pSetaSql(arrSQL);

  frmConsulta.objFrmPnl    := objFrmPnl;
  frmConsulta.objPnlBanner := objPnlBanner;

  frmConsulta.btnConfirma.Visible := blnConfirma;

  frmConsulta.blnConCon := blnConCon;
  frmConsulta.fChamaCadastro := Nil;
  If Assigned(fChamaCadastro) Then
    frmConsulta.fChamaCadastro := @fChamaCadastro;

  frmConsulta.ShowModal;

  Result := frmConsulta.blnConfirma;

  If Assigned(frmConsulta.objFrmPnl) Then
    frmConsulta.objFrmPnl.pRetornaValores(frmConsulta.cdsConsulta);

  {***************************}
  {* SIMPLES OU NAO TEM QUE  *}
  {* PEGAR SELEÇÃO DO ARRAY  *}
  {************************NC*}
  SetLength(arrSelec, 0);
  For intCon := 0 To Length(frmConsulta.arrCodSel) - 1 do
  Begin
    SetLength(arrSelec, Length(arrSelec) + 1);
    arrSelec[Length(arrSelec) - 1].strCodigo := frmConsulta.arrCodSel[intCon];
  End;

  strSimilar := '';
  If Assigned(frmConsulta.objFrmPnl) And
     Assigned(frmConsulta.objFrmPnl.frmPanel) Then
  Begin
    strSimilar := frmConsulta.objFrmPnl.strSimilar;
    frmConsulta.objFrmPnl.frmPanel.Close;
    frmConsulta.objFrmPnl.frmPanel.ManualDock(Nil);
    FreeAndNil(frmConsulta.objFrmPnl.frmPanel);
  End;

  If Result Then
  Begin
    strSQLRetorno := 'SELECT * FROM ' + Trim(strTabela);

    If Assigned(objConsulta) And (Not fEmptyStr(TDefConsulta(objConsulta).strSQLRetorno)) Then
      strSQLRetorno := TDefConsulta(objConsulta).strSQLRetorno;

    If blnSimples Then
    Begin
      qryAux.Close;
      qryAux.Fields.Clear;
      qryAux.FieldDefs.Clear;
      qryAux.SQL.Clear;

      qryAux.SQL.Add(strSQLRetorno + ' WHERE ' + strTabela + '.' + Trim(strCampoChave2) + ' = :CHAVE');

      If (strSimilar <> '') Then
         qryAux.ParamByName('CHAVE').AsString := strSimilar
      Else
        qryAux.ParamByName('CHAVE').AsString := frmConsulta.cdsConsulta.FieldByName(Trim(strCampoChave)).AsString;

      qryAux.Open;
    End
    Else
    Begin
      qryAux.Close;
      qryAux.Fields.Clear;
      qryAux.FieldDefs.Clear;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(strSQLRetorno + ' WHERE ');
      If Length(arrSelec) = 0  Then
        qryAux.SQL.Add('FALSE ')
      Else
      Begin
        qryAux.SQL.Add(fStrSQLOR(Trim(strCodBusca), Trim(strCodBusca), arrSelec));
        pSetaParamOR(arrSelec, Trim(strCodBusca), qryAux);
      End;
      qryAux.Open;
    End;
  End;
  pFreeAndNil(frmConsulta);
End;
{$ENDIF}
function fStrSQLOR(strCampo : String;
                   strParam : String;
                   arrLinha : TConsultasArray;
                   blnSemAND: Boolean = True;
                   blnNegar : Boolean = False): String;
  Var
    intCon: Integer;
begin
  Result := '';

  If blnNegar Then
    Result := Result + ' NOT( '
  Else
    Result := Result + ' ( ';
  If (Length(arrLinha) > 1) Then
  Begin
    For intCon := 0 to Length(arrLinha) - 1 Do
    Begin
      Result := Result + ' (' + strCampo + '= :' + strParam + IntToStr(intCon);
      If intCon = (Length(arrLinha) - 1) Then
        Result := Result + ')'
      Else
        Result := Result + ') OR ';
    End;
  End
  Else
    Result := Result + strCampo + '= :' + strParam;

  Result := Result + ' )';

  If Not blnSemAND Then
    Result := '  AND ' + Result;
end;

procedure pSetaParamOR(arrLinha : TConsultasArray;
                       strParam : string;
                       qryTabela: TUniQuery);
  var
    intCon: Integer;
begin
  if (Length(arrLinha) > 1) then
  begin
    for intCon := 0 to Length(arrLinha) - 1 do
      qryTabela.ParamByName(strParam + IntToStr(intCon)).AsString := arrLinha[intCon].strCodigo;
  end
  else
    qryTabela.ParamByName(strParam).AsString := arrLinha[0].strCodigo;
end;

function fGetPathTempOpcoesLocais: String;
  Var
    Buffer: array[0..254] of Char;
    strPatIni: string;
		iniArqIni : TIniFile;
begin
  Result := '';
  {$IFDEF MSWINDOWS}
  GetWindowsDirectory(Buffer, 255);
  strPatIni := StrPas(Buffer) + '\OPCOES_LOCAIS.INI';
  {$ELSE}
  strPatIni := TPath.Combine(GetCurrentDir, 'OPCOES_LOCAIS.INI');
  {$ENDIF}


  if FileExists(strPatIni) then
  begin
    {$IFDEF MSWINDOWS}
    iniArqIni := TIniFile.Create(strPatIni);
    {$ELSE}
    iniArqIni := TInifile.Create(strPatIni, TEncoding.ANSI);
    {$ENDIF}
    try
      Result := iniArqIni.ReadString('ARQUIVOS_TEMPORARIOS', 'PATH' , Result)
    finally
      iniArqIni.Free;
    end;
  end;
end;

end.