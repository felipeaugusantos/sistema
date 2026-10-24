{************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula MazaAutomotiva *}
{*********************************************************************AC*}
unit untFormulaAutomotivaMazaAutomotiva;

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
  TFormulaAutomotivaMazaAutomotiva = class(TAbstractFormulaAutomotiva)
  private
    arrMinMax: Array Of TMinMax;
    procedure IniciaArrMinMax(const dtsCadTin: IDataSet = Nil);
    function fRetMinMax(const dtsCadTin: IDataSet = Nil): Double;
    function fPesoEspecificoBase(strBase: String): Double;
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
    function fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer; dtsCadTin: IDataSet): Double; override;

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
//    function fPermiteMostrarComboDeEmbalagem: Boolean; override;

  {$IFNDEF LINUX}
    procedure pReajustarColunasFormulacao(var lsvFormulacao: TListView); Override;
  {$ENDIF}

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

    function GetVolumeMaximoLitro(dtsCadTin: IDataSet): Double; override;
    function GetVolumeMaximoGalao(dtsCadTin: IDataSet): Double; override;
    function GetVolumeMaximoLata(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoCopo(dtsCadTin: IDataSet): Double; override;
    function GetVolumeMaximoSpray(dtsCadTin: IDataSet): Double; override;

    function fExisteConfiguracao(dtsCadTin: IDataSet; strEmbalagem: String): Boolean; Override;
    function fDefiniTamTelaFormulacao(): Integer; Override;
    procedure pPreencherBaixaQtdDig(const dtsCadTin: IDataSet); Override;

    //Diluentes
    procedure pAtualizaPorcentagem(const formula: TAbstractFormulaAutomotiva;  dtsCadTin: IDataSet = Nil); override;
    procedure pReformulaNovo(strCodDil:String; strPercentual:String = '10'; const dtsCadTin: IDataSet = Nil); override;
    function fGetDiluentes(const dtsCadTin: IDataSet): TStringList; Override;
    function fRetQtdDiluente(fltVolumePro: Double; strCodDil: String; strPercentual:String = '20'): Double; Reintroduce;
    function fAumentarCampoDiluente(): Boolean; Override;
    function fRetornaDiluente(strDiluente: String): String; Override;
    function SetItemIndexLinuxDiluente(const dtsCadTin: IDataSet; ListaAdicional: TStringList): Integer; Override;
    function fRetDiluente(strLinha: String): String; Override;
  end;

implementation

uses
  untAbstractCalculadorFormulaAutomotiva, untAutcomTintaFactory, untIDicionario;

{ TFormulaAutomotivaMazaAutomotiva }

procedure TFormulaAutomotivaMazaAutomotiva.CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva);
begin
  Base.Cnv_Ml := Base.Embalagem * Base.PesoEspecifico;
end;

function TFormulaAutomotivaMazaAutomotiva.fAumentarCampoDiluente: Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaMazaAutomotiva.fCalculaQuantidadeParaBaixaEstoque(
  Base: TBaseAutomotiva): Double;
begin
   Result := Base.QuantidadeConcentrado * (Self.VolumePro / Self.VolumeOri);
end;

function TFormulaAutomotivaMazaAutomotiva.fDefiniTamTelaFormulacao: Integer;
begin
  Result := 880;
end;

function TFormulaAutomotivaMazaAutomotiva.fExisteConfiguracao(
  dtsCadTin: IDataSet; strEmbalagem: String): Boolean;
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
    qryConf.SQL := qryConf.SQL + '    CFG_IDEPRO = "MZA" AND          ';
    qryConf.SQL := qryConf.SQL + '    CFG_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" AND          ';

    If strEmbalagem = 'Litro' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLLIT"       '
    Else If strEmbalagem = 'Galão' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLGAL"       '
    Else If strEmbalagem = 'Lata' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLLAT"       '
    Else If strEmbalagem = 'Copo' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLCOP"       '
    Else If strEmbalagem = 'Spray' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLSPR"       ';

    qryConf.Open;

    Result := (Not qryConf.IsEmpty);
  Except
    Raise;
  End;
end;

function TFormulaAutomotivaMazaAutomotiva.fGetDiluentes(
  const dtsCadTin: IDataSet): TStringList;
Var
  qryGen: IDataSet;
