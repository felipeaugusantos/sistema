unit untImportAliquotaIBPTConfirma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Data.DB, untZClient,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, System.StrUtils, Uni,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, cxProgressBar;

type
  TAcaoCadAliIBPT = (tpSem, tpInserir,  tpAtualizar);

  TfrmImportAliquotaIBPTConfirma = class(TfrmPaiConfirma)
    cxgAliqIBPT: TcxGrid;
    cxgAliqIBPTDBTableView1: TcxGridDBTableView;
    cxgAliqIBPTLevel1: TcxGridLevel;
    cxgAliqIBPTDBTableView1Estado: TcxGridDBColumn;
    cxgAliqIBPTDBTableView1NCM: TcxGridDBColumn;
    cxgAliqIBPTDBTableView1EX: TcxGridDBColumn;
    cxgAliqIBPTDBTableView1AlqNac: TcxGridDBColumn;
    cxgAliqIBPTDBTableView1AlqImp: TcxGridDBColumn;
    cxgAliqIBPTDBTableView1AlqEst: TcxGridDBColumn;
    cxgAliqIBPTDBTableView1AlqMun: TcxGridDBColumn;
    grpLegenda: TGroupBox;
    Shape2: TShape;
    Shape3: TShape;
    Label2: TLabel;
    Label3: TLabel;
    cxgAliqIBPTDBTableView1Acao: TcxGridDBColumn;
    dtsCadIbp: TDataSource;
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxgAliqIBPTDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    blnOk: Boolean;
    qryExec: TUniQuery;
    function fInsereAliquotaIBPT(pgbProgresso: TcxProgressBar): Boolean;
    procedure pGravaAliquotaIBPT;
  public
    cdsCadIbp: TZClient;
  end;

  function fGetAcao(AAcaoStr: String): TAcaoCadAliIBPT;

var
  frmImportAliquotaIBPTConfirma: TfrmImportAliquotaIBPTConfirma;

implementation

uses
  untFuncoesSimples, untGravando;

function fGetAcao(AAcaoStr: String): TAcaoCadAliIBPT;
begin
  Result := tpSem;
  case AnsiIndexStr(AAcaoStr, ['I', 'A', '']) of
   0: Result := tpInserir;
   1: Result := tpAtualizar;
   2: Result := tpSem;
  end;
End;

{$R *.dfm}

procedure TfrmImportAliquotaIBPTConfirma.btnConfirmaClick(Sender: TObject);
var
  frmIns: TfrmGravando;
begin
  inherited;
  If cdsCadIbp.RecordCount > 0 then
  Begin
    pCriarFormularios(TfrmGravando, frmIns);
    Try
      frmIns.fExecutarAcao := fInsereAliquotaIBPT;
      frmIns.lblGravando.Caption :=
        'Aguarde... processando Alíquotas IBPT...';
      frmIns.Showmodal;
      If blnOk Then
        pMensagemOk('Processo concluído com êxito!');
    Finally
      pFreeAndNil(frmIns);
    End;
  End;
end;

function TfrmImportAliquotaIBPTConfirma.fInsereAliquotaIBPT(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := False;
  pgbProgresso.Properties.Max := cdsCadIbp.RecordCount;
  cdsCadIbp.First;
  cdsCadIbp.DisableControls;
  fStartTransaction;
  blnOk := False;
  Try
    Try
      While not cdsCadIbp.Eof Do
      Begin
        pGravaAliquotaIBPT;

        cdsCadIbp.Next;
      End;
      fCommit;
      blnOk := True;
      Result := True;
    Except
      On e: Exception do
      Begin
        fRollBack;
        pMensagensErro(e.Message, '[TfrmImportAliquotaIBPTConfirma.fInsereAliquotaIBPT]');
      End;
    End

  Finally
    cdsCadIbp.EnableControls;
  End;
end;

procedure TfrmImportAliquotaIBPTConfirma.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryExec);
end;

procedure TfrmImportAliquotaIBPTConfirma.FormCreate(Sender: TObject);
begin
  inherited;
  qryExec := fCriaQuery;
  blnOk := False;
