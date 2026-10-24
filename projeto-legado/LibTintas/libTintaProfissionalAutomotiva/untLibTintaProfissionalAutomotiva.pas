{**************************************************************************}
{* Classe contendo as informações especificas da tinta ProfissionalAutomotiva *}
{***********************************************************************MH*}
unit untLibTintaProfissionalAutomotiva;

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
  TLibTintaProfissionalAutomotiva = class(TAbstractLibTintaAutomotiva)
  private
    procedure ProcessarBasesFormula(Formula: TAbstractFormulaAutomotiva; qryConsulta: IDataSet);
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
  untAuttinMenuItemProfissionalAutomotiva,
{$ENDIF}
  untFormulaAutomotivaProfissionalAutomotiva, untTintadeMaquinaWrapperProfissionalAutomotiva, untAutcomTintaFactory, untVariantUtils;

{ TProfissionalAutomotivaTintadeMaquina }

function TLibTintaProfissionalAutomotiva.fRetornaCodigoChapinhaGeneric(
  strIdePro: String): String;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta(strIdePro).fGet('PROCHA');
end;

function TLibTintaProfissionalAutomotiva.fRetPesoEspecificoBase(
  strCodBas: String): Double;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := '   SELECT BAS_PESESP     ' +
              ' FROM PFA_CADBAS            ' +
              '   WHERE BAS_CODBAS = :CODBAS ';
    qryGen.ParamByName('CODBAS').AsString := strCodBas;
    qryGen.Open;

    Result := qryGen.FieldByName('BAS_PESESP').AsFloat;
  Except
    Raise;
  End;
end;

function TLibTintaProfissionalAutomotiva.fUsaChapinhaTintaGeneric(strIdePro,
  strIteTin: String): Boolean;
Var
  qryConsulta: IDataSet;
begin
  Result := False;

  qryConsulta := TAutcomTintaFactory.Get.fGetDataSet;
  qryConsulta.SQL := '  SELECT PFA_PROCHA FROM PFA_CADPFA WHERE PFA_MD5KEY = :ITETIN  ';
  qryConsulta.ParamByName('ITETIN').AsString := strIteTin;
  qryConsulta.Open;

  If qryConsulta.IsEmpty Then
    Exit;

  Result := (qryConsulta.FieldByName('PFA_PROCHA').AsString = 'S');
end;

function TLibTintaProfissionalAutomotiva.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESCRI';
end;

function TLibTintaProfissionalAutomotiva.GetCodFormul(const dicRetorno: IDicionario): string;
begin
  Result := TVariantUtils.IfNull(dicRetorno['codtin'],'') ;
end;

function TLibTintaProfissionalAutomotiva.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaProfissionalAutomotiva.Create(strTabPre);
end;

function TLibTintaProfissionalAutomotiva.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperProfissionalAutomotiva.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaProfissionalAutomotiva.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemProfissionalAutomotiva.Create();
{$ENDIF}
end;

function TLibTintaProfissionalAutomotiva.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORPFA';
end;

function TLibTintaProfissionalAutomotiva.GetNomeTinta: String;
begin
  Result := 'Profissional Automotiva';
end;

function TLibTintaProfissionalAutomotiva.GetPrefixoTabela: String;
begin
  Result := 'PFA';
end;

function TLibTintaProfissionalAutomotiva.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String): String;
begin
  Result := '';
end;

function TLibTintaProfissionalAutomotiva.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   BAS_CODBAS                                ' +
    '   , BAS_CODITE                              ' +
    ' FROM                                        ' +
    '   PFA_CADBAS                                ' +
    ' WHERE BAS_CODBAS IN (' + strBases + ') ';
end;

function TLibTintaProfissionalAutomotiva.GetVolumeConcentrado: Double;
begin
  Result := 0.9;
end;

function TLibTintaProfissionalAutomotiva.GetVolumeDiluido: Double;
begin
  Result := 0.9;
end;

function TLibTintaProfissionalAutomotiva.GetVolumeOriginal(const dicRetorno: IDicionario): Double;
begin
  Result := 0.9;
end;

function TLibTintaProfissionalAutomotiva.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := dicRetorno['volpro'];
end;

procedure TLibTintaProfissionalAutomotiva.pProcessaFormulacaoGTinFor(
  Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet; dicBases: IDicionario;
  Const Formula: TAbstractFormulaAutomotiva; Const dicDados: IDicionario; var strBases: String);
Var
  intCont: Integer;
  fltQuantidade:Double;
begin
  ProcessarBasesFormula(Formula, qryConsulta);

  For intCont := 0 To Formula.Count - 1 Do
  Begin
    fltQuantidade := TBaseAutomotiva(Formula.Items[intCont]).QuantidadeConcentrado * (dicDados['volpro'] / 0.9);

    arrFormul[intCont + 1].strFormul := TBaseAutomotiva(Formula.Items[intCont]).CodigoBase;
    arrFormul[intCont + 1].fltQtdbas := fltQuantidade;

    dicBases[arrFormul[intCont + 1].strFormul] := arrFormul[intCont + 1].fltQtdbas;
    strBases := strBases + QuotedStr(arrFormul[intCont + 1].strFormul);

    If (Not TStrUtils.fEmptyStr(arrFormul[intCont + 1].strFormul)) Then
      strBases := strBases + ', ';
  End;
end;

procedure TLibTintaProfissionalAutomotiva.pProcessaFormulacaoTabelaPreco(
  Formula: TAbstractFormulaAutomotiva; const dicRetorno: IDicionario; const qryConsulta: IDataSet);
var
  intContador: Integer;
  Base: TBaseAutomotiva;
begin
  For intContador := 1 To 20 Do
  Begin
    If (TStrUtils.fEmptyStr(TVariantUtils.IfNull(qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intContador, 2)).AsString, ''))) Then
      Continue;

    Base := TBaseAutomotiva(Formula.Add);
    Base.CodigoBase := qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intContador, 2)).AsString;
    Base.QuantidadeConcentrado := qryConsulta.FieldByName('PFA_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
    Base.TipoBase := 'B';
  End;
end;

procedure TLibTintaProfissionalAutomotiva.ProcessarBasesFormula(
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
    objBase.CodigoBase            := qryConsulta.FieldByName('PFA_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString;
    objBase.QuantidadeConcentrado := qryConsulta.FieldByName('PFA_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
    objBase.TipoBase              := 'B';
    objBase.PesoEspecifico := fRetPesoEspecificoBase(objBase.CodigoBase);
  End;
end;

procedure TLibTintaProfissionalAutomotiva.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryPFA: IDataSet;
begin
  Try
    Try
      qryPFA := TAutcomTintaFactory.Get.fGetDataSet;
      qryPFA.Close;
      qryPFA.SQL := 'SELECT *          ' +
                    '  FROM PFA_CADPFA ' +
                    ' WHERE PFA_MD5KEY = :ITETIN ';
      qryPFA.ParamByName('ITETIN').AsString := strIteTin;
      qryPFA.Open;

      if qryPFA.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryPFA.FieldByName('PFA_CODIGO').AsString;
      dicRetorno['a_n_o_'] := qryPFA.FieldByName('PFA_A_N_O_').AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TLibTintaProfissionalAutomotiva.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaProfissionalAutomotiva.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
  Var
    strTraPFA: String;
    fltTraPFA: Double;
    conf: IConfTinta;
Begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('PFA');

  strTraPFA := conf.fGet('PFATRA');
  fltTraPFA := conf.fGetDouble('PFAFAT');

  If (strTraPFA = 'VEN') Then
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0);

  Result := TFloatUtils.fFormataFloat(Result * fltTraPFA, 2);
end;

end.


