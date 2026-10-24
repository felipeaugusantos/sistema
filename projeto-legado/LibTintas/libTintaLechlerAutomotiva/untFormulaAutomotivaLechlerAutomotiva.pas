{************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula LechlerAutomotiva *}
{*********************************************************************AC*}
unit untFormulaAutomotivaLechlerAutomotiva;

interface

uses
{$IFNDEF LINUX}
  Controls,
  ComCtrls,
{$ENDIF}
  untAbstractFormulaAutomotiva, untICalculadorFormulaAutomotiva, untIDataSet, untBaseAutomotiva,
  SysUtils, untStrUtils, Classes, untIConfTinta, untFloatUtils, untModoVenda,
  untIDicionario, untVariantUtils;

type
  TMinMax = record
    fltMin : Double;
    fltMax : Double;
    fltPad : Double;
  end;

type
  TFormulaAutomotivaLechlerAutomotiva = class(TAbstractFormulaAutomotiva)
  Private
    arrMinMax: Array Of TMinMax;
    procedure IniciaArrMinMax();
    function fArredondaValor(fltValor: Double; intCasas: Integer): Double;
    function fRetornaTotalDensidade(strTipPrg: String; fltPorcen, fltDensid: Double): Double;
    function fRetornarDensidade(strCodBas : String) : Double;
    function fQuantidadePorConcentrado(fltQuantidade: Double; strCodBas: String): Double;
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
    function GetVolumePadraoBalde(dtsCadTin: IDataSet): Double; override;
    function GetVolumePadraoLata(dtsCadTin: IDataSet): Double; Override;

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
  {$ENDIF}

  {$IFNDEF LINUX}
    procedure pRecalculaFormulaMostrarDigitado(var lsvFormulacao: TListView;
      Base: TBaseAutomotiva; intDecimaisPrecoVenda, intDecimaisPesoEspecifico: Integer;
      fltFator: Double; blnConsLinhaDesBas: Boolean; intCont: Integer;
      strLinha: String; strTipBas: String); override;
  {$ENDIF}

    function GetVolumeMaximoLitro(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoGalao(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoLata(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoBalde(dtsCadTin: IDataSet): Double; Override;
    function fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer; dtsCadTin: IDataSet): Double; Override;
    function fExisteConfiguracao(dtsCadTin: IDataSet; strEmbalagem: String): Boolean; Override;
    function GetUsaChapinha(const dtsCadTin: IDataSet): Boolean; Override;
    function GetProdutoChapinha(): String; Override;

    function fRetQtdDiluente(fltVolumePro: Double; strCodDil: String; strPercentual:String = '60'): Double; Reintroduce;
    function fGetDiluentes(const dtsCadTin: IDataSet): TStringList; Override;
    procedure pReformulaNovo(strCodDil:String; strPercentual:String = '60'; const dtsCadTin: IDataSet = Nil); override;
    procedure pAtualizaPorcentagem(const formula: TAbstractFormulaAutomotiva; dtsCadTin: IDataSet = Nil); override;
    constructor Create(const strTabPre: String); Override;
    function fHabilitaRdgModoVenda(const dtsCadTin: IDataSet; blnDiluido, blnConcentrado: Boolean): Boolean; Override;
    function fOpcaoRdgMovoVenda(const dtsCadTin: IDataSet; blnConcentrado: Boolean): Integer; Override;
  end;

implementation

uses
  untAbstractCalculadorFormulaAutomotiva, untAutcomTintaFactory;

{ TFormulaAutomotivaLechlerAutomotiva }

procedure TFormulaAutomotivaLechlerAutomotiva.CarregaPrecosBases;
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

procedure TFormulaAutomotivaLechlerAutomotiva.CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva);
begin
  base.Cnv_Ml := Base.Embalagem * Base.PesoEspecifico;
end;

procedure TFormulaAutomotivaLechlerAutomotiva.CarregarBases(const dicRetorno: IDicionario);
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

constructor TFormulaAutomotivaLechlerAutomotiva.Create(const strTabPre: String);
begin
  inherited Create(strTabPre);
  Self.PorDil := 60;
end;

function TFormulaAutomotivaLechlerAutomotiva.fArredondaValor(fltValor: Double;
  intCasas: Integer): Double;
begin
  Result := TAutcomTintaFactory.Get.fStrToFloat(FormatFloat('0.' + TStrUtils.fStrZero(0, intCasas), fltValor));
end;

function TFormulaAutomotivaLechlerAutomotiva.fCalculaQuantidadeParaBaixaEstoque(Base: TBaseAutomotiva): Double;
begin
  Result := TAutcomTintaFactory.Get.IIF(mveModoVenda = mvConcentrado, Base.QuantidadeConcentrado, Base.QuantidadeDiluido) * (Self.fltVolumePro / Self.fltVolumeOri);
end;

function TFormulaAutomotivaLechlerAutomotiva.fExisteConfiguracao(dtsCadTin: IDataSet;
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
    qryConf.SQL := qryConf.SQL + '    CFG_IDEPRO = "LCA" AND          ';
    qryConf.SQL := qryConf.SQL + '    CFG_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" AND        ';

    If strEmbalagem = 'Litro' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "LITVOL"         '
    Else If strEmbalagem = 'Galão' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "GALVOL"         '
    Else If strEmbalagem = 'Lata' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "LATVOL"         '
    Else If strEmbalagem = 'Balde' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLBAL"         ';

    qryConf.Open;

    Result := (Not qryConf.IsEmpty);
  Except
    Raise;
  End;
end;

function TFormulaAutomotivaLechlerAutomotiva.fGetDiluentes(
  const dtsCadTin: IDataSet): TStringList;
Var
  qryGen: IDataSet;
  strSQL: String;
begin
  Self.ListaAdicional.Clear;
  Result := TStringList.Create;

  If Not TStrUtils.fEmptyStr(dtsCadTin.FieldByName('LCA_CODB20').AsString) Then
    Exit;


  Self.ListaAdicional.Clear;

  strSQL := '';
  strSQL := strSQL + '  SELECT                  ';
  strSQL := strSQL + '    *                     ';
  strSQL := strSQL + '  FROM                    ';
  strSQL := strSQL + '    LCA_CADBAS B          ';
  strSQL := strSQL + '  INNER JOIN ITEGER G ON         ';
  strSQL := strSQL + '    G.ITE_CODITE = B.BAS_CODITE AND         ';
  strSQL := strSQL + '    G.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '"    ';
  strSQL := strSQL + '  INNER JOIN CADITE I ON         ';
  strSQL := strSQL + '    I.ITE_CODITE =  G.ITE_CODITE            ';
  strSQL := strSQL + '  WHERE                   ';
  strSQL := strSQL + '    BAS_DESCRI LIKE "%THINNER%"             ';


  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := strSQL;
  qryGen.Open;

  Self.PorDil := 60;

  While Not qryGen.Eof Do
  Begin
    Result.Add(qryGen.FieldByName('BAS_CODBAS').AsString);
    qryGen.Next;
  End;

  If Result.Count > 0 Then
  Begin
    Self.pReformulaNovo(Result[0], '60', dtsCadTin);
    Self.blnDadosAdicionais := True;
    Self.strCaptionAdicional := 'Diluentes';
    Self.blnAdicionalDiluido := True;
  End;
end;

function TFormulaAutomotivaLechlerAutomotiva.fHabilitaRdgModoVenda(
  const dtsCadTin: IDataSet; blnDiluido, blnConcentrado: Boolean): Boolean;
begin
  Result := blnConcentrado And blnDiluido;

  If Not TStrUtils.fEmptyStr(dtsCadTin.FieldByName('LCA_CODB20').AsString) Then
    Result := False;
end;

function TFormulaAutomotivaLechlerAutomotiva.fMostrarComCatalisador: Boolean;
begin
  Result := False;
end;


function TFormulaAutomotivaLechlerAutomotiva.fOpcaoRdgMovoVenda(
  const dtsCadTin: IDataSet; blnConcentrado: Boolean): Integer;
begin
  Result := TAutcomTintaFactory.Get.IIF(blnConcentrado, 0, 1);

  If Not TStrUtils.fEmptyStr(dtsCadTin.FieldByName('LCA_CODB20').AsString) Then
    Result := 0;
end;

function TFormulaAutomotivaLechlerAutomotiva.fQuantidadePorConcentrado(fltQuantidade: Double;  strCodBas: String): Double;
begin
  Result := ((fltQuantidade / 100) * 10) / fRetornarDensidade(strCodBas);
end;


function TFormulaAutomotivaLechlerAutomotiva.fRetornarDensidade(
  strCodBas: String): Double;
var
  qryGen: IDataSet;
begin

 qryGen := nil;
  Result := 0;
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_PESESP '+
                    '  FROM LCA_CADBAS '+
                    ' WHERE BAS_CODBAS = :CODBAS';
      qryGen.ParamByName('CODBAS').AsString := strCodBas;
      qryGen.Open;

      Result := qryGen.FieldByName('BAS_PESESP').AsFloat;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

function TFormulaAutomotivaLechlerAutomotiva.fRetornaTotalDensidade(
  strTipPrg: String; fltPorcen, fltDensid: Double): Double;
begin
  Result := fltPorcen / fltDensid;
end;

function TFormulaAutomotivaLechlerAutomotiva.fRetQtdDiluente(
  fltVolumePro: Double; strCodDil, strPercentual: String): Double;
begin
  Result := ((fltVolumePro) * StrToFloat(strPercentual)) / 100;
end;

function TFormulaAutomotivaLechlerAutomotiva.fValidaVolumeFormulucao(strTipoPre: String;
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaLechlerAutomotiva.fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer;
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 0.900;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LCA').fGetDouble('LITVOL'), 3);
end;

function TFormulaAutomotivaLechlerAutomotiva.GetAcrescimoDespesaOperacionalTinta: Double;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('LCA').fGetDouble('DESOPE');
end;

function TFormulaAutomotivaLechlerAutomotiva.GetAno(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('LCA_A_N_O_').AsString;
end;

function TFormulaAutomotivaLechlerAutomotiva.GetCalcDespesasOperacionais(const base: TBaseAutomotiva;
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

function TFormulaAutomotivaLechlerAutomotiva.GetCalcIcmsSaida(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
Var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  fltVenBas := (fltQtdFor * (base.PrecoVenda / base.Cnv_Ml));

  Result := (fltVenBas * base.IcmsSaida / 100);
end;

function TFormulaAutomotivaLechlerAutomotiva.GetCalcImpostosFederais(const base: TBaseAutomotiva;
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

function TFormulaAutomotivaLechlerAutomotiva.GetCalcOutrosValores(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.OutrosValores / base.Cnv_Ml)));
end;

function TFormulaAutomotivaLechlerAutomotiva.GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.PrecoCompraLiquido / base.Cnv_Ml)));
end;

function TFormulaAutomotivaLechlerAutomotiva.GetCalcPrecoCusto(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.PrecoCusto / base.Cnv_Ml)));
end;

