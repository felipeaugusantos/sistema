unit untFatRomaneioAdicionarDoctosNaoEntregues;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, EditFocus, Uni, UniClientDataSet, StrUtils,
  cxProgressBar;

type
  TfrmFatRomaneioAdicionarDoctosNaoEntregues = class(TfrmPai)
    btnCancelar: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    pnlCabecalho: TPanel;
    lblRomaneio: TLabel;
    edtNumRom: TEditFocus;
    pnlDocsAnt: TPanel;
    Panel1: TPanel;
    cxgDocsAnt: TcxGrid;
    cxgDocsAntDados: TcxGridDBTableView;
    cxgDocsAntDadosDTAENT: TcxGridDBColumn;
    cxgDocsAntDadosNUMROM: TcxGridDBColumn;
    cxgDocsAntDadosNUMPED: TcxGridDBColumn;
    cxgDocsAntDadosNUMFAT: TcxGridDBColumn;
    cxgDocsAntDadosNOMCLI: TcxGridDBColumn;
    cxgDocsAntDadosNOMCID: TcxGridDBColumn;
    cxgDocsAntDadosCODVEN: TcxGridDBColumn;
    cxgDocsAntDadosNOMTRA: TcxGridDBColumn;
    cxgDocsAntDadosVLRCON: TcxGridDBColumn;
    cxgDocsAntNivel: TcxGridLevel;
    pnlDocVen: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    edtNFVend: TEditFocus;
    splitter: TSplitter;
    pnlDocsNov: TPanel;
    Label2: TLabel;
    Panel2: TPanel;
    cxgDocsNov: TcxGrid;
    cxgDocsNovDados: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxGridDBColumn7: TcxGridDBColumn;
    cxGridDBColumn8: TcxGridDBColumn;
    cxGridDBColumn9: TcxGridDBColumn;
    cxgDocsNovNivel: TcxGridLevel;
    dtsDocsAnt: TDataSource;
    dtsDocsNov: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure splitterCanResize(Sender: TObject; var NewSize: Integer; var Accept: Boolean);
    procedure btnCancelarClick(Sender: TObject);
    procedure cxgDocsNovDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtNumRomEnter(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    FDocsAnt,
    FDocsNov: TUniClientDataSet;
    FAceRom : String;
    FTemDocAnt: Boolean;

    procedure pCriaDataSetDocsAnt(AQry: TDataSet);
    procedure pCriaDataSetDocsNov(AQry: TDataSet);
    procedure pEscPressionado;
    procedure pLimparTela;
    procedure pCarregaDocumentosDoPreRomaneio;
    procedure pCarregaNotaFiscalNaoEntregue;
    procedure pCarregaNotaFiscalNaoEntregueJaAdicionada(ANumNF: String);
    procedure pAdicionarNotasFiscaisAoPreRomaneio;
    procedure pAtualizaQtdRomDocumento(AAutInc: String; AQtdRom: Double);

    procedure pSetaParametros(Aqry: TUniQuery);
    procedure pCarregaTabelaPrincipalRomaneio(AGer: TUniQuery; ACampos: String);
    procedure pCarregaTabelaAuxiliarRomaneio(AAux: TUniQuery; ACampos, AAutInc: String);
    procedure pCarregaTabelaDetalhesRomaneio(ADet: TUniQuery; ACampos: String);
    procedure pClonaTabelaPrincipalRomaneio(var ASeqGer: String; AGer: TUniQuery);
    procedure pClonaTabelaAuxiliarRomaneio(ASeqGer: String; AAux: TUniQuery);
    procedure pClonaTabelaDetalhesRomaneio(ASeqGer: String; ADet: TUniQuery);
    procedure pAtualizaNumeroRomaneioPedido;
    procedure pRemoveDocumentosAdicionadosAnteriormente;
    procedure pRemoveDEL_RomGerX_RomDetX_AuxRomX(AAutInc: String);

    function fChaveRomaneio: String;
    function fGetSQLFrom(ATabDel: Boolean = False): String;
    function fPreRomaneioEncontrado: Boolean;
    function fAdicionarNotasFiscaisAoPreRomaneio(AStatus: TcxProgressBar = nil): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pEscapePressed; override;
  public
    { Public declarations }
  end;

implementation

uses
  untRomGer, untFuncoesSimples, untGravando;

{$R *.dfm}

{ TfrmFatRomaneioAdicionarDoctosNaoEntregues }

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.btnCancelarClick(
  Sender: TObject);
begin
  inherited;
  pLimparTela;
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.cxgDocsNovDadosKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_RETURN: pSetFocus(edtNFVend);
    VK_DELETE:
      if (not FDocsNov.IsEmpty) then
        FDocsNov.Delete;
  end;
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.btnConfirmaClick(
  Sender: TObject);
begin
  inherited;

  if FDocsAnt.IsEmpty then
  begin
    pMensagemOk('Informe o pré-romaneio no qual será adicionado o documento!');
    Exit;
  end;

  if FDocsNov.IsEmpty and (not FTemDocAnt) then
  begin
    pMensagemOk('Não há documentos para serem adicionados ao Pré-Romaneio!');
    Exit;
  end;

  if (not FDocsNov.IsEmpty) and
     (not fPergunta('Confirma adicionar os documentos ao Pré-Romaneio?')) then
    Exit;

  if FDocsNov.IsEmpty And FTemDocAnt and
     (not fPergunta('Confirma remover documentos adicionados anteriormente?')) then
    Exit;

  try
    pAdicionarNotasFiscaisAoPreRomaneio;
  finally
    pLimparTela;
  end;
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.edtNumRomEnter(
  Sender: TObject);
begin
  inherited;
  pLimparTela;
end;

function TfrmFatRomaneioAdicionarDoctosNaoEntregues.fAdicionarNotasFiscaisAoPreRomaneio(
  AStatus: TcxProgressBar): Boolean;
var
  LGer: TUniQuery;
  LAux: TUniQuery;
  LDet: TUniQuery;
  LSeqGer: String;

  COLUMNS_ROMGERX: String;
  COLUMNS_ROMDETX: String;
  COLUMNS_AUXROMX: String;
begin
  LGer := fCriaQuery(Self);
  LAux := fCriaQuery(Self);
  LDet := fCriaQuery(Self);

  try
    try
      COLUMNS_ROMGERX := fRetCamposDaTabela('ROMGERX');
      COLUMNS_AUXROMX := fRetCamposDaTabela('AUXROMX');
      COLUMNS_ROMDETX := fRetCamposDaTabela('ROMDETX');

      if (not fStartTransaction) then
        Exit(False);

      pInformacao('Aguarde, Adicionando documentos ao Pré-Romaneio ... ', AStatus);

      pRemoveDocumentosAdicionadosAnteriormente;

      FDocsNov.First;

      while not FDocsNov.Eof do
      begin
        pProgresso(FDocsNov.RecNo, FDocsNov.RecordCount, AStatus);

        pCarregaTabelaPrincipalRomaneio(LGer, COLUMNS_ROMGERX);
        pCarregaTabelaAuxiliarRomaneio(LAux, COLUMNS_AUXROMX, LGer.FieldByName('AUTOINCREM').AsString);
        pCarregaTabelaDetalhesRomaneio(LDet, COLUMNS_ROMDETX);

        pClonaTabelaPrincipalRomaneio(LSeqGer, LGer);
        pClonaTabelaAuxiliarRomaneio(LSeqGer, LAux);
        pClonaTabelaDetalhesRomaneio(LSeqGer, LDet);

        pAtualizaNumeroRomaneioPedido;

        pRemoveDEL_RomGerX_RomDetX_AuxRomX(LGer.FieldByName('AUTOINCREM').AsString);

        FDocsNov.Next;
      end;

      Result := fCommit;

      if Result then
        pMensagemOk('Pré-Romaneio atualizado com sucesso!');
    except
      on E: Exception Do
      begin
        fRollback;
        Result := False;
        pMensagensErro(E.Message, '');
      end;
    end;
  finally
    FreeAndNil(LGer);
    FreeAndNil(LAux);
    FreeAndNil(LDet);
  end;
end;

function TfrmFatRomaneioAdicionarDoctosNaoEntregues.fChaveRomaneio: String;
begin
  Result := 'ROMANEIO_' + fNumeroRomaneio(edtNumRom.Text) + VS_strCodEmp;
end;

function TfrmFatRomaneioAdicionarDoctosNaoEntregues.fGetSQLFrom(ATabDel: Boolean = False): String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  GER_DTAENT AS DTAENT, ';
  Result := Result + '  GER_HORENT AS HORENT, ';
  Result := Result + '  GER_NUMROM AS NUMROM, ';
  Result := Result + '  GER_EMPROM AS EMPROM, ';
  Result := Result + '  CONCAT(GER_NUMDOC, "-", GER_ESPDOC, "-", GER_CODEMP) AS NUMPED, ';
  Result := Result + '  CONCAT(FGO_NUMFAT, "-", FGO_TIPFAT, "-", FGO_EMPFAT) AS NUMFAT, ';
  Result := Result + '  FGO_NUMFAT NUMVEN, ';
  Result := Result + '  GER_NUMDOC NUMDOC, ';
  Result := Result + '  GER_ESPDOC ESPDOC, ';
  Result := Result + '  GER_CODEMP CODEMP, ';
  Result := Result + '  GER_CODCLI CODCLI, ';
  Result := Result + '  IF(GER_NOMCON = "" OR GER_NOMCON IS NULL, CLI_NOMCLI, GER_NOMCON) NOMCLI, ';
  Result := Result + '  CID_NOMCID AS NOMCID, ';
  Result := Result + '  GER_CODVEN AS CODVEN, ';
  Result := Result + '  TRA_NOMTRA AS NOMTRA, ';
  Result := Result + '  GER_VLRCON AS VLRCON, ';
  Result := Result + '  GER_STATUS AS STATUS, ';
  Result := Result + '  GER_ENTNOV AS ENTNOV  ';

  if fCfgSis('MATDIS', varBoolean) then
    Result := Result + IIF(ATabDel, ', "S" AS LIBERADO ',
                           ', (SELECT '+
                           '     IF(COUNT(ROMDETX.AUTOINCREM) > 0, "S", "N") '+
                           '   FROM '+
                           '     ROMDETX '+
                           '   WHERE '+
                           '     DET_QTDROM <> DET_QTDBAI AND '+
                           '     DET_SEQGER = ROMGERX.AUTOINCREM AND '+
                           '     DET_LIBERA = "S" AND '+
                           '     DET_NUMDOC = GER_NUMDOC AND '+
                           '     DET_ESPDOC = GER_ESPDOC AND '+
                           '     DET_CODEMP = GER_CODEMP) AS LIBERADO ');

  Result := Result + 'FROM ROMGERX ';
  Result := Result + 'LEFT JOIN FATGOR ON FGO_NUMDOC = GER_NUMDOC ';
  Result := Result + '                AND FGO_ESPDOC = GER_ESPDOC ';
  Result := Result + '                AND FGO_CODEMP = GER_CODEMP ';
  Result := Result + '                AND FGO_CODCLI = GER_CODCLI ';
  Result := Result + 'LEFT JOIN CADTRA ON TRA_CODTRA = GER_CODTRA ';
  Result := Result + '     JOIN CADCLI ON GER_CODCLI = CLI_CODCLI ';
  Result := Result + '     JOIN CADCID ON IF(GER_CIDCON IS NULL, CLI_CODCID, GER_CIDCON) = CID_CODCID ';
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumRom);
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  fLock_Unlock(fChaveRomaneio, False);

  if Assigned(FDocsAnt) then
    FreeAndNil(FDocsAnt);

  if Assigned(FDocsNov) then
    FreeAndNil(FDocsNov);
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.FormCreate(Sender: TObject);
begin
  inherited;
  edtNFVend.TamCampo  := fTamDocCadRec;
  edtNFVend.MaxLength := fTamDocCadRec;
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.FormKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_F3    : btnCancelar.Click;
    VK_F10   : btnConfirma.Click;
    VK_ESCAPE: pEscPressionado;
  end;
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaDocumentosDoPreRomaneio;//Utilizado para criar a estrutura dos clientDataSets
  FAceRom := fCampoTabela('OPE_EMPROM', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]);
