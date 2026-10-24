unit Produto.GS1CNP.Interfaces.Http;

interface

uses idHTTP;

type
  IProdutoGS1CNPHttp = interface
    ['{ED2D4EF1-D04B-4222-AA1C-967AF22144EA}']

    function GetHttp: TidHTTP;
    function SetCustomHeaders(const AAcessToken: String): IProdutoGS1CNPHttp;
  end;

implementation

end.
