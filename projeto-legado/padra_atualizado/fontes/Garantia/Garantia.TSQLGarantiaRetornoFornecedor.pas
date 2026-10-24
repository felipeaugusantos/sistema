unit Garantia.TSQLGarantiaRetornoFornecedor;

interface

uses classes;

  type TSQLGarantiaRetornoFornecedor = class

    public

      function fRetornaFiltroGarantiaRetornoFornecedorNF: String;

  end;

implementation

{ TSQLGarantiaFiltroRetornoFornecedorEspecieNF }

function TSQLGarantiaRetornoFornecedor.fRetornaFiltroGarantiaRetornoFornecedorNF: String;
begin
  Result := Result + '(SELECT COUNT(*) FROM MOVDET DT ';
  Result := Result + '           INNER JOIN MOVGAU MU ON DT.AUTOINCREM = MU.GAU_SEQDET ';
  Result := Result + '                             WHERE DT.DET_SEQGER = MOVGER.AUTOINCREM) > 0 ';
end;

end.
