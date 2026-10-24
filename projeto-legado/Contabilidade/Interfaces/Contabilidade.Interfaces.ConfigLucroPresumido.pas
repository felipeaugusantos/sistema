unit Contabilidade.Interfaces.ConfigLucroPresumido;

interface

uses System.Generics.Collections, Data.DB, MemDS, DBAccess,
  Uni, untFuncoesSimples, Datasnap.DBClient, UniClientDataSet,
  Contabilidade.Interfaces.SharedLucroPresumido ;

type

  IInfoColunaDataSet = Interface
    ['{5B6D4B11-1D29-4AFF-A670-9E89DEAD9FBA}']
    Function NomeColuna: String ; overload ;
    Function NomeColuna(const AstrValue: String): IInfoColunaDataSet ; overload ;
    function TipoColuna: TFieldType ; overload ;
    function TipoColuna(const AValue: TFieldType): IInfoColunaDataSet overload ;
    function TamanhoColuna: Integer ; overload ;
    function TamanhoColuna(const AValue: Integer): IInfoColunaDataSet overload ;
  end ;

  IInfoColunasDataSet = interface
    ['{483D6CA5-166A-4C16-A6E7-818F2A42741F}']
    function fColunas: TList<IInfoColunaDataSet> ;
  end ;

  IDadosConfigLucroPresumidoCfgGeral = interface
    ['{E41EF64C-19BD-40F7-8B32-78D76AF67A2C}']
    function Autoincrem: String ; overload ;
    function Autoincrem(const AstrValue: String): IDadosConfigLucroPresumidoCfgGeral ; overload ;
    function Codigo: String ; overload ;
    function Codigo(const AstrValue: String): IDadosConfigLucroPresumidoCfgGeral ; overload ;
    function CodEmp: String ; overload ;
    function CodEmp(const AstrValue: String): IDadosConfigLucroPresumidoCfgGeral ; overload ;
    function NomEmp: String ; overload ;
    function NomEmp(const AstrValue: String): IDadosConfigLucroPresumidoCfgGeral ; overload ;
    function Exerci: Integer ; overload ;
    function Exerci(const AintValue: Integer): IDadosConfigLucroPresumidoCfgGeral ; overload ;
  end ;

  IDadosConfigLucroPresumidoCfgGeralLanCon = interface
    ['{72098B5C-DE79-4C3D-BC6E-2C5A1FF187F8}']
    function Autoincrem: String ; overload ;
    function Autoincrem(const AstrValue: String): IDadosConfigLucroPresumidoCfgGeralLanCon ; overload ;
    function SeqGer: String ; overload ;
    function SeqGer(const AstrValue: String): IDadosConfigLucroPresumidoCfgGeralLanCon ; overload ;
    function HisPad: Integer ; overload ;
    function HisPad(const AintValue: Integer): IDadosConfigLucroPresumidoCfgGeralLanCon ; overload ;
    function Histor: String ; overload ;
    function Histor(const AstrValue: String): IDadosConfigLucroPresumidoCfgGeralLanCon ; overload ;
    function CodCon: String ; overload ;
    function CodCon(const AstrValue: String): IDadosConfigLucroPresumidoCfgGeralLanCon ; overload ;
  end ;

  IDadosConfigLucroPresumidoCfgDetalheContas = interface
    ['{40ECCA48-8699-473A-8674-90BAF8AF9AFC}']
    function Autoincrem: String ; overload ;
    function Autoincrem(const AstrValue: String): IDadosConfigLucroPresumidoCfgDetalheContas ; overload ;
    function SeqGer: String ; overload ;
    function SeqGer(const AstrValue: String): IDadosConfigLucroPresumidoCfgDetalheContas ; overload ;
    function CodCon: String ; overload ;
    function CodCon(const AstrValue: String): IDadosConfigLucroPresumidoCfgDetalheContas ; overload ;
    function TpLaCo: String ; overload ;
    function TpLaCo(const AstrValue: String): IDadosConfigLucroPresumidoCfgDetalheContas ; overload ;
  end ;

  IDadosConfigLucroPresumidoCfgDetalhe = interface
    ['{A2E0D90F-6D97-4B01-AFE4-5335D1452578}']
    function Autoincrem: String ; overload ;
    function Autoincrem(const AstrValue: String): IDadosConfigLucroPresumidoCfgDetalhe ; overload ;
    function Codigo: String ; overload ;
    function Codigo(const AstrValue: String): IDadosConfigLucroPresumidoCfgDetalhe ; overload ;
    function SeqGer: String ; overload ;
    function SeqGer(const AstrValue: String): IDadosConfigLucroPresumidoCfgDetalhe ; overload ;
    function Config: Integer ; overload ;
    function Config(const AintValue: Integer): IDadosConfigLucroPresumidoCfgDetalhe ; overload ;
    function Grupo_: String ; overload ;
    function Grupo_(const AstrValue: String): IDadosConfigLucroPresumidoCfgDetalhe ; overload ;
    function CodPar: String ; overload ;
    function CodPar(const AstrValue: String): IDadosConfigLucroPresumidoCfgDetalhe ; overload ;
    function Descri: String ; overload ;
    function Descri(const AstrValue: String): IDadosConfigLucroPresumidoCfgDetalhe ; overload ;
    function Porcen: Double ; overload ;
    function Porcen(const AfltValue: Double): IDadosConfigLucroPresumidoCfgDetalhe ; overload ;
    function Contas: TList<IDadosConfigLucroPresumidoCfgDetalheContas> ; overload ;
    function Contas(AItem: IDadosConfigLucroPresumidoCfgDetalheContas): IDadosConfigLucroPresumidoCfgDetalhe ; overload ;
  end ;

  IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC = interface
    ['{AC07D0F7-3E9C-4F6F-8112-01A91DCE47E8}']
    function Autoincrem: Integer ; overload ;
    function Autoincrem(const AintValue: Integer): IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC ; overload ;
    function Codigo: String ; overload ;
    function Codigo(const AstrValue: String): IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC ; overload ;
    function Descri: String ; overload ;
    function Descri(const AstrValue: String): IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC ; overload ;
    function Grupo_: String ; overload ;
    function Grupo_(const AstrValue: String): IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC ; overload ;
    function Sequen: String ; overload ;
    function Sequen(const AstrValue: String): IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC ; overload ;
    function Porcen: Double ; overload ;
    function Porcen(const AfltValue: Double): IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC ; overload ;
    function Parame: String ; overload ;
    function Parame(const AstrValue: String): IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC ; overload ;
  end ;

  IDadosConfigLucroPresumidoCfg = interface
    ['{CE60B463-2E56-47B4-A195-BBAAD85C1AB6}']
    function Geral: IDadosConfigLucroPresumidoCfgGeral; overload ;
    function Geral(const AValue: IDadosConfigLucroPresumidoCfgGeral): IDadosConfigLucroPresumidoCfg; overload ;
    function GeralLanCon: IDadosConfigLucroPresumidoCfgGeralLanCon; overload ;
    function GeralLanCon(const AValue: IDadosConfigLucroPresumidoCfgGeralLanCon): IDadosConfigLucroPresumidoCfg; overload ;
    function Detalhe: TList<IDadosConfigLucroPresumidoCfgDetalhe>; overload ;
    function Detalhe(AItem: IDadosConfigLucroPresumidoCfgDetalhe): IDadosConfigLucroPresumidoCfg; overload ;
  end ;

  ITipoConfigLucroPresumidoPreparaCarrega = interface
    ['{E493989F-303E-432E-B7D1-F6B5B4D1B616}']
    function fPrepara(const AqryGeral, AqryGeralLancon, AqryDetalhe: TDataset;
                      const AcdsDetalhePlanco: TDataset): IDadosConfigLucroPresumidoCfg ;
  end ;

  ITipoConfigLucroPresumidoSalva = interface
    ['{190A9BDE-FD1B-497C-9ABF-C7B13ADB4DC4}']
    function fSalva(const ACfg: IDadosConfigLucroPresumidoCfg): Boolean;
  end ;

  ITipoConfigLucroPresumidoCarrega = interface
    ['{E394FA33-5D38-4514-BF3F-2EAAEF14ADF2}']
    function fCarrega(const AstrCodEmp: String; const AintExercicio: Integer; var AstrMensagem: String): IDadosConfigLucroPresumidoCfg;
    function fFiltroParame(const AstrParame: String): ITipoConfigLucroPresumidoCarrega ;
  end ;

  ITipoConfigLucroPresumidoDelete = interface
    ['{EFF454B6-8C24-4780-AC5C-BC88687E3369}']
    function fDelete(const AstrCodigo: String): Boolean;
  end ;

  ITipoConfigLucroPresumidoClona = interface
    ['{BECE6704-AE66-43DB-AA07-15CBAD9CBB2F}']
    function fClona(const AstrCodEmpDest: String; const AintExercicioDest: Integer; const AItem: IDadosConfigLucroPresumidoCfg): Boolean;
  end ;

  ITipoConfigLucroPresumidoConverte = interface
    ['{4A1DD9D4-5D1F-4E62-8931-A157C77F5BA9}']
    function fConverte(Const AcdsGeral, AcdsGeralLancon, AcdsDetalhe, AcdsDetalhePlanco: TUniClientDataSet): IDadosConfigLucroPresumidoCfg ;
  end ;

  ITipoConfigLucroPresumidoCadastroTabelaApuracaoBC = interface
    ['{57E83F92-95EB-4AF0-BBD4-986D25B17DA0}']
    function fFiltroParame(const AstrParame: String): ITipoConfigLucroPresumidoCadastroTabelaApuracaoBC ;
    function fSeleciona(): TList<IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC>  ;
  end ;

  ITipoConfigLucroPresumidoPreparaCadastroTabelaApuracaoBC = interface
    ['{E493989F-303E-432E-B7D1-F6B5B4D1B616}']
    function fListaProcessada: TList<IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC> ;
    function fSetLista(AlstLista: TList<IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC>): ITipoConfigLucroPresumidoPreparaCadastroTabelaApuracaoBC ;
    function fPrepara(const AqryTabela: TUniQuery): ITipoConfigLucroPresumidoPreparaCadastroTabelaApuracaoBC ;
  end ;

  ICopiarConfiguracaoLucroPresumidoDe = interface
    ['{E9828B6B-15E6-48EB-BA18-96B2976FA1F8}']
    function fConfiguracao: TList<IDadosConfigLucroPresumidoCfgGeral> ;
  end ;

  IFactoryConfigLucroPresumidoSalva = interface
    ['{4C3F6D35-30A4-4DD9-A8E1-691AA1716115}']
    function fConfigura(ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoSalva ;
  end ;

  IFactoryConfigLucroPresumidoCarrega = interface
    ['{93027C5B-FD9E-45CD-A50B-CE5210874246}']
    function fConfigura(ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoCarrega ;
  end ;

  IFactoryConfigLucroPresumidoDelete = interface
    ['{3998B93D-AA83-415A-AD52-0ABC0FB2255A}']
    function fConfigura(ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoDelete ;
  end ;

  IFactoryConfigLucroPresumidoClona = interface
    ['{A4643137-1948-4317-B9E8-2F0855DA232F}']
    function fConfigura(ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoClona ;
  end ;

  IFactoryConfigLucroPresumidoCadastroTabelaApuracaoBC = interface
    ['{C5AF263C-C501-4D29-93E0-0505DE02776C}']
    function fConfigura(ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoCadastroTabelaApuracaoBC ;
  end ;

  IFactoryConfigLucroPresumidoConverte = interface
    ['{4788E77F-4EF3-4519-AF28-FF182068956A}']
    function fConfigura(ATipo: TTipoLucroPresumido): ITipoConfigLucroPresumidoConverte ;
  end ;


implementation

end.
