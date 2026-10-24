{***********************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula MegaTintas *}
{********************************************************************PH*}
unit untFormulaImobiliariaMegaTintas;

interface

uses
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet, untColorante,
  SysUtils, untStrUtils;

type
  TFormulaImobiliariaMegaTintas = class(TAbstractFormulaImobiliaria)
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

{ TFormulaImobiliariaMegaTintas }

procedure TFormulaImobiliariaMegaTintas.CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat
end;

procedure TFormulaImobiliariaMegaTintas.CarregarColorantes;
var
  strSql: String;
begin
  strSql := ' SELECT ' +
    '     COL_CODCOL ' +
    '   , COL_CODITE ' +
    '   , COL_EMBALA ' +
    '   , COL_DESCRI ' +
    '   , IFNULL(ITE_ITEATI, "N") ITE_ITEATI ' +
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
    ' FROM                                ' +
    '   ' + GetNomeTabelaColorantes + ' C ' +
    '   INNER JOIN ITEGER G               ' +
    '     ON C.COL_CODITE = G.ITE_CODITE  ' +
    '   INNER JOIN CADITE I               ' +
    '     ON C.COL_CODITE = I.ITE_CODITE  ' +
    ' WHERE G.ITE_CODEMP = :CODEMP        ';

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

function TFormulaImobiliariaMegaTintas.GetCalculadorInterno: ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaMegaTintas.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := '';

  if Assigned(dtsCadTin.FindField('MEG_MD5KEY')) then
    Result := dtsCadTin.FieldByName('MEG_MD5KEY').AsString;

end;

function TFormulaImobiliariaMegaTintas.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('MEG_DESCRI').AsString;
end;

function TFormulaImobiliariaMegaTintas.GetFatorEstoque: Double;
begin
  Result := 0.154;
end;

function TFormulaImobiliariaMegaTintas.GetIdePro: String;
begin
  Result := 'MEG';
end;

function TFormulaImobiliariaMegaTintas.GetItemBaseOriginal(const strIteTin: String): String;
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
        '   MEG_CADBAS B                        ' +
        '   INNER JOIN MEG_CADMEG S             ' +
        '      ON B.BAS_CODBAS = S.MEG_BASE__   ' +
        '     AND B.BAS_CODUNI = S.MEG_CODUNI   ' +
        '     AND B.BAS_DESCRI = S.MEG_PRODUT   ' +
        ' WHERE S.MEG_MD5KEY = :ITETIN          ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if not qryGen.IsEmpty then
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

function TFormulaImobiliariaMegaTintas.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaMegaTintas.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaMegaTintas.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaMegaTintas.GetNomeTabelaBase: String;
begin
  Result := 'MEG_CADBAS';
end;

function TFormulaImobiliariaMegaTintas.GetNomeCampoColDesCol: string;
begin
  Result := 'COL_DESCRI';
end;

function TFormulaImobiliariaMegaTintas.GetNomeTabelaColorantes: String;
begin
  Result := 'MEG_CADCOL';
end;

function TFormulaImobiliariaMegaTintas.GetPrefixoFormulacao: String;
begin
  Result := 'MEG_FORM';
end;

function TFormulaImobiliariaMegaTintas.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'MEG_QTDC';
end;

function TFormulaImobiliariaMegaTintas.GetProdutoBaseFormula(const dtsCadTin: IDataSet): String;
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
        '   MEG_CADBAS               ' +
        ' WHERE BAS_CODBAS = :CODBAS ' +
        '   AND BAS_CODUNI = :CODUNI ' +
        '   AND BAS_PRODUT = :PRODUT ' ;

      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('MEG_BASE__').AsString;
      dtsGen.ParamByName('CODUNI').AsString := dtsCadTin.FieldByName('MEG_CODUNI').AsString;
      dtsGen.ParamByName('PRODUT').AsString := dtsCadTin.FieldByName('MEG_PRODUT').AsString;
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

function TFormulaImobiliariaMegaTintas.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaMegaTintas.GetTextoInformativoCalculo: String;
begin
  Result :=
    'Valor da Base = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) + sLineBreak +
    'Valor do Colorante = (Quantidade * 0.154) * (Preço / Embalagem) ' + sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaMegaTintas.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('MEG_CODUNI').AsString;
end;

procedure TFormulaImobiliariaMegaTintas.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('MEG_ACRMOB').AsFloat;
end;

end.
