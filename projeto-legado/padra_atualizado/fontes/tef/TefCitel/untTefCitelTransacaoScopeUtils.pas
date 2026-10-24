unit untTefCitelTransacaoScopeUtils;

interface

uses
  System.SysUtils, System.Generics.Collections, untTefCitelTransacaoInterfaces;

type
  TScopeCredencial = class
  private
    FstrUrl: string;
    FstrUsuario: string;
    FstrSenha: string;
    FstrChave: string;
    FstrToken: string;
    FstrCnpj: string;
    FstrCodigoInterno: string;

    function fDataStr(const AData: TDate): string;
    function fMontarChave: string;
    function fCodigoInterno: string;
  public
    function fUrl: string;
    function fChave: string;
    function fToken: string;
    function fUsuario: string;
    function fSenha: string;
    function fCnpj: string;

    constructor Create;
  end;

  TScopeTipoOperacao = (toSemOperacao = 0, toConfirmacaoSolicitada = 1, toDesfazimentoSolicitado = 2);

  TScopeControleOperacoes = class
  private
    class function fGetTipoOperacao(const ATipo: integer): TScopeTipoOperacao;
  public
    class procedure pRegistrarOperacao(const ATrn: TTransacaoTefDados; AOperacao: TScopeTipoOperacao);
    class function fStatusOperacoesRecentes(const AListPendentes: TTransacaoTefDadosLista): TDictionary<string, TScopeTipoOperacao>;
    class function fStatusControle(const AStrControle: string): TScopeTipoOperacao;
    class function fTransacaoComTravaAtiva(const AStrControle: string; var AstrMensagem: String): Boolean ;
  end;

implementation

uses
  System.StrUtils, System.DateUtils, System.MaskUtils, System.Hash,
  Uni,untFuncoesSimples, System.Classes;

{ TScopeCredencial }

constructor TScopeCredencial.Create;
begin
  FstrUrl := '';
  FstrUsuario := '';
  FstrSenha := '';
  FstrChave := '';
  FstrToken := '';
  FstrCnpj := '';
  FstrCodigoInterno := '';
end;

function TScopeCredencial.fChave: string;
begin
  if FstrChave.IsEmpty then
    FstrChave := fMontarChave;

  Result := FstrChave;
end;

function TScopeCredencial.fCnpj: string;
begin
  if FstrCnpj.IsEmpty then
  begin
    FstrCnpj := fCampoTabela('EMP_C_G_C_', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp]);
    FstrCnpj := Trim(ReplaceStr(ReplaceStr(ReplaceStr(FstrCnpj, '.', ''), '/', ''), '-', '')) ;
  end;

  Result := FstrCnpj;
end;

function TScopeCredencial.fCodigoInterno: string;
begin
  if FstrCodigoInterno.IsEmpty then
    FstrCodigoInterno := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_CS_COD']) ;

  Result := FstrCodigoInterno;
end;

function TScopeCredencial.fDataStr(const AData: TDate): string;
var
  LintAno, LintMes, LintDia: Integer ;
begin
  LintAno := YearOf(AData) ;
  LintMes := MonthOf(AData) ;
  LintDia := DayOf(AData) ;

  Result := format('%s/%s/%s', [IntToStr(LintAno), fStrZero(IntToStr(LintMes), 2), fStrZero(IntToStr(LintDia), 2)]) ;
end;

function TScopeCredencial.fMontarChave: string;
var
  LstrData, LstrCnpj, LstrCodigo: string;
begin
  LstrCnpj := fCnpj;
  LstrData := fDataStr(fNow);
  LstrCodigo := fCodigoInterno;

  Result := THashSHA2.GetHashString(format('%s:%s:%s', [LstrCnpj, LstrData, LstrCodigo]));
end;

function TScopeCredencial.fSenha: string;
begin
  if FstrSenha.IsEmpty then
    FstrSenha := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_CS_PWD']) ;

  Result := FstrSenha;
end;

function TScopeCredencial.fToken: string;
begin
  if FstrToken.IsEmpty then
    FstrToken := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_CS_TOK']) ;

  Result := FstrToken;
end;

function TScopeCredencial.fUrl: string;
begin
  if FstrUrl.IsEmpty then
    FstrUrl := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_CS_URL']) ;

  Result := FstrUrl;
end;

function TScopeCredencial.fUsuario: string;
begin
  if FstrUsuario.IsEmpty then
    FstrUsuario := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_CS_USR']) ;

  Result := FstrUsuario;
end;

{ TScopeControleOperacoes }

class function TScopeControleOperacoes.fGetTipoOperacao(
  const ATipo: integer): TScopeTipoOperacao;
