unit Contabilidade.Classes.TImportacaoDadosContabeisCfgSis;

interface

uses
  Uni, cxProgressBar, System.Generics.Collections,
  Contabilidade.Classes.TImportacaoDadosContabeis, Contabilidade.Interfaces,
  Contabilidade.Classes.TValidaProcessoCfgSis, Contabilidade.Classes.CfgContabil;

type
  TImportacaoDadosContabeisCfgSis = Class(TImportacaoDadosContabeisBase)
  private
    FarrCfgSis: array of TCfgSisInfo;
    FdctConfiguracoes: TDictionary<string, string>;
    function fNormalizaChave(const AstrCodCfg: string): string;
    function fConverteEstruturaParaValidacao(const AArr: array of TCfgSisInfo): TList<TDadosValidacaoCfgSis>;
    function fGetSqlUpdate: string;
    function fGetSqlSelectValorAnterior: string;
    function fGetSqlInsertLog: string;
  protected
    procedure pCarregaInfoColunas; override;
    function fGetSqlInsert: string; override;
    function fGetNomeTabela: string; override;
  public
    function fCarregaDadosPlanilha(const AprocErros: TErroContabilProc): boolean; override;
    function fPersisteDados: boolean; override;
    function fGetDictConfiguracoes: TDictionary<string, string>;

    constructor Create(pgbProgresso: TcxProgressBar;
      AFonte: IImportacaoDadosContabeisFonte; blnIgnorarErrosImportacao: boolean;
      ACfgContabil: ICfgContabil = nil);
    destructor Destroy; override;
  End;

implementation

uses
  System.SysUtils, Vcl.Forms, untFuncoesSimples, Data.DB;

{ TImportacaoDadosContabeisCfgSis }

function TImportacaoDadosContabeisCfgSis.fGetNomeTabela: string;
begin
  Result := 'CFGSIS';
end;

constructor TImportacaoDadosContabeisCfgSis.Create(pgbProgresso: TcxProgressBar;
  AFonte: IImportacaoDadosContabeisFonte; blnIgnorarErrosImportacao: boolean;
  ACfgContabil: ICfgContabil);
begin
  FdctConfiguracoes := TDictionary<string, string>.Create;
  inherited Create(pgbProgresso, AFonte, blnIgnorarErrosImportacao, ACfgContabil);
end;

destructor TImportacaoDadosContabeisCfgSis.Destroy;
begin
  FreeAndNil(FdctConfiguracoes);
  inherited;
end;

function TImportacaoDadosContabeisCfgSis.fNormalizaChave(const AstrCodCfg: string): string;
begin
  Result := UpperCase(Trim(AstrCodCfg));
  if Copy(Result, 1, 4) = 'CFG_' then
    Result := Copy(Result, 5, Length(Result) - 4);
end;

function TImportacaoDadosContabeisCfgSis.fConverteEstruturaParaValidacao(
  const AArr: array of TCfgSisInfo): TList<TDadosValidacaoCfgSis>;
var
  intCnt: Integer;
  regItem: TDadosValidacaoCfgSis;
