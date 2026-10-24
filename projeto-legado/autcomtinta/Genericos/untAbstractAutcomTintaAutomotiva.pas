unit untAbstractAutcomTintaAutomotiva;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  Controls, Forms, untDigTintaAutomotiva,
  untPnlBotoesAcoesNovaConsulta, untFuncoesSimples,
{$ENDIF}
  untAbstractAutcomTinta, Uni, SysUtils, Classes,
  untConstantes, untFuncEspecificas, untIFormulaAutomotiva, untTipoTinta;

type
  TFormulaAutomotivaClass = class of TFormulaAutomotiva;

  TAbstractAutcomTintaAutomotiva = class abstract(TAbstractAutcomTinta)
  protected
    procedure GetDesEmb(const stlDesEmb: TStringList); virtual; abstract;
    procedure GetProEmbLt(const stlProEmbLt: TStringList); virtual; abstract;
    procedure GetProEmbGl(const stlProEmbGl: TStringList); virtual; abstract;
    procedure GetProEmbLa(const stlProEmbLa: TStringList); virtual; abstract;
    function GetProEmbCo(): String; virtual; abstract;
    function GetProEmbSp(): String; virtual; abstract;
    function GetProEmbTb(): String; virtual; abstract;
    function GetProEmbBa(): String; virtual; abstract;
    function GetMontadora(const qryTinta: TUniQuery): string; virtual; abstract;
    function GetAno(const qryTinta: TUniQuery): string; virtual; abstract;
    function GetLinha(const qryTinta: TUniQuery): string; virtual; abstract;
    function GetProduto(): string; virtual;
    function GetChaFor(const qryTinta: TUniQuery): string; virtual; abstract;

    function GetNomeCampoBasCodBas(): string; virtual;
    function GetNomeCampoBasCodIte(): string; virtual;
    function GetNomeCampoBasDesBas(): string; virtual;

    function GetIFormulaAutomotiva(): IFormulaAutomotiva; virtual; abstract;
    function GetDescri(const qryTinta: TUniQuery): string; virtual; abstract;
    function GetTipBas(const strCodBas: string): string; virtual;
    {$IFNDEF LINUX}
    function GetfrmDigTinta(): TfrmDigTintaAutomotiva; virtual;
    {$ENDIF}
    function GetTipEmb(tipoEmbalagem: TTipoEmbalagem): string; virtual;
    function GetQtdEmb(tipoEmbalagem: TTipoEmbalagem): Double; virtual;

    function GetVolumeOri(): Double; virtual;
    function GetBlnCatalizador: Boolean; virtual;

    {$IFNDEF LINUX}
    function fDigDadosTintometricos(qryTinta: TUniQuery; stlDesEmb, stlProEmbLt, stlProEmbGl,
      stlProEmbLa: TStringList; strProEmbCo, strProEmbSp, strProEmbBa, strProEmbTb: String; var strIteEmb, strTipEmb, strTipPre: String;
      var intQtdEmb: Integer; var fltPreEmb, fltEmbala, fltPreCus, fltPreVen, fltVolPro: Double; strTabPre: String; var strCatali: String;
      dicRetorno: TDicionario): Boolean; virtual;
    {$ENDIF}

    function fGetQtdBaixa(fltValor: Double; fltVolumePro: Double): Double; override;
    function GetFormulaAutomotiva(const strTabPre: string; const formulaAutomotiva: IFormulaAutomotiva; strIdePro: String; blnRecalcularTabelas: Boolean = True): TFormulaAutomotiva; virtual;

    function fGetAcrescimoMaoObra(strIteTin: String): Double; Virtual;

  public
    function fTipoTinta(): TTipoTinta; override; stdcall;
    procedure pRetItemEDescricaoColorante(strColTinDet: String; var strCodIte, strCodBas, strDesBas: String;
      const strCodEmp: string); override;
    procedure pRetItemColorante(strColTinDet: String; Var strCodIte, strCodBas: String; const strCodEmp: string); override; stdcall;
    function fTravaQuantidadeTinta(strTipEmb: String; fltQtdEmb, fltQtdDig: Double): Boolean; override; stdcall;
    function fTintaBaixaEmbalagem(strTipEmb: String; Var strCodIte: String): Boolean; override; stdcall;
    procedure pTintaRetornaTabelaPreco(dicRetorno: TDicionario; fltFatorAcerto: Double); override; stdcall;
    {$IFNDEF LINUX}
    function fRetornaPreco(Sender: TForm; qryTinta: TUniQuery;  Var dicRetorno: TDicionario;
      blnFaturamento, blnPermiteTab: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil; strMD5Key: String = ''; blnSemTela: Boolean = False): Boolean; override; stdcall;
    {$ENDIF}
    function fRetornaCampoDescricaoColorante(): String; override;
    {$IFNDEF LINUX}
    procedure pTarefaFormulacao(Sender: TObject; frmConsulta: TfrmPnlBotoesAcoesNovaConsulta); override;
    {$ENDIF}
  end;

