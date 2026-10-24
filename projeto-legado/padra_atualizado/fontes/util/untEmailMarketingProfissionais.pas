unit untEmailMarketingProfissionais;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPai, RLFilters, RLDraftFilter, Uni, untTypesSistema,
  EditFocus, Buttons, ExtCtrls, QColorLabel, Menus, Mask, MaskEditFocus,
  frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, StrUtils, AppEvnts, ComObj,
  untFuncoesSimples, Windows, UniClientDataSet, DB, ComCtrls,
  clipBrd,  DateUtils, ComboBoxFocus, BitBtnLockedIncrem,
  untFuncoesGenerica, MaskUtils, untZClient,
  frxExportCSVTestabilidade;

type
  TfrmEmailMarketingProfissionais = class(TfrmPai)
    dlgExcel: TSaveDialog;
    pgbProgresso: TProgressBar;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl9: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lblEmpresa: TLabel;
    lbl1: TLabel;
    rdgTipDiv: TRadioGroup;
    edtNomeInicial: TEditFocus;
    edtNomeFinal: TEditFocus;
    edtCodCid: TEditFocus;
    edtEstado: TEditFocus;
    edtDesCidade: TEditFocus;
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
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtBairro: TEditFocus;
    btnConfirma: TBitBtnLocked;
    shpMultSel: TShape;
    procedure edtCodCidExit(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaCidade(Var qryCadCid : TUniQuery);
    procedure edtNomeFinalExit(Sender: TObject);
    procedure edtNomeInicialChange(Sender: TObject);
    procedure edtEstadoExit(Sender: TObject);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiExit(Sender: TObject);
    procedure rdgTipDtaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    cdsDados : TZClient;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;

  public

    arrCidade      : TConsultasArray;
    arrAtividade   : TConsultasArray;
    arrEmpresa     : TConsultasArray;

    { Public declarations }
  end;


implementation

uses untEmailMarketingSelecao, untFuncoesConsulta, untConsultas, ShellAPI, untConstantes,
  untTEnvioEmail;

{$R *.dfm}

procedure TfrmEmailMarketingProfissionais.edtCodCidExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCid,edtDesCidade,arrCidade,fRetNomCidadeSemOpc,nil,'da Cidade');
end;

procedure TfrmEmailMarketingProfissionais.edtCodCidKeyPress(Sender: TObject;
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

procedure TfrmEmailMarketingProfissionais.pCarregaCidade(Var qryCadCid: TUniQuery);
Begin
  If Not (fEmptyStr(edtCodCid.Text)) Then
    edtDesCidade.Text := qryCadCid.FieldByName('CID_NOMCID').AsString
  Else
    edtDesCidade.Text := '';

End;

procedure TfrmEmailMarketingProfissionais.btnConfirmaClick(Sender: TObject);
  Var
    strSQL,
    strLinCid,
    strLinAti,
    strEmpresa,
    strEmails       : String;
    arrDestinatarios, arrArquivos: TStringArray;
  Const
    olMailItem = 0;
begin
  inherited;

  pnlInfo.Caption := 'Carregando Profissionais...';
  pnlInfo.Repaint;
  Application.ProcessMessages;
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT DISTINCT              ';
    strSQL := strSQL + '        "S" AS MARCA,         ';
    strSQL := strSQL + '        CONCAT(DIV_CODDIV, " - ", DIV_NOMDIV) AS NOME__,';
    strSQL := strSQL + '        DIV_EMAIL_ AS EMAIL_, ';
    strSQL := strSQL + '        "" AS EMAIL2,         ';
    strSQL := strSQL + '        "" AS EMAIL3          ';
    strSQL := strSQL + ' FROM CADDIV C ';
    strSQL := strSQL + '   LEFT JOIN CADCID D ON (DIV_CODCID = CID_CODCID) ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   LENGTH(DIV_EMAIL_) > 1 AND LOCATE("@", DIV_EMAIL_) > 0 AND LOCATE(" ", DIV_EMAIL_) <= 0 ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      If rdgTipDta.ItemIndex = 0 Then
        strSQL := strSQL + '  AND DIV_DTACAD BETWEEN :DTAINI AND :DTAFIN '
      Else If rdgTipDta.ItemIndex = 1 Then
        strSQL := strSQL + '  AND DIV_DTANAS BETWEEN :DTAINI AND :DTAFIN AND DIV_DTANAS IS NOT NULL';
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskAniIni.Text)) Then
      strSQL := strSQL + '  AND (DATE_FORMAT(DIV_DTANAS, "%m/%d") BETWEEN :ANIINI AND :ANIFIN) ';

    If Not fEmptyStr(edtNomeInicial.Text) Then
      strSQL := strSQL + '  AND LEFT(DIV_NOMDIV, LENGTH(:MAIOR)) BETWEEN :NOMINI AND :NOMFIN ';

    If Not fEmptyStr(edtCodCid.Text) Then
      strSql := strSQL + fStrLocate(edtCodcid,arrCidade,'CID_CODCID','CODCID');

    If Not fEmptyStr(edtEstado.Text) Then
      strSQL := strSQL + '  AND CID_ESTADO = :ESTADO ';

    Case rdgTipDiv.ItemIndex Of
      0: strSQL := strSQL + ' AND IFNULL(DIV_CGCCPF,"2") = "2" ';
      1: strSQL := strSQL + ' AND IFNULL(DIV_CGCCPF,"2") = "1" ';
    End;

    {***********************************}
    {* FILTRO POR BAIRRO               *}
    {********************************RV*}
    If Not fEmptyStr(edtBairro.Text) Then
      strSQL := strSQL + '  AND DIV_BAIRRO LIKE :BAIRRO ';

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSql := strSQL + fStrLocate(edtCodEmpresa,arrEmpresa,'DIV_CODEMP','CODEMP');

    If edtStatus.Text = 'A' Then
      strSQL := strSQL + '  AND DIV_STATUS = "A" '
    Else If edtStatus.Text = 'I' Then
      strSQL := strSQL + '  AND DIV_STATUS = "I" ';

    If Not fEmptyStr(edtCodAti.Text) Then
      strSql := strSQL + fStrLocate(edtCodAti,arrAtividade,'DIV_CODATI','CODATI');

    If Not fEmptyStr(edtEndIni.Text) Then
      strSQL := strSQL + '  AND LEFT(DIV_ENDERE, LENGTH(:ENDMAI)) BETWEEN :ENDINI AND :ENDFIN ';

    strSQL := strSQL + ' ORDER BY ';
    strSQL := strSQL + '   DIV_NOMDIV ';

    With cdsDados.qryQuery Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

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

      If Not fEmptyStr(edtCodAti.Text) Then
        pSetaParam(edtCodAti.Text,arrAtividade,strLinAti,'CODATI',cdsDados.qryQuery);

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        pSetaParam(edtCodEmpresa.Text,arrEmpresa,strEmpresa,'CODEMP',cdsDados.qryQuery);

      cdsDados.fAbreClient(True, 'TfrmEmailMarketingProfissionais.btnConfirmaClick', False, True);

      If IsEmpty Then
        fMensagem('ATENÇÃO', 'Nenhum profissional encontrado.', ['Ok'])
      Else
       Begin

        strEmails := TfrmEmailMarketingSelecao.fSeleciona(cdsDados);

        if fEmptyStr(strEmails) Then
          Exit;


         pCriarArrayAnexosEDestinatarios('', strEmails, arrDestinatarios, arrArquivos);

         TEnvioEmail.EnviarEmail(Self,
                                 strLoginUsuarioLogado,
                                 '',
                                 [],
                                 [],
                                 arrDestinatarios,
                                 [],
                                 arrArquivos);
       End;
    End;
  Finally
    pnlInfo.Caption := '';
    pSetFocus(mskDtaIni);
  End;
