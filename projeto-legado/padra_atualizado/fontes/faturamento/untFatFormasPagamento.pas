unit untFatFormasPagamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Menus, Buttons, ExtCtrls, EditFocus, untfuncoesSimples,
  Uni, AppEvnts, untConstantes, UniClientDataSet, untFuncFat, untTypesSistema, untFuncoes,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, System.Generics.Collections,
  untAdiantamentoCliente, untTCadRec, untTCadRecRepository, untLiberacao, untTefRecebimento,
  untTiposPix, untMsgLiberacao;

type
  TfrmFatFormasPagamento = class(TfrmPai)
    pnlTotal: TPanel;
    lblValTot: TLabel;
    pnlValDig: TPanel;
    lblValDig: TLabel;
    pnlFundo: TPanel;
    lblDinheiro: TLabel;
    lblChequeVista: TLabel;
    lblChequePre: TLabel;
    lblCartao: TLabel;
    lblFaturado: TLabel;
    edtDinheiro: TEditFocus;
    edtChqVista: TEditFocus;
    edtChqPre: TEditFocus;
    edtCartao: TEditFocus;
    edtFaturado: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    edtOrdPag: TEditFocus;
    lblOrdPag: TLabel;
    lblFinanc: TLabel;
    edtFinanc: TEditFocus;
    lblValCre: TLabel;
    edtValCre: TEditFocus;
    btnReceberPix: TBitBtnLocked;
    lblValorRestante: TLabel;
    chkPixAvulso: TCheckBox;
    pnlBoleto: TPanel;
    lblBoleto: TLabel;
    edtValorBoleto: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure edtChqVistaKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure edtFaturadoExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnReceberPixClick(Sender: TObject);
    procedure edtOrdPagChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chkPixAvulsoClick(Sender: TObject);
  private
    fltValFatAnt : Double;
    blnSelCndPag : Boolean;
    fltValCreAnt: Double;
    fltValDig: Double;
    arrDatas : TDateArray;
    intGravando: Integer;
    intDigitChq: Integer;
    objLiberacao : TLiberacao;

    FobjTefRecebimento            : ITefRecebimento;
    FstrSessaoTef                 : String;
    FblnExecutandoPeloFaturamento : Boolean;

    blnCartaoConferidoEConfirmado : Boolean;
    blnTravaCondicaoPagamentoFaturadoSozinho: Boolean;

    FPortadorBaixaCtr,
    FPlanoDeContasBaixaCtr: String;

    FRecebidoPorPix: Boolean;

    FDadosPixRecebimento,
    FDadosPixRequisicao: String;

    FObjetoPixRecebimento: TDadosRetornoPixConsulta;

    FMenorDataRecebimento: TDateTime;

    FValidarPixNoOnClose: Boolean;

    FValorBoleto: Double;

    procedure pAtualizaValDig;
    procedure pConfirma;
    procedure pAtualizaDupsCred;

    Function fRetEntrada: Double;
    function fValidaValorMod(fltValor: Double; strModalidade: String): Boolean;
    function fFaturado(fltValor: Double): Boolean;
    function fChequesCadastrados(fltValor: Double; blnPrazo: Boolean): Boolean;
    function fPrecisaDigitarChequeAVista: Boolean;
    function fPrecisaDigitarChequePre: Boolean;
    function fGetModalidadesDigitadas: TArrModalidade;
    function fGetTitulosSelecionados: TArrDupSel;
    function fCriaCdsDupsCredito(AOwner: TComponent): TUniClientDataSet;
    procedure pAdicionaCtrBaixando;

    procedure AbreTelaParaPagamentoDoPix;
    function ValidarSeExistePixRecebidoSemConfirmacao: Boolean;
    procedure AdicionarDadosLancamentos(var ALiberacao: TLiberacao);
    function DeterminaCodigoDoClienteDevedorPix: String;
    procedure DeterminaMenorDataRecebimento;
    function RetornaCaptionValorRestante: String;

    procedure pEditaTamanhoForm;

    procedure pAjustaObjPixFatVenda(AObjetoPixRecebimento: TDadosRetornoPixConsulta) ;
    procedure pAjustaOrdPagPixRecebido ;
    procedure pDesligaOrdPagPixOrc ;
    procedure pHabilitaAdtPixPed ;
    procedure pHabilitaAdtCarPed(const AblnLancado: boolean) ;
    procedure pHabilitaCondicaoDePagamentoConformeFormaDePagamento;
  public
    arrCartoes: TCartoesResumoCaixaArray;

    blnConfCartoes: Boolean;
    blnVeiodeCH   : Boolean;

    fltDinheiNeg: Double;
    fltChqVisNeg: Double;
    fltChqPreNeg: Double;
    fltCartaoNeg: Double;
    fltOrdPagNeg: Double;
    fltValCreNeg: Double;

    fltValTot: Double;
    fltDinhei: Double;
    fltChqVis: Double;
    fltChqPre: Double;
    fltCartao: Double;
    fltOrdPag: Double;
    fltFatura: Double;
    fltValFin: Double;
    fltValCre: Double;
    fltRecTot: Double;
    fltValCrd: Double;
    strCodCnd: String;
    strMskCnd: String;

    //************************************************************
    fltValRecExt: Double; // Valor Recebido (Conciliação Bancaria)
    strCodPorExt: String; // Portador Fixo  (Conciliação Bancaria)
    //*************************************************MT***150976

    strDocume: String;
    strPorBai: String;

    fltTotCreditos  : Double;
    stlDupCreditos  : TStringList;
    stlLckCreditos  : TStringList;

    cdsChqPre: TUniClientDataSet;
    cdsChqVis: TUniClientDataSet;
    cdsCtaRec: TUniClientDataSet;

    blnTroChq: Boolean; // Troco para cheque.
    blnTroCar: Boolean; // Troco para cartao

    optTroco: TOperacaoTroco;
    fltValorTroco: Double;
    blnCtaRec: Boolean;
    blnGerCre: Boolean;
    strCliente: String;
    strCodOpe : String;
    blnFpg009: Boolean;

    fatVenda: TFatVenda;

    dicCheques: TDictionary<String, TChequeEmitido>;

    cdsCtrSel: TUniClientDataSet; // Duplicatas Selecionadas da Baixa do Contas a Receber!

    blnAltBas   : Boolean;
    dtaDtaEntOri: TDate;

    strConfDocsAutIncCadRec: String;

    blnConsignacao : Boolean;

    function fDigitacaoCartoes(fltValor: Double;
                               Var arrCartoes: TCartoesResumoCaixaArray;
                               strCodCar: String = '';
                               strCodFin: String = '';
                               intQtdPar: Integer = 0): Boolean;

    function fChequeVis(strValor: String; ARotinaChamada: String = ''): Boolean;
    function fChequePre(strValor: String; ARotinaChamada: String = ''): Boolean;

    property objTefRecebimento            : ITefRecebimento read FobjTefRecebimento            write FobjTefRecebimento;
    property strSessaoTef                 : String          read FstrSessaoTef                 write FstrSessaoTef;
    property blnExecutandoPeloFaturamento : Boolean         read FblnExecutandoPeloFaturamento write FblnExecutandoPeloFaturamento;

    property PortadorBaixaCtr: String read FPortadorBaixaCtr write FPortadorBaixaCtr;
    property PlanoDeContasBaixaCtr: String read FPlanoDeContasBaixaCtr write FPlanoDeContasBaixaCtr;
    property RecebidoPorPix: Boolean read FRecebidoPorPix write FRecebidoPorPix;
    property ObjetoPixRecebimento: TDadosRetornoPixConsulta read FObjetoPixRecebimento;
    property MenorDataRecebimento: TDateTime read FMenorDataRecebimento write FMenorDataRecebimento;

    property ValorBoleto: Double read FValorBoleto;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses untRcxMostraCartoes, untRcxDigCartoes, untCadCheques, untRcxTravas,
     untDigCndPagamento, untRcxMostraCheques, Math, DB, untDuplicatas,
     StrUtils, untTFuncoesPixAutcom, untTFuncoesAuxiliaresPix, untTPixDao,
     untGravando, untTefCitelUtil;

{$R *.dfm}

procedure TfrmFatFormasPagamento.FormShow(Sender: TObject);
begin
  fltValFatAnt := 0;
  blnSelCndPag := False;

  fltValCreAnt := 0;

  lblValTot.Caption := 'Valor Total: ' + FloatToStrF(fltValTot,ffFixed,12,2);
  lblValDig.Caption := 'Valor Digitado: 0,00';
  lblValorRestante.Caption := 'Valor Restante: ' + FloatToStrF(fltValTot,ffFixed,12,2);

  edtDinheiro.Text := '0,00';
  edtChqVista.Text := '0,00';
  edtChqPre.Text   := '0,00';
  edtCartao.Text   := '0,00';
  edtOrdPag.Text   := '0,00';
  edtFaturado.Text := '0,00';
  edtFinanc.Text   := '0,00';
  edtValCre.Text   := '0,00';
  edtValorBoleto.Text := '0,00';

  stlDupCreditos := TStringList.Create;
  stlLckCreditos := TStringList.Create;

  If Assigned(fatVenda) Then
  Begin
    fatVenda.objFinanc.pLimpaDados;

    If (blnFpg009) And (Not fMostraCreditoComPortador(fatVenda.strCodCli)) Then
    Begin
      lblValCre.Visible := False;
      edtValCre.Visible := False;
    End;
  End;

  blnCartaoConferidoEConfirmado := False;

  inherited;

  If (blnCtaRec And
     (Not FPortadorBaixaCtr.IsEmpty)) Or
     blnFpg009 Then
  Begin
    btnReceberPix.Visible := TFuncoesPixAutcom.RealizaValidacoesUsoDoPixNoReceber(strCodOpe,
                                                                                  FPortadorBaixaCtr,
                                                                                  not blnFpg009);
    If (FMenorDataRecebimento = 0) and (not blnFpg009) Then
      DeterminaMenorDataRecebimento;
  End;

  pEditaTamanhoForm;
  pAjustaOrdPagPixRecebido ;
  pHabilitaCondicaoDePagamentoConformeFormaDePagamento;

  edtValorBoleto.Enabled := pnlBoleto.Enabled;
  lblBoleto.Enabled := pnlBoleto.Enabled;
end;

procedure TfrmFatFormasPagamento.pAdicionaCtrBaixando;
begin
  If Assigned(cdsCtrSel) Then
  Begin
    With cdsCtrSel Do
    Begin
      First;
      While Not Eof Do
      Begin
        frmCadCheques.pAddCtrBaixando(FieldByName('NRODUP').AsString,
                                      FieldByName('CTR_ESPDOC').AsString,
                                      FieldByName('CTR_CODEMP').AsString,
                                      FieldByName('CTR_CODCLI').AsString,
                                      FieldByName('CTR_PARCEL').AsString);

        Next;
      End;
    End;
  End;
end;

procedure TfrmFatFormasPagamento.pAjustaObjPixFatVenda(
  AObjetoPixRecebimento: TDadosRetornoPixConsulta);
begin
  FObjetoPixRecebimento := AObjetoPixRecebimento ;
  FObjetoPixRecebimento.PlanoDeContas := FPlanoDeContasbaixaCtr ;

  if blnFpg009 then
  begin
    fatVenda.DadosPixDaVenda.ObjetoPixPago := FObjetoPixRecebimento ;
    fatVenda.DadosPixDaVenda.ObjetoPixPago.RecebidoPeloF11 := 'N';
    fatVenda.DadosPixDaVenda.ObjetoPixPago.PlanoDeContas := ifthen(fEmptyStr(FPlanoDeContasbaixaCtr), fCfgSis('CTAPIX'), FPlanoDeContasbaixaCtr) ;
    fatVenda.DadosPixDaVenda.RecebidoPorPix := 'S';
  end ;
end;

procedure TfrmFatFormasPagamento.pAjustaOrdPagPixRecebido;
begin
  if (Assigned(fatVenda)) and (blnFpg009) then
  begin
    if fatVenda.fRecebidoPorPix then
    begin
      edtOrdPag.Enabled := False ;
      edtOrdPag.Text := FormatFloat(',0.00', fatVenda.DadosPixDaVenda.ObjetoPixPago.ValorPago);
      btnReceberPix.Enabled := False ;
      fValidaCampos(edtOrdPag) ;
    end ;
  end ;
