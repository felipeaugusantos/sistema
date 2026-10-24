{***************************************************************}
{* Classe contendo as informações especificas da tinta MegaTintas *}
{************************************************************PH*}
unit untLibTintaMegaTintas;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaMegaTintas = class(TAbstractLibTintaImobiliaria)
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
  untAuttinMenuItemMegaTintas,
{$ENDIF}
  untFormulaImobiliariaMegaTintas, untTintadeMaquinaWrapperMegaTintas, untAutcomTintaFactory, untVariantUtils;

{ TMegaTintasTintadeMaquina }

function TLibTintaMegaTintas.GetCampoComponenteDesComp(): String;
begin
  Result := 'COL_DESCRI';
end;

function TLibTintaMegaTintas.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaMegaTintas.Create(strTabPre);
end;

function TLibTintaMegaTintas.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperMegaTintas.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaMegaTintas.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemMegaTintas.Create();
{$ENDIF}
end;

function TLibTintaMegaTintas.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORMEG';
end;

function TLibTintaMegaTintas.GetNomeTinta: String;
begin
  Result := 'Mega Tintas';
end;

function TLibTintaMegaTintas.GetPrefixoTabela: String;
begin
  Result := 'MEG';
end;

function TLibTintaMegaTintas.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String) : String;
begin
  Result := '';
  intParteInteira := Trunc((fltPulsos / 48) / 4);
  fltParteFracao  :=  (((fltPulsos / 48) / 4) - intParteInteira) * 48;
  Result := Format('%dY%.2f', [intParteInteira, fltParteFracao]);
end;

function TLibTintaMegaTintas.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   MEG_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaMegaTintas.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL :=
        ' SELECT                     ' +
        '   MEG_DESCRI               ' +
        ' FROM                       ' +
        '   MEG_CADMEG               ' +
        ' WHERE MEG_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('MEG_DESCRI').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

function TLibTintaMegaTintas.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := dtsTinta.FieldByName('MEG_REFERE').AsString;
end;

function TLibTintaMegaTintas.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('MEG');

  strSiglaTrava := conf.fGet('TRAMEG');
  fltFatTrava   := conf.fGetDouble('FATMEG');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
