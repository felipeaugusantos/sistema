{***********************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula AlterPlus *}
{********************************************************************PH*}
unit untFormulaImobiliariaAlterPlus;

interface

uses
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet, untColorante,
  SysUtils, untStrUtils;

type
  TFormulaImobiliariaAlterPlus = class(TAbstractFormulaImobiliaria)
  Private
    function fTabelaPrecoUnitaria(strTabPre: String; blnUnitario: Boolean): Boolean;
    function fEmpresaProducao(strEmpPrd, strOprFlj: String): Boolean;
    function fRetEmpresa(): String;
    function fEmpresaCd(strEmpCd, strCD_S_N: String): Boolean;
    function fEmpresaFat(strEmpFat, strFatS_N: String): Boolean;
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

{ TFormulaImobiliariaAlterPlus }

procedure TFormulaImobiliariaAlterPlus.CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat
end;

procedure TFormulaImobiliariaAlterPlus.CarregarColorantes;
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

  Else If fTabelaPrecoUnitaria(TAutcomTintaFactory.Get.fCfgSis('PREGER'), BlnCalculaUnitario) Then
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

  GetDataSetColorantes.ParamByName('CODEMP').AsString := fRetEmpresa;

  GetDataSetColorantes.Open;
end;

function TFormulaImobiliariaAlterPlus.fEmpresaCd(strEmpCd,
  strCD_S_N: String): Boolean;
begin
  Result := False;

  If Not (TStrUtils.fEmptyStr(strEmpCd)) Then
  Begin
    If strCD_S_N = 'S' Then
    Begin
      Result := True;
      Exit;
    End;
  End;
end;

function TFormulaImobiliariaAlterPlus.fEmpresaFat(strEmpFat,
  strFatS_N: String): Boolean;
begin
  Result := False;

  If Not (TStrUtils.fEmptyStr(strEmpFat)) Then
  Begin
    If strFatS_N = 'S' Then
    Begin
      Result := True;
      Exit;
    End;
  End;
end;

function TFormulaImobiliariaAlterPlus.fEmpresaProducao(strEmpPrd,
  strOprFlj: String): Boolean;
begin
  Result := False;

  If Not (TStrUtils.fEmptyStr(strEmpPrd)) Then
  Begin
    If strOprFlj = 'S' Then
    Begin
      Result := True;
      Exit;
    End;
  End;
end;

function TFormulaImobiliariaAlterPlus.fRetEmpresa: String;
begin
  If fEmpresaProducao(Self.EmpPrd, Self.OprFlj) Then
    Result := Self.EmpPrd
  Else If fEmpresaCd(Self.EmpCd_, Self.Cd_S_N) Then
    Result := Self.EmpCd_
  Else If fEmpresaFat(Self.EmpFat, Self.FatS_N) Then
    Result := Self.EmpFat
  Else
    Result := TAutcomTintaFactory.Get.GetCodEmp;
end;

function TFormulaImobiliariaAlterPlus.fTabelaPrecoUnitaria(strTabPre: String;
  blnUnitario: Boolean): Boolean;
begin
  Result := False;

  If strTabPre = '1' Then
  Begin
    If BlnCalculaUnitario Then
    Begin
      Result := True;
      Exit;
    End;
  End;
end;

function TFormulaImobiliariaAlterPlus.GetCalculadorInterno: ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaAlterPlus.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := '';

  if Assigned(dtsCadTin.FindField('ALP_MD5KEY')) then
    Result := dtsCadTin.FieldByName('ALP_MD5KEY').AsString;

end;

function TFormulaImobiliariaAlterPlus.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('ALP_DESCRI').AsString;
end;

function TFormulaImobiliariaAlterPlus.GetFatorEstoque: Double;
begin
  Result := 0.154;
end;

function TFormulaImobiliariaAlterPlus.GetIdePro: String;
begin
  Result := 'ALP';
end;

function TFormulaImobiliariaAlterPlus.GetItemBaseOriginal(const strIteTin: String): String;
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
        '   ALP_CADBAS B                        ' +
        '   INNER JOIN ALP_CADALP S             ' +
        '      ON B.BAS_CODBAS = S.ALP_CODBAS   ' +
        '     AND B.BAS_CODUNI = S.ALP_CODUNI   ' +
        '     AND B.BAS_DESCRI = S.ALP_PRODUT   ' +
        ' WHERE S.ALP_MD5KEY = :ITETIN          ';
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

function TFormulaImobiliariaAlterPlus.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaAlterPlus.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaAlterPlus.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaAlterPlus.GetNomeTabelaBase: String;
begin
  Result := 'ALP_CADBAS';
end;

function TFormulaImobiliariaAlterPlus.GetNomeCampoColDesCol: string;
begin
  Result := 'COL_DESCRI';
end;

function TFormulaImobiliariaAlterPlus.GetNomeTabelaColorantes: String;
begin
  Result := 'ALP_CADCOL';
end;

function TFormulaImobiliariaAlterPlus.GetPrefixoFormulacao: String;
begin
  Result := 'ALP_FORM';
end;

function TFormulaImobiliariaAlterPlus.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'ALP_QTDC';
end;

function TFormulaImobiliariaAlterPlus.GetProdutoBaseFormula(const dtsCadTin: IDataSet): String;
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
        '   ALP_CADBAS               ' +
        ' WHERE BAS_CODBAS = :CODBAS ' +
        '   AND BAS_CODUNI = :CODUNI ' +
        '   AND BAS_PRODUT = :PRODUT ' ;

      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('ALP_CODBAS').AsString;
      dtsGen.ParamByName('CODUNI').AsString := dtsCadTin.FieldByName('ALP_CODUNI').AsString;
      dtsGen.ParamByName('PRODUT').AsString := dtsCadTin.FieldByName('ALP_PRODUT').AsString;
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

function TFormulaImobiliariaAlterPlus.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaAlterPlus.GetTextoInformativoCalculo: String;
begin
  Result :=
    'Valor da Base = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) + sLineBreak +
    'Valor do Colorante = (Quantidade * 0.154) * (Preço / Embalagem) ' + sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaAlterPlus.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('ALP_CODUNI').AsString;
end;

procedure TFormulaImobiliariaAlterPlus.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('ALP_ACRMOB').AsFloat;
end;

end.
