unit untRateioManualOutrasDespesas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, cxCurrencyEdit, MemDS,
  DBAccess, Uni, untPai, Math;

type
  TfrmRateioManualOutrasDespesas = class(TfrmPai)
    cxgItens: TcxGridDBTableViewCitel;
    cxlItens: TcxGridLevel;
    cxItens: TcxGridCitel;
    dtsitens: TDataSource;
    lblTotOutDes: TLabel;
    btnConfirma: TSpeedButton;
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    qryEntMer: TUniQuery;
    strCnvEmb,
    strDeqTem: String;
    { Private declarations }
  public
    blnDigAposEntrada: Boolean;
    fltValOut: Double;
    blnConfirma: Boolean;
    { Public declarations }
  end;

var
  frmRateioManualOutrasDespesas: TfrmRateioManualOutrasDespesas;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmRateioManualOutrasDespesas.btnConfirmaClick(Sender: TObject);
var fltSummary: Double;
begin
  fltSummary := cxgItens.DataController.Summary.FooterSummaryValues[0];
  If (RoundTo(fltSummary, -2) <> RoundTo(fltValOut, -2)) Then
    pMensagemOk('O valor rateado difere do total. ' + #$A#$D +
                ' Valor Outras Despesas['+FormatFloat('#0.00', fltValOut)+']' + #$A#$D +
                ' Valor Informado['+FormatFloat('#0.00', fltSummary)+'].')

  Else
  begin
    blnConfirma := True;
    Close;
  End;


end;

procedure TfrmRateioManualOutrasDespesas.FormCreate(Sender: TObject);
begin
  inherited;
{}
end;

procedure TfrmRateioManualOutrasDespesas.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryEntMer);
end;

procedure TfrmRateioManualOutrasDespesas.FormShow(Sender: TObject);
begin
  inherited;
  strCnvEmb := fCfgSis('CNVEMB');
  strDeqTem := fCfgSis('DEQTEM');

  qryEntMer := fCriaQuery;
  qryEntMer.SQL.Add('SELECT ');
  If blnDigAposEntrada Then
    qryEntMer.SQL.Add(' ENT_ITEEMB AS ENT_QTDITE_TMP, ')
  Else
  Begin
    If (strCnvEmb <> 'N') Then
      qryEntMer.SQL.Add(' ROUND(ENT_QTDITE * ENT_EMBALA, ' + strDeqTem + ') AS ENT_QTDITE_TMP, ')
    Else
      qryEntMer.SQL.Add(' ENT_QTDITE  AS ENT_QTDITE_TMP, ');
  End;

  qryEntMer.SQL.Add('   TMP_ENTMER.* ');
  qryEntMer.SQL.Add(' FROM TMP_ENTMER ');
  qryEntMer.Open;
  dtsitens.DataSet := qryEntMer;

  blnConfirma := False;
  lblTotOutDes.Caption := 'Outras Despesas Total:' +  FormatFloat('#0.00', fltValOut);
end;

end.
