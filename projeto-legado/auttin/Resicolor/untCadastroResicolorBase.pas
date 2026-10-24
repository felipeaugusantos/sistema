unit untCadastroResicolorBase;

interface
uses
  untCadastroTintaBase, untIConsulta,
  untICadastroTintaBaseResicolor;

Type
  TCadastroResicolorBase = class(TCadastroTintaBase, ICadastroTintaBaseResicolor)
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

uses untConsultaCadastroBaseResicolor;

{ TCadastroResicolorBase }

constructor TCadastroResicolorBase.Create;
begin
  Inherited Create(TConsultaCadastroBaseResicolor.Create);
end;

constructor TCadastroResicolorBase.Create(consulta: IConsulta);
begin
  Inherited Create(consulta);
end;

function TCadastroResicolorBase.fGetCampoBase: String;
begin
  Result := 'BAS_BASE__';
end;

function TCadastroResicolorBase.fGetCampoChave(intIndex: Integer): String;
  Const
    arrChaves: Array[0..3] of String = ('BAS_BASE__', 'BAS_PROKEY', 'BAS_SUBKEY', 'BAS_UNIDAD');
begin
  Result := arrChaves[intIndex];
end;

function TCadastroResicolorBase.fGetCampoCodigo: String;
begin
  Result := '';
end;

function TCadastroResicolorBase.fGetCampoCodItem: String;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroResicolorBase.fGetCampoCusto: String;
begin
  Result := 'BAS_PRECUS';
end;

function TCadastroResicolorBase.fGetCampoDescricao: String;
begin
  Result := 'BAS_DESCRI';
end;

function TCadastroResicolorBase.fGetCampoMargem: String;
begin
  Result := 'BAS_MARGEM';
end;

function TCadastroResicolorBase.fGetCampoProdKey: String;
begin
  Result := 'BAS_PROKEY';
end;

function TCadastroResicolorBase.fGetCampoSubKey: String;
begin
  Result := 'BAS_SUBKEY';
end;

function TCadastroResicolorBase.fGetCampoUnidade: String;
begin
  Result := 'BAS_UNIDAD';
end;

function TCadastroResicolorBase.fGetCampoVenda: String;
begin
  Result := 'BAS_PREVEN';
end;

function TCadastroResicolorBase.fGetCountCamposChave: Integer;
begin
  Result := 4;
end;

function TCadastroResicolorBase.fGetIdePro: String;
begin
  Result := 'RSI';
end;

function TCadastroResicolorBase.fGetLabelProdKey: String;
begin
  Result := 'Prod. Key';
end;

function TCadastroResicolorBase.fGetLabelSubKey: String;
begin
  Result := 'Sub. Key';
end;

function TCadastroResicolorBase.fGetNomeCampo: String;
begin
  Result := fGetCampoBase;
end;

function TCadastroResicolorBase.fGetNomeTabela: String;
begin
  Result := 'RSI_CADBAS';
end;

function TCadastroResicolorBase.fGetNomeTinta: String;
begin
  Result := 'Resicolor';
end;

end.
