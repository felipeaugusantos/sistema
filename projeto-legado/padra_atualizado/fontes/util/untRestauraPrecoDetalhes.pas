unit untRestauraPrecoDetalhes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, cxCurrencyEdit;

type
  TFieldPar = record
    blnLocalizou: Boolean;
    FieldAntigo: TcxGridDBColumn;
    FieldNovo: TcxGridDBColumn;
  End;



  TfrmRestauraPrecoDetalhes = class(TfrmPai)
    dtsItens: TDataSource;
    cxvItens: TcxGridDBTableViewCitel;
    cxlItens: TcxGridLevel;
    cxgItens: TcxGridCitel;
    cxgITE_PRECUS_ANT: TcxGridDBColumn;
    cxgITE_PREVE1_ANT: TcxGridDBColumn;
    cxgITE_MARBR1_ANT: TcxGridDBColumn;
    cxgITE_PREVE2_ANT: TcxGridDBColumn;
    cxgITE_MARBR2_ANT: TcxGridDBColumn;
    cxgITE_PREVE3_ANT: TcxGridDBColumn;
    cxgITE_MARBR3_ANT: TcxGridDBColumn;
    cxgITE_PREVE4_ANT: TcxGridDBColumn;
    cxgITE_MARBR4_ANT: TcxGridDBColumn;
    cxgITE_PREVE5_ANT: TcxGridDBColumn;
    cxgITE_MARBR5_ANT: TcxGridDBColumn;
    cxgITE_PREVE6_ANT: TcxGridDBColumn;
    cxgITE_MARBR6_ANT: TcxGridDBColumn;
    cxgITE_PREVE7_ANT: TcxGridDBColumn;
    cxgITE_MARBR7_ANT: TcxGridDBColumn;
    cxgITE_PRECOM_ANT: TcxGridDBColumn;
    cxgITE_DESF01_ANT: TcxGridDBColumn;
    cxgITE_DESF02_ANT: TcxGridDBColumn;
    cxgITE_DESF03_ANT: TcxGridDBColumn;
    cxgITE_DESF04_ANT: TcxGridDBColumn;
    cxgITE_DESF05_ANT: TcxGridDBColumn;
    cxgITE_DESF06_ANT: TcxGridDBColumn;
    cxgITE_SUBFED_ANT: TcxGridDBColumn;
    cxgITE_IPIENT_ANT: TcxGridDBColumn;
    cxgITE_FREENT_ANT: TcxGridDBColumn;
    cxgITE_VALFRE_ANT: TcxGridDBColumn;
    cxgITE_ACRFIN_ANT: TcxGridDBColumn;
    cxgITE_SUBSTI_ANT: TcxGridDBColumn;
    cxgITE_DESADB_ANT: TcxGridDBColumn;
    cxgITE_OUTVAL_ANT: TcxGridDBColumn;
    cxgITE_ICMSAI_ANT: TcxGridDBColumn;
    cxgITE_IMPFED_ANT: TcxGridDBColumn;
    cxgITE_DESOPE_ANT: TcxGridDBColumn;
    cxgITE_ICMENT_ANT: TcxGridDBColumn;
    cxgITE_COMTB1_ANT: TcxGridDBColumn;
    cxgITE_COMTB2_ANT: TcxGridDBColumn;
    cxgITE_COMTB3_ANT: TcxGridDBColumn;
    cxgITE_COMTB4_ANT: TcxGridDBColumn;
    cxgITE_COMTB5_ANT: TcxGridDBColumn;
    cxgITE_COMTB6_ANT: TcxGridDBColumn;
    cxgITE_COMTB7_ANT: TcxGridDBColumn;
    cxgITE_PRECUS_ATU: TcxGridDBColumn;
    cxgITE_PREVE1_ATU: TcxGridDBColumn;
    cxgITE_MARBR1_ATU: TcxGridDBColumn;
    cxgITE_PREVE2_ATU: TcxGridDBColumn;
    cxgITE_MARBR2_ATU: TcxGridDBColumn;
    cxgITE_PREVE3_ATU: TcxGridDBColumn;
    cxgITE_MARBR3_ATU: TcxGridDBColumn;
    cxgITE_PREVE4_ATU: TcxGridDBColumn;
    cxgITE_MARBR4_ATU: TcxGridDBColumn;
    cxgITE_PREVE5_ATU: TcxGridDBColumn;
    cxgITE_MARBR5_ATU: TcxGridDBColumn;
    cxgITE_PREVE6_ATU: TcxGridDBColumn;
    cxgITE_MARBR6_ATU: TcxGridDBColumn;
    cxgITE_PREVE7_ATU: TcxGridDBColumn;
    cxgITE_MARBR7_ATU: TcxGridDBColumn;
    cxgITE_PRECOM_ATU: TcxGridDBColumn;
    cxgITE_DESF01_ATU: TcxGridDBColumn;
    cxgITE_DESF02_ATU: TcxGridDBColumn;
    cxgITE_DESF03_ATU: TcxGridDBColumn;
    cxgITE_DESF04_ATU: TcxGridDBColumn;
    cxgITE_DESF05_ATU: TcxGridDBColumn;
    cxgITE_DESF06_ATU: TcxGridDBColumn;
    cxgITE_SUBFED_ATU: TcxGridDBColumn;
    cxgITE_IPIENT_ATU: TcxGridDBColumn;
    cxgITE_FREENT_ATU: TcxGridDBColumn;
    cxgITE_VALFRE_ATU: TcxGridDBColumn;
    cxgITE_ACRFIN_ATU: TcxGridDBColumn;
    cxgITE_SUBSTI_ATU: TcxGridDBColumn;
    cxgITE_DESADB_ATU: TcxGridDBColumn;
    cxgITE_OUTVAL_ATU: TcxGridDBColumn;
    cxgITE_ICMSAI_ATU: TcxGridDBColumn;
    cxgITE_IMPFED_ATU: TcxGridDBColumn;
    cxgITE_DESOPE_ATU: TcxGridDBColumn;
    cxgITE_ICMENT_ATU: TcxGridDBColumn;
    cxgITE_COMTB1_ATU: TcxGridDBColumn;
    cxgITE_COMTB2_ATU: TcxGridDBColumn;
    cxgITE_COMTB3_ATU: TcxGridDBColumn;
    cxgITE_COMTB4_ATU: TcxGridDBColumn;
    cxgITE_COMTB5_ATU: TcxGridDBColumn;
    cxgITE_COMTB6_ATU: TcxGridDBColumn;
    cxgITE_COMTB7_ATU: TcxGridDBColumn;
    cxvItensColumn1: TcxGridDBColumn;
    cxvItensColumn2: TcxGridDBColumn;
    cxgITE_TCIFCU_ANT: TcxGridDBColumn;
    cxgITE_TCIFCU_ATU: TcxGridDBColumn;
    cxgITE_TSCUST_ANT: TcxGridDBColumn;
    cxgITE_TSCUST_ATU: TcxGridDBColumn;
    cxgITE_DEPICO_ANT: TcxGridDBColumn;
    cxgITE_DEPICO_ATU: TcxGridDBColumn;
    cxgITE_DEICMS_ANT: TcxGridDBColumn;
    cxgITE_DEICMS_ATU: TcxGridDBColumn;
    cxgITE_FATREG_ANT: TcxGridDBColumn;
    cxgITE_FATREG_ATU: TcxGridDBColumn;
    cxgITE_DESITE: TcxGridDBColumn;
    procedure cxvItensCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormShow(Sender: TObject);
    function fVerificaTexto_ANT_ATU(strField: String): Boolean;
    function fVerificaCamposEncotrado(CampoANT: TcxGridDBColumn; CampoATU: TcxGridDBColumn): Boolean;


  private
    procedure AlteraCorFont(ACanvas: TcxCanvas; blnPinta: Boolean);
    function fLocateFieldPar(FieldName: String): TFieldPar;
    function fFindField(FieldName: String): TcxGridDBColumn;

    { Private declarations }
  public

    { Public declarations }
  end;

