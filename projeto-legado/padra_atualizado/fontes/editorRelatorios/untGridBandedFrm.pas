unit untGridBandedFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxGridBandedTableView, cxGridDBBandedTableView,
  cxDataControllerConditionalFormattingRulesManagerDialog, Vcl.ExtCtrls,
  dxGDIPlusClasses;

type
  TfraGridBandedFrm = class(TFrame)
    cxConsulta: TcxGrid;
    cxConsultaNivel: TcxGridLevel;
    cxConsultaView: TcxGridDBBandedTableView;
    tmrRefreshDados: TTimer;
    pnlTitulo: TPanel;
    imgSupEsq: TImage;
    imgSupDir: TImage;
    pnlRodape: TPanel;
    imgInfEsq: TImage;
    imgInfDir: TImage;
    pnlLegendas: TPanel;
    pnlRodapeGrid: TPanel;
    pnlBotoes: TPanel;
    FlwBotoes: TFlowPanel;
    pnlMensagemRodape: TPanel;
    procedure tmrRefreshDadosTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfraGridBandedFrm.tmrRefreshDadosTimer(Sender: TObject);
  Var
    strTitulo: String;
begin
  Try
    tmrRefreshDados.Enabled := False;

    strTitulo := pnlTitulo.Caption;

    pnlTitulo.Caption := 'Atualizando...';
    Application.ProcessMessages;

    cxConsultaView.DataController.DataSource.DataSet.Refresh;
  Except
    pnlTitulo.Caption := 'Erro de atualização...';
    Application.ProcessMessages;
    Sleep(2000);
  End;

  pnlTitulo.Caption := strTitulo;
  Application.ProcessMessages;
  tmrRefreshDados.Enabled := True;
end;

end.
