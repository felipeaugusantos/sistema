unit untFatAtivaPreRomaneio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Grids,
  DBGridCitel, DBGrids, EditFocus, UniDataSetProvider, DB, UniClientDataSet, untAtualizaOcorrenciasCRM,
  Uni, Mask, DBCtrls, DBEditFocus, MaskEditFocus, strUtils,
  BitBtnLockedIncrem, MemDS, DBAccess, Provider, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient, cxProgressBar;

type
  TfrmFatAtivaPreRomaneio = class(TfrmPai)
    pnlCabecalho: TPanel;
    lblRomaneio: TLabel;
    edtNumRom: TEditFocus;
    dbgDocumentos: TDBGridCitel;
    dtsDocumentos: TDataSource;
    cdsDocumentos: TUniClientDataSet;
    dspDocumentos: TUniDataSetProvider;
    qryDocumentos: TUniQuery;
    btnConfirma: TBitBtnLocked;
    qryItens: TUniQuery;
    dspItens: TUniDataSetProvider;
    cdsItens: TUniClientDataSet;
    dtsItens: TDataSource;
    lblAviso: TLabel;
    btnGerarNovoPreRomaneio: TBitBtnLocked;
    btnCancelarAtivacao: TBitBtnLocked;
    btnAdicionarNaoEntregues: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure cdsDocumentosAfterOpen(DataSet: TDataSet);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnGerarNovoPreRomaneioClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarAtivacaoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAdicionarNaoEntreguesClick(Sender: TObject);

  private
    { Private declarations }
    FNumRom,
    FCodMot,
    FCodTra: String;
    FDtaRom: TDate;
    FHorRom: TTime;

    strAceRom : String;

    cdsRomRet: TUniClientDataSet;
    FOutDig: TUniClientDataSet;

    procedure pLimparRomaneio;
    procedure pCarregaDocumentos;
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
                            strAltEnd: String): Boolean;

    Function fDesAtivaRomaneio: Boolean;

    Function fRomaneioEncontrado: Boolean;
    function fGravaHistoricoProgress(ProgressBar: TcxProgressBar): Boolean;


    procedure pAtualizarOrdemImpressao;
    procedure pRetornaTransMot(var strCodTra,
                               strCodMot,
                               strCodAj1,
                               strCodAj2,
                               strCodAj3,
                               strCodAj4,
                               strObsFec,
                               strPlaVei,
                               strCodReg: string;
                               var fltVlrFre,
                               fltVlrAdi,
                               fltPerFre: Double);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untRomGer, untFatRomTransMot, untFatGerarNovoPreRomaneio,
  untHisPed, untFuncoesCRM, untGravando, untDisparaEmailAut, untFuncoes,
  untFuncoesRel, untTypesCRM, untFuncFat, untTypesSistema, untGravaRomaneio,
  untFatRomaneioAdicionarDoctosNaoEntregues;

{$R *.dfm}

{ TfrmFatBaixaRomaneio }

function TfrmFatAtivaPreRomaneio.fRomaneioEncontrado: Boolean;
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

      if fCfgSis('RMPDPA', varBoolean) then
      begin
        SQL.Add('SELECT');
        SQL.Add('  DET_JAFATU AS FGO_JAFATU, DET_NUMDOC AS FGO_NUMDOC, DET_CODEMP AS FGO_CODEMP, DET_ESPDOC AS FGO_ESPDOC');  //
        SQL.Add('FROM');
        SQL.Add('  ROMGERX R');
        SQL.Add('  INNER JOIN ROMDETX D');
        SQL.Add('    ON DET_SEQGER = R.AUTOINCREM');
        SQL.Add('WHERE ');
        SQL.Add('   R.GER_EMPROM = :CODEMP AND ');

        If (strNumRom.Length > 6) Then
          SQL.Add('   R.GER_CODBAR = :NUMDOC ')
        Else
          SQL.Add('   R.GER_NUMROM = :NUMDOC ');
      end
      else
      begin
        SQL.Add('SELECT ');
        SQL.Add('  G.FGO_JAFATU, G.FGO_NUMDOC, G.FGO_ESPDOC, G.FGO_CODEMP ');
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
      end;

      ParamByName('NUMDOC').AsString := strNumRom;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If Not IsEmpty Then
      Begin
        While Not EOF Do
        Begin
          If (FieldByName('FGO_JAFATU').AsInteger = 0) and
             (not fDocParcialmenteFat(
               FieldByName('FGO_NUMDOC').AsString,
               FieldByName('FGO_ESPDOC').AsString,
               FieldByName('FGO_CODEMP').AsString)) Then
          Begin
            Result := False;
            Last;
          End
          Else
            Result := True;

          Next;
        End;

        If Not Result Then
          fMensagem('ATENÇÃO!', 'Esse romaneio não foi totalmente expedido!', ['&O k']);
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

function TfrmFatAtivaPreRomaneio.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtNumRom) Then
  Begin
    If Not fRomaneioEncontrado Then
      Result := False
    Else
    Begin
      pCarregaDocumentos;
      btnGerarNovoPreRomaneio.Enabled := False;
      btnAdicionarNaoEntregues.Enabled := False;
      lblAviso.Visible := cdsDocumentos.FieldByName('GER_STATUS').AsString = 'A';
      btnCancelarAtivacao.Enabled := lblAviso.Visible And fVerificaAcessoSistema('CANATI');

      If lblAviso.Visible Then
        btnConfirma.Caption := '[ F10 ] Reimprimir Pré-Romaneio'
      Else
        btnConfirma.Caption := '[ F10 ] Ativar Pré-Romaneio';
    End;
  End;

  If (Not Result) Then
  Begin
    pLimparRomaneio;
    pSetFocus(Sender);
  End;
end;

procedure TfrmFatAtivaPreRomaneio.pAtualizarOrdemImpressao;
  var
    strSQL: String;
    qryUpdateOrdem : TUniQuery;
