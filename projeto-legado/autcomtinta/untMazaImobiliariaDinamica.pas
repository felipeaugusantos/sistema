unit untMazaImobiliariaDinamica;

interface

uses
  untFuncEspecificas, Forms, Classes, UniClientDataSet, untFuncoesSimples, strUtils,
  SysUtils, Controls, Math, Dialogs, Uni, Data.DB,
  untIConfTinta, untPnlBotoesAcoesNovaConsulta;

Type
  TfrmConsultaCompMazaImobiliaria = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;


  TFormulaMazaImobiliariaDinamica = class(TFormulaImobiliaria)
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

  function fRetornaPrecoMazaImobiliariaDinamica(Sender: TForm; qryCadMzi: TUniQuery;
    Var dicRetorno: TDicionario; blnFaturamento: Boolean; strTab: String = 'N';
    strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;

  function fRetornaUniTraProMazaImobiliariaDinamica(fltPrcTin, fltPrvTin: Double): Double;

  function fRetornaDescricaoMazaImobiliariaDinamica(strDesCor: String; qryCadMzi: TUniQuery): String;

  function fDigDadosTintometricos(qryCadMzi: TUniQuery; strTabPre: String;
    Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
    Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;

  function fRetornaProdutoBase(strCodBas, strProd: String; strUnidad: String): String;

  function fGTinForMazaImobiliariaDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;

  function fConsultaMazaImobiliariaDinamica(Sender: TForm): String; stdcall;
  function fConsultaMazaImobiliariaDinamicaGeral(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaMazaImobiliariaDinamicaVenda(Sender: TForm; strCodEmp: String;
    qryCadMzi: TUniQuery; blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;

  function fConsultaMazaImobiliariaDinamicaInterna(Sender: TForm;  qryCadMzi: TUniQuery;
    strTabPre: String; tipoConsulta: TTipoConsulta; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;

  procedure pRetornaDadosMazaImobiliariaDinamica(strIteTin: String; dicRetorno: TDicionario);
  procedure pRetornaTabelaPrecoMazaImobiliaria(dicRetorno: TDicionario);
  function GetIteBasOri(const strIteTin: string): string;


implementation

uses untDigTintaImobiliaria,
  untFuncoes,
  untIConsultaTinta,
  untICalculadorFatVendas,
  untITintaDeMaquinaComponente,
  untTintaMaquina,
  untMazaImobiliariaConsulta,
  untGenericTintaDeMaquinaComponente, untTintaDeMaquinaComponenteTipo,
  untTintaDeMaquinaComponenteComparerColorante,
  untTintaDeMaquinaComponenteComparerBaseImobiliaria;


{ TFormulaMazaImobiliariaDinamica }

constructor TFormulaMazaImobiliariaDinamica.Create(strTabPrePar: String);
  Var
    conf: IConfTinta;
begin
  inherited;
  conf      := fGetConfTinta('MZI');
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;

end;

procedure TFormulaMazaImobiliariaDinamica.pCalculaPreco;
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

    if not IsItemAtivo(qryCadCol.FieldByName('COL_CODITE').AsString) then
    begin
      pZerarPrecos;
      raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [qryCadCol.FieldByName('COL_CODITE').AsString]);
    end;

    If (qryCadCol.FieldByName('ITE_CNV_ML').AsFloat <= 0) And (Pos(objColorante.strCodcol, objColErros) = 0) Then
    Begin
      pZerarPrecos;
      fMensagem('', 'O produto ' + qryCadCOl.FieldByName('COL_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                             'preenchido corretamente. Favor verificar.', ['OK']);
      objColErros := objColErros + '_' + objColorante.strCodCol + '_';
      Continue;
    End;

    componente := tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerColorante.Create(objColorante.strCodCol));
    if not Assigned(componente) then
    begin
      componente := tintaDeMaquina.Adicionar(TGenericTintaDeMaquinaComponente.Create(
        objColorante.strCodIte, objColorante.strCodCol, tmctColoranteImobiliario));
    end;

    componente.Quantidade := objColorante.fltQtdCol;
    componente.PrecoCusto := (objColorante.fltQtdCol) * (objColorante.fltPreCus / objColorante.fltEmbala);
    componente.PrecoCustoReal := (objColorante.fltQtdCol) * (objColorante.fltPreCu2 / objColorante.fltEmbala);
    componente.PrecoVenda := (objColorante.fltQtdCol) * (objColorante.fltPreVen / objColorante.fltEmbala);
    componente.PrecoMedio := (objColorante.fltQtdCol) * (objColorante.fltPreMed / objColorante.fltEmbala);
    componente.UltimoPrecoCompra := (objColorante.fltQtdCol) * (objColorante.fltPreUlt / objColorante.fltEmbala);
    componente.UltimoPrecoCompraImpostos := (objColorante.fltQtdCol) * (objColorante.fltImpUlt / objColorante.fltEmbala);
    componente.PrecoCompraLiquido := (objColorante.fltQtdCol) * (objColorante.fltComLiq / objColorante.fltEmbala);

    componente.OutrosValores := objColorante.fltOutVal * objColorante.fltQtdCol / objColorante.fltEmbala;
    componente.IcmsSaida := objColorante.fltIcmSai * componente.PrecoVenda / 100;
    componente.ImpostosFederais := objColorante.fltImpFed * componente.PrecoVenda / 100;
    componente.DespesasOperacionais := objColorante.fltDesOpe * componente.PrecoVenda / 100;

    If objColorante.StrPromoc = 'S' Then
      FPromoc := 'S';
  End;

  If Not (fEmptyStr(objColErros)) Then
    Exit;

  FCusCol := tintaDeMaquina.GetPrecoCustoComponentes;
  FCu2Col := tintaDeMaquina.GetPrecoCustoRealComponentes;
  FVenCol := tintaDeMaquina.GetPrecoVendaComponentes;
  FPreMed := tintaDeMaquina.GetPrecoMedioComponentes;

  FPreUlt := tintaDeMaquina.GetUltimoPrecoCompraComponentes;
  FImpUlt := tintaDeMaquina.GetUltimoPrecoCompraImpostosComponentes;
  FComLiq := tintaDeMaquina.GetPrecoCompraLiquidoComponentes;

  FVenCol := FVenCol + (fltPerAcr * FVenCol);

  FOutVal := tintaDeMaquina.GetOutrosValoresComponentes;
  FIcmsai := tintaDeMaquina.GetIcmsSaidaComponentes;
  FImpFed := tintaDeMaquina.GetImpostosFederaisComponentes;
  FDesOpe := tintaDeMaquina.GetDespesasOperacionaisComponentes;

  FPreCus := tintaDeMaquina.GetPrecoCustoComponentes + tintaDeMaquina.GetPrecoCustoEmbalagemBase;
  FPreCu2 := tintaDeMaquina.GetPrecoCustoRealComponentes + tintaDeMaquina.GetPrecoCustoRealEmbalagemBase;

  FPreVen := tintaDeMaquina.GetPrecoVendaComponentes + (fltPerAcr * tintaDeMaquina.GetPrecoVendaComponentes) +
             tintaDeMaquina.GetPrecoVendaEmbalagemBase;

end;

procedure TFormulaMazaImobiliariaDinamica.pCarregaPrecosColorantes;
var
  intContador: Integer;
  objColorante: TColoranteImobiliario;

  fltPreCusPro: Double;
  fltPreVenPro: Double;

  conf: IConfTinta;
  fltDesOpeTinta: Double;

begin

  conf := fGetConfTinta('MZI');
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
      objColorante.StrPromoc := 'S';

      If objColorante.fltPreCus = 0 Then
        objColorante.fltPreCus := qryCadCol.FieldByName('ITE_PRECUS').AsFloat;
    End
    Else
    Begin
      objColorante.fltPreCus := qryCadCol.FieldByName('ITE_PRECUS').AsFloat;
      objColorante.fltPreVen := qryCadCol.FieldByName('ITE_PREVEN').AsFloat;
    End;

    objColorante.fltEmbala := qryCadCol.FieldByName('COL_EMBALA').AsFloat;
    objColorante.strImpDir := qryCadCol.FieldByName('ITE_IMPDIR').AsString;
    objColorante.strCodIte := qryCadCol.FieldByName('COL_CODITE').AsString;

    objColorante.fltOutVal := qryCadCol.FieldByName('ITE_OUTVAL').AsFloat;

    if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
      objColorante.fltIcmSai := calculadorFatVendas.fCalculaAliquota(objColorante.strCodIte, objColorante.strImpDir)
    else
      objColorante.fltIcmSai := qryCadCol.FieldByName('ITE_ICMSAI').AsFloat;

    objColorante.fltImpFed := qryCadCol.FieldByName('ITE_IMPFED').AsFloat;
    objColorante.fltDesOpe := qryCadCol.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;;
    objColorante.fltPreMed := qryCadCol.FieldByName('ITE_PREMED').AsFloat;
    objColorante.fltPreUlt := qryCadCol.FieldByName('ITE_PREULT').AsFloat;
    objColorante.fltImpUlt := qryCadCol.FieldByName('ITE_IMPULT').AsFloat;

    objColorante.fltComLiq := fFormataFloat(fCalculaPrecoCompraLiq(qryCadCol.Fieldbyname('ITE_PRECOM').AsFloat, qryCadCol.Fieldbyname('ITE_DESF01').AsFloat,
                                                                   qryCadCol.Fieldbyname('ITE_DESF02').AsFloat, qryCadCol.Fieldbyname('ITE_DESF03').AsFloat,
                                                                   qryCadCol.Fieldbyname('ITE_DESF04').AsFloat, qryCadCol.Fieldbyname('ITE_DESF05').AsFloat,
                                                                   qryCadCol.Fieldbyname('ITE_DESF06').AsFloat), fCfgSis('DECUNI', VarInteger));
  End;

  FCalculo.Add('Valor da Base = ' + FloatToStrF(fltVenBas, ffFixed, 12, 2));
  FCalculo.Add('Valor do Colorante = (Quantidade) * (Preço / Embalagem)');
  FCalculo.Add('Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)');
end;

procedure TFormulaMazaImobiliariaDinamica.pCarregarColorantes;
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
    qryCadCol.SQL.Add('   , ITE_PREMED                     ');

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
    end
    else
    begin
      qryCadCol.SQL.Add('   , 0 AS ITE_ICMSAI                ');
      qryCadCol.SQL.Add('   , 0 AS ITE_IMPFED                ');
      qryCadCol.SQL.Add('   , 0 AS ITE_DESOPE                ');
      qryCadCol.SQL.Add('   , 0 AS ITE_OUTVAL                ');
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
    qryCadCol.SQL.Add('   MZI_CADCOL                       ');
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

procedure TFormulaMazaImobiliariaDinamica.SetIteBas(
  const Value: String);
var
  qryAux        : TUniQuery;
  fltIcmsai     : Double;
  base          : ITintaDeMaquinaComponente;

  fltPreCusPro  : Double;
  fltPreVenPro  : Double;

  conf          : IConfTinta;
  fltDesOpeTinta: Double;


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

  conf := fGetConfTinta('MZI');
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
          qryAux.SQL.Add('   MZI_CADBAS B                       ');
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
          FPreUltBas := qryAux.FieldByName('ITE_PREULT').AsFloat;
          FImpUltBas := qryAux.FieldByName('ITE_IMPULT').AsFloat;

          FCu2BasOri := fPrecoCusto2Base(FCusBasOri, FVenBasOri);
          FComLiqBas := fFormataFloat(fCalculaPrecoCompraLiq(qryAux.Fieldbyname('ITE_PRECOM').AsFloat, qryAux.Fieldbyname('ITE_DESF01').AsFloat,
                                                             qryAux.Fieldbyname('ITE_DESF02').AsFloat, qryAux.Fieldbyname('ITE_DESF03').AsFloat,
                                                             qryAux.Fieldbyname('ITE_DESF04').AsFloat, qryAux.Fieldbyname('ITE_DESF05').AsFloat,
                                                             qryAux.Fieldbyname('ITE_DESF06').AsFloat), fCfgSis('DECUNI', VarInteger));
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
        FComLiqBas := fFormataFloat(fCalculaPrecoCompraLiq(qryAux.Fieldbyname('ITE_PRECOM').AsFloat, qryAux.Fieldbyname('ITE_DESF01').AsFloat,
                                                           qryAux.Fieldbyname('ITE_DESF02').AsFloat, qryAux.Fieldbyname('ITE_DESF03').AsFloat,
                                                           qryAux.Fieldbyname('ITE_DESF04').AsFloat, qryAux.Fieldbyname('ITE_DESF05').AsFloat,
                                                           qryAux.Fieldbyname('ITE_DESF06').AsFloat), fCfgSis('DECUNI', VarInteger));
      End;

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

function fRetornaPrecoMazaImobiliariaDinamica(Sender: TForm; qryCadMzi: TUniQuery;
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
    tinta  : IConsultaTinta;
    conf   : IConfTinta;
begin
  conf         := fGetConfTinta('MZI');

  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTabPre    := dicRetorno['tabpre'];

  Result := False;

  If strTab = 'N' Then
  Begin
    strAuto := fConsultaMazaImobiliariaDinamicaVenda(Sender, strCodEmp, qryCadMzi, blnFaturamento, dicRetorno, sltItems);

    If (strAuto = '-1') Then
    Begin
      Exit;
    End;
  End
  Else
    strAuto := strAutoTab;

  tinta := TMazaImobiliariaConsulta.Create;

  qryCadMzi.Close;
  qryCadMzi.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
  qryCadMzi.Open;


  strDesCor := tinta.fGetDescricao(qryCadMzi.FieldbyName('AUTOINCREM').AsString, strCodIte);

  If (Not fDigDadosTintometricos(qryCadMzi, strTabPre, strCodIte, strDesBas,
        strRefBas, strUniBas, strDesCor, fltPreCus, fltUnitar, dicRetorno)) Then
  Begin
    Exit;
  End;

  strDesCor := Trim(strDesCor + ' ' + tinta.fGetDescricao(qryCadMzi.FieldbyName('AUTOINCREM').AsString, strCodIte));


  strIteTin := qryCadMzi.FieldByName('MZI_CODMZI').AsString +
               qryCadMzi.FieldByName('MZI_CODEMP').AsString +
               qryCadMzi.FieldByName('MZI_CODUNI').AsString +
               qryCadMzi.FieldByName('MZI_PRODUT').AsString +
               qryCadMzi.FieldByName('MZI_COLNUM').AsString +
               qryCadMzi.FieldByName('MZI_CODBAS').AsString;

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

function fRetornaUniTraProMazaImobiliariaDinamica(fltPrcTin, fltPrvTin: Double): Double;
  Var
    strSiglaTrava: String;
    fltFatTrava: Double;
    conf: IConfTinta;
begin
  conf          := fGetConfTinta('MZI');
  strSiglaTrava := conf.fGet('TRAMZI'); //fArqIniTinta(0, 'MazaImobiliaria', 'TRAMZI', '');
  fltFatTrava   := conf.fGetDouble('FATMZI'); //fStrToFloat(fArqIniTinta(0, 'MazaImobiliaria', 'FATMZI', ''));

  If strSiglaTrava = 'CUS' Then
    Result := fltPrcTin
  Else
    Result := fltPrvTin;

  Result := Result * fltFatTrava;
end;

function fRetornaDescricaoMazaImobiliariaDinamica(strDesCor: String; qryCadMzi: TUniQuery): String;
  Var
    strDesMzi: String;
begin
  strDesMzi := qryCadMzi.FieldByName('MZI_CODMZI').AsString + ' ' +
               qryCadMzi.FieldByName('MZI_PRODUT').AsString + ' ' +
               qryCadMzi.FieldByName('MZI_CODUNI').AsString;

  Result := Trim(AnsiReplaceStr(strDesCor, '%s', strDesMzi));
end;

function fDigDadosTintometricos(qryCadMzi: TUniQuery; strTabPre: String;
  Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
  Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;
var
  objColorante: TColoranteImobiliario;
  objFormula: TFormulaMazaImobiliariaDinamica;
  intContador: Integer;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  objFormula 		 := nil;
  frmDigTintaImobiliaria := nil;
  Result 		:= False;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaMazaImobiliariaDinamica.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltFatorEstoque := 1;
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);
      objFormula.strIteBasOri := fRetornaProdutoBase(qryCadMzi.FieldByName('MZI_CODBAS').AsString,
                                                     qryCadMzi.FieldByName('MZI_PRODUT').AsString,
                                                     qryCadMzi.FieldByName('MZI_CODUNI').AsString);

      objFormula.strIteBas    := objFormula.strIteBasOri;
      objFormula.strUnidad    := qryCadMzi.FieldByName('MZI_CODUNI').AsString;
      objFormula.strDescri    := strDesCor;

      For intContador := 1 To 20 Do
      Begin

        If (fEmptyStr(qryCadMzi.FieldByName('MZI_CODC' + fStrZero(intContador, 2)).AsString)) Then
          Break;

        objColorante := TColoranteImobiliario(objFormula.Add);
        objColorante.strCodCol := qryCadMzi.FieldByName('MZI_CODC' + fStrZero(intContador, 2)).AsString;
        objColorante.fltQtdCol := qryCadMzi.FieldByName('MZI_QTDC' + fStrZero(intContador, 2)).AsFloat;

      End;

      objFormula.pCarregaPrecosColorantes;
      objFormula.pCalculaPreco;

      Result := False;

      pCriarFormularios(TfrmDigTintaImobiliaria, frmDigTintaImobiliaria);
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTintaImobiliaria.Caption := frmDigTintaImobiliaria.Caption + 'Maza Imobiliária';
      frmDigTintaImobiliaria.objFormula := objFormula;
      frmDigTintaImobiliaria.strIdePro := 'MZI';


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
    if Assigned(objFormula) then FreeAndNil(objFormula);
    if Assigned(frmDigTintaImobiliaria) then FreeAndNil(frmDigTintaImobiliaria);
  End;
end;

function fRetornaProdutoBase(strCodBas, strProd: String; strUnidad: String): String;
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Nil);

  qryAux.SQL.Add('SELECT BAS_CODITE');
  qryAux.SQL.Add('  FROM MZI_CADBAS');
  qryAux.SQL.Add(' WHERE BAS_CODBAS = :CODBAS');
  qryAux.SQL.Add('   AND BAS_CODUNI = :CODUNI');
  qryAux.SQL.Add('   AND BAS_PRODUT = :PRODUT');

  qryAux.ParamByName('CODBAS').AsString := strCodBas;
  qryAux.ParamByName('CODUNI').AsString := strUnidad;
  qryAux.ParamByName('PRODUT').AsString := strProd;

  qryAux.Open;
  Result := qryAux.FieldByName('BAS_CODITE').AsString;
  qryAux.Close;

  FreeAndNil(qryAux);
end;

function fGTinForMazaImobiliariaDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
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
  strSQL := strSQL + '	MZI_CADMZI  ';
  strSQL := strSQL + 'WHERE  ';
  strSQL := strSQl + ' CONCAT(IFNULL(MZI_CODMZI, ""),   ' ;
  strSQL := strSQl + ' IFNULL(MZI_CODEMP, ""), ' ;
  strSQL := strSQl + ' IFNULL(MZI_CODUNI, ""), ' ;
  strSQL := strSQl + ' IFNULL(MZI_PRODUT, ""), ' ;
  strSQL := strSQl + ' IFNULL(MZI_COLNUM, ""), ' ;
  strSQL := strSQl + ' IFNULL(MZI_CODBAS, ""))  = :CODSEQ ';

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

    For intContador := 1 To 20 Do
    Begin

      strCamFor := 'MZI_CODC' + fStrZero(IntToStr(intContador), 2);
      strCamBas := 'MZI_QTDC' + fStrZero(IntToStr(intContador), 2);

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
  strSQL := strSQL + '  COL_CODITE ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MZI_CADCOL ';
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

function fConsultaMazaImobiliariaDinamica(Sender: TForm): String; stdcall;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    Result := fConsultaMazaImobiliariaDinamicaInterna(Sender, qryGen, '1', tpcGeral, False, Nil, Nil);
  Finally
    FreeAndNil(qryGen);
  End;
end;

function fConsultaMazaImobiliariaDinamicaGeral(Sender: TForm; strCodEmp: String): String; stdcall;
begin
  Result := fConsultaMazaImobiliariaDinamica(Sender);
end;

function fConsultaMazaImobiliariaDinamicaVenda(Sender: TForm; strCodEmp: String;
  qryCadMzi: TUniQuery; blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;
begin
  Result := fConsultaMazaImobiliariaDinamicaInterna(Sender, qryCadMzi, '1', tpcVenda, blnFaturamento, dicRetorno, sltItems);
end;

function fConsultaMazaImobiliariaDinamicaInterna(Sender: TForm;  qryCadMzi: TUniQuery;
  strTabPre: String; tipoConsulta: TTipoConsulta; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;
begin
  Result := (TMazaImobiliariaConsulta.Create).fExecutarConsulta(Sender,
      qryCadMzi, tipoConsulta, strTabPre, TfrmConsultaCompMazaImobiliaria,
      '', blnFaturamento, dicRetorno, sltItems);
end;

procedure pRetornaDadosMazaImobiliariaDinamica(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryCadMzi: TUniQuery;
    strSQL   : String;
begin

  qryCadMzi := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT  ';
  strSQL := strSQL + '	*  ';
  strSQL := strSQL + 'FROM  ';
  strSQL := strSQL + '	MZI_CADMZI  ';
  strSQL := strSQL + 'WHERE  ';
  strSQL := strSQl + ' CONCAT(IFNULL(MZI_CODMZI, ""), ';
  strSQL := strSQl + ' IFNULL(MZI_CODEMP, ""), ' ;
  strSQL := strSQl + ' IFNULL(MZI_CODUNI, ""), ' ;
  strSQL := strSQl + ' IFNULL(MZI_PRODUT, ""), ' ;
  strSQL := strSQl + ' IFNULL(MZI_COLNUM, ""), ' ;
  strSQL := strSQl + ' IFNULL(MZI_CODBAS, "")) = :CODSEQ ';

  With qryCadMzi Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODSEQ').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := qryCadMzi.FieldByName('MZI_CODMZI').AsString +
                            qryCadMzi.FieldByName('MZI_CODEMP').AsString +
                            qryCadMzi.FieldByName('MZI_CODUNI').AsString +
                            qryCadMzi.FieldByName('MZI_PRODUT').AsString +
                            qryCadMzi.FieldByName('MZI_COLNUM').AsString +
                            qryCadMzi.FieldByName('MZI_CODBAS').AsString ;

    Close;
  End;

  FreeAndNil(qryCadMzi);
end;

procedure pRetornaTabelaPrecoMazaImobiliaria(dicRetorno: TDicionario);
var
  objFormula: TFormulaMazaImobiliariaDinamica;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaMazaImobiliariaDinamica.Create('1');
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

{ TfrmConsultaCompMazaImobiliaria }

procedure TfrmConsultaCompMazaImobiliaria.pTarefaFormulacao(Sender: TObject);
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
  qryGen.SQL.Add('SELECT * FROM MZI_CADMZI WHERE AUTOINCREM = :AUTINC');
  qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
  qryGen.Open;

  fDigDadosTintometricos(qryGen, strTabPre, strCodIte, strDesBas,
        strRefBas, strUniBas, strDesCor, fltPreCus, fltUnitar, TDicionario.Create);

  FreeAndNil(qryGen);
end;

procedure TfrmConsultaCompMazaImobiliaria.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompMazaImobiliaria.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadMziNovasFormulasDin', False);
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
      qryGen.SQL.Text := ' SELECT B.BAS_CODITE                                     ' +
                         '   FROM MZI_CADMZI F                                     ' +
                         '  INNER JOIN MZI_CADBAS B ON F.MZI_CODBAS = B.BAS_CODBAS ' +
                         '                         AND F.MZI_CODUNI = B.BAS_CODUNI ' +
                         '  WHERE CONCAT(IFNULL(MZI_CODMZI, ""),                   ' +
                         '    IFNULL(MZI_CODEMP, ""),                              ' +
                         '    IFNULL(MZI_CODUNI, ""),                              ' +
                         '    IFNULL(MZI_PRODUT, ""),                              ' +
                         '    IFNULL(MZI_COLNUM, ""),                              ' +
                         '    IFNULL(MZI_CODBAS, "")) = :ITETIN                    ';

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