begin
  Self.ListaAdicional.Clear;

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := ' SELECT * FROM MZA_CADBAS B' +
                ' INNER JOIN CADITE I ON    ' +
                '   B.BAS_CODITE = I.ITE_CODITE ' +
                ' INNER JOIN ITEGER G ON    ' +
                '   I.ITE_CODITE = G.ITE_CODITE ' +
                ' AND G.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '"  ' +
                '  WHERE BAS_EFEITO = "DILUENTE" ';
  qryGen.Open;

  Result := TStringList.Create;

  While Not qryGen.Eof Do
  Begin
    Result.Add(qryGen.FieldByName('BAS_DESCRI').AsString);
    qryGen.Next;
  End;

  If Result.Count > 0 Then
  Begin
    Self.pReformulaNovo(Result[0], FloatToStr(fRetMinMax(dtsCadTin)), dtsCadTin);
    Self.blnDadosAdicionais := True;
    Self.strCaptionAdicional := 'Diluentes';
    Self.blnAdicionalDiluido := True;
  End;
end;

function TFormulaAutomotivaMazaAutomotiva.fMostrarComCatalisador: Boolean;
begin
  Result := False;
end;

function TFormulaAutomotivaMazaAutomotiva.fPesoEspecificoBase(
  strBase: String): Double;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT BAS_PESESP FROM MZA_CADBAS WHERE BAS_CODBAS  = :CODBAS ';
  qryGen.ParamByName('CODBAS').AsString := strBase;
  qryGen.Open;

  Result := qryGen.FieldByName('BAS_PESESP').AsFloat;
end;

function TFormulaAutomotivaMazaAutomotiva.fRetDiluente(
  strLinha: String): String;
begin
  If Pos(strLinha, 'MTS_MTB_MTF_MTN_PU2_MPU_MPF_FPU_') > 0 Then
    Result := 'MAZA THINNER P/ PU 5230'
  Else If Pos(strLinha, 'MBR_MFS_MSB_EI_FLC_MLC_MLX_FLX_') > 0 Then
    Result := 'MAZA THINNER SM 800'
  Else If Pos(strLinha, 'MPC_MPR_MAB_') > 0 Then
    Result := 'MAZA DILUENTE P/ EPOXI DP-003'
  Else
    Result := 'MAZA THINNER SM 137';
end;

function TFormulaAutomotivaMazaAutomotiva.fRetMinMax(
  const dtsCadTin: IDataSet): Double;
begin
  Result := 20;

  If dtsCadTin <> Nil Then
  Begin
    If dtsCadTin.FieldByName('MZA_LINHA_').AsString = 'MLC' Then
      Result := 100;
  End;
end;

function TFormulaAutomotivaMazaAutomotiva.fRetornaDiluente(
  strDiluente: String): String;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT BAS_CODBAS FROM MZA_CADBAS B ' +
                '   INNER JOIN CADITE I ON            ' +
                '     B.BAS_CODITE = I.ITE_CODITE     ' +
                '  WHERE BAS_DESCRI = :DESCRI  AND BAS_EFEITO = "DILUENTE" ';
  qryGen.ParamByName('DESCRI').AsString := strDiluente;
  qryGen.Open;

  If qryGen.IsEmpty Then
    Result := strDiluente
  Else
    Result := qryGen.FieldByName('BAS_CODBAS').AsString;
end;

function TFormulaAutomotivaMazaAutomotiva.fRetQtdDiluente(fltVolumePro: Double;
  strCodDil, strPercentual: String): Double;
begin
  Result := ((fltVolumePro) * StrToFloat(strPercentual)) / 100;
end;

//function TFormulaAutomotivaMazaAutomotiva.fPermiteMostrarComboDeEmbalagem: Boolean;
//begin
//  Result := false;
//end;

function TFormulaAutomotivaMazaAutomotiva.fValidaVolumeFormulucao(strTipoPre: String;
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaMazaAutomotiva.fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer;
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 0.900;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('MZA').fGetDouble('VOLLIT'), 3);
end;

function TFormulaAutomotivaMazaAutomotiva.GetAcrescimoDespesaOperacionalTinta: Double;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('MZA').fGetDouble('DESOPE');
end;

function TFormulaAutomotivaMazaAutomotiva.GetAno(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('MZA_ANOCOR').AsString;
end;

function TFormulaAutomotivaMazaAutomotiva.GetCalcDespesasOperacionais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdAux    : Double;
  fltVenBas : Double;
begin
  fltQtdAux := TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido) * (Formula.VolumePro / Formula.VolumeOri);

  fltVenBas := (base.PrecoVenda / base.Embalagem) * (fltQtdAux / base.PesoEspecifico);

  Result := (base.DespesasOperacionais * fltVenBas / 100);
