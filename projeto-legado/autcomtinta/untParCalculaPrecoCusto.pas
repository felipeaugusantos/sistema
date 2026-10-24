{*************************************}
{ CLASSE PARA PASSAGEM DE PARÂMENTROS }
{  NA FUNÇÃO FCALCULAPRECOCUSTO       }
{**********************************JB*}

unit untParCalculaPrecoCusto;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core,
{$ELSE}
  Dialogs, Windows, Messages, Graphics, Controls, Forms,
{$ENDIF}
  SysUtils, Variants, Classes,
  StrUtils, untIConfiguracao{, untFormulaCustoProduto},
  untFatCalcularPrecosService,
  Faturamento.Precos.Interfaces.PrecoCusto,
  Faturamento.Precos.Tipos.PrecoCusto,
  Faturamento.Precos.Interfaces.Servicos.Disponiveis.PrecoCusto,
  Shared.Functions.Types;

//Type
//  TTipoMoeda = (moeDolar, moePeso, moeGuaranie, moeEuro, moeReal);

Type
  IConversorMoedaCusto = Interface
    function fConvertePrecos(fltPreAtu: Double; moeTipMoe: TTipoMoeda): Double;
  End;

  TParCalculaPrecoCusto = class(TComponent)
    private
      objCfg: IConfiguracao;

      FDecUni: Integer;
      FMarMkp,
      FFrmCus: String;
      FOpeAdiDesAdb: Boolean;

      FPreCom  : Double;
      FDesF01  : Double;
      FDesF02  : Double;
      FDesF03  : Double;
      FDesF04  : Double;
      FDesF05  : Double;
      FDesF06  : Double;
      FDesF07  : Double;
      FICMSEnt : Double;
      FSubFed  : Double;
      FIPIEnt  : Double;
      FFrete   : Double;
      FValFre  : Double;
      FAcrFin  : Double;
      FSubsti  : Double;
      FDesAdb  : Double;
      FTCIFCu  : Double;
      FTSCust  : Double;
      FDePiCo  : Double;
      FDeICMS  : Double;
      FFatReg  : Double;
      //FImpFed  : Double;
      //FDesOpe  : Double;

    private

      procedure SetPreCom(curPreCom: Double);
      function  GetPreCom: Double;
      procedure SetDesF01(curDesF01: Double);
      function  GetDesF01: Double;
      procedure SetDesF02(curDesF02: Double);
      function  GetDesF02: Double;
      procedure SetDesF03(curDesF03: Double);
      function  GetDesF03: Double;
      procedure SetDesF04(curDesF04: Double);
      function  GetDesF04: Double;
      procedure SetDesF05(curDesF05: Double);
      function  GetDesF05: Double;
      procedure SetDesF06(curDesF06: Double);
      function  GetDesF06: Double;
      procedure SetDesF07(curDesF07: Double);
      function  GetDesF07: Double;
      procedure SetICMSEnt(curICMSEnt: Double);
      function  GetICMSEnt: Double;
      procedure SetSubFed(curSubFed: Double);
      function  GetSubFed: Double;
      procedure SetIPIEnt(curIPIEnt: Double);
      function  GetIPIEnt: Double;
      procedure SetFrete(curFrete: Double);
      function  GetFrete: Double;
      procedure SetValFre(curValFre: Double);
      function  GetValFre: Double;
      procedure SetAcrFin(curAcrFin: Double);
      function  GetAcrFin: Double;
      procedure SetSubsti(curSubsti: Double);
      function  GetSubsti: Double;
      procedure SetTCIFCu(curTCIFCu: Double);
      function  GetTCIFCu: Double;
      procedure SetTSCust(curTSCust: Double);
      function  GetTSCust: Double;
      procedure SetDePiCo(curDePiCo: Double);
      function  GetDePiCo: Double;
      procedure SetDeICMS(curDeICMS: Double);
      function  GetDeICMS: Double;
      procedure SetFatReg(curFatReg: Double);
      function  GetFatReg: Double;
      //procedure SetDesOpe(curDesOpe: Double);
      //function  GetDesOpe: Double;

      function ServicosDisponiveisPrecoCusto: IFaturamentoPrecosServicosDisponiveisPrecoCusto;
      function RetornarValorPrecoCusto(const objConversorMoeda: IConversorMoedaCusto): Double;

    public

