{ ******************************************************************************** }
{ * Classe responsável pelas rotidas especificas de uma formula AdvanceTintoSystem * }
{ *****************************************************************************AC* }
unit untFormulaImobiliariaAdvanceTintoSystem;

interface

uses
  untAbstractFormulaImobiliaria, untICalculadorFormulaImobiliaria, untIDataSet,
  untColorante,
  SysUtils, Variants, untFloatUtils, System.Classes,
  untTintaDeMaquinaComponenteComparerBaseImobiliaria,
  untTintaDeMaquinaComponenteComparerColorante, untISaldosColorantes,
  untGenericSaldosColorantes, untITintaDeMaquinaComponente, untIDicionario,
  untGenericTintaDeMaquinaComponente, untTintaDeMaquinaComponenteTipo;

type
  TFormulaImobiliariaAdvanceTintoSystem = class(TAbstractFormulaImobiliaria)
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
    procedure GetEmbalagensDisponivels(const dicEmbalagens: IDicionario;
      const dicCodigosEmbalagens: IDicionario;
      const dicProdutosBase: IDicionario); override;
    procedure CarregaPrecosColorantes; override;
    procedure CarregarPrecosBases; override;
    function GetSaldos: ISaldosColorantes; override;
    function GetQuantidadeFormulacao(): Integer; override;
    function GetPrefixoFormulacao(): String; override;
    function GetPrefixoFormulacaoCatalisador(): String; override;
    function GetPrefixoQuantidadeCatalisador(): String; override;
    function GetDescricao(const dtsCadTin: IDataSet): String; override;
    function GetUnidade(const dtsCadTin: IDataSet): String; override;
    function GetProdutoBaseFormula(const dtsCadTin: IDataSet): String; override;
    function GetCodigoProdutoEmbalagem(): string; override;
    function GetFatorEstoque(): Double; override;
    function GetIdePro: String; override;
    function GetItemBaseOriginal(const strIteTin: String): String; override;
    function GetChaveIteTin(const dtsCadTin: IDataSet): string; override;
    function GetNomeCampoColDesCol: string; override;
    procedure CarregarColorantes; override;
    procedure CarregarBases; override;
    procedure CarregarEmbalagens; override;
    procedure CalcularPrecosIndustrial; override;
    function fMostrarFormulacaoIndustrial(): Boolean; override;
    function GetTemCatalisador(): Boolean; override;
    function GetVolumeOriginal(const dtsCadTin: IDataSet): Double; override;
    function GetVolumeBaseOriginal(const dtsCadTin: IDataSet): Double; override;
    function GetVolumeColoranteOriginal(const dtsCadTin: IDataSet)
      : Double; override;
    function GetUsaCatalisador(const dtsCadTin: IDataSet): Boolean; override;
    procedure CarregarPrecosBasesEmbalagem(const strCodigoEmbalagemBase: string); Override;
    procedure PreencheAcrescimoMaoObra(const dtsCadTin: IDataSet); Override;
  end;

implementation

uses
  untAbstractCalculadorFormulaImobiliaria, untAutcomTintaFactory, untStrUtils;

{ TFormulaImobiliariaAdvanceTintoSystem }

procedure TFormulaImobiliariaAdvanceTintoSystem.CalcularPrecosIndustrial;
Var
  intForm: Integer;
  colorante: TColorante;
  fltVendaColorante, fltEmbalagem, fltQuantidade: Double;
  TintaDeMaquinaComponente: ITintaDeMaquinaComponente;
  fltPerAcr: Double;
begin
  Try
    Try
      ZerarPrecos;
      fltPerAcr := TAutcomTintaFactory.Get.fGetConfTinta('ADT')
        .fGetDouble('APREVE') / 100.0;
      CarregaPrecosColorantes;
      CarregarPrecosBases;
      CarregaPrecosEmbalagens;

      For intForm := 0 To Self.Count - 1 Do
      Begin
        colorante := TColorante(Self.Items[intForm]);

        If (Not UsaCatalisador) And (colorante.Tipo = tciCatalisador) Then
          Continue;

        If Not(blnPersonalizada) And (colorante.Tipo = tciBase) Then
          Continue;

        If colorante.Tipo = tciCatalisador Then
        Begin
          If dtsCadTin <> Nil Then
          Begin
            If Not GetDataSetBases.Locate('BAS_CODBAS;BAS_CODEMB',
              VarArrayOf([colorante.CodigoColorante,
              dtsCadTin.FieldByName('ADT_CODEMB').AsString]), []) Then
            Begin
              Raise Exception.CreateFmt
                ('O catalisador %s não está cadastrado! Verificar!',
                [colorante.CodigoColorante]);
            End;
          End;

          If TStrUtils.fEmptyStr(GetDataSetBases.FieldByName('BAS_CODITE')
            .AsString) Then
          Begin
            Raise Exception.CreateFmt
              ('O catalisador %s não está com o produto de venda associado! Verificar!',
              [colorante.CodigoColorante]);
          End;
        End
        Else
        Begin
          If Not GetDataSetColorantes.Locate('COL_CODCOL',
            colorante.CodigoColorante, []) Then
          Begin
            Raise Exception.CreateFmt
              ('O' + TAutcomTintaFactory.Get.IIF(colorante.Tipo <>
              tciCatalisador, 'Colorante', 'Catalisador') +
              '%s não está cadastrado! Verificar!',
              [colorante.CodigoColorante]);
          End;

          If TStrUtils.fEmptyStr(GetDataSetColorantes.FieldByName('COL_CODITE')
            .AsString) Then
          Begin
            Raise Exception.CreateFmt
              ('O' + TAutcomTintaFactory.Get.IIF(colorante.Tipo <>
              tciCatalisador, 'Colorante', 'Catalisador') +
              '%s não está com o produto de venda associado! Verificar!',
              [colorante.CodigoColorante]);
          End;

          If GetDataSetColorantes.FieldByName('ITE_CNV_ML').AsFloat <= 0 Then
          Begin
            Raise Exception.CreateFmt
              ('O produto %s não está com o fator tintometrico preenchido! Verificar!',
              [GetDataSetColorantes.FieldByName('COL_CODITE').AsString]);
          End;
        End;

        TintaDeMaquinaComponente := tintaDeMaquina.Localizar
          (TTintaDeMaquinaComponenteComparerColorante.Create
          (colorante.CodigoColorante));
        If Not Assigned(TintaDeMaquinaComponente) Then
        Begin
          TintaDeMaquinaComponente := tintaDeMaquina.Adicionar
            (TGenericTintaDeMaquinaComponente.Create(TAutcomTintaFactory.Get.IIF
            (colorante.Tipo = tciCatalisador,
            GetDataSetBases.FieldByName('BAS_CODITE').AsString,
            GetDataSetColorantes.FieldByName('COL_CODITE').AsString),
            colorante.CodigoColorante, tmctColoranteImobiliario));
        End;

        fltEmbalagem := colorante.Embalagem;
        fltQuantidade := colorante.Quantidade;

        If colorante.Tipo = tciCatalisador Then
        Begin
          fltEmbalagem := 1;
          fltQuantidade := 1;
        End;

        fltVendaColorante := fltQuantidade * colorante.PrecoVenda /
          fltEmbalagem;

        TintaDeMaquinaComponente.Quantidade := fltQuantidade;
        TintaDeMaquinaComponente.PrecoCusto := fltQuantidade *
          colorante.PrecoCusto / fltEmbalagem;
        TintaDeMaquinaComponente.PrecoCustoReal := fltQuantidade *
          colorante.PrecoCustoReal / fltEmbalagem;
        TintaDeMaquinaComponente.PrecoVenda := fltVendaColorante;

        TintaDeMaquinaComponente.OutrosValores :=
          (fltQuantidade * (colorante.OutrosValores / fltEmbalagem));
        TintaDeMaquinaComponente.IcmsSaida :=
          (fltVendaColorante * (colorante.IcmsSaida / 100));
        TintaDeMaquinaComponente.ImpostosFederais :=
          (fltVendaColorante * (colorante.ImpostosFederais / 100));
        TintaDeMaquinaComponente.DespesasOperacionais :=
          (fltVendaColorante * (colorante.DespesasOperacionais / 100));

        TintaDeMaquinaComponente.PrecoMedio :=
          (fltQuantidade * (colorante.PrecoMedio / fltEmbalagem));
        TintaDeMaquinaComponente.UltimoPrecoCompra :=
          (fltQuantidade * (colorante.UltimoPrecoCompra / fltEmbalagem));
        TintaDeMaquinaComponente.UltimoPrecoCompraImpostos :=
          (fltQuantidade * (colorante.UltimoPrecoCompraImpostos /
          fltEmbalagem));
        TintaDeMaquinaComponente.PrecoCompraLiquido :=
          (fltQuantidade * (colorante.PrecoCompraLiquido / fltEmbalagem));
      End;

      fltColPrecoCustoInd := tintaDeMaquina.GetPrecoCustoComponentes;
      fltColPrecoCustoRealInd := tintaDeMaquina.GetPrecoCustoRealComponentes;
      fltColPrecoVendaInd := tintaDeMaquina.GetPrecoVendaComponentes;
      fltColOutrosValoresInd := tintaDeMaquina.GetOutrosValoresComponentes;

      fltColIcmSaidaInd := tintaDeMaquina.GetIcmsSaidaComponentes;
      fltColDespesasOperacionaisInd :=
        tintaDeMaquina.GetDespesasOperacionaisComponentes;
      fltColImpostosFederaisInd :=
        tintaDeMaquina.GetImpostosFederaisComponentes;

      fltColPrecoMedioInd := tintaDeMaquina.GetPrecoMedioComponentes;
      fltColPrecoUltimaCompraInd :=
        tintaDeMaquina.GetUltimoPrecoCompraComponentes;
      fltColImpostosUltimaCompraInd :=
        tintaDeMaquina.GetUltimoPrecoCompraImpostosComponentes;
      fltColPrecoCompraLiquidoInd :=
        tintaDeMaquina.GetPrecoCompraLiquidoComponentes;

      fltColPrecoVendaInd := fltColPrecoVendaInd +
        (fltPerAcr * fltColPrecoVendaInd);
      //tintaDeMaquina.Limpar; REQ.: 188627 Se limpar, dará pau, no F4 do F4 pois entrará em loop infinito em untRecalculadorTintadeMaquina > TRecalculadorTintadeMaquina.Recalcular

    Except
      On E: Exception Do
      Begin
        ZerarPrecos;
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', E.Message, ['&Ok']);
        Abort;
      End;
    End;
  Finally

  End;
