{*******************************************************************************************}
{* Interface que representa um configurador da tela de consulta de tinta, assim cada tinta *}
{* pode configurar a consulta de distintas                                                 *}
{****************************************************************************************PH*}
unit untIConfiguradorConsulta;

interface

type
  IConfiguradorConsulta = interface
    ['{F859AF8F-0CD9-46EE-A182-17992BF3D4E3}']
    procedure pAdicionarCampo(strNomCampo, strDesCampo, strOperador: String;
      blnVisivel: Boolean = False; blnDisponivel: Boolean = True);
    procedure fSetPos(strNomeCampo: String; intPos: Integer);
    procedure fSetVisivel(strNomeCampo: String; blnValor: Boolean); overload;
    procedure fSetVisivel(intPos: Integer; blnValor: Boolean); overload;
    procedure pAdicionarIndice(strNomeCampo, strDesCampo: String);
    procedure pAdicionarCampoDescricao(strNomeCampo: String);
    function fVerificaConfigurado(): Boolean;
    procedure pRestaurarPadrao;
    procedure pSalvarConfs();
    function fGetQtdColunas: Integer;
    function fGetDisponivel(intPos: Integer): Boolean; overload;
    function fGetDisponivel(strNomeCampo: String): Boolean; overload;
    function fGetVisivel(intPos: Integer): Boolean;
    function fGetNomeCampoColuna(intPos: Integer): String; overload;
    function fGetNomeCampoColuna(strCaptionColuna: String): String; overload;
    function GetCodIte(): String;     

  end;

implementation

end.
