unit untFatMostraComboProdVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxClasses,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxGridCustomView, cxGridCitel, cxGridLevel, cxGrid,
  cxLabel, cxCheckBox, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmFatMostraComboProdVenda = class(TfrmPaiConfirma)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    cxgProComLevel: TcxGridLevel;
    cxgProCom: TcxGridCitel;
    cxgProComView: TcxGridDBBandedTableViewCitel;
    CODITE: TcxGridDBBandedColumn;
    DESITE: TcxGridDBBandedColumn;
    REFERE: TcxGridDBBandedColumn;
    SIGUNI: TcxGridDBBandedColumn;
    cxgProComNUMLOT: TcxGridDBBandedColumn;
    cxgProSimNUMLOT: TcxGridDBBandedColumn;
    QTDITE: TcxGridDBBandedColumn;
    SITUAC: TcxGridDBBandedColumn;
    PREVEN: TcxGridDBBandedColumn;
    MARDES: TcxGridDBBandedColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    dtsProCom: TDataSource;
    dtsProSim: TDataSource;
    cxgProSim: TcxGridCitel;
    cxgProSimView: TcxGridDBBandedTableViewCitel;
    cxGridDBBandedColumn2: TcxGridDBBandedColumn;
    cxGridDBBandedColumn3: TcxGridDBBandedColumn;
    cxGridDBBandedColumn4: TcxGridDBBandedColumn;
    cxGridDBBandedColumn5: TcxGridDBBandedColumn;
    cxgProSimLevel: TcxGridLevel;
    btnTroCom: TBitBtnLocked;
    Label1: TLabel;
    cxGridDBBandedColumn6: TcxGridDBBandedColumn;
    btnInverterSelecao: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure btnTroComClick(Sender: TObject);
    procedure btnInverterSelecaoClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
  private
    blnFilSim: Boolean;

    function  getFilSim: Boolean;

    procedure pAlternaEntreGrids;
    procedure pTrocaProdutos;
    procedure pAfterScroll(DataSet: TDataSet);

    procedure pMarcarDesmarcarTodos(const blnMarcar: Boolean);
    procedure pInverterSelecao;
  public
    procedure setFilSim(Value: Boolean);
    procedure pFiltraProdSimilares;
  end;

var
  frmFatMostraComboProdVenda: TfrmFatMostraComboProdVenda;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmFatMostraComboProdVenda.btnDesmarcarTodosClick(Sender: TObject);
begin
  pMarcarDesmarcarTodos(False);
end;

procedure TfrmFatMostraComboProdVenda.btnInverterSelecaoClick(Sender: TObject);
begin
  pInverterSelecao;
end;

procedure TfrmFatMostraComboProdVenda.btnMarcarTodosClick(Sender: TObject);
begin
  pMarcarDesmarcarTodos(True);
end;

procedure TfrmFatMostraComboProdVenda.btnTroComClick(Sender: TObject);
begin
  inherited;
  pTrocaProdutos;
end;

procedure TfrmFatMostraComboProdVenda.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(cxgProCom);
end;

procedure TfrmFatMostraComboProdVenda.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (dtsProCom.DataSet.State = dsEdit) Then
    dtsProCom.DataSet.Post;

  dtsProCom.DataSet.AfterScroll := Nil;
end;

procedure TfrmFatMostraComboProdVenda.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F3) Then
    pAlternaEntreGrids
  Else If (Key = VK_F4) Then
    btnTroCom.Click
  else if (Key = VK_F5) then
    btnInverterSelecao.Click
  else if (Key = VK_F6) then
    btnMarcarTodos.Click
  else if (Key = VK_F7) then
    btnDesmarcarTodos.Click
  Else If (Key = VK_F10) Then
  Begin
    Key := 0;
    btnConfirma.Click;
  End;
end;

procedure TfrmFatMostraComboProdVenda.FormShow(Sender: TObject);
begin
  inherited;
  setFilSim(True);
  dtsProCom.DataSet.AfterScroll := pAfterScroll;

  If (fCfgSis('CTLEST') = '2') Then
  Begin
    cxgProComNUMLOT.Caption := 'Armazém';
    cxgProSimNUMLOT.Caption := 'Armazém';
  End;
end;

function TfrmFatMostraComboProdVenda.getFilSim: Boolean;
begin
  Result := blnFilSim;
end;

procedure TfrmFatMostraComboProdVenda.pAfterScroll(DataSet: TDataSet);
begin
  pFiltraProdSimilares;
end;

procedure TfrmFatMostraComboProdVenda.pAlternaEntreGrids;
begin
  If (cxgProCom.IsFocused) And (Not dtsProSim.DataSet.IsEmpty) Then
    pSetFocus(cxgProSim)
  Else
    pSetFocus(cxgProCom);
