unit untDadosIcms;

interface

uses untInterfaces, StrUtils, SysUtils;

Type
  TDadosIcms = class(TObject)
    private
      FModBcICMS: String;
      FPercRedBcICMS: String;
      FBaseCalcICMS: String;
      FAliquotaICMS: String;
      FValorICMS: String;

      FModBcST: String;
      FIVAST: String;
      FPercRedBcST: String;
      FBaseCalcST: String;
      FAliquotaST: String;
      FValorST: String;

    public
      constructor Create(dadosItem: TDadosItem);

      property strModBcICMS: String Read FModBcICMS;
      property strPercRedBcICMS: String Read FPercRedBcICMS;
      property strBaseCalcICMS: String Read FBaseCalcICMS;
      property strAliquotaICMS: String Read FAliquotaICMS;
      property strValorICMS: String Read FValorICMS;

      property strModBcST: String Read FModBcST;
      property strIVAST: String Read FIVAST;
      property strPercRedBcST: String Read FPercRedBcST;
      property strBaseCalcST: String Read FBaseCalcST;
      property strAliquotaST: String Read FAliquotaST;
      property strValorST: String Read FValorST;

  end;

  TDadosIPI = class(TObject)
    private
      FCstIPI: String;
      FBcIPI: String;
      FPercIPI: String;
      FQtdUnidIPI: String;
      FValUnidIPI: String;
      FValIPI: String;

    public
      constructor Create(dadosItem: TDadosItem; blnSimPau: Boolean);

      property strCstIPI: String Read FCstIPI;
      property strBcIPI: String Read FBcIPI;
      property strPercIPI: String Read FPercIPI;
      property strQtdUnidIPI: String Read FQtdUnidIPI;
      property strValUnidIPI: String Read FValUnidIPI;
      property strValIPI: String Read FValIPI;
  end;

  TDadosPis = class(TObject)
    private
      FCst: String;
      FBaseCalc: String;
      FAliquota: String;
      FValor: String;
      FQtdVendida: String;
      FAlqValor: String;
    public
      constructor Create(dadosItem: TDadosItem);

      property strCst: String Read FCst;
      property strBaseCalc: String Read FBaseCalc;
      property strAliquota: String Read FAliquota;
      property strValor: String Read FValor;
      property strQtdVendida: String Read FQtdVendida;
      property strAlqValor: String Read FAlqValor;
  end;

  TDadosCofins = class(TObject)
    private
      FCst: String;
      FBaseCalc: String;
      FAliquota: String;
      FValor: String;
      FQtdVendida: String;
      FAlqValor: String;
    public
      constructor Create(dadosItem: TDadosItem);

      property strCst: String Read FCst;
      property strBaseCalc: String Read FBaseCalc;
      property strAliquota: String Read FAliquota;
      property strValor: String Read FValor;
      property strQtdVendida: String Read FQtdVendida;
      property strAlqValor: String Read FAlqValor;
  end;

  function fFormatarValor(fltValor: Double; intPrecisao, intDecimais: Integer): String;

implementation
{ TDadosIcms }

constructor TDadosIcms.Create(dadosItem: TDadosItem);
  Var
    strTmpSit: String;
begin
  FModBcICMS     := '0,00';
  FPercRedBcICMS := '0,00';
  FBaseCalcICMS  := '0,00';
  FAliquotaICMS  := '0,00';
  FValorICMS     := '0,00';

  FModBcST       := '';
  FIVAST         := '0,00';
  FPercRedBcST   := '0,00';
  FBaseCalcST    := '0,00';
  FAliquotaST    := '0,00';
  FValorST       := '0,00';

  strTmpSit := RightStr(dadosItem.strCodSit, 02);

  If Pos(strTmpSit, '00_10_20_51_70_90_') > 0 Then
  Begin
    FModBcICMS := '0';

    If dadosItem.fltPerRed > 0 Then
      FPercRedBcICMS := fFormatarValor(dadosItem.fltPerRed, 5, 2);

    FBaseCalcICMS  := fFormatarValor(dadosItem.fltBasIcm, 15, 2);
    FAliquotaICMS  := fFormatarValor(dadosItem.fltAlqIcm, 05, 2);
    FValorICMS     := fFormatarValor(dadosItem.fltValIcm, 15, 2);
  End;

  If Pos(strTmpSit, '10_30_70_90') > 0 Then
  Begin
    If Pos(strTmpSit, '10_30_') > 0 Then
      FModBcST := '4'
    Else
      FModBcST := '0';

    FIVAST := '';
    FPercRedBcST := '';
    FBaseCalcST  := fFormatarValor(dadosItem.fltBasRet, 15, 2);
    FAliquotaST  := fFormatarValor(dadosItem.fltAlqRet, 05, 2);
    FValorST     := fFormatarValor(dadosItem.fltValRet, 15, 2);
  End;
