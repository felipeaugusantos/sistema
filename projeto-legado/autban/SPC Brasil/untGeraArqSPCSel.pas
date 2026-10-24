unit untGeraArqSPCSel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Data.DB, Vcl.Grids, Vcl.DBGrids,
  DBGridCitel, Vcl.StdCtrls, EditFocus, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, Uni, untFuncoesSimples, StrUtils, untFuncoes,
  cxDropDownEdit, cxDBLookupComboBox, cxEditRepositoryItems, UniClientDataSet, untConstantes,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmGeraArqSPCSel = class(TfrmPai)
    pnlTopo: TPanel;
    pnlTotais: TPanel;
    Label21: TLabel;
    Label9: TLabel;
    edtTotalDup: TEditFocus;
    edtTotalSelecionado: TEditFocus;
    pnlDadosDup: TPanel;
    lblCliente: TLabel;
    Nome: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    lblProtesta: TLabel;
    Label1: TLabel;
    edtCodCliBai: TEdit;
    edtNomCliBai: TEdit;
    edtCodPorBai: TEdit;
    edtNomPorBai: TEdit;
    edtNosNum: TEdit;
    edtHistor: TEdit;
    edtHistor2: TEdit;
    edtDesProtesta: TEdit;
    edtCodVel: TEdit;
    dbgDuplicatas: TcxGridCitel;
    dbgDuplicatasTableView1: TcxGridDBTableViewCitel;
    dbgDuplicatasTableView1CTR_NUMDUP: TcxGridDBColumn;
    dbgDuplicatasTableView1CTR_ESPDOC: TcxGridDBColumn;
    dbgDuplicatasTableView1CTR_CODEMP: TcxGridDBColumn;
    dbgDuplicatasTableView1CTR_DTAVEN: TcxGridDBColumn;
    dbgDuplicatasTableView1CTR_DTAREC: TcxGridDBColumn;
    dbgDuplicatasTableView1CTR_VALDUP: TcxGridDBColumn;
    dbgDuplicatasTableView1OCORRENCIA: TcxGridDBColumn;
    dbgDuplicatasLevel1: TcxGridLevel;
    btnSelTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    dbgDuplicatasTableView1CTR_MARCAD: TcxGridDBColumn;
    cxEditRepository: TcxEditRepository;
    imgcbxOcorrencia: TcxEditRepositoryImageComboBoxItem;
    dbgDuplicatasTableView1CTR_CODEVE: TcxGridDBColumn;
    gpbLegenda: TGroupBox;
    shp1: TShape;
    lbl1: TLabel;
    lbl3: TLabel;
    Shape1: TShape;
    Label6: TLabel;
    Label8: TLabel;
    dbgDuplicatasTableView1CTR_CLIENTE: TcxGridDBColumn;
    procedure dbgDuplicatasTableView1CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgDuplicatasTableView1CellDblClick(Sender: TcxCustomGridTableView;ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;AShift: TShiftState; var AHandled: Boolean);
    procedure dbgDuplicatasTableView1CellClick(Sender: TcxCustomGridTableView;ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;AShift: TShiftState; var AHandled: Boolean);
    procedure dbgDuplicatasTableView1KeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSelTodosClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnOrdemKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgDuplicatasTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure dbgDuplicatasTableView1OCORRENCIAPropertiesChange(Sender: TObject);
  private
    { Private declarations }
    procedure pCarregaClient;
  public
    { Public declarations }
    qryArqSPC: TUniQuery;
    cdsArqSPC: TUniClientDataSet;
    dtsArqSer: TDataSource;
    strOrdem: String;
    intOrdem: Integer;
    intOpcao: Integer;
    dtaDtaIni: TDateTime;
    dtaDtaFin: TDateTime;

    procedure pSelecionaDuplicataContasReceber;
    procedure pAtualizaDadosContasReceber;
    procedure pSelTodosContasReceber(blnMarca: Boolean = True);
    function fTotalDup: string;
    function fTotalDupSel: String;
    procedure pConfirmaDupSPC;
    procedure pCriarArquivoSPC;
    function fdupMarcadas: Boolean;
  end;

var
  frmGeraArqSPCSel: TfrmGeraArqSPCSel;

implementation

{$R *.dfm}

uses untBaixaBusca, untModuloCadCbi, untFuncAutban;

