{************************************************************************}
{* Classe contendo as informações especificas da tinta AdvanceStr *}
{*********************************************************************AC*}
unit untLibTintaAdvanceStr;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem, untGTinForTipos, Classes;

type
  TLibTintaAdvanceStr = class(TAbstractLibTintaImobiliaria)
  Private
    function RetornaPesoEspecifico(strFormul: String): Double;
  protected
    function GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria; override;
    function GetSQLColorantesGTinFor(const strColorantes: string): string; override;
  public
    function GetNomeTinta: String; override;
    function GetITintadeMaquina(): ITintadeMaquinaWrapper; override;
    function RetornaReferenciaTinta(const dtsTinta: IDataSet): String; override;
    function RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double; override;
    procedure RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario); override;
    procedure pTintaRetornaTabPrecoImobiliaria(dicRetorno: IDicionario; fltFatorAcerto: Double); Override;
    function GetMenu: IAuttinMenuItem; override;
    function GetQuantidadeOncaPulsoMl(const fltPulsos: Double; var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String = ''): String; override;
    function GetNomeTabelaFormulacao: String; override;
    function GetCampoComponenteDesComp(): String; override;
    function GetQuantidadeMlPulso(const fltValor: Double; intDecFor: Integer; strFormul: String): String; Override;
    function GetQuantidadeGramaMl(const fltValor: Double; const Fator: Double; strFormula: String): Double; Override;
    function GetPrefixoTabela(): String; Override;
    function fGTinForGer(var arrFormul: TForMulTinDetArray; var arrBaixaPigmentos: TBaixaPigmentosArray; const dicDados: IDicionario): Boolean; Override;


  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemAdvanceStr,
{$ENDIF}
  untFormulaImobiliariaAdvanceStr, untTintadeMaquinaWrapperAdvanceStr, untAutcomTintaFactory, untVariantUtils,
  untMultiSelectLocalizadorFactory, untStrUtils, StrUtils, untColorante, untICalculadorFatVendasLibTintas, untFloatUtils;

{ TAdvanceStrTintadeMaquina }

function TLibTintaAdvanceStr.fGTinForGer(var arrFormul: TForMulTinDetArray;
  var arrBaixaPigmentos: TBaixaPigmentosArray;
  const dicDados: IDicionario): Boolean;
var
  qryConsulta: IDataSet;
  intCont: Integer;
  formula: TAbstractFormulaImobiliaria;
  dicColorantes: IDicionario;
  strColorantes: string;
  qryColorantes: IDataSet;
  intPos: Integer;
  stlItensTraMl: TStringList;
begin
  Result := False;
  stlItensTraMl := nil;

  Try
    Try
      TMultiSelectLocalizadorFactory.GetLocalizador(dicDados['idepro']).Localizar(qryConsulta, ['ITETIN'], [TVariantUtils.IfNull(dicDados['itetin'], '')]);

      Result := Not qryConsulta.IsEmpty;

      If Not Result Then
        Exit;

      Formula := GetFormulaImobiliaria();
      dicColorantes := TAutcomTintaFactory.Get.GetDicionario;

      For intCont := 1 To formula.GetQuantidadeFormulacao Do
      Begin

        arrFormul[intCont].strFormul := qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2)).AsString;

        If (TAutcomTintaFactory.Get.fGetConfTinta('ADS').fGet('MOVEST') = 'GR') Or (TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fGetConfTinta('ADS').fGet('MOVEST'))) Then
          arrFormul[intCont].fltQtdbas := formula.GetQuantidadeDadosTintometricos(qryConsulta, formula.GetPrefixoQuantidade(''), TStrUtils.fStrZero(intCont, 2)) * GetFatorEstoque
        Else
          arrFormul[intCont].fltQtdbas := (formula.GetQuantidadeDadosTintometricos(qryConsulta, Formula.GetPrefixoQuantidade(''), TStrUtils.fStrZero(intCont, 2)) /
            RetornaPesoEspecifico(arrFormul[intCont].strFormul)) * GetFatorEstoque;

        dicColorantes[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;

        strColorantes := strColorantes + QuotedStr(arrFormul[intCont].strFormul);
        If (Not TStrUtils.fEmptyStr(arrFormul[intCont].strFormul)) Then
        Begin
          strColorantes := strColorantes + ', ';
        End;
      End;

      strColorantes := Trim(strColorantes);
      If (RightStr(strColorantes, 1) = ',') Then
        strColorantes := Copy(strColorantes, 1, Length(strColorantes)-1);

      qryColorantes := TAutcomTintaFactory.Get.fGetDataSet;
      qryColorantes.Close;
      qryColorantes.SQL := GetSQLColorantesGTinFor(strColorantes);
      qryColorantes.Open;

      intPos := 0;
      stlItensTraMl := TStringList.Create;
      qryColorantes.First;
      SetLength(arrBaixaPigmentos, qryColorantes.RecordCount);

      While Not qryColorantes.Eof Do
      begin

        stlItensTraMl.Add(qryColorantes.FieldByName(GetNomeCampoColoranteCodIte).AsString);
        arrBaixaPigmentos[intPos].strCodIte   := qryColorantes.FieldByName(GetNomeCampoColoranteCodIte).AsString;
        arrBaixaPigmentos[intPos].fltQtdBaixa := fRetornaQuantidadeBaixaPigmentos(dicColorantes[qryColorantes.FieldByName(GetNomeCampoColoranteCodCol).AsString], qryColorantes);

        Inc(intPos);
        qryColorantes.Next;
      end;

      dicDados['stlItensTraMl'] := stlItensTraMl.Text;
      Result := True;
    Except
      On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally
    If Assigned(stlItensTraMl) Then
      FreeAndNil(stlItensTraMl);
  End;
end;

function TLibTintaAdvanceStr.GetCampoComponenteDesComp(): String;
begin
  Result := 'COL_DESCRI';
end;

function TLibTintaAdvanceStr.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaAdvanceStr.Create(strTabPre);
end;

function TLibTintaAdvanceStr.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperAdvanceStr.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaAdvanceStr.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemAdvanceStr.Create();
{$ENDIF}
end;

function TLibTintaAdvanceStr.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORADS';
end;

function TLibTintaAdvanceStr.GetNomeTinta: String;
begin
  Result := 'Advance Str';
end;

function TLibTintaAdvanceStr.GetPrefixoTabela: String;
begin
  Result := 'ADS';
end;

function TLibTintaAdvanceStr.GetQuantidadeGramaMl(const fltValor, Fator: Double;
  strFormula: String): Double;
Var
  fltPesoEspecifico: Double;
begin
  If (TAutcomTintaFactory.Get.fGetConfTinta('ADS').fGet('MOVEST') = 'GR') Or (TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fGetConfTinta('ADS').fGet('MOVEST'))) Then
  Begin
    fltPesoEspecifico := RetornaPesoEspecifico(strFormula);
    Result := fltValor / fltPesoEspecifico;
  End
  Else
  Begin
    Result := fltValor * Fator;
  End;
