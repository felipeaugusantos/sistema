{************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula TopCoat *}
{*********************************************************************AC*}
unit untFormulaAutomotivaTopCoat;

interface

uses
{$IFNDEF LINUX}
  Controls,
  ComCtrls,
{$ENDIF}
  untAbstractFormulaAutomotiva, untICalculadorFormulaAutomotiva, untIDataSet, untBaseAutomotiva,
  SysUtils, untStrUtils, Classes, untIConfTinta, untFloatUtils, untModoVenda, untIDicionario;

type
  TMinMax = record
    fltMin : Double;
    fltMax : Double;
  end;

type
  TFormulaAutomotivaTopCoat = class(TAbstractFormulaAutomotiva)
  protected
    function GetCalculadorInterno(): ICalculadorFormulaAutomotiva; override;
    function GetTextoInformativoCalculo(): String; override;
    procedure CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva); override;
    function GetNomeCampoCustoBase: String; override;
    function GetNomeCampoVendaBase: String; override;
    function GetNomeTabelaBases: String; override;
    function GetNomeCampoBaseCodIte: String; override;
    function GetSelectBases: String; override;

    function fCalculaQuantidadeParaBaixaEstoque(Base: TBaseAutomotiva): Double; Override;
  public
    function GetPrefixoQuantidade(const strModo: String): String; override;
    function GetPrefixoLitragem(const strModo: String): String; override;
    function GetQuantidadeFormulacao(): Integer; override;
    function GetPrefixoFormulacao(): String; override;
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

    function GetVolumePadraCopo : Double;  override;
    function GetVolumePadraSpray: Double;  override;
    function GetVolumePadraTambor(dtsCadTin: IDataSet): Double; override;

    function fValidaVolumeFormulucao(strTipoPre: String; const dtsCadTin: IDataSet): Boolean; override;

    // Cálculos - Inicio
    function GetCalcImpostosFederais(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcIcmsSaida(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcPrecoMedio(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcOutrosValores(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcPrecoCusto(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcPrecoCustoReal(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcPrecoVenda(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcDespesasOperacionais(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcQuantidade(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    // Cálculos - Fim

    function GetProdutoVendaTinta(const dtsCadTin: IDataSet): string; override;
    function GetMontadora(const dtsCadTin: IDataSet): string; override;
    function GetAno(const dtsCadTin: IDataSet): string; override;
    function GetAcrescimoDespesaOperacionalTinta: Double; override;
    function GetDescricaoBase(strCodBas: String): String; override;
    function GetFatorEstoque: Double; override;
    procedure pDefineVolumeOriginal; override;
    function fMostrarComCatalisador: Boolean; override;
    procedure pPreencherPesCorFor(const dtsCadTin: IDataSet); override;
    function GetUniversal(const dtsCadTin: IDataSet): string; override;

  {$IFNDEF LINUX}
    procedure pRecalculaFormulaMostrarPadrao(var lsvFormulacao: TListView;
      Base: TBaseAutomotiva; intDecimaisPrecoVenda, intDecimaisPesoEspecifico: Integer;
      blnConsLinhaDesBas: Boolean; strTipBas: String; intCont: Integer); override;
  {$ENDIF}

  {$IFNDEF LINUX}
    procedure pRecalculaFormulaMostrarDigitado(var lsvFormulacao: TListView;
      Base: TBaseAutomotiva; intDecimaisPrecoVenda, intDecimaisPesoEspecifico: Integer;
      fltFator: Double; blnConsLinhaDesBas: Boolean; intCont: Integer;
      strLinha: String; strTipBas: String); override;
  {$ENDIF}

    function GetVolumeMaximoLitro(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoGalao(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoLata(dtsCadTin: IDataSet): Double; override;
    function GetVolumeMaximoTambor(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoSpray(dtsCadTin: IDataSet): Double; Override;

    function GetVolumePadraGalao(dtsCadTin: IDataSet): Double;  Override;
    function GetVolumePadraoLata(dtsCadTin: IDataSet): Double; override;
    function fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer; dtsCadTin: IDataSet): Double; Override;
    function fExisteConfiguracao(dtsCadTin: IDataSet; strUnidade: String): Boolean; Override;
end;

implementation

uses
  untAbstractCalculadorFormulaAutomotiva, untAutcomTintaFactory;

{ TFormulaAutomotivaTopCoat }

procedure TFormulaAutomotivaTopCoat.CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva);
begin
  Base.Cnv_Ml := Base.Embalagem * Base.PesoEspecifico;
end;

function TFormulaAutomotivaTopCoat.fCalculaQuantidadeParaBaixaEstoque(Base: TBaseAutomotiva): Double;
begin
  Result := TAutcomTintaFactory.Get.IIF(base.QuantidadeConcentrado > 0, base.QuantidadeConcentrado, base.QuantidadeDiluido) * (Self.fltVolumePro / Self.fltVolumeOri);
end;

function TFormulaAutomotivaTopCoat.fExisteConfiguracao(
  dtsCadTin: IDataSet; strUnidade: String): Boolean;
Var
  qryConf: IDataSet;
begin
  Try
    qryConf := TAutcomTintaFactory.Get.fGetDataSet;
    qryConf.Close;
    qryConf.SQL := '';
    qryConf.SQL := qryConf.SQL + '  SELECT              ';
    qryConf.SQL := qryConf.SQL + '    *                 ';
    qryConf.SQL := qryConf.SQL + '  FROM                ';
    qryConf.SQL := qryConf.SQL + '    CFGTIN            ';
    qryConf.SQL := qryConf.SQL + '  WHERE               ';
    qryConf.SQL := qryConf.SQL + '    CFG_IDEPRO = "COA" AND        ';
    qryConf.SQL := qryConf.SQL + '    CFG_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" AND      ';

    If strUnidade = 'Litro' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "LITVOL"        '
    Else If strUnidade = 'Galão' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "GALVOL"        '
    Else If strUnidade = 'Lata' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "LATVOL"        '
    Else If strUnidade = 'Tambor' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "TAMVOL"        '
    Else If strUnidade = 'Spray' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "SPRVOL"        ';

    qryConf.Open;

    Result := (Not qryConf.IsEmpty);
  Except
    Raise;
  End;
end;

function TFormulaAutomotivaTopCoat.fMostrarComCatalisador: Boolean;
begin
  Result := False;
end;


function TFormulaAutomotivaTopCoat.fValidaVolumeFormulucao(strTipoPre: String;
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaTopCoat.fVolumePadraoLitro(
  fltVolumePadraoLitro: Double; intModoVenda: Integer;
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 0.900;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('COA').fGetDouble('LITVOL'), 3);
end;

function TFormulaAutomotivaTopCoat.GetAcrescimoDespesaOperacionalTinta: Double;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('COA').fGetDouble('DESOPE');
end;

function TFormulaAutomotivaTopCoat.GetAno(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('COA_ANOCOR').AsString;
end;

function TFormulaAutomotivaTopCoat.GetCalcDespesasOperacionais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdAux    : Double;
  fltVenBas : Double;
begin
  fltQtdAux := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdAux := (fltQtdAux * formula.VolumePro / formula.VolumeOri);

  fltVenBas := (fltQtdAux *( base.PrecoVenda / base.Cnv_Ml));

  Result := (fltVenBas * base.DespesasOperacionais / 100);
end;

function TFormulaAutomotivaTopCoat.GetCalcIcmsSaida(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
Var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  fltVenBas := (fltQtdFor * (base.PrecoVenda / base.Cnv_Ml));

  Result := (fltVenBas * base.IcmsSaida / 100);
end;

function TFormulaAutomotivaTopCoat.GetCalcImpostosFederais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
Var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  fltVenBas := (fltQtdFor * (base.PrecoVenda / base.Cnv_Ml));

  Result := (fltVenBas * base.ImpostosFederais / 100);
end;

function TFormulaAutomotivaTopCoat.GetCalcOutrosValores(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.OutrosValores / base.Cnv_Ml)));
end;

function TFormulaAutomotivaTopCoat.GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.PrecoCompraLiquido / base.Cnv_Ml)));
end;

function TFormulaAutomotivaTopCoat.GetCalcPrecoCusto(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.PrecoCusto / base.Cnv_Ml)));
end;

function TFormulaAutomotivaTopCoat.GetCalcPrecoCustoReal(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.PrecoCustoReal / base.Cnv_Ml)));
end;

function TFormulaAutomotivaTopCoat.GetCalcPrecoMedio(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.PrecoMedio / base.Cnv_Ml)));
end;

function TFormulaAutomotivaTopCoat.GetCalcPrecoVenda(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.PrecoVenda / base.Cnv_Ml)));
end;

