unit untFraPessoasCte;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Vcl.ComCtrls, untTEditFocusExtendPesCte, untTypePesCte, StrUtils;

type
  TFraPessoasCte = class(TfrmPai)
    Panel1: TPanel;
    Panel2: TPanel;
    Label13: TLabel;
    Label7: TLabel;
    cmbTipoDocumentoAnexoCTE: TComboBox;
    cmbTomador: TComboBox;
    pgcPessoas: TPageControl;
    tbsRemetente: TTabSheet;
    pnlTopo: TPanel;
    grbRemetente: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edtRemetenteCNPJ: TEditFocus;
    edtRemetenteRazaoSocial: TEditFocus;
    edtRemetenteIE: TEditFocus;
    edtRemetenteUF: TEditFocus;
    edtRemetenteLogradouro: TEditFocus;
    edtRemetenteNumero: TEditFocus;
    edtRemetenteBairro: TEditFocus;
    edtRemetenteMunicipio: TEditFocus;
    edtRemetenteCodigoMunicipio: TEditFocus;
    edtRemetenteCEP: TEditFocus;
    edtRemetenteCodigoIBGE: TEditFocus;
    tbsEmitente: TTabSheet;
    Panel3: TPanel;
    grbEmitente: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    edtEmitenteCNPJ: TEditFocus;
    edtEmitenteRazaoSocial: TEditFocus;
    edtEmitenteIE: TEditFocus;
    edtEmitenteUF: TEditFocus;
    edtEmitenteLogradouro: TEditFocus;
    edtEmitenteNumero: TEditFocus;
    edtEmitenteBairro: TEditFocus;
    edtEmitenteMunicipio: TEditFocus;
    edtEmitenteCodigoMunicipio: TEditFocus;
    edtEmitenteCEP: TEditFocus;
    edtEmitenteCodigoIBGE: TEditFocus;
    tbsDestinatario: TTabSheet;
    Panel4: TPanel;
    grbDestinatario: TGroupBox;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    edtDestinatarioCNPJ: TEditFocus;
    edtDestinatarioRazaoSocial: TEditFocus;
    edtDestinatarioIE: TEditFocus;
    edtDestinatarioUF: TEditFocus;
    edtDestinatarioLogradouro: TEditFocus;
    edtDestinatarioNumero: TEditFocus;
    edtDestinatarioBairro: TEditFocus;
    edtDestinatarioMunicipio: TEditFocus;
    edtDestinatarioCodigoMunicipio: TEditFocus;
    edtDestinatarioCEP: TEditFocus;
    edtDestinatarioCodigoIBGE: TEditFocus;
    tbsExpedidor: TTabSheet;
    Panel5: TPanel;
    grbExpedidor: TGroupBox;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    edtExpedidorCNPJ: TEditFocus;
    edtExpedidorRazaoSocial: TEditFocus;
    edtExpedidorIE: TEditFocus;
    edtExpedidorUF: TEditFocus;
    edtExpedidorLogradouro: TEditFocus;
    edtExpedidorNumero: TEditFocus;
    edtExpedidorBairro: TEditFocus;
    edtExpedidorMunicipio: TEditFocus;
    edtExpedidorCodigoMunicipio: TEditFocus;
    edtExpedidorCEP: TEditFocus;
    edtExpedidorCodigoIBGE: TEditFocus;
    tbsRecebedor: TTabSheet;
    Panel6: TPanel;
    grbRecebedor: TGroupBox;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    edtRecebedorCNPJ: TEditFocus;
    edtRecebedorRazaoSocial: TEditFocus;
    edtRecebedorIE: TEditFocus;
    edtRecebedorUF: TEditFocus;
    edtRecebedorLogradouro: TEditFocus;
    edtRecebedorNumero: TEditFocus;
    edtRecebedorBairro: TEditFocus;
    edtRecebedorMunicipio: TEditFocus;
    edtRecebedorCodigoMunicipio: TEditFocus;
    edtRecebedorCEP: TEditFocus;
    edtRecebedorCodigoIBGE: TEditFocus;
    tbsTomador: TTabSheet;
    Panel7: TPanel;
    grbTomador: TGroupBox;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    edtTomadorCNPJ: TEditFocus;
    edtTomadorRazaoSocial: TEditFocus;
    edtTomadorIE: TEditFocus;
    edtTomadorUF: TEditFocus;
    edtTomadorLogradouro: TEditFocus;
    edtTomadorNumero: TEditFocus;
    edtTomadorBairro: TEditFocus;
    edtTomadorMunicipio: TEditFocus;
    edtTomadorCodigoMunicipio: TEditFocus;
    edtTomadorCEP: TEditFocus;
    edtTomadorCodigoIBGE: TEditFocus;
    procedure cmbTipoDocumentoAnexoCTEChange(Sender: TObject);
    procedure cmbTomadorChange(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtRemetenteCNPJKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtDestinatarioCNPJKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtExpedidorCNPJKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtRecebedorCNPJKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtTomadorCNPJKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtEmitenteCNPJKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtRemetenteCNPJExit(Sender: TObject);
    procedure edtDestinatarioCNPJExit(Sender: TObject);
    procedure edtExpedidorCNPJExit(Sender: TObject);
    procedure edtRecebedorCNPJExit(Sender: TObject);
  private
    { Private declarations }
    function fGetTipoDocumento: TTipoDocumentoAnexoCTE;
    
  public
    { Public declarations }
    FormPai: TForm;
    Container: TPanel;
    ControleQueReceberaOFocoAoTerminar: TWinControl;
    PageControlQueReceberaOFocoAoTerminar:TTabSheet;
    procedure pInicializaComponentes(blnEntrada: Boolean);
    procedure pSalva(incCadFis: String);
    function fValida: Boolean;
  end;




implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfraPessoasCTE }

