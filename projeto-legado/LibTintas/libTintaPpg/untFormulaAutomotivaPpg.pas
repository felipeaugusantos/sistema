{************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula Ppg *}
{*********************************************************************AC*}
unit untFormulaAutomotivaPpg;

interface

uses
{$IFNDEF LINUX}
  Controls,
  ComCtrls,
{$ENDIF}
  untAbstractFormulaAutomotiva, untICalculadorFormulaAutomotiva, untIDataSet, untBaseAutomotiva,
  SysUtils, untStrUtils, Classes, untIConfTinta, untFloatUtils, untModoVenda, untVariantUtils,
  untIDicionario, Variants, untISaldosColorantes;


type
  TMinMax = record
    fltMin : Double;
    fltMax : Double;
  end;

type
  TFormulaAutomotivaPpg = class(TAbstractFormulaAutomotiva)
  private
    arrMinMax : array of TMinMax;
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

    function fRetEmbalagemLT(strTipCor: String): String;
    function fRetEmbalagemGL(strTipCor: String): String;
    function fRetEmbalagemBD(strTipCor: String): String;
    function fRetEmbalagemTB(strTipCor: String): String;
    function fRetEmbalagemSP: String;


    function fRetDiluentes(strTipCor: String; intModDil: Integer; strCatalisador: String): TStringList;
    function fConfEmbalagem(strCodCfg : String) : String;

    function GetIndEmb(const dtsCadTin: IDataSet): integer; override;
    procedure PreencheQuantidadeFormulacaoVenda(const dtsCadTin: IDataSet); override;
    procedure pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet); override;
    function GetVolumePermitido(const dtsCadTin: IDataSet; strTipoPre: String):Double; override;
    function GetVolumePadraLitro: Double;

    function fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer; dtsCadTin: IDataSet): Double; override;

    function GetLinha(const dtsCadTin: IDataSet): string; override;

    function fGetDiluentes(const dtsCadTin: IDataSet): TStringList; override;

    function GetVolumePadraGalao(dtsCadTin: IDataSet): Double; override;

    function GetVolumePadraCopo : Double;  override;
    function GetVolumePadraSpray: Double;  override;
    function GetVolumePadraTambor(dtsCadTin: IDataSet): Double; override;
    function GetVolumePadraoBalde(dtsCadTin: IDataSet): Double; override;
    function GetVolumeMaximoSpray(dtsCadTin: IDataSet): Double; Override;

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


    function fArredondaPPG(fltValor: Double): Double;

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

    procedure pPreencheListaAdicionalBases; override;
    procedure IniciaArrMinMax(const dtsCadTin: IDataSet);
    procedure pAtualizaPorcentagem(const formula: TAbstractFormulaAutomotiva;  dtsCadTin: IDataSet = Nil); override;
    procedure pCalcularDiluente(const strCodDil: string; const fltPorDil: Double; const dtsCadTin: IDataSet);override;

    function GetVolumeMaximoLitro(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoGalao(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoBalde(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoTambor(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoCopo(dtsCadTin: IDataSet): Double; Override;

    function fExisteConfiguracao(dtsCadTin: IDataSet; strEmbalagem: String): Boolean; Override;
    function fRetEmbLitro(dtsCadTin: IDataSet): String;
    function fRetEmbGalao(dtsCadTin: IDataSet): String;
    function fRetEmbBalde(dtsCadTin: IDataSet): String;
    function fRetEmbTambor(dtsCadTin: IDataSet): String;
    function fRetEmbCopo(dtsCadTin: IDataSet): String;
    function GetSaldos: ISaldosColorantes; Override;
    function fQuantidadeMenorIgualZero: Boolean; Override;
    procedure CarregaPrecosBases; Override;


  end;

implementation

uses
  untCalculadorFormulaAutomotivaPpg, untAutcomTintaFactory, untGenericSaldosColorantes;

{ TFormulaAutomotivaPpg }

procedure TFormulaAutomotivaPpg.CarregaPrecosBases;
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

  For intContador := 0 To Self.Count-1 Do
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

      If (GetDataSetBases.FieldByName('BAS_BASEPO').AsString = 'S') Then
        Base.PesoEspecifico := 1;

      Base.PesGra                    := GetBasPesGra(GetDataSetBases);

      blnEmPromo := TAutcomTintaFactory.Get.fCarregaPromocao(GetDataSetBases.FieldByName('BAS_CODITE').AsString,
                                                             strTabPre, Self.strCodCli, Self.strCodCnd, Self.intPrzMed,
                                                             fltPreCus, fltPreVen, blnPrecoFixoParaTintaDeMaquinaImobiliaria, strCodEmpresa);

      if (blnEmPromo) And (Not Self.blnProPre) then
      begin
        Base.PrecoCusto := fltPreCus;
        Base.PrecoVenda := fltPreVen;

        If strTabPre = strTabPreTin Then
          Self.Promoc := 'S';

        if Base.PrecoCusto = 0 then
          Base.PrecoCusto := GetDataSetBases.FieldByName('ITE_PRECUS').AsFloat;
      end
      else
      begin
        Base.PrecoCusto := GetDataSetBases.FieldByName('ITE_PRECUS').AsFloat;
        Base.PrecoVenda := GetDataSetBases.FieldByName('ITE_PREVEN').AsFloat;

        If (Self.blnProPre) And (blnEmPromo) And (strTabPre = strTabPreTin) Then
          Self.Promoc := 'S';
      end;
      CarregaPrecosColorantesAdicional(GetDataSetBases, Base);
    End;
  End;

  TextoInformativoCalculo.Text := GetTextoInformativoCalculo;
end;

procedure TFormulaAutomotivaPpg.CarregaPrecosBasesPorEmpresa;
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

      If (GetDataSetBases.Locate('BAS_CODBAS', Base.CodigoBase, [])) Then
        Base.PesGra := GetBasPesGra(GetDataSetBases);

      blnEmPromo := TAutcomTintaFactory.Get.fCarregaPromocao(GetDataSetBasesPorEmpresa.FieldByName('BAS_CODITE').AsString,
                                                             strTabPre, Self.strCodCli, Self.strCodCnd, Self.intPrzMed,
                                                             fltPreCus, fltPreVen, blnPrecoFixoParaTintaDeMaquinaImobiliaria, strCodEmpresa);

      if (blnEmPromo) And (Not Self.blnProPre) then
      begin
        Base.PrecoCusto := fltPreCus;
        Base.PrecoVenda := fltPreVen;

        If strTabPre = strTabPreTin Then
          Self.Promoc := 'S';

        if Base.PrecoCusto = 0 then
          Base.PrecoCusto := GetDataSetBasesPorEmpresa.FieldByName('ITE_PRECUS').AsFloat;
      end
      else
      begin
        Base.PrecoCusto := GetDataSetBasesPorEmpresa.FieldByName('ITE_PRECUS').AsFloat;
        Base.PrecoVenda := GetDataSetBasesPorEmpresa.FieldByName('ITE_PREVEN').AsFloat;

        If (Self.blnProPre) And (blnEmPromo) And (strTabPre = strTabPreTin) Then
          Self.Promoc := 'S';
      end;
      CarregaPrecosColorantesAdicional(GetDataSetBasesPorEmpresa, Base);
    End;
  End;

  TextoInformativoCalculo.Text := GetTextoInformativoCalculo;
end;

procedure TFormulaAutomotivaPpg.CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva);
begin
  Base.Cnv_Ml := Base.Embalagem * Base.PesoEspecifico;
end;

procedure TFormulaAutomotivaPpg.CarregarBasesPorEmpresa(const dicRetorno: IDicionario);
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

  Else If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') And BlnCalculaUnitario Then
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
    '    PPG_BASEMP B     ' +
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

  {GetDataSetBasesPorEmpresa.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.IIF(TStrUtils.fEmptyStr(TVariantUtils.IfNull(dicRetorno['codempprd'],''))
                                                                               , TAutcomTintaFactory.Get.GetCodEmp
                                                                               , dicRetorno['codempprd']); }
  strCodEmp := GetDataSetBasesPorEmpresa.ParamByName('CODEMP').AsString;
  GetDataSetBasesPorEmpresa.Open;

end;

function TFormulaAutomotivaPpg.fArredondaPPG(fltValor: Double): Double;
  Var
    strAux: String;
begin
  strAux := Format('%.2f', [fltValor]);
  strAux := Copy(strAux, 1, Length(strAux) - 1);

  If (TAutcomTintaFactory.Get.fStrToFloat(strAux) = 0) Then
    strAux := Format('%.2f', [fltValor]);

  Result := TAutcomTintaFactory.Get.fStrToFloat(strAux);
end;

function TFormulaAutomotivaPpg.fCalculaQuantidadeParaBaixaEstoque(Base: TBaseAutomotiva): Double;
begin
  Result := TAutcomTintaFactory.Get.IIF(Self.mveModoVenda = mvConcentrado, base.QuantidadeConcentrado, base.QuantidadeDiluido) * (Self.fltVolumePro / Self.fltVolumeOri);
end;

function TFormulaAutomotivaPpg.fConfEmbalagem(strCodCfg: String): String;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT CFG_CODITE '+
                '  FROM CFGEMB '+
                ' WHERE CFG_CODCFG = :CODCFG '+
                '   AND CFG_PRINCI =  "S"';
  qryGen.ParamByName('CODCFG').AsString := strCodCfg;
  qryGen.Open;

  Result := qryGen.FieldByName('CFG_CODITE').AsString;
end;

function TFormulaAutomotivaPpg.fExisteConfiguracao(dtsCadTin: IDataSet;
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
    qryConf.SQL := qryConf.SQL + '    CFG_IDEPRO = "PPG" AND          ';
    qryConf.SQL := qryConf.SQL + '    CFG_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" AND            ';

    If strEmbalagem = 'Litro' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "' + fRetEmbLitro(dtsCadTin) + '"      '
    Else If strEmbalagem = 'Galão' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "' + fRetEmbGalao(dtsCadTin) + '"      '
    Else If strEmbalagem= 'Balde' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "' + fRetEmbBalde(dtsCadTin) + '"      '
    Else If strEmbalagem = 'Tambor' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "' + fRetEmbTambor(dtsCadTin) + '"     '
    Else If strEmbalagem = 'Copo' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "' + fRetEmbCopo(dtsCadTin) + '"       '
    Else If strEmbalagem = 'Spray' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLSPR"       ';

    qryConf.Open;

    Result := (Not qryConf.IsEmpty);
  Except
    Raise;
  End;
end;

function TFormulaAutomotivaPpg.fMostrarComCatalisador: Boolean;
begin
  Result := False;
end;



function TFormulaAutomotivaPpg.fQuantidadeMenorIgualZero: Boolean;
var
  intContador: Integer;
  Base: TBaseAutomotiva;
  fltFator: Double;
begin
  Result := False;

  If Self.VolumeOri > 0 Then
    fltFator := Self.VolumePro / Self.VolumeOri
  Else
    fltFator := 1;

  If Self.VolumeOri > 1 Then
    fltFator := fltFator * 1000;

  For intContador := 0 To Self.Count-1 Do
  Begin
    Base := TBaseAutomotiva(Self.Items[intContador]);

    If mveModoVenda = mvConcentrado Then
    Begin

      If Base.TipoBase = 'D' Then
        Continue;

      If (fArredondaPPG(Base.QuantidadeConcentrado * fltFator) <= 0) And (Pos('PERSONALIZ', Base.System) <= 0) Then
      Begin
        Result := True;
        Continue;
      End
      Else If (Base.TipoBase = 'B') And ((Base.QuantidadeConcentrado * fltFator) <= 0) And (Not fBaseDiluente(Base))Then
      Begin
        Result := False;
        Continue;
      End;
    End
    Else
    Begin
      If (fArredondaPPG(Base.QuantidadeDiluido * fltFator) <= 0) And (Pos('PERSONALIZ', Base.System) <= 0) Then
      Begin
        Result := True;
        Continue;
      End
      Else If ((Base.QuantidadeDiluido * fltFator) <= 0) Then
      Begin
        Result := False;
        Continue;
      End;
    End;
  End;
end;

function TFormulaAutomotivaPpg.fRetDiluentes(strTipCor: String;
  intModDil: Integer; strCatalisador: String): TStringList;
begin
  Result := TStringList.Create;
  Result.Clear;

  If (strTipCor = 'DELTRON DG') Or (strTipCor = 'DELTRON BC') Then
  Begin
    If intModDil <> 2 Then
    Begin
      Result.Add('D808');
      Result.Add('807');

      If strCatalisador <> 'D863' Then
        Result.Add('D812');
    End;
  End
  Else
    Result.Add('Sem Diluente');
end;

function TFormulaAutomotivaPpg.fRetEmbalagemBD(strTipCor: String): String;
Var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get().fGetConfTinta('PPG');

  If Pos('DELTRON', strTipCor) > 0 Then
    Result := conf.fGet('PPGLADT')
  Else If Pos('DELFLEET', strTipCor) > 0 Then
    Result := conf.fGet('PPGLADF')
  Else If Pos('DULON', strTipCor) > 0 Then
    Result := conf.fGet('PPGLADU')
  Else If Pos('OMNI', strTipCor) > 0 Then
    Result := conf.fGet('PPGLAOM')
  Else If Pos('ENVIROBASE', strTipCor) > 0 Then
    Result := conf.fGet('PPGBEN');

  If (conf.fGet('NOVFOR') = 'S') Then
  Begin
    Result := '';
    //Forma nova de carregar com troca de embalagem
    If Pos('2K', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMLA2K')
    Else If Pos('ACS', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMLAAC')
    Else If Pos('DELFLEET', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMLADF')
    Else If Pos('DELTRON', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMLADT')
    Else If Pos('DULON', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMLADU')
    Else If Pos('ENVIROBASE', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMLAEB')
    Else If Pos('INDUSTRAN', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMLAIN')
    Else If Pos('SPECTRAL GREY', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMLASG')
    Else If Pos('ZYNAMIX', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMLAZY');
  End;

end;

function TFormulaAutomotivaPpg.fRetEmbalagemGL(strTipCor: String): String;
Var
  conf: IConfTinta;
begin
  conf    := TAutcomTintaFactory.Get().fGetConfTinta('PPG');

  if Pos('DELTRON', strTipCor) > 0 then
    Result := conf.fGet('PPGGDT')
  Else If Pos('DELFLEET', strTipCor) > 0 Then
    Result := conf.fGet('PPGGDF')
  Else If Pos('DULON', strTipCor) > 0 Then
    Result := conf.fGet('PPGGDU')
  Else If Pos('OMNI', strTipCor) > 0 Then
    Result := conf.fGet('PPGGOM')
  Else If Pos('ENVIROBASE', strTipCor) > 0 Then
    Result := conf.fGet('PPGGEN');

  If (conf.fGet('NOVFOR') = 'S') Then
  Begin
    Result := '';
    //Forma nova com troca de embalagem
    If Pos('2K', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMG2K')
    Else If Pos('ACS', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMGAC')
    Else If Pos('DELFLEET', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMGDF')
    Else If Pos('DELTRON', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMGDT')
    Else If Pos('DULON', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMGDU')
    Else If Pos('ENVIROBASE', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMGEB')
    Else If Pos('INDUSTRAN', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMGIN')
    Else If Pos('SPECTRAL GREY', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMGSG')
    Else If Pos('ZYNAMIX', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMGZY');
  End;

end;

function TFormulaAutomotivaPpg.fRetEmbalagemLT(strTipCor: String): String;
Var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get().fGetConfTinta('PPG');

  if Pos('DELTRON', strTipCor) > 0 then
    Result := conf.fGet('PPGLDT')
  else if Pos('DELFLEET', strTipCor) > 0 then
    Result := conf.fGet('PPGLDF')
  else if Pos('DULON', strTipCor) > 0 then
    Result := conf.fGet('PPGLDU')
  else if Pos('OMNI', strTipCor) > 0 then
    Result := conf.fGet('PPGLOM')
  else if Pos('ENVIROBASE', strTipCor) > 0 then
    Result := conf.fGet('PPGLEN');

  //AQUI CONFIGURACOES (PM)
  If (conf.fGet('NOVFOR') = 'S') Then
  Begin
    Result := '';
    //forma nova com troca de embalagem
    if Pos('2K', strTipCor) > 0 then
      Result := fConfEmbalagem('PPGPML2K')
    Else If Pos('ACS', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMLAC')
    Else If Pos('DELFLEET', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMLDF')
    Else If Pos('DELTRON', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMLDT')
    Else If Pos('DULON', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMLDU')
    Else If Pos('ENVIROBASE', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMLEB')
    Else If Pos('INDUSTRAN', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMLIN')
    Else If Pos('SPECTRAL GREY', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMLSG')
    Else If Pos('ZYNAMIX', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMLZY');
  End;

end;

function TFormulaAutomotivaPpg.fRetEmbalagemSP: String;
Var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get().fGetConfTinta('PPG');
  Result := conf.fGet('PSPRAY');
end;

function TFormulaAutomotivaPpg.fRetEmbalagemTB(strTipCor: String): String;
Var
  conf: IConfTinta;
  // confEmb: IConfEmb;
begin
  conf := TAutcomTintaFactory.Get().fGetConfTinta('PPG');

  If Pos('DELTRON', strTipCor) > 0 Then
    Result := conf.fGet('PPGTDT')
  Else If Pos('DELFLEET', strTipCor) > 0 Then
    Result := conf.fGet('PPGTDF')
  Else If Pos('DULON', strTipCor) > 0 Then
    Result := conf.fGet('PPGTDU')
  Else If Pos('OMNI', strTipCor) > 0 Then
    Result := conf.fGet('PPGTOM')
  Else If Pos('ENVIROBASE', strTipCor) > 0 Then
    Result := conf.fGet('PPGTEN');

  If (conf.fGet('NOVFOR') = 'S') Then
  Begin
    Result := '';
    If Pos('2K', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMT2K')
    Else If Pos('ACS', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMTAC')
    Else If Pos('DELFLEET', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMTDF')
    Else If Pos('DELTRON', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMTDT')
    Else If Pos('DULON', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMTDU')
    Else If Pos('ENVIROBASE', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMTEB')
    Else If Pos('INDUSTRAN', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMTIN')
    Else If Pos('SPECTRAL GREY', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMTSG')
    Else If Pos('ZYNAMIX', strTipCor) > 0 Then
      Result := fConfEmbalagem('PPGPMTZY');
  End;

end;

function TFormulaAutomotivaPpg.fRetEmbBalde(dtsCadTin: IDataSet): String;
begin
  Result := '';

  If Pos('DELTRON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := 'VOLADT'
  Else If Pos('DELFLEET', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := 'VOLADF'
  Else If Pos('DULON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := 'VOLADU'
  Else If Pos('OMNI', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := 'VOLAOM'
  Else If Pos('ENVIROBASE', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := 'VOLBEN';

  If TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGet('NOVFOR') = 'S' Then
  Begin
    If Pos('2K', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMA2K'
    Else If Pos('ACS', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMAAC'
    Else If Pos('DELFLEET', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMADF'
    Else If Pos('DELTRON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMADT'
    Else If Pos('DULON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMADU'
    Else If Pos('ENVIROBASE', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMAEB'
    Else If Pos('INDUSTRAN', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMAIN'
    Else If Pos('SPECTRAL GREY', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMASG'
    Else If Pos('ZYNAMIX', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMAZY';
  End;
end;

function TFormulaAutomotivaPpg.fRetEmbCopo(dtsCadTin: IDataSet): String;
begin
  Result := '';

  If TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGet('NOVFOR') = 'S' Then
    Result := 'VOLCOP';
end;

function TFormulaAutomotivaPpg.fRetEmbGalao(dtsCadTin: IDataSet): String;
begin
  Result := '';

  If Pos('DELTRON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := 'VOLGDT'
  Else If Pos('DELFLEET', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := 'VOLGDF'
  Else If Pos('DULON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := 'VOLGDU'
  Else If Pos('OMNI', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := 'VOLGOM'
  Else If Pos('ENVIROBASE', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := 'VOLGEN';

  If TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGet('NOVFOR') = 'S' Then
  Begin
    If Pos('2K', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMG2K'
    Else If Pos('ACS', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMGAC'
    Else If Pos('DELFLEET', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMGDF'
    Else If Pos('DELTRON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMGDT'
    Else If Pos('DULON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMGDU'
    Else If Pos('ENVIROBASE', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMGEB'
    Else If Pos('INDUSTRAN', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMGIN'
    Else If Pos('SPECTRAL GREY', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMGSG'
    Else If Pos('ZYNAMIX', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMGZY';
  End;
end;

function TFormulaAutomotivaPpg.fRetEmbLitro(dtsCadTin: IDataSet): String;
begin
  Result := '';

  If Pos('DELTRON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := 'VOLLDT'
  Else If Pos('DELFLEET', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := 'VOLLDF'
  Else If Pos('DULON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := 'VOLLDU'
  Else If Pos('OMNI', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := 'VOLLOM'
  Else If Pos('ENVIROBASE', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := 'VOLLEN';

  If TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGet('NOVFOR') = 'S' Then
  Begin
    If Pos('2K', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPML2K'
    Else If Pos('ACS', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMLAC'
    Else If Pos('DELFLEET', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMLDF'
    Else If Pos('DELTRON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMLDT'
    Else If Pos('DULON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMLDU'
    Else If Pos('ENVIROBASE', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMLEB'
    Else If Pos('INDUSTRAN', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMLIN'
    Else If Pos('SPECTRAL GREY', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMLSG'
    Else If Pos('ZYNAMIX', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMLZY';
  End;
end;

function TFormulaAutomotivaPpg.fRetEmbTambor(dtsCadTin: IDataSet): String;
begin
  Result := '';

  If Pos('DELTRON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := 'VOLTDT'
  Else If Pos('DELFLEET', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := 'VOLTDF'
  Else If Pos('DULON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := 'VOLTDU'
  Else If Pos('OMNI', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := 'VOLTOM'
  Else If Pos('ENVIROBASE', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := 'VOLTEN';

  If TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGet('NOVFOR') = 'S' Then
  Begin
    If Pos('2K', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMT2K'
    Else If Pos('ACS', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMTAC'
    Else If Pos('DELFLEET', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMTDF'
    Else If Pos('DELTRON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMTDT'
    Else If Pos('DULON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMTDU'
    Else If Pos('ENVIROBASE', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMTEB'
    Else If Pos('INDUSTRAN', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMTIN'
    Else If Pos('SPECTRAL GREY', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMTSG'
    Else If Pos('ZYNAMIX', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := 'VOLPMTZY';
  End;
end;

function TFormulaAutomotivaPpg.fValidaVolumeFormulucao(strTipoPre: String;
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaPpg.fVolumePadraoLitro(fltVolumePadraoLitro: Double;
  intModoVenda: Integer; dtsCadTin: IDataSet): Double;
begin
  Result := Self.VolumeOri;

  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := Self.VolumeOri;
    Exit;
  End;

  If Pos('DELTRON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLLDT'), 3)
  Else If Pos('DELFLEET', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLLDF'), 3)
  Else If Pos('DULON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLLDU'), 3)
  Else If Pos('OMNI', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLLOM'), 3)
  Else If Pos('ENVIROBASE', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLLEN'), 3);

  If TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGet('NOVFOR') = 'S' Then
  Begin
    If Pos('2K', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPML2K'), 3)
    Else If Pos('ACS', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMLAC'), 3)
    Else If Pos('DELFLEET', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMLDF'), 3)
    Else If Pos('DELTRON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMLDT'), 3)
    Else If Pos('DULON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMLDU'), 3)
    Else If Pos('ENVIROBASE', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMLEB'), 3)
    Else If Pos('INDUSTRAN', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMLIN'), 3)
    Else If Pos('SPECTRAL GREY', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMLSG'), 3)
    Else If Pos('ZYNAMIX', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMLZY'), 3);
  End;
end;

function TFormulaAutomotivaPpg.GetAcrescimoDespesaOperacionalTinta: Double;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('DESOPE');
end;

function TFormulaAutomotivaPpg.GetAno(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('PPG_A_N_O_').AsString;
end;

function TFormulaAutomotivaPpg.GetCalcDespesasOperacionais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  If Pos('PERSONALIZ', Self.strCodFormul) > 0 Then
    fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido)
  Else
    fltQtdFor := fArredondaPPG(TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido), 1));

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  fltVenBas := (fltQtdFor * base.PrecoVenda / base.Cnv_Ml);

  Result := (fltVenBas * base.DespesasOperacionais / 100);
end;

function TFormulaAutomotivaPpg.GetCalcIcmsSaida(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  If Pos('PERSONALIZ', Self.strCodFormul) > 0 Then
    fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido)
  Else
    fltQtdFor := fArredondaPPG(TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido), 1));

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  fltVenBas := (fltQtdFor * base.PrecoVenda / base.Cnv_Ml);

  Result := (fltVenBas * base.IcmsSaida / 100);
end;

function TFormulaAutomotivaPpg.GetCalcImpostosFederais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
Var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  If Pos('PERSONALIZ', Self.strCodFormul) > 0 Then
    fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido)
  Else
    fltQtdFor := fArredondaPPG(TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido), 1));

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  fltVenBas := (fltQtdFor * base.PrecoVenda / base.Cnv_Ml);

  Result := (fltVenBas * base.ImpostosFederais / 100);
end;

function TFormulaAutomotivaPpg.GetCalcOutrosValores(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  If Pos('PERSONALIZ', Self.strCodFormul) > 0 Then
    fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido)
  Else
    fltQtdFor := fArredondaPPG(TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido), 1));

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  Result := (fltQtdFor * base.OutrosValores / base.Cnv_Ml);
end;

function TFormulaAutomotivaPpg.GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  If Pos('PERSONALIZ', Self.strCodFormul) > 0 Then
    fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido)
  Else
    fltQtdFor := fArredondaPPG(TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido), 1));

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  Result := (fltQtdFor * base.PrecoCompraLiquido / base.Cnv_Ml);
end;

function TFormulaAutomotivaPpg.GetCalcPrecoCusto(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  If Pos('PERSONALIZ', Self.strCodFormul) > 0 Then
    fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido)
  Else
    fltQtdFor := fArredondaPPG(TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido), 1));

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  Result := (fltQtdFor * base.PrecoCusto / base.Cnv_Ml);
end;

function TFormulaAutomotivaPpg.GetCalcPrecoCustoReal(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  If Pos('PERSONALIZ', Self.strCodFormul) > 0 Then
    fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido)
  Else
    fltQtdFor := fArredondaPPG(TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido), 1));

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  Result := (fltQtdFor * base.PrecoCustoReal / base.Cnv_Ml);
end;

function TFormulaAutomotivaPpg.GetCalcPrecoMedio(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  If Pos('PERSONALIZ', Self.strCodFormul) > 0 Then
    fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido)
  Else
    fltQtdFor := fArredondaPPG(TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido), 1));

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  Result := (fltQtdFor * base.PrecoMedio / base.Cnv_Ml);
end;

function TFormulaAutomotivaPpg.GetCalcPrecoVenda(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
Var
  fltQtdFor: Double;
Begin
  If Pos('PERSONALIZ', Self.strCodFormul) > 0 Then
    fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido)
  Else
    fltQtdFor := fArredondaPPG(TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido), 1));

  Result := (((formula.VolumePro / formula.VolumeOri * fltQtdFor) * base.PrecoVenda) / Base.Cnv_Ml);
end;

function TFormulaAutomotivaPpg.GetCalcQuantidade(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
Var
  fltQtdFor: Double;
begin
  If Pos('PERSONALIZ', Self.strCodFormul) > 0 Then
    fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido)
  Else
    fltQtdFor := fArredondaPPG(TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido), 1));

  Result := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));
end;

function TFormulaAutomotivaPpg.GetCalculadorInterno: ICalculadorFormulaAutomotiva;
begin
  Result := TCalculadorFormulaAutomotivaPpg.Create(Self);
end;

function TFormulaAutomotivaPpg.GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  If Pos('PERSONALIZ', Self.strCodFormul) > 0 Then
    fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido)
  Else
    fltQtdFor := fArredondaPPG(TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido), 1));

  fltQtdFor := fltQtdFor * formula.VolumePro / formula.VolumeOri;

  Result := (fltQtdFor * base.UltimoPrecoCompra / base.Cnv_Ml);
end;

function TFormulaAutomotivaPpg.GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  If Pos('PERSONALIZ', Self.strCodFormul) > 0 Then
    fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido)
  Else
    fltQtdFor := fArredondaPPG(TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido), 1));

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  Result := (fltQtdFor * base.UltimoPrecoCompraImpostos / base.Cnv_Ml);
end;

function TFormulaAutomotivaPpg.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('PPG_MD5KEY').AsString;
end;

function TFormulaAutomotivaPpg.GetCodFormul(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('PPG_SISTEM').AsString;
end;

function TFormulaAutomotivaPpg.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('PPG_DESCOR').AsString + ' ' +
            dtsCadTin.FieldByName('PPG_TIPO__').AsString + ' ' +
            dtsCadTin.FieldByName('PPG_A_N_O_').AsString + ' ' +
            dtsCadTin.FieldByName('PPG_CODCOR').AsString;
end;

function TFormulaAutomotivaPpg.GetDescricaoBase(strCodBas: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DESBAS '+
                    '  FROM PPG_CADBAS '+
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

function TFormulaAutomotivaPpg.fGetDiluentes(const dtsCadTin: IDataSet): TStringList;
var
  qryGen      : IDataSet;
begin

  Self.ListaAdicional.Clear;

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT DISTINCT                    '+
                '   *                                '+
                ' FROM                               '+
                '   PPG_CADBAS B                     '+
                '   INNER JOIN PPG_CADDIL D          '+
                '     ON B.BAS_CODBAS = D.DIL_CODDIL '+
                ' WHERE BAS_TIPO__ = :TIPO           '+
                '   AND DIL_SISTEM = :SISTEM         ';


  qryGen.ParamByName('TIPO').AsString   := dtsCadTin.FieldByName('PPG_TIPO__').AsString;
  qryGen.ParamByName('SISTEM').AsString := dtsCadTin.FieldByName('PPG_SISTEM').AsString;
  qryGen.Open;

  Result := TStringList.Create;

  While not qryGen.Eof do
  begin
    Result.Add(qryGen.FieldByName('BAS_CODBAS').AsString);
    qryGen.Next;
  end;

  If Result.Count > 0 Then
  Begin
    Self.blnDadosAdicionais  := True;
    Self.strCaptionAdicional := 'Diluentes';
    Self.blnAdicionalDiluido := True;
  End;

end;


function TFormulaAutomotivaPpg.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaAutomotivaPpg.GetIdePro: String;
begin
  Result := 'PPG';
end;

function TFormulaAutomotivaPpg.GetIndEmb(
  const dtsCadTin: IDataSet): integer;
begin
  Result := -1;
end;

function TFormulaAutomotivaPpg.GetLinha(const dtsCadTin: IDataSet): string;
begin
//  Result := dtsCadTin.FieldByName('PPG_TIPO__').AsString;
  Result := dtsCadTin.FieldByName('PPG_SISTEM').AsString;
end;

function TFormulaAutomotivaPpg.GetMontadora(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('MON_DESCRI').AsString;
end;

function TFormulaAutomotivaPpg.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaAutomotivaPpg.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaAutomotivaPpg.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaAutomotivaPpg.GetNomeTabelaBases: String;
begin
  Result := 'PPG_CADBAS ';
end;

Procedure TFormulaAutomotivaPpg.pPreencherPesCorFor(const dtsCadTin: IDataSet);
begin
  Self.PesoCor := 0; //dtsCadTin.FieldByName('GEN_PESCOR').AsFloat;
  Self.PesoFor := 0; //dtsCadTin.FieldByName('GEN_PESFOR').AsFloat;
end;

{$IFNDEF LINUX}
procedure TFormulaAutomotivaPpg.pRecalculaFormulaMostrarDigitado(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; fltFator: Double;
  blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha, strTipBas: String);
begin

  self.fltVolumeOri := 1000;

  If self.fltVolumeOri > 0 Then
    fltFator := self.fltVolumePro / self.fltVolumeOri
  Else
    fltFator := 1;

  If self.fltVolumeOri > 1 Then
    fltFator := fltFator * 1000;

  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    If Pos('PERSONALIZ', Base.System) <= 0 Then
    Begin
      SubItems.Add(FloatToStrF(fArredondaPPG(Base.QuantidadeConcentrado * fltFator), ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(fArredondaPPG(Base.QuantidadeDiluido     * fltFator), ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(fArredondaPPG(Base.QuantidadeDiluido2    * fltFator), ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
      SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
      SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
    End
    Else
    Begin
      SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado * fltFator, ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(Base.QuantidadeDiluido     * fltFator, ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(Base.QuantidadeDiluido2    * fltFator, ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
      SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
      SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
    End;

  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TFormulaAutomotivaPpg.pRecalculaFormulaMostrarPadrao(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; blnConsLinhaDesBas: Boolean;
  strTipBas: String; intCont: Integer);
begin
  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    If Pos('PERSONALIZ', Base.System) <= 0 Then
    Begin
      SubItems.Add(FloatToStrF(fArredondaPPG(Base.QuantidadeConcentrado), ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(fArredondaPPG(Base.QuantidadeDiluido), ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(fArredondaPPG(Base.QuantidadeDiluido2), ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
      SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
      SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
    End
    Else
    Begin
      SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado, ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(Base.QuantidadeDiluido, ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(Base.QuantidadeDiluido2, ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
      SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
      SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
    End;

  End;
end;
{$ENDIF}

function TFormulaAutomotivaPpg.GetPrefixoFormulacao: String;
begin
  Result := 'PPG_CODB';
end;

function TFormulaAutomotivaPpg.GetPrefixoLitragem(
  const strModo: String): String;
begin
  Result := '';
end;

function TFormulaAutomotivaPpg.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'PPG_QTDB';
end;

function TFormulaAutomotivaPpg.GetProdutoVendaTinta(const dtsCadTin: IDataSet): string;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGet('PROPPG');
end;

function TFormulaAutomotivaPpg.GetQuantidadeFormulacao: Integer;

begin
  Result := 20;
end;

function TFormulaAutomotivaPpg.GetSaldos: ISaldosColorantes;
var
  intCont: Integer;
  saldos: TGenericSaldosColorantes;
  base: TBaseAutomotiva;
  fltQtdFormul: Double;
  blnBaseEmpresa: Boolean;
begin
  saldos := TGenericSaldosColorantes.Create();

  For intCont := 0 To Self.Count - 1 Do
  Begin
    base := TBaseAutomotiva(Self.Items[intCont]);

    If GetDataSetBasesPorEmpresa.Locate('BAS_CODBAS;BAS_CODEMP', VarArrayOf([base.CodigoBase, strCodEmp]), []) Then
      blnBaseEmpresa := True
    Else If GetDataSetBases.Locate('BAS_CODBAS', base.CodigoBase, []) Then
      blnBaseEmpresa := False
    Else
      blnBaseEmpresa := False;

    if (Base.TipoBase = 'C') and not(self.ComCatalisador) then
      Continue;

    If (Self.mveModoVenda = mvConcentrado) And (Base.TipoBase = 'D') Then
      Continue;

    fltQtdFormul := fCalculaQuantidadeParaBaixaEstoque(Base);

    if fltQtdFormul > 0 then
    begin
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
    end;
  End;

  Result := Saldos;
end;

function TFormulaAutomotivaPpg.GetSelectBases: String;
begin
  Result := ' SELECT         ' +
            '     BAS_CODBAS ' +
            '   , BAS_CODITE ' +
            '   , BAS_EMBALA ' +
            '   , BAS_DESBAS ' +
            '   , BAS_PESESP ' +
            '   , BAS_TIPO__ ' +
            '   , BAS_BASEPO ' +
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

function TFormulaAutomotivaPpg.GetSelectBasesPorEmpresa: String;
begin
  Result := ' SELECT         ' +
            '     BAS_CODBAS ' +
            '   , BAS_CODEMP ' +
            '   , BAS_CODITE ' +
            '   , BAS_EMBALA ' +
            '   , BAS_PESESP ' +
            '   , "0" AS BAS_EMBALA ' +
            '   , "0" AS BAS_PESESP ' +
            '   , "N" AS BAS_BASEPO ' +
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

function TFormulaAutomotivaPpg.GetTextoInformativoCalculo: String;
begin
  Result  := 'Valor da Base = (Quantidade * Preço) / (Embalagem * Peso Específico)' + sLineBreak +
             'Preço da Tinta = Soma(Valores de Base) * Volume Produzido' ;
end;

function TFormulaAutomotivaPpg.GetUniversal(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaPpg.GetVolumeMaximoBalde(
  dtsCadTin: IDataSet): Double;
begin
  Result := 18.000;

  If Not fExisteConfiguracao(dtsCadTin, 'Balde') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  If Pos('DELTRON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLADT'), 3)
  Else If Pos('DELFLEET', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLADF'), 3)
  Else If Pos('DULON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLADU'), 3)
  Else If Pos('OMNI', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLAOM'), 3)
  Else If Pos('ENVIROBASE', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLBEN'), 3);

  If TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGet('NOVFOR') = 'S' Then
  Begin
    If Pos('2K', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMA2K'), 3)
    Else If Pos('ACS', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMAAC'), 3)
    Else If Pos('DELFLEET', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMADF'), 3)
    Else If Pos('DELTRON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMADT'), 3)
    Else If Pos('DULON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMADU'), 3)
    Else If Pos('ENVIROBASE', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMAEB'), 3)
    Else If Pos('INDUSTRAN', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMAIN'), 3)
    Else If Pos('SPECTRAL GREY', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMASG'), 3)
    Else If Pos('ZYNAMIX', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMAZY'), 3);
  End;
end;

function TFormulaAutomotivaPpg.GetVolumeMaximoCopo(dtsCadTin: IDataSet): Double;
begin
  Result := 0;

  If Not fExisteConfiguracao(dtsCadTin, 'Copo') Then
  Begin
    Result := 0.500;
    Exit;
  End;

  If TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGet('NOVFOR') = 'S' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLCOP'), 3);
end;

function TFormulaAutomotivaPpg.GetVolumeMaximoGalao(
  dtsCadTin: IDataSet): Double;
begin
  Result := 3.600;

  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 4.000;
    Exit;
  End;

  If Pos('DELTRON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLGDT'), 3)
  Else If Pos('DELFLEET', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLGDF'), 3)
  Else If Pos('DULON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLGDU'), 3)
  Else If Pos('OMNI', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLGOM'), 3)
  Else If Pos('ENVIROBASE', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLGEN'), 3);

  If TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGet('NOVFOR') = 'S' Then
  Begin
    If Pos('2K', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMG2K'), 3)
    Else If Pos('ACS', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMGAC'), 3)
    Else If Pos('DELFLEET', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMGDF'), 3)
    Else If Pos('DELTRON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMGDT'), 3)
    Else If Pos('DULON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMGDU'), 3)
    Else If Pos('ENVIROBASE', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMGEB'), 3)
    Else If Pos('INDUSTRAN', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMGIN'), 3)
    Else If Pos('SPECTRAL GREY', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMGSG'), 3)
    Else If Pos('ZYNAMIX', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMGZY'), 3);
  End;
end;

function TFormulaAutomotivaPpg.GetVolumeMaximoLitro(
  dtsCadTin: IDataSet): Double;
begin
  Result := 1.000;

  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 1.000;
    Exit;
  End;

  If Pos('DELTRON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLLDT'), 3)
  Else If Pos('DELFLEET', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLLDF'), 3)
  Else If Pos('DULON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLLDU'), 3)
  Else If Pos('OMNI', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLLOM'), 3)
  Else If Pos('ENVIROBASE', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLLEN'), 3);

  If TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGet('NOVFOR') = 'S' Then
  Begin
    If Pos('2K', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPML2K'), 3)
    Else If Pos('ACS', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMLAC'), 3)
    Else If Pos('DELFLEET', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMLDF'), 3)
    Else If Pos('DELTRON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMLDT'), 3)
    Else If Pos('DULON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMLDU'), 3)
    Else If Pos('ENVIROBASE', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMLEB'), 3)
    Else If Pos('INDUSTRAN', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMLIN'), 3)
    Else If Pos('SPECTRAL GREY', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMLSG'), 3)
    Else If Pos('ZYNAMIX', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMLZY'), 3);
  End;
end;

function TFormulaAutomotivaPpg.GetVolumeMaximoSpray(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Spray') Then
  Begin
    Result := 0.450;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLSPR'), 3);
end;


function TFormulaAutomotivaPpg.GetVolumeMaximoTambor(
  dtsCadTin: IDataSet): Double;
begin
  Result := 200.000;

  If Not fExisteConfiguracao(dtsCadTin, 'Tambor') Then
  Begin
    Result := 200.000;
    Exit;
  End;

  If Pos('DELTRON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLTDT'), 3)
  Else If Pos('DELFLEET', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLTDF'), 3)
  Else If Pos('DULON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLTDU'), 3)
  Else If Pos('OMNI', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLTOM'), 3)
  Else If Pos('ENVIROBASE', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLTEN'), 3);

  If TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGet('NOVFOR') = 'S' Then
  Begin
    If Pos('2K', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMT2K'), 3)
    Else If Pos('ACS', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMTAC'), 3)
    Else If Pos('DELFLEET', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMTDF'), 3)
    Else If Pos('DELTRON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMTDT'), 3)
    Else If Pos('DULON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMTDU'), 3)
    Else If Pos('ENVIROBASE', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMTEB'), 3)
    Else If Pos('INDUSTRAN', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMTIN'), 3)
    Else If Pos('SPECTRAL GREY', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMTSG'), 3)
    Else If Pos('ZYNAMIX', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMTZY'), 3);
  End;
end;

function TFormulaAutomotivaPpg.GetVolumePadraCopo: Double;
begin
  Result := 0.500;

  If Not fExisteConfiguracao(Nil, 'Copo') Then
  Begin
    Result := 0.500;
    Exit;
  End;

  If TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGet('NOVFOR') = 'S' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLCOP'), 3);
end;

function TFormulaAutomotivaPpg.GetVolumePadraGalao(dtsCadTin: IDataSet): Double;
begin
  Result := 3.600;

  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 3.600;
    Exit;
  End;

  If Pos('DELTRON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLGDT'), 3)
  Else If Pos('DELFLEET', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLGDF'), 3)
  Else If Pos('DULON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLGDU'), 3)
  Else If Pos('OMNI', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLGOM'), 3)
  Else If Pos('ENVIROBASE', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLGEN'), 3);

  If TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGet('NOVFOR') = 'S' Then
  Begin
    If Pos('2K', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMG2K'), 3)
    Else If Pos('ACS', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMGAC'), 3)
    Else If Pos('DELFLEET', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMGDF'), 3)
    Else If Pos('DELTRON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMGDT'), 3)
    Else If Pos('DULON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMGDU'), 3)
    Else If Pos('ENVIROBASE', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMGEB'), 3)
    Else If Pos('INDUSTRAN', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMGIN'), 3)
    Else If Pos('SPECTRAL GREY', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMGSG'), 3)
    Else If Pos('ZYNAMIX', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMGZY'), 3);
  End;
end;

function TFormulaAutomotivaPpg.GetVolumePadraLitro: Double;
begin
  Result := 1.000;
end;

function TFormulaAutomotivaPpg.GetVolumePadraoBalde(
  dtsCadTin: IDataSet): Double;
begin
  Result := 18.000;

  If Not fExisteConfiguracao(dtsCadTin, 'Balde') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  If Pos('DELTRON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLADT'), 3)
  Else If Pos('DELFLEET', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLADF'), 3)
  Else If Pos('DULON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLADU'), 3)
  Else If Pos('OMNI', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLAOM'), 3)
  Else If Pos('ENVIROBASE', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLBEN'), 3);

  If TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGet('NOVFOR') = 'S' Then
  Begin
    If Pos('2K', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMA2K'), 3)
    Else If Pos('ACS', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMAAC'), 3)
    Else If Pos('DELFLEET', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMADF'), 3)
    Else If Pos('DELTRON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMADT'), 3)
    Else If Pos('DULON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMADU'), 3)
    Else If Pos('ENVIROBASE', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMAEB'), 3)
    Else If Pos('INDUSTRAN', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMAIN'), 3)
    Else If Pos('SPECTRAL GREY', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMASG'), 3)
    Else If Pos('ZYNAMIX', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMAZY'), 3);
  End;
end;

function TFormulaAutomotivaPpg.GetVolumePadraSpray: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Spray') Then
  Begin
    Result := 0.450;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLSPR'), 3);
end;


function TFormulaAutomotivaPpg.GetVolumePadraTambor(dtsCadTin: IDataSet): Double;
begin
  Result := 200.000;

  If Not fExisteConfiguracao(dtsCadTin, 'Tambor') Then
  Begin
    Result := 200.000;
    Exit;
  End;

  If Pos('DELTRON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLTDT'), 3)
  Else If Pos('DELFLEET', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLTDF'), 3)
  Else If Pos('DULON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLTDU'), 3)
  Else If Pos('OMNI', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLTOM'), 3)
  Else If Pos('ENVIROBASE', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLTEN'), 3);

  If TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGet('NOVFOR') = 'S' Then
  Begin
    If Pos('2K', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMT2K'), 3)
    Else If Pos('ACS', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMTAC'), 3)
    Else If Pos('DELFLEET', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMTDF'), 3)
    Else If Pos('DELTRON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMTDT'), 3)
    Else If Pos('DULON', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMTDU'), 3)
    Else If Pos('ENVIROBASE', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMTEB'), 3)
    Else If Pos('INDUSTRAN', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMTIN'), 3)
    Else If Pos('SPECTRAL GREY', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMTSG'), 3)
    Else If Pos('ZYNAMIX', dtsCadTin.FieldByName('PPG_TIPO__').AsString) > 0 Then
      Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('PPG').fGetDouble('VOLPMTZY'), 3);
  End;
end;

function TFormulaAutomotivaPpg.GetVolumePermitido(
  const dtsCadTin: IDataSet; strTipoPre: String): Double;
begin
  Result := 0;
end;

procedure TFormulaAutomotivaPpg.IniciaArrMinMax(const dtsCadTin: IDataSet);
var
  qryGen : IDataSet;
  intCont: Integer;
begin
  SetLength(arrMinMax, Self.ListaAdicional.Count);

  if Self.ListaAdicional.Count <= 0 then
    Exit;

  qryGen := nil;

  qryGen     := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT DISTINCT                                    ' +
                '   *                                                ' +
                ' FROM                                               ' +
                '   PPG_CADBAS B                                     ' +
                '   INNER JOIN PPG_CADDIL D                          ' +
                '     ON B.BAS_CODBAS = D.DIL_CODDIL                 ' +
                ' WHERE BAS_TIPO__ = :TIPO                           ' +
                '   AND DIL_SISTEM = :SISTEM                         ' +
                '   AND DIL_CODDIL = :CODDIL                         ' +
                ' ORDER BY DIL_SISTEM                                ' ;

  qryGen.ParamByName('TIPO').AsString   := dtsCadTin.FieldByName('PPG_TIPO__').AsString;
  qryGen.ParamByName('SISTEM').AsString := dtsCadTin.FieldByName('PPG_SISTEM').AsString;

  for intCont := 0 to Self.ListaAdicional.Count - 1 do
  begin
    qryGen.Close;
    qryGen.ParamByName('CODDIL').AsString := Self.ListaAdicional[intCont];
    qryGen.Open;

    arrMinMax[intCont].fltMin := qryGen.FieldByName('DIL_MINIMO').AsFloat;
    arrMinMax[intCont].fltMax := qryGen.FieldByName('DIL_MAXIMO').AsFloat;
  end;


end;

procedure TFormulaAutomotivaPpg.pAtualizaPorcentagem(const formula: TAbstractFormulaAutomotiva;  dtsCadTin: IDataSet);
begin

   If (formula.ListaAdicional.Count <= 0) Then
    Exit;

   formula.EdtDil := Length(arrMinMax) > 0;

  If formula.PorDil > arrMinMax[formula.IndiceAdicional].fltMax Then
    formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltMax;

  If Length(arrMinMax) > 0 Then
  Begin
    if arrMinMax[Formula.IndiceAdicional].fltMax = arrMinMax[Formula.IndiceAdicional].fltMin then
      formula.HabDil := False
    else
      formula.HabDil := true;

    If formula.PorDil > arrMinMax[Formula.IndiceAdicional].fltMax Then
      formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltMax;

    If formula.PorDil < arrMinMax[Formula.IndiceAdicional].fltMin Then
      formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltMin;
  End;
end;

procedure TFormulaAutomotivaPpg.pDefineVolumeOriginal;
begin
  If Self.mveModoVenda = mvConcentrado then
    Self.VolumeOri := Self.VolumeConcentrado
  Else
    Self.VolumeOri := Self.VolumeDiluido;
end;

procedure TFormulaAutomotivaPpg.pPreencheListaAdicionalBases;
begin

end;

procedure TFormulaAutomotivaPpg.pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet);
var
  conf      : IConfTinta;
  strTipCor : String;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('PPG');

  DesEmb.Clear;
  ProEmbLt.Clear;
  ProEmbGl.Clear;
  ProEmbLa.Clear;

  sProEmbTb := '';
  sProEmbBa := '';
  sProEmbSs := '';
  sProEmbPo := '';
  sProEmbSd := '';

  strProEmbCo := '';

  stlDesEmb.Clear;

  strTipCor := dtsCadTin.FieldByName('PPG_TIPO__').AsString;

  stlDesEmb.Text := strTipCor;

  stlProEmbLt.Text := fRetEmbalagemLT(strTipCor);
  stlProEmbGl.Text := fRetEmbalagemGL(strTipCor);
  sProEmbBa        := fRetEmbalagemBD(strTipCor);
  sProEmbTb        := fRetEmbalagemTB(strTipCor);
  strProEmbSp      := fRetEmbalagemSP;

  IniciaArrMinMax(dtsCadTin);

  Self.blnMostrarEmbalagem := true;

  If (conf.fGet('NOVFOR') = 'S') Then
    strProEmbCo := conf.fGet('PPGCOP');

  strSistema := dtsCadTin.FieldByName('PPG_SISTEM').AsString;

  If ListaAdicional.Count > 0 Then
    pCalcularDiluente(ListaAdicional[0], 0, dtsCadTin)
  Else
    pCalcularDiluente('', 0, dtsCadTin);
end;

procedure TFormulaAutomotivaPpg.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('PPG_ACRMOB').AsFloat;
end;

procedure TFormulaAutomotivaPpg.PreencheQuantidadeFormulacaoVenda(const dtsCadTin: IDataSet);
Var
  intContador: Integer;
  Base: TBaseAutomotiva;
begin
  For intContador := 1 To Self.GetQuantidadeFormulacao Do
  Begin
    If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('PPG_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
      Break;

    Base                       := TBaseAutomotiva(Self.Add);
    Base.CodigoBase            := trim(dtsCadTin.FieldByName('PPG_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString);
    Base.QuantidadeConcentrado := dtsCadTin.FieldByName('PPG_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
    Base.TipoBase              := 'B';
    Base.System                := dtsCadTin.FieldByName('PPG_SISTEM').AsString;
  End;
end;

procedure TFormulaAutomotivaPpg.PreencheVolumeVenda(const dtsCadTin: IDataSet);
begin
  Self.VolumeOri         := 1;
  Self.VolumeConcentrado := 1;
  Self.VolumeDiluido     := 1;
end;

procedure TFormulaAutomotivaPpg.pCalcularDiluente(const strCodDil: string; const fltPorDil: Double; const dtsCadTin: IDataSet);
Var
  qryGen     :  IDataSet;
  intCont    : Integer;
  Dicionario : IDicionario;
  diluente   : TBaseAutomotiva;
  base       : TBaseAutomotiva;
  fltTaxa    : Double;

  fltTotalVolumeDiluido : Double;
  fltTotalVolumeAtual   : Double;
begin
  qryGen := nil;
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := ' SELECT DISTINCT                    ' +
                    '   *                                ' +
                    ' FROM                               ' +
                    '   PPG_CADBAS B                     ' +
                    '   INNER JOIN PPG_CADDIL D          ' +
                    '     ON B.BAS_CODBAS = D.DIL_CODDIL ' +
                    ' WHERE BAS_TIPO__ = :TIPO           ' +
                    '   AND DIL_SISTEM = :SISTEM         ';

      qryGen.ParamByName('TIPO').AsString   := dtsCadTin.FieldByName('PPG_TIPO__').AsString;
      qryGen.ParamByName('SISTEM').AsString := dtsCadTin.FieldByName('PPG_SISTEM').AsString;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      fltTotalVolumeAtual := 0;

      If self.Count <= 0 Then
        Exit;


      for intCont := self.Count - 1 downto 0 do
      begin
        base := (Self.Items[intCont] as TBaseAutomotiva);

        if base.TipoBase <> 'B' then
          Self.Delete(intCont)
        else
          fltTotalVolumeAtual := fltTotalVolumeAtual + (base.QuantidadeConcentrado / base.PesoEspecifico);

      end;

      fltTotalVolumeDiluido := fltTotalVolumeAtual + (fltPorDil * fltTotalVolumeAtual / 100);
      fltTaxa := fltTotalVolumeAtual / fltTotalVolumeDiluido;

      diluente := (Self.Add as TBaseAutomotiva);
      diluente.CodigoBase        := strCodDil;
      diluente.TipoBase          := 'D';
      diluente.PesoEspecifico    := qryGen.FieldByName('BAS_PESESP').AsFloat;
      diluente.QuantidadeDiluido := (fltPorDil * fltTotalVolumeAtual / 100) * diluente.PesoEspecifico;


      for intCont := Self.Count - 1 downto 0 do
      begin
        base := (Self.Items[intCont] as TBaseAutomotiva);

        if base.TipoBase <> 'D' then
        begin
          base.QuantidadeDiluido := fArredondaPPG(base.QuantidadeConcentrado  * fltTaxa);
        end
        else
        begin
          base.QuantidadeDiluido := fArredondaPPG(base.QuantidadeDiluido * fltTaxa);
        end;
      end;

      Dicionario := TAutcomTintaFactory.Get.GetDicionario;

      Self.CarregarBases(Dicionario);
      Self.CarregarBasesPorEmpresa(Dicionario);

      Self.CarregaPrecosBases;
      Self.CarregaPrecosBasesPorEmpresa;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;


end;

end.
