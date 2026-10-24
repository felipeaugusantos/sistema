unit untFatLibReservaEstoqueOS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, System.UITypes,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Vcl.Mask,
  MaskEditFocus, EditFocus, untZClient, Uni, cxTextEdit, untLiberacao,
  UniClientDataSet;

type
  TfrmFatLibReservaEstoqueOS = class(TfrmPaiSimples)
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    dtsItens: TDataSource;
    dtsPedidos: TDataSource;
    Panel1: TPanel;
    pnlTopo: TPanel;
    lblEmpresa: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    edtNumDoc: TEditFocus;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtNumOS: TEditFocus;
    edtCodEOS: TEditFocus;
    edtDesEOS: TEditFocus;
    btnFiltrar: TBitBtnLocked;
    pnlButtons: TPanel;
    FlwPnlButtons: TFlowPanel;
    btnConfirmar: TBitBtnLocked;
    btnSelecionarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    btnSelecionarItensPD: TBitBtnLocked;
    btnExpandirTodos: TBitBtnLocked;
    btnFechar: TBitBtnLocked;
    pnlBottom: TPanel;
    cxGrid: TcxGridCitel;
    cxGridTBV1: TcxGridDBTableViewCitel;
    cxGridTBV1DTAENT: TcxGridDBColumn;
    cxGridTBV1NUMPED: TcxGridDBColumn;
    cxGridTBV1CODEMP: TcxGridDBColumn;
    cxGridTBV1NOMCLI: TcxGridDBColumn;
    cxGridTBV1NUMOSE: TcxGridDBColumn;
    cxGridTBV1STATUS: TcxGridDBColumn;
    cxGridTBV2: TcxGridDBTableViewCitel;
    cxGridTBV2CODITE: TcxGridDBColumn;
    cxGridTBV2DESITE: TcxGridDBColumn;
    cxGridTBV2QTDITE: TcxGridDBColumn;
    cxGridTBV2UNIDAD: TcxGridDBColumn;
    cxGridTBV2DESMAR: TcxGridDBColumn;
    cxGridTBV2REFERE: TcxGridDBColumn;
    cxGridTBV2CODFAB: TcxGridDBColumn;
    cxGridTBV2NUMLOT: TcxGridDBColumn;
    cxGridTBV2REQUIS: TcxGridDBColumn;
    cxGridTBV2PEDCOM: TcxGridDBColumn;
    cxGridTBV2ENTMER: TcxGridDBColumn;
    cxGridTBV2QTDENT: TcxGridDBColumn;
    cxGridTBV2MARDES: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    cxGridLevel2: TcxGridLevel;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEOSKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnSelecionarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure btnSelecionarItensPDClick(Sender: TObject);
    procedure btnExpandirTodosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure cxGridTBV2EditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure cxGridTBV2CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridTBV2CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridTBV2NUMLOTPropertiesEditValueChanged(Sender: TObject);
    procedure cxGridTBV2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FExpandido         : Boolean;
    FintCorSel         : Integer;
    FNumPed            : String;
    FTextLib           : String;
    cdsPedidos         : TZClient;
    cdsItens           : TZClient;
    stlListSelecao     : TStringList;
    stlTrava           : TStringList;
    stlPedLib          : TStringList;
    stlTextLib         : TStringList;
    objLiberacao       : TLiberacao;
    strCodigoLiberacao : String;

    function fGetSQLPedidos: String;
    function fGetSQLItensPD: String;
    function fGetParametros: String;
    function fInLista: Boolean;
    function fTravaQtdEstoque: Boolean;
    function fQuantidadeItemMarcado(aCodIte, aNumLot: String): Double;
    procedure pCarregarRegistros;
    procedure pVerificaEstoque;
    procedure pSetaParametros(qry: TUniQuery);
    procedure pMarcaDesmarca;
    procedure pMarcaDesmarcaTodos(aValor: Integer);
    procedure pDesmarcarPedidosTrava;
    procedure pGravaLogLib;
    procedure pCarregaCodigoLiberacao(AstrCodigoLiberacao: String);

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmFatLibReservaEstoqueOS: TfrmFatLibReservaEstoqueOS;

implementation

uses
  untConsultas, untFuncoesSimples, untTypesSistema, untPanelCxClientes,
  untPnlDadosCliente, untIFatReservaSaldo, untTFatReservaSaldo, untTFatEntregaFutura;

{$R *.dfm}

{ TfrmFatLibReservaEstoqueOS }

procedure TfrmFatLibReservaEstoqueOS.btnConfirmarClick(Sender: TObject);
var
  intCont: Integer;
  strSQL : String;
  qryAux,
  qryAtuLot: TUniQuery;
begin
  inherited;

  if (not btnConfirmar.Visible) or (not btnConfirmar.Enabled) then
    Exit;

  if (stlListSelecao.Count = 0) then
  begin
    fMensagem('Atenção', 'Selecione os produtos que terão a reserva liberada antes de confirmar!', ['&Ok']);
    Exit;
  end;

  strSQL := '';
  strSQL := strSQL + ' UPDATE EXTDOR ';
  strSQL := strSQL + ' SET FDO_RESERV = "S" ';
  strSQL := strSQL + ' WHERE FDO_SEQFDO = :SEQFDO ';

  fStartTransaction;

  qryAux := fCriaQuery;
  qryAux.SQL.Text := strSQL;

  strSQL := '';
  strSQL := strSQL + ' UPDATE FATDOR ';
  strSQL := strSQL + ' SET FDO_NUMLOT = :NUMLOT ';
  strSQL := strSQL + ' WHERE AUTOINCREM = :SEQFDO ';

  qryAtuLot := fCriaQuery;
  qryAtuLot.SQL.Text := strSQL;

  cdsItens.DisableControls;
  try
    try
      for intCont := 0 to Pred(stlListSelecao.Count) do
      begin
        if cdsItens.Locate('SEQFDO', stlListSelecao[intCont], []) then
        begin
          qryAtuLot.Close;
          qryAtuLot.ParamByName('SEQFDO').AsString := stlListSelecao[intCont];
          qryAtuLot.ParamByName('NUMLOT').AsString := cdsItens.FieldByName('NUMLOT').AsString;
          qryAtuLot.ExecSQL;

          qryAux.Close;
          qryAux.ParamByName('SEQFDO').AsString := stlListSelecao[intCont];
          qryAux.ExecSQL;

          ReprocessarItem(cdsItens.FieldByName('CODITE').AsString, '', False);
        end;
      end;

      fCommit;
      fMensagem('Atenção', 'Liberação de reserva concluída!', ['&Ok']);
      pCarregarRegistros;
    except on E: Exception do
      fRollback;
    end;
  finally
    FreeAndNil(qryAux);
    FreeAndNil(qryAtuLot);
    cdsItens.EnableControls;
  end;
