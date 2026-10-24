unit Contabilidade.Classes.ApuracaoLucroPresumidoIrpj;

interface

uses
  Contabilidade.Interfaces.ApuracaoLucroPresumido, Data.DB, MemDS, DBAccess,
  Uni, Datasnap.DBClient, UniClientDataSet ;

type
  TTipoApuracaoLucroPresumidoCarregaIrpj = class(TInterfacedObject, ITipoApuracaoLucroPresumidoCarrega)
  private
    FblnProcessaLanCon: Boolean ;
    procedure pCarregaBd(const AstrCodEmp: String; const AintExercicio: Integer;
                         var AqryGeral, AqryDetalhe, AqryPeriodos, AqryPlanco: TUniQuery;
                         var AcdsLancon: TUniClientDataSet);
    function fCarregaInterno(const AstrCodEmp: String; const AintExercicio: Integer; var AstrMensagem: String): IDadosApuracaoLucroPresumido;
  public
    function fCarrega(const AstrCodEmp: String; const AintExercicio: Integer; var AstrMensagem: String): IDadosApuracaoLucroPresumido;
    function ProcessaLanCon(const AblnValue: Boolean): ITipoApuracaoLucroPresumidoCarrega ;
    class function New: ITipoApuracaoLucroPresumidoCarrega ;
    constructor Create ;
  end ;

  TTipoApuracaoLucroPresumidoSalvaIrpj = class(TInterfacedObject, ITipoApuracaoLucroPresumidoSalva)
  public
    function fSalva(const AApuracao: IDadosApuracaoLucroPresumido): Boolean;
    class function New: ITipoApuracaoLucroPresumidoSalva;
  end ;

  TTipoApuracaoLucroPresumidoDeleteIrpj = class(TInterfacedObject, ITipoApuracaoLucroPresumidoDelete)
  public
    function fDelete(const AstrCodigo: String): Boolean;
    class function New: ITipoApuracaoLucroPresumidoDelete;
  end ;

  TTipoApuracaoLucroPresumidoProcessaCalculosIrpj = class(TInterfacedObject, ITipoApuracaoLucroPresumidoProcessaCalculos)
  private
    FobjLinhaSemDados: ITipoLinhasSemInformacao ;
    FcdsBaseCalculo: TUniClientDataSet ;
    FcdsApuracao: TUniClientDataSet ;
    procedure pTotalizarColunasLinha26Bc ;
    procedure pTotalizarColunasLinha10Bc ;
    procedure pTotalizarColunasLinha1VL ;
    procedure pTotalizarColunasLinha3VL ;
    procedure pTotalizarColunasLinha4VL(const AstrCodEmp: String; const AintExercicio: Integer) ;
    procedure pTotalizarColunasLinha15VL ;
  public
    function CdsBaseCalculo(var Acds: TUniClientDataSet): ITipoApuracaoLucroPresumidoProcessaCalculos;
    function CdsApuracao(var Acds: TUniClientDataSet): ITipoApuracaoLucroPresumidoProcessaCalculos;
    function fProcessar(const ADados: IDadosApuracaoLucroPresumido): boolean ;
    function fLinhaSemDados(const AobjLinhaSemDados: ITipoLinhasSemInformacao): ITipoApuracaoLucroPresumidoProcessaCalculos;
    class function New: ITipoApuracaoLucroPresumidoProcessaCalculos;
    function fReprocessar(const AstrCodEmp: String; const AintExercicio: Integer): boolean ;
    constructor Create ;
  end ;

  TTipoLinhasSemEdicaoIrpj = class(TInterfacedObject, ITipoLinhasSemEdicao)
  private
    FstrGrupo: String ;
    FstrLinha: String ;
    FarrSemEdicaoBC: array[0..2] of string ;
    FarrSemEdicaoVL: array[0..5] of string ;
  public
    function fGrupo(const AstrGrupo: String): ITipoLinhasSemEdicao ;
    function fLinha(const AstrLinha: String): ITipoLinhasSemEdicao ;
    function fPodeEditar: Boolean ;
    class function New: ITipoLinhasSemEdicao;
    constructor Create ;
  end ;

  TTipoLinhasSemInformacaoIrpj = class(TInterfacedObject, ITipoLinhasSemInformacao)
  private
    FstrGrupo: String ;
    FstrLinha: String ;
    FarrSemInfoBC: array[0..0] of string ;
    FarrSemInfoVL: array[0..1] of string ;
  public
    function fGrupo(const AstrGrupo: String): ITipoLinhasSemInformacao ;
    function fLinha(const AstrLinha: String): ITipoLinhasSemInformacao ;
    function fTemInformacao: Boolean ;
    class function New: ITipoLinhasSemInformacao;
    constructor Create ;
  end ;

implementation

uses
  untFuncoesSimples, SysUtils, Contabilidade.Classes.ApuracaoLucroPresumidoComum,
  Contabilidade.Classes.ConfigLucroPresumidoIrpj, System.Generics.Collections,
  Contabilidade.Interfaces.ConfigLucroPresumido, StrUtils,
  Contabilidade.Interfaces.SharedLucroPresumido,
  Contabilidade.Classes.ConfigLucroPresumidoFactory,
  Contabilidade.Funcoes.LucroPresumido, math ;

{ TTipoApuracaoLucroPresumidoCarregaIrpj }

constructor TTipoApuracaoLucroPresumidoCarregaIrpj.Create;
begin
  FblnProcessaLanCon := True ;
