{***************************}
{* qryConPor -> CADPOR     *}
{* qryConCta -> CADCTA     *}
{* qryConBco -> CADBCO     *}
{* qryConFor -> CADFOR     *}
{************************JB*}
{***************************}
{* qryCadBco -> CADBCO     *}
{************************RV*}
unit untBaixaSintetica;

interface

uses
  Controls, Forms, StdCtrls, untPaiSimples, EditFocus, ComCtrls, Buttons,
  ExtCtrls, Mask, MaskEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem,
  Classes, frxClass, frxExportCSVTestabilidade, Data.DB, Datasnap.DBClient,
  UniClientDataSet, untTypesSistema, untLiberacao, untFechamentoFinanceiro,
  untFramePlanoDeContasMaskEdit,untTValidaCorrespondenteContabil,
  System.DateUtils;

type
  TfrmBaixaSintetica = class(TfrmPaiSimples)
    lblPorBai: TLabel;
    edtPorBai: TEditFocus;
    lblData: TLabel;
    mskDtaLan: TMaskEditFocus;
    lblDocBai: TLabel;
    lblHistor: TLabel;
    edtHisBai: TEditFocus;
    edtDocBai: TEditFocus;
    pnlConfirma: TPanel;
    edtDesPor1: TEditFocus;
    pnlFundo: TPanel;
    edtEmiCheque: TEditFocus;
    lblEmiCheque: TLabel;
    edtCodBco: TEditFocus;
    edtNomBco: TEditFocus;
    edtNumAge: TEditFocus;
    edtNumChq: TEditFocus;
    lblCodBco: TLabel;
    lblNumAge: TLabel;
    lblNumChq: TLabel;
    edtFavorecido: TEditFocus;
    mskBomPara: TMaskEditFocus;
    lblBomPara: TLabel;
    lblFavorecido: TLabel;
    edtConCor: TEditFocus;
    lblConCor: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    lblCodFor: TLabel;
    lblDtaEmi: TLabel;
    mskDtaEmi: TMaskEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    cdsCadRec_VerificaData: TUniClientDataSet;
    edtHist02: TEditFocus;
    lblhist2: TLabel;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    procedure FormCreate(Sender: TObject);
    procedure edtPorBaiKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure edtCodBcoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryConFor: TUniQuery;
    qryConBco: TUniQuery;
    qryConCta: TUniQuery;
    qryConPor: TUniQuery;
    qryCadBco: TUniQuery;
    blnLibRet: Boolean;

    objLiberacao  : TLiberacao;
    objFechamento : TFechamentoFinanceiro;
    FValidaCorrespondenteContabil: TValidaCorrespondenteContabil;

    function fExisteCheque(strCodBco, strNumAge, strNumChq: String): Boolean;
    function fChamaSenhaVariavel(strMsg : String = ''; strDirAce : String = ''; strCfgSis : String = ''; strMsgSen : String = ''; strOperador : String = ''; strNTrava : String = ''): Boolean;

    procedure pCarregaPortador;
    procedure pCarregaCentroCusto;
    procedure pHabilitaCampos(strHabilitar: String);
    procedure pCarregaBanco;
    procedure pCarregaFornecedor;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strPorBai,
    strCtaBai,
    strDtaLan,
    strDocBai,
    strHisBai,
    strHist02,
    strCodBco,
    strNumAge,
    strNumChq,
    strDtaBom,
    strDtaEmi,
    strFavore,
    strConCor,
    strCodEmp,
    strCodFor,
    strDtaPag: String;
    intDCrRecPor1: Integer;
    blnConfirma: Boolean;
    blnResumoCaixa: Boolean;
    blnCtaPag: Boolean;
    blnVemCtr: Boolean;
    blnVemADT: Boolean;
    fltValPag: Double;
    blnCadPag: Boolean;
    dtaDtaBai: TDateTime;
    blnBaiUtl: Boolean;
    blnBaixaZeradaCTP: Boolean;
    FTotRecZero: Boolean;
    FBaixaTotal: Boolean;
  end;


