unit Garantia.TfrmValidacaoEspelhoXMLView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, cxCurrencyEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView,
  cxClasses, cxGridCustomView, cxGrid, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGridDBTableView, MemDS, DBAccess,
  Uni, Datasnap.DBClient, UniClientDataSet, System.UITypes,

  Garantia.TValidacaoEspelhoXML;

type
  TfrmValidacaoEspelhoXMLView = class(TfrmPaiConfirma)
    cxgItens: TcxGrid;
    cxgItensView: TcxGridDBTableView;
    cxgItensCODIGO_PRODUTO: TcxGridDBColumn;
    cxgItensDESCRICAO_PRODUTO: TcxGridDBColumn;
    cxItensCODIGO_FABRICA: TcxGridDBColumn;
    cxgItensREFERENCIA: TcxGridDBColumn;
    cxgItensSIGLA_UNIDADE: TcxGridDBColumn;
    cxgItensCLASSIFICACAO_FISCAL: TcxGridDBColumn;
    cxgItensCST: TcxGridDBColumn;
    cxgItensBASE_ICMS: TcxGridDBColumn;
    cxgItensALIQUOTA_ICMS: TcxGridDBColumn;
    cxgItensVALOR_ICMS: TcxGridDBColumn;
    cxgItensBASE_SUBSTITUICAO_TRIBUTARIA: TcxGridDBColumn;
    cxgItensVALOR_SUBSTITUICAO_TRIBUTARIA: TcxGridDBColumn;
    cxgItensBASE_IPI: TcxGridDBColumn;
    cxgItensALIQUOTA_IPI: TcxGridDBColumn;
    cxgItensVALOR_IPI: TcxGridDBColumn;
    cxgItensVALIDACAO_VALOR_BRUTO: TcxGridDBColumn;
    cxgItensLevel1: TcxGridLevel;
    dtsValidacao: TDataSource;
    cxgItensVALOR_BRUTO: TcxGridDBColumn;
    cxgItensQUANTIDADE: TcxGridDBColumn;
    cxgItensDESCONTO: TcxGridDBColumn;
    cxgItensBASE_FUNDO_COMBATE_POBREZA_ST: TcxGridDBColumn;
    cxgItensALIQUOTA_FUNDO_COMBATE_POBREZA_ST: TcxGridDBColumn;
    cxgItensVALOR_FUNDO_COMBATE_POBREZA_ST: TcxGridDBColumn;
    cxgItensBASE_FUNDO_COMBATE_POBREZA: TcxGridDBColumn;
    cxgItensALIQUOTA_FUNDO_COMBATE_POBREZA: TcxGridDBColumn;
    cxgItensVALOR_FUNDO_COMBATE_POBREZA: TcxGridDBColumn;
    cxgItensVALIDACAO_QUANTIDADE: TcxGridDBColumn;
    cxgItensVALIDACAO_BASE_ICMS: TcxGridDBColumn;
    cxgItensVALIDACAO_ALIQUOTA_ICMS: TcxGridDBColumn;
    cxgItensVALIDACAO_VALOR_ICMS: TcxGridDBColumn;
    cxgItensVALIDACAO_BASE_SUBSTITUICAO_TRIBUTARIA: TcxGridDBColumn;
    cxgItensVALIDACAO_VALOR_SUBSTITUICAO_TRIBUTARIA: TcxGridDBColumn;
    cxgItensVALIDACAO_BASE_IPI: TcxGridDBColumn;
    cxgItensVALIDACAO_ALIQUOTA_IPI: TcxGridDBColumn;
    cxgItensVALIDACAO_VALOR_IPI: TcxGridDBColumn;
    cxgItensVALIDACAO_CST: TcxGridDBColumn;
    cxgItensVALIDACAO_DESCONTO: TcxGridDBColumn;
    cxgItensVALIDACAO_BASE_FUNDO_COMBATE_POBREZA_ST: TcxGridDBColumn;
    cxgItensVALIDACAO_ALIQUOTA_FUNDO_COMBATE_POBREZA_ST: TcxGridDBColumn;
    cxgItensVALIDACAO_VALOR_FUNDO_COMBATE_POBREZA_ST: TcxGridDBColumn;
    cxgItensVALIDACAO_BASE_FUNDO_COMBATE_POBREZA: TcxGridDBColumn;
    cxgItensVALIDACAO_ALIQUOTA_FUNDO_COMBATE_POBREZA: TcxGridDBColumn;
    cxgItensVALIDACAO_VALOR_FUNDO_COMBATE_POBREZA: TcxGridDBColumn;
    cxgItensVALIDACAO_CLASSIFICACAO_FISCAL: TcxGridDBColumn;
    Panel1: TPanel;
    shpXML: TShape;
    Label1: TLabel;
    shpEspelho: TShape;
    Label2: TLabel;
    shpErro: TShape;
    Label3: TLabel;
    cxgItensTIPO: TcxGridDBColumn;
    cxgItensVALIDACAO_DESCRICAO: TcxGridDBColumn;
    cxgItensVALIDO: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxgItensCLASSIFICACAO_FISCALCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensCSTCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensQUANTIDADECustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensVALOR_BRUTOCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensDESCONTOCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensBASE_ICMSCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensALIQUOTA_ICMSCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensVALOR_ICMSCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensBASE_SUBSTITUICAO_TRIBUTARIACustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensVALOR_SUBSTITUICAO_TRIBUTARIACustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensBASE_IPICustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensALIQUOTA_IPICustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensVALOR_IPICustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensBASE_FUNDO_COMBATE_POBREZA_STCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensALIQUOTA_FUNDO_COMBATE_POBREZA_STCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensVALOR_FUNDO_COMBATE_POBREZA_STCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensDESCRICAO_PRODUTOCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensCODIGO_PRODUTOCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxItensCODIGO_FABRICACustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensREFERENCIACustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensSIGLA_UNIDADECustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensALIQUOTA_FUNDO_COMBATE_POBREZACustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensBASE_FUNDO_COMBATE_POBREZACustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensVALOR_FUNDO_COMBATE_POBREZACustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    qryESPDET    : TUniQuery;
    qryDETELE    : TUniQuery;

    objValidacao : TValidacaoEspelhoXML;
    { Private declarations }
  public
    strCodigoAD         : String;
    strAutoincremGERELE : String;
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untLiberacao;

