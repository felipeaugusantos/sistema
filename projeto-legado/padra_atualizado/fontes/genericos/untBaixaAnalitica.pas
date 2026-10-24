{***************************}
{* qryConPor -> CADPOR     *}
{* qryConCta -> CADCTA     *}
{************************JB*}
unit untBaixaAnalitica;

interface

uses
  Controls, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, Uni, Mask,
  MaskEditFocus, EditFocus, Menus, AppEvnts, BitBtnLockedIncrem, Classes,
  frxClass, frxExportCSVTestabilidade, Vcl.Forms, untFramePlanoDeContasMaskEdit,
  untFrameCentroCustoEditFocus;

type
  TfrmBaixaAnalitica = class(TfrmPaiSimples)
    edtPorBai: TEditFocus;
    pnlConfirma: TPanel;
    edtCodPorBai: TEditFocus;
    pnlFundo: TPanel;
    lblPorBa1: TLabel;
    Panel1: TPanel;
    lblPorDeb: TLabel;
    edtCodPorDeb: TEditFocus;
    edtPorDeb: TEditFocus;
    Label5: TLabel;
    Label6: TLabel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    gpbDescontoAntecipacao: TGroupBox;
    lblTaxaBancaria: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label31: TLabel;
    edtTaxaBancaria: TEditFocus;
    edtValorTarifa: TEditFocus;
    edtValorTotalCheques: TEditFocus;
    edtValorLiquido: TEditFocus;
    edtDesFornecedorTarifa: TEditFocus;
    edtFornecedorTarifa: TEditFocus;
    fraPlanoDeContasCre: TfraPlanoDeContasMskEdit;
    fraPlanoDeContasDeb: TfraPlanoDeContasMskEdit;
    fraPlanoDeContasTar: TfraPlanoDeContasMskEdit;
    fraCentroCusto: TfraCentroCustoEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure edtPorBaiKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure edtPorDebKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorBaiChange(Sender: TObject);
    procedure edtFornecedorTarifaKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasCreMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasCreMskCodCtaExit(Sender: TObject);
    procedure fraPlanoDeContasDebMskCodCtaExit(Sender: TObject);
    procedure fraPlanoDeContasDebMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasTarMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
  private
    { Private declarations }
    qryConCta: TUniQuery;
    qryConPor: TUniQuery;
    qryCadFor : TUniQuery;
    FblnFrmRcxResumoCaixa: Boolean;
    FPortador: String;
    FBloquearEdicaoPortador: Boolean;

    procedure pCarregaPortadorDebito;
    procedure pCarregaCentroCusto;
    procedure pCarregaCentroCustoDebito;
    procedure CarregaCentroCustoDesconto;
    procedure CalcularDescontoAntecipacao;
    procedure pCarregaEventos;
    procedure SetblnFrmRcxResumoCaixa(const Value: Boolean);
    procedure PreparaCampoPortadorBaixa;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strPorBai, strPorDeb, strCtaBai, strCtaDeb, strNomPorBai, strCodEve: String;
    blnConfirma: Boolean;
    blnRepase  : Boolean;
    blnChecaPortador: Boolean;
    blnTransferencia: Boolean;
    dtaDtValPor : TDate;
    AMostrarDescontoAntecipacao: Boolean;
    AValorTaxa: Double;
    APlanoContasDescAntec: String;
    AFornecedorDescAntec : String;
    AValorTarifaAntecipacao: Double;
    blnChmCX : Boolean;
    blnVemBxCh: Boolean;
    blnSomentePortador: Boolean;

    procedure pCarregaPortador;

    property blnFrmRcxResumoCaixa: Boolean read FblnFrmRcxResumoCaixa write SetblnFrmRcxResumoCaixa;
    property Portador: String read FPortador write FPortador;
    property BloquearEdicaoPortador: boolean read FBloquearEdicaoPortador write FBloquearEdicaoPortador;
  end;


implementation

uses SysUtils, untfuncoesSimples, untPesqAux, untCadCta, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmBaixaAnalitica }

procedure TfrmBaixaAnalitica.fraPlanoDeContasCreMskCodCtaExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtPorBai.Text)) Then
  Begin
    fraPlanoDeContasCre.MskCodCta.Clear;
    fraPlanoDeContasCre.edtDesCta.Clear;
  End;
end;

procedure TfrmBaixaAnalitica.fraPlanoDeContasCreMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContasCre.MskCodCta, fraPlanoDeContasCre.edtDesCta, Nil, Key, arrCentroCusto, True, False, '', False, blnVemBxCh) Then
  Begin
    If (fValidaCampos(fraPlanoDeContasCre.MskCodCta, True)) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
    pCarregaCentroCusto;
  End;

