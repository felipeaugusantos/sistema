{***************************************************************}
{* Classe contendo as informações especificas da tinta Bautech *}
{************************************************************PH*}
unit untLibTintaBautech;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaBautech = class(TAbstractLibTintaImobiliaria)
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
  untAuttinMenuItemBautech,
{$ENDIF}
  untFormulaImobiliariaBautech, untTintadeMaquinaWrapperBautech, untAutcomTintaFactory, untVariantUtils;

{ TBautechTintadeMaquina }

function TLibTintaBautech.GetCampoComponenteDesComp(): String;
begin
  Result := 'COL_DESCRI';
end;

function TLibTintaBautech.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaBautech.Create(strTabPre);
end;

function TLibTintaBautech.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperBautech.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaBautech.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemBautech.Create();
{$ENDIF}
end;

function TLibTintaBautech.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORBAU';
end;

function TLibTintaBautech.GetNomeTinta: String;
begin
  Result := 'Bautech';
end;

function TLibTintaBautech.GetPrefixoTabela: String;
begin
  Result := 'BAU';
end;

function TLibTintaBautech.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
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

function TLibTintaBautech.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   BAU_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaBautech.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL :=
        ' SELECT                     ' +
        '   BAU_DESCRI               ' +
        ' FROM                       ' +
        '   BAU_CADBAU               ' +
        ' WHERE BAU_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
      begin
        qryGen.Close;
        qryGen.SQL :=
          ' SELECT           ' +
          '   *              ' +
          ' FROM             ' +
          '   BAU_CADBAU     ' +
          ' WHERE CONCAT(    ' +
          '     BAU_CODBAS   ' +
          '     , " "        ' +
          '     , BAU_UNIDAD ' +
          '     , BAU_DESCRI ' +
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
            '   BAU_CADBAU     ' +
            ' WHERE CONCAT(    ' +
            '       BAU_UNIDAD ' +
            '     , BAU_DESCRI ' +
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
              '   BAU_CADBAU     ' +
              ' WHERE CONCAT(    ' +
              '     BAU_DESCRI   ' +
              '     , " "        ' +
              '     , BAU_CODBAS ' +
              '     , " "        ' +
              '     , BAU_UNIDAD ' +
              '   ) = :ITETIN    ';
            qryGen.ParamByName('ITETIN').AsString := strIteTin;
            qryGen.Open;
          end;
        end;
      end;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('BAU_DESCRI').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

function TLibTintaBautech.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';//dtsTinta.FieldByName('BAU_REFERE').AsString;
end;

function TLibTintaBautech.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('BAU');

  strSiglaTrava := conf.fGet('TRABAU');
  fltFatTrava   := conf.fGetDouble('FATBAU');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
