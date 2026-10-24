unit OrdemProducaoIndustrial.TReservaSaldoOrdemProducaoIndustrial;

interface

uses Classes;

  Type
    TReservaSaldoOrdemProducaoIndustrial = Class

    Private

      FTipoItem : String;
      FPermiteReservaComposicao: Boolean;

    Public

      property  strTipoItem                 : String  read FTipoItem                 write FTipoItem;
      property  blnPermiteReservaComposicao : Boolean read FPermiteReservaComposicao write FPermiteReservaComposicao;

      function fRetornaReservaProdutoComposicao: Boolean;

      constructor create;


  End;

implementation

{ TProdutoComposicao }

constructor TReservaSaldoOrdemProducaoIndustrial.create;
begin
  FTipoItem := '';
  FPermiteReservaComposicao:= False;
end;

function TReservaSaldoOrdemProducaoIndustrial.fRetornaReservaProdutoComposicao: Boolean;
begin
  Result:= True;
  If (FTipoItem = 'COMPOS') AND (Not(FPermiteReservaComposicao)) Then
    Result:= False;
end;

end.
