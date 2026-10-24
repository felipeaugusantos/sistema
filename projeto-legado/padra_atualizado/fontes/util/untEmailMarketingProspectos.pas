unit untEmailMarketingProspectos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass, untTypesSistema,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, StrUtils,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, EditFocus, DateUtils, untZClient, Data.DB,
  cxProgressBar, untHelperCitel;

type
  TfrmEmailMarketingProspectos = class(TfrmPaiConfirma)
    gpbData: TGroupBox;
    lbl17: TLabel;
    lblTitData: TLabel;
    lbl18: TLabel;
    mskDtaFin: TMaskEditFocus;
    mskDtaIni: TMaskEditFocus;
    rdgTipDta: TRadioGroup;
    gpbAniv: TGroupBox;
    lbl15: TLabel;
    lbl16: TLabel;
    mskAniIni: TMaskEditFocus;
    mskAniFin: TMaskEditFocus;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl9: TLabel;
    lbl1: TLabel;
    edtNomeInicial: TEditFocus;
    edtNomeFinal: TEditFocus;
    edtCodCid: TEditFocus;
    edtEstado: TEditFocus;
    edtDesCidade: TEditFocus;
    edtBairro: TEditFocus;
    lbl8: TLabel;
    lbl13: TLabel;
    edtCodVendedor: TEditFocus;
    edtDesVendedor: TEditFocus;
    edtCodAti: TEditFocus;
    edtAtividade: TEditFocus;
    lbl11: TLabel;
    lbl12: TLabel;
    edtEndIni: TEditFocus;
    edtEndFin: TEditFocus;
    rdgTipCli: TRadioGroup;
    rdgStatus: TRadioGroup;
    shpCodVen: TShape;
    procedure edtNomeInicialChange(Sender: TObject);
    procedure edtNomeFinalExit(Sender: TObject);
    procedure edtCodCidExit(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtEstadoExit(Sender: TObject);
    procedure edtCodVendedorExit(Sender: TObject);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiExit(Sender: TObject);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    arrCidade      : TConsultasArray;
    arrVendedor    : TConsultasArray;
    arrAtividade   : TConsultasArray;

    strAssunto: String;
    strCodVen : String;
    blnLibVen      : Boolean;

    cdsDados   : TZClient;
    function fGravaOcorrencias(cxProgresso: TcxProgressBar): Boolean;
  public
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untFuncoesConsulta, untConsultas, untTEnvioEmail,
  untEmailMarketingSelecao, untGravando, untAtualizaOcorrenciasCRM;

procedure TfrmEmailMarketingProspectos.btnConfirmaClick(Sender: TObject);
  Var
    strSQL,
    strConsulta,
    strEmails: String;
    blnEnviou: Boolean;

    arrDestinatarios, arrArquivos: TStringArray;
  Const
    olMailItem = 0;
begin
//  inherited;
  If fEmptyStr(strCodVen) And (Not blnLibVen) Then
  Begin
    fMensagem('', 'Informe a senha para o Vendedor!', ['&Ok']);
    pSetFocus(edtCodVendedor);
    Exit;
  End;

  pnlInfo.Caption := 'Carregando Clientes...';
  pnlInfo.Repaint;
  Application.ProcessMessages;
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT DISTINCT                                 ';
    strSQL := strSQL + '        "S" AS MARCA,                            ';
    strSQL := strSQL + '        CONCAT(PRO_CODPRO, " - ", PRO_NOMCLI) AS NOME__,';
    strSQL := strSQL + '        REPLACE(PRO_EMAIL_, ";", "") AS EMAIL_,  ';
    strSQL := strSQL + '        REPLACE(PRO_EMAIL2, ";", "") AS EMAIL2,  ';
    strSQL := strSQL + '        REPLACE(PRO_EMAIL3, ";", "") AS EMAIL3   ';
    strSQL := strSQL + ' FROM PROSPE C                                   ';
    strSQL := strSQL + '   LEFT JOIN CADCID D ON PRO_CODCID = CID_CODCID ';
    strSQL := strSQL + ' WHERE ((LOCATE("@", PRO_EMAIL_) > 0)            ';
    strSQL := strSQL + '     OR (LOCATE("@", PRO_EMAIL2) > 0)            ';
    strSQL := strSQL + '     OR (LOCATE("@", PRO_EMAIL3) > 0))           ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      If rdgTipDta.ItemIndex = 0 Then
        strSQL := strSQL + '  AND PRO_DTACAD BETWEEN :DTAINI AND :DTAFIN '
      Else If rdgTipDta.ItemIndex = 1 Then
        strSQL := strSQL + '  AND PRO_NASCIM BETWEEN :DTAINI AND :DTAFIN AND PRO_NASCIM IS NOT NULL';
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskAniIni.Text)) Then
      strSQL := strSQL + '  AND (DATE_FORMAT(PRO_NASCIM, "%m/%d") BETWEEN :ANIINI AND :ANIFIN) ';

    If Not fEmptyStr(edtNomeInicial.Text) Then
      strSQL := strSQL + '  AND LEFT(PRO_NOMCLI, LENGTH(:MAIOR)) BETWEEN :NOMINI AND :NOMFIN ';

    If Not fEmptyStr(edtCodCid.Text) Then
      strSql := strSQL + fStrLocate(edtCodcid,arrCidade,'CID_CODCID','CODCID');

    If Not fEmptyStr(edtEstado.Text) Then
      strSQL := strSQL + '  AND CID_ESTADO = :ESTADO ';

    Case rdgTipCli.ItemIndex Of
      0: strSQL := strSQL + ' AND IFNULL(PRO_CGCCPF,"2") = "2" ';
      1: strSQL := strSQL + ' AND IFNULL(PRO_CGCCPF,"2") = "1" ';
    End;

    If Not fEmptyStr(edtBairro.Text) Then
      strSQL := strSQL + '  AND PRO_BAIRRO LIKE :BAIRRO ';

    If Not fEmptyStr(edtCodVendedor.Text) Then
      strSql := strSQL + fStrLocate(edtCodVendedor,arrVendedor,'PRO_CODVEN','CODVEN');

    Case rdgStatus.ItemIndex Of
      0 : strSQL := strSQL + '  AND PRO_STATUS = "A" ';
      1 : strSQL := strSQL + '  AND PRO_STATUS = "I" ';
    End;

    If Not fEmptyStr(edtCodAti.Text) Then
      strSql := strSQL + fStrLocate(edtCodAti,arrAtividade,'PRO_CODATI','CODATI');

    If Not fEmptyStr(edtEndIni.Text) Then
      strSQL := strSQL + '  AND LEFT(PRO_ENDERE, LENGTH(:ENDMAI)) BETWEEN :ENDINI AND :ENDFIN ';

    strSQL := strSQL + ' ORDER BY PRO_NOMCLI ';

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
        pSetaParam(edtCodcid.Text,arrCidade,strConsulta,'CODCID',cdsDados.qryQuery);

      If Not fEmptyStr(edtEstado.Text) Then
        ParamByName('ESTADO').AsString := edtEstado.Text;

      {***********************************}
      {* FILTRO POR BAIRRO               *}
      {********************************RV*}
      If Not fEmptyStr(edtBairro.Text) Then
        ParamByName('BAIRRO').AsString := edtBairro.Text + '%';

      If Not fEmptyStr(edtCodVendedor.Text) Then
        pSetaParam(edtCodVendedor.Text,arrVendedor,strConsulta,'CODVEN',cdsDados.qryQuery);

      If Not fEmptyStr(edtCodAti.Text) Then
        pSetaParam(edtCodAti.Text,arrAtividade,strConsulta,'CODATI',cdsDados.qryQuery);

      cdsDados.fAbreClient(True, 'TfrmEmailMarketingProspectos.btnConfirmaClick', False, True);

      If IsEmpty Then
        fMensagem('ATENÇÃO', 'Nenhum prospecto encontrado.', ['Ok'])
      Else
      Begin
        strEmails := TfrmEmailMarketingSelecao.fSeleciona(cdsDados);

        if fEmptyStr(strEmails) Then
          Exit;

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
                                              False,
                                              '',
                                              Nil,
                                              '',
                                              '',
                                              strAssunto,
                                              False,
                                              False,
                                              'S');

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

      End;
    End;
  Finally
    pnlInfo.Caption := '';
  End;

