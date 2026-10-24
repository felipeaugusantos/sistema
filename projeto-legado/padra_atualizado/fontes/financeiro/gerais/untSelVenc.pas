unit untSelVenc;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Vcl.Mask, MaskEditFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxButtons, Uni, Vcl.DBCtrls, DBMemoFocus, MemoFocus, DBEditFocus,
  untFramePlanoDeContasMaskEdit, untTypesSistema, untFrameCentroCustoDBEditFocus,
  untFrameCentroCustoEditFocus, System.StrUtils, QColorLabel;

type
  TfrmSelVen = class(TfrmPai)
    Label1: TLabel;
    Label3: TLabel;
    mskCompet: TMaskEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    mskDtaVen: TcxDateEdit;
    Label2: TLabel;
    btnConfirma: TBitBtnLocked;
    Label17: TLabel;
    memHistorico: TMemoFocus;
    lblDesPor: TLabel;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    fraCentroCusto: TfraCentroCustoEditFocus;
    lblPrevSN: TColorLabel;
    lblPrevis: TLabel;
    edtPrevis: TEditFocus;

    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure fraPlanoDeContasMskEdit1MskCodCtaExit(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasMskCodCtaEnter(Sender: TObject);
  private
    { Private declarations }
    qryConEmp: TUniQuery;

    arrCentCusto: TConsultasArray;
    arrPortador: TConsultasArray;
    FstrCodCta: String;
    FstrCodPor: String;
    FstrFUNCPG: String;
    FblnValFun: Boolean;
    procedure pCarregaEmpresa;

    procedure CarregaCentroDeCustos;

    procedure SetstrCodCta(const Value: String);
    procedure SetstrCodPor(const Value: String);
    procedure SetstrFUNCPG(const Value: String);
    procedure SetblnValFun(const Value: Boolean);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnGerPag: Boolean;
    property strFUNCPG: String read FstrFUNCPG write SetstrFUNCPG;
    property strCodCta: String read FstrCodCta write SetstrCodCta;
    property strCodPor: String read FstrCodPor write SetstrCodPor;
    property blnValFun: Boolean read FblnValFun write SetblnValFun;
    procedure HabilitaPrevisao;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untPesqAux, untFuncoesConsulta, untCadCta;

procedure TfrmSelVen.HabilitaPrevisao;
begin
  edtPrevis.Visible := True;
  lblPrevis.Visible := True;
  lblPrevSN.Visible := True;

  edtPrevis.Text := 'N';
end;

procedure TfrmSelVen.btnConfirmaClick(Sender: TObject);
begin
  If strFUNCPG = 'A' Then
  Begin
    If (fraPlanoDeContas.MskCodCta.Text = '') And blnValFun Then
    Begin
      fMensagem('ATENÇÃO!','É necessário informar o Plano de Contas!',['&O k']);
      pSetFocus(fraPlanoDeContas.MskCodCta, Self);
      Exit;
    End;
    If edtCodPor.Text = '' Then
    Begin
      fMensagem('ATENÇÃO!','É necessário informar o Portador!',['&O k']);
      pSetFocus(edtCodPor, Self);
      Exit;
    End;

    strCodCta := fRemoveAcentoPontos(fraPlanoDeContas.MskCodCta.Text);
    strCodPor := edtCodPor.Text;
  End;

  If Not fVerificaCampos Then
    SysUtils.Abort;

  blnGerPag := True;

  ModalResult := mrOk;

  inherited;
end;

procedure TfrmSelVen.btnSairClick(Sender: TObject);
begin
  inherited;
  blnGerPag := False;
end;

procedure TfrmSelVen.CarregaCentroDeCustos;
begin
  fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve.Text);
end;

procedure TfrmSelVen.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {*******************************}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmSelVen.edtCodPorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPor, edtDesPor, arrPortador, Nil, fRetNomPortador, 'do Portador');
  if fEmptyStr(edtCodPor.Text) then
    edtDesPor.Clear;
end;

procedure TfrmSelVen.edtCodPorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples,
                   Self,
                   edtCodPor,
                   edtDesPor,
                   nil,
                   Key,
                   arrPortador,
                   False,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   edtCodEmp.Text) Then
    If fValidaCampos(edtCodPor) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmSelVen.FormCreate(Sender: TObject);
begin
  inherited;
  qryConEmp := fCriaQuery();
end;

procedure TfrmSelVen.FormShow(Sender: TObject);
begin
  inherited;
  edtCodEmp.Text := VS_strCodEmp;
  fValidaCampos(edtCodEmp);
  pSetFocus(mskCompet);
  blnGerPag := False;

  If strFUNCPG = 'A' Then
  Begin
    If Not fEmptyStr(strCodCta) Then
    Begin
      fraPlanoDeContas.MskCodCta.Text := strCodCta;
      pEdtCodSelectExit(fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, arrCentCusto, fRetNomeConta, Nil, 'da Conta');
    End;
    If Not fEmptyStr(strCodPor) Then
    Begin
      edtCodPor.Text := strCodPor;
      pEdtCodSelectExit(edtCodPor, edtDesPor, arrPortador, Nil, fRetNomPortador, 'do Portador');
    End;
  End;

  fraCentroCusto.Visible := strFUNCPG = 'KMT';

  If Not MatchStr(strFUNCPG, ['A', 'KMT']) Then
  Begin
    fraPlanoDeContas.Visible := False;
    lblDesPor.Visible := False;
    edtDesPor.Visible := False;
    edtCodPor.Visible := False;
    Self.Height := 283;
    memHistorico.Top := 54;
    Label17.Top := 54;
  End
  Else
  Begin
    memHistorico.Top := 105;
    Label17.Top := 105;

    If FstrFUNCPG = 'KMT' Then
    Begin
      memHistorico.Top := 126;
      Label17.Top := 126;
    End;
  End;
