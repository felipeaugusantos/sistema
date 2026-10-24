unit untImportCadNOPConfirma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Data.DB, untZClient, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, Uni,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxGridCitel, cxCurrencyEdit, cxContainer, cxProgressBar,
  cxCheckBox, System.StrUtils;

type
  TAcaoImpCadNop = (tpSem, tpInserir,  tpAtualizar);

  TfrmImportCadNOPConfirma = class(TfrmPaiConfirma)
    dtsCadNop: TDataSource;
    grpLegenda: TGroupBox;
    Shape2: TShape;
    Shape3: TShape;
    Label2: TLabel;
    Label3: TLabel;
    cxgNopDBTableView1: TcxGridDBTableView;
    cxgNopLevel1: TcxGridLevel;
    cxgNop: TcxGrid;
    cxgNopDBCODPAI: TcxGridDBColumn;
    cxgNopDBCODNCM: TcxGridDBColumn;
    cxgNopDBCODITE: TcxGridDBColumn;
    cxgNopDBACAO: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxgNopDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
    qryExec: TUniQuery;
    function fGetAcao(strAcaoStr: String): TAcaoImpCadNop;
  protected
    procedure pGravaCadNop;
    function fInsereNops(pgbProgresso: TcxProgressBar): Boolean;
    function fTrataVazio(strValor: Variant; ValorDef: Variant ): Variant;
  public
    { Public declarations }
    cdsCadNop: TZClient;
    blnOk: Boolean;
  end;

implementation

uses
  untGravando,
  untFuncoesSimples;

{$R *.dfm}

function TfrmImportCadNOPConfirma.fGetAcao(strAcaoStr: String): TAcaoImpCadNop;
begin
  Result := tpSem;
  case AnsiIndexStr(strAcaoStr, ['I', 'A', '']) of
   0: Result := tpInserir;
   1: Result := tpAtualizar;
   2: Result := tpSem;
  end;
End;

procedure TfrmImportCadNOPConfirma.btnConfirmaClick(Sender: TObject);
  Var
    frmIns : TfrmGravando;
begin
  inherited;

  If cdsCadNop.RecordCount > 0 then
  Begin
    pCriarFormularios(TfrmGravando, frmIns);
    Try
      frmIns.fExecutarAcao := fInsereNops;
      frmIns.lblGravando.Caption := 'Aguarde... Processando NCMs...';
      frmIns.Showmodal;

      If blnOk Then
        pMensagemOk('Processo concluído com êxito!');
    Finally
      pFreeAndNil(frmIns);
    End;
  End;
end;

procedure TfrmImportCadNOPConfirma.cxgNopDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strAcao: String;
    AcaoImpCadNop : TAcaoImpCadNop;
begin
  inherited;

  If cdsCadNop.RecordCount = 0 Then
    Exit;

  strAcao := VarToString(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgNopDBACAO.Index]);

  AcaoImpCadNop := fGetAcao(strAcao);
  ACanvas.Font.Color := clBlack;

  Case AcaoImpCadNop Of
    tpInserir:  ACanvas.Brush.Color := clAqua;
    tpAtualizar: ACanvas.Brush.Color := clYellow;
    Else
      ACanvas.Brush.Color := clMoneyGreen;
  End;
end;

function TfrmImportCadNOPConfirma.fInsereNops(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := False;
  pgbProgresso.Properties.Max := cdsCadNop.RecordCount;

  blnOk := False;

  cdsCadNop.First;
  cdsCadNop.DisableControls;
  Try
    fStartTransaction;
    Try
      While Not cdsCadNop.Eof Do
      Begin
        pGravaCadNop;
        cdsCadNop.Next;
      End;
      fCommit;
      blnOk := True;
      Result := True;
    Except
      On e: Exception do
      Begin
        fRollBack;
        pMensagensErro(e.Message, '[TfrmImportCadNOPConfirma.fInsereNops]');
      End;
    End
  Finally
    cdsCadNop.EnableControls;
  End;
end;

procedure TfrmImportCadNOPConfirma.FormCreate(Sender: TObject);
begin
  inherited;
  qryExec := fCriaQuery;
  blnOk := False;
end;

procedure TfrmImportCadNOPConfirma.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryExec);
end;

procedure TfrmImportCadNOPConfirma.FormShow(Sender: TObject);
begin
  inherited;
  dtsCadNop.DataSet := cdsCadNop;
  cxgNopDBTableView1.ApplyBestFit;
end;

procedure TfrmImportCadNOPConfirma.pGravaCadNop;
  Var
    blnInclusao : Boolean;
    strAutInc : String;

  Const
    cFieldsIns =  'AUTOINCREM, NOP_CODPAI, NOP_CODNCM, NOP_CODITE';
    cParamnsIns = ':AUTOINCREM, :NOP_CODPAI, :NOP_CODNCM, :NOP_CODITE';

    cUpdate  = ' NOP_CODPAI = :NOP_CODPAI,' +
               ' NOP_CODNCM = :NOP_CODNCM,' +
               ' NOP_CODITE = :NOP_CODITE';
begin
  blnInclusao := cdsCadNop.FieldByName('ACAO').AsString = 'I';
  qryExec.SQL.Clear;

  If blnInclusao Then
  Begin
    qryExec.SQL.Add('INSERT CADNOP (' + cFieldsIns + ') VALUES ('+cParamnsIns+')');
    strAutInc := fRetAutoIncrem('CADNOP', VS_StrCodEmp);
  End
  Else
  Begin
    strAutInc := cdsCadNop.FieldByName('AUTOINCREM').AsString;
    qryExec.SQL.Add('UPDATE CADNOP SET ' + cUpdate);
    qryExec.SQL.Add(' WHERE AUTOINCREM = :AUTOINCREM');
  End;

  qryExec.ParamByName('AUTOINCREM').AsString := strAutInc;
  qryExec.ParamByName('NOP_CODPAI').AsString := cdsCadNop.FieldByName('NOP_CODPAI').AsString;
  qryExec.ParamByName('NOP_CODITE').AsString := cdsCadNop.FieldByName('NOP_CODITE').AsString;
  qryExec.ParamByName('NOP_CODNCM').AsString := cdsCadNop.FieldByName('NOP_CODNCM').AsString;

  qryExec.ExecSQL;
end;

function TfrmImportCadNOPConfirma.fTrataVazio(strValor: Variant; ValorDef: Variant): Variant;
begin
  If strValor = null Then
    Exit(ValorDef);

  If VarToStrDef(strValor, '') = '' Then
    Result := ValorDef
  Else
     Result := strValor;
end;

end.