end;

procedure TFormulaImobiliariaAdvanceTintoSystem.CarregaPrecosColorantes;
var
  intContador: Integer;
  colorante: TColorante;
  fltPreCus: Double;
  fltPreVen: Double;
  fltDesOpeTinta: Double;
  dicDados: IDicionario;
  blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
begin
  fltDesOpeTinta := TAutcomTintaFactory.Get().fGetConfTinta(GetIdePro)
    .fGetDouble('DESOPE');

  For intContador := 0 To Self.Count - 1 Do
  Begin
    colorante := TColorante(Self.Items[intContador]);

    If colorante.Tipo = tciCatalisador Then
    Begin

      If dtsCadTin <> Nil Then
      Begin
        If Not GetDataSetBases.Locate('BAS_CODBAS;BAS_CODEMB',
          VarArrayOf([colorante.CodigoColorante,
          dtsCadTin.FieldByName('ADT_CODEMB').AsString]), []) Then
        Begin
          Raise Exception.CreateFmt('O catalisador %s não está cadastrado!',
            [colorante.CodigoColorante]);
        End;
      End;
    End
    Else
    Begin
      If Not GetDataSetColorantes.Locate('COL_CODCOL',
        VarArrayOf([colorante.CodigoColorante]), []) Then
      Begin
        Raise Exception.CreateFmt('O' + TAutcomTintaFactory.Get.IIF
          (colorante.Tipo <> tciCatalisador, 'Colorante', 'Catalisador') + ' %s'
          + 'não está cadastrado!', [colorante.CodigoColorante]);
      End;
    End;

    If TAutcomTintaFactory.Get.fCarregaPromocao
      (TAutcomTintaFactory.Get.IIF(colorante.Tipo = tciCatalisador,
      GetDataSetBases.FieldByName('BAS_CODITE').AsString,
      GetDataSetColorantes.FieldByName('COL_CODITE').AsString), strTabPre,
      strCodCli, strCodCnd, intPrzMed, fltPreCus, fltPreVen, blnPrecoFixoParaTintaDeMaquinaImobiliaria) Then
    Begin
        colorante.PrecoCusto := fltPreCus;

        If TAutcomTintaFactory.Get.fGetConfTinta(GetIdePro).fGet('ZERCOL') = 'S' Then
          Colorante.PrecoVenda := 0
        Else
          Colorante.PrecoVenda := fltPreVen;

      If strTabPre = strTabPreTin Then
        Self.Promoc := 'S';

      If colorante.PrecoCusto = 0 Then
        colorante.PrecoCusto := TAutcomTintaFactory.Get.IIF
          (colorante.Tipo = tciCatalisador,
          GetDataSetBases.FieldByName('ITE_PRECUS').AsFloat,
          GetDataSetColorantes.FieldByName('ITE_PRECUS').AsFloat);
    End
    Else
    Begin
      colorante.PrecoCusto := TAutcomTintaFactory.Get.IIF(colorante.Tipo = tciCatalisador,
        GetDataSetBases.FieldByName('ITE_PRECUS').AsFloat, GetDataSetColorantes.FieldByName('ITE_PRECUS').AsFloat);

      If TAutcomTintaFactory.Get.fGetConfTinta(GetIdePro).fGet('ZERCOL') = 'S' Then
        Colorante.PrecoVenda := 0
      Else
        Colorante.PrecoVenda := TAutcomTintaFactory.Get.IIF(colorante.Tipo = tciCatalisador,
        GetDataSetBases.FieldByName('ITE_PREVEN').AsFloat, GetDataSetColorantes.FieldByName('ITE_PREVEN').AsFloat);
    End;

    If colorante.Tipo = tciCatalisador Then
    Begin
      colorante.DescricaoColorante := GetDataSetBases.FieldByName
        ('BAS_DESCRI').AsString;
      colorante.CodIte := GetDataSetBases.FieldByName('BAS_CODITE').AsString;
      colorante.ImpDir := GetDataSetBases.FieldByName('ITE_IMPDIR').AsString;
      colorante.OutrosValores := GetDataSetBases.FieldByName
        ('ITE_OUTVAL').AsFloat;
      colorante.PesoEspecifico := GetDataSetBases.FieldByName
        ('BAS_PESESP').AsFloat;
      colorante.Embalagem := 0;

      If TAutcomTintaFactory.Get.fCfgSis('IMPCF4', varBoolean) And
        Assigned(calculadorFatVendas) Then
        colorante.IcmsSaida := calculadorFatVendas.fCalculaAliquota
          (colorante.CodIte, colorante.ImpDir)
      Else
        colorante.IcmsSaida := GetDataSetBases.FieldByName
          ('ITE_ICMSAI').AsFloat;

      colorante.ImpostosFederais := GetDataSetBases.FieldByName
        ('ITE_IMPFED').AsFloat;
      colorante.DespesasOperacionais := GetDataSetBases.FieldByName
        ('ITE_DESOPE').AsFloat + fltDesOpeTinta;
      colorante.PrecoMedio := GetDataSetBases.FieldByName('ITE_PREMED').AsFloat;
      colorante.UltimoPrecoCompra := GetDataSetBases.FieldByName
        ('ITE_PREULT').AsFloat;
      colorante.UltimoPrecoCompraImpostos := GetDataSetBases.FieldByName
        ('ITE_IMPULT').AsFloat;
      colorante.PrecoCompraLiquido := TFloatUtils.fFormataFloat
        (TAutcomTintaFactory.Get.fCalculaPrecoCompraLiq
        (GetDataSetBases.FieldByName('ITE_PRECOM').AsFloat,
        GetDataSetBases.FieldByName('ITE_DESF01').AsFloat,
        GetDataSetBases.FieldByName('ITE_DESF02').AsFloat,
        GetDataSetBases.FieldByName('ITE_DESF03').AsFloat,
        GetDataSetBases.FieldByName('ITE_DESF04').AsFloat,
        GetDataSetBases.FieldByName('ITE_DESF05').AsFloat,
        GetDataSetBases.FieldByName('ITE_DESF06').AsFloat),
        TAutcomTintaFactory.Get.fCfgSis('DECUNI', varInteger));

    End
    Else
    Begin
      colorante.DescricaoColorante := GetDataSetColorantes.FieldByName
        ('COL_DESCRI').AsString;
      colorante.CodIte := GetDataSetColorantes.FieldByName
        ('COL_CODITE').AsString;
      colorante.ImpDir := GetDataSetColorantes.FieldByName
        ('ITE_IMPDIR').AsString;
      colorante.OutrosValores := GetDataSetColorantes.FieldByName
        ('ITE_OUTVAL').AsFloat;
      colorante.PesoEspecifico := GetDataSetColorantes.FieldByName
        ('COL_PESESP').AsFloat;
      colorante.Embalagem := GetDataSetColorantes.FieldByName
        ('COL_EMBALA').AsFloat;

      If TAutcomTintaFactory.Get.fCfgSis('IMPCF4', varBoolean) And
        Assigned(calculadorFatVendas) Then
        colorante.IcmsSaida := calculadorFatVendas.fCalculaAliquota
          (colorante.CodIte, colorante.ImpDir)
      Else
        colorante.IcmsSaida := GetDataSetColorantes.FieldByName
          ('ITE_ICMSAI').AsFloat;

      colorante.ImpostosFederais := GetDataSetColorantes.FieldByName
        ('ITE_IMPFED').AsFloat;
      colorante.DespesasOperacionais := GetDataSetColorantes.FieldByName
        ('ITE_DESOPE').AsFloat + fltDesOpeTinta;
      colorante.PrecoMedio := GetDataSetColorantes.FieldByName
        ('ITE_PREMED').AsFloat;
      colorante.UltimoPrecoCompra := GetDataSetColorantes.FieldByName
        ('ITE_PREULT').AsFloat;
      colorante.UltimoPrecoCompraImpostos := GetDataSetColorantes.FieldByName
        ('ITE_IMPULT').AsFloat;
      colorante.PrecoCompraLiquido := TFloatUtils.fFormataFloat
        (TAutcomTintaFactory.Get.fCalculaPrecoCompraLiq
        (GetDataSetColorantes.FieldByName('ITE_PRECOM').AsFloat,
        GetDataSetColorantes.FieldByName('ITE_DESF01').AsFloat,
        GetDataSetColorantes.FieldByName('ITE_DESF02').AsFloat,
        GetDataSetColorantes.FieldByName('ITE_DESF03').AsFloat,
        GetDataSetColorantes.FieldByName('ITE_DESF04').AsFloat,
        GetDataSetColorantes.FieldByName('ITE_DESF05').AsFloat,
        GetDataSetColorantes.FieldByName('ITE_DESF06').AsFloat),
        TAutcomTintaFactory.Get.fCfgSis('DECUNI', varInteger));
    End;

    dicDados := TAutcomTintaFactory.Get.GetDicionario;

    dicDados['preven'] := colorante.PrecoVenda;
    dicDados['precus'] := colorante.PrecoCusto;
    dicDados['outval'] := colorante.OutrosValores;
    dicDados['icmsai'] := colorante.IcmsSaida;
    dicDados['impfed'] := colorante.ImpostosFederais;
    dicDados['desope'] := colorante.DespesasOperacionais;

    colorante.PrecoCustoReal := TAutcomTintaFactory.Get.fCalculaPrecoCusto2
      (dicDados);

    CarregaPrecosColorantesAdicional(GetDataSetColorantes, colorante);
  End;

  TextoInformativoCalculo.Text := GetTextoInformativoCalculo;

