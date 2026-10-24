unit untFatMotEntregas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, untMotEntregas, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, StrUtils, untConstantes,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, untGravando,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, cxCheckBox, Uni,
  Datasnap.DBClient, UniClientDataSet, untTLock;

type
  TfrmFatMotEntregas = class(TfrmPaiSimples)
    pnlGeral: TPanel;
    pnlEntregadores: TPanel;
    pnlFundo: TPanel;
    pnlAcoes: TPanel;
    pnlDocumentos: TPanel;
    pnlLegenda: TPanel;
    cxgDocumentosDBTableViewCitel: TcxGridDBTableViewCitel;
    cxgDocumentosLevel: TcxGridLevel;
    cxgDocumentos: TcxGridCitel;
    cxgDocumentosMARDES: TcxGridDBColumn;
    cxgDocumentosDOCUMENTO: TcxGridDBColumn;
    cxgDocumentosCLIENTE: TcxGridDBColumn;
    cxgDocumentosVENDEDOR: TcxGridDBColumn;
    cxgDocumentosVLRCON: TcxGridDBColumn;
    cxgDocumentosDATAHORADOC: TcxGridDBColumn;
    cxgDocumentosENDCON: TcxGridDBColumn;
    cxgDocumentosDESREG: TcxGridDBColumn;
    cxgDocumentosSEPARACAO: TcxGridDBColumn;
    cxgDocumentosENTREGADOR: TcxGridDBColumn;
    cxgDocumentosSAIDA: TcxGridDBColumn;
    dtsDocumentos: TDataSource;
    cxgMotoristasDBTableViewCitel: TcxGridDBTableViewCitel;
    cxgMotoristasLevel1: TcxGridLevel;
    cxgMotoristas: TcxGridCitel;
    cxgMotoristasMARDES: TcxGridDBColumn;
    cxgMotoristasMOTORISTA: TcxGridDBColumn;
    dtsMotoristas: TDataSource;
    cxgMotoristasSITUAC: TcxGridDBColumn;
    btnEntrada: TBitBtnLocked;
    btnSaidaAlmoco: TBitBtnLocked;
    btnRetornoAlmoco: TBitBtnLocked;
    btnSaida: TBitBtnLocked;
    grbLegenda: TGroupBox;
    shpIndisponivel: TShape;
    shpAlmoco: TShape;
    shpEntregando: TShape;
    shpDisponivel: TShape;
    lblIndisponível: TLabel;
    lblAlmoco: TLabel;
    lblEntregando: TLabel;
    lblDisponivel: TLabel;
    cxgDocumentosFANSOB: TcxGridDBColumn;
    cxgDocumentosCONPAG: TcxGridDBColumn;
    cxgDocumentosBAICON: TcxGridDBColumn;
    cxgDocumentosTELEFONES: TcxGridDBColumn;
    btnRegPartida: TBitBtnLocked;
    btnRegChegada: TBitBtnLocked;
    btnRemoveDocs: TBitBtnLocked;
    btnDetEntrega: TBitBtnLocked;
    btnConEntrega: TBitBtnLocked;
    btnAltEntrega: TBitBtnLocked;
    btnAtualizar: TBitBtnLocked;
    btnAdicionarDocMotorista: TBitBtnLocked;
    pnlDadosDoc: TPanel;
    pgcDadosDoc: TPageControl;
    tsObservacao: TTabSheet;
    grbObsEnt: TGroupBox;
    memObsEnt: TMemo;
    grbObs: TGroupBox;
    memObs: TMemo;
    tsProdutos: TTabSheet;
    cxgItens: TcxGrid;
    cxgItensDBTableView: TcxGridDBTableView;
    cxgItensCODITE: TcxGridDBColumn;
    cxgItensDESCRI: TcxGridDBColumn;
    cxgItensUNIDAD: TcxGridDBColumn;
    cxgItensQTDITE: TcxGridDBColumn;
    cxgItensUNITAR: TcxGridDBColumn;
    cxgItensTOTITE: TcxGridDBColumn;
    cxgItensLevel: TcxGridLevel;
    dtsItensDoc: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgMotoristasMARDESPropertiesChange(Sender: TObject);
    procedure cxgMotoristasDBTableViewCitelCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnEntradaClick(Sender: TObject);
    procedure btnSaidaAlmocoClick(Sender: TObject);
    procedure btnRetornoAlmocoClick(Sender: TObject);
    procedure btnSaidaClick(Sender: TObject);
    procedure btnRegPartidaClick(Sender: TObject);
    procedure btnRegChegadaClick(Sender: TObject);
    procedure btnRemoveDocsClick(Sender: TObject);
    procedure btnDetEntregaClick(Sender: TObject);
    procedure btnConEntregaClick(Sender: TObject);
    procedure btnAltEntregaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgDocumentosMARDESPropertiesChange(Sender: TObject);
    procedure cxgDocumentosDBTableViewCitelFocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnAdicionarDocMotoristaClick(Sender: TObject);
  private
    FEntregas: TEntregas;
    FTipoDoc: TDocEntrega;
    FCodMot: String;
    FTotDocMarcados: Integer;
    FSituacaoMotoristaSelecionado: TSituacaoMotorista;
    FClientMotoristaCriado: Boolean;
    FObjLock: TLock;
    FQryItens: TUniQuery;
    procedure pMarcaMotorista;
    procedure pCarregaDocumentosEntrega;
    procedure pHabilitaBotoesSituacao(ASituacao: String = '');
    procedure pAlteraSituacaoMotorista(ASituacao: String);
    procedure pCarregaTelaInicial;
    procedure pRegistraPartida;
    procedure pRegistraChegada;
    procedure pRemoverDocumentos;
    procedure pDetalhesEntrega;
    procedure pAlterarTipoEntrega;
    procedure pConsultaDocumentosEntrega;
    procedure pLiberaTravaMotorista;
    procedure pLiberaTravaDocumentos;
    function fDocumentoPosicionado: Boolean;
    procedure pSetaSQLItensDocumento;
    { Private declarations }
  public
    { Public declarations }
    FEspeciesPermitidas: String;
  end;


