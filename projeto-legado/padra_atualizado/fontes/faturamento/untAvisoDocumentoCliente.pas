unit untAvisoDocumentoCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Vcl.ExtCtrls,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls,
  Vcl.Buttons, BitBtnLockedIncrem, EditFocus;

type
  TfrmAvisoDocumentoCliente = class(TfrmPai)
    grdDadosDBTableViewCitel1: TcxGridDBTableViewCitel;
    grdDadosLevel1: TcxGridLevel;
    grdDados: TcxGridCitel;
    dsDados: TDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    grdDadosDTAEMI: TcxGridDBColumn;
    grdDadosDOCUME: TcxGridDBColumn;
    grdDadosDTAENT: TcxGridDBColumn;
    grdDadosEMPFAT: TcxGridDBColumn;
    grdDadosPESTOT: TcxGridDBColumn;
    grdDadosENDENT: TcxGridDBColumn;
    grdDadosCODVEN: TcxGridDBColumn;
    Panel2: TPanel;
    Label19: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmAvisoDocumentoCliente.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk;
end;

end.
