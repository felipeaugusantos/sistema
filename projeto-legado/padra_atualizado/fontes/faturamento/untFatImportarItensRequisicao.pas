unit untFatImportarItensRequisicao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ComCtrls,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxProgressBar,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, UniClientDataSet, Uni, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, Datasnap.DBClient, frxClass,
  frxExportCSVTestabilidade, untTypesSistema,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmFatImportarItensRequisicao = class(TfrmPai)
    cxgReq: TcxGrid;
    cxgReqView: TcxGridDBTableView;
    cxgCliCnd: TcxGridLevel;
    btnConfirmar: TBitBtnLocked;
    btnMarDes: TBitBtnLocked;
    btnMarDesTodos: TBitBtnLocked;
    cdsReq: TUniClientDataSet;
    dtsReq: TDataSource;
    cxgReqViewAUTOINCREM: TcxGridDBColumn;
    cxgReqViewCODREQ: TcxGridDBColumn;
    cxgReqViewCODFOR: TcxGridDBColumn;
    cxgReqViewDTACAD: TcxGridDBColumn;
    cxgReqViewNOMOPE: TcxGridDBColumn;
    cxgReqViewNOMCLI: TcxGridDBColumn;
    cxgReqViewDESITE: TcxGridDBColumn;
    cxgReqViewREFERE: TcxGridDBColumn;
    cxgReqViewSIGUNI: TcxGridDBColumn;
    cxgReqViewCODFAB: TcxGridDBColumn;
    cxgReqViewQTDITE: TcxGridDBColumn;
    cxgReqViewMARDES: TcxGridDBColumn;
    cdsReqAUTOINCREM: TStringField;
    cdsReqCODREQ: TStringField;
    cdsReqDTACAD: TDateField;
    cdsReqNOMOPE: TStringField;
    cdsReqNOMCLI: TStringField;
    cdsReqPRODUT: TStringField;
    cdsReqREFERE: TStringField;
    cdsReqSIGUNI: TStringField;
    cdsReqCODFAB: TStringField;
    cdsReqQTDITE: TFloatField;
    cdsReqMARDES: TIntegerField;
    cdsReqCODITE: TStringField;
    cdsReqDESITE: TStringField;
    cxgReqViewPRODUT: TcxGridDBColumn;
    cxgReqViewCODITE: TcxGridDBColumn;
    procedure btnMarDesClick(Sender: TObject);
    procedure btnMarDesTodosClick(Sender: TObject);
    procedure cxgReqViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgReqViewCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxgReqViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSairClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure pMarcaDesmarca;
    function fCarregaItensRequisicaoInterna(pgbStatus: TcxProgressBar): Boolean;
  public
    fIncluirItem: TfIncluiItem;

    procedure pCarregaRequisicoes(strCodCli, strSeqRcd: String);
    function fCarregaItensRequisicao: Boolean;
  end;

var
  frmFatImportarItensRequisicao: TfrmFatImportarItensRequisicao;

implementation

uses untFuncoesSimples, untGravando;

{$R *.dfm}

procedure TfrmFatImportarItensRequisicao.btnConfirmarClick(Sender: TObject);
begin
  // ModalResult
end;

procedure TfrmFatImportarItensRequisicao.btnMarDesClick(Sender: TObject);
begin
  pMarcaDesmarca;
end;

procedure TfrmFatImportarItensRequisicao.btnMarDesTodosClick(Sender: TObject);
  Var
    intMarDes: Integer;
begin
  If cdsReq.IsEmpty Then Exit;

  intMarDes := Sqr(cdsReqMARDES.AsInteger-1);

  cdsReq.First;
  While Not cdsReq.Eof Do
  Begin
    cdsReq.Edit;
    cdsReqMARDES.AsInteger := intMarDes;
    cdsReq.Post;
    
    cdsReq.Next;
  End
end;

procedure TfrmFatImportarItensRequisicao.btnSairClick(Sender: TObject);
begin
  //ModalResult
end;

procedure TfrmFatImportarItensRequisicao.cxgReqViewCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  pMarcaDesmarca;
end;

