unit untMargemParaFranquia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, EditFocus, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, cxGroupBox, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, untFuncoesSimples, cxCurrencyEdit, untTMargemParaFranquia;

type
  TfrmMargemParaFranquia = class(TfrmPai)
    pnlPrecos1: TPanel;
    Label1: TLabel;
    cxvDados: TcxGridDBTableView;
    cxlDados: TcxGridLevel;
    cxDados: TcxGrid;
    cxvEMPMAT: TcxGridDBColumn;
    cxvREGIME: TcxGridDBColumn;
    cxvIPIENT: TcxGridDBColumn;
    cxvICMENT: TcxGridDBColumn;
    cxvSUBSTI: TcxGridDBColumn;
    cxvICMSAI: TcxGridDBColumn;
    cxvIMPFED: TcxGridDBColumn;
    cxvSUBFED: TcxGridDBColumn;
    cxvDESADB: TcxGridDBColumn;
    cxvPRECUS: TcxGridDBColumn;
    cxvMARBR1: TcxGridDBColumn;
    cxvPREVE1: TcxGridDBColumn;
    cxvMARBR2: TcxGridDBColumn;
    cxvPREVE2: TcxGridDBColumn;
    cxvMARBR3: TcxGridDBColumn;
    cxvPREVE3: TcxGridDBColumn;
    cxvMARBR4: TcxGridDBColumn;
    cxvPREVE4: TcxGridDBColumn;
    cxvMARBR5: TcxGridDBColumn;
    cxvPREVE5: TcxGridDBColumn;
    cxvMARBR6: TcxGridDBColumn;
    cxvPREVE6: TcxGridDBColumn;
    cxvMARBR7: TcxGridDBColumn;
    cxvPREVE7: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    lblSelecionado: TLabel;
    cxvCUSREA: TcxGridDBColumn;
    cxvEMPRESA: TcxGridDBColumn;
    procedure cxvREGIMEGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cxvDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvDadosFocusedItemChanged(Sender: TcxCustomGridTableView;
      APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
    procedure cxvMARBR1PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);

  private
    procedure pSetaVisibilidadeCampo(blnVisible: Boolean; cxCampoMargem, cxCampoVenda: TcxGridDBColumn);
    { Private declarations }
  public
    blnConfirma: Boolean;
    strMarMkp: String;
    MargemParaFranquia: TMargemParaFranquia;
    { Public declarations }
  end;

var
  frmMargemParaFranquia: TfrmMargemParaFranquia;

implementation

{$R *.dfm}

procedure TfrmMargemParaFranquia.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  blnConfirma := True;
  Close;
end;

procedure TfrmMargemParaFranquia.btnConfirmaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
    btnConfirma.Click;

end;

procedure TfrmMargemParaFranquia.cxvDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (Pos('ITE_MARBR', TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName) > 0) OR
      (Pos('ITE_PREVE', TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName) > 0) Then
  Begin
    ACanvas.Brush.Color := clYellow;
    ACanvas.Font.Color := clBlack;
  End;
end;

procedure TfrmMargemParaFranquia.cxvDadosFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  MargemParaFranquia.indexFocused :=  AFocusedItem.Tag;
end;

procedure TfrmMargemParaFranquia.cxvMARBR1PropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  If (fStrToFloat(DisplayValue) >= 100) And (strMarMkp <> '2') Then
  Begin
    fMensagem('ATENÇÃO!', 'A Margem Ideal não permitida: maior ou igual a 100!', ['&Ok']);
    DisplayValue := MargemParaFranquia.dtsDados.DataSet.FieldByName('ITE_MARBR' + MargemParaFranquia.indexFocused.ToString ).AsFloat;
  End;
end;

procedure TfrmMargemParaFranquia.cxvREGIMEGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If AText = 'R' Then
    AText := 'Lucro Real'
  Else If AText = 'S' Then
    AText := 'Simples Nacional'
  Else If AText = 'P' Then
    AText := 'Lucro Presumido'
end;

procedure TfrmMargemParaFranquia.FormActivate(Sender: TObject);
var i: integer;
begin
  inherited;
  For i := 1 To Length(VS_strTabPrc) Do
  Begin
    case i of
      1: pSetaVisibilidadeCampo(VS_strTabPrc[1] = 'S', cxvMARBR1, cxvPREVE1);
      2: pSetaVisibilidadeCampo(VS_strTabPrc[2] = 'S', cxvMARBR2, cxvPREVE2);
      3: pSetaVisibilidadeCampo(VS_strTabPrc[3] = 'S', cxvMARBR3, cxvPREVE3);
      4: pSetaVisibilidadeCampo(VS_strTabPrc[4] = 'S', cxvMARBR4, cxvPREVE4);
      5: pSetaVisibilidadeCampo(VS_strTabPrc[5] = 'S', cxvMARBR5, cxvPREVE5);
      6: pSetaVisibilidadeCampo(VS_strTabPrc[6] = 'S', cxvMARBR6, cxvPREVE6);
      7: pSetaVisibilidadeCampo(VS_strTabPrc[7] = 'S', cxvMARBR7, cxvPREVE7);
    End;
  End;

  cxvDESADB.Caption := fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + '):';
end;

procedure TfrmMargemParaFranquia.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmMargemParaFranquia.pSetaVisibilidadeCampo(blnVisible: Boolean;
  cxCampoMargem, cxCampoVenda: TcxGridDBColumn);
begin
  cxCampoMargem.Visible := blnVisible;
  cxCampoVenda.Visible  := blnVisible;
end;

end.
