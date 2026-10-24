{************************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula Lukscolor 2 *}
{******************************************************************************** PH*}
unit untFormulaImobiliariaLukscolor2;

interface

uses
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet, untColorante,
  SysUtils, untITintaDeMaquinaComponente, untStrUtils;

type
  TFormulaImobiliariaLukscolor2 = class(TAbstractFormulaImobiliaria)
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
  untAutcomTintaFactory, untMultiSelectLocalizadorFactory,
  untAbstractCalculadorFormulaImobiliaria;

{ TFormulaImobiliariaLukscolor2 }

procedure TFormulaImobiliariaLukscolor2.CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

procedure TFormulaImobiliariaLukscolor2.CarregarColorantes;
var
  strSql: String;
begin
  strSql :=
    ' SELECT         ' +
    '     COL_CODCOL ' +
    '   , COL_DESCRI ' +
    '   , COL_EMBALA ' +
    '   , COL_CODITE ' ;

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
      '   , COL_PRECUS AS ITE_PRECUS ' +
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

function TFormulaImobiliariaLukscolor2.GetCalculadorInterno: ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaLukscolor2.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('LKC_MD5KEY').AsString;
end;

function TFormulaImobiliariaLukscolor2.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('LKC_PRODUT').AsString;
end;

function TFormulaImobiliariaLukscolor2.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaImobiliariaLukscolor2.GetIdePro: String;
begin
  Result := 'LKC';
end;

function TFormulaImobiliariaLukscolor2.GetItemBaseOriginal(const strIteTin: String): String;
var
  qryGen: IDataSet;
begin
  Result := '';
  Try
    Try
      qryGen     := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := ' SELECT                              ' +
                    '   B.BAS_CODITE AS CODITE            ' +
                    ' FROM                                ' +
                    '   LKC_CADLKC A                      ' +
                    '   INNER JOIN LKC_CADBAS B           ' +
                    '     ON A.LKC_CODBAS = B.BAS_CODBAS  ' +
                    '     AND A.LKC_PRODUT = B.BAS_PRODUT ' +
                    '     AND A.LKC_UNIDAD = B.BAS_UNIDAD ' +
                    '     AND A.LKC_CONTEU = B.BAS_CONTEU ' +
                    ' WHERE LKC_MD5KEY = :ITETIN          ' ;

      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      If TMultiSelectLocalizadorFactory.GetLocalizador('LKCBAS').Localizar(qryGen, ['ITETIN'], [strIteTin]) Then
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

function TFormulaImobiliariaLukscolor2.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaLukscolor2.GetNomeCampoColDesCol: string;
begin
  Result := '';
end;

function TFormulaImobiliariaLukscolor2.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaLukscolor2.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaLukscolor2.GetNomeTabelaBase: String;
begin
  Result := 'LKC_CADBAS';
end;

function TFormulaImobiliariaLukscolor2.GetNomeTabelaColorantes: String;
begin
  Result := 'LKC_CADCOL';
end;

function TFormulaImobiliariaLukscolor2.GetPrefixoFormulacao: String;
begin
  Result := 'LKC_FORM';
end;

function TFormulaImobiliariaLukscolor2.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'LKC_QTDC';
end;

function TFormulaImobiliariaLukscolor2.GetProdutoBaseFormula(const dtsCadTin: IDataSet): String;
var
  dtsGen: IDataSet;
begin
  Try
    Try
      dtsGen := TAutcomTintaFactory.Get.fGetDataSet;
      dtsGen.SQL :=
        ' SELECT                     ' +
        '   BAS_CODITE               ' +
        ' FROM                       ' +
        '   LKC_CADBAS               ' +
        ' WHERE                      ' +
        '   BAS_CODBAS = :CODBAS AND ' +
        '   BAS_PRODUT = :PRODUT AND ' +
        '   BAS_UNIDAD = :UNIDAD AND ' +
        '   BAS_CONTEU = :CONTEU     ';

      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('LKC_CODBAS').AsString;
      dtsGen.ParamByName('PRODUT').AsString := dtsCadTin.FieldByName('LKC_PRODUT').AsString;
      dtsGen.ParamByName('UNIDAD').AsString := dtsCadTin.FieldByName('LKC_UNIDAD').AsString;
      dtsGen.ParamByName('CONTEU').AsFloat  := dtsCadTin.FieldByName('LKC_CONTEU').AsFloat;
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

function TFormulaImobiliariaLukscolor2.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaLukscolor2.GetTextoInformativoCalculo: String;
begin
  Result :=
    'Valor da Base = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) + sLineBreak +
    'Valor do Colorante = (Quantidade) * (Preço / Embalagem) ' + sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaLukscolor2.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('LKC_UNIDAD').AsString;
end;

procedure TFormulaImobiliariaLukscolor2.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('LKC_ACRMOB').AsFloat;
end;

end.
