{******************************************-*********************}
{* Classe contendo as informações especificas da tinta General *}
{*******************************************-*****************AC*}
unit untLibTintaGeneral;

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
  TLibTintaGeneral = class(TAbstractLibTintaAutomotiva)
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
  untAuttinMenuItemGeneral,
{$ENDIF}
  untFormulaAutomotivaGeneral, untTintadeMaquinaWrapperGeneral, untAutcomTintaFactory, untVariantUtils;

{ TGeneralTintadeMaquina }

{function TLibTintaGeneral.fValidarMd5Key(strIteTin: String): Boolean;
begin
  Result := True;
end;
 }
function TLibTintaGeneral.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESCRI';
end;

function TLibTintaGeneral.GetCodFormul(const dicRetorno: IDicionario): string;
begin
  Result := '';
end;

function TLibTintaGeneral.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaGeneral.Create(strTabPre);
end;

function TLibTintaGeneral.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperGeneral.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaGeneral.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemGeneral.Create();
{$ENDIF}
end;

function TLibTintaGeneral.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORGEN';
end;

function TLibTintaGeneral.GetNomeTinta: String;
begin
  Result := 'General';
end;

function TLibTintaGeneral.GetPrefixoTabela: String;
begin
  Result := 'GEN';
end;

function TLibTintaGeneral.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String = ''): String;
begin
  Result := '';
end;

function TLibTintaGeneral.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   BAS_CODBAS                                ' +
    '   , BAS_CODITE                              ' +
    ' FROM                                        ' +
    '   GEN_CADBAS                                ' +
    ' WHERE BAS_CODBAS IN (' + strBases + ') ';
end;

function TLibTintaGeneral.GetVolumeConcentrado: Double;
begin
  Result := 0.9;
end;

function TLibTintaGeneral.GetVolumeDiluido: Double;
begin
  Result := 0.9;
end;

function TLibTintaGeneral.GetVolumeOriginal(const dicRetorno: IDicionario): Double;
begin
  Result := 0.9;
end;

function TLibTintaGeneral.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := dicRetorno['volpro'];
end;

procedure TLibTintaGeneral.pProcessaFormulacaoGTinFor(
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

    If dicDados['tippre'] = 'C' Then
    begin
      arrFormul[intCont].fltQtdbas := qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicDados['tippre']) + TStrUtils.fStrZero(intCont, 2)).AsFloat;
    End
    else
    begin
      arrFormul[intCont].fltQtdbas := qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicDados['tippre']) + TStrUtils.fStrZero(intCont, 2)).AsFloat * 5 / 6;
    End;

    arrFormul[intCont].fltQtdbas := dicDados['volpro']  * arrFormul[intCont].fltQtdbas / 0.9;
    dicBases[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;

    strBases := strBases + QuotedStr(arrFormul[intCont].strFormul);

    If (Not TStrUtils.fEmptyStr(arrFormul[intCont].strFormul)) Then
      strBases := strBases + ', ';
  end;

  If dicDados['tippre'] = 'D' Then
  Begin
    arrFormul[intCont].strFormul := '7540563';
    arrFormul[intCont].fltQtdbas := 110.13 * dicDados['volpro'] / 750;
  End;

end;

procedure TLibTintaGeneral.pProcessaFormulacaoTabelaPreco(
  Formula: TAbstractFormulaAutomotiva; const dicRetorno: IDicionario; const qryConsulta: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
begin
  For intContador := 1 To 20 Do
  Begin
    If (Not TStrUtils.fEmptyStr(TVariantUtils.IfNull(qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intContador, 2)).AsString, ''))) Then
    Begin
      Base := TBaseAutomotiva(Formula.Add);

      Base.CodigoBase := qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intContador, 2)).AsString;

      If dicRetorno['tippre'] = 'C' Then
        Base.QuantidadeConcentrado := TFloatUtils.fFormataFloat(qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicRetorno['tippre']) + TStrUtils.fStrZero(intContador, 2)).AsFloat, 4)
      Else
        Base.QuantidadeDiluido     := TFloatUtils.fFormataFloat(qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicRetorno['tippre']) + TStrUtils.fStrZero(intContador, 2)).AsFloat, 4) * 5 / 6;;

      Base.TipoBase := 'B';
    End
    Else If dicRetorno['tippre'] = 'D' Then
    Begin
      Base := TBaseAutomotiva(Formula.Add);

      Base.CodigoBase := '7540563';
      Base.QuantidadeDiluido := 110.13 * 900 / 750;
      Base.TipoBase := 'D';
      Break;
    End
    Else
      Break;
  End;

end;

procedure TLibTintaGeneral.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL := 'SELECT *          ' +
                    '  FROM GEN_CADGEN ' +
                    '  LEFT JOIN GEN_CADMON ON MON_CODMON = GEN_CODMON '+
                    ' WHERE GEN_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('GEN_CODIGO').AsString;
      dicRetorno['montad'] := qryGen.FieldByName('MON_DESCRI').AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TLibTintaGeneral.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaGeneral.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
  Var
    strTraGen: String;
    fltTraGen: Double;
    conf: IConfTinta;
Begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('GEN');

  strTraGen := conf.fGet('GENTRV');
  fltTraGen := conf.fGetDouble('GENFAT');

  If (strTraGen = 'VEN') Then
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0);

  Result := TFloatUtils.fFormataFloat(Result * fltTraGen, 2);
end;

end.
