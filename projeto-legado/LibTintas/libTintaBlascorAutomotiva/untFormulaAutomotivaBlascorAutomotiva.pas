{************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula BlascorAutomotiva *}
{*********************************************************************AC*}
unit untFormulaAutomotivaBlascorAutomotiva;

interface

uses
{$IFNDEF LINUX}
  Controls,
  ComCtrls,
{$ENDIF}
  untAbstractFormulaAutomotiva, untICalculadorFormulaAutomotiva, untIDataSet, untBaseAutomotiva,
  SysUtils, untStrUtils, Classes, untIConfTinta, untFloatUtils, untModoVenda, untIDicionario, Math;

type
  TMinMax = record
    fltMin : Double;
    fltMax : Double;
  end;

type
  TFormulaAutomotivaBlascorAutomotiva = class(TAbstractFormulaAutomotiva)
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
    function GetVolumeMaximoCopo(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoSpray(dtsCadTin: IDataSet): Double; Override;

    function GetVolumePadraGalao(dtsCadTin: IDataSet): Double;  Override;
    function GetVolumePadraoLata(dtsCadTin: IDataSet): Double; override;
    function GetVolumePadraSpray : Double; Override;
    function GetVolumePadraTambor(dtsCadTin: IDataSet): Double; Override;
    function fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer; dtsCadTin: IDataSet): Double; Override;
    function fExisteConfiguracao(dtsCadTin: IDataSet; strUnidade: String): Boolean; Override;
    function GetUsaChapinha(const dtsCadTin: IDataSet): Boolean; Override;
    function GetProdutoChapinha(): String; Override;
end;

implementation

uses
  untAbstractCalculadorFormulaAutomotiva, untAutcomTintaFactory;

{ TFormulaAutomotivaBlascorAutomotiva }

procedure TFormulaAutomotivaBlascorAutomotiva.CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva);
begin
  Base.Cnv_Ml := Base.Embalagem * Base.PesoEspecifico;
end;

function TFormulaAutomotivaBlascorAutomotiva.fCalculaQuantidadeParaBaixaEstoque(Base: TBaseAutomotiva): Double;
begin
  Result := TAutcomTintaFactory.Get.IIF(base.QuantidadeConcentrado > 0, base.QuantidadeConcentrado, base.QuantidadeDiluido) * (Self.fltVolumePro / Self.fltVolumeOri);
end;

function TFormulaAutomotivaBlascorAutomotiva.fExisteConfiguracao(
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
    qryConf.SQL := qryConf.SQL + '    CFG_IDEPRO = "BLA" AND        ';
    qryConf.SQL := qryConf.SQL + '    CFG_CODEMP = :CODEMP          ';

    If strUnidade = 'Litro' Then
      qryConf.SQL := qryConf.SQL + ' AND CFG_CODCFG = "LITVOL"        '
    Else If strUnidade = 'Galão' Then
      qryConf.SQL := qryConf.SQL + ' AND  CFG_CODCFG = "GALVOL"        '
    Else If strUnidade = 'Lata' Then
      qryConf.SQL := qryConf.SQL + ' AND CFG_CODCFG = "LATVOL"        '
    Else If strUnidade = 'Copo' Then
      qryConf.SQL := qryConf.SQL + ' AND CFG_CODCFG = "COPVOL"        '
    Else If strUnidade = 'Spray' Then
      qryConf.SQL := qryConf.SQL + ' AND CFG_CODCFG = "SPRVOL"        '
    Else
      Exit(False);

    qryConf.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryConf.Open;

    Result := (Not qryConf.IsEmpty);
  Except
    Raise;
  End;
end;

function TFormulaAutomotivaBlascorAutomotiva.fMostrarComCatalisador: Boolean;
begin
  Result := False;
end;


function TFormulaAutomotivaBlascorAutomotiva.fValidaVolumeFormulucao(strTipoPre: String;
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaBlascorAutomotiva.fVolumePadraoLitro(
  fltVolumePadraoLitro: Double; intModoVenda: Integer;
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 0.900;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('BLA').fGetDouble('LITVOL'), 3);
end;

function TFormulaAutomotivaBlascorAutomotiva.GetAcrescimoDespesaOperacionalTinta: Double;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('BLA').fGetDouble('DESOPE');
end;

function TFormulaAutomotivaBlascorAutomotiva.GetAno(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('BLA_ANOINI').AsString;
end;

function TFormulaAutomotivaBlascorAutomotiva.GetCalcDespesasOperacionais(const base: TBaseAutomotiva;
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

function TFormulaAutomotivaBlascorAutomotiva.GetCalcIcmsSaida(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
Var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  fltVenBas := (fltQtdFor * (base.PrecoVenda / base.Cnv_Ml));

  Result := (fltVenBas * base.IcmsSaida / 100);
end;

function TFormulaAutomotivaBlascorAutomotiva.GetCalcImpostosFederais(const base: TBaseAutomotiva;
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

function TFormulaAutomotivaBlascorAutomotiva.GetCalcOutrosValores(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.OutrosValores / base.Cnv_Ml)));
end;

function TFormulaAutomotivaBlascorAutomotiva.GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.PrecoCompraLiquido / base.Cnv_Ml)));
end;

function TFormulaAutomotivaBlascorAutomotiva.GetCalcPrecoCusto(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.PrecoCusto / base.Cnv_Ml)));
end;

