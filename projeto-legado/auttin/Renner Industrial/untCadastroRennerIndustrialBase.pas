unit untCadastroRennerIndustrialBase;

interface

uses
  untCadastroTintaBase, untIConsulta, untConsultaCadastroBaseRennerIndustrial;

Type
  TCadastroRennerIndustrialBase = class(TCadastroTintaBase)
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

{ TCadastroRennerIndustrialBase }

constructor TCadastroRennerIndustrialBase.Create;
begin
  Inherited Create(TConsultaCadastroBaseRennerIndustrial.Create);
end;

function TCadastroRennerIndustrialBase.fGetCampoBase: String;
begin
  Result := 'BAS_BASE__';
end;

function TCadastroRennerIndustrialBase.fGetCampoChave(
  intIndex: Integer): String;
  Const
    arrChaves: Array[0..2] Of String = ('BAS_BASE__', 'BAS_UNIDAD', 'BAS_DESCRI');
begin
  Result := arrChaves[intIndex];
end;

function TCadastroRennerIndustrialBase.fGetCampoCodigo: String;
begin
  Result := '';
end;

function TCadastroRennerIndustrialBase.fGetCampoCodItem: String;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroRennerIndustrialBase.fGetCampoCusto: String;
begin
  Result := 'BAS_PRECUS';
end;

function TCadastroRennerIndustrialBase.fGetCampoDescricao: String;
begin
  Result := 'BAS_DESCRI';
end;

function TCadastroRennerIndustrialBase.fGetCampoMargem: String;
begin
  Result := 'BAS_MARGEM';
end;

function TCadastroRennerIndustrialBase.fGetCampoUnidade: String;
begin
  Result := 'BAS_UNIDAD';
end;

function TCadastroRennerIndustrialBase.fGetCampoVenda: String;
begin
  Result := 'BAS_PREVEN';
end;

function TCadastroRennerIndustrialBase.fGetCountCamposChave: Integer;
begin
  Result := 3;
end;

function TCadastroRennerIndustrialBase.fGetIdePro: String;
begin
  Result := 'REN';
end;

function TCadastroRennerIndustrialBase.fGetNomeCampo: String;
begin
  Result := fGetCampoBase;
end;

function TCadastroRennerIndustrialBase.fGetNomeTabela: String;
begin
  Result := 'REN_CADBAS';
end;

function TCadastroRennerIndustrialBase.fGetNomeTinta: String;
begin
  Result := 'Renner Industrial';
end;


end.
