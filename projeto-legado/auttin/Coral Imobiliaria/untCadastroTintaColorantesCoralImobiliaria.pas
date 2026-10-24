unit untCadastroTintaColorantesCoralImobiliaria;

interface

uses
  untCadastroTintaColorantes,
  SysUtils, Uni;

Type
  TCadastroTintaColorantesCoralImobiliaria = class(TCadastroTintaColorantes)
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
  untConsultaCadastroColoranteCoralImobiliaria, untFuncoesSimples;

{ TCadastroTintaColorantesCoralImobiliaria }

constructor TCadastroTintaColorantesCoralImobiliaria.Create;
begin
  Inherited Create(TConsultaCadastroColoranteCoralImobiliaria.Create);
end;

function TCadastroTintaColorantesCoralImobiliaria.fGetCampoChave(
  intIndex: Integer): String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesCoralImobiliaria.fGetCampoCodigo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesCoralImobiliaria.fGetCampoCusto: String;
begin
  Result := 'COL_PRECUS';
end;

function TCadastroTintaColorantesCoralImobiliaria.fGetCampoDescricao: String;
begin
  Result := '';
end;

function TCadastroTintaColorantesCoralImobiliaria.fGetCampoItem: String;
begin
  Result := 'COL_CODITE';
end;

function TCadastroTintaColorantesCoralImobiliaria.fGetCampoMargem: String;
begin
  Result := 'COL_MARGEM';
end;

function TCadastroTintaColorantesCoralImobiliaria.fGetCampoVenda: String;
begin
  Result := 'COL_PREVEN';
end;

function TCadastroTintaColorantesCoralImobiliaria.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroTintaColorantesCoralImobiliaria.fGetIdePro: String;
begin
  Result := 'CIM';
end;

function TCadastroTintaColorantesCoralImobiliaria.fGetNomeCampo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesCoralImobiliaria.fGetNomeTabela: String;
begin
  Result := 'CORIMO_CADCOL';
end;

function TCadastroTintaColorantesCoralImobiliaria.fGetNomeTinta: String;
begin
  Result := 'Coral Imobiliária';
end;

procedure TCadastroTintaColorantesCoralImobiliaria.pAtualizaFatorTintometrico;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' UPDATE CADITE                  ' +
        '   INNER JOIN CORIMO_CADCOL     ' +
        '     ON ITE_CODITE = COL_CODITE ' +
        ' SET ITE_CNV_ML = 946           ';
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
