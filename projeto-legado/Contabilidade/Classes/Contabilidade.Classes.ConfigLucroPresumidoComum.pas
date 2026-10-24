unit Contabilidade.Classes.ConfigLucroPresumidoComum;

interface

uses
  Contabilidade.Interfaces.ConfigLucroPresumido, System.Generics.Collections, Data.DB, MemDS, DBAccess,
  Uni, untFuncoesSimples, Datasnap.DBClient, UniClientDataSet, Contabilidade.Interfaces.SharedLucroPresumido ;

type

  TCopiarConfiguracaoLucroPresumidoDe = class(TInterfacedObject, ICopiarConfiguracaoLucroPresumidoDe)
  private
    FlstConfs: TList<IDadosConfigLucroPresumidoCfgGeral> ;
  public
    function fConfiguracao: TList<IDadosConfigLucroPresumidoCfgGeral> ;
    class function New: ICopiarConfiguracaoLucroPresumidoDe ;
    constructor Create;
    destructor Destroy; override ;
  end ;

  TColunaDetalhePlanco = class(TInterfacedObject, IColunaDetalhePlanco)
  public
    function fRetornaColuna(const AstrValorCodigoDetalhe: String): String ;
    class function New: IColunaDetalhePlanco ;
  end ;

  TInfoColunaDataSet = class(TInterfacedObject, IInfoColunaDataSet)
  private
    FstrNomeColuna: String ;
    FintTamanhoColuna: Integer ;
    FTipoColuna: TFieldType ;
  public
    Function NomeColuna: String ; overload ;
    Function NomeColuna(const AstrValue: String): IInfoColunaDataSet ; overload ;
    function TipoColuna: TFieldType ; overload ;
    function TipoColuna(const AValue: TFieldType): IInfoColunaDataSet overload ;
    function TamanhoColuna: Integer ; overload ;
    function TamanhoColuna(const AValue: Integer): IInfoColunaDataSet overload ;
    constructor Create ;
    class function New: IInfoColunaDataSet ;
  end ;

  TInfoColunasDataSet = class(TInterfacedObject, IInfoColunasDataSet)
  strict protected
    FlstColunas: TList<IInfoColunaDataSet> ;
  public
    function fColunas: TList<IInfoColunaDataSet>; virtual; abstract ;
    constructor Create;
    destructor Destroy; override ;
    class function New: IInfoColunasDataSet;
  end ;

  TInfoColunasDataSetConfigGeral = class(TInfoColunasDataSet)
  public
    function fColunas: TList<IInfoColunaDataSet>; override ;
  end ;

  TInfoColunasDataSetConfigGeralLancon = class(TInfoColunasDataSet)
  public
    function fColunas: TList<IInfoColunaDataSet>; override ;
  end ;

  TInfoColunasDataSetConfigDetalhe = class(TInfoColunasDataSet)
  public
    function fColunas: TList<IInfoColunaDataSet>; override ;
  end ;

  TInfoColunasDataSetConfigDetalhePlanco = class(TInfoColunasDataSet)
  public
    function fColunas: TList<IInfoColunaDataSet>; override ;
  end ;

  TDadosConfigLucroPresumidoCfgGeral = class(TInterfacedObject, IDadosConfigLucroPresumidoCfgGeral)
  private
    FstrAutoincrem: String ;
    FstrCodigo: String ;
    FstrCodEmp: String ;
    FstrNomEmp: String ;
    FintExerci: Integer ;
  public
    function Autoincrem: String ; overload ;
    function Autoincrem(const AstrValue: String): IDadosConfigLucroPresumidoCfgGeral ; overload ;
    function Codigo: String ; overload ;
    function Codigo(const AstrValue: String): IDadosConfigLucroPresumidoCfgGeral ; overload ;
    function CodEmp: String ; overload ;
    function CodEmp(const AstrValue: String): IDadosConfigLucroPresumidoCfgGeral ; overload ;
    function Exerci: Integer ; overload ;
    function Exerci(const AintValue: Integer): IDadosConfigLucroPresumidoCfgGeral ; overload ;
    function NomEmp: String ; overload ;
    function NomEmp(const AstrValue: String): IDadosConfigLucroPresumidoCfgGeral ; overload ;
    constructor Create;
    class function New: IDadosConfigLucroPresumidoCfgGeral;
  end ;

  TDadosConfigLucroPresumidoCfgGeralLanCon = class(TInterfacedObject, IDadosConfigLucroPresumidoCfgGeralLanCon)
  private
    FstrAutoincrem: String ;
    FstrSeqGer: String ;
    FintHisPad: Integer ;
    FstrHistor: String ;
    FstrCodCon: String ;
  public
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
    constructor Create;
    class function New: IDadosConfigLucroPresumidoCfgGeralLanCon;
  end ;

  TDadosConfigLucroPresumidoCfgDetalheContas = class(TInterfacedObject, IDadosConfigLucroPresumidoCfgDetalheContas)
  private
    FstrAutoincrem: String ;
    FstrSeqGer: String ;
    FstrCodCon: String ;
    FstrTpLaCo: String ;
  public
    function Autoincrem: String ; overload ;
    function Autoincrem(const AstrValue: String): IDadosConfigLucroPresumidoCfgDetalheContas ; overload ;
    function SeqGer: String ; overload ;
    function SeqGer(const AstrValue: String): IDadosConfigLucroPresumidoCfgDetalheContas ; overload ;
    function CodCon: String ; overload ;
    function CodCon(const AstrValue: String): IDadosConfigLucroPresumidoCfgDetalheContas ; overload ;
    function TpLaCo: String ; overload ;
    function TpLaCo(const AstrValue: String): IDadosConfigLucroPresumidoCfgDetalheContas ; overload ;
    constructor Create;
    class function New: IDadosConfigLucroPresumidoCfgDetalheContas;
  end ;

  TDadosConfigLucroPresumidoCfgDetalhe = class(TInterfacedObject, IDadosConfigLucroPresumidoCfgDetalhe)
  private
    FstrAutoincrem: String ;
    FstrCodigo: String ;
    FstrSeqGer: String ;
    FstrGrupo_: String ;
    FintConfig: Integer ;
    FlstContas: TList<IDadosConfigLucroPresumidoCfgDetalheContas> ;
    FstrCodPar: String ;
    FstrDescri: String ;
    FfltPorcen: Double ;
  public
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
    constructor Create;
    destructor Destroy; override ;
    class function New: IDadosConfigLucroPresumidoCfgDetalhe;
  end ;

  TDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC = class(TInterfacedObject, IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC)
  private
    FintAutoincrem: Integer ;
    FstrCodigo: String ;
    FstrDescri: String ;
    FstrGrupo_: String ;
    FstrSequen: String ;
    FfltPorcen: Double ;
    FstrParame: String ;
  public
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
    constructor Create;
    class function New: IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC;
  end ;

  TDadosConfigLucroPresumidoCfg = class(TInterfacedObject, IDadosConfigLucroPresumidoCfg)
  private
    FGeral: IDadosConfigLucroPresumidoCfgGeral ;
    FGeralLanCon: IDadosConfigLucroPresumidoCfgGeralLanCon ;
    FlstDetalhe: TList<IDadosConfigLucroPresumidoCfgDetalhe> ;
  public
    function Geral: IDadosConfigLucroPresumidoCfgGeral; overload ;
    function Geral(const AValue: IDadosConfigLucroPresumidoCfgGeral): IDadosConfigLucroPresumidoCfg; overload ;
    function GeralLanCon: IDadosConfigLucroPresumidoCfgGeralLanCon; overload ;
    function GeralLanCon(const AValue: IDadosConfigLucroPresumidoCfgGeralLanCon): IDadosConfigLucroPresumidoCfg; overload ;
    function Detalhe: TList<IDadosConfigLucroPresumidoCfgDetalhe>; overload ;
    function Detalhe(AItem: IDadosConfigLucroPresumidoCfgDetalhe): IDadosConfigLucroPresumidoCfg; overload ;
    constructor Create;
    destructor Destroy; override ;
    class function New: IDadosConfigLucroPresumidoCfg;
  end ;

  TTipoConfigLucroPresumidoPreparaCarrega = class(TInterfacedObject, ITipoConfigLucroPresumidoPreparaCarrega)
  public
    function fPrepara(const AqryGeral, AqryGeralLancon, AqryDetalhe: TDataSet;
                      const AcdsDetalhePlanco: TDataSet): IDadosConfigLucroPresumidoCfg ;
    class function New: ITipoConfigLucroPresumidoPreparaCarrega;
  end ;

  TTipoConfigLucroPresumidoPreparaCadastroTabelaApuracaoBC = class(TInterfacedObject, ITipoConfigLucroPresumidoPreparaCadastroTabelaApuracaoBC)
  private
    FlstLista: TList<IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC> ;
  public
    function fPrepara(const AqryTabela: TUniQuery): ITipoConfigLucroPresumidoPreparaCadastroTabelaApuracaoBC ;
    function fListaProcessada: TList<IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC> ;
    function fSetLista(AlstLista: TList<IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC>): ITipoConfigLucroPresumidoPreparaCadastroTabelaApuracaoBC ;
    class function New: ITipoConfigLucroPresumidoPreparaCadastroTabelaApuracaoBC;
    constructor Create;
  end ;

  TTipoConfigLucroPresumidoConverte = class(TInterfacedObject, ITipoConfigLucroPresumidoConverte)
  public
    function fConverte(Const AcdsGeral, AcdsGeralLancon, AcdsDetalhe, AcdsDetalhePlanco: TUniClientDataSet): IDadosConfigLucroPresumidoCfg ;
    class function New: ITipoConfigLucroPresumidoConverte;
  end ;

