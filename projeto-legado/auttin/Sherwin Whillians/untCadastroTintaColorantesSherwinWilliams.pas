unit untCadastroTintaColorantesSherwinWilliams;

interface

uses
  untCadastroTintaColorantes,
  SysUtils, Uni;

Type
  TCadastroTintaColorantesSherwinWilliams = class(TCadastroTintaColorantes)
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
  End;

implementation

uses
  untConsultaCadastroColoranteSherwinWilliams, untFuncoesSimples, untFuncTinta;

{ TCadastroTintaColorantesSherwinWilliams }

function TCadastroTintaColorantesSherwinWilliams.fGetCampoChave(
  intIndex: Integer): String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesSherwinWilliams.fGetCampoCodigo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesSherwinWilliams.fGetCampoCusto: String;
begin
  Result := 'COL_PRELIT';
end;

function TCadastroTintaColorantesSherwinWilliams.fGetCampoDescricao: String;
begin
  Result := 'COL_DESCRI';
end;

function TCadastroTintaColorantesSherwinWilliams.fGetCampoItem: String;
begin
  Result := 'COL_CODITE';
end;

function TCadastroTintaColorantesSherwinWilliams.fGetCampoMargem: String;
begin
  Result := 'COL_MARGEM';
end;

function TCadastroTintaColorantesSherwinWilliams.fGetCampoVenda: String;
begin
  Result := 'COL_PREVEN';
end;

function TCadastroTintaColorantesSherwinWilliams.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroTintaColorantesSherwinWilliams.fGetIdePro: String;
begin
  Result := 'LKS';
end;

function TCadastroTintaColorantesSherwinWilliams.fGetNomeCampo: String;
begin
  Result := fGetCampoCodigo;
end;

function TCadastroTintaColorantesSherwinWilliams.fGetNomeTabela: String;
begin
  Result := 'SHE_CADCOL';
end;

function TCadastroTintaColorantesSherwinWilliams.fGetNomeTinta: String;
begin
  Result := 'SherwinWilliams';
end;

procedure TCadastroTintaColorantesSherwinWilliams.pAtualizaFatorTintometrico;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      if fGetConfTinta('SHE').fGetInteger('SHEEMB') = 0 then
      begin
        qryGen.SQL.Text :=
          ' UPDATE                         ' +
          '   CADITE                       ' +
          '   INNER JOIN SHE_CADCOL        ' +
          '     ON COL_CODITE = ITE_CODITE ' +
          ' SET ITE_CNV_ML = 946           ';
      end
      else
      begin
        qryGen.SQL.Text :=
          ' UPDATE                         ' +
          '   CADITE                       ' +
          '   INNER JOIN SHE_CADCOL        ' +
          '     ON COL_CODITE = ITE_CODITE ' +
          ' SET ITE_CNV_ML = 1000          ';
      end;
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

constructor TCadastroTintaColorantesSherwinWilliams.Create;
begin
  Inherited Create(TConsultaCadastroColoranteSherwinWilliams.Create);
end;

end.
