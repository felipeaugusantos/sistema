{************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula Duxone22   *}
{*********************************************************************AC*}
unit untFormulaAutomotivaDuxone2;

interface

uses
{$IFNDEF LINUX}
  Controls,
  ComCtrls,
{$ENDIF}
  untAbstractFormulaAutomotiva, untICalculadorFormulaAutomotiva, untIDataSet, untBaseAutomotiva,
  SysUtils, untStrUtils, Classes, untIConfTinta, untFloatUtils, untModoVenda,
  Math, untIDicionario, untVariantUtils, untITintaDeMaquinaComponente, System.Variants,
  untTintaDeMaquinaComponenteComparerEmbalagemAutomotiva, untGenericTintaDeMaquinaComponente,
  untTintaDeMaquinaComponenteTipo;

type
  TMinMax = record
    fltMin : Double;
    fltMax : Double;
end;

type
  TFormulaAutomotivaDuxone2 = class(TAbstractFormulaAutomotiva)
  private
    arrMinMax: Array Of TMinMax;
    function fRetPesoEsp(strCodBas: String): Double;
  protected
    function GetCalculadorInterno(): ICalculadorFormulaAutomotiva; override;
    function GetTextoInformativoCalculo(): String; override;
    procedure CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva); override;
    function GetNomeCampoCustoBase: String; override;
    function GetNomeCampoVendaBase: String; override;
    function GetNomeTabelaBases: String; override;
    function GetNomeCampoBaseCodIte: String; override;
    function GetSelectBases: String; override;
    function GetBasesPorEmpresa(const dicRetorno: IDicionario): String; override;
    function GetBasPesGra(const dataSetBases: IDataSet): String; override;
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
    function GetVolumePadraSpray: Double; override;
    function GetVolumePadraTambor(dtsCadTin: IDataSet): Double; override;
    function GetVolumePadraCopo : Double;  override;

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
    function GetQualidade(const dtsCadTin: IDataSet): String; override;
    function GetChaFor(const dtsCadTin: IDataSet): String; override;
    function fTipoEmbalagem(intIndEmb: Integer; strQualid: String): Boolean; override;
    function fMostrarComCatalisador: Boolean; override;

    function fQuantidadeMenorIgualZero: Boolean; override;
    function fVolumeOriginalFator: Boolean; override;

    procedure pPreencherPesCorFor(const dtsCadTin: IDataSet); override;

    function GetUniversal(const dtsCadTin: IDataSet): string; override;
    function GetLinha(const dtsCadTin: IDataSet): string; override;
    function fGetFormulaEspecial(strCodigo: String) : Boolean;


    function fRetornaCatalisadorVenda(blnComCat: Boolean; strTipPre,
      strListaAdicional: String): String; override;

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


    function GetVolumePadraoLata(dtsCadTin: IDataSet): Double; override;
    function fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer; dtsCadTin: IDataSet): Double; override;
    function GetVolumePadraGalao(dtsCadTin: IDataSet): Double;  override;
    function GetVolumePadraoBalde(dtsCadTin: IDataSet): Double; override;
    function GetVolumePadraoSpraySint : Double;  override;
    function GetVolumePadraoSprayDuco : Double; override;
    function GetVolumePadraoSprayPoli : Double; override;

    function GetVolumeMaximoLitro(dtsCadTin: IDataSet): Double; override;
    function GetVolumeMaximoGalao(dtsCadTin: IDataSet): Double; override;
    function GetVolumeMaximoLata(dtsCadTin: IDataSet): Double; override;
    function GetVolumeMaximoBalde(dtsCadTin: IDataSet): Double; override;
    function GetVolumeMaximoCopo(dtsCadTin: IDataSet): Double; override;
    function GetVolumeMaximoTambor(dtsCadTin: IDataSet): Double; override;
    function GetVolumeMaximoSpraySint(dtsCadTin: IDataSet): Double; override;
    function GetVolumeMaximoSprayPoli(dtsCadTin: IDataSet): Double; override;
    function GetVolumeMaximoSprayDuco(dtsCadTin: IDataSet): Double; override;
    function fExisteConfiguracao(dtsCadTin: IDataSet; strEmbalagem: String): Boolean; Override;

    function fRetQtdDiluente(fltVolumePro: Double; strCodDil: String; strPercentual:String = '54'; fltPesoEspecifico: Double = 0): Double; Reintroduce;
    function fGetDiluentes(const dtsCadTin: IDataSet): TStringList; Override;
    procedure pReformulaNovo(strCodDil:String; strPercentual:String = '10'; const dtsCadTin: IDataSet = Nil); override;
    procedure IniciaArrMinMax(const dtsCadTin: IDataSet);
    procedure pAtualizaPorcentagem(const formula: TAbstractFormulaAutomotiva; dtsCadTin: IDataSet = Nil); override;
    function SetItemIndexLinuxDiluente(const dtsCadTin: IDataSet; ListaAdicional: TStringList): Integer; Override;
    function GetUsaChapinha(const dtsCadTin: IDataSet): Boolean; Override;
    function GetProdutoChapinha(): String; Override;
    procedure pCalculaImpostosSaida(Var dicRetorno: IDicionario); Override;
  end;

