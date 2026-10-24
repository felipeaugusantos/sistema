unit untFatGerarNovoPreRomaneio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Grids,
  DBGrids, EditFocus, UniDataSetProvider, DB, UniClientDataSet, untAtualizaOcorrenciasCRM,
  Uni, Mask, DBCtrls, DBEditFocus, MaskEditFocus, strUtils, cxProgressBar,
  BitBtnLockedIncrem, MemDS, DBAccess, Provider, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxDataControllerConditionalFormattingRulesManagerDialog, untTLock;

type
  TfrmFatGerarNovoPreRomaneio = class(TfrmPai)
    pnlCabecalho: TPanel;
    lblRomaneio: TLabel;
    edtNumRom: TEditFocus;
    dtsDocsAnt: TDataSource;
    btnConfirma: TBitBtnLocked;
    dtsDocsNov: TDataSource;
    pnlDocsAnt: TPanel;
    Panel1: TPanel;
    pnlDocsNov: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    btnCancelar: TBitBtnLocked;
    splitter: TSplitter;
    Label2: TLabel;
    Label3: TLabel;
    btnIncluirRomNaoAti: TBitBtnLocked;
    cxgDocsAnt: TcxGrid;
    cxgDocsAntDados: TcxGridDBTableView;
    cxgDocsAntNivel: TcxGridLevel;
    cxgDocsAntDadosDTAENT: TcxGridDBColumn;
    cxgDocsAntDadosNUMROM: TcxGridDBColumn;
    cxgDocsAntDadosNUMPED: TcxGridDBColumn;
    cxgDocsAntDadosNUMFAT: TcxGridDBColumn;
    cxgDocsAntDadosNOMCLI: TcxGridDBColumn;
    cxgDocsAntDadosNOMCID: TcxGridDBColumn;
    cxgDocsAntDadosCODVEN: TcxGridDBColumn;
    cxgDocsAntDadosNOMTRA: TcxGridDBColumn;
    cxgDocsAntDadosVLRCON: TcxGridDBColumn;
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
    pnlDocVen: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    edtNFVend: TEditFocus;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure splitterCanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnIncluirRomNaoAtiClick(Sender: TObject);
    procedure cxgDocsAntDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgDocsNovDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    cdsDocsAnt, cdsDocsNov: TUniClientDataSet;
    strAceRom : String;
    objLock: TLock;

    Function fAtivaRomaneio(strCodTra,
                            strCodMot,
                            strCodAj1,
                            strCodAj2,
                            strCodAj3,
                            strCodAj4,
                            strObsFec,
                            strPlaVei,
                            strCodReg: String;
                            fltVlrFre,
                            fltVlrAdi,
                            fltPerFre: Double;
                            strNumRom: String): Boolean;

    procedure pCarregaDocumentos(strNumRom: String; blnCarregaNaoAtivos: Boolean = False; pgbStatus: TcxProgressBar = nil);
    function fCarregaDocumentos(pgbStatus: TcxProgressBar = Nil): Boolean;

    Function fRomaneioEncontrado: Boolean;

    function fGerarNovoPreRomaneio(pgbStatus: TcxProgressBar = nil): Boolean;

    procedure pGerarNovoPreRomaneio;
    function fGetTotalDocumentosNovo: Double;
    function fRetornaTransportadoraSugestao: String;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
  end;

var
  frmFatGerarNovoPreRomaneio: TfrmFatGerarNovoPreRomaneio;

implementation

uses untFuncoesSimples, untRomGer, untFatRomTransMot, untGravando, untFuncFat,
  untHisPed, untFuncoesCRM, untFuncoesRel, untTypesCRM;


{$R *.dfm}

{ TfrmFatBaixaRomaneio }

function TfrmFatGerarNovoPreRomaneio.fRetornaTransportadoraSugestao: String;
begin
  Result := '';

  cdsDocsNov.First;

  while not cdsDocsNov.Eof Do
  begin
    if (not fEmptyStr(cdsDocsNov.FieldByName('CODTRA').AsString)) then
    begin
      if fEmptyStr(Result) then
        Result := cdsDocsNov.FieldByName('CODTRA').AsString
      //Se houverem transportadoras diferentes nao deve carregar nenhuma como sugestao
      else if (Result <> cdsDocsNov.FieldByName('CODTRA').AsString) then
      begin
        Result := '';
        Break;
      end;
    end;

    cdsDocsNov.Next;
  end;

  cdsDocsNov.First;
end;

function TfrmFatGerarNovoPreRomaneio.fRomaneioEncontrado: Boolean;
  Var
    qryGen   : TUniQuery;
    strNumRom: String;
