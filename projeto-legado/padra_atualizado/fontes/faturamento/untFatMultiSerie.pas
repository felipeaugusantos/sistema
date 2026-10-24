unit untFatMultiSerie;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxGridCitel, Datasnap.DBClient,
  System.Math, Uni, UniClientDataSet, cxCheckBox, cxButtons;

type
  TfrmFatMultiSerie = class(TfrmPai)
    cxgMultiSerieTableView: TcxGridDBTableViewCitel;
    cxgMultiSerieLevel: TcxGridLevel;
    cxgMultiSerie: TcxGridCitel;
    dtsSeries: TDataSource;
    cxgMultiSerieTableViewNUMSER: TcxGridDBColumn;
    cxgMultiSerieTableViewSELECAO: TcxGridDBColumn;
    cdsSeries: TUniClientDataSet;
    cdsSeriesNUMSER: TStringField;
    cdsSeriesQTDSER: TFloatField;
    cdsSeriesAGG_QTDSER: TAggregateField;
    cdsSeriesSELECIONADO: TBooleanField;
    pnlLeituraDigitacao: TPanel;
    btnHlpSeries: TcxButton;
    btnConfirmar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cdsSeriesQTDSERChange(Sender: TField);
    procedure cxgMultiSerieTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgMultiSerieTableViewEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure cxgMultiSerieTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cdsSeriesBeforePost(DataSet: TDataSet);
    procedure btnHlpSeriesClick(Sender: TObject);
  private
    Const
      BARRA_DIVISAO = 193;
      HIFEN_SUBTRACAO = 189;
  private
    { Private declarations }
    intDecQtd: Integer;
    strCodigoDeBarras : String;
    function fValidouSelecao: Boolean;
    function fCaracterPermitidoNaLeituraDeBarras(const Key : Char; const VirtualKey : Word = 0): Boolean;
    procedure pSelecionaCodigoSerie(const strCodigoBarras : String);
    function fTextoPermitidoNaLeituraDeBarras(const strTexto : String): String;
    procedure pEfetivarBuscaPelaSerie;
    function fOrdToChar(AWord : Word): Char;
  public
    { Public declarations }
    fltQtdItemPed: Double;
    procedure pAlimentaCdsSeries(AcdsOrigem: TDataSet; const blnIncrementarQtdItemPedDosExistentes : Boolean = False);
    procedure pAlimentaCdsSeriesInformadoCtrlF3DoCaixa(AcdsSeries, AcdsSeriesUsadas: TDataSet);
  end;

implementation

uses
  untFuncoesSimples, System.UITypes, ClipBrd, System.StrUtils;

{$R *.dfm}

procedure TfrmFatMultiSerie.btnConfirmarClick(Sender: TObject);
  Var
    fltQtdSelecionada : Double;
begin
  inherited;
  If cdsSeries.State = dsEdit Then
    cdsSeries.Post;

  If (Not fValidouSelecao) Then
  Begin
    pSetFocus(cxgMultiSerie);
    pMensagemOk('Nenhuma série foi selecionada!');
    Exit;
  End;

  If fltQtdItemPed > 0 Then
  Begin
    fltQtdSelecionada := IfNull(cdsSeriesAGG_QTDSER.Value, 0);
    If Not SameValue(fFormataFloat(fltQtdItemPed, intDecQtd),
                     fFormataFloat(fltQtdSelecionada, intDecQtd)) Then
    Begin
      pSetFocus(cxgMultiSerie);
      pMensagemOk('A quantidade total das séries selecionadas está divergente da quantidade original:' + sLineBreak +
                  'Quantidade Original: ' + FloatToStrF(fltQtdItemPed, ffFixed, 12, intDecQtd) + sLineBreak +
                  'Quantidade Selecionada: ' + FloatToStrF(fltQtdSelecionada, ffFixed, 12, intDecQtd));
      Exit;
    End;
  End;

  ModalResult := mrOk;
end;

procedure TfrmFatMultiSerie.btnHlpSeriesClick(Sender: TObject);
begin
  inherited;
  pMensagemOk('Essa tela permite a leitura de código de barras através do leitor, digitação manual ou área de transferência.' + sLineBreak +
              'Para essas operações é necessário estar com o foco no grid.');
end;

procedure TfrmFatMultiSerie.cdsSeriesBeforePost(DataSet: TDataSet);
begin
  inherited;
  If (cdsSeriesSELECIONADO.AsBoolean) Then
    cdsSeriesQTDSER.AsFloat := 1
  Else
    cdsSeriesQTDSER.AsFloat := 0;
end;

procedure TfrmFatMultiSerie.cdsSeriesQTDSERChange(Sender: TField);
begin
  inherited;
  If Sender.IsNull Then
    Sender.AsFloat := 0.00
  Else If Sender.AsFloat < 0 Then
    Sender.AsFloat := 0.00;
end;

