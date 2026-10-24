unit untSelPedidoRequisicao;

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
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, cxCurrencyEdit, cxCheckBox,
  untRequisicaoPedidoCompra;

type
  TfrmSelPedidoRequisicao = class(TfrmPaiConfirma)
    cxvPedidos: TcxGridDBTableViewCitel;
    cxgPedidosLevel1: TcxGridLevel;
    cxgPedidos: TcxGridCitel;
    pnlCabec: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cxvPedidosDTAPED: TcxGridDBColumn;
    cxvPedidosDTAENT: TcxGridDBColumn;
    cxvPedidosNUMPED: TcxGridDBColumn;
    cxvPedidosCODFOR: TcxGridDBColumn;
    cxvPedidosNOMFOR: TcxGridDBColumn;
    cxvPedidosQTDITE: TcxGridDBColumn;
    cxvPedidosQTDREQ: TcxGridDBColumn;
    cxvPedidosQTDDIS: TcxGridDBColumn;
    cxvPedidosCODEMP: TcxGridDBColumn;
    cxvPedidosEMPDES: TcxGridDBColumn;
    DBEditFocus1: TDBEditFocus;
    DBEditFocus2: TDBEditFocus;
    DBEditFocus3: TDBEditFocus;
    DBEditFocus4: TDBEditFocus;
    DBEditFocus5: TDBEditFocus;
    Label6: TLabel;
    DBEditFocus6: TDBEditFocus;
    DBEditFocus7: TDBEditFocus;
    dtsRequisicao: TDataSource;
    cxvPedidosAUTDET: TcxGridDBColumn;
    btnMarDes: TBitBtnLocked;
    cxvPedidosAUTREQ: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxvPedidosDOCORI: TcxGridDBColumn;
    cxvPedidosSTATUS: TcxGridDBColumn;
    cxvPedidosORDCOM: TcxGridDBColumn;
    cxvPedidosNOTENT: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnMarDesClick(Sender: TObject);
    procedure cxvPedidosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    varCDSDisponiveisBkp,
    varCDSDataBkp: OleVariant;

  public
    { Public declarations }
    blnAlterouDados: Boolean;

    objRequisicao: TRequisicaoPedidoCompra;
  end;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples;

procedure TfrmSelPedidoRequisicao.btnMarDesClick(Sender: TObject);
begin
  inherited;

  With objRequisicao do
  If Pos(cdsRequisicao.FieldByName('AUTOINCREM').AsString, cdsPedidosdisponiveis.FieldByName('AUTREQ').AsString) > 0 Then
  Begin

    fDesmarcaPedidoDisponivel;

    blnAlterouDados := True;

  End

  Else If Not fEmptyStr(cdsRequisicao.FieldByName('AUTDET').AsString) Then
  Begin

    pMensagemOk('Essa requisição já tem um pedido associado, para selecionar um novo pedido desmarque o anterior!');

  End Else
  Begin

    If fPodeSelecionarPedidoDisponivel Then
    Begin

      objRequisicao.fSelecionaPedidoDisponivel;

      blnAlterouDados := True;

    End

  End;

end;

procedure TfrmSelPedidoRequisicao.cxvPedidosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If Pos(objRequisicao.cdsRequisicao.FieldByName('AUTOINCREM').AsString,
         VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvPedidosAUTREQ.Index])) > 0 Then

  Begin

    If AViewInfo.Selected Then
      ACanvas.Brush.Color := $008080FF
    Else
      ACanvas.Brush.Color := clRed;

    ACanvas.Font.Color := clBlack;

  End;

end;

procedure TfrmSelPedidoRequisicao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If modalResult = mrOk Then
  Begin

  End
  Else If blnAlterouDados Then
  Begin
    objRequisicao.cdsRequisicao.Data := varCDSDataBkp;
    objRequisicao.cdsPedidosDisponiveis.Data := varCDSDisponiveisBkp;

    objRequisicao.pFormataDisponiveis;
    objRequisicao.pFormataCdsRequisicao;
  End;

end;

procedure TfrmSelPedidoRequisicao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If fCheckParent(ActiveControl, cxgPedidos) Then
                 btnMarDes.Click;
  End;

end;

procedure TfrmSelPedidoRequisicao.FormShow(Sender: TObject);
begin
  inherited;
  cxvPedidosORDCOM.Visible := fCfgSis('RQPDBA', VarBoolean);
  cxvPedidosNOTENT.Visible := cxvPedidosORDCOM.Visible;
  blnAlterouDados := False;

  varCDSDataBkp        := objRequisicao.cdsRequisicao.Data;
  varCDSDisponiveisBkp := objRequisicao.cdsPedidosDisponiveis.Data;

  cxvPedidosSTATUS.Visible := objRequisicao.blnRQPDBA;
  cxvPedidos.OptionsView.ColumnAutoWidth := Not objRequisicao.blnRQPDBA;

  pSetFocus(cxgPedidos);
end;

end.
