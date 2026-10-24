unit untCadastroLukscolorBase;

interface
uses
  untCadastroTintaBase, untIConsulta,
  untICadastroTintaBaseLukscolor;

Type
  TCadastroLukscolorBase = class(TCadastroTintaBase, ICadastroTintaBaseLukscolor)
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

uses untConsultaCadastroBaseLukscolor;

{ TCadastroLukscolorBase }

constructor TCadastroLukscolorBase.Create;
begin
  Inherited Create(TConsultaCadastroBaseLukscolor.Create);
end;

constructor TCadastroLukscolorBase.Create(consulta: IConsulta);
begin
  Inherited Create(consulta);
end;

function TCadastroLukscolorBase.fGetCampoBase: String;
begin
  Result := 'BAS_BASE__';
end;

function TCadastroLukscolorBase.fGetCampoChave(intIndex: Integer): String;
  Const
    arrChaves: Array[0..3] of String = ('BAS_BASE__', 'BAS_PROKEY', 'BAS_SUBKEY', 'BAS_UNIDAD');
begin
  Result := arrChaves[intIndex];
end;

function TCadastroLukscolorBase.fGetCampoCodigo: String;
begin
  Result := '';
end;

function TCadastroLukscolorBase.fGetCampoCodItem: String;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroLukscolorBase.fGetCampoCusto: String;
begin
  Result := 'BAS_PRECUS';
end;

function TCadastroLukscolorBase.fGetCampoDescricao: String;
begin
  Result := 'BAS_DESCRI';
end;

function TCadastroLukscolorBase.fGetCampoMargem: String;
begin
  Result := 'BAS_MARGEM';
end;

function TCadastroLukscolorBase.fGetCampoProdKey: String;
begin
  Result := 'BAS_PROKEY';
end;

function TCadastroLukscolorBase.fGetCampoSubKey: String;
begin
  Result := 'BAS_SUBKEY';
end;

function TCadastroLukscolorBase.fGetCampoUnidade: String;
begin
  Result := 'BAS_UNIDAD';
end;

function TCadastroLukscolorBase.fGetCampoVenda: String;
begin
  Result := 'BAS_PREVEN';
end;

function TCadastroLukscolorBase.fGetCountCamposChave: Integer;
begin
  Result := 4;
end;

function TCadastroLukscolorBase.fGetIdePro: String;
begin
  Result := 'LKS';
end;

function TCadastroLukscolorBase.fGetLabelProdKey: String;
begin
  Result := 'Prod. Key';
end;

function TCadastroLukscolorBase.fGetLabelSubKey: String;
begin
  Result := 'Sub. Key';
end;

function TCadastroLukscolorBase.fGetNomeCampo: String;
begin
  Result := fGetCampoBase;
end;

function TCadastroLukscolorBase.fGetNomeTabela: String;
begin
  Result := 'LKD_CADBAS';
end;

function TCadastroLukscolorBase.fGetNomeTinta: String;
begin
  Result := 'Lukscolor';
end;

end.
