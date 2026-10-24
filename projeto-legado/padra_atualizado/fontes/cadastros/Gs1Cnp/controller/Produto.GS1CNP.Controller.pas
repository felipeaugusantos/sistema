unit Produto.GS1CNP.Controller;

interface

uses Data.DB, UniClientDataSet, Produto.GS1CNP.Interfaces.Controller, untFuncoesSimples,
  Produto.GS1CNP.Consulta.Factory, Produto.GS1CNP.Interfaces.Cadastro, Produto.GS1CNP.Cadastro.Factory,
  Produto.GS1CNP.Interfaces.Atualiza, Produto.GS1CNP.Atualiza.Factory;

type
  TProdutoGS1CNPController = class(TInterfacedObject, IProdutoGS1CNPController)
  private
  public
    procedure Consultar(dicValoresAtuais, dicResultado: TDicionario;
      const ACodBar: String; AInsert: Boolean; const AAccessToken: String);

    function Cadastrar(const AQryCadIte: TDataSet; const AGTIN: String;
      const AEanTrb: Boolean; const AAccessToken: String; const AStatusGTIN: String): IRetornoGS1CNPCadastro;

    function Atualizar(const AQryCadIte: TDataSet; const AGTIN: String;
      const AEanTrb: Boolean; const AAccessToken: String; const AStatusGTIN: String): IRetornoGS1CNPAtualiza;

    class function New(): IProdutoGS1CNPController;
  end;

implementation

{ TProdutoGS1CNPController }

function TProdutoGS1CNPController.Atualizar(const AQryCadIte: TDataSet; const AGTIN: String;
      const AEanTrb: Boolean; const AAccessToken: String; const AStatusGTIN: String): IRetornoGS1CNPAtualiza;
begin
  Result := TProdutoGS1CNPAtualizaFactory.New.Atualizar(AQryCadIte, AGTIN, AEanTrb, AAccessToken, AStatusGTIN);
end;

function TProdutoGS1CNPController.Cadastrar(const AQryCadIte: TDataSet; const AGTIN: String;
      const AEanTrb: Boolean; const AAccessToken: String; const AStatusGTIN: String): IRetornoGS1CNPCadastro;
begin
  Result := TProdutoGS1CNPCadastroFactory.New.Cadastrar(AQryCadIte, AGTIN, AEanTrb, AAccessToken, AStatusGTIN);
end;

procedure TProdutoGS1CNPController.Consultar(dicValoresAtuais, dicResultado: TDicionario;
      const ACodBar: String; AInsert: Boolean; const AAccessToken: String);
begin
  TProdutoGS1CNPConsultaFactory.New.Consultar(dicValoresAtuais, dicResultado, ACodBar, AInsert, AAccessToken);
end;

class function TProdutoGS1CNPController.New: IProdutoGS1CNPController;
begin
  Result := Self.Create;
end;

end.
