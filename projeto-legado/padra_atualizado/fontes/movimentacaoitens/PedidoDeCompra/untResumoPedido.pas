unit untResumoPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCurrencyEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxCheckBox,
  untPastaCompra, cxDBLookupComboBox;

type
  TfrmResumoPedido = class(TfrmPaiConfirma)
    cxgFiliais: TcxGrid;
    cxvFiliais: TcxGridDBTableView;
    cxvFiliaisSIGEMP: TcxGridDBColumn;
    cxvFiliaisCODEMP: TcxGridDBColumn;
    cxvFiliaisVALMIN: TcxGridDBColumn;
    cxvFiliaisVALCOM: TcxGridDBColumn;
    cxvFiliaisNOMEMP: TcxGridDBColumn;
    cxgFiliaisLevel1: TcxGridLevel;
    cxvFiliaisGERARP: TcxGridDBColumn;
    cxvFiliaisTOTQTD: TcxGridDBColumn;
    cxvFiliaisTOTKIL: TcxGridDBColumn;
    cxvFiliaisTOTLIT: TcxGridDBColumn;
    cxvFiliaisTOTMET: TcxGridDBColumn;
    cxvFiliaisDIVQTD: TcxGridDBColumn;
    cxvFiliaisDIVPES: TcxGridDBColumn;
    cxvFiliaisDIVLIT: TcxGridDBColumn;
    cxvFiliaisDIVMET: TcxGridDBColumn;
    pnlLegenda: TPanel;
    cxvFiliaisPRA_MINQTD: TcxGridDBColumn;
    cxvFiliaisPRA_MINMET: TcxGridDBColumn;
    cxvFiliaisPRA_MINLIT: TcxGridDBColumn;
    cxvFiliaisPRA_MINPES: TcxGridDBColumn;
    lblLegenda: TLabel;
    cxvFiliaisEmpGer: TcxGridDBColumn;
    chkCnvEmb: TCheckBox;
    cxvFiliaisDESBAN: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxvFiliaisCanFocusRecord(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; var AAllow: Boolean);
    procedure cxvFiliaisTOTLITCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxvFiliaisTOTKILCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxvFiliaisTOTQTDCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxvFiliaisTOTMETCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    { Private declarations }
    objPastaCompra: TPastaCompra;
    function fLegendaVisivel(indexRow: Integer): Boolean;
  public
    { Public declarations }
    blnGerouPedido: Boolean;
    blnGerarPedido: Boolean;
    strCodFor: String;
    strConPag: String;
  end;

var
  frmResumoPedido: TfrmResumoPedido;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples;

procedure TfrmResumoPedido.cxvFiliaisCanFocusRecord(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; var AAllow: Boolean);
begin
  inherited;
  pnlLegenda.Visible := fLegendaVisivel(ARecord.RecordIndex);
  If pnlLegenda.Visible Then
  Begin
    lblLegenda.Caption := 'Quantidade Mínima do Pedido de Compra(UN):' + fPadL(FormatFloat('###,###,##0.0000', Sender.DataController.Values[ARecord.RecordIndex, cxvFiliaisPRA_MINQTD.Index]), 13) + #13 +
                          'Peso Mínimo do Pedido de Compra(KG)......:' + fPadL(FormatFloat('###,###,##0.0000', Sender.DataController.Values[ARecord.RecordIndex, cxvFiliaisPRA_MINPES.Index]), 13) + #13 +
                          'Litragem Mínima do Pedido de Compra(LT)..:' + fPadL(FormatFloat('###,###,##0.0000', Sender.DataController.Values[ARecord.RecordIndex, cxvFiliaisPRA_MINLIT.Index]), 13) + #13 +
                          'Metragem Mínima do Pedido de compra(MT)..:' + fPadL(FormatFloat('###,###,##0.0000', Sender.DataController.Values[ARecord.RecordIndex, cxvFiliaisPRA_MINMET.Index]), 13);
  End
end;

procedure TfrmResumoPedido.cxvFiliaisTOTKILCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvFiliaisDIVPES.Index] = 'S') Then
    ACanvas.Brush.Color := clRed;
end;

