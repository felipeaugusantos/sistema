unit untFatRomaneioiLogMonitorSend.Interfaces;

interface

type
  IParamiLog = interface
  ['{E9173092-94C3-4EA5-8E96-6DBB35693EC1}']
    function Autoincrem(const AValue: String): IParamiLog; overload;
    function CodRom(const AValue: String): IParamiLog; overload;

    function Autoincrem: String; overload;
    function CodRom: String; overload;
  end;

  IUpdateiLog = interface
  ['{DE8A9F8F-F5D2-4CC0-987C-FD91271D3151}']
    procedure Execute;
  end;

  IInvokerUpdateiLog = interface
  ['{8996D429-23CA-483D-82E3-C60F1E481194}']
    procedure Add(ACommand: IUpdateiLog);
    procedure Execute;
  end;


implementation

end.
