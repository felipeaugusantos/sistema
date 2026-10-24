unit untExecutaSPED;

interface

uses
  SysUtils, Uni, IOUtils, untTypesSistema, Windows, Forms;

type
  TExecutarSPED = class
  public
    class var DataInicial: TDatetime;
    class var DataFinal: TDatetime;
    class var PathArquivos: String;
    class var EmpresaLogada: String;
    class var EmpresaFiltro: String;
    class var ProcLoadTinta: TGenericProcedure;
  private
    class procedure AbortarGeracao(AMsg: String);
    class procedure CarregarVariaveis;
    class procedure AtualizarParametros(const ACodRel: String);
    class function ExecutarPreValidacao(const ACodRel: String): Boolean;
  public
    class procedure AddErro(AMsg: String);
    class procedure AddLog(AMsg: String);
    class procedure Executar(const ACodRel: String);
  end;

const
  SPED_FISCAL_PARAM = 'SPED_FISCAL';
  SPED_FISCAL_CODREL = '514203';

  SPED_PIS_COFINS_PARAM = 'SPED_PIS_COFINS';
  SPED_PIS_COFINS_CODREL = '512150';

  SQL_VERIFICACO_SPED_FISCAL_PIS_COFINS = 'VERIFICAÇÃO SPED FISCAL PIS COFINS.SQL';

implementation

uses  untFuncoesSimples, untRelatorio, untConstantes, untAtuVarGlobais;

{ TExecutarSPED }

class procedure TExecutarSPED.CarregarVariaveis;
begin
  AddLog('Definindo empresa logada: ' + Self.EmpresaLogada);
  pSetaEmpresaLogada(Self.EmpresaLogada);
  strLoginUsuarioLogado := LOG_ADM;
  AddLog('Atualizando variáveis globais');
  fAjustaDataSistema;
  pAtuVarGlobais;
  AddLog('Carregando módulos');
  Self.ProcLoadTinta;
end;

class procedure TExecutarSPED.Executar(const ACodRel: String);
begin
   Self.AtualizarParametros(ACodRel);
   Self.CarregarVariaveis;
   If Not Self.ExecutarPreValidacao(ACodRel) Then
     Exit;
   AddLog('Executando "'+fRetNomeRelatorio(ACodRel)+'"');
   TRelatorio.pExecutaRelatorio(ACodRel, [], True, False, '', False, False, 'CADVAL', '', '', False);
end;

class function TExecutarSPED.ExecutarPreValidacao(const ACodRel: String): Boolean;
var
  LScript: String;
  LQuery: TUniQuery;
begin
  If FileExists(Self.PathArquivos + '\PRE_VALIDACAO.csv') Then
    TFile.Delete(Self.PathArquivos + '\PRE_VALIDACAO.csv');

  Result := False;

  If Not FileExists(SQL_VERIFICACO_SPED_FISCAL_PIS_COFINS) Then
    Exit(True);

  AddLog('Executando script pré-validação "'+SQL_VERIFICACO_SPED_FISCAL_PIS_COFINS+'"');

  LScript := '';
  LScript := LScript + 'SET @DTAINI := '+fCurrentDate(Self.DataInicial)+';' + sLineBreak;
  LScript := LScript + 'SET @DTAFIN := '+fCurrentDate(Self.DataFinal)+';' + sLineBreak;
  LScript := LScript + 'SET @EMPRESAS_AUDITADAS := "'+Self.EmpresaFiltro+'";' + sLineBreak;
//  LScript := LScript + 'SET @EMPLOG := "'+Self.EmpresaLogada+'";' + sLineBreak;

  If ACodRel.Equals(SPED_FISCAL_CODREL) Then
    LScript := LScript + 'SET @TIPO_SPED := "F";' + sLineBreak
  Else
    LScript := LScript + 'SET @TIPO_SPED := "P";' + sLineBreak;

  LScript := LScript + TFile.ReadAllText(SQL_VERIFICACO_SPED_FISCAL_PIS_COFINS);

  If LScript.ToUpper.Contains('ALTER') Then
    Raise Exception.Create('Comando ALTER não permitido!');

  If LScript.ToUpper.Contains('DROP') Then
    Raise Exception.Create('Comando DROP não permitido!');

  If LScript.ToUpper.Contains('TRUNCATE') Then
    Raise Exception.Create('Comando TRUNCATE não permitido!');

  If LScript.ToUpper.Contains('DELETE') Then
    Raise Exception.Create('Comando DELETE não permitido!');

  If LScript.ToUpper.Contains('INSERT') Then
    Raise Exception.Create('Comando INSERT não permitido!');

  If LScript.ToUpper.Contains('UPDATE') Then
    Raise Exception.Create('Comando UPDATE não permitido!');

  LQuery := fCriaQuery();
  Try
    LQuery.SQL.Text := LScript;
    LQuery.Open;
    If LQuery.IsEmpty Then
      Exit(True);
    SaveToCSV(LQuery, Self.PathArquivos + '\PRE_VALIDACAO.csv');
  Finally
    LQuery.Free;
  End;
end;

class procedure TExecutarSPED.AbortarGeracao(AMsg: String);
begin
  AddLog(AMsg);
  KillProcess(GetCurrentProcessId);