end;

function TfrmFatRomaneioAdicionarDoctosNaoEntregues.fPreRomaneioEncontrado: Boolean;
var
  LQry   : TUniQuery;
  LNumRom: String;
begin
  try
    Result := False;
    LQry := fCriaQuery;

    LNumRom := fTrataNumRom(edtNumRom);

    if (LeftStr(edtNumRom.Text, 1) = '1') then
      LNumRom := edtNumRom.Text
    else
      LNumRom := RightStr(edtNumRom.Text,6);

    LQry.SQL.Add('SELECT ');
    LQry.SQL.Add('  FGO_JAFATU, ');
    LQry.SQL.Add('  GER_STATUS  ');
    LQry.SQL.Add('FROM ROMGERX R ');
    LQry.SQL.Add('INNER JOIN FATGOR G ON R.GER_CODEMP = G.FGO_CODEMP ');
    LQry.SQL.Add('                   AND R.GER_NUMDOC = G.FGO_NUMDOC ');
    LQry.SQL.Add('                   AND R.GER_ESPDOC = G.FGO_ESPDOC ');
    LQry.SQL.Add('                   AND R.GER_CODCLI = G.FGO_CODCLI ');
    LQry.SQL.Add('WHERE R.GER_EMPROM = :CODEMP AND ');

    if (LeftStr(edtNumRom.Text,1) = '1') then
      LQry.SQL.Add('  R.GER_CODBAR = :NUMDOC ')
    else
      LQry.SQL.Add('  R.GER_NUMROM = :NUMDOC ');

    LQry.SQL.Add('ORDER BY G.AUTOINCREM ');

    LQry.ParamByName('NUMDOC').AsString := LNumRom;
    LQry.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQry.Open;

    if (not LQry.IsEmpty) then
    begin
      Result := True;

      LQry.First;

      while not LQry.Eof do
      begin
        if (LQry.FieldByName('FGO_JAFATU').AsInteger = 0) then
        begin
          fMensagem('ATENÇÃO!', 'Esse pré-romaneio não foi totalmente expedido!', ['&O k']);
          Result := False;
          Break;
        end;

        LQry.Next;
      End;

      if (LQry.FieldByName('GER_STATUS').AsString = 'A') then
      begin
        fMensagem('ATENÇÃO!', 'Esse pré-romaneio já foi Ativado!', ['&O k']);
        Result := False;
      end;
    end
    else
    begin
      fMensagem('ATENÇÃO!', 'Pré-romaneio não encontrado!', ['&O k']);
      Result := False;
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

