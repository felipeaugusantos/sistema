unit untCadastroTintaBaseInternational;

interface

uses
  untCadastroTintaBase;

Type
  TCadastroTintaBaseInternational = class(TCadastroTintaBase)
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

uses untConsultaCadastroBaseInternational;

{ TCadastroTintaBaseVelutex }

constructor TCadastroTintaBaseInternational.Create;
begin
  inherited Create(TConsultaCadastroBaseInternational.Create);
end;

destructor TCadastroTintaBaseInternational.Destroy;
begin

  inherited;
end;

function TCadastroTintaBaseInternational.fGetCampoBase: String;
begin
  Result := '';
end;

function TCadastroTintaBaseInternational.fGetCampoChave(intIndex: Integer): String;
const
  arrChaves: array[0..1] of string = ('BAS_CODBAS', 'BAS_CODEMB');
begin
  Result := arrChaves[intIndex];
end;

function TCadastroTintaBaseInternational.fGetCampoCodigo: String;
begin
  Result := 'BAS_CODBAS';
end;

function TCadastroTintaBaseInternational.fGetCampoCodItem: String;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroTintaBaseInternational.fGetCampoCusto: String;
begin
  Result := 'BAS_PRECUS';
end;

function TCadastroTintaBaseInternational.fGetCampoDescricao: String;
begin
  Result := 'BAS_DESCRI';
end;

function TCadastroTintaBaseInternational.fGetCampoMargem: String;
begin
  Result := 'BAS_MARGEM';
end;

function TCadastroTintaBaseInternational.fGetCampoUnidade: String;
begin
  Result := 'BAS_CODEMB';
end;

function TCadastroTintaBaseInternational.fGetCampoVenda: String;
begin
  Result := 'BAS_PREVEN';
end;

function TCadastroTintaBaseInternational.fGetCountCamposChave: Integer;
begin
  Result := 2;
end;

function TCadastroTintaBaseInternational.fGetIdePro: String;
begin
  Result := 'INT';
end;

function TCadastroTintaBaseInternational.fGetLabelBase: String;
begin
  Result := '';
end;

function TCadastroTintaBaseInternational.fGetLabelCodigo: String;
begin
  Result := 'Base';
end;

function TCadastroTintaBaseInternational.fGetLabelDescricao: String;
begin
  Result := 'Descrição';
end;

function TCadastroTintaBaseInternational.fGetLabelUndiade: String;
begin
  Result := 'Embalagem';
end;

function TCadastroTintaBaseInternational.fGetNomeCampo: String;
begin
  Result := fGetCampoCodigo;
end;

function TCadastroTintaBaseInternational.fGetNomeTabela: String;
begin
  Result := 'INT_CADBAS' ;
end;

function TCadastroTintaBaseInternational.fGetNomeTinta: String;
begin
  Result := 'International';
end;

end.
