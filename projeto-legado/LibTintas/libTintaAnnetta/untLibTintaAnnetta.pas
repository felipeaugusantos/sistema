{************************************************************************}
{* Classe contendo as informações especificas da tinta Annetta *}
{*********************************************************************AC*}
unit untLibTintaAnnetta;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaAnnetta = class(TAbstractLibTintaImobiliaria)
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
  untAuttinMenuItemAnnetta,
{$ENDIF}
  untFormulaImobiliariaAnnetta, untTintadeMaquinaWrapperAnnetta, untAutcomTintaFactory, untVariantUtils;

{ TAnnettaTintadeMaquina }

function TLibTintaAnnetta.GetCampoComponenteDesComp(): String;
begin
  Result := 'COL_DESCRI';
end;

function TLibTintaAnnetta.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaAnnetta.Create(strTabPre);
end;

function TLibTintaAnnetta.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperAnnetta.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaAnnetta.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemAnnetta.Create();
{$ENDIF}
end;

function TLibTintaAnnetta.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORANN';
end;

function TLibTintaAnnetta.GetNomeTinta: String;
begin
  Result := 'Annetta';
end;

function TLibTintaAnnetta.GetPrefixoTabela: String;
begin
  Result := 'ANN';
end;

function TLibTintaAnnetta.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String) : String;
var
  fltCalculo,
  fltInteiroOnca,
  fltFracaoOnca: Double;
begin
  fltCalculo     := (fltPulsos / 48) / 0.61604;
  fltInteiroOnca := Trunc(fltCalculo);
  fltFracaoOnca  := TAutcomTintaFactory.Get.fStrToFloat(FormatFloat('0.000', (fltCalculo - fltInteiroOnca) * 48));

  Result := Format('%dY%.1f', [Trunc(fltInteiroOnca), fltFracaoOnca]);
end;

function TLibTintaAnnetta.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   ANN_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaAnnetta.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
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
        '   ANN_CADANN            ' +
        ' WHERE ANN_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('ANN_DESCRI').AsString +
                              qryGen.FieldByName('ANN_CODIGO').AsString +
                              qryGen.FieldByName('ANN_UNIDAD').AsString +
                              qryGen.FieldByName('ANN_CODBAS').AsString +
                              qryGen.FieldByName('ANN_CODEMB').AsString +
                              qryGen.FieldByName('ANN_CODUNI').AsString +
                              qryGen.FieldByName('ANN_PRODUT').AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

function TLibTintaAnnetta.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';//dtsTinta.FieldByName('ANN_REFERE').AsString;
end;

function TLibTintaAnnetta.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('ANN');

  strSiglaTrava := conf.fGet('TRAANN');
  fltFatTrava   := conf.fGetDouble('FATANN');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