end;

{************************************}
{* ATUALIZA VARIAVEIS E LABEL       *}
{*********************************AF*}
procedure TfrmFatFormasPagamento.pAtualizaValDig;
 Var
   intContador: Integer;
Begin
  fltDinhei := 0;
  fltChqVis := 0;
  fltChqPre := 0;
  fltCartao := 0;
  fltOrdPag := 0;
  fltFatura := 0;
  fltValFin := 0;
  fltValCre := 0;
  fltValCrd := 0;
  FValorBoleto := 0;

  If Not fEmptyStr(edtDinheiro.Text) Then
    fltDinhei := fStrToFloat(edtDinheiro.Text);

  If Not fEmptyStr(edtChqVista.Text) Then
    fltChqVis := fStrToFloat(edtChqVista.Text);

  If Not fEmptyStr(edtChqPre.Text) Then
    fltChqPre := fStrToFloat(edtChqPre.Text);

  If Not fEmptyStr(edtOrdPag.Text) Then
    fltOrdPag := fStrToFloat(edtOrdPag.Text);

  If Not fEmptyStr(edtValCre.Text) Then
    fltValCrd := fStrToFloat(edtValCre.Text);

  If Not fEmptyStr(edtValorBoleto.Text) Then
    FValorBoleto := fStrToFloat(edtValorBoleto.Text);

  If fCfgSis('DIGCAR', varBoolean) Then
  Begin
    If Length(arrCartoes) > 0 Then
    Begin
      For intContador := 0 To Length(arrCartoes)-1 Do
      Begin
        fltCartao := fltCartao + arrCartoes[intContador].fltValDig;
      End;
    End;

    if (blnConsignacao) then
    begin
      if not fCfgSis('BAIAVI', varBoolean) then
        fltCartao := fStrToFloat(edtCartao.Text)
      else
        edtCartao.Text := FloatToStrF(fltCartao,ffFixed,12,2);
    end
    else
      edtCartao.Text := FloatToStrF(fltCartao,ffFixed,12,2);
  End
  Else
  Begin
    fltCartao := fStrToFloat(edtCartao.Text);
  End;

  If Not fEmptyStr(edtFaturado.Text) Then
    fltFatura := fStrToFloat(edtFaturado.Text);

  If Not fEmptyStr(edtFinanc.Text) Then
    fltValFin := fStrToFloat(edtFinanc.Text);

  fltValDig := fltDinhei + fltChqVis + fltChqPre + fltCartao + fltOrdPag + fltFatura + fltValFin + fltValCrd + FValorBoleto;

  lblValDig.Caption := 'Valor Digitado: ' + FloatToStrF(fltValDig,ffFixed,12,2);
  lblValorRestante.Caption := RetornaCaptionValorRestante;
End;

procedure TfrmFatFormasPagamento.pConfirma;
  Var
    blnValRecMaior : Boolean;
Begin
  pAtualizaValDig;

  If Assigned(fatVenda) Then
  Begin

    If fStrToFloat(edtFinanc.Text) = 0 Then
    Begin
      fatVenda.objFinanc.pLimpaDados;
    End

    Else If fatVenda.objFinanc.fValorRestante(fatVenda.objFinanc.cdsMovFin, fStrToFloat(edtFinanc.Text)) <> 0 Then
    Begin
      fatVenda.fltValFin := fStrToFloat(edtFinanc.Text);

      If fatVenda.fPedeDadosFinanceira(fRetEntrada) Then
        pSetFocus(btnConfirmaDados);

      Exit;
    End;

  End;

  {*************************************}
  {* VERIFICA SE FOI DIGITADO APENAS O *}
  {* FATURADO                          *}
  {**********************************AF*}
  If (blnTravaCondicaoPagamentoFaturadoSozinho) And
     (edtFaturado.Text <> '0,00') And
     (edtDinheiro.Text =  '0,00') And
     (edtChqVista.Text =  '0,00') And
     (edtChqPre.Text   =  '0,00') And
     (edtCartao.Text   =  '0,00') And
     (edtOrdPag.Text   =  '0,00') And
     (edtFinanc.Text   =  '0,00') And
     (edtValCre.Text   =  '0,00') And
     (edtValorBoleto.Text = '0,00') Then
  Begin
    fMensagem('','Não deve ser digitado apenas faturado!!!',['&OK']);
    pSetFocus(edtDinheiro);
    Exit;
  End;

  {****************************************}
  {* VERIFICA CHEQUES A VISTA CADASTRADOS *}
  {*************************************AF*}
  If (edtChqVista.Text <> '0,00') Then
  Begin

    If (Assigned(cdsChqVis)) And (fPrecisaDigitarChequeAVista) Then
    Begin
      If Not fChequesCadastrados(fStrToFloat(edtChqVista.Text), False) Then
      Begin
        fMensagem('','O valor dos cheques a vista cadastrados difere do valor digitado!!!',['&OK']);
        pSetFocus(edtChqVista);
        Exit;
      End;
    End;

  End;

  {****************************************}
  {* VERIFICA CHEQUES A PRAZO CADASTRADOS *}
  {*************************************AF*}
  If (edtChqPre.Text <> '0,00') Then
  Begin

    If (Assigned(cdsChqPre)) And (fPrecisaDigitarChequePre) Then
    Begin
      If Not fChequesCadastrados(fStrToFloat(edtChqPre.Text), True) Then
      Begin
        fMensagem('','O valor dos cheques a prazo cadastrados difere do valor digitado!!!',['&OK']);
        pSetFocus(edtChqPre);
        Exit;
      End;
    End;

  End;

  {****************************************}
  {* VERIFICA SE ESTÁ UTILIZANDO CRÉDITOS *}
  {****************************************}
  If (edtValCre.Text <> '0,00') Then
  Begin

    If fFormataFloat(fltValDig, 2) > fFormataFloat(fltValTot, 2) Then
    Begin
      fMensagem('','Ao utilizar créditos o valor digitado não poderá ultrapassar o valor total!!!',['&OK']);
      pSetFocus(edtChqPre);
      Exit;
    End;
  End;

  If (Not fEmptyStr(edtFaturado.Text)) And (fStrToFloat(edtFaturado.Text) <> 0) Then
  Begin

    If fEmptyStr(fatVenda.arrDuplicata[0].dtaDtaVen) Then
    Begin
      fMensagem('','Preencher dados do faturado!',['&OK']);
      pSetFocus(edtFaturado);
      Exit;
    End;

  End;

  If pnlBoleto.Visible THen
  Begin
    If (FValorBoleto <> 0) And
       (fFormataFloat(fltDinhei + fltChqVis + fltChqPre + fltCartao + fltOrdPag + fltFatura + fltValFin + fltValCrd, 2) <> 0) Then
    Begin
      fMensagem('ATENÇÃO','Ao digitar valor no campo Boleto, não poderá receber com outras modalidades!',['&OK']);
      pSetFocus(edtValorBoleto);
      Exit;
    End;
  End;

  If (Not blnCtaRec) Or (Not blnGerCre) Then
  Begin

    If fFormataFloat(fltValTot, 2) <> fFormataFloat(fltValDig, 2) Then
    Begin
      if Assigned(fatVenda) And
        (fatVenda.strCodFpg = '009')  And
        (fatVenda.strOpcDoc = 'CF')   And
        fCfgSis('TRODIN', varBoolean) And
        (fStrToFloat(edtDinheiro.Text) > 0) then
      Begin
        if fFormataFloat(fStrToFloat(edtCartao.Text) + fStrToFloat(edtFaturado.Text), 2) >
           fFormataFloat(fltValTot, 2) then
        Begin
          fMensagem('','Valores informados para faturado e\ou cartão não podem ser maiores que o valor total!',['&OK']);
          pSetFocus(edtFaturado);
          Exit;
        End;

        if fFormataFloat(fltValDig, 2) > fFormataFloat(fltValTot, 2) then
        Begin
          Case fMensagem('', 'Deseja:', ['&Crédito', '&Troco', 'C&ancelar']) Of
            1: optTroco := otCredito;
            2: optTroco := otTroco;
            Else optTroco := otNada;
          End;

          If optTroco <> otNada Then
          Begin
            fltValorTroco := fFormataFloat(fltValDig, 2) - fFormataFloat(fltValTot, 2);

            if fStrToFloat(edtDinheiro.Text) <= fltValorTroco  then
            Begin
              fMensagem('','Valor a ser processado como troco maior ou igual ao valor aplicado na modalidade "dinheiro". Favor rever valores aplicados.',['&OK']);
              pSetFocus(edtDinheiro);
              Exit;
            End;

            ModalResult := mrOk;
            Close;
          End;
        End;
      End
      Else
      Begin
        fMensagem('','Valor total não bate com o valor digitado!',['&OK']);
        pSetFocus(edtDinheiro);
      End;
    End
    Else
    Begin
      FValidarPixNoOnClose := False;

      Close;
      ModalResult := mrOk;
    End;

  End
  Else
  Begin
    blnValRecMaior := (fFormataFloat(fltValRecExt, 2) > fFormataFloat(fltValTot, 2)) And (strCodPorExt <> '');
    If (fFormataFloat(fltValTot, 2) < fFormataFloat(fltValDig, 2)) Or
       (blnValRecMaior And ((fFormataFloat(fltValTot, 2) < fFormataFloat(fltValDig, 2))Or
       (fFormataFloat(fltValTot, 2) = fFormataFloat(fltValDig, 2)))) Then
    Begin
      If fFormataFloat(fltValTot, 2) < 0 Then
      Begin
        fMensagem('','Valor total não bate com o valor digitado!',['&OK']);
        pSetFocus(edtDinheiro);
      End
      else if (fFormataFloat(fltValRecExt, 2) > 0) and
              (fFormataFloat(fltValDig, 2) <> fFormataFloat(fltValRecExt, 2))  then
      begin
        fMensagem(
          '',
          'O valor informado deve ser igual ao valor total do(s) lançamento(s) selecionado(s) no extrato.' + sLineBreak +
          'Valor digitado: R$ ' + FormatFloat('#,##0.00', fFormataFloat(fltValDig, 2)) + sLineBreak +
          'Valor esperado: R$ ' + FormatFloat('#,##0.00', fFormataFloat(fltValRecExt, 2)),
          ['&OK']
        );

        pSetFocus(edtDinheiro);
      end
      Else
      Begin

        If fMensagem('','O valor '+IIF(blnValRecMaior,'recebido','informado')+' R$'+ FormatFloat('#,##0.00', IIF(blnValRecMaior,fltValRecExt,fltValDig)) +
                        ' é maior do que o valor total a ser baixado R$' + FormatFloat('#,##0.00',fltValTot) + #13#10 +
                        'Isso irá gerar crédito para este cliente. Confirma esta operação?',['','']) = 1 Then
        Begin
          If (fCfgSis('CRELIB', varBoolean)) Then
          Begin
            If Not fTravarCreditoPorRecebimentoAMaior(strCodOpe,
                                                      fGetTitulosSelecionados,
                                                      False,
                                                      fFormataFloat(fltValDig - fltValTot, 2),
                                                      fGetModalidadesDigitadas) Then
            Begin
              fltValCre := IIF(blnValRecMaior,fFormataFloat(fltValRecExt - fltValTot, 2),fFormataFloat(fltValDig - fltValTot, 2));
              fltRecTot := fRetEntrada;

              FValidarPixNoOnClose := False;
              Close;
              ModalResult := mrOk;
            End;
          End
          Else
          Begin
            fltValCre := IIF(blnValRecMaior,fFormataFloat(fltValRecExt - fltValTot, 2),fFormataFloat(fltValDig - fltValTot, 2));
            fltRecTot := fRetEntrada;

            FValidarPixNoOnClose := False;
            Close;
            ModalResult := mrOk;
          End;
        End
        Else
          pSetFocus(edtDinheiro);

      End;

    End
    Else If fFormataFloat(fltValTot, 2) > fFormataFloat(fltValDig, 2) Then
    Begin
      fMensagem('','Valor total não bate com o valor digitado!',['&OK']);
      pSetFocus(edtDinheiro);
    End

    Else
    Begin
      FValidarPixNoOnClose := False;

      Close;
      ModalResult := mrOk;
    End;

  End;

End;

