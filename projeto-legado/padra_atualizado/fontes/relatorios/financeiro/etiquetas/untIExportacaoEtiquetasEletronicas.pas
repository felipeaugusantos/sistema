unit untIExportacaoEtiquetasEletronicas;

interface

uses Vcl.ComCtrls, Data.DB, untTypesSistema;

type
  IExportacaoEtiquetasEletronicas = interface
    ['{C23E919C-8D6A-4EA6-B0F9-86B46BEADDB8}']

    function fGerarArquivo(strPath: String; DataSet: TDataSet; pgbProgresso: TProgressBar; arrCodEmpEtiEle: TConsultasArray; strNomeArq, strFiltro: string): Boolean;
  end;

implementation

end.