procedure TfraPessoasCTE.btnSairClick(Sender: TObject);
begin
  Exit;
end;

procedure TfraPessoasCTE.cmbTipoDocumentoAnexoCTEChange(Sender: TObject);
var i: integer;
begin
  pInicializaComponentes(False);

  edtExpedidorCNPJ.pLimpaGrupo;
  edtRecebedorCNPJ.pLimpaGrupo;
  If cmbTomador.ItemIndex in [2, 3] Then
    edtTomadorCNPJ.pLimpaGrupo;

  For i := 0 To grbRemetente.ControlCount -1 do
  begin
     If grbRemetente.Controls[i] is TEditFocus then
       TEditFocus(grbRemetente.Controls[i]).Enabled := TEditFocus(grbRemetente.Controls[i]).Principal;
  End;
  edtRemetenteCNPJ.TipoDocumento := fGetTipoDocumento;
  edtEmitenteCNPJ.TipoDocumento := edtRemetenteCNPJ.TipoDocumento;
  edtDestinatarioCNPJ.TipoDocumento := edtRemetenteCNPJ.TipoDocumento;
  edtExpedidorCNPJ.TipoDocumento := edtRemetenteCNPJ.TipoDocumento;
  edtRecebedorCNPJ.TipoDocumento := edtRemetenteCNPJ.TipoDocumento;

  tbsRecebedor.TabVisible := cmbTipoDocumentoAnexoCTE.Text = arrTiposNotas[2];
  tbsExpedidor.TabVisible := cmbTipoDocumentoAnexoCTE.Text = arrTiposNotas[2];
end;