end;

function fFormatarValor(fltValor: Double; intPrecisao,
  intDecimais: Integer): String;
begin
  Result := FloatToStrF(fltValor, ffFixed, intPrecisao, intDecimais);
  Result := AnsiReplaceStr(Result, '.', '');
  Result := AnsiReplaceStr(Result, ',', '.');
end;

{ TDadosIPI }

constructor TDadosIPI.Create(dadosItem: TDadosItem; blnSimPau: Boolean);
begin
  FCstIPI     := '';
  FBcIPI      := '0,00';
  FPercIPI    := '0,00';
  FQtdUnidIPI := '0,00';
  FValUnidIPI := '0,00';
  FValIPI     := '0,00';

  If blnSimPau Then
    Exit;

  If LeftStr(dadosItem.strClaFis, 1) < '5' Then
  Begin
    FCstIPI := '03';
    If dadosItem.fltValIpi <> 0 Then
      FCstIPI := '00';
  End
  Else
  Begin
    FCstIPI := '53';
    If dadosItem.fltValIpi <> 0 Then
      FCstIPI := '50';
  End;

  If Pos(FCstIPI, '00_49_50_99') > 0 Then
  Begin
    FBcIPI   := fFormatarValor(dadosItem.fltBasIpi, 15, 2);
    FPercIPI := fFormatarValor(dadosItem.fltAlqIpi, 05, 2);
    FValIPI  := fFormatarValor(dadosItem.fltValIpi, 15, 2);
  End;
end;

{ TDadosPis }

constructor TDadosPis.Create(dadosItem: TDadosItem);
begin
  FCst        := dadosItem.strCstPis;

  FBaseCalc   := '';
  FAliquota   := '';
  FValor      := '';
  FQtdVendida := '';
  FAlqValor   := '';

  If Pos(FCst, '01_02_99') > 0 Then
  Begin
    FBaseCalc := fFormatarValor(dadosItem.fltBasPis, 15, 2);
    FAliquota := fFormatarValor(dadosItem.fltAlqPis, 05, 2);
    FValor    := fFormatarValor(dadosItem.fltValPis, 15, 2);
  End;

  If Pos(FCst, '03_99') > 0 Then
  Begin
    FValor      := fFormatarValor(dadosItem.fltValPis, 15, 2);
    FQtdVendida := fFormatarValor(dadosItem.fltQtdTri, 16, 4);
    FAlqValor   := fFormatarValor(dadosItem.fltAlPisR, 15, 4);
  End;

end;

{ TDadosCofins }

constructor TDadosCofins.Create(dadosItem: TDadosItem);
begin
  FCst        := dadosItem.strCstCof;

  FBaseCalc   := '';
  FAliquota   := '';
  FValor      := '';
  FQtdVendida := '';
  FAlqValor   := '';

  If Pos(FCst, '01_02_99') > 0 Then
  Begin
    FBaseCalc := fFormatarValor(dadosItem.fltBasCof, 15, 2);
    FAliquota := fFormatarValor(dadosItem.fltAlqCof, 05, 2);
    FValor    := fFormatarValor(dadosItem.fltValCof, 15, 2);
  End;

  If Pos(FCst, '03_99') > 0 Then
  Begin
    FValor      := fFormatarValor(dadosItem.fltValCof, 15, 2);
    FQtdVendida := fFormatarValor(dadosItem.fltQtdTri, 16, 4);
    FAlqValor   := fFormatarValor(dadosItem.fltAlCofR, 15, 4);
  End;
end;

end.