implementation

uses
  untFuncoesSimples, untFatConsultaItemEntrega, untFatRomManutEntrega,
  untFatConsultaDocumentoEntrega;

{$R *.dfm}

procedure TfrmFatMotEntregas.pAlterarTipoEntrega;
var
  frmFatRomManutEntrega: TfrmFatRomManutEntrega;
begin
  if not fDocumentoPosicionado then
    Exit;

  pCriarFormularios(TfrmFatRomManutEntrega, frmFatRomManutEntrega);

  try
    frmFatRomManutEntrega.edtNumDoc.Enabled := False;
    frmFatRomManutEntrega.edtNumDoc.Text := FEntregas.FQryDocumentos.FieldByName('GER_NUMDOC').AsString;
    frmFatRomManutEntrega.edtEspDoc.Text := FEntregas.FQryDocumentos.FieldByName('GER_ESPDOC').AsString;
    frmFatRomManutEntrega.edtCodEmp.Text := FEntregas.FQryDocumentos.FieldByName('GER_CODEMP').AsString;
    frmFatRomManutEntrega.blnChamouPeloManutencaoDeEntregas := True;
    frmFatRomManutEntrega.ShowModal;
    pLiberaTravaMotorista;
    FClientMotoristaCriado := True;
    TfrmGravando.fExecutarModal(pCarregaTelaInicial, 'Aguarde, Carregando documentos ...', '');
  finally
    pFreeAndNil(frmFatRomManutEntrega);
    FClientMotoristaCriado := False;
  end;
end;

procedure TfrmFatMotEntregas.pAlteraSituacaoMotorista(ASituacao: String);
var
  LCdsTemp: TUniClientDataSet;
  LCodMot: String;
begin
  LCdsTemp := TUniClientDataSet.Create(Nil);

  try
    pCloneDataSet(LCdsTemp, FEntregas.FCdsMotoristas);
    LCdsTemp.Filtered := False;
    LCdsTemp.Filter := ' MARDES = 1 ';
    LCdsTemp.Filtered := True;

    LCodMot := LCdsTemp.FieldByName('MOT_CODMOT').AsString;

    FEntregas.pAlteraSituacaoMotorista(LCodMot, LCdsTemp.FieldByName('MOT_SITUAC').AsString, ASituacao);
    FEntregas.FCdsMotoristas.First;
    pHabilitaBotoesSituacao(ASituacao);

    FSituacaoMotoristaSelecionado := MotNenhum;

    case AnsiIndexStr(ASituacao, ['I','A','E','D']) of
      0: begin
           FSituacaoMotoristaSelecionado := MotIndisponivel;
           FEntregas.FQryDocumentos.Close;
         end;

      1: begin
           FSituacaoMotoristaSelecionado := MotAlmoco;
           FEntregas.FQryDocumentos.Close;
         end;

      2: begin
           FSituacaoMotoristaSelecionado := MotEntregando;
           FTipoDoc := DocVinculado;
           FCodMot := LCodMot;
           TfrmGravando.fExecutarModal(pCarregaDocumentosEntrega, 'Aguarde, Carregando documentos ...', '');
         end;

      3: begin
           FSituacaoMotoristaSelecionado := MotDisponivel;
           FTipoDoc := DocNaoVinculado;
           TfrmGravando.fExecutarModal(pCarregaDocumentosEntrega, 'Aguarde, Carregando documentos ...', '');
         end;
    end;
  finally
    FTipoDoc := DocTodos;
    FCodMot := EmptyStr;
    FreeAndNil(LCdsTemp);
  end;
end;

