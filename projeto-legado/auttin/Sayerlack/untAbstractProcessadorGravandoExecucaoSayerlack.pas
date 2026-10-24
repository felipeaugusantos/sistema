unit untAbstractProcessadorGravandoExecucaoSayerlack;

interface

uses
  untAbstractAdoProcessadorGravandoExecucaoArquivos, Classes, DB, SysUtils, untIConfTinta,
  Variants, ADODB;

type
  TAbstractProcessadorGravandoExecucaoSayerlack = class abstract (TAbstractAdoProcessadorGravandoExecucaoArquivos)
  protected
    conf: IConfTinta;
    function GetAdoQuery(var strNomeArquivo: string): TADOQuery; override; 
  public
    procedure GetArquivosProcessar(const stlArquivos: TStrings); override;
    constructor Create(); virtual;
  end;

implementation

uses
  untFuncTinta, untADOFactory;

{ TProcessadorGravandoExecucaoSayerlack }

constructor TAbstractProcessadorGravandoExecucaoSayerlack.Create;
begin
  inherited Create();
  conf := fGetConfTinta('SAY');
end;

function TAbstractProcessadorGravandoExecucaoSayerlack.GetAdoQuery(var strNomeArquivo: string): TADOQuery;
begin
  Result := TADOQuery.Create(nil);
  Result.ConnectionString :=  'Provider=Microsoft.ACE.OLEDB.12.0;Data Source=' +
                              strNomeArquivo +
                              ';Extended Properties="Excel 12.0;HDR=No;IMEX=1"';
end;

procedure TAbstractProcessadorGravandoExecucaoSayerlack.GetArquivosProcessar(const stlArquivos: TStrings);
begin
  stlArquivos.Text := conf.fGet('SAYPAT');
end;

end.
