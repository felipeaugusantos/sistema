unit untFormulaAdvanceIndustrial;

interface

uses
  untFormulaIndustrial, Uni, untFuncoesSimples,
  UniClientDataSet, SysUtils, Variants, Classes, StrUtils;

type
  TFormulaAdvanceIndustrial = class(TFormulaIndustrial)
  private
    strDescricao: string;
    fltPerAcr: Double;
  protected
    function GetTextoCalculo(): string; override;
    function GetDescricao(): String; override;
    procedure CarregarBases; override;
    procedure CarregarComponentes; override;
    function GetCodigoProdutoEmbalagem(): string; override;
  public
    constructor Create(const strTabPre: string;
      const cdsTinta: TUniClientDataSet); override;
    procedure CalcularPrecos; override;
    procedure GetEmbalagensDisponivels(const dicEmbalagens: TDicionario;
      const dicCodigosEmbalagens: TDicionario;
      const dicProdutosBase: TDicionario); override;
    procedure CarregarPrecosBases; override;
    procedure CarregarPrecosBasesEmbalagem(const strCodigoEmbalagemBase
      : string); override;
    procedure CarregarPrecos; override;
    function GetCodigoProdutoVendaEmbalagem(): string; override;
  end;

implementation

uses
  untTintaMaquina, untClientDataSetFactory, untIConfTinta,
    untGenericTintaDeMaquinaComponente, untITintaDeMaquinaComponente,
    untTintaDeMaquinaComponenteTipo, untTintaDeMaquinaComponenteComparerColorante,
    untTintaDeMaquinaComponenteComparerBaseImobiliaria;

{ TFormulaAdvanceIndustrial }

procedure TFormulaAdvanceIndustrial.CalcularPrecos;
var
  intForm: Integer;
  componente: TComponenteIndustrial;
  cdsComponentes: TUniClientDataSet;
  fltVendaComponente: Double;
  fltEmbalagem: Double;
  fltQuantidade: Double;
  cdsBases: TUniClientDataSet;
  TintaDeMaquinaComponente: ITintaDeMaquinaComponente;
