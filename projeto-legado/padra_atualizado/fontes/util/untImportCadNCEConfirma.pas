unit untImportCadNCEConfirma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Data.DB, untZClient, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, Uni,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxGridCitel, cxCurrencyEdit, cxContainer, cxProgressBar,
  cxCheckBox, System.StrUtils;

type
  TAcaoImpCadNce = (tpSem, tpInserir, tpAtualizar);

  TfrmImportCadNCEConfirma = class(TfrmPaiConfirma)
    dtsCadNce: TDataSource;
    grpLegenda: TGroupBox;
    Shape2: TShape;
    Shape3: TShape;
    Label2: TLabel;
    Label3: TLabel;
    cxgNceDBTableView1: TcxGridDBTableView;
    cxgNceLevel1: TcxGridLevel;
    cxgNce: TcxGrid;
    cxgNceDBCODEMP: TcxGridDBColumn;
    cxgNceDBCODNCM: TcxGridDBColumn;
    cxgNceDBCODITE: TcxGridDBColumn;
    cxgNceDBACAO: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxgNceDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
    qryExec: TUniQuery;
    function fGetAcao(strAcaoStr: String): TAcaoImpCadNce;
  protected
    procedure pGravaCadNce;
    function fInsereNces(pgbProgresso: TcxProgressBar): Boolean;
    function fTrataVazio(strValor: Variant; ValorDef: Variant ): Variant;
  public
    { Public declarations }
    cdsCadNce: TZClient;
    blnOk: Boolean;
  end;

implementation

uses
  untGravando,
  untFuncoesSimples;

{$R *.dfm}

function TfrmImportCadNCEConfirma.fGetAcao(strAcaoStr: String): TAcaoImpCadNce;
begin
  Result := tpSem;
  case AnsiIndexStr(strAcaoStr, ['I', 'A', '']) of
   0: Result := tpInserir;
   1: Result := tpAtualizar;
   2: Result := tpSem;
  end;
End;

procedure TfrmImportCadNCEConfirma.btnConfirmaClick(Sender: TObject);
  Var
    frmIns : TfrmGravando;
begin
  inherited;

  If cdsCadNce.RecordCount > 0 then
  Begin
    pCriarFormularios(TfrmGravando, frmIns);
    Try
      frmIns.fExecutarAcao := fInsereNces;
      frmIns.lblGravando.Caption := 'Aguarde... Processando NCMs...';
      frmIns.Showmodal;

      If blnOk Then
        pMensagemOk('Processo concluído com êxito!');
    Finally
      pFreeAndNil(frmIns);
    End;
  End;
end;

procedure TfrmImportCadNCEConfirma.cxgNceDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strAcao: String;
    AcaoImpCadNce : TAcaoImpCadNce;
begin
  inherited;

  If cdsCadNce.RecordCount = 0 Then
    Exit;

  strAcao := VarToString(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgNceDBACAO.Index]);

  AcaoImpCadNce := fGetAcao(strAcao);
  ACanvas.Font.Color := clBlack;

  Case AcaoImpCadNce Of
      tpInserir: ACanvas.Brush.Color := clAqua;
    tpAtualizar: ACanvas.Brush.Color := clYellow;
    Else
      ACanvas.Brush.Color := clMoneyGreen;
  End;
end;

function TfrmImportCadNCEConfirma.fInsereNces(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := False;
  pgbProgresso.Properties.Max := cdsCadNce.RecordCount;

  blnOk := False;

  cdsCadNce.First;
  cdsCadNce.DisableControls;
  Try
    fStartTransaction;
    Try
      While Not cdsCadNce.Eof Do
      Begin
        pGravaCadNce;
        cdsCadNce.Next;
      End;
      fCommit;
      blnOk := True;
      Result := True;
    Except
      On e: Exception do
      Begin
        fRollBack;
        pMensagensErro(e.Message, '[TfrmImportCadNCEConfirma.fInsereNces]');
      End;
    End
  Finally
    cdsCadNce.EnableControls;
  End;
end;

procedure TfrmImportCadNCEConfirma.FormCreate(Sender: TObject);
begin
  inherited;
  qryExec := fCriaQuery;
  blnOk := False;
end;

procedure TfrmImportCadNCEConfirma.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryExec);
end;

procedure TfrmImportCadNCEConfirma.FormShow(Sender: TObject);
begin
  inherited;
  dtsCadNce.DataSet := cdsCadNce;
  cxgNceDBTableView1.ApplyBestFit;
end;

procedure TfrmImportCadNCEConfirma.pGravaCadNce;
  Var
    blnInclusao : Boolean;
    strAutInc : String;

  Const
    cFieldsIns =  'AUTOINCREM, NCE_CODEMP, NCE_CODNCM, NCE_CODITE';
    cParamnsIns = ':AUTOINCREM, :NCE_CODEMP, :NCE_CODNCM, :NCE_CODITE';

    cUpdate  = ' NCE_CODEMP = :NCE_CODEMP,' +
               ' NCE_CODNCM = :NCE_CODNCM,' +
               ' NCE_CODITE = :NCE_CODITE';
begin

  blnInclusao := cdsCadNce.FieldByName('ACAO').AsString = 'I';
  qryExec.SQL.Clear;

  If blnInclusao Then
  Begin
    qryExec.SQL.Add('INSERT CADNCE (' + cFieldsIns + ') VALUES ('+cParamnsIns+')');
    strAutInc := fRetAutoIncrem('CADNCE', VS_StrCodEmp);
  End
  Else
  Begin
    strAutInc := cdsCadNce.FieldByName('AUTOINCREM').AsString;
    qryExec.SQL.Add('UPDATE CADNCE SET ' + cUpdate);
    qryExec.SQL.Add(' WHERE AUTOINCREM = :AUTOINCREM');
  End;

  qryExec.ParamByName('AUTOINCREM').AsString := strAutInc;
  qryExec.ParamByName('NCE_CODEMP').AsString := cdsCadNce.FieldByName('NCE_CODEMP').AsString;
  qryExec.ParamByName('NCE_CODITE').AsString := cdsCadNce.FieldByName('NCE_CODITE').AsString;
  qryExec.ParamByName('NCE_CODNCM').AsString := cdsCadNce.FieldByName('NCE_CODNCM').AsString;

  qryExec.ExecSQL;
end;

function TfrmImportCadNCEConfirma.fTrataVazio(strValor: Variant; ValorDef: Variant): Variant;
begin
  If strValor = null Then
    Exit(ValorDef);

  If VarToStrDef(strValor, '') = '' Then
    Result := ValorDef
  Else
     Result := strValor;
end;

end.





