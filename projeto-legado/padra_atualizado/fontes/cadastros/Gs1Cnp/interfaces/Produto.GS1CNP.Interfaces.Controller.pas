unit Produto.GS1CNP.Interfaces.Controller;

interface

uses Data.DB, UniClientDataSet, untFuncoesSimples, Produto.GS1CNP.Interfaces.Cadastro,
  Produto.GS1CNP.Interfaces.Atualiza;

type
  IProdutoGS1CNPController = interface
    ['{730648B9-66E9-4924-8CE5-28A6C69352BF}']

    procedure Consultar(dicValoresAtuais, dicResultado: TDicionario;
      const ACodBar: String; AInsert: Boolean; const AAccessToken: String);

    function Cadastrar(const AQryCadIte: TDataSet; const AGTIN: String;
      const AEanTrb: Boolean; const AAccessToken: String; const AStatusGTIN: String): IRetornoGS1CNPCadastro;

    function Atualizar(const AQryCadIte: TDataSet; const AGTIN: String;
      const AEanTrb: Boolean; const AAccessToken: String; const AStatusGTIN: String): IRetornoGS1CNPAtualiza;
  end;

implementation

end.
