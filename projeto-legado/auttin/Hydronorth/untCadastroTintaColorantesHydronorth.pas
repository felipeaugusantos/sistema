unit untCadastroTintaColorantesHydronorth;

interface

uses
  untCadastroTintaColorantesEmbalagem,
  SysUtils, Uni;

Type
  TCadastroTintaColorantesHydronorth = class(TCadastroTintaColorantesEmbalagem)
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

uses untConsultaCadastroColoranteHydronorth, untFuncoesSimples;

{ TCadastroTintaColorantesVelutex }

constructor TCadastroTintaColorantesHydronorth.Create;
begin
  inherited Create(TConsultaCadastroColoranteHydronorth.Create);
end;

function TCadastroTintaColorantesHydronorth.fGetCampoChave(intIndex: Integer): String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesHydronorth.fGetCampoCodigo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesHydronorth.fGetCampoCusto: String;
begin
  Result := 'COL_PRECUS';
end;

function TCadastroTintaColorantesHydronorth.fGetCampoDescricao: String;
begin
  Result := '';
end;

function TCadastroTintaColorantesHydronorth.fGetCampoEmbalagem: String;
begin
  Result := 'COL_EMBALA';
end;

function TCadastroTintaColorantesHydronorth.fGetCampoItem: String;
begin
  Result := 'COL_CODITE';
end;

function TCadastroTintaColorantesHydronorth.fGetCampoMargem: String;
begin
  Result := 'COL_MARGEM';
end;

function TCadastroTintaColorantesHydronorth.fGetCampoVenda: String;
begin
  Result := 'COL_PREVEN';
end;

function TCadastroTintaColorantesHydronorth.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroTintaColorantesHydronorth.fGetIdePro: String;
begin
  Result := 'HYD';
end;

function TCadastroTintaColorantesHydronorth.fGetLabelEmbalagem: String;
begin
  Result := 'Embalagem';
end;

function TCadastroTintaColorantesHydronorth.fGetNomeCampo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesHydronorth.fGetNomeTabela: String;
begin
  Result := 'HYD_CADCOL';
end;

function TCadastroTintaColorantesHydronorth.fGetNomeTinta: String;
begin
  Result := 'Hydronorth Imobiliária';
end;

procedure TCadastroTintaColorantesHydronorth.pAtualizaFatorTintometrico;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery(nil);
      qryGen.SQL.Text := 'UPDATE CADITE INNER JOIN HYD_CADCOL ON COL_CODITE = ITE_CODITE SET ITE_CNV_ML = 1000';
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