procedure TfrmGeraArqSPCSel.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  pCriarArquivoSPC;
end;

procedure TfrmGeraArqSPCSel.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  pSelTodosContasReceber(False);
end;

procedure TfrmGeraArqSPCSel.btnOrdemKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_Escape: btnSair.Click;
    VK_Space : pSelecionaDuplicataContasReceber;
    VK_F7    : btnSelTodos.Click;
    VK_F8    : btnDesmarcaTodos.Click;
    VK_F10   : btnConfirma.Click;
  End;
end;

procedure TfrmGeraArqSPCSel.btnSelTodosClick(Sender: TObject);
begin
  inherited;
  pSelTodosContasReceber;
end;

procedure TfrmGeraArqSPCSel.dbgDuplicatasTableView1CellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pAtualizaDadosContasReceber;
end;

procedure TfrmGeraArqSPCSel.dbgDuplicatasTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pSelecionaDuplicataContasReceber;
  pAtualizaDadosContasReceber;
end;

procedure TfrmGeraArqSPCSel.dbgDuplicatasTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  {*************************************************************}
  {* MUDA AS CORES DO GRID DE ACORDO COM A ORDEM DE A MARCACAO *}
  {**********************************************************MO*}
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasTableView1CTR_MARCAD.Index]) = 'M' Then
  Begin
    If (Not AViewInfo.Selected) Then
      ACanvas.Font.Color := clBlue
    Else
      ACanvas.Font.Color := clLime;
  End
  Else
  begin
    ACanvas.Brush.Color := clInfoBk;
    ACanvas.Font.Color := clWindowText;
  end;

  IF VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasTableView1CTR_DTAREC.Index]) <> '' then
    ACanvas.Font.Color := clRed;
end;

procedure TfrmGeraArqSPCSel.dbgDuplicatasTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_Escape: btnSair.Click;
    VK_Space : pSelecionaDuplicataContasReceber;

    VK_Return: Begin
                  pSelecionaDuplicataContasReceber;
                  pSetFocus(dbgDuplicatas);
                End;

    VK_F7    : btnSelTodos.Click;
    VK_F8    : btnDesmarcaTodos.Click;
    VK_F10   : btnConfirma.Click;
  End;
end;

procedure TfrmGeraArqSPCSel.dbgDuplicatasTableView1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  dbgDuplicatas.Refresh;
  pAtualizaDadosContasReceber;
end;

procedure TfrmGeraArqSPCSel.dbgDuplicatasTableView1OCORRENCIAPropertiesChange(
  Sender: TObject);
var
  AFocusedColumnIndex: Integer;
  texto: string;
begin
  inherited;
  pSetFocus(dbgDuplicatas);
  with dbgDuplicatasTableView1.Controller do
  begin
    AFocusedColumnIndex := FocusedColumnIndex;
    try
      FocusedColumn := dbgDuplicatasTableView1OCORRENCIA;
      EditingController.ShowEdit();
      Caption       := IntToStr(TcxComboBox(EditingController.Edit).ItemIndex);
      texto         := (TcxComboBox(EditingController.Edit).Text);

      cdsArqSPC.Edit;
      cdsArqSPC.FieldByName('OCORRENCIA').AsString := Texto;
      cdsArqSPC.Post;
    finally
      FocusedColumnIndex := AFocusedColumnIndex;
    end;
  end;
end;

procedure TfrmGeraArqSPCSel.FormActivate(Sender: TObject);
begin
  inherited;
  If intOpcao = 2 Then
  Begin
    dbgDuplicatasTableView1.Columns[7].Visible := True;
  End
  Else
  Begin
    dbgDuplicatasTableView1.Columns[7].Visible := False;
  End;
end;

procedure TfrmGeraArqSPCSel.FormCreate(Sender: TObject);
begin
  inherited;
  intOrdem := 1;
  qryArqSPC := fCriaQuery(Self);
end;

procedure TfrmGeraArqSPCSel.FormShow(Sender: TObject);
var
  intCont: Integer;
