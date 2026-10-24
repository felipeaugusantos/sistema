unit untRequisicaoVinculadasComPedidoDeCompra;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, untZClient, untFuncoesSimples,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGridCitel, cxCheckBox,
  cxCurrencyEdit, cxContainer, cxProgressBar, untGravando, Uni;

type
  TfrmRequisicaoVinculadasComPedidoDeCompra = class(TfrmPai)
    cxlDados: TcxGridLevel;
    cxDados: TcxGrid;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dtsDados: TDataSource;
    cxgDados: TcxGridDBBandedTableViewCitel;
    cxgDadosMARCADO: TcxGridDBBandedColumn;
    cxgDadosRCD_CODIGO: TcxGridDBBandedColumn;
    cxgDadosRCD_EMPRESA: TcxGridDBBandedColumn;
    cxgDadosVENDEDOR: TcxGridDBBandedColumn;
    cxgDadosCLIENTE: TcxGridDBBandedColumn;
    cxgDadosRCD_CODITE: TcxGridDBBandedColumn;
    cxgDadosITE_DESITE: TcxGridDBBandedColumn;
    cxgDadosPEDVEN: TcxGridDBBandedColumn;
    cxgDadosQTDITE: TcxGridDBBandedColumn;
    cxgDadosPCG_NUMPED: TcxGridDBBandedColumn;
    cxgDadosPCG_CODEMP: TcxGridDBBandedColumn;
    cxgDadosPCD_DTAENT: TcxGridDBBandedColumn;
    cxgDadosPCD_QTDITE: TcxGridDBBandedColumn;
    btnConfirmar: TBitBtnLocked;
    btnMarDes: TBitBtnLocked;
    btnMarTodos: TBitBtnLocked;
    btnDesTodos: TBitBtnLocked;
    cxgDadosFORNEC: TcxGridDBBandedColumn;
    procedure FormShow(Sender: TObject);
    procedure cxgDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnMarDesClick(Sender: TObject);
    procedure btnMarTodosClick(Sender: TObject);
    procedure btnDesTodosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
  private
    qryDados: TZClient;
    frmGravando: TfrmGravando;
    procedure pCarregaDados;
    procedure pSetaSQL;
    procedure pMarcaDesmarcaTodos(AMarcado: Boolean);
    function fMarcacao(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fGravacao(pgbStatus: TcxProgressBar = Nil): Boolean;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRequisicaoVinculadasComPedidoDeCompra: TfrmRequisicaoVinculadasComPedidoDeCompra;

implementation

{$R *.dfm}

procedure TfrmRequisicaoVinculadasComPedidoDeCompra.btnConfirmarClick(Sender: TObject);
begin
  If fPergunta('Remover os vínculos entre Requisição e Pedido de compra?') Then
  Begin
    Try
      TfrmGravando.fExecuta(fGravacao, frmGravando, 'Gravando informações.');
      pMensagemOk('vínculos removidos com sucesso!');
    finally
      FreeAndNil(frmGravando);
    End;

    pCarregaDados;
  End;
end;

function TfrmRequisicaoVinculadasComPedidoDeCompra.fGravacao(pgbStatus: TcxProgressBar): Boolean;
var strInc: string;
    qryComand: TUniQuery;
    sqlPCMIRQ: String;
begin
  qryDados.First;

  strInc := '';
  Result := false;
  qryDados.First;
  pgbStatus.Properties.Max := qryDados.RecordCount -1;
  sqlPCMIRQ := '';

  while not (qryDados.EoF) do
  Begin
    If qryDados.FieldByName('MARCADO').AsString = 'S' Then
    begin
      strInc :=  IIf(strInc = '', '', ',') + strInc + '"' + qryDados.FieldByName('AUTOINCREM').AsString + '"';
      sqlPCMIRQ := sqlPCMIRQ + 'DELETE FROM PCMIRQ WHERE PCM_SEQREQ = "'+qryDados.FieldByName('AUTOINCREM').AsString +'" AND PCM_SEQDET = "'+qryDados.FieldByName('RCD_SEQPCD').AsString +'";'
    End;
    qryDados.Next;
    pgbStatus.Position := qryDados.RecNo;
    Application.ProcessMessages;
  End;

  If Not fEmptyStr(strInc) Then
  Begin
    qryComand := fCriaQuery;
    try
      qryComand.SQL.Add('UPDATE MOVRCD ');
      qryComand.SQL.Add('   SET RCD_SEQPCD = NULL ');
      qryComand.SQL.Add(' WHERE AUTOINCREM IN (' + strInc + ');');
      qryComand.SQL.Add(sqlPCMIRQ);
      qryComand.ExecSQL;
    finally
      FreeAndNil(qryComand);
    End;
    Result := True;
  End;
end;

procedure TfrmRequisicaoVinculadasComPedidoDeCompra.btnDesTodosClick(
  Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(False);

end;

procedure TfrmRequisicaoVinculadasComPedidoDeCompra.btnMarDesClick(
  Sender: TObject);
begin
  inherited;
  qryDados.Edit;
  qryDados.FieldByName('MARCADO').AsString := IIf(qryDados.FieldByName('MARCADO').AsString = 'S', 'N', 'S');
  qryDados.Post;
end;

procedure TfrmRequisicaoVinculadasComPedidoDeCompra.btnMarTodosClick(
  Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaTodos(True);
end;

procedure TfrmRequisicaoVinculadasComPedidoDeCompra.cxgDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgDadosMARCADO.Index]) = 'S' Then
    ACanvas.Brush.Color := clAqua;
end;

function TfrmRequisicaoVinculadasComPedidoDeCompra.fMarcacao(
  pgbStatus: TcxProgressBar): Boolean;
  var intRec: integer;
begin
  Result := true;
  intRec := qryDados.RecNo;
  qryDados.DisableControls;
  Try
    qryDados.First;
    pgbStatus.Properties.Max := qryDados.RecordCount -1;
    while not qryDados.Eof Do
    Begin
      qryDados.Edit;
      qryDados.FieldByName('MARCADO').AsString := frmGravando.strChave;
      qryDados.Post;
      qryDados.Next;
      pgbStatus.Position := qryDados.RecNo;
      Application.ProcessMessages;
    End;
  Finally
    qryDados.RecNo := intRec;
    qryDados.EnableControls;
  End;
end;

procedure TfrmRequisicaoVinculadasComPedidoDeCompra.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F2: btnMarDes.Click;
    VK_F3: btnMarTodos.Click;
    VK_F4: btnDesTodos.Click;
    VK_F10: btnConfirmar.Click;
  End;
end;

procedure TfrmRequisicaoVinculadasComPedidoDeCompra.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmRequisicaoVinculadasComPedidoDeCompra.pCarregaDados;
begin
  If Assigned(qryDados) Then
    FreeAndNil(qryDados);

  qryDados := TZClient.Create(nil, '');
  pSetaSQL;
  qryDados.fAbreClient(False, 'TfrmRequisicaoVinculadasComPedidoDeCompra.pCarregaDados');

  btnMarDes.Enabled := False;
  btnMarTodos.Enabled := False;
  btnDesTodos.Enabled := False;
  btnConfirmar.Enabled := False;

  If qryDados.IsEmpty Then
    pMensagemOk('Não foi encontrado requisições com pedido de compra pendente.')
  Else
  Begin
    dtsDados.DataSet := qryDados;
    btnMarDes.Enabled := True;
    btnMarTodos.Enabled := True;
    btnDesTodos.Enabled := True;
    btnConfirmar.Enabled := True;
  End;
end;

procedure TfrmRequisicaoVinculadasComPedidoDeCompra.pMarcaDesmarcaTodos(
  AMarcado: Boolean);
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := 'Alterando Seleção.';
    frmGravando.strChave := IIf(AMarcado, 'S', 'N');
    frmGravando.fExecutarAcao := fMarcacao;
    frmGravando.ShowModal;
  finally
    FreeAndNil(frmGravando);
  End;
end;

procedure TfrmRequisicaoVinculadasComPedidoDeCompra.pSetaSQL;
begin
  qryDados.qryQuery.SQL.Clear;
  qryDados.qryQuery.SQL.Add('SELECT MOVRCD.AUTOINCREM,');
  qryDados.qryQuery.SQL.Add('       CAST("N" AS CHAR(1)) AS MARCADO, ');
  qryDados.qryQuery.SQL.Add('       RCD_CODIGO,');
  qryDados.qryQuery.SQL.Add('       CONCAT(RCD_CODEMP,"-",EMP_NOMEMP) AS RCD_EMPRESA,');
  qryDados.qryQuery.SQL.Add('       CONCAT(RCG_CODVEN,"-",VEN.OPE_NOMOPE) AS VENDEDOR,');
  qryDados.qryQuery.SQL.Add('       CONCAT(RCG_CODCLI,"-",CADCLI.CLI_NOMCLI) AS CLIENTE,');
  qryDados.qryQuery.SQL.Add('       CONCAT(PCMGER.PCG_CODFOR,"-",F.FOR_NOMFOR) AS FORNEC,');
  qryDados.qryQuery.SQL.Add('       RCD_CODITE,');
  qryDados.qryQuery.SQL.Add('       ITE_DESITE,');
  qryDados.qryQuery.SQL.Add('       RCD_SEQPCD,');
  qryDados.qryQuery.SQL.Add('       CONCAT(RCD_DOCPDV, "-", RCD_EMPPDV, "-", RCD_ESPPDV) AS PEDVEN,');
  qryDados.qryQuery.SQL.Add('       ROUND(RCD_QTDITE - IFNULL((SELECT SUM(BAI_QTDREQ)');
  qryDados.qryQuery.SQL.Add('                                    FROM BAIREQ');
  qryDados.qryQuery.SQL.Add('                                   WHERE BAI_AUTREQ = MOVRCD.AUTOINCREM), 0), 4) AS QTDITE,');
  qryDados.qryQuery.SQL.Add('       PCG_NUMPED, ');
  qryDados.qryQuery.SQL.Add('       IFNULL(PCG_EMPDES, PCG_CODEMP) AS PCG_CODEMP, ');
  qryDados.qryQuery.SQL.Add('       PCD_DTAENT,');
  qryDados.qryQuery.SQL.Add('       PCD_QTDITE - IFNULL(PCD_QTDBAI, 0) AS PCD_QTDITE');
  qryDados.qryQuery.SQL.Add('  FROM MOVRCG');
  qryDados.qryQuery.SQL.Add('  JOIN MOVRCD ON RCD_CODIGO = RCG_CODIGO');
  qryDados.qryQuery.SQL.Add('             AND RCD_CODEMP = RCG_CODEMP');
  qryDados.qryQuery.SQL.Add(' INNER JOIN PCMDET ON PCMDET.AUTOINCREM = RCD_SEQPCD');
  qryDados.qryQuery.SQL.Add(' INNER JOIN PCMGER ON PCG_NUMPED = PCD_NUMPED');
  qryDados.qryQuery.SQL.Add('                  AND PCG_ESPDOC = PCD_ESPDOC');
  qryDados.qryQuery.SQL.Add('                  AND PCG_CODEMP = PCD_CODEMP');
  qryDados.qryQuery.SQL.Add('                  AND PCG_NUMCTN = PCD_NUMCTN');
  qryDados.qryQuery.SQL.Add('  LEFT JOIN PREPRQ ON PRQ_SEQRCD = MOVRCD.AUTOINCREM');
  qryDados.qryQuery.SQL.Add('  LEFT JOIN FDOABS ON ABS_SEQPRQ = PREPRQ.AUTOINCREM');
  qryDados.qryQuery.SQL.Add('  LEFT JOIN FATDOR FD1 ON FD1.AUTOINCREM = ABS_SEQFDO');
  qryDados.qryQuery.SQL.Add('  LEFT JOIN FATDOR FD2 ON FD2.FDO_NUMDOC = RCD_DOCPDV');
  qryDados.qryQuery.SQL.Add('                      AND FD2.FDO_CODEMP = RCD_EMPPDV');
  qryDados.qryQuery.SQL.Add('                      AND FD2.FDO_ESPDOC = RCD_ESPPDV');
  qryDados.qryQuery.SQL.Add('                      AND FD2.FDO_CODITE = RCD_CODITE');
  qryDados.qryQuery.SQL.Add('  LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO =  IFNULL(FD1.FDO_SEQGER,FD2.FDO_SEQGER)');
  qryDados.qryQuery.SQL.Add('  LEFT JOIN CADOPE VEN ON VEN.OPE_CODOPE = RCG_CODVEN');
  qryDados.qryQuery.SQL.Add('  LEFT JOIN CADFOR F ON PCMGER.PCG_CODFOR = F.FOR_CODFOR ');
  qryDados.qryQuery.SQL.Add('  JOIN CADCLI ON CLI_CODCLI = RCG_CODCLI');
  qryDados.qryQuery.SQL.Add('  JOIN CADITE C ON C.ITE_CODITE = RCD_CODITE');
  qryDados.qryQuery.SQL.Add('  JOIN ITEGER I ON I.ITE_CODITE = RCD_CODITE AND I.ITE_CODEMP = RCD_CODEMP');
  qryDados.qryQuery.SQL.Add('  JOIN CADEMP ON EMP_CODEMP = RCD_CODEMP');
  qryDados.qryQuery.SQL.Add('  LEFT JOIN BAIREQ ON BAI_AUTREQ = MOVRCD.AUTOINCREM ');
  qryDados.qryQuery.SQL.Add(' WHERE TRUE');
  qryDados.qryQuery.SQL.Add('   AND RCD_SEQPCD IS NOT NULL');
  qryDados.qryQuery.SQL.Add('   AND (IFNULL(BAIREQ.AUTOINCREM, "") = "") ');
  qryDados.qryQuery.SQL.Add('   AND PCD_BAIXAD = 0');
  qryDados.qryQuery.SQL.Add('   AND RCD_ATETRA <> 1');
  qryDados.qryQuery.SQL.Add('   AND RCD_REQNEG = "N"');
  qryDados.qryQuery.SQL.Add(' GROUP BY MOVRCD.AUTOINCREM, RCD_SEQPCD, RCD_SEQPCD');
end;

end.
