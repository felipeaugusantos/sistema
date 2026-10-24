unit untCadastroTintaBaseAutomotivaStandox;

interface

uses
  untCadastroTintaBaseAutomotiva, untICadastroTintaBaseAutomotivaStandox,
  Variants;

Type
  TCadastroTintaBaseAutomotivaStandox = class(TCadastroTintaBaseAutomotiva, ICadastroTintaBaseAutomotivaStandox)
  public
    function fGetCampoCodItem: String; override;
    function fGetCampoCodigo: String; override;
    function fGetCampoCusto: String; override;
    function fGetCampoDescricao: String; override;
    function fGetLabelDescricao: String; override;
    function fGetCampoEmbalagem: String; override;
    function fGetCampoMargem: String; override;
    function fGetCampoPesoEspecifico: String; override;
    function fGetCampoVenda: String; override;
    function fGetCampoLinha: String;
    function fGetCampoPesoGrama: String;
    function fGetCampoTipo: String;
    function fGetCampoEmpresa: String;
    function fGetLabelLinha: String;
    function fGetLabelPesoGrama: String;
    function fGetLabelTipo: String;
    function fGetLabelEmpresa: String;
    function fGetIdePro: String; override;
    function fGetNomeCampo: String; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;

    constructor Create;
    function fGetCampoChave(intIndex: Integer): String; override;
    function fGetCountCamposChave: Integer; override;
    function fGetSqlUpdateCnvMl(): string; override;
  End;
implementation
uses
    untConsultaCadastroBaseStandox;

{ TCadastroTintaBaseAutomotivaStandox }

constructor TCadastroTintaBaseAutomotivaStandox.Create;
begin
  Inherited Create(TConsultaCadastroBaseStandox.Create);
end;

function TCadastroTintaBaseAutomotivaStandox.fGetCampoChave(
  intIndex: Integer): String;
var
  arrChaves: Array Of String;
begin
  SetLength(arrChaves,1);
  arrChaves[0] := 'BAS_CODBAS';

  Result := arrChaves[intIndex];
end;

function TCadastroTintaBaseAutomotivaStandox.fGetCampoCodigo: String;
begin
  Result := 'BAS_CODBAS';
end;

function TCadastroTintaBaseAutomotivaStandox.fGetCampoCodItem: String;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroTintaBaseAutomotivaStandox.fGetCampoCusto: String;
begin
  Result := 'BAS_PRECUS';
end;

function TCadastroTintaBaseAutomotivaStandox.fGetCampoDescricao: String;
begin
  Result := 'BAS_DESBAS';
end;

function TCadastroTintaBaseAutomotivaStandox.fGetCampoEmbalagem: String;
begin
  Result := 'BAS_EMBALA';
end;

function TCadastroTintaBaseAutomotivaStandox.fGetCampoEmpresa: String;
begin
  Result := 'BAS_CODEMP';
end;

function TCadastroTintaBaseAutomotivaStandox.fGetCampoLinha: String;
begin
  Result := 'BAS_LINHA_';
end;

function TCadastroTintaBaseAutomotivaStandox.fGetCampoMargem: String;
begin
  Result := 'BAS_MARGEM';
end;

function TCadastroTintaBaseAutomotivaStandox.fGetCampoPesoEspecifico: String;
begin
  Result := 'BAS_PESESP';
end;

function TCadastroTintaBaseAutomotivaStandox.fGetCampoPesoGrama: String;
begin
  Result := 'BAS_PESGRA';
end;

function TCadastroTintaBaseAutomotivaStandox.fGetCampoTipo: String;
begin
  Result := 'BAS_TIPO__';
end;

function TCadastroTintaBaseAutomotivaStandox.fGetCampoVenda: String;
begin
  Result := 'BAS_PREVEN';
end;

function TCadastroTintaBaseAutomotivaStandox.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroTintaBaseAutomotivaStandox.fGetIdePro: String;
begin
  Result := 'DOX';
end;

function TCadastroTintaBaseAutomotivaStandox.fGetLabelDescricao: String;
begin
  Result := 'Descrição';
end;

function TCadastroTintaBaseAutomotivaStandox.fGetLabelEmpresa: String;
begin
  Result := 'Empresa';
end;

function TCadastroTintaBaseAutomotivaStandox.fGetLabelLinha: String;
begin
  Result := 'Linha';
end;

function TCadastroTintaBaseAutomotivaStandox.fGetLabelPesoGrama: String;
begin
  Result := 'Peso em Gramas';
end;

function TCadastroTintaBaseAutomotivaStandox.fGetLabelTipo: String;
begin
  Result := 'Tipo';
end;

function TCadastroTintaBaseAutomotivaStandox.fGetNomeCampo: String;
begin
  Result := fGetCampoCodigo;
end;

function TCadastroTintaBaseAutomotivaStandox.fGetNomeTabela: String;
begin
  Result := 'DOX_CADBAS';
end;

function TCadastroTintaBaseAutomotivaStandox.fGetNomeTinta: String;
begin
  Result := 'Standox';
end;

function TCadastroTintaBaseAutomotivaStandox.fGetSqlUpdateCnvMl: string;
begin
  Result :=
    ' UPDATE                                                           ' +
    '   CADITE                                                         ' +
    '   INNER JOIN DOX_CADBAS                                          ' +
    '     ON ITE_CODITE = BAS_CODITE                                   ' +
    ' SET ITE_CNV_ML = (IFNULL(BAS_EMBALA, 1) * IFNULL(BAS_PESESP, 1)) ';
end;

end.