begin
  Try
    Result := False;
    qryGen := fCriaQuery;

    strNumRom := fTrataNumRom(edtNumRom);

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ');
      SQL.Add('  FGO_JAFATU, ');
      SQL.Add('  GER_STATUS  ');
      SQL.Add('FROM ');
      SQL.Add('  ROMGERX R INNER JOIN FATGOR G ON R.GER_CODEMP = G.FGO_CODEMP ');
      SQL.Add('                               AND R.GER_NUMDOC = G.FGO_NUMDOC ');
      SQL.Add('                               AND R.GER_ESPDOC = G.FGO_ESPDOC ');
      SQL.Add('                               AND R.GER_CODCLI = G.FGO_CODCLI ');
      SQL.Add('WHERE ');
      SQL.Add('   R.GER_EMPROM = :CODEMP AND ');

      If (strNumRom.Length > 6) Then
        SQL.Add('   R.GER_CODBAR = :NUMDOC ')
      Else
        SQL.Add('   R.GER_NUMROM = :NUMDOC ');

      SQL.Add('ORDER BY G.AUTOINCREM ');

      ParamByName('NUMDOC').AsString := strNumRom;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If Not IsEmpty Then
      Begin
        Result := True;

        First;
        While Not EOF Do
        Begin
          If (FieldByName('FGO_JAFATU').AsInteger = 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse romaneio não foi totalmente expedido!', ['&O k']);
            Result := False;
            Break;
          End;
          Next;
        End;

        If FieldByName('GER_STATUS').AsString = 'A' Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse romaneio já foi Ativado!', ['&O k']);
          Result := False;
        End;

      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Romaneio não encontrado!', ['&O k']);
        Result := False;
      End;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

end;

function TfrmFatGerarNovoPreRomaneio.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtNumRom) Then
  Begin
    blnMudarFoco := False;

    If Not fEmptyStr(edtNumRom.Text) Then
    Begin
      Result := fRomaneioEncontrado;

      If Result Then
        pCarregaDocumentos(fNumeroRomaneio(edtNumRom.Text));

      pSetFocus(edtNumRom);
      edtNumRom.Clear;
    End
    Else
      pSetFocus(cxgDocsAnt);
  End

  Else If (Sender = edtNFVend) Then
  Begin
    blnMudarFoco := False;

    If Not fEmptyStr(edtNFVend.Text) Then
    Begin
      If Not cdsDocsAnt.Locate('NUMVEN', edtNFVend.Text, []) Then
      Begin
        pMensagemOk('Documento de venda não encontrado!');
      End
      Else
      Begin
        pCopiaRegistroDataSet(cdsDocsAnt, cdsDocsNov);
        cdsDocsAnt.Delete;
      End;

      edtNFVend.Clear;
    End;
  End;

end;

procedure TfrmFatGerarNovoPreRomaneio.pCarregaDocumentos(strNumRom: String;
  blnCarregaNaoAtivos: Boolean = False; pgbStatus: TcxProgressBar = nil);
  Var
    strSQL: String;
    strChaRom: String;
    intIndRom: Integer;
    stlNumRom: TStringList;
    stlRomLib: TStringList;
    qryDocumentos: TUniQuery;