end;

function TTipoApuracaoLucroPresumidoCarregaIrpj.fCarrega(
  const AstrCodEmp: String;
  const AintExercicio: Integer;
  var AstrMensagem: String): IDadosApuracaoLucroPresumido;
begin
  Result := fCarregaInterno(AstrCodEmp, AintExercicio, AstrMensagem) ;
end;

function TTipoApuracaoLucroPresumidoCarregaIrpj.fCarregaInterno(
  const AstrCodEmp: String;
  const AintExercicio: Integer;
  var AstrMensagem: String): IDadosApuracaoLucroPresumido;
var
  LqryGeral: TUniQuery ;
  LqryDetalhe: TUniQuery ;
  LqryPeriodos: TUniquery ;
  LqryPlanco: TUniquery ;
  LobjCfg: IDadosConfigLucroPresumidoCfg ;
  LcdsLancon: TUniClientDataSet ;
begin
  Result := Nil ;

  LqryGeral := fCriaQuery() ;
  LqryDetalhe := fCriaQuery() ;
  LqryPeriodos := fCriaQuery() ;
  LqryPlanco := fCriaQuery() ;
  try

    pCarregaBd(AstrCodEmp,
               AintExercicio,
               LqryGeral,
               LqryDetalhe,
               LqryPeriodos,
               LqryPlanco,
               LcdsLancon) ;

    LobjCfg := TTipoConfigLucroPresumidoCarregaIrpj
                 .New
                 .fFiltroParame('N')
                 .fCarrega(AstrCodEmp, AintExercicio, AstrMensagem) ;

    if not Assigned(LobjCfg) then
      Exit ;

    Result := TTipoApuracaoLucroPresumidoPreparaCarrega.New.fPrepara(LqryGeral,
                                                                     LqryDetalhe,
                                                                     LqryPeriodos,
                                                                     LqryPlanco,
                                                                     LobjCfg,
                                                                     LcdsLancon);

  finally
    FreeAndNil(LqryGeral) ;
    FreeAndNil(LqryDetalhe) ;
    FreeAndNil(LqryPeriodos) ;
    FreeAndNil(LqryPlanco) ;
    FreeAndNil(LcdsLancon) ;
  end ;
end;

class function TTipoApuracaoLucroPresumidoCarregaIrpj.New: ITipoApuracaoLucroPresumidoCarrega;
begin
  Result := Self.Create ;
end;

procedure TTipoApuracaoLucroPresumidoCarregaIrpj.pCarregaBd(
  const AstrCodEmp: String; const AintExercicio: Integer; var AqryGeral,
  AqryDetalhe, AqryPeriodos, AqryPlanco: TUniQuery; var AcdsLancon: TUniClientDataSet);
begin

  AqryPlanco.SQL.Clear ;
  AqryPlanco.SQL.Add(' SELECT ') ;
  AqryPlanco.SQL.Add('   PRIRPD.IRD_PRNIRP AS CONFIG, ') ;
  AqryPlanco.SQL.Add('   PRIRCN.IRC_CODCON AS CODCON, ') ;
  AqryPlanco.SQL.Add('   PRIRCN.IRC_TPLACO AS TPLACO ') ;
  AqryPlanco.SQL.Add(' FROM PRIRPG ') ;
  AqryPlanco.SQL.Add('      INNER JOIN PRIRPD ON PRIRPG.IRM_CODIGO = PRIRPD.IRD_SEQGER ') ;
  AqryPlanco.SQL.Add('      INNER JOIN PRIRCN ON PRIRPD.IRD_CODIGO = PRIRCN.IRC_SEQGER ') ;
  AqryPlanco.SQL.Add(' WHERE IRM_CODEMP = :CODEMP ') ;
  AqryPlanco.SQL.Add('       AND IRM_EXERCI = :EXERCI ; ') ;
  AqryPlanco.ParamByName('CODEMP').AsString := AstrCodEmp ;
  AqryPlanco.ParamByName('EXERCI').AsInteger := AintExercicio ;
  AqryPlanco.Open ;

  AqryGeral.SQL.Clear ;
  AqryGeral.SQL.Add(' SELECT ') ;
  AqryGeral.SQL.Add('  AUTOINCREM, ') ;
  AqryGeral.SQL.Add('  APG_CODIGO AS CODIGO, ') ;
  AqryGeral.SQL.Add('  APG_CODEMP AS CODEMP, ') ;
  AqryGeral.SQL.Add('  APG_EXERCI AS EXERCI  ') ;
  AqryGeral.SQL.Add('  FROM APIRPG ') ;
  AqryGeral.SQL.Add('    WHERE APG_CODEMP = :CODEMP ') ;
  AqryGeral.SQL.Add('    AND APG_EXERCI = :EXERCI ') ;
  AqryGeral.ParamByName('CODEMP').AsString := AstrCodEmp ;
  AqryGeral.ParamByName('EXERCI').AsInteger := AintExercicio ;
  AqryGeral.Open ;

  AqryDetalhe.SQL.Clear ;
  AqryDetalhe.SQL.Add(' SELECT ') ;
  AqryDetalhe.SQL.Add('  APIRPD.AUTOINCREM, ') ;
  AqryDetalhe.SQL.Add('  APD_CODIGO AS CODIGO, ') ;
  AqryDetalhe.SQL.Add('  APD_SEQGER AS SEQGER, ') ;
  AqryDetalhe.SQL.Add('  APD_CONFIG AS CONFIG, ') ;
  AqryDetalhe.SQL.Add('  PRN_GRUPO_ AS GRUPO_, ') ;
  AqryDetalhe.SQL.Add('  PRN_CODIGO AS CODPAR, ') ;
  AqryDetalhe.SQL.Add('  PRN_DESCRI AS DESCRI, ') ;
  AqryDetalhe.SQL.Add('  PRN_PORCEN AS PORCEN ') ;
  AqryDetalhe.SQL.Add(' FROM APIRPD INNER JOIN PRNIRP ON APD_CONFIG = PRNIRP.AUTOINCREM ') ;
  AqryDetalhe.SQL.Add(' WHERE APD_SEQGER = :SEQGER ; ') ;
  AqryDetalhe.ParamByName('SEQGER').AsString := AqryGeral.FieldByName('CODIGO').AsString ;
  AqryDetalhe.Open ;

  AqryPeriodos.SQL.Clear ;
  AqryPeriodos.SQL.Add(' SELECT ') ;
  AqryPeriodos.SQL.Add('   APIRPE.AUTOINCREM, ') ;
  AqryPeriodos.SQL.Add('   APIRPE.APP_SEQGER AS SEQGER, ') ;
  AqryPeriodos.SQL.Add('   APIRPE.APP_PERIOD AS PERIOD, ') ;
  AqryPeriodos.SQL.Add('   APIRPE.APP_APUVAL AS APUVAL ') ;
  AqryPeriodos.SQL.Add(' FROM APIRPE ') ;
  AqryPeriodos.SQL.Add('     INNER JOIN APIRPD ON APIRPE.APP_SEQGER = APIRPD.APD_CODIGO ') ;
  AqryPeriodos.SQL.Add(' WHERE APIRPD.APD_SEQGER = :SEQGER ') ;
  AqryPeriodos.ParamByName('SEQGER').AsString := AqryGeral.FieldByName('CODIGO').AsString ;
  AqryPeriodos.Open ;

  ///Recupera os valores da LANCON, caso tenha parametro.
  AcdsLancon := fCarregaDadosLancon(AqryPlanco, AstrCodEmp, AintExercicio, FblnProcessaLanCon) ;
