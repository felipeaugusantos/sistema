unit untConsultaController;

interface

uses
  SysUtils, Classes, untConsultaModel, DBClient;

type
  TConsultaController = class
    private

    public
      procedure pConsulta(var cdsConsulta: TClientDataSet; objConsulta: TConsultaModel);
      class function get: TConsultaController;
  end;

implementation

uses
  untConsultaDao;

var
  _instance: TConsultaController;

class function TConsultaController.get: TConsultaController;
begin
  if _instance = nil then
    _instance := TConsultaController.Create;

  Result := _instance;
end;

procedure TConsultaController.pConsulta(var cdsConsulta: TClientDataSet;
  objConsulta: TConsultaModel);
var
  objConsultaDao: TConsultaDao;
begin
  objConsultaDao := TConsultaDao.Create;

  try
    objConsultaDao.pCarregaLista(objConsulta, cdsConsulta);
  finally
    FreeAndNil(objConsultaDao);
  end;
end;

end.