begin
  pProgresso(0, 0, pgbStatus);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GER_DTAENT AS DTAENT, ';
  strSQL := strSQL + '  GER_HORENT AS HORENT, ';
  strSQL := strSQL + '  GER_NUMROM AS NUMROM, ';
  strSQL := strSQL + '  GER_EMPROM AS EMPROM, ';
  strSQL := strSQL + '  CONCAT(GER_NUMDOC, "-", GER_ESPDOC, "-", GER_CODEMP) AS NUMPED, ';
  strSQL := strSQL + '  CONCAT(FGO_NUMFAT, "-", FGO_TIPFAT, "-", FGO_EMPFAT) AS NUMFAT, ';
  strSQL := strSQL + '  FGO_NUMFAT NUMVEN, ';
  strSQL := strSQL + '  GER_NUMDOC NUMDOC, ';
  strSQL := strSQL + '  GER_ESPDOC ESPDOC, ';
  strSQL := strSQL + '  GER_CODEMP CODEMP, ';
  strSQL := strSQL + '  GER_CODCLI CODCLI, ';
  strSQL := strSQL + '  IF(GER_NOMCON = "" OR GER_NOMCON IS NULL, CLI_NOMCLI, GER_NOMCON) NOMCLI, ';
  strSQL := strSQL + '  CID_NOMCID AS NOMCID, ';
  strSQL := strSQL + '  GER_CODVEN AS CODVEN, ';
  strSQL := strSQL + '  TRA_CODTRA AS CODTRA, ';
  strSQL := strSQL + '  TRA_NOMTRA AS NOMTRA, ';
  strSQL := strSQL + '  GER_VLRCON AS VLRCON, ';
  strSQL := strSQL + '  GER_STATUS AS STATUS  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ROMGERX ';
  strSQL := strSQL + '  LEFT JOIN FATGOR    ON FGO_NUMDOC = GER_NUMDOC AND ';
  strSQL := strSQL + '                         FGO_ESPDOC = GER_ESPDOC AND ';
  strSQL := strSQL + '                         FGO_CODEMP = GER_CODEMP AND ';
  strSQL := strSQL + '                         FGO_CODCLI = GER_CODCLI     ';
  strSQL := strSQL + '  LEFT JOIN CADTRA    ON TRA_CODTRA = GER_CODTRA ';
  strSQL := strSQL + '       JOIN CADCLI    ON GER_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '       JOIN CADCID    ON IF( GER_CIDCON IS NULL, CLI_CODCID, GER_CIDCON) = CID_CODCID ';
  strSQL := strSQL + 'WHERE ';

  If Not fEmptyStr(strNumRom) Then
  Begin
    strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
    strSQL := strSQL + '  GER_EMPROM = :EMPROM ';
  End
  Else
  Begin
    If Not blnCarregaNaoAtivos Then
      strSQL := strSQL + '  FALSE '
    Else
    Begin
      strSQL := strSQL + ' FGO_JAFATU = 1 AND ';
      strSQL := strSQL + ' GER_STATUS <> "A" ';
    End;
  End;

  strSQL := strSQL + ' AND LOCATE(FGO_CODEMP,' + QuotedStr(strAceRom) + ' ) > 0 ';

  strSQL := strSQL + 'ORDER BY NUMROM, EMPROM ';

  qryDocumentos := fCriaQuery(nil);

  With qryDocumentos Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If Not fEmptyStr(strNumRom) Then
    Begin
      ParamByName('NUMROM').AsString := strNumRom;
      ParamByName('EMPROM').AsString := VS_strCodEmp;
    End;

    Open;
  End;

  If Not Assigned(cdsDocsAnt) Then
  Begin
    cdsDocsAnt := fCriaClientDatset(qryDocumentos, True);
    dtsDocsAnt.DataSet := cdsDocsAnt;
  End;

  If Not Assigned(cdsDocsNov) Then
  Begin
    cdsDocsNov := fCriaClientDatset(qryDocumentos, True);
    dtsDocsNov.DataSet := cdsDocsNov;
  End;

  TFloatField(cdsDocsAnt.FieldByName('VLRCON')).DisplayFormat := '#,##0.00';
  TFloatField(cdsDocsNov.FieldByName('VLRCON')).DisplayFormat := '#,##0.00';

  {************************************************}
  {* MONTA UMA LISTA COM OS NUMEROS DOS ROMANEIOS *}
  {*********************************************JC*}
  stlNumRom := TStringList.Create;

  qryDocumentos.First;

  While Not qryDocumentos.Eof Do
  Begin
    pProgresso(qryDocumentos.RecNo, qryDocumentos.RecordCount, pgbStatus);

    If stlNumRom.IndexOf(qryDocumentos.FieldByName('NUMROM').AsString) = -1 Then
      stlNumRom.Add(qryDocumentos.FieldByName('NUMROM').AsString);

    qryDocumentos.Next;
  End;

  {*******************************************************************}
  {* PROCESSA OS ROMANEIOS VERIFICANDO SE JA NAO FORAM CARREGADOS    *}
  {* OU SE ESTAO SENDO USADOS POR OUTRA ESTACAO. CARREGA SOMENTE OS  *}
  {* QUE FORAM VALIDADOS EM UMA NOVA LISTA.                          *}
  {****************************************************************JC*}
  stlRomLib := TStringList.Create;

  For intIndRom := 0 To stlNumRom.Count -1 Do
  Begin
    pProgresso(intIndRom + 1, stlNumRom.Count, pgbStatus);

    strNumRom := stlNumRom[intIndRom];
    strChaRom := 'ROMANEIO_' + strNumRom + VS_strCodEmp;

    If cdsDocsAnt.Locate('NUMROM', strNumRom, []) Or cdsDocsNov.Locate('NUMROM', strNumRom, []) Then
      pMensagemOk('O romaneio ' + strNumRom + ' já foi carregado!')

    Else If Not objLock.fLock_Unlock(strChaRom, True, False) Then
      pMensagemOk('O romaneio ' + strNumRom + ' está sendo utilizado por outra estação: ' + fGetHostLock(strChaRom))

    Else
      stlRomLib.Add(strNumRom);
  End;

  {*********************************************************************}
  {* CARREGA NO CLIENTDATASET SOMENTE OS ROMANEIOS QUE FORAM VALIDADOS *}
  {******************************************************************JC*}
  qryDocumentos.First;

  While Not qryDocumentos.Eof Do
  Begin
    pProgresso(qryDocumentos.RecNo, qryDocumentos.RecordCount, pgbStatus);

    If stlRomLib.IndexOf(qryDocumentos.FieldByName('NUMROM').AsString) > -1 Then
      pCopiaRegistroDataSet(qryDocumentos, cdsDocsAnt);

    qryDocumentos.Next;
  End;

  pnlDocVen.Visible := Not cdsDocsAnt.IsEmpty;

  FreeAndNil(stlNumRom);
  FreeAndNil(stlRomLib);
  FreeAndNil(qryDocumentos);