end;

function TTipoApuracaoLucroPresumidoCarregaIrpj.ProcessaLanCon(
  const AblnValue: Boolean): ITipoApuracaoLucroPresumidoCarrega;
begin
  FblnProcessaLanCon := AblnValue ;
  Result := Self ;
end;

{ TTipoApuracaoLucroPresumidoSalvaIrpj }

function TTipoApuracaoLucroPresumidoSalvaIrpj.fSalva(
  const AApuracao: IDadosApuracaoLucroPresumido): Boolean;
var
  LstrAutoInc: String ;
  LstrProCod: String ;
  LqryExecGeral: TUniQuery ;
  LqryExecDetalhe: TUniQuery ;
  LqryExecDetalhePeriodo: TUniQuery ;
  LobjItem: IDadosApuracaoLucroPresumidoDetalhe ;
  LobjItemPeriodo: IDadosApuracaoLucroPresumidoPeriodo ;
  LintTamanhoCampoDetalhe: Integer ;
  LblnEmTransacao: Boolean ;
  LintTamanhoCampo: Integer ;
begin
  Result := False ;
  LblnEmTransacao := fInTransaction ;

  if not LblnEmTransacao then
    fStartTransaction() ;

  try

    if not TTipoApuracaoLucroPresumidoDeleteIrpj.New.fDelete(AApuracao.Geral.Codigo) then
    begin
      fRollback();
      exit ;
    end ;

    LqryExecGeral := fCriaQuery() ;
    LqryExecDetalhe := fCriaQuery() ;
    LqryExecDetalhePeriodo := fCriaQuery() ;
    try
      LqryExecGeral.Close ;
      LqryExecGeral.SQL.Clear ;
      LqryExecGeral.SQL.Add('SELECT * FROM APIRPG WHERE FALSE') ;
      LqryExecGeral.Open ;

      LstrAutoInc := fRetAutoIncrem('APIRPG', VS_strCodEmp) ;
      LintTamanhoCampo := fRetTamCampo('APIRPG') ;
      LintTamanhoCampo := ifThen(LintTamanhoCampo = 0, 8, LintTamanhoCampo) ;
      LstrProCod := fAtualizaProCod('APIRPG', 'APG_CODIGO', '', 1, Nil,
        function (const AValue: String) : String
        begin
          Result := fPadL(AValue, LintTamanhoCampo, '0');
        end
      );

      LqryExecGeral.Append ;
      LqryExecGeral.FieldByName('AUTOINCREM').AsString := LstrAutoInc ;
      LqryExecGeral.FieldByName('APG_CODIGO').AsString := LstrProCod ;
      LqryExecGeral.FieldByName('APG_CODEMP').AsString := AApuracao.Geral.CodEmp ;
      LqryExecGeral.FieldByName('APG_EXERCI').AsInteger := AApuracao.Geral.Exerci ;
      LqryExecGeral.Post ;

      LqryExecDetalhe.Close ;
      LqryExecDetalhe.SQL.Clear ;
      LqryExecDetalhe.SQL.Add('SELECT * FROM APIRPD WHERE FALSE') ;
      LqryExecDetalhe.Open ;

      LqryExecDetalhePeriodo.Close ;
      LqryExecDetalhePeriodo.SQL.Clear ;
      LqryExecDetalhePeriodo.SQL.Add('SELECT * FROM APIRPE WHERE FALSE') ;
      LqryExecDetalhePeriodo.Open ;

      LintTamanhoCampoDetalhe := fRetTamCampo('APIRPD') ;
      LintTamanhoCampoDetalhe := ifThen(LintTamanhoCampoDetalhe = 0, 8, LintTamanhoCampoDetalhe) ;

      for LobjItem in AApuracao.BaseCalculo do
      begin
        LqryExecDetalhe.Append ;
        LqryExecDetalhe.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('APIRPD', VS_strCodEmp) ;
        LqryExecDetalhe.FieldByName('APD_CODIGO').AsString := fAtualizaProCod('APIRPD', 'APD_CODIGO', '', 1, Nil,
          function (const AValue : String) : String
          begin
            Result := fPadL(AValue, LintTamanhoCampoDetalhe, '0');
          end
        );
        LqryExecDetalhe.FieldByName('APD_SEQGER').AsString := LstrProCod ;
        LqryExecDetalhe.FieldByName('APD_CONFIG').AsInteger := LobjItem.Config ;
        LqryExecDetalhe.Post ;
        for LobjItemPeriodo in LobjItem.Periodos do
        begin
          LqryExecDetalhePeriodo.Append ;
          LqryExecDetalhePeriodo.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('APIRPE', VS_strCodEmp) ;
          LqryExecDetalhePeriodo.FieldByName('APP_SEQGER').AsString := LqryExecDetalhe.FieldByName('APD_CODIGO').AsString ;
          LqryExecDetalhePeriodo.FieldByName('APP_PERIOD').AsInteger := LobjItemPeriodo.Period ;
          LqryExecDetalhePeriodo.FieldByName('APP_APUVAL').AsFloat := LobjItemPeriodo.Apuval ;
          LqryExecDetalhePeriodo.Post ;
        end ;
      end ;

      for LobjItem in AApuracao.CalculoImposto do
      begin
        LqryExecDetalhe.Append ;
        LqryExecDetalhe.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('APIRPD', VS_strCodEmp) ;
        LqryExecDetalhe.FieldByName('APD_CODIGO').AsString := fAtualizaProCod('APIRPD', 'APD_CODIGO', '', 1, Nil,
          function (const AValue : String) : String
          begin
            Result := fPadL(AValue, LintTamanhoCampoDetalhe, '0');
          end
        );
        LqryExecDetalhe.FieldByName('APD_SEQGER').AsString := LstrProCod ;
        LqryExecDetalhe.FieldByName('APD_CONFIG').AsInteger := LobjItem.Config ;
        LqryExecDetalhe.Post ;
        for LobjItemPeriodo in LobjItem.Periodos do
        begin
          LqryExecDetalhePeriodo.Append ;
          LqryExecDetalhePeriodo.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('APIRPE', VS_strCodEmp) ;
          LqryExecDetalhePeriodo.FieldByName('APP_SEQGER').AsString := LqryExecDetalhe.FieldByName('APD_CODIGO').AsString ;
          LqryExecDetalhePeriodo.FieldByName('APP_PERIOD').AsInteger := LobjItemPeriodo.Period ;
          LqryExecDetalhePeriodo.FieldByName('APP_APUVAL').AsFloat := LobjItemPeriodo.Apuval ;
          LqryExecDetalhePeriodo.Post ;
        end ;
      end ;

      if not LblnEmTransacao then
        fCommit() ;

      Result := True ;
    finally
      FreeAndNil(LqryExecGeral) ;
      FreeAndNil(LqryExecDetalhe) ;
      FreeAndNil(LqryExecDetalhePeriodo) ;
    end ;

  Except
    On E: Exception Do
    Begin
      if not LblnEmTransacao then
        fRollback();
      Raise Exception.Create(E.message + 'Problemas ao salvar apuração Lucro Presumido. Tente novamente!');
    End;
  End;
