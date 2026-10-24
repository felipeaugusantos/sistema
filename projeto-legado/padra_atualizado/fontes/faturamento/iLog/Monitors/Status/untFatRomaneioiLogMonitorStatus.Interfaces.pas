unit untFatRomaneioiLogMonitorStatus.Interfaces;

interface

type
  IParamiLog = interface
  ['{E9173092-94C3-4EA5-8E96-6DBB35693EC1}']
    function IdCarga(const AValue: String): IParamiLog; overload;
    function NumRom(const AValue: String): IParamiLog; overload;
    function EmpRom(const AValue: String): IParamiLog; overload;
    function NumDoc(const AValue: String): IParamiLog; overload;
    function EspDoc(const AValue: String): IParamiLog; overload;
    function CodEmp(const AValue: String): IParamiLog; overload;
    function CodCli(const AValue: String): IParamiLog; overload;
    function CodVen(const AValue: String): IParamiLog; overload;
    function CodMot(const AValue: String): IParamiLog; overload;
    function DtaRom(const AValue: TDateTime): IParamiLog; overload;
    function HorRom(const AValue: TDateTime): IParamiLog; overload;
    function Observ(const AValue: String): IParamiLog; overload;

    function IdCarga: String; overload;
    function NumRom: String; overload;
    function EmpRom: String; overload;
    function NumDoc: String; overload;
    function EspDoc: String; overload;
    function CodEmp: String; overload;
    function CodCli: String; overload;
    function CodVen: String; overload;
    function CodMot: String; overload;
    function DtaRom: TDateTime; overload;
    function HorRom: TDateTime; overload;
    function Observ: String; overload;
  end;

implementation

end.
