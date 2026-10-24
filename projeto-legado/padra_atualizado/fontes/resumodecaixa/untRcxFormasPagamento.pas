unit untRcxFormasPagamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  untGravaMovCar, Dialogs, untPai, StdCtrls, EditFocus, Menus, Buttons, ExtCtrls,
  DB, untTypesSistema, untFuncoesSimples, StrUtils, Uni, AppEvnts,
  UniClientDataSet, BitBtnLockedIncrem, untCadChq, frxClass,
  frxExportCSVTestabilidade, untRcxTResumoDeCaixa, untTiposPix, untLiberacao,
  untMsgLiberacao, untTLogLibRec, untTDesmembramentoBaixaReceber;

Type
  TCartao = Record
    strNumDup: String;
    strCodCli: String;
    strParcel: String;
    strCodEmp: String;
    dtaDtaCad: TDateTime;
    dtaDtaVen: TDateTime;
    fltValOri: Double;
    intSeqCon: Integer;
    strEmpRcx: String;
    strAutInc: String;
End;

Type
  TCheque = Record
    strCodBco: String;
    strNumAge: String;
    strConCor: String;
    strNumChq: String;
    strCodEmp: String;
    dtaDtaCad: TDateTime;
    dtaDtaVen: TDateTime;
    fltValChq: Double;
    intSeqCon: Integer;
    strEmpRcx: String;
End;

type
  TfrmRcxFormasPagamento = class(TfrmPai)
    pnlTotal: TPanel;
    lblValTot: TLabel;
    pnlFundo: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    edtDinheiro: TEditFocus;
    edtChqVista: TEditFocus;
    edtChqPre: TEditFocus;
    edtCartao: TEditFocus;
    pnlValDig: TPanel;
    lblValDig: TLabel;
    pnlSeqBai: TPanel;
    Label5: TLabel;
    edtValFin: TEditFocus;
    Label6: TLabel;
    edtOrdRec: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    btnReceberPix: TBitBtnLocked;
    chkPixAvulso: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtDinheiroExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtChqVistaKeyPress(Sender: TObject; var Key: Char);
    procedure btnReceberPixClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtOrdRecChange(Sender: TObject);
  private
    { Private declarations }
    blnErro : Boolean;
    blnDiversos: Boolean;

    fltValFinAnt: Double;

    strAutInc,
    strNumDoc,
    strParcel,
    strEspDoc,
    strCodEmp: String;

    vIntSeqCon : Integer;

    fltValDoc: Double;
    fltValDig: Double;

    blnChqVisCad: Boolean;
    blnChqPreCad: Boolean;
    blnCartaoCad: Boolean;

    fltDinRecAtu,
    fltChqAviAtu,
    fltChqPreAtu,
    fltCarRecAtu,
    fltValFinAtu,
    fltOrdRecAtu: Double;

    blnCarRec,
    blnChqPre,
    blnChqAvi: Boolean;

    cdsChqPre: TUniClientDataSet;
    cdsChqVis: TUniClientDataSet;
    cdsTrcChqAvisPre: TUniClientDataSet;
    FPixExclusao: TUniClientDataset;

    stlForPag: TStringList;
    stlCndPag: TStringList;

    FRecebimentoDinheiroAnterior,
    FRecebimentoOrdemPagamentoAnterior: Double;

    FPixAvulso,
    FRecebidoPorPix: Boolean;

    FDadosPixRecebimento,
    FDadosPixRequisicao,
    FAutoIncremChavePix: String;

    FObjetoPixRecebimento: TDadosRetornoPixConsulta;

    FDataDoCaixa: TDateTime;

    objLiberacao: TLiberacao;
    objLogLibRec: TLogLibRec;

    Procedure pGravaTrocaFormas(strAutInc, strCodOpe: String);

    Procedure pAcertaRecebimentoCadRec;

    function fAcertaRecebimentoAdtCli(ARecebidoPorPix, APortadorCadRec: String): Boolean;
    function fCorrige_CadRec_Vinculado(APortadorCadRec: String): Boolean;

    function fValidaValorMod(fltValor: Double; strModalidade: String): Boolean;
    function fDigitacaoCartoes(fltValor: Double; blnMostrarTela: Boolean;
                               strCodCar: String = '';
                               strCodFin: String = ''): Boolean;
    function fChequeVis(strValor: String; blnMostrarTela: Boolean): Boolean;
    function fChequePre(strValor: String; blnMostrarTela: Boolean): Boolean;
    function MostraPixExclusao(ATextoValor: String;
                               AMostrarTela: Boolean): Boolean;
    procedure pAtualizaValDig;

    function fRetornaTotalChqDigitados(cdsCheques: TUniClientDataSet): Double;

    function fCarregaCartoesOriginais(blnMostrarTela: Boolean): Boolean;
    function fCarregaChqVisOriginais(blnMostrarTela: Boolean): Boolean;
    function fCarregaChqPreOriginais(blnMostrarTela: Boolean): Boolean;
    function fPegarSqlUpdateCadRec(blnWhereComSeqCon: Boolean = True): String;
    function fPegarSqlDebitoAdiantamento: String;

    function fAlteraFormaPagamento: Boolean;

    function fAlterouPagamento: Boolean;

    function fGetDiversos(intSeqCon: Integer; strCodEmp: String): Boolean;

    procedure pSomaPagamentos(    intSeqCon: Integer;
                                  strCodEmp: String;
                              var fltDinRecSeq,
                                  fltChqAviSeq,
                                  fltChqPreSeq,
                                  fltCarRecSeq,
                                  fltValFinSeq,
                                  fltOrdRecSeq: Double);
    function fDocumentoFaturado(qryRcx: TUniQuery; strTabela: String): Boolean;
    procedure pLogChq(qryLog: TDataset; strDescri: String);
    function fRetHisCar(intSeqCon: Integer; strCodEmp: String): String;
    function fBuscaClienteUnico: String;

    function ValidaSaldoDoCaixaParaDinheiroEOrdemDePagamento: Boolean;

    function fVerificaPixAvulso(intSeqCon: Integer; strCodEmp: String; dtaDtaCaixa : TDate): Boolean;

    procedure AbreTelaParaPagamentoDoPix;
    function ValidarSeExistePixRecebidoSemConfirmacao: Boolean;
    procedure AtualizaDataMovimentacaoBancaria;
    procedure AdicionarDadosLancamentos(var ALiberacao: TLiberacao);
    procedure AtualizaRecPixLancamentosCaixa(AValor: String;
                                             ASeqCon: Integer;
                                             ACodigoEmpresa: String;
                                             ADataLancamento: TDateTime);
    procedure AtualizaRecPixLancamentosCadRec(AValor: String;
                                              ASeqCon: Integer;
                                              ACodigoEmpresa: String;
                                              ADataLancamento: TDateTime;
                                              APortadorCadRec: String = '');

    procedure GravarLogCtrDuplicatas(ASeqCon: Integer;
                                     ACodigoEmpresa: String;
                                     ADataLancamento: TDateTime); overload;

    procedure GravarLogCtrDuplicatas(ANumeroDuplicata,
                                     AEspecieDocumento,
                                     ACodigoEmpresa,
                                     ACodigoCliente: String); overload;

    function fTemPermissaoAlterarFormaPagtoResumoCaixa: Boolean;

    procedure AcertaDesmembramentoModalidades(ASeqCon: Integer; ACodigoEmpresa: String; ADataLancamento: TDateTime;
                                              fltvlDinhei, fltvlChqVis, fltvlChqPre, fltvlCartao, fltvlOrdRec : Double );

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }

    fltDinhei: Double;
    fltChqVis: Double;
    fltChqPre: Double;
    fltCartao: Double;
    fltValFin: Double;
    fltOrdRec: Double;
    cdsData: TUniClientDataSet;

    arrCartoesOriginais: Array Of TCartao;
    arrChqVisOriginais: Array Of TCheque;
    arrChqPreOriginais: Array Of TCheque;

    arrCartoes: TCartoesResumoCaixaArray;

    strCodCli: String;
    strCodOpe: String;

    strCodigoCaixa  : String;
    objResumoDeCaixa: TResumoDeCaixa;

    dtaDataReferencia: TDateTime;

    property RecebidoPorPix: Boolean read FRecebidoPorPix write FRecebidoPorPix;
    property PixAvulso: Boolean read FPixAvulso write FPixAvulso;
  end;


implementation

uses
 {$IFNDEF LINUX}
   untArredondaParcelasCartoes,
 {$ENDIF LINUX}
 untRcxMostraCartoes, untRcxDigCartoes, untCadCheques, untRcxDocumentosDeletar,
 untFuncoes, untMovCar, untCadRcxx, untTCadChqRepository, untDuplicatas, untArredondaParcelaImpl,
 untRcxSelDocsFpg, untTFuncoesPixAutcom, untTFuncoesAuxiliaresPix, untConstantes,
 untGravando, untTPixDao, untLogCtr;

{$R *.dfm}

procedure TfrmRcxFormasPagamento.pSomaPagamentos(    intSeqCon: Integer;
                                                     strCodEmp: String;
                                                 var fltDinRecSeq,
                                                     fltChqAviSeq,
                                                     fltChqPreSeq,
                                                     fltCarRecSeq,
                                                     fltValFinSeq,
                                                     fltOrdRecSeq: Double);
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    Clear;
    Add('SELECT ');
    Add('  SUM(IFNULL(RCX_DINREC,0)) AS DINREC,');
    Add('  SUM(IFNULL(RCX_CHQAVI,0)) AS CHQAVI,');
    Add('  SUM(IFNULL(RCX_CHQPRE,0)) AS CHQPRE,');
    Add('  SUM(IFNULL(RCX_CARREC,0)) AS CARREC,');
    Add('  SUM(IFNULL(RCX_VALFIN,0)) AS VALFIN,');
    Add('  SUM(IFNULL(RCX_ORDREC,0)) AS ORDREC ');
    Add('FROM ');
    Add('  CADRCXX ');
    Add('WHERE');
    Add('  RCX_SEQCON = :SEQCON AND ');
    Add('  RCX_CODEMP = :CODEMP AND ');

    If strCodigoCaixa.IsEmpty Then
      Add('  RCX_DTACAD > :DTAREF     ')
    Else
    Begin
      Add('  RCX_DTACAD >= :DTAREF AND ');
      Add('  RCX_LANFEC = "N"          ');
    End;

    ParamByName('SEQCON').AsInteger  := intSeqCon;
    ParamByName('CODEMP').AsString   := strCodEmp;
    ParamByName('DTAREF').AsDateTime := dtaDataReferencia;

    Open;

    fltDinRecSeq := FieldByName('DINREC').AsFloat;
    fltChqAviSeq := FieldByName('CHQAVI').AsFloat;
    fltChqPreSeq := FieldByName('CHQPRE').AsFloat;
    fltCarRecSeq := FieldByName('CARREC').AsFloat;
    fltValFinSeq := FieldByName('VALFIN').AsFloat;
    fltOrdRecSeq := FieldByName('ORDREC').AsFloat;

    Close;
  End;
  FreeAndNil(qryGen);
End;


function TfrmRcxFormasPagamento.ValidaSaldoDoCaixaParaDinheiroEOrdemDePagamento: Boolean;
  Var
    LSaldoCaixaDinheiro,
    LSaldoCaixaOrdemPagamento: Double;
    blnPixAvulso : Boolean;
begin
  Result := fFormataFloat(FRecebimentoDinheiroAnterior, 2) = 0.00;
  If Result Then
  Begin
    Result := fFormataFloat(FRecebimentoOrdemPagamentoAnterior, 2) = 0.00;

    If Result Then
      Exit;
  End;

  If FRecebimentoDinheiroAnterior <> 0 Then
  Begin
    LSaldoCaixaDinheiro := objResumoDeCaixa.fRetornaSaldoCaixaCampo('RCX_DINREC', strCodigoCaixa);

    Result := LSaldoCaixaDinheiro - (FRecebimentoDinheiroAnterior - fStrToFloat(edtDinheiro.Text)) >= 0;
    If Not Result Then
    Begin
      fMensagem('ATENÇÃO', 'A alteração da forma de pagamento não pode ser realizada pois não possui saldo em dinheiro suficiente.', ['&Ok']);
      pSetFocus(edtDinheiro);

      Exit;
    End;
  End;

  If FRecebimentoOrdemPagamentoAnterior <> 0 Then
  Begin

    blnPixAvulso := False;

    If FRecebidoPorPix Then
       blnPixAvulso := fVerificaPixAvulso(vIntSeqCon, strCodEmp, FDataDoCaixa);

    LSaldoCaixaOrdemPagamento := objResumoDeCaixa.fRetornaSaldoCaixaCampo('RCX_ORDREC', strCodigoCaixa, '', '', FRecebidoPorPix, blnPixAvulso, Not blnPixAvulso);

    Result := LSaldoCaixaOrdemPagamento - (FRecebimentoOrdemPagamentoAnterior - fStrToFloat(edtOrdRec.Text)) >= 0;
    If Not Result Then
    Begin
      fMensagem('ATENÇÃO', 'A alteração da forma de pagamento não pode ser realizada pois não possui saldo em ordem de pagamento suficiente.', ['&Ok']);
      pSetFocus(edtOrdRec);

      Exit;
    End;
  End;
end;

function TfrmRcxFormasPagamento.ValidarSeExistePixRecebidoSemConfirmacao: Boolean;
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
    objLiberacao.objMsgLibera.pAddTexto('Permitir cancelar alteração da forma de pagamento do Resumo de Caixa com um Pix já recebido');

    AdicionarDadosLancamentos(objLiberacao);

    objLiberacao.strDirAce := 'PERCANCRCXPIXREC';
    objLiberacao.strMsgSen := 'Permitir cancelar alteração da forma de pagamento do Resumo de Caixa com um Pix já recebido';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := strCodOpe;
    objLiberacao.strCodDig := strCodOpe;

    Result := objLiberacao.fLibera;
  End;
end;

procedure TfrmRcxFormasPagamento.FormShow(Sender: TObject);
  Var
    fltDinRecSeq,
    fltChqAviSeq,
    fltChqPreSeq,
    fltCarRecSeq,
    fltValFinSeq,
    fltOrdRecSeq: Double;
begin
  inherited;

  With cdsData Do
  Begin
    pnlSeqBai.Caption := 'Seq. da Baixa: ' + FieldByName('RCX_SEQCON').AsString;

    strAutInc := fGetMinAutIncRcx(FieldByName('RCX_SEQCON').AsInteger,
                                  FieldByName('RCX_CODEMP').AsString,
                                  dtaDataReferencia);

    strNumDoc := FieldByName('RCX_NUMDOC').AsString;
    strEspDoc := FieldByName('RCX_ESPDOC').AsString;
    strCodEmp := FieldByName('RCX_CODEMP').AsString;
    strParcel := FieldByName('RCX_PARCEL').AsString;

    vIntSeqCon := FieldByName('RCX_SEQCON').AsInteger;

    blnDiversos := fGetDiversos(FieldByName('RCX_SEQCON').AsInteger,
                                FieldByName('RCX_CODEMP').AsString);

    pSomaPagamentos(FieldByName('RCX_SEQCON').AsInteger,
                    FieldByName('RCX_CODEMP').AsString,
                    fltDinRecSeq, fltChqAviSeq, fltChqPreSeq, fltCarRecSeq,
                    fltValFinSeq, fltOrdRecSeq);

    fltValFinAnt := fltValFinSeq;
  End;

  fltValDoc := fltDinRecSeq + fltChqAviSeq + fltChqPreSeq + fltCarRecSeq + fltValFinSeq + fltOrdRecSeq;

  lblValDig.Caption := 'Valor Digitado: 0,00';
  lblValTot.Caption := 'Valor Total: ' + FloatToStrF(fltValDoc, ffFixed,12,2);

  edtDinheiro.Text := FloatToStrF(fltDinRecSeq, ffFixed, 12, 2);
  edtChqVista.Text := FloatToStrF(fltChqAviSeq, ffFixed, 12, 2);
  edtChqPre.Text   := FloatToStrF(fltChqPreSeq, ffFixed, 12, 2);
  edtCartao.Text   := FloatToStrF(fltCarRecSeq, ffFixed, 12, 2);
  edtValFin.Text   := FloatToStrF(fltValFinSeq, ffFixed, 12, 2);
  edtOrdRec.Text   := FloatToStrF(fltOrdRecSeq, ffFixed, 12, 2);

  //Guarda valores atuais
  fltDinRecAtu := fltDinRecSeq;
  fltChqAviAtu := fltChqAviSeq;
  fltChqPreAtu := fltChqPreSeq;
  fltCarRecAtu := fltCarRecSeq;
  fltValFinAtu := fltValFinSeq;
  fltOrdRecAtu := fltOrdRecSeq;
  blnCarRec    := (fltCarRecAtu <> 0);
  blnChqPre    := (fltChqPreAtu <> 0);
  blnChqAvi    := (fltChqAviAtu <> 0);

  fltDinhei    := 0.0;
  fltChqVis    := 0.0;
  fltChqPre    := 0.0;
  fltCartao    := 0.0;
  fltValFin    := 0.0;
  fltOrdRec    := 0.0;

  FRecebimentoDinheiroAnterior := fltDinRecSeq;
  FRecebimentoOrdemPagamentoAnterior := fltOrdRecSeq;

  pAtualizaValDig;

  stlForPag    := TStringList.Create;
  stlForPag.Sorted := True;
  stlForPag.Duplicates := dupIgnore;

  stlCndPag    := TStringList.Create;
  stlCndPag.Sorted := True;
  stlCndPag.Duplicates := dupIgnore;

  If Not Assigned(objResumoDeCaixa) Then
    objResumoDeCaixa := TResumoDeCaixa.Create;

  objResumoDeCaixa.fNecessitaFecharCaixa(False, FDataDoCaixa, strCodigoCaixa, False);

  pCarregaFormasPagto(strCodCli, stlForPag, stlCndPag);

  FAutoIncremChavePix := TPixDao.RetornaAutoIncremChavePixDoCaixa(strCodigoCaixa);

  btnReceberPix.Visible := TFuncoesPixAutcom.RealizaValidacoesUsoDoPixNoCaixa(strCodOpe,
                                                                              FAutoIncremChavePix,
                                                                              True);

  Self.Width := 309;

  chkPixAvulso.Left := btnReceberPix.Left;
  If btnReceberPix.Visible Then
  Begin
    chkPixAvulso.Left := btnReceberPix.Left + btnReceberPix.Width + 5;

    Self.Width := 339;
  End;

  chkPixAvulso.Top := btnReceberPix.Top + 3;

  chkPixAvulso.Checked := FPixAvulso;

  chkPixAvulso.Visible := fCfgSis('RCXORD', varString) = 'A';
end;

function TfrmRcxFormasPagamento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;

  function fUtilizarTipoCliente: Boolean;
  begin
    If fCfgSis('USATPC', varBoolean) Then
    Begin
      If fCfgSis('TPCBRC', varBoolean) And (stlForPag.Count <= 0) Then
        Result := False
      Else
        Result := True;
    End
    Else
      Result := False;
  end;
