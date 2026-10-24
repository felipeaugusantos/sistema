unit CobrancaEletronica.Lib.Types;

interface

uses
  System.Generics.Collections;

const
  API_PAGARME                               = 'PME';
  API_PAGARME_ENVIADA                       = API_PAGARME+'E';
  API_PAGARME_CANCELADA                     = API_PAGARME+'C';
  API_PAGARME_COM_TRANSACAO                 = API_PAGARME+'T';
  API_PAGARME_COM_PAGAMENTO                 = API_PAGARME+'P';
  API_PAGARME_EXPIRADO                      = API_PAGARME+'X';
  API_PAGARME_BAIXA_PEDIDO_NAO_ENTREGUE     = API_PAGARME+'B';
  API_PAGARME_CANCELA_LINK_REMOVE_COBELT    = API_PAGARME+'R';
  API_PAGARME_CANCELA_LINK_CRIA_NOVO        = API_PAGARME+'N';
  API_PAGARME_V5                            = API_PAGARME+'V5';

  CBE_CRIAR                                 = 'CRIAR';
  CBE_BUSCAR                                = 'BUSCAR';
  CBE_CANCELAR                              = 'CANCELAR';
  CBE_CONFIRMAR_PAGTO                       = 'CONFIRMAR_PAGTO';

  SP_COBRANCA_ELETRONICA                    = 'PAGTO_ONLINE_COBELT_%s';
  SP_ATTEMPTS_LOCK                          = 10;
  SP_DISPARO_COBRANCA_ELETRONICA_AUTOMATICO = 'DISPARO_COBRANCA_ELETRONICA_AUTOMATICO';
  SP_DISPARO_COBRANCA_ELETRONICA_PARAMS     = '%s COBRANCA_ELETRONICA';

  FC_BOLETO                                 = 'boleto';
  FC_CARTAO_CREDITO                         = 'credit_card';

  PME_STATUS_AUTORIZADA                     = 'AUTHORIZED';
  PME_STATUS_BAIXADO                        = 'PAID';
  PME_STATUS_RECUSADO                       = 'REFUSED';
  PME_STATUS_ESTORNADO                      = 'REFUNDED';

type
  TListCB                       = TList<String>;
  TTipoCobrancaEletronica       = (tcPagarMe);
  TDicionarioCobrancaEletronica = class
  private
    class var FInstance : TDicionarioCobrancaEletronica;

    FCobrancaEletronica            : TDictionary<TTipoCobrancaEletronica, TListCB>;
    FRetornoCobrancaEletronica     : TDictionary<TTipoCobrancaEletronica, TListCB>;
    FStatusCobrancaEletronica      : TDictionary<String, String>;
    FApenasComTransacaoOuPagamento : Boolean;

    function getCobrancaEletronica: TDictionary<TTipoCobrancaEletronica, TListCB>;
    function getStatusCobranca: TDictionary<String, String>;
    procedure SetApenasComTransacaoOuPagamento(const Value: Boolean);

    procedure pLoadCobrancaEletronica;
    procedure pLoadStatusCobranca;

    constructor Create;
  public
    destructor Destroy; override;

    class function GetInstance: TDicionarioCobrancaEletronica;
    class procedure DestroyInstance;

    property TipoCobranca                  : TDictionary<TTipoCobrancaEletronica, TListCB> read getCobrancaEletronica;
    property StatusCobranca                : TDictionary<String, String>                   read getStatusCobranca;
    property ApenasComTransacaoOuPagamento : Boolean                                       write SetApenasComTransacaoOuPagamento;
  end;


implementation

uses
  System.Classes, System.SysUtils, System.StrUtils;

{ TDicionarioCobrancaEletronica }

constructor TDicionarioCobrancaEletronica.Create;
begin
  FCobrancaEletronica        := nil;
  FStatusCobrancaEletronica  := nil;
  FRetornoCobrancaEletronica := TDictionary<TTipoCobrancaEletronica, TListCB>.Create;

  pLoadCobrancaEletronica;
  pLoadStatusCobranca;
end;

destructor TDicionarioCobrancaEletronica.Destroy;
begin
  FreeAndNil(FCobrancaEletronica);
  FreeAndNil(FRetornoCobrancaEletronica);
  FreeAndNil(FStatusCobrancaEletronica);

  inherited;
