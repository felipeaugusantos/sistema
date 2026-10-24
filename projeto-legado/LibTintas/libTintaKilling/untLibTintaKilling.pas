{* Classe contendo as informações especificas da tinta Killing *}
{************************************************************PH*}
unit untLibTintaKilling;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaKilling = class(TAbstractLibTintaImobiliaria)
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
  untAuttinMenuItemKilling,
{$ENDIF}
  untFormulaImobiliariaKilling, untTintadeMaquinaWrapperKilling, untAutcomTintaFactory, untVariantUtils;

{ TKillingTintadeMaquina }

function TLibTintaKilling.GetCampoComponenteDesComp(): String;
begin
  Result := 'COL_DESCRI';
end;

function TLibTintaKilling.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaKilling.Create(strTabPre);
end;

function TLibTintaKilling.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperKilling.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaKilling.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemKilling.Create();
{$ENDIF}
end;

function TLibTintaKilling.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORKIL';
end;

function TLibTintaKilling.GetNomeTinta: String;
begin
  Result := 'Killing';
end;

function TLibTintaKilling.GetPrefixoTabela: String;
begin
  Result := 'KIL';
end;

function TLibTintaKilling.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String) : String;
var
  strCalculo:String;
  fltFracao:Double;
begin
  strCalculo := FloatToStr(Int(fltPulsos / 48));
  fltFracao := fltPulsos - (Int(fltPulsos / 48) * 48);
  Result := strCalculo + 'Y' + FormatFloat('0.00', fltFracao);
end;

function TLibTintaKilling.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   KILD_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaKilling.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
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
        '   KILD_CADKIL               ' +
        ' WHERE KIL_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('KIL_CODCOR').AsString +
                              qryGen.FieldByName('KIL_DESCRI').AsString +
                              qryGen.FieldByName('KIL_REFERE').AsString +
                              qryGen.FieldByName('KIL_CODFML').AsString +
                              qryGen.FieldByName('KIL_CODBAS').AsString +
                              qryGen.FieldByName('KIL_CODUNI').AsString ;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

function TLibTintaKilling.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := dtsTinta.FieldByName('KIL_REFERE').AsString;
end;

function TLibTintaKilling.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('KIL');

  strSiglaTrava := conf.fGet('TRAKIL');
  fltFatTrava   := conf.fGetDouble('FATKIL');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
