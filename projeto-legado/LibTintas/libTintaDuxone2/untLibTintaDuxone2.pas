{******************************************-*********************}
{* Classe contendo as informações especificas da tinta Duxone2   *}
{*******************************************-*****************AC*}
unit untLibTintaDuxone2;

interface

uses
{$IFNDEF LINUX}
  Controls,
{$ENDIF}
  untAbstractLibTintaAutomotiva, untAbstractFormulaAutomotiva,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem, untFloatUtils, untBaseAutomotiva,
  untStrUtils, untGTinForTipos, Classes, Math, untModoVenda;

type
  TLibTintaDuxone2 = class(TAbstractLibTintaAutomotiva)
  private
    strPorcentagem: String;
    strDiluente: String;
    strCatalisador: String;
    function fRetPesoEspecificoBase(strCodBas: String): Double;
    function fPreencheTabelas(strTabelas: String): String;
    procedure ProcessarBasesFormula(Formula: TAbstractFormulaAutomotiva; qryConsulta: IDataSet);
    function fSetarModoVenda(dicRetorno: IDicionario): TModoVenda;
    function fDefineFatorAcerto(Formula: TAbstractFormulaAutomotiva; AFatorAcerto: Double): Double;
    function fUsaAcerto(AFatorAcerto: Double; AAcertoV: Boolean): String;
    procedure PreenchePrecosCustoVenda(dicRetorno: IDicionario; Formula: TAbstractFormulaAutomotiva; strTabelaUnica: String);
    Procedure PreenchePrecoCustoTabelaUnica(dicRetorno: IDicionario; Formula: TAbstractFormulaAutomotiva; strTabelaUnica: String);
    procedure PreencheOutrosPrecos(dicRetorno: IDicionario; Formula: TAbstractFormulaAutomotiva; strTabelaUnica: String);
    procedure PreenchePrecosCusto(dicRetorno: IDicionario; Formula: TAbstractFormulaAutomotiva);
    procedure PreenchePrecosCustoVenda1a7(dicRetorno: IDicionario; Formula: TAbstractFormulaAutomotiva; intContador: Integer);
    procedure PreencheOutrosPrecos1a7(dicRetorno: IDicionario; Formula: TAbstractFormulaAutomotiva; intContador: Integer);
  protected
    function GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva; override;
    function GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string; override;

    function GetVolumeOriginal(const dicRetorno: IDicionario): Double; override;
    function GetVolumeConcentrado: Double; override;
    function GetVolumeDiluido: Double; override;
    function GetVolumePro(const dicRetorno: IDicionario): Double; override;
    function GetCodFormul(const dicRetorno: IDicionario): string; override;

    procedure pProcessaFormulacaoTabelaPreco(Formula: TAbstractFormulaAutomotiva;
                                  const dicRetorno: IDicionario; const qryConsulta: IDataSet); override;
    procedure pProcessaFormulacaoGTinFor(Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet;
                                  dicBases: IDicionario; Const Formula: TAbstractFormulaAutomotiva;
                                  Const dicDados: IDicionario; Var strBases: String); override;

    function GetPrefixoTabela: String; override;

    function GetFormulArrBaixaPigmentos(dtsBases: IDataSet): String; override;
    function GetPesGraArrBaixaPigmentos(dtsBases: IDataSet): String; override;
    function GetEmbalaArrBaixaPigmentos(dtsBases: IDataSet): Double; override;
    function GetComponentePorEmpresas(const strCodEmp: String): String; override;
  public
    function GetNomeTinta: String; override;
    function GetITintadeMaquina(): ITintadeMaquinaWrapper; override;
    function RetornaReferenciaTinta(const dtsTinta: IDataSet): String; override;
    function RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double; override;
    procedure RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario); override;
    function GetMenu: IAuttinMenuItem; override;
    function GetQuantidadeOncaPulsoMl(const fltPulsos: Double; var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String = ''): String ; override;
    function GetNomeTabelaFormulacao: String; override;
    function GetCampoComponenteDesComp(): String; override;
    function fUsaChapinhaTintaGeneric(strIdePro, strIteTin: String): Boolean; Override;
    function fRetornaCodigoChapinhaGeneric(strIdePro: String): String; Override;
    procedure pTintaRetornaTabelaPrecoGeneric(dicRetorno: IDicionario; fltFatorAcerto: Double); Override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemDuxone2,
{$ENDIF}
  untFormulaAutomotivaDuxone2, untTintadeMaquinaWrapperDuxone2, untAutcomTintaFactory, untVariantUtils,
  untICalculadorFatVendasLibTintas;

{ TDuxone2TintadeMaquina }

function TLibTintaDuxone2.fDefineFatorAcerto(Formula: TAbstractFormulaAutomotiva; AFatorAcerto: Double): Double;
begin
  If (Not Formula.AcertoValor) And (AFatorAcerto = 0) Then
    Result        := 1
  Else
    Result        := AFatorAcerto;
