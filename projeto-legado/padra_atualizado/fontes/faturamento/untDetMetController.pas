unit untDetMetController;

interface

uses
  untDetMet, untDetMetDAO, System.SysUtils, Uni, UniClientDataSet, System.StrUtils;

Type
  TDetMetController = class
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

{ TDetMetController }

constructor TDetMetController.Create;
begin
  objDAO := TObjDAO.Create;
end;

destructor TDetMetController.Destroy;
begin
  inherited;
  FreeAndNil(objDAO);
end;

function TDetMetController.fGravarColecao(cdsDados: TUniClientDataSet): Boolean;
begin
  Result := False;

  If (Not fPreparaDadosBase(cdsDados)) Then
    Exit;

  If (Not objDAO.fGravarColecao(cdsDados)) Then
    Exit;

  Result := True;
end;

function TDetMetController.fPreparaDadosBase(Var cdsDados: TUniClientDataSet): Boolean;
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

procedure TDetMetController.pAlteraEmpresaParaAtual(Const cdsDados: TUniClientDataSet);
begin
  cdsDados.Edit;
  cdsDados.FieldByName('MET_CODEMP').AsString := Vs_strCodEmp;
  cdsDados.Post;
end;

end.
