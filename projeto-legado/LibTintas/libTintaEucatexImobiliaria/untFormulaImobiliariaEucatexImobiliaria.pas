{************************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula Eucatex Imobiliaria  *}
{******************************************************************************** PH*}
unit untFormulaImobiliariaEucatexImobiliaria;

interface

uses
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet, untColorante,
  SysUtils, untITintaDeMaquinaComponente, untIConfTinta, untStrUtils;

type
  TFormulaImobiliariaEucatexImobiliaria = class(TAbstractFormulaImobiliaria)
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
    function fMostraQuantidadeEmOnca(Var strOnca: String;
      const fltQtdCol: Double): Boolean; override;
    procedure CarregarColorantes; override;
    procedure PreencheAcrescimoMaoObra(const dtsCadTin: IDataSet); Override;
  end;

implementation

uses
  untAutcomTintaFactory, untMultiSelectLocalizadorFactory,
  untAbstractCalculadorFormulaImobiliaria;

{ TFormulaImobiliariaEucatexImobiliaria }

procedure TFormulaImobiliariaEucatexImobiliaria.CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

procedure TFormulaImobiliariaEucatexImobiliaria.CarregarColorantes;
var
  strSql: String;
begin
  strSql := ' SELECT ' +
    '     COL_CODCOL ' +
    '   , COL_CODITE ' +
    '   , COL_EMBALA ';

  if GetNomeCampoColDesCol <> '' then
    strSql := strSql + ' , '+ GetNomeCampoColDesCol
  else
    strSql := strSql + ', "" AS COL_DESCRI ';

  strSql := strSql +
    '   , IFNULL(ITE_ITEATI, "N") ITE_ITEATI      ' +
    '   , ITE_CNV_ML ' +
    '   , ITE_OUTVAL ' +
    '   , ITE_IMPFED ' +
    '   , ITE_DESOPE ' +
    '   , ITE_PREMED ' +
    '   , ITE_IMPULT ' +
    '   , ITE_PREULT ' +
    '   , ITE_ICMSAI ' +
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

function TFormulaImobiliariaEucatexImobiliaria.fMostraQuantidadeEmOnca(
  var strOnca: String; const fltQtdCol: Double): Boolean;
var
  fltInteiroOnca: Double;
  fltFracaoOnca: Double;
begin
  Result := False;

  If (TAutcomTintaFactory.Get.fGetConfTinta('EUC').fGet('EUCMAN') = 'S') Then
  Begin
    Result := True;

    fltInteiroOnca := fltQtdCol;
    fltFracaoOnca  := Frac(fltInteiroOnca) * 48 / 100;
    strOnca        := Format('%dY%.2f', [Trunc(fltInteiroOnca), fltFracaoOnca]);
  End;
end;

function TFormulaImobiliariaEucatexImobiliaria.GetCalculadorInterno: ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaEucatexImobiliaria.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('EUC_MD5KEY').AsString;
end;

function TFormulaImobiliariaEucatexImobiliaria.GetDataSetMensAlerta(
  const dtsCadTin: IDataSet): IDataSet;
Var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + '  SELECT                        ';
  strSQL := strSQL + '    EUC_OBSCOR  AS MSG_MENSAG   ';
  strSQL := strSQL + '  FROM EUC_CADEUC               ';
  strSQL := strSQL + '  WHERE EUC_MD5KEY = :MD5KEY    ';


  Result := TAutcomTintaFactory.Get.fGetDataSet;
  Result.Close;
  Result.SQL := strSQL;
  Result.ParamByName('MD5KEY').AsString := dtsCadTin.FieldByName('EUC_MD5KEY').AsString;
  Result.Open;

  If TStrUtils.fEmptyStr(Result.FieldByName('MSG_MENSAG').AsString) Then
  Begin
    Result := Nil;
    Exit;
  End;
end;

function TFormulaImobiliariaEucatexImobiliaria.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('EUC_PRODUT').AsString + ' ' +
            dtsCadTin.FieldByName('EUC_DESCOR').AsString + ' ' +
            dtsCadTin.FieldByName('EUC_UNIDAD').AsString;
end;

function TFormulaImobiliariaEucatexImobiliaria.GetFatorEstoque: Double;
begin
  Result := (29.5735295625 / 48);
end;

function TFormulaImobiliariaEucatexImobiliaria.GetIdePro: String;
begin
  Result := 'EUC';
end;

function TFormulaImobiliariaEucatexImobiliaria.GetItemBaseOriginal(const strIteTin: String): String;
var
  qryGen: IDataSet;
begin
  Result := '';
  Try
    Try
      If TMultiSelectLocalizadorFactory.GetLocalizador('EUCBAS').Localizar(qryGen, ['ITETIN'], [strIteTin]) Then
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

function TFormulaImobiliariaEucatexImobiliaria.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaEucatexImobiliaria.GetNomeCampoColDesCol: string;
begin
  Result := '';
end;

function TFormulaImobiliariaEucatexImobiliaria.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaEucatexImobiliaria.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaEucatexImobiliaria.GetNomeTabelaBase: String;
begin
  Result := 'EUC_CADBAS';
end;

function TFormulaImobiliariaEucatexImobiliaria.GetNomeTabelaColorantes: String;
begin
  Result := 'EUC_CADCOL';
end;

function TFormulaImobiliariaEucatexImobiliaria.GetPrefixoFormulacao: String;
begin
  Result := 'EUC_FORM';
end;

function TFormulaImobiliariaEucatexImobiliaria.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'EUC_QTDB';
end;

function TFormulaImobiliariaEucatexImobiliaria.GetProdutoBaseFormula(const dtsCadTin: IDataSet): String;
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
        '   EUC_CADBAS               ' +
        ' WHERE                      ' +
        '   BAS_DESCRI = :CODBAS AND ' +
        '   BAS_PRODUT = :PRODUT AND ' +
        '   BAS_CODUNI = :CODUNI AND ' +
        '   BAS_EMBALA = :EMBALA     ';

      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('EUC_DESBAS').AsString;
      dtsGen.ParamByName('PRODUT').AsString := dtsCadTin.FieldByName('EUC_PRODUT').AsString;
      dtsGen.ParamByName('CODUNI').AsString := dtsCadTin.FieldByName('EUC_UNIDAD').AsString;
      dtsGen.ParamByName('EMBALA').AsFloat  := dtsCadTin.FieldByName('EUC_EMBALA').AsFloat;
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

function TFormulaImobiliariaEucatexImobiliaria.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaEucatexImobiliaria.GetTextoInformativoCalculo: String;
begin
  Result :=
    'Valor da Base = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) + sLineBreak;

    If (TAutcomTintaFactory.Get.fGetConfTinta('EUC').fGet('EUCMAN') = 'S') Then
      Result := Result + 'Quantidade em ML = ((Parte Inteira) + ((Parte Fração / 48) * 100)) * (29.5735295625 / 48)' + sLineBreak;

    Result := Result + 'Valor do Colorante = (Quantidade * 0,61611520) * (Preço / Embalagem)' + sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaEucatexImobiliaria.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('EUC_UNIDAD').AsString;
end;

procedure TFormulaImobiliariaEucatexImobiliaria.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('EUC_ACRMOB').AsFloat;
end;

end.
