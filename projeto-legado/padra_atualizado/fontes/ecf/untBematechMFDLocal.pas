unit untBematechMFDLocal;

interface

uses Windows;

Type
  TBematechMFDLocal = class(TObject)
    private
      FTipoFiltro: String;
      FFiltroIni: String;
      FFiltroFin: String;
      FArquivoSaida: String;

      blnCopiouAplicativo: Boolean;
      blnCancelarOperacao: Boolean;

      procedure pCopiarArquivosNecessarios;
      procedure pPedeParaUsuarioAtivarAplicativoLocal;
      procedure pComunicarComAplicativoLocal;

      procedure pCopiaSeNecessario(strPath: String; arrArquivos: array of String);
      procedure pCopia(strPath: String; arrArquivos: array of String);
      procedure pNaoCopiou(strPath, strOrigem: String);

      procedure pTrataRetornoApp(strRetornoApp: String);
    public
      constructor Create(strTipoFiltro, strFiltroIni, strFiltroFin, strArquivoSaida: String);
      function fEspelhoMFDLocal: Boolean;
  end;

implementation

uses SysUtils, Classes, StrUtils, Forms, DateUtils, untFuncoesSimples;

{ TBematechMFDLocal }

constructor TBematechMFDLocal.Create(strTipoFiltro, strFiltroIni, strFiltroFin,
  strArquivoSaida: String);
begin
  FTipoFiltro   := strTipoFiltro;
  FFiltroIni    := strFiltroIni;
  FFiltroFin    := strFiltroFin;
  FArquivoSaida := strArquivoSaida;

  blnCopiouAplicativo := False;  
end;

function TBematechMFDLocal.fEspelhoMFDLocal: Boolean;
begin
  Result := False;
  blnCopiouAplicativo := False;
  
  pCopiarArquivosNecessarios;
  pPedeParaUsuarioAtivarAplicativoLocal;

  If Not blnCancelarOperacao Then
  Begin
    pComunicarComAplicativoLocal;
    Result := True;
  End;
end;

procedure TBematechMFDLocal.pCopiarArquivosNecessarios;
  Var
    strPath: String;
begin
  strPath := fCfgSis('MDLOPT');

  If Not DirectoryExists(strPath) Then
    CreateDir(strPath);

  If Not DirectoryExists(strPath) Then
    Raise Exception.Create('Pasta ' + strPath + ' não encontrado ou não disponível e não foi possível criá-la. ' +
      'Verifique se o acesso aos recursos locais está habilitado no TS.');

  pCopiaSeNecessario(strPath, ['BemaFI32.dll', 'BemaMFD.dll', 'BemaMFD2.dll']);
  pCopia(strPath, ['BemaFI32.ini']);

  If Not FileExists(ExtractFilePath(Application.ExeName) + '\DownloadMFD.exe') Then
    Raise Exception.Create('Não foi encontrado o arquivo DownloadMFD.exe na pasta do Autcom. ' +
      'Por favor, entre em contato com a Citel para sua instalação.');

  If Not FileExists(strPath + '\DownloadMFD.exe') Then
  Begin
    pCopia(strPath, ['DownloadMFD.exe']);
    blnCopiouAplicativo := True;
  End;

end;

procedure TBematechMFDLocal.pCopiaSeNecessario(strPath: String; arrArquivos: Array Of String);
  Var
    strNomArq: String;
    strOrigem: String;
    strDestino: String;
begin
  For strNomArq In arrArquivos Do
  Begin
    strOrigem := ExtractFilePath(Application.ExeName) + '\' + strNomArq;
    strDestino := strPath + '\' + strNomArq;

    If Not FileExists(strDestino) Then
    Begin
      If Not CopyFile(PChar(strOrigem), PChar(strDestino), False) Then
        pNaoCopiou(strPath, strOrigem);
    End;

    If Not FileExists(strDestino) Then
    Begin
      pNaoCopiou(strPath, strOrigem);
    End;
  End;
end;

procedure TBematechMFDLocal.pCopia(strPath: String; arrArquivos: Array Of String);
  Var
    strNomArq: String;
    strOrigem: String;
    strDestino: String;
