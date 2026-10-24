unit untPaiSQLTrace;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, untITSQLTrace;

type
  TfrmPaiSQLTrace = class(TForm)
    pnlBotoesSQLTrace: TPanel;
    btnIniciarSQLTrace: TSpeedButton;
    btnPausarSQLTrace: TSpeedButton;
    btnSalvarSQLTrace: TSpeedButton;
    lblNSQLTrace: TLabel;
    tmrSQLTrace: TTimer;
    procedure btnPausarSQLTraceClick(Sender: TObject);
    procedure btnIniciarSQLTraceClick(Sender: TObject);
    procedure btnSalvarSQLTraceClick(Sender: TObject);
    procedure tmrSQLTraceTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    objTracePai: ITSQLTrace;
    procedure pAtualizaControls;
  end;

var
  frmPaiSQLTrace: TfrmPaiSQLTrace;

implementation

{$R *.dfm}

procedure TfrmPaiSQLTrace.btnIniciarSQLTraceClick(Sender: TObject);
begin
  if (Assigned(objTracePai)) then
  begin
    objTracePai.pIniciaTrace();
    pAtualizaControls();
  end;
end;

procedure TfrmPaiSQLTrace.btnPausarSQLTraceClick(Sender: TObject);
begin
  if (Assigned(objTracePai)) then
  begin
    objTracePai.pPausaTrace();
    pAtualizaControls();
  end;
end;

procedure TfrmPaiSQLTrace.btnSalvarSQLTraceClick(Sender: TObject);
begin
  if (Assigned(objTracePai)) then
  begin
    objTracePai.pSalvaTrace();
    pAtualizaControls();
  end;
end;

procedure TfrmPaiSQLTrace.pAtualizaControls;
begin
  lblNSQLTrace.Caption       := 'Nº SQLs: ' + IntToStr(objTracePai.CountSQL);
  btnIniciarSQLTrace.Enabled := (objTracePai.Status = stPausado);
  btnPausarSQLTrace.Enabled  := (objTracePai.Status = stIniciado);
  btnSalvarSQLTrace.Enabled  := (True);
end;

procedure TfrmPaiSQLTrace.tmrSQLTraceTimer(Sender: TObject);
begin
  if (Assigned(objTracePai)) then
    pAtualizaControls();
end;

end.
