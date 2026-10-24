{****************************************************************}
{* Classe contendo as informações especificas da tinta Dacar    *}
{*************************************************************AC*}
unit untLibTintaDacar;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaDacar = class(TAbstractLibTintaImobiliaria)
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
    function MlParaOnca(fltValor : Double ) : String; override;
    function GetPrefixoTabela(): String; Override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemDacar,
{$ENDIF}
  untFormulaImobiliariaDacar, untTintadeMaquinaWrapperDacar,
  untAutcomTintaFactory, untVariantUtils,
  untMultiSelectLocalizadorFactory;

{ TDacarTintadeMaquina }

function TLibTintaDacar.GetCampoComponenteDesComp(): String;
begin
  Result := '""';
end;

function TLibTintaDacar.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaDacar.Create(strTabPre);
end;

function TLibTintaDacar.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperDacar.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaDacar.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemDacar.Create();
{$ENDIF}
end;

function TLibTintaDacar.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORDAC';
end;

function TLibTintaDacar.GetNomeTinta: String;
begin
  Result := 'Dacar';
end;

function TLibTintaDacar.GetPrefixoTabela: String;
begin
  Result := 'DAC';
end;

function TLibTintaDacar.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String) : String;
begin
  Result := MlParaOnca(fltPulsos);
end;

function TLibTintaDacar.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   DAC_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

function TLibTintaDacar.MlParaOnca(fltValor: Double): String;
var
  fltCalculo: Double;
  intParteInteira: Integer;
  fltParteFracao: Double;
begin
  fltCalculo := ((fltValor / 48) / 0.616125);
  intParteInteira := Trunc(fltCalculo);
  fltParteFracao := TAutcomTintaFactory.Get.fStrToFloat(FormatFloat('0.00', (fltCalculo - intParteInteira) * 48));
  Result := Format('%dY%.2f', [intParteInteira, fltParteFracao]);
end;

procedure TLibTintaDacar.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      If TMultiSelectLocalizadorFactory.GetLocalizador('DAC').Localizar(qryGen, ['ITETIN'], [strIteTin]) Then
      Begin
        dicRetorno['codtin'] := qryGen.FieldByName('DAC_DESCRI').AsString;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

function TLibTintaDacar.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := dtsTinta.FieldByName('DAC_REFERE').AsString;
end;

function TLibTintaDacar.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('DAC');

  strSiglaTrava := conf.fGet('TRADAC');
  fltFatTrava   := conf.fGetDouble('FATDAC');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
