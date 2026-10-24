{******************************************-*********************}
{* Classe contendo as informações especificas da tinta Duxone   *}
{*******************************************-*****************AC*}
unit untLibTintaDuxone;

interface

uses
{$IFNDEF LINUX}
  Controls,
{$ENDIF}
  untAbstractLibTintaAutomotiva, untAbstractFormulaAutomotiva,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem, untFloatUtils, untBaseAutomotiva,
  untStrUtils, untGTinForTipos, Classes,
  Math;

type
  TLibTintaDuxone = class(TAbstractLibTintaAutomotiva)
  private

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
  untAuttinMenuItemDuxone,
{$ENDIF}
  untFormulaAutomotivaDuxone, untTintadeMaquinaWrapperDuxone, untAutcomTintaFactory, untVariantUtils,
  untICalculadorFatVendasLibTintas, untModoVenda;

{ TDuxoneTintadeMaquina }

function TLibTintaDuxone.fRetornaCodigoChapinhaGeneric(
  strIdePro: String): String;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta(strIdePro).fGet('PROCHA');
end;

function TLibTintaDuxone.fUsaChapinhaTintaGeneric(strIdePro,
  strIteTin: String): Boolean;
Var
  qryConsulta: IDataSet;
begin
  Result := False;

  qryConsulta := TAutcomTintaFactory.Get.fGetDataSet;
  qryConsulta.SQL := '  SELECT DUX_PROCHA FROM DUX_CADDUX WHERE DUX_MD5KEY = :ITETIN  ';
  qryConsulta.ParamByName('ITETIN').AsString := strIteTin;
  qryConsulta.Open;

  If qryConsulta.IsEmpty Then
    Exit;

  Result := (qryConsulta.FieldByName('DUX_PROCHA').AsString = 'S');
end;

function TLibTintaDuxone.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESBAS';
end;

function TLibTintaDuxone.GetCodFormul(const dicRetorno: IDicionario): string;
begin
  Result := '';
end;

function TLibTintaDuxone.GetComponentePorEmpresas(const strCodEmp: String): String;
begin
  Result := '';

  If TAutcomTintaFactory.Get.GetEmpBasDUX Then
    Result := ' AND BAS_CODEMP = "' + strCodEmp + '" ';
end;

function TLibTintaDuxone.GetEmbalaArrBaixaPigmentos(dtsBases: IDataSet): Double;
begin
  Result := dtsBases.FieldByName('BAS_EMBALA').AsFloat;
end;

function TLibTintaDuxone.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaDuxone.Create(strTabPre);
end;

function TLibTintaDuxone.GetFormulArrBaixaPigmentos(dtsBases: IDataSet): String;
begin
  Result := dtsBases.FieldByName('BAS_CODBAS').AsString;
end;

function TLibTintaDuxone.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperDuxone.Create() as ITintadeMaquinaWrapper;
end;


function TLibTintaDuxone.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemDuxone.Create();
{$ENDIF}
end;

function TLibTintaDuxone.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORDUX';
end;

function TLibTintaDuxone.GetNomeTinta: String;
begin
  Result := 'Duxone Global';
end;

function TLibTintaDuxone.GetPesGraArrBaixaPigmentos(dtsBases: IDataSet): String;
begin
  Result := dtsBases.FieldByName('BAS_PESGRA').AsString;
end;

function TLibTintaDuxone.GetPrefixoTabela: String;
begin
  Result := 'DUX';
end;

function TLibTintaDuxone.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String): String;
begin
  Result := '';
end;

function TLibTintaDuxone.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result :=
    ' SELECT                                 ' +
    '   BAS_CODBAS                           ' +
    '   , BAS_CODITE                         ' +
    '   , BAS_PESGRA                         ' +
    '   , BAS_EMBALA                         ' +
    ' FROM                                   ' +
    '   DUX_CADBAS                           ' +
    ' WHERE BAS_CODBAS IN (' + strBases + ') ';

  If TAutcomTintaFactory.Get.GetEmpBasDUX Then
    Result := Result + '  AND BAS_CODEMP = "' + dicDados['codempprd'] + '" ';
end;

function TLibTintaDuxone.GetVolumeConcentrado: Double;
begin
  Result := 1;
end;

function TLibTintaDuxone.GetVolumeDiluido: Double;
begin
  Result := 1;
end;

function TLibTintaDuxone.GetVolumeOriginal(const dicRetorno: IDicionario): Double;
begin
  Result := 0.9;
end;

function TLibTintaDuxone.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := dicRetorno['volpro'];
end;

