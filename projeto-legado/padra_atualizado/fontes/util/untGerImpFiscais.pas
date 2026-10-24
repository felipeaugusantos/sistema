unit untGerImpFiscais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, untFiscal,
  AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  untLiberacao;

type
  TfrmGerImpFiscais = class(TfrmPai)
    pnlCentral: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    edtCodIFi: TEditFocus;
    edtDesIFi: TEditFocus;
    edtPorCom: TEditFocus;
    btnLeiturax: TBitBtnLocked;
    btnCanCupom: TBitBtnLocked;
    btnReducaoz: TBitBtnLocked;
    btnLeiMemFis: TBitBtnLocked;
    btnFormasPagto: TBitBtnLocked;
    btnParEcf: TBitBtnLocked;
    btnImpRed: TBitBtnLocked;
    btnUltRdz: TBitBtnLocked;
    btnEspMFD: TBitBtnLocked;
    btnArqMFD: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnLeituraxClick(Sender: TObject);
    procedure btnReducaozClick(Sender: TObject);
    procedure btnCanCupomClick(Sender: TObject);
    procedure btnLeiMemFisClick(Sender: TObject);
    procedure btnFormasPagtoClick(Sender: TObject);
    procedure btnParEcfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnImpRedClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnUltRdzClick(Sender: TObject);
    procedure btnEspMFDClick(Sender: TObject);
    procedure btnArqMFDClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    ecfFiscal: TUntFiscal;
    strPatIni: String;
    strCodEcf: String;
    strCodErr: String;
    strModEcf: String;
    strPorta : String;
    blnFechaForm: Boolean;
    objLiberacao : TLiberacao;

    procedure pReducaoZNovo;
    procedure pSalvaReducao(strData : String);
    function fCupomFiscalImpresso(strCondicao: String; dtaData: TDateTime): Boolean;
    procedure pImprimeCuponsPendentes(blnMostraMsg: Boolean);
    function fSemECF: Boolean;
  public
    { Public declarations }
  end;


implementation

uses untWaitWindow, untfuncoesSimples, untFisLeituraMemoria, Data.DB,
     untMenuFiscalMovEcf, untImpReducaoZ, untTypesSistema,
     untDigHoraRedZ, untMemo, Uni,  untImpressorCupom, untFuncoes,
     untFuncFat, untMenuFiscalExpMFD, untFuncoesFiscais, untObservacao;

{$R *.dfm}

