unit untCadastroTintaBaseAlessi;

interface

uses
  untCadastroTintaBase;

Type
  TCadastroTintaBaseAlessi = class(TCadastroTintaBase)
  public
    function fGetCampoBase: String; override;
    function fGetCampoCodItem: String; override;
    function fGetCampoCodigo: String; override;
    function fGetCampoCusto: String; override;
    function fGetCampoDescricao: String; override;
    function fGetCampoMargem: String; override;
    function fGetCampoUnidade: String; override;
    function fGetCampoEmbala: String; override;
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

    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses untConsultaCadastroBaseAlessi;

{ TCadastroTintaBaseAlessi }

constructor TCadastroTintaBaseAlessi.Create;
begin
  inherited Create(TConsultaCadastroBaseAlessi.Create);  
end;

destructor TCadastroTintaBaseAlessi.Destroy;
begin

  inherited;
end;

function TCadastroTintaBaseAlessi.fGetCampoBase: String;
begin
  Result := '';
end;

function TCadastroTintaBaseAlessi.fGetCampoChave(intIndex: Integer): String;
const
  arrChaves: array[0..2] of string = ('BAS_PRODUT', 'BAS_BASE__', 'BAS_CODUNI');
begin
  Result := arrChaves[intIndex];
end;

function TCadastroTintaBaseAlessi.fGetCampoCodigo: String;
begin
  Result := 'BAS_BASE__';
end;

function TCadastroTintaBaseAlessi.fGetCampoCodItem: String;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroTintaBaseAlessi.fGetCampoCusto: String;
begin
  Result := 'BAS_PRECUS';
end;

function TCadastroTintaBaseAlessi.fGetCampoDescricao: String;
begin
  Result := 'BAS_PRODUT';
end;

function TCadastroTintaBaseAlessi.fGetCampoEmbala: String;
begin
  Result := 'BAS_EMBALA';
end;

function TCadastroTintaBaseAlessi.fGetCampoMargem: String;
begin
  Result := 'BAS_MARGEM';
end;

function TCadastroTintaBaseAlessi.fGetCampoUnidade: String;
begin
  Result := 'BAS_CODUNI';
end;

function TCadastroTintaBaseAlessi.fGetCampoVenda: String;
begin
  Result := 'BAS_PREVEN';
end;

function TCadastroTintaBaseAlessi.fGetCountCamposChave: Integer;
begin
  Result := 3;
end;

function TCadastroTintaBaseAlessi.fGetIdePro: String;
begin
  Result := 'ALE';
end;

function TCadastroTintaBaseAlessi.fGetLabelBase: String;
begin
  Result := 'Base';
end;

function TCadastroTintaBaseAlessi.fGetLabelCodigo: String;
begin
  Result := 'Código';
end;

function TCadastroTintaBaseAlessi.fGetLabelDescricao: String;
begin
  Result := 'Produto';
end;

function TCadastroTintaBaseAlessi.fGetNomeCampo: String;
begin
  Result := fGetCampoDescricao;
end;

function TCadastroTintaBaseAlessi.fGetNomeTabela: String;
begin
  Result := 'ALE_CADBAS';
end;

function TCadastroTintaBaseAlessi.fGetNomeTinta: String;
begin
  Result := 'Alessi';
end;

end.
