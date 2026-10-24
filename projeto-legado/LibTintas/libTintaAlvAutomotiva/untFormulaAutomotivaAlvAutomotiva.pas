{************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula AlvAutomotiva *}
{*********************************************************************AC*}
unit untFormulaAutomotivaAlvAutomotiva;

interface

uses
{$IFNDEF LINUX}
  Controls,
  ComCtrls,
{$ENDIF}
  untAbstractFormulaAutomotiva, untICalculadorFormulaAutomotiva, untIDataSet, untBaseAutomotiva,
  SysUtils, untStrUtils, Classes, untIConfTinta, untFloatUtils, untModoVenda, untIDicionario, untVariantUtils, Math,
  System.StrUtils;

type
  TMinMax = record
    fltMin : Double;
    fltMax : Double;
  end;

type
  TFormulaAutomotivaAlvAutomotiva = class(TAbstractFormulaAutomotiva)
  Private
    arrMinMax: Array Of TMinMax;
    arrMinMaxPer: Array Of TMinMax;
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
    function GetVolumePadraoLata(dtsCadTin: IDataSet): Double; Override;

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
    function GetLinha(const dtsCadTin: IDataSet): string; override;

    procedure pPreencherPesCorFor(const dtsCadTin: IDataSet); override;
    function GetUniversal(const dtsCadTin: IDataSet): string; override;

    procedure CarregarBases(const dicRetorno: IDicionario); Override;
    procedure CarregaPrecosBases; Override;


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
    function GetVolumeMaximoLata(dtsCadTin: IDataSet): Double; Override;
    function fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer; dtsCadTin: IDataSet): Double; Override;
    function fExisteConfiguracao(dtsCadTin: IDataSet; strEmbalagem: String): Boolean; Override;
    function fGetDiluentes(const dtsCadTin: IDataSet): TStringList; Override;
    procedure pReformulaNovo(strCodDil:String; strPercentual:String = '10'; const dtsCadTin: IDataSet = Nil); override;
    function fRetQtdDiluente(fltVolumePro: Double; strCodDil: String; strPercentual:String = '50'): Double; Reintroduce;
    procedure IniciaArrMinMax(const AQryTinta: IDataSet);
    procedure pAtualizaPorcentagem(const formula: TAbstractFormulaAutomotiva;  dtsCadTin: IDataSet = Nil); Override;
    procedure pCalculaBaseAdicional(strPercentual: String = '20'; const dtsCadTin: IDataSet = Nil; strBaseAdicional: String = ''); Override;
    function fRetornaCatalisadorVenda(blnComCat: Boolean; strTipPre, strListaAdicional: String): String; override;
    function fUtilizaBlinder(): Boolean; Override;
    procedure pAtuPorcentagemBlinder(const Formula: TAbstractFormulaAutomotiva; dtsCadTin: IDataSet = Nil); Override;
    function fGetCatalizador(const dtsCadTin: IDataSet): TStringList; Override;
    function fCaptionCheckBinder(): String; Override;
    function fLeftPercentualBinder(): Integer; Override;
    function fLeftListaBinder(): Integer; Override;
    function fVisibleBinder(const dtsCadTin: IDataSet): Boolean; Override;
    function GetUsaChapinha(const dtsCadTin: IDataSet): Boolean; Override;
    function GetProdutoChapinha(): String; Override;
  end;

implementation

uses
  untAbstractCalculadorFormulaAutomotiva, untAutcomTintaFactory;

{ TFormulaAutomotivaAlvAutomotiva }

procedure TFormulaAutomotivaAlvAutomotiva.CarregaPrecosBases;
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

procedure TFormulaAutomotivaAlvAutomotiva.CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva);
begin
  base.Cnv_Ml := Base.Embalagem * Base.PesoEspecifico;
end;

procedure TFormulaAutomotivaAlvAutomotiva.CarregarBases(const dicRetorno: IDicionario);
Var
  strSQL: String;
begin
  GetDataSetBases.Close;

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


function TFormulaAutomotivaAlvAutomotiva.fCalculaQuantidadeParaBaixaEstoque(Base: TBaseAutomotiva): Double;
begin
  Result := TAutcomTintaFactory.Get.IIF(mveModoVenda = mvConcentrado, Base.QuantidadeConcentrado, Base.QuantidadeDiluido) * (Self.fltVolumePro / Self.fltVolumeOri);
end;

function TFormulaAutomotivaAlvAutomotiva.fCaptionCheckBinder: String;
begin
  Result := 'Incluir Catalisador';
end;

