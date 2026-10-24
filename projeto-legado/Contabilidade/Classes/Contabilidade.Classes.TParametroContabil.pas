unit Contabilidade.Classes.TParametroContabil;

interface

type
  TParametroContabil = class
  private
    FSequenciaParametro: string;
    FTipoLancamento: string;
    FFormaPagamento: string;
    FNaturezaOperacao: string; //a vista, a prazo ou todos
    FDescricaoValor: string;
    FCfop: string;
    FContaCredito: string;
    FCreditoClienteFornecedor: Boolean;
    FCreditoPlanoContas: Boolean;
    FCreditoPortador: Boolean;
    FContaDebito: string;
    FDebitoClienteFornecedor: Boolean;
    FDebitoPlanoContas: Boolean;
    FDebitoPortador: Boolean;
    FComplementoDebito: string;
    FCodigoHistoricoPadrao: string;
    FDescricaoHistoricoPadrao: string;
    FDescricaoPagamento: String;
    FBaixaCadastroDebito: String;
    FBaixaCadastroCredito: String;
    FHashParCon: string;
    FDebitoBandeira: boolean;
    FCreditoBandeira: boolean;
    FComplementosParametro: string;
    FDebitoAbreviacao: boolean;
    FCreditoAbreviacao: boolean;
    FPagamentoAntecipado: boolean;
    FVigenciaInicio: TDate;
    FVigenciaFinal: TDate;
    FCodigoOrigemDebito: string;
    FTipoOrigemDebito: string;
    FCodigoOrigemCredito: string;
    FTipoOrigemCredito: string;
  public
    function fParametrizouCredito : Boolean;
    function fParametrizouDebito : Boolean;
    function fOrigemCredito: String;
    function fOrigemDebito: String;
    property strSequenciaParametro: string read FSequenciaParametro write FSequenciaParametro;
    property strTipoLancamento: string read FTipoLancamento write FTipoLancamento;
    property strFormaPagamento: string read FFormaPagamento write FFormaPagamento;
    property strNaturezaOperacao: string read FNaturezaOperacao write FNaturezaOperacao; //a vista, a prazo ou todos
    property strDescricaoValor: string read FDescricaoValor write FDescricaoValor;
    property strCfop: string read FCfop write FCfop;
    property strContaCredito: string read FContaCredito write FContaCredito;
    property blnCreditoClienteFornecedor: Boolean read FCreditoClienteFornecedor write FCreditoClienteFornecedor;
    property blnCreditoPlanoContas: Boolean read FCreditoPlanoContas write FCreditoPlanoContas;
    property blnCreditoPortador: Boolean read FCreditoPortador write FCreditoPortador;
    property strContaDebito: string read FContaDebito write FContaDebito;
    property blnDebitoClienteFornecedor: Boolean read FDebitoClienteFornecedor write FDebitoClienteFornecedor;
    property blnDebitoPlanoContas: Boolean read FDebitoPlanoContas write FDebitoPlanoContas;
    property blnDebitoPortador: Boolean read FDebitoPortador write FDebitoPortador;
    property strComplementoDebito: string read FComplementoDebito write FComplementoDebito;
    property strCodigoHistoricoPadrao: string read FCodigoHistoricoPadrao write FCodigoHistoricoPadrao;
    property strDescricaoHistoricoPadrao: string read FDescricaoHistoricoPadrao write FDescricaoHistoricoPadrao;
    property strDescricaoPagamento: String read FDescricaoPagamento write FDescricaoPagamento;
    property strBaixaCadastroDebito: String read FBaixaCadastroDebito write FBaixaCadastroDebito;
    property strBaixaCadastroCredito: String read FBaixaCadastroCredito write FBaixaCadastroCredito;
    property strHashParCon: string read FHashParCon write FHashParCon;
    property blnDebitoBandeira: boolean read FDebitoBandeira write FDebitoBandeira;
    property blnCreditoBandeira: boolean read FCreditoBandeira write FCreditoBandeira;
    property strComplementosParametro: string read FComplementosParametro write FComplementosParametro;
    property blnDebitoAbreviacao: boolean read FDebitoAbreviacao write FDebitoAbreviacao;
    property blnCreditoAbreviacao: boolean read FCreditoAbreviacao write FCreditoAbreviacao;
    property blnPagamentoAntecipado: boolean read FPagamentoAntecipado write FPagamentoAntecipado;
    property dtaVigenciaInicio: TDate read FVigenciaInicio write FVigenciaInicio;
    property dtaVigenciaFinal: TDate read FVigenciaFinal write FVigenciaFinal;
    property strCodigoOrigemDebito: String read FCodigoOrigemDebito write FCodigoOrigemDebito;
    property strTipoOrigemDebito: String read FTipoOrigemDebito write FTipoOrigemDebito;
    property strCodigoOrigemCredito: String read FCodigoOrigemCredito write FCodigoOrigemCredito;
    property strTipoOrigemCredito: String read FTipoOrigemCredito write FTipoOrigemCredito;
  end;

