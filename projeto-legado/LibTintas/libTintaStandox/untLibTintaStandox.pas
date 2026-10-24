{******************************************-*************************************}
{* Classe contendo as informações especificas da tinta Standox *}
{*******************************************-************************************}
unit untLibTintaStandox;

interface

uses
{$IFNDEF LINUX}
  Controls,
{$ENDIF}
  untAbstractLibTintaAutomotiva, untAbstractFormulaAutomotiva,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem, untFloatUtils, untBaseAutomotiva,
  untStrUtils, untGTinForTipos, Classes,StrUtils;

type
  TLibTintaStandox = class(TAbstractLibTintaAutomotiva)
  private
    fltPorDil: Double;
    fltVolPro: Double;
    function fRetPesoEspecificoBase(strCodBas: String): Double;

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

    function fRetornaQuantidadeBaixaGTinFor(dicBases: IDicionario; qryBases: IDataSet): Double; override;

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

    function fTruncaValor(fltValor: Double; intCasas: Integer): Double;
    function fArredondaValor(fltValor: Double; intCasas: Integer): Double;
    function fRetornaFatorDensidade(strTipPrg: String; fltQtdCon, fltPesEsp: Double): Double;
    function fRetornaTotalDensidade(strTipPrg: String; fltPorcen, fltDensid: Double): Double;
    function fCasasDecimaisQtd(strTipPrg: String): Integer;
    function fUsaChapinhaTintaGeneric(strIdePro, strIteTin: String): Boolean; Override;
    function fRetornaCodigoChapinhaGeneric(strIdePro: String): String; Override;


  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemStandox,
{$ENDIF}
  untFormulaAutomotivaStandox, untTintadeMaquinaWrapperStandox, untAutcomTintaFactory, untVariantUtils;

{ TStandoxTintadeMaquina }



function TLibTintaStandox.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESBAS';
end;

function TLibTintaStandox.GetCodFormul(const dicRetorno: IDicionario): string;
begin
  Result := '';
end;

function TLibTintaStandox.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaStandox.Create(strTabPre);
end;

function TLibTintaStandox.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperStandox.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaStandox.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemStandox.Create();
{$ENDIF}
end;

function TLibTintaStandox.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORDOX';
end;

function TLibTintaStandox.GetNomeTinta: String;
begin
  Result := 'Standox';
end;

function TLibTintaStandox.GetPrefixoTabela: String;
begin
  Result := 'DOX';
end;

function TLibTintaStandox.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String): String;
begin
  Result := '';
end;

function TLibTintaStandox.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result :=
    ' SELECT                                 ' +
    '     BAS_CODBAS                         ' +
    '   , BAS_CODITE                         ' +
    ' FROM                                   ' +
    '   DOX_CADBAS                           ' +
    ' WHERE BAS_CODBAS IN (' + strBases + ') ';
end;

function TLibTintaStandox.GetVolumeConcentrado: Double;
begin
  Result := 1;
end;

function TLibTintaStandox.GetVolumeDiluido: Double;
begin
  Result := 1;
end;

function TLibTintaStandox.GetVolumeOriginal(const dicRetorno: IDicionario): Double;
begin
  Result := 1;
end;

function TLibTintaStandox.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := dicRetorno['volpro'];
end;

procedure TLibTintaStandox.pProcessaFormulacaoGTinFor(
  Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet; dicBases: IDicionario;
  Const Formula: TAbstractFormulaAutomotiva; Const dicDados: IDicionario; var strBases: String);
Var
  intCont: Integer;
  objBase: TBaseAutomotiva;
  strFormula:String;
  strQuantidade:String;
  fltQuantidade:Double;
begin
  For intCont := 1 to 20 do
  begin

    strFormula := formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont,2);
    strQuantidade := formula.GetPrefixoQuantidade(dicDados['tippre']) + TStrUtils.fStrZero(intCont, 2);

    If TStrUtils.fEmptyStr(qryConsulta.FieldByName(strFormula).AsString) Then
      Break;

    objBase := TBaseAutomotiva(Formula.Add);
    objBase.CodigoBase := qryConsulta.FieldByName(strFormula).AsString;
    objBase.QuantidadeConcentrado := qryConsulta.FieldByName(strQuantidade).AsFloat;
    objBase.PesoEspecifico := fRetPesoEspecificoBase(objBase.CodigoBase);
    objBase.TipoBase := 'B';

  End;

  fltPorDil := dicDados['pordil'];
  fltVolPro := dicDados['volpro'];

  Formula.pReformulaNovo(dicDados['coddil'], dicDados['pordil']);


  For intCont := 0 To formula.Count - 1 Do
  Begin
    If dicDados['tippre'] = 'C' Then
      fltQuantidade := TBaseAutomotiva(Formula.Items[intCont]).QuantidadeConcentrado * dicDados['volpro']
    Else
      fltQuantidade := TBaseAutomotiva(Formula.Items[intCont]).QuantidadeDiluido * dicDados['volpro'];

    arrFormul[intCont + 1].strFormul := TBaseAutomotiva(Formula.Items[intCont]).CodigoBase;

    If (arrFormul[intCont + 1].strFormul = 'STBLCOATA') Or
      (arrFormul[intCont + 1].strFormul = 'STBLADJSL') Then
    Begin
      arrFormul[intCont + 1].fltQtdbas := TAutcomTintaFactory.Get.IIF(dicDados['pordil'] = 10, 92.7, 170.0) * dicDados['volpro'];
    End
    Else
    Begin
      arrFormul[intCont + 1].fltQtdbas := fltQuantidade;
    End;

    dicBases[arrFormul[intCont + 1].strFormul] := arrFormul[intCont + 1].fltQtdbas;

    strBases := strBases + QuotedStr(arrFormul[intCont + 1].strFormul);
    If (Not TStrUtils.fEmptyStr(arrFormul[intCont + 1].strFormul)) Then
      strBases := strBases + ', ';


  End;