procedure TfrmFatFormasPagamento.pDesligaOrdPagPixOrc;
begin
  if (Assigned(fatVenda)) and (blnFpg009) then
  begin
    if fatVenda.strEspDoc = 'OR' then
    begin
      btnReceberPix.Enabled := False ;
      chkPixAvulso.Enabled := False ;
    end ;
  end ;
end;

procedure TfrmFatFormasPagamento.pEditaTamanhoForm;
begin
  if ( (edtFinanc.Visible) And (edtFinanc.enabled) ) or
     ((edtValCre.Visible) And (edtValCre.Left <> edtFaturado.Left)) then
    Self.width := 673
  else
    Self.width := 461;

  (**********************************)
  (* Manter a nova altura do form   *)
  (**********************************)

    Self.height := 226;
    pnlValDig.height := 28;

  if btnReceberPix.Visible then
    edtOrdPag.width := 78
  else
    edtOrdPag.width := 113;

  If chkPixAvulso.Visible Then
  Begin
    chkPixAvulso.Left := btnReceberPix.Left + btnReceberPix.Width + 5;
    chkPixAvulso.Top := btnReceberPix.Top + 3;

    Self.Width := 528;
  End;
end;

procedure TfrmFatFormasPagamento.pHabilitaAdtCarPed(const AblnLancado: boolean);
begin
  if not AblnLancado then
    exit ;

  if (Assigned(fatVenda)) and (blnFpg009) then
  begin
    if fatVenda.strEspDoc = 'PD' then
    begin
      fatVenda.blnRealizandoAdiantamentoPedidoPeloVN := True ;
    end ;
  end ;

end;

procedure TfrmFatFormasPagamento.pHabilitaAdtPixPed;
begin
  if (Assigned(fatVenda)) and (blnFpg009) then
  begin
    if fatVenda.strEspDoc = 'PD' then
    begin
      fatVenda.blnRealizandoAdiantamentoPedidoPeloVN := True ;
    end ;
  end ;
end;

procedure TfrmFatFormasPagamento.pHabilitaCondicaoDePagamentoConformeFormaDePagamento;
var
  strModalidadeFormaPagamento: string;
begin
  if not blnFpg009 then
    Exit;

  if fatVenda.strOpcDoc <> 'VN' then
    Exit;

  if pos(fatVenda.strEspDoc, 'OR_PD_') > 0 then
    Exit;

  strModalidadeFormaPagamento := fCampoTabela('CND_MODIVN', 'CADCND', ['CND_CODIGO'], [strCodCnd], False);

  if (fEmptyStr(strModalidadeFormaPagamento)) or (strModalidadeFormaPagamento = 'T') then
    Exit;

  if (strModalidadeFormaPagamento = 'V') then
  begin
    edtDinheiro.Enabled := True;
    edtChqVista.Enabled := True;
    edtOrdPag.Enabled := True;
    edtValCre.Enabled := True;
    edtFaturado.Enabled := False;
    edtFinanc.Enabled := False;
    edtChqPre.Enabled := not fCfgSis('PRACHC', varBoolean);
    edtCartao.Enabled := not fCfgSis('PRACHC', varBoolean);
  end
  else if (strModalidadeFormaPagamento = 'P') then
  begin
    blnTravaCondicaoPagamentoFaturadoSozinho := False;
    edtDinheiro.Enabled := False;
    edtChqVista.Enabled := False;
    edtOrdPag.Enabled := False;
    edtValCre.Enabled := False;
    edtFaturado.Enabled := True;
    edtFinanc.Enabled := True;
    edtChqPre.Enabled := fCfgSis('PRACHC', varBoolean);
    edtCartao.Enabled := fCfgSis('PRACHC', varBoolean);

    if (edtChqPre.Visible) and (edtChqPre.Enabled) then
      pSetFocus(edtChqPre)
    else if (edtCartao.Visible) And (edtCartao.Enabled) then
      pSetFocus(edtCartao)
    else if (edtFaturado.Visible) and (edtFaturado.Enabled) then
      pSetFocus(edtFaturado)
    else
      pSetFocus(edtFinanc);
  end;
end;

function TfrmFatFormasPagamento.RetornaCaptionValorRestante: String;
  Var
    LValorRestante: Double;
begin
  LValorRestante := (fltValTot - fltValDig);
  If (LValorRestante < 0) Then
    Result := 'Valor Restante: ' + FloatToStrF(0,ffFixed,12,2)
  Else
    Result := 'Valor Restante: ' + FloatToStrF(LValorRestante,ffFixed,12,2);
end;

function TfrmFatFormasPagamento.ValidarSeExistePixRecebidoSemConfirmacao: Boolean;
begin
  Result := Not Assigned(FObjetoPixRecebimento);

  If Result Then
    Exit;

  Result := Not TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(FObjetoPixRecebimento);

  If Not Result Then
  Begin
    Result := fMensagem('ATENÇÃO', 'O recebimento em andamento possui um Pix que já foi recebido.' + #13 +
                                   'Se continuar, o sistema não gravará o registro do pagamento desse Pix.' + #13 +
                                   'Deseja realmente continuar?', ['&Sim', '&Não'], 2) = 1;

    If Not Result Then
      Exit;

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Permitir cancelar o recebimento no Controle Financeiro com um Pix já recebido');

    AdicionarDadosLancamentos(objLiberacao);

    objLiberacao.strDirAce := 'PERCANCCTRPIXREC';
    objLiberacao.strMsgSen := 'Permitir cancelar o recebimento no Controle Financeiro com um Pix já recebido';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := strCodOpe;
    objLiberacao.strCodDig := strCodOpe;

    Result := objLiberacao.fLibera;
  End;
end;

procedure TfrmFatFormasPagamento.btnSairClick(Sender: TObject);
begin

  ModalResult := mrCancel;
  inherited;

end;

procedure TfrmFatFormasPagamento.chkPixAvulsoClick(Sender: TObject);
begin
  inherited;
  If Not btnReceberPix.Visible Then
    Exit;

  If Not chkPixAvulso.Enabled Then
    Exit;

  btnReceberPix.Enabled := Not chkPixAvulso.Checked;
end;

function TfrmFatFormasPagamento.DeterminaCodigoDoClienteDevedorPix: String;
begin
  cdsCtrSel.First;

  Result := cdsCtrSel.FieldByName('CTR_CODCLI').AsString;

  cdsCtrSel.Next;
  While Not cdsCtrSel.Eof Do
  Begin
    If Result <> cdsCtrSel.FieldByName('CTR_CODCLI').AsString Then
    Begin
      Result := '';
      Break;
    End;

    cdsCtrSel.Next;
  End;

  cdsCtrSel.First;
end;

procedure TfrmFatFormasPagamento.DeterminaMenorDataRecebimento;
begin
  cdsCtrSel.First;

  FMenorDataRecebimento := cdsCtrSel.FieldByName('CTR_DTAREC').AsDateTime;
  cdsCtrSel.Next;

  While Not cdsCtrSel.Eof Do
  Begin
    If cdsCtrSel.FieldByName('CTR_DTAREC').AsDateTime < FMenorDataRecebimento Then
      FMenorDataRecebimento := cdsCtrSel.FieldByName('CTR_DTAREC').AsDateTime;

    cdsCtrSel.Next;
  End;

  cdsCtrSel.First;
end;

procedure TfrmFatFormasPagamento.edtChqVistaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If Key = '-' Then
    Key := #0;

end;

procedure TfrmFatFormasPagamento.edtFaturadoExit(Sender: TObject);
begin
  inherited;
  fltValFatAnt := fStrToFloat(edtFaturado.Text);
end;

procedure TfrmFatFormasPagamento.edtOrdPagChange(Sender: TObject);
  Var
    LValorValido: Boolean;
begin
  inherited;
  btnReceberPix.Enabled := False;

  If FRecebidoPorPix Then
    Exit;

  LValorValido := Not fEmptyStr(edtOrdPag.Text);
  If LValorValido Then
    LValorValido := fStrToFloat(edtOrdPag.Text) > 0;

  chkPixAvulso.Enabled := LValorValido;
  If Not chkPixAvulso.Enabled Then
    chkPixAvulso.Checked := False;

  If btnReceberPix.Visible Then
  Begin
    If Not chkPixAvulso.Checked Then
      btnReceberPix.Enabled := LValorValido;
  End;
  pDesligaOrdPagPixOrc ;
  btnReceberPix.TabOrder := 5;
end;

function TfrmFatFormasPagamento.fValidaValorMod(fltValor: Double; strModalidade: String): Boolean;
  Var
    fltVlrNeg,
    fltValTotNeg: Double;
Begin
  Result := True;

  If (blnCtaRec) or
     (Assigned(fatVenda) And (fatVenda.strCodFpg = '009') And (fatVenda.strOpcDoc = 'CF') And (fCfgSis('TRODIN', varBoolean))) Then
    Exit;

  If fltValTot > 0 Then
  Begin

    If fltValor > fltValTot Then
    Begin
      fMensagem('','O valor da modalidade ' + strModalidade + ' não pode ser maior que o valor total!',['&OK']);
      Result := False;
    End;
    
  End
  Else
  Begin

    If fltValor <= 0 Then
    Begin
      fltVlrNeg    := (fltValor * -1);
      fltValTotNeg := (fltValTot * -1);
    End
    Else
    Begin
      fltVlrNeg    := fltValor;
      fltValTotNeg := fltValTot;
    End;

    If fltVlrNeg > fltValTotNeg Then
    Begin
      fMensagem('','O valor da modalidade ' + strModalidade + ' não pode ser maior que o valor total!',['&OK']);
      Result := False;
    End;
    
  End;

End;

Function TfrmFatFormasPagamento.fRetEntrada: Double;
Begin
  Result := fStrToFloat(edtDinheiro.Text) + fStrToFloat(edtChqVista.Text) +
            fStrToFloat(edtChqPre.Text) + fStrToFloat(edtCartao.Text) +
            fStrToFloat(edtOrdPag.Text) + fStrToFloat(edtFaturado.Text);
End;

