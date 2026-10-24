unit untAbstractProcessadorGravandoExecucaoArquivosRennerColorantes;

interface

uses
  untIProcessadorGravandoExecucaoArquivos, Classes, DB, SysUtils, untIGravando,
  Variants, ADODB;

type
  TAbstractProcessadorGravandoExecucaoArquivosRennerColorantes = class abstract(TInterfacedObject, IProcessadorGravandoExecucaoArquivos)
  public
    procedure GetArquivosProcessar(const stlArquivos: TStrings); virtual; abstract;
    function GetDataSetOrigem(const strNomeArquivo: string): TDataSet; virtual; abstract;
    function GetSqlDestino: string;
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

function TAbstractProcessadorGravandoExecucaoArquivosRennerColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TAbstractProcessadorGravandoExecucaoArquivosRennerColorantes.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM REI_CADCOL';
end;

procedure TAbstractProcessadorGravandoExecucaoArquivosRennerColorantes.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'REI_CADCOL';
end;

procedure TAbstractProcessadorGravandoExecucaoArquivosRennerColorantes.LimparTabelas;
begin

end;

end.

