unit untFatMostraMargemTinta;

interface

uses
  Classes, Controls, Forms, untPaiSimples, DB, cxGridLevel, cxGridDBTableView, cxGrid, UniClientDataSet,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, untFuncFat, untDicionarioITintaDeMaquinaHelper,
  untITintaDeMaquina, SysUtils, Windows, Dialogs, untTintaDeMaquinaComponenteTipo, Graphics,
  cxLookAndFeels, cxLookAndFeelPainters, untcxGridDBTableViewHelper, cxNavigator, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient,
  System.Generics.Collections, untTypesMargem,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmFatMostraMargemTinta = class(TfrmPaiSimples)
    dbgDadosTintas: TcxGrid;
    dbgvDadosTintas: TcxGridDBTableView;
    dbglDadosTintas: TcxGridLevel;
    cdsDadosTintas: TUniClientDataSet;
    dtsDadosTintas: TDataSource;
    cdsDadosTintasDescricao: TStringField;
    cdsDadosTintasTipo: TStringField;
    cdsDadosTintasProduto: TStringField;
    cdsDadosTintasQuantidade: TFloatField;
    cdsDadosTintasPrecoVenda: TCurrencyField;
    cdsDadosTintasPrecoCusto: TCurrencyField;
    cdsDadosTintasPrecoCustoReal: TCurrencyField;
    cdsDadosTintasPrecoCustoMedio: TCurrencyField;
    cdsDadosTintasOutrosValores: TCurrencyField;
    cdsDadosTintasIcmsSaida: TCurrencyField;
    cdsDadosTintasImpostosFederais: TCurrencyField;
    cdsDadosTintasDespesasOperacionais: TCurrencyField;
    cdsDadosTintasMargem: TFloatField;
    cdsDadosTintasCODITE: TStringField;
    cxstylrpstryGrupo: TcxStyleRepository;
    cxstylGrupo: TcxStyle;
    cxstylFooter: TcxStyle;
    cdsDadosTintasMarkup: TFloatField;
    popGrid: TPopupMenu;
    ImprimirF4: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure cdsDadosTintasCalcFields(DataSet: TDataSet);
    procedure dbgvDadosTintasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ImprimirF4Click(Sender: TObject);
    procedure popGridPopup(Sender: TObject);
  private
    { Private declarations }
    fatVenda: TFatVenda;
    cdsDados: TUniClientDataSet;
    cdsItens: TUniClientDataSet;
    prcImprimirF4 : TprcImprimeF4;
    dicColunasF4 : TDictionary<String, Boolean>;
    procedure ProcessarTintasDeMaquina;
    procedure ConstruirDataSet;
    procedure ConstruirGrid;
    procedure Sumarizar(const strNomeCampo: String; const summaryKind: TcxSummaryKind; const strFormato: string;
      const blnFooter, blnGroup, blnGroupFooter: Boolean);
    procedure AdicionarTitna(const tintaDeMaquina: ITintaDeMaquina);
    function GetTipoAsString(tmctTipo: TTintaDeMaquinaComponenteTipo): string;
    function GetMargem(const fltPreVen, fltIcmsSaida, fltImpostosFederais,
      fltDespesasOperacionais, fltOutrosValores, fltPrecoCusto: Double; strMarMkp: String = ''): Double;
    procedure ProcessarMargens;
    procedure AjustarColunasVisiveis;
    procedure pCalculaUltimoPrecoCompraMaisImpostosVenda;
    procedure pGerarDicionarioColunas;
    function fUserFunction(const MethodName: string; var Params: Variant): Variant;
  public
    constructor Create(AOwner: TComponent; const fatVenda: TFatVenda; const cdsVenda, cdsItens: TUniClientDataSet; prcImprimir : TprcImprimeF4 = Nil); reintroduce;
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmFatMostraMargemTinta: TfrmFatMostraMargemTinta;

implementation

uses
  untFuncTinta, untDadosFechamentoDadosTinta, untConstantes, untFuncoesSimples,
  untFatVendasCalculadorWrapper;

{$R *.dfm}

{ TfrmFatMostraMargemTinta }

procedure TfrmFatMostraMargemTinta.AdicionarTitna(const tintaDeMaquina: ITintaDeMaquina);
  var
    intCont: Integer;
