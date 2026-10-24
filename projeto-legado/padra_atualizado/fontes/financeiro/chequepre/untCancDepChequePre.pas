{***************************************************}
{*     CANCELAMENTO DE DEPÓSITO DE CHEQUE PRÉ      *}
{*   ------------------------------------------    *}
{* - CANCELA O DEPÓSITO NO CADCHQ OU (X)           *}
{* - LANÇA UM MOVIMENTO DE DÉBITO NO MOVBAN OU (X) *}
{************************************************AC*}
{***************************}
{* qryCadBco -> CADBCO     *}
{************************RV*}
unit untCancDepChequePre;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  DBCtrls, DB,   Uni, BitBtnLockedIncrem,  MaskUtils, frxClass,
  frxExportCSVTestabilidade, untFechamentoFinanceiro;

type
  TfrmCancDepChequePre = class(TfrmPai)
    pnlCons: TPanel;
    EdtCodBco: TEditFocus;
    EdtNumAge: TEditFocus;
    EdtConCor: TEditFocus;
    EdtNumChq: TEditFocus;
    edtNomBco: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dsConsulta: TDataSource;
    pnlInf: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    DBText8: TDBText;
    DBText9: TDBText;
    DBText10: TDBText;
    DBText11: TDBText;
    DBText12: TDBText;
    DBText13: TDBText;
    DBText14: TDBText;
    DBText15: TDBText;
    DBText16: TDBText;
    DBText17: TDBText;
    Label5: TLabel;
    Label22: TLabel;
    DBText18: TDBText;
    Label23: TLabel;
    DBText19: TDBText;
    Label24: TLabel;
    DBText20: TDBText;
    DBText21: TDBText;
    btnCancela: TBitBtnLocked;
    btnPesquisa: TBitBtnLocked;
    btnCarrCheques: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure EdtCodBcoKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnCarrChequesClick(Sender: TObject);
  private
    { Private declarations }
    qryConBco: TUniQuery;
    qryCadBco: TUniQuery;
    qryConsulta: TUniQuery;

    strCodPor,
    strCodCta,
    strPorDeb,
    strCtaDeb,
    strHist01,
    strNumChq,
    strEmpChq,
    strCodCli,
    strCodBco,
    strNumAge,
    strConCor,
    strNomEmi,
    strHistc1,
    strHistc2: String;

    blnTransf: Boolean;

    dtaDtaLan: TDateTime;

    fltValChq: Double;

    stlCamInd: TStringList;
    stlDesInd: TStringList;

    qryConsDep: TUniQuery;
    objFechamento: TFechamentoFinanceiro;

    procedure pCarregaBanco;

    procedure pConsultaChequePre;
    procedure pEsconde(blnMens: Boolean = True);
    procedure pMostra;
    procedure pSetaVariaveis;
    procedure pLimpaTela;

    function fConsultaDeposito: Boolean;
    function fSelectChequePre: Boolean;
    function fCancelaDeposito: Boolean;
    function fUpdateChequePre: Boolean;
    function fGravaDebitoMovBan: Boolean;
    function fGravaCreditoMovBan: Boolean;
    function fCancelaDevolucao: Boolean;
    function fDuplicataQuitada(strNumDup, strEspDup, strCodEmp, strParcel, strCodCli: String): Boolean;
    function fUpdateChequePreDevolucao: Boolean;
    function fGravaCreditoMovBanDevolucao: Boolean;
    function fGravaDebitoMovBanDevolucao: Boolean;

    procedure pCancelaDeposito;
    procedure pCancelaDevolucao;
    procedure pApagaCadRecDepDev(strNumDup, strEspDup, strCodEmp, strParcel, strCodCli: String);
    procedure pApagaCadPagDepDev(strNumDup, strSerDup, strCodEmp, strParcel, strCodFor: String);
    procedure pApagaChqDev(strSeqGer: String);
    procedure pAfterOpen(DataSet: TDataSet);
    function fTravaPeriodoDevolucao(dtaDevolucao: TDateTime): Boolean;
    procedure pDesbloqueiaRegistro;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnCanDev: Boolean;
  end;


implementation

uses untPesqAux, untFuncoesSimples, untConsultas, untTypesSistema,
  untDigPortador, untMovBan, untCadRec, untFuncoesGenerica, untConstantes, untCadChq,
  untTCadChqRepository, untTBanChqRepository, untCadPag;

{$R *.dfm}

function TfrmCancDepChequePre.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodBco) Then
    Begin

      If fEmptyStr(edtCodBco.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Banco deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaBanco;
        If qryConBco.FieldByName('BCO_CODBCO').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Banco não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtNumAge) Then
    Begin
      If fEmptyStr(edtNumAge.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Número da Agência deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtConCor) Then
    Begin
      If fEmptyStr(edtConCor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Número da Conta Corrente deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtNumChq) Then
    Begin
      If fEmptyStr(edtNumChq.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Número do Cheque deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCancDepChequePre.FormShow(Sender: TObject);
begin
  inherited;

  qryConsDep := fCriarQuery('SELECT * FROM CADCHQ WHERE FALSE', Self);

  btnCancela.Visible := False;

  If blnCanDev Then
  Begin
    Caption            := 'Cancelamento de Devolução de Cheque';
    btnCancela.Caption := '&Cancela Devolução de Cheque';
  End;
end;

procedure TfrmCancDepChequePre.EdtCodBcoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrBancos: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE BANCOS     *}
  {****************************RV*}
  If fPesqBanco(Self, edtCodBco, edtNomBco, qryTabela, Key, arrBancos) Then
  Begin
    if fValidaCampos(EdtCodBco, True) then
      SelectNext(ActiveControl, True, True);
    pCarregaBanco;
  End;
end;

procedure TfrmCancDepChequePre.pCarregaBanco;
begin
  pPesquisaCadBco(qryCadBco, qryConBco, edtCodBco.Text);
  edtNomBco.Text := qryConBco.FieldByName('BCO_NOMBCO').AsString;
end;

procedure TfrmCancDepChequePre.FormCreate(Sender: TObject);
begin
  inherited;
  blnCanDev := False;
  blnTransf := False;
  qryCadBco := fCriaQuery(Self);
  qryConBco := qryCadBco;
  //strNomeTabela := 'CADCHQ';
end;

procedure TfrmCancDepChequePre.pConsultaChequePre;
begin
  If Not fConsultaDeposito Then
    pEsconde
  Else
    pMostra;
end;

procedure TfrmCancDepChequePre.pDesbloqueiaRegistro;
begin
  With qryConsulta Do
  Begin
    IF Assigned(qryConsulta) then
    begin
      If Not Active Then
        Exit;

      fLock_Unlock('CADCHQ' + FieldByName('SEQGER').AsString, False);
    end;
  End;
end;

function TfrmCancDepChequePre.fConsultaDeposito: Boolean;
begin
  Result := True;
  If Not fSelectChequePre Then
    Result := False;
end;

