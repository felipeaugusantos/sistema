unit untFatSelPedidoCompraRequisicao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untZClient, untFuncoesSimples, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, EditFocus,
  untPaiConfirma, Datasnap.DBClient, UniClientDataSet, System.UITypes, untTCdsVinculosRequisicoes;

type
  TfrmFatSelPedidoCompraRequisicao = class(TfrmPaiConfirma)
    pnlCabecalho: TPanel;
    edtDesIte: TEditFocus;
    lblProduto: TLabel;
    lblQtd: TLabel;
    edtQtd: TEditFocus;
    btnConsultar: TBitBtnLocked;
    dtsPedidos: TDataSource;
    cxlPedidosCompra: TcxGridLevel;
    cxgPedidosCompra: TcxGridCitel;
    cxvPedidosCompra: TcxGridDBTableViewCitel;
    chkPedidosAtendemQtd: TCheckBox;
    cxvPedidosCompraNUMPED: TcxGridDBColumn;
    cxvPedidosCompraNOMFOR: TcxGridDBColumn;
    cxvPedidosCompraCODFOR: TcxGridDBColumn;
    cxvPedidosCompraDTAENT: TcxGridDBColumn;
    cxvPedidosCompraQTDPED: TcxGridDBColumn;
    cxvPedidosCompraDTAPED: TcxGridDBColumn;
    cxvPedidosCompraCODEMP: TcxGridDBColumn;
    pnlRodape: TPanel;
    edtQtdRestVinc: TEditFocus;
    lblQtdRestante: TLabel;
    btnVincular: TBitBtnLocked;
    btnReiniciarVinculosItem: TBitBtnLocked;
    shpLegendaExisteVinculo: TShape;
    lblPedidoVinculado: TLabel;
    cxvPedidosCompraVINCUL: TcxGridDBColumn;
    btnExcluirVinculo: TBitBtnLocked;
    cxvPedidosCompraQTDVIN: TcxGridDBColumn;
    cxgItensAvulso: TcxGridCitel;
    cxvItensAvulso: TcxGridDBTableViewCitel;
    cxlItensAvulso: TcxGridLevel;
    Splitter1: TSplitter;
    cxvItensAvulsoCODITE: TcxGridDBColumn;
    cxvItensAvulsoQTDITE: TcxGridDBColumn;
    cxvItensAvulsoAVULSA: TcxGridDBColumn;
    cxvItensAvulsoDESITE: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnVincularClick(Sender: TObject);
    procedure btnReiniciarVinculosItemClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxvPedidosCompraCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnExcluirVinculoClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxvItensAvulsoDESITEGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxvItensAvulsoAVULSAGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FCdsPedidos: TZClient;
    FfltQtdRestante: Double;
    function fGetSQL: String;
    procedure pConsultar;
    procedure pAtualizaEditQtdRestante;
    procedure pVincularNoPedido(AFltQtd: Double);
    function fValidaVinculo: Boolean;

    function fVerificaQtd: Boolean;
    procedure pReiniciarVinculos;
    function fGetQtdRestante: Double;
    function fGetSQLGarantia: String;
    procedure pAtualizaDataSetManutPedidoNaoEncontrado;
    function fConfirmaVinculoManutencaoReq: Boolean;
    function fGerarRequisicaoAvulsa: Boolean;
  public
    FstrCodIte: String;
    FfltQtdIte: Double;
    FstrDesIte: String;
    FblnManutReq: Boolean;
    FblnConsultou: Boolean;
    FintControlManut: Integer;
    FcdsVinculos: TUniClientDataSet;
    FcdsManutencao: TUniClientDataSet;
    Class Procedure pMostraTela(AstrCodIte: String);
    Class Function fJaPossuiVinculos(AStrCodIte: String): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmFatSelPedidoCompraRequisicao: TfrmFatSelPedidoCompraRequisicao;

implementation

{$R *.dfm}

{ TfrmFatSelPedidoCompraRequisicao }