begin
  if not Assigned(tintaDeMaquina) then
    Exit;

  for intCont := 0 to tintaDeMaquina.Count - 1 do
  begin
    cdsDadosTintas.Append;
    cdsDadosTintas.FieldByName('Descricao').AsString := tintaDeMaquina.Descricao;
    cdsDadosTintas.FieldByName('Tipo').AsString := GetTipoAsString(tintaDeMaquina[intCont].Tipo);
    cdsDadosTintas.FieldByName('CODITE').AsString := tintaDeMaquina[intCont].CodIte;
    cdsDadosTintas.FieldByName('Produto').AsString := tintaDeMaquina[intCont].CodIte + ' - ' + tintaDeMaquina[intCont].Descricao;

    if tintaDeMaquina[intCont].Tipo = tmctEmbalagemAutomotiva then
      cdsDadosTintas.FieldByName('Quantidade').AsFloat := tintaDeMaquina[intCont].Quantidade
    else
      cdsDadosTintas.FieldByName('Quantidade').AsFloat := tintaDeMaquina[intCont].Quantidade * tintaDeMaquina.Quantidade;

    cdsDadosTintas.FieldByName('PrecoVenda').AsFloat := tintaDeMaquina[intCont].PrecoVenda * tintaDeMaquina.Quantidade;
    cdsDadosTintas.FieldByName('PrecoCusto').AsFloat := tintaDeMaquina[intCont].PrecoCusto * tintaDeMaquina.Quantidade;
    cdsDadosTintas.FieldByName('PrecoCustoReal').AsFloat := tintaDeMaquina[intCont].PrecoCustoReal * tintaDeMaquina.Quantidade;
    cdsDadosTintas.FieldByName('PrecoCustoMedio').AsFloat := tintaDeMaquina[intCont].PrecoMedio * tintaDeMaquina.Quantidade;
    cdsDadosTintas.FieldByName('OutrosValores').AsFloat := tintaDeMaquina[intCont].OutrosValores * tintaDeMaquina.Quantidade;
    cdsDadosTintas.FieldByName('IcmsSaida').AsFloat := tintaDeMaquina[intCont].IcmsSaida * tintaDeMaquina.Quantidade;
    cdsDadosTintas.FieldByName('ImpostosFederais').AsFloat := tintaDeMaquina[intCont].ImpostosFederais * tintaDeMaquina.Quantidade;
    cdsDadosTintas.FieldByName('DespesasOperacionais').AsFloat := tintaDeMaquina[intCont].DespesasOperacionais * tintaDeMaquina.Quantidade;
    cdsDadosTintas.FieldByName('UltimoPrecoCompraImpostos').AsFloat := tintaDeMaquina[intCont].UltimoPrecoCompraImpostos * tintaDeMaquina.Quantidade;

    cdsDadosTintas.Post;
  end;
end;

procedure TfrmFatMostraMargemTinta.pCalculaUltimoPrecoCompraMaisImpostosVenda;
begin
  With cdsDadosTintas Do
  Begin
    First;
    While Not Eof Do
    Begin
      Edit;
      FieldByName('UltimoPrecoCompraImpostos').AsFloat := FieldByName('UltimoPrecoCompraImpostos').AsFloat +
                                                          FieldByName('OutrosValores').AsFloat +
                                                          FieldByName('IcmsSaida').AsFloat +
                                                          FieldByName('ImpostosFederais').AsFloat +
                                                          FieldByName('DespesasOperacionais').AsFloat;
      Post;
      Next;
    End;
    First;
  End;
end;

procedure TfrmFatMostraMargemTinta.popGridPopup(Sender: TObject);
begin
  inherited;
  ImprimirF4.Enabled := Assigned(prcImprimirF4) And Assigned(cdsDadosTintas) And (cdsDadosTintas.Active) And (Not cdsDadosTintas.IsEmpty) And fVerificaAcessoSistema('IMPRF4', strLoginUsuarioLogado);
end;

procedure TfrmFatMostraMargemTinta.AjustarColunasVisiveis;
begin
  dbgvDadosTintas.Columns[dbgvDadosTintas.DataController.GetItemByFieldName('PrecoCustoMedio').Index].Visible := (Copy(fCfgSis('EXMAF4'),3,1)='S'); //PREÇO MÉDIO;
  dbgvDadosTintas.Columns[dbgvDadosTintas.DataController.GetItemByFieldName('UltimoPrecoCompraImpostos').Index].Visible := (Copy(fCfgSis('EXMAF4'),2,1)='S'); //CUSTO REAL
  dbgvDadosTintas.Columns[dbgvDadosTintas.DataController.GetItemByFieldName('Markup').Index].Visible := (fCfgSis('MARMKP') = '99');
end;

