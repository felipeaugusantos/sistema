{************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula ColorPro *}
{*********************************************************************AC*}
unit untFormulaAutomotivaColorPro;

interface

uses
{$IFNDEF LINUX}
  Controls,
  ComCtrls,
  EditFocus,
{$ENDIF}
  untAbstractFormulaAutomotiva, untICalculadorFormulaAutomotiva, untIDataSet, untBaseAutomotiva,
  SysUtils, untStrUtils, Classes, untIConfTinta, untFloatUtils, untModoVenda,
  Math, StrUtils, untIDicionario, untISaldosColorantes, Variants, untVariantUtils;

type
  TFormulaAutomotivaColorPro = class(TAbstractFormulaAutomotiva)
  private
    conf: IConfTinta;

    function fVerificaQuantidadeCamadas(strIteTin: String): Integer;
  protected
    function GetCalculadorInterno(): ICalculadorFormulaAutomotiva; override;
    function GetTextoInformativoCalculo(): String; override;
    procedure CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva); override;
    function GetNomeCampoCustoBase: String; override;
    function GetNomeCampoVendaBase: String; override;
    function GetNomeTabelaBases: String; override;
    function GetNomeCampoBaseCodIte: String; override;
    function GetSelectBases: String; override;
  public
    function GetPrefixoQuantidade(const strModo: String): String; override;
    function GetPrefixoLitragem(const strModo: String): String; override;
    function GetQuantidadeFormulacao(): Integer; override;
    function GetPrefixoFormulacao(): String; override;
    procedure RecalcularTabelasGeneric(dicRetorno: IDicionario); Override;
    function GetDescricao(const dtsCadTin: IDataSet): String; override;
    function GetIdePro: String; override;
    function GetChaveIteTin(const dtsCadTin: IDataSet): string; override;
    procedure PreencheVolumeVenda(const dtsCadTin: IDataSet); override;
    procedure PreencheAcrescimoMaoObra(const dtsCadTin: IDataSet); override;
    function GetCodFormul(const dtsCadTin: IDataSet): string; override;
    function GetIndEmb(const dtsCadTin: IDataSet): integer; override;
    procedure PreencheQuantidadeFormulacaoVenda(const dtsCadTin: IDataSet); override;
    procedure pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet); override;
    function GetVolumePermitido(const dtsCadTin: IDataSet; strTipoPre: String):Double; override;
    function GetVolumePadraSpray: Double; override;
    function GetVolumePadraTambor(dtsCadTin: IDataSet): Double; override;
    function GetVolumePadraCopo : Double;  override;
    function GetVolumePadraoSpraySint : Double; override;

    function fValidaVolumeFormulucao(strTipoPre: String; const dtsCadTin: IDataSet): Boolean; override;

    function GetCalcOutrosValores(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcPrecoMedio(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcIcmsSaida(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcImpostosFederais(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcDespesasOperacionais(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcPrecoCusto(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcPrecoCustoReal(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcPrecoVenda(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcQuantidade(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;

    function GetProdutoVendaTinta(const dtsCadTin: IDataSet): string; override;
    function GetMontadora(const dtsCadTin: IDataSet): string; override;
    function GetAno(const dtsCadTin: IDataSet): string; override;
    function GetAcrescimoDespesaOperacionalTinta: Double; override;
    function GetDescricaoBase(strCodBas: String; strLinha: String): String; Reintroduce;
    function GetFatorEstoque: Double; override;
    procedure pDefineVolumeOriginal; override;
    function GetQualidade(const dtsCadTin: IDataSet): String; override;
    function GetChaFor(const dtsCadTin: IDataSet): String; override;
    function fTipoEmbalagem(intIndEmb: Integer; strQualid: String): Boolean; override;
    function fMostrarComCatalisador: Boolean; override;
    procedure pPreencheListaAdicionalBases; override;

    Constructor Create(const strTabPre: String); override;

    function GetLinha(const dtsCadTin: IDataSet): string; override;

    function fMostrarDil2: Boolean; override;
    function fConsiderarLinhaDesBas: Boolean; override;

    function fRetornaCatalisadorVenda(blnComCat: Boolean; strTipPre, strListaAdicional: String): String; override;
    function GetChaForEspecifico(const dicRetorno: IDicionario; const dtsCadTin: IDataSet): String; override;
    function GetUniversal(const dtsCadTin: IDataSet): string; override;

    function GetSaldos: ISaldosColorantes; override;

  {$IFNDEF LINUX}
    procedure pModoVendaClick(Var edtVolume: TEditFocus; intModoVenda, intListaAdic: Integer); override;
  {$ENDIF}
    function fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer; dtsCadTin: IDataSet): Double; override;
    function fVolumeMaximoSpraySint(fltVolumeMaximoSpraySint: Double): Double; override;

    function fDefine4Por1: Boolean; override;
    function fQuantidadeMenorIgualZero: Boolean; override;

    function fEncontrouNoCadastroDeBases(Base: TBaseAutomotiva): Boolean; override;
    procedure pPreencherPesCorFor(const dtsCadTin: IDataSet); override;

  {$IFNDEF LINUX}
    procedure DefineRegraListaAdicionalChange(var edtVolume: TEditFocus); override;
  {$ENDIF}

  {$IFNDEF LINUX}
    procedure pRecalculaFormulaMostrarPadrao(var lsvFormulacao: TListView;
      Base: TBaseAutomotiva; intDecimaisPrecoVenda, intDecimaisPesoEspecifico: Integer;
      blnConsLinhaDesBas: Boolean; strTipBas: String; intCont: Integer); override;
  {$ENDIF}

  {$IFNDEF LINUX}
    procedure pRecalculaFormulaMostrarDigitado(var lsvFormulacao: TListView;
      Base: TBaseAutomotiva; intDecimaisPrecoVenda, intDecimaisPesoEspecifico: Integer;
      fltFator: Double; blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha: String;
      strTipBas: String); override;
  {$ENDIF}

    function fCalculoA(Formula: TAbstractFormulaAutomotiva;
      strConDil: String; idxBase: Integer; strLinha: String): Double; override;

    function fCalculoB(Formula: TAbstractFormulaAutomotiva;
      strConDil: String; idxBase: Integer; strLinha: String): Double; override;

    function fCalculoBLinha08(Formula: TAbstractFormulaAutomotiva; strConDil: String;
      idxBase: Integer): Double; override;

    function fCalculoC(Formula: TAbstractFormulaAutomotiva; idxBase: Integer): Double; override;


    function fDefinirPadraoDiluido : Boolean; override;

    procedure pRetornaInfoLinha(strLinha: String; Var strLinDil, strBasDil: String;
      Var fltFatBas, fltPerDil: Double; strConDil: String); override;

    function GetVolumeMaximoLitro(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoGalao(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoLata(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoCopo(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoSpray(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoSpraySint(dtsCadTin: IDataSet): Double; Override;

    function GetVolumePadraoLata(dtsCadTin: IDataSet): Double; override;
    function GetVolumePadraGalao(dtsCadTin: IDataSet): Double;  override;

    function fExisteConfiguracao(dtsCadTin: IDataSet; strEmbalagem: String): Boolean; Override;
    function fRetEmbLitro(dtsCadTin: IDataSet): String;
    function fRetEmbGalao(dtsCadTin: IDataSet): String;
    function fRetEmbLata(dtsCadTin: IDataSet): String;

    function fGetCamada(dtsCadTin: IDataSet): String; Override;
    procedure CarregaPrecosBases; Override;


  end;

implementation

uses
  untCalculadorFormulaAutomotivaColorPro, untAutcomTintaFactory,
  untGenericSaldosColorantes;

{ TFormulaAutomotivaColorPro }

procedure TFormulaAutomotivaColorPro.CarregaPrecosBases;
var
  intContador: Integer;
  Base: TBaseAutomotiva;
  fltPreCus: Double;
  fltPreVen: Double;
  fltDesOpeTinta: Double;
  strCodEmpresa : String;
  blnEmPromo: Boolean;
  blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
begin
  fltDesOpeTinta := TAutcomTintaFactory.Get().fGetConfTinta(GetIdePro).fGetDouble('DESOPE');

  strCodEmpresa := fVerificaEmpresaSetada();

  Self.pPreencheListaAdicionalBases;

  For intContador := 0 To Self.Count-1 Do
  Begin
    Base := TBaseAutomotiva(Self.Items[intContador]);
    If GetDataSetBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([Base.CodigoBase, Base.LinhaBase]), []) Then
    Begin
      Base.OutrosValores             := GetDataSetBases.FieldByName('ITE_OUTVAL').AsFloat;
      Base.CodIte                    := GetDataSetBases.FieldByName('BAS_CODITE').AsString;
      Base.ImpDir                    := GetDataSetBases.FieldByName('ITE_IMPDIR').AsString;

      If TAutcomTintaFactory.Get.fCfgSis('IMPCF4', varBoolean) And Assigned(calculadorFatVendas) Then
        Base.IcmsSaida               := calculadorFatVendas.fCalculaAliquota(Base.CodIte, Base.ImpDir)
      Else
        Base.IcmsSaida               := GetDataSetBases.FieldByName('ITE_ICMSAI').AsFloat;

      Base.ImpostosFederais          := GetDataSetBases.FieldByName('ITE_IMPFED').AsFloat;
      Base.DespesasOperacionais      := GetDataSetBases.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;

      Base.PrecoMedio                := GetDataSetBases.FieldByName('ITE_PREMED').AsFloat;
      Base.UltimoPrecoCompra         := GetDataSetBases.FieldByName('ITE_PREULT').AsFloat;
      Base.UltimoPrecoCompraImpostos := GetDataSetBases.FieldByName('ITE_IMPULT').AsFloat;
      Base.PrecoCompraLiquido        := TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fCalculaPrecoCompraLiq(
                                                                                     GetDataSetBases.Fieldbyname('ITE_PRECOM').AsFloat, GetDataSetBases.Fieldbyname('ITE_DESF01').AsFloat,
                                                                                     GetDataSetBases.Fieldbyname('ITE_DESF02').AsFloat, GetDataSetBases.Fieldbyname('ITE_DESF03').AsFloat,
                                                                                     GetDataSetBases.Fieldbyname('ITE_DESF04').AsFloat, GetDataSetBases.Fieldbyname('ITE_DESF05').AsFloat,
                                                                                     GetDataSetBases.Fieldbyname('ITE_DESF06').AsFloat), TAutcomTintaFactory.Get.fCfgSis('DECUNI', VarInteger));

      Base.Embalagem                 := GetDataSetBases.FieldByName('BAS_EMBALA').AsFloat;
      Base.PesoEspecifico            := GetDataSetBases.FieldByName('BAS_PESESP').AsFloat;
      Base.PesGra                    := GetBasPesGra(GetDataSetBases);

      blnEmPromo := TAutcomTintaFactory.Get.fCarregaPromocao(GetDataSetBases.FieldByName('BAS_CODITE').AsString,
                                                             strTabPre, Self.strCodCli, Self.strCodCnd, Self.intPrzMed,
                                                             fltPreCus, fltPreVen, blnPrecoFixoParaTintaDeMaquinaImobiliaria, strCodEmpresa);
      If (blnEmPromo) And (Not Self.blnProPre) Then
      Begin
        Base.PrecoCusto := fltPreCus;
        Base.PrecoVenda := fltPreVen;

        If strTabPre = strTabPreTin Then
          Self.Promoc := 'S';

        if Base.PrecoCusto = 0 Then
          Base.PrecoCusto := GetDataSetBases.FieldByName('ITE_PRECUS').AsFloat;
      End
      Else
      Begin
        Base.PrecoCusto := GetDataSetBases.FieldByName('ITE_PRECUS').AsFloat;
        Base.PrecoVenda := GetDataSetBases.FieldByName('ITE_PREVEN').AsFloat;

        If (Self.blnProPre) And (blnEmPromo) And (strTabPre = strTabPreTin) Then
          Self.Promoc := 'S';
      End;
      CarregaPrecosColorantesAdicional(GetDataSetBases, Base);
    End;
  End;

  TextoInformativoCalculo.Text := GetTextoInformativoCalculo;
end;

procedure TFormulaAutomotivaColorPro.CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva);
begin
  Base.Cnv_Ml := Base.Embalagem * Base.PesoEspecifico;
end;

constructor TFormulaAutomotivaColorPro.Create(const strTabPre: String);
begin
  inherited Create(strTabPre);
  Self.blnDadosAdicionais  := True;
  Self.strCaptionAdicional := 'Catálise';
  Self.blnAdicionalDiluido := True;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('WCP');
end;

{$IFNDEF LINUX}
procedure TFormulaAutomotivaColorPro.DefineRegraListaAdicionalChange(
  var edtVolume: TEditFocus);
begin
  Self.VolumePro := TAutcomTintaFactory.Get.fStrToFloat(FormatFloat('#,###0.000', Self.VolumeOri));
  edtVolume.Text := FormatFloat('#,###0.000', Self.VolumeOri);
end;
{$ENDIF}

function TFormulaAutomotivaColorPro.fCalculoA(
  Formula: TAbstractFormulaAutomotiva; strConDil: String; idxBase: Integer;
  strLinha: String): Double;
Var
  intCont: Integer;

  arrX: Array[0..19] Of Double;
  arrW: Array[0..19] Of Double;
  arrY: Array[0..19] Of Double;
  arrT: Array[0..19] Of Double;
  fltSomaW: Double;

  fltDilui: Double;
  strLinDil: String;
  strCodDil: String;
  fltFatBas: Double;

  Base: TBaseAutomotiva;
begin
  pRetornaInfoLinha(strLinha, strLinDil, strCodDil, fltFatBas, fltDilui, strConDil);

  fltSomaW := 0.0;
  For intCont := 0 To 19 Do
  Begin
    arrX[intCont] := 0.0;
    arrW[intCont] := 0.0;
    arrY[intCont] := 0.0;
    arrT[intCont] := 0.0;
  End;

  For intCont := 0 To Formula.Count -1 Do
  Begin
    Base := TBaseAutomotiva(Formula.Items[intCont]);

    If (Base.TipoBase = 'C') And (Not Formula.ComCatalisador) Then
      Continue;

    If strConDil = 'DIL' Then
    Begin
      If (Base.LinhaBase = strLinDil) And (Base.CodigoBase = strCodDil) Then
        arrX[intCont] := fltDilui
      Else
        arrX[intCont] := Base.Porcen * (100 - fltDilui) / 100;
    End
    Else If strConDil = 'CON' Then
    Begin
      If (Base.LinhaBase = strLinDil) And (Base.CodigoBase = strCodDil) Then
        arrX[intCont] := 0
      Else
        arrX[intCont] := Base.Porcen;
    End;

    arrW[intCont] := arrX[intCont] / Base.PesoEspecifico;
    fltSomaW := fltSomaW + arrW[intCont];
  End;

  If fltSomaW = 0 Then
  Begin
    Result := 0;
    Exit;
  End;

  For intCont := 0 To Formula.Count -1 Do
  Begin
    Base := TBaseAutomotiva(Formula.Items[intCont]);

    If (Base.TipoBase = 'C') And (Not Formula.ComCatalisador) Then
      Continue;

    arrY[intCont] := (Formula.VolumePro * 1000 * arrW[intCont]) / fltSomaW;
    arrT[intCont] := RoundTo(arrY[intCont] * Base.PesoEspecifico,-1);
  End;

  Result := arrT[idxBase];
end;

function TFormulaAutomotivaColorPro.fCalculoB(
  Formula: TAbstractFormulaAutomotiva; strConDil: String; idxBase: Integer;
  strLinha: String): Double;
Var
  intCont: Integer;

  arrX: Array[0..19] Of Double;
  arrW: Array[0..19] Of Double;
  arrY: Array[0..19] Of Double;
  arrT: Array[0..19] Of Double;
  fltSomaW: Double;
  fltDilui: Double;
  strLinDil: String;
  strCodDil: String;
  fltFatBas: Double;
  fltThinner: Double;
  fltTinta: Double;
  Base:TBaseAutomotiva;
begin
  For intCont := 0 To 19 Do
  Begin
    arrX[intCont] := 0.0;
    arrW[intCont] := 0.0;
    arrY[intCont] := 0.0;
    arrT[intCont] := 0.0;
  End;

  fltSomaW := 0.0;
  For intCont := 0 To Formula.Count -1 Do
  Begin
    Base := TBaseAutomotiva(Formula.Items[intCont]);

    If (Base.TipoBase = 'C') And (Not Formula.ComCatalisador) Then
      Continue;

    {*******************************************}
    {* CATÁLISE 2:1                            *}
    {****************************************NC*}
    If strConDil = 'DIL' Then
    Begin
      pRetornaInfoLinha(strLinha, strLinDil, strCodDil, fltFatBas, fltDilui, strConDil);

      If (Pos(TStrUtils.fStrZero(strLinha, 2), '13_') > 0) Then
      Begin
        fltTinta   := (Formula.VolumePro * 1000) / 1.10;
        fltThinner := (fltDilui * fltTinta) / 100;
        If (Base.LinhaBase = strLinDil) And (Base.CodigoBase = strCodDil) Then
          arrX[intCont] := fltThinner
        Else
          arrX[intCont] := fltTinta;
      End
      Else If (Pos(TStrUtils.fStrZero(strLinha, 2), '58_') > 0) Then
      Begin
        arrX[intCont] := 0;
      End;
    End
    {*******************************************}
    {* CATÁLISE 4:1                            *}
    {****************************************NC*}
    Else If strConDil = 'DI2' Then
    Begin
      pRetornaInfoLinha(strLinha, strLinDil, strCodDil, fltFatBas, fltDilui, strConDil);

      If (Pos(TStrUtils.fStrZero(strLinha, 2), '58') > 0) Then
      Begin
        fltThinner := (fltDilui * (Formula.VolumePro * 1000)) / 100;
        If (Base.LinhaBase = strLinDil) And (Base.CodigoBase = strCodDil) Then
          arrX[intCont] := fltThinner
        Else
          arrX[intCont] := (Formula.VolumePro * 1000) - fltThinner;
      End
      Else  If (Pos(TStrUtils.fStrZero(strLinha, 2), '13_') > 0) Then
      Begin
        fltTinta   := (Formula.VolumePro * 1000) / 1.25;
        fltThinner := (fltDilui * fltTinta) / 100;
        If (Base.LinhaBase = strLinDil) And (Base.CodigoBase = strCodDil) Then
          arrX[intCont] := fltThinner
        Else
          arrX[intCont] := fltTinta;
      End;
    End
    {*******************************************}
    {* CATÁLISE 9:2                            *}
    {****************************************RG*}
    Else If strConDil = 'DI9_2' Then
    Begin
      pRetornaInfoLinha(strLinha, strLinDil, strCodDil, fltFatBas, fltDilui, strConDil);

      fltTinta := (Formula.VolumePro * 1000) / 1.11;
      fltThinner := (fltDilui * fltTinta) / 100;
      If (Base.LinhaBase = strLinDil) And (Base.CodigoBase = strCodDil) Then
        arrX[intCont] := fltThinner
      Else
        arrX[intCont] := fltTinta;
    End
    {*******************************************}
    {* CONCENTRADO                             *}
    {****************************************NC*}
    Else If strConDil = 'CON' Then
    Begin
      pRetornaInfoLinha(strLinha, strLinDil, strCodDil, fltFatBas, fltDilui, strConDil);

      If (Base.LinhaBase = strLinDil) And (Base.CodigoBase = strCodDil) Then
        arrX[intCont] := 0
      Else
        arrX[intCont] := Formula.VolumePro * 1000;
    End;

    arrW[intCont] := Base.Porcen / Base.PesoEspecifico;
    fltSomaW := fltSomaW + arrW[intCont];
  End;

  If fltSomaW = 0 Then
  Begin
    Result := 0;
    Exit;
  End;

  For intCont := 0 To Formula.Count -1 Do
  Begin
    Base := TBaseAutomotiva(Formula.Items[intCont]);

    If (Base.TipoBase = 'C') And (Not Formula.ComCatalisador) Then
      Continue;

    If (Base.LinhaBase = strLinDil) And (Base.CodigoBase = strCodDil) Then
      arrY[intCont] := arrX[intCont]
    Else
      arrY[intCont] := arrX[intCont] * arrW[intCont] / fltSomaW;

    arrT[intCont] := RoundTo(arrY[intCont] * Base.PesoEspecifico,-1);
  End;

  Result := arrT[idxBase];
end;

function TFormulaAutomotivaColorPro.fCalculoBLinha08(
  Formula: TAbstractFormulaAutomotiva; strConDil: String;
  idxBase: Integer): Double;
Var
  intCont: Integer;

  arrX: Array[0..19] Of Double;
  arrW: Array[0..19] Of Double;
  arrY: Array[0..19] Of Double;
  arrT: Array[0..19] Of Double;
  fltSomaW: Double;
  fltDilui: Double;
  strLinDil: String;
  strCodDil: String;
  fltFatBas: Double;
  fltThinner: Double;
  fltTinta: Double;
  Base:TBaseAutomotiva;
begin
  For intCont := 0 To 19 Do
  Begin
    arrX[intCont] := 0.0;
    arrW[intCont] := 0.0;
    arrY[intCont] := 0.0;
    arrT[intCont] := 0.0;
  End;

  fltSomaW := 0.0;
  For intCont := 0 To Formula.Count -1 Do
  Begin
    Base := TBaseAutomotiva(Formula.Items[intCont]);

    If (Base.TipoBase = 'C') And (Not Formula.ComCatalisador) Then
      Continue;

    {*******************************************}
    {* CATÁLISE 2:1                            *}
    {****************************************NC*}
    If strConDil = 'DIL' Then
    Begin
      pRetornaInfoLinha('8', strLinDil, strCodDil, fltFatBas, fltDilui, strConDil);

      fltTinta   := (Formula.VolumePro * 1000) / 0.8205666;
      fltThinner := (fltDilui * fltTinta) / 100;
      fltTinta   := (Formula.VolumePro * 1000) - fltThinner;

      If (Base.LinhaBase = strLinDil) And (Base.CodigoBase = strCodDil) Then
        arrX[intCont] := fltThinner
      Else
        arrX[intCont] := fltTinta;
    End
    {*******************************************}
    {* CATÁLISE 4:1                            *}
    {****************************************NC*}
    Else If strConDil = 'DI2' Then
    Begin
      pRetornaInfoLinha('8', strLinDil, strCodDil, fltFatBas, fltDilui, strConDil);

      fltThinner := (fltDilui * (Formula.VolumePro * 1000)) / 100;
      fltTinta   := (Formula.VolumePro * 1000) - fltThinner;

      If (Base.LinhaBase = strLinDil) And (Base.CodigoBase = strCodDil) Then
        arrX[intCont] := fltThinner
      Else
        arrX[intCont] := fltTinta;
    End
    {*******************************************}
    {* CONCENTRADO                             *}
    {****************************************NC*}
    Else If strConDil = 'CON' Then
    Begin
      pRetornaInfoLinha('8', strLinDil, strCodDil, fltFatBas, fltDilui, strConDil);

      If (Base.LinhaBase = strLinDil) And (Base.CodigoBase = strCodDil) Then
        arrX[intCont] := 0
      Else
        arrX[intCont] := Formula.VolumePro * 1000;
    End;

    arrW[intCont] := Base.Porcen / Base.PesoEspecifico;
    fltSomaW := fltSomaW + arrW[intCont];
  End;

  If fltSomaW = 0 Then
  Begin
    Result := 0;
    Exit;
  End;

  For intCont := 0 To Formula.Count -1 Do
  Begin
    Base := TBaseAutomotiva(Formula.Items[intCont]);

    If (Base.TipoBase = 'C') And (Not Formula.ComCatalisador) Then
      Continue;

    If (Base.LinhaBase = strLinDil) And (Base.CodigoBase = strCodDil) Then
      arrY[intCont] := arrX[intCont]
    Else
      arrY[intCont] := arrX[intCont] * arrW[intCont] / fltSomaW;

    arrT[intCont] := RoundTo(arrY[intCont] * Base.PesoEspecifico,-1);
  End;

  Result := arrT[idxBase];
end;

function TFormulaAutomotivaColorPro.fCalculoC(
  Formula: TAbstractFormulaAutomotiva; idxBase: Integer): Double;
Var
  intCont: Integer;
  arrR: Array[0..19] Of Double;
  arrW: Array[0..19] Of Double;
  arrY: Array[0..19] Of Double;
  arrT: Array[0..19] Of Double;
  fltSomaW: Double;
  Base:TBaseAutomotiva;
begin
  fltSomaW := 0.0;
  For intCont := 0 To 19 Do
  Begin
    arrR[intCont] := 0.0;
    arrW[intCont] := 0.0;
    arrY[intCont] := 0.0;
    arrT[intCont] := 0.0;
  End;

  For intCont := 0 To Formula.Count -1 Do
  Begin
    Base := TBaseAutomotiva(Formula.Items[intCont]);

    If (Base.TipoBase = 'C') And (Not Formula.ComCatalisador) Then
      Continue;

    If Base.CodigoBase = 'QR080' Then
      arrR[intCont] := 0
    Else
      arrR[intCont] := (Base.Porcen * 100) / (100 - 23);

    arrW[intCont] := arrR[intCont] / Base.PesoEspecifico;
    fltSomaW := fltSomaW + arrW[intCont];
  End;

  For intCont := 0 To Formula.Count -1 Do
  Begin
    Base := TBaseAutomotiva(Formula.Items[intCont]);

    If (Base.TipoBase = 'C') And (Not Formula.ComCatalisador) Then
      Continue;

    If Base.CodigoBase = 'Q080' Then
      arrY[intCont] := Formula.VolumePro * 1000 / 2
    Else
      arrY[intCont] := ((Formula.VolumePro * 1000 / 2) * arrW[intCont]) / fltSomaW;

    arrT[intCont] := RoundTo(arrY[intCont] * Base.PesoEspecifico,-1);
  End;

  Result := arrT[idxBase];
end;

function TFormulaAutomotivaColorPro.fConsiderarLinhaDesBas: Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaColorPro.fDefine4Por1: Boolean;
var
  Base: TBaseAutomotiva;
begin
  Result := False;
{$IFNDEF LINUX}
  Base := TBaseAutomotiva(Self.Items[0]);

  If (Pos(TStrUtils.fStrZero(Base.LinhaBase,3), '008_058_059_013_072_') > 0) And (Self.mveModoVenda = mvDiluido) Then
  Begin
    {***************************************************}
    {* CASO ESCOLHEU 4 POR 1 NO DILUIDO                *}
    {** 15/07/2008 - 08:46 **************************MV*}
    {********************************************}
    {* QUANDO LINHA 8 OPODE ESCOLHER 2:1 OU 4:1 *}
    {*****************************************PH*}
    If Base.LinhaBase = '8' Then
    Begin
      Result := (Self.intIndiceAdicional = 1);
    End
    Else If Base.LinhaBase = '13' Then
    Begin
      Result := (Self.intIndiceAdicional = 1);
    End
    {*******************************************************}
    {* QUANDO LINHA 72 SOMENTE 9:2 (UNICO ITEM NA COMBOBOX)*}
    {****************************************************RG*}
    Else If Base.LinhaBase = '72' Then
    Begin
      Result := False;
    End
    Else
    Begin
      {*******************************************************}
      {* QUANDO LINHA 58 SOMENTE 4:1 (UNICO ITEM NA COMBOBOX)*}
      {****************************************************PH*}
      Result := (Self.intIndiceAdicional = 0);
    End;
  End;
{$ELSE}
  Result := (Self.DilLinux = '4:1');
{$ENDIF}
end;

function TFormulaAutomotivaColorPro.fDefinirPadraoDiluido: Boolean;
begin
  Result := true;
end;

function TFormulaAutomotivaColorPro.fEncontrouNoCadastroDeBases(
  Base: TBaseAutomotiva): Boolean;
begin
  Result := GetDataSetBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([Base.CodigoBase, Base.LinhaBase]), []);
end;

function TFormulaAutomotivaColorPro.fExisteConfiguracao(dtsCadTin: IDataSet;
  strEmbalagem: String): Boolean;
Var
  qryConf: IDataSet;
begin
  Try
    qryConf := TAutcomTintaFactory.Get.fGetDataSet;
    qryConf.Close;
    qryConf.SQL := '';
    qryConf.SQL := qryConf.SQL + '  SELECT                ';
    qryConf.SQL := qryConf.SQL + '    *                   ';
    qryConf.SQL := qryConf.SQL + '  FROM                  ';
    qryConf.SQL := qryConf.SQL + '    CFGTIN              ';
    qryConf.SQL := qryConf.SQL + '  WHERE                 ';
    qryConf.SQL := qryConf.SQL + '    CFG_IDEPRO = "WCP" AND          ';
    qryConf.SQL := qryConf.SQL + '    CFG_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" AND          ';

    If strEmbalagem = 'Litro' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "' + fRetEmbLitro(dtsCadTin) + '"      '
    Else If strEmbalagem = 'Galão' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "' + fRetEmbGalao(dtsCadTin) + '"      '
    Else If strEmbalagem = 'Lata' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "' + fRetEmbLata(dtsCadTin) + '"       '
    Else If strEmbalagem = 'Copo' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLICO"       '
    Else If strEmbalagem = 'Spray' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLISP"       '
    Else If strEmbalagem = 'Spray Sint' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLISS"       ';

    qryConf.Open;

    Result := (Not qryConf.IsEmpty);
  Except
    Raise;
  End;
end;

function TFormulaAutomotivaColorPro.fGetCamada(dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('WAN_CAMADA').AsString;
end;

function TFormulaAutomotivaColorPro.fMostrarComCatalisador: Boolean;
begin
  Result := False;
end;

function TFormulaAutomotivaColorPro.fMostrarDil2: Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaColorPro.fQuantidadeMenorIgualZero: Boolean;
begin
  Result := False;
end;

function TFormulaAutomotivaColorPro.fRetEmbGalao(dtsCadTin: IDataSet): String;
begin
  Result := '';

  Case AnsiIndexStr(dtsCadTin.FieldByName('WAN_LINHA_').AsString,
    [ '1', '4', '6', '8', '9', '11', '12', '13', '14', '15', '16', '17', '19',
      '27', '58', '59', '67', '72', '74', '75', '76']) Of
    0 :  Begin
           Result := 'VOPLGL';
         End;
    1 :  Begin
           Result := 'VOHSGL';
         End;
    2 :  Begin
           Result := 'VOLAGL';
         End;
    3 :  Begin
           Result := 'VOPUGL';
         End;
    4 :  Begin
           Result := 'VOWCGL';
         End;
    5 :  Begin
           Result := 'VOSSGL';
         End;
    6 :  Begin
           Result := 'VOAPGL';
         End;
    7 :  Begin
           Result := 'VOBTGL';
         End;
    8 :  Begin
           Result := 'VOABGL';
         End;
    9 :  Begin
           Result := 'VO11GL';
         End;
   10 :  Begin
           Result := 'VO12GL';
         End;
   11 :  Begin
           Result := 'VO13GL';
         End;
   12 :  Begin
           Result := 'VOBLGL';
         End;
   13 :  Begin
           Result := 'VOMMGL';
         End;
   14 :  Begin
           Result := 'VOMSGL';
         End;
   15 :  Begin
           Result := 'VO90GL';
         End;
   16 :  Begin
           Result := 'VOLMMG';
         End;
   17 :  Begin
           Result := 'VOTFGL';
         End;
   18 :  Begin
           Result := 'VOFEGL';
         End;
   19 :  Begin
           Result := 'VOFSGL';
         End;
   20 :  Begin
           Result := 'VOFLGL';
         End;
  End;
end;

function TFormulaAutomotivaColorPro.fRetEmbLata(dtsCadTin: IDataSet): String;
begin
  Result := '';

  Case AnsiIndexStr(dtsCadTin.FieldByName('WAN_LINHA_').AsString,
    [ '1', '4', '6', '8', '9', '11', '12', '13', '14', '15', '16', '17', '19',
      '27', '58', '59', '67', '72', '74', '75', '76']) Of
    0 :  Begin
           Result := 'VOPLLA';
         End;
    1 :  Begin
           Result := 'VOHSLA';
         End;
    2 :  Begin
           Result := 'VOLALA';
         End;
    3 :  Begin
           Result := 'VOPULA';
         End;
    4 :  Begin
           Result := 'VOWCLA';
         End;
    5 :  Begin
           Result := 'VOSSLA';
         End;
    6 :  Begin
           Result := 'VOAPLA';
         End;
    7 :  Begin
           Result := 'VOBTLA';
         End;
    8 :  Begin
           Result := 'VOABLA';
         End;
    9 :  Begin
           Result := 'VO11LA';
         End;
   10 :  Begin
           Result := 'VO12LA';
         End;
   11 :  Begin
           Result := 'VO13LA';
         End;
   12 :  Begin
           Result := 'VOBLLA';
         End;
   13 :  Begin
           Result := 'VOMMLA';
         End;
   14 :  Begin
           Result := 'VOMSLA';
         End;
   15 :  Begin
           Result := 'VO90LA';
         End;
   16 :  Begin
           Result := 'VOLMMA'
         End;
   17 :  Begin
           Result := 'VOTFLA';
         End;
   18 :  Begin
           Result := 'VOFELA';
         End;
   19 :  Begin
           Result := 'VOFSLA';
         End;
   20 :  Begin
           Result := 'VOFLLA';
         End;
  End;
end;

function TFormulaAutomotivaColorPro.fRetEmbLitro(dtsCadTin: IDataSet): String;
begin
  Result := '';

  Case AnsiIndexStr(dtsCadTin.FieldByName('WAN_LINHA_').AsString,
    [ '1', '4', '6', '8', '9', '11', '12', '13', '14', '15', '16', '17', '19',
      '27', '58', '59', '67', '72', '74', '75', '76']) Of
    0 :  Begin
           Result := 'VOPLLT';
         End;
    1 :  Begin
           Result := 'VOHSLT';
         End;
    2 :  Begin
           Result := 'VOLALT';
         End;
    3 :  Begin
           Result := 'VOPULT';
         End;
    4 :  Begin
           Result := 'VOWCLT';
         End;
    5 :  Begin
           Result := 'VOSSLT';
         End;
    6 :  Begin
           Result := 'VOAPLT';
         End;
    7 :  Begin
           Result := 'VOBTLT';
         End;
    8 :  Begin
           Result := 'VOABLT';
         End;
    9 :  Begin
           Result := 'VO11LT';
         End;
   10 :  Begin
           Result := 'VO12LT';
         End;
   11 :  Begin
           Result := 'VO13LT';
         End;
   12 :  Begin
           Result := 'VOBLLT';
         End;
   13 :  Begin
           Result := 'VOMMLT';
         End;
   14 :  Begin
           Result := 'VOMSLT';
         End;
   15 :  Begin
           Result := 'VO90LT';
         End;
   16 :  Begin
           Result := 'VOLMML';
         End;
   17 :  Begin
           Result := 'VOTFLT';
         End;
   18 :  Begin
           Result := 'VOFELT';
         End;
   19 :  Begin
           Result := 'VOFSLT';
         End;
   20 :  Begin
           Result := 'VOFLLT';
         End;
  End;
end;

function TFormulaAutomotivaColorPro.fRetornaCatalisadorVenda(blnComCat: Boolean;
  strTipPre, strListaAdicional: String): String;
begin
  Result := '';
  If (strTipPre = 'D')  Then
  Begin
    Result := strListaAdicional;
    If TStrUtils.fEmptyStr(Result)  Then
      Result := '2:1';
  End;
end;

function TFormulaAutomotivaColorPro.fTipoEmbalagem(intIndEmb: Integer;
  strQualid: String): Boolean;
begin
  Result := ((intIndEmb = 0) And (strQualid = 'BP')) Or (intIndEmb = 4);
end;

function TFormulaAutomotivaColorPro.fValidaVolumeFormulucao(strTipoPre: String;
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaColorPro.fVerificaQuantidadeCamadas(
  strIteTin: String): Integer;
Var
  qryGen: IDataSet;
  qryGen2: IDataSet;
begin
  Result := 0;

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := 'SELECT *             ' +
                '  FROM WANPRO_CADWAN ' +
                ' WHERE WAN_MD5KEY = :ITETIN ';
  qryGen.ParamByName('ITETIN').AsString := strIteTin;
  qryGen.Open;

  if qryGen.IsEmpty then
  begin
    qryGen.Close;
    qryGen.SQL := 'SELECT ' +
                  '  *    ' +
                  'FROM   ' +
                  '  WANPRO_CADWAN ' +
                  'WHERE  ' +
                  ' 	 UPPER(CAST(MD5(CONCAT(IFNULL(WAN_LINHA_, ""), IFNULL(WAN_CODAKZ, ""), ' +
                  ' 	  		                 IFNULL(WAN_ALTERN, ""), IFNULL(WAN_MONTAD, ""), ' +
                  ' 		                     IFNULL(WAN_CAMADA, ""))) AS CHAR)) = :ITETIN    ';
    qryGen.ParamByName('ITETIN').AsString := strIteTin;
    qryGen.Open;

    if qryGen.IsEmpty then
      Exit;
  end;

  qryGen2 := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen2.Close;
  qryGen2.SQL := ' SELECT SQL_NO_CACHE ' +
                 '     COUNT(*)    QTD ' +
                 '  FROM WANPRO_CADWAN ' +
                 ' WHERE WAN_CAMADA IS NOT NULL ' +
                 '   AND WAN_LINHA_ = :LINHA_   ' +
                 '   AND WAN_CODAKZ = :CODAKZ   ' +
                 '   AND WAN_ALTERN = :ALTERN   ' +
                 '   AND WAN_DESCRI = :DESCRI   ' +
                 '   AND WAN_MONTAD = :MONTAD   ' +
                 '   AND WAN_VERCOR = :VERCOR   ' +
                 '   AND WAN_ANOINI = :ANOINI   ' +
                 '   AND WAN_ANOFIN = :ANOFIN   ';

  qryGen2.ParamByName('LINHA_').AsString := qryGen.FieldByName('WAN_LINHA_').AsString;
  qryGen2.ParamByName('CODAKZ').AsString := qryGen.FieldByName('WAN_CODAKZ').AsString;
  qryGen2.ParamByName('ALTERN').AsString := qryGen.FieldByName('WAN_ALTERN').AsString;
  qryGen2.ParamByName('DESCRI').AsString := qryGen.FieldByName('WAN_DESCRI').AsString;
  qryGen2.ParamByName('MONTAD').AsString := qryGen.FieldByName('WAN_MONTAD').AsString;
  qryGen2.ParamByName('VERCOR').AsString := qryGen.FieldByName('WAN_VERCOR').AsString;
  qryGen2.ParamByName('ANOINI').AsString := qryGen.FieldByName('WAN_ANOINI').AsString;
  qryGen2.ParamByName('ANOFIN').AsString := qryGen.FieldByName('WAN_ANOFIN').AsString;
  qryGen2.Open;

  Result := qryGen2.FieldByName('QTD').AsInteger;
end;

function TFormulaAutomotivaColorPro.fVolumeMaximoSpraySint(
  fltVolumeMaximoSpraySint: Double): Double;
begin
  Result := fltVolumeMaximoSpraySint;
end;

function TFormulaAutomotivaColorPro.fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer;
  dtsCadTin: IDataSet): Double;
begin
  Result := TAutcomTintaFactory.Get.IIF(intModoVenda = 0, '0,900', FormatFloat('#,###0.000', Self.VolumeOri));

  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := TAutcomTintaFactory.Get.IIF(intModoVenda = 0, '0,900', FormatFloat('#,###0.000', Self.VolumeOri));
    Exit;
  End;

  Case AnsiIndexStr(dtsCadTin.FieldByName('WAN_LINHA_').AsString,
    [ '1', '4', '6', '8', '9', '11', '12', '13', '14', '15', '16', '17', '19',
      '27', '58', '59', '67', '72', '74', '75', '76']) Of
    0 :  Begin
           Result := TAutcomTintaFactory.Get.IIF(intModoVenda = 0, TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOPLLT'), 3),
             FormatFloat('#,###0.000', Self.VolumeOri));
         End;
    1 :  Begin
           Result := TAutcomTintaFactory.Get.IIF(intModoVenda = 0, TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOHSLT'), 3),
             FormatFloat('#,###0.000', Self.VolumeOri));
         End;
    2 :  Begin
           Result := TAutcomTintaFactory.Get.IIF(intModoVenda = 0, TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOLALT'), 3),
             FormatFloat('#,###0.000', Self.VolumeOri));
         End;
    3 :  Begin
           Result := TAutcomTintaFactory.Get.IIF(intModoVenda = 0, TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOPULT'), 3),
             FormatFloat('#,###0.000', Self.VolumeOri));
         End;
    4 :  Begin
           Result := TAutcomTintaFactory.Get.IIF(intModoVenda = 0, TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOWCLT'), 3),
             FormatFloat('#,###0.000', Self.VolumeOri));
         End;
    5 :  Begin
           Result := TAutcomTintaFactory.Get.IIF(intModoVenda = 0, TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOSSLT'), 3),
             FormatFloat('#,###0.000', Self.VolumeOri));
         End;
    6 :  Begin
           Result := TAutcomTintaFactory.Get.IIF(intModoVenda = 0, TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOAPLT'), 3),
             FormatFloat('#,###0.000', Self.VolumeOri));
         End;
    7 :  Begin
           Result := TAutcomTintaFactory.Get.IIF(intModoVenda = 0, TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOBTLT'), 3),
             FormatFloat('#,###0.000', Self.VolumeOri));
         End;
    8 :  Begin
           Result := TAutcomTintaFactory.Get.IIF(intModoVenda = 0, TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOABLT'), 3),
             FormatFloat('#,###0.000', Self.VolumeOri));
         End;
    9 :  Begin
           Result := TAutcomTintaFactory.Get.IIF(intModoVenda = 0, TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VO11LT'), 3),
             FormatFloat('#,###0.000', Self.VolumeOri));
         End;
   10 :  Begin
           Result := TAutcomTintaFactory.Get.IIF(intModoVenda = 0, TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VO12LT'), 3),
             FormatFloat('#,###0.000', Self.VolumeOri));
         End;
   11 :  Begin
           Result := TAutcomTintaFactory.Get.IIF(intModoVenda = 0, TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VO13LT'), 3),
             FormatFloat('#,###0.000', Self.VolumeOri));
         End;
   12 :  Begin
           Result := TAutcomTintaFactory.Get.IIF(intModoVenda = 0, TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOBLLT'), 3),
             FormatFloat('#,###0.000', Self.VolumeOri));
         End;
   13 :  Begin
           Result := TAutcomTintaFactory.Get.IIF(intModoVenda = 0, TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOMMLT'), 3),
             FormatFloat('#,###0.000', Self.VolumeOri));
         End;
   14 :  Begin
           Result := TAutcomTintaFactory.Get.IIF(intModoVenda = 0, TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOMSLT'), 3),
             FormatFloat('#,###0.000', Self.VolumeOri));
         End;
   15 :  Begin
           Result := TAutcomTintaFactory.Get.IIF(intModoVenda = 0, TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VO90LT'), 3),
             FormatFloat('#,###0.000', Self.VolumeOri));
         End;
   16 :  Begin
           Result :=  TAutcomTintaFactory.Get.IIF(intModoVenda = 0, TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOLMML'), 3),
             FormatFloat('#,###0.000', Self.VolumeOri));
         End;
   17 :  Begin
           Result := TAutcomTintaFactory.Get.IIF(intModoVenda = 0, TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOTFLT'), 3),
             FormatFloat('#,###0.000', Self.VolumeOri));
         End;
   18 :  Begin
           Result := TAutcomTintaFactory.Get.IIF(intModoVenda = 0, TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOFELT'), 3),
             FormatFloat('#,###0.000', Self.VolumeOri));
         End;
   19 :  Begin
           Result := TAutcomTintaFactory.Get.IIF(intModoVenda = 0, TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOFSLT'), 3),
             FormatFloat('#,###0.000', Self.VolumeOri));
         End;
   20 :  Begin
           Result := TAutcomTintaFactory.Get.IIF(intModoVenda = 0, TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOFLLT'), 3),
             FormatFloat('#,###0.000', Self.VolumeOri));
         End;
  End;
end;

function TFormulaAutomotivaColorPro.GetAcrescimoDespesaOperacionalTinta: Double;
begin
  Result := conf.fGetDouble('DESOPE');
end;

function TFormulaAutomotivaColorPro.GetAno(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('WAN_ANOINI').AsString;
end;

function TFormulaAutomotivaColorPro.GetCalcDespesasOperacionais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  // A color pro tem uma unit especifica
  Result := 0;
end;

function TFormulaAutomotivaColorPro.GetCalcIcmsSaida(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  // A color pro tem uma unit especifica
  Result := 0;
end;

function TFormulaAutomotivaColorPro.GetCalcImpostosFederais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  // A color pro tem uma unit especifica
  Result := 0
end;

function TFormulaAutomotivaColorPro.GetCalcOutrosValores(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  // A color pro tem uma unit especifica
  Result := 0;
end;

function TFormulaAutomotivaColorPro.GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  // A color pro tem uma unit especifica
  Result := 0;
end;

function TFormulaAutomotivaColorPro.GetCalcPrecoCusto(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  // A color pro tem uma unit especifica
  Result := 0;
end;

function TFormulaAutomotivaColorPro.GetCalcPrecoCustoReal(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  // A color pro tem uma unit especifica
  Result := 0;
end;

function TFormulaAutomotivaColorPro.GetCalcPrecoMedio(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  // A color pro tem uma unit especifica
  Result := 0;
end;

function TFormulaAutomotivaColorPro.GetCalcPrecoVenda(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  // A color pro tem uma unit especifica
  Result := 0;
end;

function TFormulaAutomotivaColorPro.GetCalcQuantidade(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  // A color pro tem uma unit especifica
  Result := 0;
end;

function TFormulaAutomotivaColorPro.GetCalculadorInterno: ICalculadorFormulaAutomotiva;
begin
  Result := TCalculadorFormulaAutomotivaColorPro.Create(Self);
end;

function TFormulaAutomotivaColorPro.GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  // A color pro tem uma unit especifica
  Result := 0;
end;

function TFormulaAutomotivaColorPro.GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  // A color pro tem uma unit especifica
  Result := 0;
end;

function TFormulaAutomotivaColorPro.GetChaFor(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('WAN_DESCRI').AsString + ' ' +
            dtsCadTin.FieldByName('WAN_CODAKZ').AsString + ' ' +
            dtsCadTin.FieldByName('WAN_LINHA_').AsString + ' ' +
            dtsCadTin.FieldByName('WAN_MONTAD').AsString + ' ' ;
end;

function TFormulaAutomotivaColorPro.GetChaForEspecifico(
  const dicRetorno: IDicionario; const dtsCadTin: IDataSet): String;
var
  intCamadas: Integer;
begin
  Result := dicRetorno['chafor'];

  intCamadas := fVerificaQuantidadeCamadas(dicRetorno['itetin']);

  If intCamadas > 1 Then
    Result := Result + dicRetorno['camada'] + 'ª CAMADA ';

  Result := dicRetorno['descor'] + Result + dicRetorno['tipemb'];

  If intCamadas > 1 Then
    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', Format('Esta fórmula possui %d camadas, após consultar a primeira, selecione a próxima.', [intCamadas]), ['OK']);
end;

function TFormulaAutomotivaColorPro.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('WAN_MD5KEY').AsString;
end;

function TFormulaAutomotivaColorPro.GetCodFormul(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('WAN_CODAKZ').AsString;
end;

function TFormulaAutomotivaColorPro.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('WAN_DESCRI').AsString + ' ' +
            dtsCadTin.FieldByName('WAN_CODAKZ').AsString + ' ' +
            dtsCadTin.FieldByName('WAN_LINHA_').AsString;
end;

function TFormulaAutomotivaColorPro.GetDescricaoBase(strCodBas: String; strLinha: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DESBAS FROM WANPRO_CADBAS WHERE BAS_CODBAS = :CODBAS' +
                    '   AND BAS_LINHA_ = :LINHA_   ';

      qryGen.ParamByName('CODBAS').AsString := strCodBas;
      qryGen.ParamByName('LINHA_').AsString := strLinha;
      qryGen.Open;

      Result := qryGen.FieldByName('BAS_DESBAS').AsString;

      If Not TStrUtils.fEmptyStr(Result) Then
        Result := ' - ' + Result;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

function TFormulaAutomotivaColorPro.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaAutomotivaColorPro.GetIdePro: String;
begin
  Result := 'WCP';
end;

function TFormulaAutomotivaColorPro.GetIndEmb(
  const dtsCadTin: IDataSet): integer;
begin
  Result := -1;
end;

function TFormulaAutomotivaColorPro.GetLinha(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('WAN_LINHA_').AsString;
end;

function TFormulaAutomotivaColorPro.GetMontadora(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('WAN_MONTAD').AsString;
end;

function TFormulaAutomotivaColorPro.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaAutomotivaColorPro.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaAutomotivaColorPro.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaAutomotivaColorPro.GetNomeTabelaBases: String;
begin
  Result := 'WANPRO_CADBAS';
end;

function TFormulaAutomotivaColorPro.GetPrefixoFormulacao: String;
begin
  Result := 'WAN_CODC';
end;

function TFormulaAutomotivaColorPro.GetPrefixoLitragem(
  const strModo: String): String;
begin
  Result := '';
end;

function TFormulaAutomotivaColorPro.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := ''
end;

function TFormulaAutomotivaColorPro.GetProdutoVendaTinta(const dtsCadTin: IDataSet): string;
begin
  Result := conf.fGet('PROWAN');
end;

function TFormulaAutomotivaColorPro.GetQualidade(
  const dtsCadTin: IDataSet): String;
begin
  Result := '';
end;

function TFormulaAutomotivaColorPro.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaAutomotivaColorPro.GetSaldos: ISaldosColorantes;
var
  intCont: Integer;
  saldos: TGenericSaldosColorantes;
  base: TBaseAutomotiva;
  fltQtdFormul: Double;
  bln4Por1: Boolean;

  strLinha: String;
begin
  saldos := TGenericSaldosColorantes.Create();

  base := TBaseAutomotiva(Self.Items[0]);
  strLinha := base.LinhaBase;

  for intCont := 0 to Self.Count - 1 do
  begin
    base := TBaseAutomotiva(Self.Items[intCont]);

    GetDataSetBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([Base.CodigoBase, Base.LinhaBase]), []);

    if (Base.TipoBase = 'C') and not(self.ComCatalisador) then
      Continue;

    bln4Por1 := False;
  {$IFNDEF LINUX}
    If (Pos(TStrUtils.fStrZero(strLinha,3), '008_058_059_013_072_') > 0) And (mveModoVenda = mvDiluido) Then
    Begin
      {***************************************************}
      {* CASO ESCOLHEU 4 POR 1 NO DILUIDO                *}
      {** 15/07/2008 - 08:46 **************************MV*}
      {*******************************************}
      {* QUANDO LINHA 8 PODE ESCOLHER 2:1 OU 4:1 *}
      {****************************************PH*}
      If Pos(TStrUtils.fStrZero(strLinha,3),  '008_013') > 0 Then
      Begin
        bln4Por1 := (Self.intIndiceAdicional = 1);
      End
      {*******************************************************}
      {* QUANDO LINHA 72 SOMENTE 9:2 (UNICO ITEM NA COMBOBOX)*}
      {****************************************************RG*}
      Else If Pos(TStrUtils.fStrZero(strLinha, 3), '072_') > 0 Then
      Begin
        bln4Por1 := False;
      End
      Else
      Begin
        {*******************************************************}
        {* QUANDO LINHA 58 SOMENTE 4:1 (UNICO ITEM NA COMBOBOX)*}
        {****************************************************PH*}
        bln4Por1 := (Self.intIndiceAdicional = 0);
      End;
    End;
  {$ELSE}
    bln4Por1 := (Self.DilLinux = '4:1');
  {$ENDIF}

    fltQtdFormul := IfThen(mveModoVenda = mvConcentrado, Base.QuantidadeConcentrado, IfThen(bln4Por1, Base.QuantidadeDiluido2, Base.QuantidadeDiluido)) * (Self.fltVolumePro / Self.fltVolumeOri);

    if fltQtdFormul > 0 then
    begin
      saldos.Adicionar(TGenericSaldoColorante.Create(
        1,
        Descricao,
        GetDataSetBases.FieldByName('BAS_CODITE').AsString,
        VarToStrDef(TAutcomTintaFactory.Get.GetValorCampo('SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE', 'ITE_DESITE', [
          GetDataSetBases.FieldByName('BAS_CODITE').AsString]), ''),
        Base.CodigoBase,
        fltQtdFormul,
        BASE_AUTOMOTIVA,
        'N',
        0.0));
    end;
  end;

  Result := saldos;
end;

function TFormulaAutomotivaColorPro.GetSelectBases: String;
begin
  Result := ' SELECT         ' +
            '     BAS_CODBAS ' +
            '   , BAS_CODITE ' +
            '   , BAS_EMBALA ' +
            '   , BAS_PESESP ' +
            '   , BAS_DESBAS ' +
            '   , BAS_LINHA_ ' +
            '   , IFNULL(ITE_ITEATI, "N") ITE_ITEATI ' +
            '   , ITE_CNV_ML ' +
            '   , ITE_OUTVAL ' +
            '   , ITE_IMPFED ' +
            '   , ITE_DESOPE ' +
            '   , ITE_PREMED ' +
            '   , ITE_IMPULT ' +
            '   , ITE_ICMSAI ' +
            '   , ITE_PREULT ' +
            '   , ITE_PRECOM ' +
            '   , ITE_DESF01 ' +
            '   , ITE_DESF02 ' +
            '   , ITE_DESF03 ' +
            '   , ITE_DESF04 ' +
            '   , ITE_DESF05 ' +
            '   , ITE_DESF06 ';

  If TAutcomTintaFactory.Get.fCfgSis('IMPDIG') = '1' Then
    Result := Result  + '   , I.ITE_IMPDIR  '
  else
    Result := Result  + '   , G.ITE_IMPDIR  ';

end;

function TFormulaAutomotivaColorPro.GetTextoInformativoCalculo: String;
begin
  Result :=
    'PesoBase       = Embalagem * PesoEspecifico'              + sLineBreak +
    'Valor da Base  = Quantidade * Preço / PesoBase'           + sLineBreak +
    'Preço da Tinta = Soma do Valor da Base de todas as bases.';
end;

function TFormulaAutomotivaColorPro.GetUniversal(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaColorPro.GetVolumeMaximoCopo(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Copo') Then
  Begin
    Result := 0.500;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOLICO'), 3);
end;

function TFormulaAutomotivaColorPro.GetVolumeMaximoGalao(
  dtsCadTin: IDataSet): Double;
begin
  Result := 4.000;

  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 4.000;
    Exit;
  End;

  Case AnsiIndexStr(dtsCadTin.FieldByName('WAN_LINHA_').AsString,
    [ '1', '4', '6', '8', '9', '11', '12', '13', '14', '15', '16', '17', '19',
      '27', '58', '59', '67', '72', '74', '75', '76']) Of
    0 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOPLGL'), 3);
         End;
    1 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOHSGL'), 3);
         End;
    2 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOLAGL'), 3);
         End;
    3 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOPUGL'), 3);
         End;
    4 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOWCGL'), 3);
         End;
    5 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOSSGL'), 3);
         End;
    6 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOAPGL'), 3);
         End;
    7 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOBTGL'), 3);
         End;
    8 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOABGL'), 3);
         End;
    9 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VO11GL'), 3);
         End;
   10 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VO12GL'), 3);
         End;
   11 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VO13GL'), 3);
         End;
   12 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOBLGL'), 3);
         End;
   13 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOMMGL'), 3);
         End;
   14 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOMSGL'), 3);
         End;
   15 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VO90GL'), 3);
         End;
   16 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOLMMG'), 3);
         End;
   17 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOTFGL'), 3);
         End;
   18 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOFEGL'), 3);
         End;
   19 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOFSGL'), 3);
         End;
   20 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOFLGL'), 3);
         End;
  End;
end;

function TFormulaAutomotivaColorPro.GetVolumeMaximoLata(
  dtsCadTin: IDataSet): Double;
begin
  Result := 18.000;

  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Case AnsiIndexStr(dtsCadTin.FieldByName('WAN_LINHA_').AsString,
    [ '1', '4', '6', '8', '9', '11', '12', '13', '14', '15', '16', '17', '19',
      '27', '58', '59', '67', '72', '74', '75', '76']) Of
    0 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOPLLA'), 3);
         End;
    1 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOHSLA'), 3);
         End;
    2 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOLALA'), 3);
         End;
    3 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOPULA'), 3);
         End;
    4 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOWCLA'), 3);
         End;
    5 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOSSLA'), 3);
         End;
    6 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOAPLA'), 3);
         End;
    7 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOBTLA'), 3);
         End;
    8 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOABLA'), 3);
         End;
    9 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VO11LA'), 3);
         End;
   10 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VO12LA'), 3);
         End;
   11 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VO13LA'), 3);
         End;
   12 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOBLLA'), 3);
         End;
   13 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOMMLA'), 3);
         End;
   14 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOMSLA'), 3);
         End;
   15 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VO90LA'), 3);
         End;
   16 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOLMMA'), 3);
         End;
   17 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOTFLA'), 3);
         End;
   18 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOFELA'), 3);
         End;
   19 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOFSLA'), 3);
         End;
   20 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOFLLA'), 3);
         End;
  End;
end;

function TFormulaAutomotivaColorPro.GetVolumeMaximoLitro(
  dtsCadTin: IDataSet): Double;
begin
  Result := 1.000;

  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 1.000;
    Exit;
  End;

  Case AnsiIndexStr(dtsCadTin.FieldByName('WAN_LINHA_').AsString,
    [ '1', '4', '6', '8', '9', '11', '12', '13', '14', '15', '16', '17', '19',
      '27', '58', '59', '67', '72', '74', '75', '76']) Of
    0 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOPLLT'), 3);
         End;
    1 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOHSLT'), 3);
         End;
    2 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOLALT'), 3);
         End;
    3 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOPULT'), 3);
         End;
    4 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOWCLT'), 3);
         End;
    5 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOSSLT'), 3);
         End;
    6 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOAPLT'), 3);
         End;
    7 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOBTLT'), 3);
         End;
    8 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOABLT'), 3);
         End;
    9 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VO11LT'), 3);
         End;
   10 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VO12LT'), 3);
         End;
   11 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VO13LT'), 3);
         End;
   12 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOBLLT'), 3);
         End;
   13 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOMMLT'), 3);
         End;
   14 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOMSLT'), 3);
         End;
   15 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VO90LT'), 3);
         End;
   16 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOLMML'), 3);
         End;
   17 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOTFLT'), 3);
         End;
   18 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOFELT'), 3);
         End;
   19 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOFSLT'), 3);
         End;
   20 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOFLLT'), 3);
         End;
  End;
end;

function TFormulaAutomotivaColorPro.GetVolumeMaximoSpray(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Spray') Then
  Begin
    Result := 0.400;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOLISP'), 3);
end;

function TFormulaAutomotivaColorPro.GetVolumeMaximoSpraySint(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Spray Sint') Then
  Begin
    Result := 0.150;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOLISS'), 3);
end;

function TFormulaAutomotivaColorPro.GetVolumePadraCopo: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Copo') Then
  Begin
    Result := 0.500;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOLICO'), 3);
end;

function TFormulaAutomotivaColorPro.GetVolumePadraGalao(
  dtsCadTin: IDataSet): Double;
begin
  Result := 3.600;

  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 3.600;
    Exit;
  End;

  Case AnsiIndexStr(dtsCadTin.FieldByName('WAN_LINHA_').AsString,
    [ '1', '4', '6', '8', '9', '11', '12', '13', '14', '15', '16', '17', '19',
      '27', '58', '59', '67', '72', '74', '75', '76']) Of
    0 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOPLGL'), 3);
         End;
    1 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOHSGL'), 3);
         End;
    2 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOLAGL'), 3);
         End;
    3 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOPUGL'), 3);
         End;
    4 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOWCGL'), 3);
         End;
    5 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOSSGL'), 3);
         End;
    6 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOAPGL'), 3);
         End;
    7 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOBTGL'), 3);
         End;
    8 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOABGL'), 3);
         End;
    9 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VO11GL'), 3);
         End;
   10 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VO12GL'), 3);
         End;
   11 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VO13GL'), 3);
         End;
   12 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOBLGL'), 3);
         End;
   13 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOMMGL'), 3);
         End;
   14 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOMSGL'), 3);
         End;
   15 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VO90GL'), 3);
         End;
   16 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOLMMG'), 3);
         End;
   17 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOTFGL'), 3);
         End;
   18 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOFEGL'), 3);
         End;
   19 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOFSGL'), 3);
         End;
   20 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOFLGL'), 3);
         End;
  End;
end;

function TFormulaAutomotivaColorPro.GetVolumePadraoLata(
  dtsCadTin: IDataSet): Double;
begin
  Result := 18.000;

  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Case AnsiIndexStr(dtsCadTin.FieldByName('WAN_LINHA_').AsString,
    [ '1', '4', '6', '8', '9', '11', '12', '13', '14', '15', '16', '17', '19',
      '27', '58', '59', '67', '72', '74', '75', '76']) Of
    0 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOPLLA'), 3);
         End;
    1 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOHSLA'), 3);
         End;
    2 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOLALA'), 3);
         End;
    3 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOPULA'), 3);
         End;
    4 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOWCLA'), 3);
         End;
    5 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOSSLA'), 3);
         End;
    6 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOAPLA'), 3);
         End;
    7 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOBTLA'), 3);
         End;
    8 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOABLA'), 3);
         End;
    9 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VO11LA'), 3);
         End;
   10 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VO12LA'), 3);
         End;
   11 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VO13LA'), 3);
         End;
   12 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOBLLA'), 3);
         End;
   13 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOMMLA'), 3);
         End;
   14 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOMSLA'), 3);
         End;
   15 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VO90LA'), 3);
         End;
   16 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOLMMA'), 3);
         End;
   17 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOTFLA'), 3);
         End;
   18 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOFELA'), 3);
         End;
   19 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOFSLA'), 3);
         End;
   20 :  Begin
           Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOFLLA'), 3);
         End;
  End;
end;

function TFormulaAutomotivaColorPro.GetVolumePadraoSpraySint: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Spray Sint') Then
  Begin
    Result := 0.100;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOLISS'), 3);
end;

function TFormulaAutomotivaColorPro.GetVolumePadraSpray: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Spray') Then
  Begin
    Result := 0.400;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetDouble('VOLISP'), 3);
end;

function TFormulaAutomotivaColorPro.GetVolumePadraTambor(dtsCadTin: IDataSet): Double;
begin
  Result := 196.000;
end;

function TFormulaAutomotivaColorPro.GetVolumePermitido(
  const dtsCadTin: IDataSet; strTipoPre: String): Double;
begin
  Result := 0;
end;

procedure TFormulaAutomotivaColorPro.pDefineVolumeOriginal;
var
  Base: TBaseAutomotiva;
  bln4Por1: Boolean;
begin
  Base := TBaseAutomotiva(Self.Items[0]);

  Self.VolumeOri := 0.900;

  If (Pos(TStrUtils.fStrZero(Base.LinhaBase,3), '008_058_059_013_072_') > 0) And (Self.mveModoVenda = mvDiluido) Then
  Begin
    {***************************************************}
    {* CASO ESCOLHEU 4 POR 1 NO DILUIDO                *}
    {** 15/07/2008 - 08:46 **************************MV*}
    {********************************************}
    {* QUANDO LINHA 8 OPODE ESCOLHER 2:1 OU 4:1 *}
    {*****************************************PH*}
    If Base.LinhaBase = '8' Then
    Begin
    {$IFNDEF LINUX}
      bln4Por1 := (Self.intIndiceAdicional = 1);
    {$ELSE}
      bln4Por1 := (Self.DilLinux = '4:1');
    {$ENDIF}
      If bln4Por1 Then
        Self.VolumeOri := 0.750
      Else
        Self.VolumeOri := 0.640;
    End
    Else If Base.LinhaBase = '13' Then
    Begin
    {$IFNDEF LINUX}
      bln4Por1 := (Self.intIndiceAdicional = 1);
    {$ELSE}
      bln4Por1 := (Self.DilLinux = '4:1');
    {$ENDIF}
      If bln4Por1 Then
        Self.VolumeOri := 0.750
      Else
        Self.VolumeOri := 0.618;
    End
    Else
    Begin
      {*******************************************************}
      {* QUANDO LINHA 58 SOMENTE 4:1 (UNICO ITEM NA COMBOBOX)*}
      {* QUANDO LINHA 72 SOMENTE 9:2 (UNICO ITEM NA COMBOBOX)*}
      {****************************************************PH*}
      Self.VolumeOri := 0.750;
    End;
  End;
end;

{$IFNDEF LINUX}
procedure TFormulaAutomotivaColorPro.pModoVendaClick(Var edtVolume: TEditFocus; intModoVenda, intListaAdic: Integer);
var
  Base: TBaseAutomotiva;
begin
  Base := TBaseAutomotiva(Self.Items[0]);

  If (Pos(TStrUtils.fStrZero(Base.LinhaBase,3), '008_058_059_013_') > 0) And (intModoVenda = 1) Then
  Begin
//    Self.VolumePro := TAutcomTintaFactory.Get.fStrToFloat(FormatFloat('#,###0.000', Self.VolumeOri));
//    edtVolume.Text := FormatFloat('#,###0.000', Self.VolumeOri);
    Self.DefineRegraListaAdicionalChange(edtVolume);
  End;

  Self.IndiceAdicional := intListaAdic;
end;
{$ENDIF}

procedure TFormulaAutomotivaColorPro.pPreencheListaAdicionalBases;
var
  Base: TBaseAutomotiva;
begin
  Base := TBaseAutomotiva(Self.Items[0]);

  Self.ListaAdicional.Clear;

  If Pos(TStrUtils.fStrZero(Base.LinhaBase, 2), '08_13_') > 0 Then
  Begin
    Self.ListaAdicional.Add('2:1');
    If Pos(TStrUtils.fStrZero(Base.LinhaBase,3), '008_013_') > 0 Then
      Self.ListaAdicional.Add('4:1');
  End
  Else If Pos(TStrUtils.fStrZero(Base.LinhaBase, 2), '58_59_') > 0 Then
  Begin
    Self.ListaAdicional.Add('4:1');
  End
  Else If Pos(TStrUtils.fStrZero(Base.LinhaBase, 3), '072_') > 0 Then
  Begin
    Self.ListaAdicional.Add('9:2');
  End
  Else
    Self.blnAdicionalDiluido := False;
end;

procedure TFormulaAutomotivaColorPro.pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet);
  procedure pPreencher(strLitro, strGalao, strLata: String);
  begin
    ProEmbLt.Add(strLitro);
    ProEmbGl.Add(strGalao);
    ProEmbLa.Add(strLata);
  end;
begin
  DesEmb.Clear;
  ProEmbLt.Clear;
  ProEmbGl.Clear;
  ProEmbLa.Clear;

  DesEmb.Add('NORMAL');

  Case AnsiIndexStr(dtsCadTin.FieldByName('WAN_LINHA_').AsString,
    ['1', '4', '6', '8', '9', '11', '12', '13', '14', '15', '16', '17', '19',
     '27', '58', '59', '67', '72', '74', '75', '76']) Of
    0  : Begin //1
           pPreencher(conf.fGet('PLSILT'), conf.fGet('PLSIGL'), conf.fGet('PLSILA'));
         End;
    1  : Begin //4
           pPreencher(conf.fGet('WAHSLT'), conf.fGet('WAHSGL'), conf.fGet('WAHSLA'));
         End;
    2  : Begin //6
           pPreencher(conf.fGet('WALALT'), conf.fGet('WALAGL'), conf.fGet('WALALA'));
         End;
    3  : Begin //8
           pPreencher(conf.fGet('PUHSLT'), conf.fGet('PUHSGL'), conf.fGet('PUHSLA'));
         End;
    4  : Begin //9
           pPreencher(conf.fGet('WCARLT'), conf.fGet('WCARGL'), conf.fGet('WCARLA'));
         End;
    5  : Begin //11
           pPreencher(conf.fGet('SISTLT'), conf.fGet('SISTGL'), conf.fGet('SISTLA'));
         End;
    6  : Begin //12
           pPreencher(conf.fGet('PLBALT'), conf.fGet('PLBAGL'), conf.fGet('PLBALA'));
         End;
    7  : Begin //13
           pPreencher(conf.fGet('BTSILT'), conf.fGet('BTSIGL'), conf.fGet('BTSILA'));
         End;
    8  : Begin //14
           pPreencher(conf.fGet('PLAULT'), conf.fGet('PLAUGL'), conf.fGet('PLAULA'));
         End;
    9  : Begin //15
           pPreencher(conf.fGet('BT11LT'), conf.fGet('BT11GL'), conf.fGet('BT11LA'));
         End;
    10 : Begin //16
           pPreencher(conf.fGet('BT12LT'), conf.fGet('BT12GL'), conf.fGet('BT12LA'));
         End;
    11 : Begin //17
           pPreencher(conf.fGet('BT13LT'), conf.fGet('BT13GL'), conf.fGet('BT13LA'));
         End;
    12 : Begin //19
           pPreencher(conf.fGet('PLBLLT'), conf.fGet('PLBLGL'), conf.fGet('PLBLLA'));
         End;
    13 : Begin //27
           pPreencher(conf.fGet('MMSILT'), conf.fGet('MMSIGL'), conf.fGet('MMSILA'));
         End;
    14 : Begin //58
           pPreencher(conf.fGet('PUMSLT'), conf.fGet('PUMSGL'), conf.fGet('PUMSLA'));
         End;
    15 : Begin //59
           pPreencher(conf.fGet('BT90LT'), conf.fGet('BT90GL'), conf.fGet('BT90LA'));
         End;
    16 : Begin
            pPreencher(Conf.fGet('EMBMML'), Conf.fGet('EMBMMG'), Conf.fGet('EMBMMA'));
         End;
    17 : Begin //72
           pPreencher(conf.fGet('TFPULT'), conf.fGet('TFPUGL'), conf.fGet('TFPULA'));
         End;
    18 : Begin //74
           pPreencher(conf.fGet('TFEPLT'), conf.fGet('TFEPGL'), conf.fGet('TFEPLA'));
         End;
    19 : Begin //75
           pPreencher(conf.fGet('TFSILT'), conf.fGet('TFSIGL'), conf.fGet('TFSILA'));
         End;
    20 : Begin //76
           pPreencher(conf.fGet('TFLALT'), conf.fGet('TFLAGL'), conf.fGet('TFLALA'));
         End;
  End;

  sProEmbCo := conf.fGet('WANICO');
  sProEmbSp := conf.fGet('WANISP');
  sProEmbSs := conf.fGet('WANISS');

  sProEmbTb := '';
  sProEmbBa := '';
  sProEmbPo := '';
  sProEmbSd := '';
  sProEmbLa := '';
end;

procedure TFormulaAutomotivaColorPro.pPreencherPesCorFor(const dtsCadTin: IDataSet);
begin
  inherited;
  Self.PesoCor := 0;
  Self.PesoFor := 0;

end;

{$IFNDEF LINUX}
procedure TFormulaAutomotivaColorPro.pRecalculaFormulaMostrarDigitado(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; fltFator: Double;
  blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha: String;
  strTipBas: String);
begin
  With lsvFormulacao.Items.Add Do
  Begin
    Caption := TAutcomTintaFactory.Get.IIF(blnConsLinhaDesBas, Base.LinhaBase + '_', '') +
      Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase, Base.LinhaBase);

    SubItems.Add(strTipBas);
    SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado * fltFator, ffFixed, 12, 1));
    SubItems.Add(FloatToStrF(Base.QuantidadeDiluido * fltFator, ffFixed, 12, 1));
    SubItems.Add(FloatToStrF(Base.QuantidadeDiluido2 * fltFator, ffFixed, 12, 1));
    SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TFormulaAutomotivaColorPro.pRecalculaFormulaMostrarPadrao(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; blnConsLinhaDesBas: Boolean;
  strTipBas: String; intCont: Integer);
begin
  With lsvFormulacao.Items.Add Do
  Begin
    Caption := TAutcomTintaFactory.Get.IIF(blnConsLinhaDesBas, Base.LinhaBase + '_', '') +
      Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase, Base.LinhaBase);

    SubItems.Add(strTipBas);

    SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado, ffFixed, 12, 1));
    SubItems.Add(FloatToStrF(Base.QuantidadeDiluido, ffFixed, 12, 1));
    SubItems.Add(FloatToStrF(Base.QuantidadeDiluido2, ffFixed, 12, 1));
    SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

procedure TFormulaAutomotivaColorPro.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('WAN_ACRMOB').AsFloat;
end;

procedure TFormulaAutomotivaColorPro.PreencheQuantidadeFormulacaoVenda(
  const dtsCadTin: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
begin
  For intContador := 1 To Self.GetQuantidadeFormulacao Do
  Begin
    If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('WAN_CODC' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
      Break;

    Base := TBaseAutomotiva(Self.Add);
    Base.LinhaBase             := dtsCadTin.FieldByName('WAN_LINC' + TStrUtils.fStrZero(intContador, 2)).AsString;
    Base.CodigoBase            := dtsCadTin.FieldByName('WAN_CODC' + TStrUtils.fStrZero(intContador, 2)).AsString;
    Base.QuantidadeConcentrado := dtsCadTin.FieldByName('WAN_QCON' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
    Base.QuantidadeDiluido     := dtsCadTin.FieldByName('WAN_QD21' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
    Base.QuantidadeDiluido2    := dtsCadTin.FieldByName('WAN_QD41' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
    Base.Porcen                := dtsCadTin.FieldByName('WAN_PORC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

    If Base.LinhaBase = '72' Then
      Base.QuantidadeDiluido   := dtsCadTin.FieldByName('WAN_QD92' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

    Base.TipoBase              := 'B';
  End;
end;

procedure TFormulaAutomotivaColorPro.PreencheVolumeVenda(const dtsCadTin: IDataSet);
begin
  //
end;

procedure TFormulaAutomotivaColorPro.pRetornaInfoLinha(strLinha: String;
  var strLinDil, strBasDil: String; var fltFatBas, fltPerDil: Double;
  strConDil: String);
begin
  strLinDil := '';
  strBasDil := '';
  fltFatBas := 0.0;
  fltPerDil := 0.0;

  If (strLinha = '4') Then
  Begin
    strLinDil := conf.fGet('LD1WAN');
    strBasDil := conf.fGet('BD1WAN');
    fltPerDil := 33.33;
  End
  Else If (strLinha = '1') Then
  Begin
    strLinDil := conf.fGet('LD1ABS_100_50');
    strBasDil := conf.fGet('BD1ABS_100_50');
    fltPerDil := 33.33;
  End
  Else If (strLinha = '14') Then
  Begin
    strLinDil := conf.fGet('LD1ABS_100_80');
    strBasDil := conf.fGet('BD1ABS_100_80');
    fltPerDil := 44.4;
  End
  Else If (strLinha = '8') Then
  Begin
    strLinDil := conf.fGet('LD1PU_HS');
    strBasDil := conf.fGet('BD1PU_HS');

    If strConDil = 'DIL' Then
      fltPerDil := 15.39 //23.076
    Else
      fltPerDil := 20; //25;
  End
  Else If (strLinha = '58') Then
  Begin
    strLinDil := conf.fGet('LD1PU_MS');
    strBasDil := conf.fGet('BD1PU_MS');
    fltPerDil := 20;
  End

  Else If (strLinha = '16') Then
  Begin
    strLinDil := conf.fGet('LD1BT120');
    strBasDil := conf.fGet('BD1BT120');
    fltPerDil := 30;
  End
  Else If (strLinha = '59') Then
  Begin
    strLinDil := conf.fGet('LD1BT90');
    strBasDil := conf.fGet('BD1BT90');
    //fltPerDil := 25;
  End
  Else If (strLinha = '37') Then
  Begin
    strLinDil := conf.fGet('LD1BT80');
    strBasDil := conf.fGet('BD1BT80');
    fltPerDil := 15;
  End
  Else If (strLinha = '13') Then
  Begin
    strLinDil := conf.fGet('LD1BT100');
    strBasDil := conf.fGet('BD1BT100');
    If strConDil = 'DIL' Then
      fltPerDil := 10
    Else
      fltPerDil := 25;
  End
  Else If (strLinha = '12') Then
  Begin
    strLinDil := conf.fGet('LPAPB_10080');
    strBasDil := conf.fGet('BPAPB_10080');
    fltPerDil := 44.40;
  End
  Else If (strLinha = '19') Then
  Begin
    strLinDil := conf.fGet('LD1ABS_BASELINE');
    strBasDil := conf.fGet('BD1ABS_BASELINE');
    fltPerDil := 33.33;
  End
  Else If (strLinha = '72') Then
  Begin
    strLinDil := Conf.fGet('LD1BT362');
    strBasDil := Conf.fGet('BD1BT362');
    fltPerDil := 11.111;
  End;


  If (fltPerDil > 0.0) Then
    fltFatBas := (100 - fltPerDil) / 100;
end;

procedure TFormulaAutomotivaColorPro.RecalcularTabelasGeneric(
  dicRetorno: IDicionario);
var
  strTabelas: String;
  strTabelaAtual: String;
  intContador: Integer;
begin
  strTabelas := TAutcomTintaFactory.Get.fCfgSis('TABPRC');
  If Length(strTabelas) < 7 Then
    strTabelas := strTabelas + StringOfChar('N',7 - Length(strTabelas));

  Self.FBlnCalculaUnitario := False;

  strTabPreTin := TVariantUtils.IfNull(dicRetorno['tabpre'],0);
  strTabelaAtual := Self.strTabPre;
  For intContador := 1 To Length(strTabelas) Do
  Begin
    if strTabelas[intContador] = 'S' then
    begin
      Self.strTabPre := IntToStr(intContador);

      Self.CarregarBases(dicRetorno);
      Self.CarregarBasesPorEmpresa(dicRetorno);

      Self.CarregaPrecosBases;
      Self.CarregaPrecosBasesPorEmpresa;

      Self.CalcularPrecos;

      {Carrega preço da embalagem conforme tabela de preço!}
      Self.pCarregaPrecoPromocaoEmbalagem(Self.strTabPre);

      If dicRetorno['tippre'] = 'C' Then
      Begin
        If PrecoVendaCon > 0 Then
        Begin
          If TAutcomTintaFactory.Get.fGetConfTinta(GetIdePro).fGet('ACRMOB') = '1' Then
            dicRetorno['preve' + IntToStr(intContador)] := (PrecoVendaCon + EmbPrecoVenda) * (1 + AcrMob / 100)
          Else
            dicRetorno['preve' + IntToStr(intContador)] := PrecoVendaCon + EmbPrecoVenda + AcrMob;

          dicRetorno['preve' + IntToStr(intContador) + '_original'] := dicRetorno['preve' + IntToStr(intContador)];

          If Self.AcertoValor Then
            dicRetorno['preve' + IntToStr(intContador)] := dicRetorno['preve' + IntToStr(intContador)] + Self.FatorAcerto
          Else
            dicRetorno['preve' + IntToStr(intContador)] := dicRetorno['preve' + IntToStr(intContador)] * Self.FatorAcerto;
        End;
      End
      Else
      Begin
        If (PrecoVendaDil > 0) Then
        Begin
          If TAutcomTintaFactory.Get.fGetConfTinta(GetIdePro).fGet('ACRMOB') = '1' Then
            dicRetorno['preve' + IntToStr(intContador)] := (PrecoVendaDil + EmbPrecoVenda) * (1 + AcrMob / 100)
          Else
            dicRetorno['preve' + IntToStr(intContador)] := PrecoVendaDil + EmbPrecoVenda + AcrMob;

          dicRetorno['preve' + IntToStr(intContador) + '_original'] := dicRetorno['preve' + IntToStr(intContador)];

          If Self.AcertoValor Then
            dicRetorno['preve' + IntToStr(intContador)] := dicRetorno['preve' + IntToStr(intContador)] + Self.FatorAcerto
          Else
            dicRetorno['preve' + IntToStr(intContador)] := dicRetorno['preve' + IntToStr(intContador)] * Self.FatorAcerto;
        End;
      End;

      If intContador = TVariantUtils.IfNull(dicRetorno['tabpre'], 0) Then
      Begin
        dicRetorno['promoc'] := Self.Promoc;
        pCalculaImpostosSaida(dicRetorno);
      End;
    end;
  End;
  Self.strTabPre := strTabelaAtual;
  dicRetorno['fatace'] := fltFatorAcerto;
{$IFNDEF LINUX}
  If Self.AcertoValor Then
    dicRetorno['acerto'] := TAutcomTintaFactory.Get.IIF(fltFatorAcerto > 0, 'S', 'N')
  Else
    dicRetorno['acerto'] := TAutcomTintaFactory.Get.IIF(fltFatorAcerto > 1, 'S', 'N');
{$ENDIF}
end;

end.