begin
  For strNomArq In arrArquivos Do
  Begin
    strOrigem := ExtractFilePath(Application.ExeName) + '\' + strNomArq;
    strDestino := strPath + '\' + strNomArq;

    If Not CopyFile(PChar(strOrigem), PChar(strDestino), False) Then
      pNaoCopiou(strPath, strOrigem);

    If Not FileExists(strDestino) Then
    Begin
      pNaoCopiou(strPath, strOrigem);
    End;
  End;
end;

procedure TBematechMFDLocal.pNaoCopiou(strPath, strOrigem: String);
begin
  Raise Exception.Create('Não foi possível realizar a cópia do arquivo ' + strOrigem + '. ' +
    'Verifique se a pasta de destino (' + strPath + ') existe e se há permissão para gravação.');
end;

procedure TBematechMFDLocal.pPedeParaUsuarioAtivarAplicativoLocal;
begin
  blnCancelarOperacao := False;
  If blnCopiouAplicativo Then
  Begin

    If fMensagem('', 'O aplicativo DownloadMFD.exe foi copiado para o computado local. Por favor ' +
      'execute-o manualmente antes de prosseguir. Caminho do aplicativo: ' + fCfgSis('MDLOPT') + '\DownloadMFD.exe',
      ['Continuar', 'Cancelar']) = 2 Then
    Begin
      blnCancelarOperacao := True;
    End;
  End;
end;

procedure TBematechMFDLocal.pComunicarComAplicativoLocal;
  Const
    MAX_TENTATIVAS_RENOMEAR = 5;
    MAX_TIMEOUT_RETORNO = 20 * 60 * 1000; // 20min
  Var
    strArquivo: String;
    strArquivoDefinitivo: String;
    strConteudo: String;

    stlArq: TStringList;
    intTentativasRen: Integer;
    tmrInicioVerificacao: TDateTime;
    strPathLocal: String;

    strRetornoApp: String;
begin
  strPathLocal := fCfgSis('MDLOPT');
  strArquivo := strPathLocal + '\comando.tmp';
  strArquivoDefinitivo := strPathLocal + '\comando.cmd';

  strConteudo := 'MFD|' + FTipoFiltro + '|' + FFiltroIni + '|' + FFiltroFin + '|' + ExtractFileName(FArquivoSaida) + '|';

  stlArq := TStringList.Create;
  stlArq.Add(strConteudo);
  stlArq.SaveToFile(strArquivo);
  FreeAndNil(stlArq);

  intTentativasRen := 0;
  While (Not RenameFile(strArquivo, strArquivoDefinitivo)) Do
  Begin
    Sleep(200);
    If intTentativasRen >= MAX_TENTATIVAS_RENOMEAR Then
      Raise Exception.Create('Não foi possível renomear o arquivo de comando para o aplicativo local. Por favor, tente novamente.');
    Inc(intTentativasRen);
  End;

  tmrInicioVerificacao := fNow();
  While (Not FileExists(strPathLocal + '\resultado.txt')) Do
  Begin
    Sleep(1000);
    If SecondsBetween(fNow(), tmrInicioVerificacao) > MAX_TIMEOUT_RETORNO Then
      Raise Exception.Create('Não obteve resposta do aplicativo local. Por favor, verifique se está iniciado.');
  End;

  Sleep(1000);
  stlArq := TStringList.Create;

  Try
    stlArq.LoadFromFile(strPathLocal + '\resultado.txt');
    If stlArq.Count <= 0 Then
      Raise Exception.Create('Arquivo de resposta recebido, porém vazio. Por favor, tente novamente.');
    strRetornoApp := stlArq[0];
  Finally
    FreeAndNil(stlArq);
  End;

  DeleteFile(String(strPathLocal) + '\resultado.txt');

  pTrataRetornoApp(strRetornoApp);
end;

procedure TBematechMFDLocal.pTrataRetornoApp(strRetornoApp: String);
  Var
    strArquivo: String;
begin
  If AnsiStartsText('OK', strRetornoApp) Then
  Begin
    strArquivo := fCfgSis('MDLOPT') + '\' + Copy(strRetornoApp, 4, Length(strRetornoApp));
    If Not CopyFile(PChar(strArquivo), PChar(FArquivoSaida), False) Then
      Raise Exception.Create('Não foi possível copiar o arquivo final para o TS. Por favor, tente novamente.');
    Sleep(1000);
  End
  Else
  Begin
    Raise Exception.Create(strRetornoApp);
  End;
end;


end.
