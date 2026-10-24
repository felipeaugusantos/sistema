unit untCadastroSuvinilBase;

interface

uses
  untCadastroTintaBase;

Type
  TCadastroTintaBaseSuvinil = class(TCadastroTintaBase)
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
    
    constructor Create;
    destructor Destroy; override;


  End;

implementation

uses untConsultaCadastroBaseSuvinil,
     Classes, SysUtils;



{ TCadastroTintaBaseSuvinil }

constructor TCadastroTintaBaseSuvinil.Create;
begin
  Inherited Create(TConsultaCadastroBaseSuvinil.Create);
end;

destructor TCadastroTintaBaseSuvinil.Destroy;
begin

  inherited;
end;

function TCadastroTintaBaseSuvinil.fGetCampoBase: String;
begin
  Result := 'SUV_CODBAS';
end;

function TCadastroTintaBaseSuvinil.fGetCampoChave(
  intIndex: Integer): String;
  Const
    arrChaves: Array[0..2] Of String = ('SUV_CODFML', 'SUV_CODBAS', 'SUV_CODUNI');
begin
  Result := arrChaves[intIndex];
end;

function TCadastroTintaBaseSuvinil.fGetCampoCodigo: String;
begin
  Result := 'SUV_CODFML';
end;

function TCadastroTintaBaseSuvinil.fGetCampoCodItem: String;
begin
  Result := 'SUV_CODITE';
end;

function TCadastroTintaBaseSuvinil.fGetCampoCusto: String;
begin
  Result := 'SUV_PRECUS';
end;

function TCadastroTintaBaseSuvinil.fGetCampoDescricao: String;
begin
  Result := 'SUV_DESCRI';
end;

function TCadastroTintaBaseSuvinil.fGetCampoMargem: String;
begin
  Result := 'SUV_MARGEM';
end;


function TCadastroTintaBaseSuvinil.fGetCampoUnidade: String;
begin
  Result := 'SUV_CODUNI';
end;

function TCadastroTintaBaseSuvinil.fGetCampoVenda: String;
begin
  Result := 'SUV_PREVEN';
end;


function TCadastroTintaBaseSuvinil.fGetCountCamposChave: Integer;
begin
  Result := 3;
end;

function TCadastroTintaBaseSuvinil.fGetIdePro: String;
begin
  Result := 'SUV';
end;

function TCadastroTintaBaseSuvinil.fGetLabelBase: String;
begin
  Result := 'Base';
end;

function TCadastroTintaBaseSuvinil.fGetLabelCodigo: String;
begin
  Result := 'Código';
end;

function TCadastroTintaBaseSuvinil.fGetNomeCampo: String;
begin
  Result := fGetCampoCodigo;
end;

function TCadastroTintaBaseSuvinil.fGetNomeTabela: String;
begin
  Result := 'SUV_CADBAS';
end;

function TCadastroTintaBaseSuvinil.fGetNomeTinta: String;
begin
  Result := 'Suvinil';
end;

end.
