unit untNCMController;

interface

uses
  {$IF Defined(UNIDAC)}
    Uni, DBAccess,
  {$ELSE}
    ZDataset,
  {$IFEND}
  SysUtils, Classes, untNCMModel;

type
  TNCMController = class
    private

    public
      function fRetornaNCM(strCodNCM: String): TNCMModel;
      function fAtualizaNCMItemEspecial(strSeqGer, strNovoNCM: String): Boolean;
      class function get: TNCMController;
  end;

implementation

uses
  untNCMDao;

var
  _instance: TNCMController;

class function TNCMController.get: TNCMController;
begin
  if _instance = nil then
    _instance := TNCMController.Create;

  Result := _instance;
end;

function TNCMController.fRetornaNCM(strCodNCM: String): TNCMModel;
var
  objNCMDao: TNCMDao;
begin
  objNCMDao := TNCMDao.Create;

  try
    Result := objNCMDao.fRetornaNCM('NCM_CODNCM = ' + QuotedStr(strCodNCM));
  finally
    FreeAndNil(objNCMDao);
  end;
end;

function TNCMController.fAtualizaNCMItemEspecial(strSeqGer, strNovoNCM: String): Boolean;
var
  objNCMDao: TNCMDao;
  strCondicao: String;
begin
  objNCMDao := TNCMDao.Create;
  strCondicao := ' WHERE MOVTRI.DET_SEQGER = '+ QuotedStr(strSeqGer);

  try
    Result := objNCMDao.fAtualizaNCMItemEspecial(strCondicao, strNovoNCM);
  finally
    FreeAndNil(objNCMDao);
  end;
end;

end.
