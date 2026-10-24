unit untFatDadosFechamentoVenda;

interface

uses
  untFuncFat, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxGroupBox,
  untDigCndPagamentoFrame, untDadosFechamentoVendaTransportadoraFrame,
  untDadosFechamentoVendaObraFrame, untDadosFechamentoVendaBombeamentoFrame,
  untDadosFechamentoVendaMSGExpFrame, untFrameCentroCustoEditFocus,
  untDadosFechamentoVendaMSGFatFrame, untDadosFechamentoVendaClaFisFrame,
  untDadosFechamentoVendaPlanContasFrame, untDadosFechamentoVendaTotaisFrame,
  untDadosFechamentoVendaProjetoFrame,
  untDadosFechamentoVendaTipoFaturamentoFrame,
  untDadosFechamentoVendaGravarContasFrame,
  Data.DB, MemDS, DBAccess, Uni, cxProgressBar, untGravando,
  untFuncFatTypes, Datasnap.DBClient, UniClientDataSet, Math;

type
  TfrmFatDadosFechamentoVenda = class(TfrmPai)
    shpDivisoria: TShape;
    pnlLadoEsquerdo: TPanel;
    pnlLadoDireito: TPanel;
    gbPagamento: TGroupBox;
    fraPagamento: TfraDigCndPagamento;
    gbTransportadora: TGroupBox;
    fraDadosFechamentoVendaTransportadoraFrame: TfraDadosFechamentoVendaTransportadoraFrame;
    gbObra: TGroupBox;
    fraDadosFechamentoVendaObraFrame: TfraDadosFechamentoVendaObraFrame;
    gbBombeamento: TGroupBox;
    fraDadosFechamentoVendaBombeamentoFrame: TfraDadosFechamentoVendaBombeamentoFrame;
    gbExpedicao: TGroupBox;
    fraDadosFechamentoVendaMSGExpFrame: TfraDadosFechamentoVendaMSGExpFrame;
    gbCentroDeCusto: TGroupBox;
    fraCentroCustoEditFocus: TfraCentroCustoEditFocus;
    gbDadosFechamentoVenda: TGroupBox;
    fraDadosFechamentoVendaClaFisFrame: TfraDadosFechamentoVendaClaFisFrame;
    fraDadosFechamentoVendaMSGFatFrame: TfraDadosFechamentoVendaMSGFatFrame;
    gbPlanContas: TGroupBox;
    fraDadosFechamentoVendaPlanContasFrame: TfraDadosFechamentoVendaPlanContasFrame;
    gbImpostos: TGroupBox;
    fraDadosFechamentoVendaTotaisFrame: TfraDadosFechamentoVendaTotaisFrame;
    gbProjeto: TGroupBox;
    fraDadosFechamentoVendaProjetoFrame: TfraDadosFechamentoVendaProjetoFrame;
    gbTipoDeFaturamento: TGroupBox;
    fraDadosFechamentoVendaTipoFaturamentoFrame: TfraDadosFechamentoVendaTipoFaturamentoFrame;
    gbGravarContas: TGroupBox;
    fraDadosFechamentoVendaGravarContasFrame: TfraDadosFechamentoVendaGravarContasFrame;
    btnVerImpostos: TBitBtnLocked;
    btnMostraMargem: TBitBtnLocked;
    btnDadAdi: TBitBtnLocked;
    btnDigImpostosItens: TBitBtnLocked;
    btnConfirmaDados: TBitBtnLocked;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private

    FBackupVar      : TObjectBackupVar;
    FCdsVendaBkp    : TUniClientDataSet;
    FArrMatItensBkp : TMatrizFechamento;
    frmConfirmando  : TfrmGravando;
    frmCalculando   : TfrmGravando;

    FInfUltimoCalculoTotal   : TRecInfUltimoCalculoTotal;
    FInformacaoProcessamento : String;
    FStepsProcessamento      : Integer;
    FRandomSteps             : Boolean;

    procedure pAjustarAlturaTela;

    procedure pReiniciarVariaveisCondicaoPagamento();
    function fValidarDigitacaoCondicaoPagamento(): Boolean;
    procedure pValidarCondicaoPagamentoAoIniciarTelaFechamento;
    procedure pAtualizarInformacoesCondicaoPagamento;
    function fTeveAlteracaoNaCondicaoPagamento(): Boolean;
    function fAtualizarCondicaoPagamento(pgbProgresso: TcxProgressBar): Boolean;

    procedure pAtribuirVariaveisParaObjVenda;
    procedure pAtualizarInformacoesUltimoCalculoTotalVenda();
    procedure pAtualizaTotalizacao;

    procedure pSalvaVariaveisPagamento;
    procedure pRestauraVariaveisPagamento;

    procedure pCalcularTotalPedido(AInformacao: String = ''; ASteps: Integer = 1; AForcarCalculo: Boolean = False);

    function fTeveAlteracaoQueInfluenciaNoTotalVenda(): Boolean;

    function fCalcularTotalPedido(pgbProgresso: TcxProgressBar): Boolean;

    procedure pOnProcessaItem(const item: TDadosFechamento; index, count: Integer; AInfo: String = '');

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public

    objVenda    : TFatVenda;
    blnConfirma : Boolean;

    fAtualizarDadosCondicaoPagamento: function(fraDigCndPagamento: TfraDigCndPagamento; blnValidacoes: Boolean = True): Boolean of object;

    fRealizarValidacoesFechamento: function(): Boolean of object;

    fRealizaFechamentoVenda: function(): Boolean of object;

    pAlteraEnderecoEntrega: procedure(
      const blnValidarClienteSeguradora: Boolean = True) of object;

    pAfterCalcTotGer: procedure() of object;

  end;

