{ ******************************************************************************** }
{ * Classe responsável pelas rotidas especificas de uma formula AdvanceStr * }
{ *****************************************************************************AC* }
unit untFormulaImobiliariaAdvanceStr;

interface

uses
  {$IFNDEF LINUX}
  Vcl.ComCtrls,
  Forms,
  {$ENDIF}
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet,
  untColorante, SysUtils, Classes, untAbstractFormula, untStrUtils, untCalculadorFormulaImobiliariaAdvanceStr, untICalculadorFormula,
  untISaldosColorantes;

type
  TFormulaImobiliariaAdvanceStr = class(TAbstractFormulaImobiliaria)
  Private
    function fVerificaIMPDIG(): String;
    function fVerificaEmpPrdOprFlj(): Boolean;
    function fEmpresa(): String;
    function fVerificaEmpCd(strEmpCd, strCD_S_N: String): Boolean;
    function fVerificaEmpFat(strEmpFat, strFatS_N: String): Boolean;
    function fVerificaPrecoGeracaoBlnUnitario(): Boolean;
    function fRetornaPesoEspecifico(strColorante: String): Double;
    function fVerificaIcmsSaida(CfgImpCf4: Boolean; CalculadorFatVendas:Boolean): Boolean;
    function fVerificaPromocao(fPromocao: Boolean; blnProPre: Boolean; CfgColPro: Boolean): Boolean;
    function fValorPrecoCusto(fltPreCus: Double): Double;
    function fValorPrecoVenda(fltPreVen: Double): Double;
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
    {$IFNDEF LINUX}
    procedure pAjustaFormulacao(lsvFormulacao: TListView; Form: TForm); Override;
    procedure pAddItemsFormulacao(lsvFormulacao: TListView; Formula: TAbstractFormula); Override;
    {$ENDIF}
    function fAlteraFormulacao(): Boolean; Override;
    procedure CarregaPrecosColorantes; Override;
    function GetSaldos: ISaldosColorantes; Override;
  end;

  implementation

uses
  untAutcomTintaFactory,
  untMultiSelectLocalizadorFactory, untFloatUtils, untGenericSaldosColorantes, Variants;

{ TFormulaImobiliariaAdvanceStr }

procedure TFormulaImobiliariaAdvanceStr.CarregaPrecosColorantes;
var
  intContador: Integer;
  colorante: TColorante;
  fltPreCus: Double;
  fltPreVen: Double;
  fltDesOpeTinta: Double;
  strCodEmpresa: String;
  blnEmPromo: Boolean;
  blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