end;

procedure TfrmFatGerarNovoPreRomaneio.splitterCanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  inherited;
  Accept := (pnlDocsAnt.Height >= 150) And (pnlDocsNov.Height >= 150);
end;

procedure TfrmFatGerarNovoPreRomaneio.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If cdsDocsNov.IsEmpty Then
  Begin
    pMensagemOk('Não há documentos selecionados!');
  End
  Else If fPergunta('Confirma emissão de um novo Romaneio ' +
                    'com os documentos selecionados?') Then
  Begin
    Try
      pGerarNovoPreRomaneio;
    Finally
      edtNumRom.Clear;
      If cdsDocsAnt.IsEmpty Then
        pSetFocus(edtNumRom)
      Else
        pSetFocus(cxgDocsAnt);
    End;
  End;
end;

procedure TfrmFatGerarNovoPreRomaneio.btnIncluirRomNaoAtiClick(Sender: TObject);
  Var
    frmAguarde: TfrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fCarregaDocumentos;
    frmAguarde.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pFreeAndNil(frmAguarde);

  If cdsDocsAnt.IsEmpty Then
    fMensagem('ATENÇÃO!', 'Não exite(m) romaneio(s) a serem carregados!', ['&O k']);
end;

procedure TfrmFatGerarNovoPreRomaneio.cxgDocsAntDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: pSetFocus(cxgDocsNov);
    VK_SPACE: Begin
                If Not cdsDocsAnt.IsEmpty {And fPergunta('Confirma selecionar este documento?')} Then
                Begin
                  pCopiaRegistroDataSet(cdsDocsAnt, cdsDocsNov);
                  cdsDocsAnt.Delete;
                End;
              End;
  End;
end;

procedure TfrmFatGerarNovoPreRomaneio.pGerarNovoPreRomaneio;
  Var
    frmAguarde: TfrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fGerarNovoPreRomaneio;
    frmAguarde.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  pFreeAndNil(frmAguarde);
end;

function TfrmFatGerarNovoPreRomaneio.fAtivaRomaneio(strCodTra, strCodMot,
  strCodAj1, strCodAj2, strCodAj3, strCodAj4, strObsFec, strPlaVei, strCodReg: String; fltVlrFre, fltVlrAdi,
  fltPerFre: Double; strNumRom: String): Boolean;
  Var
    strSQL   : String;
    qryGenGer: TUniQuery;
