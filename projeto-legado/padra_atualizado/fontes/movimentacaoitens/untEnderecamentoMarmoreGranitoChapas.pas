unit untEnderecamentoMarmoreGranitoChapas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid,
  cxGridBandedTableView, cxGridDBBandedTableView, cxCurrencyEdit, Math, MemDS,
  DBAccess, Uni, strUtils, untTEnderecamentoMarmoreGranito, cxButtonEdit,
  System.ImageList, Vcl.ImgList, cxImageList, cxTextEdit, cxSpinEdit;

type
  TfrmEnderecamentoMarmoreGranitoChapas = class(TfrmPai)
    dtsDados: TDataSource;
    cxgDados: TcxGridDBTableViewCitel;
    cxlDados: TcxGridLevel;
    cxDados: TcxGridCitel;
    Panel1: TPanel;
    cxgDBDados: TcxGridDBBandedTableView;
    cxgDBDadosCHAPA: TcxGridDBBandedColumn;
    cxgDBDadosMEDIDA_BRUTA_LARGURA: TcxGridDBBandedColumn;
    cxgDBDadosMEDIDA_BRUTA_ALTURA: TcxGridDBBandedColumn;
    cxgDBDadosMEDIDA_LIQUIDA_LARGURA: TcxGridDBBandedColumn;
    cxgDBDadosMEDIDA_LIQUIDA_ALTURA: TcxGridDBBandedColumn;
    cxgDBDadosESPESSURA: TcxGridDBBandedColumn;
    cxgDBDadosPRECO_M2: TcxGridDBBandedColumn;
    cxgDBDadosQTD_M2_LIQUIDO: TcxGridDBBandedColumn;
    cxgDBDadosVALOR_TOTAL_M2: TcxGridDBBandedColumn;
    cxgDBDadosETIQUETA: TcxGridDBBandedColumn;
    cxgDBDadosLOTE: TcxGridDBBandedColumn;
    Label1: TLabel;
    Label2: TLabel;
    lblCapQtdChapas: TLabel;
    lblCapQtdEntrada: TLabel;
    lblLote: TLabel;
    lblProduto: TLabel;
    lblQtdChapas: TLabel;
    lblQtdEntrada: TLabel;
    btnConfirma: TBitBtnLocked;
    cxgDBDadosPERDA: TcxGridDBBandedColumn;
    pnlAcao: TPanel;
    Label5: TLabel;
    btnReplicaMedidas: TBitBtnLocked;
    cxgDBDadosCOMPLEMENTO: TcxGridDBBandedColumn;
    cxgDBDadosLOTE_DIVIDO: TcxGridDBBandedColumn;
    cxgDBDadosESTPER: TcxGridDBBandedColumn;
    pnlLegendaLotePrincipal: TPanel;
    shpLotePrincipal: TShape;
    lblLotePrincipal: TLabel;
    cxgDBDadosPRECO_ENTREGA_M2: TcxGridDBBandedColumn;
    cxgDBDadosVALOR_TOTAL_ENTREGA_M2: TcxGridDBBandedColumn;
    procedure cxgDBDadosEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure cxgDBDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure cxgDBDadosETIQUETAPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConfirmaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function fPodeInserirOuDeletar: Boolean;

    function fGetQtdChapasJadefinidas: Integer;

    procedure cxgDBDadosCHAPAPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnReplicaMedidasClick(Sender: TObject);
    procedure cxgDBDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgDBDadosCanFocusRecord(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; var AAllow: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    qryConsulta: TUniQuery;
    intDeqTem: Integer;
    FVariacaoPermitida: Double;
    function fFinaliza: Boolean;
    function fValidaTextoDosLotes: Boolean;

    function fValidaQuantidadesParaGravacao: Boolean;

    function fTrataImpressao: boolean;
    function fTrataGravacaoDosLotes: Boolean;

    function fTodosOsCamposPreenchidos: Boolean;
    function fPrecoPreenchido(var strErro: string): Boolean;
    function fEspessuraPreenchida(var strErro: string): Boolean;
    function fMargemBrutaPreenchida(var strErro: string): Boolean;
    function fMargemLiquidaPreenchida(var strErro: string): Boolean;
    function fQuantidadeTotalCalculaIgualAoDoEnderecamento: Boolean;
    function fQuantidadeTotalDeChapasIgualAoInformado: Boolean;
    procedure pDelete;

    { Private declarations }
  private
    Const
      SOMA_PRECO_M2: integer = 0;
      SOMA_QTD_M2_LIQ: integer = 1;
      SOMA_VALORTOTAL_M2: Integer = 2;
      SOMA_QTD_CHAPA: Integer = 3;
      SOMA_PERDA: Integer = 4;

      COR_LOTE_PRINCIPAL: Integer = $004080FF;

  public
    strChaveLoteTemporario: String;
    intQtdChapas: integer;
    fltPercPerda: Double;
    objEnderecamentoMarmoreGranito: TEnderecamentoMarmoreGranito;
    blnRestaura: Boolean;
    blnDefinicoesCompletas: Boolean;
    blnDividindoChapa: Boolean;
    { Public declarations }
  end;

var
  frmEnderecamentoMarmoreGranitoChapas: TfrmEnderecamentoMarmoreGranitoChapas;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmEnderecamentoMarmoreGranitoChapas.btnReplicaMedidasClick(
  Sender: TObject);
begin
  inherited;

  objEnderecamentoMarmoreGranito.pReplicarMedidas;
end;

procedure TfrmEnderecamentoMarmoreGranitoChapas.btnConfirmaClick(
  Sender: TObject);
begin
  inherited;
  blnDefinicoesCompletas := False;
  If fFinaliza Then
  begin
    blnDefinicoesCompletas := True;
    Close;
  End;

end;

procedure TfrmEnderecamentoMarmoreGranitoChapas.btnConfirmaKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
    btnConfirma.Click;

end;

procedure TfrmEnderecamentoMarmoreGranitoChapas.btnSairClick(Sender: TObject);
begin
  blnRestaura := True;
  inherited;

end;

procedure TfrmEnderecamentoMarmoreGranitoChapas.cxgDBDadosCanFocusRecord(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
begin
  inherited;
  cxgDBDadosCOMPLEMENTO.Options.Editing := not(VarToStr(Sender.DataController.Values[ARecord.RecordIndex, cxgDBDadosLOTE_DIVIDO.Index]) = 'S');
end;

procedure TfrmEnderecamentoMarmoreGranitoChapas.cxgDBDadosCHAPAPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  Var
    blnPrincipal: boolean;
begin
  inherited;
  blnPrincipal := False;
  if blnDividindoChapa then
    blnPrincipal := cxgDados.DataController.DataSet.FieldByName('LOTE_DIVIDO').AsString = 'S';

  If DisplayValue = '' Then
    DisplayValue := 0;

  If (DisplayValue < 1) Then
  begin
    if blnDividindoChapa then
    begin
      if blnPrincipal then
        DisplayValue := 0
      else begin
        fMensagem('Atenção','Somente é permitido zerar a quantidade do lote principal. '
                            +slineBreak+'Se deseja excluir um lote que foi inserido indevidamente, pressione o botão "Delete"',['&Ok']);
        abort;
      end;
    end
    else
      DisplayValue := 1;
  end;
end;

procedure TfrmEnderecamentoMarmoreGranitoChapas.cxgDBDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If blnDividindoChapa Then
  begin
    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgDBDadosLOTE_DIVIDO.Index]) = 'S' Then
    Begin
      ACAnvas.Brush.Color := COR_LOTE_PRINCIPAL;
      ACAnvas.Font.Color := clBlack;
    End;
  end;
