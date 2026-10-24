unit Contabilidade.Classes.TValidaProcessoLancamentoContabil;

interface

uses System.Generics.Collections, UniClientDataSet,
     Contabilidade.Classes.FechamentoDiaMes ;

type
  TDictPendenciasLanCon = TDictionary<String, TList<String>> ;

  TDadosValidacaoLanCon = record
    dtaLan: TDateTime ;
    strCodEmp: String ;
    fltValor: Double ;
    strContaCredito: String ;
    strContaDebito: String ;
    strCentroCustoCredito: String ;
    strCentroCustoDebito: String ;
    strComplemento: String ;
    strHistoricoPadrao: String ;
    blnValidarClienteFornecedorDebito: Boolean;
    strTipoFCDebito: String ;
    strClienteFornecedorDebito: String ;
    blnValidarClienteFornecedorCredito: Boolean;
    strTipoFCCredito: String ;
    strClienteFornecedorCredito: String ;
    strIncDoc: String ;
    strLinha: String ;
  end;

  TDadosValidacaoSomaCreditoDebito = record
    fltCredito: Double ;
    fltDebito: Double ;
    strLinha: String ;
  end ;

  TValidaProcessoLancamentoContabil = class
  private
    class function fLancouContasIguais(const AstrContaCredito, AstrContaDebito: string): boolean ;
    class function fValidarCentroCusto(const AstrConta, AstrCentroCusto: string; const AblnValidar: boolean): boolean ;
    class function fObrigatorioCentroCusto(const AstrConta, AstrCodEmp: string): boolean ;

    class function fRetornaArrayMensagens(const ADadosValidacao: TDadosValidacaoLanCon; AcdsVigenciaPlanco: TUniClientDataset; const AblnValidarIniCon: Boolean; var AVerifFec: TVerificaFechamentoDiaMes):TList<string> ;
    class procedure pAcumulaMsgVetor(var AstrMensagemValidacao: string; var AarrMensagens: TList<string>) ;
    class procedure pMostraMensagens(const AArrMensagens: TDictPendenciasLanCon) ;

    class function fValidaInicioContabilidade(var AstrMensagemValidacao: string; const AdtaLan: TDate; const AstrCodEmp: string): boolean ;
    class function fValidaPeriodoFechado(var AstrMensagemValidacao: string; const AdtaIni, AdtaFin: TDateTime; const AstrCodEmp: string): boolean ;
    class function fValidaSubconta(var AstrMensagemValidacao: string; const AblnValidarClienteFornecedor: Boolean; const AstrTipoFC, AstrClienteFornecedor, AstrDebitoCredito: String): boolean ;
    class function fValidaValor(var AstrMensagemValidacao: string; const AfltValor: double): boolean ;
    class function fValidaLancouContasIguais(var AstrMensagemValidacao: string; const AstrContaCredito, AstrContaDebito: string): boolean ;
    class function fValidaSemContas(var AstrMensagemValidacao: string; const AstrContaCredito, AstrContaDebito: string): boolean ;
    class function fValidaCentroCustoDebito(var AstrMensagemValidacao: string; const AstrConta, AstrCentroCusto, AstrCodEmp: string): boolean ;
    class function fValidaCentroCustoCredito(var AstrMensagemValidacao: string; const AstrConta, AstrCentroCusto, AstrCodEmp: string): boolean ;
    class function fValidaHistorico(var AstrMensagemValidacao: string; const AStrComplemento, AstrHistoricoPadrao: string): boolean ;
    class function fValidaPlancoVigencia(var AstrMensagemValidacao: string; AcdsPlancoVigencia: TUniClientDataSet; const AdtaLan: TDate; const AstrConta: String; const AstrCodEmp: string): boolean ;
    class function fValidaContaContabilCadastrada(var AstrMensagemValidacao: string; const AstrConta, AstrCodEmp: string):boolean ;
    class function fValidaCentroCustoCadastrada(var AstrMensagemValidacao: string; const AstrCentroCusto: string):boolean ;
    class function fValidaHistoricoPadraoCadastrada(var AstrMensagemValidacao: string; const AintHisPad: Integer; const AstrCodEmp: string):boolean ;
    class function fValidaEmpresaCadastrada(var AstrMensagemValidacao: string; const AstrCodEmp: string):boolean ;
    class function fCliForCadastrado(const AstrTipoFC, AstrClienteFornecedor: String; var AstrMensagemValidacao: string): Boolean ;
    class function fValidaFechamentoDiaMes(var AstrMensagemValidacao: string; var AVerifFec: TVerificaFechamentoDiaMes; const AdtaLan: TDate; const AstrCodEmp: string): boolean;
    class procedure pValidaSomaCreditoDebito(const ADadosValidacao: TList<TDadosValidacaoLanCon>; var AdictMensagens: TDictPendenciasLanCon) ;
  public
    class function fValida(const ADadosValidacao: TDadosValidacaoLanCon; AcdsVigenciaPlanco: TUniClientDataset; const AblnValidarIniCon: Boolean = False): boolean;
    class function fValidaBloco(const ADadosValidacao: TList<TDadosValidacaoLanCon>; AcdsVigenciaPlanco: TUniClientDataset): boolean;
  end;