procedure TfrmFatMostraMargemTinta.cdsDadosTintasCalcFields(DataSet: TDataSet);

  procedure pCalcula(strCampo : String; strMarMkp: String);
  begin
    DataSet.FieldByName(strCampo).AsFloat := GetMargem(DataSet.FieldByName('PrecoVenda').AsFloat,
      DataSet.FieldByName('IcmsSaida').AsFloat,
      DataSet.FieldByName('ImpostosFederais').AsFloat,
      DataSet.FieldByName('DespesasOperacionais').AsFloat,
      DataSet.FieldByName('OutrosValores').AsFloat,
      DataSet.FieldByName('PrecoCusto').AsFloat,
      strMarMkp);
  end;

begin
  Try
    Try
      pCalcula('Margem', '');
      pCalcula('Markup', '2');
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

procedure TfrmFatMostraMargemTinta.ConstruirDataSet;
begin
  cdsDadosTintas.Close;
  cdsDadosTintas.Open;
end;

procedure TfrmFatMostraMargemTinta.ConstruirGrid;
var
  strFormato: string;
begin
  dbgvDadosTintas.ClearItems;
  dbgvDadosTintas.DataController.CreateAllItems(True);

  dbgvDadosTintas.GetColumnByFieldName('Descricao').GroupBy(0, False);
  dbgvDadosTintas.GetColumnByFieldName('Tipo').GroupBy(1, False);

  strFormato := Format('Total: %s 0.%s', [Trim(FormatSettings.CurrencyString), fStrZero(0, FormatSettings.CurrencyDecimals)]);
  Sumarizar('PrecoVenda', skSum, strFormato, True, False, True);
  Sumarizar('PrecoCusto', skSum, strFormato, True, False, True);
  Sumarizar('PrecoCustoReal', skSum, strFormato, True, False, True);
  Sumarizar('PrecoCustoMedio', skSum, strFormato, True, False, True);
  Sumarizar('OutrosValores', skSum, strFormato, True, False, True);
  Sumarizar('IcmsSaida', skSum, strFormato, True, False, True);
  Sumarizar('ImpostosFederais', skSum, strFormato, True, False, True);
  Sumarizar('DespesasOperacionais', skSum, strFormato, True, False, True);
  Sumarizar('UltimoPrecoCompraImpostos', skSum, strFormato, True, False, True);  
  Sumarizar('Margem', skCount, '0.00%', True, False, True);
  Sumarizar('Markup', skCount, '0.00%', True, False, True);

  dbgvDadosTintas.ViewData.Expand(True);
  dbgvDadosTintas.NavigatorButtons.First.Click;
  dbgvDadosTintas.ApplyBestFit();
end;

constructor TfrmFatMostraMargemTinta.Create(AOwner: TComponent; const fatVenda: TFatVenda; const cdsVenda, cdsItens: TUniClientDataSet; prcImprimir : TprcImprimeF4 = Nil);
begin
  inherited Create(AOwner);
  Self.fatVenda := fatVenda;

  Self.cdsDados := fCriaClientDatset(cdsVenda, False, Nil);

  Self.cdsItens := TUniClientDataSet.Create(nil);
  Self.cdsItens.Data := cdsItens.Data;

  Self.prcImprimirF4 := prcImprimir;

  dicColunasF4 := TDictionary<String, Boolean>.Create;
end;

procedure TfrmFatMostraMargemTinta.dbgvDadosTintasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: begin
                 Close;
               end;
  end;
end;

destructor TfrmFatMostraMargemTinta.Destroy;
begin
  if Assigned(cdsDados) then FreeAndNil(cdsDados);
  if Assigned(cdsItens) then FreeAndNil(cdsItens);
  inherited;
end;

procedure TfrmFatMostraMargemTinta.FormShow(Sender: TObject);
begin
  ProcessarTintasDeMaquina;
  Self.WindowState := wsNormal;
  Self.WindowState := wsMaximized;
  AjustarColunasVisiveis;
  pSetFocus(dbgDadosTintas);
end;

function TfrmFatMostraMargemTinta.fUserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin
  If (MethodName = AnsiUpperCase('GetMargem')) Then
  Begin
    Result := GetMargem(Params[0], Params[1], Params[2], Params[3], Params[4], Params[5], Params[6]);
  End;
end;

function TfrmFatMostraMargemTinta.GetMargem(const fltPreVen, fltIcmsSaida, fltImpostosFederais,
  fltDespesasOperacionais, fltOutrosValores, fltPrecoCusto: Double; strMarMkp: String = ''): Double;
