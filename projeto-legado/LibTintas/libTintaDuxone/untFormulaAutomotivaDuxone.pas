{************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula Duxone   *}
{*********************************************************************AC*}
unit untFormulaAutomotivaDuxone;

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
  TFormulaAutomotivaDuxone = class(TAbstractFormulaAutomotiva)
  private

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
    function GetUsaChapinha(const dtsCadTin: IDataSet): Boolean; Override;
    function GetProdutoChapinha(): String; Override;
    procedure pCalculaImpostosSaida(Var dicRetorno: IDicionario); Override;
  end;

implementation

uses
  untAbstractCalculadorFormulaAutomotiva, untAutcomTintaFactory ;

{ TFormulaAutomotivaDuxone }

procedure TFormulaAutomotivaDuxone.CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva);
begin
  If dataSetBases.FieldByName('BAS_PESGRA').AsString = 'S' Then
    Base.Cnv_Ml := Base.Embalagem
  Else
    Base.Cnv_Ml := Base.Embalagem / Base.PesoEspecifico;
end;

function TFormulaAutomotivaDuxone.fExisteConfiguracao(dtsCadTin: IDataSet;
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
    qryConf.SQL := qryConf.SQL + '    CFG_IDEPRO = "DUX" AND          ';
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

function TFormulaAutomotivaDuxone.fGetFormulaEspecial(strCodigo: String): Boolean;
begin
  Result := Pos('ESP',strCodigo) > 0;
end;

function TFormulaAutomotivaDuxone.fMostrarComCatalisador: Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaDuxone.fQuantidadeMenorIgualZero: Boolean;
var
  intContador: Integer;
  Base: TBaseAutomotiva;
  fltFator: Double;
  intDec: Integer;
  strOperadorLiberou: String;
begin
  Result := False;

  strOperadorLiberou := '';

  If mveModoVenda = mvConcentrado Then
  Begin
    If Self.VolumePro < 0.05 Then
    Begin
      TAutcomTintaFactory.Get.fMensagem('AVISO', 'Volume mínimo concentrado permitido para a tinta Duxone Global é 0,050 ml!', ['&Ok']);
      Result := True;
      Exit;
    End;
  End
  Else
  Begin
    If Self.VolumePro < 0.1 Then
    Begin
      TAutcomTintaFactory.Get.fMensagem('AVISO', 'Volume mínimo diluído permitido para a tinta Duxone Global é 0,100 ml!', ['&Ok']);
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

  intDec := StrToIntDef(TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGet('DECFOR'), 1);

  For intContador := 0 To Self.Count-1 Do
  Begin
    Base := TBaseAutomotiva(Self.Items[intContador]);

    If ((mveModoVenda = mvConcentrado) And (Base.TipoBase = 'B') And
        (RoundTo(Base.QuantidadeConcentrado * fltFator, - intDec) <= 0) And
        (Copy(Self.CodFormul,1,3) <> 'ESP')) Or
       ((mveModoVenda = mvDiluido) And (RoundTo(Base.QuantidadeDiluido * fltFator, - intDec) <= 0)) Then
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

function TFormulaAutomotivaDuxone.fRetornaCatalisadorVenda(blnComCat: Boolean;
  strTipPre, strListaAdicional: String): String;
begin
  Result := TAutcomTintaFactory.Get.IIF(blnComCat, 'S', 'N');
end;

function TFormulaAutomotivaDuxone.fTipoEmbalagem(intIndEmb: Integer;
  strQualid: String): Boolean;
begin
  Result := False;
end;

function TFormulaAutomotivaDuxone.fValidaVolumeFormulucao(strTipoPre: String;
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaDuxone.fVolumeOriginalFator: Boolean;
begin
  Result := False;
end;

function TFormulaAutomotivaDuxone.fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer;
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 0.900;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGetDouble('VOL1_4'), 3);
end;

function TFormulaAutomotivaDuxone.GetAcrescimoDespesaOperacionalTinta: Double;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGetDouble('DESOPE');
end;

function TFormulaAutomotivaDuxone.GetAno(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('DUX_ANOCOR').AsString;
end;

function TFormulaAutomotivaDuxone.GetBasesPorEmpresa(const dicRetorno: IDicionario): String;
begin
  If TAutcomTintaFactory.Get.GetEmpBasDUX Then
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
  {Result := ' AND BAS_CODEMP = ' + QuotedStr(TAutcomTintaFactory.Get.IIF(TStrUtils.fEmptyStr(TVariantUtils.IfNull(dicRetorno['codempprd'],''))
                                                                         , TAutcomTintaFactory.Get.GetCodEmp
                                                                         , dicRetorno['codempprd']));}
end;

function TFormulaAutomotivaDuxone.GetBasPesGra(
  const dataSetBases: IDataSet): String;
begin
  Result := dataSetBases.FieldByName('BAS_PESGRA').AsString;
end;

function TFormulaAutomotivaDuxone.GetCalcDespesasOperacionais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  if fGetFormulaEspecial(formula.CodFormul) Then
    fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri)
  Else
    fltQtdFor := RoundTo(TAutcomTintaFactory.Get.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri, 2), -1);

  If base.PesGra = 'S' Then
    fltVenBas := (fltQtdFor * (base.PrecoVenda / base.Embalagem))
  Else
    fltVenBas := (fltQtdFor * (base.PrecoVenda / base.Embalagem / base.PesoEspecifico));

  Result := (fltVenBas * base.DespesasOperacionais / 100);
