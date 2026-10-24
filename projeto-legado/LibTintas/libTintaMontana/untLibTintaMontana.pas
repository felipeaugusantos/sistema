{************************************************************************}
{* Classe contendo as informações especificas da tinta Montana *}
{*********************************************************************AC*}
unit untLibTintaMontana;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaMontana = class(TAbstractLibTintaImobiliaria)
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
  untAuttinMenuItemMontana,
{$ENDIF}
  untFormulaImobiliariaMontana, untTintadeMaquinaWrapperMontana, untAutcomTintaFactory, untVariantUtils;

{ TMontanaTintadeMaquina }

function TLibTintaMontana.GetCampoComponenteDesComp(): String;
begin
  Result := '""';
end;

function TLibTintaMontana.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaMontana.Create(strTabPre);
end;

function TLibTintaMontana.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperMontana.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaMontana.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemMontana.Create();
{$ENDIF}
end;

function TLibTintaMontana.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORMON';
end;

function TLibTintaMontana.GetNomeTinta: String;
begin
  Result := 'Montana';
end;

function TLibTintaMontana.GetPrefixoTabela: String;
begin
  Result := 'MON';
end;

function TLibTintaMontana.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
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

function TLibTintaMontana.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   MON_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaMontana.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL :=
        ' SELECT          ' +
        '      MON_CODSEQ ' +
        '    , MON_CODBAS ' +
        '    , MON_ACABAM ' +
        '    , MON_DESCRI ' +
        '    , MON_DESCOR ' +
        '    , MON_PRODUT ' +
        '    , MON_UNIDAD ' +
        ' FROM ' +
        '   MON_CADMON  ' +
        ' WHERE MON_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('MON_CODSEQ').AsString +
                              qryGen.FieldByName('MON_CODBAS').AsString +
                              qryGen.FieldByName('MON_ACABAM').AsString +
                              qryGen.FieldByName('MON_DESCRI').AsString +
                              qryGen.FieldByName('MON_DESCOR').AsString +
                              qryGen.FieldByName('MON_PRODUT').AsString +
                              qryGen.FieldByName('MON_UNIDAD').AsString ;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

function TLibTintaMontana.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaMontana.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('MON');

  strSiglaTrava := conf.fGet('TRAMON');
  fltFatTrava   := conf.fGetDouble('FATMON');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