function TfrmCancDepChequePre.fSelectChequePre: Boolean;
begin
  Result := True;

  If Not Assigned(qryConsulta) Then
  Begin
    qryConsulta := fCriaQuery(Self);
    qryConsulta.AfterOpen := pAfterOpen;
  End;

  With qryConsulta Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add('SELECT  ');
    SQL.Add('  CONCAT(CHQ_CODCLI," - ",CLI_NOMCLI) AS CHQ_CODCLI, ');
    SQL.Add('  CONCAT(CHQ_CODPOR," - ",POR_NOMPOR) AS CHQ_CODPOR, ');

    SQL.Add('  CONCAT(SUBSTRING(CHQ_CODCTA,1,2),".",              ');
    SQL.Add('         SUBSTRING(CHQ_CODCTA,3,2),".",              ');
    SQL.Add('         SUBSTRING(CHQ_CODCTA,5,3)," - ",CTA_DESCTA) AS CHQ_CODCTA, ');

    SQL.Add('  IF (CHQ_CGCCPF = 1, CONCAT(CHQ_CGCCPF," - ",SUBSTRING(CHQ_C_G_C_,1,2),".", ');
    SQL.Add('                                              SUBSTRING(CHQ_C_G_C_,3,3),".", ');
    SQL.Add('                                              SUBSTRING(CHQ_C_G_C_,6,3),"/", ');
    SQL.Add('                                              SUBSTRING(CHQ_C_G_C_,9,4),"-", ');
    SQL.Add('                                              SUBSTRING(CHQ_C_G_C_,13,2)),   ');
    SQL.Add('                      CONCAT(CHQ_CGCCPF," - ",SUBSTRING(CHQ_C_G_C_,1,3),".", ');
    SQL.Add('                                              SUBSTRING(CHQ_C_G_C_,4,3),".", ');
    SQL.Add('                                              SUBSTRING(CHQ_C_G_C_,7,3),"/", ');
    SQL.Add('                                              SUBSTRING(CHQ_C_G_C_,10,2))) AS CHQ_C_G_C_,   ');

    SQL.Add('   CHQ_CODBCO, ');
    SQL.Add('   CHQ_NUMAGE, ');
    SQL.Add('   CHQ_CONCOR, ');
    SQL.Add('   CHQ_NUMCHQ, ');
    SQL.Add('   CHQ_NOMEMI, ');
    SQL.Add('   CHQ_ENDERE, ');
    SQL.Add('   CHQ_TELEMI, ');
    SQL.Add('   CHQ_CGCCPF, ');
    SQL.Add('   CHQ_C_G_C_, ');
    SQL.Add('   CHQ_DTACAD, ');
    SQL.Add('   CHQ_DTAVEN, ');
    SQL.Add('   CHQ_VALCHQ, ');
    SQL.Add('   CHQ_HIST01, ');
    SQL.Add('   CHQ_HIST02, ');
    SQL.Add('   IF(CHQ_CTADEP IS NULL, IF(CHQ_CTDPSV IS NULL, CHQ_DEPORI,CHQ_CTDPSV), CHQ_CTADEP) AS CHQ_CTADEP, ');
    SQL.Add('   CHQ_DTADEP, ');
    SQL.Add('   CHQ_DOCDEP, ');
    SQL.Add('   CHQ_DTADEV, ');
    SQL.Add('   CHQ_MOTDEV, ');
    SQL.Add('   CHQ_DTARDP, ');
    SQL.Add('   CHQ_FORREP, ');
    SQL.Add('   CHQ_OBSREP, ');
    SQL.Add('   CHQ_DTAREP, ');
    SQL.Add('   CHQ_RESCAI, ');
    SQL.Add('   CHQ_CODEMP, ');
    SQL.Add('   CHQ_NUMNOT, ');
    SQL.Add('   CHQ_DTACUS, ');
    SQL.Add('   CHQ_PORCUS, ');
    SQL.Add('   CHQ_DOCUME, ');
    SQL.Add('   CHQ_INCCTR, ');
    SQL.Add('   CHQ_HISTOR, ');
    SQL.Add('   CHQ_DOCCUS, ');
    SQL.Add('   CHQ_LOTCUS, ');
    SQL.Add('   CHQ_PORDEB, ');
    SQL.Add('   CHQ_CTADEB, ');
    SQL.Add('   CHQ_MOTDV2, ');
    SQL.Add('   CHQ_DTADP2, ');
    SQL.Add('   CHQ_DTADV2, ');
    SQL.Add('   CHQ_SEQCOM, ');
    SQL.Add('   CHQ_DTATRA, ');
    SQL.Add('   CHQ_SEQCON, ');
    SQL.Add('   CHQ_EMPRCX, ');
    SQL.Add('   CHQ_DEVDEF, ');
    SQL.Add('   CHQ_CODVEN, ');
    SQL.Add('   CHQ_SEQTRF, ');
    SQL.Add('   CHQ_DUPDEV, ');
    SQL.Add('   CHQ_DUPDEP, ');
    SQL.Add('   CHQ_CTDPSV, ');
    SQL.Add('   CHQ_CTDBSV, ');
    SQL.Add('   CHQ_PRDBSV, ');
    SQL.Add('   CHQ_CDCTSV, ');
    SQL.Add('   CHQ_CDPRSV, ');
    SQL.Add('   CHQ_TELCHE, ');
    SQL.Add('   CHQ_TELNUM, ');
    SQL.Add('   CHQ_SEQDEP, ');
    SQL.Add('   CHQ_CODOPE, ');
    SQL.Add('   CHQ_CODCMC, ');
    SQL.Add('   CHQ_DEPORI, ');

    SQL.Add('  CHQ_CODCLI AS CODCLI,  ');
    SQL.Add('  CHQ_CODPOR AS CODPOR,  ');
    SQL.Add('  CHQ_CODCTA AS CODCTA,  ');
    SQL.Add('  IF(CHQ_DEVDEF, "Sim", "Não") AS DEVDEF, ');

    SQL.Add('  SUBSTR(CHQ_DUPDEV,  1, 12) AS DUPDEV,    ');
    SQL.Add('  SUBSTR(CHQ_DUPDEV, 14,  2) AS ESPDEV,    ');
    SQL.Add('  SUBSTR(CHQ_DUPDEV, 17,  1) AS PARDEV,    ');
    SQL.Add('  SUBSTR(CHQ_DUPDEV, 19,  3) AS EMPDEV,    ');
    SQL.Add('  SUBSTR(CHQ_DUPDEV, 23,  8) AS CLIDEV,    ');

    SQL.Add('  SUBSTR(CHQ_DUPDEP,  1, 12) AS DUPDEP,    ');
    SQL.Add('  SUBSTR(CHQ_DUPDEP, 14,  1) AS PARDEP,    ');
    SQL.Add('  SUBSTR(CHQ_DUPDEP, 18,  2) AS ESPDEP,    ');
    SQL.Add('  SUBSTR(CHQ_DUPDEP, 21,  3) AS EMPDEP,    ');
    SQL.Add('  SUBSTR(CHQ_DUPDEP, 25,  8) AS CLIDEP,    ');

    SQL.Add('  SUBSTR(CHQ_DUPCTP,  1, 12) AS DUPCTP,    ');
    SQL.Add('  SUBSTR(CHQ_DUPCTP, 14,  1) AS PARCTP,    ');
    SQL.Add('  SUBSTR(CHQ_DUPCTP, 16,  3) AS EMPCTP,    ');
    SQL.Add('  SUBSTR(CHQ_DUPCTP, 20,  8) AS FORCTP,    ');

    SQL.Add('  SUBSTR(CHQ_DUPDEP,  1, 12) AS DUPTRF,    ');
    SQL.Add('  SUBSTR(CHQ_DUPDEP, 14,  1) AS PARTRF,    ');
    SQL.Add('  SUBSTR(CHQ_DUPDEP, 18,  2) AS ESPTRF,    ');
    SQL.Add('  SUBSTR(CHQ_DUPDEP, 21,  3) AS EMPTRF,    ');
    SQL.Add('  SUBSTR(CHQ_DUPDEP, 25,  8) AS CLITRF,    ');

    SQL.Add('  C.AUTOINCREM AS SEQGER ');

    SQL.Add('FROM CADCHQ C ');

    SQL.Add('       JOIN CADCLI ON CLI_CODCLI = CHQ_CODCLI        ');
    SQL.Add('  LEFT JOIN CADCTA ON CTA_CODCTA = CHQ_CODCTA        ');
    SQL.Add('  LEFT JOIN CADPOR ON POR_CODPOR = CHQ_CODPOR        ');
    SQL.Add('  WHERE ');
    
    If blnCanDev Then
      SQL.Add('  ((CHQ_DTADV2 IS NOT NULL) OR ((CHQ_DTADEV IS NOT NULL) AND (CHQ_DTADP2 IS NULL))) ')
    Else
      SQL.Add('  (NOT ((CHQ_DTADEP IS NULL) OR ((CHQ_DTADP2 IS NULL) AND (CHQ_DTADEV IS NOT NULL)))) ');

    SQL.Add('  AND CHQ_CODBCO = ' + QuotedStr(EdtCodBco.Text)      );
    SQL.Add('  AND CHQ_NUMAGE = ' + QuotedStr(EdtNumAge.Text)      );
    SQL.Add('  AND CHQ_CONCOR = ' + QuotedStr(EdtConCor.Text)      );
    SQL.Add('  AND CHQ_NUMCHQ = ' + QuotedStr(EdtNumChq.Text)      );
    Open;

    If IsEmpty Then
      Result := False;

  End;
