unit untGerDupCob;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,Uni, StrUtils,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, ComboBoxFocus, EditFocus, untTypesSistema,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, DateUtils;

type
  TfrmGerDupCob = class(TfrmPai)
    pnlFundo: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    lblStatus: TLabel;
    edtPortador: TEditFocus;
    edtDesPortador: TEdit;
    edtEmpresa: TEditFocus;
    edtDesEmpresa: TEdit;
    cbStatus: TComboBoxFocus;
    grbVencimento: TGroupBox;
    lblDtaIni: TLabel;
    lblDtaFin: TLabel;
    mskDtaIni1: TMaskEditFocus;
    mskDtaFin1: TMaskEditFocus;
    btnGerar: TBitBtnLocked;
    pnlTopo: TPanel;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure edtPortadorKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpresaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryDuplic: TUniQuery;
    qryCadPor: TUniQuery;
    arrEmp   : TConsultasArray;

    procedure pGeraDupCobrancas;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmGerDupCob: TfrmGerDupCob;

implementation

uses untConsultas,untFuncoesSimples, untGerDupSel;

{$R *.dfm}

{ TfrmGerDupCob }

procedure TfrmGerDupCob.btnGerarClick(Sender: TObject);
begin
  inherited;

  if not fValidaCampos(mskDtaIni) then
    Exit;

  if not fValidaCampos(mskDtaFin) then
    Exit;

  If Not fVerificaCampos Then
    Exit;

  pnlInfo.Caption := 'Gerando Duplicatas...';

  If fTabelaExiste('TMP_ATBREC') Then
    fDropTable('TMP_ATBREC');

  pGeraDupCobrancas;

  pnlInfo.Caption := '';
end;

procedure TfrmGerDupCob.edtEmpresaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtEmpresa, Nil, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGerDupCob.edtPortadorKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples,
                     Self,
                     edtPortador,
                     TEditFocus(edtDesPortador),
                     nil,
                     Key,
                     arrSel,
                     True,
                     'Consulta de Portadores',
                     '',
                     False,
                     False,
                     edtEmpresa.Text) then
    Begin
      If fValidaCampos(edtPortador) Then
        SelectNext((Sender As TWinControl), True, True);
    End;
  End;
end;

procedure TfrmGerDupCob.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If Assigned(qryCadPor) Then
    FreeAndNil(qryCadPor);

  If Assigned(qryDuplic) Then
    FreeAndNil(qryDuplic);
end;

procedure TfrmGerDupCob.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  qryDuplic := fCriaQuery(Self);
end;

procedure TfrmGerDupCob.FormShow(Sender: TObject);
begin
  inherited;
  mskDtaIni.Text  := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text  := FormatDateTime('dd/mm/yyyy',VS_Date);
  pSetFocus(mskDtaIni);
end;

