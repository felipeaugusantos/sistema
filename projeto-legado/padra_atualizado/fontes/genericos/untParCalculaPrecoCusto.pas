{*************************************}
{ CLASSE PARA PASSAGEM DE PARÂMENTROS }
{  NA FUNÇÃO FCALCULAPRECOCUSTO       }
{**********************************JB*}

unit untParCalculaPrecoCusto;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  Windows, Messages, Graphics, Controls, Forms, Dialogs,
  untFormulaCustoProduto,
{$ENDIF}
  untIConfiguracao,
  Shared.Functions.Types,
  Shared.Functions.Configuracoes,
  Faturamento.Precos.Tipos.PrecoCusto,
  Faturamento.Precos.Interfaces.PrecoCusto,
  Controller.Faturamento.Interfaces.Precos.Generic,
  Controller.Faturamento.Precos.Generic,
  SysUtils, Variants, Classes, StrUtils;

Type
  IConversorMoedaCusto = Interface
    function fConvertePrecos(fltPreAtu: Double; moeTipMoe: TTipoMoeda; intDecUni: Integer = 2): Double;
  End;

  TParCalculaPrecoCusto = class(TComponent)
    private
      objCfg: IConfiguracao;

      FPrecoCustoFat : IControllerFaturamentoPrecosGeneric;

      FDecUni: Integer;
      FFrmCus: String;

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
      FRpaFre  : Double;
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
      procedure SetRpaFre(curRpaFre: Double);
      function GetRpaFre: Double;

      function RetornarValorPrecoCusto(Const UtilizarConversor : Boolean) : Double;

     {$IFNDEF LINUX}
      function ApresentarFormulaDeCusto(Const CfgFormulaCusto :Boolean; Const DemonstrarFormula : Boolean) : Boolean;
     {$ENDIF}

    public

     {$IFNDEF LINUX}
      frmFormulaCusto: TFormulaCustoProduto;
     {$ENDIF}

      constructor Create(Owner: TComponent; objCfg: IConfiguracao; blnRecarregarFormula: Boolean = False; blnDemoCusto: Boolean = False; blnGeraAutoIncrem: Boolean = True); Reintroduce;

      destructor Destroy; override;

      procedure pLimparCampos;

      function fCalculaPrecoCusto(Const blnUtilizarConversorDeMoeda : Boolean = false): Double; overload;

      function fCalculaPrecoCusto(fltPreVen, fltMargem: Double): Double; overload;

      function fCalculaPrecoCustoRealVenda(fltPreVen, fltPreCus, fltOutVal,
                 fltICMSai, fltImpFed, fltDesOpe, fltDifal, fltFCP: Double; fltTaxaJuros : Double = 0; fltFrete: Double = 0): Double;

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
      property curRpaFre : Double read GetRpaFre  Write SetRpaFre;

End;

implementation

{$IFNDEF LINUX}
function TParCalculaPrecoCusto.ApresentarFormulaDeCusto(const CfgFormulaCusto,
  DemonstrarFormula: Boolean): Boolean;
begin
  Result := true;

  If CfgFormulaCusto Then
    Exit;

  If DemonstrarFormula Then
    Exit;

  Result := False;
end;
{$ENDIF}

constructor TParCalculaPrecoCusto.Create(Owner: TComponent; objCfg: IConfiguracao; blnRecarregarFormula: Boolean = False; blnDemoCusto: Boolean = False; blnGeraAutoIncrem: Boolean = True);
begin
  inherited Create(Owner);

  FPrecoCustoFat := TControllerFaturamentoPrecosGeneric.New;

  pLimparCampos;
  Self.objCfg := objCfg;

  FFrmCus := objCfg.fCfgSis('FRMCUS');
  FDecUni := objCfg.fCfgSis('DECUNI', varInteger);

{$IFNDEF LINUX}
  frmFormulaCusto := Nil;
  If ApresentarFormulaDeCusto(FFrmCus = '4', blnDemoCusto) Then
    frmFormulaCusto := TFormulaCustoProduto.Create(Self, StrToIntDef(FFrmCus, -1), blnRecarregarFormula, blnDemoCusto, blnGeraAutoIncrem)
{$ENDIF}
end;

Destructor TParCalculaPrecoCusto.Destroy;
begin

  inherited Destroy;

end;

function TParCalculaPrecoCusto.GetValFre: Double;
begin
  Result := FValFre;
end;

procedure TParCalculaPrecoCusto.SetValFre(curValFre: Double);
begin
  FValFre := curValFre;
end;


procedure TParCalculaPrecoCusto.SetPreCom(curPreCom: Double);
begin
  FPreCom := curPreCom;
