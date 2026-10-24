unit Contabilidade.Classes.TGeradorContabilCtp;

interface

uses System.Generics.Collections,
     Contabilidade.Model.TDadosImportacaoContabil,
     Contabilidade.Classes.TGeradorContabilBase,
     Contabilidade.Classes.TParametroContabil,
     Contabilidade.Classes.TDadosAbertura,
     Contabilidade.Model.ContasPagar,
     Contabilidade.Model.Portador,
     Contabilidade.Interfaces,
     SysUtils,
     UniClientDataSet,
     cxProgressBar,
     Math, Classes;

type

  TControleParConCtpItem = class
  var
    FstrTipoLancamento : string ;
    FstrFormaPagamento : string ;
    FstrDescricaoValor : string ;
    FstrTipoPagamento : string ;
    Fpagar : TContasPagar ;
    Fparametro: TParametroContabil ;
    FblnNaoParametrizado : Boolean ;
  public
    property strTipoLancamento : string read FstrTipoLancamento write FstrTipoLancamento  ;
    property strFormaPagamento : string read FstrFormaPagamento write FstrFormaPagamento  ;
    property strDescricaoValor : string read FstrDescricaoValor write FstrDescricaoValor  ;
    property strTipoPagamento : string read FstrTipoPagamento write FstrTipoPagamento ;
    property pagar : TContasPagar read Fpagar write Fpagar ;
    property parametro: TParametroContabil read Fparametro write Fparametro;
    property blnNaoParametrizado : boolean read FblnNaoParametrizado write FblnNaoParametrizado ;
  end;

  TControleParConCtp = class
  private
    FItens : TStringList ;
    FItensPendentes : TStringList ;
    function strPendencia(Item:TControleParConCtpItem):string ;
  public
    constructor Create ;
    destructor Destroy; override;
    procedure Remove(const ATipoLancamento : string  ;
                     const AFormaPagamento : string  ;
                     const ADescricaoValor : string  ;
                     const ATipoPagamento  : string  ;
                     const AControle       : integer ;
                           APagar          : TContasPagar ;
                           AParametro      : TParametroContabil) ;

    procedure Add(const ATipoLancamento : string  ;
                  const AFormaPagamento : string  ;
                  const ADescricaoValor : string  ;
                  const ATipoPagamento  : string  ;
                  const AControle       : integer ;
                        APagar          : TContasPagar ;
                        AParametro      : TParametroContabil) ;

    function Pendencias:TStringList ;
  end;

  TGeradorContabilCtp = class(TGeradorContabilBase)
  private
    FListaPagamentos: TObjectList<TContasPagar>;
    FcdsCtpLancadosPeriodoFechado: TUniClientDataSet;

    function fRetHistorico(pagar: TContasPagar; parametro: TParametroContabil): string;
    function fRetCodigoContabilizavel(const pagar: TContasPagar; const strOrigem, strContaCredito, strContaDebito: string; const AFormaPagamento: TPortadorFormaPagamento = pfpNaoEspecificado): string;

    procedure pRetornaDadosOrigem(const APagar: TContasPagar;
                              const AParametro: TParametroContabil;
                              const AOrigem: TOrigemPlanoContabil;
                              const ADebitoCredito: TTipoPlanoContas;
                              const ABaixaCadastro: string;
                              const AFormaPagamento: TPortadorFormaPagamento;
                              out AtipoOrigem, ACodigoOrigem: string);
    function fOrigemCreditoEnum(
      const AParametro: TParametroContabil): TOrigemPlanoContabil;
    function fOrigemDebitoEnum(
      const AParametro: TParametroContabil): TOrigemPlanoContabil;

    function fRetContaCredito(pagar: TContasPagar; parametro: TParametroContabil; const AFormaPagamento: TPortadorFormaPagamento = pfpNaoEspecificado): string;
    function fRetContaDebito(pagar: TContasPagar; parametro: TParametroContabil; const AFormaPagamento: TPortadorFormaPagamento = pfpNaoEspecificado): string;
    procedure pAdicionarLancamentoDescontoTotal(const AModalidade, AValorLancamento: double; const ADescricaoValor, AFormaPagamento: string; const APagar: TContasPagar; const AParametro: TParametroContabil; var ctrlCtpParcon : TControleParConCtp; const intControle: integer; var blnFlagParcon:boolean);
    procedure pAdicionarLancamento(pagar: TContasPagar;
                                   parametro: TParametroContabil;
                                   const ADescricaoValor: string;
                                   const AValorLancamento: double;
                                   var ctrlCtpParcon: TControleParConCtp;
                                   const intControle: integer;
                                   var blnFlagParcon:boolean;
                                   const AdtaLancamento: TDateTime;
                                   const AstrTipoLancamento: String;
                                   const AstrForPgo: string);
    function fRetContaPortador(const APagar: TContasPagar; const AFormaPagamento: TPortadorFormaPagamento): string;
    function fRetCodigoPortador(const APagar: TContasPagar; const AFormaPagamento: TPortadorFormaPagamento): string;
    function fTrataCodigoEmpresa(const APagar: TContasPagar):string ;
    function fTrataNomeEmpresa(const APagar: TContasPagar):string ;
    procedure pAdicionaItemListError(const APagar: TContasPagar; const AParametro: TParametroContabil; const AstrMensagem, AstrTipoLancamento, AstrDescricaoValor: string) ;
    procedure pAdicionaLista(var AdicDados: TDadosImportacaoContabil; const AcpPagar: TContasPagar) ;
    function fAdicionaLancamentoBaixaEmpresaDiferente(var AdicDados: TDadosImportacaoContabil; const AcpPagar: TContasPagar): Boolean ;
    function fTemFormaPagtoValida(const AstrFormaPagamento: String; const AlstParametrosContabil: TObjectList<TParametroContabil>; const AParametrosContabilAtual: TParametroContabil; const ADataRef: TDateTime): Boolean ;
    function fRetornaEventoDescontoJuros(const AstrCodigoEvento, AstrDescricaoValor: String): String;
    function fRetCodigoHistoricoPadrao(const APagar: TContasPagar; const AParametro: TParametroContabil; const AstrTipoLancamento: string): Integer;
    function fRetCodigoPlanoContas(const APagar: TContasPagar; AParametro: TParametroContabil): string;
  public
    procedure pGerar;

    property listaPagamentos: TObjectList<TContasPagar> read FListaPagamentos write FListaPagamentos;
    property cdsCtpLancadosPeriodoFechado: TUniClientDataSet read FcdsCtpLancadosPeriodoFechado write FcdsCtpLancadosPeriodoFechado;
  end;

implementation

{ TGeradorContabilCtp }

uses Contabilidade.Funcoes, untFuncoesSimples, Contabilidade.Classes.Helpers,
     Contabilidade.Classes.TEventoContabil, strUtils;

function TGeradorContabilCtp.fOrigemCreditoEnum(
  const AParametro: TParametroContabil): TOrigemPlanoContabil;
begin
  if AParametro.blnCreditoClienteFornecedor then
    Result := opcCliFor
  else if AParametro.blnCreditoPortador then
    Result := opcPortador
  else if AParametro.blnCreditoBandeira then
    Result := opcBandeira
  else if AParametro.blnCreditoPlanoContas then
    Result := opcPlanoContas
  else
    Result := opcParcon;
end;

function TGeradorContabilCtp.fOrigemDebitoEnum(
  const AParametro: TParametroContabil): TOrigemPlanoContabil;
begin
  if AParametro.blnDebitoClienteFornecedor then
    Result := opcCliFor
  else if AParametro.blnDebitoPortador then
    Result := opcPortador
  else if AParametro.blnDebitoBandeira then
    Result := opcBandeira
  else if AParametro.blnDebitoPlanoContas then
    Result := opcPlanoContas
  else
    Result := opcParcon;
end;

function TGeradorContabilCtp.fRetCodigoContabilizavel(const pagar: TContasPagar;
  const strOrigem, strContaCredito, strContaDebito: string;
  const AFormaPagamento: TPortadorFormaPagamento = pfpNaoEspecificado): string;
begin
  Result := '';
  if (strOrigem = 'Portador') then
    Result := fRetCodigoPortador(pagar, AFormaPagamento)
  else if (strOrigem = 'Plano de Contas') or (strOrigem = 'Plano de Contas (Cadastro)') then
    Result := pagar.planoContasCadastro.strCodigo
  else if (strOrigem = 'Plano de Contas (Baixa)') then
    Result := pagar.planoContasBaixa.strCodigo
  else if (strOrigem = 'Cliente/Fornecedor') then
    Result := pagar.participante.strCodigo
  else if (strOrigem = 'Conta Crédito') then
    Result := strContaCredito
  else if (strOrigem = 'Conta Débito') then
    Result := strContaDebito;
end;

function TGeradorContabilCtp.fRetCodigoHistoricoPadrao(
   const APagar: TContasPagar; const AParametro: TParametroContabil;
   const AstrTipoLancamento: string): Integer;
begin
  Result := fCarregaCodigoHistoricoCadCta(fRetCodigoPlanoContas(APagar, AParametro), AStrTipoLancamento);

  if Result <= 0 then
    Result := StrToInt(AParametro.strCodigoHistoricoPadrao);
end;

function TGeradorContabilCtp.fRetCodigoPlanoContas(const APagar: TContasPagar;
  AParametro: TParametroContabil): string;
begin
  if (AParametro.strTipoLancamento = TIPO_CONTAS_PAGAR_PROVISAO) then
  begin
    if APagar.strCodCtaResultado.IsEmpty then
    begin
      If (AParametro.strBaixaCadastroCredito = CONTA_DA_BAIXA) Then
        Result := APagar.planoContasBaixa.strCodigo
      else
        Result := APagar.planoContasCadastro.strCodigo;
    end
    else
      Result := APagar.strCodCtaResultado
  end
  else
  begin
    if AParametro.strBaixaCadastroCredito = CONTA_DA_BAIXA then
      Result := APagar.planoContasBaixa.strCodigo
    else
      Result := APagar.planoContasCadastro.strCodigo;
  end;
end;

function TGeradorContabilCtp.fRetCodigoPortador(const APagar: TContasPagar;
  const AFormaPagamento: TPortadorFormaPagamento): string;
var
  LPortador: TPortador ;
begin
  Result := APagar.portador.strCodigo ;
  if APagar.portador.PortadorFormaPagamento.Count > 0 then
  begin
    if APagar.portador.PortadorFormaPagamento.ContainsKey(AFormaPagamento) then
    begin
      LPortador := APagar.portador.PortadorFormaPagamento.Items[AFormaPagamento] ;
      Result := LPortador.strCodigo ;
    end;
  end;
end;

function TGeradorContabilCtp.fRetContaCredito(pagar: TContasPagar; parametro: TParametroContabil; const AFormaPagamento: TPortadorFormaPagamento = pfpNaoEspecificado): string;
  var
    strContaCredito: string;
begin
  strContaCredito := parametro.strContaCredito;

  if (strContaCredito.IsEmpty) and (not parametro.strHashParCon.IsEmpty) then
    strContaCredito := fParNco(parametro.strSequenciaParametro, fTrataCodigoEmpresa(pagar), 'C');

  if parametro.blnCreditoClienteFornecedor then
    strContaCredito := pagar.participante.strContaContabil
  else if parametro.blnCreditoPlanoContas then
  begin
    if (parametro.strTipoLancamento = TIPO_CONTAS_PAGAR_PROVISAO) then
    begin
      if pagar.strCodCtaResultado.IsEmpty then
      begin
        If (parametro.strBaixaCadastroCredito = CONTA_DA_BAIXA) Then
          strContaCredito := pagar.planoContasBaixa.strContaContabil
        else
          strContaCredito := pagar.planoContasCadastro.strContaContabil;
      end
      else
        strContaCredito := pagar.strCodCtaResultado;
    end
    else
    begin
      if parametro.strBaixaCadastroCredito = CONTA_DA_BAIXA then
        strContaCredito := pagar.planoContasBaixa.strContaContabil
      else
        strContaCredito := pagar.planoContasCadastro.strContaContabil;
    end;
  end
  else if parametro.blnCreditoPortador then
    strContaCredito := fRetContaPortador(pagar, AFormaPagamento);

  Result := strContaCredito;
end;

function TGeradorContabilCtp.fRetContaDebito(pagar: TContasPagar; parametro: TParametroContabil; const AFormaPagamento: TPortadorFormaPagamento = pfpNaoEspecificado): string;
  var
    strContaDebito: string;
begin
  strContaDebito := parametro.strContaDebito;

  if (strContaDebito.IsEmpty) and (not parametro.strHashParCon.IsEmpty) then
    strContaDebito := fParNco(parametro.strSequenciaParametro, fTrataCodigoEmpresa(pagar), 'D');

  if parametro.blnDebitoClienteFornecedor then
    strContaDebito := pagar.participante.strContaContabil
  else if parametro.blnDebitoPlanoContas then
  begin
    If (parametro.strBaixaCadastroDebito = CONTA_DA_BAIXA) Then
      strContaDebito := pagar.planoContasBaixa.strContaContabil
    else
      strContaDebito := pagar.planoContasCadastro.strContaContabil;
  end
  else if parametro.blnDebitoPortador then
    strContaDebito := fRetContaPortador(pagar, AFormaPagamento);

  Result := strContaDebito;
end;

function TGeradorContabilCtp.fRetContaPortador(
  const APagar: TContasPagar;
  const AFormaPagamento: TPortadorFormaPagamento): string;
var
  LPortador: TPortador ;
begin
  Result := APagar.portador.strContaContabil ;
  if APagar.portador.PortadorFormaPagamento.Count > 0 then
  begin
    if APagar.portador.PortadorFormaPagamento.ContainsKey(AFormaPagamento) then
    begin
      LPortador := APagar.portador.PortadorFormaPagamento.Items[AFormaPagamento] ;
      Result := LPortador.strContaContabil ;
    end;
  end;
end;

function TGeradorContabilCtp.fRetHistorico(pagar: TContasPagar; parametro: TParametroContabil): string;

  procedure addComplemento(var Resultado: string; const Value: string);
  begin
    if Value.IsEmpty then
      exit;

    if Resultado.IsEmpty then
      Resultado := Value
    else
      Resultado := Concat(Resultado, ' / ', Value);
  end;

begin
  Result := '';

  if (dadosAbertura.blnUsaCheckListComplemento) and (not parametro.strComplementosParametro.IsEmpty) then
  begin
    if parametro.strComplementosParametro.Contains('N. Docto') then
      addComplemento(Result, fRemoveZerosEsquerda(pagar.strNumero));

    If parametro.strComplementosParametro.Contains('Nome fornecedor/cliente') Then
      addComplemento(Result, pagar.participante.strNome);

    If parametro.strComplementosParametro.Contains('CNPJ') then
      addComplemento(Result, pagar.participante.strCgcCpf);

    If parametro.strComplementosParametro.Contains('Competência') then
      addComplemento(Result, pagar.strCompetencia);

    If parametro.strComplementosParametro.Contains('Parcela') then
      addComplemento(Result, pagar.strParcela);

    If parametro.strComplementosParametro.Contains('Nome Empresa') then
      addComplemento(Result, fTrataNomeEmpresa(pagar));

    If parametro.strComplementosParametro.Contains('Código Empresa') then
      addComplemento(Result, fTrataCodigoEmpresa(pagar));

    If parametro.strComplementosParametro.Contains('Data de Cadastro') then
      addComplemento(Result, FormatDateTime('dd/mm/yyyy', pagar.dtaDataCadastro));

    If parametro.strComplementosParametro.Contains('N. Cheque') then
    begin
      if not pagar.strNumChq.IsEmpty then
        addComplemento(Result, 'CHEQUE(S) NÚMERO(S):' + pagar.strNumChq);
    end;

    If parametro.strComplementosParametro.Contains('Hist. Padrão') then
      addComplemento(Result, pagar.strHist01);

    If parametro.strComplementosParametro.Contains('Histórico da Baixa') then
      addComplemento(Result, pagar.strHistoricoBaixa);

    If parametro.strComplementosParametro.Contains('Portador da Baixa') then
      addComplemento(Result, iif(fEmptyStr(pagar.portador.strCodigo), '', concat('PORTADOR BAIXA:', pagar.portador.strCodigo, '-', fCampoTabela('POR_NOMPOR', 'CADPOR', ['POR_CODPOR'], [pagar.portador.strCodigo], False) )) );
  end
  else
  begin
    if SameText(parametro.strComplementoDebito, 'N. Docto') then
      Result := fRemoveZerosEsquerda(pagar.strNumero)
    Else If SameText(parametro.strComplementoDebito, 'N. Docto. Nome fornecedor/cliente') Then
      Result := fRemoveZerosEsquerda(pagar.strNumero) + ' / ' + pagar.participante.strNome
    else if SameText(parametro.strComplementoDebito, 'N.Docto/Nome fornec./cliente/Comp./Parcela') Then
    begin
      Result := fRemoveZerosEsquerda(pagar.strNumero) + ' / ' + pagar.participante.strNome +
        ' / ' + pagar.strCompetencia + ' / ' + pagar.strParcela;
    end
    else if SameText(parametro.strComplementoDebito, 'N.Docto/Nome forn./cli./Nome Emp/N.Emp./DtaDoc.Ori') then
    begin
      Result := fRemoveZerosEsquerda(pagar.strNumero) + ' / ' + pagar.participante.strNome +
        ' / ' + fTrataNomeEmpresa(pagar) + ' / ' + fTrataCodigoEmpresa(pagar) +
        ' / ' + FormatDateTime('dd/mm/yyyy', pagar.dtaDataCadastro);
    end
    Else If SameText(parametro.strComplementoDebito, 'Nome fornecedor/cliente') Then
      Result := pagar.participante.strNome
    Else If SameText(parametro.strComplementoDebito, 'N. Conhecimento. Nome transportadora') Then
      Result := ''
    Else If (SameText(parametro.strComplementoDebito, 'N. Docto. / CNPJ / Nome fornecedor/clien')) Or
            (SameText(parametro.strComplementoDebito, 'N. Docto. / CNPJ / Nome fornecedor/cliente')) Then
      Result := fRemoveZerosEsquerda(pagar.strNumero) + ' / ' + pagar.participante.strCgcCpf + ' / ' + pagar.participante.strNome
    Else If (SameText(parametro.strComplementoDebito, 'N.Docto / Nome fornecedor/cliente / N.Cheque')) Then
      Result := fRemoveZerosEsquerda(pagar.strNumero) + ' / ' + pagar.participante.strNome + ' / ' + 'CHEQUE(S) NÚMERO(S):'+pagar.strNumChq
    else if SameText(parametro.strComplementoDebito, 'N.Docto/Histórico da baixa') Then
      Result := fRemoveZerosEsquerda(pagar.strNumero) + ' / ' + pagar.strHistoricoBaixa
    else if SameText(parametro.strComplementoDebito, 'N.Docto / Nome fornecedor/cliente / Hist.Padrão') Then
      Result := fRemoveZerosEsquerda(pagar.strNumero) + ' / ' + pagar.participante.strNome + ' / ' + pagar.strHist01;
  end;

  if (Not pagar.strDocumentoOriginal.IsEmpty) then
  begin
    Result := Result + ' / Doc.Ori: ' + pagar.strDocumentoOriginal;
    if (not pagar.strEspecieOriginal.IsEmpty) then
      Result := Result + '-' + pagar.strEspecieOriginal;
  end;
end;

function TGeradorContabilCtp.fRetornaEventoDescontoJuros(const AstrCodigoEvento,
  AstrDescricaoValor: String): String;
var
  LstrCentroCustoDefault: String ;
begin
  LstrCentroCustoDefault := fCentroCustoDefaultCntDespRecCus ;
  result := TFactoryEventoContabil.New.fConfiguraEvento(AstrCodigoEvento, 'CTP', '', AstrDescricaoValor).fConsultaEvento(LstrCentroCustoDefault) ;
end;

function TGeradorContabilCtp.fTrataCodigoEmpresa(
  const APagar: TContasPagar): string;
begin
  if (fCfgDesMva = 'S') and (not fEmptyStr(APagar.empresaCtpDet.strCodigo)) then
  begin
    result := APagar.empresaCtpDet.strCodigo ;
  end
  else
  begin
    result := APagar.empresaBaixa.strCodigo ;
  end;
end;

function TGeradorContabilCtp.fTrataNomeEmpresa(
  const APagar: TContasPagar): string;