end;

class function TTipoApuracaoLucroPresumidoSalvaIrpj.New: ITipoApuracaoLucroPresumidoSalva;
begin
  Result := Self.Create ;
end;

{ TTipoApuracaoLucroPresumidoDeleteIrpj }

function TTipoApuracaoLucroPresumidoDeleteIrpj.fDelete(
  const AstrCodigo: String): Boolean;
var
  LqryExec: TUniQuery ;
  LblnEmTransacao: Boolean ;
begin

  if fEmptyStr(AstrCodigo) then
    Exit(True) ;

  LblnEmTransacao := fInTransaction ;

  if not LblnEmTransacao then
    fStartTransaction() ;

  try

    LqryExec := fCriaQuery() ;
    try
      LqryExec.Close ;
      LqryExec.SQL.Clear ;
      LqryExec.SQL.Add('DELETE FROM APIRPG WHERE APG_CODIGO = :CODIGO ') ;
      LqryExec.ParamByName('CODIGO').AsString := AstrCodigo ;
      LqryExec.ExecSQL ;
    finally
      FreeAndNil(LqryExec) ;
    end ;

    if not LblnEmTransacao then
      fCommit() ;

    Result := True ;

  Except
    On E: Exception Do
    Begin
      if not LblnEmTransacao then
        fRollback();
      Raise Exception.Create(E.message + 'Problemas ao apagar apuração Lucro Presumido. Tente novamente!');
    End;
  End;

end;