begin
  fltDesOpeTinta := TAutcomTintaFactory.Get().fGetConfTinta(GetIdePro)
    .fGetDouble('DESOPE');

  strCodEmpresa := fVerificaEmpresaSetada();

  For intContador := 0 To Self.Count - 1 Do
  Begin
    colorante := TColorante(Self.Items[intContador]);
    GetDataSetColorantes.Locate('COL_CODCOL', colorante.CodigoColorante, []);
    colorante.DescricaoColorante := GetDataSetColorantes.FieldByName('COL_DESCRI').AsString;
    colorante.OutrosValores := GetDataSetColorantes.FieldByName('ITE_OUTVAL').AsFloat;

    colorante.CodIte := GetDataSetColorantes.FieldByName('COL_CODITE').AsString;
    colorante.ImpDir := GetDataSetColorantes.FieldByName('ITE_IMPDIR').AsString;

    If fVerificaIcmsSaida(TAutcomTintaFactory.Get.fCfgSis('IMPCF4', varBoolean), Assigned(calculadorFatVendas)) Then
      colorante.IcmsSaida := calculadorFatVendas.fCalculaAliquota(colorante.CodIte, colorante.ImpDir)
    Else
      colorante.IcmsSaida := GetDataSetColorantes.FieldByName('ITE_ICMSAI').AsFloat;

    colorante.ImpostosFederais := GetDataSetColorantes.FieldByName('ITE_IMPFED').AsFloat;
    colorante.DespesasOperacionais := GetDataSetColorantes.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;

    colorante.PrecoMedio := GetDataSetColorantes.FieldByName('ITE_PREMED').AsFloat;
    colorante.UltimoPrecoCompra := GetDataSetColorantes.FieldByName('ITE_PREULT').AsFloat;
    colorante.UltimoPrecoCompraImpostos := GetDataSetColorantes.FieldByName('ITE_IMPULT').AsFloat;
    colorante.PrecoCompraLiquido := TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fCalculaPrecoCompraLiq(
                                                              GetDataSetColorantes.FieldByName('ITE_PRECOM').AsFloat,
                                                              GetDataSetColorantes.FieldByName('ITE_DESF01').AsFloat,
                                                              GetDataSetColorantes.FieldByName('ITE_DESF02').AsFloat,
                                                              GetDataSetColorantes.FieldByName('ITE_DESF03').AsFloat,
                                                              GetDataSetColorantes.FieldByName('ITE_DESF04').AsFloat,
                                                              GetDataSetColorantes.FieldByName('ITE_DESF05').AsFloat,
                                                              GetDataSetColorantes.FieldByName('ITE_DESF06').AsFloat),
                                                              TAutcomTintaFactory.Get.fCfgSis('DECUNI', VarInteger));

    blnEmPromo := TAutcomTintaFactory.Get.fCarregaPromocao(GetDataSetColorantes.FieldByName('COL_CODITE').AsString,
                                                           strTabPre, Self.strCodCli, Self.strCodCnd, Self.intPrzMed,
                                                           fltPreCus, fltPreVen, blnPrecoFixoParaTintaDeMaquinaImobiliaria, strCodEmpresa);

    If fVerificaPromocao(blnEmPromo, Self.blnProPre, (TAutcomTintaFactory.Get.fCfgSis('COLPRO') = '2')) Then
    Begin
      colorante.PrecoCusto := fValorPrecoCusto(fltPreCus);
      colorante.PrecoVenda := fValorPrecoVenda(fltPreVen);

      If strTabPre = strTabPreTin Then
        Self.Promoc := 'S';
    End
    Else
    Begin
      colorante.PrecoCusto := GetDataSetColorantes.FieldByName('ITE_PRECUS').AsFloat;

      If TAutcomTintaFactory.Get.fGetConfTinta(GetIdePro).fGet('ZERCOL') = 'S' Then
        Colorante.PrecoVenda := 0
      Else
        Colorante.PrecoVenda := GetDataSetColorantes.FieldByName('ITE_PREVEN').AsFloat;

      If (Self.blnProPre) And (blnEmPromo) And (strTabPre = strTabPreTin) Then
        Self.Promoc := 'S';
    End;

    CarregaPrecosColorantesAdicional(GetDataSetColorantes, colorante);
  End;

  TextoInformativoCalculo.Text := GetTextoInformativoCalculo;
end;

procedure TFormulaImobiliariaAdvanceStr.CarregaPrecosColorantesAdicional
  (const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat;
  colorante.PesoEspecifico := dataSetColorantes.FieldByName('COL_PESESP').AsFloat;
end;

procedure TFormulaImobiliariaAdvanceStr.CarregarColorantes;
var
  strSql: String;
begin
  strSql := ' SELECT         ' +
            '     COL_CODCOL ' +
            '   , COL_CODITE ' +
            '   , COL_EMBALA ' +
            '   , COL_PESESP ' ;

  strSql := strSql + ' , ' + GetNomeCampoColDesCol;

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

  strSql := strSql + fVerificaIMPDIG;

  If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '0') Then
  begin
    strSql := strSql +
      '   , COL_PRECUS AS ITE_PRECUS ' +
      '   , COL_PREVEN AS ITE_PREVEN ';
  end

  Else If fVerificaPrecoGeracaoBlnUnitario Then
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
  GetDataSetCOlorantes.ParamByName('CODEMP').AsString := fEmpresa;

  GetDataSetColorantes.Open;
end;

function TFormulaImobiliariaAdvanceStr.fAlteraFormulacao: Boolean;
begin
  Result := True;
end;

