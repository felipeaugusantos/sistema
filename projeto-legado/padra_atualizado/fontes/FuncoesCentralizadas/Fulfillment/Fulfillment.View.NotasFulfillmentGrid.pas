unit Fulfillment.View.NotasFulfillmentGrid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, ClipBrd,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxGridBandedTableView, CxProgressBar,
  cxGridDBBandedTableView, cxCurrencyEdit, cxDropDownEdit,
  Fulfillment.Classes.NotasFulfillment;

type
  TfrmNotasFulfillmentGrid = class(TfrmPaiConfirma)
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    Panel1: TPanel;
    chkSoInconsis: TCheckBox;
    GroupBox1: TGroupBox;
    Shape1: TShape;
    Label6: TLabel;
    Shape2: TShape;
    Label7: TLabel;
    Shape3: TShape;
    Label8: TLabel;
    Shape4: TShape;
    Label1: TLabel;
    cxvNotas: TcxGridDBTableView;
    cxgNotasLevel1: TcxGridLevel;
    cxgNotas: TcxGrid;
    cxvNotasDTAEMI: TcxGridDBColumn;
    cxvNotasNUMDOC: TcxGridDBColumn;
    cxvNotasESPDOC: TcxGridDBColumn;
    cxvNotasCODEMP: TcxGridDBColumn;
    cxvNotasSERIE_: TcxGridDBColumn;
    cxvNotasCODCLI: TcxGridDBColumn;
    cxvNotasNOMCLI: TcxGridDBColumn;
    cxvNotasKEYACE: TcxGridDBColumn;
    cxvNotasHISTOR: TcxGridDBColumn;
    cxvNotasVLRCON: TcxGridDBColumn;
    cxvNotasNOMARQ: TcxGridDBColumn;
    cxvNotasNOMPAT: TcxGridDBColumn;
    cxvNotasSTATUS: TcxGridDBColumn;
    cxvNotasENCONT: TcxGridDBColumn;
    btnImportar: TBitBtnLocked;
    btnAbrirXML: TBitBtnLocked;
    Shape5: TShape;
    Label2: TLabel;
    btnAbrirCSV: TBitBtnLocked;
    dtsNotas: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure chkSoInconsisClick(Sender: TObject);
    procedure cxvNotasCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvNotasENCONTGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure btnImportarClick(Sender: TObject);
    procedure cxvNotasCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnAbrirXMLClick(Sender: TObject);
    procedure btnAbrirCSVClick(Sender: TObject);
    procedure cxvNotasSERIE_GetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxvNotasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    Function fCarregaNotasPrg(cxProgressBar: TCxProgressBar): Boolean;
    Procedure pCarregaNotas;
    function fImportarNotasParaTabelaNFeImp(pgbProgresso: TcxProgressBar): Boolean;
    procedure pExibirBotaoImportarParaNFeImp;
  public
    { Public declarations }
    objNotas: TNotasFulfillment;
  end;

implementation

{$R *.dfm}

Uses
  Fulfillment.View.PedArqFulFillment,
  untGravando, untFuncoesSimples, untMensagemExplicativa;

procedure TfrmNotasFulfillmentGrid.btnAbrirCSVClick(Sender: TObject);
  Var
    frmPedArqFulFillment: TfrmPedArqFulFillment;
begin
  inherited;

  pCriarFormularios(TfrmPedArqFulFillment, frmPedArqFulFillment);

  Try
    If frmPedArqFulFillment.ShowModal = mrOk Then
    Begin
      If objNotas.fExportaNotasCSV(cxvNotas, frmPedArqFulFillment.edtNomArq.Text) Then
        pMensagemOk('Arquivo exportado com sucesso!');
    End;
  Finally
    pFreeAndNil(frmPedArqFulFillment);
  End;

end;

