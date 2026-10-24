{************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula KillingIndustrial *}
{*********************************************************************AC*}
unit untFormulaIndustrialKillingIndustrial;

interface

uses
{$IFNDEF LINUX}
  Controls,
  ComCtrls,
{$ENDIF}
  untAbstractFormulaAutomotiva, untICalculadorFormulaAutomotiva, untIDataSet, untBaseAutomotiva,
  SysUtils, untStrUtils, Classes, untIConfTinta, untFloatUtils, untModoVenda;

type
  TFormulaIndustrialKillingIndustrial = class(TAbstractFormulaAutomotiva)
  private
    function fCalculaPesoEspecificoBase(strBase: String): Double;

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

    function GetVolumePadraLitro: Double;
    function GetVolumePadraGalao(dtsCadTin: IDataSet): Double; override;

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

//    function fPermiteMostrarComboDeEmbalagem: Boolean; override;
  {$IFNDEF LINUX}
    procedure pReajustarColunasFormulacao(var lsvFormulacao: TListView); Override;
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

    function GetVolumeMaximoLitro(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoGalao(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoLata(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoCopo(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoSpray(dtsCadTin: IDataSet): Double; Override;

    function fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer; dtsCadTin: IDataSet): Double; override;
    function GetVolumePadraoLata(dtsCadTin: IDataSet): Double; override;

    function fExisteConfiguracao(dtsCadTin: IDataSet; strEmbalagem: String): Boolean; Override;
    function fDefiniTamTelaFormulacao(): Integer; Override;
  end;

implementation

uses
  untAbstractCalculadorFormulaAutomotiva, untAutcomTintaFactory;

{ TFormulaIndustrialKillingIndustrial }

procedure TFormulaIndustrialKillingIndustrial.CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva);
begin
  Base.Cnv_Ml := Base.Embalagem * Base.PesoEspecifico;
end;

function TFormulaIndustrialKillingIndustrial.fCalculaPesoEspecificoBase(
  strBase: String): Double;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.Close;
    qryGen.SQL := '';
    qryGen.SQL := qryGen.SQL + '  SELECT                  ';
    qryGen.SQL := qryGen.SQL + '    BAS_PESESP            ';
    qryGen.SQL := qryGen.SQL + '  FROM                    ';
    qryGen.SQL := qryGen.SQL + '    KIN_CADBAS            ';
    qryGen.SQL := qryGen.SQL + '  WHERE                   ';
    qryGen.SQL := qryGen.SQL + '    BAS_CODBAS = :CODBAS        ';

    qryGen.ParamByName('CODBAS').AsString := strBase;
    qryGen.Open;

    Result := qryGen.FieldByName('BAS_PESESP').AsFloat;
  Except
    Raise;
  End;
end;

function TFormulaIndustrialKillingIndustrial.fCalculaQuantidadeParaBaixaEstoque(
  Base: TBaseAutomotiva): Double;
begin
  Result := Base.QuantidadeConcentrado * (Self.fltVolumePro / Self.fltVolumeOri);
end;

function TFormulaIndustrialKillingIndustrial.fDefiniTamTelaFormulacao: Integer;
begin
  Result := 770;
end;

function TFormulaIndustrialKillingIndustrial.fExisteConfiguracao(
  dtsCadTin: IDataSet; strEmbalagem: String): Boolean;
Var
  qryConf: IDataSet;
begin
  Try
    qryConf := TAutcomTintaFactory.Get.fGetDataSet;
    qryConf.Close;
    qryConf.SQL := '';
    qryConf.SQL := qryConf.SQL + '  SELECT                  ';
    qryConf.SQL := qryConf.SQL + '    *                     ';
    qryConf.SQL := qryConf.SQL + '  FROM                    ';
    qryConf.SQL := qryConf.SQL + '    CFGTIN                ';
    qryConf.SQL := qryConf.SQL + '  WHERE                   ';
    qryConf.SQL := qryConf.SQL + '    CFG_IDEPRO = "KIN" AND            ';
    qryConf.SQL := qryConf.SQL + '    CFG_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" AND          ';

    If strEmbalagem = 'Litro' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLLIT"         '
    Else If strEmbalagem = 'Galão' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLGAL"         '
    Else If strEmbalagem = 'Lata' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLLAT"         '
    Else If strEmbalagem = 'Copo' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLCOP"         '
    Else If strEmbalagem = 'Spray' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLSPR"         ';

    qryConf.Open;


    Result := (Not qryConf.IsEmpty);
  Except
    Raise;
  End;
end;

function TFormulaIndustrialKillingIndustrial.fMostrarComCatalisador: Boolean;
begin
  Result := False;
end;

//function TFormulaIndustrialKillingIndustrial.fPermiteMostrarComboDeEmbalagem: Boolean;
//begin
//  Result := false;
//end;

function TFormulaIndustrialKillingIndustrial.fValidaVolumeFormulucao(strTipoPre: String;
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := True;
end;

function TFormulaIndustrialKillingIndustrial.fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer;
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 0.900;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('KIN').fGetDouble('VOLLIT'), 3);
end;

function TFormulaIndustrialKillingIndustrial.GetAcrescimoDespesaOperacionalTinta: Double;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('KIN').fGetDouble('DESOPE');
end;

function TFormulaIndustrialKillingIndustrial.GetAno(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('KIN_ANOCOR').AsString;
end;

function TFormulaIndustrialKillingIndustrial.GetCalcDespesasOperacionais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdGrama    : Double;
  fltVenBas : Double;
begin
  fltQtdGrama := ((Formula.PesEspProduto / 100) * TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido))
    * (formula.VolumePro * 1000);

  fltVenBas := fltQtdGrama * (Base.PrecoVenda / (Base.Embalagem * Base.PesoEspecifico));

  Result := (base.DespesasOperacionais * fltVenBas / 100);
end;

function TFormulaIndustrialKillingIndustrial.GetCalcIcmsSaida(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdGrama    : Double;
  fltPreVenBas : Double;
begin
  fltQtdGrama := ((Formula.PesEspProduto / 100) * TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido))
    * (formula.VolumePro * 1000) ;

  fltPreVenBas := fltQtdGrama * (Base.PrecoVenda / (Base.Embalagem * Base.PesoEspecifico));

  Result := (fltPreVenBas * base.IcmsSaida / 100);
end;

function TFormulaIndustrialKillingIndustrial.GetCalcImpostosFederais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltVenBas: Double;
  fltQtdGrama : Double;
begin
  fltQtdGrama := ((Formula.PesEspProduto / 100) * TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido))
    * (formula.VolumePro * 1000);

  fltVenBas := fltQtdGrama * (Base.PrecoVenda / (Base.Embalagem * Base.PesoEspecifico));

  Result := (fltVenBas * base.ImpostosFederais / 100);
end;

function TFormulaIndustrialKillingIndustrial.GetCalcOutrosValores(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdGrama: Double;
begin
  fltQtdGrama := ((Formula.PesEspProduto / 100) * TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido))
    * (formula.VolumePro * 1000);

  Result := (fltQtdGrama * (Base.OutrosValores / (Base.Embalagem * Base.PesoEspecifico)));
end;

function TFormulaIndustrialKillingIndustrial.GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdGrama: Double;
begin
  fltQtdGrama := ((Formula.PesEspProduto / 100) * TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido))
    * (formula.VolumePro * 1000);

   Result := (fltQtdGrama * (Base.PrecoCompraLiquido / (Base.Embalagem * Base.PesoEspecifico)));
