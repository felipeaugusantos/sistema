unit untTransfLinGruSelecao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass, DB,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untZClient, Vcl.Grids, DBGridCitel, DBGrids,
  Vcl.ImgList, System.StrUtils, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, System.ImageList;

type
  TopcMarca = (opcMarca, opcDesmarca, opcInverte);

  TcxViewInfoAcess = class(TcxGridTableDataCellViewInfo);
  TcxPainterAccess = class(TcxGridTableDataCellPainter);

  TfrmTransfLinGruSelecao = class(TfrmPaiConfirma)
    imgLista: TImageList;
    btnMarcar: TBitBtnLocked;
    btnDesmarcar: TBitBtnLocked;
    btnInverter: TBitBtnLocked;
    Label1: TLabel;
    cxGridDadosDBTableView: TcxGridDBTableViewCitel;
    cxGridDadosLevel: TcxGridLevel;
    cxGridDados: TcxGridCitel;
    cxGridDadosMAR_SN: TcxGridDBColumn;
    cxGridDadosCODITE: TcxGridDBColumn;
    cxGridDadosDESITE: TcxGridDBColumn;
    cxGridDadosREFERE: TcxGridDBColumn;
    cxGridDadosCODFAB: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
    procedure cxGridDadosDBTableViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridDadosDBTableViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridDadosDBTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDadosDBTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure pMarcaRegistro(opcMarcaP : TopcMarca);
  public
    cdsCadIte : TZClient;
  end;

var
  frmTransfLinGruSelecao: TfrmTransfLinGruSelecao;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmTransfLinGruSelecao.btnMarcarClick(Sender: TObject);
begin
  inherited;
  With cdsCadIte Do
  Begin
    Try
      Filtered := False;
      Filter   := UpperCase(cxGridDadosDBTableView.DataController.Filter.FilterText);
      Filtered := True;
      DisableControls;
      First;
      While not Eof Do
      Begin
        Case TBitBtnLocked(Sender).Tag Of
          0 : pMarcaRegistro( opcMarca );
          1 : pMarcaRegistro( opcDesmarca );
          2 : pMarcaRegistro( opcInverte  );
        End;

        Next;
      End;
    Finally
      Filter := '';
      Filtered := False;
      First;
      EnableControls;
    End;
  End;
end;

procedure TfrmTransfLinGruSelecao.cxGridDadosDBTableViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If ACellViewInfo.Item  = cxGridDadosMAR_SN Then
  Begin
    pMarcaRegistro(opcInverte);
    AHandled := True;
  End;
end;

procedure TfrmTransfLinGruSelecao.cxGridDadosDBTableViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pMarcaRegistro(opcInverte);
  AHandled := True;
end;

procedure TfrmTransfLinGruSelecao.cxGridDadosDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  APainter: TcxPainterAccess;
Begin
  inherited;
  APainter := TcxPainterAccess(TcxViewInfoAcess(AViewInfo).GetPainterClass.Create(ACanvas, AViewInfo));
  With APainter do
  Begin
    Try
    DrawBorders;
    With AViewInfo.ClientBounds Do
    Begin
      If AViewInfo.Item = cxGridDadosMAR_SN then
      Begin
        If AViewInfo.Value = 'S' then
          imgLista.Draw(ACanvas.Canvas, Left+1, Top+1, 1)
        Else
          imgLista.Draw(ACanvas.Canvas, Left+1, Top+1, 2);
        ADone := True;
      End;
    End
    Finally
      Free;
    End;
  End;
End;

procedure TfrmTransfLinGruSelecao.cxGridDadosDBTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_Return) or (Key = VK_Space) Then
    pMarcaRegistro(opcInverte);
end;

procedure TfrmTransfLinGruSelecao.FormShow(Sender: TObject);
begin
  inherited;
  cxGridDadosDBTableView.DataController.DataSource := cdsCadIte.dtsSource;
  cxGridDadosDBTableView.CorZebra  := fCfgSis('CORZEB');
  pSetFocus(cxGridDados);
end;

procedure TfrmTransfLinGruSelecao.pMarcaRegistro(opcMarcaP: TopcMarca);
begin
  if (not cdsCadIte.Active) Or (cdsCadIte.IsEmpty) Then
    Exit;

  cdsCadIte.Edit;
  Case opcMarcaP Of
    opcMarca    : cdsCadIte.FieldByName('MAR_SN').AsString := 'S';
    opcDesmarca : cdsCadIte.FieldByName('MAR_SN').AsString := 'N';
    opcInverte  : cdsCadIte.FieldByName('MAR_SN').AsString := IFThen(cdsCadIte.FieldByName('MAR_SN').AsString = 'S', 'N', 'S');
  End;

  cdsCadIte.Post;
end;

end.
