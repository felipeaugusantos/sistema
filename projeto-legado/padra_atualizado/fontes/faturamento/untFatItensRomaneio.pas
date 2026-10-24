unit untFatItensRomaneio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids,
  EditFocus, DB, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmFatItensRomaneio = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtCodIte: TEditFocus;
    Label2: TLabel;
    edtDescri: TEditFocus;
    Label3: TLabel;
    edtQtdIte: TEditFocus;
    btnAdicionaItem: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnInformacoes: TBitBtnLocked;
    btnMarcaDesmarca: TBitBtnLocked;
    dbgItens: TcxGrid;
    dbgItensDBView: TcxGridDBTableView;
    dbgItensDET_CODITE: TcxGridDBColumn;
    dbgItensDET_DESITE: TcxGridDBColumn;
    dbgItensDET_NUMLOT: TcxGridDBColumn;
    dbgItensDET_QTDITE: TcxGridDBColumn;
    dbgItensDET_QTDBAI: TcxGridDBColumn;
    dbgItenslevel: TcxGridLevel;
    dbgItensTURENT: TcxGridDBColumn;
    dbgItensDET_UNIDAD: TcxGridDBColumn;
    dbgItensDET_EMPORI: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAdicionaItemClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnInformacoesClick(Sender: TObject);
    procedure btnMarcaDesmarcaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dbgItensDBViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure dbgItensDBViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
    blnMarca: Boolean;
    intConfirmando: Integer;

    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pMarcaDesmarcaQtdDesabilitado;
    function fTravaQuantidadeMarmore: Boolean;
  public
    { Public declarations }
    strLetMar: String;
    fltTotDoc: Double;
    strInfIte: String;
    blnMostraEmpOri: Boolean;
  end;

var
  frmFatItensRomaneio: TfrmFatItensRomaneio;

implementation

uses  untfuncoesSimples, untFatItensRomaneioInform;

{$R *.dfm}

procedure TfrmFatItensRomaneio.dbgItensDBViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgItensDET_QTDBAI.Index] > 0 then
  begin
    ACanvas.Brush.Color := clSkyBlue;
    ACanvas.Font.Color := clBlue;
  end
  else
  begin
    ACanvas.Brush.Color := clWhite;
    ACanvas.Font.Color := clBlack;
  end;
end;

procedure TfrmFatItensRomaneio.dbgItensDBViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If InterlockedIncrement(intConfirmando) <> 0 Then
  Begin
    InterlockedDecrement(intConfirmando);
    Key := 0;
    Exit;
  End
  Else
    InterlockedDecrement(intConfirmando);

  If (Key = VK_RETURN) Then
  Begin
    edtQtdIte.Enabled := True;

    if fTravaQuantidadeMarmore then
    begin
      edtQtdIte.Enabled := False;
      pMarcaDesmarcaQtdDesabilitado;
    end
    else
    begin
      pnlCabecalho.Enabled := True;
      pSetFocus(edtQtdIte);
    end;
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    btnSair.Click;
  End;
end;

procedure TfrmFatItensRomaneio.pAtualizaDados(DataSet: TDataSet);
begin

  edtCodIte.Text := qryTabela.FieldByName('DET_CODITE').AsString;
  edtDescri.Text := qryTabela.FieldByName('DET_DESITE').AsString;
  edtQtdIte.Text := FloatToStrF(qryTabela.FieldByName('DET_QTDBAI').AsFloat, ffFixed, 12, fCfgSis('DECQTD', varInteger));

end;

procedure TfrmFatItensRomaneio.pMarcaDesmarcaQtdDesabilitado;
begin
  qryTabela.Edit;
  If qryTabela.FieldByName('DET_QTDBAI').AsFloat = 0 Then
    qryTabela.FieldByName('DET_QTDBAI').AsFloat := qryTabela.FieldByName('DET_QTDITE').AsFloat
  Else
    qryTabela.FieldByName('DET_QTDBAI').AsFloat := 0;
  qryTabela.Post;
end;

