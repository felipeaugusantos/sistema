unit OrdemProducaoIndustrial.TSQLFormulaImpressao;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
     Forms, Dialogs;

Type
  TSQLFormulaImpressao = class
    private

    public

      function fRetornaSQLItemFormulaImpressao: String;

  End;

implementation

{ TSQLFormulaImpressao }

function TSQLFormulaImpressao.fRetornaSQLItemFormulaImpressao: String;
begin
  Result:= '   AND ODM_SEQUEN <> "9999"  ';
end;

end.