procedure TfrmGerImpFiscais.FormShow(Sender: TObject);
begin
  inherited;

  //*************************************************//
  // CARREGA A IMPRESSORA UTILIZADA DE ACORDO COM O  //
  // OPCOES.INI                                      //
  //**********************************************ED*//
  strPatIni := fCfgSis('DIRINI');
  strCodEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA'   , '', strPatIni + '/opcoes_fiscal.ini' );
  strModEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'MODELO'       , '', strPatIni + '/opcoes_fiscal.ini' );
  strPorta  := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'PORTA'        , '', strPatIni + '/opcoes_fiscal.ini' );

  If fEmptyStr( strCodEcf ) Then
  Begin
    Try
      pCriarFormularios(TfrmMemo, frmMemo);
      frmMemo.cxMemo.Lines.Add(fReplicatorStr(' ',35) + 'ATENÇÃO' + #13#10 +
        'A impressora fiscal que será utilizada não foi setada nas Configurações do Sistema!' + #13#10#13#10 +
        '1º - Vá nas Configurações do Sistema na aba Cupom Fiscal.' + #13#10 +
        '2º - Configure "Diretório para (opcoes_fiscal.ini)".' + #13#10 +
        '3º - SALVE!!!' + #13#10 +
        '4º - Somente após SALVAR, em "Configurações - Cupom Fiscal" configure sua impressora.');
      frmMemo.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmGerImpFiscais.FormShow]');
      End;
    End;

    pFreeAndNil(frmMemo);

    blnFechaForm := True;
    Exit;
  End;

  //*************************************************//
  // MOSTRA NA TELA A IMPRESSORA UTILIZADA           //
  //**********************************************ED*//
  edtCodIFi.Text := strCodEcf;
  edtDesIFi.Text := strModEcf;
  edtPorCom.Text := strPorta;

  //*************************************************//
  // VERIFICA OS DIREITOS DAS IMPRESSORAS            //
  //**********************************************ED*//

  If Pos(strModEcf, 'BEMATECH-MP2100THFI / MP40_BEMATECH-MP25FI OU SUPERIOR_DARUMA_SCHALTER SCFI 1E_ELGIN 1FIT SWEDA ST120 SWEDA-7000 SWEDA-9000 DARUMA FS600 DARUMA MACH DARUMA FS700 OU SUPERIOR') = 0 Then
  Begin
    btnLeiMemFis.Enabled := False;
  End;

  {***********************************************}
  {* HABILITA O BOTÃO DE IMPORTAÇÃO DE REDUÇÃO Z *}
  {* SE A ECF FOR BEMATECH DARUMA OU SWEDA.      *}
  {********************************************PZ*}
  If ((Pos('BEMATECH', strModEcf) > 0) Or
      (Pos('DARUMA'  , strModEcf) > 0) Or
      (Pos('SWEDA'   , strModEcf) > 0) Or
      (Pos('ELGIN'   , strModEcf) > 0) Or
      (Pos('EPSON'   , strModEcf) > 0)) Then
    btnImpRed.Enabled := True
  Else
    btnImpRed.Enabled := False;

  btnFormasPagto.Enabled := SameText(BEMATECH20_40, strModEcf);
  If (Not btnFormasPagto.Enabled) Then
    btnFormasPagto.Enabled := SameText(BEMATECH_MP20, strModEcf);

  If (Not btnFormasPagto.Enabled) Then
    btnFormasPagto.Enabled := SameText(DARUMA_FS700_SU, strModEcf);

  btnParEcf.Enabled := ((Pos('EPSON', AnsiUpperCase(strModEcf)) > 0) Or (Pos('SWEDA', AnsiUpperCase(strModEcf)) > 0) Or (Pos('DARUMA', AnsiUpperCase(strModEcf)) > 0));

end;

function TfrmGerImpFiscais.fSemECF: Boolean;
begin
  Result := True;
  If Assigned(VS_objFiscal) Then
    Result := False
  Else
  Begin
    fMensagem('ATENÇÃO!', 'Esta operação requer uma Impressora Fiscal (ECF).' + #13#10 +
                          'Feche o Sistema AUTCOM e tente conectar novamente com a impressora.' + #13#10 +
                          'Caso o problema persista, entre em contato com o responsável.', ['&Ok']);
  End;
end;

procedure TfrmGerImpFiscais.btnLeituraxClick(Sender: TObject);
begin
  inherited;

  pLeituraX;
end;

procedure TfrmGerImpFiscais.btnReducaozClick(Sender: TObject);
  Var
    strData, strHora: String;
    blnReducaoDia: Boolean;
    strMsgSen: String;