procedure TfrmFatMotEntregas.pCarregaDocumentosEntrega;
begin
  pLiberaTravaDocumentos;
  FEntregas.pCarregaDocumentos(FTipoDoc, FCodMot, FEspeciesPermitidas);
end;

procedure TfrmFatMotEntregas.pCarregaTelaInicial;
begin
  FTipoDoc := DocTodos;
  FCodMot := EmptyStr;
  FTotDocMarcados := 0;
  FSituacaoMotoristaSelecionado := MotNenhum;

  pCarregaDocumentosEntrega;
  FEntregas.pCarregaMotoristas(FClientMotoristaCriado);
end;

procedure TfrmFatMotEntregas.pConsultaDocumentosEntrega;
var
  frmFatConsultaDoccumentoEntrega: TfrmFatConsultaDocumentoEntrega;
begin
  pCriarFormularios(TfrmFatConsultaDocumentoEntrega, frmFatConsultaDoccumentoEntrega);

  try
    frmFatConsultaDoccumentoEntrega.ShowModal;
  finally
    pFreeAndNil(frmFatConsultaDoccumentoEntrega);
  end;
end;

procedure TfrmFatMotEntregas.pDetalhesEntrega;
var
  frmFatConsultaItemEntrega: TfrmFatConsultaItemEntrega;
begin
  if not fDocumentoPosicionado then
    Exit;

  pCriarFormularios(TfrmFatConsultaItemEntrega, frmFatConsultaItemEntrega);

  try
    frmFatConsultaItemEntrega.FAutInc := FEntregas.FQryDocumentos.FieldByName('AUTOINCREM').AsString;
    frmFatConsultaItemEntrega.ShowModal;
  finally
    pFreeAndNil(frmFatConsultaItemEntrega);
  end;
end;

procedure TfrmFatMotEntregas.pHabilitaBotoesSituacao(ASituacao: String = '');
begin
  case AnsiIndexStr(ASituacao, ['I','A','E','D']) of
    0:begin
        btnEntrada.Enabled := True;
        btnSaidaAlmoco.Enabled := False;
        btnRetornoAlmoco.Enabled := False;
        btnSaida.Enabled := False;
      end;

    1:begin
        btnEntrada.Enabled := False;
        btnSaidaAlmoco.Enabled := False;
        btnRetornoAlmoco.Enabled := True;
        btnSaida.Enabled := False;
      end;

    2:begin
        btnEntrada.Enabled := False;
        btnSaidaAlmoco.Enabled := False;
        btnRetornoAlmoco.Enabled := False;
        btnSaida.Enabled := False;
      end;

    3:begin
        btnEntrada.Enabled := False;
        btnSaidaAlmoco.Enabled := True;
        btnRetornoAlmoco.Enabled := False;
        btnSaida.Enabled := True;
      end;

  else
    begin
      btnEntrada.Enabled := False;
      btnSaidaAlmoco.Enabled := False;
      btnRetornoAlmoco.Enabled := False;
      btnSaida.Enabled := False;
    end;
  end;
end;

procedure TfrmFatMotEntregas.pLiberaTravaDocumentos;
var
  LChave: String;
begin
  try
    FEntregas.FQryDocumentos.Filtered := False;
    FEntregas.FQryDocumentos.Filter := ' MARDES = 1 ';
    FEntregas.FQryDocumentos.Filtered := True;

    if FEntregas.FQryDocumentos.RecordCount <= 0 then
      Exit;

    FEntregas.FQryDocumentos.First;

    while not FEntregas.FQryDocumentos.Eof do
    begin
      LChave := 'DOCUMENTO_ENTREGA_' + FEntregas.FQryDocumentos.FieldByName('AUTOINCREM').AsString;;
      FObjLock.fLock_Unlock(LChave, False);
      FEntregas.FQryDocumentos.Next;
    end;
  finally
    FEntregas.FQryDocumentos.Filtered := False;
    FEntregas.FQryDocumentos.Filter := EmptyStr;
  end;
end;

procedure TfrmFatMotEntregas.pLiberaTravaMotorista;
var
  LCdsMotTemp: TUniClientDataSet;
  LChave: String;
begin
  LCdsMotTemp := TUniClientDataSet.Create(Nil);

  try
    pCloneDataSet(LCdsMotTemp, FEntregas.FCdsMotoristas);

    LCdsMotTemp.Filtered := False;
    LCdsMotTemp.Filter := ' MARDES = 1 ';
    LCdsMotTemp.Filtered := True;

    if LCdsMotTemp.RecordCount <= 0 then
      Exit;

    LChave := 'MOTORISTA_ENTREGA_' + LCdsMotTemp.FieldByName('MOT_CODMOT').AsString;
    FObjLock.fLock_Unlock(LChave, False);
  finally
    FreeAndNil(LCdsMotTemp);
  end;
end;

