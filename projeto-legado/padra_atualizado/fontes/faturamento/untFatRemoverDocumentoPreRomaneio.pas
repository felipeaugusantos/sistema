unit untFatRemoverDocumentoPreRomaneio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  Vcl.ExtCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, Vcl.StdCtrls,
  EditFocus, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, BitBtnLockedIncrem, Uni, UniClientDataSet, cxProgressBar, strUtils;

type
  TfrmFatRemoverDocumentoPreRomaneio = class(TfrmPai)
    pnlCabecalho: TPanel;
    lblRomaneio: TLabel;
    Label3: TLabel;
    edtNumRom: TEditFocus;
    pnlDocsAnt: TPanel;
    Label1: TLabel;
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
    btnConfirma: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure splitterCanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxgDocsAntDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgDocsNovDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FDocsAnt,
    FDocsDel: TUniClientDataSet;
    FAceRom : String;

    procedure pCarregaDocumentos(ANumRom: String; ACarregaNaoAtivos: Boolean = False; AStatus: TcxProgressBar = nil);
    procedure pRemoverDocumentosPreRomaneio;
    procedure pSetaParametrosUpdate(AQry: TUniQuery);

    function fRomaneioEncontrado: Boolean;
    function fRemoverDocumentosPreRomaneio(AStatus: TcxProgressBar = nil): Boolean;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untFuncoesSimples, untRomGer, untFatRomTransMot, untFuncFat, untHisPed, 
  untFuncoesCRM, untGravando;

{$R *.dfm}

{ TfrmFatRemoverDocumentoPreRomaneio }

procedure TfrmFatRemoverDocumentoPreRomaneio.btnCancelarClick(Sender: TObject);
begin
  inherited;
  pDestravarTodosLocksConexaoAtual;
  FDocsAnt.EmptyDataSet;
  FDocsDel.EmptyDataSet;
  pSetFocus(edtNumRom);
  edtNumRom.Clear;
end;

procedure TfrmFatRemoverDocumentoPreRomaneio.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  if FDocsDel.IsEmpty then
    pMensagemOk('Não há documentos selecionados!')
  else if fPergunta('Confirma remover o(s) documento(s) selecionado(s) do pré-romaneio?') then
  begin
    try
      pRemoverDocumentosPreRomaneio;
    finally
      edtNumRom.Clear;

      if FDocsAnt.IsEmpty then
        pSetFocus(edtNumRom)
      else
        pSetFocus(cxgDocsAnt);
    end;
  end;
end;

procedure TfrmFatRemoverDocumentoPreRomaneio.cxgDocsAntDadosKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  
  case Key of
    VK_RETURN: pSetFocus(cxgDocsNov);
    VK_SPACE: 
      begin
        if (not FDocsAnt.IsEmpty) then
        begin
          if fEmptyStr(FDocsAnt.FieldByName('NUMFAT').AsString) then
          begin
            pCopiaRegistroDataSet(FDocsAnt, FDocsDel);
            FDocsAnt.Delete;
          end
          else
            pMensagemOk('Documento já foi faturado, não é possível remover o mesmo do pré-romaneio!');
        end;
      end;
  end;
end;

procedure TfrmFatRemoverDocumentoPreRomaneio.cxgDocsNovDadosKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_RETURN: pSetFocus(cxgDocsAnt);
    VK_DELETE: 
      begin
        if (not FDocsDel.IsEmpty) then
        begin
          pCopiaRegistroDataSet(FDocsDel, FDocsAnt);
          FDocsDel.Delete;
        end;
      end;
  end;
end;

procedure TfrmFatRemoverDocumentoPreRomaneio.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumRom);
end;

procedure TfrmFatRemoverDocumentoPreRomaneio.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pDestravarTodosLocksConexaoAtual;

  if Assigned(FDocsAnt) then 
    FreeAndNil(FDocsAnt);

  if Assigned(FDocsDel) then 
    FreeAndNil(FDocsDel);
