{******************************************-*********************}
{* Classe contendo as informações especificas da tinta MiniFabrica *}
{*******************************************-*****************AC*}
unit untLibTintaMiniFabrica;

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
  TLibTintaMiniFabrica = class(TAbstractLibTintaAutomotiva)
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
  untAuttinMenuItemMiniFabrica,
{$ENDIF}
  untFormulaAutomotivaMiniFabrica, untTintadeMaquinaWrapperMiniFabrica, untAutcomTintaFactory, untVariantUtils;

{ TMiniFabricaTintadeMaquina }

function TLibTintaMiniFabrica.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESCRI';
end;

function TLibTintaMiniFabrica.GetCodFormul(const dicRetorno: IDicionario): string;
begin
  Result := TVariantUtils.IfNull(dicRetorno['codtin'],'') ;
end;

function TLibTintaMiniFabrica.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaMiniFabrica.Create(strTabPre);
end;

function TLibTintaMiniFabrica.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperMiniFabrica.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaMiniFabrica.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemMiniFabrica.Create();
{$ENDIF}
end;

function TLibTintaMiniFabrica.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORMIF';
end;

function TLibTintaMiniFabrica.GetNomeTinta: String;
begin
  Result := 'Mini Fábrica';
end;

function TLibTintaMiniFabrica.GetPrefixoTabela: String;
begin
  Result := 'MIF';
end;

function TLibTintaMiniFabrica.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String): String;
begin
  Result := '';
end;

function TLibTintaMiniFabrica.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   BAS_CODBAS                                ' +
    '   , BAS_CODITE                              ' +
    ' FROM                                        ' +
    '   MIF_CADBAS                                ' +
    ' WHERE BAS_CODBAS IN (' + strBases + ') ';
end;

function TLibTintaMiniFabrica.GetVolumeConcentrado: Double;
begin
  Result := 0.9;
end;

function TLibTintaMiniFabrica.GetVolumeDiluido: Double;
begin
  Result := 0.9;
end;

function TLibTintaMiniFabrica.GetVolumeOriginal(
  const dicRetorno: IDicionario): Double;
begin
  Result := 0.9;
end;

function TLibTintaMiniFabrica.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := dicRetorno['volpro'];
end;

procedure TLibTintaMiniFabrica.pProcessaFormulacaoGTinFor(
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

procedure TLibTintaMiniFabrica.pProcessaFormulacaoTabelaPreco(
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

procedure TLibTintaMiniFabrica.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL := 'SELECT *          ' +
                    '  FROM MIF_CADMIF ' +
                    ' WHERE MIF_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('MIF_CODIGO').AsString;
      dicRetorno['a_n_o_'] := qryGen.FieldByName('MIF_ANOCOR').AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TLibTintaMiniFabrica.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaMiniFabrica.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
  Var
    strTraMiniFabrica: String;
    fltTraMiniFabrica: Double;
    conf: IConfTinta;
Begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('MIF');

  If (dicDados['tippre'] = 'C') Then
  Begin
    strTraMiniFabrica := TAutcomTintaFactory.Get.IIF(conf.fGet('MIFTRV') = '1', 'VEN', 'CUS');
    fltTraMiniFabrica := conf.fGetDouble('MIFFAT');
  End
  Else
  Begin
    strTraMiniFabrica := TAutcomTintaFactory.Get.IIF(conf.fGet('MIFTRV') = '3', 'VEN', 'CUS');
    fltTraMiniFabrica := conf.fGetDouble('MIFFAT');
  End;

  If (strTraMiniFabrica = 'VEN') Then
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0);

  Result := TFloatUtils.fFormataFloat(Result * fltTraMiniFabrica, 2);
end;

end.
