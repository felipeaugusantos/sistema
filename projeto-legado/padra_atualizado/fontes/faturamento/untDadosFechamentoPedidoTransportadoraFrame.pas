unit untDadosFechamentoPedidoTransportadoraFrame;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, Windows,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, strUtils,
  ExtCtrls, EditFocus, QColorLabel, untFuncFat, Uni, AppEvnts, Mask,
  MaskEditFocus, BitBtnLockedIncrem, DBCtrls, DBLookupComboBoxFocus,
  cxHint, TypInfo, DBEditFocus, ComboBoxFocus, dxScreenTip, cxClasses,
  dxCustomHint, frxClass, frxExportCSVTestabilidade, untFuncFatTypes, untLiberacao,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxGroupBox, untValidacoesFrete;

type
  TfraDadosFechamentoPedidoTransportadoraFrame = class(TFrame)
    pnlFundo: TPanel;
    pnlTransportadora: TGroupBox;
    pnlTraRedesp: TPanel;
    Label9: TLabel;
    edtTraRedCod: TEditFocus;
    edtTraRedNom: TEditFocus;
    pnlPeso: TPanel;
    lbl3: TLabel;
    lbl4: TLabel;
    lblEdiPes: TLabel;
    edtPesLiq: TEditFocus;
    edtPesBru: TEditFocus;
    pnlTransportadoraFrete: TPanel;
    lblValFre: TLabel;
    Label4: TLabel;
    Label23: TLabel;
    lblQtdTra: TLabel;
    lblEspVol: TLabel;
    btnCalcVolume: TSpeedButton;
    btnCalcFreSug: TSpeedButton;
    edtValFre: TEditFocus;
    edtDesAce: TEditFocus;
    edtQtdTra: TEditFocus;
    edtEspVol: TEditFocus;
    cmbTipFre: TComboBoxFocus;
    btnDespesasFaturamento: TBitBtnLocked;
    pnlRota: TPanel;
    edtCodRot: TEditFocus;
    lblRota: TLabel;
    tmrHideHints: TTimer;
    HintControler: TcxHintStyleController;
    Label7: TLabel;
    edtNumReg: TEditFocus;
    btnCalcularFrete: TBitBtnLocked;
    Label2: TLabel;
    edtCodTra: TEditFocus;
    edtNomTra: TEditFocus;
    edtValFreCot: TEditFocus;
    lblValFreCot: TLabel;
    pnlTransportadoraFreteAux: TPanel;
    pnlVolumeSepExc: TPanel;
    lblQtdTraSepExc: TLabel;
    edtQtdTraSepExc: TEditFocus;
    edtQtdTraSepNExc: TEditFocus;
    lblQtdTraSepNExc: TLabel;
    procedure edtCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure edtQtdTraKeyPress(Sender: TObject; var Key: Char);
    procedure btnCalcFreSugClick(Sender: TObject);
    procedure btnCalcVolumeClick(Sender: TObject);
    procedure edtValFreEnter(Sender: TObject);
    procedure edtValFreExit(Sender: TObject);
    procedure tmrHideHintsTimer(Sender: TObject);
    procedure edtPesLiqKeyPress(Sender: TObject; var Key: Char);
    procedure edtPesLiqExit(Sender: TObject);
    procedure btnDespesasFaturamentoClick(Sender: TObject);
    procedure lblEdiPesClick(Sender: TObject);
    procedure edtCodRotKeyPress(Sender: TObject; var Key: Char);
    procedure edtTraRedCodKeyPress(Sender: TObject; var Key: Char);
    procedure edtValFreChange(Sender: TObject);
    procedure edtCodRotKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    objValidacoesFrete : TValidacoesFrete;
    blnIniciandoTela: Boolean;

    strCodTraAnt: String;
    strTipFreAnt: String;
    fltValFreAnt: Double;
    fltValFreAntTrava: Double;
    fltFreCotAnt: Double;
    qryConTra: TUniQuery;

    strTipOpeAnt: String;

    blnPesBruEna: Boolean;
    blnPesLiqEna: Boolean;
    blnPesBruRea: Boolean;
    blnPesLiqRea: Boolean;
    blnPesBruTab: Boolean;
    blnPesLiqTab: Boolean;

    strCodRotLib: String;

    stlRotLib: TStringList;

    objLiberacao: TLiberacao;

    blnZeraFrete: Boolean;
    blnLiberouTranspVaziaItensEntrega: Boolean;
    blnLiberouTranspVaziaItensRetira: Boolean;
    blnLiberouAlteraTranspOrcamento: Boolean;
    blnLiberouAlteraTranspItensRetira: Boolean;
    blnLiberouAlteraTranspItensEntrega: Boolean;

    procedure pOnShow;

    procedure pCarregaCadTra;

    procedure pAtualizaPesoBrutoLiquidoFatVenda;
    procedure pAbreTelaDigPesoProduto;
    function fTravaTransportadoraPoisJaFoiDefinido: Boolean;
    function fValidaRota(strCodRot: String; var dtaDtaEnt: TDateTime): Boolean;
    procedure pCalcVolumeSepExclusiva;
    function fCalculoDeFreteEhObrigatorio: Boolean;
    function fDocumentoComFretePelaFrenetOuQualp: Boolean;
    function fValidaFrete: Boolean;
    function fGetInputPassarZeroEmitenteCIF : TInputPassarZeroEmitenteCIF;
    function fSugestaoPorFaixaOuNumeroOrcamentoVazio : Boolean;
    function fVaiInformarRotaPorDataDeEntregaDoPedido: Boolean;
  public
    { Public declarations }

    blnCalcFreteSugestaoRegia: Boolean;
    blnCalcFreteSugestaoTranp: Boolean;
    blnCalcFreteSugestaoItens: Boolean;
    blnSomenExibirSugestFrete: Boolean;
    blnCalcFreteSugestaoFaixa: Boolean;
    blnTravaZerarFrete       : Boolean;

    strCodTra: String;
    objVenda: TFatVenda;
    qryDadosPedido: TUniQuery;
    fltVlrDesAce: Double;
    blnExigeCodRota: Boolean;

    procedure pCarregarDespesasAcessoriasImpostoDeImportacao;

    procedure pCarregarDespesasAcessorias(strTipoFaturamento: String);

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;

    procedure pCalculaFreteSugestao;

    procedure OnFormShow;
    procedure OnFormCreate;
    procedure OnFormDestroy;

    function fConfirmaDados: Boolean;
    function fRetCidadeEndEnt(strAutEnt: String): String;
  end;


implementation

uses untPesqAux, Data.DB, untTypesSistema, Math, untConsultas, untDigPedCmp,
     untTipoFreteAtc, untfuncoesSimples, untConstantes, untValidacoesRotasRegiao,
     untFatMostraItensFechamento, untCadClientes, untFuncoes, untPesoItem,
     untAdiantamentoClienteGenerico, untProjetos,
     Faturamento.Classes.TiposFretesPermitidosTransp;

{$R *.dfm}

procedure TfraDadosFechamentoPedidoTransportadoraFrame.pCarregarDespesasAcessorias(strTipoFaturamento: String);
  Var
    fltPerDesAce: Double;
    fltParDesAce: Double; //Valor por Condição a Prazo
    fltDesAceIPI: Double;
    strTipFat   : String;
