{********************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula SherwinWilliams  *}
{*****************************************************************************AC*}
unit untFormulaImobiliariaSherwinWilliams;

interface

uses
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet, untColorante,
  SysUtils, untStrUtils;

type
  TFormulaImobiliariaSherwinWilliams = class(TAbstractFormulaImobiliaria)
  protected
    function GetCalculadorInterno(): ICalculadorFormulaImobiliaria; override;
    function GetNomeTabelaColorantes(): String; override;
    function GetTextoInformativoCalculo(): String; override;
    procedure CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante); override;
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
  untAbstractCalculadorFormulaImobiliaria, untAutcomTintaFactory;

{ TFormulaImobiliariaSherwinWilliams }

procedure TFormulaImobiliariaSherwinWilliams.CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

procedure TFormulaImobiliariaSherwinWilliams.CarregarColorantes;
var
  strSql: String;
begin
  strSql := ' SELECT         ' +
    '     COL_CODCOL ' +
    '   , COL_CODITE ' +
    '   , COL_EMBALA ' ;

  if GetNomeCampoColDesCol <> '' then
    strSql := strSql + ' , '+ GetNomeCampoColDesCol
  else
    strSql := strSql + ', "" AS COL_DESCRI ';

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

  If TAutcomTintaFactory.Get.fCfgSis('IMPDIG') = '1' Then
    strSql := strSql  + '   , I.ITE_IMPDIR  '
  else
    strSql := strSql  + '   , G.ITE_IMPDIR  ';

  If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '0') Then
  begin
    strSql := strSql +
      '   , COL_PRELIT AS ITE_PRECUS ' +
      '   , COL_PREVEN AS ITE_PREVEN ';
  end

  Else If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') And BlnCalculaUnitario Then
  begin
    strSql := strSql +
      '   , ITE_PRECUS               ' +
      '   , ITE_PREVE' + TAutcomTintaFactory.Get.fCfgSis('TABPRE') + ' AS ITE_PREVEN ';
  end
  else
  begin
    strSql := strSql +
      '   , ITE_PRECUS               ' +
      '   , ITE_PREVE' + Self.strTabPre + ' AS ITE_PREVEN ';
  end;

  strSql := strSql +
    ' FROM                               ' +
    '   ' + GetNomeTabelaColorantes + ' C                     ' +
    '   INNER JOIN ITEGER G              ' +
    '     ON C.COL_CODITE = G.ITE_CODITE ' +
    '   INNER JOIN CADITE I              ' +
    '     ON C.COL_CODITE = I.ITE_CODITE ' +
    ' WHERE G.ITE_CODEMP = :CODEMP       ';

  GetDataSetColorantes.SQL := strSql;

  If (Not TStrUtils.fEmptyStr(Self.EmpPrd)) And (Self.OprFlj = 'S') Then
    GetDataSetColorantes.ParamByName('CODEMP').AsString := Self.EmpPrd
  Else If (Not TStrUtils.fEmptyStr(Self.EmpCd_)) And (Self.Cd_S_N = 'S') Then
    GetDataSetColorantes.ParamByName('CODEMP').AsString := Self.EmpCd_
  Else If (Not TStrUtils.fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
    GetDataSetColorantes.ParamByName('CODEMP').AsString := Self.EmpFat
  Else
    GetDataSetColorantes.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;

  GetDataSetColorantes.Open;
end;

function TFormulaImobiliariaSherwinWilliams.GetCalculadorInterno: ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaSherwinWilliams.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('SHE_MD5KEY').AsString
end;

function TFormulaImobiliariaSherwinWilliams.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('SHE_DESCRI').AsString;
end;

function TFormulaImobiliariaSherwinWilliams.GetFatorEstoque: Double;
begin
  Result := 0.924;
end;

function TFormulaImobiliariaSherwinWilliams.GetIdePro: String;
begin
  Result := 'SHE';
end;

function TFormulaImobiliariaSherwinWilliams.GetItemBaseOriginal(const strIteTin: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL :=
        ' SELECT                                ' +
        '   B.BAS_CODITE AS CODITE              ' +
        ' FROM                                  ' +
        '   SHE_CADBAS B                        ' +
        '   INNER JOIN SHE_CADSHE S             ' +
        '      ON B.BAS_UNIDAD = S.SHE_UNIDAD   ' +
        '     AND B.BAS_BASE__ = S.SHE_BASE__   ' +
        '     AND B.BAS_PROKEY = S.SHE_PROKEY   ' +
        '     AND B.BAS_SUBKEY = S.SHE_SUBKEY   ' +
        '   WHERE S.SHE_MD5KEY = :ITETIN        ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      If qryGen.IsEmpty Then
      Begin
        qryGen.SQL :=
          ' SELECT                                ' +
          '   B.BAS_CODITE AS CODITE              ' +
          ' FROM                                  ' +
          '   SHE_CADBAS B                        ' +
          '   INNER JOIN SHE_CADSHE S             ' +
          '      ON B.BAS_UNIDAD = S.SHE_UNIDAD   ' +
          '     AND B.BAS_BASE__ = S.SHE_BASE__   ' +
          '     AND B.BAS_PROKEY = S.SHE_PROKEY   ' +
          '     AND B.BAS_SUBKEY = S.SHE_SUBKEY   ' +
          ' WHERE CONCAT(                         ' +
          '     S.SHE_DESCRI                      ' +
          '     , " "                             ' +
          '     , S.SHE_CODIGO                    ' +
          '     , " "                             ' +
          '     , S.SHE_CODIG2                    ' +
          '     , " "                             ' +
          '     , S.SHE_UNIDAD                    ' +
          '   ) = :ITETIN                         ';
        qryGen.ParamByName('ITETIN').AsString := strIteTin;
        qryGen.Open;
      End;

      If Not qryGen.IsEmpty Then
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

function TFormulaImobiliariaSherwinWilliams.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaSherwinWilliams.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaSherwinWilliams.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaSherwinWilliams.GetNomeTabelaBase: String;
begin
  Result := 'SHE_CADBAS';
end;

function TFormulaImobiliariaSherwinWilliams.GetNomeCampoColDesCol: string;
begin
  Result := 'COL_DESCRI';
end;

function TFormulaImobiliariaSherwinWilliams.GetNomeTabelaColorantes: String;
begin
  Result := 'SHE_CADCOL';
end;

function TFormulaImobiliariaSherwinWilliams.GetPrefixoFormulacao: String;
begin
  Result := 'SHE_FORM';
end;

function TFormulaImobiliariaSherwinWilliams.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'SHE_QTDB';
end;

function TFormulaImobiliariaSherwinWilliams.GetProdutoBaseFormula(const dtsCadTin: IDataSet): String;
var
  dtsGen: IDataSet;
begin
  Try
    Try
      dtsGen := TAutcomTintaFactory.Get.fGetDataSet;
      dtsGen.SQL :=
        ' SELECT                      ' +
        '    BAS_CODITE               ' +
        '   FROM                      ' +
        '    SHE_CADBAS               ' +
        '	 WHERE BAS_UNIDAD = :UNIDAD ' +
        '	   AND BAS_BASE__ = :BASE   ' +
        '	   AND BAS_PROKEY = :PROKEY ' +
        '	   AND BAS_SUBKEY = :SUBKEY ';

      dtsGen.ParamByName('UNIDAD').AsString := dtsCadTin.FieldByName('SHE_UNIDAD').AsString;
      dtsGen.ParamByName('BASE').AsString   := dtsCadTin.FieldByName('SHE_BASE__').AsString;
      dtsGen.ParamByName('PROKEY').AsString := dtsCadTin.FieldByName('SHE_PROKEY').AsString;
      dtsGen.ParamByName('SUBKEY').AsString := dtsCadTin.FieldByName('SHE_SUBKEY').AsString;
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

function TFormulaImobiliariaSherwinWilliams.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaSherwinWilliams.GetTextoInformativoCalculo: String;
begin
  Result :=
    'Valor da Base = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 3) + sLineBreak +
    'Valor do Colorante = (Quantidade * 0.924) * (Preço / Embalagem) ' + sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaSherwinWilliams.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('SHE_UNIDAD').AsString;
end;

procedure TFormulaImobiliariaSherwinWilliams.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('SHE_ACRMOB').AsFloat;
end;

end.