//      frmFormulaCusto: TFormulaCustoProduto;

      constructor Create(Owner: TComponent; objCfg: IConfiguracao; blnRecarregarFormula: Boolean = False; blnDemoCusto: Boolean = False); Reintroduce;
      destructor Destroy; override;

      procedure pLimparCampos;

      function fCalculaPrecoCusto(objConversorMoeda: IConversorMoedaCusto = Nil): Double; overload;
      function fCalculaPrecoCusto(fltPreVen, fltMargem: Double): Double; overload;

      function fCalculaPrecoCustoRealVenda(fltPreVen, fltPreCus, fltOutVal,
                 fltICMSai, fltImpFed, fltDesOpe, fltDifal, fltFCP: Double; fltTaxaJuros : Double = 0): Double;

    published
      property curPreCom : Double read GetPreCom  write SetPreCom;
      property curDesF01 : Double read GetDesF01  write SetDesF01;
      property curDesF02 : Double read GetDesF02  write SetDesF02;
      property curDesF03 : Double read GetDesF03  write SetDesF03;
      property curDesF04 : Double read GetDesF04  write SetDesF04;
      property curDesF05 : Double read GetDesF05  write SetDesF05;
      property curDesF06 : Double read GetDesF06  write SetDesF06;
      property curDesF07 : Double read GetDesF07  write SetDesF07;
      property curICMSEnt: Double read GetICMSEnt write SetICMSEnt;
      property curSubFed : Double read GetSubFed  write SetSubFed;
      property curIPIEnt : Double read GetIPIEnt  write SetIPIEnt;
      property curFrete  : Double read GetFrete   write SetFrete;
      property curValFre : Double read GetValFre  write SetValFre;
      property curAcrFin : Double read GetAcrFin  write SetAcrFin;
      property curSubsti : Double read GetSubsti  write SetSubsti;
      property curDesAdb : Double read FDesAdb    write FDesAdb;
      property curTCIFCu : Double read GetTCIFCu  write SetTCIFCu;
      property curTSCust : Double read GetTSCust  write SetTSCust;
      property curDePiCo : Double read GetDePiCo  write SetDePiCo;
      property curDeICMS : Double read GetDeICMS  write SetDeICMS;
      property curFatReg : Double read GetFatReg  write SetFatReg;
      //property curDesOpe : Double read GetDesOpe  write SetDesOpe;
      //property curImpFed : Double read FImpFed    write FImpFed;

End;

implementation

constructor TParCalculaPrecoCusto.Create(Owner: TComponent; objCfg: IConfiguracao; blnRecarregarFormula: Boolean = False; blnDemoCusto: Boolean = False);
begin
  inherited Create(Owner);
  pLimparCampos;
  Self.objCfg := objCfg;

  FOpeAdiDesAdb := SameText(objCfg.fCfgSis('OPEADI'), '+');
  FFrmCus := objCfg.fCfgSis('FRMCUS');
  FDecUni := objCfg.fCfgSis('DECUNI', varInteger);
  FMarMkp := objCfg.fCfgSis('MARMKP');

{  If (FFrmCus = '4') Or blnDemoCusto Then
    frmFormulaCusto := TFormulaCustoProduto.Create(Self, StrToIntDef(FFrmCus, -1), blnRecarregarFormula, blnDemoCusto)
  Else
    frmFormulaCusto := Nil;
    }
end;

Destructor TParCalculaPrecoCusto.Destroy;
begin

  inherited Destroy;

end;


procedure TParCalculaPrecoCusto.SetPreCom(curPreCom: Double);
begin
  FPreCom := curPreCom;
