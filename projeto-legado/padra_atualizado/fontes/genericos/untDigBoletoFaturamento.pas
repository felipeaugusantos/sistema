{***********************************}
{* ALGUMAS ALTERAÇÕES DESSE        *}
{* OBJETO DEVEM SER CONSIDERADAS   *}
{* NA untDigBoleto E untTDigBoleto *}
{********************************AJ*}
unit untDigBoletoFaturamento;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, DB,
  EditFocus, Menus, RLTypes, QColorLabel, frxClass, frxDBSet, Uni,
  AppEvnts, UniClientDataSet, frxDMPExport, StrUtils, frxExportPDF,
  BitBtnLockedIncrem, untZClient, frxExportCSVTestabilidade, untTypesSistema,
  untCadRec, untLiberacao, untTDigBoleto, Vcl.Mask, MaskEditFocus;

type
  TfrmDigBoletoFaturamento = class(TfrmPaiSimples)
    Label1: TLabel;
    Label2: TLabel;
    edtMorDia: TEditFocus;
    edtCodPor: TEditFocus;
    Label5: TLabel;
    Label3: TLabel;
    edtCodBco: TEditFocus;
    lblNosNum: TLabel;
    edtNosNum: TEditFocus;
    pnlConfirma: TPanel;
    edtNomBan: TEditFocus;
    edtDesPor: TEditFocus;
    pnlFundo: TPanel;
    Label6: TLabel;
    edtTipBol: TEditFocus;
    ColorLabel1: TColorLabel;
    edtMens01: TEditFocus;
    edtMens02: TEditFocus;
    chkEtiCob: TCheckBox;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    edtCartei: TEditFocus;
    edtPerMul: TEditFocus;
    lblPerMul: TLabel;
    lblCartei: TLabel;
    lblPercen: TLabel;
    btnAlterar: TBitBtnLocked;
    btnImprimirMercantil: TBitBtnLocked;
    chkEditaEmail: TCheckBox;
    FlwpnlConfirma: TFlowPanel;
    rdgOpcoes: TRadioGroup;
    lblMsgPortadorAut: TLabel;
    procedure edtMorDiaExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodBcoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure edtTipBolChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodBcoExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure edtNosNumChange(Sender: TObject);
    procedure btnImprimirMercantilClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorChange(Sender: TObject);
    procedure edtCodBcoChange(Sender: TObject);
    procedure rdgOpcoesClick(Sender: TObject);
  private
    { Private declarations }
    qryConPor: TUniQuery;
    qryConBco: TUniQuery;
    qryCadBco: TUniQuery;

    blnSemTela,
    blnVerNosN,
    blnComCart: Boolean;

    strDupFr3: String;

    strKeyAnt: String;

    objLiberacao : TLiberacao;
    strPortadorAnterior: String;

    bnlPortAutEmail,
    bnlPortAutSMS   : Boolean;

    objDigBoleto: TDigBoleto;

    procedure pCarregaPortador(blnTrocaBancoPadrao: Boolean=True);
    procedure pCarregaBanco;

    procedure pAvaliaNosNum;

    procedure pOcultaedtNosNum;
    procedure pHabilitaDesabilitaEdicaoEmail;
    procedure pDesabilitaOpcao(intOpcao: Integer);
    procedure pHabilitaOpcao(intOpcao: Integer);
    function fOpcaoHabilitada(intOpcao: Integer): Boolean;
    procedure pVerificaMostraMensagemPortador;
    procedure pCarregaRdgOpcoes;
    function fGatilhoEmailBNAtivo: Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strChave : String;
    strCodBco: String;
    fltValMor: Double;
    strCodPor: String;
    strNosNum: String;
    strTipBol: String;
    blnConfirma: Boolean;
    strMens01: String;
    strMens02: String;
    strRetBco: String;
    intRetCar: Integer;
    blnEtiCob: Boolean;
    blnBolPdf: Boolean;
    blnEnvMai: Boolean;
    strBraCrr: String;
    strBB_Crr: String;
    strConCrr: String;
    strOrdCampo: String;
    strOrdTipo: String;
    intRetCarAnt : Integer;
    blnAltImp: Boolean;
    blnDupMercantil: Boolean;
    {*************}
    { Qtd de Vias }
    {**********RV*}
    intQtdImp: Integer;
    cdsBoletos: TUniClientDataSet;

    strBancoAnterior: String;
    blnFat: Boolean;
    fltPerMul: Double;

    recDados: TDadosTelaDigBoleto;

    blnPortadorAlterado: Boolean;

    strEmpresaImpressao: String; //Empresa que será impresso o boleto (configurações e carteira)
    FUtilizaMultiplosBancos : Boolean;
    blnDeveImprimir    : Boolean;

    procedure pOnShow;
    procedure pCarregaDadosTela;
    function fRetornaDadosTela: TDadosTelaDigBoleto;
  end;


const
  cstIdxImprimir = 0;
  cstIdxGerarPDF = 1;
  cstIdxImprimirGerarPDF = 2;
  cstIdxEnviarEmail = 3;
  cstIdxEnviarEmailImprimir = 4;

implementation

uses
  untFuncoes, untFuncoesSimples, untPesqAux, untValorPorExtenso, untConsultas,
  untConstantes, untCfgRel, untFuncFat, untFuncoesBoleto, untDisparaSMSAut,
  untDisparaEmailAut;

{$R *.dfm}

{ TfrmDigBoletoFaturamento }

function TfrmDigBoletoFaturamento.fRetornaDadosTela: TDadosTelaDigBoleto;
begin
  Result := recDados;

  Result.blnConfirma         := blnConfirma;
  Result.blnBolPdf           := blnBolPdf;
  Result.blnEnvMai           := blnEnvMai;
  Result.blnEtiCob           := blnEtiCob;
  Result.strTipBol           := strTipBol;
  Result.blnDupMercantil     := blnDupMercantil;
  Result.blnEditaEmail       := chkEditaEmail.Checked;
  Result.blnPortadorAlterado := blnPortadorAlterado;
  Result.blnAltImp           := blnAltImp;
  Result.fltPerMul           := fltPerMul;
  Result.blnDeveImprimir     := blnDeveImprimir;
  Result.blnEnviarWPPBoleto  := fEnviaWhatsappParaCliente(cdsBoletos.FieldByName('CTR_CODCLI').AsString);

  Result.strCodBco := strCodBco;
  Result.strCodPor := strCodPor;
  Result.fltValMor := fltValMor;
  Result.strNosNum := strNosNum;
  Result.strMens01 := strMens01;
  Result.strMens02 := strMens02;
  Result.strRetBco := strRetBco;
  Result.intRetCar := intRetCar;