{$R *.dfm}

procedure TfrmValidacaoEspelhoXMLView.cxgItensALIQUOTA_FUNDO_COMBATE_POBREZA_STCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
  ACanvas.Brush.Color :=  objValidacao.fRetornaCorFundoCelula( ACanvas.Brush.Color, Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVALIDACAO_ALIQUOTA_FUNDO_COMBATE_POBREZA_ST.Index] );
  ACanvas.Font.Color  :=  objValidacao.fRetornaCorFonteCelula( Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTIPO.Index] );
end;

procedure TfrmValidacaoEspelhoXMLView.cxgItensALIQUOTA_FUNDO_COMBATE_POBREZACustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
  ACanvas.Brush.Color :=  objValidacao.fRetornaCorFundoCelula( ACanvas.Brush.Color, Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVALIDACAO_ALIQUOTA_FUNDO_COMBATE_POBREZA.Index] );
  ACanvas.Font.Color  :=  objValidacao.fRetornaCorFonteCelula( Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTIPO.Index] );
end;

procedure TfrmValidacaoEspelhoXMLView.cxgItensALIQUOTA_ICMSCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  ACanvas.Brush.Color :=  objValidacao.fRetornaCorFundoCelula( ACanvas.Brush.Color, Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVALIDACAO_ALIQUOTA_ICMS.Index] );
  ACanvas.Font.Color  :=  objValidacao.fRetornaCorFonteCelula( Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTIPO.Index] );
end;

procedure TfrmValidacaoEspelhoXMLView.cxgItensALIQUOTA_IPICustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  ACanvas.Brush.Color :=  objValidacao.fRetornaCorFundoCelula( ACanvas.Brush.Color, Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVALIDACAO_ALIQUOTA_IPI.Index] );
  ACanvas.Font.Color  :=  objValidacao.fRetornaCorFonteCelula( Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTIPO.Index] );
end;

procedure TfrmValidacaoEspelhoXMLView.cxgItensBASE_FUNDO_COMBATE_POBREZA_STCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  ACanvas.Brush.Color :=  objValidacao.fRetornaCorFundoCelula( ACanvas.Brush.Color, Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVALIDACAO_BASE_FUNDO_COMBATE_POBREZA_ST.Index] );
  ACanvas.Font.Color  :=  objValidacao.fRetornaCorFonteCelula( Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTIPO.Index] );
end;

procedure TfrmValidacaoEspelhoXMLView.cxgItensBASE_FUNDO_COMBATE_POBREZACustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  ACanvas.Brush.Color :=  objValidacao.fRetornaCorFundoCelula( ACanvas.Brush.Color, Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVALIDACAO_BASE_FUNDO_COMBATE_POBREZA.Index] );
  ACanvas.Font.Color  :=  objValidacao.fRetornaCorFonteCelula( Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTIPO.Index] );
end;

procedure TfrmValidacaoEspelhoXMLView.cxgItensBASE_ICMSCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  ACanvas.Brush.Color :=  objValidacao.fRetornaCorFundoCelula( ACanvas.Brush.Color, Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVALIDACAO_BASE_ICMS.Index] );
  ACanvas.Font.Color  :=  objValidacao.fRetornaCorFonteCelula( Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTIPO.Index] );
end;