procedure TfrmNotasFulfillmentGrid.btnAbrirXMLClick(Sender: TObject);
begin
  inherited;

  If cxvNotas.DataController.DataSource.DataSet.FieldByName('NOMARQ').AsString.IsEmpty Then
  Begin
    pMensagemOk('Arquivo inexistente!');
    Exit;
  End;

  objNotas.fExtraiArquivo(True,
                          cxvNotas.DataController.DataSource.DataSet.FieldByName('NOMPAT').AsString,
                          cxvNotas.DataController.DataSource.DataSet.FieldByName('NOMARQ').AsString,
                          cxvNotas.DataController.DataSource.DataSet.FieldByName('INDZIP').AsInteger);
end;

procedure TfrmNotasFulfillmentGrid.btnImportarClick(Sender: TObject);
begin
  inherited;
  If btnImportar.Visible Then
    TfrmGravando.fExecutarModalA(fImportarNotasParaTabelaNFeImp,
      'Importando documentos não encontrados, aguarde ... ', '');
end;


function TfrmNotasFulfillmentGrid.fImportarNotasParaTabelaNFeImp(pgbProgresso: TcxProgressBar): Boolean;
Var
  LDataSet: TDataSet;
  LQtdImport: Integer;
  LTmpCount: Integer;
  LMensagem: String;
  LMensagens: TStringList;

  procedure pProcessaGravacao;
  begin
    If Not objNotas.FInsertsInBatch.IsEmpty Then
      If Not objNotas.FInsertsInBatch.ExecSQL Then
        Exit;

    objNotas.FInsertsInBatch.Clear;

    objNotas.pReprocessaNotasComErro;

    LTmpCount := 0;
  end;

  procedure pImportarNotasParaTabelaNFeImpInterna;
  begin
    LTmpCount := 0;

    pgbProgresso.Position := 0;
    pgbProgresso.Properties.Max := LDataSet.RecordCount;

    objNotas.FInsertsInBatch.Clear;

    LDataSet.First;
    While Not LDataSet.Eof Do
    Begin
      LMensagem := '';

      If objNotas.fImportarNotaParaTabelaNFeImp(LDataSet, LMensagem) Then
      Begin
        Inc(LQtdImport);
        Inc(LTmpCount);

        //gera o insert na NFEIMP a cada 250 registros
        If LTmpCount = 250 Then
          pProcessaGravacao;
      End;

      If Not LMensagem.IsEmpty Then
        LMensagens.Add(LMensagem);

      LDataSet.Next;

      pStepStatusGravacao(pgbProgresso,
                          Format('Importando documentos não encontrados (%d/%d)', [LDataSet.RecNo, LDataSet.RecordCount]));
    End;

    //insere o restante, caso tenha
    If LTmpCount > 0 Then
      pProcessaGravacao;
  end;

begin
  Result := True;
  LQtdImport := 0;

  LMensagens := TStringList.Create;
  LDataSet := cxvNotas.DataController.DataSource.DataSet;

  Try
    Try
      LMensagens.Sorted     := True;
      LMensagens.Duplicates := dupIgnore;
      LMensagens.Delimiter  := #13;

      cxvNotas.BeginUpdate;

      LDataSet.DisableControls;

      LDataSet.Filtered := False;
      LDataSet.Filter   := 'NFESTS = ''AT''';
      LDataSet.Filtered := True;

      //importa primeiro as notas autorizadas
      pImportarNotasParaTabelaNFeImpInterna;

      LDataSet.Filtered := False;
      LDataSet.Filter   := 'NFESTS <> ''AT''';
      LDataSet.Filtered := True;

      //importa as demais notas
      pImportarNotasParaTabelaNFeImpInterna;

      If LQtdImport > 0 Then
        pMensagemOk(LQtdImport.ToString +' Nota(s) inserida(s) na fila para importação. Aguarde alguns minutos e execute a ferramenta de auditoria novamente.');

      If LMensagens.Count > 0 Then
        TfrmMensagemExplicativa.pMensagem(LMensagens.Text.Trim, 400, 800);
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmNotasFulfillmentGrid.fImportarNotasParaTabelaNFeImp]');
      End;
    End;
  Finally
    LMensagens.Free;
    LDataSet.Filter   := '';
    LDataSet.Filtered := False;
    LDataSet.EnableControls;
    cxvNotas.EndUpdate;
  End;
