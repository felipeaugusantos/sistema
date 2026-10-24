unit untGenericFormulaImobiliaria;

interface

uses
  untFuncEspecificas,  SysUtils, Uni, untIFormulaImobiliaria,
  System.Classes, untIConfTinta;

type
  TGenericFormulaImobiliaria = class(TFormulaImobiliaria)
  private
    fltPerAcr: Double;
  protected
    formulaImobiliaria: IFormulaImobiliaria;

    strIdePro: String;

    procedure SetIteBas(const Value: String); override;
    procedure pCarregarColorantes; override;
  public
    procedure pCarregaPrecosColorantes; override;
    procedure pCalculaPreco; override;
    constructor Create(const strTabPrePar: String; const formulaImobiliaria: IFormulaImobiliaria; strIdePro: String); reintroduce;
  end;

implementation
uses untFuncoesSimples,untTintaDeMaquinaComponenteTipo,untITintaDeMaquinaComponente,untTintaDeMaquinaComponenteComparerBaseImobiliaria,
untGenericTintaDeMaquinaComponente,untTintaMaquina,untTintaDeMaquinaComponenteComparerColorante,untQryConIteFactory;
{ TGenericFormulaImobiliaria }

constructor TGenericFormulaImobiliaria.Create(const strTabPrePar: String; const formulaImobiliaria: IFormulaImobiliaria; strIdePro: String);
  Var
    conf: IConfTinta;
begin
  Self.formulaImobiliaria := formulaImobiliaria;
  Self.strIdePro := strIdePro;

  conf := fGetConfTinta(strIdePro);
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;

  inherited Create(strTabPrePar);
end;

procedure TGenericFormulaImobiliaria.pCalculaPreco;
var
  objColorante: TColoranteImobiliario;
  intIndex: Integer;
  componente: ITintaDeMaquinaComponente;

  procedure pZerarPrecos;
  begin
    FPreCus := 0.0;
    FPreVen := 0.0;
    FCusCol := 0.0;
    FCu2Col := 0.0;
    FVenCol := 0.0;

    FOutVal := 0;
    FIcmsai := 0;
    FImpFed := 0;
    FDesOpe := 0;
    FPreMed := 0;

    FPreUlt := 0;
    FImpUlt := 0;
    FComLiq := 0;
  End;
