unit untCadastroTintaColorantesRennerIndustrial;

interface

uses
  untCadastroTintaColorantesEmbalagem, untConsultaCadastroColoranteRennerIndustrial,
  untIConsulta, SysUtils, Uni;

Type
  TCadastroTintaColorantesRennerIndustrial = class(TCadastroTintaColorantesEmbalagem)
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
    function fGetCampoEmbalagem(): String; override;
    function fGetLabelEmbalagem(): String; override;
    procedure pAtualizaFatorTintometrico; override;
    constructor Create;
  End;

implementation

uses
  untFuncoesSimples;

{ TCadastroTintaColorantesRennerIndustrial }

constructor TCadastroTintaColorantesRennerIndustrial.Create;
begin
  Inherited Create(TConsultaCadastroColoranteRennerIndustrial.Create);
end;

function TCadastroTintaColorantesRennerIndustrial.fGetCampoChave(
  intIndex: Integer): String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesRennerIndustrial.fGetCampoCodigo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesRennerIndustrial.fGetCampoCusto: String;
begin
  Result := 'COL_PRECUS';
end;

function TCadastroTintaColorantesRennerIndustrial.fGetCampoDescricao: String;
begin
  Result := 'COL_DESCRI';
end;

function TCadastroTintaColorantesRennerIndustrial.fGetCampoEmbalagem: String;
begin
  Result := 'COL_EMBALA';
end;

function TCadastroTintaColorantesRennerIndustrial.fGetCampoItem: String;
begin
  Result := 'COL_CODITE';
end;

function TCadastroTintaColorantesRennerIndustrial.fGetCampoMargem: String;
begin
  Result := 'COL_MARGEM';
end;

function TCadastroTintaColorantesRennerIndustrial.fGetCampoVenda: String;
begin
  Result := 'COL_PREVEN';
end;

function TCadastroTintaColorantesRennerIndustrial.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroTintaColorantesRennerIndustrial.fGetIdePro: String;
begin
  Result := 'REN';
end;

function TCadastroTintaColorantesRennerIndustrial.fGetLabelEmbalagem: String;
begin
  Result := 'Embalagem';
end;

function TCadastroTintaColorantesRennerIndustrial.fGetNomeCampo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesRennerIndustrial.fGetNomeTabela: String;
begin
  Result := 'REN_CADCOL';
end;

function TCadastroTintaColorantesRennerIndustrial.fGetNomeTinta: String;
begin
  Result := 'Renner Industrial';
end;

procedure TCadastroTintaColorantesRennerIndustrial.pAtualizaFatorTintometrico;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' UPDATE CADITE                  ' +
        '   INNER JOIN REN_CADCOL        ' +
        '     ON ITE_CODITE = COL_CODITE ' +
        ' SET ITE_CNV_ML = IFNULL(COL_EMBALA,1000) ';
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