function TfrmFatRomaneioAdicionarDoctosNaoEntregues.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (Sender = edtNumRom) then
  begin
    blnMudarFoco := False;

    if (not fEmptyStr(edtNumRom.Text)) then
      if fPreRomaneioEncontrado then
        TfrmGravando.fExecutarModalA(pCarregaDocumentosDoPreRomaneio,
          'Aguarde, carregando documentos ...', '');
  end
  else if (Sender = edtNFVend) then
  begin
    if FDocsAnt.IsEmpty then
    begin
      pMensagemOk('Informe o pré-romaneio no qual será adicionado o documento!');
      Result := False;
      Exit;
    end;

    if Not fEmptyStr(edtNFVend.Text) then
    begin
      pCarregaNotaFiscalNaoEntregue;
      blnMudarFoco := False;
      edtNFVend.Clear;
    end;
  end;
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.pAdicionarNotasFiscaisAoPreRomaneio;
begin
  try
    fChamaTelaGravando(fAdicionarNotasFiscaisAoPreRomaneio, 'Aguarde...');
  except
    on E: Exception do
      pMensagensErro(E.Message, '');
  end;
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.pAtualizaNumeroRomaneioPedido;
var
  LQry: TUniQuery;
begin
  LQry := fCriaQuery;

  try
    try
      LQry.SQL.Text := ' UPDATE FATGOR ' +
                       ' SET FGO_NUMROM = ' + fNumeroRomaneio(edtNumRom.Text).QuotedString +
                       ' WHERE FGO_NUMDOC = :NUMDOC ' +
                       '   AND FGO_ESPDOC = :ESPDOC ' +
                       '   AND FGO_CODEMP = :CODEMP ';
      pSetaParametros(LQry);
      LQry.ExecSQL;
    except
      raise;
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.pAtualizaQtdRomDocumento(
  AAutInc: String; AQtdRom: Double);
