unit untSuvinilDinamica;

interface

uses SysUtils, Forms, Classes,
   Uni,
  Dialogs, StrUtils, untFuncEspecificas, Controls, untFuncoesSimples, untConsultaCompTintaNova,
  untConsultaCompTinta,
  UniClientDataSet;

Type

  TfrmConsultaCompSuvinil = class(TfrmConsultaCompTintaNova)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;

  TFormulaSuvinil = class(TFormulaImobiliaria)
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


  function fRetornaPrecoSuvinilDinamica(Sender: TForm; qryCadSuv: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  function fRetornaUniTraProSuvinilDinamica(fltPrcTin, fltPrvTin: Double): Double;

  function fRetornaDescricaoSuvinilDinamica(strDesCor: String; qryCadSuv: TUniQuery): String;

  function fDigDadosTintometricos(qryCadSuv: TUniClientDataSet; strTabPre: String;
    Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
    Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;

  function fRetornaProdutoBase(strCodFml, strCodBas, strCodUni: String): String;
  function fGetItemBaseOri(const strIteTin: String): string;    

  function fGTinForSuvinilDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;

  function fConsultaSuvinilDinamica(Sender: TForm): String; stdcall;
  function fConsultaSuvinilDinamicaGeral(Sender: TForm): String; stdcall;
  function fConsultaSuvinilDinamicaVenda(Sender: TForm; qryCadSuv: TUniQuery; strTabPre: String): String; stdcall;

  function fConsultaSuvinilDinamicaInterna(Sender: TForm;  qryCadSuv: TUniQuery;
    strTabPre: String; tipoConsulta: TTipoConsulta): String; stdcall;

  procedure pRetornaDadosSuvinilDinamica(strIteTin: String; dicRetorno: TDicionario);
  procedure pRetornaTabelaPrecoSuvinil(dicRetorno: TDicionario);
  procedure SuvinilPulsoParaOnca(const fltPulsos: Double; var intParteInteira: Integer; var fltParteFracao: Double);

implementation

uses DB, untDigTintaImobiliaria, untSuvinilConsulta,
  untIConfTinta, untTintaMaquina, untGenericTintaDeMaquinaComponente, untTintaDeMaquinaComponenteTipo,
  untQryConIteFactory, untTintaDeMaquinaComponenteComparerColorante, untTintaDeMaquinaComponenteComparerBaseImobiliaria,
  untClientDataSetFactory, untMultiSelectLocalizadorFactory,untFuncoes,
untICalculadorFatVendas,
untITintaDeMaquinaComponente,
untIConsultaTinta,
untTintadeMaquina;

type
  TfrmDigTintaImobiliariaCustom = class(TfrmDigTintaImobiliaria);

function fRetornaPrecoSuvinilDinamica(Sender: TForm; qryCadSuv: TUniQuery;
  Var dicRetorno: TDicionario): Boolean;
var

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
  strCodIte: String;
  strDesCor: String;
  strTabPre: String;
  strDesBas: String;
  strRefBas: String;
  strUniBas: String;

  strAuto: String;
  tinta : IConsultaTinta;
  cdsCadSuv: TUniClientDataSet;
  conf: IConfTinta;
begin
  conf := fGetConfTinta('SUV');

  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTabPre    := dicRetorno['tabpre'];

  Result := False;
  strAuto := fConsultaSuvinilDinamicaVenda(Sender, qryCadSuv, strTabPre);
  If (strAuto = '-1') Then
  Begin
    Exit;
  End;

  tinta := TSuvinilConsulta.Create;
  qryCadSuv.Close;
  qryCadSuv.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
  cdsCadSuv := TClientDataSetFactory.GetClientDataSet(qryCadSuv);

  If (Not fDigDadosTintometricos(cdsCadSuv, strTabPre, strCodIte, strDesBas,
        strRefBas, strUniBas, strDesCor, fltPreCus, fltUnitar, dicRetorno)) Then
  Begin
    Exit;
  End;

  strDesCor := Trim(strDesCor + ' ' + tinta.fGetDescricao(cdsCadSuv.FieldByName('AUTOINCREM').AsString, strCodIte));
  strIteTin := cdsCadSuv.FieldByName('SUV_MD5KEY').AsString;
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

function fRetornaUniTraProSuvinilDinamica(fltPrcTin, fltPrvTin: Double): Double;
  Var
    strSiglaTrava: String;
    fltFatTrava: Double;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('SUV');

  strSiglaTrava := conf.fGet('TRASUV');
  fltFatTrava   := conf.fGetDouble('FATSUV');

  If strSiglaTrava = 'CUS' Then
    Result := fltPrcTin
  Else
    Result := fltPrvTin;

  Result := Result * fltFatTrava;
end;

function fRetornaDescricaoSuvinilDinamica(strDesCor: String; qryCadSuv: TUniQuery): String;
begin
  {***********************************}
  {* AGORA  DESCRIÇÃO É CONFIGURAVEL *}
  {********************************PH*}
  Result := strDesCor;
end;

function fRetornaProdutoBase(strCodFml, strCodBas, strCodUni: String): String;
var
  qryAux: TUniQuery;
begin
  qryAux := nil;
  Try
    Try
      qryAux := fCriaQuery(Nil);
      qryAux.SQL.Add('SELECT ');
      qryAux.SQL.Add('  SUV_CODITE ');
      qryAux.SQL.Add('FROM ');
      qryAux.SQL.Add('  SUV_CADBAS ');
      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  SUV_CODFML = :CODFML AND ');
      qryAux.SQL.Add('  SUV_CODBAS = :CODBAS AND ');
      qryAux.SQL.Add('  SUV_CODUNI = :CODUNI ');

      qryAux.ParamByName('CODFML').AsString := strCodFml;
      qryAux.ParamByName('CODBAS').AsString := strCodBas;
      qryAux.ParamByName('CODUNI').AsString := strCodUni;
      Result := TClientDataSetFactory.GetClientDataSet(qryAux).FieldByName('SUV_CODITE').AsString
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

function fGTinForSuvinilDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
  Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;
var
  strSQL: String;
  strCamFor: String;
  strCamBas: String;
  intPos: Integer;
  intContador: Integer;

  strColorantes: String;
  dicColorantes: TDicionario;
  qryGen: TUniQuery;
  cdsGen: TUniClientDataSet;
begin
  Result := False;

  qryGen := nil;
  dicColorantes := nil;
  Try
    Try
      qryGen := fCriaQuery(Nil);

      dicColorantes := TDicionario.Create;
      strColorantes := '';

      Result := TMultiSelectLocalizadorFactory.GetLocalizador('SUV').Localizar(cdsGen, ['ITETIN'], [strIteTin]);
      if not Result then
        Exit;

      For intContador := 1 To 15 Do
      Begin

        strCamFor := 'SUV_FORM' + fStrZero(IntToStr(intContador), 2);
        strCamBas := 'SUV_QTDB' + fStrZero(IntToStr(intContador), 2);

        arrFormul[intContador].strFormul := cdsGen.FieldByName(strCamFor).AsString;
        arrFormul[intContador].fltQtdBas := cdsGen.FieldByName(strCamBas).AsFloat * 0.154;

        dicColorantes[arrFormul[intContador].strFormul] := arrFormul[intContador].fltQtdBas;

        {*******************************************}
        {* GUARDA COLORANTES PARA POSTERIOR BUSCA  *}
        {* DOS ITENS                               *}
        {****************************************MV*}
        if not fEmptyStr(arrFormul[intContador].strFormul) then
        begin
          strColorantes := strColorantes + QuotedStr(arrFormul[intContador].strFormul);
          If (Not fEmptyStr(arrFormul[intContador].strFormul)) Then
            strColorantes := strColorantes + ', ';
        end;

      End;

      strColorantes := Trim(strColorantes);
      If (RightStr(strColorantes, 1) = ',') Then
        strColorantes := Copy(strColorantes, 1, Length(strColorantes)-1);

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  COL_CODCOL, ';
      strSQL := strSQL + '  COL_CODITE ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  SUV_CADCOL ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + GetInToOr('COL_CODCOL', strColorantes);

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);
      cdsGen := TClientDataSetFactory.GetClientDataSet(qryGen);

      intPos := 0;
      SetLength(arrBaixaPigmentos, cdsGen.RecordCount);

      While (Not cdsGen.Eof) Do
      Begin

        {*******************************************}
        {* ITENS QUE TEM QUE FAZER TRANSFERENCIA   *}
        {* DE SALDO EM ML                          *}
        {****************************************MV*}
        stlItensTraMl.Add(cdsGen.FieldByName('COL_CODITE').AsString);
        arrBaixaPigmentos[intPos].strCodIte   := cdsGen.FieldByName('COL_CODITE').AsString;
        arrBaixaPigmentos[intPos].fltQtdBaixa := dicColorantes[cdsGen.FieldByName('COL_CODCOL').AsString];
        Inc(intPos);
        cdsGen.Next;
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
    if Assigned(dicColorantes) then FreeAndNil(dicColorantes);
  End;
end;

function fConsultaSuvinilDinamica(Sender: TForm): String;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery(Sender);
      Result := fConsultaSuvinilDinamicaInterna(Sender, qryGen, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcGeral);
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

function fConsultaSuvinilDinamicaGeral(Sender: TForm): String;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery(Sender);
      Result := fConsultaSuvinilDinamicaInterna(Sender, qryGen, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcGeral);
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

function fConsultaSuvinilDinamicaVenda(Sender: TForm; qryCadSuv: TUniQuery; strTabPre: String): String;
begin
  Result := fConsultaSuvinilDinamicaInterna(Sender, qryCadSuv, strTabPre, tpcVenda);
end;

{ TFormulaSuvinil }

constructor TFormulaSuvinil.Create(strTabPrePar: String);
  Var
    conf: IConfTinta;
begin
  inherited;
  conf := fGetConfTinta('SUV');
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;
end;

procedure TFormulaSuvinil.pCalculaPreco;
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

    FPromoc := 'N';
  End;
begin
  inherited;
  pZerarPrecos;
  cdsCadCol := TClientDataSetFactory.GetClientDataSet(qryCadCol);

  For intIndex := 0 To Count -1 Do
  Begin
    objColorante := TColoranteImobiliario(Items[intIndex]);

    If (Not cdsCadCol.Locate('COL_CODCOL', objColorante.strCodCol, [])) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('Colorante ' + objColorante.strCodCol + ' não cadastrado. Favor verificar.');
      Exit;
    End;

    If (fEmptyStr(cdsCadCol.FieldByName('COL_CODITE').AsString)) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('Colorante ' + objColorante.strCodCol + ' não está com o produto para venda associado. ' + #13#10 +
                             'Favor verificar.');
      Exit;
    End;

    If (cdsCadCol.FieldByName('ITE_CNV_ML').AsFloat <= 0) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('O produto ' + cdsCadCol.FieldByName('COL_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                             'preenchido corretamente. Favor verificar.');
      Exit;
    End;

    if not IsItemAtivo(cdsCadCol.FieldByName('COL_CODITE').AsString) then
    begin
      pZerarPrecos;
      raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [cdsCadCol.FieldByName('COL_CODITE').AsString]);
    end;

    componente := tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerColorante.Create(objColorante.strCodCol));
    if not Assigned(componente) then
    begin
      componente := tintaDeMaquina.Adicionar(TGenericTintaDeMaquinaComponente.Create(
        objColorante.strCodIte, objColorante.strCodCol, tmctColoranteImobiliario));
    end;

    componente.Quantidade := objColorante.fltQtdCol * 0.154;
    componente.PrecoCusto := (objColorante.fltQtdCol * 0.154) * (objColorante.fltPreCus / 1000);
    componente.PrecoCustoReal := (objColorante.fltQtdCol * 0.154) * (objColorante.fltPreCu2 / 1000);
    componente.PrecoVenda := (objColorante.fltQtdCol * 0.154) * (objColorante.fltPreVen / 1000);
    componente.PrecoMedio := (objColorante.fltQtdCol * 0.154) * (objColorante.fltPreMed / 1000);
    componente.OutrosValores := objColorante.fltOutVal * objColorante.fltQtdCol * 0.154 / 1000;
    componente.IcmsSaida := objColorante.fltIcmSai * (objColorante.fltPreVen * objColorante.fltQtdCol * 0.154 / 1000) / 100;
    componente.ImpostosFederais := objColorante.fltImpFed * (objColorante.fltPreVen * objColorante.fltQtdCol * 0.154 / 1000) / 100;
    componente.DespesasOperacionais := objColorante.fltDesOpe * (objColorante.fltPreVen * objColorante.fltQtdCol * 0.154 / 1000) / 100;
    componente.UltimoPrecoCompra := (objColorante.fltQtdCol * 0.154) * (objColorante.fltPreUlt / 1000);
    componente.UltimoPrecoCompraImpostos := (objColorante.fltQtdCol * 0.154) * (objColorante.fltImpUlt / 1000);
    componente.PrecoCompraLiquido := (objColorante.fltQtdCol * 0.154) * (objColorante.fltComLiq / 1000);

    If objColorante.StrPromoc = 'S' Then
      FPromoc := 'S';
  End;

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

procedure TFormulaSuvinil.pCarregaPrecosColorantes;
var
  intContador: Integer;
  objColorante: TColoranteImobiliario;
  cdsGen: TUniClientDataSet;

  fltPreCusPro: Double;
  fltPreVenPro: Double;
  conf: IConfTinta;
  fltDesOpeTinta: Double;
begin
  conf := fGetConfTinta('SUV');
  fltDesOpeTinta := conf.fGetDouble('DESOPE');

  cdsGen := TClientDataSetFactory.GetClientDataSet(qryCadCol);

  For intContador := 0 To Self.Count-1 Do
  Begin
    objColorante := TColoranteImobiliario(Self.Items[intContador]);
    cdsGen.Locate('COL_CODCOL', objColorante.strCodCol, []);

    If fCarregaPromocao(cdsGen.FieldByName('COL_CODITE').AsString, fTabPreco,
      strCodCli, strCodCnd, intPrzMed, fltPreCusPro, fltPreVenPro) Then
    Begin
      objColorante.fltPreCus := fltPreCusPro;
      objColorante.fltPreVen := fltPreVenPro;
      objColorante.StrPromoc := 'S';

      If objColorante.fltPreCus = 0 Then
        objColorante.fltPreCus := cdsGen.FieldByName('ITE_PRECUS').AsFloat;
    End
    Else
    Begin
      objColorante.fltPreCus := cdsGen.FieldByName('ITE_PRECUS').AsFloat;
      objColorante.fltPreVen := cdsGen.FieldByName('ITE_PREVEN').AsFloat;
      objColorante.StrPromoc := 'N';
    End;

    objColorante.strImpDir := cdsGen.FieldByName('ITE_IMPDIR').AsString;
    objColorante.strCodIte := cdsGen.FieldByName('COL_CODITE').AsString;

    objColorante.fltOutVal := cdsGen.FieldByName('ITE_OUTVAL').AsFloat;

    if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
      objColorante.fltIcmSai := calculadorFatVendas.fCalculaAliquota(objColorante.strCodIte, objColorante.strImpDir)
    else
      objColorante.fltIcmSai := cdsGen.FieldByName('ITE_ICMSAI').AsFloat;

    objColorante.fltImpFed := cdsGen.FieldByName('ITE_IMPFED').AsFloat;
    objColorante.fltDesOpe := cdsGen.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;
    objColorante.fltPreMed := cdsGen.FieldByName('ITE_PREMED').AsFloat;
    objColorante.fltPreUlt := cdsGen.FieldByName('ITE_PREULT').AsFloat;
    objColorante.fltImpUlt := cdsGen.FieldByName('ITE_IMPULT').AsFloat;
    objColorante.fltComLiq := fFormataFloat(fCalculaPrecoCompraLiq(cdsGen.Fieldbyname('ITE_PRECOM').AsFloat, cdsGen.Fieldbyname('ITE_DESF01').AsFloat,
                                                                   cdsGen.Fieldbyname('ITE_DESF02').AsFloat, cdsGen.Fieldbyname('ITE_DESF03').AsFloat,
                                                                   cdsGen.Fieldbyname('ITE_DESF04').AsFloat, cdsGen.Fieldbyname('ITE_DESF05').AsFloat,
                                                                   cdsGen.Fieldbyname('ITE_DESF06').AsFloat), fCfgSis('DECUNI', VarInteger));
  End;

  FCalculo.Add('Valor da Base = ' + FloatToStrF(fltVenBas, ffFixed, 12, 2));
  FCalculo.Add('Valor do Colorante = (Quantidade * 0.154) * (Preço / 1000)');
  FCalculo.Add('Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)');
end;

procedure TFormulaSuvinil.pCarregarColorantes;
begin
  Try
    qryCadCol.SQL.Clear;
    qryCadCol.SQL.Add(' SELECT                             ');
    qryCadCol.SQL.Add('   COL_CODCOL                       ');
    qryCadCol.SQL.Add('   , COL_CODITE                     ');
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
    qryCadCol.SQL.Add('   SUV_CADCOL                       ');
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

procedure TFormulaSuvinil.SetIteBas(const Value: String);
var
  qryAux: TUniQuery;
  fltIcmsai: Double;
  base: ITintaDeMaquinaComponente;
  cdsGen: TUniClientDataSet;
  fltPreCusPro, fltPreVenPro: Double;
  conf: IConfTinta;
  fltDesOpeTinta: Double;

  function fPrecoCusto2Base(const fltPreCus, fltPreVen: Double): Double;
  begin
    Result := fCalculaPrecoCusto2(fltPreVen,
      fltPreCus,
      cdsGen.FieldByName('ITE_OUTVAL').AsFloat,
      fltIcmsai,
      cdsGen.FieldByName('ITE_IMPFED').AsFloat,
      cdsGen.FieldByName('ITE_DESOPE').AsFloat);
  end;
begin
  tintaDeMaquina.Remover(tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(FIteBas)));
  tintaDeMaquina.Remover(tintaDeMaquina.Localizar(TTintaDeMaquinaComponenteComparerBaseImobiliaria.Create(FIteBasOri)));
  inherited;

  conf := fGetConfTinta('SUV');
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
          qryAux.SQL.Add('   , ITE_PREMED                       ');          

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
          end
          else
          begin
            qryAux.SQL.Add('   , 0 AS ITE_ICMSAI                  ');
            qryAux.SQL.Add('   , 0 AS ITE_IMPFED                  ');
            qryAux.SQL.Add('   , 0 AS ITE_DESOPE                  ');
            qryAux.SQL.Add('   , 0 AS ITE_OUTVAL                  ');
          end;

          If fCfgSis('IMPDIG') = '1' Then
            qryAux.SQL.Add('   , I.ITE_IMPDIR                     ')
          else
            qryAux.SQL.Add('   , G.ITE_IMPDIR                     ');

          If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
          begin
            qryAux.SQL.Add('   , SUV_PRECUS AS ITE_PRECUS         ');
            qryAux.SQL.Add('   , SUV_PREVEN AS ITE_PREVEN         ');
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
          qryAux.SQL.Add('   SUV_CADBAS B                       ');
          qryAux.SQL.Add('   INNER JOIN CADITE I                ');
          qryAux.SQL.Add('     ON B.SUV_CODITE = I.ITE_CODITE   ');
          qryAux.SQL.Add('   INNER JOIN ITEGER G                ');
          qryAux.SQL.Add('     ON I.ITE_CODITE = G.ITE_CODITE   ');
          qryAux.SQL.Add(' WHERE I.ITE_CODITE = :CODITE         ');
          qryAux.SQL.Add('   AND G.ITE_CODEMP = :CODEMP         ');

          qryAux.ParamByName('CODITE').AsString := FIteBas;
          qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
          cdsGen := TClientDataSetFactory.GetClientDataSet(qryAux);

          If fCarregaPromocao(Value, fTabPreco, strCodCli, strCodCnd, intPrzMed,
            fltPreCusPro, fltPreVenPro) Then
          Begin
            FCusBasOri := fltPreCusPro;
            FVenBasOri := fltPreVenPro;
            FPromoc := 'S';

            If FCusBasOri = 0 Then
              FCusBasOri := cdsGen.FieldByName('ITE_PRECUS').AsFloat;
          End
          Else
          Begin
            If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
            begin
              FCusBasOri := cdsGen.FieldByName('ITE_PRECUS').AsFloat;
              FVenBasOri := cdsGen.FieldByName('ITE_PREVEN').AsFloat;
            end
            else
            begin
              FCusBasOri := cdsGen.FieldByName('ITE_PRECUS').AsFloat;
              FVenBasOri := cdsGen.FieldByName('ITE_PREVEN').AsFloat;
            end;
          End;

          FVenBasOri := FVenBasOri + (fltPerAcr * FVenBasOri);

          FOutValBas := cdsGen.FieldByName('ITE_OUTVAL').AsFloat;

          if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
          begin
            fltIcmsai := calculadorFatVendas.fCalculaAliquota(Value, cdsGen.FieldByName('ITE_IMPDIR').AsString);
            FIcmsaiBas := fltIcmsai * FVenBasOri / 100;
          end
          else
          begin
            fltIcmsai := cdsGen.FieldByName('ITE_ICMSAI').AsFloat;
            FIcmsaiBas := fltIcmsai * FVenBasOri / 100;
          end;

          FImpFedBas := cdsGen.FieldByName('ITE_IMPFED').AsFloat * FVenBasOri / 100;
          FDesOpeBas := (((cdsGen.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta) * FVenBasOri) / 100);
          FCu2BasOri := fPrecoCusto2Base(FCusBasOri, FVenBasOri);
          
          FPreMedBas := cdsGen.FieldByName('ITE_PREMED').AsFloat;
          FPreUltBas := cdsGen.FieldByName('ITE_PREULT').AsFloat;
          FImpUltBas := cdsGen.FieldByName('ITE_IMPULT').AsFloat;

          FComLiqBas := fFormataFloat(fCalculaPrecoCompraLiq(cdsGen.Fieldbyname('ITE_PRECOM').AsFloat, cdsGen.Fieldbyname('ITE_DESF01').AsFloat,
                                                             cdsGen.Fieldbyname('ITE_DESF02').AsFloat, cdsGen.Fieldbyname('ITE_DESF03').AsFloat,
                                                             cdsGen.Fieldbyname('ITE_DESF04').AsFloat, cdsGen.Fieldbyname('ITE_DESF05').AsFloat,
                                                             cdsGen.Fieldbyname('ITE_DESF06').AsFloat), fCfgSis('DECUNI', VarInteger));
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
        cdsGen := TClientDataSetFactory.GetClientDataSet(qryAux);

        If fCarregaPromocao(Value, fTabPreco, strCodCli, strCodCnd, intPrzMed,
          fltPreCusPro, fltPreVenPro) Then
        Begin
          FCusBas := fltPreCusPro;
          FVenBas := fltPreVenPro;
          FPromoc := 'S';

          If FCusBas = 0 Then
            FCusBas := cdsGen.FieldByName('ITE_PRECUS').AsFloat;
        End
        Else
        Begin
          FCusBas := cdsGen.FieldByName('ITE_PRECUS').AsFloat;
          FVenBas := cdsGen.FieldByName('ITE_PREVEN').AsFloat;
        End;

        FVenBas := FVenBas + (fltPerAcr * FVenBas);

        FOutValBas := cdsGen.FieldByName('ITE_OUTVAL').AsFloat;

        if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
        begin
          fltIcmsai := calculadorFatVendas.fCalculaAliquota(Value, cdsGen.FieldByName('ITE_IMPDIR').AsString);
          FIcmsaiBas := fltIcmsai * FVenBas / 100;
        end
        else
        begin
          fltIcmsai := cdsGen.FieldByName('ITE_ICMSAI').AsFloat;
          FIcmsaiBas := fltIcmsai * FVenBas / 100;
        end;

        FImpFedBas := cdsGen.FieldByName('ITE_IMPFED').AsFloat * FVenBas / 100;
        FDesOpeBas := (((cdsGen.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta) * FVenBas) / 100);
        FCu2Bas := fPrecoCusto2Base(FCusBas, FVenBas);
        FPreMedBas := cdsGen.FieldByName('ITE_PREMED').AsFloat;
        FPreUltBas := cdsGen.FieldByName('ITE_PREULT').AsFloat;
        FImpUltBas := cdsGen.FieldByName('ITE_IMPULT').AsFloat;
        FComLiqBas := fFormataFloat(fCalculaPrecoCompraLiq(cdsGen.Fieldbyname('ITE_PRECOM').AsFloat, cdsGen.Fieldbyname('ITE_DESF01').AsFloat,
                                                           cdsGen.Fieldbyname('ITE_DESF02').AsFloat, cdsGen.Fieldbyname('ITE_DESF03').AsFloat,
                                                           cdsGen.Fieldbyname('ITE_DESF04').AsFloat, cdsGen.Fieldbyname('ITE_DESF05').AsFloat,
                                                           cdsGen.Fieldbyname('ITE_DESF06').AsFloat), fCfgSis('DECUNI', VarInteger));
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
    if Assigned(qryAux) then FreeAndNil(qryAux);
  End;
