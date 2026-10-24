{******************************************-*********************}
{* Classe contendo as informações especificas da tinta BlascorAutomotiva *}
{*******************************************-*****************AC*}
unit untLibTintaBlascorAutomotiva;

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
  TLibTintaBlascorAutomotiva = class(TAbstractLibTintaAutomotiva)
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
    function fUsaChapinhaTintaGeneric(strIdePro, strIteTin: String): Boolean; Override;
    function fRetornaCodigoChapinhaGeneric(strIdePro: String): String; Override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemBlascorAutomotiva,
{$ENDIF}
  untFormulaAutomotivaBlascorAutomotiva, untTintadeMaquinaWrapperBlascorAutomotiva, untAutcomTintaFactory, untVariantUtils;

{ TBlascorAutomotivaTintadeMaquina }

function TLibTintaBlascorAutomotiva.fRetornaCodigoChapinhaGeneric(
  strIdePro: String): String;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta(strIdePro).fGet('PROCHA');
end;

function TLibTintaBlascorAutomotiva.fUsaChapinhaTintaGeneric(strIdePro,
  strIteTin: String): Boolean;
Var
  qryConsulta: IDataSet;
begin
  Result := False;

  qryConsulta := TAutcomTintaFactory.Get.fGetDataSet;
  qryConsulta.SQL := '  SELECT BLA_PROCHA FROM BLA_CADBLA WHERE BLA_MD5KEY = :ITETIN  ';
  qryConsulta.ParamByName('ITETIN').AsString := strIteTin;
  qryConsulta.Open;

  If qryConsulta.IsEmpty Then
    Exit;

  Result := (qryConsulta.FieldByName('BLA_PROCHA').AsString = 'S');
end;

function TLibTintaBlascorAutomotiva.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESCRI';
end;

function TLibTintaBlascorAutomotiva.GetCodFormul(const dicRetorno: IDicionario): string;
begin
  Result := TVariantUtils.IfNull(dicRetorno['codtin'],'') ;
end;

function TLibTintaBlascorAutomotiva.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaBlascorAutomotiva.Create(strTabPre);
end;

function TLibTintaBlascorAutomotiva.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperBlascorAutomotiva.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaBlascorAutomotiva.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemBlascorAutomotiva.Create();
{$ENDIF}
end;

function TLibTintaBlascorAutomotiva.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORBLA';
end;

function TLibTintaBlascorAutomotiva.GetNomeTinta: String;
begin
  Result := 'Blascor Automotiva';
end;

function TLibTintaBlascorAutomotiva.GetPrefixoTabela: String;
begin
  Result := 'BLA';
end;

function TLibTintaBlascorAutomotiva.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String): String;
begin
  Result := '';
end;

function TLibTintaBlascorAutomotiva.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   BAS_CODBAS                                ' +
    '   , BAS_CODITE                              ' +
    ' FROM                                        ' +
    '   BLA_CADBAS                                ' +
    ' WHERE BAS_CODBAS IN (' + strBases + ') ';
end;

function TLibTintaBlascorAutomotiva.GetVolumeConcentrado: Double;
begin
  Result := 0.9;
end;

function TLibTintaBlascorAutomotiva.GetVolumeDiluido: Double;
begin
  Result := 0.9;
end;

function TLibTintaBlascorAutomotiva.GetVolumeOriginal(
  const dicRetorno: IDicionario): Double;
begin
  Result := 0.9;
end;

function TLibTintaBlascorAutomotiva.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := dicRetorno['volpro'];
end;

procedure TLibTintaBlascorAutomotiva.pProcessaFormulacaoGTinFor(
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

procedure TLibTintaBlascorAutomotiva.pProcessaFormulacaoTabelaPreco(
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

procedure TLibTintaBlascorAutomotiva.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL := 'SELECT *          ' +
                    '  FROM BLA_CADBLA ' +
                    ' WHERE BLA_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('BLA_CODIGO').AsString;
      dicRetorno['a_n_o_'] := qryGen.FieldByName('BLA_ANOINI').AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TLibTintaBlascorAutomotiva.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaBlascorAutomotiva.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
  Var
    strTraBlascorAutomotiva: String;
    fltTraBlascorAutomotiva: Double;
    conf: IConfTinta;
Begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('BLA');

  If (dicDados['tippre'] = 'C') Then
  Begin
    strTraBlascorAutomotiva := TAutcomTintaFactory.Get.IIF(conf.fGet('BLATRV') = '1', 'VEN', 'CUS');
    fltTraBlascorAutomotiva := conf.fGetDouble('BLAFAT');
  End
  Else
  Begin
    strTraBlascorAutomotiva := TAutcomTintaFactory.Get.IIF(conf.fGet('BLATRV') = '3', 'VEN', 'CUS');
    fltTraBlascorAutomotiva := conf.fGetDouble('BLAFAT');
  End;

  If (strTraBlascorAutomotiva = 'VEN') Then
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0);

  Result := TFloatUtils.fFormataFloat(Result * fltTraBlascorAutomotiva, 2);
end;

end.
