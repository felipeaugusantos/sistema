{************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula RennerPerformance *}
{*********************************************************************AC*}
unit untFormulaAutomotivaRennerPerformance;

interface

uses
{$IFNDEF LINUX}
  Controls,
  ComCtrls,
{$ENDIF}
  untAbstractFormulaAutomotiva, untICalculadorFormulaAutomotiva, untIDataSet, untBaseAutomotiva,
  SysUtils, untStrUtils, Classes, untIConfTinta, untFloatUtils, untModoVenda, untIDicionario, untVariantUtils;

type
  TFormulaAutomotivaRennerPerformance = class(TAbstractFormulaAutomotiva)
  Private
    function GetSelectColorantes(): String;
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
    procedure CarregarBases(const dicRetorno: IDicionario); Override;
    procedure CarregaPrecosBases; Override;
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
    function fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer; dtsCadTin: IDataSet): Double; Override;
    function fExisteConfiguracao(dtsCadTin: IDataSet; strEmbalagem: String): Boolean; Override;
  end;

implementation

uses
  untAbstractCalculadorFormulaAutomotiva, untAutcomTintaFactory;

{ TFormulaAutomotivaRennerPerformance }

procedure TFormulaAutomotivaRennerPerformance.CarregaPrecosBases;
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

  Self.pPreencheListaAdicionalBases;

  strCodEmpresa := fVerificaEmpresaSetada();

  For intContador := 0 To Self.Count - 1 Do
  Begin
    Base := TBaseAutomotiva(Self.Items[intContador]);

    If GetDataSetBases.Locate('BAS_CODBAS', Base.CodigoBase, []) Then
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

        if Base.PrecoCusto = 0 then
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

procedure TFormulaAutomotivaRennerPerformance.CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva);
begin
  base.Cnv_Ml := Base.Embalagem * Base.PesoEspecifico;
end;

procedure TFormulaAutomotivaRennerPerformance.CarregarBases(const dicRetorno: IDicionario);
Var
  strSQL: String;