procedure TfrmFatMotEntregas.pMarcaMotorista;
var
  LPosicao: Integer;
  LCodMot: String;
  LMardes: Boolean;
  LSituacao: String;
  LChave: String;
begin
  LPosicao := FEntregas.FCdsMotoristas.RecNo;

  try
    LCodMot := FEntregas.FCdsMotoristas.FieldByName('MOT_CODMOT').AsString;
    LMardes := IIF(FEntregas.FCdsMotoristas.FieldByName('MARDES').AsInteger = 0, False, True);
    LSituacao := FEntregas.FCdsMotoristas.FieldByName('MOT_SITUAC').AsString;

    LChave := 'MOTORISTA_ENTREGA_' + FEntregas.FCdsMotoristas.FieldByName('MOT_CODMOT').AsString;

    if (LMardes) and (not FObjLock.fLock_Unlock(LChave, True, False)) Then
    begin
      fMensagem('ATENÇÃO','Motorista já selecionado em uma outra estação!',['&OK']);
      FEntregas.FCdsMotoristas.Edit;
      FEntregas.FCdsMotoristas.FieldByName('MARDES').AsInteger := 0;
      FEntregas.FCdsMotoristas.Post;
      Exit;
    end
    else if (not LMardes) then
    begin
      LChave := 'MOTORISTA_ENTREGA_' + FEntregas.FCdsMotoristas.FieldByName('MOT_CODMOT').AsString;
      FObjLock.fLock_Unlock(LChave, False);
    end;

    FTotDocMarcados := 0;
    btnRegPartida.Enabled := False;
    btnRegChegada.Enabled := False;
    btnRemoveDocs.Enabled := False;
    btnAdicionarDocMotorista.Enabled := False;

    FEntregas.FCdsMotoristas.First;

    while not FEntregas.FCdsMotoristas.Eof do
    begin
      if FEntregas.FCdsMotoristas.RecNo <> LPosicao then
      begin
        FEntregas.FCdsMotoristas.Edit;

        if FEntregas.FCdsMotoristas.FieldByName('MARDES').AsInteger = 1 then
        begin
          LChave := 'MOTORISTA_ENTREGA_' + FEntregas.FCdsMotoristas.FieldByName('MOT_CODMOT').AsString;
          FObjLock.fLock_Unlock(LChave, False);
        end;

        FEntregas.FCdsMotoristas.FieldByName('MARDES').AsInteger := 0;
        FEntregas.FCdsMotoristas.Post;
      end;

      FEntregas.FCdsMotoristas.Next;
    end;

    if LMardes then
    begin
      case AnsiIndexStr(LSituacao, ['I','A','E','D']) of
        0: begin
             FSituacaoMotoristaSelecionado := MotIndisponivel;
             FEntregas.FQryDocumentos.Close;
           end;

        1: begin
             FSituacaoMotoristaSelecionado := MotAlmoco;
             FEntregas.FQryDocumentos.Close;
           end;

        2: begin
             FSituacaoMotoristaSelecionado := MotEntregando;
             FTipoDoc := DocVinculado;
             FCodMot := LCodMot;
             pCarregaDocumentosEntrega;
           end;

        3: begin
             FSituacaoMotoristaSelecionado := MotDisponivel;
             FTipoDoc := DocNaoVinculado;
             pCarregaDocumentosEntrega;
           end;
      end;
    end
    else
    begin
      FSituacaoMotoristaSelecionado := MotNenhum;
      LSituacao := EmptyStr;
      pCarregaDocumentosEntrega;
    end;

    pHabilitaBotoesSituacao(LSituacao);
  finally
    FTipoDoc := DocTodos;
    FCodMot := EmptyStr;
    FEntregas.FCdsMotoristas.RecNo := LPosicao;
  end;
end;

procedure TfrmFatMotEntregas.pRegistraChegada;
var
  LCdsMotTemp: TUniClientDataSet;
  LDocumentos: String;
  LEntregas: String;
  LCodMot: String;
  LBaixouTodosDocumentos: Boolean;