end;

procedure TfrmEnderecamentoMarmoreGranitoChapas.cxgDBDadosEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
var
  I: Integer;
begin
  if Key = VK_RETURN then
  begin
    I := 0;
    repeat
    begin
      inc(I);
      cxgDBDados.Controller.FocusNextCell(True);
    end
    until
      (cxgDBDados.Controller.FocusedColumn.Options.Editing or (I > cxgDBDados.VisibleColumnCount));
    Key := 0;
  end;
  If cxgDBDados.Controller.FocusedColumn = cxgDBDadosLOTE Then
  Begin
    cxgDBDados.NavigatorButtons.Next.Click;
    cxgDBDadosMEDIDA_BRUTA_LARGURA.Focused := True;
  End
end;

procedure TfrmEnderecamentoMarmoreGranitoChapas.cxgDBDadosETIQUETAPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  var strFiltroInjetado: String;
begin
  inherited;

  If fPergunta('Deseja imprimir as etiquetas da(s) chapa(s)?') then
  Begin
    // If Not objEnderecamentoMarmoreGranito.fRegistroGravadoLotMar Then --> FORÇA ATUALIZAÇÃO
      objEnderecamentoMarmoreGranito.fGravaRegistroChapa;

    strFiltroInjetado := '';
    strFiltroInjetado := ' AND LOTMAR.LOT_NUMLOT = "' + dtsDados.DataSet.FieldByName('LOTE').AsString + IIF(dtsDados.DataSet.FieldByName('COMPLEMENTO').AsString <> '', ' ' + dtsDados.DataSet.FieldByName('COMPLEMENTO').AsString, '') + '"' +
                         ' AND LOTMAR.LOT_CODITE = "' + dtsDados.DataSet.FieldByName('CODITE').AsString + '"';
    objEnderecamentoMarmoreGranito.pImprimeEtiquetas(strFiltroInjetado)
  End;