begin
  inherited;

  pZerarPrecos;

  For intIndex := 0 To Count -1 Do
  Begin

    objColorante := TColoranteImobiliario(Items[intIndex]);

    If (Not qryCadCol.Locate('COL_CODCOL', objColorante.strCodcol, [])) Then
    Begin
      pZerarPrecos;
      fMensagem('', 'Colorante ' + objColorante.strCodCol + ' não cadastrado. Favor verificar.', ['OK']);
      Continue;
    End;

    If (fEmptyStr(qryCadCol.FieldByName('COL_CODITE').AsString)) Then
    Begin
      pZerarPrecos;
      fMensagem('', 'Colorante ' + objColorante.strCodCol + ' não está com o produto para venda associado.' + #13#10 +
                             'Favor verificar.', ['OK']);
      Continue;
    End;

    If (qryCadCol.FieldByName('ITE_CNV_ML').AsFloat <= 0) Then
    Begin
      pZerarPrecos;
      fMensagem('', 'O produto ' + qryCadCOl.FieldByName('COL_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                             'preenchido corretamente. Favor verificar.', ['OK']);
      Continue;
    End;

    if not IsItemAtivo(qryCadCol.FieldByName('COL_CODITE').AsString) then
    begin
      pZerarPrecos;
      raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [qryCadCol.FieldByName('COL_CODITE').AsString]);
    end;

    componente := tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerColorante.Create(objColorante.strCodCol));
    if not Assigned(componente) then
    begin
      componente := tintaDeMaquina.Adicionar(TGenericTintaDeMaquinaComponente.Create(
        objColorante.strCodIte, objColorante.strCodCol, tmctColoranteImobiliario));
    end;

    componente.Quantidade                := fltFatorEstoque * objColorante.fltQtdCol;
    componente.PrecoCusto                := fltFatorEstoque * formulaImobiliaria.GetCalculoColorantePreCus(objColorante);
    componente.PrecoCustoReal            := fltFatorEstoque * formulaImobiliaria.GetCalculoColorantePreCu2(objColorante);
    componente.PrecoVenda                := fltFatorEstoque * formulaImobiliaria.GetCalculoColorantePreVen(objColorante);
    componente.PrecoMedio                := fltFatorEstoque * formulaImobiliaria.GetCalculoColorantePreMed(objColorante);
    componente.OutrosValores             := fltFatorEstoque * formulaImobiliaria.GetCalculoColoranteOutVal(objColorante);
    componente.IcmsSaida                 := fltFatorEstoque * formulaImobiliaria.GetCalculoColoranteIcmSai(objColorante);
    componente.ImpostosFederais          := fltFatorEstoque * formulaImobiliaria.GetCalculoColoranteImpFed(objColorante);
    componente.DespesasOperacionais      := fltFatorEstoque * formulaImobiliaria.GetCalculoColoranteDesOpe(objColorante);
    componente.UltimoPrecoCompra         := fltFatorEstoque * formulaImobiliaria.GetCalculoColorantePreUlt(objColorante);
    componente.UltimoPrecoCompraImpostos := fltFatorEstoque * formulaImobiliaria.GetCalculoColoranteImpUlt(objColorante);
    componente.PrecoCompraLiquido        := fltFatorEstoque * formulaImobiliaria.GetCalculoColoranteComLiq(objColorante);

    If objColorante.StrPromoc = 'S' Then
      FPromoc := 'S';
  End;

  FCusCol := tintaDeMaquina.GetPrecoCustoComponentes;
  FCu2Col := tintaDeMaquina.GetPrecoCustoRealComponentes;
  FVenCol := tintaDeMaquina.GetPrecoVendaComponentes;
  FPreMed := tintaDeMaquina.GetPrecoMedioComponentes;

  FVenCol := FVenCol + (fltPerAcr * FVenCol);

  FOutVal := tintaDeMaquina.GetOutrosValoresComponentes;
  FIcmsai := tintaDeMaquina.GetIcmsSaidaComponentes;
  FImpFed := tintaDeMaquina.GetImpostosFederaisComponentes;
  FDesOpe := tintaDeMaquina.GetDespesasOperacionaisComponentes;

  FPreUlt := tintaDeMaquina.GetUltimoPrecoCompraComponentes;
  FImpUlt := tintaDeMaquina.GetUltimoPrecoCompraImpostosComponentes;
  FComLiq := tintaDeMaquina.GetPrecoCompraLiquidoComponentes;

  FPreCus := tintaDeMaquina.GetPrecoCustoComponentes + tintaDeMaquina.GetPrecoCustoEmbalagemBase;
  FPreCu2 := tintaDeMaquina.GetPrecoCustoRealComponentes + tintaDeMaquina.GetPrecoCustoRealEmbalagemBase;
  FPreVen := tintaDeMaquina.GetPrecoVendaComponentes + (fltPerAcr * tintaDeMaquina.GetPrecoVendaComponentes) +
             tintaDeMaquina.GetPrecoVendaEmbalagemBase;

end;

procedure TGenericFormulaImobiliaria.pCarregaPrecosColorantes;
var
  intContador: Integer;
  objColorante: TColoranteImobiliario;
  conf: IConfTinta;
  fltDesOpeTinta: Double;
  fltPreCusPro, fltPreVenPro: Double;
