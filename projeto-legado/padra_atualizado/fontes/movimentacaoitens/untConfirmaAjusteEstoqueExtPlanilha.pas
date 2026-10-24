unit untConfirmaAjusteEstoqueExtPlanilha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxTextEdit, cxImageComboBox, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  UniClientDataSet;

type
  TfrmConfirmaAjusteEstoqueExtPlanilha = class(TfrmPaiConfirma)
    pnlInfoPlan: TPanel;
    Label1: TLabel;
    cxgGrid: TcxGrid;
    cxgGridTBV: TcxGridDBTableView;
    cxgGridTBVCODITE: TcxGridDBColumn;
    cxgGridTBVDESITE: TcxGridDBColumn;
    cxgGridTBVQTDPLA: TcxGridDBColumn;
    cxgGridTBVQTDMOV: TcxGridDBColumn;
    cxgGridTBVQTDAJU: TcxGridDBColumn;
    cxgGridTBVOPERAC: TcxGridDBColumn;
    cxgGridTBVSALATU: TcxGridDBColumn;
    cxgGridTBVSALAPO: TcxGridDBColumn;
    cxgGridLevel: TcxGridLevel;
    dtsGrid: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    function fSomaColunas: Integer;
  public
    { Public declarations }
    cldsItens: TUniClientDataSet;
  end;

var
  frmConfirmaAjusteEstoqueExtPlanilha: TfrmConfirmaAjusteEstoqueExtPlanilha;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmConfirmaAjusteEstoqueExtPlanilha.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (ModalResult <> mrOk) then
  begin
    if fMensagem('ATenção', 'Deseja realmente cancelar a operação e gravação do ajuste?', ['&Sim', '&Não']) = 2 Then
    begin
      Action := CaNone;
      Exit;
    end;
  end;

  inherited;
end;

procedure TfrmConfirmaAjusteEstoqueExtPlanilha.FormResize(Sender: TObject);
var
  LLargura: Integer;
begin
  inherited;
  LLargura := (cxgGrid.Width - fSomaColunas) - 28;
  cxgGridTBV.Columns[cxgGridTBVDESITE.Index].Width := IIF((LLargura < 350), 350, LLargura);
end;

procedure TfrmConfirmaAjusteEstoqueExtPlanilha.FormShow(Sender: TObject);
begin
  inherited;
  dtsGrid.DataSet := cldsItens;
end;

function TfrmConfirmaAjusteEstoqueExtPlanilha.fSomaColunas: Integer;
var
  LCont: Integer;
begin
  Result := 0;

  for LCont := 0 to Pred(cxgGridTBV.ColumnCount) do
  begin
    if (cxgGridTBV.Columns[LCont] <> cxgGridTBVDESITE) then
      Result := Result + cxgGridTBV.Columns[LCont].Width;
  end;
end;

end.
