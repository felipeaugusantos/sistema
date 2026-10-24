unit untCadastroTintaColorantesSayerLack;

interface

uses
  untCadastroTintaColorantesEmbalagem,
  SysUtils, Uni;

Type
  TCadastroTintaColorantesSayerLack = class(TCadastroTintaColorantesEmbalagem)
  public
    function fGetIdePro: String; override;
    function fGetCampoChave(intIndex: Integer): String; override;
    function fGetCampoCodigo: String; override;
    function fGetCampoCusto: String; override;
    function fGetCampoDescricao: String; override;
    function fGetNomeTabela: String; override;
    function fGetCampoItem: String; override;
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

uses untFuncoesSimples, untConsultaCadastroColoranteSayerLack;

{ TCadastroTintaColorantesSayerLack }

constructor TCadastroTintaColorantesSayerLack.Create;
begin
  inherited Create(TConsultaCadastroColoranteSayerLack.Create);
end;

function TCadastroTintaColorantesSayerLack.fGetCampoChave(intIndex: Integer): String;
begin
  Result := 'COL_CODCOL';                                                                
end;

function TCadastroTintaColorantesSayerLack.fGetCampoCodigo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesSayerLack.fGetCampoCusto: String;
begin
  Result := 'COL_PRECUS';
end;

function TCadastroTintaColorantesSayerLack.fGetCampoDescricao: String;
begin
  Result := 'COL_DESCRI';
end;

function TCadastroTintaColorantesSayerLack.fGetCampoEmbalagem: String;
begin
  Result := 'COL_EMBALA';
end;

function TCadastroTintaColorantesSayerLack.fGetCampoItem: String;
begin
  Result := 'COL_CODITE';
end;

function TCadastroTintaColorantesSayerLack.fGetCampoMargem: String;
begin
  Result := 'COL_MARGEM';
end;

function TCadastroTintaColorantesSayerLack.fGetCampoVenda: String;
begin
  Result := 'COL_PREVEN';
end;

function TCadastroTintaColorantesSayerLack.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroTintaColorantesSayerLack.fGetIdePro: String;
begin
  Result := 'SAY';
end;

function TCadastroTintaColorantesSayerLack.fGetLabelEmbalagem: String;
begin
  Result := 'Embalagem';
end;

function TCadastroTintaColorantesSayerLack.fGetNomeCampo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesSayerLack.fGetNomeTabela: String;
begin
  Result := 'SAY_CADCOL';
end;


procedure TCadastroTintaColorantesSayerLack.pAtualizaFatorTintometrico;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery(nil);
      qryGen.SQL.Text := 'UPDATE CADITE INNER JOIN SAY_CADCOL ON COL_CODITE = ITE_CODITE SET ITE_CNV_ML = IFNULL(COL_EMBALA,1000)';
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