procedure TfrmFatSelPedidoCompraRequisicao.btnConfirmaClick(Sender: TObject);
begin
  if FblnManutReq then
  begin
    if fConfirmaVinculoManutencaoReq then
      inherited;

    Exit;
  end;

  if (FfltQtdIte > 0) and (FCdsPedidos.IsEmpty) then
  begin
    pConsultar;

    if FCdsPedidos.IsEmpty then
    begin
      inherited;
      Exit;
    end;
  end;

  If StrToFloat(edtQtd.Text) <= 0 Then
  Begin
    inherited;
    Exit;
  End;

  If (fGetQtdRestante = 0) Then
  Begin
    If Not FCdsVinculos.IsEmpty Then
    Begin
      inherited;
      Exit
    End

  End
  Else
  Begin
    If fMensagem('', 'Ainda há quantidade restante a ser vinculada. Para essa quantidade será gerada uma requisição de compra avulsa. Prosseguir?', ['&Sim', '&Não']) = 1 Then
    Begin
      FCdsVinculos.Insert;
      FCdsVinculos.FieldByName('AVULSA').AsString := 'S';
      FCdsVinculos.FieldByName('AUTINC').AsString := '';
      FCdsVinculos.FieldByname('ITE_CODITE').AsString := FStrCodIte;
      FCdsVinculos.FieldByName('QTDITE').AsFloat := FFltQtdRestante;
      FCdsVinculos.FieldByname('DESITE').AsString := FstrDesIte;
      FCdsVinculos.Post;
      inherited;
    End;
  End;

  If Not FblnConsultou Then
    btnConsultarClick(Self);
End;

procedure TfrmFatSelPedidoCompraRequisicao.btnConsultarClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
    pConsultar;
end;

procedure TfrmFatSelPedidoCompraRequisicao.btnExcluirVinculoClick(
  Sender: TObject);
begin
  inherited;
  If FCdsVinculos.isEmpty Then
    Exit;

  If fMensagem('', 'Confirma exclusão do vínculo para este item?', ['&Sim', '&Não']) = 1 Then
  Begin
    if (not FblnManutReq) then
      FCdsVinculos.Delete;

    If FCdsPedidos.Active Then
      Begin
      FCdsPedidos.Edit;
      FCdsPedidos.FieldByName('VINCUL').AsString := 'N';
      FCdsPedidos.FieldByName('QTDVIN').AsFloat := 0;
      FCdsPedidos.Post;
    End;

    pAtualizaEditQtdRestante;
  End;
end;

procedure TfrmFatSelPedidoCompraRequisicao.btnReiniciarVinculosItemClick(
  Sender: TObject);
begin
  inherited;
  If FCdsVinculos.isEmpty Then
    Exit;

  If Not fMensagem('', 'Confirma reinício dos vínculos para este item?', ['&Sim', '&Não']) = 1 Then
    Exit;

  pReiniciarVinculos;
end;

procedure TfrmFatSelPedidoCompraRequisicao.pReiniciarVinculos;
begin
  FCdsVinculos.First;

  if (not FblnManutReq) then
  begin
    While Not FCdsVinculos.Eof Do
      FCdsVinculos.Delete;
  end;

  If Not FCdsPedidos.Active Then
    Exit;

  FCdsPedidos.First;
  While Not FCdsPedidos.Eof Do
  Begin
    FCdsPedidos.Edit;
    FCdsPedidos.FieldByName('VINCUL').AsString := 'N';
    FCdsPedidos.FieldByName('QTDVIN').AsFloat := 0;
    FCdsPedidos.Post;

    FCdsPedidos.Next;
  End;

  pSetFocus(edtQtd);
  pAtualizaEditQtdRestante;
end;

procedure TfrmFatSelPedidoCompraRequisicao.btnVincularClick(Sender: TObject);
begin
  inherited;
  pVincularNoPedido(StrToFloatDef(edtQtdRestVinc.Text, 0));
end;

procedure TfrmFatSelPedidoCompraRequisicao.cxvItensAvulsoAVULSAGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If AText = 'S' then
    AText := 'SIM';
end;

procedure TfrmFatSelPedidoCompraRequisicao.cxvItensAvulsoDESITEGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If fEmptyStr(AText) then
    AText := IIf(fEmptyStr(FstrDesIte), fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [FstrCodIte]), FstrDesIte);