var
  LDor: TUniQuery;
begin
  LDor := fCriaQuery(Self);

  try
    LDor.SQL.Text := ' UPDATE FATDOR ' +
                     ' SET FDO_QTDROM = FDO_QTDROM + :QTDROM ' +
                     ' WHERE AUTOINCREM = :AUTINC ';

    LDor.ParamByName('QTDROM').AsFloat := AQtdRom;
    LDor.ParamByName('AUTINC').AsString := AAutInc;
    LDor.ExecSQL;
  finally
    FreeAndNil(LDor);
  end;
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.pCarregaDocumentosDoPreRomaneio;
var
  LSQL: String;
  LQry: TUniQuery;
begin
  LQry := fCriaQuery(nil);

  try
    LSQL := fGetSQLFrom;
    LSQL := LSQL + '  WHERE ';

    if (not fEmptyStr(fNumeroRomaneio(edtNumRom.Text))) Then
    begin
      LSQL := LSQL + '  GER_NUMROM = :NUMROM AND ';
      LSQL := LSQL + '  GER_EMPROM = :EMPROM ';
    end
    else
      LSQL := LSQL + '  FALSE ';

    LSQL := LSQL + '  AND LOCATE(FGO_CODEMP,' + QuotedStr(FAceRom) + ' ) > 0 ';
    LSQL := LSQL + 'ORDER BY NUMROM, EMPROM ';

    LQry.SQL.Add(LSQL);

    if (not fEmptyStr(fNumeroRomaneio(edtNumRom.Text))) then
    begin
      LQry.ParamByName('NUMROM').AsString := fNumeroRomaneio(edtNumRom.Text);
      LQry.ParamByName('EMPROM').AsString := VS_strCodEmp;
    end;

    LQry.Open;

    pCriaDataSetDocsAnt(LQry);
    pCriaDataSetDocsNov(LQry);

    TFloatField(FDocsAnt.FieldByName('VLRCON')).DisplayFormat := '#,##0.00';
    TFloatField(FDocsNov.FieldByName('VLRCON')).DisplayFormat := '#,##0.00';

    if (not fEmptyStr(fNumeroRomaneio(edtNumRom.Text))) and
       (not fLock_Unlock(fChaveRomaneio, True, False)) then
    begin
      pMensagemOk('O pré-romaneio ' + fNumeroRomaneio(edtNumRom.Text) +
        ' está sendo utilizado por outra estação: ' + fGetHostLock(fChaveRomaneio));
    end
    else
    begin
      FTemDocAnt := False;
      LQry.First;

      while not LQry.Eof do
      begin
        FTemDocAnt := FTemDocAnt or (LQry.FieldByName('ENTNOV').AsString = 'S');

        if (LQry.FieldByName('ENTNOV').AsString = 'S') then
          pCarregaNotaFiscalNaoEntregueJaAdicionada(LQry.FieldByName('NUMVEN').AsString)
        else
          pCopiaRegistroDataSet(LQry, FDocsAnt);

        LQry.Next;
      end;
    end;

    if (not FDocsAnt.IsEmpty) then
      pSetFocus(edtNFVend);
  finally
    FreeAndNil(LQry);
  end
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.pCarregaNotaFiscalNaoEntregue;
var
  LSQL: String;
  LQry: TUniQuery;