implementation

uses
  untGenericFormulaAutomotiva, Data.DB,untICalculadorFatVendas;

{ TAbstractAutcomTintaAutomotiva }

{$IFNDEF LINUX}
function TAbstractAutcomTintaAutomotiva.fDigDadosTintometricos(qryTinta: TUniQuery; stlDesEmb, stlProEmbLt, stlProEmbGl,
  stlProEmbLa: TStringList; strProEmbCo, strProEmbSp, strProEmbBa, strProEmbTb: String; var strIteEmb, strTipEmb, strTipPre: String;
  var intQtdEmb: Integer; var fltPreEmb, fltEmbala, fltPreCus, fltPreVen, fltVolPro: Double; strTabPre: String; var strCatali: String;
  dicRetorno: TDicionario): Boolean;
var
  objBase : TBaseAutomotiva;
  objFormula: TFormulaAutomotiva;
  intCont: Integer;
  frmDigTinta: TfrmDigTintaAutomotiva;
  fltPreCu2: Double;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  Result := False;
  objFormula := nil;
  frmDigTinta := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), IcalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;
            
      objFormula := GetFormulaAutomotiva(strTabPre, GetIFormulaAutomotiva, GetIdePro());
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);
      objFormula.strIdePro := IfNull(dicRetorno['idepro'], '');
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.strDescri := GetDescri(qryTinta);
      objFormula.fltVolumeOri := GetIFormulaAutomotiva.GetVolumeOri;

      objFormula.fltAcrMaoObr := qryTinta.FieldByName(fGetNomeCampoAcrescimoMaoObra).AsFloat;

      for intCont := 1 to 20 do
      begin
        if not Assigned(qryTinta.FindField(fGetPrefixoNomeCampoFormulacao() + fStrZero(intCont, 2))) then
          Break;

        If fEmptyStr(qryTinta.FieldByName(fGetPrefixoNomeCampoFormulacao + fStrZero(intCont, 2)).AsString) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := qryTinta.FieldByName(fGetPrefixoNomeCampoFormulacao + fStrZero(intCont, 2)).AsString;

        if Assigned(qryTinta.FindField(fGetPrefixoNomeCampoFormulacaoQuantidade('C') + fStrZero(intCont, 2))) then
          objBase.fltQtdCon := qryTinta.FieldByName(fGetPrefixoNomeCampoFormulacaoQuantidade('C') + fStrZero(intCont, 2)).AsFloat;

        if Assigned(qryTinta.FindField(fGetPrefixoNomeCampoFormulacaoQuantidade('D') + fStrZero(intCont, 2))) then
          objBase.fltQtdDil := qryTinta.FieldByName(fGetPrefixoNomeCampoFormulacaoQuantidade('D') + fStrZero(intCont, 2)).AsFloat;

        if Assigned(qryTinta.FindField(fGetPrefixoNomeCampoFormulacaoQuantidade('D2') + fStrZero(intCont, 2))) then
          objBase.fltQtdDi2 := qryTinta.FieldByName(fGetPrefixoNomeCampoFormulacaoQuantidade('D2') + fStrZero(intCont, 2)).AsFloat;

        objBase.strTipBas := GetTipBas(objBase.strCodBas);
      end;

      objFormula.pCarregaPrecosBases;

      frmDigTinta := GetfrmDigTinta;
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTinta.objFormula := objFormula;
      frmDigTinta.stlDesEmb := stlDesEmb;
      frmDigTinta.stlProEmbLt := stlProEmbLt;
      frmDigTinta.stlProEmbGl := stlProEmbGl;
      frmDigTinta.stlProEmbLa := stlProEmbLa;
      frmDigTinta.strProEmbCo := strProEmbCo;
      frmDigTinta.strProEmbSp := strProEmbSp;
      frmDigTinta.strProEmbTb := strProEmbTb;
      frmDigTinta.strProEmbBa := strProEmbBa;
      frmDigTinta.strIdePro := GetIdePro;
      frmDigTinta.chkComCat.Visible := GetBlnCatalizador;

      if stlProEmbLa.Count > 0 then
        frmDigTinta.strProEmbLa := stlProEmbLa[0];      

      Result := frmDigTinta.ShowModal = mrOk;

      if Result then
      begin
        strIteEmb := frmDigTinta.objFormula.strCodEmb;
        strTipEmb := GetTipEmb(frmDigTinta.objFormula.tpeTipEmb);
        strTipPre := IIF(frmDigTinta.rdgModoVenda.ItemIndex = 0, 'C', 'D');
        intQtdEmb := StrToIntDef(frmDigTinta.edtQtdEmb.Text, 0);
        fltPreEmb := frmDigTinta.objFormula.fltPrecoEmbalagem;
        fltEmbala := GetQtdEmb(frmDigTinta.objFormula.tpeTipEmb);
        fltVolPro := frmDigTinta.objFormula.fltVolumePro;

        If frmDigTinta.rdgModoVenda.ItemIndex = 0 Then
        Begin
          fltPreCus := frmDigTinta.objFormula.fltPrecoCusCon + frmDigTinta.objFormula.fltPrecoCustoEmbalagem;
          fltPreCu2 := frmDigTinta.objFormula.fltPrecoCu2Con + frmDigTinta.objFormula.fltPrecoCusto2Embalagem;
          fltPreVen := frmDigTinta.objFormula.fltPrecoVenCon + frmDigTinta.objFormula.fltPrecoEmbalagem;
          dicRetorno['premed'] := frmDigTinta.objFormula.fltPreMedCon + frmDigTinta.objFormula.fltPrecoMedioEmbalagem;
          dicRetorno['impult'] := frmDigTinta.objFormula.fltImpUltCon + frmDigTinta.objFormula.fltUltimoImpostoEmbalagem;
          dicRetorno['preult'] := frmDigTinta.objFormula.fltPreUltCon + frmDigTinta.objFormula.fltPreUltEmbalagem;
          dicRetorno['prctin'] := frmDigTinta.objFormula.fltComLiqCon + frmDigTinta.objFormula.fltPrecoCompraLiquidoEmbalagem;
        End
        Else
        Begin
          fltPreCus := frmDigTinta.objFormula.fltPrecoCusDil + frmDigTinta.objFormula.fltPrecoCustoEmbalagem;
          fltPreCu2 := frmDigTinta.objFormula.fltPrecoCu2Dil + frmDigTinta.objFormula.fltPrecoCusto2Embalagem;
          fltPreVen := frmDigTinta.objFormula.fltPrecoVenDil + frmDigTinta.objFormula.fltPrecoEmbalagem;
          dicRetorno['premed'] := frmDigTinta.objFormula.fltPreMedDil + frmDigTinta.objFormula.fltPrecoMedioEmbalagem;
          dicRetorno['impult'] := frmDigTinta.objFormula.fltImpUltDil + frmDigTinta.objFormula.fltUltimoImpostoEmbalagem;
          dicRetorno['preult'] := frmDigTinta.objFormula.fltPreUltDil + frmDigTinta.objFormula.fltPreUltEmbalagem;
          dicRetorno['prctin'] := frmDigTinta.objFormula.fltComLiqDil + frmDigTinta.objFormula.fltPrecoCompraLiquidoEmbalagem;
        End;

        dicRetorno['obscolorista']   := frmDigTinta.edtDescricaoColorista.Text;
        dicRetorno['tipoformulacao'] := frmDigTinta.rdgTipoFormula.ItemIndex;

        dicRetorno['precu2'] := fltPreCu2;
        dicRetorno['precus'] := fltPreCus;
        dicRetorno['tippre'] := strTipPre;
        dicRetorno['promoc'] := frmDigTinta.objFormula.StrPromoc;
        dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');
        dicRetorno.AdicionarObjeto('formul', frmDigTinta.matrizSaldosColorantes);
        objFormula.pRecalculaTabelas(strTipPre, dicRetorno);
      end;  
      
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(objFormula) then FreeAndNil(objFormula);
    if Assigned(frmDigTinta) then FreeAndNil(frmDigTinta);
  End;
