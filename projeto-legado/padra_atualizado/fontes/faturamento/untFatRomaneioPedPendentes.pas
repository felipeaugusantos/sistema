unit untFatRomaneioPedPendentes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, untZClient, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, EditFocus;

type
  TfrmFatRomaneioPedPendentes = class(TfrmPaiEdit)
    cxgPedidosView: TcxGridDBTableViewCitel;
    cxgPedidosLevel: TcxGridLevel;
    cxgPedidos: TcxGridCitel;
    pnlTotais: TPanel;
    dtsConsul: TDataSource;
    cxgPedidosViewDTENTR: TcxGridDBColumn;
    cxgPedidosViewNUMDOC: TcxGridDBColumn;
    cxgPedidosViewCODEMP: TcxGridDBColumn;
    cxgPedidosViewCODCLI: TcxGridDBColumn;
    cxgPedidosViewNOMCLI: TcxGridDBColumn;
    cxgPedidosViewCODVEN: TcxGridDBColumn;
    cxgPedidosViewNOMCID: TcxGridDBColumn;
    cxgPedidosViewESTADO: TcxGridDBColumn;
    cxgPedidosViewCODITE: TcxGridDBColumn;
    cxgPedidosViewDESITE: TcxGridDBColumn;
    cxgPedidosViewUNIDAD: TcxGridDBColumn;
    cxgPedidosViewENTRET: TcxGridDBColumn;
    cxgPedidosViewQTDITE: TcxGridDBColumn;
    cxgPedidosViewTOTPES: TcxGridDBColumn;
    cxgPedidosViewMARDES: TcxGridDBColumn;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    edtTotQuant: TEditFocus;
    edtTotPeso: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgPedidosViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgPedidosViewKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure cxgPedidosViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
    intQtdSelec: Integer;
    fltPesoSelec: Double;
    cdsConsul: TZClient;
    procedure cdsConsulAfterPost(DataSet: TDataSet);
    procedure pAbreConsulta;
    function fSqlConsulta: String;
    procedure pMarcaDesmarca(blnMarcar: Boolean);
    procedure pMarcaDesmarcaItem;
    procedure pMarcaTodos;
    procedure pDesmarcaTodos;
    procedure pAtualizaTotais;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatRomaneioPedPendentes.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  If cdsConsul.Active Then
    fExecutarModal(pDesmarcaTodos, 'Aguarde, desmarcando todos...', '');
end;

procedure TfrmFatRomaneioPedPendentes.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  If cdsConsul.Active Then
    fExecutarModal(pMarcaTodos, 'Aguarde, marcando todos...', '');
end;

procedure TfrmFatRomaneioPedPendentes.cdsConsulAfterPost(DataSet: TDataSet);
begin
  If DataSet.FieldByName('MARDES').AsString = 'M' Then
  Begin
    intQtdSelec  := intQtdSelec + 1;
    fltPesoSelec := fltPesoSelec + DataSet.FieldByName('FDO_TOTPES').AsFloat;
    Exit;
  End;

  If DataSet.FieldByName('MARDES').AsString = 'D' Then
  Begin
    intQtdSelec  := intQtdSelec - 1;
    fltPesoSelec := fltPesoSelec - DataSet.FieldByName('FDO_TOTPES').AsFloat;
    Exit;
  End;
end;

procedure TfrmFatRomaneioPedPendentes.cxgPedidosViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pMarcaDesmarcaItem;
end;

procedure TfrmFatRomaneioPedPendentes.cxgPedidosViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If Not cdsConsul.Active Then
    Exit;

  If VarToStr(AViewInfo.GridRecord.Values[cxgPedidosViewMARDES.Index]) = 'M' Then
  Begin
    If AViewInfo.Selected Then
      ACanvas.Font.Color := clLime
    Else
      ACanvas.Font.Color := clBlue;
  End;
end;

procedure TfrmFatRomaneioPedPendentes.cxgPedidosViewKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_SPACE, VK_RETURN: pMarcaDesmarcaItem;
  End;
end;

procedure TfrmFatRomaneioPedPendentes.FormCreate(Sender: TObject);
begin
  inherited;
  cdsConsul := TZClient.Create(Self);
  cdsConsul.AfterPost := cdsConsulAfterPost;
  dtsConsul.DataSet   := cdsConsul;
end;

procedure TfrmFatRomaneioPedPendentes.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsConsul);
end;

procedure TfrmFatRomaneioPedPendentes.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F6: btnMarcaTodos.Click;
    VK_F7: btnDesmarcaTodos.Click;
  End;
end;

procedure TfrmFatRomaneioPedPendentes.FormShow(Sender: TObject);
begin
  inherited;
  intQtdSelec  := 0;
  fltPesoSelec := 0.00;
  pAtualizaTotais;

  fExecutarModal(pAbreConsulta, 'Aguarde, carregando Pedidos...', '');
end;