function TfrmGerDupCob.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = edtEmpresa Then
    Begin

      If fEmptyStr(edtEmpresa.Text) Then
      Begin
        edtDesEmpresa.Text := 'TODAS';
        SetLength(arrEmp, 0);
      End
      Else
      Begin
        edtEmpresa.Text    := fStrZero(edtEmpresa.Text,3);
        edtDesEmpresa.Text := fRetNomeEmpresa(fStrZero(edtEmpresa.Text,3));
      End;

      If fEmptyStr(edtDesEmpresa.Text) And (Not fEmptyStr(edtEmpresa.Text)) Then
      Begin
        fMensagem('','Código da empresa não encontrado.',['&O K']);
        Result := False;
      End
      Else
      If (Not fEmptyStr(edtEmpresa.Text)) And
         (Pos(edtEmpresa.Text, fRetEmpAcessoCTR(strLoginUsuarioLogado)) <= 0) Then
      Begin
        fMensagem('','O usuário não possui permissão para utilizar a empresa selecionada!.',['&O K']);
        Result := False;
      End;
    End

    Else
    If (Sender = mskDtaIni) or (Sender = mskDtaFin) Then
    Begin
      If(StrToDate(mskDtaIni.Text) < IncYear(VS_Date, -1)) And Not(ActiveControl.Name = btnGerar.Name) And mskDtaIni.Focused Then
      Begin
        Result := fMensagem('', 'Data inferior a ' + DateToStr(IncYear(VS_Date, -1)) + ' (1 ano). Deseja continuar?',
        ['&Sim', '&Não']) = 1;
      End;

      If(StrToDate(mskDtaFin.Text) < IncYear(VS_Date, -1)) And Not(ActiveControl.Name = btnGerar.Name) And mskDtaFin.Focused Then
      Begin
        Result := fMensagem('', 'Data inferior a ' + DateToStr(IncYear(VS_Date, -1)) + ' (1 ano). Deseja continuar?',
        ['&Sim', '&Não']) = 1;
      End;
      If (Sender = mskDtaIni) then
      begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
            fMensagem('','O período não deve ficar em branco!',['&O K'])
          Else
            fMensagem('','A data inicial deve ser preenchida!',['&O K']);
          Result := False;
        End
        Else
        If not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
           if strtodate(mskdtafin.text) < strtodate(mskdtaini.text) then
           begin
              fMensagem('','A data Final não pode ser menor que a data Inicial!',['&O K']);
              Result := False;
           end;
        End;
      End
      Else
      If (Sender = mskDtaFin) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('','A data final deve ser preenchida!',['&O K']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtPortador) Then
    Begin
      If fEmptyStr(edtPortador.Text) Then
        edtDesPortador.Text := 'TODOS'
      Else
      Begin
        edtDesPortador.Text := fRetNomPortador(edtPortador.Text);

        If fEmptyStr(edtDesPortador.Text) And (Not fEmptyStr(edtPortador.Text)) Then
        Begin
          fMensagem('','Código do portador não encontrado.',['&O K']);
          Result := False;
        End
        Else
        Begin
          {*REQ*145940**********RP*}
          If Not fEmpresaTemAcessoPortador(edtPortador.Text, edtEmpresa.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End
          Else If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtPortador.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&O K']);
              Result := False;
            End;
          End;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmGerDupCob.pGeraDupCobrancas;
Var
  strSQL  : String;
  strAux  : String;
  strAgreg: String;
begin
  strSQL   := '';
  strAux   := '';
  strAgreg := '';

  strAgreg := strAgreg + '( SELECT     ';
  strAgreg := strAgreg + '    COUNT(*) ';
  strAgreg := strAgreg + '  FROM       ';
  strAgreg := strAgreg + '    TABINT R ';
  strAgreg := strAgreg + '  WHERE      ';
  strAgreg := strAgreg + '    R.CTR_CODCLI = CLI_CODCLI ';
  strAgreg := strAgreg + '    AND R.CTR_VALDUP < 0      ';
  strAgreg := strAgreg + '    AND R.CTR_DTAREC IS NULL )';
  strAgreg := ' ( ' + strAgreg + '  ) AS CTR_CREDIT ';

  strAux := strAux + 'CREATE TEMPORARY TABLE TMP_ATBREC ';
  strSQL := strSQL + '(SELECT ';
  strSQL := strSQL + '  CONCAT(CTR_NUMDUP,CTR_PARCEL) AS CTR_NUMDUP, ';
  strSQL := strSQL + '  CTR_NUMDUP AS NUMDUP, ';
  strSQL := strSQL + '  CTR_PARCEL, ';
  strSQL := strSQL + '  CTR_SEQBAI, ';
  strSQL := strSQL + '  CTR_CODVEN, ';
  strSQL := strSQL + '  CTR_ESPDOC, ';
  strSQL := strSQL + '  CTR_CODDIG, ';
  strSQL := strSQL + '  CTR_PORBAI, ';
  strSQL := strSQL + '  CTR_CTABAI, ';
  strSQL := strSQL + '  CTR_OPEBAI, ';
  strSQL := strSQL + '  CTR_DOCBAI, ';
  strSQL := strSQL + '  CTR_DTABAI, ';
  strSQL := strSQL + '  CTR_ADTCLI, ';
  strSQL := strSQL + '  CTR_CODEVE, ';
  strSQL := strSQL + '  CTR_VALREC, ';
  strSQL := strSQL + '  CTR_DTAREC, ';
  strSQL := strSQL + '  CTR_RESCAI, ';
  strSQL := strSQL + '  CTR_VALDES, ';
  strSQL := strSQL + '  CTR_VALJUR, ';
  strSQL := strSQL + '  CTR_SEQMOD, ';
  strSQL := strSQL + '  CTR_TIPFOR, ';
  strSQL := strSQL + '  CTR_CODCND, ';
  strSQL := strSQL + '  CTR_CONAPR, ';
  strSQL := strSQL + '  CTR_CODCTA, ';
  strSQL := strSQL + '  CTR_SEQCON, ';

  strSQL := strSQL + '  CTR_CHQPRE, ';
  strSQL := strSQL + '  CTR_CHQAVI, ';
  strSQL := strSQL + '  CTR_DINHEI, ';
  strSQL := strSQL + '  CTR_CARTAO, ';
  strSQL := strSQL + '  CTR_ORDPAG, ';
  strSQL := strSQL + '  CTR_VALFIN, ';

  strSQL := strSQL + '  CTR_DTAVEN, ';
  strSQL := strSQL + '  CTR_DTACAD, ';
  strSQL := strSQL + '  CTR_VALDUP, ';
  strSQL := strSQL + '  CTR_VALORI, ';
  strSQL := strSQL + '  CTR_DESCOB, ';
  strSQL := strSQL + '  CTR_DESCON, ';
  strSQL := strSQL + '  CTR_CODEMP, ';
  strSQL := strSQL + '  CTR_CODCLI, ';
  strSQL := strSQL + '  CLI_NOMCLI, ';

  strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, CONCAT(CLI_ENDERE," ", IFNULL(CLI_ENDNUM,"")), CLI_ENDCOB) AS CLI_ENDCOB, ';
  strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, CLI_BAIRRO, CLI_BAICOB) AS CLI_BAICOB, ';
  strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, D1.CID_NOMCID, D2.CID_NOMCID) AS CLI_NOMCID, ';
  strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, D1.CID_ESTADO, D2.CID_ESTADO) AS CLI_ESTADO, ';
  strSQL := strSQL + '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, CLI_C_E_P_, CLI_CEPCOB) AS CLI_CEPCOB, ';

  strSQL := strSQL + '  CTR_CODPOR, ';
  strSQL := strSQL + '  POR_NOMPOR, ';
  strSQL := strSQL + '  CTR_NOSNUM, ';
  strSQL := strSQL + '  CTR_HIST01, ';
  strSQL := strSQL + '  CTR_HIST02, ';
  strSQL := strSQL + '  CTR_HISBAI, ';
  strSQL := strSQL + '  CTR_OBSAG1, ';
  strSQL := strSQL + '  CTR_OBSAG2, ';
  strSQL := strSQL + '  CTR_OBSAG3, ';
  strSQL := strSQL + '  CTR_CODVEL, ';
  strSQL := strSQL + '  CTR_DESSUJ, ';
  strSQL := strSQL + '  CTR_JURSUJ, ';
  strSQL := strSQL + '  CTR_BCOCRR, ';
  strSQL := strSQL + '  CTR_NN_CRR, ';
  strSQL := strSQL + '  CTR_CARTEI, ';
  strSQL := strSQL + ' ' + strAgreg + ' ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADREC R ';
  strSQL := strSQL + '  LEFT JOIN CADCLI C  ON R.CTR_CODCLI = C.CLI_CODCLI';
  strSQL := strSQL + '  LEFT JOIN CADCID D1 ON C.CLI_CODCID = D1.CID_CODCID ';
  strSQL := strSQL + '  LEFT JOIN CADCID D2 ON C.CLI_CIDCOB = D2.CID_CODCID ';
  strSQL := strSQL + '  LEFT JOIN CADPOR P  ON R.CTR_CODPOR = P.POR_CODPOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIN AND ';
  strSQL := strSQL + '  CTR_DTAREC IS NULL AND ';

  If cbStatus.ItemIndex = 1 Then
    strSQL := strSQL + '  CTR_DTAECO IS NOT NULL AND '
  Else If cbStatus.ItemIndex = 2 Then
    strSQL := strSQL + '  CTR_DTAECO IS NULL AND ';

  strSQL := strSQL + '  CTR_VALDUP > 0 ';

  If Not fEmptyStr(edtEmpresa.Text) Then
    strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP ';

  If Not fEmptyStr(edtPortador.Text) Then
    strSQL := strSQL + '  AND CTR_CODPOR = :CODPOR ';

  strSQL := strSQL + '  ORDER BY CTR_DTAVEN)';
  strSQL := AnsiReplaceStr(strSQL,'TABINT','CADREC');
  strSQL := strAux + strSQL;

  With qryDuplic Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);

    If Not fEmptyStr(edtEmpresa.Text) Then
      ParamByName('CODEMP').AsString := edtEmpresa.Text;

    If Not fEmptyStr(edtPortador.Text) Then
      ParamByName('CODPOR').AsString := edtPortador.Text;

    ExecSQL;

    strSQL := '';
    strSQL := strSQL + 'ALTER TABLE ';
    strSQL := strSQL + '  TMP_ATBREC ';
    strSQL := strSQL + 'ADD ';
    strSQL := strSQL + '  CTR_MARCAD VARCHAR(1) ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;

    strSQL := '';
    strSQL := strSQL + 'ALTER TABLE ';
    strSQL := strSQL + '  TMP_ATBREC ';
    strSQL := strSQL + 'ADD ';
    strSQL := strSQL + '  CTR_PROTES VARCHAR(1) ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;

    strSQL := '';
    strSQL := strSQL + 'ALTER TABLE ';
    strSQL := strSQL + '  TMP_ATBREC ';
    strSQL := strSQL + 'ADD ';
    strSQL := strSQL + '  CTR_OCORRE VARCHAR(30) ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;

    strSQL := '';
    strSQL := strSQL + 'ALTER TABLE ';
    strSQL := strSQL + '  TMP_ATBREC ';
    strSQL := strSQL + 'ADD ';
    strSQL := strSQL + '  CTR_CODCAR INT ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  TMP_ATBREC ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  CTR_PROTES = "N" ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;

    SQL.Clear;
    SQL.Add('SELECT * FROM TMP_ATBREC ORDER BY CTR_DTAVEN');
    Open;

    If qryDuplic.RecordCount > 0 Then
    Begin
      Try
        pCriarFormularios(TfrmGerDupSel,frmGerDupSel);
        frmGerDupSel.qryDuplic        := qryDuplic;
        frmGerDupSel.Caption          := 'AutBan';
        frmGerDupSel.pnlTopo.Caption  := 'Geração de Duplicatas - Global Cobranças';
        frmGerDupSel.strLog           := 'GERAÇÃO DE DUPLICATAS';
        frmGerDupSel.strCodBco        := 'GLO';
        frmGerDupSel.strTipGer        := '';
        frmGerDupSel.blnGlobalCob     := True;
        frmGerDupSel.ShowModal;
      Finally
        FreeAndNil(frmGerDupSel);
      End;
    End
    Else
      fMensagem('','Não há dados para gerar duplicata!',['&O K']);
  End;
end;

end.


