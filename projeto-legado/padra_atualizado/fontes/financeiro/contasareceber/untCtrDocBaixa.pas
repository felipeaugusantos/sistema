unit untCtrDocBaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, EditFocus, Uni, UniClientDataSet,
  UniDataSetProvider;

type
  TfrmCtrDocBaixa = class(TfrmPai)
    dbgDuplicatas: TcxGrid;
    dbgDuplicatasDBTableView1: TcxGridDBTableView;
    dbgDuplicatasNUMDUP: TcxGridDBColumn;
    dbgDuplicatasESPDOC: TcxGridDBColumn;
    dbgDuplicatasCODCLI: TcxGridDBColumn;
    dbgDuplicatasCLIENTE: TcxGridDBColumn;
    dbgDuplicatasEMPRESA: TcxGridDBColumn;
    dbgDuplicatasDTACAD: TcxGridDBColumn;
    dbgDuplicatasDTAVEN: TcxGridDBColumn;
    dbgDuplicatasPORTADOR: TcxGridDBColumn;
    dbgDuplicatasNOSNUM: TcxGridDBColumn;
    dbgDuplicatasVALOR_: TcxGridDBColumn;
    dbgDuplicatasLevel1: TcxGridLevel;
    dbgDuplicatasPARCEL: TcxGridDBColumn;
    dbgDuplicatasSEQBAI: TcxGridDBColumn;
    lblTotal: TLabel;
    edtValorTotal: TEditFocus;
    dbgDuplicatasFORNECEDOR: TcxGridDBColumn;
    dbgDuplicatasCODFOR: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSairClick(Sender: TObject);
    procedure dbgDuplicatasDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    FSeqCon: Integer;
    FEmpBai: String;
    cdsCta : TUniClientDataSet;
    dtsCta: TDataSource;
    FNomeTabela: String;
    procedure pCriaTemporaria;
    procedure SetSeqCon(const Value: Integer);
    procedure SetEmpBai(const Value: String);
  public
    property SeqCon: Integer read FSeqCon write SetSeqCon;
    property EmpBai: String read FEmpBai write SetEmpBai;
    property NomeTabela: String read FNomeTabela write FNomeTabela;
  end;

var
  frmCtrDocBaixa: TfrmCtrDocBaixa;

implementation

uses
  untFuncoesSimples, untGravando;

{$R *.dfm}

procedure TfrmCtrDocBaixa.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCtrDocBaixa.dbgDuplicatasDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Var
  fltValor_: Double;
begin
  inherited;

  if SameText('Valor Recebido', AViewInfo.Item.Caption) or
     SameText('Valor Pago', AViewInfo.Item.Caption) Then
  Begin
    fltValor_ := Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasVALOR_.Index];
    If (fltValor_ < 0) Then
      ACanvas.Font.Color := clRed;
  End;
end;

procedure TfrmCtrDocBaixa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(cdsCta);
end;

procedure TfrmCtrDocBaixa.FormCreate(Sender: TObject);
begin
  inherited;
  cdsCta := TUniClientDataSet.Create(Self);
  dtsCta := fCriaDataSource(cdsCta);

  cdsCta.AggregatesActive := True;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_VALOR_';
    FieldName     := 'TOT_VALOR_';
    DataSet       := cdsCta;
    Expression    := 'SUM(VALOR_)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;

  dbgDuplicatasDBTableView1.DataController.DataSource := dtsCta;
end;

