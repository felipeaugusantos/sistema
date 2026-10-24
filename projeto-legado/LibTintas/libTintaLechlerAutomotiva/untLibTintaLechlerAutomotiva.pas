{**************************************************************************}
{* Classe contendo as informações especificas da tinta LechlerAutomotiva *}
{***********************************************************************MH*}
unit untLibTintaLechlerAutomotiva;

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
  TLibTintaLechlerAutomotiva = class(TAbstractLibTintaAutomotiva)
  private
    strPorcentagem: String;
    strDiluente: String;
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
  untAuttinMenuItemLechlerAutomotiva,
{$ENDIF}
  untFormulaAutomotivaLechlerAutomotiva, untTintadeMaquinaWrapperLechlerAutomotiva, untAutcomTintaFactory, untVariantUtils;

{ TLechlerAutomotivaTintadeMaquina }

function TLibTintaLechlerAutomotiva.fRetornaCodigoChapinhaGeneric(
  strIdePro: String): String;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta(strIdePro).fGet('PROCHA');
end;

function TLibTintaLechlerAutomotiva.fRetPesoEspecificoBase(
  strCodBas: String): Double;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := '   SELECT BAS_PESESP     ' +
              ' FROM LCA_CADBAS            ' +
              '   WHERE BAS_CODBAS = :CODBAS ';
    qryGen.ParamByName('CODBAS').AsString := strCodBas;
    qryGen.Open;

    Result := qryGen.FieldByName('BAS_PESESP').AsFloat;
  Except
    Raise;
  End;
end;

function TLibTintaLechlerAutomotiva.fUsaChapinhaTintaGeneric(strIdePro,
  strIteTin: String): Boolean;
Var
  qryConsulta: IDataSet;
begin
  Result := False;

  qryConsulta := TAutcomTintaFactory.Get.fGetDataSet;
  qryConsulta.SQL := '  SELECT LCA_PROCHA FROM LCA_CADLCA WHERE LCA_MD5KEY = :ITETIN  ';
  qryConsulta.ParamByName('ITETIN').AsString := strIteTin;
  qryConsulta.Open;

  If qryConsulta.IsEmpty Then
    Exit;

  Result := (qryConsulta.FieldByName('LCA_PROCHA').AsString = 'S');
end;

function TLibTintaLechlerAutomotiva.GetCampoComponenteDesComp: String;
begin
  Result := 'BAS_DESCRI';
end;

function TLibTintaLechlerAutomotiva.GetCodFormul(const dicRetorno: IDicionario): string;
begin
  Result := TVariantUtils.IfNull(dicRetorno['codtin'],'') ;
end;

function TLibTintaLechlerAutomotiva.GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := TFormulaAutomotivaLechlerAutomotiva.Create(strTabPre);
end;

function TLibTintaLechlerAutomotiva.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperLechlerAutomotiva.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaLechlerAutomotiva.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemLechlerAutomotiva.Create();
{$ENDIF}
end;

function TLibTintaLechlerAutomotiva.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORLCA';
end;

function TLibTintaLechlerAutomotiva.GetNomeTinta: String;
begin
  Result := 'Lechler Automotiva';
end;

function TLibTintaLechlerAutomotiva.GetPrefixoTabela: String;
begin
  Result := 'LCA';
end;

function TLibTintaLechlerAutomotiva.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String): String;
begin
  Result := '';
end;

function TLibTintaLechlerAutomotiva.GetSQLBasesGTinFor(const strBases: string; const dicDados: IDicionario): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   BAS_CODBAS                                ' +
    '   , BAS_CODITE                              ' +
    ' FROM                                        ' +
    '   LCA_CADBAS                                ' +
    ' WHERE BAS_CODBAS IN (' + strBases + ') ';
end;

function TLibTintaLechlerAutomotiva.GetVolumeConcentrado: Double;
begin
  Result := 0.9;
end;

function TLibTintaLechlerAutomotiva.GetVolumeDiluido: Double;
begin
  Result := 0.9;