procedure TfrmFatItensRomaneio.FormShow(Sender: TObject);
begin
  inherited;
  qryTabela := TUniQuery(dbgItensDBView.DataController.DataSet);

  qryTabela.DisableControls;
  qryTabela.First;

  While (Not qryTabela.Eof) Do
  Begin
    qryTabela.Edit;
    qryTabela.FieldByName('DET_QTDTMP').AsFloat := qryTabela.FieldByName('DET_QTDBAI').AsFloat;
    qryTabela.Post;
    qryTabela.Next;
  End;

  qryTabela.First;

  qryTabela.EnableControls;

  qryTabela.AfterScroll := pAtualizaDados;
  pAtualizaDados(Nil);

  dbgItensDBView.ApplyBestFit();

  strLetMar := '';
  fltTotDoc := 0.0;
  blnMarca  := False;

  dbgItensTURENT.Visible := (fCfgSis('EXITUR', varBoolean));
  dbgItensDET_EMPORI.Visible := blnMostraEmpOri;
end;

function TfrmFatItensRomaneio.fTravaQuantidadeMarmore: Boolean;
begin
  Result := False;

  if (fCfgSis('MARMOR', varBoolean)) then
  begin
    if (fCfgSis('ROMPAR', varBoolean)) then
    begin
      if dbgItensDBView.DataController.DataSource.DataSet.Active then
      begin
        if dbgItensDBView.DataController.DataSource.DataSet.RecNo > 0 then
        begin
          Result := fCampoTabela('ITE_GRAMAR', 'CADITE', ['ITE_CODITE'], [dbgItensDBView.DataController.DataSource.DataSet.FieldByName('DET_CODITE').AsString], False) = 'S';
        end;
      end;
    end;
  end;
end;

procedure TfrmFatItensRomaneio.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(dbgItens);
end;

procedure TfrmFatItensRomaneio.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qryTabela.AfterScroll := Nil;
  inherited;
end;

procedure TfrmFatItensRomaneio.FormCreate(Sender: TObject);
begin
  inherited;

  intConfirmando := -1;
  blnMostraEmpOri := False;
end;

procedure TfrmFatItensRomaneio.btnCancelarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgItens);
  pAtualizaDados(Nil);
  pnlCabecalho.Enabled := False;
end;

procedure TfrmFatItensRomaneio.btnAdicionaItemClick(Sender: TObject);
  Var
    fltMultiplo: Double;
    strOpcao   : String;
begin
  inherited;

  InterLockedIncrement(intConfirmando);
  try
    If (fStrToFloat(edtQtdIte.Text) < 0.0) Then
    Begin
      fMensagem('', 'A quantidade de entrega deve ser maior ou igual a Zero!', ['&Ok']);
      pSetFocus(edtQtdIte);
      Exit;
    End;

    If (qryTabela.FieldByName('DET_QTDITE').AsFloat < fStrToFloat(edtQtdIte.Text)) Then
    Begin
      fMensagem('', 'A quantidade de entrega deve ser menor ou igual a quantidade do romaneio!', ['&Ok']);
      pSetFocus(edtQtdIte);
      Exit;
    End;

    strOpcao := fCfgSis('DIVMVR');

    If strOpcao <> 'N' Then
    Begin
      If Not fMultiploValido(qryTabela.FieldByName('DET_CODITE').AsString,
                             fStrToFloat(edtQtdIte.Text),
                             fltMultiplo) Then
      Begin
        If strOpcao = 'A' Then
        Begin
          fMensagem('', 'A quantidade de entrega deste produto'+ #13#10 +'diverge de seu múltiplo de venda ( ' +
                        FloatToStrF(fltMultiplo, ffNumber, 12, 2) + ' )!', ['&Ok']);
        End
        Else
        Begin
          fMensagem('', 'A quantidade de entrega deve ser múltiplo de ' + FloatToStrF(fltMultiplo, ffNumber, 12, 2) + '!', ['&Ok']);
          pSetFocus(edtQtdIte);
          Exit;
        End;
      End;
    End;

    qryTabela.Edit;
    qryTabela.FieldByName('DET_QTDBAI').AsFloat := fStrToFloat(edtQtdIte.Text);
    qryTabela.Post;

    btnCancelar.Click;
  finally
    InterLockedDecrement(intConfirmando);
  end;
end;