end;

procedure TfrmEnderecamentoMarmoreGranitoChapas.cxgDBDadosKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
var
  I: Integer;
begin
  if Key = VK_RETURN then
  begin
    I := 0;
    repeat
    begin
      inc(I);
      cxgDBDados.Controller.FocusNextCell(True);
    end
    until
      (cxgDBDados.Controller.FocusedColumn.Options.Editing or (I > cxgDBDados.VisibleColumnCount));
    Key := 0;

    If cxgDBDados.Controller.FocusedColumn = cxgDBDadosLOTE Then
    Begin
      cxgDBDados.NavigatorButtons.Next.Click;
      cxgDBDadosMEDIDA_BRUTA_LARGURA.Focused := True;
    End;

  end;

end;

function TfrmEnderecamentoMarmoreGranitoChapas.fFinaliza: Boolean;
begin
  Result := False;
  If fTodosOsCamposPreenchidos Then
    If fValidaQuantidadesParaGravacao Then
      If not fValidaTextoDosLotes Then
         Exit
      Else If fTrataGravacaoDosLotes Then
          If fTrataImpressao then
            Result := True;

end;


function TfrmEnderecamentoMarmoreGranitoChapas.fValidaTextoDosLotes: Boolean;
var strLotesInvalidos: string;
    strLoteFinal: String;
