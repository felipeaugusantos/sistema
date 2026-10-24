unit untFatTipoExpedicao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, StdCtrls, EditFocus, QColorLabel, AppEvnts,
  Menus, ComCtrls, Buttons, ExtCtrls, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, untFuncFat, Types, TypInfo;

type
  TfrmFatTipoExpedicao = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    gpbTipFat: TGroupBox;
    ColorLabel2: TColorLabel;
    edtTipFat: TEditFocus;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

    FEhFaturamentoDePedidoOriundoDeConsignacao : Boolean;

    blnPermitirEmissaoFF : Boolean;
    blnPermitirEmissaoBR : Boolean;

    function fRetTipFatCnd: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    fatVenda: TFatVenda;
    blnConfirma: Boolean;
  public
    property blnEhFaturamentoDePedidoOriundoDeConsignacao : Boolean Read FEhFaturamentoDePedidoOriundoDeConsignacao Write FEhFaturamentoDePedidoOriundoDeConsignacao;
  end;

var
  frmFatTipoExpedicao: TfrmFatTipoExpedicao;

implementation

uses untFuncoesSimples, untPai, untConstantes,
 untValidadorDaRegraValorEmissaoNFCePorEstado;

{$R *.dfm}

function TfrmFatTipoExpedicao.fRetTipFatCnd: String;
var
  strTipFat: String;
begin
  strTipFat := fCampoTabela('CND_ESPFAT', 'CADCND', ['CND_CODIGO'], [fatVenda.strCodCnd]);

  if strTipFat = 'NF' then
    Result := 'A'
  else if strTipFat = 'FF' then
    Result := 'B'
  else if strTipFat = 'IF' then
    Result := 'C'
  else
    Result := '';
end;

function TfrmFatTipoExpedicao.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    strMenEmiNF: String;
    strEspeciesPermitidas: String;

  function fCPFObrigatorio: Boolean;
  begin
    Result := False;

    If (fatVenda.fGeraNovoPedidoEntregaCD('S') Or fatVenda.fPedidoMultiLoja) And
       (fCfgSis('CPFNOB', varBoolean)) Then
      Exit;

    If fCfgSis('CPFOBR', varBoolean) Then
    Begin
      If (edtTipFat.Text = 'A') Then
      Begin
        Result := True;
        strMenEmiNF := 'Nota Fiscal'
      End
      Else If (edtTipFat.Text = 'C') Then
      Begin
        If fatVenda.fGeraNovoPedidoEntregaCD('S') Then
        Begin
          Result := True;
          strMenEmiNF := 'um documento de entrega pelo CD. Neste caso, a identificação do cliente é obrigatória para que o CD possa realizar a entrega.';
        End
        Else If (fatVenda.fPedidoMultiLoja) And
                ((fatVenda.fGeraNovoPedidoEntregaImediata('S')) Or (fatVenda.fGeraNovoPedidoRetiraOutraLoja('S')) Or
                (fatVenda.fGeraNovoPedidoRetiraExpedicao('S')) Or (fatVenda.fGeraNovoPedidoRetiraMesmaLoja('S'))) Then
        Begin
          Result := True;
          strMenEmiNF := 'um documento multi-loja que terá desmembramento. Neste cenário, é obrigatório um CPF / CNPJ válido para que o consumidor tenha identificação no documento que será gerado para a outra loja.';
        End;
      End;
    End;
  end;

  function fVerificaTipFatPerfilCondicao: Boolean;
    Var
      strTipFat: String;
  begin
    If fEmptyStr(fatVenda.strCodCnd) Then
    Begin
      Result := True;
      Exit;
    End;

    strTipFat := fCampoTabela('CND_TIPFAT', 'CADCND', ['CND_CODIGO'], [fatVenda.strCodCnd]);
    Result := Pos(edtTipFat.Text , strTipFat) > 0;
  end;

begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtTipFat) And (gpbTipFat.Enabled) And (gpbTipFat.Visible) Then
    Begin
      If fEmptyStr(edtTipFat.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O tipo de faturamento não pode ser nulo!', ['&Ok']);
        Result := False;
      End
      Else If (FEhFaturamentoDePedidoOriundoDeConsignacao) And (Pos(edtTipFat.Text , 'AB') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O tipo de faturamento deve ser A ou B para a operação de consignação!', ['&Ok']);
        Result := False;
      End
      Else If (edtTipFat.Text = 'C') And (Not fCfgSis('USACUP', varBoolean)) And (Not fCfgSis('USNFCE', varBoolean)) And (Not fUsaSat) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitido Cupom Fiscal, pois nas Configurações do sistema não há permissão!', ['&O k']);
        Result := False;
      End
      Else If (edtTipFat.Text = 'C') And (fCfgSis('IF_PRZ') = 'N') And (fatVenda.strConPag <> '01000') Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitido Cupom Fiscal com condição de pagamento a Prazo,'+#13#10+
                              'pois nas Configurações de Faturamento não há permissão !', ['&O k']);
        Result := False;
      End
      Else If (fCfgSis('ENCDIF') = 'N') And (edtTipFat.Text = 'C') And (fatVenda.blnEnt_CD) Then
      Begin 
        fMensagem('ATENÇÃO!', 'Não é permitido Cupom Fiscal quando entrega através do CD!', ['&Ok']);
        Result := False;
      End
      Else If (SameText(edtTipFat.Text, 'C')) And (fatVenda.blnCliFil) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitido Cupom Fiscal para Cliente Filial', ['&O k']);
        Result := False;
      End
      Else If (edtTipFat.Text = 'C') And (fatVenda.fltTotIpi > 0) Then
      Begin
        pMensagemOk('Não é permitido Cupom Fiscal para pedido com IPI!');
        Result := False;
      End
      Else If (edtTipFat.Text = 'C') And (fFormataFloat(fatVenda.fltValFre, 2) <> 0.00) And (fatVenda.fBloqueiaCupomComFreteQuandoSATouNFCE) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitdo informar frete para Cupom Fiscal', ['&Ok']);
        Result := False;
      End
      Else If (Pos(edtTipFat.Text, 'A' + IIF(blnPermitirEmissaoFF or blnPermitirEmissaoBR, 'B', '') + IIF(SameText(fatVenda.strTipOpe, 'B'), '', 'C')) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O tipo de faturamento deve ser A' + IIF(blnPermitirEmissaoFF or blnPermitirEmissaoBR, IIF(SameText(fatVenda.strTipOpe, 'B'), ' ou ', ',') + 'B', '') + IIF(SameText(fatVenda.strTipOpe, 'B'), '', ' ou C') + '!', ['&Ok']);
        Result := False;
      End
      Else if (fatVenda.strTipOpe = 'A') And (Trim(edtTipFat.Text) <> 'A') then
      Begin
        fMensagem('ATENÇÃO!', 'O tipo de faturamento deve ser A!', ['&Ok']);
        Result := False;
      End
      Else If (edtTipFat.Text = 'C') And (fatVenda.strTipOpe = 'U') Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitido Cupom Fiscal para pedido com Tipo Operação: Uso e Consumo!', ['&O k']);
        Result := False;
      End;

      If Result And fCPFObrigatorio Then
      Begin
        If (fEmptyStr(fatVenda.strCliCgc)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Cliente não possui CPF / CNPJ. Não será permitido emitir ' + strMenEmiNF + '.', ['&Ok']);
          Result := False;
        End
        Else If (fReplicatorStr(fatVenda.strCliCgc[1], Length(fatVenda.strCliCgc)) = fatVenda.strCliCgc) And
                (fatVenda.fTrocaUFEndEntrega <> 'EX') Then
        Begin
          fMensagem('ATENÇÃO!', 'O CPF / CNPJ do cliente não é válido para emitir ' + strMenEmiNF + '.', ['&Ok']);
          Result := False;
        End;
      End
      Else If (edtTipFat.Text = 'C') And (Not fatVenda.fHaveraDesmembramentoVenda) And
              (fatVenda.fTemEntregaFutura(fatVenda.arrMatItens)) And (fCfgSis('CUPNOT') = '1') And (Not fCfgSis('HEFCOE', varBoolean)) Then
      Begin
        pMensagemOk('Não é permitido Cupom Fiscal para Entrega Futura!');
        Result := False;
      End

      Else If (edtTipFat.Text = 'C') And (Not fatVenda.fHaveraDesmembramentoVenda) And
              (fatVenda.fTemItensEntregaImediata(fatVenda.arrMatItens)) And (fCfgSis('CUPENT') = '1') Then
      Begin
        pMensagemOk('Não é permitido Cupom Fiscal para Entrega Imediata!');
        Result := False;
      End

      Else if (SameText(edtTipFat.Text,'C') and  fCfgSis('USNFCE', varBoolean)) Then
      begin
        if Not fatVenda.fValidarValorEmissaoNFCePorEstado('NFCe') then
          Result := False;
      end;

      If Result And fCfgSis('PFLCLI', varBoolean) Then
      Begin
        Result := fVerificaTipFatPerfilCondicao;

        If Not Result Then
          fMensagem('ATENÇÃO!', 'Esse Tipo de Faturamento não é permitido pelo tipo de perfil da condição de pagamento!', ['&Ok']);
      End;

      If Result And (edtTipFat.Text = 'B') And (fatVenda.strTipOpe <> 'U') Then
        Result := fatVenda.fPermiteEmissaoFFPeloTipoDePedido(edtTipFat.Text);

      If Result And fatVenda.blnVendaPresencial Then
      Begin
        If Not fatVenda.fValidaEspecieVendaPresencial(fatVenda.fTipFatToEspecie(edtTipFat.Text), strEspeciesPermitidas) Then
        Begin
          pMensagemOk(Format(MSG_ESPECIES_PERMITIDAS_VENDA_PRESENCIAL, [strEspeciesPermitidas]));
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmFatTipoExpedicao.FormCreate(Sender: TObject);
begin
  inherited;
  FEhFaturamentoDePedidoOriundoDeConsignacao := False;
end;

procedure TfrmFatTipoExpedicao.FormShow(Sender: TObject);
begin
  inherited;
  blnConfirma := False;

  blnPermitirEmissaoFF := fPermiteEmissaoEspecie('FF');
  blnPermitirEmissaoBR := fPermiteEmissaoEspecie('BR');

  If fCfgSis('UTIDTF', varBoolean) And (not fEmptyStr(fatVenda.strCodCnd)) Then
    edtTipFat.Text := fRetTipFatCnd
  Else If (Pos(fCfgSis('TIPFAT'), 'ABC') > 0) Then
    edtTipFat.Text := fCfgSis('TIPFAT');

  If (Not blnPermitirEmissaoFF) And (edtTipFat.Text = 'B') Then
    edtTipFat.Text := '';

  If (blnPermitirEmissaoBR) And (SameText(fatVenda.strTipOpe, 'B')) Then
    ColorLabel2.Caption := '(A) - Nota Fiscal    (B) - BR'
  Else If (SameText(fatVenda.strTipOpe, 'B')) Then
    ColorLabel2.Caption := '(A) - Nota Fiscal'
  Else If SameText(fatVenda.strTipOpe, 'A') Then
    ColorLabel2.Caption := '(A) - Nota Fiscal'
  Else If SameText(fatVenda.strTipOpe, 'U') Then
  Begin
    ColorLabel2.Caption := '(A) - Nota Fiscal   ';
    If fPermiteEmissaoEspecie('UC') Then
      ColorLabel2.Caption := ColorLabel2.Caption + ' (B) - UC';
  End
  Else If (blnPermitirEmissaoFF) Then
    ColorLabel2.Caption := '(A) - Nota Fiscal    (B) - FF    (C) - Cupom Fiscal'
  Else
    ColorLabel2.Caption := '(A) - Nota Fiscal    (C) - Cupom Fiscal';

  If (FEhFaturamentoDePedidoOriundoDeConsignacao) Then
    ColorLabel2.Caption := '(A) - Nota Fiscal    (B) - CS';

end;

procedure TfrmFatTipoExpedicao.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    fatVenda.strTipPed := edtTipFat.Text;
    Close;
  End;
end;

procedure TfrmFatTipoExpedicao.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
