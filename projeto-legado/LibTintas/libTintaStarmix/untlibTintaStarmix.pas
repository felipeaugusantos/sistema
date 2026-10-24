{******************************************-***********************}
{* Classe contendo as informações especificas da tinta Starmix *}
{*******************************************-*******************AC*}
unit untLibTintaStarmix;

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
  TLibTintaStarmix = class(TAbstractLibTintaAutomotiva)
  private

  protected
    function GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva; override;

    //É utilizada somente para as tintas onde a quantidade mostrada é diferente da quantidade da formulacao
    //(A maioria das tintas não utilizam isso)
    function GetFormulaAutomotivaQtdEsp(const strTabPre: String): TAbstractFormulaAutomotiva; override;

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

  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemStarmix,
{$ENDIF}
  untFormulaAutomotivaStarmix, untTintadeMaquinaWrapperStarmix, untAutcomTintaFactory, untVariantUtils;

{ TStarmixTintadeMaquina }

function TLibTintaStarmix.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESBAS';
end;

function TLibTintaStarmix.GetCodFormul(const dicRetorno: IDicionario): string;
begin
  Result := '';
end;

function TLibTintaStarmix.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaStarmix.Create(strTabPre);
end;

function TLibTintaStarmix.GetFormulaAutomotivaQtdEsp(
  const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaStarmix.Create(strTabPre);
end;

function TLibTintaStarmix.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperStarmix.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaStarmix.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemStarmix.Create();
{$ENDIF}
end;

function TLibTintaStarmix.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORSTA';
end;

function TLibTintaStarmix.GetNomeTinta: String;
begin
  Result := 'Starmix';
end;

function TLibTintaStarmix.GetPrefixoTabela: String;
begin
  Result := 'STA';
end;

function TLibTintaStarmix.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String): String;
begin
  Result := '';
end;

function TLibTintaStarmix.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   BAS_CODBAS                                ' +
    '   , BAS_CODITE                              ' +
    ' FROM                                        ' +
    '   STA_CADBAS                                ' +
    ' WHERE BAS_CODBAS IN (' + strBases + ') ';
end;

function TLibTintaStarmix.GetVolumeConcentrado: Double;
begin
  Result := 0;
end;

function TLibTintaStarmix.GetVolumeDiluido: Double;
begin
  Result := 0;
end;

function TLibTintaStarmix.GetVolumeOriginal(const dicRetorno: IDicionario): Double;
begin
  Result := 1;
end;

function TLibTintaStarmix.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := 1;
end;

procedure TLibTintaStarmix.pProcessaFormulacaoGTinFor(
  Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet; dicBases: IDicionario;
  Const Formula: TAbstractFormulaAutomotiva; Const dicDados: IDicionario; var strBases: String);
var
  intCont: Integer;
begin
  formula.pPreencherPesCorFor(qryConsulta);

  for intCont := 1 to formula.GetQuantidadeFormulacao do
  begin
    If qryConsulta.FieldByName(formula.GetPrefixoQuantidade('') + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 Then
      Break;

    arrFormul[intCont].strFormul := qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2)).AsString;
    arrFormul[intCont].fltQtdbas := TFloatUtils.fFormataFloat(dicDados['volpro'] * ((formula.PesoCor / formula.PesoFor) *
       qryConsulta.FieldByName(formula.GetPrefixoQuantidade('') + TStrUtils.fStrZero(intCont, 2)).AsFloat),1);

    dicBases[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;

    strBases := strBases + QuotedStr(arrFormul[intCont].strFormul);
    If (Not TStrUtils.fEmptyStr(arrFormul[intCont].strFormul)) Then
      strBases := strBases + ', ';
  end;
end;

procedure TLibTintaStarmix.pProcessaFormulacaoTabelaPreco(
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
    Base.CodigoBase            := dicRetorno['base' + TStrUtils.fStrZero(intContador, 2)];
    Base.QuantidadeConcentrado := TFloatUtils.fFormataFloat(dicRetorno['qtdb' + TStrUtils.fStrZero(intContador, 2)], 3);
    Base.QuantidadeDiluido     := 0.0;
    Base.TipoBase              := 'B';
  End;
end;

procedure TLibTintaStarmix.PreencherPesCorFor(
  Formula: TAbstractFormulaAutomotiva; qryConsulta: IDataSet);
begin
  Formula.PesoCor := 1;
  Formula.PesoFor := 1;
end;

procedure TLibTintaStarmix.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL := 'SELECT STA_UNIVER, ' +
                    '       STA_MONTAD, ' +
                    '       STA_CODLIN  ' +
                    '  FROM STA_CADSTA  ' +
                    ' WHERE STA_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      If qryGen.IsEmpty Then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('STA_UNIVER').AsString;
      dicRetorno['montad'] := qryGen.FieldByName('STA_MONTAD').AsString;
      dicRetorno['martin'] := qryGen.FieldByName('STA_CODLIN').AsString;
    Except
      On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally

  End;
end;

function TLibTintaStarmix.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaStarmix.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
  Var
    strTraStarmix: String;
    fltTraStarmix: Double;
    conf: IConfTinta;
Begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('STA');

  strTraStarmix := TAutcomTintaFactory.Get.IIF(conf.fGet('TRASTA') = '3', 'VEN', 'CUS');
  fltTraStarmix := conf.fGetDouble('FATSTA');

  If (strTraStarmix = 'VEN') Then
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0);

  Result := TFloatUtils.fFormataFloat(Result * fltTraStarmix, 2);
end;

end.