end;

procedure TfrmFatSelPedidoCompraRequisicao.cxvPedidosCompraCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvPedidosCompraVINCUL.Index]) = 'S' Then
    ACanvas.Brush.Color := shpLegendaExisteVinculo.Brush.Color;
end;

function TfrmFatSelPedidoCompraRequisicao.fVerificaQtd: Boolean;
begin
  Result := True;
  If FFltQtdRestante <= 0 Then
  Begin
    pMensagemOk('Toda a quantidade solicitada já foi vinculada');
    Result := False;
  End;
end;

function TfrmFatSelPedidoCompraRequisicao.fValidaVinculo: Boolean;
begin
  Result := False;
  If FCdsPedidos.isEmpty Then
    Exit;

  If Not fVerificaQtd Then
    Exit;

  If FCdsPedidos.FieldByName('VINCUL').AsString = 'S' Then
  Begin
    pMensagemOk('Pedido já vinculado para este item');
    Exit;
  End;
  Result := True;
end;

procedure TfrmFatSelPedidoCompraRequisicao.pVincularNoPedido(AFltQtd: Double);
begin
   if not fValidaVinculo then
     Exit;

  if (not FblnManutReq) then
  begin
    FCdsVinculos.Insert;
    FCdsVinculos.FieldByName('ITE_CODITE').AsString := FstrCodIte;
    FCdsVinculos.FieldByName('DESITE').AsString := FstrDesIte;
    FCdsVinculos.FieldByName('AUTINC').AsString := FCdsPedidos.FieldByName('AUTINC').AsString;
    FCdsVinculos.FieldByName('AUTGER').AsString := FCdsPedidos.FieldByName('AUTGER').AsString;
    FCdsVinculos.FieldByName('NUMPED').AsString := FCdsPedidos.FieldByName('PCG_NUMPED').AsString;

    if (FcdsPedidos.FieldByName('PCG_DTAENT').AsDateTime > 0) then
      FCdsVinculos.FieldByName('DTAENT').AsDateTime  := FcdsPedidos.FieldByName('PCG_DTAENT').AsDateTime
    else
      FCdsVinculos.FieldByName('DTAENT').Clear;

    if (FcdsPedidos.FieldByName('PCG_DTAPED').AsDateTime > 0) then
      FCdsVinculos.FieldByName('DTAPED').AsDateTime  := FcdsPedidos.FieldByName('PCG_DTAPED').AsDateTime
    else
      FCdsVinculos.FieldByName('DTAPED').Clear;

    If FFltQtdRestante < FCdsPedidos.FieldByName('QTDPED').AsFloat Then
      FCdsVinculos.FieldByName('QTDITE').AsFloat := AFltQtd
    Else
      FCdsVinculos.FieldByName('QTDITE').AsFloat := FCdsPedidos.FieldByName('QTDPED').AsFloat;
    FCdsVinculos.Post;
  end;

  FcdsPedidos.Edit;
  FcdsPedidos.FieldByName('VINCUL').AsString := 'S';
  If FFltQtdRestante < FCdsPedidos.FieldByName('QTDPED').AsFloat Then
    FcdsPedidos.FieldByName('QTDVIN').AsFloat := FFltQtdRestante
  Else
    FcdsPedidos.FieldByName('QTDVIN').AsFloat := FCdsPedidos.FieldByName('QTDPED').AsFloat;
  FcdsPedidos.Post;

  pAtualizaEditQtdRestante;
end;

procedure TfrmFatSelPedidoCompraRequisicao.pAtualizaDataSetManutPedidoNaoEncontrado;
begin
  pMensagemOk('Não foram encontrados pedidos para a quantidade solicitada. Será gerada uma requisição avulsa para a quantidade solicitada.');
  FcdsManutencao.First;

  while not FcdsManutencao.Eof do
    FcdsManutencao.Delete;

  FcdsManutencao.Insert;
  FcdsManutencao.FieldByName('CODITE').AsString    := FstrCodIte;
  FcdsManutencao.FieldByName('DESITE').AsString    := IIf(fEmptyStr(FstrDesIte), fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [FstrCodIte]), FstrDesIte);
  FcdsManutencao.FieldByName('QTDITE').AsFloat     := FfltQtdIte;
  FcdsManutencao.FieldByName('CONTROLE').AsInteger := FintControlManut;
  FcdsManutencao.FieldByName('AVULSA').AsString := 'S';
  FcdsManutencao.Post;
  inc(FintControlManut);

  ModalResult := mrOk;
  PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmFatSelPedidoCompraRequisicao.pAtualizaEditQtdRestante;