begin
  qryUpdateOrdem := fCriaQuery(Self);
  try
    cdsDocumentos.First;
    while Not cdsDocumentos.Eof do
    begin
      if cdsDocumentos.FieldByName('GER_ORDIMP').AsInteger > 0 then
      begin
        strSQL := '';
        strSQL := strSQL + ' UPDATE ROMGERX ';
        strSQL := strSQL + '    SET GER_ORDIMP = ' + cdsDocumentos.FieldByName('GER_ORDIMP').AsString;
        strSQL := strSQL + '  WHERE GER_NUMROM = ' + QuotedStr(cdsDocumentos.FieldByName('GER_NUMROM').AsString);
        strSQL := strSQL + '    AND GER_EMPROM = ' + QuotedStr(cdsDocumentos.FieldByName('GER_EMPROM').AsString);
        strSQL := strSQL + '    AND GER_NUMDOC = ' + QuotedStr(cdsDocumentos.FieldByName('GER_DOCORI').AsString);
        strSQL := strSQL + '    AND GER_ESPDOC = ' + QuotedStr(cdsDocumentos.FieldByName('GER_ESPORI').AsString);
        strSQL := strSQL + '    AND GER_CODEMP = ' + QuotedStr(cdsDocumentos.FieldByName('GER_CODEMP').AsString);
        strSQL := strSQL + '    AND GER_CODCLI = ' + QuotedStr(cdsDocumentos.FieldByName('GER_CLIORI').AsString);
        qryUpdateOrdem.SQL.Text := strSQL;
        qryUpdateOrdem.ExecSQL;
      end;
      cdsDocumentos.Next;
    end;
  finally
    FreeAndNil(qryUpdateOrdem);
  end;
end;

