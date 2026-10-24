{************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula Lazzumix *}
{*********************************************************************AC*}
unit untFormulaAutomotivaLazzumix;

interface

uses
{$IFNDEF LINUX}
  Controls,
  ComCtrls,
{$ENDIF}
  untAbstractFormulaAutomotiva, untICalculadorFormulaAutomotiva, untIDataSet, untBaseAutomotiva,
  SysUtils, untStrUtils, Classes, untIConfTinta, untFloatUtils, untModoVenda,
  untIDicionario, System.Variants, untGenericSaldosColorantes, untISaldosColorantes, untVariantUtils;


type
  TFormulaAutomotivaLazzumix = class(TAbstractFormulaAutomotiva)
  private
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
  public
    procedure CarregarBasesPorEmpresa(const dicRetorno: IDicionario); override;
    procedure CarregaPrecosBasesPorEmpresa; override;
    function GetSelectBasesPorEmpresa: String;
    procedure RecalcularTabelasGeneric(dicRetorno: IDicionario); Override;
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
    function GetVolumePadraCopo : Double; override;
    function fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer; dtsCadTin: IDataSet): Double; override;
    function GetVolumePadraGalao(dtsCadTin: IDataSet): Double; override;
    function GetVolumePadraoLata(dtsCadTin: IDataSet): Double; override;

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
    function fVolumeOriginalFator: Boolean; override;

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

    function GetVolumeMaximoLitro(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoGalao(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoLata(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoCopo(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoSpray(dtsCadTin: IDataSet): Double; Override;

    function fExisteConfiguracao(dtsCadTin: IDataSet; strEmbalagem: String): Boolean; Override;
    function fRetEmbLitro(dtsCadTin: IDataSet): String;
    function fRetEmbGalao(dtsCadTin: IDataSet): String;
    function fRetEmbLata(dtsCadTin: IDataSet): String;
    function GetSaldos: ISaldosColorantes; Override;

    function GetTemDiluido: Boolean; Override;
    function fHabilitaRdgModoVenda(const dtsCadTin: IDataSet; blnDiluido, blnConcentrado: Boolean): Boolean; Override;
    function fOpcaoRdgMovoVenda(const dtsCadTin: IDataSet; blnConcentrado: Boolean): Integer; Override;
    function fSprayVendaConcentrado(const dtsCadTin: IDataSet; ItemIndex: Integer): Integer; Override;
    function fOutrasEmbalagens(const dtsCadTin: IDataSet; ItemIndex: Integer): Integer; Override;


  end;

implementation

uses
  untCalculadorFormulaAutomotivaLazzumix, untAutcomTintaFactory;

{ TFormulaAutomotivaLazzumix }

procedure TFormulaAutomotivaLazzumix.CarregaPrecosBasesPorEmpresa;
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

  strCodEmpresa := fVerificaEmpresaSetada();

  Self.pPreencheListaAdicionalBases;

  For intContador := 0 To Self.Count-1 Do
  Begin
    Base := TBaseAutomotiva(Self.Items[intContador]);
    If GetDataSetBasesPorEmpresa.Locate('BAS_CODBAS;BAS_CODEMP', VarArrayOf([Base.CodigoBase, strCodEmp]), []) Then
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
      Base.Embalagem                 := GetDataSetBasesPorEmpresa.FieldByName('BAS_EMBALA').AsFloat;
      Base.PesoEspecifico            := GetDataSetBasesPorEmpresa.FieldByName('BAS_PESESP').AsFloat;

      Base.PrecoMedio                := GetDataSetBasesPorEmpresa.FieldByName('ITE_PREMED').AsFloat;
      Base.UltimoPrecoCompra         := GetDataSetBasesPorEmpresa.FieldByName('ITE_PREULT').AsFloat;
      Base.UltimoPrecoCompraImpostos := GetDataSetBasesPorEmpresa.FieldByName('ITE_IMPULT').AsFloat;
      Base.PrecoCompraLiquido        := TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fCalculaPrecoCompraLiq(
                                                                                     GetDataSetBasesPorEmpresa.Fieldbyname('ITE_PRECOM').AsFloat, GetDataSetBasesPorEmpresa.Fieldbyname('ITE_DESF01').AsFloat,
                                                                                     GetDataSetBasesPorEmpresa.Fieldbyname('ITE_DESF02').AsFloat, GetDataSetBasesPorEmpresa.Fieldbyname('ITE_DESF03').AsFloat,
                                                                                     GetDataSetBasesPorEmpresa.Fieldbyname('ITE_DESF04').AsFloat, GetDataSetBasesPorEmpresa.Fieldbyname('ITE_DESF05').AsFloat,
                                                                                     GetDataSetBasesPorEmpresa.Fieldbyname('ITE_DESF06').AsFloat), TAutcomTintaFactory.Get.fCfgSis('DECUNI', VarInteger));

      Base.PesGra                    := GetBasPesGra(GetDataSetBases);

      blnEmPromo := TAutcomTintaFactory.Get.fCarregaPromocao(GetDataSetBasesPorEmpresa.FieldByName('BAS_CODITE').AsString,
                                                             strTabPre, Self.strCodCli, Self.strCodCnd, Self.intPrzMed,
                                                             fltPreCus, fltPreVen, blnPrecoFixoParaTintaDeMaquinaImobiliaria, strCodEmpresa);

      If (blnEmPromo) And (Not Self.blnProPre) Then
      Begin
        Base.PrecoCusto := fltPreCus;
        Base.PrecoVenda := fltPreVen;

        If strTabPre = strTabPreTin Then
          Self.Promoc := 'S';

        if Base.PrecoCusto = 0 then
          Base.PrecoCusto := GetDataSetBasesPorEmpresa.FieldByName('ITE_PRECUS').AsFloat;
      End
      Else
      Begin
        Base.PrecoCusto := GetDataSetBasesPorEmpresa.FieldByName('ITE_PRECUS').AsFloat;
        Base.PrecoVenda := GetDataSetBasesPorEmpresa.FieldByName('ITE_PREVEN').AsFloat;

        If (Self.blnProPre) And (blnEmPromo) And (strTabPre = strTabPreTin) Then
          Self.Promoc := 'S';
      End;
      CarregaPrecosColorantesAdicional(GetDataSetBasesPorEmpresa, Base);
    End;
  End;

  TextoInformativoCalculo.Text := GetTextoInformativoCalculo;
end;

procedure TFormulaAutomotivaLazzumix.CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva);
begin
  Base.Cnv_Ml := Base.Embalagem * Base.PesoEspecifico;
end;

procedure TFormulaAutomotivaLazzumix.CarregarBasesPorEmpresa(
  const dicRetorno: IDicionario);
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
    '    LAZ_BASEMP B     ' +
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

function TFormulaAutomotivaLazzumix.fExisteConfiguracao(dtsCadTin: IDataSet;
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
    qryConf.SQL := qryConf.SQL + '    CFG_IDEPRO = "LAZ" AND            ';
    qryConf.SQL := qryConf.SQL + '    CFG_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" AND        ';

    If strEmbalagem = 'Litro' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "' + fRetEmbLitro(dtsCadTin) + '"        '
    Else If strEmbalagem = 'Galão' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "' + fRetEmbGalao(dtsCadTin) + '"        '
    Else If strEmbalagem = 'Lata' Then
      qryConf.SQL := qryConf.SQL + '  CFG_CODCFG = "' + fRetEmbLata(dtsCadTin) + '"         '
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

function TFormulaAutomotivaLazzumix.fHabilitaRdgModoVenda(
  const dtsCadTin: IDataSet; blnDiluido, blnConcentrado: Boolean): Boolean;
begin
  Result := blnConcentrado And blnDiluido;

  If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR' Then
    Result := False;
end;

function TFormulaAutomotivaLazzumix.fMostrarComCatalisador: Boolean;
begin
  Result := False;
end;

function TFormulaAutomotivaLazzumix.fOpcaoRdgMovoVenda(
  const dtsCadTin: IDataSet; blnConcentrado: Boolean): Integer;
begin
  Result := TAutcomTintaFactory.Get.IIF(blnConcentrado, 0, 1);

  If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR' Then
    Result := 1;
end;

function TFormulaAutomotivaLazzumix.fOutrasEmbalagens(const dtsCadTin: IDataSet;
  ItemIndex: Integer): Integer;
begin
  Result := ItemIndex;

  If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR' Then
    Result := 1;
end;

function TFormulaAutomotivaLazzumix.fRetEmbGalao(dtsCadTin: IDataSet): String;
begin
  Result := '';

  If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZURIL' Then
    Result := 'VOLIGL'
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZULAC' Then
    Result := 'VOLGLA'
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR' Then
    Result := 'VOLGPO'
  Else If (Pos('LEGACY', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0) Then
    Result := 'VOLGLL'
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'POLIURETANO' Then
    Result := 'VOLGPU'
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUCRIL' Then
    Result := 'VOLGCR'
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'FLEET COLOR' Then
    Result := 'VOLGFL'
  Else If Pos('ULTRA', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0 Then
    Result := 'VOLGUL'
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR PU MS' Then
    Result := 'VOLSGL'
  Else If (Pos('SHERTRUCK', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0) Then
    Result := 'VOLRGL'
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'PERSONALIZADA' Then
    Result := 'VOLNGL';
end;

function TFormulaAutomotivaLazzumix.fRetEmbLata(dtsCadTin: IDataSet): String;
begin
  Result := '';

  If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZURIL' Then
    Result := 'VOLILA'
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZULAC' Then
    Result := 'VOLLAZ'
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR' Then
    Result := 'VOLLDU'
  Else If (Pos('LEGACY', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0) Then
    Result := 'VOLLAL'
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'POLIURETANO' Then
    Result := 'VOLLAP'
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUCRIL' Then
    Result := 'VOLLIL'
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'FLEET COLOR' Then
    Result := 'VOLLCO'
  Else If Pos('ULTRA', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0 Then
    Result := 'VOLLAU'
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR PU MS' Then
    Result := 'VOLSLA'
  Else If (Pos('SHERTRUCK', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0) Then
    Result := 'VOLRLA'
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'PERSONALIZADA' Then
    Result := 'VOLNLA';
end;

function TFormulaAutomotivaLazzumix.fRetEmbLitro(dtsCadTin: IDataSet): String;
begin
  Result := '';

  If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZURIL' Then
    Result := 'VOLIEM'
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZULAC' Then
    Result := 'VOLLLA'
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR' Then
    Result := 'VOLLPO'
  Else If (Pos('LEGACY', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0) Then
    Result := 'VOLLTL'
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'POLIURETANO' Then
    Result := 'VOLLPU'
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUCRIL' Then
    Result := 'VOLLCR'
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'FLEET COLOR' Then
    Result := 'VOLLFL'
  Else If Pos('ULTRA', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0 Then
    Result := 'VOLLUL'
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR PU MS' Then
    Result := 'VOLSLT'
  Else If (Pos('SHERTRUCK', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0) Then
    Result := 'VOLRLT'
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'PERSONALIZADA' Then
    Result := 'VOLNLT';
end;

function TFormulaAutomotivaLazzumix.fSprayVendaConcentrado(
  const dtsCadTin: IDataSet; ItemIndex: Integer): Integer;
begin
  Result := ItemIndex;

  If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR' Then
    Result := 0;
end;

function TFormulaAutomotivaLazzumix.fValidaVolumeFormulucao(strTipoPre: String;
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := True;

  If strTipoPre = 'C' Then // Concentrado
  Begin
    If dtsCadTin.FieldByName('MIX_VOLCON').AsFloat = 0 Then
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','O Volume do concentrado está zerado!' + #13#10 +
                          'Não será possível vender concentrado,pois a ' + #13#10 +
                          'fórmula está cadastrada somente com volume diluído!',['&Ok']);
      Result := False;
    End;
  End
  Else
  Begin //Diluido
    If dtsCadTin.FieldByName('MIX_VOLDIL').AsFloat = 0 Then
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','O Volume do diluído está zerado!' + #13#10 +
                          'Não será possível vender diluído,pois a ' + #13#10 +
                          'fórmula está cadastrada somente com volume concentrado!',['&Ok']);
      Result := False;
    End;
  End;
end;

function TFormulaAutomotivaLazzumix.fVolumeOriginalFator: Boolean;
begin
  Result := False;
end;

function TFormulaAutomotivaLazzumix.fVolumePadraoLitro(
  fltVolumePadraoLitro: Double; intModoVenda: Integer; dtsCadTin: IDataSet): Double;
begin
  Result := 0.900;

  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 0.900;
    Exit;
  End;

{$IFNDEF LINUX}
  If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZURIL' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLIEM'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZULAC' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLLA'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLPO'), 3)
  Else If (Pos('LEGACY', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0) Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLTL'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'POLIURETANO' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLPU'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUCRIL' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLCR'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'FLEET COLOR' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLFL'), 3)
  Else If Pos('ULTRA', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLUL'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR PU MS' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLSLT'), 3)
  Else If (Pos('SHERTRUCK', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0) Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLRLT'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'PERSONALIZADA' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLNLT'), 3);
{$ENDIF}
end;

function TFormulaAutomotivaLazzumix.GetAcrescimoDespesaOperacionalTinta: Double;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('DESOPE');
end;

function TFormulaAutomotivaLazzumix.GetAno(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('MIX_A_N_O_').AsString;
end;

function TFormulaAutomotivaLazzumix.GetCalcDespesasOperacionais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloatLaz(fltQtdFor * formula.VolumePro / formula.VolumeOri);

  fltVenBas := (fltQtdFor * base.PrecoVenda / base.Cnv_Ml);

  Result    := (fltVenBas * base.DespesasOperacionais / 100);
end;

function TFormulaAutomotivaLazzumix.GetCalcIcmsSaida(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloatLaz(fltQtdFor * formula.VolumePro / formula.VolumeOri);

  fltVenBas := (fltQtdFor * base.PrecoVenda / base.Cnv_Ml);

  Result := (fltVenBas * base.IcmsSaida / 100);
end;

function TFormulaAutomotivaLazzumix.GetCalcImpostosFederais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloatLaz(fltQtdFor * formula.VolumePro / formula.VolumeOri);

  fltVenBas := (fltQtdFor * base.PrecoVenda / base.Cnv_Ml);

  Result := (fltVenBas * base.ImpostosFederais / 100);
end;

function TFormulaAutomotivaLazzumix.GetCalcOutrosValores(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloatLaz(fltQtdFor * formula.VolumePro / formula.VolumeOri);

   Result := (fltQtdFor * base.OutrosValores / base.Cnv_Ml);
end;

function TFormulaAutomotivaLazzumix.GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloatLaz(fltQtdFor * formula.VolumePro / formula.VolumeOri);

  Result := (fltQtdFor * base.PrecoCompraLiquido / base.Cnv_Ml) ;
end;

function TFormulaAutomotivaLazzumix.GetCalcPrecoCusto(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloatLaz(fltQtdFor * formula.VolumePro / formula.VolumeOri);

   Result := (fltQtdFor * base.PrecoCusto / base.Cnv_Ml);
end;

function TFormulaAutomotivaLazzumix.GetCalcPrecoCustoReal(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloatLaz(fltQtdFor * formula.VolumePro / formula.VolumeOri);

   Result := (fltQtdFor * base.PrecoCustoReal / base.Cnv_Ml);
end;

function TFormulaAutomotivaLazzumix.GetCalcPrecoMedio(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloatLaz(fltQtdFor * formula.VolumePro / formula.VolumeOri);

   Result := (fltQtdFor * base.PrecoMedio / base.Cnv_Ml);
end;

function TFormulaAutomotivaLazzumix.GetCalcPrecoVenda(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltQtdFor := TFloatUtils.fFormataFloatLaz(fltQtdFor * formula.VolumePro / Formula.Volumeori);

  Result := (fltQtdFor * base.PrecoVenda / base.Cnv_Ml);

  Result := Result + ((TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('PERFRE') / 100.0) * Result);
  Result := Result + ((TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('PERIPI') / 100.0) * Result);
  Result := Result + ((TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('PERRET') / 100.0) * Result);
  Result := Result + ((TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('PERADC') / 100.0) * Result);
  Result := Result + ((TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('PERPER') / 100.0) * Result);
  Result := Result + ((TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('MARLUC') / 100.0) * Result);
end;

function TFormulaAutomotivaLazzumix.GetCalcQuantidade(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := TFloatUtils.fFormataFloatLaz(TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido)
             * formula.VolumePro / formula.VolumeOri);
end;

function TFormulaAutomotivaLazzumix.GetCalculadorInterno: ICalculadorFormulaAutomotiva;
begin
  Result := TCalculadorFormulaAutomotivaLazzumix.Create(Self);
end;

function TFormulaAutomotivaLazzumix.GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloatLaz(fltQtdFor * formula.VolumePro / formula.VolumeOri);

  Result := (fltQtdFor * base.UltimoPrecoCompra / base.Cnv_Ml) ;
end;

function TFormulaAutomotivaLazzumix.GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  fltQtdFor := TFloatUtils.fFormataFloatLaz(fltQtdFor * formula.VolumePro / formula.VolumeOri);

  Result := (fltQtdFor * base.UltimoPrecoCompraImpostos / base.Cnv_Ml);
end;

function TFormulaAutomotivaLazzumix.GetChaForEspecifico(
  const dicRetorno: IDicionario; const dtsCadTin: IDataSet): String;
begin
  Result := dicRetorno['descor'] + dicRetorno['tipemb'];
end;


function TFormulaAutomotivaLazzumix.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('MIX_CODIGO').AsString;
end;

function TFormulaAutomotivaLazzumix.GetCodFormul(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaLazzumix.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('MIX_DESCRI').AsString + ' - ' +
            dtsCadTin.FieldByName('MIX_CODIGO').AsString;
end;

function TFormulaAutomotivaLazzumix.GetDescricaoBase(strCodBas: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DESBAS FROM LAZ_CADBAS WHERE BAS_CODBAS = :CODBAS';
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

function TFormulaAutomotivaLazzumix.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaAutomotivaLazzumix.GetIdePro: String;
begin
  Result := 'LAZ';
end;

function TFormulaAutomotivaLazzumix.GetIndEmb(
  const dtsCadTin: IDataSet): integer;
begin
  Result := -1;
  If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZURIL' Then
    Result := 0
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZULAC' Then
    Result := 1
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR' Then
    Result := 2
  Else If (Pos('LEGACY', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0) Then
    Result := 3
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'POLIURETANO' Then
    Result := 4
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUCRIL' Then
    Result := 5
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'FLEET COLOR' Then
    Result := 6
  Else If Pos('ULTRA', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0 Then
    Result := 7
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR PU MS' Then
    Result := 8
  Else If (Pos('SHERTRUCK', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0) Then
    Result := 9
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'PERSONALIZADA' Then
    Result := 10;
end;

function TFormulaAutomotivaLazzumix.GetMontadora(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('MIX_MONTAD').AsString;
end;

function TFormulaAutomotivaLazzumix.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaAutomotivaLazzumix.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaAutomotivaLazzumix.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaAutomotivaLazzumix.GetNomeTabelaBases: String;
begin
  Result := 'LAZ_CADBAS';
end;

function TFormulaAutomotivaLazzumix.GetPrefixoFormulacao: String;
begin
  Result := 'MIX_BASE';
end;

function TFormulaAutomotivaLazzumix.GetPrefixoLitragem(
  const strModo: String): String;
begin
  If strModo = 'C' Then
    Result := 'MIX_VOLCON'
  Else
    Result := 'MIX_VOLDIL';
end;

function TFormulaAutomotivaLazzumix.GetPrefixoQuantidade(const strModo: String): String;
begin
  If strModo = 'C' Then
    Result := 'MIX_QTDC'
  Else
    Result := 'MIX_QTDD';
end;

function TFormulaAutomotivaLazzumix.GetProdutoVendaTinta(const dtsCadTin: IDataSet): string;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGet('PROLAZ');
end;

function TFormulaAutomotivaLazzumix.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaAutomotivaLazzumix.GetSaldos: ISaldosColorantes;
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


    if (Base.TipoBase = 'C') and not(Self.ComCatalisador) then
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

function TFormulaAutomotivaLazzumix.GetSelectBases: String;
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

function TFormulaAutomotivaLazzumix.GetSelectBasesPorEmpresa: String;
begin
  Result := ' SELECT         ' +
            '     BAS_CODBAS ' +
            '   , BAS_CODEMP ' +
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

function TFormulaAutomotivaLazzumix.GetTemDiluido: Boolean;
Var
  intIndex: Integer;
  qryBases: IDataSet;
begin
  Result := False;
  For intIndex := 0 To Count -1 Do
  Begin
    If (TBaseAutomotiva(Items[intIndex]).QuantidadeDiluido > 0) Or
       (TBaseAutomotiva(Items[intIndex]).QuantidadeDiluido2 > 0) Then
    Begin
      Result := True;
      Break;
    End;
  End;

  If Result Then
  Begin
    //Faz uma nova verificação - Se a base do diluido esta amarrada, caso contrario não é pra liberar diluido.
    //Lazzumix
    For intIndex := 0 To Count -1 Do
    Begin
      If (TBaseAutomotiva(Items[intIndex]).QuantidadeDiluido > 0) And  (TBaseAutomotiva(Items[intIndex]).QuantidadeConcentrado <= 0) Then //Base Diluida
      Begin
        qryBases := TAutcomTintaFactory.Get.fGetDataSet;
        qryBases.SQL := ' SELECT * FROM LAZ_CADBAS WHERE BAS_CODBAS = "' + TBaseAutomotiva(Items[intIndex]).CodigoBase + '" '; ;
        qryBases.Open;

        Result := (Not TStrUtils.fEmptyStr(qryBases.FieldByName('BAS_CODITE').AsString));
        Exit;
      End;
    End;
  End;
end;

function TFormulaAutomotivaLazzumix.GetTextoInformativoCalculo: String;
begin
  Result :=
  'VolumeConcentrado = ' + FloatToStrF(VolumeConcentrado, ffFixed, 12, 4) + sLineBreak +
  'VolumeDiluido = ' + FloatToStrF(VolumeDiluido, ffFixed, 12, 4) + sLineBreak +
  '' + sLineBreak +
  'VolumeFormula = SE CONCENTRADO VolumeConcentrado SENÃO VolumeDiluido' + sLineBreak +
  '' + sLineBreak +
  'Valor da Base = (Qtde * Valor / Embalagem) * (VolumeDigitado * 1000 / VolumeFormula)' + sLineBreak +
//  'Desconto Base = Valor da Base * DescontoBase (*) ' + sLineBreak +
//  'Desconto Campanha = Valor da Base * DescontoCampanha (*) ' + sLineBreak +
  '' + sLineBreak +
  'Preço da Tinta = soma do Valor da Base de todas as bases.' + sLineBreak +
//  'Preço da Tinta = Preço da Tinta - Soma(Desconto Base) - Soma(Desconto Campanha) ' + sLineBreak +
  'Preço da Tinta = Preço da Tinta + %Frete ' + sLineBreak +
  'Preço da Tinta = Preço da Tinta + %IPI ' + sLineBreak +
  'Preço da Tinta = Preço da Tinta + %Retido ' + sLineBreak +
  'Preço da Tinta = Preço da Tinta + %Adicionais ' + sLineBreak +
  'Preço da Tinta = Preço da Tinta + %Perda ' + sLineBreak +
  'Preço da Tinta = Preço da Tinta + %Lucro ' + sLineBreak +
  '' + sLineBreak;
//  '(*) Por questões de compatibilidade com outras tintas, não foram' + sLineBreak +
//  '    acrescentadas as colunas DescontoBase e DescontoCapanha.    ' + sLineBreak +
//  '    Favor olhar no cadastro de bases ';
end;

function TFormulaAutomotivaLazzumix.GetUniversal(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('MIX_UNIVER').AsString;
end;


function TFormulaAutomotivaLazzumix.GetVolumeMaximoCopo(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Copo') Then
  Begin
    Result := 0.500;
    Exit;
  End;


  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLCOP'), 3);
end;

function TFormulaAutomotivaLazzumix.GetVolumeMaximoGalao(
  dtsCadTin: IDataSet): Double;
begin
  Result := 4.000;

  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 4.000;
    Exit;
  End;


  If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZURIL' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLIGL'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZULAC' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLGLA'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLGPO'), 3)
  Else If (Pos('LEGACY', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0) Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLGLL'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'POLIURETANO' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLGPU'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUCRIL' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLGCR'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'FLEET COLOR' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLGFL'), 3)
  Else If Pos('ULTRA', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLGUL'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR PU MS' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLSGL'), 3)
  Else If (Pos('SHERTRUCK', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0) Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLRGL'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'PERSONALIZADA' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLNGL'), 3);
end;

function TFormulaAutomotivaLazzumix.GetVolumeMaximoLata(
  dtsCadTin: IDataSet): Double;
begin
  Result := 18.000;

  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;


  If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZURIL' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLILA'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZULAC' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLAZ'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLDU'), 3)
  Else If (Pos('LEGACY', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0) Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLAL'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'POLIURETANO' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLAP'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUCRIL' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLIL'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'FLEET COLOR' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLCO'), 3)
  Else If Pos('ULTRA', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLAU'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR PU MS' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLSLA'), 3)
  Else If (Pos('SHERTRUCK', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0) Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLRLA'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'PERSONALIZADA' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLNLA'), 3);
end;

function TFormulaAutomotivaLazzumix.GetVolumeMaximoLitro(
  dtsCadTin: IDataSet): Double;
begin
  Result := 1.000;

  If Not fExisteConfiguracao(dtsCadTin, 'Litro') Then
  Begin
    Result := 1.000;
    Exit;
  End;

  If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZURIL' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLIEM'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZULAC' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLLA'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLPO'), 3)
  Else If (Pos('LEGACY', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0) Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLTL'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'POLIURETANO' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLPU'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUCRIL' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLCR'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'FLEET COLOR' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLFL'), 3)
  Else If Pos('ULTRA', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLUL'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR PU MS' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLSLT'), 3)
  Else If (Pos('SHERTRUCK', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0) Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLRLT'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'PERSONALIZADA' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLNLT'), 3);
end;

function TFormulaAutomotivaLazzumix.GetVolumeMaximoSpray(
  dtsCadTin: IDataSet): Double;
begin
  If Not fExisteConfiguracao(dtsCadTin, 'Spray') Then
  Begin
    Result := 0.400;
    Exit;
  End;


  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLSPR'), 3);
end;


function TFormulaAutomotivaLazzumix.GetVolumePadraCopo: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Copo') Then
  Begin
    Result := 0.500;
    Exit;
  End;


  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLCOP'), 3);
end;

function TFormulaAutomotivaLazzumix.GetVolumePadraGalao(dtsCadTin: IDataSet): Double;
begin
  Result := 3.600;

  If Not fExisteConfiguracao(dtsCadTin, 'Galão') Then
  Begin
    Result := 3.600;
    Exit;
  End;


{$IFNDEF LINUX}
  If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZURIL' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLIGL'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZULAC' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLGLA'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLGPO'), 3)
  Else If (Pos('LEGACY', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0) Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLGLL'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'POLIURETANO' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLGPU'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUCRIL' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLGCR'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'FLEET COLOR' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLGFL'), 3)
  Else If Pos('ULTRA', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLGUL'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR PU MS' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLSGL'), 3)
  Else If (Pos('SHERTRUCK', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0) Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLRGL'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'PERSONALIZADA' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLNGL'), 3);
{$ENDIF}
end;

function TFormulaAutomotivaLazzumix.GetVolumePadraoLata(dtsCadTin: IDataSet): Double;
begin
  Result := 18.000;

  If Not fExisteConfiguracao(dtsCadTin, 'Lata') Then
  Begin
    Result := 18.000;
    Exit;
  End;

{$IFNDEF LINUX}
  If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZURIL' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLILA'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZULAC' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLAZ'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLDU'), 3)
  Else If (Pos('LEGACY', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0) Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLAL'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'POLIURETANO' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLAP'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUCRIL' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLIL'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'FLEET COLOR' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLCO'), 3)
  Else If Pos('ULTRA', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0 Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLLAU'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'LAZZUDUR PU MS' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLSLA'), 3)
  Else If (Pos('SHERTRUCK', dtsCadTin.FieldByName('MIX_REFERE').AsString) > 0) Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLRLA'), 3)
  Else If dtsCadTin.FieldByName('MIX_REFERE').AsString = 'PERSONALIZADA' Then
    Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLNLA'), 3);
{$ENDIF}
end;

function TFormulaAutomotivaLazzumix.GetVolumePadraSpray: Double;
begin
  If Not fExisteConfiguracao(Nil, 'Spray') Then
  Begin
    Result := 0.100;
    Exit;
  End;

  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetDouble('VOLSPR'), 3);
end;

function TFormulaAutomotivaLazzumix.GetVolumePadraTambor(dtsCadTin: IDataSet): Double;
begin
  Result := 0;
end;

function TFormulaAutomotivaLazzumix.GetVolumePermitido(
  const dtsCadTin: IDataSet; strTipoPre: String): Double;
begin
  If strTipoPre = 'C' Then
    Result := dtsCadTin.FieldByName('MIX_VOLMIC').AsFloat
  Else
    Result := dtsCadTin.FieldByName('MIX_VOLMID').AsFloat;
end;

procedure TFormulaAutomotivaLazzumix.pDefineVolumeOriginal;
begin
{$IFNDEF LINUX}
 If Self.mveModoVenda = mvConcentrado then
    Self.VolumeOri := Self.VolumeConcentrado
  Else
    Self.VolumeOri := Self.VolumeDiluido;
{$ELSE}
  If Self.ModVen = 'C' Then
    Self.VolumeOri := Self.VolumeConcentrado
  Else
    Self.VolumeOri := Self.VolumeDiluido;
{$ENDIF}
end;

procedure TFormulaAutomotivaLazzumix.pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet);
var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('LAZ');

  DesEmb.Add('LAZZURIL');
  DesEmb.Add('LAZZULAC');
  DesEmb.Add('LAZZUDUR');
  DesEmb.Add('LEGACY');
  DesEmb.Add('P. U.');
  DesEmb.Add('LAZZUCRIL');
  DesEmb.Add('FLEET COLOR');
  DesEmb.Add('ULTRABASE');
  DesEmb.Add('LAZZUDUR PU MS');
  DesEmb.Add('SHERTRUCKMIX');
  DesEmb.Add('PERSONALIZADA');

  ProEmbLt.Add(conf.fGet('LAZIEM'));
  ProEmbLt.Add(conf.fGet('LAZLLA'));
  ProEmbLt.Add(conf.fGet('LAZLPO'));
  ProEmbLt.Add(conf.fGet('LAZLTL'));
  ProEmbLt.Add(conf.fGet('LAZLPU'));
  ProEmbLt.Add(conf.fGet('LAZLCR'));
  ProEmbLt.Add(conf.fGet('LAZLFL'));
  ProEmbLt.Add(conf.fGet('ULTRABASELT'));
  ProEmbLt.Add(conf.fGet('PUMSLT'));
  ProEmbLt.Add(conf.fGet('SHERLT'));
  ProEmbLt.Add(Conf.fGet('LAZNLT'));

  ProEmbGl.Add(conf.fGet('LAZIGL'));
  ProEmbGl.Add(conf.fGet('LAZGLA'));
  ProEmbGl.Add(conf.fGet('LAZGPO'));
  ProEmbGl.Add(conf.fGet('LAZGLL'));
  ProEmbGl.Add(conf.fGet('LAZGPU'));
  ProEmbGl.Add(conf.fGet('LAZGCR'));
  ProEmbGl.Add(conf.fGet('LAZGFL'));
  ProEmbGl.Add(conf.fGet('ULTRABASEGL'));
  ProEmbGl.Add(conf.fGet('PUMSGL'));
  ProEmbGl.Add(conf.fGet('SHERGL'));
  ProEmbGl.Add(Conf.fGet('LAZNGL'));

  ProEmbLa.Add(conf.fGet('LAZILA'));
  ProEmbLa.Add(conf.fGet('LAZLAZ'));
  ProEmbLa.Add(conf.fGet('LAZLDU'));
  ProEmbLa.Add(conf.fGet('LAZLAL'));
  ProEmbLa.Add(conf.fGet('LAZLAP'));
  ProEmbLa.Add(conf.fGet('LAZLIL'));
  ProEmbLa.Add(conf.fGet('LAZLCO'));
  ProEmbLa.Add(conf.fGet('ULTRABASELA'));
  ProEmbLa.Add(conf.fGet('PUMSLA'));
  ProEmbLa.Add(conf.fGet('SHERLA'));
  ProEmbLa.Add(Conf.fGet('LAZNLA'));

  sProEmbCo := conf.fGet('LAZCOP');
  sProEmbSp := conf.fGet('LAZSPR');
  sProEmbTb := '';
  sProEmbLa := '';
  sProEmbBa := '';
  sProEmbSs := '';
  sProEmbPo := '';
  sProEmbSd := '';
end;

procedure TFormulaAutomotivaLazzumix.pPreencherPesCorFor(const dtsCadTin: IDataSet);
begin
  self.PesoCor := 0;
  self.PesoFor := 0;
end;

{$IFNDEF LINUX}
procedure TFormulaAutomotivaLazzumix.pRecalculaFormulaMostrarDigitado(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; fltFator: Double;
  blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha: String;
  strTipBas: String);
begin
  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    SubItems.Add(FloatToStrF(TFloatUtils.fFormataFloatLaz(Base.QuantidadeConcentrado * fltFator), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(TFloatUtils.fFormataFloatLaz(Base.QuantidadeDiluido * fltFator), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(TFloatUtils.fFormataFloatLaz(Base.QuantidadeDiluido2 * fltFator), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure TFormulaAutomotivaLazzumix.pRecalculaFormulaMostrarPadrao(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; blnConsLinhaDesBas: Boolean;
  strTipBas: String; intCont: Integer);
begin
  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    SubItems.Add(FloatToStrF(TFloatUtils.fFormataFloatLaz(Base.QuantidadeConcentrado), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(TFloatUtils.fFormataFloatLaz(Base.QuantidadeDiluido), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(TFloatUtils.fFormataFloatLaz(Base.QuantidadeDiluido2), ffFixed, 12, 3));
    SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
    SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
    SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
  End;
end;
{$ENDIF}

procedure TFormulaAutomotivaLazzumix.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('MIX_ACRMOB').AsFloat;
end;

procedure TFormulaAutomotivaLazzumix.PreencheQuantidadeFormulacaoVenda(
  const dtsCadTin: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
begin
  For intContador := 1 To Self.GetQuantidadeFormulacao Do
  Begin

    If (TStrUtils.fEmptyStr(dtsCadTin.FieldByName('MIX_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
      Break;

    Base := TBaseAutomotiva(Self.Add);
    Base.CodigoBase            := dtsCadTin.FieldByName('MIX_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString;
    Base.QuantidadeConcentrado := (dtsCadTin.FieldByName('MIX_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat);
    Base.QuantidadeDiluido     := (dtsCadTin.FieldByName('MIX_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat);
    Base.TipoBase := 'B';

    If (Base.QuantidadeConcentrado <= 0) And  (Base.QuantidadeDiluido > 0) Then
      Base.TipoBase := 'D'
  End;
end;

procedure TFormulaAutomotivaLazzumix.PreencheVolumeVenda(const dtsCadTin: IDataSet);
begin
  Self.VolumeOri         := dtsCadTin.FieldByName('MIX_VOLCON').AsFloat / 1000;
  Self.VolumeConcentrado := dtsCadTin.FieldByName('MIX_VOLCON').AsFloat / 1000;
  Self.VolumeDiluido     := dtsCadTin.FieldByName('MIX_VOLDIL').AsFloat / 1000;
end;

procedure TFormulaAutomotivaLazzumix.RecalcularTabelasGeneric(
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

      If dicRetorno['tippre'] = 'C' Then
      Begin
        If PrecoVendaCon > 0 Then
        Begin
          If TAutcomTintaFactory.Get.fGetConfTinta(GetIdePro).fGet('ACRMOB') = '1' Then
            dicRetorno['preve' + IntToStr(intContador)] := (PrecoVendaCon + EmbPrecoVenda) * (1 + AcrMob / 100)
          Else
            dicRetorno['preve' + IntToStr(intContador)] := PrecoVendaCon + EmbPrecoVenda + AcrMob;

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

end.
