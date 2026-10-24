{***************************}
{* qryConPor -> CADPOR     *}
{* qryConBco -> CADBCO     *}
{************************JB*}
{***************************}
{* qryCadBco -> CADBCO     *}
{************************RV*}
unit untBaixaCtpAnalitica;

interface

uses
  Classes, Controls, Forms, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  EditFocus, Menus, Uni, Mask, MaskEditFocus, AppEvnts, UniClientDataSet, frxClass,
  DB, BitBtnLockedIncrem, frxExportCSVTestabilidade, untTypesSistema, untFuncFat,
  untLiberacao,untTValidaCorrespondenteContabil;

type
  TfrmBaixaCtpAnalitica = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    pnlFundo: TPanel;
    pnlCamBco: TPanel;
    lblCodBco: TLabel;
    edtCodBco: TEditFocus;
    edtNomBco: TEditFocus;
    edtNumAge: TEditFocus;
    lblNumAge: TLabel;
    Label3: TLabel;
    edtConCor: TEditFocus;
    edtNumChq: TEditFocus;
    lblNumChq: TLabel;
    Label1: TLabel;
    mskBomPara: TMaskEditFocus;
    edtFavorecido: TEditFocus;
    Label2: TLabel;
    pnlCamPor: TPanel;
    pnlCamHis: TPanel;
    lblHist1: TLabel;
    edtHist01: TEditFocus;
    edtHist02: TEditFocus;
    lblHist2: TLabel;
    pnlCamPo1: TPanel;
    Label5: TLabel;
    edtPorBai: TEditFocus;
    edtDesPor1: TEditFocus;
    Panel1: TPanel;
    Label4: TLabel;
    edtDocBai: TEditFocus;
    lblDtaBai: TLabel;
    mskDtaPag: TMaskEditFocus;
    lblEmiCheque: TLabel;
    edtEmiCheque: TEditFocus;
    Label6: TLabel;
    mskDtaEmi: TMaskEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure edtPorBaiKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure edtCodBcoKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtEmiChequeExit(Sender: TObject);
  private
    { Private declarations }
    qryConPor: TUniQuery;
    qryConBco: TUniQuery;
    qryCadBco: TUniQuery;
    arrMenSag: TStringArray;

    strDtaRec: String;
    objLiberacao : TLiberacao;
    FValidaCorrespondenteContabil: TValidaCorrespondenteContabil;

    procedure pCarregaPortador;
    procedure pHabilitaCampos(strHabilitar: String);
    procedure pCarregaBanco;
    function fRetFavorecido: String;
    procedure pAtualizaDadosCheque(strCodPor, strCodEmp: String);
    function fChamaSenhaVariavel(strMsg : String = '';
      strDirAce : String = ''; strCfgSis : String = ''; strMsgSen : String = '';
      strOperador : String = ''; strNTrava : String = ''): Boolean;
    function fExisteCheque(strCodBco, strNumAge, strNumChq, strConCor: String): Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strPorBai: String;
    strHist01: String;
    strHist02: String;
    strDocBai: String;
    blnConfirma: Boolean;
    strCodBco: String;
    strNumAge: String;
    strNumChq: String;
    strDtaBom: String;
    strDtaEmi: String;
    strFavore: String;
    strConCor: String;
    dtaDtaCad: TDateTime;
    fltValPag: Double;
    dtaDtaBai: TDateTime;

    cdsCtaPag : TUniClientDataSet;

    blnResumoCaixa: Boolean;
  end;


implementation

uses SysUtils, Math, untFuncoesSimples, untPesqAux, untConsultas;

{$R *.dfm}

{ TfrmBaixaCtpAnalitica }

function TfrmBaixaCtpAnalitica.fChamaSenhaVariavel(strMsg : String = '';
      strDirAce : String = ''; strCfgSis : String = ''; strMsgSen : String = '';
      strOperador : String = ''; strNTrava : String = ''): Boolean;