end;

function TfrmDigBoletoFaturamento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
Var strNosNum: String;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA A MORA DIARIA                  *}
    {**************************************MV*}
    If (Sender = edtMorDia) Then
    Begin
      If fEmptyStr(edtMorDia.Text) Then
      Begin
        edtMorDia.Text := '0,' + fStrZero('0',fCfgSis('CSDMOR', VarInteger));
      End
      Else If fStrToFloat(edtMorDia.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Mora Diária deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA O PORTADOR                     *}
    {**************************************MV*}
    Else If (Sender = edtCodPor) Then
    Begin
      If ((fEmptyStr(edtCodPor.Text)) And  (edtCodBco.Text <> '999')) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Portador deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaPortador(Not edtCodPor.ReadOnly);
        If (qryConPor.FieldByName('POR_CODPOR').IsNull) And  (edtCodBco.Text <> '999') Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If blnFat And Not fPortadorPermiteBoletoFaturamento(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não é permitido para impressão de boletos no Faturamento!', ['&O k']);
          Result := False;
        End
        Else If qryConPor.FieldByName('POR_IMPBOL').AsString = 'N' Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido usar esse portador para impressão de boletos!', ['&O k']);
          Result := False;
        End
        Else If (blnBuscaPorChave) Then
        Begin
          If Not qryConPor.FieldByName('POR_CODBCO').IsNull Then
          Begin
            If Not (btnAlterar.Visible And edtCodBco.ReadOnly) Then
              edtCodBco.Text := qryConPor.FieldByName('POR_CODBCO').AsString;
            fValidaCampos(edtCodBco);
            edtCodBco.Enabled := fEmptyStr(edtNomBan.Text);
          End
          Else
          Begin
            If Not (edtCodBco.Text = strBancoAnterior) Then
              edtCodBco.Text := fCfgSis('BANBOL', varString, strEmpresaImpressao);
            edtCodBco.Enabled := True;
          End;
        End
        Else If not fEmptyStr(strPortadorAnterior) Then
        begin
          if (strPortadorAnterior) <> (edtCodPor.Text) Then
            blnPortadorAlterado := True
          else
            blnPortadorAlterado := False;
        end;

        If Not edtCodBco.Enabled Then
          edtCodBcoExit(edtCodBco);
      End;
    End

    {*****************************************}
    {* VALIDA O BANCO                        *}
    {**************************************MV*}

    Else If (Sender = edtCodBco) Then
    Begin
      If (Pos(edtCodBco.Text,'999_888_777_778') <= 0) Then
      Begin
        edtTipBol.Text := 'L';
        edtTipBol.Enabled := False;
      end;

      If fEmptyStr(edtCodBco.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Banco deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else If (edtTipBol.Text = 'M')                          And
              (Not fValidaBancoCnf(edtCodBco.Text, 'CNFBOL')) And
              (edtCodBco.Text <> '999')                       And
              (edtCodBco.Text <> '888')                       And
              (edtCodBco.Text <> '778')                       And
              (edtCodBco.Text <> '777')                       Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse banco não está preparado para a impressão de Boleto!', ['&O k']);
        Result := False;
      End
      Else If (Pos(edtTipBol.Text, 'L') > 0)           And
              (Pos(edtCodBco.Text, BANCOS_LASER) <= 0) And
              (edtCodBco.Text <> '778')                And
              (edtCodBco.Text <> '999')                Then
      Begin
        fMensagem('ATENÇÃO!', 'Banco não preparado para impressão de Boleto Laser!', ['&O k']);
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

    {*****************************************}
    {* VALIDA O NOSSO NÚMERO                 *}
    {**************************************MV*}
    Else If (Sender = edtNosNum) And edtNosNum.Visible Then
    Begin
      if fEmptyStr(strNosNum) then
         strNosNum := edtNosNum.Text;

      If fEmptyStr(edtNosNum.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Nosso Número deve ser preenchido!', ['&O k']);
        Result := False;
      End;

      if btnAlterar.Visible then
      begin
        if strNosNum <> edtNosNum.Text then
        begin
          if StrToInt(edtNosNum.Text) < StrToInt(objDigBoleto.fPegaNossoNumero(qryConBco, edtCodBco.Text, strRetBco, strEmpresaImpressao, intRetCar)) then
          begin
            if fMensagem('ATENÇÃO!', 'O Nosso Número informado é menor que o calculado no cadastro do Banco! ' +
                                     'Continuar pode gerar duplicidade no nosso número. Deseja realmente continuar?', ['&Sim', '&Não']) = 2 then
            begin
              Result := False;
            end
            else
              strNosNum := edtNosNum.Text;
          end;
        end
      end;

      If (Result) And (blnVerNosN) And (Not edtNosNum.ReadOnly) Then
      Begin
        strNosNum := edtNosNum.Text;
        pAvaliaNosNum;
        edtNosNum.Text := fStrZero(fRetNossoNumeroDisponivel(edtCodBco.Text, edtNosNum.Text, strRetBco, intRetCar, VS_strCodEmp), edtNosNum.MaxLength);
        If (StrToInt64(edtNosNum.Text) <> StrToInt64(strNosNum)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O próximo Nosso Número impresso será: ' + edtNosNum.Text + '!', ['&O k']);
        End;
      End;
    End

    Else If (Sender = edtTipBol) Then
    Begin

      If fEmptyStr(edtTipBol.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O tipo de boleto deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (Pos(edtTipBol.Text, 'ML') <= 0) Then
      Begin
        Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmDigBoletoFaturamento.edtMorDiaExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtMorDia.Text) Then
    edtMorDia.Text := FloatToStrF(fStrToFloat(edtMorDia.Text), ffNumber, 12, fCfgSis('CSDMOR', VarInteger));
end;

procedure TfrmDigBoletoFaturamento.edtNosNumChange(Sender: TObject);
begin
  inherited;
  blnVerNosN := True;
end;

procedure TfrmDigBoletoFaturamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryCadBco);
end;

procedure TfrmDigBoletoFaturamento.FormCreate(Sender: TObject);
begin
  inherited;
  blnSemTela := True;

  qryCadBco := fCriaQuery(Self);
  qryConPor := fCriaQuery(Self);
  qryConBco := qryCadBco;
  blnConfirma := False;
  blnEnvMai := False;

  strEmpresaImpressao := VS_strCodEmp;

  objLiberacao := TLiberacao.Create;

  edtMorDia.Text := FloatToStrF(fCfgSis('TAXDIA', varDouble, strEmpresaImpressao),ffFixed,12,fCfgSis('CSDMOR', VarInteger));

  if fEmptyStr(strCodBco) Then
    edtCodBco.Text := fCfgSis('BANBOL', varString, strEmpresaImpressao)
  else
    edtCodBco.Text := strCodBco;

  blnAltImp := False;
  strKeyAnt := '';

  objDigBoleto := TDigBoleto.Create;
  blnDeveImprimir := False;
end;

procedure TfrmDigBoletoFaturamento.FormDestroy(Sender: TObject);
begin
  inherited;

  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  If Assigned(objDigBoleto) Then
    FreeAndNil(objDigBoleto);
end;

procedure TfrmDigBoletoFaturamento.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If Key = #27 Then
    btnCancelaDados.Click;
end;

procedure TfrmDigBoletoFaturamento.pCarregaPortador(blnTrocaBancoPadrao: Boolean=True);
begin
  pPesquisaCadPor(Nil, qryConPor, edtCodPor.Text);
  With qryConPor Do
  Begin
    edtDesPor.Text := FieldByName('POR_NOMPOR').AsString;

    If blnTrocaBancoPadrao Then
    Begin
      If (Not fEmptyStr(FieldByName('POR_CODBCO').AsString)) {And (Not edtCodBco.ReadOnly)} Then
      Begin
        edtCodBco.Text := FieldByName('POR_CODBCO').AsString;
        pCarregaBanco;

        edtCodBco.Enabled := fEmptyStr(edtNomBan.Text);
      End;
    End;

    If (blnFat And (fCfgSis('IMPBOL', varString, strEmpresaImpressao) = 'A')) Or (objDigBoleto.recCamposDigBoleto.blnExpediMult) Or recdados.blnFaturadorAutomatico Then
    Begin

      If (not blnSemTela) And (not blnComCart) Then
        strChave := '';

      If (Length(strChave) > 1) And
         (Pos('CONFIG' + edtCodBco.Text, strChave) = 0) Then
         strChave := '';

      If blnSemTela And (strChave = '') Then
      Begin
        strChave := fCarteiraImpressaoBoletoPortador(edtCodPor.Text);

        If fEmptyStr(strChave) Then
          strChave := fCfgSis('CARBOL', varString, strEmpresaImpressao);
      End;

      edtCartei.Text := strChave;
    End;

    edtCodBco.ReadOnly := edtCodPor.readOnly;

    // Valida Portadores E-Mail
    pVerificaMostraMensagemPortador();

  End;
end;

Procedure TfrmDigBoletoFaturamento.pVerificaMostraMensagemPortador();
Var strMsg : String;
Begin
    // Valida Portadores E-Mail
    strMsg          := '';
    bnlPortAutEmail := True;
    bnlPortAutSMS   := True;

    If Self.Showing Then
    Begin
       TCustomRadioGroup(Rdgopcoes.Components[3]).Enabled := True;
       TCustomRadioGroup(Rdgopcoes.Components[4]).Enabled := True;

       If Not fVerificaTemPortadorAut(0, recdados.blnFaturamento, edtCodPor.Text, strEmpresaImpressao) Then // E-MAIL;
       Begin
          bnlPortAutEmail      := False;

          TCustomRadioGroup(Rdgopcoes.Components[3]).Enabled := False;
          TCustomRadioGroup(Rdgopcoes.Components[4]).Enabled := False;

          strMsg := 'Portador não autorizado a enviar E-mail';
       End;
    End;

    lblMsgPortadorAut.Caption := strMsg;
End;

procedure TfrmDigBoletoFaturamento.pHabilitaDesabilitaEdicaoEmail;
begin
  chkEditaEmail.Enabled := rdgOpcoes.ItemIndex in [cstIdxEnviarEmail, cstIdxEnviarEmailImprimir];
  If Self.Showing Then
  Begin
    If Not chkEditaEmail.Enabled Then
      chkEditaEmail.Checked := False;
  End;
end;

procedure TfrmDigBoletoFaturamento.pAvaliaNosNum;
Var strCodConv: String;
Begin
  edtNosNum.Text := StringReplace(edtNosNum.Text,' ','',[rfreplaceAll]);

  if edtCodBco.ReadOnly then
    Exit;

  If Not fEmptyStr(edtCodBco.text) And (edtNosNum.Visible) Then
  Begin
    If MatchStr(edtCodBco.text, ['341', '995', '988', '981', '964']) Then
    Begin
      edtNosNum.TamCampo := 8;
      edtNosNum.MaxLength := 8;

      If Length(edtNosNum.Text) > 8 Then
        edtNosNum.Text := Copy(edtNosNum.Text, Length(edtNosNum.Text) - 7);
    End
    Else If (edtCodBco.text = '001') And (Pos('CONFIG001D7', strChave) = 0) And
            (Pos('CONFIG001API', strChave)  = 0) Then
    Begin
      edtNosNum.TamCampo := 11;
      edtNosNum.MaxLength := 11;
      strCodConv := fGetBancoConfig(0, 'CONFIG' + strRetBco + '-' + IntToStr(intRetCar), 'CODCONV', '');
      edtNosNum.Text := strCodConv + Copy(edtNosNum.Text, Length(strCodConv) + 1);
    End
    Else
    Begin
      edtNosNum.TamCampo := 11;
      edtNosNum.MaxLength := 11;
    End;
  End;
End;

procedure TfrmDigBoletoFaturamento.pCarregaBanco;
begin
  pPesquisaCadBco(qryCadBco, qryConBco, edtCodBco.Text);
  edtNomBan.Text := qryConBco.FieldByName('BCO_NOMBCO').AsString;

  pAvaliaNosNum;

  if btnAlterar.Visible then
  begin
    if edtCodBco.Text <> strBancoAnterior then
      strNosNUm := '';
  end;

  pOcultaEdtNosNum;
end;

procedure TfrmDigBoletoFaturamento.pCarregaDadosTela;
begin
  blnPortadorAlterado := recDados.blnPortadorAlterado;
  cdsBoletos          := recDados.cdsBoletos;
  strBancoAnterior    := recDados.strBancoAnterior;
  strCodBco           := recDados.cdsBoletos.FieldByName('CTR_BCOBOL').AsString;
  strOrdCampo         := recDados.strOrdCampo;
  strOrdTipo          := recDados.strOrdTipo;

  pCarregaRdgOpcoes;

  blnFat := True;

  If (cdsBoletos.FindField('CTR_CARTEI') <> Nil) Then
  Begin
    If recDados.blnReimp Then
    begin
      intRetCar    := recDados.intRetCar;
      intRetCarAnt := recDados.intRetCarAnt;
      strRetBco    := recDados.strRetBco;
      strChave     := recDados.strChave;
    end;
  End;

  If Not recDados.blnReimp Then
  Begin
    chkEtiCob.Top             := edtMens02.Top + 24;
    lblMsgPortadorAut.Top     := chkEtiCob.Top + 20;
    edtCartei.Visible         := False;
    edtPerMul.Visible         := False;
    lblCartei.Visible         := False;
    lblPerMul.Visible         := False;
    lblPercen.Visible         := False;
    btnAlterar.Visible        := False;
  End
  Else
  Begin
    if recDados.blnReimpParcial then
      btnAlterar.Enabled      := False;

    If Not fEmptyStr(recDados.strMorDia) Then
      edtMorDia.Text            := recDados.strMorDia;
    edtCartei.Text            := recDados.strCartei;
    edtCodPor.Text            := recDados.strCodPor;
    edtNosNum.Text            := recDados.strNosNum;
    edtPerMul.Text            := recDados.strPerMul;
    edtMens01.Text            := recDados.strMens01;
    edtMens02.Text            := recDados.strMens02;
    lblPercen.Visible         := True;
    edtMorDia.ReadOnly        := True;
    edtCodPor.ReadOnly        := True;
    edtCodBco.ReadOnly        := True;
    edtNosNum.ReadOnly        := True;
    edtMens01.ReadOnly        := True;
    edtMens02.ReadOnly        := True;
    edtCartei.ReadOnly        := True;
    edtPerMul.ReadOnly        := True;
    edtCartei.Top             := edtMens02.Top + edtMens02.Height + 2;
    lblCartei.Top             := edtCartei.Top + 3;
    edtPerMul.Top             := edtCartei.Top + edtCartei.Height + 2;
    lblPerMul.Top             := edtPerMul.Top + 3;
    lblMsgPortadorAut.Top     := chkEtiCob.Top + 20;
  End;

  If Not fEmptyStr(recDados.strMorDia) Then
    edtMorDia.Text := recDados.strMorDia;

  If (fCfgSis('BANBOL', varString, strEmpresaImpressao) <> '') And
     ((fCfgSis('EMPFAT', VarBoolean)) Or (fCfgSis('EMPFVN', VarBoolean))) Or
      FUtilizaMultiplosBancos Then
    edtCodBco.Text := recDados.strCodBco;

  If (fCfgSis('BANBOL', varString, strEmpresaImpressao) <> '') And
     (edtCodBco.Text = '') Then
    edtCodBco.Text := fCfgSis('BANBOL', varString, strEmpresaImpressao);

  If fPermiteCarregarPortadorDoDocumento(strEmpresaImpressao) Or FUtilizaMultiplosBancos Then
    edtCodPor.Text := recDados.strCodPor;

  If (recDados.strEspDoc = 'FF') And Not FUtilizaMultiplosBancos Then
  Begin
    edtCodBco.Text     := '778';
    edtCodBco.ReadOnly := True;
  End;

  strEmpresaImpressao := recDados.strEmpresaImpressao;

  edtTipBol.Enabled := False;
  edtMorDia.Enabled := False;

  chkEtiCob.Visible := False;

  edtMens01.Visible := False;
  edtMens02.Visible := False;

  Height := Height - edtMens01.Height -
                     edtMens02.Height;

  Height := Height + 20;

  If fCfgSis('DESPON', varBoolean) Then
    edtMens02.Visible := False;

  If recDados.blnEnvioAutmaticoEmail Then
    rdgOpcoes.ItemIndex := cstIdxEnviarEmail
  Else If (recDados.blnEmissaoAutomatica And recDados.blnReimp And recDados.blnPreview)Then
         rdgOpcoes.ItemIndex := cstIdxEnviarEmail;

end;

procedure TfrmDigBoletoFaturamento.edtCodBcoChange(Sender: TObject);
begin
  inherited;
  blnComCart := False;
end;

procedure TfrmDigBoletoFaturamento.edtCodBcoExit(Sender: TObject);
  Var
    strBcoAnt: String;
    intCarAnt : Integer;
    strConCor: String;
    strPorMer: String;

begin
  inherited;
  if (Trim(edtCodBco.Text) = '')  then
    Exit;

  if Length(strChave) > 1 then
    if Pos('CONFIG'+edtCodBco.Text, strChave) = 0 then
      strChave := '';

  If (btnAlterar.Visible)   And
     (fEmptyStr(strChave))  And
     (fEmptyStr(strKeyAnt)) And
     (strBancoAnterior <> '999') then
  Begin
    fMensagem('','Essa duplicata teve o boleto impresso pelo banco, porem não há informações da carteira, por isso não será possível a reimpressão pela empresa!', ['&Ok']);
    Exit;
  End;

  strBcoAnt := strBancoAnterior;

  intCarAnt := intRetCarAnt;
  pCarregaBanco;

  if intRetCar > 0 then
  begin
    If Not edtCodBco.ReadOnly Then
      intRetCar:= 0;

  end;

  {***************************************************}
  {* FUNCAO QUE VERIFICA SE O CLIENTE POSSUI MAIS DE *}
  {* UM BANCO CONFIGURADO, SE SIM ENTAO DEVE CHAMAR  *}
  {* UM GET MENU PARA QUE O CLIENTE O SELECIONE.     *}
  {************************************************ED*}

  If (Pos(edtCodBco.Text,'999_888_777_778') <= 0) Then
  Begin
    edtTipBol.Text := 'L';
    edtTipBol.Enabled := False;

    If btnAlterar.Visible Then
    Begin
      If (Length(strChave) > 1) And
         (Pos('CONFIG' + strRetBco + '-', strChave) = 0) And
         (Not edtCodBco.ReadOnly) Then strChave := '';
    End
    Else
    Begin
      If (Length(strChave) > 1) And
         (Pos('CONFIG' + edtCodBco.Text, strChave) = 0) And
         (Not edtCodBco.ReadOnly) Then strChave := '';
    End;

    If fVer_Banco_Carteira(edtCodBco.Text, IIF(fEmptyStr(edtCartei.Text),'', strChave), strRetBco, intRetCar, True, strEmpresaImpressao) Then
    Begin
      {************************************************}
      {* SÓ ENTRA NESSA VALIDAÇÃO QUANDO ESTÁ GERANDO *}
      {* UM NOVO BOLETO OU LIBEROU PARA ALTERAR       *}
      {*REQ-25848-26/01/2015************************JU*}
      If Not edtCodBco.ReadOnly Then
        edtNosNum.Text := objDigBoleto.fPegaNossoNumero(qryConBco, edtCodBco.Text, strRetBco, strEmpresaImpressao, intRetCar);

      strNosNum := edtNosNum.Text;

      If (btnAlterar.Visible)         And
         ((Not fEmptyStr(strChave))   Or
          (Not fEmptyStr(strKeyAnt))) Then
      Begin
        If fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strRetBco + '-' + IntToStr(intRetCar), 'RESPONS', '', strEmpresaImpressao)) Then
        Begin
          fMensagem('','A carteira selecionada não foi encotrada nas configurações (Autban), verifique se as configurações bancárias foram alteradas ou se essa carteira foi excluida!', ['&Ok']);
          Exit;
        End;
      End;

      If (edtCodBco.Text = '422') Or
         (edtCodBco.Text = '090') Then
        strBraCrr := fGetBancoConfig(0, 'CONFIG' + strRetBco + '-' + IntToStr(intRetCar), 'CORBRAD', '', strEmpresaImpressao)
      Else
        strBraCrr := '';

      If strRetBco = '756_240p' Then
      Begin
        strBB_Crr := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intRetCar), 'USACRR_', '', strEmpresaImpressao);
        strConCrr := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intRetCar), 'CONVCRR', '', strEmpresaImpressao);
      End
      Else
      Begin
        strBB_Crr := '';
        strConCrr := '';
      End;

      If strRetBco = '748' Then
      Begin
        If fEmptyStr(fGetBancoConfig(0, 'CONFIG748-' + IntToStr(intRetCar), 'CEDENTE', '', strEmpresaImpressao)) Then
        Begin
          pMensagemOK('Campo "CEDENTE" com valor incorreto na carteira. Verifique!');
          edtCodBco.Text := '';
          edtNomBan.Text := '';
          strChave       := '';
          edtNosNum.Clear;
          pSetFocus(edtCodPor);
        End;
      End;

      strChave := 'CONFIG' + strRetBco + '-' + IntToStr(intRetCar) + '-' + strEmpresaImpressao;
      edtCartei.Text := strChave;
      blnComCart     := True;
    End
    Else
    Begin
      intRetCar := intCarAnt;
      if not (edtCodBco.Text = strBcoAnt) then
      begin
        edtCodBco.Text := strBancoAnterior;
        pCarregaBanco;
        pSetFocus(edtCodBco);
      end;
      edtNosNum.Text := '';
    End;
  End
  Else
  Begin
    edtNosNum.Text := fStrZero(qryConBco.FieldByName('BCO_PRONUM').AsString,11);

    If edtCodBco.Text = '999' Then
    Begin
      edtTipBol.Enabled := True;
      strPorMer := fCfgSis('PORMER');
      If Not fEmptyStr(strPorMer) Then
      Begin
        edtCodPor.Text := strPorMer;
        pCarregaPortador;
      End;

      strDupFr3 := objDigBoleto.fRetornaDupMercMatric;
      If Not fEmptyStr(strDupFr3) Then
      Begin
        edtTipBol.Text := 'M';
        edtTipBol.OnChange(edtTipBol);
      End;
      Exit;
    End;

    If edtCodBco.Text = '778' Then
    Begin
      edtTipBol.Text := 'M';
      edtTipBol.OnChange(edtTipBol);
      edtTipBol.Enabled := True;
    End;
  End;

  If (Not edtNosNum.ReadOnly) and (Not fEmptyStr(edtNosNum.Text)) Then
  Begin
    pAvaliaNosNum;
    edtNosNum.Text := fStrZero(fRetNossoNumeroDisponivel(edtCodBco.Text, edtNosNum.Text, strRetBco, intRetCar, strEmpresaImpressao), 11);
  End;

  if (strRetBco = '341') Or (strRetBco = '995') then
  begin
    strConCor := fGetBancoConfig(0,'CONFIG' + strRetBco + '-' + IntToStr(intRetCar),'NUMCTAC','', strEmpresaImpressao);

    if Length(strConCor) <> 5 then
    begin
      pMensagemOK('Código da Conta Corrente deve ter 5 (cinco) caracteres, corrija nas configurações da carteira no Autban!');
      edtCodBco.Text := '';
      edtNomBan.Text := '';
      strChave       := '';
    end;
  end;

  pAvaliaNosNum;