implementation

uses Contabilidade.Funcoes, untFuncoesSimples, SysUtils, Uni, DB,
    Contabilidade.Classes.TValidaContasContabeis, Contabilidade.Interfaces,
    Contabilidade.Model.Contabilizaveis, Contabilidade.View.ErrosContabeis,
    strUtils ;

{ TValidaProcessoLancamentoContabil }

class function TValidaProcessoLancamentoContabil.fCliForCadastrado(const AstrTipoFC, AstrClienteFornecedor: String; var AstrMensagemValidacao: string): Boolean;
var
  LstrCodigoPesquisado: String ;
  LstrCliFor: String ;
begin
  Result := True ;
  LstrCodigoPesquisado := '' ;
  if UpperCase(AstrTipoFC) = 'C' then
  begin
    LstrCodigoPesquisado := fCampoTabela('CLI_CODCLI', 'CADCLI', ['CLI_CODCLI'], [AstrClienteFornecedor], False) ;
    LstrCliFor := 'Cliente' ;
  end ;

  if UpperCase(AstrTipoFC) = 'F' then
  begin
    LstrCodigoPesquisado := fCampoTabela('FOR_CODFOR', 'CADFOR', ['FOR_CODFOR'], [AstrClienteFornecedor], False) ;
    LstrCliFor := 'Fornecedor' ;
  end ;

  if fEmptyStr(LstrCodigoPesquisado) then
  begin
    Result := False ;
    AstrMensagemValidacao := 'Código ' + LstrCliFor + ' ['+AstrClienteFornecedor+'] não encontrado!' ;
  end ;

end;

class function TValidaProcessoLancamentoContabil.fLancouContasIguais(
  const AstrContaCredito, AstrContaDebito: string): boolean;
begin
  result := False ;
  if (not fEmptyStr(fSemMascaraPlaNco(AstrContaCredito))) and (not fEmptyStr(fSemMascaraPlaNco(AstrContaDebito)))  then
  begin
    Result := SameText(fSemMascaraPlaNco(AstrContaCredito), fSemMascaraPlaNco(AstrContaDebito));
  end;
end;

class function TValidaProcessoLancamentoContabil.fObrigatorioCentroCusto(
  const AstrConta, AstrCodEmp: string): boolean;
var
  LstrPatrim: string ;
  LstrTplaco: string ;
begin
  result := False ;
  if fCfgExpEcd = 'N' then
  begin
    Exit ;
  end;

  if fCfgObrCcu = 'N' then
  begin
    exit ;
  end;

  LstrTplaco := fRetTplacoEmpresaLogada(AstrCodEmp) ;
  LstrPatrim := fCampoTabela('NCO_PATRIM', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(AstrConta), LstrTplaco]) ;
  if LstrPatrim = 'S' then
  begin
    Result := False ;
    exit ;
  end;

  if LstrPatrim = 'N' then
  begin
    Result := True ;
  end;