implementation

uses SysUtils, Contabilidade.Interfaces;

{ TParametroContabil }

function TParametroContabil.fOrigemCredito: String;
begin
  Result := '';
  if (blnCreditoClienteFornecedor) then
    result := 'Cliente/Fornecedor'
  else if (blnCreditoPlanoContas) then
  begin
    result := DES_PLANO_DE_CONTAS;

    If (strTipoLancamento = 'CTP') Or
       (strTipoLancamento = 'PCP') Or
       (strTipoLancamento = 'CTR') Then
    Begin
      If (strBaixaCadastroCredito = CONTA_DA_BAIXA) Then
        Result := DES_PLANO_DE_CONTAS + ' (Baixa)'
      else If (strBaixaCadastroCredito = CONTA_DO_CADASTRO) Then
        Result := DES_PLANO_DE_CONTAS + ' (Cadastro)';
    End;
  end
  else if (blnCreditoPortador) then
    result := 'Portador'
  else if (blnCreditoBandeira) then
    result := 'Bandeira'
  else if (blnCreditoAbreviacao) then
    result := 'Abreviação'
  else if Trim(strContaCredito) <> '' then
    result := 'Conta Crédito' ;
end;

function TParametroContabil.fOrigemDebito: String;
begin
  Result := '';
  if (blnDebitoClienteFornecedor) then
    result := 'Cliente/Fornecedor'
  else if (blnDebitoPlanoContas) then
  begin
    result := DES_PLANO_DE_CONTAS;

    If (strTipoLancamento = 'CTP') Or
       (strTipoLancamento = 'PCP') Or
       (strTipoLancamento = 'CTR') Then
    Begin
      if (strBaixaCadastroCredito = CONTA_DA_BAIXA) Then
        Result := DES_PLANO_DE_CONTAS + ' (Baixa)'
      else If (strBaixaCadastroCredito = CONTA_DO_CADASTRO) Then
        Result := DES_PLANO_DE_CONTAS + ' (Cadastro)';
    End;
  end
  else if (blnDebitoPortador) then
    result := 'Portador'
  else if (blnDebitoBandeira) then
    result := 'Bandeira'
  else if (blnDebitoAbreviacao) then
    result := 'Abreviação'
  else if Trim(strContaDebito) <> '' then
    result := 'Conta Débito' ;
end;

function TParametroContabil.fParametrizouCredito: Boolean;
begin
  Result := blnCreditoClienteFornecedor Or
            blnCreditoPlanoContas Or
            blnCreditoPortador Or
            blnCreditoBandeira Or
            blnCreditoAbreviacao Or
            (Trim(strContaCredito) <> '');
end;

function TParametroContabil.fParametrizouDebito: Boolean;
begin
  Result := blnDebitoClienteFornecedor Or
            blnDebitoPlanoContas Or
            blnDebitoPortador Or
            blnDebitoBandeira Or
            blnDebitoAbreviacao Or
            (Trim(strContaDebito) <> '');
end;

end.

