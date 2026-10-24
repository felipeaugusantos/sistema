unit untTransfArmazensImportacaoConfirma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, UniClientDataSet;

type
  TfrmTransfArmazensImportacaoConfirma = class(TfrmPaiConfirma)
    cxgItens: TcxGrid;
    cxgItensView: TcxGridDBTableView;
    cxgItensViewCodIte: TcxGridDBColumn;
    cxgItensViewDesIte: TcxGridDBColumn;
    cxgItensLevel1: TcxGridLevel;
    cxgItensViewLOTORI: TcxGridDBColumn;
    cxgItensViewLOTDES: TcxGridDBColumn;
    cxgItensViewITEQTD: TcxGridDBColumn;
    dsItens: TDataSource;
    cxgItensViewSTATUS: TcxGridDBColumn;
    cxgItensViewERRO: TcxGridDBColumn;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lblSucesso: TLabel;
    lblErro: TLabel;
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormShow(Sender: TObject);
  private
    FstrNomSing: string;
    FstrNomPlur: string;
    { Private declarations }
  public
    { Public declarations }
    function Confirmar(cdsItens: TUniClientDataSet): boolean;
    property strNomSing: string read FstrNomSing write FstrNomSing;
    property strNomPlur: string read FstrNomPlur write FstrNomPlur;
  end;

implementation

{$R *.dfm}

{ TfrmTransfArmazensImportacaoConfirma }

procedure TfrmTransfArmazensImportacaoConfirma.cxgItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensViewSTATUS.Index] = 'Erro') then
    ACanvas.Brush.Color := StrToInt('$008080FF')
  else
    ACanvas.Brush.Color := StrToInt('$0080FF80')
end;

procedure TfrmTransfArmazensImportacaoConfirma.FormShow(Sender: TObject);
begin
  inherited;
  cxgItensViewLOTORI.Caption := strNomSing + ' origem';
  cxgItensViewLOTDES.Caption := strNomSing + ' destino';
  Self.Caption := 'Importação Transferência entre ' + strNomPlur + ' - Confirmação'
end;

function TfrmTransfArmazensImportacaoConfirma.Confirmar(cdsItens: TUniClientDataSet): Boolean;
begin
  cdsItens.Filtered := False;
  cdsItens.Filter := 'STATUS = ''Sucesso''';
  cdsItens.Filtered := True;
  lblSucesso.Caption := IntToStr(cdsItens.RecordCount);


  cdsItens.Filtered := False;
  cdsItens.Filter := 'STATUS = ''Erro''';
  cdsItens.Filtered := True;
  lblErro.Caption := IntToStr(cdsItens.RecordCount);

  cdsItens.Filtered := False;
  dsItens.DataSet := cdsItens;

  btnConfirma.Enabled := StrToInt(lblSucesso.Caption) > 0;

  cxgItensView.DataController.Groups.FullExpand;

  Result := ShowModal = MrOk;
end;

end.