end;

procedure TfrmImportAliquotaIBPTConfirma.FormShow(Sender: TObject);
begin
  inherited;
  dtsCadIbp.DataSet := cdsCadIbp;
end;

procedure TfrmImportAliquotaIBPTConfirma.pGravaAliquotaIBPT;
var
  blnInclusao: Boolean;
  strAutInc: String;
const
  cFieldsIns =  'AUTOINCREM, IBP_N_C_M_, IBP_ALQNAC, IBP_ALQIMP, IBP_ESTADO, IBP_ALQEST, IBP_ALQMUN, IBP_E_X___, IBP_ULTALT';
  cParamnsIns = ':AUTOINCREM, :IBP_N_C_M_, :IBP_ALQNAC, :IBP_ALQIMP, :IBP_ESTADO, :IBP_ALQEST, :IBP_ALQMUN, :IBP_E_X___, :IBP_ULTALT';

  cUpdate  = ' IBP_ALQNAC = :IBP_ALQNAC,' +
             ' IBP_ALQIMP = :IBP_ALQIMP,' +
             ' IBP_ALQEST = :IBP_ALQEST,' +
             ' IBP_ALQMUN = :IBP_ALQMUN,' +
             ' IBP_ULTALT = :IBP_ULTALT';

begin
  blnInclusao := cdsCadIbp.FieldByName('ACAO').AsString = 'I';
  qryExec.SQL.Clear;
  If blnInclusao Then
  Begin
    qryExec.SQL.Add('INSERT CADIBP (' + cFieldsIns + ') VALUES ('+cParamnsIns+')');
    strAutInc := fRetAutoIncrem('CADIBP', VS_StrCodEmp);
  End
  Else
  Begin
    strAutInc := cdsCadIbp.FieldByName('AUTOINCREM').AsString;
    qryExec.SQL.Add('UPDATE CADIBP SET ' + cUpdate);
    qryExec.SQL.Add(' WHERE AUTOINCREM = :AUTOINCREM');
  End;

  qryExec.ParamByName('AUTOINCREM').AsString := strAutInc;

  If blnInclusao THen
  Begin
    qryExec.ParamByName('IBP_N_C_M_').AsString := cdsCadIbp.FieldByName('IBP_N_C_M_').AsString;
    qryExec.ParamByName('IBP_ESTADO').AsString := cdsCadIbp.FieldByName('IBP_ESTADO').AsString;
    qryExec.ParamByName('IBP_E_X___').AsString := cdsCadIbp.FieldByName('IBP_E_X___').AsString;
  End;

  qryExec.ParamByName('IBP_ALQNAC').AsFloat := cdsCadIbp.FieldByName('IBP_ALQNAC').AsFloat;
  qryExec.ParamByName('IBP_ALQIMP').AsFloat := cdsCadIbp.FieldByName('IBP_ALQIMP').AsFloat;
  qryExec.ParamByName('IBP_ALQEST').AsFloat := cdsCadIbp.FieldByName('IBP_ALQEST').AsFloat;
  qryExec.ParamByName('IBP_ALQMUN').AsFloat := cdsCadIbp.FieldByName('IBP_ALQMUN').AsFloat;
  qryExec.ParamByName('IBP_ULTALT').AsDate := Date;

  qryExec.ExecSQL;
end;

procedure TfrmImportAliquotaIBPTConfirma.cxgAliqIBPTDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strAcao: String;
  AcaoCadAliIBPT : TAcaoCadAliIBPT;
begin
  inherited;
  If cdsCadIbp.RecordCount = 0 Then
    Exit;

  strAcao := VarToString(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgAliqIBPTDBTableView1Acao.Index]);

  AcaoCadAliIBPT := fGetAcao(strAcao);
  ACanvas.Font.Color := clBlack;

  Case AcaoCadAliIBPT Of
    tpInserir:  ACanvas.Brush.Color := clAqua;
    tpAtualizar: ACanvas.Brush.Color := clYellow;
    Else
      ACanvas.Brush.Color := clMoneyGreen;
  End;
end;

end.
