unit untEmailMarketing;

interface

uses
  Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPai, RLFilters, RLDraftFilter, Uni, untTypesSistema,
  EditFocus, Buttons, ExtCtrls, QColorLabel, Menus, Mask, MaskEditFocus,
  frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, StrUtils, AppEvnts, ComObj,
  untFuncoesSimples, Windows, UniClientDataSet, DB, ComCtrls,
  clipBrd,  DateUtils, ComboBoxFocus, BitBtnLockedIncrem,
  untFuncoesGenerica, MaskUtils, untZClient,
  frxExportCSVTestabilidade, cxProgressBar, untHelperCitel, System.SysUtils;

type


  TfrmEmailMarketing = class(TfrmPai)
    dlgExcel: TSaveDialog;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lblRegiao: TLabel;
    lblEmpresa: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lblTipCli: TLabel;
    lbl3: TLabel;
    rdgTipCli: TRadioGroup;
    gpbClienteFF: TGroupBox;
    ColorLabel6: TColorLabel;
    edtClienteFF: TEditFocus;
    gpbEnvBol: TGroupBox;
    ColorLabel5: TColorLabel;
    edtEnvBol: TEditFocus;
    cbbCategoria: TComboBoxFocus;
    edtNomeInicial: TEditFocus;
    edtNomeFinal: TEditFocus;
    edtCodCid: TEditFocus;
    edtCodVendedor: TEditFocus;
    edtCodRepresentante: TEditFocus;
    edtEstado: TEditFocus;
    edtDesCidade: TEditFocus;
    edtDesVendedor: TEditFocus;
    edtDesRepresentante: TEditFocus;
    gpbStatus: TGroupBox;
    ColorLabel3: TColorLabel;
    edtStatus: TEditFocus;
    edtEndIni: TEditFocus;
    edtEndFin: TEditFocus;
    gpbAniv: TGroupBox;
    lbl15: TLabel;
    lbl16: TLabel;
    mskAniIni: TMaskEditFocus;
    mskAniFin: TMaskEditFocus;
    edtCodAti: TEditFocus;
    edtAtividade: TEditFocus;
    gpbData: TGroupBox;
    lbl17: TLabel;
    lblTitData: TLabel;
    lbl18: TLabel;
    mskDtaFin: TMaskEditFocus;
    mskDtaIni: TMaskEditFocus;
    rdgTipDta: TRadioGroup;
    edtCodReg: TEditFocus;
    edtDesReg: TEditFocus;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtBairro: TEditFocus;
    edtTipCli: TEditFocus;
    edtDesTpc: TEditFocus;
    cbbTabPre: TComboBoxFocus;
    btnConfirma: TBitBtnLocked;
    shpMultSel: TShape;
    Label7: TLabel;
    edtCodCac: TEditFocus;
    edtDesCac: TEditFocus;
    lbl4: TLabel;
    edtCodSub: TEditFocus;
    edtDesSub: TEditFocus;
    lbl14: TLabel;
    cmbSexo: TComboBoxFocus;
    shpCodVen: TShape;
    shpCodRep: TShape;
    gpbAnivCont: TGroupBox;
    lblIniCont: TLabel;
    lblFinCont: TLabel;
    mskAniIniCont: TMaskEditFocus;
    mskAniFinCont: TMaskEditFocus;
    Label9: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    rdgLeiLGPD: TRadioGroup;
    lblCliente: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    procedure edtCodCidExit(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaCidade(Var qryCadCid : TUniQuery);
    procedure edtCodVendedorExit(Sender: TObject);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaVendedor(Var qryCadOpe : TUniQuery);
    procedure edtCodRepresentanteExit(Sender: TObject);
    procedure edtCodRepresentanteKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaRepresentante(Var qryCadOpe : TUniQuery);
    procedure edtNomeFinalExit(Sender: TObject);
    procedure edtNomeInicialChange(Sender: TObject);
    procedure edtEstadoExit(Sender: TObject);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiExit(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rdgTipDtaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRegExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodCacExit(Sender: TObject);
    procedure edtCodCacKeyPress(Sender: TObject; var Key: Char);
    procedure edtTipCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodSubKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodSubExit(Sender: TObject);
    procedure edtTipCliExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
  private
    cdsDados       : TZClient;
    arrRegiao      : TConsultasArray;
    arrSubReg      : TConsultasArray;
    arrCidade      : TConsultasArray;
    arrVendedor    : TConsultasArray;
    arrRepresent   : TConsultasArray;
    arrAtividade   : TConsultasArray;
    arrEmpresa     : TConsultasArray;
    arrCanal       : TConsultasArray;
    arrTipCli      : TConsultasArray;
    arrCodDep      : TConsultasArray;
    arrCliente     : TConsultasArray;

    strAssunto: String;
    strCodVen : String;
    strCodRep : String;
    blnLibVen : Boolean;
    blnLibRep : Boolean;

    arrArquivos,
    arrDestinatarios : TStringArray;
    FblnIgnorarEmailsInvalidos: Boolean;
    stlMensagem: TStringList;

    function fTabPreco: String;
    procedure pCarregaPrecos;
    function fGravaOcorrencias(cxProgresso: TcxProgressBar): Boolean;
    procedure pExibirListaEmailsInvalidos(stlMensagem: TStringList);
    procedure pAjustaEmails;
    function fAjustaEmail(strEmail: String): String;
  Public

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;


implementation

uses untFuncoesConsulta, untConsultas, ShellAPI, untConstantes, untTEnvioEmail,
  untEmailMarketingSelecao, untGravando, untAtualizaOcorrenciasCRM,
  untObservacao;

{$R *.dfm}

procedure TfrmEmailMarketing.edtCodCacExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCac,edtDesCac,arrCanal,nil,fRetNomCanalAcesso,'do Canal');
End;

procedure TfrmEmailMarketing.edtCodCacKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCanalAcesso(Self, edtCodCac, edtDesCac, Nil, Key, arrCanal, False) Then
  Begin
    fValidaCampos(edtCodCac, False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmEmailMarketing.edtCodCidExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCid,edtDesCidade,arrCidade,fRetNomCidadeSemOpc,nil,'da Cidade');
end;

procedure TfrmEmailMarketing.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, edtCodCid, edtDesCidade, edtEstado, Nil, Key, arrCidade, False) Then
  Begin
    fValidaCampos(edtCodCid, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEmailMarketing.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtNomCli, arrCliente, Nil, fRetNomCliente, 'do cliente');
