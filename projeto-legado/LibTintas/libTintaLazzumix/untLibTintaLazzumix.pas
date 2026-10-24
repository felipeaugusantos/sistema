{******************************************-*********************}
{* Classe contendo as informações especificas da tinta Lazzumix *}
{*******************************************-*****************AC*}
unit untLibTintaLazzumix;

interface

uses
{$IFNDEF LINUX}
  Controls,
{$ENDIF}
  untAbstractLibTintaAutomotiva, untAbstractFormulaAutomotiva,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem, untFloatUtils, untBaseAutomotiva,
  untStrUtils, untGTinForTipos, Classes;

type
  TLibTintaLazzumix = class(TAbstractLibTintaAutomotiva)
  private
    function fSelectBasesEmpresa(strCodEmp: String): String;
  protected
    function GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva; override;
    function GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string; override;
    function GetSQLBasesEmpGTinFor(const strBases: String; Const dicDados: IDicionario): String; override;

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

    procedure pProcessaBaixaPigmentosGTinFor(qryBases: IDataSet; intPos: Integer; Var List: TStringList;
      arrBaixaPigmentos: TBaixaPigmentosArray; dicBases: IDicionario; Const dicDados: IDicionario; strBases: String); Override;

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
    procedure pRetItemColorante(const strColTinDet: String; Var strCodIte, strCodBas, strDesBas: String; const strCodEmp: String); Override;
    procedure pTintaRetornaTabelaPrecoGeneric(dicRetorno: IDicionario; fltFatorAcerto: Double); Override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemLazzumix,
{$ENDIF}
  untFormulaAutomotivaLazzumix, untTintadeMaquinaWrapperLazzumix, untAutcomTintaFactory, untVariantUtils, untICalculadorFatVendasLibTintas,
  untModoVenda;

{ TLazzumixTintadeMaquina }

function TLibTintaLazzumix.fSelectBasesEmpresa(strCodEmp: String): String;
begin
  Result := ' SELECT              ';
  Result := Result + '    BAS_CODITE,     ';
  Result := Result + '    BAS_CODBAS      ';
  Result := Result + ' FROM       ';
  Result := Result + '    LAZ_BASEMP      ';
  Result := Result + ' WHERE BAS_CODBAS = :BAS_CODBAS   ';
  Result := Result + '  AND BAS_CODEMP = "' + strCodEmp + '"  ';
end;

function TLibTintaLazzumix.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESBAS';
end;

function TLibTintaLazzumix.GetCodFormul(const dicRetorno: IDicionario): string;
begin
  Result := '';
end;

function TLibTintaLazzumix.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaLazzumix.Create(strTabPre);
end;

function TLibTintaLazzumix.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperLazzumix.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaLazzumix.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemLazzumix.Create();
{$ENDIF}
end;

function TLibTintaLazzumix.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORLAZ';
end;

function TLibTintaLazzumix.GetNomeTinta: String;
begin
  Result := 'Lazzumix';
end;

function TLibTintaLazzumix.GetPrefixoTabela: String;
begin
  Result := 'MIX';
end;

function TLibTintaLazzumix.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String = ''): String;
begin
  Result := '';
end;

function TLibTintaLazzumix.GetSQLBasesEmpGTinFor(const strBases: String;
  const dicDados: IDicionario): String;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    BAS_CODBAS,         ';
  Result := Result + '    BAS_CODITE          ';
  Result := Result + '  FROM                  ';
  Result := Result + '    LAZ_BASEMP          ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    BAS_CODBAS IN (' + strBases + ')  AND         ';
  Result := Result + '    BAS_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '"  AND     ';
  Result := Result + '    BAS_CODITE IS NOT NULL      ';
end;

function TLibTintaLazzumix.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   BAS_CODBAS                                ' +
    '   , BAS_CODITE                              ' +
    ' FROM                                        ' +
    '   LAZ_CADBAS                                ' +
    ' WHERE BAS_CODBAS IN (' + strBases + ') ';
end;

function TLibTintaLazzumix.GetVolumeConcentrado: Double;
begin
  Result := 1;
end;

function TLibTintaLazzumix.GetVolumeDiluido: Double;
begin
  Result := 1;
end;

function TLibTintaLazzumix.GetVolumeOriginal(const dicRetorno: IDicionario): Double;
begin
  Result := 1;
end;

function TLibTintaLazzumix.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := 1;
end;