begin
  inherited;
  edtTotalSelecionado.Text := '0,00';

  If Not Assigned(cdsArqSPC) Then
  Begin
    cdsArqSPC := fCriaClientDatset(qryArqSPC, True);
  End;

  pCarregaClient;
  (cdsArqSPC.FieldByName('CTR_VALDUP') as TFloatField).DisplayFormat := '#,##0.00';

  dtsArqSer                := TDataSource.Create(Self);
  cdsArqSPC.ReadOnly       := False;
  dtsArqSer.DataSet        := cdsArqSPC;
  dbgDuplicatasTableView1.DataController.DataSource := dtsArqSer;

  For intCont := Low(ARR_OCORRENCIA_SPCBRASIL) to High(ARR_OCORRENCIA_SPCBRASIL) Do
  begin
    TcxComboBoxProperties(dbgDuplicatasTableView1OCORRENCIA.Properties).Items.Add(ARR_OCORRENCIA_SPCBRASIL[intCont][1]);
  end;

  pSetFocus(dbgDuplicatas);
  pAtualizaDadosContasReceber;
end;

procedure TfrmGeraArqSPCSel.pAtualizaDadosContasReceber;
begin
  edtCodCliBai.Text := cdsArqSPC.FieldByName('CTR_CODCLI').AsString;
  edtNomCliBai.Text := cdsArqSPC.FieldByName('CLI_NOMCLI').AsString;

  edtCodPorBai.Text := cdsArqSPC.FieldByName('CTR_CODPOR').AsString;
  edtNomPorBai.Text := cdsArqSPC.FieldByName('POR_NOMPOR').AsString;

  edtNosNum.Text    := cdsArqSPC.FieldByName('CTR_NOSNUM').AsString;
  edtHistor.Text    := cdsArqSPC.FieldByName('CTR_HIST01').AsString;
  edtHistor2.Text   := cdsArqSPC.FieldByName('CTR_HIST02').AsString;

  If cdsArqSPC.FieldByName('CTR_PROTES').AsString = 'N' Then
  Begin
    edtDesProtesta.Text    := 'Não';
    edtDesProtesta.Font.Color := clmoneygreen;
  End
  Else If cdsArqSPC.FieldByName('CTR_PROTES').AsString = 'S' Then
  Begin
    edtDesProtesta.Text    := 'Sim';
    edtDesProtesta.Font.Color := clRed;
  End
  Else
  Begin
    edtDesProtesta.Visible := False;
    lblProtesta.Visible    := False;
  End;

  edtCodVel.Text           := cdsArqSPC.FieldByName('CTR_CODVEL').AsString;
  edtTotalDup.Text         := fTotalDup;
end;

procedure TfrmGeraArqSPCSel.pSelecionaDuplicataContasReceber;
begin
  {*********************************************}
  {* VERIFICO SE A DUPLICATA JÁ ESTÁ NA CADCBI *}
  {******************************************MO*}
  If fTemNaCadCbi(cdsArqSPC.FieldByName('CTR_NUMDUP').AsString,
                  cdsArqSPC.FieldByName('CTR_ESPDOC').AsString,
                  cdsArqSPC.FieldByName('CTR_PARCEL').AsString,
                  cdsArqSPC.FieldByName('CTR_CODEMP').AsString,
                  cdsArqSPC.FieldByName('CTR_CODCLI').AsString,
                  'SPC')                                        Then
  Begin
    fMensagem('','Essa duplicata já foi selecinada para ser enviada ao SPC!', ['&OK']);
    Exit;
  End;

  {***********************************************}
  {* MARCA A DUPLICATA PARA SER GERADO O ARQUIVO *}
  {********************************************MO*}
  If cdsArqSPC.FieldByName('CTR_MARCAD').AsString = 'M' Then
  begin
    cdsArqSPC.Edit;
    cdsArqSPC.FieldByName('CTR_MARCAD').AsString := 'D';
    edtTotalSelecionado.Text := FormatFloat('#,##0.00', fStrToFloat(edtTotalSelecionado.Text) - cdsArqSPC.FieldByName('CTR_VALDUP').AsFloat);
    cdsArqSPC.Post;
  end
  else
  begin
    cdsArqSPC.Edit;
    cdsArqSPC.FieldByName('CTR_MARCAD').AsString := 'M';
    edtTotalSelecionado.Text := FormatFloat('#,##0.00', fStrToFloat(edtTotalSelecionado.Text) + cdsArqSPC.FieldByName('CTR_VALDUP').AsFloat);
    cdsArqSPC.Post;
  end;

  cdsArqSPC.Open;
