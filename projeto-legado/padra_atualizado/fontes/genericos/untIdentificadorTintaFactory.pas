unit untIdentificadorTintaFactory;

interface

uses
   untIIdentificadorTinta, untAutcomDllTinta, DB;

type
  TIdentificadorTintaFactory = class
  public
    class function GetIdentificadorTintaAxalta(strIteTin: String; fltQtdIte, fltVolPro: Double; strTipPre,
      strCatali: String; strCodEmpPrd: string; const fGTinForGeral: TfGTinForGeral): IIdentificadorTinta;
    class function GetIdentificadorFatVendas(const cdsVenda: TDataSet; const fGTinForGeral: TfGTinForGeral): IIdentificadorTinta;
  end;

implementation

uses untIdentificadorTinta, untFuncoesSimples;

{ TIdentificadorTintaFactory }

class function TIdentificadorTintaFactory.GetIdentificadorFatVendas(const cdsVenda: TDataSet;
  const fGTinForGeral: TfGTinForGeral): IIdentificadorTinta;
begin
  Result := TIdentificadorTinta.Create(cdsVenda.FieldByName('ITE_IDEPRO').AsString,
    cdsVenda.FieldByName('ITE_VOLPRO').AsFloat,
    cdsVenda.FieldByName('FOR_MODDIL').AsInteger,
    cdsVenda.FieldByName('ITE_CATALI').AsString,
    cdsVenda.FieldByName('ITE_CODDIL').AsString,
    cdsVenda.FieldByName('ITE_DESITE').AsString,
    cdsVenda.FieldByName('ITE_DILCON').AsString,
    cdsVenda.FieldByName('FOR_ITECOB').AsString,
    cdsVenda.FieldByName('ITE_ITETIN').AsString,
    cdsVenda.FieldByName('ITE_LAZQUA').AsInteger,
    cdsVenda.FieldByName('ITE_LINTIN').AsString,
    ((fCfgSis('PAINTM',varString,VS_strCodEmp) = 'S') and (cdsVenda.FieldByName('ITE_IDEPRO').AsString = 'PPG')),
    cdsVenda.FieldByName('ITE_PORCAT').AsFloat,
    cdsVenda.FieldByName('ITE_PORDIL').AsFloat,
    cdsVenda.FieldByName('ITE_QTDEMB').AsFloat,
    cdsVenda.FieldByName('ITE_QTDITE').AsFloat,
    cdsVenda.FieldByName('FOR_TEXBAS').AsString,
    cdsVenda.FieldByName('FOR_TIPCOR').AsString,
    cdsVenda.FieldByName('ITE_TIPPRE').AsString,
    fGTinForGeral);
end;

class function TIdentificadorTintaFactory.GetIdentificadorTintaAxalta(strIteTin: String; fltQtdIte, fltVolPro: Double; strTipPre,
  strCatali: String; strCodEmpPrd: string; const fGTinForGeral: TfGTinForGeral): IIdentificadorTinta;
begin
  Result := TIdentificadorTinta.Create('DUP', fltVolPro, 0, strCatali, '', '', '', '', strIteTin, 0, '', False, 0, 0, 0,
    fltQtdIte, '', '', strTipPre, fGTinForGeral);
end;

end.
