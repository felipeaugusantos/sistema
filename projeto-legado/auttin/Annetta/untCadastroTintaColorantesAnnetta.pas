unit untCadastroTintaColorantesAnnetta;

interface

uses
  untCadastroTintaColorantes,
  SysUtils, Uni;

Type
  TCadastroTintaColorantesAnnetta = class(TCadastroTintaColorantes)
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
  untConsultaCadastroColoranteAnnetta, untFuncoesSimples;

{ TCadastroTintaColorantesAnnetta }

constructor TCadastroTintaColorantesAnnetta.Create;
begin
  Inherited Create(TConsultaCadastroColoranteAnnetta.Create);
end;

function TCadastroTintaColorantesAnnetta.fGetCampoChave(
  intIndex: Integer): String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesAnnetta.fGetCampoCodigo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesAnnetta.fGetCampoCusto: String;
begin
  Result := 'COL_PRECUS';
end;

function TCadastroTintaColorantesAnnetta.fGetCampoDescricao: String;
begin
  Result := 'COL_DESCRI';
end;

function TCadastroTintaColorantesAnnetta.fGetCampoItem: String;
begin
  Result := 'COL_CODITE';
end;

function TCadastroTintaColorantesAnnetta.fGetCampoMargem: String;
begin
  Result := 'COL_MARGEM';
end;

function TCadastroTintaColorantesAnnetta.fGetCampoVenda: String;
begin
  Result := 'COL_PREVEN';
end;

function TCadastroTintaColorantesAnnetta.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroTintaColorantesAnnetta.fGetIdePro: String;
begin
  Result := 'ANN';
end;

function TCadastroTintaColorantesAnnetta.fGetNomeCampo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesAnnetta.fGetNomeTabela: String;
begin
  Result := 'ANN_CADCOL';
end;

function TCadastroTintaColorantesAnnetta.fGetNomeTinta: String;
begin
  Result := 'Annetta';
end;

procedure TCadastroTintaColorantesAnnetta.pAtualizaFatorTintometrico;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' UPDATE CADITE                  ' +
        '   INNER JOIN ANN_CADCOL        ' +
        '     ON ITE_CODITE = COL_CODITE ' +
        ' SET ITE_CNV_ML = 1000          ';
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
