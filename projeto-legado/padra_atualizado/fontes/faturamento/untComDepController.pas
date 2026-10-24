unit untComDepController;

interface

uses
  untComDep, untComDepDAO, System.SysUtils;

type
  TComDepController = class
  private
    objComDepDAO: TComDepDAO;

  public
    constructor Create;
    destructor Destroy; override;
    function fGravar(objComDep: TComDep): Boolean;
    function fBuscarPorAutoIncremento(strAutInc: String): TComDep;
    function fDeletar(strAutInc: String): Boolean;
    function fExisteFaixaDeFaturamento(strCodDep: String; fltFatIni, fltFatFin: Double): Boolean;
    function fExisteCodigo(strCodDep: String): Boolean;
  end;

implementation

uses
  untFuncoesSimples;

{ TComDepController }

constructor TComDepController.Create;
begin
  objComDepDAO := TComDepDAO.Create;
end;

destructor TComDepController.Destroy;
begin
  FreeAndNil(objComDepDAO);
end;

function TComDepController.fBuscarPorAutoIncremento(strAutInc: String): TComDep;
begin
  Result := objComDepDAO.fBuscarPorAutoIncremento(strAutInc);
end;

function TComDepController.fExisteCodigo(strCodDep: String): Boolean;
  Var
    objComDep: TComDep;
begin
  objComDep := objComDepDAO.fBuscarPorCodigo(strCodDep);

  Try
    Result := objComDep <> Nil;
  Finally
    FreeAndNil(objComDep);
  End;
end;

function TComDepController.fGravar(objComDep: TComDep): Boolean;
begin
  Result := objComDepDAO.fGravar(ObjComDep);
end;

function TComDepController.fDeletar(strAutInc: String): Boolean;
begin
  Result := objComDepDAO.fDeletar(strAutInc);
end;

function TComDepController.fExisteFaixaDeFaturamento(strCodDep: String; fltFatIni, fltFatFin: Double): Boolean;
  Var
    objComDep: TComDep;
begin
  objComDep := objComDepDAO.fBuscaPorDepEFaixaDeFaturamento(strCodDep, fltFatIni, fltFatFin);

  Try
    Result := objComDep <> Nil;
  Finally
    FreeAndNil(objComDep);
  End;
end;

end.