end;

function TFormulaAutomotivaMazaAutomotiva.GetCalcIcmsSaida(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdAux    : Double;
  fltPreVenBas : Double;
begin
  fltQtdAux := TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido) * (Formula.VolumePro / Formula.VolumeOri);

  fltPreVenBas := (base.PrecoVenda / base.Embalagem) * (fltQtdAux / base.PesoEspecifico);

  Result := (fltPreVenBas * base.IcmsSaida / 100);
end;

function TFormulaAutomotivaMazaAutomotiva.GetCalcImpostosFederais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltVenBas: Double;
  fltQtdAux : Double;
begin
  fltQtdAux := TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido) * (Formula.VolumePro / Formula.VolumeOri);
  fltVenBas := (base.PrecoVenda / base.Embalagem) * (fltQtdAux / base.PesoEspecifico);

  Result := (fltVenBas * base.ImpostosFederais / 100);
end;

function TFormulaAutomotivaMazaAutomotiva.GetCalcOutrosValores(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdAux: Double;
begin
  fltQtdAux := TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido) * (Formula.VolumePro / Formula.VolumeOri);

  Result := ((Base.OutrosValores / Base.Embalagem) * (fltQtdAux / Base.PesoEspecifico));
end;

function TFormulaAutomotivaMazaAutomotiva.GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdAux: Double;
begin
  fltQtdAux := TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido) * (Formula.VolumePro / Formula.VolumeOri);

  Result := ((base.PrecoCompraLiquido / Base.Embalagem) * (fltQtdAux / Base.PesoEspecifico));
end;

function TFormulaAutomotivaMazaAutomotiva.GetCalcPrecoCusto(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdAux: Double;
begin
  fltQtdAux := TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido) * (Formula.VolumePro / Formula.VolumeOri);

  Result := ((Base.PrecoCusto / Base.Embalagem) * (fltQtdAux / Base.PesoEspecifico));
end;

function TFormulaAutomotivaMazaAutomotiva.GetCalcPrecoCustoReal(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdAux: Double;
begin
  fltQtdAux := TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido) * (Formula.VolumePro / Formula.VolumeOri);

  Result := ((base.PrecoCustoReal / Base.Embalagem) * (fltQtdAux / Base.PesoEspecifico));
end;

function TFormulaAutomotivaMazaAutomotiva.GetCalcPrecoMedio(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdAux: Double;
begin
  fltQtdAux := TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido) * (Formula.VolumePro / Formula.VolumeOri);

  Result := ((Base.PrecoMedio / Base.Embalagem) * (fltQtdAux / Base.PesoEspecifico));
end;

function TFormulaAutomotivaMazaAutomotiva.GetCalcPrecoVenda(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdAux: Double;
Begin
  fltQtdAux := TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido) * (Formula.VolumePro / Formula.VolumeOri);

  Result := ((base.PrecoVenda / base.Embalagem) * (fltQtdAux / base.PesoEspecifico));
end;

function TFormulaAutomotivaMazaAutomotiva.GetCalcQuantidade(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido) * (Formula.VolumePro / Formula.VolumeOri);
end;

function TFormulaAutomotivaMazaAutomotiva.GetCalculadorInterno: ICalculadorFormulaAutomotiva;
begin
  Result := TAbstractCalculadorFormulaAutomotiva.Create(Self);
end;

function TFormulaAutomotivaMazaAutomotiva.GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdAux: Double;
Begin
  fltQtdAux := TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido) * (Formula.VolumePro / Formula.VolumeOri);

  Result := ((base.UltimoPrecoCompra / base.Embalagem) * (fltQtdAux / base.PesoEspecifico));
end;

function TFormulaAutomotivaMazaAutomotiva.GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdAux: Double;
Begin
  fltQtdAux := TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido) * (Formula.VolumePro / Formula.VolumeOri);

  Result := ((base.UltimoPrecoCompraImpostos / base.Embalagem) * (fltQtdAux / base.PesoEspecifico));
end;

function TFormulaAutomotivaMazaAutomotiva.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('MZA_MD5KEY').AsString;
end;