implementation

uses
  untAbstractCalculadorFormulaAutomotiva, untAutcomTintaFactory ;

{ TFormulaAutomotivaDuxone2 }

procedure TFormulaAutomotivaDuxone2.CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva);
begin
  If dataSetBases.FieldByName('BAS_PESGRA').AsString = 'S' Then
    Base.Cnv_Ml := Base.Embalagem
  Else
    Base.Cnv_Ml := Base.Embalagem / Base.PesoEspecifico;
end;

function TFormulaAutomotivaDuxone2.fExisteConfiguracao(dtsCadTin: IDataSet;
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
    qryConf.SQL := qryConf.SQL + '    CFG_IDEPRO = "DU2" AND          ';
    qryConf.SQL := qryConf.SQL + '    CFG_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" AND          ';

    If strEmbalagem = 'Litro' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOL1_4"     '
    Else If strEmbalagem = 'Galão' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLGAL"     '
    Else If strEmbalagem = 'Lata' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLLAT"     '
    Else If strEmbalagem = 'Copo' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLCOP"     '
    Else If strEmbalagem = 'Spray Duco' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLSDU"     '
    Else If strEmbalagem = 'Spray Poli' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLSPO"     '
    Else If strEmbalagem = 'Spray Sint' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLSPS"     '
    Else If strEmbalagem = 'Balde' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLBAL"     '
    Else If strEmbalagem = 'Tambor' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLTAM"     ';

    qryConf.Open;

    Result := (Not qryConf.IsEmpty);
  Except
    Raise;
  End;
end;

function TFormulaAutomotivaDuxone2.fGetDiluentes(
  const dtsCadTin: IDataSet): TStringList;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '   SELECT * FROM DU2_CADBAS    ';
  qryGen.SQL := qryGen.SQL + '  WHERE BAS_CODBAS IN ("DX32", "DX34")    ';
  qryGen.Open;

  Result := TStringList.Create;

  While Not qryGen.Eof Do
  Begin
    Result.Add(qryGen.FieldByName('BAS_CODBAS').AsString);
    qryGen.Next;
  End;

  If Result.Count > 0 Then
  Begin
    Self.pReformulaNovo(Result[0], TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGet('MINDIL'), dtsCadTin);
    Self.blnDadosAdicionais := True;
    Self.strCaptionAdicional := 'Diluentes';
    Self.blnAdicionalDiluido := True;
  End;
end;

function TFormulaAutomotivaDuxone2.fGetFormulaEspecial(strCodigo: String): Boolean;
begin
  Result := Pos('ESP',strCodigo) > 0;
end;

function TFormulaAutomotivaDuxone2.fMostrarComCatalisador: Boolean;
begin
  Result := False;
end;

function TFormulaAutomotivaDuxone2.fQuantidadeMenorIgualZero: Boolean;
var
  intContador: Integer;
  Base: TBaseAutomotiva;
  fltFator: Double;
  strOperadorLiberou: String;
begin
  Result := False;

  strOperadorLiberou := '';

  If mveModoVenda = mvConcentrado Then
  Begin
    If Self.VolumePro < 0.05 Then
    Begin
      TAutcomTintaFactory.Get.fMensagem('AVISO', 'Volume mínimo concentrado permitido para a tinta Duxone2 Global é 0,050 ml!', ['&Ok']);
      Result := True;
      Exit;
    End;
  End
  Else
  Begin
    If Self.VolumePro < 0.1 Then
    Begin
      TAutcomTintaFactory.Get.fMensagem('AVISO', 'Volume mínimo diluído permitido para a tinta Duxone2 Global é 0,100 ml!', ['&Ok']);
      Result := True;
      Exit;
    End;
  End;

  If Self.VolumeOri > 0 Then
    fltFator := Self.VolumePro / Self.VolumeOri
  Else
    fltFator := 1;

  If Self.fVolumeOriginalFator Then
    fltFator := fltFator * 1000;


  For intContador := 0 To Self.Count-1 Do
  Begin
    Base := TBaseAutomotiva(Self.Items[intContador]);

    If ((mveModoVenda = mvConcentrado) And (Base.TipoBase = 'B') And
        (Base.QuantidadeConcentrado * fltFator <= 0) And
        (Copy(Self.CodFormul,1,3) <> 'ESP')) Or
       ((mveModoVenda = mvDiluido) And (Base.QuantidadeDiluido * fltFator <= 0)) Then
    Begin
      Result := True;

      If TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Existem bases com a quantidade zerada, ' + #13#10 +
                                                       'podendo ocorrer alteração de cor. ' + #13#10 +
                                                       'A fórmula é responsabilidade do cliente. ' + #13#10 +
                                                       'Deseja continuar ?', ['&Sim','&Não']) = 1 Then
      Begin
        If TAutcomTintaFactory.Get.fGravarLogLiberacaoBaseAutomotiva(
                                                           strOperadorLiberou,
                                                           Base.CodigoBase,
                                                           'Liberação de base com quantidade zerada !') Then
        Begin
          BaseQtdZerada := Base.CodigoBase;
          Result := False;
        End;
      End;

      Break;
    End;
  End;
