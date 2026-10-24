unit cadastro.TSQLEstruturaIndustrial;

interface

uses classes;

  Type TSQLEstruturaIndustrial = class

    public

      function fRetornaTSQLCarregaEstrutura: String;

  End;

implementation

{ TSQLEstruturaIndustrial }

function TSQLEstruturaIndustrial.fRetornaTSQLCarregaEstrutura: String;
begin
  Result := Result + 'SELECT  ';
  Result := Result + '  GMT_CODITE, ';
  Result := Result + '  GMT_STATUS, ';
  Result := Result + '  GMT_CODOPE, ';
  Result := Result + '  GMT_FORESP, ';
  Result := Result + '  GEIMAT.AUTOINCREM, ';
  Result := Result + '  GMT_OBS001, ';
  Result := Result + '  GMT_OBS002, ';
  Result := Result + '  GMT_OBS003, ';
  Result := Result + '  GMT_OBS004, ';
  Result := Result + '  GMT_OBS005, ';
  Result := Result + '  GMT_OBS006, ';
  Result := Result + '  GMT_OBS007, ';
  Result := Result + '  GMT_DTACAD, ';
  Result := Result + '  GMT_HRACAD, ';
  Result := Result + '  GMT_DTAALT, ';
  Result := Result + '  GMT_HRAALT, ';
  Result := Result + '  GMT_DTAFOR, ';
  Result := Result + '  GMT_CAPMAX, ';
  Result := Result + '  OPE_NOMOPE, ';
  Result := Result + '  OPE_CODOPE  ';
  Result := Result + 'FROM ';
  Result := Result + '  GEIMAT ';
  Result := Result + '  LEFT JOIN CADOPE ON OPE_CODOPE = GMT_CODOPE ';
  Result := Result + 'WHERE ';
  Result := Result + '  GMT_CODITE = :CODITE AND ';
  Result := Result + '  GMT_CODCOR = :CODCOR AND ';
  Result := Result + '  GMT_FORMUL = :CODFOR ';

end;

end.
