{******************************************-*********************}
{* Classe contendo as informações especificas da tinta Autoluks *}
{*******************************************-*****************AC*}
unit untLibTintaAutoluks;

interface

uses
{$IFNDEF LINUX}
  Controls,
{$ENDIF}
  untAbstractLibTintaAutomotiva, untAbstractFormulaAutomotiva,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem, untFloatUtils, untBaseAutomotiva,
  untStrUtils, untGTinForTipos, Classes, untICalculadorFatVendasLibTintas, untModoVenda;

type
  TLibTintaAutoluks = class(TAbstractLibTintaAutomotiva)
  private
    fltVolumeOri: Double;
    function fTipoVenda(dicRetorno: IDicionario): ShortInt;
    procedure PreenchePrecosCustoVenda(dicRetorno: IDicionario; Formula: TAbstractFormulaAutomotiva; strTabelaUnica: String);
    procedure PreencheOutrosPrecos(dicRetorno: IDicionario; Formula: TAbstractFormulaAutomotiva; strTabelaUnica: String);
    function fPreencheTabelas(strTabelas: String): String;
    procedure PreenchePrecosCusto(dicRetorno: IDicionario; Formula: TAbstractFormulaAutomotiva);
    procedure PreenchePrecosCustoVenda1a7(dicRetorno: IDicionario; Formula: TAbstractFormulaAutomotiva; intContador: Integer);
    procedure PreencheOutrosPrecos1a7(dicRetorno: IDicionario; Formula: TAbstractFormulaAutomotiva; intContador: Integer);
    function fRetPesoEspecificoBase(strCodBas: String): Double;
    procedure ProcessarBasesFormula(Formula: TAbstractFormulaAutomotiva; qryConsulta: IDataSet);



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
//    procedure PreencherPesCorFor(Formula: TAbstractFormulaAutomotiva; qryConsulta: IDataSet); override;
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
    procedure pTintaRetornaTabelaPrecoGeneric(dicRetorno: IDicionario; fltFatorAcerto: Double); Override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemAutoluks,
{$ENDIF}
  untFormulaAutomotivaAutoluks, untTintadeMaquinaWrapperAutoluks, untAutcomTintaFactory, untVariantUtils;

{ TAutoluksTintadeMaquina }

function TLibTintaAutoluks.fPreencheTabelas(strTabelas: String): String;
begin
  Result := '';

  If Length(strTabelas) < 7 Then
    Result := StringOfChar('N',7 - Length(strTabelas));
end;

function TLibTintaAutoluks.fRetPesoEspecificoBase(strCodBas: String): Double;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := '   SELECT BAS_PESESP     ' +
              ' FROM ALK_CADBAS            ' +
              '   WHERE BAS_CODBAS = :CODBAS ';
    qryGen.ParamByName('CODBAS').AsString := strCodBas;
    qryGen.Open;

    Result := qryGen.FieldByName('BAS_PESESP').AsFloat;
  Except
    Raise;
  End;
end;

function TLibTintaAutoluks.fTipoVenda(dicRetorno: IDicionario): ShortInt;
begin
  If dicRetorno['tippre'] = 'C' Then
    Result := mvConcentrado
  Else
    Result := mvDiluido;
end;

function TLibTintaAutoluks.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESCRI';
end;

function TLibTintaAutoluks.GetCodFormul(const dicRetorno: IDicionario): string;
begin
  Result := TVariantUtils.IfNull(dicRetorno['codtin'],'') ;
end;

function TLibTintaAutoluks.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaAutoluks.Create(strTabPre);
end;

function TLibTintaAutoluks.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperAutoluks.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaAutoluks.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemAutoluks.Create();
{$ENDIF}
end;

function TLibTintaAutoluks.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORALK';
end;

function TLibTintaAutoluks.GetNomeTinta: String;
begin
  Result := 'Autoluks';
end;

function TLibTintaAutoluks.GetPrefixoTabela: String;
begin
  Result := 'ALK';
end;

function TLibTintaAutoluks.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String): String;
begin
  Result := '';
end;

