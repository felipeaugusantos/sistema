unit untCadastroTintaBaseAutomotivaBrazilianColor;

interface

uses
  untCadastroTintaBaseAutomotiva;

Type
  TCadastroTintaBaseAutomotivaBrazilianColor = class(TCadastroTintaBaseAutomotiva)
  public
    function fGetCampoCodItem: String; override;
    function fGetCampoCodigo: String; override;
    function fGetCampoCusto: String; override;
    function fGetCampoDescricao: String; override;
    function fGetCampoEmbalagem: String; override;
    function fGetCampoMargem: String; override;
    function fGetCampoPesoEspecifico: String; override;
    function fGetCampoVenda: String; override;
    function fGetCampoChave(intIndex: Integer): String; override;
    function fGetIdePro: String; override;
    function fGetCountCamposChave: Integer; override;
    function fGetNomeCampo: String; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;
    function fGetSqlUpdateCnvMl(): string; override;
    constructor Create();
  End;

implementation

uses untConsultaCadastroBaseBrazilianColor;

{ TCadastroTintaBaseAutomotivaBrazilianColor }

constructor TCadastroTintaBaseAutomotivaBrazilianColor.Create;
begin
  inherited Create(TConsultaCadastroBaseBrazilianColor.Create);
end;

function TCadastroTintaBaseAutomotivaBrazilianColor.fGetCampoChave(intIndex: Integer): String;
begin
  Result := 'BAS_CODBAS';
end;

function TCadastroTintaBaseAutomotivaBrazilianColor.fGetCampoCodigo: String;
begin
  Result := 'BAS_CODBAS';
end;

function TCadastroTintaBaseAutomotivaBrazilianColor.fGetCampoCodItem: String;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroTintaBaseAutomotivaBrazilianColor.fGetCampoCusto: String;
begin
  Result := 'BAS_PRECUS';
end;

function TCadastroTintaBaseAutomotivaBrazilianColor.fGetCampoDescricao: String;
begin
  Result  := 'BAS_DESBAS';
end;

function TCadastroTintaBaseAutomotivaBrazilianColor.fGetCampoEmbalagem: String;
begin
  Result := 'BAS_EMBALA';
end;

function TCadastroTintaBaseAutomotivaBrazilianColor.fGetCampoMargem: String;
begin
  Result := 'BAS_MARGEM';
end;

function TCadastroTintaBaseAutomotivaBrazilianColor.fGetCampoPesoEspecifico: String;
begin
  Result := 'BAS_PESESP';
end;

function TCadastroTintaBaseAutomotivaBrazilianColor.fGetCampoVenda: String;
begin
  Result := 'BAS_PREVEN';
end;

function TCadastroTintaBaseAutomotivaBrazilianColor.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroTintaBaseAutomotivaBrazilianColor.fGetIdePro: String;
begin
  Result := 'BZC';
end;

function TCadastroTintaBaseAutomotivaBrazilianColor.fGetNomeCampo: String;
begin
  Result := fGetCampoCodigo;
end;

function TCadastroTintaBaseAutomotivaBrazilianColor.fGetNomeTabela: String;
begin
  Result := 'BZC_CADBAS';
end;

function TCadastroTintaBaseAutomotivaBrazilianColor.fGetNomeTinta: String;
begin
  Result := 'BrazilianColor Automotiva';
end;

function TCadastroTintaBaseAutomotivaBrazilianColor.fGetSqlUpdateCnvMl: string;
begin
  Result :=
    ' UPDATE                                                         ' +
    '   CADITE                                                       ' +
    '   INNER JOIN BZC_CADBAS                                        ' +
    '     ON ITE_CODITE = BAS_CODITE                                 ' +
    ' SET ITE_CNV_ML = IFNULL(BAS_EMBALA, 1) * IFNULL(BAS_PESESP, 1) ';
end;

end.
