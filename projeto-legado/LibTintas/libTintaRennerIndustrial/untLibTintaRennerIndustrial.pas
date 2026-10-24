{************************************************************************}
{* Classe contendo as informações especificas da tinta RennerIndustrial *}
{*********************************************************************AC*}
unit untLibTintaRennerIndustrial;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem, untStrUtils;

type
  TLibTintaRennerIndustrial = class(TAbstractLibTintaImobiliaria)
  Private
    function fCalculaOnca(Quantidade: Double): String;
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
  untAuttinMenuItemRennerIndustrial,
{$ENDIF}
  untFormulaImobiliariaRennerIndustrial, untTintadeMaquinaWrapperRennerIndustrial, untAutcomTintaFactory, untVariantUtils;

{ TRennerIndustrialTintadeMaquina }

function TLibTintaRennerIndustrial.fCalculaOnca(Quantidade: Double): String;
Var
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
  strValorY := '';
  strValorX := '';
  strDosadora := '';

  // 1ª PARTE: DESCOBRIR O 'Y'

  fltValorY := Trunc((Quantidade / 0.616) / 48);

  // 2ª PARTE: DESCOBRIR A FRAÇÃO '/48'

  fltFracao  := (Quantidade / 0.616);
  fltFracaoY :=  fltValorY * 48;
  fltValorX  := (fltFracao - fltFracaoY);

  // 3ª PARTE: DESCOBRIR A FRAÇÃO '/96'

  fltResult := Quantidade - (fltValorY * 29.57) - (Trunc(fltValorX) * 0.616);
  fltDosadora :=  fltResult / 0.308;

  If Trunc(fltValorX) > 0 Then
    strValorX := FloatToStr(Trunc(fltValorX));

  If Trunc(fltDosadora) > 0 Then
    strDosadora := IntToStr(Trunc(fltDosadora)) + '/96';

  If fltValorY > 0 Then
    strValorY := FloatToStr(fltValorY) + 'Y';

  If Not TStrUtils.fEmptyStr(strValorY) Then
    strValor := strValorY;

  If Not TStrUtils.fEmptyStr(strValorX) Then
    strValor := strValor + ' ' + strValorX;

  If Not TStrUtils.fEmptyStr(strDosadora) Then
    strValor := strValor + ' ' + strDosadora;

  Result := strValor;
end;

function TLibTintaRennerIndustrial.GetCampoComponenteDesComp(): String;
begin
  Result := 'COL_DESCRI';
end;

function TLibTintaRennerIndustrial.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaRennerIndustrial.Create(strTabPre);
end;

function TLibTintaRennerIndustrial.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperRennerIndustrial.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaRennerIndustrial.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemRennerIndustrial.Create();
{$ENDIF}
end;

function TLibTintaRennerIndustrial.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORREN';
end;

function TLibTintaRennerIndustrial.GetNomeTinta: String;
begin
  Result := 'Renner Industrial';
end;

function TLibTintaRennerIndustrial.GetPrefixoTabela: String;
begin
  Result := 'REN';
end;

function TLibTintaRennerIndustrial.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String) : String;
begin
  Result := fCalculaOnca(fltPulsos);
end;

function TLibTintaRennerIndustrial.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   REN_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaRennerIndustrial.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL :=
        ' SELECT                     ' +
        '    *                       ' +
        ' FROM                       ' +
        '   REN_CADREN            ' +
        ' WHERE REN_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('REN_DESCRI').AsString +
                              qryGen.FieldByName('REN_CODIGO').AsString +
                              qryGen.FieldByName('REN_UNIDAD').AsString +
                              qryGen.FieldByName('REN_CODBAS').AsString +
                              qryGen.FieldByName('REN_CODEMB').AsString +
                              qryGen.FieldByName('REN_CODUNI').AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

function TLibTintaRennerIndustrial.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';//dtsTinta.FieldByName('REN_REFERE').AsString;
end;

function TLibTintaRennerIndustrial.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('REN');

  strSiglaTrava := conf.fGet('TRAREN');
  fltFatTrava   := conf.fGetDouble('FATREN');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
