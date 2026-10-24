{************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula NEX *}
{*********************************************************************AC*}
unit untFormulaAutomotivaNexa;

interface

uses
{$IFNDEF LINUX}
  Controls,
  ComCtrls,
{$ENDIF}
  untAbstractFormulaAutomotiva, untICalculadorFormulaAutomotiva, untIDataSet, untBaseAutomotiva,
  SysUtils, untStrUtils, Classes, untIConfTinta, untFloatUtils, untModoVenda, untVariantUtils,
  untIDicionario, untISaldosColorantes;


type
  TMinMax = record
    fltMin : Double;
    fltMax : Double;
  end;

type
  TFormulaAutomotivaNexa = class(TAbstractFormulaAutomotiva)
  private
    arrMinMax : array of TMinMax;
    strCodEmp : String;

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
    procedure CarregarBasesPorEmpresa(const dicRetorno: IDicionario); override;
    procedure CarregaPrecosBasesPorEmpresa; override;

    function GetSelectBasesPorEmpresa: String;

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

    function fRetEmbalagemLT(strTipCor: String): String;
    function fRetEmbalagemGL(strTipCor: String): String;
    function fRetEmbalagemBD(strTipCor: String): String;
    function fRetEmbalagemTB(strTipCor: String): String;
    function fRetEmbalagemCP: String;
    function fRetEmbalagemSP: String;


    function fRetDiluentes(strTipCor: String; intModDil: Integer; strCatalisador: String): TStringList;
    function fConfEmbalagem(strCodCfg : String) : String;

    function GetIndEmb(const dtsCadTin: IDataSet): integer; override;
    procedure PreencheQuantidadeFormulacaoVenda(const dtsCadTin: IDataSet); override;
    procedure pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet); override;

    function fRetTipoCor(const dtsCadTin: IDataSet) : String;

    function GetVolumePermitido(const dtsCadTin: IDataSet; strTipoPre: String):Double; override;
    function GetVolumePadraLitro: Double;

    function fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer; dtsCadTin: IDataSet): Double; override;

    function GetLinha(const dtsCadTin: IDataSet): string; override;

    function fGetDiluentes(const dtsCadTin: IDataSet): TStringList; override;

    function GetVolumePadraGalao(dtsCadTin: IDataSet): Double;  override;

    function GetVolumePadraCopo : Double;  override;
    function GetVolumePadraSpray: Double;  override;
    function GetVolumePadraTambor(dtsCadTin: IDataSet): Double; override;
    function GetVolumeMaximoSpray(dtsCadTin: IDataSet): Double; Override;



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

    function fConfProdutoVendaCriada: Boolean;


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


    function fArredondaNEX(fltValor: Double): Double;

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

    procedure pPreencheListaAdicionalBases; override;
    procedure IniciaArrMinMax(const dtsCadTin: IDataSet);
    procedure pAtualizaPorcentagem(const formula: TAbstractFormulaAutomotiva;  dtsCadTin: IDataSet = Nil); override;
    procedure pCalcularDiluente(const strCodDil: string; const fltPorDil: Double; const dtsCadTin: IDataSet); Override;

    function GetVolumeMaximoLitro(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoGalao(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoBalde(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoTambor(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoCopo(dtsCadTin: IDataSet): Double; Override;

    function GetVolumePadraoBalde(dtsCadTin: IDataSet): Double; Override;

    function fExisteConfiguracao(dtsCadTin: IDataSet; strEmbalagem: String): Boolean; Override;
    function fRetEmbLitro(dtsCadTin: IDataSet): String;
    function fRetEmbGalao(dtsCadTin: IDataSet): String;
    function fRetEmbBalde(dtsCadTin: IDataSet): String;
    function fRetEmbTambor(dtsCadTin: IDataSet): String;
    function GetSaldos: ISaldosColorantes; Override;
    function fQuantidadeMenorIgualZero: Boolean; Override;
  end;

implementation

uses
  untCalculadorFormulaAutomotivaNexa, untAutcomTintaFactory, untGenericSaldosColorantes, Variants;

{ TFormulaAutomotivaNexa }

procedure TFormulaAutomotivaNexa.CarregaPrecosBasesPorEmpresa;
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

  For intContador := 0 To Self.Count-1 Do
  Begin
    Base := TBaseAutomotiva(Self.Items[intContador]);
    If GetDataSetBasesPorEmpresa.Locate('BAS_CODBAS', Base.CodigoBase, []) Then
    Begin
      Base.OutrosValores             := GetDataSetBasesPorEmpresa.FieldByName('ITE_OUTVAL').AsFloat;
      Base.CodIte                    := GetDataSetBasesPorEmpresa.FieldByName('BAS_CODITE').AsString;
      Base.ImpDir                    := GetDataSetBasesPorEmpresa.FieldByName('ITE_IMPDIR').AsString;

      If TAutcomTintaFactory.Get.fCfgSis('IMPCF4', varBoolean) And Assigned(calculadorFatVendas) Then
        Base.IcmsSaida               := calculadorFatVendas.fCalculaAliquota(Base.CodIte, Base.ImpDir)
      Else
        Base.IcmsSaida               := GetDataSetBasesPorEmpresa.FieldByName('ITE_ICMSAI').AsFloat;

      Base.ImpostosFederais          := GetDataSetBasesPorEmpresa.FieldByName('ITE_IMPFED').AsFloat;
      Base.DespesasOperacionais      := GetDataSetBasesPorEmpresa.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;

      Base.PrecoMedio                := GetDataSetBasesPorEmpresa.FieldByName('ITE_PREMED').AsFloat;
      Base.UltimoPrecoCompra         := GetDataSetBasesPorEmpresa.FieldByName('ITE_PREULT').AsFloat;
      Base.UltimoPrecoCompraImpostos := GetDataSetBasesPorEmpresa.FieldByName('ITE_IMPULT').AsFloat;
      Base.PrecoCompraLiquido        := TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fCalculaPrecoCompraLiq(
                                                                                     GetDataSetBasesPorEmpresa.Fieldbyname('ITE_PRECOM').AsFloat, GetDataSetBasesPorEmpresa.Fieldbyname('ITE_DESF01').AsFloat,
                                                                                     GetDataSetBasesPorEmpresa.Fieldbyname('ITE_DESF02').AsFloat, GetDataSetBasesPorEmpresa.Fieldbyname('ITE_DESF03').AsFloat,
                                                                                     GetDataSetBasesPorEmpresa.Fieldbyname('ITE_DESF04').AsFloat, GetDataSetBasesPorEmpresa.Fieldbyname('ITE_DESF05').AsFloat,
                                                                                     GetDataSetBasesPorEmpresa.Fieldbyname('ITE_DESF06').AsFloat), TAutcomTintaFactory.Get.fCfgSis('DECUNI', VarInteger));

      If (GetDataSetBases.Locate('BAS_CODBAS', Base.CodigoBase, [])) Then
      Begin
        Base.Embalagem                 := GetDataSetBases.FieldByName('BAS_EMBALA').AsFloat;
        Base.PesoEspecifico            := GetDataSetBases.FieldByName('BAS_PESESP').AsFloat;
        Base.PesGra                    := GetBasPesGra(GetDataSetBases);
      End;

      blnEmPromo := TAutcomTintaFactory.Get.fCarregaPromocao(GetDataSetBasesPorEmpresa.FieldByName('BAS_CODITE').AsString,
                                                             strTabPre, Self.strCodCli, Self.strCodCnd, Self.intPrzMed,
                                                             fltPreCus, fltPreVen, blnPrecoFixoParaTintaDeMaquinaImobiliaria, strCodEmpresa);

      if (blnEmPromo) And (Not Self.blnProPre) then
      begin
        Base.PrecoCusto := fltPreCus;
        Base.PrecoVenda := fltPreVen;

        If strTabPre = strTabPreTin Then
          Self.Promoc := 'S';

        if Base.PrecoCusto = 0 then
          Base.PrecoCusto := GetDataSetBasesPorEmpresa.FieldByName('ITE_PRECUS').AsFloat;
      end
      else
      begin
        Base.PrecoCusto := GetDataSetBasesPorEmpresa.FieldByName('ITE_PRECUS').AsFloat;
        Base.PrecoVenda := GetDataSetBasesPorEmpresa.FieldByName('ITE_PREVEN').AsFloat;

        If (Self.blnProPre) And (blnEmPromo) And (strTabPre = strTabPreTin) Then
          Self.Promoc := 'S';
      end;
      CarregaPrecosColorantesAdicional(GetDataSetBasesPorEmpresa, Base);
    End;
  End;

  TextoInformativoCalculo.Text := GetTextoInformativoCalculo;
end;

procedure TFormulaAutomotivaNexa.CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva);
begin
  Base.Cnv_Ml := Base.Embalagem * Base.PesoEspecifico;
end;

procedure TFormulaAutomotivaNexa.CarregarBasesPorEmpresa(const dicRetorno: IDicionario);
var
  strSql    : String;
begin
  strSql := GetSelectBasesPorEmpresa;

  If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '0') Then
  begin
    strSql := strSql +
      '   , ' + GetNomeCampoCustoBase + ' AS ITE_PRECUS ' +
      '   , ' + GetNomeCampoVendaBase + ' AS ITE_PREVEN ';
  end

  Else If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') And BlnCalculaUnitario Then
  begin
    strSql := strSql +
      '   , ITE_PRECUS               ' +
      '   , ITE_PREVE' + TAutcomTintaFactory.Get.fCfgSis('TABPRE') + ' AS ITE_PREVEN ';
  end
  else
  begin
    strSql := strSql +
      '   , ITE_PRECUS               ' +
      '   , ITE_PREVE' + Self.strTabPre + ' AS ITE_PREVEN ';
  end;

  strSql := strSql +
    ' FROM                               ' +
    '    NEX_BASEMP B     ' +
    '   INNER JOIN ITEGER G              ' +
    '     ON B.BAS_CODITE = G.ITE_CODITE ' +
    '   INNER JOIN CADITE I              ' +
    '     ON G.ITE_CODITE = I.ITE_CODITE ' +
    ' WHERE G.ITE_CODEMP = :CODEMP       ';

  strSql := strSql + GetBasesPorEmpresa(dicRetorno);

  GetDataSetBasesPorEmpresa.SQL := strSql;

  If Not TStrUtils.fEmptyStr(Self.EmpresaProducao) And (Self.OprFlj = 'S') Then
    GetDataSetBasesPorEmpresa.ParamByName('CODEMP').AsString := Self.EmpresaProducao
  Else If Not TStrUtils.fEmptyStr(Self.EmpCd_) And (Self.CD_S_N = 'S') Then
    GetDataSetBasesPorEmpresa.ParamByName('CODEMP').AsString := Self.EmpCd_
  Else If Not TStrUtils.fEmptyStr(Self.EmpFat) And (Self.FatS_N = 'S') Then
    GetDataSetBasesPorEmpresa.ParamByName('CODEMP').AsString := Self.EmpFat
  Else
    GetDataSetBasesPorEmpresa.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;

  strCodEmp := GetDataSetBasesPorEmpresa.ParamByName('CODEMP').AsString;
  GetDataSetBasesPorEmpresa.Open;
end;

function TFormulaAutomotivaNexa.fArredondaNEX(fltValor: Double): Double;
  Var
    strAux: String;
begin
  strAux := Format('%.2f', [fltValor]);
  strAux := Copy(strAux, 1, Length(strAux) - 1);

  {Req.: 107563 - Recupera valor nas situações onde o arredondamento falhou!}
  If (TAutcomTintaFactory.Get.fStrToFloat(strAux) = 0) Then
    strAux := Format('%.2f', [fltValor]);

  Result := TAutcomTintaFactory.Get.fStrToFloat(strAux);
end;

function TFormulaAutomotivaNexa.fCalculaQuantidadeParaBaixaEstoque(Base: TBaseAutomotiva): Double;
begin
  Result := TAutcomTintaFactory.Get.IIF(Self.mveModoVenda = mvConcentrado, base.QuantidadeConcentrado, base.QuantidadeDiluido) * (Self.fltVolumePro / Self.fltVolumeOri);
end;

function TFormulaAutomotivaNexa.fConfEmbalagem(strCodCfg: String): String;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT CFG_CODITE '+
                '  FROM CFGEMB '+
                ' WHERE CFG_CODCFG = :CODCFG '+
                '   AND CFG_PRINCI =  "S"';
  qryGen.ParamByName('CODCFG').AsString := strCodCfg;
  qryGen.Open;

  Result := qryGen.FieldByName('CFG_CODITE').AsString;
end;

function TFormulaAutomotivaNexa.fConfProdutoVendaCriada: Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT CFG_CODCFG           '+
                '   FROM CFGTIN               '+
                '  WHERE CFG_IDEPRO = "NEX"   '+
                '    AND CFG_CODEMP = :CODEMP '+
                '    AND CFG_CODCFG = :CODCFG ';
  qryGen.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryGen.ParamByName('CODCFG').AsString := 'PROACS';
  qryGen.Open;

  Result := Not qryGen.IsEmpty;
end;

function TFormulaAutomotivaNexa.fExisteConfiguracao(dtsCadTin: IDataSet;
  strEmbalagem: String): Boolean;
Var
  qryConf: IDataSet;
begin
  Try
    qryConf := TAutcomTintaFactory.Get.fGetDataSet;
    qryConf.Close;
    qryConf.SQL := '';
    qryConf.SQL := qryConf.SQL + '  SELECT            ';
    qryConf.SQL := qryConf.SQL + '    *               ';
    qryConf.SQL := qryConf.SQL + '  FROM              ';
    qryConf.SQL := qryConf.SQL + '    CFGTIN          ';
    qryConf.SQL := qryConf.SQL + '  WHERE             ';
    qryConf.SQL := qryConf.SQL + '    CFG_IDEPRO = "NEX" AND        ';
    qryConf.SQL := qryConf.SQL + '    CFG_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" AND      ';

    If strEmbalagem = 'Litro' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "' + fRetEmbLitro(dtsCadTin) + '"    '
    Else If strEmbalagem = 'Galão' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "' + fRetEmbGalao(dtsCadTin) + '"    '
    Else If strEmbalagem = 'Balde' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "' + fRetEmbBalde(dtsCadTin) + '"    '
    Else If strEmbalagem = 'Tambor' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "' + fRetEmbTambor(dtsCadTin) + '"   '
    Else If strEmbalagem = 'Copo' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLUCOPO"       '
    Else If strEmbalagem = 'Spray' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "VOLSPR"       ';

    qryConf.Open;

    Result := (Not qryConf.IsEmpty);
  Except
    Raise;
  End;
end;

function TFormulaAutomotivaNexa.fMostrarComCatalisador: Boolean;
begin
  Result := False;
end;

function TFormulaAutomotivaNexa.fQuantidadeMenorIgualZero: Boolean;
var
  intContador: Integer;
  Base: TBaseAutomotiva;
  fltFator: Double;
begin
  Result := False;

  If Self.VolumeOri > 0 Then
    fltFator := Self.VolumePro / Self.VolumeOri
  Else
    fltFator := 1;

  If Self.VolumeOri > 1 Then
    fltFator := fltFator * 1000;

  For intContador := 0 To Self.Count-1 Do
  Begin
    Base := TBaseAutomotiva(Self.Items[intContador]);

    If mveModoVenda = mvConcentrado Then
    Begin

      If Base.TipoBase = 'D' Then
        Continue;

      If (fArredondaNEX(Base.QuantidadeConcentrado * fltFator) <= 0) And (Pos('PERSONALIZ', Base.System) <= 0) Then
      Begin
        Result := True;
        Continue;
      End
      Else If (Base.TipoBase = 'B') And ((Base.QuantidadeConcentrado * fltFator) <= 0) And (Not fBaseDiluente(Base))Then
      Begin
        Result := False;
        Continue;
      End;
    End
    Else
    Begin
      If (fArredondaNEX(Base.QuantidadeDiluido * fltFator) <= 0) And (Pos('PERSONALIZ', Base.System) <= 0) Then
      Begin
        Result := True;
        Continue;
      End
      Else If ((Base.QuantidadeDiluido * fltFator) <= 0) Then
      Begin
        Result := False;
        Continue;
      End;
    End;
  End;
end;

function TFormulaAutomotivaNexa.fRetDiluentes(strTipCor: String;
  intModDil: Integer; strCatalisador: String): TStringList;
begin
  Result := TStringList.Create;
  Result.Clear;

  If (strTipCor = 'DELTRON DG') Or (strTipCor = 'DELTRON BC') Then
  Begin
    If intModDil <> 2 Then
    Begin
      Result.Add('D808');
      Result.Add('807');

      If strCatalisador <> 'D863' Then
        Result.Add('D812');
    End;
  End
  Else
    Result.Add('Sem Diluente');
end;

function TFormulaAutomotivaNexa.fRetEmbalagemBD(strTipCor: String): String;
Var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get().fGetConfTinta('NEX');

  Result := '';

  if Pos('2K', strTipCor) > 0 then
    Result := conf.fGet('NEXAPMLA2K')
  Else if Pos('ACS (LA)', strTipCor) > 0 then
    Result := conf.fGet('NEXAPMLAAC')
  Else if Pos('ACS EVOLUTION (LA)', strTipCor) > 0 then
    Result := conf.fGet('NEXAPMLAEV')
  Else if Pos('INDUSTRAN', strTipCor) > 0 then
    Result := conf.fGet('NEXAPMLAIN')
  Else if (Pos('FLAT CLEAR', strTipCor) > 0)
   Or (Pos('SPECTRAL GREY', strTipCor) > 0) Then
    Result := conf.fGet('NEXAPMLASG')
  Else if Pos('TURBO PLUS', strTipCor) > 0 then
    Result := conf.fGet('NEXAPMLATP')
  Else if Pos('ZYNAMIX', strTipCor) > 0 then
    Result := conf.fGet('NEXAPMLAZY');
end;

function TFormulaAutomotivaNexa.fRetEmbalagemCP: String;
Var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get().fGetConfTinta('NEX');
  Result := conf.fGet('NEXACOP');
end;

function TFormulaAutomotivaNexa.fRetEmbalagemGL(strTipCor: String): String;
Var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get().fGetConfTinta('NEX');

  Result := '';

  if Pos('2K', strTipCor) > 0 then
    Result := conf.fGet('NEXAPMG2K')
  Else if Pos('ACS (LA)', strTipCor) > 0 then
    Result := conf.fGet('NEXAPMGAC')
  Else if Pos('ACS EVOLUTION (LA)', strTipCor) > 0 then
    Result := conf.fGet('NEXAPMGEV')
  Else if Pos('INDUSTRAN', strTipCor) > 0 then
    Result := conf.fGet('NEXAPMGIN')
  Else if (Pos('FLAT CLEAR', strTipCor) > 0)
   Or (Pos('SPECTRAL GREY', strTipCor) > 0) Then
    Result := conf.fGet('NEXAPMGSG')
  Else if Pos('TURBO PLUS', strTipCor) > 0 then
    Result := conf.fGet('NEXAPMGTP')
  Else if Pos('ZYNAMIX', strTipCor) > 0 then
    Result := conf.fGet('NEXAPMGZY');
end;

function TFormulaAutomotivaNexa.fRetEmbalagemLT(strTipCor: String): String;
Var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get().fGetConfTinta('NEX');

  Result := '';

  if Pos('2K', strTipCor) > 0 then
    Result := conf.fGet('NEXAPML2K')
  Else if Pos('ACS (LA)', strTipCor) > 0 then
    Result := conf.fGet('NEXAPMLAC')
  Else if Pos('ACS EVOLUTION (LA)', strTipCor) > 0 then
    Result := conf.fGet('NEXAPMLEV')
  Else if Pos('INDUSTRAN', strTipCor) > 0 then
    Result := conf.fGet('NEXAPMLIN')
  Else if (Pos('FLAT CLEAR', strTipCor) > 0)
   Or (Pos('SPECTRAL GREY', strTipCor) > 0) Then
    Result := conf.fGet('NEXAPMLSG')
  Else if Pos('TURBO PLUS', strTipCor) > 0 then
    Result := conf.fGet('NEXAPMLTP')
  Else if Pos('ZYNAMIX', strTipCor) > 0 then
    Result := conf.fGet('NEXAPMLZY');
end;

function TFormulaAutomotivaNexa.fRetEmbalagemSP: String;
Var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get().fGetConfTinta('NEX');
  Result := conf.fGet('PSPRAY');
end;

function TFormulaAutomotivaNexa.fRetEmbalagemTB(strTipCor: String): String;
Var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get().fGetConfTinta('NEX');

  Result := '';

  if Pos('2K', strTipCor) > 0 then
    Result := conf.fGet('NEXAPMT2K')
  Else if Pos('ACS (LA)', strTipCor) > 0 then
    Result := conf.fGet('NEXAPMTAC')
  Else if Pos('ACS EVOLUTION (LA)', strTipCor) > 0 then
    Result := conf.fGet('NEXAPMTEV')
  Else if Pos('INDUSTRAN', strTipCor) > 0 then
    Result := conf.fGet('NEXAPMTIN')
  Else if (Pos('FLAT CLEAR', strTipCor) > 0)
   Or (Pos('SPECTRAL GREY', strTipCor) > 0) Then
    Result := conf.fGet('NEXAPMTSG')
  Else if Pos('TURBO PLUS', strTipCor) > 0 then
    Result := conf.fGet('NEXAPMTTP')
  Else if Pos('ZYNAMIX', strTipCor) > 0 then
    Result := conf.fGet('NEXAPMTZY');
end;

function TFormulaAutomotivaNexa.fRetEmbBalde(dtsCadTin: IDataSet): String;
begin
  Result := '';

  If Pos('2K', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMB2K'
  Else If Pos('ACS (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMBAC'
  Else If Pos('ACS EVOLUTION (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMBEV'
  Else If Pos('FLAT CLEAR', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMBSG'
  Else If Pos('SPECTRAL GREY', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMBSG'
  Else If Pos('INDUSTRAN', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMBIN'
  Else If Pos('TURBO PLUS', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMBTP'
  Else If Pos('ZYNAMIX', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMBZY';
end;

function TFormulaAutomotivaNexa.fRetEmbGalao(dtsCadTin: IDataSet): String;
begin
  Result := '';

  If Pos('2K', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMG2K'
  Else If Pos('ACS (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMGAC'
  Else If Pos('ACS EVOLUTION (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMGEV'
  Else If Pos('FLAT CLEAR', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMGSG'
  Else If Pos('SPECTRAL GREY', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMGSG'
  Else If Pos('INDUSTRAN', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMGIN'
  Else If Pos('TURBO PLUS', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMGTP'
  Else If Pos('ZYNAMIX', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMGZY';
end;

function TFormulaAutomotivaNexa.fRetEmbLitro(dtsCadTin: IDataSet): String;
begin
  Result := '';

  If Pos('2K', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPML2K'
  Else If Pos('ACS (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMLAC'
  Else If Pos('ACS EVOLUTION (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMLEV'
  Else If Pos('FLAT CLEAR', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMLSG'
  Else If Pos('SPECTRAL GREY', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMLSG'
  Else If Pos('INDUSTRAN', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMLIN'
  Else If Pos('TURBO PLUS', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMLTP'
  Else If Pos('ZYNAMIX', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMLZY';
end;

function TFormulaAutomotivaNexa.fRetEmbTambor(dtsCadTin: IDataSet): String;
begin
  Result := '';

  If Pos('2K', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMT2K'
  Else If Pos('ACS (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMTAC'
  Else If Pos('ACS EVOLUTION (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMTEV'
  Else If Pos('FLAT CLEAR', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMTSG'
  Else If Pos('SPECTRAL GREY', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMTSG'
  Else If Pos('INDUSTRAN', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMTIN'
  Else If Pos('TURBO PLUS', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMTTP'
  Else If Pos('ZYNAMIX', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := 'VOLPMTZY';
end;

function TFormulaAutomotivaNexa.fRetTipoCor(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('NEX_TIPO__').AsString;
end;

function TFormulaAutomotivaNexa.fValidaVolumeFormulucao(strTipoPre: String;
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaNexa.fVolumePadraoLitro(fltVolumePadraoLitro: Double;
  intModoVenda: Integer; dtsCadTin: IDataSet): Double;
begin
  Result := Self.VolumeOri;

  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := Self.VolumeOri;
    Exit;
  End;

  If Pos('2K', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPML2K'), 3)
  Else If Pos('ACS (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMLAC'), 3)
  Else If Pos('ACS EVOLUTION (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMLEV'), 3)
  Else If Pos('FLAT CLEAR', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMLSG'), 3)
  Else If Pos('SPECTRAL GREY', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMLSG'), 3)
  Else If Pos('INDUSTRAN', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMLIN'), 3)
  Else If Pos('TURBO PLUS', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMLTP'), 3)
  Else If Pos('ZYNAMIX', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMLZY'), 3);
end;

function TFormulaAutomotivaNexa.GetAcrescimoDespesaOperacionalTinta: Double;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('DESOPE');
end;

function TFormulaAutomotivaNexa.GetAno(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('NEX_A_N_O_').AsString;
end;

function TFormulaAutomotivaNexa.GetCalcDespesasOperacionais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  If Pos('PERSONALIZ', Self.strCodFormul) > 0 Then
    fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido)
  Else
    fltQtdFor := fArredondaNEX(TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido), 1));

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  fltVenBas := (fltQtdFor * base.PrecoVenda / base.Cnv_Ml);

  Result := (fltVenBas * base.DespesasOperacionais / 100);
end;

function TFormulaAutomotivaNexa.GetCalcIcmsSaida(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  If Pos('PERSONALIZ', Self.strCodFormul) > 0 Then
    fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido)
  Else
    fltQtdFor := fArredondaNEX(TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido), 1));

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  fltVenBas := (fltQtdFor * base.PrecoVenda / base.Cnv_Ml);

  Result := (fltVenBas * base.IcmsSaida / 100);
end;

function TFormulaAutomotivaNexa.GetCalcImpostosFederais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
Var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  If Pos('PERSONALIZ', Self.strCodFormul) > 0 Then
    fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido)
  Else
    fltQtdFor := fArredondaNEX(TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido), 1));

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  fltVenBas := (fltQtdFor * base.PrecoVenda / base.Cnv_Ml);

  Result := (fltVenBas * base.ImpostosFederais / 100);
end;

function TFormulaAutomotivaNexa.GetCalcOutrosValores(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  If Pos('PERSONALIZ', Self.strCodFormul) > 0 Then
    fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido)
  Else
    fltQtdFor := fArredondaNEX(TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido), 1));

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  Result := (fltQtdFor * base.OutrosValores / base.Cnv_Ml);
end;

function TFormulaAutomotivaNexa.GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  If Pos('PERSONALIZ', Self.strCodFormul) > 0 Then
    fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido)
  Else
    fltQtdFor := fArredondaNEX(TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido), 1));

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  Result := (fltQtdFor * base.PrecoCompraLiquido / base.Cnv_Ml);
end;

function TFormulaAutomotivaNexa.GetCalcPrecoCusto(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  If Pos('PERSONALIZ', Self.strCodFormul) > 0 Then
    fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido)
  Else
    fltQtdFor := fArredondaNEX(TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido), 1));

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  Result := (fltQtdFor * base.PrecoCusto / base.Cnv_Ml);
end;

function TFormulaAutomotivaNexa.GetCalcPrecoCustoReal(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  If Pos('PERSONALIZ', Self.strCodFormul) > 0 Then
    fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido)
  Else
    fltQtdFor := fArredondaNEX(TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido), 1));

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  Result := (fltQtdFor * base.PrecoCustoReal / base.Cnv_Ml);
end;

function TFormulaAutomotivaNexa.GetCalcPrecoMedio(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  If Pos('PERSONALIZ', Self.strCodFormul) > 0 Then
    fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido)
  Else
    fltQtdFor := fArredondaNEX(TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido), 1));

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  Result := (fltQtdFor * base.PrecoMedio / base.Cnv_Ml);
end;

function TFormulaAutomotivaNexa.GetCalcPrecoVenda(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
Var
  fltQtdFor: Double;
Begin
  If Pos('PERSONALIZ', Self.strCodFormul) > 0 Then
    fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido)
  Else
    fltQtdFor := fArredondaNEX(TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido), 1));

  Result := (((formula.VolumePro / formula.VolumeOri * fltQtdFor) * base.PrecoVenda) / Base.Cnv_Ml);
end;

function TFormulaAutomotivaNexa.GetCalcQuantidade(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
Var
  fltQtdFor: Double;
begin
  If Pos('PERSONALIZ', Self.strCodFormul) > 0 Then
    fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido)
  Else
    fltQtdFor := fArredondaNEX(TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido), 1));

  Result := (fltQtdFor * (formula.VolumePro / formula.VolumeOri));
end;

function TFormulaAutomotivaNexa.GetCalculadorInterno: ICalculadorFormulaAutomotiva;
begin
  Result := TCalculadorFormulaAutomotivaNexa.Create(Self);
end;

function TFormulaAutomotivaNexa.GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  If Pos('PERSONALIZ', Self.strCodFormul) > 0 Then
    fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido)
  Else
    fltQtdFor := fArredondaNEX(TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido), 1));

  fltQtdFor := fltQtdFor * formula.VolumePro / formula.VolumeOri;

  Result := (fltQtdFor * base.UltimoPrecoCompra / base.Cnv_Ml);
end;

function TFormulaAutomotivaNexa.GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  If Pos('PERSONALIZ', Self.strCodFormul) > 0 Then
    fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', Base.QuantidadeConcentrado, Base.QuantidadeDiluido)
  Else
    fltQtdFor := fArredondaNEX(TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido), 1));

  fltQtdFor := (fltQtdFor * formula.VolumePro / formula.VolumeOri);

  Result := (fltQtdFor * base.UltimoPrecoCompraImpostos / base.Cnv_Ml);
end;

function TFormulaAutomotivaNexa.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('NEX_MD5KEY').AsString;
end;

function TFormulaAutomotivaNexa.GetCodFormul(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('NEX_SISTEM').AsString;
end;

function TFormulaAutomotivaNexa.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('NEX_DESCOR').AsString + ' ' +
            dtsCadTin.FieldByName('NEX_TIPO__').AsString + ' ' +
            dtsCadTin.FieldByName('NEX_A_N_O_').AsString + ' ' +
            dtsCadTin.FieldByName('NEX_CODCOR').AsString;
end;

function TFormulaAutomotivaNexa.GetDescricaoBase(strCodBas: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DESBAS '+
                    '  FROM NEX_CADBAS '+
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

function TFormulaAutomotivaNexa.fGetDiluentes(const dtsCadTin: IDataSet): TStringList;
var
  qryGen      : IDataSet;
begin

  Self.ListaAdicional.Clear;

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT DISTINCT                                    ' +
                '   *                                                ' +
                ' FROM                                               ' +
                '   NEX_CADBAS B                                     ' +
                '   INNER JOIN PPG_CADDIL D                          ' +
                '     ON B.BAS_CODBAS = D.DIL_CODDIL                 ' +
                ' WHERE BAS_TIPO__ = :TIPO                           ' +
                '   AND ((:SISTEM LIKE CONCAT("%", DIL_SISTEM, "%")) ' +
                '     OR (:SISTEM = "PERSONALIZADA"))                ';


  qryGen.ParamByName('TIPO').AsString   := dtsCadTin.FieldByName('NEX_TIPO__').AsString;
  qryGen.ParamByName('SISTEM').AsString := dtsCadTin.FieldByName('NEX_SISTEM').AsString;
  qryGen.Open;

  Result := TStringList.Create;

  While not qryGen.Eof do
  begin
    Result.Add(qryGen.FieldByName('BAS_CODBAS').AsString);
    qryGen.Next;
  end;

  If Result.Count > 0 Then
  Begin
    Self.blnDadosAdicionais  := True;
    Self.strCaptionAdicional := 'Diluentes';
    Self.blnAdicionalDiluido := True;
  End
  else
    FreeAndNil(Result);

end;


function TFormulaAutomotivaNexa.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaAutomotivaNexa.GetIdePro: String;
begin
  Result := 'NEX';
end;

function TFormulaAutomotivaNexa.GetIndEmb(
  const dtsCadTin: IDataSet): integer;
begin
  Result := -1;
end;

function TFormulaAutomotivaNexa.GetLinha(const dtsCadTin: IDataSet): string;
begin
//  Result := dtsCadTin.FieldByName('NEX_TIPO__').AsString;
  Result := dtsCadTin.FieldByName('NEX_SISTEM').AsString;
end;

function TFormulaAutomotivaNexa.GetMontadora(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('MON_DESCRI').AsString;
end;

function TFormulaAutomotivaNexa.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaAutomotivaNexa.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaAutomotivaNexa.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaAutomotivaNexa.GetNomeTabelaBases: String;
begin
  Result := 'NEX_CADBAS ';
end;

Procedure TFormulaAutomotivaNexa.pPreencherPesCorFor(const dtsCadTin: IDataSet);
begin
  Self.PesoCor := 0; //dtsCadTin.FieldByName('GEN_PESCOR').AsFloat;
  Self.PesoFor := 0; //dtsCadTin.FieldByName('GEN_PESFOR').AsFloat;
end;

{$IFNDEF LINUX}
procedure TFormulaAutomotivaNexa.pRecalculaFormulaMostrarDigitado(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; fltFator: Double;
  blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha, strTipBas: String);
begin
  self.fltVolumeOri := 1000;

  If self.fltVolumeOri > 0 Then
    fltFator := self.fltVolumePro / self.fltVolumeOri
  Else
    fltFator := 1;

  If self.fltVolumeOri > 1 Then
    fltFator := fltFator * 1000;

  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    If Pos('PERSONALIZ', Base.System) <= 0 Then
    Begin
      SubItems.Add(FloatToStrF(fArredondaNEX(Base.QuantidadeConcentrado * fltFator), ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(fArredondaNEX(Base.QuantidadeDiluido     * fltFator), ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(fArredondaNEX(Base.QuantidadeDiluido2    * fltFator), ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
      SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
      SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
    End
    Else
    Begin
      SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado * fltFator, ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(Base.QuantidadeDiluido     * fltFator, ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(Base.QuantidadeDiluido2    * fltFator, ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
      SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
      SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
    End;

  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TFormulaAutomotivaNexa.pRecalculaFormulaMostrarPadrao(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; blnConsLinhaDesBas: Boolean;
  strTipBas: String; intCont: Integer);
begin
   With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    If Pos('PERSONALIZ', Base.System) <= 0 Then
    Begin
      SubItems.Add(FloatToStrF(fArredondaNEX(Base.QuantidadeConcentrado), ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(fArredondaNEX(Base.QuantidadeDiluido), ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(fArredondaNEX(Base.QuantidadeDiluido2), ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
      SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
      SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
    End
    Else
    Begin
      SubItems.Add(FloatToStrF(Base.QuantidadeConcentrado, ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(Base.QuantidadeDiluido, ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(Base.QuantidadeDiluido2, ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
      SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
      SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
    End;

  End;
end;
{$ENDIF}

function TFormulaAutomotivaNexa.GetPrefixoFormulacao: String;
begin
  Result := 'NEX_CODB';
end;

function TFormulaAutomotivaNexa.GetPrefixoLitragem(
  const strModo: String): String;
begin
  Result := '';
end;

function TFormulaAutomotivaNexa.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'NEX_QTDB';
end;

function TFormulaAutomotivaNexa.GetProdutoVendaTinta(const dtsCadTin: IDataSet): string;
begin

  If Pos('2K', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGet('PRONEXA')
  else
  If Pos('ACS (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGet('PROACS')
  Else
  If Pos('INDUSTRAN', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGet('PROIND')
  else
  If (Pos('FLAT CLEAR', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0)
   Or (Pos('SPECTRAL GREY', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0) Then
    Result := TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGet('PROSPE')
  else
  If Pos('ZYNAMIX', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGet('PROZYN')
  else
  If Pos('ACS EVOLUTION (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGet('PROEVO')
  else
  If Pos('TURBO PLUS', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGet('PROTUR');


  If TStrUtils.fEmptyStr(Result) And (Not fConfProdutoVendaCriada) Then
    Result := TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGet('PRONEXA')
end;

function TFormulaAutomotivaNexa.GetQuantidadeFormulacao: Integer;

begin
  Result := 20;
end;

function TFormulaAutomotivaNexa.GetSaldos: ISaldosColorantes;
var
  intCont: Integer;
  saldos: TGenericSaldosColorantes;
  base: TBaseAutomotiva;
  fltQtdFormul: Double;
  blnBaseEmpresa: Boolean;
begin
  saldos := TGenericSaldosColorantes.Create();

  for intCont := 0 to Self.Count - 1 do
  begin
    base := TBaseAutomotiva(Self.Items[intCont]);

    If GetDataSetBasesPorEmpresa.Locate('BAS_CODBAS;BAS_CODEMP', VarArrayOf([base.CodigoBase, strCodEmp]), []) Then
      blnBaseEmpresa := True
    Else If GetDataSetBases.Locate('BAS_CODBAS', base.CodigoBase, []) Then
      blnBaseEmpresa := False
    Else
      blnBaseEmpresa := False;


    if (Base.TipoBase = 'C') and not(self.ComCatalisador) then
      Continue;

    If (Self.mveModoVenda = mvConcentrado) And (Base.TipoBase = 'D') Then
      Continue;

    fltQtdFormul := fCalculaQuantidadeParaBaixaEstoque(Base);

    if fltQtdFormul > 0 then
    begin
      saldos.Adicionar(TGenericSaldoColorante.Create(
        1,
        Descricao,
        TAutcomTintaFactory.Get.IIF(blnBaseEmpresa, GetDataSetBasesPorEmpresa.FieldByName('BAS_CODITE').AsString, GetDataSetBases.FieldByName('BAS_CODITE').AsString),
        VarToStrDef(TAutcomTintaFactory.Get.GetValorCampo('SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE', 'ITE_DESITE', [
        TAutcomTintaFactory.Get.IIF(blnBaseEmpresa, GetDataSetBasesPorEmpresa.FieldByName('BAS_CODITE').AsString, GetDataSetBases.FieldByName('BAS_CODITE').AsString)]), ''),
        Base.CodigoBase,
        fltQtdFormul,
        BASE_AUTOMOTIVA,
        'N',
        0.0));
    end;
  end;

  Result := saldos;
end;

function TFormulaAutomotivaNexa.GetSelectBases: String;
begin
  Result := ' SELECT         ' +
            '     BAS_CODBAS ' +
            '   , BAS_CODITE ' +
            '   , BAS_EMBALA ' +
            '   , BAS_DESBAS ' +
            '   , BAS_PESESP ' +
            '   , BAS_TIPO__ ' +
            '   , BAS_BASEPO ' +
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

function TFormulaAutomotivaNexa.GetSelectBasesPorEmpresa: String;
begin
  Result := ' SELECT         ' +
            '     BAS_CODBAS ' +
            '   , BAS_CODITE ' +
            '   , BAS_CODEMP ' +
            '   , "0" AS BAS_EMBALA ' +
            '   , "0" AS BAS_PESESP ' +
            '   , "N" AS BAS_BASEPO ' +
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

function TFormulaAutomotivaNexa.GetTextoInformativoCalculo: String;
begin
  Result  := 'Valor da Base = (Quantidade * Preço) / (Embalagem * Peso Específico)' + sLineBreak +
             'Preço da Tinta = Soma(Valores de Base) * Volume Produzido' ;
end;

function TFormulaAutomotivaNexa.GetUniversal(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaNexa.GetVolumeMaximoBalde(
  dtsCadTin: IDataSet): Double;
begin
  Result := 18.000;

  If Not fExisteConfiguracao(dtsCadTin, 'Balde') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  If Pos('2K', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMB2K'), 3)
  Else If Pos('ACS (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMBAC'), 3)
  Else If Pos('ACS EVOLUTION (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMBEV'), 3)
  Else If Pos('FLAT CLEAR', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMBSG'), 3)
  Else If Pos('SPECTRAL GREY', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMBSG'), 3)
  Else If Pos('INDUSTRAN', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMBIN'), 3)
  Else If Pos('TURBO PLUS', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMBTP'), 3)
  Else If Pos('ZYNAMIX', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMBZY'), 3);
end;

function TFormulaAutomotivaNexa.GetVolumeMaximoCopo(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Copo') Then
  Begin
    Result := 0.500;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLUCOPO'), 3);
end;

function TFormulaAutomotivaNexa.GetVolumeMaximoGalao(
  dtsCadTin: IDataSet): Double;
begin
  Result := 3.500;

  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 4.000;
    Exit;
  End;

  If Pos('2K', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMG2K'), 3)
  Else If Pos('ACS (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMGAC'), 3)
  Else If Pos('ACS EVOLUTION (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMGEV'), 3)
  Else If Pos('FLAT CLEAR', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMGSG'), 3)
  Else If Pos('SPECTRAL GREY', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMGSG'), 3)
  Else If Pos('INDUSTRAN', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMGIN'), 3)
  Else If Pos('TURBO PLUS', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMGTP'), 3)
  Else If Pos('ZYNAMIX', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMGZY'), 3);
end;

function TFormulaAutomotivaNexa.GetVolumeMaximoLitro(
  dtsCadTin: IDataSet): Double;
begin
  Result := 1.000;

  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 1.000;
    Exit;
  End;

  If Pos('2K', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPML2K'), 3)
  Else If Pos('ACS (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMLAC'), 3)
  Else If Pos('ACS EVOLUTION (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMLEV'), 3)
  Else If Pos('FLAT CLEAR', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMLSG'), 3)
  Else If Pos('SPECTRAL GREY', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMLSG'), 3)
  Else If Pos('INDUSTRAN', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMLIN'), 3)
  Else If Pos('TURBO PLUS', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMLTP'), 3)
  Else If Pos('ZYNAMIX', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMLZY'), 3);
end;

function TFormulaAutomotivaNexa.GetVolumeMaximoSpray(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Spray') Then
  Begin
    Result := 0.450;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLSPR'), 3);
end;


function TFormulaAutomotivaNexa.GetVolumeMaximoTambor(
  dtsCadTin: IDataSet): Double;
begin
  Result := 200.000;

  If Not fExisteConfiguracao(dtsCadTin, 'Tambor') Then
  Begin
    Result := 200.000;
    Exit;
  End;

  If Pos('2K', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMT2K'), 3)
  Else If Pos('ACS (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMTAC'), 3)
  Else If Pos('ACS EVOLUTION (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMTEV'), 3)
  Else If Pos('FLAT CLEAR', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMTSG'), 3)
  Else If Pos('SPECTRAL GREY', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMTSG'), 3)
  Else If Pos('INDUSTRAN', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMTIN'), 3)
  Else If Pos('TURBO PLUS', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMTTP'), 3)
  Else If Pos('ZYNAMIX', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMTZY'), 3);
end;

function TFormulaAutomotivaNexa.GetVolumePadraCopo: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Copo') Then
  Begin
    Result := 0.500;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLUCOPO'), 3);
end;

function TFormulaAutomotivaNexa.GetVolumePadraGalao(dtsCadTin: IDataSet): Double;
begin
  Result := 3.500;

  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 3.500;
    Exit;
  End;

  If Pos('2K', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMG2K'), 3)
  Else If Pos('ACS (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMGAC'), 3)
  Else If Pos('ACS EVOLUTION (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMGEV'), 3)
  Else If Pos('FLAT CLEAR', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMGSG'), 3)
  Else If Pos('SPECTRAL GREY', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMGSG'), 3)
  Else If Pos('INDUSTRAN', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMGIN'), 3)
  Else If Pos('TURBO PLUS', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMGTP'), 3)
  Else If Pos('ZYNAMIX', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMGZY'), 3);
end;

function TFormulaAutomotivaNexa.GetVolumePadraLitro: Double;
begin
  Result := 1.000;
end;

function TFormulaAutomotivaNexa.GetVolumePadraoBalde(
  dtsCadTin: IDataSet): Double;
begin
  Result := 18.000;

  If Not fExisteConfiguracao(dtsCadTin, 'Balde') Then
  Begin
    Result := 18.000;
    Exit;
  End;

  If Pos('2K', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMB2K'), 3)
  Else If Pos('ACS (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMBAC'), 3)
  Else If Pos('ACS EVOLUTION (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMBEV'), 3)
  Else If Pos('FLAT CLEAR', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMBSG'), 3)
  Else If Pos('SPECTRAL GREY', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMBSG'), 3)
  Else If Pos('INDUSTRAN', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMBIN'), 3)
  Else If Pos('TURBO PLUS', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMBTP'), 3)
  Else If Pos('ZYNAMIX', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMBZY'), 3);
end;

function TFormulaAutomotivaNexa.GetVolumePadraSpray: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Spray') Then
  Begin
    Result := 0.450;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLSPR'), 3);
end;


function TFormulaAutomotivaNexa.GetVolumePadraTambor(dtsCadTin: IDataSet): Double;
begin
  Result := 200.000;

  If Not fExisteConfiguracao(dtsCadTin, 'Tambor') Then
  Begin
    Result := 200.000;
    Exit;
  End;

  If Pos('2K', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMT2K'), 3)
  Else If Pos('ACS (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMTAC'), 3)
  Else If Pos('ACS EVOLUTION (LA)', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMTEV'), 3)
  Else If Pos('FLAT CLEAR', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMTSG'), 3)
  Else If Pos('SPECTRAL GREY', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMTSG'), 3)
  Else If Pos('INDUSTRAN', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMTIN'), 3)
  Else If Pos('TURBO PLUS', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMTTP'), 3)
  Else If Pos('ZYNAMIX', dtsCadTin.FieldByName('NEX_TIPO__').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('NEX').fGetDouble('VOLPMTZY'), 3);
end;

function TFormulaAutomotivaNexa.GetVolumePermitido(
  const dtsCadTin: IDataSet; strTipoPre: String): Double;
begin
  Result := 0;
end;

procedure TFormulaAutomotivaNexa.IniciaArrMinMax(const dtsCadTin: IDataSet);
var
  qryGen : IDataSet;
  intCont: Integer;
begin
  SetLength(arrMinMax, Self.ListaAdicional.Count);

  if Self.ListaAdicional.Count <= 0 then
    Exit;

  qryGen := nil;

  qryGen     := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT DISTINCT                                    ' +
                '   *                                                ' +
                ' FROM                                               ' +
                '   NEX_CADBAS B                                     ' +
                '   INNER JOIN PPG_CADDIL D                          ' +
                '     ON B.BAS_CODBAS = D.DIL_CODDIL                 ' +
                ' WHERE BAS_TIPO__ = :TIPO                           ' +
                '   AND ((:SISTEM LIKE CONCAT("%", DIL_SISTEM, "%")) ' +
                '     OR (:SISTEM = "PERSONALIZADA"))                ' +
                '   AND DIL_CODDIL = :CODDIL                         ' +
                ' ORDER BY DIL_SISTEM                                ' ;

  qryGen.ParamByName('TIPO').AsString   := dtsCadTin.FieldByName('NEX_TIPO__').AsString;
  qryGen.ParamByName('SISTEM').AsString := dtsCadTin.FieldByName('NEX_SISTEM').AsString;

  for intCont := 0 to Self.ListaAdicional.Count - 1 do
  begin
    qryGen.Close;
    qryGen.ParamByName('CODDIL').AsString := Self.ListaAdicional[intCont];
    qryGen.Open;

    arrMinMax[intCont].fltMin := qryGen.FieldByName('DIL_MINIMO').AsFloat;
    arrMinMax[intCont].fltMax := qryGen.FieldByName('DIL_MAXIMO').AsFloat;
  end;


end;

procedure TFormulaAutomotivaNexa.pAtualizaPorcentagem(const formula: TAbstractFormulaAutomotiva;  dtsCadTin: IDataSet);
begin

   If (formula.ListaAdicional.Count <= 0) Then
    Exit;

   formula.EdtDil := Length(arrMinMax) > 0;

  If formula.PorDil > arrMinMax[formula.IndiceAdicional].fltMax Then
    formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltMax;

  If Length(arrMinMax) > 0 Then
  Begin
    if arrMinMax[Formula.IndiceAdicional].fltMax = arrMinMax[Formula.IndiceAdicional].fltMin then
      formula.HabDil := False
    else
      formula.HabDil := true;

    If formula.PorDil > arrMinMax[Formula.IndiceAdicional].fltMax Then
      formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltMax;

    If formula.PorDil < arrMinMax[Formula.IndiceAdicional].fltMin Then
      formula.PorDil := arrMinMax[Formula.IndiceAdicional].fltMin;
  End;
end;

procedure TFormulaAutomotivaNexa.pDefineVolumeOriginal;
begin
  If Self.mveModoVenda = mvConcentrado then
    Self.VolumeOri := Self.VolumeConcentrado
  Else
    Self.VolumeOri := Self.VolumeDiluido;
end;

procedure TFormulaAutomotivaNexa.pPreencheListaAdicionalBases;
begin

end;

procedure TFormulaAutomotivaNexa.pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet);
var
  conf      : IConfTinta;
  strTipCor : String;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('NEX');

  DesEmb.Clear;
  ProEmbLt.Clear;
  ProEmbGl.Clear;
  ProEmbLa.Clear;

  sProEmbTb := '';
  sProEmbBa := '';
  sProEmbSs := '';
  sProEmbPo := '';
  sProEmbSd := '';

  strProEmbCo := '';

  stlDesEmb.Clear;

  strTipCor := fRetTipoCor(dtsCadTin);

  stlDesEmb.Text := strTipCor;

  stlProEmbLt.Text := fRetEmbalagemLT(strTipCor);
  stlProEmbGl.Text := fRetEmbalagemGL(strTipCor);
  sProEmbBa        := fRetEmbalagemBD(strTipCor);
  sProEmbTb        := fRetEmbalagemTB(strTipCor);
  strProEmbCo      := fRetEmbalagemCP;
  strProEmbSp      := fRetEmbalagemSP;


  IniciaArrMinMax(dtsCadTin);

  Self.blnMostrarEmbalagem := true;

  strSistema := dtsCadTin.FieldByName('NEX_SISTEM').AsString;

  If ListaAdicional.Count > 0 Then
    pCalcularDiluente(ListaAdicional[0], 0, dtsCadTin)
  Else
    pCalcularDiluente('', 0, dtsCadTin);
end;

procedure TFormulaAutomotivaNexa.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('NEX_ACRMOB').AsFloat;
end;

procedure TFormulaAutomotivaNexa.PreencheQuantidadeFormulacaoVenda(const dtsCadTin: IDataSet);
Var
  intContador: Integer;
  Base: TBaseAutomotiva;
begin

  For intContador := 1 To Self.GetQuantidadeFormulacao Do
  Begin
    If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('NEX_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
      Break;

    Base                       := TBaseAutomotiva(Self.Add);
    Base.CodigoBase            := trim(dtsCadTin.FieldByName('NEX_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString);
    Base.QuantidadeConcentrado := dtsCadTin.FieldByName('NEX_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
    Base.TipoBase              := 'B';
    Base.System                := dtsCadTin.FieldByName('NEX_SISTEM').AsString;
  End;



end;

procedure TFormulaAutomotivaNexa.PreencheVolumeVenda(const dtsCadTin: IDataSet);
begin
  Self.VolumeOri         := 1;
  Self.VolumeConcentrado := 1;
  Self.VolumeDiluido     := 1;
end;

procedure TFormulaAutomotivaNexa.pCalcularDiluente(const strCodDil: string; const fltPorDil: Double; const dtsCadTin: IDataSet);
Var
  qryGen     :  IDataSet;
  intCont    : Integer;
  Dicionario : IDicionario;
  diluente   : TBaseAutomotiva;
  base       : TBaseAutomotiva;
  fltTaxa    : Double;

  fltTotalVolumeDiluido : Double;
  fltTotalVolumeAtual   : Double;
begin
  qryGen := nil;
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := ' SELECT DISTINCT                                    ' +
                    '   *                                                ' +
                    ' FROM                                               ' +
                    '   NEX_CADBAS B                                     ' +
                    '   INNER JOIN PPG_CADDIL D                          ' +
                    '     ON B.BAS_CODBAS = D.DIL_CODDIL                 ' +
                    ' WHERE BAS_TIPO__ = :TIPO                           ' +
                    '   AND ((:SISTEM LIKE CONCAT("%", DIL_SISTEM, "%")) ' +
                    '     OR (:SISTEM = "PERSONALIZADA"))                ' +
                    '   AND D.DIL_CODDIL = :CODDIL ';

      qryGen.ParamByName('TIPO').AsString   := dtsCadTin.FieldByName('NEX_TIPO__').AsString;
      qryGen.ParamByName('SISTEM').AsString := dtsCadTin.FieldByName('NEX_SISTEM').AsString;
      qryGen.ParamByName('CODDIL').AsString := strCodDil;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      fltTotalVolumeAtual := 0;

      If self.Count <= 0 Then
        Exit;


      for intCont := self.Count - 1 downto 0 do
      begin
        base := (Self.Items[intCont] as TBaseAutomotiva);

        if base.TipoBase <> 'B' then
          Self.Delete(intCont)
        else
          fltTotalVolumeAtual := fltTotalVolumeAtual + (base.QuantidadeConcentrado / base.PesoEspecifico);

      end;

      fltTotalVolumeDiluido := fltTotalVolumeAtual + (fltPorDil * fltTotalVolumeAtual / 100);
      fltTaxa := fltTotalVolumeAtual / fltTotalVolumeDiluido;

      diluente := (Self.Add as TBaseAutomotiva);
      diluente.CodigoBase        := strCodDil;
      diluente.TipoBase          := 'D';
      diluente.PesoEspecifico    := qryGen.FieldByName('BAS_PESESP').AsFloat;
      diluente.QuantidadeDiluido := (fltPorDil * fltTotalVolumeAtual / 100) * diluente.PesoEspecifico;


      for intCont := Self.Count - 1 downto 0 do
      begin
        base := (Self.Items[intCont] as TBaseAutomotiva);

        if base.TipoBase <> 'D' then
        begin
          base.QuantidadeDiluido := base.QuantidadeConcentrado  * fltTaxa;
        end
        else
        begin
          base.QuantidadeDiluido := base.QuantidadeDiluido * fltTaxa;
        end;
      end;

      Dicionario := TAutcomTintaFactory.Get.GetDicionario;

      Self.CarregarBases(Dicionario);
      Self.CarregarBasesPorEmpresa(Dicionario);

      Self.CarregaPrecosBases;
      Self.CarregaPrecosBasesPorEmpresa;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;


end;

end.
