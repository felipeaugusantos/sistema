unit untLinkPagamentoCitelStatus;

interface

Const
  stTransacaoRecente = 'NOV';
  stTransacaoInvalida = 'INV';
  stTransacaoPendenteConfirmacao = 'PPC';
  stTransacaoDesfeita = 'PPN';
  stTransacaoAguardandoPagto = 'PEN';
  stTransacaoEfetuada = 'CON';
  stTransacaoNegada = 'NEG';
  stTransacaoErroEfetPagto = 'ERR';
  stTransacaoBloqueada = 'BLQ';
  stTransacaoExpirada = 'EXP';
  stTransacaoEstornada = 'EST';
  stAguardandoUsuario = 'AGU';
  stTransacaoAbandonada = 'ABA';
  stTransacaoCancelada = 'CAN';
  stTransacaoRetentativa = 'RET';
  stTransacaoRecenteEmailNaoEnviado = 'ENE';
  stTransacaoAguardandoSerEstornada = 'AES';
  stTransacaoDesvinculadaDocumento = 'TDD';
  stTransacaoErroPersistente = 'ELP';

  arrayStatus : array of string = [stTransacaoRecente,
                                 stTransacaoInvalida,
                                 stTransacaoPendenteConfirmacao,
                                 stTransacaoDesfeita,
                                 stTransacaoAguardandoPagto,
                                 stTransacaoEfetuada,
                                 stTransacaoNegada,
                                 stTransacaoErroEfetPagto,
                                 stTransacaoBloqueada,
                                 stTransacaoExpirada,
                                 stTransacaoEstornada,
                                 stAguardandoUsuario,
                                 stTransacaoAbandonada,
                                 stTransacaoCancelada,
                                 stTransacaoRetentativa,
                                 stTransacaoRecenteEmailNaoEnviado,
                                 stTransacaoAguardandoSerEstornada,
                                 stTransacaoDesvinculadaDocumento,
                                 stTransacaoErroPersistente];

type
  TPgtOnlineStatus = class
    private
      class function CaseOfString(s: string; a: array of string): Integer;
    public
      class function fTraduzStatusTransacao(strStatus : String) : String;
      class function fHabilitaNovoLink(strStatus : String) : Boolean;
      class function fHabilitaCancelamento(strStatus : String) : Boolean;
      class function fHabilitaDesvincularPedido(const AstrStatus: String): Boolean;
      class function fAtencaoDesvincularPedido(const AstrStatus: String): Boolean;
  end;

implementation

{ TPgtOnlineStatus }

class function TPgtOnlineStatus.fAtencaoDesvincularPedido(
  const AstrStatus: String): Boolean;
begin
  Result := ( (AstrStatus = stTransacaoRecente) or
              (AstrStatus = stTransacaoRecenteEmailNaoEnviado) or
              (AstrStatus = stAguardandoUsuario) )
end;

class function TPgtOnlineStatus.fHabilitaCancelamento(
  strStatus: String): Boolean;
begin
  Result := strStatus = stTransacaoEfetuada ;
end;

class function TPgtOnlineStatus.fHabilitaDesvincularPedido(
  const AstrStatus: String): Boolean;
begin
  Result := ( (AstrStatus = stTransacaoInvalida) or
              (AstrStatus = stTransacaoDesfeita) or
              (AstrStatus = stTransacaoNegada) or
              (AstrStatus = stTransacaoErroEfetPagto) or
              (AstrStatus = stTransacaoBloqueada) or
              (AstrStatus = stTransacaoExpirada) or
              (AstrStatus = stTransacaoAbandonada) or
              (AstrStatus = stTransacaoCancelada) or
              (AstrStatus = stTransacaoRecente) or
              (AstrStatus = stTransacaoRecenteEmailNaoEnviado) or
              (AstrStatus = stAguardandoUsuario) )
end;

class function TPgtOnlineStatus.fHabilitaNovoLink(strStatus: String): Boolean;
begin
  Result := ( (strStatus = stTransacaoInvalida) or
              (strStatus = stTransacaoDesfeita) or
              (strStatus = stTransacaoNegada) or
              (strStatus = stTransacaoErroEfetPagto) or
              (strStatus = stTransacaoBloqueada) or
              (strStatus = stTransacaoExpirada) or
              (strStatus = stTransacaoAbandonada) or
              (strStatus = stTransacaoCancelada) )
end;

class function TPgtOnlineStatus.fTraduzStatusTransacao(strStatus : String): String;
begin
  case CaseOfString(strStatus, arrayStatus) of
    0  : Result := 'Transação recém-criada.';
    1  : Result := 'Transação inválida.';
    2  : Result := 'Pagamento pendente de confirmação.';
    3  : Result := 'Pagamento pendente não confirmado(cancelado).';
    4  : Result := 'Transação aguardando resposta da instituição financeira.';
    5  : Result := 'Transação confirmada pela instituição financeira.';
    6  : Result := 'Transação negada pela instituição financeira.';
    7  : Result := 'Erro na comunicação com a autorizadora. Tente novamente.';
    8  : Result := 'Transação bloqueada após múltiplas tentativas de consulta de cartão.';
    9 : Result := 'A transação expirou devido ao prazo de validade do NIT.';
    10 : Result := 'Pagamento estornado.';
    11 : Result := 'Transação aguardando ação do usuário.';
    12 : Result := 'Transação expirou devido a tempo excessivo sem atualização por parte do usuário.';
    13 : Result := 'Transação cancelada pelo usuário/comprador.';
    14 : Result := 'Transação negada pela instituição financeira, porém agendada para retentativa.';
    15 : Result := 'Transação recem criada, e-mail não enviado.';
    16 : Result := 'Link de pagamento desvinculado do documento' ;
    17 : Result := 'Transação removida da fila após esgotar as tentativas de gravação no banco. Acionar o suporte (verificar LOGERR).';
  end;
end;

class function TPgtOnlineStatus.CaseOfString(s: string; a: array of string): Integer;
begin
  Result := 0;

  while (Result < Length(a)) and (a[Result] <> s) do
    Inc(Result);

  if (a[Result] <> s) then
    Result := -1;
end;

end.
