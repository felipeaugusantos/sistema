
{**************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula StarmixWeb *}
{***********************************************************************AC*}
unit untFormulaAutomotivaStarmixWeb;

interface

uses
{$IFNDEF LINUX}
  Controls,
  ComCtrls,
{$ENDIF}
  untAbstractFormulaAutomotiva, untICalculadorFormulaAutomotiva, untIDataSet, untBaseAutomotiva,
  SysUtils, untStrUtils, Classes, untIConfTinta, untFloatUtils, untModoVenda;

type
  TFormulaAutomotivaStarmixWeb = class(TAbstractFormulaAutomotiva)
  private

  protected
    function GetCalculadorInterno(): ICalculadorFormulaAutomotiva; override;
    function GetTextoInformativoCalculo(): String; override;
    procedure CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet;
      const Base: TBaseAutomotiva); override;
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
    function GetDescricao(const dtsCadTin: IDataSet): String; override;
    function GetIdePro: String; override;
    function GetChaveIteTin(const dtsCadTin: IDataSet): string; override;
    procedure PreencheVolumeVenda(const dtsCadTin: IDataSet); override;
    procedure PreencheAcrescimoMaoObra(const dtsCadTin: IDataSet); override;
    function GetCodFormul(const dtsCadTin: IDataSet): string; override;
    function GetIndEmb(const dtsCadTin: IDataSet): integer; override;
    procedure PreencheQuantidadeFormulacaoVenda(const dtsCadTin: IDataSet); override;

    procedure PreencheQuantidadeFormulacaoVendaEsp(const dtsCadTin: IDataSet); override;

    procedure pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet); override;
    function GetVolumePermitido(const dtsCadTin: IDataSet; strTipoPre: String):Double; override;
    function GetVolumePadraSpray: Double; override;
    function GetVolumePadraTambor(dtsCadTin: IDataSet): Double; override;
    function GetVolumePadraCopo : Double; override;

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
    function GetDescricaoBase(strCodBas: String): String; override;
    function GetFatorEstoque: Double; override;
    procedure pDefineVolumeOriginal; override;
    function fMostrarComCatalisador: Boolean; override;

    procedure pPreencherPesCorFor(const dtsCadTin: IDataSet); override;

    function GetUniversal(const dtsCadTin: IDataSet): string; override;
    function fCalculaQuantidadeParaBaixaEstoque(Base: TBaseAutomotiva): Double; override;
    function GetLinha(const dtsCadTin: IDataSet): string; override;

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

    function GetVolumePadraGalao(dtsCadTin: IDataSet): Double; override;
    function GetVolumePadraoLata(dtsCadTin: IDataSet): Double; override;
    function fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer; dtsCadTin: IDataSet): Double; override;

    function fExisteConfiguracao(dtsCadTin: IDataSet; strEmbalagem: String): Boolean; Override;

  end;

implementation

uses
  untAbstractCalculadorFormulaAutomotiva, untAutcomTintaFactory;

{ TFormulaAutomotivaStarmixWeb }

procedure TFormulaAutomotivaStarmixWeb.CarregaPrecosColorantesAdicional(
  const dataSetBases: IDataSet; const Base: TBaseAutomotiva);
begin
  Base.Cnv_Ml := Base.Embalagem * Base.PesoEspecifico;
end;

function TFormulaAutomotivaStarmixWeb.fCalculaQuantidadeParaBaixaEstoque(
  Base: TBaseAutomotiva): Double;
begin
  Result := TAutcomTintaFactory.Get.IIF(Self.mveModoVenda = mvConcentrado,
              Base.QuantidadeConcentrado, Base.QuantidadeDiluido) *
            (Self.fltPesCor / Self.fltPesFor) * Self.fltVolumePro;
end;