begin
  conf := fGetConfTinta(Self.strIdePro);
  fltDesOpeTinta := conf.fGetDouble('DESOPE');

  For intContador := 0 To Self.Count - 1 Do
  Begin
    objColorante := TColoranteImobiliario(Self.Items[intContador]);
    qryCadCol.Locate('COL_CODCOL', objColorante.strCodCol, []);

    If fCarregaPromocao(qryCadCol.FieldByName('COL_CODITE').AsString, fTabPreco, FCodCli, FCodCnd, FPrzMed,
      fltPreCusPro, fltPreVenPro) Then
    Begin
      objColorante.fltPreCus := fltPreCusPro;
      objColorante.fltPreVen := fltPreVenPro;
      objColorante.StrPromoc := 'S';

      If objColorante.fltPreCus = 0 Then
        objColorante.fltPreCus := qryCadCol.FieldByName('ITE_PRECUS').AsFloat;
    End
    Else
    Begin
      objColorante.fltPreCus := qryCadCol.FieldByName('ITE_PRECUS').AsFloat;
      objColorante.fltPreVen := qryCadCol.FieldByName('ITE_PREVEN').AsFloat;
      objColorante.StrPromoc := 'N';
    End;

    objColorante.strImpDir := qryCadCol.FieldByName('ITE_IMPDIR').AsString;
    objColorante.strCodIte := qryCadCol.FieldByName('COL_CODITE').AsString;

    objColorante.fltOutVal := qryCadCol.FieldByName('ITE_OUTVAL').AsFloat;

    if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
      objColorante.fltIcmSai := calculadorFatVendas.fCalculaAliquota(objColorante.strCodIte, objColorante.strImpDir)
    else
      objColorante.fltIcmSai := qryCadCol.FieldByName('ITE_ICMSAI').AsFloat;

    objColorante.fltImpFed := qryCadCol.FieldByName('ITE_IMPFED').AsFloat;
    objColorante.fltDesOpe := qryCadCol.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;
    objColorante.fltPreMed := qryCadCol.FieldByName('ITE_PREMED').AsFloat;
    objColorante.fltPreUlt := qryCadCol.FieldByName('ITE_PREULT').AsFloat;
    objColorante.fltImpUlt := qryCadCol.FieldByName('ITE_IMPULT').AsFloat;    

    if Assigned(qryCadCol.FindField('COL_EMBALA')) then
      objColorante.fltEmbala := qryCadCol.FieldByName('COL_EMBALA').AsFloat;

    objColorante.fltComLiq := fCalculaPrecoCompraLiq(qryCadCol.Fieldbyname('ITE_PRECOM').AsFloat, qryCadCol.Fieldbyname('ITE_DESF01').AsFloat,
                                                     qryCadCol.Fieldbyname('ITE_DESF02').AsFloat, qryCadCol.Fieldbyname('ITE_DESF03').AsFloat,
                                                     qryCadCol.Fieldbyname('ITE_DESF04').AsFloat, qryCadCol.Fieldbyname('ITE_DESF05').AsFloat,
                                                     qryCadCol.Fieldbyname('ITE_DESF06').AsFloat);
  End;

  FCalculo.Add('Valor da Base = ' + FloatToStrF(fltVenBas, ffFixed, 12, 2));
  FCalculo.Add(formulaImobiliaria.GetTextoCalculoValor);
end;

procedure TGenericFormulaImobiliaria.pCarregarColorantes;
var
  strCamposAdicionais: string;