begin
  ZerarPrecos;
  Try
    Try
      CarregarPrecos;
      CarregarPrecosBases;
      CarregarPrecosEmbalagem;

      cdsComponentes := TClientDataSetFactory.GetClientDataSet(qryComponentes);
      cdsBases := TClientDataSetFactory.GetClientDataSet(qryBases);

      for intForm := 0 to Self.Count - 1 do
      begin
        componente := TComponenteIndustrial(Self.Items[intForm]);
        if (not UsaCatalisador) and (componente.Tipo = tciCatalisador) then
          Continue;

        // Se for base e nao for volume personalizado, passa
        if (not blnPersonalizada) and (componente.Tipo = tciBase) then
          Continue;

        If componente.Tipo = tciCatalisador Then
        Begin
          if not cdsBases.Locate('BAS_CODBAS;BAS_CODEMB',
            VarArrayOf([componente.CodigoComponente,
            cdsTinta.FieldByName('ADT_CODEMB').AsString]), []) then
            raise Exception.CreateFmt
              ('O Catalisador %s não está cadastrado! Verificar!',
              [componente.CodigoComponente]);

          if fEmptyStr(cdsBases.FieldByName('BAS_CODITE').AsString) then
            raise Exception.CreateFmt
              ('O Catalisador %s não está com o produto de venda associado! Verificar!',
              [componente.CodigoComponente]);
        End
        Else
        Begin
          if not cdsComponentes.Locate('COL_CODCOL',
            componente.CodigoComponente, []) then
            raise Exception.CreateFmt
              ('O ' + IfThen(componente.Tipo = tciColorante, 'Colorante',
              'Catalisador') + ' %s não está cadastrado! Verificar!',
              [componente.CodigoComponente]);

          if fEmptyStr(cdsComponentes.FieldByName('COL_CODITE').AsString) then
            raise Exception.CreateFmt
              ('O ' + IfThen(componente.Tipo = tciColorante, 'Colorante',
              'Catalisador') +
              ' %s não está com o produto de venda associado! Verificar!',
              [componente.CodigoComponente]);

          if cdsComponentes.FieldByName('ITE_CNV_ML').AsFloat <= 0 then
            raise Exception.CreateFmt
              ('O produto %s não está com o fator tintométrico preenchido! Verificar!',
              [cdsComponentes.FieldByName('COL_CODITE').AsString]);
        End;

        TintaDeMaquinaComponente := tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerColorante.Create(componente.CodigoComponente));
        if not Assigned(TintaDeMaquinaComponente) then
        begin
          TintaDeMaquinaComponente := tintaDeMaquina.Adicionar(TGenericTintaDeMaquinaComponente.Create(
            IIF(componente.Tipo = tciCatalisador, cdsBases.FieldByName('BAS_CODITE').AsString, cdsComponentes.FieldByName('COL_CODITE').AsString), componente.CodigoComponente, tmctColoranteImobiliario));
        end;

        fltEmbalagem := componente.Embalagem;
        if componente.Tipo = tciCatalisador then
          fltEmbalagem := 1;

        fltQuantidade := componente.Quantidade;
        if componente.Tipo = tciCatalisador then
          fltQuantidade := 1;

        fltVendaComponente := fltQuantidade * componente.PrecoVenda / fltEmbalagem;

        TintaDeMaquinaComponente.Quantidade                := fltQuantidade;
        TintaDeMaquinaComponente.PrecoCusto                := fltQuantidade * componente.PrecoCusto / fltEmbalagem;
        TintaDeMaquinaComponente.PrecoCustoReal            := fltQuantidade * componente.PrecoCustoReal / fltEmbalagem;
        TintaDeMaquinaComponente.PrecoVenda                := fltVendaComponente;

        TintaDeMaquinaComponente.OutrosValores             := (fltQuantidade * (componente.OutrosValores / fltEmbalagem));
        TintaDeMaquinaComponente.IcmsSaida                 := (fltVendaComponente * (componente.IcmSaida / 100));
        TintaDeMaquinaComponente.ImpostosFederais          := (fltVendaComponente * (componente.ImpostosFederais / 100));
        TintaDeMaquinaComponente.DespesasOperacionais      := (fltVendaComponente * (componente.DespesasOperacionais / 100));

        TintaDeMaquinaComponente.PrecoMedio                := (fltQuantidade * (componente.PrecoMedio  / fltEmbalagem));
        TintaDeMaquinaComponente.UltimoPrecoCompra         := (fltQuantidade * (componente.UltimaCompra / fltEmbalagem));
        TintaDeMaquinaComponente.UltimoPrecoCompraImpostos := (fltQuantidade * (componente.ImpostosUltimaCompra / fltEmbalagem));
        TintaDeMaquinaComponente.PrecoCompraLiquido        := (fltQuantidade * (componente.CompraLiquido / fltEmbalagem));

        If componente.StrPromoc = 'S' Then
          FPromoc := 'S';
{
        fltEmbalagem := componente.Embalagem;
        if componente.Tipo = tciCatalisador then
          fltEmbalagem := 1;

        fltQuantidade := componente.Quantidade;
        if componente.Tipo = tciCatalisador then
          fltQuantidade := 1;

        fltVendaComponente := fltQuantidade * componente.PrecoVenda /
          fltEmbalagem;

        fltPrecoCustoComponentes := fltPrecoCustoComponentes + fltQuantidade *
          componente.PrecoCusto / fltEmbalagem;
        fltPrecoCustoRealComponentes := fltPrecoCustoRealComponentes +
          fltQuantidade * componente.PrecoCustoReal / fltEmbalagem;

        fltPrecoVendaComponentes := fltPrecoVendaComponentes +
          fltVendaComponente;
        fltOutrosValoresComponentes := fltOutrosValoresComponentes +
          fltQuantidade * componente.OutrosValores / fltEmbalagem;
        fltIcmSaidaComponentes := fltIcmSaidaComponentes +
          (fltVendaComponente * (componente.IcmSaida / 100));
        fltImpostosFederaisComponentes := fltImpostosFederaisComponentes +
          (fltVendaComponente * (componente.ImpostosFederais / 100));
        fltDespesasOperacionaisComponentes := fltDespesasOperacionaisComponentes
          + (fltVendaComponente * (componente.DespesasOperacionais / 100));

        fltPrecoMedioComponentes := fltPrecoMedioComponentes +
          (fltQuantidade * (componente.PrecoMedio / fltEmbalagem));
        fltPrecoUltimaCompraComponentes := fltPrecoUltimaCompraComponentes +
          (fltQuantidade * (componente.UltimaCompra / fltEmbalagem));
        fltImpostosUltimaCompraComponentes := fltImpostosUltimaCompraComponentes
          + (fltQuantidade * (componente.ImpostosUltimaCompra / fltEmbalagem));
        fltPrecoCompraLiqComponentes := fltPrecoCompraLiqComponentes +
          (fltQuantidade * (componente.CompraLiquido / fltEmbalagem));
 }
      end;

      fltPrecoCustoComponentes           := tintaDeMaquina.GetPrecoCustoComponentes;
      fltPrecoCustoRealComponentes       := tintaDeMaquina.GetPrecoCustoRealComponentes;
      fltPrecoVendaComponentes           := tintaDeMaquina.GetPrecoVendaComponentes;

      fltOutrosValoresComponentes        := tintaDeMaquina.GetOutrosValoresComponentes;
      fltIcmSaidaComponentes             := tintaDeMaquina.GetIcmsSaidaComponentes;
      fltImpostosFederaisComponentes     := tintaDeMaquina.GetImpostosFederaisComponentes;
      fltDespesasOperacionaisComponentes := tintaDeMaquina.GetDespesasOperacionaisComponentes;

      fltPrecoMedioComponentes           := tintaDeMaquina.GetPrecoMedioComponentes;
      fltPrecoUltimaCompraComponentes    := tintaDeMaquina.GetUltimoPrecoCompraComponentes;
      fltImpostosUltimaCompraComponentes := tintaDeMaquina.GetUltimoPrecoCompraImpostosComponentes;
      fltPrecoCompraLiqComponentes       := tintaDeMaquina.GetPrecoCompraLiquidoComponentes;

      fltPrecoVendaComponentes           := fltPrecoVendaComponentes + (fltPerAcr * fltPrecoVendaComponentes);