begin

  Result := True;

  If (Sender = edtDinheiro) Then
  Begin

    If (fEmptyStr(edtDinheiro.Text)) Then
    Begin
      edtDinheiro.Text := '0,00';
    End
    Else
      Result := fValidaValorMod(fStrToFloat(edtDinheiro.Text), 'dinheiro');

    If (Result) And (fUtilizarTipoCliente) And (fStrToFloat(edtDinheiro.Text) > 0.0) Then
    Begin
      Result := (stlForPag.IndexOf('001') >= 0);
      If (Not Result) Then
      Begin
        fMensagem('ATENÇÃO!', 'Modalidade dinheiro não permitida para esse tipo de cliente.', ['&Ok']);
      End;
    End;

    If Result Then
      pAtualizaValDig;

  End
  Else If (Sender = edtOrdRec) Then
  Begin

    If (fEmptyStr(edtOrdRec.Text)) Then
    Begin
      edtOrdRec.Text := '0,00';
    End
    Else
      Result := fValidaValorMod(fStrToFloat(edtOrdRec.Text), 'dinheiro');

    If (Result) And (fUtilizarTipoCliente) And (fStrToFloat(edtOrdRec.Text) > 0.0) Then
    Begin
      Result := (stlForPag.IndexOf('012') >= 0);
      If (Not Result) Then
      Begin
        fMensagem('ATENÇÃO!', 'Modalidade ordem de pagamento não permitida para esse tipo de cliente.', ['&Ok']);
      End;
    End;

    If Result Then
    Begin
      If FRecebidoPorPix Then
      Begin
        If (fStrToFloat(edtOrdRec.Text) <> 0.00) And
           (fStrToFloat(edtOrdRec.Text) <> fltOrdRec) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse pagamento foi feito por Pix e não pode ser alterado o valor.' + #13 +
                               'Apenas poderá ser zerado o valor da Ordem de Pagamento nesse caso.', ['&Ok']);

          Result := False;
        End;

        If Result Then
        Begin
          chkPixAvulso.Checked := FPixAvulso;

          If fStrToFloat(edtOrdRec.Text) = 0.00 Then
          Begin
            Result := MostraPixExclusao(edtOrdRec.Text, blnBuscaPorChave);

            chkPixAvulso.Checked := False;
          End;
        End;
      End;
    End;

    If Result Then
      pAtualizaValDig;

  End
  Else If (Sender = edtChqVista) Then
  Begin

    If (fEmptyStr(edtChqVista.Text)) Then
      edtChqVista.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtChqVista.Text), 'cheque a vista');

    If (Result) And (fUtilizarTipoCliente) And (fStrToFloat(edtChqVista.Text) > 0.0) Then
    Begin
      Result := (stlForPag.IndexOf('006') >= 0);
      If (Not Result) Then
      Begin
        fMensagem('ATENÇÃO!', 'Modalidade cheque a vista não permitida para esse tipo de cliente.', ['&Ok']);
      End;
    End;

    {*******************************}
    {* SE ESTIVER CONFIGURADO PARA *}
    {* CADASTRAR CHEQUES A VISTA   *}
    {****************************AF*}
    If Result Then
      Result := fChequeVis(edtChqVista.Text, blnBuscaPorChave);

    If Result Then
      pAtualizaValDig;

    If blnChqAvi Then
    Begin
      edtChqVista.Text := FloatToStrF(fltChqAviAtu, ffFixed, 12, 2);
      Result := True;
    End;
  End
  Else If (Sender = edtChqPre) Then
  Begin

    If (fEmptyStr(edtChqPre.Text)) Then
      edtChqPre.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtChqPre.Text), 'cheque - pré');

    If (Result) And (fUtilizarTipoCliente) And (fStrToFloat(edtChqPre.Text) > 0.0) Then
    Begin
      Result := (stlForPag.IndexOf('002') >= 0);
      If (Not Result) Then
      Begin
        fMensagem('ATENÇÃO!', 'Modalidade cheque pré não permitida para esse tipo de cliente.', ['&Ok']);
      End;
    End;

    If Result Then
      Result := fChequePre(edtChqPre.Text, blnBuscaPorChave);

    If Result Then
      pAtualizaValDig;

    If blnChqPre Then
    Begin
      edtChqPre.Text := FloatToStrF(fltChqPreAtu, ffFixed, 12, 2);
      Result := True;
    End;

  End
  Else If (Sender = edtCartao) Then
  Begin

    If (fEmptyStr(edtCartao.Text)) Then
    Begin
      edtCartao.Text := '0,00';
      SetLength(arrCartoes, 0);
    End
    Else
      Result := fValidaValorMod(fStrToFloat(edtCartao.Text), 'cartão');

    If (Result) And (fUtilizarTipoCliente) And (fStrToFloat(edtCartao.Text) > 0.0) Then
    Begin
      Result := (stlForPag.IndexOf('007') >= 0);
      If (Not Result) Then
      Begin
        fMensagem('ATENÇÃO!', 'Modalidade cartão não permitida para esse tipo de cliente.', ['&Ok']);
      End;
    End;

    If fCfgSis('DIGCAR', varBoolean) Then
    Begin
      If Result Then
        Result := fDigitacaoCartoes(fStrToFloat(edtCartao.Text), blnBuscaPorChave);

      If Result Then
        pAtualizaValDig;

      If blnCarRec Then
      Begin
        edtCartao.Text := FloatToStrF(fltCarRecAtu, ffFixed, 12, 2);
        pAtualizaValDig;

        If Not Result Then
          Result := blnBuscaPorChave;
      End;
    End
    Else If Result Then
      pAtualizaValDig;

  End

  Else If (Sender = edtValFin) Then
  Begin

    If (fEmptyStr(edtValFin.Text)) Then
    Begin
      edtValFin.Text := '0,00';
    End
    Else
      Result := fValidaValorMod(fStrToFloat(edtValFin.Text), 'financiamento');

    If (Result) And (fUtilizarTipoCliente) And (fStrToFloat(edtValFin.Text) > 0.0) Then
    Begin
      Result := (stlForPag.IndexOf('016') >= 0);
      If (Not Result) Then
      Begin
        fMensagem('ATENÇÃO!', 'Modalidade financiamento não permitida para esse tipo de cliente.', ['&Ok']);
      End;
    End;

    If Result And (fStrToFloat(edtValFin.Text) <> 0) And
       (fltValFinAnt <> fStrToFloat(edtValFin.Text)) Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', 'O Valor do financiamento só pode ser alterado para zero!', ['&Ok']);
    End;

//Se for necessario descomentar estas linhas falar com JC, nao vejo motivo para chamar a validacao do cartao neste ponto
//    If Result Then
//      Result := fDigitacaoCartoes(fStrToFloat(edtCartao.Text), blnBuscaPorChave);

    If Result Then
      pAtualizaValDig;

  End;

end;

function TfrmRcxFormasPagamento.fValidaValorMod(fltValor: Double; strModalidade: String): Boolean;
Begin
  Result := True;

  {If fltValor < 0 Then
  Begin
    fMensagem('','O valor da modalidade ' + strModalidade + ' não pode ser negativo!',['&OK']);
    Result := False;
  End
  Else
  If fltValor > fltValDoc Then
  Begin
    fMensagem('','O valor da modalidade ' + strModalidade + ' não pode ser maior que o valor total!',['&OK']);
    Result := False;
  End;}

End;

function TfrmRcxFormasPagamento.MostraPixExclusao(ATextoValor: String;
  AMostrarTela: Boolean): Boolean;
  Var
    LSQL: String;

    LConsulta  : TUniQuery;

    LContador: Integer;

    frmRcxDocumentosDeletar : TfrmRcxDocumentosDeletar;
begin

  Result := True;

  LConsulta := fCriaQuery(Self);

  LSQL := '';
  LSQL := LSQL + 'SELECT ';
  LSQL := LSQL + '  C.CCA_CODBCO, ';
  LSQL := LSQL + '  M.MPX_CHAPIX, ';
  LSQL := LSQL + '  M.MPX_CODEMP, ';
  LSQL := LSQL + '  M.MPX_VALPIX, ';
  LSQL := LSQL + '  M.MPX_CODOPE, ';
  LSQL := LSQL + '  M.MPX_DTAREC, ';
  LSQL := LSQL + '  M.MPX_TX_ID_, ';
  LSQL := LSQL + '  M.MPX_SEQCON  ';
  LSQL := LSQL + 'FROM ';
  LSQL := LSQL + '  MOVPIX M ';
  LSQL := LSQL + '  JOIN CCAPIX P ON P.AUTOINCREM=M.MPX_SEQPIX ';
  LSQL := LSQL + '  JOIN CADCCA C ON C.AUTOINCREM=P.PIX_SEQCCA ';
  LSQL := LSQL + 'WHERE ';
  LSQL := LSQL + '  M.MPX_CODEMP = :CODEMP AND ';
  LSQL := LSQL + '  M.MPX_SEQCON = :SEQCON AND ';
  LSQL := LSQL + '  M.MPX_DTACAD > :DTAREF AND ';
  LSQL := LSQL + '  M.MPX_RESCAI = 1           ';

  Try
    LConsulta.SQL.Text := LSQL;

    LConsulta.ParamByName('SEQCON').AsInteger := cdsData.FieldByName('RCX_SEQCON').AsInteger;
    LConsulta.ParamByName('CODEMP').AsString  := cdsData.FieldByName('RCX_CODEMP').AsString;
    LConsulta.ParamByName('DTAREF').AsDateTime := dtaDataReferencia;

    LConsulta.Open;

    FPixExclusao := fCriaClientDatSet(LConsulta);

    FreeAndNil(LConsulta);

  Finally
    FreeAndNil(LConsulta);
  End;

  If FPixExclusao.IsEmpty Then
  Begin
    Result := True;
    Exit;
  End;

  If (Not AMostrarTela) Then
    Exit;

  Try
    pCriarFormularios(TfrmRcxDocumentosDeletar, frmRcxDocumentosDeletar);

    frmRcxDocumentosDeletar.stgDocumentos.RowCount := FPixExclusao.RecordCount + 1;
    frmRcxDocumentosDeletar.stgDocumentos.ColCount := 8;
    {*******************************************}
    {* MONTA OS NOMES DAS COLUNAS              *}
    {****************************************MV*}
    frmRcxDocumentosDeletar.stgDocumentos.Cells[0, 0] := 'Banco';
    frmRcxDocumentosDeletar.stgDocumentos.Cells[1, 0] := 'Empresa';
    frmRcxDocumentosDeletar.stgDocumentos.Cells[2, 0] := 'Operador';
    frmRcxDocumentosDeletar.stgDocumentos.Cells[3, 0] := 'Dt. Receb.';
    frmRcxDocumentosDeletar.stgDocumentos.Cells[4, 0] := 'Valor';
    frmRcxDocumentosDeletar.stgDocumentos.Cells[5, 0] := 'Seq. Baixa';
    frmRcxDocumentosDeletar.stgDocumentos.Cells[6, 0] := 'Chave Pix';
    frmRcxDocumentosDeletar.stgDocumentos.Cells[7, 0] := 'Chave TxId';

    frmRcxDocumentosDeletar.stgDocumentos.ColWidths[0] := 64;
    frmRcxDocumentosDeletar.stgDocumentos.ColWidths[1] := 64;
    frmRcxDocumentosDeletar.stgDocumentos.ColWidths[2] := 64;
    frmRcxDocumentosDeletar.stgDocumentos.ColWidths[3] := 80;
    frmRcxDocumentosDeletar.stgDocumentos.ColWidths[4] := 64;
    frmRcxDocumentosDeletar.stgDocumentos.ColWidths[5] := 80;
    frmRcxDocumentosDeletar.stgDocumentos.ColWidths[6] := 120;
    frmRcxDocumentosDeletar.stgDocumentos.ColWidths[7] := 250;

    {*******************************************}
    {* MONTA DADOS                             *}
    {****************************************MV*}
    LContador := 1;
    FPixExclusao.First;
    While Not FPixExclusao.Eof Do
    Begin
      frmRcxDocumentosDeletar.stgDocumentos.Cells[0, LContador] := FPixExclusao.FieldByName('CCA_CODBCO').AsString;
      frmRcxDocumentosDeletar.stgDocumentos.Cells[1, LContador] := FPixExclusao.FieldByName('MPX_CODEMP').AsString;
      frmRcxDocumentosDeletar.stgDocumentos.Cells[2, LContador] := FPixExclusao.FieldByName('MPX_CODOPE').AsString;
      frmRcxDocumentosDeletar.stgDocumentos.Cells[3, LContador] := FormatDateTime('dd/mm/yyyy', FPixExclusao.FieldByName('MPX_DTAREC').AsDateTime);
      frmRcxDocumentosDeletar.stgDocumentos.Cells[4, LContador] := FloatToStrF(FPixExclusao.FieldByName('MPX_VALPIX').AsFloat, ffFixed, 12, 2);
      frmRcxDocumentosDeletar.stgDocumentos.Cells[5, LContador] := FPixExclusao.FieldByName('MPX_SEQCON').AsString;
      frmRcxDocumentosDeletar.stgDocumentos.Cells[6, LContador] := FPixExclusao.FieldByName('MPX_CHAPIX').AsString;
      frmRcxDocumentosDeletar.stgDocumentos.Cells[7, LContador] := FPixExclusao.FieldByName('MPX_TX_ID_').AsString;

      frmRcxDocumentosDeletar.stgDocumentos.RowHeights[LContador] := 20;

      FPixExclusao.Next;

      inc(LContador);
    End;

    Result := (frmRcxDocumentosDeletar.ShowModal = mrOk);
    If Not Result Then
      FPixExclusao.EmptyDataSet;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[MostraPixExclusao]');
    End;
  End;

  pFreeAndNil(frmRcxDocumentosDeletar);
end;

{************************************}
{* DIGITAÇÃO DOS CARTÕES            *}
{*********************************MV*}
function TfrmRcxFormasPagamento.fDigitacaoCartoes(fltValor: Double;
  blnMostrarTela: Boolean; strCodCar: String = ''; strCodFin: String = ''): Boolean;
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
    dtaDatTra: TDateTime;

    blnSaiFor: Boolean;

    stlDeletados: TStringList;
    frmRcxMostraCartoes : TfrmRcxMostraCartoes;
    frmRcxDigCartoes : TfrmRcxDigCartoes;
begin

  Result    := True;

  fltValDig := 0.0;
  fltValDes := 0.0;
  fltPerDes := 0.0;
  dtaDatTra := 0;

  {*******************************************}
  {* CASO O VALOR DE CARTÃO DIGITADO SEJA    *}
  {* IGUAL AO VALOR ORIGINAL, CANCELA TODOS  *}
  {* OS CARTÕES JÁ DIGITADOS                 *}
  {****************************************MV*}
  If FormatFloat(',0.00', fFormataFloat(fltValor, 2)).Equals(FormatFloat(',0.00', fFormataFloat(cdsData.FieldByName('RCX_CARREC').AsFloat, 2))) Then
  Begin
    SetLength(arrCartoesOriginais, 0);
    SetLength(arrCartoes, 0);
    Exit;
  End;

  If (fltValor = 0.0) Then
  Begin

    {*******************************************}
    {* MOSTRA OS CARTÕES QUE SERÃO EXCLUÍDOS   *}
    {* CASO ALTERE O VALOR DO CARTÃO           *}
    {****************************************MV*}
    If (fCarregaCartoesOriginais(blnMostrarTela)) Then
    Begin
      SetLength(arrCartoes, 0);
    End;
    Exit;

  End;

  fltTotCar := 0.0;
  For intContador := 0 To Length(arrCartoes) -1 Do
  Begin
    fltTotCar := fltTotCar + arrCartoes[intContador].fltValDig;
  End;

  If (fltTotCar = fltValor) And (blnMostrarTela) Then
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

      stlDeletados := frmRcxMostraCartoes.stlDeletados;

      For intContador := 0 To stlDeletados.Count -1 Do
      Begin

        blnSaiFor := False;

        For intContador2 := 0 To Length(arrCartoes) -1 Do
        Begin

          If (arrCartoes[intContador2].intCodSeq = StrToInt(stlDeletados[intContador])) Then
          Begin

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
        pMensagensErro(E.Message, '[fDigitacaoCartoes]');
      End;
    End;

    pFreeAndNil(frmRcxMostraCartoes);

  End
  Else
  Begin
    {*******************************************}
    {* MOSTRA OS CARTÕES QUE SERÃO EXCLUÍDOS   *}
    {* CASO ALTERE O VALOR DO CARTÃO           *}
    {****************************************MV*}
    If (Not fCarregaCartoesOriginais(blnMostrarTela)) Then
    Begin
      Result := False;
      Exit;
    End;
  End;

  fltTotCar := 0.0;
  For intContador := 0 To Length(arrCartoes) -1 Do
  Begin
    fltTotCar := fltTotCar + arrCartoes[intContador].fltValDig;
  End;

  If fFormataFloat(fltValor, 2) < fFormataFloat(fltTotCar, 2) Then
  Begin
    fltTotCar := 0.0;
    SetLength(arrCartoes, 0);
  End;

  While (fFormataFloat(fltTotCar, 2)) < (fFormataFloat(fltValor, 2)) Do
  Begin

    Try
      pCriarFormularios(TfrmRcxDigCartoes, frmRcxDigCartoes);
      frmRcxDigCartoes.strCodCar := strCodCar;
      frmRcxDigCartoes.strCodFin := strCodFin;
      frmRcxDigCartoes.fltTotDig := fltTotCar;
      frmRcxDigCartoes.fltTotGer := fltValor;
      frmRcxDigCartoes.fltMaxDig := (fltValor - fltTotCar);
      frmRcxDigCartoes.arrCartoes := arrCartoes;
      frmRcxDigCartoes.ShowModal;

      strCodCar := frmRcxDigCartoes.edtCodCar.Text;
      strDesCar := frmRcxDigCartoes.edtDesCar.Text;
      fltValDig := frmRcxDigCartoes.fltValDig;
      fltValDes := frmRcxDigCartoes.fltValDes;
      strCndPag := frmRcxDigCartoes.mskCndPag.Text;
      strNumCcd := frmRcxDigCartoes.edtNumCcd.Text;
      strNumNsu := frmRcxDigCartoes.edtNumNsu.Text;
      strObsCar := frmRcxDigCartoes.edtObsCar.Text;
      fltPerDes := frmRcxDigCartoes.fltPerDes;
      strTipCar := IIF(frmRcxDigCartoes.blnTipPOS, 'POS', 'TEF');
      dtaDatTra := frmRcxDigCartoes.dtaDatTra;

      Result    := frmRcxDigCartoes.blnConfirma;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fDigitacaoCartoes]');
      End;
    End;

    pFreeAndNil(frmRcxDigCartoes);

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
      arrCartoes[intTamMat].strNumNsu := strNumNsu;
      arrCartoes[intTamMat].fltPerDes := fltPerDes;
      arrCartoes[intTamMat].strTipCar := strTipCar;
      arrCartoes[intTamMat].dtaDtaTra := dtaDatTra;

      fltTotCar := 0.0;
      For intContador := 0 To Length(arrCartoes) -1 Do
      Begin
        fltTotCar := fltTotCar + arrCartoes[intContador].fltValDig;
      End;

    End
    Else
    Begin
      SetLength(arrCartoes, 0);
      Break;
    End;
    strCodCar := '';
  End;

end;

{************************************}
{* CADASTRA CHQUES A VISTA          *}
{*********************************AF*}
function TfrmRcxFormasPagamento.fChequeVis(strValor: String; blnMostrarTela: Boolean): Boolean;
  Var
    fltValCar: Double;
Begin
  Result := True;

  //pDeletaTemporaria(strTabTp2);

  If Not Assigned(cdsChqVis) Then cdsChqVis := fCriaCdsCheques(Self);

  fltValCar := fStrToFloat(strValor);

  If (fltValCar = 0.0) Then
  Begin

    If (fCarregaChqVisOriginais(blnMostrarTela)) Then
    Begin
      cdsChqVis.EmptyDataSet;
    End
    Else
      Result := False;

  End;

  If (fFormataFloat(fltValCar, 2) = fFormataFloat(cdsData.FieldByName('RCX_CHQAVI').AsFloat, 2)) And ((fRetornaTotalChqDigitados(cdsChqVis) = fltValCar) Or (blnChqAvi)) Then
  Begin
    Exit;
  End;

  If (fRetornaTotalChqDigitados(cdsChqVis) <> fltValCar) Then
  Begin
    If (Not fCarregaChqVisOriginais(blnMostrarTela)) Then
    Begin
      Result := False;
      Exit;
    End;
  End
  Else
  Begin
    Exit;
  End;

  With cdsChqVis Do
  Begin
    First;

    Try
      pCriarFormularios(TfrmCadCheques,frmCadCheques);
      frmCadCheques.strCodOpe         := strCodOpe;
      frmCadCheques.blnResumida       := True;
      frmCadCheques.blnResCai         := True;
      frmCadCheques.blnGravacaoFisica := False;
      frmCadCheques.fltValTot         := fltValCar;
      frmCadCheques.cdsChqRcx         := cdsChqVis;
      frmCadCheques.blnPrazo          := False;
      frmCadCheques.dbeDtaCad.Enabled := False;
      frmCadCheques.dbeDtaCad.TabStop := False;
      frmCadCheques.dbeDtaVen.Enabled := False;
      frmCadCheques.dbeDtaVen.TabStop := False;

      frmCadCheques.cdsTrcChqAvisPre.Data  := cdsTrcChqAvisPre.Data;
      frmCadCheques.cdsChqOutroTip.Data    := cdsChqPre.Data;

      frmCadCheques.strCliente        := fBuscaClienteUnico;

      frmCadCheques.RotinaChamada := 'RESUMO DE CAIXA->F3 ALTERAR FORMA PAGAMENTO';

      frmCadCheques.ShowModal;

      cdsChqVis.Data := frmCadCheques.cdsTabela.Data;

      If IsEmpty Or (Not frmCadCheques.blnConfima) Then
      Begin
        Result := False;
      End;  

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fChequeVis]');
      End;
    End;

    pFreeAndNil(frmCadCheques);

  End;

End;

function TfrmRcxFormasPagamento.fCorrige_CadRec_Vinculado(APortadorCadRec: String): Boolean;
Var
  qryUpdCtr: TUniQuery;
  qryAdtCli: TUniQuery;
  qryAdtDeb: TUniQuery;
  strCodCli,
  strNumDoc,
  strEspDoc,
  strCodEmp: String;
  strPedido: String;
  strDuplic: String;
  fltValLan: Double;
