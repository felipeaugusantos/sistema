unit untCadastroTintaBaseAutomotivaLazzumix;

interface

uses
  untCadastroTintaBaseAutomotiva;

Type
  TCadastroTintaBaseAutomotivaLazzumix = class(TCadastroTintaBaseAutomotiva)
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

uses untConsultaCadastroBaseLazzumix;

{ TCadastroTintaBaseAutomotivaLazzumix }

constructor TCadastroTintaBaseAutomotivaLazzumix.Create;
begin
  Inherited Create(TConsultaCadastroBaseLazzumix.Create);
end;

function TCadastroTintaBaseAutomotivaLazzumix.fGetCampoChave(
  intIndex: Integer): String;
begin
  Result := 'BAS_CODBAS';
end;

function TCadastroTintaBaseAutomotivaLazzumix.fGetCampoCodigo: String;
begin
  Result := 'BAS_CODBAS';
end;

function TCadastroTintaBaseAutomotivaLazzumix.fGetCampoCodItem: String;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroTintaBaseAutomotivaLazzumix.fGetCampoCusto: String;
begin
  Result := 'BAS_PRECUS';
end;

function TCadastroTintaBaseAutomotivaLazzumix.fGetCampoDescricao: String;
begin
  Result  := 'BAS_DESBAS';
end;

function TCadastroTintaBaseAutomotivaLazzumix.fGetCampoEmbalagem: String;
begin
  Result := 'BAS_EMBALA';
end;

function TCadastroTintaBaseAutomotivaLazzumix.fGetCampoMargem: String;
begin
  Result := 'BAS_MARGEM';
end;

function TCadastroTintaBaseAutomotivaLazzumix.fGetCampoPesoEspecifico: String;
begin
  Result := 'BAS_PESESP';
end;

function TCadastroTintaBaseAutomotivaLazzumix.fGetCampoVenda: String;
begin
  Result := 'BAS_PREVEN';
end;

function TCadastroTintaBaseAutomotivaLazzumix.fGetCountCamposChave: Integer;
begin
 Result := 1;
end;

function TCadastroTintaBaseAutomotivaLazzumix.fGetIdePro: String;
begin
  Result := 'LAZ';
end;

function TCadastroTintaBaseAutomotivaLazzumix.fGetNomeCampo: String;
begin
  Result := fGetCampoCodigo;
end;

function TCadastroTintaBaseAutomotivaLazzumix.fGetNomeTabela: String;
begin
  Result := 'LAZ_CADBAS';
end;

function TCadastroTintaBaseAutomotivaLazzumix.fGetNomeTinta: String;
begin
  Result := 'Lazzumix';
end;

function TCadastroTintaBaseAutomotivaLazzumix.fGetSqlUpdateCnvMl: string;
begin
  Result :=
    ' UPDATE                                                         ' +
    '   CADITE                                                       ' +
    '   INNER JOIN LAZ_CADBAS                                        ' +
    '     ON ITE_CODITE = BAS_CODITE                                 ' +
    ' SET ITE_CNV_ML = IFNULL(BAS_PESESP, 1) * IFNULL(BAS_EMBALA, 1) ';
end;

end.