end;

procedure TfrmFatLibReservaEstoqueOS.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;

  if (not btnDesmarcarTodos.Visible) or (not btnDesmarcarTodos.Enabled) then
    Exit;

  if (not cdsItens.Active) or (cdsItens.IsEmpty) then
    Exit;

  pMarcaDesmarcaTodos(0);
end;

procedure TfrmFatLibReservaEstoqueOS.btnExpandirTodosClick(Sender: TObject);
begin
  inherited;

  if (not btnExpandirTodos.Visible) or (not btnExpandirTodos.Enabled) then
    Exit;

  if FExpandido then
  begin
    cxGridTBV1.ViewData.Collapse(True);
    btnExpandirTodos.Caption := '[F8] Expandir Todos';
  end
  else
  begin
    cxGridTBV1.ViewData.Expand(True);
    btnExpandirTodos.Caption := '[F8] Retrair Todos';
  end;

  FExpandido := not FExpandido;
end;

procedure TfrmFatLibReservaEstoqueOS.btnFiltrarClick(Sender: TObject);
begin
  inherited;

  if (not fVerificaCampos) then
    Exit;

  if ((mskDtaIni.Text = '  /  /    ') and (mskDtaFin.Text <> '  /  /    ')) then
  begin
    fMensagem('AVISO', 'Informe a data inicial', ['&Ok']);
    Exit;
  end;

  if ((mskDtaIni.Text <> '  /  /    ') and (mskDtaFin.Text = '  /  /    ')) then
  begin
    fMensagem('AVISO', 'Informe a data final', ['&Ok']);
    Exit;
  end;

  if ((mskDtaIni.Text <> '  /  /    ') and (mskDtaFin.Text <> '  /  /    ')) then
  begin
    if (StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text)) then
    begin
      fMensagem('AVISO', 'A Data Inicial não pode ser maior que a Data Final.', ['&Ok']);
      Exit;
    end;
  end;

  pCarregarRegistros;

  if (cdsPedidos.RecordCount = 0) then
  begin
    fMensagem('Atenção', 'Não foram encontrados registros para o(s) filtro(s) informado(s)!', ['&Ok']);
    Exit;
  end;
end;