begin
  LCdsMotTemp := TUniClientDataSet.Create(Nil);
  FEntregas.FQryDocumentos.DisableControls;

  try
    LDocumentos := EmptyStr;
    LEntregas := EmptyStr;
    LBaixouTodosDocumentos := False;
    pCloneDataSet(LCdsMotTemp, FEntregas.FCdsMotoristas);

    FEntregas.FQryDocumentos.Filtered := False;
    FEntregas.FQryDocumentos.Filter := ' MARDES = 1 ';
    FEntregas.FQryDocumentos.Filtered := True;
    FEntregas.FQryDocumentos.First;

    LCdsMotTemp.Filtered := False;
    LCdsMotTemp.Filter := ' MARDES = 1 ';
    LCdsMotTemp.Filtered := True;

    LCodMot := LCdsMotTemp.FieldByName('MOT_CODMOT').AsString;

    while not FEntregas.FQryDocumentos.Eof do
    begin
      pIncrementaListaStr(FEntregas.FQryDocumentos.FieldByName('INCREMCOMEND').AsString, LDocumentos, True);
      pIncrementaListaStr(FEntregas.FQryDocumentos.FieldByName('END_SEQENG').AsString, LEntregas, True);
      FEntregas.FQryDocumentos.Next;
    end;

    if FEntregas.fRegistraChegada(LDocumentos, LEntregas, LCodMot, LBaixouTodosDocumentos) then
    begin
      if LBaixouTodosDocumentos then
        pAlteraSituacaoMotorista('D');

      btnRegChegada.Enabled := False;
      FTotDocMarcados := 0;
      fMensagem('','Chegada registrada com sucesso!',['&OK']);

      if not LBaixouTodosDocumentos then
      begin
        FSituacaoMotoristaSelecionado := MotEntregando;
        FTipoDoc := DocVinculado;
        FCodMot := LCodMot;
        TfrmGravando.fExecutarModal(pCarregaDocumentosEntrega, 'Aguarde, Carregando documentos ...', '');
      end;
    end;

  finally
    FEntregas.FQryDocumentos.Filtered := False;
    FEntregas.FQryDocumentos.Filter := EmptyStr;
    FEntregas.FQryDocumentos.First;
    FEntregas.FQryDocumentos.EnableControls;
    FreeAndNil(LCdsMotTemp);
  end;
end;

procedure TfrmFatMotEntregas.pRegistraPartida;
var
  LCdsMotTemp: TUniClientDataSet;
  LDocumentos: String;
  LCodMot: String;
begin
  LCdsMotTemp := TUniClientDataSet.Create(Nil);
  FEntregas.FQryDocumentos.DisableControls;

  try
    LDocumentos := EmptyStr;
    pCloneDataSet(LCdsMotTemp, FEntregas.FCdsMotoristas);

    FEntregas.FQryDocumentos.Filtered := False;
    FEntregas.FQryDocumentos.Filter := ' MARDES = 1 ';
    FEntregas.FQryDocumentos.Filtered := True;
    FEntregas.FQryDocumentos.First;

    LCdsMotTemp.Filtered := False;
    LCdsMotTemp.Filter := ' MARDES = 1 ';
    LCdsMotTemp.Filtered := True;

    LCodMot := LCdsMotTemp.FieldByName('MOT_CODMOT').AsString;

    while not FEntregas.FQryDocumentos.Eof do
    begin
      pIncrementaListaStr(FEntregas.FQryDocumentos.FieldByName('AUTOINCREM').AsString, LDocumentos, True);
      FEntregas.FQryDocumentos.Next;
    end;

    if FEntregas.fRegistraPartida(LDocumentos, LCodMot) then
    begin
      pAlteraSituacaoMotorista('E');
      btnRegPartida.Enabled := False;
      FTotDocMarcados := 0;
      fMensagem('','Partida registrada com sucesso!',['&OK']);
    end;

  finally
    FEntregas.FQryDocumentos.Filtered := False;
    FEntregas.FQryDocumentos.Filter := EmptyStr;
    FEntregas.FQryDocumentos.First;
    FEntregas.FQryDocumentos.EnableControls;
    FreeAndNil(LCdsMotTemp);
  end;
end;

procedure TfrmFatMotEntregas.pRemoverDocumentos;
var
  LCdsMotTemp: TUniClientDataSet;
  LDocumentos: String;
  LCodMot: String;
  LEntregas: TStringList;
  LRemoveuTodosDocumentos: Boolean;
begin
  LCdsMotTemp := TUniClientDataSet.Create(Nil);
  LEntregas := TStringList.Create;
  FEntregas.FQryDocumentos.DisableControls;

  try
    LDocumentos := EmptyStr;
    LEntregas.Clear;
    LRemoveuTodosDocumentos := False;
    pCloneDataSet(LCdsMotTemp, FEntregas.FCdsMotoristas);

    FEntregas.FQryDocumentos.Filtered := False;
    FEntregas.FQryDocumentos.Filter := ' MARDES = 1 ';
    FEntregas.FQryDocumentos.Filtered := True;
    FEntregas.FQryDocumentos.First;

    LCdsMotTemp.Filtered := False;
    LCdsMotTemp.Filter := ' MARDES = 1 ';
    LCdsMotTemp.Filtered := True;

    LCodMot := LCdsMotTemp.FieldByName('MOT_CODMOT').AsString;

    while not FEntregas.FQryDocumentos.Eof do
    begin
      pIncrementaListaStr(FEntregas.FQryDocumentos.FieldByName('INCREMCOMEND').AsString, LDocumentos, True);
      LEntregas.Add(FEntregas.FQryDocumentos.FieldByName('END_SEQENG').AsString);
      FEntregas.FQryDocumentos.Next;
    end;

    if FEntregas.fRemoveDocumentos(LDocumentos, LCodMot, LEntregas, LRemoveuTodosDocumentos) then
    begin
      if LRemoveuTodosDocumentos then
        pAlteraSituacaoMotorista('D');

      btnRemoveDocs.Enabled := False;
      FTotDocMarcados := 0;
      fMensagem('','Documento(s) removido(s) com sucesso!',['&OK']);

      if not LRemoveuTodosDocumentos then
      begin
        FSituacaoMotoristaSelecionado := MotEntregando;
        FTipoDoc := DocVinculado;
        FCodMot := LCodMot;
        TfrmGravando.fExecutarModal(pCarregaDocumentosEntrega, 'Aguarde, Carregando documentos ...', '');
      end;
    end;

  finally
    FEntregas.FQryDocumentos.Filtered := False;
    FEntregas.FQryDocumentos.Filter := EmptyStr;
    FEntregas.FQryDocumentos.First;
    FEntregas.FQryDocumentos.EnableControls;
    FreeAndNil(LCdsMotTemp);
    FreeAndNil(LEntregas);
  end;