function TFormulaAutomotivaStarmixWeb.fExisteConfiguracao(dtsCadTin: IDataSet;
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
    qryConf.SQL := qryConf.SQL + '    CFG_IDEPRO = "STW" AND          ';
    qryConf.SQL := qryConf.SQL + '    CFG_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" AND          ';

    If strEmbalagem = 'Litro' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLIEM"         '
    Else If strEmbalagem = 'Galão' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLIGL"         '
    Else If strEmbalagem = 'Lata' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLILA"         '
    Else If strEmbalagem = 'Copo' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLICO"         '
    Else If strEmbalagem = 'Spray' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLISP"         ';

    qryConf.Open;

    Result := (Not qryConf.IsEmpty);
  Except
    Raise;
  End;
end;

function TFormulaAutomotivaStarmixWeb.fMostrarComCatalisador: Boolean;
begin
  Result := False;
end;

function TFormulaAutomotivaStarmixWeb.fValidaVolumeFormulucao(strTipoPre: String;
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaStarmixWeb.fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer;
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 0.900;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('STW').fGetDouble('VOLIEM'),  3);
end;

function TFormulaAutomotivaStarmixWeb.GetAcrescimoDespesaOperacionalTinta: Double;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('STW').fGetDouble('DESOPE');
end;

function TFormulaAutomotivaStarmixWeb.GetAno(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('STW_ANOCOR').AsString;
end;

function TFormulaAutomotivaStarmixWeb.GetCalcDespesasOperacionais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := GetCalcQuantidade(base, formula, strTipo);

  fltVenBas := (base.PrecoVenda / base.Embalagem) * (fltQtdFor / base.PesoEspecifico);

  Result := (fltVenBas * base.DespesasOperacionais / 100);
end;

function TFormulaAutomotivaStarmixWeb.GetCalcIcmsSaida(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := GetCalcQuantidade(base, formula, strTipo);

  fltVenBas := (base.PrecoVenda / base.Embalagem) * (fltQtdFor / base.PesoEspecifico);

  Result := (fltVenBas * base.IcmsSaida / 100);
end;

function TFormulaAutomotivaStarmixWeb.GetCalcImpostosFederais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := GetCalcQuantidade(base, formula, strTipo);

  fltVenBas := (base.PrecoVenda / base.Embalagem) * (fltQtdFor / base.PesoEspecifico);

  Result := (fltVenBas * base.ImpostosFederais / 100);
end;

function TFormulaAutomotivaStarmixWeb.GetCalcOutrosValores(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := GetCalcQuantidade(base, formula, strTipo);

  Result := ((base.OutrosValores / base.Embalagem) * (fltQtdFor / base.PesoEspecifico));
end;

function TFormulaAutomotivaStarmixWeb.GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := GetCalcQuantidade(base, formula, strTipo);

  Result := ((base.PrecoCompraLiquido / base.Embalagem) * (fltQtdFor / base.PesoEspecifico));
end;

function TFormulaAutomotivaStarmixWeb.GetCalcPrecoCusto(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := GetCalcQuantidade(base, formula, strTipo);

  Result := ((base.PrecoCusto / base.Embalagem) * (fltQtdFor / base.PesoEspecifico));
end;

function TFormulaAutomotivaStarmixWeb.GetCalcPrecoCustoReal(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := GetCalcQuantidade(base, formula, strTipo);

  Result := ((base.PrecoCustoReal / base.Embalagem) * (fltQtdFor / base.PesoEspecifico));
end;

function TFormulaAutomotivaStarmixWeb.GetCalcPrecoMedio(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := GetCalcQuantidade(base, formula, strTipo);

  Result := ((base.PrecoMedio / base.Embalagem) * (fltQtdFor / base.PesoEspecifico));
end;

function TFormulaAutomotivaStarmixWeb.GetCalcPrecoVenda(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := GetCalcQuantidade(base, formula, strTipo);

  Result := ((base.PrecoVenda / base.Embalagem) * (fltQtdFor / base.PesoEspecifico));

  Result := Result + ((TAutcomTintaFactory.Get.fGetConfTinta('STW').fGetDouble('STWIMP') / 100.0) * Result);
  Result := Result + ((TAutcomTintaFactory.Get.fGetConfTinta('STW').fGetDouble('STWPER') / 100.0) * Result);
end;

function TFormulaAutomotivaStarmixWeb.GetCalcQuantidade(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := TFloatUtils.fFormataFloat(formula.VolumePro * ((formula.PesoCor / formula.PesoFor) *
    TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido)),1);
end;

function TFormulaAutomotivaStarmixWeb.GetCalculadorInterno: ICalculadorFormulaAutomotiva;
begin
  Result := TAbstractCalculadorFormulaAutomotiva.Create(Self);
end;

function TFormulaAutomotivaStarmixWeb.GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := GetCalcQuantidade(base, formula, strTipo);

  Result := ((base.UltimoPrecoCompra / base.Embalagem) * (fltQtdFor / base.PesoEspecifico));
end;

function TFormulaAutomotivaStarmixWeb.GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := GetCalcQuantidade(base, formula, strTipo);

  Result := ((base.UltimoPrecoCompraImpostos / base.Embalagem) * (fltQtdFor / base.PesoEspecifico));
end;

function TFormulaAutomotivaStarmixWeb.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('STW_MD5KEY').AsString;
end;

function TFormulaAutomotivaStarmixWeb.GetCodFormul(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaStarmixWeb.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('STW_NOMCOR').AsString + ' - ' +
            dtsCadTin.FieldByName('STW_MONTAD').AsString + ' - ' +
            dtsCadTin.FieldByName('STW_UNIVER').AsString;
end;

function TFormulaAutomotivaStarmixWeb.GetDescricaoBase(strCodBas: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DESBAS FROM STW_CADBAS WHERE BAS_CODBAS = :CODBAS';
      qryGen.ParamByName('CODBAS').AsString := strCodBas;
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

function TFormulaAutomotivaStarmixWeb.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaAutomotivaStarmixWeb.GetIdePro: String;
begin
  Result := 'STW';
end;

function TFormulaAutomotivaStarmixWeb.GetIndEmb(
  const dtsCadTin: IDataSet): integer;
begin
  Result := -1;
end;

function TFormulaAutomotivaStarmixWeb.GetLinha(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('STW_CODLIN').AsString;
end;

function TFormulaAutomotivaStarmixWeb.GetMontadora(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('STW_MONTAD').AsString;
end;

function TFormulaAutomotivaStarmixWeb.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaAutomotivaStarmixWeb.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaAutomotivaStarmixWeb.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaAutomotivaStarmixWeb.GetNomeTabelaBases: String;
begin
  Result := 'STW_CADBAS';
end;

function TFormulaAutomotivaStarmixWeb.GetPrefixoFormulacao: String;
begin
  Result := 'STW_CODB';
end;

function TFormulaAutomotivaStarmixWeb.GetPrefixoLitragem(
  const strModo: String): String;
begin
  Result := '';
end;

function TFormulaAutomotivaStarmixWeb.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'STW_QTDB';
end;

function TFormulaAutomotivaStarmixWeb.GetProdutoVendaTinta(const dtsCadTin: IDataSet): string;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('STW').fGet('PROSTW');
end;

function TFormulaAutomotivaStarmixWeb.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaAutomotivaStarmixWeb.GetSelectBases: String;
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

function TFormulaAutomotivaStarmixWeb.GetTextoInformativoCalculo: String;
begin
  Result :=
    'PesoEspecíficoFormula = ' + FloatToStrF(fltPesCor, ffFixed, 12, 3) + sLineBreak +
    'PesoTotalFormula(g) = ' + FloatToStrF(fltPesFor, ffFixed, 12, 3) + sLineBreak +
    'QtdAux = VolumeDigitado * ((PesoEspecíficoFormula / PesoTotalFórmula) * Quantidade)' + sLineBreak +
    'Valor da Base = (Preço / Embalagem) * (QtdAux / Peso Específico)' + sLineBreak +
    '' + sLineBreak +
    'Preço da Tinta = soma do Valor da Base de todas as bases' + sLineBreak +
    'Preço da Tinta = Preço da Tinta + Impostos' + sLineBreak +
    'Preço da Tinta = Preço da Tinta + %Perda';
end;

function TFormulaAutomotivaStarmixWeb.GetUniversal(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('STW_UNIVER').AsString;
end;

function TFormulaAutomotivaStarmixWeb.GetVolumeMaximoCopo(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Copo') Then
  Begin
    Result := 0.500;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('STW').fGetDouble('VOLICO'), 3);
end;

function TFormulaAutomotivaStarmixWeb.GetVolumeMaximoGalao(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 4.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('STW').fGetDouble('VOLIGL'), 3);
end;

function TFormulaAutomotivaStarmixWeb.GetVolumeMaximoLata(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('STW').fGetDouble('VOLILA'), 3);
end;

function TFormulaAutomotivaStarmixWeb.GetVolumeMaximoLitro(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 1.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('STW').fGetDouble('VOLIEM'), 3);
end;

function TFormulaAutomotivaStarmixWeb.GetVolumeMaximoSpray(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Spray') Then
  Begin
    Result := 0.400;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('STW').fGetDouble('VOLISP'), 3);
end;

function TFormulaAutomotivaStarmixWeb.GetVolumePadraCopo: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Copo') Then
  Begin
    Result := 0.500;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('STW').fGetDouble('VOLICO'), 3);
end;

function TFormulaAutomotivaStarmixWeb.GetVolumePadraGalao(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 3.600;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('STW').fGetDouble('VOLIGL'), 3);
end;

function TFormulaAutomotivaStarmixWeb.GetVolumePadraoLata(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('STW').fGetDouble('VOLILA'), 3);
end;

function TFormulaAutomotivaStarmixWeb.GetVolumePadraSpray: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Spray') Then
  Begin
    Result := 0.400;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('STW').fGetDouble('VOLISP'), 3);
end;

function TFormulaAutomotivaStarmixWeb.GetVolumePadraTambor(dtsCadTin: IDataSet): Double;
begin
  Result := 0;
end;

function TFormulaAutomotivaStarmixWeb.GetVolumePermitido(
  const dtsCadTin: IDataSet; strTipoPre: String): Double;
begin
  Result := 0;
end;

procedure TFormulaAutomotivaStarmixWeb.pDefineVolumeOriginal;
begin
//
end;

procedure TFormulaAutomotivaStarmixWeb.pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet);
var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('STW');

  DesEmb.Clear;
  ProEmbLt.Clear;
  ProEmbGl.Clear;
  ProEmbLa.Clear;

  DesEmb.Add('NORMAL');

  ProEmbLt.Add(conf.fGet('STWIEM'));
  ProEmbGl.Add(conf.fGet('STWIGL'));
  ProEmbLa.Add(conf.fGet('STWILA'));

  sProEmbCo := conf.fGet('STWICO');
  sProEmbSp := conf.fGet('STWISP');
  sProEmbTb := '';
  sProEmbLa := '';
  sProEmbBa := '';
  sProEmbSs := '';
  sProEmbPo := '';
  sProEmbSd := '';
end;

procedure TFormulaAutomotivaStarmixWeb.pPreencherPesCorFor(const dtsCadTin: IDataSet);
begin
  self.PesoCor := dtsCadTin.FieldByName('STW_PESCOR').AsFloat * 1000;
  self.PesoFor := dtsCadTin.FieldByName('STW_PESFOR').AsFloat;
end;

{$IFNDEF LINUX}
procedure TFormulaAutomotivaStarmixWeb.pRecalculaFormulaMostrarDigitado(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; fltFator: Double;
  blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha: String;
  strTipBas: String);
begin
  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado * fltFator, ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(Base.QuantidadeDiluido * fltFator, ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(Base.QuantidadeDiluido2 * fltFator, ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TFormulaAutomotivaStarmixWeb.pRecalculaFormulaMostrarPadrao(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; blnConsLinhaDesBas: Boolean;
  strTipBas: String; intCont: Integer);
begin
  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado, ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(Base.QuantidadeDiluido, ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(Base.QuantidadeDiluido2, ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

procedure TFormulaAutomotivaStarmixWeb.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('STW_ACRMOB').AsFloat;
end;

procedure TFormulaAutomotivaStarmixWeb.PreencheQuantidadeFormulacaoVenda(
  const dtsCadTin: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
  blnDiluente: Boolean;
  strDiluente: String;
  qryBasDil: IDataSet;
  strSQL: String;
begin
  blnDiluente := False;
  strDiluente := '';

  ListaDiluentes.Clear;

  strSQL := '';
  strSQL := strSQL + ' SELECT BAS_CODBAS  FROM STW_CADBAS WHERE BAS_DESBAS LIKE "%DILUENTE%"  ';
  strSQL := strSQL + ' UNION ALL  ';
  strSQL := strSQL + ' SELECT BAS_CODBAS FROM STW_CADBAS WHERE BAS_DESBAS LIKE "%REDUTOR%"    ';


  qryBasDil := TAutcomTintaFactory.Get.fGetDataSet;
  qryBasDil.Close;
  qryBasDil.SQL := strSQL;
  qryBasDil.Open;

  While Not qryBasDil.Eof Do
  Begin
    strDiluente := strDiluente + qryBasDil.FieldByName('BAS_CODBAS').AsString + '_';
    qryBasDil.Next;
  End;

  ListaDiluentes.Add(strDiluente);

  For intContador := 1 To Self.GetQuantidadeFormulacao Do
  Begin
    If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('STW_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
      Break;

    If Pos(dtsCadTin.FieldByName('STW_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString, ListaDiluentes.Text) > 0 Then
    Begin
      blnDiluente := True;
      strDiluente := dtsCadTin.FieldByName('STW_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString;
      Break;
    End;

    Base := TBaseAutomotiva(Self.Add);
    Base.CodigoBase            := dtsCadTin.FieldByName('STW_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString;
    Base.QuantidadeConcentrado := dtsCadTin.FieldByName('STW_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
    Base.QuantidadeDiluido     := 0.0;
    Base.TipoBase              := 'B';
  End;

  If blnDiluente Then
  Begin
    Self.Clear;
    For intContador := 1 To Self.GetQuantidadeFormulacao Do
    Begin

      If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('STW_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
        Break;

      Base := TBaseAutomotiva(Self.Add);
      Base.CodigoBase := dtsCadTin.FieldByName('STW_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString;
      Base.QuantidadeConcentrado := 0.0;
      Base.QuantidadeDiluido := dtsCadTin.FieldByName('STW_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

      If Base.CodigoBase = strDiluente Then
        Base.TipoBase := 'D'
      Else
        Base.TipoBase := 'B';
    End;
  End;
end;

procedure TFormulaAutomotivaStarmixWeb.PreencheQuantidadeFormulacaoVendaEsp(
  const dtsCadTin: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
  blnDiluente: Boolean;
  strDiluente: String;
  qryBasDil: IDataSet;
  strSQL: String;
begin
  blnDiluente := False;
  strDiluente := '';

  ListaDiluentes.Clear;

  strSQL := '';
  strSQL := strSQL + ' SELECT BAS_CODBAS  FROM STW_CADBAS WHERE BAS_DESBAS LIKE "%DILUENTE%"  ';
  strSQL := strSQL + ' UNION ALL  ';
  strSQL := strSQL + ' SELECT BAS_CODBAS FROM STW_CADBAS WHERE BAS_DESBAS LIKE "%REDUTOR%"    ';


  qryBasDil := TAutcomTintaFactory.Get.fGetDataSet;
  qryBasDil.Close;
  qryBasDil.SQL := strSQL;
  qryBasDil.Open;

  While Not qryBasDil.Eof Do
  Begin
    strDiluente := strDiluente + qryBasDil.FieldByName('BAS_CODBAS').AsString + '_';
    qryBasDil.Next;
  End;

  ListaDiluentes.Add(strDiluente);

  For intContador := 1 To Self.GetQuantidadeFormulacao Do
  Begin
    If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('STW_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
      Break;

    If Pos(dtsCadTin.FieldByName('STW_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString, ListaDiluentes.Text) > 0 Then
    Begin
      blnDiluente := True;
      strDiluente := dtsCadTin.FieldByName('STW_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString;
      Break;
    End;

    Base := TBaseAutomotiva(Self.Add);
    Base.CodigoBase            := dtsCadTin.FieldByName('STW_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString;
    Base.QuantidadeConcentrado := Self.VolumeOri * ((Self.PesoCor / Self.PesoFor) *
      dtsCadTin.FieldByName('STW_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat);

    Base.QuantidadeConcentrado := TFloatUtils.fFormataFloat(Base.QuantidadeConcentrado, 1);

    Base.QuantidadeDiluido     := 0.0;
    Base.TipoBase              := 'B';
  End;

  If blnDiluente Then
  Begin
    Self.Clear;
    For intContador := 1 To Self.GetQuantidadeFormulacao Do
    Begin

      If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('STW_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
        Break;

      Base := TBaseAutomotiva(Self.Add);
      Base.CodigoBase            := dtsCadTin.FieldByName('STW_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString;
      Base.QuantidadeDiluido := Self.VolumeOri * ((Self.PesoCor / Self.PesoFor) *
        dtsCadTin.FieldByName('STW_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat);

      Base.QuantidadeDiluido := TFloatUtils.fFormataFloat(Base.QuantidadeDiluido, 1);
      Base.QuantidadeConcentrado := 0.0;

      If Base.CodigoBase = strDiluente Then
        Base.TipoBase := 'D'
      Else
        Base.TipoBase := 'B';
    End;
  End;
end;

procedure TFormulaAutomotivaStarmixWeb.PreencheVolumeVenda(const dtsCadTin: IDataSet);
begin
  Self.VolumeOri := 0.9;
end;

end.
