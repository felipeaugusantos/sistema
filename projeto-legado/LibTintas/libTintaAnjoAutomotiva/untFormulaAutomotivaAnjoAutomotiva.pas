{************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula AnjoAutomotiva *}
{*********************************************************************AC*}
unit untFormulaAutomotivaAnjoAutomotiva;

interface

uses
{$IFNDEF LINUX}
  Controls,
  ComCtrls,
{$ENDIF}
  untAbstractFormulaAutomotiva, untICalculadorFormulaAutomotiva, untIDataSet, untBaseAutomotiva,
  SysUtils, untStrUtils, Classes, untIConfTinta, untFloatUtils, untModoVenda;

type
  TMinMax = record
    fltMin : Double;
    fltMax : Double;
end;

type
  TFormulaAutomotivaAnjoAutomotiva = class(TAbstractFormulaAutomotiva)
  private
    arrMinMax: Array Of TMinMax;
    function fRetQtdeDiluente(strPercentual: String; fltVolumeOriginal: Double): Double;
    function fRetPercentualDiluicao(strPercentual: String): Double;
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
    function fVolumeOriginalFator: Boolean; Override;

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

    function GetVolumePadraGalao(dtsCadTin: IDataSet): Double;  Override;
    function fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer; dtsCadTin: IDataSet): Double; Override;

    function fExisteConfiguracao(dtsCadTin: IDataSet; strEmbalagem: String): Boolean; Override;
    function fRetEmbLitro(dtsCadTin: IDataSet): String;
    function fREtEmbGalao(dtsCadTin: IDataSet): String;
    function fGetDiluentes(const dtsCadTin: IDataSet): TStringList; Override;
    procedure pReformulaNovo(strCodDil:String; strPercentual:String = '10'; const dtsCadTin: IDataSet = Nil); Override;
    procedure IniciaArrMinMax(const dtsCadTin: IDataSet);
    procedure pAtualizaPorcentagem(const formula: TAbstractFormulaAutomotiva;  dtsCadTin: IDataSet = Nil); Override;
  end;

implementation

uses
  untAbstractCalculadorFormulaAutomotiva, untAutcomTintaFactory;

{ TFormulaAutomotivaAnjoAutomotiva }

procedure TFormulaAutomotivaAnjoAutomotiva.CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva);
begin
  Base.Cnv_Ml := Base.Embalagem * Base.PesoEspecifico;
end;

function TFormulaAutomotivaAnjoAutomotiva.fCalculaQuantidadeParaBaixaEstoque(Base: TBaseAutomotiva): Double;
begin
  Result := TAutcomTintaFactory.Get.IIF(Self.mveModoVenda = mvConcentrado, base.QuantidadeConcentrado, base.QuantidadeDiluido) * (Self.fltVolumePro / Self.fltVolumeOri);
end;


