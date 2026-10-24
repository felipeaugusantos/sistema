unit untFatTipoFaturamento;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons,
  ExtCtrls, EditFocus, {Qt,} untFuncFat, untFuncFatTypes, AppEvnts, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmFatTipoFaturamento = class(TfrmPaiSimples)
    edtTipFat: TEditFocus;
    pnlConfirma: TPanel;
    Label1: TLabel;
    pnlFundo: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function fPermiteEmissaoDoPedidoMesmoSendoFilial: Boolean;
    function fPermiteTipoFaturamentoConformeCondicao(): Boolean;
    function fGetEspecieSugestao: String;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnVerificaTipoFaturamentoConformePerfil: Boolean;
    blnAutSer: Boolean;
    intPosAtual: Integer;
    arrOpcoes: TOpcoesFaturamentoArray;
    strOpcDoc: String;
    strConPag: String;
    fatVenda: TFatVenda;
    blnConfirma: Boolean;
    strEspecieSugestao : String;
  end;


implementation

uses  untfuncoesSimples, untConstantes, untValidadorDaRegraValorEmissaoNFCePorEstado;

{$R *.dfm}

procedure TfrmFatTipoFaturamento.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  blnVerificaTipoFaturamentoConformePerfil := True;
  strEspecieSugestao := EmptyStr;
end;

procedure TfrmFatTipoFaturamento.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
  Var
    intPosicao: Integer;
    intContador: Integer;
begin
  inherited;

  If Key = VK_Down Then
  Begin

    intPosicao := intPosAtual;

    If (intPosAtual+1 >= Length(arrOpcoes)) Then
    Begin
      intPosAtual := 0;
    End
    Else
      Inc(intPosAtual);

    While (arrOpcoes[intPosAtual].strMosMen = 'N') And
          (intPosicao <> intPosAtual)              Do
    Begin

      If intPosAtual >= Length(arrOpcoes)-1 Then
        intPosAtual := 0
      Else
        Inc(intPosAtual);

    End;
    edtTipFat.Text := arrOpcoes[intPosAtual].strDesCri;

  End
  Else If Key = VK_Up Then
  Begin
    intPosicao := intPosAtual;

    If (intPosAtual-1 < 0) Then
    Begin
      intPosAtual := Length(arrOpcoes)-1;
    End
    Else
      Dec(intPosAtual);

    While (arrOpcoes[intPosAtual].strMosMen = 'N') And
          (intPosicao <> intPosAtual)              Do
    Begin

      If intPosAtual <= 0 Then
        intPosAtual := 0
      Else
        Dec(intPosAtual);

    End;
    edtTipFat.Text := arrOpcoes[intPosAtual].strDesCri;

  End
   Else If Shift <> [ssAlt] Then
  Begin

    For intContador := 0 To Length(arrOpcoes) -1 Do
    Begin

      If (arrOpcoes[intContador].strOpcLet = Chr(Key)) Then
      Begin
        intPosAtual := intContador;
        Break;
      End;

    End;

    If intContador < Length(arrOpcoes) Then
      edtTipFat.Text := arrOpcoes[intPosAtual].strDesCri;

  End;

end;

function TfrmFatTipoFaturamento.fPermiteEmissaoDoPedidoMesmoSendoFilial: Boolean;
begin
  Result := False;

  If (Pos(fatVenda.strOpcDoc, 'CS_CR_FC_') > 0) Then
    Result := True
end;

function TfrmFatTipoFaturamento.fPermiteTipoFaturamentoConformeCondicao(): Boolean;
begin
  Result := True;
  If (blnVerificaTipoFaturamentoConformePerfil) Then
    Result := fatVenda.fPermiteTipoFaturamentoConformeCondicao(arrOpcoes[intPosAtual].strEspDoc);
end;