procedure TfrmValidacaoEspelhoXMLView.cxgItensBASE_IPICustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  ACanvas.Brush.Color :=  objValidacao.fRetornaCorFundoCelula( ACanvas.Brush.Color, Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVALIDACAO_BASE_IPI.Index] );
  ACanvas.Font.Color  :=  objValidacao.fRetornaCorFonteCelula( Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTIPO.Index] );
end;

procedure TfrmValidacaoEspelhoXMLView.cxgItensBASE_SUBSTITUICAO_TRIBUTARIACustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
  ACanvas.Brush.Color :=  objValidacao.fRetornaCorFundoCelula( ACanvas.Brush.Color, Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVALIDACAO_BASE_SUBSTITUICAO_TRIBUTARIA.Index] );
  ACanvas.Font.Color  :=  objValidacao.fRetornaCorFonteCelula( Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTIPO.Index] );
end;

procedure TfrmValidacaoEspelhoXMLView.cxgItensCLASSIFICACAO_FISCALCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  ACanvas.Brush.Color :=  objValidacao.fRetornaCorFundoCelula( ACanvas.Brush.Color, Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVALIDACAO_CLASSIFICACAO_FISCAL.Index] );
  ACanvas.Font.Color  :=  objValidacao.fRetornaCorFonteCelula( Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTIPO.Index] );
end;

procedure TfrmValidacaoEspelhoXMLView.cxgItensCODIGO_PRODUTOCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  ACanvas.Brush.Color :=  objValidacao.fRetornaCorFundoCelula( ACanvas.Brush.Color, Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVALIDO.Index] );
  ACanvas.Font.Color  :=  objValidacao.fRetornaCorFonteCelula( Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTIPO.Index] );
end;

procedure TfrmValidacaoEspelhoXMLView.cxgItensCSTCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Brush.Color :=  objValidacao.fRetornaCorFundoCelula( ACanvas.Brush.Color, Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVALIDACAO_CST.Index] );
  ACanvas.Font.Color  :=  objValidacao.fRetornaCorFonteCelula( Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTIPO.Index] );
end;

procedure TfrmValidacaoEspelhoXMLView.cxgItensDESCONTOCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  ACanvas.Brush.Color :=  objValidacao.fRetornaCorFundoCelula( ACanvas.Brush.Color, Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVALIDACAO_DESCONTO.Index] );
  ACanvas.Font.Color  :=  objValidacao.fRetornaCorFonteCelula( Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTIPO.Index] );
end;

procedure TfrmValidacaoEspelhoXMLView.cxgItensDESCRICAO_PRODUTOCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  ACanvas.Brush.Color :=  objValidacao.fRetornaCorFundoCelula( ACanvas.Brush.Color, Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVALIDACAO_DESCRICAO.Index] );
end;

procedure TfrmValidacaoEspelhoXMLView.cxgItensQUANTIDADECustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  ACanvas.Brush.Color :=  objValidacao.fRetornaCorFundoCelula( ACanvas.Brush.Color, Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVALIDACAO_QUANTIDADE.Index] );
  ACanvas.Font.Color  :=  objValidacao.fRetornaCorFonteCelula( Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTIPO.Index] );
end;

procedure TfrmValidacaoEspelhoXMLView.cxgItensREFERENCIACustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  ACanvas.Font.Color  :=  objValidacao.fRetornaCorFonteCelula( Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTIPO.Index] );
end;

procedure TfrmValidacaoEspelhoXMLView.cxgItensSIGLA_UNIDADECustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  ACanvas.Font.Color  :=  objValidacao.fRetornaCorFonteCelula( Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTIPO.Index] );
end;

procedure TfrmValidacaoEspelhoXMLView.cxgItensVALOR_BRUTOCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  ACanvas.Brush.Color :=  objValidacao.fRetornaCorFundoCelula( ACanvas.Brush.Color, Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVALIDACAO_VALOR_BRUTO.Index] );
  ACanvas.Font.Color  :=  objValidacao.fRetornaCorFonteCelula( Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTIPO.Index] );
end;

procedure TfrmValidacaoEspelhoXMLView.cxgItensVALOR_FUNDO_COMBATE_POBREZA_STCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
  ACanvas.Brush.Color :=  objValidacao.fRetornaCorFundoCelula( ACanvas.Brush.Color, Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVALIDACAO_VALOR_FUNDO_COMBATE_POBREZA_ST.Index] );
  ACanvas.Font.Color  :=  objValidacao.fRetornaCorFonteCelula( Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTIPO.Index] );
end;

procedure TfrmValidacaoEspelhoXMLView.cxgItensVALOR_FUNDO_COMBATE_POBREZACustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
  ACanvas.Brush.Color :=  objValidacao.fRetornaCorFundoCelula( ACanvas.Brush.Color, Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVALIDACAO_VALOR_FUNDO_COMBATE_POBREZA.Index] );
  ACanvas.Font.Color  :=  objValidacao.fRetornaCorFonteCelula( Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTIPO.Index] );