implementation

uses
  SysUtils ;

{ TDadosConfigLucroPresumidoCfgGeral }

function TDadosConfigLucroPresumidoCfgGeral.Autoincrem: String;
begin
  Result := FstrAutoincrem ;
end;

function TDadosConfigLucroPresumidoCfgGeral.Autoincrem(
  const AstrValue: String): IDadosConfigLucroPresumidoCfgGeral;
begin
  Result := Self ;
  FstrAutoincrem := AstrValue ;
end;

function TDadosConfigLucroPresumidoCfgGeral.CodEmp: String;
begin
  Result := FstrCodEmp ;
end;

function TDadosConfigLucroPresumidoCfgGeral.CodEmp(
  const AstrValue: String): IDadosConfigLucroPresumidoCfgGeral;
begin
  Result := Self ;
  FstrCodEmp := AstrValue ;
end;

function TDadosConfigLucroPresumidoCfgGeral.Codigo: String;
begin
  Result := FstrCodigo ;
end;

function TDadosConfigLucroPresumidoCfgGeral.Codigo(
  const AstrValue: String): IDadosConfigLucroPresumidoCfgGeral;
begin
  Result := Self ;
  FstrCodigo := AstrValue ;
end;

constructor TDadosConfigLucroPresumidoCfgGeral.Create;
begin
  FstrAutoincrem := '' ;
  FstrCodigo := '' ;
  FstrCodEmp := '' ;
  FstrNomEmp := '' ;
  FintExerci  := 0 ;
