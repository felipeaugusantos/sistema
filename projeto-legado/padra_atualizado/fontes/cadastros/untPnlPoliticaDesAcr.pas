unit untPnlPoliticaDesAcr;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, untPaiSimples, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, CurrencyEditFocus,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, EditFocus,
  System.Generics.Collections, UniClientDataSet, untTypesSistema, System.Math,
  System.StrUtils, cxProgressBar, Uni, frxClass, cxContainer, cxTextEdit,
  cxCurrencyEdit, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TTipoDesconto = (tdDesconto, tdAcrescimo);

type
  TfrmPnlPoliticaDesAcr = class(TfrmPaiSimples)
    pnlDescontos: TPanel;
    Label2: TLabel;
    lblDes1: TLabel;
    edtDescDes: TEditFocus;
    btnAddDes: TBitBtnLocked;
    btnCancDes: TBitBtnLocked;
    cxGridDesconto: TcxGridCitel;
    cxGridDescontoTable: TcxGridDBTableViewCitel;
    cxGridDescontoLevel1: TcxGridLevel;
    pnlLegendaDes: TPanel;
    Label3: TLabel;
    Label5: TLabel;
    btnOrdCimDes: TBitBtnLocked;
    btnOrdBaiDes: TBitBtnLocked;
    edtPercDes: TCurrencyEditFocus;
    pnlAcrecimos: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    edtDescAcr: TEditFocus;
    btnAddAcr: TBitBtnLocked;
    btnCancAcr: TBitBtnLocked;
    cxGridAcrescimo: TcxGridCitel;
    cxGridAcrescimoTable: TcxGridDBTableViewCitel;
    cxGridLevel1: TcxGridLevel;
    Panel1: TPanel;
    Label8: TLabel;
    Label12: TLabel;
    btnOrdCimAcr: TBitBtnLocked;
    btnOrdBaiAcr: TBitBtnLocked;
    edtPercAcr: TCurrencyEditFocus;
    dtsDesconto: TDataSource;
    dtsAcrescimo: TDataSource;
    cxGridDescontoTableDESCRI: TcxGridDBColumn;
    cxGridDescontoTablePERCEN: TcxGridDBColumn;
    cxGridAcrescimoTableDESCRI: TcxGridDBColumn;
    cxGridAcrescimoTablePERCEN: TcxGridDBColumn;
    lblRodape1: TLabel;
    lblTotalDes: TLabel;
    lblTotalAcr: TLabel;
    lblRodape2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnCancDesClick(Sender: TObject);
    procedure btnAddDesClick(Sender: TObject);
    procedure btnAddAcrClick(Sender: TObject);
    procedure btnCancAcrClick(Sender: TObject);
    procedure btnOrdCimDesClick(Sender: TObject);
    procedure btnOrdBaiDesClick(Sender: TObject);
    procedure btnOrdCimAcrClick(Sender: TObject);
    procedure btnOrdBaiAcrClick(Sender: TObject);
    procedure cxGridDescontoTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridAcrescimoTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridDescontoTableKeyPress(Sender: TObject; var Key: Char);
    procedure cxGridAcrescimoTableKeyPress(Sender: TObject; var Key: Char);
    procedure edtDescDesKeyPress(Sender: TObject; var Key: Char);
    procedure edtPercDesKeyPress(Sender: TObject; var Key: Char);
    procedure edtDescAcrKeyPress(Sender: TObject; var Key: Char);
    procedure edtPercAcrKeyPress(Sender: TObject; var Key: Char);
    procedure cxGridDescontoTableKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxGridAcrescimoTableKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FSeqGer: String;
    FTabPre: String;
    FHeranca: Boolean;

    procedure pInfoStatusGravacao(pgbStatus: TcxProgressBar;
      strInformacao: String; intMax: Integer = 0);
    procedure pStepStatusGravacao(pgbStatus: TcxProgressBar);

    procedure pAdicionaPolitica(tdTipo: TTipoDesconto);
    procedure pCarregaItemAlteracao(tdTipo: TTipoDesconto);
    procedure pDeletaPolitica(tdTipo: TTipoDesconto);

    procedure pOrdenaItem(cdsDataSet: TUniClientDataSet; cxGrid: TcxGridCitel;
      blnCima: Boolean);
    procedure pAtualizaOrdenacao(cdsDataSet: TUniClientDataSet;
      intOrdTmp: Integer; blnCima: Boolean);

    procedure pCriaClients;
    procedure pAfterScroll(DataSet: TDataSet);

    function fRetornaPoliticaDesconto(pgbStatus: TcxProgressBar): Boolean;
    function fRetornaPoliticaAcrescimo(pgbStatus: TcxProgressBar): Boolean;

    procedure pDeletandoPolitica(tdTipo: TTipoDesconto;
      strTabSeqGer, strTabPreP: String);
  public
    { Public declarations }
    cdsDesconto, cdsAcrescimo: TUniClientDataSet;

    procedure pCarregaPoliticas;
    procedure pCancelaPolitica(tdTipo: TTipoDesconto);
    function fGravaPoliticas(pgbStatus: TcxProgressBar): Boolean;

    procedure pAtualizaSeqGer(strSeqGer: String; strTabPre: String);
    procedure pCalculaTotal(cdsDataSet: TUniClientDataSet;
      tdTipo: TTipoDesconto);
  protected
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
  published
    property strSeqGer: String Read FSeqGer Write FSeqGer;
    property strTabPre: String Read FTabPre Write FTabPre;
    property blnHeranca: Boolean Read FHeranca Write FHeranca;
  end;

