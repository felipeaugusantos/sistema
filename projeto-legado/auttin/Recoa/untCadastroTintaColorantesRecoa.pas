unit untCadastroTintaColorantesRecoa;

interface

uses
  untCadastroTintaColorantes,
  SysUtils, Uni;

Type
  TCadastroTintaColorantesRecoa = class(TCadastroTintaColorantes)
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
 untConsultaCadastroColoranteRecoa, untFuncoesSimples;

{ TCadastroTintaColorantesRecoa }

constructor TCadastroTintaColorantesRecoa.Create;
begin
  Inherited Create(TConsultaCadastroColoranteRecoa.Create);
end;

function TCadastroTintaColorantesRecoa.fGetCampoChave(
  intIndex: Integer): String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesRecoa.fGetCampoCodigo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesRecoa.fGetCampoCusto: String;
begin
  Result := 'COL_PRECUS';
end;

function TCadastroTintaColorantesRecoa.fGetCampoDescricao: String;
begin
  Result := '';
end;

function TCadastroTintaColorantesRecoa.fGetCampoItem: String;
begin
  Result := 'COL_CODITE';
end;

function TCadastroTintaColorantesRecoa.fGetCampoMargem: String;
begin
  Result := 'COL_MARGEM';
end;

function TCadastroTintaColorantesRecoa.fGetCampoVenda: String;
begin
  Result := 'COL_PREVEN';
end;

function TCadastroTintaColorantesRecoa.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroTintaColorantesRecoa.fGetIdePro: String;
begin
  Result := 'REC';
end;

function TCadastroTintaColorantesRecoa.fGetNomeCampo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesRecoa.fGetNomeTabela: String;
begin
  Result := 'REC_CADCOL';
end;

function TCadastroTintaColorantesRecoa.fGetNomeTinta: String;
begin
  Result := 'Recoa';
end;

procedure TCadastroTintaColorantesRecoa.pAtualizaFatorTintometrico;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' UPDATE CADITE                  ' +
        '   INNER JOIN REC_CADCOL        ' +
        '     ON ITE_CODITE = COL_CODITE ' +
        ' SET ITE_CNV_ML = 810           ';
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
