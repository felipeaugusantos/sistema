unit Contabilidade.Classes.ApuracaoLucroPresumidoComum;

interface

uses
  Contabilidade.Interfaces.ApuracaoLucroPresumido, System.Generics.Collections,
  Data.DB, MemDS, DBAccess, Uni, untFuncoesSimples,
  Contabilidade.Interfaces.SharedLucroPresumido,
  Contabilidade.Interfaces.ConfigLucroPresumido, Datasnap.DBClient,
  UniClientDataSet ;

type

  TColunaDetalhePeriodo = class(TInterfacedObject, IColunaDetalhePlanco)
  public
    function fRetornaColuna(const AstrValorCodigoDetalhe: String): String ;
    class function New: IColunaDetalhePlanco ;
  end ;

  TDadosApuracaoLucroPresumidoGeral = class(TInterfacedObject, IDadosApuracaoLucroPresumidoGeral)
  private
    FstrAutoincrem: string ;
    FstrCodigo: String ;
    FstrCodEmp: String ;
    FintExerci: Integer ;
  public
    function Autoincrem: String ; overload ;
    function Autoincrem(const AstrValue: String): IDadosApuracaoLucroPresumidoGeral ; overload ;
    function Codigo: String ; overload ;
    function Codigo(const AstrValue: String): IDadosApuracaoLucroPresumidoGeral ; overload ;
    function CodEmp: String ; overload ;
    function CodEmp(const AstrValue: String): IDadosApuracaoLucroPresumidoGeral ; overload ;
    function Exerci: Integer ; overload ;
    function Exerci(const AintValue: Integer): IDadosApuracaoLucroPresumidoGeral ; overload ;
    constructor Create;
    class function New: IDadosApuracaoLucroPresumidoGeral;
  end ;

  TDadosApuracaoLucroPresumidoDetalhe = class(TInterfacedObject, IDadosApuracaoLucroPresumidoDetalhe)
  private
    FstrAutoincrem: String ;
    FstrCodigo: String ;
    FstrSeqGer: String ;
    FintConfig: Integer ;
    FstrCodPar: String ;
    FstrDescri: String ;
    FfltPorcen: Double ;
    FlstPeriodos: TList<IDadosApuracaoLucroPresumidoPeriodo> ;
    FlstPlanco: TList<IDadosApuracaoLucroPresumidoPlanco> ;
  public
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
    constructor Create;
    destructor Destroy; override ;
    class function New: IDadosApuracaoLucroPresumidoDetalhe;
  end ;

  TDadosApuracaoLucroPresumidoPeriodo = class(TInterfacedObject, IDadosApuracaoLucroPresumidoPeriodo)
  private
    FstrAutoincrem: String ;
    FstrSeqGer: String ;
    FintPeriod: Integer ;
    FfltApuval: Double ;
  public
    function Autoincrem: String ; overload ;
    function Autoincrem(const AstrValue: String): IDadosApuracaoLucroPresumidoPeriodo ; overload ;
    function SeqGer: String ; overload ;
    function SeqGer(const AstrValue: String): IDadosApuracaoLucroPresumidoPeriodo ; overload ;
    function Period: Integer ; overload ;
    function Period(const AintValue: Integer): IDadosApuracaoLucroPresumidoPeriodo ; overload ;
    function Apuval: Double ; overload ;
    function Apuval(const AfltValue: Double): IDadosApuracaoLucroPresumidoPeriodo ; overload ;
    constructor Create;
    class function New: IDadosApuracaoLucroPresumidoPeriodo;
  end ;

  TDadosApuracaoLucroPresumidoPlanco = class(TInterfacedObject, IDadosApuracaoLucroPresumidoPlanco)
  private
    FintConfig: Integer ;
    FstrCodCon: String ;
    FstrTpLaCo: String ;
  public
    function Config: Integer ; overload ;
    function Config(const AintValue: Integer): IDadosApuracaoLucroPresumidoPlanco ; overload ;
    function CodCon: String ; overload ;
    function CodCon(const AstrValue: String): IDadosApuracaoLucroPresumidoPlanco ; overload ;
    function TpLaCo: String ; overload ;
    function TpLaCo(const AstrValue: String): IDadosApuracaoLucroPresumidoPlanco ; overload ;
    constructor Create;
    class function New: IDadosApuracaoLucroPresumidoPlanco;
  end ;

  TDadosApuracaoLucroPresumido = class(TInterfacedObject, IDadosApuracaoLucroPresumido)
  private
    FGeral: IDadosApuracaoLucroPresumidoGeral ;
    FBaseCalculo: TList<IDadosApuracaoLucroPresumidoDetalhe> ;
    FCalculoImposto: TList<IDadosApuracaoLucroPresumidoDetalhe> ;
  public
    function Geral: IDadosApuracaoLucroPresumidoGeral; overload ;
    function Geral(const AValue: IDadosApuracaoLucroPresumidoGeral): IDadosApuracaoLucroPresumido; overload ;
    function BaseCalculo: TList<IDadosApuracaoLucroPresumidoDetalhe>; overload ;
    function BaseCalculo(AItem: IDadosApuracaoLucroPresumidoDetalhe): IDadosApuracaoLucroPresumido; overload ;
    function CalculoImposto: TList<IDadosApuracaoLucroPresumidoDetalhe>; overload ;
    function CalculoImposto(AItem: IDadosApuracaoLucroPresumidoDetalhe): IDadosApuracaoLucroPresumido; overload ;
    constructor Create;
    destructor Destroy; override ;
    class function New: IDadosApuracaoLucroPresumido;
  end ;


  TTipoApuracaoLucroPresumidoPreparaCarrega = class(TInterfacedObject, ITipoApuracaoLucroPresumidoPreparaCarrega)
  private
    function fPreparaPt01(const AqryDetalhe: TDataset;
                                AcdsLancon, AcdsDetalhePeriodo, AcdsPlanco: TUniClientDataSet): IDadosApuracaoLucroPresumido;
    procedure pPreparaPt02(var AobjRetorno: IDadosApuracaoLucroPresumido; AobjCfg: IDadosConfigLucroPresumidoCfg;
                               AcdsDetalhe, AcdsLancon, AcdsPlanco: TUniClientDataSet ) ;
    procedure pPreparaPt03(var AobjRetorno: IDadosApuracaoLucroPresumido; AcdsPlanco: TUniClientDataSet) ;
  public
    function fPrepara(const AqryGeral, AqryDetalhe, AqryDetalhePeriodo, AqryPlanco: TDataset;
                            AobjCfg: IDadosConfigLucroPresumidoCfg;
                            AcdsLancon: TUniClientDataSet): IDadosApuracaoLucroPresumido ;
    class function New: ITipoApuracaoLucroPresumidoPreparaCarrega;
  end ;

  TTipoApuracaoLucroPresumidoProcessaCalculos = class(TInterfacedObject, ITipoApuracaoLucroPresumidoProcessaCalculos)
  private
    FcdsBaseCalculo: TUniClientDataSet ;
    FcdsApuracao: TUniClientDataSet ;
    FobjLinhaSemDados: ITipoLinhasSemInformacao ;
  public
    function CdsBaseCalculo(var Acds: TUniClientDataSet): ITipoApuracaoLucroPresumidoProcessaCalculos;
    function CdsApuracao(var Acds: TUniClientDataSet): ITipoApuracaoLucroPresumidoProcessaCalculos;
    function fProcessar(const ADados: IDadosApuracaoLucroPresumido): boolean ;
    function fReprocessar(const AstrCodEmp: String; const AintExercicio: Integer): boolean ;
    function fLinhaSemDados(const AobjLinhaSemDados: ITipoLinhasSemInformacao): ITipoApuracaoLucroPresumidoProcessaCalculos;
    class function New: ITipoApuracaoLucroPresumidoProcessaCalculos;
    constructor Create ;
  end ;

  TTipoTrimestres = class(TInterfacedObject, ITipoTrimestres)
  private
    FlstMeses: TList<Integer> ;
    FintExerci: Integer ;
    FdtaIniAtv: TDateTime ;
  public
    function Exerci(const AintValue: Integer): ITipoTrimestres ; overload ;
    function IniAtv(const AdtaValue: TDateTime): ITipoTrimestres ; overload ;
    function MesesValidos: TList<Integer> ;
    class function New: ITipoTrimestres;
    constructor Create ;
    destructor Destroy; override ;
  end ;

  TTipoFiltroLancon = class(TInterfacedObject, ITipoFiltroLancon)
  private
    FdtsCadEmp: TDataSet ;
    FdtsPlancoConfig: TDataSet ;
    FstrColunaPlanoContas: String ;
    FblnProcessaLancon: Boolean ;
    procedure pConcatenaCodigos(const AstrCodigo: String; var AstrCodigos: String) ;
  public
    function fCadEmp(const ACadEmp: TDataSet): ITipoFiltroLancon ;
    function fPlanco(const APlancoConfig: TDataSet): ITipoFiltroLancon ;
    function fColunaPlanoContas(const AstrNomeColuna: String): ITipoFiltroLancon ;
    procedure pGeraFiltro(var AqryLancon: TUniQuery) ;
    function ProcessaLanCon(const AblnValue: Boolean): ITipoFiltroLancon ;
    class function New: ITipoFiltroLancon;
    constructor Create ;
  end ;

  TTipoApuracaoLucroPresumidoConverte = class(TInterfacedObject, ITipoApuracaoLucroPresumidoConverte)
  private
    FstrCodEmp: String ;
    FstrCodigo: String ;
    FintExerci: Integer ;
  public
    function fConverte(Const AcdsBaseCalculo, AcdsApuracaoValor: TUniClientDataSet): IDadosApuracaoLucroPresumido ;
    function CodEmp(const AstrValue: String): ITipoApuracaoLucroPresumidoConverte ;
    function Exerci(const AintValue: Integer): ITipoApuracaoLucroPresumidoConverte ;
    function Codigo(const AstrValue: String): ITipoApuracaoLucroPresumidoConverte ;
    class function New: ITipoApuracaoLucroPresumidoConverte;
    constructor Create ;
  end ;

