unit untManutencaoAbreviacoesLojasLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem;

type
  TfrmManutencaoAbreviacoesLojasLog = class(TfrmPaiConfirma)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    dtsDados: TDataSource;
  private
    { Private declarations }
  public
    class function fShowModal(DataSet: TDataSet): integer;
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmManutencaoAbreviacoesLojasLog }

class function TfrmManutencaoAbreviacoesLojasLog.fShowModal(
  DataSet: TDataSet): integer;
  Var
    frmManutencaoAbreviacoesLojasLog: TfrmManutencaoAbreviacoesLojasLog;
begin
  if DataSet.IsEmpty Then
    Exit(0);
  pCriarFormularios(TfrmManutencaoAbreviacoesLojasLog, frmManutencaoAbreviacoesLojasLog);
  Try
    frmManutencaoAbreviacoesLojasLog.dtsDados.DataSet := DataSet;
    frmManutencaoAbreviacoesLojasLog.cxGrid1DBTableView1.ViewData.Expand(True);
    Result := frmManutencaoAbreviacoesLojasLog.ShowModal;
  Finally
    FreeAndNil(frmManutencaoAbreviacoesLojasLog);
  End



end;

end.
