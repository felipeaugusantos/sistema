unit untConfGeraOrcPed;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  QColorLabel, Uni, cxHint, BitBtnLockedIncrem, ComboBoxFocus, dxScreenTip,
  cxClasses, dxCustomHint, frxClass, frxExportCSVTestabilidade, Vcl.Mask,
  MaskEditFocus;

type
  TfrmConfGeraOrcPed = class(TfrmPai)
    pnlFundo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblEntFat: TLabel;
    ColorLabel3: TColorLabel;
    edtMens01: TEditFocus;
    edtMens02: TEditFocus;
    edtCodTra: TEditFocus;
    edtValFre: TEditFocus;
    edtNomTra: TEditFocus;
    gpbTipFat: TGroupBox;
    ColorLabel2: TColorLabel;
    edtTipFat: TEditFocus;
    edtEntFat: TEditFocus;
    pnlOpcoes: TPanel;
    rdgConfirma: TRadioGroup;
    rdgTipo: TRadioGroup;
    HintControler: TcxHintStyleController;
    btnConfirmaDados: TBitBtnLocked;
    cmbTipFre: TComboBoxFocus;
    pnlEmpCD: TPanel;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    lblPreVis: TLabel;
    mskPreVis: TMaskEditFocus;
    procedure rdgConfirmaClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rdgTipoClick(Sender: TObject);
    procedure edtCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodEmpresaEnter(Sender: TObject);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtEntFatChange(Sender: TObject);
    procedure pExibindoHintEmpresa;
  private
    { Private declarations }
    qryConTra: TUniQuery;

    procedure pCarregaCadTra;
    procedure pHabilitaPrevisaoEntrega;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strConfirma: String;
    strTipoDoc : String;

    strMen001 : String;
    strMen002 : String;
    strCodTra : String;
    fltValFre : Double;
    strTipFre : String;
    strTipPed : String;
    strEntFat : String;
    dtaPreVis : TDate;
    strEmpresas: String;

  end;

var
  frmConfGeraOrcPed: TfrmConfGeraOrcPed;

implementation

uses untFuncoesSimples, untPesqAux, untFuncoesConsulta, untConsultas,
  untTipoFreteAtc, untConstantes, untTypesSistema, untRelFatListVenRep;

{$R *.dfm}

procedure TfrmConfGeraOrcPed.rdgConfirmaClick(Sender: TObject);
begin
  inherited;
  If rdgConfirma.ItemIndex = 0 Then
    rdgTipo.Enabled := True
  Else
    rdgTipo.Enabled := False;
end;

procedure TfrmConfGeraOrcPed.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodEmpresa.Text) Then
  Begin
    pMensagemOk('O campo Empresa C.D. deve ser preenchido');
    exit;
  End;

  If fVerificaCampos Then
  Begin
    If rdgConfirma.ItemIndex = 0 Then
    Begin
      strConfirma := 'S';
      If rdgTipo.ItemIndex = 0 Then
        strTipoDoc := 'OR'
      Else
      Begin
        strTipoDoc := 'PD';
        strMen001 := edtMens01.Text;
        strMen002 := edtMens02.Text;
        strCodTra := edtCodTra.Text;
        fltValFre := fStrToFloat(edtValFre.Text);
        strTipFre := fTipoFrete(cmbTipFre.Text);
        strTipPed := edtTipFat.Text;
        strEntFat := edtEntFat.Text;

        If fEmptyDate(mskPreVis.Text) Then
          dtaPreVis := 0
        Else
          dtaPreVis := StrToDateDef(mskPreVis.Text, 0);

      End;
    End
    Else
      strConfirma := 'N';

    If Assigned(frmRelFatListVenRep) Then
      frmRelFatListVenRep.strEmpCD := edtCodEmpresa.Text;

    Close;
  End;
end;

procedure TfrmConfGeraOrcPed.FormShow(Sender: TObject);
begin
  inherited;
  strTipoDoc  := '';
  strConfirma := '';

  strMen001 := '';
  strMen002 := '';
  strCodTra := '';
  fltValFre := 0.0;
  strTipFre := '';
  strTipPed := '';
  strEntFat := '';
  dtaPreVis := 0;

  frmConfGeraOrcPed.Height := frmConfGeraOrcPed.Height - pnlFundo.Height;

  If (Not fCfgSis('ENTFAT', varBoolean)) Then
  Begin
    lblEntFat.Enabled := False;
    edtEntFat.Enabled := False;
  End;

  pHabilitaPrevisaoEntrega;

  strCodTra   := '';

  qryConTra := fCriarQuery('SELECT * FROM CADTRA WHERE FALSE', Self);

  gpbTipFat.Visible := (fCfgSis('TIPEXP') = '3') Or (fCfgSis('TPDCEX') = '1');
  edtTipFat.Text    := '';

  //pSetFocus(TRadioButton(rdgConfirma.Controls[0]));
  pSetFocus(btnConfirmaDados);
end;

procedure TfrmConfGeraOrcPed.pHabilitaPrevisaoEntrega;
Begin
  lblPreVis.Enabled := edtEntFat.Text = 'S';
  mskPreVis.Enabled := edtEntFat.Text = 'S';

  If mskPreVis.Enabled Then
  Begin

    If fEmptyDate(mskPreVis.Text) Then
      mskPreVis.Text := FormatDateTime('DD/MM/YYYY', VS_Date);

  End Else
    mskPreVis.Clear;
End;

