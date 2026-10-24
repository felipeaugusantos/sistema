unit untAbstractFormulaAutomotiva;

interface

uses
  untIFormulaAutomotiva, untFuncEspecificas;

type
  TAbstractFormulaAutomotiva = class abstract(TInterfacedObject, IFormulaAutomotiva)
  public
    function GetCalculoBasePreCu2Con(objBase: TBaseAutomotiva): Double; virtual;
    function GetCalculoBasePreCu2Dil(objBase: TBaseAutomotiva): Double; virtual;
    function GetCalculoBasePreCusCon(objBase: TBaseAutomotiva): Double; virtual;
    function GetCalculoBasePreCusDil(objBase: TBaseAutomotiva): Double; virtual;
    function GetCalculoBasePreVenCon(objBase: TBaseAutomotiva): Double; virtual;
    function GetCalculoBasePreVenDil(objBase: TBaseAutomotiva): Double; virtual;
    function GetNomeTabelaBase: string; virtual; abstract;
    function GetTextoCalculoValor: string; virtual;
    function GetVolumeOri: Double; virtual;
    function GetTipBas(const strCodBas: string): string; virtual;
    function GetCalculoBaseDesOpeCon(objBase: TBaseAutomotiva): Double; virtual;
    function GetCalculoBaseDesOpeDil(objBase: TBaseAutomotiva): Double; virtual;
    function GetCalculoBaseIcmSaiCon(objBase: TBaseAutomotiva): Double; virtual;
    function GetCalculoBaseIcmSaiDil(objBase: TBaseAutomotiva): Double; virtual;
    function GetCalculoBaseImpFedCon(objBase: TBaseAutomotiva): Double; virtual;
    function GetCalculoBaseImpFedDil(objBase: TBaseAutomotiva): Double; virtual;
    function GetCalculoBaseOutValCon(objBase: TBaseAutomotiva): Double; virtual;
    function GetCalculoBaseOutValDil(objBase: TBaseAutomotiva): Double; virtual;
    function GetCalculoBasePreMedCon(objBase: TBaseAutomotiva): Double; virtual;
    function GetCalculoBasePreMedDil(objBase: TBaseAutomotiva): Double; virtual;

    function GetCalculoBaseComLiqCon(objBase: TBaseAutomotiva): Double; virtual;
    function GetCalculoBasePreUltCon(objBase: TBaseAutomotiva): Double; virtual;
    function GetCalculoBaseImpUltCon(objBase: TBaseAutomotiva): Double; virtual;

    function GetCalculoBaseComLiqDil(objBase: TBaseAutomotiva): Double; virtual;
    function GetCalculoBasePreUltDil(objBase: TBaseAutomotiva): Double; virtual;
    function GetCalculoBaseImpUltDil(objBase: TBaseAutomotiva): Double; virtual;
  end;


implementation

{ TFormulaAutomotivaBrazilianColor }

function TAbstractFormulaAutomotiva.GetCalculoBaseComLiqCon(
  objBase: TBaseAutomotiva): Double;
begin
  Result := objBase.fltQtdCon * objBase.fltComLiq / (objBase.fltEmbala * objBase.fltPesEsp);
end;

function TAbstractFormulaAutomotiva.GetCalculoBaseComLiqDil(
  objBase: TBaseAutomotiva): Double;
begin
  Result := objBase.fltQtdDil * objBase.fltComLiq / (objBase.fltEmbala * objBase.fltPesEsp);
end;

function TAbstractFormulaAutomotiva.GetCalculoBaseDesOpeCon(objBase: TBaseAutomotiva): Double;
begin
  Result := GetCalculoBasePreVenCon(objBase) * objBase.fltDesOpe / 100;
end;

function TAbstractFormulaAutomotiva.GetCalculoBaseDesOpeDil(objBase: TBaseAutomotiva): Double;
begin
  Result := GetCalculoBasePreVenDil(objBase) * objBase.fltDesOpe / 100;
end;

function TAbstractFormulaAutomotiva.GetCalculoBaseIcmSaiCon(objBase: TBaseAutomotiva): Double;
begin
  Result := GetCalculoBasePreVenCon(objBase) * objBase.fltIcmSai / 100;
end;

function TAbstractFormulaAutomotiva.GetCalculoBaseIcmSaiDil(objBase: TBaseAutomotiva): Double;
begin
  Result := GetCalculoBasePreVenDil(objBase) * objBase.fltIcmSai / 100;
end;

function TAbstractFormulaAutomotiva.GetCalculoBaseImpFedCon(objBase: TBaseAutomotiva): Double;
begin
  Result := GetCalculoBasePreVenCon(objBase) * objBase.fltImpFed / 100;
end;

function TAbstractFormulaAutomotiva.GetCalculoBaseImpFedDil(objBase: TBaseAutomotiva): Double;
begin
  Result := GetCalculoBasePreVenDil(objBase) * objBase.fltImpFed / 100;