begin
  LQry := fCriaQuery(nil);

  try
    LSQL := '(' + fGetSQLFrom;
    LSQL := LSQL + 'WHERE GER_NUMROM <> :NUMROM ';
    LSQL := LSQL + '  AND GER_EMPROM = :EMPROM  ';
    LSQL := LSQL + '  AND FGO_NUMFAT = :NUMFAT  ';
    LSQL := LSQL + '  AND FGO_TIPFAT = :TIPFAT  ';
    LSQL := LSQL + 'ORDER BY NUMROM DESC ';
    LSQL := LSQL + 'LIMIT 1) ';
    LSQL := LSQL + 'UNION ';
    LSQL := LSQL + '( ' + AnsiReplaceStr(AnsiReplaceStr(fGetSQLFrom(True), 'ROMGERX', 'DEL_ROMGERX'), 'ROMDETX', 'DEL_ROMDETX');
    LSQL := LSQL + 'WHERE GER_NUMROM <> :NUMROM ';
    LSQL := LSQL + '  AND GER_EMPROM = :EMPROM  ';
    LSQL := LSQL + '  AND FGO_NUMFAT = :NUMFAT  ';
    LSQL := LSQL + '  AND FGO_TIPFAT = :TIPFAT  ';
    LSQL := LSQL + 'ORDER BY NUMROM DESC ';
    LSQL := LSQL + 'LIMIT 1) ';

    LQry.SQL.Add(LSQL);
    LQry.ParamByName('NUMROM').AsString := fNumeroRomaneio(edtNumRom.Text);
    LQry.ParamByName('NUMFAT').AsString := edtNFVend.Text;
    LQry.ParamByName('TIPFAT').AsString := 'NF';
    LQry.ParamByName('EMPROM').AsString := VS_strCodEmp;
    LQry.Open;

    if LQry.IsEmpty then
      pMensagemOk('Documento de venda não encontrado em nenhum romaneio anterior!')

    else if FDocsNov.Locate('NUMVEN', LQry.FieldByName('NUMVEN').AsString, []) then
      pMensagemOk('Documento de venda já foi carregado!')

    else if (LQry.FieldByName('NUMROM').AsString = edtNumRom.Text) then
      pMensagemOk('Documento já foi adicionado ao pré-romaneio!')

    else if (LQry.FieldByName('STATUS').AsString <> 'A') then
      pMensagemOk('Documento foi adicionado em um pré-romaneio que ainda não foi ativado!')

    else if (fCfgSis('MATDIS', varBoolean)) and (LQry.FieldByName('LIBERADO').AsString = 'N') then
        pMensagemOk('Este Documento está pendente de liberação no Painel de Entrega!')

    else if fPergunta('Este documento foi adicionado anteriormente ao romaneio ' +
                      LQry.FieldByName('NUMROM').AsString + '. ' + #13#10 +
                      'Confirma carregar o mesmo ' +
                      'para uma nova entrega no pré-romaneio ' + edtNumRom.Text + '?') then
      pCopiaRegistroDataSet(LQry, FDocsNov);
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.pCarregaNotaFiscalNaoEntregueJaAdicionada(ANumNF: String);
var
  LSQL: String;
  LQry: TUniQuery;