function TfrmFatFormasPagamento.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;

  procedure pMostraMensagemModalidadeMaior;
    Var 
     strMsg : String;
  begin
    If fltDinheiNeg > 0 Then
    Begin
      If Not fEmptyStr(strMsg) Then
        strMsg := strMsg + #10#13;
      strMsg := strMsg + 'DINHEIRO: '+FormatFloat('#,##0.00', fltDinheiNeg);  
    End;
    If  fltChqVisNeg > 0 Then
    Begin
      If Not fEmptyStr(strMsg) Then
        strMsg := strMsg + #10#13;
      strMsg := strMsg + 'CHEQUE À VISTA: '+FormatFloat('#,##0.00', fltChqVisNeg);  
    End;
    If fltChqPreNeg > 0 Then
    Begin
      If Not fEmptyStr(strMsg) Then
        strMsg := strMsg + #10#13;
      strMsg := strMsg + 'CHEQUE A PRAZO: '+FormatFloat('#,##0.00', fltChqPreNeg);  
    End;
    If fltCartaoNeg > 0 Then
    Begin
      If Not fEmptyStr(strMsg) Then
        strMsg := strMsg + #10#13;
      strMsg := strMsg + 'CARTÃO: '+FormatFloat('#,##0.00', fltCartaoNeg);  
    End;
    If fltOrdPagNeg > 0 Then
    Begin
      If Not fEmptyStr(strMsg) Then
        strMsg := strMsg + #10#13;
      strMsg := strMsg + 'ORDEM DE PAGAMENTO: '+FormatFloat('#,##0.00', fltOrdPagNeg);  
    End;
    If fltValCreNeg > 0 Then
    Begin
      If Not fEmptyStr(strMsg) Then
        strMsg := strMsg + #10#13;
      strMsg := strMsg + 'UTILIZAÇÃO DE CRÉDITO: '+FormatFloat('#,##0.00', fltValCreNeg);  
    End;
    
    pMensagemOk('Valor não pode ser maior que o valor negociado no pedido: ' + #10#13 + strMsg);
  end;

  Var
    strCrtDevSintetizadasConfDocs: String;

  function fVeiodeCH: Boolean;
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Recebimento de documento proveniente de cheque.');
    objLiberacao.objMsgLibera.pAddTexto('Existem duplicatas com espécie CH, ou seja, documento ' +
                                        'proveniente de um cheque transformado em contas a receber. ');
    objLiberacao.objMsgLibera.pAddTexto('Não é permitido receber nessa modalidade (Cheque/Cartão).');

    objLiberacao.strDirAce := 'CTRCHQ';
    objLiberacao.strMsgSen := 'Recebimento de documento proveniente de cheque';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  End;

begin

  Result := False;

  {************************************}
  {* VALIDA DINHEIRO                  *}
  {*********************************AF*}

  If (Sender = edtDinheiro) Then
  Begin

    If (fFormataFloat(fltDinheiNeg, 2) > 0) And (fFormataFloat(fStrToFloat(edtDinheiro.Text), 2) > fFormataFloat(fltDinheiNeg, 2)) Then
    Begin
      pMostraMensagemModalidadeMaior;
      Result := False;
    End   
    Else If (fEmptyStr(edtDinheiro.Text)) Then
    Begin
      edtDinheiro.Text := '0,00';
    End
    Else
      Result := fValidaValorMod(fStrToFloat(edtDinheiro.Text), 'dinheiro');

    If Result And (fStrToFloat(edtDinheiro.Text) <> 0.0) And (Not fPermiteModalidadeParaPortador(strPorBai, 'MODDIN')) Then
    Begin
      fMensagem('','O Portador para baixa não tem permissão para esta modalidade!',['&OK']);
      Result := False;
    End;
    
    If Result Then
      pAtualizaValDig;

  End

  {************************************}
  {* VALIDA CHEQUE A VISTA            *}
  {*********************************AF*}
  Else If (Sender = edtChqVista) Then
  Begin

    If InterlockedIncrement(intDigitChq) = 0 Then
    Begin

      If (fFormataFloat(fltChqVisNeg, 2) > 0) And (fFormataFloat(fStrToFloat(edtChqVista.Text), 2) > fFormataFloat(fltChqVisNeg, 2)) Then
      Begin
        pMostraMensagemModalidadeMaior;
        Result := False;
        InterlockedDecrement(intDigitChq);
        Exit;
      End   
      Else If (fEmptyStr(edtChqVista.Text)) Then
        edtChqVista.Text := '0,00'
      Else
        Result := fValidaValorMod(fStrToFloat(edtChqVista.Text), 'cheque a vista');

      If Result And (fStrToFloat(edtChqVista.Text) <> 0.0) And (Not fPermiteModalidadeParaPortador(strPorBai, 'MODCHV')) Then
      Begin
        fMensagem('','O Portador para baixa não tem permissão para esta modalidade!',['&OK']);
        Result := False;
      End;

      {*************************************************}
      {*                                               *}
      {* VERIFICA SE EXISTE ALGUM DOCUMENTO MARCADO    *}
      {* COM ESPÉCIE CH, O QUE SIGNIFICA QUE O MESMO   *}
      {* VEIO DE UMA DEVOLUÇÃO DEFINITIVA OU TRANFERIU *}
      {* O CHEQUE PARA O CTR.                          *}
      {* CASO SEJA ISSO DEVE SER SOLICITADO UMA SENHA  *}
      {* DE LIBERAÇÃO PARA O MESMO                     *}
      {*                                               *}
      {**24/02/2015**REQ:30058***********************AF*}
      If Result And blnVeiodeCH And (fStrToFloat(edtChqVista.Text) <> 0.0) Then
      Begin
        If Not fVeiodeCH Then
        Begin
          Result := False;
          edtChqVista.Text := '0,00';
        End;
      End;

      If Result And (blnCtaRec And ((fStrToFloat(edtChqVista.Text) <> fltChqVis)
          Or (Not cdsChqVis.IsEmpty))) Then
        Result := fChequeVis(edtChqVista.Text)
      Else
      {*******************************}
      {* SE ESTIVER CONFIGURADO PARA *}
      {* CADASTRAR CHEQUES A VISTA   *}
      {****************************AF*}
      If Result And (fStrToFloat(edtChqVista.Text) <> 0.0) Then
        Result := fChequeVis(edtChqVista.Text);

      If Result Then
        pAtualizaValDig;

      InterlockedDecrement(intDigitChq);
    End
    Else
      InterlockedDecrement(intDigitChq);
  End

  {************************************}
  {* VALIDA CHEQUE A PRAZO            *}
  {*********************************AF*}
  Else If (Sender = edtChqPre) Then
  Begin

    If InterlockedIncrement(intDigitChq) = 0 Then
    Begin

      If (fFormataFloat(fltChqPreNeg, 2) > 0) And (fFormataFloat(fStrToFloat(edtChqPre.Text), 2) > fFormataFloat(fltChqPreNeg, 2)) Then
      Begin
        pMostraMensagemModalidadeMaior;
        Result := False;
        InterlockedDecrement(intDigitChq);
        Exit;
      End   
      Else If (fEmptyStr(edtChqPre.Text)) Then
        edtChqPre.Text := '0,00'
      Else
        Result := fValidaValorMod(fStrToFloat(edtChqPre.Text), 'cheque - pré');

      If Result And (fStrToFloat(edtChqPre.Text) <> 0.0) And (Not fPermiteModalidadeParaPortador(strPorBai, 'MODCHP')) Then
      Begin
        fMensagem('','O Portador para baixa não tem permissão para esta modalidade!',['&OK']);
        Result := False;
      End;
      
      {*************************************************}
      {*                                               *}
      {* VERIFICA SE EXISTE ALGUM DOCUMENTO MARCADO    *}
      {* COM ESPÉCIE CH, O QUE SIGNIFICA QUE O MESMO   *}
      {* VEIO DE UMA DEVOLUÇÃO DEFINITIVA OU TRANFERIU *}
      {* O CHEQUE PARA O CTR.                          *}
      {* CASO SEJA ISSO DEVE SER SOLICITADO UMA SENHA  *}
      {* DE LIBERAÇÃO PARA O MESMO                     *}
      {*                                               *}
      {**24/02/2015**REQ:30058***********************AF*}
      If Result And blnVeiodeCH And (fStrToFloat(edtChqPre.Text) <> 0.0) Then
      Begin
        If Not fVeiodeCH Then
        Begin
          Result := False;
          edtChqPre.Text := '0,00';
        End;
      End;

      If Result And (blnCtaRec And ((fStrToFloat(edtChqPre.Text) <> fltChqPre)
          Or (Not cdsChqPre.IsEmpty))) Then
          Result := fChequePre(edtChqPre.Text)
      Else

      If Result And (fStrToFloat(edtChqPre.Text) <> 0.0) Then
        Result := fChequePre(edtChqPre.Text);

      If Result Then
        pAtualizaValDig;

      InterlockedDecrement(intDigitChq);
    End
    Else
      InterlockedDecrement(intDigitChq);
  End

  {************************************}
  {* VALIDA CARTÃO                    *}
  {*********************************AF*}
  Else If (Sender = edtCartao) and (not blnCartaoConferidoEConfirmado) Then
  Begin

    If (fFormataFloat(fltCartaoNeg, 2) > 0) And (fFormataFloat(fStrToFloat(edtCartao.Text), 2) > fFormataFloat(fltCartaoNeg, 2)) Then
    Begin
      pMostraMensagemModalidadeMaior;
      Result := False;
    End   
    Else If (fEmptyStr(edtCartao.Text)) Then
    Begin
      edtCartao.Text := '0,00';
      SetLength(arrCartoes, 0);
    End
    Else
      Result := fValidaValorMod(fStrToFloat(edtCartao.Text), 'cartão');

    If Result And (fStrToFloat(edtCartao.Text) <> 0.0) And (Not fPermiteModalidadeParaPortador(strPorBai, 'MODCAR')) Then
    Begin
      fMensagem('','O Portador para baixa não tem permissão para esta modalidade!',['&OK']);
      Result := False;
    End;
    
    {*************************************************}
    {*                                               *}
    {* VERIFICA SE EXISTE ALGUM DOCUMENTO MARCADO    *}
    {* COM ESPÉCIE CH, O QUE SIGNIFICA QUE O MESMO   *}
    {* VEIO DE UMA DEVOLUÇÃO DEFINITIVA OU TRANFERIU *}
    {* O CHEQUE PARA O CTR.                          *}
    {* CASO SEJA ISSO DEVE SER SOLICITADO UMA SENHA  *}
    {* DE LIBERAÇÃO PARA O MESMO                     *}
    {*                                               *}
    {**24/02/2015**REQ:30058***********************AF*}
    If Result And blnVeiodeCH And (fStrToFloat(edtCartao.Text) <> 0.0) Then
    Begin
      If Not fVeiodeCH Then
      Begin
        Result := False;
        edtCartao.Text := '0,00';
      End;
    End;

    If Result And (fStrToFloat(edtCartao.Text) <> 0.0) Then
    begin
      if blnConsignacao then
      begin
        Result := True;
        If fCfgSis('BAIAVI', varBoolean) then
          Result := fDigitacaoCartoes(fStrToFloat(edtCartao.Text), arrCartoes);
      end
      else
        Result := fDigitacaoCartoes(fStrToFloat(edtCartao.Text), arrCartoes);

      pHabilitaAdtCarPed(Result) ;
    end;

    If Result Then
    begin
      pAtualizaValDig;

      If ((blnConsignacao) and (fCfgSis('BAIAVI', varBoolean))) then
      begin
        if fStrToFloat(edtCartao.Text) = fltValTot then
        begin
          blnCartaoConferidoEConfirmado := True;
          btnConfirmaDadosClick(Sender);
        end;
      end;
    end;

  End

  {************************************}
  {* VALIDA ORDEM DE PAGAMENTO        *}
  {*********************************LA*}
  Else If (Sender = edtOrdPag) Then
  Begin

    If (fFormataFloat(fltOrdPagNeg, 2) > 0) And (fFormataFloat(fStrToFloat(edtOrdPag.Text), 2) > fFormataFloat(fltOrdPagNeg, 2)) Then
    Begin
      pMostraMensagemModalidadeMaior;
      Result := False;
    End   
    Else If (fEmptyStr(edtOrdPag.Text)) Then
    Begin
      edtOrdPag.Text := '0,00';
    End
    Else
      Result := fValidaValorMod(fStrToFloat(edtOrdPag.Text), 'ordem de pagamento');

    If Result And (fStrToFloat(edtOrdPag.Text) <> 0.0) And (Not fPermiteModalidadeParaPortador(strPorBai, 'MODORD')) Then
    Begin
      fMensagem('','O Portador para baixa não tem permissão para esta modalidade!',['&OK']);
      Result := False;
    End;
    
    If Result Then
      pAtualizaValDig;

  End

  {**********************************}
  {* VALIDA BOLETO                  *}
  {*******************************AJ*}
  Else If (Sender = edtValorBoleto) Then
  Begin

    If (fEmptyStr(edtValorBoleto.Text)) Then
      edtValorBoleto.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtValorBoleto.Text), 'boleto');

    If Result And (fStrToFloat(edtValorBoleto.Text) <> 0.0) And (Not fPermiteModalidadeParaPortador(strPorBai, 'MODDIN')) Then
    Begin
      fMensagem('ATENÇÃO', 'O Portador para baixa não tem permissão para esta modalidade!',['&OK']);
      Result := False;
    End;

    If Result Then
      pAtualizaValDig;

  End

  {************************************}
  {* CHEGO A PARTE CHATA PRA CACETE   *}
  {* NEM SEI COMU FAIZ!!!!!!!!        *}
  {*********************************AF*}
  Else If (Sender = edtFaturado) Then
  Begin

    If (fEmptyStr(edtFaturado.Text)) Then
      edtFaturado.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtFaturado.Text), 'faturado');

    if Result then
    begin
      if blnSelCndPag then
      begin
        if fltValFatAnt = fStrToFloat(edtFaturado.Text) then
          Exit;
      end;
    end;

    If Result And (fStrToFloat(edtFaturado.Text) <> 0.0) Then
      Result := fFaturado(fStrToFloat(edtFaturado.Text));

    If Result Then
      pAtualizaValDig;

  End

  Else If (Sender = edtFinanc) Then
  Begin

    If (fEmptyStr(edtFinanc.Text)) Then
    Begin
      edtFinanc.Text := '0,00';

      If Assigned(fatVenda) Then
      Begin
        fatVenda.fltValFin := 0;
        fatVenda.objFinanc.pLimpaDados;
      End;

    End
    Else
      Result := fValidaValorMod(fStrToFloat(edtFinanc.Text), 'financiamento');

    If Result And (fStrToFloat(edtFinanc.Text) <> 0.0) And (Not fPermiteModalidadeParaPortador(strPorBai, 'MODFIN')) Then
    Begin
      fMensagem('','O Portador para baixa não tem permissão para esta modalidade!',['&OK']);
      Result := False;
    End;

    If Result And (fStrToFloat(edtFinanc.Text) <> 0.0) Then
    Begin

      If Assigned(fatVenda) Then
      Begin
        fatVenda.fltValFin := fStrToFloat(edtFinanc.Text);

        Result := fatVenda.fPedeDadosFinanceira(fRetEntrada);
      End

      Else Result := False;

    End;

    If Result Then
      pAtualizaValDig;

  End
  Else If (Sender = edtValCre) Then
  Begin

    If (fFormataFloat(fltValCreNeg, 2) > 0) And (fFormataFloat(fStrToFloat(edtValCre.Text), 2) > fFormataFloat(fltValCreNeg, 2)) Then
    Begin
      pMostraMensagemModalidadeMaior;
      Result := False;
    End   
    Else If (fEmptyStr(edtValCre.Text)) Then
    Begin
      edtValCre.Text := '0,00';
    End
    Else
      Result := fValidaValorMod(fStrToFloat(edtValCre.Text), 'utilizar créditos');

