unit untCadastroTintaColorantesCalamar;

interface

uses
  untCadastroTintaColorantesEmbalagem,
  SysUtils, Uni;

Type
  TCadastroTintaColorantesCalamar = class(TCadastroTintaColorantesEmbalagem)
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

uses untFuncoesSimples, untConsultaCadastroColoranteCalamar;

{ TCadastroTintaColorantesVelutex }

constructor TCadastroTintaColorantesCalamar.Create;
begin
  inherited Create(TConsultaCadastroColoranteCalamar.Create);
end;

function TCadastroTintaColorantesCalamar.fGetCampoChave(intIndex: Integer): String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesCalamar.fGetCampoCodigo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesCalamar.fGetCampoCusto: String;
begin
  Result := 'COL_PRECUS';
end;

function TCadastroTintaColorantesCalamar.fGetCampoDescricao: String;
begin
  Result := 'COL_DESCRI';
end;

function TCadastroTintaColorantesCalamar.fGetCampoEmbalagem: String;
begin
  Result := 'COL_EMBALA';
end;

function TCadastroTintaColorantesCalamar.fGetCampoItem: String;
begin
  Result := 'COL_CODITE';
end;

function TCadastroTintaColorantesCalamar.fGetCampoMargem: String;
begin
  Result := 'COL_MARGEM';
end;

function TCadastroTintaColorantesCalamar.fGetCampoVenda: String;
begin
  Result := 'COL_PREVEN';
end;

function TCadastroTintaColorantesCalamar.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroTintaColorantesCalamar.fGetIdePro: String;
begin
  Result := 'CAL';
end;

function TCadastroTintaColorantesCalamar.fGetLabelEmbalagem: String;
begin
  Result := 'Embalagem';
end;

function TCadastroTintaColorantesCalamar.fGetNomeCampo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesCalamar.fGetNomeTabela: String;
begin
  Result := 'CAL_CADCOL';
end;

function TCadastroTintaColorantesCalamar.fGetNomeTinta: String;
begin
  Result := 'Calamar';
end;

procedure TCadastroTintaColorantesCalamar.pAtualizaFatorTintometrico;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery(nil);
      qryGen.SQL.Text := 'UPDATE CADITE INNER JOIN CAL_CADCOL ON COL_CODITE = ITE_CODITE SET ITE_CNV_ML = COL_EMBALA';
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