function TfrmFatTipoFaturamento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strEspeciesPermitidas: String;
begin

  Result := True;

  repeat

    If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Begin

      If (Sender = edtTipFat) Then
      Begin

        If (fEmptyStr(edtTipFat.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'É necessário escolher um tipo de faturamento!', ['&O k']);
          Result := False;
          Break;
        End
        Else If (Not fPermiteEmissaoEspecie(arrOpcoes[intPosAtual].strEspDoc)) Then
        Begin
          fMensagem('ATENÇÃO!',Format(MSG_ESPECIE_EMISSAO_NAO_PERMITIDA, [fGetConfiguracaoPermiteEmissaoEspecie(arrOpcoes[intPosAtual].strEspDoc)]) , ['&OK']);
          Result := False;
          Break;
        End
        Else If fatVenda.blnVendaPresencial Then
        Begin
          If Not fatVenda.fValidaEspecieVendaPresencial(arrOpcoes[intPosAtual].strEspDoc, strEspeciesPermitidas) Then
          Begin
            pMensagemOk(Format(MSG_ESPECIES_PERMITIDAS_VENDA_PRESENCIAL, [strEspeciesPermitidas]));
            Result := False;
            Break;
          End;
        End

        Else If (Not fPermiteTipoFaturamentoConformeCondicao) Then
        Begin
          Result := False;
          Break;
        End

        {*****************************************}
        {* VALIDAÇÃO PARA NOTA ESPECIAL          *}
        {**************************************MV*}
        Else If (arrOpcoes[intPosAtual].strEspDoc = 'NE') Then
        Begin

{          If (fStatusCndPag(fatVenda.strConPag) = A_PRAZO) Then
          Begin
            fMensagem('ATENÇÃO!', 'Emissão de nota especial somente à vista!', ['&O k']);
            Result := False;
            Break;
          End;}

          If (strOpcDoc = 'CF') Then
          Begin
            fMensagem('ATENÇÃO!', 'Não é permitida a confirmação de documentos em Nota Especial!', ['&O k']);
            Result := False;
            Break;
          End;

        End;

        {********************************************}
        {* VALIDAÇÃO DE ITENS AGROTOXICOS EM CUPOM  *}
        {*****************************************IV*}
        If (arrOpcoes[intPosAtual].strEspDoc = 'IF') Then
        Begin

          If fCfgSis('RECGRO', varBoolean) Then
          Begin

            If (fVerificaItemAgrotoxico(fatVenda)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Não é permitido emitir Cupom Fiscal' + #13#10 +
                                    'em venda com produtos que sejam agrotóxicos!', ['&O k']);
              Result := False;
              Break;
            End;

          End;

        End;

        If (Pos(arrOpcoes[intPosAtual].strEspDoc, 'MI_FF') > 0) Then
        Begin
          {*****************************************}
          {* SE NÃO FOR ACEITO MI FORA DO ESTADO   *}
          {**************************************MV*}
          If (Not fCfgSis('MIFEST', varBoolean)) Then
          Begin

            If (fatVenda.fTrocaUFEndEntrega <> fCadEmp('ESTADO')) And (fVerificaSituacaoTributaria(fatVenda)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Não é permitido confirmar ' + arrOpcoes[intPosAtual].strEspDoc + ' com produto que ' +
                                    'tenha substituição tributária para cliente fora do estado!', ['&O k']);
              Result := False;
              Break;
            End;

          End;


        End;

        {*****************************************}
        {* VALIDAÇÃO PARA ORÇAMENTO / PEDIDO     *}
        {**************************************MV*}
        If (Pos(arrOpcoes[intPosAtual].strEspDoc, 'OR_PD_') > 0) Then
        Begin

          If (fatVenda.blnCliFil) And (Not fPermiteEmissaoDoPedidoMesmoSendoFilial) Then
          Begin
            fMensagem('ATENÇÃO!', 'Emissão de Orçamento / Pedido não permitido para cliente filial!', ['&O k']);
            Result := False;
            Break;
          End;

        End;

        If (Pos(arrOpcoes[intPosAtual].strEspDoc, 'IF_IV_') > 0) Then
        Begin

          If (fatVenda.blnCliFil) Then
          Begin
            fMensagem('ATENÇÃO!', 'Emissão de Cupom Fiscal / Cupom Fiscal Especial não permitido para cliente filial!', ['&O k']);
            Result := False;
            Break;
          End;

        End;

        {*****************************************}
        {* VALIDAÇÃO DE CONFIRMAÇÃO DE DOCUMENTO *}
        {**************************************MV*}
        If (strOpcDoc = 'CF') Then
        Begin

          If (Pos(arrOpcoes[intPosAtual].strEspDoc, 'NF_EL_NS_FF_IF_IV_D1_') <= 0) Then
          Begin

            fMensagem('ATENÇÃO!', 'Confirmação de Documento somente em Nota Fiscal e Cupom Fiscal!', ['&O k']);
            Result := False;
            Break;

          End;

        End;

        {*****************************************}
        {* VALIDAÇÃO DE VENDA NORMAL             *}
        {**************************************MV*}
        If (strOpcDoc = 'VN') Then
        Begin

          If (arrOpcoes[intPosAtual].strEspDoc = 'OR') Then
          Begin
            If (Not fEmptyStr(fatVenda.strNumOrc)) And
               (fatVenda.strEspOrc = 'PD')         Then
            Begin
              fMensagem('ATENÇÃO!', 'Não é possivel confirmar Pedido de Venda em Orçamento!', ['&O k']);
              Result := False;
              Break;
            End;
          End;

          If (arrOpcoes[intPosAtual].strEspDoc <> 'PD') Then
          Begin
            If (Not fEmptyStr(fatVenda.strNumOrc)) Then
            Begin
              If fItemPendenteSeparacaoAutoCenter(fatVenda.strEmpOri, fatVenda.strNumOrc, fatVenda.strEspOrc) Then
              Begin
                pMensagemOk('Existem produtos pendentes na Expedição de Serviço que precisam ser regularizados. '
                          + 'O pedido não poderá ser faturado com esta pendência. '
                          + 'Entre em contato com o setor responsável!');
                Result := False;
                Break;
              End
              Else If fServicoPendenteAutoCenter(fatVenda.strEmpOri, fatVenda.strNumOrc, fatVenda.strEspOrc) Then
              Begin
                pMensagemOk('Existem serviços não finalizados no Acompanhamento de Serviços. '
                          + 'O pedido não poderá ser faturado com esta pendência. '
                          + 'Entre em contato com o setor responsável!');
                Result := False;
                Break;
              End
            End
          End;
        End

        Else If (strOpcDoc = 'DV') Then
        Begin

          If Pos(arrOpcoes[intPosAtual].strEspDoc, 'DV_NF_EL_') <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Escolha Nota Fiscal (NF) ou  Devolução (DV)!', ['&O k']);
            Result := False;
            Break;
          End;

        End;

        {*************************************************************************}
        {* TRAVA CASO SEJA EMISSAO DE CUPOM FISCAL A PRAZO CONFORME CONFIGURACAO *}
        {**********************************************************************RV*}
        If (arrOpcoes[intPosAtual].strEspDoc = 'IF') And (fCfgSis('IF_PRZ') = 'N') And (strConPag <> '01000') Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido Cupom Fiscal com condição de pagamento a Prazo,'+#13#10+
                                'pois nas Configurações de Faturamento não há permissão !', ['&O k']);
          Result := False;
          Break;
        End;

        If (arrOpcoes[intPosAtual].strEspDoc = 'IF') And (fCfgSis('IF_VEN') = 'N') Then
        Begin
          fMensagem('ATENÇÃO!', 'Só é permitido a Emissão de Cupom Fiscal no Caixa!', ['&O k']);
          Result := False;
          Break;
        End;

        If (arrOpcoes[intPosAtual].strEspDoc = 'IF') And (Not fatVenda.fHaveraDesmembramentoVenda) And
           (fatVenda.fTemEntregaFutura(fatVenda.arrMatItens)) And (fCfgSis('CUPNOT') = '1') And (Not fCfgSis('HEFCOE', varBoolean)) Then
        Begin
          pMensagemOk('Não é permitido Cupom Fiscal para Entrega Futura!');
          Result := False;
          Break;
        End;

        If (arrOpcoes[intPosAtual].strEspDoc = 'IF') And (Not fatVenda.fHaveraDesmembramentoVenda) And
           (fatVenda.fTemItensEntregaImediata(fatVenda.arrMatItens)) And (fCfgSis('CUPENT') = '1') Then
        Begin
          pMensagemOk('Não é permitido Cupom Fiscal para Entrega Imediata!');
          Result := False;
          Break;
        End;

        If (fCfgSis('PAFECF', varBoolean)) And (fDavPreVendaCadastrado(fatVenda.strNumOrc, fatVenda.strEspOrc, VS_strCodEmp)) Then
        Begin
          If (arrOpcoes[intPosAtual].strEspDoc = 'IF') Then
          Begin
            pMensagemOk('Não é permitido faturar este documento em Cupom Fiscal pois o mesmo possui uma pré-venda associada. Use o PDVCitel.');
            Result := False;
            Break;
          End

          Else If (Pos(arrOpcoes[intPosAtual].strEspDoc, 'OR_PD_') > 0) Then
          Begin
            fatVenda.blnGravarDavPv := True;
          End;
        End;

        if Not fatVenda.fValidarValorEmissaoNFCePorEstado(edtTipFat.Text) then
        begin
          Result := False;
          Break;
        end;

        If (arrOpcoes[intPosAtual].strEspDoc = 'FF') And
           (Not(fCfgSis('PCDFFF', varBoolean))) And
           (strOpcDoc = 'CF') Then
        Begin
          pMensagemOk('Não é permitido confirmar este documento em "FF Faturamento Futuro"! ( CFG_PCDFFF )');
          Result := False;
          Break;
        End;

        If (strOpcDoc = 'VN') And
           (arrOpcoes[intPosAtual].strEspDoc = 'PD') And
           fCfgSis('SVPDVN', VarBoolean) Then
        Begin
          If (Not fatVenda.fValidaPrecoSugeridoTERegimeEspecialVendaNormalComoPedido) Then
          Begin
            Result := False;
            Break;
          End;
        End;


      End;

    End;

  Until True;

  If Not Result Then
    pSetFocus(Sender);
