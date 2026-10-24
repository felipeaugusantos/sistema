unit Garantia.TSQLGarantiaFiltroCancelamentoEspecieOF;

interface

uses classes;

  Type TSQLGarantiaFiltroCancelamentoEspecieOF = Class

    private

      FEspecieSelecionada: String;

    public

      property strEspecieSelecionada: String read FEspecieSelecionada write FEspecieSelecionada;

      function fRetornaFiltrovGarantiaValidaOF: String;

      constructor Create;
  End;

  CONST

    OUTRAS_ENTRADAS = 'OE';
    DEVOLUCAO       = 'DV';
    NOTA_ENTRADA    = 'NE';

implementation

{ TSQLGarantiaCancelamentoSerieOF }

constructor TSQLGarantiaFiltroCancelamentoEspecieOF.Create;
begin
  FEspecieSelecionada:= '';
end;

function TSQLGarantiaFiltroCancelamentoEspecieOF.fRetornaFiltrovGarantiaValidaOF: String;
begin
  Result:= '';
  If (FEspecieSelecionada = 'OF') Then
  Begin
    Result := Result + '(SELECT COUNT(*) FROM MOVGRC ';
    Result := Result + 'INNER JOIN MOVDET ON (MOVDET.AUTOINCREM = MOVGRC.GRC_SEQDET) ';
    Result := Result + 'WHERE MOVGER.AUTOINCREM = MOVDET.DET_SEQGER AND ';
    Result := Result + 'GRC_OPCDOC IN ("'+OUTRAS_ENTRADAS+'", "'+DEVOLUCAO+'", "'+NOTA_ENTRADA+'")) = 0 AND ';
  End;

end;

end.