class function TTipoApuracaoLucroPresumidoDeleteIrpj.New: ITipoApuracaoLucroPresumidoDelete;
begin
  Result := Self.Create ;
end;

{ TTipoApuracaoLucroPresumidoProcessaCalculosIrpj }

function TTipoApuracaoLucroPresumidoProcessaCalculosIrpj.CdsApuracao(
  var Acds: TUniClientDataSet): ITipoApuracaoLucroPresumidoProcessaCalculos;
begin
  Result := Self ;
  FcdsApuracao := Acds ;
end;

function TTipoApuracaoLucroPresumidoProcessaCalculosIrpj.CdsBaseCalculo(
  var Acds: TUniClientDataSet): ITipoApuracaoLucroPresumidoProcessaCalculos;
begin
  Result := Self ;
  FcdsBaseCalculo := Acds ;
end;

constructor TTipoApuracaoLucroPresumidoProcessaCalculosIrpj.Create;
begin
  FcdsBaseCalculo := Nil ;
  FcdsApuracao := Nil ;
  FobjLinhaSemDados := Nil ;
end;

function TTipoApuracaoLucroPresumidoProcessaCalculosIrpj.fLinhaSemDados(
  const AobjLinhaSemDados: ITipoLinhasSemInformacao): ITipoApuracaoLucroPresumidoProcessaCalculos;
begin
  Result := Self ;
  FobjLinhaSemDados := AobjLinhaSemDados ;
end;

function TTipoApuracaoLucroPresumidoProcessaCalculosIrpj.fProcessar(
  const ADados: IDadosApuracaoLucroPresumido): boolean;
var
  LevtDataSetBC, LevtDataSetAp: TDataSetNotifyEvent ;
begin
  Result := False ;

  if not Assigned(FcdsBaseCalculo) then
    Exit ;

  if not Assigned(FcdsApuracao) then
    Exit ;

  LevtDataSetBC := FcdsBaseCalculo.AfterPost ;
  LevtDataSetAp := FcdsApuracao.AfterPost ;
  FcdsBaseCalculo.AfterPost := Nil ;
  FcdsApuracao.AfterPost := Nil ;
  FcdsBaseCalculo.DisableControls ;
  FcdsApuracao.DisableControls ;
  try

    Result := TTipoApuracaoLucroPresumidoProcessaCalculos.New
                .CdsBaseCalculo(FcdsBaseCalculo)
                .CdsApuracao(FcdsApuracao)
                .fLinhaSemDados(FobjLinhaSemDados)
                .fProcessar(ADados) ;

    if not result then
      Exit ;

    // faz o processamento especifico
    Result := Self.fReprocessar(ADados.Geral.CodEmp, ADados.Geral.Exerci) ;

    FcdsBaseCalculo.First ;
    FcdsApuracao.First ;
  finally
    FcdsBaseCalculo.EnableControls ;
    FcdsApuracao.EnableControls ;
    FcdsBaseCalculo.AfterPost := LevtDataSetBC ;
    FcdsApuracao.AfterPost := LevtDataSetAP ;
  end ;
end;

function TTipoApuracaoLucroPresumidoProcessaCalculosIrpj.fReprocessar(const AstrCodEmp: String; const AintExercicio: Integer): boolean;
var
  LevtDataSetBC, LevtDataSetAp: TDataSetNotifyEvent ;
begin
  LevtDataSetBC := FcdsBaseCalculo.AfterPost ;
  LevtDataSetAp := FcdsApuracao.AfterPost ;
  FcdsBaseCalculo.AfterPost := Nil ;
  FcdsApuracao.AfterPost := Nil ;
  try
    pTotalizarColunasLinha10Bc ;
    pTotalizarColunasLinha26Bc ;
    pTotalizarColunasLinha1VL ;
    pTotalizarColunasLinha3VL ;
    pTotalizarColunasLinha4VL(AstrCodEmp, AintExercicio) ;
    pTotalizarColunasLinha15VL;
    // totaliza
    Result := TTipoApuracaoLucroPresumidoProcessaCalculos.New
                .CdsBaseCalculo(FcdsBaseCalculo)
                .CdsApuracao(FcdsApuracao)
                .fLinhaSemDados(FobjLinhaSemDados)
                .fReprocessar(AstrCodEmp, AintExercicio) ;
  finally
    FcdsBaseCalculo.AfterPost := LevtDataSetBC ;
    FcdsApuracao.AfterPost := LevtDataSetAP ;
  end ;
end;

class function TTipoApuracaoLucroPresumidoProcessaCalculosIrpj.New: ITipoApuracaoLucroPresumidoProcessaCalculos;
begin
  Result := Self.Create ;
end;

procedure TTipoApuracaoLucroPresumidoProcessaCalculosIrpj.pTotalizarColunasLinha10Bc;
const
  TOTALIZAR_BC_CODIGO_10: array[0..4] of string = ('2', '4', '6', '8', '9') ;
  LINHA_10= '10' ;
var
  LfltTrim01, LfltTrim02, LfltTrim03, LfltTrim04: Double ;
