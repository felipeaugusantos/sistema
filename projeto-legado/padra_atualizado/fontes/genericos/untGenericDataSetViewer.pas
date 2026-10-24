unit untGenericDataSetViewer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Math, ActnList, StdCtrls,  ExtCtrls, Buttons, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, System.Actions,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmGenericDataSetViewer = class(TForm)
    dbgvDados: TcxGridDBTableView;
    dbglDados: TcxGridLevel;
    dbgDados: TcxGrid;
    dtsDados: TDataSource;
    actlstAtalhos: TActionList;
    actEsc: TAction;
    mmoTexto: TMemo;
    pnlComandos: TPanel;
    btnSair: TBitBtnLocked;
    procedure actEscExecute(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
    qryDados: TDataSet;
    blnSomenteLeitura: Boolean;

    procedure ConstruirGrid;
    procedure ConstruirTela;
    function GetMemoHeight: Integer;
  public
    constructor Create(AOwner: TComponent; const qryDados: TDataSet; const strTitulo: string;
      const strTextoAdicional: string; const blnSomenteLeitura: Boolean = False); reintroduce;

    property DataSet: TDataSet read qryDados;
    { Public declarations }
  end;

var
  frmGenericDataSetViewer: TfrmGenericDataSetViewer;

implementation

uses untFuncoesSimples, System.Types;

{$R *.dfm}

{ TfrmGenericDataSetViewer }

procedure TfrmGenericDataSetViewer.actEscExecute(Sender: TObject);
begin
  btnSair.Click;
end;

procedure TfrmGenericDataSetViewer.btnSairClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmGenericDataSetViewer.ConstruirGrid;
begin
  qryDados.Active := True;
  dtsDados.AutoEdit := not blnSomenteLeitura;
  dtsDados.DataSet := Self.qryDados;

  dbgvDados.ClearItems;
  dbgvDados.DataController.CreateAllItems();
  dbgvDados.ApplyBestFit();
end;

procedure TfrmGenericDataSetViewer.ConstruirTela;
var
  intCont: Integer;
  intLarguraColunas: Integer;
  intAltura: Integer;
begin
  intLarguraColunas := 0;
  for intCont := 0 to dbgvDados.ColumnCount - 1 do
  begin
    intLarguraColunas := intLarguraColunas + dbgvDados.Columns[intCont].Width;
  end;
  intLarguraColunas := intLarguraColunas + (2 * GetSystemMetrics(SM_CXVSCROLL));
  
  intAltura := 0;  
  if not fEmptyStr(mmoTexto.Lines.Text) then
  begin
    intAltura := intAltura + GetMemoHeight;
  end;

  intAltura := intAltura + (qryDados.RecordCount + 2) * 18;
  intAltura := intAltura + (GetSystemMetrics(SM_CXHSCROLL));
  intAltura := intAltura + pnlComandos.Height;

  Self.ClientWidth := Min(intLarguraColunas, 800);
  Self.ClientHeight := Min(intAltura, 600);
end;

constructor TfrmGenericDataSetViewer.Create(AOwner: TComponent; const qryDados: TDataSet; const strTitulo: string;
  const strTextoAdicional: string; const blnSomenteLeitura: Boolean);
begin
  inherited Create(AOwner);
  Self.qryDados := qryDados;
  Self.Caption := strTitulo;
  Self.blnSomenteLeitura := blnSomenteLeitura;
  Self.mmoTexto.Text := Trim(strTextoAdicional);
  
  ConstruirGrid;
  ConstruirTela;
end;

function TfrmGenericDataSetViewer.GetMemoHeight: Integer;
var
  DC: HDC;
  saveFont: HFONT;
  size: TSize;
begin

  Result   := 0;
  DC       := GetDC(mmoTexto.Handle);
  saveFont := SelectObject(DC, mmoTexto.Font.Handle);
  Try
    Try
      size.cx := 0;
      size.cy := 0;
      Windows.GetTextExtentPoint32(DC, '|', 1, size);
      Result := (mmoTexto.Lines.Count * size.cy) + (2 * GetSystemMetrics(SM_CXHSCROLL));
      Result := Min(Result, 90);
      mmoTexto.Height := Result;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    SelectObject(DC, saveFont);
    ReleaseDC(mmoTexto.Handle, DC);
  End;
end;

end.
