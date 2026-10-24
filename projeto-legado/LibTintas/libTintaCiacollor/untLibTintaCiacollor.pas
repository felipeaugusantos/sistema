{***************************************************************}
{* Classe contendo as informações especificas da tinta Ciacollor *}
{************************************************************PH*}
unit untLibTintaCiacollor;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaCiacollor = class(TAbstractLibTintaImobiliaria)
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
  untAuttinMenuItemCiacollor,
{$ENDIF}
  untFormulaImobiliariaCiacollor, untTintadeMaquinaWrapperCiacollor, untAutcomTintaFactory, untVariantUtils;

{ TCiacollorTintadeMaquina }

function TLibTintaCiacollor.GetCampoComponenteDesComp(): String;
begin
  Result := 'COL_DESCRI';
end;

function TLibTintaCiacollor.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaCiacollor.Create(strTabPre);
end;

function TLibTintaCiacollor.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperCiacollor.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaCiacollor.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemCiacollor.Create();
{$ENDIF}
end;

function TLibTintaCiacollor.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORCIA';
end;

function TLibTintaCiacollor.GetNomeTinta: String;
begin
  Result := 'Ciacollor';
end;

function TLibTintaCiacollor.GetPrefixoTabela: String;
begin
  Result := 'CIA';
end;

function TLibTintaCiacollor.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
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

function TLibTintaCiacollor.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   CIA_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaCiacollor.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL :=
        ' SELECT                     ' +
        '   CIA_DESCRI               ' +
        ' FROM                       ' +
        '   CIA_CADCIA               ' +
        ' WHERE CIA_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
      begin
        qryGen.Close;
        qryGen.SQL :=
          ' SELECT           ' +
          '   *              ' +
          ' FROM             ' +
          '   CIA_CADCIA     ' +
          ' WHERE CONCAT(    ' +
          '     CIA_CODBAS   ' +
          '     , " "        ' +
          '     , CIA_UNIDAD ' +
          '     , CIA_DESCRI ' +
          '   ) = :ITETIN    ';
        qryGen.ParamByName('ITETIN').AsString := strIteTin;
        qryGen.Open;

        if qryGen.IsEmpty then
        begin
          qryGen.Close;
          qryGen.SQL :=
            ' SELECT           ' +
            '   *              ' +
            ' FROM             ' +
            '   CIA_CADCIA     ' +
            ' WHERE CONCAT(    ' +
            '       CIA_UNIDAD ' +
            '     , CIA_DESCRI ' +
            '   ) = :ITETIN    ';
          qryGen.ParamByName('ITETIN').AsString := strIteTin;
          qryGen.Open;

          if qryGen.IsEmpty then
          begin
            qryGen.Close;
            qryGen.SQL :=
              ' SELECT           ' +
              '   *              ' +
              ' FROM             ' +
              '   CIA_CADCIA     ' +
              ' WHERE CONCAT(    ' +
              '     CIA_DESCRI   ' +
              '     , " "        ' +
              '     , CIA_CODBAS ' +
              '     , " "        ' +
              '     , CIA_UNIDAD ' +
              '   ) = :ITETIN    ';
            qryGen.ParamByName('ITETIN').AsString := strIteTin;
            qryGen.Open;
          end;
        end;
      end;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('CIA_DESCRI').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

function TLibTintaCiacollor.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';//dtsTinta.FieldByName('CIA_REFERE').AsString;
end;

function TLibTintaCiacollor.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('CIA');

  strSiglaTrava := conf.fGet('TRACIA');
  fltFatTrava   := conf.fGetDouble('FATCIA');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
