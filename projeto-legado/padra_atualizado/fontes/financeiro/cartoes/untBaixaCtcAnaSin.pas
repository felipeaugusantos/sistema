{***************************}
{* qryConPor -> CADPOR     *}
{* qryConCta -> CADCTA     *}
{* qryConFor -> CADFOR     *}
{************************JB*}
unit untBaixaCtcAnaSin;

interface

uses
  Controls, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, EditFocus, Mask,
  MaskEditFocus, Uni, Menus, AppEvnts, BitBtnLockedIncrem, Classes, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  untFrameCentroCustoEditFocus, Vcl.Forms, untFramePlanoDeContasMaskEdit;

type
  TfrmBaixaCtcAnaSin = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    pnlFundo: TPanel;
    Panel1: TPanel;
    Label4: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    edtDesPorTax: TEditFocus;
    edtDesPorCar: TEditFocus;
    edtPorTax: TEditFocus;
    edtPorCar: TEditFocus;
    edtDesCodFor: TEditFocus;
    edtCodFor: TEditFocus;
    Panel2: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    edtPorDeb: TEditFocus;
    edtDesPorDeb: TEditFocus;
    Panel3: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edtHistor: TEditFocus;
    edtNumDoc: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    mskDtaDoc: TcxDateEdit;
    fraCentroCustoCartaoC: TfraCentroCustoEditFocus;
    fraCentroCustoTaxaC: TfraCentroCustoEditFocus;
    fraCentroCustoCartaoD: TfraCentroCustoEditFocus;
    fraPlanoDeContasCar: TfraPlanoDeContasMskEdit;
    fraPlanoDeContasDeb: TfraPlanoDeContasMskEdit;
    fraPlanoDeContasTax: TfraPlanoDeContasMskEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtPorCarKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorTaxKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorDebChange(Sender: TObject);
    procedure edtPorDebKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasCarMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasDebMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasTaxMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
  private
    { Private declarations }
    qryConFor: TUniQuery;
    qryConCta: TUniQuery;
    qryConPor: TUniQuery;
    qryConEve: TUniQuery;

    function fValidaDataPortador(strCodPor: String): Boolean;

    procedure pCarregaPortador(strCodPor: String; Var edtRetorno: TEditFocus);
    procedure pCarregaCentroCusto(strCodCta: String; Var edtRetorno: TEditFocus);
    procedure pCarregaCentroCustoFor(strCodCta: String; Var edtRetorno: TEditFocus);
    procedure pCarregaEvento(strCodEve: String; Var edtRetorno: TEditFocus);

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strPorCar,
    strCtaCar,
    strPorDeb,
    strCtaDeb,
    strPorTax,
    strCtaTax,
    strForTax,
    strCodEmp,
    strEveDeb,
    strEventoCredito,
    strEventoTaxa,
    strPortadorExtrato : String;
    dtaMaxDta: TDate;

    {*****************************************}
    {* DADOS ESPECIFICOS DA BAIXA SINTÉTICA  *}
    {**************************************MV*}
    dtaDtaDoc: TDateTime;
    strNumDoc: String;
    strHisDoc: String;

    blnBaiAna  : Boolean;
    blnConfirma: Boolean;
    blnZeraTx  : Boolean;
    blnConcil  : Boolean;
    blnVemBxCart : Boolean;
  end;


implementation

uses SysUtils, untfuncoesSimples, untPai, untCadCta, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmBaixaCtcAnaSin.FormCreate(Sender: TObject);
begin
  inherited;

  strNumDoc := '';
  strHisDoc := '';

  strPortadorExtrato := '';

  mskDtaDoc.Text := DateToStr(VS_Date);

  blnConfirma := False;
  blnConcil   := False;

  qryConPor := fCriaQuery(Self);
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryConEve := fCriarQuery('SELECT * FROM CADEVE WHERE FALSE', Self);

end;