end;

procedure TfrmCancDepChequePre.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(EdtCodBco);
end;

procedure TfrmCancDepChequePre.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If Assigned(qryConsDep) Then
    FreeAndNil(qryConsDep);

  pDesbloqueiaRegistro;

  If Assigned(qryConsulta) Then
    FreeAndNil(qryConsulta);

  FreeAndNil(qryCadBco);
end;

procedure TfrmCancDepChequePre.pEsconde(blnMens: Boolean = True);
begin
  btnCancela.Visible := False;

  If blnMens Then
    If blnCanDev Then
      fMensagem('INFORMAÇÃO','Cheque não encontrado ou não devolvido !',['&OK'])
    Else
      fMensagem('INFORMAÇÃO','Cheque não encontrado ou não depositado !',['&OK']);

  If Not blnMens Then
    pLimpaTela;

  pSetFocus(EdtCodBco);
end;

procedure TfrmCancDepChequePre.pMostra;
begin
  dsConsulta.DataSet := qryConsulta;

  (qryConsulta.FieldByName('CHQ_VALCHQ') As TFloatField).DisplayFormat := '#,##0.00';
  blnTransf := Not qryConsulta.FieldByName('CHQ_DUPDEP').IsNull;

  btnCancela.Visible := True;
End;

procedure TfrmCancDepChequePre.pCancelaDeposito;
  Var
    frmDigPortador : TfrmDigPortador;
