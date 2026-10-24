unit untFatorParaFaturamentoFrame;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, Windows,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, strUtils,
  ExtCtrls, EditFocus, QColorLabel, untFuncFat, Uni, AppEvnts, Mask,
  MaskEditFocus, BitBtnLockedIncrem, DBCtrls, DBLookupComboBoxFocus,
  cxHint, TypInfo, DBEditFocus, ComboBoxFocus, dxScreenTip, cxClasses,
  dxCustomHint, frxClass, frxExportCSVTestabilidade, untFuncFatTypes, untLiberacao,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxGroupBox;

type
  TfraFatorParaFaturamentoFrame = class(TFrame)
    pnlFundo: TPanel;
    pnlFatorParaFaturamento: TGroupBox;
    lblFatCal: TLabel;
    lblTipoFator: TLabel;
    clbTipoFator: TColorLabel;
    lblCodPor: TLabel;
    edtFatCal: TEditFocus;
    edtTipoFator: TEditFocus;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtFatCalChange(Sender: TObject);
    procedure edtFatCalEnter(Sender: TObject);
    procedure edtTipoFatorEnter(Sender: TObject);
  private
    { Private declarations }
    qryConPor: TUniQuery;
    fltFatValAnt : Double;
    strFatTipAnt : String;
    strTipFatAnt : String;

    procedure pCarregaPortador;
    procedure pCarregaFatorNFEspecialCliente;
  public
    { Public declarations }
    objVenda: TFatVenda;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;

    procedure OnFormShow;
    procedure OnFormCreate;
    procedure OnFormDestroy;

    function fConfirmaDados: Boolean;

    procedure pHabilitarFatorParaFaturamento(strTipoFaturamento: String);
  end;

var
  fraFatorParaFaturamentoFrame: TfraFatorParaFaturamentoFrame;

implementation

uses untPesqAux, Data.DB, untTypesSistema, Math, untConsultas, untDigPedCmp,
     untTipoFreteAtc, untfuncoesSimples, untConstantes, untValidacoesRotasRegiao,
     untFatMostraItensFechamento, untCadClientes, untFuncoes, untPesoItem,
     untAdiantamentoClienteGenerico, untProjetos, untMsgLiberacao;

{$R *.dfm}

procedure TfraFatorParaFaturamentoFrame.pCarregaFatorNFEspecialCliente;
  Var
    qryCliente: TUniQuery;
begin
  If (Not Assigned(objVenda)) Then
    Exit;

  qryCliente := fCriaQuery(nil);

  With qryCliente, SQL Do
  Begin
    Add('SELECT CLI_TFTNES, CLI_FTNFES FROM CADCLI WHERE CLI_CODCLI = :CODCLI');
    ParamByName('CODCLI').AsString := objVenda.strCodCli;
    Open;

    If Not IsEmpty Then
    Begin
      edtFatCal.Text    := FloatToStrF(FieldByName('CLI_FTNFES').AsFloat, ffFixed, 12, 4);
      edtTipoFator.Text := FieldByName('CLI_TFTNES').AsString;
    End;
  End;

  If fEmptyStr(edtTipoFator.Text) Then
    edtTipoFator.Text := 'V';

  FreeAndNil(qryCliente);
end;

procedure TfraFatorParaFaturamentoFrame.pCarregaPortador;
begin
  pPesquisaCadPor(Nil, qryConPor, edtCodPor.Text);
  With qryConPor Do
  Begin
    edtNomPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfraFatorParaFaturamentoFrame.pHabilitarFatorParaFaturamento(
  strTipoFaturamento: String);
begin
  strTipFatAnt := strTipoFaturamento;
  If (strTipoFaturamento <> 'B') And (strTipoFaturamento <> '') Then
  Begin
    pnlFatorParaFaturamento.Enabled := False;
    lblFatCal.Enabled    := False;
    edtFatCal.Enabled    := False;
    lblTipoFator.Enabled := False;
    edtTipoFator.Enabled := False;
    edtFatCal.Text       := '0,0000';
  End
  Else
  Begin
    pnlFatorParaFaturamento.Enabled := True;
    lblFatCal.Enabled    := True;
    edtFatCal.Enabled    := True;
    lblTipoFator.Enabled := True;
    edtTipoFator.Enabled := True;

    If (fStrToFloat(edtFatCal.Text) = 0) Then
      edtFatCal.Text     := FormatFloat('#,##0.0000', fCfgSis('FATFAT',varDouble));

    If (fStrToFloat(edtFatCal.Text) = 0) And (strTipoFaturamento = 'B') Then
      pCarregaFatorNFEspecialCliente;
  End;
end;