end;

function  TParCalculaPrecoCusto.GetPreCom: Double;
begin
  Result := FPreCom;
end;

procedure TParCalculaPrecoCusto.SetDeICMS(curDeICMS: Double);
begin
  FDeICMS := curDeICMS;
end;

procedure TParCalculaPrecoCusto.SetDePiCo(curDePiCo: Double);
begin
  FDePiCo := curDePiCo;
end;

procedure TParCalculaPrecoCusto.SetDesF01(curDesF01: Double);
begin
  FDesF01 := curDesF01;
end;

function TParCalculaPrecoCusto.GetDeICMS: Double;
begin
  Result := FDeICMS;
end;

function TParCalculaPrecoCusto.GetDePiCo: Double;
begin
  Result := FDePiCo;
end;

function  TParCalculaPrecoCusto.GetDesF01: Double;
begin
  Result := FDesF01;
end;

procedure TParCalculaPrecoCusto.SetDesF02(curDesF02: Double);
begin
  FDesF02 := curDesF02;
end;

function  TParCalculaPrecoCusto.GetDesF02: Double;
begin
  Result := FDesF02;
end;

procedure TParCalculaPrecoCusto.SetDesF03(curDesF03: Double);
begin
  FDesF03 := curDesF03;
end;

function  TParCalculaPrecoCusto.GetDesF03: Double;
begin
  Result := FDesF03;
end;

procedure TParCalculaPrecoCusto.SetDesF04(curDesF04: Double);
begin
  FDesF04 := curDesF04;
end;

function  TParCalculaPrecoCusto.GetDesF04: Double;
begin
  Result := FDesF04;
end;

procedure TParCalculaPrecoCusto.SetDesF05(curDesF05: Double);
begin
  FDesF05 := curDesF05;
end;

function  TParCalculaPrecoCusto.GetDesF05: Double;
begin
  Result := FDesF05;
end;

procedure TParCalculaPrecoCusto.SetDesF06(curDesF06: Double);
begin
  FDesF06 := curDesF06;
end;

procedure TParCalculaPrecoCusto.SetDesF07(curDesF07: Double);
begin
  FDesF07 := curDesF07;
end;

function  TParCalculaPrecoCusto.GetDesF06: Double;
begin
  Result := FDesF06;
end;

function TParCalculaPrecoCusto.GetDesF07: Double;
begin
  Result := FDesF07;
end;

procedure TParCalculaPrecoCusto.SetICMSEnt(curICMSEnt: Double);
begin
  FICMSEnt := curICMSEnt;
end;

function  TParCalculaPrecoCusto.GetICMSEnt: Double;
begin
  Result := FICMSEnt;
end;

procedure TParCalculaPrecoCusto.SetSubFed(curSubFed: Double);
begin
  FSubFed := curSubFed;
end;

function  TParCalculaPrecoCusto.GetSubFed: Double;
begin
  Result := FSubFed;
end;

procedure TParCalculaPrecoCusto.SetIPIEnt(curIPIEnt: Double);
begin
  FIPIEnt := curIPIEnt;
end;

function  TParCalculaPrecoCusto.GetIPIEnt: Double;
begin
  Result := FIPIEnt;
end;

procedure TParCalculaPrecoCusto.SetFatReg(curFatReg: Double);
begin
  FFatReg := curFatReg;
end;

procedure TParCalculaPrecoCusto.SetFrete(curFrete: Double);
begin
  FFrete := curFrete;
end;

function TParCalculaPrecoCusto.GetFatReg: Double;
begin
  Result := FFatReg;
end;

function  TParCalculaPrecoCusto.GetFrete: Double;
begin
  Result := FFrete;
end;

function TParCalculaPrecoCusto.ServicosDisponiveisPrecoCusto: IFaturamentoPrecosServicosDisponiveisPrecoCusto;
begin
  Result := GetFaturamentoPrecosService(ExtractFilePath(Application.ExeName)).PrecoCusto;