end;

class function TValidaProcessoLancamentoContabil.fRetornaArrayMensagens(
  const ADadosValidacao: TDadosValidacaoLanCon; AcdsVigenciaPlanco: TUniClientDataset;
  const AblnValidarIniCon: Boolean; var AVerifFec: TVerificaFechamentoDiaMes): TList<string>;
var
  strMsg: string ;
begin
  Result := TList<string>.Create() ;

  if AblnValidarIniCon then
  begin
    fValidaInicioContabilidade(strMsg, ADadosValidacao.dtaLan, ADadosValidacao.strCodEmp) ;
    pAcumulaMsgVetor(strMsg, Result) ;
  end;
  fValidaPeriodoFechado(strMsg, ADadosValidacao.dtaLan, ADadosValidacao.dtaLan, ADadosValidacao.strCodEmp) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaSemContas(strMsg, ADadosValidacao.strContaCredito, ADadosValidacao.strContaDebito) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaValor(strMsg, ADadosValidacao.fltValor) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaLancouContasIguais(strMsg, ADadosValidacao.strContaCredito, ADadosValidacao.strContaDebito) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaCentroCustoDebito(strMsg, ADadosValidacao.strContaDebito, ADadosValidacao.strCentroCustoDebito, ADadosValidacao.strCodEmp) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaCentroCustoCredito(strMsg, ADadosValidacao.strContaCredito, ADadosValidacao.strCentroCustoCredito, ADadosValidacao.strCodEmp) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaHistorico(strMsg, ADadosValidacao.strComplemento, ADadosValidacao.strHistoricoPadrao) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaPlancoVigencia(strMsg, AcdsVigenciaPlanco, ADadosValidacao.dtaLan, ADadosValidacao.strContaCredito, ADadosValidacao.strCodEmp) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaPlancoVigencia(strMsg, AcdsVigenciaPlanco, ADadosValidacao.dtaLan, ADadosValidacao.strContaDebito, ADadosValidacao.strCodEmp) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaContaContabilCadastrada(strMsg, ADadosValidacao.strContaCredito, ADadosValidacao.strCodEmp) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaContaContabilCadastrada(strMsg, ADadosValidacao.strContaDebito, ADadosValidacao.strCodEmp) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaCentroCustoCadastrada(strMsg, ADadosValidacao.strCentroCustoCredito) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaCentroCustoCadastrada(strMsg, ADadosValidacao.strCentroCustoDebito) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaHistoricoPadraoCadastrada(strMsg, strTointDef(ADadosValidacao.strHistoricoPadrao,0), ADadosValidacao.strCodEmp) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaEmpresaCadastrada(strMsg, ADadosValidacao.strCodEmp) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaSubconta(strMsg, ADadosValidacao.blnValidarClienteFornecedorDebito, ADadosValidacao.strTipoFCDebito, ADadosValidacao.strClienteFornecedorDebito, 'D') ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaSubconta(strMsg, ADadosValidacao.blnValidarClienteFornecedorCredito, ADadosValidacao.strTipoFCCredito, ADadosValidacao.strClienteFornecedorCredito, 'C') ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaFechamentoDiaMes(strMsg, AVerifFec, ADadosValidacao.dtaLan, ADadosValidacao.strCodEmp);
  pAcumulaMsgVetor(strMsg, Result) ;
end;

class function TValidaProcessoLancamentoContabil.fValida(
  const ADadosValidacao: TDadosValidacaoLanCon; AcdsVigenciaPlanco: TUniClientDataset;
  const AblnValidarIniCon: Boolean = False): boolean;
var
  LArrMensagens: TList<string> ;
  LDictDadosMostrar: TDictPendenciasLanCon ;
  LValidaFecDiaMes: TVerificaFechamentoDiaMes;
