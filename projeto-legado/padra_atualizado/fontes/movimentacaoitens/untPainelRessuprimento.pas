unit untPainelRessuprimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass, Vcl.ComCtrls,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untGravando, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Uni,untFuncoesSimples, untTransferenciaMovimentacaoProgramada,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxProgressBar,
  cxCurrencyEdit, cxGridBandedTableView, cxGridDBBandedTableView,
  Datasnap.DBClient, UniClientDataSet;

type
  TfrmPainelRessuprimento = class(TfrmPaiConfirma)
    btnMarDes: TBitBtnLocked;
    btnMarTodos: TBitBtnLocked;
    btnDesmarTodos: TBitBtnLocked;
    btnDesativarSelecionados: TBitBtnLocked;
    cxgItens: TcxGrid;
    cxgItensView: TcxGridDBBandedTableView;
    cxgItensCODITE: TcxGridDBBandedColumn;
    cxgItensDESITE: TcxGridDBBandedColumn;
    cxgItensLOCORI: TcxGridDBBandedColumn;
    cxgItensITE_LOCDES: TcxGridDBBandedColumn;
    cxgItensLARG_: TcxGridDBBandedColumn;
    cxgItensCODUNI: TcxGridDBBandedColumn;
    cxgItensLevel1: TcxGridLevel;
    cxgItensViewQTDTRF: TcxGridDBBandedColumn;
    cxgItensViewMETCUB: TcxGridDBBandedColumn;
    cxgItensViewALTU_: TcxGridDBBandedColumn;
    cxgItensViewPROF_: TcxGridDBBandedColumn;
    cxgItensViewCUBDES: TcxGridDBBandedColumn;
    cxgItensViewPRDDIF: TcxGridDBBandedColumn;
    cxgItensViewTXAOCU: TcxGridDBBandedColumn;
    cxgItensViewEXCESS: TcxGridDBBandedColumn;
    cxgItensViewLOCSAL: TcxGridDBBandedColumn;
    cxgItensViewCUBATU: TcxGridDBBandedColumn;
    cxgItensViewSELECIONADO: TcxGridDBBandedColumn;
    cxStyleRepository: TcxStyleRepository;
    styLocOri: TcxStyle;
    styLocDes: TcxStyle;
    styDadosItem: TcxStyle;
    pnlLegenda: TPanel;
    styQtdTransf: TcxStyle;
    cdsItens: TUniClientDataSet;
    cdsItensCODITE: TStringField;
    cdsItensLOTORI: TStringField;
    cdsItensLOTDES: TStringField;
    cdsItensQTDITE: TFloatField;
    cdsItensSALORI: TFloatField;
    cdsItensSALDES: TFloatField;
    cdsItensMAXORI: TFloatField;
    cdsItensMAXDES: TFloatField;
    cdsItensREPORI: TFloatField;
    cdsItensREPDES: TFloatField;
    cdsItensDESITE: TStringField;
    cdsItensSALDOS: TFloatField;
    cdsItensPRECUS: TFloatField;
    cdsItensLOCORI: TStringField;
    cdsItensLOCDES: TStringField;
    cdsItensDESLFO: TStringField;
    cdsItensDESLFD: TStringField;
    cdsItensCODMAR: TStringField;
    cdsItensDESMAR: TStringField;
    cdsItensSIGUNI: TStringField;
    cdsItensDTAVAL: TDateField;
    cdsItensSALORIRES: TFloatField;
    cdsItensSALORIDIS: TFloatField;
    cdsItensSALDESRES: TFloatField;
    cdsItensSALDESDIS: TFloatField;
    cdsItensAUTINC: TStringField;
    cdsItensORIPIC: TStringField;
    cdsItensDESPIC: TStringField;
    cdsItensQTDDIF: TFloatField;
    cdsItensOPEDES: TStringField;
    cdsItensNOMOPEDES: TStringField;
    cxgItensViewSALOPD: TcxGridDBBandedColumn;
    cxgItensViewCUBOPD: TcxGridDBBandedColumn;
    dtsTransf: TDataSource;
    prgProgresso: TProgressBar;
    lblLegendaShift: TLabel;
    dtsItensClasse: TDataSource;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnDesmarTodosClick(Sender: TObject);
    procedure btnMarTodosClick(Sender: TObject);
    procedure btnMarDesClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnDesativarSelecionadosClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgItensViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgItensViewDblClick(Sender: TObject);
  private
    function fMarcarDesmarcar(blnMarcar: Boolean): Boolean;
    function fMarcarDesmarcarAux(pgbProgresso: TcxProgressBar): Boolean;
    function fInicializarQuery(pgbProgresso: TcxProgressBar): Boolean;
    function fDesativarSelecionados(pgbProgresso: TcxProgressBar): Boolean;
    function fAtivarSelecionados(pgbProgresso: TcxProgressBar): Boolean;
    procedure pMarcarDesmarcarItem;
    procedure pLimpaITERES;
    var
      FblnMarcar,
      FblnShiftPressionado: Boolean;
      qryItens: TUniQuery;
      dtsItens: TDataSource;
      objTransf: TTransferenciaLote;
  public
    { Public declarations }
  end;