end;

procedure TfrmGeraArqSPCSel.pSelTodosContasReceber(blnMarca: Boolean);
var
  fltMarcad: Double;
  blnMarcadas: Boolean;
begin
  dbgDuplicatas.BeginUpdate;
  cdsArqSPC.First;
  fltMarcad := 0;
  blnMarcadas := False;
  If blnMarca Then
  begin
    while Not cdsArqSPC.Eof do
    begin
      if cdsArqSPC.FieldByName('CTR_MARCAD').AsString = 'D' then
      begin
        {*********************************************}
        {* VERIFICO SE A DUPLICATA JÁ ESTÁ NA CADCBI *}
        {******************************************MO*}
        If not fTemNaCadCbi(cdsArqSPC.FieldByName('CTR_NUMDUP').AsString,
                            cdsArqSPC.FieldByName('CTR_ESPDOC').AsString,
                            cdsArqSPC.FieldByName('CTR_PARCEL').AsString,
                            cdsArqSPC.FieldByName('CTR_CODEMP').AsString,
                            cdsArqSPC.FieldByName('CTR_CODCLI').AsString,
                            'SPC')                                        Then
        Begin
          cdsArqSPC.Edit;
          cdsArqSPC.FieldByName('CTR_MARCAD').AsString := 'M';
          fltMarcad := fltMarcad + cdsArqSPC.FieldByName('CTR_VALDUP').AsFloat;
          cdsArqSPC.Post;
        End
        else
        begin
          if (not blnMarcadas) then
             blnMarcadas := True;
        end;
      end;
      cdsArqSPC.Next;
    end;

    if fltMarcad > 0 Then
      edtTotalSelecionado.Text := FormatFloat('#,##0.00', fStrToFloat(edtTotalSelecionado.Text) + fltMarcad);
  end
  else
  begin
    while Not cdsArqSPC.Eof do
    begin
      if cdsArqSPC.FieldByName('CTR_MARCAD').AsString = 'M' then
      begin
        cdsArqSPC.Edit;
        cdsArqSPC.FieldByName('CTR_MARCAD').AsString := 'D';
        fltMarcad := fltMarcad + cdsArqSPC.FieldByName('CTR_VALDUP').AsFloat;
        cdsArqSPC.Post;
      end;
      cdsArqSPC.Next;
    end;
    edtTotalSelecionado.Text := FormatFloat('#,##0.00', fStrToFloat(edtTotalSelecionado.Text) - fltMarcad);
  end;
  cdsArqSPC.Open;

  pAtualizaDadosContasReceber;
  pSetFocus(dbgDuplicatas);
  dbgDuplicatas.EndUpdate;

  if blnMarcadas then
      fMensagem('','Foram encontradas duplicatas já selecionadas para serem enviadas ao SPC! Essas duplicatas não foram marcadas.', ['&OK']);
end;

function TfrmGeraArqSPCSel.fTotalDup: string;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;
    strSQL := '';
    strSQL := strSQL + ' SELECT SUM(CTR_VALDUP) AS CTR_TOTDUP ';
    strSQL := strSQL + ' FROM TMP_GERSPC ';

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;
    Result := FormatFloat('#,##0.00', qryGen.FieldByName('CTR_TOTDUP').AsFloat);
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmGeraArqSPCSel.fTotalDupSel: String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  try
    qryGen := fCriaQuery;
    strSQL := '';
    strSQL := strSQL + ' SELECT SUM(CTR_VALDUP) AS CTR_TOTDUP ';
    strSQL := strSQL + ' FROM TMP_GERSPC ';
    strSQL := strSQL + ' WHERE CTR_MARCAD = "M" ';

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    Result := FormatFloat('#,##0.00', qryGen.FieldByName('CTR_TOTDUP').AsFloat);
  Finally
    FreeAndNil(qryGen);
  End;
END;

