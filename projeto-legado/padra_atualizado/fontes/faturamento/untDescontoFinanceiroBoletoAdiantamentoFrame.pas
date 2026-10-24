unit untDescontoFinanceiroBoletoAdiantamentoFrame;

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
  TfraDescontoFinanceiroBoletoAdiantamentoFrame = class(TFrame)
    pnlFundo: TPanel;
    pnlDescontoFinanceiro_BoletoAdiantamento: TPanel;
    pnlDescontoFinanceiro: TGroupBox;
    Label3: TLabel;
    ColorLabel4: TColorLabel;
    Label8: TLabel;
    lblPerDes: TLabel;
    shpDesFin: TShape;
    edtDesFin: TEditFocus;
    edtTipFin: TEditFocus;
    pnlBoletoDeAdiantamento: TGroupBox;
    Label7: TLabel;
    Label10: TLabel;
    edtBolAdt: TEditFocus;
    edtValRes: TEditFocus;
    chkBolVen: TCheckBox;
    HintControler: TcxHintStyleController;
    procedure edtTipFinExit(Sender: TObject);
    procedure chkBolVenClick(Sender: TObject);
  private
    { Private declarations }
    blnIniciandoTela: Boolean;
    objLiberacao: TLiberacao;
    procedure pOnShow;

    procedure pAtualizaValorRestante;

  public
    { Public declarations }
    objVenda: TFatVenda;
    blnLiberado: Boolean;

    pCalcularTotalPedido: procedure(AInformacao: String = ''; ASteps: Integer = 1; AForcarCalculo: Boolean = False) of Object;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;

    procedure OnFormShow;
    procedure OnFormCreate;
    procedure OnFormDestroy;

    function fEhPedidoParaEmitirBoletoParaTodosVencimentos(strCodFpg, strNumOrc: String): Boolean;
    function fEhOrcamentoFechandoEmPedidoParaEmitirBoletoParaTodosVencimentos(strCodFpg, strOpcDoc, strEspDoc: String): Boolean;
    function fUtilizaDefinicaoDeImpressaoDeBoletoNaCondicaoDePagamento(strCodFpg, strOpcDoc, strEspDoc, strNumOrc: String): Boolean;

    function fConfirmaDados: Boolean;
  end;

var
  fraDescontoFinanceiroBoletoAdiantamentoFrame: TfraDescontoFinanceiroBoletoAdiantamentoFrame;

implementation

uses untPesqAux, Data.DB, untTypesSistema, Math, untConsultas, untDigPedCmp,
     untTipoFreteAtc, untfuncoesSimples, untConstantes, untValidacoesRotasRegiao,
     untFatMostraItensFechamento, untCadClientes, untFuncoes, untPesoItem,
     untAdiantamentoClienteGenerico, untProjetos, untMsgLiberacao;

{$R *.dfm}

procedure TfraDescontoFinanceiroBoletoAdiantamentoFrame.pAtualizaValorRestante;
Var
  strHint: String;
begin
  objVenda.pCalculaTotalParaCadRec;
  If chkBolVen.Checked Then
    edtBolAdt.Text := FormatFloat(edtValRes.EditFormat,
      objVenda.fltTotCadRec + objVenda.fltTotalFaturadoParcialmente - objVenda.fltValAdt);

  edtValRes.Text := FormatFloat(edtValRes.EditFormat,
    objVenda.fltTotCadRec + IIF(chkBolVen.Checked, objVenda.fltTotalFaturadoParcialmente, 0) -
    objVenda.fltValAdt - fStrToFloat(edtBolAdt.Text));

  strHint := '';
  strHint := strHint + '(+) Valor do Documento..: ' + fPadL(FormatFloat('#,##0.00', objVenda.fltTotCadRec), 10) + #13#10;
  strHint := strHint + '(+) Faturamento Parcial.: ' + fPadL(FormatFloat('#,##0.00', objVenda.fltTotalFaturadoParcialmente), 10) + #13#10;
  strHint := strHint + '(-) Adiantamento(s).....: ' + fPadL(FormatFloat('#,##0.00', objVenda.fltValAdt), 10) + #13#10;
  strHint := strHint + '(=) Valor Boleto(s).....: ' + fPadL(edtBolAdt.Text, 10);

  edtBolAdt.Hint := '';
  If chkBolVen.Checked Then
    edtBolAdt.Hint := strHint;
end;