function TFormulaImobiliariaAdvanceStr.fEmpresa: String;
begin
  If fVerificaEmpPrdOprFlj Then
    Result := Self.EmpPrd
  Else If fVerificaEmpCd(Self.EmpCd_, Self.CD_S_N) Then
    Result := Self.EmpCd_
  Else If fVerificaEmpFat(Self.EmpFat, Self.FatS_N) Then
    Result := Self.EmpFat
  Else
    Result := TAutcomTintaFactory.Get.GetCodEmp
end;


function TFormulaImobiliariaAdvanceStr.fRetornaPesoEspecifico(
  strColorante: String): Double;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT COL_PESESP FROM ADS_CADCOL WHERE COL_CODCOL = :CODCOL  ';
  qryGen.ParamByName('CODCOL').AsString := strColorante;
  qryGen.Open;

  Result := qryGen.FieldByName('COL_PESESP').AsFloat;
end;

function TFormulaImobiliariaAdvanceStr.fValorPrecoCusto(
  fltPreCus: Double): Double;
begin
  If fltPreCus = 0 Then
    Result :=  GetDataSetColorantes.FieldByName('ITE_PRECUS').AsFloat
  Else
    Result := fltPreCus;
end;

function TFormulaImobiliariaAdvanceStr.fValorPrecoVenda(
  fltPreVen: Double): Double;
begin
  If TAutcomTintaFactory.Get.fGetConfTinta(GetIdePro).fGet('ZERCOL') = 'S' Then
    Result := 0
  Else
    Result := fltPreVen;
end;

function TFormulaImobiliariaAdvanceStr.fVerificaEmpCd(strEmpCd,
  strCD_S_N: String): Boolean;
begin
  Result := False;

  If Not (TStrUtils.fEmptyStr(strEmpCd)) Then
  Begin
    If strCD_S_N = 'S' Then
      Result := True;
  End;
end;

function TFormulaImobiliariaAdvanceStr.fVerificaEmpFat(strEmpFat,
  strFatS_N: String): Boolean;
begin
  Result := False;

  If Not (TStrUtils.fEmptyStr(strEmpFat)) Then
  Begin
    If strFatS_N = 'S' Then
      Result := True;
  End;
end;

function TFormulaImobiliariaAdvanceStr.fVerificaEmpPrdOprFlj: Boolean;
begin
  Result := False;

  If Not (TStrUtils.fEmptyStr(Self.EmpPrd)) Then
  Begin
    If Self.OprFlj = 'S' Then
      Result := True;
  End;
end;

function TFormulaImobiliariaAdvanceStr.fVerificaIcmsSaida(CfgImpCf4,
  CalculadorFatVendas: Boolean): Boolean;
begin
  Result := False;

  If CfgImpCf4 Then
  Begin
    If CalculadorFatVendas Then
    Begin
      Result := True;
      Exit;
    End;
  End;
end;

function TFormulaImobiliariaAdvanceStr.fVerificaIMPDIG: String;
begin
  If TAutcomTintaFactory.Get.fCfgSis('IMPDIG') = '1' Then
    Result := '   , I.ITE_IMPDIR  '
  Else
    Result := '   , G.ITE_IMPDIR  ';
end;

function TFormulaImobiliariaAdvanceStr.fVerificaPrecoGeracaoBlnUnitario: Boolean;
begin
  Result := False;

  If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') Then
  Begin
    If BlnCalculaUnitario Then
      Result := True;
  End;
end;

function TFormulaImobiliariaAdvanceStr.fVerificaPromocao(fPromocao, blnProPre,
  CfgColPro: Boolean): Boolean;
begin
  Result := False;

  If fPromocao Then
  Begin
    If Not blnProPre Then
    Begin
      If CfgColPro Then
      Begin
        Result := True;
        Exit;
      End;
    End;
  End;
end;

function TFormulaImobiliariaAdvanceStr.GetCalculadorInterno
  : ICalculadorFormulaImobiliaria;
begin
  Result := TCalculadorFormulaImobiliariaAdvanceStr.Create(Self);
end;