function TFormulaAutomotivaAnjoAutomotiva.fExisteConfiguracao(
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
    qryConf.SQL := qryConf.SQL + '    CFG_IDEPRO = "AJT" AND          ';
    qryConf.SQL := qryConf.SQL + '    CFG_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" AND        ';

    If strEmbalagem = 'Litro' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "' + fRetEmbLitro(dtsCadTin) + '"      '
    Else If strEmbalagem = 'Galão' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "' + fREtEmbGalao(dtsCadTin) + '"      ';

    qryConf.Open;

    Result := (Not qryConf.IsEmpty);
  Except
    Raise;
  End;
end;

function TFormulaAutomotivaAnjoAutomotiva.fGetDiluentes(
  const dtsCadTin: IDataSet): TStringList;
Var
  qryGen: IDataSet;
begin
  Self.ListaAdicional.Clear;

  If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'PU FLEET TECH' Then
    Exit(Nil);

  Result := TStringList.Create;

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '   SELECT * FROM AJT_CADBAS B   ';
  qryGen.SQL := qryGen.SQL + '  INNER JOIN CADITE I ON  ';
  qryGen.SQL := qryGen.SQL + '    B.BAS_CODITE = I.ITE_CODITE   ';
  qryGen.SQL := qryGen.SQL + '  INNER JOIN ITEGER G ON  ';
  qryGen.SQL := qryGen.SQL + '    I.ITE_CODITE = G.ITE_CODITE AND   ';
  qryGen.SQL := qryGen.SQL + '    G.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '"  ';
  qryGen.SQL := qryGen.SQL + '  WHERE BAS_CODBAS IN ("TH5003")    ';
  qryGen.Open;



  While Not qryGen.Eof Do
  Begin
    Result.Add(qryGen.FieldByName('BAS_CODBAS').AsString);
    qryGen.Next;
  End;

  If Result.Count > 0 Then
  Begin
    If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIESTER' Then
      Self.pReformulaNovo(Result[0], '50', dtsCadTin)
    Else
      Self.pReformulaNovo(Result[0], '20', dtsCadTin);

    Self.blnDadosAdicionais := True;
    Self.strCaptionAdicional := 'Diluentes';
    Self.blnAdicionalDiluido := True;
  End;
end;

procedure TFormulaAutomotivaAnjoAutomotiva.pReformulaNovo(strCodDil,
  strPercentual: String; const dtsCadTin: IDataSet);
Var
  intContador          : Integer;
  Bases                : TBaseAutomotiva;
  Diluente           : TBaseAutomotiva;
  fltDesOpeTinta     : Double;
  qryGen             : IDataSet;
  fltPreCus, fltPreVen: Double;
  blnEmPromo: Boolean;
  fltVolumeOriginal: Double;
  blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
begin
  If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'PU FLEET TECH' Then
    Exit;

  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.Close;
    qryGen.SQL := '';
    qryGen.SQL := qryGen.SQL + '  SELECT                ';
    qryGen.SQL := qryGen.SQL + '    *                   ';
    qryGen.SQL := qryGen.SQL + '  FROM                  ';
    qryGen.SQL := qryGen.SQL + '    AJT_CADBAS B        ';
    qryGen.SQL := qryGen.SQL + '  INNER JOIN ITEGER G ON        ';
    qryGen.SQL := qryGen.SQL + '    G.ITE_CODITE = B.BAS_CODITE AND       ';
    qryGen.SQL := qryGen.SQL + '    G.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '"  ';
    qryGen.SQL := qryGen.SQL + '  INNER JOIN CADITE I ON        ';
    qryGen.SQL := qryGen.SQL + '    I.ITE_CODITE = G.ITE_CODITE           ';
    qryGen.SQL := qryGen.SQL + '  WHERE                 ';
    qryGen.SQL := qryGen.SQL + '    B.BAS_CODBAS = :CODBAS      ';

    qryGen.ParamByName('CODBAS').AsString := strCodDil;
    qryGen.Open;

    If qryGen.IsEmpty Then
      Exit;

    fltVolumeOriginal := dtsCadTin.FieldByName('AJT_VOLUME').AsFloat;


    For intContador := 1 To Self.GetQuantidadeFormulacao Do
    Begin
      If TStrUtils.fEmptyStr(dtsCadTin.FieldByName('AJT_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
        Break;

      Bases := TBaseAutomotiva(Self.Items[intContador - 1]);
      Bases.QuantidadeDiluido := TFloatUtils.fFormataFloat(dtsCadTin.FieldByName('AJT_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat * fRetPercentualDiluicao(strPercentual), 2);
    End;

    For intContador := Self.Count - 1 DownTo 0 Do
      Begin
        Bases := (Self.Items[intContador] As TBaseAutomotiva);
        If Bases.TipoBase <> 'B' Then
          Self.Delete(intContador);
      End;

    fltDesOpeTinta := TAutcomTintaFactory.Get.fGetConfTinta('AJT').fGetDouble('DESOPE');

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

    Diluente.QuantidadeDiluido := TFloatUtils.fFormataFloat(fRetQtdeDiluente(strPercentual, fltVolumeOriginal) * Diluente.PesoEspecifico, 3);
    Diluente.QuantidadeConcentrado := 0;
  Except
    On E: Exception Do
    Begin
      Raise;
    End;
  End;
end;

procedure TFormulaAutomotivaAnjoAutomotiva.IniciaArrMinMax(const dtsCadTin: IDataSet);
Var
  intContador: Integer;
begin
  SetLength(arrMinMax, Self.ListaAdicional.Count);

  For intContador := 0 To Self.ListaAdicional.Count - 1 Do
  Begin
    If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIESTER' Then
    Begin
      arrMinMax[intContador].fltMin := 50;
      arrMinMax[intContador].fltMax := 50;
    End
    Else If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIURETANO' Then
    Begin
      arrMinMax[intContador].fltMin := 20;
      arrMinMax[intContador].fltMax := 30;
    End;
  End;
end;

procedure TFormulaAutomotivaAnjoAutomotiva.pAtualizaPorcentagem(
  const formula: TAbstractFormulaAutomotiva;  dtsCadTin: IDataSet);
begin
  If Formula.ListaAdicional.Count <= 0 Then
    Exit;

  If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'PU FLEET TECH' Then
    Exit;

  If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIESTER' Then
    Formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltMax;

  If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIURETANO' Then
  Begin
    If Formula.PorDil <= arrMinMax[Formula.IndiceAdicional].fltMin Then
      Formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltMin
    Else If Formula.PorDil > arrMinMax[Formula.IndiceAdicional].fltMin Then
      Formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltMax
  End;

  Formula.HabDil := True;
end;



function TFormulaAutomotivaAnjoAutomotiva.fMostrarComCatalisador: Boolean;
begin
  Result := False;
end;

function TFormulaAutomotivaAnjoAutomotiva.fREtEmbGalao(
  dtsCadTin: IDataSet): String;
begin
  Result := '';

  If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIESTER' Then
    Result := 'VOLGAL_POLI'
  Else If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIURETANO' Then
    Result := 'VOLGAL_POLU'
  Else If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIURETANO CONCENTRADO' Then
    Result := 'VOLGAL_POLC'
  Else If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'PU FLEET TECH' Then
    Result := 'VOLGAL_FLEE';
end;

function TFormulaAutomotivaAnjoAutomotiva.fRetEmbLitro(
  dtsCadTin: IDataSet): String;
begin
  Result := '';

  If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIESTER' Then
    Result := 'VOLLIT_POLI'
  Else If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIURETANO' Then
    Result := 'VOLLIT_POLU'
  Else If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIURETANO CONCENTRADO' Then
    Result := 'VOLLIT_POLC'
  Else If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'PU FLEET TECH' Then
    Result := 'VOLLIT_FLEE';
end;

function TFormulaAutomotivaAnjoAutomotiva.fRetPercentualDiluicao(
  strPercentual: String): Double;
begin
  Result := 0;

  If strPercentual = '20' Then
    Result := 83.33 / 100
  Else If strPercentual = '30' Then
    Result := 77 / 100
  Else If strPercentual = '50' Then
    Result := 66.67 / 100;
end;

function TFormulaAutomotivaAnjoAutomotiva.fRetQtdeDiluente(strPercentual: String; fltVolumeOriginal: Double): Double;
begin
  Result := 0;

  If strPercentual = '20' Then
    Result := fltVolumeOriginal * 16.67 / 100
  Else If strPercentual = '30' Then
    Result := fltVolumeOriginal * 23 / 100
  Else If strPercentual = '50' Then
    Result := fltVolumeOriginal * 33.33 / 100;
end;

//function TFormulaAutomotivaAnjoAutomotiva.fPermiteMostrarComboDeEmbalagem: Boolean;
//begin
//  Result := false;
//end;

function TFormulaAutomotivaAnjoAutomotiva.fValidaVolumeFormulucao(strTipoPre: String;
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaAnjoAutomotiva.fVolumeOriginalFator: Boolean;
begin
  Result := False;
end;

function TFormulaAutomotivaAnjoAutomotiva.fVolumePadraoLitro(
  fltVolumePadraoLitro: Double; intModoVenda: Integer;
  dtsCadTin: IDataSet): Double;
begin
  Result := 0.900;

  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 0.900;
    Exit;
  End;

  If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIESTER' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('AJT').fGetDouble('VOLLIT_POLI'), 3)
  Else If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIURETANO' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('AJT').fGetDouble('VOLLIT_POLU'), 3)
  Else If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIURETANO CONCENTRADO' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('AJT').fGetDouble('VOLLIT_POLC'), 3)
  Else If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'PU FLEET TECH' Then
    REsult := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('AJT').fGetDouble('VOLLIT_FLEE'), 3);
end;

function TFormulaAutomotivaAnjoAutomotiva.GetAcrescimoDespesaOperacionalTinta: Double;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('AJT').fGetDouble('DESOPE');
end;

function TFormulaAutomotivaAnjoAutomotiva.GetAno(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('AJT_ANOINI').AsString;
end;

function TFormulaAutomotivaAnjoAutomotiva.GetCalcDespesasOperacionais(const base: TBaseAutomotiva;
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

function TFormulaAutomotivaAnjoAutomotiva.GetCalcIcmsSaida(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
Var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  fltVenBas := (fltQtdFor * (base.PrecoVenda / base.Cnv_Ml));

  Result := (fltVenBas * base.IcmsSaida / 100);
end;

function TFormulaAutomotivaAnjoAutomotiva.GetCalcImpostosFederais(const base: TBaseAutomotiva;
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

function TFormulaAutomotivaAnjoAutomotiva.GetCalcOutrosValores(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.OutrosValores / base.Cnv_Ml)));
end;

function TFormulaAutomotivaAnjoAutomotiva.GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.PrecoCompraLiquido / base.Cnv_Ml)));
end;

function TFormulaAutomotivaAnjoAutomotiva.GetCalcPrecoCusto(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.PrecoCusto / base.Cnv_Ml)));
end;

function TFormulaAutomotivaAnjoAutomotiva.GetCalcPrecoCustoReal(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.PrecoCustoReal / base.Cnv_Ml)));
end;