function TFormulaAutomotivaMazaAutomotiva.GetCodFormul(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaMazaAutomotiva.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('MZA_DESCRI').AsString + ' - ' +
            dtsCadTin.FieldByName('MZA_CODIGO').AsString;
end;

function TFormulaAutomotivaMazaAutomotiva.GetDescricaoBase(strCodBas: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DESCRI '+
                    '  FROM MZA_CADBAS '+
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

function TFormulaAutomotivaMazaAutomotiva.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaAutomotivaMazaAutomotiva.GetIdePro: String;
begin
  Result := 'MZA';
end;

function TFormulaAutomotivaMazaAutomotiva.GetIndEmb(
  const dtsCadTin: IDataSet): integer;
begin
  Result := -1;
end;

function TFormulaAutomotivaMazaAutomotiva.GetMontadora(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('MON_DESCRI').AsString;
end;

function TFormulaAutomotivaMazaAutomotiva.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaAutomotivaMazaAutomotiva.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaAutomotivaMazaAutomotiva.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaAutomotivaMazaAutomotiva.GetNomeTabelaBases: String;
begin
  Result := 'MZA_CADBAS';
end;

procedure TFormulaAutomotivaMazaAutomotiva.pPreencherBaixaQtdDig(
  const dtsCadTin: IDataSet);
begin
  Self.BaiQDig := dtsCadTin.FieldByName('MZA_BAIQDI').AsString;
end;

Procedure TFormulaAutomotivaMazaAutomotiva.pPreencherPesCorFor(const dtsCadTin: IDataSet);
begin
  Self.PesoCor := dtsCadTin.FieldByName('MZA_PESCOR').AsFloat;
  Self.PesoFor := dtsCadTin.FieldByName('MZA_PESFOR').AsFloat;
end;

{$IFNDEF LINUX}
procedure TFormulaAutomotivaMazaAutomotiva.pReajustarColunasFormulacao(
  var lsvFormulacao: TListView);
begin
  lsvFormulacao.Columns.Clear;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taLeftJustify;
    Caption := 'Base';
    Width := 215;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taLeftJustify;
    Caption := 'Tipo';
    Width := 90;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption := 'Quantidade (g)';
    Width := 85;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption := 'Qtde. Diluido';
    Width := 85;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption := 'Quantidade (ml)';
    Width := 90;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption := 'Preço';
    Width := 90;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption := 'Embalagem';
    Width := 70;
  End;

  With lsvFormulacao.Columns.Add Do
  Begin
    Alignment := taRightJustify;
    Caption := 'Peso Esp.';
    Width := 60;
  End;

end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TFormulaAutomotivaMazaAutomotiva.pRecalculaFormulaMostrarDigitado(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; fltFator: Double;
  blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha: String;
  strTipBas: String);
Var
  blnConcentrado: Boolean;
  fltFat: Double;
begin
  blnConcentrado := False;

  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    fltFat := Self.VolumePro / Self.VolumeOri;

    If Base.QuantidadeConcentrado > 0 Then
      blnConcentrado := True;

    SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado * fltFat, ffFixed, 12, 2));
    SubItems.Add(FloatToStrF(Base.QuantidadeDiluido * fltFat, ffFixed, 12, 2));
    SubItems.Add(FloatToStrF(TAutcomTintaFactory.Get.IIF(blnConcentrado, (Base.QuantidadeConcentrado / fPesoEspecificoBase(Base.CodigoBase)) * fltFat, (Base.QuantidadeDiluido / fPesoEspecificoBase(Base.CodigoBase)) * fltFat), ffFixed, 12, 2));
    SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TFormulaAutomotivaMazaAutomotiva.pRecalculaFormulaMostrarPadrao(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; blnConsLinhaDesBas: Boolean;
  strTipBas: String; intCont: Integer);
Var
  blnConcentrado: Boolean;
begin
  blnConcentrado := False;

  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    If Base.QuantidadeConcentrado > 0 Then
      blnConcentrado := True;

    SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado, ffFixed, 12, 2));
    SubItems.Add(FloatToStrF(Base.QuantidadeDiluido, ffFixed, 12, 2));
    SubItems.Add(FloatToStrF(TAutcomTintaFactory.Get.IIF(blnConcentrado, Base.QuantidadeConcentrado / fPesoEspecificoBase(Base.CodigoBase), Base.QuantidadeDiluido / fPesoEspecificoBase(Base.CodigoBase)), ffFixed, 12, 2));
    SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

