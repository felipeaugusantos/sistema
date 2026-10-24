{******************************************-*********************}
{* Classe contendo as informações especificas da tinta KillingIndustrial *}
{*******************************************-*****************AC*}
unit untLibTintaKillingIndustrial;

interface

uses
{$IFNDEF LINUX}
  Controls,
{$ENDIF}
  untAbstractLibTintaAutomotiva, untAbstractFormulaAutomotiva,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem, untFloatUtils, untBaseAutomotiva,
  untStrUtils, untGTinForTipos, Classes,
  untTipoTinta;

type
  TLibTintaKillingIndustrial = class(TAbstractLibTintaAutomotiva)
  private
    function fCalculaPesoEspecificoBase(strBase: String): Double;

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
    procedure PreencherPesCorFor(Formula: TAbstractFormulaAutomotiva;
      qryConsulta: IDataSet); override;
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
    function fTintaTipo: TTipoTinta; Override;
    // function fValidarMd5Key(strIteTin : String ) : Boolean; override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemKillingIndustrial,
{$ENDIF}
  untFormulaIndustrialKillingIndustrial, untTintadeMaquinaWrapperKillingIndustrial, untAutcomTintaFactory, untVariantUtils;

{ TKillingIndustrialTintadeMaquina }

{function TLibTintaKillingIndustrial.fValidarMd5Key(strIteTin: String): Boolean;
begin
  Result := True;
end;
 }
function TLibTintaKillingIndustrial.fCalculaPesoEspecificoBase(
  strBase: String): Double;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.Close;
    qryGen.SQL := '';
    qryGen.SQL := qryGen.SQL + '  SELECT                  ';
    qryGen.SQL := qryGen.SQL + '    BAS_PESESP            ';
    qryGen.SQL := qryGen.SQL + '  FROM                    ';
    qryGen.SQL := qryGen.SQL + '    KIN_CADBAS            ';
    qryGen.SQL := qryGen.SQL + '  WHERE                   ';
    qryGen.SQL := qryGen.SQL + '    BAS_CODBAS = :CODBAS        ';

    qryGen.ParamByName('CODBAS').AsString := strBase;
    qryGen.Open;

    Result := qryGen.FieldByName('BAS_PESESP').AsFloat;
  Except
    Raise;
  End;
end;

function TLibTintaKillingIndustrial.fTintaTipo: TTipoTinta;
begin
  Result := ttIndustrial;
end;

function TLibTintaKillingIndustrial.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESCRI';
end;

function TLibTintaKillingIndustrial.GetCodFormul(const dicRetorno: IDicionario): string;
begin
  Result := '';
end;

function TLibTintaKillingIndustrial.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaIndustrialKillingIndustrial.Create(strTabPre);
end;

function TLibTintaKillingIndustrial.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperKillingIndustrial.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaKillingIndustrial.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemKillingIndustrial.Create();
{$ENDIF}
end;

function TLibTintaKillingIndustrial.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORKIN';
end;

function TLibTintaKillingIndustrial.GetNomeTinta: String;
begin
  Result := 'Killing Industrial';
end;

function TLibTintaKillingIndustrial.GetPrefixoTabela: String;
begin
  Result := 'KIN';
end;

function TLibTintaKillingIndustrial.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String): String;
begin
  Result := '';
end;

function TLibTintaKillingIndustrial.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   BAS_CODBAS                                ' +
    '   , BAS_CODITE                              ' +
    ' FROM                                        ' +
    '   KIN_CADBAS                                ' +
    ' WHERE BAS_CODBAS IN (' + strBases + ')      ';
end;

function TLibTintaKillingIndustrial.GetVolumeConcentrado: Double;
begin
  Result := 0.9;
end;

function TLibTintaKillingIndustrial.GetVolumeDiluido: Double;
begin
  Result := 0;
end;

function TLibTintaKillingIndustrial.GetVolumeOriginal(const dicRetorno: IDicionario): Double;
begin
  Result := 0.9;
end;

function TLibTintaKillingIndustrial.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := dicRetorno['volpro'];
end;

