unit untCadastroAnjoBase;

interface

uses
  untCadastroTintaBase, untIConsulta,
  untICadastroTintaBaseAnjo;

Type
  TCadastroAnjoBase = class(TCadastroTintaBase, ICadastroTintaBaseAnjo)
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

uses untConsultaCadastroBaseAnjo;

{ TCadastroAnjoBase }

constructor TCadastroAnjoBase.Create;
begin
  Inherited Create(TConsultaCadastroBaseAnjo.Create);
end;

constructor TCadastroAnjoBase.Create(consulta: IConsulta);
begin
  Inherited Create(consulta);
end;

function TCadastroAnjoBase.fGetCampoBase: String;
begin
  Result := 'BAS_BASE__';
end;

function TCadastroAnjoBase.fGetCampoChave(intIndex: Integer): String;
  Const
    arrChaves: Array[0..3] of String = ('BAS_BASE__', 'BAS_PROKEY', 'BAS_SUBKEY', 'BAS_UNIDAD');
begin
  Result := arrChaves[intIndex];
end;

function TCadastroAnjoBase.fGetCampoCodigo: String;
begin
  Result := '';
end;

function TCadastroAnjoBase.fGetCampoCodItem: String;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroAnjoBase.fGetCampoCusto: String;
begin
  Result := 'BAS_PRECUS';
end;

function TCadastroAnjoBase.fGetCampoDescricao: String;
begin
  Result := 'BAS_DESCRI';
end;

function TCadastroAnjoBase.fGetCampoMargem: String;
begin
  Result := 'BAS_MARGEM';
end;

function TCadastroAnjoBase.fGetCampoProdKey: String;
begin
  Result := 'BAS_PROKEY';
end;

function TCadastroAnjoBase.fGetCampoSubKey: String;
begin
  Result := 'BAS_SUBKEY';
end;

function TCadastroAnjoBase.fGetCampoUnidade: String;
begin
  Result := 'BAS_UNIDAD';
end;

function TCadastroAnjoBase.fGetCampoVenda: String;
begin
  Result := 'BAS_PREVEN';
end;

function TCadastroAnjoBase.fGetCountCamposChave: Integer;
begin
  Result := 4;
end;

function TCadastroAnjoBase.fGetIdePro: String;
begin
  Result := 'ANJ';
end;

function TCadastroAnjoBase.fGetLabelProdKey: String;
begin
  Result := 'Prod. Key';
end;

function TCadastroAnjoBase.fGetLabelSubKey: String;
begin
  Result := 'Sub. Key';
end;

function TCadastroAnjoBase.fGetNomeCampo: String;
begin
  Result := fGetCampoBase;
end;

function TCadastroAnjoBase.fGetNomeTabela: String;
begin
  Result := 'ANJ_CADBAS';
end;

function TCadastroAnjoBase.fGetNomeTinta: String;
begin
  Result := 'Anjo';
end;


end.