end;

function TLibTintaAdvanceStr.GetQuantidadeMlPulso(const fltValor: Double;
  intDecFor: Integer; strFormul: String): String;
Var
  fltPesoEspecifico: Double;
begin
  fltPesoEspecifico := RetornaPesoEspecifico(strFormul);

  If (TAutcomTintaFactory.Get.fGetConfTinta('ADS').fGet('MOVEST') = 'GR') Or (TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fGetConfTinta('ADS').fGet('MOVEST'))) Then
    Result := FloatToStrF(fltValor, ffNumber, 12, intDecFor)
  Else
    Result := FloatToStrF(fltValor * fltPesoEspecifico, ffNumber, 12, intDecFor);
end;

function TLibTintaAdvanceStr.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String) : String;
Var
  fltPesoEspecifico: Double;
  fltQuantidade: Double;
  fltCalculo,
  fltInteiroOnca,
  fltFracaoOnca: Double;
begin
  Result := '';

  If (TAutcomTintaFactory.Get.fGetConfTinta('ADS').fGet('MOVEST') = 'GR') Or (TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fGetConfTinta('ADS').fGet('MOVEST'))) Then
  Begin
    fltPesoEspecifico := RetornaPesoEspecifico(strFormul);
    fltQuantidade := fltPulsos / fltPesoEspecifico;
    fltCalculo     := (fltQuantidade / 48) / 0.61611520;
    fltInteiroOnca := Trunc(fltCalculo);
    fltFracaoOnca  := TAutcomTintaFactory.Get.fStrToFloat(FormatFloat('0.000', (fltCalculo - fltInteiroOnca) * 48));
    Result := Format('%dY%.1f', [Trunc(fltInteiroOnca), fltFracaoOnca]);
  End
  Else
  Begin
    fltQuantidade := fltPulsos;
    fltCalculo     := (fltQuantidade / 48) / 0.61611520;
    fltInteiroOnca := Trunc(fltCalculo);
    fltFracaoOnca  := TAutcomTintaFactory.Get.fStrToFloat(FormatFloat('0.000', (fltCalculo - fltInteiroOnca) * 48));
    Result := Format('%dY%.1f', [Trunc(fltInteiroOnca), fltFracaoOnca]);
  End;
end;

function TLibTintaAdvanceStr.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   ADS_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaAdvanceStr.pTintaRetornaTabPrecoImobiliaria(
  dicRetorno: IDicionario; fltFatorAcerto: Double);
var
  formula: TAbstractFormulaImobiliaria;
  intCols: Integer;
  colorante: TColorante;
  calculadorFatVendas: ICalculadorFatVendasLibTintas;
  qryTintas: IDataSet;
  strCodEmp: String;
