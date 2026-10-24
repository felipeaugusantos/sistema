unit untCadMetController;

interface

uses
  untCadMet, untCadMetDAO, System.SysUtils, Uni, UniClientDataSet;

Type
  TCadMetController = class
  private
    objDAO: TObjDAO;
    procedure pTrataDadosCds(var cdsDados: TUniClientDataSet);
    function fExisteCadastro(strCodVen, strMesAno: String): Boolean;
  public
    function fBuscaPorMesAno(strCodVen, strMesAno: String): TCadMet;
    function fGravarColecao(cdsDados: TUniClientDataSet): Boolean;
    function fInserirBase(strCodVen, strMesAno: String): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  untFuncoesSimples;

{ TCadMetController }

constructor TCadMetController.Create;
begin
  objDAO := TObjDAO.Create;
end;

destructor TCadMetController.Destroy;
begin
  inherited;
  FreeAndNil(objDAO);
end;

function TCadMetController.fGravarColecao(cdsDados: TUniClientDataSet): Boolean;
begin
  Result := False;

  pTrataDadosCds(cdsDados);

  If (Not objDAO.fGravarColecao(cdsDados)) Then
    Exit;

  Result := True;
end;

procedure TCadMetController.pTrataDadosCds(Var cdsDados: TUniClientDataSet);
  Var
    objDados: TCadMet;
begin
  objDados := Nil;

  Try
    cdsDados.First;

    While (Not cdsDados.Eof) Do
    Begin
      objDados := fBuscaPorMesAno(cdsDados.FieldByName('MET_CODVEN').AsString,
                                  cdsDados.FieldByName('MET_MESANO').AsString);

      If (Assigned(objDados)) And (Not fEmptyStr(objDados.getAutInc)) Then
      Begin
        cdsDados.Edit;
        cdsDados.FieldByName('AUTOINCREM').AsString := objDados.getAutInc;
        cdsDados.Post;
      End;

      cdsDados.Next;
    End;

  Finally
    If (Assigned(objDados)) Then
      FreeAndNil(objDados);
  End;
end;

function TCadMetController.fBuscaPorMesAno(strCodVen, strMesAno: String): TCadMet;
begin
  Result := objDAO.fBuscaPorMesAno(strCodVen, strMesAno);
end;

function TCadMetController.fExisteCadastro(strCodVen, strMesAno: String): Boolean;
  Var
    objDados: TCadMet;
begin
  objDados := fBuscaPorMesAno(strCodVen, strMesAno);

  Try
    Result := (Assigned(objDados)) And (Not fEmptyStr(objDados.getAutInc));
  Finally
    FreeAndNil(objDados);
  End;
end;

function TCadMetController.fInserirBase(strCodVen, strMesAno: String): Boolean;
  Var
    objDados: TCadMet;
begin
  Result := True;

  If (fExisteCadastro(strCodVen, strMesAno)) Then
    Exit;

  objDados := TCadMet.Create('', Vs_strCodEmp, strMesAno, strCodVen);

  Try
    Result := objDAO.fGravar(objDados);
  Finally
    FreeAndNil(objDados);
  End;
end;

end.