begin
  edtDesAce.Text := FormatFloat('#,##0.00', objVenda.fltDeADig);

  If (objVenda.strCodFpg = '016') And
     (objVenda.objFinanc.fRetDespesasAcessorias > 0) Then
  Begin
    edtDesAce.Text := FormatFloat('#,##0.00', objVenda.objFinanc.fRetDespesasAcessorias);
    edtDesAce.ReadOnly := True;
    edtDesAce.TabStop  := False;
  End
  Else If (objVenda.strCliDAc = 'S') And (Pos(objVenda.strOpcDoc, 'PD_OR_VN_') > 0) Then
  Begin
    fltVlrDesAce := 0;
    strTipFat    := IIF(fEmptyStr(strTipoFaturamento), fCfgSis('TIPFAT'),strTipoFaturamento);

    If fCobrarDespAcessCondPagto(objVenda.strCodCnd, objVenda.strCodCli, strTipFat) Then
    Begin
      fltVlrDesAce := fRetornaDesAceUnicoPorVenda(objVenda.strCodCnd);
      fltPerDesAce := fRetornaDesAceCnd(objVenda.strCodCnd);
      fltParDesAce := fRetornaDesAcePrazoCnd(objVenda.strCodCnd, objVenda.strConPag);

      If fltPerDesAce > 0 Then
        fltVlrDesAce := fltVlrDesAce + objVenda.fltTotPro * fltPerDesAce / 100.00;

      fltVlrDesAce := fltVlrDesAce + fltParDesAce;
    End;

    fltVlrDesAce := fltVlrDesAce + fCfgSis('VLDEAC', varDouble);

    If fltVlrDesAce > 0 Then
    Begin
      edtDesAce.Text := FormatFloat('#,##0.00', fltVlrDesAce);
      edtDesAce.ReadOnly := True;
      edtDesAce.TabStop  := False;
    End
    Else If fEmptyStr(objVenda.strNumOrc) Then
      edtDesAce.Text := '0,00';
  End
  Else
  Begin
    If fEmptyStr(edtDesAce.Text,True) Then
      edtDesAce.Text := '0,00';
    edtDesAce.Enabled := False;
    edtDesAce.TabStop  := False;
  End;

  If (objVenda.fltTotPro = 0) And (objVenda.fltTotSer > 0) Then
  Begin
    edtDesAce.Text := '0,00';
    edtDesAce.Enabled := False;
    edtDesAce.TabStop  := False;
  End;

  If Assigned(objVenda.objDespesasFaturamento) Then
  Begin
    edtDesAce.ReadOnly := True;
    edtDesAce.TabStop  := False;
    edtDesAce.Color    := $00FFDFB8;
    edtDesAce.Text     := FormatFloat('#,##0.00', objVenda.objDespesasFaturamento.fltValorTotal);
    btnDespesasFaturamento.Visible := True;

  End;

  If objVenda.blnTaxaBombeamentoPedOrc Then
  Begin
    edtDesAce.Enabled := False;
    edtDesAce.TabStop  := False;
    edtDesAce.Text    := '0,00';
    btnDespesasFaturamento.Visible := False;
  End;

  If edtDesAce.Enabled Then
  begin
    edtDesAce.Enabled := fCfgSis('ALDAVF', varBoolean);
    edtDesAce.ReadOnly := Not edtDesAce.Enabled;
    edtDesAce.TabStop  := edtDesAce.Enabled;
  end;

  If Not btnDespesasFaturamento.Visible Then
  Begin
    edtDesAce.Width := edtDesAce.Width + btnDespesasFaturamento.Width;
    btnDespesasFaturamento.Width := 0;
  End;

  fltDesAceIPI := objVenda.fValorTotalDeIpiComoDespesaAcessoria;
  If (fltDesAceIPI > 0) Then
    edtDesAce.Text := FormatFloat('#,##0.00', fltDesAceIPI);

  pCarregarDespesasAcessoriasImpostoDeImportacao;
end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.btnCalcFreSugClick(Sender: TObject);
begin
  inherited;
  If (objVenda.fPermitirFreteNoFaturamento) Then
  Begin
    pCalculaFreteSugestao;
    If (objVenda.fltTotPro - objVenda.fltDesEsp >= objVenda.fltVlMinF) Then
      edtValFre.Text := '0,00'
    Else If fMensagem('', 'Deseja carregar o valor do frete sugestão?', ['', '']) = 1 Then
      edtValFre.Text := FormatFloat('#,##0.00', objVenda.fRetFreSugCal);
  End;
end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.btnCalcVolumeClick(Sender: TObject);
begin
  inherited;
  edtQtdTra.Text := FloatToStrF(objVenda.fRetVolumes, ffFixed, 12, 0);
  If pnlVolumeSepExc.Visible Then
    pCalcVolumeSepExclusiva;
end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.pAtualizaPesoBrutoLiquidoFatVenda;
begin
  If pnlPeso.Visible Then
  Begin
    objVenda.fltPesBru := fStrToFloat(edtPesBru.Text);
    objVenda.fltPesLiq := fStrToFloat(edtPesLiq.Text);
  End;
end;

function TfraDadosFechamentoPedidoTransportadoraFrame.fConfirmaDados: Boolean;
begin
  inherited;
  Result := False;

  pAtualizaPesoBrutoLiquidoFatVenda;

  objVenda.strNumReg := edtNumReg.Text;
  objVenda.strCodTra := edtCodTra.Text;
  objVenda.strTraRdp := edtTraRedCod.Text;
  objVenda.fltValFre := fStrToFloat(edtValFre.Text);
  objVenda.fltFreDig := fStrToFloat(edtValFre.Text);
  objVenda.strTipFre := fTipoFrete(cmbTipFre.Text);

  if edtValFreCot.Visible then
    objVenda.fltFreCot := fStrToFloat(edtValFreCot.Text);

  objVenda.fltDesAce := fStrToFloat(edtDesAce.Text);
  objVenda.fltDeADig := fStrToFloat(edtDesAce.Text);

  If edtQtdTra.Visible Then
    objVenda.intQtdTra := StrToIntDef(edtQtdTra.Text, 0);

  If pnlVolumeSepExc.Visible Then
  Begin
    objVenda.intQtdTraSepExc  := StrToIntDef(edtQtdTraSepExc.Text, 0);
    objVenda.intQtdTraSepNExc := StrToIntDef(edtQtdTraSepNExc.Text, 0);
  End;

  objVenda.strEspTra := edtEspVol.Text;

  If pnlRota.Visible Then
  begin
    objVenda.strCodRot := edtCodRot.Text;
  end
  else if (not fEmptyStr(objVenda.strCodRot)) and (not objVenda.fTemItensEntregaImediata) then
  begin
    objVenda.strCodRot := '';
  end;

  objVenda.strNomTra := edtNomTra.Text;

  pCalculaFreteSugestao;

  If (Not blnSomenExibirSugestFrete) Then
  Begin
    If (blnCalcFreteSugestaoRegia) Or
       (blnCalcFreteSugestaoTranp) Or
       (blnCalcFreteSugestaoItens) Or
       (blnCalcFreteSugestaoFaixa) Then
    Begin
      If Not objVenda.fValidaFreteSugestao(objVenda.fltFreSug) Then
      Begin
        Exit;
      End;
    End;
  End;

  If (blnTravaZerarFrete) Then
  Begin
    If Not objVenda.fValidaFreteDigitado(fltValFreAntTrava) Then
    Begin
      Exit;
    End;
  End;

  If (Assigned(objValidacoesFrete)) And (Not objValidacoesFrete.PermitePassarComFreteZeroEmitenteCIF(fGetInputPassarZeroEmitenteCIF)) Then
  Begin
    Result := False;
    Exit;
  End;

  If fEmptyStr(objVenda.strNumOrc) Then
    objVenda.blnSetouTipoFreteSugestao := True;

  If (Not fValidaFrete) Then
    Exit;

  Result := True;
end;

function TfraDadosFechamentoPedidoTransportadoraFrame.fRetCidadeEndEnt(strAutEnt: String): String;

  function fRetSQL: String;
  Begin
    Result := '';
    Result := Result + ' SELECT ETC_CIDENT ';
    Result := Result + '   FROM ENTCLI     ';
    Result := Result + '  WHERE AUTOINCREM = :AUTINC ';
  End;

var
  qryCons: TUniQuery;
begin
  Result := '';
  If Not fEmptyStr(strAutEnt) Then
  Begin
    Try
      qryCons := fCriaQuery(Nil);
      With qryCons Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fRetSQL);
        ParamByName('AUTINC').AsString := strAutEnt;
        Open;

        Result := FieldByName('ETC_CIDENT').AsString;
      End;
    Finally
      FreeAndNil(qryCons);
    End;
  End;
