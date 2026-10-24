unit untOcorrenciasRomaneio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, EditFocus, Uni, UniClientDataSet, cxProgressBar,
  UniDataSetProvider, MemoFocus, dxGDIPlusClasses,
  cxDataControllerConditionalFormattingRulesManagerDialog, untTLock, cxTextEdit;

type
  TfrmOcorrenciasRomaneio = class(TfrmPai)
    pnlDados: TPanel;
    Label1: TLabel;
    edtNumRom: TEditFocus;
    pnlGrid: TPanel;
    dbgDocumentos: TcxGrid;
    dbgDocumentosDBView: TcxGridDBTableView;
    dbgDocumentosGER_DTAENT: TcxGridDBColumn;
    dbgDocumentosGER_DTENTR: TcxGridDBColumn;
    dbgDocumentosVENDEDOR: TcxGridDBColumn;
    dbgDocumentosGER_VLRCON: TcxGridDBColumn;
    dbgDocumentoslevel: TcxGridLevel;
    btnFiltrar: TBitBtnLocked;
    dtsRomaneio: TDataSource;
    dbgDocumentosGER_CNDPAG: TcxGridDBColumn;
    btnOcorrencia: TBitBtnLocked;
    dbgDocumentosDOCUME: TcxGridDBColumn;
    dbgDocumentosOCORRE: TcxGridDBColumn;
    dbgDocumentosGER_OBSCPL: TcxGridDBColumn;
    GroupBox1: TGroupBox;
    Shape1: TShape;
    Label2: TLabel;
    Shape2: TShape;
    Label3: TLabel;
    btnRemoverOcorrencia: TBitBtnLocked;
    pnlOcorrencias: TPanel;
    Panel1: TPanel;
    Label15: TLabel;
    txtOcorrencias: TMemoFocus;
    edtCodEmp: TEditFocus;
    Label4: TLabel;
    GroupBox2: TGroupBox;
    lblSeta1: TLabel;
    lblSeta2: TLabel;
    imgSeta2: TImage;
    imgSeta1: TImage;
    dbgDocumentosGER_CODCLI: TcxGridDBColumn;
    dbgDocumentosCLI_NOMCLI: TcxGridDBColumn;
    dbgDocumentosDBGER_NUMFAT: TcxGridDBColumn;
    dbgDocumentosDBGER_TIPFAT: TcxGridDBColumn;
    procedure edtNumRomKeyPress(Sender: TObject; var Key: Char);
    procedure btnFiltrarClick(Sender: TObject);
    procedure pAfterOpen(Dataset: TDataSet);
    procedure pAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOcorrenciaClick(Sender: TObject);
    procedure pGravaOcorrencia(strCodOco, strObsComplementares: String);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgDocumentosDBViewCustomDrawGroupCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
    procedure btnRemoverOcorrenciaClick(Sender: TObject);
    procedure edtNumRomExit(Sender: TObject);
  private
    { Private declarations }
    cdsRomaneio: TUniClientDataSet;
    dspRomaneio: TUniDataSetProvider;
    qryRomaneio: TUniQuery;
    objLock: TLock;

    strChaRom: String;
    function fCarregarRomaneio(pgbStatus: TcxProgressBar): Boolean;
    function fTravaRomaneio: Boolean;
    procedure pDestravaRomaneio;
    procedure pRemoverOcorrencia;
  public
    { Public declarations }
  end;

implementation

uses
  untTypesSistema, untGravando, untRomGer, untFuncoesSimples, untConsultas,
  untDigOcorrencia, untTypesCRM, untAtualizaOcorrenciasCRM;

{$R *.dfm}