end;

function fDigDadosTintometricos(qryCadSuv: TUniClientDataSet; strTabPre: String;
  Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
  Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;
var
  objColorante: TColoranteImobiliario;
  objFormula: TFormulaSuvinil;
  intContador: Integer;
  conf: IConfTinta;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  Result := False;
  objFormula := nil;
  frmDigTintaImobiliaria := nil;
  Try
    Try
      conf := fGetConfTinta('SUV');

      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaSuvinil.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltFatorEstoque := 0.154;
      objFormula.strIteBasOri := fRetornaProdutoBase(qryCadSuv.FieldByName('SUV_CODFML').AsString,
                                                     qryCadSuv.FieldByName('SUV_CODBAS').AsString,
                                                     qryCadSuv.FieldByName('SUV_CODUNI').AsString);

      objFormula.strIteBas    := objFormula.strIteBasOri;
      objFormula.strUnidad    := qryCadSuv.FieldByName('SUV_CODUNI').AsString;
      objFormula.strDescri    := qryCadSuv.FieldByName('SUV_DESCRI').AsString;
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);

      For intContador := 1 To 15 Do
      Begin

        If (fEmptyStr(qryCadSuv.FieldByName('SUV_FORM' + fStrZero(intContador, 2)).AsString)) Then
          Break;

        objColorante := TColoranteImobiliario(objFormula.Add);
        objColorante.strCodCol := qryCadSuv.FieldByName('SUV_FORM' + fStrZero(intContador, 2)).AsString;
        objColorante.fltQtdCol := qryCadSuv.FieldByName('SUV_QTDB' + fStrZero(intContador, 2)).AsFloat;

      End;

      objFormula.pCarregaPrecosColorantes;

      Result := False;

      Application.CreateForm(TfrmDigTintaImobiliaria, frmDigTintaImobiliaria);
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTintaImobiliaria.Caption := frmDigTintaImobiliaria.Caption + 'Suvinil';
      frmDigTintaImobiliaria.objFormula := objFormula;
      frmDigTintaImobiliaria.fltPerDes  := conf.fGetDouble('DESSUV');

      frmDigTintaImobiliaria.Label3.Visible := True;
      frmDigTintaImobiliaria.edtNovBas.Visible := True;
      frmDigTintaImobiliaria.edtDesNovBas.Visible := True;
      frmDigTintaImobiliaria.edtPreNovBas.Visible := True;
      frmDigTintaImobiliaria.Label4.Visible := True;

      if fCfgSis('TROBAS') <> 'N' then
      begin
        If frmDigTintaImobiliaria.ShowModal = mrOk Then
          Result := True;
      end
      else
      begin
        frmDigTintaImobiliaria.FormShow(frmDigTintaImobiliaria);
        frmDigTintaImobiliaria.edtNovBas.Text := frmDigTintaImobiliaria.edtBasAtu.Text;
        objFormula.strIteBas := frmDigTintaImobiliaria.edtNovBas.Text;
        frmDigTintaImobiliaria.edtPreNovBas.Text := FloatToStrF(objFormula.fltVenBas, ffFixed, 12, 2);
        TfrmDigTintaImobiliariaCustom(frmDigTintaImobiliaria).pCalculaTotais;
        frmDigTintaImobiliaria.Label3.Visible := False;
        frmDigTintaImobiliaria.edtNovBas.Visible := False;
        frmDigTintaImobiliaria.edtDesNovBas.Visible := False;
        frmDigTintaImobiliaria.edtPreNovBas.Visible := False;
        frmDigTintaImobiliaria.Label4.Visible := False;
        pSetFocus(frmDigTintaImobiliaria.edtBasAtu);
        If frmDigTintaImobiliaria.ShowModal = mrOk Then
          Result := True;
      end;

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