end;

procedure TfrmFatRemoverDocumentoPreRomaneio.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  
  case Key of
    VK_F3    : btnCancelar.Click;
    VK_F10   : btnConfirma.Click;
    VK_ESCAPE: 
      begin
        if edtNumRom.Focused then 
          btnSairClick(Sender)
        else if cxgDocsNovDados.Focused then 
          pSetFocus(cxgDocsAnt)
        else 
          pSetFocus(edtNumRom);
      end;
  end;
end;

procedure TfrmFatRemoverDocumentoPreRomaneio.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaDocumentos('');//Utilizado para criar a estrutura dos clientDataSets
  FAceRom := fCampoTabela('OPE_EMPROM', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]);
end;

function TfrmFatRemoverDocumentoPreRomaneio.fRemoverDocumentosPreRomaneio(AStatus: TcxProgressBar): Boolean;
var
  LUpd: TUniQuery;
begin
  Result := True;

  LUpd := fCriaQuery(Self);

  try
    try
      if Not fStartTransaction then
        Exit(False);

      pInformacao('Aguarde, Removendo documento(s) ...', AStatus);

      FDocsDel.First;

      While Not FDocsDel.Eof Do
      begin
        pProgresso(FDocsDel.RecNo, FDocsDel.RecordCount, AStatus);

        LUpd.Close;
        LUpd.SQL.Clear;
        LUpd.SQL.Add('DELETE FROM ROMGERX ');
        LUpd.SQL.Add('WHERE GER_NUMROM = :NUMROM ');
        LUpd.SQL.Add('  AND GER_EMPROM = :EMPROM ');
        LUpd.SQL.Add('  AND GER_NUMDOC = :NUMDOC ');
        LUpd.SQL.Add('  AND GER_ESPDOC = :ESPDOC ');
        LUpd.SQL.Add('  AND GER_CODEMP = :CODEMP ');
        pSetaParametrosUpdate(LUpd);
        LUpd.ExecSQL;

        LUpd.Close;
        LUpd.SQL.Text := ' UPDATE FATGOR ' +
                         ' SET FGO_NUMROM = NULL, ' +
                         '     FGO_VALROM = 0 ' +
                         ' WHERE FGO_NUMROM = :NUMROM ' +
                         '   AND FGO_NUMDOC = :NUMDOC ' +
                         '   AND FGO_ESPDOC = :ESPDOC ' +
                         '   AND FGO_CODEMP = :CODEMP ' ;

        pSetaParametrosUpdate(LUpd);
        LUpd.ExecSQL;

        LUpd.Close;
        LUpd.SQL.Text := ' UPDATE FATDOR ' +
                         ' SET FDO_QTDROM = 0 ' +
                         ' WHERE FDO_NUMDOC = :NUMDOC ' +
                         '   AND FDO_ESPDOC = :ESPDOC ' +
                         '   AND FDO_CODEMP = :CODEMP ' ;

        pSetaParametrosUpdate(LUpd);
        LUpd.ExecSQL;

        if Not Result then
          Break;

        FDocsDel.Next;
      end;

      if Result then
        fCommit
      else
        fRollback;

      if Result then
        pMensagemOk('Documento(s) removido(s) com sucesso!');

      FDocsDel.First;
      While Not FDocsDel.Eof Do
      begin
        fLock_Unlock('ROMANEIO_' + FDocsDel.FieldByName('NUMROM').AsString + VS_strCodEmp, False, False);
        FDocsDel.Next;
      end;

      FDocsDel.EmptyDataSet;
    Except
      On E: Exception Do
      begin
        fRollback;
        Result := False;
        pMensagensErro(E.Message, '[TfrmFatRemoverDocumentoPreRomaneio.fRemoverDocumentosPreRomaneio]');
      end;
    end;
  finally
    FreeAndNil(LUpd);
  end;
end;