end;

procedure TfrmFatMotEntregas.pSetaSQLItensDocumento;
begin
  FQryItens.Close;
  FQryItens.SQL.Clear;

  FQryItens.SQL.Add('SELECT DET_CODITE AS CODITE, DET_DESCRI AS DESCRI, DET_TOTITE AS TOTITE,');
  FQryItens.SQL.Add('       DET_UNIDAD AS UNIDAD, DET_UNITAR AS UNITAR, DET_QTDITE AS QTDITE ');
  FQryItens.SQL.Add('FROM MOVDET');
  FQryItens.SQL.Add('WHERE DET_SEQGER = :SEQGER');
end;

procedure TfrmFatMotEntregas.btnAtualizarClick(Sender: TObject);
begin
  inherited;
  try
    pLiberaTravaMotorista;
    FClientMotoristaCriado := True;
    TfrmGravando.fExecutarModal(pCarregaTelaInicial, 'Aguarde, Carregando documentos ...', '');
  finally
    FClientMotoristaCriado := False;
  end;
end;

procedure TfrmFatMotEntregas.btnAdicionarDocMotoristaClick(Sender: TObject);
  Var
    cdsMotTemp: TUniClientDataSet;
    arrOpcoes: Array Of String;
    strCodMot: String;
    strDocsOX: String;
    strDocumentos: String;
    strMsgDocIndisponivel: String;
begin
  inherited;

  If Not btnAdicionarDocMotorista.Enabled Then
    Exit;

  strDocumentos := EmptyStr;
  strDocsOX := '';
  strMsgDocIndisponivel := '';
  cdsMotTemp := TUniClientDataSet.Create(Nil);
  FEntregas.FQryDocumentos.DisableControls;
  Try
    pCloneDataSet(cdsMotTemp, FEntregas.FCdsMotoristas);

    cdsMotTemp.Filtered := False;
    cdsMotTemp.Filter   := ' MOT_SITUAC = ' + QuotedStr('E');
    cdsMotTemp.Filtered := True;
    cdsMotTemp.First;

    FEntregas.FQryDocumentos.Filtered := False;
    FEntregas.FQryDocumentos.Filter   := ' MARDES = 1 ';
    FEntregas.FQryDocumentos.Filtered := True;
    FEntregas.FQryDocumentos.First;

    While Not FEntregas.FQryDocumentos.Eof Do
    Begin
      If Not fEmptyStr(FEntregas.FQryDocumentos.FieldByName('ENTREGADOR').AsString) Then
      Begin
        pIncrementaListaStr(sLineBreak + FEntregas.FQryDocumentos.FieldByName('DOCUMENTO').AsString + ' - ' +
                            FEntregas.FQryDocumentos.FieldByName('ENTREGADOR').AsString,
                            strMsgDocIndisponivel,
                            True);
      End;

      FEntregas.FQryDocumentos.Next;
    End;

    If Not fEmptyStr(strMsgDocIndisponivel) Then
    Begin
      fMensagem('ATENÇÃO', 'Os documentos selecionados já estão vinculados a um ENTREGADOR. Desmarque os documentos abaixo para prosseguir: ' + strMsgDocIndisponivel, ['&OK'], 1, False, 1, 0, False, 0, False, False, False, 300);

      Exit;
    End;

    SetLength(arrOpcoes, cdsMotTemp.RecordCount + 1);
    While Not cdsMotTemp.Eof Do
    Begin
      arrOpcoes[Pred(cdsMotTemp.recNo)] := cdsMotTemp.FieldByName('MOTORISTA').AsString;

      cdsMotTemp.Next;
    End;
    arrOpcoes[Pred(cdsMotTemp.recNo + 1)] := 'Sair';

    strCodMot := LeftStr(arrOpcoes[Pred(fGetMenu('Selecione o Motorista:', arrOpcoes, 1, False, True))], 5);
    If strCodMot = 'Sair' Then
      Exit;

    FEntregas.FQryDocumentos.First;
    While Not FEntregas.FQryDocumentos.Eof Do
    Begin
      pIncrementaListaStr(FEntregas.FQryDocumentos.FieldByName('AUTOINCREM').AsString, strDocumentos, True);

      FEntregas.FQryDocumentos.Next;
    End;

    If FEntregas.fRegistraPartida(strDocumentos, strCodMot) Then
      fMensagem('', 'Documentos adicionados com sucesso!', ['&OK']);
  Finally
    FTotDocMarcados := 0;
    FEntregas.FQryDocumentos.Filtered := False;
    FEntregas.FQryDocumentos.Filter   := EmptyStr;
    FEntregas.FQryDocumentos.First;
    TfrmGravando.fExecutarModal(pCarregaDocumentosEntrega, 'Aguarde, Carregando documentos ...', '');
    btnAdicionarDocMotorista.Enabled := False;
    FEntregas.FQryDocumentos.EnableControls;
    FreeAndNil(cdsMotTemp);
  End;
