{******************************************-***********************}
{* Classe contendo as informações especificas da tinta StarmixWeb *}
{*******************************************-*******************AC*}
unit untLibTintaStarmixWeb;

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
  TLibTintaStarmixWeb = class(TAbstractLibTintaAutomotiva)
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
  untAuttinMenuItemStarmixWeb,
{$ENDIF}
  untFormulaAutomotivaStarmixWeb, untTintadeMaquinaWrapperStarmixWeb,
  untAutcomTintaFactory, untVariantUtils;

{ TStarmixWebTintadeMaquina }

function TLibTintaStarmixWeb.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESBAS';
end;

function TLibTintaStarmixWeb.GetCodFormul(const dicRetorno: IDicionario): string;
begin
  Result := '';
end;

function TLibTintaStarmixWeb.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaStarmixWeb.Create(strTabPre);
end;

function TLibTintaStarmixWeb.GetFormulaAutomotivaQtdEsp(
  const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaStarmixWeb.Create(strTabPre);
end;

function TLibTintaStarmixWeb.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperStarmixWeb.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaStarmixWeb.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemStarmixWeb.Create();
{$ENDIF}
end;

function TLibTintaStarmixWeb.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORSTW';
end;

function TLibTintaStarmixWeb.GetNomeTinta: String;
begin
  Result := 'Starmix Web / W-Mix';
end;

function TLibTintaStarmixWeb.GetPrefixoTabela: String;
begin
  Result := 'STW';
end;

function TLibTintaStarmixWeb.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String): String;
begin
  Result := '';
end;

function TLibTintaStarmixWeb.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   BAS_CODBAS                                ' +
    '   , BAS_CODITE                              ' +
    ' FROM                                        ' +
    '   STW_CADBAS                                ' +
    ' WHERE BAS_CODBAS IN (' + strBases + ') ';
end;

function TLibTintaStarmixWeb.GetVolumeConcentrado: Double;
begin
  Result := 0;
end;

function TLibTintaStarmixWeb.GetVolumeDiluido: Double;
begin
  Result := 0;
end;

function TLibTintaStarmixWeb.GetVolumeOriginal(const dicRetorno: IDicionario): Double;
begin
  Result := 1;
end;

function TLibTintaStarmixWeb.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := 1;
end;

procedure TLibTintaStarmixWeb.pProcessaFormulacaoGTinFor(
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

procedure TLibTintaStarmixWeb.pProcessaFormulacaoTabelaPreco(
  Formula: TAbstractFormulaAutomotiva; const dicRetorno: IDicionario; const qryConsulta: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
  blnDiluente: Boolean;
  strDiluente: String;
  qryBasDil: IDataSet;
  strSQL: String;
begin
  strDiluente := '';
  blnDiluente := False;

  strSQL := '';
  strSQL := strSQL + ' SELECT BAS_CODBAS  FROM STW_CADBAS WHERE BAS_DESBAS LIKE "%DILUENTE%"  ';
  strSQL := strSQL + ' UNION ALL  ';
  strSQL := strSQL + ' SELECT BAS_CODBAS FROM STW_CADBAS WHERE BAS_DESBAS LIKE "%REDUTOR%"    ';

  qryBasDil := TAutcomTintaFactory.Get.fGetDataSet;
  qryBasDil.Close;
  qryBasDil.SQL := strSQL;
  qryBasDil.Open;

  While Not qryBasDil.Eof Do
  Begin
    strDiluente := strDiluente + qryBasDil.FieldByName('BAS_CODBAS').AsString + '_';
    qryBasDil.Next;
  End;

  For intContador := 1 To 20 Do
  Begin
    If (TStrUtils.fEmptyStr(TVariantUtils.IfNull(dicRetorno['base' + TStrUtils.fStrZero(intContador, 2)], ''))) Then
      Break;

    If Pos(dicRetorno['base' + TStrUtils.fStrZero(intContador, 2)], strDiluente) > 0 Then
    Begin
      blnDiluente := True;
      strDiluente := dicRetorno['base' + TStrUtils.fStrZero(intContador, 2)];
      Break;
    End;

    Base := TBaseAutomotiva(Formula.Add);
    Base.CodigoBase            := dicRetorno['base' + TStrUtils.fStrZero(intContador, 2)];
    Base.QuantidadeConcentrado := TFloatUtils.fFormataFloat(dicRetorno['qtdb' + TStrUtils.fStrZero(intContador, 2)], 3);
    Base.QuantidadeDiluido     := 0.0;
    Base.TipoBase              := 'B';
  End;

  If blnDiluente Then
  Begin
    Formula.Clear;
    For intContador := 1 To 20 Do
    Begin
      If TStrUtils.fEmptyStr(TVariantUtils.IfNull(dicRetorno['base' + TStrUtils.fStrZero(intContador, 2)], '')) Then
        Break;

      Base := TBaseAutomotiva(Formula.Add);
      Base.CodigoBase := dicRetorno['base' + TStrUtils.fStrZero(intContador, 2)];
      Base.QuantidadeConcentrado := 0.0;
      Base.QuantidadeDiluido := TFloatUtils.fFormataFloat(dicRetorno['qtdb' + TStrUtils.fStrZero(intContador, 2)], 3);

      If Base.CodigoBase = strDiluente Then
        Base.TipoBase := 'D'
      Else
        Base.TipoBase := 'B';
    End;
  End;
end;

procedure TLibTintaStarmixWeb.PreencherPesCorFor(
  Formula: TAbstractFormulaAutomotiva; qryConsulta: IDataSet);
begin
  Formula.PesoCor := 1;
  Formula.PesoFor := 1;
end;

procedure TLibTintaStarmixWeb.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL := 'SELECT STW_UNIVER, ' +
                    '       STW_MONTAD, ' +
                    '       STW_CODLIN  ' +
                    '  FROM STW_CADSTW  ' +
                    ' WHERE STW_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      If qryGen.IsEmpty Then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('STW_UNIVER').AsString;
      dicRetorno['montad'] := qryGen.FieldByName('STW_MONTAD').AsString;
      dicRetorno['martin'] := qryGen.FieldByName('STW_CODLIN').AsString;
    Except
      On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally

  End;
end;

function TLibTintaStarmixWeb.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaStarmixWeb.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
  Var
    strTraStarmixWeb: String;
    fltTraStarmixWeb: Double;
    conf: IConfTinta;
Begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('STW');

  strTraStarmixWeb := TAutcomTintaFactory.Get.IIF(conf.fGet('TRASTW') = '3', 'VEN', 'CUS');
  fltTraStarmixWeb := conf.fGetDouble('FATSTW');

  If (strTraStarmixWeb = 'VEN') Then
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0);

  Result := TFloatUtils.fFormataFloat(Result * fltTraStarmixWeb, 2);
end;

end.
