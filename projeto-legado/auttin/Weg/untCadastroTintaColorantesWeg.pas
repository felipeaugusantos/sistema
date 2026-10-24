unit untCadastroTintaColorantesWeg;

interface

uses
  untCadastroTintaColorantesEmbalagem,
  SysUtils;

Type
  TCadastroTintaColorantesWeg = class(TCadastroTintaColorantesEmbalagem)
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
    constructor Create;
    procedure pAtualizaFatorTintometrico; override;

    function fGetCampoEmbalagem(): String; override;
    function fGetLabelEmbalagem(): String; override;
  End;

implementation

uses
  untConsultaCadastroColoranteWeg, untFuncoesSimples;

{ TCadastroTintaColorantesWeg }

constructor TCadastroTintaColorantesWeg.Create;
begin
  Inherited Create(TConsultaCadastroColoranteWeg.Create);
end;

function TCadastroTintaColorantesWeg.fGetCampoChave(
  intIndex: Integer): String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesWeg.fGetCampoCodigo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesWeg.fGetCampoCusto: String;
begin
  Result := 'COL_PRELIT';
end;

function TCadastroTintaColorantesWeg.fGetCampoDescricao: String;
begin
  Result := 'COL_DESCRI';
end;

function TCadastroTintaColorantesWeg.fGetCampoEmbalagem: String;
begin
  Result := 'COL_EMBALA';
end;

function TCadastroTintaColorantesWeg.fGetCampoItem: String;
begin
  Result := 'COL_CODITE';
end;

function TCadastroTintaColorantesWeg.fGetCampoMargem: String;
begin
  Result := 'COL_MARGEM';
end;

function TCadastroTintaColorantesWeg.fGetCampoVenda: String;
begin
  Result := 'COL_PREVEN';
end;

function TCadastroTintaColorantesWeg.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroTintaColorantesWeg.fGetIdePro: String;
begin
  Result := 'WEG';
end;

function TCadastroTintaColorantesWeg.fGetLabelEmbalagem: String;
begin
  Result := 'Embalagem';
end;

function TCadastroTintaColorantesWeg.fGetNomeCampo: String;
begin
  Result := fGetCampoCodigo;
end;

function TCadastroTintaColorantesWeg.fGetNomeTabela: String;
begin
  Result := 'WEG_CADCOL';
end;

function TCadastroTintaColorantesWeg.fGetNomeTinta: String;
begin
  Result := 'Weg';
end;

procedure TCadastroTintaColorantesWeg.pAtualizaFatorTintometrico;
begin
  fExecutaSQL(
    ' UPDATE                         ' +
    '   CADITE                       ' +
    '   INNER JOIN WEG_CADCOL        ' +
    '     ON ITE_CODITE = COL_CODITE ' +
    ' SET ITE_CNV_ML = COL_EMBALA    ');
end;

end.
