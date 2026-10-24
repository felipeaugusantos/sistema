unit untCadastroRecoaBase;

interface

uses
  untCadastroTintaBase;

Type
  TCadastroRecoaBase = class(TCadastroTintaBase)
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

uses untConsultaCadastroBaseRecoa;

{ TCadastroRecoaBase }

constructor TCadastroRecoaBase.Create;
begin
  Inherited Create(TConsultaCadastroBaseRecoa.Create);
end;

function TCadastroRecoaBase.fGetCampoBase: String;
begin
  Result := 'BAS_BASE__';
end;

function TCadastroRecoaBase.fGetCampoChave(
  intIndex: Integer): String;
  Const
    arrChaves: Array[0..2] Of String = ('BAS_BASE__', 'BAS_UNIDAD', 'BAS_DESCRI');
begin
  Result := arrChaves[intIndex];
end;

function TCadastroRecoaBase.fGetCampoCodigo: String;
begin
  Result := '';
end;

function TCadastroRecoaBase.fGetCampoCodItem: String;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroRecoaBase.fGetCampoCusto: String;
begin
  Result := 'BAS_PRECUS';
end;

function TCadastroRecoaBase.fGetCampoDescricao: String;
begin
  Result := 'BAS_DESCRI';
end;

function TCadastroRecoaBase.fGetCampoMargem: String;
begin
  Result := 'BAS_MARGEM';
end;

function TCadastroRecoaBase.fGetCampoUnidade: String;
begin
  Result := 'BAS_UNIDAD';
end;

function TCadastroRecoaBase.fGetCampoVenda: String;
begin
  Result := 'BAS_PREVEN';
end;

function TCadastroRecoaBase.fGetCountCamposChave: Integer;
begin
  Result := 3;
end;

function TCadastroRecoaBase.fGetIdePro: String;
begin
  Result := 'REC';
end;

function TCadastroRecoaBase.fGetNomeCampo: String;
begin
  Result := fGetCampoBase;
end;

function TCadastroRecoaBase.fGetNomeTabela: String;
begin
  Result := 'REC_CADBAS';
end;

function TCadastroRecoaBase.fGetNomeTinta: String;
begin
  Result := 'Recoa';
end;


end.
