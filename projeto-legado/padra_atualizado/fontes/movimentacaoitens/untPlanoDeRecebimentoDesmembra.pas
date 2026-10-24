unit untPlanoDeRecebimentoDesmembra;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, System.UITypes,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, untZClient,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmPlanoDeRecebimentoDesmembra = class(TfrmPaiConfirma)
    cxgDocumentosLevel: TcxGridLevel;
    cxgDocumentosTableView: TcxGridDBTableViewCitel;
    cxgDocumentos: TcxGridCitel;
    cxgDocumentosTableViewNUMDOC: TcxGridDBColumn;
    cxgDocumentosTableViewESPDOC: TcxGridDBColumn;
    cxgDocumentosTableViewSERIE_: TcxGridDBColumn;
    cxgDocumentosTableViewCODFOR: TcxGridDBColumn;
    cxgDocumentosTableViewNOMFOR: TcxGridDBColumn;
    cxgDocumentosTableViewMARCA: TcxGridDBColumn;
    Label1: TLabel;
    shpLegenda: TShape;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgDocumentosTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgDocumentosTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    intQtdMar: Integer;
    cdsDados : TZClient;
    function fGetSQL: String;
    procedure pMarcaDesmarca;
  public
    strAutInc : String;
  published
    property getDados : TZClient Read cdsDados;
  end;

var
  frmPlanoDeRecebimentoDesmembra: TfrmPlanoDeRecebimentoDesmembra;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmPlanoDeRecebimentoDesmembra.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDados := TZClient.Create(Self, fGetSQL);
  cxgDocumentosTableView.DataController.DataSource := cdsDados.dtsSource;
  intQtdMar := 0;

end;

procedure TfrmPlanoDeRecebimentoDesmembra.FormShow(Sender: TObject);
begin
  inherited;
  cdsDados.qryQuery.ParamByName('AUTINC').AsString := strAutInc;
  cdsDados.fAbreClient(True, 'TfrmPlanoDeRecebimentoDesmembra.FormShow');
  pSetFocus(cxgDocumentos);
end;

procedure TfrmPlanoDeRecebimentoDesmembra.pMarcaDesmarca;
begin
  cdsDados.Edit;

  If cdsDados.FieldByName('MARCA').AsString = 'S' Then
  Begin
    cdsDados.FieldByName('MARCA').AsString := 'N';
    Dec(intQtdMar);
  End
  Else
  Begin
    If (intQtdMar + 1) = cdsDados.RecordCount Then
    Begin
      fMensagem('', 'Não é permitido desmembrar todos os documentos!', ['&OK']);
    End
    Else
    Begin
      cdsDados.FieldByName('MARCA').AsString := 'S';
      Inc(intQtdMar);
    End;
  End;

  cdsDados.Post;
  btnConfirma.Enabled := (intQtdMar > 0);
end;

procedure TfrmPlanoDeRecebimentoDesmembra.cxgDocumentosTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgDocumentosTableViewMARCA.Index]) = 'S' Then
  Begin
    ACanvas.Brush.Color := shpLegenda.Brush.Color;
    ACanvas.Font.Color  := clBlack;
//    TcxCustomGridTableView(Sender).sel
  End;

end;

procedure TfrmPlanoDeRecebimentoDesmembra.cxgDocumentosTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = 13 Then
    pMarcaDesmarca;
end;

function TfrmPlanoDeRecebimentoDesmembra.fGetSQL : String;
Begin
  Result := '';
  Result := Result + ' SELECT ADC_NUMDOC,         ';
  Result := Result + '        ADC_ESPDOC,         ';
  Result := Result + '        ADC_SERIE_,         ';
  Result := Result + '        ADC_CODFOR,         ';
  Result := Result + '        ADC_CODEMP,         ';
  Result := Result + '        FOR_NOMFOR,         ';
  Result := Result + '        "N" AS MARCA,       ';
  Result := Result + ' AGEDOC.AUTOINCREM          ';
  Result := Result + ' FROM AGEDOC                ';
  Result := Result + ' INNER JOIN CADFOR ON       ';
  Result := Result + '   FOR_CODFOR = ADC_CODFOR  ';
  Result := Result + ' WHERE ADC_SEQGER = :AUTINC ';
End;

end.
