unit Contabilidade.Classes.ApuracaoLucroPresumidoCsll;

interface

uses
  Contabilidade.Interfaces.ApuracaoLucroPresumido, Data.DB, MemDS, DBAccess,
  Uni, Datasnap.DBClient, UniClientDataSet ;

type
  TTipoApuracaoLucroPresumidoCarregaCsll = class(TInterfacedObject, ITipoApuracaoLucroPresumidoCarrega)
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

  TTipoApuracaoLucroPresumidoSalvaCsll = class(TInterfacedObject, ITipoApuracaoLucroPresumidoSalva)
  public
    function fSalva(const AApuracao: IDadosApuracaoLucroPresumido): Boolean;
    class function New: ITipoApuracaoLucroPresumidoSalva;
  end ;

  TTipoApuracaoLucroPresumidoDeleteCsll = class(TInterfacedObject, ITipoApuracaoLucroPresumidoDelete)
  public
    function fDelete(const AstrCodigo: String): Boolean;
    class function New: ITipoApuracaoLucroPresumidoDelete;
  end ;

  TTipoApuracaoLucroPresumidoProcessaCalculosCsll = class(TInterfacedObject, ITipoApuracaoLucroPresumidoProcessaCalculos)
  private
    FobjLinhaSemDados: ITipoLinhasSemInformacao ;
    FcdsBaseCalculo: TUniClientDataSet ;
    FcdsApuracao: TUniClientDataSet ;
    procedure pTotalizarColunasLinha21Bc ;
    procedure pTotalizarColunasLinha6Bc ;
    procedure pTotalizarColunasLinha1VL ;
    procedure pTotalizarColunasLinha2VL ;
    procedure pTotalizarColunasLinha4VL ;
    procedure pTotalizarColunasLinha13VL ;
  public
    function CdsBaseCalculo(var Acds: TUniClientDataSet): ITipoApuracaoLucroPresumidoProcessaCalculos;
    function CdsApuracao(var Acds: TUniClientDataSet): ITipoApuracaoLucroPresumidoProcessaCalculos;
    function fProcessar(const ADados: IDadosApuracaoLucroPresumido): boolean ;
    function fReprocessar(const AstrCodEmp: String; const AintExercicio: Integer): boolean ;
    function fLinhaSemDados(const AobjLinhaSemDados: ITipoLinhasSemInformacao): ITipoApuracaoLucroPresumidoProcessaCalculos;
    class function New: ITipoApuracaoLucroPresumidoProcessaCalculos;
    constructor Create ;
  end ;

  TTipoLinhasSemEdicaoCsll = class(TInterfacedObject, ITipoLinhasSemEdicao)
  private
    FstrGrupo: String ;
    FstrLinha: String ;
    FarrSemEdicaoBC: array[0..2] of string ;
    FarrSemEdicaoVL: array[0..4] of string ;
  public
    function fGrupo(const AstrGrupo: String): ITipoLinhasSemEdicao ;
    function fLinha(const AstrLinha: String): ITipoLinhasSemEdicao ;
    function fPodeEditar: Boolean ;
    class function New: ITipoLinhasSemEdicao;
    constructor Create ;
  end ;

  TTipoLinhasSemInformacaoCsll = class(TInterfacedObject, ITipoLinhasSemInformacao)
  private
    FstrGrupo: String ;
    FstrLinha: String ;
    FarrSemInfoBC: array[0..0] of string ;
    FarrSemInfoVL: array[0..0] of string ;
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
  Contabilidade.Classes.ConfigLucroPresumidoCsll,
  Contabilidade.Interfaces.ConfigLucroPresumido, strUtils,
  Contabilidade.Interfaces.SharedLucroPresumido,
  Contabilidade.Funcoes.LucroPresumido, math ;

{ TTipoApuracaoLucroPresumidoCarregaCsll }

constructor TTipoApuracaoLucroPresumidoCarregaCsll.Create;
begin
  FblnProcessaLanCon := True ;
end;

function TTipoApuracaoLucroPresumidoCarregaCsll.fCarrega(
  const AstrCodEmp: String;
  const AintExercicio: Integer;
  var   AstrMensagem: String): IDadosApuracaoLucroPresumido;