implementation

uses
  SysUtils, Math, StrUtils, DateUtils ;

{ TTipoApuracaoLucroPresumidoPreparaCarrega }

function TTipoApuracaoLucroPresumidoPreparaCarrega.fPrepara(
          const AqryGeral, AqryDetalhe, AqryDetalhePeriodo, AqryPlanco: TDataset;
                AobjCfg: IDadosConfigLucroPresumidoCfg;
                AcdsLancon: TUniClientDataSet): IDadosApuracaoLucroPresumido;
var
  LobjConfigGeral: IDadosApuracaoLucroPresumidoGeral ;
  LcdsDetalhePeriodo: TUniClientDataSet ;
  LcdsPlanco: TUniClientDataSet ;
  LcdsDetalhe: TUniClientDataSet ;
begin
  Result := Nil ;

  if (AqryGeral.IsEmpty) and (not Assigned(AobjCfg)) then
    Exit ;

  LobjConfigGeral := TDadosApuracaoLucroPresumidoGeral.New
                       .Autoincrem(AqryGeral.FieldByName('AUTOINCREM').AsString)
                       .Codigo(AqryGeral.FieldByName('CODIGO').AsString)
                       .CodEmp(AqryGeral.FieldByName('CODEMP').AsString)
                       .Exerci(AqryGeral.FieldByName('EXERCI').AsInteger) ;

  Result := TDadosApuracaoLucroPresumido.New
              .Geral(LobjConfigGeral) ;

  LcdsDetalhePeriodo := fCriaClientDatset(AqryDetalhePeriodo) ;
  LcdsDetalhePeriodo.IndexFieldNames := 'SEQGER' ;

  LcdsPlanco := fCriaClientDatset(AqryPlanco) ;
  LcdsPlanco.IndexFieldNames := 'CONFIG' ;

  LcdsDetalhe := fCriaClientDatset(AqryDetalhe) ;
  LcdsDetalhe.IndexFieldNames := 'CONFIG' ;

  AcdsLancon.IndexFieldNames := 'TRIMESTRE;PLANO_CONTAS' ;

  try

    Result := fPreparaPt01(AqryDetalhe, AcdsLancon, LcdsDetalhePeriodo, LcdsPlanco) ;

    pPreparaPt02(Result, AobjCfg, LcdsDetalhe, AcdsLancon, LcdsPlanco) ;

    pPreparaPt03(Result, LcdsPlanco) ;

  finally
    FreeAndNil(LcdsDetalhePeriodo) ;
    FreeAndNil(LcdsPlanco) ;
    FreeAndNil(LcdsDetalhe) ;
  end ;

end;

function TTipoApuracaoLucroPresumidoPreparaCarrega.fPreparaPt01(
  const AqryDetalhe: TDataset;
  AcdsLancon, AcdsDetalhePeriodo, AcdsPlanco: TUniClientDataSet): IDadosApuracaoLucroPresumido;
