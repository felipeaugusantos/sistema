{************************************************************************}
{* Classe contendo as informações especificas da tinta AnjoSintetica *}
{*********************************************************************AC*}
unit untLibTintaAnjoSintetica;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaAnjoSintetica = class(TAbstractLibTintaImobiliaria)
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
  untAuttinMenuItemAnjoSintetica,
{$ENDIF}
  untFormulaImobiliariaAnjoSintetica, untTintadeMaquinaWrapperAnjoSintetica, untAutcomTintaFactory, untVariantUtils;

{ TAnjoSinteticaTintadeMaquina }

function TLibTintaAnjoSintetica.GetCampoComponenteDesComp(): String;
begin
  Result := 'COL_DESCRI';
end;

function TLibTintaAnjoSintetica.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaAnjoSintetica.Create(strTabPre);
end;

function TLibTintaAnjoSintetica.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperAnjoSintetica.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaAnjoSintetica.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemAnjoSintetica.Create();
{$ENDIF}
end;

function TLibTintaAnjoSintetica.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORAJA';
end;

function TLibTintaAnjoSintetica.GetNomeTinta: String;
begin
  Result := 'Anjo Sintética';
end;

function TLibTintaAnjoSintetica.GetPrefixoTabela: String;
begin
  Result := 'AJA';
end;

function TLibTintaAnjoSintetica.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
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

function TLibTintaAnjoSintetica.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   AJA_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaAnjoSintetica.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
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
        '   AJA_CADAJA            ' +
        ' WHERE AJA_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('AJA_DESCRI').AsString +
                              qryGen.FieldByName('AJA_CODIGO').AsString +
                              qryGen.FieldByName('AJA_CODIG2').AsString +
                              qryGen.FieldByName('AJA_UNIDAD').AsString +
                              qryGen.FieldByName('AJA_PROKEY').AsString +
                              qryGen.FieldByName('AJA_SUBKEY').AsString +
                              qryGen.FieldByName('AJA_BASE__').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

function TLibTintaAnjoSintetica.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';//dtsTinta.FieldByName('AJA_REFERE').AsString;
end;

function TLibTintaAnjoSintetica.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('AJA');

  strSiglaTrava := conf.fGet('TRAAJA');
  fltFatTrava   := conf.fGetDouble('FATAJA');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
