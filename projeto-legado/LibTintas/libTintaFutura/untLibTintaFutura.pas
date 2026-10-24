{************************************************************************}
{* Classe contendo as informações especificas da tinta Futura           *}
{*********************************************************************AC*}
unit untLibTintaFutura;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem, strUtils;

type
  TLibTintaFutura = class(TAbstractLibTintaImobiliaria)
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

    function RetornaDescricaoTinta(const strDesCri: String; const dtsTinta: IDataSet; const strTipPre: String): String; override;
    function GetPrefixoTabela(): String; Override;
  end;

implementation

uses
{$IFNDEF LINUX}
  untAuttinMenuItemFutura,
{$ENDIF}
  untFormulaImobiliariaFutura, untTintadeMaquinaWrapperFutura, untAutcomTintaFactory, untVariantUtils;

{ TFuturaTintadeMaquina }

function TLibTintaFutura.GetCampoComponenteDesComp(): String;
begin
  Result := '""';
end;

function TLibTintaFutura.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaFutura.Create(strTabPre);
end;

function TLibTintaFutura.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperFutura.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaFutura.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemFutura.Create();
{$ENDIF}
end;

function TLibTintaFutura.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORFUT';
end;

function TLibTintaFutura.GetNomeTinta: String;
begin
  Result := 'Futura';
end;

function TLibTintaFutura.GetPrefixoTabela: String;
begin
  Result := 'FUT';
end;

function TLibTintaFutura.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
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

function TLibTintaFutura.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   FUT_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaFutura.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
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
        '   FUT_CADFUT               ' +
        ' WHERE FUT_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
      begin
        qryGen.Close;
        qryGen.SQL :=
          ' SELECT                           ' +
          '   *                              ' +
          ' FROM                             ' +
          '   FUT_CADFUT                     ' +
          ' WHERE                            ' +
          ' 	CONCAT(IFNULL(FUT_REFERE, ""), ' +
          ' 	       IFNULL(FUT_UNIDAD, ""), ' +
          ' 	       IFNULL(FUT_PRODUT, ""), ' +
          '          IFNULL(FUT_SPRODU, ""), ' +
          ' 	       IFNULL(FUT_CODBAS, "")) = :ITETIN ';
        qryGen.ParamByName('ITETIN').AsString := strIteTin;
        qryGen.Open;
      end;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('FUT_REFERE').AsString +
                              qryGen.FieldByName('FUT_UNIDAD').AsString +
                              qryGen.FieldByName('FUT_PRODUT').AsString +
                              qryGen.FieldByName('FUT_SPRODU').AsString +
                              qryGen.FieldByName('FUT_CODBAS').AsString;


    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

function TLibTintaFutura.RetornaDescricaoTinta(const strDesCri: String;
  const dtsTinta: IDataSet; const strTipPre: String): String;
  Var
    strDesFut: String;
begin
  strDesFut := dtsTinta.FieldByName('FUT_REFERE').AsString + ' ' +
               dtsTinta.FieldByName('FUT_PRODUT').AsString + ' ' +
               dtsTinta.FieldByName('FUT_SPRODU').AsString + ' ' +
               dtsTinta.FieldByName('FUT_UNIDAD').AsString;

  Result := Trim(AnsiReplaceStr(strDesCri, '%s', strDesFut));
end;

function TLibTintaFutura.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := dtsTinta.FieldByName('FUT_REFERE').AsString;
end;

function TLibTintaFutura.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('FUT');

  strSiglaTrava := conf.fGet('TRAFUT');
  fltFatTrava   := conf.fGetDouble('FATFUT');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