procedure TLibTintaDuxone.pProcessaFormulacaoGTinFor(
  Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet; dicBases: IDicionario;
  Const Formula: TAbstractFormulaAutomotiva; Const dicDados: IDicionario; var strBases: String);
var
  intCont: Integer;
  intIndice: Integer;
  fltQtdBai: Double;
begin
  intIndice := 1;
  for intCont := 1 to formula.GetQuantidadeFormulacao do
  begin
    If qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicDados['tippre']) + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 Then
      Break;

    If (qryConsulta.FieldByName('DUX_TIPB' + TStrUtils.fStrZero(intCont, 2)).AsString = 'C')  And (TVariantUtils.IfNull(dicDados['catalize'],'N') <> 'S') Then
      Continue;

    If (qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2)).AsString) <> (TVariantUtils.IfNull(dicDados['catalize'],'N')) Then
    Begin
      arrFormul[intIndice].strFormul := qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2)).AsString;


      If TStrUtils.fEmptyStr(qryConsulta.FieldByName('DUX_CODNFM').AsString) Then
      Begin
        fltQtdBai := RoundTo(qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicDados['tippre']) + TStrUtils.fStrZero(intCont, 2)).AsFloat, -1);
        arrFormul[intIndice].fltQtdbas := RoundTo(fltQtdBai * ((dicDados['volpro'] * 1000) /
                                                                qryConsulta.FieldByName(formula.GetPrefixoLitragem(dicDados['tippre'])).AsFloat), -1);
      End
      Else
      Begin
        fltQtdBai := qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicDados['tippre']) + TStrUtils.fStrZero(intCont, 2)).AsFloat;
        arrFormul[intIndice].fltQtdbas := fltQtdBai * ((dicDados['volpro'] * 1000) /
                                                                qryConsulta.FieldByName(formula.GetPrefixoLitragem(dicDados['tippre'])).AsFloat);
      End;



      dicBases[arrFormul[intIndice].strFormul] := arrFormul[intIndice].fltQtdbas;

      strBases := strBases + QuotedStr(arrFormul[intIndice].strFormul);

      If (Not TStrUtils.fEmptyStr(arrFormul[intIndice].strFormul)) Then
        strBases := strBases + ', ';

      Inc(intIndice, 1);
    End;
  end;
end;

procedure TLibTintaDuxone.pProcessaFormulacaoTabelaPreco(
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
    If Not qryConsulta.IsEmpty Then
    Begin
      If ((TVariantUtils.IfNull(dicRetorno['tippre'], 'C') = 'C') And (qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicRetorno['tippre']) + TStrUtils.fStrZero(intContador, 2)).AsFloat <= 0)) Or
         ((TVariantUtils.IfNull(dicRetorno['tippre'], 'D') = 'D') And (qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicRetorno['tippre']) + TStrUtils.fStrZero(intContador, 2)).AsFloat <= 0)) Then
        Continue;

      Base := TBaseAutomotiva(Formula.Add);
      Base.CodigoBase := qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intContador, 2)).AsString;


      If TVariantUtils.IfNull(dicRetorno['tippre'], 'C') = 'C' Then
      Begin
        If TStrUtils.fEmptyStr(qryConsulta.FieldByName('DUX_CODNFM').AsString) Then
          Base.QuantidadeConcentrado := RoundTo(qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicRetorno['tippre']) + TStrUtils.fStrZero(intContador, 2)).AsFloat, -1)
        else
          Base.QuantidadeConcentrado := (qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicRetorno['tippre']) + TStrUtils.fStrZero(intContador, 2)).AsFloat);
      End
      Else
      Begin
        If TStrUtils.fEmptyStr(qryConsulta.FieldByName('DUX_CODNFM').AsString) Then
          Base.QuantidadeDiluido := RoundTo(qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicRetorno['tippre']) + TStrUtils.fStrZero(intContador, 2)).AsFloat, -1)
        else
          Base.QuantidadeDiluido := (qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicRetorno['tippre']) + TStrUtils.fStrZero(intContador, 2)).AsFloat);
      End;


      Base.TipoBase  := qryConsulta.FieldByName('DUX_TIPB' + TStrUtils.fStrZero(IntToStr(intContador), 2)).AsString;
      Base.Qualidade := qryConsulta.FieldByName('DUX_QUALID').AsString;
    End
    Else
    Begin
      If (TStrUtils.fEmptyStr(TVariantUtils.IfNull(dicRetorno['base' + TStrUtils.fStrZero(intContador, 2)], ''))) Then
        Break;

      Base := TBaseAutomotiva(Formula.Add);
      Base.CodigoBase := dicRetorno['base' + TStrUtils.fStrZero(intContador, 2)];
      If dicRetorno['tippre'] = 'C' Then
        Base.QuantidadeConcentrado := TFloatUtils.fFormataFloat(dicRetorno['qtdb' + TStrUtils.fStrZero(intContador, 2)], 3) * Formula.VolumeOri / Formula.VolumePro
      Else
        Base.QuantidadeDiluido     := TFloatUtils.fFormataFloat(dicRetorno['qtdb' + TStrUtils.fStrZero(intContador, 2)], 3) * Formula.VolumeOri / Formula.VolumePro;
      Base.TipoBase := 'B';
    End;
  End;
