unit untCtaDigDadosDDA;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, QColorLabel, untConsultas, Uni,
  untConstantes, untFuncoesSimples, untTypesSistema, untPesqAux, StrUtils,
  untFrameCentroCustoEditFocus, untFramePlanoDeContasMaskEdit;

type
  TfrmCtaDigDadosDDA = class(TfrmPaiConfirma)
    Label1: TLabel;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    ColorLabel2: TColorLabel;
    Label11: TLabel;
    Label4: TLabel;
    ColorLabel1: TColorLabel;
    Label5: TLabel;
    ColorLabel3: TColorLabel;
    Label6: TLabel;
    ColorLabel4: TColorLabel;
    Label7: TLabel;
    ColorLabel5: TColorLabel;
    edtCheque: TEditFocus;
    edtVeioNF: TEditFocus;
    edtDeposi: TEditFocus;
    edtVeiobo: TEditFocus;
    edtPrevis: TEditFocus;
    Label8: TLabel;
    edtHist01: TEditFocus;
    fraCentroCusto: TfraCentroCustoEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    Label2: TLabel;
    ColorLabel6: TColorLabel;
    edtPagAnt: TEditFocus;
    procedure btnSairClick(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure fraCentroCustoedtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
  private
    qryCadPor  : TUniQuery;
    qryCadCta  : TUniQuery;
    qryCadEve  : TUniQuery;

    FstrCodPor,
    FstrCodEve,
    FstrCodCta,
    FstrVeiobo,
    FstrVeioNF,
    FstrUsaChq,
    FstrDeposi,
    FstrPrevis,
    FstrCodEmp,
    FstrCodFor,
    FstrHist01,
    FstrPagAnt: String;

    blnGravaApenasPrevisao: Boolean;

    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
    procedure pCarregaEvento();

    function fValidaChqBolDep(Sender: TWinControl): Boolean;
    { Private declarations }
  public
    blnConfirma: Boolean;
    property strCodPor: String read FstrCodPor write FstrCodPor;
    property strCodEve: String read FstrCodEve write FstrCodEve;
    property strCodCta: String read FstrCodCta write FstrCodCta;
    property strVeiobo: String read FstrVeiobo write FstrVeiobo;
    property strVeioNF: String read FstrVeioNF write FstrVeioNF;
    property strUsaChq: String read FstrUsaChq write FstrUsaChq;
    property strDeposi: String read FstrDeposi write FstrDeposi;
    property strPrevis: String read FstrPrevis write FstrPrevis;
    property strCodEmp: String read FstrCodEmp write FstrCodEmp;
    property strCodFor: String read FstrCodFor write FstrCodFor;
    property strHist01: String read FstrHist01 write FstrHist01;
    property strPagAnt: String read FstrPagAnt write FstrPagAnt;
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmCtaDigDadosDDA: TfrmCtaDigDadosDDA;

implementation

{$R *.dfm}

procedure TfrmCtaDigDadosDDA.btnConfirmaClick(Sender: TObject);
begin
  If (fEmptyStr(edtCodPor.Text)) And (fEmptyStr(fraPlanoDeContas.MskCodCta.Text)) And
     (fEmptyStr(edtVeiobo.Text)) And (fEmptyStr(edtVeioNF.Text)) And
     (fEmptyStr(edtCheque.Text)) And (fEmptyStr(edtDeposi.Text)) And
     (fEmptyStr(edtPrevis.Text)) And (fEmptyStr(edtPagAnt.Text)) Then
  Begin
    pMensagemOk('É necessário alterar alguma informação para confirmar!');
    pSetFocus(edtCodPor);
    Exit;
  End;

  If Not fVerificaCampos Then
    Exit;

  If not fEmptyStr(edtCodPor.Text) Then
  Begin
    FstrCodPor := edtCodPor.Text;
    blnConfirma := True;
   End
  Else FstrCodPor := '';

  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
  Begin
    FstrCodEve := fraCentroCusto.edtCodEve.Text;
    blnConfirma := True;
   End
  Else FstrCodEve:='';

  If Not fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
  Begin
    FstrCodCta := fraPlanoDeContas.MskCodCta.Text;
    blnConfirma := True;
   End
  Else FstrCodCta:='';

  If Not fEmptyStr(edtVeiobo.Text) Then
  Begin
    FstrVeiobo := edtVeiobo.Text;
    blnConfirma := True;
   End
  Else FstrVeiobo:='';

  If Not fEmptyStr(edtVeioNF.Text) Then
  Begin
    FstrVeioNF := edtVeioNF.Text;
    blnConfirma := True;
   End
  Else FstrVeioNF:='';

  If Not fEmptyStr(edtCheque.Text) Then
  Begin
    FstrUsaChq := edtCheque.Text;
    blnConfirma := True;
   End
  Else FstrUsaChq:='';

  If Not fEmptyStr(edtDeposi.Text) Then
  Begin
    FstrDeposi := edtDeposi.Text;
    blnConfirma := True;
   End
  Else FstrDeposi:='';

  If Not fEmptyStr(edtPrevis.Text) Then
  Begin
    FstrPrevis := edtPrevis.Text;
    blnConfirma := True;
   End
  Else FstrPrevis:='';

  If Not fEmptyStr(edtHist01.Text) Then
  Begin
    FstrHist01 := edtHist01.Text;
    blnConfirma := True;
   End
  Else FstrHist01:='';

  If Not fEmptyStr(edtPagAnt.Text) Then
  Begin
    FstrPagAnt := edtPagAnt.Text;
    blnConfirma := True;
  End
  Else FstrPagAnt := 'N';

  Close;
end;

procedure TfrmCtaDigDadosDDA.btnSairClick(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  Close;
end;

procedure TfrmCtaDigDadosDDA.edtCodPorKeyPress(Sender: TObject; var Key: Char);
Var
  arrPortador : TConsultasArray;
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, Nil, Key, arrPortador) Then
    if fValidaCampos(edtCodPor) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCtaDigDadosDDA.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma:=False;
  FstrCodPor:='';
  FstrCodEve:='';
  FstrCodCta:='';
  FstrVeiobo:='';
  FstrVeioNF:='';
  FstrUsaChq:='';
  FstrDeposi:='';
  FstrPrevis:='';
  FstrHist01:='';
  FstrPagAnt:='N';

  blnGravaApenasPrevisao := (fCfgSis('CTPPRE', varBoolean)) And
                            (fVerPermissaoOperador('LIBCTPPREV', strLoginUsuarioLogado));
end;

procedure TfrmCtaDigDadosDDA.FormShow(Sender: TObject);
begin
  inherited;
  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryCadPor := fCriarQuery('SELECT * FROM CADPOR WHERE FALSE', Self);
  qryCadEve := fCriarQuery('SELECT * FROM CADEVE WHERE FALSE', Self);

  edtCodPor.Text := FstrCodPor;
  fraCentroCusto.edtCodEve.Text := FstrCodEve;
  fraPlanoDeContas.MskCodCta.Text := FstrCodCta;
  edtVeioNF.Text := FstrVeioNF;
  edtVeioBo.Text := FstrVeioBo;
  edtCheque.Text := FstrUsaChq;
  edtPrevis.Text := FstrPrevis;
  edtDeposi.Text := FstrDeposi;
  edtHist01.Text := FstrHist01;
  edtPagAnt.Text := FstrPagAnt;

  pCarregaPortador(edtCodPor.Text, edtDesPor);
  pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);
  pCarregaEvento();

  pSetFocus(edtCodPor);