procedure TfrmBaixaCtcAnaSin.fraPlanoDeContasCarMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContasCar.MskCodCta, fraPlanoDeContasCar.edtDesCta, Nil, Key, arrCentroCusto, True, False, '', blnVemBxCart) Then
  Begin
    if fValidaCampos(TMaskEditFocus(Sender)) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBaixaCtcAnaSin.fraPlanoDeContasDebMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContasDeb.MskCodCta, fraPlanoDeContasDeb.edtDesCta, Nil, Key, arrCentroCusto, True, False, '', blnVemBxCart) Then
  Begin
    if fValidaCampos(TMaskEditFocus(Sender)) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBaixaCtcAnaSin.fraPlanoDeContasTaxMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If Not fCfgSis('USACTF', varBoolean) Then
  Begin
    If fPesqCentroCusto(Self, fraPlanoDeContasTax.MskCodCta, fraPlanoDeContasTax.edtDesCta, Nil, Key, arrCentroCusto, True, False, '', blnVemBxCart) Then
    Begin
      if fValidaCampos(TMaskEditFocus(Sender)) then
        SelectNext(ActiveControl, True, True);
    End;
  End
  Else
  Begin
    If Not fEmptyStr(strCodEmp) Then
    Begin
      If fPesqCentroCusto(Self, fraPlanoDeContasTax.MskCodCta, fraPlanoDeContasTax.edtDesCta, Nil, Key, arrCentroCusto, True, True, edtCodFor.Text, blnVemBxCart) Then
      Begin
        if fValidaCampos(TMaskEditFocus(Sender)) then
          SelectNext(ActiveControl, True, True);
      End;
    End
    Else
    Begin
      If fPesqCentroCusto(Self, fraPlanoDeContasTax.MskCodCta, fraPlanoDeContasTax.edtDesCta, Nil, Key, arrCentroCusto, True, True, edtCodFor.Text, blnVemBxCart) Then
      Begin
        if fValidaCampos(TMaskEditFocus(Sender)) then
          SelectNext(ActiveControl, True, True);
      End;
    End;
  End;

end;

