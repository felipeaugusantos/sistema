{************************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula Alessi Imobiliaria   *}
{*********************************************************************************AC*}
unit untFormulaImobiliariaAlessiImobiliaria;

interface

uses
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet, untColorante,
  SysUtils, untITintaDeMaquinaComponente, untStrUtils;

type
  TFormulaImobiliariaAlessiImobiliaria = class(TAbstractFormulaImobiliaria)
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
    function GetQuantidadeDadosTintometricos(const dtsCadTin: IDataSet;
      strPrefixoQuantidade: String; strCont: String): Double; override;
    function OncaParaMl(intParteInteira: Integer; fltParteFracao: Double): Double; override;
    function fMostraQuantidadeEmOnca(Var strOnca: String;
      const fltQtdCol: Double): Boolean; override;
    procedure PreencheAcrescimoMaoObra(const dtsCadTin: IDataSet); Override;
    procedure CarregarColorantes; Override;
  end;

implementation

uses
  untAbstractCalculadorFormulaImobiliaria, untAutcomTintaFactory, untMultiSelectLocalizadorFactory;

{ TFormulaImobiliariaAlessiImobiliaria }

procedure TFormulaImobiliariaAlessiImobiliaria.CarregaPrecosColorantesAdicional(
  const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

procedure TFormulaImobiliariaAlessiImobiliaria.CarregarColorantes;
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

function TFormulaImobiliariaAlessiImobiliaria.fMostraQuantidadeEmOnca(
  var strOnca: String; const fltQtdCol: Double): Boolean;
var
  fltInteiroOnca: Integer;
  fltFracaoOnca: Double;
begin
  Result := True;

  MlParaOnca(fltQtdCol, fltInteiroOnca, fltFracaoOnca);
  strOnca := Format('%dY%.2f', [Trunc(fltInteiroOnca), fltFracaoOnca]);
end;

function TFormulaImobiliariaAlessiImobiliaria.GetCalculadorInterno: ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaAlessiImobiliaria.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('ALE_MD5KEY').AsString
end;

function TFormulaImobiliariaAlessiImobiliaria.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('ALE_PRODUT').AsString + ' ' +
            dtsCadTin.FieldByName('ALE_BASE__').AsString + ' ' +
            dtsCadTin.FieldByName('EMB_CODUNI').AsString;
end;

function TFormulaImobiliariaAlessiImobiliaria.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaImobiliariaAlessiImobiliaria.GetIdePro: String;
begin
  Result := 'ALE';
end;

function TFormulaImobiliariaAlessiImobiliaria.GetItemBaseOriginal(const strIteTin: String): String;
var
  qryGen: IDataSet;
begin
  Result := '';
  Try
    Try
      If TMultiSelectLocalizadorFactory.GetLocalizador('ALEBAS').Localizar(qryGen, ['ITETIN'], [strIteTin]) Then
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

function TFormulaImobiliariaAlessiImobiliaria.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaAlessiImobiliaria.GetNomeCampoColDesCol: string;
begin
  Result := '';
end;

function TFormulaImobiliariaAlessiImobiliaria.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaAlessiImobiliaria.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaAlessiImobiliaria.GetNomeTabelaBase: String;
begin
  Result := 'ALE_CADBAS';
end;

function TFormulaImobiliariaAlessiImobiliaria.GetNomeTabelaColorantes: String;
begin
  Result := 'ALE_CADCOL';
end;

function TFormulaImobiliariaAlessiImobiliaria.GetPrefixoFormulacao: String;
begin
  Result := 'ALE_CODC';
end;

function TFormulaImobiliariaAlessiImobiliaria.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := '';
end;

function TFormulaImobiliariaAlessiImobiliaria.GetProdutoBaseFormula(const dtsCadTin: IDataSet): String;
var
  dtsGen: IDataSet;
begin
  Try
    Try
      dtsGen := TAutcomTintaFactory.Get.fGetDataSet;
      dtsGen.SQL :=
        ' SELECT                       ' +
        '   BAS_CODITE                 ' +
        ' FROM                         ' +
        '   ALE_CADBAS                 ' +
        ' WHERE BAS_PRODUT = :PRODUT   ' +
        '   AND BAS_BASE__ = :BASE     ' +
        '   AND BAS_EMBALA = :EMBALA   ';

      dtsGen.ParamByName('PRODUT').AsString := dtsCadTin.FieldByName('ALE_PRODUT').AsString;
      dtsGen.ParamByName('BASE').AsString   := dtsCadTin.FieldByName('ALE_BASE__').AsString;
      dtsGen.ParamByName('EMBALA').AsString := dtsCadTin.FieldByName('ALE_EMBALA').AsString;
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

function TFormulaImobiliariaAlessiImobiliaria.GetQuantidadeDadosTintometricos(
  const dtsCadTin: IDataSet; strPrefixoQuantidade: String;
  strCont: String): Double;
begin
  Result := OncaParaMl(dtsCadTin.FieldByName('ALE_QTOZ' + strCont).AsInteger,
                       dtsCadTin.FieldByName('ALE_QSHO' + strCont).AsFloat);
end;

function TFormulaImobiliariaAlessiImobiliaria.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaAlessiImobiliaria.GetTextoInformativoCalculo: String;
begin
  Result :=
    'Valor da Base      = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) + sLineBreak +
    'Quantidade em ML   = (Parte Inteira * 29.5735295625) + (Parte Fração * 0.61611520)' + sLineBreak +
    'Valor do Colorante = (Quantidade) * (Preço / Embalagem) ' + sLineBreak +
    'Valor da Tinta     = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaAlessiImobiliaria.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('EMB_CODUNI').AsString;
end;

function TFormulaImobiliariaAlessiImobiliaria.OncaParaMl(
  intParteInteira: Integer; fltParteFracao: Double): Double;
begin
  Result := (intParteInteira * 29.574) + (fltParteFracao * 0.616125);
end;

procedure TFormulaImobiliariaAlessiImobiliaria.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('ALE_ACRMOB').AsFloat;
end;

end.
