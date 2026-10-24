unit untCadastroTintaColorantesAnjoSintetica;

interface

uses
  untCadastroTintaColorantesEmbalagem,
  SysUtils;

Type
  TCadastroTintaColorantesAnjoSintetica = class(TCadastroTintaColorantesEmbalagem)
  public
    function fGetIdePro: String; override;
    function fGetCampoChave(intIndex: Integer): String; override;
    function fGetCampoCodigo: String; override;
    function fGetCampoCusto: String; override;
    function fGetCampoDescricao: String; override;
    function fGetNomeTabela: String; override;
    function fGetCampoItem: String; override;
    function fGetNomeTinta: String; override;
    function fGetCampoMargem: String; override;
    function fGetCampoVenda: String; override;
    function fGetCountCamposChave: Integer; override;
    function fGetNomeCampo: String; override;
    function fGetCampoEmbalagem(): String; override;
    function fGetLabelEmbalagem(): String; override;
    procedure pAtualizaFatorTintometrico; override;
    constructor Create;
  End;

implementation

uses
  untConsultaCadastroColoranteAnjoSintetica, untFuncoesSimples;

{ TCadastroTintaColorantesAnjoSintetica }

constructor TCadastroTintaColorantesAnjoSintetica.Create;
begin
  Inherited Create(TConsultaCadastroColoranteAnjoSintetica.Create);
end;

function TCadastroTintaColorantesAnjoSintetica.fGetCampoChave(
  intIndex: Integer): String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesAnjoSintetica.fGetCampoCodigo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesAnjoSintetica.fGetCampoCusto: String;
begin
  Result := 'COL_PRELIT';
end;

function TCadastroTintaColorantesAnjoSintetica.fGetCampoDescricao: String;
begin
  Result := 'COL_DESCRI';
end;

function TCadastroTintaColorantesAnjoSintetica.fGetCampoEmbalagem: String;
begin
  Result := 'COL_EMBALA';
end;

function TCadastroTintaColorantesAnjoSintetica.fGetCampoItem: String;
begin
  Result := 'COL_CODITE';
end;

function TCadastroTintaColorantesAnjoSintetica.fGetCampoMargem: String;
begin
  Result := 'COL_MARGEM';
end;

function TCadastroTintaColorantesAnjoSintetica.fGetCampoVenda: String;
begin
  Result := 'COL_PREVEN';
end;

function TCadastroTintaColorantesAnjoSintetica.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroTintaColorantesAnjoSintetica.fGetIdePro: String;
begin
  Result := 'AJA';
end;

function TCadastroTintaColorantesAnjoSintetica.fGetLabelEmbalagem: String;
begin
  Result := 'Embalagem';
end;

function TCadastroTintaColorantesAnjoSintetica.fGetNomeCampo: String;
begin
  Result := fGetCampoCodigo;
end;

function TCadastroTintaColorantesAnjoSintetica.fGetNomeTabela: String;
begin
  Result := 'AJA_CADCOL';
end;

function TCadastroTintaColorantesAnjoSintetica.fGetNomeTinta: String;
begin
  Result := 'Anjo Sintética';
end;

procedure TCadastroTintaColorantesAnjoSintetica.pAtualizaFatorTintometrico;
begin
  fExecutaSQL(
    ' UPDATE                         ' +
    '   CADITE                       ' +
    '   INNER JOIN AJA_CADCOL        ' +
    '     ON ITE_CODITE = COL_CODITE ' +
    ' SET ITE_CNV_ML = COL_EMBALA    ');
end;

end.