begin
  if (fCfgDesMva = 'S') and (not fEmptyStr(APagar.empresaCtpDet.strCodigo)) then
  begin
    result := APagar.empresaCtpDet.strDescricao ;
  end
  else
  begin
    result := APagar.empresaBaixa.strDescricao ;
  end;
end;

procedure TGeradorContabilCtp.pAdicionaItemListError(const APagar: TContasPagar; const AParametro: TParametroContabil; const AstrMensagem, AstrTipoLancamento, AstrDescricaoValor: string);
var
  LdicDados : TDadosImportacaoContabil ;
begin
  if FlstControleError.IndexOf(APagar.strAutoincrem) < 0 then
  begin
    FlstControleError.Add(APagar.strAutoincrem) ;

    LdicDados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);
    LdicDados.strCtpInc := APagar.strAutoincrem;
    LdicDados.strTipoLancamento := AstrTipoLancamento;
    LdicDados.strDescricaoValor := AstrDescricaoValor;
    LdicDados.empresa := APagar.empresaBaixa;
    LdicDados.empresaCtpDet := APagar.empresaCtpDet;
    LdicDados.dtaLancamento := APagar.dtaDataPagamento;
    LdicDados.strHistorico := fRetHistorico(APagar, AParametro);
    LdicDados.strContaCredito := fRetContaCredito(APagar, AParametro);
    LdicDados.strContaDebito := fRetContaDebito(APagar, AParametro);
    LdicDados.strPagamento := APagar.strTipoPagamento;
    LdicDados.strMensagemUsuario := AstrMensagem ;
    ListaDadosImportacaoContabilError.Add(LdicDados) ;
  end ;
end;

function TGeradorContabilCtp.fTemFormaPagtoValida(const AstrFormaPagamento: String; const AlstParametrosContabil: TObjectList<TParametroContabil>; const AParametrosContabilAtual: TParametroContabil; const ADataRef: TDateTime): Boolean ;
var
  LParametrosContabil: TParametroContabil ;
  LblnTemFormaPagamentoEspecifica: Boolean ;
begin
  Result := False ;

  LblnTemFormaPagamentoEspecifica := False ;
  if AParametrosContabilAtual.strFormaPagamento = FPG_TODAS then
  begin
    for LParametrosContabil in AlstParametrosContabil do
    begin
      if (LParametrosContabil.strDescricaoValor = AParametrosContabilAtual.strDescricaoValor) and
         (LParametrosContabil.strDescricaoPagamento = AParametrosContabilAtual.strDescricaoPagamento) and
         (LParametrosContabil.blnPagamentoAntecipado = AParametrosContabilAtual.blnPagamentoAntecipado) and
         (LParametrosContabil.strFormaPagamento <> FPG_TODAS) and
         (LParametrosContabil.strFormaPagamento <> FPG_CREDITO) and
         (LParametrosContabil.strFormaPagamento = AstrFormaPagamento) and
         (LParametrosContabil.dtaVigenciaInicio <= ADataRef) and
         (LParametrosContabil.dtaVigenciaFinal >= ADataRef)  then
      begin
        LblnTemFormaPagamentoEspecifica := True ;
        break ;
      end ;
    end ;
  end ;

  if LblnTemFormaPagamentoEspecifica then
    exit ;

  result := (AstrFormaPagamento = AParametrosContabilAtual.strFormaPagamento) or (AParametrosContabilAtual.strFormaPagamento = FPG_TODAS) ;
end ;

function TGeradorContabilCtp.fAdicionaLancamentoBaixaEmpresaDiferente(var AdicDados: TDadosImportacaoContabil; const AcpPagar: TContasPagar): Boolean ;
var
  LdicDadosClonado: TDadosImportacaoContabil ;
begin
  Result := True ;
  if AcpPagar.LancamentoDuploEmpDif then
  begin
    if (AcpPagar.IsCtpDet) and (fCfgDesMva = 'S') then
    begin
      LdicDadosClonado := TDadosImportacaoContabil(AdicDados.Clone) ;
      /// empresa de cadastro
      AdicDados.empresa := AcpPagar.empresaCadastro;
      AdicDados.strContaDebito := ifThen(copy(AcpPagar.empresaBaixa.strC_G_C,1,8) = copy(AcpPagar.empresaCadastro.strC_G_C,1,8), AdicDados.strContaDebito, fPlanoContasEmprestimoEntreEmpresasAtivo) ;
      AdicDados.strContaCredito := ifThen(copy(AcpPagar.empresaBaixa.strC_G_C,1,8) = copy(AcpPagar.empresaCadastro.strC_G_C,1,8), fCfgRetornaContaContabilEmpresasDiferentesCTP, AdicDados.strContaCredito) ;
      AdicDados.blnParametrizouCredito := True ;
      AdicDados.blnLancamentoDuploEmpDif := AcpPagar.LancamentoDuploEmpDif ;
      listaDadosImportacaoContabil.Add(AdicDados);
    end
    else
    begin
      LdicDadosClonado := TDadosImportacaoContabil(AdicDados.Clone) ;
      //empresa de cadastro
      AdicDados.empresa := AcpPagar.empresaCadastro ;
      AdicDados.empresaCtpDet := AcpPagar.empresaCadastro ;
      AdicDados.strContaDebito := ifThen(copy(AcpPagar.empresaBaixa.strC_G_C,1,8) = copy(AcpPagar.empresaCadastro.strC_G_C,1,8), AdicDados.strContaDebito, fPlanoContasEmprestimoEntreEmpresasAtivo) ;
      AdicDados.strContaCredito := ifThen(copy(AcpPagar.empresaBaixa.strC_G_C,1,8) = copy(AcpPagar.empresaCadastro.strC_G_C,1,8), fCfgRetornaContaContabilEmpresasDiferentesCTP, AdicDados.strContaCredito) ;
      AdicDados.blnParametrizouCredito := True ;
      AdicDados.strOrigemCredito := 'Conta Crédito';
      AdicDados.blnLancamentoDuploEmpDif := AcpPagar.LancamentoDuploEmpDif ;
      listaDadosImportacaoContabil.Add(AdicDados);
    end ;
    //empresa de baixa
    LdicDadosClonado.empresa := AcpPagar.empresaCadastro ;
    LdicDadosClonado.empresaCtpDet := AcpPagar.empresaBaixa ;
    LdicDadosClonado.strContaCredito := ifThen(copy(AcpPagar.empresaBaixa.strC_G_C,1,8) = copy(AcpPagar.empresaCadastro.strC_G_C,1,8), LdicDadosClonado.strContaCredito, fPlanoContasEmprestimoEntreEmpresasPassivo) ;
    LdicDadosClonado.strContaDebito := ifThen(copy(AcpPagar.empresaBaixa.strC_G_C,1,8) = copy(AcpPagar.empresaCadastro.strC_G_C,1,8), fCfgRetornaContaContabilEmpresasDiferentesCTP, LdicDadosClonado.strContaDebito) ;
    LdicDadosClonado.blnParametrizouDebito := True ;
    LdicDadosClonado.blnLancamentoDuploEmpDif := AcpPagar.LancamentoDuploEmpDif ;
    listaDadosImportacaoContabil.Add(LdicDadosClonado);
    Exit ;
  end ;
  Result := False ;
end ;

procedure TGeradorContabilCtp.pAdicionaLista(
  var AdicDados: TDadosImportacaoContabil; const AcpPagar: TContasPagar);
begin
  if fAdicionaLancamentoBaixaEmpresaDiferente(AdicDados, AcpPagar) then
    Exit ;

  listaDadosImportacaoContabil.Add(AdicDados);
end;

procedure TGeradorContabilCtp.pAdicionarLancamento(pagar: TContasPagar;
                                                   parametro: TParametroContabil;
                                                   const ADescricaoValor: string;
                                                   const AValorLancamento: double;
                                                   var ctrlCtpParcon: TControleParConCtp;
                                                   const intControle: integer;
                                                   var blnFlagParcon: Boolean;
                                                   const AdtaLancamento: TDateTime;
                                                   const AstrTipoLancamento: String;
                                                   const AstrForPgo: string);
  var
    dados : TDadosImportacaoContabil;
    LTpOri: string;
    LCdOri: string;
begin
  if AValorLancamento <> 0 then
  begin
    if (parametro.strDescricaoValor = ADescricaoValor) then
    begin
      blnFlagParcon := True ;
      ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_TODAS, ADescricaoValor, pagar.strTipoPagamento, intControle, pagar, parametro);
      dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);
      dados.strSeqLan := '';
      dados.empresa := pagar.empresaBaixa;
      dados.empresaCtpDet := pagar.empresaCtpDet;
      dados.dtaLancamento := AdtaLancamento ;
      dados.strTipoLancamento := AstrTipoLancamento ;
      dados.strNumDoc         := pagar.strNumero;
      dados.strCfopConfig := '';
      dados.strNaturezaOperacao := '';
      dados.strDescricaoValor := ADescricaoValor;

      dados.strContaCredito := fRetContaCredito(pagar, parametro);
      pRetornaDadosOrigem(
        pagar,
        parametro,
        fOrigemCreditoEnum(parametro),
        tpcCredito,
        parametro.strBaixaCadastroCredito,
        pfpNaoEspecificado,
        LTpOri,
        LCdOri);
      dados.strTpOriC := LTpOri;
      dados.strCdOriC := LCdOri;
      dados.strOpBcCr := parametro.strBaixaCadastroCredito;

      dados.strContaDebito := fRetContaDebito(pagar, parametro);
      pRetornaDadosOrigem(
        pagar,
        parametro,
        fOrigemDebitoEnum(parametro),
        tpcDebito,
        parametro.strBaixaCadastroDebito,
        pfpNaoEspecificado,
        LTpOri,
        LCdOri);
      dados.strTpOriD := LTpOri;
      dados.strCdOriD := LCdOri;
      dados.strOpBcDb := parametro.strBaixaCadastroDebito;

      dados.strHistorico := fRetHistorico(pagar, parametro);
      dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
      dados.fltValorLancamento := AValorLancamento;
      dados.blnParametrizouCredito := parametro.fParametrizouCredito;
      dados.blnParametrizouDebito := parametro.fParametrizouDebito;
      dados.strCCusto := pagar.strCodEve;
      dados.strOrigemCredito := parametro.fOrigemCredito;
      dados.strOrigemDebito := parametro.fOrigemDebito;
      dados.strCtpInc := pagar.strAutoincrem;
      dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito);
      dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito);
      dados.strFormaPagamento := parametro.strFormaPagamento ;
      dados.strPagamento := pagar.strTipoPagamento;
      dados.blnIsCtpDet := pagar.IsCtpDet;
      dados.blnIsAgrup := pagar.strSerie = 'AG';
      dados.strCliFor := pagar.participante.strCodigo ;
      dados.strTip_fc := 'F' ;
      dados.strForPgo := parametro.strFormaPagamento;
      dados.strSeqPar := parametro.strSequenciaParametro;
      dados.strInvNco := 'N';
      listaDadosImportacaoContabil.Add(dados);
    end;
    ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_TODAS, ADescricaoValor, pagar.strTipoPagamento, intControle, pagar, parametro);
  end;
end;

procedure TGeradorContabilCtp.pAdicionarLancamentoDescontoTotal(const AModalidade, AValorLancamento: double; const ADescricaoValor, AFormaPagamento: string; const APagar: TContasPagar; const AParametro: TParametroContabil; var ctrlCtpParcon: TControleParConCtp; const intControle: integer; var blnFlagParcon:boolean);
  var
    dados : TDadosImportacaoContabil;
    LTpOri: string;
    LCdOri: string;
begin
  if (APagar.fltValorOriginal = AValorLancamento) and
     (APagar.fltValorPago = 0) and (AModalidade = 0) then
  begin
    if (AParametro.strDescricaoValor = ADescricaoValor) and (AParametro.strFormaPagamento = AFormaPagamento) then
    begin
      blnFlagParcon := True ;
      ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, AFormaPagamento, ADescricaoValor, APagar.strTipoPagamento, intControle, APagar, AParametro);
      dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);
      dados.strSeqLan := '';
      dados.empresa := APagar.empresaBaixa;
      dados.empresaCtpDet := Apagar.empresaCtpDet;
      dados.dtaLancamento := APagar.dtaDataPagamento;
      dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
      dados.strNumDoc         := Apagar.strNumero;
      dados.strCfopConfig := '';
      dados.strNaturezaOperacao := '';
      dados.strDescricaoValor := ADescricaoValor;

      dados.strContaCredito := fRetContaCredito(APagar, AParametro); //retorna a conta com base nas regras definidas no AParametro contabil
      pRetornaDadosOrigem(
        APagar,
        AParametro,
        fOrigemCreditoEnum(AParametro),
        tpcCredito,
        AParametro.strBaixaCadastroCredito,
        pfpNaoEspecificado,
        LTpOri,
        LCdOri);
      dados.strTpOriC := LTpOri;
      dados.strCdOriC := LCdOri;
      dados.strOpBcCr := AParametro.strBaixaCadastroCredito;

      dados.strContaDebito := fRetContaDebito(APagar, AParametro); //retorna a conta com base nas regras definidas no AParametro contabil
      pRetornaDadosOrigem(
        APagar,
        AParametro,
        fOrigemDebitoEnum(AParametro),
        tpcDebito,
        AParametro.strBaixaCadastroDebito,
        pfpNaoEspecificado,
        LTpOri,
        LCdOri);
      dados.strTpOriD := LTpOri;
      dados.strCdOriD := LCdOri;
      dados.strOpBcDb := AParametro.strBaixaCadastroDebito;

      dados.strHistorico := fRetHistorico(APagar, AParametro);
      dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(APagar, AParametro, dados.strTipoLancamento);
      dados.fltValorLancamento := abs(AValorLancamento);
      dados.blnParametrizouCredito := AParametro.fParametrizouCredito;
      dados.blnParametrizouDebito := AParametro.fParametrizouDebito;
      dados.strCCusto := APagar.strCodEve;
      dados.strOrigemCredito := AParametro.fOrigemCredito;
      dados.strOrigemDebito := AParametro.fOrigemDebito;
      dados.strCtpInc := APagar.strAutoincrem;
      dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(APagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito);
      dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(APagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito);
      dados.strFormaPagamento := AParametro.strFormaPagamento ;
      dados.strPagamento := APagar.strTipoPagamento;
      dados.blnIsCtpDet := Apagar.IsCtpDet;
      dados.blnIsAgrup := Apagar.strSerie = 'AG';
      dados.strCliFor := Apagar.participante.strCodigo ;
      dados.strTip_fc := 'F' ;
      dados.strForPgo := AParametro.strFormaPagamento;
      dados.strSeqPar := Aparametro.strSequenciaParametro;
      dados.strInvNco := 'N';
      listaDadosImportacaoContabil.Add(dados);
    end;
    ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, AFormaPagamento, ADescricaoValor, APagar.strTipoPagamento, intControle, APagar, AParametro);
  end;
end;

procedure TGeradorContabilCtp.pGerar;
  var
    dados: TDadosImportacaoContabil;
    parametro: TParametroContabil;
    pagar: TContasPagar;
    intContador : integer;
    blnFlagValorPago : boolean ;
    ctrlCtpParcon : TControleParConCtp ;
    intControle : integer ;
    lstPendencias : TStringList ;
    intCnt : integer ;
    blnFlagParcon : boolean ;
    LTpOri: string;
    LCdOri: string;
  procedure pIncrementaLoop;
  begin
    intContador := intContador + 1;
    if (Assigned(dadosAbertura.progresso)) then
      pRegistrarProgresso(dadosAbertura.progresso, 0, intContador, FListaPagamentos.Count);
  end;

