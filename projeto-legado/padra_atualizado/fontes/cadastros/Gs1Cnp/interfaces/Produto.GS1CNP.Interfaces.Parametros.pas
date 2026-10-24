unit Produto.GS1CNP.Interfaces.Parametros;

interface

uses Produto.GS1CNP.Interfaces.Cadastro, Produto.GS1CNP.Interfaces.Atualiza;

type
  IProdutoGS1CNPParametrosFactory = interface
    ['{2BFB4E60-3B97-4AA2-8A69-E0FB845DAA7A}']

    function RetornaParametrosCadastro(): IParametrosGS1CNPCadastro;
    function RetornaParametrosAtualiza(): IParametrosGS1CNPAtualiza;
  end;

implementation

end.
