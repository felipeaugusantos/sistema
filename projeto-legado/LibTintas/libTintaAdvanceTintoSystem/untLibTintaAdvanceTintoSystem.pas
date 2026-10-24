{************************************************************************}
{* Classe contendo as informações especificas da tinta AdvanceTintoSystem *}
{*********************************************************************AC*}
unit untLibTintaAdvanceTintoSystem;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem, untGTinForTipos;

type
  TLibTintaAdvanceTintoSystem = class(TAbstractLibTintaImobiliaria)
  Private
    function fPesoEspecificoCadBas(strCodBas, strCodEmb: String): Double;
  protected
    function GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria; override;
    function GetSQLColorantesGTinFor(const strColorantes: string): string; override;
    function GetSQLBaseCataliGTinFor(const strColorantes: string; strCatalisador: String): String; override;
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
    function fGTinForGer(var arrFormul: TForMulTinDetArray; var arrBaixaPigmentos: TBaixaPigmentosArray; const dicDados: IDicionario): Boolean; Override;
    function GetQuantidadeGramaMl(const fltValor: Double; const Fator: Double; strFormula: String): Double; Override;

  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemAdvanceTintoSystem,
{$ENDIF}
  untFormulaImobiliariaAdvanceTintoSystem, untTintadeMaquinaWrapperAdvanceTintoSystem, untAutcomTintaFactory, untVariantUtils,  Classes,
  untMultiSelectLocalizadorFactory, untStrUtils, StrUtils, untColorante, untICalculadorFatVendasLibTintas, untFloatUtils;

{ TAdvanceTintoSystemTintadeMaquina }

function TLibTintaAdvanceTintoSystem.fGTinForGer(
  var arrFormul: TForMulTinDetArray;
  var arrBaixaPigmentos: TBaixaPigmentosArray;
  const dicDados: IDicionario): Boolean;
Var
  qryConsulta: IDataSet;
  qryCadBas: IDataSet;
  intCont: Integer;
  formula: TAbstractFormulaImobiliaria;
  dicColorantes: IDicionario;
  strColorantes: string;
  qryColorantes: IDataSet;
  intPos: Integer;
  stlItensTraMl: TStringList;
  fltFator: Double;
  intCatali: Integer;
  strCatalisador: String;