begin
Result := True;
  While (True) Do
  Begin
    Try
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto(strMsg);

      objLiberacao.strDirAce := strDirAce;
      objLiberacao.strSenLib := fCfgSis(strCfgSis);
      objLiberacao.strMsgSen := strMsgSen;
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := strOperador;
      objLiberacao.strCodDig := strOperador;
      objLiberacao.strOperador := strOperador;

      If (fMensagemLiberacao(objLiberacao, strNTrava, nil)) Then

        Break

      else
        If (fMensagem('', 'Senha Incorreta!', ['&Novamente', '&Desistir']) = 2) Then
        Begin
          Result := False;
          Exit;
        End;

    Finally
      FillChar(arrMenSag, SizeOf(arrMenSag), #0);
    End;

  End;
end;

function TfrmBaixaCtpAnalitica.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O PORTADOR                     *}
    {**************************************MV*}
    If (Sender = edtPorBai) Then
    Begin
      If (edtPorBai.Visible) And (edtPorBai.Enabled) Then
      Begin
        If fEmptyStr(edtPorBai.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Portador da Baixa deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          pCarregaPortador;
          If qryConPor.FieldByName('POR_CODPOR').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
            Result := False;
          End

          Else If Not FValidaCorrespondenteContabil.PortadorPossuiCorrespondenteContabil(edtPorBai.Text,VS_strCodEmp) Then
          Begin
            Result := False;
          End

          Else If (Not fPortadorPermiteBaixa(edtPorBai.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
            Result := False;
          End

          Else If ((Not blnResumoCaixa) And (Not fPortadorPermiteMovimentoBancario(edtPorBai.Text))) Or
                  ((blnResumoCaixa) And (fCfgSis('CTBPAG', varBoolean)) And (Not fPortadorPermiteMovimentoBancario(edtPorBai.Text))) Then
          Begin
            fMensagem('ATENÇÃO', 'Esse portador não tem permissão para gravação do movimento bancário!',['&O K']);
            Result := False;
          End

          {********************************************}
          {* VALIDA DATA DE SALDO INICIAL DO PORTADOR *}
          {*****************************************JU*}
          Else If fRetDataPortador(edtPorBai.Text) > dtaDtaBai Then
          Begin
            fMensagem('ATENÇÃO!', 'A data de saldo inicial deste portador (' + FormatDateTime('dd/mm/yyyy', fRetDataPortador(edtPorBai.Text)) +
                      ') é posterior à data de pagamento informada (' + FormatDateTime('dd/mm/yyyy', dtaDtaBai) + ')!', ['&O K']);
            Result := False;
          End
          Else If Not fEmpresaTemAcessoPortador(edtPorBai.Text, VS_strCodEmp) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End;

          If Result Then
          Begin
            If fCfgSis('DACPOR', varBoolean) Then
            Begin
              If Pos(edtPorBai.Text, strPortadoresOperador) <= 0 Then
              Begin
                fMensagem('ATENÇÃO!', 'Você não permissão para utilizar este portador!', ['&O k']);
                Result := False;
              End;
            End;
          End;

        End;
      End;
    End

    Else If (Sender = mskDtaEmi) Then
    Begin
      if edtEmiCheque.Text = 'S' Then
      begin
        If (StrToDateDef(mskDtaEmi.Text, 0) = 0) Then
        Begin
          fMensagem('', 'A data de emissão deve ser informada!', ['&O k']);
          Result := False;
        End
        else
        If (StrToDateDef(mskDtaEmi.Text, 0) <= 0) Then
        Begin
          fMensagem('', 'Data informada é inválida. Necessário correção!', ['&O k']);
          Result := False;
        End;
      end;

    End

    Else If Sender = mskBomPara Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskBomPara.Text)) Then
      Begin
        If StrToDateDef(mskBomPara.Text, 0) <= 0 Then
        Begin
          fMensagem('', 'Data informada é inválida. Necessário correção!', ['&O k']);
          Result := False;
        End
        Else If StrToDate(mskBomPara.Text) <= StrToDate(mskDtaEmi.Text) Then
        Begin
          fMensagem('', 'A data para depósito "Bom Para" deve ser maior que a data de "Emissão". ' +
                        'Caso a data para depósito do cheque seja a mesma da data da emissão, não informar data no campo "Bom Para"!', ['&O k']);
          Result := False;
        End;

      End;
    End

    {*******************************************}
    {* VALIDA EMITIR CHEQUE                    *}
    {****************************************AC*}
    Else If (Sender = edtEmiCheque) Then
    Begin
      If (Copy((Sender As TEditFocus).Text, 1, 1) <> 'S') And
         (Copy((Sender As TEditFocus).Text, 1, 1) <> 'N') Then
      Begin
        Result := False;
      End;

      If Result Then
      Begin
        pHabilitaCampos(edtEmiCheque.Text);
      End;
    End

    {*******************************************}
    {* VALIDA BANCO                            *}
    {****************************************AC*}
    Else If (Sender = edtCodBco) And (edtCodBco.Visible) And (edtEmiCheque.Text = 'S') Then
    Begin
      If fEmptyStr(edtCodBco.Text) Then
      Begin
        fMensagem('Informação', 'O Código do Banco deve ser Informado!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaBanco;

        If (qryConBco.FieldByName('BCO_CODBCO').IsNull) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse Banco não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;
    End

    {*******************************************}
    {* VALIDA AGÊNCIA                          *}
    {****************************************AC*}
    Else If (Sender = edtNumAge) And (edtNumAge.Visible) And (edtEmiCheque.Text = 'S') Then
    Begin
      If fEmptyStr(edtNumAge.Text) Then
      Begin
        fMensagem('Informação', 'O Código da Agência deve ser Informado!', ['&O k']);
        Result := False;
      End
    End

    {*******************************************}
    {* VALIDA NÚMERO DO CHEQUE                 *}
    {****************************************AC*}
    Else If (Sender = edtNumChq) And (edtNumChq.Visible) And (edtEmiCheque.Text = 'S') Then
    Begin
      If fEmptyStr(edtNumChq.Text) Then
      Begin
        fMensagem('Informação', 'O Número do Cheque deve ser Informado!', ['&O k']);
        Result := False;
      End
      Else
        edtNumChq.Text := fStrZero(edtNumChq.Text,10);

      If Result Then
      Begin
        If fExisteCheque(edtCodBco.Text, edtNumAge.Text, edtNumChq.Text, edtConCor.Text) Then
        Begin
          pMensagemOk('Já existe um cheque com Banco, Agência, Número de Cheque e Conta Corrente iguais as informações digitadas!');
          Result := False;
        End;
      End;

    End

    {*******************************************}
    {* VALIDA CONTA CORRENTE                   *}
    {****************************************AC*}
    Else If (Sender = edtConCor) And (edtConCor.Visible) And (edtEmiCheque.Text = 'S') Then
    Begin
      If fEmptyStr(edtConCor.Text) Then
      Begin
        fMensagem('Informação', 'A Conta Corrente deve ser Informada!', ['&O k']);
        Result := False;
      End
      Else
        edtConCor.Text := fStrZero(edtConCor.Text,12);
    End

    {*****************************************}
    {* VALIDA A DATA DA BAIXA                *}
    {**************************************MV*}
    Else If (Sender = mskDtaPag) And mskDtaPag.Visible Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaPag.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data da Baixa deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If (StrToDateDef(mskDtaPag.Text,0) < VS_Date) And
           (Not fEmptyStr(fCfgSis('CTPRET'))) And (StrToDateDef(mskDtaPag.Text,0) <> StrToDateDef(strDtaRec,0)) Then
        Begin
          If(Not fChamaSenhaVariavel('Permitir Baixa com Data Retroativa', 'CTPDTARET',
          'CTPRET', 'Baixa com data retroativa', strLoginUsuarioLogado)) Then
            Result := False
          Else
            strDtaRec := mskDtaPag.Text;
        End;

      End;
    End;

    If (Sender = mskDtaPag) Then
    Begin
      If Not FEmptyStr(fTiraCaracEspeciais((Sender as TMaskEditFocus).Text)) Then
        If (StrToDateDef((Sender as TMaskEditFocus).Text, 0) <= 0) Then
        Begin
          fMensagem('', 'Data informada é inválida! Necessário correção.', ['&O k']);
          Result := False;
        End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmBaixaCtpAnalitica.pCarregaPortador;
begin
  pPesquisaCadPor(Nil, qryConPor, edtPorBai.Text);
  With qryConPor Do
  Begin
    edtDesPor1.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmBaixaCtpAnalitica.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryCadBco);
  FreeAndNil(FValidaCorrespondenteContabil);
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
end;

procedure TfrmBaixaCtpAnalitica.FormCreate(Sender: TObject);
begin
  inherited;
  strDtaRec := '';
  qryConPor := fCriaQuery(Self);
  qryCadBco := fCriaQuery(Self);
  qryConBco := qryCadBco;
  objLiberacao := TLiberacao.Create;

  blnConfirma := False;
  FValidaCorrespondenteContabil :=  TValidaCorrespondenteContabil.Create;
end;

procedure TfrmBaixaCtpAnalitica.edtPorBaiKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqPortador(conSimples, Self, edtPorBai, edtDesPor1, qryConPor, Key, arrSel) Then
  Begin
    If (fValidaCampos(edtPorBai)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

  pCarregaPortador;

end;

procedure TfrmBaixaCtpAnalitica.FormShow(Sender: TObject);
begin
  inherited;
  {*******************************************}
  {* DEFAULT                                 *}
  {****************************************AC*}
  edtEmiCheque.Text := 'N';

  pHabilitaCampos(edtEmiCheque.Text);

  strCodBco := '';
  strNumAge := '';
  strNumChq := '';
  strConCor := '';

  If blnResumoCaixa Then
  Begin
    If (Not fEmptyStr(fCfgSis('PORPGR'))) And edtPorBai.Visible And edtPorBai.Enabled Then
    Begin
      edtPorBai.Text := fCfgSis('PORPGR');
      pCarregaPortador;
    End;
  End;

end;

procedure TfrmBaixaCtpAnalitica.btnCancelaDadosClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmBaixaCtpAnalitica.btnConfirmaDadosClick(Sender: TObject);
  var
    strCfg_PORPGR: String;
begin
  If fVerificaCampos Then
  Begin
    If blnResumoCaixa Then
    Begin
      strCfg_PORPGR := fCfgSis('PORPGR');

      objLiberacao.Clear;
      If (Not fEmptyStr(strCfg_PORPGR)) Then
      Begin

        If ((Not fEmptyStr(edtPorBai.Text)) And (edtPorBai.Text <> strCfg_PORPGR)) Then
        Begin
          objLiberacao.objMsgLibera.pAddTexto('Portador selecionado diferente do portador configurado para baixa.');
          If (edtPorBai.Visible) And (edtPorBai.Text <> strCfg_PORPGR) Then
            objLiberacao.objMsgLibera.pAddTextoCaption('Portador configurado', strCfg_PORPGR + ' Portador selecionado: ' + edtPorBai.Text);

          objLiberacao.objMsgLibera.pAddQuebra;
          objLiberacao.objMsgLibera.pAddQuebra;
        End;

      End;

      If Length(arrMenSag) > 0 Then
      Begin

        objLiberacao.strDirAce := 'MUDPF9';
        objLiberacao.strSenLib := fCfgSis('MUDPF9');
        objLiberacao.strMsgSen := 'Mudança de Portador ou Plano de Contas';
        objLiberacao.blnMosMen := True;
        objLiberacao.strCodOpe := strLoginUsuarioLogado;

        If (Not objLiberacao.fLibera) Then
          Exit;
      End;

    End
    Else
    Begin
      strCfg_PORPGR := fCfgSis('PORPGR');

      If (Not fEmptyStr(strCfg_PORPGR)) Then
      Begin

        If ((Not fEmptyStr(edtPorBai.Text)) And (edtPorBai.Text = strCfg_PORPGR)) Then
        Begin
          pMensagemOk('Portador ' + strCfg_PORPGR + ' não permitido, pois está configurado para baixa de Contas a Pagar no resumo de caixa.');

          If ((Not fEmptyStr(edtPorBai.Text)) And (edtPorBai.Text = strCfg_PORPGR)) Then
            pSetFocus(edtPorBai);

          Exit;
        End;

      End;

    End;

    strPorBai   := edtPorBai.Text;
    strDocBai   := edtDocBai.Text;
    strHist01   := edtHist01.Text;
    strHist02   := edtHist02.Text;
    If (edtEmiCheque.Text = 'S') Then
    Begin
      If (fCfgSis('MAXCHQ', varDouble) > 0) And
         (fltValPag > fCfgSis('MAXCHQ', varDouble)) Then
      Begin
        fMensagem('', 'Valor a ser baixado maior que o valor máximo permitido para pagamentos em cheque!', ['&Ok']);
        pSetFocus(edtEmiCheque);
        blnConfirma := False;
        Exit;
      End;

      strCodBco := edtCodBco.Text;
      strNumAge := edtNumAge.Text;
      strNumChq := edtNumChq.Text;
      strConCor := edtConCor.Text;
    End;
    blnConfirma := True;
    strDtaBom   := mskBomPara.Text;
    strDtaEmi   := mskDtaEmi.Text;
    strFavore   := edtFavorecido.Text;
    Close;
  End;
end;

procedure TfrmBaixaCtpAnalitica.pHabilitaCampos(strHabilitar: String);
begin
  If (strHabilitar = 'N') Then
  Begin
    pnlCamBco.Visible := False;

    edtCodBco.Clear;
    edtNumAge.Clear;
    edtNumChq.Clear;

    mskBomPara.Clear;
    mskDtaEmi.Clear;
    edtFavorecido.Clear;

    Self.Height := IIF(pnlCamPo1.Visible, pnlCamPo1.Height, 0) +
                   IIF(Panel1.Visible, Panel1.Height, 0) +
                   IIF(pnlCamHis.Visible, pnlCamHis.Height, 0) +
                   pnlConfirma.Height + pnlStatus.Height +
                   pnlConfirma.Height + pnlStatus.Height;

  End
  Else
  Begin
    pnlCamBco.Visible := True;

    Self.Height := IIF(pnlCamPo1.Visible, pnlCamPo1.Height, 0) +
                   IIF(Panel1.Visible, Panel1.Height, 0) +
                   IIF(pnlCamHis.Visible, pnlCamHis.Height, 0) +
                   pnlConfirma.Height + pnlStatus.Height +
                   pnlConfirma.Height + pnlStatus.Height +
                   pnlCamBco.Height;

  End;
end;

procedure TfrmBaixaCtpAnalitica.edtCodBcoKeyPress(Sender: TObject;
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
    if fValidaCampos(edtCodBco, True) then
      SelectNext(ActiveControl, True, True);
    pCarregaBanco;
  End;

end;

procedure TfrmBaixaCtpAnalitica.edtEmiChequeExit(Sender: TObject);
  Var
    strCodPor : String;
begin
  inherited;
  If edtEmiCheque.Text = 'S' Then
  Begin

    If (Assigned(cdsCtaPag)) And (cdsCtaPag.Active) Then
      edtFavorecido.Text := fRetFavorecido;

    mskDtaEmi.Text := FormatDateTime('dd/mm/yyyy', Date);

    If (edtPorBai.Visible) And (Not fEmptyStr(edtPorBai.Text)) Then
      strCodPor := edtPorBai.Text;

    If Not fEmptyStr(strCodPor) Then
      pAtualizaDadosCheque(strCodPor, VS_strCodEmp);

  End
  Else
  Begin
    edtNumChq.Text := '';
    edtNumAge.Text := '';
    edtConCor.Text := '';
    edtCodBco.Text := '';
    mskDtaEmi.Clear;
    mskBomPara.Clear;
    pCarregaBanco;
  End;
end;

procedure TfrmBaixaCtpAnalitica.pCarregaBanco;
begin
  pPesquisaCadBco(qryCadBco, qryConBco, edtCodBco.Text);
  With qryConBco Do
  Begin
    edtNomBco.Text := FieldByName('BCO_NOMBCO').AsString;
    edtCodBco.Text := FieldByName('BCO_CODBCO').AsString;
  End;
end;

procedure TfrmBaixaCtpAnalitica.pAtualizaDadosCheque(strCodPor, strCodEmp: String);
  Var
    qryTmp : TUniQuery;
begin
  qryTmp := fCriaQuery(Self);

  With qryTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * ');
    SQL.Add('  FROM PORCHQ ');
    SQL.Add(' WHERE CHQ_CODPOR = :CODPOR ');
    SQL.Add('   AND CHQ_CODEMP = :CODEMP '); 
    ParamByName('CODPOR').AsString := strCodPor;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

    If RecordCount > 0 Then
    Begin
      edtNumChq.Text := fStrZero(IntToStr(Floor(fStrToFloat(FieldByName('CHQ_NUMCHQ').AsString) + 1)), 10);
      edtNumAge.Text := FieldByName('CHQ_NUMAGE').AsString;
      edtConCor.Text := FieldByName('CHQ_NUMCCO').AsString;
      edtCodBco.Text := FieldByName('CHQ_CODBCO').AsString;
      pCarregaBanco;
    End
    Else
    Begin
      edtNumChq.Text := '';
      edtNumAge.Text := '';
      edtConCor.Text := '';
      edtCodBco.Text := '';
      pCarregaBanco;
    End;

    Close;
  End;

  FreeAndNil(qryTmp);
end;

function TfrmBaixaCtpAnalitica.fRetFavorecido: String;
  Var
      cdsGen: TUniClientDataSet;
Begin
  cdsGen := TUniClientDataSet.Create(Self);
  With cdsGen Do
  Begin
    Data := cdsCtaPag.Data;

    Filtered := False;
    Filter := 'CTP_MARDES = ' + QuotedStr('M');
    Filtered := True;

    If RecordCount = 1 Then
      Result := FieldByName('FOR_NOMFOR').AsString
    Else
      Result := '';
  End;
  FreeAndNil(cdsGen);
End;

function TfrmBaixaCtpAnalitica.fExisteCheque(strCodBco, strNumAge, strNumChq, strConCor: String): Boolean;
  Var
    qryGen: TUniQuery;
Begin

  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    Add('SELECT * FROM CHQEMI');
    Add('WHERE ');
    Add('  EMI_CODBCO = :CODBCO AND ');
    Add('  EMI_NUMAGE = :NUMAGE AND ');
    Add('  EMI_NUMCHQ = :NUMCHQ AND ');
    Add('  EMI_CONCOR = :CONCOR     ');

    ParamByName('CODBCO').AsString := strCodBco;
    ParamByName('NUMAGE').AsString := strNumAge;
    ParamByName('NUMCHQ').AsString := strNumChq;
    ParamByName('CONCOR').AsString := strConCor;

    Open;

    Result := Not IsEmpty;

    Close;
  End;
  FreeAndNil(qryGen);
end;

end.