end;

procedure TfrmFatMotEntregas.btnAltEntregaClick(Sender: TObject);
begin
  inherited;
  if not btnAltEntrega.Enabled then
    Exit;

  pAlterarTipoEntrega;
end;

procedure TfrmFatMotEntregas.btnConEntregaClick(Sender: TObject);
begin
  inherited;
  pConsultaDocumentosEntrega;
end;

procedure TfrmFatMotEntregas.btnDetEntregaClick(Sender: TObject);
begin
  inherited;
  if not btnDetEntrega.Enabled then
    Exit;

  pDetalhesEntrega;
end;

procedure TfrmFatMotEntregas.btnEntradaClick(Sender: TObject);
begin
  inherited;
  pAlteraSituacaoMotorista('D');
end;

procedure TfrmFatMotEntregas.btnRegChegadaClick(Sender: TObject);
begin
  inherited;
  if not btnRegChegada.Enabled then
    Exit;

  pRegistraChegada;
end;

procedure TfrmFatMotEntregas.btnRegPartidaClick(Sender: TObject);
begin
  inherited;

  if not btnRegPartida.Enabled then
    Exit;

  pRegistraPartida;
end;

procedure TfrmFatMotEntregas.btnRemoveDocsClick(Sender: TObject);
begin
  inherited;

  if not btnRemoveDocs.Enabled then
    Exit;

  pRemoverDocumentos;
end;

procedure TfrmFatMotEntregas.btnRetornoAlmocoClick(Sender: TObject);
begin
  inherited;
  pAlteraSituacaoMotorista('D');
end;

procedure TfrmFatMotEntregas.btnSaidaAlmocoClick(Sender: TObject);
begin
  inherited;
  pAlteraSituacaoMotorista('A');
end;

procedure TfrmFatMotEntregas.btnSaidaClick(Sender: TObject);
begin
  inherited;
  pAlteraSituacaoMotorista('I');
end;

procedure TfrmFatMotEntregas.cxgDocumentosDBTableViewCitelFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  inherited;

  btnDetEntrega.Enabled := False;
  btnAltEntrega.Enabled := False;

  if not fDocumentoPosicionado then
    Exit;

  memObs.Lines.Clear;
  memObs.Lines.Add(FEntregas.FQryDocumentos.FieldByName('GER_MENEXP').AsString);
  memObs.Lines.Add(FEntregas.FQryDocumentos.FieldByName('GER_MENEX2').AsString);
  memObs.Lines.Add(FEntregas.FQryDocumentos.FieldByName('GER_MENEX3').AsString);
  memObs.Lines.Add(FEntregas.FQryDocumentos.FieldByName('GER_MENEX4').AsString);

  memObsEnt.Lines.Clear;
  memObsEnt.Lines.Add(FEntregas.FQryDocumentos.FieldByName('ENG_OBSERV').AsString);

  FQryItens.Close;
  FQryItens.ParamByName('SEQGER').AsString := FEntregas.FQryDocumentos.FieldByName('AUTOINCREM').AsString;
  FQryItens.Open;
  TFloatField(FQryItens.FieldByName('QTDITE')).DisplayFormat := '#0.0000';
  TFloatField(FQryItens.FieldByName('TOTITE')).DisplayFormat := '#,##0.00';
  TFloatField(FQryItens.FieldByName('UNITAR')).DisplayFormat := '#,##0.00';

  btnDetEntrega.Enabled := True;
  btnAltEntrega.Enabled := Not FEntregas.fDocumentoTemEntregaVinculada(FEntregas.FQryDocumentos.FieldByName('AUTOINCREM').AsString);
end;

procedure TfrmFatMotEntregas.cxgDocumentosMARDESPropertiesChange(
  Sender: TObject);
var
  LChave: String;
