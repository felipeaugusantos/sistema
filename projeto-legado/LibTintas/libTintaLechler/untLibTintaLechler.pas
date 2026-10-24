{**************************************************************************}
{* Classe contendo as informações especificas da tinta Lechler *}
{***********************************************************************MH*}
unit untLibTintaLechler;

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
  TLibTintaLechler = class(TAbstractLibTintaAutomotiva)
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
  untAuttinMenuItemLechler,
{$ENDIF}
  untFormulaAutomotivaLechler, untTintadeMaquinaWrapperLechler, untAutcomTintaFactory, untVariantUtils;

{ TLechlerTintadeMaquina }

{function TLibTintaLechler.fValidarMd5Key(strIteTin: String): Boolean;
begin
  Result := True;
end;
 }
function TLibTintaLechler.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESCRI';
end;

function TLibTintaLechler.GetCodFormul(const dicRetorno: IDicionario): string;
begin
  Result := '';
end;

function TLibTintaLechler.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaLechler.Create(strTabPre);
end;

function TLibTintaLechler.GetInstrucaoRetComponentes(
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
  Result := Result + '     LEC_CADCOL              ';
  Result := Result + '   WHERE COL_CODCOL = :BAS_CODBAS     ';

end;

function TLibTintaLechler.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperLechler.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaLechler.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemLechler.Create();
{$ENDIF}
end;

function TLibTintaLechler.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORLEC';
end;

function TLibTintaLechler.GetNomeTinta: String;
begin
  Result := 'Lechler Industrial';
end;

function TLibTintaLechler.GetPrefixoTabela: String;
begin
  Result := 'LEC';
end;

function TLibTintaLechler.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String): String;
begin
  Result := '';
end;

function TLibTintaLechler.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result :=
    '  SELECT                                      ' +
    '    BAS_CODBAS                                ' +
    '    , BAS_CODITE                              ' +
    '    , BAS_PESESP                              ' +
    '  FROM                                        ' +
    '    LEC_CADBAS                                ' +
    '  WHERE BAS_CODBAS IN (' + strBases + ')      ' +
    '  UNION ALL                                   ' +
    '  SELECT                                      ' +
    '    COL_CODCOL AS BAS_CODBAS,                 ' +
    '    COL_CODITE AS BAS_CODITE,                 ' +
    '    COL_PESESP AS BAS_PESESP                  ' +
    '  FROM                                        ' +
    '    LEC_CADCOL                                ' +
    '  WHERE COL_CODCOL IN (' + strBases + ')      ';
end;

function TLibTintaLechler.GetVolumeConcentrado: Double;
begin
  Result := 1;
end;

function TLibTintaLechler.GetVolumeDiluido: Double;
begin
  Result := 1;
end;

function TLibTintaLechler.GetVolumeOriginal(const dicRetorno: IDicionario): Double;
begin
  Result := 1;
end;

function TLibTintaLechler.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := dicRetorno['volpro'];
end;

procedure TLibTintaLechler.pProcessaFormulacaoGTinFor(
  Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet; dicBases: IDicionario;
  Const Formula: TAbstractFormulaAutomotiva; Const dicDados: IDicionario; var strBases: String);
var
  intCont: Integer;
  intForm: Integer;
begin

  intForm := 0;

  Inc(intForm);

  arrFormul[intForm].strFormul := qryConsulta.FieldByName('LEC_CODBAS').AsString;
  arrFormul[intForm].fltQtdbas := qryConsulta.FieldByName('LEC_QTDB01').AsFloat;
  arrFormul[intForm].fltQtdbas := arrFormul[intForm].fltQtdbas / 1 * dicDados['volpro'];
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

    arrFormul[intForm].fltQtdbas := arrFormul[intForm].fltQtdbas / 1  * dicDados['volpro'];

    dicBases[arrFormul[intForm].strFormul] := arrFormul[intForm].fltQtdbas;

    strBases := strBases + '"' + arrFormul[intForm].strFormul + '"';

    If (Not TStrUtils.fEmptyStr(arrFormul[intForm].strFormul)) Then
      strBases := strBases + ', ';
  end;

end;

procedure TLibTintaLechler.pProcessaFormulacaoTabelaPreco(
  Formula: TAbstractFormulaAutomotiva; const dicRetorno: IDicionario; const qryConsulta: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
begin

  Base := TBaseAutomotiva(Formula.Add);
  Base.CodigoBase := qryConsulta.FieldByName('LEC_CODBAS').AsString;

  If dicRetorno['tippre'] = 'C' Then
    Base.QuantidadeConcentrado  :=  TFloatUtils.fFormataFloat(qryConsulta.FieldByName('LEC_QTDB01').AsFloat, 3)
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
      Base.QuantidadeConcentrado := TFloatUtils.fFormataFloat(qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicRetorno['tippre']) +
        TStrUtils.fStrZero(intContador, 2)).AsFloat, 3)
    Else
      Base.QuantidadeDiluido :=   0.00;

    Base.TipoBase := 'CO';
  End;

end;

procedure TLibTintaLechler.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryLEC: IDataSet;
begin
  Try
    Try
      qryLEC := TAutcomTintaFactory.Get.fGetDataSet;
      qryLEC.Close;
      qryLEC.SQL := 'SELECT *          ' +
                    '  FROM LEC_CADLEC ' +
                    ' WHERE LEC_MD5KEY = :ITETIN ';
      qryLEC.ParamByName('ITETIN').AsString := strIteTin;
      qryLEC.Open;

      if qryLEC.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryLEC.FieldByName('LEC_CODNFM').AsString;
      dicRetorno['martin'] := qryLEC.FieldByName('LEC_CODCOR').AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TLibTintaLechler.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaLechler.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
  Var
    strTraLEC: String;
    fltTraLEC: Double;
    conf: IConfTinta;
Begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('LEC');

  strTraLEC := conf.fGet('LECTRA');
  fltTraLEC := conf.fGetDouble('LECFAT');

  If (strTraLEC = 'VEN') Then
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0);

  Result := TFloatUtils.fFormataFloat(Result * fltTraLEC, 2);
end;

end.