end;

procedure TfrmEmailMarketing.edtCodCliKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrCliente, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEmailMarketing.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtDesDep, arrCodDep, fRetNomDep, nil, 'do Departamento');
end;

procedure TfrmEmailMarketing.edtCodDepKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrCodDep, False) Then
  Begin
    If fValidaCampos(edtCodDep, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEmailMarketing.pCarregaCidade(Var qryCadCid: TUniQuery);
Begin
  If Not (fEmptyStr(edtCodCid.Text)) Then
    edtDesCidade.Text := qryCadCid.FieldByName('CID_NOMCID').AsString
  Else
    edtDesCidade.Text := '';

End;

procedure TfrmEmailMarketing.pCarregaPrecos;
  Var
    intIndex: Integer;
Begin
  cbbTabPre.Items.Clear;

  For intIndex := 1 To Length(VS_strTabVen) Do
    if VS_strTabVen[intIndex] = 'S' Then
      cbbTabPre.Items.Add('Tabela ' + IntToStr(intIndex));

  cbbTabPre.Items.Add('');
  cbbTabPre.ItemIndex := cbbTabPre.Items.Count-1;
end;

procedure TfrmEmailMarketing.edtCodVendedorExit(Sender: TObject);
begin
  inherited;
  If blnLibVen Then
    pEdtCodSelectExit(edtCodVendedor,edtDesVendedor,arrVendedor,fRetNomVendRep,nil,'do Vendedor');
end;

procedure TfrmEmailMarketing.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
begin

  If blnLibVen And fPesqOperador(Self, edtCodVendedor, edtDesVendedor, nil, Key, arrVendedor, False) Then
  Begin
    If fValidaCampos(edtCodVendedor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmEmailMarketing.pCarregaVendedor(Var qryCadOpe: TUniQuery);
Begin
  If Not (fEmptyStr(edtCodVendedor.Text)) Then
    edtDesVendedor.Text := qryCadOpe.FieldByName('OPE_NOMOPE').AsString
  Else
    edtDesVendedor.Text := '';

end;

procedure TfrmEmailMarketing.edtCodRepresentanteExit(Sender: TObject);
begin
  inherited;
  If blnLibRep Then
    pEdtCodSelectExit(edtCodRepresentante,edtDesRepresentante,arrRepresent,fRetNomVendRep,nil,'do Representante');
end;

procedure TfrmEmailMarketing.edtCodRepresentanteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If blnLibRep And fPesqOperador(Self, edtCodRepresentante, edtDesRepresentante, nil, Key, arrRepresent, False) Then
  Begin
    If fValidaCampos(edtCodRepresentante,False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmEmailMarketing.edtCodSubExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodSub, edtDesSub, arrSubReg, nil, fRetNomSubRegiao, 'da Sub-Região');
End;

procedure TfrmEmailMarketing.edtCodSubKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqSubRegiao(Self, edtCodSub, edtDesSub, Nil, Key, arrSubReg, False) Then
  Begin
    If fValidaCampos(edtCodSub, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEmailMarketing.pCarregaRepresentante(Var qryCadOpe : TUniQuery);
Begin
  If Not (fEmptyStr(edtCodRepresentante.Text)) Then
    edtDesRepresentante.Text := qryCadOpe.FieldByName('OPE_NOMOPE').AsString
  Else
    edtDesRepresentante.Text := '';
End;

function TfrmEmailMarketing.fAjustaEmail(strEmail : String): String;
  Var
    strRetorno : String;
begin
  strRetorno := StringReplace(strEmail, ' ', '', [rfReplaceAll]);

  If (Not fEmptyStr(strRetorno)) Then
    strRetorno := strRetorno.Trim([';']);

  Result := strRetorno;
end;

procedure TfrmEmailMarketing.pAjustaEmails;
begin
  If (cdsDados.IsEmpty) Then
    Exit;

  cdsDados.First;
  While Not cdsDados.Eof Do
  Begin
    cdsDados.Edit;
    cdsDados.FieldByName('EMAIL_').AsString := fAjustaEmail(cdsDados.FieldByName('EMAIL_').AsString);
    cdsDados.FieldByName('EMAIL2').AsString := fAjustaEmail(cdsDados.FieldByName('EMAIL2').AsString);
    cdsDados.FieldByName('EMAIL3').AsString := fAjustaEmail(cdsDados.FieldByName('EMAIL3').AsString);
    cdsDados.Post;

    cdsDados.Next;
  End;
end;

procedure TfrmEmailMarketing.btnConfirmaClick(Sender: TObject);
  Var
    strSQL,
    strLinCid,
    strLinVen,
    strLinRep,
    strLinAti,
    strRegiao,
    strCodDep,
    strCodCli,
    strEmpresa,
    strTipCli,
    strCanal,
    strSubReg,
    strEmails : String;
    blnEnviou : Boolean;
    qryContatos : TUniQuery;
    lstClientes : TStringList;
    blnAdicionar: Boolean;
    recEmailsInvalidos: TRecEmailInvalidos;
  Const
    olMailItem = 0;
begin
  inherited;


  stlMensagem.Clear;

  If fEmptyStr(strCodVen) And (Not blnLibVen) Then
  Begin
    fMensagem('', 'Informe a senha para o Vendedor!', ['&Ok']);
    pSetFocus(edtCodVendedor);
    Exit;
  End;

  If fEmptyStr(strCodRep) And (Not blnLibRep) Then
  Begin
    fMensagem('', 'Informe a senha para o Representante!', ['&Ok']);
    pSetFocus(edtCodRepresentante);
    Exit;
  End;


  pnlInfo.Caption := 'Carregando Clientes...';
  pnlInfo.Repaint;
  Application.ProcessMessages;
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT DISTINCT                                 ';
    strSQL := strSQL + '        "S" AS MARCA,                            ';
    strSQL := strSQL + '        CONCAT(C.CLI_CODCLI, " - ", CLI_NOMCLI) AS NOME__,';
    strSQL := strSQL + '        CLI_EMAIL_ AS EMAIL_,                    ';
    strSQL := strSQL + '        CLI_EMAIL2 AS EMAIL2,                    ';
    strSQL := strSQL + '        CLI_EMAIL3 AS EMAIL3,                    ';
    strSQL := strSQL + '        C.CLI_CODCLI,                            ';
    strSQL := strSQL + '        C.CLI_NOMCLI,                            ';
    strSQL := strSQL + '        C.CLI_FONE01,                            ';
    strSQL := strSQL + '        C.CLI_FONE02,                            ';
    strSQL := strSQL + '        CID_NOMCID,                              ';
    strSQL := strSQL + '        CID_ESTADO                               ';
    strSQL := strSQL + ' FROM CADCLI C ';

    strSQL := strSQL + '  LEFT JOIN CADCID D ON (CLI_CODCID=CID_CODCID) ';
    strSQL := strSQL + '  LEFT JOIN CLI_INFCRE CC ON CC.CLI_CODCLI = C.CLI_CODCLI ';
    strSQL := strSQL + '  LEFT JOIN CLIDEP   ON DEP_CODCLI = C.CLI_CODCLI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ((LOCATE("@", CLI_EMAIL_) > 0) OR ';
    strSQL := strSQL + '   (LOCATE("@", CLI_EMAIL2) > 0) OR ';
    strSQL := strSQL + '   (LOCATE("@", CLI_EMAIL3) > 0))   ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      If rdgTipDta.ItemIndex = 0 Then
        strSQL := strSQL + '  AND CLI_DTACAD BETWEEN :DTAINI AND :DTAFIN '
      Else If rdgTipDta.ItemIndex = 1 Then
        strSQL := strSQL + '  AND CLI_NASCIM BETWEEN :DTAINI AND :DTAFIN AND CLI_NASCIM IS NOT NULL'
      Else
        strSQL := strSQL + '  AND CLI_ULTCOM BETWEEN :DTAINI AND :DTAFIN AND CLI_ULTCOM IS NOT NULL';
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskAniIni.Text)) Then
      strSQL := strSQL + '  AND (DATE_FORMAT(CLI_NASCIM, "%m/%d") BETWEEN :ANIINI AND :ANIFIN) ';

    If Not fEmptyStr(edtNomeInicial.Text) Then
      strSQL := strSQL + '  AND LEFT(CLI_NOMCLI, LENGTH(:MAIOR)) BETWEEN :NOMINI AND :NOMFIN ';

    If Not fEmptyStr(edtCodCid.Text) Then
      strSql := strSQL + fStrLocate(edtCodcid,arrCidade,'CID_CODCID','CODCID');

    If Not fEmptyStr(edtEstado.Text) Then
      strSQL := strSQL + '  AND CID_ESTADO = :ESTADO ';

    Case rdgTipCli.ItemIndex Of
      0: strSQL := strSQL + ' AND IFNULL(CLI_CGCCPF,"2") = "2" ';
      1: strSQL := strSQL + ' AND IFNULL(CLI_CGCCPF,"2") = "1" ';
    End;

    {***********************************}
    {* FILTRO POR BAIRRO               *}
    {********************************RV*}
    If Not fEmptyStr(edtBairro.Text) Then
      strSQL := strSQL + '  AND CLI_BAIRRO LIKE :BAIRRO ';

    If Not fEmptyStr(edtCodVendedor.Text) Then
      strSql := strSQL + fStrLocate(edtCodVendedor,arrVendedor,'CLI_CODVEN','CODVEN');

    If Not fEmptyStr(edtCodRepresentante.Text) Then
      strSql := strSQL + fStrLocate(edtCodRepresentante,arrRepresent,'CLI_CODREP','CODREP');

    strSql := strSQL + fStrLocate(edtCodReg, arrRegiao, 'CLI_CODREG', 'CODREG');

    strSql := strSQL + fStrLocate(edtCodDep, arrCodDep, 'DEP_CODDEP', 'CODDEP');

    strSql := strSQL + fStrLocate(edtCodCli, arrCliente, 'C.CLI_CODCLI', 'CODCLI');

    strSQL := strSQL + fStrLocate(edtCodSub, arrSubReg, 'CLI_CODSUB', 'CODSUB');

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSql := strSQL + fStrLocate(edtCodEmpresa,arrEmpresa,'CLI_CODEMP','CODEMP');

    {*************************************}
    {* FILTRO POR CANAL DE ACESSO        *}
    {**25/02/2011-10:01****************DP*}
    If Not fEmptyStr(edtCodCac.Text) Then
      strSql := strSQL + fStrLocate(edtCodCac,arrCanal,'CLI_CODCAC','CODCAC');

    {***********************************}
    {* FILTRO POR CATEGORIA            *}
    {********************************RV*}
    If Not fEmptyStr(cbbCategoria.Text) Then
      strSQL := strSQL + '  AND CLI_CATEGO = :CATEGO ';

    If Not fEmptyStr(cbbTabPre.Text) Then
      strSQL := strSQL + '  AND CLI_TABPRE = :TABPRE ';

    {******************************************}
    {* ACRESCENTOU FILTRO POR TIPO DE CLIENTE *}
    {***************************************DP*}
    If Not fEmptyStr(edtTipCli.Text) Then
      strSql := strSQL + fStrLocate(edtTipCli,arrTipCli,'CLI_TIPCLI','TIPCLI');

    If edtStatus.Text = 'A' Then
      strSQL := strSQL + '  AND CLI_STATUS = "A" '
    Else If edtStatus.Text = 'I' Then
      strSQL := strSQL + '  AND CLI_STATUS = "I" ';

    If edtClienteFF.Text = 'S' Then
      strSQL := strSQL + ' AND ((CLI_PERMFF = "S") OR (CLI_PERMFV = "S")) '
    Else If edtClienteFF.Text = 'N' Then
      strSQL := strSQL + ' AND ((CLI_PERMFF = "N") AND (CLI_PERMFV = "N")) ';

    If Not fEmptyStr(cmbSexo.Text) And CharInSet(cmbSexo.Text[1], ['M','F']) Then
      strSQL := strSQL + ' AND CLI_SEXO__ = "' + cmbSexo.Text[1] + '" ';

    If edtEnvBol.Text = 'S' Then
      strSQL := strSQL + '  AND CLI_ENVBOL = "S" '
    Else If edtEnvBol.Text = 'N' Then
      strSQL := strSQL + '  AND CLI_ENVBOL = "N" ';

    If Not fEmptyStr(edtCodAti.Text) Then
      strSql := strSQL + fStrLocate(edtCodAti,arrAtividade,'CLI_CODATI','CODATI');

    If Not fEmptyStr(edtEndIni.Text) Then
      strSQL := strSQL + '  AND LEFT(CLI_ENDERE, LENGTH(:ENDMAI)) BETWEEN :ENDINI AND :ENDFIN ';

    If (rdgLeiLGPD.ItemIndex = 0) Then
      strSQL := strSQL + '  AND CLI_TERACE = "S" ';

    strSQL := strSQL + ' ORDER BY ';
    strSQL := strSQL + '   CLI_NOMCLI ';

    With cdsDados.qryQuery Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If (cbbTabPre.ItemIndex <> (cbbTabPre.Items.Count-1)) Then
        ParamByName('TABPRE').AsString := fTabPreco;

      If Not fEmptyStr(edtCodReg.Text) Then
        ParamByName('CODREG').AsString  := edtCodReg.Text;

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
      End;

      If (Not fEmptyStr(fTiraCaracEspeciais(mskAniIni.Text))) Then
      Begin
        ParamByName('ANIINI').AsString := RightStr(mskAniIni.Text, 2) + '/' + LeftStr(mskAniIni.Text, 2);
        ParamByName('ANIFIN').AsString := RightStr(mskAniFin.Text, 2) + '/' + LeftStr(mskAniFin.Text, 2);
      End;

      If Not fEmptyStr(edtNomeInicial.Text) Then
      Begin
        If Length(edtNomeInicial.Text) > Length(edtNomeFinal.Text) Then
          ParamByName('MAIOR').AsString := edtNomeInicial.Text
        Else
          ParamByName('MAIOR').AsString := edtNomeFinal.Text;

        ParamByName('NOMINI').AsString := edtNomeInicial.Text;
        ParamByName('NOMFIN').AsString := edtNomeFinal.Text;
      End;

      If Not fEmptyStr(edtEndIni.Text) Then
      Begin
        If Length(edtEndIni.Text) > Length(edtEndFin.Text) Then
          ParamByName('ENDMAI').AsString := edtEndIni.Text
        Else
          ParamByName('ENDMAI').AsString := edtEndFin.Text;

        ParamByName('ENDINI').AsString := edtEndIni.Text;
        ParamByName('ENDFIN').AsString := edtEndFin.Text;
      End;

      If Not fEmptyStr(edtCodCid.Text) Then
        pSetaParam(edtCodcid.Text,arrCidade,strLinCid,'CODCID',cdsDados.qryQuery);

      If Not fEmptyStr(edtEstado.Text) Then
        ParamByName('ESTADO').AsString := edtEstado.Text;

      {***********************************}
      {* FILTRO POR BAIRRO               *}
      {********************************RV*}
      If Not fEmptyStr(edtBairro.Text) Then
        ParamByName('BAIRRO').AsString := edtBairro.Text + '%';

      If Not fEmptyStr(edtCodVendedor.Text) Then
        pSetaParam(edtCodVendedor.Text,arrVendedor,strLinVen,'CODVEN',cdsDados.qryQuery);

      If Not fEmptyStr(edtCodRepresentante.Text) Then
        pSetaParam(edtCodRepresentante.Text,arrRepresent,strLinRep,'CODREP',cdsDados.qryQuery);

      If Not fEmptyStr(edtCodAti.Text) Then
        pSetaParam(edtCodAti.Text,arrAtividade,strLinAti,'CODATI',cdsDados.qryQuery);

      pSetaParam(edtCodReg.Text,arrRegiao,strRegiao,'CODREG',cdsDados.qryQuery);

      pSetaParam(edtCodDep.Text,arrCodDep,strCodDep,'CODDEP',cdsDados.qryQuery);

      pSetaParam(edtCodCli.Text,arrCliente, strCodCli, 'CODCLI', cdsDados.qryQuery);

      pSetaParam(edtCodSub.Text, arrSubReg, strSubReg, 'CODSUB', cdsDados.qryQuery);

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        pSetaParam(edtCodEmpresa.Text,arrEmpresa,strEmpresa,'CODEMP',cdsDados.qryQuery);

      {**********************************}
      {* FILTRO POR CANAL DE ACESSO     *}
      {**25/02/2011-10:03*************DP*}
      If Not fEmptyStr(edtCodCac.Text) Then
        pSetaParam(edtCodCac.Text,arrCanal,strCanal,'CODCAC',cdsDados.qryQuery);

      {***********************************}
      {* FILTRO POR CATEGORIA            *}
      {********************************RV*}
      If Not fEmptyStr(cbbCategoria.Text) Then
        ParamByName('CATEGO').AsString := cbbCategoria.Text;

      {******************************************}
      {* ACRESCENTOU FILTRO POR TIPO DE CLIENTE *}
      {***************************************DP*}
      If Not fEmptyStr(edtTipCli.Text) Then
        pSetaParam(edtTipCli.Text,arrTipCli,strTipCli,'TIPCLI',cdsDados.qryQuery);

      cdsDados.fAbreClient(True, 'TfrmEmailMarketing.btnConfirmaClick', False, True);

      If IsEmpty Then
        fMensagem('ATENÇÃO', 'Nenhum cliente encontrado.', ['Ok'])
      Else
      Begin
        {Localiza Contatos (Aniversário)}
        If Not fEmptyStr(fTiraCaracEspeciais(mskAniIniCont.Text)) Then
        Begin

          qryContatos := fCriaQuery(Self);
          lstClientes := TStringList.Create;
          lstClientes.Clear;

          cdsDados.First;
          While Not cdsDados.Eof Do
          Begin
            lstClientes.Add(cdsDados.FieldByName('CLI_CODCLI').AsString);
            cdsDados.Next;
          End;

          Try

            If lstClientes.Count > 0 Then
            Begin

              qryContatos.Close;
              qryContatos.SQL.Clear;
              qryContatos.SQL.Add('SELECT');
              qryContatos.SQL.Add('  C.CLI_NOMCLI AS NOME_CLIENTE,');
              qryContatos.SQL.Add('  CONCAT(T.CLI_CODCLI, " - Contato: ", CLI_NOMCTT) AS NOME,');
              qryContatos.SQL.Add('  T.CLI_EMACTT,');
              qryContatos.SQL.Add('  T.CLI_CODCLI,');
              qryContatos.SQL.Add('  CID_NOMCID,');
              qryContatos.SQL.Add('  CID_ESTADO,');
              qryContatos.SQL.Add('  C.CLI_FONE01,');
              qryContatos.SQL.Add('  C.CLI_FONE02 ');
              qryContatos.SQL.Add('FROM CLICTT T ');
              qryContatos.SQL.Add(' INNER JOIN CADCLI C ON C.CLI_CODCLI = T.CLI_CODCLI');
              qryContatos.SQL.Add(' LEFT JOIN CADCID ON CID_CODCID = CLI_CIDCTT ');
              qryContatos.SQL.Add('WHERE');
              qryContatos.SQL.Add('  T.CLI_CODCLI IN (' + fCommaText(lstClientes, True, ',') + ') AND');
              qryContatos.SQL.Add('  (LOCATE("@", CLI_EMACTT) > 0) AND');
              qryContatos.SQL.Add('  (DATE_FORMAT(CLI_NASCTT, "%m/%d") BETWEEN :ANIINI AND :ANIFIN)');

              qryContatos.ParamByName('ANIINI').AsString := RightStr(mskAniIniCont.Text, 2) + '/' + LeftStr(mskAniIniCont.Text, 2);
              qryContatos.ParamByName('ANIFIN').AsString := RightStr(mskAniFinCont.Text, 2) + '/' + LeftStr(mskAniFinCont.Text, 2);
              qryContatos.Open;

              If Not qryContatos.IsEmpty Then
              Begin

                qryContatos.First;
                While Not qryContatos.Eof Do
                Begin

                  If FblnIgnorarEmailsInvalidos Then
                  Begin
                    recEmailsInvalidos.strCodCli := qryContatos.FieldByName('CLI_CODCLI').AsString;
                    recEmailsInvalidos.strNomCli := qryContatos.FieldByName('NOME_CLIENTE').AsString;
                    recEmailsInvalidos.strFone01 := qryContatos.FieldByName('CLI_FONE01').AsString;
                    recEmailsInvalidos.strFone02 := qryContatos.FieldByName('CLI_FONE02').AsString;
                    recEmailsInvalidos.strNomCid := qryContatos.FieldByName('CID_NOMCID').AsString;
                    recEmailsInvalidos.strNom_UF := qryContatos.FieldByName('CID_ESTADO').AsString;
                    recEmailsInvalidos.strEmail  := qryContatos.FieldByName('CLI_EMACTT').AsString;

                    blnAdicionar := fAdicionarListaEmailInvalido(recEmailsInvalidos, stlMensagem);

                  End
                  Else
                    blnAdicionar := True;

                  If blnAdicionar Then
                  Begin
                    cdsDados.Append;
                    cdsDados.FieldByName('MARCA').AsString      := 'S';
                    cdsDados.FieldByName('NOME__').AsString     := qryContatos.FieldByName('NOME').AsString;
                    cdsDados.FieldByName('EMAIL_').AsString     := qryContatos.FieldByName('CLI_EMACTT').AsString;
                    cdsDados.FieldByName('EMAIL2').AsString     := '';
                    cdsDados.FieldByName('EMAIL3').AsString     := '';
                    cdsDados.FieldByName('CLI_NOMCLI').AsString := qryContatos.FieldByName('NOME_CLIENTE').AsString;
                    cdsDados.Post;
                  End;

                  qryContatos.Next;

                End;

              End;

              {Ordena contatos logo abaixo do respectivo cliente}
              cdsDados.IndexFieldNames := 'CLI_NOMCLI';

            End;

          Finally
            FreeAndNil(qryContatos);
            FreeAndNil(lstClientes);
          End;

        End;

        pAjustaEmails;
        strEmails := TfrmEmailMarketingSelecao.fSeleciona(cdsDados, FblnIgnorarEmailsInvalidos);

        If fEmptyStr(strEmails) Then
          Exit;

        If FblnIgnorarEmailsInvalidos Then
        Begin
          cdsDados.Filter := 'MARCA = ' + QuotedStr('S');
          cdsDados.First;
          While Not cdsDados.Eof Do
          Begin
            If cdsDados.FieldByName('MARCA').AsString = 'S' Then
            Begin
              recEmailsInvalidos.strCodCli := cdsDados.FieldByName('CLI_CODCLI').AsString;
              recEmailsInvalidos.strNomCli := cdsDados.FieldByName('CLI_NOMCLI').AsString;
              recEmailsInvalidos.strFone01 := cdsDados.FieldByName('CLI_FONE01').AsString;
              recEmailsInvalidos.strFone02 := cdsDados.FieldByName('CLI_FONE02').AsString;
              recEmailsInvalidos.strNomCid := cdsDados.FieldByName('CID_NOMCID').AsString;
              recEmailsInvalidos.strNom_UF := cdsDados.FieldByName('CID_ESTADO').AsString;
              recEmailsInvalidos.strEmail  := cdsDados.FieldByName('EMAIL_').AsString;
              fAdicionarListaEmailInvalido(recEmailsInvalidos, stlMensagem);

              recEmailsInvalidos.strCodCli := cdsDados.FieldByName('CLI_CODCLI').AsString;
              recEmailsInvalidos.strNomCli := cdsDados.FieldByName('CLI_NOMCLI').AsString;
              recEmailsInvalidos.strFone01 := cdsDados.FieldByName('CLI_FONE01').AsString;
              recEmailsInvalidos.strFone02 := cdsDados.FieldByName('CLI_FONE02').AsString;
              recEmailsInvalidos.strNomCid := cdsDados.FieldByName('CID_NOMCID').AsString;
              recEmailsInvalidos.strNom_UF := cdsDados.FieldByName('CID_ESTADO').AsString;
              recEmailsInvalidos.strEmail  := cdsDados.FieldByName('EMAIL2').AsString;
              fAdicionarListaEmailInvalido(recEmailsInvalidos, stlMensagem);

              recEmailsInvalidos.strCodCli := cdsDados.FieldByName('CLI_CODCLI').AsString;
              recEmailsInvalidos.strNomCli := cdsDados.FieldByName('CLI_NOMCLI').AsString;
              recEmailsInvalidos.strFone01 := cdsDados.FieldByName('CLI_FONE01').AsString;
              recEmailsInvalidos.strFone02 := cdsDados.FieldByName('CLI_FONE02').AsString;
              recEmailsInvalidos.strNomCid := cdsDados.FieldByName('CID_NOMCID').AsString;
              recEmailsInvalidos.strNom_UF := cdsDados.FieldByName('CID_ESTADO').AsString;
              recEmailsInvalidos.strEmail  := cdsDados.FieldByName('EMAIL3').AsString;
              fAdicionarListaEmailInvalido(recEmailsInvalidos, stlMensagem);
            End;
            cdsDados.Next;
          End;
          cdsDados.Filter := '';
        End;


        pCriarArrayAnexosEDestinatarios('', strEmails, arrDestinatarios, arrArquivos);

        blnEnviou  := TEnvioEmail.EnviarEmail(Self,
                                              strLoginUsuarioLogado,
                                              [],
                                              [],
                                              arrDestinatarios,
                                              [],
                                              arrArquivos,
                                              True,
                                              False,
                                              '',
                                              '',
                                              0,
                                              False,
                                              '',
                                              '',
                                              '',
                                              '',
                                              0,
                                              0,
                                              0,
                                              '',
                                              '',
                                              0,
                                              false,
                                              '',
                                              Nil,
                                              '',
                                              '',
                                              strAssunto,
                                              False,
                                              False,
                                              'S',
                                              True,
                                              Nil,
                                              False,
                                              False,
                                              '',
                                              '',
                                              True,
                                              True,
                                              Nil,
                                              False,
                                              FblnIgnorarEmailsInvalidos);



        If blnEnviou And VS_strHabilitarCRM Then
        Begin
          Try
            pCriarFormularios(TfrmGravando, frmGravando);
            frmGravando.fExecutarAcao := fGravaOcorrencias;
            frmGravando.lblGravando.Caption := 'Aguarde, Gerando Ocorrências de CRM...';
            frmGravando.ShowModal;
          Finally
            FreeAndNil(frmGravando);
          End;



        End;

        pExibirListaEmailsInvalidos(stlMensagem);

      End;
    End;
  Finally
    pnlInfo.Caption := '';
  End;
End;


function TfrmEmailMarketing.fGravaOcorrencias(cxProgresso : TcxProgressBar) : Boolean;
  Var
    objCrmOco : TAtuOcoCrm;
Begin
  Result := True;
  Try
    objCrmOco := TAtuOcoCrm.Create(Nil);

    objCrmOco.strNomFrm := Self.Name;
    objCrmOco.strCodEmp := VS_strCodEmp;
    objCrmOco.strCodToc := fCfgSis('TOCEMA');
    objCrmOco.strDtaInc := fNow;
    objCrmOco.strHorInc := fNow;
    objCrmOco.strDtaAge := objCrmOco.strDtaInc;
    objCrmOco.strHorAge := objCrmOco.strHorInc;
    objCrmOco.strDtaCon := fNow;
    objCrmOco.strHorCon := fNow;
    objCrmOco.strOpeHis := strLoginUsuarioLogado;
    objCrmOco.strCodOpe := strLoginUsuarioLogado;
    objCrmOco.strDescri := 'E-Mail Marketing Enviado<<csq>>' +
                           'Assunto: ' + strAssunto + '<<csq>>' +
                           'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                           DateToStr(fNow) + ' ' + TimeToStr(fNow);

    objCrmOco.strTip_Fc := 'C';

    cdsDados.First;
    cdsDados.DisableControls;
    cdsDados.Filter   := 'MARCA = ' + QuotedStr('S');
    cdsDados.Filtered := True;

    cxProgresso.pSetMax(cdsDados.RecordCount);

    While Not cdsDados.Eof Do
    Begin
      If cdsDados.FieldByName('MARCA').AsString = 'S' Then
      Begin
        objCrmOco.strCodCli := Copy(cdsDados.FieldByName('NOME__').AsString, 1, 8);
        objCrmOco.pInsereNovaOcorrencia;
        objCrmOco.pInsereHistoricoOcorrencia;
      End;

      cdsDados.Next;
      cxProgresso.pStepBy;
      Application.ProcessMessages;

    End;

  Finally
    cdsDados.Filtered := False;
    cdsDados.Filter   := '';
    cdsDados.First;
    cdsDados.EnableControls;

    FreeAndNil(objCrmOco);
  End;
End;

procedure TfrmEmailMarketing.edtNomeFinalExit(Sender: TObject);
begin
  inherited;
  If edtNomeFinal.Text < edtNomeInicial.Text Then
  Begin
    fMensagem('AVISO', 'O nome final não pode conter uma letra menor que a inicial.', ['O& K']);
    edtNomeFinal.Clear;
    pSetFocus(edtNomeInicial);
  End;
end;

function TfrmEmailMarketing.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
  Var
    worAno: Word;
    worMes: Word;
    worDia: Word;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    {*********************}
    {* VALIDA DATA FINAL *}
    {******************AF*}
    If (Sender = mskDtaFin) Then
    Begin

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin

        If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          fMensagem('ATENÇÃO!','O campo Data Inicial deve ser preenchido!', ['&OK']);
          Result := False;
          If (Sender = mskDtaFin) Then
            Sender := mskDtaIni;
        End

        Else If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!','A data inicial deve ser menor que a data final!',['&OK']);
          Result := False;
        End;

      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
        Begin
          fMensagem('ATENÇÃO!','O campo Data Final deve ser preenchido!', ['&OK']);
          Result := False;
        End
      End;

    End

    Else If (Sender = mskAniIni) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskAniIni.Text)) Then
      Begin
        worAno := 2000;
        worMes := StrToInt(Copy(mskAniIni.Text, 4, 2));
        worDia := StrToInt(Copy(mskAniIni.Text, 1, 2));

        If Not IsValidDate(worAno, worMes, worDia) Then
        Begin
          fMensagem('ATENÇÃO!', 'Valor inválido para este campo!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    {*********************}
    {* VALIDA DATA FINAL *}
    {******************AF*}

    Else If (Sender = mskAniFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskAniFin.Text)) Then
      Begin
      worAno := 2000;
      worMes := StrToInt(Copy(mskAniFin.Text, 4, 2));
      worDia := StrToInt(Copy(mskAniFin.Text, 1, 2));
        If Not IsValidDate(worAno, worMes, worDia) Then
        Begin
          fMensagem('ATENÇÃO!', 'Valor inválido para este campo!', ['&Ok']);
          Result := False;
        End
        Else

        If fEmptyStr(fTiraCaracEspeciais(mskAniFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!','O campo Data de Aniversário Inicial deve ser preenchido!', ['&OK']);
          Result := False;
        End

        Else If StrToDate(mskAniFin.Text+'/2000') > StrToDate(mskAniFin.Text+'/2000') Then
        Begin
          fMensagem('ATENÇÃO!','Dia/Mês de Aniversário inicial deve ser menor que Dia/Mês de Aniversário final!',['&OK']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = mskAniIniCont) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskAniIniCont.Text)) Then
      Begin
        worAno := 2000;
        worMes := StrToInt(Copy(mskAniIniCont.Text, 4, 2));
        worDia := StrToInt(Copy(mskAniIniCont.Text, 1, 2));

        If Not IsValidDate(worAno, worMes, worDia) Then
        Begin
          fMensagem('ATENÇÃO!', 'Valor inválido para este campo!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = mskAniFinCont) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskAniFinCont.Text)) Then
      Begin
      worAno := 2000;
      worMes := StrToInt(Copy(mskAniFinCont.Text, 4, 2));
      worDia := StrToInt(Copy(mskAniFinCont.Text, 1, 2));
        If Not IsValidDate(worAno, worMes, worDia) Then
        Begin
          fMensagem('ATENÇÃO!', 'Valor inválido para este campo!', ['&Ok']);
          Result := False;
        End
        Else

        If fEmptyStr(fTiraCaracEspeciais(mskAniFinCont.Text)) Then
        Begin
          fMensagem('ATENÇÃO!','O campo Data de Aniversário Inicial deve ser preenchido!', ['&OK']);
          Result := False;
        End

        Else If StrToDate(mskAniFinCont.Text+'/2000') > StrToDate(mskAniFinCont.Text+'/2000') Then
        Begin
          fMensagem('ATENÇÃO!','Dia/Mês de Aniversário inicial deve ser menor que Dia/Mês de Aniversário final!',['&OK']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = edtStatus) Then
    Begin

      If fEmptyStr(edtStatus.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Status deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (edtStatus.Text <> 'A') And
              (edtStatus.Text <> 'I') And
              (edtStatus.Text <> 'T') Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Status deve ser A,I ou T!', ['&O k']);
        Result := False;
      End;

    End

    Else If (Sender = edtClienteFF) Then
    Begin
      If fEmptyStr(edtClienteFF.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Cliente FF deve ser preehcnido!',['&O K']);
        Result := False;
      End
      Else If Pos(edtClienteFF.Text,'SNT') = 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Cliente FF deve ser S,N ou T',['&O K']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA A EMPRESA                      *}
    {**************************************IV*}
    Else If (Sender = edtCodEmpresa) Then
    Begin
      pDesmarcaLista(edtCodEmpresa,arrEmpresa, 'EMPRESA');
    End

    //*************************************************//
    // VALIDA O ENDERECO INICIAL E O FINAL             //
    //**********************************************ED*//
    Else If (Sender = edtEndFin) Then
    Begin
      If Not( fEmptyStr(edtEndIni.Text) ) Then
      Begin
        If fEmptyStr(edtEndFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O endereço final deve ser preenchido!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        If Not( fEmptyStr(edtEndFin.Text) ) Then
        Begin
          If fEmptyStr(edtEndIni.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'O endereço inicial deve ser preenchido!', ['&O k']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = edtCodSub) Then
    Begin
      pDesmarcaLista(edtCodSub, arrSubReg);
    End

    {****************************}
    {* VALIDA O TIPO DE CLIENTE *}
    {*************************DP*}
    Else If (Sender = edtTipCli) And (edtTipCli.Visible) Then
    Begin
      pDesmarcaLista(edtTipCli, arrTipCli);
    End

    Else If (Sender = edtCodReg) Then
    Begin
      pDesmarcaLista(edtCodReg, arrRegiao);
    End

    {***********************************}
    {* VALIDA RECEBE BOLETO POR E-MAIL *}
    {********************************JU*}
    Else If (Sender = edtEnvBol) Then
    Begin
      If Not fEmptyStr(edtEnvBol.Text) Then
      Begin
        If (edtEnvBol.Text <> 'S') And (edtEnvBol.Text <> 'N') And (edtEnvBol.Text <> 'T') Then
        Begin
          fMensagem('','O campo Recebe boleto por e-mail deve ser S, N ou T!',['&O K'],0);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodVendedor) Then
    Begin
      pDesmarcaLista(edtCodVendedor, arrVendedor);

      If blnLibVen Then
      Begin
        strCodVen := edtCodVendedor.Text;
      End
      Else If Not fEmptyStr(edtCodVendedor.Text) Then
      Begin
        strCodVen := fRetCodVendedor(edtCodVendedor.Text);

        If Not fEmptyStr(strCodVen) Then
          edtDesVendedor.Text := fRetNomVendRep(strCodVen)
        Else
        Begin
          Result := False;
          fMensagem('','Vendedor não encontrado.', ['&O K']);
        End;
      End
      Else
      Begin
        edtDesVendedor.Text := 'TODOS';
        strCodVen := '';
      End;

      edtCodVendedor.Text := strCodVen;
    End

    Else If (Sender = edtCodRepresentante) Then
    Begin
      pDesmarcaLista(edtCodRepresentante, arrRepresent);

      If blnLibRep Then
      Begin
        strCodRep := edtCodRepresentante.Text;
      End
      Else If Not fEmptyStr(edtCodRepresentante.Text) Then
      Begin
        strCodRep := fRetCodVendedor(edtCodRepresentante.Text);

        If Not fEmptyStr(strCodRep) Then
          edtDesRepresentante.Text := fRetNomVendRep(strCodRep)
        Else
        Begin
          Result := False;
          fMensagem('','Representante não encontrado.', ['&O K']);
        End;
      End
      Else
      Begin
        edtDesRepresentante.Text := 'TODOS';
        strCodRep:= '';
      End;

      edtCodRepresentante.Text := strCodRep;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmEmailMarketing.edtNomeInicialChange(Sender: TObject);
begin
  inherited;
  If Length(Trim(edtNomeInicial.Text)) > 0 Then
    edtNomeFinal.Enabled := True
  Else
    edtNomeFinal.Enabled := False;
end;

procedure TfrmEmailMarketing.edtEstadoExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtEstado.Text) Then
  Begin
    If (Not fValidaEstado(edtEstado.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', edtEstado.Text + ' não é um Estado válido!', ['&O k']);
      edtEstado.Clear;
      pSetFocus(edtEstado);
    End;
  End;
end;

procedure TfrmEmailMarketing.edtTipCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtTipCli,edtDesTpc,arrTipCli,nil,fRetDescTipoCli,'do Tipo do Cliente');
end;

procedure TfrmEmailMarketing.edtTipCliKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqTipoCliente(Self, edtTipCli, edtDesTpc, Nil, Key, arrTipCli, False) Then
  Begin
    If fValidaCampos(edtTipCli, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

End;

procedure TfrmEmailMarketing.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqAtividade(Self, edtCodAti, edtAtividade, Nil, Key, arrAtividade, False) Then
   Begin
     fValidaCampos(edtCodAti, False);
     Self.SelectNext(ActiveControl, True, True);
   End;
end;

procedure TfrmEmailMarketing.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAti, edtAtividade, arrAtividade, nil, fRetNomAtividade, 'da Atividade');
end;

procedure TfrmEmailMarketing.edtDestinoExit(Sender: TObject);
begin
//  inherited;
end;

procedure TfrmEmailMarketing.FormShow(Sender: TObject);
begin
  inherited;
  {*******************************************}
  {* VERIFICA SE USA O TIPO DE CLIENTE       *}
  {****************************************DP*}
  If fCfgSis('USATPC', varBoolean) Then
  Begin
    edtTipCli.Visible := True;
    edtDesTpc.Visible := True;
    lblTipCli.Visible := True;
  End
  Else
  Begin
    edtTipCli.Visible := False;
    edtDesTpc.Visible := False;
    lblTipCli.Visible := False;
  End;

  pCarregaPrecos;
end;

procedure TfrmEmailMarketing.rdgTipDtaClick(Sender: TObject);
begin
  inherited;
  If rdgTipDta.ItemIndex = 0 Then
    lblTitData.Caption := '(CADASTRO)'
  Else If rdgTipDta.ItemIndex = 1 Then
    lblTitData.Caption := '(NASCIMENTO)'
  Else
    lblTitData.Caption := '(VENDA)';
end;

procedure TfrmEmailMarketing.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDados := TZClient.Create(Self);
  pPreencheCombo(TCustomComboBox(cbbCategoria), arrCtgCli);

  blnLibVen := fVerificaAcessoSistema('EMCLVN');
  If (Not blnLibVen) Then
  Begin
    edtCodVendedor.MaxLength := 10;
    edtCodVendedor.TamCampo  := 10;
    edtCodVendedor.CompZeros := False;
    edtCodVendedor.PasswordChar := '*';
    edtCodVendedor.TipoTexto := ttAlfanumerico;
    shpCodVen.Brush.Color    := clRed;
  End
  Else
  Begin
    shpCodVen.Brush.Color    := clGreen;
  End;

  blnLibRep := fVerificaAcessoSistema('EMCLRP');
  If (Not blnLibRep) Then
  Begin
    edtCodRepresentante.MaxLength := 10;
    edtCodRepresentante.TamCampo  := 10;
    edtCodRepresentante.CompZeros := False;
    edtCodRepresentante.PasswordChar := '*';
    edtCodRepresentante.TipoTexto := ttAlfanumerico;
    shpCodRep.Brush.Color    := clRed;
  End
  Else
  Begin
    shpCodRep.Brush.Color    := clGreen;
  End;

  gpbClienteFF.Visible := fPermiteEmissaoEspecie('FF');

  FblnIgnorarEmailsInvalidos := fCfgSis('EMAINV', varBoolean);
  stlMensagem := TStringList.Create;
end;

procedure TfrmEmailMarketing.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsDados);
  FreeAndNil(stlMensagem);

  inherited;
end;

procedure TfrmEmailMarketing.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: If (ActiveControl Is TRadioButton) Then SelectNext(ActiveControl, True, True);
    VK_ESCAPE: If (ActiveControl Is TRadioButton) Then btnSair.Click;
  End;
end;

procedure TfrmEmailMarketing.edtCodRegKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqRegiao(Self, edtCodReg, edtDesReg, Nil, Key, arrRegiao, False) Then
  Begin
    if fValidaCampos(edtCodReg, True) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmEmailMarketing.edtCodRegExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodReg,edtDesReg,arrRegiao,nil,fRetNomRegiao,'da Região');

end;

procedure TfrmEmailMarketing.edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa, False) Then
  Begin
    If fValidaCampos(edtCodEmpresa,True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEmailMarketing.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa,edtDesEmpresa,arrEmpresa,nil,fRetNomeEmpresaSelec,'da Empresa');
