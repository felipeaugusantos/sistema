unit untAnjoDinamica;

interface

uses
  untFuncEspecificas, Forms, Classes, Uni, untFuncoesSimples, SysUtils, Controls,
  Variants, untPnlBotoesAcoesNovaConsulta,
  UniClientDataSet;

Type

  TfrmConsultaCompAnjo = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;

  TFormulaAnjo = class(TFormulaImobiliaria)
  private
      fltPerAcr: Double;
  protected
    procedure pCarregarColorantes; override;
    procedure SetIteBas(const Value: String); override;
  public
    procedure pCalculaPreco; override;
    procedure pCarregaPrecosColorantes; override;
    constructor Create(strTabPrePar: String); override;
  End;

  function fRetornaPrecoAnjoDinamica(Sender: TForm; qryCadAnj: TUniQuery; Var dicRetorno: TDicionario;
    blnFaturamento: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;
  function fRetornaUniTraProAnjoDinamica(fltPrcTin, fltPrvTin: Double): Double;
  function fRetornaDescricaoAnjoDinamica(strDesCor: String): String;

  function fDigDadosTintometricos(qryCadAnj: TUniClientDataSet; strTabPre: String; var strCodBas: String;
    Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
    Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;

  function fRetornaProdutoBase(Base, ProKey, SubKey, Unidad: String): String;
  function fGTinForAnjoDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList; strIteCob: String): Boolean;

  function fConsultaAnjoDinamica(Sender: TForm): String; stdcall;
  function fConsultaAnjoDinamicaGeral(Sender: TForm): String; stdcall;
  function fConsultaAnjoDinamicaVenda(Sender: TForm; qryCadAnj: TUniQuery; strTabPre: String;
    blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;

  function fConsultaAnjoDinamicaInterna(Sender: TForm;  qryCadAnj: TUniQuery;
    strTabPre: String; tipoConsulta: TTipoConsulta; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;

  procedure pRetornaDadosAnjoDinamica(strIteTin: String; dicRetorno: TDicionario);
  procedure pRetornaTabelaPrecoAnjo(dicRetorno: TDicionario);
  function GetIteBasOri(const strIteTin: string): string;

implementation

uses DB, untDigTintaImobiliaria, untFuncoes, untGenericTintaDeMaquinaComponente, untITintaDeMaquinaComponente,
  untTintaDeMaquinaComponenteComparerColorante, untTintaDeMaquinaComponenteComparerBaseImobiliaria, untClientDataSetFactory, untTintaMaquina,
  untMultiSelectLocalizadorFactory,untIConfTinta,untICalculadorFatVendas,untTintaDeMaquinaComponenteTipo,untIConsultaTinta, untAnjoConsulta;

{ TfrmConsultaCompAnjo }

procedure TfrmConsultaCompAnjo.pTarefaFormulacao(Sender: TObject);
var
  qryGen: TUniQuery;
  strCodIte: String;
  strDesBas: String;
  strRefBas: String;
  strUniBas: String;
  strDesCor: String;
  fltPreCus: Double;
  fltUnitar: Double;
  strCodBas: String;
begin
  qryGen := nil;
  Try
    Try
      If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
        Exit;

      qryGen := fCriaQuery(Self);
      qryGen.SQL.Add('SELECT * FROM ANJ_CADANJ WHERE AUTOINCREM = :AUTINC');
      qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;

      fDigDadosTintometricos(TClientDataSetFactory.GetClientDataSet(qryGen),
        strTabPre, strCodBas, strCodIte, strDesBas, strRefBas, strUniBas,
        strDesCor, fltPreCus, fltUnitar, TDicionario.Create);
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

procedure TfrmConsultaCompAnjo.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompAnjo.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadAnjoNovasFormulas', False);
end;

{ TFormulaAnjo }

constructor TFormulaAnjo.Create(strTabPrePar: String);
  Var
    conf: IConfTinta;
begin
  inherited;
  conf := fGetConfTinta('ANJ');
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;
end;

procedure TFormulaAnjo.pCalculaPreco;
var
  objComponente: TColoranteImobiliario;
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

  cdsCadCol := TClientDataSetFactory.GetClientDataSet(qryCadCol);
  pZerarPrecos;
  pCarregaPrecosColorantes;

  For intIndex := 0 To Count -1 Do
  Begin

    objComponente := TColoranteImobiliario(Items[intIndex]);

    If (Not cdsCadCol.Locate('COL_CODCOL', objComponente.strCodcol, [])) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('Componente ' + objComponente.strCodCol + ' não cadastrado. Favor verificar.');
    End;

    If (fEmptyStr(cdsCadCol.FieldByName('COL_CODITE').AsString)) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('Componente ' + objComponente.strCodCol + ' não está com o produto para venda associado.' + #13#10 +
                             'Favor verificar.');
    End;

    If (cdsCadCol.FieldByName('ITE_CNV_ML').AsFloat <= 0) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('O produto ' + cdsCadCol.FieldByName('COL_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                             'preenchido corretamente. Favor verificar.');
    End;

    if not IsItemAtivo(cdsCadCol.FieldByName('COL_CODITE').AsString) then
    begin
      pZerarPrecos;
      raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [cdsCadCol.FieldByName('COL_CODITE').AsString]);
    end;

    componente := tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerColorante.Create(objComponente.strCodCol));
    if not Assigned(componente) then
    begin
      componente := tintaDeMaquina.Adicionar(TGenericTintaDeMaquinaComponente.Create(
        objComponente.strCodIte, objComponente.strCodCol, tmctColoranteImobiliario
      ));
    end;

    componente.Quantidade := objComponente.fltQtdCol;
    componente.PrecoCusto := objComponente.fltQtdCol * objComponente.fltPreCus / cdsCadCol.FieldByName('COL_EMBALA').AsFloat;
    componente.PrecoCustoReal := objComponente.fltQtdCol * objComponente.fltPreCu2 / cdsCadCol.FieldByName('COL_EMBALA').AsFloat;
    componente.PrecoVenda := objComponente.fltQtdCol * objComponente.fltPreVen / cdsCadCol.FieldByName('COL_EMBALA').AsFloat;
    componente.PrecoMedio := objComponente.fltPreMed * objComponente.fltQtdCol / cdsCadCol.FieldByName('COL_EMBALA').AsFloat;
    componente.OutrosValores := objComponente.fltOutVal * objComponente.fltQtdCol / cdsCadCol.FieldByName('COL_EMBALA').AsFloat;
    componente.IcmsSaida := objComponente.fltIcmSai * (objComponente.fltPreVen * objComponente.fltQtdCol / cdsCadCol.FieldByName('COL_EMBALA').AsFloat) / 100;
    componente.ImpostosFederais := objComponente.fltImpFed * (objComponente.fltPreVen * objComponente.fltQtdCol / cdsCadCol.FieldByName('COL_EMBALA').AsFloat) / 100;
    componente.DespesasOperacionais := objComponente.fltDesOpe * (objComponente.fltPreVen * objComponente.fltQtdCol / cdsCadCol.FieldByName('COL_EMBALA').AsFloat) / 100;

    componente.UltimoPrecoCompra := (objComponente.fltQtdCol) * (objComponente.fltPreUlt / cdsCadCol.FieldByName('COL_EMBALA').AsFloat);
    componente.UltimoPrecoCompraImpostos := (objComponente.fltQtdCol) * (objComponente.fltImpUlt / cdsCadCol.FieldByName('COL_EMBALA').AsFloat);
    componente.PrecoCompraLiquido := (objComponente.fltQtdCol) * (objComponente.fltComLiq / cdsCadCol.FieldByName('COL_EMBALA').AsFloat);
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

  FPreUlt := tintaDeMaquina.GetUltimoPrecoCompraComponentes;
  FImpUlt := tintaDeMaquina.GetUltimoPrecoCompraImpostosComponentes;
  FComLiq := tintaDeMaquina.GetPrecoCompraLiquidoComponentes;
end;

procedure TFormulaAnjo.pCarregaPrecosColorantes;
var
  intContador   : Integer;
  objComponente : TColoranteImobiliario;
  cdsCadCol     : TUniClientDataSet;
  conf          : IConfTinta;
  fltDesOpeTinta: Double;
  fltPreCusPro  : Double;
  fltPreVenPro  : Double;


begin
  conf := fGetConfTinta('ANJ');
  fltDesOpeTinta := conf.fGetDouble('DESOPE');
  cdsCadCol := TClientDataSetFactory.GetClientDataSet(qryCadCol);

  For intContador := 0 To Self.Count-1 Do
  Begin
    objComponente := TColoranteImobiliario(Self.Items[intContador]);
    cdsCadCol.Locate('COL_CODCOL', objComponente.strCodCol, []);

    If fCarregaPromocao(cdsCadCol.FieldByName('COL_CODITE').AsString, fTabPreco,
      strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
    Begin
      objComponente.fltPreCus := fltPreCusPro;
      objComponente.fltPreVen := fltPreVenPro;
      objComponente.StrPromoc := 'S';

      If objComponente.fltPreCus = 0 Then
        objComponente.fltPreCus := cdsCadCol.FieldByName('ITE_PRECUS').AsFloat;
    End
    Else
    Begin
      objComponente.fltPreCus := cdsCadCol.FieldByName('ITE_PRECUS').AsFloat;
      objComponente.fltPreVen := cdsCadCol.FieldByName('ITE_PREVEN').AsFloat;
    End;

    objComponente.strImpDir := cdsCadCol.FieldByName('ITE_IMPDIR').AsString;
    objComponente.strCodIte := cdsCadCol.FieldByName('COL_CODITE').AsString;

    objComponente.fltOutVal := cdsCadCol.FieldByName('ITE_OUTVAL').AsFloat;

    if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
      objComponente.fltIcmSai := calculadorFatVendas.fCalculaAliquota(objComponente.strCodIte, objComponente.strImpDir)
    else
      objComponente.fltIcmSai := cdsCadCol.FieldByName('ITE_ICMSAI').AsFloat;

    objComponente.fltImpFed := cdsCadCol.FieldByName('ITE_IMPFED').AsFloat;
    objComponente.fltDesOpe := cdsCadCol.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;
    objComponente.fltPreMed := cdsCadCol.FieldByName('ITE_PREMED').AsFloat;

    objComponente.fltPreUlt := cdsCadCol.FieldByName('ITE_PREULT').AsFloat;
    objComponente.fltImpUlt := cdsCadCol.FieldByName('ITE_IMPULT').AsFloat;
    objComponente.fltComLiq := fCalculaPrecoCompraLiq(cdsCadCol.Fieldbyname('ITE_PRECOM').AsFloat, cdsCadCol.Fieldbyname('ITE_DESF01').AsFloat,
                                                      cdsCadCol.Fieldbyname('ITE_DESF02').AsFloat, cdsCadCol.Fieldbyname('ITE_DESF03').AsFloat,
                                                      cdsCadCol.Fieldbyname('ITE_DESF04').AsFloat, cdsCadCol.Fieldbyname('ITE_DESF05').AsFloat,
                                                      cdsCadCol.Fieldbyname('ITE_DESF06').AsFloat);
  End;

  FCalculo.Clear;
  FCalculo.Add('Valor da Base = ' + FloatToStrF(fltVenBas, ffFixed, 12, 2));
  FCalculo.Add('Valor do Componente = (Quantidade) * (Preço / Embalagem)');
  FCalculo.Add('Valor da Tinta = Valor da Base + (Soma do Valor do Componente de todos os Componentes)');
end;

procedure TFormulaAnjo.pCarregarColorantes;
begin
  Try
    qryCadCol.SQL.Clear;
    qryCadCol.SQL.Add(' SELECT                             ');
    qryCadCol.SQL.Add('   COL_CODCOL                       ');
    qryCadCol.SQL.Add('   , COL_CODITE                     ');
    qryCadCol.SQL.Add('   , ITE_CNV_ML                     ');
    qryCadCol.SQL.Add('   , COL_EMBALA                     ');
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
      qryCadCol.SQL.Add('   , COL_PRELIT AS ITE_PRECUS       ');
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
    qryCadCol.SQL.Add('   ANJ_CADCOL                       ');
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

procedure TFormulaAnjo.SetIteBas(const Value: String);
var
  qryAux: TUniQuery;
  fltIcmsai: Double;
  base: ITintaDeMaquinaComponente;
  cdsAux: TUniClientDataSet;
  conf: IConfTinta;
  fltDesOpeTinta: Double;
  fltPreCusPro,
  fltPreVenPro: Double;

  function fPrecoCusto2Base: Double;
  begin
    Result := fCalculaPrecoCusto2(fltPreVen,
      cdsAux.FieldByName('ITE_PRECUS').AsFloat,
      cdsAux.FieldByName('ITE_OUTVAL').AsFloat,
      fltIcmsai,
      cdsAux.FieldByName('ITE_IMPFED').AsFloat,
      cdsAux.FieldByName('ITE_DESOPE').AsFloat);
  end;
begin
  tintaDeMaquina.Remover(tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(FIteBas)));
  tintaDeMaquina.Remover(tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(FIteBasOri)));
  inherited;
  conf := fGetConfTinta('ANJ');
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
          qryAux.SQL.Add('   ANJ_CADBAS B                       ');
          qryAux.SQL.Add('   INNER JOIN CADITE I                ');
          qryAux.SQL.Add('     ON B.BAS_CODITE = I.ITE_CODITE   ');
          qryAux.SQL.Add('   INNER JOIN ITEGER G                ');
          qryAux.SQL.Add('     ON I.ITE_CODITE = G.ITE_CODITE   ');
          qryAux.SQL.Add(' WHERE I.ITE_CODITE = :CODITE         ');
          qryAux.SQL.Add('   AND G.ITE_CODEMP = :CODEMP         ');

          qryAux.ParamByName('CODITE').AsString := FIteBas;
          qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
          cdsAux := TClientDataSetFactory.GetClientDataSet(qryAux);

          If fCarregaPromocao(Value, fTabPreco, strCodCli, strCodCnd, intPrzMed,
            fltPreCusPro, fltPreVenPro) Then
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

          FCu2BasOri := fPrecoCusto2Base;
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

        If fCarregaPromocao(Value, fTabPreco, strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
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

        FVenBas := FVenBas + (fltPerAcr * FVenBas);

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
        FCu2Bas := fPrecoCusto2Base;
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


function fRetornaPrecoAnjoDinamica(Sender: TForm; qryCadAnj: TUniQuery; Var dicRetorno: TDicionario;
  blnFaturamento: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;
var
  strCodEmp: String;
  strOpcDoc: String;
  blnUsaPreCus: Boolean;
  strTabPre: String;

  strCodBas: String;
  strNovBas: String;
  strDesBas: String;
  strRefere: String;
  strUniBas: String;
  strDesCor: String;
  fltPreCus: Double;
  fltPreVen: Double;

  strIteTin: String;
  fltUniTar: Double;

  strAuto: String;
  tinta : IConsultaTinta;
  cdsCadAnj: TUniClientDataSet;
  conf: IConfTinta;
begin
  conf := fGetConfTinta('ANJ');

  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTabPre    := dicRetorno['tabpre'];

  Result  := False;

  If strTab = 'N' Then
  Begin
    strAuto := fConsultaAnjoDinamicaVenda(Sender, qryCadAnj, strTabPre, blnFaturamento, dicRetorno, sltItems);

    If (strAuto = '-1') Then
    Begin
      Exit;
    End;
  End
  Else
    strAuto := strAutoTab;

  tinta := TAnjoConsulta.Create;

  qryCadAnj.Close;
  qryCadAnj.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
  cdsCadAnj := TClientDataSetFactory.GetClientDataSet(qryCadAnj);

  If Not fDigDadosTintometricos(cdsCadAnj, strTabPre, strCodBas,
      strNovBas, strDesBas, strRefere, strUniBas, strDesCor, fltPreCus,
      fltPreVen, dicRetorno) Then
  Begin
    Exit;
  End;

  strDesCor := Trim(strDesCor + ' ' + tinta.fGetDescricao(cdsCadAnj.FieldbyName('AUTOINCREM').AsString, strNovBas));

  strIteTin := cdsCadAnj.FieldByName('ANJ_MD5KEY').AsString;

  fltUniTar := fltPreVen;

  If blnUsaPreCus Then
    fltUniTar := fltPreCus;

  dicRetorno['unidad'] := strUniBas;
  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['precus'] := fltPreCus;
  dicRetorno['prvtin'] := fltUnitar;
//  dicRetorno['prctin'] := fltPreCus;
  dicRetorno['codite'] := strNovBas;
  dicRetorno['descor'] := strDesCor;
  dicRetorno['itetin'] := strIteTin;
  dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');
    
  Result := True;
end;

function fRetornaUniTraProAnjoDinamica(fltPrcTin, fltPrvTin: Double): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf          := fGetConfTinta('ANJ');
  strSiglaTrava := conf.fGet('ANJTRA');
  fltFatTrava   := conf.fGetDouble('FATANJ'); 

  If strSiglaTrava = 'CUS' Then
    Result := fltPrcTin
  Else
    Result := fltPrvTin;

  Result := Result * fltFatTrava;
end;

function fRetornaDescricaoAnjoDinamica(strDesCor: String): String;
begin
  Result := strDesCor;
end;

function fDigDadosTintometricos(qryCadAnj: TUniClientDataSet; strTabPre: String; var strCodBas: String;
  Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
  Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;
var
  objComponente: TColoranteImobiliario;
  objFormula: TFormulaAnjo;
  intContador: Integer;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  Result := False;
  objFormula := nil;
  frmDigTintaImobiliaria := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;
        
      objFormula := TFormulaAnjo.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;      
      objFormula.fltFatorEstoque := 1;
      objFormula.strCodCli    := IfNull(dicRetorno['codcli'], '');
      objFormula.strOpcDoc    := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCnd    := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed    := IfNull(dicRetorno['przmed'], 0);
      objFormula.strIteBasOri := fRetornaProdutoBase(qryCadAnj.FieldByName('ANJ_BASE__').AsString,
                                                     qryCadAnj.FieldByName('ANJ_PROKEY').AsString,
                                                     qryCadAnj.FieldByName('ANJ_SUBKEY').AsString,
                                                     qryCadAnj.FieldByName('ANJ_UNIDAD').AsString);

      objFormula.strIteBas := objFormula.strIteBasOri;
      objFormula.strUnidad := qryCadAnj.FieldByName('ANJ_UNIDAD').AsString;
      objFormula.strDescri := fRetornaDescricaoAnjoDinamica(strDesCor);

      For intContador := 1 To 20 Do
      Begin
        If fEmptyStr(qryCadAnj.FieldByName('ANJ_FORM' + fStrZero(intContador, 2)).AsString) Then
          Break;

        objComponente := TColoranteImobiliario(objFormula.Add);
        objComponente.strCodCol := qryCadAnj.FieldByName('ANJ_FORM' + fStrZero(intContador, 2)).AsString;
        objComponente.fltQtdCol := qryCadAnj.FieldByName('ANJ_QTDB' + fStrZero(intContador, 2)).AsFloat;
      End;

      objFormula.pCarregaPrecosColorantes;
      objFormula.pCalculaPreco;

      Application.CreateForm(TfrmDigTintaImobiliaria, frmDigTintaImobiliaria);
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTintaImobiliaria.Caption := frmDigTintaImobiliaria.Caption + 'Anjo';
      frmDigTintaImobiliaria.objFormula := objFormula;
      frmDigTintaImobiliaria.strIdePro  := 'ANJ';

      If frmDigTintaImobiliaria.ShowModal = mrOk Then
        Result := True;

      If Result Then
      Begin
        strNovBas := frmDigTintaImobiliaria.strNovBas;
        strDesBas := frmDigTintaImobiliaria.strDesBas;
        strRefere := frmDigTintaImobiliaria.strRefere;
        strUniBas := frmDigTintaImobiliaria.strUniBas;
        strDesCor := frmDigTintaImobiliaria.strDesCor; // + ' %s ' + frmDigTintaImobiliaria.strDesBas + ' %s ';
        fltPreCus := frmDigTintaImobiliaria.fltPreCus;
        fltPreVen := frmDigTintaImobiliaria.fltPreVen;
        strCodBas := frmDigTintaImobiliaria.objFormula.strIteBasOri;

        dicRetorno['precu2'] := objFormula.fltPreCu2;
        dicRetorno['premed'] := objFormula.fltPreMed + objFormula.fltPreMedBas;
        dicRetorno['preult'] := objFormula.fltPreUlt + objFormula.fltPreUltBas;
        dicRetorno['impult'] := objFormula.fltImpUlt + objFormula.fltImpUltBas;
        dicRetorno['prctin'] := objFormula.fltComLiq + objFormula.fltComLiqBas;

        AcertaImpostos(fltPreCus, objFormula.fltPreCu2,
          objFormula.fltOutVal + objFormula.fltOutValBas,
          objFormula.fltIcmsai + objFormula.fltIcmsaiBas,
          objFormula.fltImpFed + objFormula.fltImpFedBas,
          objFormula.fltDesOpe + objFormula.fltDesOpeBas,
          dicRetorno);

        dicRetorno['maximoqtdbase'] := frmDigTintaImobiliaria.fltQtdMaximo;
        dicRetorno.AdicionarObjeto('formul', frmDigTintaImobiliaria.matrizSaldosColorantes);
        dicRetorno.AdicionarObjeto('tintaDeMaquina', objFormula.tintaDeMaquina);

        If Assigned(dicRetorno) Then
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


function fRetornaProdutoBase(Base, ProKey, SubKey, Unidad: String): String;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Add(' SELECT ');
      qryGen.SQL.Add('   BAS_CODITE ');
      qryGen.SQL.Add(' FROM ANJ_CADBAS WHERE ');
      qryGen.SQL.Add('	BAS_UNIDAD = :UNIDAD');
      qryGen.SQL.Add('	AND BAS_BASE__ = :BASE');
      qryGen.SQL.Add('	AND BAS_PROKEY = :PROKEY');
      qryGen.SQL.Add('	AND BAS_SUBKEY = :SUBKEY');

      qryGen.ParamByName('UNIDAD').AsString := Unidad;
      qryGen.ParamByName('BASE').AsString := Base;
      qryGen.ParamByName('PROKEY').AsString := ProKey;
      qryGen.ParamByName('SUBKEY').AsString := SubKey;

      Result := TClientDataSetFactory.GetClientDataSet(qryGen).FieldByName('BAS_CODITE').AsString;
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

function fGTinForAnjoDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
  Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList; strIteCob: String): Boolean;
var
  qryGen: TUniQuery;
  dicComponentes: TDicionario;

  strComponentes: String;
  strSql: String;
  intCont: Integer;
  cdsGen: TUniClientDataSet;
begin
  Result := False;
  qryGen := nil;
  dicComponentes := nil;
  Try
    Try
      qryGen := fCriaQuery();
      dicComponentes := TDicionario.Create;
      strComponentes := '';

      Result := TMultiSelectLocalizadorFactory.GetLocalizador('ANJ').Localizar(cdsGen, ['ITETIN'], [strIteTin]);
      if not Result then
        Exit;

      For intCont := 1 To 12 Do
      Begin
        arrFormul[intCont].strFormul :=
          cdsGen.FieldByName('ANJ_FORM' + fStrZero(IntToStr(intCont), 2)).AsString;

        If fEmptyStr(arrFormul[intCont].strFormul) Then
          Break;

        arrFormul[intCont].fltQtdbas :=
          cdsGen.FieldByName('ANJ_QTDB' + fStrZero(IntToStr(intCont), 2)).AsFloat;

        dicComponentes[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;

        strComponentes := strComponentes + ',' + QuotedStr(arrFormul[intCont].strFormul);
      End;

      strComponentes := Trim(strComponentes);
      strComponentes := Copy(strComponentes, 2, Length(strComponentes));

      strSql := '';
      strSql := strSql + ' SELECT "C" TIPO, ';
      strSql := strSql + '   COL_CODCOL, ';
      strSql := strSql + '   COL_CODITE ';
      strSql := strSql + ' FROM ANJ_CADCOL ';
      strSql := strSql + ' WHERE ' + GetInToOr('COL_CODCOL', strComponentes);

      qryGen.Close;
      qryGen.SQL.Text := strSql;
      cdsGen := TClientDataSetFactory.GetClientDataSet(qryGen);

      SetLength(arrBaixaPigmentos, cdsGen.RecordCount);

      While Not cdsGen.Eof Do
      Begin
        stlItensTraMl.Add(cdsGen.FieldByName('COL_CODITE').AsString);

        arrBaixaPigmentos[cdsGen.RecNo - 1].strCodIte := cdsGen.FieldByName('COL_CODITE').AsString;
        arrBaixaPigmentos[cdsGen.RecNo - 1].fltQtdBaixa := dicComponentes[cdsGen.FieldByName('COL_CODCOL').AsString];
        arrBaixaPigmentos[cdsGen.RecNo - 1].strTipComp := cdsGen.FieldByName('TIPO').AsString;
        cdsGen.Next;
      End;

      {**************************************************************************************************}
      {* CASO VENHA ALGUM ITEM EM STRITECOB, QUER DIZER QUE O USUARIO SELECIONOU UM COMPLEMENTO DE BASE *}
      {***********************************************************************************************PH*}
      If Not fEmptyStr(strIteCob) Then
      Begin
        stlItensTraMl.Add(strIteCob);
        SetLength(arrBaixaPigmentos, Length(arrBaixaPigmentos) + 1);
        arrBaixaPigmentos[Length(arrBaixaPigmentos) - 1].strCodIte := strIteCob;
        arrBaixaPigmentos[Length(arrBaixaPigmentos) - 1].fltQtdBaixa := 1;
        arrBaixaPigmentos[Length(arrBaixaPigmentos) - 1].strTipComp := 'B';
      End;

      Result := True;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
    if Assigned(dicComponentes) then FreeAndNil(dicComponentes);
  End;

end;

function fConsultaAnjoDinamica(Sender: TForm): String; stdcall;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      Result := fConsultaAnjoDinamicaInterna(Sender, qryGen, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcGeral, False, Nil, Nil);
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

function fConsultaAnjoDinamicaGeral(Sender: TForm): String; stdcall;
begin
  Result := fConsultaAnjoDinamica(Sender);
end;

function fConsultaAnjoDinamicaVenda(Sender: TForm; qryCadAnj: TUniQuery; strTabPre: String;
  blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;
begin
  Result := fConsultaAnjoDinamicaInterna(Sender, qryCadAnj, strTabPre, tpcVenda, blnFaturamento, dicRetorno, sltItems);
end;

function fConsultaAnjoDinamicaInterna(Sender: TForm;  qryCadAnj: TUniQuery;
  strTabPre: String; tipoConsulta: TTipoConsulta; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;
begin
  Result := (TAnjoConsulta.Create).fExecutarConsulta(Sender,
    qryCadAnj, tipoConsulta, strTabPre, TfrmConsultaCompAnjo,
    '', blnFaturamento, dicRetorno, sltItems);
end;

procedure pRetornaDadosAnjoDinamica(strIteTin: String; dicRetorno: TDicionario);
var
  cdsGen: TUniClientDataSet;
begin
  if TMultiSelectLocalizadorFactory.GetLocalizador('ANJ').Localizar(cdsGen, ['ITETIN'], [strIteTin]) then
    dicRetorno['codtin'] := cdsGen.FieldByName('ANJ_DESCRI').AsString;
end;

procedure pRetornaTabelaPrecoAnjo(dicRetorno: TDicionario);
var
  objFormula: TFormulaAnjo;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaAnjo.Create('1');
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.strIteBasOri := GetIteBasOri(dicRetorno['itetin']);
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

function GetIteBasOri(const strIteTin: string): string;
var
  cdsGen: TUniClientDataSet;
begin
  Result := '';
  if TMultiSelectLocalizadorFactory.GetLocalizador('ANJBAS').Localizar(cdsGen, ['ITETIN'], [strIteTin]) then
    Result := cdsGen.FieldByName('BAS_CODITE').AsString;
end;

end.