procedure TfrmFatImportarItensRequisicao.cxgReqViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  If Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgReqViewMARDES.Index] = 1 Then
  Begin
    ACanvas.Brush.Color := clBlue;
    ACanvas.Font.Color := clWhite;
  End
  Else
  Begin
    ACanvas.Brush.Color := clWhite;
    ACanvas.Font.Color := clBlack;
  End;
end;

procedure TfrmFatImportarItensRequisicao.cxgReqViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN Then
    pMarcaDesmarca;

  If Key = VK_ESCAPE Then
    btnSair.Click;
end;

procedure TfrmFatImportarItensRequisicao.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte (cdsReqCODITE);
end;

procedure TfrmFatImportarItensRequisicao.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10: btnConfirmar.Click;
    VK_F6: btnMarDes.Click;
    VK_F7: btnMarDesTodos.Click;
  End;
end;

procedure TfrmFatImportarItensRequisicao.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(cxgReq);
end;

procedure TfrmFatImportarItensRequisicao.pCarregaRequisicoes(strCodCli, strSeqRcd: String);
  Var
    qryReq: TUniQuery;
begin
  inherited;
  qryReq := fCriaQuery;

  Try
    qryReq.SQL.Add('SELECT SQL_NO_CACHE');
    qryReq.SQL.Add('  MOVRCD.AUTOINCREM,');
    qryReq.SQL.Add('  RCG_CODIGO AS CODREQ,');
    qryReq.SQL.Add('  RCG_DTACAD AS DTACAD,');
    qryReq.SQL.Add('  CONCAT(RCG_CODVEN, "-", OPE_NOMOPE) AS NOMOPE,');
    qryReq.SQL.Add('  CONCAT(RCG_CODCLI, "-", CLI_NOMCLI) AS NOMCLI,');
    qryReq.SQL.Add('  RCD_CODITE AS CODITE,');
    qryReq.SQL.Add('  ITE_DESITE AS DESITE,');
    qryReq.SQL.Add('  CONCAT(RCD_CODITE, "-", ITE_DESITE) AS PRODUT,');
    qryReq.SQL.Add('  ITE_REFERE AS REFERE,');
    qryReq.SQL.Add('  UNI_SIGUNI AS SIGUNI,');
    qryReq.SQL.Add('  ITE_CODFAB AS CODFAB,');
    qryReq.SQL.Add('  PCD_QTDBAI AS QTDITE');
    qryReq.SQL.Add('FROM');
    qryReq.SQL.Add('  MOVRCG');
    qryReq.SQL.Add('  INNER JOIN MOVRCD ON RCD_CODEMP = RCG_CODEMP AND RCD_CODIGO = RCG_CODIGO');
    qryReq.SQL.Add('  INNER JOIN COTITE ON RCD_SEQCOT = COTITE.AUTOINCREM');
    qryReq.SQL.Add('  INNER JOIN COTGER ON COT_SEQGER = COTGER.AUTOINCREM');
    qryReq.SQL.Add('  INNER JOIN PCMIRQ ON PCM_SEQREQ = MOVRCD.AUTOINCREM');
    qryReq.SQL.Add('  INNER JOIN PCMDET ON PCMDET.AUTOINCREM = PCMIRQ.PCM_SEQDET');
    qryReq.SQL.Add('  INNER JOIN PCMGER ON PCG_NUMPED = PCD_NUMPED AND PCG_ESPDOC = PCD_ESPDOC AND PCG_CODEMP = PCD_CODEMP');
    qryReq.SQL.Add('  INNER JOIN CADOPE ON OPE_CODOPE = RCG_CODVEN');
    qryReq.SQL.Add('  INNER JOIN CADCLI ON CLI_CODCLI = RCG_CODCLI');
    qryReq.SQL.Add('  INNER JOIN CADITE ON ITE_CODITE = RCD_CODITE');
    qryReq.SQL.Add('  INNER JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI');
    qryReq.SQL.Add('  LEFT  JOIN EXTDOR ON FDO_SEQRCD = MOVRCD.AUTOINCREM');
    qryReq.SQL.Add('WHERE');
    qryReq.SQL.Add('  RCD_SEQCOT IS NOT NULL AND');//POSSUEM COTACAO
    qryReq.SQL.Add('  PCD_BAIXAD = 1         AND');//PEDIDO DE COMPRA BAIXADO
    qryReq.SQL.Add('  FDO_SEQRCD IS NULL     AND');//AINDA SEM PEDIDO DE VENDA
    qryReq.SQL.Add('  RCG_CODEMP = :CODEMP   AND');
    qryReq.SQL.Add('  RCG_CODCLI = :CODCLI   AND');
    qryReq.SQL.Add('  MOVRCD.AUTOINCREM NOT IN (' + strSeqRcd + ')');//NAO CARREGA AS ITENS JA INSERIDOS NO PEDIDO DE VENDA
    qryReq.SQL.Add('ORDER BY');
    qryReq.SQL.Add('  PRODUT, CODREQ ');

    qryReq.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryReq.ParamByName('CODCLI').AsString := strCodCli;

    qryReq.Open;

    cdsReq.CreateDataSet;
    While Not qryReq.Eof Do
    Begin
      cdsReq.Append;

      cdsReqAUTOINCREM.AsString := qryReq.FieldByName('AUTOINCREM').AsString;
      cdsReqCODREQ.AsString     := qryReq.FieldByName('CODREQ').AsString;
      cdsReqCODITE.AsString     := qryReq.FieldByName('CODITE').AsString;
      cdsReqDTACAD.AsDateTime   := qryReq.FieldByName('DTACAD').AsDateTime;
      cdsReqNOMOPE.AsString     := qryReq.FieldByName('NOMOPE').AsString;
      cdsReqNOMCLI.AsString     := qryReq.FieldByName('NOMCLI').AsString;
      cdsReqPRODUT.AsString     := qryReq.FieldByName('PRODUT').AsString;
      cdsReqDESITE.AsString     := qryReq.FieldByName('DESITE').AsString;
      cdsReqREFERE.AsString     := qryReq.FieldByName('REFERE').AsString;
      cdsReqSIGUNI.AsString     := qryReq.FieldByName('SIGUNI').AsString;
      cdsReqCODFAB.AsString     := qryReq.FieldByName('CODFAB').AsString;
      cdsReqQTDITE.AsFloat      := qryReq.FieldByName('QTDITE').AsFloat;
      cdsReqMARDES.AsInteger    := 0;

      cdsReq.Post;

      qryReq.Next;
    End;
  Finally
    FreeAndNil(qryReq);
  End;