begin

  LfltTrim01 := 0.00 ;
  LfltTrim02 := 0.00 ;
  LfltTrim03 := 0.00 ;
  LfltTrim04 := 0.00 ;

  FcdsBaseCalculo.First ;
  while not FcdsBaseCalculo.Eof do
  begin
    if MatchText(FcdsBaseCalculo.FieldByName('CODIGO').AsString, TOTALIZAR_BC_CODIGO_10) then
    begin
      LfltTrim01 := LfltTrim01 + fFormataFloat(FcdsBaseCalculo.FieldByName('PERIOD_01').AsFloat*(FcdsBaseCalculo.FieldByName('PORCEN').AsFloat/100), 2) ;
      LfltTrim02 := LfltTrim02 + fFormataFloat(FcdsBaseCalculo.FieldByName('PERIOD_02').AsFloat*(FcdsBaseCalculo.FieldByName('PORCEN').AsFloat/100), 2) ;
      LfltTrim03 := LfltTrim03 + fFormataFloat(FcdsBaseCalculo.FieldByName('PERIOD_03').AsFloat*(FcdsBaseCalculo.FieldByName('PORCEN').AsFloat/100), 2) ;
      LfltTrim04 := LfltTrim04 + fFormataFloat(FcdsBaseCalculo.FieldByName('PERIOD_04').AsFloat*(FcdsBaseCalculo.FieldByName('PORCEN').AsFloat/100), 2) ;
    end ;
    FcdsBaseCalculo.Next ;
  end ;

  if FcdsBaseCalculo.Locate('CODIGO', LINHA_10, []) then
  begin
    FcdsBaseCalculo.Edit ;
    FcdsBaseCalculo.FieldByName('PERIOD_01').AsFloat := LfltTrim01 ;
    FcdsBaseCalculo.FieldByName('PERIOD_02').AsFloat := LfltTrim02 ;
    FcdsBaseCalculo.FieldByName('PERIOD_03').AsFloat := LfltTrim03 ;
    FcdsBaseCalculo.FieldByName('PERIOD_04').AsFloat := LfltTrim04 ;
    FcdsBaseCalculo.Post ;
  end ;
end;

procedure TTipoApuracaoLucroPresumidoProcessaCalculosIrpj.pTotalizarColunasLinha15VL;
const
  TOTALIZAR_CODIGO_15: array[0..10] of string = ('3','4','5','7','8','9','10','11','12','13','14') ;
  LINHA_15= '15' ;
var
  LfltTrim01, LfltTrim02, LfltTrim03, LfltTrim04: Double ;
begin
  LfltTrim01 := 0.00 ;
  LfltTrim02 := 0.00 ;
  LfltTrim03 := 0.00 ;
  LfltTrim04 := 0.00 ;

  FcdsApuracao.First ;
  while not FcdsApuracao.Eof do
  begin
    if MatchText(FcdsApuracao.FieldByName('CODIGO').AsString, TOTALIZAR_CODIGO_15) then
    begin
      LfltTrim01 := LfltTrim01 + FcdsApuracao.FieldByName('PERIOD_01').AsFloat ;
      LfltTrim02 := LfltTrim02 + FcdsApuracao.FieldByName('PERIOD_02').AsFloat ;
      LfltTrim03 := LfltTrim03 + FcdsApuracao.FieldByName('PERIOD_03').AsFloat ;
      LfltTrim04 := LfltTrim04 + FcdsApuracao.FieldByName('PERIOD_04').AsFloat ;
    end ;
    FcdsApuracao.Next ;
  end ;

  if FcdsApuracao.Locate('CODIGO', LINHA_15, []) then
  begin
    FcdsApuracao.Edit ;
    FcdsApuracao.FieldByName('PERIOD_01').AsFloat := LfltTrim01 ;
    FcdsApuracao.FieldByName('PERIOD_02').AsFloat := LfltTrim02 ;
    FcdsApuracao.FieldByName('PERIOD_03').AsFloat := LfltTrim03 ;
    FcdsApuracao.FieldByName('PERIOD_04').AsFloat := LfltTrim04 ;
    FcdsApuracao.Post ;
  end ;

end;

procedure TTipoApuracaoLucroPresumidoProcessaCalculosIrpj.pTotalizarColunasLinha1VL;
const
  LINHA_26 = '26' ;
  LINHA_1  = '1' ;
var
  LfltTrim01, LfltTrim02, LfltTrim03, LfltTrim04: Double ;
begin
  LfltTrim01 := 0.00 ;
  LfltTrim02 := 0.00 ;
  LfltTrim03 := 0.00 ;
  LfltTrim04 := 0.00 ;

  if FcdsBaseCalculo.Locate('CODIGO', LINHA_26, []) then
  begin
    LfltTrim01 := FcdsBaseCalculo.FieldByName('PERIOD_01').AsFloat ;
    LfltTrim02 := FcdsBaseCalculo.FieldByName('PERIOD_02').AsFloat ;
    LfltTrim03 := FcdsBaseCalculo.FieldByName('PERIOD_03').AsFloat ;
    LfltTrim04 := FcdsBaseCalculo.FieldByName('PERIOD_04').AsFloat ;
  end ;

  if FcdsApuracao.Locate('CODIGO', LINHA_1, []) then
  begin
    FcdsApuracao.Edit ;
    FcdsApuracao.FieldByName('PERIOD_01').AsFloat := LfltTrim01 ;
    FcdsApuracao.FieldByName('PERIOD_02').AsFloat := LfltTrim02 ;
    FcdsApuracao.FieldByName('PERIOD_03').AsFloat := LfltTrim03 ;
    FcdsApuracao.FieldByName('PERIOD_04').AsFloat := LfltTrim04 ;
    FcdsApuracao.Post ;
  end ;
end;

