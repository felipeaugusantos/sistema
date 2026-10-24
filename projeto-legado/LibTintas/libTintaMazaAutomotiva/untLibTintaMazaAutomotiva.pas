{******************************************-*********************}
{* Classe contendo as informações especificas da tinta MazaAutomotiva *}
{*******************************************-*****************AC*}
unit untLibTintaMazaAutomotiva;

interface

uses
{$IFNDEF LINUX}
  Controls,
{$ENDIF}
  untAbstractLibTintaAutomotiva, untAbstractFormulaAutomotiva,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem, untFloatUtils, untBaseAutomotiva,
  untStrUtils, untGTinForTipos, Classes,
  untICalculadorFatVendasLibTintas, untModoVenda;

type
  TLibTintaMazaAutomotiva = class(TAbstractLibTintaAutomotiva)
  private
    function fPesoEspecificoBase(strBase: String): Double;
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
    procedure PreencherPesCorFor(Formula: TAbstractFormulaAutomotiva; qryConsulta: IDataSet); override;
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
  untAuttinMenuItemMazaAutomotiva,
{$ENDIF}
  untFormulaAutomotivaMazaAutomotiva, untTintadeMaquinaWrapperMazaAutomotiva, untAutcomTintaFactory, untVariantUtils;

{ TMazaAutomotivaTintadeMaquina }

{function TLibTintaMazaAutomotiva.fValidarMd5Key(strIteTin: String): Boolean;
begin
  Result := True;
end;
 }
function TLibTintaMazaAutomotiva.fPesoEspecificoBase(strBase: String): Double;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT BAS_PESESP FROM MZA_CADBAS WHERE BAS_CODBAS  = :CODBAS ';
  qryGen.ParamByName('CODBAS').AsString := strBase;
  qryGen.Open;

  Result := qryGen.FieldByName('BAS_PESESP').AsFloat;
end;

function TLibTintaMazaAutomotiva.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESCRI';
end;

function TLibTintaMazaAutomotiva.GetCodFormul(const dicRetorno: IDicionario): string;
begin
  Result := '';
end;

function TLibTintaMazaAutomotiva.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaMazaAutomotiva.Create(strTabPre);
end;

function TLibTintaMazaAutomotiva.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperMazaAutomotiva.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaMazaAutomotiva.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemMazaAutomotiva.Create();
{$ENDIF}
end;

function TLibTintaMazaAutomotiva.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORMZA';
end;

function TLibTintaMazaAutomotiva.GetNomeTinta: String;
begin
  Result := 'Maza Automotiva';
end;

function TLibTintaMazaAutomotiva.GetPrefixoTabela: String;
begin
  Result := 'MZA';
end;

function TLibTintaMazaAutomotiva.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String): String;
begin
  Result := '';
end;

function TLibTintaMazaAutomotiva.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   BAS_CODBAS                                ' +
    '   , BAS_CODITE                              ' +
    ' FROM                                        ' +
    '   MZA_CADBAS                                ' +
    ' WHERE BAS_CODBAS IN (' + strBases + ') ';
end;

function TLibTintaMazaAutomotiva.GetVolumeConcentrado: Double;
begin
  Result := 0.9;
end;

function TLibTintaMazaAutomotiva.GetVolumeDiluido: Double;
begin
  Result := 0;
end;

function TLibTintaMazaAutomotiva.GetVolumeOriginal(const dicRetorno: IDicionario): Double;
begin
  Result := 0.9;
end;

function TLibTintaMazaAutomotiva.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := dicRetorno['volpro'];
end;

procedure TLibTintaMazaAutomotiva.pProcessaFormulacaoGTinFor(
  Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet; dicBases: IDicionario;
  Const Formula: TAbstractFormulaAutomotiva; Const dicDados: IDicionario; var strBases: String);
var
  intCont: Integer;
  fltQuantidade: Double;
  objBase: TBaseAutomotiva;
  strFormula:String;
  strQuantidade:String;
begin
  Formula.BaiQDig  := qryConsulta.FieldByName('MZA_BAIQDI').AsString;
  fltQuantidade := 0;

  For intCont := 1 To Formula.GetQuantidadeFormulacao Do
  Begin
    strFormula := formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont,2);
    strQuantidade := formula.GetPrefixoQuantidade(dicDados['tippre']) + TStrUtils.fStrZero(intCont, 2);

    If TStrUtils.fEmptyStr(qryConsulta.FieldByName(strFormula).AsString) Then
      Break;

    objBase := TBaseAutomotiva(Formula.Add);
    objBase.CodigoBase := qryConsulta.FieldByName(strFormula).AsString;
    objBase.QuantidadeConcentrado := qryConsulta.FieldByName(strQuantidade).AsFloat / fPesoEspecificoBase(objBase.CodigoBase);
    objBase.PesoEspecifico := fPesoEspecificoBase(objBase.CodigoBase);
    objBase.TipoBase := 'B';

    fltQuantidade := fltQuantidade + objBase.QuantidadeConcentrado;
  End;

  For intCont := Formula.Count - 1 Downto 0 Do
  Begin
    strQuantidade := formula.GetPrefixoQuantidade(dicDados['tippre']) + TStrUtils.fStrZero(intCont + 1, 2);
    objBase := (Formula.Items[intCont] As TBaseAutomotiva);
    objBase.QuantidadeConcentrado := objBase.QuantidadeConcentrado * 900 / fltQuantidade;

    If Formula.BaiQDig = 'S' Then
      objBase.QuantidadeConcentrado := qryConsulta.FieldByName(strQuantidade).AsFloat
    Else
      objBase.QuantidadeConcentrado := objBase.QuantidadeConcentrado * fPesoEspecificoBase(objBase.CodigoBase);
  End;

  Formula.pReformulaNovo(dicDados['coddil'], dicDados['pordil'], qryConsulta);

  For intCont := Formula.Count - 1 Downto 0 Do
  Begin
    If dicDados['tippre'] = 'C' Then
      fltQuantidade := TBaseAutomotiva(Formula.Items[intCont]).QuantidadeConcentrado * (dicDados['volpro'] / 0.9)
    Else
      fltQuantidade := TBaseAutomotiva(Formula.Items[intCont]).QuantidadeDiluido * (dicDados['volpro'] / 0.9);

    arrFormul[intCont + 1].strFormul := TBaseAutomotiva(Formula.Items[intCont]).CodigoBase;
    arrFormul[intCont + 1].fltQtdbas := fltQuantidade;

    dicBases[arrFormul[intCont + 1].strFormul] := arrFormul[intCont + 1].fltQtdbas;

    strBases := strBases + QuotedStr(arrFormul[intCont + 1].strFormul);
    If (Not TStrUtils.fEmptyStr(arrFormul[intCont + 1].strFormul)) Then
      strBases := strBases + ', ';
  End;
