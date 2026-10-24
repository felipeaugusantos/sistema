unit untCadastroAnjoSinteticaBase;

interface

uses
  untCadastroTintaBase, untIConsulta,
  untICadastroTintaBaseAnjoSintetica;

Type
  TCadastroAnjoSinteticaBase = class(TCadastroTintaBase, ICadastroTintaBaseAnjoSintetica)
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

uses untConsultaCadastroBaseAnjoSintetica;

{ TCadastroAnjoSinteticaBase }

constructor TCadastroAnjoSinteticaBase.Create;
begin
  Inherited Create(TConsultaCadastroBaseAnjoSintetica.Create);
end;

constructor TCadastroAnjoSinteticaBase.Create(consulta: IConsulta);
begin
  Inherited Create(consulta);
end;

function TCadastroAnjoSinteticaBase.fGetCampoBase: String;
begin
  Result := 'BAS_BASE__';
end;

function TCadastroAnjoSinteticaBase.fGetCampoChave(intIndex: Integer): String;
  Const
    arrChaves: Array[0..3] of String = ('BAS_BASE__', 'BAS_PROKEY', 'BAS_SUBKEY', 'BAS_UNIDAD');
begin
  Result := arrChaves[intIndex];
end;

function TCadastroAnjoSinteticaBase.fGetCampoCodigo: String;
begin
  Result := '';
end;

function TCadastroAnjoSinteticaBase.fGetCampoCodItem: String;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroAnjoSinteticaBase.fGetCampoCusto: String;
begin
  Result := 'BAS_PRECUS';
end;

function TCadastroAnjoSinteticaBase.fGetCampoDescricao: String;
begin
  Result := 'BAS_DESCRI';
end;

function TCadastroAnjoSinteticaBase.fGetCampoMargem: String;
begin
  Result := 'BAS_MARGEM';
end;

function TCadastroAnjoSinteticaBase.fGetCampoProdKey: String;
begin
  Result := 'BAS_PROKEY';
end;

function TCadastroAnjoSinteticaBase.fGetCampoSubKey: String;
begin
  Result := 'BAS_SUBKEY';
end;

function TCadastroAnjoSinteticaBase.fGetCampoUnidade: String;
begin
  Result := 'BAS_UNIDAD';
end;

function TCadastroAnjoSinteticaBase.fGetCampoVenda: String;
begin
  Result := 'BAS_PREVEN';
end;

function TCadastroAnjoSinteticaBase.fGetCountCamposChave: Integer;
begin
  Result := 4;
end;

function TCadastroAnjoSinteticaBase.fGetIdePro: String;
begin
  Result := 'AJA';
end;

function TCadastroAnjoSinteticaBase.fGetLabelProdKey: String;
begin
  Result := 'Prod. Key';
end;

function TCadastroAnjoSinteticaBase.fGetLabelSubKey: String;
begin
  Result := 'Sub. Key';
end;

function TCadastroAnjoSinteticaBase.fGetNomeCampo: String;
begin
  Result := fGetCampoBase;
end;

function TCadastroAnjoSinteticaBase.fGetNomeTabela: String;
begin
  Result := 'AJA_CADBAS';
end;

function TCadastroAnjoSinteticaBase.fGetNomeTinta: String;
begin
  Result := 'Anjo Sintética';
end;


end.