var
  frmPainelRessuprimento: TfrmPainelRessuprimento;

implementation

{$R *.dfm}

procedure TfrmPainelRessuprimento.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If fMensagem('', 'Confirma ATIVAÇÃO dos itens selecionados?', ['&Sim', '&Não']) = 1 Then
    If TfrmGravando.fExecuta(fAtivarSelecionados, frmGravando, 'Confirmando itens...') Then
      Self.ModalResult := mrOk;
end;

procedure TfrmPainelRessuprimento.btnDesativarSelecionadosClick(
  Sender: TObject);
begin
  inherited;
  If fMensagem('', 'Confirma DESATIVAÇÃO dos itens selecionados?', ['&Sim', '&Não']) = 1 Then
    TfrmGravando.fExecuta(fDesativarSelecionados, frmGravando, 'Desativando itens...');
end;

procedure TfrmPainelRessuprimento.pLimpaITERES;
var
  qryDel: TUniQuery;
begin
  qryItens.Filter   := 'SELECIONADO = "S"';
  qryItens.Filtered := True;
  qryItens.First;

  While Not qryItens.Eof Do
  Begin
    Try
      Try
        qryDel := fCriaQuery;
        qryDel.SQL.Add('DELETE FROM ITERES WHERE AUTOINCREM = :AUTINC');
        qryDel.Params[0].AsString := qryItens.FieldByName('AUTOINCREM').AsString;

        fStartTransaction;
        qryDel.ExecSQL;
        fCommit;
      Except On
        E:Exception Do
        Begin
          fRollBack;
          pMensagemOK('Houve um erro ao limpar a tabela de ressuprimento!');
        End;
      End;
    Finally
      FreeAndNil(qryDel);
    End;

  qryItens.Next;
  End;
end;

function TfrmPainelRessuprimento.fAtivarSelecionados(pgbProgresso: TCxProgressBar): Boolean;
begin
  qryItens.Filter   := 'SELECIONADO = "S"';
  qryItens.Filtered := True;
  qryItens.First;

  pgbProgresso.Position := 0;
  pgbProgresso.Properties.Max := qryItens.RecordCount;

  Try

    While not qryItens.Eof Do
    Begin
      cdsItens.Insert;
      cdsItens.FieldByName('CODITE').AsString := qryItens.FieldByName('ITE_CODITE').AsString;
      cdsItens.FieldByName('LOTORI').AsString := qryItens.FieldByName('ITE_LOTORI').AsString;
      cdsItens.FieldByName('LOCDES').AsString := qryItens.FieldByName('ITE_LOCDES').AsString;
      cdsItens.FieldByName('QTDITE').AsFloat  := qryItens.FieldByName('ITE_QTDTRF').AsFloat;

      objTransf.strCodOpe := strLoginUsuarioLogado;
      objTransf.fCarregarLote(qryItens.FieldByName('ITE_LOTORI').AsString, cdsItens);
      cdsItens.Post;

      qryItens.Next;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    Result := objTransf.fGeraTransferencia(True, True);

    If Result Then
    Begin
      pLimpaITERES;
      pMensagemOK('Transferência realizada com sucesso!');
    End;
  Except On
    E:Exception Do
    Begin
      Result := False;
      pMensagemOK('Falha ao ativar itens selecionados!'+#13+'Verifique se o item já possui movimentações em aberto!');
      pMensagensErro(E.Message, 'TfrmPainelRessuprimento.fAtivarSelecionados');
    End;
  End;
end;

procedure TfrmPainelRessuprimento.btnDesmarTodosClick(Sender: TObject);
begin
  inherited;
  fMarcarDesmarcar(False);
end;

procedure TfrmPainelRessuprimento.pMarcarDesmarcarItem;
begin
  qryItens.Edit;
  qryItens.FieldByName('SELECIONADO').AsString := IIF(qryItens.FieldByName('SELECIONADO').AsString = 'N','S','N');
  qryItens.Post;
end;

procedure TfrmPainelRessuprimento.btnMarDesClick(Sender: TObject);
begin
  inherited;
  pMarcarDesmarcarItem;
end;

procedure TfrmPainelRessuprimento.btnMarTodosClick(Sender: TObject);
begin
  inherited;
  fMarcarDesmarcar(True);
end;

procedure TfrmPainelRessuprimento.cxgItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Font.Color := clBlack;
  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewSELECIONADO.Index]) = 'S' Then
    ACanvas.Brush.Color := clAqua;