end;

procedure TfrmBaixaAnalitica.fraPlanoDeContasDebMskCodCtaExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtPorDeb.Text) Then
    fraPlanoDeContasDeb.MskCodCta.Clear;

end;

procedure TfrmBaixaAnalitica.fraPlanoDeContasDebMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;

begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContasDeb.MskCodCta, fraPlanoDeContasDeb.edtDesCta, Nil, Key, arrCentroCusto, True, False, '', False, blnVemBxCh) Then
  Begin
    If (fValidaCampos(fraPlanoDeContasDeb.MskCodCta, True)) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
    pCarregaCentroCustoDebito;
  End;

end;

procedure TfrmBaixaAnalitica.fraPlanoDeContasTarMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrPlanoContas : TConsultasArray;
begin
  inherited;
  {************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO *}
  {************************************}
  If fPesqCentroCusto(Self, fraPlanoDeContasTar.MskCodCta, fraPlanoDeContasTar.edtDesCta, Nil, Key, arrPlanoContas, True, False, '', False, blnVemBxCh) Then
  begin
    if fValidaCampos(fraPlanoDeContasTar.MskCodCta)  then
      SelectNext(ActiveControl, True, True);
  end;

end;

function TfrmBaixaAnalitica.fValidaCampos(Sender: TWinControl;
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

          If Not(blnRepase) And Not(blnTransferencia)Then
          Begin
            fMensagem('ATENÇÃO!', 'O Portador da Baixa deve ser preenchido!', ['&O k']);
            Result := False;
          End;

          If blnTransferencia Then
          Begin
            fMensagem('ATENÇÃO!', 'O Portador da Origem deve ser preenchido!', ['&O k']);
            Result := False;
          End;

          edtCodPorBai.Clear;
          fraPlanoDeContasCre.MskCodCta.Enabled := False;
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

          Else If blnChecaPortador And SameText(qryConPor.FieldByName('POR_DEPCHE').AsString, 'N') Then
          Begin
            fMensagem('ATENÇÃO!', 'Portador não permitido para depósito de cheque!', ['&O k']);
            Result := False;
          End

          Else
          if (dtaDtValPor > 0) And (fRetDataPortador(TEditFocus(Sender).Text) > dtaDtValPor) Then
          Begin
            fMensagem('ATENÇÃO!', 'A Data de Depósito (' + FormatDateTime('dd/mm/yyyy', dtaDtValPor) + ') não pode ser menor que a Data de Inicio do Portador (' + FormatDateTime('dd/mm/yyyy', fRetDataPortador(TEditFocus(Sender).Text)) + ') !', ['&O k']);
            Result := False;
          End

          Else If Not fEmpresaTemAcessoPortador(edtPorBai.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End

          Else If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtPorBai.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos para este portador!', ['&Ok']);
              Result := False;
            End;
          End;

        End;

      End;

      If Not Result Then
        pSetFocus(Sender);

    End;

    {*****************************************}
    {* VALIDA O EVENTO                       *}
    {**************************************MV*}
    If ((Sender = fraCentroCusto.edtCodEve) And (blnChmCX)) Then
    Begin

      If (fCfgSis('EVE_CC', varBoolean)) Then
      Begin

        If (fEmptyStr(fraCentroCusto.edtCodEve.Text)) Then
        Begin
           fMensagem('ATENÇÃO!', 'O Centro de Custos deve ser preenchido!', ['&O k']);
           fraCentroCusto.edtDesEve.Clear;
           Result := False;
        End;

      End;

      If Not (fEmptyStr(fraCentroCusto.edtCodEve.Text)) Then
      Begin
         pCarregaEventos;
         If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
         Begin
           fMensagem('', 'Esse Centro de Custos não está cadastrado!', ['&Ok']);
           Result := False;
         End;
      End;

    End
    Else

    {*****************************************}
    {* VALIDA O CENTRO DE CUSTO              *}
    {**************************************MV*}
    If (Sender = fraPlanoDeContasCre.MskCodCta) And (fraPlanoDeContasCre.MskCodCta.Visible) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContasCre.MskCodCta.Text)) Then
      Begin

        //If Not blnRepase Then
        If (Not fEmptyStr(edtPorBai.Text)) And Not(blnTransferencia) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Plano de Contas da Baixa deve ser preenchido!', ['&O k']);
          Result := False;
        End;
        If (Not fEmptyStr(edtPorBai.Text))And blnTransferencia Then
        Begin
          fMensagem('ATENÇÃO!', 'Obrigatório escolher um Plano de Contas!', ['&O k']);
          Result := False;
        End;

      End
      Else
      Begin
        pCarregaCentroCusto;
        If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaLinhaGrupoCadCta(fraPlanoDeContasCre.MskCodCta.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não é permitido!', ['&O k']);
          Result := False;
        End
        Else If (qryConCta.FieldByName('CTA_PERBCH').AsString <> 'S') Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não é permitido no depósito de cheques!', ['&O k']);
          Result := False;
        End
        Else If Not PlanoDeContasAtivo(fraPlanoDeContasCre.MskCodCta.Text) Then
          Result := False;
      End;
    End

    Else If (Sender = edtPorDeb) And edtPorDeb.Visible And edtPorDeb.Enabled Then
    Begin
      If (edtPorDeb.Visible) And (edtPorDeb.Enabled) Then
      Begin
        If fEmptyStr(edtPorDeb.Text) Then
        Begin
          If blnTransferencia Or ((fCfgSis('RCXTCC') = '2')) Then
          Begin
            fMensagem('ATENÇÃO!', 'O Portador do Destino deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            fraPlanoDeContasDeb.MskCodCta.Enabled  := False;
            edtCodPorDeb.Text  := '';
            fraPlanoDeContasDeb.edtDesCta.Text  := '';
            fraPlanoDeContasDeb.MskCodCta.Text     := '';
          End;
        End
        Else
        Begin
          fraPlanoDeContasDeb.MskCodCta.Enabled  := True;

          pCarregaPortadorDebito;
          If qryConPor.FieldByName('POR_CODPOR').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
            Result := False;
          End

          Else If (Not fPortadorPermiteBaixa(edtPorDeb.Text)) Then
          Begin
            fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
            Result := False;
          End

          Else If blnChecaPortador And SameText(qryConPor.FieldByName('POR_DEPCHE').AsString, 'N') Then
          Begin
            fMensagem('ATENÇÃO!', 'Portador não permitido para depósito de cheque!', ['&O k']);
            Result := False;
          End

          Else
          if (dtaDtValPor > 0) And (fRetDataPortador(TEditFocus(Sender).Text) > dtaDtValPor) Then
          Begin
            fMensagem('ATENÇÃO!', 'A Data de Depósito (' + FormatDateTime('dd/mm/yyyy', dtaDtValPor) + ') não pode ser menor que a Data de Inicio do Portador (' + FormatDateTime('dd/mm/yyyy', fRetDataPortador(TEditFocus(Sender).Text)) + ') !', ['&O k']);
            Result := False;
          End

          Else If Not fEmpresaTemAcessoPortador(edtPorDeb.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End

          Else If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtPorDeb.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos para este portador!', ['&Ok']);
              Result := False;
            End;
          End;

        End;

      End;
    End

    Else If (Sender = fraPlanoDeContasDeb.MskCodCta) Then
    Begin
      If ((edtPorDeb.Text <> EmptyStr)) then
      Begin
        If (fraPlanoDeContasDeb.MskCodCta.Text = EmptyStr) Then
        Begin
          fMensagem('ATENÇÃO!', 'Obrigatório escolher um Plano de Contas!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          pCarregaCentroCustoDebito;
          If fraPlanoDeContasDeb.edtDesCta.Text = EmptyStr Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
            Result := False;
          End
          Else If Not fValidaLinhaGrupoCadCta(fraPlanoDeContasDeb.MskCodCta.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não é permitido!', ['&O k']);
            Result := False;
          End
          Else If (qryConCta.FieldByName('CTA_PERBCH').AsString <> 'S') Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não é permitido no depósito de cheques!', ['&O k']);
            Result := False;
          End
          Else If Not PlanoDeContasAtivo(fraPlanoDeContasDeb.MskCodCta.Text) Then
            Result := False;
        End;
      End;
    End

    Else If (Sender = edtTaxaBancaria) Then
    Begin
      If (fEmptyStr(edtTaxaBancaria.Text)) Or (fStrToFloat(edtTaxaBancaria.Text) < 0) Then
      Begin
        fMensagem('','O campo Taxa Bancária deve ser maior ou igual a 0!',['&O K']);
        Result := False;
      End
      Else
      Begin
        AValorTaxa := fStrToFloat(edtTaxaBancaria.Text);
        CalcularDescontoAntecipacao;

        if AValorTaxa = 0 then
        Begin
          fraPlanoDeContasTar.MskCodCta.Clear;
          edtFornecedorTarifa.Clear;
          fraPlanoDeContasTar.edtDesCta.Clear;
          edtDesFornecedorTarifa.Clear;

          fraPlanoDeContasTar.MskCodCta.Enabled := False;
          edtFornecedorTarifa.Enabled  := False;
        End
        Else
        Begin
          fraPlanoDeContasTar.MskCodCta.Enabled := True;
          edtFornecedorTarifa.Enabled  := True;
        End;
      end;
    end

    Else If (Sender = fraPlanoDeContasTar.MskCodCta) Then
    Begin
      If AValorTaxa > 0 then
      begin
        fraPlanoDeContasTar.MskCodCta.Enabled := True;

        If (fraPlanoDeContasTar.MskCodCta.Text = EmptyStr) Then
        Begin
          fMensagem('ATENÇÃO!', 'Obrigatório escolher um Plano de Contas de Desconto Por Antecipação!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          CarregaCentroCustoDesconto;
          If fraPlanoDeContasTar.MskCodCta.Text = EmptyStr Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
            Result := False;
          End
          Else If Not fValidaLinhaGrupoCadCta(fraPlanoDeContasTar.MskCodCta.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não é permitido!', ['&O k']);
            Result := False;
          End
          Else If (qryConCta.FieldByName('CTA_PERBCH').AsString <> 'S') Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não é permitido no depósito de cheques!', ['&O k']);
            Result := False;
          End
          Else If Not PlanoDeContasAtivo(fraPlanoDeContasTar.MskCodCta.Text) Then
            Result := False;
        End;
      end;
    End

    Else If (Sender = edtFornecedorTarifa) Then
    Begin
      If AValorTaxa > 0 then
      begin
        edtFornecedorTarifa.Enabled := True;

        If fEmptyStr(edtFornecedorTarifa.Text) Then
        begin
          fMensagem('ATENÇÃO','O Código do fornecedor para Desconto por Antecipação deve ser preenchido!',['&OK']);
          Result := False;
        end
        else
        begin
          pPesquisaCadFor(qryCadFor, qryCadFor, edtFornecedorTarifa.Text);

          If qryCadFor.FieldByName('FOR_CODFOR').IsNull Then
          Begin
            fMensagem('ATENÇÃO', 'Esse fornecedor não está cadastrado!', ['&Ok']);
            Result := False;
          End
          else
            edtDesFornecedorTarifa.Text  := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
        end;
      end;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmBaixaAnalitica.pCarregaCentroCusto;
begin
  pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContasCre.MskCodCta.Text);
  With qryConCta Do
  Begin
    fraPlanoDeContasCre.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmBaixaAnalitica.pCarregaCentroCustoDebito;
begin
  pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContasDeb.MskCodCta.Text);
  With qryConCta Do
  Begin
    fraPlanoDeContasDeb.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmBaixaAnalitica.pCarregaPortador;
begin
  pPesquisaCadPor(Nil, qryConPor, edtPorBai.Text);
  With qryConPor Do
  Begin
    edtCodPorBai.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmBaixaAnalitica.pCarregaEventos;
begin
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmBaixaAnalitica.pCarregaPortadorDebito;
begin
  pPesquisaCadPor(Nil, qryConPor, edtPorDeb.Text);
  With qryConPor Do
  Begin
    edtCodPorDeb.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmBaixaAnalitica.PreparaCampoPortadorBaixa;
begin
  If fEmptyStr(FPortador) Then
    Exit;

  edtPorBai.Text := FPortador;
  If fValidaCampos(edtPorBai) Then
  Begin
    If FBloquearEdicaoPortador Then
      edtPorBai.Enabled := False;
  End;

end;

procedure TfrmBaixaAnalitica.SetblnFrmRcxResumoCaixa(const Value: Boolean);
begin
  FblnFrmRcxResumoCaixa := Value;
end;

procedure TfrmBaixaAnalitica.FormCreate(Sender: TObject);
begin
  inherited;
  dtaDtValPor := 0;
  blnChecaPortador := False;
  blnTransferencia := False;
  blnFrmRcxResumoCaixa := False;

  qryConPor := fCriaQuery(Self);
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryCadFor := fCriaQuery(Self);
  blnConfirma := False;
  blnRepase   := False;
  AMostrarDescontoAntecipacao := False;
  blnSomentePortador := False;
end;

procedure TfrmBaixaAnalitica.edtPorBaiKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqPortador(conSimples, Self, edtPorBai, edtCodPorBai, nil, Key, arrSel) Then
  Begin
    If (fValidaCampos(edtporBai)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
  pCarregaPortador;

end;

procedure TfrmBaixaAnalitica.FormShow(Sender: TObject);
Var
  chrKey: Char;
begin
  inherited;
  SelectFirst;
  edtPorBai.Enabled := true;
  fraPlanoDeContasCre.MskCodCta.Enabled := true;
  edtPorDeb.Enabled := true;
  fraPlanoDeContasDeb.MskCodCta.Enabled := true;

  If blnChmCX Then
     FraCentroCusto.visible := True;

  //SÓ MOSTRA DESCONTO DE ANTECIPAÇÃO SE CONFIGURADO
  //UITANT: UTILIZAR TAXA DE DESCONTO POR ANTECIPAÇÃO NA ROTINA DE DEPÓSITO DE CHEQUES?
  If ( Not blnSomentePortador) Then
  Begin
    if (AMostrarDescontoAntecipacao) and
       (fCfgSis('UTIANT') = 'S') then
    begin
      gpbDescontoAntecipacao.Visible := True;
      pnlFundo.Height                := 282;
      Self.Height                    := 455;
      CalcularDescontoAntecipacao;
    end
    else
    begin
      gpbDescontoAntecipacao.Visible := False;
      pnlFundo.Height                := 100;
      Self.Height                    := 273;
    end;
  End;

  If blnFrmRcxResumoCaixa And fEmptyStr(FPortador) Then
  Begin
    if Not fEmptyStr(fCfgSis('PORSLC', varString)) then
    Begin
      edtPorBai.Text := fCfgSis('PORSLC', varString);
      chrKey := Char(#13);
      edtPorBaiKeyPress(Sender, chrKey);
    End;
  End;

  // Verifica se portador esta preenchido
  if strPorDeb <> '' then
  begin
    edtPorDeb.Text := strPorDeb;
    pCarregaPortadorDebito;
    strPorDeb := '';
  end;

  PreparaCampoPortadorBaixa;
end;

procedure TfrmBaixaAnalitica.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmBaixaAnalitica.btnConfirmaDadosClick(Sender: TObject);
  Var
    strCfg_PORPGR: String;
    strCfg_CTAGCP: String;
begin
  inherited;

  if not blnFrmRcxResumoCaixa then
  begin
    If (Not fEmptyStr(edtPorBai.Text)) Or
       (Not fEmptyStr(edtPorDeb.Text)) Or
       (Not fEmptyStr(fraPlanoDeContasCre.MskCodCta.Text)) Or
       (Not fEmptyStr(fraPlanoDeContasDeb.MskCodCta.Text)) Then
    Begin
      strCfg_PORPGR := fCfgSis('PORPGR');
      strCfg_CTAGCP := fCfgSis('CTAGCP');

      If (Not fEmptyStr(strCfg_PORPGR)) Then
      Begin

        If ((Not fEmptyStr(edtPorBai.Text))  And (edtPorBai.Text = strCfg_PORPGR)) Or
           ((Not fEmptyStr(edtPorDeb.Text))  And (edtPorDeb.Text = strCfg_PORPGR)) Then
        Begin
          pMensagemOk('Portador ' + strCfg_PORPGR + ' não permitido, pois está configurado para baixa de Contas a Pagar no resumo de caixa.');

          If ((Not fEmptyStr(edtPorBai.Text))  And (edtPorBai.Text = strCfg_PORPGR)) Then
            pSetFocus(edtPorBai)

          Else If ((Not fEmptyStr(edtPorDeb.Text))  And (edtPorDeb.Text = strCfg_PORPGR)) Then
            pSetFocus(edtPorDeb);

          Exit;
        End;

      End;

      If (Not fEmptyStr(strCfg_CTAGCP)) Then
      Begin

        If ((Not fEmptyStr(fraPlanoDeContasCre.MskCodCta.Text)) And (fraPlanoDeContasCre.MskCodCta.Text = strCfg_CTAGCP)) Or
           ((Not fEmptyStr(fraPlanoDeContasDeb.MskCodCta.Text)) And (fraPlanoDeContasDeb.MskCodCta.Text = strCfg_CTAGCP)) Then
        Begin
          pMensagemOk('Plano de Contas ' + strCfg_CTAGCP + ' não permitido, pois está configurado para baixa de Contas a Pagar no resumo de caixa.');

          If ((Not fEmptyStr(fraPlanoDeContasCre.MskCodCta.Text)) And (fraPlanoDeContasCre.MskCodCta.Text = strCfg_CTAGCP)) Then
            pSetFocus(fraPlanoDeContasCre.MskCodCta)

          Else If ((Not fEmptyStr(fraPlanoDeContasDeb.MskCodCta.Text)) And (fraPlanoDeContasDeb.MskCodCta.Text = strCfg_CTAGCP)) Then
            pSetFocus(fraPlanoDeContasDeb.MskCodCta);

          Exit;
        End;

      End;
    End;
  end;

  If fVerificaCampos Then
  Begin
    blnConfirma   := True;
    strPorBai     := edtPorBai.Text;
    strNomPorBai  := edtCodPorBai.Text;
    strCtaBai     := fraPlanoDeContasCre.MskCodCta.Text;
    strPorDeb     := edtPorDeb.Text;
    strCtaDeb     := fraPlanoDeContasDeb.MskCodCta.Text;
    strCodEve     := fraCentroCusto.edtCodEve.Text;

    if gpbDescontoAntecipacao.Visible Then
    begin
      if AValorTaxa > 0 then
      begin
        AValorTarifaAntecipacao := fStrToFloat(edtValorTarifa.Text);
        APlanoContasDescAntec   := fraPlanoDeContasTar.MskCodCta.Text;
        AFornecedorDescAntec    := edtFornecedorTarifa.Text;
      end;
    end;

    Close;
  End;
end;

//PROCEDURE QUE FAZ O CALCULO DO VALOR DA TARIFA E VALOR LÍQUIDO DO GRUPO DE DESCONTO POR ANTECIPAÇÃO
procedure TfrmBaixaAnalitica.CalcularDescontoAntecipacao;
Var
  AValorTarifa: Double;
  AValorLiquido: Double;
begin
//* O CAMPO "VALOR TARIFA" DEVE SER A TAXA BANCARIA APLICADA SOBRE O VALOR TOTAL DE CHEQUES.
//* O CAMPO "VALOR LIQUIDO" DEVE SER O VALOR TOTAL DE CHEQUES MENOS(-) O VALOR DA TARIFA.
  AValorTarifa  := fFormataFloat(AValorTaxa * (fStrToFloat(edtValorTotalCheques.Text) / 100), 2);
  AValorLiquido := fFormataFloat(fStrToFloat(edtValorTotalCheques.Text) - AValorTarifa, 2);

  edtValorTarifa.Text  := FormatFloat('#,##0.00', AValorTarifa);
  edtValorLiquido.Text := FormatFloat('#,##0.00', AValorLiquido);
end;

procedure TfrmBaixaAnalitica.CarregaCentroCustoDesconto;
begin
  pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContasTar.MskCodCta.Text);
  With qryConCta Do
  Begin
    fraPlanoDeContasTar.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmBaixaAnalitica.edtPorDebKeyPress(Sender: TObject;
  var Key: Char);
  Var
    blnValidou: Boolean;
    arrSel : TConsultasArray;

begin
  inherited;

  blnValidou := False;

  If fPesqPortador(conSimples, Self, edtPorDeb, edtCodPorDeb, nil, Key, arrSel) Then
  Begin
    If (fValidaCampos(edtPorDeb)) Then
    Begin
      Self.SelectNext(ActiveControl, True, True);
      blnValidou := True;
    End;

  End;
  pCarregaPortadorDebito;

  {************************************************}
  {* SE O PORTADOR NÃO FOR VALIDADO, NÃO CONTINUA *}
  {*********************************************PZ*}
  If (Not blnValidou) Then
    Exit;

  If (edtPorDeb.Text <> EmptyStr) Then
  Begin
    fraPlanoDeContasDeb.MskCodCta.Enabled := true;
    pSetFocus(fraPlanoDeContasDeb.MskCodCta);
  End
  Else
  Begin
    edtPorDeb.Enabled := true;
    pSetFocus(edtPorDeb);
  End;

end;

procedure TfrmBaixaAnalitica.edtFornecedorTarifaKeyPress(Sender: TObject; var Key: Char);
Var
  arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {*********************************}
  If fPesqFornecedor(conForCompleta, Self, edtFornecedorTarifa, edtDesFornecedorTarifa, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtFornecedorTarifa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaAnalitica.edtPorBaiChange(Sender: TObject);
begin
  inherited;
  fraPlanoDeContasCre.MskCodCta.Enabled := True;
end;

end.

