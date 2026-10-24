{***************************************************************}
{* Classe contendo as informações especificas da tinta Colorbraz *}
{************************************************************PH*}
unit untLibTintaColorbraz;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaColorbraz = class(TAbstractLibTintaImobiliaria)
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
  untAuttinMenuItemColorbraz,
{$ENDIF}
  untFormulaImobiliariaColorbraz, untTintadeMaquinaWrapperColorbraz,
  untAutcomTintaFactory, untVariantUtils,
  untMultiSelectLocalizadorFactory;

{ TColorbrazTintadeMaquina }

function TLibTintaColorbraz.GetCampoComponenteDesComp(): String;
begin
  Result := 'COL_DESCRI';
end;

function TLibTintaColorbraz.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaColorbraz.Create(strTabPre);
end;

function TLibTintaColorbraz.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperColorbraz.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaColorbraz.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemColorbraz.Create();
{$ENDIF}
end;

function TLibTintaColorbraz.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORCLB';
end;

function TLibTintaColorbraz.GetNomeTinta: String;
begin
  Result := 'Colorbraz';
end;

function TLibTintaColorbraz.GetPrefixoTabela: String;
begin
  Result := 'CLB';
end;

function TLibTintaColorbraz.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
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

function TLibTintaColorbraz.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_DESCRI                              ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   CLB_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaColorbraz.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      If TMultiSelectLocalizadorFactory.GetLocalizador('CLB').Localizar(qryGen, ['ITETIN'], [strIteTin]) Then
      Begin
        dicRetorno['codtin'] := qryGen.FieldByName('CLB_CODIGO').AsString +
                                qryGen.FieldByName('CLB_CODBAS').AsString +
                                qryGen.FieldByName('CLB_NOMCOR').AsString +
                                qryGen.FieldByName('CLB_PRODUT').AsString +
                                qryGen.FieldByName('CLB_UNIDAD').AsString;

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

function TLibTintaColorbraz.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaColorbraz.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('CLB');

  strSiglaTrava := conf.fGet('TRABRI');
  fltFatTrava   := conf.fGetDouble('FATBRI');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
