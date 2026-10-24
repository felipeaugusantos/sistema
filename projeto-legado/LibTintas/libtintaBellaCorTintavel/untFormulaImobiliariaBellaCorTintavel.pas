{ ******************************************************************************** }
{ * Classe responsável pelas rotidas especificas de uma formula BellaCorTintavel * }
{ *****************************************************************************AC* }
unit untFormulaImobiliariaBellaCorTintavel;

interface

uses
{$IFNDEF LINUX}
  Vcl.ComCtrls,
  Forms,
{$ENDIF}
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet,
  untColorante, SysUtils,  Classes, untAbstractFormula, untStrUtils;

type
  TFormulaImobiliariaBellaCorTintavel = class(TAbstractFormulaImobiliaria)
  Private
    function fVerificaIMPDIG(): String;
    function fVerificaEmpPrdOprFlj(): Boolean;
    function fEmpresa(): String;
    function fVerificaEmpCd(strEmpCd, strCD_S_N: String): Boolean;
    function fVerificaEmpFat(strEmpFat, strFatS_N: String): Boolean;
    function fVerificaPrecoGeracaoBlnUnitario(): Boolean;
  protected
    function GetCalculadorInterno(): ICalculadorFormulaImobiliaria; override;
    function GetNomeTabelaColorantes(): String; override;
    function GetTextoInformativoCalculo(): String; override;
    procedure CarregaPrecosColorantesAdicional(const dataSetColorantes
      : IDataSet; const colorante: TColorante); override;
    function GetNomeCampoCustoBase: String; override;
    function GetNomeCampoVendaBase: String; override;
    function GetNomeTabelaBase: String; override;
    function GetNomeCampoBaseCodIte: String; override;
  public
    function GetPrefixoQuantidade(const strModo: String): String; override;
    function GetQuantidadeFormulacao(): Integer; override;
    function GetPrefixoFormulacao(): String; override;
    function GetDescricao(const dtsCadTin: IDataSet): String; override;
    function GetUnidade(const dtsCadTin: IDataSet): String; override;
    function GetProdutoBaseFormula(const dtsCadTin: IDataSet): String; override;
    function GetFatorEstoque(): Double; override;
    function GetIdePro: String; override;
    function GetItemBaseOriginal(const strIteTin: String): String; override;
    function GetChaveIteTin(const dtsCadTin: IDataSet): string; override;
    function GetNomeCampoColDesCol: string; override;
    procedure CarregarColorantes; override;
    procedure PreencheAcrescimoMaoObra(const dtsCadTin: IDataSet); Override;
  end;

implementation

uses
  untAbstractCalculadorFormulaImobiliaria, untAutcomTintaFactory,
  untMultiSelectLocalizadorFactory;

{ TFormulaImobiliariaBellaCorTintavel }

procedure TFormulaImobiliariaBellaCorTintavel.CarregaPrecosColorantesAdicional
  (const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

procedure TFormulaImobiliariaBellaCorTintavel.CarregarColorantes;
var
  strSql: String;
begin
  strSql := ' SELECT         ' +
            '     COL_CODCOL ' +
            '   , COL_CODITE ' +
            '   , COL_EMBALA ';

  strSql := strSql + ' , ' + GetNomeCampoColDesCol;

  strSql := strSql +
    '   , IFNULL(ITE_ITEATI, "N") ITE_ITEATI      ' +
    '   , ITE_CNV_ML ' +
    '   , ITE_OUTVAL ' +
    '   , ITE_ICMSAI ' +
    '   , ITE_IMPFED ' +
    '   , ITE_DESOPE ' +
    '   , ITE_PREMED ' +
    '   , ITE_IMPULT ' +
    '   , ITE_PREULT ' +
    '   , ITE_PRECOM ' +
    '   , ITE_DESF01 ' +
    '   , ITE_DESF02 ' +
    '   , ITE_DESF03 ' +
    '   , ITE_DESF04 ' +
    '   , ITE_DESF05 ' +
    '   , ITE_DESF06 ';

  strSql := strSql + fVerificaIMPDIG;

  If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '0') Then
  begin
    strSql := strSql +
      '   , COL_PRECUS AS ITE_PRECUS ' +
      '   , COL_PREVEN AS ITE_PREVEN ';
  end

  Else If fVerificaPrecoGeracaoBlnUnitario Then
  begin
    strSql := strSql +
      '   , ITE_PRECUS               ' +
      '   , ITE_PREVE'+ TAutcomTintaFactory.Get.fCfgSis('TABPRE') + ' AS ITE_PREVEN ';
  end
  else
  begin
    strSql := strSql +
      '   , ITE_PRECUS               ' +
      '   , ITE_PREVE' + Self.strTabPre + ' AS ITE_PREVEN ';
  end;

  strSql := strSql +
    ' FROM                               ' +
    '   ' +     GetNomeTabelaColorantes + ' C ' +
    '   INNER JOIN ITEGER G              ' +
    '     ON C.COL_CODITE = G.ITE_CODITE ' +
    '   INNER JOIN CADITE I              ' +
    '     ON C.COL_CODITE = I.ITE_CODITE ' +
    ' WHERE G.ITE_CODEMP = :CODEMP       ';

  GetDataSetColorantes.SQL := strSql;
  GetDataSetCOlorantes.ParamByName('CODEMP').AsString := fEmpresa;

  GetDataSetColorantes.Open;
