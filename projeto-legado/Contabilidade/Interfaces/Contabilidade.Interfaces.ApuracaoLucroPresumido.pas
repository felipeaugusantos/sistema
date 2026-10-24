unit Contabilidade.Interfaces.ApuracaoLucroPresumido;

interface

uses System.Generics.Collections, Contabilidade.Interfaces.SharedLucroPresumido,
     Data.DB, Contabilidade.Interfaces.ConfigLucroPresumido, Datasnap.DBClient,
     UniClientDataSet, Uni ;

type
  IDadosApuracaoLucroPresumidoPeriodo = interface ;
  IDadosApuracaoLucroPresumidoPlanco = interface ;
  ITipoLinhasSemInformacao = interface ;

  IDadosApuracaoLucroPresumidoGeral = interface
    ['{50528927-BCD2-4A65-BD1A-8EB693C2B4FF}']
    function Autoincrem: String ; overload ;
    function Autoincrem(const AstrValue: String): IDadosApuracaoLucroPresumidoGeral ; overload ;
    function Codigo: String ; overload ;
    function Codigo(const AstrValue: String): IDadosApuracaoLucroPresumidoGeral ; overload ;
    function CodEmp: String ; overload ;
    function CodEmp(const AstrValue: String): IDadosApuracaoLucroPresumidoGeral ; overload ;
    function Exerci: Integer ; overload ;
    function Exerci(const AintValue: Integer): IDadosApuracaoLucroPresumidoGeral ; overload ;
  end ;

  IDadosApuracaoLucroPresumidoDetalhe = interface
    ['{4FC0F5F0-CE98-409D-BBC1-105BE426D495}']
    function Autoincrem: String ; overload ;
    function Autoincrem(const AstrValue: String): IDadosApuracaoLucroPresumidoDetalhe ; overload ;
    function Codigo: String ; overload ;
    function Codigo(const AstrValue: String): IDadosApuracaoLucroPresumidoDetalhe ; overload ;
    function SeqGer: String ; overload ;
    function SeqGer(const AstrValue: String): IDadosApuracaoLucroPresumidoDetalhe ; overload ;
    function Config: Integer ; overload ;
    function Config(const AintValue: Integer): IDadosApuracaoLucroPresumidoDetalhe ; overload ;
    function CodPar: String ; overload ;
    function CodPar(const AstrValue: String): IDadosApuracaoLucroPresumidoDetalhe ; overload ;
    function Descri: String ; overload ;
    function Descri(const AstrValue: String): IDadosApuracaoLucroPresumidoDetalhe ; overload ;
    function Porcen: Double ; overload ;
    function Porcen(const AfltValue: Double): IDadosApuracaoLucroPresumidoDetalhe ; overload ;
    function Periodos: TList<IDadosApuracaoLucroPresumidoPeriodo> ; overload ;
    function Periodos(AItem: IDadosApuracaoLucroPresumidoPeriodo): IDadosApuracaoLucroPresumidoDetalhe ; overload ;
    function Planco: TList<IDadosApuracaoLucroPresumidoPlanco> ; overload ;
    function Planco(AItem: IDadosApuracaoLucroPresumidoPlanco): IDadosApuracaoLucroPresumidoDetalhe ; overload ;
  end ;

  IDadosApuracaoLucroPresumidoPeriodo = interface
    ['{BB52926E-448A-4EE3-9A22-29E835C97628}']
    function Autoincrem: String ; overload ;
    function Autoincrem(const AstrValue: String): IDadosApuracaoLucroPresumidoPeriodo ; overload ;
    function SeqGer: String ; overload ;
    function SeqGer(const AstrValue: String): IDadosApuracaoLucroPresumidoPeriodo ; overload ;
    function Period: Integer ; overload ;
    function Period(const AintValue: Integer): IDadosApuracaoLucroPresumidoPeriodo ; overload ;
    function Apuval: Double ; overload ;
    function Apuval(const AfltValue: Double): IDadosApuracaoLucroPresumidoPeriodo ; overload ;
  end ;

  IDadosApuracaoLucroPresumidoPlanco = interface
    ['{8331CE51-744C-433F-A266-8AA5F5AAAFB0}']
    function Config: Integer ; overload ;
    function Config(const AintValue: Integer): IDadosApuracaoLucroPresumidoPlanco ; overload ;
    function CodCon: String ; overload ;
    function CodCon(const AstrValue: String): IDadosApuracaoLucroPresumidoPlanco ; overload ;
    function TpLaCo: String ; overload ;
    function TpLaCo(const AstrValue: String): IDadosApuracaoLucroPresumidoPlanco ; overload ;
  end ;

  IDadosApuracaoLucroPresumido = interface
    ['{45B6C52F-2FA8-48F3-8F84-F4881FDA8ECA}']
    function Geral: IDadosApuracaoLucroPresumidoGeral; overload ;
    function Geral(const AValue: IDadosApuracaoLucroPresumidoGeral): IDadosApuracaoLucroPresumido; overload ;
    function BaseCalculo: TList<IDadosApuracaoLucroPresumidoDetalhe>; overload ;
    function BaseCalculo(AItem: IDadosApuracaoLucroPresumidoDetalhe): IDadosApuracaoLucroPresumido; overload ;
    function CalculoImposto: TList<IDadosApuracaoLucroPresumidoDetalhe>; overload ;
    function CalculoImposto(AItem: IDadosApuracaoLucroPresumidoDetalhe): IDadosApuracaoLucroPresumido; overload ;
  end ;

  ITipoApuracaoLucroPresumidoPreparaCarrega = interface
    ['{E57AF4B8-8BFF-4FFD-BDB2-151C1F6F3A07}']
    function fPrepara(const AqryGeral, AqryDetalhe, AqryDetalhePeriodo, AqryPlanco: TDataset;
                            AobjCfg: IDadosConfigLucroPresumidoCfg;
                            AcdsLancon: TUniClientDataSet): IDadosApuracaoLucroPresumido ;
  end ;

  ITipoApuracaoLucroPresumidoConverte = interface
    ['{E2B830D4-DFB4-4497-9007-A7E0385D41EB}']
    function fConverte(Const AcdsBaseCalculo, AcdsApuracaoValor: TUniClientDataSet): IDadosApuracaoLucroPresumido ;
    function CodEmp(const AstrValue: String): ITipoApuracaoLucroPresumidoConverte ;
    function Codigo(const AstrValue: String): ITipoApuracaoLucroPresumidoConverte ;
    function Exerci(const AintValue: Integer): ITipoApuracaoLucroPresumidoConverte ;
  end ;

  ITipoApuracaoLucroPresumidoSalva = interface
    ['{61883E5F-78F7-46D5-B1DD-CF66E598F0F8}']
    function fSalva(const AApuracao: IDadosApuracaoLucroPresumido): Boolean;
  end ;

  ITipoApuracaoLucroPresumidoCarrega = interface
    ['{B63609DC-3F52-4FBF-9254-1D19F0B0480D}']
    function fCarrega(const AstrCodEmp: String; const AintExercicio: Integer; var AstrMensagem: String): IDadosApuracaoLucroPresumido;
    function ProcessaLanCon(const AblnValue: Boolean): ITipoApuracaoLucroPresumidoCarrega ;
  end ;

  ITipoApuracaoLucroPresumidoDelete = interface
    ['{8B65052C-75B7-41CF-8190-34445D8EE337}']
    function fDelete(const AstrCodigo: String): Boolean;
  end ;

  ITipoApuracaoLucroPresumidoProcessaCalculos = interface
    ['{0225E345-A7F2-426B-979C-BFA7F1EDFD45}']
    function CdsBaseCalculo(var Acds: TUniClientDataSet): ITipoApuracaoLucroPresumidoProcessaCalculos;
    function CdsApuracao(var Acds: TUniClientDataSet): ITipoApuracaoLucroPresumidoProcessaCalculos;
    function fProcessar(const ADados: IDadosApuracaoLucroPresumido): boolean ;
    function fReprocessar(const AstrCodEmp: String; const AintExercicio: Integer): boolean ;
    function fLinhaSemDados(const AobjLinhaSemDados: ITipoLinhasSemInformacao): ITipoApuracaoLucroPresumidoProcessaCalculos;
  end ;

  ITipoTrimestres = interface
    ['{C66A0BEB-5277-4477-B30D-2FCB8CB2B97E}']
    function Exerci(const AintValue: Integer): ITipoTrimestres ; overload ;
    function IniAtv(const AdtaValue: TDateTime): ITipoTrimestres ; overload ;
    function MesesValidos: TList<Integer> ;
  end ;

  ITipoLinhasSemEdicao = interface
    ['{C81877A6-4DBC-46A1-9F5A-3FC253C8D5D0}']
    function fGrupo(const AstrGrupo: String): ITipoLinhasSemEdicao ;
    function fLinha(const AstrLinha: String): ITipoLinhasSemEdicao ;
    function fPodeEditar: Boolean ;
  end ;

  ITipoLinhasSemInformacao = interface
    ['{6DA46B45-C03C-4CEA-A3B0-6AF0C88D9E94}']
    function fGrupo(const AstrGrupo: String): ITipoLinhasSemInformacao ;
    function fLinha(const AstrLinha: String): ITipoLinhasSemInformacao ;
    function fTemInformacao: Boolean ;
  end ;

  ITipoFiltroLancon = interface
    ['{19504466-3BD2-4B21-8F74-9B86A603E8A0}']
    function fCadEmp(const ACadEmp: TDataSet): ITipoFiltroLancon ;
    function fPlanco(const APlancoConfig: TDataSet): ITipoFiltroLancon ;
    function fColunaPlanoContas(const AstrNomeColuna: String): ITipoFiltroLancon ;
    function ProcessaLanCon(const AblnValue: Boolean): ITipoFiltroLancon ;
    procedure pGeraFiltro(var AqryLancon: TUniQuery) ;
  end ;

  IFactoryApuracaoLucroPresumidoSalva = interface
    ['{B9AA1B21-1AA1-409D-A251-6354EED3AB85}']
    function fConfigura(ATipo: TTipoLucroPresumido): ITipoApuracaoLucroPresumidoSalva ;
  end ;

  IFactoryApuracaoLucroPresumidoCarrega = interface
    ['{1C4DD627-3916-4B25-B962-7E23167DF91E}']
    function fConfigura(ATipo: TTipoLucroPresumido): ITipoApuracaoLucroPresumidoCarrega ;
  end ;

  IFactoryApuracaoLucroPresumidoDelete = interface
    ['{4E045A4C-2D99-4000-9BDB-16DE124D06C7}']
    function fConfigura(ATipo: TTipoLucroPresumido): ITipoApuracaoLucroPresumidoDelete ;
  end ;

  IFactoryApuracaoLucroPresumidoProcessaCalculos = interface
    ['{E24D0044-A3F0-42D5-9953-4242EACFAC36}']
    function fConfigura(ATipo: TTipoLucroPresumido): ITipoApuracaoLucroPresumidoProcessaCalculos ;
  end ;

  IFactoryLinhasSemEdicao = interface
    ['{DB98BBC2-408E-4625-9DD7-2EF679BA9F9C}']
    function fConfigura(ATipo: TTipoLucroPresumido): ITipoLinhasSemEdicao ;
  end ;

  IFactoryLinhasSemInformacao = interface
    ['{DB98BBC2-408E-4625-9DD7-2EF679BA9F9C}']
    function fConfigura(ATipo: TTipoLucroPresumido): ITipoLinhasSemInformacao ;
  end ;

implementation

end.