var
  frmFatDadosFechamentoVenda: TfrmFatDadosFechamentoVenda;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

function TfrmFatDadosFechamentoVenda.fAtualizarCondicaoPagamento(pgbProgresso: TcxProgressBar): Boolean;
begin

  pgbProgresso.Visible := False;

  If Assigned(frmConfirmando) Then
    frmConfirmando.Repaint;

  Result := fraPagamento.fConfirmaDados And fAtualizarDadosCondicaoPagamento(fraPagamento);

end;

function TfrmFatDadosFechamentoVenda.fCalcularTotalPedido(pgbProgresso: TcxProgressBar): Boolean;
begin

  pAtualizarInformacoesCondicaoPagamento;

  objVenda.pCalculaTotGer(False, True, pOnProcessaItem);

  pAtualizarInformacoesUltimoCalculoTotalVenda();

  pAtualizaTotalizacao;

  If Assigned(pAfterCalcTotGer) Then
    pAfterCalcTotGer;

  Result := True;

end;

procedure TfrmFatDadosFechamentoVenda.FormActivate(Sender: TObject);
begin
  inherited;
  pValidarCondicaoPagamentoAoIniciarTelaFechamento;
end;

procedure TfrmFatDadosFechamentoVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  If gbPagamento.Visible Then
    fraPagamento.OnFormClose(Sender, Action);

  If (Action <> caNone) Then
    If (Not blnConfirma) Then
      If gbPagamento.Visible Then
      Begin
        pReiniciarVariaveisCondicaoPagamento();
        pRestauraVariaveisPagamento;
      End;

end;

procedure TfrmFatDadosFechamentoVenda.FormCreate(Sender: TObject);
begin
  inherited;

  gbPagamento.Visible := fCfgSis('CNDVEN') = 'F';

  If gbPagamento.Visible Then
  Begin
    fraPagamento.OnFormCreate(Sender);
    fraPagamento.blnAutoHeight := False;
  End;

  gbTransportadora.Visible       := False;
  gbObra.Visible                 := False;
  gbBombeamento.Visible          := False;
  gbExpedicao.Visible            := False;
  gbCentroDeCusto.Visible        := False;
  gbDadosFechamentoVenda.Visible := False;
  gbPlanContas.Visible           := False;
  gbImpostos.Visible             := False;
  gbProjeto.Visible              := False;
  gbTipoDeFaturamento.Visible    := False;
  gbGravarContas.Visible         := False;

end;

procedure TfrmFatDadosFechamentoVenda.FormShow(Sender: TObject);
begin
  inherited;

  FCdsVendaBkp      := fCriaTemporaria(Self);
  FCdsVendaBkp.Data := cdsVenda.Data;
  FBackupVar        := TObjectBackupVar.Create(objVenda);

  If gbPagamento.Visible Then
  Begin
    fraPagamento.blnEstaNaNovaTelaDeFechamento := True;
    fraPagamento.OnFormShow(Sender);
  End;

  If gbTransportadora.Visible Then
    fraDadosFechamentoVendaTransportadoraFrame.OnFormShow;

  pAjustarAlturaTela;

end;

