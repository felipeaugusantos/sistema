unit untCalculoPrecoVenda;

interface

uses
  System.Math, System.SysUtils,
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}

{$ENDIF}
  Controller.Faturamento.Interfaces.Margem.Generic,
  Controller.Faturamento.Margem.Generic,
  Faturamento.Margem.Tipos.MargemBruta,
  Faturamento.Margem.Interfaces.MargemBruta;

function fMarkupToMargem(fltMarkup: Double): Double;

function fMargemToMarkup(fltMargem: Double): Double;

function fRetornaValCom(fltValCom: Double): Double;
function fMarkup1ou2(strMargemMarkup: String;
                     intDecUni: integer;
                     fltCnvCus,
                     curMarBruOri: Double;
                     curMarBru: Currency;
                     curPrecus: Currency;
                     curIcmsVenda: Currency;
                     curImpFed: Currency;
                     curDesOpe: Currency;
                     curValCom: Currency;
                     curDifal: Currency;
                     curFcp: Currency): Double;
function fMargemMarkup3(curMarBru, curPrecus, curIcmsVenda, curImpFed, curDesOpe, curValCom, curDifal, curFcp: Double): Double;
function fMargemMarkup4(blnCalcSt: Boolean; curPrecus, curMarBru, curIcmsVenda, fltIcmsST, curImpFed, curDesOpe, curValCom, curDifal, curFcp: Double): Double;
function fMargemMarkup5(curMarBru, curPrecus, curIcmsVenda, curImpFed, curDesOpe, curValCom, curDifal, curFcp: Double): Double;

function fCalcCurImpFed(AcurImpFed, curIcmsVenda, fltDifal, fltFCP: double): Double;



function fCalculaPrecoVenda(intOpcPrecoMargem: Integer;
                            curPrecus,
                            curPreven,
                            curMarBru,
                            curIcmsVenda,
                            curImpFed,
                            curDesOpe,
                            curValCom: Currency;
                            strMarMkp: String = '';
                            strPcmPro: String = '';
                            intDecUni: Integer = -1;
                            fltIcmsST: Double = 0;
                            blnCalcSt: Boolean = False;
                            curDifal: Currency = 0;
                            curFCP: Currency = 0;
                            curOutVal: Currency = 0;
                            blnRestringirElementosMargem: Boolean = false;
                            fltCnvCus: Double = 1):Double;

implementation

uses
{$IFDEF LINUX}
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  untTMemoriaCalculoPrecoVendaMargem;

Var
  FMargemBrutaFat: IControllerFaturamentoMargemGeneric;

Function fMargemToMarkup(fltMargem: Double): Double;
Var
  LParametrosServicoMargemParaMarkup : IParametrosServicoMargemParaMarkup;
Begin
  FMargemBrutaFat := TControllerFaturamentoMargemGeneric.New;

  LParametrosServicoMargemParaMarkup :=
    TParametrosServicoMargemParaMarkup.New.ValorDaMargem(fltMargem);

  Result := FMargemBrutaFat.MargemBruta.CalculaMargemParaMarkup(LParametrosServicoMargemParaMarkup);
End;

Function fMarkupToMargem(fltMarkup: Double): Double;
Var
  LPrecision: Integer;
Begin
  LPrecision := Max(4, fRetPrecisaoMargemItem);

  If ( ( fltMarkup / 100 ) + 1 ) <> 0 Then
    Result := RoundTo( (( fltMarkup / 100 ) / ( ( fltMarkup / 100 ) + 1 )) * 100, -LPrecision)
  Else
    Result := 0;
End;

function fRetornaValCom(fltValCom: Double): Double;
Begin
  Result := IIF((fCfgSis('PCMPRO') = 3) And (not fCfgSis('MARIDE', varBoolean)), 0, fltValCom);
End;

{***********************************************************************}
{* -> Calcula 1 Preco de Venda  e  2 Margem Bruta                      *}
{********************************************************************WI*}