procedure TfrmGeraArqSPCSel.pCarregaClient;
begin
  qryArqSPC.First;
  while not qryArqSPC.Eof do
  begin
    cdsArqSPC.Insert;
    cdsArqSPC.FieldByName('CTR_NUMDUP1').AsString   := qryArqSPC.FieldByName('CTR_NUMDUP1').AsString;
    cdsArqSPC.FieldByName('CTR_NUMDUP').AsString   := qryArqSPC.FieldByName('CTR_NUMDUP').AsString;
    cdsArqSPC.FieldByName('CTR_PARCEL').AsString   := qryArqSPC.FieldByName('CTR_PARCEL').AsString;
    cdsArqSPC.FieldByName('CTR_ESPDOC').AsString   := qryArqSPC.FieldByName('CTR_ESPDOC').AsString;
    cdsArqSPC.FieldByName('CTR_DTACAD').AsDateTime := qryArqSPC.FieldByName('CTR_DTACAD').AsDateTime;

    if qryArqSPC.FieldByName('CTR_DTAREC').AsDateTime > 0 then
      cdsArqSPC.FieldByName('CTR_DTAREC').AsDateTime := qryArqSPC.FieldByName('CTR_DTAREC').AsDateTime
    else
      cdsArqSPC.FieldByName('CTR_DTAREC').Clear;

    cdsArqSPC.FieldByName('CTR_CODEVE').AsString   := qryArqSPC.FieldByName('CTR_CODEVE').AsString;
    cdsArqSPC.FieldByName('DTAREF').AsDateTime     := qryArqSPC.FieldByName('DTAREF').AsDateTime;
    cdsArqSPC.FieldByName('CTR_VALDUP').AsFloat    := qryArqSPC.FieldByName('CTR_VALDUP').AsFloat;
    cdsArqSPC.FieldByName('CTR_CLIENTE').AsString  := qryArqSPC.FieldByName('CTR_CLIENTE').AsString;
    cdsArqSPC.FieldByName('CTR_CODEMP').AsString   := qryArqSPC.FieldByName('CTR_CODEMP').AsString;
    cdsArqSPC.FieldByName('CTR_CODCLI').AsString   := qryArqSPC.FieldByName('CTR_CODCLI').AsString;
    cdsArqSPC.FieldByName('CLI_NOMCLI').AsString   := qryArqSPC.FieldByName('CLI_NOMCLI').AsString;
    cdsArqSPC.FieldByName('CTR_CODPOR').AsString   := qryArqSPC.FieldByName('CTR_CODPOR').AsString;
    cdsArqSPC.FieldByName('POR_NOMPOR').AsString   := qryArqSPC.FieldByName('POR_NOMPOR').AsString;
    cdsArqSPC.FieldByName('CTR_NOSNUM').AsString   := qryArqSPC.FieldByName('CTR_NOSNUM').AsString;
    cdsArqSPC.FieldByName('CTR_HIST01').AsString   := qryArqSPC.FieldByName('CTR_HIST01').AsString;
    cdsArqSPC.FieldByName('CTR_HIST02').AsString   := qryArqSPC.FieldByName('CTR_HIST02').AsString;
    cdsArqSPC.FieldByName('CTR_OBSAG1').AsString   := qryArqSPC.FieldByName('CTR_OBSAG1').AsString;
    cdsArqSPC.FieldByName('CTR_OBSAG2').AsString   := qryArqSPC.FieldByName('CTR_OBSAG2').AsString;
    cdsArqSPC.FieldByName('CTR_OBSAG3').AsString   := qryArqSPC.FieldByName('CTR_OBSAG3').AsString;
    cdsArqSPC.FieldByName('CTR_CODVEL').AsString   := qryArqSPC.FieldByName('CTR_CODVEL').AsString;
    cdsArqSPC.FieldByName('CTR_DTAVEN').AsDateTime := qryArqSPC.FieldByName('CTR_DTAVEN').AsDateTime;
    cdsArqSPC.FieldByName('CTR_MARCAD').AsString   := qryArqSPC.FieldByName('CTR_MARCAD').AsString;
    cdsArqSPC.FieldByName('CTR_PROTES').AsString   := qryArqSPC.FieldByName('CTR_PROTES').AsString;
    cdsArqSPC.FieldByName('CTR_DTASER').AsDateTime := qryArqSPC.FieldByName('CTR_DTASER').AsDateTime;
    cdsArqSPC.FieldByName('CTR_SEQBAI').AsInteger  := qryArqSPC.FieldByName('CTR_SEQBAI').AsInteger;
    cdsArqSPC.FieldByName('CLI_CGCCPF').AsInteger  := qryArqSPC.FieldByName('CLI_CGCCPF').AsInteger;
    cdsArqSPC.FieldByName('CLI_C_G_C_').AsString   := qryArqSPC.FieldByName('CLI_C_G_C_').AsString;
    cdsArqSPC.FieldByName('CLI_DTACAD').AsDateTime := qryArqSPC.FieldByName('CLI_DTACAD').AsDateTime;
    cdsArqSPC.FieldByName('CLI_STATUS').AsString   := qryArqSPC.FieldByName('CLI_STATUS').AsString;
    cdsArqSPC.FieldByName('CTR_CANCEL').AsString   := qryArqSPC.FieldByName('CTR_CANCEL').AsString;
    cdsArqSPC.FieldByName('DET_DEVOLV').AsString   := qryArqSPC.FieldByName('DET_DEVOLV').AsString;
    cdsArqSPC.FieldByName('OCORRENCIA').AsString   := qryArqSPC.FieldByName('OCORRENCIA').AsString;
    cdsArqSPC.Post;
    qryArqSPC.Next;
  end;
