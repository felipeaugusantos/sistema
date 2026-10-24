{************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula FarbenAutomotiva *}
{*********************************************************************AC*}
unit untFormulaAutomotivaFarbenAutomotiva;

interface

uses
{$IFNDEF LINUX}
  Controls,
  ComCtrls,
{$ENDIF}
  untAbstractFormulaAutomotiva, untICalculadorFormulaAutomotiva, untIDataSet, untBaseAutomotiva,
  SysUtils, untStrUtils, Classes, untIConfTinta, untFloatUtils, untModoVenda,
  untIDicionario, System.StrUtils, untVariantUtils, untITintaDeMaquinaComponente, System.Variants,
  untTintaDeMaquinaComponenteComparerEmbalagemAutomotiva, untGenericTintaDeMaquinaComponente,
  untTintaDeMaquinaComponenteTipo;

type
  TMinMax = record
    fltMin : Double;
    fltMax : Double;
end;


type
  TFormulaAutomotivaFarbenAutomotiva = class(TAbstractFormulaAutomotiva)
  private
    arrMinMax: Array Of TMinMax;
    function fArredondaValor(fltValor: Double; intCasas: Integer): Double;
    function fRetornaFatorDensidade(strTipPrg: String; fltQtdCon, fltPesEsp: Double): Double;
    function fRetornaTotalDensidade(strTipPrg: String; fltPorcen, fltDensid: Double): Double;
    function fCasasDecimaisQtd(strTipPrg: String): Integer;
    function fRetornarDensidade(strCodBas : String) : Double;

  protected
    function GetCalculadorInterno(): ICalculadorFormulaAutomotiva; override;
    function GetTextoInformativoCalculo(): String; override;
    procedure CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva); override;
    function GetNomeCampoCustoBase: String; override;
    function GetNomeCampoVendaBase: String; override;
    function GetNomeTabelaBases: String; override;
    function GetNomeCampoBaseCodIte: String; override;
    function GetSelectBases: String; override;
  public
    function GetPrefixoQuantidade(const strModo: String): String; override;
    function GetPrefixoLitragem(const strModo: String): String; override;
    function GetQuantidadeFormulacao(): Integer; override;
    function GetCodNovaFormula(): String; override;
    function GetPrefixoFormulacao(): String; override;
    procedure RecalcularTabelasGeneric(dicRetorno: IDicionario); Override;
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

    function GetChaForEspecifico(const dicRetorno: IDicionario;
      const dtsCadTin: IDataSet): String; override;

  {$IFNDEF LINUX}
    procedure pRecalculaFormulaMostrarPadrao(var lsvFormulacao: TListView;
      Base: TBaseAutomotiva; intDecimaisPrecoVenda, intDecimaisPesoEspecifico: Integer;
      blnConsLinhaDesBas: Boolean; strTipBas: String; intCont: Integer); override;
  {$ENDIF}

  {$IFNDEF LINUX}
    procedure pRecalculaFormulaMostrarDigitado(var lsvFormulacao: TListView; Base: TBaseAutomotiva;
      intDecimaisPrecoVenda, intDecimaisPesoEspecifico: Integer; fltFator: Double; blnConsLinhaDesBas: Boolean;
      intCont: Integer; strLinha: String; strTipBas: String); override;
  {$ENDIF}

    function GetVolumeMaximoLitro(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoGalao(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoLata(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoTambor(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoCopo(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoSpray(dtsCadTin: IDataSet): Double; Override;

    function GetVolumePadraGalao(dtsCadTin: IDataSet): Double;  override;
    function GetVolumePadraoLata(dtsCadTin: IDataSet): Double; override;
    function fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer; dtsCadTin: IDataSet): Double; override;

    function fExisteConfiguracao(dtsCadTin: IDataSet; strEmbalagem: String): Boolean; Override;
    procedure pAtualizaPorcentagem(const formula: TAbstractFormulaAutomotiva;  dtsCadTin: IDataSet = Nil); Override;
    procedure pReformulaNovo(strCodDil:String; strPercentual:String = '10'; const dtsCadTin: IDataSet = Nil); Override;
    procedure IniciaArrMinMax;
    function fGetDiluentes(const dtsCadTin: IDataSet): TStringList; Override;
    function SetItemIndexLinuxDiluente(const dtsCadTin: IDataSet; ListaAdicional: TStringList): Integer; Override;

    function GetUsaChapinha(const dtsCadTin: IDataSet): Boolean; Override;
    function GetProdutoChapinha(): String; Override;
    procedure pCalculaImpostosSaida(Var dicRetorno: IDicionario); Override;
  end;

implementation

uses
  untAbstractCalculadorFormulaAutomotiva, untAutcomTintaFactory;

{ TFormulaAutomotivaFarbenAutomotiva }

procedure TFormulaAutomotivaFarbenAutomotiva.CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva);
begin
  Base.Cnv_Ml := Base.Embalagem * Base.PesoEspecifico;
end;

function TFormulaAutomotivaFarbenAutomotiva.fArredondaValor(fltValor: Double;
  intCasas: Integer): Double;
begin
  Result := TAutcomTintaFactory.Get.fStrToFloat(FormatFloat('0.' + TStrUtils.fStrZero(0, intCasas), fltValor));
end;

function TFormulaAutomotivaFarbenAutomotiva.fCasasDecimaisQtd(
  strTipPrg: String): Integer;
begin
  Result := 5;
end;

function TFormulaAutomotivaFarbenAutomotiva.fExisteConfiguracao(
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
    qryConf.SQL := qryConf.SQL + '    CFG_IDEPRO = "FAR" AND          ';
    qryConf.SQL := qryConf.SQL + '    CFG_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" AND          ';

    If strEmbalagem = 'Litro' THen
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLLIT"       '
    Else If strEmbalagem = 'Galão' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLGAL"       '
    Else If strEmbalagem = 'Lata' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLLAT"       '
    Else If strEmbalagem = 'Copo' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLCOP"       '
    Else If strEmbalagem = 'Tambor' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLTAM"       '
    Else If strEmbalagem = 'Spray' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLSPR"       ';

    qryConf.Open;

    Result := (Not qryConf.IsEmpty);
  Except
    Raise;
  End;
end;

function TFormulaAutomotivaFarbenAutomotiva.fGetDiluentes(
  const dtsCadTin: IDataSet): TStringList;
Var
  qryGen: IDataSet;
begin
  Self.ListaAdicional.Clear;

  Result := TStringList.Create;

  If (dtsCadTin.FieldByName('FAR_LINHA_').AsString <> 'PE') And
    (dtsCadTin.FieldByName('FAR_TIPPRG').AsString <> '3') Then
    Exit;

  If (dtsCadTin.FieldByName('FAR_LINHA_').AsString <> 'PE') And
    (dtsCadTin.FieldByName('FAR_TIPPRG').AsString = '3') Then
    Exit;

  If (dtsCadTin.FieldByName('FAR_LINHA_').AsString = 'PE') And
    (dtsCadTin.FieldByName('FAR_TIPPRG').AsString <> '3') Then
    Exit;

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '   SELECT * FROM FAR_CADBAS B   ';
  qryGen.SQL := qryGen.SQL + '  INNER JOIN CADITE I ON  ';
  qryGen.SQL := qryGen.SQL + '    B.BAS_CODITE = I.ITE_CODITE   ';
  qryGen.SQL := qryGen.SQL + '  INNER JOIN ITEGER G ON  ';
  qryGen.SQL := qryGen.SQL + '    I.ITE_CODITE = G.ITE_CODITE AND   ';
  qryGen.SQL := qryGen.SQL + '    G.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '"  ';
  qryGen.SQL := qryGen.SQL + '  WHERE BAS_CODBAS IN ("558.400", "558.000")    ';
  qryGen.Open;



  While Not qryGen.Eof Do
  Begin
    Result.Add(qryGen.FieldByName('BAS_CODBAS').AsString);
    qryGen.Next;
  End;

  If Result.Count > 0 Then
  Begin
    Self.pReformulaNovo(Result[0], '80', dtsCadTin);
    Self.blnDadosAdicionais := True;
    Self.strCaptionAdicional := 'Diluentes';
    Self.blnAdicionalDiluido := True;
  End;
end;

function TFormulaAutomotivaFarbenAutomotiva.fMostrarComCatalisador: Boolean;
begin
  Result := False;
end;

function TFormulaAutomotivaFarbenAutomotiva.fRetornaFatorDensidade(
  strTipPrg: String; fltQtdCon, fltPesEsp: Double): Double;
begin
  Result := fltQtdCon / fltPesEsp;

 { If MatchStr(strTipPrg, ['1', '2']) Then
    Result := fTruncaValor(fltQtdCon / fltPesEsp, 2);}

end;

function TFormulaAutomotivaFarbenAutomotiva.fRetornarDensidade(strCodBas: String): Double;
var
  qryGen: IDataSet;
begin

 qryGen := nil;
  Result := 0;
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DENSID '+
                    '  FROM FAR_CADBAS '+
                    ' WHERE BAS_CODBAS = :CODBAS';
      qryGen.ParamByName('CODBAS').AsString := strCodBas;
      qryGen.Open;

      Result := qryGen.FieldByName('BAS_DENSID').AsFloat;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

function TFormulaAutomotivaFarbenAutomotiva.fRetornaTotalDensidade(
  strTipPrg: String; fltPorcen, fltDensid: Double): Double;
begin
  Result := fltPorcen / fltDensid;

  {If MatchStr(strTipPrg, ['1', '2']) Then
    Result := fTruncaValor(fltPorcen / fltDensid, 2);  }

end;

function TFormulaAutomotivaFarbenAutomotiva.fValidaVolumeFormulucao(strTipoPre: String;
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaFarbenAutomotiva.fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer;
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 0.900;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('FAR').fGetDouble('VOLLIT'), 3);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetAcrescimoDespesaOperacionalTinta: Double;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('FAR').fGetDouble('DESOPE');
end;

function TFormulaAutomotivaFarbenAutomotiva.GetAno(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('FAR_A_N_O_').AsString;
end;

function TFormulaAutomotivaFarbenAutomotiva.GetCalcDespesasOperacionais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  fltVenBas := (fltQtdFor * base.PrecoVenda / base.Cnv_Ml);

  Result := (fltVenBas * base.DespesasOperacionais / 100);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetCalcIcmsSaida(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  fltVenBas := (fltQtdFor * base.PrecoVenda / base.Cnv_Ml);

  Result := (fltVenBas * base.IcmsSaida / 100);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetCalcImpostosFederais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  fltVenBas := (fltQtdFor * base.PrecoVenda / base.Cnv_Ml);

  Result := (fltVenBas * base.ImpostosFederais / 100);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetCalcOutrosValores(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  Result := (fltQtdFor * base.OutrosValores / base.Cnv_Ml);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  Result := (fltQtdFor * base.PrecoCompraLiquido / base.Cnv_Ml);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetCalcPrecoCusto(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  Result := (fltQtdFor * base.PrecoCusto / base.Cnv_Ml);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetCalcPrecoCustoReal(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  Result := (fltQtdFor * base.PrecoCustoReal / base.Cnv_Ml);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetCalcPrecoMedio(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  Result := (fltQtdFor * base.PrecoMedio / base.Cnv_Ml);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetCalcPrecoVenda(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  Result := (fltQtdFor * base.PrecoVenda / base.Cnv_Ml);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetCalcQuantidade(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido)
             * formula.VolumePro / formula.VolumeOri,3);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetCalculadorInterno: ICalculadorFormulaAutomotiva;
begin
  Result := TAbstractCalculadorFormulaAutomotiva.Create(Self);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  Result := (fltQtdFor * base.UltimoPrecoCompra / base.Cnv_Ml);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  Result := (fltQtdFor * base.UltimoPrecoCompraImpostos / base.Cnv_Ml);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetChaForEspecifico(
  const dicRetorno: IDicionario; const dtsCadTin: IDataSet): String;
begin
  Result := '';
end;


function TFormulaAutomotivaFarbenAutomotiva.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('FAR_MD5KEY').AsString;
end;

function TFormulaAutomotivaFarbenAutomotiva.GetCodFormul(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaFarbenAutomotiva.GetCodNovaFormula: String;
begin
  Result := 'FAR_CODNFM';
end;

function TFormulaAutomotivaFarbenAutomotiva.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('FAR_DESCRI').AsString;
end;

function TFormulaAutomotivaFarbenAutomotiva.GetDescricaoBase(strCodBas: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DESCRI '+
                    '  FROM FAR_CADBAS '+
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

function TFormulaAutomotivaFarbenAutomotiva.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaAutomotivaFarbenAutomotiva.GetIdePro: String;
begin
  Result := 'FAR';
end;

function TFormulaAutomotivaFarbenAutomotiva.GetIndEmb(
  const dtsCadTin: IDataSet): integer;
begin
  Result := -1;
end;

function TFormulaAutomotivaFarbenAutomotiva.GetMontadora(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('FAR_DESMON').AsString;
end;

function TFormulaAutomotivaFarbenAutomotiva.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaAutomotivaFarbenAutomotiva.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaAutomotivaFarbenAutomotiva.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaAutomotivaFarbenAutomotiva.GetNomeTabelaBases: String;
begin
  Result := 'FAR_CADBAS';
end;

function TFormulaAutomotivaFarbenAutomotiva.GetPrefixoFormulacao: String;
begin
  Result := 'FAR_CODB';
end;

function TFormulaAutomotivaFarbenAutomotiva.GetPrefixoLitragem(
  const strModo: String): String;
begin
    Result := '';
end;

function TFormulaAutomotivaFarbenAutomotiva.GetPrefixoQuantidade(const strModo: String): String;
begin
  If strModo = 'C' Then
    Result := 'FAR_QTDC'
  Else
    Result := 'FAR_QTDD';
end;

function TFormulaAutomotivaFarbenAutomotiva.GetProdutoChapinha: String;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('FAR').fGet('PROCHA');
end;

function TFormulaAutomotivaFarbenAutomotiva.GetProdutoVendaTinta(const dtsCadTin: IDataSet): string;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('FAR').fGet('FARPRO');
end;

function TFormulaAutomotivaFarbenAutomotiva.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaAutomotivaFarbenAutomotiva.GetSelectBases: String;
begin
  Result := ' SELECT         ' +
            '     BAS_CODBAS ' +
            '   , BAS_CODITE ' +
            '   , BAS_EMBALA ' +
            '   , BAS_DESCRI ' +
            '   , BAS_DENSID AS BAS_PESESP ' +
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

function TFormulaAutomotivaFarbenAutomotiva.GetTextoInformativoCalculo: String;
begin
  Result :=
    'VolumeFormula  = VolumeDigitado' + sLineBreak +
    'Valor da Base  = (Qtde. Concentrado * Preço) / (Embalagem * Peso Específico)'+ sLineBreak +
    'Preço da Tinta = Soma(Valores de Base) * Volume Produzido / VolumeFormula';
end;

function TFormulaAutomotivaFarbenAutomotiva.GetUniversal(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaFarbenAutomotiva.GetUsaChapinha(
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := (dtsCadTin.FieldByName('FAR_PROCHA').AsString = 'S');
end;

function TFormulaAutomotivaFarbenAutomotiva.GetVolumeMaximoCopo(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Copo') Then
  Begin
    Result := 0.500;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('FAR').fGetDouble('VOLCOP'), 3);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetVolumeMaximoGalao(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 4.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('FAR').fGetDouble('VOLGAL'), 3);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetVolumeMaximoLata(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('FAR').fGetDouble('VOLLAT'), 3);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetVolumeMaximoLitro(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 1.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('FAR').fGetDouble('VOLLIT'), 3);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetVolumeMaximoSpray(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Spray') Then
  Begin
    Result := 0.400;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('FAR').fGetDouble('VOLSPR'), 3);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetVolumeMaximoTambor(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Tambor') Then
  Begin
    Result := 200.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('FAR').fGetDouble('VOLTAM'), 3);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetVolumePadraCopo: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Copo') Then
  Begin
    Result := 0.450;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('FAR').fGetDouble('VOLCOP'), 3);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetVolumePadraGalao(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 3.600;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('FAR').fGetDouble('VOLGAL'), 3);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetVolumePadraoLata(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('FAR').fGetDouble('VOLLAT'), 3);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetVolumePadraSpray: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Spray') Then
  Begin
    Result := 0.400;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('FAR').fGetDouble('VOLSPR'), 3);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetVolumePadraTambor(dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Tambor') Then
  Begin
    Result := 200.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('FAR').fGetDouble('VOLTAM'), 3);
end;

function TFormulaAutomotivaFarbenAutomotiva.GetVolumePermitido(
  const dtsCadTin: IDataSet; strTipoPre: String): Double;
begin
  Result := 0;
end;

procedure TFormulaAutomotivaFarbenAutomotiva.IniciaArrMinMax;
Var
  intContador: Integer;
begin
  SetLength(arrMinMax, Self.ListaAdicional.Count);

  For intContador := 0 To Self.ListaAdicional.Count - 1 Do
  Begin
    arrMinMax[intContador].fltMin := 80;
    arrMinMax[intContador].fltMax := 100;
  End;
end;

procedure TFormulaAutomotivaFarbenAutomotiva.pAtualizaPorcentagem(
  const formula: TAbstractFormulaAutomotiva;  dtsCadTin: IDataSet);
begin
  If (dtsCadTin.FieldByName('FAR_LINHA_').AsString <> 'PE') And
    (dtsCadTin.FieldByName('FAR_TIPPRG').AsString <> '3') Then
    Exit;

  If (dtsCadTin.FieldByName('FAR_LINHA_').AsString <> 'PE') And
    (dtsCadTin.FieldByName('FAR_TIPPRG').AsString = '3') Then
    Exit;

  If (dtsCadTin.FieldByName('FAR_LINHA_').AsString = 'PE') And
    (dtsCadTin.FieldByName('FAR_TIPPRG').AsString <> '3') Then
    Exit;

  If Formula.ListaAdicional.Count <= 0 Then
    Exit;

  If Formula.PorDil > arrMinMax[Formula.IndiceAdicional].fltMax Then
    Formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltMax;

  If Formula.PorDil < arrMinMax[Formula.IndiceAdicional].fltMin Then
    Formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltMin;

  Formula.HabDil := True;
end;

procedure TFormulaAutomotivaFarbenAutomotiva.pCalculaImpostosSaida(
  var dicRetorno: IDicionario);
var
  componente: ITintaDeMaquinaComponente;
  strNomeProd: String;
begin
  SetQtdEmb(TVariantUtils.IfNull(dicRetorno['qtdemb'], 1));

  tintaDeMaquina[mvConcentrado].SetQuantidade(intQtdEmb);
  tintaDeMaquina[mvDiluido].SetQuantidade(intQtdEmb);

  strNomeProd := VarToStrDef(TAutcomTintaFactory.Get.GetValorCampo('SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE', 'ITE_DESITE', [strCodEmb]), '');

  componente := tintaDeMaquina[mvConcentrado].Localizar(TTintaDeMaquinaComponenteComparerEmbalagemAutomotiva.Create(strCodEmb));
  if not Assigned(componente) then
  begin
    componente := tintaDeMaquina[mvConcentrado].Adicionar(TGenericTintaDeMaquinaComponente.Create(
      strCodEmb, strNomeProd, EmbDespesasOperacionais, EmbIcmsSaida,
      EmbImpostosFederais, EmbOutrosValores, EmbPrecoCusto, EmbPrecoCustoReal, EmbPrecoMedio,
      EmbPrecoVenda, intQtdEmb, tmctEmbalagemAutomotiva
    ));

    tintaDeMaquina[mvDiluido].Adicionar(componente);
  end;

  componente.Quantidade                := intQtdEmb;
  componente.CodIte                    := strCodEmb;
  componente.PrecoCusto                := EmbPrecoCusto;
  componente.PrecoVenda                := EmbPrecoVenda;
  componente.PrecoCustoReal            := EmbPrecoCustoReal;
  componente.Descricao                 := strNomeProd;
  componente.PrecoMedio                := EmbPrecoMedio;
  componente.Tipo                      := tmctEmbalagemAutomotiva;
  componente.IcmsSaida                 := EmbIcmsSaida;
  componente.OutrosValores             := EmbOutrosValores;
  componente.ImpostosFederais          := EmbImpostosFederais;
  componente.DespesasOperacionais      := EmbDespesasOperacionais;
  componente.UltimoPrecoCompraImpostos := EmbPrecoUltimaCompraImpostos;

  if dicRetorno['tippre'] = 'C' then
  begin
    dicRetorno['outval'] := OutrosValoresCon;
    dicRetorno['icmsai'] := IcmsSaidaCon;
    dicRetorno['impfed'] := ImpostosFederaisCon;
    dicRetorno['desope'] := DespesasOperacionaisCon;
  end
  else
  begin
    dicRetorno['outval'] := OutrosValoresDil;
    dicRetorno['icmsai'] := IcmsSaidaDil;
    dicRetorno['impfed'] := ImpostosFederaisDil;
    dicRetorno['desope'] := DespesasOperacionaisDil;
  end;


  If Not Self.UsaChapinha Then
  Begin
    AcertaImpostos(
      dicRetorno['outval'] + EmbOutrosValores,
      dicRetorno['icmsai'] + EmbIcmsSaida,
      dicRetorno['impfed'] + EmbImpostosFederais,
      dicRetorno['desope'] + EmbDespesasOperacionais,
      dicRetorno);
  End
  Else
  Begin
    AcertaImpostos(
      dicRetorno['outval'] + EmbOutrosValores + ChaOutrosValores,
      dicRetorno['icmsai'] + EmbIcmsSaida + ChaIcmsSaida,
      dicRetorno['impfed'] + EmbImpostosFederais + ChaImpostosFederais,
      dicRetorno['desope'] + EmbDespesasOperacionais + ChaDespesasOperacionais,
      dicRetorno);
  End;
end;

procedure TFormulaAutomotivaFarbenAutomotiva.pDefineVolumeOriginal;
begin
  If Self.mveModoVenda = mvConcentrado then
    Self.VolumeOri := Self.VolumeConcentrado
  Else
    Self.VolumeOri := Self.VolumeDiluido;
end;

procedure TFormulaAutomotivaFarbenAutomotiva.pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet);
var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('FAR');

  stlDesEmb.Clear;
  DesEmb.Add('NORMAL');

  IniciaArrMinMax;

  ProEmbLt.Add(conf.fGet('FARPLT'));
  ProEmbGl.Add(conf.fGet('FARPGL'));
  ProEmbLa.Add(conf.fGet('FARPSP'));

  strProEmbCo := conf.fGet('FARPCP');
  strProEmbTb := conf.fGet('FARPTB');
  strProEmbSp := conf.fGet('FARPSY');

  If ListaAdicional.Count > 0 Then
    pReformulaNovo(ListaAdicional[0], '80', dtsCadTin);
end;

procedure TFormulaAutomotivaFarbenAutomotiva.pPreencherPesCorFor(const dtsCadTin: IDataSet);
begin
  self.PesoCor := 0;
  self.PesoFor := 0;
end;

{$IFNDEF LINUX}
procedure TFormulaAutomotivaFarbenAutomotiva.pRecalculaFormulaMostrarDigitado(Var lsvFormulacao: TListView; Base: TBaseAutomotiva;
  intDecimaisPrecoVenda, intDecimaisPesoEspecifico: Integer; fltFator: Double; blnConsLinhaDesBas: Boolean;
  intCont: Integer; strLinha: String; strTipBas: String);
begin
  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado * fltFator, ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(Base.QuantidadeDiluido * fltFator, ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(Base.QuantidadeDiluido2, ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TFormulaAutomotivaFarbenAutomotiva.pRecalculaFormulaMostrarPadrao(Var lsvFormulacao: TListView; Base: TBaseAutomotiva;
  intDecimaisPrecoVenda, intDecimaisPesoEspecifico: Integer; blnConsLinhaDesBas: Boolean; strTipBas: String; intCont: Integer);
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


procedure TFormulaAutomotivaFarbenAutomotiva.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('FAR_ACRMOB').AsFloat;
end;

procedure TFormulaAutomotivaFarbenAutomotiva.PreencheQuantidadeFormulacaoVenda(
  const dtsCadTin: IDataSet);
var
  intContador        : Integer;
  Base               : TBaseAutomotiva;
  fltFatorDensidade  : Double;
  fltTotalDensidade  : Double;
  fltTotalPorcentagem: Double;
  blnNovaFormula     : Boolean;
begin
  For intContador := 1 To Self.GetQuantidadeFormulacao Do
  Begin

    If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
      Break;

    Base := TBaseAutomotiva(self.Add);
    Base.CodigoBase            := dtsCadTin.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString;
    Base.QuantidadeConcentrado := TFloatUtils.fFormataFloat(dtsCadTin.FieldByName('FAR_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat,3);
    Base.QuantidadeDiluido     := TFloatUtils.fFormataFloat(dtsCadTin.FieldByName('FAR_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat,3);
    Base.TipoBase := 'B';
  End;

  blnNovaFormula := Pos('ESP', dtsCadTin.FieldByName('FAR_CODNFM').AsString) > 0;


  If Not blnNovaFormula Then
  begin
    fltTotalPorcentagem := 0;
    fltTotalDensidade   := 0;

    For intContador := 1 To Self.GetQuantidadeFormulacao Do
    begin
      If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
        Break;

        {FATOR DA DENSIDADE}
      Try
        fltFatorDensidade :=  fRetornaFatorDensidade(dtsCadTin.FieldByName('FAR_TIPPRG').AsString
                                                    , dtsCadTin.FieldByName('FAR_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat
                                                    , fRetornarDensidade(dtsCadTin.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString));
      Except
        fltFatorDensidade :=  1;
      End;

        {SOMATORIO DA PORCENTAGEM}
      fltTotalPorcentagem := fltTotalPorcentagem + dtsCadTin.FieldByName('FAR_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

        {SOMATORIO DA DENSIDADE}
      fltTotalDensidade := fltTotalDensidade + fltFatorDensidade;

    end;

    Try
      fltTotalDensidade := fRetornaTotalDensidade(dtsCadTin.FieldByName('FAR_TIPPRG').AsString
                                                , fltTotalPorcentagem
                                                , fltTotalDensidade);
    Except
      fltTotalDensidade := 1;
    End;


    For intContador := 1 To Self.GetQuantidadeFormulacao Do
    Begin
      If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
        Break;

      Base := TBaseAutomotiva(self.Items[intContador-1]);

      Base.QuantidadeConcentrado := fArredondaValor(0.900 * fltTotalDensidade *
                                                      (dtsCadTin.FieldByName('FAR_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat / 100) * 1000,
                                                       fCasasDecimaisQtd(dtsCadTin.FieldByName('FAR_TIPPRG').AsString));
    End;

    fltTotalPorcentagem := 0;
    fltTotalDensidade   := 0;


    For intContador := 1 To Self.GetQuantidadeFormulacao Do
    Begin
      If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
        Break;

      {FATOR DA DENSIDADE}
      fltFatorDensidade := dtsCadTin.FieldByName('FAR_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat
          / fRetornarDensidade(dtsCadTin.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString);
      {SOMATORIO DA PORCENTAGEM}
      fltTotalPorcentagem :=
        fltTotalPorcentagem + dtsCadTin.FieldByName('FAR_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

      {SOMATORIO DA DENSIDADE}
      fltTotalDensidade := fltTotalDensidade + fltFatorDensidade;
    End;

    Try
      fltTotalDensidade := fltTotalPorcentagem / fltTotalDensidade;
    Except
      fltTotalDensidade := 1;
    End;

    For intContador := 1 To 20 Do
    Begin
      If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
        Break;

      Base := TBaseAutomotiva(self.Items[intContador-1]);
      Base.QuantidadeDiluido :=
        fArredondaValor(0.900 * fltTotalDensidade * (dtsCadTin.FieldByName('FAR_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat / 100) * 1000, 5);
    End;
  End;
end;

procedure TFormulaAutomotivaFarbenAutomotiva.PreencheVolumeVenda(const dtsCadTin: IDataSet);
begin
  Self.VolumeOri         := 0.9;
  Self.VolumeConcentrado := 0.9;
  Self.VolumeDiluido     := 0.9;
end;

procedure TFormulaAutomotivaFarbenAutomotiva.pReformulaNovo(strCodDil,
  strPercentual: String; const dtsCadTin: IDataSet);
Var
  intContador          : Integer;
  Bases                : TBaseAutomotiva;
  fltFatorPorcentagem  : Double;
  fltFatorDensidade  : Double;
  fltTotalDensidade  : Double;
  fltTotalPorcentagem: Double;
  blnNovaFormula     : Boolean;
  Diluente           : TBaseAutomotiva;
  fltDesOpeTinta     : Double;
  qryGen             : IDataSet;
  fltPreCus, fltPreVen: Double;

  fltPeso: Double;
  fltPesoTotal: Double;
  blnEmPromo: Boolean;
  blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
begin
  Try
    If (dtsCadTin.FieldByName('FAR_LINHA_').AsString <> 'PE') And
      (dtsCadTin.FieldByName('FAR_TIPPRG').AsString <> '3') Then
      Exit;

    If (dtsCadTin.FieldByName('FAR_LINHA_').AsString <> 'PE') And
      (dtsCadTin.FieldByName('FAR_TIPPRG').AsString = '3') Then
      Exit;

    If (dtsCadTin.FieldByName('FAR_LINHA_').AsString = 'PE') And
    (dtsCadTin.FieldByName('FAR_TIPPRG').AsString <> '3') Then
    Exit;

    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.Close;
    qryGen.SQL := '';
    qryGen.SQL := qryGen.SQL + '  SELECT                ';
    qryGen.SQL := qryGen.SQL + '    *                   ';
    qryGen.SQL := qryGen.SQL + '  FROM                  ';
    qryGen.SQL := qryGen.SQL + '    FAR_CADBAS B        ';
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

    fltFatorPorcentagem := 100 + StrToFloat(strPercentual);

    For intContador := Self.Count - 1 DownTo 0 Do
    Begin
      Bases := (Self.Items[intContador] As TBaseAutomotiva);
      Bases.QuantidadeDiluido := dtsCadTin.FieldByName('FAR_QTDC' + TStrUtils.fStrZero(intContador + 1, 2)).AsFloat * 100 / fltFatorPorcentagem;
    End;


    blnNovaFormula := Pos('ESP', dtsCadTin.FieldByName('FAR_CODNFM').AsString) > 0;

    If Not blnNovaFormula Then
    Begin
      fltTotalPorcentagem := 0;
      fltTotalDensidade   := 0;
      fltPesoTotal := 0;

      For intContador := 1 To Self.GetQuantidadeFormulacao Do
      Begin
        If TStrUtils.fEmptyStr(dtsCadTin.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
          Break;

        {FATOR DENSIDADE}
        fltFatorDensidade := TFloatUtils.fFormataFloat(dtsCadTin.FieldByName('FAR_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat * 100 / fltFatorPorcentagem, 4);


        fltPeso :=  TFloatUtils.fFormataFloat(fltFatorDensidade / fRetornarDensidade(dtsCadTin.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString), 4);

        {SOMATORIA PORCENTAGEM}
        fltTotalPorcentagem := fltTotalPorcentagem + TFloatUtils.fFormataFloat(dtsCadTin.FieldByName('FAR_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat * 100 / fltFatorPorcentagem, 2);

        {SOMATORIA DENSIDADE}
        fltTotalDensidade := fltTotalDensidade + fltFatorDensidade;
        fltPesoTotal := fltPesoTotal + fltPeso;
      End;

      {SOMATORIA DENSIDADE + DEN. DILUENTE}
        fltFatorDensidade := TFloatUtils.fFormataFloat(StrToFloat(strPercentual) * 100 / fltFatorPorcentagem, 4);
        fltPesoTotal := fltPesoTotal + (fltFatorDensidade / fRetornarDensidade(strCodDil));

      Try
        fltTotalDensidade := fRetornaTotalDensidade(dtsCadTin.FieldByName('FAR_TIPPRG').AsString
                                                , 100
                                                , fltPesoTotal);
      Except
        fltTotalDensidade := 1;
      End;

      For intContador := 1 To Self.GetQuantidadeFormulacao Do
      Begin
        If TStrUtils.fEmptyStr(dtsCadTin.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
          Break;

        Bases := TBaseAutomotiva(Self.Items[intContador - 1]);
        Bases.QuantidadeDiluido := 0.900 * fltTotalDensidade * (dtsCadTin.FieldByName('FAR_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat / fltFatorPorcentagem) * 1000;
      End;

      For intContador := Self.Count - 1 DownTo 0 Do
      Begin
        Bases := (Self.Items[intContador] As TBaseAutomotiva);
        If Bases.TipoBase <> 'B' Then
          Self.Delete(intContador);
      End;

      fltDesOpeTinta := TAutcomTintaFactory.Get.fGetConfTinta('FAR').fGetDouble('DESOPE');

      Diluente := (Self.Add As TBaseAutomotiva);
      Diluente.CodigoBase := strCodDil;
      Diluente.TipoBase := 'D';
      Diluente.PesoEspecifico := qryGen.FieldByName('BAS_DENSID').AsFloat;
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
    End;
  Except
    On E: Exception Do
    Begin
      Raise;
    End;
  End;
end;

procedure TFormulaAutomotivaFarbenAutomotiva.RecalcularTabelasGeneric(
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
      Self.pCarregaPrecoChapinha(Self.strTabPre);

      If dicRetorno['tippre'] = 'C' Then
      Begin
        If PrecoVendaCon > 0 Then
        Begin
          If TAutcomTintaFactory.Get.fGetConfTinta(GetIdePro).fGet('ACRMOB') = '1' Then
            dicRetorno['preve' + IntToStr(intContador)] := (PrecoVendaCon + EmbPrecoVenda) * (1 + AcrMob / 100)
          Else
            dicRetorno['preve' + IntToStr(intContador)] := PrecoVendaCon + EmbPrecoVenda + AcrMob;

          If Self.UsaChapinha Then
            dicRetorno['preve' + IntToStr(intContador)] := dicRetorno['preve' + IntToStr(intContador)] + ChaPrecoVenda;

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

          If Self.UsaChapinha Then
            dicRetorno['preve' + IntToStr(intContador)] := dicRetorno['preve' + IntToStr(intContador)] + ChaPrecoVenda;

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

function TFormulaAutomotivaFarbenAutomotiva.SetItemIndexLinuxDiluente(
  const dtsCadTin: IDataSet; ListaAdicional: TStringList): Integer;
begin
  {$IFDEF LINUX}
    Result := ListaAdicional.IndexOf(Self.DilLinux);

    If Result = -1 Then
      Result := 0;
  {$ELSE}
    Result := 0;
  {$ENDIF}
end;

end.