end;

function TDadosConfigLucroPresumidoCfgGeral.Exerci: Integer;
begin
  Result := FintExerci ;
end;

function TDadosConfigLucroPresumidoCfgGeral.Exerci(
  const AintValue: Integer): IDadosConfigLucroPresumidoCfgGeral;
begin
  Result := Self ;
  FintExerci := AintValue ;
end;

class function TDadosConfigLucroPresumidoCfgGeral.New: IDadosConfigLucroPresumidoCfgGeral;
begin
  Result := Self.Create;
end;

function TDadosConfigLucroPresumidoCfgGeral.NomEmp: String;
begin
  Result := FstrNomEmp ;
end;

function TDadosConfigLucroPresumidoCfgGeral.NomEmp(
  const AstrValue: String): IDadosConfigLucroPresumidoCfgGeral;
begin
  Result := Self ;
  FstrNomEmp := AstrValue ;
end;

{ TDadosConfigLucroPresumidoCfgGeralLanCon }

function TDadosConfigLucroPresumidoCfgGeralLanCon.Autoincrem: String;
begin
  Result := FstrAutoincrem ;
end;

function TDadosConfigLucroPresumidoCfgGeralLanCon.Autoincrem(
  const AstrValue: String): IDadosConfigLucroPresumidoCfgGeralLanCon;
begin
  Result := Self ;
  FstrAutoincrem := AstrValue ;
end;

function TDadosConfigLucroPresumidoCfgGeralLanCon.CodCon(
  const AstrValue: String): IDadosConfigLucroPresumidoCfgGeralLanCon;
begin
  Result := Self ;
  FstrCodCon := AstrValue ;
end;

function TDadosConfigLucroPresumidoCfgGeralLanCon.CodCon: String;
begin
  Result := FstrCodCon ;
end;

constructor TDadosConfigLucroPresumidoCfgGeralLanCon.Create;
begin
  FstrAutoincrem := '' ;
  FstrSeqGer := '' ;
  FintHisPad := 0 ;
  FstrHistor := '' ;
  FstrCodCon := '' ;
end;

function TDadosConfigLucroPresumidoCfgGeralLanCon.HisPad: Integer;
begin
  Result := FintHisPad ;
end;

function TDadosConfigLucroPresumidoCfgGeralLanCon.HisPad(
  const AintValue: Integer): IDadosConfigLucroPresumidoCfgGeralLanCon;
begin
  Result := Self ;
  FintHisPad := AintValue ;
end;

function TDadosConfigLucroPresumidoCfgGeralLanCon.Histor: String;
begin
  Result := FstrHistor ;
end;

function TDadosConfigLucroPresumidoCfgGeralLanCon.Histor(
  const AstrValue: String): IDadosConfigLucroPresumidoCfgGeralLanCon;
begin
  Result := Self ;
  FstrHistor := AstrValue ;
end;

class function TDadosConfigLucroPresumidoCfgGeralLanCon.New: IDadosConfigLucroPresumidoCfgGeralLanCon;
begin
  Result := Self.Create;
end;

function TDadosConfigLucroPresumidoCfgGeralLanCon.SeqGer(
  const AstrValue: String): IDadosConfigLucroPresumidoCfgGeralLanCon;
begin
  Result := Self ;
  FstrSeqGer := AstrValue ;
end;

function TDadosConfigLucroPresumidoCfgGeralLanCon.SeqGer: String;
begin
  Result := FstrSeqGer ;
end;

{ TDadosConfigLucroPresumidoCfgDetalheContas }

function TDadosConfigLucroPresumidoCfgDetalheContas.Autoincrem: String;
begin
  Result := FstrAutoincrem ;
end;

function TDadosConfigLucroPresumidoCfgDetalheContas.Autoincrem(
  const AstrValue: String): IDadosConfigLucroPresumidoCfgDetalheContas;
begin
  Result := Self ;
  FstrAutoincrem := AstrValue ;
end;

function TDadosConfigLucroPresumidoCfgDetalheContas.CodCon: String;
begin
  Result := FstrCodCon ;
end;