function TFormulaAutomotivaBlascorAutomotiva.GetCalcPrecoCustoReal(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.PrecoCustoReal / base.Cnv_Ml)));
end;

function TFormulaAutomotivaBlascorAutomotiva.GetCalcPrecoMedio(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.PrecoMedio / base.Cnv_Ml)));
end;

function TFormulaAutomotivaBlascorAutomotiva.GetCalcPrecoVenda(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.PrecoVenda / base.Cnv_Ml)));
end;

function TFormulaAutomotivaBlascorAutomotiva.GetCalcQuantidade(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := (TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido) * formula.VolumePro / formula.VolumeOri);
end;

function TFormulaAutomotivaBlascorAutomotiva.GetCalculadorInterno: ICalculadorFormulaAutomotiva;
begin
  Result := TAbstractCalculadorFormulaAutomotiva.Create(Self);
end;

function TFormulaAutomotivaBlascorAutomotiva.GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := (fltQtdFor * (base.UltimoPrecoCompra / base.Cnv_Ml));
end;

function TFormulaAutomotivaBlascorAutomotiva.GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.UltimoPrecoCompraImpostos / base.Cnv_Ml)));
end;

function TFormulaAutomotivaBlascorAutomotiva.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('BLA_MD5KEY').AsString;
end;