procedure TfrmFatMultiSerie.FormCreate(Sender: TObject);
begin
  inherited;
  strCodigoDeBarras := EmptyStr;
  intDecQtd := fCfgSis('DECQTD', varInteger);
  fltQtdItemPed := 0.00;
  cdsSeries.CreateDataSet;
  cdsSeries.IndexFieldNames := 'NUMSER';
  cdsSeriesQTDSER.DisplayFormat := fDisplayFormat(intDecQtd);
end;

procedure TfrmFatMultiSerie.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE: pEscapePressed;
    VK_F10: btnConfirmar.Click;
  End;
end;

function TfrmFatMultiSerie.fTextoPermitidoNaLeituraDeBarras(
  const strTexto: String): String;
  Var
    intCnt : Integer;
begin
  Result := EmptyStr;
  For intCnt := 1 To Length(strTexto) Do
  Begin
    If (Not fCaracterPermitidoNaLeituraDeBarras(strTexto[intCnt])) Then
      Continue;
    Result := Result + strTexto[intCnt];
  End;
end;

function TfrmFatMultiSerie.fValidouSelecao: Boolean;
begin
  Result := False;
  cdsSeries.DisableControls;
  Try
    cdsSeries.First;
    While Not cdsSeries.Eof Do
    Begin
      If (cdsSeriesSELECIONADO.AsBoolean) Then
      Begin
        Result := True;
        Break;
      End;

      cdsSeries.Next;
    End;

    If Not Result Then
      cdsSeries.First;
  Finally
    cdsSeries.EnableControls;
  End;
end;

procedure TfrmFatMultiSerie.cxgMultiSerieTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (Not cdsSeries.Active) Then
    Exit;

  If (cdsSeries.IsEmpty) Then
    Exit;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgMultiSerieTableViewSELECAO.Index]) = 'True' Then
  Begin
    If ACanvas.Brush.Color = clHighlight Then
      ACanvas.Font.Color := clLime
    Else
    Begin
      ACanvas.Brush.Color := clSkyBlue;
      ACanvas.Font.Color := clBlue;
    End;
  End;
end;

procedure TfrmFatMultiSerie.cxgMultiSerieTableViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  cxgMultiSerieTableViewKeyDown(Sender, Key, Shift);
end;

function TfrmFatMultiSerie.fCaracterPermitidoNaLeituraDeBarras(const Key : Char; const VirtualKey : Word = 0): Boolean;
  Const
    CARACTERES_PERMITIDOS = ['/', '-', '0'..'9', 'A'..'Z', 'a'..'z'];
begin
  Result := False;

  If (VirtualKey <> 0) Then
    Result := (VirtualKey In ([VK_NUMPAD0..VK_NUMPAD9, VK_SUBTRACT, VK_DIVIDE, BARRA_DIVISAO, HIFEN_SUBTRACAO]));

  If Not Result Then
    Result := CharInSet(Key, CARACTERES_PERMITIDOS);
end;

function TfrmFatMultiSerie.fOrdToChar(AWord: Word): Char;
begin
  If AWord In ([VK_NUMPAD0..VK_NUMPAD9, VK_SUBTRACT, VK_DIVIDE, BARRA_DIVISAO, HIFEN_SUBTRACAO]) Then
  Begin
    Case AWord Of
      VK_NUMPAD0: Exit('0');
      VK_NUMPAD1: Exit('1');
      VK_NUMPAD2: Exit('2');
      VK_NUMPAD3: Exit('3');
      VK_NUMPAD4: Exit('4');
      VK_NUMPAD5: Exit('5');
      VK_NUMPAD6: Exit('6');
      VK_NUMPAD7: Exit('7');
      VK_NUMPAD8: Exit('8');
      VK_NUMPAD9: Exit('9');
      VK_SUBTRACT: Exit('-');
      VK_DIVIDE: Exit('/');
      BARRA_DIVISAO: Exit('/');
      HIFEN_SUBTRACAO: Exit('-');
    End;
  End;
  Result := Char(AWord);
end;

procedure TfrmFatMultiSerie.cxgMultiSerieTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
  Const
    LETRA_V = ['v', 'V'];
