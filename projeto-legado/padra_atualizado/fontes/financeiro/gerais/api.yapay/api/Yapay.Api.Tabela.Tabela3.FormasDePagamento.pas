unit Yapay.Api.Tabela.Tabela3.FormasDePagamento;

interface

uses
  System.SysUtils,
  System.Variants,
  System.Classes;

type
  TTiposCreditoParcelado = (x12, AVista);

  TTiposFormaPagamento = (TransferenciasOnline,
                          Boleto,
                          Saldo,
                          CartoesDeCredito);

  TFormasPagamento = (ItauShopline,
                      TransfOnlineBradesco,
                      TransfOnlineBancoDoBrasil,
                      BoletoBancario,
                      PagamentoComSaldo,
                      Visa,
                      Mastercard,
                      AmericanExpress,
                      Discover,
                      Elo,
                      Aura,
                      JCB,
                      Hipercard,
                      HiperItau);


type
  TFormasPagamentoHelper = record helper for TFormasPagamento
  private
    type
      TDadosFormaPagamento = record
        Id: int64;
        Descricao: string;
        TipoFormaPagamento: TTiposFormaPagamento;
        case FormaPagamento: TFormasPagamento of
          Visa, Mastercard, AmericanExpress, Discover, Elo, Aura, JCB, Hipercard, HiperItau:
            (CreditoParcelado: TTiposCreditoParcelado);
        end;
  public
    const
      Desconhecido = TFormasPagamento(-1);

    function Dados: TDadosFormaPagamento;
    class function FindById(Id: Int64): TFormasPagamento; static;
  end;

  TListFormasDePagamento = set of TFormasPagamento;

  TListFormasDePagamentoHelper = record helper for TListFormasDePagamento
    function ToString: string;
    class function FromString(const Value: string): TListFormasDePagamento; static;
  end;

implementation

const
  DadosFormaPagamento: array[0..13] of TFormasPagamentoHelper.TDadosFormaPagamento =
    (
      (Id: 7;
       Descricao: 'Itaú Shopline';
       TipoFormaPagamento: TransferenciasOnline;
       FormaPagamento: ItauShopline),

      (Id: 22;
       Descricao: 'Transf. Online Bradesco';
       TipoFormaPagamento: TransferenciasOnline;
       FormaPagamento: TransfOnlineBradesco),

      (Id: 23;
       Descricao: 'Transf. Online Banco do Brasil';
       TipoFormaPagamento: TransferenciasOnline;
       FormaPagamento: TransfOnlineBancoDoBrasil),


      (Id: 6;
       Descricao: 'Boleto Bancário';
       TipoFormaPagamento: Boleto;
       FormaPagamento: BoletoBancario),


      (Id: 8;
       Descricao: 'Pagamento com Saldo';
       TipoFormaPagamento: Saldo;
       FormaPagamento: PagamentoComSaldo),


      (Id: 3;
       Descricao: 'Visa';
       TipoFormaPagamento: CartoesDeCredito;
       FormaPagamento: Visa;
       CreditoParcelado: x12),

      (Id: 4;
       Descricao: 'Mastercard';
       TipoFormaPagamento: CartoesDeCredito;
       FormaPagamento: Mastercard;
       CreditoParcelado: x12),

      (Id: 5; Descricao:
       'American Express';
       TipoFormaPagamento: CartoesDeCredito;
       FormaPagamento: AmericanExpress;
       CreditoParcelado: x12),

      (Id: 15;
       Descricao: 'Discover';
       TipoFormaPagamento: CartoesDeCredito;
       FormaPagamento: Discover;
       CreditoParcelado: AVista),

      (Id: 16;
       Descricao: 'Elo';
       TipoFormaPagamento: CartoesDeCredito;
       FormaPagamento: Elo;
       CreditoParcelado: x12),

      (Id: 18;
       Descricao: 'Aura';
       TipoFormaPagamento: CartoesDeCredito;
       FormaPagamento: Aura;
       CreditoParcelado: x12),

      (Id: 19;
       Descricao: 'JCB';
       TipoFormaPagamento: CartoesDeCredito;
       FormaPagamento: JCB;
       CreditoParcelado: Avista),

      (Id: 20;
       Descricao: 'Hipercard';
       TipoFormaPagamento: CartoesDeCredito;
       FormaPagamento: Hipercard;
       CreditoParcelado: x12),

      (Id: 25;
       Descricao: 'Hiper (Itaú)';
       TipoFormaPagamento: CartoesDeCredito;
       FormaPagamento: HiperItau;
       CreditoParcelado: x12)
    );

{ TFormasPagamentoHelper }

function TFormasPagamentoHelper.Dados: TDadosFormaPagamento;
var
  oDadosFormaPagamento: TDadosFormaPagamento;
begin
  for oDadosFormaPagamento in DadosFormaPagamento do
  begin
    if oDadosFormaPagamento.FormaPagamento = Self then
    begin
      result := oDadosFormaPagamento;
      Break;
    end;
  end;
end;

class function TFormasPagamentoHelper.FindById(Id: Int64): TFormasPagamento;
var
  oDadosFormaPagamento: TDadosFormaPagamento;
begin
  Result := TFormasPagamento(-1);
  for oDadosFormaPagamento in DadosFormaPagamento do
  begin
    if oDadosFormaPagamento.FormaPagamento.Dados.Id = Id then
    begin
      result := oDadosFormaPagamento.FormaPagamento;
      Break;
    end;
  end;
end;

{ TListFormasDePagamentoHelper }

class function TListFormasDePagamentoHelper.FromString(
  const Value: string): TListFormasDePagamento;
var
  oStringList: TStringList;
  I: Integer;
  oFormasPagamento: TFormasPagamento;
begin
  result := [];
  oStringList := TStringList.Create;
  try
    oStringList.Delimiter := ',';
    oStringList.DelimitedText := Value;
    for I := 0 to oStringList.Count - 1 do
    begin
      oFormasPagamento := TFormasPagamento.FindById(StrToInt64Def(oStringList[i],-1));
      if oFormasPagamento <> TFormasPagamento(-1) then
        result := result + [oFormasPagamento];
    end;
  finally
    if Assigned(oStringList) then
      FreeAndNil(oStringList);
  end;
end;

function TListFormasDePagamentoHelper.ToString: string;
var
  oFormaPagamento: TFormasPagamento;
begin
  result := NullAsStringValue;
  for oFormaPagamento in Self do
  begin
    if result <> NullAsStringValue then
      result := result + ',';
    result := result + oFormaPagamento.Dados.Id.ToString;
  end;
end;

end.