end;

function TLibTintaDuxone2.fPreencheTabelas(strTabelas: String): String;
begin
  Result := '';

  If Length(strTabelas) < 7 Then
    Result := StringOfChar('N',7 - Length(strTabelas));
end;

function TLibTintaDuxone2.fRetornaCodigoChapinhaGeneric(
  strIdePro: String): String;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta(strIdePro).fGet('PROCHA');
end;

function TLibTintaDuxone2.fRetPesoEspecificoBase(strCodBas: String): Double;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := '   SELECT BAS_PESESP     ' +
              ' FROM DU2_CADBAS            ' +
              '   WHERE BAS_CODBAS = :CODBAS ';
    qryGen.ParamByName('CODBAS').AsString := strCodBas;
    qryGen.Open;

    Result := qryGen.FieldByName('BAS_PESESP').AsFloat;
  Except
    Raise;
  End;
end;

function TLibTintaDuxone2.fSetarModoVenda(dicRetorno: IDicionario): TModoVenda;
begin
  If dicRetorno['tippre'] = 'C' Then
    Result     := mvConcentrado
  Else
    Result     := mvDiluido;
end;

function TLibTintaDuxone2.fUsaAcerto(AFatorAcerto: Double;
  AAcertoV: Boolean): String;
begin
  If AAcertoV Then
    Result := TAutcomTintaFactory.Get.IIF(AFatorAcerto > 0, 'S', 'N')
  Else
    Result := TAutcomTintaFactory.Get.IIF(AFatorAcerto > 1, 'S', 'N');
end;

function TLibTintaDuxone2.fUsaChapinhaTintaGeneric(strIdePro,
  strIteTin: String): Boolean;
Var
  qryConsulta: IDataSet;
begin
  Result := False;

  qryConsulta := TAutcomTintaFactory.Get.fGetDataSet;
  qryConsulta.SQL := '  SELECT DU2_PROCHA FROM DU2_CADDU2 WHERE DU2_MD5KEY = :ITETIN  ';
  qryConsulta.ParamByName('ITETIN').AsString := strIteTin;
  qryConsulta.Open;

  If qryConsulta.IsEmpty Then
    Exit;

  Result := (qryConsulta.FieldByName('DU2_PROCHA').AsString = 'S');
end;

function TLibTintaDuxone2.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESBAS';
end;

function TLibTintaDuxone2.GetCodFormul(const dicRetorno: IDicionario): string;
begin
  Result := '';
end;

function TLibTintaDuxone2.GetComponentePorEmpresas(const strCodEmp: String): String;
begin
  Result := '';

  If TAutcomTintaFactory.Get.GetEmpBasDU2 Then
    Result := ' AND BAS_CODEMP = "' + strCodEmp + '" ';
end;

function TLibTintaDuxone2.GetEmbalaArrBaixaPigmentos(dtsBases: IDataSet): Double;
begin
  Result := dtsBases.FieldByName('BAS_EMBALA').AsFloat;
end;

function TLibTintaDuxone2.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaDuxone2.Create(strTabPre);
end;

function TLibTintaDuxone2.GetFormulArrBaixaPigmentos(dtsBases: IDataSet): String;
begin
  Result := dtsBases.FieldByName('BAS_CODBAS').AsString;
end;

function TLibTintaDuxone2.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperDuxone2.Create() as ITintadeMaquinaWrapper;
end;


function TLibTintaDuxone2.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemDuxone2.Create();
{$ENDIF}
end;

function TLibTintaDuxone2.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORDU2';
end;

function TLibTintaDuxone2.GetNomeTinta: String;
begin
  Result := 'Duxone Global 2';
end;

function TLibTintaDuxone2.GetPesGraArrBaixaPigmentos(dtsBases: IDataSet): String;
begin
  Result := dtsBases.FieldByName('BAS_PESGRA').AsString;
end;

function TLibTintaDuxone2.GetPrefixoTabela: String;
begin
  Result := 'DU2';
end;

function TLibTintaDuxone2.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String): String;
begin
  Result := '';
end;

function TLibTintaDuxone2.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result :=
    ' SELECT                                 ' +
    '   BAS_CODBAS                           ' +
    '   , BAS_CODITE                         ' +
    '   , BAS_PESGRA                         ' +
    '   , BAS_EMBALA                         ' +
    ' FROM                                   ' +
    '   DU2_CADBAS                           ' +
    ' WHERE BAS_CODBAS IN (' + strBases + ') ';

  If TAutcomTintaFactory.Get.GetEmpBasDU2 Then
    Result := Result + '  AND BAS_CODEMP = "' + dicDados['codempprd'] + '" ';
end;

function TLibTintaDuxone2.GetVolumeConcentrado: Double;
begin
  Result := 1;
end;

function TLibTintaDuxone2.GetVolumeDiluido: Double;
begin
  Result := 1;