end;


procedure TfrmValidacaoEspelhoXMLView.cxgItensVALOR_ICMSCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  ACanvas.Brush.Color :=  objValidacao.fRetornaCorFundoCelula( ACanvas.Brush.Color, Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVALIDACAO_VALOR_ICMS.Index] );
  ACanvas.Font.Color  :=  objValidacao.fRetornaCorFonteCelula( Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTIPO.Index] );
end;

procedure TfrmValidacaoEspelhoXMLView.cxgItensVALOR_IPICustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  ACanvas.Brush.Color :=  objValidacao.fRetornaCorFundoCelula( ACanvas.Brush.Color, Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVALIDACAO_VALOR_IPI.Index] );
  ACanvas.Font.Color  :=  objValidacao.fRetornaCorFonteCelula( Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTIPO.Index] );
end;

procedure TfrmValidacaoEspelhoXMLView.cxgItensVALOR_SUBSTITUICAO_TRIBUTARIACustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
  ACanvas.Brush.Color :=  objValidacao.fRetornaCorFundoCelula( ACanvas.Brush.Color, Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensVALIDACAO_VALOR_SUBSTITUICAO_TRIBUTARIA.Index] );
  ACanvas.Font.Color  :=  objValidacao.fRetornaCorFonteCelula( Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTIPO.Index] );
end;

procedure TfrmValidacaoEspelhoXMLView.cxItensCODIGO_FABRICACustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  ACanvas.Font.Color  :=  objValidacao.fRetornaCorFonteCelula( Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensTIPO.Index] );
end;

procedure TfrmValidacaoEspelhoXMLView.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  objLiberacao : TLiberacao;
begin
  inherited;
  if ModalResult = mrOk then
  begin
    if objValidacao.fExisteDivergencia then
    begin
      objLiberacao := TLiberacao.Create;
      try
        objLiberacao.strDirAce := 'LXMLAD';
        objLiberacao.strMsgSen := 'Liberação de recebimento de Garantia de Cliente com Divergência entre XML x Espelho';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.strCodDig := strLoginUsuarioLogado;
        objLiberacao.strCliente := qryESPDET.FieldByName('GER_CODCLI').AsString + '-' + fRetNomCliente(qryESPDET.FieldByName('GER_CODCLI').AsString);

        objLiberacao.objMsgLibera.pAddTexto('Liberação de recebimento de Garantia de Cliente com Divergência entre XML x Espelho');
        objLiberacao.objMsgLibera.pAddQuebra();
        objLiberacao.objMsgLibera.pAddTextoCaption('Espelho', qryESPDET.FieldByName('GER_NUMESP').AsString + '-ES' , 15);
        objLiberacao.objMsgLibera.pAddTextoCaption('NFe (XML)', qryDETELE.FieldByName('B08_NNF').AsString  + '-NF' , 15);
        objLiberacao.objMsgLibera.pAddQuebra();
        CanClose := objLiberacao.fLibera;
      finally
        FreeAndNil(objLiberacao);
      end;
    end;
  end;
end;

procedure TfrmValidacaoEspelhoXMLView.FormCreate(Sender: TObject);
begin
  inherited;

  qryESPDET := fCriaQuery;
  qryDETELE := fCriaQuery;

  objValidacao := TValidacaoEspelhoXML.Create();

  objValidacao.dtsEspelho := qryESPDET;
  qryESPDET.SQL.Text := objValidacao.fRetornaSQLEspelho;

  objValidacao.dtsXML := qryDETELE;
  qryDETELE.SQL.Text := objValidacao.fRetornaSQLXML;

  dtsValidacao.DataSet := objValidacao.cdsItens;

  shpXML.Brush.Color := TValidacaoEspelhoXML.COR_FONTE_XML;
  shpEspelho.Brush.Color := TValidacaoEspelhoXML.COR_FONTE_ESPELHO;
  shpErro.Brush.Color := TValidacaoEspelhoXML.COR_FUNDO_ERRO;
end;

procedure TfrmValidacaoEspelhoXMLView.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryESPDET);
  FreeAndNil(qryDETELE);
  FreeAndNil(objValidacao);
  inherited;
end;

procedure TfrmValidacaoEspelhoXMLView.FormShow(Sender: TObject);
begin
  inherited;

  qryESPDET.ParamByName(TValidacaoEspelhoXML.PARAMETRO_AD).AsString := strCodigoAD;
  qryESPDET.Open;

  qryDETELE.ParamByName(TValidacaoEspelhoXML.PARAMETRO_XML).AsString := strAutoincremGERELE;
  qryDETELE.Open;

  objValidacao.pCarregaItens;
  objValidacao.pAlimentaCdsItens;

end;


end.