Begin
  dtsDados.DataSet.First;
  strLotesInvalidos := '';
  While not dtsDados.DataSet.Eof Do
  Begin
    strLoteFinal := dtsDados.DataSet.FieldByName('LOTE').AsString +
                    IIf(dtsDados.DataSet.FieldByName('COMPLEMENTO').AsString <> '', ' ' + dtsDados.DataSet.FieldByName('COMPLEMENTO').AsString, '');
    If Length(strLoteFinal) > objEnderecamentoMarmoreGranito.sizeFieldNumLot Then
      strLotesInvalidos := strLotesInvalidos +  strLoteFinal + ',';
    dtsDados.DataSet.Next;
  End;

  strLotesInvalidos :=  Copy(strLotesInvalidos, 1, Length(strLotesInvalidos) -1);
  strLotesInvalidos:= StringReplace(strLotesInvalidos, ',', #$A#$D, []);

  Result := strLotesInvalidos = '';
  If Not Result Then
  begin
    pMensagemOk('Os numeros dos lotes a seguir [' + strLotesInvalidos + ']' + #$A#$D + ' tem mais que '+IntToStr(objEnderecamentoMarmoreGranito.sizeFieldNumLot)+' caracteres , por favor trocar o Número do Lote!');
    objEnderecamentoMarmoreGranito.fRedefineTextoDoLote;
    Result := False;
  End;

{}
End;

procedure TfrmEnderecamentoMarmoreGranitoChapas.pDelete;
begin

  If Not (dtsDados.DataSet.State = dsEdit) Then
  Begin
    If blnDividindoChapa Then
    begin
      If dtsDados.DataSet.FieldByName('LOTE_DIVIDO').AsString = 'S' Then
      Begin
        pMensagemOk('Este lote não pode ser excluído! Pois é o que esta sendo dividido!');
        Exit;
      End;
    End;
    objEnderecamentoMarmoreGranito.pDelete;
  End;

end;

function TfrmEnderecamentoMarmoreGranitoChapas.fValidaQuantidadesParaGravacao: Boolean;
begin
  Result := False;
  If fQuantidadeTotalCalculaIgualAoDoEnderecamento Then
    If fQuantidadeTotalDeChapasIgualAoInformado Then
      Result := True;

End;


function TfrmEnderecamentoMarmoreGranitoChapas.fMargemLiquidaPreenchida(var strErro: string): Boolean;
Begin
  strErro := '';
  If dtsDados.DataSet.FieldByName('MEDIDA_LIQUIDA_LARGURA').AsFloat = 0 Then
    strErro := 'Margem líquida - Largura não foi preenchida';
  If dtsDados.DataSet.FieldByName('MEDIDA_LIQUIDA_ALTURA').AsFloat = 0 Then
    strErro := 'Margem líquida - Altura não foi preenchida';

  Result := strErro = '';
End;

procedure TfrmEnderecamentoMarmoreGranitoChapas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Not objEnderecamentoMarmoreGranito.blnDividindoChapa Then
    objEnderecamentoMarmoreGranito.finsereLotesNaTemporaria
end;

procedure TfrmEnderecamentoMarmoreGranitoChapas.FormCreate(Sender: TObject);
begin
  inherited;
  FVariacaoPermitida := fCfgSis('DCHVAR', varDouble);

  blnDividindoChapa := False;
  qryConsulta := fCriaQuery;
  blnDefinicoesCompletas := False;
  pnlAcao.Visible := false;
  btnReplicaMedidas.Visible := True;
  intDeqTem := fCfgSis('DEQTEM', varInteger) * -1;

  cxgDBDadosVALOR_TOTAL_ENTREGA_M2.Visible := fCfgSis('MARENT', varBoolean);
  cxgDBDadosPRECO_ENTREGA_M2.Visible := fCfgSis('MARENT', varBoolean);

  cxgDBDadosPERDA.Visible := True;
  cxgDBDados.DataController.Summary.FooterSummaryItems.Add(cxgDBDadosCHAPA, spFooter, skSum, '');         //3
  cxgDBDados.DataController.Summary.FooterSummaryItems.Add(cxgDBDadosPERDA, spFooter, skSum, '#0.000');   //4
  If fCfgSis('CTRLCH', varString) = '2'  Then
  Begin
    cxgDBDadosCHAPA.Properties.OnValidate := cxgDBDadosCHAPAPropertiesValidate;
    cxgDBDadosCHAPA.Caption := 'Qtd. Chapas';
    cxgDBDadosCHAPA.Options.Editing := True;
    pnlAcao.Visible := True;
    btnReplicaMedidas.Visible := False;
    cxgDBDadosCOMPLEMENTO.Visible := True;
    cxgDBDadosESTPER.Visible := False;
  End
  else begin
    cxgDBDadosESTPER.Visible := Not blnDividindoChapa;
  end;


end;

procedure TfrmEnderecamentoMarmoreGranitoChapas.FormDestroy(Sender: TObject);
begin
  inherited;
  freeAndNil(qryConsulta)
end;

procedure TfrmEnderecamentoMarmoreGranitoChapas.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10: btnConfirma.Click;
    VK_F5: btnReplicaMedidas.Click;
    VK_INSERT: If fPodeInserirOuDeletar Then
                 objEnderecamentoMarmoreGranito.pInsereChapa(fGetQtdChapasJadefinidas);
    VK_DELETE: If fPodeInserirOuDeletar Then
                 pDelete;
    VK_ESCAPE: Close;
  End;

end;


function TfrmEnderecamentoMarmoreGranitoChapas.fPodeInserirOuDeletar: Boolean;
begin
  result := (objEnderecamentoMarmoreGranito.controleEstoqueChapa = cecVariasChapasPorLote);
  If not result Then
    result := blnDividindoChapa;
End;


function TfrmEnderecamentoMarmoreGranitoChapas.fGetQtdChapasJadefinidas: Integer;
begin
  Result := 0;
  If cxgDBDados.dataController.Summary.FooterSummaryValues[3] <> null Then
    Result := cxgDBDados.dataController.Summary.FooterSummaryValues[3];
End;

procedure TfrmEnderecamentoMarmoreGranitoChapas.FormShow(Sender: TObject);
begin
  inherited;
  blnRestaura := false;
  pSetFocus(cxDados);
  if fCfgSis('CTRLCH', varString) <> '2'  Then
    cxgDBDadosCHAPA.Properties.OnValidate := nil;
  pnlAcao.Visible := fPodeInserirOuDeletar;
  cxgDBDadosESTPER.Visible := Not blnDividindoChapa;

  if blnDividindoChapa then
  begin
    shpLotePrincipal.Brush.Color := COR_LOTE_PRINCIPAL;
    pnlLegendaLotePrincipal.Visible := blnDividindoChapa;
  end;

end;

function TfrmEnderecamentoMarmoreGranitoChapas.fMargemBrutaPreenchida(var strErro: string): Boolean;
Begin
  strErro := '';
  If dtsDados.DataSet.FieldByName('MEDIDA_LIQUIDA_LARGURA').AsFloat = 0 Then
    strErro := 'Margem líquida - Largura não foi preenchida';
  If dtsDados.DataSet.FieldByName('MEDIDA_LIQUIDA_ALTURA').AsFloat = 0 Then
    strErro := 'Margem líquida - Altura não foi preenchida';

  Result := strErro = '';
End;

function TfrmEnderecamentoMarmoreGranitoChapas.fEspessuraPreenchida(var strErro: string): Boolean;
Begin
  strErro := '';
  If dtsDados.DataSet.FieldByName('ESPESSURA').AsFloat = 0 Then
    strErro := 'Espessura(cm) não foi preenchida';

  Result := strErro = '';
End;

function TfrmEnderecamentoMarmoreGranitoChapas.fPrecoPreenchido(var strErro: string): Boolean;
Begin
  strErro := '';
  If dtsDados.DataSet.FieldByName('PRECO_M2').AsFloat = 0 Then
    strErro := 'Preço não foi preenchido';
  Result := strErro = '';
End;

function TfrmEnderecamentoMarmoreGranitoChapas.fTodosOsCamposPreenchidos: Boolean;
var strErroCompleto, strErro: String;
begin
  strErroCompleto := '';
  Try
    dtsDados.DataSet.First;
    while not dtsDados.DataSet.Eof do
    begin
      fMargemLiquidaPreenchida(strErro);
      strErroCompleto := strErroCompleto + strErro + IIf(strErro <> '', #$A#$D, '');
      fMargemBrutaPreenchida(strErro);
      strErroCompleto := strErroCompleto + strErro + IIf(strErro <> '', #$A#$D, '');
      fEspessuraPreenchida(strErro);
      strErroCompleto := strErroCompleto + strErro + IIf(strErro <> '', #$A#$D, '');
      fPrecoPreenchido(strErro);
      strErroCompleto := strErroCompleto + strErro + IIf(strErro <> '', #$A#$D, '');

      If strErroCompleto <> '' then
        Break;
      dtsDados.DataSet.Next;
    end;
  Finally
    Result := strErroCompleto = '';
    If Not Result Then
      fMensagem('Atenção!', 'Para confirmar é preciso finalizar digitação dos dados de todas as chapas!' + #$A#$D + strErroCompleto, ['&Ok']);
  end;
end;

function TfrmEnderecamentoMarmoreGranitoChapas.fQuantidadeTotalCalculaIgualAoDoEnderecamento: Boolean;
var
  fltTotalCalculado: Double;
begin
  fltTotalCalculado := cxgDBDados.dataController.Summary.FooterSummaryValues[SOMA_QTD_M2_LIQ];
  fltTotalCalculado := fltTotalCalculado + cxgDBDados.dataController.Summary.FooterSummaryValues[SOMA_PERDA];

  //Result := RoundTo(fltTotalCalculado, intDeqTem) = RoundTo(StrToFloat(lblQtdEntrada.Caption), intDeqTem);
  Result := RoundTo(ABS(RoundTo(fltTotalCalculado, intDeqTem) - RoundTo(StrToFloat(lblQtdEntrada.Caption), intDeqTem)), -6) <= FVariacaoPermitida;

  If Not Result Then
    fMensagem('Atenção!', 'A somatória da quantidade de m2 líquido ' +
                          IIf(objEnderecamentoMarmoreGranito.controleEstoqueChapa = cecVariasChapasPorLote, ' + Qtd. M² Perda ' ,'') +
                          '(' + FormatFloat(fMskDigitos(abs(intDeqTem)), fltTotalCalculado) + ') '+
                          'está divergente da quantidade da entrada (' + lblQtdEntrada.Caption + '). ' +
                          'Realize o ajuste na quantidade para continuar. ', ['&Ok']);
End;

function TfrmEnderecamentoMarmoreGranitoChapas.fQuantidadeTotalDeChapasIgualAoInformado: Boolean;
var intQtdChapasDef: Integer;
begin
  If blnDividindoChapa Then
    Exit(True);

  Result := True;
  If objEnderecamentoMarmoreGranito.controleEstoqueChapa <> cecVariasChapasPorLote Then
    Exit;

  intQtdChapasDef := cxgDBDados.dataController.Summary.FooterSummaryValues[SOMA_QTD_CHAPA];

  Result := intQtdChapasDef = intQtdChapas;

  If Not Result Then
    fMensagem('Atenção!', 'A quantidade de chapas difere das quantidades de chapas informadas previamente! ' +
                          'Qtd. Chapas Informadas('+IntToStr(intQtdChapasDef)+')' +
                          'Qtd. Chapas necessária('+IntToStr(intQtdChapas)+')', ['&Ok']);

end;

function TfrmEnderecamentoMarmoreGranitoChapas.fTrataImpressao: boolean;
var strFiltroInjetado: String;
begin
   Result := True;
   Try
     If fPergunta('Deseja imprimir as etiquetas da(s) chapa(s)?') then
     Begin
       strFiltroInjetado := '';
       strFiltroInjetado := ' AND LOTMAR.LOT_LOTBAS = "' + dtsDados.DataSet.FieldByName('LOTE_BASE').AsString + '"' +
                            ' AND LOTMAR.LOT_CODITE = "' + dtsDados.DataSet.FieldByName('CODITE').AsString + '"';
       objEnderecamentoMarmoreGranito.pImprimeEtiquetas(strFiltroInjetado);
     End;
   Except
     Result := False;
   End;

End;


function TfrmEnderecamentoMarmoreGranitoChapas.fTrataGravacaoDosLotes: boolean;
var strCodIteUsando: String;
begin
  strCodIteUsando:= '';
  If objEnderecamentoMarmoreGranito.fLoteJaCadastrado Then
  Begin
    fMensagem('Atenção!', 'Este(s) lote(s) já esta(ão) cadastrado(s)!', ['&Ok']);
    Close;
    Exit(False);
  End;

  Result := objEnderecamentoMarmoreGranito.fInsereLotesNaTemporaria;


End;


end.
