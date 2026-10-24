unit untInicializarDllAutTin;

interface

uses
  untFuncoesSimples, Uni, UniClientDataSet, DB, SysUtils, Classes, System.Generics.Collections,
  untConstantes, Controls, DateUtils, Math, StrUtils, Windows,
  Variants, untTypesSistema, untModulo,
  Vcl.Menus, Forms, ComCtrls;

Var
fRetVersionSVNAutTin: function: String; Stdcall;
pInicializaDllAutTin: procedure(frmModuloPar: TUniConnection;
                               Handle: HWND;
                               intDebugH: Byte;
                               strUsuario,
                               strEmpAceUsuLogado,
                               strEmpresa: String;
                               objTraceViewer: ITraceViewer;
                               blnUsuarioLogadoUtilizaModoClassico: Boolean); Stdcall;

pConfiguracaoTintaMaquina: procedure(); Stdcall;
fMenuTintaToXml: function(): String; Stdcall;
pOnClickMenuGenericTinta: procedure(Const menuName: String); Stdcall;
ProcessaMenuDireitoAcesso: procedure(trvMenu: TTreeView) Stdcall;

pCriaFormularioBaseGlasurit: procedure(); Stdcall;
pCriaFormularioConfGlasurit: procedure(); Stdcall;
pCriaFormularioGerArqGlasurit: procedure(); Stdcall;
pCriaFormularioNovasFormulasGlasurit: procedure(); Stdcall;
pCriaFormularioGerarNovasFormulasGlasurit: procedure(Sender: TComponent); Stdcall;
pConsultaGlasuritGeralDinamica: procedure(Sender: TForm); Stdcall;

pCriaFormularioBaseSalcomix: procedure(); Stdcall;
pCriaFormularioConfSalcomix: procedure(); Stdcall;
pCriaFormularioGerArqSalcomix: procedure(); Stdcall;
pCriaFormularioNovasFormulasSalcomix: procedure(); Stdcall;
pCriaFormularioGerarNovasFormulasSalcomix: procedure(Sender: TComponent); Stdcall;
pConsultaSalcomixGeralDinamica: procedure(Sender: TForm); Stdcall;

CriarNovasFormulasDllGeneric: procedure(AClass: String); Stdcall;

dxInitializeAuttin: procedure; StdCall;
dxFinalizeAuttin: procedure; StdCall;
fRetornaDicConfigInicialAutTin: function: TDictionary<string,boolean>; stdcall;
pIniciaFinalizaDicConfigInicialAutTin: procedure(const blnFinaliza: Boolean=False); stdcall;
pProcessarTodasTintasParaModoCompleto: procedure(); Stdcall;

procedure pIniciaFuncoesDllAuttin(blnLogOff: Boolean=False);
function RetornarAuttinDll : THandle;
procedure pCarregaFuncoesDllAuttin();

var
  blnCarregando: Boolean;

implementation

var
  blnInicializouDllAuttin: Boolean;

function RetornarAuttinDll: THandle;
Var
  strDllAuttin: String;
Begin
  strDllAuttin := ExtractFilePath(Application.ExeName) + 'auttin';

  Result := LoadLibrary(PChar(strDllAuttin + '\libAuttin.dll'));
End;

