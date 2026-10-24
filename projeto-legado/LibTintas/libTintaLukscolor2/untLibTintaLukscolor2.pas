{***************************************************************}
{* Classe contendo as informações especificas da tinta Lukscolor2 *}
{************************************************************PH*}
unit untLibTintaLukscolor2;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaLukscolor2 = class(TAbstractLibTintaImobiliaria)
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
    function GetQuantidadeMlPulso(const fltValor: Double; intDecFor: Integer; strFormul: String): String; Override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemLukscolor2,
{$ENDIF}
  untFormulaImobiliariaLukscolor2, untTintadeMaquinaWrapperLukscolor2, untAutcomTintaFactory, untVariantUtils, untMultiSelectLocalizadorFactory;

{ TLukscolor2TintadeMaquina }

function TLibTintaLukscolor2.GetCampoComponenteDesComp(): String;
begin
  Result := 'COL_DESCRI';
end;

function TLibTintaLukscolor2.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaLukscolor2.Create(strTabPre);
end;

function TLibTintaLukscolor2.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperLukscolor2.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaLukscolor2.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemLukscolor2.Create();
{$ENDIF}
end;

function TLibTintaLukscolor2.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORLKC';
end;

function TLibTintaLukscolor2.GetNomeTinta: String;
begin
  Result := 'Lukscolor 2';
end;

function TLibTintaLukscolor2.GetPrefixoTabela: String;
begin
  Result := 'LKC';
end;

function TLibTintaLukscolor2.GetQuantidadeMlPulso(const fltValor: Double;
  intDecFor: Integer; strFormul: String): String;
Var
  fltMl: Double;
begin
  fltMl := TAutcomTintaFactory.Get.fFormataFloat(fltValor, 2);

  Result := FloatToStrF(fltMl / 0.154, ffNumber, 12, intDecFor);
end;

function TLibTintaLukscolor2.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
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

function TLibTintaLukscolor2.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_DESCRI                              ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   LKC_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaLukscolor2.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      If TMultiSelectLocalizadorFactory.GetLocalizador('LKC').Localizar(qryGen, ['ITETIN'], [strIteTin]) Then
      Begin
        dicRetorno['codtin'] := qryGen.FieldByName('LKC_CODIGO').AsString +
                                qryGen.FieldByName('LKC_CODBAS').AsString +
                                qryGen.FieldByName('LKC_NOMCOR').AsString +
                                qryGen.FieldByName('LKC_PRODUT').AsString +
                                qryGen.FieldByName('LKC_UNIDAD').AsString;

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

function TLibTintaLukscolor2.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaLukscolor2.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('LKC');

  strSiglaTrava := conf.fGet('TRABRI');
  fltFatTrava   := conf.fGetDouble('FATBRI');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
