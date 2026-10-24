unit untDominioSistemasFuncoesMultiPlataforma;

interface

uses Data.DB, Uni,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
    Shared.Core
  {$ELSE}
    untDominioSistemasFuncoes
  {$ENDIF};

function fMultiCriaQuery: TUniQuery;
function fMultiCampoTabela(strCampo : String;
                           strNomTab: String;
                           arrCampoChave: Array Of String;
                           arrValorChave: Array Of Variant;
                           blnSempreLerBanco: Boolean = True;
                           strOrderBy: String = '';
                           Conexao: TUniConnection = Nil;
                           blnUsarMax: Boolean = False): Variant;
function fMultiVS_strCodEmp: String;
function fMultiCfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = ''): Variant;
procedure pMultiValidaProCod(strNomeTabela: String);
function fMultiRetAutoIncrem(strNomeTabela, strCodEmp: String; intIntervalo: Integer = -1): String;

implementation

function fMultiCriaQuery: TUniQuery;
begin
  Result := {$IFDEF LINUX} fCriaQuery() {$ELSE} VS_FuncoesExternas.fICriaQuery() {$ENDIF} ;
end ;

function fMultiCampoTabela(strCampo : String;
                           strNomTab: String;
                           arrCampoChave: Array Of String;
                           arrValorChave: Array Of Variant;
                           blnSempreLerBanco: Boolean = True;
                           strOrderBy: String = '';
                           Conexao: TUniConnection = Nil;
                           blnUsarMax: Boolean = False): Variant;
begin
  Result := {$IFDEF LINUX}
              fCampoTabela(strCampo, strNomTab, arrCampoChave, arrValorChave, blnSempreLerBanco, strOrderBy, blnUsarMax)
            {$ELSE}
              VS_FuncoesExternas.fICampoTabela(strCampo, strNomTab, arrCampoChave, arrValorChave, blnSempreLerBanco, strOrderBy, Conexao, blnUsarMax)
            {$ENDIF} ;
end ;

function fMultiVS_strCodEmp: String;
begin
  Result := {$IFDEF LINUX}
              VS_strCodEmp
            {$ELSE}
              VS_FuncoesExternas.fIGetEmpresaLogada
            {$ENDIF} ;
end ;

function fMultiCfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = ''): Variant;
begin
  Result := {$IFDEF LINUX}
              fCfgSis(strCamCfg, varTipVar, strCodEmp)
            {$ELSE}
              VS_FuncoesExternas.fICfgSis(strCamCfg, varTipVar, strCodEmp)
            {$ENDIF} ;
end ;

procedure pMultiValidaProCod(strNomeTabela: String);
begin
  {$IFDEF LINUX}
    pMultiValidaProCod(strNomeTabela)
  {$ELSE}
    VS_FuncoesExternas.pIValidaProCod(strNomeTabela)
  {$ENDIF} ;
end ;

function fMultiRetAutoIncrem(strNomeTabela, strCodEmp: String; intIntervalo: Integer = -1): String;
begin
  Result := {$IFDEF LINUX}
              fRetAutoIncrem(strNomeTabela, strCodEmp, intIntervalo)
            {$ELSE}
              VS_FuncoesExternas.fIRetAutoIncrem(strNomeTabela, strCodEmp, intIntervalo)
            {$ENDIF} ;
end ;

end.