function TFormulaAutomotivaAnjoAutomotiva.GetCalcPrecoMedio(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.PrecoMedio / base.Cnv_Ml)));
end;

function TFormulaAutomotivaAnjoAutomotiva.GetCalcPrecoVenda(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.PrecoVenda / base.Cnv_Ml)));
end;

function TFormulaAutomotivaAnjoAutomotiva.GetCalcQuantidade(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := (TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido) * formula.VolumePro / formula.VolumeOri);
end;

function TFormulaAutomotivaAnjoAutomotiva.GetCalculadorInterno: ICalculadorFormulaAutomotiva;
begin
  Result := TAbstractCalculadorFormulaAutomotiva.Create(Self);
end;

function TFormulaAutomotivaAnjoAutomotiva.GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := (fltQtdFor * (base.UltimoPrecoCompra / base.Cnv_Ml));
end;

function TFormulaAutomotivaAnjoAutomotiva.GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));

  Result := ((fltQtdFor * (base.UltimoPrecoCompraImpostos / base.Cnv_Ml)));
end;

function TFormulaAutomotivaAnjoAutomotiva.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('AJT_MD5KEY').AsString;
end;

function TFormulaAutomotivaAnjoAutomotiva.GetCodFormul(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('AJT_CODIGO').AsString;
end;

function TFormulaAutomotivaAnjoAutomotiva.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('AJT_DESCRI').AsString;
end;

function TFormulaAutomotivaAnjoAutomotiva.GetDescricaoBase(strCodBas: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DESCRI '+
                    '  FROM AJT_CADBAS '+
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

function TFormulaAutomotivaAnjoAutomotiva.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaAutomotivaAnjoAutomotiva.GetIdePro: String;
begin
  Result := 'AJT';
end;

function TFormulaAutomotivaAnjoAutomotiva.GetIndEmb(
  const dtsCadTin: IDataSet): integer;
begin
  Result := -1;

  If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIESTER' Then
    Result := 0
  Else If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIURETANO' Then
    Result := 1
  Else If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIURETANO CONCENTRADO' Then
    Result := 2
  Else If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'PU FLEET TECH' Then
    Result := 3;
end;

function TFormulaAutomotivaAnjoAutomotiva.GetMontadora(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('MON_DESCRI').AsString;
end;

function TFormulaAutomotivaAnjoAutomotiva.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaAutomotivaAnjoAutomotiva.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaAutomotivaAnjoAutomotiva.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaAutomotivaAnjoAutomotiva.GetNomeTabelaBases: String;
begin
  Result := 'AJT_CADBAS';
end;

Procedure TFormulaAutomotivaAnjoAutomotiva.pPreencherPesCorFor(const dtsCadTin: IDataSet);
begin
  Self.PesoCor := 0;
  Self.PesoFor := 0;
end;

{$IFNDEF LINUX}
procedure TFormulaAutomotivaAnjoAutomotiva.pRecalculaFormulaMostrarDigitado(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; fltFator: Double;
  blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha, strTipBas: String);
begin
  inherited;
  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado * fltFator, ffFixed, 12, 1));
    SubItems.Add(FloatToStrF(Base.QuantidadeDiluido * fltFator, ffFixed, 12, 1));
    SubItems.Add(FloatToStrF(Base.QuantidadeDiluido2 * fltFator, ffFixed, 12, 1));
    SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TFormulaAutomotivaAnjoAutomotiva.pRecalculaFormulaMostrarPadrao(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; blnConsLinhaDesBas: Boolean;
  strTipBas: String; intCont: Integer);
begin
  inherited;
  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado, ffFixed, 12, 1));
    SubItems.Add(FloatToStrF(Base.QuantidadeDiluido, ffFixed, 12, 1));
    SubItems.Add(FloatToStrF(Base.QuantidadeDiluido2, ffFixed, 12, 1));
    SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