{
      fltPrecoVendaComponentes := fltPrecoVendaComponentes +
        (fltPerAcr * fltPrecoVendaComponentes);
}

    Except
      on E: Exception do
      begin
        ZerarPrecos;
        fMensagem('ATENÇÃO!', E.Message, ['OK']);
        Abort;
      end;
    End;
  Finally
  End;
end;

procedure TFormulaAdvanceIndustrial.CarregarBases;
begin
  qryBases.Close;
  qryBases.SQL.Clear;
  qryBases.SQL.Add(' SELECT         ' + '   BAS_CODEMP   ' + '   , BAS_CODBAS '
    + '   , BAS_CODEMB ' + '   , BAS_PRODUT ' + '   , BAS_DESCRI ' +
    '   , BAS_PESESP ' + '   , EMB_DESCRI ' + '   , EMB_CODUNI ' +
    '   , BAS_CODITE ' + '   , ITE_CNV_ML ' + '   , ITE_OUTVAL ' +
    '   , ITE_ICMSAI ' + '   , ITE_IMPFED ' + '   , ITE_DESOPE ' +

    '   , ITE_PREULT ' + '   , ITE_IMPULT ' + '   , ITE_PREMED ' +

    '   , ITE_PRECOM ' + '   , ITE_DESF01 ' + '   , ITE_DESF02 ' +
    '   , ITE_DESF03 ' + '   , ITE_DESF04 ' + '   , ITE_DESF05 ' +
    '   , ITE_DESF06 ');

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  begin
    qryBases.SQL.Add('   , BAS_PRECUS AS ITE_PRECUS ' +
      '   , BAS_PREVEN AS ITE_PREVEN ');
  end
  Else If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') And FBlnCalculaUnitario Then
  begin
    qryBases.SQL.Add('   , ITE_PRECUS ' + '   , ITE_PREVE' + fArqIniTinta(0,
      'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN ');
  end
  else
  begin
    qryBases.SQL.Add('   , ITE_PRECUS ' + '   , ITE_PREVE' + strTabPre +
      ' AS ITE_PREVEN ');
  end;

  qryBases.SQL.Add(' FROM                           ' +
    '   ADT_CADBAS                   ' + '   LEFT JOIN ADT_CADEMB         ' +
    '     ON BAS_CODEMB = EMB_CODEMB ' + '   LEFT JOIN CADITE I             ' +
    '     ON BAS_CODITE = I.ITE_CODITE ' +
    '   LEFT JOIN ITEGER G               ' +
    '     ON I.ITE_CODITE = G.ITE_CODITE ' +
    '     AND G.ITE_CODEMP = :CODEMP   ');

  qryBases.ParamByName('CODEMP').AsString := VS_strCodEmp;
end;

procedure TFormulaAdvanceIndustrial.CarregarComponentes;
begin
  qryComponentes.Close;
  qryComponentes.SQL.Clear;
  qryComponentes.SQL.Add(' SELECT                         ' +
    '   COL_CODEMP                   ' + '   , COL_CODCOL                 ' +
    '   , COL_EMBALA                 ' + '   , COL_DESCRI                 ' +
    '   , COL_PESESP                 ' + '   , COL_CODITE                 ');

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
    qryComponentes.SQL.Add('   , COL_PRECUS AS ITE_PRECUS   ' +
      '   , COL_PREVEN AS ITE_PREVEN   ')
  Else If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') And FBlnCalculaUnitario Then
    qryComponentes.SQL.Add('   , ITE_PRECUS ' + '   , ITE_PREVE' +
      fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN ')
  else
    qryComponentes.SQL.Add('   , ITE_PRECUS ' + '   , ITE_PREVE' + strTabPre +
      ' AS ITE_PREVEN ');

  qryComponentes.SQL.Add('   , ITE_OUTVAL                 ' +
    '   , ITE_ICMSAI                 ' + '   , ITE_IMPFED                 ' +
    '   , ITE_DESOPE                 ' + '   , ITE_CNV_ML                 ' +

    '   , ITE_PREULT                 ' + '   , ITE_IMPULT                 ' +
    '   , ITE_PREMED                 ' +

    '   , ITE_PRECOM                 ' + '   , ITE_DESF01                 ' +
    '   , ITE_DESF02                 ' + '   , ITE_DESF03                 ' +
    '   , ITE_DESF04                 ' + '   , ITE_DESF05                 ' +
    '   , ITE_DESF06                 ' + ' FROM                               '
    + '   ADT_CADCOL                       ' +
    '   LEFT JOIN CADITE I               ' +
    '     ON COL_CODITE = I.ITE_CODITE   ' +
    '   LEFT JOIN ITEGER G               ' +
    '     ON I.ITE_CODITE = G.ITE_CODITE ' +
    '     AND G.ITE_CODEMP = :CODEMP     ');
  qryComponentes.ParamByName('CODEMP').AsString := VS_strCodEmp;
end;

procedure TFormulaAdvanceIndustrial.CarregarPrecos;
var
  intCont: Integer;
  cdsComponentes: TUniClientDataSet;
  componente: TComponenteIndustrial;
  cdsBases: TUniClientDataSet;
  conf: IConfTinta;
  fltDesOpeTinta: Double;
  fltPreCusPro, fltPreVenPro: Double;
begin
  conf := fGetConfTinta('ADT');
  fltDesOpeTinta := conf.fGetDouble('DESOPE');
  cdsComponentes := TClientDataSetFactory.GetClientDataSet(qryComponentes);
  cdsBases := TClientDataSetFactory.GetClientDataSet(qryBases);

  for intCont := 0 to Self.Count - 1 do
  begin
    componente := TComponenteIndustrial(Items[intCont]);

    If componente.Tipo = tciCatalisador Then
    Begin
      if not cdsBases.Locate('BAS_CODBAS;BAS_CODEMB',
        VarArrayOf([componente.CodigoComponente,
        cdsTinta.FieldByName('ADT_CODEMB').AsString]), []) then
        raise Exception.CreateFmt('O Catalisador %s não está cadastrado!',
          [componente.CodigoComponente]);
    End
    Else
    Begin
      if not cdsComponentes.Locate('COL_CODCOL', componente.CodigoComponente, [])
      then
        raise Exception.CreateFmt('O ' + IfThen(componente.Tipo = tciColorante,
          'Colorante', 'Catalisador') + ' %s não está cadastrado!',
          [componente.CodigoComponente]);
    End;

    If fCarregaPromocao(IIF(componente.Tipo = tciCatalisador,
                            cdsBases.FieldByName('BAS_CODITE').AsString,
                            cdsComponentes.FieldByName('COL_CODITE').AsString),
                            fTabPreco, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
    Begin
      componente.PrecoCusto := fltPreCusPro;
      componente.PrecoVenda := fltPreVenPro;
      componente.StrPromoc  := 'S';

      If componente.PrecoCusto = 0 Then
        componente.PrecoCusto := IIF(componente.Tipo = tciCatalisador,
                                    cdsBases.FieldByName('ITE_PRECUS').AsFloat,
                                    cdsComponentes.FieldByName('ITE_PRECUS').AsFloat);
    End
    Else
    Begin
      componente.PrecoCusto := IIF(componente.Tipo = tciCatalisador,
                                   cdsBases.FieldByName('ITE_PRECUS').AsFloat,
                                   cdsComponentes.FieldByName('ITE_PRECUS').AsFloat);

      componente.PrecoVenda := IIF(componente.Tipo = tciCatalisador,
                                   cdsBases.FieldByName('ITE_PREVEN').AsFloat,
                                   cdsComponentes.FieldByName('ITE_PREVEN').AsFloat);
      componente.StrPromoc  := 'N';
    End;

    If componente.Tipo = tciCatalisador Then
    Begin
//      componente.PrecoVenda := cdsBases.FieldByName('ITE_PREVEN').AsFloat;
//      componente.PrecoCusto := cdsBases.FieldByName('ITE_PRECUS').AsFloat;
      componente.OutrosValores := cdsBases.FieldByName('ITE_OUTVAL').AsFloat;
      componente.IcmSaida := cdsBases.FieldByName('ITE_ICMSAI').AsFloat;
      componente.ImpostosFederais := cdsBases.FieldByName('ITE_IMPFED').AsFloat;
      componente.DespesasOperacionais := cdsBases.FieldByName('ITE_DESOPE')
        .AsFloat + fltDesOpeTinta;
      componente.PesoEspecifico := cdsBases.FieldByName('BAS_PESESP').AsFloat;
      componente.Embalagem := 0;

      componente.PrecoMedio := cdsBases.FieldByName('ITE_PREMED').AsFloat;
      componente.UltimaCompra := cdsBases.FieldByName('ITE_PREULT').AsFloat;
      componente.ImpostosUltimaCompra :=
        cdsBases.FieldByName('ITE_IMPULT').AsFloat;
      componente.CompraLiquido := fCalculaPrecoCompraLiq
        (cdsBases.FieldByName('ITE_PRECOM').AsFloat,
        cdsBases.FieldByName('ITE_DESF01').AsFloat,
        cdsBases.FieldByName('ITE_DESF02').AsFloat,
        cdsBases.FieldByName('ITE_DESF03').AsFloat,
        cdsBases.FieldByName('ITE_DESF04').AsFloat,
        cdsBases.FieldByName('ITE_DESF05').AsFloat,
        cdsBases.FieldByName('ITE_DESF06').AsFloat);
    End
    Else
    Begin
      //componente.PrecoVenda := cdsComponentes.FieldByName('ITE_PREVEN').AsFloat;
      //componente.PrecoCusto := cdsComponentes.FieldByName('ITE_PRECUS').AsFloat;
      componente.OutrosValores := cdsComponentes.FieldByName
        ('ITE_OUTVAL').AsFloat;
      componente.IcmSaida := cdsComponentes.FieldByName('ITE_ICMSAI').AsFloat;
      componente.ImpostosFederais := cdsComponentes.FieldByName
        ('ITE_IMPFED').AsFloat;
      componente.DespesasOperacionais := cdsComponentes.FieldByName
        ('ITE_DESOPE').AsFloat + fltDesOpeTinta;
      componente.PesoEspecifico := cdsComponentes.FieldByName
        ('COL_PESESP').AsFloat;
      componente.Embalagem := cdsComponentes.FieldByName('COL_EMBALA').AsFloat;

      componente.PrecoMedio := cdsComponentes.FieldByName('ITE_PREMED').AsFloat;
      componente.UltimaCompra := cdsComponentes.FieldByName
        ('ITE_PREULT').AsFloat;
      componente.ImpostosUltimaCompra := cdsComponentes.FieldByName
        ('ITE_IMPULT').AsFloat;
      componente.CompraLiquido := fCalculaPrecoCompraLiq
        (cdsComponentes.FieldByName('ITE_PRECOM').AsFloat,
        cdsComponentes.FieldByName('ITE_DESF01').AsFloat,
        cdsComponentes.FieldByName('ITE_DESF02').AsFloat,
        cdsComponentes.FieldByName('ITE_DESF03').AsFloat,
        cdsComponentes.FieldByName('ITE_DESF04').AsFloat,
        cdsComponentes.FieldByName('ITE_DESF05').AsFloat,
        cdsComponentes.FieldByName('ITE_DESF06').AsFloat);
    End;
  end;

end;

procedure TFormulaAdvanceIndustrial.CarregarPrecosBases;
var
  cdsGen: TUniClientDataSet;
  conf: IConfTinta;
  fltDesOpeTinta: Double;
  base: ITintaDeMaquinaComponente;
  fltPreCusPro, fltPreVenPro: Double;
begin
  tintaDeMaquina.Remover(tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(Self.ItemBase)));
  Try
    Try
      conf := fGetConfTinta('ADT');
      fltDesOpeTinta := conf.fGetDouble('DESOPE');

      if (not fEmptyStr(strCodigoEmbalagemBase)) and
        (strCodigoEmbalagemBase <> cdsTinta.FieldByName('ADT_CODEMB').AsString)
      then
      begin
        CarregarPrecosBasesEmbalagem(strCodigoEmbalagemBase);
        Exit;
      end;

      cdsGen := TClientDataSetFactory.GetClientDataSet(qryBases);

      if not cdsGen.Locate('BAS_CODBAS;BAS_CODEMB;BAS_PRODUT',
        VarArrayOf([cdsTinta.FieldByName('ADT_CODBAS').AsString,
        cdsTinta.FieldByName('ADT_CODEMB').AsString,
        cdsTinta.FieldByName('ADT_PRODUT').AsString]), []) then
        raise Exception.CreateFmt('A bases %s - %s - %s não está cadastrada!',
          [cdsTinta.FieldByName('ADT_CODBAS').AsString,
          cdsTinta.FieldByName('ADT_CODEMB').AsString,
          cdsTinta.FieldByName('ADT_PRODUT').AsString]);

      Self.ItemBase := cdsGen.FieldByName('BAS_CODITE').AsString;
      Self.strCodigoEmbalagemBase := cdsGen.FieldByName('BAS_CODEMB').AsString;
      Self.strEmbalagemBase := cdsGen.FieldByName('EMB_DESCRI').AsString;
      Self.strUnidade := cdsGen.FieldByName('EMB_CODUNI').AsString;

      If fCarregaPromocao(Self.ItemBase, fTabPreco, strCodCli, strCodCnd, intPrzMed,
        fltPreCusPro, fltPreVenPro) Then
      Begin
        Self.fltPrecoCustoBase := fltPreCusPro;
        Self.fltPrecoVendaBase := fltPreVenPro;
        Self.FPromoc := 'S';

        If Self.fltPrecoCustoBase = 0 Then
          Self.fltPrecoCustoBase := cdsGen.FieldByName('ITE_PRECUS').AsFloat;
      End
      Else
      Begin
        Self.fltPrecoCustoBase := cdsGen.FieldByName('ITE_PRECUS').AsFloat;
        Self.fltPrecoVendaBase := cdsGen.FieldByName('ITE_PREVEN').AsFloat;
        Self.FPromoc  := 'N';
      End;

//      Self.fltPrecoCustoBase := cdsGen.FieldByName('ITE_PRECUS').AsFloat;
//      Self.fltPrecoVendaBase := cdsGen.FieldByName('ITE_PREVEN').AsFloat  + (fltPerAcr * cdsGen.FieldByName('ITE_PREVEN').AsFloat);

      Self.fltPrecoVendaBase := Self.fltPrecoVendaBase + (fltPerAcr * Self.fltPrecoVendaBase);

      Self.fltOutrosValoresBase := cdsGen.FieldByName('ITE_OUTVAL').AsFloat;
      Self.fltIcmSaidaBase := cdsGen.FieldByName('ITE_ICMSAI').AsFloat * Self.fltPrecoVendaBase / 100;
      Self.fltImpostosFederaisBase := cdsGen.FieldByName('ITE_IMPFED').AsFloat * Self.fltPrecoVendaBase / 100;
      Self.fltDespesasOperacionaisBase := (((cdsGen.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta) * Self.fltPrecoVendaBase) / 100);
      Self.fltPesoEspecificoBase := cdsGen.FieldByName('BAS_PESESP').AsFloat;

      Self.fltPrecoCustoRealBase := fCalculaPrecoCusto2(Self.fltPrecoVendaBase,
                                                        Self.fltPrecoCustoBase,
                                                        cdsGen.FieldByName('ITE_OUTVAL').AsFloat,
                                                        cdsGen.FieldByName('ITE_ICMSAI').AsFloat,
                                                        cdsGen.FieldByName('ITE_IMPFED').AsFloat,
                                                        cdsGen.FieldByName('ITE_DESOPE').AsFloat);

      Self.fltPrecoMedioBase := cdsGen.FieldByName('ITE_PREMED').AsFloat;
      Self.fltPrecoUltimaCompraBase := cdsGen.FieldByName('ITE_PREULT').AsFloat;
      Self.fltImpostosUltimaCompraBase := cdsGen.FieldByName('ITE_IMPULT').AsFloat;
      Self.fltPrecoCompraLiqBase := fCalculaPrecoCompraLiq
        (cdsGen.FieldByName('ITE_PRECOM').AsFloat,
        cdsGen.FieldByName('ITE_DESF01').AsFloat,
        cdsGen.FieldByName('ITE_DESF02').AsFloat,
        cdsGen.FieldByName('ITE_DESF03').AsFloat,
        cdsGen.FieldByName('ITE_DESF04').AsFloat,
        cdsGen.FieldByName('ITE_DESF05').AsFloat,
        cdsGen.FieldByName('ITE_DESF06').AsFloat);

      base := tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(Self.ItemBase));
      if not Assigned(base) then
      begin
        base := tintaDeMaquina.Adicionar(TGenericTintaDeMaquinaComponente.Create(
          Self.ItemBase, fRetNomProduto(Self.ItemBase), Self.fltDespesasOperacionaisBase, Self.fltIcmSaidaBase,
          Self.fltImpostosFederaisBase, Self.fltOutrosValoresBase, Self.fltPrecoCustoBase, Self.fltPrecoCustoRealBase,
          Self.fltPrecoMedioBase, Self.fltPrecoVendaBase, 1, tmctBaseImobiliaria,
          Self.fltPrecoUltimaCompraBase, Self.fltImpostosUltimaCompraBase, Self.fltPrecoCompraLiqBase));
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

procedure TFormulaAdvanceIndustrial.CarregarPrecosBasesEmbalagem
  (const strCodigoEmbalagemBase: string);
var
  cdsGen: TUniClientDataSet;
  base: ITintaDeMaquinaComponente;
  fltPreCusPro, fltPreVenPro: Double;
begin
  tintaDeMaquina.Remover(tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(strCodigoEmbalagemBase)));
  Try
    Try
      cdsGen := TClientDataSetFactory.GetClientDataSet(qryBases);

      if not cdsGen.Locate('BAS_CODBAS;BAS_CODEMB;BAS_PRODUT',
        VarArrayOf([cdsTinta.FieldByName('ADT_CODBAS').AsString,
        strCodigoEmbalagemBase, cdsTinta.FieldByName('ADT_PRODUT').AsString]
        ), []) then
        raise Exception.CreateFmt('A bases %s - %s - %s não está cadastrada!',
          [cdsTinta.FieldByName('ADT_CODBAS').AsString, strCodigoEmbalagemBase,
          cdsTinta.FieldByName('ADT_PRODUT').AsString]);

      Self.ItemBase := cdsGen.FieldByName('BAS_CODITE').AsString;
      Self.strCodigoEmbalagemBase := cdsGen.FieldByName('BAS_CODEMB').AsString;
      Self.strEmbalagemBase := cdsGen.FieldByName('EMB_DESCRI').AsString;
      Self.strUnidade := cdsGen.FieldByName('EMB_CODUNI').AsString;

      If fCarregaPromocao(Self.ItemBase, fTabPreco, strCodCli, strCodCnd, intPrzMed,
        fltPreCusPro, fltPreVenPro) Then
      Begin
        Self.fltPrecoCustoBase := fltPreCusPro;
        Self.fltPrecoVendaBase := fltPreVenPro;
        Self.FPromoc := 'S';

        If Self.fltPrecoCustoBase = 0 Then
          Self.fltPrecoCustoBase := cdsGen.FieldByName('ITE_PRECUS').AsFloat;
      End
      Else
      Begin
        Self.fltPrecoCustoBase := cdsGen.FieldByName('ITE_PRECUS').AsFloat;
        Self.fltPrecoVendaBase := cdsGen.FieldByName('ITE_PREVEN').AsFloat;
        Self.FPromoc := 'N';
      End;