begin
  Result := False;
  stlItensTraMl := nil;

  Try
    Try
      TMultiSelectLocalizadorFactory.GetLocalizador(dicDados['idepro']).Localizar(qryConsulta, ['ITETIN'], [TVariantUtils.IfNull(dicDados['itetin'], '')]);

      Result := Not qryConsulta.IsEmpty;

      If Not Result Then
        Exit;

      fltFator := 1;
      qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadBas.SQL := ' SELECT                     ' +
                         '   BAS_CODEMB               ' +
                         '   , BAS_CONTEU             ' +
                         ' FROM                       ' +
                         '   ADT_CADBAS               ' +
                         ' WHERE BAS_CODBAS = :CODBAS ';
      qryCadBas.ParamByName('CODBAS').AsString := qryConsulta.FieldByName('ADT_CODBAS').AsString;
      qryCadBas.Open;

      If qryCadBas.Locate('BAS_CODEMB', qryConsulta.FieldByName('ADT_CODEMB').AsString, []) Then
      Begin
        fltFator := qryCadBas.FieldByName('BAS_CONTEU').AsFloat;
        If qryCadBas.Locate('BAS_CODEMB', dicDados['tipcor'], []) Then
          fltFator := qryCadBas.FieldByName('BAS_CONTEU').AsFloat / fltFator
        Else
          Raise Exception.CreateFmt('A base não foi encontrada [%s - %s]', [qryConsulta.FieldByName('ADT_CODBAS').AsString, dicDados['tipcor']]);
      End;

      Formula := GetFormulaImobiliaria();
      dicColorantes := TAutcomTintaFactory.Get.GetDicionario;
      intCatali := 1;

      For intCont := 1 To Formula.GetQuantidadeFormulacao Do
      Begin
        arrFormul[intCont].strFormul := qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2)).AsString;
        arrFormul[intCont].fltQtdbas := formula.GetQuantidadeDadosTintometricos(qryConsulta, formula.GetPrefixoQuantidade(''), TStrUtils.fStrZero(intCont, 2)) * fltFator;
        dicColorantes[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;
        strColorantes := strColorantes + QuotedStr(arrFormul[intCont].strFormul);

        If (Not TStrUtils.fEmptyStr(arrFormul[intCont].strFormul)) Then
        Begin
          strColorantes := strColorantes + ', ';
          intCatali := intCatali + 1;
        End;
      End;

      Formula.UsaCatalisador := dicDados['catalize'] = 'S';
      Formula.dtsCadTin := qryConsulta;

      If formula.UsaCatalisador Then
      Begin
        If Not TStrUtils.fEmptyStr(formula.GetPrefixoFormulacaoCatalisador) Then
        Begin
          If Not (TStrUtils.fEmptyStr(qryConsulta.FieldByName(Formula.GetPrefixoFormulacaoCatalisador).AsString)) And
          (qryConsulta.FieldByName(formula.GetPrefixoQuantidadeCatalisador).AsFloat > 0 ) Then
          Begin
            arrFormul[intCatali].strFormul := qryConsulta.FieldByName(Formula.GetPrefixoFormulacaoCatalisador).AsString;
            arrFormul[intCatali].fltQtdbas := qryConsulta.FieldByName(Formula.GetPrefixoQuantidadeCatalisador).AsFloat;
            dicColorantes[arrFormul[intCatali].strFormul] := arrFormul[intCatali].fltQtdbas;

            strCatalisador := QuotedStr(arrFormul[intCatali].strFormul);
          End;
        End;
      End;

      strColorantes := Trim(strColorantes);
      If (RightStr(strColorantes, 1) = ',') Then
        strColorantes := Copy(strColorantes, 1, Length(strColorantes)-1);

      qryColorantes := TAutcomTintaFactory.Get.fGetDataSet;
      qryColorantes.Close;

      If formula.UsaCatalisador Then
      Begin
        If Not TStrUtils.fEmptyStr(Formula.GetPrefixoFormulacaoCatalisador) Then
        Begin
          If Not (TStrUtils.fEmptyStr(qryConsulta.FieldByName(Formula.GetPrefixoFormulacaoCatalisador).AsString)) And
            (qryConsulta.FieldByName(formula.GetPrefixoQuantidadeCatalisador).AsFloat > 0 ) Then
            qryColorantes.SQL := GetSQLBaseCataliGTinFor(strColorantes, strCatalisador)
          Else
            qryColorantes.SQL := GetSQLColorantesGTinFor(strColorantes);
        End;
      End
      Else
        qryColorantes.SQL := GetSQLColorantesGTinFor(strColorantes);


      If formula.UsaCatalisador Then
      Begin
        If Not (TStrUtils.fEmptyStr(qryConsulta.FieldByName(Formula.GetPrefixoFormulacaoCatalisador).AsString)) And
            (qryConsulta.FieldByName(formula.GetPrefixoQuantidadeCatalisador).AsFloat > 0 ) Then
            qryColorantes.ParamByName('CODEMB').AsString := qryConsulta.FieldByName('ADT_CODEMB').AsString;
      End;

      qryColorantes.Open;

      // Converter quantidade  para gramas Advance tintosystem...
      For intCont := 1 To formula.GetQuantidadeFormulacao Do
      Begin

        If TStrUtils.fEmptyStr(arrFormul[intCont].strFormul) Then
          Break;

        If Not qryColorantes.Locate('COL_CODCOL', arrFormul[intCont].strFormul, []) Then
          If qryColorantes.FieldByName('CATALI').AsString = 'N' Then
            Raise Exception.CreateFmt('O colorante %s não está cadastrado! Verificar', [dicColorantes[arrFormul[intCont].strFormul]])
          Else
            Raise Exception.CreateFmt('O catalisador %s não está cadastrado! Verificar!', [dicColorantes[arrFormul[intCont].strFormul]]);

        arrFormul[intCont].fltQtdbas := arrFormul[intCont].fltQtdbas * qryColorantes.FieldByName('COL_PESESP').AsFloat;
        dicColorantes[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;
      End;

      intPos := 0;
      stlItensTraMl := TStringList.Create;
      qryColorantes.First;
      SetLength(arrBaixaPigmentos, qryColorantes.RecordCount);

      While Not qryColorantes.Eof Do
      Begin
        If qryColorantes.FieldByName('CATALI').AsString = 'S' Then
        Begin
          stlItensTraMl.Add(qryColorantes.FieldByName('COL_CODITE').AsString);
          arrBaixaPigmentos[intPos].strCodIte   := qryColorantes.FieldByName('COL_CODITE').AsString;
          arrBaixaPigmentos[intPos].fltQtdBaixa := fRetornaQuantidadeBaixaPigmentos(dicColorantes[qryColorantes.FieldByName('COL_CODCOL').AsString], qryColorantes);
          arrBaixaPigmentos[intPos].strTipComp := 'CT';
        End
        Else
        Begin
          stlItensTraMl.Add(qryColorantes.FieldByName(GetNomeCampoColoranteCodIte).AsString);
          arrBaixaPigmentos[intPos].strCodIte   := qryColorantes.FieldByName(GetNomeCampoColoranteCodIte).AsString;
          arrBaixaPigmentos[intPos].fltQtdBaixa := fRetornaQuantidadeBaixaPigmentos(dicColorantes[qryColorantes.FieldByName(GetNomeCampoColoranteCodCol).AsString], qryColorantes);
          arrBaixaPigmentos[intPos].strTipComp := 'C'
        End;

        Inc(intPos);
        qryColorantes.Next;
      End;

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

function TLibTintaAdvanceTintoSystem.fPesoEspecificoCadBas(strCodBas,
  strCodEmb: String): Double;
Var
  qryCadBas: IDataSet;
begin
  qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadBas.Close;
  qryCadBas.SQL := ' SELECT                   ' +
    '   BAS_PESESP FROM ADT_CADBAS            ' +
    '                WHERE                    ' +
    '   BAS_CODBAS = :CODBAS AND              ' +
    '   BAS_CODEMB = :CODEMB                  ' ;

  qryCadBas.ParamByName('CODBAS').AsString := strCodBas;
  qryCadBas.ParamByName('CODEMB').AsString := strCodEmb;
  qryCadBas.Open;

  Result := qryCadBas.FieldByName('BAS_PESESP').AsFloat;
end;

function TLibTintaAdvanceTintoSystem.GetCampoComponenteDesComp(): String;
begin
  Result := 'COL_DESCRI';
end;

function TLibTintaAdvanceTintoSystem.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaAdvanceTintoSystem.Create(strTabPre);
end;

function TLibTintaAdvanceTintoSystem.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperAdvanceTintoSystem.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaAdvanceTintoSystem.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemAdvanceTintoSystem.Create();
{$ENDIF}
end;

function TLibTintaAdvanceTintoSystem.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORADT';
end;

function TLibTintaAdvanceTintoSystem.GetNomeTinta: String;
begin
  Result := 'Advance TintoSystem';
end;

function TLibTintaAdvanceTintoSystem.GetQuantidadeGramaMl(const fltValor,
  Fator: Double; strFormula: String): Double;
{Var
  qryGen: IDataSet;
  fltPeso: Double;
  fltMl: Double; }
begin
  Result := fltValor;

  {Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT COL_PESESP FROM '+ Self.GetIdePro + '_CADCOL   ' +
                  '   WHERE COL_CODCOL = :COLORANTE     ';

    qryGen.ParamByName('COLORANTE').AsString := strFormula;
    qryGen.Open;

    If qryGen.IsEmpty Then
    Begin
      qryGen.Close;
      qryGen.SQL := '  SELECT BAS_PESESP FROM ' + Self.GetIdePro + '_CADBAS    ' +
                    '    WHERE BAS_CODBAS = :BASE         ';
      qryGen.ParamByName('BASE').AsString := strFormula;
      qryGen.Open;

      If qryGen.IsEmpty Then
      Begin
        Result := fltValor * Fator;
        Exit;
      End;

      fltPeso := qryGen.FieldByName('BAS_PESESP').AsFloat;
      fltMl := fltValor * Fator;
      fltMl := fltMl * fltPeso;
      Result := fltMl;
      Exit;
    End;

    fltPeso := qryGen.FieldByName('COL_PESESP').AsFloat;

    fltMl := fltValor * Fator;
    fltMl := fltMl * fltPeso;

    Result := fltMl;
  Except
    Raise;
  End;  }
end;

function TLibTintaAdvanceTintoSystem.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String): String;

var
  fltCalculo,
  fltInteiroOnca,
  fltFracaoOnca: Double;
begin
  Result := '';

  fltCalculo     := (fltPulsos / 48) / 0.61611520;
  fltInteiroOnca := Trunc(fltCalculo);
  fltFracaoOnca  := TAutcomTintaFactory.Get.fStrToFloat(FormatFloat('0.000', (fltCalculo - fltInteiroOnca) * 48));

  Result := Format('%dY%.1f', [Trunc(fltInteiroOnca), fltFracaoOnca]);

end;

function TLibTintaAdvanceTintoSystem.GetSQLBaseCataliGTinFor(
  const strColorantes: string; strCatalisador: String): String;
begin
  Result :=
    ' SELECT           ' +
          '   COL_CODITE,    ' +
          '   COL_CODCOL,    ' +
          '   COL_DESCRI,    ' +
          '   COL_PESESP,    ' +
          '   "N" AS CATALI  ' +
          ' FROM             ' +
          '   ADT_CADCOL     ' +
          ' WHERE COL_CODCOL IN (' + strColorantes + ') ' + ' ' +
          ' UNION ALL        ' +
          ' SELECT           ' +
          '   BAS_CODITE AS COL_CODITE,    ' +
          '   BAS_CODBAS AS COL_CODCOL,    ' +
          '   BAS_DESCRI AS COL_DESCRI,    ' +
          '   BAS_PESESP AS COL_PESESP,    ' +
          '   "S" AS CATALI  ' +
          ' FROM             ' +
          '   ADT_CADBAS     ' +
          ' WHERE BAS_CODBAS IN (' + strCatalisador + ') ' + ' ' +
          ' AND BAS_CODEMB = :CODEMB ';
end;

function TLibTintaAdvanceTintoSystem.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
     ' SELECT           ' +
        '   COL_CODITE,    ' +
        '   COL_CODCOL,    ' +
        '   COL_DESCRI,    ' +
        '   COL_PESESP,    ' +
        '   "N" AS CATALI  ' +
        ' FROM             ' +
        '   ADT_CADCOL     ' +
        ' WHERE COL_CODCOL IN (' + strColorantes + ') ' + ' ';
end;

procedure TLibTintaAdvanceTintoSystem.pTintaRetornaTabPrecoImobiliaria(
  dicRetorno: IDicionario; fltFatorAcerto: Double);
var
  formula: TAbstractFormulaImobiliaria;
  intCols: Integer;
  colorante: TColorante;
  calculadorFatVendas: ICalculadorFatVendasLibTintas;
  qryTintas: IDataSet;
  qryCadCol: IDataSet;
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

      qryTintas := TAutcomTintaFactory.Get.fGetDataSet;
      qryTintas.SQL := '  SELECT * FROM ADT_CADADT WHERE TRUE AND ADT_MD5KEY = :MD5KEY    ';
      qryTintas.ParamByName('MD5KEY').AsString := TVariantUtils.IfNull(dicRetorno['itetin'], '');
      qryTintas.Open;

      Formula.dtsCadTin := qryTintas;
      Formula.AcrMob   := qryTintas.FieldByName('ADT_ACRMOB').AsFloat;


      qryCadCol := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadCol.SQL := '    SELECT COL_CODCOL, COL_PESESP FROM ADT_CADCOL   ';
      qryCadCol.Open;

      For intCols := 1 To formula.GetQuantidadeFormulacao Do
      Begin
        If (TStrUtils.fEmptyStr(TVariantUtils.IfNull(dicRetorno['base' + TStrUtils.fStrZero(intCols, 2)], ''))) Then
          Break;


        If qryCadCol.Locate('COL_CODCOL', dicRetorno['base' + TStrUtils.fStrZero(intCols, 2)], []) Then
          dicRetorno['qtdb' + TStrUtils.fStrZero(intCols, 2)] := dicRetorno['qtdb' + TStrUtils.fStrZero(intCols, 2)] / qryCadCol.FieldByName('COL_PESESP').AsFloat
        Else If dicRetorno['base' + TStrUtils.fStrZero(intCols, 2)] = qryTintas.FieldByName('ADT_CODCAT').AsString Then
          dicRetorno['qtdb' + TStrUtils.fStrZero(intCols, 2)] := dicRetorno['qtdb' + TStrUtils.fStrZero(intCols, 2)] / fPesoEspecificoCadBas(qryTintas.FieldByName('ADT_CODBAS').AsString, qryTintas.FieldByName('ADT_CODEMB').AsString);


        formula.UsaCatalisador := dicRetorno['catali'] = 'S';

        If dicRetorno['base' + TStrUtils.fStrZero(intCols, 2)] = qryTintas.FieldByName('ADT_CODCAT').AsString Then
          If Not formula.UsaCatalisador Then
            Continue;

        colorante := TColorante(formula.Add);
        colorante.CodigoColorante := dicRetorno['base' + TStrUtils.fStrZero(intCols, 2)];
        colorante.Quantidade := TFloatUtils.fFormataFloat(dicRetorno['qtdb' + TStrUtils.fStrZero(intCols, 2)], 3);

        If formula.UsaCatalisador And (Colorante.CodigoColorante = qryTintas.FieldByName('ADT_CODCAT').AsString) Then
          Colorante.Tipo := tciCatalisador
        Else
          Colorante.Tipo := tciColorante;
      End;

      formula.ItemBase := TVariantUtils.IfNull(dicRetorno['itebas'], '');
      dicRetorno['desopetinta'] := TAutcomTintaFactory.Get.fGetConfTinta(dicRetorno['idepro']).fGetDouble('DESOPE');
      formula.RecalcularTabelas(dicRetorno);

      dicRetorno['precus'] := formula.PrecoCustoIndustrial;
      dicRetorno['precu2'] := formula.PrecoCustoRealIndustrial;
      dicRetorno['premed'] := formula.PrecoMedioIndustrial;
      dicRetorno['preult'] := formula.UltimoPrecoCompraIndustrial;
      dicRetorno['impult'] := formula.UltimoPrecoCompraImpostosIndustrial;
      dicRetorno['prctin'] := formula.PrecoCompraLiquidoIndustrial;

      dicRetorno.AdicionarObjeto('tintaDeMaquina', formula.tintaDeMaquina);
    Except
      On E: Exception Do
        Raise;
    End;
  Finally
    TAutcomTintaFactory.Get.pSetaEmpresaLogadaTinta(strCodEmp);
  End;
end;

procedure TLibTintaAdvanceTintoSystem.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
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
        '   ADT_CADADT            ' +
        ' WHERE ADT_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;


      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('ADT_IDFORM').AsString +
                              qryGen.FieldByName('ADT_CODCOR').AsString +
                              qryGen.FieldByName('ADT_CODTEC').AsString +
                              qryGen.FieldByName('ADT_PRODUT').AsString +
                              qryGen.FieldByName('ADT_CODBAS').AsString +
                              qryGen.FieldByName('ADT_CODEMB').AsString +
                              qryGen.FieldByName('ADT_CODCAT').AsString;


    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

function TLibTintaAdvanceTintoSystem.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';//dtsTinta.FieldByName('ADT_REFERE').AsString;
end;

function TLibTintaAdvanceTintoSystem.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('ADT');

  strSiglaTrava := conf.fGet('TRAADT');
  fltFatTrava   := conf.fGetDouble('FATADT');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
