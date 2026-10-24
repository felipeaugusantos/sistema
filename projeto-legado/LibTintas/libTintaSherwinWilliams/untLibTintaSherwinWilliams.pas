{************************************************************************}
{* Classe contendo as informações especificas da tinta SherwinWilliams *}
{*********************************************************************AC*}
unit untLibTintaSherwinWilliams;

interface

uses
  untAbstractLibTintaImobiliaria, untAbstractFormulaImobiliaria,
  untITintadeMaquinaWrapper, untIDataSet, untIConfTinta, untIDicionario,
  SysUtils, untIAuttinMenuItem;

type
  TLibTintaSherwinWilliams = class(TAbstractLibTintaImobiliaria)
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
  untAuttinMenuItemSherwinWilliams,
{$ENDIF}
  untFormulaImobiliariaSherwinWilliams, untTintadeMaquinaWrapperSherwinWilliams, untAutcomTintaFactory, untVariantUtils;

{ TSherwinWilliamsTintadeMaquina }

function TLibTintaSherwinWilliams.GetCampoComponenteDesComp(): String;
begin
  Result := 'COL_DESCRI';
end;

function TLibTintaSherwinWilliams.GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria;
begin
  Result := TFormulaImobiliariaSherwinWilliams.Create(strTabPre);
end;

function TLibTintaSherwinWilliams.GetITintadeMaquina: ITintadeMaquinaWrapper;
begin
  Result := TTintadeMaquinaWrapperSherwinWilliams.Create() as ITintadeMaquinaWrapper;
end;

function TLibTintaSherwinWilliams.GetMenu: IAuttinMenuItem;
begin
{$IFNDEF LINUX}
  Result := TAuttinMenuItemSherwinWilliams.Create();
{$ENDIF}
end;

function TLibTintaSherwinWilliams.GetNomeTabelaFormulacao: String;
begin
  Result := 'TMP_FORSHE';
end;

function TLibTintaSherwinWilliams.GetNomeTinta: String;
begin
  Result := 'Sherwin Williams';
end;

function TLibTintaSherwinWilliams.GetPrefixoTabela: String;
begin
  Result := 'SHE';
end;

function TLibTintaSherwinWilliams.GetQuantidadeOncaPulsoMl(const fltPulsos: Double;
  var intParteInteira: Integer; var fltParteFracao: Double; strFormul: String) : String;
Var
  fltValor1 : Double;
  fltInteiro: Double;
  fltFracao : Double;

  fltVlrInt  : Double;
  fltVlrFrac : Double;

  strFracao : String;
begin
  Result := '';

//  intParteInteira := Trunc(fltPulsos / 32);
//  fltParteFracao  := ((fltPulsos / 32) - intParteInteira) * 32;

//  Result := Format('%dY%.2f', [intParteInteira, fltParteFracao]);

  fltValor1  := (fltPulsos / 32);
  fltInteiro := Trunc(fltValor1);
  fltFracao  := frac(fltValor1);

  fltValor1  := (fltFracao * 32);

  fltVlrInt  := Trunc(fltValor1);
  fltVlrFrac := Trunc((Frac(fltValor1 )) * 100);

  If (fltVlrFrac > 25) And (fltVlrFrac <= 50) Then
  Begin
    fltVlrFrac := 50
  End
  Else If (fltVlrFrac > 50) And (fltVlrFrac <= 75) Then
  Begin
    fltVlrFrac := 1
  End
  Else If (fltVlrFrac > 75) Then
  Begin
    fltVlrFrac := 0;
    fltVlrInt  := fltVlrInt + 1;
  End;

  strFracao := (FloatToStr(fltVlrInt) + ',' + FloatToStr(fltVlrFrac));

  Result := FloatToStr(fltInteiro) + 'Y' + strFracao;
end;

function TLibTintaSherwinWilliams.GetSQLColorantesGTinFor(const strColorantes: string): string;
begin
  Result :=
    ' SELECT                                      ' +
    '   COL_CODCOL                                ' +
    '   , COL_CODITE                              ' +
    ' FROM                                        ' +
    '   SHE_CADCOL                                ' +
    ' WHERE COL_CODCOL IN (' + strColorantes + ') ';
end;

procedure TLibTintaSherwinWilliams.RetornaDadosTinta(const strIteTin: String; const dicRetorno: IDicionario);
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
        '   SHE_CADSHE               ' +
        ' WHERE SHE_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if qryGen.IsEmpty then
      begin
        qryGen.Close;
        qryGen.SQL :=
          ' SELECT                         ' +
          '   *                            ' +
          ' FROM                           ' +
          '   SHE_CADSHE                   ' +
          ' WHERE                          ' +
          '   CONCAT(SHE_DESCRI, " ", SHE_CODIGO, " ", SHE_CODIG2, " ", SHE_UNIDAD) = :ITETIN ';
        qryGen.ParamByName('ITETIN').AsString := strIteTin;
        qryGen.Open;
      end;

      if qryGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryGen.FieldByName('SHE_DESCRI').AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;                            
end;

function TLibTintaSherwinWilliams.RetornaReferenciaTinta(const dtsTinta: IDataSet): String;
begin
  Result := '';
end;

function TLibTintaSherwinWilliams.RetornaUniTraProTinta(const dtsTinta: IDataSet; const dicDados: IDicionario): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('SHE');

  strSiglaTrava := conf.fGet('TRASHE');
  fltFatTrava   := conf.fGetDouble('FATSHE');

  If strSiglaTrava = 'CUS' Then
    Result := TVariantUtils.IfNull(dicDados['prctin'], 0)
  Else
    Result := TVariantUtils.IfNull(dicDados['prvtin'], 0);

  Result := Result * fltFatTrava;
end;

end.