begin
  Result := True;

  qryAdtCli := fCriaQuery();
  with qryAdtCli do
  begin
    Sql.Clear;
    Sql.Text := ' SELECT ' +
                '   ADT_CODCLI, ADT_NUMDOC, ADT_ESPDOC, ADT_CODEMP, ADT_VALLAN ' +
                ' FROM ADTCLI ' +
                ' WHERE ' +
                '   ADT_SEQCON = :SEQCON AND ' +
                '   ADT_EMPLAN = :EMPLAN AND ';

    If strCodigoCaixa.IsEmpty Then
      Sql.Text := Sql.Text + '   ADT_DTALAN > :DTAREF '
    Else
      Sql.Text := Sql.Text + '   ADT_DTALAN >= :DTAREF ';

    ParamByName('SEQCON').AsInteger :=  cdsData.FieldByName('RCX_SEQCON').AsInteger;
    ParamByName('EMPLAN').AsString  :=  cdsData.FieldByName('RCX_CODEMP').AsString;
    ParamByName('DTAREF').AsDateTime := dtaDataReferencia;
    Open;

    if Not IsEmpty then
    begin
      strCodCli := FieldByName('ADT_CODCLI').AsString;
      strNumDoc := FieldByName('ADT_NUMDOC').AsString;
      strEspDoc := FieldByName('ADT_ESPDOC').AsString;
      strCodEmp := FieldByName('ADT_CODEMP').AsString;
      fltValLan := FieldByName('ADT_VALLAN').AsFloat;

      Close;
      Sql.Clear;
      Sql.Text := ' SELECT ' +
                  '   B.DET_NUMDOC, B.DET_ESPDOC, ' +
                  '   B.DET_CODEMP, B.DET_CODCLI, ' +
                  '   B.DET_NUM_PD, B.DET_ESP_PD, ' +
                  '   B.DET_EMP_PD, B.DET_CODCLI ' +
                  ' FROM ' +
                  '   ADTCLI A ' +
                  ' INNER JOIN MOVDET B ' +
                  '  ON A.ADT_CODCLI = B.DET_CODCLI AND A.ADT_NUMDOC = B.DET_NUM_PD AND ' +
                  '     A.ADT_ESPDOC = B.DET_ESP_PD AND A.ADT_CODEMP = B.DET_EMP_PD ' +
                  ' WHERE ' +
                  '   ADT_CODCLI = :CODCLI AND ' +
                  '   ADT_NUMDOC = :NUMDOC AND ' +
                  '   ADT_ESPDOC = :ESPDOC AND ' +
                  '   ADT_CODEMP = :CODEMP     ' +
                  ' GROUP BY ' +
                  '   B.DET_CODCLI, ' +
                  '   B.DET_NUM_PD, ' +
                  '   B.DET_ESP_PD, ' +
                  '   B.DET_EMP_PD  ';

      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;

      Open;

      if Not IsEmpty then
      begin
        if RecordCount = 1 then
        Begin
          qryUpdCtr := fCriaQuery();

          qryUpdCtr.Sql.Clear;
          qryUpdCtr.Sql.Text := fPegarSqlUpdateCadRec(False);

          qryUpdCtr.ParamByName('NUMDUP').AsString := FieldByName('DET_NUMDOC').AsString;
          qryUpdCtr.ParamByName('CODEMP').AsString := FieldByName('DET_CODEMP').AsString;
          qryUpdCtr.ParamByName('ESPDOC').AsString := FieldByName('DET_ESPDOC').AsString;
          qryUpdCtr.ParamByName('CODCLI').AsString := FieldByName('DET_CODCLI').AsString;
          qryUpdCtr.ParamByName('DINHEI').AsFloat  := fltDinhei;
          qryUpdCtr.ParamByName('CHQAVI').AsFloat  := fltChqVis;
          qryUpdCtr.ParamByName('CHQPRE').AsFloat  := fltChqPre;
          qryUpdCtr.ParamByName('CARTAO').AsFloat  := fltCartao;
          qryUpdCtr.ParamByName('ORDPAG').AsFloat  := fltOrdRec;

          qryUpdCtr.ParamByName('PORBAI').AsString := APortadorCadRec;

          qryUpdCtr.ParamByName('TOTMOD').AsFloat  := fltDinhei +
                                                      fltChqVis +
                                                      fltChqPre +
                                                      fltCartao +
                                                      fltOrdRec +
                                                      fltValFin;
          qryUpdCtr.ExecSQL;
          qryUpdCtr.Close;

          FreeAndNil(qryUpdCtr);

          GravarLogCtrDuplicatas(FieldByName('DET_NUMDOC').AsString,
                                 FieldByName('DET_ESPDOC').AsString,
                                 FieldByName('DET_CODEMP').AsString,
                                 FieldByName('DET_CODCLI').AsString);

          // Ajusta lançamento de débito de Adiantamento
          qryAdtDeb := fCriaQuery();
          qryAdtDeb.Sql.Clear;
          qryAdtDeb.Sql.Text := fPegarSqlDebitoAdiantamento;

          qryAdtDeb.ParamByName('NUMDOC').AsString := strNumDoc;
          qryAdtDeb.ParamByName('CODEMP').AsString := strCodEmp;
          qryAdtDeb.ParamByName('ESPDOC').AsString := strEspDoc;
          qryAdtDeb.ParamByName('CODCLI').AsString := strCodCli;
          qryAdtDeb.ParamByName('DINHEI').AsFloat  := fltDinhei;
          qryAdtDeb.ParamByName('CHQAVI').AsFloat  := fltChqVis;
          qryAdtDeb.ParamByName('CHQPRE').AsFloat  := fltChqPre;
          qryAdtDeb.ParamByName('CARTAO').AsFloat  := fltCartao;
          qryAdtDeb.ParamByName('ORDPAG').AsFloat  := fltOrdRec;
          qryAdtDeb.ParamByName('VALLAN').AsFloat  := fltValLan;

          qryAdtDeb.ParamByName('TOTMOD').AsFloat  := fltDinhei +
                                                      fltChqVis +
                                                      fltChqPre +
                                                      fltCartao +
                                                      fltOrdRec +
                                                      fltValFin;
          qryAdtDeb.ExecSQL;
          qryAdtDeb.Close;

          FreeAndNil(qryAdtDeb);
        End
        else
        begin
          Result := False;
          fRollBack();
          strDuplic := '';

          First;
          while not eof do
          begin
            strPedido := strPedido + 'Doc: ' + FieldByName('DET_NUM_PD').AsString +
                                     ' - Esp: ' + FieldByName('DET_ESP_PD').AsString +
                                     ' - Emp: ' + FieldByName('DET_EMP_PD').AsString +
                                     ' - Cli: ' + FieldByName('DET_EMP_PD').AsString + #13;


            Next;
          end;

          strDuplic := 'Doc: ' + FieldByName('DET_NUMDOC').AsString +
                       ' - Esp: ' + FieldByName('DET_ESPDOC').AsString +
                       ' - Emp: ' + FieldByName('DET_CODEMP').AsString +
                       ' - Cli: ' + FieldByName('DET_CODCLI').AsString + #13;

          pMensagemOkAltPer('Não é possível trocar a modalidade de um pedido que foi faturado '        +#13+
                            'em um documento junto com outro(s) pedido(s).Será necessário cancelar o ' +#13+
                            'documento em que o pedido foi faturado ou estornar e posteriormente '     +#13+
                            'refazer o recebimento! '+ #13#13 +
                            'Documento em que o pedido selecionado foi faturado: ' + #13 + strDuplic  + #13 +
                            'Pedidos que foram confirmados: ' + #13 + strPedido, 285+(recNo*15));
        end;
      end;
    end;
  end;

  FreeAndNil(qryAdtCli);
end;

{************************************}
{* CADASTRA OS CHEQUES A PRAZO.     *}
{* NÃO É IGUAL O CJEQUE PRE VIU NÃO *}
{* SE ENGANE                        *}
{*********************************AF*}
function TfrmRcxFormasPagamento.fChequePre(strValor: String; blnMostrarTela: Boolean): Boolean;
  Var
    fltValCar: Double;
Begin
  Result := True;

  //pDeletaTemporaria(strTabTmp);

  If Not Assigned(cdsChqPre) Then cdsChqPre := fCriaCdsCheques(Self);

  fltValCar := fStrToFloat(strValor);

  If (fltValCar = 0.0) Then
  Begin

    If (fCarregaChqPreOriginais(blnMostrarTela)) Then
    Begin
      cdsChqPre.EmptyDataSet;
//      Exit;
    End
    Else
      Result := False;

  End;

  If (fFormataFloat(fltValCar, 2) = fFormataFloat(cdsData.FieldByName('RCX_CHQPRE').AsFloat, 2)) And ((fRetornaTotalChqDigitados(cdsChqPre) = fltValCar) Or (blnChqPre)) Then
  Begin
    Exit;
  End;

  If (fRetornaTotalChqDigitados(cdsChqPre) <> fltValCar) Then
  Begin
    If (Not fCarregaChqPreOriginais(blnMostrarTela)) Then
    Begin
      Result := False;
      Exit;
    End;
  End
  Else
  Begin
    Exit;
  End;

  With cdsChqPre Do
  Begin
    First;

    Try
      pCriarFormularios(TfrmCadCheques,frmCadCheques);
      frmCadCheques.strCodOpe  := strCodOpe;
      frmCadCheques.blnResumida       := True;
      frmCadCheques.blnResCai  := True;
      frmCadCheques.blnGravacaoFisica := False;
      frmCadCheques.fltValTot  := fltValCar;
      frmCadCheques.blnPrazo   := True;
      frmCadCheques.cdsChqRcx  := cdsChqPre;

      frmCadCheques.cdsTrcChqAvisPre.Data  := cdsTrcChqAvisPre.Data;
      frmCadCheques.cdsChqOutroTip.Data := cdsChqVis.Data;

      frmCadCheques.strCliente        := fBuscaClienteUnico;

      frmCadCheques.RotinaChamada := 'RESUMO DE CAIXA->F3 ALTERAR FORMA PAGAMENTO';

      frmCadCheques.ShowModal;

      cdsChqPre.Data := frmCadCheques.cdsTabela.Data;

      If IsEmpty Or (Not frmCadCheques.blnConfima) Then
      Begin
        Result := False;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fChequePre]');
      End;
    End;

    pFreeAndNil(frmCadCheques);

  End;

End;

function TfrmRcxFormasPagamento.fAcertaRecebimentoAdtCli(ARecebidoPorPix, APortadorCadRec: String): Boolean;
  Var
    strSQL: String;
    qryUpd: TUniQuery;

  procedure pSetarParametros;
  begin
    qryUpd.ParamByName('DINHEI').AsFloat   := fltDinhei;
    qryUpd.ParamByName('CHQAVI').AsFloat   := fltChqVis;
    qryUpd.ParamByName('CHQPRE').AsFloat   := fltChqPre;
    qryUpd.ParamByName('CARTAO').AsFloat   := fltCartao;
    qryUpd.ParamByName('ORDPAG').AsFloat   := fltOrdRec;

    qryUpd.ParamByName('TOTMOD').AsFloat   := fltDinhei +
                                              fltChqVis +
                                              fltChqPre +
                                              fltCartao +
                                              fltOrdRec +
                                              fltValFin;

    qryUpd.ParamByName('SEQCON').AsInteger :=
      cdsData.FieldByName('RCX_SEQCON').AsInteger;

    qryUpd.ParamByName('EMPLAN').AsString :=
      cdsData.FieldByName('RCX_CODEMP').AsString;

    qryUpd.ParamByName('DTAREF').AsDateTime := dtaDataReferencia;

    qryUpd.ParamByName('RECPIX').AsString := ARecebidoPorPix;
  end;

begin
  strSQL := '';
  strSQL := strSQL + 'UPDATE ';
  strSQL := strSQL + '  ADTCLI ';
  strSQL := strSQL + 'SET ';

  strSQL := strSQL + '  ADT_VALDIN = (:DINHEI / :TOTMOD) * ADT_VALLAN, ';
  strSQL := strSQL + '  ADT_VALCHV = (:CHQAVI / :TOTMOD) * ADT_VALLAN, ';
  strSQL := strSQL + '  ADT_VALCHP = (:CHQPRE / :TOTMOD) * ADT_VALLAN, ';
  strSQL := strSQL + '  ADT_VALCAR = (:CARTAO / :TOTMOD) * ADT_VALLAN, ';
  strSQL := strSQL + '  ADT_VALORD = (:ORDPAG / :TOTMOD) * ADT_VALLAN, ';
  strSQL := strSQL + '  ADT_RECPIX = :RECPIX ';

  If Not APortadorCadRec.IsEmpty Then
    strSQL := strSQL + ', ADT_CODPOR = "' + APortadorCadRec + '" ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ADT_SEQCON = :SEQCON AND ';
  strSQL := strSQL + '  ADT_EMPLAN = :EMPLAN AND ';

  If strCodigoCaixa.IsEmpty Then
    strSQL := strSQL + '  ADT_DTALAN > :DTAREF     '
  Else
    strSQL := strSQL + '  ADT_DTALAN >= :DTAREF    ';

  qryUpd := fCriaQuery;

  qryUpd.SQL. Text := strSQL;
  pSetarParametros;
  qryUpd.ExecSQL;
  qryUpd.Close;
  
  FreeAndNil(qryUpd);

  Result := fCorrige_CadRec_Vinculado(APortadorCadRec);
end;

procedure TfrmRcxFormasPagamento.pAcertaRecebimentoCadRec;
  Var
    qryUpd: TUniQuery;
begin
  qryUpd := fCriaQuery;

  Try
    qryUpd.SQL.Text := fPegarSqlUpdateCadRec;

    qryUpd.ParamByName('DINHEI').AsFloat   := fltDinhei;
    qryUpd.ParamByName('CHQAVI').AsFloat   := fltChqVis;
    qryUpd.ParamByName('CHQPRE').AsFloat   := fltChqPre;
    qryUpd.ParamByName('CARTAO').AsFloat   := fltCartao;
    qryUpd.ParamByName('ORDPAG').AsFloat   := fltOrdRec;
    qryUpd.ParamByName('VALFIN').AsFloat   := fltValFin;

    qryUpd.ParamByName('TOTMOD').AsFloat   := fltDinhei +
                                              fltChqVis +
                                              fltChqPre +
                                              fltCartao +
                                              fltOrdRec +
                                              fltValFin;

    qryUpd.ParamByName('SEQCON').AsInteger :=
      cdsData.FieldByName('RCX_SEQCON').AsInteger;

    qryUpd.ParamByName('EMPBAI').AsString :=
      cdsData.FieldByName('RCX_CODEMP').AsString;

    qryUpd.ParamByName('DTAREF').AsDateTime := dtaDataReferencia;

    qryUpd.ExecSQL;

  Finally
    qryUpd.Close;

    FreeAndNil(qryUpd);
  End;
end;

procedure TfrmRcxFormasPagamento.pAtualizaValDig;
 Var
   intContador: Integer;
Begin

  fltDinhei := 0;
  fltChqVis := 0;
  fltChqPre := 0;
  fltCartao := 0;
  fltValFin := 0;
  fltOrdRec := 0;

  If Not fEmptyStr(edtDinheiro.Text) Then
    fltDinhei := fStrToFloat(edtDinheiro.Text);

  If Not fEmptyStr(edtChqVista.Text) Then
    fltChqVis := fStrToFloat(edtChqVista.Text);

  If Not fEmptyStr(edtChqPre.Text) Then
    fltChqPre := fStrToFloat(edtChqPre.Text);

  If Not fEmptyStr(edtValFin.Text) Then
    fltValFin := fStrToFloat(edtValFin.Text);

  If Not fEmptyStr(edtOrdRec.Text) Then
    fltOrdRec := fStrToFloat(edtOrdRec.Text);

  If (Length(arrCartoes) > 0) Then
  Begin

    For intContador := 0 To Length(arrCartoes)-1 Do
    Begin
      fltCartao := fltCartao + arrCartoes[intContador].fltValDig;
    End;

  End
  Else
  Begin

    fltCartao := (fStrToFloat(edtCartao.Text));

  End;

  edtCartao.Text := FloatToStrF(fltCartao,ffFixed,12,2);

  fltValDig := fltDinhei + fltChqVis + fltChqPre + fltCartao + fltValFin + fltOrdRec;

  lblValDig.Caption := 'Valor Digitado: ' + FloatToStrF(fltValDig,ffFixed,12,2);
End;

function TfrmRcxFormasPagamento.fCarregaCartoesOriginais(blnMostrarTela: Boolean): Boolean;
  Var
    strSQL     : String;
    intContador: Integer;
    qryGenCar  : TUniQuery;
    frmRcxDocumentosDeletar : TfrmRcxDocumentosDeletar;
begin

  Result := True;

  qryGenCar := fCriaQuery(Self);

  SetLength(arrCartoesOriginais, 0);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  MCA_NUMDUP, ';
  strSQL := strSQL + '  CONCAT(MCA_CODCLI, "-", CLI_NOMCLI) AS MCA_CODCLI, ';
  strSQL := strSQL + '  MCA_PARCEL, ';
  strSQL := strSQL + '  MCA_CODEMP, ';
  strSQL := strSQL + '  MCA_DTACAD, ';
  strSQL := strSQL + '  MCA_DTAVEN, ';
  strSQL := strSQL + '  MCA_VALORI, ';
  strSQL := strSQL + '  MCA_SEQCON, ';
  strSQL := strSQL + '  MCA_EMPRCX, ';
  strSQL := strSQL + '  MOVCAR.AUTOINCREM  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVCAR  ';
  strSQL := strSQL + '  JOIN CADCLI ON CLI_CODCLI = MCA_CODCLI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  MCA_SEQCON = :SEQCON AND ';
  strSQL := strSQL + '  MCA_EMPRCX = :CODEMP AND ';

  If strCodigoCaixa.IsEmpty Then
    strSQL := strSQL + '  MCA_DTACAD > :DTAREF AND '
  Else
    strSQL := strSQL + '  MCA_DTACAD >= :DTAREF AND ';

  strSQL := strSQL + '  MCA_RESCAI = 1       AND ';
  strSQL := strSQL + '  MCA_DTATRA IS NULL       ';

  With qryGenCar Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString  := cdsData.FieldByName('RCX_CODEMP').AsString;
    ParamByName('SEQCON').AsInteger := cdsData.FieldByName('RCX_SEQCON').AsInteger;
    ParamByName('DTAREF').AsDateTime := dtaDataReferencia;

    Open;

    SetLength(arrCartoesOriginais, RecordCount);

    blnCartaoCad := (Not IsEmpty);

    While (Not Eof) Do
    Begin
      arrCartoesOriginais[RecNo-1].strNumDup := FieldByName('MCA_NUMDUP').AsString;
      arrCartoesOriginais[RecNo-1].strCodCli := FieldByName('MCA_CODCLI').AsString;
      arrCartoesOriginais[RecNo-1].strParcel := FieldByName('MCA_PARCEL').AsString;
      arrCartoesOriginais[RecNo-1].strCodEmp := FieldByName('MCA_CODEMP').AsString;
      arrCartoesOriginais[RecNo-1].dtaDtaCad := FieldByName('MCA_DTACAD').AsDateTime;
      arrCartoesOriginais[RecNo-1].dtaDtaVen := FieldByName('MCA_DTAVEN').AsDateTime;
      arrCartoesOriginais[RecNo-1].fltValOri := FieldByName('MCA_VALORI').AsFloat;
      arrCartoesOriginais[RecNo-1].intSeqCon := FieldByName('MCA_SEQCON').AsInteger;
      arrCartoesOriginais[RecNo-1].strEmpRcx := FieldByName('MCA_EMPRCX').AsString;
      arrCartoesOriginais[RecNo-1].strAutInc := FieldByName('AUTOINCREM').AsString;

      Next;
    End;

    Close;
  End;

  If (Length(arrCartoesOriginais) <= 0) Then
  Begin
    Result := True;
    Exit;
  End;

  If (Not blnMostrarTela) Then
    Exit;

  Try
    If (blnCarRec) Then
    Begin
      pCriarFormularios(TfrmRcxDocumentosDeletar, frmRcxDocumentosDeletar);

      frmRcxDocumentosDeletar.stgDocumentos.RowCount := Length(arrCartoesOriginais) + 1;
      frmRcxDocumentosDeletar.stgDocumentos.ColCount := 6;

      {*******************************************}
      {* MONTA OS NOMES DAS COLUNAS              *}
      {****************************************MV*}
      frmRcxDocumentosDeletar.stgDocumentos.Cells[0, 0] := 'Documento';
      frmRcxDocumentosDeletar.stgDocumentos.Cells[1, 0] := 'Cliente';
      frmRcxDocumentosDeletar.stgDocumentos.Cells[2, 0] := 'Empresa';
      frmRcxDocumentosDeletar.stgDocumentos.Cells[3, 0] := 'Dt. Cadastro';
      frmRcxDocumentosDeletar.stgDocumentos.Cells[4, 0] := 'Dt. Vencimento';
      frmRcxDocumentosDeletar.stgDocumentos.Cells[5, 0] := 'Valor Cartão';

      frmRcxDocumentosDeletar.stgDocumentos.ColWidths[0] := 70;
      frmRcxDocumentosDeletar.stgDocumentos.ColWidths[1] := 250;
      frmRcxDocumentosDeletar.stgDocumentos.ColWidths[2] := 50;
      frmRcxDocumentosDeletar.stgDocumentos.ColWidths[3] := 70;
      frmRcxDocumentosDeletar.stgDocumentos.ColWidths[4] := 80;
      frmRcxDocumentosDeletar.stgDocumentos.ColWidths[5] := 70;

      {*******************************************}
      {* MONTA OS DADOS                          *}
      {****************************************MV*}
      For intContador := 0 To Length(arrCartoesOriginais) -1 Do
      Begin

        frmRcxDocumentosDeletar.stgDocumentos.Cells[0, intContador+1] := arrCartoesOriginais[intContador].strNumDup + arrCartoesOriginais[intContador].strParcel;
        frmRcxDocumentosDeletar.stgDocumentos.Cells[1, intContador+1] := arrCartoesOriginais[intContador].strCodCli;
        frmRcxDocumentosDeletar.stgDocumentos.Cells[2, intContador+1] := arrCartoesOriginais[intContador].strCodEmp;
        frmRcxDocumentosDeletar.stgDocumentos.Cells[3, intContador+1] := DateToStr(arrCartoesOriginais[intContador].dtaDtaCad);
        frmRcxDocumentosDeletar.stgDocumentos.Cells[4, intContador+1] := DateToStr(arrCartoesOriginais[intContador].dtaDtaVen);
        frmRcxDocumentosDeletar.stgDocumentos.Cells[5, intContador+1] := FloatToStrF(arrCartoesOriginais[intContador].fltValOri, ffFixed, 12, 2);

      End;

      Result := (frmRcxDocumentosDeletar.ShowModal = mrOk);
      blnCarRec := Not Result;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fCarregaCartoesOriginais]');
    End;
  End;

  pFreeAndNil(frmRcxDocumentosDeletar);
  FreeAndNil(qryGenCar);

