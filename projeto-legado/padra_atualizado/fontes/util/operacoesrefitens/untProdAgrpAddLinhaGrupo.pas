unit untProdAgrpAddLinhaGrupo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Vcl.Mask, MaskEditFocus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  Datasnap.DBClient, UniClientDataSet, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  cxCheckBox, untTypesSistema, untFuncoesSimples, Uni, untConsultas,
  untFuncoesConsulta, untGravando, cxProgressBar;

type
  TfrmProdAgrpAddLinhaGrupo = class(TfrmPaiConfirma)
    pnlCabecalho: TPanel;
    Label8: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    dbgItens: TcxGrid;
    dbgItensDBTableView: TcxGridDBTableView;
    dbgItensDBTableViewIMPORT: TcxGridDBColumn;
    dbgItensDBTableViewDESITE: TcxGridDBColumn;
    dbgItensDBTableViewCODITE: TcxGridDBColumn;
    dbgItensLevel: TcxGridLevel;
    dtsItens: TDataSource;
    cdsItens: TUniClientDataSet;
    cdsItensCODAGR: TStringField;
    cdsItensCODITE: TStringField;
    cdsItensDESITE: TStringField;
    cdsItensPAIFIL: TStringField;
    btnDesmarTodos: TBitBtnLocked;
    btnMarTodos: TBitBtnLocked;
    dbgItensDBTableViewLINGRU: TcxGridDBColumn;
    btnMarDes: TBitBtnLocked;
    pnlLegenda: TPanel;
    shpMarcados: TShape;
    lblLegMarcados: TLabel;
    procedure mskLinGruExit(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarTodosClick(Sender: TObject);
    procedure btnDesmarTodosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnMarDesClick(Sender: TObject);
    procedure dbgItensDBTableViewDataControllerSummaryFooterSummaryItemsSummary(
      ASender: TcxDataSummaryItems; Arguments: TcxSummaryEventArguments;
      var OutArguments: TcxSummaryEventOutArguments);
    procedure dbgItensDBTableViewIMPORTPropertiesChange(Sender: TObject);
    procedure dbgItensDBTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    function fListaItensPrg(pgbProgresso: TcxProgressBar): Boolean;
    function fListaItens: Boolean;
    function fArrayToLista(arrDados: TConsultasArray): TStringList;
    function fMarcarDesmarcar(blnMarcar: Boolean): Boolean;
    function fMarcarDesmarcarPrg(pgbProgresso: TcxProgressBar): Boolean;
    function fCriaListaImportacao: Boolean;
    function fCriaListaImportacaoPrg(pgbProgresso: TcxProgressBar): Boolean;
    function fGetSQL: String;
    var
      FfrmGravandoCorrente: TFrmGravando;
      FblnMarcar: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; override;
    { Private declarations }
  public
    { Public declarations }
    var
      arrLinhaGrupo: TConsultasArray;
      qryConGru: TUniQuery;
      listaImportacao: TStringList;
  end;

var
  frmProdAgrpAddLinhaGrupo: TfrmProdAgrpAddLinhaGrupo;

implementation

{$R *.dfm}

procedure TfrmProdAgrpAddLinhaGrupo.mskLinGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGru, edtDesGru, arrLinhaGrupo, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);
  If Not fEmptyStr(mskLinGru.Text) Then
    fListaItens
  Else
  Begin
   edtDesGru.Clear;
   mskLinGru.Clear;
  End;
end;

procedure TfrmProdAgrpAddLinhaGrupo.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinGru, edtDesGru, qryConGru, Key, arrLinhaGrupo, False) Then
  Begin
    If fValidaCampos(mskLinGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmProdAgrpAddLinhaGrupo.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If fMensagem('', 'Confirma Itens?', ['&Sim', '&Não']) = 1 Then
    fCriaListaImportacao;
end;

function TfrmProdAgrpAddLinhaGrupo.fCriaListaImportacao: Boolean;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Criando lista de importação de itens...';
  frmGravando.fExecutarAcao := fCriaListaImportacaoPrg;

  FfrmGravandoCorrente := frmGravando;

  frmGravando.ShowModal;

  Result := frmGravando.blnConfirma;
end;

function TfrmProdAgrpAddLinhaGrupo.fCriaListaImportacaoPrg(pgbProgresso: TcxProgressBar): Boolean;
begin
  listaImportacao := TStringList.Create;

  cdsItens.Filter   := 'IMPORT = ' + QuotedStr('S');
  cdsItens.Filtered := True;
  cdsItens.First;

  pgbProgresso.Position := 0;
  pgbProgresso.Properties.Max := cdsItens.RecordCount;

  While not cdsItens.Eof Do
  Begin
    listaImportacao.Add(cdsItens.FieldByName('ITE_CODITE').AsString);
    cdsItens.Next;

    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;

  Result := True;
end;

procedure TfrmProdAgrpAddLinhaGrupo.btnDesmarTodosClick(Sender: TObject);
begin
  inherited;
  fMarcarDesmarcar(False);
end;

procedure TfrmProdAgrpAddLinhaGrupo.btnMarDesClick(Sender: TObject);
begin
  inherited;
  cdsItens.Edit;
  cdsItens.FieldByName('IMPORT').AsString := IIF(cdsItens.FieldByName('IMPORT').AsString='S','N','S');
  cdsItens.Post;
end;

procedure TfrmProdAgrpAddLinhaGrupo.btnMarTodosClick(Sender: TObject);
begin
  inherited;
  fMarcarDesmarcar(True);
end;

procedure TfrmProdAgrpAddLinhaGrupo.dbgItensDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgItensDBTableViewIMPORT.Index] = 'S' Then
    ACanvas.Brush.Color := clMoneyGreen;
end;