procedure TfrmFatAtivaPreRomaneio.pCarregaDocumentos;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GER_ROMIMP, ';
  strSQL := strSQL + '  GER_DTAENT, ';
  strSQL := strSQL + '  GER_HORENT, ';
  strSQL := strSQL + '  CONCAT(GER_NUMDOC, "-", GER_ESPDOC) GER_NUMDOC, ';
  strSQL := strSQL + '  GER_NUMDOC GER_DOCORI, ';
  strSQL := strSQL + '  GER_ESPDOC GER_ESPORI, ';
  strSQL := strSQL + '  GER_CODCLI GER_CLIORI, ';
  strSQL := strSQL + '  GER_CODEMP, ';
  strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI', 'GER_NOMCON', 'CLI_NOMCLI') + ' AS GER_NOMCLI, ';
  strSQL := strSQL + '  CADCID.CID_NOMCID, ';
  strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI', 'GER_BAICON', 'IF(IFNULL(AUX_ENTGER, "") = "", CLI_BAIRRO, ETC_BAIENT)') + ' AS GER_BAICON, ';

  strSQL := strSQL + '  IF(ROMGERX.GER_CIDENT IS NOT NULL, ';
  strSQL := strSQL + '     CIDENT.CID_NOMCID, ';
  strSQL := strSQL + '     CADCID.CID_NOMCID) AS GER_NOMCID, ';

  strSQL := strSQL + '  IF(GER_CIDENT IS NOT NULL, ';
  strSQL := strSQL + '     CIDENT.CID_ESTADO, ';
  strSQL := strSQL + '     CADCID.CID_ESTADO) AS GER_ESTADO, ';

  strSQL := strSQL + '  IF(GER_BAIENT IS NOT NULL, ';
  strSQL := strSQL + '     ROMGERX.GER_BAIENT, ';
  strSQL := strSQL +       fSQLIFClienteConsumidor('CLI_NOMCLI', 'GER_BAICON', 'IF(IFNULL(AUX_ENTGER, "") = "", CLI_BAIRRO, ETC_BAIENT)') + ') AS GER_BAIRRO, ';

  strSQL := strSQL + '  IF(GER_ENDENT IS NOT NULL, ';
  strSQL := strSQL + '     ROMGERX.GER_ENDENT, ';
  strSQL := strSQL +       fSQLIFClienteConsumidor('CLI_NOMCLI', 'GER_ENDCON', 'IF(IFNULL(AUX_ENTGER, "") <> "", ETC_ENDENT, ' +
                     '     CONCAT(CLI_ENDERE, ' +
                     '     IF(IFNULL(CLI_ENDNUM, "") = ""," ", CONCAT(", ", CLI_ENDNUM)), ' +
                     '     IF(IFNULL(CLI_ENDCOM, "") = "","", CONCAT(" ", CLI_ENDCOM)))) ') + ') AS GER_ENDCON, ';

  strSQL := strSQL + '  IF(GER_LATLON IS NOT NULL, ';
  strSQL := strSQL + '     GER_LATLON, ';
  strSQL := strSQL +       fSQLIFClienteConsumidor('CLI_NOMCLI', '""', 'IF(IFNULL(AUX_ENTGER, "") = "", "", ETC_LATLON)') + ') AS GER_LATLON, ';

  strSQL := strSQL + '  IF(GER_CEPENT IS NOT NULL, ';
  strSQL := strSQL + '     ROMGERX.GER_CEPENT, ';
  strSQL := strSQL +       fSQLIFClienteConsumidor('CLI_NOMCLI', 'GER_CEPCON', 'IF(IFNULL(AUX_ENTGER, "") = "", CLI_C_E_P_, ETC_CEPENT)') + ') AS GER_CEPCON, ';

  strSQL := strSQL + '  IF(GER_CIDENT IS NOT NULL, ';
  strSQL := strSQL + '     ROMGERX.GER_CIDENT, ';
  strSQL := strSQL +       fSQLIFClienteConsumidor('CLI_NOMCLI', 'GER_CIDCON', 'IF(IFNULL(AUX_ENTGER, "") = "", CLI_CODCID, ETC_CIDENT)') + ') AS CID_CODCID, ';

  strSQL := strSQL + fRetSQLSeqRotaRegiao(' IF(GER_CIDENT IS NOT NULL, GER_CIDENT, '+fSQLIFClienteConsumidor('CLI_NOMCLI', 'GER_CIDCON', 'IF(IFNULL(AUX_ENTGER, "") = "", CLI_CODCID, ETC_CIDENT)')+') ');

  strSQL := strSQL + '  GER_CODVEN, ';
  strSQL := strSQL + '  TRA_NOMTRA, ';
  strSQL := strSQL + '  GER_VLRCON, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ1, "-", A1.AJU_NOMAJU) AJU_NOMAJ1, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ2, "-", A2.AJU_NOMAJU) AJU_NOMAJ2, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ3, "-", A3.AJU_NOMAJU) AJU_NOMAJ3, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ4, "-", A4.AJU_NOMAJU) AJU_NOMAJ4, ';
  strSQL := strSQL + '  GER_NUMROM, ';
  strSQL := strSQL + '  GER_NOMREC, ';
  strSQL := strSQL + '  "M" GER_MARDES, ';
  strSQL := strSQL + '  FGO_NUMDOC, ';
  strSQL := strSQL + '  FGO_ESPDOC, ';
  strSQL := strSQL + '  IF(FGO_CODEMP IS NULL OR FGO_CODEMP = "", GER_CODEMP, FGO_CODEMP) FGO_CODEMP, ';
  strSQL := strSQL + '  ROMGERX.AUTOINCREM, ';
  strSQL := strSQL + '  GER_FRETE_,  ';
  strSQL := strSQL + '  GER_ADIFRE,  ';
  strSQL := strSQL + '  GER_PERFRE,  ';
  strSQL := strSQL + '  GER_CODREG,  ';
  strSQL := strSQL + '  GER_DTABAI,  ';
  strSQL := strSQL + '  GER_STATUS,  ';
  strSQL := strSQL + '  GER_ORDIMP,  ';
  strSQL := strSQL + '  0 AS ORDIMP, ';
  strSQL := strSQL + '  GER_EMPROM,  ';
  strSQL := strSQL + '  GER_ESPDOC,  ';
  strSQL := strSQL + '  TRA_NOMTRA AS GER_TRANSP, ';
  strSQL := strSQL + '  REPEAT(" ", 10000) GER_OBSERV, ';
  strSQL := strSQL + '  GER_AUTINC, ';
  strSQL := strSQL + '  CAST(0 AS DATE) AS GER_DTENTR, ';
  strSQL := strSQL + '  CAST("" AS CHAR(1)) AS GER_ENTSAI, ';
  strSQL := strSQL + '  " " AS FIS_ACESSO, ';
  strSQL := strSQL + '  GER_VLRCON AS GER_VALDOC, ';
  strSQL := strSQL + '  GER_VLRCON AS GER_VALSEL, ';
  strSQL := strSQL + '  GER_NOMTAB AS GER_NOMTBL, ';
  strSQL := strSQL + '  0.0000 GER_TOTDET, ';
  strSQL := strSQL + '  0 INCREMENTO ';

  if fCfgSis('MATDIS', varBoolean) then
  begin
    strSQL := strSQL + ', GER_LOCALI ';
    strSQL := strSQL + ', GER_DISTAN ';
    strSQL := strSQL + ', GER_TMPENT ';
    strSQL := strSQL + ', CAST(" " AS CHAR(50)) AS TEMPOENTREGA ';
    strSQL := strSQL + ', CAST(" " AS CHAR(50)) AS DISTAENTREGA ';
    strSQL := strSQL + ', CAST(" " AS CHAR(50)) AS TEMPOACUMULADO ';
    strSQL := strSQL + ', CAST(" " AS CHAR(50)) AS DISTACUMULADA ';
    strSQL := strSQL + ', GER_PRIORI AS PRIORIDADE ';
    strSQL := strSQL + ', GER_LIBAPP ';
    strSQL := strSQL + ', GER_EVITAR ';
    strSQL := strSQL + ', CAST(" " AS CHAR(3)) AS CARGANAFILIAL ';
    strSQL := strSQL + ', GER_FILIAL ';
    strSQL := strSQL + ', GER_INIPAR ';
    strSQL := strSQL + ', GER_FINROT ';
    strSQL := strSQL + ', CAST(" " AS CHAR(80)) AS BKP_ENDCON ';
    strSQL := strSQL + ', CAST(" " AS CHAR(30)) AS BKP_BAIRRO ';
    strSQL := strSQL + ', CAST(" " AS CHAR(40)) AS BKP_NOMCID ';
    strSQL := strSQL + ', CAST(" " AS CHAR(2))  AS BKP_ESTADO ';
    strSQL := strSQL + ', CAST(" " AS CHAR(8))  AS BKP_CEPCON ';
    strSQL := strSQL + ', CAST(" " AS CHAR(5))  AS BKP_CODCID ';
    strSQL := strSQL + ', GER_FSTSHT ';
  end;

  strSQL := strSQL + ', GER_ALTEND ';
  strSQL := strSQL + ', CAST(" " AS CHAR(1)) AS BKP_ALTEND ';

  strSQL := strSQL + ', GER_PESBRU ';
  strSQL := strSQL + ', GER_VOLUME ';
  strSQL := strSQL + ', GER_NUMROM AS GER_NROROM ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ROMGERX ';
  strSQL := strSQL + '  LEFT JOIN FATGOR    ON FGO_NUMDOC = GER_NUMDOC AND ';
  strSQL := strSQL + '                         FGO_ESPDOC = GER_ESPDOC AND ';
  strSQL := strSQL + '                         FGO_CODEMP = GER_CODEMP AND ';
  strSQL := strSQL + '                         FGO_CODCLI = GER_CODCLI     ';
  strSQL := strSQL + '  LEFT JOIN CADTRA    ON TRA_CODTRA = GER_CODTRA ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A1 ON GER_CODAJ1 = A1.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A2 ON GER_CODAJ2 = A2.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A3 ON GER_CODAJ3 = A3.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A4 ON GER_CODAJ4 = A4.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN AUXGOR ON AUX_SEQGER = FATGOR.AUTOINCREM ';
  strSQL := strSQL + '  LEFT JOIN ENTCLI ON ENTCLI.AUTOINCREM = AUX_ENTGER ';
  strSQL := strSQL + '       JOIN CADCLI    ON GER_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = ' + fSQLIFClienteConsumidor('CLI_NOMCLI', 'GER_CIDCON',
                                                             'IF(IFNULL(AUX_ENTGER, "") = "", GER_CIDCON, ETC_CIDENT) ');

  {***************************************}
  {* OBTEM O ENDEREÇO DE ENTREGA ROMGERX *}
  {*************************************BL}
  strSQL := strSQL + 'LEFT JOIN CADCID CIDENT ON (GER_CIDENT = CIDENT.CID_CODCID) ';

  strSQL := strSQL + 'LEFT JOIN CADREG ON REG_CODREG = IF(GER_CODREG IS NOT NULL, '+
                                                        ' GER_CODREG, '+
                                                          fSQLIFClienteConsumidor('CLI_NOMCLI', 'GER_CODREG', 'IF(IFNULL(AUX_ENTGER, "") = "", CLI_CODREG, ETC_CODREG)')+
                                                        ' )';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
  strSQL := strSQL + '  GER_EMPROM = :EMPROM AND ';
  strSQL := strSQL + '  LOCATE(FGO_CODEMP,' + QuotedStr(strAceRom) + ' ) > 0 ';

  cdsDocumentos.Close;

  With qryDocumentos Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMROM').AsString := fNumeroRomaneio(edtNumRom.Text);
    ParamByName('EMPROM').AsString := VS_strCodEmp;
    Open;
  End;

  pSetaClient(qryDocumentos);

  With cdsDocumentos Do
  Begin
    Open;
    pSetaClient(cdsDocumentos);
    DisableControls;

    While (Not Eof) Do
    Begin
      Edit;
      FieldByName('GER_OBSERV').AsString := '';
      Post;
      Next;
    End;
    First;
    EnableControls;
  End;