function TfrmFatDadosFechamentoVenda.fTeveAlteracaoNaCondicaoPagamento: Boolean;
begin

  Result := True;
  If (FInfUltimoCalculoTotal.strCodCnd = fraPagamento.edtCodCnd.Text) And
     (FInfUltimoCalculoTotal.strConPag = fraPagamento.mskCndPag.Text) And
     (FInfUltimoCalculoTotal.strCodFpg = fraPagamento.edtForPag.Text) And
     (FInfUltimoCalculoTotal.blnZerTax = fraPagamento.chkZerTax.Checked) Then
  Begin
    Result := False;
  End;

end;

function TfrmFatDadosFechamentoVenda.fTeveAlteracaoQueInfluenciaNoTotalVenda: Boolean;
begin

  Result := True;

  If (FInfUltimoCalculoTotal.fltValFre = objVenda.fltValFre) And
     (FInfUltimoCalculoTotal.fltDesAce = objVenda.fltDesAce) And
     (FInfUltimoCalculoTotal.strTipOpe = objVenda.strTipOpe) And
     (FInfUltimoCalculoTotal.strTipPed = objVenda.strTipPed) And
     (FInfUltimoCalculoTotal.fltTotBom = objVenda.fltTotBom) And
     (FInfUltimoCalculoTotal.strUfTrib = objVenda.fUFsDestTribItems) Then
  Begin
    Result := False;
  End;

end;

function TfrmFatDadosFechamentoVenda.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := (inherited fValidaCampos(Sender, blnBuscaPorChave));

  If Result And gbPagamento.Visible Then
    Result := fraPagamento.fValidaCampos(Sender, blnBuscaPorChave);

end;

function TfrmFatDadosFechamentoVenda.fValidarDigitacaoCondicaoPagamento: Boolean;
begin

  If Not gbPagamento.Visible Then
    Exit(True);

  If fraPagamento.blnConfirma And
    Not fTeveAlteracaoNaCondicaoPagamento Then
      Exit(True);

  pReiniciarVariaveisCondicaoPagamento();
  pAtribuirVariaveisParaObjVenda;

  pCriarFormularios(TfrmGravando, frmConfirmando);
  Try
    frmConfirmando.lblGravando.Caption := 'Aguarde, Validando dados de pagamento ...';
    frmConfirmando.fExecutarAcao := fAtualizarCondicaoPagamento;
    frmConfirmando.ShowModal;
    fraPagamento.blnConfirma := frmConfirmando.blnConfirma;

    If Not fraPagamento.blnConfirma Then
      Exit(False);

    pAtualizarInformacoesUltimoCalculoTotalVenda();

    pAtualizaTotalizacao;

    //sfraDadosPedido.OnAlterouCondicaoPagamento;
    //fraLiberacaoPedido.OnAlterouCondicaoPagamento;
    //pAjustarAlturaTela;

    Result := True;
  Finally
    pFreeAndNil(frmConfirmando);
  End;

end;

procedure TfrmFatDadosFechamentoVenda.pAjustarAlturaTela;
Const
  intGordurinha = 50;
Var
  intHeightEsq: Integer;
  intHeightDir: Integer;
begin

  intHeightEsq := 0;
  intHeightDir := 0;

  {Pagamento}
  intHeightEsq := intHeightEsq + IIF(gbPagamento.Visible, fRetornaSomaAlturaDosPaineisVisiveisEm(fraPagamento.pnlFundo), 0);

  {Transportadora}
  intHeightEsq := intHeightEsq + IIF(gbTransportadora.Visible, gbTransportadora.Height, 0);

  {Obra}
  intHeightEsq := intHeightEsq + IIF(gbObra.Visible, gbObra.Height, 0);

  {Bombeamento}
  intHeightEsq := intHeightEsq + IIF(gbBombeamento.Visible, gbBombeamento.Height, 0);

  {Expedição}
  intHeightEsq := intHeightEsq + IIF(gbExpedicao.Visible, gbExpedicao.Height, 0);

  {Centro de Custo}
  intHeightEsq := intHeightEsq + IIF(gbCentroDeCusto.Visible, gbCentroDeCusto.Height, 0);

  {Classificação Fiscal / Mensagem}
  intHeightEsq := intHeightEsq + IIF(gbDadosFechamentoVenda.Visible, gbDadosFechamentoVenda.Height, 0);

  {Plano de Contas}
  intHeightDir := intHeightDir + IIF(gbPlanContas.Visible, gbPlanContas.Height, 0);

  {Impostos}
  intHeightDir := intHeightDir + IIF(gbImpostos.Visible, gbImpostos.Height, 0);

  {Projeto do Cliente}
  intHeightDir := intHeightDir + IIF(gbProjeto.Visible, gbProjeto.Height, 0);

  {Tipo do Faturamento}
  intHeightDir := intHeightDir + IIF(gbTipoDeFaturamento.Visible, gbTipoDeFaturamento.Height, 0);

  {Gravar Contas}
  intHeightDir := intHeightDir + IIF(gbGravarContas.Visible, gbGravarContas.Height, 0);

  Self.ClientHeight := Max(intHeightEsq, intHeightDir) + (intGordurinha + pnlBotoes.Height);