begin
  inherited;
  If Key = VK_RETURN Then
  Begin
    pEfetivarBuscaPelaSerie;
    If cxgMultiSerieTableView.Controller.FocusedRowIndex = cxgMultiSerieTableView.ViewData.RowCount -1 Then
      SelectNext(ActiveControl, True, True);
  End
  Else If (Key = VK_BACK) Then
  Begin
    If (Not strCodigoDeBarras.IsEmpty) Then
    Begin
      If Length(strCodigoDeBarras) = 1 Then
        strCodigoDeBarras := EmptyStr
      Else
        strCodigoDeBarras := LeftStr(strCodigoDeBarras, Length(strCodigoDeBarras)-1);
      pnlLeituraDigitacao.Caption := strCodigoDeBarras
    End;
  End
  Else If (Shift = [ssCtrl]) And (CharInSet(Char(Key), LETRA_V)) Then
  Begin
    strCodigoDeBarras := fTextoPermitidoNaLeituraDeBarras(Clipboard.AsText);
    pEfetivarBuscaPelaSerie;
  End
  Else If fCaracterPermitidoNaLeituraDeBarras(Char(Key), Key) Then
  Begin
    strCodigoDeBarras := strCodigoDeBarras + fOrdToChar(Key);
    pnlInfo.Caption := 'Pressione enter para buscar a série!';
    If (Not pnlLeituraDigitacao.Visible) Then
      pnlLeituraDigitacao.Visible := True;
    pnlLeituraDigitacao.Caption := strCodigoDeBarras
  End;
end;

procedure TfrmFatMultiSerie.pAlimentaCdsSeries(AcdsOrigem: TDataSet; const blnIncrementarQtdItemPedDosExistentes : Boolean = False);
begin
  cdsSeries.EmptyDataSet;

  AcdsOrigem.First;
  While Not AcdsOrigem.Eof Do
  Begin
    cdsSeries.Append;
    cdsSeriesNUMSER.AsString := AcdsOrigem.FieldByName('NUMSER').AsString;
    cdsSeriesQTDSER.AsFloat  := AcdsOrigem.FieldByName('QTDSER').AsFloat;
    cdsSeriesSELECIONADO.AsBoolean := (cdsSeriesQTDSER.AsFloat > 0);
    cdsSeries.Post;
    If (blnIncrementarQtdItemPedDosExistentes) And (cdsSeriesSELECIONADO.AsBoolean) Then
      fltQtdItemPed := fltQtdItemPed + 1;
    AcdsOrigem.Next;
  End;

  cdsSeries.First;
end;

procedure TfrmFatMultiSerie.pAlimentaCdsSeriesInformadoCtrlF3DoCaixa(AcdsSeries,
  AcdsSeriesUsadas: TDataSet);
begin
  cdsSeries.EmptyDataSet;

  AcdsSeries.First;
  While Not AcdsSeries.Eof Do
  Begin
    AcdsSeriesUsadas.Filtered := False;
    AcdsSeriesUsadas.Filter := 'AUTINC <> '+AcdsSeries.FieldByName('AUTINC').AsString.QuotedString+' AND NUMSER = '+ AcdsSeries.FieldByName('NUMSER').AsString.QuotedString + ' AND QTDSER > 0 ';
    AcdsSeriesUsadas.Filtered := True;

    if (AcdsSeriesUsadas.RecordCount > 0) And (AcdsSeriesUsadas.FieldByName('QTDSER').AsFloat > 0) then
    Begin
      AcdsSeries.Next;
      Continue;
    End;

    AcdsSeriesUsadas.Filtered := False;
    AcdsSeriesUsadas.Filter := 'AUTINC = '+AcdsSeries.FieldByName('AUTINC').AsString.QuotedString+' AND NUMSER = '+ AcdsSeries.FieldByName('NUMSER').AsString.QuotedString + ' AND QTDSER > 0 ';
    AcdsSeriesUsadas.Filtered := True;

    cdsSeries.Append;

    if AcdsSeriesUsadas.RecordCount > 0 then
    begin
      cdsSeriesNUMSER.AsString := AcdsSeriesUsadas.FieldByName('NUMSER').AsString;
      cdsSeriesQTDSER.AsFloat  := AcdsSeriesUsadas.FieldByName('QTDSER').AsFloat;
    end
    else
    begin
      cdsSeriesNUMSER.AsString := AcdsSeries.FieldByName('NUMSER').AsString;
      cdsSeriesQTDSER.AsFloat  := AcdsSeries.FieldByName('QTDSER').AsFloat;
    end;


    cdsSeriesSELECIONADO.AsBoolean := (cdsSeriesQTDSER.AsFloat > 0);
    cdsSeries.Post;

    AcdsSeries.Next;
  End;

  cdsSeries.First;
end;

procedure TfrmFatMultiSerie.pEfetivarBuscaPelaSerie;
begin
  pSelecionaCodigoSerie(strCodigoDeBarras);
  pnlLeituraDigitacao.Visible := False;
  pnlInfo.Caption := EmptyStr;
  strCodigoDeBarras := EmptyStr;
end;

procedure TfrmFatMultiSerie.pSelecionaCodigoSerie(
  const strCodigoBarras: String);
begin
  If (Not cdsSeries.FindKey([strCodigoBarras])) Then
    Exit;
  If cdsSeriesSELECIONADO.AsBoolean Then
    Exit;
  cdsSeries.Edit;
  cdsSeriesSELECIONADO.AsBoolean := True;
  cdsSeriesQTDSER.AsFloat := 1;
  cdsSeries.Post;
end;

end.
