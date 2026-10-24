unit untCadastroIquineBase;

interface

uses
  untCadastroTintaBase, untICadastroTintaBaseIquine;

Type
  TCadastroIquineBase = class(TCadastroTintaBase, ICadastroTintaBaseIquine)
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
    function fGetCampoProduto: String;
  End;


implementation

uses untConsultaCadastroBaseIquine;

{ TCadastroIquineBase }

constructor TCadastroIquineBase.Create;
begin
  Inherited Create(TConsultaCadastroBaseIquine.Create);
end;

function TCadastroIquineBase.fGetCampoBase: String;
begin
  Result := 'BAS_BASE__';
end;

function TCadastroIquineBase.fGetCampoChave(
  intIndex: Integer): String;
  Const
    arrChaves: Array[0..2] Of String = ('BAS_BASE__', 'BAS_UNIDAD', 'BAS_DESCRI');
begin
  Result := arrChaves[intIndex];
end;

function TCadastroIquineBase.fGetCampoCodigo: String;
begin
  Result := '';
end;

function TCadastroIquineBase.fGetCampoCodItem: String;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroIquineBase.fGetCampoCusto: String;
begin
  Result := 'BAS_PRECUS';
end;

function TCadastroIquineBase.fGetCampoDescricao: String;
begin
  Result := 'BAS_DESCRI';
end;

function TCadastroIquineBase.fGetCampoMargem: String;
begin
  Result := 'BAS_MARGEM';
end;

function TCadastroIquineBase.fGetCampoProduto: String;
begin
  Result := 'BAS_PRODUT';
end;

function TCadastroIquineBase.fGetCampoUnidade: String;
begin
  Result := 'BAS_UNIDAD';
end;

function TCadastroIquineBase.fGetCampoVenda: String;
begin
  Result := 'BAS_PREVEN';
end;

function TCadastroIquineBase.fGetCountCamposChave: Integer;
begin
  Result := 3;
end;

function TCadastroIquineBase.fGetIdePro: String;
begin
  Result := 'IQU';
end;

function TCadastroIquineBase.fGetNomeCampo: String;
begin
  Result := fGetCampoBase;
end;

function TCadastroIquineBase.fGetNomeTabela: String;
begin
  Result := 'IQU_CADBAS';
end;

function TCadastroIquineBase.fGetNomeTinta: String;
begin
  Result := 'Iquine';
end;


end.
