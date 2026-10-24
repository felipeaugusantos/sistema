{************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula Dacar    *}
{*********************************************************************AC*}
unit untFormulaImobiliariaDacar;

interface

uses
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet, untColorante,
  SysUtils, untITintaDeMaquinaComponente;

type
  TFormulaImobiliariaDacar = class(TAbstractFormulaImobiliaria)
  protected
    function GetCalculadorInterno(): ICalculadorFormulaImobiliaria; override;
    function GetNomeTabelaColorantes(): String; override;
    function GetTextoInformativoCalculo(): String; override;
    procedure CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet;
      const colorante: TColorante); override;
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
  untAbstractCalculadorFormulaImobiliaria, untAutcomTintaFactory, untMultiSelectLocalizadorFactory;

{ TFormulaImobiliariaDacar }

procedure TFormulaImobiliariaDacar.CarregaPrecosColorantesAdicional(
  const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('DAC_EMBALA').AsFloat;;
end;

procedure TFormulaImobiliariaDacar.CarregarColorantes;
var
  strSql: String;
begin
  strSql := ' SELECT ' +
    '     COL_CODCOL ' +
    '   , COL_CODITE ' +
    '   , DAC_EMBALA ' ;

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
  GetDataSetColorantes.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  GetDataSetColorantes.Open;
end;

function TFormulaImobiliariaDacar.GetCalculadorInterno: ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaDacar.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('DAC_MD5KEY').AsString
end;

function TFormulaImobiliariaDacar.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('DAC_DESCRI').AsString;
end;

function TFormulaImobiliariaDacar.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaImobiliariaDacar.GetIdePro: String;
begin
  Result := 'DAC';
end;

function TFormulaImobiliariaDacar.GetItemBaseOriginal(const strIteTin: String): String;
var
  qryGen: IDataSet;
begin
  Result := '';
  Try
    Try
      If TMultiSelectLocalizadorFactory.GetLocalizador('DACBAS').Localizar(qryGen, ['ITETIN'], [strIteTin]) Then
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

function TFormulaImobiliariaDacar.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaDacar.GetNomeCampoColDesCol: string;
begin
  Result := '';
end;

function TFormulaImobiliariaDacar.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaDacar.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaDacar.GetNomeTabelaBase: String;
begin
  Result := 'DAC_CADBAS';
end;

function TFormulaImobiliariaDacar.GetNomeTabelaColorantes: String;
begin
  Result := 'DAC_CADCOL';
end;

function TFormulaImobiliariaDacar.GetPrefixoFormulacao: String;
begin
  Result := 'DAC_FORM';
end;

function TFormulaImobiliariaDacar.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'DAC_QTDB';
end;

function TFormulaImobiliariaDacar.GetProdutoBaseFormula(const dtsCadTin: IDataSet): String;
var
  dtsGen: IDataSet;
begin
  Try
    Try
      dtsGen := TAutcomTintaFactory.Get.fGetDataSet;
      dtsGen.SQL :=
        ' SELECT         ' +
        '	   BAS_CODITE  ' +
        '   FROM         ' +
        '	   DAC_CADBAS  ' +
        '  INNER JOIN DAC_UNIDAC ' +
        '	   ON (DAC_CADBAS.BAS_UNIDAD = DAC_UNIDAC.DAC_UNIAUT) ' +
        '  WHERE ' +
        '    BAS_CODFML = :CODFML AND ' +
        '	   BAS_BASE__ = :CODBAS AND ' +
        '	   DAC_UNIAUT = :CODUNI     ';

      dtsGen.ParamByName('CODFML').AsString := dtsCadTin.FieldByName('DAC_CODFML').AsString;
      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('DAC_CODBAS').AsString;
      dtsGen.ParamByName('CODUNI').AsString := dtsCadTin.FieldByName('DAC_CODUNI').AsString;
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

function TFormulaImobiliariaDacar.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaDacar.GetTextoInformativoCalculo: String;
begin
  Result :=
    'Valor da Base      = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) + sLineBreak +
    'Valor do Colorante = (Quantidade) * (Preço / Embalagem) ' + sLineBreak +
    'Valor da Tinta     = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaDacar.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('DAC_CODUNI').AsString;
end;

procedure TFormulaImobiliariaDacar.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('DAC_ACRMOB').AsFloat;
end;

end.
