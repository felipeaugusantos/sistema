unit untUniversoImobiliariaDinamica;

interface

uses
  untFuncEspecificas, Forms, Classes, Uni, untFuncoesSimples, strUtils, SysUtils, Controls,
  Math, Dialogs, Variants, untPnlBotoesAcoesNovaConsulta, ExtCtrls;

Type
  TfrmConsultaCompUniverso = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;


  TFormulaUniverso = class(TFormulaImobiliaria)
  private
    fltPerAcr: Double;
  protected
    procedure SetIteBas(const Value: String); override;
    procedure pCarregarColorantes; override;
  public
    procedure pCalculaPreco; override;
    procedure pCarregaPrecosColorantes; override;
    constructor Create(strTabPrePar: String); override;

  End;

  function fRetornaPrecoUniversoDinamica(Sender: TForm; qryCadUni: TUniQuery; Var dicRetorno: TDicionario;
    blnFaturamento: Boolean; strTab: String = 'N'; strAutoTab: String = '';  sltItems: TStringList = Nil): Boolean;
  function fRetornaUniTraProUniversoDinamica(fltPrcTin, fltPrvTin: Double): Double;
  function fRetornaDescricaoUniversoDinamica(strDesCor: String; qryCadUni: TUniQuery): String;

  function fDigDadosTintometricos(qryCadUni: TUniQuery; strTabPre: String; var strCodBas: String;
    Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
    Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;

  function fRetornaProdutoBase(strCodBas, strProd, strCodUni: String): String;
  function fGTinForUniversoDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;

  function fConsultaUniversoDinamica(Sender: TForm): String; stdcall;
  function fConsultaUniversoDinamicaGeral(Sender: TForm): String; stdcall;
  function fConsultaUniversoDinamicaVenda(Sender: TForm; qryCadUni: TUniQuery; strTabPre: String;
    blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;

  function fConsultaUniversoDinamicaInterna(Sender: TForm;  qryCadUni: TUniQuery;
    strTabPre: String; tipoConsulta: TTipoConsulta; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;

  procedure pRetornaDadosUniversoDinamica(strIteTin: String; dicRetorno: TDicionario);
  procedure pRetornaTabelaPrecoUniverso(dicRetorno: TDicionario);
  function GetIteBasOri(const strIteTin: string): string;

implementation

uses DB, untDigTintaImobiliaria, untFuncoes,
untIConfTinta,
untICalculadorFatVendas,
untIConsultaTinta,
untTintaMaquina,
untUniversoImobiliariaConsulta,
untGenericTintaDeMaquinaComponente, untITintaDeMaquinaComponente,
untTintaDeMaquinaComponenteTipo, untTintaDeMaquinaComponenteComparerColorante,
untTintaDeMaquinaComponenteComparerBaseImobiliaria;


{ TFormulaUniverso }

constructor TFormulaUniverso.Create(strTabPrePar: String);
  Var
    conf: IConfTinta;
begin
  inherited;
  conf := fGetConfTinta('UNI');
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;
end;


procedure TFormulaUniverso.pCalculaPreco;
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
      Raise Exception.Create('Colorante ' + objComponente.strCodCol + ' não cadastrado. Favor verificar.');
      Exit;
    End;

    If (fEmptyStr(qryCadCol.FieldByName('COL_CODITE').AsString)) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('Colorante ' + objComponente.strCodCol + ' não está com o produto para venda associado.' + #13#10 +
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

    componente.Quantidade                := objComponente.fltQtdCol * (29.57 / 192);
    componente.PrecoCusto                := objComponente.fltQtdCol * objComponente.fltPreCus * (29.57 / 192) / 946;
    componente.PrecoCustoReal            := objComponente.fltQtdCol * objComponente.fltPreCu2 * (29.57 / 192) / 946;
    componente.PrecoVenda                := objComponente.fltQtdCol * objComponente.fltPreVen * (29.57 / 192) / 946;
    componente.PrecoMedio                := objComponente.fltPreMed * objComponente.fltQtdCol * (29.57 / 192) / 946;
    componente.OutrosValores             := objComponente.fltOutVal * objComponente.fltQtdCol * (29.57 / 192) / 946;
    componente.IcmsSaida                 := objComponente.fltIcmSai * (objComponente.fltPreVen * objComponente.fltQtdCol * (29.57 / 192) / 946) / 100;
    componente.ImpostosFederais          := objComponente.fltImpFed * (objComponente.fltPreVen * objComponente.fltQtdCol * (29.57 / 192) / 946) / 100;
    componente.DespesasOperacionais      := objComponente.fltDesOpe * (objComponente.fltPreVen * objComponente.fltQtdCol * (29.57 / 192) / 946) / 100;
    componente.UltimoPrecoCompra         := objComponente.fltPreUlt * objComponente.fltQtdCol * (29.57 / 192) / 946;
    componente.UltimoPrecoCompraImpostos := objComponente.fltImpUlt * objComponente.fltQtdCol * (29.57 / 192) / 946;
    componente.PrecoCompraLiquido        := objComponente.fltComLiq * objComponente.fltQtdCol * (29.57 / 192) / 946;

{
    FCusCol := FCusCol + objComponente.fltQtdCol * objComponente.fltPreCus * (29.57 / 192) / 946;
    FCu2Col := FCu2Col + objComponente.fltQtdCol * objComponente.fltPreCu2 * (29.57 / 192) / 946;
    FVenCol := FVenCol + objComponente.fltQtdCol * objComponente.fltPreVen * (29.57 / 192) / 946;
    FPreMed := FPreMed + objComponente.fltPreMed * objComponente.fltQtdCol * (29.57 / 192) / 946;

    FOutVal := FOutVal + objComponente.fltOutVal * objComponente.fltQtdCol * (29.57 / 192) / 946;
    FIcmsai := FIcmsai + objComponente.fltIcmSai * (objComponente.fltPreVen * objComponente.fltQtdCol * (29.57 / 192) / 946) / 100;
    FImpFed := FImpFed + objComponente.fltImpFed * (objComponente.fltPreVen * objComponente.fltQtdCol * (29.57 / 192) / 946) / 100;
    FDesOpe := FDesOpe + objComponente.fltDesOpe * (objComponente.fltPreVen * objComponente.fltQtdCol * (29.57 / 192) / 946) / 100;

    FPreUlt := FPreUlt + objComponente.fltPreUlt * objComponente.fltQtdCol * (29.57 / 192) / 946;
    FImpUlt := FImpUlt + objComponente.fltImpUlt * objComponente.fltQtdCol * (29.57 / 192) / 946;
    FComLiq := FComLiq + objComponente.fltComLiq * objComponente.fltQtdCol * (29.57 / 192) / 946;
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
  pCarregaPrecosColorantes;
end;

procedure TFormulaUniverso.pCarregaPrecosColorantes;
  Var
    intContador: Integer;
    objColorante: TColoranteImobiliario;
    conf: IConfTinta;
    fltDesOpeTinta: Double;
    fltPreCusPro,
    fltPreVenPro : Double;

begin
  conf := fGetConfTinta('UNI');
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
  End;

  FCalculo.Clear;
  FCalculo.Add('Valor da Base = ' + FloatToStrF(fltVenBas, ffFixed, 12, 2));
  FCalculo.Add('Valor do Colorante = (Quantidade * (29.5735295625 / 192)) * (Preço / 946)');
  FCalculo.Add('Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)');

end;

procedure TFormulaUniverso.pCarregarColorantes;
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
    qryCadCol.SQL.Add('   UNI_CADCOL                       ');
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

procedure TFormulaUniverso.SetIteBas(const Value: String);
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
  conf := fGetConfTinta('UNI');
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
          qryAux.SQL.Add('   UNI_CADBAS B                       ');
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

{ TfrmConsultaCompUniverso }

procedure TfrmConsultaCompUniverso.pTarefaFormulacao(Sender: TObject);
  Var
    qryTinta: TUniQuery;
    fltPreCus: Double;
    fltPreVen: Double;
    dicRetorno: TDicionario;
    strCodBas: String;
    strNovBas: String;
    strDesBas: String;
    strRefere: String;
    strUniBas: String;
    strDesCor: String;
begin
  inherited;

  If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
    Exit;

  dicRetorno := TDicionario.Create;
  dicRetorno['idepro'] := 'UNI';

  qryTinta := fCriaQuery(Self);
  qryTinta.SQL.Add('SELECT * FROM UNI_CADUNI WHERE AUTOINCREM = :AUTINC');
  qryTinta.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
  qryTinta.Open;

  fDigDadosTintometricos(qryTinta, strTabPre, strCodBas, strNovBas, strDesBas,
      strRefere, strUniBas, strDesCor, fltPreCus, fltPreVen, dicRetorno);

  FreeAndNil(qryTinta);
  FreeAndNil(dicRetorno);
end;

procedure TfrmConsultaCompUniverso.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompUniverso.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadUniNovasFormulas', False);
end;

function fRetornaPrecoUniversoDinamica(Sender: TForm; qryCadUni: TUniQuery; Var dicRetorno: TDicionario;
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
Begin
  conf := fGetConfTinta('UNI');

  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTabPre    := dicRetorno['tabpre'];

  Result := False;

  If strTab = 'N' Then
  Begin
    strAuto := fConsultaUniversoDinamicaVenda(Sender, qryCadUni, strTabPre, blnFaturamento, dicRetorno, sltItems);

    If (strAuto = '-1') Then
    Begin
      Exit;
    End;
  End
  Else
    strAuto := strAutoTab;

  tinta := TUniversoImobiliariaConsulta.Create;

  qryCadUni.Close;
  qryCadUni.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
  qryCadUni.Open;


  strDesCor := tinta.fGetDescricao(qryCadUni.FieldbyName('AUTOINCREM').AsString, strNovBas);

  If Not fDigDadosTintometricos(qryCadUni, strTabPre, strCodBas, strNovBas,
    strDesBas, strRefere, strUniBas, strDesCor, fltPreCus, fltPreVen, dicRetorno) Then
  Begin
    Exit;
  End;

  strDesCor := Trim(strDesCor + ' ' + tinta.fGetDescricao(qryCadUni.FieldbyName('AUTOINCREM').AsString, strNovBas));


  strIteTin := qryCadUni.FieldByName('UNI_GRUPO_').AsString +
      qryCadUni.FieldByName('UNI_PRODUT').AsString +
      qryCadUni.FieldByName('UNI_CODTIN').AsString +
      qryCadUni.FieldByName('UNI_DESCOR').AsString +
      qryCadUni.FieldByName('UNI_CODBAS').AsString +
      qryCadUni.FieldByName('UNI_CODUNI').AsString;

  fltUniTar := fltPreVen;

  If blnUsaPreCus Then
    fltUniTar := fltPreCus;

  dicRetorno['unidad'] := strUniBas;
  dicRetorno['unitar'] := fltUniTar;
  dicRetorno['precus'] := fltPreCus;
  dicRetorno['prvtin'] := fltPreVen;
//  dicRetorno['prctin'] := fltPreCus;
  dicRetorno['codite'] := strNovBas;
  dicRetorno['descor'] := strDesCor;
  dicRetorno['itetin'] := strIteTin;
  dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

  Result := True;
End;

function fRetornaUniTraProUniversoDinamica(fltPrcTin, fltPrvTin: Double): Double;
  Var
    strSiglaTrava: String;
    fltFatTrava: Double;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('UNI');
  strSiglaTrava := conf.fGet('UNITRA'); //fArqIniTinta(0, 'UNIVERSO', 'UNITRA', '');
  fltFatTrava   := conf.fGetDouble('FATUNI'); //fStrToFloat(fArqIniTinta(0, 'UNIVERSO', 'FATUNI', ''));

  If strSiglaTrava = 'CUS' Then
    Result := fltPrcTin
  Else
    Result := fltPrvTin;

  Result := Result * fltFatTrava;
End;

function fRetornaDescricaoUniversoDinamica(strDesCor: String; qryCadUni: TUniQuery): String;
Begin
  Result := strDesCor;  
End;

function fDigDadosTintometricos(qryCadUni: TUniQuery; strTabPre: String; var strCodBas: String;
  Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
  Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;
var
  objFormula: TFormulaUniverso;
  intCont: Integer;
  objColorante: TColoranteImobiliario;
  calculadorFatVendas: ICalculadorFatVendas;
Begin
  Result := False;
  objFormula := nil;
  frmDigTintaImobiliaria := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaUniverso.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.strCodCli    := IfNull(dicRetorno['codcli'], '');
      objFormula.strOpcDoc    := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCnd    := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed    := IfNull(dicRetorno['przmed'], 0);
      objFormula.strIteBasOri := fRetornaProdutoBase(qryCadUni.FieldByName('UNI_CODBAS').AsString,
                                                      qryCadUni.FieldByName('UNI_PRODUT').AsString,
                                                      qryCadUni.FieldByName('UNI_CODUNI').AsString);
      objFormula.strIteBas := objFormula.strIteBasOri;
      objFormula.fltFatorEstoque := (29.57 / 192);
      objFormula.strUnidad := qryCadUni.FieldByName('UNI_CODUNI').AsString;
      objFormula.strDescri := fRetornaDescricaoUniversoDinamica(strDesCor, qryCadUni);

      For intCont := 1 To 10 Do
      Begin
        If fEmptyStr(qryCadUni.FieldByName('UNI_CODC' + fStrZero(intCont, 2)).AsString) Then
          Break;

        objColorante := TColoranteImobiliario(objFormula.Add);
        objColorante.strCodCol := qryCadUni.FieldByName('UNI_CODC' + fStrZero(intCont, 2)).AsString;
        objColorante.fltQtdCol := qryCadUni.FieldByName('UNI_QTDC' + fStrZero(intCont, 2)).AsFloat;
      End;

      objFormula.pCarregaPrecosColorantes;
      objFormula.pCalculaPreco;

      pCriarFormularios(TfrmDigTintaImobiliaria, frmDigTintaImobiliaria);
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTintaImobiliaria.Caption := frmDigTintaImobiliaria.Caption + 'Universo';
      frmDigTintaImobiliaria.objFormula := objFormula;

      frmDigTintaImobiliaria.strIdePro := IfNull(dicRetorno['idepro'], 'UNI');

      Result := (frmDigTintaImobiliaria.ShowModal = mrOk);

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

End;

function fRetornaProdutoBase(strCodBas, strProd, strCodUni: String): String;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery();
  qryGen.SQL.Add(' SELECT BAS_CODITE ');
  qryGen.SQL.Add(' FROM UNI_CADBAS ');
  qryGen.SQL.Add(' WHERE BAS_CODBAS = :CODBAS ');
  qryGen.SQL.Add('     AND BAS_PRODUT = :PRODUT ');
  qryGen.SQL.Add('     AND BAS_UNIDAD = :UNIDAD; ');

  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.ParamByName('PRODUT').AsString := strProd;
  qryGen.ParamByName('UNIDAD').AsString := strCodUni;

  qryGen.Open;
  Result := qryGen.FieldbyName('BAS_CODITE').AsString;
  FreeAndNil(qryGen);
End;

function fGTinForUniversoDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
  Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;
  Var
    qryGen: TUniQuery;
    intCont: Integer;
    dicFormulas: TDicionario;
    strColorantes: String;
Begin
  qryGen := fCriaQuery();
  qryGen.SQL.Add(' SELECT * ');
  qryGen.SQL.Add(' FROM UNI_CADUNI ');
  qryGen.SQL.Add(' WHERE  ');
  qryGen.SQL.Add('    CONCAT( ');
  qryGen.SQL.Add('    IFNULL(UNI_GRUPO_, ""),  ');
  qryGen.SQL.Add('    IFNULL(UNI_PRODUT, ""),  ');
  qryGen.SQL.Add('    IFNULL(UNI_CODTIN, ""),  ');
  qryGen.SQL.Add('    IFNULL(UNI_DESCOR, ""),  ');
  qryGen.SQL.Add('    IFNULL(UNI_CODBAS, ""),  ');
  qryGen.SQL.Add('    IFNULL(UNI_CODUNI, "")) = :ITETIN ');

  qryGen.ParamByName('ITETIN').AsString := strIteTin;
  qryGen.Open;

  Result := Not qryGen.IsEmpty;
  If Not Result Then
    Exit;

  dicFormulas := TDicionario.Create;
  strColorantes := '';

  For intCont := 1 To 10 Do
  Begin
    If fEmptyStr(qryGen.FieldByName('UNI_CODC' + fStrZero(intCont, 2)).AsString) Then
      Break;

    arrFormul[intCont].strFormul := qryGen.FieldByName('UNI_CODC' + fStrZero(intCont, 2)).AsString;
    arrFormul[intCont].fltQtdbas := qryGen.FieldByName('UNI_QTDC' + fStrZero(intCont, 2)).AsFloat * (29.57 / 192);
    dicFormulas[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;
    strColorantes := strColorantes + ',' + QuotedStr(arrFormul[intCont].strFormul);
  End;

  strColorantes := Trim(strColorantes);
  strColorantes := Copy(strColorantes, 2, Length(strColorantes));

  qryGen.Close;
  qryGen.SQL.Clear;
  qryGen.SQL.Add(' SELECT ');
  qryGen.SQL.Add('   COL_CODCOL, ');
  qryGen.SQL.Add('   COL_CODITE ');
  qryGen.SQL.Add(' FROM UNI_CADCOL ');
  qryGen.SQL.Add(' WHERE COL_CODCOL IN(' + strColorantes + ') ');
  qryGen.Open;

  SetLength(arrBaixaPigmentos, qryGen.RecordCount);

  While Not qryGen.Eof Do
  Begin
    arrBaixaPigmentos[qryGen.RecNo - 1].strCodIte := qryGen.FieldByName('COL_CODITE').AsString;
    arrBaixaPigmentos[qryGen.RecNo - 1].fltQtdBaixa := dicFormulas[qryGen.FieldByName('COL_CODCOL').AsString];
    arrBaixaPigmentos[qryGen.RecNo - 1].strTipComp := 'C';
    qryGen.Next;                   
  End;

  FreeAndNil(dicFormulas);
  FreeAndNil(qryGen);
End;

function fConsultaUniversoDinamica(Sender: TForm): String; stdcall;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery();
  Result := fConsultaUniversoDinamicaInterna(Sender, qryGen, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcGeral, False, Nil, Nil);
  FreeAndNil(qryGen);
End;

function fConsultaUniversoDinamicaGeral(Sender: TForm): String; stdcall;
Begin
  Result := fConsultaUniversoDinamica(Sender);
End;

function fConsultaUniversoDinamicaVenda(Sender: TForm; qryCadUni: TUniQuery; strTabPre: String;
  blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;
Begin
  Result := fConsultaUniversoDinamicaInterna(Sender, qryCadUni, strTabPre, tpcVenda, blnFaturamento, dicRetorno, sltItems);
End;

function fConsultaUniversoDinamicaInterna(Sender: TForm;  qryCadUni: TUniQuery;
  strTabPre: String; tipoConsulta: TTipoConsulta; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;
{
  Var
    strSql: String;
    stlCamInd: TStringList;
    stlDesInd: TStringList;
    frmConsulta: TfrmConsultaCompUniverso;
}
Begin
{
  Result := '-1';

  If Not Assigned(qryCadUni) Then
    Exit;

  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('UNI_CODTIN+UNI_PRODUT+UNI_DESCOR');

  stlDesInd.Add('Código/Produto/Descrição');

  strSql := '';
  strSql := strSql + ' SELECT ';
  strSql := strSql + '   UNI_GRUPO_    "Grupo", ';
  strSql := strSql + '   UNI_PRODUT    "Produto", ';
  strSql := strSql + '   UNI_CODTIN    "Código", ';
  strSql := strSql + '   UNI_DESCOR    "Descrição", ';
  strSql := strSql + '   UNI_CODBAS    "Base", ';
  strSql := strSql + '   UNI_CODUNI    "Unidade", ';
  strSql := strSql + '   UNI_CADUNI.AUTOINCREM ';
  strSql := strSql + ' FROM UNI_CADUNI ';
  strSql := strSql + '   INNER JOIN UNI_CADBAS ';
  strSql := strSql + '     ON UNI_CODBAS = BAS_CODBAS ';
  strSql := strSql + '       AND UNI_PRODUT = BAS_PRODUT ';
  strSql := strSql + '       AND UNI_CODUNI = BAS_UNIDAD ';
  strSql := strSql + '   INNER JOIN CADITE ';
  strSql := strSql + '     ON BAS_CODITE = ITE_CODITE ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '  TRUE  ';

  frmConsulta := TfrmConsultaCompUniverso.Create(Sender, tipoConsulta, strTabPre);
  frmConsulta.Caption := 'Consulta Universo';

  If pConsultaEspecifica(Sender, frmConsulta, qryCadUni, 'UNI_CADUNI',
    strSql, stlCamInd, stlDesInd, '', False, True, 5, True) Then
  Begin
    If Not qryCadUni.IsEmpty Then
      Result := qryCadUni.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(stlCamInd);
  FreeAndNil(stlDesInd);
}

  Result := (TUniversoImobiliariaConsulta.Create).fExecutarConsulta(Sender,
    qryCadUni, tipoConsulta, strTabPre, TfrmConsultaCompUniverso,
    '', blnFaturamento, dicRetorno, sltItems);

End;

procedure pRetornaDadosUniversoDinamica(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery();
  qryGen.SQL.Add(' SELECT * ');
  qryGen.SQL.Add(' FROM UNI_CADUNI ');
  qryGen.SQL.Add(' WHERE  ');
  qryGen.SQL.Add('    CONCAT( ');
  qryGen.SQL.Add('    IFNULL(UNI_GRUPO_, ""),  ');
  qryGen.SQL.Add('    IFNULL(UNI_PRODUT, ""),  ');
  qryGen.SQL.Add('    IFNULL(UNI_CODTIN, ""),  ');
  qryGen.SQL.Add('    IFNULL(UNI_DESCOR, ""),  ');
  qryGen.SQL.Add('    IFNULL(UNI_CODBAS, ""),  ');
  qryGen.SQL.Add('    IFNULL(UNI_CODUNI, "")) = :ITETIN; ');

  qryGen.ParamByName('ITETIN').AsString := strIteTin;
  qryGen.Open;
  dicRetorno['codtin'] :=
    qryGen.FieldByName('UNI_CODTIN').AsString + ' ' +
    qryGen.FieldByName('UNI_PRODUT').AsString + ' ' +
    qryGen.FieldByName('UNI_CODUNI').AsString;

  FreeAndNil(qryGen);
End;

procedure pRetornaTabelaPrecoUniverso(dicRetorno: TDicionario);
var
  objFormula : TFormulaUniverso;
  calculadorFatVendas: ICalculadorFatVendas;
Begin
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaUniverso.Create('1');
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.strIteBasOri := GetIteBasOri(dicRetorno['itetin']);
      objFormula.strIteBas := dicRetorno['itebas'];

      pRetornaTabelaPrecoImobiliarias(dicRetorno, objFormula, (29.57 / 192));
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(objFormula) then FreeAndNil(objFormula);
  End;
End;


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
        '   UNI_CADUNI U                        ' +
        '   INNER JOIN UNI_CADBAS B             ' +
        '     ON U.UNI_CODBAS = B.BAS_CODBAS    ' +
        '     AND U.UNI_PRODUT = B.BAS_PRODUT   ' +
        '     AND U.UNI_CODUNI = B.BAS_UNIDAD   ' +
        ' WHERE CONCAT(                         ' +
        '     IFNULL(U.UNI_GRUPO_, "")          ' +
        '     , IFNULL(U.UNI_PRODUT, "")        ' +
        '     , IFNULL(U.UNI_CODTIN, "")        ' +
        '     , IFNULL(U.UNI_DESCOR, "")        ' +
        '     , IFNULL(U.UNI_CODBAS, "")        ' +
        '     , IFNULL(U.UNI_CODUNI, "")        ' +
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
