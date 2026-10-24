{********************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula Iquine *}
{*****************************************************************************AC*}
unit untFormulaImobiliariaIquine;

interface

uses
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet, untColorante,
  SysUtils, untStrUtils, untFloatUtils, Classes;

type
  TFormulaImobiliariaIquine = class(TAbstractFormulaImobiliaria)
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
    procedure CarregaPrecosColorantes; Override;
    procedure PreencheAcrescimoMaoObra(const dtsCadTin: IDataSet); Override;
  end;

implementation

uses
  untAbstractCalculadorFormulaImobiliaria, untAutcomTintaFactory,
  untMultiSelectLocalizadorFactory;

{ TFormulaImobiliariaIquine }

procedure TFormulaImobiliariaIquine.CarregaPrecosColorantes;
var
  intContador: Integer;
  colorante: TColorante;
  fltPreCus: Double;
  fltPreVen: Double;
  fltDesOpeTinta: Double;
  blnEmPromo: Boolean;
  blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
begin
  fltDesOpeTinta := TAutcomTintaFactory.Get().fGetConfTinta('IQU').fGetDouble('DESOPE');

  For intContador := 0 To Self.Count - 1 Do
  Begin
    Colorante := TColorante(Self.Items[intContador]);
    GetDataSetColorantes.Locate('COL_CODCOL', colorante.CodigoColorante, []);
    Colorante.DescricaoColorante := GetDataSetColorantes.FieldByName('COL_DESCRI').AsString;
    Colorante.OutrosValores := GetDataSetColorantes.FieldByName('ITE_OUTVAL').AsFloat;
    Colorante.CodIte := GetDataSetColorantes.FieldByName('COL_CODITE').AsString;
    Colorante.ImpDir := GetDataSetColorantes.FieldByName('ITE_IMPDIR').AsString;

    If TAutcomTintaFactory.Get.fCfgSis('IMPCF4', varBoolean) And Assigned(calculadorFatVendas) Then
      Colorante.IcmsSaida := calculadorFatVendas.fCalculaAliquota(colorante.CodIte, colorante.ImpDir)
    Else
      Colorante.IcmsSaida := GetDataSetColorantes.FieldByName('ITE_ICMSAI').AsFloat;

    Colorante.ImpostosFederais := GetDataSetColorantes.FieldByName('ITE_IMPFED').AsFloat;
    Colorante.DespesasOperacionais := GetDataSetColorantes.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;

    Colorante.PrecoMedio := GetDataSetColorantes.FieldByName('ITE_PREMED').AsFloat;
    Colorante.UltimoPrecoCompra := GetDataSetColorantes.FieldByName('ITE_PREULT').AsFloat;
    Colorante.UltimoPrecoCompraImpostos := GetDataSetColorantes.FieldByName('ITE_IMPULT').AsFloat;
    Colorante.PrecoCompraLiquido := TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fCalculaPrecoCompraLiq(
                                                              GetDataSetColorantes.FieldByName('ITE_PRECOM').AsFloat,
                                                              GetDataSetColorantes.FieldByName('ITE_DESF01').AsFloat,
                                                              GetDataSetColorantes.FieldByName('ITE_DESF02').AsFloat,
                                                              GetDataSetColorantes.FieldByName('ITE_DESF03').AsFloat,
                                                              GetDataSetColorantes.FieldByName('ITE_DESF04').AsFloat,
                                                              GetDataSetColorantes.FieldByName('ITE_DESF05').AsFloat,
                                                              GetDataSetColorantes.FieldByName('ITE_DESF06').AsFloat),
                                                              TAutcomTintaFactory.Get.fCfgSis('DECUNI', VarInteger));

    blnEmPromo := TAutcomTintaFactory.Get.fCarregaPromocao(GetDataSetColorantes.FieldByName('COL_CODITE').AsString, strTabPre,
                                                           Self.strCodCli, Self.strCodCnd, Self.intPrzMed, fltPreCus, fltPreVen, blnPrecoFixoParaTintaDeMaquinaImobiliaria);

    If (blnEmPromo) And (Not Self.blnProPre) And (TAutcomTintaFactory.Get.fCfgSis('COLPRO') = '2') Then
    Begin
      Colorante.PrecoCusto := fltPreCus;

      If TAutcomTintaFactory.Get.fGetConfTinta('IQU').fGet('ZERCOL') = 'S' Then
        Colorante.PrecoVenda := 0
      Else
        Colorante.PrecoVenda := fltPreVen;

      If strTabPre = strTabPreTin Then
        Self.Promoc := 'S';

      If Colorante.PrecoCusto = 0 Then
        Colorante.PrecoCusto := GetDataSetColorantes.FieldByName('ITE_PRECUS').AsFloat;
    End
    Else
    Begin
      Colorante.PrecoCusto := GetDataSetColorantes.FieldByName('ITE_PRECUS').AsFloat;

      If TAutcomTintaFactory.Get.fGetConfTinta('IQU').fGet('ZERCOL') = 'S' Then
        Colorante.PrecoVenda := 0
      Else
        Colorante.PrecoVenda := GetDataSetColorantes.FieldByName('ITE_PREVEN').AsFloat;

      If (Self.blnProPre) And (blnEmPromo) And (strTabPre = strTabPreTin) Then
        Self.Promoc := 'S';
    End;
    CarregaPrecosColorantesAdicional(GetDataSetColorantes, Colorante);
  End;

  TextoInformativoCalculo.Text := GetTextoInformativoCalculo;
