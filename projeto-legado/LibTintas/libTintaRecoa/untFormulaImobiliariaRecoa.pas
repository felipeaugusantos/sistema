{ ******************************************************************************** }
{ * Classe responsável pelas rotidas especificas de uma formula Recoa * }
{ *****************************************************************************AC* }
unit untFormulaImobiliariaRecoa;

interface

uses
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet,
  untColorante, SysUtils, untStrUtils;

type
  TFormulaImobiliariaRecoa = class(TAbstractFormulaImobiliaria)
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

{ TFormulaImobiliariaRecoa }

procedure TFormulaImobiliariaRecoa.CarregaPrecosColorantesAdicional
  (const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

procedure TFormulaImobiliariaRecoa.CarregarColorantes;
var
  strSql: String;
begin
  strSql := ' SELECT         ' +
            '     COL_CODCOL ' +
            '   , COL_CODITE ' +
            '   , COL_EMBALA ';

  if GetNomeCampoColDesCol <> '' then
    strSql := strSql + ' , ' + GetNomeCampoColDesCol
  else
    strSql := strSql + ', "" AS COL_DESCRI ';

  strSql := strSql + '   , IFNULL(ITE_ITEATI, "N") ITE_ITEATI      ' +
    '   , ITE_CNV_ML ' + '   , ITE_OUTVAL ' + '   , ITE_ICMSAI ' +
    '   , ITE_IMPFED ' + '   , ITE_DESOPE ' + '   , ITE_PREMED ' +
    '   , ITE_IMPULT ' + '   , ITE_PREULT ' +

    '   , ITE_PRECOM ' + '   , ITE_DESF01 ' + '   , ITE_DESF02 ' +
    '   , ITE_DESF03 ' + '   , ITE_DESF04 ' + '   , ITE_DESF05 ' +
    '   , ITE_DESF06 ';

  If TAutcomTintaFactory.Get.fCfgSis('IMPDIG') = '1' Then
    strSql := strSql + '   , I.ITE_IMPDIR  '
  else
    strSql := strSql + '   , G.ITE_IMPDIR  ';

  If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '0') Then
  begin
    strSql := strSql + '   , COL_PRECUS AS ITE_PRECUS ' +
      '   , COL_PREVEN AS ITE_PREVEN ';
  end

  Else If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') And BlnCalculaUnitario Then
  begin
    strSql := strSql + '   , ITE_PRECUS               ' +
                       '   , ITE_PREVE' + TAutcomTintaFactory.Get.fCfgSis('TABPRE') + ' AS ITE_PREVEN ';
  end
  else
  begin
    strSql := strSql + '   , ITE_PRECUS               ' + '   , ITE_PREVE' +
      Self.strTabPre + ' AS ITE_PREVEN ';
  end;

  strSql := strSql + ' FROM                               ' + '   ' +
    GetNomeTabelaColorantes + ' C                     ' +
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

function TFormulaImobiliariaRecoa.GetCalculadorInterno
  : ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaRecoa.GetChaveIteTin(const dtsCadTin
  : IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('REC_MD5KEY').AsString
end;

function TFormulaImobiliariaRecoa.GetDescricao(const dtsCadTin
  : IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('REC_DESCRI').AsString;
end;

function TFormulaImobiliariaRecoa.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaImobiliariaRecoa.GetIdePro: String;
begin
  Result := 'REC';
end;

function TFormulaImobiliariaRecoa.GetItemBaseOriginal(const strIteTin
  : String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      If TMultiSelectLocalizadorFactory.GetLocalizador('RECBAS')
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

function TFormulaImobiliariaRecoa.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaRecoa.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaRecoa.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaRecoa.GetNomeTabelaBase: String;
begin
  Result := 'REC_CADBAS';
end;

function TFormulaImobiliariaRecoa.GetNomeCampoColDesCol: string;
begin
  Result := '';
end;

function TFormulaImobiliariaRecoa.GetNomeTabelaColorantes: String;
begin
  Result := 'REC_CADCOL';
end;

function TFormulaImobiliariaRecoa.GetPrefixoFormulacao: String;
begin
  Result := 'REC_FORM';
end;

function TFormulaImobiliariaRecoa.GetPrefixoQuantidade(const strModo
  : String): String;
begin
  Result := 'REC_QTDC';
end;

function TFormulaImobiliariaRecoa.GetProdutoBaseFormula(const dtsCadTin
  : IDataSet): String;
var
  dtsGen: IDataSet;
begin
  Try
    Try
      dtsGen := TAutcomTintaFactory.Get.fGetDataSet;
      dtsGen.SQL := ' SELECT                     ' +
        '   BAS_CODITE               ' + ' FROM                       ' +
        '   REC_CADBAS               ' + ' WHERE BAS_BASE__ = :CODBAS ' +
        '   AND BAS_UNIDAD = :CODUNI ';

      dtsGen.ParamByName('CODBAS').AsString :=
        dtsCadTin.FieldByName('REC_CODBAS').AsString;
      dtsGen.ParamByName('CODUNI').AsString :=
        dtsCadTin.FieldByName('REC_UNIDAD').AsString;
 {     dtsGen.ParamByName('DESCRI').AsString :=
        dtsCadTin.FieldByName('REC_DESCRI').AsString; }
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

function TFormulaImobiliariaRecoa.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaRecoa.GetTextoInformativoCalculo: String;
begin
  Result := 'Valor da Base = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) +
    sLineBreak +
    'Valor do Colorante = Quantidade * (Preço / Embalagem) ' +
    sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaRecoa.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('REC_UNIDAD').AsString;
end;

procedure TFormulaImobiliariaRecoa.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('REC_ACRMOB').AsFloat;
end;

end.