begin
  inherited;

  blnReducaoDia := True;
  If Not fCupomFiscalImpresso('=', VS_Date) Then
  Begin
    strMsgSen := 'Há cupons pendentes de hoje. Confirma emitir a redução Z?';

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto(strMsgSen);

    objLiberacao.strDirAce := 'RDZIFP';
    objLiberacao.strMsgSen := strMsgSen;
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.blnUsarSenhaFixa := False;
    objLiberacao.blnSempreVariavelUsuario := True;

    blnReducaoDia := objLiberacao.fLibera;
  End;

  If Not blnReducaoDia Then
  Begin
    Exit;
  End;

  If Not fCupomFiscalImpresso('<', VS_Date) Then
  Begin
    If fMensagem('', 'Há cupons não impressos de dias anteriores. Deseja realizar sua impressão agora?', ['&Sim', '&Não']) = 1 Then
    Begin
      pImprimeCuponsPendentes(False);
    End;
  End;

  If Assigned(VS_objFiscal) Then
  Begin
    pReducaoZNovo;
    Exit;
  End;

  If fMensagem('AVISO', 'Imprimir Redução(Z)?', ['&Sim', '&Não']) = 2 Then
    Exit;

  ecfFiscal := TUntFiscal.Create;
  ecfFiscal.strCodVen := strLoginUsuarioLogado;
  ecfFiscal.strNomVen := fRetNomeOperador(strLoginUsuarioLogado);

  Try

    pCriarFormularios(TfrmDigHoraRedZ, frmDigHoraRedZ);
    frmDigHoraRedZ.ShowModal;

    If (frmDigHoraRedZ.ModalResult = mrOk) Then
    Begin

      strData := '';
      strHora := '';

      If frmDigHoraRedZ.chkHorEcf.Checked Then
      Begin
        strData := FormatDateTime('dd/mm/yyyy', VS_Date);
        strHora := frmDigHoraRedZ.mskHorEcf.Text + ':00';
      End;

      Try

        pCriarFormularios(TfrmWaitWindow, frmWaitWindow);
        frmWaitWindow.lblTexto.Caption := 'Aguarde, Imprimindo Redução(Z)';
        frmWaitWindow.tmrWait.Enabled := False;

        Try

          If Not ecfFiscal.pSetModEcf( strModEcf ) Then
          Begin
            fMensagem('ATENÇÃO!', 'Não foi possível setar o Modelo da Impressora. Verifique o Modelo Configurado!', ['&Ok']);
            Exit;
          End;

          If Not ecfFiscal.fIniciaEcf( strCodErr, strPatIni, strPorta ) Then
          Begin
            fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
            Exit;
          End;

          If Not ecfFiscal.fRetImpLigada( strCodErr ) Then
          Begin
            fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
            Exit;
          End;

          //Tela de Espera
          AnimateWindow(frmWaitWindow.Handle, 200, AW_BLEND);
          frmWaitWindow.Show;
          frmWaitWindow.Refresh;

          Try

            ecfFiscal.fReducaoZ( strData, strHora, strCodErr, False );
            If fEmptyStr(ecfFiscal.fRetMensErro( strCodErr, True )) Then
            Begin
              pImprimeCuponsPendentes(True);
            End;

          Finally
            If Not ecfFiscal.fFinalizaEcf( strCodErr ) Then
            Begin
              fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
            End;
          End;

        Except
          fMensagem('ATENÇÃO!', 'Não foi possível emitir a Redução(Z). Verifique as configurações do sistema!', ['&Ok']);
        End;

        frmWaitWindow.Close;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[frmGerImpFiscais.btnReducaozClick]');
        End;
      End;

      pFreeAndNil(frmWaitWindow);

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmGerImpFiscais.pReducaoZNovo]');
    End;
  End;

  pSalvaReducao(strData);

  pFreeAndNil(frmDigHoraRedZ);

  ecfFiscal.Free;

end;

procedure TfrmGerImpFiscais.btnUltRdzClick(Sender: TObject);
  Var
    drzDadosRed : TDadosReducao;
    intCnt : Integer;
begin
  inherited;

  If fSemECF Then
    Exit;

  If fMensagem('AVISO', 'Exibir dados da última redução Z?', ['&Sim', '&Não']) = 2 Then
    Exit;

  If (VS_objFiscal.fDadosUltimaReducao(drzDadosRed)) Then
  Begin
    pCriarFormularios(TfrmObservacao, frmObservacao);
    Try
      frmObservacao.lblMensagem.Caption := 'Dados da Última Redução Z';
      frmObservacao.memObs.Lines.Add('CRZ: ' + drzDadosRed.strNumCrz);
      frmObservacao.memObs.Lines.Add('COORZ: ' + drzDadosRed.strNumCOORZ);
      frmObservacao.memObs.Lines.Add('CRO: ' + drzDadosRed.strNumCRO);
      frmObservacao.memObs.Lines.Add('DATA MOV: ' + FormatDateTime('dd/mm/yyyy',  drzDadosRed.dtaDtaMov));

      frmObservacao.memObs.Lines.Add('TOTALIZADORES: ');
      For intCnt := Low(drzDadosRed.arrTotali) To High(drzDadosRed.arrTotali) Do
        frmObservacao.memObs.Lines.add(drzDadosRed.arrTotali[intCnt].strCodTot + ': ' + FormatFloat('#,##0.00', drzDadosRed.arrTotali[intCnt].fltValAcu));

      frmObservacao.ShowModal;
    Finally
      pFreeAndNil(frmObservacao);
    End;
  End
  Else
    fMensagem('ATENÇÃO!', 'Não foi possível exibir os dados da última redução Z!', ['&OK']);