function TFormulaAutomotivaLechlerAutomotiva.GetCalcPrecoCustoReal(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.PrecoCustoReal / base.Cnv_Ml)));
end;

function TFormulaAutomotivaLechlerAutomotiva.GetCalcPrecoMedio(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.PrecoMedio / base.Cnv_Ml)));
end;

function TFormulaAutomotivaLechlerAutomotiva.GetCalcPrecoVenda(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.PrecoVenda / base.Cnv_Ml)));
end;

function TFormulaAutomotivaLechlerAutomotiva.GetCalcQuantidade(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := (TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido) * formula.VolumePro / formula.VolumeOri);
end;

function TFormulaAutomotivaLechlerAutomotiva.GetCalculadorInterno: ICalculadorFormulaAutomotiva;
begin
  Result := TAbstractCalculadorFormulaAutomotiva.Create(Self);
end;

function TFormulaAutomotivaLechlerAutomotiva.GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := (fltQtdFor * (base.UltimoPrecoCompra / base.Cnv_Ml));
end;

function TFormulaAutomotivaLechlerAutomotiva.GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.UltimoPrecoCompraImpostos / base.Cnv_Ml)));
end;

function TFormulaAutomotivaLechlerAutomotiva.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('LCA_MD5KEY').AsString;
end;

