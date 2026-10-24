unit untEditorLayoutPedidoCompra;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid,untLayoutImportacaoPedidoCompra,
  Vcl.Samples.Spin, strUtils, fs_iinterpreter;

type
  TfrmEditorLayoutPedidoCompra = class(TfrmPaiConfirma)
    Panel1: TPanel;
    cxCampos: TcxGrid;
    cxCamposDB: TcxGridDBTableView;
    cxCamposLvl: TcxGridLevel;
    dtsCampos: TDataSource;
    cxCamposDBColumn1: TcxGridDBColumn;
    cxCamposDBColuna: TcxGridDBColumn;
    edtNomLayout: TEdit;
    edtPosIniArquiv: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    fsScript1: TfsScript;
    pnlHintCodigo: TPanel;
    Label3: TLabel;
    procedure cxCamposDBCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure cxCamposDBCanFocusRecord(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; var AAllow: Boolean);
  private
    { Private declarations }

  public
    TipoVisao: TTipoVisao;
    ObjImportaPlanilhaPedidoCompra: TImportaPlanilhaPedidoCompra;

    { Public declarations }
  end;

var
  frmEditorLayoutPedidoCompra: TfrmEditorLayoutPedidoCompra;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmEditorLayoutPedidoCompra.btnConfirmaClick(Sender: TObject);
begin
  inherited;
    {}
end;

procedure TfrmEditorLayoutPedidoCompra.cxCamposDBCanFocusRecord(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
begin
  inherited;
  If TipoVisao <> tvVisualizacao Then
     ObjImportaPlanilhaPedidoCompra.pFazBackup;
end;

procedure TfrmEditorLayoutPedidoCompra.cxCamposDBCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If Not VarIsNull(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxCamposDBColuna.Index]) Then
  Begin
    If Not fEmptyStr(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxCamposDBColuna.Index])) Then
      ACanvas.Brush.Color := clMoneyGreen;
  End;

end;

function TfrmEditorLayoutPedidoCompra.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If Sender = edtNomLayout Then
  Begin
    If fEmptyStr(edtNomLayout.Text) Then
    Begin
      Result := False;
      pMensagemOk('A descrição do layout deve ser preenchido.');
    End;
  End
  Else If Sender = edtPosIniArquiv Then
  Begin
    If edtPosIniArquiv.Value < 0 Then
    Begin
      edtPosIniArquiv.Value := 0;
      pMensagemOk('O campo "Inicio dos Itens no Arquivo" deve ser Maior ou igual a zero.');
      Result := False;
    End;
  End;
  If Not Result Then
    pSetFocus(Sender)
end;

end.