begin
  intContador := 0;

  ctrlCtpParcon := TControleParConCtp.Create ;
  try
    intControle := 0 ;
    for pagar in FListaPagamentos do
    begin
      if Assigned(cdsCtpLancadosPeriodoFechado) and
         cdsCtpLancadosPeriodoFechado.FindKey([pagar.strAutoincrem]) then
      begin
        dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);
        dados.strCtpInc         := pagar.strAutoincrem;
        dados.empresa           := pagar.empresaBaixa;
        dados.empresaCtpDet     := pagar.empresaCtpDet;
        dados.dtaLancamento     := pagar.dtaDataPagamento;
        dados.fltValorLancamento:= pagar.fltValorOriginal;
        if listaParametrosContabil.Count > 0 then
          dados.strHistorico := fRetHistorico(pagar, listaParametrosContabil.Items[0]);

        dados.strMensagemUsuario := fNormalizaWarningGenerico('CTP',
                                                             'O título do Contas a Pagar, foi lançado originalmente na contabilidade no dia ' +
                                                              DateToStr(cdsCtpLancadosPeriodoFechado.FieldByName('CON_DTALAN').AsDateTime)  + '. ' +
                                                              'Para reprocessar esse título, o fechamento do período ' +
                                                              DateToStr(cdsCtpLancadosPeriodoFechado.FieldByName('CON_FECINI').AsDateTime) + ' a ' +
                                                              DateToStr(cdsCtpLancadosPeriodoFechado.FieldByName('CON_FECFIN').AsDateTime) + ' ' +
                                                              'para a empresa ' + cdsCtpLancadosPeriodoFechado.FieldByName('CON_CODEMP').AsString + ' deverá ser excluído!' );

        dados.strPagamento      := pagar.strTipoPagamento;
        dados.strTipoLancamento := 'CTP';
        dados.strNumDoc         := pagar.strNumero;
        ListaDadosImportacaoContabilError.Add(dados);
        Continue;
      end;

      if (pagar.strTipoPagamento <> 'Pagamentos Fatura') and (not pagar.portador.blnExportarPeloAutsi) then
      begin
        dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);
        dados.strCtpInc := pagar.strAutoincrem;
        dados.empresa := pagar.empresaBaixa;
        dados.empresaCtpDet := pagar.empresaCtpDet;
        dados.dtaLancamento := pagar.dtaDataPagamento;
        if listaParametrosContabil.Count > 0 then
          dados.strHistorico := fRetHistorico(pagar, listaParametrosContabil.Items[0]);
        dados.strMensagemUsuario := fNormalizaWarningGenerico('CTP', 'Portador com o código '+pagar.portador.strCodigo+', configurado para não exportar [Exportar pelo Autsi]!');
        dados.strPagamento := pagar.strTipoPagamento;
        dados.strTipoLancamento := 'CTP' ;
        dados.strNumDoc         := pagar.strNumero;
        ListaDadosImportacaoContabilWarning.Add(dados) ;
        Continue;
      end ;

      if not fEmptyStr(pagar.empresaCadastro.strCodigo) then
      begin
        if (copy(pagar.empresaBaixa.strC_G_C,1,8) <> copy(pagar.empresaCadastro.strC_G_C,1,8)) and (fEmptyStr(FstrContaEmprestimoAtivo)) then
        begin
          dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);
          dados.strCtpInc := pagar.strAutoincrem;
          dados.empresa := pagar.empresaBaixa;
          dados.empresaCtpDet := pagar.empresaCtpDet;
          dados.dtaLancamento := pagar.dtaDataPagamento;
          if listaParametrosContabil.Count > 0 then
            dados.strHistorico := fRetHistorico(pagar, listaParametrosContabil.Items[0]);
          dados.strMensagemUsuario := fNormalizaWarningGenerico('CTP', 'Divergência do CNPJ da emp. de baixa e cadastro, configure a [CFG_EMPATI]');
          dados.strPagamento := pagar.strTipoPagamento;
          dados.strTipoLancamento := 'CTP' ;
          dados.strNumDoc         := pagar.strNumero;
          ListaDadosImportacaoContabilError.Add(dados) ;
          continue ;
        end ;

        if (copy(pagar.empresaBaixa.strC_G_C,1,8) <> copy(pagar.empresaCadastro.strC_G_C,1,8)) and (fEmptyStr(FstrContaEmprestimoPassivo)) then
        begin
          dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);
          dados.strCtpInc := pagar.strAutoincrem;
          dados.empresa := pagar.empresaBaixa;
          dados.empresaCtpDet := pagar.empresaCtpDet;
          dados.dtaLancamento := pagar.dtaDataPagamento;
          if listaParametrosContabil.Count > 0 then
            dados.strHistorico := fRetHistorico(pagar, listaParametrosContabil.Items[0]);
          dados.strMensagemUsuario := fNormalizaWarningGenerico('CTP', 'Divergência do CNPJ da emp. de baixa e cadastro, configure a [CFG_EMPPAS]');
          dados.strPagamento := pagar.strTipoPagamento;
          dados.strTipoLancamento := 'CTP' ;
          dados.strNumDoc         := pagar.strNumero;
          ListaDadosImportacaoContabilError.Add(dados) ;
          continue ;
        end ;
      end ;

      blnFlagValorPago := True ;
      intControle := intControle + 1 ;
      blnFlagParcon := False ;
      for parametro in listaParametrosContabil do
      begin
        if (pagar.dtaDataPagamento < parametro.dtaVigenciaInicio) or (pagar.dtaDataPagamento > parametro.dtaVigenciaFinal) then
        begin
          pIncrementaLoop;
          Continue;
        end;

        if (dadosAbertura.blnParametrizouPagamentoAntecipadoAvulso) then
        begin
          if (pagar.strTipoPagamento = 'Pagamentos Avulsos') then
          begin
            if parametro.blnPagamentoAntecipado <> pagar.blnPagamentoAntecipado then
            begin
              pIncrementaLoop;
              Continue;
            end;
          end;
        end;

        if (dadosAbertura.blnParametrizouPagamentoAntecipadoFatura) then
        begin
          if (pagar.strTipoPagamento = 'Pagamentos Fatura') then
          begin
            if parametro.blnPagamentoAntecipado <> pagar.blnPagamentoAntecipado then
            begin
              pIncrementaLoop;
              Continue;
            end;
          end;
        end;

        if (parametro.strTipoLancamento = TIPO_CONTAS_PAGAR_PROVISAO) And
           (parametro.strDescricaoPagamento = pagar.strTipoPagamento) then
        begin

          if (pagar.fltValorOriginal > 0) then
          begin
            if (parametro.strFormaPagamento = FPG_TODAS) and
               (parametro.strDescricaoValor = DES_VALOR_ORIGINAL) then
            begin
              blnFlagParcon := True ;
              ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR_PROVISAO, FPG_TODAS, DES_VALOR_ORIGINAL, pagar.strTipoPagamento, intControle, pagar, parametro);
              dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

              dados.strSeqLan := '';
              dados.empresa := pagar.empresaBaixa;
              dados.empresaCtpDet := pagar.empresaCtpDet;
              dados.dtaLancamento := pagar.dtaDataCadastro;
              dados.strTipoLancamento := TIPO_CONTAS_PAGAR_PROVISAO;
              dados.strCfopConfig := '';
              dados.strNaturezaOperacao := '';
              dados.strDescricaoValor := DES_VALOR_ORIGINAL;

              dados.strContaCredito := fRetContaCredito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
              pRetornaDadosOrigem(
                pagar,
                parametro,
                fOrigemCreditoEnum(parametro),
                tpcCredito,
                parametro.strBaixaCadastroCredito,
                pfpNaoEspecificado,
                LTpOri,
                LCdOri);
              dados.strTpOriC := LTpOri;
              dados.strCdOriC := LCdOri;
              dados.strOpBcCr := parametro.strBaixaCadastroCredito;

              dados.strContaDebito := fRetContaDebito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
              pRetornaDadosOrigem(
                pagar,
                parametro,
                fOrigemDebitoEnum(parametro),
                tpcDebito,
                parametro.strBaixaCadastroDebito,
                pfpNaoEspecificado,
                LTpOri,
                LCdOri);
              dados.strTpOriD := LTpOri;
              dados.strCdOriD := LCdOri;
              dados.strOpBcDb := parametro.strBaixaCadastroDebito;
              dados.strNumDoc := pagar.strNumero;

              dados.strHistorico := fRetHistorico(pagar, parametro);
              dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
              dados.fltValorLancamento := pagar.fltValorOriginal;
              dados.blnParametrizouCredito := parametro.fParametrizouCredito;
              dados.blnParametrizouDebito := parametro.fParametrizouDebito;
              dados.strCCusto := pagar.strCodEve;
              dados.strOrigemCredito := parametro.fOrigemCredito;
              dados.strOrigemDebito := parametro.fOrigemDebito;
              dados.strCtpInc := pagar.strAutoincrem;
              dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito);
              dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito);
              dados.strFormaPagamento := parametro.strFormaPagamento ;
              dados.strPagamento := pagar.strTipoPagamento;
              dados.blnIsCtpDet := pagar.IsCtpDet;
              dados.blnIsAgrup := pagar.strSerie = 'AG';
              dados.strCliFor := pagar.participante.strCodigo ;
              dados.strTip_fc := 'F' ;
              dados.strForPgo := parametro.strFormaPagamento;
              dados.strSeqPar := parametro.strSequenciaParametro;
              dados.strInvNco := 'N';
              listaDadosImportacaoContabil.Add(dados);
            end;
            ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR_PROVISAO, FPG_TODAS, DES_VALOR_ORIGINAL, pagar.strTipoPagamento, intControle, pagar, parametro);
          end ;

          if (pagar.fltValorJuros > 0) then
          begin
            if   (parametro.strFormaPagamento = FPG_TODAS) and
                 (parametro.strDescricaoValor = DES_VALOR_JUROS) then
            begin
              blnFlagParcon := True ;
              ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR_PROVISAO, FPG_TODAS, DES_VALOR_JUROS, pagar.strTipoPagamento, intControle, pagar, parametro);
              dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

              dados.strSeqLan := '';
              dados.empresa := pagar.empresaBaixa;
              dados.empresaCtpDet := pagar.empresaCtpDet;
              dados.dtaLancamento := pagar.dtaDataCadastro;
              dados.strTipoLancamento := TIPO_CONTAS_PAGAR_PROVISAO;
              dados.strCfopConfig := '';
              dados.strNaturezaOperacao := '';
              dados.strDescricaoValor := DES_VALOR_JUROS;

              dados.strContaCredito := fRetContaCredito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
              pRetornaDadosOrigem(
                pagar,
                parametro,
                fOrigemCreditoEnum(parametro),
                tpcCredito,
                parametro.strBaixaCadastroCredito,
                pfpNaoEspecificado,
                LTpOri,
                LCdOri);
              dados.strTpOriC := LTpOri;
              dados.strCdOriC := LCdOri;
              dados.strOpBcCr := parametro.strBaixaCadastroCredito;

              dados.strContaDebito := fRetContaDebito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
              pRetornaDadosOrigem(
                pagar,
                parametro,
                fOrigemDebitoEnum(parametro),
                tpcDebito,
                parametro.strBaixaCadastroDebito,
                pfpNaoEspecificado,
                LTpOri,
                LCdOri);
              dados.strTpOriD := LTpOri;
              dados.strCdOriD := LCdOri;
              dados.strOpBcDb := parametro.strBaixaCadastroDebito;
              dados.strNumDoc := pagar.strNumero;

              dados.strHistorico := fRetHistorico(pagar, parametro);
              dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
              dados.fltValorLancamento := pagar.fltValorJuros;
              dados.blnParametrizouCredito := parametro.fParametrizouCredito;
              dados.blnParametrizouDebito := parametro.fParametrizouDebito;
              dados.strCCusto := fRetornaEventoDescontoJuros(pagar.strCodEve, dados.strDescricaoValor) ;
              dados.strOrigemCredito := parametro.fOrigemCredito;
              dados.strOrigemDebito := parametro.fOrigemDebito;
              dados.strCtpInc := pagar.strAutoincrem;
              dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito);
              dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito);
              dados.strFormaPagamento := parametro.strFormaPagamento ;
              dados.strPagamento := pagar.strTipoPagamento;
              dados.blnIsCtpDet := pagar.IsCtpDet;
              dados.blnIsAgrup := pagar.strSerie = 'AG';
              dados.strCliFor := pagar.participante.strCodigo ;
              dados.strTip_fc := 'F' ;
              dados.strForPgo := parametro.strFormaPagamento;
              dados.strSeqPar := parametro.strSequenciaParametro;
              dados.strInvNco := 'N';
              listaDadosImportacaoContabil.Add(dados);
            end;
            ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR_PROVISAO, FPG_TODAS, DES_VALOR_JUROS, pagar.strTipoPagamento, intControle, pagar, parametro);
          end ;

          if parametro.strFormaPagamento = FPG_TODAS then
            pAdicionarLancamento(pagar, parametro, DES_VALOR_MULTA, pagar.fltValorMulta, ctrlCtpParcon, intControle, blnFlagParcon, pagar.dtaDataPagamento, TIPO_CONTAS_PAGAR_PROVISAO, parametro.strFormaPagamento);

          if (pagar.fltValorDesconto > 0) then
          begin
            if (parametro.strFormaPagamento = FPG_TODAS) and
               (parametro.strDescricaoValor = DES_VALOR_DESCONTO) then
            begin
              blnFlagParcon := True ;
              ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR_PROVISAO, FPG_TODAS, DES_VALOR_DESCONTO, pagar.strTipoPagamento, intControle, pagar, parametro);
              dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

              dados.strSeqLan := '';
              dados.empresa := pagar.empresaBaixa;
              dados.empresaCtpDet := pagar.empresaCtpDet;
              dados.dtaLancamento := pagar.dtaDataCadastro;
              dados.strTipoLancamento := TIPO_CONTAS_PAGAR_PROVISAO;
              dados.strCfopConfig := '';
              dados.strNaturezaOperacao := '';
              dados.strDescricaoValor := DES_VALOR_DESCONTO;

              dados.strContaCredito := fRetContaCredito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
              pRetornaDadosOrigem(
                pagar,
                parametro,
                fOrigemCreditoEnum(parametro),
                tpcCredito,
                parametro.strBaixaCadastroCredito,
                pfpNaoEspecificado,
                LTpOri,
                LCdOri);
              dados.strTpOriC := LTpOri;
              dados.strCdOriC := LCdOri;
              dados.strOpBcCr := parametro.strBaixaCadastroCredito;
              dados.strNumDoc := pagar.strNumero;

              dados.strContaDebito := fRetContaDebito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
              pRetornaDadosOrigem(
                pagar,
                parametro,
                fOrigemDebitoEnum(parametro),
                tpcDebito,
                parametro.strBaixaCadastroDebito,
                pfpNaoEspecificado,
                LTpOri,
                LCdOri);
              dados.strTpOriD := LTpOri;
              dados.strCdOriD := LCdOri;
              dados.strOpBcDb := parametro.strBaixaCadastroDebito;

              dados.strHistorico := fRetHistorico(pagar, parametro);
              dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
              dados.fltValorLancamento := pagar.fltValorDesconto;
              dados.blnParametrizouCredito := parametro.fParametrizouCredito;
              dados.blnParametrizouDebito := parametro.fParametrizouDebito;
              dados.strCCusto := fRetornaEventoDescontoJuros(pagar.strCodEve, dados.strDescricaoValor);
              dados.strOrigemCredito := parametro.fOrigemCredito;
              dados.strOrigemDebito := parametro.fOrigemDebito;
              dados.strCtpInc := pagar.strAutoincrem;
              dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito);
              dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito);
              dados.strFormaPagamento := parametro.strFormaPagamento ;
              dados.strPagamento := pagar.strTipoPagamento;
              dados.blnIsCtpDet := pagar.IsCtpDet;
              dados.blnIsAgrup := pagar.strSerie = 'AG';
              dados.strCliFor := pagar.participante.strCodigo ;
              dados.strTip_fc := 'F' ;
              dados.strForPgo := parametro.strFormaPagamento;
              dados.strSeqPar := parametro.strSequenciaParametro;
              dados.strInvNco := 'N';
              listaDadosImportacaoContabil.Add(dados);
            end;
            ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR_PROVISAO, FPG_TODAS, DES_VALOR_DESCONTO, pagar.strTipoPagamento, intControle, pagar, parametro);
          end ;
        end
        //se for pago
        else if (parametro.strTipoLancamento = TIPO_CONTAS_PAGAR) And
                (parametro.strDescricaoPagamento = pagar.strTipoPagamento) then
        begin
          if fFormataFloat(Pagar.fltValorOriginal, 2) > 0 then
            pAdicionarLancamentoDescontoTotal(pagar.fltValorDinheiro, pagar.fltValorDesconto, DES_VALOR_ORIGINAL, FPG_DESCONTO_TOTAL, pagar, parametro, ctrlCtpParcon, intControle, blnFlagParcon)
          else if fFormataFloat(Pagar.fltValorOriginal, 2) < 0 then
            pAdicionarLancamentoDescontoTotal(pagar.fltValorDinheiro, abs(pagar.fltValorJuros)*-1, DES_VALOR_ORIGINAL, FPG_DESCONTO_TOTAL_CREDITO, pagar, parametro, ctrlCtpParcon, intControle, blnFlagParcon) ;

          if (pagar.blnPagamentoAntecipado) and (parametro.blnPagamentoAntecipado) then
          begin
            pAdicionarLancamento(pagar, parametro, DES_VALOR_PAGO, pagar.fltValorPago, ctrlCtpParcon, intControle, blnFlagParcon, pagar.dtaDataPagamento, TIPO_CONTAS_PAGAR, FPG_ADIANTAMENTO);
            pAdicionarLancamento(pagar, parametro, DES_VALOR_JUROS, pagar.fltValorJuros, ctrlCtpParcon, intControle, blnFlagParcon, pagar.dtaDataPagamento, TIPO_CONTAS_PAGAR, FPG_ADIANTAMENTO);
            pAdicionarLancamento(pagar, parametro, DES_VALOR_MULTA, pagar.fltValorMulta, ctrlCtpParcon, intControle, blnFlagParcon, pagar.dtaDataPagamento, TIPO_CONTAS_PAGAR, FPG_ADIANTAMENTO);
            pAdicionarLancamento(pagar, parametro, DES_VALOR_VENDOR, pagar.fltValorVendor, ctrlCtpParcon, intControle, blnFlagParcon, pagar.dtaDataPagamento, TIPO_CONTAS_PAGAR, FPG_ADIANTAMENTO);
            pAdicionarLancamento(pagar, parametro, DES_VALOR_ORIGINAL, pagar.fltValorOriginal, ctrlCtpParcon, intControle, blnFlagParcon, pagar.dtaDataPagamento, TIPO_CONTAS_PAGAR, FPG_ADIANTAMENTO);
            pAdicionarLancamento(pagar, parametro, DES_VALOR_DESCONTO, pagar.fltValorDesconto, ctrlCtpParcon, intControle, blnFlagParcon, pagar.dtaDataPagamento, TIPO_CONTAS_PAGAR, FPG_ADIANTAMENTO);
            pIncrementaLoop;
            Continue;
          end;

          ///garantia
          if pagar.strTipCtp = TIP_GARANTIA then
          begin
            if parametro.strFormaPagamento = FPG_GARANTIA then
            begin
              if parametro.strDescricaoValor = DES_VALOR_PAGO then
              begin
                blnFlagParcon := True ;
                ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_GARANTIA, DES_VALOR_PAGO, pagar.strTipoPagamento, intControle, pagar, parametro);
                dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                dados.strSeqLan := '';
                dados.empresa := pagar.empresaBaixa;
                dados.empresaCtpDet := pagar.empresaCtpDet;
                dados.dtaLancamento := pagar.dtaDataPagamento;
                dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                dados.strCfopConfig := '';
                dados.strNaturezaOperacao := '';
                dados.strDescricaoValor := DES_VALOR_PAGO;
                /// inverte a conta
                if pagar.fltValorOriginal < 0 then
                begin
                  dados.strContaDebito := fRetContaCredito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemCreditoEnum(parametro),
                    tpcCredito,
                    parametro.strBaixaCadastroCredito,
                    pfpNaoEspecificado,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriD := LTpOri;
                  dados.strCdOriD := LCdOri;
                  dados.strOpBcDb := parametro.strBaixaCadastroCredito;
                  dados.strNumDoc := pagar.strNumero;

                  dados.strContaCredito := fRetContaDebito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemDebitoEnum(parametro),
                    tpcDebito,
                    parametro.strBaixaCadastroDebito,
                    pfpNaoEspecificado,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriC := LTpOri;
                  dados.strCdOriC := LCdOri;
                  dados.strOpBcCr := parametro.strBaixaCadastroDebito;

                  dados.blnParametrizouDebito := parametro.fParametrizouCredito;
                  dados.blnParametrizouCredito := parametro.fParametrizouDebito;
                  dados.strOrigemDebito := parametro.fOrigemCredito;
                  dados.strOrigemCredito := parametro.fOrigemDebito;
                  dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito);
                  dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito);
                  dados.strInvNco := 'S';
                end
                else
                begin
                  dados.strContaCredito := fRetContaCredito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemCreditoEnum(parametro),
                    tpcCredito,
                    parametro.strBaixaCadastroCredito,
                    pfpNaoEspecificado,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriC := LTpOri;
                  dados.strCdOriC := LCdOri;
                  dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                  dados.strContaDebito := fRetContaDebito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemDebitoEnum(parametro),
                    tpcDebito,
                    parametro.strBaixaCadastroDebito,
                    pfpNaoEspecificado,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriD := LTpOri;
                  dados.strCdOriD := LCdOri;
                  dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                  dados.strNumDoc := pagar.strNumero;

                  dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                  dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                  dados.strOrigemCredito := parametro.fOrigemCredito;
                  dados.strOrigemDebito := parametro.fOrigemDebito;
                  dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito);
                  dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito);
                  dados.strInvNco := 'N';
                end ;
                dados.strHistorico := fRetHistorico(pagar, parametro);
                dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                dados.fltValorLancamento := abs(pagar.fltValorPago);
                dados.strCCusto := pagar.strCodEve;
                dados.strCtpInc := pagar.strAutoincrem;
                dados.strFormaPagamento := parametro.strFormaPagamento ;
                dados.strPagamento := pagar.strTipoPagamento;
                dados.blnIsCtpDet := pagar.IsCtpDet;
                dados.blnIsAgrup := pagar.strSerie = 'AG';
                dados.strCliFor := pagar.participante.strCodigo ;
                dados.strTip_fc := 'F' ;
                dados.strForPgo := parametro.strFormaPagamento;
                dados.strSeqPar := parametro.strSequenciaParametro;
                listaDadosImportacaoContabil.Add(dados);
              end ;
              if parametro.strDescricaoValor = DES_VALOR_ORIGINAL then
              begin
                blnFlagParcon := True ;
                ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_GARANTIA, DES_VALOR_ORIGINAL, pagar.strTipoPagamento, intControle, pagar, parametro);
                dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                dados.strSeqLan := '';
                dados.empresa := pagar.empresaBaixa;
                dados.empresaCtpDet := pagar.empresaCtpDet;
                dados.dtaLancamento := pagar.dtaDataPagamento;
                dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                dados.strCfopConfig := '';
                dados.strNaturezaOperacao := '';
                dados.strDescricaoValor := DES_VALOR_ORIGINAL;
                /// inverte a conta
                if pagar.fltValorOriginal < 0 then
                begin
                  dados.strContaDebito := fRetContaCredito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemCreditoEnum(parametro),
                    tpcCredito,
                    parametro.strBaixaCadastroCredito,
                    pfpNaoEspecificado,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriD := LTpOri;
                  dados.strCdOriD := LCdOri;
                  dados.strOpBcDb := parametro.strBaixaCadastroCredito;
                  dados.strNumDoc := pagar.strNumero;

                  dados.strContaCredito := fRetContaDebito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemDebitoEnum(parametro),
                    tpcDebito,
                    parametro.strBaixaCadastroDebito,
                    pfpNaoEspecificado,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriC := LTpOri;
                  dados.strCdOriC := LCdOri;
                  dados.strOpBcCr := parametro.strBaixaCadastroDebito;

                  dados.blnParametrizouDebito := parametro.fParametrizouCredito;
                  dados.blnParametrizouCredito := parametro.fParametrizouDebito;
                  dados.strOrigemDebito := parametro.fOrigemCredito;
                  dados.strOrigemCredito := parametro.fOrigemDebito;
                  dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito);
                  dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito);
                  dados.strInvNco := 'S';
                end
                else
                begin
                  dados.strContaCredito := fRetContaCredito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemCreditoEnum(parametro),
                    tpcCredito,
                    parametro.strBaixaCadastroCredito,
                    pfpNaoEspecificado,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriC := LTpOri;
                  dados.strCdOriC := LCdOri;
                  dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                  dados.strContaDebito := fRetContaDebito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemDebitoEnum(parametro),
                    tpcDebito,
                    parametro.strBaixaCadastroDebito,
                    pfpNaoEspecificado,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriD := LTpOri;
                  dados.strCdOriD := LCdOri;
                  dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                  dados.strNumDoc := pagar.strNumero;

                  dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                  dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                  dados.strOrigemCredito := parametro.fOrigemCredito;
                  dados.strOrigemDebito := parametro.fOrigemDebito;
                  dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito);
                  dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito);
                  dados.strInvNco := 'N';
                end ;
                dados.strHistorico := fRetHistorico(pagar, parametro);
                dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                dados.fltValorLancamento := abs(pagar.fltValorOriginal);
                dados.strCCusto := pagar.strCodEve;
                dados.strCtpInc := pagar.strAutoincrem;
                dados.strFormaPagamento := parametro.strFormaPagamento ;
                dados.strPagamento := pagar.strTipoPagamento;
                dados.blnIsCtpDet := pagar.IsCtpDet;
                dados.blnIsAgrup := pagar.strSerie = 'AG';
                dados.strCliFor := pagar.participante.strCodigo ;
                dados.strTip_fc := 'F' ;
                dados.strForPgo := parametro.strFormaPagamento;
                dados.strSeqPar := parametro.strSequenciaParametro;
                listaDadosImportacaoContabil.Add(dados);
              end ;

              if pagar.fltValorJuros > 0 then
              begin
                if (parametro.strDescricaoValor = DES_VALOR_JUROS) then
                begin
                  blnFlagParcon := True ;
                  ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_GARANTIA, DES_VALOR_JUROS, pagar.strTipoPagamento, intControle, pagar, parametro);
                  dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                  dados.strSeqLan := '';
                  dados.empresa := pagar.empresaBaixa;
                  dados.empresaCtpDet := pagar.empresaCtpDet;
                  dados.dtaLancamento := pagar.dtaDataPagamento;
                  dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                  dados.strCfopConfig := '';
                  dados.strNaturezaOperacao := '';
                  dados.strDescricaoValor := DES_VALOR_JUROS;

                  dados.strContaCredito := fRetContaCredito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemCreditoEnum(parametro),
                    tpcCredito,
                    parametro.strBaixaCadastroCredito,
                    pfpNaoEspecificado,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriC := LTpOri;
                  dados.strCdOriC := LCdOri;
                  dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                  dados.strContaDebito := fRetContaDebito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemDebitoEnum(parametro),
                    tpcDebito,
                    parametro.strBaixaCadastroDebito,
                    pfpNaoEspecificado,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriD := LTpOri;
                  dados.strCdOriD := LCdOri;
                  dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                  dados.strNumDoc := pagar.strNumero;

                  dados.strHistorico := fRetHistorico(pagar, parametro);
                  dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                  dados.fltValorLancamento := pagar.fltValorJuros;
                  dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                  dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                  dados.strCCusto := fRetornaEventoDescontoJuros(pagar.strCodEve, dados.strDescricaoValor) ;
                  dados.strOrigemCredito := parametro.fOrigemCredito;
                  dados.strOrigemDebito := parametro.fOrigemDebito;
                  dados.strCtpInc := pagar.strAutoincrem;
                  dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito);
                  dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito);
                  dados.strFormaPagamento := parametro.strFormaPagamento ;
                  dados.strPagamento := pagar.strTipoPagamento;
                  dados.blnIsCtpDet := pagar.IsCtpDet;
                  dados.blnIsAgrup := pagar.strSerie = 'AG';
                  dados.strCliFor := pagar.participante.strCodigo ;
                  dados.strTip_fc := 'F' ;
                  dados.strForPgo := parametro.strFormaPagamento;
                  dados.strSeqPar := parametro.strSequenciaParametro;
                  dados.strInvNco := 'N';
                  listaDadosImportacaoContabil.Add(dados);
                end;
                ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_GARANTIA, DES_VALOR_JUROS, pagar.strTipoPagamento, intControle, pagar, parametro);
              end ;

              pAdicionarLancamento(pagar, parametro, DES_VALOR_MULTA, pagar.fltValorMulta, ctrlCtpParcon, intControle, blnFlagParcon, pagar.dtaDataPagamento, TIPO_CONTAS_PAGAR, FPG_GARANTIA);
              pAdicionarLancamento(pagar, parametro, DES_VALOR_VENDOR, pagar.fltValorVendor, ctrlCtpParcon, intControle, blnFlagParcon, pagar.dtaDataPagamento, TIPO_CONTAS_PAGAR, FPG_GARANTIA);

              if pagar.fltValorDesconto > 0 then
              begin
                if (parametro.strDescricaoValor = DES_VALOR_DESCONTO) then
                begin
                  blnFlagParcon := True ;
                  ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_GARANTIA, DES_VALOR_DESCONTO, pagar.strTipoPagamento, intControle, pagar, parametro);
                  dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                  dados.strSeqLan := '';
                  dados.empresa := pagar.empresaBaixa;
                  dados.empresaCtpDet := pagar.empresaCtpDet;
                  dados.dtaLancamento := pagar.dtaDataPagamento;
                  dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                  dados.strCfopConfig := '';
                  dados.strNaturezaOperacao := '';
                  dados.strDescricaoValor := DES_VALOR_DESCONTO;

                  dados.strContaCredito := fRetContaCredito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemCreditoEnum(parametro),
                    tpcCredito,
                    parametro.strBaixaCadastroCredito,
                    pfpNaoEspecificado,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriC := LTpOri;
                  dados.strCdOriC := LCdOri;
                  dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                  dados.strContaDebito := fRetContaDebito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemDebitoEnum(parametro),
                    tpcDebito,
                    parametro.strBaixaCadastroDebito,
                    pfpNaoEspecificado,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriD := LTpOri;
                  dados.strCdOriD := LCdOri;
                  dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                  dados.strNumDoc := pagar.strNumero;

                  dados.strHistorico := fRetHistorico(pagar, parametro);
                  dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                  dados.fltValorLancamento := pagar.fltValorDesconto;
                  dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                  dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                  dados.strCCusto := fRetornaEventoDescontoJuros(pagar.strCodEve, dados.strDescricaoValor) ;
                  dados.strOrigemCredito := parametro.fOrigemCredito;
                  dados.strOrigemDebito := parametro.fOrigemDebito;
                  dados.strCtpInc := pagar.strAutoincrem;
                  dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito);
                  dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito);
                  dados.strFormaPagamento := parametro.strFormaPagamento ;
                  dados.strPagamento := pagar.strTipoPagamento;
                  dados.blnIsCtpDet := pagar.IsCtpDet;
                  dados.blnIsAgrup := pagar.strSerie = 'AG';
                  dados.strCliFor := pagar.participante.strCodigo ;
                  dados.strTip_fc := 'F' ;
                  dados.strForPgo := parametro.strFormaPagamento;
                  dados.strSeqPar := parametro.strSequenciaParametro;
                  dados.strInvNco := 'N';
                  listaDadosImportacaoContabil.Add(dados);
                end;
                ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_GARANTIA, DES_VALOR_DESCONTO, pagar.strTipoPagamento, intControle, pagar, parametro);
              end ;

            end ;
            pIncrementaLoop;
            Continue;
          end ;

          // PAGAMENTO DE CONTAS A PAGAR ("CTP") SEM A ESPECIFICAÇÃO DO TIPO DE PAGAMENTO ("DINHEIRO", "CHEQUE", "CARTÃO", "ORD.PAGTO") //
          // REALIZA O LANÇAMENTO COMO DINHEIRO, OBSERVANDO O CAMPO CTR_VALPAG.                                                         //

          if (pagar.fltValorPago > 0) and
             ((pagar.fltValorDinheiro=0) And (pagar.fltValorChequePre=0) And (pagar.fltValorChequeVista=0) And (pagar.fltValorCartao=0) And (pagar.fltValorOrdemPagamento=0)) and
             (blnFlagValorPago) and (parametro.strFormaPagamento <> FPG_CREDITO) and (parametro.strDescricaoValor = DES_VALOR_PAGO) Then
          begin
            blnFlagValorPago := False ;
            dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);
            blnFlagParcon := True ;
            dados.strSeqLan := '';
            dados.empresa := pagar.empresaBaixa;
            dados.empresaCtpDet := pagar.empresaCtpDet;
            dados.dtaLancamento := pagar.dtaDataPagamento;
            dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
            dados.strCfopConfig := '';
            dados.strNaturezaOperacao := '';
            dados.strDescricaoValor := DES_VALOR_PAGO;

            dados.strContaCredito := fRetContaCredito(pagar, parametro);
            pRetornaDadosOrigem(
                pagar,
                parametro,
                fOrigemCreditoEnum(parametro),
                tpcCredito,
                parametro.strBaixaCadastroCredito,
                pfpNaoEspecificado,
                LTpOri,
                LCdOri);
              dados.strTpOriC := LTpOri;
              dados.strCdOriC := LCdOri;
              dados.strOpBcCr := parametro.strBaixaCadastroCredito;

            dados.strContaDebito := fRetContaDebito(pagar, parametro);
            pRetornaDadosOrigem(
                pagar,
                parametro,
                fOrigemDebitoEnum(parametro),
                tpcDebito,
                parametro.strBaixaCadastroDebito,
                pfpNaoEspecificado,
                LTpOri,
                LCdOri);
              dados.strTpOriD := LTpOri;
              dados.strCdOriD := LCdOri;
              dados.strOpBcDb := parametro.strBaixaCadastroDebito;
              dados.strNumDoc := pagar.strNumero;

            dados.strHistorico := fRetHistorico(pagar, parametro);
            dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
            dados.fltValorLancamento := pagar.fltValorPago;
            dados.blnParametrizouCredito := parametro.fParametrizouCredito;
            dados.blnParametrizouDebito := parametro.fParametrizouDebito;
            dados.strCCusto := pagar.strCodEve;
            dados.strOrigemCredito := parametro.fOrigemCredito;
            dados.strOrigemDebito := parametro.fOrigemDebito;
            dados.strCtpInc := pagar.strAutoincrem;
            dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito);
            dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito);
            dados.strFormaPagamento := parametro.strFormaPagamento ;
            dados.strPagamento := pagar.strTipoPagamento;
            dados.blnIsCtpDet := pagar.IsCtpDet;
            dados.blnIsAgrup := pagar.strSerie = 'AG';
            dados.strCliFor := pagar.participante.strCodigo ;
            dados.strTip_fc := 'F' ;
            dados.strForPgo := parametro.strFormaPagamento;
            dados.strSeqPar := parametro.strSequenciaParametro;
            dados.strInvNco := 'N';
            listaDadosImportacaoContabil.Add(dados);

          end;

          if (pagar.fltValorPago > 0)
              and (parametro.strDescricaoValor = DES_VALOR_ORIGINAL)
              and (pagar.strTipCtp <> TIP_GARANTIA)
              and ((pagar.fltValorDinheiro=0) And (pagar.fltValorChequePre=0) And (pagar.fltValorChequeVista=0) And (pagar.fltValorCartao=0) And (pagar.fltValorOrdemPagamento=0)) then
          begin
            pAdicionaItemListError(pagar, parametro, 'Título sem forma de pagamento preenchido', TIPO_CONTAS_PAGAR, DES_VALOR_ORIGINAL) ;
          end ;

          //DINHEIRO
          if (pagar.fltValorDinheiro > 0) then
          begin
            if fTemFormaPagtoValida(FPG_DINHEIRO, listaParametrosContabil, parametro, pagar.dtaDataPagamento) then
            begin
              //se for Vr.pago
              if (parametro.strDescricaoValor = DES_VALOR_PAGO) and (not pagar.blnDescJurAjustado) then
              begin
                blnFlagParcon := True ;
                ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_DINHEIRO, DES_VALOR_PAGO, pagar.strTipoPagamento, intControle, pagar, parametro);
                dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                dados.strSeqLan := '';
                dados.empresa := pagar.empresaBaixa;
                dados.empresaCtpDet := pagar.empresaCtpDet;
                dados.dtaLancamento := pagar.dtaDataPagamento;
                dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                dados.strCfopConfig := '';
                dados.strNaturezaOperacao := '';
                dados.strDescricaoValor := DES_VALOR_PAGO;

                dados.strContaCredito := fRetContaCredito(pagar, parametro, pfpDinheiro); //retorna a conta com base nas regras definidas no parametro contabil
                pRetornaDadosOrigem(
                  pagar,
                  parametro,
                  fOrigemCreditoEnum(parametro),
                  tpcCredito,
                  parametro.strBaixaCadastroCredito,
                  pfpDinheiro,
                  LTpOri,
                  LCdOri);
                dados.strTpOriC := LTpOri;
                dados.strCdOriC := LCdOri;
                dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                dados.strContaDebito := fRetContaDebito(pagar, parametro, pfpDinheiro); //retorna a conta com base nas regras definidas no parametro contabil
                pRetornaDadosOrigem(
                  pagar,
                  parametro,
                  fOrigemDebitoEnum(parametro),
                  tpcDebito,
                  parametro.strBaixaCadastroDebito,
                  pfpDinheiro,
                  LTpOri,
                  LCdOri);
                dados.strTpOriD := LTpOri;
                dados.strCdOriD := LCdOri;
                dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                dados.strNumDoc := pagar.strNumero;

                dados.strHistorico := fRetHistorico(pagar, parametro);
                dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                dados.fltValorLancamento := pagar.fltValorDinheiro;
                dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                dados.strCCusto := pagar.strCodEve;
                dados.strOrigemCredito := parametro.fOrigemCredito;
                dados.strOrigemDebito := parametro.fOrigemDebito;
                dados.strCtpInc := pagar.strAutoincrem;
                dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito, pfpDinheiro);
                dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito, pfpDinheiro);
                dados.strFormaPagamento := parametro.strFormaPagamento ;
                dados.strPagamento := pagar.strTipoPagamento;
                dados.blnIsCtpDet := pagar.IsCtpDet;
                dados.blnIsAgrup := pagar.strSerie = 'AG';
                dados.strCliFor := pagar.participante.strCodigo ;
                dados.strTip_fc := 'F' ;
                dados.strForPgo := parametro.strFormaPagamento;
                dados.strSeqPar := parametro.strSequenciaParametro;
                dados.strInvNco := 'N';
                pAdicionaLista(dados, pagar) ;
              end;

              //se for Vr.Juros
              if (pagar.fltValorDinheiro > 0) and (pagar.fltValorJuros > 0) then
              begin
                if (parametro.strDescricaoValor = DES_VALOR_JUROS) then
                begin
                  blnFlagParcon := True ;
                  ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_TODAS, DES_VALOR_JUROS, pagar.strTipoPagamento, intControle, pagar, parametro);
                  dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                  dados.strSeqLan := '';
                  dados.empresa := pagar.empresaBaixa;
                  dados.empresaCtpDet := pagar.empresaCtpDet;
                  dados.dtaLancamento := pagar.dtaDataPagamento;
                  dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                  dados.strCfopConfig := '';
                  dados.strNaturezaOperacao := '';
                  dados.strDescricaoValor := DES_VALOR_JUROS;

                  dados.strContaCredito := fRetContaCredito(pagar, parametro, pfpDinheiro); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemCreditoEnum(parametro),
                    tpcCredito,
                    parametro.strBaixaCadastroCredito,
                    pfpDinheiro,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriC := LTpOri;
                  dados.strCdOriC := LCdOri;
                  dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                  dados.strContaDebito := fRetContaDebito(pagar, parametro, pfpDinheiro); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemDebitoEnum(parametro),
                    tpcDebito,
                    parametro.strBaixaCadastroDebito,
                    pfpDinheiro,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriD := LTpOri;
                  dados.strCdOriD := LCdOri;
                  dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                  dados.strNumDoc := pagar.strNumero;

                  dados.strHistorico := fRetHistorico(pagar, parametro);
                  dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                  dados.fltValorLancamento := (pagar.fltValorDinheiro / pagar.fltValorPago) * pagar.fltValorJuros;
                  dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                  dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                  dados.strCCusto := fRetornaEventoDescontoJuros(pagar.strCodEve, dados.strDescricaoValor) ;
                  dados.strOrigemCredito := parametro.fOrigemCredito;
                  dados.strOrigemDebito := parametro.fOrigemDebito;
                  dados.strCtpInc := pagar.strAutoincrem;
                  dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito, pfpDinheiro);
                  dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito, pfpDinheiro);
                  dados.strFormaPagamento := parametro.strFormaPagamento ;
                  dados.strPagamento := pagar.strTipoPagamento;
                  dados.blnIsCtpDet := pagar.IsCtpDet;
                  dados.blnIsAgrup := pagar.strSerie = 'AG';
                  dados.strCliFor := pagar.participante.strCodigo ;
                  dados.strTip_fc := 'F' ;
                  dados.strForPgo := parametro.strFormaPagamento;
                  dados.strSeqPar := parametro.strSequenciaParametro;
                  dados.strInvNco := 'N';
                  pAdicionaLista(dados, pagar) ;
                end;
                ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_TODAS, DES_VALOR_JUROS, pagar.strTipoPagamento, intControle, pagar, parametro);
              end ;

              pAdicionarLancamento(pagar, parametro, DES_VALOR_MULTA, (pagar.fltValorDinheiro / pagar.fltValorPago) * pagar.fltValorMulta, ctrlCtpParcon, intControle, blnFlagParcon, pagar.dtaDataPagamento, TIPO_CONTAS_PAGAR, FPG_DINHEIRO);
              pAdicionarLancamento(pagar, parametro, DES_VALOR_VENDOR, (pagar.fltValorDinheiro / pagar.fltValorPago) * pagar.fltValorVendor, ctrlCtpParcon, intControle, blnFlagParcon, pagar.dtaDataPagamento, TIPO_CONTAS_PAGAR, FPG_DINHEIRO);

              If (pagar.fltValorDinheiro > 0) And (parametro.strDescricaoValor = DES_VALOR_ORIGINAL) Then
              Begin
                blnFlagParcon := True ;
                ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_DINHEIRO, DES_VALOR_ORIGINAL, pagar.strTipoPagamento, intControle, pagar, parametro);
                dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                dados.strSeqLan := '';
                dados.empresa := pagar.empresaBaixa;
                dados.empresaCtpDet := pagar.empresaCtpDet;
                dados.dtaLancamento := pagar.dtaDataPagamento;
                dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                dados.strCfopConfig := '';
                dados.strNaturezaOperacao := '';
                dados.strDescricaoValor := DES_VALOR_ORIGINAL;

                dados.strContaCredito := fRetContaCredito(pagar, parametro, pfpDinheiro); //retorna a conta com base nas regras definidas no parametro contabil
                pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemCreditoEnum(parametro),
                    tpcCredito,
                    parametro.strBaixaCadastroCredito,
                    pfpDinheiro,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriC := LTpOri;
                  dados.strCdOriC := LCdOri;
                  dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                dados.strContaDebito := fRetContaDebito(pagar, parametro, pfpDinheiro); //retorna a conta com base nas regras definidas no parametro contabil
                pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemDebitoEnum(parametro),
                    tpcDebito,
                    parametro.strBaixaCadastroDebito,
                    pfpDinheiro,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriD := LTpOri;
                  dados.strCdOriD := LCdOri;
                  dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                  dados.strNumDoc := pagar.strNumero;

                dados.strHistorico := fRetHistorico(pagar, parametro);
                dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                dados.fltValorLancamento := pagar.fltValorDinheiro - (((pagar.fltValorDinheiro / pagar.fltValorPago) * pagar.fltValorMulta) + ((pagar.fltValorDinheiro / pagar.fltValorPago) * pagar.fltValorJuros) - ((pagar.fltValorDinheiro / pagar.fltValorPago) * pagar.fltValorDesconto));
                dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                dados.strCCusto := pagar.strCodEve;
                dados.strOrigemCredito := parametro.fOrigemCredito;
                dados.strOrigemDebito := parametro.fOrigemDebito;
                dados.strCtpInc := pagar.strAutoincrem;
                dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito, pfpDinheiro);
                dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito, pfpDinheiro);
                dados.strFormaPagamento := parametro.strFormaPagamento ;
                dados.strPagamento := pagar.strTipoPagamento;
                dados.blnIsCtpDet := pagar.IsCtpDet;
                dados.blnIsAgrup := pagar.strSerie = 'AG';
                dados.strCliFor := pagar.participante.strCodigo ;
                dados.strTip_fc := 'F' ;
                dados.strForPgo := parametro.strFormaPagamento;
                dados.strSeqPar := parametro.strSequenciaParametro;
                dados.strInvNco := 'N';
                pAdicionaLista(dados, pagar) ;
              End;

              //se for Vr.Desconto
              if (pagar.fltValorDinheiro > 0) and (pagar.fltValorDesconto > 0) then
              begin
                if (parametro.strDescricaoValor = DES_VALOR_DESCONTO) then
                begin
                  blnFlagParcon := True ;
                  ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_TODAS, DES_VALOR_DESCONTO, pagar.strTipoPagamento, intControle, pagar, parametro);
                  dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                  dados.strSeqLan := '';
                  dados.empresa := pagar.empresaBaixa;
                  dados.empresaCtpDet := pagar.empresaCtpDet;
                  dados.dtaLancamento := pagar.dtaDataPagamento;
                  dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                  dados.strCfopConfig := '';
                  dados.strNaturezaOperacao := '';
                  dados.strDescricaoValor := DES_VALOR_DESCONTO;

                  dados.strContaCredito := fRetContaCredito(pagar, parametro, pfpDinheiro); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemCreditoEnum(parametro),
                    tpcCredito,
                    parametro.strBaixaCadastroCredito,
                    pfpDinheiro,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriC := LTpOri;
                  dados.strCdOriC := LCdOri;
                  dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                  dados.strContaDebito := fRetContaDebito(pagar, parametro, pfpDinheiro); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemDebitoEnum(parametro),
                    tpcDebito,
                    parametro.strBaixaCadastroDebito,
                    pfpDinheiro,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriD := LTpOri;
                  dados.strCdOriD := LCdOri;
                  dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                  dados.strNumDoc := pagar.strNumero;

                  dados.strHistorico := fRetHistorico(pagar, parametro);
                  dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                  dados.fltValorLancamento := (pagar.fltValorDinheiro / pagar.fltValorPago) * pagar.fltValorDesconto;
                  dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                  dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                  dados.strCCusto := fRetornaEventoDescontoJuros(pagar.strCodEve, dados.strDescricaoValor) ;
                  dados.strOrigemCredito := parametro.fOrigemCredito;
                  dados.strOrigemDebito := parametro.fOrigemDebito;
                  dados.strCtpInc := pagar.strAutoincrem;
                  dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito, pfpDinheiro);
                  dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito, pfpDinheiro);
                  dados.strFormaPagamento := parametro.strFormaPagamento ;
                  dados.strPagamento := pagar.strTipoPagamento;
                  dados.blnIsCtpDet := pagar.IsCtpDet;
                  dados.blnIsAgrup := pagar.strSerie = 'AG';
                  dados.strCliFor := pagar.participante.strCodigo ;
                  dados.strTip_fc := 'F' ;
                  dados.strForPgo := parametro.strFormaPagamento;
                  dados.strSeqPar := parametro.strSequenciaParametro;
                  dados.strInvNco := 'N';
                  pAdicionaLista(dados, pagar) ;
                end;
                ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_TODAS, DES_VALOR_DESCONTO, pagar.strTipoPagamento, intControle, pagar, parametro);
              end ;

            end;
            ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_DINHEIRO, DES_VALOR_PAGO, pagar.strTipoPagamento, intControle, pagar, parametro);
            ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_DINHEIRO, DES_VALOR_ORIGINAL, pagar.strTipoPagamento, intControle, pagar, parametro);
          end ;
          //CHEQUE A VISTA
          if (pagar.fltValorChequeVista > 0) then
          begin
            if fTemFormaPagtoValida(FPG_CHEQUE_VISTA, listaParametrosContabil, parametro, pagar.dtaDataPagamento) then
            begin
              //se for Vr.Pago
              if (parametro.strDescricaoValor = DES_VALOR_PAGO) and (not pagar.blnDescJurAjustado) then
              begin
                blnFlagParcon := True ;
                ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_CHEQUE_VISTA, DES_VALOR_PAGO, pagar.strTipoPagamento, intControle, pagar, parametro);
                dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                dados.strSeqLan := '';
                dados.empresa := pagar.empresaBaixa;
                dados.empresaCtpDet := pagar.empresaCtpDet;
                dados.dtaLancamento := pagar.dtaDataPagamento;
                dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                dados.strCfopConfig := '';
                dados.strNaturezaOperacao := '';
                dados.strDescricaoValor := DES_VALOR_PAGO;

                dados.strContaCredito := fRetContaCredito(pagar, parametro, pfpChequeAVista); //retorna a conta com base nas regras definidas no parametro contabil
                pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemCreditoEnum(parametro),
                    tpcCredito,
                    parametro.strBaixaCadastroCredito,
                    pfpChequeAVista,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriC := LTpOri;
                  dados.strCdOriC := LCdOri;
                  dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                dados.strContaDebito := fRetContaDebito(pagar, parametro, pfpChequeAVista); //retorna a conta com base nas regras definidas no parametro contabil
                pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemDebitoEnum(parametro),
                    tpcDebito,
                    parametro.strBaixaCadastroDebito,
                    pfpChequeAVista,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriD := LTpOri;
                  dados.strCdOriD := LCdOri;
                  dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                  dados.strNumDoc := pagar.strNumero;

                dados.strHistorico := fRetHistorico(pagar, parametro);
                dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                dados.fltValorLancamento := pagar.fltValorChequeVista;
                dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                dados.strCCusto := pagar.strCodEve;
                dados.strOrigemCredito := parametro.fOrigemCredito;
                dados.strOrigemDebito := parametro.fOrigemDebito;
                dados.strCtpInc := pagar.strAutoincrem;
                dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito, pfpChequeAVista);
                dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito, pfpChequeAVista);
                dados.strFormaPagamento := parametro.strFormaPagamento ;
                dados.strPagamento := pagar.strTipoPagamento;
                dados.blnIsCtpDet := pagar.IsCtpDet;
                dados.blnIsAgrup := pagar.strSerie = 'AG';
                dados.strCliFor := pagar.participante.strCodigo ;
                dados.strTip_fc := 'F' ;
                dados.strForPgo := parametro.strFormaPagamento;
                dados.strSeqPar := parametro.strSequenciaParametro;
                dados.strInvNco := 'N';
                pAdicionaLista(dados, pagar) ;
              end;

              //se for Vr.Juros
              if (pagar.fltValorChequeVista > 0) and (pagar.fltValorJuros > 0) then
              begin
                if (parametro.strDescricaoValor = DES_VALOR_JUROS) then
                begin
                  blnFlagParcon := True ;
                  ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_TODAS, DES_VALOR_JUROS, pagar.strTipoPagamento, intControle, pagar, parametro);
                  dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                  dados.strSeqLan := '';
                  dados.empresa := pagar.empresaBaixa;
                  dados.empresaCtpDet := pagar.empresaCtpDet;
                  dados.dtaLancamento := pagar.dtaDataPagamento;
                  dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                  dados.strCfopConfig := '';
                  dados.strNaturezaOperacao := '';
                  dados.strDescricaoValor := DES_VALOR_JUROS;

                  dados.strContaCredito := fRetContaCredito(pagar, parametro, pfpChequeAVista); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemCreditoEnum(parametro),
                    tpcCredito,
                    parametro.strBaixaCadastroCredito,
                    pfpChequeAVista,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriC := LTpOri;
                  dados.strCdOriC := LCdOri;
                  dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                  dados.strContaDebito := fRetContaDebito(pagar, parametro, pfpChequeAVista); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemDebitoEnum(parametro),
                    tpcDebito,
                    parametro.strBaixaCadastroDebito,
                    pfpChequeAVista,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriD := LTpOri;
                  dados.strCdOriD := LCdOri;
                  dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                  dados.strNumDoc := pagar.strNumero;

                  dados.strHistorico := fRetHistorico(pagar, parametro);
                  dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                  dados.fltValorLancamento := (pagar.fltValorChequeVista / pagar.fltValorPago) * pagar.fltValorJuros;
                  dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                  dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                  dados.strCCusto := fRetornaEventoDescontoJuros(pagar.strCodEve, dados.strDescricaoValor) ;
                  dados.strOrigemCredito := parametro.fOrigemCredito;
                  dados.strOrigemDebito := parametro.fOrigemDebito;
                  dados.strCtpInc := pagar.strAutoincrem;
                  dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito, pfpChequeAVista);
                  dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito, pfpChequeAVista);
                  dados.strFormaPagamento := parametro.strFormaPagamento ;
                  dados.strPagamento := pagar.strTipoPagamento;
                  dados.blnIsCtpDet := pagar.IsCtpDet;
                  dados.blnIsAgrup := pagar.strSerie = 'AG';
                  dados.strCliFor := pagar.participante.strCodigo ;
                  dados.strTip_fc := 'F' ;
                  dados.strForPgo := parametro.strFormaPagamento;
                  dados.strSeqPar := parametro.strSequenciaParametro;
                  dados.strInvNco := 'N';
                  pAdicionaLista(dados, pagar) ;
                end;
                ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_TODAS, DES_VALOR_JUROS, pagar.strTipoPagamento, intControle, pagar, parametro);
              end ;

              pAdicionarLancamento(pagar, parametro, DES_VALOR_MULTA, (pagar.fltValorChequeVista / pagar.fltValorPago) * pagar.fltValorMulta, ctrlCtpParcon, intControle, blnFlagParcon, pagar.dtaDataPagamento, TIPO_CONTAS_PAGAR, FPG_CHEQUE_VISTA);
              pAdicionarLancamento(pagar, parametro, DES_VALOR_VENDOR, (pagar.fltValorChequeVista / pagar.fltValorPago) * pagar.fltValorVendor, ctrlCtpParcon, intControle, blnFlagParcon, pagar.dtaDataPagamento, TIPO_CONTAS_PAGAR, FPG_CHEQUE_VISTA);

              If (pagar.fltValorChequeVista > 0) And (parametro.strDescricaoValor = DES_VALOR_ORIGINAL) Then
              Begin
                blnFlagParcon := True ;
                ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_CHEQUE_VISTA, DES_VALOR_ORIGINAL, pagar.strTipoPagamento, intControle, pagar, parametro);
                dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                dados.strSeqLan := '';
                dados.empresa := pagar.empresaBaixa;
                dados.empresaCtpDet := pagar.empresaCtpDet;
                dados.dtaLancamento := pagar.dtaDataPagamento;
                dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                dados.strCfopConfig := '';
                dados.strNaturezaOperacao := '';
                dados.strDescricaoValor := DES_VALOR_ORIGINAL;

                dados.strContaCredito := fRetContaCredito(pagar, parametro, pfpChequeAVista); //retorna a conta com base nas regras definidas no parametro contabil
                pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemCreditoEnum(parametro),
                    tpcCredito,
                    parametro.strBaixaCadastroCredito,
                    pfpChequeAVista,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriC := LTpOri;
                  dados.strCdOriC := LCdOri;
                  dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                dados.strContaDebito := fRetContaDebito(pagar, parametro, pfpChequeAVista); //retorna a conta com base nas regras definidas no parametro contabil
                pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemDebitoEnum(parametro),
                    tpcDebito,
                    parametro.strBaixaCadastroDebito,
                    pfpChequeAVista,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriD := LTpOri;
                  dados.strCdOriD := LCdOri;
                  dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                  dados.strNumDoc := pagar.strNumero;

                dados.strHistorico := fRetHistorico(pagar, parametro);
                dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                dados.fltValorLancamento := pagar.fltValorChequeVista - (((pagar.fltValorChequeVista / pagar.fltValorPago) * pagar.fltValorMulta) + ((pagar.fltValorChequeVista / pagar.fltValorPago) * pagar.fltValorJuros) - ((pagar.fltValorChequeVista / pagar.fltValorPago) * pagar.fltValorDesconto));
                dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                dados.strCCusto := pagar.strCodEve;
                dados.strOrigemCredito := parametro.fOrigemCredito;
                dados.strOrigemDebito := parametro.fOrigemDebito;
                dados.strCtpInc := pagar.strAutoincrem;
                dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito, pfpChequeAVista);
                dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito, pfpChequeAVista);
                dados.strFormaPagamento := parametro.strFormaPagamento ;
                dados.strPagamento := pagar.strTipoPagamento;
                dados.blnIsCtpDet := pagar.IsCtpDet;
                dados.blnIsAgrup := pagar.strSerie = 'AG';
                dados.strCliFor := pagar.participante.strCodigo ;
                dados.strTip_fc := 'F' ;
                dados.strForPgo := parametro.strFormaPagamento;
                dados.strSeqPar := parametro.strSequenciaParametro;
                dados.strInvNco := 'N';
                pAdicionaLista(dados, pagar) ;
              End;

              //se for Vr.Desconto
              if (pagar.fltValorChequeVista > 0) and (pagar.fltValorDesconto > 0) then
              begin
                if (parametro.strDescricaoValor = DES_VALOR_DESCONTO) then
                begin
                  blnFlagParcon := True ;
                  ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_TODAS, DES_VALOR_DESCONTO, pagar.strTipoPagamento, intControle, pagar, parametro);
                  dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                  dados.strSeqLan := '';
                  dados.empresa := pagar.empresaBaixa;
                  dados.empresaCtpDet := pagar.empresaCtpDet;
                  dados.dtaLancamento := pagar.dtaDataPagamento;
                  dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                  dados.strCfopConfig := '';
                  dados.strNaturezaOperacao := '';
                  dados.strDescricaoValor := DES_VALOR_DESCONTO;

                  dados.strContaCredito := fRetContaCredito(pagar, parametro, pfpChequeAVista); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemCreditoEnum(parametro),
                    tpcCredito,
                    parametro.strBaixaCadastroCredito,
                    pfpChequeAVista,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriC := LTpOri;
                  dados.strCdOriC := LCdOri;
                  dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                  dados.strContaDebito := fRetContaDebito(pagar, parametro, pfpChequeAVista); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemDebitoEnum(parametro),
                    tpcDebito,
                    parametro.strBaixaCadastroDebito,
                    pfpChequeAVista,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriD := LTpOri;
                  dados.strCdOriD := LCdOri;
                  dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                  dados.strNumDoc := pagar.strNumero;

                  dados.strHistorico := fRetHistorico(pagar, parametro);
                  dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                  dados.fltValorLancamento := (pagar.fltValorChequeVista / pagar.fltValorPago) * pagar.fltValorDesconto;
                  dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                  dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                  dados.strCCusto := fRetornaEventoDescontoJuros(pagar.strCodEve, dados.strDescricaoValor) ;
                  dados.strOrigemCredito := parametro.fOrigemCredito;
                  dados.strOrigemDebito := parametro.fOrigemDebito;
                  dados.strCtpInc := pagar.strAutoincrem;
                  dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito, pfpChequeAVista);
                  dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito, pfpChequeAVista);
                  dados.strFormaPagamento := parametro.strFormaPagamento ;
                  dados.strPagamento := pagar.strTipoPagamento;
                  dados.blnIsCtpDet := pagar.IsCtpDet;
                  dados.blnIsAgrup := pagar.strSerie = 'AG';
                  dados.strCliFor := pagar.participante.strCodigo ;
                  dados.strTip_fc := 'F' ;
                  dados.strForPgo := parametro.strFormaPagamento;
                  dados.strSeqPar := parametro.strSequenciaParametro;
                  dados.strInvNco := 'N';
                  pAdicionaLista(dados, pagar) ;
                end;
                ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_TODAS, DES_VALOR_DESCONTO, pagar.strTipoPagamento, intControle, pagar, parametro);
              end ;
            end ;
            ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_CHEQUE_VISTA, DES_VALOR_PAGO, pagar.strTipoPagamento, intControle, pagar, parametro);
            ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_CHEQUE_VISTA, DES_VALOR_ORIGINAL, pagar.strTipoPagamento, intControle, pagar, parametro);
          end;

          //CHEQUE PRE
          if (pagar.fltValorChequePre > 0) then
          begin
            if fTemFormaPagtoValida(FPG_CHEQUE_PRE, listaParametrosContabil, parametro, pagar.dtaDataPagamento) then
            begin
              //se for Vr.Pago
              if (parametro.strDescricaoValor = DES_VALOR_PAGO) and (not pagar.blnDescJurAjustado) then
              begin
                blnFlagParcon := True ;
                ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_CHEQUE_PRE, DES_VALOR_PAGO, pagar.strTipoPagamento, intControle, pagar, parametro);
                dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                dados.strSeqLan := '';
                dados.empresa := pagar.empresaBaixa;
                dados.empresaCtpDet := pagar.empresaCtpDet;
                dados.dtaLancamento := pagar.dtaDataPagamento;
                dados.strTipoLancamento := TIPO_CONTAS_pagar;
                dados.strCfopConfig := '';
                dados.strNaturezaOperacao := '';
                dados.strDescricaoValor := DES_VALOR_PAGO;

                dados.strContaCredito := fRetContaCredito(pagar, parametro, pfpChequePre); //retorna a conta com base nas regras definidas no parametro contabil
                pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemCreditoEnum(parametro),
                    tpcCredito,
                    parametro.strBaixaCadastroCredito,
                    pfpChequePre,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriC := LTpOri;
                  dados.strCdOriC := LCdOri;
                  dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                dados.strContaDebito := fRetContaDebito(pagar, parametro, pfpChequePre); //retorna a conta com base nas regras definidas no parametro contabil
                pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemDebitoEnum(parametro),
                    tpcDebito,
                    parametro.strBaixaCadastroDebito,
                    pfpChequePre,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriD := LTpOri;
                  dados.strCdOriD := LCdOri;
                  dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                  dados.strNumDoc := pagar.strNumero;

                dados.strHistorico := fRetHistorico(pagar, parametro);
                dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                dados.fltValorLancamento := pagar.fltValorChequePre;
                dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                dados.strCCusto := pagar.strCodEve;
                dados.strOrigemCredito := parametro.fOrigemCredito;
                dados.strOrigemDebito := parametro.fOrigemDebito;
                dados.strCtpInc := pagar.strAutoincrem;
                dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito, pfpChequePre);
                dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito, pfpChequePre);
                dados.strFormaPagamento := parametro.strFormaPagamento ;
                dados.strPagamento := pagar.strTipoPagamento;
                dados.blnIsCtpDet := pagar.IsCtpDet;
                dados.blnIsAgrup := pagar.strSerie = 'AG';
                dados.strCliFor := pagar.participante.strCodigo ;
                dados.strTip_fc := 'F' ;
                dados.strForPgo := parametro.strFormaPagamento;
                dados.strSeqPar := parametro.strSequenciaParametro;
                dados.strInvNco := 'N';
                pAdicionaLista(dados, pagar) ;
              end;

              //se for Vr.Juros
              if (pagar.fltValorChequePre > 0) and (pagar.fltValorJuros > 0) then
              begin
                if (parametro.strDescricaoValor = DES_VALOR_JUROS) then
                begin
                  blnFlagParcon := True ;
                  ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_TODAS, DES_VALOR_JUROS, pagar.strTipoPagamento, intControle, pagar, parametro);
                  dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                  dados.strSeqLan := '';
                  dados.empresa := pagar.empresaBaixa;
                  dados.empresaCtpDet := pagar.empresaCtpDet;
                  dados.dtaLancamento := pagar.dtaDataPagamento;
                  dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                  dados.strCfopConfig := '';
                  dados.strNaturezaOperacao := '';
                  dados.strDescricaoValor := DES_VALOR_JUROS;

                  dados.strContaCredito := fRetContaCredito(pagar, parametro, pfpChequePre); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemCreditoEnum(parametro),
                    tpcCredito,
                    parametro.strBaixaCadastroCredito,
                    pfpChequePre,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriC := LTpOri;
                  dados.strCdOriC := LCdOri;
                  dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                  dados.strContaDebito := fRetContaDebito(pagar, parametro, pfpChequePre); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemDebitoEnum(parametro),
                    tpcDebito,
                    parametro.strBaixaCadastroDebito,
                    pfpChequePre,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriD := LTpOri;
                  dados.strCdOriD := LCdOri;
                  dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                  dados.strNumDoc := pagar.strNumero;

                  dados.strHistorico := fRetHistorico(pagar, parametro);
                  dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                  dados.fltValorLancamento := (pagar.fltValorChequePre / pagar.fltValorPago) * pagar.fltValorJuros;
                  dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                  dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                  dados.strCCusto := fRetornaEventoDescontoJuros(pagar.strCodEve, dados.strDescricaoValor) ;
                  dados.strOrigemCredito := parametro.fOrigemCredito;
                  dados.strOrigemDebito := parametro.fOrigemDebito;
                  dados.strCtpInc := pagar.strAutoincrem;
                  dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito, pfpChequePre);
                  dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito, pfpChequePre);
                  dados.strFormaPagamento := parametro.strFormaPagamento ;
                  dados.strPagamento := pagar.strTipoPagamento;
                  dados.blnIsCtpDet := pagar.IsCtpDet;
                  dados.blnIsAgrup := pagar.strSerie = 'AG';
                  dados.strCliFor := pagar.participante.strCodigo ;
                  dados.strTip_fc := 'F' ;
                  dados.strForPgo := parametro.strFormaPagamento;
                  dados.strSeqPar := parametro.strSequenciaParametro;
                  dados.strInvNco := 'N';
                  pAdicionaLista(dados, pagar) ;
                end;
                ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_TODAS, DES_VALOR_JUROS, pagar.strTipoPagamento, intControle, pagar, parametro);
              end ;

              pAdicionarLancamento(pagar, parametro, DES_VALOR_MULTA, (pagar.fltValorChequePre / pagar.fltValorPago) * pagar.fltValorMulta, ctrlCtpParcon, intControle, blnFlagParcon, pagar.dtaDataPagamento, TIPO_CONTAS_PAGAR, FPG_CHEQUE_PRE);
              pAdicionarLancamento(pagar, parametro, DES_VALOR_VENDOR, (pagar.fltValorChequePre / pagar.fltValorPago) * pagar.fltValorVendor, ctrlCtpParcon, intControle, blnFlagParcon, pagar.dtaDataPagamento, TIPO_CONTAS_PAGAR, FPG_CHEQUE_PRE);

              If (pagar.fltValorChequePre > 0) And (parametro.strDescricaoValor = DES_VALOR_ORIGINAL) Then
              Begin
                blnFlagParcon := True ;
                ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_CHEQUE_PRE, DES_VALOR_ORIGINAL, pagar.strTipoPagamento, intControle, pagar, parametro);
                dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                dados.strSeqLan := '';
                dados.empresa := pagar.empresaBaixa;
                dados.empresaCtpDet := pagar.empresaCtpDet;
                dados.dtaLancamento := pagar.dtaDataPagamento;
                dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                dados.strCfopConfig := '';
                dados.strNaturezaOperacao := '';
                dados.strDescricaoValor := DES_VALOR_ORIGINAL;

                dados.strContaCredito := fRetContaCredito(pagar, parametro, pfpChequePre); //retorna a conta com base nas regras definidas no parametro contabil
                pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemCreditoEnum(parametro),
                    tpcCredito,
                    parametro.strBaixaCadastroCredito,
                    pfpChequePre,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriC := LTpOri;
                  dados.strCdOriC := LCdOri;
                  dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                dados.strContaDebito := fRetContaDebito(pagar, parametro, pfpChequePre); //retorna a conta com base nas regras definidas no parametro contabil
                pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemDebitoEnum(parametro),
                    tpcDebito,
                    parametro.strBaixaCadastroDebito,
                    pfpChequePre,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriD := LTpOri;
                  dados.strCdOriD := LCdOri;
                  dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                  dados.strNumDoc := pagar.strNumero;

                dados.strHistorico := fRetHistorico(pagar, parametro);
                dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                dados.fltValorLancamento := pagar.fltValorChequePre - (((pagar.fltValorChequePre / pagar.fltValorPago) * pagar.fltValorMulta) + ((pagar.fltValorChequePre / pagar.fltValorPago) * pagar.fltValorJuros) - ((pagar.fltValorChequePre / pagar.fltValorPago) * pagar.fltValorDesconto));
                dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                dados.strCCusto := pagar.strCodEve;
                dados.strOrigemCredito := parametro.fOrigemCredito;
                dados.strOrigemDebito := parametro.fOrigemDebito;
                dados.strCtpInc := pagar.strAutoincrem;
                dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito, pfpChequePre);
                dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito, pfpChequePre);
                dados.strFormaPagamento := parametro.strFormaPagamento ;
                dados.strPagamento := pagar.strTipoPagamento;
                dados.blnIsCtpDet := pagar.IsCtpDet;
                dados.blnIsAgrup := pagar.strSerie = 'AG';
                dados.strCliFor := pagar.participante.strCodigo ;
                dados.strTip_fc := 'F' ;
                dados.strForPgo := parametro.strFormaPagamento;
                dados.strSeqPar := parametro.strSequenciaParametro;
                dados.strInvNco := 'N';
                pAdicionaLista(dados, pagar) ;
              End;

              //se for Vr.Desconto
              if (pagar.fltValorChequePre > 0) and (pagar.fltValorDesconto > 0) then
              begin
                if (parametro.strDescricaoValor = DES_VALOR_DESCONTO) then
                begin
                  blnFlagParcon := True ;
                  ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_TODAS, DES_VALOR_DESCONTO, pagar.strTipoPagamento, intControle, pagar, parametro);
                  dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                  dados.strSeqLan := '';
                  dados.empresa := pagar.empresaBaixa;
                  dados.empresaCtpDet := pagar.empresaCtpDet;
                  dados.dtaLancamento := pagar.dtaDataPagamento;
                  dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                  dados.strCfopConfig := '';
                  dados.strNaturezaOperacao := '';
                  dados.strDescricaoValor := DES_VALOR_DESCONTO;

                  dados.strContaCredito := fRetContaCredito(pagar, parametro, pfpChequePre); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemCreditoEnum(parametro),
                    tpcCredito,
                    parametro.strBaixaCadastroCredito,
                    pfpChequePre,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriC := LTpOri;
                  dados.strCdOriC := LCdOri;
                  dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                  dados.strContaDebito := fRetContaDebito(pagar, parametro, pfpChequePre); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemDebitoEnum(parametro),
                    tpcDebito,
                    parametro.strBaixaCadastroDebito,
                    pfpChequePre,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriD := LTpOri;
                  dados.strCdOriD := LCdOri;
                  dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                  dados.strNumDoc := pagar.strNumero;

                  dados.strHistorico := fRetHistorico(pagar, parametro);
                  dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                  dados.fltValorLancamento := (pagar.fltValorChequePre / pagar.fltValorPago) * pagar.fltValorDesconto;
                  dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                  dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                  dados.strCCusto := fRetornaEventoDescontoJuros(pagar.strCodEve, dados.strDescricaoValor) ;
                  dados.strOrigemCredito := parametro.fOrigemCredito;
                  dados.strOrigemDebito := parametro.fOrigemDebito;
                  dados.strCtpInc := pagar.strAutoincrem;
                  dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito, pfpChequePre);
                  dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito, pfpChequePre);
                  dados.strFormaPagamento := parametro.strFormaPagamento ;
                  dados.strPagamento := pagar.strTipoPagamento;
                  dados.blnIsCtpDet := pagar.IsCtpDet;
                  dados.blnIsAgrup := pagar.strSerie = 'AG';
                  dados.strCliFor := pagar.participante.strCodigo ;
                  dados.strTip_fc := 'F' ;
                  dados.strForPgo := parametro.strFormaPagamento;
                  dados.strSeqPar := parametro.strSequenciaParametro;
                  dados.strInvNco := 'N';
                  pAdicionaLista(dados, pagar) ;
                end;
                ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_TODAS, DES_VALOR_DESCONTO, pagar.strTipoPagamento, intControle, pagar, parametro);
              end ;

            end;
            ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_CHEQUE_PRE, DES_VALOR_PAGO, pagar.strTipoPagamento, intControle, pagar, parametro);
            ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_CHEQUE_PRE, DES_VALOR_ORIGINAL, pagar.strTipoPagamento, intControle, pagar, parametro);
          end ;

          //CARTAO
          if (pagar.fltValorCartao > 0) then
          begin
            if fTemFormaPagtoValida(FPG_CARTAO, listaParametrosContabil, parametro, pagar.dtaDataPagamento) then
            begin
              //se for Vr.Pago
              if (parametro.strDescricaoValor = DES_VALOR_PAGO) and (not pagar.blnDescJurAjustado) then
              begin
                blnFlagParcon := True ;
                ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_CARTAO, DES_VALOR_PAGO, pagar.strTipoPagamento, intControle, pagar, parametro);
                dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                dados.strSeqLan := '';
                dados.empresa := pagar.empresaBaixa;
                dados.empresaCtpDet := pagar.empresaCtpDet;
                dados.dtaLancamento := pagar.dtaDataPagamento;
                dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                dados.strCfopConfig := '';
                dados.strNaturezaOperacao := '';
                dados.strDescricaoValor := DES_VALOR_PAGO;

                dados.strContaCredito := fRetContaCredito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
                pRetornaDadosOrigem(
                  pagar,
                  parametro,
                  fOrigemCreditoEnum(parametro),
                  tpcCredito,
                  parametro.strBaixaCadastroCredito,
                  pfpNaoEspecificado,
                  LTpOri,
                  LCdOri);
                dados.strTpOriC := LTpOri;
                dados.strCdOriC := LCdOri;
                dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                dados.strContaDebito := fRetContaDebito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
                pRetornaDadosOrigem(
                  pagar,
                  parametro,
                  fOrigemDebitoEnum(parametro),
                  tpcDebito,
                  parametro.strBaixaCadastroDebito,
                  pfpNaoEspecificado,
                  LTpOri,
                  LCdOri);
                dados.strTpOriD := LTpOri;
                dados.strCdOriD := LCdOri;
                dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                dados.strNumDoc := pagar.strNumero;

                dados.strHistorico := fRetHistorico(pagar, parametro);
                dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                dados.fltValorLancamento := pagar.fltValorCartao;
                dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                dados.strCCusto := pagar.strCodEve;
                dados.strOrigemCredito := parametro.fOrigemCredito;
                dados.strOrigemDebito := parametro.fOrigemDebito;
                dados.strCtpInc := pagar.strAutoincrem;
                dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito);
                dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito);
                dados.strFormaPagamento := parametro.strFormaPagamento ;
                dados.strPagamento := pagar.strTipoPagamento;
                dados.blnIsCtpDet := pagar.IsCtpDet;
                dados.blnIsAgrup := pagar.strSerie = 'AG';
                dados.strCliFor := pagar.participante.strCodigo ;
                dados.strTip_fc := 'F' ;
                dados.strForPgo := parametro.strFormaPagamento;
                dados.strSeqPar := parametro.strSequenciaParametro;
                dados.strInvNco := 'N';
                pAdicionaLista(dados, pagar) ;
              end;

              //se for Vr.Juros
              if (pagar.fltValorCartao > 0) and (pagar.fltValorJuros > 0) then
              begin
                if (parametro.strDescricaoValor = DES_VALOR_JUROS) then
                begin
                  blnFlagParcon := True ;
                  ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_TODAS, DES_VALOR_JUROS, pagar.strTipoPagamento, intControle, pagar, parametro);
                  dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                  dados.strSeqLan := '';
                  dados.empresa := pagar.empresaBaixa;
                  dados.empresaCtpDet := pagar.empresaCtpDet;
                  dados.dtaLancamento := pagar.dtaDataPagamento;
                  dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                  dados.strCfopConfig := '';
                  dados.strNaturezaOperacao := '';
                  dados.strDescricaoValor := DES_VALOR_JUROS;

                  dados.strContaCredito := fRetContaCredito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemCreditoEnum(parametro),
                    tpcCredito,
                    parametro.strBaixaCadastroCredito,
                    pfpNaoEspecificado,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriC := LTpOri;
                  dados.strCdOriC := LCdOri;
                  dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                  dados.strContaDebito := fRetContaDebito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemDebitoEnum(parametro),
                    tpcDebito,
                    parametro.strBaixaCadastroDebito,
                    pfpNaoEspecificado,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriD := LTpOri;
                  dados.strCdOriD := LCdOri;
                  dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                  dados.strNumDoc := pagar.strNumero;

                  dados.strHistorico := fRetHistorico(pagar, parametro);
                  dados.intCodigoHistoricoPadrao :=fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                  dados.fltValorLancamento := (pagar.fltValorCartao / pagar.fltValorPago) * pagar.fltValorJuros;
                  dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                  dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                  dados.strCCusto := fRetornaEventoDescontoJuros(pagar.strCodEve, dados.strDescricaoValor) ;
                  dados.strOrigemCredito := parametro.fOrigemCredito;
                  dados.strOrigemDebito := parametro.fOrigemDebito;
                  dados.strCtpInc := pagar.strAutoincrem;
                  dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito);
                  dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito);
                  dados.strFormaPagamento := parametro.strFormaPagamento ;
                  dados.strPagamento := pagar.strTipoPagamento;
                  dados.blnIsCtpDet := pagar.IsCtpDet;
                  dados.blnIsAgrup := pagar.strSerie = 'AG';
                  dados.strCliFor := pagar.participante.strCodigo ;
                  dados.strTip_fc := 'F' ;
                  dados.strForPgo := parametro.strFormaPagamento;
                  dados.strSeqPar := parametro.strSequenciaParametro;
                  dados.strInvNco := 'N';
                  pAdicionaLista(dados, pagar) ;
                end;
                ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_TODAS, DES_VALOR_JUROS, pagar.strTipoPagamento, intControle, pagar, parametro);
              end ;

              pAdicionarLancamento(pagar, parametro, DES_VALOR_MULTA, (pagar.fltValorCartao / pagar.fltValorPago) * pagar.fltValorMulta, ctrlCtpParcon, intControle, blnFlagParcon, pagar.dtaDataPagamento, TIPO_CONTAS_PAGAR, FPG_CARTAO);
              pAdicionarLancamento(pagar, parametro, DES_VALOR_VENDOR, (pagar.fltValorCartao / pagar.fltValorPago) * pagar.fltValorVendor, ctrlCtpParcon, intControle, blnFlagParcon, pagar.dtaDataPagamento, TIPO_CONTAS_PAGAR, FPG_CARTAO);

              If (pagar.fltValorCartao > 0) And (parametro.strDescricaoValor = DES_VALOR_ORIGINAL) Then
              Begin
                blnFlagParcon := True ;
                ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_CARTAO, DES_VALOR_ORIGINAL, pagar.strTipoPagamento, intControle, pagar, parametro);
                dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                dados.strSeqLan := '';
                dados.empresa := pagar.empresaBaixa;
                dados.empresaCtpDet := pagar.empresaCtpDet;
                dados.dtaLancamento := pagar.dtaDataPagamento;
                dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                dados.strCfopConfig := '';
                dados.strNaturezaOperacao := '';
                dados.strDescricaoValor := DES_VALOR_ORIGINAL;

                dados.strContaCredito := fRetContaCredito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
                pRetornaDadosOrigem(
                  pagar,
                  parametro,
                  fOrigemCreditoEnum(parametro),
                  tpcCredito,
                  parametro.strBaixaCadastroCredito,
                  pfpNaoEspecificado,
                  LTpOri,
                  LCdOri);
                dados.strTpOriC := LTpOri;
                dados.strCdOriC := LCdOri;
                dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                dados.strContaDebito := fRetContaDebito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
                pRetornaDadosOrigem(
                  pagar,
                  parametro,
                  fOrigemDebitoEnum(parametro),
                  tpcDebito,
                  parametro.strBaixaCadastroDebito,
                  pfpNaoEspecificado,
                  LTpOri,
                  LCdOri);
                dados.strTpOriD := LTpOri;
                dados.strCdOriD := LCdOri;
                dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                dados.strNumDoc := pagar.strNumero;

                dados.strHistorico := fRetHistorico(pagar, parametro);
                dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                dados.fltValorLancamento := pagar.fltValorCartao - (((pagar.fltValorCartao / pagar.fltValorPago) * pagar.fltValorMulta) + ((pagar.fltValorCartao / pagar.fltValorPago) * pagar.fltValorJuros) - ((pagar.fltValorCartao / pagar.fltValorPago) * pagar.fltValorDesconto));
                dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                dados.strCCusto := pagar.strCodEve;
                dados.strOrigemCredito := parametro.fOrigemCredito;
                dados.strOrigemDebito := parametro.fOrigemDebito;
                dados.strCtpInc := pagar.strAutoincrem;
                dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito);
                dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito);
                dados.strFormaPagamento := parametro.strFormaPagamento ;
                dados.strPagamento := pagar.strTipoPagamento;
                dados.blnIsCtpDet := pagar.IsCtpDet;
                dados.blnIsAgrup := pagar.strSerie = 'AG';
                dados.strCliFor := pagar.participante.strCodigo ;
                dados.strTip_fc := 'F' ;
                dados.strForPgo := parametro.strFormaPagamento;
                dados.strSeqPar := parametro.strSequenciaParametro;
                dados.strInvNco := 'N';
                pAdicionaLista(dados, pagar) ;
              End;

              //se for Vr.Desconto
              if (pagar.fltValorCartao > 0) and (pagar.fltValorDesconto > 0) then
              begin
                if (parametro.strDescricaoValor = DES_VALOR_DESCONTO) then
                begin
                  blnFlagParcon := True ;
                  ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_TODAS, DES_VALOR_DESCONTO, pagar.strTipoPagamento, intControle, pagar, parametro);
                  dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                  dados.strSeqLan := '';
                  dados.empresa := pagar.empresaBaixa;
                  dados.empresaCtpDet := pagar.empresaCtpDet;
                  dados.dtaLancamento := pagar.dtaDataPagamento;
                  dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                  dados.strCfopConfig := '';
                  dados.strNaturezaOperacao := '';
                  dados.strDescricaoValor := DES_VALOR_DESCONTO;

                  dados.strContaCredito := fRetContaCredito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemCreditoEnum(parametro),
                    tpcCredito,
                    parametro.strBaixaCadastroCredito,
                    pfpNaoEspecificado,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriC := LTpOri;
                  dados.strCdOriC := LCdOri;
                  dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                  dados.strContaDebito := fRetContaDebito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemDebitoEnum(parametro),
                    tpcDebito,
                    parametro.strBaixaCadastroDebito,
                    pfpNaoEspecificado,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriD := LTpOri;
                  dados.strCdOriD := LCdOri;
                  dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                  dados.strNumDoc := pagar.strNumero;

                  dados.strHistorico := fRetHistorico(pagar, parametro);
                  dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                  dados.fltValorLancamento := (pagar.fltValorCartao / pagar.fltValorPago) * pagar.fltValorDesconto;
                  dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                  dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                  dados.strCCusto := fRetornaEventoDescontoJuros(pagar.strCodEve, dados.strDescricaoValor) ;
                  dados.strOrigemCredito := parametro.fOrigemCredito;
                  dados.strOrigemDebito := parametro.fOrigemDebito;
                  dados.strCtpInc := pagar.strAutoincrem;
                  dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito);
                  dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito);
                  dados.strFormaPagamento := parametro.strFormaPagamento ;
                  dados.strPagamento := pagar.strTipoPagamento;
                  dados.blnIsCtpDet := pagar.IsCtpDet;
                  dados.blnIsAgrup := pagar.strSerie = 'AG';
                  dados.strCliFor := pagar.participante.strCodigo ;
                  dados.strTip_fc := 'F' ;
                  dados.strForPgo := parametro.strFormaPagamento;
                  dados.strSeqPar := parametro.strSequenciaParametro;
                  dados.strInvNco := 'N';
                  pAdicionaLista(dados, pagar) ;
                end;
                ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_TODAS, DES_VALOR_DESCONTO, pagar.strTipoPagamento, intControle, pagar, parametro);
              end ;

            end;
            ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_CARTAO, DES_VALOR_PAGO, pagar.strTipoPagamento, intControle, pagar, parametro);
            ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_CARTAO, DES_VALOR_ORIGINAL, pagar.strTipoPagamento, intControle, pagar, parametro);
          end ;
          // ORDEM PAGAMENTO
          if (pagar.fltValorOrdemPagamento > 0) then
          begin
            if fTemFormaPagtoValida(FPG_ORDPAG, listaParametrosContabil, parametro, pagar.dtaDataPagamento) then
            begin
              //se for Vr.Pago
              if (parametro.strDescricaoValor = DES_VALOR_PAGO) and (not pagar.blnDescJurAjustado) then
              begin
                blnFlagParcon := True ;
                ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_ORDPAG, DES_VALOR_PAGO, pagar.strTipoPagamento, intControle, pagar, parametro);
                dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                dados.strSeqLan := '';
                dados.empresa := pagar.empresaBaixa;
                dados.empresaCtpDet := pagar.empresaCtpDet;
                dados.dtaLancamento := pagar.dtaDataPagamento;
                dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                dados.strCfopConfig := '';
                dados.strNaturezaOperacao := '';
                dados.strDescricaoValor := DES_VALOR_PAGO;

                dados.strContaCredito := fRetContaCredito(pagar, parametro, pfpOrdemPagamento); //retorna a conta com base nas regras definidas no parametro contabil
                pRetornaDadosOrigem(
                  pagar,
                  parametro,
                  fOrigemCreditoEnum(parametro),
                  tpcCredito,
                  parametro.strBaixaCadastroCredito,
                  pfpOrdemPagamento,
                  LTpOri,
                  LCdOri);
                dados.strTpOriC := LTpOri;
                dados.strCdOriC := LCdOri;
                dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                dados.strContaDebito := fRetContaDebito(pagar, parametro, pfpOrdemPagamento); //retorna a conta com base nas regras definidas no parametro contabil
                pRetornaDadosOrigem(
                  pagar,
                  parametro,
                  fOrigemDebitoEnum(parametro),
                  tpcDebito,
                  parametro.strBaixaCadastroDebito,
                  pfpOrdemPagamento,
                  LTpOri,
                  LCdOri);
                dados.strTpOriD := LTpOri;
                dados.strCdOriD := LCdOri;
                dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                dados.strNumDoc := pagar.strNumero;

                dados.strHistorico := fRetHistorico(pagar, parametro);
                dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                dados.fltValorLancamento := pagar.fltValorOrdemPagamento;
                dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                dados.strCCusto := pagar.strCodEve;
                dados.strOrigemCredito := parametro.fOrigemCredito;
                dados.strOrigemDebito := parametro.fOrigemDebito;
                dados.strCtpInc := pagar.strAutoincrem;
                dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito, pfpOrdemPagamento);
                dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito, pfpOrdemPagamento);
                dados.strFormaPagamento := parametro.strFormaPagamento ;
                dados.strPagamento := pagar.strTipoPagamento;
                dados.blnIsCtpDet := pagar.IsCtpDet;
                dados.blnIsAgrup := pagar.strSerie = 'AG';
                dados.strCliFor := pagar.participante.strCodigo ;
                dados.strTip_fc := 'F' ;
                dados.strForPgo := parametro.strFormaPagamento;
                dados.strSeqPar := parametro.strSequenciaParametro;
                dados.strInvNco := 'N';
                pAdicionaLista(dados, pagar) ;
              end;

              //se for Vr.Juros
              if (pagar.fltValorOrdemPagamento > 0) and (pagar.fltValorJuros > 0) then
              begin
                if (parametro.strDescricaoValor = DES_VALOR_JUROS) then
                begin
                  blnFlagParcon := True ;
                  ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_TODAS, DES_VALOR_JUROS, pagar.strTipoPagamento, intControle, pagar, parametro);
                  dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                  dados.strSeqLan := '';
                  dados.empresa := pagar.empresaBaixa;
                  dados.empresaCtpDet := pagar.empresaCtpDet;
                  dados.dtaLancamento := pagar.dtaDataPagamento;
                  dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                  dados.strCfopConfig := '';
                  dados.strNaturezaOperacao := '';
                  dados.strDescricaoValor := DES_VALOR_JUROS;

                  dados.strContaCredito := fRetContaCredito(pagar, parametro, pfpOrdemPagamento); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemCreditoEnum(parametro),
                    tpcCredito,
                    parametro.strBaixaCadastroCredito,
                    pfpOrdemPagamento,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriC := LTpOri;
                  dados.strCdOriC := LCdOri;
                  dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                  dados.strContaDebito := fRetContaDebito(pagar, parametro, pfpOrdemPagamento); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemDebitoEnum(parametro),
                    tpcDebito,
                    parametro.strBaixaCadastroDebito,
                    pfpOrdemPagamento,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriD := LTpOri;
                  dados.strCdOriD := LCdOri;
                  dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                  dados.strNumDoc := pagar.strNumero;

                  dados.strHistorico := fRetHistorico(pagar, parametro);
                  dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                  dados.fltValorLancamento := (pagar.fltValorOrdemPagamento / pagar.fltValorPago) * pagar.fltValorJuros;
                  dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                  dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                  dados.strCCusto := fRetornaEventoDescontoJuros(pagar.strCodEve, dados.strDescricaoValor) ;
                  dados.strOrigemCredito := parametro.fOrigemCredito;
                  dados.strOrigemDebito := parametro.fOrigemDebito;
                  dados.strCtpInc := pagar.strAutoincrem;
                  dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito, pfpOrdemPagamento);
                  dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito, pfpOrdemPagamento);
                  dados.strFormaPagamento := parametro.strFormaPagamento ;
                  dados.strPagamento := pagar.strTipoPagamento;
                  dados.blnIsCtpDet := pagar.IsCtpDet;
                  dados.blnIsAgrup := pagar.strSerie = 'AG';
                  dados.strCliFor := pagar.participante.strCodigo ;
                  dados.strTip_fc := 'F' ;
                  dados.strForPgo := parametro.strFormaPagamento;
                  dados.strSeqPar := parametro.strSequenciaParametro;
                  dados.strInvNco := 'N';
                  pAdicionaLista(dados, pagar) ;
                end;
                ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_TODAS, DES_VALOR_JUROS, pagar.strTipoPagamento, intControle, pagar, parametro);
              end ;

              pAdicionarLancamento(pagar, parametro, DES_VALOR_MULTA, (pagar.fltValorOrdemPagamento / pagar.fltValorPago) * pagar.fltValorMulta, ctrlCtpParcon, intControle, blnFlagParcon, pagar.dtaDataPagamento, TIPO_CONTAS_PAGAR, FPG_ORDPAG);
              pAdicionarLancamento(pagar, parametro, DES_VALOR_VENDOR, (pagar.fltValorOrdemPagamento / pagar.fltValorPago) * pagar.fltValorVendor, ctrlCtpParcon, intControle, blnFlagParcon, pagar.dtaDataPagamento, TIPO_CONTAS_PAGAR, FPG_ORDPAG);

              If (pagar.fltValorOrdemPagamento > 0) And (parametro.strDescricaoValor = DES_VALOR_ORIGINAL) Then
              Begin
                blnFlagParcon := True ;
                ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_ORDPAG, DES_VALOR_ORIGINAL, pagar.strTipoPagamento, intControle, pagar, parametro);
                dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                dados.strSeqLan := '';
                dados.empresa := pagar.empresaBaixa;
                dados.empresaCtpDet := pagar.empresaCtpDet;
                dados.dtaLancamento := pagar.dtaDataPagamento;
                dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                dados.strCfopConfig := '';
                dados.strNaturezaOperacao := '';
                dados.strDescricaoValor := DES_VALOR_ORIGINAL;

                dados.strContaCredito := fRetContaCredito(pagar, parametro, pfpOrdemPagamento); //retorna a conta com base nas regras definidas no parametro contabil
                pRetornaDadosOrigem(
                  pagar,
                  parametro,
                  fOrigemCreditoEnum(parametro),
                  tpcCredito,
                  parametro.strBaixaCadastroCredito,
                  pfpOrdemPagamento,
                  LTpOri,
                  LCdOri);
                dados.strTpOriC := LTpOri;
                dados.strCdOriC := LCdOri;
                dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                dados.strContaDebito := fRetContaDebito(pagar, parametro, pfpOrdemPagamento); //retorna a conta com base nas regras definidas no parametro contabil
                pRetornaDadosOrigem(
                  pagar,
                  parametro,
                  fOrigemDebitoEnum(parametro),
                  tpcDebito,
                  parametro.strBaixaCadastroDebito,
                  pfpOrdemPagamento,
                  LTpOri,
                  LCdOri);
                dados.strTpOriD := LTpOri;
                dados.strCdOriD := LCdOri;
                dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                dados.strNumDoc := pagar.strNumero;

                dados.strHistorico := fRetHistorico(pagar, parametro);
                dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                dados.fltValorLancamento := pagar.fltValorOrdemPagamento - (((pagar.fltValorOrdemPagamento / pagar.fltValorPago) * pagar.fltValorMulta) + ((pagar.fltValorOrdemPagamento / pagar.fltValorPago) * pagar.fltValorJuros) - ((pagar.fltValorOrdemPagamento / pagar.fltValorPago) * pagar.fltValorDesconto));
                dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                dados.strCCusto := pagar.strCodEve;
                dados.strOrigemCredito := parametro.fOrigemCredito;
                dados.strOrigemDebito := parametro.fOrigemDebito;
                dados.strCtpInc := pagar.strAutoincrem;
                dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito, pfpOrdemPagamento);
                dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito, pfpOrdemPagamento);
                dados.strFormaPagamento := parametro.strFormaPagamento ;
                dados.strPagamento := pagar.strTipoPagamento;
                dados.blnIsCtpDet := pagar.IsCtpDet;
                dados.blnIsAgrup := pagar.strSerie = 'AG';
                dados.strCliFor := pagar.participante.strCodigo ;
                dados.strTip_fc := 'F' ;
                dados.strForPgo := parametro.strFormaPagamento;
                dados.strSeqPar := parametro.strSequenciaParametro;
                dados.strInvNco := 'N';
                pAdicionaLista(dados, pagar) ;
              End;

              //se for Vr.Desconto
              if (pagar.fltValorOrdemPagamento > 0) and (pagar.fltValorDesconto > 0) then
              begin
                if (parametro.strDescricaoValor = DES_VALOR_DESCONTO) then
                begin
                  blnFlagParcon := True ;
                  ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_TODAS, DES_VALOR_DESCONTO, pagar.strTipoPagamento, intControle, pagar, parametro);
                  dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                  dados.strSeqLan := '';
                  dados.empresa := pagar.empresaBaixa;
                  dados.empresaCtpDet := pagar.empresaCtpDet;
                  dados.dtaLancamento := pagar.dtaDataPagamento;
                  dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                  dados.strCfopConfig := '';
                  dados.strNaturezaOperacao := '';
                  dados.strDescricaoValor := DES_VALOR_DESCONTO;

                  dados.strContaCredito := fRetContaCredito(pagar, parametro, pfpOrdemPagamento); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemCreditoEnum(parametro),
                    tpcCredito,
                    parametro.strBaixaCadastroCredito,
                    pfpOrdemPagamento,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriC := LTpOri;
                  dados.strCdOriC := LCdOri;
                  dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                  dados.strContaDebito := fRetContaDebito(pagar, parametro, pfpOrdemPagamento); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemDebitoEnum(parametro),
                    tpcDebito,
                    parametro.strBaixaCadastroDebito,
                    pfpOrdemPagamento,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriD := LTpOri;
                  dados.strCdOriD := LCdOri;
                  dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                  dados.strNumDoc := pagar.strNumero;

                  dados.strHistorico := fRetHistorico(pagar, parametro);
                  dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                  dados.fltValorLancamento := (pagar.fltValorOrdemPagamento / pagar.fltValorPago) * pagar.fltValorDesconto;
                  dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                  dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                  dados.strCCusto := fRetornaEventoDescontoJuros(pagar.strCodEve, dados.strDescricaoValor) ;
                  dados.strOrigemCredito := parametro.fOrigemCredito;
                  dados.strOrigemDebito := parametro.fOrigemDebito;
                  dados.strCtpInc := pagar.strAutoincrem;
                  dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito, pfpOrdemPagamento);
                  dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito, pfpOrdemPagamento);
                  dados.strFormaPagamento := parametro.strFormaPagamento ;
                  dados.strPagamento := pagar.strTipoPagamento;
                  dados.blnIsCtpDet := pagar.IsCtpDet;
                  dados.blnIsAgrup := pagar.strSerie = 'AG';
                  dados.strCliFor := pagar.participante.strCodigo ;
                  dados.strTip_fc := 'F' ;
                  dados.strForPgo := parametro.strFormaPagamento;
                  dados.strSeqPar := parametro.strSequenciaParametro;
                  dados.strInvNco := 'N';
                  pAdicionaLista(dados, pagar) ;
                end;
                ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_TODAS, DES_VALOR_DESCONTO, pagar.strTipoPagamento, intControle, pagar, parametro);
              end ;

            end;
            ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_ORDPAG, DES_VALOR_PAGO, pagar.strTipoPagamento, intControle, pagar, parametro);
            ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_ORDPAG, DES_VALOR_ORIGINAL, pagar.strTipoPagamento, intControle, pagar, parametro);
          end ;

          //Vr. Pis Receita Financeira
          if (pagar.fltValorPisRF > 0) then
          begin
            if (parametro.strDescricaoValor = DES_VALOR_PIS_RF) then
            begin
              blnFlagParcon := True ;
              ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_TODAS, DES_VALOR_PIS_RF, pagar.strTipoPagamento, intControle, pagar, parametro);
              dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

              dados.strSeqLan := '';
              dados.empresa := pagar.empresaBaixa;
              dados.empresaCtpDet := pagar.empresaCtpDet;
              dados.dtaLancamento := pagar.dtaDataPagamento;
              dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
              dados.strCfopConfig := '';
              dados.strNaturezaOperacao := '';
              dados.strDescricaoValor := DES_VALOR_PIS_RF;

              dados.strContaCredito := fRetContaCredito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
              pRetornaDadosOrigem(
                pagar,
                parametro,
                fOrigemCreditoEnum(parametro),
                tpcCredito,
                parametro.strBaixaCadastroCredito,
                pfpNaoEspecificado,
                LTpOri,
                LCdOri);
              dados.strTpOriC := LTpOri;
              dados.strCdOriC := LCdOri;
              dados.strOpBcCr := parametro.strBaixaCadastroCredito;

              dados.strContaDebito := fRetContaDebito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
              pRetornaDadosOrigem(
                pagar,
                parametro,
                fOrigemDebitoEnum(parametro),
                tpcDebito,
                parametro.strBaixaCadastroDebito,
                pfpNaoEspecificado,
                LTpOri,
                LCdOri);
              dados.strTpOriD := LTpOri;
              dados.strCdOriD := LCdOri;
              dados.strOpBcDb := parametro.strBaixaCadastroDebito;
              dados.strNumDoc := pagar.strNumero;

              dados.strHistorico := fRetHistorico(pagar, parametro);
              dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
              dados.fltValorLancamento := pagar.fltValorPisRF;
              dados.blnParametrizouCredito := parametro.fParametrizouCredito;
              dados.blnParametrizouDebito := parametro.fParametrizouDebito;
              dados.strCCusto := pagar.strCodEve;
              dados.strOrigemCredito := parametro.fOrigemCredito;
              dados.strOrigemDebito := parametro.fOrigemDebito;
              dados.strCtpInc := pagar.strAutoincrem;
              dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito);
              dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito);
              dados.strFormaPagamento := parametro.strFormaPagamento ;
              dados.strPagamento := pagar.strTipoPagamento;
              dados.blnIsCtpDet := pagar.IsCtpDet;
              dados.blnIsAgrup := pagar.strSerie = 'AG';
              dados.strCliFor := pagar.participante.strCodigo ;
              dados.strTip_fc := 'F' ;
              dados.strForPgo := parametro.strFormaPagamento;
              dados.strSeqPar := parametro.strSequenciaParametro;
              dados.strInvNco := 'N';
              pAdicionaLista(dados, pagar) ;
            end;
            ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_TODAS, DES_VALOR_PIS_RF, pagar.strTipoPagamento, intControle, pagar, parametro);
          end;

          //Vr. Cofins Receita Financeira
          if (pagar.fltValorCofinsRF > 0) then
          begin
            if (parametro.strDescricaoValor = DES_VALOR_COF_RF) then
            begin
              blnFlagParcon := True ;
              ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_TODAS, DES_VALOR_COF_RF, pagar.strTipoPagamento, intControle, pagar, parametro);
              dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

              dados.strSeqLan := '';
              dados.empresa := pagar.empresaBaixa;
              dados.empresaCtpDet := pagar.empresaCtpDet;
              dados.dtaLancamento := pagar.dtaDataPagamento;
              dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
              dados.strCfopConfig := '';
              dados.strNaturezaOperacao := '';
              dados.strDescricaoValor := DES_VALOR_COF_RF;

              dados.strContaCredito := fRetContaCredito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
              pRetornaDadosOrigem(
                pagar,
                parametro,
                fOrigemCreditoEnum(parametro),
                tpcCredito,
                parametro.strBaixaCadastroCredito,
                pfpNaoEspecificado,
                LTpOri,
                LCdOri);
              dados.strTpOriC := LTpOri;
              dados.strCdOriC := LCdOri;
              dados.strOpBcCr := parametro.strBaixaCadastroCredito;

              dados.strContaDebito := fRetContaDebito(pagar, parametro); //retorna a conta com base nas regras definidas no parametro contabil
              pRetornaDadosOrigem(
                pagar,
                parametro,
                fOrigemDebitoEnum(parametro),
                tpcDebito,
                parametro.strBaixaCadastroDebito,
                pfpNaoEspecificado,
                LTpOri,
                LCdOri);
              dados.strTpOriD := LTpOri;
              dados.strCdOriD := LCdOri;
              dados.strOpBcDb := parametro.strBaixaCadastroDebito;
              dados.strNumDoc := pagar.strNumero;

              dados.strHistorico := fRetHistorico(pagar, parametro);
              dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
              dados.fltValorLancamento := pagar.fltValorCofinsRF;
              dados.blnParametrizouCredito := parametro.fParametrizouCredito;
              dados.blnParametrizouDebito := parametro.fParametrizouDebito;
              dados.strCCusto := pagar.strCodEve;
              dados.strOrigemCredito := parametro.fOrigemCredito;
              dados.strOrigemDebito := parametro.fOrigemDebito;
              dados.strCtpInc := pagar.strAutoincrem;
              dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito);
              dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito);
              dados.strFormaPagamento := parametro.strFormaPagamento ;
              dados.strPagamento := pagar.strTipoPagamento;
              dados.blnIsCtpDet := pagar.IsCtpDet;
              dados.blnIsAgrup := pagar.strSerie = 'AG';
              dados.strCliFor := pagar.participante.strCodigo ;
              dados.strTip_fc := 'F' ;
              dados.strForPgo := parametro.strFormaPagamento;
              dados.strSeqPar := parametro.strSequenciaParametro;
              dados.strInvNco := 'N';
              pAdicionaLista(dados, pagar) ;
            end;
            ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_TODAS, DES_VALOR_COF_RF, pagar.strTipoPagamento, intControle, pagar, parametro);
          end;

          // CRÉDITO, CRÉDITO NÃO TEM UMA COLUNA NA CADPAG POR ISSO NÃO ENTRA NO TODOS
          if (pagar.fltValorDinheiro < 0) then
          begin
            if ((parametro.strFormaPagamento = FPG_CREDITO)) then
            begin
              //se for Vr.pago
              if (parametro.strDescricaoValor = DES_VALOR_PAGO) and (not pagar.blnDescJurAjustado) then
              begin
                blnFlagParcon := True ;
                ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_CREDITO, DES_VALOR_PAGO, pagar.strTipoPagamento, intControle, pagar, parametro);
                dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                dados.strSeqLan := '';
                dados.empresa := pagar.empresaBaixa;
                dados.empresaCtpDet := pagar.empresaCtpDet;
                dados.dtaLancamento := pagar.dtaDataPagamento;
                dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                dados.strCfopConfig := '';
                dados.strNaturezaOperacao := '';
                dados.strDescricaoValor := DES_VALOR_PAGO;

                dados.strContaCredito := fRetContaCredito(pagar, parametro, pfpDinheiro); //retorna a conta com base nas regras definidas no parametro contabil
                pRetornaDadosOrigem(
                  pagar,
                  parametro,
                  fOrigemCreditoEnum(parametro),
                  tpcCredito,
                  parametro.strBaixaCadastroCredito,
                  pfpDinheiro,
                  LTpOri,
                  LCdOri);
                dados.strTpOriC := LTpOri;
                dados.strCdOriC := LCdOri;
                dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                dados.strContaDebito := fRetContaDebito(pagar, parametro, pfpDinheiro); //retorna a conta com base nas regras definidas no parametro contabil
                pRetornaDadosOrigem(
                  pagar,
                  parametro,
                  fOrigemDebitoEnum(parametro),
                  tpcDebito,
                  parametro.strBaixaCadastroDebito,
                  pfpDinheiro,
                  LTpOri,
                  LCdOri);
                dados.strTpOriD := LTpOri;
                dados.strCdOriD := LCdOri;
                dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                dados.strNumDoc := pagar.strNumero;

                dados.strHistorico := fRetHistorico(pagar, parametro);
                dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                dados.fltValorLancamento := pagar.fltValorDinheiro;
                dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                dados.strCCusto := pagar.strCodEve;
                dados.strOrigemCredito := parametro.fOrigemCredito;
                dados.strOrigemDebito := parametro.fOrigemDebito;
                dados.strCtpInc := pagar.strAutoincrem;
                dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito, pfpDinheiro);
                dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito, pfpDinheiro);
                dados.strFormaPagamento := parametro.strFormaPagamento ;
                dados.strPagamento := pagar.strTipoPagamento;
                dados.blnIsCtpDet := pagar.IsCtpDet;
                dados.blnIsAgrup := pagar.strSerie = 'AG';
                dados.strCliFor := pagar.participante.strCodigo ;
                dados.strTip_fc := 'F' ;
                dados.strForPgo := parametro.strFormaPagamento;
                dados.strSeqPar := parametro.strSequenciaParametro;
                dados.strInvNco := 'N';
                pAdicionaLista(dados, pagar) ;
              end;

              //se for Vr.Juros
              if (pagar.fltValorDinheiro < 0) and (pagar.fltValorJuros <> 0) then
              begin
                if (parametro.strDescricaoValor = DES_VALOR_JUROS) then
                begin
                  blnFlagParcon := True ;
                  ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_CREDITO, DES_VALOR_JUROS, pagar.strTipoPagamento, intControle, pagar, parametro);
                  dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                  dados.strSeqLan := '';
                  dados.empresa := pagar.empresaBaixa;
                  dados.empresaCtpDet := pagar.empresaCtpDet;
                  dados.dtaLancamento := pagar.dtaDataPagamento;
                  dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                  dados.strCfopConfig := '';
                  dados.strNaturezaOperacao := '';
                  dados.strDescricaoValor := DES_VALOR_JUROS;

                  dados.strContaCredito := fRetContaCredito(pagar, parametro, pfpDinheiro); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemCreditoEnum(parametro),
                    tpcCredito,
                    parametro.strBaixaCadastroCredito,
                    pfpDinheiro,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriC := LTpOri;
                  dados.strCdOriC := LCdOri;
                  dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                  dados.strContaDebito := fRetContaDebito(pagar, parametro, pfpDinheiro); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemDebitoEnum(parametro),
                    tpcDebito,
                    parametro.strBaixaCadastroDebito,
                    pfpDinheiro,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriD := LTpOri;
                  dados.strCdOriD := LCdOri;
                  dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                  dados.strNumDoc := pagar.strNumero;

                  dados.strHistorico := fRetHistorico(pagar, parametro);
                  dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                  dados.fltValorLancamento := (pagar.fltValorDinheiro / pagar.fltValorPago) * pagar.fltValorJuros;
                  dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                  dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                  dados.strCCusto := fRetornaEventoDescontoJuros(pagar.strCodEve, dados.strDescricaoValor) ;
                  dados.strOrigemCredito := parametro.fOrigemCredito;
                  dados.strOrigemDebito := parametro.fOrigemDebito;
                  dados.strCtpInc := pagar.strAutoincrem;
                  dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito, pfpDinheiro);
                  dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito, pfpDinheiro);
                  dados.strFormaPagamento := parametro.strFormaPagamento ;
                  dados.strPagamento := pagar.strTipoPagamento;
                  dados.blnIsCtpDet := pagar.IsCtpDet;
                  dados.blnIsAgrup := pagar.strSerie = 'AG';
                  dados.strCliFor := pagar.participante.strCodigo ;
                  dados.strTip_fc := 'F' ;
                  dados.strForPgo := parametro.strFormaPagamento;
                  dados.strSeqPar := parametro.strSequenciaParametro;
                  dados.strInvNco := 'N';
                  pAdicionaLista(dados, pagar) ;
                end;
                ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_CREDITO, DES_VALOR_JUROS, pagar.strTipoPagamento, intControle, pagar, parametro);
              end ;

              pAdicionarLancamento(pagar, parametro, DES_VALOR_MULTA, (pagar.fltValorDinheiro / pagar.fltValorPago) * pagar.fltValorMulta, ctrlCtpParcon, intControle, blnFlagParcon, pagar.dtaDataPagamento, TIPO_CONTAS_PAGAR, FPG_CREDITO);
              pAdicionarLancamento(pagar, parametro, DES_VALOR_VENDOR, (pagar.fltValorDinheiro / pagar.fltValorPago) * pagar.fltValorVendor, ctrlCtpParcon, intControle, blnFlagParcon, pagar.dtaDataPagamento, TIPO_CONTAS_PAGAR, FPG_CREDITO);

              If (pagar.fltValorDinheiro < 0) And (parametro.strDescricaoValor = DES_VALOR_ORIGINAL) Then
              Begin
                blnFlagParcon := True ;
                ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_CREDITO, DES_VALOR_ORIGINAL, pagar.strTipoPagamento, intControle, pagar, parametro);
                dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                dados.strSeqLan := '';
                dados.empresa := pagar.empresaBaixa;
                dados.empresaCtpDet := pagar.empresaCtpDet;
                dados.dtaLancamento := pagar.dtaDataPagamento;
                dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                dados.strCfopConfig := '';
                dados.strNaturezaOperacao := '';
                dados.strDescricaoValor := DES_VALOR_ORIGINAL;

                dados.strContaCredito := fRetContaCredito(pagar, parametro, pfpDinheiro); //retorna a conta com base nas regras definidas no parametro contabil
                pRetornaDadosOrigem(
                  pagar,
                  parametro,
                  fOrigemCreditoEnum(parametro),
                  tpcCredito,
                  parametro.strBaixaCadastroCredito,
                  pfpDinheiro,
                  LTpOri,
                  LCdOri);
                dados.strTpOriC := LTpOri;
                dados.strCdOriC := LCdOri;
                dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                dados.strContaDebito := fRetContaDebito(pagar, parametro, pfpDinheiro); //retorna a conta com base nas regras definidas no parametro contabil
                pRetornaDadosOrigem(
                  pagar,
                  parametro,
                  fOrigemDebitoEnum(parametro),
                  tpcDebito,
                  parametro.strBaixaCadastroDebito,
                  pfpDinheiro,
                  LTpOri,
                  LCdOri);
                dados.strTpOriD := LTpOri;
                dados.strCdOriD := LCdOri;
                dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                dados.strNumDoc := pagar.strNumero;

                dados.strHistorico := fRetHistorico(pagar, parametro);
                dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                dados.fltValorLancamento := pagar.fltValorDinheiro - (((pagar.fltValorDinheiro / pagar.fltValorPago) * pagar.fltValorMulta) + ((pagar.fltValorDinheiro / pagar.fltValorPago) * pagar.fltValorJuros) - ((pagar.fltValorDinheiro / pagar.fltValorPago) * pagar.fltValorDesconto));
                dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                dados.strCCusto := pagar.strCodEve;
                dados.strOrigemCredito := parametro.fOrigemCredito;
                dados.strOrigemDebito := parametro.fOrigemDebito;
                dados.strCtpInc := pagar.strAutoincrem;
                dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito, pfpDinheiro);
                dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito, pfpDinheiro);
                dados.strFormaPagamento := parametro.strFormaPagamento ;
                dados.strPagamento := pagar.strTipoPagamento;
                dados.blnIsCtpDet := pagar.IsCtpDet;
                dados.blnIsAgrup := pagar.strSerie = 'AG';
                dados.strCliFor := pagar.participante.strCodigo ;
                dados.strTip_fc := 'F' ;
                dados.strForPgo := parametro.strFormaPagamento;
                dados.strSeqPar := parametro.strSequenciaParametro;
                dados.strInvNco := 'N';
                pAdicionaLista(dados, pagar) ;
              End;

              //se for Vr.Desconto
              if (pagar.fltValorDinheiro < 0) and (pagar.fltValorDesconto <> 0) then
              begin
                if (parametro.strDescricaoValor = DES_VALOR_DESCONTO) then
                begin
                  blnFlagParcon := True ;
                  ctrlCtpParcon.Remove(TIPO_CONTAS_PAGAR, FPG_CREDITO, DES_VALOR_DESCONTO, pagar.strTipoPagamento, intControle, pagar, parametro);
                  dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);

                  dados.strSeqLan := '';
                  dados.empresa := pagar.empresaBaixa;
                  dados.empresaCtpDet := pagar.empresaCtpDet;
                  dados.dtaLancamento := pagar.dtaDataPagamento;
                  dados.strTipoLancamento := TIPO_CONTAS_PAGAR;
                  dados.strCfopConfig := '';
                  dados.strNaturezaOperacao := '';
                  dados.strDescricaoValor := DES_VALOR_DESCONTO;

                  dados.strContaCredito := fRetContaCredito(pagar, parametro, pfpDinheiro); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemCreditoEnum(parametro),
                    tpcCredito,
                    parametro.strBaixaCadastroCredito,
                    pfpDinheiro,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriC := LTpOri;
                  dados.strCdOriC := LCdOri;
                  dados.strOpBcCr := parametro.strBaixaCadastroCredito;

                  dados.strContaDebito := fRetContaDebito(pagar, parametro, pfpDinheiro); //retorna a conta com base nas regras definidas no parametro contabil
                  pRetornaDadosOrigem(
                    pagar,
                    parametro,
                    fOrigemDebitoEnum(parametro),
                    tpcDebito,
                    parametro.strBaixaCadastroDebito,
                    pfpDinheiro,
                    LTpOri,
                    LCdOri);
                  dados.strTpOriD := LTpOri;
                  dados.strCdOriD := LCdOri;
                  dados.strOpBcDb := parametro.strBaixaCadastroDebito;
                  dados.strNumDoc := pagar.strNumero;

                  dados.strHistorico := fRetHistorico(pagar, parametro);
                  dados.intCodigoHistoricoPadrao := fRetCodigoHistoricoPadrao(pagar, parametro, dados.strTipoLancamento);
                  dados.fltValorLancamento := (pagar.fltValorDinheiro / pagar.fltValorPago) * pagar.fltValorDesconto;
                  dados.blnParametrizouCredito := parametro.fParametrizouCredito;
                  dados.blnParametrizouDebito := parametro.fParametrizouDebito;
                  dados.strCCusto := fRetornaEventoDescontoJuros(pagar.strCodEve, dados.strDescricaoValor) ;
                  dados.strOrigemCredito := parametro.fOrigemCredito;
                  dados.strOrigemDebito := parametro.fOrigemDebito;
                  dados.strCtpInc := pagar.strAutoincrem;
                  dados.strCodigoContabilizavelCredito := fRetCodigoContabilizavel(pagar, dados.strOrigemCredito, dados.strContaCredito, dados.strContaDebito, pfpDinheiro);
                  dados.strCodigoContabilizavelDebito := fRetCodigoContabilizavel(pagar, dados.strOrigemDebito, dados.strContaCredito, dados.strContaDebito, pfpDinheiro);
                  dados.strFormaPagamento := parametro.strFormaPagamento ;
                  dados.strPagamento := pagar.strTipoPagamento;
                  dados.blnIsCtpDet := pagar.IsCtpDet;
                  dados.blnIsAgrup := pagar.strSerie = 'AG';
                  dados.strCliFor := pagar.participante.strCodigo ;
                  dados.strTip_fc := 'F' ;
                  dados.strForPgo := parametro.strFormaPagamento;
                  dados.strSeqPar := parametro.strSequenciaParametro;
                  dados.strInvNco := 'N';
                  pAdicionaLista(dados, pagar) ;
                end;
                ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_CREDITO, DES_VALOR_DESCONTO, pagar.strTipoPagamento, intControle, pagar, parametro);
              end ;
              ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_CREDITO, DES_VALOR_PAGO, pagar.strTipoPagamento, intControle, pagar, parametro);
              ctrlCtpParcon.Add(TIPO_CONTAS_PAGAR, FPG_CREDITO, DES_VALOR_ORIGINAL, pagar.strTipoPagamento, intControle, pagar, parametro);
            end;

          end ;
        end;
      end;
      if not blnFlagParcon then
      begin
        dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);
        dados.strCtpInc := pagar.strAutoincrem;
        dados.empresa := pagar.empresaBaixa;
        dados.empresaCtpDet := pagar.empresaCtpDet;
        dados.dtaLancamento := pagar.dtaDataPagamento;
        dados.strMensagemUsuario := fNormalizaWarningGenerico('CTP', 'Nenhum valor atende aos parâmetros da PARCON!');
        if listaParametrosContabil.Count > 0 then
          dados.strHistorico := fRetHistorico(pagar, listaParametrosContabil.Items[0]);
        dados.strPagamento := pagar.strTipoPagamento;
        dados.strTipoLancamento := 'CTP' ;
        ListaDadosImportacaoContabilWarning.Add(dados) ;
      end ;
      pIncrementaLoop;
    end;

    lstPendencias := ctrlCtpParcon.Pendencias ;
    if lstPendencias.Count > 0 then
    begin
      for intCnt := 0 to lstPendencias.Count-1 do
      begin
        pagar := TControleParConCtpItem(lstPendencias.Objects[intCnt]).pagar ;
        parametro := TControleParConCtpItem(lstPendencias.Objects[intCnt]).parametro ;
        dados := TDadosImportacaoContabil.Create(VC_StrVersaoContabilidade, VS_strCodEmp);
        dados.strCtpInc := pagar.strAutoincrem;
        dados.empresa := pagar.empresaBaixa;
        dados.empresaCtpDet := pagar.empresaCtpDet;
        dados.dtaLancamento := pagar.dtaDataPagamento;
        dados.strMensagemUsuario := lstPendencias.Strings[intCnt];
        dados.strHistorico := fRetHistorico(pagar, parametro);
        dados.strFormaPagamento := parametro.strFormaPagamento ;
        dados.strPagamento := pagar.strTipoPagamento;
        dados.strTipoLancamento := 'CTP' ;
        ListaDadosImportacaoContabilWarning.Add(dados) ;
      end ;
    end ;

  finally
    ctrlCtpParcon.Free ;
  end ;
