unit untCadastroTintaColorantesAlessi;

interface

uses
  untCadastroTintaColorantes,
   SysUtils, Uni;

Type
  TCadastroTintaColorantesAlessi = class(TCadastroTintaColorantes)
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

uses untConsultaCadastroColoranteAlessi, untFuncoesSimples;

{ TCadastroTintaColorantesAlessi }

constructor TCadastroTintaColorantesAlessi.Create;
begin
  inherited Create(TConsultaCadastroColoranteAlessi.Create);
end;

function TCadastroTintaColorantesAlessi.fGetCampoChave(intIndex: Integer): String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesAlessi.fGetCampoCodigo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesAlessi.fGetCampoCusto: String;
begin
  Result := 'COL_PRECUS';
end;

function TCadastroTintaColorantesAlessi.fGetCampoDescricao: String;
begin
  Result := '';
end;

function TCadastroTintaColorantesAlessi.fGetCampoItem: String;
begin
  Result := 'COL_CODITE';
end;

function TCadastroTintaColorantesAlessi.fGetCampoMargem: String;
begin
  Result := 'COL_MARGEM';
end;

function TCadastroTintaColorantesAlessi.fGetCampoVenda: String;
begin
  Result := 'COL_PREVEN';
end;

function TCadastroTintaColorantesAlessi.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroTintaColorantesAlessi.fGetIdePro: String;
begin
  Result := 'ALE';
end;

function TCadastroTintaColorantesAlessi.fGetNomeCampo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesAlessi.fGetNomeTabela: String;
begin
  Result := 'ALE_CADCOL';  
end;

function TCadastroTintaColorantesAlessi.fGetNomeTinta: String;
begin
  Result := 'Alessi';
end;

procedure TCadastroTintaColorantesAlessi.pAtualizaFatorTintometrico;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery(nil);
      qryGen.SQL.Text := 'UPDATE CADITE INNER JOIN ALE_CADCOL ON COL_CODITE = ITE_CODITE SET ITE_CNV_ML = 1000';
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