implementation

uses SysUtils, untFuncoesSimples, untPesqAux, untConsultas, untCadCta, untFuncFat;

{$R *.dfm}

{ TfrmBaixaSintetica }

function TfrmBaixaSintetica.fChamaSenhaVariavel(strMsg, strDirAce, strCfgSis,
  strMsgSen, strOperador, strNTrava: String): Boolean;
begin
  Result := True;
  While (True) Do
  Begin
    Try
      objLiberacao.Clear;
      objLiberacao.strDirAce     := strDirAce;
      objLiberacao.strSenLib     := fCfgSis(strCfgSis);
      objLiberacao.strMsgSen     := strMsgSen;
      objLiberacao.blnMosMen     := True;
      objLiberacao.strCodOpe     := strOperador;
      objLiberacao.strCodDig     := strOperador;

      objLiberacao.objMsgLibera.pAddTexto(strMsg);

      If objLiberacao.fLibera Then

        Break

      else
        If (fMensagem('', 'Senha Incorreta!', ['&Novamente', '&Desistir']) = 2) Then
        Begin
          Result := False;
          Exit;
        end;

    Finally

      {******************************************************}
      {* CHAMADA A ESSA UNIT VEM DO FORM untBaixaReceber    *}
      {***************************************************MA*}

      objLiberacao.Clear;
    End;
  End;
end;

function TfrmBaixaSintetica.fExisteCheque(strCodBco, strNumAge, strNumChq: String): Boolean;
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
    Add('  EMI_NUMCHQ = :NUMCHQ     ');

    ParamByName('CODBCO').AsString := strCodBco;
    ParamByName('NUMAGE').AsString := strNumAge;
    ParamByName('NUMCHQ').AsString := strNumChq;

    Open;

    Result := Not IsEmpty;
    
    Close;
  End;
  FreeAndNil(qryGen);
End;

procedure TfrmBaixaSintetica.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If Not (fCfgSis('USACTF', varBoolean)) Or
     Not (blnCadPag) Then
  Begin
    If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto, True, False, '', False, False, blnVemCtr, blnCtaPag) Then
    Begin
      If (fValidaCampos(fraPlanoDeContas.MskCodCta, True)) Then
        Self.SelectNext(ActiveControl, True, True);
      pCarregaCentroCusto;
    End;
  End
  Else
  Begin
    If (edtCodFor.Visible) And (edtCodFor.Enabled) Then
    Begin
      If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto, True, True, edtCodFor.Text, False, False, blnVemCtr, blnCtaPag) Then
      Begin
        If (fValidaCampos(fraPlanoDeContas.MskCodCta, True)) Then
          Self.SelectNext(ActiveControl, True, True);
        pCarregaCentroCusto;
      End;
    End
    Else
    Begin
      If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto, True, True, strCodFor, False, False, blnVemCtr, blnCtaPag) Then
      Begin
        If (fValidaCampos(fraPlanoDeContas.MskCodCta, True)) Then
          Self.SelectNext(ActiveControl, True, True);
        pCarregaCentroCusto;
      End;
    End;
  End;

end;