procedure TfraPessoasCTE.cmbTomadorChange(Sender: TObject);
begin
  edtTomadorCNPJ.pLimpaGrupo;
  If cmbTomador.ItemIndex in [2, 3] Then
  Begin
    If cmbTipoDocumentoAnexoCTE.Text <> arrTiposNotas[2] Then
    Begin
      pMensagemOk('Quando Tomador é ' + cmbTomador.Text + ' o tipo de documento deve ser ' + arrTiposNotas[2]);
      cmbTomador.ItemIndex := 0;
    End;
  End
  Else
  If (cmbTomador.ItemIndex = 1) And (cmbTipoDocumentoAnexoCTE.Text <> arrTiposNotas[3]) Then
  Begin
    pMensagemOk('Quando Tomador é ' + cmbTomador.Text + ' o tipo de documento deve ser ' + arrTiposNotas[3]);
    cmbTomador.ItemIndex := 0;
  End;

  grbTomador.Enabled := cmbTomador.ItemIndex = 5;
  If Not grbTomador.Enabled Then
  Begin
    case cmbTomador.ItemIndex - 1 of
      0: edtTomadorCNPJ.pSetPessoa(edtRemetenteCNPJ.fRetPessoa(0, -1));
      1: edtTomadorCNPJ.pSetPessoa(edtExpedidorCNPJ.fRetPessoa(1, -1));
      2: edtTomadorCNPJ.pSetPessoa(edtRecebedorCNPJ.fRetPessoa(2, -1));
      3: edtTomadorCNPJ.pSetPessoa(edtDestinatarioCNPJ.fRetPessoa(3, -1));
    End;
  End;
  If cmbTomador.Text <> '' Then
  begin
    edtRemetenteCNPJ.Tomador := cmbTomador.ItemIndex - 1;
    edtEmitenteCNPJ.Tomador := cmbTomador.ItemIndex - 1;
    edtExpedidorCNPJ.Tomador := cmbTomador.ItemIndex - 1;
    edtRecebedorCNPJ.Tomador := cmbTomador.ItemIndex - 1;
    edtDestinatarioCNPJ.Tomador := cmbTomador.ItemIndex - 1;
  End;

end;

procedure TFraPessoasCte.edtDestinatarioCNPJExit(Sender: TObject);
begin
  inherited;
  If edtDestinatarioCNPJ.Text = '' Then
    If cmbTomador.Text =  'Destinatário' then
      edtTomadorCNPJ.pLimpaGrupo;

end;

procedure TFraPessoasCte.edtDestinatarioCNPJKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If tbsExpedidor.TabVisible Then
  Begin
    pgcPessoas.ActivePage := tbsExpedidor;
    pSetFocus(edtExpedidorCNPJ);
  End
  Else If cmbTomador.ItemIndex = 5 Then
  begin
    pgcPessoas.ActivePage := tbsTomador;
    pSetFocus(edtTomadorCNPJ);
  End
  Else If Assigned(ControleQueReceberaOFocoAoTerminar) Then
  Begin
    If Assigned(PageControlQueReceberaOFocoAoTerminar) Then
      PageControlQueReceberaOFocoAoTerminar.PageControl.ActivePage := PageControlQueReceberaOFocoAoTerminar;
    pSetFocus(ControleQueReceberaOFocoAoTerminar);
  End
  Else
    SelectNext(FormPai.ActiveControl, True, True);
end;

procedure TFraPessoasCte.edtEmitenteCNPJKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  pgcPessoas.ActivePage := tbsDestinatario;
  pSetFocus(edtDestinatarioCNPJ);
end;

procedure TFraPessoasCte.edtExpedidorCNPJExit(Sender: TObject);
begin
  inherited;
  If edtExpedidorCNPJ.Text = '' Then
    If cmbTomador.Text =  'Expedidor' then
      edtTomadorCNPJ.pLimpaGrupo;

end;

procedure TFraPessoasCte.edtExpedidorCNPJKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  pgcPessoas.ActivePage := tbsRecebedor;
  pSetFocus(edtRecebedorCNPJ);

end;