function TFormulaAutomotivaTopCoat.GetCalcQuantidade(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := (TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido) * formula.VolumePro / formula.VolumeOri);
end;

function TFormulaAutomotivaTopCoat.GetCalculadorInterno: ICalculadorFormulaAutomotiva;
begin
  Result := TAbstractCalculadorFormulaAutomotiva.Create(Self);
end;

function TFormulaAutomotivaTopCoat.GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := (fltQtdFor * (base.UltimoPrecoCompra / base.Cnv_Ml));
end;

function TFormulaAutomotivaTopCoat.GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.UltimoPrecoCompraImpostos / base.Cnv_Ml)));
end;

function TFormulaAutomotivaTopCoat.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('COA_MD5KEY').AsString;
end;

function TFormulaAutomotivaTopCoat.GetCodFormul(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('COA_CODIGO').AsString;
end;

function TFormulaAutomotivaTopCoat.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('COA_DESCRI').AsString;
end;

function TFormulaAutomotivaTopCoat.GetDescricaoBase(strCodBas: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DESCRI '+
                    '  FROM COA_CADBAS '+
                    ' WHERE BAS_CODBAS = :CODBAS';
      qryGen.ParamByName('CODBAS').AsString := strCodBas;
      qryGen.Open;

      Result := qryGen.FieldByName('BAS_DESCRI').AsString;

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

function TFormulaAutomotivaTopCoat.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaAutomotivaTopCoat.GetIdePro: String;
begin
  Result := 'COA';
end;

function TFormulaAutomotivaTopCoat.GetIndEmb(
  const dtsCadTin: IDataSet): integer;
begin
  Result := -1;
end;

function TFormulaAutomotivaTopCoat.GetMontadora(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('COA_MONTAD').AsString;
end;

function TFormulaAutomotivaTopCoat.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaAutomotivaTopCoat.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaAutomotivaTopCoat.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaAutomotivaTopCoat.GetNomeTabelaBases: String;
begin
  Result := 'COA_CADBAS';
end;

Procedure TFormulaAutomotivaTopCoat.pPreencherPesCorFor(const dtsCadTin: IDataSet);
begin
  Self.PesoCor := 0;
  Self.PesoFor := 0;
end;

{$IFNDEF LINUX}
procedure TFormulaAutomotivaTopCoat.pRecalculaFormulaMostrarDigitado(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; fltFator: Double;
  blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha, strTipBas: String);
begin
  inherited;
  Begin
    lsvFormulacao.Items.Add.Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    lsvFormulacao.Items[intCont].SubItems.Add(strTipBas);
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado * fltFator, ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.QuantidadeDiluido * fltFator, ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.QuantidadeDiluido2 * fltFator, ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TFormulaAutomotivaTopCoat.pRecalculaFormulaMostrarPadrao(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; blnConsLinhaDesBas: Boolean;
  strTipBas: String; intCont: Integer);
begin
  inherited;
  Begin
    lsvFormulacao.Items.Add.Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    lsvFormulacao.Items[intCont].SubItems.Add(strTipBas);
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado, ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.QuantidadeDiluido, ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.QuantidadeDiluido2, ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

function TFormulaAutomotivaTopCoat.GetPrefixoFormulacao: String;
begin
  Result := 'COA_BASE';
end;

function TFormulaAutomotivaTopCoat.GetPrefixoLitragem(
  const strModo: String): String;
begin
  Result := '';
end;

function TFormulaAutomotivaTopCoat.GetPrefixoQuantidade(const strModo: String): String;
begin
  If strModo = 'C' Then
    Result := 'COA_QTDC'
  Else
    Result := 'COA_QTDD';
end;

function TFormulaAutomotivaTopCoat.GetProdutoVendaTinta(const dtsCadTin: IDataSet): string;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('COA').fGet('COAPRO');
end;

function TFormulaAutomotivaTopCoat.GetQuantidadeFormulacao: Integer;

begin
  Result := 20;
end;

function TFormulaAutomotivaTopCoat.GetSelectBases: String;
begin
  Result := ' SELECT         ' +
            '     BAS_CODBAS ' +
            '   , BAS_CODITE ' +
            '   , BAS_EMBALA ' +
            '   , BAS_PESESP ' +
            '   , IFNULL(ITE_ITEATI, "N") ITE_ITEATI ' +
            '   , ITE_CNV_ML ' +
            '   , ITE_OUTVAL ' +
            '   , ITE_ICMSAI ' +
            '   , ITE_IMPFED ' +
            '   , ITE_DESOPE ' +
            '   , ITE_PREMED ' +
            '   , ITE_IMPULT ' +
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

function TFormulaAutomotivaTopCoat.GetTextoInformativoCalculo: String;
Var
  fltVolume : Double;
begin
  fltVolume := TAutcomTintaFactory.Get.IIF(VolumeConcentrado > 0, VolumeConcentrado, VolumeDiluido) * 1000;

  Result  :=
    'Volume         = ' + FloatToStrF(fltVolume , ffFixed, 12, 3)+ sLineBreak +
    'Quantidade     = Quantidade * (Volume Digitado / Volume)    '+ sLineBreak +
    'Valor da Base  = ((Quantidade * Preço) / (Peso Específico * Embalagem)) ' + sLineBreak +
    'Preço da Tinta = Soma do valor de todas as bases.';
end;

function TFormulaAutomotivaTopCoat.GetUniversal(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaTopCoat.GetVolumeMaximoGalao(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 4.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('COA').fGetDouble('GALVOL'), 3);
end;

function TFormulaAutomotivaTopCoat.GetVolumeMaximoLata(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('COA').fGetDouble('LATVOL'), 3);
end;

function TFormulaAutomotivaTopCoat.GetVolumeMaximoLitro(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 0.900;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('COA').fGetDouble('LITVOL'), 3);
end;

function TFormulaAutomotivaTopCoat.GetVolumeMaximoSpray(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Spray') Then
  Begin
    Result := 0.100;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('COA').fGetDouble('SPRVOL'), 3);
end;

function TFormulaAutomotivaTopCoat.GetVolumeMaximoTambor(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Tambor') Then
  Begin
    Result := 200.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('COA').fGetDouble('TAMVOL'), 3);
end;

function TFormulaAutomotivaTopCoat.GetVolumePadraCopo: Double;
begin
  Result := 0;
end;


function TFormulaAutomotivaTopCoat.GetVolumePadraGalao(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 3.600;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('COA').fGetDouble('GALVOL'), 3);
end;

function TFormulaAutomotivaTopCoat.GetVolumePadraoLata(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('COA').fGetDouble('LATVOL'), 3);
end;

function TFormulaAutomotivaTopCoat.GetVolumePadraSpray: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Spray') Then
  Begin
    Result := 0.100;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('COA').fGetDouble('SPRVOL'), 3);
end;


function TFormulaAutomotivaTopCoat.GetVolumePadraTambor(dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Tambor') Then
  Begin
    Result := 200.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('COA').fGetDouble('TAMVOL'), 3);
end;

function TFormulaAutomotivaTopCoat.GetVolumePermitido(
  const dtsCadTin: IDataSet; strTipoPre: String): Double;
begin
  Result := 0;
end;

procedure TFormulaAutomotivaTopCoat.pDefineVolumeOriginal;
begin
  If Self.mveModoVenda = mvConcentrado Then
    Self.VolumeOri := Self.VolumeConcentrado
  Else
    Self.VolumeOri := Self.VolumeDiluido;
end;

procedure TFormulaAutomotivaTopCoat.pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet);
var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('COA');


  sProEmbTb := '';
  sProEmbBa := '';
  sProEmbSs := '';
  sProEmbPo := '';
  sProEmbSd := '';

  stlDesEmb.Clear;
  stlDesEmb.Add('');

  stlProEmbLt.Add(Conf.fGet('LITEMB'));
  stlProEmbGl.Add(Conf.fGet('GALEMB'));
  stlProEmbLa.Add(Conf.fGet('LATEMB'));
  strProEmbSp := Conf.fGet('SPREMB');
  strProEmbTb := Conf.fGet('TAMEMB');
end;

procedure TFormulaAutomotivaTopCoat.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('COA_ACRMOB').AsFloat;
end;

procedure TFormulaAutomotivaTopCoat.PreencheQuantidadeFormulacaoVenda(
  const dtsCadTin: IDataSet);
var
  intContador: Integer;
  Base       : TBaseAutomotiva;
begin
  For intContador := 1 To Self.GetQuantidadeFormulacao Do
  Begin

    If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('COA_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
      Break;

    Base             := TBaseAutomotiva(Self.Add);
    Base.CodigoBase  := dtsCadTin.FieldByName('COA_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString;
    Base.QuantidadeConcentrado := dtsCadTin.FieldByName('COA_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
    Base.QuantidadeDiluido := dtsCadTin.FieldByName('COA_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
    Base.TipoBase   := 'B';
  End;
end;

procedure TFormulaAutomotivaTopCoat.PreencheVolumeVenda(const dtsCadTin: IDataSet);
begin
  Self.VolumeOri         := 0.9;
  Self.VolumeConcentrado := 0.9;
  Self.VolumeDiluido     := 0.9;
end;

end.
