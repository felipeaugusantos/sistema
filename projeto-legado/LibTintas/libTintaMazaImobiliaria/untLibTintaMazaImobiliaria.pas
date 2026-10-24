{* Classe contendo as informações especificas da tinta MazaImobiliaria *}
{************************************************************PH*}
unit untLibTintaMazaImobiliaria;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaMazaImobiliaria = class(TAbstractLibTintaImobiliaria)
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
  untAuttinMenuItemMazaImobiliaria,
{$ENDIF}
  untFormulaImobiliariaMazaImobiliaria, untTintadeMaquinaWrapperMazaImobiliaria, untAutcomTintaFactory, untVariantUtils;

{ TMazaImobiliariaTintadeMaquina }

function TLibTintaMazaImobiliaria.GetCampoComponenteDesComp(): String;
begin
  Result := '""';
end;

function TLibTintaMazaImobiliaria.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaMazaImobiliaria.Create(strTabPre);
end;

function TLibTintaMazaImobiliaria.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperMazaImobiliaria.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaMazaImobiliaria.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemMazaImobiliaria.Create();
{$ENDIF}
end;

function TLibTintaMazaImobiliaria.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORMZI';
end;

function TLibTintaMazaImobiliaria.GetNomeTinta: String;
begin
  Result := 'Maza Imobiliária';
end;

function TLibTintaMazaImobiliaria.GetPrefixoTabela: String;
begin
  Result := 'MZI';
end;

function TLibTintaMazaImobiliaria.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
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

function TLibTintaMazaImobiliaria.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   MZI_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaMazaImobiliaria.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
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
        '   MZI_CADMZI               ' +
        ' WHERE MZI_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('MZI_CODMZI').AsString +
                              qryGen.FieldByName('MZI_CODEMP').AsString +
                              qryGen.FieldByName('MZI_CODUNI').AsString +
                              qryGen.FieldByName('MZI_PRODUT').AsString +
                              qryGen.FieldByName('MZI_COLNUM').AsString +
                              qryGen.FieldByName('MZI_CODBAS').AsString ;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

function TLibTintaMazaImobiliaria.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';//dtsTinta.FieldByName('MZI_REFERE').AsString;
end;

function TLibTintaMazaImobiliaria.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('MZI');

  strSiglaTrava := conf.fGet('TRAMZI');
  fltFatTrava   := conf.fGetDouble('FATMZI');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
