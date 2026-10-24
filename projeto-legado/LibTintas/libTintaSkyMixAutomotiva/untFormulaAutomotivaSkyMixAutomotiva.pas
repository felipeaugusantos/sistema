{************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula SkyMixAutomotiva *}
{*********************************************************************AC*}
unit untFormulaAutomotivaSkyMixAutomotiva;

interface

uses
{$IFNDEF LINUX}
  Controls,
  ComCtrls,
{$ENDIF}
  untAbstractFormulaAutomotiva, untICalculadorFormulaAutomotiva, untIDataSet, untBaseAutomotiva,
  SysUtils, untStrUtils, Classes, untIConfTinta, untFloatUtils, untModoVenda, untCalculadorFormulaAutomotivaSkyMixAutomotiva,
  untVariantUtils, untIDicionario;

type
  TFormulaAutomotivaSkyMixAutomotiva = class(TAbstractFormulaAutomotiva)
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
    procedure RecalcularTabelasGeneric(dicRetorno: IDicionario); Override;
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
    function GetVolumePadraoBalde(dtsCadTin: IDataSet): Double; Override;

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
    function GetLinha(const dtsCadTin: IDataSet): string; override;

    procedure pPreencherPesCorFor(const dtsCadTin: IDataSet); override;
    function GetUniversal(const dtsCadTin: IDataSet): string; override;


