unit untComLinController;

interface

uses
  untComLin, untComLinDAO, System.SysUtils;

type
  TComLinController = class
  private
    objComLinDAO: TComLinDAO;

  public
    constructor Create;
    destructor Destroy; override;
    function fGravar(objComLin: TComLin): String;
    function fBuscarPorAutoIncremento(strAutInc: String): TComLin;
    function fDeletar(strAutInc: String): Boolean;
    function fExisteComissaoParaVendedorEmpresa(strCodEmp, strCodVen: String): Boolean;
    function fBuscaPorVendedorEmpresa(strCodEmp, strCodVen: String): TComLin;
  end;

implementation

uses
  untFuncoesSimples;

{ TComLinController }

constructor TComLinController.Create;
begin
  objComLinDAO := TComLinDAO.Create;
end;

destructor TComLinController.Destroy;
begin
  FreeAndNil(objComLinDAO);
end;

function TComLinController.fBuscarPorAutoIncremento(strAutInc: String): TComLin;
begin
  Result := objComLinDAO.fBuscarPorAutoIncremento(strAutInc);
end;

function TComLinController.fBuscaPorVendedorEmpresa(strCodEmp, strCodVen: String): TComLin;
begin
  Result := objComLinDAO.fBuscaPorVendedorEmpresa(strCodEmp, strCodVen);
end;

function TComLinController.fGravar(objComLin: TComLin): String;
begin
  Result := objComLinDAO.fGravar(ObjComLin);
end;

function TComLinController.fDeletar(strAutInc: String): Boolean;
begin
  Result := objComLinDAO.fDeletar(strAutInc);
end;

function TComLinController.fExisteComissaoParaVendedorEmpresa(strCodEmp, strCodVen: String): Boolean;
  Var
    objComLin: TComLin;
begin
  objComLin := objComLinDAO.fBuscaPorVendedorEmpresa(strCodEmp, strCodVen);

  Try
    Result := objComLin <> Nil;
  Finally
    FreeAndNil(objComLin);
  End;
end;

end.