function TfrmBaixaSintetica.fValidaCampos(Sender: TWinControl;
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

          Else If (Not fPortadorPermiteBaixa(edtPorBai.Text)) Then
          Begin
            fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
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

          Else If (blnCtaPag Or blnVemCtr) And Not FValidaCorrespondenteContabil.PortadorPossuiCorrespondenteContabil(edtPorBai.Text, VS_strCodEmp) Then
          Begin
            Result := False;
          End

          Else If Not fEmpresaTemAcessoPortador(edtPorBai.Text, VS_strCodEmp) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End

          Else If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtPorBai.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos para este portador!', ['&O k']);
              Result := False;
            End;
          End;

          If (FTotRecZero) And (Not fPermiteCreditoDebitoPortador(edtPorBai.Text)) And (FBaixaTotal) Then
          Begin
            fMensagem('ATENÇÃO!', 'Não é permitido utilizar o portador para baixa com utilização de credito zerada', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO FORNECEDOR         *}
    {**************************************MV*}
    Else If (Sender = edtCodFor) And (edtCodFor.Visible) And (edtEmiCheque.Text = 'S')   Then
    Begin
      If (edtCodFor.Visible) And (edtCodFor.Enabled) Then
      Begin
        If (fEmptyStr(edtCodFor.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Fornecedor deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          pCarregaFornecedor;
          If (qryConFor.IsEmpty) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse fornecedor não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA O CENTRO DE CUSTO              *}
    {**************************************MV*}
    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas da Baixa deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaCentroCusto;
        If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          If Not (fCfgSis('USACTF', varBoolean)) Or
             Not (blnCadPag) Then
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k'])
          Else
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado ou não está vinculado ao fornecedor!', ['&O k']);

          Result := False;
        End
        else if (blnVemCtr) and (qryConCta.FieldByName('CTA_PERREC').AsString <> 'S') then
        Begin
           fMensagem('ATENÇÃO!', 'Esse Plano de Contas não é permitido na baixa contas a receber!', ['&O k']);
           Result := False;
        End
        else if (blnCtaPag) and (qryConCta.FieldByName('CTA_PERPAG').AsString <> 'S') then
        Begin
           fMensagem('ATENÇÃO!', 'Esse Plano de Contas não é permitido na baixa contas a pagar!', ['&O k']);
           Result := False;
        End
        Else If Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.MskCodCta.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Linha / Grupo não permitido!', ['&O k']);
          Result := False;
        End
        Else If Not PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text) Then
          Result := False
        Else If (blnCtaPag Or blnVemCtr) And Not FValidaCorrespondenteContabil.PlanoDeContasPossuiCorrespondenteContabil(fraPlanoDeContas.MskCodCta.Text,VS_strCodEmp) Then
        Begin
          Result := False;
        End;
      End;
    End

    Else If (Sender = mskDtaLan) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaLan.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data do lançamento deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (StrToDateDef(mskDtaLan.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'Data informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
      End //FECHAMENTO FINANCEIRO
      Else if objFechamento.FechamentoFinanceiroJaRealizado(VS_StrCodEmp, StrToDate(mskDtaLan.Text)) then
        Result := False;

      if (blnVemCtr) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaLan.Text))) Then
      Begin
        cdsCadRec_VerificaData.Filter := 'CTR_MARDES=' + QuotedStr('M');
        cdsCadRec_VerificaData.Filtered := True;
        cdsCadRec_VerificaData.First;
        while Not cdsCadRec_VerificaData.Eof Do
        begin
          if cdsCadRec_VerificaData.FieldByName('CTR_MARDES').AsString = 'M' then
          Begin
            if StrToDate(mskDtaLan.Text) < cdsCadRec_VerificaData.FieldByName('CTR_DTACAD').AsDateTime Then
            begin
              fMensagem('', 'A data de pagamento informada não pode ser menor que a data de cadastro.', ['&O k']);
              Result := False;
              cdsCadRec_VerificaData.Filtered := False;
              Exit;
            End
            Else if StrToDate(mskDtaLan.Text) < cdsCadRec_VerificaData.FieldByName('CTR_DTAREC').AsDateTime Then
            begin
              fMensagem('', 'A data de lançamento informada não pode ser menor que a data de recebimento.', ['&O k']);
              Result := False;
              cdsCadRec_VerificaData.Filtered := False;
              Exit;
            end
            Else If (StrToDateDef(mskDtaLan.Text,0) > VS_Date) And (Not fCfgSis('BAIDAT', varBoolean)) Then
            Begin
              fMensagem('','A data do pagamento não pode ser maior que Hoje!', ['&OK']);
              Result := False;
              cdsCadRec_VerificaData.Filtered := False;
              Exit;
            End;
          end;
          cdsCadRec_VerificaData.Next;
        end;
        cdsCadRec_VerificaData.Filtered := False;
      end
      Else if (blnCtaPag) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaLan.Text))) Then
      Begin
        cdsCadRec_VerificaData.Filter := 'CTP_MARDES=' + QuotedStr('M');
        cdsCadRec_VerificaData.Filtered := True;
        cdsCadRec_VerificaData.First;
        while Not cdsCadRec_VerificaData.Eof Do
        begin
          if cdsCadRec_VerificaData.FieldByName('CTP_MARDES').AsString = 'M' then
          Begin
            if StrToDate(mskDtaLan.Text) < cdsCadRec_VerificaData.FieldByName('CTP_DTAPAG').AsDateTime Then
            begin
              fMensagem('', 'A data de lançamento informada não pode ser menor que a data de pagamento.', ['&O k']);
              Result := False;
              cdsCadRec_VerificaData.Filtered := False;
              Exit;
            end;
          end;
          cdsCadRec_VerificaData.Next;
        end;
        cdsCadRec_VerificaData.Filtered := False;
      end
      else If (StrToDateDef(mskDtaLan.Text,0) < VS_Date) Then
      Begin
        {****************************************************}
        {* CONFIGURAÇÃO PARA VERIFICAR DIAS DE TOLERÂNCIA   *}
        {* PARA BAIXA DE CONTAS A PAGAR COM DATA RETROATIVA *}
        {* CASO UTILIZE ESSA CONFIGURAÇÃO O SISTEMA NÃO     *}
        {* CONSIDERA A CONFIGURAÇÃO DE SENHA PARA LIBERAR   *}
        {* BAIXA COM DATA RETROATIVA, DENTRO DO PERÍODO     *}
        {* INFORMADO SEMPRE PASSA E FORA DO PERÍODO SEMPRE  *}
        {* TRAVA                                            *}
        {*REQ-46525-19/01/2016****************************MO*}
        If (blnCtaPag) And (Not fEmptyStr(fCfgSis('BAIATP')))  And
           (fCfgSis('BAIATP', VarInteger) > 0) Then
        Begin
          If (StrToDateDef(mskDtaLan.Text,0) < (VS_Date - fCfgSis('BAIATP', varInteger))) Then
          Begin
            fMensagem('','A data do pagamento não pode ser anterior a ' + fCfgSis('BAIATP') + ' dias da data atual!', ['&OK']);
            Result := False;
          End;
        End
        Else If (Not fEmptyStr(fCfgSis('CTPRET'))) And (StrToDateDef(mskDtaLan.Text,0) <> StrToDateDef(strDtaPag,0)) And Not(blnVemADT) Then
        Begin
          If Not blnLibRet Then
          Begin
            If(Not fChamaSenhaVariavel('Permitir Baixa com Data Retroativa', 'CTPDTARET', 'CTPRET', 'Baixa com data retroativa', strLoginUsuarioLogado)) Then
              Result := False
            Else
              blnLibRet := True;
          End;
        End
        Else If (StrToDateDef(mskDtaLan.Text,0) <> StrToDateDef(strDtaPag,0)) And (blnVemADT)And
             Not(fVerificaAcessoSistema('CTRDTARET', strLoginUsuarioLogado)) Then
        Begin
          If Not blnLibRet Then
          Begin
            If(Not fChamaSenhaVariavel('Permitir Baixa com Data Retroativa', 'CTRDTARET', ' ', 'Baixa com data retroativa', strLoginUsuarioLogado)) Then
              Result := False
            Else
              blnLibRet := True;
          End;
        End;
      End;

      If (StrToDateDef(mskDtaLan.Text,0) > VS_Date) Then
      begin
        if not fCfgSis('LANPOS', VarBoolean) then
        begin
          fMensagem('ATENÇÃO','A data para lançamento bancário não pode ser superior a data de hoje!', ['&OK']);
          pSetFocus(mskDtaLan);
          Result := False;
          Exit;
        End
        Else
        Begin
          If (Not fEmptyStr(fCfgSis('TOLBAN')))  And
             (fCfgSis('TOLBAN', VarInteger) > 0) Then
          Begin
            If StrToDateDef(mskDtaLan.Text,0) > IncDay(VS_Date, fCfgSis('TOLBAN', VarInteger)) Then
            Begin
              fMensagem('ATENÇÃO','A data para lançamento bancário não pode ser superior a ' +
                                  FormatDateTime('dd/mm/yyyy', IncDay(VS_Date, fCfgSis('TOLBAN', VarInteger))) + '!', ['&OK']);
              pSetFocus(mskDtaLan);
              Result := False;
              Exit;
            End;
          End;
        End;
      end;
    End

    {*******************************************}
    {* VALIDA EMITIR CHEQUE                    *}
    {****************************************AC*}
    Else If (Sender = edtEmiCheque) Then
    Begin
      If blnCadPag And (edtEmiCheque.Visible) Then
      Begin
        If (Copy((Sender As TEditFocus).Text, 1, 1) <> 'S') And
           (Copy((Sender As TEditFocus).Text, 1, 1) <> 'N') Then
          Result := False;

        If Result and blnBuscaPorChave Then
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

        If fExisteCheque(edtCodBco.Text, edtNumAge.Text, edtNumChq.text) Then
        Begin
          fMensagem('Informação', 'Já existe um cheque com Banco, Agência e Número iguais as informações digitadas!', ['&O k']);
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

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmBaixaSintetica.pCarregaCentroCusto;
begin
  If Not (fCfgSis('USACTF', varBoolean)) Or
     Not (blnCadPag) Then
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text)
  Else
  Begin
    If fEmptyStr(edtCodFor.Text) Then
      pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text, True, strCodFor)
    Else
      pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text, True, edtCodFor.Text);
  End;

  With qryConCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmBaixaSintetica.pCarregaPortador;
