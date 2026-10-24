unit untCadastroTintaColorantesGlobalColor;

interface

uses
  untCadastroTintaColorantes,
  SysUtils, Uni;

Type
  TCadastroTintaColorantesGlobalColor = class(TCadastroTintaColorantes)
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
    procedure pAtualizaFatorTintometrico; override;
    constructor Create;
  End;

implementation

uses
  untConsultaCadastroColoranteGlobalColor,untFuncoesSimples;

{ TCadastroTintaColorantesGlobalColor }

constructor TCadastroTintaColorantesGlobalColor.Create;
begin
  Inherited Create(TConsultaCadastroColoranteGlobalColor.Create);
end;

function TCadastroTintaColorantesGlobalColor.fGetCampoChave(
  intIndex: Integer): String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesGlobalColor.fGetCampoCodigo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesGlobalColor.fGetCampoCusto: String;
begin
  Result := 'COL_PRECUS';
end;

function TCadastroTintaColorantesGlobalColor.fGetCampoDescricao: String;
begin
  Result := 'COL_DESCRI';
end;

function TCadastroTintaColorantesGlobalColor.fGetCampoItem: String;
begin
  Result := 'COL_CODITE';
end;

function TCadastroTintaColorantesGlobalColor.fGetCampoMargem: String;
begin
  Result := 'COL_MARGEM';
end;

function TCadastroTintaColorantesGlobalColor.fGetCampoVenda: String;
begin
  Result := 'COL_PREVEN';
end;

function TCadastroTintaColorantesGlobalColor.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroTintaColorantesGlobalColor.fGetIdePro: String;
begin
  Result := 'GLO';
end;

function TCadastroTintaColorantesGlobalColor.fGetNomeCampo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesGlobalColor.fGetNomeTabela: String;
begin
  Result := 'GLO_CADCOL';
end;

function TCadastroTintaColorantesGlobalColor.fGetNomeTinta: String;
begin
  Result := 'Global Color';
end;

procedure TCadastroTintaColorantesGlobalColor.pAtualizaFatorTintometrico;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' UPDATE CADITE                  ' +
        '   INNER JOIN GLO_CADCOL        ' +
        '     ON ITE_CODITE = COL_CODITE ' +
        ' SET ITE_CNV_ML = 946           ';
      qryGen.ExecSQL;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;                              
end;

end.