function TDadosConfigLucroPresumidoCfgDetalheContas.CodCon(
  const AstrValue: String): IDadosConfigLucroPresumidoCfgDetalheContas;
begin
  Result := Self ;
  FstrCodCon := AstrValue ;
end;

constructor TDadosConfigLucroPresumidoCfgDetalheContas.Create;
begin
  FstrAutoincrem := '' ;
  FstrSeqGer := '' ;
  FstrCodCon := '' ;
  FstrTpLaCo := '' ;
end;

class function TDadosConfigLucroPresumidoCfgDetalheContas.New: IDadosConfigLucroPresumidoCfgDetalheContas;
begin
  Result := Self.Create;
end;

function TDadosConfigLucroPresumidoCfgDetalheContas.SeqGer(
  const AstrValue: String): IDadosConfigLucroPresumidoCfgDetalheContas;
begin
  Result := Self ;
  FstrSeqGer := AstrValue ;
end;

function TDadosConfigLucroPresumidoCfgDetalheContas.SeqGer: String;
begin
Result := FstrSeqGer ;
end;

function TDadosConfigLucroPresumidoCfgDetalheContas.TpLaCo(
  const AstrValue: String): IDadosConfigLucroPresumidoCfgDetalheContas;
begin
  Result := Self ;
  FstrTpLaCo := AstrValue ;
end;

function TDadosConfigLucroPresumidoCfgDetalheContas.TpLaCo: String;
begin
Result := FstrTpLaCo ;
end;

{ TDadosConfigLucroPresumidoCfgDetalhe }

function TDadosConfigLucroPresumidoCfgDetalhe.Autoincrem: String;
begin
  Result := FstrAutoincrem ;
end;

function TDadosConfigLucroPresumidoCfgDetalhe.Autoincrem(
  const AstrValue: String): IDadosConfigLucroPresumidoCfgDetalhe;
begin
  Result := Self ;
  FstrAutoincrem := AstrValue ;
end;

function TDadosConfigLucroPresumidoCfgDetalhe.Codigo(
  const AstrValue: String): IDadosConfigLucroPresumidoCfgDetalhe;
begin
  Result := Self ;
  FstrCodigo := AstrValue ;
end;

function TDadosConfigLucroPresumidoCfgDetalhe.CodPar: String;
begin
  Result := FstrCodPar ;
end;

function TDadosConfigLucroPresumidoCfgDetalhe.CodPar(
  const AstrValue: String): IDadosConfigLucroPresumidoCfgDetalhe;
begin
  Result := Self ;
  FstrCodPar := AstrValue ;
end;

function TDadosConfigLucroPresumidoCfgDetalhe.Codigo: String;
begin
  Result := FstrCodigo ;
end;

function TDadosConfigLucroPresumidoCfgDetalhe.Config(
  const AintValue: Integer): IDadosConfigLucroPresumidoCfgDetalhe;
begin
  Result := Self ;
  FintConfig := AintValue ;
end;

function TDadosConfigLucroPresumidoCfgDetalhe.Contas(
  AItem: IDadosConfigLucroPresumidoCfgDetalheContas): IDadosConfigLucroPresumidoCfgDetalhe;
begin
  Result := Self ;
  FlstContas.Add(AItem) ;
end;

function TDadosConfigLucroPresumidoCfgDetalhe.Config: Integer;
begin
  Result := FintConfig ;
end;

function TDadosConfigLucroPresumidoCfgDetalhe.Contas: TList<IDadosConfigLucroPresumidoCfgDetalheContas>;
begin
  Result := FlstContas ;
end;

constructor TDadosConfigLucroPresumidoCfgDetalhe.Create;
begin
  FstrAutoincrem := '' ;
  FstrCodigo := '' ;
  FstrSeqGer := '' ;
  FintConfig := 0 ;
  FstrGrupo_ := '' ;
  FstrCodPar := '' ;
  FstrDescri := '' ;
  FfltPorcen := 0.00 ;
  FlstContas := TList<IDadosConfigLucroPresumidoCfgDetalheContas>.Create ;
end;

function TDadosConfigLucroPresumidoCfgDetalhe.Descri: String;
begin
  Result := FstrDescri ;
end;

function TDadosConfigLucroPresumidoCfgDetalhe.Descri(
  const AstrValue: String): IDadosConfigLucroPresumidoCfgDetalhe;
begin
  Result := Self ;
  FstrDescri := AstrValue ;
end;

destructor TDadosConfigLucroPresumidoCfgDetalhe.Destroy;
begin
  FreeAndNil(FlstContas) ;
  inherited;
end;

function TDadosConfigLucroPresumidoCfgDetalhe.Grupo_: String;
begin
  Result := FstrGrupo_ ;
end;

function TDadosConfigLucroPresumidoCfgDetalhe.Grupo_(
  const AstrValue: String): IDadosConfigLucroPresumidoCfgDetalhe;
begin
  Result := Self ;
  FstrGrupo_ := AstrValue ;
end;

class function TDadosConfigLucroPresumidoCfgDetalhe.New: IDadosConfigLucroPresumidoCfgDetalhe;
begin
  Result := Self.Create;
end;