begin
  Try
    qryCadCol.SQL.Clear;
    qryCadCol.SQL.Add(' SELECT                             ');
    qryCadCol.SQL.Add('   COL_CODCOL                       ');
    qryCadCol.SQL.Add('   , COL_CODITE                     ');
    qryCadCol.SQL.Add('   , ITE_CNV_ML                     ');

    qryCadCol.SQL.Add('   , ITE_PRECOM                       ');
    qryCadCol.SQL.Add('   , ITE_DESF01                       ');
    qryCadCol.SQL.Add('   , ITE_DESF02                       ');
    qryCadCol.SQL.Add('   , ITE_DESF03                       ');
    qryCadCol.SQL.Add('   , ITE_DESF04                       ');
    qryCadCol.SQL.Add('   , ITE_DESF05                       ');
    qryCadCol.SQL.Add('   , ITE_DESF06                       ');    

    strCamposAdicionais := formulaImobiliaria.GetCamposAdicionaisCarregarColorantes;
    if not fEmptyStr(strCamposAdicionais) then
      qryCadCol.SQL.Add(', ' + strCamposAdicionais);

    qryCadCol.SQL.Add('   , ITE_ICMSAI                     ');
    qryCadCol.SQL.Add('   , ITE_IMPFED                     ');
    qryCadCol.SQL.Add('   , ITE_DESOPE                     ');
    qryCadCol.SQL.Add('   , ITE_OUTVAL                     ');
    qryCadCol.SQL.Add('   , ITE_PREMED                     ');
    qryCadCol.SQL.Add('   , ITE_PREULT                     ');
    qryCadCol.SQL.Add('   , ITE_IMPULT                     ');

    If fCfgSis('IMPDIG') = '1' Then
      qryCadCol.SQL.Add('   , I.ITE_IMPDIR                   ')
    else
      qryCadCol.SQL.Add('   , G.ITE_IMPDIR                   ');

    If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
    begin
      qryCadCol.SQL.Add('   , ' + formulaImobiliaria.GetNomeCampoColoranteCusto + ' AS ITE_PRECUS       ');
      qryCadCol.SQL.Add('   , ' + formulaImobiliaria.GetNomeCampoColoranteVenda + ' AS ITE_PREVEN       ');
    end
    Else If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') and FBlnCalculaUnitario Then
    begin
      qryCadCol.SQL.Add('   , ITE_PRECUS                     ');
      qryCadCol.SQL.Add('   , ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN       ');
    end
    else
    begin
      qryCadCol.SQL.Add('   , ITE_PRECUS                     ');
      qryCadCol.SQL.Add('   , ITE_PREVE' + strTabPre + ' AS ITE_PREVEN       ');
    end;

    qryCadCol.SQL.Add(' FROM                               ');
    qryCadCol.SQL.Add('   ' + formulaImobiliaria.GetNomeTabelaColorante + '                       ');
    qryCadCol.SQL.Add('   LEFT JOIN ITEGER G               ');
    qryCadCol.SQL.Add('     ON G.ITE_CODITE = COL_CODITE   ');
    qryCadCol.SQL.Add('   LEFT JOIN CADITE I               ');
    qryCadCol.SQL.Add('     ON I.ITE_CODITE = COL_CODITE   ');
    qryCadCol.SQL.Add(' WHERE G.ITE_CODEMP = :CODEMP       ');

    qryCadCol.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCadCol.Open;
  Except
    on E: Exception do
    begin
      pMensagensErro(E.Message,'');
    end;
  End;
end;

procedure TGenericFormulaImobiliaria.SetIteBas(const Value: String);
var
  qryGen         : TUniQuery;
  fltIcmsai      : Double;
  base           : ITintaDeMaquinaComponente;
  conf           : IConfTinta;
  fltDesOpeTinta : Double;
  fltPreCusPro   : Double;
  fltPreVenPro   : Double;

  function fPrecoCusto2Base(const fltPreCus, fltPreVen: Double): Double;
  begin
    Result := fCalculaPrecoCusto2(fltPreVen,
      fltPreCus,
      qryGen.FieldByName('ITE_OUTVAL').AsFloat,
      fltIcmsai,
      qryGen.FieldByName('ITE_IMPFED').AsFloat,
      qryGen.FieldByName('ITE_DESOPE').AsFloat);
  end;
