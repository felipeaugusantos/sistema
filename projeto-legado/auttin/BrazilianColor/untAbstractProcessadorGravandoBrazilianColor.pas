unit untAbstractProcessadorGravandoBrazilianColor;

interface

uses
  untAbstractAdoProcessadorGravandoExecucaoArquivos, Classes, DB, SysUtils,  untIConfTinta,
  Variants,  ADODB, Windows;

type
  TAbstractProcessadorGravandoBrazilianColor = class(TAbstractAdoProcessadorGravandoExecucaoArquivos)
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

constructor TAbstractProcessadorGravandoBrazilianColor.Create;
begin
  inherited Create();
  conf := fGetConfTinta('BZC');
end;

function TAbstractProcessadorGravandoBrazilianColor.GetAdoQuery(var strNomeArquivo: string): TADOQuery;
begin
  Result := TADOFactory.GetAccessQuery8(strNomeArquivo);
end;

procedure TAbstractProcessadorGravandoBrazilianColor.GetArquivosProcessar(const stlArquivos: TStrings);
begin
  stlArquivos.Text := conf.fGet('BZCPAT');
end;

end.
