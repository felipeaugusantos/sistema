{***********************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula Falcao *}
{********************************************************************PH*}
unit untFormulaImobiliariaFalcao;

interface

uses
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet, untColorante,
  SysUtils, untStrUtils;

type
  TFormulaImobiliariaFalcao = class(TAbstractFormulaImobiliaria)
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

{ TFormulaImobiliariaFalcao }

procedure TFormulaImobiliariaFalcao.CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

procedure TFormulaImobiliariaFalcao.CarregarColorantes;
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

function TFormulaImobiliariaFalcao.GetCalculadorInterno: ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaFalcao.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := '';

  if Assigned(dtsCadTin.FindField('FAL_MD5KEY')) then
    Result := dtsCadTin.FieldByName('FAL_MD5KEY').AsString;

end;

function TFormulaImobiliariaFalcao.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('FAL_DESCRI').AsString;
end;

function TFormulaImobiliariaFalcao.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaImobiliariaFalcao.GetIdePro: String;
begin
  Result := 'FAL';
end;

function TFormulaImobiliariaFalcao.GetItemBaseOriginal(const strIteTin: String): String;
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
        '   FAL_CADBAS B                        ' +
        '   INNER JOIN FAL_CADFAL S             ' +
        '      ON B.BAS_DESCRI = S.FAL_BASE__   ' +
        '     AND B.BAS_CODUNI = S.FAL_CODUNI   ' +
        '     AND B.BAS_LINHA_ = S.FAL_LINHA_   ' +
        ' WHERE S.FAL_MD5KEY = :ITETIN          ';
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

function TFormulaImobiliariaFalcao.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaFalcao.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaFalcao.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaFalcao.GetNomeTabelaBase: String;
begin
  Result := 'FAL_CADBAS';
end;

function TFormulaImobiliariaFalcao.GetNomeCampoColDesCol: string;
begin
  Result := '';
end;

function TFormulaImobiliariaFalcao.GetNomeTabelaColorantes: String;
begin
  Result := 'FAL_CADCOL';
end;

function TFormulaImobiliariaFalcao.GetPrefixoFormulacao: String;
begin
  Result := 'FAL_FORM';
end;

function TFormulaImobiliariaFalcao.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'FAL_QTDC';
end;

function TFormulaImobiliariaFalcao.GetProdutoBaseFormula(const dtsCadTin: IDataSet): String;
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
        '   FAL_CADBAS               ' +
        ' WHERE BAS_DESCRI = :CODBAS ' +
        '   AND BAS_CODUNI = :CODUNI ' +
        '   AND BAS_LINHA_ = :LINHA_' ;

      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('FAL_BASE__').AsString;
      dtsGen.ParamByName('CODUNI').AsString := dtsCadTin.FieldByName('FAL_CODUNI').AsString;
      dtsGen.ParamByName('LINHA_').AsString := dtsCadTin.FieldByName('FAL_LINHA_').AsString;
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

function TFormulaImobiliariaFalcao.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaFalcao.GetTextoInformativoCalculo: String;
begin
  Result :=
    'Valor da Base = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) + sLineBreak +
    'Valor do Colorante = (Quantidade * Preço / Embalagem) ' + sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaFalcao.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('FAL_CODUNI').AsString;
end;

procedure TFormulaImobiliariaFalcao.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('FAL_ACRMOB').AsFloat;
end;

end.