function TFormulaAutomotivaLechlerAutomotiva.GetCodFormul(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaLechlerAutomotiva.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('LCA_DESCRI').AsString;
end;

function TFormulaAutomotivaLechlerAutomotiva.GetDescricaoBase(strCodBas: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DESCRI '+
                    '  FROM LCA_CADBAS '+
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

function TFormulaAutomotivaLechlerAutomotiva.GetFatorEstoque: Double;
begin
  Result := 0.9;
end;

function TFormulaAutomotivaLechlerAutomotiva.GetIdePro: String;
begin
  Result := 'LCA';
end;

function TFormulaAutomotivaLechlerAutomotiva.GetIndEmb(
  const dtsCadTin: IDataSet): integer;
begin
  Result := -1;
end;

function TFormulaAutomotivaLechlerAutomotiva.GetLinha(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaLechlerAutomotiva.GetMontadora(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaLechlerAutomotiva.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaAutomotivaLechlerAutomotiva.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaAutomotivaLechlerAutomotiva.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaAutomotivaLechlerAutomotiva.GetNomeTabelaBases: String;
begin
  Result := 'LCA_CADBAS';
end;

Procedure TFormulaAutomotivaLechlerAutomotiva.pPreencherPesCorFor(const dtsCadTin: IDataSet);
begin
  Self.PesoCor := 0; //dtsCadTin.FieldByName('GEN_PESCOR').AsFloat;
  Self.PesoFor := 0; //dtsCadTin.FieldByName('GEN_PESFOR').AsFloat;
end;

{$IFNDEF LINUX}
procedure TFormulaAutomotivaLechlerAutomotiva.pRecalculaFormulaMostrarDigitado(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; fltFator: Double;
  blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha, strTipBas: String);
begin
  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado * fltFator, ffFixed, 12, 2));
    SubItems.Add(FloatToStrF(Base.QuantidadeDiluido * fltFator, ffFixed, 12, 2));
    SubItems.Add(FloatToStrF(Base.QuantidadeDiluido2 * fltFator, ffFixed, 12, 2));
    SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TFormulaAutomotivaLechlerAutomotiva.pRecalculaFormulaMostrarPadrao(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; blnConsLinhaDesBas: Boolean;
  strTipBas: String; intCont: Integer);
begin
  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado, ffFixed, 12, 2));
    SubItems.Add(FloatToStrF(Base.QuantidadeDiluido, ffFixed, 12, 2));
    SubItems.Add(FloatToStrF(Base.QuantidadeDiluido2, ffFixed, 12, 2));
    SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

