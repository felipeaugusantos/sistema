unit untFatPromocaoBrindesResumo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView, DBEditFocus,
  cxGridDBBandedTableView, cxClasses, cxGridCustomView, cxGrid, EditFocus,
  untPromocaoBrindes, Vcl.Mask, Vcl.DBCtrls,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmFatPromocaoBrindesResumo = class(TfrmPaiSimples)
    pnlPromocoes: TPanel;
    cxgPromocoes: TcxGrid;
    cxgPromocoesView: TcxGridDBBandedTableView;
    cxgPromocoesViewCODPRO: TcxGridDBBandedColumn;
    cxgPromocoesViewDESPRO: TcxGridDBBandedColumn;
    cxgPromocoesViewTABPRE: TcxGridDBBandedColumn;
    cxgPromocoesViewPERVAL: TcxGridDBBandedColumn;
    cxgPromocoesViewPONACU: TcxGridDBBandedColumn;
    cxgPromocoesViewPONVEN: TcxGridDBBandedColumn;
    cxgPromocoesLevel: TcxGridLevel;
    Panel13: TPanel;
    btnVerBrindes: TBitBtnLocked;
    pnlBrindes: TPanel;
    cxgBrindes: TcxGrid;
    cxgBrindesView: TcxGridDBBandedTableView;
    cxgBrindesViewCODBRI: TcxGridDBBandedColumn;
    cxgBrindesViewDESBRI: TcxGridDBBandedColumn;
    cxgBrindesViewREFBRI: TcxGridDBBandedColumn;
    cxgBrindesViewUNIBRI: TcxGridDBBandedColumn;
    cxgBrindesViewQTDBRI: TcxGridDBBandedColumn;
    cxgBrindesLevel: TcxGridLevel;
    Panel1: TPanel;
    cxgBrindesViewQTDSEL: TcxGridDBBandedColumn;
    btnSelecionarBrinde: TBitBtnLocked;
    btnRemoverBrinde: TBitBtnLocked;
    btnFechamento: TBitBtnLocked;
    edtPonDis: TDBEditFocus;
    Label1: TLabel;
    edtPonUti: TDBEditFocus;
    Label7: TLabel;
    edtTotPon: TDBEditFocus;
    Label8: TLabel;
    btnVerPromocoes: TBitBtnLocked;
    dtsPromocoes: TDataSource;
    dtsBrindes: TDataSource;
    cxgPromocoesViewPONUTI: TcxGridDBBandedColumn;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    procedure cxgBrindesViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgPromocoesViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnVerPromocoesClick(Sender: TObject);
    procedure btnVerBrindesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure pnlPromocoesEnter(Sender: TObject);
    procedure pnlPromocoesExit(Sender: TObject);
    procedure pnlBrindesEnter(Sender: TObject);
    procedure pnlBrindesExit(Sender: TObject);
    procedure btnSelecionarBrindeClick(Sender: TObject);
    procedure btnRemoverBrindeClick(Sender: TObject);
    procedure btnFechamentoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtTotPonChange(Sender: TObject);
    procedure cxgBrindesViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgPromocoesViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
  private
    function fVerificaPontosDisponiveis: Boolean;
    { Private declarations }
  public
    { Public declarations }
    objEmitirBrinde: TFatEmitirBrindePromocao;
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmFatPromocaoBrindesResumo.btnVerPromocoesClick(Sender: TObject);
begin
  inherited;
  pSetFocus(cxgPromocoes);
end;

function TfrmFatPromocaoBrindesResumo.fVerificaPontosDisponiveis: Boolean;
begin
  Result := True;
  With objEmitirBrinde.cdsPromocoesSel Do
  Begin
    First;
    While Not Eof do
    Begin
      If FieldByname('PONDIS').AsFloat > FieldByname('PONACU').AsFloat Then
      Begin
        If fpergunta('A quantidade de pontos disponíveis para a promoção ' +
                     '(' + FieldByname('DESPRO').AsString + ') ' +
                     'é maior que a quantidade de pontos para direito a brinde, ' +
                     'portanto ainda é possível selecionar mais produtos de brinde '+
                     'para o cliente. Deseja selecionar mais brindes?') Then
        Begin
          pSetFocus(cxgBrindes);
          Result := False;
          Break;
        End;
      End;
      Next;
    End;
  End;
end;

procedure TfrmFatPromocaoBrindesResumo.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  If btnDesmarcarTodos.Enabled Then
  Begin
    objEmitirBrinde.pRemoverTodosBrindes;
    btnFechamento.Enabled := True;
  End;
end;

procedure TfrmFatPromocaoBrindesResumo.btnFechamentoClick(Sender: TObject);
begin
  inherited;
  If btnFechamento.Enabled And fVerificaPontosDisponiveis Then
  Begin
    Self.Close;
    ModalResult := mrOk;
  End;
end;

procedure TfrmFatPromocaoBrindesResumo.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  If btnMarcarTodos.Enabled Then
  Begin
    objEmitirBrinde.pSelecionarTodosBrindes;
    btnFechamento.Enabled := True;
  End;
end;