end;

procedure TGeradorContabilCtp.pRetornaDadosOrigem(
  const APagar: TContasPagar;
  const AParametro: TParametroContabil;
  const AOrigem: TOrigemPlanoContabil;
  const ADebitoCredito: TTipoPlanoContas;
  const ABaixaCadastro: string;
  const AFormaPagamento: TPortadorFormaPagamento;
  out AtipoOrigem, ACodigoOrigem: string);
var
  LstrTipoLancamento: string;
  LstrContaContabil: string;
begin
  AtipoOrigem    := CODIGO_ORIGEM_PLANO_CONTABIL[AOrigem];
  ACodigoOrigem  := EmptyStr;
  LstrTipoLancamento := AParametro.strTipoLancamento;

  case AOrigem of
    opcCliFor:
      ACodigoOrigem := APagar.participante.strCodigo;

    opcPortador:
      ACodigoOrigem := fRetCodigoPortador(APagar, AFormaPagamento);

    opcBandeira:
      ACodigoOrigem := EmptyStr;

    opcPlanoContas:
      begin
        if LstrTipoLancamento = TIPO_CONTAS_PAGAR_PROVISAO then
        begin
          if APagar.strCodCtaResultado.IsEmpty then
          begin
            if ABaixaCadastro = CONTA_DA_BAIXA then
              ACodigoOrigem := APagar.planoContasBaixa.strCodigo
            else
              ACodigoOrigem := APagar.planoContasCadastro.strCodigo;
          end
          else
            ACodigoOrigem := APagar.strCodCtaResultado;
        end
        else
        begin
          if ABaixaCadastro = CONTA_DA_BAIXA then
            ACodigoOrigem := APagar.planoContasBaixa.strCodigo
          else
            ACodigoOrigem := APagar.planoContasCadastro.strCodigo;
        end;
      end;
    opcParcon:
      begin
        LstrContaContabil := EmptyStr;
        if ADebitoCredito = tpcCredito then
        begin
          LstrContaContabil := AParametro.strContaCredito;
          if (LstrContaContabil.IsEmpty) and (not AParametro.strHashParCon.IsEmpty) then
            LstrContaContabil := fParNco(AParametro.strSequenciaParametro, fTrataCodigoEmpresa(APagar), 'C');
        end
        else if ADebitoCredito = tpcDebito then
        begin
          LstrContaContabil := AParametro.strContaDebito;
          if (LstrContaContabil.IsEmpty) and (not AParametro.strHashParCon.IsEmpty) then
            LstrContaContabil := fParNco(AParametro.strSequenciaParametro, fTrataCodigoEmpresa(APagar), 'D');
        end;
        if fEmptyStr(LstrContaContabil) then
          AtipoOrigem := EmptyStr;
      end;
  end;