//      Self.fltPrecoCustoBase := cdsGen.FieldByName('ITE_PRECUS').AsFloat;
//      Self.fltPrecoVendaBase := cdsGen.FieldByName('ITE_PREVEN').AsFloat + (fltPerAcr * cdsGen.FieldByName('ITE_PREVEN').AsFloat);

      Self.fltPrecoVendaBase := Self.fltPrecoVendaBase + (fltPerAcr * Self.fltPrecoVendaBase);

      Self.fltPrecoCustoRealBase := cdsGen.FieldByName('ITE_PREVEN').AsFloat;
      Self.fltOutrosValoresBase := cdsGen.FieldByName('ITE_OUTVAL').AsFloat;
      Self.fltIcmSaidaBase := cdsGen.FieldByName('ITE_ICMSAI').AsFloat;
      Self.fltImpostosFederaisBase := cdsGen.FieldByName('ITE_IMPFED').AsFloat;
      Self.fltDespesasOperacionaisBase := cdsGen.FieldByName('ITE_DESOPE').AsFloat;
      Self.fltPesoEspecificoBase := cdsGen.FieldByName('BAS_PESESP').AsFloat;

      Self.fltPrecoMedioEmbalagem := cdsGen.FieldByName('ITE_PREMED').AsFloat;
      Self.fltPrecoUltimaCompraEmbalagem :=
        cdsGen.FieldByName('ITE_PREULT').AsFloat;
      Self.fltImpostosUltimaCompraEmbalagem :=
        cdsGen.FieldByName('ITE_IMPULT').AsFloat;
      Self.fltPrecoCompraLiqEmbalagem :=
        fCalculaPrecoCompraLiq(cdsGen.FieldByName('ITE_PRECOM').AsFloat,
        cdsGen.FieldByName('ITE_DESF01').AsFloat,
        cdsGen.FieldByName('ITE_DESF02').AsFloat,
        cdsGen.FieldByName('ITE_DESF03').AsFloat,
        cdsGen.FieldByName('ITE_DESF04').AsFloat,
        cdsGen.FieldByName('ITE_DESF05').AsFloat,
        cdsGen.FieldByName('ITE_DESF06').AsFloat);


      base := tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(Self.ItemBase));
      if not Assigned(base) then
      begin
        base := tintaDeMaquina.Adicionar(TGenericTintaDeMaquinaComponente.Create(
          Self.ItemBase, fRetNomProduto(Self.ItemBase), Self.fltDespesasOperacionaisBase, Self.fltIcmSaidaBase,
          Self.fltImpostosFederaisBase, Self.fltOutrosValoresBase, Self.fltPrecoCustoBase, Self.fltPrecoCustoRealBase,
          Self.fltPrecoMedioBase, Self.fltPrecoVendaBase, 1, tmctBaseImobiliaria,
          Self.fltPrecoUltimaCompraBase, Self.fltImpostosUltimaCompraBase, Self.fltPrecoCompraLiqBase));
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