procedure TfrmConfGeraOrcPed.rdgTipoClick(Sender: TObject);
begin
  inherited;
  If rdgTipo.ItemIndex = 1 Then
  Begin
    frmConfGeraOrcPed.Height := frmConfGeraOrcPed.Height + pnlFundo.Height;
    pnlFundo.Visible := True;
  End
  Else
  Begin
    frmConfGeraOrcPed.Height := frmConfGeraOrcPed.Height - pnlFundo.Height;
    pnlFundo.Visible := False;
  End;
end;

function TfrmConfGeraOrcPed.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodEmpresa) Then
    Begin

      If Not fEmptyStr(edtCodEmpresa.Text) Then
      Begin

        edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

        If fEmptyStr(edtDesEmpresa.Text) Then
        Begin
          pMensagemOk('Empresa não econtrada!');
          Result := False;
        End

      End
      Else edtDesEmpresa.Clear;

      If not fEmptyStr(strEmpresas) then
        If Pos(edtCodEmpresa.Text, strEmpresas) > 0 then
        Begin
          HintControler.HideHint;

          pMensagemOk('O campo Empresa C.D. não deve ser igual as empresas ja selecionadas anteriormente');
          edtCodEmpresa.Clear;
          edtDesEmpresa.Clear;

          pExibindoHintEmpresa;
          Result := False;
        End;
    End;

    If rdgTipo.ItemIndex = 1 Then //Pedido
    Begin
      If (Sender = edtCodTra) Then
      Begin
        If (fEmptyStr(edtCodTra.Text)) Then
            edtNomTra.Clear
        Else
        Begin

          pCarregaCadTra;
          If qryConTra.FieldByName('TRA_CODTRA').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa Transportadora não está cadastrada!', ['&O k']);
            Result := False;
          End;
        End;

      End

      Else If (Sender = edtValFre) Then
      Begin

        If (Not fEmptyStr(edtValFre.Text)) Then
        Begin

          If fStrToFloat(edtValFre.Text) < 0.0 Then
          Begin
            fMensagem('ATENÇÃO!', 'O Valor do frete deve ser maior ou igual a Zero!', ['&O k']);
            Result := False;
          End;

        End;

      End

      Else If (Sender = cmbTipFre) Then
      Begin

        If (Not fFreteValido(fTipoFrete(cmbTipFre.Text))) Or
           (Not fPermiteFreteProprio(fTipoFrete(cmbTipFre.Text))) Then
          Result := False;

      End

      Else If (Sender = edtTipFat) And (gpbTipFat.Enabled) And (gpbTipFat.Visible) Then
      Begin
        If (Pos(edtTipFat.Text, 'ABC') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O tipo de faturamento deve ser A,B ou C!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = edtEntFat) Then
        Result := (Pos(edtEntFat.Text, 'SN') > 0)

      Else If (Sender = mskPreVis) Then
      Begin

        If  mskPreVis.Enabled Then
        Begin

          If (fEmptyStr(fTiraCaracEspeciais(mskPreVis.Text))) Then
          Begin
            fMensagem('ATENÇÃO!','A previsão deve ser preenchida!',['&OK']);
            Result := False;
          End
          Else If (StrToDateDef(mskPreVis.Text,0) < VS_Date) Then
          Begin
            fMensagem('ATENÇÃO!','A previsão deve ser maior ou igual a data atual!',['&OK']);
            Result := False;
          End;

        End;

      End
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmConfGeraOrcPed.pCarregaCadTra;
begin
  pPesquisaCadTra(qryConTra, qryConTra, edtCodTra.Text);
  With qryConTra Do
  Begin
    edtNomTra.Text := FieldByName('TRA_NOMTRA').AsString;
  End;
end;

procedure TfrmConfGeraOrcPed.pExibindoHintEmpresa;
Begin
  HintControler.ShowHint(Self.Left + edtCodEmpresa.Left,
                         Self.Top + edtCodEmpresa.Left + 50,
     'Empresa C.D.',
     'Para gravar o pedido como "Entrega pelo C.D." informe a Empresa CD.' + #13#10 +
     'Após a gravação do pedido não será possivel alterar a Empresa C.D.' + #13#10 +
     'Caso seja necessária a alteração, cancele o pedido e gere um novo com a empresa correta.' + #13#10 +
     'É possível deixar a empresa em branco, nesse caso pedido não será gravado como "Entrega pelo C.D."');
End;

procedure TfrmConfGeraOrcPed.edtCodEmpresaEnter(Sender: TObject);
begin
  inherited;

  pExibindoHintEmpresa;
end;

procedure TfrmConfGeraOrcPed.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;

  HintControler.HideHint;
end;

procedure TfrmConfGeraOrcPed.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, True, True) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmConfGeraOrcPed.edtCodTraKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTransp: TConsultasArray;
begin
  inherited;
  {************************************}
  {* NOVA CONSULTA DE TRANSPORTADORAS *}
  {*********************************RV*}
  If fPesqTransportadora(conTraSimples, Self, edtCodTra, edtNomTra, Nil, Key, arrTransp) Then
  Begin
    If fValidaCampos(edtCodTra, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConfGeraOrcPed.edtEntFatChange(Sender: TObject);
begin
  inherited;
  pHabilitaPrevisaoEntrega;
end;

procedure TfrmConfGeraOrcPed.FormCreate(Sender: TObject);
  Var
    intTipFre: Integer;
begin
  inherited;
  cmbTipFre.Clear;
  For intTipFre In TiposFrete Do
    cmbTipFre.Items.Add(fDescricaoFrete(IntToStr(intTipFre)));

  strEmpresas := '';
end;

procedure TfrmConfGeraOrcPed.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Return) And (ActiveControl is TRadioButton) Then
    SelectNext(ActiveControl,true,true);

end;

end.
