{************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula Standox *}
{*********************************************************************AC*}
unit untFormulaAutomotivaStandox;

interface

uses
{$IFNDEF LINUX}
  Controls,
  ComCtrls,
{$ENDIF}
  untAbstractFormulaAutomotiva, untICalculadorFormulaAutomotiva, untIDataSet, untBaseAutomotiva,
  SysUtils, untStrUtils, Classes, untIConfTinta, untFloatUtils, untModoVenda,
  untIDicionario, System.StrUtils, untITintaDeMaquinaComponente, System.Variants,
  untTintaDeMaquinaComponenteComparerEmbalagemAutomotiva, untGenericTintaDeMaquinaComponente,
  untTintaDeMaquinaComponenteTipo, untVariantUtils;


type
  TMinMax = record
    fltMin : Double;
    fltMax : Double;
  end;

type
  TFormulaAutomotivaStandox = class(TAbstractFormulaAutomotiva)
  private
    arrMinMax: Array Of TMinMax;

  protected
    function GetCalculadorInterno(): ICalculadorFormulaAutomotiva; override;
    function GetTextoInformativoCalculo(): String; override;
    procedure CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva); override;
    function GetNomeCampoCustoBase: String; override;
    function GetNomeCampoVendaBase: String; override;
    function GetNomeTabelaBases: String; override;
    function GetNomeCampoBaseCodIte: String; override;
    function GetSelectBases: String; override;
    function GetBasPesGra(const dataSetBases: IDataSet): String; override;
  public
    function GetPrefixoQuantidade(const strModo: String): String; override;
    function GetPrefixoLitragem(const strModo: String): String; override;
    function GetQuantidadeFormulacao(): Integer; override;
    function GetCodNovaFormula(): String; override;
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
    procedure pRecalculaFormulaMostrarDigitado(var lsvFormulacao: TListView;
      Base: TBaseAutomotiva; intDecimaisPrecoVenda, intDecimaisPesoEspecifico: Integer;
      fltFator: Double; blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha: String;
      strTipBas: String); override;
  {$ENDIF}

    procedure IniciaArrMinMax;

    procedure pReformulaNovo(strCodDil:String; strPercentual:String = '10'; const dtsCadTin: IDataSet = Nil); override;
    function fRetQtdDiluente(strCodDil: String; strPercentual:String = '0' ): Double; override;
    function fGetDiluentes(const dtsCadTin: IDataSet): TStringList; override;
    procedure pAtualizaPorcentagem(const formula: TAbstractFormulaAutomotiva;  dtsCadTin: IDataSet = Nil); override;

    function GetVolumeMaximoLitro(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoGalao(dtsCadTin: IDataSet): Double; Override;
    function fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer; dtsCadTin: IDataSet): Double; override;
    function GetVolumePadraGalao(dtsCadTin: IDataSet): Double; override;

    function fExisteConfiguracao(dtsCadTin: IDataSet; strEmbalagem: String): Boolean; Override;
    function GetUsaChapinha(const dtsCadTin: IDataSet): Boolean; Override;
    function GetProdutoChapinha(): String; Override;
    procedure pCalculaImpostosSaida(Var dicRetorno: IDicionario); Override;
end;

implementation

uses
  untAbstractCalculadorFormulaAutomotiva, untAutcomTintaFactory;

{ TFormulaAutomotivaStandox }

procedure TFormulaAutomotivaStandox.CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva);
Var
  dicDados: IDicionario;
begin

  dicDados := TAutcomTintaFactory.Get.GetDicionario;
  dicDados['preven'] := base.PrecoVenda;
  dicDados['precus'] := base.PrecoCusto;
  dicDados['outval'] := base.OutrosValores;
  dicDados['icmsai'] := base.IcmsSaida;
  dicDados['impfed'] := base.ImpostosFederais;
  dicDados['desope'] := base.DespesasOperacionais;



  Base.PrecoCustoReal := TAutcomTintaFactory.Get.fCalculaPrecoCusto2(dicDados);


  If dataSetBases.FieldByName('BAS_PESGRA').AsString = 'S' Then
    Base.Cnv_Ml := Base.Embalagem
  Else
    Base.Cnv_Ml  := Base.Embalagem / Base.PesoEspecifico;
end;

