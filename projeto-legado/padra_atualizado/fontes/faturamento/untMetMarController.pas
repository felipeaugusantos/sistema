unit untMetMarController;

interface

uses
  untMetMar, untMetMarDAO, System.SysUtils, Uni, UniClientDataSet, System.StrUtils;

Type
  TMetMarController = class
  private
    objDAO: TObjDAO;

    function fPreparaDadosBase(var cdsDados: TUniClientDataSet): Boolean;
    procedure pAlteraEmpresaParaAtual(const cdsDados: TUniClientDataSet);
  public
    function fGravarColecao(cdsDados: TUniClientDataSet): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  untFuncoesSimples, untCadMetController;

{ TMetMarController }

constructor TMetMarController.Create;
begin
  objDAO := TObjDAO.Create;
end;

destructor TMetMarController.Destroy;
begin
  inherited;
  FreeAndNil(objDAO);
end;

function TMetMarController.fGravarColecao(cdsDados: TUniClientDataSet): Boolean;
begin
  Result := False;

  If (Not fPreparaDadosBase(cdsDados)) Then
    Exit;

  If (Not objDAO.fGravarColecao(cdsDados)) Then
    Exit;

  Result := True;
end;

function TMetMarController.fPreparaDadosBase(Var cdsDados: TUniClientDataSet): Boolean;
  Var
    objCadMetController: TCadMetController;
    strCodVen: String;
    strMesAno: String;
begin
  Result := False;
  objCadMetController := TCadMetController.Create;

  Try
    cdsDados.First;

    While (Not cdsDados.Eof) Do
    Begin
      strCodVen := cdsDados.FieldByName('MET_CODVEN').AsString;
      strMesAno := cdsDados.FieldByName('MET_MESANO').AsString;

      If (Not objCadMetController.fInserirBase(strCodVen, strMesAno)) Then
        Exit;

      If (Not objDAO.fDeletarPorPeriodo(strCodVen, strMesAno)) Then
        Exit;

      pAlteraEmpresaParaAtual(cdsDados);

      cdsDados.Next;
    End;

    Result := True;
  Finally
    FreeAndNil(objCadMetController);
  End;
end;

procedure TMetMarController.pAlteraEmpresaParaAtual(Const cdsDados: TUniClientDataSet);
begin
  cdsDados.Edit;
  cdsDados.FieldByName('MET_CODEMP').AsString := Vs_strCodEmp;
  cdsDados.Post;
end;

end.
