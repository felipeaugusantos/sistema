{***************************************************************************}
{* Classe contendo as informações especificas da tinta BrasimixImobiliaria *}
{************************************************************************AC*}
unit untLibTintaBrasimixImobiliaria;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaBrasimixImobiliaria = class(TAbstractLibTintaImobiliaria)
  Private
    function RetornaPesoEspecifico(strFormul: String): Double;
  protected
    function GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria; override;
    function GetSQLColorantesGTinFor(const strColorantes: string): string; override;
    function fRetornaQuantidadeBaixaPigmentos(fltQtdBai: Double; const dataSet: IDataSet): Double; override;
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
    function GetPrefixoTabela(): String; Override;
    function GetQuantidadeGramaMl(const fltValor: Double; const Fator: Double; strFormula: String): Double; Override;
    function GetQuantidadeMlPulso(const fltValor: Double; intDecFor: Integer; strFormul: String): String; Override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemBrasimixImobiliaria,
{$ENDIF}
  untFormulaImobiliariaBrasimixImobiliaria, untTintadeMaquinaWrapperBrasimixImobiliaria,
  untAutcomTintaFactory, untVariantUtils,
  untMultiSelectLocalizadorFactory;

{ TBrasimixImobiliariaTintadeMaquina }

function TLibTintaBrasimixImobiliaria.fRetornaQuantidadeBaixaPigmentos(
  fltQtdBai: Double; const dataSet: IDataSet): Double;
begin
  Result := fltQtdBai;
end;

function TLibTintaBrasimixImobiliaria.GetCampoComponenteDesComp(): String;
begin
  Result := '""';
end;

function TLibTintaBrasimixImobiliaria.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaBrasimixImobiliaria.Create(strTabPre);
end;

function TLibTintaBrasimixImobiliaria.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperBrasimixImobiliaria.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaBrasimixImobiliaria.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemBrasimixImobiliaria.Create();
{$ENDIF}
end;

function TLibTintaBrasimixImobiliaria.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORBZI';
end;

function TLibTintaBrasimixImobiliaria.GetNomeTinta: String;
begin
  Result := 'Brasimix Imobiliária';
end;

function TLibTintaBrasimixImobiliaria.GetPrefixoTabela: String;
begin
  Result := 'BZI';
end;

function TLibTintaBrasimixImobiliaria.GetQuantidadeGramaMl(const fltValor,
  Fator: Double; strFormula: String): Double;
Var
  fltPesoEspecifico: Double;
begin
  fltPesoEspecifico := RetornaPesoEspecifico(strFormula);
  Result := fltValor / fltPesoEspecifico;
end;

function TLibTintaBrasimixImobiliaria.GetQuantidadeMlPulso(
  const fltValor: Double; intDecFor: Integer; strFormul: String): String;
Var
  fltPesoEspecifico: Double;
  fltMl: Double;
begin
  fltPesoEspecifico := RetornaPesoEspecifico(strFormul);
  fltMl := fltValor / fltPesoEspecifico;

  Result := FloatToStrF(fltMl / 0.154, ffNumber, 12, intDecFor);
end;

function TLibTintaBrasimixImobiliaria.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String) : String;
var
  fltCalculo,
  fltInteiroOnca,
  fltFracaoOnca: Double;
  fltPesoEspecifico: Double;
begin
  fltPesoEspecifico := RetornaPesoEspecifico(strFormul);
  fltCalculo := fltPulsos /  fltPesoEspecifico;

  fltCalculo     := (fltCalculo / 48) / 0.61611520;
  fltInteiroOnca := Trunc(fltCalculo);
  fltFracaoOnca  := TAutcomTintaFactory.Get.fStrToFloat(FormatFloat('0.000', (fltCalculo - fltInteiroOnca) * 48));
  Result := Format('%dY%.1f', [Trunc(fltInteiroOnca), fltFracaoOnca]);
end;

function TLibTintaBrasimixImobiliaria.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    '   , COL_PESESP                              ' +
    ' FROM                                        ' +
    '   BZI_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaBrasimixImobiliaria.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      If TMultiSelectLocalizadorFactory.GetLocalizador('BZI').Localizar(qryGen, ['ITETIN'], [strIteTin]) Then
      Begin
        dicRetorno['codtin'] := qryGen.FieldByName('BZI_CODIGO').AsString;
        dicRetorno['martin'] := qryGen.FieldByName('BZI_REFERE').AsString;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

function TLibTintaBrasimixImobiliaria.RetornaPesoEspecifico(
  strFormul: String): Double;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   SELECT COL_PESESP FROM BZI_CADCOL WHERE COL_CODCOL = :CODCOL    ';
  qryGen.ParamByName('CODCOL').AsString := strFormul;
  qryGen.Open;

  If qryGen.IsEmpty Then
    Result := 1
  Else
    Result := qryGen.FieldByName('COL_PESESP').AsFloat;
end;

function TLibTintaBrasimixImobiliaria.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := dtsTinta.FieldByName('BZI_REFERE').AsString;
end;

function TLibTintaBrasimixImobiliaria.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('BZI');

  strSiglaTrava := conf.fGet('TRABRI');
  fltFatTrava   := conf.fGetDouble('FATBRI');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
