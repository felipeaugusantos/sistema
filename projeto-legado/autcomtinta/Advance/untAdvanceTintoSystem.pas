unit untAdvanceTintoSystem;

interface

uses
  Forms, Uni, untFuncoesSimples, Classes,  SysUtils,
  Controls,  UniClientDataSet, untPnlBotoesAcoesNovaConsulta,
  StrUtils, untFuncEspecificas;

type
  TfrmConsultaCompAdvanceTintoSystem = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;

  function fRetornaPrecoAdvanceNova(const Sender: TForm; const qryCadAdv: TUniQuery; Var dicRetorno: TDicionario;
    blnFaturamento: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;
  function fRetornaUniTraProAdvanceNova(fltPrcTin, fltPrvTin: Double): Double;

  function fDigDadosTintometricos(qryCadAdv: TUniClientDataSet; strTabPre: String;
    var strCodBas,
    strUniBas,
    strDesCor,
    strEmbalagemOriginal,
    strNovaEmbalagem,
    strCatali: string;
    Var fltPreCus,
    fltPreVen,
    fltVolPro: Double;
    dicRetorno: TDicionario): Boolean;

  function fGTinForAdvanceNova(const strIteTin: String;
    Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray;
    Var stlItensTraMl: TStringList;
    const fltVolume: Double;
    const strCatalisador: string;
    const strTipCor: string): Boolean;

  function fConsultaAdvanceNova(Sender: TForm): String; stdcall;
  function fConsultaAdvanceNovaGeral(Sender: TForm): String; stdcall;
  function fConsultaAdvanceNovaVenda(Sender: TForm; qryCadAdv: TUniQuery; strTabPre: String;
    blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;

  procedure pRetornaTabelaPrecoAdvanceNova(dicRetorno: TDicionario);

  function fPesoEspecificoCadBas(strCodBas, strCodEmb: String): Double;

implementation

uses
  untFormulaIndustrial, untIConsultaTinta, untAdvanceTintoSystemConsulta, untClientDataSetFactory,untFuncoes,untDigTintaIndustrialNova,
  untDigTintaIndustrialNovaAdvance, Data.DB,untIConfTinta, untTintaMaquina,untFormulaAdvanceIndustrial;

function fConsultaAdvanceNovaInterna(Sender: TForm;  qryCadAdv: TUniQuery;
  strTabPre: String; tipoConsulta: TTipoConsulta; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;
begin
  Result := (TAdvanceTintoSystemConsulta.Create).fExecutarConsulta(Sender,
    qryCadAdv, tipoConsulta, strTabPre, TfrmConsultaCompAdvanceTintoSystem,
    '', blnFaturamento, dicRetorno, sltItems);
end;


function fRetornaPrecoAdvanceNova(const Sender: TForm; const qryCadAdv: TUniQuery; Var dicRetorno: TDicionario;
  blnFaturamento: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;
var
  strAuto: string;
  strTabPre: string;
  strCodBas: string;
  strUniBas: string;
  strDesCor: string;
  fltPreCus: Double;
  fltPreVen: Double;
  tinta: IConsultaTinta;
  blnUsaPreCus: Boolean;
  fltUnitar: Double;
  fltVolPro: Double;
  cdsCadAdv: TUniClientDataSet;
  strEmbalagemOriginal: string;
  strNovaEmbalagem: string;
  strCatali: string;
  conf: IConfTinta;
begin
  Result := False;
  conf := fGetConfTinta('ADT');
  Try
    Try
      strTabPre := dicRetorno['tabpre'];
      blnUsaPreCus := dicRetorno['usaprecus'];

      If strTab = 'N' Then
      Begin
        strAuto := fConsultaAdvanceNovaVenda(Sender, qryCadAdv, strTabPre, blnFaturamento, dicRetorno, sltItems);
        if strAuto = '-1' then
          Exit;
      End
      Else
        strAuto := strAutoTab;

      tinta := TAdvanceTintoSystemConsulta.Create;
      qryCadAdv.Close;
      qryCadAdv.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
      cdsCadAdv := TClientDataSetFactory.GetClientDataSet(qryCadAdv);

      strDesCor := tinta.fGetDescricao(cdsCadAdv.FieldByName('AUTOINCREM').AsString, strCodBas);

      if not fDigDadosTintometricos(cdsCadAdv,
        strTabPre,
        strCodBas,
        strUniBas,
        strDesCor,
        strEmbalagemOriginal,
        strNovaEmbalagem,
        strCatali,
        fltPreCus,
        fltPreVen,
        fltVolPro,
        dicRetorno) then
        Exit;

      if fltVolPro > 0 then
        strDesCor := FormatFloat('0.000', fltVolPro / 1000) + ' ML ' + Trim(strDesCor + ' ' + tinta.fGetDescricao(cdsCadAdv.FieldByName('AUTOINCREM').AsString, strCodBas))
      else
        strDesCor := Trim(strDesCor + ' ' + tinta.fGetDescricao(cdsCadAdv.FieldByName('AUTOINCREM').AsString, strCodBas));

      strDesCor := StringReplace(strDesCor, strEmbalagemOriginal, strNovaEmbalagem, []);


      If (blnUsaPreCus) Then
        fltUnitar := fltPreCus
      Else
        fltUnitar := fltPreVen;

      dicRetorno['unidad'] := strUniBas;
      dicRetorno['unitar'] := fltUnitar;
      dicRetorno['precus'] := fltPreCus;
      dicRetorno['prvtin'] := fltUnitar;
//      dicRetorno['prctin'] := fltPreCus;
      dicRetorno['descor'] := strDesCor;
      dicRetorno['volpro'] := fltVolPro;
      dicRetorno['catali'] := strCatali;
      dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

      Result := True;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

function fRetornaUniTraProAdvanceNova(fltPrcTin, fltPrvTin: Double): Double;
var
  strSiglaTrava: String;
  fltFatTrava: Double;
  conf: IConfTinta;
begin
  conf := fGetConfTinta('ADT');

  strSiglaTrava := conf.fGet('TRAADT');
  fltFatTrava   := conf.fGetDouble('FATADT');

  If strSiglaTrava = 'CUS' Then
    Result := fltPrcTin
  Else
    Result := fltPrvTin;

  Result := Result * fltFatTrava;
end;

function fDigDadosTintometricos(qryCadAdv: TUniClientDataSet; strTabPre: String;
  var strCodBas,
  strUniBas,
  strDesCor,
  strEmbalagemOriginal,
  strNovaEmbalagem,
  strCatali: string;
  Var fltPreCus,
  fltPreVen,
  fltVolPro: Double;
  dicRetorno: TDicionario): Boolean;
var
  formula: TFormulaAdvanceIndustrial;
  componente: TComponenteIndustrial;
  intCol: Integer;
  frmDig: TfrmDigTintaIndustrialNovaAdvance;
begin
  Result := False;
  formula := nil;
  frmDig := nil;
  Try
    Try
      formula := TFormulaAdvanceIndustrial.Create(strTabPre, qryCadAdv);
      strEmbalagemOriginal := formula.EmbalagemBase;

      formula.strCodCli := IfNull(dicRetorno['codcli'], '');
      formula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      formula.intPrzMed := IfNull(dicRetorno['przmed'], 0);

      for intCol := 1 to 20 do
      begin
        if fEmptyStr(qryCadAdv.FieldByName('ADT_CODC' + fStrZero(intCol, 2)).AsString) then
          Continue;

        componente := TComponenteIndustrial(formula.Add);
        componente.CodigoComponente := qryCadAdv.FieldByName('ADT_CODC' + fStrZero(intCol, 2)).AsString;
        componente.Quantidade := qryCadAdv.FieldByName('ADT_QTDC' + fStrZero(intCol, 2)).AsFloat;
        componente.Tipo := tciColorante;
      end;

      // Catalisador
      if not fEmptyStr(qryCadAdv.FieldByName('ADT_CODCAT').AsString) then
      begin
        componente := TComponenteIndustrial(formula.Add);
        componente.CodigoComponente := qryCadAdv.FieldByName('ADT_CODCAT').AsString;
        componente.Quantidade := qryCadAdv.FieldByName('ADT_QTDCAT').AsFloat;
        componente.Tipo := tciCatalisador;
      end;

      //Base como componente da formulação, caso o usuario venda à granel
//      componente := TComponenteIndustrial(formula.Add);
//      componente.CodigoComponente := qryCadAdv.FieldByName('ADT_CODBAS').AsString;
//      componente.Quantidade := qryCadAdv.FieldByName('ADT_QTDBAS').AsFloat;
//      componente.Tipo := tciBase;

      frmDig := TfrmDigTintaIndustrialNovaAdvance.Create(nil, formula);
      frmDig.strIdePro := 'ADT';
      Result := (frmDig.ShowModal = mrOk);

      if Result then
      begin
        strCodBas := formula.ItemBase;
        strUniBas := formula.Unidade;
        strDesCor := frmDig.edtDesAdi.Text + ' ' + formula.Descricao;
        fltPreVen := formula.PrecoVenda;
        fltPreCus := formula.PrecoCusto;

        dicRetorno['codite'] := strCodBas;
//        dicRetorno['fatace'] := formula.VolumeFinal / formula.VolumeOriginal;
        dicRetorno['tipcor'] := formula.CodigoEmbalagemBase;
        fltVolPro := 0;

        if formula.Personalizada then
        begin
          fltVolPro := formula.VolumeFinal;
          dicRetorno['iteemb'] := fGetConfTinta('ADT').fGet('EMBGRA');
          dicRetorno['codite'] := fGetConfTinta('ADT').fGet('PROGRA');
        end;

        dicRetorno['precu2'] := formula.PrecoCustoReal;
        dicRetorno['premed'] := formula.PrecoMedio;
        dicRetorno['preult'] := formula.PrecoUltimaCompra;
        dicRetorno['impult'] := formula.ImpostosUltimaCompra;
        dicRetorno['prctin'] := formula.PrecoCompraLiq;

        dicRetorno.AdicionarObjeto('formul', formula.GetMatrizSaldosColorantes);
        dicRetorno.AdicionarObjeto('tintaDeMaquina', formula.tintaDeMaquina);

        dicRetorno['itetin'] := qryCadAdv.FieldByName('ADT_MD5KEY').AsString;
        strCatali := IfThen(formula.TemCatalisador and formula.UsaCatalisador, 'S', 'N');

        AcertaImpostos(fltPreCus, formula.PrecoCustoReal,
              formula.OutrosValores,
              formula.IcmSaida,
              formula.ImpostosFederais,
              formula.DespesasOperacionais,
              dicRetorno);

        formula.pRecalculaTabelas(dicRetorno);

        strNovaEmbalagem := frmDig.rgEmbalagens.Items[frmDig.rgEmbalagens.ItemIndex];
      end;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(formula) then FreeAndNil(formula);
    if Assigned(frmDig) then FreeAndNil(frmDig);
  End;
end;

function fGTinForAdvanceNova(const strIteTin: String;
    Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray;
    Var stlItensTraMl: TStringList;
    const fltVolume: Double;
    const strCatalisador: string;
    const strTipCor: string): Boolean;
var
  qryConsulta: TUniQuery;
  cdsConsulta: TUniClientDataSet;
  intCont: Integer;
  dicColorantes: TDicionario;
  stlColorantes: TStringList;
  intForm: Integer;
  cdsCadCol: TUniClientDataSet;
  fltFator: Double;
  qryCadBas: TUniQuery;
  cdsCadBas: TUniClientDataSet;
begin
  Result := False;
  qryConsulta := nil;
  dicColorantes := nil;
  stlColorantes := nil;
  qryCadBas := nil;
  Try
    Try
      qryConsulta := fCriaQuery();
      qryConsulta.SQL.Text :=
        ' SELECT                     ' +
        '   *                        ' +
        ' FROM                       ' +
        '   ADT_CADADT               ' +
        ' WHERE ADT_MD5KEY = :ITETIN ';
      qryConsulta.ParamByName('ITETIN').AsString := strIteTin;
      cdsConsulta := TClientDataSetFactory.GetClientDataSet(qryConsulta);

      if cdsConsulta.IsEmpty then
        Exit;

      qryCadBas := fCriaQuery();
      qryCadBas.SQL.Text :=
        ' SELECT                     ' +
        '   BAS_CODEMB               ' +
        '   , BAS_CONTEU             ' +
        ' FROM                       ' +
        '   ADT_CADBAS               ' +
        ' WHERE BAS_CODBAS = :CODBAS ';
      qryCadBas.ParamByName('CODBAS').AsString := cdsConsulta.FieldByName('ADT_CODBAS').AsString;
      cdsCadBas := TClientDataSetFactory.GetClientDataSet(qryCadBas);
      fltFator := 1;
      if cdsCadBas.Locate('BAS_CODEMB', cdsConsulta.FieldByName('ADT_CODEMB').AsString, []) then
      begin
        fltFator := cdsCadBas.FieldByName('BAS_CONTEU').AsFloat;
        if cdsCadBas.Locate('BAS_CODEMB', strTipCor, []) then
          fltFator := cdsCadBas.FieldByName('BAS_CONTEU').AsFloat / fltFator
        else
          raise Exception.CreateFmt('Não foi possivel encontrar a base [%s - %s]', [cdsConsulta.FieldByName('ADT_CODBAS').AsString, strTipCor]);        
      end;  
      
      

      dicColorantes := TDicionario.Create;
      intForm := 1;
      for intCont := 1 to 20 do
      begin
        if fEmptyStr(cdsConsulta.FieldByName('ADT_CODC' + fStrZero(intCont, 2)).AsString) then
          Continue;

        if cdsConsulta.FieldByName('ADT_QTDC' + fStrZero(intCont, 2)).AsFloat <= 0 then
          Continue;

        arrFormul[intForm].strFormul := cdsConsulta.FieldByName('ADT_CODC' + fStrZero(intCont, 2)).AsString;
        if fltVolume > 0 then
          arrFormul[intForm].fltQtdbas := cdsConsulta.FieldByName('ADT_QTDC' + fStrZero(intCont, 2)).AsFloat *
                                          (fltVolume / cdsConsulta.FieldByName('ADT_QTDFIN').AsFloat)
        else
          arrFormul[intForm].fltQtdbas := cdsConsulta.FieldByName('ADT_QTDC' + fStrZero(intCont, 2)).AsFloat;

        arrFormul[intForm].fltQtdbas := arrFormul[intForm].fltQtdbas * fltFator;
        dicColorantes[arrFormul[intForm].strFormul] := arrFormul[intForm].fltQtdbas;
        intForm := intForm + 1;
      end;

      // Usa catalisador e volume personalisador, pois o catalisador ja é o item da base
      if (strCatalisador = 'S')
//        and (fltVolume > 0)
        and (not fEmptyStr(cdsConsulta.FieldByName('ADT_CODCAT').AsString)) then
      begin
        arrFormul[intForm].strFormul := cdsConsulta.FieldByName('ADT_CODCAT').AsString;
        //Agora o catalizador nao é mais um item da base
        If (fltVolume > 0) Then
          arrFormul[intForm].fltQtdbas := cdsConsulta.FieldByName('ADT_QTDCAT').AsFloat *
                                          (fltVolume / cdsConsulta.FieldByName('ADT_QTDFIN').AsFloat)
        Else
          arrFormul[intForm].fltQtdbas := cdsConsulta.FieldByName('ADT_QTDCAT').AsFloat;

        dicColorantes[arrFormul[intForm].strFormul] := arrFormul[intForm].fltQtdbas;
//        intForm := intForm + 1;
      end;

      // Quando for formula com volume personalizado, a base vai na formulação
//      if fltVolume > 0 then
//      begin
//        arrFormul[intForm].strFormul := cdsConsulta.FieldByName('ADT_CODBAS').AsString;
//        arrFormul[intForm].fltQtdbas := cdsConsulta.FieldByName('ADT_QTDBAS').AsFloat *
//                                        (fltVolume / cdsConsulta.FieldByName('ADT_QTDFIN').AsFloat);

//        dicColorantes[arrFormul[intForm].strFormul] := arrFormul[intForm].fltQtdbas;
//      end;

      stlColorantes := TStringList.Create;
      stlColorantes.StrictDelimiter := True;
      for intCont := 0 to dicColorantes.Chaves.Count - 1 do
      begin
        If intCont = 0 Then
          stlColorantes.Add('"' + dicColorantes.Chaves[intCont] + '"')
        else
          If (dicColorantes.Chaves[intCont] <> '') Then
            stlColorantes.Add(',"'+dicColorantes.Chaves[intCont]+'"');
      end;

      qryConsulta.Close;
      qryConsulta.SQL.Text :=
        ' SELECT           ' +
        '   COL_CODITE,    ' +
        '   COL_CODCOL,    ' +
        '   COL_DESCRI,    ' +
        '   COL_PESESP,    ' +
        '   "N" AS CATALI  ' +
        ' FROM             ' +
        '   ADT_CADCOL     ' +
        ' WHERE COL_CODCOL IN ('+ stlColorantes.Text + ')';

      If (strCatalisador = 'S') and (not fEmptyStr(cdsConsulta.FieldByName('ADT_CODCAT').AsString)) Then
      Begin
        qryConsulta.Close;
        qryConsulta.SQL.Clear;
        qryConsulta.SQL.Text :=
          ' SELECT           ' +
          '   COL_CODITE,    ' +
          '   COL_CODCOL,    ' +
          '   COL_DESCRI,    ' +
          '   COL_PESESP,    ' +
          '   "N" AS CATALI  ' +
          ' FROM             ' +
          '   ADT_CADCOL     ' +
          ' WHERE COL_CODCOL IN ('+ stlColorantes.Text + ')' + ' ' +
          ' UNION ALL        ' +
          ' SELECT           ' +
          '   BAS_CODITE AS COL_CODITE,    ' +
          '   BAS_CODBAS AS COL_CODCOL,    ' +
          '   BAS_DESCRI AS COL_DESCRI,    ' +
          '   BAS_PESESP AS COL_PESESP,    ' +
          '   "S" AS CATALI  ' +
          ' FROM             ' +
          '   ADT_CADBAS     ' +
          ' WHERE BAS_CODBAS IN ('+ stlColorantes.Text + ')'+
          '   AND BAS_CODEMB = :CODEMB ';
        qryConsulta.ParamByName('CODEMB').AsString := cdsConsulta.FieldByName('ADT_CODEMB').AsString;
      End;

      cdsCadCol := TClientDataSetFactory.GetClientDataSet(qryConsulta);

      SetLength(arrBaixaPigmentos, dicColorantes.Chaves.Count);

      //Baixar em gramas, então converte para gramas
      for intCont := 1 to 20 do
      begin
        if fEmptyStr(arrFormul[intCont].strFormul) then
          Continue;

        if not cdsCadCol.Locate('COL_CODCOL', arrFormul[intCont].strFormul, []) then
          If cdsCadCol.FieldByName('CATALI').AsString = 'N' Then
            raise Exception.CreateFmt('O colorante %s não está cadastrado! Verificar!', [dicColorantes.Chaves[intCont]])
          Else
            raise Exception.CreateFmt('O catalisador %s não está cadastrado! Verificar!', [dicColorantes.Chaves[intCont]]);

        arrFormul[intCont].fltQtdbas := arrFormul[intCont].fltQtdbas * cdsCadCol.FieldByName('COL_PESESP').AsFloat;
        dicColorantes[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;
      end;

      for intCont := 0 to dicColorantes.Chaves.Count - 1 do
      begin
        if not cdsCadCol.Locate('COL_CODCOL', dicColorantes.Chaves[intCont], []) then
          If cdsCadCol.FieldByName('CATALI').AsString = 'N' Then
            raise Exception.CreateFmt('O colorante %s não está cadastrado! Verificar!', [dicColorantes.Chaves[intCont]])
          Else
            raise Exception.CreateFmt('O catalisador %s não está cadastrado! Verificar!', [dicColorantes.Chaves[intCont]]);

        stlItensTraMl.Add(cdsCadCol.FieldByName('COL_CODITE').AsString);
        arrBaixaPigmentos[intCont].strCodIte := cdsCadCol.FieldByName('COL_CODITE').AsString;
        arrBaixaPigmentos[intCont].fltQtdBaixa := dicColorantes[dicColorantes.Chaves[intCont]];

        If cdsCadCol.FieldByName('CATALI').AsString = 'N' Then
          arrBaixaPigmentos[intCont].strTipComp := 'C'
        Else
          arrBaixaPigmentos[intCont].strTipComp := 'CT';
      end;

      Result := True;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryConsulta) then FreeAndNil(qryConsulta);
    if Assigned(dicColorantes) then FreeAndNil(dicColorantes);
    if Assigned(stlColorantes) then FreeAndNil(stlColorantes);
    if Assigned(qryCadBas) then FreeAndNil(qryCadBas);
  End;
end;

function fConsultaAdvanceNova(Sender: TForm): String; stdcall;
var
  qryCadAdv: TUniQuery;
begin
  qryCadAdv := nil;
  Try
    Try
      qryCadAdv := fCriaQuery();
      Result := fConsultaAdvanceNovaInterna(Sender, qryCadAdv, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcGeral, False, Nil, Nil);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryCadAdv) then FreeAndNil(qryCadAdv);
  End;
end;

function fConsultaAdvanceNovaGeral(Sender: TForm): String; stdcall;
var
  qryCadAdv: TUniQuery;
begin
  qryCadAdv := nil;
  Try
    Try
      qryCadAdv := fCriaQuery();
      Result := fConsultaAdvanceNovaInterna(Sender, qryCadAdv, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), tpcGeral, False, Nil, Nil);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryCadAdv) then FreeAndNil(qryCadAdv);
  End;
end;

function fConsultaAdvanceNovaVenda(Sender: TForm; qryCadAdv: TUniQuery; strTabPre: String;
  blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;
begin
  Result := fConsultaAdvanceNovaInterna(Sender, qryCadAdv, strTabPre, tpcVenda,
    blnFaturamento, dicRetorno, sltItems);
end;

procedure pRetornaTabelaPrecoAdvanceNova(dicRetorno: TDicionario);
var
  formula: TFormulaAdvanceIndustrial;
  qryGen: TUniQuery;
  componente: TComponenteIndustrial;
  cdsGen: TUniClientDataSet;
  intContador: Integer;
  cdsCadCol: TUniClientDataSet;
  qryCadCol: TUniQuery;
  conf: IConfTinta;
begin
  conf := fGetConfTinta('ADT');
  formula := nil;
  qryGen := nil;
  qryCadCol := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text := fGetConsultaTinta('ADT').fGetSelect(True) + ' AND ADT_MD5KEY = :ITETIN ';
      qryGen.ParamByName('ITETIN').AsString := IfNull(dicRetorno['itetin'], '');
      cdsGen := TClientDataSetFactory.GetClientDataSet(qryGen);

      formula := TFormulaAdvanceIndustrial.Create(IfNull(dicRetorno['tabpre'], IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD'))),cdsGen);
      formula.ItemBase  := dicRetorno['itebas'];
      formula.UsaCatalisador := not fEmptyStr(cdsGen.FieldByName('ADT_CODCAT').AsString);

      formula.strCodCli := IfNull(dicRetorno['codcli'], '');
      formula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      formula.intPrzMed := IfNull(dicRetorno['przmed'], 0);

//      if formula.UsaCatalisador then
//      begin
//        componente := TComponenteIndustrial(formula.Add);
//        componente.CodigoComponente := cdsGen.FieldByName('ADT_CODCAT').AsString;
//        componente.Quantidade := cdsGen.FieldByName('ADT_QTDCAT').AsFloat;
//        componente.Tipo := tciCatalisador;
//      end;

      qryCadCol := fCriaQuery();
      qryCadCol.SQL.Text := 'SELECT COL_CODCOL, COL_PESESP FROM ADT_CADCOL';
      cdsCadCol := TClientDataSetFactory.GetClientDataSet(qryCadCol);

      For intContador := 1 To 20 Do
      Begin
        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Continue;

        if IfNull(dicRetorno['qtdb' + fStrZero(intContador, 2)], 0) <= 0 then
          Continue;

        if cdsCadCol.Locate('COL_CODCOL', dicRetorno['base' + fStrZero(intContador, 2)], []) then
          dicRetorno['qtdb' + fStrZero(intContador, 2)] := dicRetorno['qtdb' + fStrZero(intContador, 2)] / cdsCadCol.FieldByName('COL_PESESP').AsFloat
        Else If dicRetorno['base' + fStrZero(intContador, 2)] = cdsGen.FieldByName('ADT_CODCAT').AsString Then
          dicRetorno['qtdb' + fStrZero(intContador, 2)] := dicRetorno['qtdb' + fStrZero(intContador, 2)] / fPesoEspecificoCadBas(cdsGen.FieldByName('ADT_CODCAT').AsString, cdsGen.FieldByName('ADT_CODEMB').AsString);
      End;

      For intContador := 1 To 20 Do
      Begin
        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Continue;

        componente := TComponenteIndustrial(formula.Add);
        componente.CodigoComponente := dicRetorno['base' + fStrZero(intContador, 2)];
        componente.Quantidade := dicRetorno['qtdb' + fStrZero(intContador, 2)];

        If formula.UsaCatalisador And (componente.CodigoComponente = cdsGen.FieldByName('ADT_CODCAT').AsString) Then
          componente.Tipo := tciCatalisador
        Else
          componente.Tipo := tciColorante;
      End;

      dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');
      formula.CodigoEmbalagemBase := IfNull(dicRetorno['tipcor'], formula.CodigoEmbalagemBase);
      formula.blnCalculaUnitario  := False;
      formula.pRecalculaTabelas(dicRetorno);

      dicRetorno['precus'] := formula.PrecoCusto;
      dicRetorno['precu2'] := formula.PrecoCustoReal;

      dicRetorno['premed'] := formula.PrecoMedio;
      dicRetorno['impult'] := formula.ImpostosUltimaCompra;
      dicRetorno['preult'] := formula.PrecoUltimaCompra;
      dicRetorno['prctin'] := formula.PrecoCompraLiq;

      dicRetorno.AdicionarObjeto('tintaDeMaquina', formula.tintaDeMaquina);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(formula) then FreeAndNil(formula);
    if Assigned(qryGen) then FreeAndNil(qryGen);
    if Assigned(qryCadCol) then FreeAndNil(qryCadCol);
  End;
end;

function fPesoEspecificoCadBas(strCodBas, strCodEmb: String): Double;
var
  qryCadBas: TUniQuery;
Begin
  Try
    qryCadBas := fCriaQuery();
    With qryCadBas Do
    Begin
      Close;
      SQL.Clear;
      SQL.Text := ' SELECT BAS_PESESP ' +
                  '   FROM ADT_CADBAS ' +
                  '  WHERE BAS_CODBAS = :CODBAS ' +
                  '    AND BAS_CODEMB = :CODEMB ';
      ParamByName('CODBAS').AsString := strCodBas;
      ParamByName('CODEMB').AsString := strCodEmb;
      Open;
      Result := FieldByName('BAS_PESESP').AsFloat;
    End;
  Finally
    FreeAndNil(qryCadBas);
  End;
End;

{ TfrmConsultaCompAdvanceTintoSystem }

procedure TfrmConsultaCompAdvanceTintoSystem.pTarefaFormulacao(Sender: TObject);
var
  qryGen: TUniQuery;
  dicRetorno: TDicionario;
  strCodBas: string;
  strUniBas: string;
  strDesCor: string;
  fltPreCus: Double;
  fltUnitar: Double;
  tinta: IConsultaTinta;
  fltVolPro: Double;
  strEmbalagemOriginal: string;
  strNovaEmbalagem: string;
  strCatali: string;
begin
  qryGen := nil;
  dicRetorno := nil;
  Try
    Try
      If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
        Exit;

      tinta := TAdvanceTintoSystemConsulta.Create;

      qryGen := fCriaQuery(Self);
      qryGen.SQL.Text := tinta.fGetSelectAutoIncrem(qryConsulta.FieldByName('AUTOINCREM').AsString);

      dicRetorno := TDicionario.Create;

      fDigDadosTintometricos(TClientDataSetFactory.GetClientDataSet(qryGen),
        strTabPre,
        strCodBas,
        strUniBas,
        strDesCor,
        strEmbalagemOriginal,
        strNovaEmbalagem,
        strCatali,
        fltPreCus,
        fltUnitar,
        fltVolPro,
        dicRetorno);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
    if Assigned(dicRetorno) then FreeAndNil(dicRetorno);
  End;

end;

procedure TfrmConsultaCompAdvanceTintoSystem.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompAdvanceTintoSystem.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadAdtNovasFormulas', False);
end;

end.

