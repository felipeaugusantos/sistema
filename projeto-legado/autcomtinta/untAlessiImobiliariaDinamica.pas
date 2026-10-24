unit untAlessiImobiliariaDinamica;

interface

uses
  untFuncEspecificas, Forms, Classes, Uni, untFuncoesSimples, strUtils,
  SysUtils, Controls, untPnlBotoesAcoesNovaConsulta,
  UniClientDataSet;

Type
  TfrmConsultaCompAlessiImobiliaria = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;


  TFormulaAlessiImobiliariaDinamica = class(TFormulaImobiliaria)
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

  TFormulacaoAlessi = class(TComponent)
  protected
    objFormula: TFormulaImobiliaria;
  public
    constructor Create(AOwner: TComponent; objFormula: TFormulaImobiliaria); reintroduce;
    procedure btnFormulacaoAlessiClick(Sender: TObject);
  End;

  function fRetornaPrecoAlessiImobiliariaDinamica(Sender: TForm; qryCadAle: TUniQuery;
    Var dicRetorno: TDicionario; blnFaturamento: Boolean; strTab: String = 'N';
    strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;

  function fRetornaUniTraProAlessiImobiliariaDinamica(fltPrcTin, fltPrvTin: Double): Double;

  function fRetornaDescricaoAlessiImobiliariaDinamica(strDesCor: String; qryCadAle: TUniQuery): String;

  function fDigDadosTintometricos(qryCadAle: TUniClientDataSet; strTabPre: String;
    Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
    Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;

  function fRetornaProdutoBase(strProd, strBase, strEmbala: String): String;

  function fGTinForAlessiImobiliariaDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;

  function fConsultaAlessiImobiliariaDinamica(Sender: TForm): String; stdcall;
  function fConsultaAlessiImobiliariaDinamicaGeral(Sender: TForm): String; stdcall;
  function fConsultaAlessiImobiliariaDinamicaVenda(Sender: TForm; {strCodEmp: String;}
    qryCadAle: TUniQuery; strTabPre: String;
    blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;

  function fConsultaAlessiImobiliariaDinamicaInterna(Sender: TForm;  qryCadAle: TUniQuery;
    strTabPre: String; tipoConsulta: TTipoConsulta; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;

  procedure pRetornaDadosAlessiImobiliariaDinamica(strIteTin: String; dicRetorno: TDicionario);

  procedure pRetornaTabelaPrecoAlessi(dicRetorno: TDicionario);

  function OncaParaMl(intParteInteira: Integer; fltParteFracao: Double): Double;

  function GetIteBasOri(const strIteTin: string): string;



implementation

uses untDigTintaImobiliaria, untFormulacaoImobiliariaAlessi, untAlessiImobiliariaConsulta,
  untGenericTintaDeMaquinaComponente, Data.DB,untITintaDeMaquinaComponente,untTintaMaquina,
  untTintaDeMaquinaComponenteComparerColorante, untTintaDeMaquinaComponenteComparerBaseImobiliaria, untMultiSelectLocalizadorFactory,
  untClientDataSetFactory,untFuncoes,untIConfTinta,untICalculadorFatVendas,untTintaDeMaquinaComponenteTipo,untIConsultaTinta;


{ TFormulaAlessiImobiliariaDinamica }

constructor TFormulaAlessiImobiliariaDinamica.Create(strTabPrePar: String);
  Var
    conf: IConfTinta;
begin
  inherited;
  conf := fGetConfTinta('ALE');
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;
end;


procedure TFormulaAlessiImobiliariaDinamica.pCalculaPreco;
var
  objColorante: TColoranteImobiliario;
  intIndex: Integer;
  componente: ITintaDeMaquinaComponente;
  cdsCadCol: TUniClientDataSet;
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

  cdsCadCol := TClientDataSetFactory.GetClientDataSet(qryCadCol);

  For intIndex := 0 To Count -1 Do
  Begin

    objColorante := TColoranteImobiliario(Items[intIndex]);

    If (Not cdsCadCol.Locate('COL_CODCOL', objColorante.strCodcol, [])) And (Pos(objColorante.strCodcol, objColErros) = 0) Then
    Begin
      pZerarPrecos;
      fMensagem('', 'Colorante ' + objColorante.strCodCol + ' não cadastrado. Favor verificar.', ['OK']);
      objColErros := objColErros + '_' + objColorante.strCodCol + '_';
      Continue;
    End;

    If (fEmptyStr(cdsCadCol.FieldByName('COL_CODITE').AsString))  And (Pos(objColorante.strCodcol, objColErros) = 0) Then
    Begin
      pZerarPrecos;
      fMensagem('', 'Colorante ' + objColorante.strCodCol + ' não está com o produto para venda associado.' + #13#10 +
                             'Favor verificar.', ['OK']);
      objColErros := objColErros + '_' + objColorante.strCodCol + '_';
      Continue;
    End;

    If (cdsCadCol.FieldByName('ITE_CNV_ML').AsFloat <= 0) And (Pos(objColorante.strCodcol, objColErros) = 0) Then
    Begin
      pZerarPrecos;
      fMensagem('', 'O produto ' + cdsCadCol.FieldByName('COL_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                             'preenchido corretamente. Favor verificar.', ['OK']);
      objColErros := objColErros + '_' + objColorante.strCodCol + '_';
      Continue;
    End;

    componente := tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerColorante.Create(objColorante.strCodCol));
    if not Assigned(componente) then
    begin
      componente := tintaDeMaquina.Adicionar(TGenericTintaDeMaquinaComponente.Create(
        objColorante.strCodIte, objColorante.strCodCol, tmctColoranteImobiliario
      ));
    end;

    if not IsItemAtivo(cdsCadCol.FieldByName('COL_CODITE').AsString) then
    begin
      pZerarPrecos;
      raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [cdsCadCol.FieldByName('COL_CODITE').AsString]);
    end;

    componente.Quantidade := objColorante.fltQtdCol;
    componente.PrecoCusto := (objColorante.fltQtdCol) * (objColorante.fltPreCus / 1000);
    componente.PrecoCustoReal := (objColorante.fltQtdCol) * (objColorante.fltPreCu2 / 1000);
    componente.PrecoVenda := (objColorante.fltQtdCol) * (objColorante.fltPreVen / 1000);
    componente.PrecoMedio := objColorante.fltPreMed * objColorante.fltQtdCol / 1000;
    componente.OutrosValores := objColorante.fltOutVal * objColorante.fltQtdCol / 1000;
    componente.IcmsSaida := objColorante.fltIcmSai * (objColorante.fltPreVen * objColorante.fltQtdCol / 1000) / 100;
    componente.ImpostosFederais := objColorante.fltImpFed * (objColorante.fltPreVen * objColorante.fltQtdCol / 1000) / 100;
    componente.DespesasOperacionais := objColorante.fltDesOpe * (objColorante.fltPreVen * objColorante.fltQtdCol / 1000) / 100;

    componente.UltimoPrecoCompra := (objColorante.fltQtdCol) * (objColorante.fltPreUlt / 1000);
    componente.UltimoPrecoCompraImpostos := (objColorante.fltQtdCol) * (objColorante.fltImpUlt / 1000);
    componente.PrecoCompraLiquido := (objColorante.fltQtdCol) * (objColorante.fltComLiq / 1000);
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

  FPreCus := tintaDeMaquina.GetPrecoCustoComponentes + tintaDeMaquina.GetPrecoCustoEmbalagemBase;
  FPreCu2 := tintaDeMaquina.GetPrecoCustoRealComponentes + tintaDeMaquina.GetPrecoCustoRealEmbalagemBase;
  FPreVen := tintaDeMaquina.GetPrecoVendaComponentes + (fltPerAcr * tintaDeMaquina.GetPrecoVendaComponentes) +
             tintaDeMaquina.GetPrecoVendaEmbalagemBase;

  FPreUlt := tintaDeMaquina.GetUltimoPrecoCompraComponentes;;
  FImpUlt := tintaDeMaquina.GetUltimoPrecoCompraImpostosComponentes;
  FComLiq := tintaDeMaquina.GetPrecoCompraLiquidoComponentes;

  If Not (fEmptyStr(objColErros)) Then
    Exit;

  FPreCus := FCusBas + FCusCol;
  FPreCu2 := FCu2Bas + FCu2Col;
  FPreVen := FVenBas + FVenCol;
end;

procedure TFormulaAlessiImobiliariaDinamica.pCarregaPrecosColorantes;
var
  intContador: Integer;
  objColorante: TColoranteImobiliario;
  cdsCadCol: TUniClientDataSet;
  conf: IConfTinta;
  fltDesOpeTinta: Double;
  fltPreCusPro: Double;
  fltPreVenPro: Double;

begin
  conf := fGetConfTinta('ALE');
  fltDesOpeTinta := conf.fGetDouble('DESOPE');

  cdsCadCol := TClientDataSetFactory.GetClientDataSet(qryCadCol);

  For intContador := 0 To Self.Count - 1 Do
  Begin
    objColorante := TColoranteImobiliario(Self.Items[intContador]);

    cdsCadCol.Locate('COL_CODCOL', objColorante.strCodCol, []);

    If fCarregaPromocao(cdsCadCol.FieldByName('COL_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
    begin
      objColorante.fltPreCus := fltPreCusPro;
      objColorante.fltPreVen := fltPreVenPro;

      FPromoc := 'S';

      If fltPreCusPro = 0 Then
        objColorante.fltPreCus := cdsCadCol.FieldByName('ITE_PRECUS').AsFloat;
    end
    Else
    Begin
      objColorante.fltPreCus := cdsCadCol.FieldByName('ITE_PRECUS').AsFloat;
      objColorante.fltPreVen := cdsCadCol.FieldByName('ITE_PREVEN').AsFloat;
    End;

    objColorante.strImpDir := cdsCadCol.FieldByName('ITE_IMPDIR').AsString;
    objColorante.strCodIte := cdsCadCol.FieldByName('COL_CODITE').AsString;

    objColorante.fltOutVal := cdsCadCol.FieldByName('ITE_OUTVAL').AsFloat;

    if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
      objColorante.fltIcmSai := calculadorFatVendas.fCalculaAliquota(objColorante.strCodIte, objColorante.strImpDir)
    else
      objColorante.fltIcmSai := cdsCadCol.FieldByName('ITE_ICMSAI').AsFloat;

    objColorante.fltImpFed := cdsCadCol.FieldByName('ITE_IMPFED').AsFloat;
    objColorante.fltDesOpe := cdsCadCol.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;
    objColorante.fltPreMed := cdsCadCol.FieldByName('ITE_PREMED').AsFloat;

    objColorante.fltPreUlt := cdsCadCol.FieldByName('ITE_PREULT').AsFloat;
    objColorante.fltImpUlt := cdsCadCol.FieldByName('ITE_IMPULT').AsFloat;
    objColorante.fltComLiq := fCalculaPrecoCompraLiq(cdsCadCol.Fieldbyname('ITE_PRECOM').AsFloat, cdsCadCol.Fieldbyname('ITE_DESF01').AsFloat,
                                                     cdsCadCol.Fieldbyname('ITE_DESF02').AsFloat, cdsCadCol.Fieldbyname('ITE_DESF03').AsFloat,
                                                     cdsCadCol.Fieldbyname('ITE_DESF04').AsFloat, cdsCadCol.Fieldbyname('ITE_DESF05').AsFloat,
                                                     cdsCadCol.Fieldbyname('ITE_DESF06').AsFloat);    
  End;

  FCalculo.Add('Valor da Base = ' + FloatToStrF(fltVenBas, ffFixed, 12, 2));
  FCalculo.Add('Quantidade em ML = (Parte Inteira * 29.5735295625) + (Parte Fração * 0.61611520)');
  FCalculo.Add('Valor do Colorante = (Quantidade) * (Preço / 1000)');
  FCalculo.Add('Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)');
end;

procedure TFormulaAlessiImobiliariaDinamica.pCarregarColorantes;
begin
  Try
    qryCadCol.SQL.Clear;
    qryCadCol.SQL.Add(' SELECT                             ');
    qryCadCol.SQL.Add('   COL_CODCOL                       ');
    qryCadCol.SQL.Add('   , COL_CODITE                     ');
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
    qryCadCol.SQL.Add('   ALE_CADCOL                       ');
    qryCadCol.SQL.Add('   JOIN ITEGER G                    ');
    qryCadCol.SQL.Add('     ON G.ITE_CODITE = COL_CODITE   ');
    qryCadCol.SQL.Add('   LEFT JOIN CADITE I               ');
    qryCadCol.SQL.Add('     ON I.ITE_CODITE = COL_CODITE   ');
    qryCadCol.SQL.Add(' WHERE G.ITE_CODEMP = :CODEMP       ');

    qryCadCol.ParamByName('CODEMP').AsString := VS_strCodEmp;
    TClientDataSetFactory.GetClientDataSet(qryCadCol);
  Except
    on E: Exception do
    begin
      raise;
    end;
  End;
end;

procedure TFormulaAlessiImobiliariaDinamica.SetIteBas(
  const Value: String);
var
  qryAux        : TUniQuery;
  fltIcmsai     : Double;
  base          : ITintaDeMaquinaComponente;
  cdsAux        : TUniClientDataSet;
  conf          : IConfTinta;
  fltDesOpeTinta: Double;
  fltPreCusPro  : Double;
  fltPreVenPro  : Double;

  function fPrecoCusto2Base(const fltPreCus, fltPreVen: Double): Double;
  begin
    Result := fCalculaPrecoCusto2(fltPreVen,
      fltPreCus,
      cdsAux.FieldByName('ITE_OUTVAL').AsFloat,
      fltIcmsai,
      cdsAux.FieldByName('ITE_IMPFED').AsFloat,
      cdsAux.FieldByName('ITE_DESOPE').AsFloat);
  end;
begin
  tintaDeMaquina.Remover(tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(FIteBas)));
  tintaDeMaquina.Remover(tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(FIteBasOri)));
  inherited;
  conf := fGetConfTinta('ALE');
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
          qryAux.SQL.Add('   ALE_CADBAS B                       ');
          qryAux.SQL.Add('   INNER JOIN CADITE I                ');
          qryAux.SQL.Add('     ON B.BAS_CODITE = I.ITE_CODITE   ');
          qryAux.SQL.Add('   INNER JOIN ITEGER G                ');
          qryAux.SQL.Add('     ON I.ITE_CODITE = G.ITE_CODITE   ');
          qryAux.SQL.Add(' WHERE I.ITE_CODITE = :CODITE         ');
          qryAux.SQL.Add('   AND G.ITE_CODEMP = :CODEMP         ');

          qryAux.ParamByName('CODITE').AsString := FIteBas;
          qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
          cdsAux := TClientDataSetFactory.GetClientDataSet(qryAux);


          If fCarregaPromocao(FIteBas, fTabPreco, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
          Begin
            FCusBasOri := fltPreCusPro;
            FVenBasOri := fltPreVenPro;
            FPromoc := 'S';

            If FCusBasOri = 0 Then
              FCusBasOri := cdsAux.FieldByName('ITE_PRECUS').AsFloat;
          End
          Else
          Begin
            FCusBasOri := cdsAux.FieldByName('ITE_PRECUS').AsFloat;
            FVenBasOri := cdsAux.FieldByName('ITE_PREVEN').AsFloat;
            FPromoc    := 'N';
          End;

          FVenBasOri := FVenBasOri + (fltPerAcr * FVenBasOri);

          FOutValBas := cdsAux.FieldByName('ITE_OUTVAL').AsFloat;

          if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
          begin
            fltIcmsai := calculadorFatVendas.fCalculaAliquota(Value, cdsAux.FieldByName('ITE_IMPDIR').AsString);
            FIcmsaiBas := fltIcmsai * FVenBasOri / 100;
          end
          else
          begin
            fltIcmsai := cdsAux.FieldByName('ITE_ICMSAI').AsFloat;
            FIcmsaiBas := fltIcmsai * FVenBasOri / 100;
          end;


          FImpFedBas := cdsAux.FieldByName('ITE_IMPFED').AsFloat * FVenBasOri / 100;
          FDesOpeBas := (((cdsAux.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta) * FVenBasOri) / 100);
          FPreMedBas := cdsAux.FieldByName('ITE_PREMED').AsFloat;
          FCu2BasOri := fPrecoCusto2Base(FCusBasOri, FVenBasOri);

          FPreUltBas := cdsAux.FieldByName('ITE_PREULT').AsFloat;
          FImpUltBas := cdsAux.FieldByName('ITE_IMPULT').AsFloat;
          FComLiqBas := fCalculaPrecoCompraLiq(cdsAux.Fieldbyname('ITE_PRECOM').AsFloat, cdsAux.Fieldbyname('ITE_DESF01').AsFloat,
                                               cdsAux.Fieldbyname('ITE_DESF02').AsFloat, cdsAux.Fieldbyname('ITE_DESF03').AsFloat,
                                               cdsAux.Fieldbyname('ITE_DESF04').AsFloat, cdsAux.Fieldbyname('ITE_DESF05').AsFloat,
                                               cdsAux.Fieldbyname('ITE_DESF06').AsFloat);
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
        cdsAux := TClientDataSetFactory.GetClientDataSet(qryAux);

        If fCarregaPromocao(FIteBas, fTabPreco, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
        Begin
          FCusBas := fltPreCusPro;
          FVenBas := fltPreVenPro;
          FPromoc := 'S';

          If FCusBas = 0 Then
            FCusBas := cdsAux.FieldByName('ITE_PRECUS').AsFloat;
        End
        Else
        Begin
          FCusBas := cdsAux.FieldByName('ITE_PRECUS').AsFloat;
          FVenBas := cdsAux.FieldByName('ITE_PREVEN').AsFloat;
          FPromoc := 'N';
        End;

        FVenBas := FVenBas + (fltPerAcr * FCusBas);


        FOutValBas := cdsAux.FieldByName('ITE_OUTVAL').AsFloat;

        if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
        begin
          fltIcmsai := calculadorFatVendas.fCalculaAliquota(Value, cdsAux.FieldByName('ITE_IMPDIR').AsString);
          FIcmsaiBas := fltIcmsai * FVenBas / 100;
        end
        else
        begin
          fltIcmsai := cdsAux.FieldByName('ITE_ICMSAI').AsFloat;
          FIcmsaiBas := fltIcmsai * FVenBas / 100;
        end;

        FImpFedBas := cdsAux.FieldByName('ITE_IMPFED').AsFloat * FVenBas / 100;
        FDesOpeBas := (((cdsAux.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta) * FVenBas) / 100);
        FCu2Bas := fPrecoCusto2Base(FCusBas, FVenBas);
        FPreMedBas := cdsAux.FieldByName('ITE_PREMED').AsFloat;
        FPreUltBas := cdsAux.FieldByName('ITE_PREULT').AsFloat;
        FImpUltBas := cdsAux.FieldByName('ITE_IMPULT').AsFloat;
        FComLiqBas := fCalculaPrecoCompraLiq(cdsAux.Fieldbyname('ITE_PRECOM').AsFloat, cdsAux.Fieldbyname('ITE_DESF01').AsFloat,
                                             cdsAux.Fieldbyname('ITE_DESF02').AsFloat, cdsAux.Fieldbyname('ITE_DESF03').AsFloat,
                                             cdsAux.Fieldbyname('ITE_DESF04').AsFloat, cdsAux.Fieldbyname('ITE_DESF05').AsFloat,
                                             cdsAux.Fieldbyname('ITE_DESF06').AsFloat);
      End;

//      FOutValBas := fFormataFloat(FOutValBas, fCfgSis('DECUNI', varInteger));
//      FIcmsaiBas := fFormataFloat(FIcmsaiBas, fCfgSis('DECUNI', varInteger));
//      FImpFedBas := fFormataFloat(FImpFedBas, fCfgSis('DECUNI', varInteger));
//      FDesOpeBas := fFormataFloat(FDesOpeBas, fCfgSis('DECUNI', varInteger));
//      FPreMedBas := fFormataFloat(FPreMedBas, fCfgSis('DECUNI', varInteger));

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

function fRetornaPrecoAlessiImobiliariaDinamica(Sender: TForm; qryCadAle: TUniQuery;
  Var dicRetorno: TDicionario; blnFaturamento: Boolean; strTab: String = 'N';
  strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;
var
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
  cdsCadAle: TUniClientDataSet;
  conf: IConfTinta;
begin
  conf := fGetConfTinta('ALE');

  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTabPre    := dicRetorno['tabpre'];

  Result := False;

  If strTab = 'N' Then
  Begin
    strAuto := fConsultaAlessiImobiliariaDinamicaVenda(Sender, qryCadAle, strTabPre, blnFaturamento, dicRetorno, sltItems);

    If (strAuto = '-1') Then
    Begin
      Exit;
    End;
  End
  Else
    strAuto := strAutoTab;

  tinta := TAlessiImobiliariaConsulta.Create;

  qryCadAle.Close;
  qryCadAle.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
  cdsCadAle := TClientDataSetFactory.GetClientDataSet(qryCadAle);

  If (Not fDigDadosTintometricos(cdsCadAle, strTabPre, strCodIte, strDesBas,
        strRefBas, strUniBas, strDesCor, fltPreCus, fltUnitar, dicRetorno)) Then
  Begin
    Exit;
  End;

  strDesCor := Trim(strDesCor + ' ' + tinta.fGetDescricao(cdsCadAle.FieldbyName('AUTOINCREM').AsString, strCodIte));
  strIteTin := cdsCadAle.FieldByName('ALE_MD5KEY').AsString;

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

function fRetornaUniTraProAlessiImobiliariaDinamica(fltPrcTin, fltPrvTin: Double): Double;
  Var
    strSiglaTrava: String;
    fltFatTrava: Double;
    conf: IConfTinta;
begin
  conf     := fGetConfTinta('ALE');
  strSiglaTrava := conf.fGet('ALEPRE');
  fltFatTrava   := conf.fGetDouble('ALEFAT');

  If strSiglaTrava = 'CUS' Then
    Result := fltPrcTin
  Else
    Result := fltPrvTin;

  Result := Result * fltFatTrava;
end;

function fRetornaDescricaoAlessiImobiliariaDinamica(strDesCor: String; qryCadAle: TUniQuery): String;
begin
  Result := strDesCor;
end;

function fDigDadosTintometricos(qryCadAle: TUniClientDataSet; strTabPre: String;
  Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
  Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;
var
  objColorante: TColoranteImobiliario;
  objFormula: TFormulaAlessiImobiliariaDinamica;
  intContador: Integer;
  formulacaoAlessi: TFormulacaoAlessi;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  frmDigTintaImobiliaria := nil;
  objFormula := nil;
  Result := False;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaAlessiImobiliariaDinamica.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltFatorEstoque := 1;
      objFormula.strCodCli    := IfNull(dicRetorno['codcli'], '');
      objFormula.strOpcDoc    := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCnd    := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed    := IfNull(dicRetorno['przmed'], 0);
      objFormula.strIteBasOri := fRetornaProdutoBase(qryCadAle.FieldByName('ALE_PRODUT').AsString,
                                                     qryCadAle.FieldByName('ALE_BASE__').AsString,
                                                     qryCadAle.FieldByName('ALE_EMBALA').AsString);

      objFormula.strIteBas    := objFormula.strIteBasOri;
      objFormula.strUnidad    := qryCadAle.FieldByName('EMB_CODUNI').AsString;

      objFormula.strDescri    := qryCadAle.FieldByName('ALE_PRODUT').AsString + ' ' +
                                 qryCadAle.FieldByName('ALE_BASE__').AsString + ' ' +
                                 qryCadAle.FieldByName('EMB_CODUNI').AsString;

      For intContador := 1 To 20 Do
      Begin

        If (fEmptyStr(qryCadAle.FieldByName('ALE_CODC' + fStrZero(intContador, 2)).AsString)) Then
          Break;

        objColorante := TColoranteImobiliario(objFormula.Add);
        objColorante.strCodCol := qryCadAle.FieldByName('ALE_CODC' + fStrZero(intContador, 2)).AsString;
        objColorante.fltQtdCol := OncaParaMl(qryCadAle.FieldByName('ALE_QTOZ' + fStrZero(intContador, 2)).AsInteger,
                                    qryCadAle.FieldByName('ALE_QSHO' + fStrZero(intContador, 2)).AsFloat) ;

      End;

      objFormula.pCarregaPrecosColorantes;
      objFormula.pCalculaPreco;

      formulacaoAlessi := TFormulacaoAlessi.Create(nil, objFormula);

      Result := False;
      Application.CreateForm(TfrmDigTintaImobiliaria, frmDigTintaImobiliaria);
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTintaImobiliaria.btnFormulacao.OnClick := formulacaoAlessi.btnFormulacaoAlessiClick;
      frmDigTintaImobiliaria.Caption := frmDigTintaImobiliaria.Caption + 'Alessi Imobiliária';
      frmDigTintaImobiliaria.objFormula := objFormula;
      frmDigTintaImobiliaria.strIdePro := 'ALE';
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

        If (Result) And (Assigned(dicRetorno)) Then
        Begin
          objFormula.pRecalculaTabelas(dicRetorno);
        End;
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

function fRetornaProdutoBase(strProd, strBase, strEmbala: String): String;
var
  qryAux: TUniQuery;
begin
  qryAux := nil;
  Try
    Try
      qryAux := fCriaQuery(Nil);
      qryAux.SQL.Text :=
        ' SELECT                       ' +
        '   BAS_CODITE                 ' +
        ' FROM                         ' +
        '   ALE_CADBAS                 ' +
        ' WHERE BAS_PRODUT = :PRODUT   ' +
        '   AND BAS_BASE__ = :BASE     ' +
        '   AND BAS_EMBALA = :EMBALA   ';

      qryAux.ParamByName('PRODUT').AsString := strProd;
      qryAux.ParamByName('BASE').AsString := strBase;
      qryAux.ParamByName('EMBALA').AsString := strEmbala;

      qryAux.Open;
      Result := qryAux.FieldByName('BAS_CODITE').AsString;
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

function fGTinForAlessiImobiliariaDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
  Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;
var
  strSQL: String;
  strCamFor: String;
  intPos: Integer;
  intContador: Integer;

  strColorantes: String;
  dicColorantes: TDicionario;
  qryConsulta: TUniClientDataSet;
  qryColorantes: TUniQuery;
  cdsColorantes: TUniClientDataSet;
begin
  Result := False;
  qryColorantes := nil;
  dicColorantes := nil;

  Try
    Try
      dicColorantes := TDicionario.Create;
      strColorantes := '';

      Result := TMultiSelectLocalizadorFactory.GetLocalizador('ALE').Localizar(qryConsulta, ['ITETIN'], [strIteTin]);

      if not Result then
        Exit;

      For intContador := 1 To 20 Do
      Begin

        strCamFor := 'ALE_CODC' + fStrZero(IntToStr(intContador), 2);

        arrFormul[intContador].strFormul := qryConsulta.FieldByName(strCamFor).AsString;
        arrFormul[intContador].fltQtdBas := OncaParaMl(qryConsulta.FieldByName('ALE_QTOZ' + fStrZero(IntToStr(intContador), 2)).AsInteger,
                                              qryConsulta.FieldByName('ALE_QSHO' + fStrZero(IntToStr(intContador), 2)).AsFloat);

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

      strSQL :=
        ' SELECT                  ' +
        '   COL_CODCOL            ' +
        '   , COL_CODITE          ' +
        ' FROM                    ' +
        '   ALE_CADCOL            ' +
        ' WHERE ' + GetInToOr('COL_CODCOL', strColorantes);

      qryColorantes := fCriaQuery();
      qryColorantes.Close;
      qryColorantes.SQL.Clear;
      qryColorantes.SQL.Add(strSQL);
      cdsColorantes := TClientDataSetFactory.GetClientDataSet(qryColorantes);

      intPos := 0;
      SetLength(arrBaixaPigmentos, cdsColorantes.RecordCount);

      While (Not cdsColorantes.Eof) Do
      Begin

        {*******************************************}
        {* ITENS QUE TEM QUE FAZER TRANSFERENCIA   *}
        {* DE SALDO EM ML                          *}
        {****************************************MV*}
        stlItensTraMl.Add(cdsColorantes.FieldByName('COL_CODITE').AsString);

        arrBaixaPigmentos[intPos].strCodIte   := cdsColorantes.FieldByName('COL_CODITE').AsString;
        arrBaixaPigmentos[intPos].fltQtdBaixa := dicColorantes[cdsColorantes.FieldByName('COL_CODCOL').AsString];
        Inc(intPos);
        cdsColorantes.Next;
      End;

      Result := True;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(dicColorantes) then FreeAndNil(dicColorantes);
    if Assigned(qryColorantes) then FreeAndNil(qryColorantes);
  End;
end;

function fConsultaAlessiImobiliariaDinamica(Sender: TForm): String; stdcall;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery(Sender);
      Result := fConsultaAlessiImobiliariaDinamicaInterna(Sender, qryGen, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcGeral, False, Nil, Nil);
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

function fConsultaAlessiImobiliariaDinamicaGeral(Sender: TForm): String; stdcall;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery(Sender);
      Result := fConsultaAlessiImobiliariaDinamicaInterna(Sender, qryGen, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcGeral, False, Nil, Nil);
      FreeAndNil(qryGen);
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

function fConsultaAlessiImobiliariaDinamicaVenda(Sender: TForm; {strCodEmp: String;}
  qryCadAle: TUniQuery; strTabPre: String;
  blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;
begin
  Result := fConsultaAlessiImobiliariaDinamicaInterna(Sender, qryCadAle, strTabPre, tpcVenda,
    blnFaturamento, dicRetorno, sltItems);
end;

function fConsultaAlessiImobiliariaDinamicaInterna(Sender: TForm;  qryCadAle: TUniQuery;
    strTabPre: String; tipoConsulta: TTipoConsulta; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;
begin
  Result := (TAlessiImobiliariaConsulta.Create).fExecutarConsulta(Sender,
    qryCadAle, tipoConsulta, strTabPre, TfrmConsultaCompAlessiImobiliaria,
    '', blnFaturamento, dicRetorno, sltItems);
end;

procedure pRetornaDadosAlessiImobiliariaDinamica(strIteTin: String; dicRetorno: TDicionario);
var
  qryCadAle: TUniClientDataSet;
begin
  Try
    Try
      if not TMultiSelectLocalizadorFactory.GetLocalizador('ALE').Localizar(qryCadAle, ['ITETIN'], [strIteTin]) then
        Exit;

      dicRetorno['codtin'] := qryCadAle.FieldByName('ALE_PRODUT').AsString +
                             qryCadAle.FieldByName('ALE_BASE__').AsString +
                             qryCadAle.FieldByName('EMB_CODUNI').AsString +
                             qryCadAle.FieldByName('ALE_NOMCOR').AsString +
                             qryCadAle.FieldByName('ALE_NOMLON').AsString +
                             qryCadAle.FieldByName('ALE_CODNFM').AsString;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;


procedure pRetornaTabelaPrecoAlessi(dicRetorno: TDicionario);
var
  objFormula: TFormulaAlessiImobiliariaDinamica;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaAlessiImobiliariaDinamica.Create('1');
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;
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

{ TFormulacaoAlessi }

procedure TFormulacaoAlessi.btnFormulacaoAlessiClick(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TfrmFormulacaoImobiliariaAlessi, frmFormulacaoImobiliariaAlessi);
  frmFormulacaoImobiliariaAlessi.objFormula := objFormula;
  frmFormulacaoImobiliariaAlessi.Caption := frmFormulacaoImobiliariaAlessi.Caption + AnsiReplaceStr(objFormula.strDescri, '%s ', '');
  frmFormulacaoImobiliariaAlessi.ShowModal;
  FreeAndNil(frmFormulacaoImobiliariaAlessi);
end;

constructor TFormulacaoAlessi.Create(AOwner: TComponent;
  objFormula: TFormulaImobiliaria);
begin
  inherited Create(AOwner);
  Self. objFormula := objFormula;
end;

{ TfrmConsultaCompAlessiImobiliaria }

procedure TfrmConsultaCompAlessiImobiliaria.pTarefaFormulacao(Sender: TObject);
var
  qryGen: TUniQuery;
  strDesBas: String;
  strUniBas: String;
  strDesCor: String;
  fltPreCus: Double;
  strNovBas: String;
  strRefere: String;
  fltPreVen: Double;
  cdsGen: TUniClientDataSet;
begin
  inherited;
  qryGen := nil;
  Try
    Try
      If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
        Exit;

      qryGen := fCriaQuery(Self);
      qryGen.SQL.Text :=
        ' SELECT                                ' +
        '   *                                   ' +
        ' FROM                                  ' +
        '   ALE_CADALE                          ' +
        '   INNER JOIN ALE_CADBAS               ' +
        '     ON ALE_PRODUT = BAS_PRODUT        ' +
        '     AND ALE_BASE__ = BAS_BASE__       ' +
        '     AND ALE_EMBALA = BAS_EMBALA       ' +
        '   INNER JOIN ALE_CADEMB               ' +
        '     ON BAS_EMBALA = EMB_NOME__        ' +
        '   INNER JOIN CADUNI                   ' +
        '     ON EMB_CODUNI = UNI_CODUNI        ' +
        '   INNER JOIN CADITE                   ' +
        '     ON BAS_CODITE = ITE_CODITE        ' +
        ' WHERE ALE_CADALE.AUTOINCREM = :AUTINC ';
      qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
      cdsGen := TClientDataSetFactory.GetClientDataSet(qryGen);

      fDigDadosTintometricos(cdsGen, strTabPre,
                             strNovBas, strDesBas, strRefere, strUniBas, strDesCor,
                             fltPreCus, fltPreVen, TDicionario.Create);
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

procedure TfrmConsultaCompAlessiImobiliaria.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompAlessiImobiliaria.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadAleNovasFormulas', False);
end;

function OncaParaMl(intParteInteira: Integer; fltParteFracao: Double): Double;
begin
  Result := (intParteInteira * 29.574) + (fltParteFracao * 0.616125);
end;

function GetIteBasOri(const strIteTin: string): string;
var
  qryGen: TUniClientDataSet;
begin
  Result := '';
  qryGen := nil;
  Try
    Try
      if TMultiSelectLocalizadorFactory.GetLocalizador('ALEBAS').Localizar(qryGen, ['ITETIN'], [strIteTin]) then
        Result := qryGen.FieldByName('BAS_CODITE').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

end.

