unit untNFEXMLAuditoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,  Uni, untFuncoesSimples,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, cxCurrencyEdit,
  dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev,
  dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns, dxPSPDFExportCore,
  dxPSPDFExport, cxDrawTextUtils, dxPSPrVwStd, dxPSPrVwAdv, dxPSPrVwRibbon,
  dxPScxPageControlProducer, dxPScxGridLnk, dxPScxGridLayoutViewLnk,
  dxPScxEditorProducers, dxPScxExtEditorProducers, dxPSCore, dxPScxCommon;

type
  TfrmNFEXMLAuditoria = class(TfrmPai)
    cxvDados: TcxGridDBTableViewCitel;
    cxlDados: TcxGridLevel;
    cxgDados: TcxGridCitel;
    dstDados: TDataSource;
    cxvDadosColumn1: TcxGridDBColumn;
    cxvDadosColumn2: TcxGridDBColumn;
    cxvDadosColumn3: TcxGridDBColumn;
    cxvDadosColumn4: TcxGridDBColumn;
    cxvDadosColumn5: TcxGridDBColumn;
    cxvDadosColumn6: TcxGridDBColumn;
    cxvDadosColumn7: TcxGridDBColumn;
    cxvDadosColumn8: TcxGridDBColumn;
    cxvDadosColumn9: TcxGridDBColumn;
    cxvDadosColumn10: TcxGridDBColumn;
    btnExportar: TBitBtnLocked;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnExportarClick(Sender: TObject);
  private
  protected
    qryDados: TUniQuery;
    procedure pCarrega(Agrupador: String);
    { Private declarations }
  public
    class procedure pExibeAuditoria(Agrupador: String);
    { Public declarations }
  end;

var
  frmNFEXMLAuditoria: TfrmNFEXMLAuditoria;

implementation

uses
  cxGridExportLink;

{$R *.dfm}

{ TfrmNFEXMLAuditoria }

procedure TfrmNFEXMLAuditoria.btnExportarClick(Sender: TObject);
begin
  inherited;
  If qryDados.IsEmpty Then
    pMensagemOk('Sem dados para exportar!')
  Else
  begin
    If SaveDialog1.Execute(0) Then
    Begin
      ExportGridToCSV(SaveDialog1.FileName, cxgDados, True, True, ';', 'CSV', Nil, TEncoding.UTF8);
      pMensagemOk('Exportação realizada com sucesso!');
    End;
  End
end;

procedure TfrmNFEXMLAuditoria.FormCreate(Sender: TObject);
begin
  inherited;
  qryDados := fCriaQuery;
end;

procedure TfrmNFEXMLAuditoria.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryDados);
  inherited;
end;

procedure TfrmNFEXMLAuditoria.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If key = VK_F10 then
    btnExportar.Click;

end;

procedure TfrmNFEXMLAuditoria.pCarrega(Agrupador: String);
begin
  qryDados.SQL.Clear;
  qryDados.SQL.Add('SELECT ADT_AGRUPA,');
  qryDados.SQL.Add('       ADT_VLRCON AS VLRNF,');
  qryDados.SQL.Add('       ADT_NUMDOC,');
  qryDados.SQL.Add('       ADT_SERIE_,');
  qryDados.SQL.Add('       CAST(CONCAT(ADT_CODFOR, " - ", IFNULL(FOR_NOMFOR, "SEM CADASTRO")) AS CHAR(255)) AS FORNEC,');
  qryDados.SQL.Add('       CAST(CONCAT(ADT_EMPDES, " - ", EMP_NOMEMP) AS CHAR(255)) EMPRESA,');
  qryDados.SQL.Add('       ADT_STATUS,');
  qryDados.SQL.Add('       ADT_MOTIVO,');
  qryDados.SQL.Add('       ADT_CHAVEA,');
  qryDados.SQL.Add('       ADT_ARQUIV');
  qryDados.SQL.Add('  FROM GERADT');
  qryDados.SQL.Add('  LEFT JOIN CADFOR ON FOR_CODFOR = ADT_CODFOR');
  qryDados.SQL.Add('  LEFT JOIN CADEMP ON EMP_CODEMP = ADT_EMPDES');
  qryDados.SQL.Add(' WHERE ADT_AGRUPA = :AGRUPA');
  qryDados.ParamByName('AGRUPA').AsString := Agrupador;
  qryDados.Open;
  dstDados.DataSet := qryDados;
end;

class procedure TfrmNFEXMLAuditoria.pExibeAuditoria(Agrupador: String);
begin
  pCriarFormularios(TfrmNFEXMLAuditoria, frmNFEXMLAuditoria);
  Try
    frmNFEXMLAuditoria.pCarrega(Agrupador);
{    If Not frmNFEXMLAuditoria.qryDados.IsEmpty Then
    Begin
      frmNFEXMLAuditoria.cxvDados.ApplyBestFit;
      frmNFEXMLAuditoria.Showmodal;
    End
    Else}
     pMensagemOk('Documentos Importados com sucesso!' + #$A#$D + 'Documentos importados: ' + IntToStr(frmNFEXMLAuditoria.qryDados.RecordCount));

  Finally
    FreeAndNil(frmNFEXMLAuditoria);
  End;

end;

end.
