{**************************************************************************}
{* Classe contendo as informações especificas da tinta BrasimixAutomotiva *}
{***********************************************************************MH*}
unit untLibTintaBrasimixAutomotiva;

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
  TLibTintaBrasimixAutomotiva = class(TAbstractLibTintaAutomotiva)
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

    function GetPrefixoTabela: String; override;
    procedure pProcessaBaixaPigmentosGTinFor(qryBases: IDataSet; intPos: Integer; Var List: TStringList;
      arrBaixaPigmentos: TBaixaPigmentosArray; dicBases: IDicionario; Const dicDados: IDicionario; strBases: String); Override;
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
    // function fValidarMd5Key(strIteTin : String ) : Boolean; override;
    procedure pRetItemColorante(const strColTinDet: String; Var strCodIte, strCodBas, strDesBas: String; const strCodEmp: String); Override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemBrasimixAutomotiva,
{$ENDIF}
  untFormulaAutomotivaBrasimixAutomotiva, untTintadeMaquinaWrapperBrasimixAutomotiva, untAutcomTintaFactory, untVariantUtils;

{ TBrasimixAutomotivaTintadeMaquina }


function TLibTintaBrasimixAutomotiva.fSelectBasesEmpresa(
  strCodEmp: String): String;
begin
  Result := ' SELECT              ';
  Result := Result + '    BAS_CODITE,     ';
  Result := Result + '    BAS_CODBAS      ';
  Result := Result + ' FROM       ';
  Result := Result + '    BZA_BASEMP      ';
  Result := Result + ' WHERE BAS_CODBAS = :BAS_CODBAS   ';
  Result := Result + '  AND BAS_CODEMP = "' + strCodEmp + '"  ';
end;

function TLibTintaBrasimixAutomotiva.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESBAS';
end;

function TLibTintaBrasimixAutomotiva.GetCodFormul(const dicRetorno: IDicionario): string;
begin
  Result := '';
end;

function TLibTintaBrasimixAutomotiva.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaBrasimixAutomotiva.Create(strTabPre);
end;

function TLibTintaBrasimixAutomotiva.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperBrasimixAutomotiva.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaBrasimixAutomotiva.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemBrasimixAutomotiva.Create();
{$ENDIF}
end;

function TLibTintaBrasimixAutomotiva.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORBZA';
end;

function TLibTintaBrasimixAutomotiva.GetNomeTinta: String;
begin
  Result := 'Brasimix Automotiva';
end;

function TLibTintaBrasimixAutomotiva.GetPrefixoTabela: String;
begin
  Result := 'BZA';
end;

function TLibTintaBrasimixAutomotiva.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String): String;
begin
  Result := '';
end;

function TLibTintaBrasimixAutomotiva.GetSQLBasesEmpGTinFor(const strBases: String;
  const dicDados: IDicionario): String;
begin
  Result := '';
  Result := Result + '  SELECT                ';
  Result := Result + '    BAS_CODBAS,         ';
  Result := Result + '    BAS_CODITE          ';
  Result := Result + '  FROM                  ';
  Result := Result + '    BZA_BASEMP          ';
  Result := Result + '  WHERE                 ';
  Result := Result + '    BAS_CODBAS IN (' + strBases + ')  AND         ';
  Result := Result + '    BAS_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '"  AND     ';
  Result := Result + '    BAS_CODITE IS NOT NULL      ';
end;

function TLibTintaBrasimixAutomotiva.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   BAS_CODBAS                                ' +
    '   , BAS_CODITE                              ' +
    ' FROM                                        ' +
    '   BZA_CADBAS                                ' +
    ' WHERE BAS_CODBAS IN (' + strBases + ') ';
end;

function TLibTintaBrasimixAutomotiva.GetVolumeConcentrado: Double;
begin
  Result := 0.9;
end;

function TLibTintaBrasimixAutomotiva.GetVolumeDiluido: Double;
begin
  Result := 0.9;
end;

