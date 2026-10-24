unit untCadastroTintaColorantesAdvanceCorob;

interface

uses
  untICadastroTintaColorantesAdvance,
  SysUtils, untCadastroTintaColorantes;

Type
  TCadastroTintaColorantesAdvance = class(TCadastroTintaColorantes, ICadastroTintaColorantesAdvance)
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
    function fGetCampoEmbalagem: string;
    function fGetLabelEmbalagem: string;
    procedure pAtualizaFatorTintometrico; override;
  End;

implementation

uses
    untConsultaCadastroColoranteAdvanceCorob, untFuncoesSimples;

{ TCadastroTintaColorantesAdvance }

constructor TCadastroTintaColorantesAdvance.Create;
begin
  Inherited Create(TConsultaCadastroColoranteAdvance.Create);
end;

function TCadastroTintaColorantesAdvance.fGetCampoChave(
  intIndex: Integer): String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesAdvance.fGetCampoCodigo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesAdvance.fGetCampoCusto: String;
begin
  Result := 'COL_PRELIT';
end;

function TCadastroTintaColorantesAdvance.fGetCampoDescricao: String;
begin
  Result := 'COL_DESCRI';
end;

function TCadastroTintaColorantesAdvance.fGetCampoEmbalagem: string;
begin
  Result := 'COL_PESCOL';
end;

function TCadastroTintaColorantesAdvance.fGetCampoItem: String;
begin
  Result := 'COL_CODITE';
end;

function TCadastroTintaColorantesAdvance.fGetCampoMargem: String;
begin
  Result := 'COL_MARGEM';
end;

function TCadastroTintaColorantesAdvance.fGetCampoVenda: String;
begin
  Result := 'COL_PREVEN';
end;

function TCadastroTintaColorantesAdvance.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroTintaColorantesAdvance.fGetIdePro: String;
begin
  Result := 'ADV';
end;

function TCadastroTintaColorantesAdvance.fGetLabelEmbalagem: string;
begin
  Result := 'Embalagem';
end;

function TCadastroTintaColorantesAdvance.fGetNomeCampo: String;
begin
  Result := fGetCampoCodigo;
end;

function TCadastroTintaColorantesAdvance.fGetNomeTabela: String;
begin
  Result := 'ADVCOR_CADCOL';
end;

function TCadastroTintaColorantesAdvance.fGetNomeTinta: String;
begin
  Result := 'Advance';
end;

procedure TCadastroTintaColorantesAdvance.pAtualizaFatorTintometrico;
begin
  fExecutaSQL(
    ' UPDATE                                                              ' +
    '   CADITE                                                            ' +
    '   INNER JOIN ADVCOR_CADCOL                                          ' +
    '     ON ITE_CODITE = COL_CODITE                                      ' +
    ' SET ITE_CNV_ML = IFNULL(COL_PESCOL, 3600) ');
end;

end.
