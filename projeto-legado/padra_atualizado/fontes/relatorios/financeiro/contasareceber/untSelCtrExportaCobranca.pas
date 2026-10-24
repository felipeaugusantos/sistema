unit untSelCtrExportaCobranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxCheckBox, System.UITypes,
  cxProgressBar, untGravando, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmSelCtrExportaCobranca = class(TfrmPai)
    grdReceberLevel1: TcxGridLevel;
    grdReceberTableView: TcxGridDBTableViewCitel;
    grdReceber: TcxGridCitel;
    dsrReceber: TDataSource;
    grdReceberTableViewCTR_NUMDUP: TcxGridDBColumn;
    grdReceberTableViewCTR_PARCEL: TcxGridDBColumn;
    grdReceberTableViewCTR_ESPDOC: TcxGridDBColumn;
    grdReceberTableViewCTR_CODEMP: TcxGridDBColumn;
    grdReceberTableViewCTR_CODCLI: TcxGridDBColumn;
    grdReceberTableViewCLI_NOMCLI: TcxGridDBColumn;
    grdReceberTableViewCTR_DTACAD: TcxGridDBColumn;
    grdReceberTableViewCTR_DTAVEN: TcxGridDBColumn;
    grdReceberTableViewCTR_VALORI: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    btnMarcarTodas: TBitBtnLocked;
    btnDesmarcarTodas: TBitBtnLocked;
    grdReceberTableViewCTR_VALDUP: TcxGridDBColumn;
    grdReceberTableViewMARDES: TcxGridDBColumn;
    btnGeraCSV: TBitBtnLocked;
    procedure btnMarcarTodasClick(Sender: TObject);
    procedure btnDesmarcarTodasClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure grdReceberTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdReceberTableViewDblClick(Sender: TObject);
    procedure grdReceberTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGeraCSVClick(Sender: TObject);
  private
    FDataSet: TDataSet;
    procedure SetDataSet(const Value: TDataSet);
    procedure pSeleciona(blnSelecionado: Boolean);
    procedure pSelecionaTodos(blnSelecionado: Boolean);
    function fGeraCSV(cxProgress : TcxProgressBar): Boolean;
  public
    property DataSet: TDataSet read FDataSet write SetDataSet;
  end;

implementation

uses untIFuncoes, untFuncoesSimples, untTEnvioEmail, untFuncoesRel, untFuncoesRel2;

{$R *.dfm}

{ TfrmSelCtrExportaCobranca }

procedure TfrmSelCtrExportaCobranca.btnMarcarTodasClick(Sender: TObject);
begin
  inherited;
  pSelecionaTodos(True);
end;

function TfrmSelCtrExportaCobranca.fGeraCSV(cxProgress: TcxProgressBar): Boolean;
Var
  strAutIncremento: String;

Begin

  Result := True;

  strAutIncremento := '';

  FDataSet.Filter := 'MARDES = ''S''';
  FDataSet.Filtered := TRUE;

  With FDataSet Do
  Begin

    First;

    While Not Eof Do
    Begin

      If (FieldByName('MARDES').AsString = 'S') Then
      Begin
        strAutIncremento := strAutIncremento + '_' + FieldByName('INCCTR').AsString;
      end;

      Next;

    End;

  End;

  FDataSet.Filtered := FALSE;

  If Assigned(prcExecutaRelatorio) Then
  begin
  prcExecutaRelatorio(270, 8790, [],
                       ['STRINC'],
                       [strAutIncremento],
                       nil,
                       nil,
                       False);
  End;

End;

procedure TfrmSelCtrExportaCobranca.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F7: Begin
              Key := 0;
              btnMarcarTodas.Click;
           End;
    VK_F8: Begin
              Key := 0;
              btnDesmarcarTodas.Click;
           End;
    VK_F10: Begin
              Key := 0;
              btnConfirma.Click;
            End;
    VK_F9: Begin
              Key := 0;
              btnGeraCSV.Click;
            End;
  End;
end;

procedure TfrmSelCtrExportaCobranca.grdReceberTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Var
  strMarcado: String;
begin
  inherited;
  With FDataSet Do
  Begin
    If (Not Active) Or (IsEmpty) Then
      Exit;

    If (FindField('MARDES') = Nil) Then
      Exit;

    strMarcado := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdReceberTableViewMARDES.Index]);

    If (strMarcado = 'S') Then
      ACanvas.Font.Color := clBlue;

    If ACanvas.Brush.Color = clHighLight Then
    Begin
      If strMarcado = 'S' Then
        ACanvas.Font.Color := clLime
      Else
        ACanvas.Font.Color := clWhite;
    End;

  End;
end;

procedure TfrmSelCtrExportaCobranca.grdReceberTableViewDblClick(
  Sender: TObject);
begin
  inherited;
  if FDataSet.FieldByName('MARDES').AsString = 'S' then
    pSeleciona(False)
  else
    pSeleciona(True);
end;

procedure TfrmSelCtrExportaCobranca.grdReceberTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    if FDataSet.FieldByName('MARDES').AsString = 'S' then
      pSeleciona(False)
    else
      pSeleciona(True);

    Key := VK_DOWN;
  End;
end;

procedure TfrmSelCtrExportaCobranca.pSeleciona(blnSelecionado: Boolean);
begin
  FDataSet.Edit;
  if blnSelecionado then
    FDataSet.FieldByName('MARDES').AsString := 'S'
  else
    FDataSet.FieldByName('MARDES').AsString := 'N';
  FDataSet.Post;
end;

procedure TfrmSelCtrExportaCobranca.pSelecionaTodos(blnSelecionado: Boolean);
var
  objBookmark: TBookmark;
begin
  FDataSet.DisableControls;
  objBookmark := FDataSet.GetBookmark;
  try
    FDataSet.First;
    while not FDataSet.Eof do
    Begin
      pSeleciona(blnSelecionado);
      FDataSet.Next;
    End;
  finally
    FDataSet.EnableControls;
    if FDataSet.BookmarkValid(objBookmark) then
      FDataSet.GotoBookmark(objBookmark);
  end;
end;

procedure TfrmSelCtrExportaCobranca.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk;
end;

procedure TfrmSelCtrExportaCobranca.btnDesmarcarTodasClick(Sender: TObject);
begin
  inherited;
  pSelecionaTodos(False);
end;

procedure TfrmSelCtrExportaCobranca.btnGeraCSVClick(Sender: TObject);
  Var
    frmAguarde: untGravando.TfrmGravando;
begin
  inherited;
  Try
    Try
      pCriarFormularios(untGravando.TfrmGravando, frmAguarde);
      frmAguarde.lblGravando.Caption := 'Gerando Arquivo...';
      frmAguarde.fExecutarAcao := fGeraCSV;
      frmAguarde.ShowModal;
    Finally
      FreeAndNil(frmAguarde);
    End;
  Except
    On E : Exception Do
      pMensagensErro(E.Message, 'TGeraExcel.fGerarRelatorio');
  End;
end;

procedure TfrmSelCtrExportaCobranca.SetDataSet(const Value: TDataSet);
begin
  FDataSet := Value;
  dsrReceber.DataSet := FDataSet;
end;



end.
