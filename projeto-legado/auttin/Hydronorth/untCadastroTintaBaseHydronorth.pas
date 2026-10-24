unit untCadastroTintaBaseHydronorth;

interface

uses
  untCadastroTintaBase;

Type
  TCadastroTintaBaseHydronorth = class(TCadastroTintaBase)
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

    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses untConsultaCadastroBaseHydronorth;

{ TCadastroTintaBaseVelutex }

constructor TCadastroTintaBaseHydronorth.Create;
begin
  inherited Create(TConsultaCadastroBaseHydronorth.Create);
end;

destructor TCadastroTintaBaseHydronorth.Destroy;
begin

  inherited;
end;

function TCadastroTintaBaseHydronorth.fGetCampoBase: String;
begin
  Result := '';
end;

function TCadastroTintaBaseHydronorth.fGetCampoChave(intIndex: Integer): String;
const
  arrChaves: array[0..2] of string = ('BAS_BASE__', 'BAS_PRODUT', 'BAS_CODEMB');
begin
  Result := arrChaves[intIndex];
end;

function TCadastroTintaBaseHydronorth.fGetCampoCodigo: String;
begin
  Result := 'BAS_BASE__';
end;

function TCadastroTintaBaseHydronorth.fGetCampoCodItem: String;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroTintaBaseHydronorth.fGetCampoCusto: String;
begin
  Result := 'BAS_PRECUS';
end;

function TCadastroTintaBaseHydronorth.fGetCampoDescricao: String;
begin
  Result := 'BAS_PRODUT';
end;

function TCadastroTintaBaseHydronorth.fGetCampoMargem: String;
begin
  Result := 'BAS_MARGEM';
end;

function TCadastroTintaBaseHydronorth.fGetCampoUnidade: String;
begin
  Result := 'BAS_CODEMB';
end;

function TCadastroTintaBaseHydronorth.fGetCampoVenda: String;
begin
  Result := 'BAS_PREVEN';
end;

function TCadastroTintaBaseHydronorth.fGetCountCamposChave: Integer;
begin
  Result := 3;
end;

function TCadastroTintaBaseHydronorth.fGetIdePro: String;
begin
  Result := 'HYD';
end;

function TCadastroTintaBaseHydronorth.fGetLabelBase: String;
begin
  Result := '';
end;

function TCadastroTintaBaseHydronorth.fGetLabelCodigo: String;
begin
  Result := 'Base';
end;

function TCadastroTintaBaseHydronorth.fGetLabelDescricao: String;
begin
  Result := 'Produto';
end;

function TCadastroTintaBaseHydronorth.fGetLabelUndiade: String;
begin
  Result := 'Embalagem';
end;

function TCadastroTintaBaseHydronorth.fGetNomeCampo: String;
begin
  Result := fGetCampoDescricao;
end;

function TCadastroTintaBaseHydronorth.fGetNomeTabela: String;
begin
  Result := 'HYD_CADBAS' ;
end;

function TCadastroTintaBaseHydronorth.fGetNomeTinta: String;
begin
  Result := 'Hydronorth Imobiliária';
end;

end.