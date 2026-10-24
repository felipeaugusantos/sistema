unit untDepTabController;

interface

uses
  untDepTab, untDepTabDAO, System.SysUtils, Uni, UniClientDataSet;

type
  TDepTabController = class
  private
    objDepTabDAO: TDepTabDAO;
    function fTrataExclusao(cdsDepTab: TUniClientDataSet; strCodCom: String): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function fGravar(cdsDepTab: TUniClientDataSet; strCodCom: String): Boolean;
    function fDeletarColecao(strCodCom: String): Boolean;
    procedure pCarregaLista(strCodCom: String; Var cdsDepTab: TUniClientDataSet);
  end;

implementation

uses
  untFuncoesSimples;

{ TDepTabController }

constructor TDepTabController.Create;
begin
  objDepTabDAO := TDepTabDAO.Create;
end;

destructor TDepTabController.Destroy;
begin
  FreeAndNil(objDepTabDAO);
end;

procedure TDepTabController.pCarregaLista(strCodCom: String; Var cdsDepTab: TUniClientDataSet);
begin
  objDepTabDAO.pCarregaLista(strCodCom, cdsDepTab);
end;

function TDepTabController.fGravar(cdsDepTab: TUniClientDataSet; strCodCom: String): Boolean;
begin
  Result := False;

  If (Not fTrataExclusao(cdsDepTab, strCodCom)) Then
    Exit;

  If (Not objDepTabDAO.fGravarColecao(cdsDepTab)) Then
    Exit;

  Result := True;
end;

function TDepTabController.fTrataExclusao(cdsDepTab: TUniClientDataSet; strCodCom: String): Boolean;
  Var
    cdsBusca: TUniClientDataSet;
begin
  Result := True;
  cdsBusca := TUniClientDataSet.Create(Nil);

  Try
    objDepTabDAO.pCarregaLista(strCodCom, cdsBusca);
    cdsBusca.First;

    While (Not cdsBusca.Eof) Do
    Begin
      If (Not cdsDepTab.Locate('AUTOINCREM', cdsBusca.FieldByName('AUTOINCREM').AsString, [])) Then
        Result := objDepTabDAO.fDeletar(cdsBusca.FieldByName('AUTOINCREM').AsString);
      cdsBusca.Next;
    End;

  Finally
    FreeAndNil(cdsBusca);
  End;
end;

function TDepTabController.fDeletarColecao(strCodCom: String): Boolean;
begin
  Result := objDepTabDAO.fDeletarColecao(strCodCom);
end;

end.
