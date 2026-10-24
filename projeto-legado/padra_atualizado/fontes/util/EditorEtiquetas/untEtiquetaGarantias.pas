unit untEtiquetaGarantias;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
     Forms, Dialogs;

Type
  TObjEtiquetaGarantias = class
    private

      FEspecieDocumento   : String;

    public

      property strEspecieDocumento : String  read FEspecieDocumento     write FEspecieDocumento;

      function fGetSQLMovGadFiltro: String;

      Const
        ESPECIE_GA = 'GA';
        ESPECIE_GC = 'GC';

  End;


implementation

{ TObjEtiquetaGarantias }

function TObjEtiquetaGarantias.fGetSQLMovGadFiltro: String;
begin
  Result:= '';

  If FEspecieDocumento = ESPECIE_GA Then
    Result:= 'E.DET_ESPDOC = "'+ESPECIE_GA+'"   AND  '
  Else
  If FEspecieDocumento = ESPECIE_GC Then
    Result:= 'E.DET_ESPDOC = "'+ESPECIE_GC+'"   AND  ';

end;

end.
