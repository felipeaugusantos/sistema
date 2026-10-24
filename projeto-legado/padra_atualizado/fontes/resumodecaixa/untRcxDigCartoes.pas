{***************************}
{* qryCadCar -> CADCAR     *}
{************************RV*}
unit untRcxDigCartoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Mask, MaskEditFocus, Menus, AppEvnts, Uni, untConstantes, untTypesSistema,
  untTefRecebimento, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  StrUtils, untLiberacao, untTAmarraCartao, untInterfaceTefCitel, untTefCitelUtil,
  untTefCitelPagueFacil, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxDateUtils, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, UniClientDataSet, untMsgLiberacao;

type
  TfrmRcxDigCartoes = class(TfrmPaiSimples)
    pnlPrincipal: TPanel;
    Label3: TLabel;
    edtCodCar: TEditFocus;
    edtDesCar: TEditFocus;
    Label4: TLabel;
    edtTotCar: TEditFocus;
    lblCndPag: TLabel;
    mskCndPag: TMaskEditFocus;
    Label6: TLabel;
    edtObsCar: TEditFocus;
    pnlTotais: TPanel;
    Label7: TLabel;
    edtTotDig: TEditFocus;
    Label8: TLabel;
    edtTotGer: TEditFocus;
    Label9: TLabel;
    edtQtdPar: TEditFocus;
    btnConfirma: TBitBtnLocked;
    pnlConfirma: TPanel;
    pnlATop: TPanel;
    edtNumNsu: TEditFocus;
    Label1: TLabel;
    edtNumCcd: TEditFocus;
    lblNumLib: TLabel;
    edtValCar: TEditFocus;
    Label2: TLabel;
    edtNumNsuCon: TEditFocus;
    Label5: TLabel;
    btnAjuda: TBitBtnLocked;
    Label11: TLabel;
    mskDtaTra: TcxDateEdit;
    procedure btnSairClick(Sender: TObject);
    procedure edtCodCarKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtValCarKeyPress(Sender: TObject; var Key: Char);
    procedure edtQtdParChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnAjudaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodCarExit(Sender: TObject);
    procedure edtNumCcdKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumNsuKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumNsuConKeyPress(Sender: TObject; var Key: Char);
    procedure edtQtdParKeyPress(Sender: TObject; var Key: Char);
    procedure mskCndPagKeyPress(Sender: TObject; var Key: Char);
    procedure edtObsCarKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryCadCar: TUniQuery;
    blnRealizandoTEF: Boolean;
    blnLibMinParc: Boolean;
    objLiberacao : TLiberacao;


    FblnExecutandoPeloFaturamento : Boolean;

    RetornoTEFCitel: IRetornoTEFCitel;
    blnCartCreditoLiberado: Boolean;
    blnCartCreditoAVencerLiberado: Boolean;

    intOperacao, intQtdParc : Integer;
    FLiberacao: TLiberacao;
    FLiberadoCartCred: Boolean;
    FLiberadoCartCredVencer: Boolean;

    FintPeriod: Integer ;
    FintPriVenc: Integer ;
    FblnMultiLojaComAlgumaEmpresaTefDesligado: Boolean ;

    function fConfirmarDados: Boolean;

    procedure OnFormShow(Sender: TObject);

    procedure pCarregaCartao;
    function fTravarQuantidadeNegociada: Boolean;
    function fPermitirRecebVencidoCartCredito: Boolean;
    function fPermitirRecebAVencerCartCredito: Boolean;

    function ValidaAcessoAosPortadoresDeCartao(): Boolean;

    function fChamaTelaDeOperacoes(out intQtdParc : Integer;
                                   out intOperacao : Integer;
                                       AobjDadosAdicionaisTefTra: IDadosAdicionaisTefTra) : IRetornoTEFCitel;
    function fLiberarRecebCartCredito: Boolean;
    function fLiberarRecebAVencerCartCredito: Boolean;
    procedure pAddDupVencidas;
    procedure pAddDupAVencer;

    procedure pBloqueiaContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure pSetaContextPopup;
    function fPrecisaAmarrarInfoCartao(const AstrCodCar, AstrCodEmp: String):boolean ;
    function fCodigoCartaoSomenteLeitura: Boolean ;
    procedure pTrataCndTef;
    procedure pAcertaNumDocTraDoc ;
    procedure pReadOnlyNsuNumeroLiberacaoTefF11(const AstrNsu, AstrCcd: String) ;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnTroCar: Boolean;
    optTrocoCar: TOperacaoTroco;
    fltValorTrocoCar: Double;

    fltTotDig: Double;
    fltTotGer: Double;
    fltMaxDig: Double;

    fltValDig: Double;
    fltValDes: Double;
    fltPerDes: Double;

    dtaDatTra:TDateTime;

    blnConfirma: Boolean;
    qryGenCar: TUniQuery;
    blnHabComp: Boolean;

    blnTraVal: Boolean;

    blnRcxResumoCaixa: Boolean;
    blnTemDupsVencidas: Boolean;
    blnTemDupsAVencer: Boolean;

    strNumCcd: String;
    strCodCar: String;
    strNumNsu: String;
    strControle: String;
    intQtdPar: Integer;
    intQtdNeg: Integer;

    blnFulfillment: Boolean;

    strCodFin: String;

    blnSairComEsc: Boolean;
    blnF11       : Boolean;
    strArquivoTef: String;
    blnTefRcx: Boolean;
    objTefRecebimento: ITefRecebimento;
    objTefCitelPagueFacil : ITefCitelPagueFacil;

    strArqViaCliente: String;
    strArqViaLojista: String;
    strNumDoc: String;
    strDtaTra: String;
    strHraTra: String;
    strOpcDoc: String;
    strIncDoc: String;
    strTabela: String;
    intModali: Integer;

    blnTipPOS: Boolean;

    blnSemMensagem: Boolean;

    arrCartoes: TCartoesResumoCaixaArray; //Array de cartoes já digitados
    arrCartoesTef: TCartoesResumoCaixaArray;
    arrDocCartoes: TArrayInfoTraDoc;

    strUltMsgCamposCartao : String;
    strSessaoTef : String;
    strRcxCodOpe : String;
    blnEhQuestFidelidade: Boolean;
    blnQtdeParcTefDifNegociada: Boolean;
    blnEhGrynCash: Boolean;

    strChaPix : String;
    strPixS_N : String;
    strCodigoCarteiraDigital : String;
    strCodigoTipoOperacaoCartao: string;
    strCodigoBandeira: string;

    strTpParc: String;

    strModalidade: String;

    blnPermiteDigitarDados: Boolean;

    cdsTemp: TUniClientDataSet;

    property Liberacao: TLiberacao read FLiberacao write FLiberacao;
    property LiberadoCartCred: Boolean read FLiberadoCartCred write FLiberadoCartCred default False;
    property LiberadoCartCredVencer: Boolean read FLiberadoCartCredVencer write FLiberadoCartCredVencer default False;
    function fVerificaCamposCartao: Boolean;

    procedure pExecutarSemTela();

    procedure pGarantirCancelamentoTefRecebimento(AobjTefRecebimento : ITefRecebimento; AstrArquivo: String);
    procedure pCancelarTefDeCartoesJaConfirmados(AobjTefRecebimento: ITefRecebimento; AarrCartoes: TCartoesResumoCaixaArray);
    procedure pPrepararEdits;
    property Period: Integer read FintPeriod write FintPeriod ;
    property PriVenc: Integer read FintPriVenc write FintPriVenc ;
    property blnExecutandoPeloFaturamento : Boolean read FblnExecutandoPeloFaturamento write FblnExecutandoPeloFaturamento;
    procedure pGaranteCancelamentoTefCitel(AarrCartoes : TCartoesResumoCaixaArray);
    property MultiLojaComAlgumaEmpresaTefDesligado: Boolean read FblnMultiLojaComAlgumaEmpresaTefDesligado write FblnMultiLojaComAlgumaEmpresaTefDesligado ;
    function fVaiExibirPerguntaTefPos: Boolean;
  end;