begin
  LQry := fCriaQuery(nil);

  try
    LSQL := fGetSQLFrom;
    LSQL := LSQL + ' WHERE GER_NUMROM <> :NUMROM ';
    LSQL := LSQL + '   AND GER_EMPROM = :EMPROM  ';
    LSQL := LSQL + '   AND FGO_NUMFAT = :NUMFAT  ';
    LSQL := LSQL + '   AND FGO_TIPFAT = :TIPFAT  ';
    LSQL := LSQL + ' ORDER BY NUMROM DESC ';
    LSQL := LSQL + ' LIMIT 1 ';

    LQry.SQL.Add(LSQL);
    LQry.ParamByName('NUMROM').AsString := fNumeroRomaneio(edtNumRom.Text);
    LQry.ParamByName('NUMFAT').AsString := ANumNF;
    LQry.ParamByName('TIPFAT').AsString := 'NF';
    LQry.ParamByName('EMPROM').AsString := VS_strCodEmp;
    LQry.Open;

    if (not LQry.IsEmpty) then
      pCopiaRegistroDataSet(LQry, FDocsNov);
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.pCarregaTabelaAuxiliarRomaneio(
  AAux: TUniQuery; ACampos, AAutInc: String);
begin
  try
    AAux.Close;
    AAux.SQL.Clear;

    AAux.SQL.Add('  SELECT ' + ACampos);
    AAux.SQL.Add('    FROM AUXROMX ');
    AAux.SQL.Add('  WHERE AUX_SEQGER = ' +AAutInc.QuotedString);

    AAux.SQL.Add('  UNION ');

    AAux.SQL.Add('  SELECT ' + ACampos);
    AAux.SQL.Add('    FROM DEL_AUXROMX ');
    AAux.SQL.Add('  WHERE AUX_SEQGER = ' + AAutInc.QuotedString);

    AAux.Open;
  except
    raise;
  end;
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.pCarregaTabelaDetalhesRomaneio(
  ADet: TUniQuery; ACampos: String);
begin
  try
    ADet.Close;
    ADet.SQL.Clear;

    ADet.SQL.Add('  SELECT ' + ACampos);
    ADet.SQL.Add('    FROM ROMDETX ');
    ADet.SQL.Add('  WHERE DET_NUMROM = :NUMROM ');
    ADet.SQL.Add('    AND DET_EMPROM = :EMPROM ');
    ADet.SQL.Add('    AND DET_NUMDOC = :NUMDOC ');
    ADet.SQL.Add('    AND DET_ESPDOC = :ESPDOC ');
    ADet.SQL.Add('    AND DET_CODEMP = :CODEMP ');

    if fCfgSis('MATDIS', varBoolean) then
      ADet.SQL.Add(' AND DET_LIBERA = "S" ')
    else
      ADet.SQL.Add(' AND DET_QTDBAI <> DET_QTDROM ');

    ADet.SQL.Add('  UNION ');

    ADet.SQL.Add('  SELECT ' + ACampos);
    ADet.SQL.Add('    FROM DEL_ROMDETX ');
    ADet.SQL.Add('  WHERE DET_NUMROM = :NUMROM ');
    ADet.SQL.Add('    AND DET_EMPROM = :EMPROM ');
    ADet.SQL.Add('    AND DET_NUMDOC = :NUMDOC ');
    ADet.SQL.Add('    AND DET_ESPDOC = :ESPDOC ');
    ADet.SQL.Add('    AND DET_CODEMP = :CODEMP ');

    if fCfgSis('MATDIS', varBoolean) then
      ADet.SQL.Add(' AND DET_LIBERA = "S" ')
    else
      ADet.SQL.Add(' AND DET_QTDBAI <> DET_QTDROM ');

    pSetaParametros(ADet);
    ADet.Open;
  except
    raise;
  end;
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.pCarregaTabelaPrincipalRomaneio(AGer: TUniQuery; ACampos: String);
begin
  try
    AGer.Close;
    AGer.SQL.Clear;

    AGer.SQL.Add('  SELECT ' + ACampos);
    AGer.SQL.Add('    FROM ROMGERX ');
    AGer.SQL.Add('  WHERE GER_NUMROM = :NUMROM ');
    AGer.SQL.Add('    AND GER_EMPROM = :EMPROM ');
    AGer.SQL.Add('    AND GER_NUMDOC = :NUMDOC ');
    AGer.SQL.Add('    AND GER_ESPDOC = :ESPDOC ');
    AGer.SQL.Add('    AND GER_CODEMP = :CODEMP ');

    AGer.SQL.Add('  UNION ');

    AGer.SQL.Add('  SELECT ' + ACampos);
    AGer.SQL.Add('    FROM DEL_ROMGERX ');
    AGer.SQL.Add('  WHERE GER_NUMROM = :NUMROM ');
    AGer.SQL.Add('    AND GER_EMPROM = :EMPROM ');
    AGer.SQL.Add('    AND GER_NUMDOC = :NUMDOC ');
    AGer.SQL.Add('    AND GER_ESPDOC = :ESPDOC ');
    AGer.SQL.Add('    AND GER_CODEMP = :CODEMP ');

    pSetaParametros(AGer);
    AGer.Open;
  except
    raise;
  end;
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.pClonaTabelaAuxiliarRomaneio(ASeqGer: String; AAux: TUniQuery);
var
  LCont: Integer;
  LQry: TUniQuery;