end;

function TfrmRcxFormasPagamento.fCarregaChqVisOriginais(blnMostrarTela: Boolean): Boolean;
  Var
    intContador: Integer;
    strSQL     : String;
    qryGenChq  : TUniQuery;
    frmRcxDocumentosDeletar : TfrmRcxDocumentosDeletar;
begin

  Result := True;

  qryGenChq := fCriaQuery(Self);

  SetLength(arrChqVisOriginais, 0);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CHQ_CODBCO, ';
  strSQL := strSQL + '  CHQ_NUMAGE, ';
  strSQL := strSQL + '  CHQ_CONCOR, ';
  strSQL := strSQL + '  CHQ_NUMCHQ, ';
  strSQL := strSQL + '  CHQ_CODEMP, ';
  strSQL := strSQL + '  CHQ_DTACAD, ';
  strSQL := strSQL + '  CHQ_DTAVEN, ';
  strSQL := strSQL + '  CHQ_VALCHQ, ';
  strSQL := strSQL + '  CHQ_SEQCON, ';
  strSQL := strSQL + '  CHQ_EMPRCX  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCHQ ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CHQ_SEQCON = :SEQCON AND ';
  strSQL := strSQL + '  CHQ_EMPRCX = :CODEMP AND ';

  If strCodigoCaixa.IsEmpty Then
    strSQL := strSQL + '  CHQ_DTACAD > :DTAREF AND '
  Else
    strSQL := strSQL + '  CHQ_DTACAD >= :DTAREF AND ';

  strSQL := strSQL + '  RIGHT(CHQ_DOCUME, 3) = "AVI" AND ';
  strSQL := strSQL + '  CHQ_RESCAI = 1       AND ';
  strSQL := strSQL + '  CHQ_DTATRA IS NULL       ';

  With qryGenChq Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('SEQCON').AsInteger := cdsData.FieldByName('RCX_SEQCON').AsInteger;
    ParamByName('CODEMP').AsString  := cdsData.FieldByName('RCX_CODEMP').AsString;
    ParamByName('DTAREF').AsDateTime := dtaDataReferencia;

    Open;

    SetLength(arrChqVisOriginais, RecordCount);

    blnChqVisCad := (Not IsEmpty);

    cdsTrcChqAvisPre.EmptyDataSet;

    While (Not Eof) Do
    Begin
      arrChqVisOriginais[RecNo-1].strCodBco := FieldByName('CHQ_CODBCO').AsString;
      arrChqVisOriginais[RecNo-1].strNumAge := FieldByName('CHQ_NUMAGE').AsString;
      arrChqVisOriginais[RecNo-1].strConCor := FieldByName('CHQ_CONCOR').AsString;
      arrChqVisOriginais[RecNo-1].strNumChq := FieldByName('CHQ_NUMCHQ').AsString;
      arrChqVisOriginais[RecNo-1].strCodEmp := FieldByName('CHQ_CODEMP').AsString;
      arrChqVisOriginais[RecNo-1].dtaDtaCad := FieldByName('CHQ_DTACAD').AsDateTime;
      arrChqVisOriginais[RecNo-1].dtaDtaVen := FieldByName('CHQ_DTAVEN').AsDateTime;
      arrChqVisOriginais[RecNo-1].fltValChq := FieldByName('CHQ_VALCHQ').AsFloat;
      arrChqVisOriginais[RecNo-1].intSeqCon := FieldByName('CHQ_SEQCON').AsInteger;
      arrChqVisOriginais[RecNo-1].strEmpRcx := FieldByName('CHQ_EMPRCX').AsString;

      cdsTrcChqAvisPre.Insert;
      cdsTrcChqAvisPre.FieldByName('CHQ_CODBCO').AsString   := FieldByName('CHQ_CODBCO').AsString;
      cdsTrcChqAvisPre.FieldByName('CHQ_NUMAGE').AsString   := FieldByName('CHQ_NUMAGE').AsString;
      cdsTrcChqAvisPre.FieldByName('CHQ_CONCOR').AsString   := FieldByName('CHQ_CONCOR').AsString;
      cdsTrcChqAvisPre.FieldByName('CHQ_NUMCHQ').AsString   := FieldByName('CHQ_NUMCHQ').AsString;
      cdsTrcChqAvisPre.FieldByName('CHQ_CODEMP').AsString   := FieldByName('CHQ_CODEMP').AsString;
      cdsTrcChqAvisPre.FieldByName('CHQ_DTACAD').AsDateTime := FieldByName('CHQ_DTACAD').AsDateTime;
      cdsTrcChqAvisPre.FieldByName('CHQ_DTAVEN').AsDateTime := FieldByName('CHQ_DTAVEN').AsDateTime;
      cdsTrcChqAvisPre.FieldByName('CHQ_VALCHQ').AsFloat    := FieldByName('CHQ_VALCHQ').AsFloat;
      cdsTrcChqAvisPre.FieldByName('CHQ_SEQCON').AsInteger  := FieldByName('CHQ_SEQCON').AsInteger;
      cdsTrcChqAvisPre.FieldByName('CHQ_EMPRCX').AsString   := FieldByName('CHQ_EMPRCX').AsString;
      cdsTrcChqAvisPre.Post;

      Next;
    End;

    Close;
  End;

  If (Length(arrChqVisOriginais) <= 0) Then
  Begin
    Result := True;
    Exit;
  End;

  If (Not blnMostrarTela) Then
    Exit;

  Try
    If (blnChqAvi) Then
    Begin
      pCriarFormularios(TfrmRcxDocumentosDeletar, frmRcxDocumentosDeletar);

      frmRcxDocumentosDeletar.stgDocumentos.RowCount := Length(arrChqVisOriginais) + 1;
      frmRcxDocumentosDeletar.stgDocumentos.ColCount := 8;
      {*******************************************}
      {* MONTA OS NOMES DAS COLUNAS              *}
      {****************************************MV*}
      frmRcxDocumentosDeletar.stgDocumentos.Cells[0, 0] := 'Banco';
      frmRcxDocumentosDeletar.stgDocumentos.Cells[1, 0] := 'Agencia';
      frmRcxDocumentosDeletar.stgDocumentos.Cells[2, 0] := 'Ct. Corrente';
      frmRcxDocumentosDeletar.stgDocumentos.Cells[3, 0] := 'Nro. Cheque';
      frmRcxDocumentosDeletar.stgDocumentos.Cells[4, 0] := 'Empresa';
      frmRcxDocumentosDeletar.stgDocumentos.Cells[5, 0] := 'Dt. Cadastro';
      frmRcxDocumentosDeletar.stgDocumentos.Cells[6, 0] := 'Dt. Vencimento';
      frmRcxDocumentosDeletar.stgDocumentos.Cells[7, 0] := 'Valor Cheque';

      frmRcxDocumentosDeletar.stgDocumentos.ColWidths[0] := 64;
      frmRcxDocumentosDeletar.stgDocumentos.ColWidths[1] := 80;
      frmRcxDocumentosDeletar.stgDocumentos.ColWidths[2] := 80;
      frmRcxDocumentosDeletar.stgDocumentos.ColWidths[3] := 80;
      frmRcxDocumentosDeletar.stgDocumentos.ColWidths[4] := 64;
      frmRcxDocumentosDeletar.stgDocumentos.ColWidths[5] := 64;
      frmRcxDocumentosDeletar.stgDocumentos.ColWidths[6] := 80;
      frmRcxDocumentosDeletar.stgDocumentos.ColWidths[7] := 80;

      {*******************************************}
      {* MONTA DADOS                             *}
      {****************************************MV*}
      For intContador := 0 To Length(arrChqVisOriginais) -1 Do
      Begin
        frmRcxDocumentosDeletar.stgDocumentos.Cells[0, intContador+1] := arrChqVisOriginais[intContador].strCodBco;
        frmRcxDocumentosDeletar.stgDocumentos.Cells[1, intContador+1] := arrChqVisOriginais[intContador].strNumAge;
        frmRcxDocumentosDeletar.stgDocumentos.Cells[2, intContador+1] := arrChqVisOriginais[intContador].strConCor;
        frmRcxDocumentosDeletar.stgDocumentos.Cells[3, intContador+1] := arrChqVisOriginais[intContador].strNumChq;
        frmRcxDocumentosDeletar.stgDocumentos.Cells[4, intContador+1] := arrChqVisOriginais[intContador].strCodEmp;
        frmRcxDocumentosDeletar.stgDocumentos.Cells[5, intContador+1] := DateToStr(arrChqVisOriginais[intContador].dtaDtaCad);
        frmRcxDocumentosDeletar.stgDocumentos.Cells[6, intContador+1] := DateToStr(arrChqVisOriginais[intContador].dtaDtaVen);
        frmRcxDocumentosDeletar.stgDocumentos.Cells[7, intContador+1] := FloatToStrF(arrChqVisOriginais[intContador].fltValChq, ffFixed, 12, 2);

        frmRcxDocumentosDeletar.stgDocumentos.RowHeights[intContador+1] := 20;
      End;

      Result := (frmRcxDocumentosDeletar.ShowModal = mrOk);
      If Not Result Then
        cdsTrcChqAvisPre.EmptyDataSet;

      blnChqAvi := Not Result;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fCarregaChqVisOriginais]');
    End;
  End;

  pFreeAndNil(frmRcxDocumentosDeletar);
  FreeAndNil(qryGenChq);

end;

function TfrmRcxFormasPagamento.fPegarSqlUpdateCadRec(blnWhereComSeqCon: Boolean = True): String;
begin
  Result := '';
  Result := Result + 'UPDATE ';
  Result := Result + '  CADREC ';
  Result := Result + 'SET ';

  Result := Result + '  CTR_DINHEI = IF(CTR_VALORI > 0, (:DINHEI / :TOTMOD) * CTR_VALREC, CTR_DINHEI), ';
  Result := Result + '  CTR_CHQAVI = IF(CTR_VALORI > 0, (:CHQAVI / :TOTMOD) * CTR_VALREC, CTR_CHQAVI), ';
  Result := Result + '  CTR_CHQPRE = IF(CTR_VALORI > 0, (:CHQPRE / :TOTMOD) * CTR_VALREC, CTR_CHQPRE), ';
  Result := Result + '  CTR_CARTAO = IF(CTR_VALORI > 0, (:CARTAO / :TOTMOD) * CTR_VALREC, CTR_CARTAO), ';
  Result := Result + '  CTR_ORDPAG = IF(CTR_VALORI > 0, (:ORDPAG / :TOTMOD) * CTR_VALREC, CTR_ORDPAG), ';
  Result := Result + '  CTR_VALFIN = IF(CTR_VALORI > 0, (:VALFIN / :TOTMOD) * CTR_VALREC, CTR_VALFIN), ';

  If Not blnWhereComSeqCon Then
    Result := Result + '  CTR_PORBAI = :PORBAI, ';

  Result := Result + '  CTR_RECDIN = IF(:DINHEI > 0, "S", "N"), ';
  Result := Result + '  CTR_RECCHE = IF(:CHQAVI > 0, "S", "N"), ';
  Result := Result + '  CTR_RECPRE = IF(:CHQPRE > 0, "S", "N"), ';
  Result := Result + '  CTR_RECCAR = IF(:CARTAO > 0, "S", "N"), ';
  Result := Result + '  CTR_RECORD = IF(:ORDPAG > 0, "S", "N"), ';
  Result := Result + '  CTR_RECFIN = IF(:VALFIN > 0, "S", "N")  ';

  Result := Result + 'WHERE ';
  if blnWhereComSeqCon  then
  begin
    Result := Result + '  CTR_SEQCON = :SEQCON AND ';
    Result := Result + '  CTR_EMPBAI = :EMPBAI AND ';

    If strCodigoCaixa.IsEmpty Then
      Result := Result + '  CTR_DTABAI > :DTAREF '
    Else
      Result := Result + '  CTR_DTABAI >= :DTAREF ';
  end
  else
  begin
    Result := Result + '  CTR_NUMDUP = :NUMDUP AND ';
    Result := Result + '  CTR_ESPDOC = :ESPDOC AND ';
    Result := Result + '  CTR_CODEMP = :CODEMP AND ';
    Result := Result + '  CTR_CODCLI = :CODCLI ';
  end;
end;

function TfrmRcxFormasPagamento.fPegarSqlDebitoAdiantamento: String;
begin
  Result := '';
  Result := Result + 'UPDATE ';
  Result := Result + '  ADTCLI ';
  Result := Result + 'SET ';

  Result := Result + '  ADT_VALDIN = (:DINHEI / :TOTMOD) * ADT_VALLAN, ';
  Result := Result + '  ADT_VALCHV = (:CHQAVI / :TOTMOD) * ADT_VALLAN, ';
  Result := Result + '  ADT_VALCHP = (:CHQPRE / :TOTMOD) * ADT_VALLAN, ';
  Result := Result + '  ADT_VALCAR = (:CARTAO / :TOTMOD) * ADT_VALLAN, ';
  Result := Result + '  ADT_VALORD = (:ORDPAG / :TOTMOD) * ADT_VALLAN  ';

  Result := Result + 'WHERE ';
  Result := Result + '  ADT_CODCLI = :CODCLI AND ' +
                     '  ADT_NUMDOC = :NUMDOC AND ' +
                     '  ADT_ESPDOC = :ESPDOC AND ' +
                     '  ADT_CODEMP = :CODEMP AND ' +
                     '  ADT_VALLAN = :VALLAN AND ' +
                     '  ADT_TIPLAN = "D" ';
end;

function TfrmRcxFormasPagamento.fRetHisCar(intSeqCon: Integer;
  strCodEmp: String): String;
  Var
    qrySelDoc: TUniQuery;
begin
  qrySelDoc := fCriaQuery;
  With qrySelDoc Do
  Begin
    SQL.Text := 'SELECT CTR_NUMDUP, CTR_ESPDOC, CTR_PARCEL, CTR_CODEMP FROM CADREC WHERE ' +
                ' CTR_SEQCON = :SEQCON AND CTR_EMPBAI = :EMPBAI AND';

    If strCodigoCaixa.IsEmpty Then
      SQL.Text := SQL.Text + ' CTR_DTABAI > :DTAREF '
    Else
      SQL.Text := SQL.Text + ' CTR_DTABAI >= :DTAREF ';

    ParamByName('SEQCON').AsInteger := intSeqCon;
    ParamByName('EMPBAI').AsString  := strCodEmp;
    ParamByName('DTAREF').AsDateTime := dtaDataReferencia;
    Open;

    Result := '';
    While Not Eof Do
    Begin
      Result := Result + FieldByName('CTR_NUMDUP').AsString +
                FieldByName('CTR_PARCEL').AsString + '-' +
                FieldByName('CTR_ESPDOC').AsString + '-' +
                FieldByName('CTR_CODEMP').AsString + '/';
      Next;
    End;
    Result := Copy(Result, 1, Length(Result) - 1);

    If RecordCount = 1 Then
      Result := 'REF. AO DOC. ' + Copy(Result, 1, 250 - Length('REF. AO DOC. '))
    Else
      Result := 'REF. AOS DOCS. '  + Copy(Result, 1, 250 - Length('REF. AOS DOCS. '));
    Close;
  End;
  FreeAndNil(qrySelDoc);
end;

function TfrmRcxFormasPagamento.fRetornaTotalChqDigitados(cdsCheques: TUniClientDataSet): Double;
begin
  Result := 0.00;

  With cdsCheques Do
    If Assigned(cdsCheques) And (Not IsEmpty) Then
      Result := TAggregateField(FieldByName('TOT_VALCHQ')).Value;

  Result := fFormataFloat(Result, 2);
end;

function TfrmRcxFormasPagamento.fCarregaChqPreOriginais(blnMostrarTela: Boolean): Boolean;
  Var
    strSQL     : String;
    intContador: Integer;
    qryGenChq  : TUniQuery;
    frmRcxDocumentosDeletar : TfrmRcxDocumentosDeletar;
begin

  Result := True;

  qryGenChq := fCriaQuery(Self);

  SetLength(arrChqPreOriginais, 0);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CHQ_CODBCO, ';
  strSQL := strSQL + '  CHQ_NUMAGE, ';
  strSQL := strSQL + '  CHQ_CONCOR, ';
  strSQL := strSQL + '  CHQ_NUMCHQ, ';
  strSQL := strSQL + '  CHQ_CODEMP, ';
  strSQL := strSQL + '  CHQ_DTACAD, ';
  strSQL := strSQL + '  CHQ_DTAVEN, ';
  strSQL := strSQL + '  CHQ_VALCHQ, ';
  strSQL := strSQL + '  CHQ_SEQCON, ';
  strSQL := strSQL + '  CHQ_EMPRCX  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCHQ ';
  strSQL := strSQL + 'WHERE ';