end;


procedure TfrmFatTipoFaturamento.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    Close;
  End;

end;

function TfrmFatTipoFaturamento.fGetEspecieSugestao: String;
  Var
    blnUsaPaf : Boolean;
begin
  If (Not fEmptyStr(strEspecieSugestao)) Then
    Exit(strEspecieSugestao);

  Result := fCfgSis('ESPSUG');
  blnUsaPaf := fCfgSis('PAFECF', varBoolean);

  If (fatVenda.strOpcDoc = 'VN') And (fatVenda.blnMulLoj Or blnUsaPaf) Then
    Result := 'NF';

  If (Pos(fatVenda.strOpcDoc, 'VN_') > 0) And (fatVenda.strTipOpe = 'B') Then
    Result := EmptyStr;

  If (Pos(fatVenda.strOpcDoc, 'TE_') > 0) Then
    Result := 'NF';
end;

procedure TfrmFatTipoFaturamento.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatTipoFaturamento.FormShow(Sender: TObject);
  Var
    intContador : Integer;
    strEspSug : String;
begin
  inherited;
  intPosAtual := 0;
  strEspSug := EmptyStr;

  If Pos(strOpcDoc, 'VN_TE_') > 0 Then
  Begin
    strEspSug := fGetEspecieSugestao;

    For intContador := Low(arrOpcoes) To High(arrOpcoes) Do
    Begin
      If arrOpcoes[intContador].strEspDoc = strEspSug Then
      Begin
        intPosAtual := intContador;
        Break;
      End;
    End;
  End;

  If blnAutSer Then
    intPosAtual := 3;

  If strEspSug = 'XX' Then
    edtTipFat.Clear
  Else
    edtTipFat.Text := arrOpcoes[intPosAtual].strDesCri;
end;

end.