function fCalcCurImpFed(AcurImpFed, curIcmsVenda, fltDifal, fltFCP: double): Double;
Begin
  Result := AcurImpFed;

  If fCfgSis('PDISIF') = 'S' Then
  Begin
    If fCfgSis('ICMDEB') = 'S' Then
      Result := (AcurImpFed * (1 - (curIcmsVenda/100)));
  End
  Else If fCfgSis('DIMPF4', varString) = 'S' Then
  Begin
    Result := (AcurImpFed * (1 - ((curIcmsVenda + fltDifal + fltFCP)/100)));
  End;
End;



function fMarkup1ou2(strMargemMarkup: String;
                     intDecUni: integer;
                     fltCnvCus,
                     curMarBruOri: Double;
                     curMarBru: Currency;
                     curPrecus: Currency;
                     curIcmsVenda: Currency;
                     curImpFed: Currency;
                     curDesOpe: Currency;
                     curValCom: Currency;
                     curDifal: Currency;
                     curFcp: Currency): Double;
Begin
  // MARKUP OPÇÃO 2 (MODELO NOVO)

  If ( strMargemMarkup = '2' ) Then
    curMarBru := fMarkupToMargem(curMarBru);

  Result := curPrecus;

  curMarBruOri:= curMarBru;

  curMarBru := curMarBru + curIcmsVenda + curImpFed + curDesOpe + curValCom + curDifal + curFcp ;

  TMemoriaCalculoPrecoVendaMargem.strFormula := TMemoriaCalculoPrecoVendaMargem.strFormula +
                                                'Margem = Margem Bruta + ICMS Venda + Imp. Fed. + Desp. Ope. + Pre. Compra + DIFAL + Fundo de Pobreza';
  TMemoriaCalculoPrecoVendaMargem.strCalculo := TMemoriaCalculoPrecoVendaMargem.strCalculo +
                                                'Margem : ' + FormatFloat(fMskDigitos(intDecUni), curMarBruOri) + ' + ' +
                                                 FormatFloat(fMskDigitos(intDecUni), curIcmsVenda) + ' + ' +
                                                 FormatFloat(fMskDigitos(intDecUni), curImpFed)  + ' + ' +
                                                 FormatFloat(fMskDigitos(intDecUni), curDesOpe) + ' + ' +
                                                 FormatFloat(fMskDigitos(intDecUni), curValCom) + ' + ' +
                                                 FormatFloat(fMskDigitos(intDecUni), curDifal) + ' + ' +
                                                 FormatFloat(fMskDigitos(intDecUni), curFcp) + ' = ' +
                                                 FormatFloat(fMskDigitos(intDecUni), curMarBru) + ';';


  If (curMarBru = 100) Then
  Begin
    curMarBru := 0;
    TMemoriaCalculoPrecoVendaMargem.strCalculo := TMemoriaCalculoPrecoVendaMargem.strCalculo + #13  +  'Obs: Se Margem igual 100, então Margem será para o cálculo)'
  End;

  If (Result / ( 1 - ( curMarBru / 100 ) )) <> 0 Then
  Begin
    Result := Result / ( 1 - ( curMarBru / 100 ) );
    TMemoriaCalculoPrecoVendaMargem.strFormula := TMemoriaCalculoPrecoVendaMargem.strFormula + #13 +
                                                  'Preço de Venda = Preço de Custo / (1-(Margem / 100))';
    TMemoriaCalculoPrecoVendaMargem.strCalculo := TMemoriaCalculoPrecoVendaMargem.strCalculo + #13 +
                                                  'Preço de Venda : ' +
                                                  FormatFloat(fMskDigitos(intDecUni),curPrecus/fltCnvCus) + ' / (1-(' +
                                                  FormatFloat(fMskDigitos(intDecUni),curMarBru) + '/ 100)) = ' + FormatFloat(fMskDigitos(intDecUni), Result/fltCnvCus);
  End
  Else
  begin
    TMemoriaCalculoPrecoVendaMargem.strFormula := TMemoriaCalculoPrecoVendaMargem.strFormula + #13 +
                                                  'Se a Margem for 0 o preço de venda é o preço de custo.';
    TMemoriaCalculoPrecoVendaMargem.strCalculo := TMemoriaCalculoPrecoVendaMargem.strCalculo + #13 +
                                                  'Preço de Venda = ' + FormatFloat(fMskDigitos(intDecUni), curPrecus/fltCnvCus) + ' = ' + FormatFloat(fMskDigitos(intDecUni), Result/fltCnvCus) ;
  End;