var
  frmRestauraPrecoDetalhes: TfrmRestauraPrecoDetalhes;

implementation

uses
  untFuncoesSimples;


{$R *.dfm}

procedure TfrmRestauraPrecoDetalhes.AlteraCorFont(ACanvas: TcxCanvas; blnPinta: Boolean);
begin
  If blnPinta Then
    ACanvas.Font.Color := clRed
  Else
    ACanvas.Font.Color := clBlack;
end;

procedure TfrmRestauraPrecoDetalhes.cxvItensCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  var FieldPar: TFieldPar;
begin
  inherited;

  FieldPar := fLocateFieldPar(AViewInfo.Item.Name);
  If FieldPar.blnLocalizou Then
    AlteraCorFont(ACanvas, Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, FieldPar.FieldNovo.Index] <>
                   Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, FieldPar.FieldAntigo.Index]);
end;

function TfrmRestauraPrecoDetalhes.fFindField(
  FieldName: String): TcxGridDBColumn;
  var i: integer;
begin
  Result := nil;

  For i := 0 To cxvItens.ColumnCount -1 do
  Begin
    If cxvItens.Columns[i].Name = FieldName Then
    begin
      Result := cxvItens.Columns[i];
      Break;
    End;
  End;
end;

function TfrmRestauraPrecoDetalhes.fLocateFieldPar(FieldName: String): TFieldPar;
begin
  Result.blnLocalizou := False;
  If fVerificaTexto_ANT_ATU(FieldName) Then
  Begin
    Result.FieldAntigo := fFindField(StringReplace(FieldName, '_ANT', '_ATU', []));
    Result.FieldNovo   := fFindField(StringReplace(FieldName, '_ATU', '_ANT', []));
    IF fVerificaCamposEncotrado(Result.FieldAntigo, Result.FieldNovo) Then
      Result.blnLocalizou := True;
  End;