var
  LobjConfigDetalhe: IDadosApuracaoLucroPresumidoDetalhe ;
  LobjConfigDetalhePeriodo: IDadosApuracaoLucroPresumidoPeriodo ;
  LfltValorLancon: Double ;
  LblnTemLancon: Boolean ;
begin
  AqryDetalhe.First ;
  while not AqryDetalhe.Eof do
  begin

    LobjConfigDetalhe := TDadosApuracaoLucroPresumidoDetalhe.New
                           .Autoincrem(AqryDetalhe.FieldByName('AUTOINCREM').AsString)
                           .Codigo(AqryDetalhe.FieldByName('CODIGO').AsString)
                           .SeqGer(AqryDetalhe.FieldByName('SEQGER').AsString)
                           .Config(AqryDetalhe.FieldByName('CONFIG').AsInteger)
                           .CodPar(AqryDetalhe.FieldByName('CODPAR').AsString)
                           .Descri(AqryDetalhe.FieldByName('DESCRI').AsString)
                           .Porcen(AqryDetalhe.FieldByName('PORCEN').AsFloat);

    if AcdsDetalhePeriodo.FindKey([AqryDetalhe.FieldByName('CODIGO').AsString]) then
    begin
      while (AqryDetalhe.FieldByName('CODIGO').AsString = AcdsDetalhePeriodo.FieldByName('SEQGER').AsString)
            and (not AcdsDetalhePeriodo.Eof) do
      begin
        //verifica se tem valor apurado na Lancon
        LfltValorLancon := 0.00 ;
        LblnTemLancon := False ;
        if AcdsPlanco.FindKey([AqryDetalhe.FieldByName('CONFIG').AsInteger]) then
        begin
          while (AqryDetalhe.FieldByName('CONFIG').AsInteger = AcdsPlanco.fieldByName('CONFIG').AsInteger)
                and (not AcdsPlanco.Eof) do
          begin
            if AcdsLancon.FindKey([AcdsDetalhePeriodo.FieldByName('PERIOD').AsInteger, AcdsPlanco.fieldByName('CODCON').AsString]) then
            begin
              LblnTemLancon := True ;
              LfltValorLancon := LfltValorLancon + AcdsLancon.FieldByName('CREDITO').AsFloat ;
              LfltValorLancon := LfltValorLancon - AcdsLancon.FieldByName('DEBITO').AsFloat ;
            end ;
            AcdsPlanco.Next ;
          end ;
        end ;

        LobjConfigDetalhePeriodo := TDadosApuracaoLucroPresumidoPeriodo.New
                                     .Autoincrem(AcdsDetalhePeriodo.FieldByName('AUTOINCREM').AsString)
                                     .SeqGer(AcdsDetalhePeriodo.FieldByName('SEQGER').AsString)
                                     .Period(AcdsDetalhePeriodo.FieldByName('PERIOD').AsInteger)
                                     .Apuval(ifThen(LblnTemLancon, LfltValorLancon, AcdsDetalhePeriodo.FieldByName('APUVAL').AsFloat)) ;
        LobjConfigDetalhe.Periodos(LobjConfigDetalhePeriodo) ;

        AcdsDetalhePeriodo.Next ;
      end ;

      if pos(BASE_CALCULO, AqryDetalhe.FieldByName('GRUPO_').AsString) > 0 then
        result.BaseCalculo(LobjConfigDetalhe) ;

      if pos(APURACAO, AqryDetalhe.FieldByName('GRUPO_').AsString) > 0 then
        result.CalculoImposto(LobjConfigDetalhe) ;
    end ;

    AqryDetalhe.Next ;
  end ;

end;

class function TTipoApuracaoLucroPresumidoPreparaCarrega.New: ITipoApuracaoLucroPresumidoPreparaCarrega;
begin
  Result := Self.Create ;
end;

procedure TTipoApuracaoLucroPresumidoPreparaCarrega.pPreparaPt02(
  var AobjRetorno: IDadosApuracaoLucroPresumido;
  AobjCfg: IDadosConfigLucroPresumidoCfg; AcdsDetalhe,
  AcdsLancon, AcdsPlanco: TUniClientDataSet);
var
  LintPeriod: Integer ;
  LfltValorLancon: Double ;
  LblnTemLancon: Boolean ;
  LlstCfgDetalhe: TList<IDadosConfigLucroPresumidoCfgDetalhe> ;
  LobjCfgDetalhe: IDadosConfigLucroPresumidoCfgDetalhe ;
  LobjConfigDetalhe: IDadosApuracaoLucroPresumidoDetalhe ;
  LobjConfigDetalhePeriodo: IDadosApuracaoLucroPresumidoPeriodo ;
begin
  ///adiciona as novas configurações caso precise.
  LlstCfgDetalhe := AobjCfg.Detalhe ;
  for LobjCfgDetalhe in LlstCfgDetalhe do
  begin
    if not AcdsDetalhe.FindKey([LobjCfgDetalhe.Config]) then
    begin
      LobjConfigDetalhe := TDadosApuracaoLucroPresumidoDetalhe.New
                             .Config(LobjCfgDetalhe.Config)
                             .CodPar(LobjCfgDetalhe.CodPar)
                             .Descri(LobjCfgDetalhe.Descri)
                             .Porcen(LobjCfgDetalhe.Porcen) ;

      // 4 Trimestres
      for LintPeriod := 1 to 4 do
      begin
        LfltValorLancon := 0.00 ;
        LblnTemLancon := False ;
        if AcdsPlanco.FindKey([LobjCfgDetalhe.Config]) then
        begin
          while (LobjCfgDetalhe.Config = AcdsPlanco.fieldByName('CONFIG').AsInteger)
                and (not AcdsPlanco.Eof) do
          begin
            if AcdsLancon.FindKey([LintPeriod, AcdsPlanco.fieldByName('CODCON').AsString]) then
            begin
              LblnTemLancon := True ;
              LfltValorLancon := LfltValorLancon + AcdsLancon.FieldByName('CREDITO').AsFloat ;
              LfltValorLancon := LfltValorLancon - AcdsLancon.FieldByName('DEBITO').AsFloat ;
            end ;
            AcdsPlanco.Next ;
          end ;
        end ;

        LobjConfigDetalhePeriodo := TDadosApuracaoLucroPresumidoPeriodo.New
                                      .Period(LintPeriod)
                                      .Apuval(ifThen(LblnTemLancon, LfltValorLancon, 0.00)) ;
        LobjConfigDetalhe.Periodos(LobjConfigDetalhePeriodo) ;
      end ;

      if pos(BASE_CALCULO, LobjCfgDetalhe.Grupo_) > 0 then
        AobjRetorno.BaseCalculo(LobjConfigDetalhe) ;

      if pos(APURACAO, LobjCfgDetalhe.Grupo_) > 0 then
        AobjRetorno.CalculoImposto(LobjConfigDetalhe) ;

    end ;
  end ;