procedure pRetornaDadosSuvinilDinamica(strIteTin: String; dicRetorno: TDicionario);
var
  qryCadSuv: TUniQuery;
  cdsCadSuv: TUniClientDataSet;
begin
  qryCadSuv := nil;
  Try
    Try
      qryCadSuv := fCriaQuery(Nil);

      if not TMultiSelectLocalizadorFactory.GetLocalizador('SUV').Localizar(cdsCadSuv, ['ITETIN'], [strIteTin]) then
        Exit;

      dicRetorno['codtin'] := cdsCadSuv.FieldByName('SUV_DESCRI').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryCadSuv) then FreeAndNil(qryCadSuv);
  End;
end;

procedure pRetornaTabelaPrecoSuvinil(dicRetorno: TDicionario);
var
  objFormula: TFormulaSuvinil;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaSuvinil.Create('1');
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltFatorEstoque := 0.154;
      objFormula.strIteBasOri := fGetItemBaseOri(dicRetorno['itetin']);
      pRetornaTabelaPrecoImobiliarias(dicRetorno, objFormula, 0.154);
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

procedure SuvinilPulsoParaOnca(const fltPulsos: Double; var intParteInteira: Integer; var fltParteFracao: Double);
begin
  intParteInteira := Trunc((fltPulsos / 48) / 4);
  fltParteFracao :=  (((fltPulsos / 48) / 4) - intParteInteira) * 48;