function TDadosConfigLucroPresumidoCfgDetalhe.Porcen: Double;
begin
  Result := FfltPorcen ;
end;

function TDadosConfigLucroPresumidoCfgDetalhe.Porcen(
  const AfltValue: Double): IDadosConfigLucroPresumidoCfgDetalhe;
begin
  Result := Self ;
  FfltPorcen := AfltValue ;
end;

function TDadosConfigLucroPresumidoCfgDetalhe.SeqGer: String;
begin
  Result := FstrSeqGer ;
end;

function TDadosConfigLucroPresumidoCfgDetalhe.SeqGer(
  const AstrValue: String): IDadosConfigLucroPresumidoCfgDetalhe;
begin
  Result := Self ;
  FstrSeqGer := AstrValue ;
end;

{ TDadosConfigLucroPresumidoCfg }

constructor TDadosConfigLucroPresumidoCfg.Create;
begin
  FGeral := Nil ;
  FGeralLanCon := Nil ;
  FlstDetalhe := TList<IDadosConfigLucroPresumidoCfgDetalhe>.Create ;
end;

destructor TDadosConfigLucroPresumidoCfg.Destroy;
begin
  FreeAndNIl(FlstDetalhe) ;
  inherited;
end;

function TDadosConfigLucroPresumidoCfg.Detalhe(AItem: IDadosConfigLucroPresumidoCfgDetalhe): IDadosConfigLucroPresumidoCfg;
begin
  Result := Self ;
  FlstDetalhe.Add(AItem) ;
end;

function TDadosConfigLucroPresumidoCfg.Detalhe: TList<IDadosConfigLucroPresumidoCfgDetalhe>;
begin
  Result := FlstDetalhe ;
end;

function TDadosConfigLucroPresumidoCfg.Geral(
  const AValue: IDadosConfigLucroPresumidoCfgGeral): IDadosConfigLucroPresumidoCfg;
begin
  Result := Self ;
  FGeral := AValue ;
end;

function TDadosConfigLucroPresumidoCfg.Geral: IDadosConfigLucroPresumidoCfgGeral;
begin
  Result := FGeral ;
end;

function TDadosConfigLucroPresumidoCfg.GeralLanCon(
  const AValue: IDadosConfigLucroPresumidoCfgGeralLanCon): IDadosConfigLucroPresumidoCfg;
begin
  Result := Self ;
  FGeralLanCon := AValue ;
end;

function TDadosConfigLucroPresumidoCfg.GeralLanCon: IDadosConfigLucroPresumidoCfgGeralLanCon;
begin
  Result := FGeralLanCon ;
end;

class function TDadosConfigLucroPresumidoCfg.New: IDadosConfigLucroPresumidoCfg;
begin
  Result := Self.Create;
end;

{ TTipoConfigLucroPresumidoPreparaCarrega }

function TTipoConfigLucroPresumidoPreparaCarrega.fPrepara(const AqryGeral,
  AqryGeralLancon, AqryDetalhe: TDataSet;
  const AcdsDetalhePlanco: TDataSet): IDadosConfigLucroPresumidoCfg;
var
  LobjConfigGeral: IDadosConfigLucroPresumidoCfgGeral ;
  LobjConfigGeralLancon: IDadosConfigLucroPresumidoCfgGeralLanCon ;
  LobjConfigDetalhe: IDadosConfigLucroPresumidoCfgDetalhe ;
  LobjConfigDetalheContas: IDadosConfigLucroPresumidoCfgDetalheContas ;
  LstrColunaDetalhe: String ;
