unit untIProcessadorGravandoExecucao;

interface

uses
  Classes, DB, SysUtils, untIGravando;

type
  IProcessadorGravandoExecucao = interface
    ['{3A8844D7-A7F5-490B-85C1-5B1D41879915}']
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings);
    function GetDataSetOrigem(): TDataSet;
    function GetSqlDestino(): string;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet);
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
      const qryOrigem, qryDestino: TDataSet);
    function fGetNomeGravacao(): string;
    procedure LimparTabelas; 
  end;

implementation

end.