function TfrmFatRemoverDocumentoPreRomaneio.fRomaneioEncontrado: Boolean;
var
  LQry   : TUniQuery;
  LNumRom: String;
begin
  try
    Result := False;
    LQry := fCriaQuery;

    if (LeftStr(edtNumRom.Text,1) = '1') then
      LNumRom := edtNumRom.Text
    else
      LNumRom := RightStr(edtNumRom.Text,6);

    LQry.Close;
    LQry.SQL.Clear;
    LQry.SQL.Add('SELECT ');
    LQry.SQL.Add('  FGO_JAFATU, ');
    LQry.SQL.Add('  GER_STATUS  ');
    LQry.SQL.Add('FROM ');
    LQry.SQL.Add('  ROMGERX R INNER JOIN FATGOR G ON R.GER_CODEMP = G.FGO_CODEMP ');
    LQry.SQL.Add('                               AND R.GER_NUMDOC = G.FGO_NUMDOC ');
    LQry.SQL.Add('                               AND R.GER_ESPDOC = G.FGO_ESPDOC ');
    LQry.SQL.Add('                               AND R.GER_CODCLI = G.FGO_CODCLI ');
    LQry.SQL.Add('WHERE ');
    LQry.SQL.Add('   R.GER_EMPROM = :CODEMP AND ');

    if (LeftStr(edtNumRom.Text,1) = '1') then
      LQry.SQL.Add('   R.GER_CODBAR = :NUMDOC ')
    else
      LQry.SQL.Add('   R.GER_NUMROM = :NUMDOC ');

    LQry.SQL.Add('ORDER BY G.AUTOINCREM ');

    LQry.ParamByName('NUMDOC').AsString := LNumRom;
    LQry.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQry.Open;

    Result := Not LQry.IsEmpty;

    if Not Result then
      fMensagem('ATENÇÃO!', 'Romaneio não encontrado!', ['&O k']);

    if Result And (LQry.FieldByName('GER_STATUS').AsString = 'A') then
    begin
      fMensagem('ATENÇÃO!', 'Esse romaneio já foi Ativado!', ['&O k']);
      Result := False;
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

function TfrmFatRemoverDocumentoPreRomaneio.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (Sender = edtNumRom) then
  begin
    blnMudarFoco := False;

    if Not fEmptyStr(edtNumRom.Text) then
    begin
      edtNumRom.Text := fTrataNumRom(edtNumRom);
      Result := fRomaneioEncontrado;

      if Result then
        pCarregaDocumentos(fNumeroRomaneio(edtNumRom.Text));

      pSetFocus(edtNumRom);
      edtNumRom.Clear;
    end
    else
      pSetFocus(cxgDocsAnt);
  end;
end;

procedure TfrmFatRemoverDocumentoPreRomaneio.pCarregaDocumentos(ANumRom: String;
  ACarregaNaoAtivos: Boolean; AStatus: TcxProgressBar);
var
  LSQL: String;
  LChaRom: String;
  LIndRom: Integer;
  LLstRom: TStringList;
  LLstLib: TStringList;
  LQry: TUniQuery;
