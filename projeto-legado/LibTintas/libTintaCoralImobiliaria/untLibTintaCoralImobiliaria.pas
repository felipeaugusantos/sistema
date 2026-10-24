{************************************************************************}
{* Classe contendo as informações especificas da tinta CoralImobiliaria *}
{*********************************************************************AC*}
unit untLibTintaCoralImobiliaria;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaCoralImobiliaria = class(TAbstractLibTintaImobiliaria)
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
  untAuttinMenuItemCoralImobiliaria,
{$ENDIF}
  untFormulaImobiliariaCoralImobiliaria, untTintadeMaquinaWrapperCoralImobiliaria, untAutcomTintaFactory, untVariantUtils;

{ TCoralImobiliariaTintadeMaquina }

function TLibTintaCoralImobiliaria.GetCampoComponenteDesComp(): String;
begin
  Result := '""';
end;

function TLibTintaCoralImobiliaria.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaCoralImobiliaria.Create(strTabPre);
end;

function TLibTintaCoralImobiliaria.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperCoralImobiliaria.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaCoralImobiliaria.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemCoralImobiliaria.Create();
{$ENDIF}
end;

function TLibTintaCoralImobiliaria.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORCIM';
end;

function TLibTintaCoralImobiliaria.GetNomeTinta: String;
begin
  Result := 'Coral Imobiliária';
end;

function TLibTintaCoralImobiliaria.GetPrefixoTabela: String;
begin
  Result := 'COR';
end;

function TLibTintaCoralImobiliaria.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String) : String;
begin
  Result := '';
  intParteInteira := Trunc(fltPulsos / 96);
  fltParteFracao  :=  ((fltPulsos / 96) - intParteInteira) * 48;
  Result := Format('%dY%.2f', [intParteInteira, fltParteFracao]);
end;

function TLibTintaCoralImobiliaria.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   CORIMO_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaCoralImobiliaria.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL :=
        ' SELECT                     ' +
        '   COR_DESCRI,              ' +
        '   COR_COLID1,              ' +
        '   COR_COLID2,              ' +
        '   COR_DESPRO               ' +
        ' FROM                       ' +
        '   CORIMO_CADCOR            ' +
        ' WHERE COR_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
      begin
        qryGen.Close;
        qryGen.SQL :=
          ' SELECT                         ' +
          '   COR_DESCRI,                  ' +
          '   COR_COLID1,                  ' +
          '   COR_COLID2,                  ' +
          '   COR_DESPRO                   ' + 
          ' FROM                           ' +
          '   CORIMO_CADCOR                ' +
          ' WHERE CONCAT(                  ' +
          '     IFNULL(COR_DESCRI, '''')   ' +
          '     , IFNULL(COR_CODIGO, '''') ' +
          '     , IFNULL(COR_UNIDAD, '''') ' +
          '     , IFNULL(COR_COLID1, '''') ' +
          '     , IFNULL(COR_COLID2, '''') ' +
          '     , IFNULL(COR_DESPRO, '''') ' +
          '     , IFNULL(COR_CODBAS, '''') ' +
          '     , IFNULL(COR_CODEMB, '''') ' +
          '     , IFNULL(COR_CODUNI, '''') ' +
          '     , IFNULL(COR_UNIVER, '''') ' +
          '   ) = :ITETIN                  ';
        qryGen.ParamByName('ITETIN').AsString := strIteTin;
        qryGen.Open;

        if qryGen.IsEmpty then
        begin
          qryGen.Close;
          qryGen.SQL :=
            ' SELECT                         ' +
            '   COR_DESCRI,                  ' +
            '   COR_COLID1,                  ' +
            '   COR_COLID2,                  ' +
            '   COR_DESPRO                   ' + 
            ' FROM                           ' +
            '   CORIMO_CADCOR                ' +
            ' WHERE CONCAT(                  ' +
            '     IFNULL(COR_COLID1, '''')   ' +
            '     , IFNULL(COR_COLID2, '''') ' +
            '     , IFNULL(COR_DESPRO, '''') ' +
            '     , IFNULL(COR_CODBAS, '''') ' +
            '     , IFNULL(COR_CODIGO, '''') ' +
            '     , IFNULL(COR_UNIDAD, '''') ' +
            '   ) = :ITETIN                  ';
          qryGen.ParamByName('ITETIN').AsString := strIteTin;
          qryGen.Open;

          if qryGen.IsEmpty then
          begin
            qryGen.Close;
            qryGen.SQL :=
              ' SELECT                     ' +
              '   COR_DESCRI,              ' +
              '   COR_COLID1,              ' +
              '   COR_COLID2,              ' +
              '   COR_DESPRO               ' + 
              ' FROM                       ' +
              '   CORIMO_CADCOR            ' +
              ' WHERE COR_CODSEQ = :ITETIN ';
            qryGen.ParamByName('ITETIN').AsString := strIteTin;
            qryGen.Open;
          end;
        end;
      end;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('COR_COLID1').AsString + '/' +
                              qryGen.FieldByName('COR_COLID2').AsString;
      dicRetorno['martin'] := qryGen.FieldByName('COR_DESPRO').AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

function TLibTintaCoralImobiliaria.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';//dtsTinta.FieldByName('COR_REFERE').AsString;
end;

function TLibTintaCoralImobiliaria.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('CIM');

  strSiglaTrava := conf.fGet('TRACOR');
  fltFatTrava   := conf.fGetDouble('FATCOR');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
