{************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula BrasimixAutomotiva *}
{*********************************************************************AC*}
unit untFormulaAutomotivaBrasimixAutomotiva;

interface

uses
{$IFNDEF LINUX}
  Controls,
  ComCtrls,
{$ENDIF}
  untAbstractFormulaAutomotiva, untICalculadorFormulaAutomotiva, untIDataSet, untBaseAutomotiva,
  SysUtils, untStrUtils, Classes, untIConfTinta, untFloatUtils, untModoVenda,
  System.Variants, untIDicionario, untGenericSaldosColorantes, untISaldosColorantes, untVariantUtils,
  untCalculadorFormulaAutomotivaBrasimixAutomotiva;

type
  TFormulaAutomotivaBrasimixAutomotiva = class(TAbstractFormulaAutomotiva)
  private
    strCodEmp : String;

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
    procedure CarregarBasesPorEmpresa(const dicRetorno: IDicionario); override;
    procedure CarregaPrecosBasesPorEmpresa; override;
    function GetSelectBasesPorEmpresa: String;

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

    procedure pRecalculaFormulaMostrarPadrao(var lsvFormulacao: TListView;
      Base: TBaseAutomotiva; intDecimaisPrecoVenda, intDecimaisPesoEspecifico: Integer;
      blnConsLinhaDesBas: Boolean; strTipBas: String; intCont: Integer); override;

    procedure pRecalculaFormulaMostrarDigitado(var lsvFormulacao: TListView;
      Base: TBaseAutomotiva; intDecimaisPrecoVenda, intDecimaisPesoEspecifico: Integer;
      fltFator: Double; blnConsLinhaDesBas: Boolean; intCont: Integer;
      strLinha: String; strTipBas: String); override;

    function GetVolumeMaximoLitro(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoGalao(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoCopo(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoSpray(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoLata(dtsCadTin: IDataSet): Double; Override;

    function GetVolumePadraGalao(dtsCadTin: IDataSet): Double;  Override;
    function GetVolumePadraoLata(dtsCadTin: IDataSet): Double;  Override;
    function fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer; dtsCadTin: IDataSet): Double; Override;
    function fExisteConfiguracao(dtsCadTin: IDataSet; strEmbalagem: String): Boolean; Override;
    function fBloqueiaTipoEmbalagem(): Boolean; Override;
    function GetSaldos: ISaldosColorantes; Override;

  end;

implementation

uses
  untAbstractCalculadorFormulaAutomotiva, untAutcomTintaFactory;

{ TFormulaAutomotivaBrasimixAutomotiva }

procedure TFormulaAutomotivaBrasimixAutomotiva.CarregaPrecosBasesPorEmpresa;
var
  intContador: Integer;
  Base: TBaseAutomotiva;
  fltPreCus: Double;
  fltPreVen: Double;
  fltDesOpeTinta: Double;
  strCodEmpresa: String;
  blnEmPromo: Boolean;
  blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
begin
  fltDesOpeTinta := TAutcomTintaFactory.Get().fGetConfTinta(GetIdePro).fGetDouble('DESOPE');

  strCodEmpresa := fVerificaEmpresaSetada();

  Self.pPreencheListaAdicionalBases;

  For intContador := 0 To Self.Count-1 Do
  Begin
    Base := TBaseAutomotiva(Self.Items[intContador]);
    If GetDataSetBasesPorEmpresa.Locate('BAS_CODBAS;BAS_CODEMP', VarArrayOf([Base.CodigoBase, strCodEmp]), []) Then
    Begin
      Base.OutrosValores             := GetDataSetBasesPorEmpresa.FieldByName('ITE_OUTVAL').AsFloat;
      Base.CodIte                    := GetDataSetBasesPorEmpresa.FieldByName('BAS_CODITE').AsString;
      Base.ImpDir                    := GetDataSetBasesPorEmpresa.FieldByName('ITE_IMPDIR').AsString;

      If TAutcomTintaFactory.Get.fCfgSis('IMPCF4', varBoolean) And Assigned(calculadorFatVendas) Then
        Base.IcmsSaida               := calculadorFatVendas.fCalculaAliquota(Base.CodIte, Base.ImpDir)
      Else
        Base.IcmsSaida               := GetDataSetBasesPorEmpresa.FieldByName('ITE_ICMSAI').AsFloat;

      Base.ImpostosFederais          := GetDataSetBasesPorEmpresa.FieldByName('ITE_IMPFED').AsFloat;
      Base.DespesasOperacionais      := GetDataSetBasesPorEmpresa.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;
      Base.Embalagem                 := GetDataSetBasesPorEmpresa.FieldByName('BAS_EMBALA').AsFloat;
      Base.PesoEspecifico            := GetDataSetBasesPorEmpresa.FieldByName('BAS_PESESP').AsFloat;

      Base.PrecoMedio                := GetDataSetBasesPorEmpresa.FieldByName('ITE_PREMED').AsFloat;
      Base.UltimoPrecoCompra         := GetDataSetBasesPorEmpresa.FieldByName('ITE_PREULT').AsFloat;
      Base.UltimoPrecoCompraImpostos := GetDataSetBasesPorEmpresa.FieldByName('ITE_IMPULT').AsFloat;
      Base.PrecoCompraLiquido        := TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fCalculaPrecoCompraLiq(
                                                                                     GetDataSetBasesPorEmpresa.Fieldbyname('ITE_PRECOM').AsFloat, GetDataSetBasesPorEmpresa.Fieldbyname('ITE_DESF01').AsFloat,
                                                                                     GetDataSetBasesPorEmpresa.Fieldbyname('ITE_DESF02').AsFloat, GetDataSetBasesPorEmpresa.Fieldbyname('ITE_DESF03').AsFloat,
                                                                                     GetDataSetBasesPorEmpresa.Fieldbyname('ITE_DESF04').AsFloat, GetDataSetBasesPorEmpresa.Fieldbyname('ITE_DESF05').AsFloat,
                                                                                     GetDataSetBasesPorEmpresa.Fieldbyname('ITE_DESF06').AsFloat), TAutcomTintaFactory.Get.fCfgSis('DECUNI', VarInteger));

      Base.PesGra                    := GetBasPesGra(GetDataSetBases);

      blnEmPromo := TAutcomTintaFactory.Get.fCarregaPromocao(GetDataSetBasesPorEmpresa.FieldByName('BAS_CODITE').AsString,
                                                             strTabPre, Self.strCodCli, Self.strCodCnd, Self.intPrzMed,
                                                             fltPreCus, fltPreVen, blnPrecoFixoParaTintaDeMaquinaImobiliaria, strCodEmpresa);

      If (blnEmPromo) And (Not Self.blnProPre) Then
      Begin
        Base.PrecoCusto := fltPreCus;
        Base.PrecoVenda := fltPreVen;

        If strTabPre = strTabPreTin Then
          Self.Promoc := 'S';

        if Base.PrecoCusto = 0 then
          Base.PrecoCusto := GetDataSetBasesPorEmpresa.FieldByName('ITE_PRECUS').AsFloat;
      End
      Else
      Begin
        Base.PrecoCusto := GetDataSetBasesPorEmpresa.FieldByName('ITE_PRECUS').AsFloat;
        Base.PrecoVenda := GetDataSetBasesPorEmpresa.FieldByName('ITE_PREVEN').AsFloat;

        If (Self.blnProPre) And (blnEmPromo) And (strTabPre = strTabPreTin) Then
          Self.Promoc := 'S';
      End;
      CarregaPrecosColorantesAdicional(GetDataSetBasesPorEmpresa, Base);
    End;
  End;

  TextoInformativoCalculo.Text := GetTextoInformativoCalculo;
end;

procedure TFormulaAutomotivaBrasimixAutomotiva.CarregarBasesPorEmpresa(
  const dicRetorno: IDicionario);
var
  strSql    : String;
begin
  strSql := GetSelectBasesPorEmpresa;

  If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '0') Then
  begin
    strSql := strSql +
      '   , ' + GetNomeCampoCustoBase + ' AS ITE_PRECUS ' +
      '   , ' + GetNomeCampoVendaBase + ' AS ITE_PREVEN ';
  end

  Else If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') And (BlnCalculaUnitario) Then
  begin
    strSql := strSql +
      '   , ITE_PRECUS               ' +
      '   , ITE_PREVE' + TAutcomTintaFactory.Get.fCfgSis('TABPRE') + ' AS ITE_PREVEN ';
  end
  else
  begin
    strSql := strSql +
      '   , ITE_PRECUS               ' +
      '   , ITE_PREVE' + Self.strTabPre + ' AS ITE_PREVEN ';
  end;

  strSql := strSql +
    ' FROM                               ' +
    '    BZA_BASEMP B     ' +
    '   INNER JOIN ITEGER G              ' +
    '     ON B.BAS_CODITE = G.ITE_CODITE ' +
    '   INNER JOIN CADITE I              ' +
    '     ON G.ITE_CODITE = I.ITE_CODITE ' +
    ' WHERE G.ITE_CODEMP = :CODEMP       ';

  strSql := strSql + GetBasesPorEmpresa(dicRetorno);

  GetDataSetBasesPorEmpresa.SQL := strSql;

  If Not TStrUtils.fEmptyStr(Self.EmpresaProducao) And (Self.OprFlj = 'S') Then
    GetDataSetBasesPorEmpresa.ParamByName('CODEMP').AsString := Self.EmpresaProducao
  Else If Not TStrUtils.fEmptyStr(Self.EmpCd_) And (Self.CD_S_N = 'S') Then
    GetDataSetBasesPorEmpresa.ParamByName('CODEMP').AsString := Self.EmpCd_
  Else If Not TStrUtils.fEmptyStr(Self.EmpFat) And (Self.FatS_N = 'S') Then
    GetDataSetBasesPorEmpresa.ParamByName('CODEMP').AsString := Self.EmpFat
  Else
    GetDataSetBasesPorEmpresa.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;

  strCodEmp := GetDataSetBasesPorEmpresa.ParamByName('CODEMP').AsString;
  GetDataSetBasesPorEmpresa.Open;

end;

function TFormulaAutomotivaBrasimixAutomotiva.GetSelectBasesPorEmpresa: String;
begin
  Result := ' SELECT         ' +
            '     BAS_CODBAS ' +
            '   , BAS_CODEMP ' +
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

procedure TFormulaAutomotivaBrasimixAutomotiva.CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva);
begin
  Base.Cnv_Ml := Base.Embalagem * Base.PesoEspecifico;
