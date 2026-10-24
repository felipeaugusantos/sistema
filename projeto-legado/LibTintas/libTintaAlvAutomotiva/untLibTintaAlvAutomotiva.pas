{**************************************************************************}
{* Classe contendo as informações especificas da tinta AlvAutomotiva *}
{***********************************************************************MH*}
unit untLibTintaAlvAutomotiva;

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
  TLibTintaAlvAutomotiva = class(TAbstractLibTintaAutomotiva)
  private
    fltPorDil: Double;
    fltVolPro: Double;
    fltPorPer: Double;
    function fRetPesoEspecificoBase(strCodBas: String): Double;
    procedure ProcessarBasesFormula(Formula: TAbstractFormulaAutomotiva; qryConsulta: IDataSet);

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
    function fUsaChapinhaTintaGeneric(strIdePro, strIteTin: String): Boolean; Override;
    function fRetornaCodigoChapinhaGeneric(strIdePro: String): String; Override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemAlvAutomotiva,
{$ENDIF}
  untFormulaAutomotivaAlvAutomotiva, untTintadeMaquinaWrapperAlvAutomotiva, untAutcomTintaFactory, untVariantUtils;

{ TAlvAutomotivaTintadeMaquina }

function TLibTintaAlvAutomotiva.fRetornaCodigoChapinhaGeneric(
  strIdePro: String): String;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta(strIdePro).fGet('PROCHA');
end;

function TLibTintaAlvAutomotiva.fUsaChapinhaTintaGeneric(strIdePro,
  strIteTin: String): Boolean;
Var
  qryConsulta: IDataSet;
begin
  Result := False;

  qryConsulta := TAutcomTintaFactory.Get.fGetDataSet;
  qryConsulta.SQL := '  SELECT ALA_PROCHA FROM ALA_CADALA WHERE ALA_MD5KEY = :ITETIN  ';
  qryConsulta.ParamByName('ITETIN').AsString := strIteTin;
  qryConsulta.Open;

  If qryConsulta.IsEmpty Then
    Exit;

  Result := (qryConsulta.FieldByName('ALA_PROCHA').AsString = 'S');
end;

function TLibTintaAlvAutomotiva.fRetPesoEspecificoBase(strCodBas: String): Double;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.Close;
    qryGen.SQL := qryGen.SQL + '  SELECT                  ';
    qryGen.SQL := qryGen.SQL + '    BAS_PESESP            ';
    qryGen.SQL := qryGen.SQL + '  FROM                    ';
    qryGen.SQL := qryGen.SQL + '    ALA_CADBAS            ';
    qryGen.SQL := qryGen.SQL + '  WHERE                   ';
    qryGen.SQL := qryGen.SQL + '    BAS_CODBAS = :CODBAS        ';

    qryGen.ParamByName('CODBAS').AsString := strCodBas;
    qryGen.Open;

    Result := qryGen.FieldByName('BAS_PESESP').AsFloat;
  Except
    Raise;
  End;
end;

function TLibTintaAlvAutomotiva.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESCRI';
end;

function TLibTintaAlvAutomotiva.GetCodFormul(const dicRetorno: IDicionario): string;
begin
  Result := '';
end;

function TLibTintaAlvAutomotiva.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaAlvAutomotiva.Create(strTabPre);
end;

function TLibTintaAlvAutomotiva.GetInstrucaoRetComponentes(
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
end;

function TLibTintaAlvAutomotiva.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperAlvAutomotiva.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaAlvAutomotiva.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemAlvAutomotiva.Create();
{$ENDIF}
end;

function TLibTintaAlvAutomotiva.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORALA';
end;

function TLibTintaAlvAutomotiva.GetNomeTinta: String;
begin
  Result := 'ALV Automotiva';
end;

function TLibTintaAlvAutomotiva.GetPrefixoTabela: String;
begin
  Result := 'ALA';
end;

function TLibTintaAlvAutomotiva.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String): String;
begin
  Result := '';
end;

function TLibTintaAlvAutomotiva.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result :=
    '  SELECT                                      ' +
    '    BAS_CODBAS                                ' +
    '    , BAS_CODITE                              ' +
    '    , BAS_PESESP                              ' +
    '  FROM                                        ' +
    '    ALA_CADBAS                                ' +
    '  WHERE BAS_CODBAS IN (' + strBases + ')      ' ;
end;

function TLibTintaAlvAutomotiva.GetVolumeConcentrado: Double;
begin
  Result := 0.9;
end;

function TLibTintaAlvAutomotiva.GetVolumeDiluido: Double;
begin
  Result := 0.9;
end;

function TLibTintaAlvAutomotiva.GetVolumeOriginal(const dicRetorno: IDicionario): Double;
begin
  Result := 0.9;
end;