constructor TFormulaAdvanceIndustrial.Create(const strTabPre: string;  const cdsTinta: TUniClientDataSet);
  Var
    conf: IConfTinta;
begin
  Self.fltVolumeOriginal     := cdsTinta.FieldByName('ADT_QTDFIN').AsFloat;
  Self.fltVolumeBaseOriginal := cdsTinta.FieldByName('ADT_QTDBAS').AsFloat;

  Self.fltVolumeColorantesOriginal := cdsTinta.FieldByName('ADT_QTD_ML').AsFloat + cdsTinta.FieldByName('ADT_QTDCAT').AsFloat;

  Self.strCodigoBase  := cdsTinta.FieldByName('ADT_CODBAS').AsString;

  Self.strDescricao   := Format('%s %s %s %s %s',
    [cdsTinta.FieldByName('ADT_IDFORM').AsString,
    cdsTinta.FieldByName('ADT_CODCOR').AsString,
    cdsTinta.FieldByName('ADT_CODTEC').AsString,
    cdsTinta.FieldByName('ADT_PRODUT').AsString,
    cdsTinta.FieldByName('EMB_DESCRI').AsString]);

  Self.UsaCatalisador := cdsTinta.FieldByName('ADT_QTDCAT').AsFloat > 0;

  inherited Create(strTabPre, cdsTinta);

  conf      := fGetConfTinta('ADT');
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;
end;