end;

procedure TTipoApuracaoLucroPresumidoPreparaCarrega.pPreparaPt03(
  var AobjRetorno: IDadosApuracaoLucroPresumido; AcdsPlanco: TUniClientDataSet);
var
  LlstConfigDetalhe: TList<IDadosApuracaoLucroPresumidoDetalhe> ;
  LobjConfigDetalhePlanco: IDadosApuracaoLucroPresumidoPlanco ;
  LobjConfigDetalhe: IDadosApuracaoLucroPresumidoDetalhe ;
begin
  ///associa as plancos, caso tenha na configuração
  LlstConfigDetalhe := AobjRetorno.BaseCalculo ;
  for LobjConfigDetalhe in LlstConfigDetalhe do
  begin
    if AcdsPlanco.FindKey([LobjConfigDetalhe.Config]) then
    begin
      while (LobjConfigDetalhe.Config = AcdsPlanco.fieldByName('CONFIG').AsInteger)
            and (not AcdsPlanco.Eof) do
      begin

        LobjConfigDetalhePlanco := TDadosApuracaoLucroPresumidoPlanco.New
                                     .Config(AcdsPlanco.fieldByName('CONFIG').AsInteger)
                                     .CodCon(AcdsPlanco.fieldByName('CODCON').AsString)
                                     .TpLaCo(AcdsPlanco.fieldByName('TPLACO').AsString) ;

        LobjConfigDetalhe.Planco(LobjConfigDetalhePlanco) ;

        AcdsPlanco.Next ;
      end ;
    end ;
  end ;

  LlstConfigDetalhe := AobjRetorno.CalculoImposto ;
  for LobjConfigDetalhe in LlstConfigDetalhe do
  begin
    if AcdsPlanco.FindKey([LobjConfigDetalhe.Config]) then
    begin
      while (LobjConfigDetalhe.Config = AcdsPlanco.fieldByName('CONFIG').AsInteger)
            and (not AcdsPlanco.Eof) do
      begin

        LobjConfigDetalhePlanco := TDadosApuracaoLucroPresumidoPlanco.New
                                     .Config(AcdsPlanco.fieldByName('CONFIG').AsInteger)
                                     .CodCon(AcdsPlanco.fieldByName('CODCON').AsString)
                                     .TpLaCo(AcdsPlanco.fieldByName('TPLACO').AsString) ;

        LobjConfigDetalhe.Planco(LobjConfigDetalhePlanco) ;

        AcdsPlanco.Next ;
      end ;
    end ;
  end ;

end;

{ TDadosApuracaoLucroPresumidoGeral }

function TDadosApuracaoLucroPresumidoGeral.Autoincrem: String;
begin
  Result := FstrAutoincrem ;
end;

function TDadosApuracaoLucroPresumidoGeral.Autoincrem(
  const AstrValue: String): IDadosApuracaoLucroPresumidoGeral;
begin
  Result := Self ;
  FstrAutoincrem := AstrValue ;
end;

function TDadosApuracaoLucroPresumidoGeral.CodEmp: String;
begin
  Result := FstrCodEmp ;
end;

function TDadosApuracaoLucroPresumidoGeral.CodEmp(
  const AstrValue: String): IDadosApuracaoLucroPresumidoGeral;
begin
  Result := Self ;
  FstrCodEmp := AstrValue ;
end;

function TDadosApuracaoLucroPresumidoGeral.Codigo: String;
begin
  Result := FstrCodigo ;
end;

function TDadosApuracaoLucroPresumidoGeral.Codigo(
  const AstrValue: String): IDadosApuracaoLucroPresumidoGeral;
begin
  Result := Self ;
  FstrCodigo := AstrValue ;
end;

constructor TDadosApuracaoLucroPresumidoGeral.Create;
begin
  FstrAutoincrem := '' ;
  FstrCodigo := '' ;
  FstrCodEmp := '' ;
  FintExerci := 0 ;
end;

function TDadosApuracaoLucroPresumidoGeral.Exerci(
  const AintValue: Integer): IDadosApuracaoLucroPresumidoGeral;
begin
  Result := Self ;
  FintExerci := AintValue ;
end;

function TDadosApuracaoLucroPresumidoGeral.Exerci: Integer;
begin
  Result := FintExerci ;
end;

class function TDadosApuracaoLucroPresumidoGeral.New: IDadosApuracaoLucroPresumidoGeral;
begin
  Result := Self.Create ;
end;

{ TDadosApuracaoLucroPresumidoDetalhe }

function TDadosApuracaoLucroPresumidoDetalhe.Autoincrem: String;
begin
  Result := FstrAutoincrem ;
end;

function TDadosApuracaoLucroPresumidoDetalhe.Autoincrem(
  const AstrValue: String): IDadosApuracaoLucroPresumidoDetalhe;
begin
  Result := Self ;
  FstrAutoincrem := AstrValue ;
end;

function TDadosApuracaoLucroPresumidoDetalhe.Codigo(
  const AstrValue: String): IDadosApuracaoLucroPresumidoDetalhe;
begin
  Result := Self ;
  FstrCodigo := AstrValue ;
end;

function TDadosApuracaoLucroPresumidoDetalhe.CodPar: String;
begin
  Result := FstrCodPar ;
end;

function TDadosApuracaoLucroPresumidoDetalhe.CodPar(
  const AstrValue: String): IDadosApuracaoLucroPresumidoDetalhe;
begin
  Result := Self ;
  FstrCodPar := AstrValue ;
end;

function TDadosApuracaoLucroPresumidoDetalhe.Codigo: String;
begin
  Result := FstrCodigo ;
end;

function TDadosApuracaoLucroPresumidoDetalhe.Config(
  const AintValue: Integer): IDadosApuracaoLucroPresumidoDetalhe;
begin
  Result := Self ;
  FintConfig := AintValue ;
end;

function TDadosApuracaoLucroPresumidoDetalhe.Config: Integer;
begin
  Result := FintConfig ;
end;

