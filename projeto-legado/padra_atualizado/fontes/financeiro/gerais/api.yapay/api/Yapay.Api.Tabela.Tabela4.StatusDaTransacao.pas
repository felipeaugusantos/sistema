unit Yapay.Api.Tabela.Tabela4.StatusDaTransacao;

interface

uses
  System.SysUtils,
  System.Variants,
  System.Classes;

type
  TStatusTransacao = (Waiting_payment,
                      Processing,
                      Approved,
                      Canceled,
                      Contestation,
                      Monitoring,
                      Failed);

  TStatusTransacaoHelper = record helper for TStatusTransacao
  private
    type
      TDadosStatusTransacao = record
        Id: int64;
        Status: TStatusTransacao;
        Status_tag: string;
        Status_name: string;
      end;
  public
    function Dados: TDadosStatusTransacao;
    class function FindByCodigo(const Id: Int64): TStatusTransacao; static;
    class function FindByStatusTag(const Status_Tag: string): TStatusTransacao; static;
  end;

implementation

const
  DadosStatusTransacao: array[0..6] of TStatusTransacaoHelper.TDadosStatusTransacao =
    (
      (Id: 4;
       Status: Waiting_payment;
       Status_tag: 'waiting_payment';
       Status_name: 'Aguardando Pagamento'),

      (Id: 5;
       Status: Processing;
       Status_tag: 'processing';
       Status_name: 'Em Processamento'),

      (Id: 6;
       Status: Approved;
       Status_tag: 'approved';
       Status_name: 'Aprovada'),

      (Id: 7;
       Status: Canceled;
       Status_tag: 'canceled';
       Status_name: 'Cancelada'),

      (Id: 24;
       Status: Contestation;
       Status_tag: 'contestation';
       Status_name: 'Em Contestação'),

      (Id: 87;
       Status: Monitoring;
       Status_tag: 'monitoring';
       Status_name: 'Em Monitoramento'),

      (Id: 89;
       Status: Failed;
       Status_tag: 'failed';
       Status_name: 'Reprovada')
    );

{ TStatusTransacaoHelper }

function TStatusTransacaoHelper.Dados: TDadosStatusTransacao;
var
  oDadosStatusTransacao: TDadosStatusTransacao;
begin
  for oDadosStatusTransacao in DadosStatusTransacao do
  begin
    if oDadosStatusTransacao.Status = Self then
    begin
      result := oDadosStatusTransacao;
      Break;
    end;
  end;
end;

class function TStatusTransacaoHelper.FindByCodigo(const Id: Int64): TStatusTransacao;
var
  oDadosStatusTransacao: TDadosStatusTransacao;
begin
  Result := TStatusTransacao(-1);
  for oDadosStatusTransacao in DadosStatusTransacao do
  begin
    if oDadosStatusTransacao.Status.Dados.Id = Id then
    begin
      result := oDadosStatusTransacao.Status;
      Break;
    end;
  end;
end;

class function TStatusTransacaoHelper.FindByStatusTag(const Status_Tag: string): TStatusTransacao;
var
  oDadosStatusTransacao: TDadosStatusTransacao;
begin
  Result := TStatusTransacao(-1);
  for oDadosStatusTransacao in DadosStatusTransacao do
  begin
    if CompareText(oDadosStatusTransacao.Status.Dados.Status_tag, Status_Tag) = 0 then
    begin
      result := oDadosStatusTransacao.Status;
      Break;
    end;
  end;
end;

end.