//    if (fltValCreAnt <> fStrToFloat(edtValCre.Text) then
//    begin
//      stlDupCreditos.Clear;
//      stlLckCreditos.Clear;
//    end;

    If Assigned(fatVenda) Then
      strCrtDevSintetizadasConfDocs := fatVenda.fRetDuplicatasDevolucaoSintetizadasConfDocs;

    If Result And (fStrToFloat(edtValCre.Text) <> 0.0) and (fltValCreAnt <> fStrToFloat(edtValCre.Text)) Then
      Result := TAdiantamento.fSelecionarCreditos(strCliente, 'CTR', fStrToFloat(edtValCre.Text), fltTotCreditos, stlDupCreditos, stlLckCreditos, '', Nil, strCrtDevSintetizadasConfDocs);

    If Result Then
    Begin
      pAtualizaDupsCred;
      pAtualizaValDig;
      fltValCreAnt := fStrToFloat(edtValCre.Text);
    End
    Else
      fltValCreAnt := 0;
  End;
end;

{************************************}
{* DIGITAÇÃO DOS CARTÕES            *}
{*********************************MV*}
function TfrmFatFormasPagamento.fDigitacaoCartoes(fltValor: Double;
   Var arrCartoes: TCartoesResumoCaixaArray; strCodCar: String = '';
   strCodFin: String = ''; intQtdPar: Integer = 0): Boolean;
  Var
    fltTotCar: Double;
    intTamMat: Integer;
    intContador: Integer;
    intContador2: Integer;
    intContador3: Integer;

    strDesCar: String;
    fltValDig: Double;
    fltValDes: Double;
    fltPerDes: Double;
    strCndPag: String;
    strObsCar: String;
    strNumCcd: String;
    strNumNsu: String;
    strTipCar: String;
    strViaCli: String;
    strViaLoj: String;
    strNumDoc: String;
    strDtaTra: String;
    strHraTra: String;
    strStatusCartao: String;
    dtaDatTra: TDateTime;

    strPixS_N: String;
    strChaPix: String;
    strCodigoCarteiraDigital: String;
    strCodigoTipoOperacaoCartao: String;
    strCodigoBandeira: String;

    blnSaiFor: Boolean;

    stlDeletados: TStringList;
    frmRcxMostraCartoes : TfrmRcxMostraCartoes;
    frmRcxDigCartoes : TfrmRcxDigCartoes;

    LstrArquivoTef: String;
    LstrControle: String;
begin

  Result    := True;

  fltValDig := 0.0;
  fltValDes := 0.0;
  fltPerDes := 0.0;
  dtadattra := 0;

  If (fltValor = 0.0) Then
  Begin
    SetLength(arrCartoes, 0);
    Exit;
  End;

  If (fCfgSis('DIGCAR') <> 'S') Then
  Begin
    SetLength(arrCartoes, 0);
    Exit;
  End;

  pCriarFormularios(TfrmRcxDigCartoes, frmRcxDigCartoes);

  fltTotCar := 0.0;
  For intContador := 0 To Length(arrCartoes) -1 Do
  Begin
    fltTotCar := fltTotCar + arrCartoes[intContador].fltValDig;
  End;

  If (fFormataFloat(fltTotCar,2) = fFormataFloat(fltValor,2)) Then
  Begin

    Try
      pCriarFormularios(TfrmRcxMostraCartoes, frmRcxMostraCartoes);

      For intContador := 0 To Length(arrCartoes) -1 Do
      Begin
        frmRcxMostraCartoes.lsvCartoes.AddItem(arrCartoes[intContador].strCodCar + ' - ' +
                                               arrCartoes[intContador].strDesCar, Nil);
        frmRcxMostraCartoes.lsvCartoes.Items[intContador].SubItems.Add(FloatToStrF(arrCartoes[intContador].fltValDig, ffFixed, 12, 2));
        frmRcxMostraCartoes.lsvCartoes.Items[intContador].SubItems.Add(IntToStr(arrCartoes[intContador].intCodSeq));
      End;

      frmRcxMostraCartoes.lsvCartoes.Columns[2].Width := 0;

      frmRcxMostraCartoes.ShowModal;

      blnConfCartoes := frmRcxMostraCartoes.blnConfirma;

      stlDeletados := frmRcxMostraCartoes.stlDeletados;

      For intContador := 0 To stlDeletados.Count -1 Do
      Begin

        blnSaiFor := False;

        For intContador2 := 0 To Length(arrCartoes) -1 Do
        Begin

          If (arrCartoes[intContador2].intCodSeq = StrToInt(stlDeletados[intContador])) Then
          Begin

            if Assigned(FobjTefRecebimento) then
              frmRcxDigCartoes.pGarantirCancelamentoTefRecebimento(FobjTefRecebimento, arrCartoes[intContador2].strArqTef);

            For intContador3 := intContador2 To Length(arrCartoes) - 2 Do
            Begin
              arrCartoes[intContador3] := arrCartoes[intContador3+1];
            End;
            SetLength(arrCartoes, Length(arrCartoes)-1);
            blnSaiFor := True;
          End;

          If (blnSaiFor) Then
            Break;

        End;

      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmFatFormasPagamento.fDigitacaoCartoes]');
      End;
    End;

    pFreeAndNil(frmRcxMostraCartoes);
  End;

  fltTotCar := 0.0;
  For intContador := 0 To Length(arrCartoes) -1 Do
  Begin
    fltTotCar := fltTotCar + arrCartoes[intContador].fltValDig;
  End;

  If fFormataFloat(fltValor,2) < fFormataFloat(fltTotCar,2) Then
  Begin
    fltTotCar := 0.0;
    SetLength(arrCartoes,0);
  End;

  While RoundTo(fltTotCar, -2) < RoundTo(fltValor, -2) Do
  Begin

    Try
      frmRcxDigCartoes.strCodFin := strCodFin;
      frmRcxDigCartoes.strCodCar := strCodCar;
      frmRcxDigCartoes.intQtdPar := intQtdPar;

      frmRcxDigCartoes.blnTroCar := blnTroCar;
      frmRcxDigCartoes.fltTotDig := fltTotCar;
      frmRcxDigCartoes.fltTotGer := fltValor;
      frmRcxDigCartoes.fltMaxDig := (fltValor - fltTotCar);
      frmRcxDigCartoes.arrCartoes := arrCartoes;

      if Assigned(FobjTefRecebimento) then
      Begin
        frmRcxDigCartoes.blnExecutandoPeloFaturamento := FblnExecutandoPeloFaturamento;
        frmRcxDigCartoes.strSessaoTef                 := FstrSessaoTef;
        frmRcxDigCartoes.objTefRecebimento            := FobjTefRecebimento;
        frmRcxDigCartoes.blnTefRcx                    := fCfgSis('TEFREC', varBoolean);
      End;

      if fCfgSis('SOLCAR', varBoolean) then
        frmRcxDigCartoes.intQtdNeg := intQtdPar;

      frmRcxDigCartoes.pPrepararEdits;
      frmRcxDigCartoes.strOpcDoc := 'VN';

      if (frmRcxDigCartoes.fVaiExibirPerguntaTefPos) then
        frmRcxDigCartoes.blnPermiteDigitarDados := False;

      frmRcxDigCartoes.ShowModal;

      strCodCar := frmRcxDigCartoes.edtCodCar.Text;
      strDesCar := frmRcxDigCartoes.edtDesCar.Text;
      fltValDig := frmRcxDigCartoes.fltValDig;
      dtaDatTra := frmRcxDigCartoes.dtaDatTra;
      fltValDes := frmRcxDigCartoes.fltValDes;
      strCndPag := frmRcxDigCartoes.mskCndPag.Text;
      strNumCcd := frmRcxDigCartoes.edtNumCcd.Text;
      strNumNsu := fPadL(frmRcxDigCartoes.edtNumNsu.Text, 14, '0');
      LstrControle := frmRcxDigCartoes.strControle ;
      strObsCar := frmRcxDigCartoes.edtObsCar.Text;
      fltPerDes := frmRcxDigCartoes.fltPerDes;
      strTipCar := IIF(frmRcxDigCartoes.blnTipPOS, 'POS', 'TEF');
      LstrArquivoTef := frmRcxDigCartoes.strArquivoTef;
      strPixS_N := frmRcxDigCartoes.strPixS_N;
      strChaPix := frmRcxDigCartoes.strChaPix;
      strCodigoCarteiraDigital := frmRcxDigCartoes.strCodigoCarteiraDigital;
      strCodigoTipoOperacaoCartao := frmRcxDigCartoes.strCodigoTipoOperacaoCartao;
      strCodigoBandeira := frmRcxDigCartoes.strCodigoBandeira;
      strViaCli := frmRcxDigCartoes.strArqViaCliente;
      strViaLoj := frmRcxDigCartoes.strArqViaLojista;
      strNumDoc := frmRcxDigCartoes.strNumDoc;
      strDtaTra := frmRcxDigCartoes.strDtaTra;
      strHraTra := frmRcxDigCartoes.strHraTra;
      strStatusCartao := 'P';

      Result    := frmRcxDigCartoes.blnConfirma;

      if Result then
      begin
        if (strTipCar = 'TEF') and fEmptyStr(LstrArquivoTef) then
        begin
          Result := False;
          pMensagemOk('A modalidade selecionada utiliza "TEF", ' +
                      'porém não foi encontrado o arquivo que confirma a transação TEF. ' +
                      'Entre em contato com a CITEL para solução do problema!');
        end;
      end;

      If Result Then
      Begin
        optTroco      := frmRcxDigCartoes.optTrocoCar;
        fltValorTroco := frmRcxDigCartoes.fltValorTrocoCar;
      End;
      
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[frmFatFormasPagamento.fDigitacaoCartoes_1]');
      End;
    End;

    If (Result) Then
    Begin
      intTamMat := Length(arrCartoes);
      SetLength(arrCartoes, intTamMat+1);
      arrCartoes[intTamMat].intCodSeq := intTamMat;
      arrCartoes[intTamMat].strCodCar := strCodCar;
      arrCartoes[intTamMat].strDesCar := strDesCar;
      arrCartoes[intTamMat].fltValDig := fltValDig;
      arrCartoes[intTamMat].strCndPag := strCndPag;
      arrCartoes[intTamMat].strObsCar := strObsCar;
      arrCartoes[intTamMat].fltValDes := fltValDes;
      arrCartoes[intTamMat].strNumCcd := strNumCcd;
      arrCartoes[intTamMat].fltPerDes := fltPerDes;
      arrCartoes[intTamMat].strCodFin := strCodFin;
      arrCartoes[intTamMat].strNumNsu := strNumNsu;
      arrCartoes[intTamMat].strControle := LstrControle;
      arrCartoes[intTamMat].strTipCar := strTipCar;
      arrCartoes[intTamMat].strArqTef := LstrArquivoTef;
      arrCartoes[intTamMat].strPixS_N := strPixS_N;
      arrCartoes[intTamMat].strChaPix := strChaPix;
      arrCartoes[intTamMat].strCodigoCarteiraDigital := strCodigoCarteiraDigital;
      arrCartoes[intTamMat].dtaDtaTra := dtaDatTra;

      if VS_blnTefCitel then
      begin
        arrCartoes[intTamMat].strViaCli := strViaCli;
        arrCartoes[intTamMat].strViaLoj := strViaLoj;
        arrCartoes[intTamMat].strNumDoc := strNumDoc;
        arrCartoes[intTamMat].strDtaTra := strDtaTra;
        arrCartoes[intTamMat].strHraTra := strHraTra;
        arrCartoes[intTamMat].strStatusCartao := strStatusCartao;
        arrCartoes[intTamMat].strConteudoArquivo := LstrArquivoTef;
        if fAutoConfirmaTransacaoPendenteEstaAtivada then
        begin
          arrCartoes[intTamMat].strCodigoTipoOperacaoCartao := strCodigoTipoOperacaoCartao;
          arrCartoes[intTamMat].strCodigoBandeira := strCodigoBandeira;
          arrCartoes[intTamMat].blnTefCnf := fAutoConfirmarTransacaoTef(arrCartoes[intTamMat]);
          if arrCartoes[intTamMat].blnTefCnf then
            arrCartoes[intTamMat].strStatusCartao := 'F';
        end;
      end;

      if Assigned(FobjTefRecebimento) then
      Begin
        If (not VS_blnTefCitel) and (Not fEmptyStr(LstrArquivoTef)) And (FileExists(LstrArquivoTef)) Then
          arrCartoes[intTamMat].strConteudoArquivo := fLerConteudoArquivo(LstrArquivoTef);

        if ((not VS_blnTefCitel) and (arrCartoes[intTamMat].strTipCar = 'TEF') and (fEmptyStr(arrCartoes[intTamMat].strConteudoArquivo))) then
        begin
          Result := False;
          pMensagemOk('A modalidade selecionada utiliza "TEF", ' +
                      'porém não foi encontrado o arquivo que c' +
                      'onfirma a transação TEF. ' +
                      'Entre em contato com a CITEL para solução do problema!');
          Exit;
        end;
      End;

      fltTotCar := 0.0;
      For intContador := 0 To Length(arrCartoes) -1 Do
      Begin
        fltTotCar := fltTotCar + arrCartoes[intContador].fltValDig;
      End;

    End
    Else
    Begin
      if Assigned(FobjTefRecebimento) then
      Begin
        frmRcxDigCartoes.pGarantirCancelamentoTefRecebimento(FobjTefRecebimento, LstrArquivoTef);
        frmRcxDigCartoes.pCancelarTefDeCartoesJaConfirmados(FobjTefRecebimento, arrCartoes);
      End;
      SetLength(arrCartoes, 0);
      Break;
    End;

    strCodCar := '';
    strViaCli := '';
    strViaLoj := '';
  End;

  pFreeAndNil(frmRcxDigCartoes);
