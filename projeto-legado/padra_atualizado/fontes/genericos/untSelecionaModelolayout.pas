unit untSelecionaModelolayout;

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
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, untLayoutDinamico;

type
  TfrmSelecionaModeloLayout = class(TfrmPaiConfirma)
    Panel1: TPanel;
    Panel2: TPanel;
    btnDelete: TBitBtnLocked;
    btnEdit: TBitBtnLocked;
    btnNovo: TBitBtnLocked;
    BitBtnLocked1: TBitBtnLocked;
    dtsModelos: TDataSource;
    cxModelos: TcxGridCitel;
    cxModeloDB: TcxGridDBTableViewCitel;
    cxModeloDescri: TcxGridDBColumn;
    cxModeloslvl: TcxGridLevel;
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure BitBtnLocked1Click(Sender: TObject);
  private
    { Private declarations }
  public
    LayoutDinamico: TLayoutDinamico;
    { Public declarations }
  end;

var
  frmSelecionaModeloLayout: TfrmSelecionaModeloLayout;

implementation

{$R *.dfm}

procedure TfrmSelecionaModeloLayout.BitBtnLocked1Click(Sender: TObject);
begin
  inherited;
  LayoutDinamico.pAbrirEditorDeLayout(tvVisualizacao);

end;

procedure TfrmSelecionaModeloLayout.btnDeleteClick(Sender: TObject);
begin
  inherited;
  LayoutDinamico.pRemoveModelo;
  LayoutDinamico.pSetDataSet(dtsModelos)

end;

procedure TfrmSelecionaModeloLayout.btnEditClick(Sender: TObject);
begin
  inherited;
  LayoutDinamico.pAbrirEditorDeLayout(tvEdicao);
  LayoutDinamico.pSetDataSet(dtsModelos)

end;

procedure TfrmSelecionaModeloLayout.btnNovoClick(Sender: TObject);
begin
  inherited;
  LayoutDinamico.pAbrirEditorDeLayout(tvInsercao);
  LayoutDinamico.pSetDataSet(dtsModelos)
end;

end.