end;

procedure TLibTintaStandox.pProcessaFormulacaoTabelaPreco(
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

procedure TLibTintaStandox.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL := 'SELECT * FROM DOX_CADDOX ' +
                    ' WHERE DOX_MD5KEY = :ITETIN ';


      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('DOX_CODDOX').AsString;
      dicRetorno['montad'] := qryGen.FieldByName('DOX_MONTAD').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TLibTintaStandox.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaStandox.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
Var
  conf: IConfTinta;
begin
  conf  := TAutcomTintaFactory.Get.fGetConfTinta('DOX');

  If conf.fGet('DOXPRE') = 'VEN' Then
    Result :=  TVariantUtils.IfNull(dicDados['unitar'],0) * conf.fGetDouble('DOXFAT')
  Else
    Result :=  TVariantUtils.IfNull(dicDados['precus' ],0) * conf.fGetDouble('DOXFAT');

  Result := TFloatUtils.fFormataFloat(Result, 2);
end;

function TLibTintaStandox.fArredondaValor(fltValor: Double;
  intCasas: Integer): Double;
begin
  Result := TAutcomTintaFactory.Get.fStrToFloat(FormatFloat('0.' + TStrUtils.fStrZero(0, intCasas), fltValor));
end;

function TLibTintaStandox.fCasasDecimaisQtd(
  strTipPrg: String): Integer;
begin
  Result := 4;

  If MatchStr(strTipPrg, ['1', '2']) Then
    Result := 5;
end;

function TLibTintaStandox.fRetornaCodigoChapinhaGeneric(
  strIdePro: String): String;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta(strIdePro).fGet('PROCHA');
end;

function TLibTintaStandox.fRetornaFatorDensidade(strTipPrg: String;
  fltQtdCon, fltPesEsp: Double): Double;
begin
  Result := fltQtdCon / fltPesEsp;

  If MatchStr(strTipPrg, ['1', '2']) Then
    Result := fTruncaValor(fltQtdCon / fltPesEsp, 2);
end;

function TLibTintaStandox.fRetornaQuantidadeBaixaGTinFor(dicBases: IDicionario;
  qryBases: IDataSet): Double;
begin
  If (qryBases.FieldByName('BAS_CODBAS').AsString = 'STBLCOATA') Or
    (qryBases.FieldByName('BAS_CODBAS').AsString = 'STBLADJSL') Then
    Result := TAutcomTintaFactory.Get.IIF(fltPorDil = 10, 92.7, 170.0) * fltVolPro
  Else
    Result := dicBases[qryBases.FieldByName(GetNomeCampoBaseCodBas).AsString];
end;

function TLibTintaStandox.fRetornaTotalDensidade(strTipPrg: String;
  fltPorcen, fltDensid: Double): Double;
begin
  Result := fltPorcen / fltDensid;

  If MatchStr(strTipPrg, ['1', '2']) Then
    Result := fTruncaValor(fltPorcen / fltDensid, 2);

end;

function TLibTintaStandox.fRetPesoEspecificoBase(strCodBas: String): Double;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := '   SELECT BAS_PESESP     ' +
              ' FROM DOX_CADBAS            ' +
              '   WHERE BAS_CODBAS = :CODBAS ';
    qryGen.ParamByName('CODBAS').AsString := strCodBas;
    qryGen.Open;

    Result := qryGen.FieldByName('BAS_PESESP').AsFloat;
  Except
    Raise;
  End;
end;

function TLibTintaStandox.fTruncaValor(fltValor: Double;
  intCasas: Integer): Double;
begin
  Result := TAutcomTintaFactory.Get.fStrToFloat((FloatToStr(Int(fltValor)) ) + Copy(FloatToStr(Frac(fltValor)), 2, (intCasas + 1) ) );
end;

function TLibTintaStandox.fUsaChapinhaTintaGeneric(strIdePro,
  strIteTin: String): Boolean;
Var
  qryConsulta: IDataSet;
begin
  Result := False;

  qryConsulta := TAutcomTintaFactory.Get.fGetDataSet;
  qryConsulta.SQL := '  SELECT DOX_PROCHA FROM DOX_CADDOX WHERE DOX_MD5KEY = :ITETIN  ';
  qryConsulta.ParamByName('ITETIN').AsString := strIteTin;
  qryConsulta.Open;

  If qryConsulta.IsEmpty Then
    Exit;

  Result := (qryConsulta.FieldByName('DOX_PROCHA').AsString = 'S');
end;

end.