end;

{************************************}
{* CADASTRA CHQUES A VISTA          *}
{*********************************AF*}
function TfrmFatFormasPagamento.fChequeVis(strValor: String; ARotinaChamada: String = ''): Boolean;
  Var
    fltValCar: Double;
    fltValChq: Double;
    strChave : String;
Begin
  Result    := True;
  fltValChq := 0.0;

  If Not fPrecisaDigitarChequeAVista Then
    Exit;

  If Not Assigned(cdsChqVis) Then cdsChqVis := fCriaCdsCheques(Self);

  With cdsChqVis Do
  Begin
    First;

    fltValCar := fStrToFloat(strValor);

    If cdsChqVis.RecordCount > 0 Then
    Begin
      If fltValCar = 0.0 Then
      Begin
        If fMensagem('AVISO', 'Existe(m) Cheque(s) Digitado(s)! Limpa a Digitação dos Cheques?', ['&Sim', '&Não']) = 1 Then
          cdsChqVis.CancelUpdates
        Else
        Begin
          fMensagem('Aviso','Informe o valor de Cheque a Vista!!!',['&OK']);
          Result := False;
          pSetFocus(edtChqVista);
        End;
        Exit;
      End;

      Try
        pCriarFormularios(TfrmRcxMostraCheques,frmRcxMostraCheques);
        frmRcxMostraCheques.dsCheques.DataSet := cdsChqVis;
        frmRcxMostraCheques.ShowModal;

        fltValChq := frmRcxMostraCheques.fltValTot;
      Except
        On E: Exception Do
        Begin
          fltValChq := 0.0;
          pMensagensErro(E.Message, '[fChequeVis]');
        End;
      End;

      pFreeAndNil(frmRcxMostraCheques);
    End;

    If fltValChq <> fltValCar Then
    Begin
      Try

        pCriarFormularios(TfrmCadCheques,frmCadCheques);
        frmCadCheques.strCodOpe         := strCodOpe;
        frmCadCheques.blnResumida       := True;
        frmCadCheques.blnResCai         := Not(blnCtaRec);

        frmCadCheques.blnGravacaoFisica := False;
        frmCadCheques.fltValTot         := fltValCar;
        frmCadCheques.blnPrazo          := False;
        frmCadCheques.cdsChqRcx         := cdsChqVis;
        frmCadCheques.dbeDtaCad.Enabled := False;
        frmCadCheques.dbeDtaCad.TabStop := False;
        frmCadCheques.dbeDtaVen.Enabled := False;
        frmCadCheques.dbeDtaVen.TabStop := False;

        frmCadCheques.cdsChqOutroTip.Data := cdsChqPre.Data;

        frmCadCheques.RotinaChamada := 'BAIXA DE CONTAS A RECEBER';
        If Assigned(fatVenda) Then
        Begin
          If MatchStr(fatVenda.strOpcDoc, ['CF', 'CP']) Then
            frmCadCheques.RotinaChamada := 'CONFIRMAÇÃO DE VENDAS'
          Else
            frmCadCheques.RotinaChamada := 'VENDA';
        End
        Else
        Begin
          If Not ARotinaChamada.IsEmpty Then
            frmCadCheques.RotinaChamada := ARotinaChamada;
        End;

        frmCadCheques.blnJaIncluiu      := True;
        frmCadCheques.edtTotDig.Text := FormatFloat('#,##0.00',fltValChq);
        frmCadCheques.edtTotGer.Text := FormatFloat('#,##0.00',fltValCar);

        frmCadCheques.blnTroChq         := blnTroChq;
        frmCadCheques.strDocume         := IIF(strDocume <> 'DIVERSOS', strDocume + 'AVI', strDocume);
        frmCadCheques.strCliente        := strCliente;
        frmCadCheques.dicCheques        := TDictionary<String, TChequeEmitido>.Create;
        frmCadCheques.blnCtaRec         := blnCtaRec;

        frmCadCheques.strConfDocsAutIncCadRec := strConfDocsAutIncCadRec;

        If Not blnCtaRec Then
          If (Assigned(dicCheques)) And
             (dicCheques.Count > 0) Then
          Begin
            For strChave In dicCheques.Keys Do
              frmCadCheques.dicCheques.AddOrSetValue(strChave, dicCheques[strChave]);
          End;

        pAdicionaCtrBaixando;

        frmCadCheques.ShowModal;

        cdsChqVis.Data := frmCadCheques.cdsTabela.Data;

        If IsEmpty Or (Not frmCadCheques.blnConfima) Then
        Begin
          Result := False;
        End;

        If Result Then
        Begin
          optTroco      := frmCadCheques.optTroco;
          fltValorTroco := frmCadCheques.fltValorTroco;
        End;

        If (Assigned(frmCadCheques.dicCheques)) And
           (frmCadCheques.dicCheques.Count > 0) Then
        Begin
          For strChave In frmCadCheques.dicCheques.Keys Do
            dicCheques.AddOrSetValue(strChave, frmCadCheques.dicCheques[strChave]);
        End;

      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, '[frmFatFormasPagamento.fChequeVis]');
        End;
      End;
      pFreeAndNil(frmCadCheques);

    End;

  End;

End;

function TfrmFatFormasPagamento.fPrecisaDigitarChequeAVista: Boolean;
begin
  Result := (fCfgSis('CHQRCX') = 'S') And (fCfgSis('CHQVIS') = 'S');
end;

{************************************}
{* CADASTRA OS CHEQUES A PRAZO.     *}
{* NÃO É IGUAL O CJEQUE PRE VIU NÃO *}
{* SE ENGANE                        *}
{*********************************AF*}
function TfrmFatFormasPagamento.fChequePre(strValor: String; ARotinaChamada: String = ''): Boolean;
  Var
    fltValCar: Double;
    fltValChq: Double;
    strChave : String;
Begin
  Result    := True;
  fltValChq := 0.0;

  If Not fPrecisaDigitarChequePre Then
    Exit;

  If Not Assigned(cdsChqPre) Then cdsChqPre := fCriaCdsCheques(Self);

  With cdsChqPre Do
  Begin
    First;

    fltValCar := fStrToFloat(strValor);

    If cdsChqPre.RecordCount > 0 Then
    Begin
      If fltValCar = 0.0 Then
      Begin
        If fMensagem('AVISO', 'Existe(m) Cheque(s) Digitado(s)! Limpa a Digitação dos Cheques?', ['&Sim', '&Não']) = 1 Then
          cdsChqPre.CancelUpdates
        Else
        Begin
          fMensagem('Aviso','Informe o valor de Cheque - Pré!!!',['&OK']);
          Result := False;
          pSetFocus(edtChqPre);
        End;
        Exit;
      End;

      Try
        pCriarFormularios(TfrmRcxMostraCheques,frmRcxMostraCheques);
        frmRcxMostraCheques.dsCheques.DataSet := cdsChqPre;
        frmRcxMostraCheques.ShowModal;

        // ***** Verifica prazo medio para recebimento de cheque pré. ***** //
        Result := fVerificaPrazoRecebimentoChequePre( cdsChqPre );
        If Not Result Then
           cdsChqPre.EmptyDataSet;

        fltValChq := frmRcxMostraCheques.fltValTot;

      Except
        On E: Exception Do
        Begin
          fltValChq := 0.0;
          pMensagensErro(E.Message, '[fChequePre]');
        End;
      End;

      pFreeAndNil(frmRcxMostraCheques);
    End;

    If fFormataFloat(fltValChq,2) <> fFormataFloat(fltValCar,2) Then
    Begin
      Try
        pCriarFormularios(TfrmCadCheques,frmCadCheques);
        frmCadCheques.strCodOpe  := strCodOpe;
        frmCadCheques.blnResumida       := True;
        frmCadCheques.blnResCai         := Not(blnCtaRec);

        frmCadCheques.blnGravacaoFisica := False;
        frmCadCheques.fltValTot  := fltValCar;
        frmCadCheques.blnPrazo   := True;
        frmCadCheques.cdsChqRcx  := cdsChqPre;
        frmCadCheques.blnTroChq  := blnTroChq;

        frmCadCheques.cdsChqOutroTip.Data := cdsChqVis.Data;

        frmCadCheques.RotinaChamada := 'BAIXA DE CONTAS A RECEBER';
        If Assigned(fatVenda) Then
        Begin
          If MatchStr(fatVenda.strOpcDoc, ['CF', 'CP']) Then
            frmCadCheques.RotinaChamada := 'CONFIRMAÇÃO DE VENDAS'
          Else
            frmCadCheques.RotinaChamada := 'VENDA';
        End
        Else
        Begin
          If Not ARotinaChamada.IsEmpty Then
            frmCadCheques.RotinaChamada := ARotinaChamada;
        End;

        frmCadCheques.blnJaIncluiu      := True;
        frmCadCheques.edtTotDig.Text := FormatFloat('#,##0.00',fltValChq);
        frmCadCheques.edtTotGer.Text := FormatFloat('#,##0.00',fltValCar);

        frmCadCheques.strDocume  := IIF(strDocume <> 'DIVERSOS', strDocume + 'PRZ', strDocume);
        frmCadCheques.strCliente := strCliente;
        frmCadCheques.dicCheques := TDictionary<String, TChequeEmitido>.Create;
        frmCadCheques.blnCtaRec  := blnCtaRec;

        frmCadCheques.strConfDocsAutIncCadRec := strConfDocsAutIncCadRec;

        If Not blnCtaRec Then
          If (Assigned(dicCheques)) And
             (dicCheques.Count > 0) Then
          Begin
            For strChave In dicCheques.Keys Do
              frmCadCheques.dicCheques.AddOrSetValue(strChave, dicCheques[strChave]);
          End;

        pAdicionaCtrBaixando;

        frmCadCheques.ShowModal;

        cdsChqPre.Data := frmCadCheques.cdsTabela.Data;

        If IsEmpty Or (Not frmCadCheques.blnConfima) Then
        Begin
          Result := False;
        End;

        if Result then
        Begin
          // ***** Verifica prazo medio para recebimento de cheque pré. ***** //
          Result := fVerificaPrazoRecebimentoChequePre( cdsChqPre );
          if Not Result then
             cdsChqPre.EmptyDataSet;
        End;

        If Result Then
        Begin
          optTroco      := frmCadCheques.optTroco;
          fltValorTroco := frmCadCheques.fltValorTroco;
        End;

        If (Assigned(frmCadCheques.dicCheques)) And
           (frmCadCheques.dicCheques.Count > 0) Then
        Begin
          For strChave In frmCadCheques.dicCheques.Keys Do
            dicCheques.AddOrSetValue(strChave, frmCadCheques.dicCheques[strChave]);
        End;
      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, '[frmFatFormasPagamento.fChequePre]');
        End;
      End;
      pFreeAndNil(frmCadCheques);
    End;

  End;

