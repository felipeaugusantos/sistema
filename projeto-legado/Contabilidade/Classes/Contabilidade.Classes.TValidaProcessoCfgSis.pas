unit Contabilidade.Classes.TValidaProcessoCfgSis;

interface

uses
  System.Generics.Collections, Contabilidade.Interfaces;

const
  // CFGs cujo valor e definido via checkbox na tela de importacao.
  // Sao ignoradas silenciosamente se presentes no arquivo CSV.
  CFGSIS_GERENCIADAS_PELA_UI: array[0..1] of string = (
    'CONEMP',
    'HISTPL'
  );

  // CFGs que envolvem codigos de cadastro (portador, ccusto), tabelas auxiliares
  // ou senhas e nao podem ser exportadas/importadas via modelo.
  CFGSIS_BLACKLIST: array[0..6] of string = (
    'ADTORD',
    'EVENEC',
    'EVESAI',
    'LYCONT',
    'PICORF',
    'SENLCO',
    'SQCNCO'
  );

type
  TDictPendenciasCfgSis = TDictionary<string, TList<string>>;

  TDadosValidacaoCfgSis = record
    ACodigo: string;
    AValor: string;
  end;

  TValidaProcessoCfgSis = class
  private
    class function fNormalizaChaveComPrefixo(const AstrCodCfg: string): string;
    class function fRetornaArrayMensagens(const ADadosValidacao: TDadosValidacaoCfgSis; ACodigoDuplicado: TList<string> = nil): TList<string>;
    class function fRetornaCodigoDuplicadoBloco(const ADadosValidacao: TList<TDadosValidacaoCfgSis>): TList<string>;
    class procedure pAcumulaMsgVetor(var AMensagemValidacao: string; var AArrMensagens: TList<string>);
    class procedure pMostraMensagens(const AArrMensagens: TDictPendenciasCfgSis; const AprocErros: TErroContabilProc);
    class function fChaveSemPrefixo(const AstrCodCfg: string): string;

  public
    class function fValidaCodigo(var AMensagemValidacao: string; const ACodigo: string): boolean;
    class function fValidaExistenciaCfg(var AMensagemValidacao: string; const ACodigo: string): boolean;
    class function fValidaValor(var AMensagemValidacao: string; const AValor: string): boolean;

    class function fEstaEmBlacklist(const ACodigo: string): boolean;
    class function fEhGerenciadaPelaUI(const ACodigo: string): boolean;
    class function fNormalizaChave(const AstrCodCfg: string): string;

    class function fValidaCfgSisBloco(const ADadosValidacao: TList<TDadosValidacaoCfgSis>; const AprocErros: TErroContabilProc): boolean;
  end;

implementation

uses
  UntFuncoesSimples, SysUtils, Contabilidade.Funcoes,
  Contabilidade.Classes.TValidaContasContabeis;

{ TValidaProcessoCfgSis }

class function TValidaProcessoCfgSis.fChaveSemPrefixo(
  const AstrCodCfg: string): string;
begin
  Result := UpperCase(Trim(AstrCodCfg));
  if Copy(Result, 1, 4) = 'CFG_' then
    Result := Copy(Result, 5, Length(Result) - 4);
end;

class function TValidaProcessoCfgSis.fNormalizaChaveComPrefixo(
  const AstrCodCfg: string): string;
begin
  Result := UpperCase(Trim(AstrCodCfg));
  if Copy(Result, 1, 4) <> 'CFG_' then
    Result := 'CFG_' + Result;
end;

class function TValidaProcessoCfgSis.fNormalizaChave(
  const AstrCodCfg: string): string;
begin
  // Retorna a chave sem prefixo CFG_ em maiusculas
  Result := fChaveSemPrefixo(AstrCodCfg);
end;

class function TValidaProcessoCfgSis.fEstaEmBlacklist(
  const ACodigo: string): boolean;