end;

function TFormulaImobiliariaBellaCorTintavel.fEmpresa: String;
begin
  If fVerificaEmpPrdOprFlj Then
    Result := Self.EmpPrd
  Else If fVerificaEmpCd(Self.EmpCd_, Self.CD_S_N) Then
    Result := Self.EmpCd_
  Else If fVerificaEmpFat(Self.EmpFat, Self.FatS_N) Then
    Result := Self.EmpFat
  Else
    Result := TAutcomTintaFactory.Get.GetCodEmp
end;

function TFormulaImobiliariaBellaCorTintavel.fVerificaEmpCd(strEmpCd,
  strCD_S_N: String): Boolean;
begin
  Result := False;

  If Not (TStrUtils.fEmptyStr(strEmpCd)) Then
  Begin
    If strCD_S_N = 'S' Then
      Result := True;
  End;
end;

function TFormulaImobiliariaBellaCorTintavel.fVerificaEmpFat(strEmpFat,
  strFatS_N: String): Boolean;
begin
  Result := False;

  If Not (TStrUtils.fEmptyStr(strEmpFat)) Then
  Begin
    If strFatS_N = 'S' Then
      Result := True;
  End;
end;

function TFormulaImobiliariaBellaCorTintavel.fVerificaEmpPrdOprFlj: Boolean;
begin
  Result := False;

  If Not (TStrUtils.fEmptyStr(Self.EmpPrd)) Then
  Begin
    If Self.OprFlj = 'S' Then
      Result := True;
  End;
end;

function TFormulaImobiliariaBellaCorTintavel.fVerificaIMPDIG: String;
begin
  If TAutcomTintaFactory.Get.fCfgSis('IMPDIG') = '1' Then
    Result := '   , I.ITE_IMPDIR  '
  Else
    Result := '   , G.ITE_IMPDIR  ';
end;

function TFormulaImobiliariaBellaCorTintavel.fVerificaPrecoGeracaoBlnUnitario: Boolean;
begin
  Result := False;

  If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') Then
  Begin
    If BlnCalculaUnitario Then
      Result := True;
  End;
end;

function TFormulaImobiliariaBellaCorTintavel.GetCalculadorInterno
  : ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaBellaCorTintavel.GetChaveIteTin(const dtsCadTin
  : IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('BLT_MD5KEY').AsString
end;

function TFormulaImobiliariaBellaCorTintavel.GetDescricao(const dtsCadTin
  : IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('BLT_PRODUT').AsString;
end;

function TFormulaImobiliariaBellaCorTintavel.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaImobiliariaBellaCorTintavel.GetIdePro: String;
begin
  Result := 'BLT';
end;

function TFormulaImobiliariaBellaCorTintavel.GetItemBaseOriginal(const strIteTin
  : String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      If TMultiSelectLocalizadorFactory.GetLocalizador('BLTBAS')
        .Localizar(qryGen, ['ITETIN'], [strIteTin]) Then
        Result := qryGen.FieldByName('CODITE').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

function TFormulaImobiliariaBellaCorTintavel.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaBellaCorTintavel.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaBellaCorTintavel.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaBellaCorTintavel.GetNomeTabelaBase: String;
begin
  Result := 'BLT_CADBAS';
end;

function TFormulaImobiliariaBellaCorTintavel.GetNomeCampoColDesCol: string;
begin
  Result := 'COL_DESCRI';
end;

function TFormulaImobiliariaBellaCorTintavel.GetNomeTabelaColorantes: String;
begin
  Result := 'BLT_CADCOL';
end;

function TFormulaImobiliariaBellaCorTintavel.GetPrefixoFormulacao: String;
begin
  Result := 'BLT_FORM';
end;

function TFormulaImobiliariaBellaCorTintavel.GetPrefixoQuantidade(const strModo
  : String): String;
begin
  Result := 'BLT_QTDC';
end;

function TFormulaImobiliariaBellaCorTintavel.GetProdutoBaseFormula(const dtsCadTin
  : IDataSet): String;
var
  dtsGen: IDataSet;
begin
  Try
    Try
      dtsGen := TAutcomTintaFactory.Get.fGetDataSet;
      dtsGen.SQL := ' SELECT                     ' +
        '   BAS_CODITE               ' + ' FROM                       ' +
        '   BLT_CADBAS               ' + ' WHERE BAS_CODBAS = :CODBAS ' +
        '   AND BAS_UNIDAD = :CODUNI ' + '  AND BAS_PRODUT = :DESCRI  ';

      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('BLT_CODBAS').AsString;
      dtsGen.ParamByName('CODUNI').AsString := dtsCadTin.FieldByName('BLT_UNIDAD').AsString;
      dtsGen.ParamByName('DESCRI').AsString := dtsCadTin.FieldByName('BLT_PRODUT').AsString;
      dtsGen.Open;

      Result := dtsGen.FieldByName('BAS_CODITE').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

function TFormulaImobiliariaBellaCorTintavel.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaBellaCorTintavel.GetTextoInformativoCalculo: String;
begin
  Result :=
    'Valor da Base = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) + sLineBreak +
    'Valor do Colorante = (Quantidade) * (Preço / Embalagem) ' + sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaBellaCorTintavel.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('BLT_UNIDAD').AsString;
end;

procedure TFormulaImobiliariaBellaCorTintavel.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('BLT_ACRMOB').AsFloat;
end;

end.
