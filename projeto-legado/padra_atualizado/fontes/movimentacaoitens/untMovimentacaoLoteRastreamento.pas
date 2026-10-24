unit untMovimentacaoLoteRastreamento;

interface

uses
  Classes, SysUtils, Data.Db, untFuncoesSimples,
  System.Variants, untZClient;

  type
    TMovimentacaoLoteRastreamento = class
      strCodIte : String;
      strCodFor : String;
    public
      cdsMovRas : TZClient;
      constructor Create;

      function fAbreCdsMovRas(strSeqLot: String) : boolean;
      procedure pAdicionaMovimentacao(strNumLot: String);
  end;


implementation

{ TMovimentacaoLoteRastreamento }

constructor TMovimentacaoLoteRastreamento.Create;
begin
  inherited;
  Self.strCodIte := '';
  Self.strCodFor := '';
  cdsMovRas := TZClient.Create(nil, 'SELECT * FROM MOVRAS WHERE MOV_SEQLOT = :SEQLOT');
end;



function TMovimentacaoLoteRastreamento.fAbreCdsMovRas(strSeqLot: String) : boolean;
begin
  Self.strCodIte := strCodIte;
  Self.strCodFor := strCodFor;

  cdsMovRas.Close;
  cdsMovRas.qryQuery.Close;
  cdsMovRas.qryQuery.ParamByName('CODITE').AsString := strCodIte;
  cdsMovRas.qryQuery.ParamByName('CODFOR').AsString := strCodFor;

  Result := cdsMovRas.fAbreClient(True);
end;

procedure TMovimentacaoLoteRastreamento.pAdicionaMovimentacao(strNumLot : String);
begin
  if fEmptyStr(strNumLot) then
    raise Exception.create('Informe o número do lote!');


  cdsMovRas.Append;
  cdsMovRas.FieldByName('LOT_NUMLOT').AsString := strNumLot;
  cdsMovRas.FieldByName('LOT_CODITE').AsString := Self.strCodIte;
  cdsMovRas.FieldByName('LOT_CODFOR').AsString := Self.strCodFor;
  cdsMovRas.Post;
end;

end.
