{************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula Dupont   *}
{*********************************************************************AC*}
unit untFormulaAutomotivaDupont;

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
  TFormulaAutomotivaDupont = class(TAbstractFormulaAutomotiva)
  private
    function Sgn(X: Extended): Integer;
    function RoundToExp(const AValue: Currency; const ADigit: TRoundToRange): Currency;
    function RoundUp(X: Extended): Extended;
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
    procedure RecalcularTabelasGeneric(dicRetorno: IDicionario); Override;
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

    function GetVolumeMaximoLitro(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoGalao(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoLata(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoBalde(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoTambor(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoCopo(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoSpraySint(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoSprayPoli(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoSprayDuco(dtsCadTin: IDataSet): Double; Override;

    function fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer; dtsCadTin: IDataSet): Double; override;
    function GetVolumePadraGalao(dtsCadTin: IDataSet): Double; override;
    function GetVolumePadraoLata(dtsCadTin: IDataSet): Double; override;
    function GetVolumePadraoBalde(dtsCadTin: IDataSet): Double; override;
    function GetVolumePadraoSprayDuco : Double; override;
    function GetVolumePadraoSprayPoli : Double; override;
    function GetVolumePadraoSpraySint : Double;  override;

    function fExisteConfiguracao(dtsCadTin: IDataSet; strEmbalagem: String): Boolean; Override;
    function fRetEmbLitro(dtsCadTin: IDataSet): String;
    function fRetEmbGalao(dtsCadTin: IDataSet): String;
    function fRetEmbLata(dtsCadTin: IDataSet): String;

    function GetUsaChapinha(const dtsCadTin: IDataSet): Boolean; Override;
    function GetProdutoChapinha(): String; Override;
    procedure pCalculaImpostosSaida(Var dicRetorno: IDicionario); Override;
  end;

implementation

uses
  untAbstractCalculadorFormulaAutomotiva, untAutcomTintaFactory ;

{ TFormulaAutomotivaDupont }

procedure TFormulaAutomotivaDupont.CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva);
begin
  If dataSetBases.FieldByName('BAS_PESGRA').AsString = 'S' Then
    Base.Cnv_Ml := Base.Embalagem
  Else
    Base.Cnv_Ml := Base.Embalagem / Base.PesoEspecifico;
end;

function TFormulaAutomotivaDupont.fExisteConfiguracao(dtsCadTin: IDataSet;
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
    qryConf.SQL := qryConf.SQL + '    CFG_IDEPRO = "DUP" AND            ';
    qryConf.SQL := qryConf.SQL + '    CFG_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" AND          ';

    If strEmbalagem = 'Litro' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "' + fRetEmbLitro(dtsCadTin) + '"      '
    Else If strEmbalagem = 'Galão' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "' + fRetEmbGalao(dtsCadTin) + '"      '
    Else If strEmbalagem = 'Lata' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "' + fRetEmbLata(dtsCadTin) + '"       '
    Else If strEmbalagem = 'Balde' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLBAL"       '
    Else If strEmbalagem = 'Copo' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLCOP"       '
    Else If strEmbalagem = 'Spray Duco' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLSDU"       '
    Else If strEmbalagem = 'Spray Poli' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLSPO"       '
    Else If strEmbalagem = 'Spray Sint' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLSPS"       '
    Else If strEmbalagem = 'Tambor' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLTAM"       ';

    qryConf.Open;

    Result := (Not qryConf.IsEmpty);
  Except
    Raise;
  End;
end;

function TFormulaAutomotivaDupont.fGetFormulaEspecial(strCodigo: String): Boolean;
begin
  Result := Pos('ESP',strCodigo) > 0;
end;

function TFormulaAutomotivaDupont.fMostrarComCatalisador: Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaDupont.fQuantidadeMenorIgualZero: Boolean;
var
  intContador: Integer;
  Base: TBaseAutomotiva;
  fltFator: Double;
  intDec: Integer;
  strOperadorLiberou: String;
begin
  Result := False;

  strOperadorLiberou := '';


  If Copy(Self.CodFormul, 1, 3) = 'ESP' Then
  Begin
    If Self.VolumePro < 0.001 Then
    Begin
      TAutcomTintaFactory.Get.fMensagem('AVISO', 'O volume mínimo deve ser maior que ' + FloatToStr(Self.VolumePro), ['&Ok']);
      Result := True;
      Exit;
    End;
  End
  Else
  Begin
    If mveModoVenda = mvConcentrado Then
    Begin
      If Self.VolumePro < 0.05 Then
      Begin
        TAutcomTintaFactory.Get.fMensagem('AVISO', 'Volume mínimo concentrado permitido para a tinta Axalta é 0,050 ml!', ['&Ok']);
        Result := True;
        Exit;
      End;
    End
    Else
    Begin
      If Self.VolumePro < 0.1 Then
      Begin
        TAutcomTintaFactory.Get.fMensagem('AVISO', 'Volume mínimo diluído permitido para a tinta Axalta é 0,100 ml!', ['&Ok']);
        Result := True;
        Exit;
      End;
    End;
  End;

  If Self.VolumeOri > 0 Then
    fltFator := Self.VolumePro / Self.VolumeOri
  Else
    fltFator := 1;

  If Self.fVolumeOriginalFator Then
    fltFator := fltFator * 1000;

  intDec := StrToIntDef(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGet('DECFOR'), 1);

  For intContador := 0 To Self.Count-1 Do
  Begin
    Base := TBaseAutomotiva(Self.Items[intContador]);

    If ((mveModoVenda = mvConcentrado) And (Base.TipoBase = 'B') And
        (RoundToExp(Base.QuantidadeConcentrado * fltFator, - intDec) <= 0) And
        (Copy(Self.CodFormul,1,3) <> 'ESP')) Or
       ((mveModoVenda = mvDiluido) And (RoundToExp(Base.QuantidadeDiluido * fltFator, - intDec) <= 0)) Then
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

function TFormulaAutomotivaDupont.fRetEmbGalao(dtsCadTin: IDataSet): String;
begin
  Result := '';

  If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'DUXONE' Then
    Result := 'VOLGAL'
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'NASON' Then
    Result := 'VOLNGL'
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'CHROMA' Then
    Result := 'VOLCGL'
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'IMRON' Then
    Result := 'VOLIGL'
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'CORMAX' Then
    Result := 'VOLMGL';
end;

function TFormulaAutomotivaDupont.fRetEmbLata(dtsCadTin: IDataSet): String;
begin
  Result := '';

  If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'DUXONE' Then
    Result := 'VOLLAT'
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'NASON' Then
    Result := 'VOLNLA'
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'CHROMA' Then
    Result := 'VOLCLA'
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'IMRON' Then
    Result := 'VOLILA'
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'CORMAX' Then
    Result := 'VOLMLA';
end;

function TFormulaAutomotivaDupont.fRetEmbLitro(dtsCadTin: IDataSet): String;
begin
  Result := '';

  If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'DUXONE' Then
    Result := 'VOL1_4'
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'NASON' Then
    Result := 'VOLNLT'
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'CHROMA' Then
    Result := 'VOLCLT'
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'IMRON' Then
    Result := 'VOLILT'
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'CORMAX' Then
    Result := 'VOLMLT';
end;

function TFormulaAutomotivaDupont.fRetornaCatalisadorVenda(blnComCat: Boolean;
  strTipPre, strListaAdicional: String): String;
begin
  Result := TAutcomTintaFactory.Get.IIF(blnComCat, 'S', 'N');
end;

function TFormulaAutomotivaDupont.fTipoEmbalagem(intIndEmb: Integer;
  strQualid: String): Boolean;
begin
  Result := ((intIndEmb = 0) And (strQualid = 'BP')) or (intIndEmb = 4);
end;

function TFormulaAutomotivaDupont.fValidaVolumeFormulucao(strTipoPre: String;
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaDupont.fVolumeOriginalFator: Boolean;
begin
  Result := False;
end;

function TFormulaAutomotivaDupont.fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer;
  dtsCadTin: IDataSet): Double;
begin
  Result := 0.900;

  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 0.900;
    Exit;
  End;

  If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'DUXONE' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOL1_4'), 3)
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'NASON' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLNLT'), 3)
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'CHROMA' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLCLT'), 3)
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'IMRON' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLILT'), 3)
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'CORMAX' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLMLT'), 3);
end;

function TFormulaAutomotivaDupont.GetAcrescimoDespesaOperacionalTinta: Double;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('DESOPE');
end;

function TFormulaAutomotivaDupont.GetAno(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('DUP_ANOCOR').AsString;
end;

function TFormulaAutomotivaDupont.GetBasesPorEmpresa(const dicRetorno: IDicionario): String;
begin
  If TAutcomTintaFactory.Get.GetEmpBasDup Then
  Begin
    If (Not TStrUtils.fEmptyStr(Self.EmpresaProducao)) And (Self.OprFlj = 'S') Then
      Result := ' AND BAS_CODEMP = ' + QuotedStr(Self.EmpresaProducao)
    Else If Not (TStrUtils.fEmptyStr(Self.EmpCd_)) And (Self.CD_S_N = 'S') Then
      Result := ' AND BAS_CODEMP = ' + QuotedStr(Self.EmpCd_)
    Else If Not (TStrUtils.fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
      Result := ' AND BAS_CODEMP = ' + QuotedStr(Self.EmpFat)
    Else
      Result := ' AND BAS_CODEMP = ' + QuotedStr(TAutcomTintaFactory.Get.GetCodEmp);
  End;

  {Result := ' AND BAS_CODEMP = ' + QuotedStr(TAutcomTintaFactory.Get.IIF(TStrUtils.fEmptyStr(TVariantUtils.IfNull(dicRetorno['codempprd'],''))
                                                                         , TAutcomTintaFactory.Get.GetCodEmp
                                                                         , dicRetorno['codempprd']));}
end;

function TFormulaAutomotivaDupont.GetBasPesGra(
  const dataSetBases: IDataSet): String;
begin
  Result := dataSetBases.FieldByName('BAS_PESGRA').AsString;
end;

function TFormulaAutomotivaDupont.GetCalcDespesasOperacionais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  if fGetFormulaEspecial(formula.CodFormul) Then
    fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri)
  Else
    fltQtdFor := RoundToExp(fltQtdFor * formula.VolumePro / formula.VolumeOri, -1);

  If base.PesGra = 'S' Then
    fltVenBas := (fltQtdFor * (base.PrecoVenda / base.Embalagem))
  Else
    fltVenBas := (fltQtdFor * (base.PrecoVenda / base.Embalagem / base.PesoEspecifico));

  Result := (fltVenBas * base.DespesasOperacionais / 100);
end;

function TFormulaAutomotivaDupont.GetCalcIcmsSaida(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  if fGetFormulaEspecial(formula.CodFormul) Then
    fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri)
  Else
    fltQtdFor := RoundToExp(fltQtdFor * formula.VolumePro / formula.VolumeOri, -1);


  If base.PesGra = 'S' Then
    fltVenBas := (fltQtdFor * (base.PrecoVenda / base.Embalagem))
  Else
    fltVenBas := (fltQtdFor * (base.PrecoVenda / base.Embalagem / base.PesoEspecifico));

  Result := (fltVenBas * base.IcmsSaida / 100);
end;

function TFormulaAutomotivaDupont.GetCalcImpostosFederais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  if fGetFormulaEspecial(formula.CodFormul) Then
    fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri)
  Else
    fltQtdFor := RoundToExp(fltQtdFor * formula.VolumePro / formula.VolumeOri, -1);

  If base.PesGra = 'S' Then
    fltVenBas := (fltQtdFor * (base.PrecoVenda / base.Embalagem))
  Else
    fltVenBas := (fltQtdFor * (base.PrecoVenda / base.Embalagem / base.PesoEspecifico));

  Result := (fltVenBas * base.ImpostosFederais / 100);
end;

function TFormulaAutomotivaDupont.GetCalcOutrosValores(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  if fGetFormulaEspecial(formula.CodFormul) Then
    fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri)
  Else
    fltQtdFor := RoundToExp(fltQtdFor * formula.VolumePro / formula.VolumeOri, -1);


  If base.PesGra = 'S' Then
    Result := (fltQtdFor * (base.OutrosValores / base.Embalagem))
  Else
    Result := (fltQtdFor * (base.OutrosValores / Base.Embalagem / Base.PesoEspecifico));
end;

function TFormulaAutomotivaDupont.GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  if fGetFormulaEspecial(formula.CodFormul) Then
    fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri)
  Else
    fltQtdFor := RoundToExp(fltQtdFor * formula.VolumePro / formula.VolumeOri, -1);

  If base.PesGra = 'S' Then
    Result := (fltQtdFor * (base.PrecoCompraLiquido / base.Embalagem))
  Else
    Result := (fltQtdFor * (base.PrecoCompraLiquido / Base.Embalagem / Base.PesoEspecifico));
end;

function TFormulaAutomotivaDupont.GetCalcPrecoCusto(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  if fGetFormulaEspecial(formula.CodFormul) Then
    fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri)
  Else
    fltQtdFor := RoundToExp(fltQtdFor * formula.VolumePro / formula.VolumeOri, -1);

  If base.PesGra = 'S' Then
    Result := (fltQtdFor * (base.PrecoCusto / base.Embalagem))
  Else
    Result := (fltQtdFor * (base.PrecoCusto / base.Embalagem / base.PesoEspecifico));
end;

function TFormulaAutomotivaDupont.GetCalcPrecoCustoReal(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  if fGetFormulaEspecial(formula.CodFormul) Then
    fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri)
  Else
    fltQtdFor := RoundToExp(fltQtdFor * formula.VolumePro / formula.VolumeOri, -1);


  If base.PesGra = 'S' Then
    Result := (fltQtdFor * (base.PrecoCustoReal / base.Embalagem))
  Else
    Result := (fltQtdFor * (base.PrecoCustoReal / Base.Embalagem / Base.PesoEspecifico));
end;

function TFormulaAutomotivaDupont.GetCalcPrecoMedio(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  if fGetFormulaEspecial(formula.CodFormul) Then
    fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri)
  Else
    fltQtdFor := RoundToExp(fltQtdFor * formula.VolumePro / formula.VolumeOri, -1);

  If base.PesGra = 'S' Then
    Result := (fltQtdFor * (base.PrecoMedio / base.Embalagem))
  Else
    Result := (fltQtdFor * (base.PrecoMedio / Base.Embalagem / Base.PesoEspecifico));
end;

function TFormulaAutomotivaDupont.GetCalcPrecoVenda(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  if fGetFormulaEspecial(formula.CodFormul) Then
    fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri)
  Else
    fltQtdFor := RoundToExp(fltQtdFor * formula.VolumePro / formula.VolumeOri, -1);

  If base.PesGra = 'S' Then
    Result := (fltQtdFor * (base.PrecoVenda / base.Embalagem))
  Else
    Result := (fltQtdFor * (base.PrecoVenda / Base.Embalagem / Base.PesoEspecifico));
end;

function TFormulaAutomotivaDupont.GetCalcQuantidade(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  if fGetFormulaEspecial(formula.CodFormul) Then
    Result := (TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido)
               * formula.VolumePro / formula.VolumeOri)
  Else
    Result := RoundToExp(TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido)
               * formula.VolumePro / formula.VolumeOri, -1);
end;

function TFormulaAutomotivaDupont.GetCalculadorInterno: ICalculadorFormulaAutomotiva;
begin
  Result := TAbstractCalculadorFormulaAutomotiva.Create(Self);
end;

function TFormulaAutomotivaDupont.GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  if fGetFormulaEspecial(formula.CodFormul) Then
    fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri)
  Else
    fltQtdFor := RoundToExp(fltQtdFor * formula.VolumePro / formula.VolumeOri, -1);

  If base.PesGra = 'S' Then
    Result := (fltQtdFor * (base.UltimoPrecoCompra / base.Embalagem))
  Else
    Result := (fltQtdFor * (base.UltimoPrecoCompra / Base.Embalagem / Base.PesoEspecifico));
end;

function TFormulaAutomotivaDupont.GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  if fGetFormulaEspecial(formula.CodFormul) Then
    fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri)
  Else
    fltQtdFor := RoundToExp(fltQtdFor * formula.VolumePro / formula.VolumeOri, -1);

  If base.PesGra = 'S' Then
    Result := (fltQtdFor * (base.UltimoPrecoCompraImpostos / base.Embalagem))
  Else
    Result := (fltQtdFor * (base.UltimoPrecoCompraImpostos / Base.Embalagem / Base.PesoEspecifico));
end;

function TFormulaAutomotivaDupont.GetChaFor(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('DUP_DESCRI').AsString + ' ' +
            dtsCadTin.FieldByName('DUP_MONTAD').AsString + ' ' +
            dtsCadTin.FieldByName('DUP_QUALID').AsString + ' ' +
            dtsCadTin.FieldByName('DUP_CODDUP').AsString + ' ' +
            dtsCadTin.FieldByName('DUP_ALTERN').AsString + ' ' +
            dtsCadTin.FieldByName('DUP_REGIAO').AsString;
end;

function TFormulaAutomotivaDupont.GetChaForEspecifico(
  const dicRetorno: IDicionario; const dtsCadTin: IDataSet): String;
begin
  Result := dicRetorno['chafor'] + dicRetorno['tipemb'];
end;


function TFormulaAutomotivaDupont.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('DUP_MD5KEY').AsString;
end;

function TFormulaAutomotivaDupont.GetCodFormul(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('DUP_CODDUP').AsString;
end;

function TFormulaAutomotivaDupont.GetDescricao(const dtsCadTin: IDataSet): String;
Var
  IntCont  : Integer;
  strDesc  : String;
begin
  strDesc := '';

  For intCont := 1 To 20 Do
  Begin
     If dtsCadTin.FieldByName('DUP_TIPB' + TStrUtils.fStrZero(intCont, 2)).AsString = 'C' Then
     Begin
       strDesc  := dtsCadTin.FieldByName('DUP_DESCRI').AsString + ' - ' +
                   dtsCadTin.FieldByName('DUP_CODDUP').AsString + ' - ' +
                   'CATALISADOR ' + dtsCadTin.FieldByName('DUP_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString;
       Break;
     End;
  End;

  If (strDesc <> '') Then
    Result :=  strDesc
  Else
    Result := dtsCadTin.FieldByName('DUP_DESCRI').AsString + ' - ' +
              dtsCadTin.FieldByName('DUP_CODDUP').AsString;
end;

function TFormulaAutomotivaDupont.GetDescricaoBase(strCodBas: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DESBAS FROM DUP_CADBAS WHERE BAS_CODBAS = :CODBAS';
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

function TFormulaAutomotivaDupont.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaAutomotivaDupont.GetIdePro: String;
begin
  Result := 'DUP';
end;

function TFormulaAutomotivaDupont.GetIndEmb(
  const dtsCadTin: IDataSet): integer;
begin
  Result := -1;

  if dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'DUXONE' then
    Result := 0
  else if dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'NASON' then
    Result := 1
  else if dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'CHROMA' then
    Result := 2
  else if dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'IMRON' then
    Result := 3
  else if dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'CORMAX' then
    Result := 4;
end;

function TFormulaAutomotivaDupont.GetLinha(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('DUP_LINHA_').AsString;
end;

function TFormulaAutomotivaDupont.GetMontadora(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('DUP_MONTAD').AsString;
end;

function TFormulaAutomotivaDupont.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaAutomotivaDupont.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaAutomotivaDupont.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaAutomotivaDupont.GetNomeTabelaBases: String;
begin
  Result := 'DUP_CADBAS';
end;

function TFormulaAutomotivaDupont.GetPrefixoFormulacao: String;
begin
  Result := 'DUP_BASE';
end;

function TFormulaAutomotivaDupont.GetPrefixoLitragem(
  const strModo: String): String;
begin
  Result := 'DUP_LITRAG';
end;

function TFormulaAutomotivaDupont.GetPrefixoQuantidade(const strModo: String): String;
begin
  If strModo = 'C' Then
    Result := 'DUP_QTDC'
  Else
    Result := 'DUP_QTDD';
end;

function TFormulaAutomotivaDupont.GetProdutoChapinha: String;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGet('PROCHA');
end;

function TFormulaAutomotivaDupont.GetProdutoVendaTinta(const dtsCadTin: IDataSet): string;
begin
  Result := '';

  if Pos('CHROMA', dtsCadTin.FieldByName('DUP_LINHA_').AsString) > 0 then
    Result := TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGet('PROCHR')
  else if Pos('DUXONE', dtsCadTin.FieldByName('DUP_LINHA_').AsString) > 0 then
    Result := TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGet('PRODUX')
  else if Pos('IMRON', dtsCadTin.FieldByName('DUP_LINHA_').AsString) > 0 then
    Result := TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGet('PROIRO')
  else if Pos('CORMAX', dtsCadTin.FieldByName('DUP_LINHA_').AsString) > 0 then
    Result := TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGet('PROCOR')
  else if Pos('NASON', dtsCadTin.FieldByName('DUP_LINHA_').AsString) > 0 then
    Result := TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGet('PRONAS');
end;

function TFormulaAutomotivaDupont.GetQualidade(
  const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('DUP_QUALID').AsString;
end;

function TFormulaAutomotivaDupont.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaAutomotivaDupont.GetSelectBases: String;
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

function TFormulaAutomotivaDupont.GetTextoInformativoCalculo: String;
begin
  Result :=
  'VolumeFormula       = ' + FloatToStrF(VolumeOri, ffFixed, 12, 4)          + sLineBreak +
  'Preço Base "Gramas" = (Preço / Embalagem) * Quantidade'                   + sLineBreak +
  'Preço Base "MLs"    = (Preço / Embalagem / Peso Específico) * Quantidade' + sLineBreak +
  'Preço da Tinta      = Soma do valor de todas as bases.';
end;

function TFormulaAutomotivaDupont.GetUniversal(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaDupont.GetUsaChapinha(
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := (dtsCadTin.FieldByName('DUP_PROCHA').AsString = 'S');
end;

function TFormulaAutomotivaDupont.GetVolumeMaximoBalde(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Balde') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLBAL'), 3);
end;

function TFormulaAutomotivaDupont.GetVolumeMaximoCopo(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Copo') Then
  Begin
    Result := 0.500;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLCOP'), 3);
end;

function TFormulaAutomotivaDupont.GetVolumeMaximoGalao(
  dtsCadTin: IDataSet): Double;
begin
  Result := 4.000;

  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 4.000;
    Exit;
  End;

  If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'DUXONE' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLGAL'), 3)
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'NASON' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLNGL'), 3)
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'CHROMA' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLCGL'), 3)
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'IMRON' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLIGL'), 3)
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'CORMAX' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLMGL'), 3);
end;

function TFormulaAutomotivaDupont.GetVolumeMaximoLata(
  dtsCadTin: IDataSet): Double;
begin
  Result := 18.000;

  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'DUXONE' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLLAT'), 3)
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'NASON' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLNLA'), 3)
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'CHROMA' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLCLA'), 3)
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'IMRON' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLILA'), 3)
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'CORMAX' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLMLA'), 3);
end;

function TFormulaAutomotivaDupont.GetVolumeMaximoLitro(
  dtsCadTin: IDataSet): Double;
begin
  Result := 1.000;

  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 1.000;
    Exit;
  End;

  If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'DUXONE' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOL1_4'), 3)
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'NASON' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLNLT'), 3)
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'CHROMA' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLCLT'), 3)
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'IMRON' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLILT'), 3)
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'CORMAX' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLMLT'), 3);
end;

function TFormulaAutomotivaDupont.GetVolumeMaximoSprayDuco(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Spray Duco') Then
  Begin
    Result := 0.150;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLSDU'), 3);
end;

function TFormulaAutomotivaDupont.GetVolumeMaximoSprayPoli(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Spray Poli') Then
  Begin
    Result := 0.150;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLSPO'), 3);
end;

function TFormulaAutomotivaDupont.GetVolumeMaximoSpraySint(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Spray Sint') Then
  Begin
    Result := 0.150;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLSPS'), 3);
end;

function TFormulaAutomotivaDupont.GetVolumeMaximoTambor(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Tambor') Then
  Begin
    Result := 200.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLTAM'), 3);
end;

function TFormulaAutomotivaDupont.GetVolumePadraCopo: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Copo') Then
  Begin
    Result := 0.500;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLCOP'), 3);
end;

function TFormulaAutomotivaDupont.GetVolumePadraGalao(
  dtsCadTin: IDataSet): Double;
begin
  Result := 3.600;

  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 3.600;
    Exit;
  End;

  If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'DUXONE' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLGAL'), 3)
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'NASON' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLNGL'), 3)
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'CHROMA' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLCGL'), 3)
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'IMRON' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLIGL'), 3)
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'CORMAX' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLMGL'), 3);
end;

function TFormulaAutomotivaDupont.GetVolumePadraoBalde(dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Balde') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLBAL'), 3);
end;

function TFormulaAutomotivaDupont.GetVolumePadraoLata(
  dtsCadTin: IDataSet): Double;
begin
  Result := 18.000;

  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'DUXONE' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLLAT'), 3)
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'NASON' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLNLA'), 3)
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'CHROMA' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLCLA'), 3)
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'IMRON' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLILA'), 3)
  Else If dtsCadTin.FieldByName('DUP_LINHA_').AsString = 'CORMAX' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLMLA'), 3);
end;

function TFormulaAutomotivaDupont.GetVolumePadraoSprayDuco: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Spray Duco') Then
  Begin
    Result := 0.150;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLSDU'), 3);
end;

function TFormulaAutomotivaDupont.GetVolumePadraoSprayPoli: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Spray Poli') Then
  Begin
    Result := 0.150;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLSPO'), 3);
end;

function TFormulaAutomotivaDupont.GetVolumePadraoSpraySint: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Spray Sint') Then
  Begin
    Result := 0.150;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLSPS'), 3);
end;

function TFormulaAutomotivaDupont.GetVolumePadraSpray: Double;
begin
  Result := 0;
end;

function TFormulaAutomotivaDupont.GetVolumePadraTambor(dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Tambor') Then
  Begin
    Result := 196.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetDouble('VOLTAM'), 3);
end;

function TFormulaAutomotivaDupont.GetVolumePermitido(
  const dtsCadTin: IDataSet; strTipoPre: String): Double;
begin
  Result := 0;
end;

procedure TFormulaAutomotivaDupont.pCalculaImpostosSaida(
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

procedure TFormulaAutomotivaDupont.pDefineVolumeOriginal;
begin
  //
end;

procedure TFormulaAutomotivaDupont.pPreencheProdutoEmbagemVenda;
var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('DUP');

  DesEmb.Add('DUXONE');
  ProEmbLt.Add(conf.fGet('ITE1_4'));
  ProEmbGl.Add(conf.fGet('ITEGAL'));
  ProEmbLa.Add(conf.fGet('ITELAT'));

  DesEmb.Add('NASON');
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
  ProEmbLa.Add(conf.fGet('CORMLA'));

  sProEmbCo := conf.fGet('ITECOP');
  sProEmbTb := conf.fGet('ITETAM');
  sProEmbBa := conf.fGet('ITEBAL');
  sProEmbSs := conf.fGet('ITESPS');
  sProEmbPo := conf.fGet('ITESPO');
  sProEmbSd := conf.fGet('ITESDU');
  sProEmbSp := '';
  sProEmbLa := '';
end;

procedure TFormulaAutomotivaDupont.pPreencherPesCorFor(
  const dtsCadTin: IDataSet);
begin
  inherited;
  Self.PesoCor := 0;
  Self.PesoFor := 0;
end;

{$IFNDEF LINUX}
procedure TFormulaAutomotivaDupont.pRecalculaFormulaMostrarDigitado(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; fltFator: Double;
  blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha: String;
  strTipBas: String);
var
  intDec: Integer;
begin
  intDec := StrToIntDef(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGet('DECFOR'), 1);

  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    SubItems.Add(FloatToStrF(RoundToExp(Base.QuantidadeConcentrado * fltFator, - intDec), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(RoundToExp(Base.QuantidadeDiluido * fltFator, - intDec), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(RoundToExp(Base.QuantidadeDiluido2 * fltFator, - intDec), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TFormulaAutomotivaDupont.pRecalculaFormulaMostrarPadrao(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; blnConsLinhaDesBas: Boolean;
  strTipBas: String; intCont: Integer);
var
  intDec: Integer;
begin
  intDec := StrToIntDef(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGet('DECFOR'), 1);

  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    SubItems.Add(FloatToStrF(RoundToExp(Base.QuantidadeConcentrado, - intDec), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(RoundToExp(Base.QuantidadeDiluido, - intDec), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(RoundToExp(Base.QuantidadeDiluido2, - intDec), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

procedure TFormulaAutomotivaDupont.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('DUP_ACRMOB').AsFloat;
end;

procedure TFormulaAutomotivaDupont.PreencheQuantidadeFormulacaoVenda(
  const dtsCadTin: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
begin
  For intContador := 1 To Self.GetQuantidadeFormulacao Do
  Begin
    If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('DUP_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
      Continue;

    Base := TBaseAutomotiva(Self.Add);
    Base.IdePro                := 'DUP';
    Base.CodigoBase            := dtsCadTin.FieldByName('DUP_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString;



    If TStrUtils.fEmptyStr(dtsCadTin.FieldByName('DUP_CODNFM').AsString) Then
    Begin
      Base.QuantidadeConcentrado := RoundToExp(dtsCadTin.FieldByName('DUP_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat, -1);
      Base.QuantidadeDiluido     := RoundToExp(dtsCadTin.FieldByName('DUP_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat, -1);
    End
    Else
    Begin
      Base.QuantidadeConcentrado := (dtsCadTin.FieldByName('DUP_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat);
      Base.QuantidadeDiluido     := (dtsCadTin.FieldByName('DUP_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat);
    End;

    Base.TipoBase              := dtsCadTin.FieldByName('DUP_TIPB' + TStrUtils.fStrZero(intContador, 2)).AsString;
    Base.Qualidade             := dtsCadTin.FieldByName('DUP_QUALID').AsString;
  End;
end;

procedure TFormulaAutomotivaDupont.PreencheVolumeVenda(const dtsCadTin: IDataSet);
begin
  Self.VolumeOri := dtsCadTin.FieldByName('DUP_LITRAG').AsFloat / 1000;
end;

procedure TFormulaAutomotivaDupont.RecalcularTabelasGeneric(
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

function TFormulaAutomotivaDupont.RoundToExp(const AValue: Currency;
  const ADigit: TRoundToRange): Currency;
var
  LFactor: Extended;
  rmOrig: TRoundingMode;
begin
  LFactor := IntPower(10, ADigit);
  Result := RoundUp(AValue / LFactor) * LFactor;
  rmOrig := GetRoundMode;
  if rmOrig <> rmNearest then begin
    SetRoundMode(rmNearest);
    Result := Round(Result / LFactor) * LFactor;
    SetRoundMode(rmOrig);
  end;
end;

function TFormulaAutomotivaDupont.RoundUp(X: Extended): Extended;
begin
  Result := Int(X) + Sgn(Frac(X));
end;

function TFormulaAutomotivaDupont.Sgn(X: Extended): Integer;
begin
  If X < 0 Then
    Result := -1
  Else
  Begin
    If X = 0 Then
      Result := 0
    Else If X < 0.5 Then
      Result := 0
    Else
      Result := 1;
  End;
end;

end.
