{ ******************************************************************************** }
{ * Classe responsável pelas rotidas especificas de uma formula Lukscolor * }
{ *****************************************************************************AC* }
unit untFormulaImobiliariaLukscolor;

interface

uses
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet,
  untColorante, SysUtils, untStrUtils;

type
  TFormulaImobiliariaLukscolor = class(TAbstractFormulaImobiliaria)
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
//    procedure CarregarColorantes; override;
    procedure PreencheAcrescimoMaoObra(const dtsCadTin: IDataSet); Override;
    procedure CarregarColorantes; Override;
  end;

implementation

uses
  untAbstractCalculadorFormulaImobiliaria, untAutcomTintaFactory,
  untMultiSelectLocalizadorFactory;

{ TFormulaImobiliariaLukscolor }

procedure TFormulaImobiliariaLukscolor.CarregaPrecosColorantesAdicional
  (const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

procedure TFormulaImobiliariaLukscolor.CarregarColorantes;
var
  strSql: String;
begin
  strSql := ' SELECT         ' +
            '     COL_CODCOL ' +
            '   , COL_CODITE ' +
            '   , COL_EMBALA ' ;

  if GetNomeCampoColDesCol <> '' then
    strSql := strSql + ' , ' + GetNomeCampoColDesCol
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
    strSql := strSql + '   , I.ITE_IMPDIR  '
  else
    strSql := strSql + '   , G.ITE_IMPDIR  ';

  If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '0') Then
  begin
    strSql := strSql +
      '   , COL_PRECUS AS ITE_PRECUS ' +
      '   , COL_PREVEN AS ITE_PREVEN ';
  end

  Else If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') And (BlnCalculaUnitario) Then
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

  If Not (TStrUtils.fEmptyStr(Self.EmpPrd)) And (Self.OprFlj = 'S') Then
    GetDataSetColorantes.ParamByName('CODEMP').AsString := Self.EmpPrd
  Else If Not (TStrUtils.fEmptyStr(Self.EmpCd_)) And (Self.Cd_S_N = 'S') Then
    GetDataSetColorantes.ParamByName('CODEMP').AsString := Self.EmpCd_
  Else If Not (TStrUtils.fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
    GetDataSetColorantes.ParamByName('CODEMP').AsString := Self.EmpFat
  Else
    GetDataSetCOlorantes.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;

  GetDataSetColorantes.Open;
end;

function TFormulaImobiliariaLukscolor.GetCalculadorInterno: ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaLukscolor.GetChaveIteTin(const dtsCadTin : IDataSet): string;
begin
  If Not TStrUtils.fEmptyStr(dtsCadTin.FieldByName('LKD_MD5KEY').AsString) Then
    Result := dtsCadTin.FieldByName('LKD_MD5KEY').AsString
  Else
    Result := dtsCadTin.FieldByName('LKD_DESCRI').AsString + ' ' +
              dtsCadTin.FieldByName('LKD_CODIGO').AsString + ' ' +
              dtsCadTin.FieldByName('LKD_CODIG2').AsString + ' ' +
              dtsCadTin.FieldByName('LKD_UNIDAD').AsString;
end;

function TFormulaImobiliariaLukscolor.GetDescricao(const dtsCadTin : IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('LKD_DESCRI').AsString;
end;

function TFormulaImobiliariaLukscolor.GetFatorEstoque: Double;
begin
  Result := 0.154;
end;

function TFormulaImobiliariaLukscolor.GetIdePro: String;
begin
  Result := 'LKS';
end;

function TFormulaImobiliariaLukscolor.GetItemBaseOriginal(const strIteTin : String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      If TMultiSelectLocalizadorFactory.GetLocalizador('LKDBAS').Localizar(qryGen, ['ITETIN'], [strIteTin]) Then
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

function TFormulaImobiliariaLukscolor.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaLukscolor.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaLukscolor.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaLukscolor.GetNomeTabelaBase: String;
begin
  Result := 'LKD_CADBAS';
end;

function TFormulaImobiliariaLukscolor.GetNomeCampoColDesCol: string;
begin
  Result := 'COL_DESCRI';
end;

function TFormulaImobiliariaLukscolor.GetNomeTabelaColorantes: String;
begin
  Result := 'LKD_CADCOL';
end;

function TFormulaImobiliariaLukscolor.GetPrefixoFormulacao: String;
begin
  Result := 'LKD_FORM';
end;

function TFormulaImobiliariaLukscolor.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'LKD_QTDB';
end;

function TFormulaImobiliariaLukscolor.GetProdutoBaseFormula(const dtsCadTin : IDataSet): String;
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
        '   LKD_CADBAS               ' +
        ' WHERE BAS_BASE__ = :CODBAS ' +
        '   AND BAS_PROKEY = :PROKEY ' +
        '   AND BAS_SUBKEY = :SUBKEY ' +
        '   AND BAS_UNIDAD = :CODUNI ' ;

      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('LKD_BASE__').AsString;
      dtsGen.ParamByName('CODUNI').AsString := dtsCadTin.FieldByName('LKD_UNIDAD').AsString;
      dtsGen.ParamByName('SUBKEY').AsString := dtsCadTin.FieldByName('LKD_SUBKEY').AsString;
      dtsGen.ParamByName('PROKEY').AsString := dtsCadTin.FieldByName('LKD_PROKEY').AsString;

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

function TFormulaImobiliariaLukscolor.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaLukscolor.GetTextoInformativoCalculo: String;
begin
  Result := 'Valor da Base = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) +
    sLineBreak +
    'Valor do Colorante = (Quantidade * 0.154) * (Preço / Embalagem) ' +
    sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaLukscolor.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('LKD_UNIDAD').AsString;
end;

procedure TFormulaImobiliariaLukscolor.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('LKD_ACRMOB').AsFloat;
end;

end.