End;

function TfrmFatFormasPagamento.fPrecisaDigitarChequePre: Boolean;
begin
  Result := (fCfgSis('CHQRCX') = 'S')
end;

{*************************************}
{* ESSA FUNÇAO EH DU-KARALHO, NEM EU *}
{* QUE FIZ SEI O QUE ELA FAZ HEHEHE  *}
{**********************************AF*}
function TfrmFatFormasPagamento.fFaturado(fltValor: Double): Boolean;
  Var
    intContador: Integer;
    strConPag  : String;
    dtaDtaBas  : TDate;
    frmDigCndPagamento : TfrmDigCndPagamento;
Begin
  {*****************************************}
  {* CHAMA A TELA DE CONDIÇÃO DE PAGAMENTO *}
  {**************************************AF*}
  Try
    pCriarFormularios(TfrmDigCndPagamento, frmDigCndPagamento);
    frmDigCndPagamento.fraDigCndPagamento.pnlForPag.Visible := False;
    frmDigCndPagamento.Height := frmDigCndPagamento.Height - frmDigCndPagamento.fraDigCndPagamento.pnlForPag.Height;
    frmDigCndPagamento.fraDigCndPagamento.mskCndPag.EditMask := MASK_CONPAG;

    frmDigCndPagamento.fraDigCndPagamento.edtCodCnd.Text := strCodCnd;
    frmDigCndPagamento.fraDigCndPagamento.strCcnAnt      := strCodCnd;
    frmDigCndPagamento.fraDigCndPagamento.strCndPag      := strMskCnd;
    frmDigCndPagamento.fraDigCndPagamento.mskCndPag.Text := strMskCnd;

    frmDigCndPagamento.showModal;

    Result := frmDigCndPagamento.fraDigCndPagamento.blnConfirma;

    If Result Then
    Begin

      strMskCnd := frmDigCndPagamento.fraDigCndPagamento.strCndPag;
      strCodCnd := frmDigCndPagamento.fraDigCndPagamento.edtCodCnd.Text;

      If Copy(frmDigCndPagamento.fraDigCndPagamento.mskCndPag.Text,3,3) <= '000' Then
      Begin
        fMensagem('','A condição de pagamento deve ser a prazo!',['&OK']);
        Result := False;
      End;

    End;

    If Result Then
    Begin

      Repeat
        dtaDtaBas := VS_Date;

        {***************************************************************************************}
        {* UTILIZA A DATA DA EMISSÃO DO PEDIDO COMO BASE PARA CALCULO DA CONDIÇÃO DE PAGAMENTO *}
        {************************************************************************************PZ*}
        If (blnAltBas) Then
          dtaDtaBas := dtaDtaEntOri;

        pZeraDigDuplic(fatVenda.arrDuplicata);
        Result := fDigDuplic(fatVenda.arrDuplicata, strMskCnd, 0, fltValor, True, True, False, dtaDtaBas, False, 0, 'N', True, False, 0, False, Nil, '',
        True, True, Nil, '', False, True, '', '', Nil, fatVenda.fFaturandoPedido);

        If Not Result Then
          Break;

        intContador := 0;
        {*****************************************}
        {* REFAZ A CONDIÇÃO DE PAGAMENTO         *}
        {* E VERIFICA SE EH A VISTA              *}
        {**************************************AF*}
        While (fatVenda.arrDuplicata[intContador].dtaDtaVen <> '') And
              (intContador < 23)                          Do
        Begin

          SetLength(arrDatas, intContador + 1);
          arrDatas[intContador] := StrToDate(fatVenda.arrDuplicata[intContador].dtaDtaVen);
          Inc(intContador);

        End;
        strConPag := fRetornaCndPag(arrDatas, VS_Date);

        If Copy(strConPag,3,3) <= '000' Then
        Begin
          fMensagem('','A condição de pagamento deve ser a prazo!',['&OK']);
          Result := False;
        End;

        If Result Then Break;

      Until False;

    End;

    if Result then
      blnSelCndPag := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[frmFatFormasPagamento.fFaturado]');
    End;
  End;

  pFreeAndNil(frmDigCndPagamento);

End;

function TfrmFatFormasPagamento.fChequesCadastrados(fltValor: Double; blnPrazo: Boolean): Boolean;
  Var
    cdsTemp: TUniClientDataSet;
    fltTotal: Double;
Begin
  fltTotal := 0.00;

  If blnPrazo Then cdsTemp := cdsChqPre Else cdsTemp := cdsChqVis;

  With cdsTemp Do
    If Assigned(cdsTemp) And (Not IsEmpty) Then
      fltTotal := TAggregateField(FieldByName('TOT_VALCHQ')).Value;

  Result := (fFormataFloat(fltValor, 2) = fFormataFloat(fltTotal, 2));

End;

procedure TfrmFatFormasPagamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If FValidarPixNoOnClose Then
  Begin
    If Not ValidarSeExistePixRecebidoSemConfirmacao Then
    Begin
      Action := CaNone;
      ModalResult := mrNone;

      Exit;
    End;
  End;

  inherited;

end;

procedure TfrmFatFormasPagamento.FormCreate(Sender: TObject);
begin
  inherited;
  blnGerCre      := True;
  blnCtaRec      := False;
  blnTroChq      := False;
  blnTroCar      := False;
  optTroco       := otNada;
  fltValorTroco  := 0.0;
  fltValCre      := 0;
  fltValCrd      := 0;
  intGravando    := -1;
  intDigitChq    := -1;
  fatVenda       := Nil;
  blnConfCartoes := True;
  blnVeiodeCH    := False;
  blnAltBas      := False;
  strPorBai      := '';
  blnConsignacao := False;
  blnFpg009      := False;

  fltDinheiNeg := 0;
  fltChqVisNeg := 0;
  fltChqPreNeg := 0;
  fltCartaoNeg := 0;
  fltOrdPagNeg := 0;
  fltValCreNeg := 0;

  FValorBoleto := 0;

  dtaDtaEntOri := VS_Date;

  dicCheques     := TDictionary<String, TChequeEmitido>.Create;
  objLiberacao := TLiberacao.Create;

  FobjTefRecebimento            := Nil;
  FstrSessaoTef                 := '';
  FblnExecutandoPeloFaturamento := False;

  FMenorDataRecebimento := 0;

  FValidarPixNoOnClose := True;
  blnTravaCondicaoPagamentoFaturadoSozinho := True;
end;

procedure TfrmFatFormasPagamento.FormDestroy(Sender: TObject);
begin
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  inherited;
end;

procedure TfrmFatFormasPagamento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //Para resolver problema do foco no botão, ao apertar ENTER
  If btnReceberPix.Enabled Then
  Begin
    If edtOrdPag.Focused Then
    Begin
      If Key = VK_Return Then
      Begin
        If fValidaCampos(edtOrdPag) Then
        Begin
          pSetFocus(btnConfirmaDados);
          pSetFocus(btnReceberPix);
        End;
        Key := 0;
      End;
    End;
  End;

  inherited;

end;

procedure TfrmFatFormasPagamento.AbreTelaParaPagamentoDoPix;
  Var
    LErro,
    LChavePix,
    LRetornoPix,
    LCodigoCliente,
    LChaveDocumento: String;

    LDadosRequisicaoPixAVista: TDadosRequisicaoPixAVista;