function TfraDescontoFinanceiroBoletoAdiantamentoFrame.fConfirmaDados: Boolean;
begin
  inherited;
  Result := True;

  If Result And pnlDescontoFinanceiro.Visible Then
    Result := fValidaCampos(edtTipFin, True) And
              fValidaCampos(edtDesFin, True);

  If Result And pnlBoletoDeAdiantamento.Visible Then
    Result := fValidaCampos(edtBolAdt, True);

  If Result And chkBolVen.Checked Then
    Result := fValidaCampos(chkBolVen, True);

  If Not Result Then
    Exit;

  objVenda.strTipFin := edtTipFin.Text;
  objVenda.fltDesFin := fStrToFloat(edtDesFin.Text);

  If pnlBoletoDeAdiantamento.Visible Then
  Begin
    objVenda.fltBolAdt := fStrToFloat(edtBolAdt.Text);
    objVenda.blnBolVen := chkBolVen.Checked;
  End;

  If objVenda.blnAtualizarDuplicataBoletoAdiantamento Then
  Begin
    objVenda.pAtualizarValorDuplicataBoletoAdiantamento(objVenda.strNumOrc,
                                                        objVenda.strEspOrc,
                                                        objVenda.strEmpOri,
                                                        objVenda.strCliAnt,
                                                        edtBolAdt.Text);
  End;

end;

function TfraDescontoFinanceiroBoletoAdiantamentoFrame.fEhOrcamentoFechandoEmPedidoParaEmitirBoletoParaTodosVencimentos(strCodFpg, strOpcDoc, strEspDoc: String): Boolean;
begin
  Result := ((pnlBoletoDeAdiantamento.Visible) And (strCodFpg = '008') And (strOpcDoc = 'OR') And (strEspDoc = 'PD'));
end;

function TfraDescontoFinanceiroBoletoAdiantamentoFrame.fEhPedidoParaEmitirBoletoParaTodosVencimentos(strCodFpg, strNumOrc: String): Boolean;
begin
 Result := ((pnlBoletoDeAdiantamento.Visible) And (strCodFpg = '008') And (fEmptyStr(strNumOrc)));
end;

function TfraDescontoFinanceiroBoletoAdiantamentoFrame.fUtilizaDefinicaoDeImpressaoDeBoletoNaCondicaoDePagamento(strCodFpg, strOpcDoc, strEspDoc, strNumOrc: String): Boolean;
begin
  Result := (((fEhOrcamentoFechandoEmPedidoParaEmitirBoletoParaTodosVencimentos(strCodFpg, strOpcDoc, strEspDoc)) Or (fEhPedidoParaEmitirBoletoParaTodosVencimentos(strCodFpg, strNumOrc))) And (fCfgSis('SUGBOL', varString) = '3'));
end;

procedure TfraDescontoFinanceiroBoletoAdiantamentoFrame.OnFormCreate;
begin
  inherited;
  blnLiberado := False;
  objLiberacao := TLiberacao.create;
end;

procedure TfraDescontoFinanceiroBoletoAdiantamentoFrame.OnFormDestroy;
begin
  FreeAndNil(objLiberacao);
  inherited;
end;

function TfraDescontoFinanceiroBoletoAdiantamentoFrame.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    fltValDes: Double;
    strOpcTraDfi: string;
