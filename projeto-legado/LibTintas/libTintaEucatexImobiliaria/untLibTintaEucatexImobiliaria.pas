{***************************************************************************}
{* Classe contendo as informações especificas da tinta Eucatex Imobiliaria *}
{************************************************************************PH*}
unit untLibTintaEucatexImobiliaria;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaEucatexImobiliaria = class(TAbstractLibTintaImobiliaria)
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
  untAuttinMenuItemEucatexImobiliaria,
{$ENDIF}
  untFormulaImobiliariaEucatexImobiliaria, untTintadeMaquinaWrapperEucatexImobiliaria,
  untAutcomTintaFactory, untVariantUtils,
  untMultiSelectLocalizadorFactory;

{ TEucatexImobiliariaTintadeMaquina }

function TLibTintaEucatexImobiliaria.GetCampoComponenteDesComp(): String;
begin
  Result := '""';
end;

function TLibTintaEucatexImobiliaria.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaEucatexImobiliaria.Create(strTabPre);
end;

function TLibTintaEucatexImobiliaria.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperEucatexImobiliaria.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaEucatexImobiliaria.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemEucatexImobiliaria.Create();
{$ENDIF}
end;

function TLibTintaEucatexImobiliaria.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FOREUC';
end;

function TLibTintaEucatexImobiliaria.GetNomeTinta: String;
begin
  Result := 'Eucatex Imobiliária';
end;

function TLibTintaEucatexImobiliaria.GetPrefixoTabela: String;
begin
  Result := 'EUC';
end;

function TLibTintaEucatexImobiliaria.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String) : String;
var
  fltCalculo,
  fltInteiroOnca,
  fltFracaoOnca,
  fltQuantidade: Double;
begin
  fltQuantidade  := (fltPulsos * (29.5735295625 / 48));
  fltCalculo     := (fltQuantidade / 48) / 0.61611520;
  fltInteiroOnca := Trunc(fltCalculo);
  fltFracaoOnca  := TAutcomTintaFactory.Get.fStrToFloat(FormatFloat('0.000', (fltCalculo - fltInteiroOnca) * 48));

  Result := Format('%dY%.1f', [Trunc(fltInteiroOnca), fltFracaoOnca]);
end;

function TLibTintaEucatexImobiliaria.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   EUC_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaEucatexImobiliaria.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      If TMultiSelectLocalizadorFactory.GetLocalizador('EUC').Localizar(qryGen, ['ITETIN'], [strIteTin]) Then
      Begin
        dicRetorno['codtin'] := qryGen.FieldByName('EUC_CODCOR').AsString +
                                qryGen.FieldByName('EUC_DESCOR').AsString +
                                qryGen.FieldByName('EUC_PRODUT').AsString +
                                qryGen.FieldByName('EUC_DESBAS').AsString +
                                qryGen.FieldByName('EUC_UNIDAD').AsString +
                                qryGen.FieldByName('EUC_CODNFM').AsString;

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

function TLibTintaEucatexImobiliaria.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaEucatexImobiliaria.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('EUC');

  strSiglaTrava := conf.fGet('TRAEUC');
  fltFatTrava   := conf.fGetDouble('EUCFAT');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