end;

procedure TfrmDigBoletoFaturamento.edtCodBcoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrBancos: TConsultasArray;
begin
  inherited;

  If (edtCodBco.ReadOnly) Or (Not edtCodBco.Enabled) Then
    Exit;

  {*******************************}
  {* NOVA CONSULTA DE BANCOS     *}
  {****************************RV*}
  If fPesqBanco(Self, edtCodBco, edtNomBan, qryTabela, Key, arrBancos) Then
  Begin
    if fValidaCampos(edtCodBco, True) then
      SelectNext(ActiveControl, True, True);
    pCarregaBanco;
  End;
end;

procedure TfrmDigBoletoFaturamento.edtCodPorChange(Sender: TObject);
begin
  inherited;
  blnComCart := False;
end;

procedure TfrmDigBoletoFaturamento.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If (edtCodPor.ReadOnly) Or (Not edtCodPor.Enabled) Then
    Exit;

  If blnFat Then
  Begin
    If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, qryConPor, Key, arrSel,
                     True, 'Consulta de Portadores', 'S', False, True) Then
    Begin
      If fValidaCampos(edtCodPor, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End

  Else If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, qryConPor, Key, arrSel,
                        True, 'Consulta de Portadores', '', False, True) Then
  Begin
    If fValidaCampos(edtCodPor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmDigBoletoFaturamento.FormShow(Sender: TObject);
begin
  pCarregaRdgOpcoes;

  btnImprimirMercantil.Enabled := True;
  blnSemTela := False;
  blnVerNosN := False;
  blnComCart := False;
  strPortadorAnterior := edtCodPor.Text;
  Self.pOnShow;

  if fCfgSis('IMPBOP') = '1'  Then
     rdgOpcoes.ItemIndex :=0
  Else If fCfgSis('IMPBOP') = '2' Then
     rdgOpcoes.ItemIndex :=1
  Else If fCfgSis('IMPBOP') = '3' Then
     rdgOpcoes.ItemIndex :=2
  Else If fCfgSis('IMPBOP') = '4' Then
     rdgOpcoes.ItemIndex :=3
  Else If fCfgSis('IMPBOP') = '5' Then
     rdgOpcoes.ItemIndex :=4;
end;

procedure TfrmDigBoletoFaturamento.pCarregaRdgOpcoes;
var
  blnUtiSms,
  blnUtiWpp: Boolean;

  objSmsWpp: TSMSAut;
begin
  blnUtiSms := False;
  blnUtiWpp := False;

  objSmsWpp := TSMSAut.Create(Nil);
  try

    if ((fCfgSis('URLSMS', VarString, strEmpresaImpressao) <> '') And
       (fCfgSis('USRSMS', VarString, strEmpresaImpressao) <> '')  And
       (fCfgSis('SENSMS', VarString, strEmpresaImpressao) <> '')) Or
       (fCfgSis('SMSMKM', varBoolean)) then
    begin
      objSmsWpp.FOpcDoc := 'BO';
      objSmsWpp.FStatus := staNenhumaAcao;
      objSmsWpp.FWhatsapp := False;

      blnUtiSms := objSmsWpp.fTemModeloAtivo;
    end;

    if fCfgSis('UTIWPP', varBoolean, strEmpresaImpressao) then
    begin
      objSmsWpp.FOpcDoc := 'BO';
      objSmsWpp.FStatus := staNenhumaAcao;
      objSmsWpp.FWhatsapp := True;

      blnUtiWpp := ((fEnviaWhatsappParaCliente(cdsBoletos.FieldByName('CTR_CODCLI').AsString)) and
                    (objSmsWpp.fTemModeloAtivo));
    end;

    rdgOpcoes.Items.Clear;
    rdgOpcoes.Items.Add('Imprimir');
    rdgOpcoes.Items.Add('Gerar PDF');
    rdgOpcoes.Items.Add('Imprimir e gerar PDF');

    rdgOpcoes.Items.Add('Enviar por email'+
                        IIF(blnUtiSms, ' / SMS', '')+
                        IIF(blnUtiWpp, ' / Whatsapp', ''));

    rdgOpcoes.Items.Add('Enviar por email'+
                        IIF(blnUtiSms, ' / SMS', '')+
                        IIF(blnUtiWpp, ' / Whatsapp', '')+
                        ' e imprimir');

  finally
    FreeAndNil(objSmsWpp);
  end;

end;

procedure TfrmDigBoletoFaturamento.pOnShow;
begin
  inherited;

  if Not fEmptyStr(strBancoAnterior) Then
  Begin
    edtCodBco.Text := strBancoAnterior;
    Caption := 'Reimpressão de Boletos: ' + fRetNomeBancoSelec(strBancoAnterior);
  End
  Else
  Begin
    Caption := 'Impressão de Boletos';

    If fEmptyStr(edtCodPor.Text) Then
       edtCodPor.Text := fCfgSis('PORBOL', varString, strEmpresaImpressao);
  End;

  If Not fEmptyStr(edtCodBco.Text) Then
    pCarregaBanco;

  pCarregaPortador(blnFat);

  pOcultaEdtNosNum;

  if (edtCodBco.Text = '999') or (edtCodBco.Text = '778') then
  begin
    edtTipBol.Text := 'M';
    edtTipBol.Enabled := True;
  end
  else
  begin
    edtTipBol.Text := 'L';
    edtTipBol.Enabled := False;
  end;

  edtTipBolChange(edtTipBol);

  pVerificaMostraMensagemPortador();
end;

procedure TfrmDigBoletoFaturamento.rdgOpcoesClick(Sender: TObject);
begin
  inherited;

  pHabilitaDesabilitaEdicaoEmail;
end;

{*********************************************}
{* BOTÃO ALTERAR SÓ É VISIVEL NA REIMPRESSÃO *}
{* SÓ LIBERA OS CAMPOS MEDIANTE SENHA        *}
{*REQ-25848-22/01/2015*********************JU*}
procedure TfrmDigBoletoFaturamento.btnAlterarClick(Sender: TObject);
  Var
    strKeyAux  : String;
begin
  inherited;

  strKeyAux := Copy(strChave, 1, Length(edtCartei.Text) - 4);

  If fEmptyStr(strKeyAnt) Then
    strKeyAnt := strChave;

  If ((fGetBancoConfig(0, strKeyAux, 'RESPONS', '') = 'B') Or
      (fEmptyStr(strKeyAnt)))                             And
      (strBancoAnterior <> '999') Then
  Begin
    fMensagem('','O boleto dessa duplicata foi impresso pelo banco, portanto seus dados não podem ser alterados pela empresa!', ['&Ok']);
    pSetFocus(btnConfirmaDados);
    Exit;
  End;

  objLiberacao.clear;
  objLiberacao.objMsgLibera.pAddTexto('Boleto já impresso!!!');
  objLiberacao.objMsgLibera.pAddTexto('Qualquer alteração nestas informações será de sua total responsabilidade!');

  objLiberacao.strDirAce := 'ALTBOL';
  objLiberacao.strSenLib := fCfgSis('LIBBOL');
  objLiberacao.strMsgSen := 'Reimpressão de boletos';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;

  objLiberacao.pInformaNumDocEspDocCodEmp(
                       cdsBoletos.FieldByName('NRODUP').AsString,
                       cdsBoletos.FieldByName('CTR_ESPDOC').AsString,
                       cdsBoletos.FieldByName('CTR_CODEMP').AsString);


  If objLiberacao.fLibera Then
  Begin
     edtMorDia.ReadOnly := False;
     edtCodPor.ReadOnly := False;
     edtCodBco.ReadOnly := False;
     edtNosNum.ReadOnly := False;
     edtMens01.ReadOnly := False;
     edtMens02.ReadOnly := False;

     edtCartei.Text := '';
     edtCodBco.Text := '';

     strNosNum          := edtNosNum.Text;

     edtPerMul.ReadOnly := False;
     blnAltImp := True;

     strEmpresaImpressao := VS_strCodEmp;

     pSetFocus(edtTipBol);
  End;

end;

procedure TfrmDigBoletoFaturamento.btnCancelaClick(Sender: TObject);
begin
  blnConfirma := False;
  Close;
end;

procedure TfrmDigBoletoFaturamento.btnConfirmaDadosClick(Sender: TObject);
  Var
    strNosNumAtu: String;
begin
  If Not fEmptyStr(edtCodBco.Text) and fEmptyStr(strBancoAnterior) Then
    strBancoAnterior := edtCodBco.Text;

  If (fCfgSis('NROBOL', varBoolean)) And
     (Pos(edtCodBco.Text, '778_999_') <= 0)  Then
  begin
    if (Pos(edtCodBco.Text, strChave) <= 0) or (Pos(strRetBco, strChave) <= 0) then
    begin
      edtCodBcoExit(nil);
      if fEmptyStr(strChave) then
      begin
       pMensagemOK('É necessário escolher pelo menos uma carteira!');
       Exit;
      end;
    end;
  end;

  If Not fVerificaCampos Then
    Exit;

  If Not fValidaCampos(edtCodBco, True) Then
    Exit;

  If edtCodBco.Text = '999' Then
  Begin
    strDupFr3 := objDigBoleto.fRetornaDupMercMatric;
    If Not fEmptyStr(strDupFr3) Then
    Begin
      If edtTipBol.Text = 'L' Then
      Begin
        fMensagem('ATENÇÃO', 'Para Layouts personalizados de Duplicatas, a impressão é feita apenas em Matricial. Layout no diretório do AUTCOM - Fr3.', ['&OK']);
        Exit;
      end;
    End;
  End
  else
  begin
    if fCfgSis('IMPMER', varBoolean) then
      btnImprimirMercantilClick(Sender);
    blnDupMercantil := False;
  end;

  If (btnAlterar.Visible)   And
     (fEmptyStr(strChave))  And
     (fEmptyStr(strKeyAnt)) And
     (strBancoAnterior <> '999') then
  Begin
    fMensagem('','Essa duplicata teve o boleto impresso pelo banco, porem não há informações da carteira, por isso não será possível a reimpressão pela empresa!', ['&Ok']);
    Exit;
  End;

  If (fEmptyStr(edtNosNum.Text)) Then
    edtCodBcoExit(Sender);

  If Not fCfgSis('NROBOL', varBoolean) Then
  Begin
    {***************************************************}
    {* FUNCAO QUE VERIFICA SE O CLIENTE POSSUI MAIS DE *}
    {* UM BANCO CONFIGURADO, SE SIM ENTAO DEVE CHAMAR  *}
    {* UM GET MENU PARA QUE O CLIENTE O SELECIONE.     *}
    {************************************************ED*}
    If (Pos(edtCodBco.Text,'999_888_777_778') <= 0) Then
    Begin

      {************************************************}
      {* SÓ ENTRA NESSA VALIDAÇÃO QUANDO ESTÁ GERANDO *}
      {* UM NOVO BOLETO OU LIBEROU PARA ALTERAR       *}
      {*REQ-25848-26/01/2015************************JU*}
      If Not edtCodBco.ReadOnly Then
        intRetCar := 0;

      If  fVer_Banco_Carteira(edtCodBco.Text, IIF(fEmptyStr(edtCartei.Text), '', strChave), strRetBco, intRetCar, True, strEmpresaImpressao) Then
      Begin
        edtNosNum.Text := objDigBoleto.fPegaNossoNumero(qryConBco, edtCodBco.Text, strRetBco, strEmpresaImpressao, intRetCar);

        If (btnAlterar.Visible)         And
           ((Not fEmptyStr(strChave))   Or
            (Not fEmptyStr(strKeyAnt))) Then
        Begin
          If fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strRetBco + '-' + IntToStr(intRetCar), 'RESPONS', '')) Then
          Begin
            fMensagem('','A carteira selecionada não foi encontrada nas configurações (Autban), verifique se as configurações bancárias foram alteradas ou se essa carteira foi excluida!', ['&Ok']);
            Exit;
          End;
        End;

        If strRetBco = '756_240p' Then
        Begin
          strBB_Crr := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intRetCar), 'USACRR_', '');
          strConCrr := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intRetCar), 'CONVCRR', '');
        End
        Else
        Begin
          strBB_Crr := '';
          strConCrr := '';
        End;

        If (edtCodBco.Text = '422') Or
           (edtCodBco.Text = '090') Then
          strBraCrr := fGetBancoConfig(0, 'CONFIG' + strRetBco + '-' + IntToStr(intRetCar), 'CORBRAD', '')
        Else
          strBraCrr := '';

        edtCartei.Text := IntToStr(intRetCar);
        strChave   := 'CONFIG' + strRetBco + '-' + IntToStr(intRetCar) + '-' + VS_strCodEmp;
        blnComCart := True;
      End
      else
      begin
        pMensagemOK('É necessário escolher pelo menos uma carteira!');
        Exit;
      end;
    End
    Else
      edtNosNum.Text := fStrZero(qryConBco.FieldByName('BCO_PRONUM').AsString,11);
  End;

  strNosNumAtu := edtNosNum.Text;

  If (Pos(edtCodBco.Text, BANCOS_PDFMAIL) <= 0)  Then
  Begin
    case rdgOpcoes.ItemIndex of
      cstIdxGerarPDF,
      cstIdxImprimirGerarPDF : Begin
                                 pMensagemOK('A geração para PDF do banco ' + edtCodBco.Text + ' está em construção! Utilize um gerador de PDF!');
                                 Exit;
                               End;
      cstIdxEnviarEmail,
      cstIdxEnviarEmailImprimir: Begin
                                   pMensagemOK('O envio de E-Mail do banco ' + edtCodBco.Text + ' está em construção!');
                                   Exit;
                                 End;
    end;
  End;

  If (intRetCar <= 0)          And
     (edtCodBco.Text <> '999') And
     (edtCodBco.Text <> '888') And
     (edtCodBco.Text <> '778') And
     (edtCodBco.Text <> '777') Then
  Begin
    pMensagemOK('É necessário configurar e escolher pelo menos uma carteira!');
    Exit;
  End;

  If fVerificaCampos Then
  Begin
    strCodBco   := edtCodBco.Text;
    strCodPor   := edtCodPor.Text;
    fltValMor   := fStrToFloat(edtMorDia.Text);
    strNosNum   := strNosNumAtu;
    strTipBol   := edtTipBol.Text;
    blnConfirma := True;
    strMens01   := edtMens01.Text;
    strMens02   := edtMens02.Text;
    blnEtiCob   := chkEtiCob.Checked;

    blnBolPdf   := (rdgOpcoes.ItemIndex in [cstIdxGerarPDF, cstIdxImprimirGerarPDF, cstIdxEnviarEmail, cstIdxEnviarEmailImprimir]);
    blnEnvMai   := (rdgOpcoes.ItemIndex in [cstIdxEnviarEmail, cstIdxEnviarEmailImprimir]);
    blnDeveImprimir := (rdgOpcoes.ItemIndex in [cstIdxImprimir, cstIdxImprimirGerarPDF, cstIdxEnviarEmailImprimir]);

    fltPerMul := 0;
    If edtPerMul.Visible Then
      fltPerMul := fStrToFloat(edtPerMul.Text);

    If (strCodBco = '999') Then
    Begin
      pMensagemOK('Para impressão de duplicata Mercantil favor utilizar o botão "Imprimir Dup. Mercantil".');
      Exit;
    End;

    recDados := fRetornaDadosTela;

    Close;
  End;
