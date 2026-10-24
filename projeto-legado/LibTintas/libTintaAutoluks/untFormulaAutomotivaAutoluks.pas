{************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula Autoluks *}
{*********************************************************************AC*}
unit untFormulaAutomotivaAutoluks;

interface

uses
{$IFNDEF LINUX}
  Controls,
  ComCtrls,
{$ENDIF}
  untAbstractFormulaAutomotiva, untICalculadorFormulaAutomotiva, untIDataSet, untBaseAutomotiva,
  SysUtils, untStrUtils, Classes, untIConfTinta, untFloatUtils, untModoVenda, untIDicionario;

type
  TMinMax = record
    fltMin : Double;
    fltMax : Double;
  end;

type
  TFormulaAutomotivaAutoluks = class(TAbstractFormulaAutomotiva)
  private
    arrMinMax : array of TMinMax;
    function fCalculaVolumeTotal(): Double;
    function fEItemPromocao(qryGen: IDataSet; fltPreVen: Double; fltPreCus: Double): Boolean;
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

    procedure pRecalculaFormulaMostrarDigitado(var lsvFormulacao: TListView;
      Base: TBaseAutomotiva; intDecimaisPrecoVenda, intDecimaisPesoEspecifico: Integer;
      fltFator: Double; blnConsLinhaDesBas: Boolean; intCont: Integer;
      strLinha: String; strTipBas: String); override;
  {$ENDIF}

    function GetVolumeMaximoLitro(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoGalao(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoLata(dtsCadTin: IDataSet): Double; override;

    function GetVolumePadraGalao(dtsCadTin: IDataSet): Double;  Override;
    function GetVolumePadraoLata(dtsCadTin: IDataSet): Double; override;
    function fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer; dtsCadTin: IDataSet): Double; Override;

    function fExisteConfiguracao(dtsCadTin: IDataSet; strUnidade: String): Boolean; Override;
    function fRetEmbLitro(dtsCadTin: IDataSet): String;
    function fRetEmbGalao(dtsCadTin: IDataSet): String;

    function fRetQtdDiluente(fltVolumePro: Double; strCodDil: String; strPercentual:String = '54'): Double; Reintroduce;
    function fGetDiluentes(const dtsCadTin: IDataSet): TStringList; Override;
    procedure pReformulaNovo(strCodDil:String; strPercentual:String = '10'; const dtsCadTin: IDataSet = Nil); override;
    procedure IniciaArrMinMax();
    procedure pAtualizaPorcentagem(const formula: TAbstractFormulaAutomotiva; dtsCadTin: IDataSet = Nil); override;
  end;

implementation

uses
  untAbstractCalculadorFormulaAutomotiva, untAutcomTintaFactory;

{ TFormulaAutomotivaAutoluks }

procedure TFormulaAutomotivaAutoluks.CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva);
begin
  Base.Cnv_Ml := Base.Embalagem * Base.PesoEspecifico;
end;

function TFormulaAutomotivaAutoluks.fCalculaQuantidadeParaBaixaEstoque(Base: TBaseAutomotiva): Double;
begin
  Result := TAutcomTintaFactory.Get.IIF(base.QuantidadeConcentrado > 0, base.QuantidadeConcentrado, base.QuantidadeDiluido) * (Self.fltVolumePro / Self.fltVolumeOri);
end;


function TFormulaAutomotivaAutoluks.fCalculaVolumeTotal: Double;
Var
  Bases: TBaseAutomotiva;
  intContador: Integer;
  fltVolumeTotal: Double;
begin
  fltVolumeTotal := 0;

  For intContador :=  Self.Count - 1 DownTo 0 Do
  Begin
    Bases := (Self.Items[intContador] As TBaseAutomotiva);

    If Bases.TipoBase <> 'B' Then
      Self.Delete(intContador)
    Else
      fltVolumeTotal := fltVolumeTotal + (Bases.QuantidadeConcentrado / Bases.PesoEspecifico);
  End;

  Result := 1000;
end;

function TFormulaAutomotivaAutoluks.fEItemPromocao(qryGen: IDataSet; fltPreVen: Double; fltPreCus: Double): Boolean;
  Var
    blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