procedure TfrmOcorrenciasRomaneio.btnRemoverOcorrenciaClick(Sender: TObject);
begin
  inherited;
  if (cdsRomaneio.Active) and (cdsRomaneio.RecordCount > 0) then
    begin
    if (dbgDocumentosDBView.Controller.FocusedRow.ClassName = 'TcxGridDataRow') and
       (not fEmptyStr(cdsRomaneio.FieldByName('OCORRE').AsString))
    then
    begin
      if fMensagem('', 'Tem certeza que deseja apagar a ocorrência selecionada?', ['&Sim', '&Não'], 2) = 1 then
        pRemoverOcorrencia;
    end
    else
      fMensagem('Atenção!', 'Selecione uma ocorrência para ser removida', ['&Ok']);

    pSetFocus(dbgDocumentos);
  end
  else
    fMensagem('Atenção!', 'Selecione um romaneio antes de adicionar ou remover ocorrências', ['&Ok']);
end;

procedure TfrmOcorrenciasRomaneio.btnFiltrarClick(Sender: TObject);
begin
  inherited;

  if fEmptyStr(edtCodEmp.Text)  Then
  begin
    fMensagem('Atenção!','Código da empresa não informado.', ['&OK']);
    edtCodEmp.Clear;
    pSetFocus(edtCodEmp);
  end
  else
  begin
    If (fVerificaCampos) And
       (fTravaRomaneio)  And
       (fTravaDocsRomaneio(edtNumRom.Text, objLock)) Then
    Begin
      Try
        pCriarFormularios(TfrmGravando,frmGravando);
        frmGravando.lblGravando.Caption := 'Aguarde... Carregando.';
        frmGravando.strChave := 'PEDCOM';
        frmGravando.fExecutarAcao := fCarregarRomaneio;
        frmGravando.ShowModal;
      Except
        On E: Exception Do
          pMensagensErro(E.Message,'[Consultar - untFatRomaneio]');
      End;
      pFreeAndNil(frmGravando);
    End;
  end;
end;

procedure TfrmOcorrenciasRomaneio.btnOcorrenciaClick(Sender: TObject);
var
  strCodOco, strObsComplementares: String;
begin
  if (cdsRomaneio.Active) and (cdsRomaneio.RecordCount > 0) then
  begin
    Try
      pCriarFormularios(TfrmDigOcorrencia, frmDigOcorrencia);
      frmDigOcorrencia.blnInformarHisCom := True;
      frmDigOcorrencia.edtHisCom.MaxLength := 0;
      frmDigOcorrencia.lblHisCom.Caption := 'Obs. Complementares:';

      frmDigOcorrencia.ShowModal;
      If (frmDigOcorrencia.ModalResult = mrOk) Then
      Begin
        strCodOco := frmDigOcorrencia.strCodOco;
        strObsComplementares := frmDigOcorrencia.strHisCom;

        pGravaOcorrencia(strCodOco, strObsComplementares);
      End
      Else
      Begin
        strCodOco := '';
        strObsComplementares := '';
      End;
    Finally
      pFreeAndNil(frmDigOcorrencia);
    End;
  end
  else
    fMensagem('Atenção!', 'Selecione um romaneio antes de adicionar ou remover ocorrências', ['&Ok']);
end;

procedure TfrmOcorrenciasRomaneio.dbgDocumentosDBViewCustomDrawGroupCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
begin
  inherited;

  With cdsRomaneio Do
  Begin
    {*****************************************}
    {* CASO A TABELA ESTEJA FECHADA, SAI     *}
    {**************************************MV*}
    If Not Active Then
      Exit;

    If (Sender.DataController.GetValue(AViewInfo.GridRecord.RecordIndex, dbgDocumentosOCORRE.Index) <> Null) Then
      ACanvas.Brush.Color := $0032CD9A
    Else
      ACanvas.Brush.Color := clSkyBlue;
  end;
end;

procedure TfrmOcorrenciasRomaneio.edtNumRomExit(Sender: TObject);
begin
  inherited;

  if fEmptyStr(edtNumRom.Text) then
  begin
    fMensagem('Atenção!','Código do romaneio não informado.', ['&OK']);
    pSetFocus(edtNumRom);
  end;
end;