//  strSQL := strSQL + '  CHQ_DOCUME = :DOCUME ';
  strSQL := strSQL + '  CHQ_SEQCON = :SEQCON AND ';
  strSQL := strSQL + '  CHQ_EMPRCX = :CODEMP AND ';

  If strCodigoCaixa.IsEmpty Then
    strSQL := strSQL + '  CHQ_DTACAD > :DTAREF AND '
  Else
    strSQL := strSQL + '  CHQ_DTACAD >= :DTAREF AND ';

  strSQL := strSQL + '  RIGHT(CHQ_DOCUME, 3) = "PRZ" AND ';
  strSQL := strSQL + '  CHQ_RESCAI = 1       AND ';
  strSQL := strSQL + '  CHQ_DTATRA IS NULL       ';

  With qryGenChq Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('SEQCON').AsInteger := cdsData.FieldByName('RCX_SEQCON').AsInteger;
    ParamByName('CODEMP').AsString  := cdsData.FieldByName('RCX_CODEMP').AsString;
    ParamByName('DTAREF').AsDateTime := dtaDataReferencia;

    Open;

    SetLength(arrChqPreOriginais, RecordCount);

    blnChqPreCad := (Not IsEmpty);

    cdsTrcChqAvisPre.EmptyDataSet;

    While (Not Eof) Do
    Begin
      arrChqPreOriginais[RecNo-1].strCodBco := FieldByName('CHQ_CODBCO').AsString;
      arrChqPreOriginais[RecNo-1].strNumAge := FieldByName('CHQ_NUMAGE').AsString;
      arrChqPreOriginais[RecNo-1].strConCor := FieldByName('CHQ_CONCOR').AsString;
      arrChqPreOriginais[RecNo-1].strNumChq := FieldByName('CHQ_NUMCHQ').AsString;
      arrChqPreOriginais[RecNo-1].strCodEmp := FieldByName('CHQ_CODEMP').AsString;
      arrChqPreOriginais[RecNo-1].dtaDtaCad := FieldByName('CHQ_DTACAD').AsDateTime;
      arrChqPreOriginais[RecNo-1].dtaDtaVen := FieldByName('CHQ_DTAVEN').AsDateTime;
      arrChqPreOriginais[RecNo-1].fltValChq := FieldByName('CHQ_VALCHQ').AsFloat;
      arrChqPreOriginais[RecNo-1].intSeqCon := FieldByName('CHQ_SEQCON').AsInteger;
      arrChqPreOriginais[RecNo-1].strEmpRcx := FieldByName('CHQ_EMPRCX').AsString;

      cdsTrcChqAvisPre.Insert;
      cdsTrcChqAvisPre.FieldByName('CHQ_CODBCO').AsString   := FieldByName('CHQ_CODBCO').AsString;
      cdsTrcChqAvisPre.FieldByName('CHQ_NUMAGE').AsString   := FieldByName('CHQ_NUMAGE').AsString;
      cdsTrcChqAvisPre.FieldByName('CHQ_CONCOR').AsString   := FieldByName('CHQ_CONCOR').AsString;
      cdsTrcChqAvisPre.FieldByName('CHQ_NUMCHQ').AsString   := FieldByName('CHQ_NUMCHQ').AsString;
      cdsTrcChqAvisPre.FieldByName('CHQ_CODEMP').AsString   := FieldByName('CHQ_CODEMP').AsString;
      cdsTrcChqAvisPre.FieldByName('CHQ_DTACAD').AsDateTime := FieldByName('CHQ_DTACAD').AsDateTime;
      cdsTrcChqAvisPre.FieldByName('CHQ_DTAVEN').AsDateTime := FieldByName('CHQ_DTAVEN').AsDateTime;
      cdsTrcChqAvisPre.FieldByName('CHQ_VALCHQ').AsFloat    := FieldByName('CHQ_VALCHQ').AsFloat;
      cdsTrcChqAvisPre.FieldByName('CHQ_SEQCON').AsInteger  := FieldByName('CHQ_SEQCON').AsInteger;
      cdsTrcChqAvisPre.FieldByName('CHQ_EMPRCX').AsString   := FieldByName('CHQ_EMPRCX').AsString;
      cdsTrcChqAvisPre.Post;

      Next;
    End;

    Close;
  End;

  If (Length(arrChqPreOriginais) <= 0) Then
  Begin
    Result := True;
    Exit;
  End;

  If (Not blnMostrarTela) Then
    Exit;

  Try
    If (blnChqPre) Then
    Begin
      pCriarFormularios(TfrmRcxDocumentosDeletar, frmRcxDocumentosDeletar);

      frmRcxDocumentosDeletar.stgDocumentos.RowCount := Length(arrChqPreOriginais) + 1;
      frmRcxDocumentosDeletar.stgDocumentos.ColCount := 8;
      {*******************************************}
      {* MONTA OS NOMES DAS COLUNAS              *}
      {****************************************MV*}
      frmRcxDocumentosDeletar.stgDocumentos.Cells[0, 0] := 'Banco';
      frmRcxDocumentosDeletar.stgDocumentos.Cells[1, 0] := 'Agencia';
      frmRcxDocumentosDeletar.stgDocumentos.Cells[2, 0] := 'Ct. Corrente';
      frmRcxDocumentosDeletar.stgDocumentos.Cells[3, 0] := 'Nro. Cheque';
      frmRcxDocumentosDeletar.stgDocumentos.Cells[4, 0] := 'Empresa';
      frmRcxDocumentosDeletar.stgDocumentos.Cells[5, 0] := 'Dt. Cadastro';
      frmRcxDocumentosDeletar.stgDocumentos.Cells[6, 0] := 'Dt. Vencimento';
      frmRcxDocumentosDeletar.stgDocumentos.Cells[7, 0] := 'Valor Cheque';

      frmRcxDocumentosDeletar.stgDocumentos.ColWidths[0] := 64;
      frmRcxDocumentosDeletar.stgDocumentos.ColWidths[1] := 80;
      frmRcxDocumentosDeletar.stgDocumentos.ColWidths[2] := 80;
      frmRcxDocumentosDeletar.stgDocumentos.ColWidths[3] := 80;
      frmRcxDocumentosDeletar.stgDocumentos.ColWidths[4] := 64;
      frmRcxDocumentosDeletar.stgDocumentos.ColWidths[5] := 64;
      frmRcxDocumentosDeletar.stgDocumentos.ColWidths[6] := 80;
      frmRcxDocumentosDeletar.stgDocumentos.ColWidths[7] := 80;

      {*******************************************}
      {* MONTA DADOS                             *}
      {****************************************MV*}
      For intContador := 0 To Length(arrChqPreOriginais) -1 Do
      Begin
        frmRcxDocumentosDeletar.stgDocumentos.Cells[0, intContador+1] := arrChqPreOriginais[intContador].strCodBco;
        frmRcxDocumentosDeletar.stgDocumentos.Cells[1, intContador+1] := arrChqPreOriginais[intContador].strNumAge;
        frmRcxDocumentosDeletar.stgDocumentos.Cells[2, intContador+1] := arrChqPreOriginais[intContador].strConCor;
        frmRcxDocumentosDeletar.stgDocumentos.Cells[3, intContador+1] := arrChqPreOriginais[intContador].strNumChq;
        frmRcxDocumentosDeletar.stgDocumentos.Cells[4, intContador+1] := arrChqPreOriginais[intContador].strCodEmp;
        frmRcxDocumentosDeletar.stgDocumentos.Cells[5, intContador+1] := DateToStr(arrChqPreOriginais[intContador].dtaDtaCad);
        frmRcxDocumentosDeletar.stgDocumentos.Cells[6, intContador+1] := DateToStr(arrChqPreOriginais[intContador].dtaDtaVen);
        frmRcxDocumentosDeletar.stgDocumentos.Cells[7, intContador+1] := FloatToStrF(arrChqPreOriginais[intContador].fltValChq, ffFixed, 12, 2);

        frmRcxDocumentosDeletar.stgDocumentos.RowHeights[intContador+1] := 20;
      End;

      Result := (frmRcxDocumentosDeletar.ShowModal = mrOk);
      If Not Result Then
        cdsTrcChqAvisPre.EmptyDataSet;

      blnChqPre := Not Result;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fCarregaChqPreOriginais]');
    End;
  End;

  pFreeAndNil(frmRcxDocumentosDeletar);
  FreeAndNil(qryGenChq);

end;

procedure TfrmRcxFormasPagamento.AbreTelaParaPagamentoDoPix;
  Var
    LErro,
    LRetornoPix: String;

    LRecordNumber: Integer;

    LDadosRequisicaoPixAVista: TDadosRequisicaoPixAVista;
begin
  Try
    LDadosRequisicaoPixAVista := TFuncoesPixAutcom.RetornaDadosRequisicaoCaixa(cdsData,
                                                                               fStrToFloat(edtOrdRec.Text),
                                                                               strCodCli,
                                                                               TPixDao.ChavePixUtilizaShipay(FAutoIncremChavePix) = 'S');

    LDadosRequisicaoPixAVista.TextoItemShipay := LDadosRequisicaoPixAVista.SolicitacaoPagador;
    LDadosRequisicaoPixAVista.UtilizaShipay := TPixDao.ChavePixUtilizaShipay(FAutoIncremChavePix);
    LDadosRequisicaoPixAVista.UtilizaTefScope := TPixDao.ChavePixUtilizaTefScope(FAutoIncremChavePix);
    LDadosRequisicaoPixAVista.TipoCobranca := 'instantanea';

    FDadosPixRequisicao := TFuncoesPix.RetornaJsonDadosRequisicao(LDadosRequisicaoPixAVista);

    LRecordNumber := cdsData.RecNo;
    cdsData.Filter := 'RCX_SEQCON=' + cdsData.FieldByName('RCX_SEQCON').AsString;
    cdsData.Filtered := True;
    LRetornoPix := TFuncoesPixAutcom.PagarPixViaQRCodeGerandoNovoPix(FAutoIncremChavePix,
                                                                     FDadosPixRequisicao,
                                                                     FDadosPixRecebimento,
                                                                     strCodCli,
                                                                     False,
                                                                     TFuncoesPixAutcom.RetornaChaveDaDuplicata(cdsData, Self.Caption),
                                                                     fltValDoc);

    cdsData.Filter := '';
    cdsData.Filtered := False;
    cdsData.RecNo := LRecordNumber;

    LErro := TFuncoesPix.RetornaMensagemErroRequisicao(LRetornoPix);
    If Not LErro.IsEmpty Then
      Raise ExceptionAutcom.Create(LErro);

    FDadosPixRecebimento := LRetornoPix;

    FObjetoPixRecebimento := TFuncoesPix.RetornaDadosDoRetornoPixConsulta(LRetornoPix,
                                                                          FDadosPixRequisicao);

    If TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(FObjetoPixRecebimento) Then
    Begin
      edtOrdRec.Text := FormatFloat(',0.00', FObjetoPixRecebimento.ValorPago);
      edtOrdRec.Enabled := False;
      btnReceberPix.Enabled := False;
      chkPixAvulso.Enabled := False;
      chkPixAvulso.Checked := False;

      FObjetoPixRecebimento.SeqConRecebimento := cdsData.FieldByName('RCX_SEQCON').AsInteger;
      FObjetoPixRecebimento.JsonRetorno := FDadosPixRecebimento;
      FObjetoPixRecebimento.JSonRequisicao := FDadosPixRequisicao;
      FObjetoPixRecebimento.AutoIncremChavePix := FAutoIncremChavePix;
      FObjetoPixRecebimento.PlanoDeContas := fCfgSis('CTAPIX');
      If FObjetoPixRecebimento.PlanoDeContas.IsEmpty Then
        FObjetoPixRecebimento.PlanoDeContas := fCfgSis('CTATRA');

      FObjetoPixRecebimento.CodigoDoCaixa := strCodigoCaixa;

      If FObjetoPixRecebimento.SolicitacaoPagador.IsEmpty Then
      Begin
        FObjetoPixRecebimento.SolicitacaoPagador := LDadosRequisicaoPixAVista.SolicitacaoPagador;
        FObjetoPixRecebimento.NomeDevedor := LDadosRequisicaoPixAVista.NomeDevedor;
        FObjetoPixRecebimento.CPFCNPJDevedor := LDadosRequisicaoPixAVista.CPFCNPJDevedor;
      End;
    End
    Else
      fMensagem('ATENÇÃO', 'O recebimento do Pix por QRCode não foi realizado. ' + #13 + 'Assim o registro do Pix não foi gerado.', ['&Ok']);
  Except
    On E: ExceptionAutcom Do
      Raise ExceptionAutcom.Create(E.Message);
  End;
end;

procedure TfrmRcxFormasPagamento.AdicionarDadosLancamentos(
  var ALiberacao: TLiberacao);
  Var
    LDataset: TUniClientDataset;

    LTabela: TRegistroMsgLiberaTabela;

    LLinha: TLinhaMsgLibera;

    LTotalLancamentos: Double;
begin
  ALiberacao.objMsgLibera.pAddTexto('');

  ALiberacao.objMsgLibera.pAddTexto('Valor do Pix: ' + edtOrdRec.Text);
  ALiberacao.objMsgLibera.pAddTexto('');

  LTotalLancamentos := 0;

  LTabela := TRegistroMsgLiberaTabela.Create;
  LLinha  := TLinhaMsgLibera.Create;
  LLinha.enuTipoLinha := tlCabecalho;
  LLinha.pAddColuna(''  , 'LANÇAMENTO', 24 , alEsquerda , teAutcom);
  LLinha.pAddColuna(''  , 'SEQ.BAIXA' , 11 , alCentro   , teAutcom);
  LLinha.pAddColuna(''  , 'DT.CAD.'   , 11 , alCentro   , teAutcom);
  LLinha.pAddColuna(''  , 'CLIENTE'   , 39 , alEsquerda , teAutcom);
  LLinha.pAddColuna(''  , 'VR.LANÇ.'  , 21 , alDireita  , teAutcom);
  LTabela.lstLinhas.Add(LLinha);

  LDataset := fCriaClientDatSet(cdsData);
  LDataset.Filter := 'RCX_SEQCON=' + cdsData.FieldByName('RCX_SEQCON').AsString;
  LDataset.Filtered := True;

  LDataset.First;
  While Not LDataset.Eof Do
  Begin
    LLinha  := TLinhaMsgLibera.Create;
    LLinha.enuTipoLinha := tlValor;
    LLinha.pAddColuna('LANÇAMENTO',  LDataset.FieldByName('RCX_NUMDOC').AsString +
                                     LDataset.FieldByName('RCX_PARCEL').AsString + '-' +
                                     LDataset.FieldByName('RCX_ESPDOC').AsString + '-' +
                                     LDataset.FieldByName('RCX_CODEMP').AsString                                 , 24 , alEsquerda);
    LLinha.pAddColuna('SEQ.BAIXA' ,  LDataset.FieldByName('RCX_SEQCON').AsString                                 , 11 , alCentro  );
    LLinha.pAddColuna('DT.CAD.'   ,  FormatDateTime('dd/MM/yyyy', LDataset.FieldByName('RCX_DTACAD').AsDateTime) , 11 , alCentro  );
    if (POS(LDataset.FieldByName('RCX_CODCLI').AsString, LDataset.FieldByName('CLI_NOMCLI').AsString) <= 0) then
      LLinha.pAddColuna('CLIENTE' ,  LDataset.FieldByName('RCX_CODCLI').AsString + '-' +
                                     LDataset.FieldByName('CLI_NOMCLI').AsString                                 , 39 , alEsquerda)
    else
      LLinha.pAddColuna('CLIENTE' ,  LDataset.FieldByName('CLI_NOMCLI').AsString                                 , 39 , alEsquerda);

    LLinha.pAddColuna('VR.LANÇ.'  ,  FormatFloat('#,##0.00', LDataset.FieldByName('RCX_VALGRD').AsFloat)         , 21 , alDireita );
    LTabela.lstLinhas.Add(LLinha);

    LTotalLancamentos := LTotalLancamentos + fFormataFloat(LDataset.FieldByName('RCX_VALGRD').AsFloat, 2);

    LDataset.Next;
  End;

  LLinha  := TLinhaMsgLibera.Create;
  LLinha.enuTipoLinha := tlTotal;
  LLinha.pAddColuna(''          , 'TOTAIS'                                  , 91, alDireita, teAutcom);
  LLinha.pAddColuna('Descrição' , FormatFloat('#,##0.00', LTotalLancamentos), 21, alDireita, teAmbos);
  LTabela.lstLinhas.Add(LLinha);

  ALiberacao.objMsgLibera.lstRegistros.Add(LTabela);
end;

procedure TfrmRcxFormasPagamento.AtualizaDataMovimentacaoBancaria;
  Var
    LUpdate: TUniQuery;
begin

  If FObjetoPixRecebimento.DataGravacaoMovBan = 0 Then
    Exit;

  Try
    LUpdate := fCriaQuery(Nil);

    Try
      LUpdate.Close;
      LUpdate.SQL.Text := ' UPDATE CADREC '+
                          '    SET CTR_DTABAN = :DTABAN '+
                          ' WHERE CTR_SEQCON = :SEQCON  '+
                          '   AND CTR_EMPBAI = :EMPBAI  '+
                          '   AND CTR_DTAREC = :DTAREC  ';

      LUpdate.ParamByName('DTABAN').AsDateTime := FObjetoPixRecebimento.DataGravacaoMovBan;

      LUpdate.ParamByName('SEQCON').AsInteger  := cdsData.FieldByName('RCX_SEQCON').AsInteger;
      LUpdate.ParamByName('EMPBAI').AsString   := cdsData.FieldByName('RCX_CODEMP').AsString;
      LUpdate.ParamByName('DTAREC').AsDateTime := cdsData.FieldByName('RCX_DTACAD').AsDateTime;
      LUpdate.ExecSQL;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LUpdate);
  End;

end;

procedure TfrmRcxFormasPagamento.AtualizaRecPixLancamentosCadRec(AValor: String;
  ASeqCon: Integer; ACodigoEmpresa: String; ADataLancamento: TDateTime; APortadorCadRec: String = '');
  Var
    LAtualiza: TUniQuery;
begin
  LAtualiza := fCriaQuery;
  Try
    LAtualiza.SQL.Text := 'UPDATE CADREC SET CTR_RECPIX=:RECPIX ';

    If Not APortadorCadRec.IsEmpty Then
    Begin
      LAtualiza.SQL.Add(', CTR_PORBAI=:PORBAI ');
      LAtualiza.ParamByName('PORBAI').AsString := APortadorCadRec;
    End;

    LAtualiza.SQL.Add('WHERE CTR_DTAREC=:DTAREC AND ' +
                      '      CTR_EMPBAI=:CODEMP AND ' +
                      '      CTR_SEQCON=:SEQCON AND ' +
                      '      CTR_RESCAI=1           ');

    LAtualiza.ParamByName('RECPIX').AsString := AValor;

    LAtualiza.ParamByName('DTAREC').AsDateTime := ADataLancamento;
    LAtualiza.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LAtualiza.ParamByName('SEQCON').AsInteger := ASeqCon;

    LAtualiza.ExecSQL;
  Finally
    LAtualiza.Close;
    FreeAndNil(LAtualiza);
  End;
end;

procedure TfrmRcxFormasPagamento.AtualizaRecPixLancamentosCaixa(AValor: String;
  ASeqCon: Integer; ACodigoEmpresa: String; ADataLancamento: TDateTime);
  Var
    LAtualiza: TUniQuery;
begin
  Try
    LAtualiza := fCriaQuery;

    LAtualiza.SQL.Text := 'UPDATE CADRCXX SET RCX_RECPIX=:RECPIX ' +
                          'WHERE RCX_DTACAD=:DTACAD AND ' +
                          '      RCX_CODEMP=:CODEMP AND ' +
                          '      RCX_SEQCON=:SEQCON     ';

    LAtualiza.ParamByName('RECPIX').AsString := AValor;

    LAtualiza.ParamByName('DTACAD').AsDateTime := ADataLancamento;
    LAtualiza.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LAtualiza.ParamByName('SEQCON').AsInteger := ASeqCon;

    LAtualiza.ExecSQL;
  Finally
    FreeAndNil(LAtualiza);
  End;
end;

procedure TfrmRcxFormasPagamento.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  pSetFocus(btnConfirmaDados);//Necessario para executar o evento onexit do campo focado quando pressiona tela de atalho

  pAtualizaValDig;

  if not fAlterouPagamento then
  Begin
    fMensagem('','Não foi alterado nenhuma informação referente ao pagamento!',['&OK']);
    pSetFocus(edtDinheiro);
    Exit;
  End;

  {*************************************}
  {* VERIFICA SE FOI DIGITADO APENAS O *}
  {* FATURADO                          *}
  {**********************************AF*}
  If (edtDinheiro.Text =  '0,00') And
     (edtChqVista.Text =  '0,00') And
     (edtChqPre.Text   =  '0,00') And
     (edtCartao.Text   =  '0,00') And
     (edtValFin.Text   =  '0,00') And
     (edtOrdRec.Text   =  '0,00') Then
  Begin
    fMensagem('','É necessário digitar algum valor!',['&OK']);
    pSetFocus(edtDinheiro);
    Exit;
  End;

  If fltOrdRecAtu <> fltOrdRec Then
  Begin
    If fltOrdRec <> 0.00 Then
    Begin
      If TFuncoesPixAutcom.DeveReceberOrdemDePagamentoComQRCodePix(fStrToFloat(edtOrdRec.Text),
                                                                   FObjetoPixRecebimento) Then
      Begin
        fMensagem('ATENÇÃO', 'Recebimento do QRCode Pix é obrigatório na utilização da modalidade Ordem de Pagamento.', ['&Ok']);
        Exit;
      End;
    End;
  End;

  {****************************************}
  {* VERIFICA CHEQUES A VISTA CADASTRADOS *}
  {*************************************AF*}
  If (edtChqVista.Text <> '0,00') And (Length(arrChqVisOriginais) > 0) Then
  Begin

    If Assigned(cdsChqVis) Then
    Begin
      If (fStrToFloat(edtChqVista.Text) <> fRetornaTotalChqDigitados(cdsChqVis)) Then
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
  If (edtChqPre.Text <> '0,00') And (Length(arrChqPreOriginais) > 0) Then
  Begin

    If Assigned(cdsChqPre) Then
    Begin
      If (fStrToFloat(edtChqPre.Text) <> fRetornaTotalChqDigitados(cdsChqPre)) Then
      Begin
        fMensagem('','O valor dos cheques a prazo cadastrados difere do valor digitado!!!',['&OK']);
        pSetFocus(edtChqPre);
        Exit;
      End;
    End;

  End;

  If (Length(arrCartoes) > 0) Then
  Begin

    If (fFormataFloat(fltCartao, 2) <> fFormataFloat(fStrToFloat(edtCartao.Text), 2)) Then
    Begin
      fMensagem('','O valor dos cartões cadastrados difere do valor digitado!!!',['&OK']);
      pSetFocus(edtCartao);
      Exit;
    End;

  End;

  if Not objResumoDeCaixa.fVerificaSaldoMaximo(fStrToFloat(edtDinheiro.Text), strCodOpe, strCodigoCaixa) Then
  Begin
    pSetFocus(edtDinheiro);
    Exit;
  End;

  If (fFormataFloat(fltValDig,2) <> fFormataFloat(fltValDoc,2)) Then
  Begin
    fMensagem('','Valor total não bate com o valor digitado!',['&OK']);
    pSetFocus(edtDinheiro);
  End
  Else
  Begin
    If Not ValidaSaldoDoCaixaParaDinheiroEOrdemDePagamento Then
      Exit;

    If (fMensagem('', 'Confirma alteração de forma de pagamento?', ['&Sim', '&Não']) = 2) Then
    Begin
      Exit;
    End;

    If (not fTemPermissaoAlterarFormaPagtoResumoCaixa()) then
      Exit;

    If objResumoDeCaixa.CaixaJaFoiFechado(FDataDoCaixa) Then
      Exit;

    If Not fVerificaCampos Then
      Exit;

    If fAlteraFormaPagamento Then
    Begin
      FObjetoPixRecebimento := Nil;
      fMensagem('', 'Alteração concluída com sucesso!', ['&Ok']);
      Close;

      {**********************************}
      {* VERIFICA SE OS VALORES FORAM   *}
      {* REALMENTE ALTERADOS            *}
      {*******************************AJ*}
      If (FloatToStrF(fltDinRecAtu, ffFixed, 12, 2) = edtDinheiro.Text) And
         (FloatToStrF(fltChqAviAtu, ffFixed, 12, 2) = edtChqVista.Text) And
         (FloatToStrF(fltChqPreAtu, ffFixed, 12, 2) = edtChqPre.Text)   And
         (FloatToStrF(fltCarRecAtu, ffFixed, 12, 2) = edtCartao.Text)   And
         (FloatToStrF(fltValFinAtu, ffFixed, 12, 2) = edtValFin.Text)   Then
        Exit;

      ModalResult := mrOk;
    End;

  End;