begin
  Result := True;

  If (Sender = edtTipFin) And pnlDescontoFinanceiro.Visible Then
  Begin
    If (Pos(edtTipFin.Text, 'PV') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Tipo de Desconto Financeiro deve ser (P)ercentual ou (V)alor!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtDesFin) And pnlDescontoFinanceiro.Visible Then
  Begin
    strOpcTraDfi := fCfgSis('TRADFI');
          
    If fStrToFloat(edtDesFin.Text) < 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Desconto Financeiro deve ser maior ou igual a zero!', ['&Ok']);
      Result := False;
    End

    Else If (edtTipFin.Text = 'P') And (fStrToFloat(edtDesFin.Text) >= 100) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Desconto em percentual dever ser menor que 100%!', ['&Ok']);
      Result := False;
    End

    Else If (fStrToFloat(edtDesFin.Text) > 0) And (Pos(strOpcTraDfi, 'T_A_') > 0) Then
    Begin
      pCalcularTotalPedido('Calculando desconto financeiro');
      pAtualizaValorRestante;

      If (edtTipFin.Text = 'P') Then
        fltValDes := RoundTo(objVenda.fltTotGer * fStrToFloat(edtDesFin.Text) / 100, -2)
      Else
        fltValDes := fStrToFloat(edtDesFin.Text);

      {**************************************}
      {* TRATAMENTO DE SENHA FIXA, VARIAVEL *}
      {* OU POR USUARIO                     *}
      {***********************************PE*}
      If Not blnLiberado then
      begin

        objLiberacao.Clear;
        objLiberacao.strDirAce    := 'DADEFN';
        objLiberacao.strSenLib    := fCfgSis('SNHDFI');
        objLiberacao.blnTraTel    := strOpcTraDfi = 'T';
        objLiberacao.strMsgSen    := 'Desconto do Financeiro';
        objLiberacao.strCodOpe    := objVenda.strCodVen;
        objLiberacao.strCodDig    := objVenda.strCodDig;
        objLiberacao.strCliente   := objVenda.strCodCli + '-' + fRetNomCliente(objVenda.strCodCli);

        objLiberacao.objMsgLibera.pAddTexto('Senha para conceder liberação do desconto do financeiro.');
        objLiberacao.objMsgLibera.pAddTextoCaption('Valor Documento' ,FormatFloat('#,##0.00', objVenda.fltTotGer), 16);
        objLiberacao.objMsgLibera.pAddTextoCaption('Desc. Financeiro',FormatFloat('#,##0.00', fltValDes)         , 16);

        if objVenda.fFatMensagemLiberacao(objLiberacao) then
        Begin
          blnLiberado := True;
          objVenda.strCodVen := objLiberacao.strCodOpe;
          objVenda.strCodDig := objLiberacao.strCodDig;
        end;
      End;

      Result := Result And blnLiberado;
    End;

  End

  Else If (Sender = chkBolVen) And pnlBoletoDeAdiantamento.Visible Then
  Begin
    If chkBolVen.Checked And (Pos(objVenda.strCodFpg, '008_014_015_012_') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Somente é permitido emitir boletos para todos os vencimentos ' +
        'quando utilizando as formas de pagamento 008-' + fRetDesFpg('008') + ', '+
        '014-' + fRetDesFpg('014') + ', 015-' + fRetDesFpg('015') + ' e 012-' + fRetDesFpg('012') +' !', ['&Ok']);
      If chkBolVen.Enabled Then
      Begin
        chkBolVen.Checked := False;
        edtBolAdt.Text := '0,00';
      End;
      Result := False;
    End;
  End

  Else If (Sender = edtBolAdt) And pnlBoletoDeAdiantamento.Visible Then
  Begin
    If fStrToFloat(edtBolAdt.Text) < 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor do boleto de adiantamento deve ser maior ou igual a zero!', ['&Ok']);
      edtBolAdt.Text := '0,00';
      Result := False;
    End;

    If Result And (fStrToFloat(edtBolAdt.Text) < objVenda.fltTotalBoletosAdiantamentoJaEnviados) Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor do boleto de adiantamento não pode ser '+
        'menor que o valor já enviado para o banco!', ['&Ok']);
      edtBolAdt.Text := FormatFloat(edtBolAdt.EditFormat, objVenda.fltTotalBoletosAdiantamentoJaEnviados);
      Result := False;
    End;

    If Result And chkBolVen.Checked And (fStrToFloat(edtBolAdt.Text) < objVenda.fltTotalFaturadoParcialmente) Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor do boleto de adiantamento não pode ser '+
        'menor que o valor dos documentos de faturamento já emitidos!', ['&Ok']);
      edtBolAdt.Text := FormatFloat(edtBolAdt.EditFormat, objVenda.fltTotalFaturadoParcialmente);
      Result := False;
    End;

    pCalcularTotalPedido('Calculando boleto(s) de adiantamento');
    pAtualizaValorRestante;

    If Result And (fStrToFloat(edtValRes.Text) < 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor do boleto de adiantamento não pode ser '+
        'maior que o valor restante a ser pago do documento!', ['&Ok']);
      edtBolAdt.Text := FormatFloat(edtBolAdt.EditFormat, objVenda.fltTotCadRec - objVenda.fltValAdt);
      pAtualizaValorRestante;
      Result := False;
    End;
  End;

  If Result And pnlBoletoDeAdiantamento.Visible And Not blnIniciandoTela Then
  Begin
    pCalcularTotalPedido('Calculando boleto(s) de adiantamento');
    pAtualizaValorRestante;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfraDescontoFinanceiroBoletoAdiantamentoFrame.chkBolVenClick(
  Sender: TObject);
