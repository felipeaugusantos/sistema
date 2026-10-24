{************************************************************************}
{* Classe contendo as informações especificas da tinta Calamar *}
{*********************************************************************AC*}
unit untLibTintaCalamar;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaCalamar = class(TAbstractLibTintaImobiliaria)
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
  untAuttinMenuItemCalamar,
{$ENDIF}
  untFormulaImobiliariaCalamar, untTintadeMaquinaWrapperCalamar, untAutcomTintaFactory, untVariantUtils;

{ TCalamarTintadeMaquina }

function TLibTintaCalamar.GetCampoComponenteDesComp(): String;
begin
  Result := 'COL_DESCRI';
end;

function TLibTintaCalamar.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaCalamar.Create(strTabPre);
end;

function TLibTintaCalamar.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperCalamar.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaCalamar.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemCalamar.Create();
{$ENDIF}
end;

function TLibTintaCalamar.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORCAL';
end;

function TLibTintaCalamar.GetNomeTinta: String;
begin
  Result := 'Calamar';
end;

function TLibTintaCalamar.GetPrefixoTabela: String;
begin
  Result := 'CAL';
end;

function TLibTintaCalamar.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
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

function TLibTintaCalamar.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   CAL_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaCalamar.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
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
        '   CAL_CADCAL            ' +
        ' WHERE CAL_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;


      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('CAL_CODBAS').AsString +
                              qryGen.FieldByName('CAL_CODEMB').AsString +
                              qryGen.FieldByName('CAL_KEY1__').AsString +
                              qryGen.FieldByName('CAL_KEY2__').AsString +
                              qryGen.FieldByName('CAL_KEY3__').AsString +
                              qryGen.FieldByName('CAL_PRODUT').AsString +
                              qryGen.FieldByName('CAL_COLECA').AsString;


    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

function TLibTintaCalamar.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';//dtsTinta.FieldByName('CAL_REFERE').AsString;
end;

function TLibTintaCalamar.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('CAL');

  strSiglaTrava := conf.fGet('TRACAL');
  fltFatTrava   := conf.fGetDouble('FATCAL');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
