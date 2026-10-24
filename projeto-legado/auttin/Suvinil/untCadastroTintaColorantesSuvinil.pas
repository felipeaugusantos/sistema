unit untCadastroTintaColorantesSuvinil;

interface

uses
  untCadastroTintaColorantes,
  SysUtils, Uni;

Type
  TCadastroTintaColorantesSuvinil = class(TCadastroTintaColorantes)
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
  untConsultaCadastroColoranteSuvinil, untFuncoesSimples;

{ TCadastroTintaColorantesSuvinil }

constructor TCadastroTintaColorantesSuvinil.Create;
begin
  Inherited Create(TConsultaCadastroColoranteSuvinil.Create);
end;

function TCadastroTintaColorantesSuvinil.fGetCampoChave(
  intIndex: Integer): String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesSuvinil.fGetCampoCodigo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesSuvinil.fGetCampoCusto: String;
begin
  Result := 'COL_PRECUS';
end;

function TCadastroTintaColorantesSuvinil.fGetCampoDescricao: String;
begin
  Result := '';
end;

function TCadastroTintaColorantesSuvinil.fGetCampoItem: String;
begin
  Result := 'COL_CODITE';
end;

function TCadastroTintaColorantesSuvinil.fGetCampoMargem: String;
begin
  Result := 'COL_MARGEM';
end;

function TCadastroTintaColorantesSuvinil.fGetCampoVenda: String;
begin
  Result := 'COL_PREVEN';
end;

function TCadastroTintaColorantesSuvinil.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroTintaColorantesSuvinil.fGetIdePro: String;
begin
  Result := 'SUV';
end;

function TCadastroTintaColorantesSuvinil.fGetNomeCampo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesSuvinil.fGetNomeTabela: String;
begin
  Result := 'SUV_CADCOL';
end;

function TCadastroTintaColorantesSuvinil.fGetNomeTinta: String;
begin
  Result := 'Suvinil';
end;


procedure TCadastroTintaColorantesSuvinil.pAtualizaFatorTintometrico;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' UPDATE                         ' +
        '   CADITE                       ' +
        '   INNER JOIN SUV_CADCOL        ' +
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