constructor TDadosApuracaoLucroPresumidoDetalhe.Create;
begin
  FstrAutoincrem := '' ;
  FstrCodigo := '' ;
  FstrSeqGer := '' ;
  FintConfig := 0 ;
  FstrCodPar := '' ;
  FstrDescri := '' ;
  FfltPorcen := 0.00 ;
  FlstPeriodos := TList<IDadosApuracaoLucroPresumidoPeriodo>.Create ;
  FlstPlanco := TList<IDadosApuracaoLucroPresumidoPlanco>.Create ;
end;

function TDadosApuracaoLucroPresumidoDetalhe.Descri: String;
begin
  Result := FstrDescri ;
end;

function TDadosApuracaoLucroPresumidoDetalhe.Descri(
  const AstrValue: String): IDadosApuracaoLucroPresumidoDetalhe;
begin
  Result := Self ;
  FstrDescri := AstrValue ;
end;

destructor TDadosApuracaoLucroPresumidoDetalhe.Destroy;
begin
  FreeAndNil(FlstPeriodos) ;
  FreeAndNil(FlstPlanco) ;
  inherited;
end;

class function TDadosApuracaoLucroPresumidoDetalhe.New: IDadosApuracaoLucroPresumidoDetalhe;
begin
  Result := Self.Create ;
end;

function TDadosApuracaoLucroPresumidoDetalhe.Periodos: TList<IDadosApuracaoLucroPresumidoPeriodo>;
begin
  Result :=  FlstPeriodos ;
end;

function TDadosApuracaoLucroPresumidoDetalhe.Periodos(
  AItem: IDadosApuracaoLucroPresumidoPeriodo): IDadosApuracaoLucroPresumidoDetalhe;
begin
  Result := Self ;
  FlstPeriodos.Add(AItem) ;
end;

function TDadosApuracaoLucroPresumidoDetalhe.Planco: TList<IDadosApuracaoLucroPresumidoPlanco>;
begin
  Result := FlstPlanco ;
end;

function TDadosApuracaoLucroPresumidoDetalhe.Planco(
  AItem: IDadosApuracaoLucroPresumidoPlanco): IDadosApuracaoLucroPresumidoDetalhe;
begin
  Result := Self ;
  FlstPlanco.Add(AItem) ;
end;

function TDadosApuracaoLucroPresumidoDetalhe.Porcen: Double;
begin
  Result := FfltPorcen ;
end;

function TDadosApuracaoLucroPresumidoDetalhe.Porcen(
  const AfltValue: Double): IDadosApuracaoLucroPresumidoDetalhe;
begin
  Result := Self ;
  FfltPorcen := AfltValue ;
end;

function TDadosApuracaoLucroPresumidoDetalhe.SeqGer: String;
begin
  Result := FstrSeqGer ;
end;

function TDadosApuracaoLucroPresumidoDetalhe.SeqGer(
  const AstrValue: String): IDadosApuracaoLucroPresumidoDetalhe;
begin
  Result := Self ;
  FstrSeqGer := AstrValue ;
end;

{ TDadosApuracaoLucroPresumidoPeriodo }

function TDadosApuracaoLucroPresumidoPeriodo.Apuval(
  const AfltValue: Double): IDadosApuracaoLucroPresumidoPeriodo;
begin
  Result := Self ;
  FfltApuval := AfltValue ;
end;

function TDadosApuracaoLucroPresumidoPeriodo.Apuval: Double;
begin
  Result := FfltApuval ;
end;

function TDadosApuracaoLucroPresumidoPeriodo.Autoincrem(
  const AstrValue: String): IDadosApuracaoLucroPresumidoPeriodo;
begin
  Result := Self ;
  FstrAutoincrem := AstrValue ;
end;

function TDadosApuracaoLucroPresumidoPeriodo.Autoincrem: String;
begin
  Result := FstrAutoincrem ;
end;

constructor TDadosApuracaoLucroPresumidoPeriodo.Create;
begin
  FstrAutoincrem := '' ;
  FstrSeqGer := '' ;
  FintPeriod := 0 ;
  FfltApuval := 0.00 ;
end;

class function TDadosApuracaoLucroPresumidoPeriodo.New: IDadosApuracaoLucroPresumidoPeriodo;
begin
  Result := Self.Create ;
end;

function TDadosApuracaoLucroPresumidoPeriodo.Period: Integer;
begin
  Result := FintPeriod ;
end;

function TDadosApuracaoLucroPresumidoPeriodo.Period(
  const AintValue: Integer): IDadosApuracaoLucroPresumidoPeriodo;
begin
  Result := Self ;
  FintPeriod := AintValue ;
end;

function TDadosApuracaoLucroPresumidoPeriodo.SeqGer: String;
begin
  Result := FstrSeqGer ;
end;

function TDadosApuracaoLucroPresumidoPeriodo.SeqGer(
  const AstrValue: String): IDadosApuracaoLucroPresumidoPeriodo;
begin
  Result := Self ;
  FstrSeqGer := AstrValue ;
end;

{ TDadosApuracaoLucroPresumido }

function TDadosApuracaoLucroPresumido.BaseCalculo(
  AItem: IDadosApuracaoLucroPresumidoDetalhe): IDadosApuracaoLucroPresumido;
begin
  Result := Self ;
  FBaseCalculo.Add(AItem) ;
end;

function TDadosApuracaoLucroPresumido.BaseCalculo: TList<IDadosApuracaoLucroPresumidoDetalhe>;
begin
  Result := FBaseCalculo ;
end;

function TDadosApuracaoLucroPresumido.CalculoImposto: TList<IDadosApuracaoLucroPresumidoDetalhe>;
begin
  Result := FCalculoImposto ;
end;

function TDadosApuracaoLucroPresumido.CalculoImposto(
  AItem: IDadosApuracaoLucroPresumidoDetalhe): IDadosApuracaoLucroPresumido;
begin
  Result := Self ;
  FCalculoImposto.Add(AItem) ;
end;

constructor TDadosApuracaoLucroPresumido.Create;
begin
  FGeral := Nil ;
  FBaseCalculo := TList<IDadosApuracaoLucroPresumidoDetalhe>.Create ;
  FCalculoImposto := TList<IDadosApuracaoLucroPresumidoDetalhe>.Create ;
end;

destructor TDadosApuracaoLucroPresumido.Destroy;
begin
  FreeAndNil(FBaseCalculo) ;
  FreeAndNil(FCalculoImposto) ;
  inherited;
end;

function TDadosApuracaoLucroPresumido.Geral(
  const AValue: IDadosApuracaoLucroPresumidoGeral): IDadosApuracaoLucroPresumido;
begin
  Result := Self ;
  FGeral := AValue ;
end;