procedure TFraPessoasCte.edtRecebedorCNPJExit(Sender: TObject);
begin
  inherited;
  If edtRecebedorCNPJ.Text = '' Then
    If cmbTomador.Text =  'Expedidor' then
      edtTomadorCNPJ.pLimpaGrupo;
end;

procedure TFraPessoasCte.edtRecebedorCNPJKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If cmbTomador.ItemIndex = 5 Then
  begin
    pgcPessoas.ActivePage := tbsTomador;
    pSetFocus(edtTomadorCNPJ);
  End
  Else If Assigned(ControleQueReceberaOFocoAoTerminar) Then
  Begin
    If Assigned(PageControlQueReceberaOFocoAoTerminar) Then
      PageControlQueReceberaOFocoAoTerminar.PageControl.ActivePage := PageControlQueReceberaOFocoAoTerminar;
    pSetFocus(ControleQueReceberaOFocoAoTerminar);
  End
  Else
    SelectNext(FormPai.ActiveControl, True, True);
end;

procedure TFraPessoasCte.edtRemetenteCNPJExit(Sender: TObject);
begin
  inherited;
  If edtRemetenteCNPJ.Text = '' Then
    If cmbTomador.Text =  'Remetente' then
      edtTomadorCNPJ.pLimpaGrupo;
end;

procedure TFraPessoasCte.edtRemetenteCNPJKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  pgcPessoas.ActivePage := tbsEmitente;
  pSetFocus(edtEmitenteCNPJ);
end;

procedure TFraPessoasCte.edtTomadorCNPJKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Assigned(ControleQueReceberaOFocoAoTerminar) Then
  Begin
    If Assigned(PageControlQueReceberaOFocoAoTerminar) Then
      PageControlQueReceberaOFocoAoTerminar.PageControl.ActivePage := PageControlQueReceberaOFocoAoTerminar;
    pSetFocus(ControleQueReceberaOFocoAoTerminar);
  End
  Else
    SelectNext(FormPai.ActiveControl, True, True);

end;

function TfraPessoasCTE.fGetTipoDocumento: TTipoDocumentoAnexoCTE;
begin
  Result := tdNotaCompra;
  case AnsiIndexStr(cmbTipoDocumentoAnexoCTE.Text, arrTiposNotas) of
    0 : Result := tdNotaCompra;
    1 : Result := tdNotaVenda;
    2 : Result := tdNotaDevolucaoVenda;
    3 : Result := tdNotaDevolucaoCompra;
  end;
end;

procedure TFraPessoasCte.FormShow(Sender: TObject);
begin
  inherited;
  tbsRecebedor.TabVisible := False;
  tbsExpedidor.TabVisible := False;
  cmbTomador.ItemIndex := 5;
  cmbTomadorChange(cmbTomador);

end;

function TFraPessoasCte.fValida: Boolean;
var Sender: TWinControl;
    strErro: string;
begin
  Result := True;
  Sender := nil;
  strErro:= '';
  If cmbTipoDocumentoAnexoCTE.Text = '' Then
  Begin
    pSetFocus(cmbTipoDocumentoAnexoCTE);
    pMensagemOk('Tipo do Documento deve ser preenchido!');
    Exit(False);
  End;

  If cmbTomador.Text = '' Then
  Begin
    pSetFocus(cmbTomador);
    pMensagemOk('Tomador deve ser preenchido!');
    Exit(False);
  End;

  

  Try
    Sender := edtRemetenteCNPJ;
    edtRemetenteCNPJ.pPreenchido;
    pgcPessoas.ActivePage := tbsRemetente;

    Sender := edtEmitenteCNPJ;
    edtEmitenteCNPJ.pPreenchido;
    pgcPessoas.ActivePage := tbsEmitente;

    Sender := edtDestinatarioCNPJ;
    edtDestinatarioCNPJ.pPreenchido;
    pgcPessoas.ActivePage := tbsDestinatario;

    Sender := edtTomadorCNPJ;
    edtTomadorCNPJ.pPreenchido;
    pgcPessoas.ActivePage := tbsTomador;
  Except
    on e: Exception do
    begin
      Result := False;
      pMensagemOk(e.message);
      pSetFocus(Sender);
    End;
  End;