begin
  Result := fCarregaInterno(AstrCodEmp, AintExercicio, AstrMensagem) ;
end;

function TTipoApuracaoLucroPresumidoCarregaCsll.fCarregaInterno(
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

    LobjCfg := TTipoConfigLucroPresumidoCarregaCsll
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

class function TTipoApuracaoLucroPresumidoCarregaCsll.New: ITipoApuracaoLucroPresumidoCarrega;
begin
  Result := Self.Create ;
end;

procedure TTipoApuracaoLucroPresumidoCarregaCsll.pCarregaBd(
  const AstrCodEmp: String; const AintExercicio: Integer; var AqryGeral,
  AqryDetalhe, AqryPeriodos, AqryPlanco: TUniQuery;
  var AcdsLancon: TUniClientDataSet);
begin

  AqryPlanco.SQL.Clear ;
  AqryPlanco.SQL.Add(' SELECT ') ;
  AqryPlanco.SQL.Add('  PRCSLD.CSD_PRNCSL AS CONFIG, ') ;
  AqryPlanco.SQL.Add('  PRCSCN.CSC_CODCON AS CODCON, ') ;
  AqryPlanco.SQL.Add('  PRCSCN.CSC_TPLACO AS TPLACO ') ;
  AqryPlanco.SQL.Add(' FROM PRCSLG ') ;
  AqryPlanco.SQL.Add('     INNER JOIN PRCSLD ON PRCSLG.CSM_CODIGO = PRCSLD.CSD_SEQGER ') ;
  AqryPlanco.SQL.Add('     INNER JOIN PRCSCN ON PRCSLD.CSD_CODIGO = PRCSCN.CSC_SEQGER ') ;
  AqryPlanco.SQL.Add(' WHERE CSM_CODEMP = :CODEMP ') ;
  AqryPlanco.SQL.Add('      AND CSM_EXERCI = :EXERCI ; ') ;
  AqryPlanco.ParamByName('CODEMP').AsString := AstrCodEmp ;
  AqryPlanco.ParamByName('EXERCI').AsInteger := AintExercicio ;
  AqryPlanco.Open ;


  AqryGeral.SQL.Clear ;
  AqryGeral.SQL.Add(' SELECT ') ;
  AqryGeral.SQL.Add('  AUTOINCREM, ') ;
  AqryGeral.SQL.Add('  APG_CODIGO AS CODIGO, ') ;
  AqryGeral.SQL.Add('  APG_CODEMP AS CODEMP, ') ;
  AqryGeral.SQL.Add('  APG_EXERCI AS EXERCI  ') ;
  AqryGeral.SQL.Add('  FROM APCSLG ') ;
  AqryGeral.SQL.Add('    WHERE APG_CODEMP = :CODEMP ') ;
  AqryGeral.SQL.Add('    AND APG_EXERCI = :EXERCI ') ;
  AqryGeral.ParamByName('CODEMP').AsString := AstrCodEmp ;
  AqryGeral.ParamByName('EXERCI').AsInteger := AintExercicio ;
  AqryGeral.Open ;

  AqryDetalhe.SQL.Clear ;
  AqryDetalhe.SQL.Add(' SELECT ') ;
  AqryDetalhe.SQL.Add('  APCSLD.AUTOINCREM, ') ;
  AqryDetalhe.SQL.Add('  APD_CODIGO AS CODIGO, ') ;
  AqryDetalhe.SQL.Add('  APD_SEQGER AS SEQGER, ') ;
  AqryDetalhe.SQL.Add('  APD_CONFIG AS CONFIG, ') ;
  AqryDetalhe.SQL.Add('  PRN_GRUPO_ AS GRUPO_, ') ;
  AqryDetalhe.SQL.Add('  PRN_CODIGO AS CODPAR, ') ;
  AqryDetalhe.SQL.Add('  PRN_DESCRI AS DESCRI, ') ;
  AqryDetalhe.SQL.Add('  PRN_PORCEN AS PORCEN ') ;
  AqryDetalhe.SQL.Add(' FROM APCSLD INNER JOIN PRNCSL ON APD_CONFIG = PRNCSL.AUTOINCREM ') ;
  AqryDetalhe.SQL.Add(' WHERE APD_SEQGER = :SEQGER ; ') ;
  AqryDetalhe.ParamByName('SEQGER').AsString := AqryGeral.FieldByName('CODIGO').AsString ;
  AqryDetalhe.Open ;

  AqryPeriodos.SQL.Clear ;
  AqryPeriodos.SQL.Add(' SELECT ') ;
  AqryPeriodos.SQL.Add('   APCSPE.AUTOINCREM, ') ;
  AqryPeriodos.SQL.Add('   APCSPE.APP_SEQGER AS SEQGER, ') ;
  AqryPeriodos.SQL.Add('   APCSPE.APP_PERIOD AS PERIOD, ') ;
  AqryPeriodos.SQL.Add('   APCSPE.APP_APUVAL AS APUVAL ') ;
  AqryPeriodos.SQL.Add(' FROM APCSPE ') ;
  AqryPeriodos.SQL.Add('     INNER JOIN APCSLD ON APCSPE.APP_SEQGER = APCSLD.APD_CODIGO ') ;
  AqryPeriodos.SQL.Add(' WHERE APCSLD.APD_SEQGER = :SEQGER ') ;
  AqryPeriodos.ParamByName('SEQGER').AsString := AqryGeral.FieldByName('CODIGO').AsString ;
  AqryPeriodos.Open ;

  ///Recupera os valores da LANCON, caso tenha parametro.
  AcdsLancon := fCarregaDadosLancon(AqryPlanco, AstrCodEmp, AintExercicio, FblnProcessaLanCon) ;
end;

function TTipoApuracaoLucroPresumidoCarregaCsll.ProcessaLanCon(
  const AblnValue: Boolean): ITipoApuracaoLucroPresumidoCarrega;
begin
  FblnProcessaLanCon := AblnValue ;
  Result := Self ;
end;

{ TTipoApuracaoLucroPresumidoSalvaCsll }

function TTipoApuracaoLucroPresumidoSalvaCsll.fSalva(
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

    if not TTipoApuracaoLucroPresumidoDeleteCsll.New.fDelete(AApuracao.Geral.Codigo) then
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
      LqryExecGeral.SQL.Add('SELECT * FROM APCSLG WHERE FALSE') ;
      LqryExecGeral.Open ;

      LstrAutoInc := fRetAutoIncrem('APCSLG', VS_strCodEmp) ;
      LintTamanhoCampo := fRetTamCampo('APCSLG') ;
      LintTamanhoCampo := ifThen(LintTamanhoCampo = 0, 8, LintTamanhoCampo) ;

      LstrProCod := fAtualizaProCod('APCSLG', 'APG_CODIGO', '', 1, Nil,
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
      LqryExecDetalhe.SQL.Add('SELECT * FROM APCSLD WHERE FALSE') ;
      LqryExecDetalhe.Open ;

      LqryExecDetalhePeriodo.Close ;
      LqryExecDetalhePeriodo.SQL.Clear ;
      LqryExecDetalhePeriodo.SQL.Add('SELECT * FROM APCSPE WHERE FALSE') ;
      LqryExecDetalhePeriodo.Open ;

      LintTamanhoCampoDetalhe := fRetTamCampo('APCSLD') ;
      LintTamanhoCampoDetalhe := ifThen(LintTamanhoCampoDetalhe = 0, 8, LintTamanhoCampoDetalhe) ;

      for LobjItem in AApuracao.BaseCalculo do
      begin
        LqryExecDetalhe.Append ;
        LqryExecDetalhe.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('APCSLD', VS_strCodEmp) ;
        LqryExecDetalhe.FieldByName('APD_CODIGO').AsString := fAtualizaProCod('APCSLD', 'APD_CODIGO', '', 1, Nil,
          function (const AValue: String) : String
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
          LqryExecDetalhePeriodo.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('APCSPE', VS_strCodEmp) ;
          LqryExecDetalhePeriodo.FieldByName('APP_SEQGER').AsString := LqryExecDetalhe.FieldByName('APD_CODIGO').AsString ;
          LqryExecDetalhePeriodo.FieldByName('APP_PERIOD').AsInteger := LobjItemPeriodo.Period ;
          LqryExecDetalhePeriodo.FieldByName('APP_APUVAL').AsFloat := LobjItemPeriodo.Apuval ;
          LqryExecDetalhePeriodo.Post ;
        end ;
      end ;

      for LobjItem in AApuracao.CalculoImposto do
      begin
        LqryExecDetalhe.Append ;
        LqryExecDetalhe.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('APCSLD', VS_strCodEmp) ;
        LqryExecDetalhe.FieldByName('APD_CODIGO').AsString := fAtualizaProCod('APCSLD', 'APD_CODIGO', '', 1, Nil,
          function (const AValue: String) : String
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
          LqryExecDetalhePeriodo.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('APCSPE', VS_strCodEmp) ;
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

class function TTipoApuracaoLucroPresumidoSalvaCsll.New: ITipoApuracaoLucroPresumidoSalva;
begin
  Result := Self.Create ;
end;

{ TTipoApuracaoLucroPresumidoDeleteCsll }

function TTipoApuracaoLucroPresumidoDeleteCsll.fDelete(
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
      LqryExec.SQL.Add('DELETE FROM APCSLG WHERE APG_CODIGO = :CODIGO ') ;
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

class function TTipoApuracaoLucroPresumidoDeleteCsll.New: ITipoApuracaoLucroPresumidoDelete;
begin
  Result := Self.Create ;
end;

{ TTipoApuracaoLucroPresumidoProcessaCalculosCsll }

constructor TTipoApuracaoLucroPresumidoProcessaCalculosCsll.Create;
begin
  FcdsBaseCalculo := Nil ;
  FcdsApuracao := Nil ;
  FobjLinhaSemDados := Nil ;
end;

function TTipoApuracaoLucroPresumidoProcessaCalculosCsll.CdsApuracao(
  var Acds: TUniClientDataSet): ITipoApuracaoLucroPresumidoProcessaCalculos;
begin
  Result := Self ;
  FcdsApuracao := Acds ;
end;

function TTipoApuracaoLucroPresumidoProcessaCalculosCsll.CdsBaseCalculo(
  var Acds: TUniClientDataSet): ITipoApuracaoLucroPresumidoProcessaCalculos;
begin
  Result := Self ;
  FcdsBaseCalculo := Acds ;
end;

function TTipoApuracaoLucroPresumidoProcessaCalculosCsll.fLinhaSemDados(
  const AobjLinhaSemDados: ITipoLinhasSemInformacao): ITipoApuracaoLucroPresumidoProcessaCalculos;
begin
  Result := Self ;
  FobjLinhaSemDados := AobjLinhaSemDados ;
end;

function TTipoApuracaoLucroPresumidoProcessaCalculosCsll.fProcessar(
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

function TTipoApuracaoLucroPresumidoProcessaCalculosCsll.fReprocessar(const AstrCodEmp: String; const AintExercicio: Integer): boolean;
var
  LevtDataSetBC, LevtDataSetAp: TDataSetNotifyEvent ;
begin
  LevtDataSetBC := FcdsBaseCalculo.AfterPost ;
  LevtDataSetAp := FcdsApuracao.AfterPost ;
  FcdsBaseCalculo.AfterPost := Nil ;
  FcdsApuracao.AfterPost := Nil ;
  try

    // outros calculos
    pTotalizarColunasLinha6Bc ;
    pTotalizarColunasLinha21Bc ;
    pTotalizarColunasLinha1VL ;
    pTotalizarColunasLinha2VL ;
    pTotalizarColunasLinha4VL ;
    pTotalizarColunasLinha13VL ;

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

class function TTipoApuracaoLucroPresumidoProcessaCalculosCsll.New: ITipoApuracaoLucroPresumidoProcessaCalculos;
begin
  Result := Self.Create ;
end;

procedure TTipoApuracaoLucroPresumidoProcessaCalculosCsll.pTotalizarColunasLinha13VL;
const
  TOTALIZAR_VL_CODIGO_21: array[0..7] of string = ('4','6','7','8','9','10','11','12') ;
  LINHA_13= '13' ;
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
    if MatchText(FcdsApuracao.FieldByName('CODIGO').AsString, TOTALIZAR_VL_CODIGO_21) then
    begin
      LfltTrim01 := LfltTrim01 + FcdsApuracao.FieldByName('PERIOD_01').AsFloat ;
      LfltTrim02 := LfltTrim02 + FcdsApuracao.FieldByName('PERIOD_02').AsFloat ;
      LfltTrim03 := LfltTrim03 + FcdsApuracao.FieldByName('PERIOD_03').AsFloat ;
      LfltTrim04 := LfltTrim04 + FcdsApuracao.FieldByName('PERIOD_04').AsFloat ;
    end ;
    FcdsApuracao.Next ;
  end ;

  if FcdsApuracao.Locate('CODIGO', LINHA_13, []) then
  begin
    FcdsApuracao.Edit ;
    FcdsApuracao.FieldByName('PERIOD_01').AsFloat := LfltTrim01 ;
    FcdsApuracao.FieldByName('PERIOD_02').AsFloat := LfltTrim02 ;
    FcdsApuracao.FieldByName('PERIOD_03').AsFloat := LfltTrim03 ;
    FcdsApuracao.FieldByName('PERIOD_04').AsFloat := LfltTrim04 ;
    FcdsApuracao.Post ;
  end ;
end;

procedure TTipoApuracaoLucroPresumidoProcessaCalculosCsll.pTotalizarColunasLinha1VL;
const
  LINHA_21 = '21' ;
  LINHA_1  = '1' ;
var
  LfltTrim01, LfltTrim02, LfltTrim03, LfltTrim04: Double ;
begin
  LfltTrim01 := 0.00 ;
  LfltTrim02 := 0.00 ;
  LfltTrim03 := 0.00 ;
  LfltTrim04 := 0.00 ;

  if FcdsBaseCalculo.Locate('CODIGO', LINHA_21, []) then
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

procedure TTipoApuracaoLucroPresumidoProcessaCalculosCsll.pTotalizarColunasLinha21Bc;
const
  TOTALIZAR_BC_CODIGO_21: array[0..16] of string = ('6','7','8','9','10','11','12','13','14','15','16','16.01','18','19','19.01','19.02','20') ;
  LINHA_21= '21' ;
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
    if MatchText(FcdsBaseCalculo.FieldByName('CODIGO').AsString, TOTALIZAR_BC_CODIGO_21) then
    begin
      LfltTrim01 := LfltTrim01 + FcdsBaseCalculo.FieldByName('PERIOD_01').AsFloat ;
      LfltTrim02 := LfltTrim02 + FcdsBaseCalculo.FieldByName('PERIOD_02').AsFloat ;
      LfltTrim03 := LfltTrim03 + FcdsBaseCalculo.FieldByName('PERIOD_03').AsFloat ;
      LfltTrim04 := LfltTrim04 + FcdsBaseCalculo.FieldByName('PERIOD_04').AsFloat ;
    end ;
    FcdsBaseCalculo.Next ;
  end ;

  if FcdsBaseCalculo.Locate('CODIGO', LINHA_21, []) then
  begin
    FcdsBaseCalculo.Edit ;
    FcdsBaseCalculo.FieldByName('PERIOD_01').AsFloat := LfltTrim01 ;
    FcdsBaseCalculo.FieldByName('PERIOD_02').AsFloat := LfltTrim02 ;
    FcdsBaseCalculo.FieldByName('PERIOD_03').AsFloat := LfltTrim03 ;
    FcdsBaseCalculo.FieldByName('PERIOD_04').AsFloat := LfltTrim04 ;
    FcdsBaseCalculo.Post ;
  end ;
end;

procedure TTipoApuracaoLucroPresumidoProcessaCalculosCsll.pTotalizarColunasLinha2VL;
const
  LINHA_1  = '1' ;
  LINHA_2  = '2' ;
  ALIQUOTA = 9.00 ;
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

  if FcdsApuracao.Locate('CODIGO', LINHA_2, []) then
  begin
    FcdsApuracao.Edit ;
    FcdsApuracao.FieldByName('PERIOD_01').AsFloat := fFormataFloat(LfltTrim01 * (ALIQUOTA/100), 2) ;
    FcdsApuracao.FieldByName('PERIOD_02').AsFloat := fFormataFloat(LfltTrim02 * (ALIQUOTA/100), 2) ;
    FcdsApuracao.FieldByName('PERIOD_03').AsFloat := fFormataFloat(LfltTrim03 * (ALIQUOTA/100), 2) ;
    FcdsApuracao.FieldByName('PERIOD_04').AsFloat := fFormataFloat(LfltTrim04 * (ALIQUOTA/100), 2) ;
    FcdsApuracao.Post ;
  end ;

end;

procedure TTipoApuracaoLucroPresumidoProcessaCalculosCsll.pTotalizarColunasLinha4VL;
const
  LINHA_2  = '2' ;
  LINHA_3  = '3' ;
  LINHA_4  = '4' ;
  ALIQUOTA = 9.00 ;
var
  LfltTrim01, LfltTrim02, LfltTrim03, LfltTrim04: Double ;
begin
  LfltTrim01 := 0.00 ;
  LfltTrim02 := 0.00 ;
  LfltTrim03 := 0.00 ;
  LfltTrim04 := 0.00 ;

  if FcdsApuracao.Locate('CODIGO', LINHA_2, []) then
  begin
    LfltTrim01 := LfltTrim01 + FcdsApuracao.FieldByName('PERIOD_01').AsFloat ;
    LfltTrim02 := LfltTrim02 + FcdsApuracao.FieldByName('PERIOD_02').AsFloat ;
    LfltTrim03 := LfltTrim03 + FcdsApuracao.FieldByName('PERIOD_03').AsFloat ;
    LfltTrim04 := LfltTrim04 + FcdsApuracao.FieldByName('PERIOD_04').AsFloat ;
  end ;

  if FcdsApuracao.Locate('CODIGO', LINHA_3, []) then
  begin
    LfltTrim01 := LfltTrim01 + FcdsApuracao.FieldByName('PERIOD_01').AsFloat ;
    LfltTrim02 := LfltTrim02 + FcdsApuracao.FieldByName('PERIOD_02').AsFloat ;
    LfltTrim03 := LfltTrim03 + FcdsApuracao.FieldByName('PERIOD_03').AsFloat ;
    LfltTrim04 := LfltTrim04 + FcdsApuracao.FieldByName('PERIOD_04').AsFloat ;
  end ;

  if FcdsApuracao.Locate('CODIGO', LINHA_4, []) then
  begin
    FcdsApuracao.Edit ;
    FcdsApuracao.FieldByName('PERIOD_01').AsFloat := fFormataFloat(LfltTrim01, 2) ;
    FcdsApuracao.FieldByName('PERIOD_02').AsFloat := fFormataFloat(LfltTrim02, 2) ;
    FcdsApuracao.FieldByName('PERIOD_03').AsFloat := fFormataFloat(LfltTrim03, 2) ;
    FcdsApuracao.FieldByName('PERIOD_04').AsFloat := fFormataFloat(LfltTrim04, 2) ;
    FcdsApuracao.Post ;
  end ;

end;

procedure TTipoApuracaoLucroPresumidoProcessaCalculosCsll.pTotalizarColunasLinha6Bc;
const
  TOTALIZAR_BC_CODIGO_6: array[0..2] of string = ('2', '4', '5') ;
  LINHA_6= '6' ;
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
    if MatchText(FcdsBaseCalculo.FieldByName('CODIGO').AsString, TOTALIZAR_BC_CODIGO_6) then
    begin
      LfltTrim01 := LfltTrim01 + fFormataFloat(FcdsBaseCalculo.FieldByName('PERIOD_01').AsFloat*(FcdsBaseCalculo.FieldByName('PORCEN').AsFloat/100), 2) ;
      LfltTrim02 := LfltTrim02 + fFormataFloat(FcdsBaseCalculo.FieldByName('PERIOD_02').AsFloat*(FcdsBaseCalculo.FieldByName('PORCEN').AsFloat/100), 2) ;
      LfltTrim03 := LfltTrim03 + fFormataFloat(FcdsBaseCalculo.FieldByName('PERIOD_03').AsFloat*(FcdsBaseCalculo.FieldByName('PORCEN').AsFloat/100), 2) ;
      LfltTrim04 := LfltTrim04 + fFormataFloat(FcdsBaseCalculo.FieldByName('PERIOD_04').AsFloat*(FcdsBaseCalculo.FieldByName('PORCEN').AsFloat/100), 2) ;
    end ;
    FcdsBaseCalculo.Next ;
  end ;

  if FcdsBaseCalculo.Locate('CODIGO', LINHA_6, []) then
  begin
    FcdsBaseCalculo.Edit ;
    FcdsBaseCalculo.FieldByName('PERIOD_01').AsFloat := LfltTrim01 ;
    FcdsBaseCalculo.FieldByName('PERIOD_02').AsFloat := LfltTrim02 ;
    FcdsBaseCalculo.FieldByName('PERIOD_03').AsFloat := LfltTrim03 ;
    FcdsBaseCalculo.FieldByName('PERIOD_04').AsFloat := LfltTrim04 ;
    FcdsBaseCalculo.Post ;
  end ;
end;

{ TTipoLinhasSemEdicaoCsll }

constructor TTipoLinhasSemEdicaoCsll.Create;
begin
  FarrSemEdicaoBC[0] := '1' ;
  FarrSemEdicaoBC[1] := '6' ;
  FarrSemEdicaoBC[2] := '21' ;

  FarrSemEdicaoVL[0] := '1' ;
  FarrSemEdicaoVL[1] := '2' ;
  FarrSemEdicaoVL[2] := '4' ;
  FarrSemEdicaoVL[3] := '5' ;
  FarrSemEdicaoVL[4] := '13' ;

  FstrGrupo := '' ;
  FstrLinha := '' ;
end;

function TTipoLinhasSemEdicaoCsll.fGrupo(
  const AstrGrupo: String): ITipoLinhasSemEdicao;
begin
  FstrGrupo := AstrGrupo ;
  Result := Self ;
end;

function TTipoLinhasSemEdicaoCsll.fLinha(
  const AstrLinha: String): ITipoLinhasSemEdicao;
begin
  FstrLinha := AstrLinha ;
  Result := Self ;
end;

function TTipoLinhasSemEdicaoCsll.fPodeEditar: Boolean;
begin
  Result := True ;
  if pos(FstrGrupo, BASE_CALCULO) > 0 then
    Result := not MatchText(FstrLinha, FarrSemEdicaoBC)
  else if pos(FstrGrupo, APURACAO) > 0 then
    Result := not MatchText(FstrLinha, FarrSemEdicaoVL) ;
end;

class function TTipoLinhasSemEdicaoCsll.New: ITipoLinhasSemEdicao;
begin
  Result := Self.Create ;
end;

{ TTipoLinhasSemInformacaoCsll }

constructor TTipoLinhasSemInformacaoCsll.Create;
begin
  FarrSemInfoBC[0] := '1' ;

  FarrSemInfoVL[0] := '5' ;

  FstrLinha := '' ;
  FstrGrupo := '' ;
end;

function TTipoLinhasSemInformacaoCsll.fGrupo(
  const AstrGrupo: String): ITipoLinhasSemInformacao;
begin
  FstrGrupo := AstrGrupo ;
  Result := Self ;
end;

function TTipoLinhasSemInformacaoCsll.fLinha(
  const AstrLinha: String): ITipoLinhasSemInformacao;
begin
  FstrLinha := AstrLinha ;
  Result := Self ;
end;

function TTipoLinhasSemInformacaoCsll.fTemInformacao: Boolean;
begin
  Result := True ;
  if pos(FstrGrupo, BASE_CALCULO) > 0 then
    Result := not MatchText(FstrLinha, FarrSemInfoBC)
  else if pos(FstrGrupo, APURACAO) > 0 then
    Result := not MatchText(FstrLinha, FarrSemInfoVL) ;
end;

class function TTipoLinhasSemInformacaoCsll.New: ITipoLinhasSemInformacao;
begin
  Result := Self.Create ;
end;

end.