end;

procedure TfrmPainelRessuprimento.cxgItensViewDblClick(Sender: TObject);
begin
  inherited;
  btnMarDes.Click;
end;

procedure TfrmPainelRessuprimento.cxgItensViewFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  inherited;
  If (FblnShiftPressionado) Then
  Begin
    FblnShiftPressionado := False;
    pMarcarDesmarcaritem;
  End;
end;

function TfrmPainelRessuprimento.fDesativarSelecionados(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  qryItens.Filter   := 'SELECIONADO = "S"';
  qryItens.Filtered := True;
  qryItens.First;

  pgbProgresso.Position := 0;
  pgbProgresso.Properties.Max := qryItens.RecordCount;

  Try
    While Not qryItens.Eof Do
    Begin
      qryItens.Delete;
      qryItens.Next;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    Result := True;
  Except On
    E:Exception Do
    Begin
      Result := False;
    End;
  End;

end;

function TfrmPainelRessuprimento.fMarcarDesmarcar(blnMarcar: Boolean): Boolean;
begin
  FblnMarcar := blnMarcar;
  Result := TfrmGravando.fExecuta(fMarcarDesmarcarAux, frmGravando, IIF(blnMarcar, 'Marcando','Desmarcando') + ' itens...');
end;

function TfrmPainelRessuprimento.fMarcarDesmarcarAux(pgbProgresso: TcxProgressBar):Boolean;
var
  recNo: Integer;
begin
  recNo := qryItens.RecNo;
  qryItens.First;

  pgbProgresso.Position       := 0;
  pgbProgresso.Properties.Max := qryItens.RecordCount;

  While not qryItens.Eof Do
  Begin
    qryItens.Edit;
    qryItens.FieldByName('SELECIONADO').AsString := IIF(FblnMarcar,'S','N');
    qryItens.Post;
    qryItens.Next;

    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;

  qryItens.recNo := recNo;

  Result := True;
end;

procedure TfrmPainelRessuprimento.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryItens);
  FreeAndNil(objTransf);
end;

procedure TfrmPainelRessuprimento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  FblnShiftPressionado := Shift = [ssShift];
  Case Key Of
    VK_F2:
      btnMarTodos.Click;
    VK_F3:
      btnDesmarTodos.Click;
    VK_F9:
      btnDesativarSelecionados.Click;
    VK_F10:
      btnConfirma.Click;
    VK_RETURN, VK_SPACE:
      btnMarDes.Click;
  End;
end;

procedure TfrmPainelRessuprimento.FormShow(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecuta(fInicializarQuery, frmGravando, 'Selecionando itens...');
  dtsItens := fCriaDataSource(qryItens);
  cxgItensView.DataController.DataSource := dtsItens;
  cdsItens.CreateDataSet;
  objTransf := TTransferenciaLote.Create(Self, cdsItens, dtsItensClasse, prgProgresso);
end;


function TfrmPainelRessuprimento.fInicializarQuery(pgbProgresso: TCxProgressBar): Boolean;
begin
  qryItens := fCriaQuery;
  qryItens.SQL.Clear;
  qryItens.SQL.Add('SELECT                               ');
  qryItens.SQL.Add(' I.*,                                ');
  qryItens.SQL.Add(' CAST("N" AS CHAR(1)) AS SELECIONADO ');
  qryItens.SQL.Add('FROM                                 ');
  qryItens.SQL.Add(' ITERES I                            ');
  qryItens.SQL.Add('WHERE                                ');
  qryItens.SQL.Add(' I.ITE_CODEMP = :CODEMP              ');
  qryItens.SQL.Add('ORDER BY I.ITE_CODITE                ');
  qryItens.ParamByName('CODEMP').AsString := (VS_strCodEmp);
  qryItens.Open;

  qryItens.FieldByName('SELECIONADO').ReadOnly := False;

  If qryItens.isEmpty Then
  Begin
    pMensagemOk('Não há itens para ressuprimento!');
    ModalResult := mrOK;
  End;

  Result := True;
end;

end.