procedure TfrmFatLibReservaEstoqueOS.btnSelecionarItensPDClick(Sender: TObject);
begin
  inherited;

  if (not btnSelecionarItensPD.Visible) or (not btnSelecionarItensPD.Enabled) then
    Exit;

  cdsItens.DisableControls;

  cdsItens.Filtered := False;
  cdsItens.Filter   := 'SEQEQU=''' + cdsPedidos.FieldByName('AUTINC').AsString + '''';
  cdsItens.Filtered := True;

  try
    FNumPed := '';
    FTextLib := '';
    objLiberacao.objMsgLibera.Clear;
    stlTrava.Clear;
    stlPedLib.Clear;
    stlTextLib.Clear;

    cdsItens.First;

    while not cdsItens.Eof do
    begin
      pVerificaEstoque;

      if (not fInLista) then
        stlListselecao.Add(cdsItens.FieldByName('SEQFDO').AsString);

      cdsItens.Edit;
      cdsItens.FieldByName('MARDES').AsInteger := 1;
      cdsItens.Post;

      cdsItens.Next;
    end;

    if (not fEmptyStr(FTextLib)) then
      stlTextLib.Add(FTextLib);

    if not fTravaQtdEstoque then
      pDesmarcarPedidosTrava
    else
      pGravaLogLib;
  finally
    cdsItens.Filtered := False;
    cdsItens.Filter   := '';
    cdsItens.Filtered := True;
    cdsItens.EnableControls;
  end;
end;

procedure TfrmFatLibReservaEstoqueOS.btnSelecionarTodosClick(Sender: TObject);
begin
  inherited;

  if (not btnSelecionarTodos.Visible) or (not btnSelecionarTodos.Enabled) then
    Exit;

  if (not cdsItens.Active) or (cdsItens.IsEmpty) then
    Exit;

  pMarcaDesmarcaTodos(1);
end;

procedure TfrmFatLibReservaEstoqueOS.cxGridTBV2CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pMarcaDesmarca;
end;

procedure TfrmFatLibReservaEstoqueOS.cxGridTBV2CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridTBV2MARDES.Index] = '1') then
  begin
    if ACanvas.Brush.Color = clHighLight then
      ACanvas.Font.Color := clHighLightText
    else
      ACanvas.Brush.Color := FintCorSel;
  end;
end;

procedure TfrmFatLibReservaEstoqueOS.cxGridTBV2EditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
var
  qryCadLot: TUniQuery;
  arrLotes: TConsultasArray;
begin
  inherited;

  Key := AnsiUpperCase(Key)[1];

  if TcxGridDbColumn(AItem).DataBinding.FieldName = 'NUMLOT' then
  begin
    if fEntraCons(Key) then
    begin
      try
        qryCadLot := fCriaQuery;

        if fPesqLoteFat(Self, nil,
                        fCfgSis('DECUNI'),
                        cdsItens.FieldByName('CODITE').AsString,
                        false, false,
                        qryCadLot, Key, arrLotes, '', nil, True, nil, True, True) then
        begin
          if (qryCadLot.FieldByName('LOT_NUMLOT').AsString = 'A DEFINIR')
            or (qryCadLot.FieldByName('LOT_NUMLOT').AsString = 'GARANTIA') then
          begin
            Key := #0;
            pMensagemOk('Não é permitido informar o lote ' + qryCadLot.FieldByName('LOT_NUMLOT').AsString + '!');
          end
          else if (qryCadLot.FieldByName('LOT_LOTAPR').AsString = 'N') then
          begin
            pMensagemOk('Lote "' + qryCadLot.FieldByName('NUMLOT').AsString + '" não liberado. Verifique!');
            Exit;
          end
          else
          begin
            cdsItens.Edit;
            cdsItens.FieldByName('NUMLOT').AsString := qryCadLot.FieldByName('LOT_NUMLOT').AsString;

            if cdsItens.FieldByName('MARDES').AsInteger = 1 then
            begin
              cdsItens.FieldByName('MARDES').AsInteger := 0;

              if fInLista then
                stlListSelecao.Delete(stlListselecao.IndexOf(cdsItens.FieldByName('SEQFDO').AsString));
            end;

            cdsItens.Post;
          end;
        end;
      finally
        FreeAndNil(qryCadLot);
      end;
    end;
  end;
end;

procedure TfrmFatLibReservaEstoqueOS.cxGridTBV2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if (Key = VK_RETURN) then
    pMarcaDesmarca;
end;

procedure TfrmFatLibReservaEstoqueOS.cxGridTBV2NUMLOTPropertiesEditValueChanged(
  Sender: TObject);
var
  strLote: String;
begin
  inherited;

  strLote := TcxTextEdit(Sender).Text;

  if (fEmptyStr(strLote)) then
  begin
    pMensagemOk('Informe um lote para o item ' + cdsItens.FieldByName('CODITE').AsString + '!');
    cdsItens.Cancel;
    Exit;
  end
  else if (strLote = 'A DEFINIR')
    or (strLote = 'GARANTIA') then
  begin
    pMensagemOk('Não é permitido informar o lote ' + strLote + '!');
    cdsItens.Cancel;
    Exit;
  end
  else if not fExisteLote(strLote,
                          cdsItens.FieldByName('CODITE').AsString,
                          VS_strCodEmp,
                          True) then
  begin
    pMensagemOk('O lote informado "' + strLote + '" não existe. Verifique!');
    cdsItens.Cancel;
    Exit;
  end
  else if not fLoteAprovadoLibCompra(cdsItens.FieldByName('CODITE').AsString,
                                     strLote,
                                     VS_strCodEmp) then
  begin
    pMensagemOk('Lote "' + strLote + '" não liberado. Verifique!');
    cdsItens.Cancel;
    Exit;
  end;

  if cdsItens.FieldByName('MARDES').AsInteger = 1 then
  begin
    cdsItens.FieldByName('MARDES').AsInteger := 0;
    cdsItens.FieldByName('MARDES').AsString  := strLote;

    if fInLista then
      stlListSelecao.Delete(stlListselecao.IndexOf(cdsItens.FieldByName('SEQFDO').AsString));
  end;
end;

procedure TfrmFatLibReservaEstoqueOS.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
var
  arrClientes: TConsultasArray;
  objfrmPnl : TPanelCxClientes;
begin
  inherited;

  try
    try
      objfrmPnl := TPanelCxClientes.Create(TfrmPnlDadosCliente);
      objfrmPnl.strNomForm := self.name;

      if fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes,true,objfrmPnl) then
      begin
        if fValidaCampos(edtCodCli, True) then
          SelectNext(ActiveControl, True, True);
      end;
    except
      on E: Exception do
        pMensagensErro(E.Message, '[pCodCliKeyPress]');
    end;
  finally
    FreeAndNil(objfrmPnl);
  end;
end;

procedure TfrmFatLibReservaEstoqueOS.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel : TConsultasArray;
begin
  inherited;
  if fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrSel) then
  begin
    if fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmFatLibReservaEstoqueOS.edtCodEOSKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel : TConsultasArray;
begin
  inherited;
  if fPesqEmpresa(conEmpSimples, Self, edtCodEOS, edtDesEOS, Nil, Key, arrSel) then
  begin
    if fValidaCampos(edtCodEOS, True) Then
      SelectNext(ActiveControl, True, True);
  end;
end;

function TfrmFatLibReservaEstoqueOS.fGetParametros: String;
begin
  Result := '';

  if not fEmptyStr(edtCodEmp.Text) then
    Result := Result + ' AND FGO_CODEMP = :CODEMP ';

  if not fEmptyStr(edtCodCli.Text) then
    Result := Result + ' AND FGO_CODCLI = :CODCLI ';

  if not fEmptyStr(edtNumDoc.Text) then
    Result := Result + ' AND FGO_NUMDOC = :NUMDOC ';

  if (mskDtaIni.Text <> '  /  /    ') and (mskDtaFin.Text <> '  /  /    ') then
    Result := Result + ' AND FGO_DTAENT >= :DTAINI AND FGO_DTAENT <= :DTAFIN ';

  if not fEmptyStr(edtNumOS.Text) then
    Result := Result + ' AND EQU_NUMOSE = :NUMOSE ';

  if not fEmptyStr(edtCodEOS.Text) then
    Result := Result + ' AND EQU_CODEMP = :CODEOS ';
end;

function TfrmFatLibReservaEstoqueOS.fGetSQLItensPD: String;
begin
  Result := '';

  Result := Result + ' SELECT EQUGER.AUTOINCREM SEQEQU, FATDOR.AUTOINCREM SEQFDO, FDO_CODITE CODITE, FDO_DESCRI DESITE, ';
  Result := Result + '     FDO_QTDITE QTDITE, FDO_UNIDAD UNIDAD, MAR_DESMAR DESMAR, FDO_REFERE REFERE, ';
  Result := Result + '     (SELECT ITE_CODFAB FROM CADITE WHERE ITE_CODITE = FDO_CODITE) CODFAB, ';
  Result := Result + '     FDO_NUMLOT NUMLOT, RCD_CODIGO NUMREQ, PCD_NUMPED PEDCOM, ';
  Result := Result + '     CONCAT(PCD_DOCEMI, PCD_ESPEMI) ENTMER, PCD_QTDBAI QTDENT, 0 MARDES ';
  Result := Result + ' FROM FATDOR ';
  Result := Result + ' INNER JOIN FATGOR ON FDO_SEQGER = FATGOR.AUTOINCREM ';
  Result := Result + ' INNER JOIN EQUGER ON FDO_NUMDOC = EQU_NUMPED AND FDO_ESPDOC = EQU_TIPPED AND FDO_CODEMP = EQU_EMPPED ';
  Result := Result + ' INNER JOIN CADMAR ON FDO_CODMAR = MAR_CODMAR ';
  Result := Result + ' LEFT JOIN MOVRCD ON FDO_NUMDOC = RCD_DOCPDV AND FDO_ESPDOC = RCD_ESPPDV AND FDO_CODEMP = RCD_EMPPDV AND FDO_CODITE = RCD_CODITE ';
  Result := Result + ' LEFT JOIN PCMDET ON RCD_SEQPCD = PCMDET.AUTOINCREM ';
  Result := Result + ' WHERE EXISTS (SELECT FDO_RESERV ';
  Result := Result + '               FROM EXTDOR ';
  Result := Result + '               WHERE FDO_RESERV = "N" AND FDO_SEQFDO = FATDOR.AUTOINCREM) AND ';
  Result := Result + '     FDO_JAFATU = 0 ';

  Result := Result + fGetParametros;

  Result := Result + ' ORDER BY 1, 2 ';
end;

function TfrmFatLibReservaEstoqueOS.fGetSQLPedidos: String;
begin
  Result := '';

  Result := Result + ' SELECT EQUGER.AUTOINCREM AUTINC, FGO_DTAENT DTAENT, FGO_NUMDOC NUMPED, FGO_CODEMP CODEMP, ';
  Result := Result + '     CONCAT(CLI_CODCLI, " - ", CLI_NOMCLI) NOMCLI, EQU_NUMOSE NUMOSE, ';
  Result := Result + '     CASE ';
  Result := Result + '         WHEN EQU_FLXSIT = "OI" THEN "OS INCLUÍDA" ';
  Result := Result + '         WHEN EQU_FLXSIT = "TC" THEN "ANÁLISE TÉCNICA CONCLUÍDA" ';
  Result := Result + '         WHEN EQU_FLXSIT = "TA" THEN "ANÁLISE TÉCNICA EM ANDAMENTO" ';
  Result := Result + '         WHEN EQU_FLXSIT = "OR" THEN "ORÇAMENTO REALIZADO" ';
  Result := Result + '         WHEN EQU_FLXSIT = "OA" THEN "ORÇAMENTO APROVADO" ';
  Result := Result + '         WHEN EQU_FLXSIT = "ON" THEN "ORÇAMENTO REPROVADO" ';
  Result := Result + '         WHEN EQU_FLXSIT = "EM" THEN "EM MANUTENÇÃO" ';
  Result := Result + '         WHEN EQU_FLXSIT = "AP" THEN "AG. PEÇAS" ';
  Result := Result + '         WHEN EQU_FLXSIT = "MF" THEN "MANUTENÇÃO FINALIZADA" ';
  Result := Result + '         WHEN EQU_FLXSIT = "AR" THEN "ARMAZENADA" ';
  Result := Result + '         WHEN EQU_FLXSIT = "FA" THEN "FATURADO" ';
  Result := Result + '         WHEN EQU_FLXSIT = "AF" THEN "AG. FATURAMENTO" ';
  Result := Result + '         WHEN EQU_FLXSIT = "AS" THEN "AG. SEPARAÇÃO" ';
  Result := Result + '     END STATUS ';
  Result := Result + ' FROM EQUGER ';
  Result := Result + ' INNER JOIN FATGOR ON EQU_NUMPED = FGO_NUMDOC AND EQU_TIPPED = FGO_ESPDOC AND EQU_EMPPED = FGO_CODEMP ';
  Result := Result + ' INNER JOIN CADCLI ON FGO_CODCLI = CLI_CODCLI ';
  Result := Result + ' WHERE EXISTS (SELECT FDO_RESERV ';
  Result := Result + '               FROM EXTDOR ';
  Result := Result + '               INNER JOIN FATDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM ';
  Result := Result + '               WHERE FDO_RESERV = "N" AND FDO_JAFATU = 0 AND FDO_SEQGER = FATGOR.AUTOINCREM) ';

  Result := Result + fGetParametros;

  Result := Result + ' ORDER BY 1 ';
end;

function TfrmFatLibReservaEstoqueOS.fInLista: Boolean;
begin
  Result := stlListselecao.IndexOf(cdsItens.FieldByName('SEQFDO').AsString) > -1;
end;

procedure TfrmFatLibReservaEstoqueOS.FormCreate(Sender: TObject);
begin
  inherited;

  objLiberacao := TLiberacao.Create;
  cdsPedidos   := TZClient.Create(Nil);
  cdsItens     := TZClient.Create(Nil);

  stlListSelecao := TStringList.Create;
  stlTrava       := TStringList.Create;
  stlPedLib      := TStringList.Create;
  stlTextLib     := TStringList.Create;

  stlListSelecao.Clear;
  stlTrava.Clear;
  stlPedLib.Clear;
  stlTextLib.Clear;

  FintCorSel := clAqua;
end;

procedure TfrmFatLibReservaEstoqueOS.FormDestroy(Sender: TObject);
begin
  inherited;

  dtsPedidos.DataSet := Nil;
  dtsItens.DataSet   := Nil;

  FreeAndNil(objLiberacao);
  FreeAndNil(cdsPedidos);
  FreeAndNil(cdsItens);
  FreeAndNil(stlListSelecao);
  FreeAndNil(stlTrava);
  FreeAndNil(stlPedLib);
  FreeAndNil(stlTextLib);
end;

procedure TfrmFatLibReservaEstoqueOS.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_F10: btnConfirmar.Click;
    VK_F5 : btnSelecionarTodos.Click;
    VK_F6 : btnDesmarcarTodos.Click;
    VK_F7 : btnSelecionarItensPD.Click;
    VK_F8 : btnExpandirTodos.Click;
  end;
end;

procedure TfrmFatLibReservaEstoqueOS.FormShow(Sender: TObject);
begin
  inherited;

  FExpandido := False;

  if (fCfgSis('CTLEST') = '1') then
    cxGridTBV2NUMLOT.Caption := 'Lote';
end;

function TfrmFatLibReservaEstoqueOS.fQuantidadeItemMarcado(aCodIte, aNumLot: String): Double;
var
  intCont : Integer;
  cdsDados: TUniClientDataSet;
begin
  Result := 0;

  cdsDados := TUniClientDataSet.Create(Self);

  try
    pCloneDataSet(cdsDados, cdsItens);

    for intCont := 0 to Pred(stlListSelecao.Count) do
    begin
      if cdsDados.Locate('SEQFDO', stlListSelecao[intCont], []) then
      begin
        if (cdsDados.FieldByName('CODITE').AsString = aCodIte) and
          (cdsDados.FieldByName('NUMLOT').AsString = aNumLot) then
          Result := Result + cdsDados.FieldByName('QTDITE').AsFloat;
      end;
    end;
  finally
    FreeAndNil(cdsDados);
  end;
end;

procedure TfrmFatLibReservaEstoqueOS.pCarregaCodigoLiberacao(
  AstrCodigoLiberacao: String);
begin
  strCodigoLiberacao := AstrCodigoLiberacao;
end;

function TfrmFatLibReservaEstoqueOS.fTravaQtdEstoque: Boolean;
begin
  Result := True;

  strCodigoLiberacao := EmptyStr;

  if objLiberacao.objMsgLibera.IsEmpty then
    Exit;

  objLiberacao.strDirAce := 'LBSDVN';
  objLiberacao.strSenLib := fCfgSis('SESDPE');
  objLiberacao.strMsgSen := 'Liberação de produto sem saldo - Pedido';
  objLiberacao.blnMosMen := True;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;
  objLiberacao.procCarregaCodigoLiberadoGerado := pCarregaCodigoLiberacao;

  Result := objLiberacao.fLibera;
end;

function TfrmFatLibReservaEstoqueOS.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (Sender = edtCodEmp) then
  Begin
    if fEmptyStr(edtCodEmp.Text) then
      edtDesEmp.Clear
    else
    begin
      edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

      if fEmptyStr(edtDesEmp.Text) then
      Begin
        fMensagem('','O código da empresa informado não é válido!', ['&OK']);
        Result := False;
      end;
    end;
  end

  else if (Sender = edtCodEOS) then
  Begin
    if fEmptyStr(edtCodEOS.Text) then
      edtDesEOS.Clear
    else
    begin
      edtDesEOS.Text := fRetNomeEmpresaSelec(edtCodEOS.Text);

      if fEmptyStr(edtDesEOS.Text) then
      Begin
        fMensagem('','O código da empresa OS informado não é válido!', ['&OK']);
        Result := False;
      end;
    end;
  end

  else if (Sender = edtCodCli) then
  begin

    edtNomCli.Clear;

    if not fEmptyStr(edtCodCli.Text) then
    begin
      edtCodCli.Text := fPadL(edtCodCli.Text, edtCodCli.TamCampo, '0');
      edtNomCli.Text := fRetNomCliente(edtCodCli.Text);

      if fEmptyStr(edtNomCli.Text) then
      begin
        fMensagem('AVISO', 'Cliente não encontrado!', ['&Ok']);
        Result := False;
      end;
    end
    else
      edtNomCli.Clear;
  end;
end;

procedure TfrmFatLibReservaEstoqueOS.pCarregarRegistros;
begin
  dtsPedidos.DataSet := Nil;
  cdsPedidos.DisableControls;
  cdsPedidos.qryQuery.SQL.Clear;
  cdsPedidos.qryQuery.SQL.Text := fGetSQLPedidos;
  pSetaParametros(cdsPedidos.qryQuery);
  cdsPedidos.fAbreClient(True, 'TfrmFatLibReservaEstoqueOS.btnFiltrarClick()');
  cdsPedidos.EnableControls;
  dtsPedidos.DataSet := cdsPedidos;

  dtsItens.DataSet := Nil;
  cdsItens.DisableControls;
  cdsItens.qryQuery.SQL.Clear;
  cdsItens.qryQuery.SQL.Text := fGetSQLItensPD;
  pSetaParametros(cdsItens.qryQuery);
  cdsItens.fAbreClient(True, 'TfrmFatLibReservaEstoqueOS.btnFiltrarClick()');
  cdsItens.EnableControls;
  dtsItens.DataSet := cdsItens;
end;

procedure TfrmFatLibReservaEstoqueOS.pDesmarcarPedidosTrava;
var
  intCont: integer;
begin
  for intCont := 0 to Pred(stlTrava.Count) do
  begin
    if cdsItens.Locate('SEQFDO', stlTrava[intCont], []) then
    begin
      cdsItens.Edit;
      cdsItens.FieldByName('MARDES').AsInteger := 0;
      cdsItens.Post;

      if fInLista then
        stlListSelecao.Delete(stlListSelecao.IndexOf(stlTrava[intCont]));
    end;
  end;
end;

procedure TfrmFatLibReservaEstoqueOS.pGravaLogLib;
var
  intCont: integer;
  stlPed : TStringList;
  strText: String;
begin
  stlPed := TStringList.Create;

  try
    for intCont := 0 to Pred(stlPedLib.Count) do
    begin
      stlPed.Clear;
      stlPed.Delimiter := '-';
      stlPed.DelimitedText := stlPedLib[intCont];

      strText := stlPed[0];
      strText := stlPed[1];
      strText := stlPed[2];

      pGeraLogLiberacao(stlPed[0], stlPed[1], stlPed[2], stlTextLib[intCont]);
    end;

    If stlPedLib.Count > 0 Then
      pRemoveLogLiberacao(strCodigoLiberacao);
  finally
    FreeAndNil(stlPed);
  end;
end;

procedure TfrmFatLibReservaEstoqueOS.pMarcaDesmarca;
begin
  if (cdsItens.FieldByName('MARDES').AsInteger = 0) then
  begin
    FNumPed := '';
    FTextLib := '';
    stlTrava.Clear;
    stlPedLib.Clear;
    stlTextLib.Clear;
    objLiberacao.objMsgLibera.Clear;
    pVerificaEstoque;

    if fTravaQtdEstoque then
    begin
      cdsItens.Edit;
      cdsItens.FieldByName('MARDES').AsInteger := 1;

      if (not fEmptyStr(FTextLib)) then
        stlTextLib.Add(FTextLib);

      pGravaLogLib;

      if (not fInLista) then
        stlListSelecao.Add(cdsItens.FieldByName('SEQFDO').AsString);
    end;
  end
  else
  begin
    cdsItens.Edit;
    cdsItens.FieldByName('MARDES').AsInteger := 0;

    if (fInLista) then
      stlListselecao.Delete(stlListSelecao.IndexOf(cdsItens.FieldByName('SEQFDO').AsString));
  end;

  cdsItens.Post;
end;

procedure TfrmFatLibReservaEstoqueOS.pMarcaDesmarcaTodos(aValor: Integer);
var
  strAutInc: String;
begin
  cdsItens.DisableControls;

  try
    if (aValor = 0) then
      stlListSelecao.Clear;

    strAutInc := '';
    FNumPed   := '';
    FTextLib  := '';
    objLiberacao.objMsgLibera.Clear;
    stlTrava.Clear;
    stlPedLib.Clear;
    stlTextLib.Clear;

    cdsItens.First;

    while not cdsItens.Eof do
    begin
      if (strAutInc <> cdsItens.FieldByName('SEQEQU').AsString) then
      begin
        strAutInc := cdsItens.FieldByName('SEQEQU').AsString;
        cdsPedidos.Locate('AUTINC', strAutInc, []);
      end;

      if (aValor = 1) then
        pVerificaEstoque;

      if (aValor = 1) and (not fInLista) then
        stlListselecao.Add(cdsItens.FieldByName('SEQFDO').AsString);

      if (cdsItens.FieldByName('MARDES').AsInteger = aValor) then
      begin
        cdsItens.Next;
        Continue;
      end;

      cdsItens.Edit;
      cdsItens.FieldByName('MARDES').AsInteger := aValor;
      cdsItens.Post;

      cdsItens.Next;
    end;

    if (not fEmptyStr(FTextLib)) then
      stlTextLib.Add(FTextLib);

    if (aValor = 0) then
      Exit;

    if not fTravaQtdEstoque then
      pDesmarcarPedidosTrava
    else
      pGravaLogLib;
  finally
    cdsItens.EnableControls;
  end;
end;

procedure TfrmFatLibReservaEstoqueOS.pSetaParametros(qry: TUniQuery);
begin
  if not fEmptyStr(edtCodEmp.Text) then
    qry.ParamByName('CODEMP').AsString := edtCodEmp.Text;

  if not fEmptyStr(edtCodCli.Text) then
    qry.ParamByName('CODCLI').AsString := edtCodCli.Text;

  if not fEmptyStr(edtNumDoc.Text) then
    qry.ParamByName('NUMDOC').AsString := edtNumDoc.Text;

  if (mskDtaIni.Text <> '  /  /    ') and (mskDtaFin.Text <> '  /  /    ') then
  begin
    qry.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
    qry.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
  end;

  if not fEmptyStr(edtNumOS.Text) then
    qry.ParamByName('NUMOSE').AsString := edtNumOS.Text;

  if not fEmptyStr(edtCodEOS.Text) then
    qry.ParamByName('CODEOS').AsString := edtCodEOS.Text;
end;

procedure TfrmFatLibReservaEstoqueOS.pVerificaEstoque;
var
  fltQuantidade,
  fltSaldoDisp,
  fltSaldos,
  fltFiltro,
  fltGarant,
  fltEstExt,
  fltOrdPro,
  fltQtdSol,
  fltSaldoFisico,
  fltSaldoEntFut,
  fltQtdMarcada: Double;
  blnProdutoEspecialAltoGiro: Boolean;
begin
  fltQtdMarcada := fQuantidadeItemMarcado(cdsItens.FieldByName('CODITE').AsString, cdsItens.FieldByName('NUMLOT').AsString);
  fltQtdSol     := cdsItens.FieldByName('QTDITE').AsFloat;
  fltQuantidade := cdsItens.FieldByName('QTDITE').AsFloat;
  fltSaldos     := fCampoTabela('IFNULL(LOT_SALDOS, 0)', 'CADLOT', ['LOT_STATUS', 'LOT_CODITE', 'LOT_CODEMP', 'LOT_NUMLOT'],
          ['S', cdsItens.FieldByName('CODITE').AsString, cdsPedidos.FieldByName('CODEMP').AsString, cdsItens.FieldByName('NUMLOT').AsString]);

  If fCfgSis('ALTGIR', varBoolean) Then
    blnProdutoEspecialAltoGiro := ProdutoEspecialAltoGiro(cdsItens.FieldByName('CODITE').AsString, cdsPedidos.FieldByName('CODEMP').AsString)
  Else
    blnProdutoEspecialAltoGiro := False;

  if blnProdutoEspecialAltoGiro then
  begin
    fltSaldoFisico := fRetornaSaldoDisponivel(cdsItens.FieldByName('CODITE').AsString,
                                              False,
                                              False,
                                              cdsItens.FieldByName('NUMLOT').AsString,
                                              False,
                                              cdsPedidos.FieldByName('CODEMP').AsString,
                                              '',
                                              False,
                                              False);

    fltSaldoEntFut := TEntregaFutura.New(
                         TParamEF.New()
                           .CodIte(cdsItens.FieldByName('CODITE').AsString)
                           .CodEmp(cdsPedidos.FieldByName('CODEMP').AsString)
                           .Lote(cdsItens.FieldByName('NUMLOT').AsString)
                           .Faturamento(True)
                         ).Total();
  end
  else
  begin
    fltSaldoFisico := fltSaldos;
    fltSaldoEntFut := 0;
  end;

  {****************************************}
  {* RETORNA O SALDO RESERVADO DE PEDIDOS *}
  {****************************************}
  fltFiltro := TSaldoReservado.New(
                 TReservaParametros.New()
                   .EmpresaItem(cdsPedidos.FieldByName('CODEMP').AsString)
                   .CodigoItem(cdsItens.FieldByName('CODITE').AsString)
                   .CodEmpresa(cdsPedidos.FieldByName('CODEMP').AsString)
                   .NumeroLote(cdsItens.FieldByName('NUMLOT').AsString)
                   .NumeroDocumento(cdsPedidos.FieldByName('NUMPED').AsString)
                   .TipoFiltroDocumento(tfdIgnorarDocumento)
                   .TipoReserva(trsPedidoVenda)
                 ).fGetQuantidade();

  {*****************************************}
  {* RETORNA O SALDO RESERVADO DE GARANTIA *}
  {*****************************************}
  fltGarant := TSaldoReservado.New(
                 TReservaParametros.New()
                   .EmpresaItem(cdsPedidos.FieldByName('CODEMP').AsString)
                   .CodigoItem(cdsItens.FieldByName('CODITE').AsString)
                   .CodEmpresa(cdsPedidos.FieldByName('CODEMP').AsString)
                   .NumeroLote(cdsItens.FieldByName('NUMLOT').AsString)
                   .NumeroDocumento(cdsPedidos.FieldByName('NUMPED').AsString)
                   .TipoFiltroDocumento(tfdIgnorarDocumento)
                   .TipoReserva(trsGarantia)
                 ).fGetQuantidade();

  {*****************************************}
  {* RETORNA O SALDO RESERVADO EXTERNO     *}
  {*****************************************}
  fltEstExt := TSaldoReservado.New(
                 TReservaParametros.New()
                   .EmpresaItem(cdsPedidos.FieldByName('CODEMP').AsString)
                   .CodigoItem(cdsItens.FieldByName('CODITE').AsString)
                   .CodEmpresa(cdsPedidos.FieldByName('CODEMP').AsString)
                   .NumeroLote(cdsItens.FieldByName('NUMLOT').AsString)
                   .NumeroDocumento(cdsPedidos.FieldByName('NUMPED').AsString)
                   .TipoFiltroDocumento(tfdIgnorarDocumento)
                   .TipoReserva(trsExterno)
                 ).fGetQuantidade();

  {**************************************************}
  {* RETORNA O SALDO RESERVADO DE ORDEM DE PRODUCAO *}
  {**************************************************}
  fltOrdPro := TSaldoReservado.New(
                 TReservaParametros.New()
                   .EmpresaItem(cdsPedidos.FieldByName('CODEMP').AsString)
                   .CodigoItem(cdsItens.FieldByName('CODITE').AsString)
                   .CodEmpresa(cdsPedidos.FieldByName('CODEMP').AsString)
                   .NumeroLote(cdsItens.FieldByName('NUMLOT').AsString)
                   .NumeroDocumento(cdsPedidos.FieldByName('NUMPED').AsString)
                   .TipoFiltroDocumento(tfdIgnorarDocumento)
                   .TipoReserva(trsOrdemProducao)
                 ).fGetQuantidade();

  If not blnProdutoEspecialAltoGiro then
    fltQuantidade := fltQuantidade + fltFiltro + fltGarant + fltOrdPro + fltEstExt + fltQtdMarcada;

  if fFormataFloat(fltQuantidade, fCfgSis('DECQTD', VarInteger)) > fFormataFloat(fltSaldoFisico, fCfgSis('DECQTD', VarInteger)) then
  begin
    stlTrava.Add(cdsItens.FieldByName('SEQFDO').AsString);

    fltSaldoDisp := (fltSaldos - fltQtdSol - fltFiltro - fltGarant - fltOrdPro - fltEstExt - fltQtdMarcada);

    if (FNumPed <> cdsPedidos.FieldByName('NUMPED').AsString + '-PD-' + cdsPedidos.FieldByName('CODEMP').AsString) then
    begin
      if (not fEmptyStr(FTextLib)) then
        stlTextLib.Add(FTextLib);

      FTextLib := '';
      FNumPed := cdsPedidos.FieldByName('NUMPED').AsString + '-PD-' + cdsPedidos.FieldByName('CODEMP').AsString;
      stlPedLib.Add(FNumPed);

      objLiberacao.objMsgLibera.pAddSeparador(50);
      objLiberacao.objMsgLibera.pAddTextoCaption('Pedido'                        , FNumPed                                               , 29);
      objLiberacao.objMsgLibera.pAddSeparador(50);

      FTextLib := FTextLib + '--------------------------------------------------';
      FTextLib := FTextLib + #13 + 'Pedido.......................: ' + FNumPed;
      FTextLib := FTextLib + #13 + '--------------------------------------------------';
    end;

    objLiberacao.objMsgLibera.pAddTextoCaption('Cód. Item'                     , cdsItens.FieldByName('CODITE').AsString                                          , 29);
    objLiberacao.objMsgLibera.pAddTextoCaption('Descrição'                     , cdsItens.FieldByName('DESITE').AsString                                          , 29);
    objLiberacao.objMsgLibera.pAddTextoCaption('Marca'                         , cdsItens.FieldByName('DESMAR').AsString                                          , 29);
    objLiberacao.objMsgLibera.pAddTextoCaption('Qtd. Solicitada'               , FloatToStrF(fltQtdSol, ffNumber, 12, fCfgSis('DECQTD', varInteger))              , 29);

    FTextLib := FTextLib + #13 + 'Cód. Item....................: ' + cdsItens.FieldByName('CODITE').AsString;
    FTextLib := FTextLib + #13 + 'Descrição....................: ' + cdsItens.FieldByName('DESITE').AsString;
    FTextLib := FTextLib + #13 + 'Marca........................: ' + cdsItens.FieldByName('DESMAR').AsString;
    FTextLib := FTextLib + #13 + 'Qtd. Solicitada..............: ' + FloatToStrF(fltQtdSol, ffNumber, 12, fCfgSis('DECQTD', varInteger));

    If blnProdutoEspecialAltoGiro Then
    Begin
      objLiberacao.objMsgLibera.pAddTextoCaption('Saldo Físico'                , FloatToStrF(fltSaldoFisico, ffNumber, 12, fCfgSis('DECQTD', varInteger))         , 29);
      objLiberacao.objMsgLibera.pAddTextoCaption('Saldo Entrega Futura'        , FloatToStrF(fltSaldoEntFut, ffNumber, 12, fCfgSis('DECQTD', varInteger))         , 29);

      FTextLib := FTextLib + #13 + 'Saldo Físico.................: ' + FloatToStrF(fltSaldoFisico, ffNumber, 12, fCfgSis('DECQTD', varInteger));
      FTextLib := FTextLib + #13 + 'Saldo Entrega Futura.........: ' + FloatToStrF(fltSaldoEntFut, ffNumber, 12, fCfgSis('DECQTD', varInteger));
    End;

    objLiberacao.objMsgLibera.pAddTextoCaption('Saldo Atual'                   , FloatToStrF(fltSaldos, ffNumber, 12, fCfgSis('DECQTD', varInteger))              , 29);
    FTextLib := FTextLib + #13 + 'Saldo Atual..................: ' + FloatToStrF(fltSaldos, ffNumber, 12, fCfgSis('DECQTD', varInteger));

    if fCfgSis('ESTEXT', VarBoolean) then
    begin
      objLiberacao.objMsgLibera.pAddTextoCaption('Saldo Reserv. Estoque Externo', FloatToStrF(fltEstExt, ffNumber, 12, fCfgSis('DECQTD', varInteger))              , 29);
      FTextLib := FTextLib + #13 + 'Saldo Reserv. Estoque Externo: ' + FloatToStrF(fltEstExt, ffNumber, 12, fCfgSis('DECQTD', varInteger));
    end;

    objLiberacao.objMsgLibera.pAddTextoCaption('Saldo Reserv. Pedido de Venda' , FloatToStrF(fltFiltro, ffNumber, 12, fCfgSis('DECQTD', varInteger))              , 29);
    objLiberacao.objMsgLibera.pAddTextoCaption('Saldo Reserv. Garantia'        , FloatToStrF(fltGarant, ffNumber, 12, fCfgSis('DECQTD', varInteger))              , 29);
    objLiberacao.objMsgLibera.pAddTextoCaption('Saldo Reserv. Ord. Produção'   , FloatToStrF(fltOrdPro, ffNumber, 12, fCfgSis('DECQTD', varInteger))              , 29);
    objLiberacao.objMsgLibera.pAddTextoCaption('Saldo Disponível'              , FloatToStrF(fltSaldoDisp, ffNumber, 12, fCfgSis('DECQTD', varInteger))           , 29);
    objLiberacao.objMsgLibera.pAddTextoCaption('Empresa'                       , cdsPedidos.FieldByName('CODEMP').AsString +' - '+Copy(fRetNomeEmpresaSelec(cdsPedidos.FieldByName('CODEMP').AsString),1,50)                      , 29);
    objLiberacao.objMsgLibera.pAddQuebra();

    FTextLib := FTextLib + #13 + 'Saldo Reserv. Pedido de Venda: ' + FloatToStrF(fltFiltro, ffNumber, 12, fCfgSis('DECQTD', varInteger));
    FTextLib := FTextLib + #13 + 'Saldo Reserv. Garantia.......: ' + FloatToStrF(fltGarant, ffNumber, 12, fCfgSis('DECQTD', varInteger));
    FTextLib := FTextLib + #13 + 'Saldo Reserv. Ord. Produção..: ' + FloatToStrF(fltOrdPro, ffNumber, 12, fCfgSis('DECQTD', varInteger));
    FTextLib := FTextLib + #13 + 'Saldo Disponível.............: ' + FloatToStrF(fltSaldoDisp, ffNumber, 12, fCfgSis('DECQTD', varInteger));
    FTextLib := FTextLib + #13 + 'Empresa......................: ' + cdsPedidos.FieldByName('CODEMP').AsString +' - '+Copy(fRetNomeEmpresaSelec(cdsPedidos.FieldByName('CODEMP').AsString),1,50);
    FTextLib := FTextLib + #13;
  end;
end;

end.