end;

function TFormulaAutomotivaBrasimixAutomotiva.fBloqueiaTipoEmbalagem: Boolean;
begin
  Result := False;
end;

function TFormulaAutomotivaBrasimixAutomotiva.fCalculaQuantidadeParaBaixaEstoque(Base: TBaseAutomotiva): Double;
begin
  Result := TAutcomTintaFactory.Get.IIF(base.QuantidadeConcentrado > 0, base.QuantidadeConcentrado, base.QuantidadeDiluido) * (Self.fltVolumePro / Self.fltVolumeOri);
end;

function TFormulaAutomotivaBrasimixAutomotiva.fExisteConfiguracao(
  dtsCadTin: IDataSet; strEmbalagem: String): Boolean;
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
    qryConf.SQL := qryConf.SQL + '    CFG_IDEPRO = "BZA" AND          ';
    qryConf.SQL := qryConf.SQL + '    CFG_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" AND        ';

    If strEmbalagem = 'Litro' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLLTS"       '
    Else If strEmbalagem = 'Galão' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLGLS"       '
    Else If strEmbalagem = 'Lata' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLLAS"       '
    Else If strEmbalagem = 'Copo' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLCOP"       '
    Else If strEmbalagem = 'Spray' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLSPR"       ';

    qryConf.Open;

    Result := (Not qryConf.IsEmpty);
  Except
    Raise;
  End;