begin
  result := False ;
  try
    LValidaFecDiaMes := TVerificaFechamentoDiaMes.Create;
    LArrMensagens := fRetornaArrayMensagens(ADadosValidacao, AcdsVigenciaPlanco, AblnValidarIniCon, LValidaFecDiaMes) ;
    if LArrMensagens.Count > 0 then
    begin
      LDictDadosMostrar := TDictPendenciasLanCon.Create ;
      try
        LDictDadosMostrar.Add(' ', LArrMensagens);
        pMostraMensagens(LDictDadosMostrar) ;
      finally
        FreeAndNil(LDictDadosMostrar) ;
      end;
      exit ;
    end;
  finally
    if Assigned(LValidaFecDiaMes) then
      FreeAndNil(LValidaFecDiaMes);
    FreeAndNil(LArrMensagens) ;
  end;
  result := True ;
end;

class function TValidaProcessoLancamentoContabil.fValidaBloco(
  const ADadosValidacao: TList<TDadosValidacaoLanCon>; AcdsVigenciaPlanco: TUniClientDataset): boolean;
var
  LDadoValidacao: TDadosValidacaoLanCon ;
  LArrMensagens : TList<string> ;
  LintLinha : Integer ;
  LdictMensagens : TDictPendenciasLanCon ;
  LValidaFecDiaMes: TVerificaFechamentoDiaMes;
begin
  result := False ;

  LdictMensagens := TDictPendenciasLanCon.Create ;

  try
    LValidaFecDiaMes := TVerificaFechamentoDiaMes.Create;
    LintLinha := 1 ;
    for LDadoValidacao in ADadosValidacao do
    begin
      Inc(LintLinha) ;
      LArrMensagens := fRetornaArrayMensagens(LDadoValidacao, AcdsVigenciaPlanco, False, LValidaFecDiaMes) ;
      if LArrMensagens.Count > 0 then
      begin
        if not LdictMensagens.ContainsKey(intToStr(LintLinha)) then
        begin
          LdictMensagens.Add(intToStr(LintLinha), LArrMensagens);
        end;
      end
      else
      begin
        FreeAndNil(LArrMensagens) ;
      end;
    end;

    pValidaSomaCreditoDebito(ADadosValidacao, LdictMensagens) ;

    if LdictMensagens.Count > 0 then
    begin
      pMostraMensagens(LdictMensagens) ;
      exit ;
    end;

  finally
    if Assigned(LValidaFecDiaMes) then
      FreeandNil(LValidaFecDiaMes);
    FreeAndNil(LdictMensagens) ;
  end;

  result := True ;
end;

class function TValidaProcessoLancamentoContabil.fValidaCentroCustoCadastrada(
  var AstrMensagemValidacao: string; const AstrCentroCusto: string): boolean;
var
  LstrRetorno: string ;
begin
  result := True ;
  If (fEmptyStr(AstrCentroCusto, True)) Then
  Begin
    Exit;
  End;

  LstrRetorno := fCampoTabela('EVE_CODEVE', 'CADEVE', ['EVE_CODEVE'], [AstrCentroCusto]) ;
  if fEmptyStr(LstrRetorno) then
  begin
    AstrMensagemValidacao := 'Centro de Custo ['+AstrCentroCusto+'] não Cadastrado!' ;
  end;

end;

class function TValidaProcessoLancamentoContabil.fValidaCentroCustoCredito(
  var AstrMensagemValidacao: string; const AstrConta, AstrCentroCusto,
  AstrCodEmp: string): boolean;
var
  LblnValidar: boolean ;
  LblnExisteCampoCON_CCUSCR: boolean ;
begin
  LblnExisteCampoCON_CCUSCR := fCampoExiste('LANCON', 'CON_CCUSCR');
  LblnValidar := LblnExisteCampoCON_CCUSCR and fObrigatorioCentroCusto(AstrConta, AstrCodEmp) ;

  result := fValidarCentroCusto(AstrConta, AstrCentroCusto, LblnValidar) ;
  if not result then
  begin
    AstrMensagemValidacao := '"C.Custo Cre." deve ser informado!' ;
  end;

end;