end;

procedure TParCalculaPrecoCusto.SetAcrFin(curAcrFin: Double);
begin
  FAcrFin := curAcrFin;
end;

function  TParCalculaPrecoCusto.GetAcrFin: Double;
begin
  Result := FAcrFin;
end;

procedure TParCalculaPrecoCusto.SetSubsti(curSubsti: Double);
begin
  FSubsti := curSubsti;
end;

procedure TParCalculaPrecoCusto.SetTCIFCu(curTCIFCu: Double);
begin
  FTCIFCu := curTCIFCu
end;

procedure TParCalculaPrecoCusto.SetTSCust(curTSCust: Double);
begin
  FTSCust := curTSCust;
end;

function  TParCalculaPrecoCusto.GetSubsti: Double;
begin
  Result := FSubsti;
end;

function TParCalculaPrecoCusto.GetTCIFCu: Double;
begin
  Result := FTCIFCu;
end;

function TParCalculaPrecoCusto.GetTSCust: Double;
begin
  Result := FTSCust;
end;

(*
procedure TParCalculaPrecoCusto.SetDesOpe(curDesOpe: Double);
begin
  FDesOpe := curDesOpe;
end;

function  TParCalculaPrecoCusto.GetDesOpe: Double;
begin
  Result := FDesOpe;
end;
*)

procedure  TParCalculaPrecoCusto.pLimparCampos;
begin
  curPreCom := 0.0;
  curDesF01 := 0.0;
  curDesF02 := 0.0;
  curDesF03 := 0.0;
  curDesF04 := 0.0;
  curDesF05 := 0.0;
  curDesF06 := 0.0;
  curDesF07 := 0.0;
  curICMSEnt:= 0.0;
  curIPIEnt := 0.0;
  curSubFed := 0.0;
  curFrete  := 0.0;
  curValFre := 0.0;
  curAcrFin := 0.0;
  curSubsti := 0.0;
  curDesAdb := 0.0;
  curTCIFCu := 0.0;
  curTSCust := 0.0;
  curDePiCo := 0.0;
  curDeICMS := 0.0;
  curFatReg := 0.0;
//  curDesOpe := 0.0;
  //curImpFed := 0.0;
end;

function TParCalculaPrecoCusto.RetornarValorPrecoCusto(const objConversorMoeda: IConversorMoedaCusto): Double;
Var
  LParametros : IParametrosServicoPrecoCusto;
Begin
  LParametros :=
    TParametrosServicoPrecoCusto.New
      .PrecoDeCompra(curPreCom)
      .Desconto01(curDesF01)
      .Desconto02(curDesF02)
      .Desconto03(curDesF03)
      .Desconto04(curDesF04)
      .Desconto05(curDesF05)
      .Desconto06(curDesF06)
      .Desconto07(curDesF07)
      .IcmsDeEntrada(curICMSEnt)
      .ImpostoFederal(curSubFed)
      .IpiDeEntrada(curIPIEnt)
      .PercentualFreteDeEntrada(curFrete)
      .ValorDoFrete(curValFre)
      .AcrescimoFinal(curAcrFin)
      .SubstituicaoTributaria(curSubsti)
      .DescontosAdicionais(curDesAdb)
      .TipoMoeda(moeDolar)
      .CalculandoTintaDeMaquina(True);

  If Assigned(objConversorMoeda) Then
  Begin
    Result :=
      ServicosDisponiveisPrecoCusto
        .CalculaPrecoCustoConversorMoeda(LParametros)
          .ResultadoCalculoPrecoCusto
            .ValorCalculadoPrecoCusto;

    Exit;
  End;

  Result :=
    ServicosDisponiveisPrecoCusto
      .CalculaPrecoCusto(LParametros)
        .ResultadoCalculoPrecoCusto
          .ValorCalculadoPrecoCusto;
end;