function TFormulaAdvanceIndustrial.GetCodigoProdutoEmbalagem: string;
begin
  Result := fGetConfTinta('ADT').fGet('EMBGRA');
end;

function TFormulaAdvanceIndustrial.GetCodigoProdutoVendaEmbalagem: string;
begin
  Result := fGetConfTinta('ADT').fGet('PROGRA');
end;

function TFormulaAdvanceIndustrial.GetDescricao: String;
begin
  Result := strDescricao;
end;

procedure TFormulaAdvanceIndustrial.GetEmbalagensDisponivels(const dicEmbalagens
  : TDicionario; const dicCodigosEmbalagens: TDicionario;
  const dicProdutosBase: TDicionario);
var
  qryGen: TUniQuery;
  cdsGen: TUniClientDataSet;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                                               ' +
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
        cdsTinta.FieldByName('ADT_MD5KEY').AsString;
      cdsGen := TClientDataSetFactory.GetClientDataSet(qryGen);
      while not cdsGen.Eof do
      begin
        dicEmbalagens[cdsGen.FieldByName('EMB_DESCRI').AsString] :=
          cdsGen.FieldByName('ADT_QTDFIN').AsFloat;
        dicCodigosEmbalagens[cdsGen.FieldByName('EMB_DESCRI').AsString] :=
          cdsGen.FieldByName('EMB_CODEMB').AsString;
        dicProdutosBase[cdsGen.FieldByName('EMB_DESCRI').AsString] :=
          cdsGen.FieldByName('BAS_CODITE').AsString;
        cdsGen.Next;
      end;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then
      FreeAndNil(qryGen);
  End;
end;

function TFormulaAdvanceIndustrial.GetTextoCalculo: string;
begin
  Result := '';

  if blnPersonalizada then
    Result := 'Valor da Embalagem = ' + FormatCurr('0.00',
      fltPrecoVendaEmbalagem) + sLineBreak
  else
    Result := 'Valor da Base = ' + FormatCurr('0.00', fltPrecoVendaBase) +
      sLineBreak;

  Result := Result + 'Valor do Componente = (Quantidade) * (Preço / Embalagem)'
    + sLineBreak;
  Result := Result + 'Valor da Tinta = Valor da Base ';
  if blnUsaCatalisador then
    Result := Result + ' + Valor do Catalisador ';
  Result := Result + ' + Soma dos Valores dos Componentes ';
end;

end.
