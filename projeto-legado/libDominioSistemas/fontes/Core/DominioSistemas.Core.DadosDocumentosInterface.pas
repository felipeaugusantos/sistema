unit DominioSistemas.Core.DadosDocumentosInterface;

interface

uses
  Data.DB, DominioSistemas.Core.DocumentoInterface ;

type
  IListarDadosDocumentos = interface
    ['{609AB01A-19A6-42D1-810D-2B11DB15075F}']
    function fDocumentos(const ACodEmp: String;
                               const ADataIni, ADataFim: TDateTime;
                               const AChaveAcesso: String): TDataSet ;
    function fDocumentosJaProcessados(const ACodEmp: String;
                                      const ADataIni, ADataFim: TDateTime): TDataSet ;
    function fDocumentosProcessamentoPendente(const ACodEmp: String): TDataSet ;
  end ;

  IDadosDocumentosFactory = interface
    ['{1C688502-CC77-433B-95B8-2DCE254FE3C6}']
    function fListar(const ATipo: TTipoDocumentoDominio): IListarDadosDocumentos;
  end ;

implementation

end.