begin
  Try
    Try
      If Not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendasLibTintas, calculadorFatVendas) Then
        calculadorFatVendas := Nil;

      formula := GetFormulaImobiliaria(TVariantUtils.IfNull(dicRetorno['tabpre'], '1'));
      formula.calculadorFatVendas := calculadorFatVendas;
      formula.OpcDoc := TVariantUtils.IfNull(dicRetorno['opcdoc'], '');
      formula.CodCli := TVariantUtils.IfNull(dicRetorno['codcli'], '');
      formula.PrzMed := TVariantUtils.IfNull(dicRetorno['przmed'], '0');
      formula.CodCnd := TVariantUtils.IfNull(dicRetorno['codcnd'], '');
      formula.ProPre := TVariantUtils.IfNull(dicRetorno['propre'], False);
      formula.EmpPrd := TVariantUtils.IfNull(dicRetorno['empprd'], '');
      formula.OprFlj := TVariantUtils.IfNull(dicRetorno['oprflj'], '');
      Formula.EmpCd_ := TVariantUtils.IfNull(dicRetorno['emp_cd'], '');
      Formula.Cd_S_N := TVariantUtils.IfNull(dicRetorno['Cd_S_N'], '');
      Formula.EmpFat := TVariantUtils.IfNull(dicRetorno['empfat'], '');
      Formula.FatS_N := TVariantUtils.IfNull(dicRetorno['FatS_N'], '');
      strCodEmp := TAutcomTintaFactory.Get.GetCodEmp;
      TAutcomTintaFactory.Get.pSetaEmpresaLogadaTinta(Formula.fVerificaEmpresaSetada);
      formula.ItemBaseOriginal := formula.GetItemBaseOriginal(dicRetorno['itetin']);

      If Not TStrUtils.fEmptyStr(GetPrefixoTabela) Then
      Begin
        If fRetornaFormulacaoParaTabelaPreco(dicRetorno, qryTintas) Then
        Begin
          If Assigned(qryTintas.FindField(GetPrefixoTabela + '_ACRMOB')) Then
            Formula.AcrMob := qryTintas.FieldByName(GetPrefixoTabela + '_ACRMOB').AsFloat
          Else
            Formula.AcrMob := 0;
        End;
      End
      Else
        Formula.AcrMob := 0;


      For intCols := 1 To formula.GetQuantidadeFormulacao Do
      begin
        If (TStrUtils.fEmptyStr(TVariantUtils.IfNull(dicRetorno['base' + TStrUtils.fStrZero(intCols, 2)], ''))) Then
          Break;

        colorante := TColorante(formula.Add);
        colorante.CodigoColorante := dicRetorno['base' + TStrUtils.fStrZero(intCols, 2)];

        If (TAutcomTintaFactory.Get.fGetConfTinta('ADS').fGet('MOVEST') = 'GR') Or (TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fGetConfTinta('ADS').fGet('MOVEST'))) Then
          colorante.Quantidade := TFloatUtils.fFormataFloat(dicRetorno['qtdb' + TStrUtils.fStrZero(intCols, 2)]  / formula.FatorEstoque, 3)
        Else
          colorante.Quantidade := TFloatUtils.fFormataFloat((dicRetorno['qtdb' + TStrUtils.fStrZero(intCols, 2)] * RetornaPesoEspecifico(colorante.CodigoColorante)) / formula.FatorEstoque, 3);

        colorante.Tipo := tciColorante;
      end;

      formula.ItemBase := TVariantUtils.IfNull(dicRetorno['itebas'], '');
      dicRetorno['desopetinta'] := TAutcomTintaFactory.Get.fGetConfTinta(dicRetorno['idepro']).fGetDouble('DESOPE');
      formula.RecalcularTabelas(dicRetorno);

      dicRetorno['precus'] := formula.PrecoCusto + formula.BasePrecoCusto;
      dicRetorno['precu2'] := formula.PrecoCustoReal + formula.BasePrecoCustoReal;
      dicRetorno['premed'] := formula.PrecoMedio + formula.BasePrecoMedio;
      dicRetorno['preult'] := formula.UltimoPrecoCompra + formula.BasePrecoUltimaCompra;
      dicRetorno['impult'] := formula.UltimoPrecoCompraImpostos + formula.BasePrecoUltimaCompraImpostos;
      dicRetorno['prctin'] := formula.PrecoCompraLiquido + formula.BasePrecoCompraLiquido;

      dicRetorno.AdicionarObjeto('tintaDeMaquina', formula.tintaDeMaquina);
    Except
      On E: Exception Do
        Raise;
    End;
  Finally
    TAutcomTintaFactory.Get.pSetaEmpresaLogadaTinta(strCodEmp);
  End;
end;

procedure TLibTintaAdvanceStr.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL :=
        ' SELECT                     ' +
        '   *                        ' +
        ' FROM                       ' +
        '   ADS_CADADS            ' +
        ' WHERE ADS_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('ADS_CODIGO').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

function TLibTintaAdvanceStr.RetornaPesoEspecifico(strFormul: String): Double;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   SELECT COL_PESESP FROM ADS_CADCOL WHERE COL_CODCOL = :CODCOL    ';
  qryGen.ParamByName('CODCOL').AsString := strFormul;
  qryGen.Open;

  If qryGen.IsEmpty Then
    Result := 1
  Else
    Result := qryGen.FieldByName('COL_PESESP').AsFloat;
end;

function TLibTintaAdvanceStr.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaAdvanceStr.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('ADS');

  strSiglaTrava := conf.fGet('TRAADS');
  fltFatTrava   := conf.fGetDouble('FATADS');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
