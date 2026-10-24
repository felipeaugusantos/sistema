{******************************************-*************************************}
{* Classe contendo as informações especificas da tinta BrazilianColorAutomotiva *}
{*******************************************-************************************}
unit untLibTintaBrazilianColorAutomotiva;

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
  TLibTintaBrazilianColorAutomotiva = class(TAbstractLibTintaAutomotiva)
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

  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemBrazilianColorAutomotiva,
{$ENDIF}
  untFormulaAutomotivaBrazilianColorAutomotiva, untTintadeMaquinaWrapperBrazilianColorAutomotiva, untAutcomTintaFactory, untVariantUtils;

{ TBrazilianColorAutomotivaTintadeMaquina }

function TLibTintaBrazilianColorAutomotiva.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESBAS';
end;

function TLibTintaBrazilianColorAutomotiva.GetCodFormul(const dicRetorno: IDicionario): string;
begin
  Result := '';
end;

function TLibTintaBrazilianColorAutomotiva.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaBrazilianColorAutomotiva.Create(strTabPre);
end;

function TLibTintaBrazilianColorAutomotiva.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperBrazilianColorAutomotiva.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaBrazilianColorAutomotiva.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemBrazilianColorAutomotiva.Create();
{$ENDIF}
end;

function TLibTintaBrazilianColorAutomotiva.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORBZC';
end;

function TLibTintaBrazilianColorAutomotiva.GetNomeTinta: String;
begin
  Result := 'BrazilianColor Automotiva';
end;

function TLibTintaBrazilianColorAutomotiva.GetPrefixoTabela: String;
begin
  Result := 'BZC';
end;

function TLibTintaBrazilianColorAutomotiva.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String): String;
begin
  Result := '';
end;

function TLibTintaBrazilianColorAutomotiva.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result :=
    ' SELECT                                 ' +
    '   BAS_CODBAS                           ' +
    '   , BAS_CODITE                         ' +
    ' FROM                                   ' +
    '   BZC_CADBAS                           ' +
    ' WHERE BAS_CODBAS IN (' + strBases + ') ';
end;

function TLibTintaBrazilianColorAutomotiva.GetVolumeConcentrado: Double;
begin
  Result := 0.9;
end;

function TLibTintaBrazilianColorAutomotiva.GetVolumeDiluido: Double;
begin
  Result := 0.9;
end;

function TLibTintaBrazilianColorAutomotiva.GetVolumeOriginal(const dicRetorno: IDicionario): Double;
begin
  Result := 0.9;
end;

function TLibTintaBrazilianColorAutomotiva.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := dicRetorno['volpro'];
end;

procedure TLibTintaBrazilianColorAutomotiva.pProcessaFormulacaoGTinFor(
  Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet; dicBases: IDicionario;
  Const Formula: TAbstractFormulaAutomotiva; Const dicDados: IDicionario; var strBases: String);
var
  intCont: Integer;
  intAux : Integer;
begin
  intAux := 0;

  for intCont := 1 to formula.GetQuantidadeFormulacao do
  begin
    If qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicDados['tippre']) + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0 Then
      continue
    else
    Begin
      Inc(intAux);

      arrFormul[intAux].strFormul   := qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2)).AsString;

      arrFormul[intAux].fltQtdbas := qryConsulta.FieldByName(formula.GetPrefixoQuantidade(dicDados['tippre']) + TStrUtils.fStrZero(intCont, 2)).AsFloat;

      arrFormul[intAux].fltQtdbas := dicDados['volpro']  * arrFormul[intAux].fltQtdbas / 0.9;

      dicBases[arrFormul[intAux].strFormul] := arrFormul[intAux].fltQtdbas;

      strBases := strBases + QuotedStr(arrFormul[intAux].strFormul);

      If (Not TStrUtils.fEmptyStr(arrFormul[intAux].strFormul)) Then
        strBases := strBases + ', ';

    end;

  end;

end;

procedure TLibTintaBrazilianColorAutomotiva.pProcessaFormulacaoTabelaPreco(
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
      Base.QuantidadeConcentrado := TFloatUtils.fFormataFloat(dicRetorno['qtdb' + TStrUtils.fStrZero(intContador, 2)], 3) * Formula.VolumeOri / Formula.VolumePro
    Else
      Base.QuantidadeDiluido     := TFloatUtils.fFormataFloat(dicRetorno['qtdb' + TStrUtils.fStrZero(intContador, 2)], 3) * Formula.VolumeOri / Formula.VolumePro;

    Base.TipoBase := 'B';

  End;
end;

procedure TLibTintaBrazilianColorAutomotiva.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL := 'SELECT BZC_CODIGO '+
                    '     , BZC_CODUNI '+
                    '     , BZC_DESCRI '+
                    '     , BZC_A_N_O_ '+
                    '     , BZC_CODMON '+
                    '     , BZC_LINHA_ '+
                    '     , MON_DESCRI '+
                    '  FROM BZC_CADBZC '+
                    '  LEFT JOIN BZC_CADMON '+
                    '         ON BZC_CODMON = MON_CODMON '+
                    ' WHERE BZC_MD5KEY = :ITETIN ';


      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('BZC_CODIGO').AsString;
      dicRetorno['montad'] := qryGen.FieldByName('MON_DESCRI').AsString;
      dicRetorno['a_n_o_'] := qryGen.FieldByName('BZC_A_N_O_').AsString;
      dicRetorno['linha_'] := qryGen.FieldByName('BZC_LINHA_').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TLibTintaBrazilianColorAutomotiva.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaBrazilianColorAutomotiva.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
  Var
    strTraBrazilianColorAutomotiva: String;
    fltTraBrazilianColorAutomotiva: Double;
    conf: IConfTinta;
Begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('BZC');

  If (dicDados['tippre'] = 'C') Then
  Begin
    strTraBrazilianColorAutomotiva := TAutcomTintaFactory.Get.IIF(conf.fGet('TRABZC') = '1', 'VEN', 'CUS');
    fltTraBrazilianColorAutomotiva := conf.fGetDouble('FATZBC');
  End
  Else
  Begin
    strTraBrazilianColorAutomotiva := TAutcomTintaFactory.Get.IIF(conf.fGet('TRABZC') = '3', 'VEN', 'CUS');
    fltTraBrazilianColorAutomotiva := conf.fGetDouble('FATBZC');
  End;

  If (strTraBrazilianColorAutomotiva = 'VEN') Then
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0);

  Result := TFloatUtils.fFormataFloat(Result * fltTraBrazilianColorAutomotiva, 2);
end;

end.