begin
  Try

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  ROMGERX ';
    strSQL := strSQL + 'SET ';

    If Not fEmptyStr(strCodTra) Then
      strSQL := strSQL + '  GER_CODTRA = :CODTRA, ';

    If Not fEmptyStr(strCodMot) Then
      strSQL := strSQL + '  GER_CODMOT = :CODMOT, ';

    If Not fEmptyStr(strCodAj1) Then
      strSQL := strSQL + '  GER_CODAJ1 = :CODAJ1, ';

    If Not fEmptyStr(strCodAj2) Then
      strSQL := strSQL + '  GER_CODAJ2 = :CODAJ2, ';

    If Not fEmptyStr(strCodAj3) Then
      strSQL := strSQL + '  GER_CODAJ3 = :CODAJ3, ';

    If Not fEmptyStr(strCodAj4) Then
      strSQL := strSQL + '  GER_CODAJ4 = :CODAJ4, ';

    If Not fEmptyStr(strObsFec) Then
      strSQL := strSQL + '  GER_OBSFEC = :OBSFEC, ';

    If Not fEmptyStr(strPlaVei) Then
      strSQL := strSQL + '  GER_PLAVEI = :PLAVEI, ';

    If Not fEmptyStr(strCodReg) Then
      strSQL := strSQL + '  GER_CODREG = :CODREG, ';

    strSQL := strSQL + '  GER_FRETE_ = :FRETE_, ';
    strSQL := strSQL + '  GER_ADIFRE = :ADIFRE, ';
    strSQL := strSQL + '  GER_PERFRE = :PERFRE, ';
    strSQL := strSQL + '  GER_PERFRE = :PERFRE, ';
    strSQL := strSQL + '  GER_DTAROM = :DTAROM, ';
    strSQL := strSQL + '  GER_HORROM = :HORROM, ';
    strSQL := strSQL + '  GER_STATUS = "A"      ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
    strSQL := strSQL + '  GER_EMPROM = :EMPROM ';

    qryGenGer := fCriaQuery;
    With qryGenGer Do
    Begin
      SQL.Add(strSQL);

      If Not fEmptyStr(strCodTra) Then
       ParamByName('CODTRA').AsString  := strCodTra;

      If Not fEmptyStr(strCodMot) Then
        ParamByName('CODMOT').AsString := strCodMot;

      If Not fEmptyStr(strCodAj1) Then
        ParamByName('CODAJ1').AsString := strCodAj1;

      If Not fEmptyStr(strCodAj2) Then
        ParamByName('CODAJ2').AsString := strCodAj2;

      If Not fEmptyStr(strCodAj3) Then
        ParamByName('CODAJ3').AsString := strCodAj3;

      If Not fEmptyStr(strCodAj4) Then
        ParamByName('CODAJ4').AsString := strCodAj4;

      If Not fEmptyStr(strObsFec) Then
        ParamByName('OBSFEC').AsString := strObsFec;

      If Not fEmptyStr(strPlaVei) Then
        ParamByName('PLAVEI').AsString := strPlaVei;

      If Not fEmptyStr(strCodReg) Then
        ParamByName('CODREG').AsString := strCodReg;

      ParamByName('FRETE_').AsFloat    := fltVlrFre;
      ParamByName('ADIFRE').AsFloat    := fltVlrAdi;
      ParamByName('PERFRE').AsFloat    := fltPerFre;
      ParamByName('NUMROM').AsString   := fNumeroRomaneio(strNumRom);
      ParamByName('EMPROM').AsString   := VS_strCodEmp;
      ParamByName('DTAROM').AsDate     := VS_date;
      ParamByName('HORROM').AsString   := TimeToStr(fRetHoraServidor);
      ExecSQL;
    End;
    FreeAndNil(qryGenGer);

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fAtivaRomaneio]');
    End;
  End;
end;

function TfrmFatGerarNovoPreRomaneio.fCarregaDocumentos(
  pgbStatus: TcxProgressBar): Boolean;
begin
  pInformacao('Aguarde, Carregando Romaneio(s)...', pgbStatus);
  objLock.pDestravarTodos;
  cdsDocsAnt.EmptyDataSet;
  cdsDocsNov.EmptyDataSet;
  pCarregaDocumentos('', True, pgbStatus);
  Result := True;
end;