procedure pCarregaFuncoesDllAuttin();
Begin
  If (HandleDllAuttin = 0) Then
    blnInicializouDllAuttin := False;

  HandleDllAuttin := RetornarAuttinDll;

  If (HandleDllAuttin <> 0) Then
  Begin
    fRetVersionSVNAutTin := GetProcAddress(HandleDllAuttin, pChar('fRetVersionSVNAutTin'));
    pInicializaDllAutTin := GetProcAddress(HandleDllAuttin, PChar('pInicializaDllAutTin'));
    pConfiguracaoTintaMaquina := GetProcAddress(HandleDllAuttin, PChar('pConfiguracaoTintaMaquina'));
    fMenuTintaToXml := GetProcAddress(HandleDllAuttin, PChar('fMenuTintaToXml'));
    pOnClickMenuGenericTinta := GetProcAddress(HandleDllAuttin, PChar('pOnClickMenuGenericTinta'));
    ProcessaMenuDireitoAcesso := GetProcAddress(HandleDllAuttin, PChar('ProcessaMenuDireitoAcesso'));
    pCriaFormularioBaseGlasurit := GetProcAddress(HandleDllAuttin, PChar('pCriaFormularioBaseGlasurit'));
    pCriaFormularioConfGlasurit := GetProcAddress(HandleDllAuttin, PChar('pCriaFormularioConfGlasurit'));
    pCriaFormularioGerArqGlasurit := GetProcAddress(HandleDllAuttin, PChar('pCriaFormularioGerArqGlasurit'));
    pCriaFormularioNovasFormulasGlasurit := GetProcAddress(HandleDllAuttin, PChar('pCriaFormularioNovasFormulasGlasurit'));
    pCriaFormularioGerarNovasFormulasGlasurit := GetProcAddress(HandleDllAuttin, PChar('pCriaFormularioGerarNovasFormulasGlasurit'));
    pConsultaGlasuritGeralDinamica := GetProcAddress(HandleDllAuttin, PChar('pConsultaGlasuritGeralDinamica'));
    pCriaFormularioBaseSalcomix := GetProcAddress(HandleDllAuttin, PChar('pCriaFormularioBaseSalcomix'));
    pCriaFormularioConfSalcomix := GetProcAddress(HandleDllAuttin, PChar('pCriaFormularioConfSalcomix'));
    pCriaFormularioGerArqSalcomix := GetProcAddress(HandleDllAuttin, PChar('pCriaFormularioGerArqSalcomix'));
    pCriaFormularioNovasFormulasSalcomix := GetProcAddress(HandleDllAuttin, PChar('pCriaFormularioNovasFormulasSalcomix'));
    pCriaFormularioGerarNovasFormulasSalcomix := GetProcAddress(HandleDllAuttin, PChar('pCriaFormularioGerarNovasFormulasSalcomix'));
    pConsultaSalcomixGeralDinamica := GetProcAddress(HandleDllAuttin, PChar('pConsultaSalcomixGeralDinamica'));
    CriarNovasFormulasDllGeneric := GetProcAddress(HandleDllAuttin, PChar('CriarNovasFormulasDllGeneric'));
    dxInitializeAuttin := GetProcAddress(HandleDllAuttin, PChar('dxInitializeAuttin'));
    dxFinalizeAuttin := GetProcAddress(HandleDllAuttin, PChar('dxFinalizeAuttin'));
    fRetornaDicConfigInicialAutTin := GetProcAddress(HandleDllAuttin, PChar('fRetornaDicConfigInicialAutTin'));
    pIniciaFinalizaDicConfigInicialAutTin := GetProcAddress(HandleDllAuttin, PChar('pIniciaFinalizaDicConfigInicialAutTin'));
    pProcessarTodasTintasParaModoCompleto := GetProcAddress(HandleDllAuttin, PChar('pProcessarTodasTintasParaModoCompleto'));

    If Assigned(dxInitializeAuttin) Then
      dxInitializeAuttin
  End;
End;

procedure pIniciaFuncoesDllAuttin(blnLogOff: Boolean=False);
Begin
  If (Not blnInicializouDllAuttin) Or (blnLogOff) Then
  Begin
    While (blnCarregando) Do
      Sleep(100);

    blnCarregando  := True;

    Try
      pInicializaDllAutTin(frmModulo.GetCurrentConnection,
                           VS_APPLICATION_HANDLE,
                           DebugHook,
                           strLoginUsuarioLogado,
                           strEmpAcessoUsuarioLogado,
                           VS_strCodEmp,
                           VS_objTraceViewer,
                           blnUsuarioLogadoUtilizaModoClassico);

      blnInicializouDllAuttin := True;
    Finally
      blnCarregando  := False;
    End;
  End;
End;

Initialization
  HandleDllAuttin := 0;
  blnInicializouDllAuttin := False;
  blnCarregando := False;

Finalization

end.