class function TValidaProcessoLancamentoContabil.fValidaCentroCustoDebito(
  var AstrMensagemValidacao: string; const AstrConta, AstrCentroCusto,
  AstrCodEmp: string): boolean;
var
  LblnExisteCampoCON_CCUSTO: boolean ;
  LblnValidar: boolean ;
begin
  LblnExisteCampoCON_CCUSTO := True ;
  LblnValidar := LblnExisteCampoCON_CCUSTO and fObrigatorioCentroCusto(AstrConta, AstrCodEmp) ;

  result := fValidarCentroCusto(AstrConta, AstrCentroCusto, LblnValidar) ;
  if not result then
  begin
    AstrMensagemValidacao := '"C.Custo Deb." deve ser informado!' ;
  end;

end;

class function TValidaProcessoLancamentoContabil.fValidaContaContabilCadastrada(
  var AstrMensagemValidacao: string; const AstrConta,
  AstrCodEmp: string): boolean;
var
  LstrTplaco: string ;
  LqryBusca: TUniQuery ;
begin
  result := True ;
  If (fEmptyStr(fSemMascaraPlaNco(AstrConta), True)) Then
  Begin
    Exit;
  End;

  LstrTplaco := fRetTplacoEmpresaLogada(AstrCodEmp) ;

  LqryBusca := fCriaQuery() ;
  try
    LqryBusca.Close;
    LqryBusca.SQL.Clear;
    LqryBusca.SQL.Add(' SELECT NCO_CODCON ');
    LqryBusca.SQL.Add('   FROM PLANCO ');
    LqryBusca.SQL.Add('  WHERE TRUE AND NCO_TPLACO = :TPLACO ');
    LqryBusca.ParamByName('TPLACO').AsString := LstrTplaco ;
    LqryBusca.SQL.Add('  AND (NCO_CODCON = :CODCON) ');
    if fCfgCtntsi = 'N' then
    begin
      LqryBusca.SQL.Add(' AND IFNULL(NCO_NATURE,"A") = "A" ') ;
    end ;
    LqryBusca.ParamByName('CODCON').AsString := fSemMascaraPlaNco(AstrConta);
    LqryBusca.SQL.Add('  ORDER BY NCO_CODCON ');
    LqryBusca.Open;

    result := LqryBusca.IsEmpty ;
    If result Then
    Begin
      result := False ;
      AstrMensagemValidacao := 'Conta ['+AstrConta+'/'+LstrTplaco+'] Não Cadastrada no Plano de Contas!' ;
    End ;

  finally
    FreeAndNil(LqryBusca) ;
  end;

end;

class function TValidaProcessoLancamentoContabil.fValidaEmpresaCadastrada(
  var AstrMensagemValidacao: string; const AstrCodEmp: string): boolean;
var
  LstrRetorno: string ;
begin
  result := True ;
  If fEmptyStr(AstrCodEmp) Then
  Begin
    Exit;
  End;

  LstrRetorno := fCampoTabela('EMP_CODEMP', 'CADEMP', ['EMP_CODEMP'], [AstrCodEmp]) ;
  if fEmptyStr(LstrRetorno) then
  begin
    AstrMensagemValidacao := 'Empresa ['+AstrCodEmp+'] não Cadastrada!' ;
    Result := False ;
    exit ;
  end;

end;

class function TValidaProcessoLancamentoContabil.fValidaFechamentoDiaMes(
  var AstrMensagemValidacao: string; var AVerifFec: TVerificaFechamentoDiaMes;
  const AdtaLan: TDate; const AstrCodEmp: string): boolean;
begin
  Result := not AVerifFec.fTemFechamentoTValida(AdtaLan, AdtaLan, AstrCodEmp, AstrMensagemValidacao)
end;

class function TValidaProcessoLancamentoContabil.fValidaHistorico(
  var AstrMensagemValidacao: string; const AStrComplemento,
  AstrHistoricoPadrao: string): boolean;