end;

class procedure TDicionarioCobrancaEletronica.DestroyInstance;
begin
  If (Not Assigned(FInstance)) Then
    Exit;
  FreeAndNil(FInstance);
end;

function TDicionarioCobrancaEletronica.getCobrancaEletronica: TDictionary<TTipoCobrancaEletronica, TListCB>;
var
  LKey  : TTipoCobrancaEletronica;
  LItem : String;
begin
  FRetornoCobrancaEletronica.Clear;

  for LKey in FCobrancaEletronica.Keys do
  begin
    FRetornoCobrancaEletronica.Add(LKey, TList<String>.Create);

    for LItem in FCobrancaEletronica.Items[LKey] do
    begin
      if (LKey = tcPagarMe) and
         (FApenasComTransacaoOuPagamento) then
      begin
        if (LItem = API_PAGARME) or
           (LItem = API_PAGARME_ENVIADA) or
           (LItem = API_PAGARME_BAIXA_PEDIDO_NAO_ENTREGUE) or
           (LItem = API_PAGARME_EXPIRADO) or
           (LItem = API_PAGARME_CANCELADA) then
          Continue;
      end;

      FRetornoCobrancaEletronica.Items[LKey].Add(LItem);
    end;
  end;

  Result := FRetornoCobrancaEletronica;
end;

class function TDicionarioCobrancaEletronica.GetInstance: TDicionarioCobrancaEletronica;
begin
  if not Assigned(FInstance) then
    FInstance := TDicionarioCobrancaEletronica.Create;

  Result := FInstance;
end;

function TDicionarioCobrancaEletronica.getStatusCobranca: TDictionary<String, String>;
begin
  Result := FStatusCobrancaEletronica;
end;

procedure TDicionarioCobrancaEletronica.pLoadCobrancaEletronica;
begin
  FCobrancaEletronica := TDictionary<TTipoCobrancaEletronica, TListCB>.Create;

  FCobrancaEletronica.Add(tcPagarMe, TList<String>.Create);
  FCobrancaEletronica.Items[tcPagarMe].Add(API_PAGARME);
  FCobrancaEletronica.Items[tcPagarMe].Add(API_PAGARME_ENVIADA);
  FCobrancaEletronica.Items[tcPagarMe].Add(API_PAGARME_CANCELADA);
  FCobrancaEletronica.Items[tcPagarMe].Add(API_PAGARME_COM_TRANSACAO);
  FCobrancaEletronica.Items[tcPagarMe].Add(API_PAGARME_COM_PAGAMENTO);
  FCobrancaEletronica.Items[tcPagarMe].Add(API_PAGARME_EXPIRADO);
  FCobrancaEletronica.Items[tcPagarMe].Add(API_PAGARME_BAIXA_PEDIDO_NAO_ENTREGUE);
end;

procedure TDicionarioCobrancaEletronica.pLoadStatusCobranca;
begin
  FStatusCobrancaEletronica := TDictionary<String, String>.Create;
  FStatusCobrancaEletronica.Add('processing','Transação está em processo de autorização');
  FStatusCobrancaEletronica.Add('authorized','Transação foi autorizada');
  FStatusCobrancaEletronica.Add('paid','Transação paga');
  FStatusCobrancaEletronica.Add('refunded','Transação estornada completamente');
  FStatusCobrancaEletronica.Add('waiting_payment','Transação aguardando pagamento');
  FStatusCobrancaEletronica.Add('pending_refund','Transação do tipo Boleto e que está aguardando confirmação do estorno solicitado');
  FStatusCobrancaEletronica.Add('refused','Transação recusada, não autorizada');
  FStatusCobrancaEletronica.Add('chargedback','Transação sofreu chargeback');
  FStatusCobrancaEletronica.Add('analyzing','Transação encaminhada para a análise manual feita por um especialista em prevenção a fraude');
  FStatusCobrancaEletronica.Add('pending_review','Transação pendente de revisão manual por parte do lojista');
end;

procedure TDicionarioCobrancaEletronica.SetApenasComTransacaoOuPagamento(
  const Value: Boolean);
begin
  FApenasComTransacaoOuPagamento := Value;
end;

end.
