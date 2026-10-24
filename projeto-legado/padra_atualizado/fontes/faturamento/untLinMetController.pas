unit untLinMetController;

interface

uses
  untLinMet, untLinMetDAO, System.SysUtils, Uni, UniClientDataSet;

type
  TLinMetController = class
  private
    objLinMetDAO: TLinMetDAO;
    function fTrataExclusao(cdsDados: TUniClientDataSet; strComLin: String): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function fGravar(cdsDados: TUniClientDataSet; strComLin: String): Boolean;
    function fDeletarColecao(strComLin: String): Boolean;
    procedure pCarregaLista(strComLin: String; Var cdsDados: TUniClientDataSet);
  end;

implementation

uses
  untFuncoesSimples;

{ TLinMetController }

constructor TLinMetController.Create;
begin
  objLinMetDAO := TLinMetDAO.Create;
end;

destructor TLinMetController.Destroy;
begin
  FreeAndNil(objLinMetDAO);
end;

procedure TLinMetController.pCarregaLista(strComLin: String; Var cdsDados: TUniClientDataSet);
begin
  objLinMetDAO.pCarregaLista(strComLin, cdsDados);
end;

function TLinMetController.fGravar(cdsDados: TUniClientDataSet; strComLin: String): Boolean;
begin
  Result := False;

  If (Not fTrataExclusao(cdsDados, strComLin)) Then
    Exit;

  If (Not objLinMetDAO.fGravarColecao(cdsDados)) Then
    Exit;

  Result := True;
end;

function TLinMetController.fTrataExclusao(cdsDados: TUniClientDataSet; strComLin: String): Boolean;
  Var
    cdsBusca: TUniClientDataSet;
begin
  Result := True;
  cdsBusca := TUniClientDataSet.Create(Nil);

  Try
    objLinMetDAO.pCarregaLista(strComLin, cdsBusca);
    cdsBusca.First;

    While (Not cdsBusca.Eof) Do
    Begin
      If (Not cdsDados.Locate('AUTOINCREM', cdsBusca.FieldByName('AUTOINCREM').AsString, [])) Then
        Result := objLinMetDAO.fDeletar(cdsBusca.FieldByName('AUTOINCREM').AsString);
      cdsBusca.Next;
    End;

  Finally
    FreeAndNil(cdsBusca);
  End;
end;

function TLinMetController.fDeletarColecao(strComLin: String): Boolean;
begin
  Result := objLinMetDAO.fDeletarColecao(strComLin);
end;

end.