end;

procedure TfrmFatAtivaPreRomaneio.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumRom);
end;

procedure TfrmFatAtivaPreRomaneio.FormCreate(Sender: TObject);
begin
  inherited;
  btnGerarNovoPreRomaneio.Visible := (Not fCfgSis('ROMPAR', varBoolean)) And fCfgSis('GERPRO', varBoolean);
  btnAdicionarNaoEntregues.Visible := (Not fCfgSis('ROMPAR', varBoolean)) And fCfgSis('GERPRO', varBoolean);
  btnCancelarAtivacao.Enabled := False;
  strAceRom := fCampoTabela('OPE_EMPROM', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]);

  pConfiguraPopup(btnConfirma);

  cdsRomRet := TUniClientDataSet.Create(Self);
  cdsRomRet.FieldDefs.Add('RET_DISTAN', ftFloat);
  cdsRomRet.FieldDefs.Add('RET_TMPRET', ftFloat);
  cdsRomRet.CreateDataSet;

  FOutDig := fCriaDataSetOutDig;
end;

procedure TfrmFatAtivaPreRomaneio.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsRomRet);
  FreeAndNil(FOutDig);
end;

procedure TfrmFatAtivaPreRomaneio.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
   VK_F10   : btnConfirma.Click;
   VK_F2    : btnGerarNovoPreRomaneio.Click;
   VK_F3    : btnAdicionarNaoEntregues.Click;
   VK_F4    : btnCancelarAtivacao.Click;
   VK_ESCAPE: If dbgDocumentos.Focused Then
              Begin
                pLimparRomaneio;
                pSetFocus(edtNumRom);
              End
              Else
                btnSairClick(Sender);
  End;
end;

procedure TfrmFatAtivaPreRomaneio.btnGerarNovoPreRomaneioClick(Sender: TObject);
begin
  inherited;
  If btnGerarNovoPreRomaneio.Visible And btnGerarNovoPreRomaneio.Enabled Then
    pCriarForm(TfrmFatGerarNovoPreRomaneio, frmFatGerarNovoPreRomaneio);
end;

procedure TfrmFatAtivaPreRomaneio.btnAdicionarNaoEntreguesClick(Sender: TObject);
begin
  inherited;

  if (not btnAdicionarNaoEntregues.Visible) then
    Exit;

  if (not btnAdicionarNaoEntregues.Enabled) then
    Exit;

  pCriarForm(TfrmFatRomaneioAdicionarDoctosNaoEntregues);
end;

procedure TfrmFatAtivaPreRomaneio.btnCancelarAtivacaoClick(Sender: TObject);
begin
  inherited;

  If Not btnCancelarAtivacao.Enabled Then
    Exit;

  If (cdsDocumentos.FieldByName('GER_DTABAI').AsDatetime > 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é possível cancelar a ativação deste romaneio,' + #13 +
                          'pois o mesmo já foi baixado', ['&O k']);
    Exit;
  End;

  Try
    fStartTransaction;

    If fDesAtivaRomaneio Then
    Begin
      fMensagem('', 'Ativação do Romaneio Nº ' + fNumeroRomaneio(edtNumRom.Text) + ' cancelada com sucesso!', ['&Ok']);
      fCommit;
      pLimparRomaneio;
    End
    Else
      fRollback;

    pSetFocus(edtNumRom);

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmFatRomaneio.btnCancelarAtivacaoClick]');
      fRollback;
    End;

  End;
end;

procedure TfrmFatAtivaPreRomaneio.btnConfirmaClick(Sender: TObject);
  Var
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
    fltPerFre,
    fltTotDoc: Double;
    frmFatRomTransMot : TfrmFatRomTransMot;
    blnComita: Boolean;
    arrDuplicataCND: TarrDuplicata;
    strNumRomaneio,
    strAutInc: String;