begin
  try
    if (ATipo >= 0) and (ATipo <= 2) then
      Result := TScopeTipoOperacao(ATipo)
    else
      Result := toSemOperacao;
  except
    Result := toSemOperacao;
  end;
end;

class function TScopeControleOperacoes.fStatusControle(const AStrControle: string): TScopeTipoOperacao;
var
  LQry: TUniQuery;
begin
  Result := toSemOperacao;

  LQry := fCriaQuery();
  try
    LQry.SQL.Text := 'SELECT CSP_TIPOPE FROM CSPEND WHERE CSP_CONTRO = :CONTRO';
    LQry.ParamByName('CONTRO').AsString := AStrControle;
    LQry.Open;

    if LQry.RecordCount > 0 then
      Result := Self.fGetTipoOperacao(LQry.FieldByName('CSP_TIPOPE').AsInteger);
  finally
    FreeAndNil(LQry);
  end;
end;

class function TScopeControleOperacoes.fStatusOperacoesRecentes(
  const AListPendentes: TTransacaoTefDadosLista): TDictionary<string, TScopeTipoOperacao>;
var
  LQry: TUniQuery;
  LSQL, LKey, LCodRede, LControle, LDtTransacao: string;
  LWhere: TStringList;
  LItem: TTransacaoTefDados;
  LTipoOperacao: TScopeTipoOperacao;
  LTempList: TDictionary<string, TScopeTipoOperacao>;
begin
  Result := nil;

  if not Assigned(AListPendentes) then
    Exit;

  LSQL := EmptyStr;
  LWhere := TStringList.Create;
  LWhere.Delimiter := ',';
  try
    for LItem in AListPendentes do
    begin
      if not Trim(LItem.Contro).IsEmpty then
        LWhere.Add(LItem.Contro);
    end;

    if LWhere.Count > 0 then
      LSQL := ' SELECT AUTOINCREM, CSP_CONTRO, CSP_TIPOPE, CSP_CODRED, CSP_DTATRA ' +
              ' FROM CSPEND ' +
              ' WHERE CSP_CONTRO IN (' + QuotedStr(LWhere.CommaText) + ') ' +
              ' ORDER BY CSP_DTAHRA DESC ';

  finally
    FreeAndNil(LWhere);
  end;

  if LSQL = EmptyStr then
    Exit;

  Result := TDictionary<string, TScopeTipoOperacao>.Create;
  try
    LQry := fCriaQuery();
    try
      LQry.SQL.Text := LSQL;
      LQry.Open;

      if LQry.RecordCount = 0 then
        Exit;

      LTempList := TDictionary<string, TScopeTipoOperacao>.Create;
      try
        LQry.First;
        while not LQry.Eof do
        begin
          LControle := LQry.FieldByName('CSP_CONTRO').AsString;
          LCodRede := LQry.FieldByName('CSP_CODRED').AsString;
          LDtTransacao := LQry.FieldByName('CSP_DTATRA').AsString;

          if Trim(LCodRede).IsEmpty or Trim(LDtTransacao).IsEmpty then
            LKey := LControle + ':' + LQry.FieldByName('AUTOINCREM').AsString
          else
            LKey := LControle + ':' +
                    LCodRede  + '-' +
                    LDtTransacao.Replace('/', '').Replace('-', ''); //ex: '08206912025:00005-20102025'

          if not LTempList.ContainsKey(LKey) then
          begin
            LTipoOperacao := fGetTipoOperacao(LQry.FieldByName('CSP_TIPOPE').AsInteger);
            LTempList.Add(LKey, LTipoOperacao);
          end;
          LQry.Next;
        end;

        for LKey in LTempList.Keys do
        begin
          LControle := copy(LKey, 1, Pos(':', LKey)-1);
          LTipoOperacao := LTempList.Items[LKey];
          Result.Add(LControle, LTipoOperacao);
        end;

      finally
        FreeAndNil(LTempList);
      end;
    finally
      FreeAndNil(LQry);
    end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

class function TScopeControleOperacoes.fTransacaoComTravaAtiva(
  const AStrControle: string; var AstrMensagem: String): Boolean;
var
  LQry: TUniQuery ;
  LSQL: string;
  LOperador, LEmpresa, LUsuario: string;
