{********************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula Futura *}
{*****************************************************************************AC*}
unit untFormulaImobiliariaFutura;

interface

uses
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet, untColorante,
  SysUtils, untStrUtils;

type
  TFormulaImobiliariaFutura = class(TAbstractFormulaImobiliaria)
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
    function GetDataSetMensAlerta(const dtsCadTin: IDataSet): IDataSet; Override;
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
    procedure PreencheAcrescimoMaoObra(const dtsCadTin: IDataSet); Override;
    procedure CarregarColorantes; Override;
  end;

implementation

uses
  untAbstractCalculadorFormulaImobiliaria, untAutcomTintaFactory;

{ TFormulaImobiliariaFutura }

procedure TFormulaImobiliariaFutura.CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

procedure TFormulaImobiliariaFutura.CarregarColorantes;
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

function TFormulaImobiliariaFutura.GetCalculadorInterno: ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaFutura.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('FUT_MD5KEY').AsString
end;

function TFormulaImobiliariaFutura.GetDataSetMensAlerta(
  const dtsCadTin: IDataSet): IDataSet;
Var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + '  SELECT                        ';
  strSQL := strSQL + '    FUT_MENSAG  AS MSG_MENSAG   ';
  strSQL := strSQL + '  FROM FUT_CADFUT               ';
  strSQL := strSQL + '  WHERE FUT_MD5KEY = :MD5KEY    ';


  Result := TAutcomTintaFactory.Get.fGetDataSet;
  Result.Close;
  Result.SQL := strSQL;
  Result.ParamByName('MD5KEY').AsString := dtsCadTin.FieldByName('FUT_MD5KEY').AsString;
  Result.Open;

  If TStrUtils.fEmptyStr(Result.FieldByName('MSG_MENSAG').AsString) Then
  Begin
    Result := Nil;
    Exit;
  End;
end;

function TFormulaImobiliariaFutura.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('FUT_DESCRI').AsString;
end;

function TFormulaImobiliariaFutura.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaImobiliariaFutura.GetIdePro: String;
begin
  Result := 'FUT';
end;

function TFormulaImobiliariaFutura.GetItemBaseOriginal(const strIteTin: String): String;
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
        '   FUT_CADBAS B                     ' +
        '   INNER JOIN FUT_CADFUT S          ' +
        '      ON B.BAS_CODBAS = S.FUT_CODBAS   ' +
        '     AND B.BAS_CODUNI = S.FUT_UNIDAD   ' +
        '     AND B.BAS_PRODUT = S.FUT_PRODUT   ' +
        '   WHERE S.FUT_MD5KEY = :ITETIN        ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      If qryGen.IsEmpty then
      Begin
        qryGen.Close;
        qryGen.SQL :=
          ' SELECT                                ' +
          '   B.BAS_CODITE AS CODITE              ' +
          ' FROM                                  ' +
          '   FUT_CADBAS B                        ' +
          '   INNER JOIN FUT_CADFUT S             ' +
          '      ON B.BAS_CODBAS = S.FUT_CODBAS   ' +
          '     AND B.BAS_CODUNI = S.FUT_UNIDAD   ' +
          '     AND B.BAS_PRODUT = S.FUT_PRODUT   ' +
          ' WHERE CONCAT(                         ' +
          '       IFNULL(S.FUT_REFERE, "")        ' +
          '     , IFNULL(S.FUT_UNIDAD, "")        ' +
          '     , IFNULL(S.FUT_PRODUT, "")        ' +
          '     , IFNULL(S.FUT_SPRODU, "")        ' +
          '     , IFNULL(S.FUT_CODBAS, "")        ' +
          '   ) = :ITETIN                         ';
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

function TFormulaImobiliariaFutura.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaFutura.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaFutura.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaFutura.GetNomeTabelaBase: String;
begin
  Result := 'FUT_CADBAS';
end;

function TFormulaImobiliariaFutura.GetNomeCampoColDesCol: string;
begin
  Result := '';
end;

function TFormulaImobiliariaFutura.GetNomeTabelaColorantes: String;
begin
  Result := 'FUT_CADCOL';
end;

function TFormulaImobiliariaFutura.GetPrefixoFormulacao: String;
begin
  Result := 'FUT_FORM';
end;

function TFormulaImobiliariaFutura.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'FUT_QTDB';
end;

function TFormulaImobiliariaFutura.GetProdutoBaseFormula(const dtsCadTin: IDataSet): String;
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
        '   FUT_CADBAS               ' +
        ' WHERE BAS_CODBAS = :CODBAS ' +
        '   AND BAS_CODUNI = :CODUNI ' +
        '   AND BAS_PRODUT = :PRODUT ' ;

      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('FUT_CODBAS').AsString;
      dtsGen.ParamByName('CODUNI').AsString := dtsCadTin.FieldByName('FUT_UNIDAD').AsString;
      dtsGen.ParamByName('PRODUT').AsString := dtsCadTin.FieldByName('FUT_PRODUT').AsString;
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

function TFormulaImobiliariaFutura.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaFutura.GetTextoInformativoCalculo: String;
begin
  Result :=
    'Valor da Base = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) + sLineBreak +
    'Valor do Colorante = (Quantidade) * (Preço / Embalagem) ' + sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaFutura.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('FUT_UNIDAD').AsString;
end;

procedure TFormulaImobiliariaFutura.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('FUT_ACRMOB').AsFloat;
end;

end.