var
  LstrChave: string;
  LintI: Integer;
begin
  LstrChave := fChaveSemPrefixo(ACodigo);
  Result := False;
  for LintI := Low(CFGSIS_BLACKLIST) to High(CFGSIS_BLACKLIST) do
    if LstrChave = CFGSIS_BLACKLIST[LintI] then
      Exit(True);
end;

class function TValidaProcessoCfgSis.fEhGerenciadaPelaUI(
  const ACodigo: string): boolean;
var
  LstrChave: string;
  LintI: Integer;
begin
  LstrChave := fChaveSemPrefixo(ACodigo);
  Result := False;
  for LintI := Low(CFGSIS_GERENCIADAS_PELA_UI) to High(CFGSIS_GERENCIADAS_PELA_UI) do
    if LstrChave = CFGSIS_GERENCIADAS_PELA_UI[LintI] then
      Exit(True);
end;

class function TValidaProcessoCfgSis.fValidaCodigo(
  var AMensagemValidacao: string; const ACodigo: string): boolean;
begin
  Result := False;

  if fEmptyStr(ACodigo) then
  begin
    AMensagemValidacao := 'O código da configuração deve ser informado.';
    Exit;
  end;

  Result := True;
end;

class function TValidaProcessoCfgSis.fValidaExistenciaCfg(var AMensagemValidacao: string; const ACodigo: string): boolean;
var
  LstrCodSemPrefixo: string;
begin
  Result := False;

  LstrCodSemPrefixo := fChaveSemPrefixo(ACodigo);

  // CFGs da blacklist nao podem ser importadas via modelo contabil
  if fEstaEmBlacklist(LstrCodSemPrefixo) then
  begin
    AMensagemValidacao := 'A configuração [' + fNormalizaChaveComPrefixo(ACodigo) +
      '] não pode ser importada via modelo contabil pois envolve ' +
      'códigos de cadastro, tabelas auxiliares ou senhas.';
    Exit;
  end;

  // CFGs gerenciadas pela UI nao devem estar no arquivo CSV
  if fEhGerenciadaPelaUI(LstrCodSemPrefixo) then
  begin
    AMensagemValidacao := 'A configuração [' + fNormalizaChaveComPrefixo(ACodigo) +
      '] e definida via opção na tela de importação e não deve ' +
      'estar presente no arquivo CSV.';
    Exit;
  end;

  if not fConfiguracaoExiste(LstrCodSemPrefixo) then
  begin
    AMensagemValidacao := 'A configuração [' + fNormalizaChaveComPrefixo(ACodigo) +'] não existe na empresa ' + VS_strCodEmp + '.';
    Exit;
  end;

  Result := True;
end;

class function TValidaProcessoCfgSis.fValidaValor(
  var AMensagemValidacao: string; const AValor: string): boolean;
begin
  // Por enquanto nao ha validacao especifica para o valor
  Result := True;
end;

class function TValidaProcessoCfgSis.fRetornaArrayMensagens(
  const ADadosValidacao: TDadosValidacaoCfgSis;
  ACodigoDuplicado: TList<string>): TList<string>;
var
  strMsg: string;
  LstrChave: string;
begin
  Result := TList<string>.Create;

  if Assigned(ACodigoDuplicado) then
  begin
    LstrChave := UpperCase(Trim(ADadosValidacao.ACodigo));
    if ACodigoDuplicado.IndexOf(LstrChave) <> -1 then
    begin
      strMsg := 'Código [' + ADadosValidacao.ACodigo + '] duplicado na planilha!';
      pAcumulaMsgVetor(strMsg, Result);
    end;
  end;

  strMsg := '';

  fValidaCodigo(strMsg, ADadosValidacao.ACodigo);
  pAcumulaMsgVetor(strMsg, Result);

  fValidaExistenciaCfg(strMsg, ADadosValidacao.ACodigo);
  pAcumulaMsgVetor(strMsg, Result);

  fValidaValor(strMsg, ADadosValidacao.AValor);
  pAcumulaMsgVetor(strMsg, Result);