begin
  inherited;

  LChave := 'DOCUMENTO_ENTREGA_' + FEntregas.FQryDocumentos.FieldByName('AUTOINCREM').AsString;

  if FEntregas.FQryDocumentos.FieldByName('MARDES').AsInteger = 1 then
  begin
    Inc(FTotDocMarcados);

    if not FObjLock.fLock_Unlock(LChave, True, False) then
    begin
      fMensagem('ATENÇÃO','Documento já selecionado em uma outra estação!',['&OK']);
      FEntregas.FQryDocumentos.Edit;
      FEntregas.FQryDocumentos.FieldByName('MARDES').AsInteger := 0;
      FEntregas.FQryDocumentos.Post;
      Exit;
    end;
  end
  else
  begin
    if FTotDocMarcados > 0 then
      Dec(FTotDocMarcados)
    else
      FTotDocMarcados := 0;

    FObjLock.fLock_Unlock(LChave, False);
  end;

  if FTotDocMarcados > 0 then
  begin
    case FSituacaoMotoristaSelecionado of
      MotDisponivel: btnRegPartida.Enabled := True;

      MotEntregando: begin
                       btnRegChegada.Enabled := True;
                       btnRemoveDocs.Enabled := True;
                     end;

      MotNenhum    : btnAdicionarDocMotorista.Enabled := (Not fEmptyStr(fCampoTabela('MOT_CODMOT', 'CADMOT', ['MOT_SITUAC'], ['E']))) And
                                                         (fEmptyStr(FEntregas.FQryDocumentos.FieldByName('INCREMCOMEND').AsString));
    end;
  end
  else
  begin
    btnRegPartida.Enabled := False;
    btnRegChegada.Enabled := False;
    btnRemoveDocs.Enabled := False;
    btnAdicionarDocMotorista.Enabled := False;
  end;
end;

procedure TfrmFatMotEntregas.cxgMotoristasDBTableViewCitelCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  LSituacao: String;
begin
  inherited;

  LSituacao := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgMotoristasSITUAC.Index]);

  case AnsiIndexStr(LSituacao, ['I','A','E','D']) of
    0: begin
         ACanvas.Brush.Color := clRed;
         ACanvas.Font.Color := clWhite;
       end;

    1: begin
         ACanvas.Brush.Color := clYellow;
         ACanvas.Font.Color := clBlack;
       end;

    2: begin
         ACanvas.Brush.Color := clBlue;
         ACanvas.Font.Color := clWhite;
       end;

    3: begin
         ACanvas.Brush.Color := clGreen;
         ACanvas.Font.Color := clWhite;
       end;
  end;
end;

procedure TfrmFatMotEntregas.cxgMotoristasMARDESPropertiesChange(
  Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(pMarcaMotorista, 'Aguarde, Carregando documentos ...', '');
end;

function TfrmFatMotEntregas.fDocumentoPosicionado: Boolean;
begin
  Result := False;

  if not Assigned(FEntregas.FQryDocumentos) then
    Exit;

  if not FEntregas.FQryDocumentos.Active then
    Exit;

  if FEntregas.FQryDocumentos.RecordCount <= 0 then
    Exit;

  if FEntregas.FQryDocumentos.RecNo <= 0 then
    Exit;

  Result := True;
end;

procedure TfrmFatMotEntregas.FormCreate(Sender: TObject);
begin
  inherited;

  FQryItens := fCriaQuery;
  FEntregas := TEntregas.Create;
  FTipoDoc := DocTodos;
  FCodMot := EmptyStr;
  FTotDocMarcados := 0;
  FSituacaoMotoristaSelecionado := MotNenhum;
  FClientMotoristaCriado := False;
  pSetaSQLItensDocumento;
  dtsDocumentos.DataSet := FEntregas.FQryDocumentos;
  dtsMotoristas.DataSet := FEntregas.FCdsMotoristas;
  dtsItensDoc.DataSet   := FQryItens;
  FObjLock := TLock.Create;
  FEspeciesPermitidas := EmptyStr;
end;

procedure TfrmFatMotEntregas.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FEntregas);
  FreeAndNil(FObjLock);
  FreeAndNil(FQryItens);

  inherited;
end;

procedure TfrmFatMotEntregas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_F2: btnRegPartida.Click;
    VK_F3: btnRegChegada.Click;
    VK_F4: btnRemoveDocs.Click;
    VK_F5: btnAtualizar.Click;
    VK_F6: btnDetEntrega.Click;
    VK_F7: btnConEntrega.Click;
    VK_F8: btnAltEntrega.Click;
    VK_F10: btnAdicionarDocMotorista.Click;
  end;
end;

procedure TfrmFatMotEntregas.FormShow(Sender: TObject);
begin
  inherited;

  TfrmGravando.fExecutarModal(pCarregaTelaInicial, 'Aguarde, Carregando documentos ...', '');
end;

end.