begin
  FFltQtdRestante := fGetQtdRestante;
  edtQtdRestVinc.Text := FloatToStr(FFltQtdRestante);
end;

function TfrmFatSelPedidoCompraRequisicao.fGerarRequisicaoAvulsa: Boolean;
begin
  if (FfltQtdIte > 0) then
  begin
    pMensagemOk('Não foram encontrados pedidos para a quantidade solicitada. Será gerada uma requisição avulsa para a quantidade solicitada.');
    Exit(True);
  end;

  Result := fMensagem('', 'Não foram encontrados pedidos para a quantidade solicitada, gerar uma requisição avulsa para toda a quantidade solicitada?', ['&Sim', '&Não']) = 1;
end;

function TFrmFatSelPedidoCompraRequisicao.fGetQtdRestante: Double;
var
  fltSomaQtd: Double;
  intRecNo: Integer;
begin
  fltSomaQtd := 0;
  If Not FCdsPedidos.Active Then
    Exit(0);

  intRecNo := FCdsPedidos.RecNo;
  FCdsPedidos.First;
  While Not FCdsPedidos.Eof Do
  Begin
    fltSomaQtd := fltSomaQtd + FCdsPedidos.FieldByName('QTDVIN').AsFloat;
    FCdsPedidos.Next;
  End;
  Result := StrToFloatDef(edtQtd.Text, 0) - fltSomaQtd;

  FCdsPedidos.RecNo := intRecNo;
end;

function TfrmFatSelpedidoCompraRequisicao.fGetSQLGarantia:String;
begin
  Result := '';
  Result := Result + ' IF((COALESCE((SELECT COUNT(1)           ';
  Result := Result + '             FROM MOVGAE D                     ';
  Result := Result + '            WHERE D.GAE_NUMENV = SUBSTRING(PCG_DOCORI,1,' + IntToStr(fTamDocCadRec) + ')';
  Result := Result + '              AND D.GAE_ESPENV = SUBSTRING(PCG_DOCORI,' + IntToStr(IIf(fTamDocCadRec = 6, 7, 13)) + ',2) ';
  Result := Result + '              AND D.GAE_EMPENV = SUBSTRING(PCG_DOCORI, LENGTH(PCG_DOCORI) - 2, LENGTH(PCG_DOCORI))) , 0) > 0) OR ';
  Result := Result + '  (COALESCE((SELECT COUNT(1)                               ';
  Result := Result + '   FROM PCMDET                                             ';
  Result := Result + '     INNER JOIN SEQGAR ON SEQ_PCMDET = PCMDET.AUTOINCREM   ';
  Result := Result + '   WHERE PCD_NUMPED = PCG_NUMPED                           ';
  Result := Result + '     AND PCD_CODEMP = PCG_CODEMP                           ';
  Result := Result + '     AND PCD_NUMCTN = PCG_NUMCTN                           ';
  Result := Result + '     AND PCD_ESPDOC = PCG_ESPDOC),0) > 0 ), "SIM", "NÃO" ) AS GARANT, ';
end;