function TfrmFatGerarNovoPreRomaneio.fGerarNovoPreRomaneio(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    qryUpd: TUniQuery;
    qryGer: TUniQuery;
    qryDet: TUniQuery;
    strNumRomNov: String;
    strCodTra,
    strCodMot,
    strCodAj1,
    strCodAj2,
    strCodAj3,
    strCodAj4,
    strObsFec,
    strPlaVei,
    strCodReg: String;
    fltVlrFre,
    fltVlrAdi,
    fltPerFre: Double;
    objHisPed: THisPed;
    objOcoCrm: TAtuOcoCrm;
    intCnt : Integer;
    strFieldName : String;
    blnAtivar: Boolean;
    frmFatRomTransMot : TfrmFatRomTransMot;
  procedure pSetaParametrosUpdate(qry: TUniQuery);
  begin
    If qry.FindParam('ROMNOV') <> Nil Then
      qry.ParamByName('ROMNOV').AsString := strNumRomNov;

    If qry.FindParam('NUMROM') <> Nil Then
      qry.ParamByName('NUMROM').AsString := cdsDocsNov.FieldByName('NUMROM').AsString;

    If qry.FindParam('EMPROM') <> Nil Then
      qry.ParamByName('EMPROM').AsString := cdsDocsNov.FieldByName('EMPROM').AsString;

    If qry.FindParam('NUMDOC') <> Nil Then
      qry.ParamByName('NUMDOC').AsString := cdsDocsNov.FieldByName('NUMDOC').AsString;

    If qry.FindParam('ESPDOC') <> Nil Then
      qry.ParamByName('ESPDOC').AsString := cdsDocsNov.FieldByName('ESPDOC').AsString;

    If qry.FindParam('CODEMP') <> Nil Then
      qry.ParamByName('CODEMP').AsString := cdsDocsNov.FieldByName('CODEMP').AsString;
  end;

  function fDefinirRoteiro: Boolean; begin
    Result := (fCfgSis('OPCROM', varInteger) = 1)   And
              (fCfgSis('USPRRO', varString)  = 'S') And
              (fCfgSis('GERPRO', varString)  = 'S') And
              (fCfgSis('ROMPAR', varString)  = 'N') And
              (fCfgSis('TIPEXP', varString)  = '5') And
              (fCfgSis('TPDCEX', varInteger) = 1);
  end;

begin
  Result := True;

  fltVlrFre := 0;
  fltVlrAdi := 0;
  fltPerFre := 0;

  blnAtivar := fPergunta('Deseja realizar a ativação do novo pré-romaneio?');

  if blnAtivar then
  begin
    pCriarFormularios(TfrmFatRomTransMot, frmFatRomTransMot);

    Try
      frmFatRomTransMot.edtCodTra.Text    := strCodTra;
      frmFatRomTransMot.edtCodMot.Text    := strCodMot;
      frmFatRomTransMot.edtCodAj1.Text    := strCodAj1;
      frmFatRomTransMot.edtCodAj2.Text    := strCodAj2;
      frmFatRomTransMot.edtCodAj3.Text    := strCodAj3;
      frmFatRomTransMot.edtCodAj4.Text    := strCodAj4;
      frmFatRomTransMot.mmoObsFec.Text    := strObsFec;
      frmFatRomTransMot.mskPlaVei.Text    := strPlaVei;
      frmFatRomTransMot.edtCodReg.Text    := '';
      frmFatRomTransMot.strCodRom         := '';
      frmFatRomTransMot.fltTotDoc         := fGetTotalDocumentosNovo;
      frmFatRomTransMot.edtVlrFrete.Text  := FloatToStrF(0, ffFixed, 12, 2);
      frmFatRomTransMot.edtVlrAdiant.Text := FloatToStrF(0, ffFixed, 12, 2);
      frmFatRomTransMot.edtPercFrete.Text := FloatToStrF(0, ffFixed, 12, 4);
      frmFatRomTransMot.btnRoteiro.Visible:= False;
      frmFatRomTransMot.ShowModal;

      If (frmFatRomTransMot.ModalResult = mrOk) Then
      Begin
        strCodTra := frmFatRomTransMot.edtCodTra.Text;
        strCodMot := frmFatRomTransMot.edtCodMot.Text;
        strCodAj1 := frmFatRomTransMot.edtCodAj1.Text;
        strCodAj2 := frmFatRomTransMot.edtCodAj2.Text;
        strCodAj3 := frmFatRomTransMot.edtCodAj3.Text;
        strCodAj4 := frmFatRomTransMot.edtCodAj4.Text;
        strObsFec := frmFatRomTransMot.mmoObsFec.Text;
        strPlaVei := fTiraCaracEspeciais(frmFatRomTransMot.mskPlaVei.Text);
        strCodReg := frmFatRomTransMot.edtCodReg.Text;
        fltVlrFre := fStrToFloat(frmFatRomTransMot.edtVlrFrete.Text);
        fltVlrAdi := fStrToFloat(frmFatRomTransMot.edtVlrAdiant.Text);
        fltPerFre := fStrToFloat(frmFatRomTransMot.edtPercFrete.Text);
      End
      Else
        Exit(False);
    Finally
      pFreeAndNil(frmFatRomTransMot);
    End;
  end;

  If fEmptyStr(strCodTra) Then
    strCodTra := fRetornaTransportadoraSugestao;

  qryGer := fCriaQuery(Self);
  qryDet := fCriaQuery(Self);
  qryUpd := fCriaQuery(Self);
  objHisPed := THisPed.Create(Self);

  Try
    Try
      If Not fStartTransaction Then
        Exit(False);

      strNumRomNov := fAtualizaProCod('ROMGERX', 'GER_NUMROM');

      pInformacao('Aguarde, Gravando Romaneio (' + strNumRomNov + ').', pgbStatus);

      cdsDocsNov.First;
      While Not cdsDocsNov.Eof Do
      Begin
        pProgresso(cdsDocsNov.RecNo, cdsDocsNov.RecordCount, pgbStatus);

        With qryGer Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(' SELECT * ');
          SQL.Add('   FROM ROMGERX ');
          SQL.Add('  WHERE GER_NUMROM = :NUMROM ');
          SQL.Add('    AND GER_EMPROM = :EMPROM ');
          SQL.Add('    AND GER_NUMDOC = :NUMDOC ');
          SQL.Add('    AND GER_ESPDOC = :ESPDOC ');
          SQL.Add('    AND GER_CODEMP = :CODEMP ');
          pSetaParametrosUpdate(qryGer);
          Open;
        End;

        With qryDet Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(' SELECT * ');
          SQL.Add('   FROM ROMDETX ');
          SQL.Add('  WHERE DET_NUMROM = :NUMROM ');
          SQL.Add('    AND DET_EMPROM = :EMPROM ');
          SQL.Add('    AND DET_NUMDOC = :NUMDOC ');
          SQL.Add('    AND DET_ESPDOC = :ESPDOC ');
          SQL.Add('    AND DET_CODEMP = :CODEMP ');
          pSetaParametrosUpdate(qryDet);
          Open;
        End;

        With qryUpd Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(' DELETE ');
          SQL.Add('   FROM ROMGERX ');
          SQL.Add('  WHERE GER_NUMROM = :NUMROM ');
          SQL.Add('    AND GER_EMPROM = :EMPROM ');
          SQL.Add('    AND GER_NUMDOC = :NUMDOC ');
          SQL.Add('    AND GER_ESPDOC = :ESPDOC ');
          SQL.Add('    AND GER_CODEMP = :CODEMP ');
          pSetaParametrosUpdate(qryUpd);
          ExecSQL;
        End;

        qryUpd.Close;
        qryUpd.SQL.Text := 'SELECT * FROM ROMGERX WHERE FALSE ';
        qryUpd.Open;

        qryUpd.Append;
        For intCnt := 0 To qryUpd.FieldCount-1 Do
        Begin
          strFieldName := qryUpd.Fields[intCnt].FieldName;
          If qryGer.FindField(  strFieldName ) <> Nil Then
            qryUpd.FieldByName( strFieldName ).Value := qryGer.FieldByName(  strFieldName ).Value;
        End;
        qryUpd.FieldByName('GER_NUMROM').AsString  := strNumRomNov;

        If (fDefinirRoteiro()) Then
          qryUpd.FieldByName('GER_ORDIMP').AsInteger := cdsDocsNov.RecNo;

        qryUpd.Post;

        qryUpd.Close;
        qryUpd.SQL.Text := 'SELECT * FROM ROMDETX WHERE FALSE ';
        qryUpd.Open;

        qryDet.First;
        While Not qryDet.Eof Do
        Begin
          qryUpd.Append;
          For intCnt := 0 To qryUpd.FieldCount-1 Do
          Begin
            strFieldName := qryUpd.Fields[intCnt].FieldName;
            If qryDet.FindField(  strFieldName ) <> Nil Then
              qryUpd.FieldByName( strFieldName ).Value := qryDet.FieldByName(  strFieldName ).Value;
          End;
          qryUpd.FieldByName('DET_NUMROM').AsString := strNumRomNov;
          qryUpd.Post;

          qryDet.Next;
        End;

        qryUpd.Close;
        qryUpd.SQL.Text := ' UPDATE FATGOR ' +
                           '   SET FGO_NUMROM = :ROMNOV ' +
                           ' WHERE FGO_NUMROM = :NUMROM AND ' +
                           '       FGO_NUMDOC = :NUMDOC AND ' +
                           '       FGO_ESPDOC = :ESPDOC AND ' +
                           '       FGO_CODEMP = :CODEMP     ' ;

        pSetaParametrosUpdate(qryUpd);
        qryUpd.ExecSQL;

        Result := objHisPed.fGravarHistorico(cdsDocsNov.FieldByName('NUMDOC').AsString,
                                             cdsDocsNov.FieldByName('ESPDOC').AsString,
                                             cdsDocsNov.FieldByName('CODEMP').AsString,
                                             cdsDocsNov.FieldByName('NUMROM').AsString,
                                             VS_Date,
                                             fTime(),
                                             strCodMot,
                                             strCodTra);

        If (VS_strHabilitarCRM) And (Not fEmptyStr(fCfgSis('VENORC', varString))) And (Not fEmptyStr(fCfgSis('VENPED', varString))) Then
        Begin
          objOcoCrm := fAtualizaInformacoesCRM(cdsDocsNov.FieldByName('NUMDOC').AsString,
                                               cdsDocsNov.FieldByName('ESPDOC').AsString,
                                               cdsDocsNov.FieldByName('CODEMP').AsString,
                                               cdsDocsNov.FieldByName('CODCLI').AsString,
                                               cdsDocsNov.FieldByName('NUMROM').AsString,
                                               strCodMot + ' - ' + strCodTra,
                                               cdsDocsNov.FieldByName('CODVEN').AsString,
                                               afcRomaneioInclusao);

          TAtuOcoCrm(objOcoCrm).pProcessaFatOcorrenciasCRM;
        End;

        If Not Result Then
          Break;

        cdsDocsNov.Next;
      End;

      if blnAtivar then
        Result := Result And fAtivaRomaneio(strCodTra, strCodMot, strCodAj1, strCodAj2, strCodAj3, strCodAj4, strObsFec,
                                            strPlaVei, strCodReg, fltVlrFre, fltVlrAdi, fltPerFre, strNumRomNov);

      If Result Then
        fCommit
      Else
        fRollback;

      if not fCfgSis('ROMEDI', varBoolean) then
        pImprimirRomaneio(fNumeroRomaneio(strNumRomNov))

      else if Assigned(prcExecutaRelatorio) then
        prcExecutaRelatorio(13, 1361, [1361, 1371],
                            ['NUMROM', 'EMPROM'],
                            [fNumeroRomaneio(strNumRomNov), VS_strCodEmp],
                            btnConfirma);

      If Result Then
        pMensagemOk('Romaneio Nº ' + strNumRomNov + ' gravado e ativado com sucesso!');

      cdsDocsNov.First;
      While Not cdsDocsNov.Eof Do
      Begin
        objLock.fLock_Unlock('ROMANEIO_' + cdsDocsNov.FieldByName('NUMROM').AsString + VS_strCodEmp, False, False);
        cdsDocsNov.Next;
      End;

      cdsDocsNov.EmptyDataSet;
    Except
      On E: Exception Do
      Begin
        fRollback;
        Result := False;
        pMensagensErro(E.Message, '[TfrmFatGerarNovoPreRomaneio.fGerarNovoPreRomaneio]');
      End;
    End;
  Finally
    FreeAndNil(qryUpd);
    FreeAndNil(qryGer);
    FreeAndNil(qryDet);
    FreeAndNil(objHisPed);
  End;
end;

procedure TfrmFatGerarNovoPreRomaneio.cxgDocsNovDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: pSetFocus(cxgDocsAnt);
    VK_DELETE: Begin
                 If Not cdsDocsNov.IsEmpty {And fPergunta('Confirma remover este documento?')} Then
                 Begin
                   pCopiaRegistroDataSet(cdsDocsNov, cdsDocsAnt);
                   cdsDocsNov.Delete;
                 End;
               End;
  End;
end;

procedure TfrmFatGerarNovoPreRomaneio.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumRom);
end;