end;

procedure TFormulaImobiliariaIquine.CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat; //946;
end;

procedure TFormulaImobiliariaIquine.CarregarColorantes;
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

function TFormulaImobiliariaIquine.GetCalculadorInterno: ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaIquine.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('IQU_MD5KEY').AsString
end;

function TFormulaImobiliariaIquine.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('IQU_DESCRI').AsString;
end;

function TFormulaImobiliariaIquine.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaImobiliariaIquine.GetIdePro: String;
begin
  Result := 'IQU';
end;

function TFormulaImobiliariaIquine.GetItemBaseOriginal(const strIteTin: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      If TMultiSelectLocalizadorFactory.GetLocalizador('IQUBAS')
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

function TFormulaImobiliariaIquine.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaIquine.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaIquine.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaIquine.GetNomeTabelaBase: String;
begin
  Result := 'IQU_CADBAS';
end;

function TFormulaImobiliariaIquine.GetNomeCampoColDesCol: string;
begin
  Result := '';
end;

function TFormulaImobiliariaIquine.GetNomeTabelaColorantes: String;
begin
  Result := 'IQU_CADCOL';
end;

function TFormulaImobiliariaIquine.GetPrefixoFormulacao: String;
begin
  Result := 'IQU_FORM';
end;

function TFormulaImobiliariaIquine.GetPrefixoQuantidade(const strModo: String): String;
begin
  Result := 'IQU_QTDC';
end;

function TFormulaImobiliariaIquine.GetProdutoBaseFormula(const dtsCadTin: IDataSet): String;
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
        '   IQU_CADBAS               ' +
        ' WHERE BAS_BASE__ = :CODBAS ' +
        '   AND BAS_UNIDAD = :CODUNI ' +
        '   AND BAS_PRODUT = :DESCRI ' +
        '   AND BAS_EMBALA = :EMBALA ';

      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('IQU_CODBAS').AsString;
      dtsGen.ParamByName('CODUNI').AsString := dtsCadTin.FieldByName('IQU_UNIDAD').AsString;
      dtsGen.ParamByName('DESCRI').AsString := dtsCadTin.FieldByName('IQU_PRODUT').AsString;
      dtsGen.ParamByName('EMBALA').AsFloat := dtsCadTin.FieldByName('IQU_EMBALA').AsFloat;
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

function TFormulaImobiliariaIquine.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaIquine.GetTextoInformativoCalculo: String;
begin
  Result :=
    'Valor da Base = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) + sLineBreak +
    'Valor do Colorante = Quantidade * Preço / 800 ' + sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaIquine.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('IQU_UNIDAD').AsString;
end;

procedure TFormulaImobiliariaIquine.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('IQU_ACRMOB').AsFloat;
end;

end.