function TfrmFatSelPedidoCompraRequisicao.fGetSQL: String;
begin
  Result := '';
  Result := Result + '  SELECT                                      ';
  Result := Result + '    *                                         ';
  Result := Result + '  FROM                                        ';
  Result := Result + '    (SELECT                                   ';
  Result := Result + '      PCG_NUMPED,                             ';
  Result := Result + '      PCMDET.AUTOINCREM AS AUTINC,            ';
  Result := Result + '      PCMGER.AUTOINCREM AS AUTGER,            ';
  Result := Result + '      CAST("N" AS CHAR(1)) AS VINCUL,         ';
  Result := Result + '      CAST(0 AS DECIMAL(12,2)) AS QTDVIN,     ';
  Result := Result + '      PCG_CODEMP,                             ';
  Result := Result + '      PCG_DTAPED,                             ';
  Result := Result + '      PCG_DTAENT,                             ';
  Result := Result + '      F.FOR_CODFOR,                           ';
  Result := Result + '      F.FOR_NOMFOR,                           ';
  Result := Result + '      IF((IFNULL(EMP_FORFIL, "") <> "") AND   ';
  Result := Result + '      (IFNULL(PCG_DOCORI, "") <> ""), "SIM", "NÃO") AS TRANSF, ';
  Result := Result + fGetSQLGarantia;
  Result := Result + '      SUM(PCD_QTDITE) - IFNULL((SELECT SUM(RCD_QTDITE) FROM MOVRCD WHERE RCD_SEQPCD = PCMDET.AUTOINCREM AND RCD_CODITE = PCMDET.PCD_CODITE), 0) AS QTDPED ';
  Result := Result + '    FROM                                      ';
  Result := Result + '      PCMGER                                  ';
  Result := Result + '      INNER JOIN PCMDET                       ';
  Result := Result + '        ON PCD_NUMPED = PCG_NUMPED            ';
  Result := Result + '        AND PCD_CODEMP = PCG_CODEMP           ';
  Result := Result + '        AND PCD_ESPDOC = PCG_ESPDOC           ';
  Result := Result + '        AND PCD_NUMCTN = PCG_NUMCTN           ';
  Result := Result + '      INNER JOIN CADFOR F                     ';
  Result := Result + '        ON PCG_CODFOR = F.FOR_CODFOR          ';
  Result := Result + '      LEFT JOIN CADEMP                        ';
  Result := Result + '        ON EMP_FORFIL = PCG_CODFOR            ';
  Result := Result + '       AND PCG_ESPDOC = PCD_ESPDOC            ';
  Result := Result + '       AND PCG_CODEMP = PCD_CODEMP            ';
  Result := Result + '    WHERE PCG_BAIXAD = 0                      ';
  Result := Result + '       AND PCD_CODITE = :CODITE               ';
  Result := Result + '       AND PCD_BAIXAD = 0                     ';
  Result := Result + '       AND PCG_NUMCTN = 0                     ';
  Result := Result + '       AND PCG_ESPDOC = "PD"                  ';
  Result := Result + '    GROUP BY PCG_NUMPED ) PED                 ';
  Result := Result + '    WHERE GARANT = "NÃO" AND TRANSF = "NÃO"   ';
  Result := Result + '      AND QTDPED > 0                          ';

  If chkPedidosAtendemQtd.Checked Then
    Result := Result + '   AND QTDPED >= :QTDITE                  ';

  Result := Result + '  GROUP BY PCG_NUMPED, QTDPED                 ';
  Result := Result + '  ORDER BY PCG_DTAENT DESC                    ';
end;

procedure TfrmFatSelPedidoCompraRequisicao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FCdsVinculos.Filtered := False;
end;

procedure TfrmFatSelPedidoCompraRequisicao.FormCreate(Sender: TObject);
begin
  inherited;
  FCdsVinculos := TCdsVinculosRequisicoes.fGetClientDataSet;

  If Not Assigned(FCdsVinculos) Then
    Exit;

  FFltQtdRestante := 0;

  FCdsPedidos := TZClient.Create(Self);
  dtsPedidos.DataSet := FCdsPedidos;
  FFltQtdRestante := 0;
  FfltQtdIte := 0;
  FblnManutReq := False;
  FblnConsultou := False;
end;

procedure TfrmFatSelPedidoCompraRequisicao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_DELETE: btnExcluirVinculo.Click;
    VK_F3: btnVincular.Click;
    VK_F4: btnReiniciarVinculosItem.Click;
  End;
end;

