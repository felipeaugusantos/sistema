{***************************************************************}
{* Classe contendo as informações especificas da tinta SherwinWilliams2 *}
{************************************************************PH*}
unit untLibTintaSherwinWilliams2;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaSherwinWilliams2 = class(TAbstractLibTintaImobiliaria)
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
  untAuttinMenuItemSherwinWilliams2,
{$ENDIF}
  untFormulaImobiliariaSherwinWilliams2, untTintadeMaquinaWrapperSherwinWilliams2, untAutcomTintaFactory, untVariantUtils;

{ TSherwinWilliams2TintadeMaquina }

function TLibTintaSherwinWilliams2.GetCampoComponenteDesComp(): String;
begin
  Result := '""';
end;

function TLibTintaSherwinWilliams2.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaSherwinWilliams2.Create(strTabPre);
end;

function TLibTintaSherwinWilliams2.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperSherwinWilliams2.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaSherwinWilliams2.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemSherwinWilliams2.Create();
{$ENDIF}
end;

function TLibTintaSherwinWilliams2.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORSHW';
end;

function TLibTintaSherwinWilliams2.GetNomeTinta: String;
begin
  Result := 'Sherwin Williams 2';
end;

function TLibTintaSherwinWilliams2.GetPrefixoTabela: String;
begin
  Result := 'SHW';
end;

function TLibTintaSherwinWilliams2.GetQuantidadeMlPulso(const fltValor: Double;
  intDecFor: Integer; strFormul: String): String;
begin
  Result := FloatToStrF(fltValor / 0.924, ffNumber, 12, intDecFor);
end;


function TLibTintaSherwinWilliams2.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String) : String;
Var
  fltOnca:Double;
begin
  fltOnca := fltPulsos / 0.924;
  Result := FloatToStrF(fltOnca, ffNumber, 12, 2);
end;

function TLibTintaSherwinWilliams2.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   SHW_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaSherwinWilliams2.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.Close;
      qryGen.SQL :=
        ' SELECT                     ' +
        '   SHW_CODIGO               ' +
        ' FROM                       ' +
        '   SHW_CADSHW               ' +
        ' WHERE SHW_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('SHW_CODIGO').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

function TLibTintaSherwinWilliams2.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaSherwinWilliams2.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('SHW');

  strSiglaTrava := conf.fGet('TRASHW');
  fltFatTrava   := conf.fGetDouble('FATTIN');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
