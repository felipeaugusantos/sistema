unit untCadastroTintaBaseVelutex;

interface

uses
  untCadastroTintaBase;

Type
  TCadastroTintaBaseVelutex = class(TCadastroTintaBase)
  public
    function fGetCampoBase: String; override;
    function fGetCampoCodItem: String; override;
    function fGetCampoCodigo: String; override;
    function fGetCampoCusto: String; override;
    function fGetCampoDescricao: String; override;
    function fGetCampoMargem: String; override;
    function fGetCampoUnidade: String; override;
    function fGetCampoVenda: String; override;

    function fGetIdePro: String; override;
    function fGetNomeTabela: String; override;

    function fGetNomeTinta: String; override;
    function fGetNomeCampo: String; override;

    function fGetLabelBase: String; override;
    function fGetLabelCodigo: String; override;
    function fGetLabelDescricao: String; override;
    function fGetCountCamposChave: Integer; override;
    function fGetCampoChave(intIndex: Integer): String; override;
    function fGetLabelUndiade: String; override; 

    function fGetCampoCadIteCodIte(): String; override;

    function fGetFiltro(): String; override;


    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses untConsultaCadastroBaseVelutex;

{ TCadastroTintaBaseVelutex }

constructor TCadastroTintaBaseVelutex.Create;
begin
  inherited Create(TConsultaCadastroBaseVelutex.Create);
end;

destructor TCadastroTintaBaseVelutex.Destroy;
begin

  inherited;
end;

function TCadastroTintaBaseVelutex.fGetCampoBase: String;
begin
  Result := '';
end;

function TCadastroTintaBaseVelutex.fGetCampoCadIteCodIte: String;
begin
  Result := 'BAS_CODITE' ;
end;

function TCadastroTintaBaseVelutex.fGetCampoChave(intIndex: Integer): String;
const
  arrChaves: array[0..2] of string = ('BAS_CODBAS', 'BAS_PRODUT', 'BAS_CODUNI');
begin
  Result := arrChaves[intIndex];
end;

function TCadastroTintaBaseVelutex.fGetCampoCodigo: String;
begin
  Result := 'BAS_CODBAS';
end;

function TCadastroTintaBaseVelutex.fGetCampoCodItem: String;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroTintaBaseVelutex.fGetCampoCusto: String;
begin
  Result := 'BAS_PRECUS';
end;

function TCadastroTintaBaseVelutex.fGetCampoDescricao: String;
begin
  Result := 'BAS_PRODUT';
end;

function TCadastroTintaBaseVelutex.fGetCampoMargem: String;
begin
  Result := 'BAS_MARGEM';
end;

function TCadastroTintaBaseVelutex.fGetCampoUnidade: String;
begin
  Result := 'BAS_CODUNI';
end;

function TCadastroTintaBaseVelutex.fGetCampoVenda: String;
begin
  Result := 'BAS_PREVEN';
end;

function TCadastroTintaBaseVelutex.fGetCountCamposChave: Integer;
begin
  Result := 3;
end;

function TCadastroTintaBaseVelutex.fGetFiltro: String;
begin
  Result := ' AND ITE_ITEBAS = "S" ';
end;

function TCadastroTintaBaseVelutex.fGetIdePro: String;
begin
  Result := 'VEL';
end;

function TCadastroTintaBaseVelutex.fGetLabelBase: String;
begin
  Result := 'Base';
end;

function TCadastroTintaBaseVelutex.fGetLabelCodigo: String;
begin
  Result := 'Código';
end;

function TCadastroTintaBaseVelutex.fGetLabelDescricao: String;
begin
  Result := 'Produto';
end;

function TCadastroTintaBaseVelutex.fGetLabelUndiade: String;
begin
  Result := 'Unidade';
end;

function TCadastroTintaBaseVelutex.fGetNomeCampo: String;
begin
  Result := fGetCampoDescricao;
end;

function TCadastroTintaBaseVelutex.fGetNomeTabela: String;
begin
  Result := 'VEL_CADBAS' ;
end;

function TCadastroTintaBaseVelutex.fGetNomeTinta: String;
begin
  Result := 'Velutex';
end;

end.