End;

procedure TfrmEmailMarketingProfissionais.edtNomeFinalExit(Sender: TObject);
begin
  inherited;
  If edtNomeFinal.Text < edtNomeInicial.Text Then
  Begin
    fMensagem('AVISO', 'O nome final não pode conter uma letra menor que a inicial.', ['O& K']);
    edtNomeFinal.Clear;
    pSetFocus(edtNomeInicial);
  End;
end;

function TfrmEmailMarketingProfissionais.fValidaCampos(Sender: TWinControl;
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
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmEmailMarketingProfissionais.edtNomeInicialChange(Sender: TObject);
begin
  inherited;
  If Length(Trim(edtNomeInicial.Text)) > 0 Then
    edtNomeFinal.Enabled := True
  Else
    edtNomeFinal.Enabled := False;
end;

procedure TfrmEmailMarketingProfissionais.edtEstadoExit(Sender: TObject);
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

procedure TfrmEmailMarketingProfissionais.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqAtividade(Self, edtCodAti, edtAtividade, Nil, Key, arrAtividade, False) Then
   Begin
     fValidaCampos(edtCodAti, False);
     Self.SelectNext(ActiveControl, True, True);
   End;
end;

procedure TfrmEmailMarketingProfissionais.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAti, edtAtividade, arrAtividade, nil, fRetNomAtividade, 'da Atividade');
end;

procedure TfrmEmailMarketingProfissionais.rdgTipDtaClick(Sender: TObject);
begin
  inherited;
  If rdgTipDta.ItemIndex = 0 Then
    lblTitData.Caption := '(CADASTRO)'
  Else If rdgTipDta.ItemIndex = 1 Then
    lblTitData.Caption := '(NASCIMENTO)';
end;

procedure TfrmEmailMarketingProfissionais.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDados := TZClient.Create(Self);
end;

procedure TfrmEmailMarketingProfissionais.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsDados);
  inherited;
end;

procedure TfrmEmailMarketingProfissionais.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: If (ActiveControl Is TRadioButton) Then SelectNext(ActiveControl, True, True);
    VK_ESCAPE: If (ActiveControl Is TRadioButton) Then btnSair.Click;
  End;
end;

procedure TfrmEmailMarketingProfissionais.edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa, False) Then
  Begin
    If fValidaCampos(edtCodEmpresa,True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEmailMarketingProfissionais.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa,edtDesEmpresa,arrEmpresa,nil,fRetNomeEmpresaSelec,'da Empresa');
end;

end.

