{***************************************************************}
{* Classe contendo as informações especificas da tinta Falcao *}
{************************************************************PH*}
unit untLibTintaFalcao;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaFalcao = class(TAbstractLibTintaImobiliaria)
  Private
    function RetornaPesoEspecifico(strFormul: String): Double;
  protected
    function GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria; override;
    function GetSQLColorantesGTinFor(const strColorantes: string): string; override;
  public
    function GetNomeTinta: String; override;
    function GetITintadeMaquina(): ITintadeMaquinaWrapper; override;
    function RetornaReferenciaTinta(const dtsTinta: IDataSet): String; override;
    function RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double; override;
    procedure RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario); override;
    function GetMenu: IAuttinMenuItem; override;
    function GetQuantidadeOncaPulsoMl(const fltPulsos: Double; var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String = ''): String; override;
    function GetNomeTabelaFormulacao: String; override;
    function GetCampoComponenteDesComp(): String; override;
    function GetQuantidadeGramaMl(const fltValor: Double; const Fator: Double; strFormula: String): Double; Override;
    function GetPrefixoTabela(): String; Override;


  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemFalcao,
{$ENDIF}
  untFormulaImobiliariaFalcao, untTintadeMaquinaWrapperFalcao, untAutcomTintaFactory, untVariantUtils;

{ TFalcaoTintadeMaquina }

function TLibTintaFalcao.GetCampoComponenteDesComp(): String;
begin
  Result := '""';
end;

function TLibTintaFalcao.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaFalcao.Create(strTabPre);
end;

function TLibTintaFalcao.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperFalcao.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaFalcao.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemFalcao.Create();
{$ENDIF}
end;

function TLibTintaFalcao.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORFAL';
end;

function TLibTintaFalcao.GetNomeTinta: String;
begin
  Result := 'Falcão';
end;

function TLibTintaFalcao.GetPrefixoTabela: String;
begin
  Result := 'FAL';
end;

function TLibTintaFalcao.GetQuantidadeGramaMl(const fltValor, Fator: Double;
  strFormula: String): Double;
Var
  fltPesoEspecifico: Double;
begin
  fltPesoEspecifico := RetornaPesoEspecifico(strFormula);

  Result := fltValor / fltPesoEspecifico;
end;

function TLibTintaFalcao.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String) : String;
Var
  fltPesoEspecifico: Double;
  fltQuantidade: Double;
  fltCalculo,
  fltInteiroOnca,
  fltFracaoOnca: Double;
begin
  Result := '';
  fltPesoEspecifico := RetornaPesoEspecifico(strFormul);
  fltQuantidade := fltPulsos / fltPesoEspecifico;
  fltCalculo     := (fltQuantidade / 48) / 0.61611520;
  fltInteiroOnca := Trunc(fltCalculo);
  fltFracaoOnca  := TAutcomTintaFactory.Get.fStrToFloat(FormatFloat('0.000', (fltCalculo - fltInteiroOnca) * 48));

  Result := Format('%dY%.1f', [Trunc(fltInteiroOnca), fltFracaoOnca]);
end;

function TLibTintaFalcao.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   FAL_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaFalcao.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL :=
        ' SELECT                     ' +
        '   FAL_CODIGO               ' +
        ' FROM                       ' +
        '   FAL_CADFAL               ' +
        ' WHERE FAL_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('FAL_CODIGO').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

function TLibTintaFalcao.RetornaPesoEspecifico(strFormul: String): Double;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   SELECT COL_PESESP FROM FAL_CADCOL WHERE COL_CODCOL = :CODCOL    ';
  qryGen.ParamByName('CODCOL').AsString := strFormul;
  qryGen.Open;

  Result := qryGen.FieldByName('COL_PESESP').AsFloat;
end;

function TLibTintaFalcao.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaFalcao.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('FAL');

  strSiglaTrava := conf.fGet('TRAFAL');
  fltFatTrava   := conf.fGetDouble('FATFAL');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
