{**************************************************************************}
{* Classe contendo as informações especificas da tinta Alessi Imobiliaria *}
{***********************************************************************AC*}
unit untLibTintaAlessiImobiliaria;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaAlessiImobiliaria = class(TAbstractLibTintaImobiliaria)
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
  untAuttinMenuItemAlessiImobiliaria,
{$ENDIF}
  untFormulaImobiliariaAlessiImobiliaria, untTintadeMaquinaWrapperAlessiImobiliaria,
  untAutcomTintaFactory, untVariantUtils, untMultiSelectLocalizadorFactory;

{ TAlessiImobiliariaTintadeMaquina }

function TLibTintaAlessiImobiliaria.GetCampoComponenteDesComp(): String;
begin
  Result := '""';
end;

function TLibTintaAlessiImobiliaria.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaAlessiImobiliaria.Create(strTabPre);
end;

function TLibTintaAlessiImobiliaria.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperAlessiImobiliaria.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaAlessiImobiliaria.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemAlessiImobiliaria.Create();
{$ENDIF}
end;

function TLibTintaAlessiImobiliaria.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORALE';
end;

function TLibTintaAlessiImobiliaria.GetNomeTinta: String;
begin
  Result := 'Alessi Imobiliária';
end;

function TLibTintaAlessiImobiliaria.GetPrefixoTabela: String;
begin
  Result := 'ALE';
end;

function TLibTintaAlessiImobiliaria.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String) : String;
begin
  Result := MlParaOnca(fltPulsos);
end;

function TLibTintaAlessiImobiliaria.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   ALE_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

function TLibTintaAlessiImobiliaria.MlParaOnca(fltValor: Double): String;
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

procedure TLibTintaAlessiImobiliaria.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      If TMultiSelectLocalizadorFactory.GetLocalizador('ALE').Localizar(qryGen, ['ITETIN'], [strIteTin]) Then
      Begin
        dicRetorno['codtin'] := qryGen.FieldByName('ALE_PRODUT').AsString +
                                qryGen.FieldByName('ALE_BASE__').AsString +
                                qryGen.FieldByName('EMB_CODUNI').AsString +
                                qryGen.FieldByName('ALE_NOMCOR').AsString +
                                qryGen.FieldByName('ALE_NOMLON').AsString +
                                qryGen.FieldByName('ALE_CODNFM').AsString;
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

function TLibTintaAlessiImobiliaria.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaAlessiImobiliaria.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('ALE');

  strSiglaTrava := conf.fGet('ALEPRE');
  fltFatTrava   := conf.fGetDouble('ALEFAT');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
