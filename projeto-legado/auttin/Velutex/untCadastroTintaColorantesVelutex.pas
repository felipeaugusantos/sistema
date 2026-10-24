unit untCadastroTintaColorantesVelutex;

interface

uses
  untCadastroTintaColorantes,
  SysUtils, Uni;

Type
  TCadastroTintaColorantesVelutex = class(TCadastroTintaColorantes)
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
  end;

implementation

uses untFuncoesSimples,untConsultaCadastroColoranteVelutex;

{ TCadastroTintaColorantesVelutex }

constructor TCadastroTintaColorantesVelutex.Create;
begin
  inherited Create(TConsultaCadastroColoranteVelutex.Create);
end;

function TCadastroTintaColorantesVelutex.fGetCampoChave(intIndex: Integer): String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesVelutex.fGetCampoCodigo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesVelutex.fGetCampoCusto: String;
begin
  Result := 'COL_PRECUS';
end;

function TCadastroTintaColorantesVelutex.fGetCampoDescricao: String;
begin
  Result := 'COL_DESCRI';
end;

function TCadastroTintaColorantesVelutex.fGetCampoItem: String;
begin
  Result := 'COL_CODITE';
end;

function TCadastroTintaColorantesVelutex.fGetCampoMargem: String;
begin
  Result := 'COL_MARGEM';
end;

function TCadastroTintaColorantesVelutex.fGetCampoVenda: String;
begin
  Result := 'COL_PREVEN';
end;

function TCadastroTintaColorantesVelutex.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroTintaColorantesVelutex.fGetIdePro: String;
begin
  Result := 'VEL';
end;

function TCadastroTintaColorantesVelutex.fGetNomeCampo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesVelutex.fGetNomeTabela: String;
begin
  Result := 'VEL_CADCOL';
end;

function TCadastroTintaColorantesVelutex.fGetNomeTinta: String;
begin
  Result := 'Velutex';
end;

procedure TCadastroTintaColorantesVelutex.pAtualizaFatorTintometrico;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery(nil);
      qryGen.SQL.Text := 'UPDATE CADITE INNER JOIN VEL_CADCOL ON COL_CODITE = ITE_CODITE SET ITE_CNV_ML = 1000';
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
