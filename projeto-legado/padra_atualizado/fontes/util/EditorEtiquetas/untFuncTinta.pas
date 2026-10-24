unit untFuncTinta;

interface

uses
  untIConfTinta, untITransferencias, untTypesSistema, untIFatOrdProTintaMaquina, untILiberacao,
  untIExecutaSQLReplicacaoTinta, untIFatDefineLotesPedidoWMS, untIFuncoesCRM, untIFuncoesSaldos,
  untFuncoesSimples, Windows, Forms, Uni, untFuncoesTintaDeMaquinaBpl, SysUtils,
  untITintasDeMaquina;

Var
  fGetConfTinta: Function(strIdePro: String): IConfTinta; stdcall;
  fGetFatorML: Function (strIdePro: String): Double; stdcall;
  fTintaBaixaProduto: Function(strIdePro: String): Boolean; stdcall;
  fRetornaNomeTinta: Function(strIdePro: String; blnExiLib: Boolean = True): String; stdcall;
  fRetornaTabelaColoranteTinta: Function (strIdePro: String): String; stdcall;
  fGetQuantidadeOncaPulsoMl : Function (const fltValor: Double = 0; const strIdePro: string = ''; const strFormul: String = ''): string; stdcall;
  pRetornaDadosTinta: Procedure (strIdePro, strIteTin: String; dicRetorno: TDicionario); stdcall;
  pRetItemEDescricaoColorante: Procedure (strIdePro, strColTinDet: String; Var strCodIte, strCodBas, strDesBas: String; const strCodEmp: string; strLinha_: String = ''); stdcall;
  fGetTintasdeMaquina: Function(blnDestruir: Boolean = False): ITintasDeMaquina; stdcall;
  fUsaChapinhaTinta: Function(strIdePro: String; strIteTin: String): Boolean; Stdcall;
  fRetornaCodigoChapinha: Function(strIdePro: String): String; Stdcall;


procedure pCarregaFuncoesDll();


implementation

{$IFNDEF LINUX}
uses
 untModulo, untLiberacaoFactory, untConstantes;
{$ENDIF}

procedure pCarregaFuncoesDll();
Begin
  HandleDllTinta := LoadLibrary(PChar(ExtractFilePath(Application.ExeName) + DLL_TINTA_PATH));;

  If (HandleDllTinta = 0) Then
  Begin
    VS_strUsaTmq := 'N';
    Exit;
  End;

  fGetConfTinta        := GetProcAddress(HandleDllTinta, PChar('fGetConfTinta'));
  pRetornaDadosTinta   := GetProcAddress(HandleDllTinta, PChar('pRetornaDadosTinta'));
  pRetItemEDescricaoColorante := GetProcAddress(HandleDllTinta, PChar('pRetItemEDescricaoColorante'));
  fGetFatorML          := GetProcAddress(HandleDllTinta, PChar('fGetFatorML'));
  fRetornaNomeTinta    := GetProcAddress(HandleDllTinta, PChar('fRetornaNomeTinta'));
  fTintaBaixaProduto        := GetProcAddress(HandleDllTinta, PChar('fTintaBaixaProduto'));
  fRetornaTabelaColoranteTinta := GetProcAddress(HandleDllTinta, PChar('fRetornaTabelaColoranteTinta'));
  fGetQuantidadeOncaPulsoMl   := GetProcAddress(HandleDllTinta, PChar('fGetQuantidadeOncaPulsoMl'));
  fGetTintasdeMaquina         := GetProcAddress(HandleDllTinta, PChar('fGetTintasdeMaquina'));
  fUsaChapinhaTinta         := GetProcAddress(HandleDllTinta, PChar('fUsaChapinhaTinta'));
  fRetornaCodigoChapinha    := GetProcAddress(HandleDllTinta, PChar('fRetornaCodigoChapinha'));
End;

end.