end;

function TfrmEmailMarketingProspectos.fGravaOcorrencias(cxProgresso : TcxProgressBar) : Boolean;
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

    objCrmOco.strTip_Fc := 'P';

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


procedure TfrmEmailMarketingProspectos.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAti, edtAtividade, arrAtividade, nil, fRetNomAtividade, 'da Atividade');
end;

procedure TfrmEmailMarketingProspectos.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqAtividade(Self, edtCodAti, edtAtividade, Nil, Key, arrAtividade, False) Then
   Begin
     fValidaCampos(edtCodAti, False);
     Self.SelectNext(ActiveControl, True, True);
   End;
end;

procedure TfrmEmailMarketingProspectos.edtCodCidExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCid,edtDesCidade,arrCidade,fRetNomCidadeSemOpc,nil,'da Cidade');
end;

procedure TfrmEmailMarketingProspectos.edtCodCidKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCidade(Self, edtCodCid, edtDesCidade, edtEstado, Nil, Key, arrCidade, False) Then
  Begin
    fValidaCampos(edtCodCid, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEmailMarketingProspectos.edtCodVendedorExit(Sender: TObject);
begin
  inherited;
  If blnLibVen Then
    pEdtCodSelectExit(edtCodVendedor,edtDesVendedor,arrVendedor,fRetNomVendRep,nil,'do Vendedor');
end;

procedure TfrmEmailMarketingProspectos.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If blnLibVen And fPesqOperador(Self, edtCodVendedor, edtDesVendedor, nil, Key, arrVendedor, False) Then
  Begin
    If fValidaCampos(edtCodVendedor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmEmailMarketingProspectos.edtEstadoExit(Sender: TObject);
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

procedure TfrmEmailMarketingProspectos.edtNomeFinalExit(Sender: TObject);
begin
  inherited;
  If edtNomeFinal.Text < edtNomeInicial.Text Then
  Begin
    fMensagem('AVISO', 'O nome final não pode conter uma letra menor que a inicial.', ['O& K']);
    edtNomeFinal.Clear;
    pSetFocus(edtNomeInicial);
  End;

end;

procedure TfrmEmailMarketingProspectos.edtNomeInicialChange(Sender: TObject);
begin
  inherited;
  edtNomeFinal.Enabled := (Length(Trim(edtNomeInicial.Text)) > 0);
end;

procedure TfrmEmailMarketingProspectos.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDados := TZClient.Create(Self);

  blnLibVen := fVerificaAcessoSistema('EMPRVN');
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

end;

procedure TfrmEmailMarketingProspectos.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsDados);
  inherited;
end;

function TfrmEmailMarketingProspectos.fValidaCampos(Sender: TWinControl;  blnValidaIndividual: Boolean): Boolean;
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

  End;

  If Not Result Then
    pSetFocus(Sender);
end;


end.
