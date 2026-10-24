unit untIFormulaAutomotiva;

interface

uses
  untFuncEspecificas;

type
  IFormulaAutomotiva = interface
    ['{FADAA274-F8B9-4905-9D4F-D77FBF961F56}']
    function GetNomeTabelaBase(): string;
    function GetTextoCalculoValor: string;
    function GetVolumeOri(): Double;
    function GetCalculoBasePreCusCon(objBase: TBaseAutomotiva): Double;
    function GetCalculoBasePreCu2Con(objBase: TBaseAutomotiva): Double;
    function GetCalculoBasePreVenCon(objBase: TBaseAutomotiva): Double;

    function GetCalculoBasePreCusDil(objBase: TBaseAutomotiva): Double;
    function GetCalculoBasePreCu2Dil(objBase: TBaseAutomotiva): Double;
    function GetCalculoBasePreVenDil(objBase: TBaseAutomotiva): Double;
    function GetTipBas(const strCodBas: string): string;

    function GetCalculoBaseOutValCon(objBase: TBaseAutomotiva): Double;
    function GetCalculoBaseIcmSaiCon(objBase: TBaseAutomotiva): Double;
    function GetCalculoBaseImpFedCon(objBase: TBaseAutomotiva): Double;
    function GetCalculoBaseDesOpeCon(objBase: TBaseAutomotiva): Double;
    function GetCalculoBasePreMedCon(objBase: TBaseAutomotiva): Double;

    function GetCalculoBaseOutValDil(objBase: TBaseAutomotiva): Double;
    function GetCalculoBaseIcmSaiDil(objBase: TBaseAutomotiva): Double;
    function GetCalculoBaseImpFedDil(objBase: TBaseAutomotiva): Double;
    function GetCalculoBaseDesOpeDil(objBase: TBaseAutomotiva): Double;
    function GetCalculoBasePreMedDil(objBase: TBaseAutomotiva): Double;

    function GetCalculoBaseComLiqCon(objBase: TBaseAutomotiva): Double;
    function GetCalculoBasePreUltCon(objBase: TBaseAutomotiva): Double;
    function GetCalculoBaseImpUltCon(objBase: TBaseAutomotiva): Double;

    function GetCalculoBaseComLiqDil(objBase: TBaseAutomotiva): Double;
    function GetCalculoBasePreUltDil(objBase: TBaseAutomotiva): Double;
    function GetCalculoBaseImpUltDil(objBase: TBaseAutomotiva): Double;
  end;

implementation

end.