end;

procedure TfrmGeraArqSPCSel.pConfirmaDupSPC;
  Var
    qryConBco : TUniQuery;
begin
  If Not cdsArqSPC.IsEmpty Then
  Begin
    Try
      qryConBco := fCriaQuery;
      fStartTransaction;
      cdsArqSPC.DisableControls;

      With cdsArqSPC Do
      Begin
        First;

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          {***********************************}
          {* PASSA APENAS SE ESTIVER MARCADO *}
          {********************************MO*}
          If FieldByName('CTR_MARCAD').AsString = 'M' Then
          Begin
            frmModuloCadCbi.pGravaCadCbiGer(FieldByName('CTR_NUMDUP').AsString,
                                            FieldByName('CTR_PROTES').AsString,
                                            fRetCgcCpf(FieldByName('CTR_CODCLI').AsString),
                                            FieldByName('CTR_PARCEL').AsString,
                                            FieldByName('CTR_ESPDOC').AsString,
                                            FieldByName('CTR_CODEMP').AsString,
                                            FieldByName('CTR_CODCLI').AsString,
                                            'SPC',
                                            '',
                                            '',
                                            '',
                                            FieldByName('CTR_DTACAD').AsDateTime,
                                            FieldByName('CTR_DTAVEN').AsDateTime,
                                            FieldByName('CTR_VALDUP').AsCurrency,
                                            0,
                                            FieldByName('CTR_OBSAG1').AsString,
                                            FieldByName('CTR_OBSAG2').AsString,
                                            FieldByName('CTR_OBSAG3').AsString,
                                            '',
                                            '',
                                            0,
                                            '',
                                            '',
                                            IIF(intOpcao = 1, 'I', 'E'),
                                            dtaDtaIni,
                                            dtaDtaFin,
                                            IIF(intOpcao = 1, '', Copy(FieldByName('OCORRENCIA').AsString,1,2) ));
          End;

          Next;
        End;

        fCommit;
        fMensagem('','Seleção efetuada com sucesso!',['&O K']);

        cdsArqSPC.EnableControls;
        btnSair.Click;
      End;

    Except
      On E:Exception Do
      Begin
        fRollBack;
        fMensagem('','Ocorreu um erro ao tentar gravar os dados!' + #13#10 + E.Message,['&O K']);
      End;
    End;

    FreeAndNil(qryConBco);
  End;

end;

procedure TfrmGeraArqSPCSel.pCriarArquivoSPC;
Begin
  If fdupMarcadas Then
  Begin
    pConfirmaDupSPC;
    Close;
  End
  Else
    fMensagem(Application.Title, 'Não existem duplicatas selecionadas', ['&O K']);
END;

function TfrmGeraArqSPCSel.fdupMarcadas: Boolean;
Begin
  dbgDuplicatas.BeginUpdate;
  Result := False;

  cdsArqSPC.First;
  while Not cdsArqSPC.Eof do
  begin
    if cdsArqSPC.FieldByName('CTR_MARCAD').AsString = 'M' then
    begin
      Result := True;
      dbgDuplicatas.EndUpdate;
      Exit;
    end;

    cdsArqSPC.Next;
  end;
  dbgDuplicatas.EndUpdate;
end;

end.
