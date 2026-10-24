unit untIFuncoesCXGrid;

interface

Uses Classes, Uni, DB, cxGridDBTableView;

Type
  IFuncoesCXGrid = interface
  ['{0068EE0B-BBFB-4566-89F1-52EB1D41DFBE}']
    function fEscreverNoArquivo(strNomArq, strTexto: String): Boolean;
    function fArquivoParaString(strNomArq: String): String;
    function fCriarArquivoTemporario(strNomArq: String = ''; strPathTmp: String = ''): String;
    function fGetFiltros(coluna: TcxGridDBColumn): String;
    function fGetOrdem(view: TcxGridDBTableView): String;
    function fCarregarView(view: TcxGridDBTableView; strChave: String; qryConsulta: TDataSet; Var intRecNo: Integer): Boolean;
    procedure pSalvarView(view: TcxGridDBTableView; strChave: String; qryConsulta: TDataSet);
    procedure pSalvarEstado(view: TcxGridDBTableView; strChave: String);
    procedure pCarregarEstado(view: TcxGridDBTableView; strChave: String);
    procedure pFocoNoFiltro(view: TcxGridDBTableView; stlCamOrd: TStringList; const strNomeColuna: String = ''; blnExecutarEnd: Boolean=True);
    procedure pProximoFiltro(view: TcxGridDBTableView);
  End;

implementation

end.