procedure TLibTintaLazzumix.pProcessaBaixaPigmentosGTinFor(qryBases: IDataSet;
  intPos: Integer; var List: TStringList;
  arrBaixaPigmentos: TBaixaPigmentosArray; dicBases: IDicionario;
  const dicDados: IDicionario; strBases: String);
Var
  qryBasEmp: IDataSet;
  strBasEmp: String;
begin
  qryBasEmp := TAutcomTintaFactory.Get.fGetDataSet;
  qryBasEmp.Close;
  qryBasEmp.SQL := GetSQLBasesEmpGTinFor(strBases, dicDados);
  qryBasEmp.Open;

  While Not (qryBasEmp.Eof) Do
  Begin

    If dicBases[qryBasEmp.FieldByName('BAS_CODBAS').AsString] <= 0 Then
    Begin
      qryBasEmp.Next;
      Continue;
    End;

    List.Add(qryBasEmp.FieldByName(GetNomeCampoBaseCodIte).AsString);
    arrBaixaPigmentos[intPos].strCodIte   := qryBasEmp.FieldByName(GetNomeCampoBaseCodIte).AsString;
    arrBaixaPigmentos[intPos].fltQtdBaixa := dicBases[qryBasEmp.FieldByName('BAS_CODBAS').AsString];
    arrBaixaPigmentos[intPos].strFormul   := GetFormulArrBaixaPigmentos(qryBases);
    arrBaixaPigmentos[intPos].strPesGra   := GetPesGraArrBaixaPigmentos(qryBases);
    arrBaixaPigmentos[intPos].fltEmbBas   := GetEmbalaArrBaixaPigmentos(qryBases);

    strBasEmp := strBasEmp + '"' + qryBasEmp.FieldByName('BAS_CODBAS').AsString + '", ';
    Inc(intPos);
    qryBasEmp.Next;
  End;

  While Not qryBases.Eof Do
  Begin
    If Pos(qryBases.FieldByName('BAS_CODBAS').AsString, strBasEmp) > 0 Then
    Begin
      qryBases.Next;
      Continue;
    End;

    If fRetornaQuantidadeBaixaGTinFor(dicBases, qryBases) <= 0 Then
    Begin
      qryBases.Next;
      Continue;
    End;

    List.Add(qryBases.FieldByName(GetNomeCampoBaseCodIte).AsString);
    arrBaixaPigmentos[intPos].strCodIte   := qryBases.FieldByName(GetNomeCampoBaseCodIte).AsString;
    arrBaixaPigmentos[intPos].fltQtdBaixa := fRetornaQuantidadeBaixaGTinFor(dicBases, qryBases);
    arrBaixaPigmentos[intPos].strFormul   := GetFormulArrBaixaPigmentos(qryBases);
    arrBaixaPigmentos[intPos].strPesGra   := GetPesGraArrBaixaPigmentos(qryBases);
    arrBaixaPigmentos[intPos].fltEmbBas   := GetEmbalaArrBaixaPigmentos(qryBases);

    Inc(intPos);
    qryBases.Next;
  End;
end;

procedure TLibTintaLazzumix.pProcessaFormulacaoGTinFor(
  Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet; dicBases: IDicionario;
  Const Formula: TAbstractFormulaAutomotiva; Const dicDados: IDicionario; var strBases: String);
var
  intCont: Integer;
  intQtd: Integer;
begin
  intQtd := 1;

  For intCont := 1 To formula.GetQuantidadeFormulacao Do
  Begin
    If qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicDados['tippre']) + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 Then
      Continue;

    arrFormul[intQtd].strFormul := qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2)).AsString;
    arrFormul[intQtd].fltQtdbas := (qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicDados['tippre']) + TStrUtils.fStrZero(intCont, 2)).AsFloat) *
                                    (dicDados['volpro'] * 1000) /
                                    qryConsulta.FieldByName(formula.GetPrefixoLitragem(dicDados['tippre'])).AsString;

    arrFormul[intQtd].fltQtdbas := TFloatUtils.fFormataFloatLaz(arrFormul[intQtd].fltQtdBas);

    dicBases[arrFormul[intQtd].strFormul] := arrFormul[intQtd].fltQtdbas;

    strBases := strBases + QuotedStr(arrFormul[intQtd].strFormul);
    If (Not TStrUtils.fEmptyStr(arrFormul[intQtd].strFormul)) Then
      strBases := strBases + ', ';

    Inc(intQtd);
  End;
end;

