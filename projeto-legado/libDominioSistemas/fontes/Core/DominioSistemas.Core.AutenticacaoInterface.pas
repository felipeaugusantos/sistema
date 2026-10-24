unit DominioSistemas.Core.AutenticacaoInterface;

interface

type
  IAutenticacao = interface
    ['{605114DD-F95A-46AC-97F8-78C3C9A3F7B0}']
    function fGetAccessToken(const ACodEmp: String): String ;
    function fGetXIntegrationKey(const ACodEmp: String): String ;
  end ;

  IAutenticacaoFactory = interface
    ['{C12A3241-10BB-436D-954F-5DF362C10F30}']
    function fCriar: IAutenticacao;
  end ;

implementation

end.