End;

function fMargemMarkup3(curMarBru, curPrecus, curIcmsVenda, curImpFed, curDesOpe, curValCom, curDifal, curFcp: Double): Double;
Begin
  If curPrecus / (1 - ((curIcmsVenda + curImpFed + curDesOpe + curValCom + curDifal + curFcp )/100)) = 0 Then
    Result := curPrecus
  Else
    Result := curPrecus / (1 - ((curIcmsVenda + curImpFed + curDesOpe + curValCom + curDifal + curFcp )/100));
  Result := Result + ( ( Result * curMarBru ) / 100 );
End;

function fMargemMarkup4(blnCalcSt: Boolean; curPrecus, curMarBru, curIcmsVenda, fltIcmsST, curImpFed, curDesOpe, curValCom, curDifal, curFcp: Double): Double;
begin
  If (blnCalcSt) Then
    curIcmsVenda := 0
  Else
    fltIcmsST := 0;

  If ((100 - (curIcmsVenda + curImpFed + curDesOpe + curValCom + curDifal + curFcp))/100) = 0 Then
    Result := curPrecus
  Else
  Begin
    Result := (curPrecus + ( ( curPrecus * curMarBru ) / 100 ));
    Result := ((Result + fltIcmsST) / ((100 - (curIcmsVenda + curImpFed + curDesOpe + curValCom + curDifal + curFcp))/100));
  End;
End;


function fMargemMarkup5(curMarBru, curPrecus, curIcmsVenda, curImpFed, curDesOpe, curValCom, curDifal, curFcp: Double): double;
begin
  If curPrecus / (1 - ((curIcmsVenda + curImpFed + curDesOpe + curValCom + curDifal + curFcp )/100)) = 0 Then
    Result := curPrecus
  Else
    Result := curPrecus / (1 - ((curIcmsVenda + curImpFed + curDesOpe + curValCom + curDifal + curFcp )/100));

  If (100 - curMarBru) <> 0 Then
    Result := Result / ((100 - curMarBru) /100)
  Else
    Result := 0;
End;


function fCalculaPrecoVenda(intOpcPrecoMargem: Integer;
                            curPrecus,
                            curPreven,
                            curMarBru,
                            curIcmsVenda,
                            curImpFed,
                            curDesOpe,
                            curValCom: Currency;
                            strMarMkp: String = '';
                            strPcmPro: String = '';
                            intDecUni: Integer = -1;
                            fltIcmsST: Double = 0;
                            blnCalcSt: Boolean = False;
                            curDifal: Currency = 0;
                            curFCP: Currency = 0;
                            curOutVal: Currency = 0;
                            blnRestringirElementosMargem: Boolean = false;
                            fltCnvCus: Double = 1):Double;
  Var
    strMargemMarkup : String;
    strElementosMargem: String;
    LParametrosServicoMargemBruta : IParametrosServicoMargemBruta;
    curMarBruOri: Double;
