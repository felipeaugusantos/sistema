unit untCadMixController;

interface

uses
  untCadMix, untCadMixDAO, System.SysUtils;

type
  TCadMixController = class
  private
    objDAO: TCadMixDAO;

  public
    constructor Create;
    destructor Destroy; override;
    function fGravar(objDados: TCadMix): Boolean;
    function fBuscarPorAutoIncremento(strAutInc: String): TCadMix;
    function fDeletar(strAutInc: String): Boolean;
    function fExisteMeta(strCodEmp: String): Boolean;
  end;

implementation

uses
  untFuncoesSimples;

{ TController }

constructor TCadMixController.Create;
begin
  objDAO := TCadMixDAO.Create;
end;

destructor TCadMixController.Destroy;
begin
  FreeAndNil(objDAO);
end;

function TCadMixController.fBuscarPorAutoIncremento(strAutInc: String): TCadMix;
begin
  Result := objDAO.fBuscarPorAutoIncremento(strAutInc);
end;

function TCadMixController.fGravar(objDados: TCadMix): Boolean;
begin
  Result := objDAO.fGravar(objDados);
end;

function TCadMixController.fDeletar(strAutInc: String): Boolean;
begin
  Result := objDAO.fDeletar(strAutInc);
end;

function TCadMixController.fExisteMeta(strCodEmp: String): Boolean;
  Var
    objDados: TCadMix;
begin
  objDados := objDAO.fBuscaPorEmpresa(strCodEmp);

  Try
    Result := objDados <> Nil;
  Finally
    FreeAndNil(objDados);
  End;
end;

end.