begin
  strSQL := GetSelectBases;

  If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '0') Then
  begin
    strSQL := strSQL +
      '   , ' + GetNomeCampoCustoBase + ' AS ITE_PRECUS ' +
      '   , ' + GetNomeCampoVendaBase + ' AS ITE_PREVEN ';
  end

  Else If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') And BlnCalculaUnitario Then
  begin
    strSQL := strSQL +
      '   , ITE_PRECUS               ' +
      '   , ITE_PREVE' + TAutcomTintaFactory.Get.fCfgSis('TABPRE') + ' AS ITE_PREVEN ';
  end
  else
  begin
    strSQL := strSQL +
      '   , ITE_PRECUS               ' +
      '   , ITE_PREVE' + Self.strTabPre + ' AS ITE_PREVEN ';
  end;

  strSQL := strSQL +
    ' FROM                               ' +
    '   ' + GetNomeTabelaBases + ' B     ' +
    '   INNER JOIN ITEGER G              ' +
    '     ON B.BAS_CODITE = G.ITE_CODITE ' +
    '   INNER JOIN CADITE I              ' +
    '     ON G.ITE_CODITE = I.ITE_CODITE ' +
    ' WHERE G.ITE_CODEMP = :CODEMP       ';

  strSql := strSql + GetBasesPorEmpresa(dicRetorno);

  strSQL := strSQL + GetSelectColorantes();

  GetDataSetBases.SQL := strSql;

  If (Not TStrUtils.fEmptyStr(Self.EmpresaProducao)) And (Self.OprFlj = 'S') Then
    GetDataSetBases.ParamByName('CODEMP').AsString := Self.EmpresaProducao
  Else If (Not TStrUtils.fEmptyStr(Self.EmpCd_)) And (Self.CD_S_N = 'S') Then
    GetDataSetBases.ParamByName('CODEMP').AsString := Self.EmpCd_
  Else If (Not TStrUtils.fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
    GetDataSetBases.ParamByName('CODEMP').AsString := Self.EmpFat
  Else
    GetDataSetBases.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;

  GetDataSetBases.Open;
end;

function TFormulaAutomotivaRennerPerformance.fCalculaQuantidadeParaBaixaEstoque(Base: TBaseAutomotiva): Double;
begin
  Result := TAutcomTintaFactory.Get.IIF(mveModoVenda = mvConcentrado, Base.QuantidadeConcentrado, Base.QuantidadeDiluido) * (Self.fltVolumePro / Self.fltVolumeOri);
end;

function TFormulaAutomotivaRennerPerformance.fExisteConfiguracao(dtsCadTin: IDataSet;
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
    qryConf.SQL := qryConf.SQL + '    CFG_IDEPRO = "REP" AND          ';
    qryConf.SQL := qryConf.SQL + '    CFG_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" AND        ';

    If strEmbalagem = 'Litro' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLLIT"         '
    Else If strEmbalagem = 'Galão' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLGAL"         ';

    qryConf.Open;

    Result := (Not qryConf.IsEmpty);
  Except
    Raise;
  End;
end;

function TFormulaAutomotivaRennerPerformance.fMostrarComCatalisador: Boolean;
begin
  Result := False;
end;

function TFormulaAutomotivaRennerPerformance.fValidaVolumeFormulucao(strTipoPre: String;
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaRennerPerformance.fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer;
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 0.900;
    Exit;
  End;

  If dtsCadTin.FieldByName('REP_CODBAS').AsString = 'RHB300' Then
    Result := 0.900
  Else If dtsCadTin.FieldByName('REP_CODBAS').AsString = 'RHB347' Then
    Result := 0.675
  Else
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('REP').fGetDouble('VOLLIT'), 3);
end;

function TFormulaAutomotivaRennerPerformance.GetAcrescimoDespesaOperacionalTinta: Double;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('REP').fGetDouble('DESOPE');
end;

function TFormulaAutomotivaRennerPerformance.GetAno(const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaRennerPerformance.GetCalcDespesasOperacionais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := Base.QuantidadeConcentrado;

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri, 2);

  fltVenBas := (fltQtdFor * base.PrecoVenda / base.Cnv_Ml);

   Result := (fltVenBas * base.DespesasOperacionais / 100);
end;

function TFormulaAutomotivaRennerPerformance.GetCalcIcmsSaida(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := Base.QuantidadeConcentrado;

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri, 2);

  fltVenBas := (fltQtdFor * base.PrecoVenda / base.Cnv_Ml);

  Result := (fltVenBas * base.IcmsSaida / 100);
end;

function TFormulaAutomotivaRennerPerformance.GetCalcImpostosFederais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
Var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := Base.QuantidadeConcentrado;

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri, 2);

  fltVenBas := (fltQtdFor * base.PrecoVenda / base.Cnv_Ml);

  Result := (fltVenBas * base.ImpostosFederais / 100);
end;

function TFormulaAutomotivaRennerPerformance.GetCalcOutrosValores(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
Var
  fltQtdFor:Double;
begin
  fltQtdFor := Base.QuantidadeConcentrado;

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri, 2);

  Result := (fltQtdFor * base.OutrosValores / base.Cnv_Ml);
end;

function TFormulaAutomotivaRennerPerformance.GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := Base.QuantidadeConcentrado;

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri, 2);

  Result := (fltQtdFor * base.PrecoCompraLiquido / base.Cnv_Ml);
end;

function TFormulaAutomotivaRennerPerformance.GetCalcPrecoCusto(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := Base.QuantidadeConcentrado;

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri, 2);

  Result := (fltQtdFor * base.PrecoCusto / base.Cnv_Ml);
end;

function TFormulaAutomotivaRennerPerformance.GetCalcPrecoCustoReal(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := Base.QuantidadeConcentrado;

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri, 2);

  Result := (fltQtdFor * base.PrecoCustoReal / base.Cnv_Ml);
end;

function TFormulaAutomotivaRennerPerformance.GetCalcPrecoMedio(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
Var
  fltQtdFor:Double;
begin
  fltQtdFor := Base.QuantidadeConcentrado;

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri, 2);

  Result := (fltQtdFor * base.PrecoMedio / base.Cnv_Ml);
