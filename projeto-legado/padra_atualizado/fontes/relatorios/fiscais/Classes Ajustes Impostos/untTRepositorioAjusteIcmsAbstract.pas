unit untTRepositorioAjusteIcmsAbstract;

interface

uses System.Generics.Collections, Uni, SysUtils,
     untTAjusteIcms, untTypesSistema, untIRepositorioAjusteIcms;

type
  TRepositorioAjusteIcmsAbstract = class(TInterfacedObject, IRepositorioAjusteIcms)
  protected
    FListaAjustes: TObjectList<TAjusteIcms>;
    FConexao: TUniConnection;
  public
    function fRetListaAjusteIcms(dtaIni, dtaFin: TDateTime; strCodEmp: string = ''): TObjectList<TAjusteIcms>; virtual; abstract;
    function fRetParametroEmpresas(arrEmp: TConsultasArray): string;

    constructor create(conexao: TUniconnection);
    destructor Destroy; override;
  end;

implementation

{ TRepositorioAjusteIcmsAbstract }

constructor TRepositorioAjusteIcmsAbstract.create(conexao: TUniconnection);
begin
  inherited create;

  FListaAjustes := TObjectList<TAjusteIcms>.Create;
  FConexao := conexao;
end;

destructor TRepositorioAjusteIcmsAbstract.Destroy;
begin
  FListaAjustes.Free;

  inherited;
end;

function TRepositorioAjusteIcmsAbstract.fRetParametroEmpresas(arrEmp: TConsultasArray): string;
  var
    intIndex: integer;
begin
  Result := '';

  for intIndex := Low(arrEmp) to High(arrEmp) do
  begin
    Result := arrEmp[intIndex].strCodigo + '_';
  end;
end;

end.
