unit Produto.GS1CNP.Atualiza.Factory;

interface

uses Data.DB, Produto.GS1CNP.Interfaces.Atualiza, Produto.GS1CNP.Service.Atualiza,
  Produto.GS1CNP.Parametros.Factory;

type
  TProdutoGS1CNPAtualizaFactory = class(TInterfacedObject, IProdutoGS1CNPAtualizaFactory)
  private
  public
    function Atualizar(const AQryCadIte: TDataSet; const AGTIN: String; const AEanTrb: Boolean;
      const AAccessToken: String; const AStatusGTIN: String): IRetornoGS1CNPAtualiza;

    class function New(): IProdutoGS1CNPAtualizaFactory;
  end;

implementation

{ TProdutoGS1CNPAtualizaFactory }

function TProdutoGS1CNPAtualizaFactory.Atualizar(const AQryCadIte: TDataSet; const AGTIN: String;
  const AEanTrb: Boolean; const AAccessToken: String; const AStatusGTIN: String): IRetornoGS1CNPAtualiza;
var
  LRetorno: IRetornoGS1CNPAtualiza;
begin
  LRetorno :=
    TProdutoGS1CNPServiceAtualiza.New(AAccessToken)
      .Atualizar(
         TProdutoGS1CNPParametrosFactory.New(AQryCadIte, AGTIN, AEanTrb, AStatusGTIN)
           .RetornaParametrosAtualiza()
    );

  Result := LRetorno;
end;

class function TProdutoGS1CNPAtualizaFactory.New: IProdutoGS1CNPAtualizaFactory;
begin
  Result := Self.Create;
end;

end.