end;

function TFormulaAutomotivaRennerPerformance.GetCalcPrecoVenda(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor:Double;
Begin
  fltQtdFor := Base.QuantidadeConcentrado;

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri, 2);

  Result := (fltQtdFor * base.PrecoVenda / base.Cnv_Ml);
end;

function TFormulaAutomotivaRennerPerformance.GetCalcQuantidade(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido)
             * formula.VolumePro / formula.VolumeOri, 2);
end;

function TFormulaAutomotivaRennerPerformance.GetCalculadorInterno: ICalculadorFormulaAutomotiva;
begin
  Result := TAbstractCalculadorFormulaAutomotiva.Create(Self);
end;

function TFormulaAutomotivaRennerPerformance.GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := Base.QuantidadeConcentrado;

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri, 2);

  Result := (fltQtdFor * base.UltimoPrecoCompra / base.Cnv_Ml);
end;

function TFormulaAutomotivaRennerPerformance.GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := Base.QuantidadeConcentrado;

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri, 2);

  Result := (fltQtdFor * base.UltimoPrecoCompraImpostos / base.Cnv_Ml);
end;

function TFormulaAutomotivaRennerPerformance.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('REP_MD5KEY').AsString;
end;

function TFormulaAutomotivaRennerPerformance.GetCodFormul(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaRennerPerformance.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('REP_NOMCOR').AsString;
end;

function TFormulaAutomotivaRennerPerformance.GetDescricaoBase(strCodBas: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DESCRI '+
                    '  FROM REP_CADBAS '+
                    ' WHERE BAS_CODBAS = :CODBAS  ';
      qryGen.SQL := qryGen.SQL + '  UNION ALL           ';
      qryGen.SQL := qryGen.SQL + '    SELECT COL_DESCRI AS BAS_DESCRI       ';
      qryGen.SQL := qryGen.SQL + '  FROM REP_CADCOL     ';
      qryGen.SQL := qryGen.SQL + '    WHERE COL_CODCOL = :CODBAS            ';
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

function TFormulaAutomotivaRennerPerformance.GetFatorEstoque: Double;
begin
  Result := 0.9;
end;

function TFormulaAutomotivaRennerPerformance.GetIdePro: String;
begin
  Result := 'REP';
end;

function TFormulaAutomotivaRennerPerformance.GetIndEmb(
  const dtsCadTin: IDataSet): integer;
begin
  Result := -1;
end;

function TFormulaAutomotivaRennerPerformance.GetLinha(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaRennerPerformance.GetMontadora(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaRennerPerformance.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaAutomotivaRennerPerformance.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaAutomotivaRennerPerformance.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaAutomotivaRennerPerformance.GetNomeTabelaBases: String;
begin
  Result := 'REP_CADBAS';
end;

Procedure TFormulaAutomotivaRennerPerformance.pPreencherPesCorFor(const dtsCadTin: IDataSet);
begin
  Self.PesoCor := 0;
  Self.PesoFor := 0;
end;

{$IFNDEF LINUX}
procedure TFormulaAutomotivaRennerPerformance.pRecalculaFormulaMostrarDigitado(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; fltFator: Double;
  blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha, strTipBas: String);
begin
  Begin
    lsvFormulacao.Items.Add.Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    lsvFormulacao.Items[intCont].SubItems.Add(strTipBas);
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado * fltFator, ffFixed, 12, 2));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(TAutcomTintaFactory.Get.fFormataFloatSky(Base.QuantidadeDiluido * fltFator), ffFixed, 12, 2));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(TAutcomTintaFactory.Get.fFormataFloatSky(Base.QuantidadeDiluido2 * fltFator), ffFixed, 12, 2));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TFormulaAutomotivaRennerPerformance.pRecalculaFormulaMostrarPadrao(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; blnConsLinhaDesBas: Boolean;
  strTipBas: String; intCont: Integer);