end;

function TFormulaAutomotivaBrasimixAutomotiva.fMostrarComCatalisador: Boolean;
begin
  Result := False;
end;


function TFormulaAutomotivaBrasimixAutomotiva.fValidaVolumeFormulucao(strTipoPre: String;
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaBrasimixAutomotiva.fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer;
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 0.900;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('BZA').fGetDouble('VOLLTS'), 3);
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetAcrescimoDespesaOperacionalTinta: Double;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('BZA').fGetDouble('DESOPE');
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetAno(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('BZA_A_N_O_').AsString;
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetCalcDespesasOperacionais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  fltVenBas := (fltQtdFor * base.PrecoVenda / base.Cnv_Ml);

  Result := (fltVenBas * base.DespesasOperacionais / 100);
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetCalcIcmsSaida(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  fltVenBas := (fltQtdFor * base.PrecoVenda / base.Cnv_Ml);

  Result := (fltVenBas * base.IcmsSaida / 100);
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetCalcImpostosFederais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
Var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  fltVenBas := (fltQtdFor * base.PrecoVenda / base.Cnv_Ml);

  Result := (fltVenBas * base.ImpostosFederais / 100);
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetCalcOutrosValores(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  Result := (fltQtdFor * base.OutrosValores / base.Cnv_Ml);
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  Result := (fltQtdFor * base.PrecoCompraLiquido / base.Cnv_Ml);
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetCalcPrecoCusto(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  Result := (fltQtdFor * base.PrecoCusto / base.Cnv_Ml);
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetCalcPrecoCustoReal(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  Result := (fltQtdFor * base.PrecoCustoReal / base.Cnv_Ml);
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetCalcPrecoMedio(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  Result := (fltQtdFor * base.PrecoMedio / base.Cnv_Ml);
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetCalcPrecoVenda(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
Begin
  Result := (((formula.VolumePro / formula.VolumeOri * TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido)) * base.PrecoVenda) / Base.Cnv_Ml);
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetCalcQuantidade(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := (TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido) * (formula.VolumePro / formula.VolumeOri));
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetCalculadorInterno: ICalculadorFormulaAutomotiva;
begin
  Result := TAbstractCalculadorFormulaAutomotivaBrasimixAutomotiva.Create(Self);
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloatLaz(fltQtdFor * formula.VolumePro / formula.VolumeOri);

  Result := (fltQtdFor * base.UltimoPrecoCompra / base.Cnv_Ml);
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  Result := (fltQtdFor * base.UltimoPrecoCompraImpostos / base.Cnv_Ml);
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('BZA_MD5KEY').AsString;
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetCodFormul(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('BZA_DESCRI').AsString;
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetDescricaoBase(strCodBas: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DESBAS '+
                    '  FROM BZA_CADBAS '+
                    ' WHERE BAS_CODBAS = :CODBAS';
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

function TFormulaAutomotivaBrasimixAutomotiva.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetIdePro: String;
begin
  Result := 'BZA';
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetIndEmb(
  const dtsCadTin: IDataSet): integer;
begin
  Result := -1;

  If Pos('SINT.', dtsCadTin.FieldByName('BZA_ARQTXT').AsString) > 0 Then
    Result := 0
  Else If Pos('SINTETICO', dtsCadTin.FieldByName('BZA_ARQTXT').AsString) > 0 Then
    Result := 0
  Else If Pos('LACA', dtsCadTin.FieldByName('BZA_ARQTXT').AsString) > 0 Then
    Result := 1
  Else If Pos('POLIESTER', dtsCadTin.FieldByName('BZA_ARQTXT').AsString) > 0 Then
    Result := 2
  Else If Pos('POLIURETANO', dtsCadTin.FieldByName('BZA_ARQTXT').AsString) > 0 Then
    Result := 3
  Else If Pos('PU', dtsCadTin.FieldByName('BZA_ARQTXT').AsString) > 0 Then
    Result := 3
  Else If Pos('EPOXI', dtsCadTin.FieldByName('BZA_ARQTXT').AsString) > 0 Then
    Result := 4
  Else If Pos('EPOX', dtsCadTin.FieldByName('BZA_ARQTXT').AsString) > 0 Then
    Result := 4;
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetMontadora(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('BZA_MONTAD').AsString;
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetNomeTabelaBases: String;
begin
  Result := 'BZA_CADBAS';
end;

Procedure TFormulaAutomotivaBrasimixAutomotiva.pPreencherPesCorFor(const dtsCadTin: IDataSet);
begin
  Self.PesoCor := 0; //dtsCadTin.FieldByName('GEN_PESCOR').AsFloat;
  Self.PesoFor := 0; //dtsCadTin.FieldByName('GEN_PESFOR').AsFloat;
end;

{$IFNDEF LINUX}
procedure TFormulaAutomotivaBrasimixAutomotiva.pRecalculaFormulaMostrarDigitado(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; fltFator: Double;
  blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha, strTipBas: String);
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
procedure TFormulaAutomotivaBrasimixAutomotiva.pRecalculaFormulaMostrarPadrao(
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

function TFormulaAutomotivaBrasimixAutomotiva.GetPrefixoFormulacao: String;
begin
  Result := 'BZA_CODB';
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetPrefixoLitragem(
  const strModo: String): String;
begin
  Result := '';
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'BZA_QTDB';
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetProdutoVendaTinta(const dtsCadTin: IDataSet): string;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('BZA').fGet('PROBZA');
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetQuantidadeFormulacao: Integer;

begin
  Result := 20;
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetSaldos: ISaldosColorantes;
var
  intCont: Integer;
  saldos: TGenericSaldosColorantes;
  base: TBaseAutomotiva;
  fltQtdFormul: Double;
  blnBaseEmpresa: Boolean;
begin
  saldos := TGenericSaldosColorantes.Create();

  for intCont := 0 to Self.Count - 1 do
  begin
    base := TBaseAutomotiva(Self.Items[intCont]);

    If GetDataSetBasesPorEmpresa.Locate('BAS_CODBAS;BAS_CODEMP', VarArrayOf([base.CodigoBase, strCodEmp]), []) Then
      blnBaseEmpresa := True
    Else If GetDataSetBases.Locate('BAS_CODBAS', base.CodigoBase, []) Then
      blnBaseEmpresa := False
    Else
      blnBaseEmpresa := False;


    If (Base.TipoBase = 'C') And Not (Self.ComCatalisador) Then
      Continue;

    fltQtdFormul := fCalculaQuantidadeParaBaixaEstoque(Base);

    If fltQtdFormul > 0 Then
    Begin
      saldos.Adicionar(TGenericSaldoColorante.Create(
        1,
        Descricao,
        TAutcomTintaFactory.Get.IIF(blnBaseEmpresa, GetDataSetBasesPorEmpresa.FieldByName('BAS_CODITE').AsString, GetDataSetBases.FieldByName('BAS_CODITE').AsString),
        VarToStrDef(TAutcomTintaFactory.Get.GetValorCampo('SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE', 'ITE_DESITE', [
        TAutcomTintaFactory.Get.IIF(blnBaseEmpresa, GetDataSetBasesPorEmpresa.FieldByName('BAS_CODITE').AsString, GetDataSetBases.FieldByName('BAS_CODITE').AsString)]), ''),
        Base.CodigoBase,
        fltQtdFormul,
        BASE_AUTOMOTIVA,
        'N',
        0.0));
    End;
  end;

  Result := saldos;
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetSelectBases: String;
begin
  Result := ' SELECT         ' +
            '     BAS_CODBAS ' +
            '   , BAS_CODITE ' +
            '   , BAS_EMBALA ' +
            '   , BAS_PESPEC AS BAS_PESESP' +
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

function TFormulaAutomotivaBrasimixAutomotiva.GetTextoInformativoCalculo: String;
begin
  Result :=
  'VolumeFormula  = ' + FloatToStrF(VolumePro, ffFixed, 12,3)+ sLineBreak +
  'Valor da Base  = (Qtde. Concentrado * Preço) / (Embalagem * Volume Produzido) /0.900'+ sLineBreak +
  'Preço da Tinta = (Soma do Valor da Base de todas as bases)';


end;

function TFormulaAutomotivaBrasimixAutomotiva.GetUniversal(
  const dtsCadTin: IDataSet): string;
begin
  Result := 'BZA_CODUNI';
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetVolumeMaximoCopo(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Copo') Then
  Begin
    Result := 0.500;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('BZA').fGetDouble('VOLCOP'), 3);
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetVolumeMaximoGalao(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 4.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('BZA').fGetDouble('VOLGLS'), 3);
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetVolumeMaximoLata(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('BZA').fGetDouble('VOLLAS'), 3);
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetVolumeMaximoLitro(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 1.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('BZA').fGetDouble('VOLLTS'), 3);
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetVolumeMaximoSpray(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Spray') Then
  Begin
    Result := 0.400;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('BZA').fGetDouble('VOLSPR'), 3);
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetVolumePadraCopo: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Copo') Then
  Begin
    Result := 0.500;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('BZA').fGetDouble('VOLCOP'), 3);
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetVolumePadraGalao(dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 3.600;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('BZA').fGetDouble('VOLGLS'), 3);
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetVolumePadraLitro: Double;
begin
  Result := 0.900;
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetVolumePadraoLata(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('BZA').fGetDouble('VOLLAS'), 3);
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetVolumePadraSpray: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Spray') Then
  Begin
    Result := 0.400;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('BZA').fGetDouble('VOLSPR'), 3);
end;


function TFormulaAutomotivaBrasimixAutomotiva.GetVolumePadraTambor(dtsCadTin: IDataSet): Double;
begin
  Result := 0;
end;

function TFormulaAutomotivaBrasimixAutomotiva.GetVolumePermitido(
  const dtsCadTin: IDataSet; strTipoPre: String): Double;
begin
  Result := 0;
end;

procedure TFormulaAutomotivaBrasimixAutomotiva.pDefineVolumeOriginal;
begin
  If Self.mveModoVenda = mvConcentrado then
    Self.VolumeOri := Self.VolumeConcentrado
  Else
    Self.VolumeOri := Self.VolumeDiluido;
end;

procedure TFormulaAutomotivaBrasimixAutomotiva.pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet);
var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('BZA');


  sProEmbTb := '';
  sProEmbBa := '';
  sProEmbSs := '';
  sProEmbPo := '';
  sProEmbSd := '';

  stlDesEmb.Clear;
  stlDesEmb.Add('SINTETICO');
  stlDesEmb.Add('LACA');
  stlDesEmb.Add('POLIESTER');
  stlDesEmb.Add('P. U.');
  stlDesEmb.Add('EPOXI');

  stlProEmbGl.Add(conf.fGet('BZAIGL'));
  stlProEmbGl.Add(conf.fGet('BZAGLA'));
  stlProEmbGl.Add(conf.fGet('BZAGPO'));
  stlProEmbGl.Add(conf.fGet('BZAGPU'));
  stlProEmbGl.Add(conf.fGet('BZAGPE'));

  stlProEmbLt.Add(conf.fGet('BZAIEM'));
  stlProEmbLt.Add(conf.fGet('BZALLA'));
  stlProEmbLt.Add(conf.fGet('BZALPO'));
  stlProEmbLt.Add(conf.fGet('BZALPU'));
  stlProEmbLt.Add(conf.fGet('BZALPE'));

  stlProEmbLa.Add(Conf.fGet('BZALAS'));
  stlProEmbLa.Add(Conf.fGet('BZALAL'));
  stlProEmbLa.Add(Conf.fGet('BZALAP'));
  stlProEmbLa.Add(Conf.fGet('BZALAU'));
  stlProEmbLa.Add(Conf.fGet('BZALAE'));

  strProEmbCo := conf.fGet('BZACOP');
  strProEmbSp := conf.fGet('BZASPR');

end;

procedure TFormulaAutomotivaBrasimixAutomotiva.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('BZA_ACRMOB').AsFloat;
end;

procedure TFormulaAutomotivaBrasimixAutomotiva.PreencheQuantidadeFormulacaoVenda(
  const dtsCadTin: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
begin
  For intContador := 1 To Self.GetQuantidadeFormulacao Do
  Begin

    If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('BZA_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
      Break;

    Base := TBaseAutomotiva(Self.Add);
    Base.CodigoBase            := dtsCadTin.FieldByName('BZA_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString;

    If ((dtsCadTin.FieldByName('BZA_ARQTXT').AsString = 'POLIESTER')
     Or (dtsCadTin.FieldByName('BZA_ARQTXT').AsString = 'POLIESTER PREMIUM')) Then
      Base.QuantidadeDiluido     := dtsCadTin.FieldByName('BZA_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat
    Else
      Base.QuantidadeConcentrado := dtsCadTin.FieldByName('BZA_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;


    If ((Base.CodigoBase = 'DILUEN') Or (Base.CodigoBase = 'TD00050')) Then
      Base.TipoBase := 'D'
    Else
      Base.TipoBase := 'B';

  End;

end;

procedure TFormulaAutomotivaBrasimixAutomotiva.PreencheVolumeVenda(const dtsCadTin: IDataSet);
begin
  Self.VolumeOri         := 0.9;

  Self.VolumeConcentrado := 0.9;
  Self.VolumeDiluido     := 0.9;
end;

end.

