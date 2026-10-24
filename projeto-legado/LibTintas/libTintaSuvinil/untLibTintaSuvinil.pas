{***************************************************************}
{* Classe contendo as informações especificas da tinta suvinil *}
{************************************************************PH*}
unit untLibTintaSuvinil;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaSuvinil = class(TAbstractLibTintaImobiliaria)
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
  untAuttinMenuItemSuvinil,
{$ENDIF}
  untFormulaImobiliariaSuvinil, untTintadeMaquinaWrapperSuvinil, untAutcomTintaFactory, untVariantUtils;

{ TSuvinilTintadeMaquina }

function TLibTintaSuvinil.GetCampoComponenteDesComp(): String;
begin
  Result := '""';
end;

function TLibTintaSuvinil.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaSuvinil.Create(strTabPre);
end;

function TLibTintaSuvinil.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperSuvinil.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaSuvinil.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemSuvinil.Create();
{$ENDIF}
end;

function TLibTintaSuvinil.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORSUV';
end;

function TLibTintaSuvinil.GetNomeTinta: String;
begin
  Result := 'Suvinil';
end;

function TLibTintaSuvinil.GetPrefixoTabela: String;
begin
  Result := 'SUV';
end;

function TLibTintaSuvinil.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String) : String;
begin
  Result := '';
  intParteInteira := Trunc((fltPulsos / 48) / 4);
  fltParteFracao  :=  (((fltPulsos / 48) / 4) - intParteInteira) * 48;
  Result := Format('%dY%.2f', [intParteInteira, fltParteFracao]);
end;

function TLibTintaSuvinil.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   SUV_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaSuvinil.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL :=
        ' SELECT                     ' +
        '   SUV_DESCRI               ' +
        ' FROM                       ' +
        '   SUV_CADSUV               ' +
        ' WHERE SUV_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      If qryGen.IsEmpty Then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('SUV_DESCRI').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TLibTintaSuvinil.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := dtsTinta.FieldByName('SUV_REFERE').AsString;
end;

function TLibTintaSuvinil.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('SUV');

  strSiglaTrava := conf.fGet('TRASUV');
  fltFatTrava   := conf.fGetDouble('FATSUV');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.