procedure TfrmOcorrenciasRomaneio.edtNumRomKeyPress(Sender: TObject;
  var Key: Char);
var
  qryConGen: TUniQuery;
  arrSel   : TConsultasArray;
begin
  inherited;

  If (edtNumRom.ReadOnly) Then
    Exit;

  qryConGen := fCriaQuery(Self);

  If fPesqRomaneio(Self, edtNumRom, qryConGen, Key, arrSel, '', True, True, 'Consulta de Romaneios') Then
  Begin
    edtCodEmp.Text := qryConGen.FieldByName('GER_CODEMP').AsString;
    If (fValidaCampos(edtNumRom, True)) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;

  FreeAndNil(qryConGen);
end;

function TfrmOcorrenciasRomaneio.fCarregarRomaneio(
  pgbStatus: TcxProgressBar): Boolean;
begin
  Result := True;

  try
    with qryRomaneio, SQL do
    begin
      Close;
      Clear;
      Append(' SELECT ');
      Append(' R.AUTOINCREM, ');
      Append(' R.GER_DTAENT, ');
      Append(' CONCAT(R.GER_NUMDOC, "-", R.GER_ESPDOC, "-", R.GER_CODEMP, ');
      Append('        " - ", R.GER_CODCLI, "-", IFNULL(CLI_NOMCLI, "")) AS DOCUME, ');
      Append(' R.GER_NUMDOC, ');
      Append(' R.GER_ESPDOC, ');
      Append(' R.GER_CODEMP, ');
      Append(' R.GER_NUMFAT, ');
      Append(' R.GER_TIPFAT, ');
      Append(' CONCAT(R.GER_CODCLI, "-", CLI_NOMCLI) AS CLIENTE, ');
      Append(' R.GER_CODCLI, ');
      Append(' R.GER_VLRCON, ');
      Append(' CLI_NOMCLI, ');
      Append(' CONCAT(R.GER_CODCND, "-", CND_DESCRI) AS CNDPAG, ');
      Append(' R.GER_CODCND, ');
      Append('  DATE_FORMAT( ');
      Append('       IF(IFNULL(PD.FGO_DTENTR,0) = 0, ');
      Append('          IF(IFNULL(G.GER_DTENTR,0) = 0, ');
      Append('                   N.GER_DTENTR, ');
      Append('             G.GER_DTENTR), ');
      Append('          PD.FGO_DTENTR), ');
      Append('  "%d/%m/%Y") AS GER_DTENTR, ');
      Append(' CONCAT(R.GER_CODVEN, "-", OPE_NOMOPE) AS VENDEDOR, ');
      Append(' R.GER_CODVEN, ');
      Append(' CONCAT(OCO_CODOCO, "-", OCO_DESOCO) AS OCORRE, ');
      Append(' OCO.GER_CODOCO, ');
      Append(' OCO.GER_DTAOCO, ');
      Append(' OCO.GER_HRAOCO, ');
      Append(' OCO.GER_CODOPE, ');
      Append(' OCO.GER_OBSCPL, ');
      Append(' "OBS.COMPL." AS OBSCPL ');
      Append(' FROM ROMGERX R ');
      Append(' LEFT JOIN FATGOR PD ON PD.FGO_NUMDOC = R.GER_NUMDOC ');
      Append(' AND PD.FGO_ESPDOC = R.GER_ESPDOC ');
      Append(' AND PD.FGO_CODEMP = R.GER_CODEMP ');
      Append(' LEFT JOIN MOVGER G ON G.GER_NUMDOC = R.GER_NUMDOC AND ');
      Append('                       G.GER_ESPDOC = R.GER_ESPDOC AND ');
      Append('                       G.GER_CODEMP = R.GER_CODEMP AND ');
      Append('                       G.GER_CODCLI = R.GER_CODCLI ');
      Append(' LEFT JOIN NOTGER N ON N.GER_NUMDOC = R.GER_NUMDOC AND ');
      Append('                       N.GER_ESPDOC = R.GER_ESPDOC AND ');
      Append('                       N.GER_CODEMP = R.GER_CODEMP AND ');
      Append('                       N.GER_CODCLI = R.GER_CODCLI ');
      Append(' LEFT JOIN CADCLI ON R.GER_CODCLI = CLI_CODCLI ');
      Append(' LEFT JOIN CADOPE ON R.GER_CODVEN = OPE_CODOPE ');
      Append(' LEFT JOIN CADCND ON R.GER_CODCND = CND_CODIGO ');
      Append(' LEFT JOIN ROMOCO OCO ON OCO.AUTOINCREM = R.AUTOINCREM ');
      Append(' LEFT JOIN CADOCO ON OCO.GER_CODOCO = OCO_CODOCO ');
      Append(' WHERE R.GER_NUMROM = :NUMROM ');
      Append(' AND R.GER_EMPROM = :CODEMP ');
      Append(' ORDER BY DOCUME ');

      ParamByName('NUMROM').AsString := edtNumRom.Text;
      ParamByName('CODEMP').AsString := edtCodEmp.Text;

      Open;

      pSetaClient(qryRomaneio);
      cdsRomaneio.SetProvider(dspRomaneio);

      if cdsRomaneio.Active then
        cdsRomaneio.Refresh
      else
        cdsRomaneio.Open;

      With cdsRomaneio Do
      Begin
        If (cdsRomaneio.IsEmpty) Then
          fMensagem('', 'Não há documentos com esses dados!', ['&OK'])
        Else
          pSetFocus(dbgDocumentos);
      End;
    end;
  except
    on E: Exception do
      fMensagem('ATENÇÃO!', E.Message, ['&Ok']);
  end;
