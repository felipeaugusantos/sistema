unit ArquivosBanco.Interfaces;

interface

uses
  UniClientDataSet, cxGraphics;

type
  IArquivosBancoInterface = interface
    ['{1EC7E468-8202-4D2E-B970-2CF2033122FD}']
    function fTabela: String;
    function fPrefixo: String;
    function fCampoFK: String;
    function fTitulo: String;
    function fFileOpenFilter: String;

    function fValorFK: String; overload;
    function fValorFK(AstrValue: String): IArquivosBancoInterface; overload;

    function fThumbList: TcxImageList; overload;
    function fThumbList(AValue: TcxImageList): IArquivosBancoInterface; overload;

    procedure pCarregaArquivos(AcdsDados: TUniClientDataSet);
    procedure pGravaArquivo(AstrArquivo: String);
    procedure pExcluirArquivo(AstrAutInc: String);
  end;

implementation

end.
