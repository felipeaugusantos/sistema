unit untCadastroTintaColorantesLukscolor;

interface

uses
  untCadastroTintaColorantes,
  SysUtils, Uni;

Type
  TCadastroTintaColorantesLukscolor = class(TCadastroTintaColorantes)
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
  untConsultaCadastroColoranteLukscolor, untFuncoesSimples;

{ TCadastroTintaColorantesLukscolor }

constructor TCadastroTintaColorantesLukscolor.Create;
begin
  Inherited Create(TConsultaCadastroColoranteLukscolor.Create);
end;

function TCadastroTintaColorantesLukscolor.fGetCampoChave(
  intIndex: Integer): String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesLukscolor.fGetCampoCodigo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesLukscolor.fGetCampoCusto: String;
begin
  Result := 'COL_PRELIT';
end;

function TCadastroTintaColorantesLukscolor.fGetCampoDescricao: String;
begin
  Result := 'COL_DESCRI';
end;

function TCadastroTintaColorantesLukscolor.fGetCampoItem: String;
begin
  Result := 'COL_CODITE';
end;

function TCadastroTintaColorantesLukscolor.fGetCampoMargem: String;
begin
  Result := 'COL_MARGEM';
end;

function TCadastroTintaColorantesLukscolor.fGetCampoVenda: String;
begin
  Result := 'COL_PREVEN';
end;

function TCadastroTintaColorantesLukscolor.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroTintaColorantesLukscolor.fGetIdePro: String;
begin
  Result := 'LKS';
end;

function TCadastroTintaColorantesLukscolor.fGetNomeCampo: String;
begin
  Result := fGetCampoCodigo;
end;

function TCadastroTintaColorantesLukscolor.fGetNomeTabela: String;
begin
  Result := 'LKD_CADCOL';
end;

function TCadastroTintaColorantesLukscolor.fGetNomeTinta: String;
begin
  Result := 'LuksColor';
end;

procedure TCadastroTintaColorantesLukscolor.pAtualizaFatorTintometrico;
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
        '   INNER JOIN LKD_CADCOL        ' +
        '     ON COL_CODITE = ITE_CODITE ' +
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