begin
  LQry    := fCriaQuery(nil);
  LLstRom := TStringList.Create;
  LLstLib := TStringList.Create;

  try
    pProgresso(0, 0, AStatus);

    LSQL := '';
    LSQL := LSQL + 'SELECT ';
    LSQL := LSQL + '  GER_DTAENT AS DTAENT, ';
    LSQL := LSQL + '  GER_HORENT AS HORENT, ';
    LSQL := LSQL + '  GER_NUMROM AS NUMROM, ';
    LSQL := LSQL + '  GER_EMPROM AS EMPROM, ';
    LSQL := LSQL + '  CONCAT(GER_NUMDOC, "-", GER_ESPDOC, "-", GER_CODEMP) AS NUMPED, ';
    LSQL := LSQL + '  CONCAT(FGO_NUMFAT, "-", FGO_TIPFAT, "-", FGO_EMPFAT) AS NUMFAT, ';
    LSQL := LSQL + '  FGO_NUMFAT NUMVEN, ';
    LSQL := LSQL + '  GER_NUMDOC NUMDOC, ';
    LSQL := LSQL + '  GER_ESPDOC ESPDOC, ';
    LSQL := LSQL + '  GER_CODEMP CODEMP, ';
    LSQL := LSQL + '  GER_CODCLI CODCLI, ';
    LSQL := LSQL + '  IF(GER_NOMCON = "" OR GER_NOMCON IS NULL, CLI_NOMCLI, GER_NOMCON) NOMCLI, ';
    LSQL := LSQL + '  CID_NOMCID AS NOMCID, ';
    LSQL := LSQL + '  GER_CODVEN AS CODVEN, ';
    LSQL := LSQL + '  TRA_CODTRA AS CODTRA, ';
    LSQL := LSQL + '  TRA_NOMTRA AS NOMTRA, ';
    LSQL := LSQL + '  GER_VLRCON AS VLRCON, ';
    LSQL := LSQL + '  GER_STATUS AS STATUS  ';
    LSQL := LSQL + 'FROM ';
    LSQL := LSQL + '  ROMGERX ';
    LSQL := LSQL + '  LEFT JOIN FATGOR    ON FGO_NUMDOC = GER_NUMDOC AND ';
    LSQL := LSQL + '                         FGO_ESPDOC = GER_ESPDOC AND ';
    LSQL := LSQL + '                         FGO_CODEMP = GER_CODEMP AND ';
    LSQL := LSQL + '                         FGO_CODCLI = GER_CODCLI     ';
    LSQL := LSQL + '  LEFT JOIN CADTRA    ON TRA_CODTRA = GER_CODTRA ';
    LSQL := LSQL + '       JOIN CADCLI    ON GER_CODCLI = CLI_CODCLI ';
    LSQL := LSQL + '       JOIN CADCID    ON IF( GER_CIDCON IS NULL, CLI_CODCID, GER_CIDCON) = CID_CODCID ';
    LSQL := LSQL + 'WHERE ';

    if Not fEmptyStr(ANumRom) then
    begin
      LSQL := LSQL + '  GER_NUMROM = :NUMROM AND ';
      LSQL := LSQL + '  GER_EMPROM = :EMPROM ';
    end
    else
    begin
      if Not ACarregaNaoAtivos then
        LSQL := LSQL + '  FALSE '
      else
      begin
        LSQL := LSQL + ' FGO_JAFATU = 1 AND ';
        LSQL := LSQL + ' GER_STATUS <> "A" ';
      end;
    end;

    LSQL := LSQL + ' AND LOCATE(FGO_CODEMP,' + QuotedStr(FAceRom) + ' ) > 0 ';
    LSQL := LSQL + 'ORDER BY NUMROM, EMPROM ';

    LQry.Close;
    LQry.SQL.Clear;
    LQry.SQL.Add(LSQL);

    if Not fEmptyStr(ANumRom) then
    begin
      LQry.ParamByName('NUMROM').AsString := ANumRom;
      LQry.ParamByName('EMPROM').AsString := VS_strCodEmp;
    end;

    LQry.Open;

    if Not Assigned(FDocsAnt) then
    begin
      FDocsAnt := fCriaClientDatset(LQry, True);
      dtsDocsAnt.DataSet := FDocsAnt;
    end;

    if Not Assigned(FDocsDel) then
    begin
      FDocsDel := fCriaClientDatset(LQry, True);
      dtsDocsNov.DataSet := FDocsDel;
    end;

    TFloatField(FDocsAnt.FieldByName('VLRCON')).DisplayFormat := '#,##0.00';
    TFloatField(FDocsDel.FieldByName('VLRCON')).DisplayFormat := '#,##0.00';

    {************************************************}
    {* MONTA UMA LISTA COM OS NUMEROS DOS ROMANEIOS *}
    {*********************************************JC*}
    LQry.First;

    While Not LQry.Eof Do
    begin
      pProgresso(LQry.RecNo, LQry.RecordCount, AStatus);

      if LLstRom.IndexOf(LQry.FieldByName('NUMROM').AsString) = -1 then
        LLstRom.Add(LQry.FieldByName('NUMROM').AsString);

      LQry.Next;
    end;

    {*******************************************************************}
    {* PROCESSA OS ROMANEIOS VERIFICANDO SE JA NAO FORAM CARREGADOS    *}
    {* OU SE ESTAO SendO USADOS POR OUTRA ESTACAO. CARREGA SOMENTE OS  *}
    {* QUE FORAM VALIDADOS EM UMA NOVA LISTA.                          *}
    {****************************************************************JC*}
    For LIndRom := 0 To LLstRom.Count -1 Do
    begin
      pProgresso(LIndRom + 1, LLstRom.Count, AStatus);

      ANumRom := LLstRom[LIndRom];
      LChaRom := 'ROMANEIO_' + ANumRom + VS_strCodEmp;

      if FDocsAnt.Locate('NUMROM', ANumRom, []) Or FDocsDel.Locate('NUMROM', ANumRom, []) then
        pMensagemOk('O romaneio ' + ANumRom + ' já foi carregado!')

      else if Not fLock_Unlock(LChaRom, True, False) then
        pMensagemOk('O romaneio ' + ANumRom + ' está sendo utilizado por outra estação: ' + fGetHostLock(LChaRom))

      else
        LLstLib.Add(ANumRom);
    end;

    {*********************************************************************}
    {* CARREGA NO CLIENTDATASET SOMENTE OS ROMANEIOS QUE FORAM VALIDADOS *}
    {******************************************************************JC*}
    LQry.First;

    While Not LQry.Eof Do
    begin
      pProgresso(LQry.RecNo, LQry.RecordCount, AStatus);

      if LLstLib.IndexOf(LQry.FieldByName('NUMROM').AsString) > -1 then
        pCopiaRegistroDataSet(LQry, FDocsAnt);

      LQry.Next;
    end;
  finally
    FreeAndNil(LLstRom);
    FreeAndNil(LLstLib);
    FreeAndNil(LQry);
  end;
