unit untParPreController;

interface

uses
  untParPre, untParPreDAO, Uni, Data.DB, UniClientDataSet, System.SysUtils;

Type
  TParPreController = class
  private
    objDAO: TObjDAO;

    function fTrataExclusao(strCodEmp: String): Boolean;
  public
    function fGravarColecao(cdsDados: TUniClientDataSet; strCodEmp: String): Boolean;
    function fDeletarColecao(strCodEmp: String): Boolean;
    function fDeletar(strAutInc: String): Boolean;
    function fBuscaPorValor(fltVlrFat: Double; strCodEmp: String): TParPre;
    procedure pCarregaLista(strCodEmp: String; var cdsDados: TUniClientDataSet);

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TParPreController }

constructor TParPreController.Create;
begin
  objDAO := TObjDAO.Create;
end;

destructor TParPreController.Destroy;
begin
  inherited;
  FreeAndNil(objDAO);
end;

procedure TParPreController.pCarregaLista(strCodEmp: String; Var cdsDados: TUniClientDataSet);
begin
  objDAO.pCarregaLista(strCodEmp, cdsDados);
end;

function TParPreController.fBuscaPorValor(fltVlrFat: Double; strCodEmp: String): TParPre;
begin
  Result := objDAO.fBuscaPorValor(fltVlrFat, strCodEmp);
end;

function TParPreController.fGravarColecao(cdsDados: TUniClientDataSet; strCodEmp: String): Boolean;
begin
  Result := False;

  If (Not fTrataExclusao(strCodEmp)) Then
    Exit;

  If (Not objDAO.fGravarColecao(cdsDados)) Then
    Exit;

  Result := True;
end;

function TParPreController.fTrataExclusao(strCodEmp: String): Boolean;
begin
  Result := objDAO.fDeletarPorEmpresa(strCodEmp);
end;

function TParPreController.fDeletar(strAutInc: String): Boolean;
begin
  Result := objDAO.fDeletarPorAutInc(strAutInc);
end;

function TParPreController.fDeletarColecao(strCodEmp: String): Boolean;
begin
  Result := objDAO.fDeletarPorEmpresa(strCodEmp);
end;

end.
