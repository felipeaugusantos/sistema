unit untAbstractConsulta;

interface

Uses untIConsulta;


Type

  TAbstractConsulta = class abstract(TInterfacedObject, IConsulta)
  public
    function fRetornarSQLIpi  : String; virtual;

    function fRetornarSQLStCustoAquisicao : String; virtual;

    function fRetornarSQLIcms : String; virtual;

    function fRetornarSQLIcmsEfetivo : String; virtual;

    function fRetornarSQLSt : String; virtual;

    function fRetornarSQLDifal : String; virtual;

    function fRetornarSQLFcp : String; virtual;

    function fRetornarSQLFcpDifal : String; virtual;

    function fRetornarSQLIcmsOrgaoPublico : String; virtual;

    function fRetornarSQLCfop : String; virtual;

    function fRetornarSQLPrecoCusto : String; virtual;

    function fRetornarSQLMargemVenda: String; virtual;
  end;


implementation

{ TAbstractConsulta }

function TAbstractConsulta.fRetornarSQLCfop: String;
begin
  Result := '';
end;

function TAbstractConsulta.fRetornarSQLDifal: String;
begin
  Result := '';
end;

function TAbstractConsulta.fRetornarSQLFcp: String;
begin
  Result := '';
end;

function TAbstractConsulta.fRetornarSQLFcpDifal: String;
begin
  Result := '';
end;

function TAbstractConsulta.fRetornarSQLIcms: String;
begin
  Result := '';
end;

function TAbstractConsulta.fRetornarSQLIcmsEfetivo: String;
begin
  Result := '';
end;

function TAbstractConsulta.fRetornarSQLIcmsOrgaoPublico: String;
begin
  Result := '';
end;

function TAbstractConsulta.fRetornarSQLIpi: String;
begin
  Result := '';
end;

function TAbstractConsulta.fRetornarSQLMargemVenda: String;
begin
  result := '';
end;

function TAbstractConsulta.fRetornarSQLPrecoCusto: String;
begin
  Result := '';
end;

function TAbstractConsulta.fRetornarSQLSt: String;
begin
  Result := '';
end;

function TAbstractConsulta.fRetornarSQLStCustoAquisicao: String;
begin
  Result := '';
end;

end.