implementation

uses untFuncoes, untFuncoesSimples, untPesqAux, untPai,
     untFuncFat, untConsultas, untFunTef, untFiscal, untRelAjudaMod,
     untTefCitelOperacoes, untPrincipal, untFatVendas, untTefCitelInfoMsg, math;

{$R *.dfm}

procedure TfrmRcxDigCartoes.btnSairClick(Sender: TObject);
begin
  If blnRealizandoTEF Then
    Exit;

  inherited;
  Close;
end;

function TfrmRcxDigCartoes.fTravarQuantidadeNegociada: Boolean;
begin
  Result := TDadosValidaParcelasCartao
              .New
              .F11(blnF11)
              .QtdNeg(intQtdNeg)
              .CodFin(strCodFin)
              .fTravarQuantidadeNegociada ;
end;

function TfrmRcxDigCartoes.fPermitirRecebVencidoCartCredito: Boolean;
begin
  Result := fCfgSis('RECVCD', varBoolean);
end;

function TfrmRcxDigCartoes.fPermitirRecebAVencerCartCredito: Boolean;
begin
  Result := fCfgSis('PERCCV', varBoolean);
end;

function TfrmRcxDigCartoes.fPrecisaAmarrarInfoCartao(const AstrCodCar,
  AstrCodEmp: String): boolean;
begin
  Result := True ;
  if fEmptyStr(AstrCodCar) then
    exit ;

  if (not fEmptyStr(AstrCodEmp)) and (AstrCodEmp <> VS_strCodEmp) then
    exit ;

  Result := False ;
end;

function TfrmRcxDigCartoes.fVaiExibirPerguntaTefPos: Boolean;
begin
  Result := (VS_strUsaTef = 'S') and Assigned(objTefRecebimento) and (blnTefRcx) and (not FblnMultiLojaComAlgumaEmpresaTefDesligado);
end;

function TfrmRcxDigCartoes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;

  procedure pMensagem(strTitulo: String;
                      strTexto: String;
                      arrOpcoes: Array Of String);
  Begin
    If (Not blnSemMensagem) Then
      fMensagem(strTitulo, strTexto, arrOpcoes)
    Else
      strUltMsgCamposCartao := strTexto;
  End;

  Var
    strCartaoTef: String;
    strCodOpe: String;
    strArquivo : String;
    blnObrCCD,
    blnObrNSU: Boolean;
    strCCD, strNSU : String;
    objAmarraCartao: TAmarraCartao;
    strData, strHora : String;
    stlConteudo : TStringList;
    LstrCodEmp : String ;
    LobjDadosAdicionaisTefTra: IDadosAdicionaisTefTra ;
    LstrTipoOperacaoTef: String ;