function TLibTintaAutoluks.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   BAS_CODBAS                                ' +
    '   , BAS_CODITE                              ' +
    ' FROM                                        ' +
    '   ALK_CADBAS                                ' +
    ' WHERE BAS_CODBAS IN (' + strBases + ') ';
end;

function TLibTintaAutoluks.GetVolumeConcentrado: Double;
begin
  Result := fltVolumeOri;
end;

function TLibTintaAutoluks.GetVolumeDiluido: Double;
begin
  Result := fltVolumeOri;
end;

function TLibTintaAutoluks.GetVolumeOriginal(
  const dicRetorno: IDicionario): Double;
begin
  Result := fltVolumeOri;

end;

function TLibTintaAutoluks.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := dicRetorno['volpro'];
end;

procedure TLibTintaAutoluks.pProcessaFormulacaoGTinFor(
  Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet; dicBases: IDicionario;
  Const Formula: TAbstractFormulaAutomotiva; Const dicDados: IDicionario; var strBases: String);
Var
  intCont: Integer;
  fltQuantidade:Double;
begin
  ProcessarBasesFormula(Formula, qryConsulta);

  If dicDados['tippre'] <> 'C' Then
    Formula.pReformulaNovo('ATL000', dicDados['pordil'], qryConsulta);

  For intCont := 0 To Formula.Count - 1 Do
  Begin
    If dicDados['tippre'] = 'C' Then
      fltQuantidade := TAutcomTintaFactory.Get.fFormataFloat(TBaseAutomotiva(Formula.Items[intCont]).QuantidadeConcentrado * dicDados['volpro'], 1)
    Else
      fltQuantidade := TAutcomTintaFactory.Get.fFormataFloat(TBaseAutomotiva(Formula.Items[intCont]).QuantidadeDiluido * dicDados['volpro'], 1);

    arrFormul[intCont + 1].strFormul := TBaseAutomotiva(Formula.Items[intCont]).CodigoBase;
    arrFormul[intCont + 1].fltQtdbas := fltQuantidade;

    dicBases[arrFormul[intCont + 1].strFormul] := arrFormul[intCont + 1].fltQtdbas;
    strBases := strBases + QuotedStr(arrFormul[intCont + 1].strFormul);

    If (Not TStrUtils.fEmptyStr(arrFormul[intCont + 1].strFormul)) Then
      strBases := strBases + ', ';
  End;
end;

