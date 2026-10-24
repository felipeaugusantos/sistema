{************************************************************************}
{* Classe contendo as informações especificas da tinta AnjoImobiliaria2 *}
{*********************************************************************AC*}
unit untLibTintaAnjoImobiliaria2;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaAnjoImobiliaria2 = class(TAbstractLibTintaImobiliaria)
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
    function GetQuantidadeMlPulso(const fltValor: Double; intDecFor: Integer; strFormul: String): String; Override;
    function GetPrefixoTabela(): String; Override;

  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemAnjoImobiliaria2,
{$ENDIF}
  untFormulaImobiliariaAnjoImobiliaria2, untTintadeMaquinaWrapperAnjoImobiliaria2, untAutcomTintaFactory, untVariantUtils;

{ TAnjoImobiliaria2TintadeMaquina }

function TLibTintaAnjoImobiliaria2.GetCampoComponenteDesComp(): String;
begin
  Result := 'COL_DESCRI';
end;

function TLibTintaAnjoImobiliaria2.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaAnjoImobiliaria2.Create(strTabPre);
end;

function TLibTintaAnjoImobiliaria2.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperAnjoImobiliaria2.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaAnjoImobiliaria2.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemAnjoImobiliaria2.Create();
{$ENDIF}
end;

function TLibTintaAnjoImobiliaria2.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORAN2';
end;

function TLibTintaAnjoImobiliaria2.GetNomeTinta: String;
begin
  Result := 'Anjo Imobiliária 2';
end;

function TLibTintaAnjoImobiliaria2.GetPrefixoTabela: String;
begin
  Result := 'AN2';
end;

function TLibTintaAnjoImobiliaria2.GetQuantidadeMlPulso(const fltValor: Double;
  intDecFor: Integer; strFormul: String): String;
begin
  Result := FloatToStrF(fltValor / 0.154, ffNumber, 12, intDecFor);
end;

function TLibTintaAnjoImobiliaria2.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String) : String;
var
  fltCalculo,
  fltInteiroOnca,
  fltFracaoOnca: Double;
begin
  fltCalculo     := (fltPulsos / 48) / 0.61611520;
  fltInteiroOnca := Trunc(fltCalculo);
  fltFracaoOnca  := TAutcomTintaFactory.Get.fStrToFloat(FormatFloat('0.000', (fltCalculo - fltInteiroOnca) * 48));

  Result := Format('%dY%.1f', [Trunc(fltInteiroOnca), fltFracaoOnca]);
end;

function TLibTintaAnjoImobiliaria2.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   AN2_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaAnjoImobiliaria2.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL :=
        ' SELECT                     ' +
        '   *                        ' +
        ' FROM                       ' +
        '   AN2_CADAN2            ' +
        ' WHERE AN2_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('AN2_CODIGO').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

function TLibTintaAnjoImobiliaria2.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaAnjoImobiliaria2.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('AN2');

  strSiglaTrava := conf.fGet('TRAAN2');
  fltFatTrava   := conf.fGetDouble('FATAN2');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