procedure TfrmCtrDocBaixa.FormShow(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(pCriaTemporaria,'Aguarde... Carregando Títulos','');
  cdsCta.EnableControls;
  dbgDuplicatas.Refresh;
end;

procedure TfrmCtrDocBaixa.pCriaTemporaria;
  Var
    strSQL   : String;
    qryCta: TUniQuery;
    dspCta: TUniDataSetProvider;
begin
  Try
    cdsCta.Filter   := '';
    cdsCta.Filtered := False;
    cdsCta.Close;
    qryCta := fCriaQuery(Self);
    dspCta := TUniDataSetProvider.Create(Self);
    dspCta.DataSet := qryCta;
    cdsCta.SetProvider(dspCta);


    strSQL := 'SELECT ';
    strSQL := strSQL + 'CTA.CTR_CODCLI AS CODCLI, ';
    strSQL := strSQL + 'L.CLI_NOMCLI AS CLIENTE, ';
    strSQL := strSQL + 'CTA.CTR_NUMDUP AS NUMDUP, ';
    strSQL := strSQL + 'CTR_ESPDOC AS ESPDOC, ';
    strSQL := strSQL + 'CTR_PARCEL AS PARCEL, ';
    strSQL := strSQL + 'CTA.CTR_SEQBAI AS SEQBAI, ';
    strSQL := strSQL + 'CONCAT(CTA.CTR_EMPBAI, " - ", E.EMP_NOMEMP) AS EMPRESA, ';
    strSQL := strSQL + 'CTA.CTR_DTACAD AS DTACAD, ';
    strSQL := strSQL + 'CTA.CTR_DTAVEN AS DTAVEN, ';
    strSQL := strSQL + 'CONCAT(CTA.CTR_PORBAI, " - ", P.POR_NOMPOR) AS PORTADOR, ';
    strSQL := strSQL + 'CTR_NOSNUM AS NOSNUM, ';
    strSQL := strSQL + 'CTA.CTR_VALREC AS VALOR_ ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + NomeTabela+' AS CTA ';
    strSQL := strSQL + 'JOIN CADPOR P ON CTA.CTR_PORBAI = P.POR_CODPOR ';
    strSQL := strSQL + 'JOIN CADCLI L ON CTA.CTR_CODCLI = L.CLI_CODCLI ';
    strSQL := strSQL + 'JOIN CADEMP E ON CTA.CTR_EMPBAI = E.EMP_CODEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + 'CTA.CTR_SEQCON = :SEQCON AND CTA.CTR_EMPBAI = :EMPBAI ';
    strSQL := strSQL + 'ORDER BY CTA.CTR_VALREC ';

    if NomeTabela = 'CADPAG' then
    begin
      strSQL := StringReplace(strSQL, 'CTR_ESPDOC', '""',         [rfReplaceAll]);
      strSQL := StringReplace(strSQL, 'CTR_NOSNUM', '""',         [rfReplaceAll]);
      strSQL := StringReplace(strSQL, '_VALREC',    '_VALPAG',    [rfReplaceAll]);
      strSQL := StringReplace(strSQL, 'NOMCLI',     'NOMFOR',     [rfReplaceAll]);
      strSQL := StringReplace(strSQL, 'CODCLI',     'CODFOR',     [rfReplaceAll]);
      strSQL := StringReplace(strSQL, 'CADCLI',     'CADFOR',     [rfReplaceAll]);
      strSQL := StringReplace(strSQL, 'CLIENTE',    'FORNECEDOR', [rfReplaceAll]);
      strSQL := StringReplace(strSQL, 'CTR_',       'CTP_',       [rfReplaceAll]);
      strSQL := StringReplace(strSQL, 'CLI_',       'FOR_',       [rfReplaceAll]);

      dbgDuplicatasVALOR_     .Caption := 'Valor Pago';
      dbgDuplicatasNOSNUM     .Visible := False;
      dbgDuplicatasESPDOC     .Visible := False;
      dbgDuplicatasCODCLI     .Visible := False;
      dbgDuplicatasCLIENTE    .Visible := False;
      dbgDuplicatasCODFOR     .Visible := True;
      dbgDuplicatasFORNECEDOR .Visible := True;
      lblTotal                .Caption := 'Total Pago:';
    end;

    With qryCta Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQCON').AsInteger := SeqCon;
      ParamByName('EMPBAI').AsString := EmpBai;
      Open;

      Application.ProcessMessages;

      If Not IsEmpty Then
      Begin
        pSetaClient(qryCta);
        With cdsCta Do
        Begin
          Open;
          (FieldByName('VALOR_') As TFloatField).DisplayFormat := ',0.00';
          edtValorTotal.Text := FormatCurr(',0.00', StrToFloat(FieldByName('TOT_VALOR_').AsString));
          First;
        End;
      End;
      Close;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;

  Application.ProcessMessages;
  cdsCta.SetProvider(nil);
  FreeAndNil(dspCta);
  FreeAndNil(qryCta);
end;

procedure TfrmCtrDocBaixa.SetEmpBai(const Value: String);
begin
  FEmpBai := Value;
end;

procedure TfrmCtrDocBaixa.SetSeqCon(const Value: Integer);
begin
  FSeqCon := Value;
end;

end.