procedure TfrmProdAgrpAddLinhaGrupo.dbgItensDBTableViewDataControllerSummaryFooterSummaryItemsSummary(
  ASender: TcxDataSummaryItems; Arguments: TcxSummaryEventArguments;
  var OutArguments: TcxSummaryEventOutArguments);
var
  strImport: String;
begin
  inherited;
  Try
    strImport := dbgItensDBTableView.DataController.Values[Arguments.RecordIndex, dbgItensDBTableViewIMPORT.Index];
  Except
    strImport := '';
  End;

  If (Arguments.SummaryItem.Index > -1) And (strImport <> 'S') Then
    OutArguments.Done := True;
end;

procedure TfrmProdAgrpAddLinhaGrupo.dbgItensDBTableViewIMPORTPropertiesChange(
  Sender: TObject);
begin
  inherited;
  cdsItens.post;
end;

function TfrmProdAgrpAddLinhaGrupo.fArrayToLista(
  arrDados: TConsultasArray): TStringList;
var
  I: Integer;
  lst: TStringList;
begin
  lst := TStringList.Create;
  for I:=0 to Length(arrDados)-1 do
    lst.Add(arrDados[I].strCodigo);

  Result := lst;
end;

function TfrmProdAgrpAddLinhaGrupo.fListaItens: Boolean;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Carregando itens...';
  frmGravando.fExecutarAcao := fListaItensPrg;

  FfrmGravandoCorrente := frmGravando;

  frmGravando.ShowModal;

  Result := frmGravando.blnConfirma;
end;

function TfrmProdAgrpAddLinhaGrupo.fGetSQL:String;
  begin
    Result := '';
    Result := Result + '  SELECT                                       ';
    Result := Result + '   ITE_CODITE,                                 ';
    Result := Result + '   ITE_DESITE,                                 ';
    Result := Result + '   CONCAT(GRU_CODGRU,"-",GRU_DESGRU) AS GRUPO_,';
    Result := Result + '   CAST("" AS CHAR(1)) AS IMPORT               ';
    Result := Result + '  FROM                                         ';
    Result := Result + '   CADITE                                      ';
    Result := Result + '  INNER JOIN                                   ';
    Result := Result + '   CADGRU ON                                   ';
    Result := Result + '    GRU_CODGRU = ITE_CODGRU                    ';
    Result := Result + '  WHERE                                        ';
    Result := Result + '   LOCATE(ITE_CODGRU, :LSTGRP) > 0             ';
  end;

function TfrmProdAgrpAddLinhaGrupo.fListaItensPrg(
  pgbProgresso: TcxProgressBar): Boolean;
var
  qryItens: TUniQuery;
begin
  Try
    qryItens := fCriarQuery(fGetSQL);
    qryItens.ParamByName('LSTGRP').AsString := fArrayToLista(arrLinhaGrupo).CommaText;
    qryItens.Open;

    pgbProgresso.Position       := 0;
    pgbProgresso.Properties.Max := qryItens.RecordCount;

    cdsItens.EmptyDataSet;
    While not qryItens.Eof Do
    Begin
      cdsItens.Append;
      cdsItens.FieldByName('ITE_CODITE').AsString := qryItens.FieldByName('ITE_CODITE').AsString;
      cdsItens.FieldByName('ITE_DESITE').AsString := qryItens.FieldByName('ITE_DESITE').AsString;
      cdsItens.FieldByName('IMPORT').AsString     := 'S';
      cdsItens.FieldByName('GRUPO_').AsString     := qryItens.FieldByName('GRUPO_').AsString;
      cdsItens.Post;

      qryItens.Next;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;
      cdsItens.First;

      Result := True;
  Finally
    FreeAndNil(qryItens);
  End;
end;

function TfrmProdAgrpAddLinhaGrupo.fMarcarDesmarcar(
  blnMarcar: Boolean): Boolean;
begin
  FblnMarcar := blnMarcar;
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := IIF(blnMarcar, 'Marcando itens...', 'Desmarcando itens...');
  frmGravando.fExecutarAcao := fMarcarDesmarcarPrg;

  FfrmGravandoCorrente := frmGravando;

  frmGravando.ShowModal;

  Result := frmGravando.blnConfirma;
end;

function TfrmProdAgrpAddLinhaGrupo.fMarcarDesmarcarPrg(pgbProgresso: TcxProgressBar): Boolean;
var
  recNo: Integer;
begin
  recNo := cdsItens.RecNo;
  cdsItens.First;

  pgbProgresso.Position       := 0;
  pgbProgresso.Properties.Max := cdsItens.RecordCount;

  While not cdsItens.Eof Do
  Begin
    cdsItens.Edit;
    cdsItens.FieldByName('IMPORT').AsString := IIF(FblnMarcar,'S','N');
    cdsItens.Post;
    cdsItens.Next;

     pgbProgresso.Position := pgbProgresso.Position + 1;
     Application.ProcessMessages;
  End;

  cdsItens.recNo := recNo;

  Result := True;
end;

procedure TfrmProdAgrpAddLinhaGrupo.FormCreate(Sender: TObject);
begin
  inherited;
  cdsItens.CreateDataSet;
  cdsItens.Open;
end;

procedure TfrmProdAgrpAddLinhaGrupo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F2: btnMarTodos.Click;
    VK_F3: btnDesmarTodos.Click;
    VK_SPACE: btnMarDes.Click;
  End;
end;

procedure TfrmProdAgrpAddLinhaGrupo.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(mskLinGru);
end;

function TfrmProdAgrpAddLinhaGrupo.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = mskLinGru) And fEmptyStr(mskLinGru.Text) Then
  Begin
    pDesmarcaLista(mskLinGru, arrLinhaGrupo,'',6);
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
