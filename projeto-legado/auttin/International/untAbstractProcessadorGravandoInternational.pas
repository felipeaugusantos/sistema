unit untAbstractProcessadorGravandoInternational;

interface

uses
  untAbstractAdoProcessadorGravandoExecucaoArquivos, Classes, DB, SysUtils,  untIConfTinta,
  Variants,  ADODB, Windows;

type
  TAbstractProcessadorGravandoInternational = class(TAbstractAdoProcessadorGravandoExecucaoArquivos)
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

{ TAbstractProcessadorGravandoExecucaoBrasimixImobiliaria }

constructor TAbstractProcessadorGravandoInternational.Create;
begin
  inherited Create();
  conf := fGetConfTinta('INT');
end;

function TAbstractProcessadorGravandoInternational.GetAdoQuery(var strNomeArquivo: string): TADOQuery;
begin
  Result := TADOFactory.GetAccessQuery12(strNomeArquivo);
end;

procedure TAbstractProcessadorGravandoInternational.GetArquivosProcessar(const stlArquivos: TStrings);
begin
  stlArquivos.Text := conf.fGet('INTPAT');
end;

end.