end;

procedure TfrmRcxFormasPagamento.btnReceberPixClick(Sender: TObject);
begin
  inherited;
  If fMensagem('ATENÇÃO', 'Deseja realizar o recebimento do valor ' + FormatFloat(',0.00', fStrToFloat(edtOrdRec.Text)) +
                          ' através do QRCode Pix?', ['&Sim', '&Não'], 1) = 2 Then
  Begin
    pSetFocus(edtOrdRec);
    SelectNext(ActiveControl, True, True);
    Exit;
  End;

  If FDataDoCaixa <> VS_Date Then
  Begin
    fMensagem('ATENÇÃO', 'Não é possível receber por Pix com o caixa do dia anterior em aberto.', ['&Ok']);
    pSetFocus(edtOrdRec);
    Exit;
  End;

  If (fFormataFloat(fltValDig,2) > fFormataFloat(fltValDoc,2)) Then
  Begin
    fMensagem('ATENÇÃO','O valor do documento não pode ser menor que o valor digitado!',['&OK']);
    pSetFocus(edtOrdRec);
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

  If edtValFin.Visible Then
    pSetFocus(edtValFin)
  Else
    pSetFocus(btnConfirmaDados);
end;

Procedure TfrmRcxFormasPagamento.pGravaTrocaFormas(strAutInc,
                                                   strCodOpe: String);
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin

  strSQL := '';
  strSQL := strSQL + 'REPLACE INTO TRORCX    ';
  strSQL := strSQL + '  (TRO_SEQGER,         ';
  strSQL := strSQL + '   TRO_DINREC,         ';
  strSQL := strSQL + '   TRO_CHQAVI,         ';
  strSQL := strSQL + '   TRO_CHQPRE,         ';
  strSQL := strSQL + '   TRO_CARREC,         ';
  strSQL := strSQL + '   TRO_CODFPG,         ';
  strSQL := strSQL + '   TRO_CODOPE,         ';
  strSQL := strSQL + '   TRO_VALFIN,         ';
  strSQL := strSQL + '   TRO_ORDREC,         ';
  strSQL := strSQL + '   TRO_RECPIX)         ';
  strSQL := strSQL + 'SELECT                 ';
  strSQL := strSQL + '  AUTOINCREM,          ';
  strSQL := strSQL + '  RCX_DINREC,          ';
  strSQL := strSQL + '  RCX_CHQAVI,          ';
  strSQL := strSQL + '  RCX_CHQPRE,          ';
  strSQL := strSQL + '  RCX_CARREC,          ';
  strSQL := strSQL + '  RCX_CODFPG,          ';
  strSQL := strSQL + '  :CODOPE,             ';
  strSQL := strSQL + '  RCX_VALFIN,          ';
  strSQL := strSQL + '  RCX_ORDREC,          ';
  strSQL := strSQL + '  RCX_RECPIX           ';
  strSQL := strSQL + 'FROM                   ';
  strSQL := strSQL + '  CADRCXX              ';
  strSQL := strSQL + 'WHERE                  ';
  strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

  qryGen := fCriaQuery;

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODOPE').AsString  := strCodOpe;
    ParamByName('AUTINC').AsString  := strAutInc;
    ExecSQL;
    Close;
  End;

  FreeAndNil(qryGen);
End;

procedure TfrmRcxFormasPagamento.pLogChq(qryLog: TDataset; strDescri: String);
  Var
    repCadChq: TCadChqRepository;
begin

  Try
    repCadChq := TCadChqRepository.Create;
    With qryLog Do
    Begin
      repCadChq.pGravaLog(FieldByName('CHQ_CODBCO').AsString, FieldByName('CHQ_NUMAGE').AsString,
                          FieldByName('CHQ_CONCOR').AsString, FieldByName('CHQ_NUMCHQ').AsString,
                          strDescri);
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  FreeAndNil(repCadChq);

end;

function TfrmRcxFormasPagamento.fGetDiversos(intSeqCon: Integer; strCodEmp: String): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT DISTINCT RCX_NUMDOC, RCX_ESPDOC, RCX_CODEMP, RCX_PARCEL FROM CADRCXX');
    SQL.Add('WHERE RCX_SEQCON = :SEQCON AND RCX_CODEMP = :CODEMP');

    If strCodigoCaixa.IsEmpty Then
      SQL.Add('  AND RCX_DTACAD > :DTAREF')
    Else
    Begin
      SQL.Add('  AND RCX_DTACAD >= :DTAREF');
      SQL.Add('  AND RCX_LANFEC="N" ');
    End;

    ParamByName('CODEMP').AsString  := strCodEmp;
    ParamByName('SEQCON').AsInteger := intSeqCon;
    ParamByName('DTAREF').AsDateTime := dtaDataReferencia;

    Open;

    Result := RecordCount > 1;

    Close;
  End;

  FreeAndNil(qryGen);
End;

function TfrmRcxFormasPagamento.fAlteraFormaPagamento: Boolean;
  Var
    intContador : Integer;
    intContador2: Integer;
    intContCopia: Integer;

    strSQL   : String;
    strArqGer: String;
    strArqDet: String;

    strNotGer: String;
    strNotDet: String;

    strCodCar: String;
    strDesCar: String;
    fltValTot: Double;
    strConPag: String;
    strNumCcd: String;
    strNumNsu: String;
    strHisTor: String;
    fltPerCar: Double;
    fltValDes: Double;
    strTipCar: String;
    qryGenChq: TUniQuery;
    qryAuxChq: TUniQuery;
    strHisCar: String;

    dtaDtaTra,
    LDataBaseCartao: TDatetime;

    strNovoFpg: String;

    arrDuplicata,
    arrDuplOri  : TArrDigDuplicArray;

    strEmpRcxAvi: String;
    strEmpRcxPre: String;
    strEmpRcxCar: String;

    qryGenRcx: TUniQuery;

    strDifVal: String;
    objArredondaParcela: IArredondaParcela;

    LAlteradoParaPix,
    LPortadorCadRec: String;

    LSeqConTFCancelamento: Integer;

    LGravarNovoRegistroPix: Boolean;
    LTipoParcelamento: String;