end;

procedure TfrmFatDadosFechamentoVenda.pAtribuirVariaveisParaObjVenda;
begin
  {
  If fraTransportadora.Visible Then
  Begin
    objVenda.fltValFre := fStrToFloat(fraTransportadora.edtValFre.Text);
    objVenda.fltDesAce := fStrToFloat(fraTransportadora.edtDesAce.Text);
  End;

  If fraDadosPedido.pnlBombeamento.Visible Then
  Begin
    objVenda.fltTotBom := fStrToFloat(fraDadosPedido.edtTotBom.Text);
  End;

  objVenda.strTipOpe := fraDadosPedido.edtTipOpe.Text;
  objVenda.strTipPed := fraDadosPedido.edtTipFat.Text;
  }
end;

procedure TfrmFatDadosFechamentoVenda.pAtualizarInformacoesCondicaoPagamento;
begin

  If gbPagamento.Visible Then
  Begin
    objVenda.pAtualizaInformacoesCondPagamento;
    objVenda.pCalculaTaxVpr;
    objVenda.blnTaxVpr := True;
    objVenda.blnDeCndF := True;
    If fraPagamento.chkZerTax.Checked Then
    Begin
      objVenda.fltTaxVpr := 0;
      objVenda.blnTaxVpr := False;
    End;
  End;

end;

procedure TfrmFatDadosFechamentoVenda.pAtualizarInformacoesUltimoCalculoTotalVenda;
begin
  //Condicao de pagamento
  If gbPagamento.Visible Then
  Begin
    FInfUltimoCalculoTotal.strCodCnd := fraPagamento.edtCodCnd.Text;
    FInfUltimoCalculoTotal.strConPag := fraPagamento.mskCndPag.Text;
    FInfUltimoCalculoTotal.strCodFpg := fraPagamento.edtForPag.Text;
    FInfUltimoCalculoTotal.blnZerTax := fraPagamento.chkZerTax.Checked;
  End;
  //Dados da tela
  FInfUltimoCalculoTotal.fltValFre := objVenda.fltValFre;
  FInfUltimoCalculoTotal.fltDesAce := objVenda.fltDesAce;
  FInfUltimoCalculoTotal.strTipOpe := objVenda.strTipOpe;
  FInfUltimoCalculoTotal.strTipPed := objVenda.strTipPed;
  FInfUltimoCalculoTotal.fltTotBom := objVenda.fltTotBom;
  FInfUltimoCalculoTotal.strUfTrib := objVenda.fUFsDestTribItems;
end;

procedure TfrmFatDadosFechamentoVenda.pAtualizaTotalizacao;
begin
{
  lblTotalProdutos.Caption    := FormatFloat(fMskDigitos(2), objVenda.fltTotPro);

  If objVenda.fltTotSer > 0 Then
  Begin
    lblTitProdutos.Caption    := '    Total dos Produtos/Serviços:';
    lblTotalProdutos.Caption  := FormatFloat(fMskDigitos(2), objVenda.fltTotPro + objVenda.fltTotSer);
  End;

  If objVenda.fltDesEsp > 0 Then
    lblDescontoEspecial.Caption := FormatFloat(fMskDigitos(2), objVenda.fltDesEsp)
  Else
  Begin
    lblDescontoEspecial.Visible := False;
    lblTitDescontoEspecial.Visible := False;
    lblTitProdutos.Top := lblDescontoEspecial.Top;
    lblTotalProdutos.Top := lblDescontoEspecial.Top;
  End;

  lblDespesaAcessoria.Caption := FormatFloat(fMskDigitos(2), objVenda.fltDesAce);
  lblFrete.Caption            := FormatFloat(fMskDigitos(2), objVenda.fltValFre);
  lblIPI.Caption              := FormatFloat(fMskDigitos(2), objVenda.fltTotIpi);
  lblST.Caption               := FormatFloat(fMskDigitos(2), objVenda.fltTotRet);
  lblFCPST.Caption            := FormatFloat(fMskDigitos(2), objVenda.fltTotFcpST);
  lblTotalComImpostos.Caption := FormatFloat(fMskDigitos(2), objVenda.fltTotGer);
}
end;