end;
{$ENDIF}

function TAbstractAutcomTintaAutomotiva.fGetAcrescimoMaoObra(
  strIteTin: String): Double;
var
  qryAcrMob: TUniQuery;
begin
  qryAcrMob := fCriaQuery();
  qryAcrMob.SQL.Text := fGetSqlGTinFor;
  qryAcrMob.ParamByName('ITETIN').AsString := strIteTin;
  qryAcrMob.Open;

  Result := qryAcrMob.FieldByName(fGetNomeCampoAcrescimoMaoObra).AsFloat;
end;

function TAbstractAutcomTintaAutomotiva.fGetQtdBaixa(fltValor, fltVolumePro: Double): Double;
begin
  Result := fltValor * fltVolumePro / GetVolumeOri;
end;

function TAbstractAutcomTintaAutomotiva.fRetornaCampoDescricaoColorante: String;
begin
  Result := 'BAS_DESBAS';
end;

{$IFNDEF LINUX}
function TAbstractAutcomTintaAutomotiva.fRetornaPreco(Sender: TForm; qryTinta: TUniQuery; var dicRetorno: TDicionario;
  blnFaturamento, blnPermiteTab: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil; strMD5Key: String = ''; blnSemTela: Boolean = False): Boolean;
var
  stlDesEmb: TStringList;
  stlProEmbLt: TStringList;
  stlProEmbGl: TStringList;
  stlProEmbLa: TStringList;
  strProEmbCo: String; // Copo
  strProEmbSp: String; // Spray
  strProEmbTb: String; // Tambor
  strProEmbBa: String; // Balde
  strCodEmp: string;
  strOpcDoc: string;
  strTipEmb: string;
  intQtdEmb: Integer;
  strTabPre: string;
  strAuto: string;
  strIteTin: string;
  strIteEmb: string;
  strTipPre: string;
  fltPreEmb: Double;
  fltEmbala: Double;
  fltPreCus: Double;
  fltPreVen: Double;
  fltVolPro: Double;
  strCatali: string;
  strDesCor: string;