function TDadosApuracaoLucroPresumido.Geral: IDadosApuracaoLucroPresumidoGeral;
begin
  Result := FGeral ;
end;

class function TDadosApuracaoLucroPresumido.New: IDadosApuracaoLucroPresumido;
begin
  Result := Self.Create ;
end;

{ TColunaDetalhePeriodo }

function TColunaDetalhePeriodo.fRetornaColuna(
  const AstrValorCodigoDetalhe: String): String;
begin
  if fEmptyStr(AstrValorCodigoDetalhe) then
    Result := 'CONFIG'
  else
    Result := 'CODIGO' ;
end;

class function TColunaDetalhePeriodo.New: IColunaDetalhePlanco;
begin
  Result := Self.Create ;
end;

{ TDadosApuracaoLucroPresumidoPlanco }

function TDadosApuracaoLucroPresumidoPlanco.CodCon: String;
begin
  Result := FstrCodCon ;
end;

function TDadosApuracaoLucroPresumidoPlanco.CodCon(
  const AstrValue: String): IDadosApuracaoLucroPresumidoPlanco;
begin
  Result := Self ;
  FstrCodCon := AstrValue ;
end;

function TDadosApuracaoLucroPresumidoPlanco.Config: Integer;
begin
  Result := FintConfig ;
end;

function TDadosApuracaoLucroPresumidoPlanco.Config(
  const AintValue: Integer): IDadosApuracaoLucroPresumidoPlanco;
begin
  Result := Self ;
  FintConfig := AintValue ;
end;

constructor TDadosApuracaoLucroPresumidoPlanco.Create;
begin
  FstrCodCon := '' ;
  FstrTpLaCo := '' ;
  FintConfig := 0 ;
end;

class function TDadosApuracaoLucroPresumidoPlanco.New: IDadosApuracaoLucroPresumidoPlanco;
begin
  Result := Self.Create ;
end;

function TDadosApuracaoLucroPresumidoPlanco.TpLaCo: String;
begin
  Result := FstrTpLaCo ;
end;

function TDadosApuracaoLucroPresumidoPlanco.TpLaCo(
  const AstrValue: String): IDadosApuracaoLucroPresumidoPlanco;
begin
  Result := Self ;
  FstrTpLaCo := AstrValue ;
end;

{ TTipoApuracaoLucroPresumidoProcessaCalculos }

function TTipoApuracaoLucroPresumidoProcessaCalculos.CdsApuracao(
  var Acds: TUniClientDataSet): ITipoApuracaoLucroPresumidoProcessaCalculos;
begin
  Result := Self ;
  FcdsApuracao := Acds ;
end;

function TTipoApuracaoLucroPresumidoProcessaCalculos.CdsBaseCalculo(
  var Acds: TUniClientDataSet): ITipoApuracaoLucroPresumidoProcessaCalculos;
begin
  Result := Self ;
  FcdsBaseCalculo := Acds ;
end;

constructor TTipoApuracaoLucroPresumidoProcessaCalculos.Create;
begin
  FcdsBaseCalculo := Nil ;
  FcdsApuracao    := Nil ;
end;

function TTipoApuracaoLucroPresumidoProcessaCalculos.fLinhaSemDados(
  const AobjLinhaSemDados: ITipoLinhasSemInformacao): ITipoApuracaoLucroPresumidoProcessaCalculos;
begin
  Result := Self ;
  FobjLinhaSemDados := AobjLinhaSemDados ;
end;

function TTipoApuracaoLucroPresumidoProcessaCalculos.fProcessar(
  const ADados: IDadosApuracaoLucroPresumido): boolean;
var
  LlstConfigDetalhe: TList<IDadosApuracaoLucroPresumidoDetalhe> ;
  LobjConfigDetalhe: IDadosApuracaoLucroPresumidoDetalhe ;
  LobjPeriodo: IDadosApuracaoLucroPresumidoPeriodo ;
  LfltTotalPeriodos: Double ;
begin
  Result := False ;

  if not Assigned(ADados) then
    Exit ;

  FcdsBaseCalculo.EmptyDataSet ;
  FcdsApuracao.EmptyDataSet ;

  // base calculo
  LlstConfigDetalhe := ADados.BaseCalculo ;
  for LobjConfigDetalhe in LlstConfigDetalhe do
  begin
    FcdsBaseCalculo.Append ;
    FcdsBaseCalculo.FieldByName('AUTOINCREM').AsInteger := LobjConfigDetalhe.Config ;
    FcdsBaseCalculo.FieldByName('CODIGO').AsString := LobjConfigDetalhe.CodPar ;
    FcdsBaseCalculo.FieldByName('DESCRI').AsString := LobjConfigDetalhe.Descri ;
    if FobjLinhaSemDados.fGrupo(BASE_CALCULO).fLinha(LobjConfigDetalhe.CodPar).fTemInformacao then
    begin
      LfltTotalPeriodos := 0.00 ;
      for LobjPeriodo in LobjConfigDetalhe.Periodos do
      begin
        FcdsBaseCalculo.FieldByName('PERIOD_'+fStrZero(LobjPeriodo.Period, 2)).AsFloat := LobjPeriodo.Apuval ;
        LfltTotalPeriodos := LfltTotalPeriodos + LobjPeriodo.Apuval ;
      end ;
      FcdsBaseCalculo.FieldByName('PERIOD_TOT').AsFloat := LfltTotalPeriodos ;
    end ;
    FcdsBaseCalculo.FieldByName('BLOQUE').AsString := ifThen(LobjConfigDetalhe.Planco.Count > 0, 'S', 'N') ;
    FcdsBaseCalculo.FieldByName('PORCEN').AsFloat := LobjConfigDetalhe.Porcen ;
    FcdsBaseCalculo.Post ;
  end ;

  // apuração
  LlstConfigDetalhe := ADados.CalculoImposto ;
  for LobjConfigDetalhe in LlstConfigDetalhe do
  begin
    FcdsApuracao.Append ;
    FcdsApuracao.FieldByName('AUTOINCREM').AsInteger := LobjConfigDetalhe.Config ;
    FcdsApuracao.FieldByName('CODIGO').AsString := LobjConfigDetalhe.CodPar ;
    FcdsApuracao.FieldByName('DESCRI').AsString := LobjConfigDetalhe.Descri ;
    if FobjLinhaSemDados.fGrupo(APURACAO).fLinha(LobjConfigDetalhe.CodPar).fTemInformacao then
    begin
      LfltTotalPeriodos := 0.00 ;
      for LobjPeriodo in LobjConfigDetalhe.Periodos do
      begin
        FcdsApuracao.FieldByName('PERIOD_'+fStrZero(LobjPeriodo.Period, 2)).AsFloat := LobjPeriodo.Apuval ;
        LfltTotalPeriodos := LfltTotalPeriodos + LobjPeriodo.Apuval ;
      end ;
      FcdsApuracao.FieldByName('PERIOD_TOT').AsFloat := LfltTotalPeriodos ;
    end ;
    FcdsApuracao.FieldByName('BLOQUE').AsString := ifThen(LobjConfigDetalhe.Planco.Count > 0, 'S', 'N') ;
    FcdsApuracao.FieldByName('PORCEN').AsFloat := LobjConfigDetalhe.Porcen ;
    FcdsApuracao.Post ;
  end ;

  Result := True ;