function TFormulaAutomotivaBlascorAutomotiva.GetCodFormul(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('BLA_CODIGO').AsString;
end;

function TFormulaAutomotivaBlascorAutomotiva.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('BLA_DESCRI').AsString;
end;

function TFormulaAutomotivaBlascorAutomotiva.GetDescricaoBase(strCodBas: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DESCRI '+
                    '  FROM BLA_CADBAS '+
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

function TFormulaAutomotivaBlascorAutomotiva.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaAutomotivaBlascorAutomotiva.GetIdePro: String;
begin
  Result := 'BLA';
end;

function TFormulaAutomotivaBlascorAutomotiva.GetIndEmb(
  const dtsCadTin: IDataSet): integer;
begin
  Result := -1;
end;

function TFormulaAutomotivaBlascorAutomotiva.GetMontadora(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('MON_DESCRI').AsString;
end;

function TFormulaAutomotivaBlascorAutomotiva.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaAutomotivaBlascorAutomotiva.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaAutomotivaBlascorAutomotiva.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaAutomotivaBlascorAutomotiva.GetNomeTabelaBases: String;
begin
  Result := 'BLA_CADBAS';
end;

Procedure TFormulaAutomotivaBlascorAutomotiva.pPreencherPesCorFor(const dtsCadTin: IDataSet);
begin
  Self.PesoCor := 0;
  Self.PesoFor := 0;
end;

{$IFNDEF LINUX}
procedure TFormulaAutomotivaBlascorAutomotiva.pRecalculaFormulaMostrarDigitado(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; fltFator: Double;
  blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha, strTipBas: String);
var
  intDec: Integer;
begin
  intDec := StrToIntDef(TAutcomTintaFactory.Get.fGetConfTinta('BLA').fGet('DECFOR'), 1);

  inherited;
  Begin
    lsvFormulacao.Items.Add.Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    lsvFormulacao.Items[intCont].SubItems.Add(strTipBas);
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(RoundTo(Base.QuantidadeConcentrado * fltFator, - intDec), ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(RoundTo(Base.QuantidadeDiluido * fltFator, - intDec), ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(RoundTo(Base.QuantidadeDiluido2 * fltFator, - intDec), ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TFormulaAutomotivaBlascorAutomotiva.pRecalculaFormulaMostrarPadrao(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; blnConsLinhaDesBas: Boolean;
  strTipBas: String; intCont: Integer);
var
  intDec: Integer;
begin
  intDec := StrToIntDef(TAutcomTintaFactory.Get.fGetConfTinta('BLA').fGet('DECFOR'), 1);

  inherited;
  Begin
    lsvFormulacao.Items.Add.Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    lsvFormulacao.Items[intCont].SubItems.Add(strTipBas);
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(RoundTo(Base.QuantidadeConcentrado, - intDec), ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(RoundTo(Base.QuantidadeDiluido, - intDec), ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(RoundTo(Base.QuantidadeDiluido2, - intDec), ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

function TFormulaAutomotivaBlascorAutomotiva.GetPrefixoFormulacao: String;
begin
  Result := 'BLA_BASE';
end;

function TFormulaAutomotivaBlascorAutomotiva.GetPrefixoLitragem(
  const strModo: String): String;
begin
  Result := '';
end;

function TFormulaAutomotivaBlascorAutomotiva.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'BLA_QTDB'
end;

function TFormulaAutomotivaBlascorAutomotiva.GetProdutoChapinha: String;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('BLA').fGet('PROCHA');
end;

function TFormulaAutomotivaBlascorAutomotiva.GetProdutoVendaTinta(const dtsCadTin: IDataSet): string;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('BLA').fGet('BLAPRO');
end;

function TFormulaAutomotivaBlascorAutomotiva.GetQuantidadeFormulacao: Integer;

begin
  Result := 20;
end;

function TFormulaAutomotivaBlascorAutomotiva.GetSelectBases: String;
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

function TFormulaAutomotivaBlascorAutomotiva.GetTextoInformativoCalculo: String;
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

function TFormulaAutomotivaBlascorAutomotiva.GetUniversal(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaBlascorAutomotiva.GetUsaChapinha(
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := (dtsCadTin.FieldByName('BLA_PROCHA').AsString = 'S');
end;

function TFormulaAutomotivaBlascorAutomotiva.GetVolumeMaximoCopo(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Copo') Then
  Begin
    Result := 0.500;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('BLA').fGetDouble('COPVOL'), 3);
end;

function TFormulaAutomotivaBlascorAutomotiva.GetVolumeMaximoGalao(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 4.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('BLA').fGetDouble('GALVOL'), 3);
end;

function TFormulaAutomotivaBlascorAutomotiva.GetVolumeMaximoLata(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('BLA').fGetDouble('LATVOL'), 3);
end;

function TFormulaAutomotivaBlascorAutomotiva.GetVolumeMaximoLitro(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 0.900;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('BLA').fGetDouble('LITVOL'), 3);
end;


function TFormulaAutomotivaBlascorAutomotiva.GetVolumeMaximoSpray(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Spray') Then
  Begin
    Result := 0.400;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('BLA').fGetDouble('SPRVOL'), 3);
end;

function TFormulaAutomotivaBlascorAutomotiva.GetVolumePadraCopo: Double;
begin
  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('BLA').fGetDouble('COPVOL'), 3);
end;


function TFormulaAutomotivaBlascorAutomotiva.GetVolumePadraGalao(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 3.600;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('BLA').fGetDouble('GALVOL'), 3);
end;

function TFormulaAutomotivaBlascorAutomotiva.GetVolumePadraoLata(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('BLA').fGetDouble('LATVOL'), 3);
end;

function TFormulaAutomotivaBlascorAutomotiva.GetVolumePadraSpray: Double;
begin
  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('BLA').fGetDouble('SPRVOL'), 3);
end;

function TFormulaAutomotivaBlascorAutomotiva.GetVolumePadraTambor(
  dtsCadTin: IDataSet): Double;
begin
  Result := 0;
end;

function TFormulaAutomotivaBlascorAutomotiva.GetVolumePermitido(
  const dtsCadTin: IDataSet; strTipoPre: String): Double;
begin
  Result := 0;
end;

procedure TFormulaAutomotivaBlascorAutomotiva.pDefineVolumeOriginal;
begin
  If Self.mveModoVenda = mvConcentrado Then
    Self.VolumeOri := Self.VolumeConcentrado
  Else
    Self.VolumeOri := Self.VolumeDiluido;
end;

procedure TFormulaAutomotivaBlascorAutomotiva.pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet);
var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('BLA');


  sProEmbTb := '';
  sProEmbBa := '';
  sProEmbSs := '';
  sProEmbPo := '';
  sProEmbSd := '';
  sProEmbCo := '';

  stlDesEmb.Clear;
  stlDesEmb.Add('');

  stlProEmbLt.Add(Conf.fGet('LITEMB'));
  stlProEmbGl.Add(Conf.fGet('GALEMB'));
  stlProEmbLa.Add(Conf.fGet('LATEMB'));
  strProEmbCo := Conf.fGet('COPEMB');
  strProEmbSp := Conf.fGet('SPREMB');
end;

procedure TFormulaAutomotivaBlascorAutomotiva.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('BLA_ACRMOB').AsFloat;
end;

procedure TFormulaAutomotivaBlascorAutomotiva.PreencheQuantidadeFormulacaoVenda(
  const dtsCadTin: IDataSet);
var
  intContador: Integer;
  Base       : TBaseAutomotiva;
  blnDiluido : Boolean;
begin
  blnDiluido := False;

  For intContador := 1 To Self.GetQuantidadeFormulacao Do
  Begin
    If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('BLA_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
      Break;

    If  dtsCadTin.FieldByName('BLA_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString = 'TH 10000' Then
    Begin
      blnDiluido := True;
      Break;
    End;

    If  dtsCadTin.FieldByName('BLA_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString = 'TH 040' Then
    Begin
      blnDiluido := True;
      Break;
    End;
  End;

  If blnDiluido Then
  Begin
    For intContador := 1 To Self.GetQuantidadeFormulacao Do
    Begin
      If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('BLA_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
        Break;

      Base             := TBaseAutomotiva(Self.Add);
      Base.CodigoBase  := dtsCadTin.FieldByName('BLA_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString;
      Base.QuantidadeDiluido := dtsCadTin.FieldByName('BLA_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
      Base.TipoBase   := 'B';
    End;
  End
  Else
  Begin
    For intContador := 1 To Self.GetQuantidadeFormulacao Do
    Begin
      If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('BLA_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
        Break;

      Base             := TBaseAutomotiva(Self.Add);
      Base.CodigoBase  := dtsCadTin.FieldByName('BLA_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString;
      Base.QuantidadeConcentrado := dtsCadTin.FieldByName('BLA_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
      Base.TipoBase   := 'B';
    End;
  End;
end;

procedure TFormulaAutomotivaBlascorAutomotiva.PreencheVolumeVenda(const dtsCadTin: IDataSet);
begin
  Self.VolumeOri         := 0.9;
  Self.VolumeConcentrado := 0.9;
  Self.VolumeDiluido     := 0.9;
end;

end.
