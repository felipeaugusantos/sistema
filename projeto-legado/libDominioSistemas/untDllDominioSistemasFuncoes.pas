unit untDllDominioSistemasFuncoes;

interface

uses
  untDllDominioSistemas, SysUtils, Windows,
  untInterfacesLibDominioSistemasAutcom;

type
  TShowFormDominio = procedure(prmDllTra: Pointer); stdcall;
  TInicializaObjetoLibDominioSistemas = procedure(AObjetoLibDominioSistemas: ILibDominioSistemas); stdcall;
  TdxInitialize = procedure; StdCall;
  TSetStyleAutcomProc = procedure(AModoClassico: Boolean); StdCall;

  procedure pAbrirFormDominio(frmTipCadastro: TTipoDominio);

implementation

uses untModulo, untFuncoesSimples, untLibDominioSistemasAutcom;

procedure pAbrirFormDominio(frmTipCadastro: TTipoDominio);
Var
  objCadastro: TParamDominio;
  hDll: THandle;
  pShowFormDominio: TShowFormDominio;
  pInicializaObjetoLibDominioSistemas: TInicializaObjetoLibDominioSistemas;
  pDxInitialize: TdxInitialize ;
  pSetStyleAutcom: TSetStyleAutcomProc ;
  LobjFunc: TILibDominioSistemasAutcom ;
begin
  Try
    hDll := LoadLibrary('libDominioSistemas.dll');

    if hDll = 0 then
    begin
      pMensagensErro('Erro ao carregar a DLL: ' + SysErrorMessage(GetLastError), 'DLL libDominioSistemas');
      Exit;
    end;

    @pShowFormDominio := GetProcAddress(hDll, 'pShowFormDominio');
    if not Assigned(pShowFormDominio) then
    begin
      pMensagensErro('Função pShowFormDominio não encontrada na DLL', 'DLL libDominioSistemas');
      FreeLibrary(hDll);
      Exit;
    end;

    @pInicializaObjetoLibDominioSistemas := GetProcAddress(hDll, 'pInicializaObjetoLibDominioSistemas');
    if not Assigned(pInicializaObjetoLibDominioSistemas) then
    begin
      pMensagensErro('Função pInicializaObjetoLibDominioSistemas não encontrada na DLL', 'DLL libDominioSistemas');
      FreeLibrary(hDll);
      Exit;
    end;

    @pDxInitialize := GetProcAddress(hDll, 'dxInitialize');
    if not Assigned(pDxInitialize) then
    begin
      pMensagensErro('Função dxInitialize não encontrada na DLL', 'DLL libDominioSistemas');
      FreeLibrary(hDll);
      Exit;
    end;

    @pSetStyleAutcom := GetProcAddress(hDll, 'SetStyleAutcom');
    if not Assigned(pSetStyleAutcom) then
    begin
      pMensagensErro('Função SetStyleAutcom não encontrada na DLL', 'DLL libDominioSistemas');
      FreeLibrary(hDll);
      Exit;
    end;

    pDxInitialize ;

    LobjFunc := TILibDominioSistemasAutcom.Create ;
    objCadastro := TParamDominio.Create;
    try
      pInicializaObjetoLibDominioSistemas(LobjFunc) ;

      pSetStyleAutcom(LobjFunc.fIExecutandoModoClassico) ;

      objCadastro.frmTipCad := frmTipCadastro;
      pShowFormDominio(objCadastro);

      FreeLibrary(hDll);

    finally
      FreeAndNil(objCadastro);
    end;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'DLL libDominioSistemas');
    End;
  End;
end;

end.