begin
  Result := Nil ;

  if AqryDetalhe.IsEmpty then
    Exit ;

  LobjConfigGeral := TDadosConfigLucroPresumidoCfgGeral.New
                       .Autoincrem(AqryGeral.FieldByName('AUTOINCREM').AsString)
                       .Codigo(AqryGeral.FieldByName('CODIGO').AsString)
                       .CodEmp(AqryGeral.FieldByName('CODEMP').AsString)
                       .Exerci(AqryGeral.FieldByName('EXERCI').AsInteger) ;

  LobjConfigGeralLancon := Nil ;
  if not AqryGeralLancon.IsEmpty then
  begin
    LobjConfigGeralLancon := TDadosConfigLucroPresumidoCfgGeralLanCon.New
                               .Autoincrem(AqryGeralLancon.FieldByName('AUTOINCREM').AsString)
                               .SeqGer(AqryGeralLancon.FieldByName('SEQGER').AsString)
                               .HisPad(AqryGeralLancon.FieldByName('HISPAD').AsInteger)
                               .Histor(AqryGeralLancon.FieldByName('HISTOR').AsString)
                               .CodCon(AqryGeralLancon.FieldByName('CODCON').AsString) ;
  end ;

  result := TDadosConfigLucroPresumidoCfg.New
              .Geral(LobjConfigGeral)
              .GeralLanCon(LobjConfigGeralLancon) ;

  AqryDetalhe.First ;
  while not AqryDetalhe.Eof do
  begin

    LobjConfigDetalhe := TDadosConfigLucroPresumidoCfgDetalhe.New
                           .Autoincrem(AqryDetalhe.FieldByName('AUTOINCREM').AsString)
                           .SeqGer(AqryDetalhe.FieldByName('SEQGER').AsString)
                           .Codigo(AqryDetalhe.FieldByName('CODIGO').AsString)
                           .Config(AqryDetalhe.FieldByName('PRNIRP').AsInteger)
                           .Grupo_(AqryDetalhe.FieldByName('GRUPO_').AsString)
                           .CodPar(AqryDetalhe.FieldByName('CODPAR').AsString)
                           .Descri(AqryDetalhe.FieldByName('DESCRI').AsString)
                           .Porcen(AqryDetalhe.FieldByName('PORCEN').AsFloat) ;

    LstrColunaDetalhe := TColunaDetalhePlanco.New.fRetornaColuna(AqryDetalhe.FieldByName('CODIGO').AsString) ;
    if TUniClientDataSet(AcdsDetalhePlanco).FindKey([AqryDetalhe.FieldByName(LstrColunaDetalhe).AsString]) then
    begin
      while (AqryDetalhe.FieldByName(LstrColunaDetalhe).AsString = AcdsDetalhePlanco.FieldByName('SEQGER').AsString)
            and (not AcdsDetalhePlanco.Eof) do
      begin

        LobjConfigDetalheContas := TDadosConfigLucroPresumidoCfgDetalheContas.New
                                     .Autoincrem(AcdsDetalhePlanco.FieldByName('AUTOINCREM').AsString)
                                     .SeqGer(AcdsDetalhePlanco.FieldByName('SEQGER').AsString)
                                     .CodCon(AcdsDetalhePlanco.FieldByName('CODCON').AsString)
                                     .TpLaCo(AcdsDetalhePlanco.FieldByName('TPLACO').AsString) ;
        LobjConfigDetalhe.Contas(LobjConfigDetalheContas) ;

        AcdsDetalhePlanco.Next ;
      end ;
    end ;

    result.Detalhe(LobjConfigDetalhe) ;

    AqryDetalhe.Next ;
  end ;

end;

class function TTipoConfigLucroPresumidoPreparaCarrega.New: ITipoConfigLucroPresumidoPreparaCarrega;
begin
  Result := Self.Create ;
end;

{ TTipoConfigLucroPresumidoPreparaCadastroTabelaApuracaoBC }

constructor TTipoConfigLucroPresumidoPreparaCadastroTabelaApuracaoBC.Create;
begin
  FlstLista := nil ;
end;

function TTipoConfigLucroPresumidoPreparaCadastroTabelaApuracaoBC.fListaProcessada: TList<IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC>;
begin
  Result := FlstLista ;
end;

function TTipoConfigLucroPresumidoPreparaCadastroTabelaApuracaoBC.fPrepara(
  const AqryTabela: TUniQuery): ITipoConfigLucroPresumidoPreparaCadastroTabelaApuracaoBC;
var
  LobjCadastroTabelaApuracaoBC: IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC ;
begin
  Result := Self ;

  AqryTabela.First ;
  while not AqryTabela.Eof do
  begin
    LobjCadastroTabelaApuracaoBC := TDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC.New
                                      .Autoincrem(AqryTabela.FieldByName('AUTOINCREM').AsInteger)
                                      .Codigo(AqryTabela.FieldByName('PRN_CODIGO').AsString)
                                      .Descri(AqryTabela.FieldByName('PRN_DESCRI').AsString)
                                      .Grupo_(AqryTabela.FieldByName('PRN_GRUPO_').AsString)
                                      .Sequen(AqryTabela.FieldByName('PRN_SEQUEN').AsString)
                                      .Parame(AqryTabela.FieldByName('PRN_PARAME').AsString)
                                      .Porcen(AqryTabela.FieldByName('PRN_PORCEN').AsFloat) ;
    FlstLista.Add(LobjCadastroTabelaApuracaoBC) ;
    AqryTabela.Next ;
  end ;
end;

function TTipoConfigLucroPresumidoPreparaCadastroTabelaApuracaoBC.fSetLista(
  AlstLista: TList<IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC>): ITipoConfigLucroPresumidoPreparaCadastroTabelaApuracaoBC;
begin
  Result := Self ;
  FlstLista := AlstLista ;
end;

class function TTipoConfigLucroPresumidoPreparaCadastroTabelaApuracaoBC.New: ITipoConfigLucroPresumidoPreparaCadastroTabelaApuracaoBC;
begin
  Result := Self.Create ;
end;

{ TDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC }

function TDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC.Autoincrem: Integer;
begin
  Result := FintAutoincrem ;
end;

function TDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC.Autoincrem(
  const AintValue: Integer): IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC;
begin
  Result := Self ;
  FintAutoincrem := AintValue ;
end;

function TDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC.Codigo: String;
begin
  Result := FstrCodigo ;
end;

function TDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC.Codigo(
  const AstrValue: String): IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC;
begin
  Result := Self ;
  FstrCodigo := AstrValue ;
end;

constructor TDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC.Create;
begin
  FintAutoincrem := 0 ;
  FstrCodigo := '' ;
  FstrDescri := '' ;
  FstrGrupo_ := '' ;
  FstrSequen := '' ;
  FfltPorcen := 0 ;
  FstrParame := '' ;