function TFormulaAutomotivaAlvAutomotiva.fExisteConfiguracao(dtsCadTin: IDataSet;
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
    qryConf.SQL := qryConf.SQL + '    CFG_IDEPRO = "ALA" AND          ';
    qryConf.SQL := qryConf.SQL + '    CFG_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" AND        ';

    If strEmbalagem = 'Litro' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "LITVOL"         '
    Else If strEmbalagem = 'Galão' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "GALVOL"         '
    Else If strEmbalagem = 'Lata' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "LATVOL"         ';

    qryConf.Open;

    Result := (Not qryConf.IsEmpty);
  Except
    Raise;
  End;
end;

function TFormulaAutomotivaAlvAutomotiva.fGetCatalizador(
  const dtsCadTin: IDataSet): TStringList;
Var
  LQryGen : IDataSet;
  LBases: String;
  LSql: String;
  intContador: Integer;
begin
  Self.ListaCatalizador.Clear;

  LBases := '(';

  For intContador := 1 To GetQuantidadeFormulacao Do
  Begin
    If TStrUtils.fEmptyStr(dtsCadTin.FieldByName('ALA_CODB' + TStrUtils.fStrZero(IntContador, 2)).AsString) Then
      Break;

    LBases := LBases + QuotedStr(dtsCadTin.FieldByName('ALA_CODB' + TStrUtils.fStrZero(IntContador, 2)).AsString) + ',';
  End;

  If LBases.EndsWith(',') Then
    LBases := LBases.Substring(0, LBases.Length - 1);

  LBases := LBases + ')';

  LSql := '';
  LSql := LSql + ' SELECT DISTINCT                      ';
  LSql := LSql + '   *                                  ';
  LSql := LSql + ' FROM                                 ';
  LSql := LSql + '   ALA_CADBAS                         ';
  LSql := LSql + ' INNER JOIN ALA_CADDIL ON             ';
  LSql := LSql + '   DIL_PRODUT = BAS_CODBAS            ';
  LSql := LSql + ' INNER JOIN CADITE I ON               ';
  LSql := LSql + '   I.ITE_CODITE = BAS_CODITE          ';
  LSql := LSql + '  INNER JOIN ITEGER G ON              ';
  LSql := LSql + '    I.ITE_CODITE = G.ITE_CODITE AND   ';
  LSql := LSql + '    G.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '"  ';
  LSql := LSql + ' WHERE BAS_CODBAS IN ' + LBases + '   ';
  LSql := LSql + ' AND DIL_TIPO__ = "CATALISADOR"          ';


  LQryGen := TAutcomTintaFactory.Get.fGetDataSet;
  LQryGen.Close;
  LQryGen.SQL := LSql;
  LQryGen.Open;

  If LQryGen.IsEmpty Then
    Exit(Nil);

  Result := TStringList.Create;

  While Not LQryGen.Eof Do
  Begin
    Result.Add(LQryGen.FieldByName('DIL_CODDIL').AsString);
    LQryGen.Next;
  End;

  If Result.Count > 0 Then
  Begin
    Self.blnDadosCatalizador := True;
    Self.strCaptionCatalizador := 'Catalisador';
  End;
end;

function TFormulaAutomotivaAlvAutomotiva.fGetDiluentes(
  const dtsCadTin: IDataSet): TStringList;
Var
  LQryGen : IDataSet;
  LBases: String;
  LSql: String;
  IntContador: Integer;
begin
  Self.ListaAdicional.Clear;

  LBases := '(';

  For intContador := 1 To GetQuantidadeFormulacao Do
  Begin
    If TStrUtils.fEmptyStr(dtsCadTin.FieldByName('ALA_CODB' + TStrUtils.fStrZero(IntContador, 2)).AsString) Then
      Break;

    LBases := LBases + QuotedStr(dtsCadTin.FieldByName('ALA_CODB' + TStrUtils.fStrZero(IntContador, 2)).AsString) + ',';
  End;

  If LBases.EndsWith(',') Then
    LBases := LBases.Substring(0, LBases.Length - 1);

  LBases := LBases + ')';

  LSql := '';
  LSql := LSql + ' SELECT DISTINCT                      ';
  LSql := LSql + '   *                                  ';
  LSql := LSql + ' FROM                                 ';
  LSql := LSql + '   ALA_CADBAS                         ';
  LSql := LSql + ' INNER JOIN ALA_CADDIL ON             ';
  LSql := LSql + '   DIL_PRODUT = BAS_CODBAS            ';
  LSql := LSql + ' INNER JOIN CADITE I ON               ';
  LSql := LSql + '   I.ITE_CODITE = BAS_CODITE          ';
  LSql := LSql + '  INNER JOIN ITEGER G ON              ';
  LSql := LSql + '    I.ITE_CODITE = G.ITE_CODITE AND   ';
  LSql := LSql + '    G.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '"  ';
  LSql := LSql + ' WHERE BAS_CODBAS IN ' + LBases + '   ';
  LSql := LSql + ' AND DIL_TIPO__ = "DILUENTE"          ';


  LQryGen := TAutcomTintaFactory.Get.fGetDataSet;
  LQryGen.Close;
  LQryGen.SQL := LSql;
  LQryGen.Open;

  If LQryGen.IsEmpty Then
    Exit(Nil);

  Result := TStringList.Create;

  While Not LQryGen.Eof Do
  Begin
    Result.Add(LQryGen.FieldByName('DIL_CODDIL').AsString);
    LQryGen.Next;
  End;

  If Result.Count > 0 Then
  Begin
    Self.blnDadosAdicionais := True;
    Self.strCaptionAdicional := 'Diluentes';
    Self.blnAdicionalDiluido := True;
  End;
end;

function TFormulaAutomotivaAlvAutomotiva.fLeftListaBinder: Integer;
begin
  Result := 135;
end;

function TFormulaAutomotivaAlvAutomotiva.fLeftPercentualBinder: Integer;
begin
  Result := 300;
end;

function TFormulaAutomotivaAlvAutomotiva.fMostrarComCatalisador: Boolean;
begin
  Result := False;
end;


function TFormulaAutomotivaAlvAutomotiva.fRetornaCatalisadorVenda(blnComCat: Boolean;
  strTipPre, strListaAdicional: String): String;
begin
  Result := TAutcomTintaFactory.Get.IIF(blnComCat, strListaAdicional + ';' + FloatToStr(Self.PorPer), '0');
end;

function TFormulaAutomotivaAlvAutomotiva.fRetQtdDiluente(fltVolumePro: Double;
  strCodDil, strPercentual: String): Double;
begin
  Result := ((fltVolumePro * 1000) * StrToFloat(strPercentual)) / 100
end;

function TFormulaAutomotivaAlvAutomotiva.fUtilizaBlinder: Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaAlvAutomotiva.fValidaVolumeFormulucao(strTipoPre: String;
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaAlvAutomotiva.fVisibleBinder(const dtsCadTin: IDataSet): Boolean;
Var
  LQryGen : IDataSet;
  LBases: String;
  LSql: String;
  intContador: Integer;
begin
  LBases := '(';

  For intContador := 1 To GetQuantidadeFormulacao Do
  Begin
    If TStrUtils.fEmptyStr(dtsCadTin.FieldByName('ALA_CODB' + TStrUtils.fStrZero(IntContador, 2)).AsString) Then
      Break;

    LBases := LBases + QuotedStr(dtsCadTin.FieldByName('ALA_CODB' + TStrUtils.fStrZero(IntContador, 2)).AsString) + ',';
  End;

  If LBases.EndsWith(',') Then
    LBases := LBases.Substring(0, LBases.Length - 1);

  LBases := LBases + ')';

  LSql := '';
  LSql := LSql + ' SELECT DISTINCT                      ';
  LSql := LSql + '   *                                  ';
  LSql := LSql + ' FROM                                 ';
  LSql := LSql + '   ALA_CADBAS                         ';
  LSql := LSql + ' INNER JOIN ALA_CADDIL ON             ';
  LSql := LSql + '   DIL_PRODUT = BAS_CODBAS            ';
  LSql := LSql + ' INNER JOIN CADITE I ON               ';
  LSql := LSql + '   I.ITE_CODITE = BAS_CODITE          ';
  LSql := LSql + '  INNER JOIN ITEGER G ON              ';
  LSql := LSql + '    I.ITE_CODITE = G.ITE_CODITE AND   ';
  LSql := LSql + '    G.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '"  ';
  LSql := LSql + ' WHERE BAS_CODBAS IN ' + LBases + '   ';
  LSql := LSql + ' AND DIL_TIPO__ = "CATALISADOR"          ';


  LQryGen := TAutcomTintaFactory.Get.fGetDataSet;
  LQryGen.Close;
  LQryGen.SQL := LSql;
  LQryGen.Open;

  Result := (Not LQryGen.IsEmpty);
end;

function TFormulaAutomotivaAlvAutomotiva.fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer;
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 1.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('ALA').fGetDouble('LITVOL'), 3);
end;

function TFormulaAutomotivaAlvAutomotiva.GetAcrescimoDespesaOperacionalTinta: Double;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('ALA').fGetDouble('DESOPE');
end;

function TFormulaAutomotivaAlvAutomotiva.GetAno(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('ALA_ANOCOR').AsString;
end;

function TFormulaAutomotivaAlvAutomotiva.GetCalcDespesasOperacionais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);
  fltVenBas := (fltQtdFor * (Base.PrecoVenda / Base.Embalagem / Base.PesoEspecifico));

  Result := (fltVenBas * base.DespesasOperacionais / 100);
end;

function TFormulaAutomotivaAlvAutomotiva.GetCalcIcmsSaida(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);
  fltVenBas := (fltQtdFor * (Base.PrecoVenda / Base.Embalagem / Base.PesoEspecifico));

  Result := (fltVenBas * base.IcmsSaida / 100);
end;

function TFormulaAutomotivaAlvAutomotiva.GetCalcImpostosFederais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
Var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);
  fltVenBas := (fltQtdFor * (Base.PrecoVenda / Base.Embalagem / Base.PesoEspecifico));

  Result := (fltVenBas * base.ImpostosFederais / 100);
