{**************************************************************************}
{* Classe contendo as informações especificas da tinta RennerPerformance *}
{***********************************************************************MH*}
unit untLibTintaRennerPerformance;

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
  TLibTintaRennerPerformance = class(TAbstractLibTintaAutomotiva)
  private

  protected
    function GetInstrucaoRetComponentes(const strCodEmp: String): String; Override;
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
    // function fValidarMd5Key(strIteTin : String ) : Boolean; override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemRennerPerformance,
{$ENDIF}
  untFormulaAutomotivaRennerPerformance, untTintadeMaquinaWrapperRennerPerformance, untAutcomTintaFactory, untVariantUtils;

{ TRennerPerformanceTintadeMaquina }

{function TLibTintaRennerPerformance.fValidarMd5Key(strIteTin: String): Boolean;
begin
  Result := True;
end;
 }
function TLibTintaRennerPerformance.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESCRI';
end;

function TLibTintaRennerPerformance.GetCodFormul(const dicRetorno: IDicionario): string;
begin
  Result := '';
end;

function TLibTintaRennerPerformance.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaRennerPerformance.Create(strTabPre);
end;

function TLibTintaRennerPerformance.GetInstrucaoRetComponentes(
  const strCodEmp: String): String;
begin
  Result :=
    ' SELECT ' +
    '   ' + Self.GetCampoComponenteCodIte +
    '   ,' + Self.GetCampoComponenteCodComp +
    '   ,' + Self.GetCampoComponenteDesComp + ' AS DESBAS ' +
    ' FROM ' +
    '   ' + Self.fRetornaTabelaColoranteTinta +
    ' WHERE ' + GetWhereRetComponente(strCodEmp);

  Result := Result + ' UNION ALL                   ';
  Result := Result + '   SELECT                    ';
  Result := Result + '     COL_CODITE AS ' + Self.GetCampoComponenteCodIte + ',  ';
  Result := Result + '     COL_CODCOL AS ' + Self.GetCampoComponenteCodComp + ',  ';
  Result := Result + '     COL_DESCRI AS DESBAS    ';
  Result := Result + '   FROM                      ';
  Result := Result + '     REP_CADCOL              ';
  Result := Result + '   WHERE COL_CODCOL = :BAS_CODBAS     ';

end;

function TLibTintaRennerPerformance.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperRennerPerformance.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaRennerPerformance.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemRennerPerformance.Create();
{$ENDIF}
end;

function TLibTintaRennerPerformance.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORREP';
end;

function TLibTintaRennerPerformance.GetNomeTinta: String;
begin
  Result := 'Renner Performance';
end;

function TLibTintaRennerPerformance.GetPrefixoTabela: String;
begin
  Result := 'REP';
end;

function TLibTintaRennerPerformance.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String): String;
begin
  Result := '';
end;

function TLibTintaRennerPerformance.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result :=
    '  SELECT                                      ' +
    '    BAS_CODBAS                                ' +
    '    , BAS_CODITE                              ' +
    '    , BAS_PESESP                              ' +
    '  FROM                                        ' +
    '    REP_CADBAS                                ' +
    '  WHERE BAS_CODBAS IN (' + strBases + ')      ' +
    '  UNION ALL                                   ' +
    '  SELECT                                      ' +
    '    COL_CODCOL AS BAS_CODBAS,                 ' +
    '    COL_CODITE AS BAS_CODITE,                 ' +
    '    COL_PESESP AS BAS_PESESP                  ' +
    '  FROM                                        ' +
    '    REP_CADCOL                                ' +
    '  WHERE COL_CODCOL IN (' + strBases + ')      ';
end;

function TLibTintaRennerPerformance.GetVolumeConcentrado: Double;
begin
  Result := 0.9;
end;

function TLibTintaRennerPerformance.GetVolumeDiluido: Double;
begin
  Result := 0.9;
end;

function TLibTintaRennerPerformance.GetVolumeOriginal(const dicRetorno: IDicionario): Double;
begin
  Result := 0.9;
end;

function TLibTintaRennerPerformance.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := dicRetorno['volpro'];
end;

procedure TLibTintaRennerPerformance.pProcessaFormulacaoGTinFor(
  Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet; dicBases: IDicionario;
  Const Formula: TAbstractFormulaAutomotiva; Const dicDados: IDicionario; var strBases: String);
