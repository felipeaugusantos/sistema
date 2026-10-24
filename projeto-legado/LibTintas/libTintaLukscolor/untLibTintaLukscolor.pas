{************************************************************************}
{* Classe contendo as informações especificas da tinta Lukscolor *}
{*********************************************************************AC*}
unit untLibTintaLukscolor;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaLukscolor = class(TAbstractLibTintaImobiliaria)
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
  untAuttinMenuItemLukscolor,
{$ENDIF}
  untFormulaImobiliariaLukscolor, untTintadeMaquinaWrapperLukscolor, untAutcomTintaFactory, untVariantUtils;

{ TLukscolorTintadeMaquina }

function TLibTintaLukscolor.GetCampoComponenteDesComp(): String;
begin
  Result := 'COL_DESCRI';
end;

function TLibTintaLukscolor.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaLukscolor.Create(strTabPre);
end;

function TLibTintaLukscolor.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperLukscolor.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaLukscolor.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemLukscolor.Create();
{$ENDIF}
end;

function TLibTintaLukscolor.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORLKS';
end;

function TLibTintaLukscolor.GetNomeTinta: String;
begin
  Result := 'Lukscolor';
end;

function TLibTintaLukscolor.GetPrefixoTabela: String;
begin
  Result := 'LKD';
end;

function TLibTintaLukscolor.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String) : String;
begin
  Result := '';
  intParteInteira := Trunc((fltPulsos / 48) / 4);
  fltParteFracao  :=  (((fltPulsos / 48) / 4) - intParteInteira) * 48;
  Result := Format('%dY%.2f', [intParteInteira, fltParteFracao]);
end;

function TLibTintaLukscolor.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   LKD_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaLukscolor.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
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
        '   LKD_CADLKD            ' +
        ' WHERE LKD_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;


      if qryGen.IsEmpty then
      begin
        qryGen.Close;
        qryGen.SQL :=
          ' SELECT '+
          '   * '+
          ' FROM '+
          '   LKD_CADLKD '+
          ' WHERE '+
          '  CONCAT(LKD_DESCRI, " ", LKD_CODIGO, " ", LKD_CODIG2) = :ITETIN ';
        qryGen.ParamByName('ITETIN').AsString := strIteTin;
        qryGen.Open;
      end;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('LKD_DESCRI').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

function TLibTintaLukscolor.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';//dtsTinta.FieldByName('LKD_REFERE').AsString;
end;

function TLibTintaLukscolor.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('LKS');

  strSiglaTrava := conf.fGet('TRALKS');
  fltFatTrava   := conf.fGetDouble('FATLKS');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