end;

procedure TfrmDigBoletoFaturamento.btnImprimirMercantilClick(Sender: TObject);
begin
  inherited;
  recDados.strTipoRelatorio    := edtTipBol.Text;
  recDados.strEmpresaImpressao := strEmpresaImpressao;
  recDados.strOrdenacaoCampos  := strOrdCampo;
  recDados.strOrdenacaoTipo    := strOrdTipo;
  recDados.strFormulario       := Self.Name;

  recDados.fltPercentualMulta := 0;
  If edtPerMul.Visible Then
    recDados.fltPercentualMulta := fStrToFloat(edtPerMul.Text);

  recDados.fltPercentualMora := 0;
  If edtMorDia.Visible Then
    recDados.fltPercentualMora := fStrToFloat(edtMorDia.Text);

  recDados.cdsBoletos := cdsBoletos;
  objDigBoleto.recCamposDigBoleto := recDados;
  blnDupMercantil := objDigBoleto.fImprimirDuplicataMercantil;

  strCodBco   := '999';
  strCodPor   := '';
  fltValMor   := fStrToFloat(edtMorDia.Text);
  strNosNum   := '';
  strTipBol   := edtTipBol.Text;
  blnConfirma := True;
  strMens01   := edtMens01.Text;
  strMens02   := edtMens02.Text;
  blnEtiCob   := chkEtiCob.Checked;

  blnBolPdf   := (rdgOpcoes.ItemIndex in [cstIdxGerarPDF, cstIdxImprimirGerarPDF, cstIdxEnviarEmail, cstIdxEnviarEmailImprimir]);
  blnEnvMai   := (rdgOpcoes.ItemIndex in [cstIdxEnviarEmail, cstIdxEnviarEmailImprimir]);
  blnDeveImprimir := (rdgOpcoes.ItemIndex in [cstIdxImprimir, cstIdxImprimirGerarPDF, cstIdxEnviarEmailImprimir]);

  btnImprimirMercantil.Enabled := Not blnDupMercantil;
  pSetFocus(btnCancelaDados);
