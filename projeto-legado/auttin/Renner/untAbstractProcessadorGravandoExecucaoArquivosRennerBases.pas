unit untAbstractProcessadorGravandoExecucaoArquivosRennerBases;

interface

uses
  untIProcessadorGravandoExecucaoArquivos, Classes, DB, SysUtils, untIGravando,
  Variants, ADODB;

type
  TAbstractProcessadorGravandoExecucaoArquivosRennerBases = class abstract(TInterfacedObject, IProcessadorGravandoExecucaoArquivos)
  public
    procedure GetArquivosProcessar(const stlArquivos: TStrings); virtual; abstract;
    function GetDataSetOrigem(const strNomeArquivo: string): TDataSet; virtual; abstract;
    function GetSqlDestino: string; virtual;
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings); virtual;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet); virtual; abstract;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean; virtual; abstract;
    procedure LimparTabelas; virtual;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando; const qryOrigem: TDataSet;
      const qryDestino: TDataSet); virtual; abstract;
    function fGetNomeGravacao: string; virtual;
    procedure ArquivoFormulaPadrao(const gravando: IGravando; const strNomeArquivo: string); virtual; abstract;
  end;

implementation

{ TProcessadorGravandoExecucaoArquivosRennerBases }

function TAbstractProcessadorGravandoExecucaoArquivosRennerBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TAbstractProcessadorGravandoExecucaoArquivosRennerBases.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM REI_CADBAS';
end;

procedure TAbstractProcessadorGravandoExecucaoArquivosRennerBases.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'REI_CADBAS';
end;

procedure TAbstractProcessadorGravandoExecucaoArquivosRennerBases.LimparTabelas;
begin

end;

end.
