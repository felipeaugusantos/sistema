unit Contabilidade.View.ConferenciaEstoqueContabilDetalhe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Uni, Contabilidade.View.TfrmPaiContabilidade;

type
  TfrmConferenciaEstoqueContabilDetalhe = class(TfrmPaiContabilidade)
    Panel1: TPanel;
    cxGridCitel1DBTableViewSaldoInicial: TcxGridDBTableViewCitel;
    cxGridCitel1Level1: TcxGridLevel;
    cxGridCitel1: TcxGridCitel;
    dtsDados: TDataSource;
    cxGridCitel1DBTableViewSaldoInicialCODITE: TcxGridDBColumn;
    cxGridCitel1DBTableViewSaldoInicialDESCRI: TcxGridDBColumn;
    cxGridCitel1DBTableViewSaldoInicialREFERE: TcxGridDBColumn;
    cxGridCitel1DBTableViewSaldoInicialUNIDAD: TcxGridDBColumn;
    cxGridCitel1DBTableViewSaldoInicialVALTOT: TcxGridDBColumn;
    cxGridCitelAgrupadoCfop: TcxGridDBTableView;
    cxGridCitelAgrupadoCfopCLAFIS: TcxGridDBColumn;
    cxGridCitelAgrupadoCfopCODITE: TcxGridDBColumn;
    cxGridCitelAgrupadoCfopDESCRI: TcxGridDBColumn;
    cxGridCitelAgrupadoCfopQTDITE: TcxGridDBColumn;
    cxGridCitelAgrupadoCfopUNITAR: TcxGridDBColumn;
    cxGridCitelAgrupadoCfopTOTITE: TcxGridDBColumn;
    cxGridCitelAgrupadoCfopTOTFRE: TcxGridDBColumn;
    cxGridCitelAgrupadoCfopDESACE: TcxGridDBColumn;
    cxGridCitelAgrupadoCfopVALIPI: TcxGridDBColumn;
    cxGridCitelAgrupadoCfopVALRET: TcxGridDBColumn;
    cxGridCitelAgrupadoCfopVLRCON: TcxGridDBColumn;
    cxGridCitelAgrupadoCfopAGRUP2: TcxGridDBColumn;
    cxGridCitelAgrupadoCfopRecuperaveis: TcxGridDBTableView;
    cxGridCitelAgrupadoCfopRecuperaveisCLAFIS: TcxGridDBColumn;
    cxGridCitelAgrupadoCfopRecuperaveisAGRUP2: TcxGridDBColumn;
    cxGridCitelAgrupadoCfopRecuperaveisCODITE: TcxGridDBColumn;
    cxGridCitelAgrupadoCfopRecuperaveisDESCRI: TcxGridDBColumn;
    cxGridCitelAgrupadoCfopRecuperaveisQTDITE: TcxGridDBColumn;
    cxGridCitelAgrupadoCfopRecuperaveisUNITAR: TcxGridDBColumn;
    cxGridCitelAgrupadoCfopRecuperaveisTOTITE: TcxGridDBColumn;
    cxGridCitelAgrupadoCfopRecuperaveisIMPREC: TcxGridDBColumn;
    cxGridCitelAjustes: TcxGridDBTableView;
    cxGridCitelAjustesAGRUP2: TcxGridDBColumn;
    cxGridCitelAjustesCODITE: TcxGridDBColumn;
    cxGridCitelAjustesDESCRI: TcxGridDBColumn;
    cxGridCitelAjustesQTDITE: TcxGridDBColumn;
    cxGridCitelAjustesUNITAR: TcxGridDBColumn;
    cxGridCitelAjustesTOTITE: TcxGridDBColumn;
    cxGridCitelAjustesVALFRE: TcxGridDBColumn;
    cxGridCitelAjustesDESACE: TcxGridDBColumn;
    cxGridCitelAjustesVALIPI: TcxGridDBColumn;
    cxGridCitelAjustesVALRET: TcxGridDBColumn;
    cxGridCitelAjustesVLRCON: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxGridCitelAgrupadoCfopTcxGridDBDataControllerTcxDataSummaryDefaultGroupSummaryItems0GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
      var AText: string);
    procedure cxGridCitelAgrupadoCfopRecuperaveisTcxGridDBDataControllerTcxDataSummaryDefaultGroupSummaryItems0GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
      var AText: string);
    procedure cxGridCitelAjustesTcxGridDBDataControllerTcxDataSummaryDefaultGroupSummaryItems0GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
      var AText: string);
  private
    { Private declarations }
    qryDados : TUniQuery;
  public
    { Public declarations }
    strSqlDetail : String;
  end;

var
  frmConferenciaEstoqueContabilDetalhe: TfrmConferenciaEstoqueContabilDetalhe;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmConferenciaEstoqueContabilDetalhe.cxGridCitelAgrupadoCfopRecuperaveisTcxGridDBDataControllerTcxDataSummaryDefaultGroupSummaryItems0GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: string);
begin
  inherited;
  AText := 'Valor: ' + FloatToStrF(AValue, ffNumber, 15, 2);
end;

procedure TfrmConferenciaEstoqueContabilDetalhe.cxGridCitelAgrupadoCfopTcxGridDBDataControllerTcxDataSummaryDefaultGroupSummaryItems0GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: string);
begin
  inherited;
  AText := 'Valor: ' + FloatToStrF(AValue, ffNumber, 15, 2);
end;

procedure TfrmConferenciaEstoqueContabilDetalhe.cxGridCitelAjustesTcxGridDBDataControllerTcxDataSummaryDefaultGroupSummaryItems0GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: string);
begin
  inherited;
  AText := 'Valor: ' + FloatToStrF(AValue, ffNumber, 15, 2);
end;

procedure TfrmConferenciaEstoqueContabilDetalhe.FormCreate(Sender: TObject);
begin
  inherited;
  qryDados := fCriaQuery(Self);
  strSqlDetail := '';
end;

procedure TfrmConferenciaEstoqueContabilDetalhe.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryDados);
  inherited;
end;

procedure TfrmConferenciaEstoqueContabilDetalhe.FormShow(Sender: TObject);
  Var
    intCnt : Integer;
begin
  inherited;
  If (Not fEmptyStr(strSqlDetail)) Then
  Begin
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSqlDetail);
    qryDados.Open;

    For intCnt := 0 To qryDados.FieldCount-1 Do
    Begin
      If (qryDados.Fields[intCnt].DataType = ftFloat) Then
        TFloatField(qryDados.FieldByName( qryDados.Fields[intCnt].FieldName )).DisplayFormat := '##,#0.00';
    End;

    dtsDados.DataSet := qryDados;

    TcxGridDBTableViewCitel(cxGridCitel1Level1.GridView).ViewData.Expand(True);
    TcxGridDBTableViewCitel(cxGridCitel1Level1.GridView).DataController.GotoFirst;
  End;
end;

end.