procedure TfrmFatSelPedidoCompraRequisicao.FormShow(Sender: TObject);
begin
  inherited;
  edtQtd.Text := '0,00';
  pSetFocus(edtQtd);
  edtDesIte.Text := FStrCodIte + ' - ' + IIf(fEmptyStr(FstrDesIte), fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [FstrCodIte]), FstrDesIte);

  if (FfltQtdIte > 0) then
  begin
    edtQtd.Text := FloatToStrF(FfltQtdIte, ffFixed, 12, 4);
    edtQtd.Enabled := False;
  end;

  if FblnManutReq then
    btnConsultarClick(Self);
end;

class function TfrmFatSelPedidoCompraRequisicao.fJaPossuiVinculos(AStrCodIte: String): Boolean;
Var
  cdsVin: TUniClientDataSet;
begin
  cdsVin := TCdsVinculosRequisicoes.fGetClientDataSet;
  If Not Assigned(cdsVin) Then
    Exit(False);

  cdsVin.Filter := 'ITE_CODITE = ' + QuotedStr(AStrCodIte);
  cdsVin.Filtered := True;

  Result := Not cdsVin.IsEmpty;
end;

function TfrmFatSelPedidoCompraRequisicao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtQtd) Then
    Begin
      If fEmptyStr(edtQtd.Text) Then
      Begin
        edtQtd.Text := '0,00';
        Result := False;
        pMensagemOk('A quantidade para a requisição deve ser informada');
      End;
      If StrToFloat(edtQtd.Text) = 0 Then
      Begin
        Result := False;
        pMensagemOk('A quantidade para a requisição deve ser maior que zero');
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

class procedure TfrmFatSelPedidoCompraRequisicao.pMostraTela(AstrCodIte: String);
Var
  frmFatSelPedido : TfrmFatSelPedidoCompraRequisicao;
  cdsVin,
  cdsAvu: TUniClientDataSet;
  dtsVinculos: TDataSource;
begin
  cdsVin := TCdsVinculosRequisicoes.fGetClientDataSet;
  If Not Assigned(cdsVin) Then
    Exit;

  cdsAvu := TUniClientDataSet.Create(Nil);

  dtsVinculos := fCriaDataSource(cdsAvu);

  Try
    cdsVin.Filtered := False;
    cdsVin.Filter := '';
    cdsVin.Filter := 'ITE_CODITE = ' + QuotedStr(AStrCodIte) + ' AND AVULSA = ''S''';
    cdsVin.Filtered := True;
    pCloneDataSet(cdsAvu, cdsVin);
    cdsVin.Filtered := False;
    cdsAvu.Filter := 'ITE_CODITE = ' + QuotedStr(AStrCodIte) + ' AND AVULSA = ''S''';
    cdsAvu.Filtered := True;
    Try
      pCriarFormularios(TfrmFatSelPedidoCompraRequisicao, frmFatSelPedido);
      frmFatSelPedido.FstrCodIte := AstrCodIte;
      frmFatSelPedido.cxvItensAvulso.DataController.DataSource := dtsVinculos;
      frmFatSelPedido.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  Finally
    FreeAndNil(frmFatSelPedido);
  End;
end;

function TfrmFatSelPedidoCompraRequisicao.fConfirmaVinculoManutencaoReq: Boolean;
var
  strDesIte: String;