procedure TfrmFatDadosFechamentoVenda.pCalcularTotalPedido(AInformacao: String; ASteps: Integer; AForcarCalculo: Boolean);
begin

  If Not AForcarCalculo Then
    If fCheckParent(ActiveControl, fraPagamento) Then
      Exit;

  pAtribuirVariaveisParaObjVenda;

  If Not AForcarCalculo Then
    If Not fTeveAlteracaoQueInfluenciaNoTotalVenda Then
      Exit;

  If AInformacao.IsEmpty Then
    AInformacao := 'Calculando total dos produto(s) (%s)';

  FInformacaoProcessamento := 'Aguarde, ' + AInformacao + ' ...';

  FStepsProcessamento := ASteps;
  FRandomSteps        := ASteps = 0;

  If FRandomSteps Then
    FStepsProcessamento := 1;

  pCriarFormularios(TfrmGravando, frmCalculando);

  Try
    frmCalculando.lblGravando.Caption := AInformacao;
    frmCalculando.fExecutarAcao := fCalcularTotalPedido;
    frmCalculando.ShowModal;
  Finally
    pFreeAndNil(frmCalculando);
  End;

end;

procedure TfrmFatDadosFechamentoVenda.pOnProcessaItem(const item: TDadosFechamento; index, count: Integer; AInfo: String = '');
Var
  LPos: Integer;
  LMax: Integer;
  blnProgresso : Boolean;
begin

  If Assigned(frmCalculando) Then
  Begin

    LPos := Succ(Index);
    LMax := Count -1;

    blnProgresso := (LPos Mod FStepsProcessamento = 0);

    If Not blnProgresso Then
      blnProgresso := (LPos = LMax);

    If (blnProgresso) Then
    Begin
      If AInfo.IsEmpty Or FRandomSteps Then
        AInfo := FInformacaoProcessamento;

      pInformacao(Format(AInfo, [item.strCodIte + '-' + fPadR(item.strDesIte, 10)]), frmCalculando.pgbStatus);
      pProgresso(LPos, LMax, frmCalculando.pgbStatus);

      If FRandomSteps Then
        FStepsProcessamento := RandomRange(1, 10);

    End;

  End;

end;

procedure TfrmFatDadosFechamentoVenda.pReiniciarVariaveisCondicaoPagamento;
begin

  fraPagamento.blnConfirma := False;
  objVenda.fltTaxJur := 0;
  objVenda.fltTaxVpr := 0;
  objVenda.blnTaxVpr := False;
  objVenda.blnDeCndF := False;
  objVenda.arrMatItens := FArrMatItensBkp;

  //cdsVenda.CloneData(FCdsVendaBkp);
  cdsVenda.LogChanges := False;
  objVenda.pFormataDecimaisGrid(cdsVenda);

end;

procedure TfrmFatDadosFechamentoVenda.pRestauraVariaveisPagamento;
begin
  FBackupVar.GetBackupVar(['strCodCnd', 'strConPag', 'strCodFpg']);
end;

procedure TfrmFatDadosFechamentoVenda.pSalvaVariaveisPagamento;
begin
  FBackupVar.SetBackupVar(['strCodCnd', 'strConPag', 'strCodFpg']);
end;

procedure TfrmFatDadosFechamentoVenda.pValidarCondicaoPagamentoAoIniciarTelaFechamento;
begin

  pSalvaVariaveisPagamento;

  If objVenda.strNumOrc.IsEmpty Then
    Exit;

  If Not gbPagamento.Visible Then
    Exit;

  If fEmptyStr(fraPagamento.edtCodCnd.Text) Then
    Exit;

  If fEmptyStr(fraPagamento.mskCndPag.Text) Then
    Exit;

  If fEmptyStr(fraPagamento.edtForPag.Text) Then
    Exit;

  If Not fValidarDigitacaoCondicaoPagamento() Then
    pSetFocus(fraPagamento.edtCodCnd);

  pCalcularTotalPedido();

end;

end.