function TLibTintaBrasimixAutomotiva.GetVolumeOriginal(const dicRetorno: IDicionario): Double;
begin
  Result := 0.9;
end;

function TLibTintaBrasimixAutomotiva.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := dicRetorno['volpro'];
end;

procedure TLibTintaBrasimixAutomotiva.pProcessaBaixaPigmentosGTinFor(qryBases: IDataSet;
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

procedure TLibTintaBrasimixAutomotiva.pProcessaFormulacaoGTinFor(
  Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet; dicBases: IDicionario;
  Const Formula: TAbstractFormulaAutomotiva; Const dicDados: IDicionario; var strBases: String);
var
  intCont: Integer;
begin
  for intCont := 1 to formula.GetQuantidadeFormulacao do
  begin
    If qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicDados['tippre']) + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 Then
      Break;

    arrFormul[intCont].strFormul   := qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2)).AsString;

    arrFormul[intCont].fltQtdbas := qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicDados['tippre']) + TStrUtils.fStrZero(intCont, 2)).AsFloat;

    arrFormul[intCont].fltQtdbas := dicDados['volpro']  * arrFormul[intCont].fltQtdbas / 0.9;

    dicBases[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;

    strBases := strBases + QuotedStr(arrFormul[intCont].strFormul);

    If (Not TStrUtils.fEmptyStr(arrFormul[intCont].strFormul)) Then
      strBases := strBases + ', ';
  end;

end;

procedure TLibTintaBrasimixAutomotiva.pProcessaFormulacaoTabelaPreco(
  Formula: TAbstractFormulaAutomotiva; const dicRetorno: IDicionario; const qryConsulta: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
begin
  For intContador := 1 To 20 Do
  Begin
    If (TStrUtils.fEmptyStr(TVariantUtils.IfNull(qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intContador, 2)).AsString, ''))) Then
      Break;

    Base := TBaseAutomotiva(Formula.Add);

    Base.CodigoBase := qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intContador, 2)).AsString;

    If dicRetorno['tippre'] = 'C' Then
      Base.QuantidadeConcentrado := //dicRetorno['volpro'] *
        TFloatUtils.fFormataFloat(qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicRetorno['tippre']) + TStrUtils.fStrZero(intContador, 2)).AsFloat, 4) //  / 0.9
    Else
      Base.QuantidadeDiluido := //dicRetorno['volpro'] *
        TFloatUtils.fFormataFloat(qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicRetorno['tippre']) + TStrUtils.fStrZero(intContador, 2)).AsFloat, 4);// / 0.9;

    Base.TipoBase := 'B';
  End;

end;

procedure TLibTintaBrasimixAutomotiva.pRetItemColorante(
  const strColTinDet: String; var strCodIte, strCodBas, strDesBas: String;
  const strCodEmp: String);
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

procedure TLibTintaBrasimixAutomotiva.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryBZA: IDataSet;
begin
  Try
    Try
      qryBZA := TAutcomTintaFactory.Get.fGetDataSet;
      qryBZA.Close;
      qryBZA.SQL := 'SELECT *          ' +
                    '  FROM BZA_CADBZA ' +
                    ' WHERE BZA_MD5KEY = :ITETIN ';
      qryBZA.ParamByName('ITETIN').AsString := strIteTin;
      qryBZA.Open;

      if qryBZA.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryBZA.FieldByName('BZA_CODSEQ').AsString;
      dicRetorno['montad'] := qryBZA.FieldByName('BZA_MONTAD').AsString;
      dicRetorno['martin'] := qryBZA.FieldByName('BZA_ARQTXT').AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TLibTintaBrasimixAutomotiva.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaBrasimixAutomotiva.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
  Var
    strTraBZA: String;
    fltTraBZA: Double;
    conf: IConfTinta;
Begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('BZA');

  strTraBZA := conf.fGet('TRABZA');
  fltTraBZA := conf.fGetDouble('FATBZA');

  If (strTraBZA = 'VEN') Then
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0);

  Result := TFloatUtils.fFormataFloat(Result * fltTraBZA, 2);
end;

end.