//    function fPermiteMostrarComboDeEmbalagem: Boolean; override;

  {$IFNDEF LINUX}
    procedure pRecalculaFormulaMostrarPadrao(var lsvFormulacao: TListView;
      Base: TBaseAutomotiva; intDecimaisPrecoVenda, intDecimaisPesoEspecifico: Integer;
      blnConsLinhaDesBas: Boolean; strTipBas: String; intCont: Integer); override;

    procedure pRecalculaFormulaMostrarDigitado(var lsvFormulacao: TListView;
      Base: TBaseAutomotiva; intDecimaisPrecoVenda, intDecimaisPesoEspecifico: Integer;
      fltFator: Double; blnConsLinhaDesBas: Boolean; intCont: Integer;
      strLinha: String; strTipBas: String); override;
  {$ENDIF}

    function GetVolumeMaximoLitro(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoGalao(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoCopo(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoBalde(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoSpray(dtsCadTin: IDataSet): Double; Override;
    function fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer; dtsCadTin: IDataSet): Double; override;
    function fExisteConfiguracao(dtsCadTin: IDataSet; strEmbalagem: String): Boolean; Override;
    function fRetEmbLitro(dtsCadTin: IDataSet): String;
    function fRetEmbGalao(dtsCadTin: IDataSet): String;
  end;

implementation

uses
  untAbstractCalculadorFormulaAutomotiva, untAutcomTintaFactory;

{ TFormulaAutomotivaSkyMixAutomotiva }

procedure TFormulaAutomotivaSkyMixAutomotiva.CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva);
begin
end;

function TFormulaAutomotivaSkyMixAutomotiva.fCalculaQuantidadeParaBaixaEstoque(Base: TBaseAutomotiva): Double;
begin
  Result := TAutcomTintaFactory.Get.IIF(Self.mveModoVenda = mvConcentrado, base.QuantidadeConcentrado, base.QuantidadeDiluido) * (Self.fltVolumePro / Self.fltVolumeOri);
end;

function TFormulaAutomotivaSkyMixAutomotiva.fExisteConfiguracao(
  dtsCadTin: IDataSet; strEmbalagem: String): Boolean;
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
    qryConf.SQL := qryConf.SQL + '    CFG_IDEPRO = "SKY" AND          ';
    qryConf.SQL := qryConf.SQL + '    CFG_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" AND          ';

    If strEmbalagem = 'Litro' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "' + fRetEmbLitro(dtsCadTin) + '"      '
    Else If strEmbalagem = 'Galão' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "' + fRetEmbGalao(dtsCadTin) + '"      '
    Else If strEmbalagem = 'Balde' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLPBD"       '
    Else If strEmbalagem = 'Spray' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLPSP"       '
    Else If strEmbalagem = 'Copo' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLPCP"       ';

    qryConf.Open;

    Result := (Not qryConf.IsEmpty);
  Except
    Raise;
  End;
end;

function TFormulaAutomotivaSkyMixAutomotiva.fMostrarComCatalisador: Boolean;
begin
  Result := False;
end;


function TFormulaAutomotivaSkyMixAutomotiva.fRetEmbGalao(
  dtsCadTin: IDataSet): String;
begin
  Result := '';

  If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '5' Then
    Result := 'VOLPGA'
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '2' Then
    Result := 'VOLPGA_POLIESTER'
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '3' Then
    Result := 'VOLPGA_POLIESTER'
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '6' Then
    Result := 'VOLPGA_PU'
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '4' Then
    Result := 'VOLPGA_SINTETICO'
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'L' Then
    Result := 'VOLPGA_FROSFL'
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'S' Then
    Result := 'VOLPGA_FROSFS'
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'P' Then
    Result := 'VOLPGA_FROSFP'
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'E' Then
    Result := 'VOLPGA_FROSFE';
end;

function TFormulaAutomotivaSkyMixAutomotiva.fRetEmbLitro(
  dtsCadTin: IDataSet): String;
begin
  Result := '';

  If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '5' Then
    Result := 'VOLPQU'
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '2' Then
    Result := 'VOLPQU_POLIESTER'
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '3' Then
    Result := 'VOLPQU_POLIESTER'
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '6' Then
    Result := 'VOLPQU_PU'
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '4' Then
    Result := 'VOLPQU_SINTETICO'
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'L' Then
    Result := 'VOLPQU_FROSFL'
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'S' Then
    Result := 'VOLPQU_FROSFS'
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'P' Then
    Result := 'VOLPQU_FROSFP'
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'E' Then
    Result := 'VOLPQU_FROSFE';
end;

function TFormulaAutomotivaSkyMixAutomotiva.fValidaVolumeFormulucao(strTipoPre: String;
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaSkyMixAutomotiva.fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer;
  dtsCadTin: IDataSet): Double;
begin
  Result := 0.900;

  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 0.900;
    Exit;
  End;

  If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '5' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPQU'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '2' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPQU_POLIESTER'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '3' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPQU_POLIESTER'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '6' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPQU_PU'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '4' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPQU_SINTETICO'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'L' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPQU_FROSFL'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'S' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPQU_FROSFS'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'P' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPQU_FROSFP'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'E' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPQU_FROSFE'), 3);
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetAcrescimoDespesaOperacionalTinta: Double;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('DESOPE');
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetAno(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('SKY_ANOFAB').AsString;
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetCalcDespesasOperacionais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := 0;
  //SkyMix Automotiva tem uma unt especifica para realizar os calculos
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetCalcIcmsSaida(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := 0;
  //SkyMix Automotiva tem uma unt especifica para realizar os calculos
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetCalcImpostosFederais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;

begin
  Result := 0;
  //SkyMix Automotiva tem uma unt especifica para realizar os calculos
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetCalcOutrosValores(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := 0;
  //SkyMix Automotiva tem uma unt especifica para realizar os calculos
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := 0;
  //SkyMix Automotiva tem uma unt especifica para realizar os calculos
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetCalcPrecoCusto(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := 0;
  //SkyMix Automotiva tem uma unt especifica para realizar os calculos
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetCalcPrecoCustoReal(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := 0;
  //SkyMix Automotiva tem uma unt especifica para realizar os calculos
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetCalcPrecoMedio(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := 0;
  //SkyMix Automotiva tem uma unt especifica para realizar os calculos
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetCalcPrecoVenda(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
Begin
  Result := 0;
  //SkyMix Automotiva tem uma unt especifica para realizar os calculos
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetCalcQuantidade(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := 0;
  //SkyMix Automotiva tem uma unt especifica para realizar os calculos
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetCalculadorInterno: ICalculadorFormulaAutomotiva;
begin
  Result := TCalculadorFormulaAutomotivaSkyMixAutomotiva.Create(Self);
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := 0;
  //SkyMix Automotiva tem uma unt especifica para realizar os calculos
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := 0;
  //SkyMix Automotiva tem uma unt especifica para realizar os calculos
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('SKY_MD5KEY').AsString;
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetCodFormul(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('SKY_DESCRI').AsString;
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetDescricaoBase(strCodBas: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DESCRI '+
                    '  FROM SKY_CADBAS '+
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

function TFormulaAutomotivaSkyMixAutomotiva.GetFatorEstoque: Double;
begin
  Result := 0.9;
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetIdePro: String;
begin
  Result := 'SKY';
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetIndEmb(
  const dtsCadTin: IDataSet): integer;
begin
  Result := -1;

  If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '5' Then // LACA
    Result := 0
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '2' Then   // POLIESTER
    Result := 1
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '3' Then   // POLIESTER
    Result := 1
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '6' Then   // PU
    Result := 2
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '4' Then   // SINTETICO
    Result := 3
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'L' Then   // FROTA SFL
    Result := 4
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'S' Then   // FROTA SFS
    Result := 5
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'P' Then   // FROTA SFP
    Result := 6
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'E' Then   // FROTA SFE
    Result := 7;
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetLinha(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('GRU_LINHA_').AsString;
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetMontadora(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('SKY_CODMON').AsString;
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetNomeTabelaBases: String;
begin
  Result := 'SKY_CADBAS';
end;

Procedure TFormulaAutomotivaSkyMixAutomotiva.pPreencherPesCorFor(const dtsCadTin: IDataSet);
begin
  Self.PesoCor := 0; //dtsCadTin.FieldByName('GEN_PESCOR').AsFloat;
  Self.PesoFor := 0; //dtsCadTin.FieldByName('GEN_PESFOR').AsFloat;
end;

{$IFNDEF LINUX}
procedure TFormulaAutomotivaSkyMixAutomotiva.pRecalculaFormulaMostrarDigitado(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; fltFator: Double;
  blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha, strTipBas: String);
begin
  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado * fltFator, ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(TAutcomTintaFactory.Get.fFormataFloatSky(Base.QuantidadeDiluido * fltFator), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(TAutcomTintaFactory.Get.fFormataFloatSky(Base.QuantidadeDiluido2 * fltFator), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;

procedure TFormulaAutomotivaSkyMixAutomotiva.pRecalculaFormulaMostrarPadrao(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; blnConsLinhaDesBas: Boolean;
  strTipBas: String; intCont: Integer);
begin
  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado, ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(TAutcomTintaFactory.Get.fFormataFloatSky(Base.QuantidadeDiluido), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(TAutcomTintaFactory.Get.fFormataFloatSky(Base.QuantidadeDiluido2), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

function TFormulaAutomotivaSkyMixAutomotiva.GetPrefixoFormulacao: String;
begin
  Result := 'SKY_FORM';
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetPrefixoLitragem(
  const strModo: String): String;
begin
  Result := '';
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetPrefixoQuantidade(const strModo: String): String;
begin
  If strModo = 'C' Then
    Result := 'SKY_QTDC'
  Else
    Result := 'SKY_QTDB';
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetProdutoVendaTinta(const dtsCadTin: IDataSet): string;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGet('SKYPRO');
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetQuantidadeFormulacao: Integer;

begin
  Result := 20;
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetSelectBases: String;
begin
  Result := ' SELECT         ' +
            '     BAS_CODBAS ' +
            '   , BAS_CODITE ' +
            '   , BAS_EMBALA ' +
            '   , BAS_PESESP ' +
            '   , IFNULL(ITE_ITEATI, "N") ITE_ITEATI ' +
            '   , ITE_CNV_ML ' +
            '   , ITE_IPISAI ' +
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

function TFormulaAutomotivaSkyMixAutomotiva.GetTextoInformativoCalculo: String;
begin
  Result :=
  'VolumeFormula  = ' + FloatToStrF(VolumePro, ffFixed, 12,3) + sLineBreak +
  'Fator = (Quantidade / Peso Específico / Embalagem)' + sLineBreak +
  'Valor da Base  = (Preço * Fator * Valor Produzido / 0.9'+ sLineBreak +
  'Preço da Tinta = (Soma do Valor da Base de todas as bases)';
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetUniversal(
  const dtsCadTin: IDataSet): string;
begin
  Result := 'SKY_CODUNI';
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetVolumeMaximoBalde(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Balde') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPBD'), 3);
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetVolumeMaximoCopo(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Copo') Then
  Begin
    Result := 0.500;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPCP'), 3);
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetVolumeMaximoGalao(
  dtsCadTin: IDataSet): Double;
begin
  Result := 3.600;

  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 4.000;
    Exit;
  End;

  If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '5' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPGA'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '2' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPGA_POLIESTER'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '3' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPGA_POLIESTER'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '6' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPGA_PU'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '4' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPGA_SINTETICO'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'L' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPGA_FROSFL'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'S' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPGA_FROSFS'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'P' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPGA_FROSFP'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'E' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPGA_FROSFE'), 3);
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetVolumeMaximoLitro(
  dtsCadTin: IDataSet): Double;
begin
  Result := 0.900;

  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 1.000;
    Exit;
  End;

  If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '5' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPQU'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '2' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPQU_POLIESTER'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '3' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPQU_POLIESTER'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '6' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPQU_PU'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '4' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPQU_SINTETICO'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'L' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPQU_FROSFL'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'S' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPQU_FROSFS'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'P' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPQU_FROSFP'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'E' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPQU_FROSFE'), 3);
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetVolumeMaximoSpray(
  dtsCadTin: IDataSet): Double;
begin
   If Not fExisteConfiguracao(dtsCadTin, 'Balde') Then
  Begin
    Result := 0.100;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPSP'), 3);
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetVolumePadraCopo: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Copo') Then
  Begin
    Result := 0.450;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPCP'), 3);
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetVolumePadraGalao(dtsCadTin: IDataSet): Double;
begin
  Result := 3.600;

  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 3.600;
    Exit;
  End;

  If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '5' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPGA'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '2' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPGA_POLIESTER'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '3' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPGA_POLIESTER'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '6' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPGA_PU'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = '4' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPGA_SINTETICO'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'L' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPGA_FROSFL'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'S' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPGA_FROSFS'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'P' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPGA_FROSFP'), 3)
  Else If dtsCadTin.FieldByName('SKY_CODGRU').AsString = 'E' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPGA_FROSFE'), 3);
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetVolumePadraLitro: Double;
begin
  Result := 0.900;
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetVolumePadraoBalde(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(Nil, 'Balde') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPBD'), 3);
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetVolumePadraSpray: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Spray') Then
  Begin
    Result := 0.100;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SKY').fGetDouble('VOLPSP'), 3);
end;


function TFormulaAutomotivaSkyMixAutomotiva.GetVolumePadraTambor(dtsCadTin: IDataSet): Double;
begin
  Result := 0;
end;

function TFormulaAutomotivaSkyMixAutomotiva.GetVolumePermitido(
  const dtsCadTin: IDataSet; strTipoPre: String): Double;
begin
  Result := 0;
end;

procedure TFormulaAutomotivaSkyMixAutomotiva.pDefineVolumeOriginal;
begin
  If Self.mveModoVenda = mvConcentrado then
    Self.VolumeOri := Self.VolumeConcentrado
  Else
    Self.VolumeOri := Self.VolumeDiluido;
end;

procedure TFormulaAutomotivaSkyMixAutomotiva.pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet);
var
  conf: IConfTinta;
  stlGruEmbLt,
  stlGruEmbGl:TStringList;
  strGruEmbCo:String;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('SKY');

  stlGruEmbLt := TStringList.Create;
  stlGruEmbGl := TStringList.Create;



  sProEmbTb := '';
  sProEmbBa := '';
  sProEmbSs := '';
  sProEmbPo := '';
  sProEmbSd := '';

  stlDesEmb.Clear;
  stlDesEmb.Add('LACA');
  stlDesEmb.Add('POLIESTER');
  stlDesEmb.Add('PU');
  stlDesEmb.Add('SINTÉTICO');
  stlDesEmb.Add('SKYFROTA(SFL)');
  stlDesEmb.Add('SKYFROTA(SFS)');
  stlDesEmb.Add('SKYFROTA(SFP)');
  stlDesEmb.Add('SKYFROTA(SFE)');

  stlProEmbGl.Add(Conf.fGet('SKYPGA'));
  stlProEmbGl.Add(Conf.fGet('SKYPGA_POLIESTER'));
  stlProEmbGl.Add(Conf.fGet('SKYPGA_PU'));
  stlProEmbGl.Add(Conf.fGet('SKYPGA_SINTETICO'));
  stlProEmbGl.Add(Conf.fGet('SKYPGA_FROSFL'));
  stlProEmbGl.Add(Conf.fGet('SKYPGA_FROSFS'));
  stlProEmbGl.Add(Conf.fGet('SKYPGA_FROSFP'));
  stlProEmbGl.Add(Conf.fGet('SKYPGA_FROSFE'));

  stlGruEmbGl.Add(TAutcomTintaFactory.Get.fRetGrupoItem(Conf.fGet('SKYPGA')));
  stlGruEmbGl.Add(TAutcomTintaFactory.Get.fRetGrupoItem(Conf.fGet('SKYPGA_POLIESTER')));
  stlGruEmbGl.Add(TAutcomTintaFactory.Get.fRetGrupoItem(Conf.fGet('SKYPGA_PU')));
  stlGruEmbGl.Add(TAutcomTintaFactory.Get.fRetGrupoItem(Conf.fGet('SKYPGA_SINTETICO')));
  stlGruEmbGl.Add(TAutcomTintaFactory.Get.fRetGrupoItem(Conf.fGet('SKYPGA_FROSFL')));
  stlGruEmbGl.Add(TAutcomTintaFactory.Get.fRetGrupoItem(Conf.fGet('SKYPGA_FROSFS')));
  stlGruEmbGl.Add(TAutcomTintaFactory.Get.fRetGrupoItem(Conf.fGet('SKYPGA_FROSFP')));
  stlGruEmbGl.Add(TAutcomTintaFactory.Get.fRetGrupoItem(Conf.fGet('SKYPGA_FROSFE')));

  stlProEmbLt.Add(Conf.fGet('SKYPQU'));
  stlProEmbLt.Add(Conf.fGet('SKYPQU_POLIESTER'));
  stlProEmbLt.Add(Conf.fGet('SKYPQU_PU'));
  stlProEmbLt.Add(Conf.fGet('SKYPQU_SINTETICO'));
  stlProEmbLt.Add(Conf.fGet('SKYPQU_FROSFL'));
  stlProEmbLt.Add(Conf.fGet('SKYPQU_FROSFS'));
  stlProEmbLt.Add(Conf.fGet('SKYPQU_FROSFP'));
  stlProEmbLt.Add(Conf.fGet('SKYPQU_FROSFE'));

  stlGruEmbLt.Add(TAutcomTintaFactory.Get.fRetGrupoItem(Conf.fGet('SKYPQU')));
  stlGruEmbLt.Add(TAutcomTintaFactory.Get.fRetGrupoItem(Conf.fGet('SKYPQU_POLIESTER')));
  stlGruEmbLt.Add(TAutcomTintaFactory.Get.fRetGrupoItem(Conf.fGet('SKYPQU_PU')));
  stlGruEmbLt.Add(TAutcomTintaFactory.Get.fRetGrupoItem(Conf.fGet('SKYPQU_SINTETICO')));
  stlGruEmbLt.Add(TAutcomTintaFactory.Get.fRetGrupoItem(Conf.fGet('SKYPQU_FROSFL')));
  stlGruEmbLt.Add(TAutcomTintaFactory.Get.fRetGrupoItem(Conf.fGet('SKYPQU_FROSFS')));
  stlGruEmbLt.Add(TAutcomTintaFactory.Get.fRetGrupoItem(Conf.fGet('SKYPQU_FROSFP')));
  stlGruEmbLt.Add(TAutcomTintaFactory.Get.fRetGrupoItem(Conf.fGet('SKYPQU_FROSFE')));


  strProEmbCo := conf.fGet('SKYPCP');
  strGruEmbCo := TAutcomTintaFactory.Get.fRetGrupoItem(Conf.fGet('SKYPCP'));

  strProEmbBa := Conf.fGet('SKYPBD');
  strProEmbSp := Conf.fGet('SKYPSP');

  If Assigned(stlGruEmbLt) Then
    FreeAndNil(stlGruEmbLt);

  If Assigned(stlGruEmbGl) Then
    FreeAndNil(stlGruEmbGl);
end;

procedure TFormulaAutomotivaSkyMixAutomotiva.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('SKY_ACRMOB').AsFloat;
end;

procedure TFormulaAutomotivaSkyMixAutomotiva.PreencheQuantidadeFormulacaoVenda(
  const dtsCadTin: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
begin
  For intContador := 1 To Self.GetQuantidadeFormulacao Do
  Begin

    If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
      Break;

    Base := TBaseAutomotiva(Self.Add);
    Base.CodigoBase            := dtsCadTin.FieldByName('SKY_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString;
    Base.QuantidadeDiluido  := dtsCadTin.FieldByName('SKY_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
    Base.QuantidadeConcentrado := dtsCadTin.FieldByName('SKY_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

    If Base.CodigoBase = 'TH700' Then
      Base.TipoBase := 'D'
    Else
      Base.TipoBase := 'B';



  End;

end;

procedure TFormulaAutomotivaSkyMixAutomotiva.PreencheVolumeVenda(const dtsCadTin: IDataSet);
begin
  Self.VolumeOri         := 0.9;

  Self.VolumeConcentrado := 0.9;
  Self.VolumeDiluido     := 0.9;
end;

procedure TFormulaAutomotivaSkyMixAutomotiva.RecalcularTabelasGeneric(
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
