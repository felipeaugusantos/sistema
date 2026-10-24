{**************************************************************************}
{* Classe contendo as informações especificas da tinta Roberlo *}
{***********************************************************************MH*}
unit untLibTintaRoberlo;

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
  TLibTintaRoberlo = class(TAbstractLibTintaAutomotiva)
  private
    fltPorDil: Double;
    fltVolPro: Double;
    fltPorPer: Double;
    function fRetPesoEspecificoBase(strCodBas: String): Double;
    function fRetQuantidadeConcentrada(qryConsulta: IDataSet; intQuantidade: Integer): Double;


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
  untAuttinMenuItemRoberlo,
{$ENDIF}
  untFormulaAutomotivaRoberlo, untTintadeMaquinaWrapperRoberlo, untAutcomTintaFactory, untVariantUtils;

{ TRoberloTintadeMaquina }

{function TLibTintaRoberlo.fValidarMd5Key(strIteTin: String): Boolean;
begin
  Result := True;
end;
 }
function TLibTintaRoberlo.fRetPesoEspecificoBase(strCodBas: String): Double;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.Close;
    qryGen.SQL := qryGen.SQL + '  SELECT                  ';
    qryGen.SQL := qryGen.SQL + '    BAS_PESESP            ';
    qryGen.SQL := qryGen.SQL + '  FROM                    ';
    qryGen.SQL := qryGen.SQL + '    ROB_CADBAS            ';
    qryGen.SQL := qryGen.SQL + '  WHERE                   ';
    qryGen.SQL := qryGen.SQL + '    BAS_CODBAS = :CODBAS        ';

    qryGen.ParamByName('CODBAS').AsString := strCodBas;
    qryGen.Open;

    Result := qryGen.FieldByName('BAS_PESESP').AsFloat;
  Except
    Raise;
  End;
end;

function TLibTintaRoberlo.fRetQuantidadeConcentrada(
  qryConsulta: IDataSet; intQuantidade: Integer): Double;
Var
  fltQtd: Double;
  fltQtdGrama: Double;
  fltVolumeMl: Double;
  intContador: Integer;
begin
  fltVolumeMl := 0;

  For intContador := 1 To 20 Do
  Begin

    If TStrUtils.fEmptyStr(qryConsulta.FieldByName('ROB_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
      Break;

    fltQtd := (qryConsulta.FieldByName('ROB_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat / 100) * 1000;
    fltVolumeMl := fltVolumeMl + (fltQtd / fRetPesoEspecificoBase(qryConsulta.FieldByName('ROB_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString));
  End;

  fltQtdGrama := (qryConsulta.FieldByName('ROB_QTDB' + TStrUtils.fStrZero(intQuantidade, 2)).AsFloat / 100) * 1000;
  Result := (fltQtdGrama / fltVolumeMl) * 1000;
end;

function TLibTintaRoberlo.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESCRI';
end;

function TLibTintaRoberlo.GetCodFormul(const dicRetorno: IDicionario): string;
begin
  Result := '';
end;

function TLibTintaRoberlo.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaRoberlo.Create(strTabPre);
end;

function TLibTintaRoberlo.GetInstrucaoRetComponentes(
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

function TLibTintaRoberlo.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperRoberlo.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaRoberlo.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemRoberlo.Create();
{$ENDIF}
end;

function TLibTintaRoberlo.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORROB';
end;

function TLibTintaRoberlo.GetNomeTinta: String;
begin
  Result := 'Roberlo';
end;

function TLibTintaRoberlo.GetPrefixoTabela: String;
begin
  Result := 'ROB';
end;

function TLibTintaRoberlo.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String): String;
begin
  Result := '';
end;

function TLibTintaRoberlo.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result :=
    '  SELECT                                      ' +
    '    BAS_CODBAS                                ' +
    '    , BAS_CODITE                              ' +
    '    , BAS_PESESP                              ' +
    '  FROM                                        ' +
    '    ROB_CADBAS                                ' +
    '  WHERE BAS_CODBAS IN (' + strBases + ')      ' ;
end;

function TLibTintaRoberlo.GetVolumeConcentrado: Double;
begin
  Result := 0.9;
end;

function TLibTintaRoberlo.GetVolumeDiluido: Double;
begin
  Result := 0.9;
end;

function TLibTintaRoberlo.GetVolumeOriginal(const dicRetorno: IDicionario): Double;
begin
  Result := 0.9;
end;

function TLibTintaRoberlo.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := dicRetorno['volpro'];
end;

procedure TLibTintaRoberlo.pProcessaFormulacaoGTinFor(
  Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet; dicBases: IDicionario;
  Const Formula: TAbstractFormulaAutomotiva; Const dicDados: IDicionario; var strBases: String);
Var
  intCont: Integer;
  objBase: TBaseAutomotiva;
  strFormula:String;
  strQuantidade:String;
  fltQuantidade:Double;
  intPos: Integer;
begin
  For intCont := 1 To 20 Do
  Begin
    strFormula := Formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2);
    strQuantidade := Formula.GetPrefixoQuantidade(dicDados['tippre']) + TStrUtils.fStrZero(intCont, 2);

    If TStrUtils.fEmptyStr(qryConsulta.FieldByName(strFormula).AsString) Then
      Break;

    objBase := TBaseAutomotiva(Formula.Add);
    objBase.CodigoBase := qryConsulta.FieldByName(strFormula).AsString;
    objBase.QuantidadeConcentrado := fRetQuantidadeConcentrada(qryConsulta, intCont);
    objBase.PesoEspecifico := fRetPesoEspecificoBase(ObjBase.CodigoBase);
    objBase.TipoBase := 'B';
  End;

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
      fltQuantidade := TBaseAutomotiva(Formula.Items[intCont]).QuantidadeConcentrado * fltVolPro
    Else
      fltQuantidade := TBaseAutomotiva(Formula.Items[intCont]).QuantidadeDiluido * fltVolPro;

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

procedure TLibTintaRoberlo.pProcessaFormulacaoTabelaPreco(
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

procedure TLibTintaRoberlo.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryROB: IDataSet;
begin
  Try
    Try
      qryROB := TAutcomTintaFactory.Get.fGetDataSet;
      qryROB.Close;
      qryROB.SQL := 'SELECT *          ' +
                    '  FROM ROB_CADROB ' +
                    ' WHERE ROB_MD5KEY = :ITETIN ';
      qryROB.ParamByName('ITETIN').AsString := strIteTin;
      qryROB.Open;

      if qryROB.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryROB.FieldByName('ROB_CODIGO').AsString;
      dicRetorno['martin'] := qryROB.FieldByName('ROB_MARCA_').AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TLibTintaRoberlo.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaRoberlo.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
  Var
    strTraROB: String;
    fltTraROB: Double;
    conf: IConfTinta;
Begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('ROB');

  strTraROB := conf.fGet('ROBTRA');
  fltTraROB := conf.fGetDouble('ROBFAT');

  If (strTraROB = 'VEN') Then
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0);

  Result := TFloatUtils.fFormataFloat(Result * fltTraROB, 2);
end;

end.