begin
  Begin
    lsvFormulacao.Items.Add.Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    lsvFormulacao.Items[intCont].SubItems.Add(strTipBas);

    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado, ffFixed, 12, 2));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(TAutcomTintaFactory.Get.fFormataFloatSky(Base.QuantidadeDiluido), ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(TAutcomTintaFactory.Get.fFormataFloatSky(Base.QuantidadeDiluido2), ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

function TFormulaAutomotivaRennerPerformance.GetPrefixoFormulacao: String;
begin
  Result := 'REP_FORM';
end;

function TFormulaAutomotivaRennerPerformance.GetPrefixoLitragem(
  const strModo: String): String;
begin
  Result := '';
end;

function TFormulaAutomotivaRennerPerformance.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'REP_QTDC'
end;

function TFormulaAutomotivaRennerPerformance.GetProdutoVendaTinta(const dtsCadTin: IDataSet): string;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('REP').fGet('PROREP');
end;

function TFormulaAutomotivaRennerPerformance.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaAutomotivaRennerPerformance.GetSelectBases: String;
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

function TFormulaAutomotivaRennerPerformance.GetSelectColorantes: String;
begin
  Result := ' UNION ALL                   ';
  Result := Result + '  SELECT            ';
  Result := Result + '    COL_CODCOL AS BAS_CODBAS,     ';
  Result := Result + '    COL_CODITE AS BAS_CODITE,     ';
  Result := Result + '    COL_EMBALA AS BAS_EMBALA,     ';
  Result := Result + '    COL_PESESP AS BAS_PESESP,     ';
  Result := Result + '    IFNULL(ITE_ITEATI, "N") ITE_ITEATI,       ';
  Result := Result + '    ITE_CNV_ML AS CNV_ML,     ';
  Result := Result + '    ITE_IPISAI AS IPISAI,     ';
  Result := Result + '    ITE_OUTVAL AS OUTVAL,     ';
  Result := Result + '    ITE_ICMSAI AS ICMSAI,     ';
  Result := Result + '    ITE_IMPFED AS IMPFED,     ';
  Result := Result + '    ITE_DESOPE AS DESOPE,     ';
  Result := Result + '    ITE_PREMED AS PREMED,     ';
  Result := Result + '    ITE_IMPULT AS IMPULT,     ';
  Result := Result + '    ITE_PREULT AS PREULT,     ';
  Result := Result + '    ITE_PRECOM AS PRECOM,     ';
  Result := Result + '    ITE_DESF01 AS DESF01,     ';
  Result := Result + '    ITE_DESF02 AS DESF02,     ';
  Result := Result + '    ITE_DESF03 AS DESF03,     ';
  Result := Result + '    ITE_DESF04 AS DESF04,     ';
  Result := Result + '    ITE_DESF05 AS DESF05,     ';
  Result := Result + '    ITE_DESF06 AS DESF06     ';


  If TAutcomTintaFactory.Get.fCfgSis('IMPDIG') = '1' Then
    Result := Result  + '   , I.ITE_IMPDIR AS IMPDIR '
  else
    Result := Result  + '   , G.ITE_IMPDIR AS IMPDIR ';

  If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '0') Then
  begin
    Result := Result +
      '   , ' + GetNomeCampoCustoBase + ' AS PRECUS ' +
      '   , ' + GetNomeCampoVendaBase + ' AS PREVEN ';
  end

  Else If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') And BlnCalculaUnitario Then
  begin
    Result := Result +
      '   , ITE_PRECUS               ' +
      '   , ITE_PREVE' + TAutcomTintaFactory.Get.fCfgSis('TABPRE') + ' AS PREVEN ';
  end
  else
  begin
    Result := Result +
      '   , ITE_PRECUS               ' +
      '   , ITE_PREVE' + Self.strTabPre + ' AS PREVEN ';
  end;

  Result := Result + '  FROM            ';
  Result := Result + '    REP_CADCOL  C      ';
  Result := Result + '  INNER JOIN ITEGER G ON        ';
  Result := Result + '    C.COL_CODITE = G.ITE_CODITE       ';
  Result := Result + '  INNER JOIN CADITE I ON        ';
  Result := Result + '    G.ITE_CODITE = I.ITE_CODITE       ';
end;

function TFormulaAutomotivaRennerPerformance.GetTextoInformativoCalculo: String;
begin
  Result :=
  'Valor da Base = (Quantidade * Preço da Base) / (Embalagem * Peso Especifico)' + sLineBreak +
  'Valores dos Colorantes = (Quantidade * Preço do Colorante) / (Embalagem * Peso Especifico)' + sLineBreak +
  'Preço da Tinta = (Soma do Valor da Base + Soma do Valor do Colorante de todos colorantes)';
end;

function TFormulaAutomotivaRennerPerformance.GetUniversal(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaRennerPerformance.GetVolumeMaximoGalao(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 4.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('REP').fGetDouble('VOLGAL'), 3);
end;

function TFormulaAutomotivaRennerPerformance.GetVolumeMaximoLitro(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 1.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('REP').fGetDouble('VOLLIT'), 3);
end;

function TFormulaAutomotivaRennerPerformance.GetVolumePadraCopo: Double;
begin
  Result := 0;
end;

function TFormulaAutomotivaRennerPerformance.GetVolumePadraGalao(dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 3.600;
    Exit;
  End;


  If dtsCadTin.FieldByName('REP_CODBAS').AsString = 'RHB300' Then
    Result := 3.600
  Else If dtsCadTin.FieldByName('REP_CODBAS').AsString = 'RHB347' Then
    Result := 2.700
  Else
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('REP').fGetDouble('VOLGAL'), 3);
end;

function TFormulaAutomotivaRennerPerformance.GetVolumePadraLitro: Double;
begin
  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('REP').fGetDouble('VOLLIT'), 3);
end;

function TFormulaAutomotivaRennerPerformance.GetVolumePadraSpray: Double;
begin
  Result := 0;
end;


function TFormulaAutomotivaRennerPerformance.GetVolumePadraTambor(dtsCadTin: IDataSet): Double;
begin
  Result := 0;
end;

function TFormulaAutomotivaRennerPerformance.GetVolumePermitido(
  const dtsCadTin: IDataSet; strTipoPre: String): Double;
begin
  Result := 0;
end;

procedure TFormulaAutomotivaRennerPerformance.pDefineVolumeOriginal;
begin
  If Self.mveModoVenda = mvConcentrado then
    Self.VolumeOri := Self.VolumeConcentrado
  Else
    Self.VolumeOri := Self.VolumeDiluido;
end;

procedure TFormulaAutomotivaRennerPerformance.pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet);
var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('REP');




  sProEmbTb := '';
  sProEmbBa := '';
  sProEmbSs := '';
  sProEmbPo := '';
  sProEmbSd := '';

  stlDesEmb.Clear;
  stlDesEmb.Add('');


  stlProEmbLt.Add(Conf.fGet('REPLIT'));
  stlProEmbGl.Add(Conf.fGet('REPGAL'));
end;

procedure TFormulaAutomotivaRennerPerformance.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('REP_ACRMOB').AsFloat;
end;

procedure TFormulaAutomotivaRennerPerformance.PreencheQuantidadeFormulacaoVenda(
  const dtsCadTin: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
begin

  Base := TBaseAutomotiva(Self.Add);
  Base.CodigoBase := dtsCadTin.FieldByName('REP_CODBAS').AsString;
  Base.QuantidadeConcentrado := dtsCadTin.FieldByName('REP_QTDBAS').AsFloat;
  Base.TipoBase              := 'B';


  For intContador := 1 To Self.GetQuantidadeFormulacao Do
  Begin

    If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('REP_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
      Break;

    Base := TBaseAutomotiva(Self.Add);
    Base.CodigoBase := dtsCadTin.FieldByName('REP_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString;
    Base.QuantidadeConcentrado := dtsCadTin.FieldByName('REP_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
    Base.TipoBase              := 'CO';
  End;
end;

procedure TFormulaAutomotivaRennerPerformance.PreencheVolumeVenda(const dtsCadTin: IDataSet);
begin
  Self.VolumeOri         := 0.9;
  Self.VolumeConcentrado := 0.9;
  Self.VolumeDiluido     := 0.9;
end;

end.
