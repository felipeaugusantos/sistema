unit untTFormaPagamento;

interface

Type
  TFormaPagamento = class
    private
      FCodigo: String;
      FDescricao: String;
      FContaContabil: String;
    public
      //Se for a vista retorna true se não false
      function fRetVendaVistaPrazo: Boolean;

      property strCodigo: String read FCodigo write FCodigo;
      property strDescricao: String read FDescricao write FDescricao;
      property strContaContabil: String read FContaContabil write FContaContabil;
  end;

implementation

{ TFormaPagamento }

function TFormaPagamento.fRetVendaVistaPrazo: Boolean;
begin
  If FCodigo = '001' Then
    Result := True
  Else
    Result := False;
end;

end.