//  fltPrcTin: Double;
  fltPrvTin: Double;
  strChaFor: string;
begin
  Result := False;
  stlDesEmb := nil;
  stlProEmbLt := nil;
  stlProEmbGl := nil;
  stlProEmbLa := nil;
  Try
    Try
      stlDesEmb := TStringList.Create;
      stlProEmbLt := TStringList.Create;
      stlProEmbGl := TStringList.Create;
      stlProEmbLa := TStringList.Create;

      strCodEmp    := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      strOpcDoc    := IfNull(dicRetorno['opcdoc'], '');
      strTipEmb    := IfNull(dicRetorno['tipemb'], '');
      intQtdEmb    := IfNull(dicRetorno['qtdemb'], 0);
      strTabPre    := IfNull(dicRetorno['tabpre'], '');

      If strTab = 'N' Then
      Begin
        strAuto := fConsultaTintaVenda(Sender, strCodEmp, qryTinta, blnFaturamento, blnPermiteTab, dicRetorno, sltItems);
        If (strAuto = '-1') Then
        Begin
          Exit;
        End;
      End
      Else
        strAuto := strAutoTab;

      qryTinta.Close;
      qryTinta.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
      qryTinta.Open;

      GetDesEmb(stlDesEmb);
      GetProEmbLt(stlProEmbLt);
      GetProEmbGl(stlProEmbGl);
      GetProEmbLa(stlProEmbLa);

      strProEmbCo := GetProEmbCo;
      strProEmbSp := GetProEmbSp;
      strProEmbTb := GetProEmbTb;
      strProEmbBa := GetProEmbBa;

      strIteTin := GetIteTin(qryTinta);
      strChaFor := GetChaFor(qryTinta);

      dicRetorno['montad'] := GetMontadora(qryTinta);
      dicRetorno['a_n_o_'] := GetAno(qryTinta);
      dicRetorno['linha_'] := GetLinha(qryTinta);

      if not fDigDadosTintometricos(qryTinta,
        stlDesEmb,
        stlProEmbLt,
        stlProEmbGl,
        stlProEmbLa,
        strProEmbCo,
        strProEmbSp,
        strProEmbBa,
        strProEmbTb,
        strIteEmb,
        strTipEmb,
        strTipPre,
        intQtdEmb,
        fltPreEmb,
        fltEmbala,
        fltPreCus,
        fltPreVen,
        fltVolPro,
        strTabPre,
        strCatali,
        dicRetorno) then
        Exit;

      strDesCor := Trim(tinta.fGetDescricao(qryTinta.FieldbyName('AUTOINCREM').AsString));
      dicRetorno['unidad'] := fRetUnidadeItem(strIteEmb);
      
