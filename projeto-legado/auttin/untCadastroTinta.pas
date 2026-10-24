unit untCadastroTinta;

interface

uses
  untICadastroTinta, untIConsulta;

Type
  TCadastroTinta = class(TInterfacedObject, ICadastroTinta)
  protected
    consulta: IConsulta;
  public
    constructor Create(consulta: IConsulta);
    function fGetCampoCadIteCodIte: String; virtual;
    function fGetCampoChave(intIndex: Integer): String; virtual; abstract;
    function fGetConsulta: IConsulta; virtual;
    function fGetCountCamposChave: Integer; virtual; abstract;
    function fGetIdePro: String; virtual; abstract;
    function fGetLabelCodIteCodIte: String; virtual;
    function fGetNomeCampo: String; virtual; abstract;
    function fGetNomeClasse: String; virtual;
    function fGetNomeTabela: String; virtual; abstract;
    function fGetNomeTinta: String; virtual; 
    function fValidaCampos(strNomeCampo: String; strValorCampo: String;
      var strRetorno: String): Boolean; virtual; abstract;
  End;

implementation

uses untFuncTinta;

{ TCadastroTinta }

constructor TCadastroTinta.Create(consulta: IConsulta);
begin
  Self.consulta := consulta;
end;

function TCadastroTinta.fGetCampoCadIteCodIte: String;
begin
  Result := 'ITE_CODITE';
end;

function TCadastroTinta.fGetConsulta: IConsulta;
begin
  Result := consulta;
end;

function TCadastroTinta.fGetLabelCodIteCodIte: String;
begin
  Result := 'Item';
end;

function TCadastroTinta.fGetNomeClasse: String;
begin
  Result := Self.ClassName;
end;

function TCadastroTinta.fGetNomeTinta: String;
begin
  Result := fGetTintasdeMaquina.fGetNomeTinta(fGetIdePro);
end;

end.