end;

function TFormulaIndustrialKillingIndustrial.GetCalcPrecoCusto(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdGrama: Double;
begin
  fltQtdGrama := ((Formula.PesEspProduto / 100) * TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido))
    * (formula.VolumePro * 1000);

  Result := (fltQtdGrama * (Base.PrecoCusto / (Base.Embalagem * Base.PesoEspecifico)));
end;

function TFormulaIndustrialKillingIndustrial.GetCalcPrecoCustoReal(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdGrama: Double;
begin
  fltQtdGrama := ((Formula.PesEspProduto / 100) * TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido))
    * (formula.VolumePro * 1000);

  Result := (fltQtdGrama * (Base.PrecoCustoReal / (Base.Embalagem * Base.PesoEspecifico)));
end;

function TFormulaIndustrialKillingIndustrial.GetCalcPrecoMedio(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdGrama: Double;
begin
  fltQtdGrama := ((Formula.PesEspProduto / 100) * TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido))
    * (formula.VolumePro * 1000);

  Result := (fltQtdGrama * (Base.PrecoMedio / (Base.Embalagem * Base.PesoEspecifico)));
end;

function TFormulaIndustrialKillingIndustrial.GetCalcPrecoVenda(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdGrama: Double;
Begin
  fltQtdGrama := ((Formula.PesEspProduto / 100) * TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido))
    * (formula.VolumePro * 1000);

  Result := (fltQtdGrama * (Base.PrecoVenda / (Base.Embalagem * Base.PesoEspecifico)));
end;

function TFormulaIndustrialKillingIndustrial.GetCalcQuantidade(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := ((Formula.PesEspProduto / 100) * TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido))
    * (formula.VolumePro * 1000);
end;

function TFormulaIndustrialKillingIndustrial.GetCalculadorInterno: ICalculadorFormulaAutomotiva;
begin
  Result := TAbstractCalculadorFormulaAutomotiva.Create(Self);