begin
  LQry := fCriaQuery;

  try
    try
      LQry.SQL.Add('SELECT * FROM AUXROMX WHERE FALSE ');
      LQry.Open;

      LQry.Append;

      For LCont := 0 To LQry.FieldCount-1 Do
        LQry.Fields[LCont].Value := AAux.Fields[LCont].Value;

      LQry.FieldByName('AUX_SEQGER').AsString := ASeqGer;
      LQry.Post;
    except
      raise;
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.pClonaTabelaDetalhesRomaneio(
  ASeqGer: String; ADet: TUniQuery);
var
  LCont: Integer;
  LQry: TUniQuery;
begin
  LQry := fCriaQuery;

  try
    try
      //Clona os registros da tabela ROMDETX
      LQry.Close;
      LQry.SQL.Clear;
      LQry.SQL.Add(' SELECT * FROM ROMDETX WHERE FALSE ');
      LQry.Open;

      ADet.First;

      while not ADet.Eof do
      begin
        LQry.Append;

        for LCont := 0 to LQry.FieldCount-1 do
          LQry.Fields[LCont].Value := ADet.Fields[LCont].Value;

        LQry.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ROMDETX', VS_strCodEmp);
        LQry.FieldByName('DET_SEQGER').AsString := ASeqGer;
        LQry.FieldByName('DET_NUMROM').AsString := fNumeroRomaneio(edtNumRom.Text);
        LQry.FieldByName('DET_EMPROM').AsString := VS_strCodEmp;

        if LQry.FieldByName('DET_QTDROM').AsFloat <> LQry.FieldByName('DET_QTDBAI').AsFloat then
          LQry.FieldByName('DET_QTDBAI').AsFloat := (LQry.FieldByName('DET_QTDROM').AsFloat -
                                                       LQry.FieldByName('DET_QTDBAI').AsFloat);

        LQry.FieldByName('DET_QTDROM').AsFloat := LQry.FieldByName('DET_QTDBAI').AsFloat;

        if fCfgSis('MATDIS', varBoolean) then
        begin
          LQry.FieldByName('DET_QTDAVA').Clear;
          LQry.FieldByName('DET_QTDFAL').Clear;
          LQry.FieldByName('DET_LIBERA').AsString := 'N';
        end;

        pAtualizaQtdRomDocumento(LQry.FieldByName('DET_AUTINC').AsString, LQry.FieldByName('DET_QTDROM').AsFloat);

        LQry.Post;
        ADet.Next;
      end;
    except
      raise;
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.pClonaTabelaPrincipalRomaneio(var ASeqGer: String; AGer: TUniQuery);
var
  LCont: Integer;
  LQry: TUniQuery;