end;

procedure TfrmFatMostraComboProdVenda.pFiltraProdSimilares;
begin
  If (getFilSim) Then
  Begin
    dtsProSim.DataSet.Filtered := False;
    dtsProSim.DataSet.Filter   := 'SEQGER = ' + QuotedStr(dtsProCom.DataSet.FieldByName('AUTINC').AsString);
    dtsProSim.DataSet.Filtered := True;
  End;
end;

procedure TfrmFatMostraComboProdVenda.pInverterSelecao;
var
  intRecNo: Integer;
begin
  with dtsProCom.DataSet do
  begin
    if not IsEmpty then
    begin
      intRecNo := RecNo;
      DisableControls;
      First;

      while not Eof do
      begin
        Edit;
        FieldByName('MARDES').AsString := IIF(FieldByName('MARDES').AsString = 'N', 'S', 'N');
        Post;

        Next;
      end;

      RecNo := intRecNo;
      EnableControls;
    end;
  end;
end;

procedure TfrmFatMostraComboProdVenda.pMarcarDesmarcarTodos(
  const blnMarcar: Boolean);
var
  intRecNo: Integer;
begin
  with dtsProCom.DataSet do
  begin
    if not IsEmpty then
    begin
      intRecNo := RecNo;
      DisableControls;
      First;

      while not Eof do
      begin
        Edit;
        FieldByName('MARDES').AsString := IIF(blnMarcar, 'S', 'N');
        Post;

        Next;
      end;

      RecNo := intRecNo;
      EnableControls;
    end;
  end;
end;

procedure TfrmFatMostraComboProdVenda.pTrocaProdutos;
Var
  strCodIte: String;
  strDesIte: String;
  strRefere: String;
  strSigUni: String;
  strNumLot: String;
  fltPreVen: Double;
begin
  If (dtsProCom.DataSet.IsEmpty) Or
     (dtsProSim.DataSet.IsEmpty) Then
    Exit;

  setFilSim(False);

  strCodIte := dtsProCom.DataSet.FieldByName('CODITE').AsString;
  strDesIte := dtsProCom.DataSet.FieldByName('DESITE').AsString;
  strRefere := dtsProCom.DataSet.FieldByName('REFERE').AsString;
  strSigUni := dtsProCom.DataSet.FieldByName('SIGUNI').AsString;
  strNumLot := dtsProCom.DataSet.FieldByName('NUMLOT').AsString;
  fltPreVen := dtsProCom.DataSet.FieldByName('PREVEN').AsFloat;

  dtsProCom.DataSet.Edit;
  dtsProCom.DataSet.FieldByName('CODITE').AsString := dtsProSim.DataSet.FieldByName('CODITE').AsString;
  dtsProCom.DataSet.FieldByName('DESITE').AsString := dtsProSim.DataSet.FieldByName('DESITE').AsString;
  dtsProCom.DataSet.FieldByName('REFERE').AsString := dtsProSim.DataSet.FieldByName('REFERE').AsString;
  dtsProCom.DataSet.FieldByName('SIGUNI').AsString := dtsProSim.DataSet.FieldByName('SIGUNI').AsString;
  dtsProCom.DataSet.FieldByName('NUMLOT').AsString := dtsProSim.DataSet.FieldByName('NUMLOT').AsString;
  dtsProCom.DataSet.FieldByName('PREVEN').AsFloat  := dtsProSim.DataSet.FieldByName('PREVEN').AsFloat;
  dtsProCom.DataSet.FieldByName('MARDES').AsString := 'S';
  dtsProCom.DataSet.Post;

  dtsProSim.DataSet.Edit;
  dtsProSim.DataSet.FieldByName('SEQGER').AsString := dtsProCom.DataSet.FieldByName('AUTINC').AsString;
  dtsProSim.DataSet.FieldByName('CODITE').AsString := strCodIte;
  dtsProSim.DataSet.FieldByName('DESITE').AsString := strDesIte;
  dtsProSim.DataSet.FieldByName('REFERE').AsString := strRefere;
  dtsProSim.DataSet.FieldByName('SIGUNI').AsString := strSigUni;
  dtsProSim.DataSet.FieldByName('NUMLOT').AsString := strNumLot;
  dtsProSim.DataSet.FieldByName('PREVEN').AsFloat  := fltPreVen;
  dtsProSim.DataSet.Post;

  setFilSim(True);

end;

procedure TfrmFatMostraComboProdVenda.setFilSim(Value: Boolean);
begin
  blnFilSim := Value;
end;

end.
