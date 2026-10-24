unit untFatManConsertoHistPausarRetornar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, untZClient;

type
  TfrmFatManConsertoHistPausarRetornar = class(TfrmPai)
    cxgrid: TcxGridCitel;
    cxgridTBV: TcxGridDBTableViewCitel;
    cxGridTBVDESCRI: TcxGridDBColumn;
    cxGridTBVDTAENT: TcxGridDBColumn;
    cxGridTBVHORENT: TcxGridDBColumn;
    cxGridTBVNOMOPE: TcxGridDBColumn;
    cxgridLevel1: TcxGridLevel;
    dsGrid: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FHist: TZClient;
  public
    { Public declarations }
    strSeqEqu: String;
  end;

implementation

{$R *.dfm}

procedure TfrmFatManConsertoHistPausarRetornar.FormCreate(Sender: TObject);
begin
  inherited;

  FHist := TZClient.Create(Self,  'SELECT EQU_DESCRI DESCRI, EQU_DTAENT DTAENT, EQU_HORENT HORENT, CONCAT(OPE_CODOPE, "-", OPE_NOMOPE) NOMOPE ' +
                                  'FROM EQUOBT ' +
                                  'INNER JOIN CADOPE ON EQU_CODOPE = OPE_CODOPE ' +
                                  'WHERE EQU_SEQGER = :SEQEQU ' +
                                  'ORDER BY EQU_DTAENT, EQU_HORENT ');

  dsGrid.DataSet := FHist;
end;

procedure TfrmFatManConsertoHistPausarRetornar.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FHist);
end;

procedure TfrmFatManConsertoHistPausarRetornar.FormShow(Sender: TObject);
begin
  inherited;
  FHist.qryQuery.ParamByName('SEQEQU').AsString := strSeqEqu;
  FHist.fAbreClient(True, 'TfrmFatManConsertoHistPausarRetornar.FormShow');
end;

end.