end;

procedure TFormulaImobiliariaAdvanceTintoSystem.CarregaPrecosColorantesAdicional
  (const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
  If colorante.Tipo = tciCatalisador Then
    colorante.Embalagem := 0
  Else
    colorante.Embalagem := dataSetColorantes.FieldByName('COL_EMBALA').AsFloat;
end;

procedure TFormulaImobiliariaAdvanceTintoSystem.CarregarBases;
begin
  GetDataSetBases.Close;
  GetDataSetBases.SQL := ' SELECT         ' + '   BAS_CODEMP   ' +
    '   , BAS_CODBAS ' + '   , BAS_CODEMB ' + '   , BAS_PRODUT ' +
    '   , BAS_DESCRI ' + '   , BAS_PESESP ' + '   , EMB_DESCRI ' +
    '   , EMB_CODUNI ' + '   , BAS_CODITE ' + '   , ITE_CNV_ML ' +
    '   , ITE_OUTVAL ' + '   , ITE_ICMSAI ' + '   , ITE_IMPFED ' +
    '   , ITE_DESOPE ' + '   , ITE_PREULT ' + '   , ITE_IMPULT ' +
    '   , ITE_PREMED ' + '   , ITE_PRECOM ' + '   , ITE_DESF01 ' +
    '   , ITE_DESF02 ' + '   , ITE_DESF03 ' + '   , ITE_DESF04 ' +
    '   , ITE_DESF05 ' + '   , ITE_DESF06 ' + '   , BAS_CODITE ';

  If TAutcomTintaFactory.Get.fCfgSis('IMPDIG') = '1' Then
    GetDataSetBases.SQL := GetDataSetBases.SQL + '   , I.ITE_IMPDIR  '
  else
    GetDataSetBases.SQL := GetDataSetBases.SQL + '   , G.ITE_IMPDIR  ';

  If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '0') Then
  Begin
    GetDataSetBases.SQL := GetDataSetBases.SQL +
      '   , BAS_PRECUS AS ITE_PRECUS ' + '   , BAS_PREVEN AS ITE_PREVEN ';
  End
  Else If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') And BlnCalculaUnitario Then
  Begin
    GetDataSetBases.SQL := GetDataSetBases.SQL + '   , ITE_PRECUS ' +
      '   , G.ITE_PREVE' + TAutcomTintaFactory.Get.fCfgSis('TABPRE') + ' AS ITE_PREVEN ';
  End
  Else
  Begin
    GetDataSetBases.SQL := GetDataSetBases.SQL + '   , ITE_PRECUS ' +
      '   , G.ITE_PREVE' + Self.strTabPre + ' AS ITE_PREVEN ';
  End;

  GetDataSetBases.SQL := GetDataSetBases.SQL +
    ' FROM                           ' + '   ADT_CADBAS                   ' +
    '   LEFT JOIN ADT_CADEMB         ' + '     ON BAS_CODEMB = EMB_CODEMB ' +
    '   LEFT JOIN CADITE I             ' + '     ON BAS_CODITE = I.ITE_CODITE '
    + '   LEFT JOIN ITEGER G               ' +
    '     ON I.ITE_CODITE = G.ITE_CODITE ' +
    '     AND G.ITE_CODEMP = :CODEMP     ';


  If (Not TStrUtils.fEmptyStr(Self.EmpPrd)) And (Self.OprFlj = 'S') Then
    GetDataSetBases.ParamByName('CODEMP').AsString := Self.EmpPrd
  Else If Not (TStrUtils.fEmptyStr(Self.EmpCd_)) And (Self.Cd_S_N = 'S') Then
    GetDataSetBases.ParamByName('CODEMP').AsString := Self.EmpCd_
  Else If Not (TStrUtils.fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
    GetDataSetBases.ParamByName('CODEMP').AsString := Self.EmpFat
  Else
    GetDataSetBases.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;

  GetDataSetBases.Open;

end;

procedure TFormulaImobiliariaAdvanceTintoSystem.CarregarColorantes;
var
  strSql: String;
begin
  strSql := ' SELECT         ' + '     COL_CODCOL ' + '   , COL_CODITE ' +
    '   , COL_EMBALA ' + '   , COL_PESESP ';

  if GetNomeCampoColDesCol <> '' then
    strSql := strSql + ' , ' + GetNomeCampoColDesCol
  else
    strSql := strSql + ', "" AS COL_DESCRI ';

  strSql := strSql + '   , IFNULL(ITE_ITEATI, "N") ITE_ITEATI      ' +
    '   , ITE_CNV_ML ' + '   , ITE_OUTVAL ' + '   , ITE_ICMSAI ' +
    '   , ITE_IMPFED ' + '   , ITE_DESOPE ' + '   , ITE_PREMED ' +
    '   , ITE_IMPULT ' + '   , ITE_PREULT ' + '   , ITE_PRECOM ' +
    '   , ITE_DESF01 ' + '   , ITE_DESF02 ' + '   , ITE_DESF03 ' +
    '   , ITE_DESF04 ' + '   , ITE_DESF05 ' + '   , ITE_DESF06 ';

  If TAutcomTintaFactory.Get.fCfgSis('IMPDIG') = '1' Then
    strSql := strSql + '   , I.ITE_IMPDIR  '
  else
    strSql := strSql + '   , G.ITE_IMPDIR  ';

  If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '0') Then
  begin
    strSql := strSql + '   , COL_PRECUS AS ITE_PRECUS ' +
      '   , COL_PREVEN AS ITE_PREVEN ';
  end

  Else If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') And BlnCalculaUnitario Then
  begin
    strSql := strSql + '   , ITE_PRECUS               ' +
                       '   , ITE_PREVE' + TAutcomTintaFactory.Get.fCfgSis('TABPRE') + ' AS ITE_PREVEN ';
  end
  else
  begin
    strSql := strSql + '   , ITE_PRECUS               ' + '   , ITE_PREVE' +
      Self.strTabPre + ' AS ITE_PREVEN ';
  end;

  strSql := strSql + ' FROM                               ' + '   ' +
    GetNomeTabelaColorantes + ' C                     ' +
    '   INNER JOIN ITEGER G              ' +
    '     ON C.COL_CODITE = G.ITE_CODITE ' +
    '   INNER JOIN CADITE I              ' +
    '     ON C.COL_CODITE = I.ITE_CODITE ' +
    ' WHERE G.ITE_CODEMP = :CODEMP       ';

  GetDataSetColorantes.SQL := strSql;

  If (Not TStrUtils.fEmptyStr(Self.EmpPrd)) And (Self.OprFlj = 'S') Then
    GetDataSetColorantes.ParamByName('CODEMP').AsString := Self.EmpPrd
  Else If Not (TStrUtils.fEmptyStr(Self.EmpCd_)) And (Self.Cd_S_N = 'S') Then
    GetDataSetColorantes.ParamByName('CODEMP').AsString := Self.EmpCd_
  Else If Not (TStrUtils.fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
    GetDataSetColorantes.ParamByName('CODEMP').AsString := Self.EmpFat
  Else
    GetDataSetColorantes.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;

  GetDataSetColorantes.Open;
end;

procedure TFormulaImobiliariaAdvanceTintoSystem.CarregarEmbalagens;
begin
  GetDataSetEmbalagens.SQL := ' SELECT         ' + '   ITE_CODITE   ' +
    '   , ITE_OUTVAL ' + '   , ITE_ICMSAI ' + '   , ITE_IMPFED ' +
    '   , ITE_DESOPE ';
  If (TAutcomTintaFactory.Get.fCfgSis('PREGER') = '1') And (BlnCalculaUnitario) Then
  Begin
    GetDataSetEmbalagens.SQL := GetDataSetEmbalagens.SQL + '   , ITE_PRECUS ' +
      '   , ITE_PREVE' + TAutcomTintaFactory.Get.fCfgSis('TABPRE') + ' AS ITE_PREVEN ';
  End
  Else
  Begin
    GetDataSetEmbalagens.SQL := GetDataSetEmbalagens.SQL + '   , ITE_PRECUS ' +
      '   , ITE_PREVE' +  Self.strTabPre + ' AS ITE_PREVEN ';
  End;

  GetDataSetEmbalagens.SQL := GetDataSetEmbalagens.SQL +
    ' FROM                       ' + '   ITEGER                   ' +
    ' WHERE ITE_CODITE = :CODITE ' + '   AND ITE_CODEMP = :CODEMP ';

  If (Not TStrUtils.fEmptyStr(Self.EmpPrd)) And (Self.OprFlj = 'S') Then
    GetDataSetEmbalagens.ParamByName('CODEMP').AsString := Self.EmpPrd
  Else If (Not TStrUtils.fEmptyStr(Self.EmpCd_)) And (Self.Cd_S_N = 'S') Then
    GetDataSetColorantes.ParamByName('CODEMP').AsString := Self.EmpCd_
  Else If (Not TStrUtils.fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
    GetDataSetColorantes.ParamByName('CODEMP').AsString := Self.EmpFat
  Else
    GetDataSetEmbalagens.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;

  GetDataSetEmbalagens.ParamByName('CODITE').AsString := GetCodigoProdutoEmbalagem;
  GetDataSetEmbalagens.Open;
end;

procedure TFormulaImobiliariaAdvanceTintoSystem.CarregarPrecosBases;
Var
  fltDesOpeTinta: Double;
  base: ITintaDeMaquinaComponente;
  fltPreCusPro, fltPreVenPro: Double;
  fltPerAcr: Double;
  dicDados: IDicionario;
  strSQL: String;
  dataSetCalculo: IDataSet;
  strCodEmpresa: String;
  blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
begin
  tintaDeMaquina.Remover(tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(Self.ItemBase)));
  Try
    Try
      fltDesOpeTinta := TAutcomTintaFactory.Get.fGetConfTinta('ADT').fGetDouble('DESOPE');
      fltPerAcr := TAutcomTintaFactory.Get.fGetConfTinta('ADT').fGetDouble('APREVE') / 100.0;
      strCodEmpresa := fVerificaEmpresaSetada();

      If dtsCadTin <> Nil Then
      Begin
        If Not(TStrUtils.fEmptyStr(strCodigoEmbalagemBase)) And
          (strCodigoEmbalagemBase <> dtsCadTin.FieldByName('ADT_CODEMB').AsString) Then
        Begin
          CarregarPrecosBasesEmbalagem(strCodigoEmbalagemBase);
          Exit;
        End;
      End;

      If dtsCadTin <> Nil Then
      Begin
        if not GetDataSetBases.Locate('BAS_CODBAS;BAS_CODEMB;BAS_PRODUT',
          VarArrayOf([dtsCadTin.FieldByName('ADT_CODBAS').AsString,
          dtsCadTin.FieldByName('ADT_CODEMB').AsString,
          dtsCadTin.FieldByName('ADT_PRODUT').AsString]), []) then
          raise Exception.CreateFmt('A bases %s - %s - %s não está cadastrada!',
            [dtsCadTin.FieldByName('ADT_CODBAS').AsString,
            dtsCadTin.FieldByName('ADT_CODEMB').AsString,
            dtsCadTin.FieldByName('ADT_PRODUT').AsString]);
      End;


      If Not TStrUtils.fEmptyStr(Self.ItemBase) And (Self.ItemBase <> Self.ItemBaseOriginal) Then
      Begin
        strSQL := ' SELECT          ' +
                  '     I.ITE_ITEATI  ' +
                  '   , I.ITE_CODITE  ' +
                  '   , ITE_OUTVAL    ' +
                  '   , ITE_ICMSAI    ' +
                  '   , ITE_IMPFED    ' +
                  '   , ITE_DESOPE    ' +
                  '   , ITE_PREMED    ' +
                  '   , ITE_PREULT    ' +
                  '   , ITE_IMPULT    ' +
                  '   , ITE_PRECOM    ' +
                  '   , ITE_DESF01    ' +
                  '   , ITE_DESF02    ' +
                  '   , ITE_DESF03    ' +
                  '   , ITE_DESF04    ' +
                  '   , ITE_DESF05    ' +
                  '   , ITE_DESF06    ';

        If TAutcomTintaFactory.Get.fCfgSis('IMPDIG') = '1' Then
          strSQL := strSQL + '   , I.ITE_IMPDIR  '
        else
          strSQL := strSQL + '   , G.ITE_IMPDIR  ';

        If (TAutcomTintaFactory.Get.fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO','0') = '1') And BlnCalculaUnitario Then
        Begin
          strSQL := strSQL + '   , ITE_PRECUS               ' +
                             '   , ITE_PREVE'+ TAutcomTintaFactory.Get.fArqIniTinta(0, 'GERAL','TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN ';
        End
        Else
        Begin
          strSQL := strSQL + '   , ITE_PRECUS               ' +
                             '   , ITE_PREVE'+ Self.strTabPre + ' AS ITE_PREVEN ';
        End;

        strSQL := strSQL +
          ' FROM                             ' +
          '   ITEGER G                       ' +
          ' INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ' +
          ' WHERE G.ITE_CODEMP = :CODEMP       ' +
        '   AND G.ITE_CODITE = :CODITE       ';

        dataSetCalculo := TAutcomTintaFactory.Get.fGetDataSet;
        dataSetCalculo.Close;
        dataSetCalculo.SQL := strSQL;

        If (Not TStrUtils.fEmptyStr(Self.EmpPrd)) And (Self.OprFlj = 'S') Then
          dataSetCalculo.ParamByName('CODEMP').AsString := Self.EmpPrd
        Else If (Not TStrUtils.fEmptyStr(Self.EmpCd_)) And (Self.CD_S_N = 'S') Then
          dataSetCalculo.ParamByName('CODEMP').AsString := Self.EmpCd_
        Else If (Not TStrUtils.fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
          dataSetCalculo.ParamByName('CODEMP').AsString := Self.EmpFat
        Else
          dataSetCalculo.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;

        dataSetCalculo.ParamByName('CODITE').AsString := Self.ItemBase;
        dataSetCalculo.Open;

        If (dataSetCalculo.FieldByName('ITE_ITEATI').AsString = 'N') Then
        begin
          raise ExceptionAutCom.CreateFmt('O produto Base %s não está ativo, Favor verificar!', [Self.ItemBase]);
        end;

        Self.ItemBase := dataSetCalculo.FieldByName('ITE_CODITE').AsString;
        Self.strCodigoEmbalagemBase := GetDataSetBases.FieldByName('BAS_CODEMB').AsString;
        Self.strEmbalagemBase := GetDataSetBases.FieldByName('EMB_DESCRI').AsString;
        Self.Unidade := GetDataSetBases.FieldByName('EMB_CODUNI').AsString;

        If TAutcomTintaFactory.Get.fCarregaPromocao(Self.ItemBase, strTabPre,
          strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro, blnPrecoFixoParaTintaDeMaquinaImobiliaria, strCodEmpresa) Then
        Begin
          Self.fltBasePrecoCusto := fltPreCusPro;
          Self.fltBasePrecoVenda := fltPreVenPro;

          Self.Promoc := 'S';

          If Self.fltBasePrecoCusto = 0 Then
            Self.fltBasePrecoCusto := dataSetCalculo.FieldByName('ITE_PRECUS').AsFloat;
        End
        Else
        Begin
          Self.fltBasePrecoCusto := dataSetCalculo.FieldByName('ITE_PRECUS').AsFloat;
          Self.fltBasePrecoVenda := dataSetCalculo.FieldByName('ITE_PREVEN').AsFloat;
        End;

        Self.fltBasePrecoVenda := Self.fltBasePrecoVenda * (1 + fltPerAcr);
        Self.fltBaseOutrosValores := dataSetCalculo.FieldByName('ITE_OUTVAL').AsFloat;
        Self.fltBaseIcmsSaida := dataSetCalculo.FieldByName('ITE_ICMSAI').AsFloat * Self.fltBasePrecoVenda / 100;
        Self.fltBaseImpostosFederais := dataSetCalculo.FieldByName('ITE_IMPFED').AsFloat * Self.fltBasePrecoVenda / 100;
        Self.fltBaseDespesasOperacionais := (((dataSetCalculo.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta) * Self.fltBasePrecoVenda) / 100);
        Self.fltPesoEspecificoBase := GetDataSetBases.FieldByName('BAS_PESESP').AsFloat;

        dicDados := TAutcomTintaFactory.Get.GetDicionario;

        dicDados['preven'] := Self.fltBasePrecoVenda;
        dicDados['precus'] := Self.fltBasePrecoCusto;
        dicDados['outval'] := dataSetCalculo.FieldByName('ITE_OUTVAL').AsFloat;
        dicDados['icmsai'] := dataSetCalculo.FieldByName('ITE_ICMSAI').AsFloat;
        dicDados['impfed'] := dataSetCalculo.FieldByName('ITE_IMPFED').AsFloat;
        dicDados['desope'] := dataSetCalculo.FieldByName('ITE_DESOPE').AsFloat;

        Self.fltBasePrecoCustoReal := TAutcomTintaFactory.Get.fCalculaPrecoCusto2(dicDados);
        Self.fltBasePrecoMedio := dataSetCalculo.FieldByName('ITE_PREMED').AsFloat;
        Self.fltBasePrecoUltimaCompra := dataSetCalculo.FieldByName('ITE_PREULT').AsFloat;
        Self.fltImpostosUltimaCompraBase := dataSetCalculo.FieldByName('ITE_IMPULT').AsFloat;
        Self.fltBasePrecoCompraLiquido := TAutcomTintaFactory.Get.fCalculaPrecoCompraLiq
          (dataSetCalculo.FieldByName('ITE_PRECOM').AsFloat,
          dataSetCalculo.FieldByName('ITE_DESF01').AsFloat,
          dataSetCalculo.FieldByName('ITE_DESF02').AsFloat,
          dataSetCalculo.FieldByName('ITE_DESF03').AsFloat,
          dataSetCalculo.FieldByName('ITE_DESF04').AsFloat,
          dataSetCalculo.FieldByName('ITE_DESF05').AsFloat,
          dataSetCalculo.FieldByName('ITE_DESF06').AsFloat);

        base := tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(Self.ItemBase));

        If Not(Assigned(base)) Then
        Begin
          base := tintaDeMaquina.Adicionar(TGenericTintaDeMaquinaComponente.Create
            (Self.ItemBase, TAutcomTintaFactory.Get.fRetNomProduto(Self.ItemBase),
            Self.fltBaseDespesasOperacionais, Self.fltBaseIcmsSaida,
            Self.fltBaseImpostosFederais, Self.fltBaseOutrosValores,
            Self.fltBasePrecoCusto, Self.fltBasePrecoCustoReal,
            Self.fltBasePrecoMedio, Self.fltBasePrecoVenda, 1,
            tmctBaseImobiliaria, Self.fltBasePrecoUltimaCompra,
            Self.fltImpostosUltimaCompraBase, Self.fltBasePrecoCompraLiquido));
        End;
      End
      Else
      Begin
        Self.ItemBase := GetDataSetBases.FieldByName('BAS_CODITE').AsString;
        Self.strCodigoEmbalagemBase := GetDataSetBases.FieldByName('BAS_CODEMB').AsString;
        Self.strEmbalagemBase := GetDataSetBases.FieldByName('EMB_DESCRI').AsString;
        Self.Unidade := GetDataSetBases.FieldByName('EMB_CODUNI').AsString;

        If TAutcomTintaFactory.Get.fCarregaPromocao(Self.ItemBase, strTabPre,
          strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro, blnPrecoFixoParaTintaDeMaquinaImobiliaria, strCodEmpresa) Then
        Begin
          Self.fltBasePrecoCusto := fltPreCusPro;
          Self.fltBasePrecoVenda := fltPreVenPro;

          Self.Promoc := 'S';

          If Self.fltBasePrecoCusto = 0 Then
            Self.fltBasePrecoCusto := GetDataSetBases.FieldByName
              ('ITE_PRECUS').AsFloat;
        End
        Else
        Begin
          Self.fltBasePrecoCusto := GetDataSetBases.FieldByName('ITE_PRECUS').AsFloat;
          Self.fltBasePrecoVenda := GetDataSetBases.FieldByName('ITE_PREVEN').AsFloat;
        End;

        Self.fltBasePrecoVenda := Self.fltBasePrecoVenda * (1 + fltPerAcr);
        Self.fltBaseOutrosValores := GetDataSetBases.FieldByName('ITE_OUTVAL').AsFloat;
        Self.fltBaseIcmsSaida := GetDataSetBases.FieldByName('ITE_ICMSAI').AsFloat * Self.fltBasePrecoVenda / 100;
        Self.fltBaseImpostosFederais := GetDataSetBases.FieldByName('ITE_IMPFED').AsFloat * Self.fltBasePrecoVenda / 100;
        Self.fltBaseDespesasOperacionais := (((GetDataSetBases.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta) * Self.fltBasePrecoVenda) / 100);
        Self.fltPesoEspecificoBase := GetDataSetBases.FieldByName('BAS_PESESP').AsFloat;

        dicDados := TAutcomTintaFactory.Get.GetDicionario;

        dicDados['preven'] := Self.fltBasePrecoVenda;
        dicDados['precus'] := Self.fltBasePrecoCusto;
        dicDados['outval'] := GetDataSetBases.FieldByName('ITE_OUTVAL').AsFloat;
        dicDados['icmsai'] := GetDataSetBases.FieldByName('ITE_ICMSAI').AsFloat;
        dicDados['impfed'] := GetDataSetBases.FieldByName('ITE_IMPFED').AsFloat;
        dicDados['desope'] := GetDataSetBases.FieldByName('ITE_DESOPE').AsFloat;

        Self.fltBasePrecoCustoReal := TAutcomTintaFactory.Get.fCalculaPrecoCusto2(dicDados);
        Self.fltBasePrecoMedio := GetDataSetBases.FieldByName('ITE_PREMED').AsFloat;
        Self.fltBasePrecoUltimaCompra := GetDataSetBases.FieldByName('ITE_PREULT').AsFloat;
        Self.fltImpostosUltimaCompraBase := GetDataSetBases.FieldByName('ITE_IMPULT').AsFloat;
        Self.fltBasePrecoCompraLiquido := TAutcomTintaFactory.Get.fCalculaPrecoCompraLiq
          (GetDataSetBases.FieldByName('ITE_PRECOM').AsFloat,
          GetDataSetBases.FieldByName('ITE_DESF01').AsFloat,
          GetDataSetBases.FieldByName('ITE_DESF02').AsFloat,
          GetDataSetBases.FieldByName('ITE_DESF03').AsFloat,
          GetDataSetBases.FieldByName('ITE_DESF04').AsFloat,
          GetDataSetBases.FieldByName('ITE_DESF05').AsFloat,
          GetDataSetBases.FieldByName('ITE_DESF06').AsFloat);

        base := tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(Self.ItemBase));

        If Not(Assigned(base)) Then
        Begin
          base := tintaDeMaquina.Adicionar(TGenericTintaDeMaquinaComponente.Create
            (Self.ItemBase, TAutcomTintaFactory.Get.fRetNomProduto(Self.ItemBase),
            Self.fltBaseDespesasOperacionais, Self.fltBaseIcmsSaida,
            Self.fltBaseImpostosFederais, Self.fltBaseOutrosValores,
            Self.fltBasePrecoCusto, Self.fltBasePrecoCustoReal,
            Self.fltBasePrecoMedio, Self.fltBasePrecoVenda, 1,
            tmctBaseImobiliaria, Self.fltBasePrecoUltimaCompra,
            Self.fltImpostosUltimaCompraBase, Self.fltBasePrecoCompraLiquido));
        End;
      End;
    Except
      On E: Exception Do
        Raise;
    End;
  Finally

  End;
end;

procedure TFormulaImobiliariaAdvanceTintoSystem.CarregarPrecosBasesEmbalagem(
  const strCodigoEmbalagemBase: string);
Var
  base: ITintaDeMaquinaComponente;
  fltPreCusPro, fltPreVenPro: Double;
  fltPerAcr: Double;
  dicDados: IDicionario;
  strSQL: String;
  dataSetCalculo: IDataSet;
  strCodEmpresa: String;
  blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
begin
  tintaDeMaquina.Remover(tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(strCodigoEmbalagemBase)));
  Try
    Try
      fltPerAcr := TAutcomTintaFactory.Get.fGetConfTinta('ADT').fGetDouble('APREVE') / 100.0;
      strCodEmpresa := fVerificaEmpresaSetada();

      If dtsCadTin <> Nil Then
      Begin
        If Not GetDataSetBases.Locate('BAS_CODBAS;BAS_CODEMB;BAS_PRODUT', VarArrayOf([dtsCadTin.FieldByName('ADT_CODBAS').AsString,
          strCodigoEmbalagemBase, dtsCadTin.FieldByName('ADT_PRODUT').AsString]), []) Then
        Begin
          Raise Exception.CreateFmt('A bases %s - %s - %s não está cadastrada!',[dtsCadTin.FieldByName('ADT_CODBAS').AsString,
            strCodigoEmbalagemBase, dtsCadTin.FieldByName('ADT_PRODUT').AsString]);
        End;
      End;

      If Not TStrUtils.fEmptyStr(Self.ItemBase) And (Self.ItemBase <> Self.ItemBaseOriginal) Then
      Begin
        strSQL := ' SELECT          ' +
                  '     I.ITE_ITEATI  ' +
                  '   , I.ITE_CODITE  ' +
                  '   , ITE_OUTVAL    ' +
                  '   , ITE_ICMSAI    ' +
                  '   , ITE_IMPFED    ' +
                  '   , ITE_DESOPE    ' +
                  '   , ITE_PREMED    ' +
                  '   , ITE_PREULT    ' +
                  '   , ITE_IMPULT    ' +
                  '   , ITE_PRECOM    ' +
                  '   , ITE_DESF01    ' +
                  '   , ITE_DESF02    ' +
                  '   , ITE_DESF03    ' +
                  '   , ITE_DESF04    ' +
                  '   , ITE_DESF05    ' +
                  '   , ITE_DESF06    ';

        If TAutcomTintaFactory.Get.fCfgSis('IMPDIG') = '1' Then
          strSQL := strSQL + '   , I.ITE_IMPDIR  '
        else
          strSQL := strSQL + '   , G.ITE_IMPDIR  ';

        If (TAutcomTintaFactory.Get.fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO','0') = '1') And BlnCalculaUnitario Then
        Begin
          strSQL := strSQL + '   , ITE_PRECUS               ' +
                             '   , ITE_PREVE'+ TAutcomTintaFactory.Get.fArqIniTinta(0, 'GERAL','TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN ';
        End
        Else
        Begin
          strSQL := strSQL + '   , ITE_PRECUS               ' +
                             '   , ITE_PREVE'+ Self.strTabPre + ' AS ITE_PREVEN ';
        End;

        strSQL := strSQL +
          ' FROM                             ' +
          '   ITEGER G                       ' +
          ' INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ' +
          ' WHERE G.ITE_CODEMP = :CODEMP       ' +
        '   AND G.ITE_CODITE = :CODITE       ';

        dataSetCalculo := TAutcomTintaFactory.Get.fGetDataSet;
        dataSetCalculo.Close;
        dataSetCalculo.SQL := strSQL;

        If (Not TStrUtils.fEmptyStr(Self.EmpPrd)) And (Self.OprFlj = 'S') Then
          dataSetCalculo.ParamByName('CODEMP').AsString := Self.EmpPrd
        Else If (Not TStrUtils.fEmptyStr(Self.EmpCd_)) And (Self.CD_S_N = 'S') Then
          dataSetCalculo.ParamByName('CODEMP').AsString := Self.EmpCd_
        Else If (Not TStrUtils.fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
          dataSetCalculo.ParamByName('CODEMP').AsString := Self.EmpFat
        Else
          dataSetCalculo.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;

        dataSetCalculo.ParamByName('CODITE').AsString := Self.ItemBase;
        dataSetCalculo.Open;

        If (dataSetCalculo.FieldByName('ITE_ITEATI').AsString = 'N') Then
        begin
          raise ExceptionAutCom.CreateFmt('O produto Base %s não está ativo, Favor verificar!', [Self.ItemBase]);
        end;

        Self.ItemBase := dataSetCalculo.FieldByName('ITE_CODITE').AsString;
        Self.strCodigoEmbalagemBase := GetDataSetBases.FieldByName('BAS_CODEMB').AsString;
        Self.strEmbalagemBase := GetDataSetBases.FieldByName('EMB_DESCRI').AsString;
        Self.Unidade := GetDataSetBases.FieldByName('EMB_CODUNI').AsString;

        If TAutcomTintaFactory.Get.fCarregaPromocao(Self.ItemBase, strTabPre, strCodCli, strCodCnd, intPrzMed,
          fltPreCusPro, fltPreVenPro, blnPrecoFixoParaTintaDeMaquinaImobiliaria, strCodEmpresa) Then
        Begin
          Self.fltBasePrecoCusto := fltPreCusPro;
          Self.fltBasePrecoVenda := fltPreVenPro;
          Self.Promoc := 'S';

          If Self.fltBasePrecoCusto = 0 Then
            Self.fltBasePrecoCusto := dataSetCalculo.FieldByName('ITE_PRECUS').AsFloat;
        End
        Else
        Begin
          Self.fltBasePrecoCusto := dataSetCalculo.FieldByName('ITE_PRECUS').AsFloat;
          Self.fltBasePrecoVenda := dataSetCalculo.FieldByName('ITE_PREVEN').AsFloat;
        End;

        Self.fltBasePrecoVenda := Self.BasePrecoVenda * (1 + fltPerAcr);
        Self.fltBaseOutrosValores := dataSetCalculo.FieldByName('ITE_OUTVAL').AsFloat;
        Self.fltBaseIcmsSaida := dataSetCalculo.FieldByName('ITE_ICMSAI').AsFloat * Self.fltBasePrecoVenda / 100;
        Self.fltBaseImpostosFederais := dataSetCalculo.FieldByName('ITE_IMPFED').AsFloat * Self.fltBasePrecoVenda / 100;
        Self.fltBaseDespesasOperacionais := (((dataSetCalculo.FieldByName('ITE_DESOPE').AsFloat) * Self.fltBasePrecoVenda) / 100);
        Self.fltPesoEspecificoBase := GetDataSetBases.FieldByName('BAS_PESESP').AsFloat;

        dicDados := TAutcomTintaFactory.Get.GetDicionario;

        dicDados['preven'] := Self.fltBasePrecoVenda;
        dicDados['precus'] := Self.fltBasePrecoCusto;
        dicDados['outval'] := dataSetCalculo.FieldByName('ITE_OUTVAL').AsFloat;
        dicDados['icmsai'] := dataSetCalculo.FieldByName('ITE_ICMSAI').AsFloat;
        dicDados['impfed'] := dataSetCalculo.FieldByName('ITE_IMPFED').AsFloat;
        dicDados['desope'] := dataSetCalculo.FieldByName('ITE_DESOPE').AsFloat;

        Self.fltBasePrecoCustoReal := TAutcomTintaFactory.Get.fCalculaPrecoCusto2(dicDados);
        Self.fltPrecoMedioEmbalagem := dataSetCalculo.FieldByName('ITE_PREMED').AsFloat;
        Self.fltPrecoUltimaCompraEmbalagem := dataSetCalculo.FieldByName('ITE_PREULT').AsFloat;
        Self.fltImpostosUltimaCompraEmbalagem := dataSetCalculo.FieldByName('ITE_IMPULT').AsFloat;
        Self.fltPrecoCompraLiqEmbalagem := TAutcomTintaFactory.Get.fCalculaPrecoCompraLiq(
                                            dataSetCalculo.FieldByName('ITE_PRECOM').AsFloat,
                                            dataSetCalculo.FieldByName('ITE_DESF01').AsFloat,
                                            dataSetCalculo.FieldByName('ITE_DESF02').AsFloat,
                                            dataSetCalculo.FieldByName('ITE_DESF03').AsFloat,
                                            dataSetCalculo.FieldByName('ITE_DESF04').AsFloat,
                                            dataSetCalculo.FieldByName('ITE_DESF05').AsFloat,
                                            dataSetCalculo.FieldByName('ITE_DESF06').AsFloat);

        Base := tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(Self.ItemBase));

        If Not Assigned(Base) Then
        Begin
           base := tintaDeMaquina.Adicionar(TGenericTintaDeMaquinaComponente.Create(
            Self.ItemBase, TAutcomTintaFactory.Get.fRetNomProduto(Self.ItemBase), Self.fltBaseDespesasOperacionais, Self.fltBaseIcmsSaida,
            Self.fltBaseImpostosFederais, Self.fltBaseOutrosValores, Self.fltBasePrecoCusto, Self.fltBasePrecoCustoReal, Self.fltBasePrecoMedio, Self.fltBasePrecoVenda,
            1, tmctBaseImobiliaria, Self.fltBasePrecoUltimaCompra, Self.fltBasePrecoUltimaCompraImpostos, Self.fltBasePrecoCompraLiquido));
        End;
      End
      Else
      Begin

        Self.ItemBase := GetDataSetBases.FieldByName('BAS_CODITE').AsString;
        Self.strCodigoEmbalagemBase := GetDataSetBases.FieldByName('BAS_CODEMB').AsString;
        Self.strEmbalagemBase := GetDataSetBases.FieldByName('EMB_DESCRI').AsString;
        Self.Unidade := GetDataSetBases.FieldByName('EMB_CODUNI').AsString;

        If TAutcomTintaFactory.Get.fCarregaPromocao(Self.ItemBase, strTabPre, strCodCli, strCodCnd, intPrzMed,
          fltPreCusPro, fltPreVenPro, blnPrecoFixoParaTintaDeMaquinaImobiliaria, strCodEmpresa) Then
        Begin
          Self.fltBasePrecoCusto := fltPreCusPro;
          Self.fltBasePrecoVenda := fltPreVenPro;
          Self.Promoc := 'S';

          If Self.fltBasePrecoCusto = 0 Then
            Self.fltBasePrecoCusto := GetDataSetBases.FieldByName('ITE_PRECUS').AsFloat;
        End
        Else
        Begin
          Self.fltBasePrecoCusto := GetDataSetBases.FieldByName('ITE_PRECUS').AsFloat;
          Self.fltBasePrecoVenda := GetDataSetBases.FieldByName('ITE_PREVEN').AsFloat;
        End;

        Self.fltBasePrecoVenda := Self.BasePrecoVenda * (1 + fltPerAcr);
        Self.fltBaseOutrosValores := GetDataSetBases.FieldByName('ITE_OUTVAL').AsFloat;
        Self.fltBaseIcmsSaida := GetDataSetBases.FieldByName('ITE_ICMSAI').AsFloat * Self.fltBasePrecoVenda / 100;
        Self.fltBaseImpostosFederais := GetDataSetBases.FieldByName('ITE_IMPFED').AsFloat * Self.fltBasePrecoVenda / 100;
        Self.fltBaseDespesasOperacionais := (((GetDataSetBases.FieldByName('ITE_DESOPE').AsFloat) * Self.fltBasePrecoVenda) / 100);
        Self.fltPesoEspecificoBase := GetDataSetBases.FieldByName('BAS_PESESP').AsFloat;

        dicDados := TAutcomTintaFactory.Get.GetDicionario;

        dicDados['preven'] := Self.fltBasePrecoVenda;
        dicDados['precus'] := Self.fltBasePrecoCusto;
        dicDados['outval'] := GetDataSetBases.FieldByName('ITE_OUTVAL').AsFloat;
        dicDados['icmsai'] := GetDataSetBases.FieldByName('ITE_ICMSAI').AsFloat;
        dicDados['impfed'] := GetDataSetBases.FieldByName('ITE_IMPFED').AsFloat;
        dicDados['desope'] := GetDataSetBases.FieldByName('ITE_DESOPE').AsFloat;

        Self.fltBasePrecoCustoReal := TAutcomTintaFactory.Get.fCalculaPrecoCusto2(dicDados);
        Self.fltPrecoMedioEmbalagem := GetDataSetBases.FieldByName('ITE_PREMED').AsFloat;
        Self.fltPrecoUltimaCompraEmbalagem := GetDataSetBases.FieldByName('ITE_PREULT').AsFloat;
        Self.fltImpostosUltimaCompraEmbalagem := GetDataSetBases.FieldByName('ITE_IMPULT').AsFloat;
        Self.fltPrecoCompraLiqEmbalagem := TAutcomTintaFactory.Get.fCalculaPrecoCompraLiq(
                                            GetDataSetBases.FieldByName('ITE_PRECOM').AsFloat,
                                            GetDataSetBases.FieldByName('ITE_DESF01').AsFloat,
                                            GetDataSetBases.FieldByName('ITE_DESF02').AsFloat,
                                            GetDataSetBases.FieldByName('ITE_DESF03').AsFloat,
                                            GetDataSetBases.FieldByName('ITE_DESF04').AsFloat,
                                            GetDataSetBases.FieldByName('ITE_DESF05').AsFloat,
                                            GetDataSetBases.FieldByName('ITE_DESF06').AsFloat);

        Base := tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(Self.ItemBase));

        If Not Assigned(Base) Then
        Begin
           base := tintaDeMaquina.Adicionar(TGenericTintaDeMaquinaComponente.Create(
            Self.ItemBase, TAutcomTintaFactory.Get.fRetNomProduto(Self.ItemBase), Self.fltBaseDespesasOperacionais, Self.fltBaseIcmsSaida,
            Self.fltBaseImpostosFederais, Self.fltBaseOutrosValores, Self.fltBasePrecoCusto, Self.fltBasePrecoCustoReal, Self.fltBasePrecoMedio, Self.fltBasePrecoVenda,
            1, tmctBaseImobiliaria, Self.fltBasePrecoUltimaCompra, Self.fltBasePrecoUltimaCompraImpostos, Self.fltBasePrecoCompraLiquido));
        End;
      End;
    Except
      On E: Exception Do
        Raise;
    End;
  Finally

  End;
end;

function TFormulaImobiliariaAdvanceTintoSystem.
  fMostrarFormulacaoIndustrial: Boolean;
begin
  Result := True;
end;

function TFormulaImobiliariaAdvanceTintoSystem.GetCalculadorInterno
  : ICalculadorFormulaImobiliaria;
begin
  Result := TAbstractCalculadorFormulaImobiliaria.Create(Self);
end;

function TFormulaImobiliariaAdvanceTintoSystem.GetChaveIteTin(const dtsCadTin
  : IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('ADT_MD5KEY').AsString
end;

function TFormulaImobiliariaAdvanceTintoSystem.
  GetCodigoProdutoEmbalagem: string;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('ADT').fGet('EMBGRA');
end;

function TFormulaImobiliariaAdvanceTintoSystem.GetDescricao(const dtsCadTin
  : IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('ADT_IDFORM').AsString + ' ' +
            dtsCadTin.FieldByName('ADT_CODCOR').AsString + ' ' +
            dtsCadTin.FieldByName('ADT_CODTEC').AsString + ' ' +
            dtsCadTin.FieldByName('ADT_PRODUT').AsString + ' ' +
            dtsCadTin.FieldByName('EMB_DESCRI').AsString;
end;

procedure TFormulaImobiliariaAdvanceTintoSystem.GetEmbalagensDisponivels
  (const dicEmbalagens, dicCodigosEmbalagens, dicProdutosBase: IDicionario);
Var
  qryGen: IDataSet;
begin
  Try
    Try

      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := ' SELECT                                               ' +
        '   ADT_QTDFIN * BAS_CONTEU / ADT_QTDBAS AS ADT_QTDFIN ' +
        '   , EMB_CODEMB                                       ' +
        '   , EMB_DESCRI                                       ' +
        '   , BAS_CODITE                                       ' +
        ' FROM                                                 ' +
        '   ADT_CADADT                                         ' +
        '   INNER JOIN ADT_CADBAS                              ' +
        '     ON ADT_CODBAS = BAS_CODBAS                       ' +
        '     AND ADT_PRODUT = BAS_PRODUT                      ' +
        '   INNER JOIN ADT_CADEMB                              ' +
        '     ON BAS_CODEMB = EMB_CODEMB                       ' +
        ' WHERE ADT_MD5KEY = :MD5KEY                           ';

      qryGen.ParamByName('MD5KEY').AsString :=
        dtsCadTin.FieldByName('ADT_MD5KEY').AsString;

      qryGen.Open;

      While Not qryGen.Eof Do
      Begin
        dicEmbalagens[qryGen.FieldByName('EMB_DESCRI').AsString] := qryGen.FieldByName('ADT_QTDFIN').AsFloat;
        dicCodigosEmbalagens[qryGen.FieldByName('EMB_DESCRI').AsString] := qryGen.FieldByName('EMB_CODEMB').AsString;
        dicProdutosBase[qryGen.FieldByName('EMB_DESCRI').AsString] := qryGen.FieldByName('BAS_CODITE').AsString;
        Self.DescEmbalagem.Add(qryGen.FieldByName('EMB_DESCRI').AsString);
        qryGen.Next;
      End;

      Self.MaxEmbalagem := qryGen.RecordCount;

    Except
      On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally

  End;
end;

function TFormulaImobiliariaAdvanceTintoSystem.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaImobiliariaAdvanceTintoSystem.GetIdePro: String;
begin
  Result := 'ADT';
end;

function TFormulaImobiliariaAdvanceTintoSystem.GetItemBaseOriginal
  (const strIteTin: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := ' SELECT                                ' +
        '   B.BAS_CODITE AS CODITE              ' +
        ' FROM                                  ' +
        '   ADT_CADBAS B                     ' +
        '   INNER JOIN ADT_CADADT S          ' +
        '      ON B.BAS_CODBAS = S.ADT_CODBAS   ' +
        '     AND B.BAS_PRODUT = S.ADT_PRODUT   ' +
        '   WHERE S.ADT_MD5KEY = :ITETIN        ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      If qryGen.IsEmpty Then
      Begin
        qryGen.SQL := ' SELECT                              ' +
          '   B.BAS_CODITE AS CODITE            ' +
          ' FROM                                ' +
          '   ADT_CADADT C                   ' +
          '   INNER JOIN ADT_CADBAS B        ' +
          '     ON C.ADT_CODBAS = B.BAS_CODBAS  ' +
          '     AND C.ADT_PRODUT = B.BAS_PRODUT ' +
          ' WHERE CONCAT(                       ' +
          '     IFNULL(C.ADT_IDFORM, '''')      ' +
          '     , IFNULL(C.ADT_CODCOR, '''')    ' +
          '     , IFNULL(C.ADT_CODTEC, '''')    ' +
          '     , IFNULL(C.ADT_PRODUT, '''')    ' +
          '     , IFNULL(C.ADT_CODBAS, '''')    ' +
          '     , IFNULL(C.ADT_CODEMB, '''')    ' +
          '     , IFNULL(C.ADT_CODCAT, '''')    ' +
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

function TFormulaImobiliariaAdvanceTintoSystem.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaImobiliariaAdvanceTintoSystem.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaImobiliariaAdvanceTintoSystem.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaImobiliariaAdvanceTintoSystem.GetNomeTabelaBase: String;
begin
  Result := 'ADT_CADBAS';
end;

function TFormulaImobiliariaAdvanceTintoSystem.GetNomeCampoColDesCol: string;
begin
  Result := 'COL_DESCRI';
end;

function TFormulaImobiliariaAdvanceTintoSystem.GetNomeTabelaColorantes: String;
begin
  Result := 'ADT_CADCOL';
end;

function TFormulaImobiliariaAdvanceTintoSystem.GetPrefixoFormulacao: String;
begin
  Result := 'ADT_CODC';
end;

function TFormulaImobiliariaAdvanceTintoSystem.
  GetPrefixoFormulacaoCatalisador: String;
begin
  Result := 'ADT_CODCAT';
end;

function TFormulaImobiliariaAdvanceTintoSystem.GetPrefixoQuantidade
  (const strModo: String): String;
begin
  Result := 'ADT_QTDC';
end;

function TFormulaImobiliariaAdvanceTintoSystem.
  GetPrefixoQuantidadeCatalisador: String;
begin
  Result := 'ADT_QTDCAT';
end;

function TFormulaImobiliariaAdvanceTintoSystem.GetProdutoBaseFormula
  (const dtsCadTin: IDataSet): String;
var
  dtsGen: IDataSet;
begin
  Try
    Try
      dtsGen := TAutcomTintaFactory.Get.fGetDataSet;
      dtsGen.SQL := ' SELECT                     ' +
        '   BAS_CODITE               ' + ' FROM                       ' +
        '   ADT_CADBAS               ' + ' WHERE BAS_CODBAS = :CODBAS ' +
        '   AND BAS_CODEMB = :CODEMB ' + '   AND BAS_PRODUT = :DESCRI ';

      dtsGen.ParamByName('CODBAS').AsString := dtsCadTin.FieldByName('ADT_CODBAS').AsString;
      dtsGen.ParamByName('CODEMB').AsString := dtsCadTin.FieldByName('ADT_CODEMB').AsString;
      dtsGen.ParamByName('DESCRI').AsString := dtsCadTin.FieldByName('ADT_PRODUT').AsString;
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

function TFormulaImobiliariaAdvanceTintoSystem.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaImobiliariaAdvanceTintoSystem.GetSaldos: ISaldosColorantes;
Var
  intContador: Integer;
  Saldos: TGenericSaldosColorantes;
  colorante: TColorante;
  fltQtdFormul: Double;
begin
  Saldos := TGenericSaldosColorantes.Create();

  For intContador := 0 To Self.Count - 1 Do
  Begin
    colorante := TColorante(Self.Items[intContador]);
    If GetDataSetColorantes.Locate('COL_CODCOL',
      colorante.CodigoColorante, []) Then
    Begin
      fltQtdFormul := colorante.Quantidade * GetDataSetColorantes.FieldByName
        ('COL_PESESP').AsFloat;

      If fltQtdFormul > 0 Then
      Begin
        Saldos.Adicionar(TGenericSaldoColorante.Create(1, Descricao,
          GetDataSetColorantes.FieldByName('COL_CODITE').AsString,
          VarToStrDef(TAutcomTintaFactory.Get.GetValorCampo
          ('SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE',
          'ITE_DESITE', [GetDataSetColorantes.FieldByName('COL_CODITE')
          .AsString]), ''), colorante.CodigoColorante, fltQtdFormul,
          COLORANTE_IMOBILIARIO, 'N', 0.00));

      End;
    End
    Else If (colorante.Tipo = tciCatalisador) And (Self.TemCatalisador) And
      (Self.UsaCatalisador) Then
    Begin
      If GetDataSetBases.Locate('BAS_CODBAS;BAS_CODEMB',
        VarArrayOf([colorante.CodigoColorante, Self.strCodigoEmbalagemBase]
        ), []) Then
      Begin
        fltQtdFormul := colorante.Quantidade * GetDataSetBases.FieldByName
          ('BAS_PESESP').AsFloat;

        If fltQtdFormul > 0 Then
        Begin
          Saldos.Adicionar(TGenericSaldoColorante.Create(1, Descricao,
            GetDataSetBases.FieldByName('BAS_CODITE').AsString,
            VarToStrDef(TAutcomTintaFactory.Get.GetValorCampo
            ('SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE',
            'ITE_DESITE', [GetDataSetBases.FieldByName('BAS_CODITE').AsString]),
            ''), colorante.CodigoColorante, fltQtdFormul, CATALISADOR,
            'N', 0.00));
        End;
      End;
    End;
  End;

  If (ItemBase) <> (ItemBaseOriginal) Then
  Begin
      Saldos.Adicionar(TGenericSaldoColorante.Create(1, Descricao, ItemBase,
        VarToStrDef(TAutcomTintaFactory.Get.GetValorCampo
        ('SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE',
        'ITE_DESITE', [ItemBase]), ''), ItemBase, 1, BASE_IMOBILIARIA,
        'N', 0.00));
  End
  Else
  Begin
      Saldos.Adicionar(TGenericSaldoColorante.Create(1, Descricao,
        ItemBaseOriginal, VarToStrDef(TAutcomTintaFactory.Get.GetValorCampo
        ('SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE',
        'ITE_DESITE', [ItemBaseOriginal]), ''), ItemBaseOriginal, 1,
        BASE_IMOBILIARIA, 'N', 0.00));
   End;

  Result := Saldos;

end;

function TFormulaImobiliariaAdvanceTintoSystem.GetTemCatalisador(): Boolean;
Var
  intContador: Integer;
begin
  Result := False;
  For intContador := 0 To Self.Count - 1 Do
  Begin
    If TColorante(Self.Items[intContador]).Tipo = tciCatalisador Then
    Begin
      Result := True;
      Exit;
    End;
  End;
end;

function TFormulaImobiliariaAdvanceTintoSystem.
  GetTextoInformativoCalculo: String;
begin
  Result := 'Valor da Base = ' + FloatToStrF(BasePrecoVenda, ffFixed, 12, 2) +
    sLineBreak + 'Valor do Colorante = (Quantidade) * (Preço / Embalagem) ' +
    sLineBreak +
    'Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)';
end;

function TFormulaImobiliariaAdvanceTintoSystem.GetUnidade(const dtsCadTin
  : IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('ADT_CODEMB').AsString
end;

function TFormulaImobiliariaAdvanceTintoSystem.GetUsaCatalisador(const dtsCadTin
  : IDataSet): Boolean;
begin
  Result := dtsCadTin.FieldByName('ADT_QTDCAT').AsFloat > 0;
end;

function TFormulaImobiliariaAdvanceTintoSystem.GetVolumeBaseOriginal
  (const dtsCadTin: IDataSet): Double;
begin
  Result := 1;
  Try
    Result := dtsCadTin.FieldByName('ADT_QTDBAS').AsFloat;
  Except
    On E: Exception Do
    Begin
      TAutcomTintaFactory.Get.fMensagem('', E.Message, ['&Ok']);
    End;
  End;
end;

function TFormulaImobiliariaAdvanceTintoSystem.GetVolumeColoranteOriginal
  (const dtsCadTin: IDataSet): Double;
begin
  Result := dtsCadTin.FieldByName('ADT_QTD_ML').AsFloat +  dtsCadTin.FieldByName('ADT_QTDCAT').AsFloat;
end;

function TFormulaImobiliariaAdvanceTintoSystem.GetVolumeOriginal(const dtsCadTin
  : IDataSet): Double;
begin
  Result := dtsCadTin.FieldByName('ADT_QTDFIN').AsFloat;
end;

procedure TFormulaImobiliariaAdvanceTintoSystem.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('ADT_ACRMOB').AsFloat;
end;

end.