begin
  inherited;

  blnComita := False;

  If Not cdsDocumentos.Active Then
    Exit;

  {*************************************}
  {* CALCULA O VALOR TOTAL DOS PEDIDOS *}
  {**********************************MM*}
  fltTotDoc := 0.00;
  With cdsDocumentos Do
  Begin
    First;
    While Not EOF Do
    Begin
      fltTotDoc := fltTotDoc + FieldByName('GER_VLRCON').AsFloat;
      Next;
    End;
  End;

  If fltTotDoc = 0 Then
    Exit;

  If lblAviso.Visible Then
  Begin
    If (fMensagem('ATENÇÃO!', 'Reimprime Romaneio?', ['&Sim', '&Não'], 1) = 1) Then
    Begin
      if not fCfgSis('ROMEDI', varBoolean) then
        pImprimirRomaneio(fNumeroRomaneio(edtNumRom.Text))

      else if Assigned(prcExecutaRelatorio) then
        prcExecutaRelatorio(13, 1361, [1361, 1371],
                            ['NUMROM', 'EMPROM'],
                            [fNumeroRomaneio(edtNumRom.Text), VS_strCodEmp],
                            Sender);

      pLimparRomaneio;
    End;
  End
  Else
  Begin

    If (fMensagem('ATENÇÃO!', 'Confirma ativação do Pré-Romaneio?', ['&Sim', '&Não'], 2) = 2) Then
      Exit;

    pRetornaTransMot(strCodTra, strCodMot, strCodAj1, strCodAj2,
                     strCodAj3, strCodAj4, strObsFec, strPlaVei,
                     strCodReg, fltVlrFre, fltVlrAdi, fltPerFre);

    {*******************************************}
    {* TELA DA TRANSPORTADORA / MOTORISTA      *}
    {****************************************MV*}
    Try
      pCriarFormularios(TfrmFatRomTransMot, frmFatRomTransMot);
      frmFatRomTransMot.cdsTmpDoc         := cdsDocumentos;
      frmFatRomTransMot.cdsOutDig         := FOutDig;
      frmFatRomTransMot.edtCodTra.Text    := strCodTra;
      frmFatRomTransMot.edtCodMot.Text    := strCodMot;
      frmFatRomTransMot.edtCodAj1.Text    := strCodAj1;
      frmFatRomTransMot.edtCodAj2.Text    := strCodAj2;
      frmFatRomTransMot.edtCodAj3.Text    := strCodAj3;
      frmFatRomTransMot.edtCodAj4.Text    := strCodAj4;
      frmFatRomTransMot.mmoObsFec.Text    := strObsFec;
      frmFatRomTransMot.mskPlaVei.Text    := strPlaVei;
      frmFatRomTransMot.edtCodReg.Text    := cdsDocumentos.FieldByName('GER_CODREG').AsString;
      frmFatRomTransMot.strCodRom         := fNumeroRomaneio(edtNumRom.Text);
      frmFatRomTransMot.fltTotDoc         := fltTotDoc;
      frmFatRomTransMot.edtVlrFrete.Text  := FloatToStrF(cdsDocumentos.FieldByName('GER_FRETE_').AsFloat, ffFixed, 12, 2);
      frmFatRomTransMot.edtVlrAdiant.Text := FloatToStrF(cdsDocumentos.FieldByName('GER_ADIFRE').AsFloat, ffFixed, 12, 2);
      frmFatRomTransMot.edtPercFrete.Text := FloatToStrF(cdsDocumentos.FieldByName('GER_PERFRE').AsFloat, ffFixed, 12, 4);
      frmFatRomTransMot.cdsRomRet         := cdsRomRet;
      frmFatRomTransMot.ShowModal;

      If (frmFatRomTransMot.ModalResult = mrOk) Then
      Begin
        blnComita := True;

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

        fStartTransaction;

        pInsereOutDigXDefinicaoRotas(FOutDig, cdsDocumentos);

        if fCfgSis('MATDIS', varBoolean) then
        begin
          cdsDocumentos.First;
          while not cdsDocumentos.Eof do
          begin
            if (cdsDocumentos.FieldByName('GER_ESPDOC').AsString = 'OX') and
               (cdsDocumentos.FieldByName('GER_FILIAL').AsString = 'S') then
            begin
              strNumRomaneio := fNumeroRomaneio(edtNumRom.Text);
              blnComita := blnComita and fGravaRomGer(strNumRomaneio,                                     // Número do Romaneio (Referencia)
                                                      strAutInc,                                          // Auto Incremento (Referência)
                                                      cdsDocumentos.FieldByName('GER_NUMDOC').AsString,   // Documento
                                                      cdsDocumentos.FieldByName('GER_ESPDOC').AsString,   // Espécie
                                                      cdsDocumentos.FieldByName('GER_CODEMP').AsString,   // Empresa
                                                      strCodTra,                                          // Transportadora
                                                      cdsDocumentos.FieldByName('GER_CODVEN').AsString,   // Vendedor
                                                      '',                                                 // Fornecedor
                                                      '',                                                 // Cliente
                                                      'C',                                                // Tipo (Cliente / Fornecedor)
                                                      cdsDocumentos.FieldByName('GER_DTAENT').AsDateTime, // Data de Entrada
                                                      cdsDocumentos.FieldByName('GER_HORENT').AsDateTime, // Hora de Entrada
                                                      0,                                                  // Data do Documento
                                                      '',                                                 // Condição de Pagamento
                                                      '',                                                 // Estado
                                                      '',                                                 // Nome Cliente Consumidor
                                                      '',                                                 // Endereço Cliente Consumidor
                                                      '',                                                 // Bairro Cliente Consumidor
                                                      '',                                                 // CEP Cliente Consumidor
                                                      '',                                                 // Cidade Cliente Consumidor
                                                      '',                                                 // Estado Cliente Consumidor
                                                      '',                                                 // Telefone Cliente Consumidor
                                                      '',                                                 // CGC/CPF Cliente Consumidor
                                                      '',                                                 // CNPJ Cliente Consumidor
                                                      '',                                                 // Inscrição Estadual Cliente Consumidor
                                                      '',                                                 // RG Cliente Consumidor
                                                      '',                                                 // Romaneio já impresso?
                                                      0,                                                  // Base Simples Paulista
                                                      0,                                                  // Base IPI
                                                      0,                                                  // Aliquota IPI
                                                      0,                                                  // Total de IPI
                                                      0,                                                  // Base de ICMS
                                                      0,                                                  // Aliquota de ICMS
                                                      0,                                                  // Total de ICMS
                                                      0,                                                  // Total Retido
                                                      0,                                                  // Aliquota Retido
                                                      0,                                                  // Base Retido
                                                      0,                                                  // Desconto Especial
                                                      0,                                                  // Valor Contabil
                                                      0,                                                  // Total dos Produtos
                                                      0,                                                  // Total de Custo
                                                      0,                                                  // Total Médio
                                                      '',                                                 // Tipo de Frete
                                                      0,                                                  // Total do Frete
                                                      0,                                                  // Peso Bruto
                                                      0,                                                  // Peso Líquido
                                                      0,                                                  // Volume
                                                      '',                                                 // Espécie
                                                      '',                                                 // Marca
                                                      cdsDocumentos.FieldByName('GER_NOMCLI').AsString,   // Mensagem 01
                                                      '',                                                 // Mensagem 02
                                                      False,                                              // Ja Faturado?
                                                      '',                                                 // Tipo de Faturamento
                                                      '',                                                 // Numero do Faturamento
                                                      0,                                                  // Data do Faturamento
                                                      '',                                                 // Vendedor do Faturamento
                                                      '',                                                 // Condição do Faturamento
                                                      0.0,                                                // Valor do Faturamento
                                                      0.0,                                                // Valor da Parcela 01
                                                      0.0,                                                // Valor da Parcela 02
                                                      0.0,                                                // Valor da Parcela 03
                                                      0.0,                                                // Valor da Parcela 04
                                                      0.0,                                                // Valor da Parcela 05
                                                      0.0,                                                // Valor da Parcela 06
                                                      0.0,                                                // Valor da Parcela 07
                                                      0.0,                                                // Valor da Parcela 08
                                                      0.0,                                                // Valor da Parcela 09
                                                      0.0,                                                // Valor da Parcela 10
                                                      0.0,                                                // Valor da Parcela 11
                                                      0.0,                                                // Valor da Parcela 12
                                                      arrDuplicataCND,
                                                      '',                                                 // Série
                                                      '',                                                 // Nota Especial
                                                      '',                                                 // Classificação Fiscal
                                                      0,
                                                      '',                                                 // Digitador
                                                      '',                                                 // Código da Condição de Pagamento
                                                      '',                                                 // Código da Forma de Pagamento
                                                      strPlaVei,                                          //Placa do veiculo
                                                      strCodMot,                                          // Motorista
                                                      strCodAj1,                                          // Ajudante 1
                                                      strCodAj2,                                          // Ajudante 2
                                                      strCodAj3,                                          // Ajudante 3
                                                      strCodAj4,                                          // Ajudante 4
                                                      strObsFec,                                          // Observação Fechamento do Romaneio
                                                      strCodReg,                                          // Região
                                                      VS_Date,                                            // Data do Romaneio
                                                      fTime(),                                            // Hora do Romaneio
                                                      strLoginUsuarioLogado,                              // Operador que realizou o romaneio
                                                      cdsDocumentos.FieldByName('GER_ORDIMP').AsInteger,  // Ordem de Impressao
                                                      0.0,                                                // Valor original do
                                                      strLoginUsuarioLogado,                              // Operador Solicitante
                                                      '',                                                 // Ref de Endereco de Entrega
                                                      fltVlrFre,
                                                      fltVlrAdi,
                                                      fltPerFre,
                                                      '',
                                                      '',
                                                      'A',
                                                      '',
                                                      cdsDocumentos.FieldByName('GER_NOMTBL').AsString,
                                                      cdsDocumentos.FieldByName('GER_ENTSAI').AsString,
                                                      cdsDocumentos.FieldByName('GER_AUTINC').AsString,
                                                      '',
                                                      '',
                                                      '',
                                                      '',
                                                      cdsDocumentos.FieldByName('GER_LOCALI').AsString,
                                                      cdsDocumentos.FieldByName('GER_LIBAPP').AsString,
                                                      cdsDocumentos.FieldByName('GER_EVITAR').AsString,
                                                      cdsDocumentos.FieldByName('GER_DISTAN').AsFloat,
                                                      cdsDocumentos.FieldByName('GER_TMPENT').AsFloat,
                                                      cdsDocumentos.FieldByName('GER_ENDCON').AsString,
                                                      cdsDocumentos.FieldByName('GER_BAIRRO').AsString,
                                                      cdsDocumentos.FieldByName('GER_CEPCON').AsString,
                                                      cdsDocumentos.FieldByName('CID_CODCID').AsString,
                                                      '',
                                                      cdsDocumentos.FieldByName('GER_FILIAL').AsString,
                                                      cdsDocumentos.FieldByName('GER_INIPAR').AsString,
                                                      '',
                                                      '',
                                                      'N',
                                                      nil,
                                                      cdsDocumentos.FieldByName('GER_LATLON').AsString,
                                                      cdsDocumentos.FieldByName('PRIORIDADE').AsInteger,
                                                      'N',
                                                      '',
                                                      0,
                                                      0,
                                                      cdsDocumentos.FieldByName('GER_FSTSHT').AsString,
                                                      cdsDocumentos.FieldByName('GER_FINROT').AsString);

            end
            else
              blnComita := blnComita and fGravaRota(cdsDocumentos.FieldByName('AUTOINCREM').AsString,
                                                    cdsDocumentos.FieldByName('GER_LOCALI').AsString,
                                                    cdsDocumentos.FieldByName('GER_LIBAPP').AsString,
                                                    cdsDocumentos.FieldByName('GER_EVITAR').AsString,
                                                    cdsDocumentos.FieldByName('GER_FILIAL').AsString,
                                                    cdsDocumentos.FieldByName('GER_INIPAR').AsString,
                                                    cdsDocumentos.FieldByName('GER_LATLON').AsString,
                                                    cdsDocumentos.FieldByName('GER_ORDIMP').AsInteger,
                                                    cdsDocumentos.FieldByName('GER_DISTAN').AsFloat,
                                                    cdsDocumentos.FieldByName('GER_TMPENT').AsFloat,
                                                    cdsDocumentos.FieldByName('PRIORIDADE').AsInteger,
                                                    cdsDocumentos.FieldByName('GER_FSTSHT').AsString,
                                                    cdsDocumentos.FieldByName('GER_FINROT').AsString);

            cdsDocumentos.Next;
          end;

          blnComita := blnComita and fAtivaRomaneio(strCodTra, strCodMot, strCodAj1, strCodAj2, strCodAj3, strCodAj4,
                                                    strObsFec, strPlaVei, strCodReg, fltVlrFre, fltVlrAdi, fltPerFre,
                                                    cdsDocumentos.FieldByName('GER_ALTEND').AsString);

          blnComita := blnComita and fGravaRomRet(cdsRomRet, fNumeroRomaneio(edtNumRom.Text), VS_strCodEmp);
        end
        else
        begin
          blnComita := fAtivaRomaneio(strCodTra, strCodMot, strCodAj1, strCodAj2, strCodAj3, strCodAj4,
                                      strObsFec, strPlaVei, strCodReg, fltVlrFre, fltVlrAdi, fltPerFre,
                                      cdsDocumentos.FieldByName('GER_ALTEND').AsString);

          if blnComita then
            pAtualizarOrdemImpressao;
        end;
      End
      Else
      Begin
        if fCfgSis('MATDIS', varBoolean) then
        begin
          try
            cdsDocumentos.Filtered := False;

            cdsDocumentos.Filter := 'TRIM(BKP_ENDCON) <> '+QuotedStr('')+' OR '+
                                    'TRIM(BKP_BAIRRO) <> '+QuotedStr('')+' OR '+
                                    'TRIM(BKP_NOMCID) <> '+QuotedStr('')+' OR '+
                                    'TRIM(BKP_ESTADO) <> '+QuotedStr('')+' OR '+
                                    'TRIM(BKP_CEPCON) <> '+QuotedStr('');

            cdsDocumentos.Filtered := True;

            cdsDocumentos.First;
            while not cdsDocumentos.Eof do
            begin
              cdsDocumentos.Edit;

              if not fEmptyStr(cdsDocumentos.FieldByName('BKP_ENDCON').AsString) then
                cdsDocumentos.FieldByName('GER_ENDCON').AsString := cdsDocumentos.FieldByName('BKP_ENDCON').AsString;

              if not fEmptyStr(cdsDocumentos.FieldByName('BKP_BAIRRO').AsString) then
                cdsDocumentos.FieldByName('GER_BAIRRO').AsString := cdsDocumentos.FieldByName('BKP_BAIRRO').AsString;

              if not fEmptyStr(cdsDocumentos.FieldByName('BKP_NOMCID').AsString) then
                cdsDocumentos.FieldByName('GER_NOMCID').AsString := cdsDocumentos.FieldByName('BKP_NOMCID').AsString;

              if not fEmptyStr(cdsDocumentos.FieldByName('BKP_ESTADO').AsString) then
                cdsDocumentos.FieldByName('GER_ESTADO').AsString := cdsDocumentos.FieldByName('BKP_ESTADO').AsString;

              if not fEmptyStr(cdsDocumentos.FieldByName('BKP_CEPCON').AsString) then
                cdsDocumentos.FieldByName('GER_CEPCON').AsString := cdsDocumentos.FieldByName('BKP_CEPCON').AsString;

              if not fEmptyStr(cdsDocumentos.FieldByName('BKP_CODCID').AsString) then
                cdsDocumentos.FieldByName('CID_CODCID').AsString := cdsDocumentos.FieldByName('BKP_CODCID').AsString;

              if not fEmptyStr(cdsDocumentos.FieldByName('BKP_ALTEND').AsString) then
                cdsDocumentos.FieldByName('GER_ALTEND').AsString := cdsDocumentos.FieldByName('BKP_ALTEND').AsString;

              cdsDocumentos.FieldByName('BKP_ENDCON').AsString := EmptyStr;
              cdsDocumentos.FieldByName('BKP_BAIRRO').AsString := EmptyStr;
              cdsDocumentos.FieldByName('BKP_NOMCID').AsString := EmptyStr;
              cdsDocumentos.FieldByName('BKP_ESTADO').AsString := EmptyStr;
              cdsDocumentos.FieldByName('BKP_CEPCON').AsString := EmptyStr;
              cdsDocumentos.FieldByName('BKP_ALTEND').AsString := EmptyStr;
              cdsDocumentos.FieldByName('GER_LOCALI').AsString := 'OK?';

              cdsDocumentos.Post;

              cdsDocumentos.Next;
            end;
          finally
            cdsDocumentos.Filtered := False;
          end;
        end;
      End;

      if blnComita then
      begin
        fCommit;

        if not fCfgSis('ROMEDI', varBoolean) then
          pImprimirRomaneio(fNumeroRomaneio(edtNumRom.Text))

        else if Assigned(prcExecutaRelatorio) then
          prcExecutaRelatorio(13, 1361, [1361, 1371],
                              ['NUMROM', 'EMPROM'],
                              [fNumeroRomaneio(edtNumRom.Text), VS_strCodEmp],
                              Sender);

        cdsDocumentos.First;

        While Not cdsDocumentos.Eof DO
        Begin
          fDisparaWhatsappAutomatico(cdsDocumentos.FieldByName('GER_DOCORI').AsString, 'E5', cdsDocumentos.FieldByName('GER_ESPORI').AsString, '', 'AT', '', cdsDocumentos.FieldByName('GER_CLIORI').AsString, '', True, '', Nil, '', '', '', Self.UnitName);
          fDisparaEmailAutomatico(cdsDocumentos.FieldByName('GER_DOCORI').AsString, 'E5', cdsDocumentos.FieldByName('GER_ESPORI').AsString, '', 'AT', '', cdsDocumentos.FieldByName('GER_CLIORI').AsString);
          fDisparaSMSAutomatico(cdsDocumentos.FieldByName('GER_DOCORI').AsString, 'E5', cdsDocumentos.FieldByName('GER_ESPORI').AsString, '', 'AT', '', cdsDocumentos.FieldByName('GER_CLIORI').AsString);
          cdsDocumentos.Next;
        End;

        fMensagem('', 'Romaneio Nº ' + fNumeroRomaneio(edtNumRom.Text) + ' ativado com sucesso!', ['&Ok']);
        pLimparRomaneio;
      end
      else
        fRollBack;

      pFreeAndNil(frmFatRomTransMot);
      pSetFocus(edtNumRom);

    Except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmFatRomaneio.fConfirmaRomaneio]');
        fRollback;
      End;

    End;
  End;
