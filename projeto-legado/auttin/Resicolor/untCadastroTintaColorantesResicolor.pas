unit untCadastroTintaColorantesResicolor;

interface

uses
  untCadastroTintaColorantes,
  SysUtils, Uni;

Type
  TCadastroTintaColorantesResicolor = class(TCadastroTintaColorantes)
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

  uses untConsultaCadastroColoranteResicolor, untFuncoesSimples;

{ TCadastroTintaColorantesResicolor }

constructor TCadastroTintaColorantesResicolor.Create;
begin
  Inherited Create(TConsultaCadastroColoranteResicolor.Create);
end;

function TCadastroTintaColorantesResicolor.fGetCampoChave(
  intIndex: Integer): String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesResicolor.fGetCampoCodigo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesResicolor.fGetCampoCusto: String;
begin
  Result := 'COL_PRELIT';
end;

function TCadastroTintaColorantesResicolor.fGetCampoDescricao: String;
begin
  Result := 'COL_DESCRI';
end;

function TCadastroTintaColorantesResicolor.fGetCampoItem: String;
begin
  Result := 'COL_CODITE';
end;

function TCadastroTintaColorantesResicolor.fGetCampoMargem: String;
begin
  Result := 'COL_MARGEM';
end;

function TCadastroTintaColorantesResicolor.fGetCampoVenda: String;
begin
  Result := 'COL_PREVEN';
end;

function TCadastroTintaColorantesResicolor.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroTintaColorantesResicolor.fGetIdePro: String;
begin
  Result := 'RSI';
end;

function TCadastroTintaColorantesResicolor.fGetNomeCampo: String;
begin
  Result := fGetCampoCodigo;
end;

function TCadastroTintaColorantesResicolor.fGetNomeTabela: String;
begin
  Result := 'RSI_CADCOL';
end;

function TCadastroTintaColorantesResicolor.fGetNomeTinta: String;
begin
  Result := 'Resicolor';
end;

procedure TCadastroTintaColorantesResicolor.pAtualizaFatorTintometrico;
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
        '   INNER JOIN RSI_CADCOL        ' +
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