begin
  Result := False;

  if FFltQtdRestante > 0 then
    If fMensagem('', 'Ainda há quantidade restante a ser vinculada. Para essa quantidade será gerada uma requisição de compra avulsa. Prosseguir?', ['&Sim', '&Não']) = 2 then
    begin
      ModalResult := mrNone;
      Exit;
    end;

  while not FcdsManutencao.Eof do
    FcdsManutencao.Delete;

  strDesIte := IIf(fEmptyStr(FstrDesIte), fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [FstrCodIte]), FstrDesIte);

  FcdsPedidos.Filtered := False;
  FcdsPedidos.Filter := 'VINCUL=''S''';
  FcdsPedidos.Filtered := True;

  if (not FcdsPedidos.IsEmpty) then
  begin
    FcdsPedidos.First;

    while not FcdsPedidos.Eof do
    begin
      FcdsManutencao.Append;
      FcdsManutencao.FieldByName('CODITE').AsString    := FstrCodIte;
      FcdsManutencao.FieldByName('DESITE').AsString    := strDesIte;;
      FcdsManutencao.FieldByName('QTDITE').AsFloat     := FcdsPedidos.FieldByName('QTDVIN').AsFloat;
      FcdsManutencao.FieldByName('AUTINC').AsString    := FcdsPedidos.FieldByName('AUTINC').AsString;
      FcdsManutencao.FieldByName('AUTGER').AsString    := FcdsPedidos.FieldByName('AUTGER').AsString;
      FcdsManutencao.FieldByName('NUMPED').AsString    := FcdsPedidos.FieldByName('PCG_NUMPED').AsString;
      FcdsManutencao.FieldByName('DTAENT').AsDateTime  := FcdsPedidos.FieldByName('PCG_DTAENT').AsDateTime;
      FcdsManutencao.FieldByName('DTAPED').AsDateTime  := FcdsPedidos.FieldByName('PCG_DTAPED').AsDateTime;
      FcdsManutencao.FieldByName('CONTROLE').AsInteger := FintControlManut;
      FcdsManutencao.Post;

      inc(FintControlManut);

      FcdsPedidos.Next;
    end;
  end;

  if FFltQtdRestante > 0 then
  begin
    FcdsManutencao.Insert;
    FcdsManutencao.FieldByName('CODITE').AsString    := FstrCodIte;
    FcdsManutencao.FieldByName('DESITE').AsString    := strDesIte;
    FcdsManutencao.FieldByName('QTDITE').AsFloat     := FFltQtdRestante;
    FcdsManutencao.FieldByName('CONTROLE').AsInteger := FintControlManut;
    FcdsManutencao.FieldByName('AVULSA').AsString    := 'S';
    FcdsManutencao.Post;
    inc(FintControlManut);
  end;

  Result := True;
end;

procedure TfrmFatSelPedidoCompraRequisicao.pConsultar;
begin

  Try
    FCdsPedidos.qryQuery.SQL.Clear;
    FCdsPedidos.qryQuery.SQL.Add(fGetSQL);
    FCdsPedidos.qryQuery.ParamByName('CODITE').AsString := FStrCodIte;

    If chkPedidosAtendemQtd.Checked Then
      FCdsPedidos.qryQuery.ParamByName('QTDITE').AsFloat := StrToFloatDef(edtQtd.Text, 0);

    FCdsPedidos.fAbreClient(True, 'TfrmFatSelPedidoCompraRequisicao.pConsultar');
    FCdsPedidos.First;

    While Not FCdsPedidos.Eof Do
    Begin
      If FCdsVinculos.Locate('AUTINC', FcdsPedidos.FieldByName('AUTINC').AsString, []) Then
      Begin
        FcdsPedidos.Edit;
        FcdsPedidos.FieldByName('VINCUL').AsString := 'S';
        FcdsPedidos.FieldByName('QTDVIN').AsFloat := FCdsVinculos.FieldByName('QTDITE').AsFloat;
        FcdsPedidos.Post;
      End;
      FCdsPedidos.Next;
    End;


    If FCdsPedidos.IsEmpty Then
    Begin
      if FblnManutReq then
        pAtualizaDataSetManutPedidoNaoEncontrado
      else
      begin
        If fGerarRequisicaoAvulsa Then
        Begin
          FCdsVinculos.Insert;
          FCdsVinculos.FieldByName('AVULSA').AsString := 'S';
          FCdsVinculos.FieldByName('AUTINC').AsString := '';
          FCdsVinculos.FieldByname('ITE_CODITE').AsString := FStrCodIte;
          FCdsVinculos.FieldByname('DESITE').AsString := FstrDesIte;
          FCdsVinculos.FieldByName('QTDITE').AsFloat := StrToFloatDef(edtQtd.Text, 0);
          FCdsVinculos.Post;
          ModalResult := mrOk;
        End
        Else
        Begin
          pSetFocus(edtQtd);
          Exit;
        End;
      End;
    End;

    FblnConsultou := True;
    pAtualizaEditQtdRestante;
    cxvPedidosCompra.ApplyBestFit;

  Except On
    E:Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmFatSelPedidoCompraRequisicao.pConsultar');
    End;
  End;
end;

end.
