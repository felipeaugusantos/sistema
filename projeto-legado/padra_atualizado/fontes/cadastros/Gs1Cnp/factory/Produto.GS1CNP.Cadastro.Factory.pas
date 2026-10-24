unit Produto.GS1CNP.Cadastro.Factory;

interface

uses Data.DB, UniClientDataSet, untFuncoesSimples, Produto.GS1CNP.Interfaces.Cadastro,
  Produto.GS1CNP.Tipos.Cadastro, Produto.GS1CNP.Service.Cadastro, System.SysUtils,
  Produto.GS1CNP.Parametros.Factory;

type
  TProdutoGS1CNPCadastroFactory = class(TInterfacedObject, IProdutoGS1CNPCadastroFactory)
  private
  public
    function Cadastrar(const AQryCadIte: TDataSet; const AGTIN: String; const AEanTrb: Boolean;
      const AAccessToken: String; const AStatusGTIN: String): IRetornoGS1CNPCadastro;

    class function New(): IProdutoGS1CNPCadastroFactory;
  end;

implementation

{ TProdutoGS1CNPCadastroFactory }

function TProdutoGS1CNPCadastroFactory.Cadastrar(const AQryCadIte: TDataSet; const AGTIN: String;
  const AEanTrb: Boolean; const AAccessToken: String; const AStatusGTIN: String): IRetornoGS1CNPCadastro;
var
  LRetorno: IRetornoGS1CNPCadastro;
begin
  LRetorno :=
    TProdutoGS1CNPServiceCadastro.New(AAccessToken)
      .Cadastrar(
        TProdutoGS1CNPParametrosFactory.New(AQryCadIte, AGTIN, AEanTrb, AStatusGTIN)
          .RetornaParametrosCadastro()
      );

  Result := LRetorno;
end;

class function TProdutoGS1CNPCadastroFactory.New: IProdutoGS1CNPCadastroFactory;
begin
  Result := Self.Create;
end;

end.
