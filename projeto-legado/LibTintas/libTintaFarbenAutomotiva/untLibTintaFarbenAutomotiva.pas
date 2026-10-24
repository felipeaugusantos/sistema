{******************************************-*************************************}
{* Classe contendo as informações especificas da tinta FarbenAutomotiva *}
{*******************************************-************************************}
unit untLibTintaFarbenAutomotiva;

interface

uses
{$IFNDEF LINUX}
  Controls,
{$ENDIF}
  untAbstractLibTintaAutomotiva, untAbstractFormulaAutomotiva,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem, untFloatUtils, untBaseAutomotiva,
  untStrUtils, untGTinForTipos, Classes,StrUtils;

type
  TLibTintaFarbenAutomotiva = class(TAbstractLibTintaAutomotiva)
  private
    fltVolPro: Double;
    strPorcentagem: String;
    strDiluente: String;
    function fRetornarDensidade(strCodBas : String) : Double;
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

    function fTruncaValor(fltValor: Double; intCasas: Integer): Double;
    function fArredondaValor(fltValor: Double; intCasas: Integer): Double;
    function fRetornaFatorDensidade(strTipPrg: String; fltQtdCon, fltPesEsp: Double): Double;
    function fRetornaTotalDensidade(strTipPrg: String; fltPorcen, fltDensid: Double): Double;
    function fCasasDecimaisQtd(strTipPrg: String): Integer;
    procedure pTintaRetornaTabelaPrecoGeneric(dicRetorno: IDicionario; fltFatorAcerto: Double); Override;
    function fUsaChapinhaTintaGeneric(strIdePro, strIteTin: String): Boolean; Override;
    function fRetornaCodigoChapinhaGeneric(strIdePro: String): String; Override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemFarbenAutomotiva,
{$ENDIF}
  untFormulaAutomotivaFarbenAutomotiva, untTintadeMaquinaWrapperFarbenAutomotiva, untAutcomTintaFactory, untVariantUtils,
  untICalculadorFatVendasLibTintas, untModoVenda;

{ TFarbenAutomotivaTintadeMaquina }



function TLibTintaFarbenAutomotiva.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESCRI';
end;

function TLibTintaFarbenAutomotiva.GetCodFormul(const dicRetorno: IDicionario): string;
begin
  Result := '';
end;

function TLibTintaFarbenAutomotiva.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaFarbenAutomotiva.Create(strTabPre);
end;

function TLibTintaFarbenAutomotiva.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperFarbenAutomotiva.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaFarbenAutomotiva.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemFarbenAutomotiva.Create();
{$ENDIF}
end;

function TLibTintaFarbenAutomotiva.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORFAR';
end;

function TLibTintaFarbenAutomotiva.GetNomeTinta: String;
begin
  Result := 'Farben Automotiva';
end;

function TLibTintaFarbenAutomotiva.GetPrefixoTabela: String;
begin
  Result := 'FAR';
end;

function TLibTintaFarbenAutomotiva.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String): String;
begin
  Result := '';
end;

function TLibTintaFarbenAutomotiva.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result :=
    ' SELECT                                 ' +
    '     BAS_CODBAS                         ' +
    '   , BAS_CODITE                         ' +
    '   , BAS_DESCRI                         ' +
    '   , BAS_EMBALA                         ' +
    '   , BAS_DENSID AS BAS_PESESP           ' +
    ' FROM                                   ' +
    '   FAR_CADBAS                           ' +
    ' WHERE BAS_CODBAS IN (' + strBases + ') ';
end;

function TLibTintaFarbenAutomotiva.GetVolumeConcentrado: Double;
begin
  Result := 0.9;
end;

function TLibTintaFarbenAutomotiva.GetVolumeDiluido: Double;
begin
  Result := 0.9;
end;

function TLibTintaFarbenAutomotiva.GetVolumeOriginal(const dicRetorno: IDicionario): Double;
begin
  Result := 0.9;
end;

function TLibTintaFarbenAutomotiva.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := dicRetorno['volpro'];
end;

procedure TLibTintaFarbenAutomotiva.pProcessaFormulacaoGTinFor(
  Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet; dicBases: IDicionario;
  Const Formula: TAbstractFormulaAutomotiva; Const dicDados: IDicionario; var strBases: String);
