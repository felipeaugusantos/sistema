unit untBrasimixImobiliariaDinamica;

interface

uses SysUtils, Forms, Classes,  Uni,
     StrUtils, untFuncEspecificas, Controls, untFuncoesSimples,
     untPnlBotoesAcoesNovaConsulta,
     Data.DB;

Type

  TfrmConsultaCompBrasimixImobiliaria = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;

  TFormulaBrasimixImobiliaria = class(TFormulaImobiliaria)
    private
      fltPerAcr: Double;

    protected
      procedure SetIteBas(const Value: String); override;
      procedure pCarregarColorantes; override;
    public
      procedure pCarregaPrecosColorantes; override;
      procedure pCalculaPreco; override;
      constructor Create(strTabPrePar: String); override;
  End;

  TFormulacaoBrasimix = class(TComponent)
  protected
    objFormula: TFormulaImobiliaria;
  public
    constructor Create(AOwner: TComponent; objFormula: TFormulaImobiliaria); reintroduce;
    procedure btnFormulacaoBrasimixClick(Sender: TObject);
  End;


  function fRetornaPrecoBrasimixImobiliariaDinamica(Sender: TForm; qryCadBzi: TUniQuery;
    Var dicRetorno: TDicionario; blnFaturamento: Boolean; strTab: String = 'N';
    strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;

  function fRetornaUniTraProBrasimixImobiliariaDinamica(fltPrcTin, fltPrvTin: Double): Double;

  function fRetornaDescricaoBrasimixImobiliariaDinamica(strDesCor: String; qryCadBzi: TUniQuery): String;

  function fDigDadosTintometricos(qryCadBzi: TUniQuery; strTabPre: String;
    Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
    Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;

  function fRetornaProdutoBase(strLinha, strCodBas, strCodUni: String): String;

  function fGTinForBrasimixImobiliariaDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;

  function fConsultaBrasimixImobiliariaDinamica(Sender: TForm): String; stdcall;
  function fConsultaBrasimixImobiliariaDinamicaGeral(Sender: TForm): String; stdcall;
  function fConsultaBrasimixImobiliariaDinamicaVenda(Sender: TForm; qryCadBzi: TUniQuery; strTabPre: String;
    blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;

  function fConsultaBrasimixImobiliariaDinamicaInterna(Sender: TForm;  qryCadBzi: TUniQuery;
    strTabPre: String; tipoConsulta: TTipoConsulta; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;

  procedure pRetornaDadosBrasimixImobiliariaDinamica(strIteTin: String; dicRetorno: TDicionario);
  procedure pRetornaTabelaPrecoBrasimixImobiliaria(dicRetorno: TDicionario);
  function GetIteBasOri(const strIteTin: string): string;


implementation
uses untFuncoes,untIConfTinta,untICalculadorFatVendas, untIConsultaTinta, untTintadeMaquina,untTintaMaquina,untDigTintaImobiliaria, untBrasimixImobiliariaConsulta, untFormulacaoImobiliariaBrasimixImobiliaria,
    untGenericTintaDeMaquinaComponente,
    untITintaDeMaquinaComponente,
    untTintaDeMaquinaComponenteTipo,
    untTintaDeMaquinaComponenteComparerColorante,
    untTintaDeMaquinaComponenteComparerBaseImobiliaria;
{ TfrmConsultaCompBrasimixImobiliaria }

procedure TfrmConsultaCompBrasimixImobiliaria.pTarefaFormulacao(
  Sender: TObject);
  Var
    qryGen: TUniQuery;
    strCodIte: String;
    strDesBas: String;
    strRefBas: String;
    strUniBas: String;
    strDesCor: String;
    fltPreCus: Double;
    fltUnitar: Double;
begin
  inherited;

  If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
    Exit;

  qryGen := fCriaQuery(Self);
  qryGen.SQL.Add('SELECT * FROM BZI_CADBZI WHERE AUTOINCREM = :AUTINC');
  qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
  qryGen.Open;

  fDigDadosTintometricos(qryGen, strTabPre, strCodIte, strDesBas,
    strRefBas, strUniBas, strDesCor, fltPreCus, fltUnitar, TDicionario.Create);

  FreeAndNil(qryGen);
end;

procedure TfrmConsultaCompBrasimixImobiliaria.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompBrasimixImobiliaria.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadBziNovasFormulas', False);
end;

{ TFormulaBrasimixImobiliaria }

constructor TFormulaBrasimixImobiliaria.Create(strTabPrePar: String);
  Var
    conf: IConfTinta;
begin
  inherited;
  conf := fGetConfTinta('BZI');
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;
end;

procedure TFormulaBrasimixImobiliaria.pCalculaPreco;
  Var
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
      Raise Exception.Create('Colorante ' + objColorante.strCodCol + ' não cadastrado. Favor verificar.');
      Exit;
    End;

    If (fEmptyStr(qryCadCol.FieldByName('COL_CODITE').AsString)) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('Colorante ' + objColorante.strCodCol + ' não está com o produto para venda associado.' + #13#10 +
                             'Favor verificar.');
      Exit;
    End;

    If (qryCadCol.FieldByName('ITE_CNV_ML').AsFloat <= 0) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('O produto ' + qryCadCOl.FieldByName('COL_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                             'preenchido corretamente. Favor verificar.');
      Exit;
    End;

    if (objColorante.fltPesEsp <= 0) then
    begin
      pZerarPrecos;
      Raise Exception.Create('Colorante ' + objColorante.strCodCol + ' não está com o peso específico configurado!' + #13#10 +
                             'Favor verificar.');
    end;  
    
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

    componente.Quantidade                := fFormataFloat(objColorante.fltQtdCol, 3);
    componente.PrecoCusto                := fFormataFloat(objColorante.fltQtdCol / objColorante.fltPesEsp, 3) * (objColorante.fltPreCus / 1000);
    componente.PrecoCustoReal            := fFormataFloat(objColorante.fltQtdCol / objColorante.fltPesEsp, 3) * (objColorante.fltPreCu2 / 1000);
    componente.PrecoVenda                := fFormataFloat(objColorante.fltQtdCol / objColorante.fltPesEsp, 3) * (objColorante.fltPreVen / 1000);
    componente.PrecoMedio                := objColorante.fltPreMed * objColorante.fltQtdCol / 1000;
    componente.OutrosValores             := objColorante.fltOutVal * objColorante.fltQtdCol / 1000;
    componente.IcmsSaida                 := objColorante.fltIcmSai * (objColorante.fltPreVen * objColorante.fltQtdCol / 1000) / 100;
    componente.ImpostosFederais          := objColorante.fltImpFed * (objColorante.fltPreVen * objColorante.fltQtdCol / 1000) / 100;
    componente.DespesasOperacionais      := objColorante.fltDesOpe * (objColorante.fltPreVen * objColorante.fltQtdCol / 1000) / 100;
    componente.UltimoPrecoCompra         := objColorante.fltPreUlt * (objColorante.fltQtdCol / 1000);
    componente.UltimoPrecoCompraImpostos := objColorante.fltImpUlt * (objColorante.fltQtdCol / 1000);
    componente.PrecoCompraLiquido        := objColorante.fltComLiq * (objColorante.fltQtdCol / 1000);

    If objColorante.StrPromoc = 'S' Then
      FPromoc := 'S';

{
    FCusCol := FCusCol + fFormataFloat(fFormataFloat(objColorante.fltQtdCol / objColorante.fltPesEsp, 3) * (objColorante.fltPreCus / 1000), 2);
    FCu2Col := FCu2Col + fFormataFloat(fFormataFloat(objColorante.fltQtdCol / objColorante.fltPesEsp, 3) * (objColorante.fltPreCu2 / 1000), 2);
    FVenCol := FVenCol + fFormataFloat(fFormataFloat(objColorante.fltQtdCol / objColorante.fltPesEsp, 3) * (objColorante.fltPreVen / 1000), 2);
    FPreMed := FPreMed + objColorante.fltPreMed * objColorante.fltQtdCol / 1000;

    FOutVal := FOutVal + objColorante.fltOutVal * objColorante.fltQtdCol / 1000;
    FIcmsai := FIcmsai + objColorante.fltIcmSai * (objColorante.fltPreVen * objColorante.fltQtdCol / 1000) / 100;
    FImpFed := FImpFed + objColorante.fltImpFed * (objColorante.fltPreVen * objColorante.fltQtdCol / 1000) / 100;
    FDesOpe := FDesOpe + objColorante.fltDesOpe * (objColorante.fltPreVen * objColorante.fltQtdCol / 1000) / 100;

    FPreUlt := FPreUlt + objColorante.fltPreUlt * (objColorante.fltQtdCol / 1000);
    FImpUlt := FImpUlt + objColorante.fltImpUlt * (objColorante.fltQtdCol / 1000);
    FComLiq := FComLiq + objColorante.fltComLiq * (objColorante.fltQtdCol / 1000);
}
  End;

  FCusCol := tintaDeMaquina.GetPrecoCustoComponentes;
  FCu2Col := tintaDeMaquina.GetPrecoCustoRealComponentes;
  FVenCol := tintaDeMaquina.GetPrecoVendaComponentes + (fltPerAcr * tintaDeMaquina.GetPrecoVendaComponentes);;
  FPreMed := tintaDeMaquina.GetPrecoMedioComponentes;
  FPreUlt := tintaDeMaquina.GetUltimoPrecoCompraComponentes;
  FImpUlt := tintaDeMaquina.GetUltimoPrecoCompraImpostosComponentes;
  FComLiq := tintaDeMaquina.GetPrecoCompraLiquidoComponentes;

  FOutVal := tintaDeMaquina.GetOutrosValoresComponentes;
  FIcmsai := tintaDeMaquina.GetIcmsSaidaComponentes;
  FImpFed := tintaDeMaquina.GetImpostosFederaisComponentes;
  FDesOpe := tintaDeMaquina.GetDespesasOperacionaisComponentes;

  FPreCus := fFormataFloat(tintaDeMaquina.GetPrecoCustoComponentes, 2) + tintaDeMaquina.GetPrecoCustoEmbalagemBase;
  FPreCu2 := fFormataFloat(tintaDeMaquina.GetPrecoCustoRealComponentes, 2) + tintaDeMaquina.GetPrecoCustoRealEmbalagemBase;
  FPreVen := fFormataFloat(FVenCol, 2) + tintaDeMaquina.GetPrecoVendaEmbalagemBase;

{
  FVenCol := FVenCol + (fltPerAcr * FVenCol);

  FPreCus := FCusBas + fFormataFloat(FCusCol, 2);
  FPreCu2 := FCu2Bas + fFormataFloat(FCu2Col, 2);
  FPreVen := FVenBas + fFormataFloat(FVenCol, 2);
}
end;

procedure TFormulaBrasimixImobiliaria.pCarregaPrecosColorantes;
  Var
    intContador: Integer;
    objColorante: TColoranteImobiliario;
    conf: IConfTinta;
    fltDesOpeTinta: Double;
    fltPreCusPro, fltPreVenPro: Double;
begin
  conf := fGetConfTinta('BZI');
  fltDesOpeTinta := conf.fGetDouble('DESOPE');

  For intContador := 0 To Self.Count-1 Do
  Begin
    objColorante := TColoranteImobiliario(Self.Items[intContador]);
    qryCadCol.Locate('COL_CODCOL', objColorante.strCodCol, []);

    If fCarregaPromocao(qryCadCol.FieldByName('COL_CODITE').AsString, fTabPreco,
      strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
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
    End;

    objColorante.fltPesEsp := qryCadCol.FieldByName('COL_PESESP').AsFloat;
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
    objColorante.fltComLiq := fCalculaPrecoCompraLiq(qryCadCol.Fieldbyname('ITE_PRECOM').AsFloat, qryCadCol.Fieldbyname('ITE_DESF01').AsFloat,
                                                     qryCadCol.Fieldbyname('ITE_DESF02').AsFloat, qryCadCol.Fieldbyname('ITE_DESF03').AsFloat,
                                                     qryCadCol.Fieldbyname('ITE_DESF04').AsFloat, qryCadCol.Fieldbyname('ITE_DESF05').AsFloat,
                                                     qryCadCol.Fieldbyname('ITE_DESF06').AsFloat);
  End;

  FCalculo.Add('Valor da Base = ' + FloatToStrF(fltVenBas, ffFixed, 12, 2));
  FCalculo.Add('Valor do Colorante = (Quantidade / Peso Específico Colorante) * (Preço / 1000)'); //VERIFICAR RONALDO
  FCalculo.Add('Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)');
end;

procedure TFormulaBrasimixImobiliaria.pCarregarColorantes;
begin
  Try
    qryCadCol.SQL.Clear;
    qryCadCol.SQL.Add(' SELECT                             ');
    qryCadCol.SQL.Add('   COL_CODCOL                       ');
    qryCadCol.SQL.Add('   , COL_CODITE                     ');
    qryCadCol.SQL.Add('   , ITE_CNV_ML                     ');
    qryCadCol.SQL.Add('   , COL_PESESP                     ');

    qryCadCol.SQL.Add('   , ITE_PREULT                     ');
    qryCadCol.SQL.Add('   , ITE_IMPULT                     ');

    qryCadCol.SQL.Add('   , ITE_PRECOM                       ');
    qryCadCol.SQL.Add('   , ITE_DESF01                       ');
    qryCadCol.SQL.Add('   , ITE_DESF02                       ');
    qryCadCol.SQL.Add('   , ITE_DESF03                       ');
    qryCadCol.SQL.Add('   , ITE_DESF04                       ');
    qryCadCol.SQL.Add('   , ITE_DESF05                       ');
    qryCadCol.SQL.Add('   , ITE_DESF06                       ');

    If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') <>  '0') Then
    begin
      qryCadCol.SQL.Add('   , ITE_ICMSAI                     ');
      qryCadCol.SQL.Add('   , ITE_IMPFED                     ');
      qryCadCol.SQL.Add('   , ITE_DESOPE                     ');
      qryCadCol.SQL.Add('   , ITE_OUTVAL                     ');
      qryCadCol.SQL.Add('   , ITE_PREMED                     ');
    end
    else
    begin
      qryCadCol.SQL.Add('   , 0 AS ITE_ICMSAI                ');
      qryCadCol.SQL.Add('   , 0 AS ITE_IMPFED                ');
      qryCadCol.SQL.Add('   , 0 AS ITE_DESOPE                ');
      qryCadCol.SQL.Add('   , 0 AS ITE_OUTVAL                ');
      qryCadCol.SQL.Add('   , 0 AS ITE_PREMED                ');
    end;

    If fCfgSis('IMPDIG') = '1' Then
      qryCadCol.SQL.Add('   , I.ITE_IMPDIR                   ')
    else
      qryCadCol.SQL.Add('   , G.ITE_IMPDIR                   ');

    If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
    begin
      qryCadCol.SQL.Add('   , COL_PRECUS AS ITE_PRECUS       ');
      qryCadCol.SQL.Add('   , COL_PREVEN AS ITE_PREVEN       ');
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
    qryCadCol.SQL.Add('   BZI_CADCOL                       ');
    qryCadCol.SQL.Add('   JOIN ITEGER G                    ');
    qryCadCol.SQL.Add('     ON G.ITE_CODITE = COL_CODITE   ');
    qryCadCol.SQL.Add('   LEFT JOIN CADITE I               ');
    qryCadCol.SQL.Add('     ON I.ITE_CODITE = COL_CODITE   ');
    qryCadCol.SQL.Add(' WHERE G.ITE_CODEMP = :CODEMP       ');

    qryCadCol.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCadCol.Open;
  Except
    on E: Exception do
    begin
      raise;
    end;
  End;
end;

procedure TFormulaBrasimixImobiliaria.SetIteBas(const Value: String);
var
  qryAux: TUniQuery;
  fltIcmsai: Double;
  conf: IConfTinta;
  fltDesOpeTinta : Double;
  fltPreCusPro,
  fltPreVenPro : Double;
  base: ITintaDeMaquinaComponente;

  function fPrecoCusto2Base(const fltPreCus, fltPreVen: Double): Double;
  begin
    Result := fCalculaPrecoCusto2(fltPreVen,
      fltPreCus,
      qryAux.FieldByName('ITE_OUTVAL').AsFloat,
      fltIcmsai,
      qryAux.FieldByName('ITE_IMPFED').AsFloat,
      qryAux.FieldByName('ITE_DESOPE').AsFloat);
  end;
begin
  tintaDeMaquina.Remover(tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(FIteBas)));
  tintaDeMaquina.Remover(tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(FIteBasOri)));
  inherited;
  conf := fGetConfTinta('BZI');
  fltDesOpeTinta := conf.fGetDouble('DESOPE');

  qryAux := nil;
  Try
    Try
      qryAux := fCriaQuery(Nil);
      qryAux.SQL.Clear;

      If Value = strIteBasOri Then
      Begin
        If fltCusBasOri <= 0.0 Then
        Begin
          qryAux.SQL.Clear;
          qryAux.SQL.Add(' SELECT                               ');
          qryAux.SQL.Add('   I.ITE_CODITE                       ');

          qryAux.SQL.Add('   , G.ITE_PREULT                     ');
          qryAux.SQL.Add('   , G.ITE_IMPULT                     ');

          qryAux.SQL.Add('   , ITE_PRECOM                       ');
          qryAux.SQL.Add('   , ITE_DESF01                       ');
          qryAux.SQL.Add('   , ITE_DESF02                       ');
          qryAux.SQL.Add('   , ITE_DESF03                       ');
          qryAux.SQL.Add('   , ITE_DESF04                       ');
          qryAux.SQL.Add('   , ITE_DESF05                       ');
          qryAux.SQL.Add('   , ITE_DESF06                       ');

          If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') <>  '0') Then
          begin
            qryAux.SQL.Add('   , ITE_ICMSAI                       ');
            qryAux.SQL.Add('   , ITE_IMPFED                       ');
            qryAux.SQL.Add('   , ITE_DESOPE                       ');
            qryAux.SQL.Add('   , ITE_OUTVAL                       ');
            qryAux.SQL.Add('   , ITE_PREMED                       ');
          end
          else
          begin
            qryAux.SQL.Add('   , 0 AS ITE_ICMSAI                  ');
            qryAux.SQL.Add('   , 0 AS ITE_IMPFED                  ');
            qryAux.SQL.Add('   , 0 AS ITE_DESOPE                  ');
            qryAux.SQL.Add('   , 0 AS ITE_OUTVAL                  ');
            qryAux.SQL.Add('   , 0 AS ITE_PREMED                  ');
          end;

          If fCfgSis('IMPDIG') = '1' Then
            qryAux.SQL.Add('   , I.ITE_IMPDIR                     ')
          else
            qryAux.SQL.Add('   , G.ITE_IMPDIR                     ');

          If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
          begin
            qryAux.SQL.Add('   , BAS_PRECUS AS ITE_PRECUS         ');
            qryAux.SQL.Add('   , BAS_PREVEN AS ITE_PREVEN         ');
          end
          Else If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') and FBlnCalculaUnitario Then
          begin
            qryAux.SQL.Add('   , ITE_PRECUS                       ');
            qryAux.SQL.Add('   , ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN         ');
          end
          else
          begin
            qryAux.SQL.Add('   , ITE_PRECUS                       ');
            qryAux.SQL.Add('   , ITE_PREVE' + strTabPre + ' AS ITE_PREVEN         ');
          end;

          qryAux.SQL.Add(' FROM                                 ');
          qryAux.SQL.Add('   BZI_CADBAS B                       ');
          qryAux.SQL.Add('   INNER JOIN CADITE I                ');
          qryAux.SQL.Add('     ON B.BAS_CODITE = I.ITE_CODITE   ');
          qryAux.SQL.Add('   INNER JOIN ITEGER G                ');
          qryAux.SQL.Add('     ON I.ITE_CODITE = G.ITE_CODITE   ');
          qryAux.SQL.Add(' WHERE I.ITE_CODITE = :CODITE         ');
          qryAux.SQL.Add('   AND G.ITE_CODEMP = :CODEMP         ');

          qryAux.ParamByName('CODITE').AsString := FIteBas;
          qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
          qryAux.Open;

          If fCarregaPromocao(Value, fTabPreco, strCodCli, strCodCnd, intPrzMed,
            fltPreCusPro, fltPreVenPro) Then
          Begin
            FCusBasOri := fltPreCusPro;
            FVenBasOri := fltPreVenPro;
            FPromoc := 'S';

            If FCusBasOri = 0 Then
              FCusBasOri := qryAux.FieldByName('ITE_PRECUS').AsFloat;
          End
          Else
          Begin
            FCusBasOri := qryAux.FieldByName('ITE_PRECUS').AsFloat;
            FVenBasOri := qryAux.FieldByName('ITE_PREVEN').AsFloat;
            FPromoc    := 'N';
          End;

          FVenBasOri := FVenBasOri + (fltPerAcr * FVenBasOri);

          if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
          begin
            fltIcmsai := calculadorFatVendas.fCalculaAliquota(Value, qryAux.FieldByName('ITE_IMPDIR').AsString);
            FIcmsaiBas := fltIcmsai * FVenBasOri / 100;
          end
          else
          begin
            fltIcmsai := qryAux.FieldByName('ITE_ICMSAI').AsFloat;
            FIcmsaiBas := fltIcmsai * FVenBasOri / 100;
          end;

          FImpFedBas := qryAux.FieldByName('ITE_IMPFED').AsFloat * FVenBasOri / 100;
          FDesOpeBas := (((qryAux.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta) * FVenBasOri) / 100);
          FPreMedBas := qryAux.FieldByName('ITE_PREMED').AsFloat;

          FCu2BasOri := fPrecoCusto2Base(FCusBasOri, FVenBasOri);

          FPreUltBas := qryAux.FieldByName('ITE_PREULT').AsFloat;
          FImpUltBas := qryAux.FieldByName('ITE_IMPULT').AsFloat;
          FComLiqBas := fCalculaPrecoCompraLiq(qryAux.Fieldbyname('ITE_PRECOM').AsFloat, qryAux.Fieldbyname('ITE_DESF01').AsFloat,
                                               qryAux.Fieldbyname('ITE_DESF02').AsFloat, qryAux.Fieldbyname('ITE_DESF03').AsFloat,
                                               qryAux.Fieldbyname('ITE_DESF04').AsFloat, qryAux.Fieldbyname('ITE_DESF05').AsFloat,
                                               qryAux.Fieldbyname('ITE_DESF06').AsFloat);
        End;

        FCusBas := fltCusBasOri;
        FCu2Bas := fltCu2BasOri;
        FVenBas := fltVenBasOri;
      End
      Else
      Begin
        FIteBas := Value;

        qryAux.SQL.Clear;
        qryAux.SQL.Add(' SELECT                               ');
        qryAux.SQL.Add('   I.ITE_CODITE                       ');

        qryAux.SQL.Add('   , G.ITE_PREULT                     ');
        qryAux.SQL.Add('   , G.ITE_IMPULT                     ');

        qryAux.SQL.Add('   , ITE_PRECOM                       ');
        qryAux.SQL.Add('   , ITE_DESF01                       ');
        qryAux.SQL.Add('   , ITE_DESF02                       ');
        qryAux.SQL.Add('   , ITE_DESF03                       ');
        qryAux.SQL.Add('   , ITE_DESF04                       ');
        qryAux.SQL.Add('   , ITE_DESF05                       ');
        qryAux.SQL.Add('   , ITE_DESF06                       ');

        If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') <>  '0') Then
        begin
          qryAux.SQL.Add('   , ITE_ICMSAI                       ');
          qryAux.SQL.Add('   , ITE_IMPFED                       ');
          qryAux.SQL.Add('   , ITE_DESOPE                       ');
          qryAux.SQL.Add('   , ITE_OUTVAL                       ');
          qryAux.SQL.Add('   , ITE_PREMED                       ');
        end
        else
        begin
          qryAux.SQL.Add('   , 0 AS ITE_ICMSAI                  ');
          qryAux.SQL.Add('   , 0 AS ITE_IMPFED                  ');
          qryAux.SQL.Add('   , 0 AS ITE_DESOPE                  ');
          qryAux.SQL.Add('   , 0 AS ITE_OUTVAL                  ');
          qryAux.SQL.Add('   , 0 AS ITE_PREMED                  ');
        end;

        If fCfgSis('IMPDIG') = '1' Then
          qryAux.SQL.Add('   , I.ITE_IMPDIR                     ')
        else
          qryAux.SQL.Add('   , G.ITE_IMPDIR                     ');

        If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') and FBlnCalculaUnitario Then
        begin
          qryAux.SQL.Add('   , ITE_PRECUS                       ');
          qryAux.SQL.Add('   , ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN         ');
        end
        else
        begin
          qryAux.SQL.Add('   , ITE_PRECUS                       ');
          qryAux.SQL.Add('   , ITE_PREVE' + strTabPre + ' AS ITE_PREVEN         ');
        end;

        qryAux.SQL.Add(' FROM                                 ');
        qryAux.SQL.Add('   CADITE I                           ');
        qryAux.SQL.Add('   INNER JOIN ITEGER G                ');
        qryAux.SQL.Add('     ON I.ITE_CODITE = G.ITE_CODITE   ');
        qryAux.SQL.Add(' WHERE I.ITE_CODITE = :CODITE         ');
        qryAux.SQL.Add('   AND G.ITE_CODEMP = :CODEMP         ');

        qryAux.ParamByName('CODITE').AsString := FIteBas;
        qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryAux.Open;

        If fCarregaPromocao(Value, fTabPreco, strCodCli, strCodCnd, intPrzMed,
          fltPreCusPro, fltPreVenPro) Then
        Begin
          FCusBas := fltPreCusPro;
          FVenBas := fltPreVenPro;
          FPromoc := 'S';

          If FCusBas = 0 Then
            FCusBas := qryAux.FieldByName('ITE_PRECUS').AsFloat;
        End
        Else
        Begin
          FCusBas := qryAux.FieldByName('ITE_PRECUS').AsFloat;
          FVenBas := qryAux.FieldByName('ITE_PREVEN').AsFloat;
          FPromoc := 'N';
        End;

        FVenBas := FVenBas + (fltPerAcr * FVenBas);

        FOutValBas := qryAux.FieldByName('ITE_OUTVAL').AsFloat;

        if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
        begin
          fltIcmsai := calculadorFatVendas.fCalculaAliquota(Value, qryAux.FieldByName('ITE_IMPDIR').AsString);
          FIcmsaiBas := fltIcmsai * FVenBas / 100;
        end
        else
        begin
          fltIcmsai := qryAux.FieldByName('ITE_ICMSAI').AsFloat;
          FIcmsaiBas := fltIcmsai * FVenBas / 100;
        end;

        FImpFedBas := qryAux.FieldByName('ITE_IMPFED').AsFloat * FVenBas / 100;
        FDesOpeBas := (((qryAux.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta) * FVenBas) / 100);
        FCu2Bas := fPrecoCusto2Base(FCusBas, FVenBas);
        FPreMedBas := qryAux.FieldByName('ITE_PREMED').AsFloat;
        FPreUltBas := qryAux.FieldByName('ITE_PREULT').AsFloat;
        FImpUltBas := qryAux.FieldByName('ITE_IMPULT').AsFloat;
        FComLiqBas := fCalculaPrecoCompraLiq(qryAux.Fieldbyname('ITE_PRECOM').AsFloat, qryAux.Fieldbyname('ITE_DESF01').AsFloat,
                                             qryAux.Fieldbyname('ITE_DESF02').AsFloat, qryAux.Fieldbyname('ITE_DESF03').AsFloat,
                                             qryAux.Fieldbyname('ITE_DESF04').AsFloat, qryAux.Fieldbyname('ITE_DESF05').AsFloat,
                                             qryAux.Fieldbyname('ITE_DESF06').AsFloat);
      End;

//      FOutValBas := fFormataFloat(FOutValBas, fCfgSis('DECUNI', varInteger));
//      FIcmsaiBas := fFormataFloat(FIcmsaiBas, fCfgSis('DECUNI', varInteger));
//      FImpFedBas := fFormataFloat(FImpFedBas, fCfgSis('DECUNI', varInteger));
//      FDesOpeBas := fFormataFloat(FDesOpeBas, fCfgSis('DECUNI', varInteger));
//      FPreMed    := fFormataFloat(FPreMed,    fCfgSis('DECUNI', varInteger));

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
    if Assigned(qryAux) then FreeAndNil(qryAux);
  End;
end;

function fRetornaPrecoBrasimixImobiliariaDinamica(Sender: TForm; qryCadBzi: TUniQuery;
    Var dicRetorno: TDicionario; blnFaturamento: Boolean; strTab: String = 'N';
    strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;
  Var

    {*******************************************}
    {* PARAMETROS                              *}
    {****************************************MV*}
    strCodEmp: String;
    strOpcDoc: String;
    strIteTin: String;
    blnUsaPreCus: Boolean;

    {*******************************************}
    {* VARIÁVEIS INTERNAS                      *}
    {****************************************MV*}
    fltPreCus: Double;
    fltUnitar: Double;
    strDesCor: String;
    strTabPre: String;
    strChaFor: String;
    strRefBas: String;
    strUniBas: String;
    strNovBas: String;
    strDesBas: String;

    strAuto: String;
    tinta  : IConsultaTinta;

    conf: IConfTinta;
begin
  conf := fGetConfTinta('BZI');

  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTabPre    := dicRetorno['tabpre'];

  Result := False;

  If strTab = 'N' Then
  Begin
    strAuto := fConsultaBrasimixImobiliariaDinamicaVenda(Sender, qryCadBzi, strTabPre, blnFaturamento, dicRetorno, sltItems);

    If (strAuto = '-1') Then
    Begin
      Exit;
    End;
  End
  Else
    strAuto := strAutoTab;

  tinta := TBrasimixImobiliariaConsulta.Create;

  qryCadBzi.Close;
  qryCadBzi.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
  qryCadBzi.Open;

  If (Not fDigDadosTintometricos(qryCadBzi, strTabPre, strNovBas, strDesBas,
                                 strRefBas, strUniBas, strDesCor,
                                 fltPreCus, fltUnitar, dicRetorno)) Then
  Begin
    Exit;
  End;

  strDesCor := Trim(strDesCor + ' ' + tinta.fGetDescricao(qryCadBzi.FieldByName('AUTOINCREM').AsString, strNovBas));

  strIteTin := qryCadBzi.FieldByName('BZI_CODIGO').AsString +
               qryCadBzi.FieldByName('BZI_UNIDAD').AsString +
               qryCadBzi.FieldByName('BZI_DESCRI').AsString +
               qryCadBzi.FieldByName('BZI_REFERE').AsString;

  strChaFor := qryCadBzi.FieldByName('BZI_DESCRI').AsString + ' ' +
               qryCadBzi.FieldByName('BZI_REFERE').AsString + ' ' +
               qryCadBzi.FieldByName('BZI_UNIDAD').AsString;

  fltPreCus := fltPreCus;

  If (blnUsaPreCus) Then
    fltUnitar := fltPreCus
  Else
    fltUnitar := fltUnitar;

  If (strOpcDoc = 'BR') Then
    fltUnitar := fltUnitar;

  dicRetorno['unidad'] := strUniBas;    

  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['precus'] := fltPreCus;
  dicRetorno['prvtin'] := fltUnitar;
//  dicRetorno['prctin'] := fltPreCus;
  dicRetorno['codite'] := strNovBas;
  dicRetorno['descor'] := strDesCor;
  dicRetorno['itetin'] := strIteTin;
  dicRetorno['chafor'] := strChaFor;
  dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

  Result := True;
end;

function fRetornaUniTraProBrasimixImobiliariaDinamica(fltPrcTin, fltPrvTin: Double): Double;
  Var
    strSiglaTrava: String;
    fltFatTrava: Double;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('BZI');
  
  strSiglaTrava := conf.fGet('TRABRI');
  fltFatTrava   := conf.fGetDouble('FATBRI');

  If strSiglaTrava = 'CUS' Then
    Result := fltPrcTin
  Else
    Result := fltPrvTin;

  Result := Result * fltFatTrava;
end;

function fRetornaDescricaoBrasimixImobiliariaDinamica(strDesCor: String; qryCadBzi: TUniQuery): String;
begin
  Result := strDesCor;
end;

function fDigDadosTintometricos(qryCadBzi: TUniQuery; strTabPre: String;
    Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
    Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;
var
  objColorante: TColoranteImobiliario;
  objFormula: TFormulaBrasimixImobiliaria;
  intContador: Integer;
  formula: TFormulacaoBrasimix;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  objFormula := nil;
  frmDigTintaImobiliaria := nil;
  Result := False;
  formula := nil;

  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaBrasimixImobiliaria.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltFatorEstoque := 1;
      objFormula.strCodCli    := IfNull(dicRetorno['codcli'], '');
      objFormula.strOpcDoc    := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCnd    := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed    := IfNull(dicRetorno['przmed'], 0);
      objFormula.strIteBasOri := fRetornaProdutoBase(qryCadBzi.FieldByName('BZI_LINHA_').AsString,
                                                     qryCadBzi.FieldByName('BZI_CODBAS').AsString,
                                                     qryCadBzi.FieldByName('BZI_CODUNI').AsString);

      objFormula.strIteBas    := objFormula.strIteBasOri;
      objFormula.strUnidad    := qryCadBzi.FieldByName('BZI_UNIDAD').AsString;
      objFormula.strDescri    := qryCadBzi.FieldByName('BZI_DESCRI').AsString;

      For intContador := 1 To 10 Do
      Begin

        If (fEmptyStr(qryCadBzi.FieldByName('BZI_CODC' + fStrZero(intContador, 2)).AsString)) Then
          Break;

        objColorante := TColoranteImobiliario(objFormula.Add);
        objColorante.strCodCol := qryCadBzi.FieldByName('BZI_CODC' + fStrZero(intContador, 2)).AsString;
        objColorante.fltQtdCol := qryCadBzi.FieldByName('BZI_QTDC' + fStrZero(intContador, 2)).AsFloat;
      End;

      formula := TFormulacaoBrasimix.Create(nil, objFormula);
      objFormula.pCarregaPrecosColorantes;


      frmDigTintaImobiliaria := TfrmDigTintaImobiliaria.Create(nil);
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTintaImobiliaria.Caption := frmDigTintaImobiliaria.Caption + 'Brasimix Imobiliaria';
      frmDigTintaImobiliaria.objFormula := objFormula;
      frmDigTintaImobiliaria.strIdePro := 'BZI';
      frmDigTintaImobiliaria.btnFormulacao.OnClick := formula.btnFormulacaoBrasimixClick;
      If frmDigTintaImobiliaria.ShowModal = mrOk Then
        Result := True;

      If (Result) Then
      Begin
        strNovBas := frmDigTintaImobiliaria.strNovBas;
        strDesBas := frmDigTintaImobiliaria.strDesBas;
        strRefere := frmDigTintaImobiliaria.strRefere;
        strUniBas := frmDigTintaImobiliaria.strUniBas;
        strDesCor := frmDigTintaImobiliaria.strDesCor;
        fltPreCus := frmDigTintaImobiliaria.fltPreCus;
        fltPreVen := frmDigTintaImobiliaria.fltPreVen;
      End;

      dicRetorno['precu2'] := objFormula.fltPreCu2;
      dicRetorno['premed'] := objFormula.fltPreMed + objFormula.fltPreMedBas;
      dicRetorno['preult'] := objFormula.fltPreUlt + objFormula.fltPreUltBas;
      dicRetorno['impult'] := objFormula.fltImpUlt + objFormula.fltImpUltBas;
      dicRetorno['prctin'] := objFormula.fltComLiq + objFormula.fltComLiqBas;
      dicRetorno['promoc'] := objFormula.StrPromoc;

      AcertaImpostos(fltPreCus, objFormula.fltPreCu2,
        objFormula.fltOutVal + objFormula.fltOutValBas,
        objFormula.fltIcmsai + objFormula.fltIcmsaiBas,
        objFormula.fltImpFed + objFormula.fltImpFedBas,
        objFormula.fltDesOpe + objFormula.fltDesOpeBas,
        dicRetorno);

      dicRetorno['maximoqtdbase'] := frmDigTintaImobiliaria.fltQtdMaximo;
      dicRetorno.AdicionarObjeto('formul', frmDigTintaImobiliaria.matrizSaldosColorantes);
      dicRetorno.AdicionarObjeto('tintaDeMaquina', objFormula.tintaDeMaquina);

      dicRetorno['promoc']      := objFormula.StrPromoc;

      If (Result) And (Assigned(dicRetorno)) Then
      Begin
        objFormula.pRecalculaTabelas(dicRetorno);
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(objFormula) then FreeAndNil(objFormula);
    if Assigned(frmDigTintaImobiliaria) then FreeAndNil(frmDigTintaImobiliaria);
    if Assigned(formula) then FreeAndNil(formula);    
  End;

end;

function fRetornaProdutoBase(strLinha, strCodBas, strCodUni: String): String;
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  BAS_CODITE ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  BZI_CADBAS ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  BAS_LINHA_ = :LINHA_ AND ');
  qryAux.SQL.Add('  BAS_BASE__ = :CODBAS AND ');
  qryAux.SQL.Add('  BAS_UNIDAD = :CODUNI ');

  qryAux.ParamByName('LINHA_').AsString := strLinha;
  qryAux.ParamByName('CODBAS').AsString := strCodBas;
  qryAux.ParamByName('CODUNI').AsString := strCodUni;

  qryAux.Open;
  Result := qryAux.FieldByName('BAS_CODITE').AsString;
  qryAux.Close;

  FreeAndNil(qryAux);
end;

function fGTinForBrasimixImobiliariaDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;
  Var
    strSQL: String;
    strCamFor: String;
    strCamBas: String;
    intPos: Integer;
    intContador: Integer;

    strColorantes: String;
    dicColorantes: TDicionario;
    qryConsulta01: TUniQuery;
begin
  Result := False;
  qryConsulta01 := nil;
  dicColorantes := nil;
  Try
    Try
      qryConsulta01 := fCriaQuery(Nil);
      dicColorantes := TDicionario.Create;
      strColorantes := '';

      Result := True;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  BZI_CADBZI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CONCAT(IFNULL(BZI_CODIGO, ""), ';
      strSQL := strSQL + '         IFNULL(BZI_UNIDAD, ""), ';
      strSQL := strSQL + '         IFNULL(BZI_DESCRI, ""), ';
      strSQL := strSQL + '         IFNULL(BZI_REFERE, "")) = :ITETIN ';


      With qryConsulta01 Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('ITETIN').AsString := strIteTin;
        Open;

        If (IsEmpty) Then
        Begin
          Result := False;
        End;

        If (Not Result) Then
        Begin
          strSQL := '';
          strSQL := strSQL + 'SELECT ';
          strSQL := strSQL + '  * ';
          strSQL := strSQL + 'FROM ';
          strSQL := strSQL + '  BZI_CADBZI ';
          strSQL := strSQL + 'WHERE ';
          strSQL := strSQL + '  CONCAT(BZI_CODIGO, BZI_UNIDAD) = :ITETIN ';

          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('ITETIN').AsString := strIteTin;
          Open;
        End;

        If IsEmpty Then
          Exit;

        For intContador := 1 To 10 Do
        Begin

          strCamFor := 'BZI_CODC' + fStrZero(IntToStr(intContador), 2);
          strCamBas := 'BZI_QTDC' + fStrZero(IntToStr(intContador), 2);

          arrFormul[intContador].strFormul := FieldByName(strCamFor).AsString;
          arrFormul[intContador].fltQtdBas := FieldByName(strCamBas).AsFloat;

          dicColorantes[arrFormul[intContador].strFormul] := arrFormul[intContador].fltQtdBas;

          {*******************************************}
          {* GUARDA COLORANTES PARA POSTERIOR BUSCA  *}
          {* DOS ITENS                               *}
          {****************************************MV*}
          strColorantes := strColorantes + QuotedStr(arrFormul[intContador].strFormul);
          If (Not fEmptyStr(arrFormul[intContador].strFormul)) Then
            strColorantes := strColorantes + ', ';

        End;

        strColorantes := Trim(strColorantes);
        If (RightStr(strColorantes, 1) = ',') Then
          strColorantes := Copy(strColorantes, 1, Length(strColorantes)-1);

      End;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  COL_CODCOL, ';
      strSQL := strSQL + '  COL_CODITE, ';
      strSQL := strSQL + '  COL_PESESP ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  BZI_CADCOL ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  COL_CODCOL IN (' + strColorantes + ') ';

      With qryConsulta01 Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

        intPos := 0;
        SetLength(arrBaixaPigmentos, RecordCount);

        While (Not Eof) Do
        Begin

          {*******************************************}
          {* ITENS QUE TEM QUE FAZER TRANSFERENCIA   *}
          {* DE SALDO EM ML                          *}
          {****************************************MV*}
          stlItensTraMl.Add(FieldByName('COL_CODITE').AsString);

          arrBaixaPigmentos[intPos].strCodIte   := FieldByName('COL_CODITE').AsString;
          arrBaixaPigmentos[intPos].fltQtdBaixa := dicColorantes[FieldByName('COL_CODCOL').AsString] / FieldByName('COL_PESESP').AsFloat;
          Inc(intPos);
          Next;
        End;

        Close;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryConsulta01) then FreeAndNil(qryConsulta01);
    if Assigned(dicColorantes) then FreeAndNil(dicColorantes);
  End;
end;

function fConsultaBrasimixImobiliariaDinamica(Sender: TForm): String; stdcall;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Sender);
  Result := fConsultaBrasimixImobiliariaDinamicaInterna(Sender, qryGen, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcGeral, False, Nil, Nil);
  FreeAndNil(qryGen);
end;

function fConsultaBrasimixImobiliariaDinamicaGeral(Sender: TForm): String; stdcall;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Sender);
  Result := fConsultaBrasimixImobiliariaDinamicaInterna(Sender, qryGen, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcGeral, False, Nil, Nil);
  FreeAndNil(qryGen);
end;

function fConsultaBrasimixImobiliariaDinamicaVenda(Sender: TForm; qryCadBzi: TUniQuery; strTabPre: String;
  blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;
begin
  Result := fConsultaBrasimixImobiliariaDinamicaInterna(Sender, qryCadBzi, strTabPre, tpcVenda, blnFaturamento, dicRetorno, sltItems);
end;

function fConsultaBrasimixImobiliariaDinamicaInterna(Sender: TForm;  qryCadBzi: TUniQuery;
  strTabPre: String; tipoConsulta: TTipoConsulta; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;
begin
  Result := (TBrasimixImobiliariaConsulta.Create).fExecutarConsulta(Sender,
    qryCadBzi, tipoConsulta, strTabPre, TfrmConsultaCompBrasimixImobiliaria,
    '', blnFaturamento, dicRetorno, sltItems);
end;

procedure pRetornaDadosBrasimixImobiliariaDinamica(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryCadBzi: TUniQuery;
    strSQL: String;
begin

  qryCadBzi := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BZI_CADBZI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(IFNULL(BZI_CODIGO, ""), ';
  strSQL := strSQL + '         IFNULL(BZI_UNIDAD, ""), ';
  strSQL := strSQL + '         IFNULL(BZI_DESCRI, ""), ';
  strSQL := strSQL + '         IFNULL(BZI_REFERE, "")) = :ITETIN ';

  With qryCadBzi Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;

    If IsEmpty Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  BZI_CADBZI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CONCAT(BZI_CODIGO, BZI_UNIDAD) = :ITETIN ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('ITETIN').AsString := strIteTin;
      Open;
    End;

    dicRetorno['codtin'] := FieldByName('BZI_CODIGO').AsString;
    dicRetorno['martin'] := FieldByName('BZI_REFERE').AsString;
    
    Close;
  End;

  FreeAndNil(qryCadBzi);
end;

procedure pRetornaTabelaPrecoBrasimixImobiliaria(dicRetorno: TDicionario);
var
  objFormula: TFormulaBrasimixImobiliaria;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaBrasimixImobiliaria.Create('1');
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;

      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);

      objFormula.strIteBasOri := GetIteBasOri(dicRetorno['itetin']);
      objFormula.strIteBas := dicRetorno['itebas'];
      pRetornaTabelaPrecoImobiliarias(dicRetorno, objFormula, 1);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(objFormula) then FreeAndNil(objFormula);
  End;

end;

{ TFormulacaoBrasimix }

procedure TFormulacaoBrasimix.btnFormulacaoBrasimixClick(Sender: TObject);
begin
  frmFormulacaoImobiliariaBrasimixImobiliaria := nil;
  Try
    Try
      frmFormulacaoImobiliariaBrasimixImobiliaria := TfrmFormulacaoImobiliariaBrasimixImobiliaria.Create(Self);
      frmFormulacaoImobiliariaBrasimixImobiliaria.objFormula := objFormula;
      frmFormulacaoImobiliariaBrasimixImobiliaria.Caption := frmFormulacaoImobiliariaBrasimixImobiliaria.Caption + AnsiReplaceStr(objFormula.strDescri, '%s ', '');
      frmFormulacaoImobiliariaBrasimixImobiliaria.ShowModal;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmFormulacaoImobiliariaBrasimixImobiliaria) then FreeAndNil(frmFormulacaoImobiliariaBrasimixImobiliaria);
  End;
end;

constructor TFormulacaoBrasimix.Create(AOwner: TComponent; objFormula: TFormulaImobiliaria);
begin
  inherited Create(AOwner);
  Self.objFormula := objFormula;
end;

function GetIteBasOri(const strIteTin: string): string;
var
  qryGen: TUniQuery;
begin
  Result := '';
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                              ' +
        '   B.BAS_CODITE                      ' +
        ' FROM                                ' +
        '   BZI_CADBZI A                      ' +
        '   INNER JOIN BZI_CADBAS B           ' +
        '     ON BZI_LINHA_ = B.BAS_LINHA_    ' +
        '     AND BZI_CODBAS = B.BAS_BASE__   ' +
        '     AND BZI_CODUNI = B.BAS_UNIDAD   ' +
        ' WHERE CONCAT(                       ' +
        '     IFNULL(A.BZI_CODIGO, '''')      ' +
        '     , IFNULL(A.BZI_UNIDAD, '''')    ' +
        '     , IFNULL(A.BZI_DESCRI, '''')    ' +
        '     , IFNULL(A.BZI_REFERE, '''')    ' +
        '   ) = :ITETIN                       ';
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;
      if not qryGen.IsEmpty then
        Result := qryGen.FieldByName('BAS_CODITE').AsString;

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
