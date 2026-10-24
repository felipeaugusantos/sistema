unit untImportCadProdutoCamposAtualiza;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, untFuncoesSimples,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, cxGroupBox, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Datasnap.DBClient, UniClientDataSet, dxBarBuiltInMenu,
  cxGridCustomPopupMenu, cxGridPopupMenu, cxEditRepositoryItems;

type
  TfrmImportCadProdutoCamposAtualiza = class(TfrmPaiConfirma)
    cxGroupBox3: TcxGroupBox;
    lblOpSele: TLabel;
    cxGrid: TcxGrid;
    cxvCampos: TcxGridDBTableView;
    cxvCamposColuna: TcxGridDBColumn;
    cxvCamposMARDES: TcxGridDBColumn;
    cxvCamposDescricao: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    dtsCampos: TDataSource;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxEditRepository1: TcxEditRepository;
    chkMarDes: TcxEditRepositoryCheckBoxItem;
    cxGridPopupMenu1: TcxGridPopupMenu;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    popOpSele: TPopupMenu;
    MarcarTodos1: TMenuItem;
    DesmarcarTodos1: TMenuItem;
    N1: TMenuItem;
    InverterSeleo1: TMenuItem;
    cdsCampos: TUniClientDataSet;
    cdsCamposDESCRI: TStringField;
    cdsCamposCOLUNA: TStringField;
    cdsCamposMARDES: TStringField;
    cdsCamposINDEX: TIntegerField;
    cxvCamposIndex: TcxGridDBColumn;
    cdsCamposFIELD: TStringField;
    procedure lblOpSeleClick(Sender: TObject);
    procedure MarcarTodos1Click(Sender: TObject);
    procedure DesmarcarTodos1Click(Sender: TObject);
    procedure InverterSeleo1Click(Sender: TObject);
  private
    { Private declarations }
    function fContaSelecao: Integer;
    Procedure pOpcaoSelecao(strOpcao : Char);
  public
    { Public declarations }
  end;

var
  frmImportCadProdutoCamposAtualiza: TfrmImportCadProdutoCamposAtualiza;

implementation

{$R *.dfm}

procedure TfrmImportCadProdutoCamposAtualiza.DesmarcarTodos1Click(
  Sender: TObject);
begin
  inherited;
  pOpcaoSelecao('N');
end;

function TfrmImportCadProdutoCamposAtualiza.fContaSelecao: Integer;
  Var
    strBookMark : TBookmark;
Begin
  Try
    Result := 0;
    cdsCampos.DisableControls;
    strBookMark := cdsCampos.Bookmark;
    cdsCampos.First;
    While Not cdsCampos.Eof Do
    Begin
      If cdsCampos.FieldByName('MARDES').AsString = 'S' Then
        Inc(Result);
      cdsCampos.Next;
    End;
  Finally
    cdsCampos.Bookmark := strBookMark;
    cdsCampos.EnableControls;
  End;
End;

procedure TfrmImportCadProdutoCamposAtualiza.InverterSeleo1Click(
  Sender: TObject);
begin
  inherited;
  pOpcaoSelecao('I');
end;

procedure TfrmImportCadProdutoCamposAtualiza.lblOpSeleClick(Sender: TObject);
  Var
    intQtdSel : Integer;
    curPos    : TPoint;
begin
  inherited;
  intQtdSel := fContaSelecao;

  MarcarTodos1.Enabled    := (intQtdSel < cdsCampos.RecordCount);
  DesmarcarTodos1.Enabled := (intQtdSel > 0);

  GetCursorPos(curPos);
  popOpSele.Popup(curPos.X + 2, curPos.Y + 2);
end;

procedure TfrmImportCadProdutoCamposAtualiza.MarcarTodos1Click(Sender: TObject);
begin
  inherited;
  pOpcaoSelecao('S');
end;

procedure TfrmImportCadProdutoCamposAtualiza.pOpcaoSelecao(strOpcao: Char);
  var
    strBookMark : TBookmark;
begin
  // strOpcao
  // S - Marcar Todos
  // N - Desmarcar Todos
  // I - Inverter Seleção;
  try
    strBookMark := cdsCampos.Bookmark;
    cdsCampos.DisableControls;
    cdsCampos.First;

    While Not cdsCampos.Eof Do
    Begin
      cdsCampos.Edit;
      Case strOpcao Of
        'S',
        'N' : cdsCampos.FieldByName('MARDES').AsString := strOpcao;
        'I' : cdsCampos.FieldByName('MARDES').AsString := IIF(cdsCampos.FieldByName('MARDES').AsString = 'S', 'N', 'S');
      End;
      cdsCampos.Post;
      cdsCampos.Next;
    End;

  Finally
    cdsCampos.EnableControls;
    cdsCampos.Bookmark := strBookMark;
  End;
end;

end.

