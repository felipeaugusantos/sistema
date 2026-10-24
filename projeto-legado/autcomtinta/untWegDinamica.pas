unit untWegDinamica;

interface

uses
  untFuncEspecificas, Forms, Classes, Uni, untFuncoesSimples, strUtils, SysUtils, Controls,
  Math, Dialogs, Variants, untPnlBotoesAcoesNovaConsulta;

Type

  TfrmConsultaCompWeg = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;

  TFormulaWeg = class(TFormulaImobiliaria)
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

  function fRetornaPrecoWegDinamica(Sender: TForm; qryCadWeg: TUniQuery; Var dicRetorno: TDicionario;
    blnFaturamento: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;
  function fRetornaUniTraProWegDinamica(fltPrcTin, fltPrvTin: Double): Double;
  function fRetornaDescricaoWegDinamica(strDesCor: String; qryCadWeg: TUniQuery): String;

  function fDigDadosTintometricos(qryCadWeg: TUniQuery; strTabPre: String; var strCodBas: String;
    Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
    Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;

  function fRetornaProdutoBase(Base, ProKey, SubKey, Unidad: String): String;
  function fGTinForWegDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList; strIteCob: String): Boolean;

  function fConsultaWegDinamica(Sender: TForm): String; stdcall;
  function fConsultaWegDinamicaGeral(Sender: TForm): String; stdcall;
  function fConsultaWegDinamicaVenda(Sender: TForm; qryCadWeg: TUniQuery; strTabPre: String;
    blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;

  function fConsultaWegDinamicaInterna(Sender: TForm;  qryCadWeg: TUniQuery;
    strTabPre: String; tipoConsulta: TTipoConsulta; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;

  procedure pRetornaDadosWegDinamica(strIteTin: String; dicRetorno: TDicionario);
  procedure pRetornaTabelaPrecoWeg(dicRetorno: TDicionario);
  function GetIteBasOri(const strIteTin: string): string;

implementation

uses DB, untDigTintaImobiliaria, untFuncoes,untIConfTinta,
untICalculadorFatVendas,
untIConsultaTinta,
untTintaMaquina,
untWegConsulta,
untGenericTintaDeMaquinaComponente,
untITintaDeMaquinaComponente, untTintaDeMaquinaComponenteTipo,
untTintaDeMaquinaComponenteComparerColorante, untTintaDeMaquinaComponenteComparerBaseImobiliaria;

{ TfrmConsultaCompWeg }

procedure TfrmConsultaCompWeg.pTarefaFormulacao(Sender: TObject);
  Var
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
  inherited;

  If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
    Exit;

  qryGen := fCriaQuery(Self);
  qryGen.SQL.Add('SELECT * FROM WEG_CADWEG WHERE AUTOINCREM = :AUTINC');
  qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
  qryGen.Open;

  fDigDadosTintometricos(qryGen, strTabPre, strCodBas, strCodIte, strDesBas,
    strRefBas, strUniBas, strDesCor, fltPreCus, fltUnitar, TDicionario.Create);

  FreeAndNil(qryGen);
end;

procedure TfrmConsultaCompWeg.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompWeg.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadWegNovasFormulas', False);
end;

{ TFormulaWeg }

constructor TFormulaWeg.Create(strTabPrePar: String);
  Var
    conf: IConfTinta;
begin
  inherited;
  conf := fGetConfTinta('WEG');
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;
end;


procedure TFormulaWeg.pCalculaPreco;
var
  objComponente: TColoranteImobiliario;
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

    objComponente := TColoranteImobiliario(Items[intIndex]);

    If (Not qryCadCol.Locate('COL_CODCOL', objComponente.strCodcol, [])) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('Componente ' + objComponente.strCodCol + ' não cadastrado. Favor verificar.');
      Exit;
    End;

    If (fEmptyStr(qryCadCol.FieldByName('COL_CODITE').AsString)) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('Componente ' + objComponente.strCodCol + ' não está com o produto para venda associado.' + #13#10 +
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

    if not IsItemAtivo(qryCadCol.FieldByName('COL_CODITE').AsString) then
    begin
      pZerarPrecos;
      raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [qryCadCol.FieldByName('COL_CODITE').AsString]);
    end;

    componente := tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerColorante.Create(objComponente.strCodCol));
    if not Assigned(componente) then
    begin
      componente := tintaDeMaquina.Adicionar(TGenericTintaDeMaquinaComponente.Create(
        objComponente.strCodIte, objComponente.strCodCol, tmctColoranteImobiliario));
    end;

    componente.Quantidade                := objComponente.fltQtdCol;
    componente.PrecoCusto                := objComponente.fltQtdCol * objComponente.fltPreCus / objComponente.fltEmbala;
    componente.PrecoCustoReal            := objComponente.fltQtdCol * objComponente.fltPreCu2 / objComponente.fltEmbala;
    componente.PrecoVenda                := objComponente.fltQtdCol * objComponente.fltPreVen / objComponente.fltEmbala;
    componente.PrecoMedio                := objComponente.fltPreMed * objComponente.fltQtdCol / objComponente.fltEmbala;
    componente.OutrosValores             := objComponente.fltOutVal * objComponente.fltQtdCol / objComponente.fltEmbala;
    componente.IcmsSaida                 := objComponente.fltIcmSai * (objComponente.fltPreVen * objComponente.fltQtdCol / objComponente.fltEmbala) / 100;
    componente.ImpostosFederais          := objComponente.fltImpFed * (objComponente.fltPreVen * objComponente.fltQtdCol / objComponente.fltEmbala) / 100;
    componente.DespesasOperacionais      := objComponente.fltDesOpe * (objComponente.fltPreVen * objComponente.fltQtdCol / objComponente.fltEmbala) / 100;
    componente.UltimoPrecoCompra         := objComponente.fltPreUlt * objComponente.fltQtdCol / objComponente.fltEmbala;
    componente.UltimoPrecoCompraImpostos := objComponente.fltImpUlt * objComponente.fltQtdCol / objComponente.fltEmbala;
    componente.PrecoCompraLiquido        := objComponente.fltComLiq * objComponente.fltQtdCol / objComponente.fltEmbala;

{
    FCusCol := FCusCol + objComponente.fltQtdCol * objComponente.fltPreCus / 3600;
    FCu2Col := FCu2Col + objComponente.fltQtdCol * objComponente.fltPreCu2 / 3600;
    FVenCol := FVenCol + objComponente.fltQtdCol * objComponente.fltPreVen / 3600;
    FPreMed := FPreMed + objComponente.fltPreMed * objComponente.fltQtdCol / 3600;

    FOutVal := FOutVal + objComponente.fltOutVal * objComponente.fltQtdCol / 3600;
    FIcmsai := FIcmsai + objComponente.fltIcmSai * (objComponente.fltPreVen * objComponente.fltQtdCol / 3600) / 100;
    FImpFed := FImpFed + objComponente.fltImpFed * (objComponente.fltPreVen * objComponente.fltQtdCol / 3600) / 100;
    FDesOpe := FDesOpe + objComponente.fltDesOpe * (objComponente.fltPreVen * objComponente.fltQtdCol / 3600) / 100;

    FPreUlt := FPreUlt + objComponente.fltPreUlt * objComponente.fltQtdCol / 3600;
    FImpUlt := FImpUlt + objComponente.fltImpUlt * objComponente.fltQtdCol / 3600;
    FComLiq := FComLiq + objComponente.fltComLiq * objComponente.fltQtdCol / 3600;
}
  End;

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

  FPreCus := tintaDeMaquina.GetPrecoCustoComponentes     + tintaDeMaquina.GetPrecoCustoEmbalagemBase;
  FPreCu2 := tintaDeMaquina.GetPrecoCustoRealComponentes + tintaDeMaquina.GetPrecoCustoRealEmbalagemBase;
  FPreVen := FVenCol + tintaDeMaquina.GetPrecoVendaEmbalagemBase;

{
  FVenCol := FVenCol + (fltPerAcr * FVenCol);

  FPreCus := FCusBas + FCusCol;
  FPreCu2 := FCu2Bas + FCu2Col;
  FPreVen := FVenBas + FVenCol;
}
end;

procedure TFormulaWeg.pCarregaPrecosColorantes;
  Var
    intContador: Integer;
    objComponente: TColoranteImobiliario;
    conf: IConfTinta;
    fltDesOpeTinta: Double;
    fltPreCusPro,
    fltPreVenPro : Double;

begin
  conf := fGetConfTinta('WEG');
  fltDesOpeTinta := conf.fGetDouble('DESOPE');

  For intContador := 0 To Self.Count-1 Do
  Begin
    objComponente := TColoranteImobiliario(Self.Items[intContador]);
    qryCadCol.Locate('COL_CODCOL', objComponente.strCodCol, []);

    If fCarregaPromocao(qryCadCol.FieldByName('COL_CODITE').AsString, fTabPreco,
      strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
    Begin
      objComponente.fltPreCus := fltPreCusPro;
      objComponente.fltPreVen := fltPreVenPro;
      FPromoc := 'S';

      If objComponente.fltPreCus = 0 Then
        objComponente.fltPreCus := qryCadCol.FieldByName('ITE_PRECUS').AsFloat;
    End
    Else
    Begin
      objComponente.fltPreCus := qryCadCol.FieldByName('ITE_PRECUS').AsFloat;
      objComponente.fltPreVen := qryCadCol.FieldByName('ITE_PREVEN').AsFloat;
    End;

    objComponente.strImpDir := qryCadCol.FieldByName('ITE_IMPDIR').AsString;
    objComponente.strCodIte := qryCadCol.FieldByName('COL_CODITE').AsString;

    objComponente.fltOutVal := qryCadCol.FieldByName('ITE_OUTVAL').AsFloat;

    if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
      objComponente.fltIcmSai := calculadorFatVendas.fCalculaAliquota(objComponente.strCodIte, objComponente.strImpDir)
    else
      objComponente.fltIcmSai := qryCadCol.FieldByName('ITE_ICMSAI').AsFloat;

    objComponente.fltImpFed := qryCadCol.FieldByName('ITE_IMPFED').AsFloat;
    objComponente.fltDesOpe := qryCadCol.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;
    objComponente.fltPreMed := qryCadCol.FieldByName('ITE_PREMED').AsFloat;
    objComponente.fltPreUlt := qryCadCol.FieldByName('ITE_PREULT').AsFloat;
    objComponente.fltImpUlt := qryCadCol.FieldByName('ITE_IMPULT').AsFloat;
    objComponente.fltComLiq := fCalculaPrecoCompraLiq(qryCadCol.Fieldbyname('ITE_PRECOM').AsFloat, qryCadCol.Fieldbyname('ITE_DESF01').AsFloat,
                                                      qryCadCol.Fieldbyname('ITE_DESF02').AsFloat, qryCadCol.Fieldbyname('ITE_DESF03').AsFloat,
                                                      qryCadCol.Fieldbyname('ITE_DESF04').AsFloat, qryCadCol.Fieldbyname('ITE_DESF05').AsFloat,
                                                      qryCadCol.Fieldbyname('ITE_DESF06').AsFloat);

    objComponente.fltEmbala := qryCadCol.FieldByName('COL_EMBALA').AsFloat;
  End;

  FCalculo.Clear;
  FCalculo.Add('Valor da Base = ' + FloatToStrF(fltVenBas, ffFixed, 12, 2));
  FCalculo.Add('Valor do Componente = (Quantidade) * (Preço / Embalagem)');
  FCalculo.Add('Valor da Tinta = Valor da Base + (Soma do Valor do Componente de todos os Componentes)');
end;

procedure TFormulaWeg.pCarregarColorantes;
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
    qryCadCol.SQL.Add('   WEG_CADCOL                       ');
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

procedure TFormulaWeg.SetIteBas(const Value: String);
var
  qryAux: TUniQuery;
  fltIcmsai: Double;
  conf: IConfTinta;
  fltDesOpeTinta: Double;
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
  conf := fGetConfTinta('WEG');
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
          qryAux.SQL.Add('   WEG_CADBAS B                       ');
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
//      FPreMed := fFormataFloat(FPreMed, fCfgSis('DECUNI', varInteger));

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


function fRetornaPrecoWegDinamica(Sender: TForm; qryCadWeg: TUniQuery; Var dicRetorno: TDicionario;
  blnFaturamento: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;
  Var
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
    conf: IConfTinta;
begin
    conf := fGetConfTinta('WEG');

    strCodEmp    := dicRetorno['codemp'];
    strOpcDoc    := dicRetorno['opcdoc'];
    blnUsaPreCus := dicRetorno['usaprecus'];
    strTabPre    := dicRetorno['tabpre'];

    Result  := False;

    If strTab = 'N' Then
    Begin
      strAuto := fConsultaWegDinamicaVenda(Sender, qryCadWeg, strTabPre, blnFaturamento, dicRetorno, sltItems);

      If (strAuto = '-1') Then
      Begin
        Exit;
      End;
    End
    Else
      strAuto := strAutoTab;

    tinta := TWegConsulta.Create;

    qryCadWeg.Close;
    qryCadWeg.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
    qryCadWeg.Open;


    strDesCor := tinta.fGetDescricao(qryCadWeg.FieldbyName('AUTOINCREM').AsString, strNovBas);

    If Not fDigDadosTintometricos(qryCadWeg, strTabPre, strCodBas,
        strNovBas, strDesBas, strRefere, strUniBas, strDesCor, fltPreCus,
        fltPreVen, dicRetorno) Then
    Begin
      Exit;
    End;

    strDesCor := Trim(strDesCor + ' ' + tinta.fGetDescricao(qryCadWeg.FieldbyName('AUTOINCREM').AsString, strNovBas));

    strIteTin := qryCadWeg.FieldByName('WEG_DESCRI').AsString + ' ' +
                 qryCadWeg.FieldByName('WEG_CODIGO').AsString + ' ' +
                 qryCadWeg.FieldByName('WEG_CODIG2').AsString + ' ' +
                 qryCadWeg.FieldByName('WEG_UNIDAD').AsString;

    fltUniTar := fltPreVen;

    If blnUsaPreCus Then
      fltUniTar := fltPreCus;

    dicRetorno['unidad'] := strUniBas;
    dicRetorno['unitar'] := fltUnitar;
    dicRetorno['precus'] := fltPreCus;
    dicRetorno['prvtin'] := fltUnitar;
//    dicRetorno['prctin'] := fltPreCus;
    dicRetorno['codite'] := strNovBas;
    dicRetorno['descor'] := strDesCor;
    dicRetorno['itetin'] := strIteTin;
    dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

    Result := True;
end;

function fRetornaUniTraProWegDinamica(fltPrcTin, fltPrvTin: Double): Double;
  Var
    strSiglaTrava: String;
    fltFatTrava: Double;
    conf: IConfTinta;
begin
  conf          := fGetConfTinta('WEG');
  strSiglaTrava := conf.fGet('WEGTRA');
  fltFatTrava   := conf.fGetDouble('FATWEG');

  If strSiglaTrava = 'CUS' Then
    Result := fltPrcTin
  Else
    Result := fltPrvTin;

  Result := Result * fltFatTrava;
end;

function fRetornaDescricaoWegDinamica(strDesCor: String; qryCadWeg: TUniQuery): String;
begin
  Result := strDesCor;
end;

function fDigDadosTintometricos(qryCadWeg: TUniQuery; strTabPre: String; var strCodBas: String;
  Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
  Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;
var
  objComponente: TColoranteImobiliario;
  objFormula: TFormulaWeg;
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
            
      objFormula := TFormulaWeg.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltFatorEstoque := 1;
      objFormula.strCodCli    := IfNull(dicRetorno['codcli'], '');
      objFormula.strOpcDoc    := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCnd    := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed    := IfNull(dicRetorno['przmed'], 0);
      objFormula.strIteBasOri := fRetornaProdutoBase(qryCadWeg.FieldByName('WEG_BASE__').AsString,
                                                     qryCadWeg.FieldByName('WEG_PROKEY').AsString,
                                                     qryCadWeg.FieldByName('WEG_SUBKEY').AsString,
                                                     qryCadWeg.FieldByName('WEG_UNIDAD').AsString);

      objFormula.strIteBas := objFormula.strIteBasOri;
      objFormula.strUnidad := qryCadWeg.FieldByName('WEG_UNIDAD').AsString;

      objFormula.strDescri := fRetornaDescricaoWegDinamica(strDesCor, qryCadWeg);

      For intContador := 1 To 20 Do
      Begin
        If fEmptyStr(qryCadWeg.FieldByName('WEG_FORM' + fStrZero(intContador, 2)).AsString) Then
          Break;

        objComponente := TColoranteImobiliario(objFormula.Add);
        objComponente.strCodCol := qryCadWeg.FieldByName('WEG_FORM' + fStrZero(intContador, 2)).AsString;
        objComponente.fltQtdCol := qryCadWeg.FieldByName('WEG_QTDB' + fStrZero(intContador, 2)).AsFloat;
      End;

      objFormula.pCarregaPrecosColorantes;
      objFormula.pCalculaPreco;

      Try
        pCriarFormularios(TfrmDigTintaImobiliaria, frmDigTintaImobiliaria);
        objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
        frmDigTintaImobiliaria.Caption := frmDigTintaImobiliaria.Caption + 'Weg';
        frmDigTintaImobiliaria.objFormula := objFormula;
        frmDigTintaImobiliaria.strIdePro  := IfNull(dicRetorno['idepro'], 'WEG');
        If frmDigTintaImobiliaria.ShowModal = mrOk Then
          Result := True;
      Finally
        If Result Then
        Begin
          strNovBas := frmDigTintaImobiliaria.strNovBas;
          strDesBas := frmDigTintaImobiliaria.strDesBas;
          strRefere := frmDigTintaImobiliaria.strRefere;
          strUniBas := frmDigTintaImobiliaria.strUniBas;
          strDesCor := frmDigTintaImobiliaria.strDesCor;
          fltPreCus := frmDigTintaImobiliaria.fltPreCus;
          fltPreVen := frmDigTintaImobiliaria.fltPreVen;
          strCodBas := frmDigTintaImobiliaria.objFormula.strIteBasOri;
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
      End;

      If Result And Assigned(dicRetorno) Then
        objFormula.pRecalculaTabelas(dicRetorno);
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


function fRetornaProdutoBase(Base, ProKey, SubKey, Unidad: String): String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Add(' SELECT ');
  qryGen.SQL.Add('   BAS_CODITE ');
  qryGen.SQL.Add(' FROM WEG_CADBAS WHERE ');
  qryGen.SQL.Add('	BAS_UNIDAD = :UNIDAD');
  qryGen.SQL.Add('	AND BAS_BASE__ = :BASE');
  qryGen.SQL.Add('	AND BAS_PROKEY = :PROKEY');
  qryGen.SQL.Add('	AND BAS_SUBKEY = :SUBKEY');

  qryGen.ParamByName('UNIDAD').AsString := Unidad;
  qryGen.ParamByName('BASE').AsString := Base;
  qryGen.ParamByName('PROKEY').AsString := ProKey;
  qryGen.ParamByName('SUBKEY').AsString := SubKey;
  qryGen.Open;

  Result := qryGen.FieldByName('BAS_CODITE').AsString;
  qryGen.Close;
end;

function fGTinForWegDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
  Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList; strIteCob: String): Boolean;
  Var
    qryGen: TUniQuery;
    dicComponentes: TDicionario;

    strComponentes: String;
    strSql: String;
    intCont: Integer;
begin
  qryGen := fCriaQuery();
  dicComponentes := TDicionario.Create;
  strComponentes := '';

  Result := True;

  strSQL := '';
  strSQL := strSQL + ' SELECT * ';
  strSQL := strSQL + ' FROM WEG_CADWEG ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '  CONCAT(WEG_DESCRI, " ", WEG_CODIGO, " ", WEG_CODIG2, " ", WEG_UNIDAD) = :ITETIN ';

  qryGen.Close;
  qryGen.SQL.Clear;
  qryGen.SQL.Text := strSql;
  qryGen.ParamByName('ITETIN').AsString := strIteTin;
  qryGen.Open;

  If qryGen.IsEmpty Then
  Begin
    Result := False;
    Exit;
  End;

  For intCont := 1 To 12 Do
  Begin
    arrFormul[intCont].strFormul :=
      qryGen.FieldByName('WEG_FORM' + fStrZero(IntToStr(intCont), 2)).AsString;

    If fEmptyStr(arrFormul[intCont].strFormul) Then
      Break;

    arrFormul[intCont].fltQtdbas :=
      qryGen.FieldByName('WEG_QTDB' + fStrZero(IntToStr(intCont), 2)).AsFloat;

    dicComponentes[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;

    strComponentes := strComponentes + ',' + QuotedStr(arrFormul[intCont].strFormul);
  End;

  strComponentes := Trim(strComponentes);
  strComponentes := Copy(strComponentes, 2, Length(strComponentes));

  strSql := '';
  strSql := strSql + ' SELECT "C" TIPO, ';
  strSql := strSql + '   COL_CODCOL, ';
  strSql := strSql + '   COL_CODITE ';
  strSql := strSql + ' FROM WEG_CADCOL ';
  strSql := strSql + ' WHERE COL_CODCOL IN(' + strComponentes + ') ';

  qryGen.Close;
  qryGen.SQL.Text := strSql;
  qryGen.Open;

  SetLength(arrBaixaPigmentos, qryGen.RecordCount);

  While Not qryGen.Eof Do
  Begin
    stlItensTraMl.Add(qryGen.FieldByName('COL_CODITE').AsString);

    arrBaixaPigmentos[qryGen.RecNo - 1].strCodIte := qryGen.FieldByName('COL_CODITE').AsString;
    arrBaixaPigmentos[qryGen.RecNo - 1].fltQtdBaixa := dicComponentes[qryGen.FieldByName('COL_CODCOL').AsString];
    arrBaixaPigmentos[qryGen.RecNo - 1].strTipComp := qryGen.FieldByName('TIPO').AsString;
    qryGen.Next;
  End;

  qryGen.Close;

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


  FreeAndNil(dicComponentes);
  FreeAndNil(qryGen);
end;

function fConsultaWegDinamica(Sender: TForm): String; stdcall;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  Result := fConsultaWegDinamicaInterna(Sender, qryGen, '1', tpcGeral, False, Nil, Nil);
  FreeAndNil(qryGen);
end;

function fConsultaWegDinamicaGeral(Sender: TForm): String; stdcall;
begin
  Result := fConsultaWegDinamica(Sender);
end;

function fConsultaWegDinamicaVenda(Sender: TForm; qryCadWeg: TUniQuery; strTabPre: String;
  blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;
begin
  Result := fConsultaWegDinamicaInterna(Sender, qryCadWeg, strTabPre, tpcVenda, blnFaturamento, dicRetorno, sltItems);
end;

function fConsultaWegDinamicaInterna(Sender: TForm;  qryCadWeg: TUniQuery;
  strTabPre: String; tipoConsulta: TTipoConsulta; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;
begin
  Result := (TWegConsulta.Create).fExecutarConsulta(Sender,
    qryCadWeg, tipoConsulta, strTabPre, TfrmConsultaCompWeg, '', blnFaturamento, dicRetorno, sltItems);

end;

procedure pRetornaDadosWegDinamica(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryGen: TUniQuery;
    strSql: String;
begin
  qryGen := fCriaQuery();

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   * ';
  strSQL := strSQL + ' FROM WEG_CADWEG ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '  CONCAT(WEG_DESCRI, " ", WEG_CODIGO, " ", WEG_CODIG2) = :ITETIN ';

  qryGen.Close;
  qryGen.SQL.Text := strSql;
  qryGen.ParamByName('ITETIN').AsString := strIteTin;
  qryGen.Open;
  dicRetorno['codtin'] := qryGen.FieldByName('WEG_DESCRI').AsString +
                          qryGen.FieldByName('WEG_CODIGO').AsString +
                          qryGen.FieldByName('WEG_CODIG2').AsString;
end;

procedure pRetornaTabelaPrecoWeg(dicRetorno: TDicionario);
var
  objFormula: TFormulaWeg;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaWeg.Create('1');
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
        '   WEG_CADWEG W                        ' +
        '   INNER JOIN WEG_CADBAS B             ' +
        '     ON W.WEG_BASE__ = B.BAS_BASE__    ' +
        '     AND W.WEG_PROKEY = B.BAS_PROKEY   ' +
        '     AND W.WEG_SUBKEY = B.BAS_SUBKEY   ' +
        '     AND W.WEG_UNIDAD = B.BAS_UNIDAD   ' +
        ' WHERE CONCAT(                         ' +
        '     W.WEG_DESCRI                      ' +
        '     , " "                             ' +
        '     , W.WEG_CODIGO                    ' +
        '     , " "                             ' +
        '     , W.WEG_CODIG2                    ' +
        '     , " "                             ' +
        '     , W.WEG_UNIDAD                    ' +
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
