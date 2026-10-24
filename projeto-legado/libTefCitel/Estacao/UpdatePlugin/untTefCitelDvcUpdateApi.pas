unit untTefCitelDvcUpdateApi;

{ Traducao para Pascal das interfaces COM de tsvirtualchannels.h (Microsoft
  Platform SDK - plugin cliente de Dynamic Virtual Channel do RDP), lado
  cliente do canal "TefCitelUpd" (Req. 456190, Fase 6.1).

  DUPLICADA DE PROPOSITO a partir de untTefCitelDvcPluginApi.pas, em vez de
  referenciada por search-path. E a mesma decisao ja registrada em
  IA\rules\tef-dvc.md para o fCrc32, e pelo mesmo motivo: sao dois .dproj
  diferentes, e compartilhar unit entre eles traz problema de search-path e,
  pior, faz uma alteracao num plugin mexer silenciosamente no outro. O
  TefCitelDvcPlugin.dll e codigo validado em campo que esta fase NAO pode
  tocar - nem por tabela.

  Um erro de GUID aqui faz o QueryInterface falhar silenciosamente do lado do
  cliente RDP, sem mensagem de erro util - nao alterar sem conferir contra o
  header original. }

interface

uses
  Winapi.Windows, Winapi.ActiveX;

const
  { Canal proprio, separado do "TefCitelCh" da transacao. A separacao E o
    desenho: e ela que garante que ninguem escreve neste canal enquanto uma
    leitura esta pendente, que e a condicao que torna o bloco grande seguro
    (ver secao 12 de IA\specs\456190\specs.md). }
  TEF_UPD_CANAL: AnsiString = 'TefCitelUpd';

  IID_IWTSPlugin: TGUID = '{A1230201-1439-4E62-A414-190D0AC3D40E}';
  IID_IWTSListener: TGUID = '{A1230206-9A39-4D58-8674-CDB4DFF4E73B}';
  IID_IWTSListenerCallback: TGUID = '{A1230203-D6A7-11D8-B9FD-000BDBD1F198}';
  IID_IWTSVirtualChannelCallback: TGUID = '{A1230204-D6A7-11D8-B9FD-000BDBD1F198}';
  IID_IWTSVirtualChannelManager: TGUID = '{A1230205-D6A7-11D8-B9FD-000BDBD1F198}';
  IID_IWTSVirtualChannel: TGUID = '{A1230207-D6A7-11D8-B9FD-000BDBD1F198}';

type
  IWTSPlugin = interface;
  IWTSListener = interface;
  IWTSListenerCallback = interface;
  IWTSVirtualChannelCallback = interface;
  IWTSVirtualChannelManager = interface;
  IWTSVirtualChannel = interface;

  IWTSPlugin = interface(IUnknown)
    ['{A1230201-1439-4E62-A414-190D0AC3D40E}']
    function Initialize(const ChannelMgr: IWTSVirtualChannelManager): HRESULT; stdcall;
    function Connected: HRESULT; stdcall;
    function Disconnected(DisconnectCode: DWORD): HRESULT; stdcall;
    function Terminated: HRESULT; stdcall;
  end;

  IWTSListener = interface(IUnknown)
    ['{A1230206-9A39-4D58-8674-CDB4DFF4E73B}']
    function GetConfiguration(out PropertyBag: IPropertyBag): HRESULT; stdcall;
  end;

  IWTSListenerCallback = interface(IUnknown)
    ['{A1230203-D6A7-11D8-B9FD-000BDBD1F198}']
    function OnNewChannelConnection(const Channel: IWTSVirtualChannel;
      Data: PWideChar; Accept: PBOOL;
      out Callback: IWTSVirtualChannelCallback): HRESULT; stdcall;
  end;

  IWTSVirtualChannelCallback = interface(IUnknown)
    ['{A1230204-D6A7-11D8-B9FD-000BDBD1F198}']
    function OnDataReceived(Size: ULONG; Buffer: PByte): HRESULT; stdcall;
    function OnClose: HRESULT; stdcall;
  end;

  IWTSVirtualChannelManager = interface(IUnknown)
    ['{A1230205-D6A7-11D8-B9FD-000BDBD1F198}']
    function CreateListener(ChannelName: PAnsiChar; Flags: ULONG;
      const ListenerCallback: IWTSListenerCallback;
      out Listener: IWTSListener): HRESULT; stdcall;
  end;

  IWTSVirtualChannel = interface(IUnknown)
    ['{A1230207-D6A7-11D8-B9FD-000BDBD1F198}']
    function Write(Size: ULONG; Buffer: PByte; Reserved: Pointer): HRESULT; stdcall;
    function Close: HRESULT; stdcall;
  end;

implementation

end.