begin
  Result := False;

  If TAutcomTintaFactory.Get.fCarregaPromocao(qryGen.FieldByName('BAS_CODITE').AsString,
                                                  strTabPre, Self.strCodCli, Self.strCodCnd, Self.intPrzMed,
                                                  fltPreCus, fltPreVen, blnPrecoFixoParaTintaDeMaquinaImobiliaria) Then
  Begin
    If (Not Self.blnProPre) Then
      Result := True;
  End;
end;

function TFormulaAutomotivaAutoluks.fExisteConfiguracao(
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
    qryConf.SQL := qryConf.SQL + '    CFG_IDEPRO = "ALK" AND        ';
    qryConf.SQL := qryConf.SQL + '    CFG_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" AND      ';

    If strUnidade = 'Litro' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "LITVOL"        '
    Else If strUnidade = 'Galão' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "GALVOL"        '
    Else If strUnidade = 'Lata' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "LATVOL"        ';

    qryConf.Open;

    Result := (Not qryConf.IsEmpty);
  Except
    Raise;
  End;
end;

function TFormulaAutomotivaAutoluks.fGetDiluentes(
  const dtsCadTin: IDataSet): TStringList;
Var
  qryGen: IDataSet;
  strSQL: String;
begin
  Self.ListaAdicional.Clear;

  If (dtsCadTin.FieldByName('ALK_PRODUT').AsString = 'ATL SINTETICO') Then
    Exit(Nil);


  strSQL := '';
  strSQL := strSQL + '  SELECT                  ';
  strSQL := strSQL + '    *                     ';
  strSQL := strSQL + '  FROM                    ';
  strSQL := strSQL + '    ALK_CADBAS B          ';
  strSQL := strSQL + '  INNER JOIN ITEGER G ON         ';
  strSQL := strSQL + '    G.ITE_CODITE = B.BAS_CODITE AND         ';
  strSQL := strSQL + '    G.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '"    ';
  strSQL := strSQL + '  INNER JOIN CADITE I ON         ';
  strSQL := strSQL + '    I.ITE_CODITE =  G.ITE_CODITE            ';
  strSQL := strSQL + '  WHERE                   ';
  strSQL := strSQL + '    BAS_CODBAS = :CODBAS        ';


  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := strSQL;
  qryGen.ParamByName('CODBAS').AsString := 'ATL000';
  qryGen.Open;

  Result := TStringList.Create;

  While Not qryGen.Eof Do
  Begin
    Result.Add(qryGen.FieldByName('BAS_CODBAS').AsString);
    qryGen.Next;
  End;

  If Result.Count > 0 Then
  Begin
    Self.pReformulaNovo(Result[0], '54', dtsCadTin);
    Self.blnDadosAdicionais := True;
    Self.strCaptionAdicional := 'Diluentes';
    Self.blnAdicionalDiluido := True;
  End;
end;

function TFormulaAutomotivaAutoluks.fMostrarComCatalisador: Boolean;
begin
  Result := False;
end;

function TFormulaAutomotivaAutoluks.fRetEmbGalao(
  dtsCadTin: IDataSet): String;
begin
  Result := '';

  If dtsCadTin.FieldByName('ALK_PRODUT').AsString = 'POLIESTER' Then
    Result := 'VOLGAL_POLI'
  Else If dtsCadTin.FieldByName('ALK_PRODUT').AsString = 'POLIURETANO' Then
    Result := 'VOLGAL_POLU'
  Else If dtsCadTin.FieldByName('ALK_PRODUT').AsString = 'POLIURETANO CONCENTRADO' Then
    Result := 'VOLGAL_POLC';
end;

function TFormulaAutomotivaAutoluks.fRetEmbLitro(
  dtsCadTin: IDataSet): String;
begin
  Result := '';

  If dtsCadTin.FieldByName('ALK_PRODUT').AsString = 'POLIESTER' Then
    Result := 'VOLLIT_POLI'
  Else If dtsCadTin.FieldByName('ALK_PRODUT').AsString = 'POLIURETANO' Then
    Result := 'VOLLIT_POLU'
  Else If dtsCadTin.FieldByName('ALK_PRODUT').AsString = 'POLIURETANO CONCENTRADO' Then
    Result := 'VOLLIT_POLC';
end;

function TFormulaAutomotivaAutoluks.fRetQtdDiluente(fltVolumePro: Double;
  strCodDil, strPercentual: String): Double;
begin
  Result := ((fltVolumePro * 1000) * StrToFloat(strPercentual)) / 100;
end;

function TFormulaAutomotivaAutoluks.fValidaVolumeFormulucao(strTipoPre: String;
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaAutoluks.fVolumePadraoLitro(
  fltVolumePadraoLitro: Double; intModoVenda: Integer;
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 0.900;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('ALK').fGetDouble('LITVOL'), 3);
end;

function TFormulaAutomotivaAutoluks.GetAcrescimoDespesaOperacionalTinta: Double;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('ALK').fGetDouble('DESOPE');
end;

function TFormulaAutomotivaAutoluks.GetAno(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('ALK_ANOINI').AsString;
end;

function TFormulaAutomotivaAutoluks.GetCalcDespesasOperacionais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdAux    : Double;
  fltVenBas : Double;
begin
  fltQtdAux := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdAux := TAutcomTintaFactory.Get.fFormataFloat((fltQtdAux * formula.VolumePro / formula.VolumeOri), 1);

  fltVenBas := (fltQtdAux *( base.PrecoVenda / base.Cnv_Ml));

  Result := (fltVenBas * base.DespesasOperacionais / 100);
end;

function TFormulaAutomotivaAutoluks.GetCalcIcmsSaida(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
Var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TAutcomTintaFactory.Get.fFormataFloat((fltQtdFor * formula.VolumePro / formula.VolumeOri), 1);

  fltVenBas := (fltQtdFor * (base.PrecoVenda / base.Cnv_Ml));

  Result := (fltVenBas * base.IcmsSaida / 100);
end;

function TFormulaAutomotivaAutoluks.GetCalcImpostosFederais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
Var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TAutcomTintaFactory.Get.fFormataFloat((fltQtdFor * formula.VolumePro / formula.VolumeOri), 1);

  fltVenBas := (fltQtdFor * (base.PrecoVenda / base.Cnv_Ml));

  Result := (fltVenBas * base.ImpostosFederais / 100);
end;

function TFormulaAutomotivaAutoluks.GetCalcOutrosValores(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TAutcomTintaFactory.Get.fFormataFloat((fltQtdFor * (formula.VolumePro / formula.VolumeOri)), 1);

  Result := ((fltQtdFor * (base.OutrosValores / base.Cnv_Ml)));
end;

function TFormulaAutomotivaAutoluks.GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TAutcomTintaFactory.Get.fFormataFloat((fltQtdFor * (formula.VolumePro / formula.VolumeOri)), 1);

  Result := ((fltQtdFor * (base.PrecoCompraLiquido / base.Cnv_Ml)));
end;

function TFormulaAutomotivaAutoluks.GetCalcPrecoCusto(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TAutcomTintaFactory.Get.fFormataFloat((fltQtdFor * (formula.VolumePro / formula.VolumeOri)), 1);

  Result := ((fltQtdFor * (base.PrecoCusto / base.Cnv_Ml)));
end;

function TFormulaAutomotivaAutoluks.GetCalcPrecoCustoReal(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TAutcomTintaFactory.Get.fFormataFloat((fltQtdFor * (formula.VolumePro / formula.VolumeOri)), 1);

  Result := ((fltQtdFor * (base.PrecoCustoReal / base.Cnv_Ml)));
end;

function TFormulaAutomotivaAutoluks.GetCalcPrecoMedio(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TAutcomTintaFactory.Get.fFormataFloat((fltQtdFor * (formula.VolumePro / formula.VolumeOri)), 1);

  Result := ((fltQtdFor * (base.PrecoMedio / base.Cnv_Ml)));
end;

function TFormulaAutomotivaAutoluks.GetCalcPrecoVenda(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TAutcomTintaFactory.Get.fFormataFloat((fltQtdFor * (formula.VolumePro / formula.VolumeOri)), 1);

  Result := ((fltQtdFor * (base.PrecoVenda / base.Cnv_Ml)));
end;

function TFormulaAutomotivaAutoluks.GetCalcQuantidade(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := TAutcomTintaFactory.Get.fFormataFloat((TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido) * formula.VolumePro / formula.VolumeOri), 1);
end;

function TFormulaAutomotivaAutoluks.GetCalculadorInterno: ICalculadorFormulaAutomotiva;
begin
  Result := TAbstractCalculadorFormulaAutomotiva.Create(Self);
end;

function TFormulaAutomotivaAutoluks.GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TAutcomTintaFactory.Get.fFormataFloat((fltQtdFor * (formula.VolumePro / formula.VolumeOri)), 1);

  Result := (fltQtdFor * (base.UltimoPrecoCompra / base.Cnv_Ml));
end;

function TFormulaAutomotivaAutoluks.GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TAutcomTintaFactory.Get.fFormataFloat((fltQtdFor * (formula.VolumePro / formula.VolumeOri)), 1);

  Result := ((fltQtdFor * (base.UltimoPrecoCompraImpostos / base.Cnv_Ml)));
end;

function TFormulaAutomotivaAutoluks.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('ALK_MD5KEY').AsString;
end;

function TFormulaAutomotivaAutoluks.GetCodFormul(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('ALK_CODIGO').AsString;
end;

function TFormulaAutomotivaAutoluks.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('ALK_DESCRI').AsString;
end;

function TFormulaAutomotivaAutoluks.GetDescricaoBase(strCodBas: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DESCRI '+
                    '  FROM ALK_CADBAS '+
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

function TFormulaAutomotivaAutoluks.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaAutomotivaAutoluks.GetIdePro: String;
begin
  Result := 'ALK';
end;

function TFormulaAutomotivaAutoluks.GetIndEmb(
  const dtsCadTin: IDataSet): integer;
begin
  Result := -1;

  If dtsCadTin.FieldByName('ALK_PRODUT').AsString = 'POLIESTER' Then
    Result := 0
  Else If dtsCadTin.FieldByName('ALK_PRODUT').AsString = 'POLIURETANO' Then
    Result := 1
  Else If dtsCadTin.FieldByName('ALK_PRODUT').AsString = 'POLIURETANO CONCENTRADO' Then
    Result := 2;
end;

function TFormulaAutomotivaAutoluks.GetMontadora(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('ALK_CORMON').AsString;
end;

function TFormulaAutomotivaAutoluks.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaAutomotivaAutoluks.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaAutomotivaAutoluks.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaAutomotivaAutoluks.GetNomeTabelaBases: String;
begin
  Result := 'ALK_CADBAS';
end;

Procedure TFormulaAutomotivaAutoluks.pPreencherPesCorFor(const dtsCadTin: IDataSet);
begin
  Self.PesoCor := 0;
  Self.PesoFor := 0;
end;

{$IFNDEF LINUX}
procedure TFormulaAutomotivaAutoluks.pRecalculaFormulaMostrarDigitado(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; fltFator: Double;
  blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha, strTipBas: String);
begin
  inherited;
  Begin
    lsvFormulacao.Items.Add.Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    lsvFormulacao.Items[intCont].SubItems.Add(strTipBas);
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(TAutcomTintaFactory.Get.fFormataFloat(Base.QuantidadeConcentrado * fltFator, 1), ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(TAutcomTintaFactory.Get.fFormataFloat(Base.QuantidadeDiluido * fltFator, 1), ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(TAutcomTintaFactory.Get.fFormataFloat(Base.QuantidadeDiluido2 * fltFator, 1), ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;

procedure TFormulaAutomotivaAutoluks.pRecalculaFormulaMostrarPadrao(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; blnConsLinhaDesBas: Boolean;
  strTipBas: String; intCont: Integer);
begin
  inherited;
  Begin
    lsvFormulacao.Items.Add.Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    lsvFormulacao.Items[intCont].SubItems.Add(strTipBas);
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(TAutcomTintaFactory.Get.fFormataFloat(Base.QuantidadeConcentrado, 1), ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(TAutcomTintaFactory.Get.fFormataFloat(Base.QuantidadeDiluido, 1), ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(TAutcomTintaFactory.Get.fFormataFloat(Base.QuantidadeDiluido2, 1), ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

function TFormulaAutomotivaAutoluks.GetPrefixoFormulacao: String;
begin
  Result := 'ALK_BASE';
end;

function TFormulaAutomotivaAutoluks.GetPrefixoLitragem(
  const strModo: String): String;
begin
  Result := 'ALK_VOLUME';
end;

function TFormulaAutomotivaAutoluks.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'ALK_QTDC';
end;

function TFormulaAutomotivaAutoluks.GetProdutoVendaTinta(const dtsCadTin: IDataSet): string;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('ALK').fGet('ALKPRO');
end;

function TFormulaAutomotivaAutoluks.GetQuantidadeFormulacao: Integer;

begin
  Result := 20;
end;

function TFormulaAutomotivaAutoluks.GetSelectBases: String;
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

function TFormulaAutomotivaAutoluks.GetTextoInformativoCalculo: String;
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

function TFormulaAutomotivaAutoluks.GetUniversal(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaAutoluks.GetVolumeMaximoGalao(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 4.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('ALK').fGetDouble('GALVOL'), 3);
end;

function TFormulaAutomotivaAutoluks.GetVolumeMaximoLata(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('ALK').fGetDouble('LATVOL'), 3);
end;

function TFormulaAutomotivaAutoluks.GetVolumeMaximoLitro(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 1.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('ALK').fGetDouble('LITVOL'), 3);
end;

function TFormulaAutomotivaAutoluks.GetVolumePadraCopo: Double;
begin
  Result := 0;
end;


function TFormulaAutomotivaAutoluks.GetVolumePadraGalao(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 3.600;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('ALK').fGetDouble('GALVOL'), 3);
end;

function TFormulaAutomotivaAutoluks.GetVolumePadraoLata(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('ALK').fGetDouble('LATVOL'), 3);
end;

function TFormulaAutomotivaAutoluks.GetVolumePadraSpray: Double;
begin
  Result := 0;
end;


function TFormulaAutomotivaAutoluks.GetVolumePadraTambor(dtsCadTin: IDataSet): Double;
begin
  Result := 0;
end;

function TFormulaAutomotivaAutoluks.GetVolumePermitido(
  const dtsCadTin: IDataSet; strTipoPre: String): Double;
begin
  Result := 0;
end;

procedure TFormulaAutomotivaAutoluks.IniciaArrMinMax();
Var
  intContador: Integer;
begin
  SetLength(arrMinMax, Self.ListaAdicional.Count);

  If Self.ListaAdicional.Count <= 0 Then
    Exit;

  For intContador := 0 To Self.ListaAdicional.Count - 1 Do
  Begin
    arrMinMax[intContador].fltMin := 54;
    arrMinMax[intContador].fltMax := 54;
  End;
end;

procedure TFormulaAutomotivaAutoluks.pAtualizaPorcentagem(
  const formula: TAbstractFormulaAutomotiva; dtsCadTin: IDataSet);
begin
  If (formula.ListaAdicional.Count <= 0) Then
    Exit;

  If (dtsCadTin.FieldByName('ALK_PRODUT').AsString = 'ATL SINTETICO') Then
    Exit;

  formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltMax;

  If Length(arrMinMax) > 0 Then
  Begin
    If arrMinMax[Formula.IndiceAdicional].fltMax = arrMinMax[Formula.IndiceAdicional].fltMin Then
      Formula.HabDil := False;
  End;
end;

procedure TFormulaAutomotivaAutoluks.pDefineVolumeOriginal;
begin
  If Self.mveModoVenda = mvConcentrado Then
    Self.VolumeOri := Self.VolumeConcentrado
  Else
    Self.VolumeOri := Self.VolumeDiluido;
end;

procedure TFormulaAutomotivaAutoluks.pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet);
var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('ALK');


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
    pReformulaNovo(ListaAdicional[0], '54', dtsCadTin);
end;

procedure TFormulaAutomotivaAutoluks.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('ALK_ACRMOB').AsFloat;
end;

procedure TFormulaAutomotivaAutoluks.PreencheQuantidadeFormulacaoVenda(
  const dtsCadTin: IDataSet);
var
  intContador: Integer;
  Base       : TBaseAutomotiva;
begin
  For intContador := 1 To Self.GetQuantidadeFormulacao Do
  Begin

    If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('ALK_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
      Break;

    Base             := TBaseAutomotiva(Self.Add);
    Base.CodigoBase  := trim(dtsCadTin.FieldByName('ALK_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString);
    Base.QuantidadeConcentrado := dtsCadTin.FieldByName('ALK_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
    Base.TipoBase   := 'B';
  End;
end;

procedure TFormulaAutomotivaAutoluks.PreencheVolumeVenda(const dtsCadTin: IDataSet);
begin
  Self.VolumeOri         := dtsCadTin.FieldByName('ALK_VOLUME').AsFloat / 1000;
  Self.VolumeConcentrado := dtsCadTin.FieldByName('ALK_VOLUME').AsFloat / 1000;
  Self.VolumeDiluido     := dtsCadTin.FieldByName('ALK_VOLUME').AsFloat / 1000;
end;

procedure TFormulaAutomotivaAutoluks.pReformulaNovo(strCodDil,
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

  fltDiluicao, fltParteDiluida,
  fltParteCatalizador, fltParteTinta: Double;
  fltRedutor: Double;
begin
  If (dtsCadTin.FieldByName('ALK_PRODUT').AsString = 'ATL SINTETICO') Then
    Exit;

  Try
    fltDiluicao := 0.54;

    qryGen := TAutcomTintaFactory.Get.fGetDataSet;

    strSQL := '';
    strSQL := strSQL + '  SELECT                  ';
    strSQL := strSQL + '    *                     ';
    strSQL := strSQL + '  FROM                    ';
    strSQL := strSQL + '    ALK_CADBAS B          ';
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

    fltVolumeTotal := fCalculaVolumeTotal;

    fltDesOpeTinta := TAutcomTintaFactory.Get.fGetConfTinta('ALK').fGetDouble('DESOPE');

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

    fltPreCus := 0;
    fltPreVen := 0;

    If fEItemPromocao(qryGen, fltPreVen, fltPreCus) Then
    Begin
      Diluente.PrecoCusto := fltPreCus;
      Diluente.PrecoVenda := fltPreVen;

      If strTabPre = strTabPreTin Then
          Self.Promoc := 'S';

      If Diluente.PrecoCusto = 0 Then
        Diluente.PrecoCusto := qryGen.FieldByName('ITE_PRECUS').AsFloat;
    End;


    If dtsCadTin.FieldByName('ALK_PRODUT').AsString = 'ATL PU' Then
    Begin
      fltParteCatalizador := fltVolumeTotal / 4;
      fltParteDiluida := fltVolumeTotal / 4;
      fltRedutor := TAutcomTintaFactory.Get.fFormataFloat((fltVolumeTotal - fltParteCatalizador - fltParteDiluida) / fltVolumeTotal, 7);
      Diluente.QuantidadeDiluido := fltParteDiluida * diluente.PesoEspecifico;
    End
    Else If dtsCadTin.FieldByName('ALK_PRODUT').AsString = 'ATL PU FROTA' Then
    Begin
      fltParteCatalizador := fltVolumeTotal / 4.5;
      fltParteDiluida := fltVolumeTotal / 9;
      fltRedutor := TAutcomTintaFactory.Get.fFormataFloat((fltVolumeTotal - fltParteCatalizador - fltParteDiluida) / fltVolumeTotal, 7);
      Diluente.QuantidadeDiluido := fltParteDiluida * diluente.PesoEspecifico;
    End
    Else
    Begin
      fltParteCatalizador := 0;
      fltParteTinta := TAutcomTintaFactory.Get.fFormataFloat(fltVolumeTotal / (1 + fltParteCatalizador + (fltDiluicao * (1 + fltParteCatalizador))), 4);
      fltParteDiluida := TAutcomTintaFactory.Get.fFormataFloat((fltParteTinta + fltParteCatalizador) * fltDiluicao, 4);
      fltRedutor := 0.6493507;
      Diluente.QuantidadeDiluido := fltParteDiluida * Diluente.PesoEspecifico;
    End;

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
        Bases.QuantidadeDiluido := (Bases.QuantidadeConcentrado *  fltRedutor);
    End;
  Except
    On E: Exception Do
    Begin
      Raise;
    End;
  End;
end;

end.