procedure TfrmResumoPedido.cxvFiliaisTOTLITCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvFiliaisDIVLIT.Index] = 'S') Then
    ACanvas.Brush.Color := clRed;
end;

procedure TfrmResumoPedido.cxvFiliaisTOTMETCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
  inherited;
  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvFiliaisDIVMET.Index] = 'S') Then
    ACanvas.Brush.Color := clRed;

end;

procedure TfrmResumoPedido.cxvFiliaisTOTQTDCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
  inherited;
  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvFiliaisDIVQTD.Index] = 'S') Then
    ACanvas.Brush.Color := clRed;
end;

function TfrmResumoPedido.fLegendaVisivel(indexRow: Integer): Boolean;
begin
 Result := (cxvFiliaisTOTQTD.Visible) And
           ((cxvFiliais.DataController.Values[indexRow, cxvFiliaisDIVQTD.Index] = 'S') Or
            (cxvFiliais.DataController.Values[indexRow, cxvFiliaisDIVPES.Index] = 'S') Or
            (cxvFiliais.DataController.Values[indexRow, cxvFiliaisDIVLIT.Index] = 'S') Or
            (cxvFiliais.DataController.Values[indexRow, cxvFiliaisDIVMET.Index] = 'S'));
end;

procedure TfrmResumoPedido.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    If Not objPastaCompra.fTemFilialSelecionada Then
    Begin
      pMensagemOk('Selecione os pedidos que serão gerados!');
      Action := caNone;
      Exit;
    End;
    objPastaCompra.strConPag := strConPag;
    objPastaCompra.strCodFor := strCodFor;
    objPastaCompra.blnCnvEmb := chkCnvEmb.Checked;

    blnGerouPedido := objPastaCompra.fGeraPedidosResumo;

    If Not blnGerouPedido Then
      Action := caNone;

  End;

end;

procedure TfrmResumoPedido.FormCreate(Sender: TObject);
begin
  inherited;

  blnGerouPedido := False;
  blnGerarPedido := False;
  objPastaCompra := TPastaCompra.Create(Self);
  chkCnvEmb.Visible := fCfgSis('CNVEMB') ='S';

  cxvFiliais.DataController.DataSource := objPastaCompra.objResumoEmpresa.dtsSource;
end;

procedure TfrmResumoPedido.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: btnConfirma.Click;
  End;
end;

procedure TfrmResumoPedido.FormShow(Sender: TObject);
  var
    AAlow: Boolean;
begin
  inherited;
  cxvFiliaisTOTQTD.Visible := strCodFor <> '';
  cxvFiliaisTOTKIL.Visible := strCodFor <> '';
  cxvFiliaisTOTLIT.Visible := strCodFor <> '';
  cxvFiliaisTOTMET.Visible := strCodFor <> '';

  If Not cxvFiliaisTOTQTD.Visible Then
    Self.Width := Self.Width - cxvFiliaisTOTQTD.Width;

  If Not cxvFiliaisTOTKIL.Visible Then
    Self.Width := Self.Width - cxvFiliaisTOTKIL.Width;

  If Not cxvFiliaisTOTLIT.Visible Then
    Self.Width := Self.Width - cxvFiliaisTOTLIT.Width;

  If Not cxvFiliaisTOTMET.Visible Then
    Self.Width := Self.Width - cxvFiliaisTOTMET.Width;

  objPastaCompra.fCarregaResumo('', strCodFor, blnGerarPedido);
  If cxvFiliaisTOTQTD.Visible Then
    cxvFiliaisCanFocusRecord(cxvFiliais, cxvFiliais.Controller.FocusedRow, AAlow);

  cxvFiliaisEmpGer.Visible := (Not objPastaCompra.objResumoEmpresa.IsEmpty) And
                              (objPastaCompra.objResumoEmpresa.FieldByName('EMPPAS').AsString = 'S');

  If cxvFiliaisEmpGer.Visible Then
    TcxLookupComboBoxProperties(cxvFiliaisEmpGer.Properties).ListSource := objPastaCompra.cdsEmpresas.dtsSource
  Else
    Self.Width := Self.Width - cxvFiliaisEmpGer.Width;

end;

end.