end;

function TfrmGerImpFiscais.fCupomFiscalImpresso(strCondicao: String; dtaData: TDateTime): Boolean;
  Var
    qrySelect: TUniQuery;
begin
  qrySelect := fCriaQuery;

  Try
    With qrySelect Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(' SELECT "TRUE" ');
      SQL.Add('   FROM MOVGER ');
      SQL.Add('  WHERE GER_DTAENT ' + strCondicao + ' :DTAENT ');
      SQL.Add('    AND GER_CODEMP = :CODEMP ');
      SQL.Add('    AND GER_ESPDOC IN ("IF", "IV") ');
      SQL.Add('    AND GER_IMPRES = 0 ');

      SQL.Add('  UNION ALL   ');

      SQL.Add(' SELECT "TRUE" ');
      SQL.Add('   FROM NOTGER ');
      SQL.Add('  WHERE GER_DTAENT ' + strCondicao + ' :DTAENT ');
      SQL.Add('    AND GER_CODEMP = :CODEMP ');
      SQL.Add('    AND GER_ESPDOC IN ("IF", "IV") ');
      SQL.Add('    AND GER_IMPRES = 0 ');

      ParamByName('DTAENT').AsDateTime := dtaData;
      ParamByName('CODEMP').AsString   := VS_strCodEmp;
      Open;

      If Not IsEmpty Then
        Result := False
      Else
        Result := True;
    End;

  Finally

    FreeAndNil(qrySelect);

  End;
end;

procedure TfrmGerImpFiscais.btnArqMFDClick(Sender: TObject);
begin
  inherited;

  If fSemECF Then
    Exit;

  Try
    pCriarFormularios(TfrmMenuFiscalExpMFD, frmMenuFiscalExpMFD);
    frmMenuFiscalExpMFD.pnlCabecalho.Caption := 'Arquivo MFD';
    frmMenuFiscalExpMFD.Height := 275;
    frmMenuFiscalExpMFD.BorderStyle := bsDialog;
    frmMenuFiscalExpMFD.Position := poOwnerFormCenter;
    frmMenuFiscalExpMFD.blnEspelho := False;
    frmMenuFiscalExpMFD.ShowModal;
  Finally
    pFreeAndNil(frmMenuFiscalExpMFD);
  End;
end;

procedure TfrmGerImpFiscais.btnCanCupomClick(Sender: TObject);
  var
    fslFiscal : TFiscal;
begin
  inherited;

  {************************************************}
  {* VERIFICA SE EXISTE UM CUPOM ABERTO E CANCELA *}
  {*********************************************RN*}
  fslFiscal := TFiscal.fCriarImpressora(Self, strModEcf, '', '');
  Try
    If fslFiscal <> Nil Then
    Begin
      If (strModEcf <> DARUMA_FS700_SU) Then
      Begin
        If fslFiscal.fVerificaCupomAberto Then
        Begin
          If VS_objFiscal.fCancelaCupom Then
            pMensagemOK('Cupom cancelado com sucesso!'); 
        End
        Else fMensagem('ATENÇÃO!', 'Para cancelar o cupom no ECF utilize a rotina de cancelamento de documentos.', ['&Ok']);
      End
      Else fMensagem('ATENÇÃO!', 'Para cancelar o cupom no ECF utilize a rotina de cancelamento de documentos.', ['&Ok']);
    End
    Else
    Begin
      ecfFiscal := TUntFiscal.Create;
      ecfFiscal.pSetModEcf( strModEcf );
      ecfFiscal.fIniciaEcf( strCodErr, strPatIni, strPorta );
      ecfFiscal.fRetImpLigada( strCodErr );
      If ecfFiscal.fVerificaCupomAberto Then
      Begin
        If ecfFiscal.fCancelaCupom(strCodErr) Then
          pMensagemOK('Cupom cancelado com sucesso!');
      End
      Else fMensagem('ATENÇÃO!', 'Para cancelar o cupom no ECF utilize a rotina de cancelamento de documentos.', ['&Ok']);
    End;
  Except
    On E: Exception do
      pMensagensErro(E.Message, '');
  End;
    
  FreeAndNil(fslFiscal);
  FreeAndNil(ecfFiscal);
