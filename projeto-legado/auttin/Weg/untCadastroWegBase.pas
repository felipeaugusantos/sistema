unit untCadastroWegBase;

interface

uses
  untCadastroTintaBase, untIConsulta,
  untICadastroTintaBaseWeg;

Type
  TCadastroWegBase = class(TCadastroTintaBase, ICadastroTintaBaseWeg)
  public
    constructor Create; overload; 
    constructor Create(consulta: IConsulta); overload; virtual;
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
    function fGetCampoProdKey: String;
    function fGetCampoSubKey: String;
    function fGetLabelProdKey: String;
    function fGetLabelSubKey: String;
  End;


implementation

uses untConsultaCadastroBaseWeg;

{ TCadastroWegBase }

constructor TCadastroWegBase.Create;
begin
  Inherited Create(TConsultaCadastroBaseWeg.Create);
end;

constructor TCadastroWegBase.Create(consulta: IConsulta);
begin
  Inherited Create(consulta);
end;

function TCadastroWegBase.fGetCampoBase: String;
begin
  Result := 'BAS_BASE__';
end;

function TCadastroWegBase.fGetCampoChave(intIndex: Integer): String;
  Const
    arrChaves: Array[0..3] of String = ('BAS_BASE__', 'BAS_PROKEY', 'BAS_SUBKEY', 'BAS_UNIDAD');
begin
  Result := arrChaves[intIndex];
end;

function TCadastroWegBase.fGetCampoCodigo: String;
begin
  Result := '';
end;

function TCadastroWegBase.fGetCampoCodItem: String;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroWegBase.fGetCampoCusto: String;
begin
  Result := 'BAS_PRECUS';
end;

function TCadastroWegBase.fGetCampoDescricao: String;
begin
  Result := 'BAS_DESCRI';
end;

function TCadastroWegBase.fGetCampoMargem: String;
begin
  Result := 'BAS_MARGEM';
end;

function TCadastroWegBase.fGetCampoProdKey: String;
begin
  Result := 'BAS_PROKEY';
end;

function TCadastroWegBase.fGetCampoSubKey: String;
begin
  Result := 'BAS_SUBKEY';
end;

function TCadastroWegBase.fGetCampoUnidade: String;
begin
  Result := 'BAS_UNIDAD';
end;

function TCadastroWegBase.fGetCampoVenda: String;
begin
  Result := 'BAS_PREVEN';
end;

function TCadastroWegBase.fGetCountCamposChave: Integer;
begin
  Result := 4;
end;

function TCadastroWegBase.fGetIdePro: String;
begin
  Result := 'WEG';
end;

function TCadastroWegBase.fGetLabelProdKey: String;
begin
  Result := 'Prod. Key';
end;

function TCadastroWegBase.fGetLabelSubKey: String;
begin
  Result := 'Sub. Key';
end;

function TCadastroWegBase.fGetNomeCampo: String;
begin
  Result := fGetCampoBase;
end;

function TCadastroWegBase.fGetNomeTabela: String;
begin
  Result := 'WEG_CADBAS';
end;

function TCadastroWegBase.fGetNomeTinta: String;
begin
  Result := 'Weg';
end;


end.