Begin

  TMemoriaCalculoPrecoVendaMargem.strFormula := 'Formula:' + #13;
  TMemoriaCalculoPrecoVendaMargem.strCalculo := 'Cálculo:' + #13;

  If blnRestringirElementosMargem Then
  Begin
    strElementosMargem := fCfgSis('ELEMAR');

    curDesOpe    := IIF( (strElementosMargem[1] = 'S'), curDesOpe,    0 );
    curImpFed    := IIF( (strElementosMargem[2] = 'S'), curImpFed,    0 );
    curIcmsVenda := IIF( (strElementosMargem[3] = 'S'), curIcmsVenda, 0 );
    curOutVal    := IIF( (strElementosMargem[4] = 'S'), curOutVal,    0 );
    curDifal     := IIF( (strElementosMargem[5] = 'S'), curDifal,     0 );
    curFCP       := IIF( (strElementosMargem[6] = 'S'), curFCP,       0 );
  End;

  curImpFed := fCalcCurImpFed(curImpFed, curIcmsVenda, curDifal, curFCP);

  curPrecus := curPrecus + curOutVal;

  If intDecUni = - 1 Then
    intDecUni := fCfgSis('DECUNI', varInteger);

  Result := 0;
  strMargemMarkup := strMarMkp;
  If fEmptyStr(strMarMkp) Then
    strMargemMarkup := fCfgSis('MARMKP');


  {*********************************************}
  {* caso nao use comissao por tabela de preco *}
  {******************************************jc*}

  If fEmptyStr(strPcmPro) Then
    strPcmPro := fCfgSis('PCMPRO');

  {MANTENDO O PARAMETRO CURVALCOM, MESMO QUANDO PCMPRO = '3' - QUE NÃO UTILIZA COMISSÃO, POIS USA O CAMPO DE VALOR
  PARA OUTROS ACRESCIMOS, PORTANTO SÓ SERÁ ZERADO QUANTO PCMPRO = '1' - KM}
  If strPcmPro = '1' Then
    curValCom := 0;

  {*****************************************}
  {* intOpcCalculo -> 1 Margem             *}
  {*               -> 2 MarKup             *}
  {**************************************WI*}
  If strMargemMarkup = '' Then
    strMargemMarkup := '1';

  {*****************************************}
  {* -> Calcula Preco de Venda             *}
  {**************************************WI*}
  If ( intOpcPrecoMargem = 1 ) Then
  Begin

    // CFG_MARMKP = MARGEM OU MARKUP OPÇÃO 2 (MODELO NOVO)
    If ( strMargemMarkup = '1' ) Or ( strMargemMarkup = '2' ) Then
    Begin
      curMarBruOri:= curMarBru;

      Result := fMarkup1ou2(strMargemMarkup,
                            intDecUni,
                            fltCnvCus,
                            curMarBruOri,
                            curMarBru,
                            curPrecus,
                            curIcmsVenda,
                            curImpFed,
                            curDesOpe,
                            curValCom,
                            curDifal,
                            curFcp)
    End
    Else If ( strMargemMarkup = '3' ) Then // MARKUP MODELO ANTIGO
    Begin
     Result := fMargemMarkup3(curMarBru, curPrecus, curIcmsVenda, curImpFed, curDesOpe, curValCom, curDifal, curFcp)
    End

    Else If ( strMargemMarkup = '4' ) Then // (4) - MARKUP RITEC
    Begin
      Result := fMargemMarkup4(blnCalcSt, curPrecus, curMarBru, curIcmsVenda, fltIcmsST, curImpFed, curDesOpe, curValCom, curDifal, curFcp)

    End

    Else If ( strMargemMarkup = '5' ) Then
    Begin
      Result := fMargemMarkup5(curMarBru, curPrecus, curIcmsVenda, curImpFed, curDesOpe, curValCom, curDifal, curFcp)
    End;

  End

  {*****************************************}
  {* -> Calcula Margem Bruta               *}
  {**************************************WI*}
  Else If ( intOpcPrecoMargem = 2 ) Then
  Begin
    FMargemBrutaFat := TControllerFaturamentoMargemGeneric.New;

    LParametrosServicoMargemBruta :=
      TParametrosServicoMargemBruta.New
        .ConfiguracaoMargemMarkup(strMargemMarkup)
        .PrecoDeCusto(curPrecus)
        .PrecoDeVenda(curPreven)
        .ValorDaMargem(curMarBru)
        .IcmsDeSaida(curIcmsVenda)
        .ImpostosFederais(curImpFed)
        .DespesasOperacionais(curDesOpe)
        .PrecoDeCompra(curValCom)
        .ValorIcmsSt(fltIcmsST)
        .CalcularST(blnCalcSt)
        .ValorDifal(curDifal)
        .ValorFCP(curFcp);


    Result := FMargemBrutaFat.MargemBruta.CalculaMargemBruta(LParametrosServicoMargemBruta);
  End;

//  Usando FormatFloat('#,##0.00', 82.075) as vezes resulta '82.07' outras vezes '82.08'
//  vamos trocar por fFormataFloat que arredonda pra cima sempre
//  If (intOpcPrecoMargem = 1) Then
//    Result := fStrToFloat(FormatFloat(fMskDigitos(intDecUni) , Result ) );
  If (intOpcPrecoMargem = 1) Then
    Result := fFormataFloat(Result, intDecUni);
End;

end.