function TfraFatorParaFaturamentoFrame.fConfirmaDados: Boolean;
begin
  inherited;
  Result := fValidaCampos(edtFatCal, True) And
            fValidaCampos(edtTipoFator, True) And
            fValidaCampos(edtCodPor, True);

  If Not Result Then
    Exit;

  objVenda.strCodPorNfMeiaNota := edtCodPor.Text;

  If fCfgSis('SOLFNE', varBoolean) Then
  Begin
    objVenda.fltFatNot    := fStrToFloat(edtFatCal.Text);
    objVenda.strTipFatNEs := edtTipoFator.Text;
  End;
end;

procedure TfraFatorParaFaturamentoFrame.OnFormCreate;
begin
  inherited;
  qryConPor    := fCriaQuery(Self);
  fltFatValAnt := 0.00;
  strFatTipAnt := '';
end;

procedure TfraFatorParaFaturamentoFrame.OnFormDestroy;
begin
  inherited;
end;

function TfraFatorParaFaturamentoFrame.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;

Var
  objLiberacao : TLiberacao;

begin
  Result := True;

  If (Sender = edtFatCal) And Self.Visible And
     (pnlFatorParaFaturamento.Enabled) Then
  Begin
    If Not fValidaEscala(edtFatCal.Text, 0, 0.9999) Then
    Begin
      fMensagem('','O Fator para Nota Especial deve estar enter 0 e 0.9999, verifique!', ['&Ok']);
      Result := False;
    End;

    {TRATAR A LIBERAÇÃO PARA A DIMINUIÇÃO DO FATOR - KM}
    If (Result) And (fCfgSis('FATNSP',varBoolean)) Then
    Begin
      If (fltFatValAnt > fStrToFloat(edtFatCal.Text)) And Assigned(objVenda) And (Not fEmptyStr(edtFatCal.Text)) Then
      Try
        objLiberacao := TLiberacao.Create;

        objLiberacao.objMsgLibera.pAddTexto('Permissão para diminuir o fator de nota especial na digitação do pedido de venda');
        objLiberacao.objMsgLibera.pAddSeparador(100);
        objLiberacao.objMsgLibera.pAddTextoCaption('Fator Digitado', FloatToStrF(StrToFloat(edtFatCal.Text), ffNumber, 12, 3));
        objLiberacao.objMsgLibera.pAddTextoCaption('Fator Anterior', FloatToStrF(fltFatValAnt, ffNumber, 12, 3));
        objLiberacao.strDirAce  := 'DIMFNE';
        objLiberacao.strSenLib  := fCfgSis('SENLBD');
        objLiberacao.strMsgSen  := 'Liberacao de Diminuição do Fator de Nota Especial';
        objLiberacao.blnMosMen  := True;
        objLiberacao.strCodOpe  := strLoginUsuarioLogado;
        objLiberacao.strCodDig  := strLoginUsuarioLogado;
        objLiberacao.strCliente := objVenda.strCodCli + '-' + objVenda.strCliNom;
        objLiberacao.strCpfCnpj := objVenda.strCliCgc;
        objLiberacao.blnUsarSenhaFixa         := False;
        objLiberacao.blnSempreVariavelUsuario := True;
        objLiberacao.tipCliFor := IIF(objVenda.strOpcDoc = 'OF', cfFornecedor, cfCliente);
        Result := objVenda.fFatMensagemLiberacao(objLiberacao);

        If (not Result) then
          edtFatCal.Text := FloatToStrF(fltFatValAnt, ffNumber, 12, 3)
        Else
          fltFatValAnt   := fStrToFloat(edtFatCal.Text);
      Finally
        FreeAndNil(objLiberacao);
      End;
    End;
  End

  Else If (Sender = edtTipoFator) And Self.Visible And
          (pnlFatorParaFaturamento.Enabled) Then
  Begin
    If (Pos(edtTipoFator.Text, 'V_Q_') <= 0) Then
    Begin
      fMensagem('','O Tipo de Fator para Nota Especial deve ser (V)alor ou (Q)uantidade, verifique!', ['&Ok']);
      Result := False;
    End;

    If (Result) And (fCfgSis('TFANSP',varBoolean)) Then
    Begin
      If (strFatTipAnt <> edtTipoFator.Text) And Assigned(objVenda) And (Not fEmptyStr(edtTipoFator.Text)) Then
      Begin

        objLiberacao := TLiberacao.Create;

        Try
          objLiberacao.objMsgLibera.pAddTexto('Permissão para alterar o tipo do fator de nota especial na digitação do pedido de venda');
          objLiberacao.objMsgLibera.pAddSeparador(100);
          objLiberacao.objMsgLibera.pAddTextoCaption('Tipo Informado', edtTipoFator.Text);
          objLiberacao.objMsgLibera.pAddTextoCaption('Tipo Anterior', strFatTipAnt) ;
          objLiberacao.strDirAce  := 'TFANSP';
          objLiberacao.strSenLib  := fCfgSis('SENLBD');
          objLiberacao.strMsgSen  := 'Liberacao de Alteração do Tipo do Fator de Nota Especial';
          objLiberacao.blnMosMen  := True;
          objLiberacao.strCodOpe  := strLoginUsuarioLogado;
          objLiberacao.strCodDig  := strLoginUsuarioLogado;
          objLiberacao.strCliente := objVenda.strCodCli + '-' + objVenda.strCliNom;
          objLiberacao.strCpfCnpj := objVenda.strCliCgc;
          objLiberacao.blnUsarSenhaFixa         := False;
          objLiberacao.blnSempreVariavelUsuario := True;
          objLiberacao.tipCliFor := IIF(objVenda.strOpcDoc = 'OF', cfFornecedor, cfCliente);
          Result := objVenda.fFatMensagemLiberacao(objLiberacao);

          If (not Result) then
            edtTipoFator.Text := strFatTipAnt
          Else
            strFatTipAnt   := edtTipoFator.Text;
        Finally
          FreeAndNil(objLiberacao);
        End;
      End;
    End;
  End

  Else If (Sender = edtCodPor) And (edtCodPor.Visible)  And (Self.Visible) And
          (pnlFatorParaFaturamento.Enabled) Then
  Begin
    If Not fEmptyStr(edtCodPor.Text) Then
    Begin
      pCarregaPortador;
      If qryConPor.FieldByName('POR_CODPOR').IsNull Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
        Result := False;
      End
      {*REQ*145940**********RP*}
      Else If Not fEmpresaTemAcessoPortador(qryConPor.FieldByName('POR_CODPOR').AsString) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'O portador deve ser preenchido.!', ['&O k']);
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfraFatorParaFaturamentoFrame.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    if fPesqPortador(conSimples, GetParentForm(self) as TForm, edtCodPor, edtNomPor, qryConPor, Key, arrSel) then
    Begin
      If fValidaCampos(edtCodPor, True) Then
        SelectNext(GetParentForm(self).ActiveControl, True, True);
    End;
  End;