end;

function TFormulaAutomotivaDuxone2.fRetornaCatalisadorVenda(blnComCat: Boolean;
  strTipPre, strListaAdicional: String): String;
begin
  Result := strListaAdicional;
end;

function TFormulaAutomotivaDuxone2.fRetPesoEsp(strCodBas: String): Double;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT BAS_PESESP FROM DU2_CADBAS WHERE BAS_CODBAS = :CODBAS  ';
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.Open;

  Result := qryGen.FieldByName('BAS_PESESP').AsFloat;
end;

function TFormulaAutomotivaDuxone2.fRetQtdDiluente(fltVolumePro: Double;
  strCodDil, strPercentual: String; fltPesoEspecifico: Double): Double;
begin
  Result := (StrToFloat(strPercentual) * 10) * fltPesoEspecifico;
end;

function TFormulaAutomotivaDuxone2.fTipoEmbalagem(intIndEmb: Integer;
  strQualid: String): Boolean;
begin
  Result := False;
end;

function TFormulaAutomotivaDuxone2.fValidaVolumeFormulucao(strTipoPre: String;
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaDuxone2.fVolumeOriginalFator: Boolean;
begin
  Result := False;
end;

function TFormulaAutomotivaDuxone2.fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer;
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 0.900;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGetDouble('VOL1_4'), 3);
end;

function TFormulaAutomotivaDuxone2.GetAcrescimoDespesaOperacionalTinta: Double;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGetDouble('DESOPE');
end;