begin

  If blnRealizandoTEF Then
  Begin
    Result := False;
    Exit;
  End;

  Result := True;

  blnObrCCD := (qryCadCar.Active) And
               (qryCadCar.RecordCOunt > 0) And
               (fObrigaInformarNumeroLiberacaoCartao(qryCadCar.FieldByName('CAR_OBRCCD').AsString));
  blnObrNSU := (qryCadCar.Active) And
               (qryCadCar.RecordCOunt > 0) And
               (fObrigaInformarNSUCartao(qryCadCar.FieldByName('CAR_OBRNSU').AsString));

  If (Sender = edtNumCcd) And ((VS_strUsaTef = 'N') Or blnTipPOS) And (blnObrCCD) Then
  Begin

    If (fEmptyStr(edtNumCcd.Text)) Then
    Begin
      pMensagem('', 'O número de liberação deve ser preenchido!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = mskDtaTra) Then
  Begin

    If (fEmptyStr(mskDtaTra.Text)) Then
    Begin
      pMensagem('', 'A data da transação deve ser informada!', ['&Ok']);
      Result := False;
    End
    Else If (StrToDateTime(mskDtaTra.Text) > VS_Date) Then
    Begin
      pMensagem('', 'A Data da transação não pode ser maior que a data de hoje!', ['&Ok']);
      Result := False;
    End
    Else If (StrToDateTime(mskDtaTra.Text) < (VS_Date - fCfgSis('DTRARE', varInteger))) Then
    Begin
      pMensagem('', 'A Data da transação não pode ser inferior a '+fCfgSis('DTRARE', varString)+' dias!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = edtValCar) And (edtValCar.Enabled) Then
  Begin

    If (fEmptyStr(edtValCar.Text)) Then
    Begin
      pMensagem('', 'É necessário digitar o valor do cartão!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtValCar.Text) < 0.01) Then
    Begin
      pMensagem('', 'O valor do cartão deve ser maior ou igual a 0,01!', ['&Ok']);
      Result := False;
    End
    Else If (Not blnTroCar) And (fFormataFloat(fStrToFloat(edtValCar.Text), 2) > fFormataFloat(fltMaxDig, 2)) Then
    Begin
      pMensagem('', 'O valor do cartão deve ser menor ou igual a ' + FloatToStrF(fltMaxDig, ffFixed, 12, 2) + '!', ['&Ok']);
      Result := False;
    End
    Else If (Not blnTroCar) And (blnTraVal) And (fFormataFloat(fStrToFloat(edtValCar.Text), 2) <> fFormataFloat(fltMaxDig, 2)) Then
    Begin
      pMensagem('', 'O valor do cartão deve ser igual a ' + FloatToStrF(fltMaxDig, ffFixed, 12, 2) + '!', ['&Ok']);
      Result := False;
    End;

    If Result And (Not blnBuscaPorChave) And (blnTroCar)                            And
      (fFormataFloat(fStrToFloat(edtValCar.Text), 2) > fFormataFloat(fltMaxDig, 2)) And
      (Not Assigned(objTefRecebimento))                                             Then
    Begin
      optTrocoCar      := otNada;
      fltValorTrocoCar := 0.0;

      If (Not blnSemMensagem) Then
      Begin
        Case fMensagem('', 'Deseja:', ['&Crédito', '&Troco', 'C&ancelar']) Of
          1: optTrocoCar := otCredito;
          2: optTrocoCar := otTroco;
          Else
          Begin
            Result := False;
            optTrocoCar := otNada;
          End;
        End;
      End
      Else
      Begin
        Result := False;
        optTrocoCar := otNada;
      End;

      If optTrocoCar <> otNada Then
        fltValorTrocoCar := fFormataFloat(fStrToFloat(edtValCar.Text) - fltMaxDig, 2);

    End;
    If (Result) and fVaiExibirPerguntaTefPos Then
    Begin
      If (Not blnSemMensagem) Then
      Begin
        blnPermiteDigitarDados := True;

        If fMensagem('', 'Escolha a opção:', ['&TEF', '&POS']) = 1 Then
        Begin
          If (Result) And (fCfgSis('PAFECF', varBoolean)) Then
          Begin
            If Not Assigned(VS_objFiscal) Then
            Begin
              fMensagem('', TEFREC_MENSAGEM_OBJETO_ECF_NULL, ['&OK']);
              Result := False;
            End;

            If Not VS_objFiscal.fArquivoEcfIniValido(strArquivo) Then
            Begin
              fMensagem('', TEFREC_MENSAGEM_ARQUIVO_ECF_INVALIDO + sLineBreak +
                            TEFREC_MENSAGEM_OBJETO_ECF_NULL + sLineBreak +
                            strArquivo, ['&OK']);
              Result := False;
            End;
          End;

          If (Result) Then
          Begin
            blnRealizandoTEF := True;
            blnTipPOS        := False;

            if VS_blnTefCitel then
            begin
              if VS_AutoatendimentoPagueFacil then
              begin
                strNumDoc := fRetNumDocTransacaoTef;
                strOpcDoc := 'PF';

                LobjDadosAdicionaisTefTra := TDadosAdicionaisTefTra
                                               .New
                                               .OpcDoc(strOpcDoc)
                                               .PixS_N('N')
                                               .OpeRcx(strRcxCodOpe)
                                               .ArrDocs(Nil)
                                               .NumDoc(strNumDoc)
                                               .Valor(fStrToFloat(edtValCar.Text)) ;

                RetornoTEFCitel := objTefCitelPagueFacil.fRecebePagueFacil(fStrToFloat(edtValCar.Text),
                                                                           intQtdParc,
                                                                           intOperacao,
                                                                           strNumDoc,
                                                                           strRcxCodOpe,
                                                                           strModalidade,
                                                                           LobjDadosAdicionaisTefTra);
              end
              else
              begin
                strNumDoc := fRetNumDocTransacaoTef;
                pAcertaNumDocTraDoc ;
                LobjDadosAdicionaisTefTra := TDadosAdicionaisTefTra
                                               .New
                                               .OpcDoc(strOpcDoc)
                                               .PixS_N('N')
                                               .OpeRcx(strRcxCodOpe)
                                               .ArrDocs(arrDocCartoes)
                                               .NumDoc(strNumDoc)
                                               .Valor(fStrToFloat(edtValCar.Text)) ;

                RetornoTEFCitel := fChamaTelaDeOperacoes(intQtdParc, intOperacao, LobjDadosAdicionaisTefTra);
              end ;

              Result := Assigned(RetornoTEFCitel);

              if Result then
              begin
				        stlConteudo    := TStringList.Create;
                try
                  
                  pMontaConteudoCupom(RetornoTEFCitel.DadosCartao.strConteudoViaCliente + sLineBreak +
                                      RetornoTEFCitel.DadosCartao.strConteudoViaLojista,
                                      fStrZero(RetornoTEFCitel.DadosCartao.strNomeRede,5),
                                      fStrZero(RetornoTEFCitel.DadosCartao.strBandeira,5),
                                      RetornoTEFCitel.DadosCartao.strCodigoEstabeleci,
                                      stlConteudo);
                  strArquivoTef  := stlConteudo.Text;
                finally

                  FreeAndNil(stlConteudo);
                end;

                strArqViaCliente := RetornoTEFCitel.DadosCartao.strConteudoViaCliente;
                strArqViaLojista := RetornoTEFCitel.DadosCartao.strConteudoViaLojista;
                strData          := copy(RetornoTEFCitel.DadosCartao.strDataHoraTrans,1,8);
                strHora          := copy(RetornoTEFCitel.DadosCartao.strDataHoraTrans,9,6);
                strControle      := RetornoTEFCitel.DadosCartao.strControle ;

              end;
            end
            Else
              Result := objTefRecebimento.fAdicionarRecebimento(fStrToFloat(edtValCar.Text), strArquivoTef);
          End;

          If Result Then
          Begin
            If (VS_blnTefCitel) Then
            begin
              edtNumNsu.Text := IfThen(Not fEmptyStr(RetornoTEFCitel.DadosCartao.strNSU), fPadL(RetornoTEFCitel.DadosCartao.strNSU, 14, '0'), '');
              if fEmptyStr(RetornoTEFCitel.DadosCartao.strNSU) then edtNumNsu.ReadOnly := False else edtNumNsu.ReadOnly := True ;

              edtNumCcd.Text := RetornoTEFCitel.DadosCartao.strAutorizacao;
              if fEmptyStr(edtNumCcd.Text) then edtNumCcd.ReadOnly := False else edtNumCcd.ReadOnly := True ;

              If edtNumNsuCon.Visible Then
                edtNumNsuCon.Text := IfThen(Not fEmptyStr(RetornoTEFCitel.DadosCartao.strNSU), fPadL(RetornoTEFCitel.DadosCartao.strNSU, 14, '0'), '');

              strTpParc      := RetornoTEFCitel.DadosCartao.strTipoTransacao;
              intQtdPar      := StrToInt(RetornoTEFCitel.DadosCartao.strQuantidadeParcelas);

              strDtaTra      := copy(RetornoTEFCitel.DadosCartao.strDataHoraTrans,1,8);
              strHraTra      := copy(RetornoTEFCitel.DadosCartao.strDataHoraTrans,9,6);

              LstrTipoOperacaoTef := RetornoTEFCitel.DadosCartao.strTipoOperacao ;
              strCodigoTipoOperacaoCartao := IntToStr(intOperacao);
              strCodigoBandeira := fStrZero(RetornoTEFCitel.DadosCartao.strBandeira,5);

              strCartaoTef := '';
              LstrCodEmp := '';
              pRetDadosCartao(fStrZero(RetornoTEFCitel.DadosCartao.strNomeRede,5),
                              strCodigoBandeira,
                              RetornoTEFCitel.DadosCartao.strTipoTransacao,
                              intQtdPar, strCartaoTef, RetornoTEFCitel.DadosCartao.strCodigoCarteiraDigital,
                              LstrCodEmp, RetornoTEFCitel.DadosCartao.strTipDeb, LstrTipoOperacaoTef);

              strChaPix := '';
              strPixS_N := 'N';
              strCodigoCarteiraDigital := '';
              if intOperacao = 122 then
              begin
                strPixS_N := RetornoTEFCitel.DadosCartao.strPixS_N ;
                strChaPix := RetornoTEFCitel.DadosCartao.strChaPix ;
                strCodigoCarteiraDigital := RetornoTEFCitel.DadosCartao.strCodigoCarteiraDigital ;
              end;

              if fPrecisaAmarrarInfoCartao(strCartaoTef, LstrCodEmp) then
              begin
                objAmarraCartao := TAmarraCartao.Create(fStrZero(RetornoTEFCitel.DadosCartao.strNomeRede,5),
                                                        strCodigoBandeira,
                                                        RetornoTEFCitel.DadosCartao.strTipoTransacao, intQtdPar,
                                                        RetornoTEFCitel.DadosCartao.strCodigoCarteiraDigital,
                                                        RetornoTEFCitel.DadosCartao.strTipDeb, LstrTipoOperacaoTef);
                Try
                  objAmarraCartao.pPosNumerosSeq('', strCCD, strNSU, strCartaoTef);
                Finally
                  FreeAndNil(objAmarraCartao);
                End;
              end;

              edtCodCar.Text := strCartaoTef;
              pCarregaCartao;

              edtQtdPar.Text := RetornoTEFCitel.DadosCartao.strQuantidadeParcelas;
            end
            Else If Assigned(VS_objTef) Then
            Begin
              edtNumCcd.Text := VS_objTef.strNumCcd;
              edtNumNsu.Text := IfThen(Not fEmptyStr(VS_objTef.strNumNsu), fPadL(VS_objTef.strNumNsu, 14, '0'), '');
              If edtNumNsuCon.Visible Then
                edtNumNsuCon.Text := IfThen(Not fEmptyStr(VS_objTef.strNumNsu), fPadL(VS_objTef.strNumNsu, 14, '0'), '');

              intQtdPar := VS_objTef.intQtdPar;

              strCartaoTef := '';
              pRetDadosCartao(VS_objTef.strNomRed, VS_objTef.strNomBan, VS_objTef.strTipTra, intQtdPar, strCartaoTef, '', LstrCodEmp, '0', 'C');
              edtCodCar.Text := strCartaoTef;
              pCarregaCartao;

              edtQtdPar.Text := IntToStr(VS_objTef.intQtdPar);

              if fEmptyStr(strChaPix)then
                strChaPix := VS_objTef.strChaPix;
              if fEmptyStr(strPixS_N)then
                strPixS_N := VS_objTef.strPixS_N;
            End
            else
            begin
              Result := False;
              pMensagemOk('A modalidade selecionada utiliza "TEF", ' +
                          'porém as configurações do TEF não foram ' +
                          'carregadas na inicialização do sistema! ' +
                          'Reinicie o AUTCOM, e se o problema persistir entre em contato com a Citel!');
            end;
          End;

          blnRealizandoTEF := False;

          if (Result) and (not fEmptyStr(edtQtdPar.Text)) and (StrToIntDef(edtQtdPar.Text,0) > 0)
             and (Assigned(qryGenCar)) and (qryGenCar.Active) then
          begin
            pTrataCndTef ;
            mskCndPag.Text    := fRetornaCndPagPeriod(StrToIntDef(edtQtdPar.Text,0),
                                                      ifThen(FintPriVenc = -1, qryGenCar.FieldByName('CAR_PERIOD').AsInteger, FintPeriod),
                                                      qryGenCar.FieldByName('CAR_EXCDIA').AsInteger,
                                                      FintPriVenc);
          end;

          If Result Then
          begin
            edtValCar.Enabled := False;
            if (blnRcxResumoCaixa) or (blnExecutandoPeloFaturamento) then
            begin
              btnConfirmaClick(nil);
            end;
          end;
        End
        Else
        Begin
          blnTipPOS         := True;
          edtValCar.Enabled := False;
          strArqViaCliente  := '';
          strArqViaLojista  := '';
          If fCodigoCartaoSomenteLeitura Then
          Begin
            edtCodCar.ReadOnly := True;
            edtQtdPar.ReadOnly := True;
          End;
        End;
      End
      Else
        Result := False;
    End;

  End
  Else If (Sender = edtCodCar) And (edtCodCar.Enabled)Then
  Begin

    If (fEmptyStr(edtCodCar.Text)) Then
    Begin
      pMensagem('', 'O código do cartão deve ser preenchido!', ['&Ok']);
      Result := False;
    End Else
    Begin

      If blnBuscaPorChave Then
        pCarregaCartao;

      If (qryGenCar.FieldByName('CAR_CODCAR').IsNull) Then
      Begin
        pMensagem('', 'Esse cartão não está cadastrado!', ['&Ok']);
        Result := False;
      End

      Else If qryGenCar.FieldByName('CAR_STATUS').AsString = 'N' Then
      Begin
        pMensagem('', 'Esse cartão está inativo!', ['&Ok']);
        Result := False;
      End

      Else If Not ValidaAcessoAosPortadoresDeCartao Then
      Begin
        fMensagem('ATENÇÃO!', 'Operador sem permissão de acesso aos portadores do cadastro de cartões!', ['&Ok']);
        Result := False;
      End

      Else If (Not qryGenCar.FieldByName('CAR_CODEMP').IsNull) And
              (Not fEmptyStr(qryGenCar.FieldByName('CAR_CODEMP').AsString))   And
              (Not blnEhQuestFidelidade) And
              (Not blnEhGrynCash ) And
              (qryGenCar.FieldByName('CAR_CODEMP').AsString <> VS_strCodEmp) Then
      Begin
        pMensagem('', 'Cartão da empresa (' + qryGenCar.FieldByName('CAR_CODEMP').AsString + '), ' +
          'portanto não pode ser utilizado.', ['&Ok']);
        Result := False;
      End
      Else If (fTravarQuantidadeNegociada) And (Not fEmptyStr(strCodCar)) And
              (fRetTipoCartao(strCodCar) = 'D') And (qryGenCar.FieldByName('CAR_TIPCAR').AsString = 'C') Then
      Begin
        pMensagem('', 'Foi negociado para recebimento com cartão de DÉBITO, portanto não é ' +
                      'permitido selecionar um cartão de CRÉDITO. Favor selecionar outro ' +
                      'cartão para prosseguir com o recebimento!', ['&Ok']);//Imperio das tintas - divergencia de Taxas de cartoes
        Result := False;
      End

      Else If (Not fPermitirRecebVencidoCartCredito) And (qryGenCar.FieldByName('CAR_TIPCAR').AsString = 'C') and (blnTemDupsVencidas)
      And (blnRcxResumoCaixa) and (Not blnCartCreditoLiberado) Then
      Begin
        Result := fLiberarRecebCartCredito;
        blnCartCreditoLiberado := Result;
        FLiberadoCartCred := Result;
      End

      Else If (Not fPermitirRecebAVencerCartCredito) And (qryGenCar.FieldByName('CAR_TIPCAR').AsString = 'C') and (blnTemDupsAVencer)
      And (blnRcxResumoCaixa) and (Not blnCartCreditoAVencerLiberado) Then
      Begin
        Result := fLiberarRecebAVencerCartCredito;
        blnCartCreditoAVencerLiberado := Result;
        FLiberadoCartCredVencer := Result;
      End;

      If Result Then
      Begin
        fltPerDes := IIF(qryCadCar.FieldByName('CAR_TIPTAX').AsString.ToUpper = 'P',
                         qryCadCar.FieldByName('CAR_PERDES').AsFloat,
                         (qryCadCar.FieldByName('CAR_PERDES').AsFloat /
                         (fStrToFloat(edtValCar.Text)/StrToIntDef(edtQtdPar.Text,1)) * 100));
        edtTotCar.Text := FloatToStrF(fCalculaValDocCartao(fStrToFloat(edtValCar.Text),
                                      fltPerDes),
                                      ffFixed, 12, 2);
      End;

      if (not (fRetTipoCartao(edtCodCar.Text) = 'C'))
      and FLiberadoCartCred then
      begin
        pRemoveLiberacao('PRDVCCCHP','001');
        FLiberadoCartCred := False;
        blnCartCreditoLiberado := False;
      end;

      if (not (fRetTipoCartao(edtCodCar.Text) = 'C'))
      and FLiberadoCartCredVencer then
      begin
        pRemoveLiberacao('DIRRCXRECDUPAVCCCH','001');
        FLiberadoCartCredVencer := False;
        blnCartCreditoAVencerLiberado := False;
      end;

    End;
  End

  Else If (Sender = edtQtdPar) And (edtQtdPar.Enabled) Then
  Begin
    fValidaCampos(edtCodCar, False);

    If (fEmptyStr(edtQtdPar.Text)) Then
    Begin
      pMensagem('ATENÇÃO!', 'A quantidade de parcelas deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (StrToIntDef(edtQtdPar.Text,0) <= 0) Then
    Begin
      pMensagem('ATENÇÃO!', 'A quantidade de parcelas deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End
    Else If fEmptyStr(strCodFin) And (qryCadCar.FieldByName('CAR_MAXPAR').AsInteger > 0) And
            (StrToIntDef(edtQtdPar.Text,0) > qryCadCar.FieldByName('CAR_MAXPAR').AsInteger) Then
    Begin
      pMensagem('ATENÇÃO!', 'A quantidade de parcelas deve ser menor ou igual a ' + qryCadCar.FieldByName('CAR_MAXPAR').AsString + '!', ['&Ok']);
      Result := False;
    End
    Else If (fEmptyStr(strCodFin)) And (qryCadCar.FieldByName('CAR_SUGPAR').AsInteger > 0) And
            (StrToIntDef(edtQtdPar.Text,0) < qryCadCar.FieldByName('CAR_SUGPAR').AsInteger) Then
    Begin
      pMensagem('ATENÇÃO!', 'A quantidade de parcelas deve ser maior ou igual a ' + qryCadCar.FieldByName('CAR_SUGPAR').AsString + '!', ['&Ok']);
      Result := False;
    End
    Else If fTravarQuantidadeNegociada And (intQtdNeg < StrToIntDef(edtQtdPar.Text,0)) Then
    Begin
      if blnTipPOS then
      begin
        pMensagem('ATENÇÃO!', 'A quantidade de parcelas não pode ser maior que a quantidade negociada (' + IntToStr(intQtdNeg) + ')!', ['&OK']);
        Result := False;
      end
      else
        blnQtdeParcTefDifNegociada := True;
    End
    {**********************************************************}
    {* SE FOR MAIS DE UMA PARCELA E O VALOR MÍNIMO DA PARCELA *}
    {* FOI ULTRAPASSADO, PEDE SENHA PARA LIBERAÇÃO            *}
    {*******************************************************RV*}
    Else If (Not blnLibMinParc) And fEmptyStr(strCodFin) And (StrToIntDef(edtQtdPar.Text,0) > 1) And ((fStrToFloat(edtValCar.Text) / StrToIntDef(edtQtdPar.Text,0)) < qryCadCar.FieldByName('CAR_PARMIN').AsFloat) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Valor da Parcela Menor que o Valor Mínimo');
      objLiberacao.objMsgLibera.pAddTextoCaption('Valor do documento'        , FormatFloat('#,##0.00', fStrToFloat(edtValCar.Text))                                   , 23);
      objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade de parcelas.: ' , edtQtdPar.Text                                                                         , 23);
      objLiberacao.objMsgLibera.pAddTextoCaption('Valor da parcela.......: ' , FormatFloat('#,##0.00', (fStrToFloat(edtValCar.Text) / StrToIntDef(edtQtdPar.Text,0))) , 23);
      objLiberacao.objMsgLibera.pAddTextoCaption('Valor mínimo permitido.: ' , FormatFloat('#,##0.00', qryCadCar.FieldByName('CAR_PARMIN').AsFloat)                   , 23);

      strCodOpe := strLoginUsuarioLogado;

      objLiberacao.strDirAce := 'PARMIN';
      objLiberacao.strMsgSen := 'Valor da Parcela Menor que o Valor Mínimo';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;
      objLiberacao.strOperador := strCodOpe;


      Result := objLiberacao.fLibera;

      blnLibMinParc := Result;
    End
    Else If fEmptyStr(strCodFin) And (StrToIntDef(edtQtdPar.Text,0) > fCfgSis('PARCAR', varInteger)) Then
    Begin
      pMensagem('ATENÇÃO!', 'A quantidade de parcelas deve ser menor ou igual a ' + fCfgSis('PARCAR') + '!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pTrataCndTef ;
      mskCndPag.Text    := fRetornaCndPagPeriod(StrToIntDef(edtQtdPar.Text,0),
                                                ifThen(FintPriVenc = -1, qryGenCar.FieldByName('CAR_PERIOD').AsInteger, FintPeriod),
                                                qryGenCar.FieldByName('CAR_EXCDIA').AsInteger,
                                                FintPriVenc);
      mskCndPag.Enabled := False;
    End;

  End

  Else If (Sender = mskCndPag) And (mskCndPag.Enabled) Then
  Begin

    If (fEmptyStr(mskCndPag.Text)) Then
    Begin
      pMensagem('', 'A condição de pagamento deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (Not fValidaCndPag(mskCndPag.Text)) Then
    Begin
      pMensagem('', 'Essa condição de pagamento não é valida!', ['&Ok']);
      Result := False;
    End;

  End
  Else If (Sender = edtNumNsu) Then
  Begin

    If ((VS_strUsaTef = 'N') Or blnTipPOS) Then
    Begin
      If (fEmptyStr(edtNumNsu.Text)) And (blnObrNSU) Then
      Begin
        pMensagem('', 'O número do cupom (NSU) deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If fCfgSis('VALNSU', VarBoolean) Then
      Begin
        If Length(edtNumNsu.Text) < 14 Then
        Begin
          pMensagem('','O número do cupom deve ter 14 caracteres!', ['&Ok']);
          Result := False;
        End;
      End;

    End;
  End

  Else If (Sender = edtNumNsuCon) And (edtNumNsuCon.Visible) Then
  Begin

    If (fEmptyStr(edtNumNsuCon.Text)) And (blnObrNSU) Then
    Begin
      pMensagem('', 'O número do cupom (NSU) deve ser confirmado!', ['&Ok']);
      Result := False;
    End
    Else If edtNumNsuCon.Text <> edtNumNsu.Text Then
    Begin
      pMensagem('','Valor informado diferente do número do cupom!', ['&Ok']);
      edtNumNsu.Clear;
      Sender := edtNumNsu;
      edtNumNsuCon.Clear;
      Result := False;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

function TfrmRcxDigCartoes.fVerificaCamposCartao: Boolean;
begin
  strUltMsgCamposCartao := '';
  Result := fVerificaCampos;
end;

procedure TfrmRcxDigCartoes.mskCndPagKeyPress(Sender: TObject; var Key: Char);
begin
  if (not blnPermiteDigitarDados) then
    Key := #0;
end;

procedure TfrmRcxDigCartoes.pAddDupVencidas;
var
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
begin
  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'DOCUMENTO'     , 16 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'EMP'           , 3  , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'CLIENTE'       , 40 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'ESPÉCIE'       , 7  , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DT. CAD.'      , 10 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DT. VENC.'     , 10 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'VR. ORIGINAL'  , 15 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'VR. DUPLICATA' , 15 , alDireita  , teAutcom);
  objTabela.lstLinhas.Add(objLinha);

  With CdsTemp Do
  Begin
    First;
    While Not Eof Do
    Begin

      If (FieldByName('CTR_MARDES').AsString = 'M') And (FieldByName('CTR_DTAVEN').AsDateTime < VS_Date) Then
      Begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('DOCUMENTO'     , FieldByName('CTR_DUPPAR').AsString                                , 16 , alEsquerda );
        objLinha.pAddColuna('EMP'           , FieldByName('CTR_CODEMP').AsString                                , 3  , alCentro   );
        objLinha.pAddColuna('CLIENTE'       , FieldByName('CTR_NOMCLI').AsString                                , 40 , alEsquerda );
        objLinha.pAddColuna('ESPÉCIE'       , FieldByName('CTR_ESPDOC').AsString                                , 7  , alCentro   );
        objLinha.pAddColuna('DT. CAD.'      , FormatDatetime('dd/mm/yyyy',FieldByName('CTR_DTACAD').AsDatetime) , 10 , alCentro   );
        objLinha.pAddColuna('DT. VEN.'      , FormatDatetime('dd/mm/yyyy',FieldByName('CTR_DTAVEN').AsDatetime) , 10 , alCentro   );
        objLinha.pAddColuna('VR. ORIGINAL'  , FormatFloat('###,##0.00', FieldByName('CTR_VALORI').AsFloat)      , 15 , alDireita  );
        objLinha.pAddColuna('VR. DUPLICATA' , FormatFloat('###,##0.00', FieldByName('CTR_VALDUP').AsFloat)      , 15 , alDireita  );
        objTabela.lstLinhas.Add(objLinha);


      End;
      Next;
    End;
  End;

  FLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
  FLiberacao.objMsgLibera.pAddQuebra;

end;

procedure TfrmRcxDigCartoes.pBloqueiaContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  if (not blnPermiteDigitarDados) then
    Handled := True;
end;

procedure TfrmRcxDigCartoes.pAcertaNumDocTraDoc;
var
  LintCnt: Integer ;
begin
  if not Assigned(arrDocCartoes) then
    Exit ;

  if Length(arrDocCartoes) = 0 then
    Exit ;

  for LintCnt := Low(arrDocCartoes) to High(arrDocCartoes) do
  begin
    arrDocCartoes[LintCnt].NumDoc := strNumDoc ;
  end ;
end;

procedure TfrmRcxDigCartoes.pAddDupAVencer;
var
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
begin
  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'DOCUMENTO'     , 16 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'EMP'           , 3  , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'CLIENTE'       , 40 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'ESPÉCIE'       , 7  , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DT. CAD.'      , 10 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DT. VENC.'     , 10 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'VR. ORIGINAL'  , 15 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'VR. DUPLICATA' , 15 , alDireita  , teAutcom);
  objTabela.lstLinhas.Add(objLinha);

  With CdsTemp Do
  Begin
    First;
    While Not Eof Do
    Begin

      If (FieldByName('CTR_MARDES').AsString = 'M') And (FieldByName('CTR_DTAVEN').AsDateTime > VS_Date) Then
      Begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('DOCUMENTO'     , FieldByName('CTR_DUPPAR').AsString                                , 16 , alEsquerda );
        objLinha.pAddColuna('EMP'           , FieldByName('CTR_CODEMP').AsString                                , 3  , alCentro   );
        objLinha.pAddColuna('CLIENTE'       , FieldByName('CTR_NOMCLI').AsString                                , 40 , alEsquerda );
        objLinha.pAddColuna('ESPÉCIE'       , FieldByName('CTR_ESPDOC').AsString                                , 7  , alCentro   );
        objLinha.pAddColuna('DT. CAD.'      , FormatDatetime('dd/mm/yyyy',FieldByName('CTR_DTACAD').AsDatetime) , 10 , alCentro   );
        objLinha.pAddColuna('DT. VEN.'      , FormatDatetime('dd/mm/yyyy',FieldByName('CTR_DTAVEN').AsDatetime) , 10 , alCentro   );
        objLinha.pAddColuna('VR. ORIGINAL'  , FormatFloat('###,##0.00', FieldByName('CTR_VALORI').AsFloat)      , 15 , alDireita  );
        objLinha.pAddColuna('VR. DUPLICATA' , FormatFloat('###,##0.00', FieldByName('CTR_VALDUP').AsFloat)      , 15 , alDireita  );
        objTabela.lstLinhas.Add(objLinha);


      End;
      Next;
    End;
  End;

  FLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
  FLiberacao.objMsgLibera.pAddQuebra;

end;

procedure TfrmRcxDigCartoes.edtCodCarExit(Sender: TObject);
begin
  inherited;
  if blnPermiteDigitarDados then
    fValidaCampos(edtCodCar,True);
end;

procedure TfrmRcxDigCartoes.edtCodCarKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCartao : TConsultasArray;

begin
  inherited;
  If edtCodCar.ReadOnly Then
    Exit;

  if (not blnPermiteDigitarDados) then
  begin
    Key := #0;
    Exit;
  end;

  {*****************************}
  {* NOVA CONSULTA DE CARTOES  *}
  {**************************DP*}
  If fPesqCartao(Self, edtCodCar, edtDesCar, Nil, Key, arrCartao, True, True) Then
  Begin
      If (fValidaCampos(edtCodCar, True)) Then
        Self.SelectNext(ActiveControl, True, True);
    pCarregaCartao;
  End;

end;

procedure TfrmRcxDigCartoes.edtNumCcdKeyPress(Sender: TObject; var Key: Char);
begin
  if (not blnPermiteDigitarDados) then
    Key := #0;
end;

procedure TfrmRcxDigCartoes.edtNumNsuConKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not blnPermiteDigitarDados) then
    Key := #0;
end;

procedure TfrmRcxDigCartoes.edtNumNsuKeyPress(Sender: TObject; var Key: Char);
begin
  if (not blnPermiteDigitarDados) then
    Key := #0;
end;

procedure TfrmRcxDigCartoes.edtObsCarKeyPress(Sender: TObject; var Key: Char);
begin
  if (not blnPermiteDigitarDados) then
    Key := #0;
end;

procedure TfrmRcxDigCartoes.edtQtdParChange(Sender: TObject);
begin
  inherited;
  blnLibMinParc := False;
end;

procedure TfrmRcxDigCartoes.edtQtdParKeyPress(Sender: TObject; var Key: Char);
begin
  if (not blnPermiteDigitarDados) then
    Key := #0;
end;

procedure TfrmRcxDigCartoes.edtValCarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If blnRealizandoTEF Then
    Key := #0;
end;

procedure TfrmRcxDigCartoes.pExecutarSemTela;
begin
  OnFormShow(nil);
  If fValidaCampos(edtValCar, True) Then
    fConfirmarDados;
end;

procedure TfrmRcxDigCartoes.pCancelarTefDeCartoesJaConfirmados(AobjTefRecebimento: ITefRecebimento; AarrCartoes: TCartoesResumoCaixaArray);
  Var
    Lcartao: TCartoesResumoCaixa;
begin
  if (VS_blnTefCitel) then
  begin
    pGaranteCancelamentoTefCitel(ArrCartoes);
  end
  else
  begin
    For Lcartao In AarrCartoes Do
    Begin
      If (FileExists(Lcartao.strArqTef)) Then
      Begin
        pGarantirCancelamentoTefRecebimento(AobjTefRecebimento, Lcartao.strArqTef);
      End;

    End;
  end;
end;

procedure TfrmRcxDigCartoes.pCarregaCartao;
begin
  pPesquisaCadCar(qryCadCar, qryGenCar, edtCodCar.Text);

  With qryGenCar Do
  Begin
    edtDesCar.Text := FieldByName('CAR_DESCAR').AsString;
    fltPerDes      := FieldByName('CAR_PERDES').AsFloat;

    If (intQtdPar <= 0) Then
    Begin
      If Not fEmptyStr(FieldByName('CAR_SUGPAR').AsString) Then
        edtQtdPar.Text := FieldByName('CAR_SUGPAR').AsString
      Else
        edtQtdPar.Text := EmptyStr;
    End;
  End;

  If fTravarQuantidadeNegociada Then
    edtQtdPar.Text := IntToStr(intQtdNeg);
end;

function TfrmRcxDigCartoes.fCodigoCartaoSomenteLeitura: boolean;
begin
  Result := False ;

  if fVerificaAcessoSistema('F11ALTCAR', strLoginUsuarioLogado) then
    Exit ;

  if (strOpcDoc <> 'AD') and (strOpcDoc <> 'RX') then
    Exit ;

  if fEmptyStr(edtCodCar.Text) then
    Exit ;

  Result := True ;

end;

procedure TfrmRcxDigCartoes.pGarantirCancelamentoTefRecebimento(AobjTefRecebimento: ITefRecebimento; AstrArquivo: String);
begin
  If Not FileExists( AstrArquivo ) Then
    Exit;

  While (Not AobjTefRecebimento.fCancelarRecebimento(AstrArquivo)) Do
  Begin
    Application.ProcessMessages;
  End;
end;

procedure TfrmRcxDigCartoes.pPrepararEdits;
begin
  edtValCar.Enabled := True;
  edtNumCcd.Clear;
  edtNumNsu.Clear;
  edtNumNsuCon.Clear;
  edtCodCar.Clear;
  edtDesCar.Clear;
  edtQtdPar.Clear;
  edtTotCar.Clear;
  mskCndPag.Clear;
  edtObsCar.Clear;
end;

procedure TfrmRcxDigCartoes.pReadOnlyNsuNumeroLiberacaoTefF11(const AstrNsu,
  AstrCcd: String);
begin

  if strOpcDoc <> '11' then
    Exit ;

  if blnTipPOS then
    Exit ;

  if AstrNsu = '00000000000000' then
    edtNumNsu.ReadOnly := False
  else
    edtNumNsu.ReadOnly := True ;

  if fEmptyStr(AstrCcd) then
    edtNumCcd.ReadOnly := False
  else
    edtNumCcd.ReadOnly := True ;
end;

procedure TfrmRcxDigCartoes.pSetaContextPopup;
begin
  edtNumCcd.OnContextPopup := pBloqueiaContextPopup;
  edtNumNsu.OnContextPopup := pBloqueiaContextPopup;
  edtNumNsuCon.OnContextPopup := pBloqueiaContextPopup;
  edtCodCar.OnContextPopup := pBloqueiaContextPopup;
  edtQtdPar.OnContextPopup := pBloqueiaContextPopup;
  edtObsCar.OnContextPopup := pBloqueiaContextPopup;
  TEditFocus(mskCndPag).OnContextPopup := pBloqueiaContextPopup;
end;

procedure TfrmRcxDigCartoes.pTrataCndTef;
begin
  if Assigned(RetornoTEFCitel) then
  begin
    FintPriVenc := RetornoTEFCitel.DadosCartao.intPrimeiroVencimento ;
    FintPeriod := RetornoTEFCitel.DadosCartao.intPeriodo ;
  end ;
end;

function TfrmRcxDigCartoes.ValidaAcessoAosPortadoresDeCartao: Boolean;
begin
  Result := True;

  If fCfgSis('DACPOR', varBoolean) Then
  Begin
    If Pos(qryGenCar.FieldByName('CAR_PORBAI').AsString, strPortadoresOperador) <= 0 Then
      Result := qryGenCar.FieldByName('CAR_PORBAI').AsString.IsEmpty;

    If Result Then
    Begin
      If Pos(qryGenCar.FieldByName('CAR_PORTAX').AsString, strPortadoresOperador) <= 0 Then
        Result := qryGenCar.FieldByName('CAR_PORTAX').AsString.IsEmpty;

      If Result Then
      Begin
        If Pos(qryGenCar.FieldByName('CAR_PORBAD').AsString, strPortadoresOperador) <= 0 Then
          Result := qryGenCar.FieldByName('CAR_PORBAD').AsString.IsEmpty;
      End;
    End;
  End;
End;

procedure TfrmRcxDigCartoes.FormShow(Sender: TObject);
begin
  inherited;
  Self.OnFormShow(Sender);
end;

procedure TfrmRcxDigCartoes.OnFormShow(Sender: TObject);
begin
  pSetFocus(edtValCar);
  qryGenCar := fCriaQuery(Self);

  qryGenCar := qryCadCar;

  mskDtaTra.Date := VS_Date;

  If (blnHabComp) Then
  Begin
    edtTotDig.Text := FloatToStrF(fltTotDig, ffFixed, 12, 2);
    edtTotGer.Text := FloatToStrF(fltTotGer, ffFixed, 12, 2);
    edtValCar.Text := FloatToStrF(fltMaxDig, ffFixed, 12, 2);
  End
  Else
    pSetFocus(edtNumCcd);

  edtNumCcd.Text := strNumCcd;
  If blnFulfillment Then
    edtNumNsu.Text := strNumNsu
  Else
    edtNumNsu.Text := IfThen(Not fEmptyStr(strNumNsu), fPadL(strNumNsu, 14, '0'), '');
  pReadOnlyNsuNumeroLiberacaoTefF11(fPadL(strNumNsu, 14, '0'), strNumCcd) ;

  If (Not fEmptyStr(strCodCar)) Then
  Begin
    edtCodCar.Text := strCodCar;
    pCarregaCartao;
    edtQtdPar.Text := IntToStr(intQtdPar);

    If fEmptyStr(strCodFin) Then
      fValidaCampos(edtQtdPar);
  End;

  If Not fEmptyStr(strCodFin) Then
  Begin
    lblNumLib.Caption := 'Número do Contrato:';

    If Not fEmptyStr(fRetNomeCartao(strCodCar)) Then
    Begin
      edtCodCar.ReadOnly := True;
      edtCodCar.TabStop  := False;
      fValidaCampos(edtCodCar, True);
    End;

    edtValCar.ReadOnly := True;
    edtValCar.TabStop  := False;

    edtValCar.ReadOnly := True;
    edtValCar.TabStop  := False;
    edtTotCar.ReadOnly := True;
    edtTotCar.TabStop  := False;

    edtQtdPar.ReadOnly := True;

    lblCndPag.Visible  := False;
    mskCndPag.Visible  := False;
    mskCndPag.ReadOnly := True;
    mskCndPag.TabStop  := False;

    mskCndPag.Text    := fRetornaCndPagPeriod(StrToIntDef(edtQtdPar.Text,0),
                                              qryGenCar.FieldByName('CAR_PERIOD').AsInteger,
                                              qryGenCar.FieldByName('CAR_EXCDIA').AsInteger);

    pSetFocus(edtNumCcd);
  End;

  If Not Assigned(objTefRecebimento) Then
    objTefRecebimento := TTefRecebimentoVazio.Create;

  blnConfirma := False;
  blnCartCreditoLiberado := False;
end;

procedure TfrmRcxDigCartoes.btnAjudaClick(Sender: TObject);
begin
  inherited;
  If Not TBitBtnLocked(Sender).Visible Then
    Exit;

  pCriarFormularios(TfrmRelAjudaMod, TForm(frmRelAjudaMod));
  frmRelAjudaMod.pAbreAjuda('frmCadMovCartoes', 'CUPONS_CARTOES');
  pFreeAndNil(frmRelAjudaMod);

  pSetFocus(edtValCar);
end;

procedure TfrmRcxDigCartoes.btnConfirmaClick(Sender: TObject);
begin
  If blnRealizandoTEF Then
    Exit;

  inherited;

  If fConfirmarDados Then
    Self.Close;
end;

function TfrmRcxDigCartoes.fChamaTelaDeOperacoes(out intQtdParc : Integer;
                                                 out intOperacao : Integer;
                                                     AobjDadosAdicionaisTefTra: IDadosAdicionaisTefTra) : IRetornoTEFCitel;
  var
    frmTefCitelOperacoes : TfrmTefCitelOperacoes;
begin
  pCriarFormularios(TfrmTefCitelOperacoes, frmTefCitelOperacoes);
  try
    objTefCitel.AdicionaObserver(frmTefCitelOperacoes);

    frmTefCitelOperacoes.fltValor                   := fStrToFloat(edtValCar.Text);
    frmTefCitelOperacoes.strNumDoc                  := strNumDoc;
    frmTefCitelOperacoes.strRcxCodOpe               := strRcxCodOpe;
    frmTefCitelOperacoes.objDadosAdicionaisTefTra   := AobjDadosAdicionaisTefTra ;
    frmTefCitelOperacoes.blnApenasDebito            := (fRetTipoCartao(edtCodCar.Text) = 'D');

    if fCfgSis('SOLCAR', varBoolean) then
    begin
      frmTefCitelOperacoes.objValidaParcelas        := TDadosValidaParcelasCartao
                                                       .New
                                                       .QtdNeg(intQtdNeg)
                                                       .CodFin(strCodFin);
    end;

    if frmTefCitelOperacoes.ShowModal = mrOk then
    begin
      Result      := frmTefCitelOperacoes.RetornoTEFCitel;
      intQtdParc  := frmTefCitelOperacoes.intQtdParcelas;
      intOperacao := frmTefCitelOperacoes.intOperacao;
      strModalidade := frmTefCitelOperacoes.strModalidade;
    end
    else
      Result := nil;
  Finally
    objTefCitel.RemoveObserver(frmTefCitelOperacoes);
    pFreeAndNil(frmTefCitelOperacoes);
  End;
end;

function TfrmRcxDigCartoes.fConfirmarDados(): Boolean;
begin

  optTrocoCar      := otNada;
  fltValorTrocoCar := 0.0;

  If (Not fVerificaCampos) Then
    Exit(False);

  {If fVerificaDuplicidade then
  Begin
    fMensagem('', 'Já existe um cartão com o mesmo número de liberação e data de cadastro para essa Empresa. Verifique!', ['&Ok']);
    pSetFocus(edtNumCcd);
    Exit;
  end;}

  fltValDig   := fStrToFloat(edtValCar.Text);
  fltValDes   := fStrToFloat(edtTotCar.Text);
  strNumNsu   := edtNumNsu.Text;
  dtaDatTra   := mskDtaTra.Date;

  blnConfirma := True;

  if Assigned(objTefCitelPagueFacil) then
    objTefCitelPagueFacil := nil;

  Result := blnConfirma;
end;

function TfrmRcxDigCartoes.fLiberarRecebCartCredito: Boolean;
begin
  try
    FLiberacao.Clear;
    FLiberacao.objMsgLibera.pAddTexto('');
    FLiberacao.objMsgLibera.pAddTexto('RECEBIMENTO DE DOCUMENTO VENCIDO COM CARTÃO DE CRÉDITO     ', alCentro   , teAutcom);
    FLiberacao.objMsgLibera.pAddQuebra;

    pAddDupVencidas;

    FLiberacao.strDirAce := 'PRDVCCCHP';
    FLiberacao.strSenLib := fCfgSis('RECVCD');
    FLiberacao.strMsgSen := 'Receb. doc. vencido c/ cartão de crédito';
    FLiberacao.strCodOpe := strLoginUsuarioLogado;
    FLiberacao.strCodDig := strLoginUsuarioLogado;
    FLiberacao.strCodIte := '001'; //Parametrizar a diferença no Log entre CC e CHQ.

    Result := FLiberacao.fLibera;

  except on E: Exception do
    begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmRcxDigCartoes.fLiberarRecebCartCredito]');
    end;
  end;
end;

function TfrmRcxDigCartoes.fLiberarRecebAVencerCartCredito: Boolean;
begin
  try
    FLiberacao.Clear;
    FLiberacao.objMsgLibera.pAddTexto('');
    FLiberacao.objMsgLibera.pAddTexto('RECEBIMENTO DE DOCUMENTO Á VENCER COM CARTÃO DE CRÉDITO     ', alCentro   , teAutcom);
    FLiberacao.objMsgLibera.pAddQuebra;

    pAddDupAVencer;

    FLiberacao.strDirAce := 'DIRRCXRECDUPAVCCCH';
    FLiberacao.strSenLib := fCfgSis('PERCCV');
    FLiberacao.strMsgSen := 'Receb. doc. á vencer c/ cartão de crédito';
    FLiberacao.strCodOpe := strLoginUsuarioLogado;
    FLiberacao.strCodDig := strLoginUsuarioLogado;
    FLiberacao.strCodIte := '001'; //Parametrizar a diferença no Log entre CC e CHQ.

    Result := FLiberacao.fLibera;

  except on E: Exception do
    begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmRcxDigCartoes.fLiberarRecebAVencerCartCredito]');
    end;
  end;
end;

procedure TfrmRcxDigCartoes.FormActivate(Sender: TObject);
begin
  inherited;
  blnSemMensagem := False; // No momento em que o form é ativado as mensagens voltam!
end;

procedure TfrmRcxDigCartoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  If blnRealizandoTEF Then
  Begin
    Action := caNone;
    Exit;
  End;

  inherited;

  If (Not blnConfirma) And (Not blnSairComEsc) Then
  Begin
    fMensagem('','A digitação dos cartões é obrigatória!', ['&Ok']);
    Action := caNone;
  End;

end;

procedure TfrmRcxDigCartoes.FormCreate(Sender: TObject);
begin
  blnRcxResumoCaixa := False;
  blnExecutandoPeloFaturamento := False;
  qryCadCar := fCriaQuery(Self);
  inherited;
  RetornoTEFCitel := Nil;
  FintPeriod := 0 ;
  FintPriVenc := -1 ;
  objLiberacao := TLiberacao.Create;
  blnHabComp    := True;
  blnTraVal     := False;
  blnTroCar     := False;
  strCodFin     := '';
  strArquivoTef := '';
  strArqViaCliente := '';
  strArqViaLojista := '';
  strUltMsgCamposCartao := '';

  blnFulfillment   := False;
  blnSairComEsc    := True;
  blnRealizandoTEF := False;
  blnF11           := False;
  blnTefRcx        := False;
  blnLibMinParc    := False;
  blnTipPOS        := True;
  blnSemMensagem   := False;
  blnCartCreditoLiberado := False;

  If Not fCfgSis('VALNSU', VarBoolean) Then
  Begin
    Self.Height := Self.Height - pnlConfirma.Height;
    pnlConfirma.Visible := False;
    edtNumNsuCon.Visible   := False;
  End
  Else
  Begin
    edtNumNsu.PasswordChar := '*';
    edtNumNsu.CompZeros    := False;
  End;

  strSessaoTef := '';
  SetLength(arrCartoes, 0);
  blnEhQuestFidelidade := False;
  blnEhGrynCash        := False;
  mskCndPag.EditMask := MASK_CONPAG;
  blnQtdeParcTefDifNegociada := False;

  //If (VS_blnTefCitel) Then
    //pIniciaTefCitel;
  cdsTemp := TUniClientDataSet.Create(Nil);
  strCodigoCarteiraDigital := '' ;
  strCodigoTipoOperacaoCartao := '';
  strCodigoBandeira := '';

  blnPermiteDigitarDados := True;

  pSetaContextPopup;
  arrDocCartoes := Nil ;
  FblnMultiLojaComAlgumaEmpresaTefDesligado := False ;
end;

procedure TfrmRcxDigCartoes.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  FreeAndNil(cdsTemp);
end;

procedure TfrmRcxDigCartoes.pGaranteCancelamentoTefCitel(AarrCartoes : TCartoesResumoCaixaArray);
var
  intContCartao : Integer;
begin
  for intContCartao := 0 to  Length(AarrCartoes) - 1 do
  begin
    if fVerificaUtilizouTEFCitel(AarrCartoes[intContCartao].strViaCli, AarrCartoes[intContCartao].strViaLoj) then
    begin
      if AarrCartoes[intContCartao].strStatusCartao = 'P' then
      begin
        pEstornaTransacaoPendente(False,
                                  AarrCartoes[intContCartao].strDtaTra,
                                  AarrCartoes[intContCartao].strHraTra,
                                  AarrCartoes[intContCartao].strNumDoc,
                                  '');

        AarrCartoes[intContCartao].strStatusCartao := 'C';

        pGravaTransacaoEstornada(AarrCartoes[intContCartao].strNumDoc,
                                 AarrCartoes[intContCartao].strNumNsu,
                                 AarrCartoes[intContCartao].strDtaTra,
                                 AarrCartoes[intContCartao].strHraTra,
                                 '',
                                 '',
                                 AarrCartoes[intContCartao].fltValDig,
                                 AarrCartoes[intContCartao].strControle);
      end
      else if fAutoConfirmaTransacaoPendenteEstaAtivada and
        (AarrCartoes[intContCartao].strStatusCartao = 'F') then
      begin
        if fCancelaTransacaoEfetivada(
          fAjustaIdentificadorEstornoTef(AarrCartoes[intContCartao]),
          AarrCartoes[intContCartao].fltValDig,
          AarrCartoes[intContCartao].strDtaTra,
          AarrCartoes[intContCartao].strCodigoCarteiraDigital,
          AarrCartoes[intContCartao].strCodigoTipoOperacaoCartao,
          AarrCartoes[intContCartao].strCodigoBandeira) then
        begin
          AarrCartoes[intContCartao].strStatusCartao := 'C';
        end;
      end;
    end;
  end;
end;

end.