function TFormulaAutomotivaAnjoAutomotiva.GetPrefixoFormulacao: String;
begin
  Result := 'AJT_FORM';
end;

function TFormulaAutomotivaAnjoAutomotiva.GetPrefixoLitragem(
  const strModo: String): String;
begin
  Result := 'AJT_VOLUME';
end;

function TFormulaAutomotivaAnjoAutomotiva.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'AJT_QTDC';
end;

function TFormulaAutomotivaAnjoAutomotiva.GetProdutoVendaTinta(const dtsCadTin: IDataSet): string;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('AJT').fGet('AJTPRO');
end;

function TFormulaAutomotivaAnjoAutomotiva.GetQuantidadeFormulacao: Integer;

begin
  Result := 20;
end;

function TFormulaAutomotivaAnjoAutomotiva.GetSelectBases: String;
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

function TFormulaAutomotivaAnjoAutomotiva.GetTextoInformativoCalculo: String;
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

function TFormulaAutomotivaAnjoAutomotiva.GetUniversal(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaAnjoAutomotiva.GetVolumeMaximoGalao(
  dtsCadTin: IDataSet): Double;
begin
  Result := 4.000;

  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 4.000;
    Exit;
  End;

  If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIESTER' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('AJT').fGetDouble('VOLGAL_POLI'), 3)
  Else If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIURETANO' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('AJT').fGetDouble('VOLGAL_POLU'), 3)
  Else If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIURETANO CONCENTRADO' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('AJT').fGetDouble('VOLGAL_POLC'), 3)
  Else If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'PU FLEET TECH' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('AJT').fGetDouble('VOLGAL_FLEE'), 3);
