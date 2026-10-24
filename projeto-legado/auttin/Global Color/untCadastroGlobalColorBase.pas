unit untCadastroGlobalColorBase;

interface

uses
  untCadastroTintaBase, untIConsulta, untConsultaCadastroBaseGlobalColor;

Type
  TCadastroGlobalColorBase = class(TCadastroTintaBase)
  public
    constructor Create;
    function fGetCampoBase: String; override;
    function fGetCampoChave(intIndex: Integer): String; override;
    function fGetCampoCodItem: String; override;
    function fGetCampoCodigo: String; override;
    function fGetCampoCusto: String; override;
    function fGetCampoDescricao: String; override;
    function fGetCampoMargem: String; override;
    function fGetCampoUnidade: String; override;
    function fGetCampoVenda: String; override;
    function fGetCountCamposChave: Integer; override;
    function fGetIdePro: String; override;
    function fGetNomeCampo: String; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;    
  End;


implementation

{ TCadastroGlobalColorBase }

constructor TCadastroGlobalColorBase.Create;
begin
  Inherited Create(TConsultaCadastroBaseGlobalColor.Create);
end;

function TCadastroGlobalColorBase.fGetCampoBase: String;
begin
  Result := 'BAS_BASE__';
end;

function TCadastroGlobalColorBase.fGetCampoChave(
  intIndex: Integer): String;
  Const
    arrChaves: Array[0..2] Of String = ('BAS_BASE__', 'BAS_UNIDAD', 'BAS_DESCRI');
begin
  Result := arrChaves[intIndex];
end;

function TCadastroGlobalColorBase.fGetCampoCodigo: String;
begin
  Result := '';
end;

function TCadastroGlobalColorBase.fGetCampoCodItem: String;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroGlobalColorBase.fGetCampoCusto: String;
begin
  Result := 'BAS_PRECUS';
end;

function TCadastroGlobalColorBase.fGetCampoDescricao: String;
begin
  Result := 'BAS_DESCRI';
end;

function TCadastroGlobalColorBase.fGetCampoMargem: String;
begin
  Result := 'BAS_MARGEM';
end;

function TCadastroGlobalColorBase.fGetCampoUnidade: String;
begin
  Result := 'BAS_UNIDAD';
end;

function TCadastroGlobalColorBase.fGetCampoVenda: String;
begin
  Result := 'BAS_PREVEN';
end;

function TCadastroGlobalColorBase.fGetCountCamposChave: Integer;
begin
  Result := 3;
end;

function TCadastroGlobalColorBase.fGetIdePro: String;
begin
  Result := 'GLO';
end;

function TCadastroGlobalColorBase.fGetNomeCampo: String;
begin
  Result := fGetCampoBase;
end;

function TCadastroGlobalColorBase.fGetNomeTabela: String;
begin
  Result := 'GLO_CADBAS';
end;

function TCadastroGlobalColorBase.fGetNomeTinta: String;
begin
  Result := 'Global Color';
end;


end.