end;

function TTipoApuracaoLucroPresumidoProcessaCalculos.fReprocessar(const AstrCodEmp: String; const AintExercicio: Integer): boolean;
var
  LintPeriod: Integer ;
  LstrPeriod: String ;
  LfltValor: Double ;
begin
  //calcula os totais das linhas
  FcdsBaseCalculo.First ;
  while not FcdsBaseCalculo.Eof do
  begin
    if not FobjLinhaSemDados.fGrupo(BASE_CALCULO).fLinha(FcdsBaseCalculo.FieldByName('CODIGO').AsString).fTemInformacao then
    begin
      FcdsBaseCalculo.Next ;
      continue ;
    end ;

    LfltValor := 0.00 ;
    for LintPeriod := 1 to 4 do
    begin
      LstrPeriod := fStrZero(IntToStr(LintPeriod), 2) ;
      LfltValor := LfltValor + FcdsBaseCalculo.FieldByName('PERIOD_'+LstrPeriod).AsFloat ;
    end ;
    FcdsBaseCalculo.Edit ;
    FcdsBaseCalculo.FieldByName('PERIOD_TOT').AsFloat := LfltValor ;
    FcdsBaseCalculo.Post ;

    FcdsBaseCalculo.Next ;
  end ;

  FcdsApuracao.First ;
  while not FcdsApuracao.Eof do
  begin
    if not FobjLinhaSemDados.fGrupo(APURACAO).fLinha(FcdsApuracao.FieldByName('CODIGO').AsString).fTemInformacao then
    begin
      FcdsApuracao.Next ;
      continue ;
    end ;

    LfltValor := 0.00 ;
    for LintPeriod := 1 to 4 do
    begin
      LstrPeriod := fStrZero(IntToStr(LintPeriod), 2) ;
      LfltValor := LfltValor + FcdsApuracao.FieldByName('PERIOD_'+LstrPeriod).AsFloat ;
    end ;
    FcdsApuracao.Edit ;
    FcdsApuracao.FieldByName('PERIOD_TOT').AsFloat := LfltValor ;
    FcdsApuracao.Post ;

    FcdsApuracao.Next ;
  end ;

  Result := True ;
end;

class function TTipoApuracaoLucroPresumidoProcessaCalculos.New: ITipoApuracaoLucroPresumidoProcessaCalculos;
begin
  Result := Self.Create ;
end;

{ TTipoTrimestres }

constructor TTipoTrimestres.Create;
begin
  FlstMeses := TList<Integer>.Create ;
  FintExerci := 0 ;
end;

destructor TTipoTrimestres.Destroy;
begin
  FreeAndNil(FlstMeses) ;
  inherited;
end;

function TTipoTrimestres.Exerci(const AintValue: Integer): ITipoTrimestres;
begin
  Result := Self ;
  FintExerci := AintValue ;
end;

function TTipoTrimestres.IniAtv(const AdtaValue: TDateTime): ITipoTrimestres;
begin
  Result := Self ;
  FdtaIniAtv := AdtaValue ;
end;

function TTipoTrimestres.MesesValidos: TList<Integer>;
var
  LdtaIni, LdtaFin: TDateTime ;
  LintMes: Integer ;
  LintCntMes: Integer ;
  LblnContaMes: Boolean ;
begin
  LdtaIni := EncodeDate(FintExerci, 1, 1) ;
  LdtaFin := EncodeDate(FintExerci, 12, 31) ;
  FlstMeses.Clear ;
  if (FdtaIniAtv >= LdtaIni) and (FdtaIniAtv <= LdtaFin) then
  begin
    FlstMeses.Add(0) ; // 1º Trimestre
    FlstMeses.Add(0) ; // 2º Trimestre
    FlstMeses.Add(0) ; // 3º Trimestre
    FlstMeses.Add(0) ; // 4º Trimestre
    //analisa mês a Mês
    LblnContaMes := False ;
    LintCntMes := 0 ;
    for LintMes := 1 to 12 do
    begin
      LdtaIni := EncodeDate(FintExerci, LintMes, 1) ;
      LdtaFin := EndOfAMonth(FintExerci, LintMes) ;

      if (FdtaIniAtv >= LdtaIni) and (FdtaIniAtv <= LdtaFin) then
        LblnContaMes := True ;

      LintCntMes := LintCntMes + ifThen(LblnContaMes, 1, 0) ;
      if LintMes mod 3 = 0 then
      begin
        FlstMeses.Items[(LintMes div 3)-1] := LintCntMes ;
        LintCntMes := 0 ;
      end ;
    end ;
  end
  else
  begin
    FlstMeses.Add(3) ; // 1º Trimestre
    FlstMeses.Add(3) ; // 2º Trimestre
    FlstMeses.Add(3) ; // 3º Trimestre
    FlstMeses.Add(3) ; // 4º Trimestre
  end ;
  Result := FlstMeses ;
end;

class function TTipoTrimestres.New: ITipoTrimestres;
begin
  Result := Self.Create ;
end;

{ TTipoFiltroLancon }

constructor TTipoFiltroLancon.Create;
begin
  FdtsCadEmp := Nil ;
  FdtsPlancoConfig := Nil ;
  FstrColunaPlanoContas := '' ;
  FblnProcessaLancon := True ;
end;

function TTipoFiltroLancon.fCadEmp(
  const ACadEmp: TDataSet): ITipoFiltroLancon;
begin
  Result := Self ;
  FdtsCadEmp := ACadEmp ;
end;

function TTipoFiltroLancon.fColunaPlanoContas(
  const AstrNomeColuna: String): ITipoFiltroLancon;
begin
  Result := Self ;
  FstrColunaPlanoContas := AstrNomeColuna ;
end;

function TTipoFiltroLancon.fPlanco(
  const APlancoConfig: TDataSet): ITipoFiltroLancon;
