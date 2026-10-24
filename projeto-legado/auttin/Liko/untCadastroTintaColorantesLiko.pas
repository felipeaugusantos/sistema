unit untCadastroTintaColorantesLiko;

interface

uses
  untCadastroTintaColorantes,
   SysUtils, Uni;

Type
  TCadastroTintaColorantesLiko = class(TCadastroTintaColorantes)
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
  untConsultaCadastroColoranteLiko, untFuncoesSimples;

{ TCadastroTintaColorantesLiko }

constructor TCadastroTintaColorantesLiko.Create;
begin
  Inherited Create(TConsultaCadastroColoranteLiko.Create);
end;

function TCadastroTintaColorantesLiko.fGetCampoChave(
  intIndex: Integer): String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesLiko.fGetCampoCodigo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesLiko.fGetCampoCusto: String;
begin
  Result := 'COL_PRECUS';
end;

function TCadastroTintaColorantesLiko.fGetCampoDescricao: String;
begin
  Result := 'COL_DESCRI';
end;

function TCadastroTintaColorantesLiko.fGetCampoItem: String;
begin
  Result := 'COL_CODITE';
end;

function TCadastroTintaColorantesLiko.fGetCampoMargem: String;
begin
  Result := 'COL_MARGEM';
end;

function TCadastroTintaColorantesLiko.fGetCampoVenda: String;
begin
  Result := 'COL_PREVEN';
end;

function TCadastroTintaColorantesLiko.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroTintaColorantesLiko.fGetIdePro: String;
begin
  Result := 'LIK';
end;

function TCadastroTintaColorantesLiko.fGetNomeCampo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesLiko.fGetNomeTabela: String;
begin
  Result := 'LIK_CADCOL';
end;

function TCadastroTintaColorantesLiko.fGetNomeTinta: String;
begin
  Result := 'Liko';
end;

procedure TCadastroTintaColorantesLiko.pAtualizaFatorTintometrico;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' UPDATE CADITE                  ' +
        '   INNER JOIN LIK_CADCOL        ' +
        '     ON ITE_CODITE = COL_CODITE ' +
        ' SET ITE_CNV_ML = 3600          ';
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