end;



procedure TfrmGerImpFiscais.btnLeiMemFisClick(Sender: TObject);
begin
  inherited;

  Try
    pCriarFormularios(tfrmFisLeituraMemoria, frmFisLeituraMemoria);

    frmFisLeituraMemoria.strPatIni := strPatIni;
    frmFisLeituraMemoria.strModEcf := strModEcf;
    frmFisLeituraMemoria.strPorta  := strPorta;

    frmFisLeituraMemoria.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmGerImpFiscais.btnLeiMemFisClick]');
    End;
  End;

  pFreeAndNil(frmFisLeituraMemoria);

end;

procedure TfrmGerImpFiscais.btnEspMFDClick(Sender: TObject);
begin
  inherited;

  If fSemECF Then
    Exit;

  Try
    pCriarFormularios(TfrmMenuFiscalExpMFD, frmMenuFiscalExpMFD);
    frmMenuFiscalExpMFD.pnlCabecalho.Caption := 'Espelho MFD';
    frmMenuFiscalExpMFD.Height := 275;
    frmMenuFiscalExpMFD.BorderStyle := bsDialog;
    frmMenuFiscalExpMFD.Position := poOwnerFormCenter;
    frmMenuFiscalExpMFD.blnEspelho := True;
    frmMenuFiscalExpMFD.ShowModal;
  Finally
    pFreeAndNil(frmMenuFiscalExpMFD);
  End;

end;

procedure TfrmGerImpFiscais.btnFormasPagtoClick(Sender: TObject);
begin
  inherited;

  If fMensagem('AVISO', 'Deseja programar as Formas de Pagamento?', ['&Sim', '&Não']) = 2 Then
    Exit;

  ecfFiscal := TUntFiscal.Create;
  ecfFiscal.strCodVen := strLoginUsuarioLogado;
  ecfFiscal.strNomVen := fRetNomeOperador(strLoginUsuarioLogado);

  Try

    pCriarFormularios(TfrmWaitWindow, frmWaitWindow);
    frmWaitWindow.lblTexto.Caption := 'Aguarde, programando Formas de Pagamento';
    frmWaitWindow.tmrWait.Enabled := False;

    Try

      If Not ecfFiscal.pSetModEcf( strModEcf ) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não foi possível setar o Modelo da Impressora. Verifique o Modelo Configurado!', ['&Ok']);
        Exit;
      End;

      If Not ecfFiscal.fIniciaEcf( strCodErr, strPatIni, strPorta ) Then
      Begin
        fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
        Exit;
      End;

      If Not ecfFiscal.fRetImpLigada( strCodErr ) Then
      Begin
        fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
        Exit;
      End;

      //Tela de Espera

      AnimateWindow(frmWaitWindow.Handle, 200, AW_BLEND);
      frmWaitWindow.Show;
      frmWaitWindow.Refresh;

      Try                                  

        ecfFiscal.fCadastraFormasPagamento( strCodErr );

        ecfFiscal.fRetMensErro( strCodErr, True );

      Finally
        If Not ecfFiscal.fFinalizaEcf( strCodErr ) Then
        Begin
          fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
        End;
      End;

    Except
      fMensagem('ATENÇÃO!', 'Não foi possível programar as Formas de Pagamento. Verifique as configurações do sistema!', ['&Ok']);
    End;

    frmWaitWindow.Close;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmGerImpFiscais.btnFormasPagtoClick]');
    End;
  End;

  pFreeAndNil(frmWaitWindow);
  ecfFiscal.Free;

end;