end;

function TFormulaAutomotivaDuxone.GetCalcIcmsSaida(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  if fGetFormulaEspecial(formula.CodFormul) Then
    fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri)
  Else
    fltQtdFor := RoundTo(TAutcomTintaFactory.Get.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri, 2), -1);


  If base.PesGra = 'S' Then
    fltVenBas := (fltQtdFor * (base.PrecoVenda / base.Embalagem))
  Else
    fltVenBas := (fltQtdFor * (base.PrecoVenda / base.Embalagem / base.PesoEspecifico));

  Result := (fltVenBas * base.IcmsSaida / 100);
end;

function TFormulaAutomotivaDuxone.GetCalcImpostosFederais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  if fGetFormulaEspecial(formula.CodFormul) Then
    fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri)
  Else
    fltQtdFor := RoundTo(TAutcomTintaFactory.Get.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri, 2), -1);

  If base.PesGra = 'S' Then
    fltVenBas := (fltQtdFor * (base.PrecoVenda / base.Embalagem))
  Else
    fltVenBas := (fltQtdFor * (base.PrecoVenda / base.Embalagem / base.PesoEspecifico));

  Result := (fltVenBas * base.ImpostosFederais / 100);
end;

function TFormulaAutomotivaDuxone.GetCalcOutrosValores(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  if fGetFormulaEspecial(formula.CodFormul) Then
    fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri)
  Else
    fltQtdFor := RoundTo(TAutcomTintaFactory.Get.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri, 2), -1);

  If base.PesGra = 'S' Then
    Result := (fltQtdFor * (base.OutrosValores / base.Embalagem))
  Else
    Result := (fltQtdFor * (base.OutrosValores / Base.Embalagem / Base.PesoEspecifico));
end;

function TFormulaAutomotivaDuxone.GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  if fGetFormulaEspecial(formula.CodFormul) Then
    fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri)
  Else
    fltQtdFor := RoundTo(TAutcomTintaFactory.Get.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri, 2), -1);

  If base.PesGra = 'S' Then
    Result := (fltQtdFor * (base.PrecoCompraLiquido / base.Embalagem))
  Else
    Result := (fltQtdFor * (base.PrecoCompraLiquido / Base.Embalagem / Base.PesoEspecifico));
end;

function TFormulaAutomotivaDuxone.GetCalcPrecoCusto(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  if fGetFormulaEspecial(formula.CodFormul) Then
    fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri)
  Else
    fltQtdFor := RoundTo(TAutcomTintaFactory.Get.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri, 2), -1);

  If base.PesGra = 'S' Then
    Result := (fltQtdFor * (base.PrecoCusto / base.Embalagem))
  Else
    Result := (fltQtdFor * (base.PrecoCusto / base.Embalagem / base.PesoEspecifico));
