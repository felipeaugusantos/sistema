unit untIContabilidade;

interface

uses System.Generics.Collections, Contabilidade.Interfaces;

type
  IParametrosMonitorContabil = interface
    ['{579E3A69-3702-421A-BC2C-684FB52C2525}']
    function EmpresaLancamento(const AValue: String): IParametrosMonitorContabil; overload;
    function EmpresaLancamento: String; overload;
    function IdLancamento: int64; overload;
    function IdLancamento(AValue: int64): IParametrosMonitorContabil; overload;
  end;

  IParametrosGeracaoLanCon = interface
    ['{402A999B-395E-4DF7-9B8A-97D4F4713E70}']
    function TipLan: string; overload;
    function IncDoc: string; overload;
    function Tabela: string; overload;
    function ModLan: integer; overload;
    function Incremento: int64; overload;
    function Reenvio: boolean; overload;
    function TipLan(const AValue: string): IParametrosGeracaoLanCon; overload;
    function IncDoc(const AValue: string): IParametrosGeracaoLanCon; overload;
    function Tabela(const AValue: string): IParametrosGeracaoLanCon; overload;
    function ModLan(const AValue: integer): IParametrosGeracaoLanCon; overload;
    function Incremento(AValue: int64): IParametrosGeracaoLanCon; overload;
    function Reenvio(AValue: boolean): IParametrosGeracaoLanCon; overload;
    function EmpLan: string; overload ;
    function DtaLan: TDateTime; overload ;
    function EmpLan(const AValue: string): IParametrosGeracaoLanCon; overload;
    function DtaLan(const AValue: TDateTime): IParametrosGeracaoLanCon; overload;
    function ArrIncDoc(const AValue: TArrIncDoc): IParametrosGeracaoLanCon; overload;
    function ArrIncDoc: TArrIncDoc; overload ;
  end;

  IParametrosUpdateLogCon = interface
    ['{C7405BF1-856E-4547-88B4-C3EF633D38C4}']
    function Origem: string; overload;
    function Inconsistencia: string; overload;
    function Historico: string; overload;
    function DescricaoValor: string; overload;
    function NaturezaOperacao: string; overload;
    function Processado: integer; overload;
    function Status: string; overload;
    function Incremento: int64; overload;
    function Reenvio: boolean; overload;
    function Origem(AValue: string): IParametrosUpdateLogCon; overload;
    function Inconsistencia(AValue: string): IParametrosUpdateLogCon; overload;
    function Historico(AValue: string): IParametrosUpdateLogCon; overload;
    function DescricaoValor(AValue: string): IParametrosUpdateLogCon; overload;
    function NaturezaOperacao(AValue: string): IParametrosUpdateLogCon; overload;
    function Processado(AValue: integer): IParametrosUpdateLogCon; overload;
    function Status(AValue: string): IParametrosUpdateLogCon; overload;
    function Incremento(AValue: int64): IParametrosUpdateLogCon; overload;
    function Reenvio(AValue: boolean): IParametrosUpdateLogCon; overload;
  end;

  ILancarLanCon = interface
    ['{3D96ABD8-F00E-45B3-B55D-103C58AF08D5}']
    procedure Execute;
  end;

  IFactoryLancarLanCon = interface
    ['{D899539F-445F-409D-B019-0EDE18E2AB4D}']
    procedure Execute(AParams: IParametrosGeracaoLanCon);
  end;

  IUpdateLogCon = interface
    ['{C493D45F-F055-4ED2-9117-7F209ED6F972}']
    procedure Execute(AParams: TList<IParametrosUpdateLogCon>; AFiltroExcecao: String);
  end;

  IFactoryUpdateLogCon = interface
    ['{A762A6CC-4886-473D-8E98-4A55410DE728}']
    procedure Execute(AParams: TList<IParametrosUpdateLogCon>; AFiltroExcecao: String);
  end;

implementation

end.