begin
  LQry := fCriaQuery;

  try
    try
      ASeqGer := fRetAutoIncrem('ROMGERX', VS_strCodEmp);

      LQry.SQL.Add('SELECT * FROM ROMGERX WHERE FALSE ');
      LQry.Open;

      LQry.Append;

      For LCont := 0 To LQry.FieldCount-1 Do
        LQry.Fields[LCont].Value := AGer.Fields[LCont].Value;

      LQry.FieldByName('AUTOINCREM').AsString := ASeqGer;
      LQry.FieldByName('GER_NUMROM').AsString := fNumeroRomaneio(edtNumRom.Text);
      LQry.FieldByName('GER_EMPROM').AsString := VS_strCodEmp;
      LQry.FieldByName('GER_STATUS').AsString := FDocsAnt.FieldByName('STATUS').AsString;
      LQry.FieldByName('GER_ENTNOV').AsString := 'S';//Entregar novamente
      LQry.FieldByName('GER_DTABAI').Clear;
      LQry.FieldByName('GER_HORBAI').Clear;
      LQry.FieldByName('GER_SEQATV').Clear;

      if fCfgSis('MATDIS', varBoolean) then
      begin
        LQry.FieldByName('GER_DTAINI').Clear;
        LQry.FieldByName('GER_HORINI').Clear;
        LQry.FieldByName('GER_DTACHE').Clear;
        LQry.FieldByName('GER_HORCHE').Clear;
        LQry.FieldByName('GER_DTABAI').Clear;
        LQry.FieldByName('GER_HORBAI').Clear;
        LQry.FieldByName('GER_ENTREG').Clear;
        LQry.FieldByName('GER_BAIAPP').AsString := 'N';
        LQry.FieldByName('GER_INIPAR').AsString := '';
        LQry.FieldByName('GER_LOCALI').AsString := '';
        LQry.FieldByName('GER_TMPENT').AsInteger := 0;
        LQry.FieldByName('GER_DISTAN').AsInteger := 0;
        LQry.FieldByName('GER_LIBAPP').AsString := 'N';
      end;

      LQry.Post;
    except
      raise;
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.pCriaDataSetDocsAnt(AQry: TDataSet);
begin
  if Assigned(FDocsAnt) then
    Exit;

  FDocsAnt := fCriaClientDatset(AQry, True);
  dtsDocsAnt.DataSet := FDocsAnt;
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.pCriaDataSetDocsNov(AQry: TDataSet);
begin
  if Assigned(FDocsNov) then
    Exit;

  FDocsNov := fCriaClientDatset(AQry, True);
  dtsDocsNov.DataSet := FDocsNov;
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.pEscapePressed;
begin
  pEscPressionado;
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.pEscPressionado;
begin
  if edtNumRom.Focused then
    btnSair.Click
  else if edtNFVend.Focused then
    pSetFocus(edtNumRom)
  else
    pSetFocus(edtNFVend);
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.pLimparTela;
begin
  if Assigned(FDocsAnt) then
    FDocsAnt.EmptyDataSet;

  if Assigned(FDocsNov) then
    FDocsNov.EmptyDataSet;

  fLock_Unlock(fChaveRomaneio, False);

  edtNumRom.Clear;
  edtNFVend.Clear;
  pSetFocus(edtNumRom);
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.pRemoveDEL_RomGerX_RomDetX_AuxRomX(AAutInc: String);
var
  LQry: TUniQuery;
begin
  LQry := fCriaQuery;

  try
    try
      LQry.SQL.Add('DELETE FROM DEL_ROMGERX ');
      LQry.SQL.Add('WHERE AUTOINCREM = :AUTINC ');
      LQry.ParamByName('AUTINC').AsString := AAutInc;
      LQry.ExecSQL;

      LQry.Close;
      LQry.SQL.Clear;
      LQry.SQL.Add('DELETE FROM DEL_ROMDETX ');
      LQry.SQL.Add('WHERE DET_SEQGER = :SEQGER ');
      LQry.ParamByName('SEQGER').AsString := AAutInc;
      LQry.ExecSQL;

      LQry.Close;
      LQry.SQL.Clear;
      LQry.SQL.Add('DELETE FROM DEL_AUXROMX ');
      LQry.SQL.Add('WHERE AUX_SEQGER = :SEQGER ');
      LQry.ParamByName('SEQGER').AsString := AAutInc;
      LQry.ExecSQL;
    except
      raise;
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.pRemoveDocumentosAdicionadosAnteriormente;
var
  LQry: TUniQuery;
begin
  LQry := fCriaQuery;

  try
    try
      LQry.SQL.Text := ' DELETE FROM ROMGERX ' +
                       ' WHERE GER_NUMROM = ' + fNumeroRomaneio(edtNumRom.Text).QuotedString +
                       '   AND GER_EMPROM = ' + VS_strCodEmp.QuotedString +
                       '   AND GER_ENTNOV = "S" ' ;
      LQry.ExecSQL;
    except
      raise;
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.pSetaParametros(Aqry: TUniQuery);
begin
  try
    if (Aqry.FindParam('NUMROM') <> nil) then
      Aqry.ParamByName('NUMROM').AsString := FDocsNov.FieldByName('NUMROM').AsString;

    if (Aqry.FindParam('EMPROM') <> nil) then
      Aqry.ParamByName('EMPROM').AsString := FDocsNov.FieldByName('EMPROM').AsString;

    if (Aqry.FindParam('NUMDOC') <> nil) then
      Aqry.ParamByName('NUMDOC').AsString := FDocsNov.FieldByName('NUMDOC').AsString;

    if (Aqry.FindParam('ESPDOC') <> nil) then
      Aqry.ParamByName('ESPDOC').AsString := FDocsNov.FieldByName('ESPDOC').AsString;

    if (Aqry.FindParam('CODEMP') <> nil) then
      Aqry.ParamByName('CODEMP').AsString := FDocsNov.FieldByName('CODEMP').AsString;
  except
    raise;
  end;
end;

procedure TfrmFatRomaneioAdicionarDoctosNaoEntregues.splitterCanResize(
  Sender: TObject; var NewSize: Integer; var Accept: Boolean);
begin
  inherited;
  Accept := (pnlDocsAnt.Height >= 150) And (pnlDocsNov.Height >= 150);
end;

end.
