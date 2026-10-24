unit untConsulta;

interface

Uses System.Classes, System.StrUtils, Uni, untFuncoes, untClasseCfop;

  Type
    TConsulta = class
      Public
        Constructor Create(AOpcao : String; ADataInicial, ADataFinal : TDate);

        function fRetornarDados : TUniQuery;
      Private
        LOpcao       : String;
        LDataInicial : TDate;
        LDataFinal   : TDate;

        function fRetornarSQL : String;
    end;


implementation


{ TConsulta }

constructor TConsulta.Create(AOpcao: String; ADataInicial, ADataFinal: TDate);
begin
  LOpcao       := AOpcao;
  LDataInicial := ADataInicial;
  LDataFinal   := ADataFinal;
end;

function TConsulta.fRetornarDados : TUniQuery;
begin
  Result := fCriaQuery(Nil);
  Result.SQL.Text := fRetornarSQL;
  Result.ParamByName('DTAINI').AsDate := LDataInicial;
  Result.ParamByName('DTAFIM').AsDate := LDataFinal;
  Result.Open;
end;

function TConsulta.fRetornarSQL: String;
begin
  Case AnsiIndexStr(LOpcao, ['IPI','STCUSTOAQUISICAO', 'ICMS', 'ICMSEFETIVO', 'ST',
                             'DIFAL', 'FCP', 'FCPDIFAL', 'ICMSORGAOPUBLICO', 'CFOP']) of
    0: Result := '';
    1: Result := '';
    2: Result := '';
    3: Result := '';
    4: Result := '';
    5: Result := '';
    6: Result := '';
    7: Result := '';
    8: Result := '';
    9: Result := TConsultaCfop.New.fRetornarSQLCfop;
  end
end;

end.