procedure TfrmGerImpFiscais.btnImpRedClick(Sender: TObject);
begin
  inherited;
  pCriarForm(TfrmImpReducaoZ, frmImpReducaoZ);
end;

procedure TfrmGerImpFiscais.btnParEcfClick(Sender: TObject);
begin
  inherited;

  If fMensagem('AVISO', 'Imprimir Parametros do ECF?', ['&Sim', '&Não']) = 2 Then
    Exit;

  ecfFiscal := TUntFiscal.Create;
  ecfFiscal.strCodVen := strLoginUsuarioLogado;
  ecfFiscal.strNomVen := fRetNomeOperador(strLoginUsuarioLogado);

  Try

    pCriarFormularios(TfrmWaitWindow, frmWaitWindow);
    frmWaitWindow.lblTexto.Caption := 'Aguarde, Imprimindo Parametros';
    frmWaitWindow.tmrWait.Enabled := False;

    Try

      If Not ecfFiscal.pSetModEcf( strModEcf ) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não foi possível setar o Modelo da Impressora. Verifique o Modelo Configurado!', ['&Ok']);
        Exit;
      End;

      If Not ecfFiscal.fIniciaEcf( strCodErr, strPatIni, strPorta ) Then
      Begin
        fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
        Exit;
      End;

      If Not ecfFiscal.fRetImpLigada( strCodErr ) Then
      Begin
        fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
        Exit;
      End;


      Try

        ecfFiscal.fParEcf;

      Finally
        If Not ecfFiscal.fFinalizaEcf( strCodErr ) Then
        Begin
          fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
        End;
      End;

    Except
      fMensagem('ATENÇÃO!', 'Não foi possível emitir os parametros da ecf. Verifique as configurações do sistema!', ['&Ok']);
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmGerImpFiscais.btnParEcfClick]');
    End;
  End;

  pFreeAndNil(frmWaitWindow);
  ecfFiscal.Free;

end;

procedure TfrmGerImpFiscais.pReducaoZNovo;
  Var
    frmMenuFiscalMovEcf: TfrmMenuFiscalMovEcf;
    drzDadosRed: TDadosReducao;
    strData, strHora: String;
begin

  If fMensagem('ATENÇÃO', 'Efetuar Redução Z?', ['&Sim', '&Não']) = 1 Then
  Begin

    Try

      pCriarFormularios(TfrmDigHoraRedZ, frmDigHoraRedZ);
      frmDigHoraRedZ.ShowModal;

      If (frmDigHoraRedZ.ModalResult = mrOk) Then
      Begin

        strData := '';
        strHora := '';

        If frmDigHoraRedZ.chkHorEcf.Checked Then
        Begin
          strData := FormatDateTime('dd/mm/yyyy', VS_Date);
          strHora := frmDigHoraRedZ.mskHorEcf.Text + ':00';
        End;

        If VS_objFiscal.fReducaoZ(strData, strHora) Then
        Begin

          If fCfgSis('IMPRDZ', varInteger) = 1 Then
          Begin

            If (VS_objFiscal.fDadosUltimaReducao(drzDadosRed)) Then
            Begin
              pCriarFormularios(TfrmMenuFiscalMovEcf, frmMenuFiscalMovEcf);
              frmMenuFiscalMovEcf.blnGerarDoDia := True;
              frmMenuFiscalMovEcf.dtaReducao := drzDadosRed.dtaDtaMov;
              strData := DateToStr(drzDadosRed.dtaDtaMov);
              frmMenuFiscalMovEcf.ShowModal;
              pFreeAndNil(frmMenuFiscalMovEcf);
            End
            Else
            Begin
              fMensagem('ATENÇÃO!', 'Não foi possível realizar a exportação da movimentação do ECF. ' +
                                    'Por favor, realize-a através do Menu Fiscal.', ['&Ok']);
            End;

          End;

          pImprimeCuponsPendentes(True);

        End;

      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmGerImpFiscais.pReducaoZNovo]');
      End;
    End;

    pFreeAndNil(frmDigHoraRedZ);

    pSalvaReducao(strData);

  End;

end;