end;

procedure TLibTintaMazaAutomotiva.pProcessaFormulacaoTabelaPreco(
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
      Base.QuantidadeConcentrado :=
        TFloatUtils.fFormataFloat(dicRetorno['qtdb' + TStrUtils.fStrZero(intContador, 2)], 3) * Formula.VolumeOri / Formula.VolumePro
    Else
      Base.QuantidadeDiluido     :=
        TFloatUtils.fFormataFloat(dicRetorno['qtdb' + TStrUtils.fStrZero(intContador, 2)], 3) * Formula.VolumeOri / Formula.VolumePro;

    Base.TipoBase := 'B';
  End;
end;

procedure TLibTintaMazaAutomotiva.PreencherPesCorFor(
  Formula: TAbstractFormulaAutomotiva; qryConsulta: IDataSet);
begin
  Formula.pPreencherPesCorFor(qryConsulta);
end;

procedure TLibTintaMazaAutomotiva.pTintaRetornaTabelaPrecoGeneric(
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

      Formula.CodFormul := GetCodFormul(dicRetorno);
      Formula.BaiQDig   := qryConsulta.FieldByName('MZA_BAIQDI').AsString;

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

        Formula.pCalculaImpostosSaida(dicRetorno);
        dicRetorno.AdicionarObjeto('tintaDeMaquina', Formula.tintaDeMaquina[Formula.mveModoVenda]);
        dicRetorno['promoc'] := Formula.Promoc;

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

procedure TLibTintaMazaAutomotiva.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL := 'SELECT *          ' +
                    '  FROM MZA_CADMZA ' +
                    '  LEFT JOIN MZA_CADMON ON MON_CODMON = MZA_CODMON '+
                    ' WHERE MZA_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
      begin
        qryGen.Close;
        qryGen.SQL := ' SELECT * '+
                      ' FROM MZA_CADMZA '+
                      ' LEFT JOIN MZA_CADMON ON MON_CODMON = MZA_CODMON '+
                      ' WHERE  '+
                      '    UPPER(CAST(MD5(CONCAT( '+
                      '       IFNULL(MZA_CODIGO, ""),  '+
                      '       IFNULL(MZA_VARIAC, ""),  '+
                      '       IFNULL(MZA_DESCRI, ""),  '+
                      '       IFNULL(MZA_ANOCOR, ""),  '+
                      '       IFNULL(MZA_DTAFOR, ""),  '+
                      '       IFNULL(MZA_LINHA_, ""),  '+
                      '       IFNULL(MZA_CODMON, ""),  '+
                      '       IFNULL(MZA_CODNFM, ""),  '+
                      '       IFNULL(MZA_UNIVER, "")))AS CHAR)) = :ITETIN ';

        qryGen.ParamByName('ITETIN').AsString := strIteTin;
        qryGen.Open;
      end;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('MZA_CODIGO').AsString;
      dicRetorno['martin'] := qryGen.FieldByName('MZA_LINHA_').AsString;
      dicRetorno['montad'] := qryGen.FieldByName('MON_DESCRI').AsString;
      dicRetorno['a_n_o_'] := qryGen.FieldByName('MZA_ANOCOR').AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TLibTintaMazaAutomotiva.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaMazaAutomotiva.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
  Var
    strTraMazaAutomotiva: String;
    fltTraMazaAutomotiva: Double;
    conf: IConfTinta;
Begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('MZA');

  If (dicDados['tippre'] = 'C') Then
  Begin
    strTraMazaAutomotiva := TAutcomTintaFactory.Get.IIF(conf.fGet('MZATRV') = '1', 'VEN', 'CUS');
    fltTraMazaAutomotiva := conf.fGetDouble('MZAFAT');
  End
  Else
  Begin
    strTraMazaAutomotiva := TAutcomTintaFactory.Get.IIF(conf.fGet('MZATRV') = '3', 'VEN', 'CUS');
    fltTraMazaAutomotiva := conf.fGetDouble('MZAFAT');
  End;

  If (strTraMazaAutomotiva = 'VEN') Then
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0);

  Result := TFloatUtils.fFormataFloat(Result * fltTraMazaAutomotiva, 2);
end;

end.

