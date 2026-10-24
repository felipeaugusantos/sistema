unit untImportCadProdutoVariacaoPreVen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, cxCurrencyEdit, untZClient, cxProgressBar;

type
  TfrmImportCadProdutoVariacaoPreVen = class(TfrmPai)
    cxgItens: TcxGrid;
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    dtsDados: TDataSource;
    cxgItensViewMARCADO: TcxGridDBColumn;
    btnMarcar: TBitBtnLocked;
    btnMarcAll: TBitBtnLocked;
    btnDesmAll: TBitBtnLocked;
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnMarcarClick(Sender: TObject);
    procedure btnMarcAllClick(Sender: TObject);
    procedure btnDesmAllClick(Sender: TObject);
  private
    blnMarcar: Boolean;
    procedure pMarcaDesmarcaTodos(blnMarca: boolean);
    function fMarcaDesmarcaTodosAux(prgProgresso: TcxProgressBar): Boolean;

    { Private declarations }
  protected
    cdsDadosAlt: TZClient;
  public
    { Public declarations }
    class procedure pExibeVariacao(AcdsDadosAlt: TZClient);

  end;

var
  frmImportCadProdutoVariacaoPreVen: TfrmImportCadProdutoVariacaoPreVen;

implementation

uses
  untFuncoesSimples, untGravando;

{$R *.dfm}

procedure TfrmImportCadProdutoVariacaoPreVen.btnDesmAllClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(False);

end;

procedure TfrmImportCadProdutoVariacaoPreVen.btnMarcAllClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(True);

end;

procedure TfrmImportCadProdutoVariacaoPreVen.btnMarcarClick(Sender: TObject);
begin
  inherited;
  cdsDadosAlt.Edit;
  cdsDadosAlt.FieldByName('MARCADO').AsInteger := IIf(cdsDadosAlt.FieldByName('MARCADO').AsInteger = 1, 0, 1);
  cdsDadosAlt.Post;

end;

procedure TfrmImportCadProdutoVariacaoPreVen.cxgItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  If cdsDadosAlt.RecordCount = 0 Then
    Exit;
  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewMARCADO.Index] = '1') Then
  Begin
    ACanvas.Brush.Color := clAqua;
    ACanvas.Font.Color := clBlack;
  End;
  If Pos('Novo', AViewInfo.Item.Caption) > 0 then
    ACanvas.Brush.Color := clMoneyGreen

end;

class procedure TfrmImportCadProdutoVariacaoPreVen.pExibeVariacao(AcdsDadosAlt: TZClient);
begin
  pCriarFormularios(TfrmImportCadProdutoVariacaoPreVen, frmImportCadProdutoVariacaoPreVen);
  Try
    frmImportCadProdutoVariacaoPreVen.dtsDados.DataSet := AcdsDadosAlt;
    frmImportCadProdutoVariacaoPreVen.cdsDadosAlt := AcdsDadosAlt;
    frmImportCadProdutoVariacaoPreVen.ShowModal;
  Finally
    FreeAndNil(frmImportCadProdutoVariacaoPreVen);
  End;

end;

procedure TfrmImportCadProdutoVariacaoPreVen.pMarcaDesmarcaTodos(blnMarca: boolean);
  var frmMarca: TfrmGravando;
begin
  blnMarcar := blnMarca;
  pCriarFormularios(TfrmGravando, frmMarca);
  Try
    frmMarca.lblGravando.Caption := 'Efetivando marcação dos itens...';
    frmMarca.fExecutarAcao := fMarcaDesmarcaTodosAux;
    frmMarca.Showmodal;
  Finally
    pFreeAndNil(frmMarca);
  End;
end;

function TfrmImportCadProdutoVariacaoPreVen.fMarcaDesmarcaTodosAux(prgProgresso: TcxProgressBar): Boolean;
begin
  prgProgresso.Properties.Max := cdsDadosAlt.RecordCount -1;
  cdsDadosAlt.DisableControls;
  Try
    cdsDadosAlt.First;
    While Not cdsDadosAlt.Eof Do
    Begin
      cdsDadosAlt.Edit;
      cdsDadosAlt.FieldByName('MARCADO').AsInteger := IIf(blnMarcar, 1, 0);
      cdsDadosAlt.Post;
      cdsDadosAlt.Next;
      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
    End;
    Result := True;
  Finally
    cdsDadosAlt.EnableControls;
  End;
end;



end.