procedure TfrmGerImpFiscais.pSalvaReducao(strData: String);
Var tdados : TDadosReducao;
    ecffiscalbrd : TFiscalBrd;
    blnObjFiscalCriado: Boolean;

    procedure pLog(strTexto: String);
      Var
        strNomeDir: String;
        strNomeArq: String;
        stlLog: TStringList;
    begin
      strNomeDir := ExtractFilePath(Application.ExeName) +  '\LOGRDZ';
      strNomeArq := strNomeDir + '\' + strLoginUsuarioLogado + '_' + FormatDateTime('ddmmyyyy_hhnnss', fNow()) + '.txt';
      
      If Not DirectoryExists(strNomeDir) Then
        CreateDir(strNomeDir);

      stlLog := TStringList.Create;
      If FileExists(strNomeArq) Then
        stlLog.LoadFromFile(strNomeArq);

      stlLog.Add(strTexto);
      stlLog.SaveToFile(strNomeArq);
      FreeAndNil(stlLog);
    end;
begin
  pLog('Inicio pSalvaReducao: ' + strData);
  try
    blnObjFiscalCriado := Assigned(VS_objFiscal);

    If Not blnObjFiscalCriado Then
      ecffiscalbrd := TFiscalBrd.Create(Self,strModEcf)
    Else
      ecffiscalbrd := VS_objFiscal;

    If ecffiscalbrd.fDadosUltimaReducao(tdados) Then
      strData := DateToStr(tdados.dtaDtaMov);

    If Not blnObjFiscalCriado Then
      FreeAndNil(ecffiscalbrd);

    pLog('Irá chamar Form');

    pCriarFormularios(TfrmImpReducaoZ, frmImpReducaoZ);

    If fCfgSis('IMPRDZ', varInteger) = 2 Then
    begin
      pLog('Exit!!!!!');
      Exit;
    End;

    frmImpReducaoZ.pnlMsgRdZ.Visible := True;
    frmImpReducaoZ.mskDtaIni.Enabled := False;
    frmImpReducaoZ.mskDtaIni.Text := strData;
    frmImpReducaoZ.mskDtaFin.Enabled := False;
    frmImpReducaoZ.mskDtaFin.Text := strData;
    frmImpReducaoZ.blnImportaAutomatico := True;
    frmImpReducaoZ.ShowModal;

    pLog('Finalizou Rotina');
  finally
    FreeAndNil(frmImpReducaoZ);
  end;
  pLog('Fim pSalvaReducao');
end;

procedure TfrmGerImpFiscais.FormCreate(Sender: TObject);
begin
  inherited;
  objLiberacao := TLiberacao.Create;
  If (VS_strUsaPaf = 'S') Then
    pCarregarSignBema;

  If Not DirectoryExists('PAF') Then
    CreateDir('PAF');

  blnFechaForm := False;
end;

procedure TfrmGerImpFiscais.FormDestroy(Sender: TObject);
begin
  If Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  inherited;
end;

procedure TfrmGerImpFiscais.FormPaint(Sender: TObject);
begin
  inherited;

  If blnFechaForm Then
    Close;

end;

procedure TfrmGerImpFiscais.pImprimeCuponsPendentes(blnMostraMsg: Boolean);
  Var
    impressor: TImpressorDeCupons;
    stlProblemas: TStringList;
begin
  impressor := TImpressorDeCupons.Create;
  impressor.SetMostraMsg(blnMostraMsg);
  impressor.pImrpimeCupons;
  stlProblemas := impressor.fProblemas;
  FreeAndNil(impressor);

  Try
  
    If stlProblemas.Count > 0 Then
    Begin
      pCriarFormularios(TfrmMemo, frmMemo);

      Try
        stlProblemas.Insert(0, 'Os cupons abaixo não puderam ser impressos. Por favor, imprimir no F8 no Resumo de Caixa.');
        frmMemo.cxMemo.Lines.Assign(stlProblemas);
        frmMemo.ShowModal;
      Finally
        FreeAndNil(frmMemo);
      End;

    End;

  Finally
    FreeAndNil(stlProblemas);
  End;
end;

end.