begin
  Result := TList<TDadosValidacaoCfgSis>.Create;
  for intCnt := Low(AArr) to High(AArr) do
  begin
    if TValidaProcessoCfgSis.fEhGerenciadaPelaUI(AArr[intCnt].strSIS_CODCFG) then
      Continue;

    FillChar(regItem, SizeOf(regItem), #0);
    regItem.ACodigo := AArr[intCnt].strSIS_CODCFG;
    regItem.AValor := AArr[intCnt].strSIS_VALCFG;
    Result.Add(regItem);
  end;
end;

procedure TImportacaoDadosContabeisCfgSis.pCarregaInfoColunas;
begin
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CODIGO*', True));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('VALOR*', False));
end;

function TImportacaoDadosContabeisCfgSis.fGetSqlInsert: string;
begin
  // Nao utilizado - a persistencia usa UPDATE
  Result := '';
end;

function TImportacaoDadosContabeisCfgSis.fGetSqlUpdate: string;
begin
  Result := 'UPDATE CFGSIS SET SIS_VALCFG = :VALOR ' +
            'WHERE SIS_CODEMP = :CODEMP AND SIS_CODCFG = :CODCFG';
end;

function TImportacaoDadosContabeisCfgSis.fGetSqlSelectValorAnterior: string;
begin
  Result := 'SELECT SIS_VALCFG FROM CFGSIS ' +
            'WHERE SIS_CODEMP = :CODEMP AND SIS_CODCFG = :CODCFG';
end;

function TImportacaoDadosContabeisCfgSis.fGetSqlInsertLog: string;
begin
  Result := 'INSERT INTO LOGCFG (' ;
  Result := Result + 'AUTOINCREM, ' ;
  Result := Result + 'LOG_DTAALT, ' ;
  Result := Result + 'LOG_HORALT, ' ;
  Result := Result + 'LOG_CODOPE, ' ;
  Result := Result + 'LOG_CODCFG, ' ;
  Result := Result + 'LOG_VALANT, ' ;
  Result := Result + 'LOG_VALATU, ' ;
  Result := Result + 'LOG_CODEMP, ' ;
  Result := Result + 'LOG_EMPCFG'  ;
  Result := Result + ') VALUES (' ;
  Result := Result + ':AUTOINCREM, ' ;
  Result := Result + ':DTAALT, ' ;
  Result := Result + ':HORALT, ' ;
  Result := Result + ':CODOPE, ' ;
  Result := Result + ':CODCFG, ' ;
  Result := Result + ':VALANT, ' ;
  Result := Result + ':VALATU, ' ;
  Result := Result + ':CODEMP, ' ;
  Result := Result + ':EMPCFG'  ;
  Result := Result + ')' ;
end;

function TImportacaoDadosContabeisCfgSis.fCarregaDadosPlanilha(
  const AprocErros: TErroContabilProc): boolean;
var
  intConLin: integer;
  intUltimo: integer;
  intQtdLinhas: Integer;
  LstrCodCfg: string;
  LstrChave: string;
  LDadosValidacao: TList<TDadosValidacaoCfgSis>;
begin
  pSetaTextoProgresso(pgbProgresso, 'Lendo Planilha: Configurações');
  Result := False;

  if not fValidaCabecalho then
    Exit;

  if not fQtdLinhas(intQtdLinhas) then
    Exit;

  pgbProgresso.Properties.Max := intQtdLinhas - 1;

  SetLength(FarrCfgSis, 0);
  FdctConfiguracoes.Clear;

  for intConLin := fIndicePrimeiroRegistro to intQtdLinhas - 1 do
  begin
    pgbProgresso.Position := intConLin;
    Application.ProcessMessages;

    SetLength(FarrCfgSis, Length(FarrCfgSis) + 1);
    intUltimo := High(FarrCfgSis);

    LstrCodCfg := fGetDadosCelula(0, intConLin, tdcStr);

    // CFGs da blacklist: pular (o validador as rejeita com mensagem)
    if TValidaProcessoCfgSis.fEstaEmBlacklist(LstrCodCfg) then
    begin
      SetLength(FarrCfgSis, Length(FarrCfgSis) - 1);
      Continue;
    end;

    FarrCfgSis[intUltimo].strSIS_CODCFG := LstrCodCfg;
    FarrCfgSis[intUltimo].strSIS_VALCFG := fGetDadosCelula(1, intConLin, tdcStr, False);

    // Popula o dicionario com a chave normalizada (sem prefixo CFG_)
    LstrChave := fNormalizaChave(LstrCodCfg);
    if not FdctConfiguracoes.ContainsKey(LstrChave) then
      FdctConfiguracoes.Add(LstrChave, FarrCfgSis[intUltimo].strSIS_VALCFG);
  end;

  if not FblnIgnorarErrosImportacao then
  begin
    if FMensagemErroDadosContabeis.fTemMensagemErro then
    begin
      if not FblnImportacaoOrquestrada then
        FMensagemErroDadosContabeis.pMostraMensagemErro(True);
      Exit;
    end;
  end;

  ///valida as informacoes carregadas no array
  LDadosValidacao := fConverteEstruturaParaValidacao(FarrCfgSis);
  try
    if not TValidaProcessoCfgSis.fValidaCfgSisBloco(LDadosValidacao, AprocErros) then
    begin
      Exit;
    end;
  finally
    FreeAndNil(LDadosValidacao);
  end;

  Result := True;
end;

function TImportacaoDadosContabeisCfgSis.fPersisteDados: boolean;
var
  intCnt: integer;
  strMensagemErro: string;
  blnAbortado: boolean;
  strCodCfgCompleto: string;
  strValorAnterior: string;
  strAutoInc: string;
  LdtaNow: TDateTime;
  qrySelect: TUniQuery;
  qryLog: TUniQuery;
begin
  Result := False;
  blnAbortado := False;
  pSetaTextoProgresso(pgbProgresso, 'Gravando Registros: Configurações');
  pgbProgresso.Properties.Max := Length(FarrCfgSis);

  pStartTransactionImportacao;

  qrySelect := nil;
  qryLog := nil;
  try
    try
      qrySelect := fCriaQuery(nil);
      qryLog := fCriaQuery(nil);

      FqryExec.Close;
      FqryExec.SQL.Clear;
      FqryExec.SQL.Text := fGetSqlUpdate;

      qrySelect.SQL.Text := fGetSqlSelectValorAnterior;
      qryLog.SQL.Text := fGetSqlInsertLog;

      for intCnt := Low(FarrCfgSis) to High(FarrCfgSis) do
      begin
        try
          pgbProgresso.Position := intCnt + 1;
          Application.ProcessMessages;

          if FMensagemErroDadosContabeis.fTemLinhaComErro(intCnt) then
            Continue;

          // A coluna SIS_CODCFG na tabela guarda com prefixo CFG_
          // Se o valor ja veio com CFG_, mantem; senao, adiciona
          strCodCfgCompleto := UpperCase(Trim(FarrCfgSis[intCnt].strSIS_CODCFG));
          if Copy(strCodCfgCompleto, 1, 4) <> 'CFG_' then
            strCodCfgCompleto := 'CFG_' + strCodCfgCompleto;

          // Busca o valor anterior para o log
          // Busca o valor anterior para o log
          // A validacao de existencia da cfg e feita pela classe de validacao
          qrySelect.Close;
          qrySelect.ParamByName('CODEMP').AsString := VS_strCodEmp;
          qrySelect.ParamByName('CODCFG').AsString := strCodCfgCompleto;
          qrySelect.Open;

          if qrySelect.IsEmpty then
            strValorAnterior := ''
          else
            strValorAnterior := qrySelect.FieldByName('SIS_VALCFG').AsString;

          // Executa o UPDATE
          FqryExec.ParamByName('VALOR').AsString := FarrCfgSis[intCnt].strSIS_VALCFG;
          FqryExec.ParamByName('CODEMP').AsString := VS_strCodEmp;
          FqryExec.ParamByName('CODCFG').AsString := strCodCfgCompleto;
          FqryExec.ExecSQL;

          // Grava log na LOGCFG
          LdtaNow := fNow;
          strAutoInc := fRetAutoIncrem('LOGCFG', VS_strCodEmp);

          qryLog.ParamByName('AUTOINCREM').AsString := strAutoInc;
          qryLog.ParamByName('DTAALT').AsDateTime := LdtaNow;
          qryLog.ParamByName('HORALT').AsDateTime := LdtaNow;
          qryLog.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
          qryLog.ParamByName('CODCFG').AsString := strCodCfgCompleto;
          qryLog.ParamByName('VALANT').AsString := strValorAnterior;
          qryLog.ParamByName('VALATU').AsString := FarrCfgSis[intCnt].strSIS_VALCFG;
          qryLog.ParamByName('CODEMP').AsString := VS_strCodEmp;
          qryLog.ParamByName('EMPCFG').AsString := VS_strCodEmp;
          qryLog.ExecSQL;

        except
          on E1: Exception do
          begin
            strMensagemErro := 'Problemas ao importar a linha ' +
              IntToStr(intCnt + 2) + ', erro: ' + E1.Message;
            if not FblnIgnorarErrosImportacao then
            begin
              blnAbortado := True;
              raise Exception.Create(strMensagemErro);
            end
            else
            begin
              blnAbortado := False;
              FMensagemErroDadosContabeis.pRegistraMensagemErro(strMensagemErro);
            end;
          end;
        end;
      end;

      pCommitImportacao;

    except
      on E2: Exception do
      begin
        pRollbackImportacao;
        FMensagemErroDadosContabeis.pRegistraMensagemErro(E2.Message);
        if FblnImportacaoOrquestrada then
          Raise;
      end;
    end;
  finally
    FreeAndNil(qrySelect);
    FreeAndNil(qryLog);
  end;

  if FMensagemErroDadosContabeis.fTemMensagemErro then
  begin
    FMensagemErroDadosContabeis.pMostraMensagemErro(blnAbortado, FblnImportacaoOrquestrada);
    Exit;
  end;

  pMensagemSucesso;

  Result := True;
end;

function TImportacaoDadosContabeisCfgSis.fGetDictConfiguracoes: TDictionary<string, string>;
begin
  Result := FdctConfiguracoes;
end;

end.