procedure TfrmFatGerarNovoPreRomaneio.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Assigned(cdsDocsAnt) Then FreeAndNil(cdsDocsAnt);
  If Assigned(cdsDocsNov) Then FreeAndNil(cdsDocsNov);
  FreeAndNil(objLock);
end;

procedure TfrmFatGerarNovoPreRomaneio.FormCreate(Sender: TObject);
begin
  inherited;
  edtNFVend.TamCampo  := fTamDocCadRec;
  edtNFVend.MaxLength := fTamDocCadRec;
  objLock := TLock.Create;

  pConfiguraPopup(btnConfirma);
end;

procedure TfrmFatGerarNovoPreRomaneio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F3    : btnCancelar.Click;
    VK_F5    : btnIncluirRomNaoAti.Click;
    VK_F10   : btnConfirma.Click;
    VK_ESCAPE: Begin
                 If edtNumRom.Focused  Then btnSairClick(Sender)
                 Else If cxgDocsNovDados.Focused Then pSetFocus(cxgDocsAnt)
                 Else pSetFocus(edtNumRom);
               End;
  End;
end;

procedure TfrmFatGerarNovoPreRomaneio.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaDocumentos('');//Utilizado para criar a estrutura dos clientDataSets
  strAceRom := fCampoTabela('OPE_EMPROM', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]);
  pnlDocVen.Visible := False;
end;

function TfrmFatGerarNovoPreRomaneio.fGetTotalDocumentosNovo: Double;
begin
  Result := 0;
  cdsDocsNov.First;
  While Not cdsDocsNov.Eof Do
  Begin
    Result := Result + cdsDocsNov.FieldByName('VLRCON').AsFloat;
    cdsDocsNov.Next;
  End;
end;

procedure TfrmFatGerarNovoPreRomaneio.btnCancelarClick(Sender: TObject);
begin
  inherited;
  objLock.pDestravarTodos;
  cdsDocsAnt.EmptyDataSet;
  cdsDocsNov.EmptyDataSet;
  pSetFocus(edtNumRom);
  edtNumRom.Clear;
end;

end.