{***********************************************************************}
{* -> Calcula Preco de Custo                                           *}
{********************************************************************JB*}
function TParCalculaPrecoCusto.fCalculaPrecoCusto(objConversorMoeda: IConversorMoedaCusto = Nil): Double;
//  Var
//    fltRes01: Double;
//    fltRes02: Double;
//    fltRes03: Double;
//    fltRes04: Double;
//    fltRes05: Double;
//    fltRes06: Double;
//    fltTotFre: Double;
//
//    auxICMSEnt,
//    auxIPIEnt,
//    auxFrete,
//    auxAcrFin,
//    auxSubFed,
//    auxSubsti: Double;
Begin

//  {**********************************}
//  {* CALCULA PREÇOS DE CUSTO        *}
//  {*******************************JB*}
//  Result := curPrecom;
//
//  {***********************************}
//  {* VERIFICA SE CONVERTE O VALOR DO *}
//  {* PREÇO DE COMPRA EM DOLAR.       *}
//  {********************************PZ*}
//  If (Assigned(objConversorMoeda)) Then
//    Result := objConversorMoeda.fConvertePrecos(Result, moeDolar);
//
//  Result := Result - ( Result * ( curDesF01 / 100 ) );
//  Result := Result - ( Result * ( curDesF02 / 100 ) );
//  Result := Result - ( Result * ( curDesF03 / 100 ) );
//  Result := Result - ( Result * ( curDesF04 / 100 ) );
//  Result := Result - ( Result * ( curDesF05 / 100 ) );
//  Result := Result - ( Result * ( curDesF06 / 100 ) );
//  Result := Result - ( Result * ( curDesF07 / 100 ) );
//
//  If (FFrmCus = '1') Then
//  Begin
//
//    Result   := Result + ( Result * ( curIPIEnt  / 100 ) );
//    Result   := Result + ( Result * ( curSubsti  / 100 ) );
//
//    fltRes01 := ( Result * ( curICMSEnt / 100 ) );
//    fltRes03 := ( Result * ( curFrete   / 100 ) );
//    fltRes04 := ( Result * ( curAcrFin  / 100 ) );
//    fltRes06 := ( Result * ( curSubFed  / 100 ) );
//
//    Result := Result - fltRes01 + fltRes03 + fltRes04 - fltRes06;
//
//  End
//  Else If (FFrmCus = '2') Then
//  Begin
//
//    fltRes01  := ( Result * ( curIPIEnt  / 100 ) );
//    fltRes02  := ( Result * ( curSubsti  / 100 ) );
//
//    fltTotFre := Result + fltRes01 + fltRes02;
//    fltRes03  := fltTotFre * ( curFrete / 100 );
//
//    fltRes04  := ( Result * ( curICMSEnt / 100 ) );
//    fltRes06  := ( Result * ( curSubFed  / 100 ) );
//
//    fltRes05  := ( (Result + fltRes01 + fltRes02) * ( curAcrFin  / 100 ) );
//
//    Result    := Result + fltRes01 + fltRes02 + fltRes03 - fltRes04 + fltRes05 - fltRes06;
//
//  End
//  Else If (FFrmCus = '3') Then
//  Begin
//
//    auxICMSEnt := ( Result * ( curICMSEnt / 100 ) );
//    auxIPIEnt  := ( Result * ( curIPIEnt  / 100 ) );
//    auxFrete   := ( Result * ( curFrete   / 100 ) );
//    auxAcrFin  := ( Result * ( curAcrFin  / 100 ) );
//    auxSubFed  := ( Result * ( curSubFed  / 100 ) );
//
//    auxSubsti  := ( ( (  Result  + auxIPIEnt +  auxFrete ) * curSubsti ) / 100 );
//
//    Result     := Result - auxICMSEnt + auxFrete + auxSubsti + auxIPIEnt + auxAcrFin - auxSubFed;
//  End;
//
//  If (FFrmCus = '4') Then
//  Begin
//
//{    Result := frmFormulaCusto.fCalculaPrecoCusto(Result,    curICMSEnt, curSubFed,
//                                                 curIPIEnt, curFrete,   curValFre,
//                                                 curAcrFin, curSubsti,  curDesAdb,
//                                                 curAnteST, curTCIFCu,  curTSCust,
//                                                 curDePiCo, curDeICMS,  curFatReg);}
//
//  End Else
//  Begin
//
//    {*****************************************}
//    {* SOMA O FRETE EM VALOR.                *}
//    {**************************************MV*}
//    Result := Result + curValFre;
//
//    {***********************************}
//    {* DESC. ADICIONAIS (BOLETO)       *}
//    {********************************AF*}
//    If FOpeAdiDesAdb Then
//      Result := Result + ( Result * ( curDesAdb / 100 ) )
//    Else
//      Result := Result - ( Result * ( curDesAdb / 100 ) );
//
//  End;
//
//  Result := fStrToFloat( FormatFloat(fMskDigitos(FDecUni), Result ) );

  Result := RetornarValorPrecoCusto(objConversorMoeda);