end;

procedure TfrmOcorrenciasRomaneio.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(objLock);
end;

procedure TfrmOcorrenciasRomaneio.FormCreate(Sender: TObject);
begin
  inherited;

  qryRomaneio := fCriaQuery(Self);
  dspRomaneio := TUniDataSetProvider.Create(Self);
  cdsRomaneio := TUniClientDataSet.Create(Self);
  cdsRomaneio.SetProvider(dspRomaneio);

  dspRomaneio.DataSet := qryRomaneio;
  dtsRomaneio.DataSet := cdsRomaneio;

  cdsRomaneio.AfterOpen := pAfterOpen;
  cdsRomaneio.AfterScroll := pAfterScroll;

  dspRomaneio.DataSet := qryRomaneio;
  dtsRomaneio.DataSet := cdsRomaneio;

  objLock := TLock.Create;
end;

procedure TfrmOcorrenciasRomaneio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if (Key = VK_F2) then
    btnOcorrencia.Click
  else if (Key = VK_DELETE) then
    btnRemoverOcorrencia.Click
  else if (Key = VK_ESCAPE) then
    pEscapePressed;
end;

function TfrmOcorrenciasRomaneio.fTravaRomaneio: Boolean;
begin
  // DESTRAVA ANTERIOR SE HOUVER
  pDestravaRomaneio;
  If cdsRomaneio.Active Then
    cdsRomaneio.EmptyDataSet;

  Result := False;

  If Not fEmptyStr(edtNumRom.Text) Then
  Begin
    //TRAVA O NOVO
    strChaRom := 'ROMANEIO_' + edtNumRom.Text + edtCodEmp.Text;

    If Not fRomaneioExiste(edtNumRom.Text, edtCodEmp.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Romaneio não encontrado!', ['&O k']);
      Exit;
    End
    Else
    If Not objLock.fLock_Unlock(strChaRom, True, False) Then
    Begin
      fMensagem('ATENÇÃO!', 'Este romaneio está sendo utilizado por outra estação: ' + fGetHostLock(strChaRom), ['&Ok']);
      strChaRom := '';
    End
    Else Result := True;
  End;
end;

procedure TfrmOcorrenciasRomaneio.pAfterOpen(Dataset: TDataSet);
begin
  With DataSet Do
  Begin
    (FieldByName('GER_VLRCON') As TFloatField).DisplayFormat := '#,###0.00';
  End;
end;

{


begin
  inherited;

end;

}

procedure TfrmOcorrenciasRomaneio.pAfterScroll(DataSet: TDataSet);
var
  qryOco: TUniQuery;
begin
  try
    qryOco := fCriaQuery;

    with qryOco, SQL do
    begin
      Close;
      Clear;
      Append(' SELECT CONCAT(OCO_CODOCO, "-", OCO_DESOCO) AS OCORRE, ');
      Append(' CONCAT("Operador: ", GER_CODOPE, " - ", OPE_NOMOPE) AS OPERADOR, ');
      Append(' GER_DTAOCO, GER_HRAOCO, ');
      Append(' GER_OBSCPL ');
      Append(' FROM ROMOCO ');
      Append(' LEFT JOIN CADOCO ON GER_CODOCO = OCO_CODOCO ');
      Append(' LEFT JOIN CADOPE ON GER_CODOPE = OPE_CODOPE ');
      Append(' WHERE ROMOCO.AUTOINCREM = ' +QuotedStr(DataSet.FieldByName('AUTOINCREM').AsString));
      Open;

      txtOcorrencias.Lines.Clear;

      while not qryOco.Eof do
      begin
        txtOcorrencias.Lines.Add(qryOco.FieldByName('OPERADOR').AsString);
        txtOcorrencias.Lines.Add(Format('Data/Hora: %s - %s',
                                 [FormatDateTime('dd/mm/yyyy', qryOco.FieldByName('GER_DTAOCO').AsDateTime),
                                  FormatDateTime('hh:nn', qryOco.FieldByName('GER_HRAOCO').AsDateTime)]
                                 ));
        txtOcorrencias.Lines.Add(qryOco.FieldByName('OCORRE').AsString);
        txtOcorrencias.Lines.Add(qryOco.FieldByName('GER_OBSCPL').AsString);
        txtOcorrencias.Lines.Add('==============================================');
        qryOco.Next;
      end;
    end;

  finally
    FreeAndNil(qryOco);
  end;
end;

procedure TfrmOcorrenciasRomaneio.pDestravaRomaneio;
begin
  // DESTRAVA ANTERIOR SE HOUVER
  strChaRom := '';
  objLock.pDestravarTodos;
end;

procedure TfrmOcorrenciasRomaneio.pGravaOcorrencia(strCodOco,
  strObsComplementares: String);
var
  qryOcorrencia: TUniQuery;
  strDescri: String;
begin
  try
    try
      qryOcorrencia := fCriaQuery;

      with qryOcorrencia, SQL do
      begin
        Close;
        Clear;
        Append(' SELECT * FROM ROMOCO WHERE FALSE ');
        Open;

        Edit;

        FieldByName('AUTOINCREM').AsString := cdsRomaneio.FieldByName('AUTOINCREM').AsString;
        FieldByName('GER_CODOPE').AsString := strLoginUsuarioLogado;
        FieldByName('GER_DTAOCO').AsDateTime := fNow;
        FieldByName('GER_HRAOCO').AsDateTime := fNow;
        FieldByName('GER_CODOCO').AsString := strCodOco;
        FieldByName('GER_OBSCPL').AsString := strObsComplementares;

        Post;

        If (VS_strHabilitarCRM) Then
        Begin
          strDescri:= Concat('Operador: ', strLoginUsuarioLogado, ' - ',
                             fRetNomeOperador(strLoginUsuarioLogado)) + '<<csq>>' +
                      Format('Data/Hora: %s - %s',
                             [FormatDateTime('dd/mm/yyyy', FieldByName('GER_DTAOCO').AsDateTime),
                              FormatDateTime('hh:nn', FieldByName('GER_HRAOCO').AsDateTime)]) + '<<csq>><<csq>>' +
                      Concat(strCodOco, '-',
                             fCampoTabela('OCO_DESOCO', 'CADOCO', ['OCO_CODOCO'], [strCodOco])) + '<<csq>>' +
                      strObsComplementares;

          TUpdateOccurrenceCRM.New()
            .NumDoc(qryRomaneio.FieldByName('GER_NUMDOC').AsString)
            .EspDoc(qryRomaneio.FieldByName('GER_ESPDOC').AsString)
            .CodEmp(qryRomaneio.FieldByName('GER_CODEMP').AsString)
            .Descri(strDescri)
            .AcaFat(afcRegistroOcorrenciaRomaneio)
            .strNomFrm(Self.Name)
            .pRun();
        End;

        cdsRomaneio.Refresh;
      end;
    except
      on E: Exception do
        fMensagem('Erro!', E.Message, ['&Ok']);
    end;
  finally
    FreeAndNil(qryOcorrencia);
  end;
end;

procedure TfrmOcorrenciasRomaneio.pRemoverOcorrencia;
var
  qryUpdate: TUniQuery;
  qryDelete: TUniQuery;
begin
  try
    try
      qryUpdate := fCriaQuery;
      qryDelete := fCriaQuery;

      with qryUpdate, SQL do
      begin
        fStartTransaction;

        Close;
        Clear;
        Append(' SELECT * FROM DEL_ROMOCO WHERE FALSE ');
        Open;

        Edit;

        FieldByName('AUTOINCREM').AsString := cdsRomaneio.FieldByName('AUTOINCREM').AsString;
        FieldByName('GER_CODOPE').AsString := cdsRomaneio.FieldByName('GER_CODOPE').AsString;
        FieldByName('GER_DTAOCO').AsDateTime := cdsRomaneio.FieldByName('GER_DTAOCO').AsDateTime;
        FieldByName('GER_HRAOCO').AsDateTime := cdsRomaneio.FieldByName('GER_HRAOCO').AsDateTime;
        FieldByName('GER_CODOCO').AsString := cdsRomaneio.FieldByName('GER_CODOCO').AsString;
        FieldByName('GER_OBSCPL').AsString := cdsRomaneio.FieldByName('GER_OBSCPL').AsString;
        FieldByName('DTADEL').AsDateTime := fNow;
        FieldByName('HORDEL').AsDateTime := fNow;

        Post;
      end;

      with qryDelete, SQL do
      begin
        Close;
        Clear;
        Append(' DELETE FROM ROMOCO ');
        Append(' WHERE AUTOINCREM = :AUTOINCREM ');
        Append(' AND GER_DTAOCO = :DTAOCO ');
        Append(' AND GER_HRAOCO = :HRAOCO ');
        Append(' AND GER_CODOCO = :CODOCO ');

        if Not fEmptyStr(cdsRomaneio.FieldByName('GER_OBSCPL').AsString) then
          Append(' AND GER_OBSCPL = ' +QuotedStr(cdsRomaneio.FieldByName('GER_OBSCPL').AsString));

        ParamByName('AUTOINCREM').AsString := cdsRomaneio.FieldByName('AUTOINCREM').AsString;
        ParamByName('DTAOCO').AsDateTime := cdsRomaneio.FieldByName('GER_DTAOCO').AsDateTime;
        ParamByName('HRAOCO').AsDateTime := cdsRomaneio.FieldByName('GER_HRAOCO').AsDateTime;
        ParamByName('CODOCO').AsString := cdsRomaneio.FieldByName('GER_CODOCO').AsString;

        ExecSQL;
      end;

      fCommit;

      cdsRomaneio.Refresh;
    except
      on E: Exception do
      begin
        fMensagem('Erro', E.Message, ['&Ok']);
        fRollback;
        pSetFocus(dbgDocumentos);
      end;
    end;
  finally
    FreeAndNil(qryUpdate);
  end;
end;

end.
