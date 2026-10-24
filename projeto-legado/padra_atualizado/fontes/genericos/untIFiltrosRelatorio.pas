unit untIFiltrosRelatorio;

interface

Uses frxClass, untGeraExcel, untTypesSistema;

Type
  IFiltrosRelatorio = Interface
  ['{F468C6E4-6DB9-4552-A3B2-B89E58FAA4FF}']
    Procedure pLimpaFiltros;

    Procedure pIncluiFiltro(strNomVar, strFiltro: String; blnTitRel: Boolean = False);

    Procedure pSetaVariaveisFast(frxReport: TfrxReport; blnMatricial: Boolean);

    function GetStrNomRel : String;
    procedure SetStrNomRel(Value : String);

    function GetArrFiltros : TArrRecFiltros;
    procedure SetArrFiltros(Value : TArrRecFiltros);

    property arrFiltros: TArrRecFiltros  Read GetArrFiltros Write SetArrFiltros;
    property strNomRel: String  Read GetStrNomRel Write SetStrNomRel;
End;

implementation

end.
