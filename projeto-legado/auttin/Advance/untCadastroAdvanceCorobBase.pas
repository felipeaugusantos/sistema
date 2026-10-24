unit untCadastroAdvanceCorobBase;

interface
uses
  untCadastroTintaBase, untIConsulta,
  untICadastroTintaBaseAdvanceCorob;

Type
  TCadastroAdvanceBase = class(TCadastroTintaBase, ICadastroTintaBaseAdvanceCorob)
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

uses untConsultaCadastroBaseAdvanceCorob;

{ TCadastroAdvanceBase }

constructor TCadastroAdvanceBase.Create;
begin
  Inherited Create(TConsultaCadastroBaseAdvance.Create);
end;

constructor TCadastroAdvanceBase.Create(consulta: IConsulta);
begin
  Inherited Create(consulta);
end;

function TCadastroAdvanceBase.fGetCampoBase: String;
begin
  Result := 'BAS_BASE__';
end;

function TCadastroAdvanceBase.fGetCampoChave(intIndex: Integer): String;
  Const
    arrChaves: Array[0..3] of String = ('BAS_BASE__', 'BAS_PROKEY', 'BAS_SUBKEY', 'BAS_UNIDAD');
begin
  Result := arrChaves[intIndex];
end;

function TCadastroAdvanceBase.fGetCampoCodigo: String;
begin
  Result := '';
end;

function TCadastroAdvanceBase.fGetCampoCodItem: String;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroAdvanceBase.fGetCampoCusto: String;
begin
  Result := 'BAS_PRECUS';
end;

function TCadastroAdvanceBase.fGetCampoDescricao: String;
begin
  Result := 'BAS_DESCRI';
end;

function TCadastroAdvanceBase.fGetCampoMargem: String;
begin
  Result := 'BAS_MARGEM';
end;

function TCadastroAdvanceBase.fGetCampoProdKey: String;
begin
  Result := 'BAS_PROKEY';
end;

function TCadastroAdvanceBase.fGetCampoSubKey: String;
begin
  Result := 'BAS_SUBKEY';
end;

function TCadastroAdvanceBase.fGetCampoUnidade: String;
begin
  Result := 'BAS_UNIDAD';
end;

function TCadastroAdvanceBase.fGetCampoVenda: String;
begin
  Result := 'BAS_PREVEN';
end;

function TCadastroAdvanceBase.fGetCountCamposChave: Integer;
begin
  Result := 4;
end;

function TCadastroAdvanceBase.fGetIdePro: String;
begin
  Result := 'ADV';
end;

function TCadastroAdvanceBase.fGetLabelProdKey: String;
begin
  Result := 'Prod. Key';
end;

function TCadastroAdvanceBase.fGetLabelSubKey: String;
begin
  Result := 'Sub. Key';
end;

function TCadastroAdvanceBase.fGetNomeCampo: String;
begin
  Result := fGetCampoBase;
end;

function TCadastroAdvanceBase.fGetNomeTabela: String;
begin
  Result := 'ADVCOR_CADBAS';
end;

function TCadastroAdvanceBase.fGetNomeTinta: String;
begin
  Result := 'Advance';
end;

end.