end;

{ TControleParConCtp }

procedure TControleParConCtp.Add(const ATipoLancamento : string  ;
                                 const AFormaPagamento : string  ;
                                 const ADescricaoValor : string  ;
                                 const ATipoPagamento  : string  ;
                                 const AControle       : integer ;
                                       APagar          : TContasPagar ;
                                       AParametro      : TParametroContabil);
var
  item : TControleParConCtpItem ;
  intFlag : integer ;
  strChave : string ;
begin
  strChave := ATipoLancamento + '|' + AFormaPagamento + '|' + ADescricaoValor + '|' + ATipoPagamento + '|' + IntToStr(AControle) ;
  intFlag := FItens.IndexOf(strChave) ;
  if intFlag = -1 then
  begin
    item := TControleParConCtpItem.Create ;
    item.strTipoLancamento := ATipoLancamento ;
    item.strFormaPagamento := AFormaPagamento ;
    item.strDescricaoValor := ADescricaoValor ;
    item.strTipoPagamento := ATipoPagamento ;
    item.pagar := APagar ;
    item.parametro := AParametro ;
    item.blnNaoParametrizado := False ;
    FItens.AddObject(strChave, item) ;
  end;
end;

constructor TControleParConCtp.Create;
begin
  FItens := TStringList.Create ;
  FItens.Sorted := True ;
  FItensPendentes := TStringList.Create ;