end;

procedure TLibTintaDuxone.pTintaRetornaTabelaPrecoGeneric(
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

      If dicRetorno['tippre'] = 'C' Then
        Formula.mveModoVenda     := mvConcentrado
      Else
        Formula.mveModoVenda     := mvDiluido;

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
        Formula.AcrMob := qryConsulta.FieldByName(GetPrefixoTabela + '_ACRMOB').AsFloat
      Else
        dicRetorno['formula_nao_encontrada'] := 'S';

      Formula.CodEmb := dicRetorno['iteemb'];
      Formula.UsaChapinha := Formula.GetUsaChapinha(qryConsulta);
      Formula.ProCha := TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGet('PROCHA');

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
        Formula.pCarregaPrecoChapinha(strTabelaUnica, TVariantUtils.IfNull(dicRetorno['opcdoc'], ''));

        If TVariantUtils.IfNull(dicRetorno['precus'], 0) <= 0 Then
        Begin
          If dicRetorno['tippre'] = 'C' Then
            dicRetorno['precus'] := Formula.PrecoCustoCon + Formula.EmbPrecoCusto
          Else
            dicRetorno['precus'] := Formula.PrecoCustoDil + Formula.EmbPrecoCusto;

          If Formula.UsaChapinha Then
            dicRetorno['precus'] := dicRetorno['precus'] + Formula.ChaPrecoCusto;
        End;

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

        Formula.pCalculaImpostosSaida(dicRetorno);
        dicRetorno.AdicionarObjeto('tintaDeMaquina', Formula.tintaDeMaquina[Formula.mveModoVenda]);
        dicRetorno['promoc'] := Formula.Promoc;

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
      End
      Else
      Begin
        strTabelas := TAutcomTintaFactory.Get.fCfgSis('TABPRC');
        If Length(strTabelas) < 7 Then
          strTabelas := strTabelas + StringOfChar('N',7 - Length(strTabelas));

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

            If dicRetorno['tippre'] = 'C' Then
            Begin
              If Formula.UsaChapinha Then
              Begin
                dicRetorno['precu2'] := Formula.ChaPrecoCustoReal;
                dicRetorno['preve' + IntToStr(intContador)] := Formula.ChaPrecoVenda;
              End;

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
              If Formula.UsaChapinha Then
              Begin
                dicRetorno['precu2'] := Formula.ChaPrecoCustoReal;
                dicRetorno['preve' + IntToStr(intContador)] := Formula.ChaPrecoVenda;
              End;

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
        raise Exception.Create(E.Message);
      end;
    End;
  Finally
    TAutcomTintaFactory.Get.pSetaEmpresaLogadaTinta(strCodEmp);
  End;
end;

procedure TLibTintaDuxone.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL := 'SELECT *           ' +
                    '  FROM DUX_CADDUX  ' +
                    ' WHERE DUX_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('DUX_CODDUX').AsString;
      dicRetorno['montad'] := qryGen.FieldByName('DUX_MONTAD').AsString;
      dicRetorno['martin'] := qryGen.FieldByName('DUX_LINHA_').AsString;
      dicRetorno['a_n_o_'] := qryGen.FieldByName('DUX_ANOCOR').AsString;
      dicRetorno['catal_'] := qryGen.FieldByName('DUX_CATALI').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TLibTintaDuxone.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaDuxone.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
  Var
    strTraDuxone: String;
    fltTraDuxone: Double;
    conf: IConfTinta;
Begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('DUX');

  strTraDuxone := conf.fGet('TRADUX');
  fltTraDuxone := conf.fGetDouble('FATDUX');

  If (strTraDuxone = 'VEN') Then
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0);

  Result := TFloatUtils.fFormataFloat(Result * fltTraDuxone, 2);
end;

end.