end;

function TFormulaIndustrialKillingIndustrial.GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdGrama: Double;
Begin
  fltQtdGrama := ((Formula.PesEspProduto / 100) * TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido))
    * (formula.VolumePro* 1000);

  Result := (fltQtdGrama * (Base.UltimoPrecoCompra / (Base.Embalagem * Base.PesoEspecifico)));
end;

function TFormulaIndustrialKillingIndustrial.GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdGrama: Double;
Begin
  fltQtdGrama := ((Formula.PesEspProduto / 100) * TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido))
    * (formula.VolumePro * 1000);

   Result := (fltQtdGrama * (Base.UltimoPrecoCompraImpostos / (Base.Embalagem * Base.PesoEspecifico)));
end;

function TFormulaIndustrialKillingIndustrial.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('KIN_MD5KEY').AsString;
end;

function TFormulaIndustrialKillingIndustrial.GetCodFormul(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaIndustrialKillingIndustrial.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('KIN_DESCRI').AsString + ' - ' +
            dtsCadTin.FieldByName('KIN_CODIGO').AsString;
end;

function TFormulaIndustrialKillingIndustrial.GetDescricaoBase(strCodBas: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DESCRI '+
                    '  FROM KIN_CADBAS '+
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

function TFormulaIndustrialKillingIndustrial.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaIndustrialKillingIndustrial.GetIdePro: String;
begin
  Result := 'KIN';
end;

function TFormulaIndustrialKillingIndustrial.GetIndEmb(
  const dtsCadTin: IDataSet): integer;
begin
  Result := -1;
end;

function TFormulaIndustrialKillingIndustrial.GetMontadora(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('MON_DESCRI').AsString;
end;

function TFormulaIndustrialKillingIndustrial.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaIndustrialKillingIndustrial.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaIndustrialKillingIndustrial.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaIndustrialKillingIndustrial.GetNomeTabelaBases: String;
begin
  Result := 'KIN_CADBAS';
end;

Procedure TFormulaIndustrialKillingIndustrial.pPreencherPesCorFor(const dtsCadTin: IDataSet);
Var
  intContador: Integer;
  fltQtdTotal: Double;
begin
  fltQtdTotal := 0;

  For intContador := 1 To  GetQuantidadeFormulacao Do
  Begin

    If TStrUtils.fEmptyStr(dtsCadTin.FieldByName('KIN_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
      Break;

    fltQtdTotal := fltQtdTotal + (1 / fCalculaPesoEspecificoBase(dtsCadTin.FieldByName('KIN_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString) *
      dtsCadTin.FieldByName('KIN_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat);
  End;

  Self.PesEspProduto := (100 / fltQtdTotal);
end;

{$IFNDEF LINUX}
procedure TFormulaIndustrialKillingIndustrial.pReajustarColunasFormulacao(
  var lsvFormulacao: TListView);
begin
  lsvFormulacao.Columns.Clear;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taLeftJustify;
    Caption   := 'Base';
    Width     := 215;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taLeftJustify;
    Caption   := 'Tipo';
    Width     := 90;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption   := 'Quantidade(g)';
    Width     := 85;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption   := 'Percentual(%)';
    Width     := 85;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption   := 'Preço';
    Width     := 90;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption   := 'Embalagem';
    Width     := 90;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption   := 'Peso Esp.';
    Width     := 80;
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TFormulaIndustrialKillingIndustrial.pRecalculaFormulaMostrarDigitado(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; fltFator: Double;
  blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha: String;
  strTipBas: String);
begin

  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    fltFator := (Self.VolumePro * 1000) * (Self.PesEspProduto / 100);


    SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado * fltFator, ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado, ffFixed, 12, 2));
    SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TFormulaIndustrialKillingIndustrial.pRecalculaFormulaMostrarPadrao(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; blnConsLinhaDesBas: Boolean;
  strTipBas: String; intCont: Integer);
Var
  fltFator: Double;
begin

  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    fltFator := (Self.VolumeOri * 1000) * (Self.PesEspProduto / 100);

    SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado * fltFator, ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado, ffFixed, 12, 2));
    SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}


function TFormulaIndustrialKillingIndustrial.GetPrefixoFormulacao: String;
begin
  Result := 'KIN_BASE';
end;

function TFormulaIndustrialKillingIndustrial.GetPrefixoLitragem(
  const strModo: String): String;
begin
  Result := '';
end;

function TFormulaIndustrialKillingIndustrial.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'KIN_QTDB';
end;

function TFormulaIndustrialKillingIndustrial.GetProdutoVendaTinta(const dtsCadTin: IDataSet): string;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('KIN').fGet('KINPRO');
end;

function TFormulaIndustrialKillingIndustrial.GetQuantidadeFormulacao: Integer;

begin
  Result := 20;
end;

function TFormulaIndustrialKillingIndustrial.GetSelectBases: String;
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

function TFormulaIndustrialKillingIndustrial.GetTextoInformativoCalculo: String;
begin
  Result :=
    'Peso Específico do Produto = ' + FloatToStrF(PesEspProduto, ffNumber, 12, 3) + ' ' + sLineBreak +
    'Percentual(%) = (Quantidade da Base) ' + sLineBreak +
    'Quantidade(g) = ((Peso Específico do Produto / 100) * Percentual) * Volume Produzido ' + sLineBreak +
    'Valor da Base = (Preço / Embalagem) * (Quantidade(g) / Peso Específico)';
end;

function TFormulaIndustrialKillingIndustrial.GetUniversal(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('KIN_SISTEM').AsString;
end;

function TFormulaIndustrialKillingIndustrial.GetVolumeMaximoCopo(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Copo') Then
  Begin
    Result := 0.500;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('KIN').fGetDouble('VOLCOP'), 3);
end;

function TFormulaIndustrialKillingIndustrial.GetVolumeMaximoGalao(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 4.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('KIN').fGetDouble('VOLGAL'), 3);
end;

function TFormulaIndustrialKillingIndustrial.GetVolumeMaximoLata(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('KIN').fGetDouble('VOLLAT'), 3);
end;

function TFormulaIndustrialKillingIndustrial.GetVolumeMaximoLitro(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 1.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('KIN').fGetDouble('VOLLIT'), 3);
end;

function TFormulaIndustrialKillingIndustrial.GetVolumeMaximoSpray(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Spray') Then
  Begin
    Result := 0.100;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('KIN').fGetDouble('VOLSPR'), 3);
end;

function TFormulaIndustrialKillingIndustrial.GetVolumePadraCopo: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Copo') Then
  Begin
    Result := 0.500;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('KIN').fGetDouble('VOLCOP'), 3);
end;

function TFormulaIndustrialKillingIndustrial.GetVolumePadraGalao(dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 3.600;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('KIN').fGetDouble('VOLGAL'), 3);
end;

function TFormulaIndustrialKillingIndustrial.GetVolumePadraoLata(dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('KIN').fGetDouble('VOLLAT'), 3);
end;

function TFormulaIndustrialKillingIndustrial.GetVolumePadraLitro: Double;
begin
  Result := 0.900;
end;

function TFormulaIndustrialKillingIndustrial.GetVolumePadraSpray: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Spray') Then
  Begin
    Result := 0.100;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('KIN').fGetDouble('VOLSPR'), 3);
end;


function TFormulaIndustrialKillingIndustrial.GetVolumePadraTambor(dtsCadTin: IDataSet): Double;
begin
  Result := 0;
end;

function TFormulaIndustrialKillingIndustrial.GetVolumePermitido(
  const dtsCadTin: IDataSet; strTipoPre: String): Double;
begin
    Result := 0;
end;

procedure TFormulaIndustrialKillingIndustrial.pDefineVolumeOriginal;
begin
  Self.VolumeOri := Self.VolumeConcentrado
end;

procedure TFormulaIndustrialKillingIndustrial.pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet);
var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('KIN');


  sProEmbTb := '';
  sProEmbBa := '';
  sProEmbSs := '';
  sProEmbPo := '';
  sProEmbSd := '';

  stlDesEmb.Clear;
  stlDesEmb.Add('KILLING');

  stlProEmbLt.Add(conf.fGet('KINLIT'));
  stlProEmbGl.Add(conf.fGet('KINGAL'));
  stlProEmbLa.Add(conf.fGet('KINLAT'));
  sProEmbSp := Conf.fGet('KINSPR');
  sProEmbCo := Conf.fGet('KINCOP');
end;

procedure TFormulaIndustrialKillingIndustrial.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('KIN_ACRMOB').AsFloat;
end;

procedure TFormulaIndustrialKillingIndustrial.PreencheQuantidadeFormulacaoVenda(
  const dtsCadTin: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
begin
  For intContador := 1 To Self.GetQuantidadeFormulacao Do
  Begin

    If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('KIN_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
      Break;

    Base := TBaseAutomotiva(Self.Add);
    Base.CodigoBase            := dtsCadTin.FieldByName('KIN_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString;
    Base.QuantidadeConcentrado := dtsCadTin.FieldByName('KIN_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

    Base.TipoBase   := 'B';
  End;
end;

procedure TFormulaIndustrialKillingIndustrial.PreencheVolumeVenda(const dtsCadTin: IDataSet);
begin
  Self.VolumeOri         := 0.9;
  Self.VolumeConcentrado := 0.9;
end;

end.
