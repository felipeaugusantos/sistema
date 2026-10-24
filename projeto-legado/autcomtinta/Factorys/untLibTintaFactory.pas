unit untLibTintaFactory;

interface

uses
  untILibTinta, Classes, SysUtils, untLibTintaDllRelacao;

type
  TLibTintaFactory = class(TInterfacedObject)
  private
    class var blnScaneado: Boolean;
    class var stlArquivosDll: TStringList;
    class var stlArquivosDllDir: TStringList;
    class function GetStlArquivosDll: TStringList;
    class function GetStlArquivosDllDir: TStringList;
    class procedure pAdicionaDLLTintaDir(strNomeDLL: String);
    class function fAchaWrapperPorNomeArquivo(const strNomeArquivo: String): TObject;
    class function fMontarCaminhoDLL(const strDir, strNomeArquivo: String): String;
  public
    class procedure RegistrarDll(const strNomeArquivoDll: string);
    class function GetITintadeMaquina(const strIdentificador: string): ILibTinta;
    class procedure ScanearDlls;
    class procedure UnLoadDlls;
    class procedure GetIdentificadores(const stlIdentificadores: TStrings);
    class procedure GetTintaDLLDiretorio(const stlTintaDLLDiretorio: TStrings);
  end;

implementation

uses
{$IFDEF LINUX}
  Services.Core.Types,
{$ENDIF}
  untLibTintaDllWrapper, untAutcomTintaWrapper;

{ TTintadeMaquinaFactory }

class function TLibTintaFactory.fAchaWrapperPorNomeArquivo(const strNomeArquivo: String): TObject;
var
  intCont: Integer;
  strBase: String;
begin
  Result := nil;
  for intCont := 0 to GetStlArquivosDll.Count - 1 do
  begin
    strBase := ExtractFileName(GetStlArquivosDll[intCont]);
    if SameText(strBase, strNomeArquivo) then
    begin
      Result := GetStlArquivosDll.Objects[intCont];
      Exit;
    end;
  end;
end;

class function TLibTintaFactory.fMontarCaminhoDLL(const strDir, strNomeArquivo: String): String;
begin
  Result := IncludeTrailingPathDelimiter(strDir) + strNomeArquivo;
end;

class procedure TLibTintaFactory.GetIdentificadores(const stlIdentificadores: TStrings);
var
  libRel: TLibTintaDllRelacao;
  stlHabilitados: TStringList;
  intCont: Integer;
  strArquivo: String;
begin
  if not blnScaneado then
    ScanearDlls;

  stlIdentificadores.Clear;
  libRel := Nil;
  stlHabilitados := Nil;
  try
    libRel := TLibTintaDllRelacao.Create(True);
    stlHabilitados := TStringList.Create;

    libRel.pGetIdeProHabilitados(stlHabilitados);

    //IDEPRO com USATIN = 'S'
    for intCont := 0 to stlHabilitados.Count - 1 do
    begin
      strArquivo := libRel.fGetNomeDLLPorIdePro(stlHabilitados[intCont]);
      if (strArquivo <> '') and Assigned(fAchaWrapperPorNomeArquivo(strArquivo)) then
        stlIdentificadores.Add(stlHabilitados[intCont]);
    end;
  finally
    If Assigned(stlHabilitados) Then
      FreeAndNil(stlHabilitados);
    If Assigned(libRel) Then
      FreeAndNil(libRel);
  end;
end;

class function TLibTintaFactory.GetITintadeMaquina(const strIdentificador: string): ILibTinta;
var
  libRel: TLibTintaDllRelacao;
  strArquivo: String;
  objWrapper: TObject;
begin
  pDebugViaEventLog('[AutcomTinta][GetITintadeMaquina] "' + strIdentificador + '"');

  if not blnScaneado then
    ScanearDlls;

  Result := nil;
  if strIdentificador = '' then
  begin
    pDebugViaEventLog('[AutcomTinta][GetITintadeMaquina] Identificador Vazio!');
    Exit;
  end;

  if strIdentificador = 'NOR' then
  begin
    Exit;
  end;

  libRel := TLibTintaDllRelacao.Create(False);
  try
    strArquivo := libRel.fGetNomeDLLPorIdentificadorGenerico(strIdentificador);
  finally
    FreeAndNil(libRel);
  end;

  if strArquivo = '' then
  begin
    pDebugViaEventLog('[AutcomTinta][GetITintadeMaquina] "' + strIdentificador + '": Não achei nem por IDEPRO nem por NOMETINTA"');
    Exit;
  end;

  pDebugViaEventLog(Format('[AutcomTinta][GetITintadeMaquina] "%s" -> %s', [strIdentificador, strArquivo]));

  objWrapper := fAchaWrapperPorNomeArquivo(strArquivo);
  if Assigned(objWrapper) then
    Result := TLibTintaDllWrapper(objWrapper).GetTintadeMaquina
  else
    pDebugViaEventLog('[AutcomTinta][GetITintadeMaquina] Wrapper nao encontrado para: ' + strArquivo+'!');
end;

class function TLibTintaFactory.GetStlArquivosDll: TStringList;
begin
  if not Assigned(stlArquivosDll) then
  begin
    stlArquivosDll := TStringList.Create;
  end;

  Result := stlArquivosDll;
end;

