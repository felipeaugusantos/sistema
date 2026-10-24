unit untCadastroTintaColorantesIquine;

interface

uses
  untCadastroTintaColorantesEmbalagem,
  SysUtils, Uni;

Type
  TCadastroTintaColorantesIquine = class(TCadastroTintaColorantesEmbalagem)
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
    function fGetCampoEmbalagem():String; override;
    function fGetLabelEmbalagem():String; override;

  End;

implementation

uses
     untConsultaCadastroColoranteIquine, untFuncoesSimples;

{ TCadastroTintaColorantesIquine }

constructor TCadastroTintaColorantesIquine.Create;
begin
  Inherited Create(TConsultaCadastroColoranteIquine.Create);
end;

function TCadastroTintaColorantesIquine.fGetCampoChave(
  intIndex: Integer): String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesIquine.fGetCampoCodigo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesIquine.fGetCampoCusto: String;
begin
  Result := 'COL_PRECUS';
end;

function TCadastroTintaColorantesIquine.fGetCampoDescricao: String;
begin
  Result := '';
end;

function TCadastroTintaColorantesIquine.fGetCampoEmbalagem: String;
begin
  Result := 'COL_EMBALA';
end;


function TCadastroTintaColorantesIquine.fGetCampoItem: String;
begin
  Result := 'COL_CODITE';
end;

function TCadastroTintaColorantesIquine.fGetCampoMargem: String;
begin
  Result := 'COL_MARGEM';
end;

function TCadastroTintaColorantesIquine.fGetCampoVenda: String;
begin
  Result := 'COL_PREVEN';
end;

function TCadastroTintaColorantesIquine.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroTintaColorantesIquine.fGetIdePro: String;
begin
  Result := 'IQU';
end;

function TCadastroTintaColorantesIquine.fGetLabelEmbalagem: String;
begin
  Result := 'Embalagem';
end;


function TCadastroTintaColorantesIquine.fGetNomeCampo: String;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroTintaColorantesIquine.fGetNomeTabela: String;
begin
  Result := 'IQU_CADCOL';
end;

function TCadastroTintaColorantesIquine.fGetNomeTinta: String;
begin
  Result := 'Iquine';
end;

procedure TCadastroTintaColorantesIquine.pAtualizaFatorTintometrico;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' UPDATE CADITE                  ' +
        '   INNER JOIN IQU_CADCOL     ' +
        '     ON ITE_CODITE = COL_CODITE ' +
        ' SET ITE_CNV_ML = COL_EMBALA    ';
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
