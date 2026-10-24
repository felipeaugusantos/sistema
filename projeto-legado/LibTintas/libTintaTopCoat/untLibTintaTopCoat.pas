{******************************************-*********************}
{* Classe contendo as informações especificas da tinta TopCoat *}
{*******************************************-*****************AC*}
unit untLibTintaTopCoat;

interface

uses
{$IFNDEF LINUX}
  Controls,
{$ENDIF}
  untAbstractLibTintaAutomotiva, untAbstractFormulaAutomotiva,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem, untFloatUtils, untBaseAutomotiva,
  untStrUtils, untGTinForTipos, Classes,
  untICalculadorFatVendasLibTintas, untModoVenda;

type
  TLibTintaTopCoat = class(TAbstractLibTintaAutomotiva)
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
  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemTopCoat,
{$ENDIF}
  untFormulaAutomotivaTopCoat, untTintadeMaquinaWrapperTopCoat, untAutcomTintaFactory, untVariantUtils;

{ TTopCoatTintadeMaquina }

function TLibTintaTopCoat.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESCRI';
end;

function TLibTintaTopCoat.GetCodFormul(const dicRetorno: IDicionario): string;
begin
  Result := TVariantUtils.IfNull(dicRetorno['codtin'],'') ;
end;

function TLibTintaTopCoat.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaTopCoat.Create(strTabPre);
end;

function TLibTintaTopCoat.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperTopCoat.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaTopCoat.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemTopCoat.Create();
{$ENDIF}
end;

function TLibTintaTopCoat.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORCOA';
end;

function TLibTintaTopCoat.GetNomeTinta: String;
begin
  Result := 'Top Coat';
end;

function TLibTintaTopCoat.GetPrefixoTabela: String;
begin
  Result := 'COA';
end;

function TLibTintaTopCoat.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String): String;
begin
  Result := '';
end;

function TLibTintaTopCoat.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   BAS_CODBAS                                ' +
    '   , BAS_CODITE                              ' +
    ' FROM                                        ' +
    '   COA_CADBAS                                ' +
    ' WHERE BAS_CODBAS IN (' + strBases + ') ';
end;

function TLibTintaTopCoat.GetVolumeConcentrado: Double;
begin
  Result := 0.9;
end;

function TLibTintaTopCoat.GetVolumeDiluido: Double;
begin
  Result := 0.9;
end;

function TLibTintaTopCoat.GetVolumeOriginal(
  const dicRetorno: IDicionario): Double;
begin
  Result := 0.9;
end;

function TLibTintaTopCoat.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := dicRetorno['volpro'];
end;

procedure TLibTintaTopCoat.pProcessaFormulacaoGTinFor(
  Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet; dicBases: IDicionario;
  Const Formula: TAbstractFormulaAutomotiva; Const dicDados: IDicionario; var strBases: String);
Var
  intCont: Integer;
begin
  for intCont := 1 to formula.GetQuantidadeFormulacao do
  begin
    If qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicDados['tippre']) + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 Then
      Break;

    arrFormul[intCont].strFormul := qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2)).AsString;
    arrFormul[intCont].fltQtdbas := (qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicDados['tippre']) + TStrUtils.fStrZero(intCont, 2)).AsFloat) *
      dicDados['volpro'] / 0.900;

    dicBases[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;

    strBases := strBases + QuotedStr(arrFormul[intCont].strFormul);
    If (Not TStrUtils.fEmptyStr(arrFormul[intCont].strFormul)) Then
      strBases := strBases + ', ';
  end;
end;

procedure TLibTintaTopCoat.pProcessaFormulacaoTabelaPreco(
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
      Base.QuantidadeConcentrado := TFloatUtils.fFormataFloat(dicRetorno['qtdb' + TStrUtils.fStrZero(intContador, 2)], 3) * Formula.VolumeOri  / Formula.VolumePro
    Else
      Base.QuantidadeDiluido     := TFloatUtils.fFormataFloat(dicRetorno['qtdb' + TStrUtils.fStrZero(intContador, 2)], 3) * Formula.VolumeOri  / Formula.VolumePro;

    Base.TipoBase := 'B';
  End;
end;

procedure TLibTintaTopCoat.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL := 'SELECT *          ' +
                    '  FROM COA_CADCOA ' +
                    ' WHERE COA_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('COA_CODIGO').AsString;
      dicRetorno['a_n_o_'] := qryGen.FieldByName('COA_ANOCOR').AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TLibTintaTopCoat.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaTopCoat.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
  Var
    strTraTopCoat: String;
    fltTraTopCoat: Double;
    conf: IConfTinta;
Begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('COA');

  If (dicDados['tippre'] = 'C') Then
  Begin
    strTraTopCoat := TAutcomTintaFactory.Get.IIF(conf.fGet('COATRV') = '1', 'VEN', 'CUS');
    fltTraTopCoat := conf.fGetDouble('COAFAT');
  End
  Else
  Begin
    strTraTopCoat := TAutcomTintaFactory.Get.IIF(conf.fGet('COATRV') = '3', 'VEN', 'CUS');
    fltTraTopCoat := conf.fGetDouble('COAFAT');
  End;

  If (strTraTopCoat = 'VEN') Then
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0);

  Result := TFloatUtils.fFormataFloat(Result * fltTraTopCoat, 2);
end;

end.