end;


function TfrmRestauraPrecoDetalhes.fVerificaCamposEncotrado(CampoANT,
  CampoATU: TcxGridDBColumn): Boolean;
begin
  Result := true;
  If Not (Assigned(CampoANT)) Then
    Exit(False);
  If Not (Assigned(CampoATU)) Then
    Exit(False);
end;

function TfrmRestauraPrecoDetalhes.fVerificaTexto_ANT_ATU(strField: String): Boolean;
begin
  Result := false;
  If (Pos('_ANT',  strField) > 0) Then
    Exit(True);
  If (Pos('_ATU',  strField) > 0) Then
    Exit(True);
end;

procedure TfrmRestauraPrecoDetalhes.FormShow(Sender: TObject);
var strTabPrc: string;
    i: integer;
    blnSuframa: boolean;
begin
  inherited;
  blnSuframa := (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4');
  cxgITE_TCIFCU_ANT.Visible := blnSuframa;
  cxgITE_TCIFCU_ATU.Visible := blnSuframa;
  cxgITE_TSCUST_ANT.Visible := blnSuframa;
  cxgITE_TSCUST_ATU.Visible := blnSuframa;
  cxgITE_DEPICO_ANT.Visible := blnSuframa;
  cxgITE_DEPICO_ATU.Visible := blnSuframa;
  cxgITE_DEICMS_ANT.Visible := blnSuframa;
  cxgITE_DEICMS_ATU.Visible := blnSuframa;
  cxgITE_FATREG_ANT.Visible := blnSuframa;
  cxgITE_FATREG_ATU.Visible := blnSuframa;


  strTabPrc := fCfgSis('TABPRC');

  If Length(strTabPrc) < 7 Then
    For i := Length(strTabPrc) To 6 do
      strTabPrc := strTabPrc + 'N';

  cxgITE_PREVE1_ANT.Visible := strTabPrc[1] = 'S';
  cxgITE_MARBR1_ANT.Visible := strTabPrc[1] = 'S';
  cxgITE_COMTB1_ANT.Visible := strTabPrc[1] = 'S';
  cxgITE_PREVE1_ATU.Visible := strTabPrc[1] = 'S';
  cxgITE_MARBR1_ATU.Visible := strTabPrc[1] = 'S';
  cxgITE_COMTB1_ATU.Visible := strTabPrc[1] = 'S';

  cxgITE_PREVE2_ANT.Visible := strTabPrc[2] = 'S';
  cxgITE_MARBR2_ANT.Visible := strTabPrc[2] = 'S';
  cxgITE_COMTB2_ANT.Visible := strTabPrc[2] = 'S';
  cxgITE_PREVE2_ATU.Visible := strTabPrc[2] = 'S';
  cxgITE_MARBR2_ATU.Visible := strTabPrc[2] = 'S';
  cxgITE_COMTB2_ATU.Visible := strTabPrc[2] = 'S';

  cxgITE_PREVE3_ANT.Visible := strTabPrc[3] = 'S';
  cxgITE_MARBR3_ANT.Visible := strTabPrc[3] = 'S';
  cxgITE_COMTB3_ANT.Visible := strTabPrc[3] = 'S';
  cxgITE_PREVE3_ATU.Visible := strTabPrc[3] = 'S';
  cxgITE_MARBR3_ATU.Visible := strTabPrc[3] = 'S';
  cxgITE_COMTB3_ATU.Visible := strTabPrc[3] = 'S';

  cxgITE_PREVE4_ANT.Visible := strTabPrc[4] = 'S';
  cxgITE_MARBR4_ANT.Visible := strTabPrc[4] = 'S';
  cxgITE_COMTB4_ANT.Visible := strTabPrc[4] = 'S';
  cxgITE_PREVE4_ATU.Visible := strTabPrc[4] = 'S';
  cxgITE_MARBR4_ATU.Visible := strTabPrc[4] = 'S';
  cxgITE_COMTB4_ATU.Visible := strTabPrc[4] = 'S';

  cxgITE_PREVE5_ANT.Visible := strTabPrc[5] = 'S';
  cxgITE_MARBR5_ANT.Visible := strTabPrc[5] = 'S';
  cxgITE_COMTB5_ANT.Visible := strTabPrc[5] = 'S';
  cxgITE_PREVE5_ATU.Visible := strTabPrc[5] = 'S';
  cxgITE_MARBR5_ATU.Visible := strTabPrc[5] = 'S';
  cxgITE_COMTB5_ATU.Visible := strTabPrc[5] = 'S';

  cxgITE_PREVE6_ANT .Visible := strTabPrc[6] = 'S';
  cxgITE_MARBR6_ANT .Visible := strTabPrc[6] = 'S';
  cxgITE_COMTB6_ANT .Visible := strTabPrc[6] = 'S';
  cxgITE_PREVE6_ATU .Visible := strTabPrc[6] = 'S';
  cxgITE_MARBR6_ATU .Visible := strTabPrc[6] = 'S';
  cxgITE_COMTB6_ATU .Visible := strTabPrc[6] = 'S';

  cxgITE_PREVE7_ANT.Visible := strTabPrc[7] = 'S';
  cxgITE_MARBR7_ANT.Visible := strTabPrc[7] = 'S';
  cxgITE_COMTB7_ANT.Visible := strTabPrc[7] = 'S';
  cxgITE_PREVE7_ATU.Visible := strTabPrc[7] = 'S';
  cxgITE_MARBR7_ATU.Visible := strTabPrc[7] = 'S';
  cxgITE_COMTB7_ATU.Visible := strTabPrc[7] = 'S';
end;

end.