var
  frmPnlPoliticaDesAcr: TfrmPnlPoliticaDesAcr;

implementation

{$R *.dfm}

uses untFuncoesSimples, untGravando;

procedure TfrmPnlPoliticaDesAcr.btnAddAcrClick(Sender: TObject);
begin
  inherited;

  pAdicionaPolitica(tdAcrescimo);
end;

procedure TfrmPnlPoliticaDesAcr.btnAddDesClick(Sender: TObject);
begin
  inherited;

  pAdicionaPolitica(tdDesconto);
end;

procedure TfrmPnlPoliticaDesAcr.btnCancAcrClick(Sender: TObject);
begin
  inherited;

  pCancelaPolitica(tdAcrescimo);
end;

procedure TfrmPnlPoliticaDesAcr.btnCancDesClick(Sender: TObject);
begin
  inherited;

  pCancelaPolitica(tdDesconto);
end;

procedure TfrmPnlPoliticaDesAcr.btnOrdBaiAcrClick(Sender: TObject);
begin
  inherited;

  pOrdenaItem(cdsAcrescimo, cxGridAcrescimo, False);
end;

procedure TfrmPnlPoliticaDesAcr.btnOrdBaiDesClick(Sender: TObject);
begin
  inherited;

  pOrdenaItem(cdsDesconto, cxGridDesconto, False);
end;

procedure TfrmPnlPoliticaDesAcr.btnOrdCimAcrClick(Sender: TObject);
begin
  inherited;

  pOrdenaItem(cdsAcrescimo, cxGridAcrescimo, True);
end;

procedure TfrmPnlPoliticaDesAcr.btnOrdCimDesClick(Sender: TObject);
begin
  inherited;

  pOrdenaItem(cdsDesconto, cxGridDesconto, True);
end;