{*******************************************}
{* CONFIRMA OS ITENS. CASO MARQUE TODOS OS *}
{* ITENS COM ZERO, TEM O MESMO EFEITO DE   *}
{* DESMARCAR O DOCUMENTO.                  *}
{****************************************MV*}
procedure TfrmFatItensRomaneio.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (fMensagem('', 'Confirma itens?', ['&Sim', '&Não']) = 2) Then
    Exit;

  qryTabela.DisableControls;
  qryTabela.First;

  strLetMar := 'M';
  fltTotDoc := 0.0;

  While (Not qryTabela.Eof) Do
  Begin

    {*******************************************}
    {* CALCULA O TOTAL SELECIONADO DO DOC.     *}
    {****************************************MV*}
    fltTotDoc := fltTotDoc +
                 (fFormataFloat(qryTabela.FieldByName('DET_QTDBAI').AsFloat * qryTabela.FieldByName('DET_UNITAR').AsFloat, 2)) -
                 (fFormataFloat(qryTabela.FieldByName('DET_QTDBAI').AsFloat * (qryTabela.FieldByName('DET_DESESP').AsFloat / qryTabela.FieldByName('DET_QTDTOT_REAL').AsFloat), 2)) +
                 (fFormataFloat(qryTabela.FieldByName('DET_QTDBAI').AsFloat * (qryTabela.FieldByName('DET_TOTFRE').AsFloat / qryTabela.FieldByName('DET_QTDTOT_REAL').AsFloat), 2)) +
                 (fFormataFloat(qryTabela.FieldByName('DET_QTDBAI').AsFloat * (qryTabela.FieldByName('DET_DESACE').AsFloat / qryTabela.FieldByName('DET_QTDTOT_REAL').AsFloat), 2));


    If (qryTabela.FieldByName('DET_QTDBAI').AsFloat <> qryTabela.FieldByName('DET_QTDITE').AsFloat) Then
    Begin
      strLetMar := 'P';
    End;

    qryTabela.Next;
  End;

  If (fltTotDoc <= 0.0) Then
    strLetMar := 'D';

  qryTabela.EnableControls;
  Close;
  ModalResult := mrOk;

end;

procedure TfrmFatItensRomaneio.btnSairClick(Sender: TObject);
begin
  If (fMensagem('', 'Abandona itens?', ['&Sim', '&Não']) = 2) Then
    Exit;

  inherited;

  qryTabela.DisableControls;
  qryTabela.First;

  While (Not qryTabela.Eof) Do
  Begin
    qryTabela.Edit;
    qryTabela.FieldByName('DET_QTDBAI').AsFloat := qryTabela.FieldByName('DET_QTDTMP').AsFloat;
    qryTabela.Post;
    qryTabela.Next;
  End;
  qryTabela.EnableControls;

  ModalResult := mrCancel;
  strLetMar := '';
end;

procedure TfrmFatItensRomaneio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

    If InterlockedIncrement(intConfirmando) <> 0 Then
  Begin
    InterlockedDecrement(intConfirmando);
    Key := 0;
    Exit;
  End
  Else
    InterlockedDecrement(intConfirmando);

  If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End;

  If (Key = VK_F9) Then
  Begin
    btnInformacoes.Click;
  End;

  If (Key = VK_F8) Then
  Begin
    btnMarcaDesmarca.Click;
  End;
end;

procedure TfrmFatItensRomaneio.btnInformacoesClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmFatItensRomaneioInform, frmFatItensRomaneioInform);
    frmFatItensRomaneioInform.lblCodigo.Caption    := qryTabela.FieldByName('DET_CODITE').AsString;
    frmFatItensRomaneioInform.lblDescricao.Caption := qryTabela.FieldByName('DET_DESITE').AsString;
    frmFatItensRomaneioInform.memInform.Texto      := qryTabela.FieldByName('DET_INFITE').AsString;
    frmFatItensRomaneioInform.ShowModal;
    strInfIte := frmFatItensRomaneioInform.memInform.Text;

    qryTabela.Edit;
    qryTabela.FieldByName('DET_INFITE').AsString := strInfIte;
    qryTabela.Post;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmFatItensRomaneio.btnInformacoesClick]');
    End;
  End;

  pFreeAndNil(frmFatItensRomaneioInform);

  pSetFocus(dbgItens);

end;

procedure TfrmFatItensRomaneio.btnMarcaDesmarcaClick(Sender: TObject);
begin
  qryTabela.DisableControls;
  qryTabela.First;

  While (Not qryTabela.Eof) Do
  Begin
    qryTabela.Edit;

    If blnMarca Then
      qryTabela.FieldByName('DET_QTDBAI').AsFloat := qryTabela.FieldByName('DET_QTDITE').AsFloat
    Else
      qryTabela.FieldByName('DET_QTDBAI').AsFloat := 0;

    qryTabela.Post;
    qryTabela.Next;
  End;

  blnMarca := Not blnMarca;
  qryTabela.First;

  qryTabela.EnableControls;
  pAtualizaDados(Nil);
end;

end.