function TFormulaAutomotivaMazaAutomotiva.GetPrefixoFormulacao: String;
begin
  Result := 'MZA_FORM';
end;

function TFormulaAutomotivaMazaAutomotiva.GetPrefixoLitragem(
  const strModo: String): String;
begin
  Result := '';
end;

function TFormulaAutomotivaMazaAutomotiva.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'MZA_QTDC';
end;

function TFormulaAutomotivaMazaAutomotiva.GetProdutoVendaTinta(const dtsCadTin: IDataSet): string;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('MZA').fGet('MZAPRO');
end;

function TFormulaAutomotivaMazaAutomotiva.GetQuantidadeFormulacao: Integer;

begin
  Result := 20;
end;

function TFormulaAutomotivaMazaAutomotiva.GetSelectBases: String;
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

function TFormulaAutomotivaMazaAutomotiva.GetTextoInformativoCalculo: String;
begin
  Result :=
    'PesoEspecíficoFormula = ' + FloatToStrF(Self.PesoCor, ffFixed, 12, 3)+ sLineBreak +
    'PesoTotalFormula(g) = ' + FloatToStrF(Self.PesoFor, ffFixed, 12, 3)  + sLineBreak +
    'Quantidade Ml = Quantidade(g) / Peso Específico ' + sLineBreak +
    'Valor da Base = (Preço / Embalagem) * (QtdDigitada / Peso Específico)';
end;

function TFormulaAutomotivaMazaAutomotiva.GetUniversal(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('MZA_UNIVER').AsString;
end;

function TFormulaAutomotivaMazaAutomotiva.GetVolumeMaximoCopo(
  dtsCadTin: IDataSet): Double;
Begin
  If Not fExisteConfiguracao(dtsCadTin, 'Copo') Then
  Begin
    Result := 0.500;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('MZA').fGetDouble('VOLCOP'), 3);
End;

function TFormulaAutomotivaMazaAutomotiva.GetVolumeMaximoGalao(
  dtsCadTin: IDataSet): Double;
Begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 4.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('MZA').fGetDouble('VOLGAL'), 3);
End;

function TFormulaAutomotivaMazaAutomotiva.GetVolumeMaximoLata(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('MZA').fGetDouble('VOLLAT'), 3);
end;

function TFormulaAutomotivaMazaAutomotiva.GetVolumeMaximoLitro(
  dtsCadTin: IDataSet): Double;
Begin
  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 1.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('MZA').fGetDouble('VOLLIT'), 3);
End;

function TFormulaAutomotivaMazaAutomotiva.GetVolumeMaximoSpray(
  dtsCadTin: IDataSet): Double;
Begin
  If Not fExisteConfiguracao(dtsCadTin, 'Spray') Then
  Begin
    Result := 0.400;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('MZA').fGetDouble('VOLSPR'), 3);
End;

function TFormulaAutomotivaMazaAutomotiva.GetVolumePadraCopo: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Copo') Then
  Begin
    Result := 0.450;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('MZA').fGetDouble('VOLCOP'), 3);
end;

function TFormulaAutomotivaMazaAutomotiva.GetVolumePadraGalao(dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 3.600;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('MZA').fGetDouble('VOLGAL'), 3);
end;

function TFormulaAutomotivaMazaAutomotiva.GetVolumePadraLitro: Double;
begin
  Result := 0.900;
end;

function TFormulaAutomotivaMazaAutomotiva.GetVolumePadraoLata(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('MZA').fGetDouble('VOLLAT'), 3);
end;

function TFormulaAutomotivaMazaAutomotiva.GetVolumePadraSpray: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Spray') Then
  Begin
    Result := 0.190;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('MZA').fGetDouble('VOLSPR'), 3);
end;

function TFormulaAutomotivaMazaAutomotiva.GetVolumePadraTambor(dtsCadTin: IDataSet): Double;
begin
  Result := 0;
end;

function TFormulaAutomotivaMazaAutomotiva.GetVolumePermitido(
  const dtsCadTin: IDataSet; strTipoPre: String): Double;
begin
  Result := 0;
end;

procedure TFormulaAutomotivaMazaAutomotiva.IniciaArrMinMax(
  const dtsCadTin: IDataSet);
Var
  intContador: Integer;