end;

class function TValidaProcessoCfgSis.fRetornaCodigoDuplicadoBloco(
  const ADadosValidacao: TList<TDadosValidacaoCfgSis>): TList<string>;
var
  LItem: TDadosValidacaoCfgSis;
  lstControle: TList<string>;
  LstrChave: string;
begin
  Result := TList<string>.Create;
  lstControle := TList<string>.Create;
  try
    for LItem in ADadosValidacao do
    begin
      LstrChave := UpperCase(Trim(LItem.ACodigo));
      if lstControle.IndexOf(LstrChave) = -1 then
      begin
        lstControle.Add(LstrChave);
      end
      else
      begin
        if Result.IndexOf(LstrChave) = -1 then
        begin
          Result.Add(LstrChave);
        end;
      end;
    end;
  finally
    FreeAndNil(lstControle);
  end;
end;

class function TValidaProcessoCfgSis.fValidaCfgSisBloco(
  const ADadosValidacao: TList<TDadosValidacaoCfgSis>;
  const AprocErros: TErroContabilProc): boolean;
var
  LDictDadosMostrar: TDictPendenciasCfgSis;
  LLstCodigoDuplicado: TList<string>;
  LLstMensagens: TList<string>;
  LDadoValidacao: TDadosValidacaoCfgSis;
  LArrMensagens: TList<string>;
  LstrChave: string;
begin
  Result := False;
  LDictDadosMostrar := TDictPendenciasCfgSis.Create;
  LLstCodigoDuplicado := fRetornaCodigoDuplicadoBloco(ADadosValidacao);
  try
    for LDadoValidacao in ADadosValidacao do
    begin
      LArrMensagens := fRetornaArrayMensagens(LDadoValidacao, LLstCodigoDuplicado);
      LstrChave := UpperCase(Trim(LDadoValidacao.ACodigo));

      if (LArrMensagens.Count > 0) and (not LDictDadosMostrar.ContainsKey(LstrChave)) then
        LDictDadosMostrar.Add(LstrChave, LArrMensagens)
      else
        FreeAndNil(LArrMensagens);
    end;

    if LDictDadosMostrar.Count > 0 then
    begin
      pMostraMensagens(LDictDadosMostrar, AprocErros);
      Exit;
    end;
  finally
    for LLstMensagens in LDictDadosMostrar.Values do
      LLstMensagens.Free;
    FreeAndNil(LDictDadosMostrar);
    FreeAndNil(LLstCodigoDuplicado);
  end;

  Result := True;
end;

class procedure TValidaProcessoCfgSis.pAcumulaMsgVetor(
  var AMensagemValidacao: string; var AArrMensagens: TList<string>);
begin
  if not fEmptyStr(AMensagemValidacao) then
  begin
    AArrMensagens.Add(AMensagemValidacao);
  end;
  AMensagemValidacao := '';
end;

class procedure TValidaProcessoCfgSis.pMostraMensagens(
  const AArrMensagens: TDictPendenciasCfgSis;
  const AprocErros: TErroContabilProc);
var
  objMensagens: TValidaContaContabil;
  strItem: string;
  regDoc: TContaErro;
  LPair: TPair<string, TList<string>>;
begin
  objMensagens := TValidaContaContabil.Create;
  try
    for LPair in AArrMensagens do
    begin
      for strItem in LPair.Value do
      begin
        regDoc.strChaveDocumento := LPair.Key;
        regDoc.strMotivo := strItem;
        regDoc.strWarning := 'N';
        objMensagens.pAddErro(regDoc, nil);
      end;
    end;

    if Assigned(AprocErros) then
      AprocErros(objMensagens.DataSet);

  finally
    FreeAndNil(objMensagens);
  end;
end;

end.