begin
  Result := Self ;
  FdtsPlancoConfig := APlancoConfig ;
end;

class function TTipoFiltroLancon.New: ITipoFiltroLancon;
begin
  Result := Self.Create ;
end;

procedure TTipoFiltroLancon.pConcatenaCodigos(const AstrCodigo: String;
  var AstrCodigos: String);
begin
  if fEmptyStr(AstrCodigos) then
    AstrCodigos := fQuotedStr(AstrCodigo)
  else
    AstrCodigos := AstrCodigos +','+ fQuotedStr(AstrCodigo) ;
end;

procedure TTipoFiltroLancon.pGeraFiltro(var AqryLancon: TUniQuery);
var
  LstrCodEmp: String ;
  LstrPlanco: String ;
begin
  if not Assigned(FdtsCadEmp) then
    Exit ;

  if not Assigned(FdtsPlancoConfig) then
    Exit ;

  if not FblnProcessaLancon then
  begin
    AqryLancon.SQL.Add(' AND FALSE ') ;
    exit ;
  end ;

  LstrCodEmp := '' ;
  LstrPlanco := '' ;

  FdtsCadEmp.First ;
  while not FdtsCadEmp.Eof do
  begin
    pConcatenaCodigos(FdtsCadEmp.FieldByName('EMP_CODEMP').AsString, LstrCodEmp) ;
    FdtsCadEmp.Next ;
  end ;

  FdtsPlancoConfig.First ;
  while not FdtsPlancoConfig.Eof do
  begin
    pConcatenaCodigos(FdtsPlancoConfig.FieldByName('CODCON').AsString, LstrPlanco) ;
    FdtsPlancoConfig.Next ;
  end ;

  if not fEmptyStr(LstrCodEmp) then
    AqryLancon.SQL.Add(' AND CON_EMPLAN IN (' + LstrCodEmp + ') ') ;

  if not fEmptyStr(LstrPlanco) then
    AqryLancon.SQL.Add(' AND ' + FstrColunaPlanoContas + ' IN (' + LstrPlanco + ') ')
  else
    AqryLancon.SQL.Add(' AND FALSE ') ;

end;

function TTipoFiltroLancon.ProcessaLanCon(
  const AblnValue: Boolean): ITipoFiltroLancon;
begin
  FblnProcessaLancon := AblnValue ;
  Result := Self ;
end;

{ TTipoApuracaoLucroPresumidoConverte }

function TTipoApuracaoLucroPresumidoConverte.CodEmp(
  const AstrValue: String): ITipoApuracaoLucroPresumidoConverte;
begin
  FstrCodEmp := AstrValue ;
  Result := Self ;
end;

function TTipoApuracaoLucroPresumidoConverte.Codigo(
  const AstrValue: String): ITipoApuracaoLucroPresumidoConverte;
begin
  FstrCodigo := AstrValue ;
  Result := Self ;
end;

constructor TTipoApuracaoLucroPresumidoConverte.Create;
begin
  FstrCodEmp := '' ;
  FstrCodigo := '' ;
  FintExerci := 0 ;
end;

function TTipoApuracaoLucroPresumidoConverte.Exerci(
  const AintValue: Integer): ITipoApuracaoLucroPresumidoConverte;
begin
  FintExerci := AintValue ;
  Result := Self ;
end;

function TTipoApuracaoLucroPresumidoConverte.fConverte(const AcdsBaseCalculo,
  AcdsApuracaoValor: TUniClientDataSet): IDadosApuracaoLucroPresumido;
var
  LobjGeral: IDadosApuracaoLucroPresumidoGeral ;
  LobjDetalhe: IDadosApuracaoLucroPresumidoDetalhe ;
  LintPeriod: Integer ;
  LobjPeriodo: IDadosApuracaoLucroPresumidoPeriodo ;
  LobjApuracao: IDadosApuracaoLucroPresumido ;
begin
  LobjGeral := TDadosApuracaoLucroPresumidoGeral
                 .New
                 .Codigo(FstrCodigo)
                 .CodEmp(FstrCodEmp)
                 .Exerci(FintExerci) ;

  LobjApuracao := TDadosApuracaoLucroPresumido
                    .New
                    .Geral(LobjGeral) ;

  AcdsBaseCalculo.DisableControls ;
  AcdsApuracaoValor.DisableControls ;
  try

    AcdsBaseCalculo.First ;
    while not AcdsBaseCalculo.Eof do
    begin
      LobjDetalhe := TDadosApuracaoLucroPresumidoDetalhe
                       .New
                       .Codigo(AcdsBaseCalculo.FieldByName('CODIGO').AsString)
                       .Config(AcdsBaseCalculo.FieldByName('AUTOINCREM').AsInteger) ;

      for LintPeriod := 1 to 4 do
      begin
        LobjPeriodo := TDadosApuracaoLucroPresumidoPeriodo
                         .New
                         .Period(LintPeriod)
                         .Apuval(AcdsBaseCalculo.FieldByName('PERIOD_'+fStrZero(LintPeriod, 2)).AsFloat) ;
        LobjDetalhe.Periodos(LobjPeriodo) ;
      end ;

      LobjApuracao.BaseCalculo(LobjDetalhe) ;
      AcdsBaseCalculo.Next ;
    end ;

    AcdsApuracaoValor.First ;
    while not AcdsApuracaoValor.Eof do
    begin
      LobjDetalhe := TDadosApuracaoLucroPresumidoDetalhe
                       .New
                       .Codigo(AcdsApuracaoValor.FieldByName('CODIGO').AsString)
                       .Config(AcdsApuracaoValor.FieldByName('AUTOINCREM').AsInteger) ;

      for LintPeriod := 1 to 4 do
      begin
        LobjPeriodo := TDadosApuracaoLucroPresumidoPeriodo
                         .New
                         .Period(LintPeriod)
                         .Apuval(AcdsApuracaoValor.FieldByName('PERIOD_'+fStrZero(LintPeriod, 2)).AsFloat) ;
        LobjDetalhe.Periodos(LobjPeriodo) ;
      end ;

      LobjApuracao.CalculoImposto(LobjDetalhe) ;
      AcdsApuracaoValor.Next ;
    end ;

  finally
    AcdsBaseCalculo.EnableControls ;
    AcdsApuracaoValor.EnableControls ;
  end ;

  Result := LobjApuracao ;
end;

class function TTipoApuracaoLucroPresumidoConverte.New: ITipoApuracaoLucroPresumidoConverte;
begin
  Result := Self.Create ;
end;

end.