end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.btnDespesasFaturamentoClick(Sender: TObject);
begin
  inherited;
  If btnDespesasFaturamento.Visible And Assigned(objVenda.objDespesasFaturamento) Then
  Begin
    objVenda.objDespesasFaturamento.pExibirDigitacaoDespesas;
    edtDesAce.Text := FormatFloat('#,##0.00', objVenda.objDespesasFaturamento.fltValorTotal);
    SelectNext(GetParentForm(self).ActiveControl, True, True);
  End;
end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.OnFormCreate;
  Var
    intTipFre: Integer;
begin
  inherited;
  cmbTipFre.Clear;
  For intTipFre In TiposFrete Do
    cmbTipFre.Items.Add(fDescricaoFrete(IntToStr(intTipFre)));

  strCodTra   := '';

  strTipOpeAnt := '';

  qryConTra := fCriarQuery('SELECT * FROM CADTRA WHERE FALSE', Self);

  stlRotLib := TStringList.Create;

  objLiberacao := TLiberacao.create;
  blnLiberouTranspVaziaItensEntrega := False;
  blnLiberouTranspVaziaItensRetira := False;
  blnLiberouAlteraTranspOrcamento := False;
  blnLiberouAlteraTranspItensRetira := False;
  blnLiberouAlteraTranspItensEntrega := False;

  fltVlrDesAce := 0;
end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.OnFormDestroy;
begin
  FreeAndNil(stlRotLib);
  FreeAndNil(objLiberacao);
  If (Assigned(objValidacoesFrete)) Then
    FreeAndNil(objValidacoesFrete);
  inherited;
end;

function TfraDadosFechamentoPedidoTransportadoraFrame.fSugestaoPorFaixaOuNumeroOrcamentoVazio: Boolean;
begin
  {***********************************************************************************}
  {* Se o cliente utiliza Sugestão de Frete por Faixa de Faturamento, quando o       *}
  {* operador carregar um orçamento salvo anteriormente o autcom tem que recalcular  *}
  {* o frete, pois o valor do orçamento pode ter sido alterado atingindo outra faixa,*}
  {* o que pode alterar o valor do frete.                                            *}
  {********************************************************************************MM*}
  Result := blnCalcFreteSugestaoFaixa;

  {***************************************************************}
  {* Se não usa sugestão por faixa, não deve recalcular o frete  *}
  {* quando carrega um orçamento salvo anteriormente.            *}
  {************************************************************MM*}
  If Not Result Then
    Result := fEmptyStr(objVenda.strNumOrc);
end;

function TfraDadosFechamentoPedidoTransportadoraFrame.fValidaRota(strCodRot: String; var dtaDtaEnt: TDateTime): Boolean;
var
  objRotReg : TRotReg;
begin
  objRotReg := nil;
  Try
    Try
      objRotReg           := TRotReg.Create(Self);
      objRotReg.strCodRot := strCodRot;
      objRotReg.fltPesBru := objVenda.fltPesBru;
      objRotReg.fltTotPro := objVenda.fltTotPro;
      objRotReg.strCodVen := objVenda.strCodVen;
      objRotReg.strCodDig := objVenda.strCodDig;
      objRotReg.strNumOrc := IIF(fEmptyStr(objVenda.strNumOrc),'',objVenda.strNumOrc + '-' + objVenda.strEspDoc + '-' + VS_strCodEmp);
      objRotReg.strCodCli := objVenda.strCodCli;
      objRotReg.strEspDoc := objVenda.strEspDoc;
      objRotReg.strSeqFgo := objVenda.strIncOrc;

      Result := objRotReg.fIniciaValidacoes;

      dtaDtaEnt := objRotReg.dtaDtaEnt;

      If Result Then
      Begin
        edtCodTra.Text := objRotReg.fRetTranspRota;
        edtNomTra.Text := fRetNomTransportadora(edtCodTra.Text);
      End;
    Except
      On E: Exception do
      Begin
        Result := False;
        pMensagensErro(E.Message,'[fValidaRota]');
      End;
    End;
  Finally
    objRotReg.Free;
  End;
end;

function TfraDadosFechamentoPedidoTransportadoraFrame.fVaiInformarRotaPorDataDeEntregaDoPedido: Boolean;
begin
  Result := False;

  If not objVenda.fEntregaImediataPorDataDeEntregaComRotaPorPedido Then
    Exit;
  If blnExigeCodRota Then
    Exit;
  Result := True;
end;

function TfraDadosFechamentoPedidoTransportadoraFrame.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    dtaDtaEnt  : TDateTime;
    strObgrot : String;
    strTipoItem: String;
    strMsgLiberacao: String;