end;

procedure TfrmFatImportarItensRequisicao.pMarcaDesmarca;
begin
  If cdsReq.IsEmpty Then Exit;

  cdsReq.Edit;
  cdsReqMARDES.AsInteger := Sqr(cdsReqMARDES.AsInteger-1); //0-1 = -1² = 1 | 1-1 = 0² = 0;
  cdsReq.Post;

  cxgReqView.DataController.Refresh;
end;

function TfrmFatImportarItensRequisicao.fCarregaItensRequisicao: Boolean;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fCarregaItensRequisicaoInterna;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  pFreeAndNil(frmGravando);
end;

function TfrmFatImportarItensRequisicao.fCarregaItensRequisicaoInterna(pgbStatus: TcxProgressBar): Boolean;
begin
  With cdsReq Do
  Begin
    First;

    Result := False;

    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := RecordCount;

    While Not Eof Do
    Begin
      pgbStatus.Position := RecNo;
      Application.ProcessMessages;

      If FieldByName('MARDES').AsInteger > 0 Then
      Begin
        Result := fIncluirItem(FieldByName('CODITE').AsString,
                               FieldByName('DESITE').AsString,
                               FieldByName('QTDITE').AsFloat,
                               0.00,
                               FieldByName('AUTOINCREM').AsString);
        If Not Result Then
          Break;
      End;

      Next;
    End;

  End;
end;

end.