end;

procedure TfrmFatAtivaPreRomaneio.cdsDocumentosAfterOpen(DataSet: TDataSet);
begin
  inherited;
  With Dataset Do
  Begin
    TFloatField(FieldByName('GER_VLRCON')).DisplayFormat := '#,##0.00';
  End;
end;

procedure TfrmFatAtivaPreRomaneio.pLimparRomaneio;
begin
  edtNumRom.Text := EmptyStr;
  lblAviso.Visible := False;

  btnCancelarAtivacao.Enabled      := False;
  btnGerarNovoPreRomaneio.Enabled  := True;
  btnAdicionarNaoEntregues.Enabled := True;

  If cdsDocumentos.Active And Not cdsDocumentos.IsEmpty Then
    cdsDocumentos.EmptyDataSet;
end;

procedure TfrmFatAtivaPreRomaneio.pRetornaTransMot(var strCodTra, strCodMot,
  strCodAj1, strCodAj2, strCodAj3, strCodAj4, strObsFec, strPlaVei, strCodReg: string; var fltVlrFre, fltVlrAdi,
  fltPerFre: Double);
var
  strSQL   : string;
  qryGenGer: TUniQuery;
begin
  qryGenGer := fCriaQuery(Self);
  try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  GER_PLAVEI, ';
    strSQL := strSQL + '  GER_CODMOT, ';
    strSQL := strSQL + '  GER_CODAJ1, ';
    strSQL := strSQL + '  GER_CODAJ2, ';
    strSQL := strSQL + '  GER_CODAJ3, ';
    strSQL := strSQL + '  GER_CODAJ4, ';
    strSQL := strSQL + '  GER_OBSFEC, ';
    strSQL := strSQL + '  GER_CODTRA, ';
    strSQL := strSQL + '  GER_CODREG, ';
    strSQL := strSQL + '  GER_FRETE_, ';
    strSQL := strSQL + '  GER_ADIFRE, ';
    strSQL := strSQL + '  GER_PERFRE  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ROMGERX ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
    strSQL := strSQL + '  GER_EMPROM = :EMPROM';

    qryGenGer.SQL.Clear;
    qryGenGer.SQL.Add(strSQL);
    qryGenGer.ParamByName('NUMROM').AsString := edtNumRom.Text;
    qryGenGer.ParamByName('EMPROM').AsString := VS_strCodEmp;
    qryGenGer.Open;
    try
      strCodTra := qryGenGer.FieldByName('GER_CODTRA').AsString;
      strCodMot := qryGenGer.FieldByName('GER_CODMOT').AsString;
      strCodAj1 := qryGenGer.FieldByName('GER_CODAJ1').AsString;
      strCodAj2 := qryGenGer.FieldByName('GER_CODAJ2').AsString;
      strCodAj3 := qryGenGer.FieldByName('GER_CODAJ3').AsString;
      strCodAj4 := qryGenGer.FieldByName('GER_CODAJ4').AsString;
      strObsFec := qryGenGer.FieldByName('GER_OBSFEC').AsString;
      strPlaVei := qryGenGer.FieldByName('GER_PLAVEI').AsString;
      strCodReg := qryGenGer.FieldByName('GER_CODREG').AsString;
      fltVlrFre := qryGenGer.FieldByName('GER_FRETE_').AsFloat;
      fltVlrAdi := qryGenGer.FieldByName('GER_ADIFRE').AsFloat;
      fltPerFre := qryGenGer.FieldByName('GER_PERFRE').AsFloat;
    finally
      qryGenGer.Close;
    end;
  finally
    FreeAndNil(qryGenGer);
  end;