begin
  pPesquisaCadPor(Nil, qryConPor, edtPorBai.Text);
  With qryConPor Do
  Begin
    edtDesPor1.Text := FieldByName('POR_NOMPOR').AsString;
    intDCrRecPor1   := FieldByName('POR_DCRREC').AsInteger;
    blnBaiUtl       := FieldByName('POR_BAIUTL').AsString = 'S';
  End;
end;

procedure TfrmBaixaSintetica.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryCadBco);
end;

procedure TfrmBaixaSintetica.FormCreate(Sender: TObject);
begin
  qryCadBco := fCriaQuery(Self);
  inherited;
  qryConPor := fCriaQuery(Self);
  qryConBco := qryCadBco;
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);

  blnConfirma := False;
  blnCadPag   := False;
  blnLibRet := False;

  blnResumoCaixa := False;

  objLiberacao := TLiberacao.create;
  FValidaCorrespondenteContabil :=  TValidaCorrespondenteContabil.Create;
  FTotRecZero := False;
  FBaixaTotal := False;
end;

procedure TfrmBaixaSintetica.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objLiberacao);
  FreeAndNil(FValidaCorrespondenteContabil);
  inherited;
end;

procedure TfrmBaixaSintetica.edtPorBaiKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqPortador(conSimples, Self, edtPorBai, edtDesPor1, nil, Key, arrSel) Then    
  Begin
    If (fValidaCampos(edtporBai)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
  pCarregaPortador;

end;

procedure TfrmBaixaSintetica.FormShow(Sender: TObject);
begin
  inherited;
  SelectFirst;

  {*******************************************}
  {* DEFAULT                                 *}
  {****************************************AC*}
  If blnCadPag Then
  Begin
    edtEmiCheque.Text := 'N';

    edtPorBai.Enabled  := False;
    edtPorBai.Visible  := False;
    edtDesPor1.Visible := False;
    lblPorBai.Visible  := False;

    IF blnBaixaZeradaCTP Then
    Begin
      edtPorBai.Enabled  := True;
      edtPorBai.Visible  := True;
      edtDesPor1.Visible := True;
      lblPorBai.Visible  := True;

      pSetFocus(edtPorBai);
    End
    Else
      pSetFocus(fraPlanoDeContas.MskCodCta);

    lblEmiCheque.Visible := False;
    edtEmiCheque.Visible := False;

    pHabilitaCampos(edtEmiCheque.Text);
  End
  Else
  Begin
    fraPlanoDeContas.Top   := edtEmiCheque.Top;

    mskDtaLan.Top   := (fraPlanoDeContas.Top + mskDtaLan.Height) + 1;
    lblData.Top     := mskDtaLan.Top + 4;

    edtDocBai.Top   := (mskDtaLan.Top + edtDocBai.Height) + 1;
    lblDocBai.Top   := edtDocBai.Top + 4;

    edtHisBai.Top   := (edtDocBai.Top + edtHisBai.Height) + 1;
    lblHistor.Top   := edtHisBai.Top + 4;


    lblEmiCheque.Visible := False;
    lblCodBco.Visible := False;
    lblNumAge.Visible := False;
    lblNumChq.Visible := False;
    lblConCor.Visible := False;
    lblCodFor.Visible := False;

    edtEmiCheque.Visible := False;
    edtCodBco.Visible := False;
    edtNumAge.Visible := False;
    edtNumChq.Visible := False;
    edtConCor.Visible := False;
    edtCodFor.Visible := False;
    edtNomFor.Visible := False;

    mskBomPara.Visible := False;
    mskDtaEmi.Visible := False;
    edtFavorecido.Visible := False;

    Self.Height := 229;
  End;

  strCodBco := '';
  strNumAge := '';
  strNumChq := '';
  strConCor := '';

  If blnResumoCaixa And blnCtaPag Then
  Begin
    If (Not fEmptyStr(fCfgSis('PORPGR'))) And edtPorBai.Visible And edtPorBai.Enabled Then
    Begin
      edtPorBai.Text := fCfgSis('PORPGR');
      pCarregaPortador;
    End;

    If (Not fEmptyStr(fCfgSis('CTAGCP'))) And fraPlanoDeContas.MskCodCta.Visible And fraPlanoDeContas.MskCodCta.Enabled Then
    Begin
      fraPlanoDeContas.MskCodCta.Text := fCfgSis('CTAGCP');
      pCarregaCentroCusto;
    End;

  End
  Else
  If blnCtaPag And edtPorBai.Visible And edtPorBai.Enabled Then
    pCarregaPortador;

  If Not blnVemADT Then
  Begin
    edtHist02.Top  := (edtHisBai.Top + edtHist02.Height) + 1;
    lblHist2.Top   :=  edtHist02.Top + 4;
  End
  Else
  Begin
    edtHist02.Visible := False;
    lblHist2.Visible  := False;
  End;
end;

procedure TfrmBaixaSintetica.btnCancelaClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmBaixaSintetica.btnConfirmaDadosClick(Sender: TObject);
  Var
    strCfg_PORPGR: String;
    strCfg_CTAGCP: String;
begin
  inherited;

  If fVerificaCampos Then
  Begin
    If blnResumoCaixa And blnCtaPag Then
    Begin
      strCfg_PORPGR := fCfgSis('PORPGR');
      strCfg_CTAGCP := fCfgSis('CTAGCP');

      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'MUDPF9';
      objLiberacao.strSenLib    := fCfgSis('MUDPF9');
      objLiberacao.strMsgSen    := 'Mudança de Portador ou Plano de Contas';
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.strSenFvu    := 'F';

      If (Not fEmptyStr(strCfg_PORPGR)) Then
      Begin

        If ((Not fEmptyStr(edtPorBai.Text)) And (edtPorBai.Text <> strCfg_PORPGR)) Then
        Begin
          objLiberacao.objMsgLibera.pAddTexto('Portador selecionado diferente do portador configurado para baixa.');

          If (edtPorBai.Visible) And (edtPorBai.Text <> strCfg_PORPGR) Then
            objLiberacao.objMsgLibera.pAddTextoCaption('Portador configurado', strCfg_PORPGR + ' Portador selecionado: ' + edtPorBai.Text, 20);

          objLiberacao.objMsgLibera.pAddQuebra;
          objLiberacao.objMsgLibera.pAddQuebra;
        End;

      End;

      If (Not fEmptyStr(strCfg_CTAGCP)) Then
      Begin

        If (Not fEmptyStr(fraPlanoDeContas.MskCodCta.Text)) And (fraPlanoDeContas.MskCodCta.Text <> strCfg_CTAGCP) Then
        Begin
          objLiberacao.objMsgLibera.pAddTexto('Plano de Contas selecionado diferente do Plano de Contas configurada para baixa.');
          objLiberacao.objMsgLibera.pAddTextoCaption('Plano de Contas configurado:', strCfg_CTAGCP + ' Plano de Contas selecionado: ' + fraPlanoDeContas.MskCodCta.Text, 27);

          objLiberacao.objMsgLibera.pAddQuebra;
          objLiberacao.objMsgLibera.pAddQuebra;

        End;

      End;

      If  (not objLiberacao.objMsgLibera.isEmpty) and (not objLiberacao.fLibera) then
        Exit;

    End
    Else
    Begin
      strCfg_PORPGR := fCfgSis('PORPGR');
      strCfg_CTAGCP := fCfgSis('CTAGCP');

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

      If (Not fEmptyStr(strCfg_CTAGCP)) Then
      Begin

        If (Not fEmptyStr(fraPlanoDeContas.MskCodCta.Text)) And (fraPlanoDeContas.MskCodCta.Text = strCfg_CTAGCP) Then
        Begin
          pMensagemOk('Plano de Contas ' + strCfg_CTAGCP + ' não permitida, pois está configurada para baixa de Contas a Pagar no resumo de caixa.');
          pSetFocus(fraPlanoDeContas.MskCodCta);
          Exit;
        End;

      End;

    End;

    strPorBai   := edtPorBai.Text;
    strCtaBai   := fraPlanoDeContas.MskCodCta.Text;
    strDtaLan   := mskDtaLan.Text;
    strDocBai   := edtDocBai.Text;
    strHisBai   := edtHisBai.Text;
    strHist02   := edtHist02.Text;
    strDtaPag   := mskDtaLan.Text;
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
      strCodFor := edtCodFor.Text;
    End;
    strDtaBom   := mskBomPara.Text;
    strDtaEmi   := mskDtaEmi.Text;
    strFavore   := edtFavorecido.Text;
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmBaixaSintetica.edtCodBcoKeyPress(Sender: TObject;
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

procedure TfrmBaixaSintetica.pCarregaBanco;
begin
  pPesquisaCadBco(qryCadBco, qryConBco, edtCodBco.Text);
  With qryConBco Do
  Begin
    edtNomBco.Text := FieldByName('BCO_NOMBCO').AsString;
    edtCodBco.Text := FieldByName('BCO_CODBCO').AsString;
  End;
end;

procedure TfrmBaixaSintetica.pHabilitaCampos(strHabilitar: String);
begin
  If strHabilitar = 'N' Then
  Begin
    If Not edtPorBai.Visible Then
    Begin
      lblEmiCheque.Top := edtPorBai.Top;
      edtEmiCheque.Top := edtPorBai.Top;
    End
    Else
    Begin
      lblEmiCheque.Top := edtPorBai.Top + edtPorBai.Height + 1;
      edtEmiCheque.Top := edtPorBai.Top + edtPorBai.Height + 1;
    End;

    fraPlanoDeContas.Top := (edtEmiCheque.Top);// + mskCtaBai.Height) + 1;

    mskDtaLan.Top   := (fraPlanoDeContas.Top + mskDtaLan.Height) + 1;
    lblData.Top     := mskDtaLan.Top + 4;

    edtDocBai.Top   := (mskDtaLan.Top + edtDocBai.Height) + 1;
    lblDocBai.Top   := edtDocBai.Top + 4;

    edtHisBai.Top   := (edtDocBai.Top + edtHisBai.Height) + 1;
    lblHistor.Top   := edtHisBai.Top + 4;


    lblCodBco.Visible := False;
    lblNumAge.Visible := False;
    lblNumChq.Visible := False;
    lblConCor.Visible := False;
    lblCodFor.Visible := False;

    edtCodBco.Visible := False;
    edtNomBco.Visible := False;
    edtNumAge.Visible := False;
    edtNumChq.Visible := False;
    edtConCor.Visible := False;
    edtCodFor.Visible := False;
    edtNomFor.Visible := False;

    mskBomPara.Visible := False;
    mskDtaEmi.Visible := False;
    edtFavorecido.Visible := False;

    Self.Height := 238;
  End
  Else
  Begin

    Self.Height := 422;

    fraPlanoDeContas.Top    := mskDtaLan.Top;

    lblData.Top     := lblDocBai.Top;
    mskDtaLan.Top   := edtDocBai.Top;

    lblDocBai.Top   := lblHistor.Top;
    edtDocBai.Top   := edtHisBai.Top;

    edtHisBai.Top   := edtHisBai.Top + edtHisBai.Height + 1;
    lblHistor.Top   := edtHisBai.Top + 4;

    lblCodBco.Visible := True;
    lblNumAge.Visible := True;
    lblNumChq.Visible := True;
    lblConCor.Visible := True;
    lblCodFor.Visible := True;

    edtCodBco.Visible := True;
    edtNumAge.Visible := True;
    edtNumChq.Visible := True;
    edtConCor.Visible := True;
    edtCodFor.Visible := True;
    edtNomFor.Visible := True;
    mskBomPara.Visible := True;
    mskDtaEmi.Visible := True;
    edtFavorecido.Visible := True;

    edtCodBco.Top   := edtHisBai.Top + edtCodBco.Height + 1;
    edtNomBco.Top   := edtHisBai.Top + edtNomBco.Height + 1;
    lblCodBco.Top   := edtCodBco.Top + 4;

    edtNumAge.Top   := edtCodBco.Top + edtNumAge.Height + 1;
    lblNumAge.Top   := edtNumAge.Top + 4;

    edtConCor.Top   := edtNumAge.Top + edtConCor.Height + 1;
    lblConCor.Top   := edtConCor.Top + 4;

    edtNumChq.Top   := edtConCor.Top + edtNumChq.Height + 1;
    lblNumChq.Top   := edtNumChq.Top + 4;

    mskBomPara.Top  := edtNumChq.Top + mskBomPara.Height + 1;
    lblBomPara.Top  := mskBomPara.Top + 4;

    mskDtaEmi.Top   := mskBomPara.Top + mskDtaEmi.Height + 1;
    lblDtaEmi.Top   := mskDtaEmi.Top + 4;

    edtFavorecido.Top:= mskDtaEmi.Top + edtFavorecido.Height + 1;
    lblFavorecido.Top:= edtFavorecido.Top + 4;

    edtCodFor.Text    := strCodFor;
    lblCodFor.Top     := edtCodFor.Top + 4;

    pCarregaFornecedor;
  End;
end;

procedure TfrmBaixaSintetica.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBaixaSintetica.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryConFor, qryConFor, edtCodFor.Text);
  With qryConFor Do
  Begin
    edtNomFor.Text := FieldByName('FOR_NOMFOR').AsString;
    If (Not fEmptyStr(edtCodFor.Text)) Then
      strCodFor := edtCodFor.Text;
  End;
end;

end.


