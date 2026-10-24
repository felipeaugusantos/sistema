unit untIProcessadorGravandoExecucaoArquivos;

interface

uses
  Classes, DB, SysUtils, untIGravando;

type
  IProcessadorGravandoExecucaoArquivos = interface
    ['{02EA7987-F59D-4533-AA0E-9AF7C1FC113B}']
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings);
    procedure GetArquivosProcessar(const stlArquivos: TStrings);
    function GetDataSetOrigem(const strNomeArquivo: string): TDataSet;
    function GetSqlDestino(): string;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet);
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
      const qryOrigem, qryDestino: TDataSet);
    function fGetNomeGravacao(): string;
    procedure LimparTabelas;
    procedure ArquivoFormulaPadrao(const gravando: IGravando; const strNomeArquivo: string);
  end;

implementation

end.