end;

function TDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC.Descri(
  const AstrValue: String): IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC;
begin
  Result := Self ;
  FstrDescri := AstrValue ;
end;

function TDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC.Descri: String;
begin
  Result := FstrDescri ;
end;

function TDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC.Grupo_(
  const AstrValue: String): IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC;
begin
  Result := Self ;
  FstrGrupo_ := AstrValue ;
end;

function TDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC.Grupo_: String;
begin
  Result := FstrGrupo_ ;
end;

class function TDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC.New: IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC;
begin
  Result := Self.Create ;
end;

function TDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC.Parame(
  const AstrValue: String): IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC;
begin
  Result := Self ;
  FstrParame := AstrValue ;
end;

function TDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC.Parame: String;
begin
  Result := FstrParame ;
end;

function TDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC.Porcen(
  const AfltValue: Double): IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC;
begin
  Result := Self ;
  FfltPorcen := AfltValue ;
end;

function TDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC.Porcen: Double;
begin
  Result := FfltPorcen ;
end;

function TDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC.Sequen(
  const AstrValue: String): IDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC;
begin
  Result := Self ;
  FstrSequen := AstrValue ;
end;

function TDadosConfigLucroPresumidoCfgCadastroTabelaApuracaoBC.Sequen: String;
begin
  Result := FstrSequen ;
end;

{ TTipoConfigLucroPresumidoConverte }

function TTipoConfigLucroPresumidoConverte.fConverte(const AcdsGeral,
  AcdsGeralLancon, AcdsDetalhe,
  AcdsDetalhePlanco: TUniClientDataSet): IDadosConfigLucroPresumidoCfg;
begin
  Result := TTipoConfigLucroPresumidoPreparaCarrega.New.fPrepara(AcdsGeral, AcdsGeralLancon, AcdsDetalhe, AcdsDetalhePlanco) ;
end;

class function TTipoConfigLucroPresumidoConverte.New: ITipoConfigLucroPresumidoConverte;
begin
  Result := Self.Create ;
end;

{ TInfoColunaDataSet }

constructor TInfoColunaDataSet.Create;
begin
  FstrNomeColuna := '' ;
  FintTamanhoColuna := 0 ;
  FTipoColuna := ftString ;
end;

class function TInfoColunaDataSet.New: IInfoColunaDataSet;
begin
  Result := Self.Create ;
end;

function TInfoColunaDataSet.NomeColuna: String;
begin
  Result := FstrNomeColuna ;
end;

function TInfoColunaDataSet.NomeColuna(
  const AstrValue: String): IInfoColunaDataSet;
begin
  Result := Self ;
  FstrNomeColuna := AstrValue ;
end;

function TInfoColunaDataSet.TamanhoColuna(
  const AValue: Integer): IInfoColunaDataSet;
begin
  Result := Self ;
  FintTamanhoColuna := AValue ;
end;

function TInfoColunaDataSet.TamanhoColuna: Integer;
begin
  Result := FintTamanhoColuna ;
end;

function TInfoColunaDataSet.TipoColuna(
  const AValue: TFieldType): IInfoColunaDataSet;
begin
  Result := Self ;
  FTipoColuna := AValue ;
end;

function TInfoColunaDataSet.TipoColuna: TFieldType;
begin
  Result := FTipoColuna ;
end;

{ TInfoColunasDataSet }

constructor TInfoColunasDataSet.Create;
begin
  FlstColunas := TList<IInfoColunaDataSet>.Create ;
end;

destructor TInfoColunasDataSet.Destroy;
begin
  FreeAndNil(FlstColunas) ;
  inherited;
end;

class function TInfoColunasDataSet.New: IInfoColunasDataSet;
begin
  Result := Self.Create ;
end;

{ TInfoColunasDataSetConfigGeral }

function TInfoColunasDataSetConfigGeral.fColunas: TList<IInfoColunaDataSet>;
begin
  FlstColunas.Clear ;
  FlstColunas.Add(TInfoColunaDataSet.New.NomeColuna('AUTOINCREM').TipoColuna(ftString).TamanhoColuna(20)) ;
  FlstColunas.Add(TInfoColunaDataSet.New.NomeColuna('CODIGO').TipoColuna(ftString).TamanhoColuna(6)) ;
  FlstColunas.Add(TInfoColunaDataSet.New.NomeColuna('CODEMP').TipoColuna(ftString).TamanhoColuna(3)) ;
  FlstColunas.Add(TInfoColunaDataSet.New.NomeColuna('EXERCI').TipoColuna(ftInteger)) ;
  Result := FlstColunas ;
end;

{ TInfoColunasDataSetConfigGeralLancon }