begin

  strEmpRcxAvi := '';
  strEmpRcxPre := '';
  strEmpRcxCar := '';

  Screen.Cursor := crHourGlass;

  LAlteradoParaPix := IIF(chkPixAvulso.Checked, 'S', 'N');

  LGravarNovoRegistroPix := False;
  If Assigned(FObjetoPixRecebimento) Then
  Begin
    If TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(FObjetoPixRecebimento) Then
    Begin
      LGravarNovoRegistroPix := True;

      LAlteradoParaPix := 'S';
    End;
  End;

  {*************************************************}
  {* DEVE SER CHAMADO ANTES DA TRANSACAO PRINCIPAL *}
  {*********************************************JC**}
  fRetSequencialMovCar('MOVCAR', cdsData.FieldByName('RCX_CODEMP').AsString, arrCartoes);

  If LGravarNovoRegistroPix Then
    FObjetoPixRecebimento.SeqConTransferencia := StrToInt(fRetRcxCon);

  LSeqConTFCancelamento := 0;
  If FRecebidoPorPix Then
  Begin
    If cdsData.FieldByName('REGISTRO_PIX').AsInteger > 0 Then
    Begin
      If fStrToFloat(edtOrdRec.Text) = 0 Then
        LSeqConTFCancelamento := StrToInt(fRetRcxCon)
      Else
        LAlteradoParaPix := 'S';
    End;
  End;


  fStartTransaction;

  qryGenChq := fCriaQuery(Self);
  qryAuxChq := fCriaQuery(Nil);

  Try

    strArqGer := 'MOVGER';
    strArqDet := 'MOVDET';

    strNotGer := 'NOTGER';
    strNotDet := 'NOTDET';

    {*******************************************}
    {* APAGA E REGRAVA OS CHEQUES À VISTA      *}
    {****************************************MV*}
        {*******************************************}
        {* NAO APAGA SE NAO EXISTIR - REPLICACAO   *}
        {****************************************LA*}
    If {(fltChqVis <= 0.0) Or }(Length(arrChqVisOriginais) > 0) Then
    Begin
      {***********************}
      {* GRAVA NO DEL_CADCHQ *}
      {********************JU*}
      strSQL := '';
      strSQL := strSQL + 'SELECT * FROM CADCHQ ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CHQ_SEQCON = :SEQCON AND ';
      strSQL := strSQL + '  CHQ_EMPRCX = :CODEMP AND ';

      If strCodigoCaixa.IsEmpty Then
        strSQL := strSQL + '  CHQ_DTACAD > :DTAREF AND '
      Else
        strSQL := strSQL + '  CHQ_DTACAD >= :DTAREF AND ';

      strSQL := strSQL + '  RIGHT(CHQ_DOCUME, 3) = "AVI" AND ';
      strSQL := strSQL + '  CHQ_RESCAI = 1       AND ';
      strSQL := strSQL + '  CHQ_DTATRA IS NULL       ';

      qryAuxChq.Close;
      qryAuxChq.SQL.Clear;
      qryAuxChq.SQL.Add(strSQL);
      qryAuxChq.ParamByName('SEQCON').AsInteger := cdsData.FieldByName('RCX_SEQCON').AsInteger;
      qryAuxChq.ParamByName('CODEMP').AsString  := cdsData.FieldByName('RCX_CODEMP').AsString;
      qryAuxChq.ParamByName('DTAREF').AsDateTime := dtaDataReferencia;
      qryAuxChq.Open;

      If (Not qryAuxChq.IsEmpty) Then
      Begin
        qryAuxChq.First;

        While (Not qryAuxChq.Eof) Do
        Begin
          pLogChq(qryAuxChq, 'APAGANDO CHQ. VIS. (frmRcxFormasPagamento.fLogChq)');
          qryAuxChq.Next;
        End;
      End;

      strSQL := '';
      strSQL := strSQL +  ' SELECT SQL_NO_CACHE * FROM CADCHQ ';
      strSQL := strSQL +  ' WHERE                      ';
      strSQL := strSQL +  '  CHQ_SEQCON = :SEQCON AND ';
      strSQL := strSQL +  '  CHQ_EMPRCX = :CODEMP AND ';

      If strCodigoCaixa.IsEmpty Then
        strSQL := strSQL + '  CHQ_DTACAD > :DTAREF AND '
      Else
        strSQL := strSQL + '  CHQ_DTACAD >= :DTAREF AND ';

      strSQL := strSQL +  '  RIGHT(CHQ_DOCUME, 3) = "AVI" AND ';
      strSQL := strSQL +  '  CHQ_RESCAI = 1       AND ';
      strSQL := strSQL +  '  CHQ_DTATRA IS NULL       ';

      With qryGenChq, SQL Do
      Begin
        Close;
        Clear;
        Add(strSQL);
        ParamByName('SEQCON').AsInteger := cdsData.FieldByName('RCX_SEQCON').AsInteger;
        ParamByName('CODEMP').AsString  := cdsData.FieldByName('RCX_CODEMP').AsString;
        ParamByName('DTAREF').AsDateTime := dtaDataReferencia;
        Open;
      End;

      While Not qryGenChq.Eof Do
      Begin
        fVerificaIntegridade(Self.Name, 'CADCHQ', qryGenChq);
        qryGenChq.Next;
      End;

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CADCHQ ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CHQ_SEQCON = :SEQCON AND ';
      strSQL := strSQL + '  CHQ_EMPRCX = :CODEMP AND ';

      If strCodigoCaixa.IsEmpty Then
        strSQL := strSQL + '  CHQ_DTACAD > :DTAREF AND '
      Else
        strSQL := strSQL + '  CHQ_DTACAD >= :DTAREF AND ';

      strSQL := strSQL + '  RIGHT(CHQ_DOCUME, 3) = "AVI" AND ';
      strSQL := strSQL + '  CHQ_RESCAI = 1       AND ';
      strSQL := strSQL + '  CHQ_DTATRA IS NULL       ';

      With qryGenChq Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('SEQCON').AsInteger := cdsData.FieldByName('RCX_SEQCON').AsInteger;
        ParamByName('CODEMP').AsString  := cdsData.FieldByName('RCX_CODEMP').AsString;
        ParamByName('DTAREF').AsDateTime := dtaDataReferencia;
        ExecSQL;
        Close;
      End;
    End;

    {*******************************************}
    {* APAGA E REGRAVA OS CHEQUES PRÉ          *}
    {****************************************MV*}
        {*******************************************}
        {* NAO APAGA SE NAO EXISTIR - REPLICACAO   *}
        {****************************************LA*}
    If ({(fltChqPre <= 0.0) Or} (Length(arrChqPreOriginais) > 0)) Then
    Begin
      {***********************}
      {* GRAVA NO DEL_CADCHQ *}
      {********************JU*}
      strSQL := '';
      strSQL := strSQL + 'SELECT * FROM CADCHQ ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CHQ_SEQCON = :SEQCON AND ';
      strSQL := strSQL + '  CHQ_EMPRCX = :CODEMP AND ';

      If strCodigoCaixa.IsEmpty Then
        strSQL := strSQL + '  CHQ_DTACAD > :DTAREF AND '
      Else
        strSQL := strSQL + '  CHQ_DTACAD >= :DTAREF AND ';

      strSQL := strSQL + '  RIGHT(CHQ_DOCUME, 3) = "PRZ" AND ';
      strSQL := strSQL + '  CHQ_RESCAI = 1       AND ';
      strSQL := strSQL + '  CHQ_DTATRA IS NULL       ';

      qryAuxChq.Close;
      qryAuxChq.SQL.Clear;
      qryAuxChq.SQL.Add(strSQL);
      qryAuxChq.ParamByName('SEQCON').AsInteger := cdsData.FieldByName('RCX_SEQCON').AsInteger;
      qryAuxChq.ParamByName('CODEMP').AsString  := cdsData.FieldByName('RCX_CODEMP').AsString;
      qryAuxChq.ParamByName('DTAREF').AsDateTime := dtaDataReferencia;
      qryAuxChq.Open;

      If (Not qryAuxChq.IsEmpty) Then
      Begin
        qryAuxChq.First;

        While (Not qryAuxChq.Eof) Do
        Begin
          pLogChq(qryAuxChq, 'APAGANDO CHQ. PRE. (frmRcxFormasPagamento.fLogChq)');
          qryAuxChq.Next;
        End;
      End;

      strSQL := '';
      strSQL := strSQL +  ' SELECT SQL_NO_CACHE * FROM CADCHQ ';
      strSQL := strSQL +  ' WHERE                      ';
      strSQL := strSQL +  '  CHQ_SEQCON = :SEQCON AND ';
      strSQL := strSQL +  '  CHQ_EMPRCX = :CODEMP AND ';

      If strCodigoCaixa.IsEmpty Then
        strSQL := strSQL + '  CHQ_DTACAD > :DTAREF AND '
      Else
        strSQL := strSQL + '  CHQ_DTACAD >= :DTAREF AND ';

      strSQL := strSQL +  '  RIGHT(CHQ_DOCUME, 3) = "PRZ" AND ';
      strSQL := strSQL +  '  CHQ_RESCAI = 1       AND ';
      strSQL := strSQL +  '  CHQ_DTATRA IS NULL       ';

      With qryGenChq, SQL Do
      Begin
        Close;
        Clear;
        Add(strSQL);
        ParamByName('SEQCON').AsInteger := cdsData.FieldByName('RCX_SEQCON').AsInteger;
        ParamByName('CODEMP').AsString  := cdsData.FieldByName('RCX_CODEMP').AsString;
        ParamByName('DTAREF').AsDateTime := dtaDataReferencia;
        Open;
      End;

      While Not qryGenChq.Eof Do
      Begin
        fVerificaIntegridade(Self.Name, 'CADCHQ', qryGenChq);
        qryGenChq.Next;
      End;

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CADCHQ ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CHQ_SEQCON = :SEQCON AND ';
      strSQL := strSQL + '  CHQ_EMPRCX = :CODEMP AND ';

      If strCodigoCaixa.IsEmpty Then
        strSQL := strSQL + '  CHQ_DTACAD > :DTAREF AND '
      Else
        strSQL := strSQL + '  CHQ_DTACAD >= :DTAREF AND ';

      strSQL := strSQL + '  RIGHT(CHQ_DOCUME, 3) = "PRZ" AND ';
      strSQL := strSQL + '  CHQ_RESCAI = 1       AND ';
      strSQL := strSQL + '  CHQ_DTATRA IS NULL       ';

      With qryGenChq Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('SEQCON').AsInteger := cdsData.FieldByName('RCX_SEQCON').AsInteger;
        ParamByName('CODEMP').AsString  := cdsData.FieldByName('RCX_CODEMP').AsString;
        ParamByName('DTAREF').AsDateTime := dtaDataReferencia;
        ExecSQL;
        Close;
      End;
    End;

    If ((Length(arrChqVisOriginais) > 0) Or (Not blnChqVisCad)) And Assigned(cdsChqVis) And (cdsChqVis.Active) Then
    If Not cdsChqVis.IsEmpty Then
    Begin

      If (Length(arrChqVisOriginais) > 0) Then
      Begin
        strEmpRcxAvi := arrChqVisOriginais[0].strEmpRcx;
      End;

      With cdsChqVis Do
      Begin

        First;

        While (Not Eof) Do
        Begin

          fGravaCheque(FieldByName('CHQ_CODBCO').AsString,
                       FieldByName('CHQ_NUMAGE').AsString,
                       FieldByName('CHQ_CONCOR').AsString,
                       FieldByName('CHQ_NUMCHQ').AsString,
                       FieldByName('CHQ_CODCLI').AsString,
                       FieldByName('CHQ_NOMEMI').AsString,
                       FieldByName('CHQ_ENDERE').AsString,
                       FieldByName('CHQ_TELEMI').AsString,
                       FieldByName('CHQ_CGCCPF').AsString,
                       FieldByName('CHQ_C_G_C_').AsString,
                       FieldByName('CHQ_HIST01').AsString,
                       FieldByName('CHQ_HIST02').AsString,
                       FieldByName('CHQ_CTADEP').AsString,
                       FieldByName('CHQ_DOCDEP').AsString,
                       FieldByName('CHQ_CODPOR').AsString,
                       FieldByName('CHQ_CODCTA').AsString,
                       FieldByName('CHQ_MOTDEV').AsString,
                       FieldByName('CHQ_FORREP').AsString,
                       FieldByName('CHQ_OBSREP').AsString,
                       FieldByName('CHQ_CODEMP').AsString,
                       FieldByName('CHQ_NUMNOT').AsString,
                       FieldByName('CHQ_PORCUS').AsString,

                       IIF(blnDiversos, 'DIVERSOS-', strNumDoc + strParcel + strEspDoc + strCodEmp) + 'AVI',

                       'N',
                       FieldByName('CHQ_DTACAD').AsDateTime,
                       FieldByName('CHQ_DTAVEN').AsDateTime,
                       FieldByName('CHQ_DTADEP').AsDateTime,
                       FieldByName('CHQ_DTADEV').AsDateTime,
                       FieldByName('CHQ_DTARDP').AsDateTime,
                       FieldByName('CHQ_DTAREP').AsDateTime,
                       FieldByName('CHQ_DTACUS').AsDateTime,
                       FieldByName('CHQ_VALCHQ').AsFloat,
                       '',
                       cdsData.FieldByName('RCX_SEQCON').AsInteger,
                       cdsData.FieldByName('RCX_CODEMP').AsString,
                       1,
                       FieldByName('CHQ_TELCHE').AsString,
                       FieldByName('CHQ_TELNUM').AsString,
                       FieldByName('CHQ_CODOPE').AsString,
                       FieldByName('CHQ_CODCMC').AsString,
                       0,0,0,0,
                       FieldByName('CHQ_PORCHQ').AsString,
                       self.Name,
                       FieldByName('CHQ_NAODEP').AsString,
                       FieldByName('CHQ_CODCID').AsString,
                       strCodigoCaixa);

          pLogChq(cdsChqVis, 'INSERINDO (frmRcxFormasPagamento.fAlteraFormaPagamento)');

          Next;
        End;

      End;

    End;

    If ((Length(arrChqPreOriginais) > 0) Or (Not blnChqPreCad)) And  Assigned(cdsChqPre) And (cdsChqPre.Active)  Then
    If Not cdsChqPre.IsEmpty Then
    Begin

      If (Length(arrChqPreOriginais) > 0) Then
      Begin
        strEmpRcxPre := arrChqPreOriginais[0].strEmpRcx;
      End;

      With cdsChqPre Do
      Begin

        First;
        While (Not Eof) Do
        Begin

          Result := fGravaCheque(FieldByName('CHQ_CODBCO').AsString,
                                 FieldByName('CHQ_NUMAGE').AsString,
                                 FieldByName('CHQ_CONCOR').AsString,
                                 FieldByName('CHQ_NUMCHQ').AsString,
                                 FieldByName('CHQ_CODCLI').AsString,
                                 FieldByName('CHQ_NOMEMI').AsString,
                                 FieldByName('CHQ_ENDERE').AsString,
                                 FieldByName('CHQ_TELEMI').AsString,
                                 FieldByName('CHQ_CGCCPF').AsString,
                                 FieldByName('CHQ_C_G_C_').AsString,
                                 FieldByName('CHQ_HIST01').AsString,
                                 FieldByName('CHQ_HIST02').AsString,
                                 FieldByName('CHQ_CTADEP').AsString,
                                 FieldByName('CHQ_DOCDEP').AsString,
                                 FieldByName('CHQ_CODPOR').AsString,
                                 FieldByName('CHQ_CODCTA').AsString,
                                 FieldByName('CHQ_MOTDEV').AsString,
                                 FieldByName('CHQ_FORREP').AsString,
                                 FieldByName('CHQ_OBSREP').AsString,
                                 FieldByName('CHQ_CODEMP').AsString,
                                 FieldByName('CHQ_NUMNOT').AsString,
                                 FieldByName('CHQ_PORCUS').AsString,

                                 IIF(blnDiversos, 'DIVERSOS-', strNumDoc + strParcel + strEspDoc + strCodEmp) + 'PRZ',

                                 'N',
                                 FieldByName('CHQ_DTACAD').AsDateTime,
                                 FieldByName('CHQ_DTAVEN').AsDateTime,
                                 FieldByName('CHQ_DTADEP').AsDateTime,
                                 FieldByName('CHQ_DTADEV').AsDateTime,
                                 FieldByName('CHQ_DTARDP').AsDateTime,
                                 FieldByName('CHQ_DTAREP').AsDateTime,
                                 FieldByName('CHQ_DTACUS').AsDateTime,
                                 FieldByName('CHQ_VALCHQ').AsFloat,
                                 '',
                                 cdsData.FieldByName('RCX_SEQCON').AsInteger,
                                 cdsData.FieldByName('RCX_CODEMP').AsString,
                                 1,
                                 FieldByName('CHQ_TELCHE').AsString,
                                 FieldByName('CHQ_TELNUM').AsString,
                                 FieldByName('CHQ_CODOPE').AsString,
                                 FieldByName('CHQ_CODCMC').AsString,
                                 0,0,0,0,
                                 FieldByName('CHQ_PORCHQ').AsString,
                                 Self.Name,
                                 FieldByName('CHQ_NAODEP').AsString,
                                 FieldByName('CHQ_CODCID').AsString,
                                 strCodigoCaixa);

          If (Not Result) Then
          Begin
            fRollBack;
            Exit;
          End;

          pLogChq(cdsChqPre, 'INSERINDO (frmRcxFormasPagamento.fAlteraFormaPagamento)');

          Next;
        End;

      End;

    End;

    {*******************************************}
    {* APAGA E REGRAVA OS CARTÕES              *}
    {****************************************MV*}
        {*******************************************}
        {* NAO APAGA SE NAO EXISTIR - REPLICACAO   *}
        {****************************************LA*}
    If {(fltCartao <= 0.0) Or} (Length(arrCartoesOriginais) > 0) Then
    Begin

      For intContCopia := 0 To High(arrCartoesOriginais) Do
        pApagaCartao(arrCartoesOriginais[intContCopia].strAutInc, Self.Name);
    End;

    If (Length(arrCartoesOriginais) > 0) Or (Not blnCartaoCad) Then
    Begin

      If Length(arrCartoesOriginais) > 0 Then
      Begin
        strEmpRcxCar := arrCartoesOriginais[0].strEmpRcx;
      End;

      strHisCar := fRetHisCar(cdsData.FieldByName('RCX_SEQCON').AsInteger, cdsData.FieldByName('RCX_CODEMP').AsString);

      For intContador := 0 To Length(arrCartoes) -1 Do
      Begin

        strCodCar := arrCartoes[intContador].strCodCar;
        strDesCar := arrCartoes[intContador].strDesCar;
        fltValTot := arrCartoes[intContador].fltValDig;
        strConPag := arrCartoes[intContador].strCndPag;
        strNumCcd := arrCartoes[intContador].strNumCcd;
        strNumNsu := arrCartoes[intContador].strNumNsu;
        strHisTor := arrCartoes[intContador].strObsCar;
        fltPerCar := arrCartoes[intContador].fltPerDes;
        fltValDes := arrCartoes[intContador].fltValDes;
        strTipCar := arrCartoes[intContador].strTipCar;
        dtaDtaTra := arrCartoes[intContador].dtaDtaTra;

        LDataBaseCartao := RetornaDataBaseCartao(VS_Date, dtaDtaTra);

        LTipoParcelamento := '';

        {$IFNDEF LINUX}
          LTipoParcelamento := fCampoTabela('CAR_ARRPAR', 'CADCAR', ['CAR_CODCAR'], [strCodCar]);

          If (strTipCar = 'POS') And (LTipoParcelamento <> 'N') Then
            objArredondaParcela := TArredondaParCartaoPos.fArredondamentoParcelas(strCodCar)
          Else
            objArredondaParcela := fArredondamentoParcelas(strCodCar);
        {$ELSE}
          objArredondaParcela := fArredondamentoParcelas(strCodCar);
        {$ENDIF LINUX}

        fDigDuplicVar(strConPag, 0, fltValTot, False, False, False, LDataBaseCartao, False, arrDuplicata, 0, 'N', False, False, 0, objArredondaParcela);
        SetLength(arrDuplOri, Length(arrDuplicata));

        For intContCopia := 0 To Length(arrDuplicata) - 1 Do
          arrDuplOri[intContCopia] := arrDuplicata[intContCopia];

        fDigDuplicVar(strConPag, 0, fltValDes, False, False, False, LDataBaseCartao, False, arrDuplicata, 0, 'N', False, False, 0, objArredondaParcela);

        intContador2 := 0;
        While (intContador2 < Length(arrDuplicata))                   And
              (Not fEmptyStr(arrDuplicata[intContador2].strSequen)) Do
        Begin
          Result := fGravaMovCar(Self.Name,
                                 'INCLUSÃO',
                                 arrCartoes[intContador].strNumDup,
                                 cdsData.FieldByName('RCX_CODCLI').AsString,
                                 arrDuplicata[intContador2].strSequen,
                                 cdsData.FieldByName('RCX_CODEMP').AsString,
                                 strCodCar,
                                 VS_Date,
                                 StrToDate(arrDuplicata[intContador2].dtaDtaVen),
                                 arrDuplicata[intContador2].curValor,
                                 arrDuplicata[intContador2].curValor,
                                 strHisTor,
                                 strHisCar,
                                 strConPag,
                                 0,
                                 0.0,
                                 '',
                                 '',
                                 '',
                                 '',
                                 '',
                                 '',
                                 '',
                                 '',
                                 fltPerCar,
                                 arrDuplOri[intContador2].curValor,
                                 arrDuplOri[intContador2].curValor - arrDuplicata[intContador2].curValor,
                                 strNumCcd,

                                 IIF(blnDiversos, 'DIVERSOS',
                                     strNumDoc +  '-' + arrDuplicata[intContador2].strSequen  + '-' +
                                     strEspDoc + '-' + strCodEmp + '-000'),

                                 '',
                                 cdsData.FieldByName('RCX_SEQCON').AsInteger,
                                 strCodEmp,
                                 strCodOpe,
                                 True,
                                 '',
                                 'B',
                                 '',
                                 strTipCar,
                                 0,
                                 0,
                                 0,
                                 0,
                                 strNumNsu,
                                 '',
                                 dtaDtaTra,
                                 0,
                                 0,
                                 0,
                                 strCodigoCaixa);

          Inc(intContador2);

          If (Not Result) Then
          Begin
            fRollBack;
            Exit;
          End;

        End;

      End;

    End;

    If LGravarNovoRegistroPix Then
    Begin
      TFuncoesPixAutcom.GravarRegistroPixBaixado(FObjetoPixRecebimento,
                                                 True,
                                                 True,
                                                 strCodOpe,
                                                 Self.Name);

      AtualizaDataMovimentacaoBancaria;
    End
    Else If FRecebidoPorPix Then
    Begin
      If fStrToFloat(edtOrdRec.Text) = 0 Then
      Begin
        If cdsData.FieldByName('REGISTRO_PIX').AsInteger > 0 Then
          TFuncoesPixAutcom.ExcluirPixDoCaixa(cdsData.FieldByName('RCX_SEQCON').AsInteger,
                                              cdsData.FieldByName('RCX_CODEMP').AsString,
                                              cdsData.FieldByName('RCX_DTACAD').AsDateTime,
                                              Self.Name,
                                              LSeqConTFCancelamento
                                              );
      End;
    End;

    pGravaTrocaFormas(strAutInc, strCodOpe);

    AtualizaRecPixLancamentosCaixa(LAlteradoParaPix,
                                   cdsData.FieldByName('RCX_SEQCON').AsInteger,
                                   cdsData.FieldByName('RCX_CODEMP').AsString,
                                   cdsData.FieldByName('RCX_DTACAD').AsDateTime
                                   );

    strNovoFpg := '';
    If (fltDinhei > 0) Then
      strNovoFpg := '001';

    If (fltChqVis > 0) Then
    Begin
      If (fEmptyStr(strNovoFpg)) Then
        strNovoFpg := '006'
      Else
        strNovoFpg := '009';
    End;

    If (fltChqPre > 0) Then
    Begin
      If (fEmptyStr(strNovoFpg)) Then
        strNovoFpg := '002'
      Else
        strNovoFpg := '009';
    End;

    If (fltCartao > 0) Then
    Begin
      If (fEmptyStr(strNovoFpg)) Then
        strNovoFpg := '007'
      Else
        strNovoFpg := '009';
    End;

    If (fltValFin > 0) Then
    Begin
      If (fEmptyStr(strNovoFpg)) Then
        strNovoFpg := '016'
      Else
        strNovoFpg := '009';
    End;

    If (fltOrdRec > 0) Then
    Begin
      If (fEmptyStr(strNovoFpg)) Then
        strNovoFpg := '012'
      Else
        strNovoFpg := '009';
    End;

    pAcertaRecebimentoCadRec;

    LPortadorCadRec := objResumoDeCaixa.RetornaPortadorCADRECNoResumoDeCaixa(FAutoIncremChavePix,
                                                                             fCfgSis('PORRCX'),
                                                                             IIF(objResumoDeCaixa.TransferenciaOrdemPagamentoAutomatica, fCfgSis('PORORD'), EmptyStr),
                                                                             fltOrdRec,
                                                                             fltValDig,
                                                                             FRecebidoPorPix Or LGravarNovoRegistroPix,
                                                                             True);

    AtualizaRecPixLancamentosCadRec(LAlteradoParaPix,
                                    cdsData.FieldByName('RCX_SEQCON').AsInteger,
                                    cdsData.FieldByName('RCX_CODEMP').AsString,
                                    cdsData.FieldByName('RCX_DTACAD').AsDateTime,
                                    LPortadorCadRec);

    GravarLogCtrDuplicatas(cdsData.FieldByName('RCX_SEQCON').AsInteger,
                           cdsData.FieldByName('RCX_CODEMP').AsString,
                           cdsData.FieldByName('RCX_DTACAD').AsDateTime);

    Result :=  fAcertaRecebimentoAdtCli(LAlteradoParaPix, LPortadorCadRec);

    If Result Then
    Begin
       AcertaDesmembramentoModalidades(cdsData.FieldByName('RCX_SEQCON').AsInteger,
                                       cdsData.FieldByName('RCX_CODEMP').AsString,
                                       cdsData.FieldByName('RCX_DTACAD').AsDateTime,
                                       fltDinhei,
                                       fltChqVis,
                                       fltChqPre,
                                       fltCartao,
                                       fltOrdRec);
    End;

    if not Result then
    begin //Só executo o Exit pois dei rollback dentro da rotina por ter uma mensagem de erro
      Screen.Cursor := crDefault;
      Exit;
    end;

    {***************************************}
    {* PRIMEIRO DEVE ZERAR TODAS AS MODS.  *}
    {* PARA POSTERIORMENTE GRAVAR A NOVA   *}
    {* MODALIDADE                          *}
    {************************************AF*}
    strSQL := '';
    strSQL := strSQL + 'UPDATE CADRCXX SET ';
    strSQL := strSQL + '  RCX_DINREC = 0, RCX_CHQAVI = 0, RCX_CHQPRE = 0, ';
    strSQL := strSQL + '  RCX_CARREC = 0, RCX_VALFIN = 0, RCX_ORDREC = 0  ';
    strSQL := strSQL + 'WHERE RCX_SEQCON = :SEQCON AND RCX_CODEMP = :CODEMP ';

    If strCodigoCaixa.IsEmpty Then
      strSQL := strSQL + '  AND RCX_DTACAD > :DTAREF '
    Else
    Begin
      strSQL := strSQL + '  AND RCX_DTACAD >= :DTAREF ';
      strSQL := strSQL + '  AND RCX_LANFEC = "N" ';
    End;

    With qryGenChq Do
    Begin
      Close; SQL.Clear; SQL.Add(strSQL);
      ParamByName('SEQCON').AsInteger := cdsData.FieldByName('RCX_SEQCON').AsInteger;
      ParamByName('CODEMP').AsString  := cdsData.FieldByName('RCX_CODEMP').AsString;
      ParamByName('DTAREF').AsDateTime := dtaDataReferencia;
      ExecSQL;
    End;

    {***************************************}
    {* AGORA GRAVA OS NOVOS VALORES        *}
    {************************************AF*}
    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  CADRCXX X ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  RCX_CODFPG = :CODFPG, ';
    strSQL := strSQL + '  RCX_DINREC = :DINREC, ';
    strSQL := strSQL + '  RCX_CHQAVI = :CHQAVI, ';
    strSQL := strSQL + '  RCX_CHQPRE = :CHQPRE, ';
    strSQL := strSQL + '  RCX_CARREC = :CARREC, ';
    strSQL := strSQL + '  RCX_VALFIN = :VALFIN, ';
    strSQL := strSQL + '  RCX_ORDREC = :ORDREC, ';
    strSQL := strSQL + '  RCX_RECPIX = :RECPIX  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  AUTOINCREM = :AUTINC  ';

    With qryGenChq Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODFPG').AsString  := strNovoFpg;
      ParamByName('DINREC').AsFloat   := fltDinhei;
      ParamByName('CHQAVI').AsFloat   := fltChqVis;
      ParamByName('CHQPRE').AsFloat   := fltChqPre;
      ParamByName('CARREC').AsFloat   := fltCartao;
      ParamByName('VALFIN').AsFloat   := fltValFin;
      ParamByName('ORDREC').AsFloat   := fltOrdRec;
      ParamByName('RECPIX').AsString  := LAlteradoParaPix;

      ParamByName('AUTINC').AsString := strAutInc;

      ExecSQL;
      Close;
    End;

    If FRecebimentoDinheiroAnterior <> fStrToFloat(edtDinheiro.Text) Then
      objResumoDeCaixa.CorrigeFundoDeCaixaNaTrocaDeModalidade(strAutInc,
                                                              fStrToFloat(edtDinheiro.Text),
                                                              FRecebimentoDinheiroAnterior,
                                                              strCodigoCaixa,
                                                              VS_strCodEmp);

    {***************************************}
    {* ANÁLISE DA GRAVAÇÃO DO CAIXA        *}
    {************************************AF*}
    If Result Then
    Begin
      Result := fGravouCaixaCorreto(strDifVal, cdsData.FieldByName('RCX_SEQCON').AsInteger);
      If Not Result Then
      Begin
        fRollBack;
        blnErro := True;

        Screen.Cursor := crDefault;
        FreeAndNil(qryGenChq);
        FreeAndNil(qryGenRcx);

        Exit;
      End;
    End;

    qryGenRcx := fCriaQuery;
    With qryGenRcx, SQL Do
    Begin
      Clear;
      Add('SELECT');
      Add('  RCX_CODCLI,');
      Add('  RCX_NUMDOC,');
      Add('  RCX_ESPDOC,');
      Add('  RCX_CODEMP ');
      Add('FROM');
      Add('  CADRCXX');
      Add('WHERE ');
      Add('  RCX_SEQCON = :SEQCON AND ');
      Add('  RCX_CODEMP = :CODEMP AND ');

      If strCodigoCaixa.IsEmpty Then
        Add('  RCX_DTACAD > :DTAREF ')
      Else
      Begin
        Add('  RCX_DTACAD >= :DTAREF AND ');
        Add('  RCX_LANFEC = "N"          ');
      End;

      ParamByName('SEQCON').AsInteger := cdsData.FieldByName('RCX_SEQCON').AsInteger;
      ParamByName('CODEMP').AsString  := cdsData.FieldByName('RCX_CODEMP').AsString;
      ParamByName('DTAREF').AsDateTime := dtaDataReferencia;

      Open;
    End;

    While Not qryGenRcx.Eof Do
    Begin

      If fDocumentoFaturado(qryGenRcx, strNotGer) Then
      Begin

        strSQL := '';
        strSQL := strSQL + 'UPDATE ';
        strSQL := strSQL + '  ' + strNotGer + ' ';
        strSQL := strSQL + 'SET ';
        strSQL := strSQL + '  GER_CODFPG = :CODFPG ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
        strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
        strSQL := strSQL + '  GER_CODEMP = :CODEMP ';

        With qryGenChq Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODFPG').AsString := strNovoFpg;
          ParamByName('NUMDOC').AsString := qryGenRcx.FieldByName('RCX_NUMDOC').AsString;
          ParamByName('ESPDOC').AsString := qryGenRcx.FieldByName('RCX_ESPDOC').AsString;
          ParamByName('CODEMP').AsString := qryGenRcx.FieldByName('RCX_CODEMP').AsString;
          ExecSQL;
          Close;
        End;

        strSQL := '';
        strSQL := strSQL + 'UPDATE ';
        strSQL := strSQL + '  ' + strNotDet + ' ';
        strSQL := strSQL + 'SET ';
        strSQL := strSQL + '  DET_CODFPG = :CODFPG ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  DET_NUMDOC = :NUMDOC AND ';
        strSQL := strSQL + '  DET_ESPDOC = :ESPDOC AND ';
        strSQL := strSQL + '  DET_CODEMP = :CODEMP ';

        With qryGenChq Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODFPG').AsString := strNovoFpg;
          ParamByName('NUMDOC').AsString := qryGenRcx.FieldByName('RCX_NUMDOC').AsString;
          ParamByName('ESPDOC').AsString := qryGenRcx.FieldByName('RCX_ESPDOC').AsString;
          ParamByName('CODEMP').AsString := qryGenRcx.FieldByName('RCX_CODEMP').AsString;
          ExecSQL;
          Close;
        End;

      End
      Else
      Begin

        strSQL := '';
        strSQL := strSQL + 'UPDATE ';
        strSQL := strSQL + '  ' + strArqGer + ' ';
        strSQL := strSQL + 'SET ';
        strSQL := strSQL + '  GER_CODFPG = :CODFPG ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
        strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
        strSQL := strSQL + '  GER_CODEMP = :CODEMP ';

        With qryGenChq Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODFPG').AsString := strNovoFpg;
          ParamByName('NUMDOC').AsString := qryGenRcx.FieldByName('RCX_NUMDOC').AsString;
          ParamByName('ESPDOC').AsString := qryGenRcx.FieldByName('RCX_ESPDOC').AsString;
          ParamByName('CODEMP').AsString := qryGenRcx.FieldByName('RCX_CODEMP').AsString;
          ExecSQL;
          Close;
        End;

        strSQL := '';
        strSQL := strSQL + 'UPDATE ';
        strSQL := strSQL + '  ' + strArqDet + ' ';
        strSQL := strSQL + 'SET ';
        strSQL := strSQL + '  DET_CODFPG = :CODFPG ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  DET_NUMDOC = :NUMDOC AND ';
        strSQL := strSQL + '  DET_ESPDOC = :ESPDOC AND ';
        strSQL := strSQL + '  DET_CODEMP = :CODEMP ';

        With qryGenChq Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODFPG').AsString := strNovoFpg;
          ParamByName('NUMDOC').AsString := qryGenRcx.FieldByName('RCX_NUMDOC').AsString;
          ParamByName('ESPDOC').AsString := qryGenRcx.FieldByName('RCX_ESPDOC').AsString;
          ParamByName('CODEMP').AsString := qryGenRcx.FieldByName('RCX_CODEMP').AsString;
          ExecSQL;
          Close;
        End;

      End;

      qryGenRcx.Next;
    End; {While}

    If Result Then
      fCommit
    Else
      fRollBack;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[fAlteraFormaPagamento]');
      Result := False;
    End;
  End;

  If blnErro Then
    pMensagemOk('Ocorreu uma inconsistência na gravação dos valores!' + #13#10 +
                 strDifVal + #13#10 +
                'Feche o Resumo de Caixa e tente novamente! Se o problema persistir entre em contato com a Citel!');
  blnErro := False;
  Screen.Cursor := crDefault;

  FreeAndNil(qryGenChq);
  FreeAndNil(qryGenRcx);
end;