//      fltPrcTin := fltPreCus;
      fltPrvTin := fltPreVen;

      dicRetorno['precus'] := fltPreCus;
      dicRetorno['unitar'] := fltPreVen;
//      dicRetorno['prctin'] := fltPrcTin;
      dicRetorno['prvtin'] := fltPrvTin;
      dicRetorno['codite'] := GetProduto;
      dicRetorno['itetin'] := strIteTin;

      dicRetorno['iteemb'] := strIteEmb;
      dicRetorno['tipemb'] := strTipEmb;
      dicRetorno['qtdemb'] := intQtdEmb;
      dicRetorno['preemb'] := fltPreEmb;
      dicRetorno['tippre'] := strTipPre;
      dicRetorno['embala'] := fltEmbala;
      dicRetorno['descor'] := strDesCor;
      dicRetorno['volpro'] := fltVolPro;
      dicRetorno['chafor'] := strChaFor;
      dicRetorno['catali'] := strCatali;
      dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

      pFormataValores(dicRetorno, fCfgSis('DECUNI', varInteger));      

      Result := True;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
    if Assigned(stlProEmbLa) then FreeAndNil(stlProEmbLa);
  End;
end;
{$ENDIF}

function TAbstractAutcomTintaAutomotiva.fTintaBaixaEmbalagem(strTipEmb: String; var strCodIte: String): Boolean;
begin
  Result := False;
end;

function TAbstractAutcomTintaAutomotiva.fTipoTinta: TTipoTinta;
begin
  Result := ttAutomotiva;
end;

function TAbstractAutcomTintaAutomotiva.fTravaQuantidadeTinta(strTipEmb: String; fltQtdEmb, fltQtdDig: Double): Boolean;
begin
  Result := True;
end;

{$IFNDEF LINUX}
function TAbstractAutcomTintaAutomotiva.GetfrmDigTinta: TfrmDigTintaAutomotiva;
begin
  Result := TfrmDigTintaAutomotiva.Create(nil);
end;
{$ENDIF}

function TAbstractAutcomTintaAutomotiva.GetNomeCampoBasCodBas: string;
begin
  Result := 'BAS_CODBAS';
end;

function TAbstractAutcomTintaAutomotiva.GetNomeCampoBasCodIte: string;
begin
  Result := 'BAS_CODITE';
end;

function TAbstractAutcomTintaAutomotiva.GetNomeCampoBasDesBas: string;
begin
  Result := 'BAS_DESBAS';
end;

function TAbstractAutcomTintaAutomotiva.GetProduto: string;
begin
  Result := conf.fGet('CODPRO');;
end;

function TAbstractAutcomTintaAutomotiva.GetQtdEmb(tipoEmbalagem: TTipoEmbalagem): Double;
begin
  case tipoEmbalagem of
    teLitro: Result := 0.9;
    teGalao: Result := 3.6;
    teCopo: Result := 0.5;
    teSpray: Result := 0.15;
    tePoliester: Result := 0.15;
    teDuco: Result := 0.15;
    teTambor: Result := 200;
    teLata: Result := 18;
    teBalde: Result := 18;
  else
    Result := 0.9;
  end;
end;

function TAbstractAutcomTintaAutomotiva.GetTipBas(const strCodBas: string): string;
begin
  Result := 'B';
end;

function TAbstractAutcomTintaAutomotiva.GetTipEmb(tipoEmbalagem: TTipoEmbalagem): string;
begin
  case tipoEmbalagem of
    teLitro: Result := 'LT';
    teGalao: Result := 'GL';
    teCopo: Result := 'CP';
    teSpray: Result := 'SP';
    tePoliester: Result := 'PO';
    teDuco: Result := 'DC';
    teTambor: Result := 'TB';
    teLata: Result := 'LA';
    teBalde: Result := 'BD';
  end;
end;

function TAbstractAutcomTintaAutomotiva.GetVolumeOri: Double;
begin
  Result := GetIFormulaAutomotiva.GetVolumeOri;
end;

