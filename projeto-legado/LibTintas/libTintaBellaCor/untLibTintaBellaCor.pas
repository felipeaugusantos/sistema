{***************************************************************}
{* Classe contendo as informações especificas da tinta BellaCor *}
{************************************************************PH*}
unit untLibTintaBellaCor;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaBellaCor = class(TAbstractLibTintaImobiliaria)
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
  untAuttinMenuItemBellaCor,
{$ENDIF}
  untFormulaImobiliariaBellaCor, untTintadeMaquinaWrapperBellaCor, untAutcomTintaFactory, untVariantUtils;

{ TBellaCorTintadeMaquina }

function TLibTintaBellaCor.GetCampoComponenteDesComp(): String;
begin
  Result := 'COL_DESCRI';
end;

function TLibTintaBellaCor.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaBellaCor.Create(strTabPre);
end;

function TLibTintaBellaCor.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperBellaCor.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaBellaCor.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemBellaCor.Create();
{$ENDIF}
end;

function TLibTintaBellaCor.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORBEL';
end;

function TLibTintaBellaCor.GetNomeTinta: String;
begin
  Result := 'Bellacor';
end;

function TLibTintaBellaCor.GetPrefixoTabela: String;
begin
  Result := 'BEL';
end;

function TLibTintaBellaCor.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String) : String;
Var
  conf         : IConfTinta;

  TipoDosadora : String; // 0:Manual/1:Automática
  strDosadora  : String;
  strValor     : String;
  strValorY    : String;
  strValorX    : String;

  fltValorY    : Double;
  fltValorX    : Double;
  fltFracao    : Double;
  fltFracaoY   : Double;
  fltResult    : Double;
  fltDosadora  : Double;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('BEL');

  strValorY   := '';
  strValorX   := '';
  strDosadora := '';

  TipoDosadora := conf.fGet('TIPDOS');

  // 1ª PARTE: DESCOBRIR O 'Y'
  fltValorY := Trunc((fltPulsos / 0.616) / 48);

  // 2ª PARTE: DESCOBRIR A FRAÇÃO '/48'
  fltFracao :=  (fltPulsos / 0.616);

  fltFracaoY := fltValorY * 48;

  fltValorX := (fltFracao - fltFracaoY);

  // 3ª PARTE: DESCOBRIR A FRAÇÃO '/96' (DOSADORA AUTOMÁTICA) OU '/384' (DOSADORA MANUAL)

  fltResult := fltPulsos - (fltValorY * 29.57) - (Trunc(fltValorX) * 0.616);

  // NESTE PONTO, O SISTEMA DEVE OLHAR A CONFIGURAÇÃO QUE DETERMINA SE A DOSADORA É MANUAL OU AUTOMÁTICA.

  fltDosadora := fltResult / TAutcomTintaFactory.Get.IIF(TipoDosadora = '0', 0.308, 0.077);

  If Trunc(fltValorX) > 0 Then
    strValorX := FloatToStr(Trunc(fltValorX)) + '/48';

  If Trunc(fltDosadora) > 0 Then
    strDosadora := IntToStr(Trunc(fltDosadora))  + '/' + TAutcomTintaFactory.Get.IIF(TipoDosadora = '0', '96', '384');

  If fltValorY > 0 Then
    strValorY := FloatToStr(fltValorY) + 'Y';

  strValor :=  strValorY +' '+ strValorX + ' '+  strDosadora;

  Result :=  strValor;
end;

function TLibTintaBellaCor.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   BEL_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaBellaCor.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
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
        '   BEL_CADBEL               ' +
        ' WHERE BEL_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('BEL_NOMCOR').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function TLibTintaBellaCor.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';//dtsTinta.FieldByName('BEL_REFERE').AsString;
end;

function TLibTintaBellaCor.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('BEL');

  strSiglaTrava := conf.fGet('TRABEL');
  fltFatTrava   := conf.fGetDouble('FATBEL');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
