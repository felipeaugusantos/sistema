 unit untEucatexImobiliariaDinamica;

interface

uses
  untFuncEspecificas, Forms, Classes, Uni, untFuncoesSimples, strUtils, untPnlBotoesAcoesNovaConsulta,
  SysUtils, Controls;

Type
  TfrmConsultaCompEucatexImobiliaria = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;


  TFormulaEucatexImobiliariaDinamica = class(TFormulaImobiliaria)
    private
      fltPerAcr: Double;
    protected
      objColErros: String;
      procedure SetIteBas(const Value: String); override;
      procedure pCarregarColorantes; override;
    public
      procedure pCarregaPrecosColorantes; override;
      procedure pCalculaPreco; override;
      constructor Create(strTabPrePar: String); override;
  End;

  TFormulacaoEucatex = class(TComponent)
  protected
    objFormula: TFormulaImobiliaria;
  public
    constructor Create(AOwner: TComponent; objFormula: TFormulaImobiliaria); reintroduce;
    procedure btnFormulacaoEucatexClick(Sender: TObject);
  End;

  function fRetornaPrecoEucatexImobiliariaDinamica(Sender: TForm; qryCadEuc: TUniQuery;
    Var dicRetorno: TDicionario; blnFaturamento: Boolean; strTab: String = 'N';
    strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;

  function fRetornaUniTraProEucatexImobiliariaDinamica(fltPrcTin, fltPrvTin: Double): Double;

  function fRetornaDescricaoEucatexImobiliariaDinamica(strDesCor: String; qryCadEuc: TUniQuery): String;

  function fDigDadosTintometricos(qryCadEuc: TUniQuery; strTabPre: String;
    Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
    Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;

  function fRetornaProdutoBase(strCodBas, strDesBas, strCodUni: String): String;

  function fGTinForEucatexImobiliariaDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;

  function fConsultaEucatexImobiliariaDinamica(Sender: TForm): String; stdcall;
  function fConsultaEucatexImobiliariaDinamicaGeral(Sender: TForm): String; stdcall;
  function fConsultaEucatexImobiliariaDinamicaVenda(Sender: TForm; {strCodEmp: String;}
    qryCadEuc: TUniQuery; strTabPre: String; blnFaturamento: Boolean;
    dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;

  function fConsultaEucatexImobiliariaDinamicaInterna(Sender: TForm;  qryCadEuc: TUniQuery;
    strTabPre: String; tipoConsulta: TTipoConsulta; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;

  procedure pRetornaDadosEucatexImobiliariaDinamica(strIteTin: String; dicRetorno: TDicionario);
  procedure pRetornaTabelaPrecoEucatex(dicRetorno: TDicionario);
  function GetIteBasOri(const strIteTin: string): string;

implementation

uses untDigTintaImobiliaria, Data.DB,untFuncoes,untIConfTinta,untICalculadorFatVendas,
  untFormulacaoImobiliariaEucatex, untEucatexImobiliariaConsulta,untIConsultaTinta,untTintaMaquina,
  untGenericTintaDeMaquinaComponente, untITintaDeMaquinaComponente,
  untTintaDeMaquinaComponenteTipo, untTintaDeMaquinaComponenteComparerColorante,
  untTintaDeMaquinaComponenteComparerBaseImobiliaria;


{ TFormulaEucatexImobiliariaDinamica }

constructor TFormulaEucatexImobiliariaDinamica.Create(strTabPrePar: String);
  Var
    conf: IConfTinta;
begin
  inherited;
  conf := fGetConfTinta('EUC');
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;
end;

procedure TFormulaEucatexImobiliariaDinamica.pCalculaPreco;
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

    If (Not qryCadCol.Locate('COL_CODCOL', objColorante.strCodcol, [])) And (Pos(objColorante.strCodcol, objColErros) = 0) Then
    Begin
      pZerarPrecos;
      fMensagem('', 'Colorante ' + objColorante.strCodCol + ' não cadastrado. Favor verificar.', ['OK']);
      objColErros := objColErros + '_' + objColorante.strCodCol + '_';
      Continue;
    End;

      If (fEmptyStr(qryCadCol.FieldByName('COL_CODITE').AsString))  And (Pos(objColorante.strCodcol, objColErros) = 0) Then
    Begin
      pZerarPrecos;
      fMensagem('', 'Colorante ' + objColorante.strCodCol + ' não está com o produto para venda associado.' + #13#10 +
                             'Favor verificar.', ['OK']);
      objColErros := objColErros + '_' + objColorante.strCodCol + '_';
      Continue;
    End;

    If (qryCadCol.FieldByName('ITE_CNV_ML').AsFloat <= 0) And (Pos(objColorante.strCodcol, objColErros) = 0) Then
    Begin
      pZerarPrecos;
      fMensagem('', 'O produto ' + qryCadCOl.FieldByName('COL_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                             'preenchido corretamente. Favor verificar.', ['OK']);
      objColErros := objColErros + '_' + objColorante.strCodCol + '_';
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

    componente.Quantidade                := (objColorante.fltQtdCol * (29.5735295625 / 48));
    componente.PrecoCusto                := (objColorante.fltQtdCol * (29.5735295625 / 48)) * (objColorante.fltPreCus / objColorante.fltEmbala);
    componente.PrecoCustoReal            := (objColorante.fltQtdCol * (29.5735295625 / 48)) * (objColorante.fltPreCu2 / objColorante.fltEmbala);
    componente.PrecoVenda                := (objColorante.fltQtdCol * (29.5735295625 / 48)) * (objColorante.fltPreVen / objColorante.fltEmbala);
    componente.PrecoMedio                := objColorante.fltPreMed * objColorante.fltQtdCol * (29.5735295625 / 48) / objColorante.fltEmbala;
    componente.OutrosValores             := objColorante.fltOutVal * objColorante.fltQtdCol * (29.5735295625 / 48) / objColorante.fltEmbala;
    componente.IcmsSaida                 := objColorante.fltIcmSai * (objColorante.fltPreVen * objColorante.fltQtdCol * (29.5735295625 / 48) / objColorante.fltEmbala) / 100;
    componente.ImpostosFederais          := objColorante.fltImpFed * (objColorante.fltPreVen * objColorante.fltQtdCol * (29.5735295625 / 48) / objColorante.fltEmbala) / 100;
    componente.DespesasOperacionais      := objColorante.fltDesOpe * (objColorante.fltPreVen * objColorante.fltQtdCol * (29.5735295625 / 48) / objColorante.fltEmbala) / 100;
    componente.UltimoPrecoCompra         := objColorante.fltPreUlt * (objColorante.fltQtdCol * (29.5735295625 / 48) / objColorante.fltEmbala);
    componente.UltimoPrecoCompraImpostos := objColorante.fltImpUlt * (objColorante.fltQtdCol * (29.5735295625 / 48) / objColorante.fltEmbala);
    componente.PrecoCompraLiquido        := objColorante.fltComLiq * (objColorante.fltQtdCol * (29.5735295625 / 48) / objColorante.fltEmbala);

{
    FCusCol := FCusCol + (objColorante.fltQtdCol * (29.5735295625 / 48)) * (objColorante.fltPreCus / 1000);
    FCu2Col := FCu2Col + (objColorante.fltQtdCol * (29.5735295625 / 48)) * (objColorante.fltPreCu2 / 1000);
    FVenCol := FVenCol + (objColorante.fltQtdCol * (29.5735295625 / 48)) * (objColorante.fltPreVen / 1000);
    FPreMed := FPreMed + objColorante.fltPreMed * objColorante.fltQtdCol * (29.5735295625 / 48) / 1000;

    FOutVal := FOutVal + objColorante.fltOutVal * objColorante.fltQtdCol * (29.5735295625 / 48) / 1000;
    FIcmsai := FIcmsai + objColorante.fltIcmSai * (objColorante.fltPreVen * objColorante.fltQtdCol * (29.5735295625 / 48) / 1000) / 100;
    FImpFed := FImpFed + objColorante.fltImpFed * (objColorante.fltPreVen * objColorante.fltQtdCol * (29.5735295625 / 48) / 1000) / 100;
    FDesOpe := FDesOpe + objColorante.fltDesOpe * (objColorante.fltPreVen * objColorante.fltQtdCol * (29.5735295625 / 48) / 1000) / 100;

    FPreUlt := FPreUlt + objColorante.fltPreUlt * (objColorante.fltQtdCol * (29.5735295625 / 48) / 1000);
    FImpUlt := FImpUlt + objColorante.fltImpUlt * (objColorante.fltQtdCol * (29.5735295625 / 48) / 1000);
    FComLiq := FComLiq + objColorante.fltComLiq * (objColorante.fltQtdCol * (29.5735295625 / 48) / 1000);
}
  End;

  If Not (fEmptyStr(objColErros)) Then
    Exit;

  FCusCol := tintaDeMaquina.GetPrecoCustoComponentes;
  FCu2Col := tintaDeMaquina.GetPrecoCustoRealComponentes;
  FVenCol := tintaDeMaquina.GetPrecoVendaComponentes + (fltPerAcr * tintaDeMaquina.GetPrecoVendaComponentes);
  FPreMed := tintaDeMaquina.GetPrecoMedioComponentes;
  FPreUlt := tintaDeMaquina.GetUltimoPrecoCompraComponentes;
  FImpUlt := tintaDeMaquina.GetUltimoPrecoCompraImpostosComponentes;
  FComLiq := tintaDeMaquina.GetPrecoCompraLiquidoComponentes;

  FOutVal := tintaDeMaquina.GetOutrosValoresComponentes;
  FIcmsai := tintaDeMaquina.GetIcmsSaidaComponentes;
  FImpFed := tintaDeMaquina.GetImpostosFederaisComponentes;
  FDesOpe := tintaDeMaquina.GetDespesasOperacionaisComponentes;

  FPreCus := tintaDeMaquina.GetPrecoCustoComponentes + tintaDeMaquina.GetPrecoCustoEmbalagemBase;
  FPreCu2 := tintaDeMaquina.GetPrecoCustoRealComponentes + tintaDeMaquina.GetPrecoCustoRealEmbalagemBase;
  FPreVen := FVenCol + tintaDeMaquina.GetPrecoVendaEmbalagemBase;

{
  FVenCol := FVenCol + (fltPerAcr * FVenCol);

  FPreCus := FCusBas + FCusCol;
  FPreCu2 := FCu2Bas + FCu2Col;
  FPreVen := FVenBas + FVenCol;
}
end;

procedure TFormulaEucatexImobiliariaDinamica.pCarregaPrecosColorantes;
  Var
    intContador: Integer;
    objColorante: TColoranteImobiliario;
    conf: IConfTinta;
    fltDesOpeTinta: Double;
    fltPreCusPro,
    fltPreVenPro: Double;
begin
  conf := fGetConfTinta('EUC');
  fltDesOpeTinta := conf.fGetDouble('DESOPE');

  For intContador := 0 To Self.Count - 1 Do
  Begin
    objColorante := TColoranteImobiliario(Self.Items[intContador]);
    qryCadCol.Locate('COL_CODCOL', objColorante.strCodCol, []);

    If fCarregaPromocao(qryCadCol.FieldByName('COL_CODITE').AsString, fTabPreco,
      strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
    Begin
      objColorante.fltPreCus := fltPreCusPro;
      objColorante.fltPreVen := fltPreVenPro;
      FPromoc := 'S';

      If objColorante.fltPreCus = 0 Then
        objColorante.fltPreCus := qryCadCol.FieldByName('ITE_PRECUS').AsFloat;
    End
    Else
    Begin
      objColorante.fltPreCus := qryCadCol.FieldByName('ITE_PRECUS').AsFloat;
      objColorante.fltPreVen := qryCadCol.FieldByName('ITE_PREVEN').AsFloat;
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
    objColorante.fltComLiq := fCalculaPrecoCompraLiq(qryCadCol.Fieldbyname('ITE_PRECOM').AsFloat, qryCadCol.Fieldbyname('ITE_DESF01').AsFloat,
                                                     qryCadCol.Fieldbyname('ITE_DESF02').AsFloat, qryCadCol.Fieldbyname('ITE_DESF03').AsFloat,
                                                     qryCadCol.Fieldbyname('ITE_DESF04').AsFloat, qryCadCol.Fieldbyname('ITE_DESF05').AsFloat,
                                                     qryCadCol.Fieldbyname('ITE_DESF06').AsFloat);

    objColorante.fltEmbala := qryCadCol.FieldByName('COL_EMBALA').AsFloat;
  End;

  FCalculo.Add('Valor da Base = ' + FloatToStrF(fltVenBas, ffFixed, 12, 2));

  If (conf.fGet('EUCMAN') = 'S') Then
    FCalculo.Add('Quantidade em ML = ((Parte Inteira) + ((Parte Fração / 48) * 100)) * (29.5735295625 / 48)');

  FCalculo.Add('Valor do Colorante = Quantidade * (Preço / Embalagem)');
  FCalculo.Add('Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)');
end;

procedure TFormulaEucatexImobiliariaDinamica.pCarregarColorantes;
begin
  Try
    qryCadCol.SQL.Clear;
    qryCadCol.SQL.Add(' SELECT                             ');
    qryCadCol.SQL.Add('   COL_CODCOL                       ');
    qryCadCol.SQL.Add('   , COL_CODITE                     ');
    qryCadCol.SQL.Add('   , COL_EMBALA                     ');
    qryCadCol.SQL.Add('   , ITE_CNV_ML                     ');

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
    qryCadCol.SQL.Add('   EUC_CADCOL                       ');
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

procedure TFormulaEucatexImobiliariaDinamica.SetIteBas(
  const Value: String);
var
  qryAux: TUniQuery;
  fltIcmsai: Double;
  conf: IConfTinta;
  fltDesOpeTinta: Double;
  fltPreCusPro,
  fltPreVenPro: Double;
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
  conf := fGetConfTinta('EUC');
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
          qryAux.SQL.Add('   EUC_CADBAS B                       ');
          qryAux.SQL.Add('   INNER JOIN CADITE I                ');
          qryAux.SQL.Add('     ON B.BAS_CODITE = I.ITE_CODITE   ');
          qryAux.SQL.Add('   INNER JOIN ITEGER G                ');
          qryAux.SQL.Add('     ON I.ITE_CODITE = G.ITE_CODITE   ');
          qryAux.SQL.Add(' WHERE I.ITE_CODITE = :CODITE         ');
          qryAux.SQL.Add('   AND G.ITE_CODEMP = :CODEMP         ');

          qryAux.ParamByName('CODITE').AsString := FIteBas;
          qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
          qryAux.Open;

          If fCarregaPromocao(FIteBas, fTabPreco, strCodCli, strCodCnd, intPrzMed,
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

          FOutValBas := qryAux.FieldByName('ITE_OUTVAL').AsFloat;

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

        If fCarregaPromocao(FIteBas, fTabPreco, strCodCli, strCodCnd, intPrzMed,
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

function fRetornaPrecoEucatexImobiliariaDinamica(Sender: TForm; qryCadEuc: TUniQuery;
  Var dicRetorno: TDicionario; blnFaturamento: Boolean; strTab: String = 'N';
  strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;
  Var
    strCodEmp: String;
    strOpcDoc: String;
    strIteTin: String;
    blnUsaPreCus: Boolean;

    fltPreCus: Double;
    fltUnitar: Double;
    strCodIte: String;
    strDesCor: String;
    strTabPre: String;
    strDesBas: String;
    strRefBas: String;
    strUniBas: String;
    strAuto: String;
    tinta : IConsultaTinta;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('EUC');

  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTabPre    := dicRetorno['tabpre'];

  Result := False;
{
  If (fConsultaEucatexImobiliariaDinamicaVenda(Sender, strCodEmp, qryCadEuc) = '-1') Then
  Begin
    Exit;
  End;
}

  If strTab = 'N' Then
  Begin
    strAuto := fConsultaEucatexImobiliariaDinamicaVenda(Sender, qryCadEuc, strTabPre, blnFaturamento, dicRetorno, sltItems);

    If (strAuto = '-1') Then
    Begin
      Exit;
    End;
  End
  Else
    strAuto := strAutoTab;

  tinta := TEucatexImobiliariaConsulta.Create;

  qryCadEuc.Close;
  qryCadEuc.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
  qryCadEuc.Open;

  If (Not fDigDadosTintometricos(qryCadEuc, strTabPre, strCodIte, strDesBas,
        strRefBas, strUniBas, strDesCor, fltPreCus, fltUnitar, dicRetorno)) Then
  Begin
    Exit;
  End;

  strDesCor := Trim(strDesCor + ' ' + tinta.fGetDescricao(qryCadEuc.FieldbyName('AUTOINCREM').AsString, strCodIte));
//  strIteTin := qryCadEuc.FieldByName('EUC_CODSEQ').AsString;
  strIteTin := qryCadEuc.FieldByName('EUC_CODCOR').AsString +
              qryCadEuc.FieldByName('EUC_DESCOR').AsString +
              qryCadEuc.FieldByName('EUC_PRODUT').AsString +
              qryCadEuc.FieldByName('EUC_DESBAS').AsString +
              qryCadEuc.FieldByName('EUC_UNIDAD').AsString +
              qryCadEuc.FieldByName('EUC_CODNFM').AsString +
              qryCadEuc.FieldByName('EUC_OBSCOR').AsString;

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
  dicRetorno['codite'] := strCodIte;
  dicRetorno['descor'] := strDesCor;
  dicRetorno['itetin'] := strIteTin;
  dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

  Result := True;
end;

function fRetornaUniTraProEucatexImobiliariaDinamica(fltPrcTin, fltPrvTin: Double): Double;
  Var
    strSiglaTrava: String;
    fltFatTrava: Double;
    conf: IConfTinta;
begin
  conf     := fGetConfTinta('EUC');
  strSiglaTrava := conf.fGet('TRAEUC'); //fArqIniTinta(0, 'Eucatex Imobiliaria', 'TRAEUC', '');
  fltFatTrava   := conf.fGetDouble('EUCFAT'); //fStrToFloat(fArqIniTinta(0, 'Eucatex Imobiliaria', 'EUCFAT', ''));

  If strSiglaTrava = 'CUS' Then
    Result := fltPrcTin
  Else
    Result := fltPrvTin;

  Result := Result * fltFatTrava;
end;

function fRetornaDescricaoEucatexImobiliariaDinamica(strDesCor: String; qryCadEuc: TUniQuery): String;
begin
  Result := strDesCor;  
end;

function fDigDadosTintometricos(qryCadEuc: TUniQuery; strTabPre: String;
  Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
  Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;
var
  objColorante: TColoranteImobiliario;
  objFormula: TFormulaEucatexImobiliariaDinamica;
  intContador: Integer;
  formulacaoEucatex: TFormulacaoEucatex;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  Result := False;
  objFormula := nil;
  frmDigTintaImobiliaria := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;
            
      objFormula := TFormulaEucatexImobiliariaDinamica.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltFatorEstoque := (29.5735295625 / 48);
      objFormula.strCodCli    := IfNull(dicRetorno['codcli'], '');
      objFormula.strOpcDoc    := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCnd    := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed    := IfNull(dicRetorno['przmed'], 0);
      objFormula.strIteBasOri := fRetornaProdutoBase(qryCadEuc.FieldByName('EUC_DESBAS').AsString,
                                                     qryCadEuc.FieldByName('EUC_PRODUT').AsString,
                                                     qryCadEuc.FieldByName('EUC_UNIDAD').AsString);

      objFormula.strIteBas    := objFormula.strIteBasOri;
      objFormula.strUnidad    := qryCadEuc.FieldByName('EUC_UNIDAD').AsString;

      objFormula.strDescri    := qryCadEuc.FieldByName('EUC_PRODUT').AsString + ' ' +
                                 qryCadEuc.FieldByName('EUC_DESCOR').AsString + ' ' +
                                 qryCadEuc.FieldByName('EUC_UNIDAD').AsString;

      For intContador := 1 To 6 Do
      Begin

        If (fEmptyStr(qryCadEuc.FieldByName('EUC_FORM' + fStrZero(intContador, 2)).AsString)) Then
          Break;

        objColorante := TColoranteImobiliario(objFormula.Add);
        objColorante.strCodCol := qryCadEuc.FieldByName('EUC_FORM' + fStrZero(intContador, 2)).AsString;
        objColorante.fltQtdCol := qryCadEuc.FieldByName('EUC_QTDB' + fStrZero(intContador, 2)).AsFloat;

      End;

      objFormula.pCarregaPrecosColorantes;
      objFormula.pCalculaPreco;

      formulacaoEucatex := TFormulacaoEucatex.Create(nil, objFormula);

      pCriarFormularios(TfrmDigTintaImobiliaria, frmDigTintaImobiliaria);
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTintaImobiliaria.btnFormulacao.OnClick := formulacaoEucatex.btnFormulacaoEucatexClick;
      frmDigTintaImobiliaria.Caption    := frmDigTintaImobiliaria.Caption + 'Eucatex Imobiliaria';
      frmDigTintaImobiliaria.objFormula := objFormula;
      frmDigTintaImobiliaria.strIdePro  := 'EUC';

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
      End;

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
    if Assigned(frmDigTintaImobiliaria) then FreeAndNil(frmDigTintaImobiliaria);
    if Assigned(objFormula) then FreeAndNil(objFormula);
  End;

end;

function fRetornaProdutoBase(strCodBas, strDesBas, strCodUni: String): String;
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('	BAS_CODITE');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('	EUC_CADBAS');
  qryAux.SQL.Add('WHERE');
  qryAux.SQL.Add('	BAS_DESCRI = :CODBAS');
  qryAux.SQL.Add('	AND BAS_PRODUT = :DESBAS');
  qryAux.SQL.Add('  AND BAS_CODUNI = :CODUNI');

  qryAux.ParamByName('CODBAS').AsString := strCodBas;
  qryAux.ParamByName('DESBAS').AsString := strDesBas;
  qryAux.ParamByName('CODUNI').AsString := strCodUni;

  qryAux.Open;
  Result := qryAux.FieldByName('BAS_CODITE').AsString;
  qryAux.Close;

  FreeAndNil(qryAux);
end;

function fGTinForEucatexImobiliariaDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
  Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;
  Var
    strSQL: String;
    strCamFor: String;
    strCamBas: String;
    intPos: Integer;
    intContador: Integer;

    strColorantes: String;
    dicColorantes: TDicionario;
    qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery(Nil);

  dicColorantes := TDicionario.Create;
  strColorantes := '';

  Result := True;

  strSQL := '';
  strSQL := strSQL + 'SELECT  ';
  strSQL := strSQL + '	*  ';
  strSQL := strSQL + 'FROM  ';
  strSQL := strSQL + '	EUC_CADEUC  ';
  strSQL := strSQL + 'WHERE  ';
  strSQL := strSQl + ' CONCAT(IFNULL(EUC_CODCOR, ""),  ';
  strSQL := strSQl + ' IFNULL(EUC_DESCOR, ""),  ';
  strSQL := strSQl + ' IFNULL(EUC_PRODUT, ""),  ';
  strSQL := strSQl + ' IFNULL(EUC_DESBAS, ""),  ';
  strSQL := strSQl + ' IFNULL(EUC_UNIDAD, ""),  ';
  strSQL := strSQl + ' IFNULL(EUC_CODNFM, ""),  ';
  strSQL := strSQl + ' IFNULL(EUC_OBSCOR, "")) = :CODSEQ ';

  With qryConsulta Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODSEQ').AsString := strIteTin;
    Open;

    If (IsEmpty) Then
    Begin
      Result := False;
      Exit;
    End;

    For intContador := 1 To 6 Do
    Begin

      strCamFor := 'EUC_FORM' + fStrZero(IntToStr(intContador), 2);
      strCamBas := 'EUC_QTDB' + fStrZero(IntToStr(intContador), 2);

      arrFormul[intContador].strFormul := FieldByName(strCamFor).AsString;
      arrFormul[intContador].fltQtdBas := FieldByName(strCamBas).AsFloat * (29.5735295625 / 48);

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
  strSQL := strSQL + '  COL_CODITE ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  EUC_CADCOL ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  COL_CODCOL IN (' + strColorantes + ') ';

  With qryConsulta Do
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
      arrBaixaPigmentos[intPos].fltQtdBaixa := dicColorantes[FieldByName('COL_CODCOL').AsString];
      Inc(intPos);
      Next;
    End;

    Close;
  End;

  FreeAndNil(dicColorantes);
  FreeAndNil(qryConsulta);
end;

function fConsultaEucatexImobiliariaDinamica(Sender: TForm): String; stdcall;
var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Sender);
  Result := fConsultaEucatexImobiliariaDinamicaInterna(Sender, qryGen, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcGeral, False, Nil, Nil);
  FreeAndNil(qryGen);
end;

function fConsultaEucatexImobiliariaDinamicaGeral(Sender: TForm): String; stdcall;
var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Sender);
  Result := fConsultaEucatexImobiliariaDinamicaInterna(Sender, qryGen, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcGeral, False, Nil, Nil);
  FreeAndNil(qryGen);
end;

function fConsultaEucatexImobiliariaDinamicaVenda(Sender: TForm; {strCodEmp: String;}
  qryCadEuc: TUniQuery; strTabPre: String; blnFaturamento: Boolean;
  dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;
begin
  Result := fConsultaEucatexImobiliariaDinamicaInterna(Sender, qryCadEuc, strTabPre, tpcVenda, blnFaturamento, dicRetorno, sltItems);
end;

function fConsultaEucatexImobiliariaDinamicaInterna(Sender: TForm;  qryCadEuc: TUniQuery;
    strTabPre: String; tipoConsulta: TTipoConsulta; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;
begin
  Result := (TEucatexImobiliariaConsulta.Create).fExecutarConsulta(Sender,
    qryCadEuc, tipoConsulta, strTabPre, TfrmConsultaCompEucatexImobiliaria,
    '', blnFaturamento, dicRetorno, sltItems);
end;

procedure pRetornaDadosEucatexImobiliariaDinamica(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryCadEuc: TUniQuery;
    strSQL: String;
begin

  qryCadEuc := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT  ';
  strSQL := strSQL + '	*  ';
  strSQL := strSQL + 'FROM  ';
  strSQL := strSQL + '	EUC_CADEUC ';
  strSQL := strSQL + 'WHERE ';
//  strSQL := strSQL + '	EUC_CODSEQ = :CODSEQ ';
  strSQL := strSQl + ' CONCAT(IFNULL(EUC_CODCOR, ""),  ';
  strSQL := strSQl + ' IFNULL(EUC_DESCOR, ""),  ';
  strSQL := strSQl + ' IFNULL(EUC_PRODUT, ""),  ';
  strSQL := strSQl + ' IFNULL(EUC_DESBAS, ""),  ';
  strSQL := strSQl + ' IFNULL(EUC_UNIDAD, ""),  ';
  strSQL := strSQl + ' IFNULL(EUC_CODNFM, ""),  ';
  strSQL := strSQl + ' IFNULL(EUC_OBSCOR, "")) = :CODSEQ ';

  With qryCadEuc Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODSEQ').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := qryCadEuc.FieldByName('EUC_CODCOR').AsString +
                           qryCadEuc.FieldByName('EUC_DESCOR').AsString +
                           qryCadEuc.FieldByName('EUC_PRODUT').AsString +
                           qryCadEuc.FieldByName('EUC_DESBAS').AsString +
                           qryCadEuc.FieldByName('EUC_UNIDAD').AsString +
                           qryCadEuc.FieldByName('EUC_CODNFM').AsString +
                           qryCadEuc.FieldByName('EUC_OBSCOR').AsString;
    Close;
  End;

  FreeAndNil(qryCadEuc);
end;


procedure pRetornaTabelaPrecoEucatex(dicRetorno: TDicionario);
var
  objFormula: TFormulaEucatexImobiliariaDinamica;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;
            
      objFormula := TFormulaEucatexImobiliariaDinamica.Create('1');
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);

      objFormula.strIteBasOri := GetIteBasOri(dicRetorno['itetin']);
      objFormula.strIteBas := dicRetorno['itebas'];
      
      pRetornaTabelaPrecoImobiliarias(dicRetorno, objFormula, (29.5735295625 / 48));
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

{ TFormulacaoEucatex }

procedure TFormulacaoEucatex.btnFormulacaoEucatexClick(Sender: TObject);
begin
  inherited;
  pCriarFormularios(TfrmFormulacaoImobiliariaEucatex, frmFormulacaoImobiliariaEucatex);
  frmFormulacaoImobiliariaEucatex.objFormula := objFormula;
  frmFormulacaoImobiliariaEucatex.Caption := frmFormulacaoImobiliariaEucatex.Caption + AnsiReplaceStr(objFormula.strDescri, '%s ', '');
  frmFormulacaoImobiliariaEucatex.ShowModal;
  FreeAndNil(frmFormulacaoImobiliariaEucatex);
end;

constructor TFormulacaoEucatex.Create(AOwner: TComponent;
  objFormula: TFormulaImobiliaria);
begin
  inherited Create(AOwner);
  Self. objFormula := objFormula;
end;

{ TfrmConsultaCompEucatexImobiliaria }

procedure TfrmConsultaCompEucatexImobiliaria.pTarefaFormulacao(Sender: TObject);
  Var
    qryGen: TUniQuery;
    strDesBas: String;
    strUniBas: String;
    strDesCor: String;
    fltPreCus: Double;
    strNovBas: String;
    strRefere: String;
    fltPreVen: Double;
begin
  inherited;
  If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
    Exit;

  qryGen := fCriaQuery(Self);
  qryGen.SQL.Add('SELECT * FROM EUC_CADEUC WHERE AUTOINCREM = :AUTINC');
  qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
  qryGen.Open;

  fDigDadosTintometricos(qryGen, strTabPre,
                         strNovBas, strDesBas, strRefere, strUniBas, strDesCor,
                         fltPreCus, fltPreVen, TDicionario.Create);

  FreeAndNil(qryGen);
end;

procedure TfrmConsultaCompEucatexImobiliaria.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompEucatexImobiliaria.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadEucNovasFormulas', False);
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
        ' SELECT                                ' +
        '   B.BAS_CODITE                        ' +
        ' FROM                                  ' +
        '   EUC_CADEUC E                        ' +
        '   INNER JOIN EUC_CADBAS B             ' +
        '     ON E.EUC_DESBAS = B.BAS_DESCRI    ' +
        '     AND E.EUC_PRODUT = B.BAS_PRODUT   ' +
        '     AND E.EUC_UNIDAD = B.BAS_CODUNI   ' +
        ' WHERE CONCAT(                         ' +
        '     IFNULL(E.EUC_CODCOR, '''')        ' +
        '     , IFNULL(E.EUC_DESCOR, '''')      ' +
        '     , IFNULL(E.EUC_PRODUT, '''')      ' +
        '     , IFNULL(E.EUC_DESBAS, '''')      ' +
        '     , IFNULL(E.EUC_UNIDAD, '''')      ' +
        '     , IFNULL(E.EUC_CODNFM, '''')      ' +
        '     , IFNULL(E.EUC_OBSCOR, '''')      ' +
        '   ) = :ITETIN                         ';
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