begin

  Result := True;

  If (Sender = edtCodTra) Then
  Begin

    If (fEmptyStr(edtCodTra.Text)) Then
    Begin
      If (Not blnLiberouTranspVaziaItensEntrega) And (fCfgSis('SEMTRA', varBoolean)) And (objVenda.fTemItensEntregaImediata) And (Pos(objVenda.strOpcDoc, 'PD_OR_VN_') > 0) Then
      Begin
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddTexto('Limpar a transportadora quando houver itens de entrega imediata no Orçamento, Pedido ou Venda Normal.');
        objLiberacao.objMsgLibera.pAddSeparador(75);
        objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'                 , objVenda.strCodCli + '-' + fRetNomCliente(objVenda.strCodCli) , 24);
        objLiberacao.objMsgLibera.pAddTextoCaption('Valor do Documento'      , FormatFloat('#,##0.00', objVenda.fltTotGer)                   , 24);
        objLiberacao.objMsgLibera.pAddTextoCaption('Transportadora Anterior' , strCodTraAnt + '-' + fRetNomTransportadora(strCodTraAnt)            , 24);

        objLiberacao.strDirAce  := 'SEMTRA';
        objLiberacao.strMsgSen  := 'Limpar a transportadora quando houver itens de entrega imediata no Orçamento, Pedido ou Venda Normal.';
        objLiberacao.strCodOpe  := objVenda.strCodVen;
        objLiberacao.strCodDig  := objVenda.strCodDig;

        If Not objLiberacao.fLibera Then
        Begin
          edtNomTra.Clear;
          fMensagem('ATENÇÃO!', 'Transportadora não informada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          edtNomTra.Clear;
          blnLiberouTranspVaziaItensEntrega := True;
        End;
      End

      Else If (Not blnLiberouTranspVaziaItensRetira) And (fCfgSis('SERTRA', varBoolean)) And (objVenda.fTemItensRetira) And (Pos(objVenda.strOpcDoc, 'PD_OR_VN_') > 0) Then
      Begin
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddTexto('Limpar a transportadora quando houver itens de retira no Orçamento, Pedido ou Venda Normal.');
        objLiberacao.objMsgLibera.pAddSeparador(75);
        objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'                 , objVenda.strCodCli + '-' + fRetNomCliente(objVenda.strCodCli) , 24);
        objLiberacao.objMsgLibera.pAddTextoCaption('Valor do Documento'      , FormatFloat('#,##0.00', objVenda.fltTotGer)                   , 24);
        objLiberacao.objMsgLibera.pAddTextoCaption('Transportadora Anterior' , strCodTraAnt + '-' + fRetNomTransportadora(strCodTraAnt)            , 24);

        objLiberacao.strDirAce  := 'SERTRA';
        objLiberacao.strMsgSen  := 'Limpar a transportadora quando houver itens de retira no Orçamento, Pedido ou Venda Normal.';
        objLiberacao.strCodOpe  := objVenda.strCodVen;
        objLiberacao.strCodDig  := objVenda.strCodDig;

        If Not objLiberacao.fLibera Then
        Begin
          edtNomTra.Clear;
          fMensagem('ATENÇÃO!', 'Transportadora não informada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          edtNomTra.Clear;
          blnLiberouTranspVaziaItensRetira := True;
        End;
      End

      Else
      Begin
        edtNomTra.Clear;
      End;

    End
    else
    if not fRetTransportadoraAtiva(edtCodTra.Text) then
    begin
      fMensagem('ATENÇÃO!', 'Transportadora está inativada!', ['&Ok']);
      Result := False;
    end
    Else
    Begin
      If (fCfgSis('PERATF', varBoolean)) And (fCfgSis('FRETRA', varString) = FRETRA_POR_FAIXA_FATURAMENTO) Then
      Begin
        If (Not objVenda.fVerificaTransportadoraVinculadaFreteFaixaFaturamento(edtCodTra.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Transportadora não atende a faixa de faturamento!', ['&Ok']);
          Result := False;
        End;
      End;

      If (Result) And (Not SameText(edtCodTra.Text, strCodTraAnt)) Then
      Begin
        If (Not blnLiberouAlteraTranspOrcamento) And (objVenda.strEspDoc = 'OR') Then
         Begin
          strTipoItem := '';
          If (objVenda.fTemItensEntregaImediata) And (fCfgSis('SATOIE', varBoolean)) Then
            strTipoItem := 'E'
          Else If (objVenda.fTemItensRetira) And (fCfgSis('SATOIR', varBoolean)) Then
            strTipoItem := 'R';

          If Not fEmptyStr(strTipoItem) Then
          Begin
            strMsgLiberacao := IIF(strTipoItem = 'E', 'entrega imediata', 'retira');

            objLiberacao.Clear;
            objLiberacao.objMsgLibera.pAddTexto('Alterar a transportadora quando houver itens de ' + strMsgLiberacao + ' no Orçamento.');
            objLiberacao.objMsgLibera.pAddSeparador(75);
            objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'                 , objVenda.strCodCli + '-' + fRetNomCliente(objVenda.strCodCli) , 24);
            objLiberacao.objMsgLibera.pAddTextoCaption('Valor do Documento'      , FormatFloat('#,##0.00', objVenda.fltTotGer)                   , 24);
            objLiberacao.objMsgLibera.pAddTextoCaption('Transportadora Anterior' , strCodTraAnt + '-' + fRetNomTransportadora(strCodTraAnt)      , 24);
            objLiberacao.objMsgLibera.pAddTextoCaption('Transportadora Atual'    , edtCodTra.Text + '-' + fRetNomTransportadora(edtCodTra.Text)  , 24);

            objLiberacao.strDirAce := IIF(strTipoItem = 'E', 'SATOIE', 'SATOIR');
            objLiberacao.strMsgSen := 'Alterar a transportadora quando houver itens de ' + strMsgLiberacao + ' no Orçamento.';
            objLiberacao.strCodOpe := objVenda.strCodVen;
            objLiberacao.strCodDig := objVenda.strCodDig;

            If Not objLiberacao.fLibera Then
            Begin
              edtCodTra.Text := strCodTraAnt;
              fMensagem('ATENÇÃO!', 'Transportadora não alterada!', ['&Ok']);
              Result := False;
            End
            Else
            Begin
              blnLiberouAlteraTranspOrcamento := True;
            End;
          End;
        End

        Else If (Not blnLiberouAlteraTranspItensRetira) And (fCfgSis('ALRTRA', varBoolean)) And (objVenda.fTemItensRetira) And (Pos(objVenda.strOpcDoc, 'PD_OR_VN_') > 0) And (Pos(objVenda.strEspDoc, 'PD_VN_FF_CF_') > 0) Then
        Begin
          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('Alterar a transportadora quando houver itens de retira no Pedido ou Venda Normal.');
          objLiberacao.objMsgLibera.pAddSeparador(75);
          objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'                 , objVenda.strCodCli + '-' + fRetNomCliente(objVenda.strCodCli) , 24);
          objLiberacao.objMsgLibera.pAddTextoCaption('Valor do Documento'      , FormatFloat('#,##0.00', objVenda.fltTotGer)                   , 24);
          objLiberacao.objMsgLibera.pAddTextoCaption('Transportadora Anterior' , strCodTraAnt + '-' + fRetNomTransportadora(strCodTraAnt)      , 24);
          objLiberacao.objMsgLibera.pAddTextoCaption('Transportadora Atual'    , edtCodTra.Text + '-' + fRetNomTransportadora(edtCodTra.Text)  , 24);

          objLiberacao.strDirAce  := 'ALRTRA';
          objLiberacao.strMsgSen  := 'Alterar a transportadora quando houver itens de retira no Pedido ou Venda Normal.';
          objLiberacao.strCodOpe  := objVenda.strCodVen;
          objLiberacao.strCodDig  := objVenda.strCodDig;

          If Not objLiberacao.fLibera Then
          Begin
            edtCodTra.Text := strCodTraAnt;
            fMensagem('ATENÇÃO!', 'Transportadora não alterada!', ['&Ok']);
            Result := False;
          End
          Else
          Begin
            blnLiberouAlteraTranspItensRetira := True;
          End;
        End

        Else If (Not blnLiberouAlteraTranspItensEntrega) And (fCfgSis('ALMTRA', varBoolean)) And (objVenda.fTemItensEntregaImediata) And (Pos(objVenda.strOpcDoc, 'PD_OR_VN_') > 0) And (Pos(objVenda.strEspDoc, 'PD_VN_FF_CF_') > 0) Then
        Begin
          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('Alterar a transportadora quando houver itens de entrega imediata no Pedido ou Venda Normal.');
          objLiberacao.objMsgLibera.pAddSeparador(75);
          objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'                 , objVenda.strCodCli + '-' + fRetNomCliente(objVenda.strCodCli) , 24);
          objLiberacao.objMsgLibera.pAddTextoCaption('Valor do Documento'      , FormatFloat('#,##0.00', objVenda.fltTotGer)                   , 24);
          objLiberacao.objMsgLibera.pAddTextoCaption('Transportadora Anterior' , strCodTraAnt + '-' + fRetNomTransportadora(strCodTraAnt)      , 24);
          objLiberacao.objMsgLibera.pAddTextoCaption('Transportadora Atual'    , edtCodTra.Text + '-' + fRetNomTransportadora(edtCodTra.Text)  , 24);


          objLiberacao.strDirAce  := 'ALMTRA';
          objLiberacao.strMsgSen  := 'Alterar a transportadora quando houver itens de entrega imediata no Pedido ou Venda Normal.';
          objLiberacao.strCodOpe  := objVenda.strCodVen;
          objLiberacao.strCodDig  := objVenda.strCodDig;

          If Not objLiberacao.fLibera Then
          Begin
            edtCodTra.Text := strCodTraAnt;
            fMensagem('ATENÇÃO!', 'Transportadora não alterada!', ['&Ok']);
            Result := False;
          End
          Else
          Begin
            blnLiberouAlteraTranspItensEntrega := True;
          End;
        End
      End;

      If Result Then
      Begin
        pCarregaCadTra;
        If qryConTra.FieldByName('TRA_CODTRA').IsNull Then
        Begin
          If (blnCalcFreteSugestaoTranp) Then
          Begin
            fMensagem('ATENÇÃO!', IIF(blnCalcFreteSugestaoTranp, fRetMsgTransportadoraNaoEncontrada(objVenda.fRetornaStrCodCidEntAtual),
                                                                 fRetMsgTransportadoraNaoEncontrada), ['&Ok']);
          End
          Else
          If (blnCalcFreteSugestaoRegia) Then
          Begin
            fMensagem('ATENÇÃO!', IIF(blnCalcFreteSugestaoRegia, fRetMsgTransportadoraNaoEncontrada(objVenda.fRetornaStrCodRegEntAtual, True),
                                                                 fRetMsgTransportadoraNaoEncontrada('', True)), ['&Ok']);
          End;

          Result := False;
        End
        Else If Not objVenda.blnTaxaBombeamentoPedOrc Then
        Begin
          If (objVenda.fPermitirFreteNoFaturamento) And (not blnZeraFrete) Then
          Begin
            If (blnCalcFreteSugestaoTranp Or blnCalcFreteSugestaoRegia) And (Not blnSomenExibirSugestFrete) And (blnBuscaPorChave) Then
            Begin
              pCalculaFreteSugestao;
              If (objVenda.fltTotPro - objVenda.fltDesEsp >= objVenda.fltVlMinF) Then
                edtValFre.Text := '0,00'
              Else If (fCfgSis('CARFRE', varString) = 'N') Or
                      (fMensagem('', 'Deseja carregar o valor do frete da transportadora selecionada?', ['','']) = 1) Then
              Begin
                edtValFre.Text := FloatToStrF(objVenda.fRetFreSugCal, ffNumber, 12, 2);
              End;
            End
            Else If (Not blnCalcFreteSugestaoRegia) And
                    (Not blnCalcFreteSugestaoTranp) And
                    (Not blnCalcFreteSugestaoItens) And
                    (Not blnCalcFreteSugestaoFaixa) And blnBuscaPorChave And
                    (((fStrToFloat(edtValFre.Text) = 0) And fEmptyStr(objVenda.strNumOrc)) Or
                    (Not SameText(edtCodTra.Text, strCodTraAnt))) Then
            Begin
              If (fCfgSis('CARFRE', varString) = 'N') Or
                 ((qryConTra.FieldByName('TRA_VALFRE').AsFloat > 0) And (fMensagem('', 'Deseja carregar o valor do frete da transportadora selecionada?' + #13#10 + 'Valor ' + FormatFloat('#0.00', qryConTra.FieldByName('TRA_VALFRE').AsFloat), ['','']) = 1)) Then
              Begin
                edtValFre.Text := FormatFloat('#0.00', qryConTra.FieldByName('TRA_VALFRE').AsFloat);
              End;
            End
            Else
            If ((blnCalcFreteSugestaoItens Or (blnCalcFreteSugestaoFaixa)) And
               (Not blnSomenExibirSugestFrete) And
               (Not SameText(edtCodTra.Text, strCodTraAnt)))Then
            Begin
              pCalculaFreteSugestao;
              If (objVenda.fltTotPro - objVenda.fltDesEsp >= objVenda.fltVlMinF) Then
                edtValFre.Text := '0,00'
              Else
                edtValFre.Text := FloatToStrF(objVenda.fltFreSug, ffNumber, 12, 2);
            End;

          End;
        End;
      End;
    End;

    If Result Then
    Begin
      strCodTraAnt := edtCodTra.Text;
      If blnBuscaPorChave Then
        fltValFreAntTrava := fStrToFloat(edtValFre.Text);
    End;

    If (fCfgSis('USALAL', varString) = 'S') And (btnCalcularFrete.Visible) Then
    Begin
      btnCalcularFrete.Enabled := (fCampoTabela('TRA_ETIDES', 'CADTRA', ['TRA_CODTRA'], [edtCodTra.Text]) = 'LALAMOVE');
    End;
  End

  Else If (Sender = edtTraRedCod) Then
  Begin
    If (fEmptyStr(edtTraRedCod.Text)) Then
      edtTraRedNom.Clear
    Else
    Begin
      edtTraRedNom.Text := fRetNomTransportadora(edtTraRedCod.Text);

      If fEmptyStr(edtTraRedNom.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Transportadora não está cadastrada!', ['&OK']);
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
      End
      {*********************************************************}
      {* SE CASO A VENDA FOR MAIOR QUE O VALOR DE CONFIGURAÇÃO *}
      {* DE INSEÇÃO DO FRETE, NÃO DEIXA COBRAR O FRETE.        *}
      {*******************************************************FC}
      Else If (fFormataFloat(fltValFreAnt, 2) <> fFormataFloat(fStrToFloat(edtValFre.Text,0), 2)) And
              (fFormataFloat(objVenda.fltTotPro - objVenda.fltDesEsp, 2) >= fFormataFloat(objVenda.fltVlMinF, 2)) And
              (fStrToFloat(edtValFre.Text) > 0.0) Then
      Begin
        If fMensagem('ATENÇÃO!', 'O Valor da venda é maior / igual ao valor mínimo para isenção da cobrança do frete. O que deseja fazer?'
                               , ['&Continuar e zerar o frete', '&Manter o frete digitado'], 1, False, 1, 210) = 1 Then
          edtValFre.Text := '0,00';
      End;

    End
    Else
      edtValFre.Text := '0,00';

    blnTravaZerarFrete  := objVenda.fTravaAoZerarFrete(fltValFreAntTrava, fStrToFloat(edtValFre.Text));

    fltValFreAnt := fStrToFloat(edtValFre.Text,0);

  End

  Else If (Sender = edtValFreCot) and (edtValFreCot.Visible) Then
  Begin

    If (Not fEmptyStr(edtValFreCot.Text)) Then
    Begin

      If fStrToFloat(edtValFreCot.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor do frete cotado deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
    End
    Else
      edtValFreCot.Text := '0,00';

    fltFreCotAnt := fStrToFloat(edtValFreCot.Text,0);
  End

  Else If (Sender = edtQtdTra) And (edtQtdTra.Visible) Then
  Begin
    If pnlVolumeSepExc.Visible Then
    Begin
      edtQtdTraSepNExc.Text := FloatToStrF(fStrToFloat(edtQtdTra.Text) - fStrToFloat(edtQtdTraSepExc.Text), ffFixed, 12, 0);

      If fStrToFloat(edtQtdTraSepNExc.Text) < 0.0 Then
      Begin
        pMensagemOk('O campo "Volume dos itens de Separação não Exclusiva" não pode ficar negativo. '+
          'Ajuste o Volume para poder continuar (ele deve ser maior ou igual ao volume dos itens '+
          'de separação exclusiva) ou revise as configurações de cálculo de volume, pois o volume '+
          'dos itens de separação exclusiva devem seguir as configurações de cálculo de volume do Sistema.');
        Result := False;
      End;

      If fStrToFloat(edtQtdTra.Text) <> (fStrToFloat(edtQtdTraSepExc.Text) + fStrToFloat(edtQtdTraSepNExc.Text)) Then
      Begin
        pMensagemOk('O Volume deve ser igual à soma dos campos "Volume dos itens de Separação Exclusiva" e '+
          '"Volume dos itens de Separação Não Exclusiva". Realize o ajuste do campo do volume para poder continuar.');
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtDesAce) And (edtDesAce.Enabled) Then
  Begin

    If (Not fEmptyStr(edtDesAce.Text)) Then
    Begin

      If (fStrtoFloat(edtDesAce.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor da despesa acessória deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End;

    End;

  End

  Else If (Sender = cmbTipFre) Then
  Begin

    If (Not fFreteValido(fTipoFrete(cmbTipFre.Text))) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe um Tipo de Frete válido:' +#13+
                            'Emitente(CIF), Destinatário(FOB) ou Terceiros', ['&O k']);
      Result := False;
    End
    Else If (Not fPermiteFreteProprio(fTipoFrete(cmbTipFre.Text))) Then
    Begin
      Result := False;
    End
    Else
    Begin
      If (fTipoFrete(cmbTipFre.Text) = '9') And (fStrToFloat(edtValFre.Text) > 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe um Tipo de Frete válido:' +#13+
                              'Emitente(CIF), Destinatário(FOB) ou Terceiros', ['&O k']);
        Result := False;
      End
      Else If objVenda.blnVendaPresencial And fCfgSis('FREPRE', varBoolean) Then
      Begin
        If (Not fCfgSis('FTVDPS', varBoolean)) And (fTipoFrete(cmbTipFre.Text) <> '9') And (fStrToFloat(edtValFre.Text) = 0) And (objVenda.strOpcDoc <> 'OF') Then
        Begin
          fMensagem('ATENÇÃO!', 'Quando não foi informado valor de frete na venda presencial, só é permitido informar o tipo de Frete: "Sem Frete"!', ['&O k']);
          Result := False;
        End;
      End;
    End;

    If Result And
      blnCalcFreteSugestaoFaixa And
      (fTipoFrete(cmbTipFre.Text) <> strTipFreAnt) And
      (not blnZeraFrete) Then
    Begin
      pCalculaFreteSugestao;
      If (objVenda.fltTotPro - objVenda.fltDesEsp >= objVenda.fltVlMinF) Then
        edtValFre.Text := '0,00'
      Else
        edtValFre.Text := FloatToStrF(objVenda.fltFreSug, ffNumber, 12, 2);
    End;

    If Not fTipoFretePermitidoTransportadora(edtCodTra.Text, fTipoFrete(cmbTipFre.Text)) Then
    Begin
      If Not objVenda.fLiberaTipoFreteNaoPermitidoTransportadora(edtCodTra.Text,  cmbTipFre.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O tipo de frete: "' + cmbTipFre.Text + '" ' + sLineBreak +
                              'não se encontra na lista de tipos de fretes permitidos para a transportadora.' + sLineBreak +
                              'Verifique o cadatro da transportadora.', ['&OK']);
        Result := False;
      End;
    End;

    If Result Then
      strTipFreAnt := fTipoFrete(cmbTipFre.Text)
  End

  Else If (Sender = edtCodRot) And pnlRota.Visible Then
  Begin
    If Not fEmptyStr(edtCodRot.Text) Then
    Begin

      If strCodRotLib <> edtCodRot.Text Then
      Begin
        If Not fValidaRota(edtCodRot.Text, dtaDtaEnt) Then
        Begin
          fMensagem('ATENÇÃO!', 'Rota não permitida!', ['&Ok']);
          Result := False;
          strCodRotLib := '';
        End
        Else
          strCodRotLib := edtCodRot.Text;
      End;

    End
    Else
    Begin
      If Not fVaiInformarRotaPorDataDeEntregaDoPedido Then
      Begin
        strObgrot :=  fCampoTabela('TRA_OBGROT', 'CADTRA', ['TRA_CODTRA'], [edtCodTra.text]);
        if ((fCfgSis('OBGROT', varString) = '1') or
            ((strObgRot = 'S') and (fCfgSis('OBGROT', varString) = '2'))) then
        begin
          fMensagem('ATENÇÃO!', 'O Campo Rota deve ser preenchido!', ['&O k']);
          Result := False;
        end;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.lblEdiPesClick(Sender: TObject);
begin
  inherited;
  pAbreTelaDigPesoProduto;
end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.pCarregaCadTra;
begin

  If ((Not blnCalcFreteSugestaoTranp) And (Not blnCalcFreteSugestaoRegia)) Or (fTravaTransportadoraPoisJaFoiDefinido) Then
    pPesquisaCadTra(qryConTra, qryConTra, edtCodTra.Text, 'S')
  Else
  Begin
    If (blnCalcFreteSugestaoRegia) Then
      pPesquisaCadTraRegFrete(qryConTra, qryConTra, edtCodTra.Text, objVenda.fRetornaStrCodRegEntAtual, 'S')
    Else
      pPesquisaCadTraCidFrete(qryConTra, qryConTra, edtCodTra.Text, objVenda.fRetornaStrCodCidEntAtual, 'S');
  End;

  With qryConTra Do
  Begin
    edtNomTra.Text := FieldByName('TRA_NOMTRA').AsString;
  End;

  If (fCfgSis('USALAL', varString) = 'S') And (btnCalcularFrete.Visible) Then
  Begin
    btnCalcularFrete.Enabled := (qryConTra.FieldByName('TRA_ETIDES').AsString = 'LALAMOVE');
  End;
end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.edtCodRotKeyPress(Sender: TObject; var Key: Char);
  Var
    arrRotReg : TConsultasArray;
begin
  inherited;

  If fPesqEntregasRotasRegiaoPdOr(GetParentForm(self) as TForm, edtCodRot, Nil, Nil, Key, arrRotReg, True,
      IIF(fEmptyStr(fRetCidadeEndEnt(objVenda.strAutEnt)),objVenda.strCodCid, fRetCidadeEndEnt(objVenda.strAutEnt)),
      IIF(fEmptyStr(fRetCidadeEndEnt(objVenda.strAutEnt)),objVenda.strCliCep, objVenda.strCepEnt),
      True,
      objVenda.fltPesBru,
      objVenda.strIncOrc) Then
  Begin
    If fValidaCampos(edtCodRot, True) Then
      Keybd_Event(VK_RETURN, 0, 0, 0);
  End;
end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.edtCodRotKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_BACK) Or (Key = VK_DELETE) Then
  Begin
    edtCodRot.Clear;
  End;
end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.edtCodTraKeyPress(Sender: TObject; var Key: Char);
Var
  arrTransp  : TConsultasArray;
  TipoConTra : TTipoConsultaTransportad;
  strCidReg  : String;
begin

  inherited;

  {************************************}
  {* NOVA CONSULTA DE TRANSPORTADORAS *}
  {*********************************RV*}
  If (blnCalcFreteSugestaoTranp) Then
  Begin
    TipoConTra := conTraCidFrete;
    strCidReg  := objVenda.fRetornaStrCodCidEntAtual;
  End
  Else If (blnCalcFreteSugestaoRegia) Then
  Begin
    TipoConTra := conTraRegFrete;
    strCidReg  := objVenda.fRetornaStrCodRegEntAtual;
  End
  Else
  Begin
    TipoConTra := conTraCompleta;
    strCidReg  := '';
  End;

  If fPesqTransportadora(TipoConTra, GetParentForm(self) as TForm, edtCodTra, edtNomTra, Nil, Key, arrTransp, True, strCidReg, 'S', objVenda.fltTotGer) Then
  Begin
    If fValidaCampos(edtCodTra, True) Then
      SelectNext(GetParentForm(self).ActiveControl, True, True);
  End;

end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.edtPesLiqExit(Sender: TObject);
begin
  inherited;
  pAtualizaPesoBrutoLiquidoFatVenda;
end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.edtPesLiqKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If CharInSet(Key, ['-']) Then
  Begin
    Key := #0;
  End;
end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.edtQtdTraKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If CharInSet(Key, [',', '.', '-']) Then
  Begin
    Key := #0;
  End;
end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.edtTraRedCodKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTra : TConsultasArray;
begin
  inherited;
  If fPesqTransportadora(conTraCompleta, GetParentForm(self) as TForm, edtTraRedCod, edtTraRedNom, Nil, Key, arrTra, True, 'S') Then
  Begin
    If fValidaCampos(edtTraRedCod, True) Then
      SelectNext(GetParentForm(self).ActiveControl, True, True);
  End;
end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.edtValFreChange(
  Sender: TObject);
begin
  objVenda.fltValFre := fStrToFloat(edtValFre.Text);
end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.edtValFreEnter(Sender: TObject);
begin
  inherited;
  pCalculaFreteSugestao;
  
  If blnSomenExibirSugestFrete Then
  Begin
    HintControler.ShowHint(Self.Left + edtValFre.Left + edtValFre.Width,
                           15 + Self.Top + edtValFre.Top + edtValFre.Height,
                           'Valor do frete sugestão: ' + FormatFloat('#,##0.00', objVenda.fltFreSug), '');
  End;
end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.pCalculaFreteSugestao;
begin
  If (blnCalcFreteSugestaoRegia Or
      blnCalcFreteSugestaoTranp Or
      blnCalcFreteSugestaoItens Or
      blnCalcFreteSugestaoFaixa) And
      (not blnZeraFrete) Then
  Begin
    objVenda.fltFreSugCal := 0;

    If (blnCalcFreteSugestaoTranp Or blnCalcFreteSugestaoRegia) Then
      objVenda.fCalculaSugestaoFreteTransportadora(edtCodTra.Text, True, blnCalcFreteSugestaoRegia)
    Else
    If blnCalcFreteSugestaoItens Then
      objVenda.fCalculaSugestaoFreteProdutos(edtCodTra.Text, True)
    Else
    If blnCalcFreteSugestaoFaixa Then
      objVenda.fCalculaSugestaoFreteFaixaFaturamento(edtCodTra.Text, cmbTipFre.Text);
  End;
end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.pCalcVolumeSepExclusiva;
begin
  edtQtdTraSepExc.Text  := FloatToStrF(objVenda.fRetVolumesSepExc, ffFixed, 12, 0);
  edtQtdTraSepNExc.Text := FloatToStrF(fStrToFloat(edtQtdTra.Text) - fStrToFloat(edtQtdTraSepExc.Text), ffFixed, 12, 0);
end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.edtValFreExit(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.pOnShow;
begin
  inherited;

  blnCalcFreteSugestaoRegia := (fCfgSis('FRETRA') = FRETRA_POR_TRANSPORTADORA_REGIAO);
  blnCalcFreteSugestaoTranp := (fCfgSis('FRETRA') = FRETRA_POR_TRANSPORTADORA_CIDADE);
  blnCalcFreteSugestaoItens := (fCfgSis('FRETRA') = FRETRA_POR_PRODUTOS_ADICIONAL_TRANSPORTADORA);
  blnCalcFreteSugestaoFaixa := (fCfgSis('FRETRA') = FRETRA_POR_FAIXA_FATURAMENTO);
  blnSomenExibirSugestFrete := (fCfgSis('SUGFRE') = '2');

  edtNumReg.Text := objVenda.strNumReg;

  If objVenda.blnCliFil Then
    edtValFre.ReadOnly := (Not fCfgSis('ALFRTR', varBoolean))
  Else
    edtValFre.ReadOnly := (Not fCfgSis('ALTFRE', varBoolean));

  edtValFre.ReadOnly := (edtValFre.ReadOnly) Or (Not objVenda.fPermitirFreteNoFaturamento);
  edtValFre.TabStop  := (Not edtValFre.ReadOnly);

  lblValFreCot.Visible := fCfgSis('SFRCPD', varBoolean);
  edtValFreCot.Visible := lblValFreCot.Visible;

  If (edtValFreCot.Visible) Then
    lblValFre.Caption := 'Frete à Cobrar:';

  lblQtdTra.Visible      := (objVenda.strEspDoc = 'PD') Or fCfgSis('VOLPED', varBoolean);
  edtQtdTra.Visible      := edtQtdTra.Visible;
  edtQtdTra.Visible      := edtQtdTra.Visible;
  btnCalcVolume.Visible  := edtQtdTra.Visible;

  pnlVolumeSepExc.Visible := edtQtdTra.Visible And fCfgSis('SEPEXC', varBoolean);

  If Not pnlVolumeSepExc.Visible Then
    pnlTransportadoraFrete.Height := pnlTransportadoraFrete.Height - pnlVolumeSepExc.Height;

  pnlPeso.Visible := fPermiteInformarPesoNoPedidoDeVenda And (objVenda.strEspDoc = 'PD');

  pnlTraRedesp.Visible := fCfgSis('UTTRDP', varBoolean);

  If pnlPeso.Visible Then
  Begin
    If (Not fEmptyStr(objVenda.strNumOrc)) And
       Assigned(qryDadosPedido) And (Not qryDadosPedido.IsEmpty) Then
    Begin
      objVenda.fltPesBru := qryDadosPedido.FieldByName('FGO_PESBRU').AsFloat;
      objVenda.fltPesLiq := qryDadosPedido.FieldByName('FGO_PESLIQ').AsFloat;
    End;

    objVenda.pCalculaPesBruLiq(True);
    edtPesBru.Text := FormatFloat('#,##0.000', objVenda.fltPesBru);
    edtPesLiq.Text := FormatFloat('#,##0.000', objVenda.fltPesLiq);
  End;

  If fEmptyStr(objVenda.strNumOrc) Or (objVenda.intQtdTra = 0) Then
  Begin
    If fCfgSis('CALVOL', varBoolean) Then
    Begin
      edtQtdTra.Text := FloatToStrF(objVenda.fRetVolumes, ffFixed, 12, 0);
      If pnlVolumeSepExc.Visible Then
        pCalcVolumeSepExclusiva;
    End
    Else
    Begin
      edtQtdTra.Text := '0';
      edtQtdTraSepExc.Text  := '0';
      edtQtdTraSepNExc.Text := '0';
    End;
  End
  Else
  Begin
    If (Floor(objVenda.fRetVolumes) <> objVenda.intQtdTra) And fCfgSis('CALVOL', varBoolean) Then
      objVenda.pTratarDiferencaVolumeCalculadoComDigitado;

    edtQtdTra.Text := FloatToStrF(objVenda.intQtdTra, ffFixed, 12, 0);
    If pnlVolumeSepExc.Visible Then
    Begin
      edtQtdTraSepExc.Text  := FloatToStrF(objVenda.intQtdTraSepExc, ffFixed, 12, 0);
      edtQtdTraSepNExc.Text := FloatToStrF(objVenda.intQtdTraSepNExc, ffFixed, 12, 0);
    End;
  End;

  edtEspVol.Text := objVenda.strEspTra;

  {*****************************************}
  {* CARREGA EDITS                         *}
  {**************************************MV*}
  If (Not fEmptyStr(objVenda.strNumOrc)) Then
  Begin
    edtCodTra.Text := objVenda.strCodTra;
  End
  Else If (Not fEmptyStr(strCodTra)) Then
  Begin
    edtCodTra.Text := strCodTra;
  End
  Else
  Begin
    If (Not fEmptyStr(fCfgSis('TRASUG'))) Then
      edtCodTra.Text := fCfgSis('TRASUG');
  End;

  If (fTravaTransportadoraPoisJaFoiDefinido) And
     (Not fEmptyStr(edtCodTra.Text)) Then
    edtCodTra.Enabled := False;

  edtTraRedCod.Text := objVenda.strTraRdp;
  fValidaCampos(edtTraRedCod);

  pCarregaCadTra;

  If (Not blnCalcFreteSugestaoTranp) And
     (Not blnCalcFreteSugestaoRegia) And
     (Not blnCalcFreteSugestaoItens) And
     (Not blnCalcFreteSugestaoFaixa) And
     (Not fEmptyStr(edtCodTra.Text)) Then
  Begin
    If fEmptyStr(objVenda.strNumOrc) Then
    Begin
      If (objVenda.fltFreDig <= 0) Then
        objVenda.fltFreDig := qryConTra.FieldByName('TRA_VALFRE').AsFloat;
    End
    Else
    Begin
      If (objVenda.fltFreDig <= 0) And (objVenda.fTemItensEntrega(objVenda.arrMatItens)) And (qryConTra.FieldByName('TRA_VALFRE').AsFloat > 0) Then
      Begin
        If fMensagem('ATENÇÃO!', 'Foi detectado itens com entrega!' + #10#13 +
                                  'Deseja carregar o frete de R$ '+FormatFloat(',0.00', qryConTra.FieldByName('TRA_VALFRE').AsFloat)+'?', ['&Sim', '&Não']) = 1 Then
          objVenda.fltFreDig := qryConTra.FieldByName('TRA_VALFRE').AsFloat;
      End;
    End;
  End;

  edtValFre.Text := IfThen(Not objVenda.fPermitirFreteNoFaturamento, '0,00', FormatFloat('#,##0.00', objVenda.fltFreDig));
  edtValFreCot.Text := FormatFloat('#,##0.00', objVenda.fltFreCot);

  If objVenda.strTipFre.IsEmpty Then
    objVenda.strTipFre := fCfgSis('TIPFRE');

  cmbTipFre.ItemIndex   := cmbTipFre.Items.IndexOf(fDescricaoFrete(objVenda.fGetTipoFreteSugestao));
  cmbTipFre.Enabled     := objVenda.fPermitirFreteNoFaturamento;

  btnCalcFreSug.Visible := False;

  If (blnCalcFreteSugestaoItens Or
      blnCalcFreteSugestaoRegia Or
      blnCalcFreteSugestaoTranp Or
      blnCalcFreteSugestaoFaixa) And
     (Not blnSomenExibirSugestFrete) And
     (objVenda.fPermitirFreteNoFaturamento) Then
  Begin
    btnCalcFreSug.Visible := (Not edtValFre.ReadOnly);

    If fSugestaoPorFaixaOuNumeroOrcamentoVazio And (Pos(objVenda.strOpcDoc, 'CF_CI_CT_CP_') <= 0) Then
    Begin
      pCalculaFreteSugestao;
      If (objVenda.fltTotPro - objVenda.fltDesEsp >= objVenda.fltVlMinF) Then
        edtValFre.Text := '0,00'
      Else
        edtValFre.Text := FloatToStrF(objVenda.fltFreSug, ffNumber, 12, 2);
    End;
  End;

  blnZeraFrete := (fCfgSis('ZERFRE', varBoolean)) and (objVenda.fPossuiSomenteItensRetira);

  If (blnZeraFrete) Then
  Begin
    edtValFre.Text := '0,00';
    edtValFre.Enabled := False;
    objVenda.blnZerouFrete_CFG_ZERFRE := True;
  End
  Else
    objVenda.blnZerouFrete_CFG_ZERFRE := False;

  pCarregarDespesasAcessorias(objVenda.strTipPed);

  If objVenda.blnTaxaBombeamentoPedOrc Then
  Begin
    edtValFre.Enabled := False;
    edtValFre.Text    := '0,00';
    btnCalcFreSug.Visible := False;
  End;

  If (objVenda.fltTotPro = 0) And (objVenda.fltTotSer > 0) Then
  Begin
    edtValFre.Text := '0,00';
    edtValFre.Enabled := False;
  End;

  blnPesBruEna := edtPesBru.Enabled;
  blnPesLiqEna := edtPesLiq.Enabled;
  blnPesBruRea := edtPesBru.ReadOnly;
  blnPesLiqRea := edtPesLiq.ReadOnly;
  blnPesBruTab := edtPesBru.TabStop;
  blnPesLiqTab := edtPesLiq.TabStop;

  If (objVenda.strEdiPes = 'E') And (pnlPeso.Visible) Then
  Begin
    edtPesBru.readOnly := True;
    edtPesLiq.readOnly := True;
    edtPesBru.TabStop  := False;
    edtPesLiq.TabStop  := False;
  End;

  {**********************************************}
  {* VERIFICA SE UTILIZA A CONFIGURAÇÃO DA ROTA *}
  {* E REALIZA OS DEVIDOS TRATAMENTOS       :-) *}
  {******************************************TS**}
  strCodRotLib      := '';
  pnlRota.Visible := False;

  If (objVenda.fTemItensEntregaImediata) Then
  Begin
    pnlRota.Visible := fCfgSis('REGCID', varBoolean) And (objVenda.strEspDoc <> 'OR');

    If Not fEmptyStr(objVenda.strCodRot) Then
    Begin
      edtCodRot.Text := objVenda.strCodRot;
      fValidaCampos(edtCodRot);
    End;
  End;

  Self.Height := 19 + pnlTransportadoraFrete.Height +
                 IIF(pnlRota.Visible, pnlRota.Height, 0) +
                 IIF(pnlTraRedesp.Visible, pnlTraRedesp.Height, 0) +
                 IIF(pnlPeso.Visible, pnlPeso.Height, 0);

  strCodTraAnt := edtCodTra.Text;
  strTipFreAnt := fTipoFrete(cmbTipFre.Text);
  fltValFreAnt := fStrToFloat(edtValFre.Text,0);
  fltValFreAntTrava := fStrToFloat(edtValFre.Text,0);
  fltFreCotAnt := fStrToFloat(edtValFreCot.Text,0);

  objVenda.strCodTraAnt := edtCodTra.Text;
  objVenda.strNomTraAnt := edtNomTra.Text;
  objVenda.fltValFreAnt := fStrToFloat(edtValFre.Text,0);
  objVenda.blnFreFatRecalculado := False;
  objValidacoesFrete := TValidacoesFrete.Create(objVenda);
  blnTravaZerarFrete := False;
end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.OnFormShow;
begin
  blnIniciandoTela := True;
  Try
    pOnShow;
  Finally
    blnIniciandoTela := False;
  End;
end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.pAbreTelaDigPesoProduto;
Var
  objPesIte: TPesIte;
begin

  Try

    objPesIte := TPesIte.Create(Self);
    objPesIte.fatVenda := objVenda;

    objPesIte.blnPesBruEna := blnPesBruEna;
    objPesIte.blnPesLiqEna := blnPesLiqEna;
    objPesIte.blnPesBruRea := blnPesBruRea;
    objPesIte.blnPesLiqRea := blnPesLiqRea;
    objPesIte.blnPesBruTab := blnPesBruTab;
    objPesIte.blnPesLiqTab := blnPesLiqTab;

    objPesIte.pAbreTelaDigPesoProduto(edtPesBru, edtPesLiq);

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmDadosFechamentoPedidoTransportadoraFrame.pAbreTelaDigPesoProduto]');
  End;

  FreeAndNil(objPesIte);

end;

function TfraDadosFechamentoPedidoTransportadoraFrame.fTravaTransportadoraPoisJaFoiDefinido: Boolean;
begin
  Result := (Not fEmptyStr(objVenda.strCodTra)) And
            (objVenda.strOpcDoc = 'CP') And
            (objVenda.blnResolveuConflitoDeTransportadora) And
            (fCfgSis('TREXCP') = 'S' {Pedir senha});
end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.tmrHideHintsTimer(Sender: TObject);
begin
  inherited;
  If Screen.ActiveForm <> GetParentForm(self) Then
    HintControler.HideHint;
end;

function TfraDadosFechamentoPedidoTransportadoraFrame.fCalculoDeFreteEhObrigatorio: Boolean;
begin
  Result := False;

  If (Not btnCalcularFrete.Visible) Then
    Exit;

  If (Pos(objVenda.strEspDoc, 'PD_OR_') <= 0) Then
    Exit;

  If (Not fDocumentoComFretePelaFrenetOuQualp) Then
    Exit;

  If (Not((fCfgSis('FREUSA', varBoolean)) Or (fCfgSis('QLPUSA', varBoolean)))) Then
    Exit;

  If (Not fCfgSis('OBRFRE', varBoolean)) Then
    Exit;

  If (Not objVenda.fAlterouItensPedido(True)) Then
    Exit;

  Result := True;
end;

function TfraDadosFechamentoPedidoTransportadoraFrame.fValidaFrete: Boolean;
begin
  Result := False;

  If (fCalculoDeFreteEhObrigatorio) And (Not objVenda.blnFreFatRecalculado) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para continuar, o frete do documento '+
              'deve ser recalculado.', ['&Ok']);
    pSetFocus(btnCalcularFrete);
    Exit;
  End;

  Result := True;
end;

function TfraDadosFechamentoPedidoTransportadoraFrame.fGetInputPassarZeroEmitenteCIF : TInputPassarZeroEmitenteCIF;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result.EditValFre := edtValFre;
  Result.ComboTipFre := cmbTipFre;
  Result.CodigoTransportadora := edtCodTra.Text;
end;

function TfraDadosFechamentoPedidoTransportadoraFrame.fDocumentoComFretePelaFrenetOuQualp: Boolean;
  Var
    strTipFrete: String;
begin
  strTipFrete := fCampoTabela('FRE_TIPAPI', 'FREFAT',
                             ['FRE_NUMDOC', 'FRE_ESPDOC', 'FRE_CODEMP'],
                             [objVenda.strNumOrc, objVenda.strEspOrc, objVenda.strEmpOri]);

  Result := (Pos(strTipFrete, 'FRENET_QUALP_') > 0);
end;

procedure TfraDadosFechamentoPedidoTransportadoraFrame.pCarregarDespesasAcessoriasImpostoDeImportacao;
begin
  If not fCfgSis('EIIZFM', varBoolean) Then
    Exit;

  objVenda.fltTiiZfm := objVenda.fRetornaValorDoImpostoDeImportacaoZonaFranca;

  edtDesAce.Text := FormatFloat('#,##0.00', objVenda.fltTiiZfm);
end;

end.