begin
  result := False ;
  if (strToIntDef(trim(AstrHistoricoPadrao),0) = 0) and (fEmptyStr(trim(AStrComplemento))) then
  begin
    AstrMensagemValidacao := 'Pelo menos um dos campos devem ser informados "Histórico Padrão" e/ou "Complemento"!' ;
    exit ;
  end;
  result := True ;
end;

class function TValidaProcessoLancamentoContabil.fValidaHistoricoPadraoCadastrada(
  var AstrMensagemValidacao: string; const AintHisPad: Integer; const AstrCodEmp: string): boolean;
var
  LstrRetorno: string ;
begin
  result := True ;
  If AintHisPad = 0 Then
  Begin
    Exit;
  End;

  LstrRetorno := fRetDescHistoricoPadrao(AintHisPad.ToString, AstrCodEmp);
  if fEmptyStr(LstrRetorno) then
  begin
    AstrMensagemValidacao := 'Histórico Padrão ['+inttostr(AintHisPad)+'] não Cadastrado!' ;
    Result := False ;
    exit ;
  end;

end;

class function TValidaProcessoLancamentoContabil.fValidaInicioContabilidade(
  var AstrMensagemValidacao: string; const AdtaLan: TDate;
  const AstrCodEmp: string): boolean;
var
  LstrIniCon: string;
  LdtaIniCon : TDate;
begin
  Result := False ;

  if not fCampoExiste('CADEMP', 'EMP_INICON') then
    Exit ;

  try
    LstrIniCon := fCampoTabela('EMP_INICON', 'CADEMP', ['EMP_CODEMP'], [AstrCodEmp]) ;
    LdtaIniCon :=  StrToDate(LstrIniCon);
  except
    LdtaIniCon := 0;
  end;

  Result := AdtaLan >= LdtaIniCon;

  if not Result then
    AstrMensagemValidacao :=
      'Não é permitido que a Data de Lançamento seja inferior à "Data de Início da Contabilidade pelo Autcom",'
      + ' informada na aba "Contabilidade", do Cadastro de Empresas (> Principal > Manutenção de Cadastros > Auxiliares > Empresas).'
      + ' Verifique a Situação.'

end;

class function TValidaProcessoLancamentoContabil.fValidaLancouContasIguais(
  var AstrMensagemValidacao: string; const AstrContaCredito,
  AstrContaDebito: string): boolean;
begin
  result := fLancouContasIguais(AstrContaCredito, AstrContaDebito) ;
  if result then
  begin
    AstrMensagemValidacao := 'Não é permitido lançar contas contábeis iguais!' ;
  end;
end;

class function TValidaProcessoLancamentoContabil.fValidaPeriodoFechado(var AstrMensagemValidacao: string;
   const AdtaIni, AdtaFin: TDateTime; const AstrCodEmp: string): boolean;
begin
  result := fLancamentoAnteriorFechamento(AdtaIni, AstrCodEmp, AstrMensagemValidacao) ;
end;

class function TValidaProcessoLancamentoContabil.fValidaPlancoVigencia(
  var AstrMensagemValidacao: string; AcdsPlancoVigencia: TUniClientDataSet;
  const AdtaLan: TDate; const AstrConta, AstrCodEmp: string): boolean;
begin

  result := fVerificaPlancoVigencia(AcdsPlancoVigencia,
                                    AdtaLan,
                                    fSemMascaraPlaNco(AstrConta),
                                    AstrMensagemValidacao,
                                    AstrCodEmp) ;

end;

class function TValidaProcessoLancamentoContabil.fValidarCentroCusto(
  const AstrConta, AstrCentroCusto: string;
  const AblnValidar: boolean): boolean;
begin
  result := True ;
  if fCfgObrCcu = 'N' then
  begin
    exit ;
  end;

  if AblnValidar then
  begin
    if fEmptyStr(AstrCentroCusto) then
    begin
      if fEmptyStr(fSemMascaraPlaNco(AstrConta)) then
      begin
        Exit ;
      end;
      result := False ;
    end;
  end;

end;