end;

procedure TfrmFatRemoverDocumentoPreRomaneio.pRemoverDocumentosPreRomaneio;
begin
  try
    fChamaTelaGravando(fRemoverDocumentosPreRomaneio, 'Aguarde...');
  except
    on E: Exception do
      pMensagensErro(E.Message, '');
  end;
end;

procedure TfrmFatRemoverDocumentoPreRomaneio.pSetaParametrosUpdate(AQry: TUniQuery);
begin
  if AQry.FindParam('NUMROM') <> nil then
    AQry.ParamByName('NUMROM').AsString := FDocsDel.FieldByName('NUMROM').AsString;

  if AQry.FindParam('EMPROM') <> nil then
    AQry.ParamByName('EMPROM').AsString := FDocsDel.FieldByName('EMPROM').AsString;

  if AQry.FindParam('NUMDOC') <> nil then
    AQry.ParamByName('NUMDOC').AsString := FDocsDel.FieldByName('NUMDOC').AsString;

  if AQry.FindParam('ESPDOC') <> nil then
    AQry.ParamByName('ESPDOC').AsString := FDocsDel.FieldByName('ESPDOC').AsString;

  if AQry.FindParam('CODEMP') <> nil then
    AQry.ParamByName('CODEMP').AsString := FDocsDel.FieldByName('CODEMP').AsString;
end;

procedure TfrmFatRemoverDocumentoPreRomaneio.splitterCanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  inherited;
  Accept := (pnlDocsAnt.Height >= 150) And (pnlDocsNov.Height >= 150);
end;

end.
