{************************************************************************}
{* Classe contendo as informações especificas da tinta Resicolor *}
{*********************************************************************AC*}
unit untLibTintaResicolor;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaResicolor = class(TAbstractLibTintaImobiliaria)
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
    function GetPrefixoTabela(): String; Override;

  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemResicolor,
{$ENDIF}
  untFormulaImobiliariaResicolor, untTintadeMaquinaWrapperResicolor, untAutcomTintaFactory, untVariantUtils;

{ TResicolorTintadeMaquina }

function TLibTintaResicolor.GetCampoComponenteDesComp(): String;
begin
  Result := 'COL_DESCRI';
end;

function TLibTintaResicolor.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaResicolor.Create(strTabPre);
end;

function TLibTintaResicolor.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperResicolor.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaResicolor.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemResicolor.Create();
{$ENDIF}
end;

function TLibTintaResicolor.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORRSI';
end;

function TLibTintaResicolor.GetNomeTinta: String;
begin
  Result := 'Resicolor';
end;

function TLibTintaResicolor.GetPrefixoTabela: String;
begin
  Result := 'RSI';
end;

function TLibTintaResicolor.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
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

function TLibTintaResicolor.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   RSI_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaResicolor.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
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
        '   RSI_CADRSI            ' +
        ' WHERE RSI_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('RSI_DESCRI').AsString +
                              qryGen.FieldByName('RSI_BASE__').AsString +
                              qryGen.FieldByName('RSI_CODIGO').AsString +
                              qryGen.FieldByName('RSI_CODIG2').AsString +
                              qryGen.FieldByName('RSI_PROKEY').AsString +
                              qryGen.FieldByName('RSI_SUBKEY').AsString +
                              qryGen.FieldByName('RSI_UNIDAD').AsString ;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

function TLibTintaResicolor.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';//dtsTinta.FieldByName('RSI_REFERE').AsString;
end;

function TLibTintaResicolor.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('RSI');

  strSiglaTrava := conf.fGet('TRARSI');
  fltFatTrava   := conf.fGetDouble('FATRSI');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