end;

procedure TfrmCtaDigDadosDDA.fraCentroCustoedtCodEveKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  fraCentroCusto.edtCodEveKeyPress(Sender, Key);

end;

procedure TfrmCtaDigDadosDDA.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
  blnPesqCta     : Boolean;
begin
  inherited;
  If Not fCfgSis('USACTF', varBoolean) Then
    blnPesqCta := fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto)
  Else
    blnPesqCta := fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto, True, True, FstrCodFor);

  If blnPesqCta Then
    if fValidaCampos(fraPlanoDeContas.MskCodCta) then
      SelectNext(ActiveControl, True, True);
end;

function TfrmCtaDigDadosDDA.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodPor) Then
    Begin

      If fEmptyStr(edtCodPor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O portador deve ser preenchido!', ['&Ok']);
        edtDesPor.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaPortador(edtCodPor.Text, edtDesPor);
        If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!', ['&Ok']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End;
      End;

      If (Result) And ((fCfgSis('DACPOR', varBoolean)) And  (Pos(edtCodPor.Text, fRetPortadoresOperador(strLoginUsuarioLogado)) <= 0)) then
      Begin
        fMensagem('ATENÇÃO!', 'O Operador não possui Direito de Acesso ao Portador selecionado!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = fraCentroCusto.edtCodEve) Then
    Begin

      If fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        If (fCfgSis('CTPOBE', varBoolean)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Centro de Custo deve ser preenchido!', ['&O k']);
          Result := False;
        End;
        fraCentroCusto.edtDesEve.Clear;
      End
      Else
      Begin
        pCarregaEvento();
        if fEmptyStr(fraCentroCusto.edtDesEve.Text) then
        //If qryCadEve.FieldByName('EVE_CODEVE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custo não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin

      If fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser preenchido!', ['&Ok']);
        fraPlanoDeContas.edtDesCta.Clear;
        Result := False;
      End
      Else If (RightStr(fraPlanoDeContas.MskCodCta.Text, 3) = '000') Then
      Begin
        fMensagem('ATENÇÃO!', 'Linha / Grupo não é permitido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);
        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          If Not fCfgSis('USACTF', varBoolean) Then
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok'])
          Else
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado ou não está vinculado ao Fornecedor!', ['&Ok']);
          Result := False;
        End
        Else
          Result := PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text,True);
      End;

    End
    Else If (Sender = edtVeiobo) Or (Sender = edtVeioNF) Or
            (Sender = edtCheque) Or (Sender = edtPrevis) Or
            (Sender = edtDeposi) Or (Sender = edtPagAnt) Then
    Begin
      Result := fValidaChqBolDep(Sender);
      Exit;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCtaDigDadosDDA.fValidaChqBolDep(Sender: TWinControl): Boolean;
begin
  Result := True;

  If (Not fEmptyStr(TEditFocus(Sender).Text)) And (Pos(TEditFocus(Sender).Text, 'SN') <= 0) Then
  Begin
    Result := False;
    fMensagem('','O campo deve ser informado com (S)im ou (N)ão!', ['&Ok']);
  End
  Else If TEditFocus(Sender).Text = 'S' Then
  Begin
    If (Sender = edtCheque) Then
    Begin
      If ((edtVeiobo.Text = 'S') Or (fEmptyStr(edtVeiobo.Text))) Or
      ((edtDeposi.Text = 'S') Or (fEmptyStr(edtDeposi.Text))) Then
      Begin
        Result := False;
        fMensagem('','Para informar Cheque como (S)im, os campos Depósito e Veio Boleto devem estar iguais à (N)ão!', ['&Ok']);
        pSetFocus(Sender);
        PostMessage(Handle, WM_KEYDOWN, VK_Tab, 0);
      End;
    End;

    If (Sender = edtVeiobo) Then
    Begin
      If ((edtCheque.Text = 'S') Or (fEmptyStr(edtCheque.Text))) Or
      ((edtDeposi.Text = 'S') Or (fEmptyStr(edtDeposi.Text))) Then
      Begin
        Result := False;
        fMensagem('','Para informar Veio Boleto como (S)im, os campos Depósito e Cheque devem estar iguais à (N)ão!', ['&Ok']);
        pSetFocus(Sender);
        PostMessage(Handle, WM_KEYDOWN, VK_Tab, 0);
      End;
    End;

    If (Sender = edtDeposi) Then
    Begin
      If ((edtCheque.Text = 'S') Or (fEmptyStr(edtCheque.Text))) Or
      ((edtVeiobo.Text = 'S') Or (fEmptyStr(edtVeiobo.Text))) Then
      Begin
        Result := False;
        fMensagem('','Para informar deposito como (S)im, os campos veio boleto e cheque devem estar iguais à (N)ão!', ['&Ok']);
        pSetFocus(Sender);
        PostMessage(Handle, WM_KEYDOWN, VK_Tab, 0);
      End;
    End;
  End
  Else
  Begin
   If (Sender = edtPrevis) Then
    Begin
      If (blnGravaApenasPrevisao) And (edtPrevis.Text = 'N') Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO','Essa conta deve possuir o campo Previsão igual a (S)im!', ['&Ok']);
      End;
    End
    Else
    If (Sender = edtPagAnt) Then
    Begin
      If (fEmptyStr(edtPagAnt.Text)) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO','O campo Pagamento Antecipado deve ser informado com (S)im ou (N)ão!', ['&Ok']);
      End;
    End;
  End;
end;

procedure TfrmCtaDigDadosDDA.pCarregaCentroCusto(strCtaBai: String;
  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai, fCfgSis('USACTF', varBoolean), FstrCodFor);
  With qryCadCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmCtaDigDadosDDA.pCarregaEvento();
begin
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmCtaDigDadosDDA.pCarregaPortador(strCodPor: String;
  edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtDesPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

end.