begin
  SetLength(arrMinMax, Self.ListaAdicional.Count);

  If Self.ListaAdicional.Count <= 0 Then
    Exit;

  For intContador := 0 To Self.ListaAdicional.Count - 1 Do
  Begin
    arrMinMax[intContador].fltMin := fRetMinMax(dtsCadTin);
    arrMinMax[intContador].fltMax := fRetMinMax(dtsCadTin);
  End;
end;

procedure TFormulaAutomotivaMazaAutomotiva.pAtualizaPorcentagem(
  const formula: TAbstractFormulaAutomotiva; dtsCadTin: IDataSet);
begin
  If (dtsCadTin.FieldByName('MZA_LINHA_').AsString = 'MHS') Or
     (dtsCadTin.FieldByName('MZA_LINHA_').AsString = 'MPL') Then
    Exit;

  If Formula.ListaAdicional.Count <= 0 Then
    Exit;

  If Formula.PorDil > arrMinMax[Formula.IndiceAdicional].fltMax Then
    Formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltMax;

  If Formula.PorDil < arrMinMax[Formula.IndiceAdicional].fltMin Then
    Formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltMin;

  Formula.HabDil := True;
end;

procedure TFormulaAutomotivaMazaAutomotiva.pDefineVolumeOriginal;
begin
  Self.VolumeOri := Self.VolumeConcentrado;
end;

procedure TFormulaAutomotivaMazaAutomotiva.pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet);
var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('MZA');


  sProEmbTb := '';
  sProEmbBa := '';
  sProEmbSs := '';
  sProEmbPo := '';
  sProEmbSd := '';

  stlDesEmb.Clear;
  stlDesEmb.Add(dtsCadTin.FieldByName('MZA_LINHA_').AsString);

  IniciaArrMinMax(dtsCadTin);

  stlProEmbLt.Add(conf.fGet('MZALIT'));
  stlProEmbGl.Add(conf.fGet('MZAGAL'));
  stlProEmbLa.Add(conf.fGet('MZALAT'));

  sProEmbCo := conf.fGet('MZACOP');
  sProEmbSp := conf.fGet('MZASPR');

  If ListaAdicional.Count > 0 Then
    pReformulaNovo(ListaAdicional[0], FloatToStr(fRetMinMax(dtsCadTin)), dtsCadTin);
end;

procedure TFormulaAutomotivaMazaAutomotiva.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('MZA_ACRMOB').AsFloat;
end;