function TFormulaAutomotivaLechlerAutomotiva.GetPrefixoFormulacao: String;
begin
  Result := 'LCA_CODB';
end;

function TFormulaAutomotivaLechlerAutomotiva.GetPrefixoLitragem(
  const strModo: String): String;
begin
  Result := '';
end;

function TFormulaAutomotivaLechlerAutomotiva.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'LCA_QTDB'
end;

function TFormulaAutomotivaLechlerAutomotiva.GetProdutoChapinha: String;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('LCA').fGet('PROCHA');
end;

function TFormulaAutomotivaLechlerAutomotiva.GetProdutoVendaTinta(const dtsCadTin: IDataSet): string;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('LCA').fGet('LCAPRO');
end;

function TFormulaAutomotivaLechlerAutomotiva.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaAutomotivaLechlerAutomotiva.GetSelectBases: String;
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

function TFormulaAutomotivaLechlerAutomotiva.GetTextoInformativoCalculo: String;
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

function TFormulaAutomotivaLechlerAutomotiva.GetUniversal(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaLechlerAutomotiva.GetUsaChapinha(
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := (dtsCadTin.FieldByName('LCA_PROCHA').AsString = 'S');
end;

function TFormulaAutomotivaLechlerAutomotiva.GetVolumeMaximoBalde(
  dtsCadTin: IDataSet): Double;
begin
  Result := 20.000;
end;

function TFormulaAutomotivaLechlerAutomotiva.GetVolumeMaximoGalao(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 4.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LCA').fGetDouble('GALVOL'), 3);
end;

function TFormulaAutomotivaLechlerAutomotiva.GetVolumeMaximoLata(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LCA').fGetDouble('LATVOL'), 3);
end;

function TFormulaAutomotivaLechlerAutomotiva.GetVolumeMaximoLitro(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 0.900;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LCA').fGetDouble('LITVOL'), 3);
end;

function TFormulaAutomotivaLechlerAutomotiva.GetVolumePadraCopo: Double;
begin
  Result := 0;
end;

function TFormulaAutomotivaLechlerAutomotiva.GetVolumePadraGalao(dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 3.600;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LCA').fGetDouble('GALVOL'), 3);
end;

function TFormulaAutomotivaLechlerAutomotiva.GetVolumePadraLitro: Double;
begin
  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LCA').fGetDouble('LITVOL'), 3);
end;

function TFormulaAutomotivaLechlerAutomotiva.GetVolumePadraoBalde(dtsCadTin: IDataSet): Double;
begin
  Result := 20.000;
end;

function TFormulaAutomotivaLechlerAutomotiva.GetVolumePadraoLata(dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 16.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LCA').fGetDouble('LATVOL'), 3);
end;

function TFormulaAutomotivaLechlerAutomotiva.GetVolumePadraSpray: Double;
begin
  Result := 0;
end;


function TFormulaAutomotivaLechlerAutomotiva.GetVolumePadraTambor(dtsCadTin: IDataSet): Double;
begin
  Result := 0;
end;

function TFormulaAutomotivaLechlerAutomotiva.GetVolumePermitido(
  const dtsCadTin: IDataSet; strTipoPre: String): Double;
begin
  Result := 0;
end;

procedure TFormulaAutomotivaLechlerAutomotiva.IniciaArrMinMax;
Var
  intContador: Integer;
begin
  SetLength(arrMinMax, Self.ListaAdicional.Count);

  If Self.ListaAdicional.Count <= 0 Then
    Exit;

  For intContador := 0 To Self.ListaAdicional.Count - 1 Do
  Begin
    arrMinMax[intContador].fltMin := 1;
    arrMinMax[intContador].fltMax := 100;
    arrMinMax[intContador].fltPad := 60;
  End;
end;

procedure TFormulaAutomotivaLechlerAutomotiva.pAtualizaPorcentagem(
  const formula: TAbstractFormulaAutomotiva; dtsCadTin: IDataSet);
begin
  If Not TStrUtils.fEmptyStr(dtsCadTin.FieldByName('LCA_CODB20').AsString) Then
    Exit;

  If Formula.ListaAdicional.Count <= 0 Then
    Exit;

  If Formula.PorDil <> 60 Then
  Begin
   If Formula.PorDil > arrMinMax[Formula.IndiceAdicional].fltMax Then
     Formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltMax;

  If Formula.PorDil < arrMinMax[Formula.IndiceAdicional].fltMin Then
    Formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltMin;
  End
  Else
    Formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltPad;

  Formula.HabDil := True;
end;

procedure TFormulaAutomotivaLechlerAutomotiva.pDefineVolumeOriginal;
begin
  If Self.mveModoVenda = mvConcentrado then
    Self.VolumeOri := Self.VolumeConcentrado
  Else
    Self.VolumeOri := Self.VolumeDiluido;
end;

procedure TFormulaAutomotivaLechlerAutomotiva.pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet);
var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('LCA');

  sProEmbTb := '';
  sProEmbBa := '';
  sProEmbSs := '';
  sProEmbPo := '';
  sProEmbSd := '';

  stlDesEmb.Clear;
  stlDesEmb.Add('');

  IniciaArrMinMax;

  stlProEmbLt.Add(Conf.fGet('LITEMB'));
  stlProEmbGl.Add(Conf.fGet('GALEMB'));
  stlProEmbLa.Add(Conf.fGet('LATEMB'));

  If ListaAdicional.Count > 0 Then
    pReformulaNovo(ListaAdicional[0], '60', dtsCadTin);
end;

procedure TFormulaAutomotivaLechlerAutomotiva.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('LCA_ACRMOB').AsFloat;
end;

procedure TFormulaAutomotivaLechlerAutomotiva.PreencheQuantidadeFormulacaoVenda(
  const dtsCadTin: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
//  fltFatorDensidade  : Double;
//  fltTotalDensidade  : Double;
//  fltTotalPorcentagem: Double;
begin
  For intContador := 1 To Self.GetQuantidadeFormulacao Do
  Begin

    If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('LCA_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
      Break;

    Base := TBaseAutomotiva(Self.Add);
    Base.CodigoBase := dtsCadTin.FieldByName('LCA_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString;
    Base.QuantidadeConcentrado := dtsCadTin.FieldByName('LCA_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat * 0.9;
    Base.QuantidadeDiluido     := 0.0;
    Base.TipoBase              := 'B';
  End;

end;

procedure TFormulaAutomotivaLechlerAutomotiva.PreencheVolumeVenda(const dtsCadTin: IDataSet);
begin
  Self.VolumeOri         := 0.9;
  Self.VolumeConcentrado := 0.9;
  Self.VolumeDiluido     := 0.9;
end;

procedure TFormulaAutomotivaLechlerAutomotiva.pReformulaNovo(strCodDil,
  strPercentual: String; const dtsCadTin: IDataSet);
Var
  intContador          : Integer;
  Bases                : TBaseAutomotiva;
  fltFatorPorcentagem  : Double;
  fltFatorDensidade  : Double;
  fltTotalDensidade  : Double;
  fltTotalPorcentagem: Double;
  Diluente           : TBaseAutomotiva;
  fltDesOpeTinta     : Double;
  qryGen             : IDataSet;
  fltPreCus, fltPreVen: Double;

  fltPeso: Double;
  fltPesoTotal: Double;
  blnEmPromo: Boolean;
  strSQL: String;
  blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
begin
  qryGen := Nil;

  If Not TStrUtils.fEmptyStr(dtsCadTin.FieldByName('LCA_CODB20').AsString) Then
    Exit;

  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;

    strSQL := '';
    strSQL := strSQL + '  SELECT                  ';
    strSQL := strSQL + '    *                     ';
    strSQL := strSQL + '  FROM                    ';
    strSQL := strSQL + '    LCA_CADBAS B          ';
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

    fltFatorPorcentagem := 100 + StrToFloat(strPercentual);

    For intContador := Self.Count - 1 DownTo 0 Do
    Begin
      Bases := (Self.Items[intContador] As TBaseAutomotiva);
      Bases.QuantidadeDiluido := fQuantidadePorConcentrado(dtsCadTin.FieldByName('LCA_QTDB' + TStrUtils.fStrZero(intContador + 1, 2)).AsFloat, dtsCadTin.FieldByName('LCA_CODB' + TStrUtils.fStrZero(intContador + 1, 2)).AsString) * 100 / fltFatorPorcentagem;
    End;

    fltTotalPorcentagem := 0;
    fltTotalDensidade   := 0;
    fltPesoTotal := 0;

     For intContador := 1 To Self.GetQuantidadeFormulacao Do
    Begin
      If TStrUtils.fEmptyStr(dtsCadTin.FieldByName('LCA_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
        Break;

      {FATOR DENSIDADE}
      fltFatorDensidade := TFloatUtils.fFormataFloat(fQuantidadePorConcentrado(dtsCadTin.FieldByName('LCA_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat, dtsCadTin.FieldByName('LCA_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString) * 100 / fltFatorPorcentagem, 4);


      fltPeso :=  TFloatUtils.fFormataFloat(fltFatorDensidade / fRetornarDensidade(dtsCadTin.FieldByName('LCA_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString), 4);

      {SOMATORIA PORCENTAGEM}
      fltTotalPorcentagem := fltTotalPorcentagem + TFloatUtils.fFormataFloat(fQuantidadePorConcentrado(dtsCadTin.FieldByName('LCA_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat, dtsCadTin.FieldByName('LCA_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString) * 100 / fltFatorPorcentagem, 2);

      {SOMATORIA DENSIDADE}
      fltTotalDensidade := fltTotalDensidade + fltFatorDensidade;
      fltPesoTotal := fltPesoTotal + fltPeso;
    End;

    {SOMATORIA DENSIDADE + DEN. DILUENTE}
    fltFatorDensidade := TFloatUtils.fFormataFloat(StrToFloat(strPercentual) * 100 / fltFatorPorcentagem, 4);
    fltPesoTotal := fltPesoTotal + (fltFatorDensidade / fRetornarDensidade(strCodDil));

    Try
      fltTotalDensidade := fRetornaTotalDensidade('1'
                                              , 100
                                              , fltPesoTotal);
    Except
      fltTotalDensidade := 1;
    End;

    For intContador := 1 To Self.GetQuantidadeFormulacao Do
    Begin
      If TStrUtils.fEmptyStr(dtsCadTin.FieldByName('LCA_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
        Break;

      Bases := TBaseAutomotiva(Self.Items[intContador - 1]);
      Bases.QuantidadeDiluido := 0.900 * fltTotalDensidade * (fQuantidadePorConcentrado(dtsCadTin.FieldByName('LCA_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat, dtsCadTin.FieldByName('LCA_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString) / fltFatorPorcentagem) * 1000;
    End;

    For intContador := Self.Count - 1 DownTo 0 Do
    Begin
      Bases := (Self.Items[intContador] As TBaseAutomotiva);
      If Bases.TipoBase <> 'B' Then
        Self.Delete(intContador);
    End;

    fltDesOpeTinta := TAutcomTintaFactory.Get.fGetConfTinta('LCA').fGetDouble('DESOPE');

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
      Diluente.PrecoVenda := fltPreVen;
      Diluente.PrecoCusto := fltPreCus;

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

    Diluente.QuantidadeDiluido := fArredondaValor(0.900 * fltTotalDensidade * (strToFloat(strPercentual) / fltFatorPorcentagem) * 1000, 5);
    Diluente.QuantidadeConcentrado := 0.0;
  Except
    On E: Exception Do
      Raise;
  End;
end;

end.