end;

procedure TfrmDigBoletoFaturamento.pOcultaedtNosNum;
begin
  If ((fCfgSis('NROBOL', varBoolean)) and (edtCodBco.Text <> '999')) Then
  Begin
    If Not edtNosNum.Visible Then
    Begin
      edtMens01.Top := edtMens01.Top + edtNosNum.Height;
      edtMens02.Top := edtMens02.Top + edtNosNum.Height;
      chkEtiCob.Top := chkEtiCob.Top + edtNosNum.Height;
      lblMsgPortadorAut.Top := lblMsgPortadorAut.Top + edtNosNum.Height;
      Self.Height := Self.Height + edtNosNum.Height;
      If edtCartei.Visible Then
      Begin
        edtCartei.Top := edtCartei.Top + edtNosNum.Height;
        lblCartei.Top := edtCartei.Top;
        edtPerMul.Top := edtPerMul.Top + edtNosNum.Height;
        lblPerMul.Top := edtPerMul.Top;
        lblPercen.Top := edtPerMul.Top;
      End;
    End;

    edtNosNum.Enabled := True;
    edtNosNum.Visible := True;
    lblNosNum.Visible := True;
  End
  Else
  Begin
    If edtNosNum.Visible Then
    Begin
      edtMens01.Top := edtMens01.Top - edtNosNum.Height;
      edtMens02.Top := edtMens02.Top - edtNosNum.Height;

      If edtCartei.Visible Then
      Begin
        edtCartei.Top := edtCartei.Top - edtNosNum.Height;
        lblCartei.Top := edtCartei.Top;
        edtPerMul.Top := edtPerMul.Top - edtNosNum.Height;
        lblPerMul.Top := edtPerMul.Top;
        lblPercen.Top := edtPerMul.Top;
      End;

      chkEtiCob.Top := chkEtiCob.Top - edtNosNum.Height;
      lblMsgPortadorAut.Top := lblMsgPortadorAut.Top - edtNosNum.Height;
      Self.Height := Self.Height - edtNosNum.Height;
    End;

    edtNosNum.Enabled := False;
    edtNosNum.Visible := False;
    lblNosNum.Visible := False;
  End;
