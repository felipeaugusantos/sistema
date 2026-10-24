unit untCadastroAnnettaBase;

interface

uses
  untCadastroTintaBase, untIConsulta, untConsultaCadastroBaseAnnetta;

Type
  TCadastroAnnettaBase = class(TCadastroTintaBase)
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

{ TCadastroAnnettaBase }

constructor TCadastroAnnettaBase.Create;
begin
  Inherited Create(TConsultaCadastroBaseAnnetta.Create);
end;

function TCadastroAnnettaBase.fGetCampoBase: String;
begin
  Result := 'BAS_BASE__';
end;

function TCadastroAnnettaBase.fGetCampoChave(
  intIndex: Integer): String;
  Const
    arrChaves: Array[0..2] Of String = ('BAS_BASE__', 'BAS_UNIDAD', 'BAS_DESCRI');
begin
  Result := arrChaves[intIndex];
end;

function TCadastroAnnettaBase.fGetCampoCodigo: String;
begin
  Result := '';
end;

function TCadastroAnnettaBase.fGetCampoCodItem: String;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroAnnettaBase.fGetCampoCusto: String;
begin
  Result := 'BAS_PRECUS';
end;

function TCadastroAnnettaBase.fGetCampoDescricao: String;
begin
  Result := 'BAS_DESCRI';
end;

function TCadastroAnnettaBase.fGetCampoMargem: String;
begin
  Result := 'BAS_MARGEM';
end;

function TCadastroAnnettaBase.fGetCampoUnidade: String;
begin
  Result := 'BAS_UNIDAD';
end;

function TCadastroAnnettaBase.fGetCampoVenda: String;
begin
  Result := 'BAS_PREVEN';
end;

function TCadastroAnnettaBase.fGetCountCamposChave: Integer;
begin
  Result := 3;
end;

function TCadastroAnnettaBase.fGetIdePro: String;
begin
  Result := 'ANN';
end;

function TCadastroAnnettaBase.fGetNomeCampo: String;
begin
  Result := fGetCampoBase;
end;

function TCadastroAnnettaBase.fGetNomeTabela: String;
begin
  Result := 'ANN_CADBAS';
end;

function TCadastroAnnettaBase.fGetNomeTinta: String;
begin
  Result := 'Annetta';
end;


end.
