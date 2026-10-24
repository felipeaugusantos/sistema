unit untCadastroCoralImobiliariaBase;

interface

uses
  untCadastroTintaBase, untConsultaCadastroBaseCoralImobiliaria;

Type
  TCadastroCoralImobiliariaBase = class(TCadastroTintaBase)
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

{ TCadastroCoralImobiliariaBase }

constructor TCadastroCoralImobiliariaBase.Create;
begin
  Inherited Create(TConsultaCadastroBaseCoralImobiliaria.Create);
end;

function TCadastroCoralImobiliariaBase.fGetCampoBase: String;
begin
  Result := 'BAS_BASE__';
end;

function TCadastroCoralImobiliariaBase.fGetCampoChave(
  intIndex: Integer): String;
  Const
    arrChaves: Array[0..2] Of String = ('BAS_BASE__', 'BAS_UNIDAD', 'BAS_DESCRI');
begin
  Result := arrChaves[intIndex];
end;

function TCadastroCoralImobiliariaBase.fGetCampoCodigo: String;
begin
  Result := '';
end;

function TCadastroCoralImobiliariaBase.fGetCampoCodItem: String;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroCoralImobiliariaBase.fGetCampoCusto: String;
begin
  Result := 'BAS_PRECUS';
end;

function TCadastroCoralImobiliariaBase.fGetCampoDescricao: String;
begin
  Result := 'BAS_DESCRI';
end;

function TCadastroCoralImobiliariaBase.fGetCampoMargem: String;
begin
  Result := 'BAS_MARGEM';
end;

function TCadastroCoralImobiliariaBase.fGetCampoUnidade: String;
begin
  Result := 'BAS_UNIDAD';
end;

function TCadastroCoralImobiliariaBase.fGetCampoVenda: String;
begin
  Result := 'BAS_PREVEN';
end;

function TCadastroCoralImobiliariaBase.fGetCountCamposChave: Integer;
begin
  Result := 3;
end;

function TCadastroCoralImobiliariaBase.fGetIdePro: String;
begin
  Result := 'CIM';
end;

function TCadastroCoralImobiliariaBase.fGetNomeCampo: String;
begin
  Result := fGetCampoBase;
end;

function TCadastroCoralImobiliariaBase.fGetNomeTabela: String;
begin
  Result := 'CORIMO_CADBAS';
end;

function TCadastroCoralImobiliariaBase.fGetNomeTinta: String;
begin
  Result := 'Coral Imobiliária';
end;


end.
