unit untCadastroTintaBaseAutomotivaDupont;

interface

uses
  untCadastroTintaBaseAutomotiva,
  Variants,untICadastroTintaBaseAutomotivaDupont;

Type
  TCadastroTintaBaseAutomotivaDupont = class(TCadastroTintaBaseAutomotiva, ICadastroTintaBaseAutomotivaDupont)
  public
    function fGetCampoCodItem: String; override;
    function fGetCampoCodigo: String; override;
    function fGetCampoCusto: String; override;
    function fGetCampoDescricao: String; override;
    function fGetLabelDescricao: String; override;
    function fGetCampoEmbalagem: String; override;
    function fGetCampoMargem: String; override;
    function fGetCampoPesoEspecifico: String; override;
    function fGetCampoVenda: String; override;
    function fGetCampoLinha: String;
    function fGetCampoPesoGrama: String;
    function fGetCampoTipo: String;
    function fGetCampoEmpresa: String;
    function fGetLabelLinha: String;
    function fGetLabelPesoGrama: String;
    function fGetLabelTipo: String;
    function fGetLabelEmpresa: String;
    function fGetIdePro: String; override;
    function fGetNomeCampo: String; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;
    function fGetArrayLinhas: TStringArrayDup;
//    function fGetArrayQualidades: TStringArray;
    function fGetArrayTipos: TStringArrayDup;

    constructor Create;
    function fGetCampoChave(intIndex: Integer): String; override;
    function fGetCountCamposChave: Integer; override;
    function fGetSqlUpdateCnvMl(): string; override;
  End;
implementation

uses untFuncoesSimples, untConsultaCadastroBaseDupont;

{ TCadastroTintaBaseAutomotivaDupont }

constructor TCadastroTintaBaseAutomotivaDupont.Create;
begin
  Inherited Create(TConsultaCadastroBaseDupont.Create);
end;

function TCadastroTintaBaseAutomotivaDupont.fGetArrayLinhas: TStringArrayDup;
begin
  Result := VarArrayOf(['DUXONE', 'IMRON', 'NASON', 'CHROMA']);
end;

function TCadastroTintaBaseAutomotivaDupont.fGetArrayTipos: TStringArrayDup;
begin
  Result := VarArrayOf(['TINTING', 'DILUENTE', 'PRIMER', 'CATALISADOR', 'OUTROS', 'BINDER', 'VERNIZ', 'MASSA', 'KIT'])
end;

function TCadastroTintaBaseAutomotivaDupont.fGetCampoChave(
  intIndex: Integer): String;
var
  arrChaves: Array Of String;
begin
  If fCfgSis('EMPBDU',varBoolean) Then
  Begin
    SetLength(arrChaves,2);
    arrChaves[0] := 'BAS_CODBAS';
    arrChaves[1] := 'BAS_CODEMP'
  End
  Else
  Begin
    SetLength(arrChaves,1);
    arrChaves[0] := 'BAS_CODBAS';
  End;

  Result := arrChaves[intIndex];
end;

function TCadastroTintaBaseAutomotivaDupont.fGetCampoCodigo: String;
begin
  Result := 'BAS_CODBAS';
end;

function TCadastroTintaBaseAutomotivaDupont.fGetCampoCodItem: String;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroTintaBaseAutomotivaDupont.fGetCampoCusto: String;
begin
  Result := 'BAS_PRECUS';
end;

function TCadastroTintaBaseAutomotivaDupont.fGetCampoDescricao: String;
begin
  Result := 'BAS_DESBAS';
end;

function TCadastroTintaBaseAutomotivaDupont.fGetCampoEmbalagem: String;
begin
  Result := 'BAS_EMBALA';
end;

function TCadastroTintaBaseAutomotivaDupont.fGetCampoEmpresa: String;
begin
  Result := 'BAS_CODEMP';
end;

function TCadastroTintaBaseAutomotivaDupont.fGetCampoLinha: String;
begin
  Result := 'BAS_LINHA_';
end;

function TCadastroTintaBaseAutomotivaDupont.fGetCampoMargem: String;
begin
  Result := 'BAS_MARGEM';
end;

function TCadastroTintaBaseAutomotivaDupont.fGetCampoPesoEspecifico: String;
begin
  Result := 'BAS_PESESP';
end;

function TCadastroTintaBaseAutomotivaDupont.fGetCampoPesoGrama: String;
begin
  Result := 'BAS_PESGRA';
end;

function TCadastroTintaBaseAutomotivaDupont.fGetCampoTipo: String;
begin
  Result := 'BAS_TIPO__';
end;

function TCadastroTintaBaseAutomotivaDupont.fGetCampoVenda: String;
begin
  Result := 'BAS_PREVEN';
end;

function TCadastroTintaBaseAutomotivaDupont.fGetCountCamposChave: Integer;
begin
  Result := 1;
  If fCfgSis('EMPBDU',varBoolean) Then
    Result := 2;  
end;

function TCadastroTintaBaseAutomotivaDupont.fGetIdePro: String;
begin
  Result := 'DUP';
end;

function TCadastroTintaBaseAutomotivaDupont.fGetLabelDescricao: String;
begin
  Result := 'Descrição';
end;

function TCadastroTintaBaseAutomotivaDupont.fGetLabelEmpresa: String;
begin
  Result := 'Empresa';
end;

function TCadastroTintaBaseAutomotivaDupont.fGetLabelLinha: String;
begin
  Result := 'Linha';
end;

function TCadastroTintaBaseAutomotivaDupont.fGetLabelPesoGrama: String;
begin
  Result := 'Peso em Gramas';
end;

{function TCadastroTintaBaseAutomotivaDupont.fGetLabelQualidade: String;
begin
  Result := 'Qualidade';
end;}

function TCadastroTintaBaseAutomotivaDupont.fGetLabelTipo: String;
begin
  Result := 'Tipo';
end;

function TCadastroTintaBaseAutomotivaDupont.fGetNomeCampo: String;
begin
  Result := fGetCampoCodigo;
end;

function TCadastroTintaBaseAutomotivaDupont.fGetNomeTabela: String;
begin
  Result := 'DUP_CADBAS';
end;

function TCadastroTintaBaseAutomotivaDupont.fGetNomeTinta: String;
begin
  Result := 'Dupont';
end;

function TCadastroTintaBaseAutomotivaDupont.fGetSqlUpdateCnvMl: string;
begin
  Result :=
    ' UPDATE                                                           ' +
    '   CADITE                                                         ' +
    '   INNER JOIN DUP_CADBAS                                          ' +
    '     ON ITE_CODITE = BAS_CODITE                                   ' +
    ' SET ITE_CNV_ML = (IFNULL(BAS_EMBALA, 1) * IFNULL(BAS_PESESP, 1)) ';
end;

end.