end;

function TLibTintaLechlerAutomotiva.GetVolumeOriginal(const dicRetorno: IDicionario): Double;
begin
  Result := 0.9;
end;

function TLibTintaLechlerAutomotiva.GetVolumePro(const dicRetorno: IDicionario): Double;
begin
  Result := dicRetorno['volpro'];
end;

procedure TLibTintaLechlerAutomotiva.pProcessaFormulacaoGTinFor(
  Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet; dicBases: IDicionario;
  Const Formula: TAbstractFormulaAutomotiva; Const dicDados: IDicionario; var strBases: String);
Var
  intCont: Integer;
  fltQuantidade:Double;
begin
  strPorcentagem := dicDados['pordil'];
  strDiluente := dicDados['coddil'];

  ProcessarBasesFormula(Formula, qryConsulta);

  If dicDados['tippre'] <> 'C' Then
    Formula.pReformulaNovo(dicDados['coddil'], dicDados['pordil'], qryConsulta);

  For intCont := 0 To Formula.Count - 1 Do
  Begin
    If dicDados['tippre'] = 'C' Then
      fltQuantidade := TBaseAutomotiva(Formula.Items[intCont]).QuantidadeConcentrado * dicDados['volpro']
    Else
      fltQuantidade := TBaseAutomotiva(Formula.Items[intCont]).QuantidadeDiluido * (dicDados['volpro'] / 0.9);

    arrFormul[intCont + 1].strFormul := TBaseAutomotiva(Formula.Items[intCont]).CodigoBase;
    arrFormul[intCont + 1].fltQtdbas := fltQuantidade;

    dicBases[arrFormul[intCont + 1].strFormul] := arrFormul[intCont + 1].fltQtdbas;
    strBases := strBases + QuotedStr(arrFormul[intCont + 1].strFormul);

    If (Not TStrUtils.fEmptyStr(arrFormul[intCont + 1].strFormul)) Then
      strBases := strBases + ', ';
  End;
end;

procedure TLibTintaLechlerAutomotiva.pProcessaFormulacaoTabelaPreco(
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
    Base.QuantidadeConcentrado := qryConsulta.FieldByName('LCA_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat * GetVolumeConcentrado;
    Base.TipoBase := 'B';
  End;

  Formula.pReformulaNovo(strDiluente, strPorcentagem, qryConsulta);
end;

procedure TLibTintaLechlerAutomotiva.ProcessarBasesFormula(
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
    objBase.CodigoBase            := qryConsulta.FieldByName('LCA_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString;
    objBase.QuantidadeConcentrado := qryConsulta.FieldByName('LCA_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
    objBase.TipoBase              := 'B';
    objBase.PesoEspecifico := fRetPesoEspecificoBase(objBase.CodigoBase);
  End;
end;

procedure TLibTintaLechlerAutomotiva.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryLCA: IDataSet;
begin
  Try
    Try
      qryLCA := TAutcomTintaFactory.Get.fGetDataSet;
      qryLCA.Close;
      qryLCA.SQL := 'SELECT *          ' +
                    '  FROM LCA_CADLCA ' +
                    ' WHERE LCA_MD5KEY = :ITETIN ';
      qryLCA.ParamByName('ITETIN').AsString := strIteTin;
      qryLCA.Open;

      if qryLCA.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryLCA.FieldByName('LCA_CODIGO').AsString;
      dicRetorno['a_n_o_'] := qryLCA.FieldByName('LCA_A_N_O_').AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TLibTintaLechlerAutomotiva.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaLechlerAutomotiva.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
  Var
    strTraLCA: String;
    fltTraLCA: Double;
    conf: IConfTinta;
Begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('LCA');

  strTraLCA := conf.fGet('LCATRA');
  fltTraLCA := conf.fGetDouble('LCAFAT');

  If (strTraLCA = 'VEN') Then
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0);

  Result := TFloatUtils.fFormataFloat(Result * fltTraLCA, 2);
end;

end.