end;

function TfrmFatAtivaPreRomaneio.fAtivaRomaneio(strCodTra,
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
                                                strAltEnd: String): Boolean;
  Var
    strSQL   : String;
    qryGenGer: TUniQuery;
begin
  Result := True;
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
    strSQL := strSQL + '  GER_STATUS = "A",     ';
    strSQL := strSQL + '  GER_ALTEND = :ALTEND  ';
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
      ParamByName('NUMROM').AsString   := fNumeroRomaneio(edtNumRom.Text);
      ParamByName('EMPROM').AsString   := VS_strCodEmp;
      ParamByName('DTAROM').AsDate     := VS_date;
      ParamByName('HORROM').AsString   := TimeToStr(fRetHoraServidor);
      ParamByName('ALTEND').AsString   := strAltEnd;
      ExecSQL;
    End;
    FreeAndNil(qryGenGer);

    If Result Then
    Begin
      FNumRom := fNumeroRomaneio(edtNumRom.Text);
      FCodMot := strCodMot;
      FCodTra := strCodTra;
      FDtaRom := VS_date;
      FHorRom := fTime();

      Try
        pCriarFormularios(TfrmGravando, frmGravando);
        frmGravando.fExecutarAcao := fGravaHistoricoProgress;
        frmGravando.lblGravando.Caption := 'Gravando históricos...';
        frmGravando.ShowModal;
        Result := frmGravando.blnConfirma;

      Finally
        FreeAndNil(frmGravando);
      End;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fAtivaRomaneio]');
    End;
  End;