end;

procedure TParCalculaPrecoCusto.SetRpaFre(curRpaFre: Double);
begin
  FRpaFre := curRpaFre;
end;

function  TParCalculaPrecoCusto.GetPreCom: Double;
begin
  Result := FPreCom;
end;

function TParCalculaPrecoCusto.GetRpaFre: Double;
begin
  Result := curRpaFre;
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
  FTCIFCu := curTCIFCu;
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
  curRpaFre := 0.0;
end;

function TParCalculaPrecoCusto.RetornarValorPrecoCusto(
  const UtilizarConversor: Boolean): Double;
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
      .TaxaDeControleDeIncentivosFiscaisSuframa(curTCIFCu)
      .TaxaDeServicoSuframa(curTSCust)
      .DescontoPISCOFINS(curDePiCo)
      .DescontoDeIcms(curDeICMS)
      .FatorRegional(curFatReg)
      .Predol(UtilizarConversor);

  If UtilizarConversor Then
  begin
    Result := FPrecoCustoFat.PrecoCusto.CalculaPrecoCustoConversorMoeda(LParametros);
    Exit;
  end;

  Result := FPrecoCustoFat.PrecoCusto.CalculaPrecoCusto(LParametros);

end;

{***********************************************************************}
{* -> Calcula Preco de Custo                                           *}
{********************************************************************JB*}
function TParCalculaPrecoCusto.fCalculaPrecoCusto(Const blnUtilizarConversorDeMoeda: Boolean = false): Double;
Begin
  Result := RetornarValorPrecoCusto(blnUtilizarConversorDeMoeda);
End;

{*******************************************}
{* FAZ CÁLCULO DO CUSTO DE ACORDO COM A    *}
{* CONFIGURAÇÃO DE MARGEM / MARK-UP        *}
{****************************************MV*}
function TParCalculaPrecoCusto.fCalculaPrecoCusto(fltPreVen, fltMargem: Double): Double;
var
  LParametrosPrecoCustomargem : IParametrosServicoPrecoCustoMargemMarkup;
begin
  LParametrosPrecoCustomargem :=
    TParametrosServicoPrecoCustoMargemMarkup.New
      .PrecoDeVenda(fltPreVen)
      .Margem(fltMargem)
      .DecUni(FDecUni);

  Result :=
    FPrecoCustoFat.
      PrecoCusto.
        CalculaPrecoCusto(LParametrosPrecoCustomargem);
end;


function TParCalculaPrecoCusto.fCalculaPrecoCustoRealVenda(fltPreVen, fltPreCus, fltOutVal,
              fltICMSai, fltImpFed, fltDesOpe, fltDifal, fltFCP: Double; fltTaxaJuros : Double = 0; fltFrete: Double = 0): Double;
Var
  LParametros : IParametrosCalculoPrecoCustoRealVenda;
  LImpostosFederais : Double;
begin
  LImpostosFederais :=  fltImpFed;

  If objConfiguracoes.fGetValorConfiguracao(CFG_DEDUZIR_ICMS_DO_PIS_COFINS_NA_PRECIFICAO, varString) = 'S' Then
  Begin
    If objConfiguracoes.fGetValorConfiguracao(CFG_DEDUZIR_ICMS_PRODUTO_TRIBUTADO_DA_BASE_DE_CALCULO_DO_DEBITO, varString) = 'S' Then
      LImpostosFederais := (LImpostosFederais * (1 - (fltICMSai/100)));
  End
  Else If objConfiguracoes.fGetValorConfiguracao(CFG_DEDUZIR_ICMS_DIFAL_FCP_PRODUTO_TRIBUTADO_DA_BASE_DE_CALCULO_DO_DEBITO, varString) = 'S' Then
  Begin
    LImpostosFederais := (LImpostosFederais * (1 - ((fltICMSai + fltDifal + fltFCP)/100)));
  End;

  LParametros :=
    TParametrosCalculoPrecoCustoRealVenda.New
      .PrecoDeVenda(fltPreVen)
      .PrecoDeCusto(fltPreCus)
      .OutrosValores(fltOutVal)
      .IcmsDeSaida(fltICMSai)
      .ImpostosFederais(LImpostosFederais)
      .DespesasOperacionais(fltDesOpe)
      .AliquotaDoDifal(fltDifal)
      .AliquotaDoFcp(fltFCP)
      .TaxaDeJuros(fltTaxaJuros)
      .ValorFrete(fltFrete);

  Result :=
    FPrecoCustoFat.
      PrecoCusto.
        CalculaPrecoCustoRealVenda(LParametros);
End;


end.