begin

  AstrMensagem := '' ;

  LSQL := 'SELECT '             + sLineBreak +
          'LCKATC.LCK_NOMUSU  ' + sLineBreak +
          ',CADEMP.EMP_CODEMP ' + sLineBreak +
          ',CADEMP.EMP_NOMFAN ' + sLineBreak +
          ',LCKATC.LCK_CODOPE ' + sLineBreak +
          ',CADOPE.OPE_NOMOPE ' + sLineBreak +
          ',TEFTRA.TFT_CONTRO ' + sLineBreak +
          'FROM LCKATC '        + sLineBreak +
          'INNER JOIN TEFTRA ON (LCKATC.LCK_MACADD = TEFTRA.TFT_MACADD '  + sLineBreak +
          '        AND LCKATC.LCK_NOMMAQ = TEFTRA.TFT_NOMMAQ '            + sLineBreak +
          '        AND LCKATC.LCK_NOMUSU = TEFTRA.TFT_NOMUSU '            + sLineBreak +
          '        AND LCKATC.LCK_DTALCK = TEFTRA.TFT_DTATRA '            + sLineBreak +
          '        AND LCKATC.LCK_CHAACE LIKE "%TEF_%"  '                 + sLineBreak +
          '        AND LCKATC.LCK_DTALCK = CURRENT_DATE)'                 + sLineBreak +
          'INNER JOIN CADOPE ON (CADOPE.OPE_CODOPE = LCKATC.LCK_CODOPE) ' + sLineBreak +
          'INNER JOIN CADEMP ON (CADEMP.EMP_CODEMP = CADOPE.OPE_CODEMP) ' + sLineBreak +
          'WHERE '                                                        + sLineBreak +
          'TRIM(TEFTRA.TFT_CONTRO)<> "" '                                 + sLineBreak +
          'AND TEFTRA.TFT_CONTRO = :CONTRO '                              + sLineBreak +
          'AND LCKATC.LCK_HRALCK < TEFTRA.TFT_HRATRA';

  LQry := fCriaQuery();
  try
    LQry.SQL.Text := LSQL;
    LQry.ParamByName('CONTRO').AsString := AStrControle;
    LQry.Open;

    Result := LQry.RecordCount > 0;
    if not Result then Exit;

    LOperador := LQry.fieldbyname('LCK_CODOPE').AsString + ' - ' + LQry.fieldbyname('OPE_NOMOPE').AsString;
    LEmpresa  := LQry.fieldbyname('EMP_CODEMP').AsString + ' - ' + LQry.fieldbyname('EMP_NOMFAN').AsString;
    LUsuario  := LQry.fieldbyname('LCK_NOMUSU').AsString;

    AstrMensagem := 'Transação em andamento ou não concluída, travada com:' + SlineBreak +
                    'Operador: '  + LOperador + sLineBreak +
                    'Empresa: '   + LEmpresa  + sLineBreak +
                    'Usuário Windows: ' + LUsuario + sLineBreak +
                    'Para destravar, acesse: Útil > Ambiente de Rede > Relatório de Travas';
  finally
    FreeAndNil(LQry) ;
  end ;
end;

class procedure TScopeControleOperacoes.pRegistrarOperacao(
  const ATrn: TTransacaoTefDados; AOperacao: TScopeTipoOperacao);
var
  LQry: TUniQuery;
  LSQL: string;
begin
  LSQL := 'INSERT INTO CSPEND ( ' + sLineBreak +
          '  CSP_CONTRO,        ' + sLineBreak +
          '  CSP_TIPOPE,        ' + sLineBreak +
          '  CSP_DTAHRA,        ' + sLineBreak +
          '  CSP_CODOPE,        ' + sLineBreak +
          '  CSP_CODEMP,        ' + sLineBreak +
          '  CSP_CODRED,        ' + sLineBreak + // codigo da rede
          '  CSP_DTATRA         ' + sLineBreak + // data/hora transacao
          ') VALUES (           ' + sLineBreak +
          '  :CONTRO,           ' + sLineBreak +
          '  :TIPOPE,           ' + sLineBreak +
          '  :DTAHRA,           ' + sLineBreak +
          '  :CODOPE,           ' + sLineBreak +
          '  :CODEMP,           ' + sLineBreak +
          '  :CODRED,           ' + sLineBreak +
          '  :DTATRA            ' + sLineBreak +
          ')';

  LQry := fCriaQuery();
  try
    LQry.SQL.Text := LSQL;
    LQry.ParamByName('CONTRO').AsString := ATrn.Contro;
    LQry.ParamByName('CODRED').AsString := ATrn.NomRed;
    LQry.ParamByName('DTATRA').AsDateTime := ATrn.DtaHra;
    LQry.ParamByName('DTAHRA').AsDateTime := fNow();
    LQry.ParamByName('TIPOPE').AsInteger := Ord(AOperacao);
    LQry.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    LQry.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQry.ExecSQL;
  finally
    FreeAndNil(LQry);
  end;
end;

end.