procedure TLibTintaAutoluks.pProcessaFormulacaoTabelaPreco(
  Formula: TAbstractFormulaAutomotiva; const dicRetorno: IDicionario; const qryConsulta: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
begin
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

procedure TLibTintaAutoluks.PreencheOutrosPrecos(dicRetorno: IDicionario; Formula: TAbstractFormulaAutomotiva; strTabelaUnica: String);
begin
  If dicRetorno['tippre'] = 'C' Then
  Begin
    dicRetorno['impult'] := Formula.UltimoPrecoCompraImpostosCon + Formula.EmbPrecoUltimaCompraImpostos;
    dicRetorno['preult'] := Formula.UltimoPrecoCompraCon + Formula.EmbPrecoUltimaCompra;
    dicRetorno['premed'] := Formula.PrecoMedioCon + Formula.EmbPrecoMedio;
    dicRetorno['prctin'] := Formula.PrecoCompraLiquidoCon + Formula.EmbPrecoCompraLiquido;
  End
  Else
  Begin
    dicRetorno['impult'] := Formula.UltimoPrecoCompraImpostosDil + Formula.EmbPrecoUltimaCompraImpostos;
    dicRetorno['preult'] := Formula.UltimoPrecoCompraDil + Formula.EmbPrecoUltimaCompra;
    dicRetorno['premed'] := Formula.PrecoMedioDil + Formula.EmbPrecoMedio;
    dicRetorno['prctin'] := Formula.PrecoCompraLiquidoDil + Formula.EmbPrecoCompraLiquido;
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

procedure TLibTintaAutoluks.PreencheOutrosPrecos1a7(dicRetorno: IDicionario;
  Formula: TAbstractFormulaAutomotiva; intContador: Integer);
begin
  If intContador = TVariantUtils.IfNull(dicRetorno['tabpre'], 0) Then
  Begin
    Formula.pCalculaImpostosSaida(dicRetorno);
    dicRetorno.AdicionarObjeto('tintaDeMaquina', Formula.tintaDeMaquina[Formula.mveModoVenda]);
    dicRetorno['promoc'] := Formula.Promoc;

    If dicRetorno['tippre'] = 'C' Then
    Begin
      If Formula.AcertoValor Then
      Begin
        dicRetorno['impult'] := Formula.UltimoPrecoCompraImpostosCon + Formula.EmbPrecoUltimaCompraImpostos + Formula.FatorAcerto;
        dicRetorno['preult'] := Formula.UltimoPrecoCompraCon + Formula.EmbPrecoUltimaCompra + Formula.FatorAcerto;
        dicRetorno['premed'] := Formula.PrecoMedioCon + Formula.EmbPrecoMedio + Formula.FatorAcerto;
        dicRetorno['prctin'] := Formula.PrecoCompraLiquidoCon + Formula.EmbPrecoCompraLiquido + Formula.FatorAcerto;
      End
      Else
      Begin
        dicRetorno['impult'] := (Formula.UltimoPrecoCompraImpostosCon + Formula.EmbPrecoUltimaCompraImpostos) * Formula.FatorAcerto;
        dicRetorno['preult'] := (Formula.UltimoPrecoCompraCon + Formula.EmbPrecoUltimaCompra) * Formula.FatorAcerto;
        dicRetorno['premed'] := (Formula.PrecoMedioCon + Formula.EmbPrecoMedio) * Formula.FatorAcerto;
        dicRetorno['prctin'] := (Formula.PrecoCompraLiquidoCon + Formula.EmbPrecoCompraLiquido) * Formula.FatorAcerto;
      End;
    End
    Else
    Begin
      If Formula.AcertoValor Then
      Begin
        dicRetorno['impult'] := Formula.UltimoPrecoCompraImpostosDil + Formula.EmbPrecoUltimaCompraImpostos + Formula.FatorAcerto;
        dicRetorno['preult'] := Formula.UltimoPrecoCompraDil + Formula.EmbPrecoUltimaCompra + Formula.FatorAcerto;
        dicRetorno['premed'] := Formula.PrecoMedioDil + Formula.EmbPrecoMedio + Formula.FatorAcerto;
        dicRetorno['prctin'] := Formula.PrecoCompraLiquidoDil + Formula.EmbPrecoCompraLiquido + Formula.FatorAcerto;
      End
      Else
      Begin
        dicRetorno['impult'] := (Formula.UltimoPrecoCompraImpostosDil + Formula.EmbPrecoUltimaCompraImpostos) * Formula.FatorAcerto;
        dicRetorno['preult'] := (Formula.UltimoPrecoCompraDil + Formula.EmbPrecoUltimaCompra) * Formula.FatorAcerto;
        dicRetorno['premed'] := (Formula.PrecoMedioDil + Formula.EmbPrecoMedio) * Formula.FatorAcerto;
        dicRetorno['prctin'] := (Formula.PrecoCompraLiquidoDil + Formula.EmbPrecoCompraLiquido) * Formula.FatorAcerto;
      End;
    End;
  End;
end;

procedure TLibTintaAutoluks.PreenchePrecosCusto(dicRetorno: IDicionario;
  Formula: TAbstractFormulaAutomotiva);
begin
  If TVariantUtils.IfNull(dicRetorno['precus'], 0) <= 0 Then
  Begin
    If dicRetorno['tippre'] = 'C' Then
    Begin
      If Formula.AcertoValor Then
        dicRetorno['precus'] := Formula.PrecoCustoCon + Formula.EmbPrecoCusto + Formula.FatorAcerto
      Else
        dicRetorno['precus'] := (Formula.PrecoCustoCon + Formula.EmbPrecoCusto) * Formula.FatorAcerto;
    End
    Else
    Begin
      If Formula.AcertoValor Then
        dicRetorno['precus'] := Formula.PrecoCustoDil + Formula.EmbPrecoCusto + Formula.FatorAcerto
      Else
        dicRetorno['precus'] := (Formula.PrecoCustoDil + Formula.EmbPrecoCusto) * Formula.FatorAcerto;
    End;
  End;
end;

procedure TLibTintaAutoluks.PreenchePrecosCustoVenda(dicRetorno: IDicionario;
  Formula: TAbstractFormulaAutomotiva; strTabelaUnica: String);
begin
  If TVariantUtils.IfNull(dicRetorno['precus'], 0) <= 0 Then
  Begin
    If dicRetorno['tippre'] = 'C' Then
      dicRetorno['precus'] := Formula.PrecoCustoCon + Formula.EmbPrecoCusto
    Else
      dicRetorno['precus'] := Formula.PrecoCustoDil + Formula.EmbPrecoCusto;
  End;

  If dicRetorno['tippre'] = 'C' Then
  Begin
    dicRetorno['precu2'] := Formula.PrecoCustoRealCon + Formula.EmbPrecoCustoReal;

    If TAutcomTintaFactory.Get.fGetConfTinta(Self.GetIdePro).fGet('ACRMOB') = '1' Then
      dicRetorno['preve' + strTabelaUnica] := (Formula.PrecoVendaCon + Formula.EmbPrecoVenda) * (1 + Formula.AcrMob / 100)
    Else
      dicRetorno['preve' + strTabelaUnica] := (Formula.PrecoVendaCon + Formula.EmbPrecoVenda) + Formula.AcrMob;
  End
  Else
  Begin
    dicRetorno['precu2'] := Formula.PrecoCustoRealDil + Formula.EmbPrecoCustoReal;

    If TAutcomTintaFactory.Get.fGetConfTinta(Self.GetIdePro).fGet('ACRMOB') = '1' Then
      dicRetorno['preve' + strTabelaUnica] := (Formula.PrecoVendaDil + Formula.EmbPrecoVenda) * (1 + Formula.AcrMob / 100)
    Else
      dicRetorno['preve' + strTabelaUnica] := Formula.PrecoVendaDil + Formula.EmbPrecoVenda + Formula.AcrMob;
  End;
end;

procedure TLibTintaAutoluks.PreenchePrecosCustoVenda1a7(dicRetorno: IDicionario;
  Formula: TAbstractFormulaAutomotiva; intContador: Integer);
begin
  PreenchePrecosCusto(dicRetorno, Formula);

  If dicRetorno['tippre'] = 'C' Then
  Begin
    If Formula.AcertoValor Then
      dicRetorno['precu2'] := Formula.PrecoCustoRealCon + Formula.EmbPrecoCustoReal + Formula.FatorAcerto
    Else
      dicRetorno['precu2'] := (Formula.PrecoCustoRealCon + Formula.EmbPrecoCustoReal) * Formula.FatorAcerto;

    If TAutcomTintaFactory.Get.fGetConfTinta(Self.GetIdePro).fGet('ACRMOB') = '1' Then
      dicRetorno['preve' + IntToStr(intContador)] := (Formula.PrecoVendaCon + Formula.EmbPrecoVenda) * (1 + Formula.AcrMob / 100)
    Else
      dicRetorno['preve' + IntToStr(intContador)] := Formula.PrecoVendaCon + Formula.EmbPrecoVenda + Formula.AcrMob;

    dicRetorno['preve' + IntToStr(intContador) + '_original'] := dicRetorno['preve' + IntToStr(intContador)];
  End
  Else
  Begin
    If Formula.AcertoValor Then
      dicRetorno['precu2'] := Formula.PrecoCustoRealDil + Formula.EmbPrecoCustoReal + Formula.FatorAcerto
    Else
      dicRetorno['precu2'] := (Formula.PrecoCustoRealDil + Formula.EmbPrecoCustoReal) * Formula.FatorAcerto;

    If TAutcomTintaFactory.Get.fGetConfTinta(Self.GetIdePro).fGet('ACRMOB') = '1' Then
      dicRetorno['preve' + IntToStr(intContador)] := (Formula.PrecoVendaDil + Formula.EmbPrecoVenda) * (1 + Formula.AcrMob / 100)
    Else
      dicRetorno['preve' + IntToStr(intContador)] := Formula.PrecoVendaDil + Formula.EmbPrecoVenda + Formula.AcrMob;

    dicRetorno['preve' + IntToStr(intContador) + '_original'] := dicRetorno['preve' + IntToStr(intContador)];
  End;
end;

procedure TLibTintaAutoluks.ProcessarBasesFormula(
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
    objBase.CodigoBase            := qryConsulta.FieldByName('ALK_BASE' + TStrUtils.fStrZero(intCont, 2)).AsString;
    objBase.QuantidadeConcentrado := qryConsulta.FieldByName('ALK_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
    objBase.TipoBase              := 'B';
    objBase.PesoEspecifico := fRetPesoEspecificoBase(objBase.CodigoBase);
  End;
end;

procedure TLibTintaAutoluks.pTintaRetornaTabelaPrecoGeneric(
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
      Formula.mveModoVenda       := fTipoVenda(dicRetorno);

      If (Not Formula.AcertoValor) And (fltFatorAcerto = 0) Then
        Formula.FatorAcerto        := 1
      Else
        Formula.FatorAcerto        := fltFatorAcerto;

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

      If Formula.AcertoValor Then
        dicRetorno['acerto'] := TAutcomTintaFactory.Get.IIF(Formula.FatorAcerto > 0, 'S', 'N')
      Else
        dicRetorno['acerto'] := TAutcomTintaFactory.Get.IIF(Formula.FatorAcerto > 1, 'S', 'N');

      If fRetornaFormulacaoParaTabelaPreco(dicRetorno, qryConsulta) Then
      Begin
        Formula.AcrMob := qryConsulta.FieldByName(GetPrefixoTabela + '_ACRMOB').AsFloat;
        Formula.VolumeOri := qryConsulta.FieldByName('ALK_VOLUME').AsFloat / 1000;
        Formula.VolumeConcentrado := qryConsulta.FieldByName('ALK_VOLUME').AsFloat / 1000;
        Formula.VolumeDiluido := qryConsulta.FieldByName('ALK_VOLUME').AsFloat / 1000;
      End
      Else
        dicRetorno['formula_nao_encontrada'] := 'S';

      Formula.CodEmb := dicRetorno['iteemb'];

      Formula.CodFormul := GetCodFormul(dicRetorno);

      PreencherPesCorFor(Formula, qryConsulta);

      pProcessaFormulacaoTabelaPreco(Formula, dicRetorno, qryConsulta);

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

{procedure TLibTintaAutoluks.PreencherPesCorFor(
  Formula: TAbstractFormulaAutomotiva; qryConsulta: IDataSet);
begin
  Formula.pPreencherPesCorFor(qryConsulta);
end;
 }
procedure TLibTintaAutoluks.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL := 'SELECT *          ' +
                    '  FROM ALK_CADALK ' +
                    ' WHERE ALK_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('ALK_CODIGO').AsString;
      dicRetorno['martin'] := qryGen.FieldByName('ALK_PRODUT').AsString;
      dicRetorno['a_n_o_'] := qryGen.FieldByName('ALK_ANOINI').AsString;
      dicRetorno['montad'] := qryGen.FieldByName('ALK_PRODUT').AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TLibTintaAutoluks.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaAutoluks.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
  Var
    strTraAutoluks: String;
    fltTraAutoluks: Double;
    conf: IConfTinta;
Begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('ALK');

  If (dicDados['tippre'] = 'C') Then
  Begin
    strTraAutoluks := TAutcomTintaFactory.Get.IIF(conf.fGet('ALKTRV') = '1', 'VEN', 'CUS');
    fltTraAutoluks := conf.fGetDouble('ALKFAT');
  End
  Else
  Begin
    strTraAutoluks := TAutcomTintaFactory.Get.IIF(conf.fGet('ALKTRV') = '3', 'VEN', 'CUS');
    fltTraAutoluks := conf.fGetDouble('ALKFAT');
  End;

  If (strTraAutoluks = 'VEN') Then
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0);

  Result := TFloatUtils.fFormataFloat(Result * fltTraAutoluks, 2);
end;

end.
