unit untCadastroTintaColorantesInternational;

interface

uses
  untCadastroTintaColorantesEmbalagem,
  SysUtils, Uni;

Type
  TCadastroTintaColorantesInternational = class(TCadastroTintaColorantesEmbalagem)
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
  end;

implementation

uses untFuncoesSimples, untConsultaCadastroColoranteInternational;

{ TCadastroTintaColorantesVelutex }

constructor TCadastroTintaColorantesInternational.Create;
begin
  inherited Create(TConsultaCadastroColoranteInternational.Create);
end;

function TCadastroTintaColorantesInternational.fGetCampoChave(intIndex: Integer): String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesInternational.fGetCampoCodigo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesInternational.fGetCampoCusto: String;
begin
  Result := 'COL_PRECUS';
end;

function TCadastroTintaColorantesInternational.fGetCampoDescricao: String;
begin
  Result := '';
end;

function TCadastroTintaColorantesInternational.fGetCampoEmbalagem: String;
begin
  Result := 'COL_EMBALA';
end;

function TCadastroTintaColorantesInternational.fGetCampoItem: String;
begin
  Result := 'COL_CODITE';
end;

function TCadastroTintaColorantesInternational.fGetCampoMargem: String;
begin
  Result := 'COL_MARGEM';
end;

function TCadastroTintaColorantesInternational.fGetCampoVenda: String;
begin
  Result := 'COL_PREVEN';
end;

function TCadastroTintaColorantesInternational.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroTintaColorantesInternational.fGetIdePro: String;
begin
  Result := 'INT';
end;

function TCadastroTintaColorantesInternational.fGetLabelEmbalagem: String;
begin
  Result := 'Embalagem';
end;

function TCadastroTintaColorantesInternational.fGetNomeCampo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesInternational.fGetNomeTabela: String;
begin
  Result := 'INT_CADCOL';
end;

function TCadastroTintaColorantesInternational.fGetNomeTinta: String;
begin
  Result := 'International';
end;

procedure TCadastroTintaColorantesInternational.pAtualizaFatorTintometrico;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery(nil);
      qryGen.SQL.Text := 'UPDATE CADITE INNER JOIN INT_CADCOL ON COL_CODITE = ITE_CODITE SET ITE_CNV_ML = COL_EMBALA';
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
