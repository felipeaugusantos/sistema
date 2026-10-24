{********************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula Sayerlack *}
{*****************************************************************************AC*}
unit untFormulaImobiliariaSayerlack;

interface

uses
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet, untColorante,
  SysUtils, untStrUtils;

type
  TFormulaImobiliariaSayerlack = class(TAbstractFormulaImobiliaria)
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

{ TFormulaImobiliariaSayerlack }

procedure TFormulaImobiliariaSayerlack.CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

procedure TFormulaImobiliariaSayerlack.CarregarColorantes;
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

function TFormulaImobiliariaSayerlack.GetCalculadorInterno: ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaSayerlack.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('SAY_MD5KEY').AsString
end;

function TFormulaImobiliariaSayerlack.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('SAY_PRODUT').AsString;
end;

function TFormulaImobiliariaSayerlack.GetFatorEstoque: Double;
begin
  Result := 0.077015625;
end;

function TFormulaImobiliariaSayerlack.GetIdePro: String;
begin
  Result := 'SAY';
end;

function TFormulaImobiliariaSayerlack.GetItemBaseOriginal(const strIteTin: String): String;
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
        '   SAY_CADBAS B                     '    +
        '   INNER JOIN SAY_CADSAY S          '    +
        '      ON B.BAS_CODBAS = S.SAY_CODBAS   ' +
        '     AND B.BAS_PRODUT = S.SAY_PRODUT   ' +
        '     AND B.BAS_DESEMB = S.SAY_DESEMB   ' +
        '   WHERE S.SAY_MD5KEY = :ITETIN        ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      If qryGen.IsEmpty Then
      Begin
        qryGen.SQL :=
        ' SELECT                              ' +
        '   B.BAS_CODITE AS CODITE            ' +
        ' FROM                                ' +
        '   SAY_CADSAY C                   ' +
        '   INNER JOIN SAY_CADBAS B        ' +
        '     ON C.SAY_CODBAS = B.BAS_CODBAS  ' +
        '     AND C.SAY_PRODUT = B.BAS_PRODUT ' +
        '     AND C.SAY_DESEMB = B.BAS_DESEMB ' +
        ' WHERE CONCAT(                       ' +
        '     IFNULL(C.SAY_BASE__, '''')  ,     ' +
        '     IFNULL(C.SAY_CODBAS, '''')  ,     ' +
        '     IFNULL(C.SAY_PRODUT, '''')  ,     ' +
        '     IFNULL(C.SAY_CODIGO, '''')  ,     ' +
        '     IFNULL(C.SAY_DESEMB, '''')        ' +
        '   ) = :ITETIN                       ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;
      End;

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

function TFormulaImobiliariaSayerlack.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaSayerlack.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaSayerlack.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaSayerlack.GetNomeTabelaBase: String;
begin
  Result := 'SAY_CADBAS';
end;

function TFormulaImobiliariaSayerlack.GetNomeCampoColDesCol: string;
begin
  Result := 'COL_DESCRI';
end;

function TFormulaImobiliariaSayerlack.GetNomeTabelaColorantes: String;
begin
  Result := 'SAY_CADCOL';
end;

function TFormulaImobiliariaSayerlack.GetPrefixoFormulacao: String;
begin
  Result := 'SAY_FORM';
end;

function TFormulaImobiliariaSayerlack.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'SAY_QTDC';
end;

function TFormulaImobiliariaSayerlack.GetProdutoBaseFormula(const dtsCadTin: IDataSet): String;
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
        '   SAY_CADBAS               ' +
        ' WHERE BAS_CODBAS = :CODBAS ' +
        '   AND BAS_DESEMB = :DESEMB ' +
        '   AND BAS_PRODUT = :PRODUT ' ;

      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('SAY_CODBAS').AsString;
      dtsGen.ParamByName('DESEMB').AsString := dtsCadTin.FieldByName('SAY_DESEMB').AsString;
      dtsGen.ParamByName('PRODUT').AsString := dtsCadTin.FieldByName('SAY_PRODUT').AsString;
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

function TFormulaImobiliariaSayerlack.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaSayerlack.GetTextoInformativoCalculo: String;
begin
  Result :=
    'Valor da Base = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) + sLineBreak +
    'Valor do Colorante = (Quantidade/384) * 0,029574 * Preço ' + sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaSayerlack.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('SAY_DESEMB').AsString;
end;

procedure TFormulaImobiliariaSayerlack.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('SAY_ACRMOB').AsFloat;
end;

end.