function TfrmBaixaCtcAnaSin.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var SEditFocus : TEditFocus;
    SMensagem  : String;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtPorCar) And (Not blnConcil) Then
    Begin

      If (fEmptyStr(edtPorCar.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Portador do Cartão deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaPortador(edtPorCar.Text, edtDesPorCar);
        If qryConPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
          Result := False;
        End

        Else If (Not fPortadorPermiteBaixa(edtPorCar.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
          Result := False;
        End

        Else If Not fEmpresaTemAcessoPortador(edtPorCar.Text, VS_strCodEmp) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End

        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtPorCar.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&O k']);
            Result := False;
          End;
        End;

        If (Not fValidaDataPortador(edtPorCar.Text)) And (Result) Then
        Begin
          fMensagem('ATENÇÃO', 'Não é permitido utilizar o portador ' + edtPorCar.Text + ', pois sua Data Inicial é maior que a Data da Baixa!',['&O K']);
          Result := False;

        End;
      End;

    End

    Else If (Sender = fraPlanoDeContasCar.MskCodCta) And (Not blnConcil) Then
    Begin

      If fEmptyStr(fraPlanoDeContasCar.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas do Cartão deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If Not fValidaLinhaGrupoCadCta(fraPlanoDeContasCar.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Linha / Grupo do Plano de Contas não permitido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaCentroCusto(fraPlanoDeContasCar.MskCodCta.Text, fraPlanoDeContasCar.edtDesCta);
        If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
          Result := False;
        End
        else if (blnVemBxCart) and (qryConCta.FieldByName('CTA_PERBCA').AsString <> 'S') then
        Begin
           fMensagem('ATENÇÃO!', 'Esse Plano de Contas não é permitido na baixa de cartão!', ['&O k']);
           Result := False;
        End
        Else If Not PlanoDeContasAtivo(fraPlanoDeContasCar.MskCodCta.Text) Then
          Result := False;
      End;

    End

    Else If (Sender = edtPorTax) And (Not blnConcil) Then
    Begin

      If Not blnZeraTx Then
      Begin
        If (fEmptyStr(edtPorTax.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Portador da Taxa deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          pCarregaPortador(edtPorTax.Text, edtDesPorTax);
          If qryConPor.FieldByName('POR_CODPOR').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
            Result := False;
          End
          Else If (Not fPortadorPermiteBaixa(edtPorTax.Text)) Then
          Begin
            fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
            Result := False;
          End

          Else If Not fEmpresaTemAcessoPortador(edtPorTax.Text, VS_strCodEmp) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End

          Else If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtPorTax.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&O k']);
              Result := False;
            End;
          End;

          If (Not fValidaDataPortador(edtPorTax.Text)) And (Result) Then
          Begin
            fMensagem('ATENÇÃO', 'Não é permitido utilizar o portador ' + edtPorTax.Text + ', pois sua Data Inicial é maior que a Data da Baixa!',['&O K']);
            Result := False;

          End;
        End;
      End;

    End

    Else If (Sender = edtCodFor) And (Not blnConcil) Then
    Begin

      If Not blnZeraTx Then
      Begin
        If (fEmptyStr(edtCodFor.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Fornecedor deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          edtDesCodFor.Text := IIF(fEmptyStr(edtCodFor.Text), '', fRetNomFornecedor(edtCodFor.Text));

          If fEmptyStr(edtDesCodFor.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&O k']);
            Result := False;
          End;
        End;
      End;

    End

    Else If (Sender = fraPlanoDeContasTax.MskCodCta) And (Not blnConcil) Then
    Begin

      If Not blnZeraTx Then
      Begin
        If fEmptyStr(fraPlanoDeContasTax.MskCodCta.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Plano de Contas do Cartão deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaLinhaGrupoCadCta(fraPlanoDeContasTax.MskCodCta.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Linha / Grupo do plano de contas não permitido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          pCarregaCentroCustoFor(fraPlanoDeContasTax.MskCodCta.Text, fraPlanoDeContasTax.edtDesCta);
          If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
          Begin
            If Not fCfgSis('USACTF', varBoolean) Then
              fMensagem('ATENÇÃO!', 'Esse plano de contas não está cadastrado!', ['&O k'])
            Else
              fMensagem('ATENÇÃO!', 'Esse plano de contas não está cadastrado ou não está vinculado ao fornecedor!', ['&O k']);

            Result := False;
          End
          else if (blnVemBxCart) and (qryConCta.FieldByName('CTA_PERBCA').AsString <> 'S') then
          Begin
             fMensagem('ATENÇÃO!', 'Esse Plano de Contas não é permitido na baixa de cartão!', ['&O k']);
             Result := False;
          End
          Else If (blnBaiAna) Then
          Begin

  {          If (fValidaLinhaGrupo) Then
            Begin

              If (fMensagem('ATENÇÃO!', 'Confirma baixa?', ['&S i m', '&N ã o']) = 1) Then
              Begin

                strPorCar := edtPorCar.Text;
                strCtaCar := mskCtaCar.Text;
                strPorTax := edtPorTax.Text;
                strCtaTax := mskCtaTax.Text;

                blnConfirma := True;
                Close;

              End
              Else
              Begin
                pSetFocus(mskCtaTax);
                blnMudarFoco := False;
              End;

            End;}

          End
          Else If Not PlanoDeContasAtivo(fraPlanoDeContasTax.MskCodCta.Text) Then
            Result := False
        End;
      End;

    End

    {**********************************}
    { VALIDA PORTADOR DO DEBITO        }
    {*******************************JB*}
    Else If (Sender = edtPorDeb) And (Not blnConcil) Then
    Begin

      If Not (fEmptyStr(edtPorDeb.Text)) Then
      Begin
        pCarregaPortador(edtPorDeb.Text, edtDesPorDeb);
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

        Else If Not fEmpresaTemAcessoPortador(edtPorDeb.Text, VS_strCodEmp) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End

       Else If fCfgSis('DACPOR', varBoolean) And (Pos(edtPorDeb.Text, strPortadoresOperador) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&O k']);
          Result := False;
        End

        Else If Not fEmptyStr(edtPorCar.Text) And (edtPorCar.Text = edtPorDeb.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'O portador do Grupo de Débito não pode ser o mesmo do Grupo de Crédito!',['&O K']);
          Result := False;
        End;

        If (Not fValidaDataPortador(edtPorDeb.Text)) And (Result) Then
        Begin
          fMensagem('ATENÇÃO', 'Não é permitido utilizar o portador ' + edtPorDeb.Text + ', pois sua Data Inicial é maior que a Data da Baixa!',['&O K']);
          Result := False;

        End;
      End
      Else
        edtDesPorDeb.Clear;

    End

    {**********************************}
    { VALIDA CENTRO DE CUSTO DO DEBITO }
    {*******************************JB*}
    Else If (Sender = fraPlanoDeContasDeb.MskCodCta) And (Not blnConcil) Then
    Begin
      If (Not fEmptyStr(edtPorDeb.Text)) then
      Begin
        If (fEmptyStr(fraPlanoDeContasDeb.MskCodCta.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Obrigatório escolher um plano de contas!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          pCarregaCentroCusto(fraPlanoDeContasDeb.MskCodCta.Text, fraPlanoDeContasDeb.edtDesCta);
          If fEmptyStr(fraPlanoDeContasDeb.edtDesCta.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse plano de contas não está cadastrado!', ['&O k']);
            Result := False;
          End
          else if (blnVemBxCart) and (qryConCta.FieldByName('CTA_PERBCA').AsString <> 'S') then
          Begin
             fMensagem('ATENÇÃO!', 'Esse Plano de Contas não é permitido na baixa de cartão!', ['&O k']);
             Result := False;
          End
          Else If Not PlanoDeContasAtivo(fraPlanoDeContasDeb.MskCodCta.Text) Then
            Result := False
        End;
      End
      Else
        fraPlanoDeContasDeb.edtDesCta.Clear;
    End

    Else If ((Sender = fraCentroCustoCartaoD.edtCodEve) or (Sender = fraCentroCustoCartaoC.edtCodEve) or (sender = fraCentroCustoTaxaC.edtCodEve))
     and (Not blnConcil) then
      begin

        if fEmptyStr(TEditFocus(Sender).Text) and fCfgSis('CTPOBE', varBoolean) Then
          Begin
            SMensagem := '';
            if Sender = fraCentroCustoCartaoC.edtCodEve then
              SMensagem := 'O campo Centro de Custos do crédito deve ser preenchido.'
            else
            if Sender = fraCentroCustoTaxaC.edtCodEve then
              SMensagem := 'O campo Centro de Custos da taxa deve ser preenchido.'
            else
            if not fEmptyStr(fraCentroCustoCartaoD.edtCodEve.Text) then
              SMensagem := 'O campo Centro de Custos do débito deve ser preenchido.';

            if not fEmptyStr(SMensagem) then
              begin
                fMensagem('ATENÇÃO!', SMensagem, ['&Ok']);
                pSetFocus(Sender);
                Exit(False);
              end;
          End;

        if Sender = fraCentroCustoCartaoD.edtCodEve then
          SEditFocus := fraCentroCustoCartaoD.edtDesEve
        else
        if Sender = fraCentroCustoCartaoC.edtCodEve then
          SEditFocus := fraCentroCustoCartaoC.edtDesEve
        else
          SEditFocus := fraCentroCustoTaxaC.edtDesEve;

        SEditFocus.Text := fRetNomEvento(TEditFocus(Sender));

        If Not fEmptyStr(TEditFocus(Sender).Text) Then
        Begin
          TEditFocus(sender).Text := fStrZero(TEditFocus(Sender).Text,5);
          pCarregaEvento(TEditFocus(Sender).Text, SEditFocus);

          If fEmptyStr(SEditFocus.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&Ok']);
            pSetFocus(sender);
            Exit(False);
          End;

          If (Sender = fraCentroCustoCartaoD.edtCodEve) and (Result) And (fEmptyStr(edtPorDeb.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Para utilizar o Centro de Custos de débito é necessário selecionar '+
              'Portador e Plano de Contas de débito!', ['&Ok']);
            Exit(False);
          End;

        End
        Else
        Begin
          SEditFocus.Clear;
          TEditFocus(Sender).Clear;
        End;

      end

    Else If (Sender = mskDtaDoc) And (Not blnBaiAna) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaDoc.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data do Documento deve ser preenchida!', ['&O k']);
        Result := False;
      End;

    End

{    Else If (Sender = edtNumDoc) And (Not blnBaiAna) Then
    Begin
      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Número do Documento deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End}

    Else If (Sender = edtHistor) And (Not blnBaiAna) Then
    Begin
      If fEmptyStr(edtHistor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Histórico do Documento deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin

{        If (fValidaLinhaGrupo) Then
        Begin

          If (fMensagem('ATENÇÃO!', 'Confirma baixa?', ['&S i m', '&N ã o']) = 1) Then
          Begin

            strPorCar := edtPorCar.Text;
            strCtaCar := mskCtaCar.Text;
            strPorTax := edtPorTax.Text;
            strCtaTax := mskCtaTax.Text;

            dtaDtaDoc := StrToDate(mskDtaDoc.Text);
            strNumDoc := edtNumDoc.Text;
            strHisDoc := edtHistor.Text;

            blnConfirma := True;
            Close;

          End
          Else
          Begin
            pSetFocus(edtHistor);
            blnMudarFoco := False;
          End;

        End;}

      End;
    End

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmBaixaCtcAnaSin.fValidaDataPortador(strCodPor: String): Boolean;
begin
  Result := (qryConPor.FieldByName('POR_DTAINI').IsNull) Or (IIF(blnBaiAna, dtaMaxDta, mskDtaDoc.Date) >= qryConPor.FieldByName('POR_DTAINI').Value);
end;

procedure TfrmBaixaCtcAnaSin.pCarregaEvento(strCodEve: String;
  var edtRetorno: TEditFocus);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADEVE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  EVE_CODEVE = :CODEVE ';

  With qryConEve Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEVE').AsString := strCodEve;
    Open;
    edtRetorno.Text := IIF(fEmptyStr(strCodEve), '', FieldByName('EVE_DESEVE').AsString);
  End;
end;

procedure TfrmBaixaCtcAnaSin.pCarregaCentroCusto(strCodCta: String;
  var edtRetorno: TEditFocus);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCTA ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTA_CODCTA = :CODCTA ';

  With qryConCta Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCTA').AsString := strCodCta;
    Open;
    edtRetorno.Text := IIF(fEmptyStr(strCodCta), '', FieldByName('CTA_DESCTA').AsString);
  End;
end;

procedure TfrmBaixaCtcAnaSin.pCarregaCentroCustoFor(strCodCta: String;
  var edtRetorno: TEditFocus);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCTA ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTA_CODCTA = :CODCTA ';

  If fCfgSis('USACTF', varBoolean) Then
  Begin
    strSQL := strSQL + '  AND CTA_CODCTA IN ';
    strSQL := strSQL + '  (SELECT CTF_CODCTA FROM CTAFOR WHERE CTF_CODFOR = :CODFOR) ';
  End;

  With qryConCta Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCTA').AsString := strCodCta;

    If fCfgSis('USACTF', varBoolean) Then
      ParamByName('CODFOR').AsString := edtCodFor.Text;

    Open;
    edtRetorno.Text := IIF(fEmptyStr(strCodCta), '', FieldByName('CTA_DESCTA').AsString);
  End;
end;

procedure TfrmBaixaCtcAnaSin.pCarregaPortador(strCodPor: String;
  var edtRetorno: TEditFocus);
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADPOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  POR_CODPOR = :CODPOR ';

  With qryConPor Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODPOR').AsString := strCodPor;
    Open;
    edtRetorno.Text := IIF(fEmptyStr(strCodPor), '', FieldByName('POR_NOMPOR').AsString);
  End;

end;

procedure TfrmBaixaCtcAnaSin.FormShow(Sender: TObject);
begin
  inherited;
  If blnBaiAna Then
  begin
    mskDtaDoc.Visible := False;
    Label12.Visible   := False;
    Label10.Top       := Label11.Top;
    edtHistor.Top     := edtNumDoc.Top;
    Label11.Top       := Label12.Top;
    edtNumDoc.Top     := mskDtaDoc.Top;
    Self.Height       := 415;
  end;

  If fCfgSis('BAIOTI', varBoolean) Then
  Begin
    edtPorCar.Text := strPorCar;
    pCarregaPortador(edtPorCar.Text, edtDesPorCar);

    fraPlanoDeContasCar.MskCodCta.Text := strCtaCar;
    pCarregaCentroCusto(fraPlanoDeContasCar.MskCodCta.Text, fraPlanoDeContasCar.edtDesCta);

    edtPorTax.Text := strPorTax;
    pCarregaPortador(edtPorTax.Text, edtDesPorTax);

    fraPlanoDeContasTax.MskCodCta.Text := strCtaTax;
    pCarregaCentroCusto(fraPlanoDeContasTax.MskCodCta.Text, fraPlanoDeContasTax.edtDesCta);

    edtCodFor.Text := strForTax;
    edtDesCodFor.Text := IIF(fEmptyStr(strForTax), '', fRetNomFornecedor(edtCodFor.Text));

    edtPorDeb.Text := strPorDeb;
    pCarregaPortador(edtPorDeb.Text, edtDesPorDeb);

    fraPlanoDeContasDeb.MskCodCta.Text := strCtaDeb;
    pCarregaCentroCusto(fraPlanoDeContasDeb.MskCodCta.Text, fraPlanoDeContasDeb.edtDesCta);

    fraCentroCustoCartaoD.edtCodEve.Text := strEveDeb;
    fraCentroCustoCartaoD.edtDesEve.Text := fRetNomEvento(strEveDeb);

    fraCentroCustoCartaoC.edtCodEve.Text := strEventoCredito;
    fraCentroCustoCartaoC.edtDesEve.Text := fRetNomEvento(strEventoCredito);

    fraCentroCustoTaxaC.edtCodEve.Text := strEventoTaxa;
    fraCentroCustoTaxaC.edtDesEve.Text := fRetNomEvento(strEventoTaxa);

   {If (Not fEmptyStr(strPorCar)) Then
      pSetFocus(edtPorDeb);}
  End;

  If Not strPortadorExtrato.IsEmpty Then
  Begin
    edtPorCar.Text := strPortadorExtrato;
    pCarregaPortador(edtPorCar.Text, edtDesPorCar);
  End;

  edtPorTax.Enabled := (Not blnZeraTx) And (Not blnConcil);
  fraPlanoDeContasTax.MskCodCta.Enabled := (Not blnZeraTx) And (Not blnConcil);
  edtCodFor.Enabled := (Not blnZeraTx) And (Not blnConcil);

  If blnConcil Then
  Begin
    Panel1.Visible    := False;
    Panel2.Visible    := False;
    mskDtaDoc.Visible := False;
    Label12.Visible   := False;
    Height := 160;
    pSetFocus(edtNumDoc);
  End;
end;

procedure TfrmBaixaCtcAnaSin.edtPorCarKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqPortador(conSimples,
                   Self,
                   edtPorCar,
                   edtDesPorCar,
                   nil,
                   Key,
                   arrSel,
                   True,
                   'Consulta de Portadores',
                   '',
                   False,
                   False) Then
  Begin
    If (fValidaCampos(edtPorCar)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBaixaCtcAnaSin.edtPorTaxKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqPortador(conSimples, Self, edtPorTax, edtDesPorTax, nil, Key, arrSel) Then
  Begin
    If (fValidaCampos(edtPorTax)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBaixaCtcAnaSin.btnConfirmaDadosClick(Sender: TObject);
  Var
    strCfg_PORPGR: String;
    strCfg_CTAGCP: String;
begin
  inherited;

  If (Not fEmptyStr(edtPorCar.Text)) Or (Not fEmptyStr(fraPlanoDeContasCar.MskCodCta.Text)) Or
     (Not fEmptyStr(edtPorTax.Text)) Or (Not fEmptyStr(fraPlanoDeContasTax.MskCodCta.Text)) Or
     (Not fEmptyStr(edtPorDeb.Text)) Or (Not fEmptyStr(fraPlanoDeContasDeb.MskCodCta.Text)) Then
  Begin
    strCfg_PORPGR := fCfgSis('PORPGR');
    strCfg_CTAGCP := fCfgSis('CTAGCP');

    If (Not fEmptyStr(strCfg_PORPGR)) Then
    Begin

      If ((Not fEmptyStr(edtPorCar.Text)) And (edtPorCar.Text = strCfg_PORPGR)) Or
         ((Not fEmptyStr(edtPorTax.Text)) And (edtPorTax.Text = strCfg_PORPGR)) Or
         ((Not fEmptyStr(edtPorDeb.Text)) And (edtPorDeb.Text = strCfg_PORPGR)) Then
      Begin
        pMensagemOk('Portador ' + strCfg_PORPGR + ' não permitido, pois está configurado para baixa de Contas a Pagar no resumo de caixa.');

        If ((Not fEmptyStr(edtPorCar.Text)) And (edtPorCar.Text = strCfg_PORPGR)) Then
          pSetFocus(edtPorCar)

        Else If ((Not fEmptyStr(edtPorTax.Text)) And (edtPorTax.Text = strCfg_PORPGR)) Then
          pSetFocus(edtPorTax)

        Else If ((Not fEmptyStr(edtPorDeb.Text)) And (edtPorDeb.Text = strCfg_PORPGR)) Then
          pSetFocus(edtPorDeb);

        Exit;
      End;

    End;

    If (Not fEmptyStr(strCfg_CTAGCP)) Then
    Begin

      If ((Not fEmptyStr(fraPlanoDeContasCar.MskCodCta.Text)) And (fraPlanoDeContasCar.MskCodCta.Text = strCfg_CTAGCP)) Or
         ((Not fEmptyStr(fraPlanoDeContasTax.MskCodCta.Text)) And (fraPlanoDeContasTax.MskCodCta.Text = strCfg_CTAGCP)) Or
         ((Not fEmptyStr(fraPlanoDeContasDeb.MskCodCta.Text)) And (fraPlanoDeContasDeb.MskCodCta.Text = strCfg_CTAGCP)) Then
      Begin
        pMensagemOk('Plano de Contas ' + strCfg_CTAGCP + ' não permitido, pois está configurado para baixa de Contas a Pagar no resumo de caixa.');

        If ((Not fEmptyStr(fraPlanoDeContasCar.MskCodCta.Text)) And (fraPlanoDeContasCar.MskCodCta.Text = strCfg_CTAGCP)) Then
          pSetFocus(fraPlanoDeContasCar.MskCodCta)

        Else If ((Not fEmptyStr(fraPlanoDeContasTax.MskCodCta.Text)) And (fraPlanoDeContasTax.MskCodCta.Text = strCfg_CTAGCP)) Then
          pSetFocus(fraPlanoDeContasTax.MskCodCta)

        Else If ((Not fEmptyStr(fraPlanoDeContasDeb.MskCodCta.Text)) And (fraPlanoDeContasDeb.MskCodCta.Text = strCfg_CTAGCP)) Then
          pSetFocus(fraPlanoDeContasDeb.MskCodCta);

        Exit;
      End;

    End;
  End;

  If (Not fValidaCampos(mskDtaDoc)) Then
    Exit;

  If (fVerificaCampos) And
     (fMensagem('ATENÇÃO!', 'Confirma baixa?', ['&Sim', '&Não']) = 1) Then
  Begin

    strPorCar := edtPorCar.Text;
    strCtaCar := fraPlanoDeContasCar.MskCodCta.Text;
    strPorTax := edtPorTax.Text;
    strCtaTax := fraPlanoDeContasTax.MskCodCta.Text;
    strForTax := edtCodFor.Text;

    strPorDeb        := edtPorDeb.Text;
    strCtaDeb        := fraPlanoDeContasDeb.MskCodCta.Text;
    strEveDeb        := fraCentroCustoCartaoD.edtCodEve.Text;
    strEventoCredito := fraCentroCustoCartaoC.edtCodEve.Text;
    strEventoTaxa    := fraCentroCustoTaxaC.edtCodEve.Text;

    dtaDtaDoc := StrToDate(mskDtaDoc.Text);
    strNumDoc := edtNumDoc.Text;
    strHisDoc := edtHistor.Text;

    blnConfirma := True;
    Close;

  End;
end;

procedure TfrmBaixaCtcAnaSin.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmBaixaCtcAnaSin.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
    
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, eDTCodFor, edtDesCodFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBaixaCtcAnaSin.edtPorDebChange(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtPorDeb.Text)) Then
  Begin
    fraPlanoDeContasDeb.MskCodCta.Enabled := False;
    fraPlanoDeContasDeb.MskCodCta.Clear;
  End
  Else
    fraPlanoDeContasDeb.MskCodCta.Enabled := True;
end;

procedure TfrmBaixaCtcAnaSin.edtPorDebKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqPortador(conSimples, Self, edtPorDeb, edtDesPorDeb, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtPorDeb, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

end.