end;

function TFormulaAutomotivaAnjoAutomotiva.GetVolumeMaximoLitro(
  dtsCadTin: IDataSet): Double;
begin
  Result := 1.000;

  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 1.000;
    Exit;
  End;

  If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIESTER' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('AJT').fGetDouble('VOLLIT_POLI'), 3)
  Else If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIURETANO' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('AJT').fGetDouble('VOLLIT_POLU'), 3)
  Else If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIURETANO CONCENTRADO' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('AJT').fGetDouble('VOLLIT_POLC'), 3)
  Else If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'PU FLEET TECH' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('AJT').fGetDouble('VOLLIT_FLEE'), 3);
end;

function TFormulaAutomotivaAnjoAutomotiva.GetVolumePadraCopo: Double;
begin
  Result := 0;
end;


function TFormulaAutomotivaAnjoAutomotiva.GetVolumePadraGalao(
  dtsCadTin: IDataSet): Double;
begin
  Result := 3.600;

  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 3.600;
    Exit;
  End;

  If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIESTER' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('AJT').fGetDouble('VOLGAL_POLI'), 3)
  Else If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIURETANO' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('AJT').fGetDouble('VOLGAL_POLU'), 3)
  Else If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIURETANO CONCENTRADO' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('AJT').fGetDouble('VOLGAL_POLC'), 3)
  Else If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'PU FLEET TECH' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('AJT').fGetDouble('VOLGAL_FLEE'), 3);
