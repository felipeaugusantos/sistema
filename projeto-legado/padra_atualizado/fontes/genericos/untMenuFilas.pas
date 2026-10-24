unit untMenuFilas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, Printers, UniClientDataSet, Uni,
  cxImageComboBox, ImgList, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass,
  frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, System.ImageList,
  cxImageList, Datasnap.DBClient;

type
  TfrmMenuFilas = class(TfrmPai)
    gridFilas: TcxGrid;
    gridFilasDBTableView: TcxGridDBTableView;
    gridFilasIDEIMP: TcxGridDBColumn;
    gridFilasNOMFIL: TcxGridDBColumn;
    gridFilasLevel: TcxGridLevel;
    btnConfigurar: TBitBtnLocked;
    gridFilasDESPRO: TcxGridDBColumn;
    lblNomPro: TLabel;
    dtsFilas: TDataSource;
    cdsFilas: TUniClientDataSet;
    cdsFilasNOMFIL: TStringField;
    cdsFilasIDEIMP: TStringField;
    cdsFilasDESPRO: TStringField;
    cxmglstImagens: TcxImageList;
    btnImprimir: TBitBtnLocked;
    procedure lblNomProClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure gridFilasDBTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure gridFilasDBTableViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnConfigurarClick(Sender: TObject);
    procedure gridFilasDBTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure pCarregaFilas;
  public
    { Public declarations }
    qryCfgRel: TUniQuery;
    strNomForm: String;
    blnBotoes: Boolean;

    strNomeFila: String;
    blnConfirma: Boolean;
  end;

var
  frmMenuFilas: TfrmMenuFilas;

implementation

uses untCfgRel;

{$R *.dfm}

procedure TfrmMenuFilas.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  TCfgRel.pConfigurarFilaDeImpressao(nil, strNomForm);

  If Assigned(qryCfgRel) Then
  Begin
    qryCfgRel.Refresh;
    pCarregaFilas;
  End;
end;

procedure TfrmMenuFilas.btnImprimirClick(Sender: TObject);
  Var
    Key: Word;
begin
  inherited;
  Key := VK_Return;
  gridFilasDBTableViewKeyDown(Sender, Key, [ssShift]);
end;

procedure TfrmMenuFilas.btnSairClick(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  strNomeFila := '';
end;

procedure TfrmMenuFilas.FormActivate(Sender: TObject);
begin
  inherited;
  If blnConfirma Then
    Close;
end;

procedure TfrmMenuFilas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If Not blnConfirma Then
  Begin
    TCfgRel.fMensagem('', 'Nenhuma fila de impressão foi selecionada. Impressão cancelada.', ['&O k']);
    strNomeFila  := '';
    blnConfirma  :=  False;
  End;
end;

procedure TfrmMenuFilas.FormCreate(Sender: TObject);
begin
  inherited;
  blnBotoes := True;
end;

procedure TfrmMenuFilas.FormShow(Sender: TObject);
begin
  inherited;
  blnConfirma   := False;

  cdsFilas.CreateDataSet;
  pCarregaFilas;

  If cdsFilas.IsEmpty Then
  Begin
    TCfgRel.fMensagem('', 'Não há filas para serem mostradas. O sistema irá usar a padrão!', ['&O k']);
    strNomeFila  := '';
    blnConfirma  := True;
  End;

  lblNomPro.Caption := strNomForm;
  pnlBotoes.Visible := blnBotoes;
end;

procedure TfrmMenuFilas.gridFilasDBTableViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
  Var
    Key: Word;
begin
  inherited;
  Key := VK_Return;
  gridFilasDBTableViewKeyDown(Sender, Key, [ssShift]);
end;

procedure TfrmMenuFilas.gridFilasDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (Not AViewInfo.GridRecord.Focused) And
     (AViewInfo.GridRecord.Index Mod 2 = 0) Then
  Begin
    ACanvas.Brush.Color := StrToIntDef(TCfgRel.fCfgSis('CORZEB'), clMoneyGreen);
    ACanvas.Font.Color  := clBlack;
  End;
end;

procedure TfrmMenuFilas.gridFilasDBTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) And (Not cdsFilas.IsEmpty) Then
  Begin
    strNomeFila := cdsFilas.FieldByName('NOMFIL').AsString;
    blnConfirma := True;
    Close;
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    strNomeFila := '';
    blnConfirma := False;
    Close;
  End;
end;

procedure TfrmMenuFilas.lblNomProClick(Sender: TObject);
begin
  inherited;
  TCfgRel.pMensagemOk('Chave para configuração de fila: ' + lblNomPro.Caption);
end;

procedure TfrmMenuFilas.pCarregaFilas;
  Var
    intContador: Integer;
begin
  cdsFilas.EmptyDataSet;

  If Not Assigned(qryCfgRel) Or qryCfgRel.IsEmpty Then
  Begin
    gridFilasIDEIMP.Visible := False;
    gridFilasDESPRO.Visible := False;
    gridFilasNOMFIL.Visible := True;

    TCfgRel.pRetFilasImpressao(TCfgRel.arrFilas);

    For intContador := 0 To Length(TCfgRel.arrFilas) -1 Do
    Begin
      If (TCfgRel.arrFilas[intContador].blnMostrar) Then
      Begin
        cdsFilas.Append;
        cdsFilas.FieldByName('NOMFIL').AsString := TCfgRel.arrFilas[intContador].strNomeFila;
        cdsFilas.Post;
      End;
    End;
  End
  Else
  Begin
    qryCfgRel.First;
    While Not qryCfgRel.Eof Do
    Begin
      cdsFilas.Append;
      cdsFilas.FieldByName('NOMFIL').AsString := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
      cdsFilas.FieldByName('DESPRO').AsString := qryCfgRel.FieldByName('REL_DESPRO').AsString;
      cdsFilas.FieldByName('IDEIMP').AsString := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
      cdsFilas.Post;
      qryCfgRel.Next;
    End;

    gridFilasIDEIMP.Visible := True;
    gridFilasDESPRO.Visible := True;
    gridFilasNOMFIL.Visible := True;
  End;
end;

end.