function TLibTintaAlvAutomotiva.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := dicRetorno['volpro'];
end;

procedure TLibTintaAlvAutomotiva.pProcessaFormulacaoGTinFor(
  Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet; dicBases: IDicionario;
  Const Formula: TAbstractFormulaAutomotiva; Const dicDados: IDicionario; var strBases: String);
Var
  intCont: Integer;
  fltQuantidade:Double;
  intPos: Integer;
begin
  ProcessarBasesFormula(Formula, qryConsulta);

  intPos := Pos(';', dicDados['catalize']);

  fltPorDil := dicDados['pordil'];
  fltPorPer := StrToFloat(Copy(dicDados['catalize'], intPos + 1, Length(dicDados['catalize'])));
  fltVolPro := dicDados['volpro'];

  Formula.PerfomanceAgent := fltPorPer > 0;

  Formula.pCalculaBaseAdicional(FloatToStr(fltPorPer), qryConsulta, Copy(dicDados['catalize'], 1, intPos - 1));

  Formula.pReformulaNovo(dicDados['coddil'], dicDados['pordil']);

  For intCont := 0 To Formula.Count - 1 Do
  Begin
    If dicDados['tippre'] = 'C' Then
      fltQuantidade := TBaseAutomotiva(Formula.Items[intCont]).QuantidadeConcentrado * (fltVolPro / 0.9)
    Else
      fltQuantidade := TBaseAutomotiva(Formula.Items[intCont]).QuantidadeDiluido * (fltVolPro / 0.9);

    If fltQuantidade <= 0 Then
      Continue;

    arrFormul[intCont + 1].strFormul := TBaseAutomotiva(Formula.Items[intCont]).CodigoBase;
    arrFormul[intCont + 1].fltQtdbas := fltQuantidade;

    dicBases[arrFormul[intCont + 1].strFormul] := arrFormul[intCont + 1].fltQtdbas;
    strBases := strBases + QuotedStr(arrFormul[intCont + 1].strFormul);

    If (Not TStrUtils.fEmptyStr(arrFormul[intCont + 1].strFormul)) Then
      strBases := strBases + ', ';
  End;
end;

procedure TLibTintaAlvAutomotiva.pProcessaFormulacaoTabelaPreco(
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
      Base.QuantidadeConcentrado :=
        TFloatUtils.fFormataFloat(dicRetorno['qtdb' + TStrUtils.fStrZero(intContador, 2)], 3) * Formula.VolumeOri / Formula.VolumePro
    Else
      Base.QuantidadeDiluido     :=
        TFloatUtils.fFormataFloat(dicRetorno['qtdb' + TStrUtils.fStrZero(intContador, 2)], 3) * Formula.VolumeOri / Formula.VolumePro;

    Base.TipoBase := 'B';
  End;

end;

procedure TLibTintaAlvAutomotiva.ProcessarBasesFormula(
  Formula: TAbstractFormulaAutomotiva; qryConsulta: IDataSet);
Var
  intCont: Integer;
  objBase: TBaseAutomotiva;
begin
  For intCont := 1 To formula.GetQuantidadeFormulacao Do
  Begin
    If qryConsulta.FieldByName(formula.GetPrefixoQuantidade('') + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 Then
      Break;

    objBase := TBaseAutomotiva(Formula.Add);
    objBase.CodigoBase            := qryConsulta.FieldByName('ALA_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString;
    objBase.QuantidadeConcentrado := qryConsulta.FieldByName('ALA_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
    objBase.TipoBase              := 'B';
    objBase.PesoEspecifico := fRetPesoEspecificoBase(objBase.CodigoBase);
  End;
end;

procedure TLibTintaAlvAutomotiva.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryALA: IDataSet;
begin
  Try
    Try
      qryALA := TAutcomTintaFactory.Get.fGetDataSet;
      qryALA.Close;
      qryALA.SQL := 'SELECT *          ' +
                    '  FROM ALA_CADALA ' +
                    ' WHERE ALA_MD5KEY = :ITETIN ';
      qryALA.ParamByName('ITETIN').AsString := strIteTin;
      qryALA.Open;

      if qryALA.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryALA.FieldByName('ALA_CODIGO').AsString;
      dicRetorno['a_n_o_'] := qryALA.FieldByName('ALA_ANOCOR').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TLibTintaAlvAutomotiva.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaAlvAutomotiva.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
  Var
    strTraALA: String;
    fltTraALA: Double;
    conf: IConfTinta;
Begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('ALA');

  strTraALA := conf.fGet('ALATRA');
  fltTraALA := conf.fGetDouble('ALAFAT');

  If (strTraALA = 'VEN') Then
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0);

  Result := TFloatUtils.fFormataFloat(Result * fltTraALA, 2);
end;

end.