procedure TFormulaAutomotivaMazaAutomotiva.PreencheQuantidadeFormulacaoVenda(
  const dtsCadTin: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
  fltQuantidade: Double;
begin
  fltQuantidade := 0;

  For intContador := 1 To Self.GetQuantidadeFormulacao Do
  Begin

    If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('MZA_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
      Break;

    Base := TBaseAutomotiva(Self.Add);
    Base.CodigoBase            := dtsCadTin.FieldByName('MZA_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString;
    Base.QuantidadeConcentrado := dtsCadTin.FieldByName('MZA_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat / fPesoEspecificoBase(Base.CodigoBase);

    Base.TipoBase   := 'B';

    fltQuantidade := Base.QuantidadeConcentrado + fltQuantidade;
  End;

  //CALCULANDO FORMULA PARA 900ML

  For intContador := 1 To Self.GetQuantidadeFormulacao Do
  Begin
    If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('MZA_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
      Break;

    Base := (Self.Items[intContador - 1] as TBaseAutomotiva);
    Base.QuantidadeConcentrado :=  Base.QuantidadeConcentrado * 900 / fltQuantidade;

    If dtsCadTin.FieldByName('MZA_BAIQDI').AsString = 'S' Then
      Base.QuantidadeConcentrado := dtsCadTin.FieldByName('MZA_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat
    Else
      Base.QuantidadeConcentrado := Base.QuantidadeConcentrado * fPesoEspecificoBase(Base.CodigoBase);
  End;
end;

procedure TFormulaAutomotivaMazaAutomotiva.PreencheVolumeVenda(const dtsCadTin: IDataSet);
begin
  Self.VolumeOri         := 0.9;
  Self.VolumeConcentrado := 0.9;
end;

procedure TFormulaAutomotivaMazaAutomotiva.pReformulaNovo(strCodDil,
  strPercentual: String; const dtsCadTin: IDataSet);
Var
  intContador: Integer;
  qryGen: IDataSet;
  diluente: TBaseAutomotiva;
  Bases: TBaseAutomotiva;
  fltVolumeAtual: Double;
  fltDesOpeTinta: Double;
  dicDados: IDicionario;
begin
  If (dtsCadTin.FieldByName('MZA_LINHA_').AsString = 'MHS') Or
     (dtsCadTin.FieldByName('MZA_LINHA_').AsString = 'MPL') Then
    Exit;

  qryGen := Nil;
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.Close;
    qryGen.SQL :=
      ' SELECT DISTINCT                           ' +
      '   *                                       ' +
      ' FROM                                      ' +
      '   MZA_CADBAS B                            ' +
      ' INNER JOIN CADITE I ON                    ' +
      '   B.BAS_CODITE = I.ITE_CODITE             ' +
      ' INNER JOIN ITEGER G ON                    ' +
      '   I.ITE_CODITE = G.ITE_CODITE AND         ' +
      '   G.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ' +
      ' WHERE B.BAS_DESCRI = :DESCRI AND          ' +
      '   B.BAS_EFEITO = "DILUENTE"               ';

    qryGen.ParamByName('DESCRI').AsString := strCodDil;
    qryGen.Open;

    If qryGen.IsEmpty Then
    Begin
      qryGen.Close;
      qryGen.SQL := ' SELECT DISTINCT                           ' +
      '   *                                       ' +
      ' FROM                                      ' +
      '   MZA_CADBAS B                            ' +
      ' INNER JOIN CADITE I ON                    ' +
      '   B.BAS_CODITE = I.ITE_CODITE             ' +
      ' INNER JOIN ITEGER G ON                    ' +
      '   I.ITE_CODITE = G.ITE_CODITE AND         ' +
      '   G.ITE_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ' +
      ' WHERE B.BAS_CODBAS = :DESCRI AND          ' +
      '   B.BAS_EFEITO = "DILUENTE"               ';

      qryGen.ParamByName('DESCRI').AsString := strCodDil;
      qryGen.Open;
    End;

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
    Diluente.CodigoBase := qryGen.FieldByName('BAS_CODBAS').AsString;
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
    Diluente.PesGra := 'N';

    dicDados := TAutcomTintaFactory.Get.GetDicionario;
    dicDados := TAutcomTintaFactory.Get.GetDicionario;
    dicDados['preven'] := Diluente.PrecoVenda;
    dicDados['precus'] := Diluente.PrecoCusto;
    dicDados['outval'] := Diluente.OutrosValores;
    dicDados['icmsai'] := Diluente.IcmsSaida;
    dicDados['impfed'] := Diluente.ImpostosFederais;
    dicDados['desope'] := Diluente.DespesasOperacionais;

    Diluente.PrecoCustoReal := TAutcomTintaFactory.Get.fCalculaPrecoCusto2(dicDados);

    Diluente.QuantidadeDiluido := fRetQtdDiluente(fltVolumeAtual, strCodDil, strPercentual);
    Diluente.QuantidadeDiluido := Diluente.QuantidadeDiluido * Diluente.PesoEspecifico;
    Diluente.QuantidadeDiluido := (Diluente.QuantidadeDiluido * 1 * 1000) / (1 * 1000 + (strToFloat(strPercentual) * 10));

    For intContador := Self.Count - 1 Downto 0 Do
    Begin
      Bases := (Self.Items[intContador] As TBaseAutomotiva);

      If Bases.TipoBase <> 'D' Then
      Begin
        Bases.QuantidadeDiluido := (Bases.QuantidadeConcentrado / Bases.PesoEspecifico);
        Bases.QuantidadeDiluido := ((Bases.QuantidadeDiluido * 1000) / (1000 + (StrToFloat(strPercentual) * 10)));
        Bases.QuantidadeDiluido := TAutcomTintaFactory.Get.fFormataFloat((Bases.QuantidadeDiluido * Bases.PesoEspecifico), 2);
      End;
    End;
  Except
    On E: Exception Do
      Raise;
  End;
end;

function TFormulaAutomotivaMazaAutomotiva.SetItemIndexLinuxDiluente(
  const dtsCadTin: IDataSet; ListaAdicional: TStringList): Integer;
Var
  intContador: Integer;
begin
  If ListaAdicional = Nil Then
    Exit(0);

  if ListaAdicional.Count < 0 Then
    Exit(0);

  Result := 0;


  For intContador := 0 To ListaAdicional.Count Do
  Begin
    if fRetDiluente(dtsCadTin.FieldByName('MZA_LINHA_').AsString) = ListaAdicional[intContador] Then
      Exit(intContador);
  End;
end;

end.