end;


{ TfrmConsultaCompSuvinil }

procedure TfrmConsultaCompSuvinil.pTarefaFormulacao(Sender: TObject);
var
  qryGen: TUniQuery;
  strCodIte: String;
  strDesBas: String;
  strRefBas: String;
  strUniBas: String;
  strDesCor: String;
  fltPreCus: Double;
  fltUnitar: Double;
begin
  qryGen := nil;
  Try
    Try
      If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
        Exit;

      qryGen := fCriaQuery(Self);
      qryGen.SQL.Add('SELECT * FROM SUV_CADSUV WHERE AUTOINCREM = :AUTINC');
      qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;

      fDigDadosTintometricos(TClientDataSetFactory.GetClientDataSet(qryGen),
        strTabPre, strCodIte, strDesBas, strRefBas, strUniBas, strDesCor,
        fltPreCus, fltUnitar, TDicionario.Create);
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

procedure TfrmConsultaCompSuvinil.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompSuvinil.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadSuvNovasFormulas', False);
end;

function fConsultaSuvinilDinamicaInterna(Sender: TForm;  qryCadSuv: TUniQuery;
  strTabPre: String; tipoConsulta: TTipoConsulta): String; stdcall;
begin
  Result := (TSuvinilConsulta.Create).fExecutarConsulta(Sender,
    qryCadSuv, tipoConsulta, strTabPre, TfrmConsultaCompSuvinil);
end;

function fGetItemBaseOri(const strIteTin: String): string;
var
  cdsGen: TUniClientDataSet;
begin
  Result := '';
  Try
    Try
      if TMultiSelectLocalizadorFactory.GetLocalizador('SUVBAS').Localizar(cdsGen, ['ITETIN'], [strIteTin]) then
        Result := cdsGen.FieldByName('CODITE').AsString;
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