procedure TLibTintaKillingIndustrial.pProcessaFormulacaoGTinFor(
  Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet; dicBases: IDicionario;
  Const Formula: TAbstractFormulaAutomotiva; Const dicDados: IDicionario; var strBases: String);
var
  intCont: Integer;
  fltPesoProduto: Double;
begin
  fltPesoProduto := 0;

  For intCont := 1 To Formula.GetQuantidadeFormulacao Do
  Begin

    If TStrUtils.fEmptyStr(qryConsulta.FieldByName(Formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2)).AsString) Then
      Break;

    fltPesoProduto := fltPesoProduto + (1 / fCalculaPesoEspecificoBase(qryConsulta.FieldByName(Formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2)).AsString) *
      qryConsulta.FieldByName(Formula.GetPrefixoQuantidade(dicDados['tippre']) + TStrUtils.fStrZero(intCont, 2)).AsFloat);
  End;

  fltPesoProduto := (100 / fltPesoProduto);


  for intCont := 1 to formula.GetQuantidadeFormulacao do
  begin
    If qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicDados['tippre']) + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 Then
      Break;

    arrFormul[intCont].strFormul   := qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2)).AsString;

      arrFormul[intCont].fltQtdbas := (dicDados['volpro'] * 1000) * ((fltPesoProduto / 100) *
        qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicDados['tippre']) + TStrUtils.fStrZero(intCont, 2)).AsFloat);

    dicBases[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;

    strBases := strBases + QuotedStr(arrFormul[intCont].strFormul);

    If (Not TStrUtils.fEmptyStr(arrFormul[intCont].strFormul)) Then
      strBases := strBases + ', ';
  end;
end;

procedure TLibTintaKillingIndustrial.pProcessaFormulacaoTabelaPreco(
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
      Base.QuantidadeConcentrado := TFloatUtils.fFormataFloat(qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicRetorno['tippre']) + TStrUtils.fStrZero(intContador, 2)).AsFloat, 4)
    Else
      Base.QuantidadeDiluido     := TFloatUtils.fFormataFloat(qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicRetorno['tippre']) + TStrUtils.fStrZero(intContador, 2)).AsFloat, 4);

    Base.TipoBase := 'B';
  End;
end;

procedure TLibTintaKillingIndustrial.PreencherPesCorFor(
  Formula: TAbstractFormulaAutomotiva; qryConsulta: IDataSet);
begin
  Formula.pPreencherPesCorFor(qryConsulta);
end;

procedure TLibTintaKillingIndustrial.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL := 'SELECT *          ' +
                    '  FROM KIN_CADKIN ' +
                    '  LEFT JOIN KIN_CADMON ON MON_CODMON = KIN_CODMON ' +
                    '  LEFT JOIN KIN_CADLIN ON LIN_CODIGO = KIN_LINHA_ ' +
                    ' WHERE KIN_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('KIN_CODIGO').AsString;
      dicRetorno['martin'] := qryGen.FieldByName('LIN_DESCRI').AsString;
      dicRetorno['montad'] := qryGen.FieldByName('MON_DESCRI').AsString;
      dicRetorno['a_n_o_'] := qryGen.FieldByName('KIN_ANOCOR').AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TLibTintaKillingIndustrial.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaKillingIndustrial.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
  Var
    strTraKillingIndustrial: String;
    fltTraKillingIndustrial: Double;
    conf: IConfTinta;
Begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('KIN');

  If (dicDados['tippre'] = 'C') Then
  Begin
    strTraKillingIndustrial := TAutcomTintaFactory.Get.IIF(conf.fGet('KINTRV') = '1', 'VEN', 'CUS');
    fltTraKillingIndustrial := conf.fGetDouble('KINFAT');
  End
  Else
  Begin
    strTraKillingIndustrial := TAutcomTintaFactory.Get.IIF(conf.fGet('KINTRV') = '3', 'VEN', 'CUS');
    fltTraKillingIndustrial := conf.fGetDouble('KINFAT');
  End;

  If (strTraKillingIndustrial = 'VEN') Then
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0);

  Result := TFloatUtils.fFormataFloat(Result * fltTraKillingIndustrial, 2);
end;

end.