end;

function TFormulaAutomotivaDuxone.GetCalcPrecoCustoReal(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  if fGetFormulaEspecial(formula.CodFormul) Then
    fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri)
  Else
    fltQtdFor := RoundTo(TAutcomTintaFactory.Get.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri, 2), -1);

  If base.PesGra = 'S' Then
    Result := (fltQtdFor * (base.PrecoCustoReal / base.Embalagem))
  Else
    Result := (fltQtdFor * (base.PrecoCustoReal / Base.Embalagem / Base.PesoEspecifico));
end;

function TFormulaAutomotivaDuxone.GetCalcPrecoMedio(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  if fGetFormulaEspecial(formula.CodFormul) Then
    fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri)
  Else
    fltQtdFor := RoundTo(TAutcomTintaFactory.Get.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri, 2), -1);

  If base.PesGra = 'S' Then
    Result := (fltQtdFor * (base.PrecoMedio / base.Embalagem))
  Else
    Result := (fltQtdFor * (base.PrecoMedio / Base.Embalagem / Base.PesoEspecifico));
end;

function TFormulaAutomotivaDuxone.GetCalcPrecoVenda(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  if fGetFormulaEspecial(formula.CodFormul) Then
    fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri)
  Else
    fltQtdFor := RoundTo(TAutcomTintaFactory.Get.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri, 2), -1);

  If base.PesGra = 'S' Then
    Result := (fltQtdFor * (base.PrecoVenda / base.Embalagem))
  Else
    Result := (fltQtdFor * (base.PrecoVenda / Base.Embalagem / Base.PesoEspecifico));
end;

function TFormulaAutomotivaDuxone.GetCalcQuantidade(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  if fGetFormulaEspecial(formula.CodFormul) Then
    Result := (TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido)
               * formula.VolumePro / formula.VolumeOri)
  Else
    Result := RoundTo(TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido)
               * formula.VolumePro / formula.VolumeOri, 2), -1);
end;

function TFormulaAutomotivaDuxone.GetCalculadorInterno: ICalculadorFormulaAutomotiva;
begin
  Result := TAbstractCalculadorFormulaAutomotiva.Create(Self);
end;

function TFormulaAutomotivaDuxone.GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  if fGetFormulaEspecial(formula.CodFormul) Then
    fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri)
  Else
    fltQtdFor := RoundTo(TAutcomTintaFactory.Get.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri, 2), -1);

  If base.PesGra = 'S' Then
    Result := (fltQtdFor * (base.UltimoPrecoCompra / base.Embalagem))
  Else
    Result := (fltQtdFor * (base.UltimoPrecoCompra / Base.Embalagem / Base.PesoEspecifico));
end;

function TFormulaAutomotivaDuxone.GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  if fGetFormulaEspecial(formula.CodFormul) Then
    fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri)
  Else
    fltQtdFor := RoundTo(TAutcomTintaFactory.Get.fFormataFloat(fltQtdFor * formula.VolumePro / formula.VolumeOri, 2), -1);

  If base.PesGra = 'S' Then
    Result := (fltQtdFor * (base.UltimoPrecoCompraImpostos / base.Embalagem))
  Else
    Result := (fltQtdFor * (base.UltimoPrecoCompraImpostos / Base.Embalagem / Base.PesoEspecifico));
end;

