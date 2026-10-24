unit untEditorLayout;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, untLayoutDinamico, untPai, cxTextEdit;

type
  TfrmEditorLayout = class(TfrmPai)
    Panel1: TPanel;
    Label1: TLabel;
    edtNomLayout: TEdit;
    dtsCampos: TDataSource;
    cxCampos: TcxGrid;
    cxCamposDB: TcxGridDBTableView;
    cxCamposDBColumn1: TcxGridDBColumn;
    cxCamposDBColuna: TcxGridDBColumn;
    cxCamposLvl: TcxGridLevel;
    Panel2: TPanel;
    Label2: TLabel;
    cxCamposObrigatorio: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxCamposDBCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormShow(Sender: TObject);
  private
    FblnModoVisualizacao: Boolean;
    procedure pSetModoVisualizacao(const Value: Boolean);
    { Private declarations }
  public
    blnConfirma: Boolean;
    FValidaTodosOsCamposDefaultPreenchidos: TfuncTodosOsCamposDefaultPreenchidos;
    property blnModoVisualizacao : Boolean read FblnModoVisualizacao write pSetModoVisualizacao ;
    { Public declarations }
  end;

var
  frmEditorLayout: TfrmEditorLayout;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmEditorLayout.btnConfirmaClick(Sender: TObject);
begin
  If fEmptyStr(edtNomLayout.Text) Then
  Begin
    pMensagemOk('Atenção! O nome do layout precisa ser preenchido!');
    pSetFocus(edtNomLayout);
    Exit;
  End;

  If FValidaTodosOsCamposDefaultPreenchidos then
  begin
    blnConfirma := True;
    Close;
  End;
end;


procedure TfrmEditorLayout.cxCamposDBCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxCamposObrigatorio.Index]) = 'S' Then
    ACAnvas.Font.Color := clRed;
end;

procedure TfrmEditorLayout.FormShow(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmEditorLayout.pSetModoVisualizacao(const Value: Boolean);
begin
  FblnModoVisualizacao := Value;
  cxCamposDB.OptionsData.Editing := Not Value;


end;

end.
