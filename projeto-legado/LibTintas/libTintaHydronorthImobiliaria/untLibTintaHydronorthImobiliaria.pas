{************************************************************************}
{* Classe contendo as informações especificas da tinta HydronorthImobiliaria *}
{*********************************************************************AC*}
unit untLibTintaHydronorthImobiliaria;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaHydronorthImobiliaria = class(TAbstractLibTintaImobiliaria)
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
  untAuttinMenuItemHydronorthImobiliaria,
{$ENDIF}
  untFormulaImobiliariaHydronorthImobiliaria, untTintadeMaquinaWrapperHydronorthImobiliaria, untAutcomTintaFactory, untVariantUtils;

{ THydronorthImobiliariaTintadeMaquina }

function TLibTintaHydronorthImobiliaria.GetCampoComponenteDesComp(): String;
begin
  Result := '""';
end;

function TLibTintaHydronorthImobiliaria.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaHydronorthImobiliaria.Create(strTabPre);
end;

function TLibTintaHydronorthImobiliaria.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperHydronorthImobiliaria.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaHydronorthImobiliaria.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemHydronorthImobiliaria.Create();
{$ENDIF}
end;

function TLibTintaHydronorthImobiliaria.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORHYD';
end;

function TLibTintaHydronorthImobiliaria.GetNomeTinta: String;
begin
  Result := 'Hydronorth Imobiliária';
end;

function TLibTintaHydronorthImobiliaria.GetPrefixoTabela: String;
begin
  Result := 'HYD';
end;

function TLibTintaHydronorthImobiliaria.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String) : String;

var
  fltCalculo,
  fltInteiroOnca,
  fltFracaoOnca: Double;
begin
  Result := '';

  fltCalculo     := (fltPulsos / 48) / 0.61611520;
  fltInteiroOnca := Trunc(fltCalculo);
  fltFracaoOnca  := TAutcomTintaFactory.Get.fStrToFloat(FormatFloat('0.000', (fltCalculo - fltInteiroOnca) * 48));

  Result := Format('%dY%.1f', [Trunc(fltInteiroOnca), fltFracaoOnca]);

end;

function TLibTintaHydronorthImobiliaria.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   HYD_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaHydronorthImobiliaria.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
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
        '   HYD_CADHYD            ' +
        ' WHERE HYD_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;


      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('HYD_COLECA').AsString +
                              qryGen.FieldByName('HYD_PRODUT').AsString +
                              qryGen.FieldByName('HYD_C_O_R_').AsString +
                              qryGen.FieldByName('HYD_CORLON').AsString +
                              qryGen.FieldByName('HYD_BASE__').AsString +
                              qryGen.FieldByName('HYD_CODEMB').AsString;


    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

function TLibTintaHydronorthImobiliaria.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';//dtsTinta.FieldByName('HYD_REFERE').AsString;
end;

function TLibTintaHydronorthImobiliaria.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('HYD');

  strSiglaTrava := conf.fGet('TRAHYD');
  fltFatTrava   := conf.fGetDouble('FATHYD');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