end;

procedure TfrmSelVen.fraPlanoDeContasMskCodCtaEnter(Sender: TObject);
begin
  inherited;
  fraPlanoDeContas.MskCodCta.EditMask := '';
end;

procedure TfrmSelVen.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = '/' Then
    fraPlanoDeContas.MskCodCtaKeyPress(Sender, Key);

  If (Key = #13) Then
  Begin
    pEdtCodSelectExit(fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, arrCentCusto, fRetNomeConta, Nil, 'da Conta');
    If(fValidaCampos(fraPlanoDeContas.MskCodCta, True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmSelVen.fraPlanoDeContasMskEdit1MskCodCtaExit(Sender: TObject);
begin
  inherited;
  fraPlanoDeContas.MskCodCtaExit(Sender);
  if fEmptyStr(fraPlanoDeContas.MskCodCta.Text) then
    fraPlanoDeContas.edtDesCta.Clear;
end;

function TfrmSelVen.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodEmp) Then
    Begin
      edtNomEmp.Clear;
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          pCarregaEmpresa;
          If qryConEmp.FieldByName('EMP_CODEMP').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = mskCompet) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(mskCompet.Text))) Then
      begin
        fMensagem('ATENÇÃO!', 'A competência deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If not fValidaDataStr('01/'+ mskCompet.Text) Then
        Begin
          pMensagemOk('Data informada na Competência não é válida!');
          Result := False;
        End
        Else If Length(fTiraCaracEspeciais(Trim(mskCompet.Text))) < 6 Then
        Begin
          pMensagemOk('O ano da Competência deve ser preenchido com 4 dígitos!');
          Result := False;
        End;
      End;
    End
    Else If (Sender = mskDtaVen) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaVen.Text)) Then
      Begin
        pMensagemOk('A data de vencimento deve ser preenchida!');
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA PREVISÃO                       *}
    {**************************************MA*}
    Else If (Sender = edtPrevis) Then
    Begin
      If (edtPrevis.Visible) Then
      Begin
        If (fEmptyStr(edtPrevis.Text))  Then
        Begin
          fMensagem('ATENÇÃO!','É necessário informar a Previsão!', ['&O k']);
          Result := False;
        End
        Else If Pos(edtPrevis.Text, 'SN') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!','O campo Previsão deve ser informado com (S)im ou (N)ão!', ['&O k']);
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO EVENTO             *}
    {**************************************LB*}
    Else If (Sender = fraCentroCusto.edtCodEve) And fraCentroCusto.Visible Then
    Begin

      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        CarregaCentroDeCustos;
        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (fRetTipoEvento(fraCentroCusto.edtCodEve.Text)='R') Then
        Begin
          fMensagem('ATENÇÃO', 'Esse Centro de Custos pode ser aplicado somente às contas a receber!',['&OK']);
          Result := False;
        End;
      End
      Else
      Begin
        If fCfgSis('CTPOBE', varBoolean) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Centro de Custos deve ser preenchido!', ['&O k']);
          Result := False;
        End;

        fraCentroCusto.edtDesEve.Clear;
      End;
    End;

    If (Result) And (strFUNCPG = 'A') Then
    Begin
      If (Sender = fraPlanoDeContas.MskCodCta)
      And (fEmptyStr(fraPlanoDeContas.MskCodCta.Text))
      And (blnValFun) Then
      Begin
        fMensagem('ATENÇÃO!','É necessário informar o Plano de Contas!',['&O k']);
        Result := False;
      End
      Else If (Sender = edtCodPor) And (fEmptyStr(edtCodPor.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','É necessário informar o Portador!',['&O k']);
        Result := False;
      End;
    End

    Else If (Result) And (strFUNCPG = 'KMT') Then
    Begin
      If (Sender = fraPlanoDeContas.MskCodCta) Then
      Begin
        If (fEmptyStr(fraPlanoDeContas.MskCodCta.Text)) Then
        Begin
          fMensagem('ATENÇÃO!','É necessário informar o Plano de Contas!',['&Ok']);
          Result := False;
        End
        Else If (Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.MskCodCta.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Linha / Grupo não é permitido!', ['&O k']);
          Result := False;
        End
        {************************************************}
        {* NÃO DEIXA INFORMAR CENTRO DE CUSTO DE RATEIO *}
        {*********************************************RV*}
        Else If (fraPlanoDeContas.MskCodCta.Text = fCfgSis('CTAPRI')) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Plano de Contas de Rateio não é permitido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If Not PlanoDeContasAtivo(fraPlanoDeContas.mskCodCta.Text) Then
          Begin
            Result := False;
          End
          Else If Result And fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then
          Begin
            If Not fCfgSis('USACTF', varBoolean) Then
              fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok'])
            Else
              fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado ou não está vinculado ao fornecedor!', ['&O k']);

            Result := False;
          End;
        End;
      End;
    End;


  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmSelVen.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  With qryConEmp Do
  Begin
    edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmSelVen.SetstrCodCta(const Value: String);
begin
  FstrCodCta := Value;
end;

procedure TfrmSelVen.SetstrCodPor(const Value: String);
begin
  FstrCodPor := Value;
end;

procedure TfrmSelVen.SetstrFUNCPG(const Value: String);
begin
  FstrFUNCPG := Value;
end;

procedure TfrmSelVen.SetblnValFun(const Value: Boolean);
begin
  FblnValFun := Value;
end;

end.