end;

function TFormulaAutomotivaAnjoAutomotiva.GetVolumePadraSpray: Double;
begin
  Result := 0;
end;


function TFormulaAutomotivaAnjoAutomotiva.GetVolumePadraTambor(dtsCadTin: IDataSet): Double;
begin
  Result := 0;
end;

function TFormulaAutomotivaAnjoAutomotiva.GetVolumePermitido(
  const dtsCadTin: IDataSet; strTipoPre: String): Double;
begin
  Result := 0;
end;

procedure TFormulaAutomotivaAnjoAutomotiva.pDefineVolumeOriginal;
begin
  If Self.mveModoVenda = mvConcentrado then
    Self.VolumeOri := Self.VolumeConcentrado
  Else
    Self.VolumeOri := Self.VolumeDiluido;
end;

procedure TFormulaAutomotivaAnjoAutomotiva.pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet);
var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('AJT');


  sProEmbTb := '';
  sProEmbBa := '';
  sProEmbSs := '';
  sProEmbPo := '';
  sProEmbSd := '';

  IniciaArrMinMax(dtsCadTin);

  stlDesEmb.Clear;
  stlDesEmb.Add('POLIESTER');
  stlDesEmb.Add('POLIURETANO');
  stlDesEmb.Add('POLIURETANO CONCENTRADO');
  stlDesEmb.Add('PU FLEET TECH');

  stlProEmbLt.Add(conf.fGet('AJTLIT_POLI')); // POLIESTER LITRO
  stlProEmbGl.Add(conf.fGet('AJTGAL_POLI')); // POLIESTER GALÃO

  stlProEmbLt.Add(Conf.fGet('AJTLIT_POLU')); //POLIURETANO LITRO
  stlProEmbGl.Add(Conf.fGet('AJTGAL_POLU')); //POLIURERANO GALÃO

  stlProEmbLt.Add(Conf.fGet('AJTLIT_POLC')); //POLIURETANO CONCENTRADO LITRO
  stlProEmbGl.Add(Conf.fGet('AJTGAL_POLC')); //POLIURETANO CONCENTRADO GALÃO

  stlProEmbLt.Add(Conf.fGet('AJTLIT_FLEE')); //PU FLEET TECH LITRO
  stlProEmbGl.Add(Conf.fGet('AJTGAL_FLEE')); //PU FLEET TECH GALÃO


  If ListaAdicional.Count > 0 Then
  Begin
    If dtsCadTin.FieldByName('AJT_PRODUT').AsString = 'POLIESTER' Then
      Self.pReformulaNovo(ListaAdicional[0], '50', dtsCadTin)
    Else
      Self.pReformulaNovo(ListaAdicional[0], '20', dtsCadTin);
  End;
end;

procedure TFormulaAutomotivaAnjoAutomotiva.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('AJT_ACRMOB').AsFloat;
end;

procedure TFormulaAutomotivaAnjoAutomotiva.PreencheQuantidadeFormulacaoVenda(
  const dtsCadTin: IDataSet);
var
  intContador: Integer;
  Base       : TBaseAutomotiva;
begin
  For intContador := 1 To Self.GetQuantidadeFormulacao Do
  Begin

    If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('AJT_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
      Break;

    Base             := TBaseAutomotiva(Self.Add);
    Base.CodigoBase  := trim(dtsCadTin.FieldByName('AJT_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString);
    Base.QuantidadeConcentrado := dtsCadTin.FieldByName('AJT_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
    Base.TipoBase   := 'B';
  End;
end;

procedure TFormulaAutomotivaAnjoAutomotiva.PreencheVolumeVenda(const dtsCadTin: IDataSet);
begin
  Self.VolumeOri         := dtsCadTin.FieldByName('AJT_VOLUME').AsFloat / 1000;
  Self.VolumeConcentrado := dtsCadTin.FieldByName('AJT_VOLUME').AsFloat / 1000;
  Self.VolumeDiluido     := dtsCadTin.FieldByName('AJT_VOLUME').AsFloat / 1000;
end;

end.