procedure TAbstractAutcomTintaAutomotiva.pRetItemColorante(strColTinDet: String; var strCodIte, strCodBas: String; const strCodEmp: string);
var
  strDesBas: String;
begin
  pRetItemEDescricaoColorante(strColTinDet, strCodIte, strCodBas, strDesBas, strCodEmp);
end;

procedure TAbstractAutcomTintaAutomotiva.pRetItemEDescricaoColorante(strColTinDet: String; var strCodIte, strCodBas, strDesBas: String;
  const strCodEmp: string);
var
  qryGen: TUniQuery;
  stlCampos: TStringList;
begin
  qryGen := nil;
  stlCampos := nil;
  strCodIte := '';
  strCodBas := '';
  strDesBas := '';
  Try
    Try
      stlCampos := TStringList.Create;
      stlCampos.Duplicates := dupIgnore;
      stlCampos.Sorted := True;

      stlCampos.Add(GetNomeCampoBasCodBas);
      stlCampos.Add(GetNomeCampoBasCodIte);
      stlCampos.Add(GetNomeCampoBasDesBas);
      
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                       ' +
        stlCampos.CommaText +
        ' FROM                         ' +
        fRetornaTabelaColoranteTinta +
        ' WHERE ' + GetNomeCampoBasCodBas + ' = :CODBAS   ';
      qryGen.ParamByName('CODBAS').AsString := strColTinDet;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      if not fEmptyStr(GetNomeCampoBasCodBas) then
        strCodBas := qryGen.FieldByName(GetNomeCampoBasCodBas).AsString;

      if not fEmptyStr(GetNomeCampoBasCodIte) then
        strCodIte := qryGen.FieldByName(GetNomeCampoBasCodIte).AsString;

      if not fEmptyStr(GetNomeCampoBasDesBas) then
        strDesBas := qryGen.FieldByName(GetNomeCampoBasDesBas).AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
    if Assigned(stlCampos) then FreeAndNil(stlCampos);
  End;
end;

{$IFNDEF LINUX}
procedure TAbstractAutcomTintaAutomotiva.pTarefaFormulacao(Sender: TObject; frmConsulta: TfrmPnlBotoesAcoesNovaConsulta);
var
  qryGen: TUniQuery;
  dicGen: TDicionario;
  stlDesEmb: TStringList;
  stlProEmbLt: TStringList;
  stlProEmbGl: TStringList;
  stlProEmbLa: TStringList;
  strProEmbCo: String; // Copo
  strProEmbSp: String; // Spray
  strProEmbTb: String; // Tambor
  strProEmbBa: String; // Balde
  strIteTin: string;
  strChaFor: string;
  strIteEmb: string;
  strTipEmb: string;
  strTipPre: string;
  intQtdEmb: Integer;
  fltPreEmb: Double;
  fltEmbala: Double;
  fltPreCus: Double;
  fltPreVen: Double;
  strTabPre: string;
  fltVolPro: Double;
  strCatali: string;
begin
  qryGen := nil;
  dicGen := nil;
  stlDesEmb := nil;
  stlProEmbLt := nil;
  stlProEmbGl := nil;
  stlProEmbLa := nil;
    
  Try
    Try
      If (Not frmConsulta.qryConsulta.Active) Or (frmConsulta.qryConsulta.IsEmpty) Then
        Exit;

      qryGen := fCriaQuery();
      qryGen.SQL.Add('SELECT * FROM ' + tinta.fGetNomeTabela + ' WHERE AUTOINCREM = :AUTINC');
      qryGen.ParamByName('AUTINC').AsString := frmConsulta.qryConsulta.FieldByName('AUTOINCREM').AsString;
      qryGen.Open;

      stlDesEmb := TStringList.Create;
      stlProEmbLt := TStringList.Create;
      stlProEmbGl := TStringList.Create;
      stlProEmbLa := TStringList.Create;

      GetDesEmb(stlDesEmb);
      GetProEmbLt(stlProEmbLt);
      GetProEmbGl(stlProEmbGl);
      GetProEmbLa(stlProEmbLa);

      strProEmbCo := GetProEmbCo;
      strProEmbSp := GetProEmbSp;
      strProEmbTb := GetProEmbTb;
      strProEmbBa := GetProEmbBa;

      strIteTin := GetIteTin(qryGen);
      strChaFor := GetChaFor(qryGen);

      dicGen := TDicionario.Create;

      fDigDadosTintometricos(qryGen,
        stlDesEmb,
        stlProEmbLt,
        stlProEmbGl,
        stlProEmbLa,
        strProEmbCo,
        strProEmbSp,
        strProEmbBa,
        strProEmbTb,
        strIteEmb,
        strTipEmb,
        strTipPre,
        intQtdEmb,
        fltPreEmb,
        fltEmbala,
        fltPreCus,
        fltPreVen,
        fltVolPro,
        strTabPre,
        strCatali,
        dicGen);

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
    if Assigned(dicGen) then FreeAndNil(dicGen);
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
    if Assigned(stlProEmbLa) then FreeAndNil(stlProEmbLa);
  End;