Begin
  If fMensagem('AVISO', 'Deseja cancelar o Depósito do Cheque ?', ['&Sim', '&Não']) = 1 Then
  Begin

    If blnTransf And fDuplicataQuitada(qryConsulta.FieldByName('DUPTRF').AsString,
                                       qryConsulta.FieldByName('ESPTRF').AsString,
                                       qryConsulta.FieldByName('EMPTRF').AsString,
                                       qryConsulta.FieldByName('PARTRF').AsString,
                                       qryConsulta.FieldByName('CLITRF').AsString) Then
    Begin
      fMensagem('Informação','Cancelamento não permitido.' + #13#10 + 'Já houve baixa da duplicata relativa ao cheque!',['&O K']);
      Exit;
    End;

    pSetaVariaveis;

    If (Not blnTransf) And (fEmptyStr(strPorDeb) Or fEmptyStr(fRetNomPortador(strPorDeb))) Then
    Begin
    
      fMensagem('', 'Portador para débito em branco!', ['&Ok']);
      pCriarFormularios(TfrmDigPortador, frmDigPortador);
      frmDigPortador.Caption := 'Informe o Portador para o débito';
      frmDigPortador.ShowModal;
      
      If frmDigPortador.blnConfirma Then
      Begin
        strPorDeb := frmDigPortador.strCodPor;
        FreeAndNil(frmDigPortador);

        {*REQ*145940**********RP*}
        If Not fEmpresaTemAcessoPortador(strPorDeb) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Exit;
        End;
      End Else
      Begin
        FreeAndNil(frmDigPortador);
        Exit;
      End;

    End;

    If fCancelaDeposito Then
    Begin
      pEsconde(False);
      fMensagem('Informação','Cancelamento de Depósito de Cheque executado com sucesso !',['&O K']);
    End;

  End;
End;

function TfrmCancDepChequePre.fDuplicataQuitada(strNumDup, strEspDup, strCodEmp, strParcel, strCodCli: String): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin

    Clear;
    Add('SELECT');
    Add('  COUNT(*) AS QTDDUP');
    Add('FROM');
    Add('  CADREC ');
    Add('WHERE');
    Add('  CTR_NUMDUP = :NUMDUP AND ');
    Add('  CTR_ESPDOC = :ESPDOC AND ');
    Add('  CTR_CODEMP = :CODEMP AND ');
    Add('  CTR_CODCLI = :CODCLI AND ');
    Add('  CTR_PARCEL = :PARCEL AND ');
    Add('  CTR_DTAREC IS NOT NULL   ');

    ParamByName('NUMDUP').AsString := strNumDup;
    ParamByName('ESPDOC').AsString := strEspDup;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('PARCEL').AsString := strParcel;
    ParamByName('CODCLI').AsString := strCodCli;

    Open;
    Result := FieldByName('QTDDUP').AsInteger > 0;
    Close;

  End;
  
  FreeAndNil(qryGen);
End;

function TfrmCancDepChequePre.fUpdateChequePreDevolucao: Boolean;
  Var
    qryUpdate: TUniQuery;
    repCadChq: TCadChqRepository;
begin
  Result := True;

  Try

    qryUpdate := fCriaQuery;

    With qryUpdate Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE CADCHQ ');
      SQL.Add('   SET                    ');

      SQL.Add('     CHQ_INCCTR = "N",        ');
      SQL.Add('     CHQ_DTADEV = IF(CHQ_DTADV2 IS NULL OR CHQ_DTADP2 IS NULL, NULL, CHQ_DTADEV), ');
      SQL.Add('     CHQ_MOTDEV = IF(CHQ_DTADV2 IS NULL OR CHQ_DTADP2 IS NULL, NULL, CHQ_MOTDEV), ');
      SQL.Add('     CHQ_DTADV2 = NULL,       ');
      SQL.Add('     CHQ_MOTDV2 = NULL,       ');
      SQL.Add('     CHQ_CODCTA = IF(CHQ_CDCTSV IS NULL, CHQ_CTCORI, CHQ_CDCTSV), ');
      SQL.Add('     CHQ_CODPOR = IF(CHQ_CDPRSV IS NULL, CHQ_PRCORI, CHQ_CDPRSV), ');
      SQL.Add('     CHQ_PORDEB = IF(CHQ_PRDBSV IS NULL, CHQ_PRDORI, CHQ_PRDBSV), ');
      SQL.Add('     CHQ_CTADEB = IF(CHQ_CTDBSV IS NULL, CHQ_CTDORI, CHQ_CTDBSV), ');
      SQL.Add('     CHQ_CTADEP = IF(  CHQ_CTDPSV IS NULL, CHQ_DEPORI, CHQ_CTDPSV), ');
      SQL.Add('     CHQ_DEVDEF = FALSE,      ');
      SQL.Add('     CHQ_CDCTSV = NULL,       ');
      SQL.Add('     CHQ_CDPRSV = NULL,       ');
      SQL.Add('     CHQ_PRDBSV = NULL,       ');
      SQL.Add('     CHQ_CTDBSV = NULL,       ');
      SQL.Add('     CHQ_CTDPSV = NULL,       ');
      SQL.Add('     CHQ_DUPDEV = NULL,       ');
      SQL.Add('     CHQ_DUPCTP = NULL        ');

      SQL.Add(' WHERE CHQ_CODBCO = ' + QuotedStr(qryConsulta.FieldByName('CHQ_CODBCO').AsString));
      SQL.Add('   AND CHQ_NUMAGE = ' + QuotedStr(qryConsulta.FieldByName('CHQ_NUMAGE').AsString));
      SQL.Add('   AND CHQ_CONCOR = ' + QuotedStr(qryConsulta.FieldByName('CHQ_CONCOR').AsString));
      SQL.Add('   AND CHQ_NUMCHQ = ' + QuotedStr(qryConsulta.FieldByName('CHQ_NUMCHQ').AsString));
      ExecSQL;
    End;

    FreeAndNil(qryUpdate);

    repCadChq := TCadChqRepository.Create;

    {********************}
    {* GRAVAR NO LOGCHQ *}
    {*****************JU*}
    repCadChq.pGravaLog(qryConsulta.FieldByName('CHQ_CODBCO').AsString, qryConsulta.FieldByName('CHQ_NUMAGE').AsString,
                        qryConsulta.FieldByName('CHQ_CONCOR').AsString, qryConsulta.FieldByName('CHQ_NUMCHQ').AsString,
                        'CANCELAMENTO DE DEVOLUÇÃO (frmCancDepChequePre.fUpdateChequePreDevolucao)');
  Except
    On E: Exception Do
    Begin
      FreeAndNil(qryUpdate);
			pMensagensErro(E.Message,'[TfrmCancDepChequePre.fUpdateChequePreDevolucao]');
      Result := False;
    End;
  End;
  FreeAndNil(repCadChq);

End;

procedure TfrmCancDepChequePre.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin

    If FindField('CHQ_TELEMI') <> nil Then
      TStringField(FieldByName('CHQ_TELEMI')).EditMask := fRetMascaraFonePais;

  End;
end;

{******************************************************}
{* PROCEDURE QUE APAGA DUPLICATAS DO CADPAG           *}
{* QUANDO CANCELA DEVOLUÇÃO DO CHEQUE REPASSADO       *}
{**************************21/03/2018**Req. 68936**WS**}
procedure TfrmCancDepChequePre.pApagaCadPagDepDev(strNumDup, strSerDup,
  strCodEmp, strParcel, strCodFor: String);
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    Clear;
    Add('SELECT SQL_NO_CACHE * FROM ');
    Add('  CADPAG ');
    Add('WHERE');
    Add('  CTP_NUMDUP = :NUMDUP AND ');
    Add('  CTP_SERIE_ = :SERIE_ AND ');
    Add('  CTP_CODEMP = :CODEMP AND ');
    Add('  CTP_CODFOR = :CODFOR AND ');
    Add('  CTP_PARCEL = :PARCEL     ');

    ParamByName('NUMDUP').AsString := strNumDup;
    ParamByName('SERIE_').AsString := strSerDup;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('PARCEL').AsString := strParcel;
    ParamByName('CODFOR').AsString := strCodFor;

    Open;

    While Not Eof Do
    Begin
      fApagaDuplicataContasPagar(qryGen, Self.Name);
      Next;
    End;

  End;
  FreeAndNil(qryGen);
end;

Procedure TfrmCancDepChequePre.pApagaCadRecDepDev(strNumDup, strEspDup, strCodEmp, strParcel, strCodCli: String);
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    Clear;
    Add('SELECT SQL_NO_CACHE * FROM ');
    Add('  CADREC ');
    Add('WHERE');
    Add('  CTR_NUMDUP = :NUMDUP AND ');
    Add('  CTR_ESPDOC = :ESPDOC AND ');
    Add('  CTR_CODEMP = :CODEMP AND ');
    Add('  CTR_CODCLI = :CODCLI AND ');
    Add('  CTR_PARCEL = :PARCEL     ');

    ParamByName('NUMDUP').AsString := strNumDup;
    ParamByName('ESPDOC').AsString := strEspDup;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('PARCEL').AsString := strParcel;
    ParamByName('CODCLI').AsString := strCodCli;

    Open;

    While Not Eof Do
    Begin
      fApagaDuplicataContasReceber(qryGen, Self.Name);
      Next;
    End;

  End;
  FreeAndNil(qryGen);
End;

Function TfrmCancDepChequePre.fGravaCreditoMovBanDevolucao: Boolean;
  Var
    lstBanChq : TBanChqRepository;
Begin
  With qryConsulta Do
  Begin
    lstBanChq := TBanChqRepository.Create;
    lstBanChq.fAdd(FieldByName('CHQ_CODBCO').AsString,
                   FieldByName('CHQ_NUMAGE').AsString,
                   FieldByName('CHQ_CONCOR').AsString,
                   FieldByName('CHQ_NUMCHQ').AsString,
                   FieldByName('CODCLI').AsString,
                   FieldByName('CHQ_NOMEMI').AsString,
                   FieldByName('CHQ_HIST01').AsString,
                   FieldByName('CHQ_HIST02').AsString,
                   FieldByName('CHQ_CODEMP').AsString,
                   '',
                   FieldByName('CHQ_VALCHQ').AsFloat);

    Result := fGravaMovBan(FieldByName('CHQ_CDCTSV').AsString, // Centro de Custo
                           FieldByName('CHQ_CDPRSV').AsString, // Portador da Baixa
                           strLoginUsuarioLogado,              // Operador da Baixa
                           VS_Date,                            // Data do Lançamento
                           fTime(),                            // Hora do Lançamento
                           FieldByName('CHQ_NUMCHQ').AsString, // Numero do Documento
                           'C',                                // Credito / Debito
                           VS_strCodEmp,                       // Empresa da Baixa
                           FieldByName('CHQ_VALCHQ').AsFloat,  // Valor Do Lançamento
                           'CANCEL. DE DEV. CHEQUE No ' + FieldByName('CHQ_NUMCHQ').AsString, //Histórico 1
                           '',                                 // Histórico 2
                           FieldByName('CODCLI').AsString,     // Cliente da Duplicata
                           '',                                 // Fornecedor da Duplicata
                           FieldByName('CHQ_NUMCHQ').AsString, // Número da Duplicata
                           0,                                  // Sequencial de Baixa
                           '',                                 // Parcela da Duplicata
                           FieldByName('CHQ_CODEMP').AsString, // Empresa da Duplicata
                           '',                                 // Série
                           '',                                 // Código do Evento
                           '',                                 // Documento da Baixa
                           lstBanChq.fGetList                  // Log Bancário
                          ) <> '';

    FreeAndNil(lstBanChq);
  End;
End;

Function TfrmCancDepChequePre.fGravaDebitoMovBanDevolucao: Boolean;
  Var
    lstBanChq : TBanChqRepository;
Begin
  With qryConsulta Do
  Begin
    lstBanChq := TBanChqRepository.Create;
    lstBanChq.fAdd(FieldByName('CHQ_CODBCO').AsString,
                   FieldByName('CHQ_NUMAGE').AsString,
                   FieldByName('CHQ_CONCOR').AsString,
                   FieldByName('CHQ_NUMCHQ').AsString,
                   FieldByName('CODCLI').AsString,
                   FieldByName('CHQ_NOMEMI').AsString,
                   FieldByName('CHQ_HIST01').AsString,
                   FieldByName('CHQ_HIST02').AsString,
                   FieldByName('CHQ_CODEMP').AsString,
                   '',
                   FieldByName('CHQ_VALCHQ').AsFloat);

    Result := fGravaMovBan(FieldByName('CHQ_CTDBSV').AsString, // Centro de Custo
                           FieldByName('CHQ_PRDBSV').AsString, // Portador da Baixa
                           strLoginUsuarioLogado,              // Operador da Baixa
                           VS_Date,                            // Data do Lançamento
                           fTime(),                            // Hora do Lançamento
                           FieldByName('CHQ_NUMCHQ').AsString, // Numero do Documento
                           'D',                                // Credito / Debito
                           VS_strCodEmp,                       // Empresa da Baixa
                           FieldByName('CHQ_VALCHQ').AsFloat,  // Valor Do Lançamento
                           'CANCEL. DE DEV. CHEQUE No ' + FieldByName('CHQ_NUMCHQ').AsString, //Histórico 1
                           '',                                 // Histórico 2
                           FieldByName('CODCLI').AsString,     // Cliente da Duplicata
                           '',                                 // Fornecedor da Duplicata
                           FieldByName('CHQ_NUMCHQ').AsString, // Número da Duplicata
                           0,                                  // Sequencial de Baixa
                           '',                                 // Parcela da Duplicata
                           FieldByName('CHQ_CODEMP').AsString, // Empresa da Duplicata
                           '',                                 // Série
                           '',                                 // Código do Evento
                           '',                                 // Documento da Baixa
                           lstBanChq.fGetList                  // Log Bancário
                          ) <> '';

    FreeAndNil(lstBanChq);
  End;
End;

Procedure TfrmCancDepChequePre.pApagaChqDev(strSeqGer: String);
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    Clear;
    Add('DELETE FROM CHQDEV ');
    Add('WHERE');
    Add('  CHQ_SEQGER = :SEQGER ');

    ParamByName('SEQGER').AsString := strSeqGer;

    ExecSQL;

  End;
  FreeAndNil(qryGen);
End;

function TfrmCancDepChequePre.fCancelaDevolucao: Boolean;
Begin
  With qryConsulta Do
  Try

    fStartTransaction;

    Result := fUpdateChequePreDevolucao;

    {QUANDO NÃO FOR REPASSE}
    IF (FieldByName('CHQ_DEPORI').AsString <> 'REPASSE') then
    begin
      {NÃO DEFINITIVA}
      if (FieldByName('CHQ_DEVDEF').AsInteger = 0) then
      begin
        If Result And (Not FieldByName('CHQ_CDPRSV').IsNull) Then
        begin
          Result := fGravaCreditoMovBanDevolucao;
        end;

        If Result And (Not FieldByName('CHQ_PRDBSV').IsNull) Then
        begin
          Result := fGravaDebitoMovBanDevolucao;
        end;
      end
      {DEVOLUÇÃO1 + DEFINITIVA}
      else
      begin
        {SE CONFIGURAÇÃO ESTIVER NÃO}
        if not fCfgSis('CHQCTR',varBoolean) then
        begin
          If Result And (Not FieldByName('CHQ_CDPRSV').IsNull) Then
          begin
            Result := fGravaCreditoMovBanDevolucao;
          end;

          If Result And (Not FieldByName('CHQ_PRDBSV').IsNull) Then
          begin
            Result := fGravaDebitoMovBanDevolucao;
          end;
        end
        {SE CONFIGURAÇÃO ESTIVER SIM}
        else
        begin
          If Result And (Not FieldByName('CHQ_CDPRSV').IsNull) Then
          begin
            Result := fGravaCreditoMovBanDevolucao;
          end;
        end;
      end;
    end
    {QUANDO FOR REPASSE AUTOMATICAMENTE A DEVOLUÇÃO É DEFINITIVA}
    else
    begin
      {SE CONFIGURAÇÃO NÃO}
      if not fCfgSis('CHQCTR',varBoolean) then
      begin
        If Result And (Not FieldByName('CHQ_PRDBSV').IsNull) Then
        begin
          Result := fGravaDebitoMovBanDevolucao;
        end;
      end
      {SE CONFIGURAÇÃO SIM}
      else
      begin
        If Result And (Not FieldByName('CHQ_CDPRSV').IsNull) Then
        begin
          Result := fGravaCreditoMovBanDevolucao;
        end;
      end;
    end;

    If Result Then
    Begin

      If (Not fEmptyStr(FieldByName('DUPDEV').AsString)) And
         (Not fEmptyStr(FieldByName('ESPDEV').AsString)) And
         (Not fEmptyStr(FieldByName('PARDEV').AsString)) And
         (Not fEmptyStr(FieldByName('EMPDEV').AsString)) And
         (Not fEmptyStr(FieldByName('CLIDEV').AsString)) Then
        pApagaCadRecDepDev(FieldByName('DUPDEV').AsString,
                           FieldByName('ESPDEV').AsString,
                           FieldByName('CHQ_CODEMP').AsString,
                           FieldByName('PARDEV').AsString,
                           FieldByName('CLIDEV').AsString);

      If (Not fEmptyStr(FieldByName('DUPDEP').AsString)) And
         (Not fEmptyStr(FieldByName('ESPDEP').AsString)) And
         (Not fEmptyStr(FieldByName('PARDEP').AsString)) And
         (Not fEmptyStr(FieldByName('EMPDEP').AsString)) And
         (Not fEmptyStr(FieldByName('CLIDEP').AsString)) Then
        pApagaCadRecDepDev(FieldByName('DUPDEP').AsString,
                           FieldByName('ESPDEP').AsString,
                           FieldByName('EMPDEP').AsString,
                           FieldByName('PARDEP').AsString,
                           FieldByName('CLIDEP').AsString);

      If (Not fEmptyStr(FieldByName('DUPCTP').AsString)) And
         (Not fEmptyStr(FieldByName('PARCTP').AsString)) And
         (Not fEmptyStr(FieldByName('EMPCTP').AsString)) And
         (Not fEmptyStr(FieldByName('FORCTP').AsString)) Then
        pApagaCadPagDepDev(FieldByName('DUPCTP').AsString,
                           '',
                           FieldByName('EMPCTP').AsString,
                           FieldByName('PARCTP').AsString,
                           FieldByName('FORCTP').AsString);

      If (Not fEmptyStr(FieldByName('SEQGER').AsString)) Then
        pApagaChqDev(FieldByName('SEQGER').AsString);
    End;

    If Result Then
    BEGIN
      fLock_Unlock('CADCHQ' + FieldByName('SEQGER').AsString, False);
      fCommit;
    END
    Else
      fRollBack;

  Except

    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
			pMensagensErro(E.Message,'[TfrmCancDepChequePre.fCancelaDevolucao]');
    End;

  End;
End;

{**********************************************}
{** Função para checar a trava do periodo de **}
{** Cancelamento de devoluções de cheque pré **}
{** RQ:22165 ******************************BB**}
function TfrmCancDepChequePre.fTravaPeriodoDevolucao(dtaDevolucao:TDateTime): Boolean;
var
  intDias: Integer;
begin
  Result := False;

  If fCfgSis('DEVCHQ', varString, VS_strCodEmp) <> '' Then
  Begin
    Try
      intDias:= strToInt(fCfgSis('DEVCHQ', varString, VS_strCodEmp));

      If (intDias > 0) Then
      If dtaDevolucao + intDias < fNow() Then
        Result := True;

    Except
      raise Exception.Create('Número de dias definidos para travar o cancelamento de devolução do cheque, não é válido.'
                             + #13#10 + 'Configuração: "CFG_DEVCHQ"');
      Result := False;
      Exit;
    End;

  End;
end;

procedure TfrmCancDepChequePre.pCancelaDevolucao;
  Var
    strCampos: String;
Begin
  With qryConsulta Do
  If fMensagem('AVISO', 'Deseja cancelar a Devolução do Cheque ?', ['&Sim', '&Não']) = 1 Then
  Begin
    //FECHAMENTO FINANCEIRO
    if (Not FieldByName('CHQ_DTADV2').IsNull) then
    begin
      if objFechamento.FechamentoFinanceiroJaRealizado(VS_strCodEmp, FieldByName('CHQ_DTADV2').AsDateTime) then
        Exit;
    end
    else
    if (Not FieldByName('CHQ_DTADEV').IsNull) then
    begin
      if objFechamento.FechamentoFinanceiroJaRealizado(VS_strCodEmp, FieldByName('CHQ_DTADEV').AsDateTime) then
        Exit;
    end;

  {Verifica Trava de Devolução *BB*}

    If fTravaPeriodoDevolucao(FieldByName('CHQ_DTADEV').AsDateTime) Then
    Begin
      fMensagem('Cancelamento não permitido.',
                'Não é permitido cancelar a DEVOLUÇÃO de Cheque, ' +
                #13#10 + ' após "' + fCfgSis('DEVCHQ') + '" dia(s) da última devolução.',
                ['&O K']);
      Exit;
    End;

  {*******************************}

    If fDuplicataQuitada(FieldByName('DUPDEV').AsString,
                         FieldByName('ESPDEV').AsString,
                         FieldByName('EMPDEV').AsString,
                         FieldByName('PARDEV').AsString,
                         FieldByName('CLIDEV').AsString) = True Then
    Begin
      fMensagem('Informação','Cancelamento não permitido.' + #13#10 + 'Já houve a quitação relativa ao cheque!',['&O K']);
      Exit;
    End;

    If ((FieldByName('CHQ_DEVDEF').AsInteger = 1) Or (Not FieldByName('CHQ_DTADV2').IsNull)) And
       (Not fEmptyStr(FieldByName('DUPDEV').AsString)) And
       fDuplicataQuitada(FieldByName('DUPDEV').AsString,
                         FieldByName('ESPDEV').AsString,
                         FieldByName('EMPDEV').AsString,
                         FieldByName('PARDEV').AsString,
                         FieldByName('CLIDEV').AsString) Then
    Begin
      fMensagem('Informação','Cancelamento não permitido.' + #13#10 + 'Já houve baixa da duplicata relativa ao cheque!',['&O K']);
      Exit;
    End;

    If fDuplicataQuitada(FieldByName('DUPDEP').AsString,
                         FieldByName('ESPDEP').AsString,
                         FieldByName('EMPDEP').AsString,
                         FieldByName('PARDEP').AsString,
                         FieldByName('CLIDEP').AsString) = True Then
    Begin
      fMensagem('Informação','Cancelamento não permitido.' + #13#10 + 'Já houve a quitação relativa ao cheque!',['&O K']);
      Exit;
    End;

    strCampos := '';

    If ((Not (FieldByName('CHQ_SEQTRF').IsNull)) Or (fCfgSis('RCXTCC') = '2')) And
    ((Not FieldByName('CHQ_PRDBSV').IsNull) And
    (Not FieldByName('CHQ_CTDBSV').IsNull) And
    (Not FieldByName('CHQ_CDCTSV').IsNull) And
    (Not FieldByName('CHQ_CTDPSV').IsNull)) Then
    Begin
      If (fEmptyStr(FieldByName('CHQ_CDPRSV').AsString)  Or
          fEmptyStr(FieldByName('CHQ_CDCTSV').AsString)  Or
          fEmptyStr(FieldByName('CHQ_PRDBSV').AsString)  Or
          fEmptyStr(FieldByName('CHQ_CTDBSV').AsString)  Or
          fEmptyStr(FieldByName('CHQ_CTDPSV').AsString)) And
          (Not FieldByName('CHQ_DTADV2').IsNull          Or
          (Not FieldByName('CHQ_DTADEV').IsNull          And
           FieldByName('CHQ_DTADP2').IsNull))            Then
      Begin
        strCampos := strCampos + IIF(fEmptyStr(FieldByName('CHQ_CDPRSV').AsString), #13#10 + 'Campo de portador CHQ_CDPRSV está vazio!','');
        strCampos := strCampos + IIF(fEmptyStr(FieldByName('CHQ_CDCTSV').AsString), #13#10 + 'Campo de conta CHQ_CDCTSV está vazio!','');
        strCampos := strCampos + IIF(fEmptyStr(FieldByName('CHQ_PRDBSV').AsString), #13#10 + 'Campo de portador CHQ_PRDBSV está vazio!','');
        strCampos := strCampos + IIF(fEmptyStr(FieldByName('CHQ_CTDBSV').AsString), #13#10 + 'Campo de conta CHQ_CTDBSV está vazio!','');
        strCampos := strCampos + IIF(fEmptyStr(FieldByName('CHQ_CTDPSV').AsString), #13#10 + 'Campo de conta CHQ_CTDPSV está vazio!','');

        fMensagem('Informação','Cancelamento não permitido! ' + strCampos,['&O K']);
        Exit;
      End;
    End;
{    Else If ((Not (FieldByName('CHQ_SEQTRF').IsNull)) Or (fCfgSis('RCXTCC') = '2')) Then
    Begin
      If  (FieldByName('CHQ_CDPRSV').IsNull) And
          (FieldByName('CHQ_CDCTSV').IsNull) And
          (Not FieldByName('CHQ_DTADV2').IsNull  Or
          (Not FieldByName('CHQ_DTADEV').IsNull  And
              FieldByName('CHQ_DTADP2').IsNull)) Then
      Begin
        strCampos := strCampos + IIF(fEmptyStr(FieldByName('CHQ_CDPRSV').AsString), #13#10 + 'Campo de portador CHQ_CDPRSV está vazio!','');
        strCampos := strCampos + IIF(fEmptyStr(FieldByName('CHQ_CDCTSV').AsString), #13#10 + 'Campo de conta CHQ_CDCTSV está vazio!','');

        fMensagem('Informação','Cancelamento não permitido! ' + strCampos,['&O K']);
        Exit;
      End;
    End;
 }
    If fCancelaDevolucao Then
    Begin
      pEsconde(False);
      fMensagem('Informação','Cancelamento de Devolução de Cheque executado com sucesso !',['&O K']);
    End;


  End;
End;

procedure TfrmCancDepChequePre.btnCancelaClick(Sender: TObject);
begin
  inherited;
  If Not qryConsulta.IsEmpty Then
  Begin

    If blnCanDev Then
      pCancelaDevolucao
    Else
      pCancelaDeposito;
  End;
end;

function TfrmCancDepChequePre.fCancelaDeposito: Boolean;
begin
  Result := True;

  fStartTransaction;

  If Not fUpdateChequePre Then
    Result := False;

  If Not blnTransf Then
  Begin

    If (Result) And (Not qryConsulta.FieldByName('CHQ_CODPOR').IsNull) And
                    (Not qryConsulta.FieldByName('CHQ_CODCTA').IsNull) Then
    Begin
      If Not fGravaDebitoMovBan Then
        Result := False;
    End;

    If (Result) And (Not qryConsulta.FieldByName('CHQ_PORDEB').IsNull) And
                    (Not qryConsulta.FieldByName('CHQ_CTADEB').IsNull) Then
    Begin
      If Not fGravaCreditoMovBan Then
        Result := False;
    End;

  End
  Else
  Begin

    If (Result) Then
    Begin

      If (Not fEmptyStr(qryConsulta.FieldByName('CHQ_DUPDEP').AsString)) Then
        pApagaCadRecDepDev(qryConsulta.FieldByName('DUPTRF').AsString,
                           qryConsulta.FieldByName('ESPTRF').AsString,
                           qryConsulta.FieldByName('EMPTRF').AsString,
                           qryConsulta.FieldByName('PARTRF').AsString,
                           qryConsulta.FieldByName('CLITRF').AsString);

    End;

  End;

  If Result Then
  BEGIN
    fLock_Unlock('CADCHQ' + qryConsulta.FieldByName('SEQGER').AsString, False);
    fCommit;
  END
  Else
    fRollBack;
end;

function TfrmCancDepChequePre.fUpdateChequePre: Boolean;
  Var
    qryUpdate: TUniQuery;
    repCadChq: TCadChqRepository;
begin
  Result := True;

  Try

    qryUpdate := fCriaQuery;

    With qryUpdate Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE CADCHQ ');
      SQL.Add('    SET                    ');
      SQL.Add('        CHQ_DTADEP = IF(CHQ_DTADP2 IS NULL, NULL, CHQ_DTADEP), ');
      SQL.Add('        CHQ_CTADEP = IF(CHQ_DTADP2 IS NULL, NULL, CHQ_DEPORI), '); //NULL, ');
      SQL.Add('        CHQ_DOCDEP = NULL, ');
      SQL.Add('        CHQ_CODPOR = IF(CHQ_DTADP2 IS NULL, NULL, CHQ_PRCORI), '); //NULL, ');
      SQL.Add('        CHQ_CODCTA = IF(CHQ_DTADP2 IS NULL, NULL, CHQ_CTCORI), '); //NULL, ');


      If blnTransf Then
      Begin
        SQL.Add('      CHQ_DUPDEP = NULL, ');
        SQL.Add('      CHQ_INCCTR = "N",  ');
      End;

      SQL.Add('        CHQ_PORDEB = IF(CHQ_DTADP2 IS NULL, NULL, CHQ_PRDORI), '); //NULL, ');
      SQL.Add('        CHQ_CTADEB = IF(CHQ_DTADP2 IS NULL, NULL, CHQ_CTDORI), '); //NULL, ');
      SQL.Add('        CHQ_DTADP2 = NULL, ');
      SQL.Add('        CHQ_SEQDEP = IF(CHQ_DTADP2 IS NULL, NULL, CHQ_SEQDEP)  ');
      SQL.Add('  WHERE CHQ_CODBCO = ' + QuotedStr(qryConsulta.FieldByName('CHQ_CODBCO').AsString));
      SQL.Add('    AND CHQ_NUMAGE = ' + QuotedStr(qryConsulta.FieldByName('CHQ_NUMAGE').AsString));
      SQL.Add('    AND CHQ_CONCOR = ' + QuotedStr(qryConsulta.FieldByName('CHQ_CONCOR').AsString));
      SQL.Add('    AND CHQ_NUMCHQ = ' + QuotedStr(qryConsulta.FieldByName('CHQ_NUMCHQ').AsString));
      ExecSQL;
    End;

    FreeAndNil(qryUpdate);

    repCadChq := TCadChqRepository.Create;
    {********************}
    {* GRAVAR NO LOGCHQ *}
    {*****************JU*}
    repCadChq.pGravaLog(qryConsulta.FieldByName('CHQ_CODBCO').AsString, qryConsulta.FieldByName('CHQ_NUMAGE').AsString,
                        qryConsulta.FieldByName('CHQ_CONCOR').AsString, qryConsulta.FieldByName('CHQ_NUMCHQ').AsString,
                        'CANCELAMENTO DE DEPÓSITO (frmCancDepChequePre.fUpdateChequePre)');
  Except
    On E: Exception Do
    Begin
      FreeAndNil(qryUpdate);
			pMensagensErro(E.Message,'[TfrmCancDepChequePre.fUpdateChequePre]');
      Result := False;
    End;
  End;

  FreeAndNil(repCadChq);
end;

function TfrmCancDepChequePre.fGravaDebitoMovBan: Boolean;
  Var
    lstBanChq : TBanChqRepository;
Begin
  Result := True;

  lstBanChq := TBanChqRepository.Create;
  lstBanChq.fAdd(strCodBco,
                 strNumAge,
                 strConCor,
                 strNumChq,
                 strCodCli,
                 strNomEmi,
                 strHistc1,
                 strHistc2,
                 strEmpChq,
                 '',
                 fltValChq);

  If fGravaMovBan(strCodCta,                       // Centro de Custo
                  strCodPor,                       // Portador da Baixa
                  strLoginUsuarioLogado,           // Operador da Baixa
                  dtaDtaLan,                       // Data do Lançamento
                  fTime(),                         // Hora do Lançamento
                  strNumChq,                       // Numero do Documento
                  'D',                             // Credito / Debito
                  VS_strCodEmp,                    // Empresa da Baixa
                  fltValChq,                       // Valor Do Lançamento
                  strHist01,                       // Histórico 1
                  '',                              // Histórico 2
                  strCodCli,                       // Cliente da Duplicata
                  '',                              // Fornecedor da Duplicata
                  strNumChq,                       // Número da Duplicata
                  0,                               // Sequencial de Baixa
                  '',                              // Parcela da Duplicata
                  strEmpChq,                       // Empresa da Duplicata
                  '',                              // Série
                  '',                              // Código do Evento
                  '',                              // Documento da Baixa
                  lstBanChq.fGetList               // Log Bancário
                 ) = '' Then
    Result := False;

  FreeAndNil(lstBanChq);
End;

function TfrmCancDepChequePre.fGravaCreditoMovBan: Boolean;
  Var
    lstBanChq : TBanChqRepository;
begin
  Result := True;

  lstBanChq := TBanChqRepository.Create;
  lstBanChq.fAdd(strCodBco,
                 strNumAge,
                 strConCor,
                 strNumChq,
                 strCodCli,
                 strNomEmi,
                 strHistc1,
                 strHistc2,
                 strEmpChq,
                 '',
                 fltValChq);

  If fGravaMovBan(strCtaDeb,                        // Centro de Custo Debito
                  strPorDeb,                        // Portador da Baixa Debito
                  strLoginUsuarioLogado,            // Operador da Baixa
                  dtaDtaLan,                        // Data do Lançamento
                  fTime(),                          // Hora do Lançamento
                  strNumChq,                        // Numero do Documento
                  'C',                              // Credito / Debito
                  VS_strCodEmp,                     // Empresa da Baixa
                  fltValChq,                        // Valor Do Lançamento
                  strHist01,                        // Histórico 1
                  '',                               // Histórico 2
                  strCodCli,                        // Cliente da Duplicata
                  '',                               // Fornecedor da Duplicata
                  strNumChq,                        // Número da Duplicata
                  0,                                // Sequencial de Baixa
                  '',                               // Parcela da Duplicata
                  strEmpChq,                        // Empresa da Duplicata
                  '',                               // Série
                  '',                               // Código do Evento
                  '',                               // Documento da Baixa
                  lstBanChq.fGetList                // Log Bancário
                 ) = '' Then
    Result := False;

  FreeAndNil(lstBanChq);
end;

procedure TfrmCancDepChequePre.pSetaVariaveis;
begin
  strCodPor := qryConsulta.FieldByName('CODPOR').AsString;
  strCodCta := qryConsulta.FieldByName('CODCTA').AsString;
  strPorDeb := qryConsulta.FieldByName('CHQ_PORDEB').AsString;
  strCtaDeb := qryConsulta.FieldByName('CHQ_CTADEB').AsString;
  If qryConsulta.FieldByName('CHQ_DTADEP').AsDateTime > VS_Date Then
    dtaDtaLan := qryConsulta.FieldByName('CHQ_DTADEP').AsDateTime
  Else
    dtaDtaLan := VS_Date;
  fltValChq := qryConsulta.FieldByName('CHQ_VALCHQ').AsFloat;
  strHist01 := 'CANCEL. DO DEPOSITO CHEQUE No ' + qryConsulta.FieldByName('CHQ_NUMCHQ').AsString; //qryConsulta.FieldByName('CHQ_HIST01').AsString;
  strNumChq := qryConsulta.FieldByName('CHQ_NUMCHQ').AsString;
  strEmpChq := qryConsulta.FieldByName('CHQ_CODEMP').AsString;
  strCodCli := qryConsulta.FieldByName('CODCLI').AsString;
  strCodBco := qryConsulta.FieldByName('CHQ_CODBCO').AsString;
  strNumAge := qryConsulta.FieldByName('CHQ_NUMAGE').AsString;
  strConCor := qryConsulta.FieldByName('CHQ_CONCOR').AsString;
  strNomEmi := qryConsulta.FieldByName('CHQ_NOMEMI').AsString;
  strHistc1 := qryConsulta.FieldByName('CHQ_HIST01').AsString;
  strHistc2 := qryConsulta.FieldByName('CHQ_HIST02').AsString;
end;

procedure TfrmCancDepChequePre.btnCarrChequesClick(Sender: TObject);
begin
  inherited;
  If fValidaCampos(EdtCodBco,True) And fValidaCampos(EdtNumAge,True) And
     fValidaCampos(EdtConCor,True) And fValidaCampos(EdtNumChq,True) Then
  Begin
  pConsultaChequePre;
  End;
end;

procedure TfrmCancDepChequePre.btnPesquisaClick(Sender: TObject);
  Var
    arrSel    : TConsultasArray;
    chrKey    : Char;

begin
  Try

    chrKey := '/';
    utcRegistros.Limpar(Self.Name + 'CADCHQ');

    Try

      If fPesqCheqDep(Self, qryConsDep, 'CADCHQ', blnCanDev, chrKey, arrSel) Then
      Begin
        pDesbloqueiaRegistro;
        If Not fLock_Unlock('CADCHQ' + qryConsDep.FieldByName('AUTOINCREM').AsString, True, False) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cheque está sendo utilizado por outra estação: ' + fGetHostLock('CADCHQ' + qryConsDep.FieldByName('AUTOINCREM').AsString), ['&Ok']);
          Exit;
        End;

        With qryConsDep Do
        Begin
          If Not IsEmpty Then
          Begin
            EdtCodBco.Text := FieldByName('CHQ_CODBCO').AsString;
            EdtNumAge.Text := FieldByname('CHQ_NUMAGE').AsString;
            EdtConCor.Text := FieldByName('CHQ_CONCOR').AsString;
            EdtNumChq.Text := FieldByname('CHQ_NUMCHQ').AsString;
          End;
        End;

        pCarregaBanco;

        If Not fEmptyStr(EdtNumChq.Text) Then
        Begin
          btnCarrCheques.Click;
          If btnCancela.Visible = False Then
          Begin
            pSetFocus(btnCancela);
          End;
        End;

      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmCancDepChequePre.btnPesquisaClick]');
      End;
    End;

  Finally
    qryConsDep.Close;
    FreeAndNil(stlCamInd);
    FreeAndNil(stlDesInd);
  End;
end;

procedure TfrmCancDepChequePre.pLimpaTela;
begin
  qryConsulta.Close;
  qryConsulta.Open;
  EdtCodBco.Clear;
  EdtNumAge.Clear;
  EdtConCor.Clear;
  EdtNumChq.Clear;
  pCarregaBanco;
end;

end.
