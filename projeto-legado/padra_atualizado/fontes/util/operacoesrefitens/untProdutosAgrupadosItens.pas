unit untProdutosAgrupadosItens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxClasses, cxGridLevel, cxGrid, DB, UniClientDataSet, cxDBData, cxGridDBTableView,
  Uni, cxDataControllerConditionalFormattingRulesManagerDialog,
  Datasnap.DBClient, frxClass, frxExportCSVTestabilidade, cxProgressBar;

type
  TfrmProdutosAgrupadosItens = class(TfrmPai)
    dtsAgr: TDataSource;
    cdsAgr: TUniClientDataSet;
    dbgAgr: TcxGrid;
    dbgAgrLevel1: TcxGridLevel;
    cdsAgrCODAGR: TStringField;
    cdsAgrCODITE: TStringField;
    dbgAgrDBTableView1: TcxGridDBTableView;
    dbgAgrDBTableView1CODAGR: TcxGridDBColumn;
    dbgAgrDBTableView1CODITE: TcxGridDBColumn;
    cdsAgrPAIFIL: TStringField;
    cdsAgrDESITE: TStringField;
    dbgAgrDBTableView1DESITE: TcxGridDBColumn;
    dbgAgrDBTableView1PAIFIL: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    procedure dbgAgrDBTableView1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure dbgAgrDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dtsAgrDataChange(Sender: TObject; Field: TField);
    procedure dbgAgrDBTableView1DblClick(Sender: TObject);
    procedure dbgAgrDBTableView1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure dbgAgrDBTableView1EditDblClick(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit);
  private
    { Private declarations }
    qryGen     : TUniQuery;
    function fCarregaItensPrg(prbProgresso: TcxProgressBar):Boolean;

  public
    strCodIte : string;
    strCodAgr : string;
    { Public declarations }
  end;

var
  frmProdutosAgrupadosItens: TfrmProdutosAgrupadosItens;

implementation

uses untFuncoesSimples, untGravando;

{$R *.dfm}

procedure TfrmProdutosAgrupadosItens.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  strCodAgr:=cdsAgr.FieldByName('CODAGR').AsString;

  btnSair.Click;
end;

procedure TfrmProdutosAgrupadosItens.dbgAgrDBTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  btnConfirma.Click;
end;

procedure TfrmProdutosAgrupadosItens.dbgAgrDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Var
  strCodIteGrd:string;
begin
  inherited;

  strCodIteGrd := Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgAgrDBTableView1CODITE.Index];
  If (strCodIteGrd = strCodIte) Then
  Begin
    ACanvas.Font.Color := clRed;
  End;

end;

procedure TfrmProdutosAgrupadosItens.dbgAgrDBTableView1DblClick(
  Sender: TObject);
begin
  inherited;

  btnConfirma.Click;
end;

procedure TfrmProdutosAgrupadosItens.dbgAgrDBTableView1EditDblClick(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit);
begin
  inherited;

  btnConfirma.Click;
end;

procedure TfrmProdutosAgrupadosItens.dbgAgrDBTableView1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If Key = #27 Then
    btnSair.Click;
end;

procedure TfrmProdutosAgrupadosItens.dtsAgrDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;

  If cdsAgr.RecordCount > 0 Then
  begin
    pnlInfo.Caption:='Selecionado: '+cdsAgr.FieldByName('CODAGR').AsString;
  End;
end;

procedure TfrmProdutosAgrupadosItens.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(cdsAgrCODITE);

  strCodAgr:='EXIT';
end;

procedure TfrmProdutosAgrupadosItens.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_RETURN Then
  Begin
    btnConfirma.Click;
  End;
end;

procedure TfrmProdutosAgrupadosItens.FormShow(Sender: TObject);
 Var
   strSQL,
   strSQLInner: String;
   intCont    : Integer;
   intLargura : Integer;
   frmGravando: TFrmGravando;
begin
  inherited;

  Try
    qryGen := fCriaQuery;

    {**********************************************}
    {* CARREGA ITENS DE TODOS OS GRUPOS ONDE O    *}
    {* ITEM BUSCADO CONSTA                        *}
    {*******************************************VA*}
    strSQLInner:=' SELECT DISTINCT CADAGR.AGR_CODAGR, CADAGR.AGR_CODITE, CADAGR.AGR_ITEPAI FROM CADAGR '
        +' INNER JOIN (SELECT AGR_CODAGR FROM CADAGR WHERE AGR_CODITE = '+QuotedStr(strCodIte)+') AS TAB001 ON (TAB001.AGR_CODAGR = CADAGR.AGR_CODAGR) ';

    strSQLInner:=' INNER JOIN ('+strSQLInner+') AS A ON (A.AGR_CODITE=I.ITE_CODITE) ';

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  I.ITE_CODITE AS CODITE, ';
    strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';
    strSQL := strSQL + '  A.AGR_CODAGR AS CODAGR, ';
    strSQL := strSQL + '  IF(A.AGR_ITEPAI="S","Pai","Filho") PAIFIL ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I ';
    strSQL := strSQL + '  INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE AND G.ITE_CODEMP = :CODEMP ';

    strSQL := strSQL + strSQLInner;

    strSQL := strSQL + '  ORDER BY A.AGR_ITEPAI DESC, I.ITE_DESITE  ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
    End;

    pSetaCodIte(cdsAgrCODITE);

    cdsAgr.CreateDataSet;
    cdsAgr.Open;
    cdsAgr.DisableControls;

    pCriarFormularios(TfrmGravando, frmGravando);
    Try
      frmGravando.lblGravando.Caption := 'Carregando Itens...';
      frmGravando.fExecutarAcao := fCarregaItensPrg;
      frmGravando.ShowModal;
    Finally
      FreeAndNil(frmGravando)
    End;




    dbgAgrDBTableView1.ViewData.Expand(True);
    pSetFocus(dbgAgr);
    dbgAgrDBTableView1.NavigatorButtons.First.Click;

    intLargura := 0;
    For intCont := 0 To dbgAgrDBTableView1.VisibleColumnCount - 1 Do
    Begin
      dbgAgrDBTableView1.VisibleColumns[intCont].ApplyBestFit();
      intLargura := intLargura + dbgAgrDBTableView1.VisibleColumns[intCont].Width;
    End;

    Self.ClientWidth := intLargura + 55;
    cdsAgr.EnableControls;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmProdutosAgrupadosItens.fCarregaItensPrg(prbProgresso: TcxProgressBar):Boolean;
begin
  Result := True;
  prbProgresso.Properties.Max := qryGen.RecordCount -1;
  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    cdsAgr.Append;
    cdsAgr.FieldByName('CODAGR').AsString:=qryGen.FieldByName('CODAGR').AsString;
    cdsAgr.FieldByName('CODITE').AsString:=qryGen.FieldByName('CODITE').AsString;
    cdsAgr.FieldByName('DESITE').AsString:=qryGen.FieldByName('DESITE').AsString;
    cdsAgr.FieldByName('PAIFIL').AsString:=qryGen.FieldByName('PAIFIL').AsString;
    cdsAgr.Post;

    qryGen.Next;
    prbProgresso.Position := qryGen.RecNo;
    If qryGen.Recno Mod  20 = 0 then
      Application.ProcessMessages;
  End;
End;

end.