class function TValidaProcessoLancamentoContabil.fValidaSemContas(
  var AstrMensagemValidacao: string; const AstrContaCredito,
  AstrContaDebito: string): boolean;
begin
  result := False ;
  if (fEmptyStr(fSemMascaraPlaNco(AstrContaCredito))) and (fEmptyStr(fSemMascaraPlaNco(AstrContaDebito))) then
  begin
    AstrMensagemValidacao := 'Nenhuma Conta Contábil Informada!' ;
    exit ;
  end;

  result := True ;
end;

class function TValidaProcessoLancamentoContabil.fValidaSubconta(
  var AstrMensagemValidacao: string;
  const AblnValidarClienteFornecedor: Boolean; const AstrTipoFC,
  AstrClienteFornecedor, AstrDebitoCredito: String): boolean;
var
  LstrDebCre: String ;
begin
  Result := True;

  If (fCfgDesmembrarSubContaCliFor = 'N') Then
    Exit;

  If (Not AblnValidarClienteFornecedor) Then
    Exit;

  LstrDebCre := '' ;
  if AstrDebitoCredito = 'C' then
    LstrDebCre := 'Crédito'
  else if AstrDebitoCredito = 'D' then
    LstrDebCre := 'Débito' ;

  if fEmptyStr(AstrTipoFC) then
  begin
    AstrMensagemValidacao := 'Tipo Subconta [C/F] ' + LstrDebCre + ' não informada!' ;
    Exit(False);
  end ;

  if not MatchStr(UpperCase(AstrTipoFC), ['C', 'F']) then
  begin
    AstrMensagemValidacao := 'Tipo Subconta inválido, permitido apenas [C/F]!' ;
    Exit(False);
  end ;

  if fEmptyStr(AstrClienteFornecedor) then
  begin
    AstrMensagemValidacao := 'Subconta Cli/For ' + LstrDebCre + ' não informada!' ;
    Exit(False);
  end ;

  if not fCliForCadastrado(AstrTipoFC, AstrClienteFornecedor, AstrMensagemValidacao) then
    Exit(False);

end;

class function TValidaProcessoLancamentoContabil.fValidaValor(
  var AstrMensagemValidacao: string; const AfltValor: double): boolean;
begin
  result := True ;
  if AfltValor <= 0.00 then
  begin
    AstrMensagemValidacao := 'Valor deve ser maior que zero!' ;
    result := False ;
    exit ;
  end;
end;

class procedure TValidaProcessoLancamentoContabil.pAcumulaMsgVetor(
  var AstrMensagemValidacao: string; var AarrMensagens: TList<string>);
begin
  if not fEmptyStr(AstrMensagemValidacao) then
  begin
    AarrMensagens.Add(AstrMensagemValidacao) ;
  end;
  AstrMensagemValidacao := '' ;
end;

class procedure TValidaProcessoLancamentoContabil.pMostraMensagens(
  const AArrMensagens: TDictPendenciasLanCon);
var
  objMensagens: TValidaContaContabil ;
  strItem: string ;
  regDoc: TContaErro ;
  LfrmErrosContabil : TfrmErrosContabil;
  LPair: TPair<string, TList<string>> ;
  LblnMostraChave: Boolean ;
