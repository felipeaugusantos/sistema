unit untCadastroTintaColorantesAnjo;

interface

uses
  untCadastroTintaColorantesEmbalagem,
  SysUtils;

Type
  TCadastroTintaColorantesAnjo = class(TCadastroTintaColorantesEmbalagem)
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
   untConsultaCadastroColoranteAnjo, untFuncoesSimples;

{ TCadastroTintaColorantesAnjo }

constructor TCadastroTintaColorantesAnjo.Create;
begin
  Inherited Create(TConsultaCadastroColoranteAnjo.Create);
end;

function TCadastroTintaColorantesAnjo.fGetCampoChave(
  intIndex: Integer): String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesAnjo.fGetCampoCodigo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesAnjo.fGetCampoCusto: String;
begin
  Result := 'COL_PRELIT';
end;

function TCadastroTintaColorantesAnjo.fGetCampoDescricao: String;
begin
  Result := 'COL_DESCRI';
end;

function TCadastroTintaColorantesAnjo.fGetCampoEmbalagem: String;
begin
  Result := 'COL_EMBALA';
end;

function TCadastroTintaColorantesAnjo.fGetCampoItem: String;
begin
  Result := 'COL_CODITE';
end;

function TCadastroTintaColorantesAnjo.fGetCampoMargem: String;
begin
  Result := 'COL_MARGEM';
end;

function TCadastroTintaColorantesAnjo.fGetCampoVenda: String;
begin
  Result := 'COL_PREVEN';
end;

function TCadastroTintaColorantesAnjo.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroTintaColorantesAnjo.fGetIdePro: String;
begin
  Result := 'ANJ';
end;

function TCadastroTintaColorantesAnjo.fGetLabelEmbalagem: String;
begin
  Result := 'Embalagem';
end;

function TCadastroTintaColorantesAnjo.fGetNomeCampo: String;
begin
  Result := fGetCampoCodigo;
end;

function TCadastroTintaColorantesAnjo.fGetNomeTabela: String;
begin
  Result := 'ANJ_CADCOL';
end;

function TCadastroTintaColorantesAnjo.fGetNomeTinta: String;
begin
  Result := 'Anjo';
end;

procedure TCadastroTintaColorantesAnjo.pAtualizaFatorTintometrico;
begin
  fExecutaSQL(
    ' UPDATE                         ' +
    '   CADITE                       ' +
    '   INNER JOIN ANJ_CADCOL        ' +
    '     ON ITE_CODITE = COL_CODITE ' +
    ' SET ITE_CNV_ML = COL_EMBALA    ');
end;

end.