function TFormulaImobiliariaAdvanceStr.GetChaveIteTin(const dtsCadTin
  : IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('ADS_MD5KEY').AsString
end;

function TFormulaImobiliariaAdvanceStr.GetDescricao(const dtsCadTin
  : IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('ADS_PRODUT').AsString;
end;

function TFormulaImobiliariaAdvanceStr.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaImobiliariaAdvanceStr.GetIdePro: String;
begin
  Result := 'ADS';
end;

function TFormulaImobiliariaAdvanceStr.GetItemBaseOriginal(const strIteTin
  : String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      If TMultiSelectLocalizadorFactory.GetLocalizador('ADSBAS')
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

function TFormulaImobiliariaAdvanceStr.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaAdvanceStr.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaAdvanceStr.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaAdvanceStr.GetNomeTabelaBase: String;
begin
  Result := 'ADS_CADBAS';
end;

function TFormulaImobiliariaAdvanceStr.GetNomeCampoColDesCol: string;
begin
  Result := 'COL_DESCRI';
end;

function TFormulaImobiliariaAdvanceStr.GetNomeTabelaColorantes: String;
begin
  Result := 'ADS_CADCOL';
end;

function TFormulaImobiliariaAdvanceStr.GetPrefixoFormulacao: String;
begin
  Result := 'ADS_FORM';
end;

function TFormulaImobiliariaAdvanceStr.GetPrefixoQuantidade(const strModo
  : String): String;
begin
  Result := 'ADS_QTDC';
end;

function TFormulaImobiliariaAdvanceStr.GetProdutoBaseFormula(const dtsCadTin
  : IDataSet): String;
var
  dtsGen: IDataSet;
begin
  Try
    Try
      dtsGen := TAutcomTintaFactory.Get.fGetDataSet;
      dtsGen.SQL := ' SELECT                     ' +
        '   BAS_CODITE               ' + ' FROM                       ' +
        '   ADS_CADBAS               ' + ' WHERE BAS_CODBAS = :CODBAS ' +
        '   AND BAS_UNIDAD = :CODUNI ' + '  AND BAS_PRODUT = :DESCRI  ';

      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('ADS_CODBAS').AsString;
      dtsGen.ParamByName('CODUNI').AsString := dtsCadTin.FieldByName('ADS_UNIDAD').AsString;
      dtsGen.ParamByName('DESCRI').AsString := dtsCadTin.FieldByName('ADS_PRODUT').AsString;
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

function TFormulaImobiliariaAdvanceStr.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaAdvanceStr.GetSaldos: ISaldosColorantes;
var
  intCont: Integer;
  saldos: TGenericSaldosColorantes;
  colorante: TColorante;
begin
  saldos := TGenericSaldosColorantes.Create();

  for intCont := 0 to Self.Count - 1 do
  begin
    colorante := TColorante(Self.Items[intCont]);
    GetDataSetColorantes.Locate('COL_CODCOL', colorante.CodigoColorante, []);

    if colorante.Quantidade > 0 then
    begin
      saldos.Adicionar(TGenericSaldoColorante.Create(1,
        Descricao,
        GetDataSetColorantes.FieldByName('COL_CODITE').AsString,
        VarToStrDef(TAutcomTintaFactory.Get.GetValorCampo
        ('SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE',
        'ITE_DESITE', [GetDataSetColorantes.FieldByName('COL_CODITE').AsString], True
        ), ''),
        colorante.CodigoColorante,
        TAutcomTintaFactory.Get.IIF((TAutcomTintaFactory.Get.fGetConfTinta('ADS').fGet('MOVEST') = 'GR') Or (TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fGetConfTinta('ADS').fGet('MOVEST')))
        , colorante.Quantidade * FatorEstoque, (colorante.Quantidade / fRetornaPesoEspecifico(colorante.CodigoColorante)) * FatorEstoque),
        COLORANTE_IMOBILIARIO,
        'N',
        0.0));
    end;
  end;

  saldos.Adicionar(TGenericSaldoColorante.Create(1,
    Descricao,
    ItemBase,
    VarToStrDef(TAutcomTintaFactory.Get.GetValorCampo
    ('SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE', 'ITE_DESITE',
    [ItemBase], True), ''),
    ItemBase,
    1,
    BASE_IMOBILIARIA,
    'N',
    0.0));

  Result := saldos;
end;

function TFormulaImobiliariaAdvanceStr.GetTextoInformativoCalculo: String;
Var
  strValorPreco: String;
begin
  If (TAutcomTintaFactory.Get.fGetConfTinta('ADS').fGet('MOVEST') = 'GR') Or (TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fGetConfTinta('ADS').fGet('MOVEST'))) Then
    strValorPreco :=   'Valor do Colorante = (Quantidade em gramas * Preço) / (Embalagem * Peso Específico) '
  Else
    strValorPreco :=  'Valor do Colorante = Quantidade em ML  * (Preço / Embalagem) ';

  Result :=
    'Valor da Base = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) + sLineBreak + strValorPreco + sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaAdvanceStr.GetUnidade(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('ADS_UNIDAD').AsString;
end;

{$IFNDEF LINUX}
procedure TFormulaImobiliariaAdvanceStr.pAddItemsFormulacao(
  lsvFormulacao: TListView; Formula: TAbstractFormula);
Var
  Colorante: TColorante;
  intContador: Integer;
begin
  For intContador := 0 To Formula.Count - 1 Do
  Begin
    Colorante := TColorante(Formula.Items[intContador]);

    If Colorante.Embalagem <= 0 Then
      lsvFormulacao.Columns[4].Caption := '';

    If Colorante.DescricaoColorante <> '' Then
      lsvFormulacao.Items.Add.Caption := Colorante.CodigoColorante + ' - ' + Colorante.DescricaoColorante
    Else
      lsvFormulacao.Items.Add.Caption := Colorante.CodigoColorante;

    lsvFormulacao.Items[intContador].SubItems.Add(FloatToStrF(Colorante.Quantidade / fRetornaPesoEspecifico(Colorante.CodigoColorante), ffFixed, 12, 3));
    lsvFormulacao.Items[intContador].SubItems.Add(FloatToStrF(Colorante.Quantidade , ffFixed, 12, 3));

    lsvFormulacao.Items[intContador].SubItems.Add(FloatToStrF(Colorante.PrecoVenda, ffFixed, 12, 6));

    If Colorante.Embalagem > 0 Then
      lsvFormulacao.Items[intContador].SubItems.Add(FloatToStrF(Colorante.Embalagem, ffFixed, 12, 4));
  End;
end;

procedure TFormulaImobiliariaAdvanceStr.pAjustaFormulacao(
  lsvFormulacao: TListView; Form: TForm);
begin
  Form.ClientWidth := 700;
  Form.Width := 700;
  lsvFormulacao.Columns.Clear;

  lsvFormulacao.Columns.Add;
  lsvFormulacao.Columns.Items[0].Alignment := taRightJustify;
  lsvFormulacao.Columns.Items[0].Caption   := 'Colorante';
  lsvFormulacao.Columns.Items[0].Width     := (lsvFormulacao.Width - 10) div 5;

  lsvFormulacao.Columns.Add;
  lsvFormulacao.Columns.Items[1].Alignment := taRightJustify;
  lsvFormulacao.Columns.Items[1].Caption   := 'Quantidade(ML)';
  lsvFormulacao.Columns.Items[1].Width     := (lsvFormulacao.Width - 10) div 5;

  lsvFormulacao.Columns.Add;
  lsvFormulacao.Columns.Items[2].Alignment := taRightJustify;
  lsvFormulacao.Columns.Items[2].Caption   := 'Quantidade(Grama)';
  lsvFormulacao.Columns.Items[2].Width     := (lsvFormulacao.Width - 10) div 5;

  lsvFormulacao.Columns.Add;
  lsvFormulacao.Columns.Items[3].Alignment := taRightJustify;
  lsvFormulacao.Columns.Items[3].Caption   := 'Preço';
  lsvFormulacao.Columns.Items[3].Width     := (lsvFormulacao.Width - 10) div 5;

  lsvFormulacao.Columns.Add;
  lsvFormulacao.Columns.Items[4].Alignment := taRightJustify;
  lsvFormulacao.Columns.Items[4].Caption   := 'Embalagem';
  lsvFormulacao.Columns.Items[4].Width     := (lsvFormulacao.Width - 10) div 5;
end;
{$ENDIF}

procedure TFormulaImobiliariaAdvanceStr.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('ADS_ACRMOB').AsFloat;
end;

end.