function TFormulaAutomotivaDuxone2.GetAno(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('DU2_ANOCOR').AsString;
end;

function TFormulaAutomotivaDuxone2.GetBasesPorEmpresa(const dicRetorno: IDicionario): String;
begin
  If TAutcomTintaFactory.Get.GetEmpBasDU2 Then
  Begin
    If (Not TStrUtils.fEmptyStr(Self.EmpresaProducao)) And (Self.OprFlj = 'S') Then
      Result := ' AND BAS_CODEMP = ' + QuotedStr(Self.EmpresaProducao)
    Else If (Not TStrUtils.fEmptyStr(Self.EmpCd_)) And (Self.CD_S_N = 'S') Then
      Result := ' AND BAS_CODEMP = ' + QuotedStr(Self.EmpCd_)
    Else If (Not TStrUtils.fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
      Result := ' AND BAS_CODEMP = ' + QuotedStr(Self.EmpFat)
    Else
      Result := ' AND BAS_CODEMP = ' + QuotedStr(TAutcomTintaFactory.Get.GetCodEmp);
  End;
end;

function TFormulaAutomotivaDuxone2.GetBasPesGra(
  const dataSetBases: IDataSet): String;
begin
  Result := dataSetBases.FieldByName('BAS_PESGRA').AsString;
end;

function TFormulaAutomotivaDuxone2.GetCalcDespesasOperacionais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltQtdFor := fltQtdFor * formula.VolumePro / formula.VolumeOri;

  If base.PesGra = 'S' Then
    fltVenBas := (fltQtdFor * (base.PrecoVenda / base.Embalagem))
  Else
    fltVenBas := (fltQtdFor * (base.PrecoVenda / (base.Embalagem * base.PesoEspecifico)));

  Result := (fltVenBas * base.DespesasOperacionais / 100);
end;

function TFormulaAutomotivaDuxone2.GetCalcIcmsSaida(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltQtdFor := fltQtdFor * formula.VolumePro / formula.VolumeOri;


  If base.PesGra = 'S' Then
    fltVenBas := (fltQtdFor * (base.PrecoVenda / base.Embalagem))
  Else
    fltVenBas := (fltQtdFor * (base.PrecoVenda / (base.Embalagem * base.PesoEspecifico)));

  Result := (fltVenBas * base.IcmsSaida / 100);
end;

function TFormulaAutomotivaDuxone2.GetCalcImpostosFederais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltQtdFor := fltQtdFor * formula.VolumePro / formula.VolumeOri;

  If base.PesGra = 'S' Then
    fltVenBas := (fltQtdFor * (base.PrecoVenda / base.Embalagem))
  Else
    fltVenBas := (fltQtdFor * (base.PrecoVenda / (base.Embalagem * base.PesoEspecifico)));

  Result := (fltVenBas * base.ImpostosFederais / 100);
end;

function TFormulaAutomotivaDuxone2.GetCalcOutrosValores(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltQtdFor := fltQtdFor * formula.VolumePro / formula.VolumeOri;

  If base.PesGra = 'S' Then
    Result := (fltQtdFor * (base.OutrosValores / base.Embalagem))
  Else
    Result := (fltQtdFor * (base.OutrosValores / (Base.Embalagem * Base.PesoEspecifico)));
end;

function TFormulaAutomotivaDuxone2.GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltQtdFor := fltQtdFor * formula.VolumePro / formula.VolumeOri;

  If base.PesGra = 'S' Then
    Result := (fltQtdFor * (base.PrecoCompraLiquido / base.Embalagem))
  Else
    Result := (fltQtdFor * (base.PrecoCompraLiquido / (Base.Embalagem * Base.PesoEspecifico)));
end;

function TFormulaAutomotivaDuxone2.GetCalcPrecoCusto(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltQtdFor := fltQtdFor * formula.VolumePro / formula.VolumeOri;

  If base.PesGra = 'S' Then
    Result := (fltQtdFor * (base.PrecoCusto / base.Embalagem))
  Else
    Result := (fltQtdFor * (base.PrecoCusto / (base.Embalagem * base.PesoEspecifico)));
end;

function TFormulaAutomotivaDuxone2.GetCalcPrecoCustoReal(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltQtdFor := fltQtdFor * formula.VolumePro / formula.VolumeOri;

  If base.PesGra = 'S' Then
    Result := (fltQtdFor * (base.PrecoCustoReal / base.Embalagem))
  Else
    Result := (fltQtdFor * (base.PrecoCustoReal / (Base.Embalagem * Base.PesoEspecifico)));
end;

function TFormulaAutomotivaDuxone2.GetCalcPrecoMedio(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltQtdFor := fltQtdFor * formula.VolumePro / formula.VolumeOri;

  If base.PesGra = 'S' Then
    Result := (fltQtdFor * (base.PrecoMedio / base.Embalagem))
  Else
    Result := (fltQtdFor * (base.PrecoMedio / (Base.Embalagem * Base.PesoEspecifico)));
end;

function TFormulaAutomotivaDuxone2.GetCalcPrecoVenda(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltQtdFor := fltQtdFor * formula.VolumePro / formula.VolumeOri;

  If base.PesGra = 'S' Then
    Result := (fltQtdFor * (base.PrecoVenda / base.Embalagem))
  Else
    Result := (fltQtdFor * (base.PrecoVenda / (Base.Embalagem * Base.PesoEspecifico)));
end;

function TFormulaAutomotivaDuxone2.GetCalcQuantidade(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido)
               * formula.VolumePro / formula.VolumeOri;
end;

function TFormulaAutomotivaDuxone2.GetCalculadorInterno: ICalculadorFormulaAutomotiva;
begin
  Result := TAbstractCalculadorFormulaAutomotiva.Create(Self);
end;

function TFormulaAutomotivaDuxone2.GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltQtdFor := fltQtdFor * formula.VolumePro / formula.VolumeOri;

  If base.PesGra = 'S' Then
    Result := (fltQtdFor * (base.UltimoPrecoCompra / base.Embalagem))
  Else
    Result := (fltQtdFor * (base.UltimoPrecoCompra / (Base.Embalagem * Base.PesoEspecifico)));
end;

function TFormulaAutomotivaDuxone2.GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltQtdFor := fltQtdFor * formula.VolumePro / formula.VolumeOri;

  If base.PesGra = 'S' Then
  	Result := (fltQtdFor * (base.UltimoPrecoCompraImpostos / base.Embalagem))
	Else
  	Result := (fltQtdFor * (base.UltimoPrecoCompraImpostos / (Base.Embalagem * Base.PesoEspecifico)));
end;

function TFormulaAutomotivaDuxone2.GetChaFor(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('DU2_DESCRI').AsString + ' ' +
            dtsCadTin.FieldByName('DU2_MONTAD').AsString + ' ' +
            dtsCadTin.FieldByName('DU2_QUALID').AsString + ' ' +
            dtsCadTin.FieldByName('DU2_CODDU2').AsString + ' ' +
            dtsCadTin.FieldByName('DU2_ALTERN').AsString + ' ' +
            dtsCadTin.FieldByName('DU2_REGIAO').AsString;
end;

function TFormulaAutomotivaDuxone2.GetChaForEspecifico(
  const dicRetorno: IDicionario; const dtsCadTin: IDataSet): String;
begin
  Result := dicRetorno['chafor'] + dicRetorno['tipemb'];
end;


function TFormulaAutomotivaDuxone2.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('DU2_MD5KEY').AsString;
end;

function TFormulaAutomotivaDuxone2.GetCodFormul(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('DU2_CODDU2').AsString;
end;

function TFormulaAutomotivaDuxone2.GetDescricao(const dtsCadTin: IDataSet): String;
Var
  IntCont  : Integer;
  strDesc  : String;
begin
  strDesc := '';

  For intCont := 1 To 20 Do
  Begin
     If dtsCadTin.FieldByName('DU2_TIPB' + TStrUtils.fStrZero(intCont, 2)).AsString = 'C' Then
     Begin
       {strDesc  := dtsCadTin.FieldByName('DU2_DESCRI').AsString + ' - ' +
                   dtsCadTin.FieldByName('DU2_CODDU2').AsString + ' - ' +
                   'CATALISADOR ' + dtsCadTin.FieldByName('DU2_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString;
                   }

       strDesc  := dtsCadTin.FieldByName('DU2_DESCRI').AsString + ' - ' +
                   dtsCadTin.FieldByName('DU2_CODDU2').AsString + ' - ' +
                   dtsCadTin.FieldByName('DU2_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString;

       Break;
     End;
  End;

  If (strDesc <> '') Then
    Result :=  strDesc
  Else
    Result := dtsCadTin.FieldByName('DU2_DESCRI').AsString + ' - ' +
              dtsCadTin.FieldByName('DU2_CODDU2').AsString;
end;

function TFormulaAutomotivaDuxone2.GetDescricaoBase(strCodBas: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DESBAS '+
                    '  FROM DU2_CADBAS '+
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

function TFormulaAutomotivaDuxone2.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaAutomotivaDuxone2.GetIdePro: String;
begin
  Result := 'DU2';
end;

function TFormulaAutomotivaDuxone2.GetIndEmb(
  const dtsCadTin: IDataSet): integer;
begin
  Result := 0;
end;

function TFormulaAutomotivaDuxone2.GetLinha(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('DU2_LINHA_').AsString;
end;

function TFormulaAutomotivaDuxone2.GetMontadora(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('DU2_MONTAD').AsString;
end;

function TFormulaAutomotivaDuxone2.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaAutomotivaDuxone2.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaAutomotivaDuxone2.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaAutomotivaDuxone2.GetNomeTabelaBases: String;
begin
  Result := 'DU2_CADBAS';
end;

function TFormulaAutomotivaDuxone2.GetPrefixoFormulacao: String;
begin
  Result := 'DU2_BASE';
end;

function TFormulaAutomotivaDuxone2.GetPrefixoLitragem(
  const strModo: String): String;
begin
  Result := 'DU2_LITRAG';
end;

function TFormulaAutomotivaDuxone2.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'DU2_QTDC'
end;

function TFormulaAutomotivaDuxone2.GetProdutoChapinha: String;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGet('PROCHA');
end;

function TFormulaAutomotivaDuxone2.GetProdutoVendaTinta(const dtsCadTin: IDataSet): string;
begin
  Result := '';
  Result := TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGet('PRODU2');
end;

function TFormulaAutomotivaDuxone2.GetQualidade(
  const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('DU2_QUALID').AsString;
end;

function TFormulaAutomotivaDuxone2.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaAutomotivaDuxone2.GetSelectBases: String;
begin
  Result := ' SELECT         ' +
            '     BAS_CODBAS ' +
            '   , BAS_CODITE ' +
            '   , BAS_EMBALA ' +
            '   , BAS_PESESP ' +
            '   , BAS_CODEMP ' +
            '   , BAS_DESBAS ' +
            '   , BAS_PESGRA ' +
            '   , BAS_TIPO__ ' +
            '   , BAS_LINHA_ ' +
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

function TFormulaAutomotivaDuxone2.GetTextoInformativoCalculo: String;
begin
  Result :=
  'VolumeFormula     = ' + FloatToStrF(VolumeOri, ffFixed, 12, 4)          + sLineBreak +
  'Quantidade           = Quantidade * (Volume Digitado / Volume)'                   + sLineBreak +
  'Valor da Base       = (Quantidade * Preço) / (Peso Específico * Embalagem)' + sLineBreak +
  'Preço da Tinta       = Soma do valor de todas as bases.';
end;

function TFormulaAutomotivaDuxone2.GetUniversal(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaDuxone2.GetUsaChapinha(
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := (dtsCadTin.FieldByName('DU2_PROCHA').AsString = 'S');
end;

function TFormulaAutomotivaDuxone2.GetVolumeMaximoBalde(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Balde') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGetDouble('VOLBAL'), 3);
end;

function TFormulaAutomotivaDuxone2.GetVolumeMaximoCopo(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Copo') Then
  Begin
    Result := 0.500;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGetDouble('VOLCOP'), 3);
end;

function TFormulaAutomotivaDuxone2.GetVolumeMaximoGalao(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 4.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGetDouble('VOLGAL'), 3);
end;

function TFormulaAutomotivaDuxone2.GetVolumeMaximoLata(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGetDouble('VOLLAT'), 3);
end;

function TFormulaAutomotivaDuxone2.GetVolumeMaximoLitro(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 1.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGetDouble('VOL1_4'), 3);
end;

function TFormulaAutomotivaDuxone2.GetVolumeMaximoSprayDuco(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Spray Duco') Then
  Begin
    Result := 0.150;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGetDouble('VOLSDU'), 3);
end;

function TFormulaAutomotivaDuxone2.GetVolumeMaximoSprayPoli(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Spray Poli') Then
  Begin
    Result := 0.150;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGetDouble('VOLSPO'), 3);
end;

function TFormulaAutomotivaDuxone2.GetVolumeMaximoSpraySint(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Spray Sint') Then
  Begin
    Result := 0.150;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGetDouble('VOLSPS'), 3);
end;

function TFormulaAutomotivaDuxone2.GetVolumeMaximoTambor(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Tambor') Then
  Begin
    Result := 200.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGetDouble('VOLTAM'), 3);
end;

function TFormulaAutomotivaDuxone2.GetVolumePadraCopo: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Copo') Then
  Begin
    Result := 0.500;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGetDouble('VOLCOP'), 3);
end;

function TFormulaAutomotivaDuxone2.GetVolumePadraGalao(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 3.600;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGetDouble('VOLGAL'), 3);
end;

function TFormulaAutomotivaDuxone2.GetVolumePadraoBalde(dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Balde') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGetDouble('VOLBAL'), 3);
end;

function TFormulaAutomotivaDuxone2.GetVolumePadraoLata(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGetDouble('VOLLAT'), 3);
end;

function TFormulaAutomotivaDuxone2.GetVolumePadraoSprayDuco: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Spray Duco') Then
  Begin
    Result := 0.150;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGetDouble('VOLSDU'), 3);
end;

function TFormulaAutomotivaDuxone2.GetVolumePadraoSprayPoli: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Spray Poli') Then
  Begin
    Result := 0.150;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGetDouble('VOLSPO'), 3);
end;

function TFormulaAutomotivaDuxone2.GetVolumePadraoSpraySint: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Spray Sint') Then
  Begin
    Result := 0.150;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGetDouble('VOLSPS'), 3);
end;

function TFormulaAutomotivaDuxone2.GetVolumePadraSpray: Double;
begin
  Result := 0;
end;

function TFormulaAutomotivaDuxone2.GetVolumePadraTambor(dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Tambor') Then
  Begin
    Result := 196.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGetDouble('VOLTAM'), 3);
end;

function TFormulaAutomotivaDuxone2.GetVolumePermitido(
  const dtsCadTin: IDataSet; strTipoPre: String): Double;
begin
  Result := 0;
end;

procedure TFormulaAutomotivaDuxone2.IniciaArrMinMax(const dtsCadTin: IDataSet);
Var
  intContador: Integer;
begin
  SetLength(arrMinMax, Self.ListaAdicional.Count);

  For intContador := 0 To Self.ListaAdicional.Count - 1 Do
  Begin
    arrMinMax[intContador].fltMin := TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGetDouble('MINDIL');
    arrMinMax[intContador].fltMax := TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGetDouble('MAXDIL');

    If dtsCadTin.FieldByName('DU2_LINHA_').AsString = '1ST' Then
    Begin
      arrMinMax[intContador].fltMin := 10;
      arrMinMax[intContador].fltMax := 10;
    End;
  End;
end;

procedure TFormulaAutomotivaDuxone2.pAtualizaPorcentagem(
  const formula: TAbstractFormulaAutomotiva; dtsCadTin: IDataSet);
begin
  If Formula.ListaAdicional.Count <= 0 Then
    Exit;

  If Formula.PorDil > arrMinMax[Formula.IndiceAdicional].fltMax Then
    Formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltMax;

  If Formula.PorDil < arrMinMax[Formula.IndiceAdicional].fltMin Then
    Formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltMin;

  Formula.HabDil := True;
end;

procedure TFormulaAutomotivaDuxone2.pCalculaImpostosSaida(
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

procedure TFormulaAutomotivaDuxone2.pDefineVolumeOriginal;
begin
  //
end;

procedure TFormulaAutomotivaDuxone2.pPreencheProdutoEmbagemVenda;
var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('DU2');

  DesEmb.Clear;

  DesEmb.Add('Duxone');

  IniciaArrMinMax(dtsCadTin);


  ProEmbLt.Add(conf.fGet('ITE1_4'));
  ProEmbGl.Add(conf.fGet('ITEGAL'));
  ProEmbLa.Add(conf.fGet('ITELAT'));
  sProEmbCo := conf.fGet('ITECOP');
  sProEmbTb := conf.fGet('ITETAM');
  sProEmbBa := conf.fGet('ITEBAL');
  sProEmbSs := conf.fGet('ITESPS');
  sProEmbPo := conf.fGet('ITESPO');
  sProEmbSd := conf.fGet('ITESDU');
  sProEmbSp := '';
  sProEmbLa := '';

  If ListaAdicional.Count > 0 Then
    pReformulaNovo(ListaAdicional[0], TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGet('MINDIL'), dtsCadTin);
end;

procedure TFormulaAutomotivaDuxone2.pPreencherPesCorFor(
  const dtsCadTin: IDataSet);
begin
  inherited;
  Self.PesoCor := 0;
  Self.PesoFor := 0;
end;

{$IFNDEF LINUX}
procedure TFormulaAutomotivaDuxone2.pRecalculaFormulaMostrarDigitado(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; fltFator: Double;
  blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha: String;
  strTipBas: String);
begin
  Begin
    lsvFormulacao.Items.Add.Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    lsvFormulacao.Items[intCont].SubItems.Add(strTipBas);
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado * fltFator, ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.QuantidadeDiluido * fltFator, ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.QuantidadeDiluido2 * fltFator, ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TFormulaAutomotivaDuxone2.pRecalculaFormulaMostrarPadrao(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; blnConsLinhaDesBas: Boolean;
  strTipBas: String; intCont: Integer);
begin
  Begin
    lsvFormulacao.Items.Add.Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    lsvFormulacao.Items[intCont].SubItems.Add(strTipBas);
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado, ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.QuantidadeDiluido, ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.QuantidadeDiluido2, ffFixed, 12, 3));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    lsvFormulacao.Items[intCont].SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

procedure TFormulaAutomotivaDuxone2.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('DU2_ACRMOB').AsFloat;
end;

procedure TFormulaAutomotivaDuxone2.PreencheQuantidadeFormulacaoVenda(
  const dtsCadTin: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
begin
  For intContador := 1 To Self.GetQuantidadeFormulacao Do
  Begin
    If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('DU2_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
      Continue;

    Base := TBaseAutomotiva(Self.Add);
    Base.IdePro                := 'DU2';
    Base.CodigoBase            := dtsCadTin.FieldByName('DU2_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString;
    Base.QuantidadeConcentrado := dtsCadTin.FieldByName('DU2_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
    Base.TipoBase              := dtsCadTin.FieldByName('DU2_TIPB' + TStrUtils.fStrZero(intContador, 2)).AsString;
    Base.Qualidade             := dtsCadTin.FieldByName('DU2_QUALID').AsString;
  End;
end;

procedure TFormulaAutomotivaDuxone2.PreencheVolumeVenda(const dtsCadTin: IDataSet);
begin
  Self.VolumeOri := dtsCadTin.FieldByName('DU2_LITRAG').AsFloat / 1000;
end;

procedure TFormulaAutomotivaDuxone2.pReformulaNovo(strCodDil,
  strPercentual: String; const dtsCadTin: IDataSet);
Var
  intContador: Integer;
  qryGen: IDataSet;
  diluente: TBaseAutomotiva;
  Bases: TBaseAutomotiva;
  fltVolumeConcentrado: Double;
  fltVolumeDiluido: Double;
  fltVolumeTotal: Double;
  fltTotalGramas: Double;
  fltPesoEspFormula: Double;
  fltDesOpeTinta: Double;
  dicDados: IDicionario;
  intDecFor: Integer;
  fltVolumeTinta: Double;
begin
  Try
    intDecFor := TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGetInteger('DECFOR');

    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.Close;
    qryGen.SQL := '';
    qryGen.SQL := qryGen.SQL + '  SELECT                ';
    qryGen.SQL := qryGen.SQL + '    *                   ';
    qryGen.SQL := qryGen.SQL + '  FROM                  ';
    qryGen.SQL := qryGen.SQL + '    DU2_CADBAS B        ';
    qryGen.SQL := qryGen.SQL + '  INNER JOIN ITEGER G ON        ';
    qryGen.SQL := qryGen.SQL + '    G.ITE_CODITE = B.BAS_CODITE  AND   ';
    qryGen.SQL := qryGen.SQL + '    G.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '"    ';
    qryGen.SQL := qryGen.SQL + '  INNER JOIN CADITE I ON        ';
    qryGen.SQL := qryGen.SQL + '    I.ITE_CODITE = G.ITE_CODITE           ';
    qryGen.SQL := qryGen.SQL + '  WHERE                 ';
    qryGen.SQL := qryGen.SQL + '    B.BAS_CODBAS = :CODBAS      ';

    qryGen.ParamByName('CODBAS').AsString := strCodDil;
    qryGen.Open;

    If qryGen.IsEmpty Then
      Exit;

    If dtsCadTin.FieldByName('DU2_LINHA_').AsString <> '1ST' Then
    Begin

      fltVolumeConcentrado := 0;
      fltVolumeTotal := 1000;

      For intContador := Self.Count - 1 Downto 0 Do
      Begin
        Bases := (Self.Items[intContador] As TBaseAutomotiva);
        If Bases.TipoBase <> 'B' Then
          Self.Delete(intContador)
        Else
          fltVolumeConcentrado := fltVolumeConcentrado + dtsCadTin.FieldByName('DU2_QTDC' + TStrUtils.fStrZero(intContador + 1, 2)).AsFloat;
      End;

      fltDesOpeTinta := TAutcomTintaFactory.Get().fGetConfTinta(GetIdePro).fGetDouble('DESOPE');

      Diluente := (Self.Add as TBaseAutomotiva);
      Diluente.CodigoBase := strCodDil;
      Diluente.TipoBase := 'D';
      Diluente.PesoEspecifico := qryGen.FieldByName('BAS_PESESP').AsFloat;
      Diluente.QuantidadeDiluido := fRetQtdDiluente(1, strCodDil, strPercentual, qryGen.FieldByName('BAS_PESESP').AsFloat);
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

      fltVolumeDiluido := fltVolumeConcentrado + Diluente.QuantidadeDiluido;
      fltVolumeTotal := fltVolumeTotal + (StrToFloat(strPercentual) * 10);
      fltPesoEspFormula := TAutcomTintaFactory.Get.fFormataFloat(fltVolumeDiluido / fltVolumeTotal, 5);
      fltTotalGramas := 1000 * fltPesoEspFormula;

      Diluente.QuantidadeDiluido := TAutcomTintaFactory.Get.fFormataFloat((diluente.QuantidadeDiluido * fltTotalGramas) / fltVolumeDiluido, intDecFor);

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
          Bases.QuantidadeDiluido := TAutcomTintaFactory.Get.fFormataFloat((dtsCadTin.FieldByName('DU2_QTDC' + TStrUtils.fStrZero(intContador + 1, 2)).AsFloat * fltTotalGramas) / fltVolumeDiluido, intDecFor);

      End;
    End
    Else
    Begin
      fltVolumeConcentrado := 0;
      fltVolumeTinta := 1100;

      For intContador := Self.Count - 1 Downto 0 Do
      Begin
        Bases := (Self.Items[intContador] As TBaseAutomotiva);
        If Bases.TipoBase <> 'B' Then
          Self.Delete(intContador)
        Else
          fltVolumeConcentrado := fltVolumeConcentrado + dtsCadTin.FieldByName('DU2_QTDC' + TStrUtils.fStrZero(intContador + 1, 2)).AsFloat;
      End;

      fltDesOpeTinta := TAutcomTintaFactory.Get().fGetConfTinta(GetIdePro).fGetDouble('DESOPE');

      Diluente := (Self.Add as TBaseAutomotiva);
      Diluente.CodigoBase := strCodDil;
      Diluente.TipoBase := 'D';
      Diluente.PesoEspecifico := qryGen.FieldByName('BAS_PESESP').AsFloat;
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

      Diluente.QuantidadeDiluido := 100 * fRetPesoEsp(strCodDil);

      fltVolumeDiluido := fltVolumeConcentrado + Diluente.QuantidadeDiluido;
      fltPesoEspFormula := TAutcomTintaFactory.Get.fFormataFloat(fltVolumeDiluido / fltVolumeTinta, 5);
      fltTotalGramas := 1000 * fltPesoEspFormula;

      Diluente.QuantidadeDiluido := TAutcomTintaFactory.Get.fFormataFloat((Diluente.QuantidadeDiluido * fltTotalGramas) / fltVolumeDiluido, intDecFor);

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
          Bases.QuantidadeDiluido := TAutcomTintaFactory.Get.fFormataFloat((dtsCadTin.FieldByName('DU2_QTDC' + TStrUtils.fStrZero(intContador + 1, 2)).AsFloat * fltTotalGramas) / fltVolumeDiluido, intDecFor);
        End;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Raise;
    End;
  End;
end;

function TFormulaAutomotivaDuxone2.SetItemIndexLinuxDiluente(
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