begin
  If Not pnlBoletoDeAdiantamento.Visible Then
    Exit;

  If chkBolVen.Focused And chkBolVen.Checked Then
    fValidaCampos(chkBolVen, True);

  edtBolAdt.ReadOnly    := False;
  edtBolAdt.TabStop     := True;
  edtBolAdt.Color       := clWindow;
  edtBolAdt.NormalColor := clWindow;

  If chkBolVen.Checked Then
  Begin
    edtBolAdt.ReadOnly    := True;
    edtBolAdt.TabStop     := False;
    edtBolAdt.Color       := $00FFDFB8;
    edtBolAdt.NormalColor := $00FFDFB8;

    pCalcularTotalPedido('Calculando boleto(s) de adiantamento');
    pAtualizaValorRestante;
  End;
end;

procedure TfraDescontoFinanceiroBoletoAdiantamentoFrame.edtTipFinExit(Sender: TObject);
begin
  inherited;
  lblPerDes.Visible := SameText(edtTipFin.Text, 'P');
end;

procedure TfraDescontoFinanceiroBoletoAdiantamentoFrame.pOnShow;
begin
  inherited;
  If objVenda.strTipFin = '' Then
    objVenda.strTipFin := 'P';

  edtTipFin.Text := objVenda.strTipFin;
  edtDesFin.Text := FormatFloat('#0.00', objVenda.fltDesFin);

  chkBolVen.Checked := objVenda.blnBolVen;

  If fEhPedidoParaEmitirBoletoParaTodosVencimentos(objVenda.strCodFpg, objVenda.strNumOrc) Then
    chkBolVen.Checked := fCfgSis('SUGBOL') = '1';

  If fEhOrcamentoFechandoEmPedidoParaEmitirBoletoParaTodosVencimentos(objVenda.strCodFpg, objVenda.strOpcDoc, objVenda.strEspDoc) Then
     chkBolVen.Checked := fCfgSis('SUGBOL') = '1';

  If fUtilizaDefinicaoDeImpressaoDeBoletoNaCondicaoDePagamento(objVenda.strCodFpg, objVenda.strOpcDoc, objVenda.strEspDoc, objVenda.strNumOrc) Then
    chkBolVen.Checked := IIF(fCampoTabela('CND_EMIBOL', 'CADCND', ['CND_CODIGO'], [objVenda.strCodCnd], False) = 1, True, False);


  edtBolAdt.Text    := FormatFloat('#0.00', objVenda.fltBolAdt);

  If objVenda.fltTotalBoletosAdiantamentoJaEnviados + objVenda.fltTotalFaturadoParcialmente > 0 Then
    chkBolVen.Enabled := False;

  chkBolVenClick(nil);

  {********************************************}
  { DIREITO DE ACESSO PARA DESCONTO FINANCEIRO }
  {*****************************************PE*}
  If fVerificaAcessoSistema('DADEFN')Then
  Begin
    shpDesFin.Brush.Color := clGreen;
    shpDesfin.Pen.Color := ClGreen;
  End Else
  Begin
    shpDesFin.Brush.Color := clRed;
    shpDesFin.Pen.Color := clRed;
  End;

  pnlDescontoFinanceiro.Visible := (objVenda.strEspDoc = 'PD') And fCfgSis('DESFIN', varBoolean);
  pnlBoletoDeAdiantamento.Visible := (objVenda.strEspDoc = 'PD') And
                                     (fCfgSis('BOLADT', varBoolean) Or (objVenda.fltBolAdt > 0)) And
                                     (Not objVenda.DadosPixDaVenda.GerarPixDaVenda);

  If objVenda.DadosPixDaVenda.GerarPixDaVenda Then
  Begin
    chkBolVen.Checked := False;
    objVenda.fltBolAdt := 0;
  End;

  pnlBoletoDeAdiantamento.Enabled := fCfgSis('ALTBOL', varBoolean);

  Self.Visible := pnlDescontoFinanceiro.Visible Or pnlBoletoDeAdiantamento.Visible;

  If pnlBoletoDeAdiantamento.Visible Then
  Begin
    pCalcularTotalPedido('Calculando boleto(s) de adiantamento');
    pAtualizaValorRestante;
  End;
end;

procedure TfraDescontoFinanceiroBoletoAdiantamentoFrame.OnFormShow;
begin
  blnIniciandoTela := True;
  Try
    pOnShow;
  Finally
    blnIniciandoTela := False;
  End;
end;

end.

