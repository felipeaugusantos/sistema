unit untCadastroTintaBaseCalamar;

interface

uses
  untCadastroTintaBase;

Type
  TCadastroTintaBaseCalamar = class(TCadastroTintaBase)
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
    function fGetCountCamposChave: Integer; override;
    function fGetCampoChave(intIndex: Integer): String; override;
    function fGetLabelUndiade: String; override;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses untConsultaCadastroBaseCalamar;

{ TCadastroTintaBaseCalamar }

constructor TCadastroTintaBaseCalamar.Create;
begin
  inherited Create(TConsultaCadastroBaseCalamar.Create);
end;

destructor TCadastroTintaBaseCalamar.Destroy;
begin

  inherited;
end;

function TCadastroTintaBaseCalamar.fGetCampoBase: String;
begin
  Result := '';
end;

function TCadastroTintaBaseCalamar.fGetCampoChave(intIndex: Integer): String;
const
  arrChaves: array[0..1] of string = ('BAS_CODBAS', 'BAS_CODEMB');
begin
  Result := arrChaves[intIndex];
end;

function TCadastroTintaBaseCalamar.fGetCampoCodigo: String;
begin
  Result := 'BAS_CODBAS';
end;

function TCadastroTintaBaseCalamar.fGetCampoCodItem: String;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroTintaBaseCalamar.fGetCampoCusto: String;
begin
  Result := 'BAS_PRECUS';
end;

function TCadastroTintaBaseCalamar.fGetCampoDescricao: String;
begin
  Result := 'BAS_DESCRI';
end;

function TCadastroTintaBaseCalamar.fGetCampoMargem: String;
begin
  Result := 'BAS_MARGEM';
end;

function TCadastroTintaBaseCalamar.fGetCampoUnidade: String;
begin
  Result := 'BAS_CODEMB';
end;

function TCadastroTintaBaseCalamar.fGetCampoVenda: String;
begin
  Result := 'BAS_PREVEN';
end;

function TCadastroTintaBaseCalamar.fGetCountCamposChave: Integer;
begin
  Result := 2;
end;

function TCadastroTintaBaseCalamar.fGetIdePro: String;
begin
  Result := 'CAL';
end;

function TCadastroTintaBaseCalamar.fGetLabelBase: String;
begin
  Result := '';
end;

function TCadastroTintaBaseCalamar.fGetLabelCodigo: String;
begin
  Result := 'Base';
end;

function TCadastroTintaBaseCalamar.fGetLabelUndiade: String;
begin
  Result := 'Embalagem';
end;

function TCadastroTintaBaseCalamar.fGetNomeCampo: String;
begin
  Result := fGetCampoDescricao;
end;

function TCadastroTintaBaseCalamar.fGetNomeTabela: String;
begin
  Result := 'CAL_CADBAS' ;
end;

function TCadastroTintaBaseCalamar.fGetNomeTinta: String;
begin
  Result := 'Calamar';
end;

end.