end;

function TfrmEmailMarketing.fTabPreco: String;
begin
  Result := RightStr(cbbTabPre.Text,1);
end;

procedure TfrmEmailMarketing.pExibirListaEmailsInvalidos(stlMensagem: TStringList);
var
  frmObservacao: TfrmObservacao;
  strCabecalho: String;
  strMensagem: String;
  strRodape: String;
Begin
  If Not Assigned(stlMensagem) Then
    Exit;

  If stlMensagem.Count <= 0 Then
    Exit;

  strCabecalho := EmptyStr;
  strCabecalho := strCabecalho + '---------------------------------------------------------------------------------------------------------------------------------' + #13#10;
  strCabecalho := strCabecalho + '| Código    | Nome Cliente                    | Cidade                |  UF |  Telefone 1 |  Telefone 2 | E-Mail                |' + #13#10;
  strCabecalho := strCabecalho + '---------------------------------------------------------------------------------------------------------------------------------' + #13#10;

  strRodape    := strRodape    + '---------------------------------------------------------------------------------------------------------------------------------' + #13#10;

  strMensagem :=  strCabecalho + stlMensagem.Text + strRodape;

  pCriarFormularios(TfrmObservacao, frmObservacao);
  Try
    frmObservacao.Caption := 'Lista de e-mails que não foram enviados ';
    frmObservacao.lblMensagem.Visible := False;
    frmObservacao.memObs.Texto := strMensagem;
    frmObservacao.memObs.SelStart := 0;
    frmObservacao.Width := 1000;
    frmObservacao.ShowModal;
  Finally
    pFreeAndNil(frmObservacao);
  End;
End;

end.
