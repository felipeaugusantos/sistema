unit untConsultaOcorrenciasCRMEmergenciais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  DB, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid,
  Uni, UniDataSetProvider, UniClientDataSet,
  BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, MemDS, DBAccess, Provider,
  Datasnap.DBClient, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmConsultaOcorrenciasCRMEmergenciais = class(TfrmPaiSimples)
    pnlGeral: TPanel;
    dbgOcorrencias: TcxGrid;
    dbgOcorrenciasDBTableView1: TcxGridDBTableView;
    dbgOcorrenciasDBTableView1CLI_NOMCLI: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1OCO_PROTOC: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1GOC_CODGOC: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1GOC_DESGOC: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1OCO_CODTOC: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1TOC_DESTOC: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1OCO_DTAINC: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1OCO_HORINC: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1OCO_DTACON: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1OCO_HORCON: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1OPE_NOMOPE: TcxGridDBColumn;
    dbgOcorrenciasDBTableView1OCO_CODEMP: TcxGridDBColumn;
    dbgOcorrenciasLevel1: TcxGridLevel;
    pnlBotoesInferiores: TPanel;
    cdsOcorrencias: TUniClientDataSet;
    cdsOcorrenciasOCO_CODOCO: TStringField;
    cdsOcorrenciasOCO_CODTOC: TStringField;
    cdsOcorrenciasTOC_DESTOC: TStringField;
    cdsOcorrenciasOCO_CODCLI: TStringField;
    cdsOcorrenciasGOC_CODGOC: TStringField;
    cdsOcorrenciasGOC_DESGOC: TStringField;
    cdsOcorrenciasCLI_NOMCLI: TStringField;
    cdsOcorrenciasOCO_DTAINC: TDateField;
    cdsOcorrenciasOCO_HORINC: TTimeField;
    cdsOcorrenciasOCO_DTACON: TDateField;
    cdsOcorrenciasOCO_HORCON: TTimeField;
    cdsOcorrenciasOPE_NOMOPE: TStringField;
    cdsOcorrenciasOCO_CODEMP: TStringField;
    cdsOcorrenciasOCO_OPEOCO: TStringField;
    cdsOcorrenciasOCO_PROTOC: TStringField;
    dtsOcorrencias: TDataSource;
    dspOcorrencias: TUniDataSetProvider;
    qryOcorrencias: TUniQuery;
    btnSairBaixa: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    procedure btnSairBaixaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgOcorrenciasDBTableView1DblClick(Sender: TObject);
    procedure cdsOcorrenciasAfterScroll(DataSet: TDataSet);
    procedure dbgOcorrenciasDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FCodCli: String;
    FCodEmp: String;
    FCodOpe: String;
    FTip_Fc: String;

    procedure pConfirma;

  protected
    function getCodCli: String;
    function getCodEmp: String;
    function getCodOpe: String;
    function getTip_Fc: String;

    procedure setCodCli(const Value: String);
    procedure setCodEmp(const Value: String);
    procedure setCodOpe(const Value: String);
    procedure setTip_Fc(const Value: String);

  public
    { Public declarations }

    strCodOco: String;
    strCodGoc: String;

    procedure pConsultaEmergenciais;

    property strCodCli: String Read getCodCli Write setCodCli;
    property strCodEmp: String Read getCodEmp Write setCodEmp;
    property strCodOpe: String Read getCodOpe Write setCodOpe;
    property strTip_Fc: String Read getTip_Fc Write setTip_Fc;
  end;

var
  frmConsultaOcorrenciasCRMEmergenciais: TfrmConsultaOcorrenciasCRMEmergenciais;

implementation

uses   untFuncoesCRM, untFuncoesSimples;

{$R *.dfm}

procedure TfrmConsultaOcorrenciasCRMEmergenciais.btnConfirmaClick(
  Sender: TObject);
begin
  inherited;
  pConfirma;
  Close;
end;

procedure TfrmConsultaOcorrenciasCRMEmergenciais.btnSairBaixaClick(
  Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmConsultaOcorrenciasCRMEmergenciais.cdsOcorrenciasAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  btnConfirma.Enabled := Not DataSet.IsEmpty;
end;

procedure TfrmConsultaOcorrenciasCRMEmergenciais.dbgOcorrenciasDBTableView1DblClick(
  Sender: TObject);
begin
  inherited;
  btnConfirma.Click;
end;

procedure TfrmConsultaOcorrenciasCRMEmergenciais.dbgOcorrenciasDBTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: btnConfirma.Click;
  End;
end;

procedure TfrmConsultaOcorrenciasCRMEmergenciais.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  qryOcorrencias.Close;
  cdsOcorrencias.Close;
end;

procedure TfrmConsultaOcorrenciasCRMEmergenciais.FormCreate(Sender: TObject);
begin
  inherited;
  strCodOco := '';
  strCodGoc := '';
  strTip_Fc := 'C';
end;

procedure TfrmConsultaOcorrenciasCRMEmergenciais.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE: btnSairBaixa.Click;
    VK_F10: btnConfirma.Click;
  End;
end;

procedure TfrmConsultaOcorrenciasCRMEmergenciais.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgOcorrencias);
  If FTip_Fc = 'F' Then
    dbgOcorrenciasDBTableView1CLI_NOMCLI.Caption := 'Fornecedor';
end;

function TfrmConsultaOcorrenciasCRMEmergenciais.getCodCli: String;
begin
  Result := FCodCli;
end;

function TfrmConsultaOcorrenciasCRMEmergenciais.getCodEmp: String;
begin
  Result := FCodEmp;
end;

function TfrmConsultaOcorrenciasCRMEmergenciais.getCodOpe: String;
begin
  Result := FCodOpe;
end;

function TfrmConsultaOcorrenciasCRMEmergenciais.getTip_Fc: String;
begin
  Result := FTip_Fc;
end;

procedure TfrmConsultaOcorrenciasCRMEmergenciais.pConfirma;
begin
  if not cdsOcorrencias.IsEmpty then
  begin
    strCodOco := cdsOcorrenciasOCO_CODOCO.AsString;
    strCodGoc := cdsOcorrenciasGOC_CODGOC.AsString;
  end;
end;

procedure TfrmConsultaOcorrenciasCRMEmergenciais.pConsultaEmergenciais;
begin
  cdsOcorrencias.CreateDataSet;
  with qryOcorrencias do
  begin
    cdsOcorrencias.Close;
    Close;
    SQL.Clear;
    SQL.Add(fRetornaSQLOcorrenciasEmergenciais(FTip_Fc));
    Params.ParamByName('CODCLI').AsString := strCodCli;
    Params.ParamByName('CODOPE').AsString := strCodOpe;
    Open;
    cdsOcorrencias.Open;
  end;
end;

procedure TfrmConsultaOcorrenciasCRMEmergenciais.setCodCli(const Value: String);
begin
  If (FCodCli <> Value) Then
    FCodCli := Value;
end;

procedure TfrmConsultaOcorrenciasCRMEmergenciais.setCodEmp(const Value: String);
begin
  If (FCodEmp <> Value) Then
    FCodEmp := Value;
end;

procedure TfrmConsultaOcorrenciasCRMEmergenciais.setCodOpe(const Value: String);
begin
  If (FCodOpe <> Value) Then
    FCodOpe := Value;
end;

procedure TfrmConsultaOcorrenciasCRMEmergenciais.setTip_Fc(const Value: String);
begin
  If (FTip_Fc <> Value) Then
    FTip_Fc := Value;
end;

end.