end;

function TfrmFatAtivaPreRomaneio.fGravaHistoricoProgress(ProgressBar : TcxProgressBar ) : Boolean;
  Var
    objHisPed: THisPed;
    objOcoCrm: TAtuOcoCrm;
Begin
  Result := True;
  Try
    objHisPed := THisPed.Create(Self);
    ProgressBar.Properties.Max := qryDocumentos.RecordCount;

    qryDocumentos.First;
    qryDocumentos.DisableControls;
    While Not qryDocumentos.Eof Do
    Begin

      Result := objHisPed.fGravarHistorico(qryDocumentos.FieldByName('GER_DOCORI').AsString,
                                           qryDocumentos.FieldByName('GER_ESPORI').AsString,
                                           qryDocumentos.FieldByName('GER_CODEMP').AsString,
                                           FNumRom,
                                           FDtaRom,
                                           FHorRom,
                                           FCodMot,
                                           FCodTra);

      If (VS_strHabilitarCRM) And (Not fEmptyStr(fCfgSis('VENORC', varString))) And (Not fEmptyStr(fCfgSis('VENPED', varString))) Then
      Begin
        objOcoCrm := fAtualizaInformacoesCRM(qryDocumentos.FieldByName('GER_DOCORI').AsString,
                                             qryDocumentos.FieldByName('GER_ESPORI').AsString,
                                             qryDocumentos.FieldByName('GER_CODEMP').AsString,
                                             qryDocumentos.FieldByName('GER_CLIORI').AsString,
                                             EmptyStr,
                                             EmptyStr,
                                             qryDocumentos.FieldByName('GER_CODVEN').AsString,
                                             afcRomaneioAtivacao);

        objOcoCrm.strNumRom := FNumRom;
        objOcoCrm.strCodTra := FCodTra;
        objOcoCrm.strCodMot := FCodMot;
        TAtuOcoCrm(objOcoCrm).pProcessaFatOcorrenciasCRM;

      End;

      If not Result Then
        Break;

      ProgressBar.Position := qryDocumentos.RecNo;
      qryDocumentos.Next;
    End;

  Finally
    qryDocumentos.First;
    qryDocumentos.EnableControls;
    FreeAndNil( objHisPed );
  End;

End;

function TfrmFatAtivaPreRomaneio.fDesAtivaRomaneio: Boolean;
  Var
    strSQL   : String;
    qryGenGer: TUniQuery;
begin
  Result := False;

  If (fMensagem('ATENÇÃO!', 'Cancela ativação do Romaneio?', ['&Sim', '&Não'], 2) = 2) Then
    Exit;

  Try
    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  ROMGERX ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  GER_CODTRA = NULL, ';
    strSQL := strSQL + '  GER_CODMOT = NULL, ';
    strSQL := strSQL + '  GER_CODAJ1 = NULL, ';
    strSQL := strSQL + '  GER_CODAJ2 = NULL, ';
    strSQL := strSQL + '  GER_CODAJ3 = NULL, ';
    strSQL := strSQL + '  GER_CODAJ4 = NULL, ';
    strSQL := strSQL + '  GER_OBSFEC = NULL, ';
    strSQL := strSQL + '  GER_PLAVEI = NULL, ';
    strSQL := strSQL + '  GER_CODREG = NULL, ';
    strSQL := strSQL + '  GER_FRETE_ = NULL, ';
    strSQL := strSQL + '  GER_ADIFRE = NULL, ';
    strSQL := strSQL + '  GER_PERFRE = NULL, ';
    strSQL := strSQL + '  GER_PERFRE = NULL, ';
    strSQL := strSQL + '  GER_DTAROM = NULL, ';
    strSQL := strSQL + '  GER_HORROM = NULL, ';
    strSQL := strSQL + '  GER_STATUS = "P"   ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
    strSQL := strSQL + '  GER_EMPROM = :EMPROM ';

    qryGenGer := fCriaQuery;
    With qryGenGer Do
    Begin
      SQL.Add(strSQL);
      ParamByName('NUMROM').AsString   := fNumeroRomaneio(edtNumRom.Text);
      ParamByName('EMPROM').AsString   := VS_strCodEmp;
      ExecSQL;
    End;
    FreeAndNil(qryGenGer);

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fDesAtivaRomaneio]');
    End;
  End;

end;

end.