end;

class procedure TExecutarSPED.AddErro(AMsg: String);
begin
  Self.AbortarGeracao(AMsg);
end;

class procedure TExecutarSPED.AddLog(AMsg: String);
begin
  TFile.AppendAllText(Self.PathArquivos + '\log.txt', DateTimeToStr(fNow()) + ' - ' + AMsg + sLineBreak, TEncoding.ANSI);
end;

class procedure TExecutarSPED.AtualizarParametros(const ACodRel: String);
var
  LDtaIns: TDateTime;
  LHraIns: TDateTime;
  LQryLog: TUniQuery;
  LArrPar: TArray<String>;
  LArrVal: TArray<String>;
  LArrMul: TArray<String>;
begin
  AddLog('Carregando parâmetros');

  If Not fTabelaExiste('CADVAL_LOG', True) Then
    AbortarGeracao('Tabela CADVAL_LOG não existe!');

  Setlength(LArrPar, 0);
  Setlength(LArrVal, 0);
  Setlength(LArrMul, 0);

  LQryLog := fCriaQuery;
  Try
    LQryLog.Close;
    LQryLog.SQL.Clear;
    LQryLog.SQL.Add(' SELECT SQL_NO_CACHE ');
    LQryLog.SQL.Add('   LOG_DTAINS, ');
    LQryLog.SQL.Add('   LOG_HRAINS ');
    LQryLog.SQL.Add(' FROM ');
    LQryLog.SQL.Add('   CADVAL_LOG ');
    LQryLog.SQL.Add(' WHERE LOG_CODREL = :CODREL ');
    LQryLog.SQL.Add(' ORDER BY LOG_DTAINS DESC, ');
    LQryLog.SQL.Add('   LOG_HRAINS DESC ');
    LQryLog.SQL.Add(' LIMIT 1; ');
    LQryLog.ParamByName('CODREL').AsString := ACodRel;
    LQryLog.Open;

    LDtaIns := LQryLog.FieldByName('LOG_DTAINS').AsDatetime;
    LHraIns := LQryLog.FieldByName('LOG_HRAINS').AsDatetime;

    LQryLog.Close;
    LQryLog.SQL.Clear;
    LQryLog.SQL.Add(' SELECT SQL_NO_CACHE ');
    LQryLog.SQL.Add('   * ');
    LQryLog.SQL.Add(' FROM ');
    LQryLog.SQL.Add('   CADVAL_LOG ');
    LQryLog.SQL.Add(' WHERE LOG_CODREL = :CODREL ');
    LQryLog.SQL.Add('   AND LOG_DTAINS = :DTAINS ');
    LQryLog.SQL.Add('   AND LOG_HRAINS = :HRAINS ');
    LQryLog.ParamByName('CODREL').AsString := ACodRel;
    LQryLog.ParamByName('DTAINS').AsDate   := LDtaIns;
    LQryLog.ParamByName('HRAINS').AsTime   := LHraIns;
    LQryLog.Open;

    LQryLog.First;
    While Not LQryLog.Eof Do
    Begin
      pAddDados(LArrPar, LQryLog.FieldByName('LOG_NOMPAR').AsString);
      pAddDados(LArrVal, LQryLog.FieldByName('LOG_ULTVAL').AsString);
      pAddDados(LArrMul, LQryLog.FieldByName('LOG_MULSEL').AsString);
      LQryLog.Next;
    End;

    AddLog('Atualizando parâmetros');
    TRelatorio.pAtualizarParametrosRelatorio(ACodRel, LOG_ADM, LArrPar, LArrVal, LArrMul);
    TRelatorio.pAtualizarParametrosRelatorio(ACodRel, LOG_ADM, ['DTAINI'],    [DateToStr(DataInicial)], ['N']);
    TRelatorio.pAtualizarParametrosRelatorio(ACodRel, LOG_ADM, ['DTAFIN'],    [DateToStr(DataFinal)], ['N']);
    TRelatorio.pAtualizarParametrosRelatorio(ACodRel, LOG_ADM, ['PASTA_REL'], [PathArquivos], ['N']);
    TRelatorio.pAtualizarParametrosRelatorio(ACodRel, LOG_ADM, ['ENVITESMP'], ['Não'], ['N']);

    Self.EmpresaLogada := LQryLog.FieldByName('LOG_EMPLOG').AsString;

    If LQryLog.IsEmpty Then
      AbortarGeracao('Nenhum registro encontrado na tabela CADVAL_LOG com LOG_CODREL = "' + ACodRel + '". Verifique!');

    If Self.EmpresaLogada.IsEmpty Then
      AbortarGeracao('Código da empresa "LOG_EMPLOG" não pode estar vazio na tabela CADVAL_LOG. Verifique!');

    If Not LQryLog.Locate('LOG_NOMPAR', 'CODEMP', []) Then
      Self.EmpresaFiltro := Self.EmpresaLogada
    Else
      Self.EmpresaFiltro := LQryLog.FieldByName('LOG_ULTVAL').AsString;
  Finally
    FreeAndNil(LQryLog);
  End;
end;

initialization
  strLoginUsuarioLogado := LOG_ADM;

end.