end;

function TLibTintaDuxone2.GetVolumeOriginal(const dicRetorno: IDicionario): Double;
begin
  Result := 0.9;
end;

function TLibTintaDuxone2.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := dicRetorno['volpro'];
end;

procedure TLibTintaDuxone2.pProcessaFormulacaoGTinFor(
  Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet; dicBases: IDicionario;
  Const Formula: TAbstractFormulaAutomotiva; Const dicDados: IDicionario; var strBases: String);
Var
  intCont: Integer;
  fltQuantidade:Double;
begin
  strPorcentagem := dicDados['pordil'];
  strDiluente := dicDados['coddil'];
  strCatalisador := dicDados['catalize'];

  ProcessarBasesFormula(Formula, qryConsulta);



  If dicDados['tippre'] <> 'C' Then
  Begin
    Formula.pReformulaNovo(dicDados['coddil'], dicDados['pordil'], qryConsulta);
  End;

  For intCont := 0 To Formula.Count - 1 Do
  Begin
    If dicDados['tippre'] = 'C' Then
      fltQuantidade := TBaseAutomotiva(Formula.Items[intCont]).QuantidadeConcentrado * dicDados['volpro']
    Else
      fltQuantidade := TBaseAutomotiva(Formula.Items[intCont]).QuantidadeDiluido * dicDados['volpro'];

    arrFormul[intCont + 1].strFormul := TBaseAutomotiva(Formula.Items[intCont]).CodigoBase;
    arrFormul[intCont + 1].fltQtdbas := fltQuantidade;

    dicBases[arrFormul[intCont + 1].strFormul] := arrFormul[intCont + 1].fltQtdbas;
    strBases := strBases + QuotedStr(arrFormul[intCont + 1].strFormul);

    If (Not TStrUtils.fEmptyStr(arrFormul[intCont + 1].strFormul)) Then
      strBases := strBases + ', ';
  End;
end;