procedure TfrmPnlPoliticaDesAcr.cxGridAcrescimoTableCellDblClick
  (Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pCarregaItemAlteracao(tdAcrescimo);
end;

procedure TfrmPnlPoliticaDesAcr.cxGridAcrescimoTableKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Key = VK_DELETE Then
    pDeletaPolitica(tdAcrescimo);
end;

procedure TfrmPnlPoliticaDesAcr.cxGridAcrescimoTableKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = #13 Then
    pCarregaItemAlteracao(tdAcrescimo);
end;

procedure TfrmPnlPoliticaDesAcr.cxGridDescontoTableCellDblClick
  (Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pCarregaItemAlteracao(tdDesconto);
end;

procedure TfrmPnlPoliticaDesAcr.cxGridDescontoTableKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Key = VK_DELETE Then
    pDeletaPolitica(tdDesconto);
end;

procedure TfrmPnlPoliticaDesAcr.cxGridDescontoTableKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = #13 Then
    pCarregaItemAlteracao(tdDesconto);
end;

procedure TfrmPnlPoliticaDesAcr.edtDescAcrKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = #13 Then
    pSetFocus(edtPercAcr);
end;

procedure TfrmPnlPoliticaDesAcr.edtDescDesKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If Key = #13 Then
    pSetFocus(edtPercDes);
end;

procedure TfrmPnlPoliticaDesAcr.edtPercAcrKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = #13 Then
    pSetFocus(btnAddAcr);
end;

procedure TfrmPnlPoliticaDesAcr.edtPercDesKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If Key = #13 Then
    pSetFocus(btnAddDes);
end;

procedure TfrmPnlPoliticaDesAcr.FormCreate(Sender: TObject);
begin
  inherited;

  pCriaClients;
  dtsDesconto.DataSet  := cdsDesconto;
  dtsAcrescimo.DataSet := cdsAcrescimo;

  cdsDesconto.AfterScroll  := pAfterScroll;
  cdsAcrescimo.AfterScroll := pAfterScroll;
  cdsDesconto.Open;
  cdsAcrescimo.Open;

  FSeqGer := '';
  FTabPre := '';
  FHeranca := False;

  pCarregaPoliticas;
end;

procedure TfrmPnlPoliticaDesAcr.pAdicionaPolitica(tdTipo: TTipoDesconto);
  procedure pAddItem;
  Begin
    If tdTipo = tdDesconto Then
    Begin
      If cdsDesconto.State = dsEdit Then
      Begin
        cdsDesconto.FieldByName('TAB_DESCRI').AsString := edtDescDes.Text;
        cdsDesconto.FieldByName('TAB_PERCEN').AsFloat  := edtPercDes.Value;
        cdsDesconto.Post;
      End
      Else
      Begin
        With cdsDesconto Do
        Begin
          Append;
          FieldByName('AUTOINCREM').AsString  := '';
          FieldByName('TAB_SEQGER').AsString  := '';
          FieldByName('TAB_TABPRE').AsString  := strTabPre;
          FieldByName('TAB_DESCRI').AsString  := edtDescDes.Text;
          FieldByName('TAB_PERCEN').AsFloat   := edtPercDes.Value;
          FieldByName('TAB_TIPDES').AsString  := 'D';
          FieldByName('TAB_ORDDES').AsInteger := cdsDesconto.RecordCount + 1;
          Post;
        End;
      End;

      pCalculaTotal(cdsDesconto, tdTipo);
    End
    Else
    Begin
      If cdsAcrescimo.State = dsEdit Then
      Begin
        cdsAcrescimo.FieldByName('TAB_DESCRI').AsString := edtDescAcr.Text;
        cdsAcrescimo.FieldByName('TAB_PERCEN').AsFloat  := edtPercAcr.Value;
        cdsAcrescimo.Post;
      End
      Else
      Begin
        With cdsAcrescimo Do
        Begin
          Append;
          FieldByName('AUTOINCREM').AsString  := '';
          FieldByName('TAB_SEQGER').AsString  := '';
          FieldByName('TAB_TABPRE').AsString  := strTabPre;
          FieldByName('TAB_DESCRI').AsString  := edtDescAcr.Text;
          FieldByName('TAB_PERCEN').AsFloat   := edtPercAcr.Value;
          FieldByName('TAB_TIPDES').AsString  := 'A';
          FieldByName('TAB_ORDDES').AsInteger := cdsAcrescimo.RecordCount + 1;
          Post;
        End;
      End;

      pCalculaTotal(cdsAcrescimo, tdTipo);
    End;
  End;

begin
  If tdTipo = tdDesconto Then
  Begin
    If fValidaCampos(edtDescDes, True) And fValidaCampos(edtPercDes, True) Then
    Begin
      pAddItem;
      pCancelaPolitica(tdTipo);
    End;
  End
  Else
  Begin
    If fValidaCampos(edtDescAcr, True) And fValidaCampos(edtPercAcr, True) Then
    Begin
      pAddItem;
      pCancelaPolitica(tdTipo);
    End;
  End;
end;

function TfrmPnlPoliticaDesAcr.fRetornaPoliticaAcrescimo
  (pgbStatus: TcxProgressBar): Boolean;
Var
  qryTmp: TUniQuery;
begin
  Try
    If cdsAcrescimo.Active Then
      cdsAcrescimo.EmptyDataSet;

    qryTmp := fCriaQuery;

    With qryTmp Do
    Begin
      SQL.Clear;
      SQL.Add('SELECT * FROM TABNEG WHERE TAB_SEQGER = :SEQGER AND TAB_TIPDES = "A" AND TAB_TABPRE = :TABPRE ');
      ParamByName('SEQGER').AsString := FSeqGer;
      ParamByName('TABPRE').AsString := FTabPre;
      Open;

      If Not IsEmpty Then
      Begin
        If Not cdsAcrescimo.Active Then
          cdsAcrescimo.Open;

        pInfoStatusGravacao(pgbStatus, 'Aguarde, Carregando Políticas de Acréscimo...', qryTmp.RecordCount);
        First;

        While Not Eof Do
        Begin
          cdsAcrescimo.Append;

          If Not blnHeranca Then
            cdsAcrescimo.FieldByName('AUTOINCREM').AsString := FieldByName('AUTOINCREM').AsString;

          cdsAcrescimo.FieldByName('TAB_SEQGER').AsString  := FieldByName('TAB_SEQGER').AsString;
          cdsAcrescimo.FieldByName('TAB_TABPRE').AsString  := FieldByName('TAB_TABPRE').AsString;
          cdsAcrescimo.FieldByName('TAB_DESCRI').AsString  := FieldByName('TAB_DESCRI').AsString;
          cdsAcrescimo.FieldByName('TAB_PERCEN').AsFloat   := FieldByName('TAB_PERCEN').AsFloat;
          cdsAcrescimo.FieldByName('TAB_TIPDES').AsString  := FieldByName('TAB_TIPDES').AsString;
          cdsAcrescimo.FieldByName('TAB_ORDDES').AsInteger := FieldByName('TAB_ORDDES').AsInteger;
          cdsAcrescimo.Post;

          pStepStatusGravacao(pgbStatus);
          Application.ProcessMessages;

          Next;
        End;
      End;

      Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  FreeAndNil(qryTmp);
  pCalculaTotal(cdsAcrescimo, tdAcrescimo);
end;

function TfrmPnlPoliticaDesAcr.fRetornaPoliticaDesconto
  (pgbStatus: TcxProgressBar): Boolean;
Var
  qryTmp: TUniQuery;
begin
  Try
    If cdsDesconto.Active Then
      cdsDesconto.EmptyDataSet;

    qryTmp := fCriaQuery;

    With qryTmp Do
    Begin
      SQL.Clear;
      SQL.Add('SELECT * FROM TABNEG WHERE TAB_SEQGER = :SEQGER AND TAB_TIPDES = "D" AND TAB_TABPRE = :TABPRE ');
      ParamByName('SEQGER').AsString := FSeqGer;
      ParamByName('TABPRE').AsString := FTabPre;
      Open;

      If Not IsEmpty Then
      Begin
        If Not cdsDesconto.Active Then
          cdsDesconto.Open;

        pInfoStatusGravacao(pgbStatus, 'Aguarde, Carregando Política de Desconto...', qryTmp.RecordCount);
        First;

        While Not Eof Do
        Begin
          cdsDesconto.Append;

          If Not blnHeranca Then
            cdsDesconto.FieldByName('AUTOINCREM').AsString := FieldByName('AUTOINCREM').AsString;

          cdsDesconto.FieldByName('TAB_SEQGER').AsString  := FieldByName('TAB_SEQGER').AsString;
          cdsDesconto.FieldByName('TAB_TABPRE').AsString  := FieldByName('TAB_TABPRE').AsString;
          cdsDesconto.FieldByName('TAB_DESCRI').AsString  := FieldByName('TAB_DESCRI').AsString;
          cdsDesconto.FieldByName('TAB_PERCEN').AsFloat   := FieldByName('TAB_PERCEN').AsFloat;
          cdsDesconto.FieldByName('TAB_TIPDES').AsString  := FieldByName('TAB_TIPDES').AsString;
          cdsDesconto.FieldByName('TAB_ORDDES').AsInteger := FieldByName('TAB_ORDDES').AsInteger;
          cdsDesconto.Post;

          pStepStatusGravacao(pgbStatus);
          Application.ProcessMessages;

          Next;
        End;
      End;

      Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  FreeAndNil(qryTmp);
  pCalculaTotal(cdsDesconto, tdDesconto);
end;

function TfrmPnlPoliticaDesAcr.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtDescAcr) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtDescAcr.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Defina uma descrição.', ['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = edtPercAcr) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtPercAcr.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Defina um percentual de acréscimo.', ['&OK']);
        Result := False;
      End
      Else
      Begin
        If edtPercAcr.Value <= 0 Then
        Begin
          fMensagem('ATENÇÃO', 'O percentual de acréscimo deve ser maior que zero.', ['&OK']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtDescDes) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtDescDes.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Defina uma descrição.', ['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = edtPercDes) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtPercDes.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Defina um percentual de desconto.', ['&OK']);
        Result := False;
      End
      Else
      Begin
        If edtPercDes.Value <= 0 Then
        Begin
          fMensagem('ATENÇÃO', 'O percentual de desconto deve ser maior que zero.', ['&OK']);
          Result := False;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmPnlPoliticaDesAcr.pAfterScroll(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If FindField('TAB_PERCEN') <> nil Then
      TFloatField(FieldByName('TAB_PERCEN')).DisplayFormat := '#,##0.00';
  End;
end;

procedure TfrmPnlPoliticaDesAcr.pAtualizaOrdenacao
  (cdsDataSet: TUniClientDataSet; intOrdTmp: Integer; blnCima: Boolean);
begin
  With cdsDataSet Do
  Begin
    First;
    While Not Eof Do
    Begin
      Edit;
      FieldByName('TAB_ORDDES').AsInteger := RecNo - 1;
      Post;

      Next;
    End;
  End;
end;

procedure TfrmPnlPoliticaDesAcr.pAtualizaSeqGer(strSeqGer: String;
  strTabPre: String);
Var
  prcScroll: TprcScroll;

  procedure pAtualizaInterno(cdsDataSet: TUniClientDataSet);
  Begin
    With cdsDataSet Do
    Begin
      pDisableControls(cdsDataSet, prcScroll);

      First;
      While Not Eof Do
      Begin
        Edit;
        FieldByName('TAB_SEQGER').AsString := strSeqGer;
        FieldByName('TAB_TABPRE').AsString := strTabPre;
        Post;

        Next;
      End;

      pEnableControls(cdsDataSet, prcScroll);
    End;
  End;

begin
  pAtualizaInterno(cdsDesconto);
  pAtualizaInterno(cdsAcrescimo);
end;

procedure TfrmPnlPoliticaDesAcr.pCalculaTotal(cdsDataSet: TUniClientDataSet;
  tdTipo: TTipoDesconto);
Var
  prcScroll: TprcScroll;
  fltTotal: Double;
Begin
  fltTotal := 0.00;
  pDisableControls(cdsDataSet, prcScroll);

  With cdsDataSet Do
  Begin
    First;

    While Not Eof Do
    Begin
      fltTotal := fltTotal + FieldByName('TAB_PERCEN').AsFloat;
      Next;
    End;
  End;

  pEnableControls(cdsDataSet, prcScroll);

  If tdTipo = tdDesconto Then
    lblTotalDes.Caption := FormatFloat('#,##0.00', fltTotal)
  Else
    lblTotalAcr.Caption := FormatFloat('#,##0.00', fltTotal);
end;

procedure TfrmPnlPoliticaDesAcr.pCancelaPolitica(tdTipo: TTipoDesconto);
begin
  If tdTipo = tdDesconto Then
  Begin
    edtDescDes.Text := '';
    edtPercDes.Value := 0;
    pSetFocus(edtDescDes);
  End
  Else
  Begin
    edtDescAcr.Text := '';
    edtPercAcr.Value := 0;
    pSetFocus(edtDescAcr);
  End;
end;

procedure TfrmPnlPoliticaDesAcr.pCarregaItemAlteracao(tdTipo: TTipoDesconto);
begin
  If tdTipo = tdDesconto Then
  Begin
    With cdsDesconto Do
    Begin
      If Not IsEmpty Then
      Begin
        Edit;
        edtDescDes.Text  := FieldByName('TAB_DESCRI').AsString;
        edtPercDes.Value := FieldByName('TAB_PERCEN').AsFloat;
        pSetFocus(edtDescDes);
      End;
    End;
  End
  Else
  Begin
    With cdsAcrescimo Do
    Begin
      If Not IsEmpty Then
      Begin
        Edit;
        edtDescAcr.Text  := FieldByName('TAB_DESCRI').AsString;
        edtPercAcr.Value := FieldByName('TAB_PERCEN').AsFloat;
        pSetFocus(edtDescAcr);
      End;
    End;
  End;
end;

procedure TfrmPnlPoliticaDesAcr.pCarregaPoliticas;
Var
  frmAguarde: TfrmGravando;
begin
  If Not fEmptyStr(FSeqGer) Then
  Begin
    Try
      pCriarFormularios(TfrmGravando, frmAguarde);
      frmAguarde.fExecutarAcao := fRetornaPoliticaDesconto;
      frmAguarde.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;

    pFreeAndNil(frmAguarde);

    Try
      pCriarFormularios(TfrmGravando, frmAguarde);
      frmAguarde.fExecutarAcao := fRetornaPoliticaAcrescimo;
      frmAguarde.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;

    pFreeAndNil(frmAguarde);
  End;
end;

procedure TfrmPnlPoliticaDesAcr.pCriaClients;
begin
  cdsDesconto := TUniClientDataSet.Create(Self);

  With cdsDesconto, FieldDefs Do
  Begin
    With AddFieldDef Do
    Begin
      Name := 'AUTOINCREM';
      DataType := ftString;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'TAB_SEQGER';
      DataType := ftString;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'TAB_TABPRE';
      DataType := ftString;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'TAB_DESCRI';
      DataType := ftString;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'TAB_PERCEN';
      DataType := ftFloat;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'TAB_TIPDES';
      DataType := ftString;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'TAB_ORDDES';
      DataType := ftInteger;
      Required := False;
    End;

    IndexFieldNames := 'TAB_ORDDES';
    CreateDataSet;
  End;

  cdsAcrescimo := fCriaClientDatset(cdsDesconto, True, Self);
  cdsAcrescimo.IndexFieldNames := 'TAB_ORDDES';
end;

procedure TfrmPnlPoliticaDesAcr.pDeletandoPolitica(tdTipo: TTipoDesconto;
  strTabSeqGer, strTabPreP: String);
Var
  qryTmp: TUniQuery;
begin
  Try
    qryTmp := fCriaQuery;

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('DELETE FROM TABNEG WHERE TAB_SEQGER = :SEQGER AND TAB_TIPDES = :TIPDES AND TAB_TABPRE = :TABPRE ');
      ParamByName('SEQGER').AsString := strTabSeqGer;
      ParamByName('TABPRE').AsString := strTabPreP;
      ParamByName('TIPDES').AsString := IfThen(tdTipo = tdDesconto, 'D', 'A');
      ExecSQL;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  FreeAndNil(qryTmp);
end;

procedure TfrmPnlPoliticaDesAcr.pDeletaPolitica(tdTipo: TTipoDesconto);
begin
  If tdTipo = tdDesconto Then
  Begin
    If cdsDesconto.IsEmpty Then
      Exit;

    cdsDesconto.Delete;
    pAtualizaOrdenacao(cdsDesconto, -1, True);
    pCalculaTotal(cdsDesconto, tdTipo);
  End
  Else
  Begin
    If cdsAcrescimo.IsEmpty Then
      Exit;

    cdsAcrescimo.Delete;
    pAtualizaOrdenacao(cdsAcrescimo, -1, True);
    pCalculaTotal(cdsAcrescimo, tdTipo);
  End;
end;

procedure TfrmPnlPoliticaDesAcr.pInfoStatusGravacao(pgbStatus: TcxProgressBar;
  strInformacao: String; intMax: Integer);
begin
  If Assigned(pgbStatus) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strInformacao;

    If intMax > 0 Then
    Begin
      pgbStatus.Properties.Max := intMax;
      pgbStatus.Position := 0;
    End;

    Application.ProcessMessages;
  End;
end;

function TfrmPnlPoliticaDesAcr.fGravaPoliticas
  (pgbStatus: TcxProgressBar): Boolean;
Var
  qryInsert: TUniQuery;

  procedure pAddCampos(DataSet: TUniClientDataSet);
  Begin
    With DataSet Do
    Begin
      qryInsert.FieldByName('TAB_SEQGER').AsString  := FieldByName('TAB_SEQGER').AsString;
      qryInsert.FieldByName('TAB_TABPRE').AsString  := FieldByName('TAB_TABPRE').AsString;
      qryInsert.FieldByName('TAB_DESCRI').AsString  := FieldByName('TAB_DESCRI').AsString;
      qryInsert.FieldByName('TAB_PERCEN').AsFloat   := FieldByName('TAB_PERCEN').AsFloat;
      qryInsert.FieldByName('TAB_TIPDES').AsString  := FieldByName('TAB_TIPDES').AsString;
      qryInsert.FieldByName('TAB_ORDDES').AsInteger := FieldByName('TAB_ORDDES').AsInteger;
    End;
  End;

begin
  Result := False;

  pInfoStatusGravacao(pgbStatus, 'Aguarde, Deletando Política de Desconto...', 1);
  pDeletandoPolitica(tdDesconto, FSeqGer, FTabPre);
  pStepStatusGravacao(pgbStatus);
  Application.ProcessMessages;

  pInfoStatusGravacao(pgbStatus, 'Aguarde, Deletando Política de Acréscimo...', 1);
  pDeletandoPolitica(tdAcrescimo, FSeqGer, FTabPre);
  pStepStatusGravacao(pgbStatus);
  Application.ProcessMessages;

  pInfoStatusGravacao(pgbStatus, 'Aguarde, Gravando Política de Desconto...', cdsDesconto.RecordCount);

  Try
    qryInsert := fCriaQuery;

    qryInsert.SQL.Clear;
    qryInsert.SQL.Add('SELECT * FROM TABNEG WHERE FALSE');
    qryInsert.Open;

    With cdsDesconto Do
    Begin
      If Not IsEmpty then
      Begin
        First;

        While Not Eof Do
        Begin
          qryInsert.Append;

          If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
            qryInsert.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('TABNEG', VS_strCodEmp)
          Else
            qryInsert.FieldByName('AUTOINCREM').AsString := FieldByName('AUTOINCREM').AsString;

          pAddCampos(cdsDesconto);
          qryInsert.Post;

          Edit;
          FieldByName('AUTOINCREM').AsString := qryInsert.FieldByName('AUTOINCREM').AsString;
          Post;

          pStepStatusGravacao(pgbStatus);
          Application.ProcessMessages;

          Next;
        End;
      End;
    End;

    pInfoStatusGravacao(pgbStatus, 'Aguarde, Gravando Política de Acréscimo...', cdsAcrescimo.RecordCount);

    With cdsAcrescimo Do
    Begin
      If Not IsEmpty then
      Begin
        First;

        While Not Eof Do
        Begin
          qryInsert.Append;

          If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
            qryInsert.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('TABNEG', VS_strCodEmp)
          Else
            qryInsert.FieldByName('AUTOINCREM').AsString := FieldByName('AUTOINCREM').AsString;

          pAddCampos(cdsAcrescimo);
          qryInsert.Post;

          Edit;
          FieldByName('AUTOINCREM').AsString := qryInsert.FieldByName('AUTOINCREM').AsString;
          Post;

          pStepStatusGravacao(pgbStatus);
          Application.ProcessMessages;

          Next;
        End;
      End;
    End;

    Result := True;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  FreeAndNil(qryInsert);
end;

procedure TfrmPnlPoliticaDesAcr.pOrdenaItem(cdsDataSet: TUniClientDataSet;
  cxGrid: TcxGridCitel; blnCima: Boolean);
  Var
    prcScroll: TprcScroll;
    strDescri: String;

    procedure pMoveItemCima;
      Var
        strSeqAtu, strSeqAnt: String;
    begin
      If (cdsDataSet.RecNo <> 1) Then
      Begin
        strSeqAtu := cdsDataSet.FieldByName('TAB_ORDDES').AsString;

        cdsDataSet.Prior;

        strSeqAnt := cdsDataSet.FieldByName('TAB_ORDDES').AsString;

        cdsDataSet.Edit;
        cdsDataSet.FieldByName('TAB_ORDDES').AsString := strSeqAtu;
        cdsDataSet.Post;

        cdsDataSet.Prior;

        cdsDataSet.Edit;
        cdsDataSet.FieldByName('TAB_ORDDES').AsString := strSeqAnt;
        cdsDataSet.Post;
      End;
    End;

    procedure pMoveItemBaixo;
      Var
        strSeqAtu, strSeqAnt: String;
    begin
      If (cdsDataSet.RecordCount <> cdsDataSet.RecNo) Then
      Begin
        strSeqAtu := cdsDataSet.FieldByName('TAB_ORDDES').AsString;

        cdsDataSet.Next;

        strSeqAnt := cdsDataSet.FieldByName('TAB_ORDDES').AsString;

        cdsDataSet.Edit;
        cdsDataSet.FieldByName('TAB_ORDDES').AsString := strSeqAtu;
        cdsDataSet.Post;

        cdsDataSet.Prior;

        cdsDataSet.Edit;
        cdsDataSet.FieldByName('TAB_ORDDES').AsString := strSeqAnt;
        cdsDataSet.Post;
      End;
    End;
begin
  inherited;

  If cdsDataSet.IsEmpty Then
    fMensagem('ATENÇÃO', 'Não existem registros na grade para realizar a ordenação.', ['&OK'])
  Else
  Begin
    With cdsDataSet Do
    Begin
      strDescri := FieldByName('TAB_DESCRI').AsString;

      If blnCima Then
      Begin
        // Já esta no começo da lista
        If FieldByName('TAB_ORDDES').AsInteger = 1 Then
          Exit;
      End
      Else
      Begin
        // Já esta no fim da lista
        If FieldByName('TAB_ORDDES').AsInteger = RecordCount Then
          Exit;
      End;

      Try
        pDisableControls(cdsDataSet, prcScroll);

        If blnCima Then
          pMoveItemCima
        Else
          pMoveItemBaixo;
      Finally
        pEnableControls(cdsDataSet, prcScroll);
      End;

      cdsDataSet.Locate('TAB_DESCRI', strDescri, []);
    End;
  End;
end;

procedure TfrmPnlPoliticaDesAcr.pStepStatusGravacao(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

end.
