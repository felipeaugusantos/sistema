unit untSelecionaRelAtalho;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmSelecionaRelAtalho = class(TfrmPaiEdit)
    btnGravar: TBitBtnLocked;
    cxGridCitel1Level1: TcxGridLevel;
    cxgRelats: TcxGridDBTableViewCitel;
    cxGridCitel1: TcxGridCitel;
    cxgRelatsCODREL: TcxGridDBColumn;
    cxgRelatsNOMREL: TcxGridDBColumn;
    cxgRelatsTIPIMP: TcxGridDBColumn;
    dtsCadRel: TDataSource;
    Panel1: TPanel;
    rdgFiltros: TRadioGroup;
    btnRestaurar: TBitBtnLocked;
    procedure rdgFiltrosClick(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    blnRestaurarRelatorioPadrao: Boolean;
    { Public declarations }

  end;


implementation

{$R *.dfm}

procedure TfrmSelecionaRelAtalho.btnRestaurarClick(Sender: TObject);
begin
  If Not btnRestaurar.Visible Then
    Exit;
  inherited;
  blnRestaurarRelatorioPadrao := True;
end;

procedure TfrmSelecionaRelAtalho.FormShow(Sender: TObject);
begin
  inherited;
  blnRestaurarRelatorioPadrao := False;
end;

procedure TfrmSelecionaRelAtalho.rdgFiltrosClick(Sender: TObject);
begin
  inherited;

  cxgRelats.DataController.DataSource.DataSet.Filtered := rdgFiltros.ItemIndex = 0;
end;

end.