function TFormulaAutomotivaDuxone.GetChaFor(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('DUX_DESCRI').AsString + ' ' +
            dtsCadTin.FieldByName('DUX_MONTAD').AsString + ' ' +
            dtsCadTin.FieldByName('DUX_QUALID').AsString + ' ' +
            dtsCadTin.FieldByName('DUX_CODDUX').AsString + ' ' +
            dtsCadTin.FieldByName('DUX_ALTERN').AsString + ' ' +
            dtsCadTin.FieldByName('DUX_REGIAO').AsString;
end;

function TFormulaAutomotivaDuxone.GetChaForEspecifico(
  const dicRetorno: IDicionario; const dtsCadTin: IDataSet): String;
begin
  Result := dicRetorno['chafor'] + dicRetorno['tipemb'];
end;


function TFormulaAutomotivaDuxone.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('DUX_MD5KEY').AsString;
end;

function TFormulaAutomotivaDuxone.GetCodFormul(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('DUX_CODDUX').AsString;
end;

function TFormulaAutomotivaDuxone.GetDescricao(const dtsCadTin: IDataSet): String;
Var
  IntCont  : Integer;
  strDesc  : String;
begin
  strDesc := '';

  For intCont := 1 To 20 Do
  Begin
     If dtsCadTin.FieldByName('DUX_TIPB' + TStrUtils.fStrZero(intCont, 2)).AsString = 'C' Then
     Begin
       {strDesc  := dtsCadTin.FieldByName('DUX_DESCRI').AsString + ' - ' +
                   dtsCadTin.FieldByName('DUX_CODDUX').AsString + ' - ' +
                   'CATALISADOR ' + dtsCadTin.FieldByName('DUX_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString;
                   }

       strDesc  := dtsCadTin.FieldByName('DUX_DESCRI').AsString + ' - ' +
                   dtsCadTin.FieldByName('DUX_CODDUX').AsString + ' - ' +
                   dtsCadTin.FieldByName('DUX_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString;

       Break;
     End;
  End;

  If (strDesc <> '') Then
    Result :=  strDesc
  Else
    Result := dtsCadTin.FieldByName('DUX_DESCRI').AsString + ' - ' +
              dtsCadTin.FieldByName('DUX_CODDUX').AsString;
end;

function TFormulaAutomotivaDuxone.GetDescricaoBase(strCodBas: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DESBAS '+
                    '  FROM DUX_CADBAS '+
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

function TFormulaAutomotivaDuxone.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaAutomotivaDuxone.GetIdePro: String;
begin
  Result := 'DUX';
end;

function TFormulaAutomotivaDuxone.GetIndEmb(
  const dtsCadTin: IDataSet): integer;
begin
  Result := 0;
end;

function TFormulaAutomotivaDuxone.GetLinha(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('DUX_LINHA_').AsString;
end;

function TFormulaAutomotivaDuxone.GetMontadora(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('DUX_MONTAD').AsString;
end;

function TFormulaAutomotivaDuxone.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaAutomotivaDuxone.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaAutomotivaDuxone.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaAutomotivaDuxone.GetNomeTabelaBases: String;
begin
  Result := 'DUX_CADBAS';
end;

function TFormulaAutomotivaDuxone.GetPrefixoFormulacao: String;
begin
  Result := 'DUX_BASE';
end;

function TFormulaAutomotivaDuxone.GetPrefixoLitragem(
  const strModo: String): String;
begin
  Result := 'DUX_LITRAG';
end;

function TFormulaAutomotivaDuxone.GetPrefixoQuantidade(const strModo: String): String;
begin
  If strModo = 'C' Then
    Result := 'DUX_QTDC'
  Else
    Result := 'DUX_QTDD';
end;

function TFormulaAutomotivaDuxone.GetProdutoChapinha: String;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGet('PROCHA');
end;

function TFormulaAutomotivaDuxone.GetProdutoVendaTinta(const dtsCadTin: IDataSet): string;
begin
  Result := '';
  Result := TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGet('PRODUX');

end;

function TFormulaAutomotivaDuxone.GetQualidade(
  const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('DUX_QUALID').AsString;
end;

function TFormulaAutomotivaDuxone.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaAutomotivaDuxone.GetSelectBases: String;
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

function TFormulaAutomotivaDuxone.GetTextoInformativoCalculo: String;
begin
  Result :=
  'VolumeFormula       = ' + FloatToStrF(VolumeOri, ffFixed, 12, 4)          + sLineBreak +
  'Preço Base "Gramas" = (Preço / Embalagem) * Quantidade'                   + sLineBreak +
  'Preço Base "MLs"    = (Preço / Embalagem / Peso Específico) * Quantidade' + sLineBreak +
  'Preço da Tinta      = Soma do valor de todas as bases.';
end;

function TFormulaAutomotivaDuxone.GetUniversal(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaDuxone.GetUsaChapinha(
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := (dtsCadTin.FieldByName('DUX_PROCHA').AsString = 'S');
end;

function TFormulaAutomotivaDuxone.GetVolumeMaximoBalde(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Balde') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGetDouble('VOLBAL'), 3);
end;

function TFormulaAutomotivaDuxone.GetVolumeMaximoCopo(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Copo') Then
  Begin
    Result := 0.500;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGetDouble('VOLCOP'), 3);
end;

function TFormulaAutomotivaDuxone.GetVolumeMaximoGalao(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 4.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGetDouble('VOLGAL'), 3);
end;

function TFormulaAutomotivaDuxone.GetVolumeMaximoLata(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGetDouble('VOLLAT'), 3);
end;

function TFormulaAutomotivaDuxone.GetVolumeMaximoLitro(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 1.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGetDouble('VOL1_4'), 3);
end;

function TFormulaAutomotivaDuxone.GetVolumeMaximoSprayDuco(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Spray Duco') Then
  Begin
    Result := 0.150;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGetDouble('VOLSDU'), 3);
end;

function TFormulaAutomotivaDuxone.GetVolumeMaximoSprayPoli(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Spray Poli') Then
  Begin
    Result := 0.150;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGetDouble('VOLSPO'), 3);
end;

function TFormulaAutomotivaDuxone.GetVolumeMaximoSpraySint(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Spray Sint') Then
  Begin
    Result := 0.150;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGetDouble('VOLSPS'), 3);
end;

function TFormulaAutomotivaDuxone.GetVolumeMaximoTambor(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Tambor') Then
  Begin
    Result := 200.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGetDouble('VOLTAM'), 3);
end;

function TFormulaAutomotivaDuxone.GetVolumePadraCopo: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Copo') Then
  Begin
    Result := 0.500;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGetDouble('VOLCOP'), 3);
end;

function TFormulaAutomotivaDuxone.GetVolumePadraGalao(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 3.600;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGetDouble('VOLGAL'), 3);
end;

function TFormulaAutomotivaDuxone.GetVolumePadraoBalde(dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Balde') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGetDouble('VOLBAL'), 3);
end;

function TFormulaAutomotivaDuxone.GetVolumePadraoLata(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGetDouble('VOLLAT'), 3);
end;

function TFormulaAutomotivaDuxone.GetVolumePadraoSprayDuco: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Spray Duco') Then
  Begin
    Result := 0.150;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGetDouble('VOLSDU'), 3);
end;

function TFormulaAutomotivaDuxone.GetVolumePadraoSprayPoli: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Spray Poli') Then
  Begin
    Result := 0.150;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGetDouble('VOLSPO'), 3);
end;

function TFormulaAutomotivaDuxone.GetVolumePadraoSpraySint: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Spray Sint') Then
  Begin
    Result := 0.150;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGetDouble('VOLSPS'), 3);
end;

function TFormulaAutomotivaDuxone.GetVolumePadraSpray: Double;
begin
  Result := 0;
end;

function TFormulaAutomotivaDuxone.GetVolumePadraTambor(dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Tambor') Then
  Begin
    Result := 196.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGetDouble('VOLTAM'), 3);
end;

function TFormulaAutomotivaDuxone.GetVolumePermitido(
  const dtsCadTin: IDataSet; strTipoPre: String): Double;
begin
  Result := 0;
end;

procedure TFormulaAutomotivaDuxone.pCalculaImpostosSaida(
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

procedure TFormulaAutomotivaDuxone.pDefineVolumeOriginal;
begin
  //
end;

procedure TFormulaAutomotivaDuxone.pPreencheProdutoEmbagemVenda;
var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('DUX');

  DesEmb.Clear;

  DesEmb.Add('DUXONE');
  ProEmbLt.Add(conf.fGet('ITE1_4'));
  ProEmbGl.Add(conf.fGet('ITEGAL'));
  ProEmbLa.Add(conf.fGet('ITELAT'));

  {DesEmb.Add('NASON');
  ProEmbLt.Add(conf.fGet('NASOLT'));
  ProEmbGl.Add(conf.fGet('NASOGL'));
  ProEmbLa.Add(conf.fGet('NASOLA'));

  DesEmb.Add('CHROMA');
  ProEmbLt.Add(conf.fGet('CHROLT'));
  ProEmbGl.Add(conf.fGet('CHROGL'));
  ProEmbLa.Add(conf.fGet('CHROLA'));

  DesEmb.Add('IMRON');
  ProEmbLt.Add(conf.fGet('IMROLT'));
  ProEmbGl.Add(conf.fGet('IMROGL'));
  ProEmbLa.Add(conf.fGet('IMROLA'));

  DesEmb.Add('CORMAX');
  ProEmbLt.Add(conf.fGet('CORMLT'));
  ProEmbGl.Add(conf.fGet('CORMGL'));
  ProEmbLa.Add(conf.fGet('CORMLA')); }

  sProEmbCo := conf.fGet('ITECOP');
  sProEmbTb := conf.fGet('ITETAM');
  sProEmbBa := conf.fGet('ITEBAL');
  sProEmbSs := conf.fGet('ITESPS');
  sProEmbPo := conf.fGet('ITESPO');
  sProEmbSd := conf.fGet('ITESDU');
  sProEmbSp := '';
  sProEmbLa := '';
end;

procedure TFormulaAutomotivaDuxone.pPreencherPesCorFor(
  const dtsCadTin: IDataSet);
begin
  inherited;
  Self.PesoCor := 0;
  Self.PesoFor := 0;
end;

{$IFNDEF LINUX}
procedure TFormulaAutomotivaDuxone.pRecalculaFormulaMostrarDigitado(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; fltFator: Double;
  blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha: String;
  strTipBas: String);
var
  intDec: Integer;
begin
  intDec := StrToIntDef(TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGet('DECFOR'), 1);

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
{$ENDIF}

{$IFNDEF LINUX}
procedure TFormulaAutomotivaDuxone.pRecalculaFormulaMostrarPadrao(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; blnConsLinhaDesBas: Boolean;
  strTipBas: String; intCont: Integer);
var
  intDec: Integer;
begin
  intDec := StrToIntDef(TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGet('DECFOR'), 1);

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

procedure TFormulaAutomotivaDuxone.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('DUX_ACRMOB').AsFloat;
end;

procedure TFormulaAutomotivaDuxone.PreencheQuantidadeFormulacaoVenda(
  const dtsCadTin: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
begin
  For intContador := 1 To Self.GetQuantidadeFormulacao Do
  Begin
    If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('DUX_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
      Continue;

    Base := TBaseAutomotiva(Self.Add);
    Base.IdePro                := 'DUX';
    Base.CodigoBase            := dtsCadTin.FieldByName('DUX_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString;



    If TStrUtils.fEmptyStr(dtsCadTin.FieldByName('DUX_CODNFM').AsString) Then
    Begin
      Base.QuantidadeConcentrado := RoundTo(dtsCadTin.FieldByName('DUX_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat, -1);
      Base.QuantidadeDiluido     := RoundTo(dtsCadTin.FieldByName('DUX_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat, -1);
    End
    Else
    Begin
      Base.QuantidadeConcentrado := (dtsCadTin.FieldByName('DUX_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat);
      Base.QuantidadeDiluido     := (dtsCadTin.FieldByName('DUX_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat);
    End;

    Base.TipoBase              := dtsCadTin.FieldByName('DUX_TIPB' + TStrUtils.fStrZero(intContador, 2)).AsString;
    Base.Qualidade             := dtsCadTin.FieldByName('DUX_QUALID').AsString;
  End;
end;

procedure TFormulaAutomotivaDuxone.PreencheVolumeVenda(const dtsCadTin: IDataSet);
begin
  Self.VolumeOri := dtsCadTin.FieldByName('DUX_LITRAG').AsFloat / 1000;
end;

end.
