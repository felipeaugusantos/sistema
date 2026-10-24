unit untFatDefineLoteSeparacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, System.UITypes,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Datasnap.DBClient, UniClientDataSet,
  cxTextEdit, MemDS, DBAccess, Uni, cxGridCitel, EditFocus, untCadLote;

type
  TfrmFatDefineLoteSeparacao = class(TfrmPaiConfirma)
    cdsItens: TUniClientDataSet;
    cdsItensAUTINC: TStringField;
    cdsItensNUMDOC: TStringField;
    cdsItensCODITE: TStringField;
    cdsItensDESITE: TStringField;
    cdsItensQTDITE: TFloatField;
    cdsItensLOCFIS: TStringField;
    cdsItensNUMLOT: TStringField;
    dtsItens: TDataSource;
    cdsItensEMPITE: TStringField;
    cxgItensDBTableView: TcxGridDBTableViewCitel;
    cxgItensLevel: TcxGridLevel;
    cxgItens: TcxGridCitel;
    cxgItensNUMLOT: TcxGridDBColumn;
    cxgItensCODITE: TcxGridDBColumn;
    cxgItensDESITE: TcxGridDBColumn;
    cxgItensQTDITE: TcxGridDBColumn;
    cxgItensLOCFIS: TcxGridDBColumn;
    pnlLegendas: TPanel;
    shpEditavel: TShape;
    lblEditavel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure cxgItensDBTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormShow(Sender: TObject);
    procedure cxgItensNUMLOTPropertiesChange(Sender: TObject);
    procedure cxgItensNUMLOTPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    function fValidaLote(strNumLot: String): Boolean;
  public
    { Public declarations }
  end;


implementation

uses
  untConsultas, untTypesSistema, untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatDefineLoteSeparacao.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  cdsItens.Post;

  cdsItens.First;

  while not cdsItens.Eof do
  begin
    if not fValidaLote(cdsItensNUMLOT.AsString) then
    begin
      if cdsItens.State <> dsEdit Then
        cdsItens.Edit;

      cdsItens.FieldByName('NUMLOT').AsString := 'A DEFINIR';
      Exit;
    end;

    cdsItens.Next;
  end;

  ModalResult := mrOk;
end;

procedure TfrmFatDefineLoteSeparacao.cxgItensDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if AViewInfo.Item.Options.Editing then
  begin
    ACanvas.Brush.Color := shpEditavel.Brush.Color;
    ACanvas.Font.Color  := clBlack;
  end;
end;

procedure TfrmFatDefineLoteSeparacao.cxgItensNUMLOTPropertiesChange(
  Sender: TObject);
var
  qryCadLot: TUniQuery;
  arrLotes: TConsultasArray;
  Key: Char;
begin
  inherited;

  If (cxgItensDBTableView.Controller.FocusedColumn.Name <> 'cxgItensNUMLOT') Then
    Exit;

  If TcxTextEdit(Sender).Text <> '/' Then
    Exit;

  Key := '/';

  qryCadLot := fCriaQuery;

  try
    try
      If fPesqLoteFat(Self, Nil,
                      fCfgSis('DECUNI'),
                      cdsItensCODITE.AsString,
                      false, false,
                      qryCadLot, key, arrLotes, '', Nil, True, Nil,
                      True, False, False, False, False, Nil, '',
                      False, False, False, '', 0, cdsItensQTDITE.AsFloat) Then
      begin
        if cdsItens.State <> dsEdit Then
          cdsItens.Edit;

        cdsItens.FieldByName('NUMLOT').AsString := qryCadLot.FieldByName('LOT_NUMLOT').AsString;
      end
      else
      begin
        if cdsItens.State <> dsEdit Then
          cdsItens.Edit;

        cdsItens.FieldByName('NUMLOT').AsString := 'A DEFINIR';
      end;
    except
    end;
  finally
    FreeAndNil(qryCadLot);
  end;
end;

procedure TfrmFatDefineLoteSeparacao.cxgItensNUMLOTPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  If Not fValidaLote(DisplayValue) Then
    DisplayValue := 'A DEFINIR';
end;

procedure TfrmFatDefineLoteSeparacao.FormCreate(Sender: TObject);
begin
  inherited;
  cdsItens.CreateDataSet;
end;

procedure TfrmFatDefineLoteSeparacao.FormShow(Sender: TObject);
begin
  inherited;
  cdsItens.First;
  pSetFocus(cxgItens);
end;

function TfrmFatDefineLoteSeparacao.fValidaLote(strNumLot: String): Boolean;
var
  objCadLot: TCadLot;
begin
  objCadLot := TCadLot.Create(Self);

  Try
    Result := True;

    If fEmptyStr(strNumLot) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe o número do lote!', ['&Ok']);
      Exit(False);
    End
    Else If Not objCadLot.fExisteLote(cdsItensCODITE.AsString, cdsItensEMPITE.AsString, strNumLot) Then
    Begin
      fMensagem('ATENÇÃO!', 'Lote não encontrado!', ['&Ok']);
      Exit(False);
    End
    Else If (fFormataFloat(objCadLot.qryCadLot.FieldByName('LOT_SALDOS').AsFloat, fCfgSis('DECQTD', varInteger)) < fFormataFloat(cdsItensQTDITE.AsFloat, fCfgSis('DECQTD', varInteger))) Then
    Begin
      fMensagem('ATENÇÃO!', 'Lote sem saldo suficiente', ['&Ok']);
      Exit(False);
    End;
  Finally
    FreeAndNil(objCadLot);
  End;
end;

end.