end;

function TfrmDigBoletoFaturamento.fGatilhoEmailBNAtivo: Boolean;
  Var
    objEmaAut : TEmaAut;
begin
  objEmaAut := TEmaAut.Create(nil);
  Try
    objEmaAut.FOpcDoc := 'BN';
    objEmaAut.FEspDoc := recDados.strEspDoc;
    objEmaAut.FStatus := staNenhumaAcao;

    Result := objEmaAut.fTemEmailAtivo;
  Finally
    FreeAndNil(objEmaAut);
  End;
end;

procedure TfrmDigBoletoFaturamento.edtTipBolChange(Sender: TObject);
begin
  inherited;

  rdgOpcoes.Enabled := (edtTipBol.Text = 'L');
  Try

    If Not rdgOpcoes.Enabled Then
      Exit;

    pDesabilitaOpcao(cstIdxGerarPDF);
    pDesabilitaOpcao(cstIdxImprimirGerarPDF);
    pDesabilitaOpcao(cstIdxEnviarEmail);
    pDesabilitaOpcao(cstIdxEnviarEmailImprimir);

    If fCfgSis('IMPBOD', varBoolean, strEmpresaImpressao) Then
    Begin
      pHabilitaOpcao(cstIdxGerarPDF);
      pHabilitaOpcao(cstIdxImprimirGerarPDF);
      pHabilitaOpcao(cstIdxEnviarEmail);
      pHabilitaOpcao(cstIdxEnviarEmailImprimir);
    End;

    If rdgOpcoes.Enabled Then
    Begin
      If fOpcaoHabilitada(cstIdxGerarPDF) And (fCfgSis('GERBOL', VarString, strEmpresaImpressao) = 'M') Then
        rdgOpcoes.ItemIndex := cstIdxGerarPDF;

      If fOpcaoHabilitada(cstIdxGerarPDF) And (fCfgSis('ENVBOL', VarString, strEmpresaImpressao) = 'M') And
        (Self.Showing Or (Not Self.Showing And Not fGatilhoEmailBNAtivo)) Then
        rdgOpcoes.ItemIndex := cstIdxEnviarEmail;
    End;

  Finally
    pHabilitaDesabilitaEdicaoEmail;
  End;
end;

procedure TfrmDigBoletoFaturamento.pDesabilitaOpcao(intOpcao: Integer);
begin
  If Self.Showing Then
    rdgOpcoes.Controls[intOpcao].Enabled := False;
end;

procedure TfrmDigBoletoFaturamento.pHabilitaOpcao(intOpcao: Integer);
begin
  If Self.Showing Then
    rdgOpcoes.Controls[intOpcao].Enabled := True;
end;

function TfrmDigBoletoFaturamento.fOpcaoHabilitada(intOpcao: Integer): Boolean;
begin
  Result := True;

  If Self.Showing Then
    Result := (rdgOpcoes.Controls[intOpcao].Enabled = True);
end;

end.