class function TLibTintaFactory.GetStlArquivosDllDir: TStringList;
begin
  if not Assigned(stlArquivosDllDir) then
  begin
    stlArquivosDllDir := TStringList.Create;
  end;

  Result := stlArquivosDllDir;
end;

class procedure TLibTintaFactory.GetTintaDLLDiretorio(
  const stlTintaDLLDiretorio: TStrings);
var
  intCont: Integer;
begin
  stlTintaDLLDiretorio.Clear;
  for intCont := 0 to GetStlArquivosDllDir.Count - 1 do
  begin
    stlTintaDLLDiretorio.Add(GetStlArquivosDllDir[intCont]);
  end;
end;

class procedure TLibTintaFactory.UnLoadDlls;
var
  intIndex: Integer;
begin
  for intIndex := 0 to GetStlArquivosDll.Count - 1 do
  begin
    GetStlArquivosDll.Objects[intIndex].Free;
  end;

  stlArquivosDll.Clear;
  stlArquivosDllDir.Clear;
end;

class procedure TLibTintaFactory.pAdicionaDLLTintaDir(strNomeDLL: String);
begin
  GetStlArquivosDllDir.Add(strNomeDLL);
end;

class procedure TLibTintaFactory.RegistrarDll(const strNomeArquivoDll: string);
begin
  if not FileExists(strNomeArquivoDll) then
    Exit;

  if GetStlArquivosDll.IndexOf(strNomeArquivoDll) >= 0 then
    Exit;

  GetStlArquivosDll.AddObject(strNomeArquivoDll,
    TLibTintaDllWrapper.Create(strNomeArquivoDll, TAutcomTintaWrapper.Create));
end;

class procedure TLibTintaFactory.ScanearDlls;
var
  strDir: String;
  libRel: TLibTintaDllRelacao;
  stlHabilitados, stlTodasDoMapa: TStringList;
  intCont: Integer;
  strArquivo, strCaminho: String;
begin
  pDebugViaEventLog('[AutcomTinta][ScanearDlls] >>> Início');

  libRel := Nil;
  stlHabilitados := Nil;
  stlTodasDoMapa := Nil;
  try
    libRel := TLibTintaDllRelacao.Create(True);
    stlHabilitados := TStringList.Create;
    stlTodasDoMapa := TStringList.Create;

   {$IFDEF LINUX}
    strDir := ExtractFilePath(Application.ExeName) + '/auttin/tintas/';
   {$ELSE}
    strDir := ExtractFileDir(ParamStr(0));
    if SameText(ExtractFileName(strDir), 'auttin') then
      strDir := strDir + '\tintas\'
    else
      strDir := strDir + '\auttin\tintas\';
   {$ENDIF}

    If Assigned(stlArquivosDllDir) Then
      stlArquivosDllDir.Clear;

    libRel.pGetTodosNomesDLL(stlTodasDoMapa);
    for intCont := 0 to stlTodasDoMapa.Count - 1 do
    begin
      strCaminho := fMontarCaminhoDLL(strDir, stlTodasDoMapa[intCont]);
      if FileExists(strCaminho) then
        pAdicionaDLLTintaDir(stlTodasDoMapa[intCont]);
    end;

    pDebugViaEventLog(Format('[AutcomTinta][ScanearDlls] %d DLLs presentes em disco (do mapa)', [GetStlArquivosDllDir.Count]));

    libRel.pGetIdeProHabilitados(stlHabilitados);

    pDebugViaEventLog(Format('[AutcomTinta][ScanearDlls] CFGTIN: %d marcas habilitadas', [stlHabilitados.Count]));

    for intCont := 0 to stlHabilitados.Count - 1 do
    begin
      strArquivo := libRel.fGetNomeDLLPorIdePro(stlHabilitados[intCont]);
      if strArquivo = '' then
      begin
        pDebugViaEventLog(Format('[AutcomTinta][ScanearDlls] ignorada (sem mapeamento): %s', [stlHabilitados[intCont]]));
        Continue;
      end;

      strCaminho := fMontarCaminhoDLL(strDir, strArquivo);
      if not FileExists(strCaminho) then
      begin
        pDebugViaEventLog(Format('[AutcomTinta][ScanearDlls] ignorada (arquivo não encontrado): %s', [strArquivo]));
        Continue;
      end;

      RegistrarDll(strCaminho); //Cria somente Wrapper da Lib - LoadLibrary ocorrerá no GetTintadeMaquina
    end;

    blnScaneado := True;
  finally
    If Assigned(stlTodasDoMapa) Then
      FreeAndNil(stlTodasDoMapa);

    If Assigned(stlHabilitados) Then
      FreeAndNil(stlHabilitados);

    If Assigned(libRel) Then
      FreeAndNil(libRel);
  end;

  pDebugViaEventLog(Format('[AutcomTinta][ScanearDlls] <<< Fim: %d wrappers registrados, %d DLLs em disco', [GetStlArquivosDll.Count, GetStlArquivosDllDir.Count]));
end;

initialization
  TLibTintaFactory.blnScaneado := False;
  TLibTintaFactory.stlArquivosDll := nil;
  TLibTintaFactory.stlArquivosDllDir := nil;

finalization
  if Assigned(TLibTintaFactory.stlArquivosDll) then
  begin
    FreeAndNil(TLibTintaFactory.stlArquivosDll);
    FreeAndNil(TLibTintaFactory.stlArquivosDllDir);
  end;

end.
