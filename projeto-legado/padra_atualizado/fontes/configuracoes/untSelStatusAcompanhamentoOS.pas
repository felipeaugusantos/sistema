unit untSelStatusAcompanhamentoOS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxCustomData, cxStyles, cxTL, cxTextEdit,
  cxTLdxBarBuiltInMenu, cxDataControllerConditionalFormattingRulesManagerDialog,
  cxButtons, cxInplaceContainer, Vcl.ComCtrls, cxContainer, cxEdit, cxTreeView;

type
  TfrmSelStatusAcompanhamentoOS = class(TfrmPaiConfirma)
    pnlFilSta: TPanel;
    pnlButSta: TPanel;
    btnRetrair: TcxButton;
    btnExpandir: TcxButton;
    tvStatus: TcxTreeView;
    procedure btnExpandirClick(Sender: TObject);
    procedure btnRetrairClick(Sender: TObject);
    procedure tvStatusDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strSituacao: String;
  end;

implementation

{$R *.dfm}

procedure TfrmSelStatusAcompanhamentoOS.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  strSituacao := tvStatus.Selected.Text;
end;

procedure TfrmSelStatusAcompanhamentoOS.btnExpandirClick(Sender: TObject);
begin
  tvStatus.FullExpand;
end;

procedure TfrmSelStatusAcompanhamentoOS.btnRetrairClick(Sender: TObject);
begin
  inherited;
  tvStatus.FullCollapse;
end;

procedure TfrmSelStatusAcompanhamentoOS.FormCreate(Sender: TObject);
begin
  inherited;
  strSituacao := '';
end;

procedure TfrmSelStatusAcompanhamentoOS.tvStatusDblClick(Sender: TObject);
begin
  inherited;
  btnConfirma.Click;
end;

end.