end;

procedure TfrmNotasFulfillmentGrid.pExibirBotaoImportarParaNFeImp;
begin
  btnImportar.Visible := False;

//  If Not fEhAdministrador(strLoginUsuarioLogado) Then
//    Exit;

  If Not chkSoInconsis.Checked Then
    Exit;

  btnImportar.Visible := True;
end;

procedure TfrmNotasFulfillmentGrid.chkSoInconsisClick(Sender: TObject);
begin
  inherited;
  pExibirBotaoImportarParaNFeImp;
  pCarregaNotas;
end;

procedure TfrmNotasFulfillmentGrid.cxvNotasCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  btnAbrirXML.Click;
end;

procedure TfrmNotasFulfillmentGrid.cxvNotasCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    intStatus: Integer;
begin
  inherited;

  intStatus := StrToIntDef(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvNotasSTATUS.Index]), 0);

  Case intStatus Of
    intNaoEncontrada                                : ACanvas.Font.Color := clRed;
    intCanceladoXML_NaoCancaladaLivro               : ACanvas.Font.Color := $004080FF;
    intFaltante                                     : ACanvas.Font.Color := clPurple;
    intNaoEncontradaPelaChaveMasEncontradaPeloNumero: ACanvas.Font.Color := clFuchsia;
    Else                                              ACanvas.Font.Color := clBlue;
  End;

end;

procedure TfrmNotasFulfillmentGrid.cxvNotasENCONTGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;

  If VarToStr(cxvNotas.DataController.Values[ARecord.RecordIndex, cxvNotasENCONT.Index]) = 'S' Then
    AText := 'Encontradas'
  Else
    AText := 'Não Encontradas';

end;

procedure TfrmNotasFulfillmentGrid.cxvNotasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (ssCtrl In Shift) And (Char(Key) = 'C') Then
  Begin
    If Assigned(cxvNotas.Controller.FocusedRow) And Assigned(cxvNotas.Controller.FocusedColumn) Then
      Clipboard.AsText := VarToStr(cxvNotas.Controller.FocusedRow.Values[cxvNotas.Controller.FocusedColumn.Index]);
  End;
end;

procedure TfrmNotasFulfillmentGrid.cxvNotasSERIE_GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
  Var
    intStatus: Integer;
begin
  inherited;

  intStatus := StrToIntDef(IfNull(Sender.DataBinding.DataController.Values[ARecord.RecordIndex, cxvNotasSTATUS.Index], 0), 0);

  If intStatus = intFaltante Then
    AText := '';
end;

Function TfrmNotasFulfillmentGrid.fCarregaNotasPrg(cxProgressBar: TCxProgressBar): Boolean;
Begin
  If chkSoInconsis.Checked Then
    dtsNotas.DataSet := objNotas.cdsInconsistencias
  Else
    dtsNotas.DataSet := objNotas.cdsNotas;

  cxvNotas.ViewData.Expand(True);
  cxvNotas.NavigatorButtons.First.Click;

  Result := True;
end;

Procedure TfrmNotasFulfillmentGrid.pCarregaNotas;
  Var
    frmGravando: TfrmGravando;
Begin
  TfrmGravando.fExecuta(fCarregaNotasPrg, frmGravando, 'Carregando notas para a tela, aguarde...', False);
End;

procedure TfrmNotasFulfillmentGrid.FormShow(Sender: TObject);
begin
  inherited;
  Self.Caption := Self.Caption + ' (' + objNotas.strHUbMkpDescricao+ ')';
  pExibirBotaoImportarParaNFeImp;
  fCarregaNotasPrg(Nil);
end;


end.