begin
  LblnMostraChave := True ;
  objMensagens := TValidaContaContabil.Create ;
  try
    for LPair in AArrMensagens do
    begin
      for strItem in LPair.Value do
      begin
        LblnMostraChave := not femptyStr(LPair.Key) ;
        regDoc.strChaveDocumento := LPair.Key ;
        regDoc.strMotivo := strItem ;
        regDoc.strWarning := 'N' ;
        objMensagens.pAddErro(regDoc, Nil);
      end;
    end;

    pCriarFormularios(TfrmErrosContabil, LfrmErrosContabil);
    try
      LfrmErrosContabil.cdsErros := objMensagens.DataSet;
      LfrmErrosContabil.objUpdateContaContabil := Nil;
      LfrmErrosContabil.cxDadosDBTableViewCHVDOC.Visible := LblnMostraChave ;
      LfrmErrosContabil.cxDadosDBTableViewCHVDOC.Caption := 'Linha' ;
      LfrmErrosContabil.cxDadosDBTableViewTIPLAN.Visible := False ;
      LfrmErrosContabil.cxDadosDBTableViewORIGEM.Visible := False ;
      LfrmErrosContabil.cxDadosDBTableViewHISTOR.Visible := False ;
      LfrmErrosContabil.cxDadosDBTableViewDESVAL.Visible := False ;
      LfrmErrosContabil.cxDadosDBTableViewNATCFO.Visible := False ;
      LfrmErrosContabil.cxDadosDBTableViewPLANCO.Visible := False ;
      LfrmErrosContabil.ShowModal;
    finally
      pFreeAndNil(LfrmErrosContabil);
    end;

  finally
    FreeAndNil(objMensagens) ;
  end;
end;

class procedure TValidaProcessoLancamentoContabil.pValidaSomaCreditoDebito(
  const ADadosValidacao: TList<TDadosValidacaoLanCon>;
  var AdictMensagens: TDictPendenciasLanCon);
var
  LdictCreditoDebitoIgualZero: TDictionary<String, TDadosValidacaoSomaCreditoDebito> ;
  LpairItem: TPair<String, TDadosValidacaoSomaCreditoDebito> ;
  LDadoValidacao: TDadosValidacaoLanCon ;
  LregValores: TDadosValidacaoSomaCreditoDebito ;
  LArrMensagens : TList<string> ;
begin
  if not fConfiguracaoExiste('TRDCZE') then
    exit;

  if not fCfgSis('TRDCZE', varBoolean) then
    exit;


  LdictCreditoDebitoIgualZero := TDictionary<String, TDadosValidacaoSomaCreditoDebito>.Create ;
  try
    for LDadoValidacao in ADadosValidacao do
    begin
      if not fEmptyStr(LDadoValidacao.strIncDoc) then
      begin
        if not LdictCreditoDebitoIgualZero.ContainsKey(LDadoValidacao.strIncDoc) then
        begin
          FillChar(LregValores, SizeOf(LregValores), #0);
          LdictCreditoDebitoIgualZero.Add(LDadoValidacao.strIncDoc, LregValores);
        end;

        LregValores := LdictCreditoDebitoIgualZero.Items[LDadoValidacao.strIncDoc] ;
        LregValores.strLinha := LregValores.strLinha + ifThen(fEmptyStr(LregValores.strLinha), '', ',') + LDadoValidacao.strLinha ;

        if not fEmptyStr(LDadoValidacao.strContaCredito) then
          LregValores.fltCredito := LregValores.fltCredito + fFormataFloat(LDadoValidacao.fltValor, 2) ;

        if not fEmptyStr(LDadoValidacao.strContaDebito) then
          LregValores.fltDebito := LregValores.fltDebito + fFormataFloat(LDadoValidacao.fltValor, 2) ;
        LdictCreditoDebitoIgualZero.Items[LDadoValidacao.strIncDoc] := LregValores ;
      end ;
    end ;

    for LpairItem in LdictCreditoDebitoIgualZero do
    begin
      if fFormataFloat(LpairItem.Value.fltCredito, 2) <> fFormataFloat(LpairItem.Value.fltDebito,2) then
      begin
        LArrMensagens := TList<string>.Create ;
        LArrMensagens.Add(format(CONTABIL_MSG_TOTDEB_MENOS_TOTCRE_DIFERENTE_ZERO,
                                 [FormatCurr('#,##0.00', fFormataFloat(LpairItem.Value.fltDebito, 2)),
                                  FormatCurr('#,##0.00', fFormataFloat(LpairItem.Value.fltCredito, 2))
                                 ])
                         ) ;
        AdictMensagens.Add(LpairItem.Value.strLinha, LArrMensagens);
      end ;
    end ;

  finally
    FreeAndNil(LdictCreditoDebitoIgualZero) ;
  end ;

end;

end.