var
  intCont: Integer;
  intForm: Integer;
begin

  intForm := 0;

  Inc(intForm);

  arrFormul[intForm].strFormul := qryConsulta.FieldByName('REP_CODBAS').AsString;
  arrFormul[intForm].fltQtdbas := qryConsulta.FieldByName('REP_QTDBAS').AsFloat;
  arrFormul[intForm].fltQtdbas := TAutcomTintaFactory.Get.fFormataFloat(arrFormul[intForm].fltQtdbas / 0.9 * dicDados['volpro'], 2);
  dicBases[arrFormul[intForm].strFormul] := arrFormul[intForm].fltQtdbas;

  strBases := strBases + '"' + arrFormul[intForm].strFormul + '"';

  If (Not TStrUtils.fEmptyStr(arrFormul[intForm].strFormul)) Then
    strBases := strBases + ', ';


  for intCont := 1 to formula.GetQuantidadeFormulacao do
  begin
    Inc(intForm);

    If qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicDados['tippre']) + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 Then
      Break;

    arrFormul[intForm].strFormul   := qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2)).AsString;

    arrFormul[intForm].fltQtdbas := qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicDados['tippre']) + TStrUtils.fStrZero(intCont, 2)).AsFloat;

    arrFormul[intForm].fltQtdbas := TAutcomTintaFactory.Get.fFormataFloat(arrFormul[intForm].fltQtdbas / 0.9  * dicDados['volpro'], 2);

    dicBases[arrFormul[intForm].strFormul] := arrFormul[intForm].fltQtdbas;

    strBases := strBases + '"' + arrFormul[intForm].strFormul + '"';

    If (Not TStrUtils.fEmptyStr(arrFormul[intForm].strFormul)) Then
      strBases := strBases + ', ';
  end;

end;

procedure TLibTintaRennerPerformance.pProcessaFormulacaoTabelaPreco(
  Formula: TAbstractFormulaAutomotiva; const dicRetorno: IDicionario; const qryConsulta: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
begin

  Base := TBaseAutomotiva(Formula.Add);
  Base.CodigoBase := qryConsulta.FieldByName('REP_CODBAS').AsString;

  If dicRetorno['tippre'] = 'C' Then
    Base.QuantidadeConcentrado  :=  qryConsulta.FieldByName('REP_QTDBAS').AsFloat
  Else
    Base.QuantidadeDiluido      := 0.00;

  Base.TipoBase := 'B';

  For intContador := 1 To 20 Do
  Begin
    If (TStrUtils.fEmptyStr(TVariantUtils.IfNull(qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intContador, 2)).AsString, ''))) Then
      Break;

    Base := TBaseAutomotiva(Formula.Add);

    Base.CodigoBase := qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intContador, 2)).AsString;

    If dicRetorno['tippre'] = 'C' Then
      Base.QuantidadeConcentrado := qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicRetorno['tippre']) + TStrUtils.fStrZero(intContador, 2)).AsFloat
    Else
      Base.QuantidadeDiluido :=   0.00;

    Base.TipoBase := 'CO';
  End;

end;

procedure TLibTintaRennerPerformance.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryREP: IDataSet;
begin
  Try
    Try
      qryREP := TAutcomTintaFactory.Get.fGetDataSet;
      qryREP.Close;
      qryREP.SQL := 'SELECT *          ' +
                    '  FROM REP_CADREP ' +
                    ' WHERE REP_MD5KEY = :ITETIN ';
      qryREP.ParamByName('ITETIN').AsString := strIteTin;
      qryREP.Open;

      if qryREP.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryREP.FieldByName('REP_CODIGO').AsString;
      dicRetorno['martin'] := qryREP.FieldByName('REP_NOMCOR').AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TLibTintaRennerPerformance.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaRennerPerformance.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
  Var
    strTraREP: String;
    fltTraREP: Double;
    conf: IConfTinta;
Begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('REP');

  strTraREP := conf.fGet('REPTRA');
  fltTraREP := conf.fGetDouble('REPFAT');

  If (strTraREP = 'VEN') Then
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0);

  Result := TFloatUtils.fFormataFloat(Result * fltTraREP, 2);
end;

end.
