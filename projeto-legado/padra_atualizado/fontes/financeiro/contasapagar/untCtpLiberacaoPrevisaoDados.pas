unit untCtpLiberacaoPrevisaoDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma,
  untFrameCentroCustoEditFocus, Vcl.Mask, MaskEditFocus, Vcl.StdCtrls,
  EditFocus, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.Buttons, BitBtnLockedIncrem, untTypesSistema,
  untFramePlanoDeContasMaskEdit;

type
  TfrmCtpLiberacaoPrevisaoDados = class(TfrmPaiConfirma)
    pnlCabecalho: TPanel;
    Label24: TLabel;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    fraCentroCusto: TfraCentroCustoEditFocus;
    Label1: TLabel;
    edtHistorico: TEditFocus;
    lblMotivo: TLabel;
    edtMotivo: TEditFocus;
    fraPlanoDeContasCtp: TfraPlanoDeContasMskEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure btnSairClick(Sender: TObject);
    procedure fraPlanoDeContasCtpMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
  private
    procedure pCarregaCentroDeCustos;
    procedure pCarregaPlanoDeContas;
    procedure pCarregaPortador;
    { Private declarations }
  public
    blnReprova: Boolean;

    arrCentroDeCustos,
    arrPortador,
    arrPlanoDeContas : TConsultasArray;

    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    { Protected declarations }
  end;

implementation
Uses untFuncoesSimples, untConsultas, untPesqAux;
{$R *.dfm}

procedure TfrmCtpLiberacaoPrevisaoDados.btnSairClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfrmCtpLiberacaoPrevisaoDados.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, nil, Key, arrPortador, False) Then
    If fValidaCampos(edtCodPor) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCtpLiberacaoPrevisaoDados.FormCreate(Sender: TObject);
begin
  inherited;
  blnReprova := False;
end;

procedure TfrmCtpLiberacaoPrevisaoDados.FormShow(Sender: TObject);
begin
  inherited;
  lblMotivo.Visible := blnReprova;
  edtMotivo.Visible := blnReprova;

  pSetFocus(fraPlanoDeContasCtp.MskCodCta);
end;

procedure TfrmCtpLiberacaoPrevisaoDados.fraPlanoDeContasCtpMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCentroCusto(Self, fraPlanoDeContasCtp.MskCodCta, fraPlanoDeContasCtp.edtDesCta, Nil, Key, arrCentroDeCustos, False) Then
  Begin
    If fValidaCampos(fraPlanoDeContasCtp.MskCodCta, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCtpLiberacaoPrevisaoDados.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtMotivo) And (blnReprova) Then
    Begin

      If (fEmptyStr(edtMotivo.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O motivo deve ser preenchido!', ['&Ok']);
        Result := False;
      End;

    End
    {*******************************}
    {* VALIDA O CENTRO DE CUSTOS   *}
    {****************************AJ*}
    Else If (Sender = fraCentroCusto.edtCodEve) Then
    Begin
      fraCentroCusto.edtDesEve.Clear;
      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin

        If fraCentroCusto.edtCodEve.Text <> '00000' Then
           pCarregaCentroDeCustos;

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
      End;

    End

    {***************************}
    {* VALIDA PLANO DE CONTAS  *}
    {************************AJ*}
    Else If (Sender = fraPlanoDeContasCtp.MskCodCta) Then
    Begin
      fraPlanoDeContasCtp.edtDesCta.Clear;
      If Not fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContasCtp.MskCodCta.Text)) Then
      Begin

        If fraPlanoDeContasCtp.MskCodCta.Text <> '0' Then
           pCarregaPlanoDeContas;

        if fEmptyStr(fraPlanoDeContasCtp.edtDesCta.Text) Then
        Begin
           fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
           Result := False;
        End
        else if not PlanoDeContasAtivo(fraPlanoDeContasCtp.MskCodCta.Text) Then
          Result := False;
      End;
    End

    {**************************************}
    {* VALIDA O CÓDIGO DO PORTADOR        *}
    {***********************************JU*}
    Else If (Sender = edtCodPor) Then
    Begin
      edtDesPor.Clear;
      If Not fEmptyStr(edtCodPor.Text) Then
      Begin

        If edtCodPor.Text <> '00000' Then
           pCarregaPortador;

       if fEmptyStr(EdtDesPor.Text) Then
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
        Else
        Begin

          If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Você não permissão para utilizar este portador!', ['&O k']);
              Result := False;
            End;
          End;

        End;

      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCtpLiberacaoPrevisaoDados.pCarregaCentroDeCustos;
begin
  fraCentroCusto.edtDesEve.Clear;
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve);
end;

procedure TfrmCtpLiberacaoPrevisaoDados.pCarregaPlanoDeContas;
begin
  fraPlanoDeContasCtp.edtDesCta.Clear;
  If Not fEmptyStr(fraPlanoDeContasCtp.MskCodCta.Text) Then
    fraPlanoDeContasCtp.edtDesCta.Text := fCampoTabela('CTA_DESCTA', 'CADCTA', ['CTA_CODCTA'], [fRetSomenteNumeros(fraPlanoDeContasCtp.MskCodCta.Text)]);
end;

procedure TfrmCtpLiberacaoPrevisaoDados.pCarregaPortador;
begin
  edtDesPor.Clear;
  If Not fEmptyStr(edtCodPor.Text) Then
    edtDesPor.Text := fCampoTabela('POR_NOMPOR', 'CADPOR', ['POR_CODPOR'], [edtCodPor.Text]);
end;

end.