end;

function TAbstractFormulaAutomotiva.GetCalculoBaseImpUltCon(
  objBase: TBaseAutomotiva): Double;
begin
  Result := objBase.fltQtdCon * objBase.fltImpUlt / (objBase.fltEmbala * objBase.fltPesEsp);
end;

function TAbstractFormulaAutomotiva.GetCalculoBaseImpUltDil(
  objBase: TBaseAutomotiva): Double;
begin
  Result := objBase.fltQtdDil * objBase.fltImpUlt / (objBase.fltEmbala * objBase.fltPesEsp);
end;

function TAbstractFormulaAutomotiva.GetCalculoBaseOutValCon(objBase: TBaseAutomotiva): Double;
begin
  Result := objBase.fltQtdCon * objBase.fltOutVal / (objBase.fltEmbala * objBase.fltPesEsp);
end;

function TAbstractFormulaAutomotiva.GetCalculoBaseOutValDil(objBase: TBaseAutomotiva): Double;
begin
  Result := objBase.fltQtdDil * objBase.fltOutVal / (objBase.fltEmbala * objBase.fltPesEsp);
end;

function TAbstractFormulaAutomotiva.GetCalculoBasePreCu2Con(objBase: TBaseAutomotiva): Double;
begin
  Result := objBase.fltQtdCon * fCalculaPrecoCusto2(objBase.fltPreVen,
    objBase.fltPreCus, objBase.fltOutVal, objBase.fltIcmSai, objBase.fltImpFed, objBase.fltDesOpe 
  ) / (objBase.fltEmbala * objBase.fltPesEsp);
end;

function TAbstractFormulaAutomotiva.GetCalculoBasePreCu2Dil(objBase: TBaseAutomotiva): Double;
begin
  Result := objBase.fltQtdDil * fCalculaPrecoCusto2(objBase.fltPreVen,
    objBase.fltPreCus, objBase.fltOutVal, objBase.fltIcmSai, objBase.fltImpFed, objBase.fltDesOpe
  ) / (objBase.fltEmbala * objBase.fltPesEsp);
end;

function TAbstractFormulaAutomotiva.GetCalculoBasePreCusCon(objBase: TBaseAutomotiva): Double;
begin
  Result := objBase.fltQtdCon * objBase.fltPreCus / (objBase.fltEmbala * objBase.fltPesEsp);
end;

function TAbstractFormulaAutomotiva.GetCalculoBasePreCusDil(objBase: TBaseAutomotiva): Double;
begin
  Result := objBase.fltQtdDil * objBase.fltPreCus / (objBase.fltEmbala * objBase.fltPesEsp);
end;

function TAbstractFormulaAutomotiva.GetCalculoBasePreMedCon(objBase: TBaseAutomotiva): Double;
begin
  Result := objBase.fltQtdCon * objBase.fltPreMed / (objBase.fltEmbala * objBase.fltPesEsp);
end;

function TAbstractFormulaAutomotiva.GetCalculoBasePreMedDil(objBase: TBaseAutomotiva): Double;
begin
  Result := objBase.fltQtdDil * objBase.fltPreMed / (objBase.fltEmbala * objBase.fltPesEsp);
end;

function TAbstractFormulaAutomotiva.GetCalculoBasePreUltCon(
  objBase: TBaseAutomotiva): Double;
begin
  Result := objBase.fltQtdCon * objBase.fltPreUlt / (objBase.fltEmbala * objBase.fltPesEsp);
end;

function TAbstractFormulaAutomotiva.GetCalculoBasePreUltDil(
  objBase: TBaseAutomotiva): Double;
begin
  Result := objBase.fltQtdDil * objBase.fltPreUlt / (objBase.fltEmbala * objBase.fltPesEsp);
end;

function TAbstractFormulaAutomotiva.GetCalculoBasePreVenCon(objBase: TBaseAutomotiva): Double;
begin
  Result := objBase.fltQtdCon * objBase.fltPreVen / (objBase.fltEmbala * objBase.fltPesEsp);
end;

function TAbstractFormulaAutomotiva.GetCalculoBasePreVenDil(objBase: TBaseAutomotiva): Double;
begin
  Result := objBase.fltQtdDil * objBase.fltPreVen / (objBase.fltEmbala * objBase.fltPesEsp); 
end;

function TAbstractFormulaAutomotiva.GetTextoCalculoValor: string;
begin
  Result := 'Valor da Base  = (Quantidade * Preço) / (Embalagem * Peso Específico)' + #13#10 +
    'Preço da Tinta = Soma(Valores de Base) * Volume Produzido / VolumeFormula';
end;

function TAbstractFormulaAutomotiva.GetTipBas(const strCodBas: string): string;
begin
  Result := 'B';
end;

function TAbstractFormulaAutomotiva.GetVolumeOri: Double;
begin
  Result := 0.9;
end;

end.