procedure TTipoApuracaoLucroPresumidoProcessaCalculosIrpj.pTotalizarColunasLinha26Bc;
const
  TOTALIZAR_BC_CODIGO_26: array[0..17] of string = ('10','11','12','13','14','15','16','17','18','19','20','20.01','22','23','24','25','25.01','25.02') ;
  LINHA_26= '26' ;
var
  LfltTrim01, LfltTrim02, LfltTrim03, LfltTrim04: Double ;
begin

  LfltTrim01 := 0.00 ;
  LfltTrim02 := 0.00 ;
  LfltTrim03 := 0.00 ;
  LfltTrim04 := 0.00 ;

  FcdsBaseCalculo.First ;
  while not FcdsBaseCalculo.Eof do
  begin
    if MatchText(FcdsBaseCalculo.FieldByName('CODIGO').AsString, TOTALIZAR_BC_CODIGO_26) then
    begin
      LfltTrim01 := LfltTrim01 + FcdsBaseCalculo.FieldByName('PERIOD_01').AsFloat ;
      LfltTrim02 := LfltTrim02 + FcdsBaseCalculo.FieldByName('PERIOD_02').AsFloat ;
      LfltTrim03 := LfltTrim03 + FcdsBaseCalculo.FieldByName('PERIOD_03').AsFloat ;
      LfltTrim04 := LfltTrim04 + FcdsBaseCalculo.FieldByName('PERIOD_04').AsFloat ;
    end ;
    FcdsBaseCalculo.Next ;
  end ;

  if FcdsBaseCalculo.Locate('CODIGO', LINHA_26, []) then
  begin
    FcdsBaseCalculo.Edit ;
    FcdsBaseCalculo.FieldByName('PERIOD_01').AsFloat := LfltTrim01 ;
    FcdsBaseCalculo.FieldByName('PERIOD_02').AsFloat := LfltTrim02 ;
    FcdsBaseCalculo.FieldByName('PERIOD_03').AsFloat := LfltTrim03 ;
    FcdsBaseCalculo.FieldByName('PERIOD_04').AsFloat := LfltTrim04 ;
    FcdsBaseCalculo.Post ;
  end ;
end;

procedure TTipoApuracaoLucroPresumidoProcessaCalculosIrpj.pTotalizarColunasLinha3VL;
const
  LINHA_1  = '1' ;
  LINHA_3  = '3' ;
  ALIQUOTA = 15.00 ;
var
  LfltTrim01, LfltTrim02, LfltTrim03, LfltTrim04: Double ;
begin
  LfltTrim01 := 0.00 ;
  LfltTrim02 := 0.00 ;
  LfltTrim03 := 0.00 ;
  LfltTrim04 := 0.00 ;

  if FcdsApuracao.Locate('CODIGO', LINHA_1, []) then
  begin
    LfltTrim01 := FcdsApuracao.FieldByName('PERIOD_01').AsFloat ;
    LfltTrim02 := FcdsApuracao.FieldByName('PERIOD_02').AsFloat ;
    LfltTrim03 := FcdsApuracao.FieldByName('PERIOD_03').AsFloat ;
    LfltTrim04 := FcdsApuracao.FieldByName('PERIOD_04').AsFloat ;
  end ;

  if FcdsApuracao.Locate('CODIGO', LINHA_3, []) then
  begin
    FcdsApuracao.Edit ;
    FcdsApuracao.FieldByName('PERIOD_01').AsFloat := fFormataFloat(LfltTrim01 * (ALIQUOTA/100), 2) ;
    FcdsApuracao.FieldByName('PERIOD_02').AsFloat := fFormataFloat(LfltTrim02 * (ALIQUOTA/100), 2) ;
    FcdsApuracao.FieldByName('PERIOD_03').AsFloat := fFormataFloat(LfltTrim03 * (ALIQUOTA/100), 2) ;
    FcdsApuracao.FieldByName('PERIOD_04').AsFloat := fFormataFloat(LfltTrim04 * (ALIQUOTA/100), 2) ;
    FcdsApuracao.Post ;
  end ;

end;

procedure TTipoApuracaoLucroPresumidoProcessaCalculosIrpj.pTotalizarColunasLinha4VL(const AstrCodEmp: String; const AintExercicio: Integer);
const
  LINHA_1  = '1' ;
  LINHA_4  = '4' ;
var
  LfltValorBaseAdicional: Double ;
  LfltAliqAdicional: Double ;
  LdtaApartirDe: TDateTime ;

  LarrTrim: array[1..4] of double ;
  LintCnt: integer ;
  LlstMesesValidos: TList<Integer> ;
  LfltBCMensal: Double ;
  LarrBCAdicionalTrim: array[1..4] of double ;
  LTrimestres: ITipoTrimestres ;
  LintMesesTrim: Integer ;