begin
  Try
    LCodigoCliente := EmptyStr;

    if blnFpg009 then
    begin
      LDadosRequisicaoPixAVista := TFuncoesPixAutcom.RetornaDadosRequisicaoPedido(fatVenda,
                                                                                  fStrToFloat(edtOrdPag.Text));

      LCodigoCliente := fatVenda.strCodCli;
      LChaveDocumento := TFuncoesPixAutcom.RetornaChaveDaVenda(fatVenda, fatVenda.strNomeForm);

      LChavePix := fCfgSis('CHAPIX');
    end
    else
    begin
      LDadosRequisicaoPixAVista := TFuncoesPixAutcom.RetornaDadosRequisicaoReceber(cdsCtrSel,
                                                                                   fStrToFloat(edtOrdPag.Text),
                                                                                   DeterminaCodigoDoClienteDevedorPix);

      LCodigoCliente := DeterminaCodigoDoClienteDevedorPix;

      LChaveDocumento := TFuncoesPixAutcom.RetornaChaveDaDuplicata(cdsCtrSel, 'Baixa de Contas a Receber');

      LChavePix := TPixDao.RetornaChavePixDoPortador(FPortadorBaixaCtr);
    end;

    LDadosRequisicaoPixAVista.TextoItemShipay := LDadosRequisicaoPixAVista.SolicitacaoPagador;
    LDadosRequisicaoPixAVista.UtilizaShipay := TPixDao.ChavePixUtilizaShipay(LChavePix);
    LDadosRequisicaoPixAVista.UtilizaTefScope := TPixDao.ChavePixUtilizaTefScope(LChavePix);
    LDadosRequisicaoPixAVista.TipoCobranca := 'instantanea';

    FDadosPixRequisicao := TFuncoesPix.RetornaJsonDadosRequisicao(LDadosRequisicaoPixAVista);

    LRetornoPix := TFuncoesPixAutcom.PagarPixViaQRCodeGerandoNovoPix(LChavePix,
                                                                     FDadosPixRequisicao,
                                                                     FDadosPixRecebimento,
                                                                     LCodigoCliente,
                                                                     False,
                                                                     LChaveDocumento,
                                                                     Self.fltValTot);

    LErro := TFuncoesPix.RetornaMensagemErroRequisicao(LRetornoPix);
    If Not LErro.IsEmpty Then
      Raise ExceptionAutcom.Create(LErro);

    FDadosPixRecebimento := LRetornoPix;

    pAjustaObjPixFatVenda(TFuncoesPix.RetornaDadosDoRetornoPixConsulta(LRetornoPix,
                                                                       FDadosPixRequisicao));

    If TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(FObjetoPixRecebimento) Then
    Begin
      edtOrdPag.Text := FormatFloat(',0.00', FObjetoPixRecebimento.ValorPago);
      pHabilitaAdtPixPed ;
      chkPixAvulso.Checked := False;
      chkPixAvulso.Enabled := False;
      edtOrdPag.Enabled := False;
      btnReceberPix.Enabled := False;

      FObjetoPixRecebimento.JsonRetorno := FDadosPixRecebimento;
      FObjetoPixRecebimento.JSonRequisicao := FDadosPixRequisicao;
      FObjetoPixRecebimento.AutoIncremChavePix := LChavePix;

      If FObjetoPixRecebimento.SolicitacaoPagador.IsEmpty Then
      Begin
        FObjetoPixRecebimento.SolicitacaoPagador := LDadosRequisicaoPixAVista.SolicitacaoPagador;
        FObjetoPixRecebimento.NomeDevedor := LDadosRequisicaoPixAVista.NomeDevedor;
        FObjetoPixRecebimento.CPFCNPJDevedor := LDadosRequisicaoPixAVista.CPFCNPJDevedor;
      End;
    End
    Else
      fMensagem('ATENÇÃO', 'O recebimento do Pix por QR Code não foi realizado. ' + #13 + 'Assim o registro do Pix não será gerado.', ['&Ok']);
  Except
    On E: ExceptionAutcom Do
      Raise ExceptionAutcom.Create(E.Message);
  End;
end;

procedure TfrmFatFormasPagamento.AdicionarDadosLancamentos(
  var ALiberacao: TLiberacao);
  Var
    LDataset: TUniClientDataset;

    LTabela: TRegistroMsgLiberaTabela;

    LLinha: TLinhaMsgLibera;

    LTotalLancamentos: Double;
begin
  ALiberacao.objMsgLibera.pAddTexto('');

  ALiberacao.objMsgLibera.pAddTexto('Valor do Pix: ' + edtOrdPag.Text);
  ALiberacao.objMsgLibera.pAddTexto('');

  LTotalLancamentos := 0;

  LTabela := TRegistroMsgLiberaTabela.Create;
  LLinha  := TLinhaMsgLibera.Create;
  LLinha.enuTipoLinha := tlCabecalho;
  LLinha.pAddColuna(''  , 'LANÇAMENTO', 24 , alEsquerda , teAutcom);
  LLinha.pAddColuna(''  , 'DT.CAD.'   , 11 , alCentro   , teAutcom);
  LLinha.pAddColuna(''  , 'DT.VEN.'   , 11 , alCentro   , teAutcom);
  LLinha.pAddColuna(''  , 'CLIENTE'   , 39 , alEsquerda , teAutcom);
  LLinha.pAddColuna(''  , 'VR.REC.'  , 21 , alDireita  , teAutcom);
  LTabela.lstLinhas.Add(LLinha);

  LDataset := fCriaClientDatSet(cdsCtrSel);
  LDataset.Filter := 'CTR_MARDES=''M'' ';
  LDataset.Filtered := True;

  LDataset.First;
  While Not LDataset.Eof Do
  Begin
    LLinha  := TLinhaMsgLibera.Create;
    LLinha.enuTipoLinha := tlValor;
    LLinha.pAddColuna('LANÇAMENTO',  LDataset.FieldByName('CTR_NUMDUP').AsString + '-' +
                                     LDataset.FieldByName('CTR_ESPDOC').AsString + '-' +
                                     LDataset.FieldByName('CTR_CODEMP').AsString                                 , 24 , alEsquerda);
    LLinha.pAddColuna('DT.CAD.'   ,  FormatDateTime('dd/MM/yyyy', LDataset.FieldByName('CTR_DTACAD').AsDateTime) , 11 , alCentro  );
    LLinha.pAddColuna('DT.VEN.'   ,  FormatDateTime('dd/MM/yyyy', LDataset.FieldByName('CTR_DTAVEN').AsDateTime) , 11 , alCentro  );

    LLinha.pAddColuna('CLIENTE' ,  LDataset.FieldByName('CTR_CODCLI').AsString + '-' +
                                   LDataset.FieldByName('CLI_NOMCLI').AsString                                   , 39 , alEsquerda);

    LLinha.pAddColuna('VR.REC.'  ,  FormatFloat('#,##0.00', LDataset.FieldByName('CTR_VALREC').AsFloat)           , 21 , alDireita );
    LTabela.lstLinhas.Add(LLinha);

    LTotalLancamentos := LTotalLancamentos + fFormataFloat(LDataset.FieldByName('CTR_VALREC').AsFloat, 2);

    LDataset.Next;
  End;

  LLinha  := TLinhaMsgLibera.Create;
  LLinha.enuTipoLinha := tlTotal;
  LLinha.pAddColuna(''          , 'TOTAIS'                                  , 91, alDireita, teAutcom);
  LLinha.pAddColuna('Descrição' , FormatFloat('#,##0.00', LTotalLancamentos), 21, alDireita, teAmbos);
  LTabela.lstLinhas.Add(LLinha);

  ALiberacao.objMsgLibera.lstRegistros.Add(LTabela);
end;

procedure TfrmFatFormasPagamento.btnConfirmaDadosClick(Sender: TObject);
begin
  try
    If Self.Visible Then
    Begin
      If Not fVerificaCampos Then
        Exit;
    End;

    inherited;

    If InterlockedIncrement(intGravando) = 0 Then
    Begin
      pConfirma;
      InterlockedDecrement(intGravando);
    End
    Else
      InterlockedDecrement(intGravando);
  finally
    blnCartaoConferidoEConfirmado := False;
  end;
end;

procedure TfrmFatFormasPagamento.btnReceberPixClick(Sender: TObject);
begin
  inherited;
  If (FMenorDataRecebimento <> VS_Date) and (not blnFpg009) Then
  Begin
    fMensagem('ATENÇÃO', 'Não é possível receber por Pix com duplicatas que a data de recebimento seja retroativa.', ['&Ok']);
    pSetFocus(edtOrdPag);
    Exit;
  End;

  If fMensagem('ATENÇÃO', 'Deseja realizar o recebimento do valor ' + FormatFloat(',0.00', fStrToFloat(edtOrdPag.Text)) +
                          ' através do QR Code Pix?', ['&Sim', '&Não'], 1) = 2 Then
  Begin
    pSetFocus(edtOrdPag);
    SelectNext(ActiveControl, True, True);
    Exit;
  End;

  Try
    AbreTelaParaPagamentoDoPix;
  Except
    On E: ExceptionAutcom Do
    Begin
      fMensagem('ERRO', E.Message, ['&Ok']);

      Exit;
    End;
  End;

  If edtFinanc.Visible Then
    pSetFocus(edtFinanc)
  Else
    pSetFocus(btnConfirmaDados);
end;

function TfrmFatFormasPagamento.fGetModalidadesDigitadas: TArrModalidade;
begin
  FillChar(Result, SizeOf(Result), #0);

  If fStrToFloat(edtDinheiro.Text) <> 0.00 Then
  Begin
    SetLength(Result, Length(Result) + 1);
    Result[Length(Result) - 1].strDesMod := 'DINHEIRO';
    Result[Length(Result) - 1].fltValMod := fStrToFloat(edtDinheiro.Text);
  End;

  If fStrToFloat(edtCartao.Text) <> 0.00 Then
  Begin
    SetLength(Result, Length(Result) + 1);
    Result[Length(Result) - 1].strDesMod := 'CARTÃO';
    Result[Length(Result) - 1].fltValMod := fStrToFloat(edtCartao.Text);
  End;

  If fStrToFloat(edtOrdPag.Text) <> 0.00 Then
  Begin
    SetLength(Result, Length(Result) + 1);
    Result[Length(Result) - 1].strDesMod := 'ORDEM DE PAGAMENTO';
    Result[Length(Result) - 1].fltValMod := fStrToFloat(edtOrdPag.Text);
  End;

  If fStrToFloat(edtChqVista.Text) <> 0.00 Then
  Begin
    SetLength(Result, Length(Result) + 1);
    Result[Length(Result) - 1].strDesMod := 'CHEQUE A VISTA';
    Result[Length(Result) - 1].fltValMod := fStrToFloat(edtChqVista.Text);
  End;

  If fStrToFloat(edtChqPre.Text) <> 0.00 Then
  Begin
    SetLength(Result, Length(Result) + 1);
    Result[Length(Result) - 1].strDesMod := 'CHEQUE PRÉ';
    Result[Length(Result) - 1].fltValMod := fStrToFloat(edtChqPre.Text);
  End;

  If fStrToFloat(edtFaturado.Text) <> 0.00 Then
  Begin
    SetLength(Result, Length(Result) + 1);
    Result[Length(Result) - 1].strDesMod := 'FATURADO';
    Result[Length(Result) - 1].fltValMod := fStrToFloat(edtFaturado.Text);
  End;

  If fStrToFloat(edtFinanc.Text) <> 0.00 Then
  Begin
    SetLength(Result, Length(Result) + 1);
    Result[Length(Result) - 1].strDesMod := 'FINANCIAMENTO';
    Result[Length(Result) - 1].fltValMod := fStrToFloat(edtFinanc.Text);
  End;

  If fStrToFloat(edtValCre.Text) <> 0.00 Then
  Begin
    SetLength(Result, Length(Result) + 1);
    Result[Length(Result) - 1].strDesMod := 'UTILIZAR CRÉDITOS';
    Result[Length(Result) - 1].fltValMod := fStrToFloat(edtValCre.Text);
  End;
end;

function TfrmFatFormasPagamento.fGetTitulosSelecionados: TArrDupSel;
begin
  FillChar(Result, SizeOf(Result), #0);

  cdsCtrSel.First;
  While Not cdsCtrSel.Eof Do
  Begin
    If cdsCtrSel.FieldByName('CTR_MARDES').AsString = 'M' Then
    Begin
      SetLength(Result, Length(Result) + 1);

      Result[Length(Result) - 1].strNumDoc := cdsCtrSel.FieldByName('NRODUP').AsString;
      Result[Length(Result) - 1].strSeqBai := cdsCtrSel.FieldByName('CTR_SEQBAI').AsString;
      Result[Length(Result) - 1].strCodCli := cdsCtrSel.FieldByName('CTR_CODCLI').AsString;
      Result[Length(Result) - 1].strParcel := cdsCtrSel.FieldByName('PARDUP').AsString;
      Result[Length(Result) - 1].strEspDoc := cdsCtrSel.FieldByName('CTR_ESPDOC').AsString;
      Result[Length(Result) - 1].strCodEmp := cdsCtrSel.FieldByName('CTR_CODEMP').AsString;
      Result[Length(Result) - 1].dtaDtaCad := cdsCtrSel.FieldByName('CTR_DTACAD').AsDateTime;
      Result[Length(Result) - 1].dtaDtaVen := cdsCtrSel.FieldByName('CTR_DTAVEN').AsDateTime;
      Result[Length(Result) - 1].fltVlrRec := cdsCtrSel.FieldByName('CTR_VALCAL').AsFloat;
    End;
    cdsCtrSel.Next;
  End;
end;


procedure TfrmFatFormasPagamento.pAtualizaDupsCred;
Var
  iDup : Integer;
  objRec: TCadRec;
  objRep: TCadRecRepository;
  strAutInc : String;
begin
  cdsCtrSel := fCriaCdsDupsCredito(Self);

  objRep := TCadRecRepository.Create;

  For iDup := 0 To stlDupCreditos.Count-1 do
  Begin
    strAutInc := AnsiReplaceStr(stlDupCreditos[iDup],'''','');
    objRec := objRep.fRetDuplicata(strAutInc);

    If Assigned(objRec) Then
    begin
      with cdsCtrSel do
      begin
        Insert;
        FieldByName('NRODUP').AsString       := objRec.CTR_NUMDUP;
        FieldByName('CTR_SEQBAI').AsInteger  := objRec.CTR_SEQBAI;
        FieldByName('CTR_CODCLI').AsString   := objRec.objCodCli.strCodCli;
        FieldByName('PARDUP').AsString       := objRec.CTR_PARCEL;
        FieldByName('CTR_ESPDOC').AsString   := objRec.CTR_ESPDOC;
        FieldByName('CTR_CODEMP').AsString   := objRec.CTR_CODEMP;
        FieldByName('CTR_DTACAD').AsDateTime := objRec.CTR_DTACAD;
        FieldByName('CTR_DTAVEN').AsDateTime := objRec.CTR_DTAVEN;
        FieldByName('CTR_VALCAL').AsFloat    := objRec.CTR_VALDUP;
        FieldByName('CTR_MARDES').AsString   := 'M';
        Post;
      end;
    end;
  End;

  If Assigned(objRep) Then
    FreeAndNil(objRep);
end;

function TfrmFatFormasPagamento.fCriaCdsDupsCredito(AOwner: TComponent): TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(AOwner);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'NRODUP';
    DataType := ftString;
    Size     := 12;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CTR_SEQBAI';
    DataType := ftInteger;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CTR_CODCLI';
    DataType := ftString;
    Size     := 8;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PARDUP';
    DataType := ftString;
    Size     := 3;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CTR_ESPDOC';
    DataType := ftString;
    Size     := 2;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CTR_CODEMP';
    DataType := ftString;
    Size     := 3;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CTR_DTACAD';
    DataType := ftDate;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CTR_DTAVEN';
    DataType := ftDate;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CTR_VALCAL';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CTR_MARDES';
    DataType := ftString;
    Size     := 1;
    Required := False;
  End;

  Result.CreateDataSet;
  Result.Open;
end;

end.