End;

{*******************************************}
{* FAZ CÁLCULO DO CUSTO DE ACORDO COM A    *}
{* CONFIGURAÇÃO DE MARGEM / MARK-UP        *}
{****************************************MV*}
function TParCalculaPrecoCusto.fCalculaPrecoCusto(fltPreVen, fltMargem: Double): Double;
var
  LParametros: IParametrosServicoPrecoCustoMargemMarkup;
begin
//  If Pos(FMarMkp, '1_5_') > 0 Then
//  Begin
//    Result := fltPreVen * ((100.0 - fltMargem) / 100.0);
//  End
//  Else
//  Begin
//    Result := fltPreVen / (1.0 + (fltMargem / 100.0));
//  End;
//
//  Result := fFormataFloat(Result, 2);

  LParametros :=
    TParametrosServicoPrecoCustoMargemMarkup.New()
      .PrecoDeVenda(fltPreVen)
      .Margem(fltMargem);

  Result :=
    ServicosDisponiveisPrecoCusto
      .CalculaPrecoCusto(LParametros)
        .ResultadoCalculoPrecoCusto
          .ValorCalculadoPrecoCusto;
End;

function TParCalculaPrecoCusto.fCalculaPrecoCustoRealVenda(fltPreVen, fltPreCus, fltOutVal,
              fltICMSai, fltImpFed, fltDesOpe, fltDifal, fltFCP: Double; fltTaxaJuros : Double = 0): Double;
var
  LParametros: IParametrosCalculoPrecoCustoRealVenda;
Begin
//  Result := fltPreCus * (1 + fltTaxaJuros/100)+ fltOutVal + (fltICMSai*fltPreVen/100) +
//                                                            (fltImpFed*fltPreVen/100) +
//                                                            (fltDesOpe*fltPreVen/100) +
//                                                            (fltDifal *fltPreVen/100) +
//                                                            (fltFCP   *fltPreVen/100);

  LParametros :=
    TParametrosCalculoPrecoCustoRealVenda.New()
      .PrecoDeVenda(fltPreVen)
      .PrecoDeCusto(fltPreCus)
      .OutrosValores(fltOutVal)
      .IcmsDeSaida(fltICMSai)
      .ImpostosFederais(fltImpFed)
      .DespesasOperacionais(fltDesOpe)
      .AliquotaDoDifal(fltDifal)
      .AliquotaDoFcp(fltFCP)
      .TaxaDeJuros(fltTaxaJuros);

  Result :=
    ServicosDisponiveisPrecoCusto
      .CalculaPrecoCustoRealVenda(LParametros)
        .ResultadoCalculoPrecoCusto
          .ValorCalculadoPrecoCusto;
End;

function TParCalculaPrecoCusto.GetValFre: Double;
begin
  Result := FValFre;
end;

procedure TParCalculaPrecoCusto.SetValFre(curValFre: Double);
begin
  FValFre := curValFre;
end;

end.