function TFormulaAutomotivaStandox.fExisteConfiguracao(dtsCadTin: IDataSet;
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
    qryConf.SQL := qryConf.SQL + '    CFG_IDEPRO = "DOX" AND          ';
    qryConf.SQL := qryConf.SQL + '    CFG_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" AND        ';

    If strEmbalagem = 'Litro' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "DOXVLT"     '
    Else If strEmbalagem = 'Galão' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "DOXVGL"     ';

    qryConf.Open;

    Result := (Not qryConf.IsEmpty);
  Except
    Raise;
  End;
end;

function TFormulaAutomotivaStandox.fGetDiluentes(
  const dtsCadTin: IDataSet): TStringList;
Var
  qryGen: IDataSet;
begin
  Self.ListaAdicional.Clear;


  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT DISTINCT                                    ' +
                '   *                                                ' +
                ' FROM                                               ' +
                '   DOX_CADBAS B                                     ' +
                '   INNER JOIN DOX_CADDIL D                          ' +
                '     ON D.DIL_CODDIL = B.BAS_CODBAS                 ';
  qryGen.Open;

  Result := TStringList.Create;

  While Not qryGen.Eof Do
  Begin
    Result.Add(qryGen.FieldByName('BAS_CODBAS').AsString);
    qryGen.Next;
  End;

  If Result.Count > 0 Then
  Begin
    Self.pReformulaNovo(Result[0]);
    Self.blnDadosAdicionais := True;
    Self.strCaptionAdicional := 'Diluentes';
    Self.blnAdicionalDiluido := True;
  End;
end;

function TFormulaAutomotivaStandox.fMostrarComCatalisador: Boolean;
begin
  Result := False;
end;


function TFormulaAutomotivaStandox.fRetQtdDiluente(strCodDil,
  strPercentual: String): Double;
begin
  Result := 0;
  If strCodDil = 'MSB 10-20' Then
  Begin
    Result := 291.7;
  End
  Else If strCodDil = 'MSB 15-25' Then
  Begin
    Result := 283.3;
  End
  Else If strCodDil = 'MSB 25-35' Then
  Begin
    Result := 289.7;
  End
  Else If strCodDil = 'STBLCOATA' Then
  Begin
    Result := TAutcomTintaFactory.Get.IIF(strPercentual = '10', 92.7, 170.0);
  End
  Else If strCodDil = 'STBLADJSL' Then
  Begin
    Result := TAutcomTintaFactory.Get.IIF(strPercentual = '10', 92.7, 170.0);
  End;
end;

function TFormulaAutomotivaStandox.fValidaVolumeFormulucao(strTipoPre: String;
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaStandox.fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer;
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 0.900;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DOX').fGetDouble('DOXVLT'), 3);
end;

function TFormulaAutomotivaStandox.GetAcrescimoDespesaOperacionalTinta: Double;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('DOX').fGetDouble('DESOPE');
end;

function TFormulaAutomotivaStandox.GetAno(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('DOX_ANOINI').AsString;
end;

function TFormulaAutomotivaStandox.GetBasPesGra(
  const dataSetBases: IDataSet): String;
begin
  Result := dataSetBases.FieldByName('BAS_PESGRA').AsString;
end;

function TFormulaAutomotivaStandox.GetCalcDespesasOperacionais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  If Base.PesGra = 'S' Then
    fltVenBas := (fltQtdFor * (Base.PrecoVenda / Base.Embalagem))
  Else
    fltVenBas := (fltQtdFor * (Base.PrecoVenda / Base.Embalagem / Base.PesoEspecifico));

  Result := (fltVenBas * base.DespesasOperacionais / 100);
end;

function TFormulaAutomotivaStandox.GetCalcIcmsSaida(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);


  If Base.PesGra = 'S' Then
    fltVenBas := (fltQtdFor * (Base.PrecoVenda / Base.Embalagem))
  Else
    fltVenBas := (fltQtdFor * (Base.PrecoVenda / Base.Embalagem / Base.PesoEspecifico));

  Result := (fltVenBas * base.IcmsSaida / 100);
end;

function TFormulaAutomotivaStandox.GetCalcImpostosFederais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  If Base.PesGra = 'S' Then
    fltVenBas := (fltQtdFor * (Base.PrecoVenda / Base.Embalagem))
  Else
    fltVenBas := (fltQtdFor * (Base.PrecoVenda / Base.Embalagem / Base.PesoEspecifico));

  Result := (fltVenBas * base.ImpostosFederais / 100);
end;

function TFormulaAutomotivaStandox.GetCalcOutrosValores(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  If Base.PesGra = 'S' Then
      Result := (fltQtdFor * base.OutrosValores / base.Embalagem)
  Else
    Result := (fltQtdFor * base.OutrosValores / base.Embalagem / Base.PesoEspecifico);
end;

function TFormulaAutomotivaStandox.GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * (formula.VolumePro / formula.VolumeOri),3);

  If Base.PesGra = 'S' Then
    Result := (fltQtdFor * base.PrecoCompraLiquido / base.Embalagem)
  Else
    Result := (fltQtdFor * base.PrecoCompraLiquido / base.Embalagem / base.PesoEspecifico);
end;

function TFormulaAutomotivaStandox.GetCalcPrecoCusto(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  If Base.PesGra = 'S' Then
    Result  := (fltQtdFor * (Base.PrecoCusto / Base.Embalagem))
  Else
    Result  := (fltQtdFor * (Base.PrecoCusto / Base.Embalagem / Base.PesoEspecifico));
end;

function TFormulaAutomotivaStandox.GetCalcPrecoCustoReal(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  If Base.PesGra = 'S' Then
    Result  := (fltQtdFor * (Base.PrecoCustoReal / Base.Embalagem))
  Else
    Result  := (fltQtdFor * (Base.PrecoCustoReal / Base.Embalagem / Base.PesoEspecifico));
end;

function TFormulaAutomotivaStandox.GetCalcPrecoMedio(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  If Base.PesGra = 'S' Then
    Result := (fltQtdFor * base.PrecoMedio / Base.Embalagem)
  Else
    Result := (fltQtdFor * base.PrecoMedio / base.Embalagem / base.PesoEspecifico);
end;

function TFormulaAutomotivaStandox.GetCalcPrecoVenda(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  If Base.PesGra = 'S' Then
    Result  := (fltQtdFor * (Base.PrecoVenda / Base.Embalagem))
  Else
    Result  := (fltQtdFor * (Base.PrecoVenda / Base.Embalagem / Base.PesoEspecifico));
end;

function TFormulaAutomotivaStandox.GetCalcQuantidade(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido)
             * formula.VolumePro / formula.VolumeOri,3);
end;

function TFormulaAutomotivaStandox.GetCalculadorInterno: ICalculadorFormulaAutomotiva;
begin
  Result := TAbstractCalculadorFormulaAutomotiva.Create(Self);
end;

function TFormulaAutomotivaStandox.GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  If Base.PesGra = 'S' Then
    Result := (fltQtdFor * base.UltimoPrecoCompra / Base.Embalagem)
  Else
    Result := (fltQtdFor * base.UltimoPrecoCompra / base.Embalagem / base.PesoEspecifico);
end;

function TFormulaAutomotivaStandox.GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri,3);

  If Base.PesGra = 'S' Then
    Result := (fltQtdFor * base.UltimoPrecoCompraImpostos / Base.Embalagem)
  Else
    Result := (fltQtdFor * base.UltimoPrecoCompraImpostos / Base.Embalagem / base.PesoEspecifico);
end;

function TFormulaAutomotivaStandox.GetChaForEspecifico(
  const dicRetorno: IDicionario; const dtsCadTin: IDataSet): String;
begin
  Result := '';
end;


function TFormulaAutomotivaStandox.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('DOX_MD5KEY').AsString;
end;

function TFormulaAutomotivaStandox.GetCodFormul(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaStandox.GetCodNovaFormula: String;
begin
  Result := 'DOX_CODNFM';
end;

function TFormulaAutomotivaStandox.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('DOX_DESCRI').AsString;
end;

function TFormulaAutomotivaStandox.GetDescricaoBase(strCodBas: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DESBAS '+
                    '  FROM DOX_CADBAS '+
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

function TFormulaAutomotivaStandox.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaAutomotivaStandox.GetIdePro: String;
begin
  Result := 'DOX';
end;

function TFormulaAutomotivaStandox.GetIndEmb(
  const dtsCadTin: IDataSet): integer;
begin
  Result := -1;
end;

function TFormulaAutomotivaStandox.GetMontadora(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('DOX_MONTAD').AsString;
end;

function TFormulaAutomotivaStandox.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaAutomotivaStandox.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaAutomotivaStandox.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaAutomotivaStandox.GetNomeTabelaBases: String;
begin
  Result := 'DOX_CADBAS';
end;

function TFormulaAutomotivaStandox.GetPrefixoFormulacao: String;
begin
  Result := 'DOX_BASE';
end;

function TFormulaAutomotivaStandox.GetPrefixoLitragem(
  const strModo: String): String;
begin
    Result := '';
end;

function TFormulaAutomotivaStandox.GetPrefixoQuantidade(const strModo: String): String;
begin
    Result := 'DOX_QTDC'
end;

function TFormulaAutomotivaStandox.GetProdutoChapinha: String;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('DOX').fGet('PROCHA');
end;

function TFormulaAutomotivaStandox.GetProdutoVendaTinta(const dtsCadTin: IDataSet): string;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('DOX').fGet('PRODOX');
end;

function TFormulaAutomotivaStandox.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaAutomotivaStandox.GetSelectBases: String;
begin
  Result := ' SELECT         ' +
            '     BAS_CODBAS ' +
            '   , BAS_CODITE ' +
            '   , BAS_EMBALA ' +
            '   , BAS_DESBAS ' +
            '   , BAS_PESESP ' +
            '   , BAS_PESGRA ' +
            '   , IFNULL(ITE_ITEATI, "N") ITE_ITEATI ' +
            '   , ITE_CNV_ML ' +
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

  If (TAutcomTintaFactory.Get.fCfgSis('PREGER') <> '0') Then
  Begin
    Result := Result + '    , ITE_ICMSAI  ';
    Result := Result + '    , ITE_IMPFED  ';
    Result := Result + '    , ITE_DESOPE  ';
    Result := Result + '    , ITE_OUTVAL  ';
  End
  Else
  Begin
    Result := Result + '    , 0 AS ITE_ICMSAI ';
    Result := Result + '    , 0 AS ITE_IMPFED ';
    Result := Result + '    , 0 AS ITE_DESOPE ';
    Result := Result + '    , 0 AS ITE_OUTVAL ';
  End;


end;

function TFormulaAutomotivaStandox.GetTextoInformativoCalculo: String;
begin
  Result :=
    'VolumeFormula  = ' + FloatToStrF(Self.VolumePro, ffFixed, 12, 4) + sLineBreak +
    'Valor da Base "Gramas" = (Preço / Embalagem)' + sLineBreak +
    'Valor da Base "MLs" = (Preço / Embalagem / Peso Específico' + sLineBreak +
    'Preço da Tinta = Soma do Valor da Base de todas as bases';
end;

function TFormulaAutomotivaStandox.GetUniversal(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaStandox.GetUsaChapinha(
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := (dtsCadTin.FieldByName('DOX_PROCHA').AsString = 'S');
end;

function TFormulaAutomotivaStandox.GetVolumeMaximoGalao(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 4.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DOX').fGetDouble('DOXVGL'), 3);
end;

function TFormulaAutomotivaStandox.GetVolumeMaximoLitro(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 1.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DOX').fGetDouble('DOXVLT'), 3);
end;

function TFormulaAutomotivaStandox.GetVolumePadraCopo: Double;
begin
  Result := 0.450;
end;

function TFormulaAutomotivaStandox.GetVolumePadraGalao(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 3.600;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DOX').fGetDouble('DOXVGL'), 3);
end;

function TFormulaAutomotivaStandox.GetVolumePadraSpray: Double;
begin
  Result := 0.400;
end;

function TFormulaAutomotivaStandox.GetVolumePadraTambor(dtsCadTin: IDataSet): Double;
begin
  Result := 200.000;
end;

function TFormulaAutomotivaStandox.GetVolumePermitido(
  const dtsCadTin: IDataSet; strTipoPre: String): Double;
begin
  Result := 0;
end;

procedure TFormulaAutomotivaStandox.IniciaArrMinMax;
Var
  intContador: Integer;
begin
  SetLength(arrMinMax, Self.ListaAdicional.Count);

  If Self.ListaAdicional.Count <= 0 Then
    Exit;

  For intContador := 0 To Self.ListaAdicional.Count - 1 Do
  Begin
    arrMinMax[intContador].fltMin := 10;
    arrMinMax[intContador].fltMax := 20;
  End;
end;

procedure TFormulaAutomotivaStandox.pAtualizaPorcentagem(
  const formula: TAbstractFormulaAutomotiva;  dtsCadTin: IDataSet);
begin

  If (formula.ListaAdicional.Count <= 0) Then
    Exit;

  If formula.PorDil > arrMinMax[formula.IndiceAdicional].fltMax Then
    formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltMax;

  If Length(arrMinMax) > 0 Then
  Begin
    If arrMinMax[Formula.IndiceAdicional].fltMax = arrMinMax[Formula.IndiceAdicional].fltMin Then
      formula.HabDil := False
    Else
      formula.HabDil := true;

    If formula.PorDil > arrMinMax[Formula.IndiceAdicional].fltMax Then
      formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltMax;

    If formula.PorDil < arrMinMax[Formula.IndiceAdicional].fltMin Then
      formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltMin;

    If (Formula.IndiceAdicional <> 3) And (Formula.IndiceAdicional <> 4) Then
      Formula.PorDil := 0.00;

  End;
end;

procedure TFormulaAutomotivaStandox.pCalculaImpostosSaida(
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

procedure TFormulaAutomotivaStandox.pDefineVolumeOriginal;
begin
  If Self.mveModoVenda = mvConcentrado then
    Self.VolumeOri := Self.VolumeConcentrado
  Else
    Self.VolumeOri := Self.VolumeDiluido;
end;

procedure TFormulaAutomotivaStandox.pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet);
var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('DOX');

  stlDesEmb.Clear;
  DesEmb.Add('NORMAL');

  IniciaArrMinMax;

  ProEmbLt.Add(conf.fGet('DOXPLT'));
  ProEmbGl.Add(conf.fGet('DOXPGL'));

  If ListaAdicional.Count > 0 Then
    pReformulaNovo(ListaAdicional[0]);
end;

procedure TFormulaAutomotivaStandox.pPreencherPesCorFor(const dtsCadTin: IDataSet);
begin
  self.PesoCor := 0;
  self.PesoFor := 0;
end;

{$IFNDEF LINUX}
procedure TFormulaAutomotivaStandox.pRecalculaFormulaMostrarDigitado(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; fltFator: Double;
  blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha: String;
  strTipBas: String);
begin
  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    SubItems.Add(FloatToStrF(TFloatUtils.fFormataFloat(Base.QuantidadeConcentrado * fltFator, 3), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(TFloatUtils.fFormataFloat(Base.QuantidadeDiluido * fltFator,3), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(TFloatUtils.fFormataFloat(Base.QuantidadeDiluido2,3), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TFormulaAutomotivaStandox.pRecalculaFormulaMostrarPadrao(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; blnConsLinhaDesBas: Boolean;
  strTipBas: String; intCont: Integer);
begin
  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    SubItems.Add(FloatToStrF(TFloatUtils.fFormataFloat(Base.QuantidadeConcentrado,3), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(TFloatUtils.fFormataFloat(Base.QuantidadeDiluido,3), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(TFloatUtils.fFormataFloat(Base.QuantidadeDiluido2,3), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}


procedure TFormulaAutomotivaStandox.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('DOX_ACRMOB').AsFloat;
end;

procedure TFormulaAutomotivaStandox.PreencheQuantidadeFormulacaoVenda(
  const dtsCadTin: IDataSet);
var
  intContador        : Integer;
  Base               : TBaseAutomotiva;

begin
  For intContador := 1 To Self.GetQuantidadeFormulacao Do
  Begin

    If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('DOX_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
      Break;

    Base := TBaseAutomotiva(self.Add);
    Base.CodigoBase            := dtsCadTin.FieldByName('DOX_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString;
    Base.QuantidadeConcentrado := TFloatUtils.fFormataFloat(dtsCadTin.FieldByName('DOX_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat,3);
    Base.TipoBase := 'B';
  End;
end;

procedure TFormulaAutomotivaStandox.PreencheVolumeVenda(const dtsCadTin: IDataSet);
begin
  Self.VolumeOri         := 1;
  Self.VolumeConcentrado := 1;
  Self.VolumeDiluido     := 1;
end;

procedure TFormulaAutomotivaStandox.pReformulaNovo(strCodDil: String;
  strPercentual:String; const dtsCadTin: IDataSet);
Var
  intContador: Integer;
  qryGen: IDataSet;
  diluente: TBaseAutomotiva;
  Bases: TBaseAutomotiva;
  fltVolumeAtual: Double;
  fltDesOpeTinta: Double;
  dicDados: IDicionario;
begin
  qryGen := Nil;
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL :=
        ' SELECT DISTINCT                                      ' +
        '   *                                                  ' +
        ' FROM                                                 ' +
        '   DOX_CADBAS B                                       ' +
        '   INNER JOIN DOX_CADDIL D                            ' +
        '     ON D.DIL_CODDIL = B.BAS_CODBAS                   ' +
        '   INNER JOIN ITEGER I ON I.ITE_CODITE = B.BAS_CODITE ' +
        '                      AND I.ITE_CODEMP = B.BAS_CODEMP ' +
        '   INNER JOIN CADITE G ON I.ITE_CODITE = G.ITE_CODITE ' +
        ' WHERE BAS_CODBAS = :CODBAS                           ';

    qryGen.ParamByName('CODBAS').AsString := strCodDil;
    qryGen.Open;

    If qryGen.IsEmpty Then
      Exit;

    fltVolumeAtual := 0;

    For intContador := Self.Count - 1 Downto 0 Do
    Begin
      Bases := (Self.Items[intContador] As TBaseAutomotiva);
      If Bases.TipoBase <> 'B' Then
        Self.Delete(intContador)
      Else
        fltVolumeAtual := fltVolumeAtual + (Bases.QuantidadeConcentrado / Bases.PesoEspecifico);
    End;

    fltDesOpeTinta := TAutcomTintaFactory.Get().fGetConfTinta(GetIdePro).fGetDouble('DESOPE');

    Diluente := (Self.Add as TBaseAutomotiva);
    Diluente.CodigoBase := strCodDil;
    Diluente.TipoBase := 'D';
    Diluente.PesoEspecifico := qryGen.FieldByName('BAS_PESESP').AsFloat;
    Diluente.QuantidadeDiluido := fRetQtdDiluente(strCodDil, strPercentual);
    Diluente.PrecoVenda := qryGen.FieldByName('ITE_PREVE' + Self.strTabPre).AsFloat;
    Diluente.PrecoCusto := qryGen.FieldByName('ITE_PRECUS').AsFloat;
    Diluente.IcmsSaida := qryGen.FieldByName('ITE_ICMSAI').AsFloat;
    Diluente.ImpostosFederais := qryGen.FieldByName('ITE_IMPFED').AsFloat;
    Diluente.DespesasOperacionais := qryGen.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;
    Diluente.UltimoPrecoCompra := qryGen.FieldByName('ITE_PREULT').AsFloat;
    Diluente.UltimoPrecoCompraImpostos := qryGen.FieldByName('ITE_IMPULT').AsFloat;
    Diluente.Embalagem := qryGen.FieldByName('BAS_EMBALA').AsFloat;
    Diluente.PrecoMedio := qryGen.FieldByName('ITE_PREMED').AsFloat;
    Diluente.OutrosValores := qryGen.FieldByName('ITE_OUTVAL').AsFloat;
    Diluente.CodIte := qryGen.FieldByName('BAS_CODITE').AsString;
    Diluente.ImpDir := qryGen.FieldByName('ITE_IMPDIR').AsString;
    Diluente.PesGra := qryGen.FieldByName('BAS_PESGRA').AsString;

    dicDados := TAutcomTintaFactory.Get.GetDicionario;
    dicDados := TAutcomTintaFactory.Get.GetDicionario;
    dicDados['preven'] := Diluente.PrecoVenda;
    dicDados['precus'] := Diluente.PrecoCusto;
    dicDados['outval'] := Diluente.OutrosValores;
    dicDados['icmsai'] := Diluente.IcmsSaida;
    dicDados['impfed'] := Diluente.ImpostosFederais;
    dicDados['desope'] := Diluente.DespesasOperacionais;

    Diluente.PrecoCustoReal := TAutcomTintaFactory.Get.fCalculaPrecoCusto2(dicDados);


    For intContador := Self.Count - 1 Downto 0 Do
    Begin
      Bases := (Self.Items[intContador] As TBaseAutomotiva);

      If Bases.TipoBase <> 'D' Then
      Begin
        Bases.QuantidadeDiluido := (Bases.QuantidadeConcentrado / Bases.PesoEspecifico);
        Bases.QuantidadeDiluido := ((Bases.QuantidadeDiluido * 1000) / fltVolumeAtual);

        If ((strCodDil =  'STBLCOATA') Or (strCodDil =  'STBLADJSL')) Then
        Begin
          Bases.QuantidadeDiluido := ((Bases.QuantidadeDiluido * 1000) / TAutcomTintaFactory.Get.IIF(strPercentual = '10', 1100, 1200));
        End
        Else
        Begin
          Bases.QuantidadeDiluido := ((Bases.QuantidadeDiluido * 1000) / 1500);
        End;

        Bases.QuantidadeDiluido := TAutcomTintaFactory.Get.fFormataFloat((Bases.QuantidadeDiluido * Bases.PesoEspecifico), 1);
      End;
    End;
  Except
    On E: Exception Do
      Raise;
  End;
end;

end.
