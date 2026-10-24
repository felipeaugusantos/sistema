unit untTypesSistema;

interface

uses System.Classes, Data.DB, Uni,
     System.Types, System.SysUtils, System.strUtils;

type
  TConsultas = record
    strCodigo: string;
    strDescri: string;
  End;

  TConsultasArray = array of TConsultas;
  TStringArrayArray = Array of Array of String;
  TTipoConsultaSimples = (conSimples, conParaBaixas, conTransfCx);
  TTipoConsultaEmpresa = (conEmpSimples, conEmpCompleta);
  TfncRetNome = function (strCodigo: String): String;
  TfncRetNomeConst = function (Const strCodigo: String): String;
  TBooleanFunctionWithBooleanParam = function(blnCheck : Boolean = False) : Boolean;
  TProcReconectarModulo = reference to procedure(strErro : String);
  TDataModuleClass = Class Of TDataModule;
  TStringArray = Array Of String;

var
  VS_TrimMemorySize: String;

implementation

initialization
  VS_TrimMemorySize := '';

end.