end;

function TFormulaAutomotivaAlvAutomotiva.GetCalcOutrosValores(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
Var
  fltQtdFor:Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  Result := (fltQtdFor * base.OutrosValores / base.Embalagem / Base.PesoEspecifico);
end;

function TFormulaAutomotivaAlvAutomotiva.GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * (formula.VolumePro / formula.VolumeOri),3);

  Result := (fltQtdFor * base.PrecoCompraLiquido / base.Embalagem / base.PesoEspecifico);
end;

function TFormulaAutomotivaAlvAutomotiva.GetCalcPrecoCusto(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  Result := (fltQtdFor * (Base.PrecoCusto / Base.Embalagem / Base.PesoEspecifico));
end;

function TFormulaAutomotivaAlvAutomotiva.GetCalcPrecoCustoReal(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  Result := (fltQtdFor * (Base.PrecoCustoReal / Base.Embalagem / Base.PesoEspecifico));
end;

function TFormulaAutomotivaAlvAutomotiva.GetCalcPrecoMedio(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
Var
  fltQtdFor:Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  Result := (fltQtdFor * base.PrecoMedio / base.Embalagem / base.PesoEspecifico);
end;

function TFormulaAutomotivaAlvAutomotiva.GetCalcPrecoVenda(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor:Double;
Begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  Result := (fltQtdFor * (Base.PrecoVenda / Base.Embalagem / Base.PesoEspecifico));
end;

function TFormulaAutomotivaAlvAutomotiva.GetCalcQuantidade(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido)
             * formula.VolumePro / formula.VolumeOri,3);
end;

function TFormulaAutomotivaAlvAutomotiva.GetCalculadorInterno: ICalculadorFormulaAutomotiva;
begin
  Result := TAbstractCalculadorFormulaAutomotiva.Create(Self);
end;

function TFormulaAutomotivaAlvAutomotiva.GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  Result := (fltQtdFor * base.UltimoPrecoCompra / base.Embalagem / base.PesoEspecifico);
end;

function TFormulaAutomotivaAlvAutomotiva.GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  Result := (fltQtdFor * base.UltimoPrecoCompraImpostos / Base.Embalagem / base.PesoEspecifico);
end;

function TFormulaAutomotivaAlvAutomotiva.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('ALA_MD5KEY').AsString;
end;

function TFormulaAutomotivaAlvAutomotiva.GetCodFormul(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaAlvAutomotiva.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('ALA_DESCRI').AsString;
end;

function TFormulaAutomotivaAlvAutomotiva.GetDescricaoBase(strCodBas: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DESCRI '+
                    '  FROM ALA_CADBAS '+
                    ' WHERE BAS_CODBAS = :CODBAS  ';
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

function TFormulaAutomotivaAlvAutomotiva.GetFatorEstoque: Double;
begin
  Result := 0.9;
end;

function TFormulaAutomotivaAlvAutomotiva.GetIdePro: String;
begin
  Result := 'ALA';
end;

function TFormulaAutomotivaAlvAutomotiva.GetIndEmb(
  const dtsCadTin: IDataSet): integer;
begin
  Result := -1;
end;

function TFormulaAutomotivaAlvAutomotiva.GetLinha(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaAlvAutomotiva.GetMontadora(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaAlvAutomotiva.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaAutomotivaAlvAutomotiva.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaAutomotivaAlvAutomotiva.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaAutomotivaAlvAutomotiva.GetNomeTabelaBases: String;
begin
  Result := 'ALA_CADBAS';
end;

Procedure TFormulaAutomotivaAlvAutomotiva.pPreencherPesCorFor(const dtsCadTin: IDataSet);
begin
  Self.PesoCor := 0;
  Self.PesoFor := 0;
end;

{$IFNDEF LINUX}
procedure TFormulaAutomotivaAlvAutomotiva.pRecalculaFormulaMostrarDigitado(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; fltFator: Double;
  blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha, strTipBas: String);
var
  intDec: Integer;
begin
  intDec := StrToIntDef(TAutcomTintaFactory.Get.fGetConfTinta('ALA').fGet('DECFOR'), 1);

  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    SubItems.Add(FloatToStrF(RoundTo(Base.QuantidadeConcentrado * fltFator, - intDec), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(RoundTo(Base.QuantidadeDiluido * fltFator, - intDec), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(RoundTo(Base.QuantidadeDiluido2 * fltFator, - intDec), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;

procedure TFormulaAutomotivaAlvAutomotiva.pRecalculaFormulaMostrarPadrao(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; blnConsLinhaDesBas: Boolean;
  strTipBas: String; intCont: Integer);
var
  intDec: Integer;
begin
  intDec := StrToIntDef(TAutcomTintaFactory.Get.fGetConfTinta('ALA').fGet('DECFOR'), 1);

  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    SubItems.Add(FloatToStrF(RoundTo(Base.QuantidadeConcentrado, - intDec), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(RoundTo(Base.QuantidadeDiluido, - intDec), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(RoundTo(Base.QuantidadeDiluido2, - intDec), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}


function TFormulaAutomotivaAlvAutomotiva.GetPrefixoFormulacao: String;
begin
  Result := 'ALA_CODB';
end;

function TFormulaAutomotivaAlvAutomotiva.GetPrefixoLitragem(
  const strModo: String): String;
begin
  Result := '';
end;

function TFormulaAutomotivaAlvAutomotiva.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'ALA_QTDB'
end;

function TFormulaAutomotivaAlvAutomotiva.GetProdutoChapinha: String;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('ALA').fGet('PROCHA');
end;

function TFormulaAutomotivaAlvAutomotiva.GetProdutoVendaTinta(const dtsCadTin: IDataSet): string;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('ALA').fGet('ALAPRO');
end;

function TFormulaAutomotivaAlvAutomotiva.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaAutomotivaAlvAutomotiva.GetSelectBases: String;
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

function TFormulaAutomotivaAlvAutomotiva.GetTextoInformativoCalculo: String;
Var
  fltVolumePadrao: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Litro') Then
    fltVolumePadrao := 1.000
  Else
    fltVolumePadrao := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('ALA').fGetDouble('LITVOL'), 3);

  Result :=
    'VolumeFormula  = ' + FloatToStrF(fltVolumePadrao, ffFixed, 12, 4) + sLineBreak +
    'Valor da Base  = Quantidade * (Preço / (Embalagem * Peso específico))' + sLineBreak +
    'Preço da Tinta = Soma do Valor da Base de todas as bases';
end;

function TFormulaAutomotivaAlvAutomotiva.GetUniversal(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaAlvAutomotiva.GetUsaChapinha(
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := (dtsCadTin.FieldByName('ALA_PROCHA').AsString = 'S');
end;

function TFormulaAutomotivaAlvAutomotiva.GetVolumeMaximoGalao(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 4.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('ALA').fGetDouble('GALVOL'), 3);
end;


function TFormulaAutomotivaAlvAutomotiva.GetVolumeMaximoLata(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('ALA').fGetDouble('LATVOL'), 3);
end;

function TFormulaAutomotivaAlvAutomotiva.GetVolumeMaximoLitro(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 1.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('ALA').fGetDouble('LITVOL'), 3);
end;

function TFormulaAutomotivaAlvAutomotiva.GetVolumePadraCopo: Double;
begin
  Result := 0;
end;

function TFormulaAutomotivaAlvAutomotiva.GetVolumePadraGalao(dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 3.500;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('ALA').fGetDouble('GALVOL'), 3);
end;

function TFormulaAutomotivaAlvAutomotiva.GetVolumePadraLitro: Double;
begin
  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('ALA').fGetDouble('LITVOL'), 3);
end;


function TFormulaAutomotivaAlvAutomotiva.GetVolumePadraoLata(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 16.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('ALA').fGetDouble('LATVOL'), 3);
end;

function TFormulaAutomotivaAlvAutomotiva.GetVolumePadraSpray: Double;
begin
  Result := 0;
end;


function TFormulaAutomotivaAlvAutomotiva.GetVolumePadraTambor(dtsCadTin: IDataSet): Double;
begin
  Result := 0;
end;

function TFormulaAutomotivaAlvAutomotiva.GetVolumePermitido(
  const dtsCadTin: IDataSet; strTipoPre: String): Double;
begin
  Result := 0;
end;

procedure TFormulaAutomotivaAlvAutomotiva.IniciaArrMinMax(const AQryTinta: IDataSet);
Var
  IntContador: Integer;
  LQryGen : IDataSet;
  LBases: String;
  LSql: String;
begin
  SetLength(arrMinMax, Self.ListaAdicional.Count);

  If Self.ListaAdicional.Count <= 0 Then
    Exit;

  LBases := '(';

  For intContador := 1 To GetQuantidadeFormulacao Do
  Begin
    If TStrUtils.fEmptyStr(AQryTinta.FieldByName('ALA_CODB' + TStrUtils.fStrZero(IntContador, 2)).AsString) Then
      Break;

    LBases := LBases + QuotedStr(AQryTinta.FieldByName('ALA_CODB' + TStrUtils.fStrZero(IntContador, 2)).AsString) + ',';
  End;

  If LBases.EndsWith(',') Then
    LBases := LBases.Substring(0, LBases.Length - 1);

  LBases := LBases + ')';

  LSql := '';
  LSql := LSql + ' SELECT DISTINCT                      ';
  LSql := LSql + '   *                                  ';
  LSql := LSql + ' FROM                                 ';
  LSql := LSql + '   ALA_CADBAS                         ';
  LSql := LSql + ' INNER JOIN ALA_CADDIL ON             ';
  LSql := LSql + '   DIL_PRODUT = BAS_CODBAS            ';
  LSql := LSql + ' INNER JOIN CADITE ON                 ';
  LSql := LSql + '   ITE_CODITE = BAS_CODITE            ';
  LSql := LSql + ' WHERE BAS_CODBAS IN ' + LBases + '   ';
  LSql := LSql + ' AND DIL_TIPO__ = "DILUENTE"          ';


  LQryGen := TAutcomTintaFactory.Get.fGetDataSet;
  LQryGen.SQL := LSql;
  LQryGen.Open;
  LQryGen.First;

  If Not LQryGen.IsEmpty Then
    Self.PorDil := StrToFloat(AnsiReplaceStr(LQryGen.FieldByName('DIL_PERCEN').AsString, '.', ','));

  While Not LQryGen.Eof Do
  Begin
    arrMinMax[LQryGen.RecNo - 1].fltMin := 0;
    arrMinMax[LQryGen.RecNo - 1].fltMax := 100;
    LQryGen.Next;
  End;

  SetLength(arrMinMaxPer, Self.ListaCatalizador.Count);

  If Self.ListaCatalizador.Count <= 0 Then
    Exit;

  LSql := '';
  LSql := LSql + ' SELECT DISTINCT                      ';
  LSql := LSql + '   *                                  ';
  LSql := LSql + ' FROM                                 ';
  LSql := LSql + '   ALA_CADBAS                         ';
  LSql := LSql + ' INNER JOIN ALA_CADDIL ON             ';
  LSql := LSql + '   DIL_PRODUT = BAS_CODBAS            ';
  LSql := LSql + ' INNER JOIN CADITE ON                 ';
  LSql := LSql + '   ITE_CODITE = BAS_CODITE            ';
  LSql := LSql + ' WHERE BAS_CODBAS IN ' + LBases + '   ';
  LSql := LSql + ' AND DIL_TIPO__ = "CATALISADOR"       ';

  LQryGen.Close;
  LQryGen.SQL := LSql;
  LQryGen.Open;
  LQryGen.First;


  If Not LQryGen.IsEmpty Then
    Self.PorPer := StrToFloat(AnsiReplaceStr(LQryGen.FieldByName('DIL_PERCEN').AsString, '.', ','));

  While Not LQryGen.Eof Do
  Begin
    arrMinMaxPer[LQryGen.RecNo - 1].fltMin := 0;
    arrMinMaxPer[LQryGen.RecNo - 1].fltMax := 100;
    LQryGen.Next;
  End;
end;

procedure TFormulaAutomotivaAlvAutomotiva.pAtualizaPorcentagem(
  const formula: TAbstractFormulaAutomotiva; dtsCadTin: IDataSet);
begin
  If (formula.ListaAdicional.Count <= 0) Then
    Exit;

  If formula.PorDil > arrMinMax[formula.IndiceAdicional].fltMax Then
    formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltMax;

  Formula.CodDil := ListaAdicional.Text;

  If Length(arrMinMax) > 0 Then
  Begin
    formula.HabDil := true;

    If formula.PorDil > arrMinMax[Formula.IndiceAdicional].fltMax Then
      formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltMax;

    If formula.PorDil = 0 Then
      formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltMin;
  End;
end;

procedure TFormulaAutomotivaAlvAutomotiva.pAtuPorcentagemBlinder(
  const Formula: TAbstractFormulaAutomotiva; dtsCadTin: IDataSet);
begin
  If (formula.ListaCatalizador.Count <= 0) Then
    Exit;

  If Formula.IndiceCatalizador = -1 Then
  Begin
    If Formula.PorPer > arrMinMaxPer[0].fltMax Then
      Formula.PorPer := arrMinMaxPer[0].fltMax;

    If Formula.PorPer < arrMinMaxPer[0].fltMin Then
      Formula.PorPer := arrMinMaxPer[0].fltMin;
  End
  Else
  Begin
    If Formula.PorPer > arrMinMaxPer[Formula.IndiceCatalizador].fltMax Then
      Formula.PorPer := arrMinMaxPer[Formula.IndiceCatalizador].fltMax;

    If Formula.PorPer < arrMinMaxPer[Formula.IndiceCatalizador].fltMin Then
      Formula.PorPer := arrMinMaxPer[Formula.IndiceCatalizador].fltMin;
  End;
end;

procedure TFormulaAutomotivaAlvAutomotiva.pCalculaBaseAdicional(strPercentual: String = '20'; const dtsCadTin: IDataSet = Nil; strBaseAdicional: String = '');
Var
  intContador: Integer;
  qryGen: IDataSet;
  strSQL: String;
  Agent: TBaseAutomotiva;
  Bases: TBaseAutomotiva;
  fltDesOpeTinta: Double;
  dicDados: IDicionario;
  fltVolumeTotal: Double;
  fltVolumeTotalDil: Double;
  fltPreCus, fltPreVen: Double;
  blnEmPromo: Boolean;
  blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
  intDec: Integer;
begin
  fltVolumeTotalDil := 0;

  If (Self.PerfomanceAgent) And (strPercentual <> '0') Then
  Begin
    strSQL := '';
    strSQL := strSQL + '  SELECT              ';
    strSQL := strSQL + '    *                 ';
    strSQL := strSQL + '  FROM                ';
    strSQL := strSQL + '    ALA_CADBAS B      ';
    strSQL := strSQL + '  INNER JOIN ITEGER G ON        ';
    strSQL := strSQL + '    G.ITE_CODITE = B.BAS_CODITE AND       ';
    strSQL := strSQL + '    G.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '"    ';
    strSQL := strSQL + '  INNER JOIN CADITE I ON         ';
    strSQL := strSQL + '    I.ITE_CODITE = G.ITE_CODITE           ';
    strSQL := strSQL + '  WHERE               ';
    strSQL := strSQL + '    B.BAS_CODBAS = "' + strBaseAdicional + '";              ';

    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.Close;
    qryGen.SQL := strSQL;
    qryGen.Open;

    If qryGen.IsEmpty Then
      Exit;

    fltVolumeTotal := 0;

    For intContador :=  Self.Count - 1 DownTo 0 Do
    Begin
      Bases := (Self.Items[intContador] As TBaseAutomotiva);

      If Bases.TipoBase = 'CA' Then
        Self.Delete(intContador)
      Else
      Begin
        If Bases.TipoBase <> 'D' Then
          fltVolumeTotal := fltVolumeTotal + (Bases.QuantidadeConcentrado / Bases.PesoEspecifico);

        fltVolumeTotalDil := fltVolumeTotalDil + (Bases.QuantidadeDiluido / Bases.PesoEspecifico);
      End;
    End;

    fltDesOpeTinta := TAutcomTintaFactory.Get.fGetConfTinta('ROB').fGetDouble('DESOPE');
    intDec := StrToIntDef(TAutcomTintaFactory.Get.fGetConfTinta('ALA').fGet('DECFOR'), 1);



    Agent := (Self.Add As TBaseAutomotiva);
    Agent.CodigoBase := strBaseAdicional;
    Agent.TipoBase := 'CA';
    Agent.PesoEspecifico := qryGen.FieldByName('BAS_PESESP').AsFloat;
    Agent.PrecoVenda := qryGen.FieldByName('ITE_PREVE' + Self.StrTabPre).AsFloat;
    Agent.PrecoCusto := qryGen.FieldByName('ITE_PRECUS').AsFloat;
    Agent.IcmsSaida := qryGen.FieldByName('ITE_ICMSAI').AsFloat;
    Agent.ImpostosFederais := qryGen.FieldByName('ITE_IMPFED').AsFloat;
    Agent.DespesasOperacionais := qryGen.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;
    Agent.UltimoPrecoCompra := qryGen.FieldByName('ITE_PREULT').AsFloat;
    Agent.UltimoPrecoCompraImpostos := qryGen.FieldByName('ITE_IMPULT').AsFloat;
    Agent.Embalagem := qryGen.FieldByName('BAS_EMBALA').AsFloat;
    Agent.PrecoMedio := qryGen.FieldByName('ITE_PREMED').AsFloat;
    Agent.OutrosValores := qryGen.FieldByName('ITE_OUTVAL').AsFloat;
    Agent.CodIte := qryGen.FieldByName('BAS_CODITE').AsString;
    Agent.ImpDir := qryGen.FieldByName('ITE_IMPDIR').AsString;
    Agent.Cnv_Ml := Agent.Embalagem * Agent.PesoEspecifico;
    Agent.PesGra := 'N';

    blnEmPromo := TAutcomTintaFactory.Get.fCarregaPromocao(Agent.CodIte, strTabPre, Self.strCodCli, Self.strCodCnd, Self.intPrzMed, fltPreCus, fltPreVen, blnPrecoFixoParaTintaDeMaquinaImobiliaria);

    If (blnEmPromo) And (Not Self.blnProPre) Then
    Begin
      Agent.PrecoCusto := fltPreCus;
      Agent.PrecoVenda := fltPreVen;

      If strTabPre = strTabPreTin Then
        Self.Promoc := 'S';

      If Agent.PrecoCusto = 0 Then
        Agent.PrecoCusto := qryGen.FieldByName('ITE_PRECUS').AsFloat;
    End
    Else
    Begin
      If (Self.blnProPre) And (blnEmPromo) And (strTabPre = strTabPreTin) Then
        Self.Promoc := 'S';
    End;

    dicDados := TAutcomTintaFactory.Get.GetDicionario;
    dicDados['preven'] := Agent.PrecoVenda;
    dicDados['precus'] := Agent.PrecoCusto;
    dicDados['outval'] := Agent.OutrosValores;
    dicDados['icmsai'] := Agent.IcmsSaida;
    dicDados['impfed'] := Agent.ImpostosFederais;
    dicDados['desope'] := Agent.DespesasOperacionais;
    Agent.PrecoCustoReal := TAutcomTintaFactory.Get.fCalculaPrecoCusto2(dicDados);

    Agent.QuantidadeConcentrado := fRetQtdDiluente(0.9, strBaseAdicional, strPercentual);
    Agent.QuantidadeDiluido     := fRetQtdDiluente(0.9, Self.CodDil, strPercentual);
    Agent.QuantidadeConcentrado := Agent.QuantidadeConcentrado * Agent.PesoEspecifico;
    Agent.QuantidadeConcentrado := (Agent.QuantidadeConcentrado * 1 * 1000) / (1 * 1000 + (strToFloat(strPercentual) * 10));
    Agent.QuantidadeDiluido  := Agent.QuantidadeDiluido  * Agent.PesoEspecifico;
    Agent.QuantidadeDiluido  := (Agent.QuantidadeDiluido  * 1 * 1000) / (1 * 1000 + StrToFloat(strPercentual) * 10);

    For intContador := Self.Count - 1 DownTo 0 Do
    Begin
      Bases := (Self.Items[intContador] As TBaseAutomotiva);

      If Bases.TipoBase <> 'CA' Then
      Begin
        Bases.QuantidadeDiluido := (Bases.QuantidadeDiluido / Bases.PesoEspecifico);
        Bases.QuantidadeDiluido := ((Bases.QuantidadeDiluido * 900) / fltVolumeTotalDil);
        Bases.QuantidadeDiluido := ((Bases.QuantidadeDiluido * 1000) / (1000 + (StrToFloat(strPercentual) * 10)));
        Bases.QuantidadeDiluido := TAutcomTintaFactory.Get.fFormataFloat((Bases.QuantidadeDiluido * Bases.PesoEspecifico), intDec);

        Bases.QuantidadeConcentrado := (Bases.QuantidadeConcentrado  / Bases.PesoEspecifico);
        Bases.QuantidadeConcentrado := ((Bases.QuantidadeConcentrado  * 900) / fltVolumeTotal);
        Bases.QuantidadeConcentrado := ((Bases.QuantidadeConcentrado  * 1000) / (1000 + (StrToFloat(strPercentual) * 10)));
        Bases.QuantidadeConcentrado := TAutcomTintaFactory.Get.fFormataFloat((Bases.QuantidadeConcentrado  * Bases.PesoEspecifico), intDec);
      End;
    End;
  End
  Else
  Begin
    For intContador := Self.Count - 1 DownTo 0 Do
    Begin
      Bases := Self.Items[intContador] As TBaseAutomotiva;

      If Bases.TipoBase = 'CA' Then
        Self.Delete(intContador);
    End;

    For intContador := 1 To Self.GetQuantidadeFormulacao Do
    Begin
      If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('ALA_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
        Break;

      Bases := (Self.Items[intContador - 1] As TBaseAutomotiva);
      Bases.QuantidadeConcentrado := dtsCadTin.FieldByName('ALA_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
    End;
  End;
end;

procedure TFormulaAutomotivaAlvAutomotiva.pDefineVolumeOriginal;
begin
  If Self.mveModoVenda = mvConcentrado then
    Self.VolumeOri := Self.VolumeConcentrado
  Else
    Self.VolumeOri := Self.VolumeDiluido;
end;

procedure TFormulaAutomotivaAlvAutomotiva.pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet);
var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('ALA');

  sProEmbTb := '';
  sProEmbBa := '';
  sProEmbSs := '';
  sProEmbPo := '';
  sProEmbSd := '';
  sProEmbCo := '';

  stlDesEmb.Clear;
  stlDesEmb.Add('');

  IniciaArrMinMax(dtsCadTin);

  stlProEmbLt.Add(Conf.fGet('LITEMB'));
  stlProEmbGl.Add(Conf.fGet('GALEMB'));
  stlProEmbLa.Add(Conf.fGet('LATEMB'));

  If ListaAdicional.Count > 0 Then
    pReformulaNovo(ListaAdicional[0], '0');
end;

procedure TFormulaAutomotivaAlvAutomotiva.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('ALA_ACRMOB').AsFloat;
end;

procedure TFormulaAutomotivaAlvAutomotiva.PreencheQuantidadeFormulacaoVenda(
  const dtsCadTin: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
begin
  For intContador := 1 To Self.GetQuantidadeFormulacao Do
  Begin

    If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('ALA_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
      Break;

    Base := TBaseAutomotiva(Self.Add);
    Base.CodigoBase := dtsCadTin.FieldByName('ALA_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString;
    Base.QuantidadeConcentrado := dtsCadTin.FieldByName('ALA_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
    Base.QuantidadeDiluido     := 0.0;
    Base.TipoBase              := 'B';
  End;
end;

procedure TFormulaAutomotivaAlvAutomotiva.PreencheVolumeVenda(const dtsCadTin: IDataSet);
begin
  Self.VolumeOri         := 0.9;
  Self.VolumeConcentrado := 0.9;
  Self.VolumeDiluido     := 0.9;
end;

procedure TFormulaAutomotivaAlvAutomotiva.pReformulaNovo(strCodDil,
  strPercentual: String; const dtsCadTin: IDataSet);
Var
  intContador: Integer;
  qryGen: IDataSet;
  strSQL: String;
  diluente: TBaseAutomotiva;
  Bases: TBaseAutomotiva;
  fltDesOpeTinta: Double;
  dicDados: IDicionario;
  fltVolumeTotal: Double;
  fltPreCus, fltPreVen: Double;
  blnEmPromo: Boolean;
  blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
  intDec: Integer;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    {*****************************}
    {**    CALCULO DILUENTE     **}
    {**************************RG*}


    strSQL := '';
    strSQL := strSQL + '  SELECT                  ';
    strSQL := strSQL + '    *                     ';
    strSQL := strSQL + '  FROM                    ';
    strSQL := strSQL + '    ALA_CADBAS B          ';
    strSQL := strSQL + '  INNER JOIN ITEGER G ON         ';
    strSQL := strSQL + '    G.ITE_CODITE = B.BAS_CODITE AND         ';
    strSQL := strSQL + '    G.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '"    ';
    strSQL := strSQL + '  INNER JOIN CADITE I ON         ';
    strSQL := strSQL + '    I.ITE_CODITE =  G.ITE_CODITE            ';
    strSQL := strSQL + '  WHERE                   ';
    strSQL := strSQL + '    BAS_CODBAS = :CODBAS        ';

    qryGen.Close;
    qryGen.SQL := strSQL;
    qryGen.ParamByName('CODBAS').AsString := strCodDil;
    qryGen.Open;

    If qryGen.IsEmpty Then
      Exit;

    fltVolumeTotal := 0;

    For intContador :=  Self.Count - 1 DownTo 0 Do
    Begin
      Bases := (Self.Items[intContador] As TBaseAutomotiva);

      If Bases.TipoBase = 'D' Then
        Self.Delete(intContador)
      Else
        fltVolumeTotal := fltVolumeTotal + (Bases.QuantidadeConcentrado / Bases.PesoEspecifico);
    End;

    fltDesOpeTinta := TAutcomTintaFactory.Get.fGetConfTinta('ALA').fGetDouble('DESOPE');
    intDec := StrToIntDef(TAutcomTintaFactory.Get.fGetConfTinta('ALA').fGet('DECFOR'), 1);

    Diluente := (Self.Add As TBaseAutomotiva);
    Diluente.CodigoBase := strCodDil;
    Diluente.TipoBase := 'D';
    Diluente.PesoEspecifico := qryGen.FieldByName('BAS_PESESP').AsFloat;
    Diluente.PrecoVenda := qryGen.FieldByName('ITE_PREVE' + Self.strTabPre).AsFloat;
    Diluente.PrecoCusto := qryGen.FieldByName('ITE_PRECUS').AsFloat;
    Diluente.IcmsSaida  := qryGen.FieldByName('ITE_ICMSAI').AsFloat;
    Diluente.ImpostosFederais := qryGen.FieldByName('ITE_IMPFED').AsFloat;
    Diluente.DespesasOperacionais := qryGen.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;
    Diluente.UltimoPrecoCompra := qryGen.FieldByName('ITE_PREULT').AsFloat;
    Diluente.UltimoPrecoCompraImpostos := qryGen.FieldByName('ITE_IMPULT').AsFloat;
    Diluente.Embalagem := qryGen.FieldByName('BAS_EMBALA').AsFloat;
    Diluente.PrecoMedio := qryGen.FieldByName('ITE_PREMED').AsFloat;
    Diluente.OutrosValores := qryGen.FieldByName('ITE_OUTVAL').AsFloat;
    Diluente.CodIte := qryGen.FieldByName('BAS_CODITE').AsString;
    Diluente.ImpDir := qryGen.FieldByName('ITE_IMPDIR').AsString;
    Diluente.Cnv_Ml := Diluente.Embalagem * Diluente.PesoEspecifico;
    Diluente.PesGra := 'N';

    blnEmPromo := TAutcomTintaFactory.Get.fCarregaPromocao(qryGen.FieldByName('BAS_CODITE').AsString,
                                                           strTabPre, Self.strCodCli, Self.strCodCnd, Self.intPrzMed,
                                                           fltPreCus, fltPreVen, blnPrecoFixoParaTintaDeMaquinaImobiliaria);

    If (blnEmPromo) And (Not Self.blnProPre) Then
    Begin
      Diluente.PrecoCusto := fltPreCus;
      Diluente.PrecoVenda := fltPreVen;

      If strTabPre = strTabPreTin Then
          Self.Promoc := 'S';

      If Diluente.PrecoCusto = 0 Then
        Diluente.PrecoCusto := qryGen.FieldByName('ITE_PRECUS').AsFloat;
    End
    Else
    Begin
      If (Self.blnProPre) And (blnEmPromo) And (strTabPre = strTabPreTin) Then
        Self.Promoc := 'S';
    End;

    Diluente.QuantidadeDiluido := fRetQtdDiluente(0.9, strCodDil, strPercentual);
    Diluente.QuantidadeDiluido := Diluente.QuantidadeDiluido * Diluente.PesoEspecifico;
    Diluente.QuantidadeDiluido := (Diluente.QuantidadeDiluido * 1 * 1000) / (1 * 1000 + (strToFloat(strPercentual) * 10));


    dicDados := TAutcomTintaFactory.Get.GetDicionario;
    dicDados['preven'] := Diluente.PrecoVenda;
    dicDados['precus'] := Diluente.PrecoCusto;
    dicDados['outval'] := Diluente.OutrosValores;
    dicDados['icmsai'] := Diluente.IcmsSaida;
    dicDados['impfed'] := Diluente.ImpostosFederais;
    dicDados['desope'] := Diluente.DespesasOperacionais;

    Diluente.PrecoCustoReal := TAutcomTintaFactory.Get.fCalculaPrecoCusto2(dicDados);

    For intContador := Self.Count -1 DownTo 0 Do
    Begin
      Bases := (Self.Items[intContador] As TBaseAutomotiva);

      If Bases.TipoBase <> 'D' Then
      Begin
        Bases.QuantidadeDiluido := (Bases.QuantidadeConcentrado / Bases.PesoEspecifico);
        Bases.QuantidadeDiluido := ((Bases.QuantidadeDiluido * 900) / fltVolumeTotal);
        Bases.QuantidadeDiluido := ((Bases.QuantidadeDiluido * 1000) / (1000 + (StrToFloat(strPercentual) * 10)));
        Bases.QuantidadeDiluido := TAutcomTintaFactory.Get.fFormataFloat((Bases.QuantidadeDiluido * Bases.PesoEspecifico), intDec);
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Raise;
    End;
  End;
end;

end.