function TInfoColunasDataSetConfigGeralLancon.fColunas: TList<IInfoColunaDataSet>;
begin
  FlstColunas.Clear ;
  FlstColunas.Add(TInfoColunaDataSet.New.NomeColuna('AUTOINCREM').TipoColuna(ftString).TamanhoColuna(20)) ;
  FlstColunas.Add(TInfoColunaDataSet.New.NomeColuna('SEQGER').TipoColuna(ftString).TamanhoColuna(6)) ;
  FlstColunas.Add(TInfoColunaDataSet.New.NomeColuna('HISPAD').TipoColuna(ftInteger)) ;
  FlstColunas.Add(TInfoColunaDataSet.New.NomeColuna('HISTOR').TipoColuna(ftString).TamanhoColuna(512)) ;
  FlstColunas.Add(TInfoColunaDataSet.New.NomeColuna('CODCON').TipoColuna(ftString).TamanhoColuna(20)) ;
  Result := FlstColunas ;
end;

{ TInfoColunasDataSetConfigDetalhe }

function TInfoColunasDataSetConfigDetalhe.fColunas: TList<IInfoColunaDataSet>;
begin
  FlstColunas.Clear ;
  FlstColunas.Add(TInfoColunaDataSet.New.NomeColuna('AUTOINCREM').TipoColuna(ftString).TamanhoColuna(20)) ;
  FlstColunas.Add(TInfoColunaDataSet.New.NomeColuna('CODIGO').TipoColuna(ftString).TamanhoColuna(6)) ;
  FlstColunas.Add(TInfoColunaDataSet.New.NomeColuna('SEQGER').TipoColuna(ftString).TamanhoColuna(6)) ;
  FlstColunas.Add(TInfoColunaDataSet.New.NomeColuna('PRNIRP').TipoColuna(ftInteger)) ;
  Result := FlstColunas ;
end;

{ TInfoColunasDataSetConfigDetalhePlanco }

function TInfoColunasDataSetConfigDetalhePlanco.fColunas: TList<IInfoColunaDataSet>;
begin
  FlstColunas.Clear ;
  FlstColunas.Add(TInfoColunaDataSet.New.NomeColuna('AUTOINCREM').TipoColuna(ftString).TamanhoColuna(20)) ;
  FlstColunas.Add(TInfoColunaDataSet.New.NomeColuna('SEQGER').TipoColuna(ftString).TamanhoColuna(6)) ;
  FlstColunas.Add(TInfoColunaDataSet.New.NomeColuna('CODCON').TipoColuna(ftString).TamanhoColuna(20)) ;
  FlstColunas.Add(TInfoColunaDataSet.New.NomeColuna('TPLACO').TipoColuna(ftString).TamanhoColuna(6)) ;
  Result := FlstColunas ;
end;

{ TColunaDetalhePlanco }

function TColunaDetalhePlanco.fRetornaColuna(
  const AstrValorCodigoDetalhe: String): String;
begin
  if fEmptyStr(AstrValorCodigoDetalhe) then
    Result := 'PRNIRP'
  else
    Result := 'CODIGO' ;
end;

class function TColunaDetalhePlanco.New: IColunaDetalhePlanco;
begin
  Result := Self.Create ;
end;

{ TCopiarConfiguracaoLucroPresumidoDe }

constructor TCopiarConfiguracaoLucroPresumidoDe.Create;
begin
  FlstConfs := TList<IDadosConfigLucroPresumidoCfgGeral>.Create ;
end;

destructor TCopiarConfiguracaoLucroPresumidoDe.Destroy;
begin
  FreeAndNil(FlstConfs) ;
  inherited;
end;

function TCopiarConfiguracaoLucroPresumidoDe.fConfiguracao: TList<IDadosConfigLucroPresumidoCfgGeral>;
var
  LqryConfs: TUniQuery ;
begin

  LqryConfs := fCriaQuery() ;
  try
    LqryConfs.Close ;
    LqryConfs.SQL.Clear ;
    LqryConfs.SQL.Add(' SELECT PRIRPG.AUTOINCREM, PRIRPG.IRM_CODIGO, PRIRPG.IRM_CODEMP, PRIRPG.IRM_EXERCI, CADEMP.EMP_NOMEMP ');
    LqryConfs.SQL.Add(' FROM PRIRPG ');
    LqryConfs.SQL.Add('      INNER JOIN CADEMP ON PRIRPG.IRM_CODEMP = CADEMP.EMP_CODEMP; ');
    LqryConfs.Open ;
    LqryConfs.First ;

    while not LqryConfs.Eof do
    begin
      FlstConfs.Add(
        TDadosConfigLucroPresumidoCfgGeral
          .New
          .Autoincrem(LqryConfs.FieldByName('AUTOINCREM').AsString)
          .Codigo(LqryConfs.FieldByName('IRM_CODIGO').AsString)
          .CodEmp(LqryConfs.FieldByName('IRM_CODEMP').AsString)
          .NomEmp(LqryConfs.FieldByName('EMP_NOMEMP').AsString)
          .Exerci(LqryConfs.FieldByName('IRM_EXERCI').AsInteger)
      ) ;
      LqryConfs.Next ;
    end ;

  finally
    FreeAndNil(LqryConfs) ;
  end ;

  Result := FlstConfs ;

end;

class function TCopiarConfiguracaoLucroPresumidoDe.New: ICopiarConfiguracaoLucroPresumidoDe;
begin
  Result := Self.Create ;
end;

end.