function TfrmRcxFormasPagamento.fAlterouPagamento: Boolean;
begin
  if  ((fltDinRecAtu <>  fltDinhei) or
       (fltChqAviAtu <>  fltChqVis) or
       (fltChqPreAtu <>  fltChqPre) or
       (fltCarRecAtu <>  fltCartao) or
       (fltValFinAtu <>  fltValFin) or
       (fltOrdRecAtu <>  fltOrdRec) or
       (chkPixAvulso.Checked <> FPixAvulso)) then
  begin
    Result := True;
  end
  Else
  Begin
    If Not FRecebidoPorPix Then
    Begin
      If Assigned(FObjetoPixRecebimento) Then
      Begin
        Result := TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(FObjetoPixRecebimento);

        If Result Then
          Exit;
      End;
    End;
    Result := False;
  End;

end;

{****************************************************************}
{* ESTA FUNÇÃO RETORNA O CODIGO DO CLIENTE SE O RECEBIMENTO     *}
{* CONTER APENAS 1 CLIENTE E RETORNA '' SE HOUVER MAIS CLIENTES *}
{************************************13/03/2018**Req. 98936**WS**}
function TfrmRcxFormasPagamento.fBuscaClienteUnico: String;
var
  bkmPosicao: TBookmark;
  strSeqBai: String;
  strCodCli: String;
begin
  strCodCli := '';
  If Assigned(cdsData) Then
  Begin
    strSeqBai := cdsData.FieldByName('RCX_SEQCON').AsString;
    bkmPosicao := cdsData.GetBookmark;
    cdsData.First;
    While (Not cdsData.Eof) Do
    Begin
      If (cdsData.FieldByName('RCX_SEQCON').AsString = strSeqBai) Then
      Begin
        If fEmptyStr(strCodCli) Then
          strCodCli := cdsData.FieldByName('RCX_CODCLI').AsString
        Else
        Begin
          If strCodCli <> cdsData.FieldByName('RCX_CODCLI').AsString Then
          Begin
            strCodCli := '';
            Break;
          End;
        End;
      End;
      cdsData.Next;
    End;
    If (bkmPosicao <> Nil) Then
      cdsData.GotoBookmark(bkmPosicao);
  End;
  Result := strCodCli
end;

procedure TfrmRcxFormasPagamento.FormCreate(Sender: TObject);
begin
  inherited;
  cdsChqPre := fCriaCdsCheques(Self);
  cdsChqVis := fCriaCdsCheques(Self);
  cdsTrcChqAvisPre := fCriaCdsCheques(Self);

  strCodigoCaixa := '';

  dtaDataReferencia := 0;

  FRecebidoPorPix := False;

  FDadosPixRecebimento := '';
  FDadosPixRequisicao := '';

  FObjetoPixRecebimento := Nil;

  objLiberacao := TLiberacao.Create;

  objLogLibRec := TLogLibRec.Create;
  If Not objLogLibRec.pExisteTabela Then
    objLogLibRec.CriaTabelaTemporaria();
end;

procedure TfrmRcxFormasPagamento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //Para resolver problema do foco no botão, ao apertar ENTER
  If btnReceberPix.Enabled Then
  Begin
    If edtOrdRec.Focused Then
    Begin
      If Key = VK_Return Then
      Begin
        pSetFocus(btnConfirmaDados);
        pSetFocus(btnReceberPix);
        Key := 0;
      End;
    End;
  End;

  inherited;
end;

procedure TfrmRcxFormasPagamento.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtDinheiro);
end;

procedure TfrmRcxFormasPagamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If Not ValidarSeExistePixRecebidoSemConfirmacao Then
  Begin
    Action := CaNone;
    Exit;
  End;

  inherited;
  FreeAndNil(stlForPag);
  FreeAndNil(stlCndPag);
  FreeAndNil(objLiberacao);
  if Assigned(cdsTrcChqAvisPre) then
    FreeAndNil(cdsTrcChqAvisPre);

  if Assigned(objLogLibRec) then
     FreeAndNil(objLogLibRec);
end;

procedure TfrmRcxFormasPagamento.edtChqVistaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If Key = '-' Then
    Key := #0;

end;

procedure TfrmRcxFormasPagamento.edtDinheiroExit(Sender: TObject);
begin
  inherited;
  If Not fValidaCampos(TWinControl(Sender), True) Then
  Begin
    TEdit(Sender).Text := '0,00';
    pSetFocus(TEdit(Sender));
  End;
end;

procedure TfrmRcxFormasPagamento.edtOrdRecChange(Sender: TObject);
  Var
    LValorValido: Boolean;
begin
  inherited;
  btnReceberPix.Enabled := False;

  If FRecebidoPorPix Then
    Exit;

  LValorValido := Not fEmptyStr(edtOrdRec.Text);
  If LValorValido Then
    LValorValido := fStrToFloat(edtOrdRec.Text) > 0;

  chkPixAvulso.Enabled := LValorValido;
  If Not chkPixAvulso.Enabled Then
    chkPixAvulso.Checked := False;

  If btnReceberPix.Visible Then
  Begin
    If Not chkPixAvulso.Checked Then
      btnReceberPix.Enabled := LValorValido;
  End;

  btnReceberPix.TabOrder := 5;
end;

function TfrmRcxFormasPagamento.fDocumentoFaturado(qryRcx: TUniQuery; strTabela: String): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin

  Try
    qryGen := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  GER_NUMDOC ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + strTabela;
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  GER_CODCLI = :CODCLI ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := qryRcx.FieldByName('RCX_NUMDOC').AsString;
      ParamByName('ESPDOC').AsString := qryRcx.FieldByName('RCX_ESPDOC').AsString;
      ParamByName('CODEMP').AsString := qryRcx.FieldByName('RCX_CODEMP').AsString;
      ParamByName('CODCLI').AsString := qryRcx.FieldByName('RCX_CODCLI').AsString;
      Open;

      Result := Not qryGen.IsEmpty;

      Close;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[fDocumentoFaturado]');
      Result := False;
    End;
  End;

  FreeAndNil(qryGen);
End;

function TfrmRcxFormasPagamento.fVerificaPixAvulso(intSeqCon: Integer; strCodEmp: String; dtaDtaCaixa : TDate): Boolean;
  Var
    qryGen : TUniQuery;
    strSQL : String;
Begin
  Result := False;

  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT AUTOINCREM FROM MOVPIX ';
    strSQL := strSQL + '  WHERE MPX_SEQCON = :SEQCON ';
    strSQL := strSQL + '    AND MPX_DTACAD = :DTACAD ';
    strSQL := strSQL + '    AND MPX_CODEMP = :CODEMP ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQCON').AsInteger  := intSeqCon;
      ParamByName('DTACAD').AsDatetime := dtaDtaCaixa;
      ParamByName('CODEMP').AsString   := strCodEmp;
      Open;

      If IsEmpty Then
         Result := True
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[fVerificaPixAvulso]');
    End;
  End;

  FreeAndNil(qryGen);

End;

procedure TfrmRcxFormasPagamento.GravarLogCtrDuplicatas(ANumeroDuplicata,
  AEspecieDocumento, ACodigoEmpresa, ACodigoCliente: String);
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    //OBS: Esse não tem mesmo parcela, pois parte da MOVDET (FATURA TODAS AS PARCELAS DO DOCUMENTO)
    LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                          'FROM CADREC ' +
                          'WHERE CTR_NUMDUP=:NUMDUP AND ' +
                          '      CTR_ESPDOC=:ESPDOC AND ' +
                          '      CTR_CODEMP=:CODEMP AND ' +
                          '      CTR_CODCLI=:CODCLI AND ' +
                          '      CTR_RESCAI=1           ';

    LConsulta.ParamByName('NUMDUP').AsString := ANumeroDuplicata;
    LConsulta.ParamByName('ESPDOC').AsString := AEspecieDocumento;
    LConsulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LConsulta.ParamByName('CODCLI').AsString := ACodigoCliente;
    LConsulta.Open;

    While Not LConsulta.Eof Do
    Begin
      untLogCtr.GravaLogCtr(LConsulta.FieldByNAme('AUTOINCREM').AsString,
                            'ALTERAÇÃO DE FORMA DE PAGAMENTO',
                            Self.Name,
                            strCodOpe);

      LConsulta.Next;
    End;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmRcxFormasPagamento.GravarLogCtrDuplicatas(ASeqCon: Integer;
  ACodigoEmpresa: String; ADataLancamento: TDateTime);
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                          'FROM CADREC ' +
                          'WHERE CTR_DTAREC=:DTAREC AND ' +
                          '      CTR_EMPBAI=:CODEMP AND ' +
                          '      CTR_SEQCON=:SEQCON AND ' +
                          '      CTR_RESCAI=1           ';

    LConsulta.ParamByName('DTAREC').AsDateTime := ADataLancamento;
    LConsulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LConsulta.ParamByName('SEQCON').AsInteger := ASeqCon;
    LConsulta.Open;

    While Not LConsulta.Eof Do
    Begin
      untLogCtr.GravaLogCtr(LConsulta.FieldByNAme('AUTOINCREM').AsString,
                            'ALTERAÇÃO DE FORMA DE PAGAMENTO',
                            Self.Name,
                            strCodOpe);

      LConsulta.Next;
    End;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

function TfrmRcxFormasPagamento.fTemPermissaoAlterarFormaPagtoResumoCaixa() : Boolean;
  Var
    objLiberacao : TLiberacao;
    objTabela : TRegistroMsgLiberaTabela;
    objLinha : TLinhaMsgLibera;
    qryDup : TUniQuery;
    fltDupTot : Double;
begin
  qryDup := fCriaQuery;
  try
    objLogLibRec.pLimpaTmpLogLib();

    If fVerificaAcessoSistema('DIRRCXALTFORPAG', strCodOpe) Then
      begin
        Result := True;
        Exit;
      end;

    objLiberacao := TLiberacao.Create;
    objLiberacao.objMsgLibera.pAddSeparador(0, teAutcom);
    objLiberacao.objMsgLibera.pAddTexto('ALTERAR FORMA DE PAGAMENTO NO RESUMO DE CAIXA [F3]', alCentro , teAutcom,  '', 141);
    objLiberacao.objMsgLibera.pAddSeparador(0, teAutcom);

    objTabela := TRegistroMsgLiberaTabela.Create;
    objLinha := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna('', 'FORMA DE PAGAMENTO', 18, alEsquerda , teAutcom);
    objLinha.pAddColuna('', 'VALOR ORIGINAL'    , 15, alEsquerda , teAutcom);
    objLinha.pAddColuna('', 'VALOR PAGAMENTO'   , 15, alEsquerda , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    objLinha := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('FORMA DE PAGAMENTO', 'DINHEIRO'                                , 18 , alEsquerda );
    objLinha.pAddColuna('VALOR ORIGINAL'    , FloatToStrF(fltDinRecAtu, ffNumber, 9, 2) , 15 , alDireita );
    objLinha.pAddColuna('VALOR PAGAMENTO'   , FloatToStrF(fltDinhei, ffNumber, 9, 2)    , 15 , alDireita );
    objTabela.lstLinhas.Add(objLinha);

    objLinha := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('FORMA DE PAGAMENTO', 'CHEQUE A VISTA'                          , 18 , alEsquerda );
    objLinha.pAddColuna('VALOR ORIGINAL'    , FloatToStrF(fltChqAviAtu, ffNumber, 9, 2) , 15 , alDireita );
    objLinha.pAddColuna('VALOR PAGAMENTO'   , FloatToStrF(fltChqVis, ffNumber, 9, 2)    , 15 , alDireita );
    objTabela.lstLinhas.Add(objLinha);

    objLinha := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('FORMA DE PAGAMENTO', 'CHEQUE PRÉ'                              , 18 , alEsquerda );
    objLinha.pAddColuna('VALOR ORIGINAL'    , FloatToStrF(fltChqPreAtu, ffNumber, 9, 2) , 15 , alDireita );
    objLinha.pAddColuna('VALOR PAGAMENTO'   , FloatToStrF(fltChqPre, ffNumber, 9, 2)    , 15 , alDireita );
    objTabela.lstLinhas.Add(objLinha);

    objLinha := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('FORMA DE PAGAMENTO', 'CARTÃO'                                  , 18 , alEsquerda );
    objLinha.pAddColuna('VALOR ORIGINAL'    , FloatToStrF(fltCarRecAtu, ffNumber, 9, 2) , 15 , alDireita );
    objLinha.pAddColuna('VALOR PAGAMENTO'   , FloatToStrF(fltCartao, ffNumber, 9, 2)    , 15 , alDireita );
    objTabela.lstLinhas.Add(objLinha);

    objLinha := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('FORMA DE PAGAMENTO', IIF(chkPixAvulso.Checked, 'ORDEM PAGTO (PIX)', 'ORDEM PAGAMENTO') , 18 , alEsquerda );
    objLinha.pAddColuna('VALOR ORIGINAL'    , FloatToStrF(fltOrdRecAtu, ffNumber, 9, 2) , 15 , alDireita );
    objLinha.pAddColuna('VALOR PAGAMENTO'   , FloatToStrF(fltOrdRec, ffNumber, 9, 2)    , 15 , alDireita );
    objTabela.lstLinhas.Add(objLinha);

    objLinha := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('FORMA DE PAGAMENTO', 'FINANCIAMENTO'                           , 18 , alEsquerda );
    objLinha.pAddColuna('VALOR ORIGINAL'    , FloatToStrF(fltValFinAtu, ffNumber, 9, 2) , 15 , alDireita );
    objLinha.pAddColuna('VALOR PAGAMENTO'   , FloatToStrF(fltValFin, ffNumber, 9, 2)    , 15 , alDireita );
    objTabela.lstLinhas.Add(objLinha);

    objLinha := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlTotal;
    objLinha.pAddColuna('FORMA DE PAGAMENTO', 'TOTAL'                             , 18 , alDireita );
    objLinha.pAddColuna('VALOR ORIGINAL'    , FloatToStrF(fltValDoc,ffFixed,12,2) , 15 , alDireita );
    objLinha.pAddColuna('VALOR PAGAMENTO'   , FloatToStrF(fltValDig,ffFixed,12,2) , 15 , alDireita );
    objTabela.lstLinhas.Add(objLinha);

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    objTabela := TRegistroMsgLiberaTabela.Create;
    objLinha := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna('', 'NUMERO DA DUPLICATA'  , 20 , alEsquerda , teAutcom);
    objLinha.pAddColuna('', 'EMPRESA'              ,  7 , alCentro   , teAutcom);
    objLinha.pAddColuna('', 'CLIENTE'              , 25 , alEsquerda , teAutcom);
    objLinha.pAddColuna('', 'DT.CAD.'              , 10 , alCentro   , teAutcom);
    objLinha.pAddColuna('', 'DT. VEN.'             , 10 , alCentro   , teAutcom);
    objLinha.pAddColuna('', 'VALOR ORIGINAL'       , 14 , alDireita  , teAutcom);
    objLinha.pAddColuna('', 'DESCRIÇÃO'            , 25 , alEsquerda  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    qryDup.Close;
    qryDup.SQL.Clear;
    qryDup.SQL.Add('SELECT CONCAT(CTR_NUMDUP,CTR_PARCEL,''-'',CTR_ESPDOC) AS NUMDUP, CTR_ESPDOC, CTR_CODEMP,');
    qryDup.SQL.Add('       CTR_NUMDUP, CTR_CODCLI, CLI_NOMCLI, CTR_DTACAD, CTR_DTAVEN, RCX_VALDOC, RCX_DESCRI, RCX_CODEMP,');
    qryDup.SQL.Add('       CTR_PARCEL');
    qryDup.SQL.Add('');
    qryDup.SQL.Add('FROM CADREC');
    qryDup.SQL.Add('INNER JOIN CADCLI');
    qryDup.SQL.Add('  ON CLI_CODCLI = CTR_CODCLI');
    qryDup.SQL.Add('LEFT JOIN CADRCXX');
    qryDup.SQL.Add('  ON RCX_SEQCON = CTR_SEQCON');
    qryDup.SQL.Add('  AND RCX_DTACAD = CTR_DTAREC');
    qryDup.SQL.Add('  AND RCX_CODEMP = CTR_EMPBAI');
    qryDup.SQL.Add('  AND RCX_CODCLI = CTR_CODCLI');
    qryDup.SQL.Add('');
    qryDup.SQL.Add('WHERE RCX_CODEMP = :CODEMP');
    qryDup.SQL.Add('AND CTR_SEQCON = :SEQCON');
    qryDup.ParamByName('CODEMP').AsString  := cdsData.FieldByName('RCX_CODEMP').AsString;
    qryDup.ParamByName('SEQCON').AsInteger := vIntSeqCon;
    qryDup.Open;

    fltDupTot := 0;

    qryDup.First;
    while not qryDup.eof do
      begin
        objLinha := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('NUMERO DA DUPLICATA' , qryDup.FieldByName('NUMDUP').AsString     , 20 , alEsquerda );
        objLinha.pAddColuna('EMPRESA'             , qryDup.FieldByName('RCX_CODEMP').AsString ,  7 , alCentro );
        objLinha.pAddColuna('CLIENTE'             , qryDup.FieldByName('CLI_NOMCLI').AsString , 25 , alEsquerda );
        objLinha.pAddColuna('DT.CAD.'             , qryDup.FieldByName('CTR_DTACAD').AsString , 10 , alCentro );
        objLinha.pAddColuna('DT. VEN.'            , qryDup.FieldByName('CTR_DTAVEN').AsString , 10 , alCentro );
        objLinha.pAddColuna('VALOR ORIGINAL'      , FloatToStrF(qryDup.FieldByName('RCX_VALDOC').AsFloat, ffNumber, 9, 2)   , 14 , alDireita );
        objLinha.pAddColuna('DESCRIÇÃO'           , qryDup.FieldByName('RCX_DESCRI').AsString , 25 , alEsquerda );
        objTabela.lstLinhas.Add(objLinha);
        fltDupTot := fltDupTot + qryDup.FieldByName('RCX_VALDOC').AsFloat;
        qryDup.next;
      end;

    objLinha := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlTotal;
    objLinha.pAddColuna(''                    , 'TOTAL'                                  , 80 , alDireita );
    objLinha.pAddColuna('VALOR ORIGINAL'      , FloatToStrF(fltDupTot, ffNumber, 9, 2)   , 14 , alDireita );
    objLinha.pAddColuna(''                    , ''                                       , 25 , alEsquerda );
    objTabela.lstLinhas.Add(objLinha);

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    objLiberacao.strDirAce := 'DIRRCXALTFORPAG';
    objLiberacao.strMsgSen := 'Permitir alterar forma de pagamento no resumo de caixa [F3]';
    objLiberacao.strCodOpe := strCodOpe;
    Result := objLiberacao.fLibera;

    if (Result) then
      begin
        qryDup.First;
        while not qryDup.eof do
          begin
            ObjLoglibRec.pInsereLogLigTMP(objLiberacao, qryDup.FieldByName('CTR_NUMDUP').AsString, qryDup.FieldByName('CTR_ESPDOC').AsString, qryDup.FieldByName('CTR_CODEMP').AsString );
            objLogLibRec.pGravarTmplogLib(qryDup.FieldByName('CTR_NUMDUP').AsString, qryDup.FieldByName('CTR_ESPDOC').AsString, qryDup.FieldByName('CTR_CODEMP').AsString );
            qryDup.next;
          end;
      end;

    qryDup.Close;
  finally
    if (assigned(objLiberacao)) then
      FreeAndNil(objLiberacao);

    FreeAndNil(qryDup);
  end;

end;

procedure TfrmRcxFormasPagamento.AcertaDesmembramentoModalidades(ASeqCon: Integer; ACodigoEmpresa: String; ADataLancamento: TDateTime;
 fltvlDinhei, fltvlChqVis, fltvlChqPre, fltvlCartao, fltvlOrdRec : Double );
  Var
    LConsulta: TUniQuery;
    LDesmembrarBaixaReceber : TDesmembraBaixaReceber;
begin
  LConsulta := fCriaQuery;

  Try

    LDesmembrarBaixaReceber := TDesmembraBaixaReceber.Create;

    LDesmembrarBaixaReceber.ApagarDesmembramentoAnterior(ASeqCon, ACodigoEmpresa, ADataLancamento);

    LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                          'FROM CADREC ' +
                          'WHERE CTR_DTAREC=:DTAREC AND ' +
                          '      CTR_EMPBAI=:CODEMP AND ' +
                          '      CTR_SEQCON=:SEQCON AND ' +
                          '      CTR_RESCAI=1           ';

    LConsulta.ParamByName('DTAREC').AsDateTime := ADataLancamento;
    LConsulta.ParamByName('CODEMP').AsString   := ACodigoEmpresa;
    LConsulta.ParamByName('SEQCON').AsInteger  := ASeqCon;
    LConsulta.Open;

    LConsulta.First;

    While Not LConsulta.Eof Do
    Begin

      LDesmembrarBaixaReceber.AdicionarDuplicata(LConsulta.FieldByNAme('AUTOINCREM').AsString);

      LConsulta.Next;
    End;

    //Aqui sera feito o desmembramento do titulo por especies de pagamento
    LDesmembrarBaixaReceber.ProcessarDesmembramentos(fltvlDinhei,
                                                     fltvlCartao,
                                                     fltvlChqPre,
                                                     fltvlChqVis,
                                                     fltvlOrdRec,
                                                     '');

  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);

    If Assigned(LDesmembrarBaixaReceber) Then
       FreeAndNil(LDesmembrarBaixaReceber);
  End;
end;

end.