end;

destructor TControleParConCtp.Destroy;
var
  intCnt : integer ;
begin
  FreeAndNil(FItensPendentes) ;
  for intCnt := 0 to FItens.Count-1 do
  begin
    TObject(FItens.Objects[intCnt]).Free ;
  end;
  FreeAndNil(FItens) ;
  inherited ;
end;

function TControleParConCtp.Pendencias: TStringList;
var
  intCnt : integer ;
  strPendencias : String ;
begin
  for intCnt := 0 to FItens.Count-1 do
  begin
    if not TControleParConCtpItem(FItens.Objects[intCnt]).blnNaoParametrizado then
    begin
      strPendencias := strPendencia(TControleParConCtpItem(FItens.Objects[intCnt])) ;
      FItensPendentes.AddObject(strPendencias, FItens.Objects[intCnt]) ;
    end;
  end;
  result := FItensPendentes ;
end;

procedure TControleParConCtp.Remove(const ATipoLancamento, AFormaPagamento,
  ADescricaoValor, ATipoPagamento: string; const AControle: integer;
  APagar: TContasPagar; AParametro : TParametroContabil);
var
  item : TControleParConCtpItem ;
  intFlag : integer ;
  strChave : string ;
begin
  strChave := ATipoLancamento + '|' + AFormaPagamento + '|' + ADescricaoValor + '|' + ATipoPagamento + '|' + IntToStr(AControle) ;
  intFlag := FItens.IndexOf(strChave) ;
  if intFlag = -1 then
  begin
    item := TControleParConCtpItem.Create ;
    item.strTipoLancamento := ATipoLancamento ;
    item.strFormaPagamento := AFormaPagamento ;
    item.strDescricaoValor := ADescricaoValor ;
    item.strTipoPagamento := ATipoPagamento ;
    item.pagar := APagar ;
    item.parametro := AParametro ;
    item.blnNaoParametrizado := True ;
    FItens.AddObject(strChave, item) ;
  end
  else
  begin
    TControleParConCtpItem(FItens.Objects[intFlag]).blnNaoParametrizado := True ;
  end;
end;

function TControleParConCtp.strPendencia(Item: TControleParConCtpItem): string;
begin
  result := '[CTP | ' ;
  result := result + Item.strDescricaoValor + ' | ' ;
  result := result + Item.strFormaPagamento + ' | ' ;
  result := result + Item.strTipoPagamento + ']' ;
end;

end.