Var
  intCont             : Integer;
  fltFatorDensidade   : Double;
  fltTotalDensidade   : Double;
  fltTotalPorcentagem : Double;
  qryGen              : IDataSet;
  blnNovaFormula      : boolean;
  objBase             : TBaseAutomotiva;
  strFormula,
  strQuantCon,
  strQuantDil       : String;
  fltQuantidade     : Double;
  fltTotFatorDilui  : Double;
  intQtdFor: Integer;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT * FROM FAR_CADBAS ';
  qryGen.Open;

  fltTotalDensidade   := 0;
  fltTotalPorcentagem := 0;
  fltTotFatorDilui := 100 + StrToFloat(dicDados['pordil']);

  blnNovaFormula := Pos('ESP', qryConsulta.FieldByName(formula.GetCodNovaFormula).AsString) > 0 ;

  fltVolPro := dicDados['volpro'];
  strPorcentagem := dicDados['pordil'];
  strDiluente := dicDados['coddil'];

  For intCont := 1 To 20 Do
  Begin
    strFormula := Formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2);
    strQuantCon := 'FAR_QTDC' + TStrUtils.fStrZero(intCont, 2);
    strQuantDil := 'FAR_QTDD' + TStrUtils.fStrZero(intCont, 2);

    If TStrUtils.fEmptyStr(qryConsulta.FieldByName(strFormula).AsString) Then
      Continue;

    objBase := TBaseAutomotiva(Formula.Add);
    objBase.CodigoBase := qryConsulta.FieldByName(strFormula).AsString;
    objBase.QuantidadeConcentrado := qryConsulta.FieldByName(strQuantCon).AsFloat;
    objBase.QuantidadeDiluido := qryConsulta.FieldByName(strQuantDil).AsFloat;
    objBase.PesoEspecifico := fRetornarDensidade(ObjBase.CodigoBase);
    ObjBase.TipoBase := 'B';
  End;

  intQtdFor := 1;
  Formula.pReformulaNovo(dicDados['coddil'], dicDados['pordil'], qryConsulta);

  If (qryConsulta.FieldByName('FAR_LINHA_').AsString = 'PE') And (qryConsulta.FieldByName('FAR_TIPPRG').AsString = '3') Then
  Begin
    For intCont := 0 To Formula.Count - 1 Do
    Begin
      If dicDados['tippre'] = 'C' Then
        fltQuantidade := TBaseAutomotiva(Formula.Items[intCont]).QuantidadeConcentrado
      Else
        fltQuantidade := TBaseAutomotiva(Formula.Items[intCont]).QuantidadeDiluido;

      arrFormul[intCont + 1].strFormul := TBaseAutomotiva(Formula.Items[intCont]).CodigoBase;
      arrFormul[intCont + 1].fltQtdbas := fltQuantidade;

      strBases := strBases + QuotedStr(arrFormul[intCont + 1].strFormul);

      If (Not TStrUtils.fEmptyStr(arrFormul[intCont + 1].strFormul)) Then
        strBases := strBases + ', ';

      If (TBaseAutomotiva(Formula.Items[intCont]).CodigoBase = '558.400') Or
        (TBaseAutomotiva(Formula.Items[intCont]).CodigoBase = '558.000') Then
      Begin
        fltTotalPorcentagem := fltTotalPorcentagem + StrToFloat(dicDados['pordil']) * 100 / fltTotFatorDilui;
        Break;
      End;

      If dicDados['tippre'] = 'C' Then
        fltTotalPorcentagem := fltTotalPorcentagem + fltQuantidade
      Else
        fltTotalPorcentagem := fltTotalPorcentagem + TBaseAutomotiva(Formula.Items[intCont]).QuantidadeConcentrado * 100 / fltTotFatorDilui;
    End;
  End
  Else
  Begin
    For intCont := 1 to 20 do
    begin
      If qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicDados['tippre']) + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 Then
        continue;

      arrFormul[intQtdFor].strFormul   := qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2)).AsString;
      arrFormul[intQtdFor].fltQtdbas := qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicDados['tippre']) + TStrUtils.fStrZero(intCont, 2)).AsFloat;

      fltTotalPorcentagem := fltTotalPorcentagem + arrFormul[intQtdFor].fltQtdbas;

      strBases := strBases + QuotedStr(arrFormul[intQtdFor].strFormul);

      If (Not TStrUtils.fEmptyStr(arrFormul[intQtdFor].strFormul)) Then
        strBases := strBases + ', ';

      Inc(intQtdFor);
    End;
  End;

  For intCont := 1 to 20 do
  begin

    If TStrUtils.fEmptyStr(arrFormul[intCont].strFormul) Then
      continue;

    qryGen.Locate('BAS_CODBAS',arrFormul[intCont].strFormul,[]);

    Try
      fltFatorDensidade :=  arrFormul[intCont].fltQtdbas / qryGen.FieldByName('BAS_DENSID').AsFloat;
    Except
      fltFatorDensidade :=  1;
    End;

    fltTotalDensidade := fltTotalDensidade + fltFatorDensidade;
  end;

  Try
    fltTotalDensidade := fltTotalPorcentagem / fltTotalDensidade
  Except
    fltTotalDensidade := 1;
  End;

  If (qryConsulta.FieldByName('FAR_LINHA_').AsString = 'PE') And (qryConsulta.FieldByName('FAR_TIPPRG').AsString = '3') Then
  Begin
    For intCont := 1 To 20 Do
    Begin
      If TStrUtils.fEmptyStr(arrFormul[intCont].strFormul) Then
        Continue;

      If blnNovaFormula Then
      Begin
        arrFormul[intCont].fltQtdbas := arrFormul[intCont].fltQtdbas * dicDados['volpro'] / 0.9;
        dicBases[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;
      End
      Else
      Begin
        If dicDados['tippre'] = 'C' Then
          arrFormul[intCont].fltQtdbas := fArredondaValor(dicDados['volpro']* fltTotalDensidade * (arrFormul[intCont].fltQtdbas / 100) * 1000, fCasasDecimaisQtd(qryConsulta.FieldByName('FAR_TIPPRG').AsString))
        Else
          arrFormul[intCont].fltQtdbas := TBaseAutomotiva(Formula.Items[intCont - 1]).QuantidadeDiluido * (dicDados['volpro'] / 0.9);

        dicBases[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;
      End;
    End;
  End
  Else
  Begin
    For intCont := 1 To 20 Do
    Begin

      If TStrUtils.fEmptyStr(arrFormul[intCont].strFormul) Then
        continue;

      If blnNovaFormula Then
      Begin
        arrFormul[intCont].fltQtdbas := arrFormul[intCont].fltQtdbas * dicDados['volpro'] / 0.9;
        dicBases[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;
      End
      Else
      Begin
        arrFormul[intCont].fltQtdbas := fArredondaValor(dicDados['volpro']* fltTotalDensidade * (arrFormul[intCont].fltQtdbas / 100) * 1000, 5);
        dicBases[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;
      End;
    End;
  End;
end;

procedure TLibTintaFarbenAutomotiva.pProcessaFormulacaoTabelaPreco(
  Formula: TAbstractFormulaAutomotiva; const dicRetorno: IDicionario; const qryConsulta: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
  fltFatorDensidade  : Double;
  fltTotalDensidade  : Double;
  fltTotalPorcentagem: Double;
  blnNovaFormula     : Boolean;
begin
  fltTotalPorcentagem := 0;
  fltTotalDensidade   := 0;

  For intContador := 1 To 20 Do
  Begin
    If (TStrUtils.fEmptyStr(TVariantUtils.IfNull(qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intContador, 2)).AsString, ''))) Then
      Continue;

    If (dicRetorno['tippre'] = 'C') And (qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intContador, 2)).AsString = '558.000') Then
      Continue;

    Base := TBaseAutomotiva(Formula.Add);
    Base.CodigoBase := qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intContador, 2)).AsString;

    If dicRetorno['tippre'] = 'C' Then
      Base.QuantidadeConcentrado := qryConsulta.FieldByName('FAR_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat
    Else
      Base.QuantidadeDiluido     := qryConsulta.FieldByName('FAR_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

    Base.TipoBase := 'B';
  End;

  Formula.pReformulaNovo(strDiluente, strPorcentagem, qryConsulta);

  blnNovaFormula := Pos('ESP', qryConsulta.FieldByName(formula.GetCodNovaFormula).AsString) > 0;

  If Not blnNovaFormula Then
  begin
    //CONCENTRADO

    For intContador := 0 To Formula.Count - 1 Do
    Begin
      If (TStrUtils.fEmptyStr(TVariantUtils.IfNull(dicRetorno['base' + TStrUtils.fStrZero(intContador+1, 2)], ''))) Then
        Continue;

      Base := TBaseAutomotiva(Formula.Items[intContador]);

      Try
        fltFatorDensidade :=  fRetornaFatorDensidade(qryConsulta.FieldByName('FAR_TIPPRG').AsString ,
                                                    Base.QuantidadeConcentrado,
                                                    fRetornarDensidade(Base.CodigoBase));
      Except
        fltFatorDensidade :=  1;
      End;

      {SOMATORIO DA PORCENTAGEM}
      fltTotalPorcentagem := fltTotalPorcentagem + Base.QuantidadeConcentrado;

      {SOMATORIO DA DENSIDADE}
      fltTotalDensidade := fltTotalDensidade + fltFatorDensidade;
    End;

    Try
      fltTotalDensidade := fRetornaTotalDensidade(qryConsulta.FieldByName('FAR_TIPPRG').AsString, fltTotalPorcentagem, fltTotalDensidade);
    Except
      fltTotalDensidade := 1;
    End;

    For intContador := 0 To Formula.Count - 1 Do
    Begin
      If (TStrUtils.fEmptyStr(TVariantUtils.IfNull(dicRetorno['base' + TStrUtils.fStrZero(intContador + 1, 2)], ''))) Then
        Continue;

      Base := TBaseAutomotiva(Formula.Items[intContador]);


      Base.QuantidadeConcentrado := fArredondaValor(0.900 * fltTotalDensidade * (Base.QuantidadeConcentrado / 100) * 1000, fCasasDecimaisQtd(qryConsulta.FieldByName('FAR_TIPPRG').AsString));
    End;

    //DILUIDO
    fltTotalPorcentagem := 0;
    fltTotalDensidade   := 0;

    If (qryConsulta.FieldByName('FAR_LINHA_').AsString = 'PE') And (qryConsulta.FieldByName('FAR_TIPPRG').AsString = '3') Then
    Begin
      For intContador := 0 To Formula.Count  -1 Do
      Begin
        Base := TBaseAutomotiva(Formula.Items[intContador]);
        Base.QuantidadeDiluido := TBaseAutomotiva(Formula.Items[intContador]).QuantidadeDiluido;
      End;
    End
    Else
    Begin

      For intContador := 0 To Formula.Count  - 1 Do
      Begin
        If (TStrUtils.fEmptyStr(TVariantUtils.IfNull(dicRetorno['base' + TStrUtils.fStrZero(intContador + 1, 2)], ''))) Then
          Continue;

        Base := TBaseAutomotiva(Formula.Items[intContador]);

        {FATOR DA DENSIDADE}
        fltFatorDensidade :=  Base.QuantidadeDiluido / fRetornarDensidade(Base.CodigoBase);
        {SOMATORIO DA PORCENTAGEM}
        fltTotalPorcentagem := fltTotalPorcentagem + Base.QuantidadeDiluido;

        {SOMATORIO DA DENSIDADE}
        fltTotalDensidade := fltTotalDensidade + fltFatorDensidade;
      End;

      Try
        fltTotalDensidade := fltTotalPorcentagem / fltTotalDensidade;
      Except
        fltTotalDensidade := 1;
      End;

      For intContador := 0 To Formula.Count  - 1 Do
      Begin
        If (TStrUtils.fEmptyStr(TVariantUtils.IfNull(dicRetorno['base' + TStrUtils.fStrZero(intContador + 1, 2)], ''))) Then
          Continue;

        Base := TBaseAutomotiva(Formula.Items[intContador]);
        Base.QuantidadeDiluido := fArredondaValor(0.900 * fltTotalDensidade * (Base.QuantidadeDiluido / 100) * 1000, 5);
      End;
    End;
  End;
end;

procedure TLibTintaFarbenAutomotiva.pTintaRetornaTabelaPrecoGeneric(
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
      Formula.ProCha := TAutcomTintaFactory.Get.fGetConfTinta('FAR').fGet('PROCHA');

      PreencherPesCorFor(Formula, qryConsulta);
      pProcessaFormulacaoTabelaPreco(Formula, dicRetorno, qryConsulta);
      Formula.CodFormul := GetCodFormul(dicRetorno);


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


procedure TLibTintaFarbenAutomotiva.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL := 'SELECT FAR_CODSEQ '+
                    '     , FAR_DESCRI '+
                    '     , FAR_A_N_O_ '+
                    '     , FAR_LINHA_ '+
                    '     , FAR_CODMON '+
                    '     , FAR_DESMON '+
                    '     , FAR_CODNFM '+
                    '  FROM FAR_CADFAR '+
                    '  LEFT JOIN FAR_CADMON '+
                    '         ON FAR_CODMON = FAR_CODMON'+
                    ' WHERE FAR_MD5KEY = :ITETIN ';


      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

        dicRetorno['codtin'] := qryGen.FieldByName('FAR_CODSEQ').AsString;
        dicRetorno['montad'] := qryGen.FieldByName('FAR_CODMON').AsString;
        dicRetorno['a_n_o_'] := qryGen.FieldByName('FAR_A_N_O_').AsString;
        dicRetorno['martin'] := qryGen.FieldByName('FAR_LINHA_').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TLibTintaFarbenAutomotiva.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaFarbenAutomotiva.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
Var
  conf: IConfTinta;
begin
  conf  := TAutcomTintaFactory.Get.fGetConfTinta('FAR');

  If conf.fGet('FARPRE') = 'VEN' Then
    Result :=  TVariantUtils.IfNull(dicDados['unitar'],0) * conf.fGetDouble('FARFAT')
  Else
    Result :=  TVariantUtils.IfNull(dicDados['precus' ],0) * conf.fGetDouble('FARFAT');

  Result := TFloatUtils.fFormataFloat(Result, 2);
end;

function TLibTintaFarbenAutomotiva.fArredondaValor(fltValor: Double;
  intCasas: Integer): Double;
begin
  Result := TAutcomTintaFactory.Get.fStrToFloat(FormatFloat('0.' + TStrUtils.fStrZero(0, intCasas), fltValor));
end;

function TLibTintaFarbenAutomotiva.fCasasDecimaisQtd(
  strTipPrg: String): Integer;
begin
  Result := 5;
end;

function TLibTintaFarbenAutomotiva.fRetornaCodigoChapinhaGeneric(
  strIdePro: String): String;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta(strIdePro).fGet('PROCHA');
end;

function TLibTintaFarbenAutomotiva.fRetornaFatorDensidade(strTipPrg: String;
  fltQtdCon, fltPesEsp: Double): Double;
begin
  Result := fltQtdCon / fltPesEsp;
end;

function TLibTintaFarbenAutomotiva.fRetornarDensidade(
  strCodBas: String): Double;
var
  qryGen: IDataSet;
begin

 qryGen := nil;
  Result := 0;
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DENSID '+
                    '  FROM FAR_CADBAS '+
                    ' WHERE BAS_CODBAS = :CODBAS';
      qryGen.ParamByName('CODBAS').AsString := strCodBas;
      qryGen.Open;

      Result := qryGen.FieldByName('BAS_DENSID').AsFloat;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

function TLibTintaFarbenAutomotiva.fRetornaTotalDensidade(strTipPrg: String;
  fltPorcen, fltDensid: Double): Double;
begin
  Result := fltPorcen / fltDensid;

 { If MatchStr(strTipPrg, ['1', '2']) Then
    Result := fTruncaValor(fltPorcen / fltDensid, 2);}

end;

function TLibTintaFarbenAutomotiva.fTruncaValor(fltValor: Double;
  intCasas: Integer): Double;
begin
  Result := TAutcomTintaFactory.Get.fStrToFloat((FloatToStr(Int(fltValor)) ) + Copy(FloatToStr(Frac(fltValor)), 2, (intCasas + 1) ) );
end;

function TLibTintaFarbenAutomotiva.fUsaChapinhaTintaGeneric(strIdePro,
  strIteTin: String): Boolean;
Var
  qryConsulta: IDataSet;
begin
  Result := False;

  qryConsulta := TAutcomTintaFactory.Get.fGetDataSet;
  qryConsulta.SQL := '  SELECT FAR_PROCHA FROM FAR_CADFAR WHERE FAR_MD5KEY = :ITETIN  ';
  qryConsulta.ParamByName('ITETIN').AsString := strIteTin;
  qryConsulta.Open;

  If qryConsulta.IsEmpty Then
    Exit;

  Result := (qryConsulta.FieldByName('FAR_PROCHA').AsString = 'S');
end;

end.