end;

procedure TfraFatorParaFaturamentoFrame.edtFatCalChange(Sender: TObject);
  Var
    blnVisible: Boolean;
begin
  inherited;
  blnVisible := False;
  If (fStrToFloat(edtFatCal.Text) > 0) And (edtTipoFator.Text = 'Q') Then
  Begin
    If fCfgSis('FINMNO') = '2' Then
    Begin
      blnVisible := True;
      edtCodPor.Text := objVenda.fDefinePortadorBaixa;
      fValidaCampos(edtCodPor);
    End;
  End;

  lblCodPor.Visible := blnVisible;
  edtCodPor.Visible := blnVisible;
  edtNomPor.Visible := blnVisible;

  If Not blnVisible Then
    edtCodPor.Clear;
end;

procedure TfraFatorParaFaturamentoFrame.edtFatCalEnter(Sender: TObject);
begin
  If (Not fEmptyStr(edtFatCal.Text)) Then
    fltFatValAnt := fStrToFloat(edtFatCal.Text)
  Else
    fltFatValAnt := 0.000;
end;

procedure TfraFatorParaFaturamentoFrame.edtTipoFatorEnter(Sender: TObject);
begin
  strFatTipAnt := edtTipoFator.Text;
end;

procedure TfraFatorParaFaturamentoFrame.OnFormShow;
begin
  Self.Visible := fCfgSis('SOLFNE', varBoolean) And (objVenda.strEspDoc = 'PD');

  If fCfgSis('SOLFNE', varBoolean) Then
  Begin
    edtTipoFator.Visible := fCfgSis('FTNFES', varBoolean);
    lblTipoFator.Visible := edtTipoFator.Visible;
    clbTipoFator.Visible := edtTipoFator.Visible;
    edtFatCal.Text       := FormatFloat(',0.0000', objVenda.fltFatNot);
    edtTipoFator.Text    := objVenda.strTipFatNEs;
    If (objVenda.fltFatNot = 0) And (strTipFatAnt = 'B')  Then
      pCarregaFatorNFEspecialCliente;
  End;

  If Not fEmptyStr(objVenda.strCodPorNfMeiaNota) Then
  Begin
    edtCodPor.Text := objVenda.strCodPorNfMeiaNota;
    fValidaCAmpos(edtCodPor);
  End;

  If Not fVerificaAcessoSistema('ALTFNE') Then
  Begin
    edtFatCal.Enabled := False;
    edtTipoFator.Enabled := False;
    edtCodPor.Enabled := False;
    edtNomPor.Enabled := False;
  End;
end;

end.