begin
  tintaDeMaquina.Remover(tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(FIteBas)));
  tintaDeMaquina.Remover(tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(FIteBasOri)));
  inherited;
  conf := fGetConfTinta(Self.strIdePro);
  fltDesOpeTinta := conf.fGetDouble('DESOPE');
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery(Nil);
      qryGen.SQL.Clear;


      If Value = strIteBasOri Then
      Begin
        If fltCusBasOri <= 0.0 Then
        Begin
          qryGen.SQL.Clear;
          qryGen.SQL.Add(' SELECT                               ');
          qryGen.SQL.Add('   I.ITE_CODITE                       ');

          qryGen.SQL.Add('   , G.ITE_ICMSAI                     ');
          qryGen.SQL.Add('   , G.ITE_IMPFED                     ');
          qryGen.SQL.Add('   , G.ITE_DESOPE                     ');
          qryGen.SQL.Add('   , G.ITE_OUTVAL                     ');
          qryGen.SQL.Add('   , G.ITE_PREMED                     ');
          qryGen.SQL.Add('   , G.ITE_PREULT                     ');
          qryGen.SQL.Add('   , G.ITE_IMPULT                     ');

          qryGen.SQL.Add('   , ITE_PRECOM                       ');
          qryGen.SQL.Add('   , ITE_DESF01                       ');
          qryGen.SQL.Add('   , ITE_DESF02                       ');
          qryGen.SQL.Add('   , ITE_DESF03                       ');
          qryGen.SQL.Add('   , ITE_DESF04                       ');
          qryGen.SQL.Add('   , ITE_DESF05                       ');
          qryGen.SQL.Add('   , ITE_DESF06                       ');

          If fCfgSis('IMPDIG') = '1' Then
            qryGen.SQL.Add('   , I.ITE_IMPDIR                     ')
          else
            qryGen.SQL.Add('   , G.ITE_IMPDIR                     ');

          If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
          begin
            qryGen.SQL.Add('   , ' + formulaImobiliaria.GetNomeCampoBaseCusto + ' AS ITE_PRECUS         ');
            qryGen.SQL.Add('   , ' + formulaImobiliaria.GetNomeCampoBaseVenda + ' AS ITE_PREVEN         ');
          end
          Else If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') and FBlnCalculaUnitario Then
          begin
            qryGen.SQL.Add('   , ITE_PRECUS                       ');
            qryGen.SQL.Add('   , ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN         ');
          end
          else
          begin
            qryGen.SQL.Add('   , ITE_PRECUS                       ');
            qryGen.SQL.Add('   , ITE_PREVE' + strTabPre + ' AS ITE_PREVEN         ');
          end;

          qryGen.SQL.Add(' FROM                                 ');
          qryGen.SQL.Add('   ' + formulaImobiliaria.GetNomeTabelaBase + ' B                       ');
          qryGen.SQL.Add('   INNER JOIN CADITE I                ');
          qryGen.SQL.Add('     ON B.BAS_CODITE = I.ITE_CODITE   ');
          qryGen.SQL.Add('   INNER JOIN ITEGER G                ');
          qryGen.SQL.Add('     ON I.ITE_CODITE = G.ITE_CODITE   ');
          qryGen.SQL.Add(' WHERE I.ITE_CODITE = :CODITE         ');
          qryGen.SQL.Add('   AND G.ITE_CODEMP = :CODEMP         ');

          qryGen.ParamByName('CODITE').AsString := FIteBas;
          qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
          qryGen.Open;

          If fCarregaPromocao(Value, fTabPreco, FCodCli, FCodCnd, FPrzMed,
            fltPreCusPro, fltPreVenPro) Then
          Begin
            FVenBasOri := fltPreVenPro;
            FCusBasOri := fltPreCusPro;
            FPromoc := 'S';

            If FCusBasOri = 0 Then
              FCusBasOri := qryGen.FieldByName('ITE_PRECUS').AsFloat;
          end
          else
          begin
            FVenBasOri := qryGen.FieldByName('ITE_PREVEN').AsFloat;
            FCusBasOri := qryGen.FieldByName('ITE_PRECUS').AsFloat;
          end;

          FVenBasOri := FVenBasOri + (fltPerAcr * FVenBasOri);

          FOutValBas := qryGen.FieldByName('ITE_OUTVAL').AsFloat;

          if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
          begin
            fltIcmsai := calculadorFatVendas.fCalculaAliquota(Value, qryGen.FieldByName('ITE_IMPDIR').AsString);
            FIcmsaiBas := fltIcmsai * FVenBasOri / 100;
          end
          else
          begin
            fltIcmsai := qryGen.FieldByName('ITE_ICMSAI').AsFloat;
            FIcmsaiBas := fltIcmsai * FVenBasOri / 100;
          end;

          FImpFedBas := qryGen.FieldByName('ITE_IMPFED').AsFloat * FVenBasOri / 100;
          FDesOpeBas := (((qryGen.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta) * FVenBasOri) / 100);
          FPreMedBas := qryGen.FieldByName('ITE_PREMED').AsFloat;
          FCu2BasOri := fPrecoCusto2Base(FCusBasOri, FVenBasOri);
          FPreUltBas := qryGen.FieldByName('ITE_PREULT').AsFloat;
          FImpUltBas := qryGen.FieldByName('ITE_IMPULT').AsFloat;

          FComLiqBas := fCalculaPrecoCompraLiq(qryGen.Fieldbyname('ITE_PRECOM').AsFloat, qryGen.Fieldbyname('ITE_DESF01').AsFloat,
                                               qryGen.Fieldbyname('ITE_DESF02').AsFloat, qryGen.Fieldbyname('ITE_DESF03').AsFloat,
                                               qryGen.Fieldbyname('ITE_DESF04').AsFloat, qryGen.Fieldbyname('ITE_DESF05').AsFloat,
                                               qryGen.Fieldbyname('ITE_DESF06').AsFloat);
        End;

        FCusBas := fltCusBasOri;
        FCu2Bas := fltCu2BasOri;
        FVenBas := fltVenBasOri;
      End
      Else
      Begin
        FIteBas := Value;

        qryGen.SQL.Clear;
        qryGen.SQL.Add(' SELECT                               ');
        qryGen.SQL.Add('   I.ITE_CODITE                       ');
        qryGen.SQL.Add('   , G.ITE_ICMSAI                     ');
        qryGen.SQL.Add('   , G.ITE_IMPFED                     ');
        qryGen.SQL.Add('   , G.ITE_DESOPE                     ');
        qryGen.SQL.Add('   , G.ITE_OUTVAL                     ');
        qryGen.SQL.Add('   , G.ITE_PREMED                     ');
        qryGen.SQL.Add('   , G.ITE_PREULT                     ');
        qryGen.SQL.Add('   , G.ITE_IMPULT                     ');

        qryGen.SQL.Add('   , ITE_PRECOM                       ');
        qryGen.SQL.Add('   , ITE_DESF01                       ');
        qryGen.SQL.Add('   , ITE_DESF02                       ');
        qryGen.SQL.Add('   , ITE_DESF03                       ');
        qryGen.SQL.Add('   , ITE_DESF04                       ');
        qryGen.SQL.Add('   , ITE_DESF05                       ');
        qryGen.SQL.Add('   , ITE_DESF06                       ');

        If fCfgSis('IMPDIG') = '1' Then
          qryGen.SQL.Add('   , I.ITE_IMPDIR                     ')
        else
          qryGen.SQL.Add('   , G.ITE_IMPDIR                     ');

        If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') and FBlnCalculaUnitario Then
        begin
          qryGen.SQL.Add('   , ITE_PRECUS                       ');
          qryGen.SQL.Add('   , ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN         ');
        end
        else
        begin
          qryGen.SQL.Add('   , ITE_PRECUS                       ');
          qryGen.SQL.Add('   , ITE_PREVE' + strTabPre + ' AS ITE_PREVEN         ');
        end;

        qryGen.SQL.Add(' FROM                                 ');
        qryGen.SQL.Add('   CADITE I                           ');
        qryGen.SQL.Add('   INNER JOIN ITEGER G                ');
        qryGen.SQL.Add('     ON I.ITE_CODITE = G.ITE_CODITE   ');
        qryGen.SQL.Add(' WHERE I.ITE_CODITE = :CODITE         ');
        qryGen.SQL.Add('   AND G.ITE_CODEMP = :CODEMP         ');

        qryGen.ParamByName('CODITE').AsString := FIteBas;
        qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryGen.Open;

        If fCarregaPromocao(Value, fTabPreco, FCodCli, FCodCnd, FPrzMed, fltPreCusPro, fltPreVenPro) Then
        Begin
          FCusBas := fltPreCusPro;
          FVenBas := fltPreVenPro;
          FPromoc := 'S';

          If FCusBas = 0 Then
            FCusBas := qryGen.FieldByName('ITE_PRECUS').AsFloat;
        end
        else
        begin
          FCusBas := qryGen.FieldByName('ITE_PRECUS').AsFloat;
          FVenBas := qryGen.FieldByName('ITE_PREVEN').AsFloat;
        end;

        FVenBas := FVenBas + (fltPerAcr * FVenBas);

        FOutValBas := qryGen.FieldByName('ITE_OUTVAL').AsFloat;

        if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
        begin
          fltIcmsai := calculadorFatVendas.fCalculaAliquota(Value, qryGen.FieldByName('ITE_IMPDIR').AsString);
          FIcmsaiBas := fltIcmsai * FVenBas / 100;
        end
        else
        begin
          fltIcmsai := qryGen.FieldByName('ITE_ICMSAI').AsFloat;
          FIcmsaiBas := fltIcmsai * FVenBas / 100;
        end;

        FImpFedBas := qryGen.FieldByName('ITE_IMPFED').AsFloat * FVenBas / 100;
        FDesOpeBas := (((qryGen.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta) * FVenBas) / 100);
        FCu2Bas := fPrecoCusto2Base(FCusBas, FVenBas);
        FPreMedBas := qryGen.FieldByName('ITE_PREMED').AsFloat;
        FPreUltBas := qryGen.FieldByName('ITE_PREULT').AsFloat;
        FImpUltBas := qryGen.FieldByName('ITE_IMPULT').AsFloat;
        FComLiqBas := fCalculaPrecoCompraLiq(qryGen.Fieldbyname('ITE_PRECOM').AsFloat, qryGen.Fieldbyname('ITE_DESF01').AsFloat,
                                             qryGen.Fieldbyname('ITE_DESF02').AsFloat, qryGen.Fieldbyname('ITE_DESF03').AsFloat,
                                             qryGen.Fieldbyname('ITE_DESF04').AsFloat, qryGen.Fieldbyname('ITE_DESF05').AsFloat,
                                             qryGen.Fieldbyname('ITE_DESF06').AsFloat);
      End;

