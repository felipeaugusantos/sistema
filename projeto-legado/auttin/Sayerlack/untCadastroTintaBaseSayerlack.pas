unit untCadastroTintaBaseSayerlack;

interface

uses
  untCadastroTintaBase;

Type
  TCadastroTintaBaseSayerlack = class(TCadastroTintaBase)
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

uses
  untConsultaCadastroBaseSayerlack;

{ TCadastroTintaBaseVelutex }

constructor TCadastroTintaBaseSayerlack.Create;
begin
  inherited Create(TConsultaCadastroBaseSayerlack.Create);
end;

destructor TCadastroTintaBaseSayerlack.Destroy;
begin

  inherited;
end;

function TCadastroTintaBaseSayerlack.fGetCampoBase: String;
begin
  Result := 'BAS_BASE__';
end;

function TCadastroTintaBaseSayerlack.fGetCampoChave(intIndex: Integer): String;
const
  arrChaves: array[0..2] of string = ('BAS_BASE__', 'BAS_CODBAS', 'BAS_DESEMB');
begin
  Result := arrChaves[intIndex];
end;

function TCadastroTintaBaseSayerlack.fGetCampoCodigo: String;
begin
  Result := 'BAS_CODBAS';
end;

function TCadastroTintaBaseSayerlack.fGetCampoCodItem: String;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroTintaBaseSayerlack.fGetCampoCusto: String;
begin
  Result := 'BAS_PRECUS'; 
end;

function TCadastroTintaBaseSayerlack.fGetCampoDescricao: String;
begin
  Result := 'BAS_PRODUT';
end;

function TCadastroTintaBaseSayerlack.fGetCampoMargem: String;
begin
  Result := 'BAS_MARGEM';
end;

function TCadastroTintaBaseSayerlack.fGetCampoUnidade: String;
begin
  Result := 'BAS_DESEMB';
end;

function TCadastroTintaBaseSayerlack.fGetCampoVenda: String;
begin
  Result := 'BAS_PREVEN';
end;

function TCadastroTintaBaseSayerlack.fGetCountCamposChave: Integer;
begin
  Result := 2;  
end;

function TCadastroTintaBaseSayerlack.fGetIdePro: String;
begin
  Result := 'SAY';
end;

function TCadastroTintaBaseSayerlack.fGetLabelBase: String;
begin
  Result := 'Base';
end;

function TCadastroTintaBaseSayerlack.fGetLabelCodigo: String;
begin
  Result := 'Código';
end;

function TCadastroTintaBaseSayerlack.fGetLabelDescricao: String;
begin
  Result := 'Produto';
end;

function TCadastroTintaBaseSayerlack.fGetLabelUndiade: String;
begin
  Result := 'Embalagem';
end;

function TCadastroTintaBaseSayerlack.fGetNomeCampo: String;
begin
  Result := fGetCampoDescricao;
end;

function TCadastroTintaBaseSayerlack.fGetNomeTabela: String;
begin
  Result := 'SAY_CADBAS';
end;

end.