var
  fltMargem: Double;
  fltIcmsai: Double;
  fltImpFed: Double;
  fltDesOpe: Double;
begin
  Result    := 0.0;
  fltMargem := 0.0;

  If fEmptyStr(strMarMkp) Then
    strMarMkp := fCfgSis('MARMKP');

  Try
    Try
      if fltPreVen > 0 then
      begin
        fltIcmsai := 100 * (fltIcmsSaida / fltPreVen);
        fltImpFed := 100 * (fltImpostosFederais / fltPreVen);
        fltDesOpe := 100 * (fltDespesasOperacionais / fltPreVen);

        fltMargem := fCalculaPrecoVenda(2,
          fltPrecoCusto + fltOutrosValores,
          fltPreVen,
          0,
          fltIcmsai,
          fltImpFed,
          fltDesOpe,
          0,
          strMarMkp,
          fCfgSis('PCMPRO'),
          fCfgSis('DECUNI', varInteger));
      end;

      Result := fltMargem;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

function TfrmFatMostraMargemTinta.GetTipoAsString(tmctTipo: TTintaDeMaquinaComponenteTipo): string;
begin
  case tmctTipo of
    tmctColoranteImobiliario: Result := 'Colorantes';
    tmctBaseAutomotiva: Result := 'Bases Automotivas';
    tmctEmbalagemAutomotiva: Result := 'Embalagens Automotivas';
    tmctBaseImobiliaria: Result := 'Bases Imobiliárias';
  end;
end;

procedure TfrmFatMostraMargemTinta.ImprimirF4Click(Sender: TObject);
  Var
    stlFunctions : TStringList;
begin
  inherited;
  stlFunctions := TStringList.Create;
  stlFunctions.Add('function GetMargem(const fltPreVen, fltIcmsSaida, fltImpostosFederais, fltDespesasOperacionais, fltOutrosValores, fltPrecoCusto: Double; strMarMkp: String = ''): Double;');
  pGerarDicionarioColunas;
  prcImprimirF4(cdsDadosTintas, dicColunasF4, fUserFunction, True, stlFunctions);
  FreeAndNil(stlFunctions);
end;

procedure TfrmFatMostraMargemTinta.pGerarDicionarioColunas;
  Var
    intCnt : Integer;
    strNomeCol : String;
begin
  dicColunasF4.Clear;

  For intCnt := 0 To dbgvDadosTintas.ColumnCount -1 Do
  Begin
    If (Not fEmptyStr(dbgvDadosTintas.Columns[intCnt].DataBinding.FieldName)) Then
    Begin
      strNomeCol := 'rll' + dbgvDadosTintas.Columns[intCnt].DataBinding.FieldName;
      dicColunasF4.AddOrSetValue(strNomeCol, dbgvDadosTintas.Columns[intCnt].Visible);
    End;
  End;
end;

procedure TfrmFatMostraMargemTinta.ProcessarMargens;

  Var
    intNivel: Integer;
    intLinha: Integer;

  procedure pGroupSummary(strCampo, strMarMkp: String);
  begin
    dbgvDadosTintas.GroupSummaryValuesByFieldName[intLinha, intNivel, strCampo] := GetMargem(
      IfNull(dbgvDadosTintas.GroupSummaryValuesByFieldName[intLinha, intNivel, 'PrecoVenda'], 0),
      IfNull(dbgvDadosTintas.GroupSummaryValuesByFieldName[intLinha, intNivel, 'IcmsSaida'], 0),
      IfNull(dbgvDadosTintas.GroupSummaryValuesByFieldName[intLinha, intNivel, 'ImpostosFederais'], 0),
      IfNull(dbgvDadosTintas.GroupSummaryValuesByFieldName[intLinha, intNivel, 'DespesasOperacionais'], 0),
      IfNull(dbgvDadosTintas.GroupSummaryValuesByFieldName[intLinha, intNivel, 'OutrosValores'], 0),
      IfNull(dbgvDadosTintas.GroupSummaryValuesByFieldName[intLinha, intNivel, 'PrecoCusto'], 0),
      strMarMkp);
  end;

  procedure pFooterSummary(strCampo, strMarMkp: String);
  begin
    dbgvDadosTintas.FooterSummaryValuesByFieldName[strCampo] := GetMargem(
      IfNull(dbgvDadosTintas.FooterSummaryValuesByFieldName['PrecoVenda'], 0),
      IfNull(dbgvDadosTintas.FooterSummaryValuesByFieldName['IcmsSaida'], 0),
      IfNull(dbgvDadosTintas.FooterSummaryValuesByFieldName['ImpostosFederais'], 0),
      IfNull(dbgvDadosTintas.FooterSummaryValuesByFieldName['DespesasOperacionais'], 0),
      IfNull(dbgvDadosTintas.FooterSummaryValuesByFieldName['OutrosValores'], 0),
      IfNull(dbgvDadosTintas.FooterSummaryValuesByFieldName['PrecoCusto'], 0),
      strMarMkp);
  end;