procedure TLibTintaLazzumix.pProcessaFormulacaoTabelaPreco(
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
      Base.QuantidadeConcentrado := TFloatUtils.fFormataFloat(dicRetorno['qtdb' + TStrUtils.fStrZero(intContador, 2)], 3)
    Else
      Base.QuantidadeDiluido     := TFloatUtils.fFormataFloat(dicRetorno['qtdb' + TStrUtils.fStrZero(intContador, 2)], 3);
    Base.TipoBase := 'B';
  End;
end;

procedure TLibTintaLazzumix.pRetItemColorante(const strColTinDet: String;
  var strCodIte, strCodBas, strDesBas: String; const strCodEmp: String);
var
  dataSet: IDataSet;
begin
  dataSet := nil;
  strCodIte := '';
  strCodBas := '';
  Try
    Try
      dataSet := TAutcomTintaFactory.Get().fGetDataSet;
      dataSet.SQL:= fSelectBasesEmpresa(strCodEmp);
      SetaParametrosRetComponentes(dataSet, strColTinDet);
      dataSet.Open;

      If Not DataSet.IsEmpty Then
      Begin
        strCodIte := dataSet.FieldByName(GetCampoComponenteCodIte).AsString;
        strCodBas := dataSet.FieldByName(GetCampoComponenteCodComp).AsString;
      End;

      dataSet.Close;
      DataSet.SQL := GetInstrucaoRetComponentes(strCodEmp);
      SetaParametrosRetComponentes(dataSet, strColTinDet);
      dataSet.Open;

      If TStrUtils.fEmptyStr(strCodIte) Then
        strCodIte := dataSet.FieldByName(GetCampoComponenteCodIte).AsString;

      If TStrUtils.fEmptyStr(strCodBas) Then
        strCodBas := dataSet.FieldByName(GetCampoComponenteCodComp).AsString;

      strDesBas := dataSet.FieldByName('DESBAS').AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    dataSet := nil;
  End;
end;

procedure TLibTintaLazzumix.pTintaRetornaTabelaPrecoGeneric(
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

          dicRetorno['preve' + strTabelaUnica + '_original'] := dicRetorno['preve' + strTabelaUnica];
        End
        Else
        Begin
          dicRetorno['precu2'] := Formula.PrecoCustoRealDil + Formula.EmbPrecoCustoReal;

          If TAutcomTintaFactory.Get.fGetConfTinta(Self.GetIdePro).fGet('ACRMOB') = '1' Then
            dicRetorno['preve' + strTabelaUnica] := (Formula.PrecoVendaDil + Formula.EmbPrecoVenda) * (1 + Formula.AcrMob / 100)
          Else
            dicRetorno['preve' + strTabelaUnica] := Formula.PrecoVendaDil + Formula.EmbPrecoVenda + Formula.AcrMob;

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
        raise Exception.Create(E.Message);
      end;
    End;
  Finally
    TAutcomTintaFactory.Get.pSetaEmpresaLogadaTinta(strCodEmp);
  End;
end;

procedure TLibTintaLazzumix.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL := 'SELECT * ' +
                    '  FROM LAZ_CADMIX  ' +
                    ' WHERE MIX_CODIGO = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('MIX_CODIGO').AsString;
      dicRetorno['montad'] := qryGen.FieldByName('MIX_MONTAD').AsString;
      dicRetorno['martin'] := qryGen.FieldByName('MIX_REFERE').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TLibTintaLazzumix.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := dtsTinta.FieldByName('MIX_REFERE').AsString;
end;

function TLibTintaLazzumix.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
  Var
    strTraLazzumix: String;
    fltTraLazzumix: Double;
    conf: IConfTinta;
Begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('LAZ');

  If (dicDados['tippre'] = 'C') Then
  Begin
    strTraLazzumix := TAutcomTintaFactory.Get.IIF(conf.fGet('TRACLZ') = '1', 'VEN', 'CUS');
    fltTraLazzumix := conf.fGetDouble('FATCLZ');
  End
  Else
  Begin
    strTraLazzumix := TAutcomTintaFactory.Get.IIF(conf.fGet('TRADLZ') = '3', 'VEN', 'CUS');
    fltTraLazzumix := conf.fGetDouble('FATDLZ');
  End;

  If (strTraLazzumix = 'VEN') Then
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0);

  Result := TFloatUtils.fFormataFloat(Result * fltTraLazzumix, 2);
end;

end.