//      FOutValBas := fFormataFloat(FOutValBas, fCfgSis('DECUNI', varInteger));
//      FIcmsaiBas := fFormataFloat(FIcmsaiBas, fCfgSis('DECUNI', varInteger));
//      FImpFedBas := fFormataFloat(FImpFedBas, fCfgSis('DECUNI', varInteger));
//      FDesOpeBas := fFormataFloat(FDesOpeBas, fCfgSis('DECUNI', varInteger));
//      FPreMedBas := fFormataFloat(FPreMedBas, fCfgSis('DECUNI', varInteger));
//      FPreUltBas := fFormataFloat(FPreUltBas, fCfgSis('DECUNI', varInteger));
//      FImpUltBas := fFormataFloat(FImpUltBas, fCfgSis('DECUNI', varInteger));

      base := tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(Value));
      if not Assigned(base) then
      begin
        base := tintaDeMaquina.Adicionar(TGenericTintaDeMaquinaComponente.Create(
          FIteBas, fRetNomProduto(FIteBas), FDesOpeBas, FIcmsaiBas, FImpFedBas,
          FOutValBas, FCusBas, FCu2Bas, FPreMedBas, FVenBas, 1, tmctBaseImobiliaria,
          FPreUltBas, FImpUltBas, FComLiqBas
        ));
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

end.