function TfrmFatRomaneioPedPendentes.fSqlConsulta: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT "D" AS MARDES, ';
  strSQL := strSQL + '       IF(FDO_MOTFUT <> "A", FDO_DTENTR, NULL) AS FDO_DTENTR, ';
  strSQL := strSQL + '       FGO_NUMDOC, ';
  strSQL := strSQL + '       FGO_CODEMP, ';
  strSQL := strSQL + '       FGO_CODCLI, ';
  strSQL := strSQL + '       CLI_NOMCLI, ';
  strSQL := strSQL + '       FGO_CODVEN, ';
  strSQL := strSQL + '       CID_NOMCID, ';
  strSQL := strSQL + '       CID_ESTADO, ';
  strSQL := strSQL + '       FDO_CODITE, ';
  strSQL := strSQL + '       ITE_DESITE, ';
  strSQL := strSQL + '       FDO_UNIDAD, ';
  strSQL := strSQL + '       FDO_QTDITE, ';
  strSQL := strSQL + '       FDO_TOTPES, ';
  strSQL := strSQL + '       CASE WHEN FDO_ENTRET = "E" THEN ';
  strSQL := strSQL + '         CONCAT("ENT-", CASE WHEN FDO_ENTFUT = "S" THEN "F" ELSE "I" END) ';
  strSQL := strSQL + '         ELSE "RET" ';
  strSQL := strSQL + '       END AS FDO_ENTRET ';
  strSQL := strSQL + 'FROM FATGOR ';
  strSQL := strSQL + 'JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM ';
  strSQL := strSQL + 'JOIN FATDOR ON FDO_SEQGER = FATGOR.AUTOINCREM ';
  strSQL := strSQL + 'JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM ';
  strSQL := strSQL + 'JOIN CADITE ON ITE_CODITE = FDO_CODITE ';
  strSQL := strSQL + 'JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI ';
  strSQL := strSQL + 'JOIN CADCID ON CID_CODCID = CLI_CODCID ';
  strSQL := strSQL + 'WHERE FGO_JAFATU = 0 ';
  strSQL := strSQL + '  AND FDO_JAFATU = 0 ';
  strSQL := strSQL + '  AND FGO_DOCEND IS NULL ';
  strSQL := strSQL + '  AND IFNULL(FGO_CORTE_, "") <> "S" ';
  strSQL := strSQL + '  AND FGO_MEN001 <> "GARANTIA" ';
  strSQL := strSQL + '  AND FGO_VLRCON > 0 ';
  strSQL := strSQL + '  AND FGO_EMPEXP = '+ VS_strCodEmp.QuotedString;
  strSQL := strSQL + '  AND FGO_CODCLI NOT IN (SELECT EMP_CLIFIL FROM CADEMP WHERE EMP_CLIFIL IS NOT NULL) ';

  Result := strSQL;
end;

procedure TfrmFatRomaneioPedPendentes.pAbreConsulta;
begin
  cdsConsul.Close;
  cdsConsul.qryQuery.SQL.Text := fSqlConsulta;
  cdsConsul.fAbreClient(True, 'TfrmFatRomaneioPedPendentes.pAbreConsulta');
  cdsConsul.LogChanges := False;
  cdsConsul.IndexFieldNames := 'FDO_DTENTR;CID_ESTADO;CID_NOMCID;FGO_NUMDOC';
  cdsConsul.First;

  TFloatField(cdsConsul.FieldByName('FDO_QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  TFloatField(cdsConsul.FieldByName('FDO_TOTPES')).DisplayFormat := fMskDigitos(fCfgSis('DECBRU', varInteger));
end;

procedure TfrmFatRomaneioPedPendentes.pAtualizaTotais;
begin
  edtTotQuant.Text := intQtdSelec.ToString;
  edtTotPeso.Text  := FormatFloat(fMskDigitos(fCfgSis('DECBRU', varInteger)), fltPesoSelec);
end;

procedure TfrmFatRomaneioPedPendentes.pMarcaDesmarca(blnMarcar: Boolean);
begin
  cdsConsul.Edit;
  cdsConsul.FieldByName('MARDES').AsString := IIF(blnMarcar, 'M', 'D');
  cdsConsul.Post;
end;

procedure TfrmFatRomaneioPedPendentes.pMarcaDesmarcaItem;
begin
  If Not cdsConsul.IsEmpty Then
  Begin
    pMarcaDesmarca(cdsConsul.FieldByName('MARDES').AsString = 'D');
    pAtualizaTotais;
  End;
end;

procedure TfrmFatRomaneioPedPendentes.pDesmarcaTodos;
begin
  If Not cdsConsul.Locate('MARDES', 'M', []) Then
    Exit;

  cdsConsul.DisableControls;
  Try
    cdsConsul.First;
    While Not cdsConsul.Eof Do
    Begin
      If cdsConsul.FieldByName('MARDES').AsString <> 'D' Then
        pMarcaDesmarca(False);
      cdsConsul.Next;
    End;
  Finally
    pAtualizaTotais;
    cdsConsul.First;
    cdsConsul.EnableControls;
  End;
end;

procedure TfrmFatRomaneioPedPendentes.pMarcaTodos;
begin
  If Not cdsConsul.Locate('MARDES', 'D', []) Then
    Exit;

  cdsConsul.DisableControls;
  Try
    cdsConsul.First;
    While Not cdsConsul.Eof Do
    Begin
      If cdsConsul.FieldByName('MARDES').AsString <> 'M' Then
        pMarcaDesmarca(True);
      cdsConsul.Next;
    End;
  Finally
    pAtualizaTotais;
    cdsConsul.First;
    cdsConsul.EnableControls;
  End;
end;

end.
