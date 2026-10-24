unit Garantia.TCancelamentoGarantia;

interface

uses
  Classes,
  SysUtils;


  type
    TCancelamentoGarantia = class
    private
      FSigla: String;

    public
      function fVerificaMovimentacoesPosteriores: Boolean;
      function fSiglasVerificamMovimentacoesPosteriores : String;
      function fEhRecebimentoCliente: Boolean;

      property strSigla : String read FSigla write FSigla;
  end;


implementation

uses
  Garantia.Constantes;

{ TCancelamentoGarantia }
function TCancelamentoGarantia.fSiglasVerificamMovimentacoesPosteriores: String;
begin
  Result := TSiglasGarantia.RECEBIMENTO_CLIENTE;
  Result := Result + TSiglasGarantia.ENVIO_FORNECEDOR;
  Result := Result + TSiglasGarantia.RETORNO_FORNECEDOR;
end;

function TCancelamentoGarantia.fVerificaMovimentacoesPosteriores: Boolean;
Begin
  Result := fSiglasVerificamMovimentacoesPosteriores.Contains(FSigla);
End;

function TCancelamentoGarantia.fEhRecebimentoCliente: Boolean;
Begin
  Result := TSiglasGarantia.RECEBIMENTO_CLIENTE.Contains(strSigla);
End;


end.