begin
  if AintExercicio = 0 then
    Exit ;

  LfltValorBaseAdicional := fCampoTabela('TRI_VALBAS', 'EPREGT', ['TRI_CODEMP', 'TRI_ANOEXE'], [AstrCodEmp, AintExercicio], False) ;
  LfltAliqAdicional := fCampoTabela('TRI_ADIRPJ', 'EPREGT', ['TRI_CODEMP', 'TRI_ANOEXE'], [AstrCodEmp, AintExercicio], False) ;
  LdtaApartirDe := fCampoTabela('TRI_INIATV', 'EPREGT', ['TRI_CODEMP', 'TRI_ANOEXE'], [AstrCodEmp, AintExercicio], False) ;

  LarrTrim[1] := 0.00 ;
  LarrTrim[2] := 0.00 ;
  LarrTrim[3] := 0.00 ;
  LarrTrim[4] := 0.00 ;

  LarrBCAdicionalTrim[1] := 0.00 ;
  LarrBCAdicionalTrim[2] := 0.00 ;
  LarrBCAdicionalTrim[3] := 0.00 ;
  LarrBCAdicionalTrim[4] := 0.00 ;

  if FcdsApuracao.Locate('CODIGO', LINHA_1, []) then
  begin
    LarrTrim[1] := FcdsApuracao.FieldByName('PERIOD_01').AsFloat ;
    LarrTrim[2] := FcdsApuracao.FieldByName('PERIOD_02').AsFloat ;
    LarrTrim[3] := FcdsApuracao.FieldByName('PERIOD_03').AsFloat ;
    LarrTrim[4] := FcdsApuracao.FieldByName('PERIOD_04').AsFloat ;
  end ;

  ///valor adicional
  LTrimestres := TTipoTrimestres.New.Exerci(AintExercicio).IniAtv(LdtaApartirDe);
  LlstMesesValidos := LTrimestres.MesesValidos;

  for LintCnt := Low(LarrTrim) to High(LarrTrim) do
  begin
    LintMesesTrim := LlstMesesValidos.Items[LintCnt-1] ;
    if LintMesesTrim <> 0 then
    begin
      LfltBCMensal := fFormataFloat(LarrTrim[LintCnt]/LlstMesesValidos.Items[LintCnt-1], 2) ;
      if LfltBCMensal > LfltValorBaseAdicional then
        LarrBCAdicionalTrim[LintCnt] := fFormataFloat( LarrTrim[LintCnt] - (LfltValorBaseAdicional*LintMesesTrim), 2) ;
    end ;
  end ;

  if FcdsApuracao.Locate('CODIGO', LINHA_4, []) then
  begin
    FcdsApuracao.Edit ;
    for LintCnt := Low(LarrBCAdicionalTrim) to High(LarrBCAdicionalTrim) do
      FcdsApuracao.FieldByName('PERIOD_'+fStrZero(inttostr(LintCnt), 2)).AsFloat := fFormataFloat(LarrBCAdicionalTrim[LintCnt]*(LfltAliqAdicional/100), 2) ;
    FcdsApuracao.Post ;
  end ;

end;

{ TTipoLinhasSemEdicaoIrpj }

constructor TTipoLinhasSemEdicaoIrpj.Create;
begin
  FarrSemEdicaoBC[0] := '1' ;
  FarrSemEdicaoBC[1] := '10' ;
  FarrSemEdicaoBC[2] := '26' ;

  FarrSemEdicaoVL[0] := '1' ;
  FarrSemEdicaoVL[1] := '2' ;
  FarrSemEdicaoVL[2] := '3' ;
  FarrSemEdicaoVL[3] := '4' ;
  FarrSemEdicaoVL[4] := '6' ;
  FarrSemEdicaoVL[5] := '15' ;

  FstrLinha := '' ;
  FstrGrupo := '' ;
end;

function TTipoLinhasSemEdicaoIrpj.fGrupo(
  const AstrGrupo: String): ITipoLinhasSemEdicao;
begin
  FstrGrupo := AstrGrupo ;
  Result := Self ;
end;

function TTipoLinhasSemEdicaoIrpj.fLinha(
  const AstrLinha: String): ITipoLinhasSemEdicao;
begin
  FstrLinha := AstrLinha ;
  Result := Self ;
end;

function TTipoLinhasSemEdicaoIrpj.fPodeEditar: Boolean;
begin
  Result := True ;
  if pos(FstrGrupo, BASE_CALCULO) > 0 then
    Result := not MatchText(FstrLinha, FarrSemEdicaoBC)
  else if pos(FstrGrupo, APURACAO) > 0 then
    Result := not MatchText(FstrLinha, FarrSemEdicaoVL) ;
end;

class function TTipoLinhasSemEdicaoIrpj.New: ITipoLinhasSemEdicao;
begin
  Result := Self.Create ;
end;

{ TTipoLinhasSemInformacaoIrpj }

constructor TTipoLinhasSemInformacaoIrpj.Create;
begin
  FarrSemInfoBC[0] := '1' ;

  FarrSemInfoVL[0] := '2' ;
  FarrSemInfoVL[1] := '6' ;

  FstrLinha := '' ;
  FstrGrupo := '' ;
end;

function TTipoLinhasSemInformacaoIrpj.fGrupo(
  const AstrGrupo: String): ITipoLinhasSemInformacao;
begin
  FstrGrupo := AstrGrupo ;
  Result := Self ;
end;

function TTipoLinhasSemInformacaoIrpj.fLinha(
  const AstrLinha: String): ITipoLinhasSemInformacao;
begin
  FstrLinha := AstrLinha ;
  Result := Self ;
end;

function TTipoLinhasSemInformacaoIrpj.fTemInformacao: Boolean;
begin
  Result := True ;
  if pos(FstrGrupo, BASE_CALCULO) > 0 then
    Result := not MatchText(FstrLinha, FarrSemInfoBC)
  else if pos(FstrGrupo, APURACAO) > 0 then
    Result := not MatchText(FstrLinha, FarrSemInfoVL) ;
end;

class function TTipoLinhasSemInformacaoIrpj.New: ITipoLinhasSemInformacao;
begin
  Result := Self.Create ;
end;

end.
