{************************************************************************}
{* Classe contendo as informações especificas da tinta RennerImobiliaria *}
{*********************************************************************AC*}
unit untLibTintaRennerImobiliaria;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaRennerImobiliaria = class(TAbstractLibTintaImobiliaria)
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
  untAuttinMenuItemRennerImobiliaria,
{$ENDIF}
  untFormulaImobiliariaRennerImobiliaria, untTintadeMaquinaWrapperRennerImobiliaria, untAutcomTintaFactory, untVariantUtils;

{ TRennerImobiliariaTintadeMaquina }

function TLibTintaRennerImobiliaria.GetCampoComponenteDesComp(): String;
begin
  Result := 'COL_DESCRI';
end;

function TLibTintaRennerImobiliaria.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaRennerImobiliaria.Create(strTabPre);
end;

function TLibTintaRennerImobiliaria.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperRennerImobiliaria.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaRennerImobiliaria.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemRennerImobiliaria.Create();
{$ENDIF}
end;

function TLibTintaRennerImobiliaria.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORREI';
end;

function TLibTintaRennerImobiliaria.GetNomeTinta: String;
begin
  Result := 'Renner Imobiliária';
end;

function TLibTintaRennerImobiliaria.GetPrefixoTabela: String;
begin
  Result := 'REI';
end;

function TLibTintaRennerImobiliaria.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
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

function TLibTintaRennerImobiliaria.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   REI_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaRennerImobiliaria.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL :=
        ' SELECT        ' +
        '   REI_DESCRI, ' +
        '   REI_REFERE, ' +
        '   REI_UNIDAD, ' +
        '   REI_DESCOR, ' +
        '   REI_CODPRO, ' +
        '   REI_CODBAS, ' +
        '   REI_DTACAD  ' +
        ' FROM          ' +
        '   REI_CADREI  ' +
        ' WHERE REI_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('REI_DESCRI').AsString +
                              qryGen.FieldByName('REI_REFERE').AsString +
                              qryGen.FieldByName('REI_UNIDAD').AsString +
                              qryGen.FieldByName('REI_DESCOR').AsString +
                              qryGen.FieldByName('REI_CODPRO').AsString +
                              qryGen.FieldByName('REI_CODBAS').AsString +
                              qryGen.FieldByName('REI_DTACAD').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

function TLibTintaRennerImobiliaria.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := dtsTinta.FieldByName('REI_REFERE').AsString;
end;

function TLibTintaRennerImobiliaria.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('REI');

  strSiglaTrava := conf.fGet('TRAREI');
  fltFatTrava   := conf.fGetDouble('FATREI');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