end;
{$ENDIF}

procedure TAbstractAutcomTintaAutomotiva.pTintaRetornaTabelaPreco(dicRetorno: TDicionario; fltFatorAcerto: Double);
var
  strIteTin: String;
  strTabelas: String;
  objFormula: TFormulaAutomotiva;
  objBase: TBaseAutomotiva;
  intContador: Integer;
  calculadorFatVendas: ICalculadorFatVendas;
  strTabelaUnica: String;
begin
  objFormula := nil;
  Try
    Try
      strIteTin := dicRetorno['itetin'];

      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := GetFormulaAutomotiva('1', GetIFormulaAutomotiva, GetIdePro(), False);
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltVolumeOri := GetIFormulaAutomotiva.GetVolumeOri;
      objFormula.fltVolumePro := dicRetorno['volpro'];
      If dicRetorno['tippre'] = 'C' Then
        objFormula.mveModoVenda := mvConcentrado
      Else
        objFormula.mveModoVenda := mvDiluido;
      objFormula.fltFatorAcerto := fltFatorAcerto;
      objFormula.strCodEmb := dicRetorno['iteemb'];
      objFormula.strIdePro := IfNull(dicRetorno['idepro'], '');

      objFormula.fltAcrMaoObr := fGetAcrescimoMaoObra(dicRetorno['itetin']);

      For intContador := 1 To 20 Do
      Begin
        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := dicRetorno['base' + fStrZero(intContador, 2)];
        If dicRetorno['tippre'] = 'C' Then
          objBase.fltQtdCon := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 3) * objFormula.fltVolumeOri / objFormula.fltVolumePro
        Else
          objBase.fltQtdDil := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 3) * objFormula.fltVolumeOri / objFormula.fltVolumePro;
        objBase.strTipBas := 'B';
      End;

      dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

      strTabelaUnica := IfNull(dicRetorno['tabelaunica'], '');

      if not fEmptyStr(strTabelaUnica) then
      begin
        objFormula.strTabPre := strTabelaUnica;
        objFormula.pCarregarColorantes;
        objFormula.pCarregaPrecosBases;
        objFormula.pCalcularPrecos;

        If IfNull(dicRetorno['precus'], 0) <= 0 Then
        Begin
          If dicRetorno['tippre'] = 'C' Then
            dicRetorno['precus'] := objFormula.fltPrecoCusCon + objFormula.fltPrecoCustoEmbalagem
          Else
            dicRetorno['precus'] := objFormula.fltPrecoCusDil + objFormula.fltPrecoCustoEmbalagem;
        End;

        If dicRetorno['tippre'] = 'C' Then
        Begin
          dicRetorno['precu2'] := objFormula.fltPrecoCu2Con + objFormula.fltPrecoCusto2Embalagem;
          dicRetorno['preve' + strTabelaUnica] := objFormula.fltPrecoVenCon + objFormula.fltPrecoEmbalagem;
        End
        Else
        Begin
          dicRetorno['precu2'] := objFormula.fltPrecoCu2Dil + objFormula.fltPrecoCusto2Embalagem;
          dicRetorno['preve' + strTabelaUnica] := objFormula.fltPrecoVenDil + objFormula.fltPrecoEmbalagem;
        End;

        objFormula.pCalculaImpostosSaida(dicRetorno);
        dicRetorno['promoc'] := objFormula.StrPromoc;

        If dicRetorno['tippre'] = 'C' Then
        Begin
          dicRetorno['premed'] := objFormula.fltPreMedCon + objFormula.fltPrecoMedioEmbalagem;
          dicRetorno['impult'] := objFormula.fltImpUltCon + objFormula.fltUltimoImpostoEmbalagem;
          dicRetorno['preult'] := objFormula.fltPreUltCon + objFormula.fltPreUltEmbalagem;
          dicRetorno['prctin'] := objFormula.fltComLiqCon + objFormula.fltPrecoCompraLiquidoEmbalagem;
        End
        Else
        Begin
          dicRetorno['premed'] := objFormula.fltPreMedDil + objFormula.fltPrecoMedioEmbalagem;
          dicRetorno['impult'] := objFormula.fltImpUltDil + objFormula.fltUltimoImpostoEmbalagem;
          dicRetorno['preult'] := objFormula.fltPreUltDil + objFormula.fltPreUltEmbalagem;
          dicRetorno['prctin'] := objFormula.fltComLiqDil + objFormula.fltPrecoCompraLiquidoEmbalagem;
        End;
      end
      else
      begin
        strTabelas := fCfgSis('TABPRC');
        If Length(strTabelas) < 7 Then
          strTabelas := strTabelas + StringOfChar('N',7 - Length(strTabelas));

        For intContador := 1 To Length(strTabelas) Do
        Begin
          if strTabelas[intContador] = 'S' then
          begin

            objFormula.strTabPre := IntToStr(intContador);
            objFormula.pCarregarColorantes;
            objFormula.pCarregaPrecosBases;
            objFormula.pCalcularPrecos;
            If IfNull(dicRetorno['precus'], 0) <= 0 Then
            Begin
              If dicRetorno['tippre'] = 'C' Then
                dicRetorno['precus'] := objFormula.fltPrecoCusCon + objFormula.fltPrecoCustoEmbalagem
              Else
                dicRetorno['precus'] := objFormula.fltPrecoCusDil + objFormula.fltPrecoCustoEmbalagem;
            End;

            If dicRetorno['tippre'] = 'C' Then
            Begin
              dicRetorno['precu2'] := objFormula.fltPrecoCu2Con + objFormula.fltPrecoCusto2Embalagem;
              dicRetorno['premed'] := objFormula.fltPreMedCon + objFormula.fltPrecoMedioEmbalagem;
              dicRetorno['preve' + IntToStr(intContador)] := objFormula.fltPrecoVenCon + objFormula.fltPrecoEmbalagem;
              dicRetorno['impult'] := objFormula.fltImpUltCon + objFormula.fltUltimoImpostoEmbalagem;
              dicRetorno['preult'] := objFormula.fltPreUltCon + objFormula.fltPreUltEmbalagem;
              dicRetorno['prctin'] := objFormula.fltComLiqCon + objFormula.fltPrecoCompraLiquidoEmbalagem;
            End
            Else
            Begin
              dicRetorno['precu2'] := objFormula.fltPrecoCu2Dil + objFormula.fltPrecoCusto2Embalagem;
              dicRetorno['premed'] := objFormula.fltPreMedDil + objFormula.fltPrecoMedioEmbalagem;
              dicRetorno['preve' + IntToStr(intContador)] := objFormula.fltPrecoVenDil + objFormula.fltPrecoEmbalagem;
              dicRetorno['impult'] := objFormula.fltImpUltDil + objFormula.fltUltimoImpostoEmbalagem;
              dicRetorno['preult'] := objFormula.fltPreUltDil + objFormula.fltPreUltEmbalagem;
              dicRetorno['prctin'] := objFormula.fltComLiqDil + objFormula.fltPrecoCompraLiquidoEmbalagem;
            End;

            if intContador = IfNull(dicRetorno['tabpre'], 0) then
            Begin
              objFormula.pCalculaImpostosSaida(dicRetorno);
              dicRetorno['promoc'] := objFormula.StrPromoc;
            End;
          end;
        end;
      end;

      objFormula.pRecalculaTabelas(dicRetorno['tippre'], dicRetorno);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(objFormula) then FreeAndNil(objFormula);
  End;

end;

function TAbstractAutcomTintaAutomotiva.GetBlnCatalizador: Boolean;
begin
  Result := False;
end;

function TAbstractAutcomTintaAutomotiva.GetFormulaAutomotiva(const strTabPre: string;
  const formulaAutomotiva: IFormulaAutomotiva; strIdePro: String; blnRecalcularTabelas: Boolean = True): TFormulaAutomotiva;
begin
  Result := TGenericFormulaAutomotiva.Create(strTabPre, formulaAutomotiva, strIdePro, blnRecalcularTabelas);
end;

end.