end;


procedure TfraPessoasCTE.pInicializaComponentes(blnEntrada: Boolean);
begin
  pnlBotoes.Visible := False;
  pnlStatus.Visible := False;
  If cmbTipoDocumentoAnexoCTE.Text = '' Then
  Begin
    If blnEntrada then
    begin
      cmbTipoDocumentoAnexoCTE.Items.Add(arrTiposNotas[0]);
      cmbTipoDocumentoAnexoCTE.Items.Add(arrTiposNotas[2]);
    End
    Else
    Begin
      cmbTipoDocumentoAnexoCTE.Items.Add(arrTiposNotas[0]);
      cmbTipoDocumentoAnexoCTE.Items.Add(arrTiposNotas[1]);
      cmbTipoDocumentoAnexoCTE.Items.Add(arrTiposNotas[2]);
      cmbTipoDocumentoAnexoCTE.Items.Add(arrTiposNotas[3]);
    End;
    cmbTipoDocumentoAnexoCTE.ItemIndex := 0;
  End;
  pgcPessoas.ActivePage := tbsRemetente;
  {Estas desfinicoes faz com que o carrege os dados nos componentes conforme o edit cnpj/cpf  -> untTEditFocusExtendPesCte}
  edtRemetenteCNPJ.Formpai := FormPai;

  edtRemetenteCNPJ.TipoPessoa := tpessRemetente;
  edtRemetenteCNPJ.TipoDocumento := fGetTipoDocumento;
  edtRemetenteCNPJ.Agrupador := grbRemetente;
  edtRemetenteCNPJ.AgrupadorTomador := grbTomador;
  edtRemetenteCNPJ.TipoCampoIdentificado := tciCNPJ;
  edtRemetenteCNPJ.Principal := True;
  edtRemetenteRazaoSocial.TipoCampoIdentificado := tcirazaoSocial;
  edtRemetenteIE.TipoCampoIdentificado := tciIE;
  edtRemetenteUF.TipoCampoIdentificado := tciUF;
  edtRemetenteLogradouro.TipoCampoIdentificado := tciLogradouro;
  edtRemetenteNumero.TipoCampoIdentificado := tciNumero;
  edtRemetenteBairro.TipoCampoIdentificado := tciBairro;
  edtRemetenteMunicipio.TipoCampoIdentificado := tciMunicipio;
  edtRemetenteCodigoMunicipio.TipoCampoIdentificado := tciCodigoMunicipio;
  edtRemetenteCEP.TipoCampoIdentificado := tciCEP;
  edtRemetenteCodigoIBGE.TipoCampoIdentificado := tciCodigoIBGE;

  edtEmitenteCNPJ.Formpai := FormPai;
  edtEmitenteCNPJ.TipoPessoa := tpessEmitente;
  edtEmitenteCNPJ.TipoDocumento := fGetTipoDocumento;
  edtEmitenteCNPJ.Agrupador := grbEmitente;
  edtEmitenteCNPJ.AgrupadorTomador := grbTomador;
  edtEmitenteCNPJ.TipoCampoIdentificado := tciCNPJ;
  edtEmitenteCNPJ.Principal := True;
  edtEmitenteRazaoSocial.TipoCampoIdentificado := tcirazaoSocial;
  edtEmitenteIE.TipoCampoIdentificado := tciIE;
  edtEmitenteUF.TipoCampoIdentificado := tciUF;
  edtEmitenteLogradouro.TipoCampoIdentificado := tciLogradouro;
  edtEmitenteNumero.TipoCampoIdentificado := tciNumero;
  edtEmitenteBairro.TipoCampoIdentificado := tciBairro;
  edtEmitenteMunicipio.TipoCampoIdentificado := tciMunicipio;
  edtEmitenteCodigoMunicipio.TipoCampoIdentificado := tciCodigoMunicipio;
  edtEmitenteCEP.TipoCampoIdentificado := tciCEP;
  edtEmitenteCodigoIBGE.TipoCampoIdentificado := tciCodigoIBGE;


  edtExpedidorCNPJ.Formpai := FormPai;
  edtExpedidorCNPJ.TipoPessoa := tpessExpedidor;
  edtExpedidorCNPJ.TipoDocumento := fGetTipoDocumento;
  edtExpedidorCNPJ.Agrupador := grbExpedidor;
  edtExpedidorCNPJ.AgrupadorTomador := grbTomador;
  edtExpedidorCNPJ.TipoCampoIdentificado := tciCNPJ;
  edtExpedidorCNPJ.Principal := True;
  edtExpedidorRazaoSocial.TipoCampoIdentificado := tcirazaoSocial;
  edtExpedidorIE.TipoCampoIdentificado := tciIE;
  edtExpedidorUF.TipoCampoIdentificado := tciUF;
  edtExpedidorLogradouro.TipoCampoIdentificado := tciLogradouro;
  edtExpedidorNumero.TipoCampoIdentificado := tciNumero;
  edtExpedidorBairro.TipoCampoIdentificado := tciBairro;
  edtExpedidorMunicipio.TipoCampoIdentificado := tciMunicipio;
  edtExpedidorCodigoMunicipio.TipoCampoIdentificado := tciCodigoMunicipio;
  edtExpedidorCEP.TipoCampoIdentificado := tciCEP;
  edtExpedidorCodigoIBGE.TipoCampoIdentificado := tciCodigoIBGE;

  edtRecebedorCNPJ.Formpai := FormPai;
  edtRecebedorCNPJ.TipoPessoa := tpessRecebedor;
  edtRecebedorCNPJ.TipoDocumento := fGetTipoDocumento;
  edtRecebedorCNPJ.Agrupador := grbRecebedor;
  edtRecebedorCNPJ.AgrupadorTomador := grbTomador;
  edtRecebedorCNPJ.TipoCampoIdentificado := tciCNPJ;
  edtRecebedorCNPJ.Principal := True;
  edtRecebedorRazaoSocial.TipoCampoIdentificado := tcirazaoSocial;
  edtRecebedorIE.TipoCampoIdentificado := tciIE;
  edtRecebedorUF.TipoCampoIdentificado := tciUF;
  edtRecebedorLogradouro.TipoCampoIdentificado := tciLogradouro;
  edtRecebedorNumero.TipoCampoIdentificado := tciNumero;
  edtRecebedorBairro.TipoCampoIdentificado := tciBairro;
  edtRecebedorMunicipio.TipoCampoIdentificado := tciMunicipio;
  edtRecebedorCodigoMunicipio.TipoCampoIdentificado := tciCodigoMunicipio;
  edtRecebedorCEP.TipoCampoIdentificado := tciCEP;
  edtRecebedorCodigoIBGE.TipoCampoIdentificado := tciCodigoIBGE;

  edtDestinatarioCNPJ.Formpai := FormPai;
  edtDestinatarioCNPJ.TipoPessoa := tpessDestinatario;
  edtDestinatarioCNPJ.TipoDocumento := fGetTipoDocumento;
  edtDestinatarioCNPJ.Agrupador := grbDestinatario;
  edtDestinatarioCNPJ.AgrupadorTomador := grbTomador;
  edtDestinatarioCNPJ.TipoCampoIdentificado := tciCNPJ;
  edtDestinatarioCNPJ.Principal := True;
  edtDestinatarioRazaoSocial.TipoCampoIdentificado := tcirazaoSocial;
  edtDestinatarioIE.TipoCampoIdentificado := tciIE;
  edtDestinatarioUF.TipoCampoIdentificado := tciUF;
  edtDestinatarioLogradouro.TipoCampoIdentificado := tciLogradouro;
  edtDestinatarioNumero.TipoCampoIdentificado := tciNumero;
  edtDestinatarioBairro.TipoCampoIdentificado := tciBairro;
  edtDestinatarioMunicipio.TipoCampoIdentificado := tciMunicipio;
  edtDestinatarioCodigoMunicipio.TipoCampoIdentificado := tciCodigoMunicipio;
  edtDestinatarioCEP.TipoCampoIdentificado := tciCEP;
  edtDestinatarioCodigoIBGE.TipoCampoIdentificado := tciCodigoIBGE;

  edtTomadorCNPJ.Formpai := FormPai;
  edtTomadorCNPJ.TipoPessoa := tpessTomador;
  edtTomadorCNPJ.TipoDocumento := fGetTipoDocumento;
  edtTomadorCNPJ.Agrupador := grbTomador;
  edtTomadorCNPJ.TipoCampoIdentificado := tciCNPJ;
  edtTomadorCNPJ.Principal := True;
  edtTomadorRazaoSocial.TipoCampoIdentificado := tcirazaoSocial;
  edtTomadorIE.TipoCampoIdentificado := tciIE;
  edtTomadorUF.TipoCampoIdentificado := tciUF;
  edtTomadorLogradouro.TipoCampoIdentificado := tciLogradouro;
  edtTomadorNumero.TipoCampoIdentificado := tciNumero;
  edtTomadorBairro.TipoCampoIdentificado := tciBairro;
  edtTomadorMunicipio.TipoCampoIdentificado := tciMunicipio;
  edtTomadorCodigoMunicipio.TipoCampoIdentificado := tciCodigoMunicipio;
  edtTomadorCEP.TipoCampoIdentificado := tciCEP;
  edtTomadorCodigoIBGE.TipoCampoIdentificado := tciCodigoIBGE;
  edtRemetenteCNPJ.PessoaEditKeyDown := edtRemetenteCNPJKeyDown;

  edtDestinatarioCNPJ.PessoaEditKeyDown := edtDestinatarioCNPJKeyDown;
  edtExpedidorCNPJ.PessoaEditKeyDown := edtExpedidorCNPJKeyDown;
  edtRecebedorCNPJ.PessoaEditKeyDown := edtRecebedorCNPJKeyDown;
  edtTomadorCNPJ.PessoaEditKeyDown := edtTomadorCNPJKeyDown;
  edtEmitenteCNPJ.PessoaEditKeyDown := edtEmitenteCNPJKeyDown;

  Dock(Container, Container.BoundsRect);
  Show;
  pgcPessoas.ActivePage := tbsRemetente;

end;

procedure TFraPessoasCte.pSalva(incCadFis: String);
begin
  If incCadFis = '' Then
    Exit;
  edtRemetenteCNPJ.pSalva(incCadFis, cmbTomador.ItemIndex -1);
  edtEmitenteCNPJ.pSalva(incCadFis, cmbTomador.ItemIndex -1);
  edtDestinatarioCNPJ.pSalva(incCadFis, cmbTomador.ItemIndex -1);
  edtExpedidorCNPJ.pSalva(incCadFis, cmbTomador.ItemIndex -1);
  edtRecebedorCNPJ.pSalva(incCadFis, cmbTomador.ItemIndex -1);
  edtTomadorCNPJ.pSalva(incCadFis, cmbTomador.ItemIndex -1);

  edtRemetenteCNPJ.pLimpaGrupo;
  edtEmitenteCNPJ.pLimpaGrupo;
  edtDestinatarioCNPJ.pLimpaGrupo;
  edtExpedidorCNPJ.pLimpaGrupo;
  edtRecebedorCNPJ.pLimpaGrupo;
  edtTomadorCNPJ.pLimpaGrupo;
end;

end.



