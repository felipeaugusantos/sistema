unit untCadastroLikoBase;

interface

uses
  untCadastroTintaBase;

Type
  TCadastroLikoBase = class(TCadastroTintaBase)
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

uses untConsultaCadastroBaseLiko;

{ TCadastroLikoBase }

constructor TCadastroLikoBase.Create;
begin
  Inherited Create(TConsultaCadastroBaseLiko.Create);
end;

function TCadastroLikoBase.fGetCampoBase: String;
begin
  Result := 'BAS_BASE__';
end;

function TCadastroLikoBase.fGetCampoChave(
  intIndex: Integer): String;
  Const
    arrChaves: Array[0..2] Of String = ('BAS_BASE__', 'BAS_UNIDAD', 'BAS_DESCRI');
begin
  Result := arrChaves[intIndex];
end;

function TCadastroLikoBase.fGetCampoCodigo: String;
begin
  Result := '';
end;

function TCadastroLikoBase.fGetCampoCodItem: String;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroLikoBase.fGetCampoCusto: String;
begin
  Result := 'BAS_PRECUS';
end;

function TCadastroLikoBase.fGetCampoDescricao: String;
begin
  Result := 'BAS_DESCRI';
end;

function TCadastroLikoBase.fGetCampoMargem: String;
begin
  Result := 'BAS_MARGEM';
end;

function TCadastroLikoBase.fGetCampoUnidade: String;
begin
  Result := 'BAS_UNIDAD';
end;

function TCadastroLikoBase.fGetCampoVenda: String;
begin
  Result := 'BAS_PREVEN';
end;

function TCadastroLikoBase.fGetCountCamposChave: Integer;
begin
  Result := 3;
end;

function TCadastroLikoBase.fGetIdePro: String;
begin
  Result := 'LIK';
end;

function TCadastroLikoBase.fGetNomeCampo: String;
begin
  Result := fGetCampoBase;
end;

function TCadastroLikoBase.fGetNomeTabela: String;
begin
  Result := 'LIK_CADBAS';
end;

function TCadastroLikoBase.fGetNomeTinta: String;
begin
  Result := 'Liko';
end;


end.
