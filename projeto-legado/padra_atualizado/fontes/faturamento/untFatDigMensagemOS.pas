unit untFatDigMensagemOS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, untPaiSimples, Uni, DB,
  ComboBoxFocus, Vcl.Buttons, EditFocus, untFuncFat, BitBtnLockedIncrem, strUtils,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  dxScreenTip, cxClasses, dxCustomHint, cxHint, System.Math;

type
  TfrmFatDigMensagemOS = class(TfrmPaiSimples)
    pnlPrincipal: TPanel;
    Label2: TLabel;
    edtCodTra: TEditFocus;
    edtNomTra: TEditFocus;
    lblValFre: TLabel;
    edtValFre: TEditFocus;
    btnCalcFreSug: TSpeedButton;
    lblQtdTra: TLabel;
    edtQtdTra: TEditFocus;
    btnCalcVolume: TSpeedButton;
    lblEspVol: TLabel;
    edtEspVol: TEditFocus;
    Label4: TLabel;
    cmbTipFre: TComboBoxFocus;
    pnlConfirma: TPanel;
    btnCancelaDados: TBitBtnLocked;
    btnConfirmaDados: TBitBtnLocked;
    HintControler: TcxHintStyleController;
    pnlVolumeSepExc: TPanel;
    lblQtdTraSepExc: TLabel;
    lblQtdTraSepNExc: TLabel;
    edtQtdTraSepExc: TEditFocus;
    edtQtdTraSepNExc: TEditFocus;
    procedure edtCodTraEnter(Sender: TObject);
    procedure edtCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnCalcFreSugClick(Sender: TObject);
    procedure edtQtdTraKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnCalcVolumeClick(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtValFreEnter(Sender: TObject);
    procedure edtValFreExit(Sender: TObject);
  private
    { Private declarations }
    strTraAnt: String;
    qryConTra: TUniQuery;
    blnCalcFreteSugestaoRegia: Boolean;
    blnCalcFreteSugestaoTranp: Boolean;
    blnCalcFreteSugestaoItens: Boolean;
    blnSomenExibirSugestFrete: Boolean;

    procedure pCarregaCadTra;
    procedure pCalculaFreteSugestao;
    function fTravaTransportadoraPoisJaFoiDefinido: Boolean;
    procedure pCalcVolumeSepExclusiva;
  public
    { Public declarations }
    strCodTra: String;
    fatVenda: TFatVenda;
    blnConfirma: Boolean;

    procedure pOnShow;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmFatDigMensagemOS: TfrmFatDigMensagemOS;

implementation

{$R *.dfm}

uses untConstantes, untTypesSistema, untConsultas, untFuncoesSimples,
  untTipoFreteAtc, untPesqAux;

procedure TfrmFatDigMensagemOS.btnCalcFreSugClick(Sender: TObject);
begin
  inherited;

  If (fatVenda.fPermitirFreteNoFaturamento) Then
  Begin
    pCalculaFreteSugestao();
    If (fatVenda.fltTotPro - fatVenda.fltDesEsp >= fatVenda.fltVlMinF) Then
      edtValFre.Text := '0,00'
    Else If fMensagem('', 'Deseja carregar o valor do frete sugestão?', ['', '']) = 1 Then
      edtValFre.Text := FormatFloat('#,##0.00', fatVenda.fltFreSug);
  End;
end;

procedure TfrmFatDigMensagemOS.btnCalcVolumeClick(Sender: TObject);
begin
  inherited;
  edtQtdTra.Text := FloatToStrF(fatVenda.fRetVolumes, ffFixed, 12, 0);
  If pnlVolumeSepExc.Visible Then
    pCalcVolumeSepExclusiva;
end;

procedure TfrmFatDigMensagemOS.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;

  Close();
end;

procedure TfrmFatDigMensagemOS.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then Begin
    fatVenda.strCodTra := edtCodTra.Text;
    fatVenda.strEspTra := edtEspVol.Text;
    fatVenda.strTipFre := fTipoFrete(cmbTipFre.Text);
    fatVenda.intQtdTra := StrToIntDef(edtQtdTra.Text, 0);
    fatVenda.fltValFre := fStrToFloat(edtValFre.Text);
    fatVenda.fltFreDig := fStrToFloat(edtValFre.Text);

    If pnlVolumeSepExc.Visible Then
    Begin
      fatVenda.intQtdTraSepExc  := StrToIntDef(edtQtdTraSepExc.Text, 0);
      fatVenda.intQtdTraSepNExc := StrToIntDef(edtQtdTraSepNExc.Text, 0);
    End;

    blnConfirma := True;

    Close();
  End;
end;

procedure TfrmFatDigMensagemOS.edtCodTraEnter(Sender: TObject);
begin
  inherited;

  strTraAnt := edtCodTra.text;
end;

procedure TfrmFatDigMensagemOS.edtCodTraKeyPress(Sender: TObject; var Key: Char);
Var
  arrTransp  : TConsultasArray;
  TipoConTra : TTipoConsultaTransportad;
  strCidReg  : String;
begin

  inherited;

  If (blnCalcFreteSugestaoTranp) Then
  Begin
    TipoConTra := conTraCidFrete;
    strCidReg  := fatVenda.fRetornaStrCodCidEntAtual;
  End
  Else If (blnCalcFreteSugestaoRegia) Then
  Begin
    TipoConTra := conTraRegFrete;
    strCidReg  := fatVenda.fRetornaStrCodRegEntAtual;
  End
  Else
  Begin
    TipoConTra := conTraCompleta;
    strCidReg  := '';
  End;

  If fPesqTransportadora(TipoConTra, Self, edtCodTra, edtNomTra, Nil, Key, arrTransp, True, strCidReg) Then
  Begin
    If fValidaCampos(edtCodTra, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDigMensagemOS.edtQtdTraKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If CharInSet(Key, [',', '.', '-']) Then
  Begin
    Key := #0;
  End;
end;

procedure TfrmFatDigMensagemOS.edtValFreEnter(Sender: TObject);
begin
  inherited;

  pCalculaFreteSugestao;

  If blnSomenExibirSugestFrete Then
  Begin
    HintControler.ShowHint(Self.Left + edtValFre.Left + edtValFre.Width,
                           15 + Self.Top + edtValFre.Top + edtValFre.Height,
                           'Valor do frete sugestão: ' + FormatFloat('#,##0.00', fatVenda.fltFreSug), '');
  End;
end;

procedure TfrmFatDigMensagemOS.edtValFreExit(Sender: TObject);
begin
  inherited;

  HintControler.HideHint;
end;

procedure TfrmFatDigMensagemOS.FormCreate(Sender: TObject);
  Var
    intTipFre: Integer;
begin
  inherited;

  cmbTipFre.Clear;

  For intTipFre In TiposFrete Do
    cmbTipFre.Items.Add(fDescricaoFrete(IntToStr(intTipFre)));

  strCodTra   := '';
  blnConfirma := False;

  qryConTra := fCriarQuery('SELECT * FROM CADTRA WHERE FALSE', Self);
end;

procedure TfrmFatDigMensagemOS.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F10) Then
     btnConfirmaDados.Click();
end;

procedure TfrmFatDigMensagemOS.FormShow(Sender: TObject);
begin
  inherited;

  pOnShow();
end;

function TfrmFatDigMensagemOS.fTravaTransportadoraPoisJaFoiDefinido: Boolean;
begin
  Result := (Not fEmptyStr(fatVenda.strCodTra)) And
            (fatVenda.strOpcDoc = 'CP') And
            (fatVenda.blnResolveuConflitoDeTransportadora) And
            (fCfgSis('TREXCP') = 'S' {Pedir senha});
end;

function TfrmFatDigMensagemOS.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodTra) Then
    Begin

      If (fEmptyStr(edtCodTra.Text)) Then
      Begin
        edtNomTra.Clear;
      End
      Else
      Begin
        pCarregaCadTra;
        If qryConTra.FieldByName('TRA_CODTRA').IsNull Then
        Begin

          If (blnCalcFreteSugestaoTranp) Then
          Begin
            fMensagem('ATENÇÃO!', IIF(blnCalcFreteSugestaoTranp, fRetMsgTransportadoraNaoEncontrada(fatVenda.fRetornaStrCodCidEntAtual),
                                                                 fRetMsgTransportadoraNaoEncontrada), ['&Ok']);
          End
          Else
          If (blnCalcFreteSugestaoRegia) Then
          Begin
            fMensagem('ATENÇÃO!', IIF(blnCalcFreteSugestaoRegia, fRetMsgTransportadoraNaoEncontrada(fatVenda.fRetornaStrCodRegEntAtual, True),
                                                                 fRetMsgTransportadoraNaoEncontrada('', True)), ['&Ok']);
          End;

          Result := False;

        End
        Else If Not fatVenda.blnTaxaBombeamentoPedOrc Then
        Begin
          If (fatVenda.fPermitirFreteNoFaturamento) Then
          Begin
            If (blnCalcFreteSugestaoTranp Or blnCalcFreteSugestaoRegia) And (Not blnSomenExibirSugestFrete) And (blnBuscaPorChave) Then
            Begin
              pCalculaFreteSugestao;
              If (fatVenda.fltTotPro - fatVenda.fltDesEsp >= fatVenda.fltVlMinF) Then
                edtValFre.Text := '0,00'
              Else If (fCfgSis('CARFRE', varString) = 'N') Or
                      (fMensagem('', 'Deseja carregar o valor do frete da transportadora selecionada?', ['','']) = 1) Then
                edtValFre.Text := FloatToStrF(fatVenda.fltFreSug, ffNumber, 12, 2);
            End
            Else If (Not blnCalcFreteSugestaoTranp) And
                    (Not blnCalcFreteSugestaoRegia) And
                    (Not blnCalcFreteSugestaoItens) And blnBuscaPorChave And
                    (((fStrToFloat(edtValFre.Text) = 0) And fEmptyStr(fatVenda.strNumOrc)) Or
                    (Not SameText(edtCodTra.Text, strTraAnt))) Then
            Begin
              If (fCfgSis('CARFRE', varString) = 'N') Or
                 ((qryConTra.FieldByName('TRA_VALFRE').AsFloat > 0) And
                 (fMensagem('', 'Deseja carregar o valor do frete da transportadora selecionada?' + #13#10 + 'Valor ' + FormatFloat('#0.00', qryConTra.FieldByName('TRA_VALFRE').AsFloat), ['','']) = 1)) Then
                edtValFre.Text := FormatFloat('#0.00', qryConTra.FieldByName('TRA_VALFRE').AsFloat);
            End
            Else If (blnCalcFreteSugestaoItens) And
                    (Not SameText(edtCodTra.Text, strTraAnt)) Then
            Begin
              pCalculaFreteSugestao;
              If (fatVenda.fltTotPro - fatVenda.fltDesEsp >= fatVenda.fltVlMinF) Then
                edtValFre.Text := '0,00'
              Else
                edtValFre.Text := FloatToStrF(fatVenda.fltFreSug, ffNumber, 12, 2);
            End;

          End;
          strTraAnt := edtCodTra.Text;
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
        Else If (fFormataFloat(fatVenda.fltTotGer, 2) >= fFormataFloat(fCfgSis('VLMINF', varDouble), 2)) And
                (fStrToFloat(edtValFre.Text) > 0.0) Then
        Begin
          If fMensagem('ATENÇÃO!', 'O Valor da venda é maior / igual ao valor mínimo para isenção da cobrança do frete. O que deseja fazer?'
                                 , ['&Continuar e zerar o frete', '&Manter o frete digitado'], 1, False, 1, 210) = 1 Then
            edtValFre.Text := '0,00';
        End;

      End;

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

    Else If (Sender = cmbTipFre) Then
    Begin

      If (Not fFreteValido(fTipoFrete(cmbTipFre.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe um Tipo de Frete!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        If (Not fPermiteFreteProprio(fTipoFrete(cmbTipFre.Text))) Then
          Result := False
        Else If (fTipoFrete(cmbTipFre.Text) = '9') And (fStrToFloat(edtValFre.Text) > 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe um Tipo de Frete válido:' +#13+
                                'Emitente(CIF), Destinatário(FOB) ou Terceiros', ['&O k']);
          Result := False;
        End;
      End;

    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatDigMensagemOS.pCalculaFreteSugestao;
begin
  If (blnCalcFreteSugestaoTranp Or
      blnCalcFreteSugestaoRegia Or
      blnCalcFreteSugestaoItens) Then
  Begin
    If blnCalcFreteSugestaoTranp Or blnCalcFreteSugestaoRegia Then
      fatVenda.fCalculaSugestaoFreteTransportadora(edtCodTra.Text, True, blnCalcFreteSugestaoRegia)

    Else If blnCalcFreteSugestaoItens Then
      fatVenda.fCalculaSugestaoFreteProdutos(edtCodTra.Text, True);
  End;
end;

procedure TfrmFatDigMensagemOS.pCalcVolumeSepExclusiva;
begin
  edtQtdTraSepExc.Text  := FloatToStrF(fatVenda.fRetVolumesSepExc, ffFixed, 12, 0);
  edtQtdTraSepNExc.Text := FloatToStrF(fStrToFloat(edtQtdTra.Text) - fStrToFloat(edtQtdTraSepExc.Text), ffFixed, 12, 0);
end;

procedure TfrmFatDigMensagemOS.pCarregaCadTra;
begin

  If ((Not blnCalcFreteSugestaoTranp) And (Not blnCalcFreteSugestaoRegia)) Or (fTravaTransportadoraPoisJaFoiDefinido) Then
    pPesquisaCadTra(qryConTra, qryConTra, edtCodTra.Text)
  Else
  Begin
    If (blnCalcFreteSugestaoRegia) Then
      pPesquisaCadTraRegFrete(qryConTra, qryConTra, edtCodTra.Text, fatVenda.fRetornaStrCodRegEntAtual)
    Else
      pPesquisaCadTraCidFrete(qryConTra, qryConTra, edtCodTra.Text, fatVenda.fRetornaStrCodCidEntAtual);
  End;

  With qryConTra Do
  Begin
    edtNomTra.Text := FieldByName('TRA_NOMTRA').AsString;
  End;
end;

procedure TfrmFatDigMensagemOS.pOnShow;
begin

  blnCalcFreteSugestaoRegia := (fCfgSis('FRETRA') = FRETRA_POR_TRANSPORTADORA_REGIAO);
  blnCalcFreteSugestaoTranp := (fCfgSis('FRETRA') = FRETRA_POR_TRANSPORTADORA_CIDADE);
  blnCalcFreteSugestaoItens := (fCfgSis('FRETRA') = FRETRA_POR_PRODUTOS_ADICIONAL_TRANSPORTADORA);
  blnSomenExibirSugestFrete := (fCfgSis('SUGFRE') = '2');

  edtValFre.ReadOnly := (Not fCfgSis('ALTFRE', varBoolean));
  edtValFre.ReadOnly := (edtValFre.ReadOnly) Or (Not fatVenda.fPermitirFreteNoFaturamento);
  edtValFre.TabStop  := (Not edtValFre.ReadOnly);

  If (Not fEmptyStr(fatVenda.strNumOrc)) Then
  Begin
    edtCodTra.Text := fatVenda.strCodTra;
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

  pCarregaCadTra;

  If ((Not blnCalcFreteSugestaoTranp) And (Not blnCalcFreteSugestaoRegia)) And (Not blnCalcFreteSugestaoItens) Then
  Begin
    If (Not fEmptyStr(edtCodTra.Text)) And (fatVenda.fltFreDig <= 0) Then
    Begin
      If fEmptyStr(fatVenda.strNumOrc) Then
        fatVenda.fltFreDig := qryConTra.FieldByName('TRA_VALFRE').AsFloat;
      strTraAnt := edtCodTra.Text;
    End;
  End;

  edtEspVol.Text := fatVenda.strEspTra;

  cmbTipFre.ItemIndex   := cmbTipFre.Items.IndexOf(fDescricaoFrete(IfThen(Not fatVenda.fPermitirFreteNoFaturamento, '9', fatVenda.strTipFre)));
  cmbTipFre.Enabled     := fatVenda.fPermitirFreteNoFaturamento;

  pnlVolumeSepExc.Visible := fCfgSis('SEPEXC', varBoolean);
  If Not pnlVolumeSepExc.Visible Then
    Self.Height := Self.Height - pnlVolumeSepExc.Height;

  If fEmptyStr(fatVenda.strNumOrc) Or (fatVenda.intQtdTra = 0) Then
  Begin
    If fCfgSis('CALVOL', varBoolean) Then
    Begin
      edtQtdTra.Text := FloatToStrF(fatVenda.fRetVolumes, ffFixed, 12, 0);
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
    If (Floor(fatVenda.fRetVolumes) <> fatVenda.intQtdTra) And fCfgSis('CALVOL', varBoolean) Then
      fatVenda.pTratarDiferencaVolumeCalculadoComDigitado;

    edtQtdTra.Text := FloatToStrF(fatVenda.intQtdTra, ffFixed, 12, 0);
    If pnlVolumeSepExc.Visible Then
    Begin
      edtQtdTraSepExc.Text  := FloatToStrF(fatVenda.intQtdTraSepExc, ffFixed, 12, 0);
      edtQtdTraSepNExc.Text := FloatToStrF(fatVenda.intQtdTraSepNExc, ffFixed, 12, 0);
    End;
  End;
  
  edtValFre.Text := IfThen(Not fatVenda.fPermitirFreteNoFaturamento, '0,00', FormatFloat('#,##0.00', fatVenda.fltFreDig));
end;

end.
