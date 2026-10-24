unit Produto.GS1CNP.Interfaces.Service;

interface

uses Produto.GS1CNP.Interfaces.Consulta, Produto.GS1CNP.Interfaces.Cadastro,
  Produto.GS1CNP.Interfaces.Atualiza;

type
  IProdutoGS1CNPServiceConsulta = interface
    ['{9B876CDB-DDCF-41DC-9F6F-00CCCAAC88EC}']

    function Consultar(const strCodBar: String): IProdutoGS1CNPConsultaRetorno;
  end;

  IProdutoGS1CNPServiceCadastro = interface
   ['{2BDEE8DC-EEC1-4BED-9635-7824581C795B}']

    function Cadastrar(const AParametros: IParametrosGS1CNPCadastro): IRetornoGS1CNPCadastro;
  end;

  IProdutoGS1CNPServiceAtualiza = interface
    ['{2937FF51-F9F9-4AA6-A7B8-1DB6EEBE5D91}']

    function Atualizar(const AParametros: IParametrosGS1CNPAtualiza): IRetornoGS1CNPAtualiza;
  end;

implementation

end.
