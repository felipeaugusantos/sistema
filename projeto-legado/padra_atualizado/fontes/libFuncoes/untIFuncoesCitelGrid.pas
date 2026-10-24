unit untIFuncoesCitelGrid;

interface

Uses Classes, Uni, DB, DBGridCitel;

Type
  IFuncoesCitelGrid = interface
  ['{0068EE0B-BBFB-4566-89F1-52EB1D41DFBE}']
    function fCarregarView(grid: TDBGridCitel; strChave: String): Boolean; overload;
    procedure pSalvarView(grid: TDBGridCitel; strChave: String); overload;
    procedure pDeletarView(strChave: String);
  End;

implementation

end.
