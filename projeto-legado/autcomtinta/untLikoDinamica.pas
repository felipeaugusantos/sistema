unit untLikoDinamica;

interface

uses Forms, Classes, Uni, SysUtils,  StrUtils,
  untFuncEspecificas, Controls, untFuncoesSimples,
  untPnlBotoesAcoesNovaConsulta,
  UniClientDataSet,
  Math;

Type
  TFormulaLiko = class(TFormulaImobiliaria)
    private
      fltPerAcr: Double;
    protected
      procedure SetIteBas(const Value: String); override;
      procedure pCarregarColorantes; override;
    public
      fltFatEmb: Double;
      procedure pCarregaPrecosColorantes; override;
      procedure pCalculaPreco; override;
      constructor Create(strTabPrePar: String); override;
  End;

  TfrmConsultaCompLiko = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;

  function fRetFatorEmbalagem(strCodEmb: String): Double;

  function fConsultaLikoDinamica(Sender: TForm): String; stdcall;
  function fConsultaLikoDinamicaGeral(Sender: TForm): String; stdcall;
  function fConsultaLikoDinamicaVenda(Sender: TForm; qryCadLik: TUniQuery; strTabPre: String;
    blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;

  function fConsultaLikoDinamicaInterna(Sender: TForm;
    qryCadLik: TUniQuery; strTabPre: String; tipoConsulta: TTipoConsulta;
    blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;

  function fRetornaDescricaoLikoDinamica(strDescri: String; qryTinta: TUniQuery): String;
  function fRetornaReferenciaLikoDinamica(qryTinta: TUniQuery): String;

  function fRetornaUniTraProLikoDinamica(fltPrcTin, fltPrvTin: Double): Double;

  function fRetornaPrecoLikoDinamica(Sender: TForm; qryCadLik: TUniQuery;
    Var dicRetorno: TDicionario; blnFaturamento: Boolean; strTab: String = 'N';
    strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;

  function fDigDadosTintometricos(qryCadLik: TUniClientDataSet; strTabPre,
    strCodEmp: String; Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
    Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;

  function fRetornaProdutoBase(strCodBas, strUnidad: String): String;

  function fGTinForLikoDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;

  procedure pRetornaDadosLikoDinamica(strIteTin: String; dicRetorno: TDicionario);
  procedure pRetornaTabelaPrecoLiko(dicRetorno: TDicionario);
  function GetIteBasOri(const strIteTin: string): string;

implementation

uses 
DB, untDigTintaImobiliaria,
untLikoConsulta, untTintaMaquina, untIConfTinta, untQryConIteFactory, untGenericTintaDeMaquinaComponente,
untTintaDeMaquinaComponenteTipo, untMultiSelectLocalizadorFactory,untFuncoes,
untICalculadorFatVendas,
untITintaDeMaquinaComponente,
untIConsultaTinta,
untClientDataSetFactory,
untTintaDeMaquinaComponenteComparerColorante,
untTintaDeMaquinaComponenteComparerBaseImobiliaria;

function fConsultaLikoDinamica(Sender: TForm): String;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery(Sender);
      Result := fConsultaLikoDinamicaInterna(Sender, qryGen, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcGeral, False, Nil, Nil);
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

function fConsultaLikoDinamicaGeral(Sender: TForm): String;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery(Sender);
      Result := fConsultaLikoDinamicaInterna(Sender, qryGen, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcGeral, False, Nil, Nil);
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

function fConsultaLikoDinamicaVenda(Sender: TForm; qryCadLik: TUniQuery; strTabPre: String;
  blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String;
begin
  Result := fConsultaLikoDinamicaInterna(Sender, qryCadLik, strTabPre, tpcVenda, blnFaturamento, dicRetorno, sltItems);
end;

function fRetornaDescricaoLikoDinamica(strDescri: String; qryTinta: TUniQuery): String;
begin
  {***********************************}
  {* AGORA  DESCRIÇÃO É CONFIGURAVEL *}
  {********************************PH*}
  Result := strDescri;
end;

function fRetornaReferenciaLikoDinamica(qryTinta: TUniQuery): String;
begin
  Result := '';
end;

function fRetornaUniTraProLikoDinamica(fltPrcTin, fltPrvTin: Double): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := fGetConfTinta('LIK');

  strSiglaTrava := conf.fGet('TRACOR');
  fltFatTrava   := conf.fGetDouble('FATCOR');

  If strSiglaTrava = 'CUS' Then
    Result := fltPrcTin
  Else
    Result := fltPrvTin;

  Result := Result * fltFatTrava;
end;

function fRetornaPrecoLikoDinamica(Sender: TForm; qryCadLik: TUniQuery;
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
  strRefBas: String;
  strDesBas: String;
  strUniBas: String;
  strChaFor: String;

  strAuto: String;
  tinta : IConsultaTinta;
  cdsCadLik: TUniClientDataSet;
  conf: IConfTinta;
begin
  conf := fGetConfTinta('LIK');

  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTabPre    := dicRetorno['tabpre'];

  Result := False;
  strAuto := '-1';

  If strTab = 'N' Then
  Begin
    strAuto := fConsultaLikoDinamicaVenda(Sender, qryCadLik, strTabPre, blnFaturamento, dicRetorno, sltItems);
    If (strAuto = '-1') Then
    Begin
      Exit;
    End;
  End
  Else
    strAuto := strAutoTab;

  tinta := TLikoConsulta.Create;

  qryCadLik.Close;
  qryCadLik.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
  cdsCadLik := TClientDataSetFactory.GetClientDataSet(qryCadLik);

  If (Not fDigDadosTintometricos(cdsCadLik, strTabPre, strCodEmp,
        strCodIte, strDesBas, strRefBas, strUniBas, strDesCor,
        fltPreCus, fltUnitar, dicRetorno)) Then
  Begin
    Exit;
  End;

  strDesCor := Trim(strDesCor + ' ' + tinta.fGetDescricao(cdsCadLik.FieldByName('AUTOINCREM').AsString, strCodIte));

  strChaFor := IIF(fEmptyStr(strRefBas), '', ' ') + strRefBas + IIF(fEmptyStr(strRefBas), '', ' ') + strUniBas;
  strChaFor := strChaFor +  ' ' + cdsCadLik.FieldByName('LIK_CODIGO').AsString;

  strIteTin := cdsCadLik.FieldByName('LIK_MD5KEY').AsString;

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
  dicRetorno['chafor'] := strChaFor;
  dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

  Result := True;
end;

function fDigDadosTintometricos(qryCadLik: TUniClientDataSet; strTabPre,
  strCodEmp: String; Var strNovBas, strDesBas, strRefere, strUniBas, strDesCor: String;
  Var fltPreCus, fltPreVen: Double; dicRetorno: TDicionario): Boolean;
var
  objColorante: TColoranteImobiliario;
  objFormula: TFormulaLiko;
  intContador: Integer;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  frmDigTintaImobiliaria := nil;
  objFormula := nil;
  Result := False;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaLiko.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltFatorEstoque := 1;
      objFormula.strOpcDoc    := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli    := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd    := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed    := IfNull(dicRetorno['przmed'], 0);
      objFormula.strIteBasOri := fRetornaProdutoBase(qryCadLik.FieldByName('LIK_CODBAS').AsString,
                                                     qryCadLik.FieldByName('LIK_CODUNI').AsString);

      objFormula.strIteBas    := objFormula.strIteBasOri;
      objFormula.strUnidad    := qryCadLik.FieldByName('LIK_UNIDAD').AsString;
      objFormula.strDescri    := qryCadLik.FieldByName('LIK_DESCRI').AsString;
      objFormula.fltFatEmb    := fRetFatorEmbalagem(qryCadLik.FieldByName('LIK_CODEMB').AsString);

      For intContador := 1 To 10 Do
      Begin

        If (fEmptyStr(qryCadLik.FieldByName('LIK_FORM' + fStrZero(intContador, 2)).AsString)) Then
          Break;

        objColorante := TColoranteImobiliario(objFormula.Add);
        objColorante.strCodCol := qryCadLik.FieldByName('LIK_FORM' + fStrZero(intContador, 2)).AsString;
        objColorante.fltQtdCol := qryCadLik.FieldByName('LIK_QTDC' + fStrZero(intContador, 2)).AsFloat;

      End;

      objFormula.pCarregaPrecosColorantes;

      Result := False;
      Try
        Application.CreateForm(TfrmDigTintaImobiliaria, frmDigTintaImobiliaria);
        objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
        frmDigTintaImobiliaria.Caption := frmDigTintaImobiliaria.Caption + 'Liko';
        frmDigTintaImobiliaria.objFormula := objFormula;
        frmDigTintaImobiliaria.strIdePro  := 'LIK';
        If frmDigTintaImobiliaria.ShowModal = mrOk Then
          Result := True;
      Finally

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

function fRetornaProdutoBase(strCodBas, strUnidad: String): String;
var
  qryAux: TUniQuery;
begin
  qryAux := nil;
  Try
    Try
      qryAux := fCriaQuery(Nil);
      qryAux.SQL.Add('SELECT ');
      qryAux.SQL.Add('  BAS_CODITE ');
      qryAux.SQL.Add('FROM ');
      qryAux.SQL.Add('  LIK_CADBAS ');
      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  BAS_BASE__ = :CODBAS AND ');
      qryAux.SQL.Add('  BAS_UNIDAD = :UNIDAD ');

      qryAux.ParamByName('CODBAS').AsString := strCodBas;
      qryAux.ParamByName('UNIDAD').AsString := strUnidad;

      Result := TClientDataSetFactory.GetClientDataSet(qryAux).FieldByName('BAS_CODITE').AsString;
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

function fGTinForLikoDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
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

      Result := TMultiSelectLocalizadorFactory.GetLocalizador('LIK').Localizar(cdsGen, ['ITETIN'], [strIteTin]);
      if not Result then
        Exit;

      For intContador := 1 To 10 Do
      Begin

        strCamFor := 'LIK_FORM' + fStrZero(IntToStr(intContador), 2);
        strCamBas := 'LIK_QTDC' + fStrZero(IntToStr(intContador), 2);

        arrFormul[intContador].strFormul := cdsGen.FieldByName(strCamFor).AsString;
        arrFormul[intContador].fltQtdBas := cdsGen.FieldByName(strCamBas).AsFloat;

        dicColorantes[arrFormul[intContador].strFormul] := arrFormul[intContador].fltQtdBas;

        {*******************************************}
        {* GUARDA COLORANTES PARA POSTERIOR BUSCA  *}
        {* DOS ITENS                               *}
        {****************************************MV*}
        If (Not fEmptyStr(arrFormul[intContador].strFormul)) Then
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
      strSQL := strSQL + '  LIK_CADCOL ';
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

{ TFormulaLiko }

constructor TFormulaLiko.Create(strTabPrePar: String);
  Var
    conf: IConfTinta;
begin
  inherited;
  conf := fGetConfTinta('LIK');
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;
end;

procedure TFormulaLiko.pCalculaPreco;
var
  objColorante: TColoranteImobiliario;
  intIndex: Integer;
  componente: ITintaDeMaquinaComponente;
  cdsCadCol: TUniClientDataSet;

  procedure pZerarPrecos;
  begin
    FPreCus := 0.0;
    FPreVen := 0.0;
    FCu2Col := 0.0;
    FCusCol := 0.0;
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

    If (Not cdsCadCol.Locate('COL_CODCOL', objColorante.strCodcol, [])) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('Colorante ' + objColorante.strCodCol + ' não cadastrado. Favor verificar.');
      Exit;
    End;

    If (fEmptyStr(cdsCadCol.FieldByName('COL_CODITE').AsString)) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('Colorante ' + objColorante.strCodCol + ' não está com o produto para venda associado.' + #13#10 +
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
        objColorante.strCodIte, objColorante.strCodCol, tmctColoranteImobiliario
      ));
    end;

    componente.Quantidade                := objColorante.fltQtdCol;
    componente.PrecoCusto                := objColorante.fltQtdCol * objColorante.fltPreCus / 3600;
    componente.PrecoCustoReal            := objColorante.fltQtdCol * objColorante.fltPreCu2 / 3600;
    componente.PrecoVenda                := objColorante.fltQtdCol * objColorante.fltPreVen / 3600;
    componente.PrecoMedio                := objColorante.fltQtdCol * objColorante.fltPreMed / 3600;
    componente.OutrosValores             := objColorante.fltOutVal * objColorante.fltQtdCol / 3600;
    componente.IcmsSaida                 := objColorante.fltIcmSai * (objColorante.fltPreVen * objColorante.fltQtdCol / 3600) / 100;
    componente.ImpostosFederais          := objColorante.fltImpFed * (objColorante.fltPreVen * objColorante.fltQtdCol / 3600) / 100;
    componente.DespesasOperacionais      := objColorante.fltDesOpe * (objColorante.fltPreVen * objColorante.fltQtdCol / 3600) / 100;
    componente.UltimoPrecoCompra         := objColorante.fltQtdCol * objColorante.fltPreUlt / 3600;
    componente.UltimoPrecoCompraImpostos := objColorante.fltQtdCol * objColorante.fltImpUlt / 3600;
    componente.PrecoCompraLiquido        := objColorante.fltQtdCol * objColorante.fltComLiq / 3600;

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

procedure TFormulaLiko.pCarregaPrecosColorantes;
var
  intContador: Integer;
  objColorante: TColoranteImobiliario;
  cdsGen: TUniClientDataSet;

  fltPreCusPro: Double;
  fltPreVenPro: Double;
  conf: IConfTinta;
  fltDesOpeTinta: Double;
begin
  conf := fGetConfTinta('LIK');
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
      objColorante.strPromoc := 'S';
    End
    Else
    Begin
      objColorante.fltPreCus := cdsGen.FieldByName('ITE_PRECUS').AsFloat;
      objColorante.fltPreVen := cdsGen.FieldByName('ITE_PREVEN').AsFloat;
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
  FCalculo.Add('Valor do Colorante = Quantidade * Preço / 3600');
  FCalculo.Add('Valor da Tinta = Valor da Base + (Soma do Valor do Colorante de todos os Colorantes)');
end;

procedure TFormulaLiko.pCarregarColorantes;
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
    qryCadCol.SQL.Add('   LIK_CADCOL                       ');
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

procedure TFormulaLiko.SetIteBas(const Value: String);
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
  conf := fGetConfTinta('LIK');
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
          qryAux.SQL.Add('   LIK_CADBAS B                       ');
          qryAux.SQL.Add('   INNER JOIN CADITE I                ');
          qryAux.SQL.Add('     ON B.BAS_CODITE = I.ITE_CODITE   ');
          qryAux.SQL.Add('   INNER JOIN ITEGER G                ');
          qryAux.SQL.Add('     ON I.ITE_CODITE = G.ITE_CODITE   ');
          qryAux.SQL.Add(' WHERE I.ITE_CODITE = :CODITE         ');
          qryAux.SQL.Add('   AND G.ITE_CODEMP = :CODEMP         ');

          qryAux.ParamByName('CODITE').AsString := FIteBas;
          qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
          cdsGen := TClientDataSetFactory.GetClientDataSet(qryAux);

          If fCarregaPromocao(Value, fTabPreco, strCodCli, strCodCnd, intPrzMed,fltPreCusPro, fltPreVenPro) Then
          Begin
            FCusBasOri := fltPreCusPro;
            FVenBasOri := fltPreVenPro;
            FPromoc    := 'S';

            If FCusBasOri = 0 Then
              FCusBasOri := cdsGen.FieldByName('ITE_PRECUS').AsFloat;
          End
          Else
          Begin
            FCusBasOri := cdsGen.FieldByName('ITE_PRECUS').AsFloat;
            FVenBasOri := cdsGen.FieldByName('ITE_PREVEN').AsFloat;
            FPromoc    := 'N';
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
          FPreMedBas := cdsGen.FieldByName('ITE_PREMED').AsFloat;
          FCu2BasOri := fPrecoCusto2Base(FCusBasOri, FVenBasOri);
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
          FPromoc := 'N';
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

function fRetFatorEmbalagem(strCodEmb: String): Double;
var
  qryGen: TUniQuery;
  cdsGen: TUniClientDataSet;
begin
  Result := 0;
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT DISTINCT ' +
        '   EMB_QTDEMB    ' +
        '   , EMB_CODEMB  ' +
        ' FROM            ' +
        '   LIK_CADEMB ';
      cdsGen := TClientDataSetFactory.GetClientDataSet(qryGen);
      if cdsGen.Locate('EMB_CODEMB', strCodEmb, []) then
        Result := RoundTo(cdsGen.FieldByName('EMB_QTDEMB').AsFloat / 1000, -4);
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

procedure pRetornaDadosLikoDinamica(strIteTin: String; dicRetorno: TDicionario);
var
  cdsGen: TUniClientDataSet;
begin
  if TMultiSelectLocalizadorFactory.GetLocalizador('LIK').Localizar(cdsGen, ['ITETIN'], [strIteTin]) then
  begin
    dicRetorno['codtin'] := cdsGen.FieldByName('LIK_CODIGO').AsString + '/' +
      cdsGen.FieldByName('LIK_UNIDAD').AsString;
    dicRetorno['martin'] := cdsGen.FieldByName('LIK_DESCRI').AsString;
  end;
end;

procedure pRetornaTabelaPrecoLiko(dicRetorno: TDicionario);
var
  objFormula: TFormulaLiko;
  calculadorFatVendas: ICalculadorFatVendas;
begin
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaLiko.Create('1');
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.strIteBasOri := GetIteBasOri(dicRetorno['itetin']);
      objFormula.strOpcDoc    := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli    := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd    := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed    := IfNull(dicRetorno['przmed'], 0);

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

{ TfrmConsultaCompLiko }

procedure TfrmConsultaCompLiko.pTarefaFormulacao(
  Sender: TObject);
var
  qryGen: TUniQuery;
  fltPreCus: Double;
  fltUnitar: Double;
  strCodIte: String;
  strDesCor: String;
  strRefBas: String;
  strDesBas: String;
  strUniBas: String;
  cdsGen: TUniClientDataSet;
begin
  inherited;
  qryGen := nil;
  Try
    Try
      If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
        Exit;

      qryGen := fCriaQuery(Self);
      qryGen.SQL.Add('SELECT * FROM LIK_CADLIK WHERE AUTOINCREM = :AUTINC');
      qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
      cdsGen := TClientDataSetFactory.GetClientDataSet(qryGen);

      fDigDadosTintometricos(cdsGen, strTabPre, VS_strCodEmp, strCodIte, strDesBas,
            strRefBas, strUniBas, strDesCor, fltPreCus, fltUnitar, TDicionario.Create);
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

procedure TfrmConsultaCompLiko.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompLiko.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadLikoDinNfm', False);
end;

function fConsultaLikoDinamicaInterna(Sender: TForm;
  qryCadLik: TUniQuery; strTabPre: String; tipoConsulta: TTipoConsulta;
  blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;
begin
  Result := (TLikoConsulta.Create).fExecutarConsulta(Sender,
    qryCadLik, tipoConsulta, strTabPre, TfrmConsultaCompLiko,
    '', blnFaturamento, dicRetorno, sltItems);
end;

function GetIteBasOri(const strIteTin: string): string;
var
  cdsGen: TUniClientDataSet;
begin
  Result := '';
  if TMultiSelectLocalizadorFactory.GetLocalizador('LIKBAS').Localizar(cdsGen, ['ITETIN'], [strIteTin]) then
    Result := cdsGen.FieldByName('BAS_CODITE').AsString;
end;

end.