procedure TLibTintaDuxone2.pProcessaFormulacaoTabelaPreco(
  Formula: TAbstractFormulaAutomotiva; const dicRetorno: IDicionario; const qryConsulta: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
begin
  If Not qryConsulta.IsEmpty Then
    Formula.VolumeOri := qryConsulta.FieldByName(formula.GetPrefixoLitragem(dicRetorno['tippre'])).AsFloat / 1000;

  Formula.ComCatalisador := TAutcomTintaFactory.Get.IIF(TVariantUtils.IfNull(dicRetorno['catali'], 'N') = 'S', True, False);

  For intContador := 1 To 20 Do
  Begin
    If (TStrUtils.fEmptyStr(TVariantUtils.IfNull(dicRetorno['base' + TStrUtils.fStrZero(intContador, 2)], ''))) Then
      Break;

    Base := TBaseAutomotiva(Formula.Add);
    Base.CodigoBase := dicRetorno['base' + TStrUtils.fStrZero(intContador, 2)];

    If dicRetorno['tippre'] = 'C' Then
      Base.QuantidadeConcentrado := dicRetorno['qtdb' + TStrUtils.fStrZero(intContador, 2)] * Formula.VolumeOri / Formula.VolumePro
    Else
      Base.QuantidadeDiluido     := dicRetorno['qtdb' + TStrUtils.fStrZero(intContador, 2)] * Formula.VolumeOri / Formula.VolumePro;

    Base.TipoBase := 'B';
  End;
end;

procedure TLibTintaDuxone2.PreencheOutrosPrecos(dicRetorno: IDicionario;
  Formula: TAbstractFormulaAutomotiva; strTabelaUnica: String);
begin
  If dicRetorno['tippre'] = 'C' Then
  Begin
    dicRetorno['impult'] := Formula.UltimoPrecoCompraImpostosCon + Formula.EmbPrecoUltimaCompraImpostos;
    dicRetorno['preult'] := Formula.UltimoPrecoCompraCon + Formula.EmbPrecoUltimaCompra;
    dicRetorno['premed'] := Formula.PrecoMedioCon + Formula.EmbPrecoMedio;
    dicRetorno['prctin'] := Formula.PrecoCompraLiquidoCon + Formula.EmbPrecoCompraLiquido;

    If Formula.UsaChapinha Then
    Begin
      dicRetorno['impult'] := dicRetorno['impult'] + Formula.ChaPrecoUltimaCompraImpostos;
      dicRetorno['preult'] := dicRetorno['preult'] + Formula.ChaPrecoUltimaCompra;
      dicRetorno['premed'] := dicRetorno['premed'] + Formula.ChaPrecoMedio;
      dicRetorno['prctin'] := dicRetorno['prctin'] + Formula.ChaPrecoCompraLiquido;
    End;
  End
  Else
  Begin
    dicRetorno['impult'] := Formula.UltimoPrecoCompraImpostosDil + Formula.EmbPrecoUltimaCompraImpostos;
    dicRetorno['preult'] := Formula.UltimoPrecoCompraDil + Formula.EmbPrecoUltimaCompra;
    dicRetorno['premed'] := Formula.PrecoMedioDil + Formula.EmbPrecoMedio;
    dicRetorno['prctin'] := Formula.PrecoCompraLiquidoDil + Formula.EmbPrecoCompraLiquido;

    If Formula.UsaChapinha Then
    Begin
      dicRetorno['impult'] := dicRetorno['impult'] + Formula.ChaPrecoUltimaCompraImpostos;
      dicRetorno['preult'] := dicRetorno['preult'] + Formula.ChaPrecoUltimaCompra;
      dicRetorno['premed'] := dicRetorno['premed'] + Formula.ChaPrecoMedio;
      dicRetorno['prctin'] := dicRetorno['prctin'] + Formula.ChaPrecoCompraLiquido;
    End;
  end;

  If Formula.AcertoValor Then
  Begin
    dicRetorno['precus'] := dicRetorno['precus'] + Formula.FatorAcerto;
    dicRetorno['preve' + strTabelaUnica] := dicRetorno['preve' + strTabelaUnica] + Formula.FatorAcerto;
    dicRetorno['precu2'] := dicRetorno['precu2'] + Formula.FatorAcerto;
    dicRetorno['impult'] := dicRetorno['impult'] + Formula.FatorAcerto;
    dicRetorno['preult'] := dicRetorno['preult'] + Formula.FatorAcerto;
    dicRetorno['premed'] := dicRetorno['premed'] + Formula.FatorAcerto;
    dicRetorno['prctin'] := dicRetorno['prctin'] + Formula.FatorAcerto;
  End
  Else
  Begin
    dicRetorno['precus'] := dicRetorno['precus'] * Formula.FatorAcerto;
    dicRetorno['preve' + strTabelaUnica] := dicRetorno['preve' + strTabelaUnica] * Formula.FatorAcerto;
    dicRetorno['precu2'] := dicRetorno['precu2'] * Formula.FatorAcerto;
    dicRetorno['impult'] := dicRetorno['impult'] * Formula.FatorAcerto;
    dicRetorno['preult'] := dicRetorno['preult'] * Formula.FatorAcerto;
    dicRetorno['premed'] := dicRetorno['premed'] * Formula.FatorAcerto;
    dicRetorno['prctin'] := dicRetorno['prctin'] * Formula.FatorAcerto;
  End;
end;

procedure TLibTintaDuxone2.PreencheOutrosPrecos1a7(dicRetorno: IDicionario;
  Formula: TAbstractFormulaAutomotiva; intContador: Integer);
begin
  If intContador = TVariantUtils.IfNull(dicRetorno['tabpre'], 0) Then
  Begin
    Formula.pCalculaImpostosSaida(dicRetorno);
    dicRetorno.AdicionarObjeto('tintaDeMaquina', Formula.tintaDeMaquina[Formula.mveModoVenda]);
    dicRetorno['promoc'] := Formula.Promoc;

    If dicRetorno['tippre'] = 'C' Then
    Begin
      If Formula.UsaChapinha Then
      Begin
        dicRetorno['impult'] := Formula.ChaPrecoUltimaCompraImpostos;
        dicRetorno['preult'] := Formula.ChaPrecoUltimaCompra;
        dicRetorno['premed'] := Formula.ChaPrecoMedio;
        dicRetorno['prctin'] := Formula.ChaPrecoCompraLiquido;
      End;

      If Formula.AcertoValor Then
      Begin
        dicRetorno['impult'] := TVariantUtils.IfNull(dicRetorno['impult'], 0) + (Formula.UltimoPrecoCompraImpostosCon + Formula.EmbPrecoUltimaCompraImpostos + Formula.FatorAcerto);
        dicRetorno['preult'] := TVariantUtils.IfNull(dicRetorno['preult'], 0) + (Formula.UltimoPrecoCompraCon + Formula.EmbPrecoUltimaCompra + Formula.FatorAcerto);
        dicRetorno['premed'] := TVariantUtils.IfNull(dicRetorno['premed'], 0) + (Formula.PrecoMedioCon + Formula.EmbPrecoMedio + Formula.FatorAcerto);
        dicRetorno['prctin'] := TVariantUtils.IfNull(dicRetorno['prctin'], 0) + (Formula.PrecoCompraLiquidoCon + Formula.EmbPrecoCompraLiquido + Formula.FatorAcerto);
      End
      Else
      Begin
        dicRetorno['impult'] := (TVariantUtils.IfNull(dicRetorno['impult'], 0) + Formula.UltimoPrecoCompraImpostosCon + Formula.EmbPrecoUltimaCompraImpostos) * Formula.FatorAcerto;
        dicRetorno['preult'] := (TVariantUtils.IfNull(dicRetorno['preult'], 0) + Formula.UltimoPrecoCompraCon + Formula.EmbPrecoUltimaCompra) * Formula.FatorAcerto;
        dicRetorno['premed'] := (TVariantUtils.IfNull(dicRetorno['premed'], 0) + Formula.PrecoMedioCon + Formula.EmbPrecoMedio) * Formula.FatorAcerto;
        dicRetorno['prctin'] := (TVariantUtils.IfNull(dicRetorno['prctin'], 0) + Formula.PrecoCompraLiquidoCon + Formula.EmbPrecoCompraLiquido) * Formula.FatorAcerto;
      End;
    End
    Else
    Begin
      If Formula.UsaChapinha Then
      Begin
        dicRetorno['impult'] := Formula.ChaPrecoUltimaCompraImpostos;
        dicRetorno['preult'] := Formula.ChaPrecoUltimaCompra;
        dicRetorno['premed'] := Formula.ChaPrecoMedio;
        dicRetorno['prctin'] := Formula.ChaPrecoCompraLiquido;
      End;

      If Formula.AcertoValor Then
      Begin
        dicRetorno['impult'] := TVariantUtils.IfNull(dicRetorno['impult'], 0) + (Formula.UltimoPrecoCompraImpostosDil + Formula.EmbPrecoUltimaCompraImpostos + Formula.FatorAcerto);
        dicRetorno['preult'] := TVariantUtils.IfNull(dicRetorno['preult'], 0) + (Formula.UltimoPrecoCompraDil + Formula.EmbPrecoUltimaCompra + Formula.FatorAcerto);
        dicRetorno['premed'] := TVariantUtils.IfNull(dicRetorno['premed'], 0) + (Formula.PrecoMedioDil + Formula.EmbPrecoMedio + Formula.FatorAcerto);
        dicRetorno['prctin'] := TVariantUtils.IfNull(dicRetorno['prctin'], 0) + (Formula.PrecoCompraLiquidoDil + Formula.EmbPrecoCompraLiquido + Formula.FatorAcerto);
      End
      Else
      Begin
        dicRetorno['impult'] := (TVariantUtils.IfNull(dicRetorno['impult'], 0) + Formula.UltimoPrecoCompraImpostosDil + Formula.EmbPrecoUltimaCompraImpostos) * Formula.FatorAcerto;
        dicRetorno['preult'] := (TVariantUtils.IfNull(dicRetorno['preult'], 0) + Formula.UltimoPrecoCompraDil + Formula.EmbPrecoUltimaCompra) * Formula.FatorAcerto;
        dicRetorno['premed'] := (TVariantUtils.IfNull(dicRetorno['premed'], 0) + Formula.PrecoMedioDil + Formula.EmbPrecoMedio) * Formula.FatorAcerto;
        dicRetorno['prctin'] := (TVariantUtils.IfNull(dicRetorno['prctin'], 0) + Formula.PrecoCompraLiquidoDil + Formula.EmbPrecoCompraLiquido) * Formula.FatorAcerto;
      End;
    End;
  End;
end;

procedure TLibTintaDuxone2.PreenchePrecoCustoTabelaUnica(
  dicRetorno: IDicionario; Formula: TAbstractFormulaAutomotiva;
  strTabelaUnica: String);
begin
  If TVariantUtils.IfNull(dicRetorno['precus'], 0) <= 0 Then
  Begin
    If dicRetorno['tippre'] = 'C' Then
      dicRetorno['precus'] := Formula.PrecoCustoCon + Formula.EmbPrecoCusto
    Else
      dicRetorno['precus'] := Formula.PrecoCustoDil + Formula.EmbPrecoCusto;

    If Formula.UsaChapinha Then
      dicRetorno['precus'] := dicRetorno['precus'] + Formula.ChaPrecoCusto;
  End;
end;

procedure TLibTintaDuxone2.PreenchePrecosCusto(dicRetorno: IDicionario;
  Formula: TAbstractFormulaAutomotiva);
begin
  If TVariantUtils.IfNull(dicRetorno['precus'], 0) <= 0 Then
  Begin
    If dicRetorno['tippre'] = 'C' Then
    Begin
      If Formula.UsaChapinha Then
        dicRetorno['precus'] := Formula.ChaPrecoCusto;

      If Formula.AcertoValor Then
        dicRetorno['precus'] := TVariantUtils.IfNull(dicRetorno['precus'], 0) + (Formula.PrecoCustoCon + Formula.EmbPrecoCusto + Formula.FatorAcerto)
      Else
        dicRetorno['precus'] := (TVariantUtils.IfNull(dicRetorno['precus'], 0) + Formula.PrecoCustoCon + Formula.EmbPrecoCusto) * Formula.FatorAcerto;
    End
    Else
    Begin
      If Formula.UsaChapinha Then
        dicRetorno['precus'] := Formula.ChaPrecoCusto;

      If Formula.AcertoValor Then
        dicRetorno['precus'] := TVariantUtils.IfNull(dicRetorno['precus'], 0) + (Formula.PrecoCustoDil + Formula.EmbPrecoCusto + Formula.FatorAcerto)
      Else
        dicRetorno['precus'] := (TVariantUtils.IfNull(dicRetorno['precus'], 0) + Formula.PrecoCustoDil + Formula.EmbPrecoCusto) * Formula.FatorAcerto;
    End;
  End;
end;

procedure TLibTintaDuxone2.PreenchePrecosCustoVenda(dicRetorno: IDicionario;
  Formula: TAbstractFormulaAutomotiva; strTabelaUnica: String);
begin
  PreenchePrecoCustoTabelaUnica(dicRetorno, Formula, strTabelaUnica);

  If dicRetorno['tippre'] = 'C' Then
  Begin
    dicRetorno['precu2'] := Formula.PrecoCustoRealCon + Formula.EmbPrecoCustoReal;

    If TAutcomTintaFactory.Get.fGetConfTinta(Self.GetIdePro).fGet('ACRMOB') = '1' Then
      dicRetorno['preve' + strTabelaUnica] := (Formula.PrecoVendaCon + Formula.EmbPrecoVenda) * (1 + Formula.AcrMob / 100)
    Else
      dicRetorno['preve' + strTabelaUnica] := (Formula.PrecoVendaCon + Formula.EmbPrecoVenda) + Formula.AcrMob;

    If Formula.UsaChapinha Then
    Begin
      dicRetorno['precu2'] := dicRetorno['precu2'] + Formula.ChaPrecoCustoReal;
      dicRetorno['preve' + strTabelaUnica] := dicRetorno['preve' + strTabelaUnica] + Formula.ChaPrecoVenda;
    End;

    dicRetorno['preve' + strTabelaUnica + '_original'] := dicRetorno['preve' + strTabelaUnica];
  End
  Else
  Begin
    dicRetorno['precu2'] := Formula.PrecoCustoRealDil + Formula.EmbPrecoCustoReal;

    If TAutcomTintaFactory.Get.fGetConfTinta(Self.GetIdePro).fGet('ACRMOB') = '1' Then
      dicRetorno['preve' + strTabelaUnica] := (Formula.PrecoVendaDil + Formula.EmbPrecoVenda) * (1 + Formula.AcrMob / 100)
    Else
      dicRetorno['preve' + strTabelaUnica] := Formula.PrecoVendaDil + Formula.EmbPrecoVenda + Formula.AcrMob;

    If Formula.UsaChapinha Then
    Begin
      dicRetorno['precu2'] := dicRetorno['precu2'] + Formula.ChaPrecoCustoReal;
      dicRetorno['preve' + strTabelaUnica] := dicRetorno['preve' + strTabelaUnica] + Formula.ChaPrecoVenda;
    End;

    dicRetorno['preve' + strTabelaUnica + '_original'] := dicRetorno['preve' + strTabelaUnica];
  End;
end;

procedure TLibTintaDuxone2.PreenchePrecosCustoVenda1a7(dicRetorno: IDicionario;
  Formula: TAbstractFormulaAutomotiva; intContador: Integer);
begin
  PreenchePrecosCusto(dicRetorno, Formula);

  If Formula.UsaChapinha Then
  Begin
    dicRetorno['precu2'] := Formula.ChaPrecoCustoReal;
    dicRetorno['preve' + IntToStr(intContador)] := Formula.ChaPrecoVenda;
  End;

  If dicRetorno['tippre'] = 'C' Then
  Begin
     If Formula.AcertoValor Then
      dicRetorno['precu2'] := TVariantUtils.IfNull(dicRetorno['precu2'], 0) + (Formula.PrecoCustoRealCon + Formula.EmbPrecoCustoReal + Formula.FatorAcerto)
    Else
      dicRetorno['precu2'] := (TVariantUtils.IfNull(dicRetorno['precu2'], 0) + Formula.PrecoCustoRealCon + Formula.EmbPrecoCustoReal) * Formula.FatorAcerto;

    If TAutcomTintaFactory.Get.fGetConfTinta(Self.GetIdePro).fGet('ACRMOB') = '1' Then
      dicRetorno['preve' + IntToStr(intContador)] := (TVariantUtils.IfNull(dicRetorno['preve' + IntToStr(intContador)], 0) + Formula.PrecoVendaCon + Formula.EmbPrecoVenda) * (1 + Formula.AcrMob / 100)
    Else
      dicRetorno['preve' + IntToStr(intContador)] := TVariantUtils.IfNull(dicRetorno['preve' + IntToStr(intContador)], 0) + (Formula.PrecoVendaCon + Formula.EmbPrecoVenda + Formula.AcrMob);

    dicRetorno['preve' + IntToStr(intContador) + '_original'] := dicRetorno['preve' + IntToStr(intContador)];
  End
  Else
  Begin
    If Formula.AcertoValor Then
      dicRetorno['precu2'] := TVariantUtils.IfNull(dicRetorno['precu2'], 0) + (Formula.PrecoCustoRealDil + Formula.EmbPrecoCustoReal + Formula.FatorAcerto)
    Else
      dicRetorno['precu2'] := (TVariantUtils.IfNull(dicRetorno['precu2'], 0) + Formula.PrecoCustoRealDil + Formula.EmbPrecoCustoReal) * Formula.FatorAcerto;

    If TAutcomTintaFactory.Get.fGetConfTinta(Self.GetIdePro).fGet('ACRMOB') = '1' Then
      dicRetorno['preve' + IntToStr(intContador)] := (TVariantUtils.IfNull(dicRetorno['preve' + IntToStr(intContador)], 0) + Formula.PrecoVendaDil + Formula.EmbPrecoVenda) * (1 + Formula.AcrMob / 100)
    Else
      dicRetorno['preve' + IntToStr(intContador)] := TVariantUtils.IfNull(dicRetorno['preve' + IntToStr(intContador)], 0) + (Formula.PrecoVendaDil + Formula.EmbPrecoVenda + Formula.AcrMob);

    dicRetorno['preve' + IntToStr(intContador) + '_original'] := dicRetorno['preve' + IntToStr(intContador)];
  End;
end;

procedure TLibTintaDuxone2.ProcessarBasesFormula(
  Formula: TAbstractFormulaAutomotiva; qryConsulta: IDataSet);
Var
  intCont: Integer;
  objBase: TBaseAutomotiva;
begin
  For intCont := 1 To formula.GetQuantidadeFormulacao Do
  Begin
    If qryConsulta.FieldByName(formula.GetPrefixoQuantidade('') + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 Then
      Break;

    objBase := TBaseAutomotiva(Formula.Add);
    objBase.CodigoBase            := qryConsulta.FieldByName('DU2_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString;
    objBase.QuantidadeConcentrado := qryConsulta.FieldByName('DU2_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
    objBase.TipoBase              := 'B';
    objBase.PesoEspecifico := fRetPesoEspecificoBase(objBase.CodigoBase);
  End;
end;


procedure TLibTintaDuxone2.pTintaRetornaTabelaPrecoGeneric(
  dicRetorno: IDicionario; fltFatorAcerto: Double);
var
  strTabelas: String;
  Formula: TAbstractFormulaAutomotiva;
  intContador: Integer;
  strTabelaUnica: String;
  strTabelaAtual: String;
  calculadorFatVendas: ICalculadorFatVendasLibTintas;
  qryConsulta: IDataSet;
  strCodEmp: String;
begin
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendasLibTintas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      Formula := GetFormulaAutomotiva(TVariantUtils.IfNull(dicRetorno['tabpre'], '1'));
      formula.calculadorFatVendas := calculadorFatVendas;
      Formula.BlnCalculaUnitario := False;
      Formula.VolumeOri          := GetVolumeOriginal(dicRetorno);
      Formula.VolumeConcentrado  := GetVolumeConcentrado;
      Formula.VolumeDiluido      := GetVolumeDiluido;
      Formula.VolumePro          := GetVolumePro(dicRetorno);
      Formula.mveModoVenda       := fSetarModoVenda(dicRetorno);
      Formula.FatorAcerto        := fDefineFatorAcerto(Formula, fltFatorAcerto);

      Formula.OpcDoc := TVariantUtils.IfNull(dicRetorno['opcdoc'], '');
      Formula.CodCli := TVariantUtils.IfNull(dicRetorno['codcli'], '');
      Formula.CodCnd := TVariantUtils.IfNull(dicRetorno['codcnd'], '');
      Formula.PrzMed := TVariantUtils.IfNull(dicRetorno['przmed'], 0);
      formula.OprFlj := TVariantUtils.IfNull(dicRetorno['oprflj'], '');
      formula.EmpresaProducao := TVariantUtils.IfNull(dicRetorno['empprd'], '');
      Formula.EmpCd_ := TVariantUtils.IfNull(dicRetorno['emp_cd'], '');
      Formula.CD_S_N := TVariantUtils.IfNull(dicRetorno['Cd_S_N'], '');
      Formula.EmpFat := TVariantUtils.IfNull(dicRetorno['empfat'], '');
      Formula.FatS_N := TVariantUtils.IfNull(dicRetorno['FatS_N'], '');

      strCodEmp := TAutcomTintaFactory.Get.GetCodEmp;
      TAutcomTintaFactory.Get.pSetaEmpresaLogadaTinta(Formula.fVerificaEmpresaSetada);

      dicRetorno['acerto'] := fUsaAcerto(Formula.FatorAcerto, Formula.AcertoValor);

      If fRetornaFormulacaoParaTabelaPreco(dicRetorno, qryConsulta) Then
        Formula.AcrMob := qryConsulta.FieldByName(GetPrefixoTabela + '_ACRMOB').AsFloat
      Else
        dicRetorno['formula_nao_encontrada'] := 'S';

      Formula.CodEmb := dicRetorno['iteemb'];
      Formula.UsaChapinha := Formula.GetUsaChapinha(qryConsulta);
      Formula.ProCha := TAutcomTintaFactory.Get.fGetConfTinta('DU2').fGet('PROCHA');
      PreencherPesCorFor(Formula, qryConsulta);
      pProcessaFormulacaoTabelaPreco(Formula, dicRetorno, qryConsulta);
      Formula.CodFormul := Formula.GetCodFormul(qryConsulta);
      dicRetorno['desopetinta'] := TAutcomTintaFactory.Get.fGetConfTinta(GetIdePro).fGetDouble('DESOPE');
      strTabelaUnica := TVariantUtils.IfNull(dicRetorno['tabelaunica'], '');

      If (not TStrUtils.fEmptyStr(strTabelaUnica)) Then
      Begin
        Formula.TabPre := strTabelaUnica;

        Formula.CarregarBases(dicRetorno);
        Formula.CarregarBasesPorEmpresa(dicRetorno);

        Formula.CarregaPrecosBases;
        Formula.CarregaPrecosBasesPorEmpresa;

        Formula.CalcularPrecos;

        {Carrega preço da embalagem conforme tabela de preço!}
        Formula.pCarregaPrecoPromocaoEmbalagem(strTabelaUnica, TVariantUtils.IfNull(dicRetorno['opcdoc'], ''));
        Formula.pCarregaPrecoChapinha(Formula.TabPre, TVariantUtils.IfNull(dicRetorno['opcdoc'], ''));
        PreenchePrecosCustoVenda(dicRetorno, Formula, strTabelaUnica);

        Formula.pCalculaImpostosSaida(dicRetorno);
        dicRetorno.AdicionarObjeto('tintaDeMaquina', Formula.tintaDeMaquina[Formula.mveModoVenda]);
        dicRetorno['promoc'] := Formula.Promoc;
        PreencheOutrosPrecos(dicRetorno, Formula, strTabelaUnica);
      End
      Else
      Begin
        strTabelas := TAutcomTintaFactory.Get.fCfgSis('TABPRC');
        strTabelas := strTabelas + fPreencheTabelas(strTabelas);

        strTabelaAtual := Formula.TabPre;
        For intContador := 1 To Length(strTabelas) Do
        Begin
          If strTabelas[intContador] = 'S' Then
          Begin
            Formula.TabPre := IntToStr(intContador);

            Formula.CarregarBases(dicRetorno);
            Formula.CarregarBasesPorEmpresa(dicRetorno);

            Formula.CarregaPrecosBases;
            Formula.CarregaPrecosBasesPorEmpresa;

            Formula.CalcularPrecos;

            {Carrega preço da embalagem conforme tabela de preço!}
            Formula.pCarregaPrecoPromocaoEmbalagem(Formula.TabPre, TVariantUtils.IfNull(dicRetorno['opcdoc'], ''));
            Formula.pCarregaPrecoChapinha(Formula.TabPre, TVariantUtils.IfNull(dicRetorno['opcdoc'], ''));
            PreenchePrecosCustoVenda1a7(dicRetorno, Formula, intContador);
            PreencheOutrosPrecos1a7(dicRetorno, Formula, intContador);

            If Formula.AcertoValor Then
              dicRetorno['preve' + IntToStr(intContador)] := dicRetorno['preve' + IntToStr(intContador)] + Formula.FatorAcerto
            Else
              dicRetorno['preve' + IntToStr(intContador)] := dicRetorno['preve' + IntToStr(intContador)] * Formula.FatorAcerto;
          End;
        End;
        Formula.TabPre := strTabelaAtual;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    TAutcomTintaFactory.Get.pSetaEmpresaLogadaTinta(strCodEmp);
  End;
end;

procedure TLibTintaDuxone2.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL := 'SELECT *           ' +
                    '  FROM DU2_CADDU2  ' +
                    ' WHERE DU2_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('DU2_CODDU2').AsString;
      dicRetorno['montad'] := qryGen.FieldByName('DU2_MONTAD').AsString;
      dicRetorno['martin'] := qryGen.FieldByName('DU2_LINHA_').AsString;
      dicRetorno['a_n_o_'] := qryGen.FieldByName('DU2_ANOCOR').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TLibTintaDuxone2.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaDuxone2.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
  Var
    strTraDuxone2: String;
    fltTraDuxone2: Double;
    conf: IConfTinta;
Begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('DU2');

  strTraDuxone2 := conf.fGet('TRADU2');
  fltTraDuxone2 := conf.fGetDouble('FATDU2');

  If (strTraDuxone2 = 'VEN') Then
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0);

  Result := TFloatUtils.fFormataFloat(Result * fltTraDuxone2, 2);
end;

end.