begin
  for intLinha := 0 to dbgvDadosTintas.DataController.RowCount - 1 do
  begin
    intNivel := dbgvDadosTintas.DataController.GetRowInfo(intLinha).Level;
    pGroupSummary('Margem', '');
    pGroupSummary('Markup', '2');
  end;

  pFooterSummary('Margem', '');
  pFooterSummary('Markup', '2');
end;

procedure TfrmFatMostraMargemTinta.ProcessarTintasDeMaquina;
var
  tintaDeMaquina: ITintaDeMaquina;
  fatVendasCalculadorWrapper: TFatVendasCalculadorWrapper;
  strCodEmpTinta: String;
begin
  fatVendasCalculadorWrapper := nil;
  Try
    Try
      ConstruirDataSet;
      cdsDados.First;
      fatVendasCalculadorWrapper := TFatVendasCalculadorWrapper.Create(fatVenda);

      while not cdsDados.Eof do
      begin
        cdsItens.RecNo := cdsDados.RecNo;

        Try
          If Not fEmptyStr(cdsDados.FieldByName('ITE_EMPPRD').AsString) Then
            strCodEmpTinta := cdsDados.FieldByName('ITE_EMPPRD').AsString
          Else If Not fEmptyStr(cdsDados.FieldByName('ITE_EMPITE').AsString) Then
            strCodEmpTinta := cdsDados.FieldByName('ITE_EMPITE').AsString;

          If Assigned(fatVenda) Then
            If fatVenda.fEhDocumentoAbastecimentoPorDepositoUsandoPrecoLocal() Then
              strCodEmpTinta := VS_strCodEmp;

          pSetaEmpresaLogadaTinta(strCodEmpTinta);

          tintaDeMaquina := fGetITintadeMaquina(TDadosFechamentoDadosTinta.Create(cdsDados), fatVendasCalculadorWrapper);
          RecalcularTintadeMaquina(tintaDeMaquina, cdsItens.FieldByName('ITE_UNITAR').AsFloat, cdsItens.FieldByName('ITE_PRECUS').AsFloat);
          AdicionarTitna(tintaDeMaquina);

        Finally
          pSetaEmpresaLogadaTinta(VS_strCodEmp);
        end;

        cdsDados.Next;
      end;

      pCalculaUltimoPrecoCompraMaisImpostosVenda;
      ConstruirGrid;
      pSetFocus(dbgDadosTintas);
      ProcessarMargens;
      dbgvDadosTintas.ApplyBestFit();
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(fatVendasCalculadorWrapper) then FreeAndNil(fatVendasCalculadorWrapper);
  End;
end;

procedure TfrmFatMostraMargemTinta.Sumarizar(const strNomeCampo: String; const summaryKind: TcxSummaryKind; const strFormato: string;
  const blnFooter, blnGroup, blnGroupFooter: Boolean);
begin
  if blnFooter then
  begin
    dbgvDadosTintas.Columns[dbgvDadosTintas.DataController.GetItemByFieldName(strNomeCampo).Index].Summary.FooterKind := summaryKind;
    dbgvDadosTintas.Columns[dbgvDadosTintas.DataController.GetItemByFieldName(strNomeCampo).Index].Summary.FooterFormat := strFormato;
  end;

  if blnGroup then
  begin
    dbgvDadosTintas.Columns[dbgvDadosTintas.DataController.GetItemByFieldName(strNomeCampo).Index].Summary.GroupKind := summaryKind;
    dbgvDadosTintas.Columns[dbgvDadosTintas.DataController.GetItemByFieldName(strNomeCampo).Index].Summary.GroupFormat:= strFormato;
  end;

  if blnGroupFooter then
  begin
    dbgvDadosTintas.Columns[dbgvDadosTintas.DataController.GetItemByFieldName(strNomeCampo).Index].Summary.GroupFooterKind := summaryKind;
    dbgvDadosTintas.Columns[dbgvDadosTintas.DataController.GetItemByFieldName(strNomeCampo).Index].Summary.GroupFooterFormat := strFormato;
  end;
end;

end.