procedure TfrmFatPromocaoBrindesResumo.btnRemoverBrindeClick(Sender: TObject);
begin
  inherited;
  If btnRemoverBrinde.Enabled Then
    objEmitirBrinde.pRemoverBrinde;
end;

procedure TfrmFatPromocaoBrindesResumo.btnSelecionarBrindeClick(Sender: TObject);
begin
  inherited;
  If btnSelecionarBrinde.Enabled Then
  Begin
    objEmitirBrinde.pSelecionarBrinde;
    btnFechamento.Enabled := True;
  End;
end;

procedure TfrmFatPromocaoBrindesResumo.btnVerBrindesClick(
  Sender: TObject);
begin
  inherited;
  pSetFocus(cxgBrindes);
end;

procedure TfrmFatPromocaoBrindesResumo.cxgBrindesViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If Assigned(objEmitirBrinde) And objEmitirBrinde.cdsBrindesSel.Active Then
  Begin
    If fStrToFloat(VarToStr(Sender.DataController.Values[
      AViewInfo.GridRecord.RecordIndex, cxgBrindesViewQTDSEL.Index])) > 0 Then
    Begin
      If AViewInfo.Selected Then
      Begin
        ACanvas.Brush.Color := clHighlight;
        ACanvas.Font.Color  := clLime;
      End
      Else
        ACanvas.Brush.Color := clMoneyGreen;
    End;
  End;
end;

procedure TfrmFatPromocaoBrindesResumo.cxgBrindesViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key Of
    VK_RETURN : btnSelecionarBrinde.Click;
    VK_DELETE : btnRemoverBrinde.Click;
    VK_F2     : btnMarcarTodos.Click;
    VK_F3     : btnDesmarcarTodos.Click;
    VK_ESCAPE : btnVerPromocoes.Click;
    VK_F10    : Begin
                  Key := 0;
                  btnFechamento.Click;
                End;
  end;
end;

procedure TfrmFatPromocaoBrindesResumo.cxgPromocoesViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  If Assigned(objEmitirBrinde) And objEmitirBrinde.cdsPromocoesSel.Active Then
  Begin
    If fStrToFloat(VarToStr(Sender.DataController.Values[
      AViewInfo.GridRecord.RecordIndex, cxgPromocoesViewPONUTI.Index])) > 0 Then
    Begin
      If AViewInfo.Selected Then
      Begin
        ACanvas.Brush.Color := clHighlight;
        ACanvas.Font.Color  := clLime;
      End
      Else
        ACanvas.Brush.Color := clMoneyGreen;
    End;
  End;
end;

procedure TfrmFatPromocaoBrindesResumo.cxgPromocoesViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key Of
    VK_ESCAPE: pEscapePressed;
    VK_RETURN: btnVerBrindes.Click;
    VK_F10   : Begin
                 Key := 0;
                 btnFechamento.Click;
               End;
  end;
end;

procedure TfrmFatPromocaoBrindesResumo.edtTotPonChange(Sender: TObject);
begin
  inherited;
  If Assigned(TDBEditFocus(Sender).DataSource.DataSet) And
     TDBEditFocus(Sender).DataSource.DataSet.Active Then
  Begin
    If fStrToFloat(TDBEditFocus(Sender).Text) < 0 Then
      TDBEditFocus(Sender).Font.Color := clRed
    Else
      TDBEditFocus(Sender).Font.Color := clGreen;
  End;
end;

procedure TfrmFatPromocaoBrindesResumo.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(cxgBrindes);//Necessario para chamar o onExit do pnlBrindes
  pSetFocus(cxgPromocoes);//Necessario para chamar o onEnter do pnlPromocoes
end;

procedure TfrmFatPromocaoBrindesResumo.FormCreate(Sender: TObject);
begin
  inherited;
  btnFechamento.Enabled := False;
end;

procedure TfrmFatPromocaoBrindesResumo.FormShow(Sender: TObject);
begin
  inherited;
  dtsBrindes.DataSet:= objEmitirBrinde.cdsBrindesSel;
  dtsPromocoes.DataSet := objEmitirBrinde.cdsPromocoesSel;
end;

procedure TfrmFatPromocaoBrindesResumo.pnlBrindesEnter(Sender: TObject);
begin
  inherited;
  btnRemoverBrinde.Enabled := True;
  btnSelecionarBrinde.Enabled := True;
  btnVerPromocoes.Enabled := True;
  btnMarcarTodos.Enabled := True;
  btnDesmarcarTodos.Enabled := True;
end;

procedure TfrmFatPromocaoBrindesResumo.pnlBrindesExit(Sender: TObject);
begin
  inherited;
  btnRemoverBrinde.Enabled := False;
  btnSelecionarBrinde.Enabled := False;
  btnVerPromocoes.Enabled := False;
  btnMarcarTodos.Enabled := False;
  btnDesmarcarTodos.Enabled := False;
end;

procedure TfrmFatPromocaoBrindesResumo.pnlPromocoesEnter(Sender: TObject);
begin
  inherited;
  btnVerbrindes.Enabled := True;
end;

procedure TfrmFatPromocaoBrindesResumo.pnlPromocoesExit(Sender: TObject);
begin
  inherited;
  btnVerBrindes.Enabled := False;
end;

end.
