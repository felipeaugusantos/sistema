unit untEstornoReceber;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  EditFocus, Grids, DBGridCitel, DBGrids, DB, StrUtils, Menus, Uni, AppEvnts,
  untCadChq, UniDataSetProvider, UniClientDataSet, BitBtnLockedIncrem, MemDS,
  DBAccess, Provider, frxClass, frxExportCSVTestabilidade, Datasnap.DBClient,
  untTCadRec, untTCadRecRepository, System.Generics.Collections, untTMovCar,
  untTMovCarRepository, untTBanCTP, untLogBan, untLiberacao, untMsgLiberacao,
  untTLock, Aurelius.Types.Nullable, untFechamentoFinanceiro, untRcxTResumoDeCaixa,
  FulFillment.Classes, untTFuncoesPixAutcom, System.DateUtils,
  untCtrSelecionaTipoEstornoPix, untBaixaAnalitica, untTLogMpx, untLogMovCtr;

type
  TfrmEstornoReceber = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    edtNumDup: TEditFocus;
    Label5: TLabel;
    Label1: TLabel;
    edtCodEmp: TEditFocus;
    Label2: TLabel;
    edtEspDoc: TEditFocus;
    Label3: TLabel;
    edtCodCli: TEditFocus;
    pnlDados: TPanel;
    dbgDuplicatas: TDBGridCitel;
    edtParcel: TEditFocus;
    pnlBotoesEstorno: TPanel;
    btnConfirma: TBitBtnLocked;
    btnSairEst: TBitBtnLocked;
    edtNomCli: TEditFocus;
    edtNomEmp: TEditFocus;
    dtsDados: TDataSource;
    cdsDados: TUniClientDataSet;
    cpvDados: TUniDataSetProvider;
    qryDados: TUniQuery;
    btnConsultar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure dbgDuplicatasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgDuplicatasDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnSairEstClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtCodCliExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtNumDupExit(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }

    intConfirma: Integer;
    strMotEst: String;
    LHistComplementar : String;
    qryConEmp: TUniQuery;
    qryConCli: TUniQuery;
    qryMsgCli: TUniQuery;

    strSeqCon : String;
    strDocsNaoEnc  : String;
    blnFecharForm  : Boolean;
    LCaixaDoDiaFechado : Boolean;
    stlConjugadas  : TStringList;
    blnEstDtaDoc   : Boolean;
    blnDocumentosOk: Boolean;
    objLiberacao : TLiberacao;
    objLock: TLock;
    AClientesMarcados: TStringList;
    objFechamento: TFechamentoFinanceiro;

    blnFechadoCaixa: Boolean;

    FobjFulFillmentLogBuilder : TFulFillmentLogBuilder;

    FRealizarDevolucaoDoPix,
    FSolicitarDevolucaoPix,
    FGerarCreditoDevolucaoPix,
    FGerouCreditoPix: Boolean;

    FPortadorCredito,
    FEventoCredito,
    FRecebidoPorPix: String;

    FRegistroMovPix: TUniClientDataSet;

    FSeqconCCCanceladoADT: Integer;

    FUtilizaContabilidadeERecebidoPorAdiantamento: Boolean;

    FValorTotalPix: Double;

    procedure pLimpaCampos;
    procedure pCarregaEmpresa;
    procedure pCarregaCliente;

    function fTemLinkPagamento: Boolean;

    function fValidaEstornoAdiantamento(cdsSeqCon: TUniClientDataSet; Var strMsg: String): Boolean;

    procedure pMarcaDuplicata(strMarDes: String);
    procedure pConfirmaEstornoInterno;
    function fDocsBaixaComLCK: Boolean;

    function DeveGravarMovBan(ADataset: TDataset): Boolean;
    function PossuiFaturamentoDoPedidoAntesDoRecebimentoDoBoletoAdiantamento(Adataset: TDataset): Boolean;

    Procedure pEstornaDuplicataSimples(cdsAux: TUniClientDataSet);
    Procedure pEstornaDuplicataParcial(cdsAux: TUniClientDataSet);
    Procedure pEstornaContasAPagar(const strAutCtp: String; dtaEstorn: TDate);
    function fEstornaDuplicataConjugadas(oleDados: OleVariant; strPorBai: String): Boolean;
    procedure pEstornaAdiantamentoCliente(cdsAux: TUniClientDataSet);

    function fPossuiTransferenciaAutomaticaAtiva(ADadosDuplicata: OleVariant): Boolean;

    procedure LacarEstornoAnalíticoCaixaLancamentoZerado(ASeqcon: Integer;
                                                         AEmpresaBaixa: String;
                                                         ADataRecebimento: TDateTime);

    function RetornaValorCreditoDaBaixa(ASeqcon: Integer;
                                        AEmpresaBaixa: String;
                                        ADataRecebimento: TDateTime): Double;

    function fApagarDuplicatasFinanciamento(strEspDoc, strNumDoc, strCliFor, strCodEmp: String; Var strDuplicatas: String): Boolean;

    Function fHouveTransferenciaCartao(intSeqCon: Integer; strEmpRcx: String; dtaDtaCad: TDateTime;blnNaoTransf:Boolean = False): Boolean;
    Function fHouveTransferenciaCheque(intSeqCon: Integer; strEmpRcx: String; dtaDtaCad: TDateTime;blnNaoTransf:Boolean = False): Boolean;
    Function fEstornaMovCar(intSeqCon: Integer; strEmpRcx: String; dtaDtaRec: TDateTime): Boolean;
    function fEstornaCheque(intSeqCon: Integer; strEmpRcx, strTipChq: String; dtaDtaRec: TDateTime): Boolean;

    function fVerificaDuplicataPrincipal: Boolean;

    function fVerSeqBai(strNumDup, strEspDoc, strParcel, strCodEmp, strCodCli: String): Boolean;

    function fVerificaDocumentosBaixados(intSeqCon: Integer; strEmpRcx: String; dtaDtaCad: TDateTime;
                                         ANumDup,AParcel,AEspDoc,ACodEmp,ACodCli,AAdtCli: String): Boolean;

    function fPedePortador(Var strPorBai: String): Boolean;
    function fPedePortadorCaixa(Var strPorBai: String): Boolean;

    function ValidaTransferenciasLiberadas(ASequencialBaixa,
                                           AEmpresaBaixa: String): Boolean;

    procedure pApagaChequeCartao(strSeqCon, strEmpRcx: String; dtaDtaRec: TDateTime; fltValCar, fltChqVis, fltChqPre, fltValFin: Double);

    function ValorPixJaDevolvidoNoBanco(ARegistroPix: TDataSet; AValidaQuantidade: Boolean = True): Boolean;
    procedure SolicitarDevolucaoDoPix(ARegistroPix: TUniClientDataSet);
    procedure ApagaRegistroPix(ASeqCon: Integer; AEmpresaLancamento: String; ADataRecebimento: TDateTime);

    procedure pEstornarLancamentoCreditoCaixa(strNumDup, strParcel, strCodEmp, strEspDoc, strCodCli, strPorBaiSelecionado: String; intSeqBai: Integer; oleDados: OleVariant; dtaEstorn, dtaDtaRec: TDate);
    procedure pDeterminaModEstornoRcx(intSeqCon: Integer; strEmpBai: String; dtaDtaCad: TDateTime; Var fltValDin, fltValCar, fltChqVis, fltChqPre, fltOrdRec, fltValFin, fltValDoc, fltTotGua, fltTotDol, fltTotEur, fltTotPes, fltTotRea: Double; var ARecPix: String);
    function fVerificaDatasDiferentes(ACliente: TStringList; intSeqCon: Integer; strEmpRcx: String; dtaDtaBai: TDateTime): Boolean;
    function fVerConfirmada(strNumDup, strEspDoc, strParcel, strCodEmp, strCodCli: String): Boolean;
    function fPrincipalConfirmadaNoMesmoCadastro(const ANumeroDuplicata, AEspecie, AParcela, AEmpresa,
      ACliente: String; const ADataCadastro: TDateTime): Boolean;

    procedure pRealizaLCDocumentosTransferidos(intSeqConEstorno: Integer; strCodEmpEstorno: String; dtaDtaCad: TDateTime; AOperadorCaixa: String);
    function fLancaLCTransferidos(fltTotalChqVis, fltTotalChqPre,
      fltTotalCartao: Double; strHistorico: String; AOperadorCaixa: String): Boolean;
    procedure pLogChq(qryLog: TUniQuery);
    function fDupJaEstornada(strNumDup, strParcel, strSeqBai, strCodEmp, strEspDoc, strCodCli: String): Boolean;
    function fAdtJaEstornado(strAutInc: String): Boolean;
    function fBloquearEstornoPedidoJaFaturado(strNumDoc, strEspDoc, strCodCli, strCodEmp: String): Boolean;
    function fGetMsgEstorno(strNumDup, strSeqBai, strEspDoc, strCodEmp: String;
      dtaDtaRec: TDateTime; fltValRec: Double): String;
    function fCreditoUtilizado(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli: String;
                               intSeqBai, intSeqCon: Integer): Boolean;

    procedure pRemoveLiberacaoDoctoParaExpedicaoAutomatico(strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel: String);
    function  fPodeRemoverLiberaracaoDoctoParaExpedicaoAutomatico(strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel: String): Boolean;
    procedure pMarcaDoctoComoNaoLiberadoParaExpedicao(strNumDup, strEspDoc, strCodEmp, strCodCli: String);
    function fVerificaBaixaVinculadaCartoesChequesNaoTransferidos(dtaFechCai,dtaBaixa:TDateTime;intSeqCon:Integer;strEmpBai:String) : Boolean;
    function fSaldoCaixaSuficiente(intSeqCon: Integer; strEmpBai: String; dtaDtaBai: TDateTime; ARecebidoPorPix: Boolean): Boolean;
    function fLockedByCurrentConnection(strChaLck: String): Boolean;
    function fDocumentoFaturado(oleDados: OleVariant): Boolean;
    function fBuscaDataEstornoSintetica(strNumDup : String = '';
                                        strCodCli : String = '';
                                        strCodEmp : String = '';
                                        strParcel : String = '';
                                        strEspDoc : String = ''): TDateTime;
    function fTemDuplicataOrigemConverte : Boolean;

    function ValidarDuplicatasComBaixaParcial(out ADuplicatasBaixadas: String): Boolean;

    procedure pEmitirMensagem(AstrTitulo, AstrMensagem : String; AblnEhLogDeErro : Boolean = False; AblnMostarViaMemo : Boolean = False;
      AblMensagemDentroDeRaise : Boolean = False);

    function fPedidoAlpe: Boolean;
    procedure pVerificaDuplicatasRestantesDocumento;

    function DuplicataEmAbertoDaParcialPossuiChavePix(ADatasetBaixa: TDataset): Boolean;
    function DuplicataCreditoEmAbertoPossuiChavePix(ADatasetBaixa: TDataset): Boolean;

    function ValidacoesDeRecebimentoPorPix(ARecebidoPorPix: Boolean): Boolean;
    function fRetornaValRecPix(ADataset: TDataset): Double ;
    function SolicitaDireitoDeAcessoDevolucaoPix(ADuplicatas: TUniClientDataset;
                                                 ATipoSolicitacao: String = ''): Boolean;
    function PossuiRegistroNaMovPix: Boolean;

    function GeracaoCreditoRecebimentoPix(ADataset: TDataset): Boolean;
    function GerarCreditoRecebimentoPix(ADataset: TDataset): Boolean;
    procedure SelecionaPortadorEventoGeracaoCredito(out ACodigoPortador,
                                                        ACodigoEvento: String);
    function RetornaComissoesDeAgrupamentos(ADatasetBaixa: TDataset): TUniQuery;
    function fVerificaExisteMovBanJurosDesc(strAutoIncrem: string): Boolean;
    function fEstornaMovbanJurosDescto(strAutoIncrem: string; dtaEstorn: TDate): Boolean;
    procedure pExcluiMovCtrEstornada(strAutoIncrem: string);
    function fEstornaMovbanJurosDesctoSintetico(strAutoIncrem, strPorBai, strCtaBai : string; dtaEstorn: TDate): Boolean;
    function fVerificaDuplicatasReceberTarifaBancaria(strAutInc: String): Boolean;
    procedure pEstornaContasAReceberTarifa(strAutInc: String; dtaEstorn: TDate);

    function RegistroCreditoAdiantamentoEstornado(ASequencialControle,
                                                  AEmpresaLancamento: String;
                                                  ADataLancamento: TDateTime): Boolean;

    function RetornaDataDoCaixaDosLancamentos(ADataAtualCaixa: TDateTime;
                                              ADatasetLancamentos: TDataset): TDateTime;

    function RetornaTipoMovimentacaoBancaria(AValorLancamento: Double): String;

    function DocumentoPossuiDevolucoes(ADataset: TDataset): Boolean;

    function FiltroPossuiBaixaDeDuplicatasComTotalEParcial(ADataset: TUniClientDataset): Integer;

    function DeveGravarMovimentacaoBancariaDoEstornoDeCreditoDoCaixa(AResumoDeCaixa: String;
                                                                     ASeqcon: Integer;
                                                                     ADatasetDuplicata: TDataset;
                                                                     ADataRecebimento: TDateTime): Boolean;
    function fCalculaFreteEstornaDuplicatasParcial(ACdsAux: TUniClientDataset): Double;
    function fMensagemEstornoNoMesmoDia(const strLanFec : String)  : String;
    function fLiberouTravaPeloCancelamentoComSenha(const strLanFec : String; var blnExibiuTrava : Boolean) : Boolean;
    function fGetLanFec(const ADataSetCaixa : TDataSet) : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnResCai : Boolean;    //VARIÁVEL INDICA SE ESSA TELA ESTÁ SENDO CHAMADA NO CAIXA
    strEstRec : String;
    dtaDtaRcx : TDateTime;
    blnEstornoAutomatico: Boolean;
    blnNotaDenegada : boolean;
    blnAlpe: Boolean; //INDICA SE O ESTORNO A SER FEITO É PROVENIENTE DE UM PEDIDO COM ADIANTAMENTO ALPE

    strCodigoCaixa  : String;
    objResumoDeCaixa: TResumoDeCaixa;
    blnEstornoDocLocEqu: Boolean;
    strNumDoc,
    strEspDoc,
    strCodCli,
    strCodOpe: String;

    procedure pSelecionaDuplicata;
    procedure pConfirmaEstorno;
    procedure pCriaTemporaria;
    procedure pFormShow;

    property objFulFillmentLogBuilder : TFulFillmentLogBuilder read FobjFulFillmentLogBuilder write FobjFulFillmentLogBuilder;
    property UtilizaContabilidadeERecebidoPorAdiantamento: Boolean read FUtilizaContabilidadeERecebidoPorAdiantamento write FUtilizaContabilidadeERecebidoPorAdiantamento Default False;
  end;


implementation

uses
  untAdiantamentoCliente, untFuncoes, untfuncoesSimples,
  untPesqAux, untConsultas, untConstantes,
  untDigPortador,  untMovBan, untCadRec, untCadRcxx,
  untBaixaReceber, untMemo, untSQLRepositorio, untTypesSistema, untFuncFat,
  untTCadChqRepository, untTBanCtrRepository, untEstornoPagar,
  untTCadPagRepository, untTCadPag, untTMovBanRepository, untTMovBan,
  untTBanCtpRepository, untTCadFor, untDigOcorrencia, untLogCtr,
  untFuncoesGenerica, untValidacoesSistemaDEPS, untAtualizaOcorrenciasCRM,
  untTypesCRM, untGravando, untFuncoesRel, untFuncoesRel2, Yapay.Api.Facade, untAlpe,
  untTPixDao, untObjectManager, untTiposPix, untTFuncoesAuxiliaresPix,
  untCancelamentoDocResumo, untLinkPagamentoCitelUtil, untPgtOnlineApi;

{$R *.dfm}

{ TfrmEstornoCtaReceber }

function TfrmEstornoReceber.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O NÚMERO DA DUPLICATA          *}
    {**************************************MV*}
    If (Sender = edtNumDup) Then
    Begin
      If fEmptyStr(edtNumDup.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Número da Duplicata deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If Length(fRetSomenteNumeros(edtNumDup.text)) = Length(edtNumDup.text) Then
          edtNumDup.Text := fStrZero(edtNumDup.Text, 12);
      End;
    End

    {****************************}
    {* VALIDA A PARCELA         *}
    {*************************MV*}
    Else If (Sender = edtParcel) Then
    Begin
      If fEmptyStr(edtParcel.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Parcela da Duplicata deve ser preenchida!', ['&O k']);
        Result := False;
      End;

      If Result Then
      Begin
        If fRetSomenteNumeros(edtNumDup.Text).Length = Length(edtNumDup.Text) Then
          edtNumDup.Text := fStrZero(edtNumDup.Text, 12);
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DA EMPRESA            *}
    {**************************************MV*}
    Else If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          pCarregaEmpresa;
          If qryConEmp.FieldByName('EMP_CODEMP').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
            Result := False;
          End;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA A ESPÉCIE                      *}
    {**************************************MV*}
    Else If (Sender = edtEspDoc) Then
    Begin
      If fEmptyStr(edtEspDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Espécie deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If Length(edtEspDoc.Text) <> 2 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Espécie deve ter exatamente 2 caracteres!', ['&O k']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO CLIENTE            *}
    {**************************************MV*}
    Else If (Sender = edtCodCli) Then
    Begin
      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Cliente deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaCliente;
        If qryConCli.FieldByName('CLI_CODCLI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&O k']);
          Result := False;
          pSetFocus(edtNumDup);
          pLimpaCampos;
          blnMudarFoco := False;
          Exit;
        End
      End;
    End
    Else If (Sender = btnConsultar) Then
    Begin
      if (not blnEstornoAutomatico) and (fPedidoAlpe) then //se não for um estorno automático, valida se é um pedido alpe
      begin
        fMensagem('ATENÇÃO!', 'Este pedido de venda possui adiantamento de recebíveis pela ALPE. '+
                              'Portanto o seu estorno é proibido e apenas o seu cancelamento é permitido!', ['&O k']);
        Result := False;
        Exit;
      end
      else
      If blnBuscaPorChave Then
      Begin
        If Not fVerificaCampos Then
        Begin
          blnMudarFoco := False;
          Exit;
        End;

        TfrmGravando.fExecutarModal(pCriaTemporaria, 'Aguarde... Carregando títulos.', '');
        if not cdsDados.IsEmpty then
        begin
          pSetFocus(dbgDuplicatas);
        end;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmEstornoReceber.fPedidoAlpe: Boolean;
begin
  Result := False;

  if TAlpe.fPedidoAlpe(edtNumDup.Text, edtEspDoc.Text, edtCodEmp.Text) then
    Result := True; //INDICA QUE É UM PEDIDO ALPE

end;

function TfrmEstornoReceber.fValidaEstornoAdiantamento(cdsSeqCon: TUniClientDataSet; Var strMsg: String): Boolean;
  Var
    qryAdiantamentos: TUniQuery;
    arrCreditos: TStringArray;
begin
  Try
    Result := True;

    qryAdiantamentos := fCriaQuery;

    If Not TAdiantamento.fCarregarAdiantamentos(edtNumDup.Text,
                                                edtEspDoc.Text,
                                                edtCodEmp.Text,
                                                edtCodCli.Text,
                                                qryAdiantamentos) Then
    Begin
      Exit;
    End;

    If TAdiantamento.fAdiantamentoPossuiDebitos(edtNumDup.Text,
                                                edtEspDoc.Text,
                                                edtCodEmp.Text,
                                                edtCodCli.Text) Then
    Begin
      strMsg := 'Não é possível estornar este adiantamento de cliente pois ' +
        'já existem lançamentos de débitos provenientes de Faturamento do ' +
        'Pedido ou Geração de Crédito do saldo do(s) adiantamento(s)!';
      Result := False;
      Exit;
    End;

    {****************************************************************************}
    {* DEVE SELECIONAR QUAL ADIANTAMENTO SERA ESTORNADO, CASO TENHA MAIS DE UM. *}
    {************************************************************************JC**}
    qryAdiantamentos.Filtered := False;
    qryAdiantamentos.Filter   := 'TIPLAN = ' + QuotedStr('D') + ' AND ESTORN <> ' + QuotedStr('S');
    qryAdiantamentos.Filtered := True;

    If Not qryAdiantamentos.IsEmpty Then
    Begin
      Result := Not TAdiantamento.fAdiantamentoPossuiCreditosBaixados(qryAdiantamentos.FieldByName('EMPLAN').AsString,
                                                                      qryAdiantamentos.FieldByName('SEQCON').AsInteger);
      If Not Result Then
      Begin
        strMsg := 'Não é possível estornar este adiantamento de cliente pois ' +
                  'existem créditos gerados já baixados. ';
        Exit;
      End;
    End;

    {****************************************************************************}
    {* DEVE SELECIONAR QUAL ADIANTAMENTO SERA ESTORNADO, CASO TENHA MAIS DE UM. *}
    {************************************************************************JC**}
    qryAdiantamentos.Filtered := False;
    qryAdiantamentos.Filter   := 'TIPLAN = ' + QuotedStr('C') + ' AND ESTORN <> ' + QuotedStr('S');
    qryAdiantamentos.Filtered := True;

    If (qryAdiantamentos.IsEmpty) and (not blnAlpe) Then
    Begin
      strMsg := 'Não é possível estornar este adiantamento de cliente pois ' +
        'todos os lançamentos já foram estornados!';
      Result := False;
      Exit;
    End
    Else
    If qryAdiantamentos.IsEmpty then
    begin
      strMsg := 'Pedido Alpe cancelado com sucesso!';
      Result := False;
      Exit;
    end;

    If blnRescai Then
    Begin
      If Not qryAdiantamentos.FieldByName('RESCAI').AsString.Equals('1') Then
      Begin
        strMsg := 'O adiantamento não pode ser estornado pelo Resumo de Caixa pois foi recebido pelo Controle Financeiro.' + #13 +
                  'Acesse o Estorno de Contas a Receber pelo Controle Financeiro.';
        Exit(False);
      End;
    End;

    If qryAdiantamentos.RecordCount > 1 Then
    Begin
      SetLength(arrCreditos, 0);

      qryAdiantamentos.First;

      While Not qryAdiantamentos.EOF Do
      Begin
        pAddDados(arrCreditos, 'Data: '  + qryAdiantamentos.FieldByName('DTALAN').AsString + ' ' +
                                           qryAdiantamentos.FieldByName('HORLAN').AsString + ' ' +
                               'Emp.: '  + qryAdiantamentos.FieldByName('EMPLAN').AsString + ' ' +
                               'Valor: ' + FormatFloat('#,##0.00', qryAdiantamentos.FieldByName('VALLAN').AsFloat));
        qryAdiantamentos.Next;
      End;

      qryAdiantamentos.RecNo := fGetMenu('Selecione o Adiantamento para estorno:', arrCreditos, 1);
    End;

    If Not TAdiantamento.fAdiantamentoPodeSerEstornadoPeloFinanceiro(qryAdiantamentos.FieldByName('NUMDOC').AsString,
                                                                     qryAdiantamentos.FieldByName('ESPDOC').AsString,
                                                                     qryAdiantamentos.FieldByName('CODEMP').AsString,
                                                                     qryAdiantamentos.FieldByName('CODCLI').AsString,
                                                                     fFormataFloat(qryAdiantamentos.FieldByName('VALLAN').AsFloat, 2)) Then
    Begin
      strMsg := 'Não é possível estornar este adiantamento de cliente pois ' +
                'não existe saldo suficiente!';
      Result := False;
      Exit;
    End;

    cdsSeqCon.Append;
    cdsSeqCon.FieldByName('CTR_SEQCON').AsString := qryAdiantamentos.FieldByName('SEQCON').AsString;
    cdsSeqCon.FieldByName('CTR_EMPBAI').AsString := qryAdiantamentos.FieldByName('EMPLAN').AsString;
    cdsSeqCon.FieldByName('CTR_DTABAI').AsString := qryAdiantamentos.FieldByName('DTALAN').AsString;

    If cdsSeqCon.FieldByName('CTR_CODCLI').AsString.IsEmpty Then
      cdsSeqCon.FieldByName('CTR_CODCLI').AsString := edtCodCLi.Text;

    cdsSeqCon.Post;
  Finally
    FreeAndNil(qryAdiantamentos);
  End;
end;

procedure TfrmEstornoReceber.pCarregaCliente;
var
strSQL: String;
begin
  pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text);
  With qryConCli Do
    edtNomCli.Text := FieldByName('CLI_NOMCLI').AsString;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CONCAT(CID_NOMCID,"-",CID_ESTADO) AS INFCID, ';
  strSQL := strSQL + '   C.* ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADCLI C ';
  strSQL := strSQL + '   INNER JOIN CADCID ON CID_CODCID = C.CLI_CODCID ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CLI_CODCLI = :CODCLI ';

  With qryMsgCli Do
  Begin
    Close;
    Sql.Clear;
    Sql.Add(strSQL);
    ParamByName('CODCLI').AsString := edtCodCli.Text;
    Open;
  End;


end;

procedure TfrmEstornoReceber.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  With qryConEmp Do
    edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
end;

{*****************************************}
{* CHAMA TELA DE ESTORNO                 *}
{**************************************MV*}
procedure TfrmEstornoReceber.pConfirmaEstorno;
Begin

  If InterlockedIncrement(intConfirma) = 0 Then
  Begin

    Try
      TfrmGravando.fExecutarModal(pConfirmaEstornoInterno, 'Aguarde... Estornando duplicatas.', '');
      InterlockedDecrement(intConfirma);
    Except
      On E: Exception Do
      Begin
        InterlockedDecrement(intConfirma);
        pMensagensErro(E.Message, 'TfrmEstornoReceber.pConfirmaEstorno');
      End;
    End;

  End
  Else
    InterlockedDecrement(intConfirma);

End;

procedure TfrmEstornoReceber.pConfirmaEstornoInterno;
  Var
    strPorBai: String;
    cdsAux: TUniClientDataSet;
    qryDup: TUniQuery;
    strNumDup, strFornec, strDtaCad, strDtaVen, strValDup: String;
    strCliente: String;
    intRecNo  : Integer;
    objTabela : TRegistroMsgLiberaTabela;
  	objLinha  : TLinhaMsgLibera;
    cdsDadosCaixa: TDataset;
    blnExibiuTravaCancelamentoNoDia : Boolean;
    fltDinheiro, fltCartao, fltOrdPag, fltCheqAv, fltCheqPre: Double;

    LCTPCOMAgrupadas,
    LMensagem: String;

    LComissaoAgrupamento: TUniQuery;

    LNumeroPedidoAdiantamento: String;
begin
  If (Not objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoFechamento(strCodigoCaixa), True, False)) Then
  Begin
    pEmitirMensagem('','Não será possível estornar recebimentos agora pois outra estação está realizando o fechamento do caixa!');

    Exit;
  End
  Else
    objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoFechamento(strCodigoCaixa), False);

  If (Not objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDaTransferencia(strCodigoCaixa), True, False)) Then
  Begin
    pEmitirMensagem('','Não será possível estornar recebimentos agora pois outra estação está realizando transferência!');

    pLimpaCampos;
    blnMudarFoco := False;

    Exit;
  End
  Else
    objLock.fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDaTransferencia(strCodigoCaixa), False);

  If Not fVerificaCampos Then
  Begin
    blnMudarFoco := False;
    Exit;
  End;

  cdsAux := TUniClientDataSet.Create(Self);
  cdsAux.Data := cdsDados.Data;

  Try

    {*********************}
    {* NÃO HÁ DUPLICATAS *}
    {******************AF*}
    If cdsDados.RecordCount = 0 Then
    Begin
      If Not blnEstornoDocLocEqu Then
        pEmitirMensagem('','Não há duplicatas a serem estornadas' + IIF(blnResCai,' ou não foi baixada pelo resumo de caixa!', '!'), True);

      pSetFocus(edtNumDup);
      pLimpaCampos;
      blnMudarFoco := False;
      Exit;
    End;

    cdsAux.Filter := 'CTR_MARDES = ' + QuotedStr('M');
    cdsAux.Filtered := True;

    LNumeroPedidoAdiantamento := EmptyStr;
    If Not blnEstornoAutomatico Then
    Begin
      If Not strEstRec.Equals('(Cancelamento de Documentos)') Then
        FUtilizaContabilidadeERecebidoPorAdiantamento :=
                      untCadRec.UtilizaContabilidadeERecebidoPorAdiantamento(LNumeroPedidoAdiantamento,
                                                                             cdsAux.FieldByName('NUMDUP').AsString,
                                                                             cdsAux.FieldByName('CTR_ESPDOC').AsString,
                                                                             cdsAux.FieldByName('CTR_CODEMP').AsString,
                                                                             cdsAux.FieldByName('CTR_CODCLI').AsString,
                                                                             cdsAux.FieldByName('PARDUP').AsString,
                                                                             cdsAux.FieldByName('CTR_SEQBAI').AsInteger);
    End;

    FRecebidoPorPix := 'N';
    If cdsAux.Locate('CTR_MARDES;CTR_RECPIX', VarArrayOf(['M', 'S']), []) Then
      FRecebidoPorPix := 'S';

    cdsAux.First;

    While Not cdsAux.Eof Do
    Begin
      If fFormataFloat(cdsAux.FieldByName('CTR_VALREC').AsFloat,2) > 0 Then
        Break;

      cdsAux.Next;
    End;

    intRecNo := cdsAux.RecNo;

    LComissaoAgrupamento := RetornaComissoesDeAgrupamentos(cdsAux);

    blnFecharForm := False;

    cdsAux.First;
    AClientesMarcados.Clear;
    While not cdsAux.Eof Do
    Begin
      AClientesMarcados.Add(cdsAux.FieldByName('CTR_CODCLI').AsString);
      blnFecharForm := blnFecharForm or ((cdsAux.FieldByName('CTR_RESCAI').AsInteger = 1) and LCaixaDoDiaFechado);

      cdsAux.Next;
    End;

    {**********************************}
    {* NÃO HÁ DUPLICATAS SELECIONADAS *}
    {*******************************AF*}
    If cdsAux.RecordCount = 0 Then
    Begin
      fMensagem('', 'Não há duplicatas selecionadas!', ['&Ok']);

      FreeAndNil(cdsAux);
      pSetFocus(dbgDuplicatas);
      blnMudarFoco := False;
      Exit;
    End;

    {*************************************************************************}
    {* VERIFICA SE O OPERADOR POSSUI PERMISSÃO DE ESTORNO DO CNTAS A RECEBER *}
    {* DIREITO => DIRRCXEST                                                  *}
    {**********************************************************************RL*}
    strCliente := qryMsgCli.FieldByName('CLI_CODCLI').AsString + ' - ' + qryMsgCli.FieldByName('CLI_NOMCLI').AsString;
    strCliente := AnsiReplaceStr(strCliente, chr(10), '');

    objLiberacao.Clear;
    If Not fEmptyStr(strEstRec) Then
      objLiberacao.objMsgLibera.pAddTexto('Estorno de Contas a Receber' + strEstRec)
    Else
      objLiberacao.objMsgLibera.pAddTexto('Estorno de Contas a Receber(Resumo de Caixa)');

    objLiberacao.objMsgLibera.pAddSeparador(116);

    With qryMsgCli Do
    Begin
      objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'   , strCliente                                                    , 17);
      objLiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ'  , fFormataCpfCgc(FieldByName('CLI_C_G_C_').AsString, fSetaPais) , 17);
      objLiberacao.objMsgLibera.pAddTextoCaption('Cidade/Uf' , FieldByName('INFCID').AsString                                , 17);
    End;

    objLiberacao.objMsgLibera.pAddTextoCaption('Operador da Baixa', cdsAux.FieldByName('CTR_OPEBAI').AsString                , 17);

    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'DUPLICATA'   , 21 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'DT.CAD.'     , 10 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'DT.VENCTO'   , 10 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'DT.RECTO'    , 10 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'VR.ORIGINAL' , 12 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'VR.RECEBIDO' , 12 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'JUROS'       , 12 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'DESCONTOS'   , 12 , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    fltDinheiro := 0;
    fltCartao   := 0;
    fltOrdPag   := 0;
    fltCheqAv   := 0;
    fltCheqPre  := 0;

    With cdsAux Do
    Begin
      First;
      While Not Eof Do
      Begin
        fltDinheiro := fltDinheiro + FieldByName('CTR_DINHEI').AsFloat;
        fltCartao   := fltCartao + FieldByName('CTR_CARTAO').AsFloat;
        fltOrdPag   := fltOrdPag + FieldByName('CTR_ORDPAG').AsFloat;
        fltCheqAv   := fltCheqAv + FieldByName('CTR_CHQAVI').AsFloat;
        fltCheqPre  := fltCheqPre + FieldByName('CTR_CHQPRE').AsFloat;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('DUPLICATA'   ,   fPadR(FieldByName('CTR_NUMDUP').AsString, 12) + '-'
                                            + fPadR(FieldByName('PARDUP').AsString, 1)      + '-'
                                            + fPadR(FieldByName('CTR_ESPDOC').AsString, 2)  + '-'
                                            + FieldByName('CTR_CODEMP').AsString                                 , 21 , alEsquerda);
        objLinha.pAddColuna('DT.CAD.'      ,  FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTACAD').AsDateTime) , 10 , alEsquerda);
        objLinha.pAddColuna('DT.VENCTO'    ,  FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTAVEN').AsDateTime) , 10 , alEsquerda);
        objLinha.pAddColuna('DT.RECTO'     ,  FormatDateTime('dd/mm/yyyy', FieldByName('CTR_DTAREC').AsDateTime) , 10 , alEsquerda);
        objLinha.pAddColuna('VR.ORIGINAL'  ,  FloatToStrF(FieldByName('CTR_GRVORI').AsFloat, ffNumber, 12, 2)    , 12 , alDireita );
        objLinha.pAddColuna('VR.RECEBIDO'  ,  FloatToStrF(FieldByName('CTR_VALREC').AsFloat, ffNumber, 12, 2)    , 12 , alDireita );
        objLinha.pAddColuna('JUROS'        ,  FloatToStrF(FieldByName('CTR_VALJUR').AsFloat, ffNumber, 12, 2)    , 12 , alDireita );
        objLinha.pAddColuna('DESCONTOS'    ,  FloatToStrF(FieldByName('CTR_VALDES').AsFloat, ffNumber, 12, 2)    , 12 , alDireita );
        objTabela.lstLinhas.Add(objLinha);
        cdsAux.Next;
      End;

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      objLiberacao.objMsgLibera.pAddTextoCaption('Dinheiro', FloatToStrF(fltDinheiro, ffNumber, 12, 2), 20);
      objLiberacao.objMsgLibera.pAddTextoCaption('Cartão', FloatToStrF(fltCartao, ffNumber, 12, 2), 20);
      objLiberacao.objMsgLibera.pAddTextoCaption(IIF(FRecebidoPorPix = 'S', 'Pix', 'Ordem de Pagamento'), FloatToStrF(fltOrdPag, ffNumber, 12, 2), 20);
      objLiberacao.objMsgLibera.pAddTextoCaption('Cheque a Vista', FloatToStrF(fltCheqAv, ffNumber, 12, 2), 20);
      objLiberacao.objMsgLibera.pAddTextoCaption('Cheque Pré', FloatToStrF(fltCheqPre, ffNumber, 12, 2), 20);
    End;

    cdsAux.RecNo := intRecNo;

    if (Not fVerificaAcessoSistema('DIRRCXEST', IIF((blnResCai) and (not fEmptyStr(strCodOpe)), strCodOpe ,strLoginUsuarioLogado))) then
    begin

      objLiberacao.strDirAce := 'DIRRCXEST';
      objLiberacao.strMsgSen := 'Liberação para Estorno de Contas a Receber.';
      if (blnResCai) and (not fEmptyStr(strCodOpe)) then
      begin
        objLiberacao.strCodOpe := strCodOpe;
        objLiberacao.strCodDig := strCodOpe;
      end
      else
      begin
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.strCodDig := strLoginUsuarioLogado;
      end;

      objLiberacao.strSenLib := fCfgSis('ESTCTR');

      If (Not objLiberacao.fLibera) Then
      begin
        fMensagem('','Senha inválida!',['&OK']);
        Exit;
      end;
    end;

    cdsDadosCaixa := objResumoDeCaixa.fRetornaDadosLancamentosCaixaSeqCon(cdsAux.FieldByName('CTR_SEQCON').AsString,
                                                                          cdsAux.FieldByName('CTR_EMPBAI').AsString,
                                                                          IIF(cdsAux.FieldByName('CTR_DTAREC').IsNull,
                                                                              cdsAux.FieldByName('CTR_DTACAD').AsDateTime,
                                                                              cdsAux.FieldByName('CTR_DTAREC').AsDateTime));

    blnFechadoCaixa := (Not Assigned(cdsDadosCaixa)) Or
                       (cdsDadosCaixa.IsEmpty) Or
                       (cdsDadosCaixa.FieldByName('RCX_LANFEC').AsString = 'S');

    blnExibiuTravaCancelamentoNoDia := False;

    {***********************************}
    {* ESTORNO NÃO PERMITIDO EM RESUMO *}
    {* COM DATA DIFERENTE              *}
    {********************************AF*}
    If (blnResCai) And
       (cdsAux.FieldByName('CTR_DTAREC').AsDateTime <> dtaDtaRcx) Then
    Begin
      pEmitirMensagem('','Estorno não permitido, o resumo de caixa somente estorna a duplicata quando a data de recebimento for a mesma do caixa.' + #13#10 +
                      'Por favor, estornar pelo financeiro.', True);

     {*************************************************************}
     {* CASO A BAIXA FOI EFETUADA COM  CARTÃO OU CHEQUE EMITE UM  *}
     {* AVISO AO USUARIO PARA EFETUAR A TRANSFERENCIA             *}
     {REQ45210**************************************************LE*}
      If (fCfgSis('RCXTCC') = '2') Then
        fVerificaBaixaVinculadaCartoesChequesNaoTransferidos(cdsAux.FieldByName('CTR_DTAREC').AsDateTime,
                                                             cdsAux.FieldByName('CTR_DTABAI').AsDateTime,
                                                             cdsAux.FieldByName('CTR_SEQCON').AsInteger,
                                                             cdsAux.FieldByName('CTR_EMPBAI').AsString);

        pSetFocus(dbgDuplicatas);
        blnMudarFoco := False;
    End
    Else If (blnResCai) And
            (Not strCodigoCaixa.IsEmpty) And
            (objResumoDeCaixa.fCaixaDebaixaCtrDiferenteDoCaixaDeEstorno(cdsAux.FieldByName('NUMDUP').AsString + '-' +
                                                                        cdsAux.FieldByName('PARDUP').AsString + '-' +
                                                                        cdsAux.FieldByName('CTR_ESPDOC').AsString + '-' +
                                                                        cdsAux.FieldByName('CTR_CODEMP').AsString + '-' +
                                                                        cdsAux.FieldByName('CTR_CODCLI').AsString + '-' +
                                                                        cdsAux.FieldByName('CTR_SEQBAI').AsString,
                                                                        strCodigoCaixa,
                                                                        VS_strCodEmp,
                                                                        cdsAux.FieldByName('CTR_SEQCON').AsInteger)) Then
    Begin
      fMensagem('ATENÇÃO', 'Estorno não permitido, pois o caixa da baixa é diferente do caixa que está em operação.', ['&Ok']);

      pSetFocus(dbgDuplicatas);
      blnMudarFoco := False;
    End

    {**********************************}
    {* EMPRESA DE BAIXA DIFERENTE     *}
    {*******************************AF*}
    Else If cdsAux.FieldByName('CTR_EMPBAI').AsString <> VS_strCodEmp Then
    Begin
      pEmitirMensagem('','Permitido apenas estornar documentos baixados pela empresa ' + VS_strCodEmp + '!', True);

      pSetFocus(dbgDuplicatas);
      blnMudarFoco := False;
    End

    Else If Not ValidaTransferenciasLiberadas(cdsAux.FieldByName('CTR_SEQCON').AsString,
                                              cdsAux.FieldByName('CTR_EMPBAI').AsString)  Then
    Begin
      fMensagem('ATENÇÃO', 'Estorno não permitido, pois existem transferências de cheques ou cartões não liberadas.', ['&Ok']);

      pSetFocus(dbgDuplicatas);
      blnMudarFoco := False;
    End

    Else If (blnRescai) And
            (cdsDadosCaixa.FieldByName('RCX_LANFEC').AsString = 'S') Then
    Begin
      fMensagem('ATENÇÃO', 'Estorno não permitido pelo Resumo de Caixa, pois após esse recebimento o caixa já foi fechado.' + #13 +
                           'Por favor, estornar pelo financeiro ou cancele fechamento do caixa.', ['&O k']);

      pSetFocus(dbgDuplicatas);
      blnMudarFoco := False;
    End

    Else If (Not blnRescai) And
            (Not blnAlpe) And
            (Not FUtilizaContabilidadeERecebidoPorAdiantamento) And
            (cdsAux.FieldByName('CTR_RESCAI').AsInteger = 1) And
            (cdsAux.FieldByName('CTR_DTAREC').AsDateTime = dtaDtaRcx) And
            (Not fLiberouTravaPeloCancelamentoComSenha(fGetLanFec(cdsDadosCaixa), blnExibiuTravaCancelamentoNoDia)) Then
    Begin
      If (Not blnExibiuTravaCancelamentoNoDia) Then
      Begin
        LMensagem := fMensagemEstornoNoMesmoDia(fGetLanFec(cdsDadosCaixa));
        fMensagem('ATENÇÃO', LMensagem, ['&Ok']);
      End;
      pSetFocus(dbgDuplicatas);
      blnMudarFoco := False;
    End

    Else If (FUtilizaContabilidadeERecebidoPorAdiantamento) And
            (Not strEstRec.Equals('(Cancelamento de Documentos)') And
            (Not fBloquearEstornoPedidoJaFaturado(cdsAux.FieldByName('NUMDUP').AsString,
                                             cdsAux.FieldByName('CTR_ESPDOC').AsString,
                                             cdsAux.FieldByName('CTR_CODCLI').AsString,
                                             cdsAux.FieldByName('CTR_CODEMP').AsString)) And
            ((cdsAux.FieldByName('CTR_RESCAI').AsInteger <> 1) Or
             (cdsAux.FieldByName('CTR_DTAREC').AsDateTime <> dtaDtaRcx))) Then
    Begin
      fMensagem('ATENÇÃO', 'Esse documento está associado a um pedido recebido por adiantamento: ' + LNumeroPedidoAdiantamento + '.' + #13 +
                           'Será necessário acessar a rotina "Cancelamento de Documentos" para realizar a exclusão do Contas a Receber.', ['&Ok']);

      pSetFocus(dbgDuplicatas);
      blnMudarFoco := False;
    End

    Else If Not fEmptyStr(cdsAux.FieldByName('CTR_CTPCOM').AsString) Then
    Begin
      qryDup := fCriaQueryCadPagCTPCom(cdsAux.FieldByName('CTR_CTPCOM').AsString);
      Try
        strNumDup := qryDup.FieldByName('CTP_NUMDUP').AsString;
        strFornec := qryDup.FieldByName('FORNECEDOR').AsString;
        strDtaCad := FormatDateTime('dd/mm/yyyy', qryDup.FieldByName('CTP_DTACAD').AsDateTime);
        strDtaVen := FormatDateTime('dd/mm/yyyy', qryDup.FieldByName('CTP_DTAVEN').AsDateTime);
        strValDup := FormatFloat('#,##0.00', qryDup.FieldByName('CTP_VALDUP').AsFloat);

        pEmitirMensagem('','Esta duplicata não pode ser estornada porque deu origem ao contas a pagar referente a comissão de vendedores.' + #13#10 +
                        'Duplicata: '+ strNumDup +'-A - Fornecedor: '+ strFornec + #13#10 +
                        'Data Cadastro: '+ strDtaCad +' - Data Vencimento:'+ strDtaVen +' - Valor: '+ strValDup + #13#10 +
                        'Primeiro deve ser estornado e cancelado esta conta a pagar para permitir o estorno desta duplicata no contas a receber.', True, True);

        pSetFocus(dbgDuplicatas);
        blnMudarFoco := False;
      Finally
        FreeAndNil(qryDup);
      End;
    End

    Else If Not LComissaoAgrupamento.IsEmpty Then
    Begin
      LCTPCOMAgrupadas := '';

      LComissaoAgrupamento.First;
      While not LComissaoAgrupamento.Eof Do
      Begin
        LCTPCOMAgrupadas := LCTPCOMAgrupadas + LComissaoAgrupamento.FieldByName('COM_CTPCOM').AsString + '_';

        LComissaoAgrupamento.Next;
      End;

      qryDup := fCriaQueryCadPagCTPCom(LCTPCOMAgrupadas);

      LMensagem := 'A baixa possui duplicatas agrupadas que deram origem ao contas a pagar referente a comissão de vendedores. ' +
                   'Por isso o estorno não pode ser realizado.' + #13 +
                   'A relação de duplicatas de contas a pagar geradas: ' + #13 + #13;
      While Not qryDup.Eof Do
      Begin
        LMensagem := LMensagem + 'Duplicata: '+ qryDup.FieldByName('CTP_NUMDUP').AsString + '-A ' +
                                 '- Fornecedor: '+ qryDup.FieldByName('FORNECEDOR').AsString + #13#10 +
                                 'Data Cadastro: '+ FormatDateTime('dd/mm/yyyy', qryDup.FieldByName('CTP_DTACAD').AsDateTime) +
                                 ' - Data Vencimento:' + FormatDateTime('dd/mm/yyyy', qryDup.FieldByName('CTP_DTAVEN').AsDateTime) +
                                 ' - Valor: '+ FormatFloat('#,##0.00', qryDup.FieldByName('CTP_VALDUP').AsFloat) + #13#10;
        qryDup.Next;
      End;

      LMensagem := LMensagem + #13 + 'Primeiro deve ser estornado e cancelado os contas a pagar para permitir o estorno desta baixa no contas a receber.';

      pEmitirMensagem('', LMensagem, True, True);

      FreeAndNil(qryDup);

      pSetFocus(dbgDuplicatas);
      blnMudarFoco := False;
    End

    Else If Not fVerificaDocumentosBaixados(cdsAux.FieldByName('CTR_SEQCON').AsInteger,
                                            cdsAux.FieldByName('CTR_EMPBAI').AsString,
                                            cdsAux.FieldByName('CTR_DTABAI').AsDateTime,
                                            cdsAux.FieldByName('NUMDUP').AsString,
                                            cdsAux.FieldByName('PARDUP').AsString,
                                            cdsAux.FieldByName('CTR_ESPDOC').AsString,
                                            cdsAux.FieldByName('CTR_CODEMP').AsString,
                                            cdsAux.FieldByName('CTR_CODCLI').AsString,
                                            cdsAux.FieldByName('CTR_ADTCLI').AsString) Then
    Begin
      pSetFocus(dbgDuplicatas);
      blnMudarFoco := False;
    End

    Else If Not fVerificaDatasDiferentes(AClientesMarcados,
                                         cdsAux.FieldByName('CTR_SEQCON').AsInteger,
                                         cdsAux.FieldByName('CTR_EMPBAI').AsString,
                                         cdsAux.FieldByName('CTR_DTABAI').AsDateTime) Then
    Begin
      pSetFocus(dbgDuplicatas);
      blnMudarFoco := False;
    End

    Else If fBloquearEstornoPedidoJaFaturado(cdsAux.FieldByName('NUMDUP').AsString,
                                             cdsAux.FieldByName('CTR_ESPDOC').AsString,
                                             cdsAux.FieldByName('CTR_CODCLI').AsString,
                                             cdsAux.FieldByName('CTR_CODEMP').AsString) Then
    Begin
      pEmitirMensagem('','Pedido já faturado. ' + #13#10 +
                      'O faturamento precisa ser cancelado para ser permitido estornar a duplicata! Acessar: Principal > Cancelamento de Documentos. ', True);

      pSetFocus(dbgDuplicatas);
      blnMudarFoco := False;
    End

    Else If (cdsAux.FieldByName('CTR_RESCAI').AsInteger = 1) And
            fVerificaBaixaVinculadaCartoesChequesNaoTransferidos(cdsAux.FieldByName('CTR_DTAREC').AsDateTime,
                                                                 cdsAux.FieldByName('CTR_DTABAI').AsDateTime,
                                                                 cdsAux.FieldByName('CTR_SEQCON').AsInteger,
                                                                 cdsAux.FieldByName('CTR_EMPBAI').AsString) Then
    Begin
      pSetFocus(dbgDuplicatas);
      blnMudarFoco := False;
    End

    Else If Not ValidacoesDeRecebimentoPorPix(FRecebidoPorPix = 'S') Then
    Begin
      pSetFocus(dbgDuplicatas);
      blnMudarFoco := False;
    End

    Else If (fCfgSis('RCXTCC') = '2') And
            ((objResumoDeCaixa.strTIPofechamento = 'T') Or (blnResCai)) And
            (cdsAux.FieldByName('CTR_RESCAI').AsInteger = 1) And
            (cdsAux.FieldByName('CTR_DTABAI').AsDateTime = dtaDtaRcx) And
            (cdsDadosCaixa.FieldByName('RCX_LANFEC').AsString <> 'S') And
            (Not fSaldoCaixaSuficiente(cdsAux.FieldByName('CTR_SEQCON').AsInteger,
                                       cdsAux.FieldByName('CTR_EMPBAI').AsString,
                                       cdsAux.FieldByName('CTR_DTABAI').AsDateTime,
                                       FRecebidoPorPix = 'S')) Then
    Begin
      pSetFocus(dbgDuplicatas);
      blnMudarFoco := False;
    End

    Else If fDocumentoFaturado(cdsAux.Data) then
    Begin
      pSetFocus(dbgDuplicatas);
      blnMudarFoco := False;
    End

    Else If fPossuiTransferenciaAutomaticaAtiva(cdsAux.Data) Then
    Begin
      pEmitirMensagem('ATENÇÃO', 'Para realizar o estorno do documento, '+
                                 'cancele a transferência vinculada à essa duplicata em: '+ #13#10 +
                                 'Resumo de Caixa > [F1] Lançamentos > TF Transferência > [F8] Cancelamento de transferências', True);
      pSetFocus(dbgDuplicatas);
      blnMudarFoco := False;
    End
    Else If (blnFecharForm) Then
    begin
      pMensagemOk('O caixa está com data de fechamento igual a hoje, portanto não será possível estornar duplicatas!');
      pSetFocus(dbgDuplicatas);
      blnMudarFoco := False;
      Exit;
    end
    Else If (blnEstornoAutomatico And fPedePortador(strPorBai)) Or ((fMensagem('', 'Confirma estorno de duplicata(s)?', ['&Sim', '&Não']) = 1) And fPedePortador(strPorBai)) Then
    Begin
      {***************************************************}
      {* AVISO E CONFIRMAÇÃO PARA DUPLICATAS DESCONTADAS *}
      {************************************************AJ*}
      If (fCfgSis('ENCBAN', varBoolean)) And
         (Not cdsAux.FieldByName('CTR_MOVDES').IsNull) And
         (Pos(cdsAux.FieldByName('CTR_BCOENV').AsString, '237_033_') <= 0) Then
      Begin
        If fMensagem('ATENÇÃO', 'Essa duplicata foi recebida antecipadamente através de desconto de duplicatas '      +
                                'no banco. Ao realizar o estorno, será realizado o lançamento na '                    +
                                'movimentação bancária do valor da duplicata, mas as tarifas referentes ao desconto ' +
                                'não serão estornadas, deve ser feito manualmente, caso necessário.' + #13 +
                                'Deseja realmente continuar com o estorno?', ['&Sim', '&Não'], 1) = 2 Then
          Exit;
      End;

      If fEstornaDuplicataConjugadas(cdsAux.Data, strPorBai) Then
      Begin
        If Not blnEstornoDocLocEqu Then
        Begin
          blnMudarFoco := False;
          pLimpaCampos;
          pSetFocus(edtNumDup);
        End;
      End;
    End
    Else
    Begin
      pSetFocus(dbgDuplicatas);
      blnMudarFoco := False;
    End;

  Finally
    FreeAndNil(cdsAux);
    If Assigned(cdsDadosCaixa) Then
      FreeAndNil(cdsDadosCaixa);

    If Assigned(LComissaoAgrupamento) Then
      FreeAndNil(LComissaoAgrupamento);
  End;

end;

procedure TfrmEstornoReceber.pCriaTemporaria;
  Var
    strSQL: String;
    strCam: String;
    strAux: String;
    strMsg: String;
    strWhrAdt : String;
    strAutincMovGerFC: string;

    function fGetSqlWhereSeqCon: String;
    begin
      Result := '';
      cdsDados.First;

      While Not cdsDados.Eof Do
      Begin
        If cdsDados.FieldByName('CTR_SEQCON').AsInteger > 0 Then
        Begin
          If Not fEmptyStr(Result) Then
            Result := Result + ' OR ';

          Result := Result + ' ( CTR_SEQCON = ' + cdsDados.FieldByName('CTR_SEQCON').AsString + ' AND ';
          Result := Result + '   CTR_EMPBAI = ' + QuotedStr(cdsDados.FieldByName('CTR_EMPBAI').AsString) + ' ) ';
        End;
        cdsDados.Next;
      End;

      If Not fEmptyStr(Result) Then
        Result := '( ' + Result + ' ) ';

      cdsDados.First;
    end;

    function fTabelaCredito(strSeqCon, strNumDup, strParcel, strSeqBai, strCodEmp, strEspDoc, strCodCli: String; dtaDtaCad: TDateTime): String;
      Var
        qryTab: TUniQuery;
    Begin
      Try
        Result := '';
        qryTab := fCriaQuery(Self);

        strSQL := '';
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   "CADREC" AS TABELA ';
        strSQL := strSQL + ' FROM ';
        strSQL := strSQL + '  CADREC ';
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '  (CTR_DTAREC IS NULL AND ';
        strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
        strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
        strSQL := strSQL + '   CTR_SEQBAI = :SEQBAI AND ';
        strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
        strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
        strSQL := strSQL + '   CTR_DTACAD = :DTACAD) ';

        {**********************************************}
        {* AQUI DEVE SER UNION APENAS E NÃO UNION ALL *}
        {*******************************************AF*}
        strSQL := strSQL + ' UNION ';

        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   "CADREC" AS TABELA ';
        strSQL := strSQL + ' FROM ';
        strSQL := strSQL + '  CADREC ';
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '  (CTR_DTAREC IS NOT NULL AND ';
        strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
        strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
        strSQL := strSQL + '   CTR_SEQBAI = :SEQBAI AND ';
        strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
        strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
        strSQL := strSQL + '   CTR_DTACAD = :DTACAD AND ';
        strSQL := strSQL + '   CTR_SEQCON = :SEQCON) ';

        With qryTab Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('NUMDUP').AsString   := strNumDup;
          ParamByName('PARCEL').AsString   := strParcel;
          ParamByName('SEQBAI').AsString   := strSeqBai;
          ParamByName('CODEMP').AsString   := strCodEmp;
          ParamByName('ESPDOC').AsString   := strEspDoc;
          ParamByName('CODCLI').AsString   := strCodCli;
          ParamByName('DTACAD').AsDateTime := dtaDtaCad;
          ParamByName('SEQCON').AsString   := strSeqCon;
          Open;

          If IsEmpty Then
          Begin
            If Not RegistroCreditoAdiantamentoEstornado(strSeqCon, strCodEmp, dtaDtaCad)  Then
              Raise ExceptionAutCom.Create('Não foi encontrado o crédito: ' + strNumDup + strParcel + '-' + strEspDoc + '-' + strCodEmp + '-' +
                                     FormatDateTime('dd/mm/yyyy',dtaDtaCad) + ' gerado na baixa da duplicata, ou o mesmo foi baixado.')
            Else
              Result := 'ADTCLI';
          End
          Else
            Result := IIF(FieldByName('TABELA').AsString = '', 'CADREC', FieldByName('TABELA').AsString);

          Close;
        End;

      Except
        On E: ExceptionAutCom Do
          Raise ExceptionAutCom.Create(E.Message);

        On E: Exception Do
          Raise Exception.Create(E.Message);
      End;

      FreeAndNil(qryTab);
    End;

    procedure pCarregaDadosCredito;
      Var
        cdsAux: TUniClientDataSet;

        LValorCC: Double;

        LSeqconValidar: Integer;
    Begin

      Try
        cdsAux := TUniClientDataSet.Create(Self);
        cdsAux.Data := cdsDados.Data;

        LSeqconValidar := FiltroPossuiBaixaDeDuplicatasComTotalEParcial(cdsAux);

        cdsAux.First;
        While Not cdsAux.Eof Do
        Begin
          If LSeqconValidar > 0 Then
          BEgin
            If Not MatchStr(cdsAux.FieldByName('CTR_SEQCON').AsString, ['0', LSeqconValidar.ToString]) Then
            Begin
              cdsAux.Next;

              Continue;
            End;
          End;

          strSQL := '';
          strSQL := strSQL + 'SELECT ';
          strSQL := strSQL + strCam;
          strSQL := strSQL + 'FROM ';
          strSQL := strSQL + '  LOGCTR ';
          strSQL := strSQL + 'WHERE ';
          strSQL := strSQL + '  CTR_VALORI < 0 AND ';
          strSQL := strSQL + '  CTR_SEQCON = :SEQCON AND ';
          strSQL := strSQL + '  CTR_DTACAD IN( :DTABAI, :DTAREC ) AND ';
          strSQL := strSQL + '  CTR_CODEMP = :EMPBAI AND ';
          strSQL := strSQL + '  CTR_DTAREC IS NULL       ';

          With qryDados Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('SEQCON').AsString   := cdsAux.FieldByName('CTR_SEQCON').AsString;
            ParamByName('DTABAI').AsDate     := cdsAux.FieldByName('CTR_DTABAI').AsDateTime;
            ParamByName('DTAREC').AsDate     := cdsAux.FieldByName('CTR_DTAREC').AsDateTime;
            ParamByName('EMPBAI').AsString   := cdsAux.FieldByName('CTR_EMPBAI').AsString;
            Open;

            While Not qryDados.Eof Do
            Begin
              cdsDados.Filter := 'NUMDUP = ' + QuotedStr(qryDados.FieldByName('NUMDUP').AsString) + ' AND ' +
                                 'PARDUP = ' + QuotedStr(qryDados.FieldByName('PARDUP').AsString) + ' AND ' +
                                 'CTR_SEQBAI = ' + QuotedStr(qryDados.FieldByName('CTR_SEQBAI').AsString) + ' AND ' +
                                 'CTR_CODEMP = ' + QuotedStr(qryDados.FieldByName('CTR_CODEMP').AsString) + ' AND ' +
                                 'CTR_ESPDOC = ' + QuotedStr(qryDados.FieldByName('CTR_ESPDOC').AsString) + ' AND ' +
                                 'CTR_CODCLI = ' + QuotedStr(qryDados.FieldByName('CTR_CODCLI').AsString) + ' AND ' +
                                 'CTR_DTACAD = ' + QuotedStr(qryDados.FieldByName('CTR_DTACAD').AsString);
              cdsDados.Filtered := True;

              If cdsDados.IsEmpty Then
              Begin
                cdsDados.Insert;
                cdsDados.FieldByName('NUMDUP').AsString       := qryDados.FieldByName('NUMDUP').AsString;
                cdsDados.FieldByName('PARDUP').AsString       := qryDados.FieldByName('PARDUP').AsString;
                cdsDados.FieldByName('CTR_NUMDUP').AsString   := qryDados.FieldByName('CTR_NUMDUP').AsString;
                cdsDados.FieldByName('CTR_CODDIG').AsString   := qryDados.FieldByName('CTR_CODDIG').AsString;
                cdsDados.FieldByName('CTR_SEQBAI').AsString   := qryDados.FieldByName('CTR_SEQBAI').AsString;
                cdsDados.FieldByName('ORDBAI').AsString       := qryDados.FieldByName('ORDBAI').AsString;
                cdsDados.FieldByName('CTR_DTACAD').AsDateTime := qryDados.FieldByName('CTR_DTACAD').AsDateTime;
                cdsDados.FieldByName('CTR_DTAVEN').AsDateTime := qryDados.FieldByName('CTR_DTAVEN').AsDateTime;
                cdsDados.FieldByName('CTR_DESCOB').AsFloat    := qryDados.FieldByName('CTR_DESCOB').AsFloat;
                cdsDados.FieldByName('CTR_DESCON').AsString   := qryDados.FieldByName('CTR_DESCON').AsString;
                cdsDados.FieldByName('CTR_HIST01').AsString   := qryDados.FieldByName('CTR_HIST01').AsString;
                cdsDados.FieldByName('CTR_HIST02').AsString   := qryDados.FieldByName('CTR_HIST02').AsString;
                cdsDados.FieldByName('CTR_EMPBAI').AsString   := qryDados.FieldByName('CTR_EMPBAI').AsString;
                cdsDados.FieldByName('CTR_CTABAI').AsString   := qryDados.FieldByName('CTR_CTABAI').AsString;
                cdsDados.FieldByName('CTR_OPEBAI').AsString   := qryDados.FieldByName('CTR_OPEBAI').AsString;
                cdsDados.FieldByName('CTR_PORBAI').AsString   := qryDados.FieldByName('CTR_PORBAI').AsString;
                cdsDados.FieldByName('CTR_CODEMP').AsString   := qryDados.FieldByName('CTR_CODEMP').AsString;
                cdsDados.FieldByName('CTR_ESPDOC').AsString   := qryDados.FieldByName('CTR_ESPDOC').AsString;
                cdsDados.FieldByName('CTR_CODCLI').AsString   := qryDados.FieldByName('CTR_CODCLI').AsString;
                cdsDados.FieldByName('CTR_VALJUR').AsFloat    := qryDados.FieldByName('CTR_VALJUR').AsFloat;
                cdsDados.FieldByName('CTR_VALCOB').AsFloat    := qryDados.FieldByName('CTR_VALCOB').AsFloat;
                cdsDados.FieldByName('CTR_VALDES').AsFloat    := qryDados.FieldByName('CTR_VALDES').AsFloat;
//                cdsDados.FieldByName('CTR_DTAREC').AsDateTime := qryDados.FieldByName('CTR_DTAREC').AsDateTime;
                cdsDados.FieldByName('CTR_VALREC').AsFloat    := qryDados.FieldByName('CTR_VALREC').AsFloat;
                cdsDados.FieldByName('CTR_VALDUP').AsFloat    := qryDados.FieldByName('CTR_VALDUP').AsFloat;
                cdsDados.FieldByName('CTR_ADTCLI').AsString   := qryDados.FieldByName('CTR_ADTCLI').AsString;
                cdsDados.FieldByName('CTR_CODEVE').AsString   := qryDados.FieldByName('CTR_CODEVE').AsString;
                cdsDados.FieldByName('CTR_RESCAI').AsInteger  := qryDados.FieldByName('CTR_RESCAI').AsInteger;
                cdsDados.FieldByName('CTR_ORIF11').AsString   := qryDados.FieldByName('CTR_ORIF11').AsString;
                cdsDados.FieldByName('CTR_SEQCON').AsString   := qryDados.FieldByName('CTR_SEQCON').AsString;
                cdsDados.FieldByName('CTR_DINHEI').AsFloat    := qryDados.FieldByName('CTR_DINHEI').AsFloat;
                cdsDados.FieldByName('CTR_CHQAVI').AsFloat    := qryDados.FieldByName('CTR_CHQAVI').AsFloat;
                cdsDados.FieldByName('CTR_CHQPRE').AsFloat    := qryDados.FieldByName('CTR_CHQPRE').AsFloat;
                cdsDados.FieldByName('CTR_CARTAO').AsFloat    := qryDados.FieldByName('CTR_CARTAO').AsFloat;
                cdsDados.FieldByName('CTR_ORDPAG').AsFloat    := qryDados.FieldByName('CTR_ORDPAG').AsFloat;

                cdsDados.FieldByName('CTR_TABELA').AsString   := fTabelaCredito(qryDados.FieldByName('CTR_SEQCON').AsString,
                                                                                qryDados.FieldByName('NUMDUP').AsString,
                                                                                qryDados.FieldByName('PARDUP').AsString,
                                                                                qryDados.FieldByName('CTR_SEQBAI').AsString,
                                                                                qryDados.FieldByName('CTR_CODEMP').AsString,
                                                                                qryDados.FieldByName('CTR_ESPDOC').AsString,
                                                                                qryDados.FieldByName('CTR_CODCLI').AsString,
                                                                                qryDados.FieldByName('CTR_DTACAD').AsDateTime);

                cdsDados.FieldByName('CTR_MARDES').AsString   := qryDados.FieldByName('CTR_MARDES').AsString;
                cdsDados.FieldByName('CTR_VALANT').AsFloat    := qryDados.FieldByName('CTR_VALANT').AsFloat;
                cdsDados.FieldByName('CTR_JURANT').AsFloat    := qryDados.FieldByName('CTR_JURANT').AsFloat;
                cdsDados.FieldByName('CTR_DESANT').AsFloat    := qryDados.FieldByName('CTR_DESANT').AsFloat;
                cdsDados.FieldByName('CTR_COBANT').AsFloat    := qryDados.FieldByName('CTR_COBANT').AsFloat;
                cdsDados.FieldByName('CTR_VALFIN').AsFloat    := qryDados.FieldByName('CTR_VALFIN').AsFloat;
                cdsDados.FieldByName('CTR_QTDDAV').AsInteger  := qryDados.FieldByName('CTR_QTDDAV').AsInteger;
                cdsDados.FieldByName('CTR_DIFORI').AsFloat    := qryDados.FieldByName('CTR_DIFORI').AsFloat;
                cdsDados.FieldByName('CTR_DTABAI').AsDateTime := qryDados.FieldByName('CTR_DTABAI').AsDateTime;
                cdsDados.FieldByName('CTR_CTPCOM').AsString   := qryDados.FieldByName('CTR_CTPCOM').AsString;
                cdsDados.FieldByName('CTR_PERDPO').AsFloat    := qryDados.FieldByName('CTR_PERDPO').AsFloat;
                cdsDados.FieldByName('CTR_GRVORI').AsFloat    := qryDados.FieldByName('CTR_GRVORI').AsFloat;
                cdsDados.FieldByName('CTR_LINDIG').AsString   := qryDados.FieldByName('CTR_LINDIG').AsString;
                cdsDados.FieldByName('CTR_CARTEI').AsString   := qryDados.FieldByName('CTR_CARTEI').AsString;
                cdsDados.FieldByName('CTR_NOSNUM').AsString   := qryDados.FieldByName('CTR_NOSNUM').AsString;
                cdsDados.FieldByName('CTR_BCOBOL').AsString   := qryDados.FieldByName('CTR_BCOBOL').AsString;
                cdsDados.FieldByName('CTR_BCOENV').AsString   := qryDados.FieldByName('CTR_BCOENV').AsString;
                cdsDados.FieldByName('CTR_DTAENV').AsDateTime := qryDados.FieldByName('CTR_DTAENV').AsDateTime;
                cdsDados.FieldByName('CTR_AUTCTP').AsString   := qryDados.FieldByName('CTR_AUTCTP').AsString;
                cdsDados.FieldByName('CTR_MOVDES').AsString   := qryDados.FieldByName('CTR_MOVDES').AsString;
                cdsDados.FieldByName('CTR_VALORI').AsFloat    := qryDados.FieldByName('CTR_VALORI').AsFloat;
                cdsDados.FieldByName('CTR_RECPIX').AsString   := qryDados.FieldByName('CTR_RECPIX').AsString;
                cdsDados.FieldByName('CTR_ESTORN').AsString   := qryDados.FieldByName('CTR_ESTORN').AsString;
                cdsDados.FieldByName('CTR_DTABAN').AsString   := qryDados.FieldByName('CTR_DTABAN').AsString;

                cdsDados.Post;
              End;

              qryDados.Next;
            End;

          End;

          cdsAux.Next;
        End;

        //Removendo registro do CC estornado no adiantamento
        If FSeqconCCCanceladoADT > 0 Then
        Begin
          cdsDados.Filter   := 'CTR_TABELA=''ADTCLI'' AND CTR_ESPDOC=''CC'' AND CTR_VALDUP < 0 AND (CTR_VALREC IS NULL OR CTR_VALREC=0) ';
          cdsDados.Filtered := True;

          If Not cdsDados.IsEmpty Then
          Begin
            LValorCC := fFormataFloat(cdsDados.FieldByName('CTR_VALDUP').AsFloat, 2);

            cdsDados.Filter   := 'CTR_TABELA=''ADTCLI'' AND CTR_SEQCON=' + FSeqconCCCanceladoADT.ToString;
            cdsDados.Filtered := True;

            cdsDados.First;
            While Not cdsDados.Eof Do
            Begin
              If Abs(LValorCC) = Abs(fFormataFloat(cdsDados.FieldByName('CTR_VALDUP').AsFloat, 2))  Then
              Begin
                If (cdsDados.FieldByName('CTR_ESPDOC').AsString = 'CC') And
                   (cdsDados.FieldByName('CTR_VALREC').IsNull Or (cdsDados.FieldByName('CTR_VALREC').AsFloat = 0)) Then
                Begin
                  cdsDados.Delete;
                  Continue;
                End;

                If (cdsDados.FieldByName('CTR_ESPDOC').AsString = 'PD') And
                   (cdsDados.FieldByName('CTR_ESTORN').AsString = 'S') Then
                Begin
                  cdsDados.Delete;
                  Continue;
                End;
              End;

              cdsDados.Next;
            End;
          End;
        End;
      Except
        On E: ExceptionAutCom Do
          Raise ExceptionAutCom.Create(E.Message);

        On E: Exception Do
          Raise Exception.Create(E.Message);
      End;

      cdsDados.Filter   := '';
      cdsDados.Filtered := False;
      FreeAndNil(cdsAux);
    End;
begin
  Try
    FSeqconCCCanceladoADT := 0;

    strAutincMovGerFC := EmptyStr;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   CTR_SEQCON, CTR_EMPBAI, CTR_DTABAI, CTR_CODCLI  ';
    strSQL := strSQL + ' FROM  ';
    strSQL := strSQL + '   CADREC ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CTR_DTAREC IS NOT NULL ' + IIF(blnResCai,' AND CTR_RESCAI = 1 ','');

    strSQL := strSQL + IIF(fEmptyStr(edtNumDup.Text), '', ' AND CTR_NUMDUP = :NUMDUP ');
    strSQL := strSQL + IIF(fEmptyStr(edtParcel.Text), '', ' AND CTR_PARCEL = :PARCEL ');
    strSQL := strSQL + IIF(fEmptyStr(edtCodEmp.Text), '', ' AND CTR_CODEMP = :CODEMP ');
    strSQL := strSQL + IIF(fEmptyStr(edtEspDoc.Text), '', ' AND CTR_ESPDOC = :ESPDOC ');
    strSQL := strSQL + IIF(fEmptyStr(edtCodCli.Text), '', ' AND CTR_CODCLI = :CODCLI ');

    With qryDados Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(edtNumDup.Text) Then ParamByName('NUMDUP').AsString := edtNumDup.Text;
      If Not fEmptyStr(edtParcel.Text) Then ParamByName('PARCEL').AsString := edtParcel.Text;
      If Not fEmptyStr(edtCodEmp.Text) Then ParamByName('CODEMP').AsString := edtCodEmp.Text;
      If Not fEmptyStr(edtEspDoc.Text) Then ParamByName('ESPDOC').AsString := edtEspDoc.Text;
      If Not fEmptyStr(edtCodCli.Text) Then ParamByName('CODCLI').AsString := edtCodCli.Text;

      Open;

      pSetaClient(qryDados);

      cdsDados.Filtered := False;
      cdsDados.Filter   := '';
      cdsDados.IndexFieldNames := '';
      cdsDados.Close;
      cdsDados.SetProvider(cpvDados);
      cdsDados.Open;
    End;

    If (cdsDados.IsEmpty) And (blnEstornoAutomatico) And (not blnAlpe) Then
      Exit;

    if (cdsDados.IsEmpty) and
       (not fEmptyStr(edtNumDup.Text)) and (not fEmptyStr(edtCodEmp.Text)) and
       (not fEmptyStr(edtEspDoc.Text)) and (not fEmptyStr(edtCodCli.Text)) then
    begin
      qryDados.Close;
      qryDados.SQL.Clear;
      qryDados.SQL.Add('SELECT AUTOINCREM FROM MOVGER');
      qryDados.SQL.Add('WHERE GER_NUMDOC = :NUMDOC');
      qryDados.SQL.Add('AND GER_ESPDOC = :ESPDOC');
      qryDados.SQL.Add('AND GER_CODEMP = :CODEMP');
      qryDados.SQL.Add('AND GER_CODCLI = :CODCLI');

      qryDados.ParamByName('NUMDOC').AsString := edtNumDup.Text;
      qryDados.ParamByName('CODEMP').AsString := edtCodEmp.Text;
      qryDados.ParamByName('ESPDOC').AsString := edtEspDoc.Text;
      qryDados.ParamByName('CODCLI').AsString := edtCodCli.Text;

      qryDados.Open;

      if not qryDados.IsEmpty then
      begin
        strAutincMovGerFC := qryDados.FieldByName('AUTOINCREM').AsString;
        qryDados.Close;
        qryDados.SQL.Clear;
        qryDados.SQL.Add('SELECT * FROM CADREC ');
        qryDados.SQL.Add('WHERE CTR_SEQFCO = :SEQFCO');

        qryDados.ParamByName('SEQFCO').AsString := strAutincMovGerFC;
        qryDados.Open;

        pSetaClient(qryDados);

        cdsDados.Filtered := False;
        cdsDados.Filter   := '';
        cdsDados.IndexFieldNames := '';
        cdsDados.Close;
        cdsDados.SetProvider(cpvDados);
        cdsDados.Open;
      end;
    end;

    {******************************************************************}
    {* CASO NAO ENCONTROU DUPLICATAS VERIFICA SE POSSUI ADIANTAMENTOS *}
    {***************************************************************JC*}
    If cdsDados.RecordCount = 0 Then
    Begin
      If Not fValidaEstornoAdiantamento(cdsDados, strMsg) Then
      Begin
        pMensagemOk(strMsg);
        pLimpaCampos;
        blnMudarFoco := False;
        Exit;
      End;
    End;

    If cdsDados.RecordCount = 0 Then
    Begin
      pMensagemOk('Não há duplicatas a serem estornadas' + IIF(blnResCai,' ou não foi baixada pelo resumo de caixa!', '!'));
      pLimpaCampos;
      blnMudarFoco := False;
      Exit;
    End;

    If fEmptyStr(cdsDados.FieldByName('CTR_EMPBAI').AsString) Then
    Begin
      pMensagemOk('A empresa de baixa não está preenchida, ligue para a Citel e informe o campo CADREC->CTR_EMPBAI!');
      pLimpaCampos;
      blnMudarFoco := False;
      Exit;
    End;

    If fEmptyStr(cdsDados.FieldByName('CTR_SEQCON').AsString) Then
    Begin
      pMensagemOk('O sequencial de baixa não está preenchido, ligue para a Citel e informe o campo CADREC->CTR_SEQCON!');
      pLimpaCampos;
      blnMudarFoco := False;
      Exit;
    End;

    strAux := '';
    strSQL := '';
    strSQL := strSQL + 'SELECT ';

    {********************************************}
    {********************************************}
    {**           !!!  ATENÇÃO !!!             **}
    {** QUANDO MUDAR A ESTRUTURA DE CAMPOS     **}
    {** MUDAR TAMBÉM A INSERÇÃO QUE ESTA ACIMA **}
    {** NA PROCEDURE pCarregaDadosCredito      **}
    {********************************************}
    {********************************************}

    strCam := '';
    strCam := strCam + '  AUTOINCREM, ';
    strCam := strCam + '  CTR_NUMDUP AS NUMDUP, ';
    strCam := strCam + '  CTR_PARCEL AS PARDUP, ';
    strCam := strCam + '  CONCAT(CTR_NUMDUP, CTR_PARCEL) AS CTR_NUMDUP, ';
    strCam := strCam + '  CTR_CODDIG, ';
    strCam := strCam + '  CTR_SEQBAI, ';
    strCam := strCam + '  IF(CTR_SEQBAI = 0, CTR_SEQBAI, 999 - CTR_SEQBAI) AS ORDBAI, ';//Para ordenar as duplicatas por ordem da baixa decrescente
    strCam := strCam + '  CTR_DTACAD, ';
    strCam := strCam + '  CTR_DTAVEN, ';
    strCam := strCam + '  CTR_DESCOB, ';
    strCam := strCam + '  CTR_DESCON, ';
    strCam := strCam + '  CTR_HIST01, ';
    strCam := strCam + '  CTR_HIST02, ';
    strCam := strCam + '  CTR_EMPBAI, ';
    strCam := strCam + '  CTR_CTABAI, ';
    strCam := strCam + '  CTR_OPEBAI, ';
    strCam := strCam + '  CTR_PORBAI, ';
    strCam := strCam + '  CTR_CODEMP, ';
    strCam := strCam + '  CTR_ESPDOC, ';
    strCam := strCam + '  CTR_CODCLI, ';
    strCam := strCam + '  CTR_VALJUR, ';
    strCam := strCam + '  CTR_VALCOB, ';
    strCam := strCam + '  CTR_VALDES, ';
    strCam := strCam + '  CTR_DTAREC, ';
    strCam := strCam + '  CTR_VALREC, ';
    strCam := strCam + '  CTR_VALDUP, ';
    strCam := strCam + '  CTR_ADTCLI, ';
    strCam := strCam + '  CTR_CODEVE, ';
    strCam := strCam + '  CTR_RESCAI, ';
    strCam := strCam + '  CTR_ORIF11, ';
    strCam := strCam + '  CTR_SEQCON, ';
    strCam := strCam + '  CTR_DINHEI, ';
    strCam := strCam + '  CTR_CHQAVI, ';
    strCam := strCam + '  CTR_CHQPRE, ';
    strCam := strCam + '  CTR_CARTAO, ';
    strCam := strCam + '  CTR_ORDPAG, ';
    strCam := strCam + '  CTR_CTPCOM, ';
    strCam := strCam + '  "CADREC" AS CTR_TABELA, ';
    strCam := strCam + '  "D" AS CTR_MARDES, ';
    strCam := strCam + '  ""  AS CTR_ORIGEM, ';
    strCam := strCam + '  CTR_VALANT, ';
    strCam := strCam + '  CTR_JURANT, ';
    strCam := strCam + '  CTR_DESANT, ';
    strCam := strCam + '  CTR_COBANT, ';
    strCam := strCam + '  CTR_VALFIN, ';
    strCam := strCam + '  CTR_DTABAI, ';
    strCam := strCam + '  CTR_DOCBAI, ';
    strCam := strCam + '  CTR_QTDDAV, ';
    strCam := strCam + '  CTR_DIFORI, ';
    strCam := strCam + '  CTR_PERDPO, ';
    strCam := strCam + '  CTR_GRVORI, ';
    strCam := strCam + '  CTR_LINDIG, ';
    strCam := strCam + '  CTR_CARTEI, ';
    strCam := strCam + '  CTR_NOSNUM, ';
    strCam := strCam + '  CTR_BCOBOL, ';
    strCam := strCam + '  CTR_BCOENV, ';
    strCam := strCam + '  CTR_DTAENV, ';
    strCam := strCam + '  CTR_AUTCTP, ';
    strCam := strCam + '  CTR_MOVDES, ';
    strCam := strCam + '  CTR_VALORI, ';
    strCam := strCam + '  CTR_RECPIX,  ';
    strCam := strCam + '  "N" AS CTR_ESTORN, ';
    strCam := strCam + '  CTR_DTABAN, ';
    strCam := strCam + '  CTR_VALFRE  ';
    strSQL := strSQL + strCam;
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADREC ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '  CTR_DTAREC IS NOT NULL AND ' + IIF(blnResCai,' CTR_RESCAI = 1 AND ','');

    If Not fEmptyStr(fGetSqlWhereSeqCon) Then
    Begin
      strAux := strSQL;
      strSQL := strSQL + fGetSqlWhereSeqCon;
      {***************************************}
      {* AQUI DEVE SER UNION E NÃO UNION ALL *}
      {************************************AF*}
      strSQL := strSQL + ' UNION ';
      strSQL := strSQL + strAux;
    End;

    strSQL := strSQL + ' (CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI)';

    strSQL := strSQL + ' UNION ALL ';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   AUTOINCREM, ';
    strSQL := strSQL + '   ADT_NUMDOC AS NUMDUP, ';
    strSQL := strSQL + '   "A"        AS PARDUP, ';
    strSQL := strSQL + '   CONCAT(ADT_NUMDOC, "A") AS CTR_NUMDUP, ';
    strSQL := strSQL + '   ADT_OPELAN AS CTR_CODDIG, ';
    strSQL := strSQL + '   0          AS CTR_SEQBAI, ';
    strSQL := strSQL + '   0          AS ORDBAI, ';
    strSQL := strSQL + '   ADT_DTALAN AS CTR_DTACAD, ';
    strSQL := strSQL + '   ADT_DTALAN AS CTR_DTAVEN, ';
    strSQL := strSQL + '   0.00       AS CTR_DESCOB, ';
    strSQL := strSQL + '   "N"        AS CTR_DESCON, ';
    strSQL := strSQL + '   ADT_DESCRI AS CTR_HIST01, ';
    strSQL := strSQL + '   NULL       AS CTR_HIST02, ';
    strSQL := strSQL + '   ADT_EMPLAN AS CTR_EMPBAI, ';
    strSQL := strSQL + '   IF(ADT_ORIGEM = "CTR" OR (IFNULL(ADT_ORIGEM, "") = "" AND IFNULL(ADT_CODCTA, "") <> ""), ADT_CODCTA, "' + fCfgSis('CTARCX') + '") AS CTR_CTABAI, ';
    strSQL := strSQL + '   ADT_OPELAN AS CTR_OPEBAI, ';
    strSQL := strSQL + '   IF(ADT_ORIGEM = "CTR" OR (IFNULL(ADT_ORIGEM, "") = "" AND IFNULL(ADT_CODPOR, "") <> ""), ADT_CODPOR, "' + fCfgSis('PORRCX') + '") AS CTR_PORBAI, ';
    strSQL := strSQL + '   ADT_CODEMP AS CTR_CODEMP, ';
    strSQL := strSQL + '   ADT_ESPDOC AS CTR_ESPDOC, ';
    strSQL := strSQL + '   ADT_CODCLI AS CTR_CODCLI, ';
    strSQL := strSQL + '   0.00       AS CTR_VALJUR, ';
    strSQL := strSQL + '   0.00       AS CTR_VALCOB, ';
    strSQL := strSQL + '   0.00       AS CTR_VALDES, ';
    strSQL := strSQL + '   ADT_DTALAN AS CTR_DTAREC, ';
    strSQL := strSQL + '   IF(ADT_TIPLAN = "C", ADT_VALLAN, -ADT_VALLAN) AS CTR_VALREC, ';
    strSQL := strSQL + '   IF(ADT_TIPLAN = "C", ADT_VALLAN, -ADT_VALLAN) AS CTR_VALDUP, ';
    strSQL := strSQL + '   "S"        AS CTR_ADTCLI, ';
    strSQL := strSQL + '   NULL       AS CTR_CODEVE, ';
    strSQL := strSQL + '   IF(ADT_ORIGEM="RCX" OR ADT_RESCAI=1, 1, 0) AS CTR_RESCAI, ';
    strSQL := strSQL + '   "N"        AS CTR_ORIF11, ';
    strSQL := strSQL + '   ADT_SEQCON AS CTR_SEQCON, ';
    strSQL := strSQL + '   IF(ADT_TIPLAN = "C", (ADT_VALDIN + ADT_VALCRE), -(ADT_VALDIN + ADT_VALCRE)) AS CTR_DINHEI, ';
    strSQL := strSQL + '   IF(ADT_TIPLAN = "C", ADT_VALCHV, -ADT_VALCHV) AS CTR_CHQAVI, ';
    strSQL := strSQL + '   IF(ADT_TIPLAN = "C", ADT_VALCHP, -ADT_VALCHP) AS CTR_CHQPRE, ';
    strSQL := strSQL + '   IF(ADT_TIPLAN = "C", ADT_VALCAR, -ADT_VALCAR) AS CTR_CARTAO, ';
    strSQL := strSQL + '   IF(ADT_TIPLAN = "C", ADT_VALORD, -ADT_VALORD) AS CTR_ORDPAG, ';
    strSQL := strSQL + '   NULL       AS CTR_CTPCOM, ';
    strSQL := strSQL + '   "ADTCLI"   AS CTR_TABELA, ';
    strSQL := strSQL + '   "D"        AS CTR_MARDES, ';
    strSQL := strSQL + '   ADT_ORIGEM AS CTR_ORIGEM, ';
    strSQL := strSQL + '   IF(ADT_TIPLAN = "C", ADT_VALLAN, -ADT_VALLAN) AS CTR_VALANT, ';
    strSQL := strSQL + '   0.00       AS CTR_JURANT, ';
    strSQL := strSQL + '   0.00       AS CTR_DESANT, ';
    strSQL := strSQL + '   0.00       AS CTR_COBANT, ';
    strSQL := strSQL + '   0.00       AS CTR_VALFIN, ';
    strSQL := strSQL + '   ADT_DTALAN AS CTR_DTABAI, ';
    strSQL := strSQL + '   ""         AS CTR_DOCBAI, ';
    strSQL := strSQL + '   0          AS CTR_QTDDAV, ';
    strSQL := strSQL + '   0.00       AS CTR_DIFORI, ';
    strSQL := strSQL + '   0.00       AS CTR_PERDPO, ';
    strSQL := strSQL + '   0.00       AS CTR_GRVORI, ';
    strSQL := strSQL + '   ""         AS CTR_LINDIG, ';
    strSQL := strSQL + '   ""         AS CTR_CARTEI, ';
    strSQL := strSQL + '   ""         AS CTR_NOSNUM, ';
    strSQL := strSQL + '   ""         AS CTR_BCOBOL, ';
    strSQL := strSQL + '   ""         AS CTR_BCOENV, ';
    strSQL := strSQL + '  ADT_DTALAN  AS CTR_DTAENV, ';
    strSQL := strSQL + '  NULL        AS CTR_AUTCTP, ';
    strSQL := strSQL + '  NULL        AS CTR_MOVDES, ';
    strSQL := strSQL + '  ADT_VALLAN  AS CTR_VALORI, ';
    strSQL := strSQL + '  ADT_RECPIX AS CTR_RECPIX,  ';
    strSQL := strSQL + '  ADT_ESTORN AS CTR_ESTORN,  ';
    strSQL := strSQL + '  ADT_DTABAN AS CTR_DTABAN,  ';
    strSQL := strSQL + '   0.00      AS CTR_VALFRE   ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   ADTCLI ';
    strSQL := strSQL + ' WHERE ';

    strWhrAdt := AnsiReplaceStr(AnsiReplaceStr(fGetSqlWhereSeqCon, 'CTR_SEQCON', 'ADT_SEQCON'),
                                                                   'CTR_EMPBAI', 'ADT_EMPLAN');
    strWhrAdt := strWhrAdt + IIF(fEmptyStr(strWhrAdt),'ADT_CODCLI = :CODCLI',' AND ADT_CODCLI = :CODCLI ');

    If fEmptyStr(strWhrAdt) Then
      strSQL := strSQL + ' TRUE '
    Else
      strSQL := strSQL + strWhrAdt;

    {**************************************************************************************}
    {* QUANDO ORIGEM EM DESMEMBRAMENTO DE VENDA (F11) UTILIZANDO CREDITOS É NECESSARIO    *}
    {* ESTORNAR POR CTR_SEQBAI DECRESCENTE, POIS O MESMO CREDITO PODE TER SIDO UTILIZADO  *}
    {* P/ BAIXAR "VARIOS" DOCUMENTOS EMITIDOS TENDO ASSIM "VARIAS" BAIXAS PARCIAIS DESTE  *}
    {* CREDITO COM O MESMO CTR_SEQCON. QUANDO FOR ESTORNAR ESTES CREDITOS É NECESSARIO    *}
    {* QUE SEJA EM ORDEM DECRESCENTE, OU SEJA, PELA ULTIMA BAIXA PARCIAL...               *}
    {**************************************************************************************}
    {* ESTA ALTERACAO É NECESSARIA POIS FOI LIBERADO FATURAR PEDIDOS COM DESMEMBRAMENTO   *}
    {* UTILIZANDO FORMA DE PAGAMENTO "CREDITO" NO F11 DO RESUMO DE CAIXA                  *}
    {**********************************************************************************JC**}
    strSQL := strSQL + '  ORDER BY ';
    if (Not fVerificaAcessoSistema('DIRRCXEST', strLoginUsuarioLogado)) then
      strSQL := strSQL + '    CTR_DTAREC, CTR_CODEMP, CTR_ESPDOC, CTR_NUMDUP, PARDUP '
    Else
      strSQL := strSQL + '    CTR_ESPDOC, NUMDUP, PARDUP, ORDBAI ';

    With qryDados Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := edtNumDup.Text;
      ParamByName('PARCEL').AsString := edtParcel.Text;
      ParamByName('CODEMP').AsString := edtCodEmp.Text;
      ParamByName('ESPDOC').AsString := edtEspDoc.Text;
      ParamByName('CODCLI').AsString := edtCodCli.Text;
      Open;

      pSetaClient(qryDados);

      cdsDados.Filtered := False;
      cdsDados.Filter   := '';
      cdsDados.IndexFieldNames := '';
      cdsDados.Close;
      cdsDados.SetProvider(cpvDados);
      cdsDados.Open;
      cdsDados.IndexFieldNames := 'CTR_ESPDOC;NUMDUP;PARDUP;ORDBAI;';

      pCarregaDadosCredito;

      (cdsDados.FieldByName('CTR_VALREC') As TFloatField).DisplayFormat := '#,##0.00';
    End;

  Except
    On E: ExceptionAutCom Do
    Begin
      pLimpaCampos;
      blnMudarFoco := False;
      pMensagemOk(E.Message);
    End;

    On E: Exception Do
    Begin
      pLimpaCampos;
      blnMudarFoco := False;
      pMensagensErro(E.Message,'');
    End;
  End;

end;

procedure TfrmEstornoReceber.pEstornaAdiantamentoCliente(cdsAux: TUniClientDataSet);
  Var
    strDuplicatas: String;
begin
  If Not TAdiantamento.fEstornarAdiantamento(cdsAux.FieldByName('AUTOINCREM').AsString) Then
    Raise ExceptionAutcom.Create('Ocorreu um erro ao estornar o adiantamento do cliente!');

  If Not fApagarDuplicatasFinanciamento(cdsAux.FieldByName('CTR_ESPDOC').AsString,
                                        cdsAux.FieldByName('NUMDUP').AsString,
                                        cdsAux.FieldByName('CTR_CODCLI').AsString,
                                        cdsAux.FieldByName('CTR_CODEMP').AsString,
                                        strDuplicatas) Then
  Begin
    Raise ExceptionAutcom.Create('Ocorreu um erro ao estornar o adiantamento do cliente!' + #13#10 + strDuplicatas);
  End;

end;

procedure TfrmEstornoReceber.pEstornaContasAPagar(const strAutCtp: String; dtaEstorn: TDate);
Var
  strCreDeb: String;
  qryGen: TUniQuery;
  repCtp: TCadPagRepository;
  repMovBan: TMovBanRepository;
  repBanCtp: TBanCtpRepository;
  AMovBan: TList<TMovBan>;
  lstLogBan: TList<TLogBan>;
  objLogBan : TLogBan;
  ACtaPag: TCadPag;
  strSeqLan: String;
begin
  repCtp    := TCadPagRepository.Create;
  repMovBan := TMovBanRepository.Create;
  repBanCtp := TBanCtpRepository.Create;

  qryGen := fCriaQuery;
  with qryGen do
  begin
    SQL.Clear;
    SQL.Text := ' SELECT * FROM CADPAG WHERE AUTOINCREM = :AUTCTP';
    ParamByName('AUTCTP').AsString := strAutCtp;
    Open;

    if not isEmpty then
    begin
      ACtaPag   := repCtp.fRetDuplicata(strAutCtp);

      if Assigned(ACtaPag) then
      begin
        strSeqLan  := '';

        {*****************************************************}
        {* LIMPANDO A ORIGEM DO REGISTRO PRINCIPAL DA MOVBAN *}
        {*REQ*155872***************************************MO*}
        repMovBan.pLimparOrigemPrincipal(ACtaPag);

        //Recuperando o lançamento da MovBan para efetuar o lançamento inverso
        AMovBan    := repMovBan.fRetDocumentos(FieldByName('CTP_SEQCON').AsInteger,
                                               FieldByName('CTP_CODEMP').AsString,
                                               FieldByName('CTP_DOCBAI').AsString);

        if ((assigned(AMovBan)) and (AMovBan.Count > 0)) then
        begin
          strCreDeb  := AMovBan[0].strCreDeb;

          if strCreDeb = 'C' then
            strCreDeb := 'D'
          else
            strCreDeb := 'C';

          //Gravando o novo movimento da tabela Movban
          AMovBan[0].dtaDtaLan := dtaEstorn;
          AMovBan[0].dtaHorLan := fNow;
          AMovBan[0].strCreDeb := strCreDeb;
          AMovBan[0].strHist01 := 'Ref. estorno ao pagamento de tarifas';
          AMovBan[0].strHist02 := '';
          AMovBan[0].strOrigem := repMovBan.fGetOrigem('CTP');
          AMovBan[0].strSeqLan := '';
          AMovBan[0].strAutInc := SNull;

          strSeqLan :=  repMovBan.fGravaMovBan(AMovBan[0]);

          //GRAVANDO A BANCTP
          repBanCtp.fAdd(ACtaPag.strNumDup,
                         ACtaPag.strParcel,
                         ACtaPag.strSerie,
                         ACtaPag.strCodEmp,
                         ACtaPag.strCodFor,
                         'Ref. estorno ao pagamento de tarifas',
                         '',
                         ACtaPag.strCodCTA,
                         ACtaPag.strEmpBai,
                         ACtaPag.intSeqBai,
                         ACtaPag.fltValPag,
                         ACtaPag.fltDinhei,
                         0,
                         0,
                         0);

          lstLogBan :=  repBanCtp.fGetList;
          If (Assigned(lstLogBan)) Then
           For objLogBan In lstLogBan Do
             TGravaLogBan.fGravaLogBan(objLogBan, ACtaPag.strCodEmp, strSeqLan);
        end;

        //Estornando a duplicata, Gravando a Del_CadPag e apagando o registro na tabela CadPag
        repCtp.pEstornaDuplicataSimples(ACtaPag, self.Name);
        repCtp.pGravaDelCadPag(ACtaPag, self.Name);
        repCtp.pDeletar(ACtaPag);

        AMovBan.Clear;

        repBanCtp.pClear;
      end;
    end;
    Close;
  end;
  FreeAndNil(qryGen);
end;

function TfrmEstornoReceber.fApagarDuplicatasFinanciamento(strEspDoc, strNumDoc,
  strCliFor, strCodEmp: String; Var strDuplicatas: String): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  Result := True;

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE * FROM ';
  strSQL := strSQL + '  CADREC   ';
  strSQL := strSQL + 'WHERE       ';
  strSQL := strSQL + '  CTR_ESPDOC = "FI"    AND ';
  strSQL := strSQL + '  CTR_DOCDIV = :NUMDOC AND ';
  strSQL := strSQL + '  CTR_ESPDIV = :ESPDOC AND ';
  strSQL := strSQL + '  CTR_CLIDIV = :CODCLI AND ';
  strSQL := strSQL + '  CTR_EMPDIV = :CODEMP     ';

  qryGen := fCriaQuery;

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODCLI').AsString := strCliFor;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    strDuplicatas := 'Duplicatas que já foram baixadas e portanto não será permitido cancelar o documento!';

    While Not Eof Do
    Begin
      If (FieldByName('CTR_VALDUP').AsFloat = 0) And (FieldByName('CTR_VRTRDV').AsFloat = 0) Then
      Begin
        Result := False;

        strDuplicatas := strDuplicatas + #13#10 +
                         FieldByName('CTR_NUMDUP').AsString +
                         FieldByName('CTR_PARCEL').AsString + ' - ' +
                         FieldByName('CTR_ESPDOC').AsString + ' Loja: ' +
                         FieldByName('CTR_CODEMP').AsString;
      End
      Else
        fApagaDuplicataContasReceber(qryGen, Self.Name);

      Next;
    End;

    Close;
  End;

  FreeAndNil(qryGen);

End;

{*****************************************}
{* USADO QUANDO UMA DUPLICATA NÃO POSSUI *}
{* BAIXAS PARCIAIS                       *}
{**************************************MV*}
Procedure TfrmEstornoReceber.pEstornaDuplicataSimples(cdsAux: TUniClientDataSet);
  Var
    strSQL       : String;
    fltNovoValOri: Double;
    qryGen       : TUniQuery;
begin

  Try
    qryGen := fCriaQuery;

    fltNovoValOri := cdsAux.FieldByName('CTR_VALREC').AsFloat -
                     cdsAux.FieldByName('CTR_VALJUR').AsFloat -
                     cdsAux.FieldByName('CTR_VALCOB').AsFloat +
                     cdsAux.FieldByName('CTR_VALDES').AsFloat;

    strSQL := '';
    strSQL := strSQL + ' UPDATE ';
    strSQL := strSQL + cdsAux.FieldByName('CTR_TABELA').AsString;
    strSQL := strSQL +  ' SET ';
    strSQL := strSQL + '    CTR_VALIPI = (CTR_VALIPI * (1 + IFNULL(:VALORI / CTR_VALDUP, 0))),  ';
    strSQL := strSQL + '    CTR_VALRET = (CTR_VALRET * (1 + IFNULL(:VALORI / CTR_VALDUP, 0))),  ';
    strSQL := strSQL + '    CTR_VALACE = (CTR_VALACE * (1 + IFNULL(:VALORI / CTR_VALDUP, 0))),  ';
    strSQL := strSQL + '    CTR_VALFRE = (CTR_VALFRE * (1 + IFNULL(:VALORI / CTR_VALDUP, 0))),  ';
    strSQL := strSQL + '    CTR_VALCBS = (CTR_VALCBS * (1 + IFNULL(:VALORI / CTR_VALDUP, 0))),  ';
    strSQL := strSQL + '    CTR_VALIBS = (CTR_VALIBS * (1 + IFNULL(:VALORI / CTR_VALDUP, 0))),  ';
    strSQL := strSQL + '    CTR_VAL_IS = (CTR_VAL_IS * (1 + IFNULL(:VALORI / CTR_VALDUP, 0))),  ';
    strSQL := strSQL + '    CTR_VALORI = IF(IFNULL(CTR_VALANT,0) = 0, :VALORI, CTR_VALANT), ';
    strSQL := strSQL + '    CTR_VALDUP = :VALORI, ';
    strSQL := strSQL + '    CTR_VALJUR = 0, ';
    strSQL := strSQL + '    CTR_VALCOB = 0, ';
    strSQL := strSQL + '    CTR_VALDES = 0, ';
    strSQL := strSQL + '    CTR_VALREC = 0, ';
    strSQL := strSQL + '    CTR_DESSUJ = :DESANT, ';
    strSQL := strSQL + '    CTR_JURSUJ = :JURANT, ';
    strSQL := strSQL + '    CTR_DESCOB = :COBANT, ';
    strSQL := strSQL + '    CTR_JURANT = 0, ';
    strSQL := strSQL + '    CTR_DESANT = 0, ';
    strSQL := strSQL + '    CTR_COBANT = 0, ';
    strSQL := strSQL + '    CTR_DTABAI = NULL, ';
    strSQL := strSQL + '    CTR_DTAREC = NULL, ';
    strSQL := strSQL + '    CTR_CARBAI = NULL, ';
    strSQL := strSQL + '    CTR_DTABAN = NULL, ';
    strSQL := strSQL + '    CTR_PORBAI = NULL, ';
    strSQL := strSQL + '    CTR_HISBAI = NULL, ';
    strSQL := strSQL + '    CTR_DOCBAI = NULL, ';
    strSQL := strSQL + '    CTR_EMPBAI = NULL, ';
    strSQL := strSQL + '    CTR_CTABAI = NULL, ';
    strSQL := strSQL + '    CTR_OPEBAI = NULL, ';
    strSQL := strSQL + '    CTR_CREDIN = NULL, ';
    strSQL := strSQL + '    CTR_CRECAR = NULL, ';
    strSQL := strSQL + '    CTR_CRECHP = NULL, ';
    strSQL := strSQL + '    CTR_CRECHV = NULL, ';
    strSQL := strSQL + '    CTR_CREORD = NULL, ';
    strSQL := strSQL + '    CTR_DINHEI = 0,    ';
    strSQL := strSQL + '    CTR_CHQAVI = 0,    ';
    strSQL := strSQL + '    CTR_CHQPRE = 0,    ';
    strSQL := strSQL + '    CTR_CARTAO = 0,    ';
    strSQL := strSQL + '    CTR_ORDPAG = 0,    ';
    strSQL := strSQL + '    CTR_RECDIN = "N",  ';
    strSQL := strSQL + '    CTR_RECCHE = "N",  ';
    strSQL := strSQL + '    CTR_RECPRE = "N",  ';
    strSQL := strSQL + '    CTR_RECCAR = "N",  ';
    strSQL := strSQL + '    CTR_RECORD = "N",  ';
    strSQL := strSQL + '    CTR_BAIMAN = "N",  ';
    strSQL := strSQL + '    CTR_RESCAI = 0,    ';
    strSQL := strSQL + '    CTR_ORIF11 = "N",  ';
    strSQL := strSQL + '    CTR_AUTCTP = NULL, ';
    strSQL := strSQL + '    CTR_MOVDES = NULL, ';
    strSQL := strSQL + '    CTR_JURBAI = 0.00, ';
    strSQL := strSQL + '    CTR_DESBAI = 0.00, ';
    strSQL := strSQL + '    CTR_VALCOR = 0.00, ';
    strSQL := strSQL + '    CTR_AMORTI = 0.00, ';
    strSQL := strSQL + '    CTR_SEQCON = 0,    ';
    strSQL := strSQL + '    CTR_RECPIX = "N",  ';
    strSQL := strSQL + '    CTR_EMPPIX = NULL, ';
    strSQL := strSQL + '    CTR_TX_PIX = NULL  ';

    If Not fPedidoTemBoletoAdiantamento(cdsAux.FieldByName('NUMDUP').AsString,
                                        cdsAux.FieldByName('CTR_ESPDOC').AsString,
                                        cdsAux.FieldByName('CTR_CODEMP').AsString) Then
    Begin
      strSQL := strSQL + '    ,CTR_ADTCLI = "N"   ';
    End;

    If fCfgSis('RMOTES', varBoolean) Then
      strSQL := strSQL + '    ,CTR_MOTEST = :MOTEST ';

    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '   CTR_SEQBAI = 0 ';

    {*****************************************}
    {* ESTORNA A DUPLICATA                   *}
    {**************************************MV*}
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      if ((cdsAux.FieldByName('CTR_SEQBAI').AsInteger = 0) And (Pos('RETORNO CONSIG',cdsAux.FieldByName('CTR_HIST01').AsString) > 0) And (fltNovoValOri > 0))  then
      Begin
        fltNovoValOri := fltNovoValOri * -1;
      End;

      ParamByName('VALORI').AsFloat  := fltNovoValOri;
      ParamByName('NUMDUP').AsString := cdsAux.FieldByName('NUMDUP').AsString;
      ParamByName('PARCEL').AsString := cdsAux.FieldByName('PARDUP').AsString;
      ParamByName('ESPDOC').AsString := cdsAux.FieldByName('CTR_ESPDOC').AsString;
      ParamByName('CODEMP').AsString := cdsAux.FieldByName('CTR_CODEMP').AsString;
      ParamByName('CODCLI').AsString := cdsAux.FieldByName('CTR_CODCLI').AsString;
      ParamByName('JURANT').AsFloat  := cdsAux.FieldByName('CTR_JURANT').AsFloat;
      ParamByName('DESANT').AsFloat  := cdsAux.FieldByName('CTR_DESANT').AsFloat;
      ParamByName('COBANT').AsFloat  := cdsAux.FieldByName('CTR_COBANT').AsFloat;

      If fCfgSis('RMOTES', varBoolean) Then
         ParamByName('MOTEST').AsString  := strMotEst;

      ExecSQL;
      Close;
    End;

    {*********************************}
    {* GRAVAR TABELA DO SISTEMA DEPS *}
    {******************************AJ*}
    If (cdsAux.FieldByName('CTR_TABELA').AsString = 'CADREC') And
       (fCfgSis('USADEP') = 'S') Then
      TValidacoesSistemaDEPS.pGravaLancamentoSistemaDEPS(Concat(cdsAux.FieldByName('NUMDUP').AsString, '-',
                                                                cdsAux.FieldByName('PARDUP').AsString, '-',
                                                                cdsAux.FieldByName('CTR_ESPDOC').AsString, '-',
                                                                cdsAux.FieldByName('CTR_CODEMP').AsString, '-',
                                                                cdsAux.FieldByName('CTR_CODCLI').AsString, '-',
                                                                cdsAux.FieldByName('CTR_SEQBAI').AsString),
                                                         'ESTORNO');

    {****************}
    {* GRAVA LOGCTR *}
    {*************JS*}
    untLogCtr.GravaLogCtr(cdsAux.FieldByName('AUTOINCREM').AsString, 'ESTORNO', Self.Name + IIF(blnResCai, 'RESCAI',''), objLiberacao.strOperador,0,0,LHistComplementar);

    If cdsAux.FieldByName('CTR_TABELA').AsString = 'CADREC' Then
      AtualizaBOLCTRBoletosEstornoTotal(cdsAux.FieldByName('AUTOINCREM').AsString);

    If VS_strHabilitarCRM And (Not fEmptyStr(fCfgSis('OCOFIN', varString))) Then
    Begin
      TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(cdsAux.FieldByName('NUMDUP').AsString,
                                               cdsAux.FieldByName('CTR_ESPDOC').AsString,
                                               cdsAux.FieldByName('CTR_CODEMP').AsString,
                                               cdsAux.FieldByName('CTR_CODCLI').AsString,
                                               cdsAux.FieldByName('PARDUP').AsString,
                                               strLoginUsuarioLogado,
                                               fRetCgcCpf(cdsAux.FieldByName('CTR_CODCLI').AsString),
                                               afcEstorno, False, True);
    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Raise Exception.Create('Erro ao tentar estornar duplicata: ' + E.Message);
    End;
  End;

  FreeAndNil(qryGen);
end;

procedure TfrmEstornoReceber.FormCreate(Sender: TObject);
  Var
    LCriou: Boolean;
begin
  inherited;
  qryMsgCli := fCriaQuery(nil);
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  strEstRec := '';

  objLiberacao := TLiberacao.Create;
  objLock := TLock.Create;

  edtCodEmp.Text := VS_strCodEmp;
  pCarregaEmpresa;

  cdsDados.Close;

  edtNumDup.TamCampo  := fTamDocCadRec;
  edtNumDup.MaxLength := fTamDocCadRec;

  blnFecharForm := False;
  intConfirma := -1;
  blnEstornoAutomatico := False;
  blnNotaDenegada := False;

  strCodigoCaixa := '';
  blnFechadoCaixa := False;
  FValorTotalPix := 0;

  FobjFulFillmentLogBuilder := Nil;

  FUtilizaContabilidadeERecebidoPorAdiantamento := False;

  If Assigned(frwk) Then
    FreeAndNil(frwk);

  fCriaObjManager(LCriou);
end;

procedure TfrmEstornoReceber.FormDestroy(Sender: TObject);
begin
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  FreeAndNil(objLock);

  if Assigned(AClientesMarcados) then
    FreeAndNil(AClientesMarcados);
  inherited;

end;

procedure TfrmEstornoReceber.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10   : Begin
                 Key := 0;
                 btnConfirma.Click;
               End;
  End;
end;

procedure TfrmEstornoReceber.pLimpaCampos;
begin
  edtNomCli.Clear;
  edtNumDup.Clear;
  edtEspDoc.Clear;
  edtCodCli.Clear;
  edtParcel.Text := 'A';
  cdsDados.Close;

  pSetFocus(edtNumDup);
  objLock.pDestravarTodos;
  FValorTotalPix := 0;

  blnFecharForm := False;

  If Assigned(FRegistroMovPix) Then
    FreeAndNil(FRegistroMovPix);
end;

procedure TfrmEstornoReceber.pLogChq(qryLog: TUniQuery);
  Var
    repCadChq: TCadChqRepository;
begin
  Try
    repCadChq := TCadChqRepository.Create;
    repCadChq.pGravaLog(qryLog.FieldByName('CHQ_CODBCO').AsString,
                        qryLog.FieldByName('CHQ_NUMAGE').AsString,
                        qryLog.FieldByName('CHQ_CONCOR').AsString,
                        qryLog.FieldByName('CHQ_NUMCHQ').AsString,
                        'DELETANDO (frmEstornoCtaReceber.pLogChq)');

    FreeAndNil(repCadChq);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

Function TfrmEstornoReceber.fEstornaMovCar(intSeqCon: Integer; strEmpRcx: String; dtaDtaRec: TDateTime): Boolean;
  Var
    objMovCar: TMovCar;
    objRep   : TMovCarRepository;
Begin
  Result := True;

  If intSeqCon <= 0 Then
  Begin
    strDocsNaoEnc := strDocsNaoEnc + 'Cartões';
    Exit;
  End;

  Try
    objRep := TMovCarRepository.Create();
    For objMovCar in objRep.fGetMovCarsRcx(intSeqCon, strEmpRcx) Do
      objRep.pExcluir(objMovCar, Self.Name);

    FreeAndNil(objRep);
  Except
    Raise;
  End;
End;

function TfrmEstornoReceber.fPedePortadorCaixa(Var strPorBai: String): Boolean;
  Var
    frmDigPortador : TfrmDigPortador;
Begin
  Try
    pMensagemOk('Duplicata(s) baixada(s) pelo caixa em dia anterior, ' +
                'portanto será solicitado um portador para débito do lançamento da movimentação bancária!');

    pCriarFormularios(TfrmDigPortador, frmDigPortador);
    frmDigPortador.Caption := 'Informe o Portador para Débito';
    frmDigPortador.bolMostraVendedor := False;
    frmDigPortador.FValidaPermissaoEstornoReceber := True;
    frmDigPortador.ShowModal;

    Result := frmDigPortador.blnConfirma;

    If Result And fEmptyStr(frmDigPortador.strCodPor) Then
      Result := False;

    If Result Then
    Begin
      {*REQ*145940**********RP*}
      If Not fEmpresaTemAcessoPortador(frmDigPortador.strCodPor, edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        Exit(False);
      End;

      strPorBai := frmDigPortador.strCodPor;
    End;

    pFreeAndNil(frmDigPortador);
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[TfrmEstornoReceber.fPedePortadorCaixa]');
    End;
  End;
End;

function TfrmEstornoReceber.fPedePortador(Var strPorBai: String): Boolean;
  Var
    blnPedPor: Boolean;
    cdsAux   : TUniClientDataSet;
    frmDigPortador : TfrmDigPortador;
Begin
  Result := True;
  Try
    blnPedPor := False;

    cdsAux := TUniClientDataSet.Create(Self);
    cdsAux.Data := cdsDados.Data;

    cdsAux.Filter := 'CTR_MARDES = ' + QuotedStr('M');
    cdsAux.Filtered := True;

    cdsAux.First;
    While Not cdsAux.Eof Do
    Begin

      If Not cdsAux.FieldByName('CTR_DTAREC').IsNull Then
      Begin
        If fEmptyStr(cdsAux.FieldByName('CTR_PORBAI').AsString) Or
           fEmptyStr(fRetNomPortador(cdsAux.FieldByName('CTR_PORBAI').AsString)) Then
        Begin
          blnPedPor := True;
          Break;
        End
        Else
          strPorBai := cdsAux.FieldByName('CTR_PORBAI').AsString;
      End;

      cdsAux.Next;
    End;
    
    If blnPedPor Then
    Begin
      fMensagem('', 'Há duplicata(s) com o Portador da baixa em branco!', ['&Ok']);
      pCriarFormularios(TfrmDigPortador, frmDigPortador);
      frmDigPortador.Caption := 'Informe o Portador para o estorno';
      frmDigPortador.ShowModal;
      Result := frmDigPortador.blnConfirma;

      If Result Then
      Begin
        {*REQ*145940**********RP*}
        If Not fEmpresaTemAcessoPortador(frmDigPortador.strCodPor, edtCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Exit(False);
        End;

        strPorBai := frmDigPortador.strCodPor;
      End;

      FreeAndNil(frmDigPortador);
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(cdsAux);
End;

{*****************************************}
{* MONTA MENSAGEM DE DUPLICATA ESTORNADA *}
{* RQ: 30648 / 5349 *******************BB*}
function TfrmEstornoReceber.fGetMsgEstorno(strNumDup, strSeqBai, strEspDoc, strCodEmp: String; dtaDtaRec:TDateTime; fltValRec: Double): String;
begin
  Result := '<<csq>>' + // <<STRING QUEBRA DE LINHA>>
            ' - DUPLICATA ESTORNADA: ' + FormatDateTime('dd/mm/yyyy', fNow()) +
            ' ' + strNumDup + ' - SEQ: ' + strSeqBai +
            ' - ESP: ' + strEspDoc + ' - EMP: ' + strCodEmp +
            ' - DTA. REC.: ' + FormatDateTime('dd/mm/yyyy', dtaDtaRec) +
            ' - VR. REC.: '  + FormatFloat('#,##0.00', fltValRec);
end;

procedure TfrmEstornoReceber.pEstornaDuplicataParcial(cdsAux: TUniClientDataSet);
  Var
    strSQL           : String;
    strMsgEstorno    : String;
    qryGen           : TUniQuery;
    LValorAnterior   : Double;
begin
  Try
    qryGen := fCriaQuery;
    LValorAnterior := 0;

    If (cdsAux.FieldByName('CTR_VALANT').AsFloat = cdsAux.FieldByName('CTR_VALORI').AsFloat) Then
      LValorAnterior := RetornaValorAnterior(cdsAux.FieldByName('CTR_SEQCON').AsInteger,
                                             cdsAux.FieldByName('CTR_EMPBAI').AsString,
                                             cdsAux.FieldByName('NUMDUP').AsString,
                                             cdsAux.FieldByName('PARDUP').AsString,
                                             cdsAux.FieldByName('CTR_ESPDOC').AsString,
                                             cdsAux.FieldByName('CTR_CODEMP').AsString,
                                             cdsAux.FieldByName('CTR_CODCLI').AsString,
                                             cdsAux.FieldByName('CTR_SEQBAI').AsInteger);

      If (cdsAux.FieldByName('CTR_VALANT').AsFloat = cdsAux.FieldByName('CTR_GRVORI').AsFloat) And
         (cdsAux.FieldByName('CTR_SEQBAI').AsInteger > 1) Then
      LValorAnterior := RetornaValorAnteriorBaixaTotal(cdsAux.FieldByName('CTR_SEQCON').AsInteger,
                                                       cdsAux.FieldByName('CTR_EMPBAI').AsString,
                                                       cdsAux.FieldByName('NUMDUP').AsString,
                                                       cdsAux.FieldByName('PARDUP').AsString,
                                                       cdsAux.FieldByName('CTR_ESPDOC').AsString,
                                                       cdsAux.FieldByName('CTR_CODEMP').AsString,
                                                       cdsAux.FieldByName('CTR_CODCLI').AsString);

    If (LValorAnterior = 0) Then
      LValorAnterior := cdsAux.FieldByName('CTR_VALANT').AsFloat;


    strMsgEstorno := fGetMsgEstorno( cdsAux.FieldByName('CTR_NUMDUP').AsString,
                                     cdsAux.FieldByName('CTR_SEQBAI').AsString,
                                     cdsAux.FieldByName('CTR_ESPDOC').AsString,
                                     cdsAux.FieldByName('CTR_CODEMP').AsString,
                                     cdsAux.FieldByName('CTR_DTAREC').Value,
                                     cdsAux.FieldByName('CTR_VALREC').Value);

    strSQL := '';
    strSQL := strSQL + 'UPDATE ' + cdsAux.FieldByName('CTR_TABELA').AsString + ' SET   ';
    strSQL := strSQL + '  CTR_VALIPI = (CTR_VALIPI * (1 + (:VALORI/CTR_VALDUP))),      ';
    strSQL := strSQL + '  CTR_VALRET = (CTR_VALRET * (1 + (:VALORI/CTR_VALDUP))),      ';
    strSQL := strSQL + '  CTR_VALACE = (CTR_VALACE * (1 + (:VALORI/CTR_VALDUP))),      ';
    strSQL := strSQL + '  CTR_VALFRE = (CTR_VALFRE + :VALFRE),                                        ';
    strSQL := strSQL + '  CTR_VALCBS = (CTR_VALCBS * (1 + (:VALORI/CTR_VALDUP))),      ';
    strSQL := strSQL + '  CTR_VALIBS = (CTR_VALIBS * (1 + (:VALORI/CTR_VALDUP))),      ';
    strSQL := strSQL + '  CTR_VAL_IS = (CTR_VAL_IS * (1 + (:VALORI/CTR_VALDUP))),      ';
    strSQL := strSQL + '  CTR_VALORI = IF(:GRVORI = 0, CTR_VALDUP, :GRVORI),           ';

    If cdsAux.FieldByName('CTR_SEQBAI').AsInteger = 1 Then
      strSQL := strSQL + '  CTR_VALDUP = CTR_VALORI, '
    Else
    Begin
      strSQL := strSQL + '  CTR_VALDUP = IF(:VALANT = 0, CTR_VALDUP, :VALANT), ';
    End;

    strSQL := strSQL + '  CTR_DTAVEN = IF(:VALANT = 0, CTR_DTAVEN, :DTAVEN),           ';
    strSQL := strSQL + '  CTR_DESSUJ = :DESANT,                                        ';
    strSQL := strSQL + '  CTR_JURSUJ = :JURANT,                                        ';
    strSQL := strSQL + '  CTR_DESCOB = :COBANT,                                        ';
    strSQL := strSQL + '  CTR_JURANT = 0,                                              ';
    strSQL := strSQL + '  CTR_DESANT = 0,                                              ';
    strSQL := strSQL + '  CTR_COBANT = 0,                                              ';
    strSQL := strSQL + '  CTR_CTABAI = NULL,                                           ';
    strSQL := strSQL + '  CTR_PORBAI = NULL,                                           ';
    strSQL := strSQL + '  CTR_DOCBAI = NULL,                                           ';
    strSQL := strSQL + '  CTR_HISBAI = NULL,                                           ';
    strSQL := strSQL + '  CTR_OPEBAI = NULL,                                           ';
    strSQL := strSQL + '  CTR_VALREC = 0,                                              ';
    strSQL := strSQL + '  CTR_DTAREC = NULL,                                           ';
    strSQL := strSQL + '  CTR_DTABAI = NULL,                                           ';
    strSQL := strSQL + '  CTR_DTABAN = NULL,                                           ';
    strSQL := strSQL + '  CTR_EMPBAI = NULL,                                           ';
    strSQL := strSQL + '  CTR_VALDES = 0,                                              ';
    strSQL := strSQL + '  CTR_VALJUR = 0,                                              ';
    strSQL := strSQL + '  CTR_CARBAI = NULL,                                           ';
    strSQL := strSQL + '  CTR_VALCOB = 0,                                              ';
    strSQL := strSQL + '  CTR_ORIF11 = "N",                                            ';
    strSQL := strSQL + '  CTR_SEQMOD = NULL,                                           ';
    strSQL := strSQL + '  CTR_CREDIN = NULL,                                           ';
    strSQL := strSQL + '  CTR_CRECAR = NULL,                                           ';
    strSQL := strSQL + '  CTR_CRECHP = NULL,                                           ';
    strSQL := strSQL + '  CTR_CRECHV = NULL,                                           ';
    strSQL := strSQL + '  CTR_CREORD = NULL,                                           ';
    strSQL := strSQL + '  CTR_DINHEI = 0,                                              ';
    strSQL := strSQL + '  CTR_CHQAVI = 0,                                              ';
    strSQL := strSQL + '  CTR_CHQPRE = 0,                                              ';
    strSQL := strSQL + '  CTR_CARTAO = 0,                                              ';
    strSQL := strSQL + '  CTR_RECDIN = "N",                                            ';
    strSQL := strSQL + '  CTR_RECCHE = "N",                                            ';
    strSQL := strSQL + '  CTR_RECPRE = "N",                                            ';
    strSQL := strSQL + '  CTR_RECCAR = "N",                                            ';
    strSQL := strSQL + '  CTR_RECPIX = "N",                                            ';
    strSQL := strSQL + '  CTR_RESCAI = 0,                                              ';
    strSQL := strSQL + '  CTR_DIFORI = CTR_DIFORI - :DIFORI,                           ';
    strSQL := strSQL + '  CTR_PERDPO = :PERDPO,                                        ';
    strSQL := strSQL + '  CTR_LINDIG = :LINDIG,                                        ';

    If Not fPedidoTemBoletoAdiantamento(cdsAux.FieldByName('NUMDUP').AsString,
                                        cdsAux.FieldByName('CTR_ESPDOC').AsString,
                                        cdsAux.FieldByName('CTR_CODEMP').AsString) Then
    Begin
      strSQL := strSQL + '    CTR_ADTCLI = "N",   ';
    End;

    {*****************************}
    {* GRAVA MENSAGEM DE ESTORNO *}
    {**************************BB*}
    strSQL := strSQL + '  CTR_HIST01 = CONCAT(CTR_HIST01, " ", :HIST01)                ';
    strSQL := strSQL + 'WHERE                                                          ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND                                     ';
    strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND                                     ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND                                     ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND                                     ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND                                     ';
    strSQL := strSQL + '  CTR_SEQBAI = 0                                               ';

    {*****************************************}
    {* ESTORNA A DUPLICATA PRINCIPAL         *}
    {**************************************MV*}
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ParamByName('VALORI').AsFloat := cdsAux.FieldByName('CTR_VALREC').AsFloat;
    qryGen.ParamByName('VALANT').AsFloat := LValorAnterior;
    qryGen.ParamByName('GRVORI').AsFloat    := cdsAux.FieldByName('CTR_GRVORI').AsFloat;
    qryGen.ParamByName('DTAVEN').AsDateTime := cdsAux.FieldByName('CTR_DTAVEN').AsDateTime;
    qryGen.ParamByName('JURANT').AsFloat    := cdsAux.FieldByName('CTR_JURANT').AsFloat;
    qryGen.ParamByName('DESANT').AsFloat    := cdsAux.FieldByName('CTR_DESANT').AsFloat;
    qryGen.ParamByName('COBANT').AsFloat    := cdsAux.FieldByName('CTR_COBANT').AsFloat;
    qryGen.ParamByName('NUMDUP').AsString   := cdsAux.FieldByName('NUMDUP').AsString;
    qryGen.ParamByName('PARCEL').AsString   := cdsAux.FieldByName('PARDUP').AsString;
    qryGen.ParamByName('ESPDOC').AsString   := cdsAux.FieldByName('CTR_ESPDOC').AsString;
    qryGen.ParamByName('CODEMP').AsString   := cdsAux.FieldByName('CTR_CODEMP').AsString;
    qryGen.ParamByName('CODCLI').AsString   := cdsAux.FieldByName('CTR_CODCLI').AsString;
    qryGen.ParamByName('DIFORI').AsFloat    := cdsAux.FieldByName('CTR_DIFORI').AsFloat;
    qryGen.ParamByName('PERDPO').AsFloat    := cdsAux.FieldByName('CTR_PERDPO').AsFloat;
    qryGen.ParamByName('LINDIG').AsString   := cdsAux.FieldByName('CTR_LINDIG').AsString;
    qryGen.ParamByName('VALFRE').AsFloat    := fCalculaFreteEstornaDuplicatasParcial(cdsAux);

    qryGen.ParamByName('HIST01').AsString   := strMsgEstorno;

    qryGen.ExecSQL;
    qryGen.Close;

    If cdsAux.FieldByName('CTR_TABELA').AsString = 'CADREC' Then
        AtualizaBOLCTRBoletosEstornoParcial(fCampoTabela('AUTOINCREM', 'CADREC',
                                              ['CTR_NUMDUP', 'CTR_PARCEL', 'CTR_ESPDOC', 'CTR_CODEMP', 'CTR_CODCLI', 'CTR_SEQBAI'],
                                              [cdsAux.FieldByName('NUMDUP').AsString, cdsAux.FieldByName('PARDUP').AsString,
                                               cdsAux.FieldByName('CTR_ESPDOC').AsString, cdsAux.FieldByName('CTR_CODEMP').AsString,
                                               cdsAux.FieldByName('CTR_CODCLI').AsString, 0]),
                                            cdsAux.FieldByName('CTR_SEQBAI').AsString  = '1');

    {*********************************}
    {* GRAVAR TABELA DO SISTEMA DEPS *}
    {******************************AJ*}
    If (cdsAux.FieldByName('CTR_TABELA').AsString = 'CADREC') And
       (fCfgSis('USADEP') = 'S') Then
      TValidacoesSistemaDEPS.pGravaLancamentoSistemaDEPS(Concat(cdsAux.FieldByName('NUMDUP').AsString, '-',
                                                                cdsAux.FieldByName('PARDUP').AsString, '-',
                                                                cdsAux.FieldByName('CTR_ESPDOC').AsString, '-',
                                                                cdsAux.FieldByName('CTR_CODEMP').AsString, '-',
                                                                cdsAux.FieldByName('CTR_CODCLI').AsString, '-',
                                                                cdsAux.FieldByName('CTR_SEQBAI').AsString),
                                                         'ESTORNO');

    {****************}
    {* GRAVA LOGCTR *}
    {*************JS*}
    untLogCtr.GravaLogCtr(cdsAux.FieldByName('NUMDUP').AsString,
                          cdsAux.FieldByName('CTR_ESPDOC').AsString,
                          cdsAux.FieldByName('CTR_CODCLI').AsString,
                          cdsAux.FieldByName('CTR_CODEMP').AsString,
                          cdsAux.FieldByName('PARDUP').AsString, 0,
                          'ALTERAÇÃO DE ESTORNO',
                          Self.Name + IIF(blnResCai, 'RESCAI',''),
                          objLiberacao.strOperador,
                          LHistComplementar);

    If VS_strHabilitarCRM And (Not fEmptyStr(fCfgSis('OCOFIN', varString))) Then
    Begin
      TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(cdsAux.FieldByName('NUMDUP').AsString,
                                               cdsAux.FieldByName('CTR_ESPDOC').AsString,
                                               cdsAux.FieldByName('CTR_CODEMP').AsString,
                                               cdsAux.FieldByName('CTR_CODCLI').AsString,
                                               cdsAux.FieldByName('PARDUP').AsString,
                                               strLoginUsuarioLogado,
                                               fRetCgcCpf(cdsAux.FieldByName('CTR_CODCLI').AsString),
                                               afcEstorno);
    End;

    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE * FROM ';
    strSQL := strSQL + cdsAux.FieldByName('CTR_TABELA').AsString;
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '   CTR_SEQBAI = ' + QuotedStr(cdsAux.FieldByName('CTR_SEQBAI').AsString);

    {**************************************}
    {* DELETA A DUPLICATA PARCIAL         *}
    {***********************************MV*}
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := cdsAux.FieldByName('NUMDUP').AsString;
      ParamByName('PARCEL').AsString := cdsAux.FieldByName('PARDUP').AsString;
      ParamByName('ESPDOC').AsString := cdsAux.FieldByName('CTR_ESPDOC').AsString;
      ParamByName('CODEMP').AsString := cdsAux.FieldByName('CTR_CODEMP').AsString;
      ParamByName('CODCLI').AsString := cdsAux.FieldByName('CTR_CODCLI').AsString;
      Open;

      fApagaDuplicataContasReceber(qryGen, Self.Name, 'ESTORNO', False, True);
      Close;
    End;

  Except
    On E: Exception Do
    Begin
      FreeAndNil(qryGen);
      Raise Exception.Create('Erro: ' + E.Message);
    End;
  End;

  FreeAndNil(qryGen);
end;

procedure TfrmEstornoReceber.pMarcaDuplicata(strMarDes: String);
  Var
    strChaLck: String;
    blnErro: Boolean;

    LChaveTravada: String;
begin
  strChaLck := 'CADREC' +
               cdsDados.FieldByName('NUMDUP').AsString +
               cdsDados.FieldByName('CTR_ESPDOC').AsString +
               cdsDados.FieldByName('CTR_CODEMP').AsString +
               cdsDados.FieldByName('CTR_CODCLI').AsString;

  blnErro := False;
  LChaveTravada := '';

  If strMarDes = 'M' Then
  Begin

    If Not fLockedByCurrentConnection(strChaLck) And Not fEmptyStr(fGetHostLock(strChaLck)) Then
    Begin
      LChaveTravada := strChaLck;
      blnErro := True;
    End;

    strChaLck := strChaLck + cdsDados.FieldByName('PARDUP').AsString;
    If Not fLockedByCurrentConnection(strChaLck) And Not fEmptyStr(fGetHostLock(strChaLck)) Then
    Begin
      LChaveTravada := strChaLck;
      blnErro := True;
    End;

    strChaLck := strChaLck + cdsDados.FieldByName('CTR_SEQBAI').AsString;
    If Not fLockedByCurrentConnection(strChaLck) And Not objLock.fLock_Unlock(strChaLck, True, False) Then
    Begin
      LChaveTravada := strChaLck;
      blnErro := True;
    End;
  End
  Else
  Begin
    strChaLck := strChaLck + cdsDados.FieldByName('PARDUP').AsString + cdsDados.FieldByName('CTR_SEQBAI').AsString;
    objLock.fLock_Unlock(strChaLck, False);
  End;

  if blnErro then
  begin
    pEmitirMensagem('', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(LChaveTravada));
    blnDocumentosOK := False;
    Exit;
  end;

  cdsDados.Edit;
  cdsDados.FieldByName('CTR_MARDES').AsString := strMarDes;
  cdsDados.Post;
end;

function TfrmEstornoReceber.PossuiFaturamentoDoPedidoAntesDoRecebimentoDoBoletoAdiantamento(
  Adataset: TDataset): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  If Not ADataset.FieldByName('CTR_ESPDOC').AsString.Equals('PD') Then
    Exit(False);

  LConsulta := fCriaQuery;
  Try
    LConsulta.SQL.Text := 'SELECT COUNT(0) AS TOTAL ' +
                          'FROM MOVDET D ' +
                          'LEFT JOIN ADTCLI A ON A.ADT_NUMDOC=D.DET_NUM_PD ' +
                          '                  AND A.ADT_ESPDOC=D.DET_ESP_PD ' +
                          '                  AND A.ADT_CODEMP=D.DET_EMP_PD ' +
                          'WHERE D.DET_NUM_PD=:NUM_PD ' +
                          '  AND D.DET_ESP_PD="PD" ' +
                          '  AND D.DET_EMP_PD=:EMP_PD ' +
                          '  AND D.DET_DTAENT<=:DTABAI ' +
                          '  AND A.ADT_NUMDOC IS NULL ';

    LConsulta.ParamByName('NUM_PD').AsString := ADataset.FieldByName('NUMDUP').AsString;
    LConsulta.ParamByName('EMP_PD').AsString := ADataset.FieldByName('CTR_CODEMP').AsString;
    LConsulta.ParamByName('DTABAI').AsDateTime := ADataset.FieldByName('CTR_DTABAI').AsDateTime;
    LConsulta.Open;

    Result := LConsulta.FieldByName('TOTAL').AsInteger > 0;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

function TfrmEstornoReceber.PossuiRegistroNaMovPix: Boolean;
begin
  If Not Assigned(FRegistroMovPix) Then
    Exit(False);

  If FRegistroMovPix.IsEmpty Then
    Exit(False);

  Result := True;
end;

procedure TfrmEstornoReceber.pRealizaLCDocumentosTransferidos(intSeqConEstorno: Integer; strCodEmpEstorno: String; dtaDtaCad: TDateTime; AOperadorCaixa: String);
  Var
    qryChq: TUniQuery;
    qryCrt: TUniQuery;

    fltTotalChqVis: Double;
    fltTotalChqPre: Double;
    fltTotalCartao: Double;
begin
  fltTotalChqVis := 0;
  fltTotalChqPre := 0;
  fltTotalCartao := 0;

  Try
    qryChq := fCarregaChequesTransferidos(intSeqConEstorno, strCodEmpEstorno, dtaDtaCad);
    While (Not qryChq.Eof) Do
    Begin
      If qryChq.FieldByName('CHQ_DTACAD').AsDateTime = qryChq.FieldByName('CHQ_DTAVEN').AsDateTime Then
        fltTotalChqVis := fltTotalChqVis + qryChq.FieldByName('CHQ_VALCHQ').AsFloat
      ELse fltTotalChqPre := fltTotalChqPre + qryChq.FieldByName('CHQ_VALCHQ').AsFloat;

      qryChq.Next;
    End;

    FreeAndNil(qryChq);

    qryCrt := fCarregaCartoesTransferidos(intSeqConEstorno, strCodEmpEstorno, dtaDtaCad);
    While (Not qryCrt.Eof) Do
    Begin
      fltTotalCartao := fltTotalCartao + qryCrt.FieldByName('MCA_VALSTA').AsFloat;
      qryCrt.Next;
    End;

    FreeAndNil(qryCrt);

    If Not fLancaLCTransferidos(fltTotalChqVis, fltTotalChqPre, fltTotalCartao, 'REF. A DOCUMENTOS TRANSFERIDOS.', AOperadorCaixa) Then
    Begin
      Raise Exception.Create('Não foi possível gravar o caixa dos documentos transferidos.');
    End;
  Except
    On E: Exception Do
      Raise E;
  End;
end;

function TfrmEstornoReceber.fLancaLCTransferidos(fltTotalChqVis, fltTotalChqPre, fltTotalCartao: Double; strHistorico: String; AOperadorCaixa: String): Boolean;
  Var
    fltTotalDoc: Double;
    strSeqRcx: String;
begin
  Result := True;
  fltTotalDoc := fltTotalChqVis+fltTotalChqPre+fltTotalCartao;

  If (fFormataFloat(fltTotalDoc, 2) <> 0) And (Not blnFechadoCaixa) Then
  Begin
    If AOperadorCaixa.IsEmpty Then
      AOperadorCaixa := strLoginUsuarioLogado;

    Result := untCadRcxx.fGravaCadRcx(strSeqRcx,
                                      '',                                      // Cliente
                                      AOperadorCaixa,                        // Operador
                                      'EST.TF.',                               // Documento
                                      'LC',                                    // Espécie
                                      VS_strCodEmp,                            // Empresa
                                      dtaDtaRcx,                                // Data de Cadastro
                                      fTime(),                                  // Hora de Cadastro
                                      '',                                      // Duplicata
                                      '',                                      // Parcela
                                      'REF. A ESTORNO. CTA. RECEBER',          // Descrição
                                      '',                                      // Juros / Desconto
                                      '',                                      // Identificação de Fechamento
                                      '',                                      // Forma de Pagamento
                                      fltTotalDoc,                             // Valor do Documento
                                      0.0,                                     // Valor do Desconto
                                      0.0,                                     // Valor do Juros
                                      0,                                       // Dinheiro recebido
                                      fltTotalChqVis,                          // Cheque a vista
                                      fltTotalChqPre,                          // Cheque pre datado
                                      fltTotalCartao,                          // Valor em Cartã
                                      0,                                       // Valor em Ordem de Pagamento
                                      0.0,                                     // Valor do Crédito
                                      0.0,                                     // Valor de Financeira
                                      0.0,                                     // Valor de outros
                                      0.0,                                     // Venda a prazo
                                      '',                                      // Num. do Romaneio
                                      StrToInt(fRetRcxCon),                    // Sequencial de Controle
                                      0,                                       // Sequencial de Baixa (Duplicata)
                                      fCfgSisL('SQFCRX'),                      // Sequencial de Fechamento parcial de caixa
                                      '',                                      // Empresa da duplicata
                                      '',                                      // MotDes
                                      1,                                       // Identificação do Caixa
                                      0.00,
                                      0.00,
                                      0.00,
                                      0.00,
                                      0.00,
                                      'N',
                                      strMotEst,
                                      strCodigoCaixa);
  End;
end;

function TfrmEstornoReceber.fLockedByCurrentConnection(
  strChaLck: String): Boolean;
  begin
    Result := (fGetIdConnectionLock(strChaLck) = fGetConnectionID) And
              (fGetIPConnectionLock(strChaLck) = VS_IPAddressAsString);
  end;

procedure TfrmEstornoReceber.dbgDuplicatasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if (not Assigned(cdsDados.FindField('CTR_MARDES'))) then
    Exit;

  if (cdsDados.IsEmpty) then
    Exit;

  Case Key Of
    VK_Return: TfrmGravando.fExecutarModal(pSelecionaDuplicata, 'Aguarde... ' +
                                           IIF(cdsDados.FieldByName('CTR_MARDES').AsString = 'M', 'Desmarcando ', 'Marcando ') +
                                           'títulos.', '');
    VK_Escape: pLimpaCampos;
  End;
  
end;

function TfrmEstornoReceber.DeveGravarMovBan(ADataset: TDataset): Boolean;
begin
  {Se o valor recebido for igual a zero não deve gerar movban}
  If fFormataFloat(ADataset.FieldByName('CTR_VALREC').AsFloat, 2) = 0.00 Then
    Exit(False);

  Result := ADataset.FieldByName('CTR_RESCAI').AsInteger = 0;
  If Not Result Then
  Begin
    //Se foi recebido pelo caixa e esse ainda estiver aberto, não deve gravar movban
    Result := ADataset.FieldByName('CTR_DTAREC').AsDateTime <> dtaDtaRcx;
    If Result Then
      Result := ADataset.FieldByName('CTR_ORIGEM').AsString <> 'CTR';
  End;

  If Not Result Then
    Exit;

  If ADataset.FieldByName('CTR_VALREC').AsFloat > 0 Then
  Begin
    //Se for uma duplicata baixada com o adiantamento do pedido nao deve gerar movban
    If Pos('CADREC', ADataset.FieldByName('CTR_TABELA').AsString) > 0 Then
    Begin
      Result := ADataset.FieldByName('CTR_ADTCLI').AsString <> 'S';

      //Se for boleto adiantamento que possui faturamento parcial antes do recebimento, deve gravar MOVBAN
      If Not Result Then
        Result := PossuiFaturamentoDoPedidoAntesDoRecebimentoDoBoletoAdiantamento(ADataset);
    End;
  End;

  If Not Result Then
    Exit;

  //Se for um debito de adiantamento nao deve gerar movban
  If fPos('ADTCLI', ADataset.FieldByName('CTR_TABELA').AsString) Then
    Result := ADataset.FieldByName('CTR_VALREC').AsFloat > 0;
end;

function TfrmEstornoReceber.DeveGravarMovimentacaoBancariaDoEstornoDeCreditoDoCaixa(
  AResumoDeCaixa: String; ASeqcon: Integer; ADatasetDuplicata: TDataset;
  ADataRecebimento: TDateTime): Boolean;
  Var
    LDataRecebimento: TDateTime;

    LDadosCaixa: TDataset;
begin
  Result := True;

  If Not AResumoDeCaixa.Equals('1') Then
    Exit;

  LDataRecebimento := ADatasetDuplicata.FieldByName('CTR_DTAREC').AsDateTime;
  If ADatasetDuplicata.FieldByName('CTR_DTAREC').IsNull Then
    LDataRecebimento := ADatasetDuplicata.FieldByName('CTR_DTACAD').AsDateTime;

  LDadosCaixa := objResumoDeCaixa.fRetornaDadosLancamentosCaixaSeqCon(ASeqcon.ToString,
                                                                      ADatasetDuplicata.FieldByName('CTR_EMPBAI').AsString,
                                                                      LDataRecebimento);
  Try
    If LDadosCaixa.FieldByName('RCX_LANFEC').AsString.Equals('S') Then
      Exit;

    If ADataRecebimento <> dtaDtaRcx Then
      Exit;

    If blnFechadoCaixa Then
      Exit;

    Result := False;
  Finally
    LDadosCaixa.Close;
    FreeAndNil(LDadosCaixa);
  End;
end;

function TfrmEstornoReceber.DocumentoPossuiDevolucoes(ADataset: TDataset): Boolean;
  Var
    LDocumentos: String;

    LConsulta: TUniQuery;

    LCancelamentoDocResumo: TfrmCancelamentoDocResumo;
begin
  Result := False;

  If Not (fCfgSis('ESTDEV', varBoolean)) Then
    Exit;

  If Not ADataset.FieldByName('CTR_ESPDOC').AsString.Equals('FF') Then
    Exit;

  LConsulta := fCriaQuery(Self);

  LDocumentos := EmptyStr;

  Try
    LConsulta.SQL.Text := 'SELECT DISTINCT ' +
                          '  DET_NUMDOC,   ' +
                          '  DET_ESPDOC,   ' +
                          '  DET_CODEMP    ' +
                          'FROM MOVDET ' +
                          'WHERE DET_DOCDEV = :NUMDOC ' +
                          '  AND DET_ESPDEV = :ESPDOC ' +
                          '  AND DET_EMPDEV = :CODEMP ' +
                          '  AND DET_CODCLI = :CODCLI ' +
                          '  AND DET_TIP_FC = "C" ' +
                          '  AND DET_NUMDOC <> DET_DOCDEV';

    LConsulta.ParamByName('NUMDOC').AsString := ADataset.FieldByName('NUMDUP').AsString;
    LConsulta.ParamByName('ESPDOC').AsString := ADataset.FieldByName('CTR_ESPDOC').AsString;
    LConsulta.ParamByName('CODCLI').AsString := ADataset.FieldByName('CTR_CODCLI').AsString;
    LConsulta.ParamByName('CODEMP').AsString := ADataset.FieldByName('CTR_CODEMP').AsString;
    LConsulta.Open;

    While Not LConsulta.Eof Do
    Begin
      LDocumentos := LDocumentos + LConsulta.FieldByName('DET_NUMDOC').AsString + '-' +
                                   LConsulta.FieldByName('DET_ESPDOC').AsString + '-' +
                                   LConsulta.FieldByName('DET_CODEMP').AsString + #13#10;

      LConsulta.Next;
    End;

    If Not LDocumentos.IsEmpty Then
    Begin
      Try
        pCriarFormularios(TfrmCancelamentoDocResumo, LCancelamentoDocResumo);
        LCancelamentoDocResumo.memResumo.Lines.Add('O documento ' + ADataset.FieldByName('CTR_NUMDUP').AsString + '-' +
                                                                    ADataset.FieldByName('CTR_ESPDOC').AsString + '-' +
                                                                    ADataset.FieldByName('CTR_CODEMP').AsString +
                                                     ' não pode ser estornado pois existe(m)');
        LCancelamentoDocResumo.memResumo.Lines.Add('a(s) seguinte(s) devolução(ões): ');
        LCancelamentoDocResumo.memResumo.Lines.Add('');
        LCancelamentoDocResumo.memResumo.Lines.Add(LDocumentos);
        LCancelamentoDocResumo.ShowModal;
        Result := True;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[frmEstornoReceber.DocumentoPossuiDevolucoes]');
      End;
    End;

    FreeAndNil(LCancelamentoDocResumo);
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

function TfrmEstornoReceber.DuplicataCreditoEmAbertoPossuiChavePix(
  ADatasetBaixa: TDataset): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Result := False;

  If ADatasetBaixa.FieldByName('CTR_MARDES').AsString = 'M' Then
    Exit;

  If ADatasetBaixa.FieldByName('CTR_ESPDOC').AsString <> 'CC' Then
    Exit;

  If ADatasetBaixa.FieldByName('CTR_TABELA').AsString <> 'CADREC' Then
    Exit;

  If Not ADatasetBaixa.FieldByName('CTR_DTAREC').AsString.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                          ' FROM CADREC ' +
                          ' WHERE CTR_NUMDUP = :NUMDUP ' +
                          '   AND CTR_PARCEL = :PARCEL ' +
                          '   AND CTR_ESPDOC = :ESPDOC ' +
                          '   AND CTR_CODEMP = :CODEMP ' +
                          '   AND CTR_CODCLI = :CODCLI ' +
                          '   AND CTR_SEQBAI=0         ' +
                          '   AND CTR_TX_PIX IS NOT NULL ';

    LConsulta.ParamByName('NUMDUP').AsString := ADatasetBaixa.FieldByName('NUMDUP').AsString;
    LConsulta.ParamByName('PARCEL').AsString := ADatasetBaixa.FieldByName('PARDUP').AsString;
    LConsulta.ParamByName('ESPDOC').AsString := ADatasetBaixa.FieldByName('CTR_ESPDOC').AsString;
    LConsulta.ParamByName('CODEMP').AsString := ADatasetBaixa.FieldByName('CTR_CODEMP').AsString;
    LConsulta.ParamByName('CODCLI').AsString := ADatasetBaixa.FieldByName('CTR_CODCLI').AsString;

    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;

    If Result Then
      pEmitirMensagem('ATENÇÃO', 'O estorno não pode ser realizado pois a duplicata ' +
                           ADatasetBaixa.FieldByName('CTR_NUMDUP').AsString + '-' +
                           ADatasetBaixa.FieldByName('CTR_ESPDOC').AsString + '-' +
                           ADatasetBaixa.FieldByName('CTR_CODEMP').AsString +
                                 ' possui um registro Pix gerado e ativo.', True);
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TfrmEstornoReceber.DuplicataEmAbertoDaParcialPossuiChavePix(ADatasetBaixa: TDataset): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Result := False;

  If ADatasetBaixa.FieldByName('CTR_MARDES').AsString = 'M' Then
    Exit;

  If ADatasetBaixa.FieldByName('CTR_SEQBAI').AsInteger = 0 Then
    Exit;

  If ADatasetBaixa.FieldByName('CTR_TABELA').AsString <> 'CADREC' Then
    Exit;

  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                          ' FROM CADREC ' +
                          ' WHERE CTR_NUMDUP = :NUMDUP ' +
                          '   AND CTR_PARCEL = :PARCEL ' +
                          '   AND CTR_ESPDOC = :ESPDOC ' +
                          '   AND CTR_CODEMP = :CODEMP ' +
                          '   AND CTR_CODCLI = :CODCLI ' +
                          '   AND CTR_SEQBAI=0         ' +
                          '   AND CTR_DTAREC IS NULL   ' +
                          '   AND CTR_TX_PIX IS NOT NULL ';

    LConsulta.ParamByName('NUMDUP').AsString := ADatasetBaixa.FieldByName('NUMDUP').AsString;
    LConsulta.ParamByName('PARCEL').AsString := ADatasetBaixa.FieldByName('PARDUP').AsString;
    LConsulta.ParamByName('ESPDOC').AsString := ADatasetBaixa.FieldByName('CTR_ESPDOC').AsString;
    LConsulta.ParamByName('CODEMP').AsString := ADatasetBaixa.FieldByName('CTR_CODEMP').AsString;
    LConsulta.ParamByName('CODCLI').AsString := ADatasetBaixa.FieldByName('CTR_CODCLI').AsString;

    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;

    If Result Then
      fMensagem('ATENÇÃO', 'O estorno não pode ser realizado pois a duplicata ' +
                           ADatasetBaixa.FieldByName('CTR_NUMDUP').AsString + '-' +
                           ADatasetBaixa.FieldByName('CTR_ESPDOC').AsString + '-' +
                           ADatasetBaixa.FieldByName('CTR_CODEMP').AsString +
                           ' possui uma parte em aberto e com um registro Pix gerado e ativo.', ['&Ok']);
  Finally
    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmEstornoReceber.pEmitirMensagem(AstrTitulo, AstrMensagem: String; AblnEhLogDeErro : Boolean = False; AblnMostarViaMemo : Boolean = False;
  AblMensagemDentroDeRaise : Boolean = False);
begin
  if (blnEstornoAutomatico) and (Assigned(FobjFulFillmentLogBuilder)) then
  Begin
    FobjFulFillmentLogBuilder.blnLogTratadoEmRaise := AblMensagemDentroDeRaise;
    FobjFulFillmentLogBuilder.pSalvarLog(AstrMensagem, AblnEhLogDeErro);
  End
  Else
  Begin
    if AblnMostarViaMemo then
      TfrmMemo.pShowMessage(AstrMensagem)
    else
      fMensagem(AstrTitulo, AstrMensagem, ['&O k']);
  End;
end;

procedure TfrmEstornoReceber.pSelecionaDuplicata;
  Var
    strMarcar: String;
//    strSeqCon: String;
    strEmpRcx: String;
    dtaDtaBai: TDateTime;
    intRecNo : Integer;
    blnCreditoGeradoComBaixaTotalEParcial: Boolean;

    LDuplicatasComBaixaTotal: String;
    LDataRecebimento : TDateTime;

    function fParcialBaixadaJunto: Boolean;
      Var
        cdsDup: TUniClientDataSet;
        intRecNo: Integer;
        strChaLck: String;
    Begin
      Try
        cdsDup := TUniClientDataSet.Create(Self);

        cdsDup.Data := cdsDados.Data;
        cdsDup.Filter := 'CTR_MARDES = ' + QuotedStr('M') + ' AND ' +
                         'NUMDUP = ' + QuotedStr(cdsDados.FieldByName('NUMDUP').AsString) + ' AND ' +
                         'PARDUP = ' + QuotedStr(cdsDados.FieldByName('PARDUP').AsString) + ' AND ' +
                         'CTR_ESPDOC = ' + QuotedStr(cdsDados.FieldByName('CTR_ESPDOC').AsString) + ' AND ' +
                         'CTR_CODEMP = ' + QuotedStr(cdsDados.FieldByName('CTR_CODEMP').AsString) + ' AND ' +
                         'CTR_CODCLI = ' + QuotedStr(cdsDados.FieldByName('CTR_CODCLI').AsString) + ' AND ' +
                         'CTR_SEQBAI = 0';
        cdsDup.Filtered := True;

        If Not cdsDup.IsEmpty Then
        Begin
          intRecNo := cdsDados.RecNo;
          cdsDados.First;
          While Not cdsDados.Eof Do
          Begin
//            If (Not ((cdsDados.FieldByName('NUMDUP').AsString = cdsDup.FieldByName('NUMDUP').AsString) And
//                     (cdsDados.FieldByName('PARDUP').AsString = cdsDup.FieldByName('PARDUP').AsString) And
//                     (cdsDados.FieldByName('CTR_ESPDOC').AsString = cdsDup.FieldByName('CTR_ESPDOC').AsString) And
//                     (cdsDados.FieldByName('CTR_CODEMP').AsString = cdsDup.FieldByName('CTR_CODEMP').AsString) And
//                     (cdsDados.FieldByName('CTR_CODCLI').AsString = cdsDup.FieldByName('CTR_CODCLI').AsString) And
//                     (cdsDados.FieldByName('CTR_SEQBAI').AsString = '0'))) And (cdsDados.FieldByName('CTR_MARDES').AsString = 'M') Then

            blnCreditoGeradoComBaixaTotalEParcial := ((cdsDados.FieldByName('CTR_DTABAI').IsNull) Or (cdsDados.FieldByName('CTR_DTABAI').AsDateTime = 0)) And
                                                     (cdsDados.FieldByName('CTR_ESPDOC').AsString = 'CC') And
                                                     (cdsDados.FieldByName('CTR_CODEMP').AsString = cdsDup.FieldByName('CTR_EMPBAI').AsString) And
                                                     (cdsDados.FieldByName('CTR_SEQCON').AsString = cdsDup.FieldByName('CTR_SEQCON').AsString);

            If ((Not ((cdsDados.FieldByName('CTR_DTABAI').AsDateTime = cdsDup.FieldByName('CTR_DTABAI').AsDateTime) And
                     (cdsDados.FieldByName('CTR_SEQCON').AsString = cdsDup.FieldByName('CTR_SEQCON').AsString) And
                     (cdsDados.FieldByName('CTR_EMPBAI').AsString = cdsDup.FieldByName('CTR_EMPBAI').AsString))) And
                (Not blnCreditoGeradoComBaixaTotalEParcial))
                 And (cdsDados.FieldByName('CTR_MARDES').AsString = 'M') Then
            Begin
              cdsDados.Edit;
              cdsDados.FieldByName('CTR_MARDES').AsString := 'D';
              cdsDados.Post;

              strChaLck := 'CADREC' +
                           cdsDados.FieldByName('NUMDUP').AsString +
                           cdsDados.FieldByName('CTR_ESPDOC').AsString +
                           cdsDados.FieldByName('CTR_CODEMP').AsString +
                           cdsDados.FieldByName('CTR_CODCLI').AsString;

              strChaLck := strChaLck + cdsDados.FieldByName('PARDUP').AsString + cdsDados.FieldByName('CTR_SEQBAI').AsString;
              objLock.fLock_Unlock(strChaLck, False);
            End;

            cdsDados.Next;
          End;
          cdsDados.RecNo := intRecNo;
        End;

        Result := Not cdsDup.IsEmpty;

      Except
        On E: Exception Do
        Begin
          Raise Exception.Create(E.Message);
        End;
      End;

      FreeandNil(cdsDup);
    End;

    function MesmaDataDeBaixa : Boolean;
    Begin
      Result := (dtaDtaBai = IIF(cdsDados.FieldByName('CTR_DTABAI').AsDateTime = 0,
                                 cdsDados.FieldByName('CTR_DTACAD').AsDateTime,
                                 cdsDados.FieldByName('CTR_DTABAI').AsDateTime));

      If Not Result Then
      Begin
        Result := (LDataRecebimento = IIF(cdsDados.FieldByName('CTR_DTAREC').AsDateTime = 0,
                                          cdsDados.FieldByName('CTR_DTACAD').AsDateTime,
                                          cdsDados.FieldByName('CTR_DTAREC').AsDateTime));
      End;

    End;


    function fValidaMesmoRecebimento: Boolean;
    begin
      Result := (strSeqCon = cdsDados.FieldByName('CTR_SEQCON').AsString) And
                (strEmpRcx = IIF(cdsDados.FieldByName('CTR_DTABAI').AsDateTime = 0,
                                 cdsDados.FieldByName('CTR_CODEMP').AsString,
                                 cdsDados.FieldByName('CTR_EMPBAI').AsString)) And
                                 MesmaDataDeBaixa;
    end;

    procedure pDesmarcaConjunto;
    Begin

      cdsDados.First;
      While Not cdsDados.Eof Do
      Begin

        If fValidaMesmoRecebimento Then
          pMarcaDuplicata('D');

        cdsDados.Next;
      End;

    End;

begin
  If (Not cdsDados.Active) Then
    Exit;

  If (cdsDados.IsEmpty) Then
    Exit;

  Try
    cdsDados.DisableControls;

    intRecNo  := cdsDados.RecNo;
    strSeqCon := cdsDados.FieldByName('CTR_SEQCON').AsString;
    strEmpRcx := IIF(cdsDados.FieldByName('CTR_DTABAI').AsDateTime = 0, cdsDados.FieldByName('CTR_CODEMP').AsString, cdsDados.FieldByName('CTR_EMPBAI').AsString);
    dtaDtaBai := IIF(cdsDados.FieldByName('CTR_DTABAI').AsDateTime = 0, cdsDados.FieldByName('CTR_DTACAD').AsDateTime, cdsDados.FieldByName('CTR_DTABAI').AsDateTime);
    LDataRecebimento  := IIF(cdsDados.FieldByName('CTR_DTAREC').AsDateTime = 0, cdsDados.FieldByName('CTR_DTACAD').AsDateTime, cdsDados.FieldByName('CTR_DTAREC').AsDateTime);

    If cdsDados.FieldByName('CTR_MARDES').AsString <> 'M' Then
    Begin

      If cdsDados.Locate('CTR_MARDES', 'M', []) Then
      Begin
        cdsDados.RecNo := intRecNo;
        fMensagem('ATENÇÃO!', 'É necessário baixar uma duplicata por vez!', ['&Ok']);
        cdsDados.EnableControls;
        Exit;
      End;

      blnDocumentosOk := True;

      If fTemDuplicataOrigemConverte then
      begin
        cdsDados.EnableControls;
        Exit;
      end;
      if fDocsBaixaComLCK then
      begin
        cdsDados.EnableControls;
        Exit;
      end;

      if fTemLinkPagamento then
      begin
        cdsDados.EnableControls;
        blnDocumentosOk := False;
        Exit;
      end ;

      //Primeiro deve processar as duplicatas principais (seqbai = 0)
      cdsDados.First;
      While Not cdsDados.Eof Do
      Begin

        If fValidaMesmoRecebimento And (cdsDados.FieldByName('CTR_SEQBAI').AsInteger = 0) Then
        Begin

          If cdsDados.FieldByName('CTR_DTAREC').AsDateTime = 0 Then
          Begin

            If Not fCreditoUtilizado(cdsDados.FieldByName('NUMDUP').AsString, cdsDados.FieldByName('PARDUP').AsString,
                                     cdsDados.FieldByName('CTR_ESPDOC').AsString, cdsDados.FieldByName('CTR_CODEMP').AsString,
                                     cdsDados.FieldByName('CTR_CODCLI').AsString, cdsDados.FieldByName('CTR_SEQBAI').AsInteger,
                                     cdsDados.FieldByName('CTR_SEQCON').AsInteger) Then
            Begin
              If DuplicataCreditoEmAbertoPossuiChavePix(cdsDados) Then
              Begin
                blnDocumentosOk := False;
                strMarcar := 'D';
                Break;
              End;

              If DocumentoPossuiDevolucoes(cdsDados) Then
              Begin
                blnDocumentosOk := False;
                strMarcar := 'D';
                Break;
              End;

              pMarcaDuplicata('M');
            End
            Else
              blnDocumentosOk := False;

          End
          Else
          If DocumentoPossuiDevolucoes(cdsDados) Then
          Begin
            blnDocumentosOk := False;
            strMarcar := 'D';
            Break;
          End
          Else
          Begin
            //Verifica se ja existe baixas para os adiantamentos do cliente
            If (cdsDados.FieldByName('CTR_TABELA').AsString = 'ADTCLI') And
               (cdsDados.FieldByName('CTR_VALDUP').AsFloat > 0)         And
               (TAdiantamento.fAdiantamentoPossuiDebitos(cdsDados.FieldByName('NUMDUP'    ).AsString,
                                                         cdsDados.FieldByName('CTR_ESPDOC').AsString,
                                                         cdsDados.FieldByName('CTR_CODEMP').AsString,
                                                         cdsDados.FIeldByName('CTR_CODCLI').AsString)) Then
            Begin
              pEmitirMensagem('', 'Não é possível estornar este adiantamento de cliente pois ' +
                          'já existem lançamentos de débitos provenientes de Faturamento do ' +
                                  'Pedido ou Geração de Crédito do saldo do(s) adiantamento(s)!', True);
              blnDocumentosOk := False;
            End
            Else If (cdsDados.FieldByName('CTR_TABELA').AsString = 'ADTCLI')  And
                     TAdiantamento.fPossuiCreditoGerado(cdsDados.FieldByName('NUMDUP'    ).AsString,
                                                        cdsDados.FieldByName('CTR_ESPDOC').AsString,
                                                        cdsDados.FieldByName('CTR_CODEMP').AsString) Then
               Begin
                 {REQ: 209303 MT}
                  pEmitirMensagem('', 'Não é possível estornar este adiantamento de cliente pois ' +
                              'já existem lançamentos de débitos provenientes de Faturamento do ' +
                                      'Pedido ou Geração de Crédito do saldo do(s) adiantamento(s)!', True);
                  blnDocumentosOk := False;
               End
            Else
              pMarcaDuplicata('M');
          End;

          if blnDocumentosOk then
          begin
            if EstaConciliado(cdsDados.FieldByName('CTR_DOCBAI').AsString, 'CADREC') then
            begin
              pEmitirMensagem('', 'Não é possível estornar esse título, pois o mesmo está conciliado. ' +
                                  'Para ser possível estorná-lo, o mesmo deve ser desconciliado. Acessar PRINCIPAL > CONTROLE FINANCEIRO > CONCILIAÇÃO BANCÁRIA.', True);
              strMarcar := 'D';
              blnDocumentosOk := False;
            end;
          end;

          If blnDocumentosOk then
          Begin
            If fVerificaSeDuplicataEstaVinculadaParaConciliacao(cdsDados.FieldByName('NUMDUP').AsString,cdsDados.FieldByName('PARDUP').AsString,
                                                                cdsDados.FieldByName('CTR_CODEMP').AsString,cdsDados.FieldByName('CTR_CODCLI').AsString,
                                                                cdsDados.FieldByName('CTR_ESPDOC').AsString,'','CADREC',cdsDados.FieldByName('CTR_DOCBAI').AsString) Then
            Begin
              pEmitirMensagem('', 'Não é possível estornar esse título, pois o mesmo está Vinculado para Conciliação. ' +
                                  'Para ser possível estorná-lo, o mesmo deve ser Desvinculado. Acessar PRINCIPAL > CONTROLE FINANCEIRO > CONCILIAÇÃO BANCÁRIA.', True);
              strMarcar := 'D';
              blnDocumentosOk := False;
            End;

          End;
        End;

        cdsDados.Next;
      End;

      //Processa as duplicatas nao principais (seqbai <> 0)
      cdsDados.First;
      While Not cdsDados.Eof Do
      Begin

        If fValidaMesmoRecebimento And (cdsDados.FieldByName('CTR_SEQBAI').AsInteger <> 0) Then
        Begin

          //Verifica se a duplicata principal ainda nao foi recebida
          If fVerificaDuplicataPrincipal Then
          Begin

            //Verifica se tem duplicata(s) com seqbai maior baixada(s)
            If fTemDuplicataPosteriorBaixada(cdsDados.FieldByName('NUMDUP').AsString,
                                             cdsDados.FieldByName('PARDUP').AsString,
                                             cdsDados.FieldByName('CTR_ESPDOC').AsString,
                                             cdsDados.FieldByName('CTR_CODEMP').AsString,
                                             cdsDados.FieldByName('CTR_CODCLI').AsString,
                                             cdsDados.FieldByName('CTR_SEQBAI').AsInteger,
                                             cdsDados.FieldByName('CTR_SEQCON').AsInteger) Then
            Begin
              pEmitirMensagem('', 'Há duplicata(s) parciais de ' + cdsDados.FieldByName('NUMDUP').AsString + '-' +
                                                             cdsDados.FieldByName('CTR_ESPDOC').AsString + ', baixadas posteriormente. '+ #13#10 +
                                  'As duplicatas parciais devem ser estornadas a partir da última baixa.', True);
              strMarcar := 'D';
              blnDocumentosOk := False;
            End
            Else
              strMarcar := 'M';

          End
          //Else - duplicata principal ja foi recebida
          Else
          Begin
            //verifica se a duplicata parcial foi recebida junto com a principal
            If fParcialBaixadaJunto Then
            Begin
              strMarcar := 'M';
            End
            Else
            Begin
              If Not ValidarDuplicatasComBaixaParcial(LDuplicatasComBaixaTotal) Then
                pEmitirMensagem('ATENÇÃO', 'Para realizar o estorno, antes é necessário estornar a baixa referente ' +
                                     'ao registro principal (Seq. 0) das seguintes duplicatas: ' +#13 +
                                           LDuplicatasComBaixaTotal, True)
              Else
                pEmitirMensagem('', 'Primeiro você deve estornar a duplicata principal (Seq. 0) de: ' + cdsDados.FieldByName('NUMDUP').AsString + '-' +
                                                                                                  cdsDados.FieldByName('PARDUP').AsString + '-' +
                                                                                                  cdsDados.FieldByName('CTR_ESPDOC').AsString + '-' +
                                                                                                        cdsDados.FieldByName('CTR_CODEMP').AsString + '!', True);
              blnDocumentosOk := False;
            End;

          End;

          if blnDocumentosOk Then
          begin
            if EstaConciliado(cdsDados.FieldByName('CTR_DOCBAI').AsString, 'CADREC') then
            begin
              pEmitirMensagem('', 'Há duplicatas conciliadas, portando não será possível realizar o estorno. ' +
                                  'Para ser possível estorná-las, as mesmas devem ser desconciliadas. Acessar PRINCIPAL > CONTROLE FINANCEIRO > CONCILIAÇÃO BANCÁRIA.', True);
              strMarcar := 'D';
              blnDocumentosOk := False;
            end;
          end;

          If blnDocumentosOk Then
          Begin
            If DuplicataEmAbertoDaParcialPossuiChavePix(cdsDados) Then
            Begin
              blnDocumentosOk := False;
              strMarcar := 'D';
              Break;
            End;

            If DocumentoPossuiDevolucoes(cdsDados) Then
            Begin
              blnDocumentosOk := False;
              strMarcar := 'D';
              Break;
            End;
          End;

          pMarcaDuplicata(strMarcar);
        End;

        cdsDados.Next;
      End;

      {******************************************}
      {* DESMARCA TODAS POIS DEU ERRO EM ALGUMA *}
      {***************************************AF*}
      If Not blnDocumentosOk Then
        pDesmarcaConjunto;

    End
    Else
      pDesmarcaConjunto;

    cdsDados.RecNo := intRecNo;
    dbgDuplicatas.Refresh;

  Except
    On E: ExceptionAutcom Do
    Begin
      pDesmarcaConjunto;

      fMensagem('ATENÇÃO!', E.Message, ['&Ok']);
    End;

    On E: Exception Do
    Begin
      pDesmarcaConjunto;

      pMensagensErro(E.Message, '[pSelecionaDuplicata]');
    End;
  End;

  If blnDocumentosOk Then
    dtaDtaRcx := RetornaDataDoCaixaDosLancamentos(dtaDtaRcx,
                                                  cdsDados);

  cdsDados.EnableControls;
end;

procedure TfrmEstornoReceber.pVerificaDuplicatasRestantesDocumento;
begin
  If Not blnEstornoDocLocEqu Then
    Exit;

  Self.Close;

end;

function TfrmEstornoReceber.RetornaValorCreditoDaBaixa(ASeqcon: Integer;
  AEmpresaBaixa: String; ADataRecebimento: TDateTime): Double;
  Var
    LConsulta: TUniQuery;
begin
  Result := 0.00;

  If ASeqCon <= 0 Then
    Exit;

  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT SUM(IFNULL(RCX_VALCRE, 0)) AS VALCRE FROM CADRCXX ' +
                          ' WHERE RCX_DTACAD="' + FormatDateTime('yyyy/mm/dd', ADataRecebimento) + '" ' +
                          '   AND RCX_CODEMP="' + AEmpresaBaixa + '" ' +
                          '   AND RCX_SEQCON=' + ASeqcon.ToString;

    If Not strCodigoCaixa.IsEmpty Then
      LConsulta.SQL.Text := LConsulta.SQL.Text  + ' AND RCX_CODCAX="' + strCodigoCaixa + '" ';

    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit;

    Result := fFormataFloat(LConsulta.FieldByname('VALCRE').AsFloat, 2);
  Finally
    FreeAndNil(LConsulta);
  end;
end;

function TfrmEstornoReceber.ValidacoesDeRecebimentoPorPix(
  ARecebidoPorPix: Boolean): Boolean;
  Var
    LDuplicatas: TUniClientDataSet;

    LConsulta: TUniQuery;

    LRecebimentoPossuiPix: Boolean;
begin
  Result := True;

  FSolicitarDevolucaoPix := False;

  FGerarCreditoDevolucaoPix := False;

  FGerouCreditoPix := False;

  If Not ARecebidoPorPix Then
    Exit;

  Try
    LDuplicatas := TUniClientDataSet.Create(Self);
    LDuplicatas.Data := cdsDados.Data;

    LDuplicatas.Filter := 'CTR_MARDES=''M'' AND CTR_DTAREC IS NOT NULL ';
    LDuplicatas.Filtered := True;

    LDuplicatas.Locate('CTR_RECPIX', 'S', []);

    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT MPX_CODEMP, MPX_TX_ID_, MPX_SEQTRF, MPX_RESCAI, ' +
                          '       MPX_DTAREC, MPX_END_ID, AUTOINCREM, MPX_VALREC, ' +
                          '       MPX_DTACAD, MPX_QRCODE, MPX_QTDDEV, MPX_SEQPIX, ' +
                          '       MPX_PORBAI, MPX_CTABAI, MPX_USASHP, MPX_JSOENV, ' +
                          '       MPX_SEQCON, MPX_PIXSCP  '+
                          'FROM MOVPIX ' +
                          'WHERE MPX_SEQCON=' + LDuplicatas.FieldByName('CTR_SEQCON').AsString +
                          '  AND MPX_CODEMP="' + LDuplicatas.FieldByName('CTR_EMPBAI').AsString + '" ' +
                          '  AND MPX_DTAREC="' + FormatDateTime('yyyy/mm/dd', LDuplicatas.FieldByName('CTR_DTAREC').AsDateTime) + '"';
    LConsulta.Open;

    FRegistroMovPix := fCriaClientDatSet(LConsulta);
    FRegistroMovPix.Open;

    LRecebimentoPossuiPix := Not FRegistroMovPix.IsEmpty;

    If Not LRecebimentoPossuiPix Then
      Exit;

    FValorTotalPix := fRetornaValRecPix(FRegistroMovPix) ;

    If MatchStr(TPixDao.RetornaBancoDaChavePix(FRegistroMovPix.FieldByName('MPX_SEQPIX').AsString), ['748']) Then
      FRealizarDevolucaoDoPix := FRegistroMovPix.FieldByName('MPX_USASHP').AsString = 'S';

    If Not FRealizarDevolucaoDoPix Then
    Begin
      Result := fMensagem('ATENÇÃO', 'Esse recebimento possui uma cobrança Pix de ' +
                                     FormatFloat(',0.00', FValorTotalPix) + ' vinculada.' + #13 +
                                     'Ao realizar o estorno, o sistema removerá a cobrança, mas ' +
                                     'o valor NÃO será devolvido de forma automática por Pix ao cliente.' + #13 +
                                     'Deseja continuar?', ['&Sim', '&Não']) = 1;

      If Result Then
      Begin
        FGerarCreditoDevolucaoPix := GeracaoCreditoRecebimentoPix(FRegistroMovPix);

        If FGerarCreditoDevolucaoPix Then
        Begin
          SelecionaPortadorEventoGeracaoCredito(FPortadorCredito,
                                                FEventoCredito);

          Result := Not FPortadorCredito.IsEmpty;
        End;
      End;

      Exit;
    End;

    If DaysBetween(LDuplicatas.FieldByName('CTR_DTAREC').AsDateTime, VS_Date) >= 90 Then
      Exit(fMensagem('ATENÇÃO', 'A data de recebimento do Pix ultrapassou o limite de 90 dias para a devolução do valor de ' +
                                FormatFloat(',0.00',FValorTotalPix) + 'de forma automática.' + #13 +
                                'Deve ser realizada a devolução para o cliente pelo aplicativo do banco.' + #13 +
                                'O estorno continuará a seguir.', ['&Ok']) = 1);

    FGerarCreditoDevolucaoPix := GeracaoCreditoRecebimentoPix(FRegistroMovPix);
    If FGerarCreditoDevolucaoPix Then
    Begin
      fMensagem('ATENÇÃO', 'Esse recebimento possui uma cobrança Pix de ' +
                           FormatFloat(',0.00', FValorTotalPix) + ' vinculada.' + #13 +
                           'Ao realizar o estorno, o sistema removerá a cobrança, mas ' +
                           'o valor NÃO será devolvido de forma automática por Pix ao cliente e '+
                           'será gerado um crédito.', ['&Ok']);

      Result := SolicitaDireitoDeAcessoDevolucaoPix(LDuplicatas,
                                                    'CREDITO');

      If Result Then
      Begin
        SelecionaPortadorEventoGeracaoCredito(FPortadorCredito,
                                              FEventoCredito);

        Result := Not FPortadorCredito.IsEmpty;
      End;

      FSolicitarDevolucaoPix := False;

      Exit;
    End;

    Result := fMensagem('ATENÇÃO', 'O sistema irá realizar a devolução do pagamento ao cliente via Pix de ' +
                                   FormatFloat(',0.00', FValorTotalPix) + '.' + #13 +
                                   'Deseja continuar com o estorno?', ['&Sim', '&Não']) = 1;

    If Result Then
    Begin
      Result := SolicitaDireitoDeAcessoDevolucaoPix(LDuplicatas);

      FSolicitarDevolucaoPix := Result;
    End;
  Finally
    FreeAndNil(LConsulta);
    FreeAndNil(LDuplicatas);
  End;
end;

function TfrmEstornoReceber.RegistroCreditoAdiantamentoEstornado(
  ASequencialControle, AEmpresaLancamento: String;
  ADataLancamento: TDateTime): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  If ASequencialControle = '0' Then
    Exit(False);

  If ASequencialControle.IsEmpty Then
    Exit(False);

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                          'FROM ADTCLI ' +
                          'WHERE ADT_DTALAN=:DTALAN ' +
                          '  AND ADT_SEQCON=:SEQCON ' +
                          '  AND ADT_EMPLAN=:EMPLAN ' +
                          '  AND ADT_TIPLAN="D" ' +
                          '  AND ADT_ESTORN="S" ';

    LConsulta.ParamByName('DTALAN').AsDateTime := ADataLancamento;
    LConsulta.ParamByName('SEQCON').AsInteger := StrToInt(ASequencialControle);
    LConsulta.ParamByName('EMPLAN').AsString := AEmpresaLancamento;

    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;

    If Result Then
      FSeqconCCCanceladoADT := StrToInt(ASequencialControle);
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TfrmEstornoReceber.RetornaComissoesDeAgrupamentos(
  ADatasetBaixa: TDataset): TUniQuery;
  Var
    LSQLWhere: String;
begin
  Result := fCriaQuery;

  LSQLWhere := '';

  ADatasetBaixa.first;
  While Not ADatasetBaixa.Eof Do
  Begin
    If ADatasetBaixa.FieldByName('CTR_ESPDOC').AsString = 'AG' Then
      LSQLWhere := LSQLWhere + '(COM_NUMAGR="' + ADatasetBaixa.FieldByName('NUMDUP').AsString + '" AND ' +
                               ' COM_EMPAGR="' + ADatasetBaixa.FieldByName('CTR_CODEMP').AsString + '" AND ' +
                               ' COM_PARAGR="' + ADatasetBaixa.FieldByName('PARDUP').AsString + '" AND ' +
                               ' COM_CODCLI="' + ADatasetBaixa.FieldByName('CTR_CODCLI').AsString + '") OR ';
    ADatasetBaixa.Next;
  End;
  ADatasetBaixa.First;

  If LSQLWhere.IsEmpty Then
    LSQLWhere := ' FALSE '
  Else
    LSQLWhere := LeftStr(LSQLWhere, LSQLWhere.Length - 3);

  Result.SQL.Text := 'SELECT * FROM AGRCOM ' +
                     'WHERE ' +
                     LSQLWhere;

  Result.Open;
end;

function TfrmEstornoReceber.RetornaDataDoCaixaDosLancamentos(
  ADataAtualCaixa: TDateTime; ADatasetLancamentos: TDataset): TDateTime;
  Var
    LFiltroAtual: String;

    LDatasetCaixa: TDataset;
begin
  Result := ADataAtualCaixa;

  If blnResCai Then
    Exit;

  LFiltroAtual := ADatasetLancamentos.Filter;

  Try
    ADatasetLancamentos.Filter := 'CTR_MARDES=''M'' AND CTR_RESCAI=1';
    ADatasetLancamentos.Filtered := True;

    If Not ADatasetLancamentos.IsEmpty Then
    Begin
      LDatasetCaixa := objResumoDeCaixa.fRetornaDadosLancamentosCaixaSeqCon(ADatasetLancamentos.FieldByName('CTR_SEQCON').AsString,
                                                                            ADatasetLancamentos.FieldByName('CTR_EMPBAI').AsString,
                                                                            IIF(ADatasetLancamentos.FieldByName('CTR_DTAREC').IsNull,
                                                                                ADatasetLancamentos.FieldByName('CTR_DTACAD').AsDateTime,
                                                                                ADatasetLancamentos.FieldByName('CTR_DTAREC').AsDateTime));

      strCodigoCaixa := LDatasetCaixa.FieldByName('RCX_CODCAX').AsString;

      objResumoDeCaixa.fNecessitaFecharCaixa(False,
                                             Result,
                                             strCodigoCaixa,
                                             False,
                                             ADatasetLancamentos.FieldByName('CTR_EMPBAI').AsString);

      FreeAndNil(LDatasetCaixa);
    End;
  Finally
    ADatasetLancamentos.Filter := LFiltroAtual;
    ADatasetLancamentos.Filtered := Not LFiltroAtual.IsEmpty;
    ADatasetLancamentos.First;
  End;
end;

function TfrmEstornoReceber.RetornaTipoMovimentacaoBancaria(
  AValorLancamento: Double): String;
begin
  Result := 'C';

  If fFormataFloat(AValorLancamento, 2) > 0 Then
    Result := 'D';
end;

function TfrmEstornoReceber.ValidarDuplicatasComBaixaParcial(out ADuplicatasBaixadas: String): Boolean;
  Var
    LRegistroAtual: Integer;

    LConsulta: TUniQuery;

    LCopia: TUniClientDataset;

    LSQL,
    LSeqCon,
    LEmpBai: String;
    LDtaRec: TDateTime;
begin
  Result := True;

  LSeqCon := cdsDados.FieldByName('CTR_SEQCON').AsString;
  LEmpBai := cdsDados.FieldByName('CTR_EMPBAI').AsString;
  LDtaRec := cdsDados.FieldByName('CTR_DTAREC').AsDateTime;

  LRegistroAtual := cdsDados.RecNo;

  LCopia := fCriaClientDatSet(cdsDados);

  ADuplicatasBaixadas := '';

  LSQL := 'SELECT CTR_NUMDUP,           ' +
          '       CTR_PARCEL,           ' +
          '       CTR_ESPDOC,           ' +
          '       CTR_CODEMP,           ' +
          '       CTR_CODCLI            ' +
          'FROM CADREC                  ' +
          'WHERE CTR_NUMDUP=:NUMDUP     ' +
          '  AND CTR_PARCEL=:PARCEL     ' +
          '  AND CTR_ESPDOC=:ESPDOC     ' +
          '  AND CTR_CODEMP=:CODEMP     ' +
          '  AND CTR_CODCLI=:CODCLI     ' +
          '  AND CTR_SEQBAI=0           ' +
          '  AND CTR_DTAREC IS NOT NULL ';

  LConsulta := fCriaQuery;
  LConsulta.SQL.Text := LSQL;

  Try
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      If cdsDados.FieldByName('CTR_SEQBAI').AsString = '0' Then
      Begin
        cdsDados.Next;
        Continue;
      End;

      If cdsDados.FieldByName('CTR_TABELA').AsString <> 'CADREC' Then
      Begin
        cdsDados.Next;
        Continue;
      End;

      If (cdsDados.FieldByName('CTR_SEQCON').AsString <> LSeqCon) Or
         (cdsDados.FieldByName('CTR_EMPBAI').AsString <> LEmpBai) Or
         (cdsDados.FieldByName('CTR_DTAREC').Value    <> LDtaRec) Then
      Begin
        cdsDados.Next;
        Continue;
      End;

      If LCopia.Locate('NUMDUP;PARDUP;CTR_ESPDOC;CTR_CODEMP;CTR_CODCLI;CTR_SEQBAI',
                       VarArrayOf([cdsDados.FieldByName('NUMDUP').AsString,
                                   cdsDados.FieldByName('PARDUP').AsString,
                                   cdsDados.FieldByName('CTR_ESPDOC').AsString,
                                   cdsDados.FieldByName('CTR_CODEMP').AsString,
                                   cdsDados.FieldByName('CTR_CODCLI').AsString, 0]), []) Then
      Begin
        cdsDados.Next;
        Continue;
      End;

      LConsulta.Close;
      LConsulta.ParamByName('NUMDUP').AsString := cdsDados.FieldByName('NUMDUP').AsString;
      LConsulta.ParamByName('PARCEL').AsString := cdsDados.FieldByName('PARDUP').AsString;
      LConsulta.ParamByName('ESPDOC').AsString := cdsDados.FieldByName('CTR_ESPDOC').AsString;
      LConsulta.ParamByName('CODEMP').AsString := cdsDados.FieldByName('CTR_CODEMP').AsString;
      LConsulta.ParamByName('CODCLI').AsString := cdsDados.FieldByName('CTR_CODCLI').AsString;
      LConsulta.Open;

      If Not LConsulta.IsEmpty Then
      Begin
        Result := False;

        ADuplicatasBaixadas := Concat(ADuplicatasBaixadas,
                                      cdsDados.FieldByName('NUMDUP').AsString,
                                      cdsDados.FieldByName('PARDUP').AsString, '-',
                                      cdsDados.FieldByName('CTR_ESPDOC').AsString, '-',
                                      cdsDados.FieldByName('CTR_CODEMP').AsString, '-',
                                      cdsDados.FieldByName('CTR_CODCLI').AsString, #13);
      End;

      cdsDados.Next;
    End;
  Finally
    cdsDados.RecNo := LRegistroAtual;

    FreeAndNil(LCopia);
    FreeAndNil(LConsulta);
  End;
end;

function TfrmEstornoReceber.ValidaTransferenciasLiberadas(ASequencialBaixa,
  AEmpresaBaixa: String): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Result := Not fCfgSis('USAAUT', varBoolean);
  If Result Then
    Exit;

  Result := fCfgSis('TPFCCX', varString) <> 'C';
  If Result Then
    Exit;

  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                          'FROM MOVCAR ' +
                          'WHERE MCA_SEQCON=' + ASequencialBaixa +
                          '  AND MCA_EMPRCX="' + AEmpresaBaixa + '" ' +
                          '  AND MCA_RESCAI=1 ' +
                          '  AND MCA_TRFLIB="N" ' +
                          'UNION ALL ' +
                          'SELECT AUTOINCREM ' +
                          'FROM CADCHQ ' +
                          'WHERE CHQ_SEQCON=' + ASequencialBaixa +
                          '  AND CHQ_EMPRCX="' + AEmpresaBaixa + '" ' +
                          '  AND CHQ_RESCAI=1 ' +
                          '  AND CHQ_TRFLIB="N" ';

    LConsulta.Open;

    Result := LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TfrmEstornoReceber.ValorPixJaDevolvidoNoBanco(
  ARegistroPix: TDataSet; AValidaQuantidade: Boolean = True): Boolean;
  Var
    LResposta: String;

    LDadosCobranca: TDadosRetornoPixConsulta;

    LDadosRetorno: TDadosRetornoPixDevolucao;
begin
  If AValidaQuantidade Then
  Begin
    Result := ARegistroPix.FieldByName('MPX_QTDDEV').AsInteger > 0;

    If Not Result Then
      Exit;
  End;

  Result := False;

  if TPixDao.ChavePixUtilizaTefScope(ARegistroPix.FieldByName('MPX_SEQPIX').AsString) = 'S' then
    Exit;


  LResposta := TFuncoesPixAutcom.ConsultarCobrancaPorTxId(ARegistroPix.FieldByName('MPX_TX_ID_').AsString,
                                                          ARegistroPix.FieldByName('MPX_SEQPIX').AsString,
                                                          ARegistroPix.FieldByName('MPX_JSOENV').AsString);


  LDadosCobranca := TFuncoesPix.RetornaDadosDoRetornoPixConsulta(LResposta,
                                                                 ARegistroPix.FieldByName('MPX_JSOENV').AsString);

  For LDadosRetorno In LDadosCobranca.DadosDevolucao Do
  Begin
    If MatchStr(LDadosRetorno.Status, STATUS_PIX_DEVOLVIDO) Then
    Begin
      TPixDao.Create().AtualizaDadosRetornoDevolucaoPix(LDadosRetorno,
                                                        ARegistroPix.FieldByName('AUTOINCREM').AsString,
                                                        Self.Name,
                                                        IIF(blnResCai, VS_strCodigoOperadorLogadoCaixa, strLoginUsuarioLogado));

      Exit(True);
    End;
  End;
end;

Procedure TfrmEstornoReceber.SelecionaPortadorEventoGeracaoCredito(out ACodigoPortador,
                                                                       ACodigoEvento: String);
  Var
    LBaixaAnalitica: TfrmBaixaAnalitica;

    LPortadorAdiantamento: String;
Begin
  ACodigoEvento := '';
  ACodigoPortador := '';

  Try
    pCriarFormularios(TfrmBaixaAnalitica, LBaixaAnalitica);

    Try
      LBaixaAnalitica.blnChmCX := True;

      LBaixaAnalitica.Panel1.Visible := False;

      LBaixaAnalitica.edtPorDeb.Visible  := False;
      LBaixaAnalitica.edtPorDeb.Enabled  := False;
      LBaixaAnalitica.lblPorDeb.Visible  := False;
      LBaixaAnalitica.edtCodPorDeb.Enabled := False;
      LBaixaAnalitica.edtCodPorDeb.Visible := False;
      LBaixaAnalitica.blnFrmRcxResumoCaixa := True;

      LBaixaAnalitica.gpbDescontoAntecipacao.Visible := False;

      LBaixaAnalitica.fraPlanoDeContasCre.Visible := False;
      LBaixaAnalitica.fraPlanoDeContasCre.MskCodCta.Visible := False;

      LBaixaAnalitica.pnlFundo.Height := LBaixaAnalitica.edtPorBai.Top + LBaixaAnalitica.edtPorBai.Height + 30;
      LBaixaAnalitica.Height := LBaixaAnalitica.pnlFundo.Height + LBaixaAnalitica.pnlConfirma.Height + LBaixaAnalitica.pnlStatus.Height + 35;
      LBaixaAnalitica.pnlFundo.Align := alClient;

      If cdsDados.FieldByName('CTR_TABELA').AsString = 'ADTCLI' Then
      Begin
        LPortadorAdiantamento := fCfgSis('PCTRCC');
        If LPortadorAdiantamento.IsEmpty Then
          LPortadorAdiantamento := fCampoTabela('CND_CODPOR', 'CADCND', ['CND_CODIGO'], [fRetornaInformacaoVenda(edtNumDup.Text, edtEspDoc.Text, edtCodEmp.Text, 'CODCND')]);

        LBaixaAnalitica.edtPorBai.Text := LPortadorAdiantamento;
        LBaixaAnalitica.pCarregaPortador;
      End;

      LBaixaAnalitica.ShowModal;

      If Not LBaixaAnalitica.blnConfirma Then
        Exit;

      If Not fEmptyStr(LBaixaAnalitica.edtPorBai.Text) Then
      Begin
        ACodigoEvento := LBaixaAnalitica.strCodEve;
        ACodigoPortador := LBaixaAnalitica.edtPorBai.Text;
      End
      Else
        fMensagem('ATENÇÃO', 'O portador do crédito deve ser selecionado.', ['&Ok']);
    Finally
      FreeAndNil(LBaixaAnalitica);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TfrmEstornoReceber.SelecionaPortadorEventoGeracaoCredito]');
  End;
end;

function TfrmEstornoReceber.SolicitaDireitoDeAcessoDevolucaoPix(ADuplicatas: TUniClientDataset;
  ATipoSolicitacao: String = ''): Boolean;
  Var
    LDinheiro,
    LCartao,
    LChequeAVista,
    LChequePre,
    LOrdemPagamento: Double;
    objTabela: TRegistroMsgLiberaTabela;
  	objLinha: TLinhaMsgLibera;
begin
  objLiberacao.Clear;

  If ATipoSolicitacao.IsEmpty Then
    objLiberacao.objMsgLibera.pAddTexto('PERMITIR REALIZAR A DEVOLUÇÃO DO VALOR DE UM PAGAMENTO PIX AO ESTORNAR O RECEBIMENTO')
  Else
    objLiberacao.objMsgLibera.pAddTexto('PERMITIR ESTORNAR O RECEBIMENTO PIX SEM REALIZAR A DEVOLUÇÃO AUTOMÁTICA');

  objLiberacao.objMsgLibera.pAddSeparador(116);

  objLiberacao.objMsgLibera.pAddTexto('Cliente: ' + edtCodCli.text + '-' + edtNomCli.Text);
  objLiberacao.objMsgLibera.pAddTexto('Data do Pix: ' + FormatDateTime('dd/mm/yyyy', FRegistroMovPix.FieldByName('MPX_DTACAD').AsDateTime));
  objLiberacao.objMsgLibera.pAddTexto('Valor do Pix: ' + FormatFloat(',0.00', FRegistroMovPix.FieldByName('MPX_VALREC').AsFloat));
  objLiberacao.objMsgLibera.pAddTexto('Identificação: ' + FRegistroMovPix.FieldByName('MPX_TX_ID_').AsString);
  objLiberacao.objMsgLibera.pAddTexto('Texto QR Code: ' + FRegistroMovPix.FieldByName('MPX_QRCODE').AsString);
  objLiberacao.objMsgLibera.pAddTexto('');
  objLiberacao.objMsgLibera.pAddTexto('Operador da Baixa: ' + ADuplicatas.FieldByName('CTR_OPEBAI').AsString);

  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'DUPLICATA'   , 21 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'DT.CAD.'     , 10 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'DT.VENCTO'   , 10 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'DT.RECTO'    , 10 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'VR.ORIGINAL' , 12 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'VR.RECEBIDO' , 12 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'JUROS'       , 12 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'DESCONTOS'   , 12 , alDireita  , teAutcom);
  objTabela.lstLinhas.Add(objLinha);

  LDinheiro := 0;
  LCartao := 0;
  LChequeAVista := 0;
  LChequePre := 0;
  LOrdemPagamento := 0;

  ADuplicatas.First;
  While Not ADuplicatas.Eof Do
  Begin
    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('DUPLICATA'   ,   fPadR(ADuplicatas.FieldByName('CTR_NUMDUP').AsString, 12) + '-'
                                        + fPadR(ADuplicatas.FieldByName('PARDUP').AsString, 1)      + '-'
                                        + fPadR(ADuplicatas.FieldByName('CTR_ESPDOC').AsString, 2)  + '-'
                                        + ADuplicatas.FieldByName('CTR_CODEMP').AsString                                 , 21 , alEsquerda);
    objLinha.pAddColuna('DT.CAD.'     ,   FormatDateTime('dd/mm/yyyy', ADuplicatas.FieldByName('CTR_DTACAD').AsDateTime) , 10 , alEsquerda);
    objLinha.pAddColuna('DT.VENCTO'   ,   FormatDateTime('dd/mm/yyyy', ADuplicatas.FieldByName('CTR_DTAVEN').AsDateTime) , 10 , alEsquerda);
    objLinha.pAddColuna('DT.RECTO'    ,   FormatDateTime('dd/mm/yyyy', ADuplicatas.FieldByName('CTR_DTAREC').AsDateTime) , 10 , alEsquerda);
    objLinha.pAddColuna('VR.ORIGINAL' ,   FloatToStrF(ADuplicatas.FieldByName('CTR_GRVORI').AsFloat, ffNumber, 12, 2)    , 12 , alDireita );
    objLinha.pAddColuna('VR.RECEBIDO' ,   FloatToStrF(ADuplicatas.FieldByName('CTR_VALREC').AsFloat, ffNumber, 12, 2)    , 12 , alDireita );
    objLinha.pAddColuna('JUROS'       ,   FloatToStrF(ADuplicatas.FieldByName('CTR_VALJUR').AsFloat, ffNumber, 12, 2)    , 12 , alDireita );
    objLinha.pAddColuna('DESCONTOS'   ,   FloatToStrF(ADuplicatas.FieldByName('CTR_VALDES').AsFloat, ffNumber, 12, 2)    , 12 , alDireita );
    objTabela.lstLinhas.Add(objLinha);

    LDinheiro := LDinheiro + ADuplicatas.FieldByName('CTR_DINHEI').AsFloat;
    LCartao := LCartao + ADuplicatas.FieldByName('CTR_CARTAO').AsFloat;
    LChequeAVista := LChequeAVista + ADuplicatas.FieldByName('CTR_CHQAVI').AsFloat;
    LChequePre := LChequePre + ADuplicatas.FieldByName('CTR_CHQPRE').AsFloat;
    LOrdemPagamento := LOrdemPagamento + ADuplicatas.FieldByName('CTR_ORDPAG').AsFloat;

    ADuplicatas.Next;
  End;
  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  objLiberacao.objMsgLibera.pAddTextoCaption('Dinheiro', FloatToStrF(LDinheiro, ffNumber, 12, 2), 20);
  objLiberacao.objMsgLibera.pAddTextoCaption('Cartão', FloatToStrF(LCartao, ffNumber, 12, 2), 20);
  objLiberacao.objMsgLibera.pAddTextoCaption('Pix', FloatToStrF(LOrdemPagamento, ffNumber, 12, 2), 20);
  objLiberacao.objMsgLibera.pAddTextoCaption('Cheque a Vista', FloatToStrF(LChequeAVista, ffNumber, 12, 2), 20);
  objLiberacao.objMsgLibera.pAddTextoCaption('Cheque Pré', FloatToStrF(LChequePre, ffNumber, 12, 2), 20);

  If ATipoSolicitacao.IsEmpty Then
  Begin
    objLiberacao.strDirAce := 'PERMDEVRECPIX';
    objLiberacao.strMsgSen := 'PERMITIR REALIZAR A DEVOLUÇÃO DO VALOR DE UM PAGAMENTO PIX AO ESTORNAR O RECEBIMENTO';
  End
  Else
  Begin
    objLiberacao.strDirAce := 'PERMESTSEMDEVPIX';
    objLiberacao.strMsgSen := 'PERMITIR ESTORNAR O RECEBIMENTO PIX SEM REALIZAR A DEVOLUÇÃO AUTOMÁTICA';
  End;

  if (blnResCai) and (not fEmptyStr(strCodOpe)) then
  begin
    objLiberacao.strCodOpe := strCodOpe;
    objLiberacao.strCodDig := strCodOpe;
  end
  else
  begin
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;
  end;

  Result := objLiberacao.fLibera;
end;

procedure TfrmEstornoReceber.SolicitarDevolucaoDoPix(
  ARegistroPix: TUniClientDataSet);
  Var
    LChaveDev,
    LResposta,
    LChaveDevolucao,
    LMensagemErro: String;

    LDadosRetorno: TDadosRetornoPixDevolucao;

    LContador,
    LTempoAguardo: Integer;

    LDevolucaoRealizada: Boolean;
begin

  If MatchStr(ARegistroPix.FieldByName('MPX_END_ID').AsString, ['PAGAMENTOFORCADOTELAQRCODE',
                                                                'PAGAMENTOFORCADOROBOQRCODE']) Then
    Exit;

  If Not FSolicitarDevolucaoPix Then
    Exit;

  LTempoAguardo := 3000;

  Try
    LDevolucaoRealizada := ValorPixJaDevolvidoNoBanco(ARegistroPix);
    If LDevolucaoRealizada Then
      Exit;

    LChaveDev := ARegistroPix.FieldByName('AUTOINCREM').AsString +
                 ARegistroPix.FieldByName('MPX_QTDDEV').AsString;

    LChaveDevolucao := ARegistroPix.FieldByName('MPX_END_ID').AsString;
    If (ARegistroPix.FieldByName('MPX_USASHP').AsString = 'S') or
       (ARegistroPix.FieldByName('MPX_PIXSCP').AsString = 'S') Then
    Begin
      LChaveDevolucao := TPixDao.RetornaControleDoJsonRetornoPix(
        ARegistroPix.FieldByName('MPX_CODEMP').AsString,
        ARegistroPix.FieldByName('MPX_TX_ID_').AsString);

      LTempoAguardo := 7000;
    End;

    LResposta := TFuncoesPixAutcom.SolicitarDevolucao(LChaveDevolucao,
                                                      LChaveDev,
                                                      ARegistroPix.FieldByName('MPX_VALREC').AsFloat,
                                                      ARegistroPix.FieldByName('MPX_SEQPIX').AsString,
                                                      ARegistroPix.FieldByName('MPX_USASHP').AsString = 'S');

    LDadosRetorno := TFuncoesPix.RetornaDadosDoRetornoPixDevolucao(LResposta,
                                                                   ARegistroPix.FieldByName('MPX_USASHP').AsString = 'S');

    For LContador := 1 To 4 Do
    Begin
      If MatchStr(LDadosRetorno.Status, STATUS_PIX_DEVOLVIDO) Then
      Begin
        LDevolucaoRealizada := True;

        TPixDao.Create().AtualizaDadosRetornoDevolucaoPix(LDadosRetorno,
                                                          ARegistroPix.FieldByName('AUTOINCREM').AsString,
                                                          Self.Name,
                                                          IIF(blnResCai, VS_strCodigoOperadorLogadoCaixa, strLoginUsuarioLogado));

        Break;
      End;

      Sleep(LTempoAguardo);

      Application.ProcessMessages;

      LDevolucaoRealizada := ValorPixJaDevolvidoNoBanco(ARegistroPix, False);
      If LDevolucaoRealizada Then
        Break;
    End;

    If Not LDevolucaoRealizada Then
      Raise Exception.Create('A solicitação da devolução do Pix foi solicitada ao banco, mas ainda não foi processada.' + #13 +
                             'Aguarde em torno de 2 minutos e realize o estorno novamente.');
  Except
    On E: Exception Do
    Begin
      LMensagemErro := E.Message;
      If LeftStr(LMensagemErro, 7) <> 'DEVPIX-' Then
        LMensagemErro := 'DEVPIX-' + LMensagemErro;

      Raise ExceptionAutcom.Create(LMensagemErro);
    End;
  End;
end;

function TfrmEstornoReceber.fDocsBaixaComLCK: Boolean;
var
  cdsDocsBai: TUniQuery;
  blnErro: Boolean;
  strChaLckDocs, strDoc: String;
begin
  Result  := False;
  blnErro := False;

  cdsDocsBai := fCriaQuery;
  with cdsDocsBai do
  begin
    SQL.Text := ' SELECT ' +
                '    CTR_NUMDUP, CTR_ESPDOC, CTR_CODEMP, CTR_CODCLI, CTR_PARCEL, CTR_SEQBAI ' +
                ' FROM CADREC ' +
                ' WHERE ' +
                '    CTR_SEQCON =  "'   + cdsDados.FieldByName('CTR_SEQCON').AsString + '"';

    open;


    if RecordCount > 1 then
    begin
      while not Eof do
      begin
        strChaLckDocs := 'CADREC' +
                         FieldByName('CTR_NUMDUP').AsString +
                         FieldByName('CTR_ESPDOC').AsString +
                         FieldByName('CTR_CODEMP').AsString +
                         FieldByName('CTR_CODCLI').AsString;

        If Not fLockedByCurrentConnection(strChaLckDocs) And Not fEmptyStr(fGetHostLock(strChaLckDocs)) Then
        begin
          blnErro := True;
          Last;
        end;

        strChaLckDocs := strChaLckDocs + cdsDocsBai.FieldByName('CTR_PARCEL').AsString;
        If Not fLockedByCurrentConnection(strChaLckDocs) And Not fEmptyStr(fGetHostLock(strChaLckDocs)) Then
        Begin
          blnErro := True;
          Last;
        End;

        strChaLckDocs := strChaLckDocs + cdsDocsBai.FieldByName('CTR_SEQBAI').AsString;
        If Not fLockedByCurrentConnection(strChaLckDocs) And Not objLock.fLock_Unlock(strChaLckDocs, True, False) Then
        Begin
          blnErro := True;
          Last;
        End;

        Next;
      end;
    end;
  end;

  FreeAndNil(cdsDocsBai);

  if blnErro then
  begin
    strDoc := StringReplace(strChaLckDocs, 'CADREC', '', []);
    strDoc := Copy(strDoc, 1, 12) + Copy(strDoc, 26, 1) +'-' + Copy(strDoc, 13, 2) + '-' + Copy(strDoc, 18, 8) + ' / Loja: ' + Copy(strDoc, 15, 3);
    fMensagem('ATENÇÃO!', 'O  documento ' + strDoc + ', participante da baixa, está sendo utilizado por outra estação: ' + fGetHostLock(strChaLckDocs), ['&Ok']);
    Result := True;
    Exit;
  end;

end;

{*****************************************}
{* RETORNA TRUE, SE HÁ ALGUMA DUPLICATA  *}
{* PRINCIPAL SELECIONADA                 *}
{**************************************MV*}
function TfrmEstornoReceber.fVerificaDuplicataPrincipal: Boolean;
begin
  If cdsDados.FieldByName('CTR_SEQBAI').AsInteger = 0 Then
    Result := True
  Else
    Result := Not fDuplicataPrincipalBaixada(cdsDados.FieldByName('NUMDUP').AsString,
                                             cdsDados.FieldByName('PARDUP').AsString,
                                             cdsDados.FieldByName('CTR_ESPDOC').AsString,
                                             cdsDados.FieldByName('CTR_CODEMP').AsString,
                                             cdsDados.FieldByName('CTR_CODCLI').AsString,
                                             cdsDados.FieldByName('CTR_SEQBAI').AsInteger);
end;

function TfrmEstornoReceber.fTemDuplicataOrigemConverte: Boolean;
 Var
   intRecNo : Integer;
begin
  With cdsDados Do
  Begin
    Result := False;
    intRecNo := cdsDados.RecNo;
    DisableControls;
    First;
    While Not Eof Do
    Begin
      If fEhDuplicataOriginadaDeConverte(FieldByName('NUMDUP').AsString,FieldByName('PARDUP').AsString,
                                         FieldByName('CTR_CODEMP').AsString,FieldByName('CTR_CODCLI').AsString,
                                         FieldByName('CTR_ESPDOC').AsString,'','CADREC') Then
      Begin
        fMensagem('', 'Há duplicata(s) originada(s) de converte, portando não será possível realizar o estornar, pois a(s) mesma(s) são somente para consultas! ', ['&O k']);
        Last;
        Result := True;
      End;
      Next;
    End;
    cdsDados.RecNo := intRecNo;
    EnableControls;
  End;
end;

function TfrmEstornoReceber.fTemLinkPagamento: Boolean;
begin
  Result := False ;

  if TValidacoesPagamentoOnline.fAgrupamentoPossuiLinkPagamento(
          cdsDados.FieldByName('NUMDUP').AsString,
          cdsDados.FieldByName('CTR_ESPDOC').AsString,
          cdsDados.FieldByName('CTR_CODEMP').AsString,
          cdsDados.FieldByName('CTR_CODCLI').AsString) then
  begin
    pEmitirMensagem('', 'Não será possível estornar esta duplicata pois existe link de pagamento. ' +
                        'Para ser possível estorná-lo, o mesmo deve ser cancelado. Acessar  Útil > Links para Pagamento Online - Manutenção.', True);
    Exit(True);
  end;

  if (cdsDados.FieldByName('CTR_ESPDOC').AsString = 'PD') and
     TLinkPagamentoCitelClass.fDocumentoLinkPagamentoCitel(cdsDados.FieldByName('NUMDUP').AsString,
                                                           cdsDados.FieldByName('CTR_ESPDOC').AsString,
                                                           cdsDados.FieldByName('CTR_CODEMP').AsString, '', 'PD') then
  begin
    pEmitirMensagem('', 'Pedido com Link de Pagamento associado. '+#13#10+
                        'Para realizar o estorno, acessar rotina '+#13#10+
                        '" > Útil > Links para Pagamento Online - Manutenção" e acionar botão "Cancelar Pagamento"', True);
    Exit(True) ;
  end ;

end;

procedure TfrmEstornoReceber.dbgDuplicatasDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  If (Not cdsDados.Active) Or (cdsDados.IsEmpty) Or (cdsDados.Fields.FindField('CTR_MARDES') = Nil) Then
    Exit;

  If cdsDados.FieldByName('CTR_MARDES').AsString = 'M' Then
  Begin
    dbgDuplicatas.Canvas.Font.Color := clBlue;
    dbgDuplicatas.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;

end;

procedure TfrmEstornoReceber.btnConsultarClick(Sender: TObject);
begin
  inherited;
  fValidaCampos(btnConsultar, True);
end;

procedure TfrmEstornoReceber.btnSairEstClick(Sender: TObject);
begin
  inherited;
  Close;
end;

Function TfrmEstornoReceber.fHouveTransferenciaCartao(intSeqCon: Integer; strEmpRcx: String; dtaDtaCad: TDateTime; blnNaoTransf:Boolean = False): Boolean;
  Var
    qryGen: TUniQuery;
Begin

  qryGen := fCarregaCartoesTransferidos(intSeqCon, strEmpRcx, dtaDtaCad,blnNaoTransf);

  Result := Not qryGen.IsEmpty;

  If Result Then
  Begin
    pEmitirMensagem('','Há cartões '+IfThen(blnNaoTransf,'não','') + ' transferidos relativos a essa baixa!.' + #13 +
                    IfThen(blnNaoTransf,'Deve ser transferido o cartão referente a liberação: '+ qryGen.FieldByName('MCA_NUMCCD').AsString  +  ' antes do estorno ser efetuado.'
                     ,'Para estornar este documento cancelar o sequencial: '+qryGen.FieldByName('MCA_SEQTRF').AsString+'.' + #13 +
                    'F1 - LANÇAMENTOS > TF - TRANSFERÊNCIA > [F8] CANCELAMENTO DE TRANSFERÊNCIAS'), True);
  End;

  qryGen.Close;

  FreeAndNil(qryGen);
End;

Function TfrmEstornoReceber.fHouveTransferenciaCheque(intSeqCon: Integer; strEmpRcx: String; dtaDtaCad: TDateTime; blnNaoTransf:Boolean = False): Boolean;
  Var
    qryGen: TUniQuery;
    sltNaoTransf:TStringList;
Begin
  sltNaoTransf := TStringList.Create;

  qryGen := fCarregaChequesTransferidos(intSeqCon, strEmpRcx, dtaDtaCad,blnNaoTransf);

  Result := Not qryGen.IsEmpty;

  If Result  Then
  Begin
    qryGen.First;
    While Not qryGen.Eof do
    Begin
      sltNaoTransf.Add(qryGen.FieldByName('CHQ_NUMCHQ').AsString);
      qryGen.Next;
    End;
  End;

  If Result Then
  Begin
    pEmitirMensagem('','Há cheques '+IfThen(blnNaoTransf,'não','') +  ' transferidos relativos a essa baixa!' + #13 +
                    IfThen(blnNaoTransf,'Devem ser transferidos os cheques: '+sltNaoTransf.Text+ ' antes do estorno ser efetuado.',
                    'Para estornar este documento cancelar o sequencial: '+qryGen.FieldByName('CHQ_SEQTRF').AsString+'.' + #13 +
                    'F1 - LANÇAMENTOS > TF - TRANSFERÊNCIA > [F8] CANCELAMENTO DE TRANSFERÊNCIAS'), True, True);
  End;

  qryGen.Close;
  FreeAndNil(qryGen);
End;

function TfrmEstornoReceber.FiltroPossuiBaixaDeDuplicatasComTotalEParcial(
  ADataset: TUniClientDataset): Integer;
  Var
    AChaveDuplicata,
    ASeqconValidacao: String;
begin
  Result := 0;

  ADataset.IndexFieldNames := 'NUMDUP;PARDUP;CTR_ESPDOC;CTR_CODEMP;CTR_CODCLI;CTR_SEQBAI;CTR_SEQCON';
  ADataset.First;

  AChaveDuplicata := EmptyStr;
  ASeqconValidacao := '0';

  While Not ADataset.Eof Do
  Begin
    If Not AChaveDuplicata.Contains(ADataset.FieldByName('NUMDUP').AsString +
                                    ADataset.FieldByName('PARDUP').AsString +
                                    ADataset.FieldByName('CTR_ESPDOC').AsString +
                                    ADataset.FieldByName('CTR_CODEMP').AsString +
                                    ADataset.FieldByName('CTR_CODCLI').AsString) Then
    Begin
      AChaveDuplicata := ADataset.FieldByName('NUMDUP').AsString +
                         ADataset.FieldByName('PARDUP').AsString +
                         ADataset.FieldByName('CTR_ESPDOC').AsString +
                         ADataset.FieldByName('CTR_CODEMP').AsString +
                         ADataset.FieldByName('CTR_CODCLI').AsString +
                         ADataset.FieldByName('CTR_SEQBAI').AsString;

      If ADataset.FieldByName('CTR_SEQBAI').AsString.Equals('0') Then
        ASeqconValidacao := ADataset.FieldByName('CTR_SEQCON').AsString;
    End
    Else
    Begin
      If Not ADataset.FieldByName('CTR_SEQBAI').AsString.Equals('0') Then
      Begin
        If RightStr(AChaveDuplicata, 1).Equals('0') Then
        Begin
          If Not ASeqconValidacao.Equals(ADataset.FieldByName('CTR_SEQCON').AsString) Then
          BEgin
            Result := StrToInt(ASeqconValidacao);

            Break;
          End;
        End;
      End;
    End;

    ADataset.Next;
  End;

  ADataset.IndexFieldNames := '';
  ADataset.First;
end;

procedure TfrmEstornoReceber.ApagaRegistroPix(ASeqCon: Integer;
  AEmpresaLancamento: String; ADataRecebimento: TDateTime);
  Var
    LDadosPedidoPix: TUniClientDataSet;
begin
  If MatchStr(ASeqCon.ToString, ['', '0']) Then
    Exit;

  If Not Assigned(FRegistroMovPix) Then
    Exit;

  Try
    If Not FRegistroMovPix.IsEmpty Then
    Begin
      FRegistroMovPix.First ;
      while not FRegistroMovPix.Eof do
      begin
        SolicitarDevolucaoDoPix(FRegistroMovPix);

        If FGerarCreditoDevolucaoPix Then
          FGerouCreditoPix := GerarCreditoRecebimentoPix(FRegistroMovPix);

        LDadosPedidoPix := TPixDao.RetornaDadosPedidoPix(FRegistroMovPix.FieldByName('MPX_TX_ID_').AsString,
                                                         FRegistroMovPix.FieldByName('MPX_CODEMP').AsString);

        If Not LDadosPedidoPix.IsEmpty Then
          TPixDao.LimparPixDosPedidos(FRegistroMovPix.FieldByName('MPX_CODEMP').AsString,
                                      FRegistroMovPix.FieldByName('MPX_TX_ID_').AsString);

        If (FRegistroMovPix.FieldByName('MPX_RESCAI').AsInteger = 1) And
           (ADataRecebimento = dtaDtaRcx) Then
          TFuncoesPixAutcom.ExcluirPixDoCaixa(ASeqCon,
                                              FRegistroMovPix.FieldByName('MPX_CODEMP').AsString,
                                              ADataRecebimento,
                                              Self.Name,
                                              StrToInt(fRetRcxCon))
        Else
          TPixDao.ExcluirRegistroDoPix(FRegistroMovPix.FieldByName('MPX_CODEMP').AsString,
                                       FRegistroMovPix.FieldByName('MPX_TX_ID_').AsString,
                                       Self.Name,
                                       'EXCLUSÃO - ESTORNO RECEBER');
        FRegistroMovPix.Next ;
      end ;
    end;
  Finally
    If Assigned(LDadosPedidoPix) Then
      FreeAndNil(LDadosPedidoPix);
  End;
end;

procedure TfrmEstornoReceber.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (cdsDados.Active = False) Or (cdsDados.IsEmpty) Then
  begin
    fMensagem('ATENÇÃO!', 'O número da duplicata deve ser preenchido!', ['&O k']);
    pSetFocus(edtNumDup);
    Exit;
  end;
  
  Try
    Self.Enabled := False;
    btnConfirma.Enabled := False;
    pConfirmaEstorno;
    pVerificaDuplicatasRestantesDocumento;
  Finally
    Self.Enabled := True;
    btnConfirma.Enabled := True;

    FRealizarDevolucaoDoPix := fCfgSis('DEVPIX', varBoolean);
  End;

end;

procedure TfrmEstornoReceber.edtCodCliExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtCodCli.Text) Then
    If Not fValidaCampos(edtCodCli) Then
    Begin
      pSetFocus(edtNumDup);
      Exit;
    End;
end;

procedure TfrmEstornoReceber.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmEstornoReceber.fVerSeqBai(strNumDup, strEspDoc, strParcel, strCodEmp, strCodCli: String): Boolean;
  Var
    strSQL: String;
    qryAux: TUniQuery;
begin
  Try
    qryAux := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   COUNT(*) AS QTD ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + ' CADREC ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '   CTR_SEQBAI = 0           ';

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('NUMDUP').AsString   := strNumDup;
    qryAux.ParamByName('ESPDOC').AsString   := strEspDoc;
    qryAux.ParamByName('PARCEL').AsString   := strParcel;
    qryAux.ParamByName('CODEMP').AsString   := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString   := strCodCli;
    qryAux.Open;

    Result := (qryAux.FieldByName('QTD').AsInteger > 0);

    qryAux.Close;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function TfrmEstornoReceber.GeracaoCreditoRecebimentoPix(
  ADataset: TDataset): Boolean;
  Var
    LCtrSelecionaTipoEstornoPix: TfrmCtrSelecionaTipoEstornoPix;

    LAbreTelaSelecao: Boolean;
begin
  LAbreTelaSelecao := FRealizarDevolucaoDoPix;
  If LAbreTelaSelecao Then
    LAbreTelaSelecao := DaysBetween(ADataset.FieldByName('MPX_DTAREC').AsDateTime, VS_Date) < 90;

  If Not LAbreTelaSelecao Then
    Exit(fMensagem('ATENÇÃO', 'Deseja gerar um crédito ao cliente de ' +
                              FormatFloat(',0.00', fRetornaValRecPix(ADataset)) +
                              ' referente ao Pix que será removido?', ['&Sim', '&Não']) = 1);

  If ADataset.FieldByName('MPX_USASHP').AsString = 'S' Then
  Begin
    If ADataset.FieldByName('MPX_QTDDEV').AsInteger In [1, 2] Then
      Exit(False);
  End;

  Try
    pCriarFormularios(TfrmCtrSelecionaTipoEstornoPix, LCtrSelecionaTipoEstornoPix);
    LCtrSelecionaTipoEstornoPix.ShowModal;

    Result := LCtrSelecionaTipoEstornoPix.TipoEstorno = tpeCredito;
  Finally
    FreeAndNil(LCtrSelecionaTipoEstornoPix);
  End;
end;

function TfrmEstornoReceber.GerarCreditoRecebimentoPix(
  ADataset: TDataset): Boolean;
  Var
    LSeqLan,
    LOperador,
    LNumeroDuplicata: String;
    LBanCtr: TBanCtrRepository;
    strSeqRec : String;
    LDataCad  : TDatetime;
begin
  If ValorPixJaDevolvidoNoBanco(ADataset) Then
    Exit(False);

  Try
    LNumeroDuplicata := fRetSequencial('PROCCO', VS_strCodEmp, fTamDocCadRec);

    LOperador := strCodOpe;
    If LOperador.IsEmpty Then
      LOperador := strLoginUsuarioLogado;

    LDataCad := ADataset.FieldByName('MPX_DTAREC').AsDateTime;

    If fCampoTabela('POR_BAIUTL', 'CADPOR', ['POR_CODPOR'], [FPortadorCredito]) = 'S' Then
       LDataCad := fAcertaDataParaDiaUtil(ADataset.FieldByName('MPX_DTAREC').AsDateTime);

    Result := fGravaCadRec(strSeqRec,
                           Self.Name,
                           'INCLUSÃO',
                           LNumeroDuplicata,                                                   // Duplicata
                           'A',                                                                // Parcela
                           0,                                                                  // Sequencial de Baixa
                           'CC',                                                               // Espécie
                           edtCodCli.Text,                                                     // Cliente
                           VS_strCodEmp,                                                       // Empresa
                           LOperador,                                                          // Vendedor
                           LOperador,                                                          // Digitador
                           FPortadorCredito,                                                   // Portador
                           LDataCad,                                                           // Data de Cadastro
                           LDataCad,                                                           // Data de Vencimento
                           -ADataset.FieldByName('MPX_VALREC').AsFloat,                        // Valor da Duplicata
                           -ADataset.FieldByName('MPX_VALREC').AsFloat,                        // Valor Original
                           0.0,                                                                // Despesa de Cobrança
                           'N',                                                                // Desconto
                           'CRÉDITO GERADO POR ESTORNO DE RECEBIMENTO PIX - ' +
                              edtNumDup.Text + edtParcel.Text + '-' + edtCodEmp.Text,          // Histórico 1
                           '',                                                                 // Histórico 2
                           '',                                                                 // Portador da Baixa
                           '',                                                                 // Centro de Custo da Baixa
                           '',                                                                 // Operador da Baixa
                           '',                                                                 // Documento da Baixa
                           0.0,                                                                // Valor do Recebimento
                           0,                                                                  // Data do Recebimento
                           'N',
                           FEventoCredito,                                                     // Código do Evento
                           '',                                                                 // Código Velho (CONVERSÃO)
                           '',                                                                 // Tipo de Fora (Condição de Pagamento)
                           '',                                                                 // Código da Condição de Pagamento
                           False,
                           IIF(fEmptyStr(fCfgSis('CTR_CC')),'',fCfgSis('CTR_CC')),             // Codigo do Centro de Custo
                           0,                                                                  // Sequencial de Controle
                           0,
                           '','','','',0,0,0,0,'','','','','','',0,0,'',0,0,'N',
                           0,0,0,0,0,0,0,0,'',0,0,0,'',0,0,0,0,0,0,'',0,'INCLUSÃO',
                           '','','','N','N','','','','',
                           ADataset.FieldByName('MPX_SEQCON').AsInteger,
                           ADataset.FieldByName('MPX_DTAREC').AsDateTime);

    If Result Then
    Begin
      LBanCtr := TBanCtrRepository.Create;
      LBanCtr.fAdd(LNumeroDuplicata,
                   'A',
                   'CC',
                   VS_strCodEmp,
                   edtCodCli.Text,
                   'CRÉDITO GERADO POR ESTORNO DE RECEBIMENTO PIX - ' +
                          edtNumDup.Text + edtParcel.Text + '-' + edtCodEmp.Text,
                   '',
                   0,
                   ADataset.FieldByName('MPX_VALREC').AsFloat,
                   0.0,
                   0.0,
                   0.0,
                   'S');

      LSeqLan := fGravaMovBan(ADataset.FieldByName('MPX_CTABAI').AsString,       // Centro de Custo
                              ADataset.FieldByName('MPX_PORBAI').AsString,       // Portador da Baixa
                              LOperador,                                         // Operador da Baixa
                              LDataCad,                                          // Data do Lançamento
                              fTime(),                                           // Hora do Lançamento
                              LNumeroDuplicata,                                  // Numero do Documento
                              'C',                                               // Credito / Debito
                              VS_strCodEmp,                                      // Empresa da Baixa
                              ADataset.FieldByName('MPX_VALREC').AsFloat,        // Valor Do Lançamento
                              'CRÉDITO GERADO POR ESTORNO DE RECEBIMENTO PIX',   // Histórico 1
                              'DOC: ' + edtNumDup.Text + edtParcel.Text + '-' + edtCodEmp.Text,  // Histórico 2
                              edtCodCli.Text,                                    // Cliente da Duplicata
                              '',                                                // Fornecedor da Duplicata
                              LNumeroDuplicata,                                  // Número da Duplicata
                              0,                                                 // Sequencial de Baixa
                              'A',                                               // Parcela da Duplicata
                              VS_strCodEmp,                                      // Empresa da Duplicata
                              '',                                                // Série
                              '',                                                // Codigo do Evento
                              '',                                                // Documento da Baixa
                              LBanCtr.fGetList);

      pAtualizarSequencialMovBanInclusaoCredito(strSeqRec, LSeqLan);

      Result := Not LSeqLan.IsEmpty;

      If Not Result Then
        Raise Exception.Create('Não foi possível gravar a movimentação bancária ao gerar o Crédito do Pix.');

      TLogMpx.GravaLogMpx(ADataset.FieldByName('AUTOINCREM').AsString,
                          'GERAÇÃO CRÉDITO ESTORNO PIX',
                          Self.Name);
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TfrmEstornoReceber.LacarEstornoAnalíticoCaixaLancamentoZerado(
  ASeqcon: Integer; AEmpresaBaixa: String; ADataRecebimento: TDateTime);
  Var
    LConsulta: TUniQuery;

    LAutoIncremRcx: String;

    LSeqConEstorno: Integer;
begin
  If ASeqCon <= 0 Then
    Exit;

  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT * FROM CADRCXX ' +
                          ' WHERE RCX_DTACAD="' + FormatDateTime('yyyy/mm/dd', ADataRecebimento) + '" ' +
                          '   AND RCX_CODEMP="' + AEmpresaBaixa + '" ' +
                          '   AND RCX_SEQCON=' + ASeqcon.ToString;

    If Not strCodigoCaixa.IsEmpty Then
      LConsulta.SQL.Text := LConsulta.SQL.Text  + ' AND RCX_CODCAX="' + strCodigoCaixa + '" ';

    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit;

    LSeqConEstorno := StrToInt(fRetRcxCon);

    While Not LConsulta.Eof Do
    Begin
      fGravaCadRcx(LAutoIncremRcx,
                   LConsulta.FieldByName('RCX_CODCLI').AsString,                       // Cliente
                   LConsulta.FieldByName('RCX_CODOPE').AsString,                       // Operador
                   LConsulta.FieldByName('RCX_NUMDOC').AsString,                       // Documento
                   IIF(LConsulta.FieldByName('RCX_VALDOC').AsFloat > 0, 'LD', 'LC'),   // Espécie
                   LConsulta.FieldByName('RCX_CODEMP').AsString,                       // Empresa
                   dtaDtaRcx,                                                          // Data de Cadastro
                   fTime(),                                                            // Hora de Cadastro
                   LConsulta.FieldByName('RCX_NUMDUP').AsString,                       // Duplicata
                   LConsulta.FieldByName('RCX_PARCEL').AsString,                       // Parcela
                   'REF. A ESTORNO. CTA. RECEBER',                                     // Descrição
                   LConsulta.FieldByName('RCX_JURDES').AsString,                       // Juros / Desconto
                   '',                                                                 // Identificação de Fechamento
                   '',                                                                 // Forma de Pagamento
                   fFormataFloat(LConsulta.FieldByName('RCX_VALDOC').AsFloat * -1, 2), // Valor do Documento
                   fFormataFloat(LConsulta.FieldByName('RCX_VALJUR').AsFloat * -1, 2), // Valor do Desconto
                   fFormataFloat(LConsulta.FieldByName('RCX_VALDES').AsFloat * -1, 2), // Valor do Juros
                   fFormataFloat(LConsulta.FieldByName('RCX_DINREC').AsFloat * -1, 2), // Dinheiro recebido
                   fFormataFloat(LConsulta.FieldByName('RCX_CHQAVI').AsFloat * -1, 2), // Cheque a vista
                   fFormataFloat(LConsulta.FieldByName('RCX_CHQPRE').AsFloat * -1, 2), // Cheque pre datado
                   fFormataFloat(LConsulta.FieldByName('RCX_CARREC').AsFloat * -1, 2), // Valor em Cartã
                   fFormataFloat(LConsulta.FieldByName('RCX_ORDREC').AsFloat * -1, 2), // Valor em Ordem de Pagamento
                   fFormataFloat(LConsulta.FieldByName('RCX_VALCRE').AsFloat * -1, 2), // Valor do Crédito
                   fFormataFloat(LConsulta.FieldByName('RCX_VALFIN').AsFloat * -1, 2), // Valor em Financiamento
                   fFormataFloat(LConsulta.FieldByName('RCX_OUTROS').AsFloat * -1, 2), // Valor de outros
                   0.00,                                                               // Venda a prazo
                   '',                                                                 // Num. do Romaneio
                   LSeqConEstorno,                                                     // Sequencial de Controle
                   LConsulta.FieldByName('RCX_SEQBAI').Value,                          // Sequencial de Baixa (Duplicata)
                   fCfgSisL('SQFCRX'),                                                 // Sequencial de Fechamento parcial de caixa
                   LConsulta.FieldByName('RCX_EMPDUP').AsString,                       // Empresa da duplicata
                   '',                                                                 // MotDes
                   1,                                                                  // Identificação do Caixa
                   fFormataFloat(LConsulta.FieldByName('RCX_TOTGUA').AsFloat * -1, 2),
                   fFormataFloat(LConsulta.FieldByName('RCX_TOTDOL').AsFloat * -1, 2),
                   fFormataFloat(LConsulta.FieldByName('RCX_TOTEUR').AsFloat * -1, 2),
                   fFormataFloat(LConsulta.FieldByName('RCX_TOTPES').AsFloat * -1, 2),
                   fFormataFloat(LConsulta.FieldByName('RCX_TOTREA').AsFloat * -1, 2),
                   'N',
                   strMotEst,
                   LConsulta.FieldByName('RCX_CODCAX').AsString,
                   '',
                   0.00,
                   False,
                   0.00,
                   '',
                   0,
                   LConsulta.FieldByName('RCX_RECPIX').AsString);

      LConsulta.Next;
    End;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TfrmEstornoReceber.fVerConfirmada(strNumDup, strEspDoc, strParcel, strCodEmp, strCodCli: String): Boolean;
  Var
    strSQL: String;
    qryAux: TUniQuery;
begin

  Try
    qryAux := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   CTR_NUMDUP ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CTRCNF ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '   CTR_SEQBAI = 0           ';

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('NUMDUP').AsString   := strNumDup;
    qryAux.ParamByName('ESPDOC').AsString   := strEspDoc;
    qryAux.ParamByName('PARCEL').AsString   := strParcel;
    qryAux.ParamByName('CODEMP').AsString   := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString   := strCodCli;
    qryAux.Open;

    Result := Not qryAux.IsEmpty;

    qryAux.Close;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function TfrmEstornoReceber.fPrincipalConfirmadaNoMesmoCadastro(const ANumeroDuplicata, AEspecie, AParcela, AEmpresa,
  ACliente: String; const ADataCadastro: TDateTime): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery(Self);
  Try
    LConsulta.SQL.Add(' SELECT ');
    LConsulta.SQL.Add('   CTR_NUMDUP ');
    LConsulta.SQL.Add(' FROM ');
    LConsulta.SQL.Add('   CTRCNF ');
    LConsulta.SQL.Add(' WHERE ');
    LConsulta.SQL.Add('   CTR_NUMDUP = :NUMDUP AND ');
    LConsulta.SQL.Add('   CTR_ESPDOC = :ESPDOC AND ');
    LConsulta.SQL.Add('   CTR_PARCEL = :PARCEL AND ');
    LConsulta.SQL.Add('   CTR_CODEMP = :CODEMP AND ');
    LConsulta.SQL.Add('   CTR_CODCLI = :CODCLI AND ');
    LConsulta.SQL.Add('   CTR_SEQBAI = 0       AND ');
    LConsulta.SQL.Add('   CTR_DTACAD = :DTACAD     ');

    LConsulta.ParamByName('NUMDUP').AsString   := ANumeroDuplicata;
    LConsulta.ParamByName('ESPDOC').AsString   := AEspecie;
    LConsulta.ParamByName('PARCEL').AsString   := AParcela;
    LConsulta.ParamByName('CODEMP').AsString   := AEmpresa;
    LConsulta.ParamByName('CODCLI').AsString   := ACliente;
    LConsulta.ParamByName('DTACAD').AsDateTime := ADataCadastro;
    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmEstornoReceber.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEstornoReceber.edtNumDupExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtNumDup.Text) Then
    fValidaCampos(edtNumDup);
end;

function TfrmEstornoReceber.fEstornaDuplicataConjugadas(oleDados: OleVariant; strPorBai: String): Boolean;
  Var
    strCreDeb    : String;
    strSeqRcx    : String;
    strOpeBai    : String;

    fltTotGua    : Double;
    fltTotDol    : Double;
    fltTotEur    : Double;
    fltTotPes    : Double;
    fltTotRea    : Double;

    fltTecTot    : Double;
    fltValDin    : Double;
    fltValCar    : Double;
    fltChqVis    : Double;
    fltChqPre    : Double;
    fltOrdRec    : Double;
    fltValFin    : Double;
    fltValLan    : Double;
    blnResult    : Boolean;
    intResCai    : Integer;
    dtaDtaRec    : TDateTime;
    dtaEstorn    : TDateTime;

    cdsAux       : TUniClientDataSet;
    lstBanCtr    : TBanCtrRepository;
    repMovBan    : TMovBanRepository;
    AMovBan      : TList<TMovBan>;
    frmBaixaReceber : TfrmBaixaReceber;

    intTipDtaEstBai: Integer;

    blnEstornouMovCarYapay: boolean;

    strRetornoErro,
    LOperadorCaixa: string;

    LGravouMovBanEstorno: Boolean;

    blnExisteMovBanJurosDesc: Boolean;

    LRecebidoPorPix: String;
begin
  Result := False;
  blnEstornouMovCarYapay := False;
  strDocsNaoEnc := '';

  If fEmptyStr(strOpeBai) Then
    strOpeBai := strLoginUsuarioLogado;

  strMotEst := '';
  LHistComplementar := '';
  If fCfgSis('RMOTES', varBoolean) Then
  begin

    If (blnEstornoAutomatico) And (Assigned(FobjFulFillmentLogBuilder)) Then
    Begin
      If (Not fExisteConfiguracao('CANOCO', VS_strCodEmp)) Then
      Begin
        pEmitirMensagem('', '"CFG_CANOCO" não encontrada na empresa '+ VS_strCodEmp +'!', True);
        Exit;
      End;

      If (Not fExisteConfiguracao('CANMOT', VS_strCodEmp)) Then
      Begin
        pEmitirMensagem('', '"CFG_CANMOT" não encontrada na empresa '+ VS_strCodEmp +'!', True);
        Exit;
      End;

      strMotEst         := fCfgSis('CANOCO', varString);
      LHistComplementar := fCfgSis('CANMOT', varString);

      If fEmptyStr(strMotEst) Then
      Begin
        pEmitirMensagem('', 'Não será possível estornar o recebimento no cancelamento pois o sistema está configurado '+
          'para solicitar o motivo no cancelamento (CFG_RMOTES) e não está configurado corretamente.'+ sLineBreak +
          'Preencha as configurações abaixo para que a importação possa ser realizada:'+ sLineBreak +
          'CFG_CANOCO - Ocorrência para importação de NF de Cancelamento via Fulfillment quando (CFG_RMOTES = "S")'+ sLineBreak +
          'CFG_CANMOT - Motivo para importação de NF de Cancelamento via Fulfillment quando (CFG_RMOTES = "S")', True);
        Exit;
      End;
    End
    Else
    Begin

      Try
        pCriarFormularios(TfrmDigOcorrencia, frmDigOcorrencia);
        frmDigOcorrencia.LEstornoCTR := True;
        frmDigOcorrencia.blnInformarHisCom := True;

        If (frmDigOcorrencia.ShowModal = mrOk) Then
        Begin
          strMotEst := (frmDigOcorrencia.strCodOco);
          LHistComplementar := (frmDigOcorrencia.strHisCom);
        End;
      Finally
        FreeAndNil(frmDigOcorrencia);
      End;

      If fEmptyStr(strMotEst) Then
      Begin
        pMensagemOk('O código da ocorrência do estorno deve ser preenchido!');
        Exit;
      End;

    End;

  end;

  Try
    cdsAux := TUniClientDataSet.Create(Self);
    cdsAux.Data := oleDados;

    cdsAux.Filter   := 'CTR_MARDES = ' + QuotedStr('M');
    cdsAux.Filtered := True;

    cdsAux.First;

    blnResult := True;
    intResCai := 0;
    dtaDtaRec := 0;
    stlConjugadas := TStringList.Create;

    with cdsAux Do
    begin
      while Not Eof do
      begin
        {******************************************************************}
        {**** CRÉDITO DE CLIENTE O CAMPO CTR_DTAREC É GRAVADO ZERADO. *****}
        {* PERCORRE O CLIENT ATÉ ENCONTRAR A DUPLICATA COM CTR_VALREC > 0 *}
        {****** FAZENDO COM QUE SEJA A DUPLICATA A SER VERIFICADA. ********}
        {**REQ*46346***07/01/2016***************************************MO*}
        If (cdsAux.FieldByName('CTR_VALREC').AsFloat > 0) and (cdsAux.FieldByName('CTR_ORIGEM').AsString <> 'CTR') Then
        begin
          If ((cdsAux.FieldByName('CTR_DTAREC').AsDateTime <> dtaDtaRcx) And
              (cdsAux.FieldByName('CTR_RESCAI').AsInteger <> 0)) Then
          Begin
            strPorBai := IIF(fEmptyStr(cdsAux.FieldByName('CTR_PORBAI').AsString),
                             strPorBai, cdsAux.FieldByName('CTR_PORBAI').AsString);

            If Not fPedePortadorCaixa(strPorBai) Then
              Exit
            Else
              Break;
          End;
        end;
        cdsAux.Next;
      end;
    end;
    If fEmptyStr(strPorBai) Then strPorBai := cdsAux.FieldByName('CTR_PORBAI').AsString;
    If fEmptyStr(strPorBai) Then fPedePortador(strPorBai);

    If fEmptyStr(strPorBai) Then
      Exit;

    cdsAux.First;
    While Not cdsAux.Eof Do
    Begin

      If (cdsAux.FieldByName('CTR_ESPDOC').AsString <> 'PD') And
         (fPrincipalConfirmadaNoMesmoCadastro(cdsAux.FieldByName(    'NUMDUP').AsString,
                                              cdsAux.FieldByName('CTR_ESPDOC').AsString,
                                              cdsAux.FieldByName(    'PARDUP').AsString,
                                              cdsAux.FieldByName('CTR_CODEMP').AsString,
                                              cdsAux.FieldByName('CTR_CODCLI').AsString,
                                              cdsAux.FieldByName('CTR_DTACAD').AsDateTime)) Then
      Begin
        pEmitirMensagem('','Estorno não permitido, pois a duplicata principal de: ' + cdsAux.fieldbyname('CTR_NUMDUP').AsString +
                        ' não foi encontrada ou foi confirmada.', True);

        blnResult := False;
        Break;
      End;

      If (cdsAux.FieldByName('CTR_TABELA').AsString = 'CADREC') And
         (Not fVerSeqBai(cdsAux.FieldByName(    'NUMDUP').AsString,
                         cdsAux.FieldByName('CTR_ESPDOC').AsString,
                         cdsAux.FieldByName(    'PARDUP').AsString,
                         cdsAux.FieldByName('CTR_CODEMP').AsString,
                         cdsAux.FieldByName('CTR_CODCLI').AsString)) Then
      Begin
        pEmitirMensagem('','Estorno não permitido, pois a duplicata principal de: ' + cdsAux.fieldbyname('CTR_NUMDUP').AsString +
                        ' não foi encontrada no Contas a Receber.' + #13#10 + 'Possível motivo: a duplicata já foi agrupada.', True);

        blnResult := False;
        Break;
      End;

      If Not ((cdsAux.fieldbyname('CTR_ESPDOC').AsString = 'CC') And (cdsAux.fieldbyname('CTR_DTAREC').AsDateTime = 0)) Then
      Begin
        If cdsAux.FieldByName('CTR_TABELA').AsString = 'ADTCLI' Then
        Begin
          If fAdtJaEstornado(cdsAux.FieldByName('AUTOINCREM').AsString) Then
          Begin
            blnResult := False;
            Break;
          End;
        End
        Else If fDupJaEstornada(cdsAux.FieldByName(    'NUMDUP').AsString,
                                cdsAux.FieldByName(    'PARDUP').AsString,
                                cdsAux.FieldByName('CTR_SEQBAI').AsString,
                                cdsAux.FieldByName('CTR_CODEMP').AsString,
                                cdsAux.FieldByName('CTR_ESPDOC').AsString,
                                cdsAux.FieldByName('CTR_CODCLI').AsString) Then
        Begin
          blnResult := False;
          Break;
        End;
      End;

      cdsAux.Next;
    End;

    If Not blnResult Then
      Exit;

    cdsAux.IndexFieldNames := 'CTR_SEQBAI';

    blnEstDtaDoc := False;
    cdsAux.First;
    While Not cdsAux.Eof Do
    Begin
      If (cdsAux.FieldByName('CTR_RESCAI').AsInteger = 0) Or
        ((cdsAux.FieldByName('CTR_DTAREC').AsDateTime <> dtaDtaRcx) And
         (cdsAux.FieldByName('CTR_RESCAI').AsInteger <> 0)) Then
      Begin
        if blnEstornoAutomatico then
          blnEstDtaDoc := False
        else
        Begin
          //blnEstDtaDoc := (fTipDtaEstBai(fVerificaAcessoSistema('DTAOER')) = 2);
          If (Not fVerificaAcessoSistema('DTAOER')) Then
          Begin
            pEmitirMensagem('','Operador sem acesso a "Estorno com Data do Dia do Estorno" e "Estorno com Data do Dia da Baixa". Por favor, verifique os direitos de acesso.', True);

            blnResult := False;
            Break;
          End;

          Case fCfgSis('RDTEMB', varInteger) of
            1: blnEstDtaDoc := (fTipDtaEstBai(fVerificaAcessoSistema('DTAOER')) = 2);
            2: blnEstDtaDoc := True;    // Data Documento;
            3: blnEstDtaDoc := False;   // Data Atual;
          Else

            intTipDtaEstBai := fTipDtaEstBai(fVerificaAcessoSistema('DTAOER'));

            If (intTipDtaEstBai = 2) Then
              blnEstDtaDoc := True
            Else If (intTipDtaEstBai = 1) Then
              blnEstDtaDoc := False
            Else
            Begin
              pEmitirMensagem('','Operador sem acesso a "Estorno com Data do Dia do Estorno" e "Estorno com Data do Dia da Baixa". Por favor, verifique os direitos de acesso.', True);

              blnResult := False;
              Break;
            End;

          End;
        End;
        Break;
      End;

      cdsAux.Next;
    End;

    cdsAux.IndexFieldNames := '';
    cdsAux.First;

    //FECHAMENTO FINANCEIRO
    //VERIFICA A DATA DA BAIXA DO DOCUMENTO, CASO ESCOLHIDA
    if (blnEstDtaDoc) and (cdsAux.FieldByName('CTR_DTAREC').AsDateTime > 0) then
      if objFechamento.FechamentoFinanceiroJaRealizado(VS_strCodEmp, cdsAux.FieldByName('CTR_DTAREC').AsDateTime) then
        blnResult := False;

    If Not blnResult Then
      Exit;

    fStartTransaction;

    fltTecTot := 0;
    cdsAux.First;
    While Not cdsAux.Eof Do
    Begin

      {********************************************************************}
      {* ZERO O VALOR AQUI PORQUE ESTAVA GRAVANDO VALOR DOBRADO NO MOVBAN *}
      {* QUANDO ERA BAIXA PARCIAL RECEBIDA NO CAIXA UTILIZANDO CC         *}
      {*****************************************************************JU*}
      fltValLan := 0;

      LGravouMovBanEstorno := False;

      {*****************************************}
      {* VERIFICA SE É UM CRÉDITO INCLUÍDO DU- *}
      {* RANTE A BAIXA, CASO POSITIVO, APAGA O *}
      {* CADREC E LANÇA O "LD" NO CAIXA.       *}
      {**************************************AF*}
      If (cdsAux.fieldbyname('CTR_ESPDOC').AsString = 'CC') And
         (cdsAux.fieldbyname('CTR_DTAREC').AsDateTime = 0)   Then
      Begin
        If Not blnEstDtaDoc Then
          dtaEstorn := VS_Date
        Else dtaEstorn := IIF(cdsAux.FieldByName('CTR_DTAREC').IsNull, cdsAux.FieldByName('CTR_DTACAD').AsDateTime, cdsAux.FieldByName('CTR_DTAREC').AsDateTime);
        pEstornarLancamentoCreditoCaixa(cdsAux.FieldByName('NUMDUP').AsString,
                                        cdsAux.FieldByName('PARDUP').AsString,
                                        cdsAux.FieldByName('CTR_CODEMP').AsString,
                                        cdsAux.FieldByName('CTR_ESPDOC').AsString,
                                        cdsAux.FieldByName('CTR_CODCLI').AsString,
                                        strPorBai,
                                        cdsAux.FieldByName('CTR_SEQBAI').AsInteger,
                                        cdsDados.Data,
                                        dtaEstorn,
                                        cdsAux.FieldByName('CTR_DTACAD').AsDateTime);
      End
      Else
      Begin
        If dtaDtaRec = 0 Then dtaDtaRec := cdsAux.FieldByName('CTR_DTAREC').AsDateTime;
        If intResCai = 0 Then intResCai := cdsAux.FieldByName('CTR_RESCAI').AsInteger;

        {********************************************}
        {* CASO FOR RESCAI = 0:                     *}
        {*   CASO NÃO VENHA DO RESUMO DE CAIXA, O   *}
        {*   VALOR É A SOMA DOS VALORES RECEBIDOS . *}
        {* CASO FOR RESCAI = 1:                     *}
        {*   CASO VENHA DO RESUMO DE CAIXA, O VALOR *}
        {*   DO LANCAMENTO É A SOMA DAS MODALIDADES.*}
        {**************************************MV,JB*}
        fltValDin := fltValDin + cdsAux.FieldByName('CTR_DINHEI').AsFloat;
        fltValCar := fltValCar + cdsAux.FieldByName('CTR_CARTAO').AsFloat;
        fltChqVis := fltChqVis + cdsAux.FieldByName('CTR_CHQAVI').AsFloat;
        fltChqPre := fltChqPre + cdsAux.FieldByName('CTR_CHQPRE').AsFloat;
        fltOrdRec := fltOrdRec + cdsAux.FieldByName('CTR_ORDPAG').AsFloat;
        fltValFin := fltValFin + cdsAux.FieldByName('CTR_VALFIN').AsFloat;

        fltTecTot := fltTecTot + cdsAux.FieldByName('CTR_VALREC').AsFloat;
        If intResCai = 0 Then
          fltValLan := fFormataFloat(cdsAux.FieldByName('CTR_VALREC').AsFloat, 2)
        Else
        Begin
          fltValLan := fltValLan + fFormataFloat(cdsAux.FieldByName('CTR_DINHEI').AsFloat, 2) +
                                   fFormataFloat(cdsAux.FieldByName('CTR_CARTAO').AsFloat, 2) +
                                   fFormataFloat(cdsAux.FieldByName('CTR_CHQAVI').AsFloat, 2) +
                                   fFormataFloat(cdsAux.FieldByName('CTR_CHQPRE').AsFloat, 2) +
                                   fFormataFloat(cdsAux.FieldByName('CTR_ORDPAG').AsFloat, 2) +
                                   fFormataFloat(cdsAux.FieldByName('CTR_VALFIN').AsFloat, 2);
        End;

        strCreDeb := RetornaTipoMovimentacaoBancaria(fltValLan);
        fltValLan := IIF(strCreDeb = 'D', 1, -1) * fltValLan;

        {*****************************************}
        {* GRAVA MOVBAN                          *}
        {**************************************AF*}
        If DeveGravarMovBan(cdsAux) Then
        Begin
          repMovBan := TMovBanRepository.Create;

          If Not blnEstDtaDoc Then
            dtaEstorn := VS_Date
          Else
          Begin
            {**************************}
            {* Caso não possua SEQLAN *}
            {* utilizar DTAREC        *}
            {***********************FS*}
            //Tirado o IIF, pois estava dando erro.
            dtaEstorn := cdsAux.FieldByName('CTR_DTAREC').AsDateTime;

            If cdsAux.FieldByName('CTR_TABELA').AsString = 'ADTCLI' Then
            Begin

              If Not cdsAux.FieldByName('CTR_DTABAN').IsNull Then
                 dtaEstorn := cdsAux.FieldByName('CTR_DTABAN').AsDateTime
              Else
                 dtaEstorn := IIF(cdsAux.FieldByName('CTR_DTAREC').IsNull, cdsAux.FieldByName('CTR_DTACAD').AsDateTime, cdsAux.FieldByName('CTR_DTAREC').AsDateTime);

            End;

            If fCfgSis('CTR_AS') = 'S'Then
            Begin
             dtaEstorn := fBuscaDataEstornoSintetica(cdsAux.FieldByName('NUMDUP').AsString,
                                                     cdsAux.FieldByName('CTR_CODCLI').AsString,
                                                     cdsAux.FieldByName('CTR_CODEMP').AsString,
                                                     cdsAux.FieldByName('PARDUP').AsString,
                                                     cdsAux.FieldByName('CTR_ESPDOC').AsString);

              If dtaEstorn = 0 Then
                dtaEstorn := cdsAux.FieldByName('CTR_DTAREC').AsDateTime;
            End;


            If (Not fEmptyStr(cdsAux.FieldByName('CTR_DOCBAI').AsString)) Then
            Begin
              AMovBan   := repMovBan.fRetDocumentos(cdsAux.FieldByName('CTR_EMPBAI').AsString,cdsAux.FieldByName('CTR_DOCBAI').AsString);
              If (assigned(AMovBan)) and (AMovBan.Count > 0) Then
                dtaEstorn := AMovBan[0].dtaDtaLan;
              AMovBan.Clear;
            End;
          End;

          {*****************************************************}
          {* LIMPANDO A ORIGEM DO REGISTRO PRINCIPAL DA MOVBAN *}
          {*REQ*155872***************************************MO*}
          If (Not fEmptyStr(cdsAux.FieldByName('CTR_DOCBAI').AsString)) Then
            repMovBan.pLimparOrigemPrincipal(cdsAux.FieldByName('CTR_DOCBAI').AsString, (cdsAux.FieldByName('CTR_RECPIX').AsString = 'S'));

          blnExisteMovBanJurosDesc := fVerificaExisteMovBanJurosDesc(cdsAux.FieldByName('AUTOINCREM').AsString);

          If Not blnExisteMovBanJurosDesc Then
          Begin

            lstBanCtr := TBanCtrRepository.Create;
            lstBanCtr.fAdd(cdsAux.FieldByName('NUMDUP').AsString,
                           cdsAux.FieldByName('PARDUP').AsString,
                           cdsAux.FieldByName('CTR_ESPDOC').AsString,
                           cdsAux.FieldByName('CTR_EMPBAI').AsString,
                           cdsAux.FieldByName('CTR_CODCLI').AsString,
                           cdsAux.FieldByName('CTR_HIST01').AsString,
                           cdsAux.FieldByName('CTR_HIST02').AsString,
                           cdsAux.FieldByName('CTR_SEQBAI').AsInteger,
                           fltValLan,
                           cdsAux.FieldByName('CTR_VALJUR').AsFloat,
                           cdsAux.FieldByName('CTR_VALDES').AsFloat,
                           cdsAux.FieldByName('CTR_VALANT').AsFloat,
                           'S');

          If fEmptyStr(fGravaMovBan(cdsAux.FieldByName('CTR_CTABAI').AsString,                           // Centro de Custo
                                    strPorBai,                                                           // Portador da Baixa
                                      strLoginUsuarioLogado,                                               // Operador da Baixa
                                      dtaEstorn,                                                           // Data do Lançamento
                                      fTime(),                                                             // Hora do Lançamento
                                      cdsAux.FieldByName('CTR_NUMDUP').AsString,                           // Numero do Documento
                                      strCreDeb,                                                           // Credito / Debito
                                      cdsAux.FieldByName('CTR_EMPBAI').AsString,                           // Empresa da Baixa
                                      fltValLan,                                                           // Valor Do Lançamento
                                      'ESTORNO DA DUPLICATA ' + cdsAux.FieldByName('CTR_NUMDUP').AsString, // Histórico 1
                                      '',                                                                  // Histórico 2
                                      cdsAux.FieldByName('CTR_CODCLI').AsString,                           // Cliente da Duplicata
                                      '',                                                                  // Fornecedor da Duplicata
                                      cdsAux.FieldByName('NUMDUP').AsString,                               // Número da Duplicata
                                      0,                                                                   // Sequencial de Baixa
                                      cdsAux.FieldByName('PARDUP').AsString,                               // Parcela da Duplicata
                                      cdsAux.FieldByName('CTR_CODEMP').AsString,                                                        // Empresa da Duplicata
                                      '',                                                                  // Serie
                                      cdsAux.FieldByName('CTR_CODEVE').AsString,                           // Codigo do Evento
                                      '',                                                                  // Documento da Baixa
                                      lstBanCtr.fGetList,                                                  // Log Bancário
                                      0,
                                      0,
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      1,
                                      False
                                     )) Then
            Begin
              FreeAndNil(lstBanCtr);
              Raise Exception.Create('Não foi possível gravar o movimento bancário!');
              Exit;
            End;

            FreeAndNil(lstBanCtr);

          End
          Else
          Begin
             //********* ESTORNO DA MOVBAN DE JUROS E DESCONTO LANÇADOS SEPARADOS DA DUPLICATA **********

             If fCfgSis('CTR_AS') = 'S' Then
                fEstornaMovbanJurosDesctoSintetico(cdsAux.FieldByName('AUTOINCREM').AsString,
                                                   cdsAux.FieldByName('CTR_PORBAI').AsString,
                                                   cdsAux.FieldByName('CTR_CTABAI').AsString, dtaEstorn)
             Else
                fEstornaMovbanJurosDescto(cdsAux.FieldByName('AUTOINCREM').AsString, dtaEstorn);

             pExcluiMovCtrEstornada(cdsAux.FieldByName('AUTOINCREM').AsString);
          End;

          LGravouMovBanEstorno := True;
        End;

        If cdsAux.FieldByName('CTR_TABELA').AsString = 'ADTCLI' Then
        Begin
          pEstornaAdiantamentoCliente(cdsAux);
          {******************************************************
          * Se a origem do adiantamento foi o Contas a Receber, *
          * gera o lançamento de estorno na MovBan              *
          *******************************************************}

          if cdsAux.FieldByName('CTR_ORIGEM').AsString = 'CTR' Then
          Begin
            If Not blnEstDtaDoc Then
              dtaEstorn := VS_Date
            Else
            Begin
              If Not cdsAux.FieldByName('CTR_DTABAN').IsNull Then
                 dtaEstorn := cdsAux.FieldByName('CTR_DTABAN').AsDateTime
              Else
                 dtaEstorn := IIF(cdsAux.FieldByName('CTR_DTAREC').IsNull, cdsAux.FieldByName('CTR_DTACAD').AsDateTime, cdsAux.FieldByName('CTR_DTAREC').AsDateTime);
            End;

            {*****************************************************}
            {* LIMPANDO A ORIGEM DO REGISTRO PRINCIPAL DA MOVBAN *}
            {*REQ*155872***************************************MO*}
            If cdsAux.FieldByName('CTR_SEQCON').AsInteger > 0 Then
            begin
              repMovBan := TMovBanRepository.Create;
              repMovBan.pLimparOrigemPrincipal(cdsAux.FieldByName('CTR_SEQCON').AsInteger, (cdsAux.FieldByName('CTR_RECPIX').AsString = 'S'));
              FreeAndNil(repMovBan);
            end;

            If Not LGravouMovBanEstorno Then
            Begin
              lstBanCtr := TBanCtrRepository.Create;
              lstBanCtr.fAdd(cdsAux.FieldByName('NUMDUP').AsString,
                             cdsAux.FieldByName('PARDUP').AsString,
                             cdsAux.FieldByName('CTR_ESPDOC').AsString,
                             cdsAux.FieldByName('CTR_EMPBAI').AsString,
                             cdsAux.FieldByName('CTR_CODCLI').AsString,
                             cdsAux.FieldByName('CTR_HIST01').AsString,
                             cdsAux.FieldByName('CTR_HIST02').AsString,
                             cdsAux.FieldByName('CTR_SEQBAI').AsInteger,
                             fltValLan,
                             0,
                             0,
                             0,
                             'S');

              If fEmptyStr(fGravaMovBan(cdsAux.FieldByName('CTR_CTABAI').AsString,                           // Centro de Custo
                                        strPorBai,                                                           // Portador da Baixa
                                        strLoginUsuarioLogado,                                               // Operador da Baixa
                                        dtaEstorn,                                                           // Data do Lançamento
                                        fTime(),                                                             // Hora do Lançamento
                                        cdsAux.FieldByName('CTR_NUMDUP').AsString,                           // Numero do Documento
                                        strCreDeb,                                                           // Credito / Debito
                                        cdsAux.FieldByName('CTR_EMPBAI').AsString,                           // Empresa da Baixa
                                        fltValLan,                                                           // Valor Do Lançamento
                                        'ESTORNO DA DUPLICATA ' + cdsAux.FieldByName('CTR_NUMDUP').AsString, // Histórico 1
                                        '',                                                                  // Histórico 2
                                        cdsAux.FieldByName('CTR_CODCLI').AsString,                           // Cliente da Duplicata
                                        '',                                                                  // Fornecedor da Duplicata
                                        cdsAux.FieldByName('NUMDUP').AsString,                               // Número da Duplicata
                                        0,                                                                   // Sequencial de Baixa
                                        cdsAux.FieldByName('PARDUP').AsString,                               // Parcela da Duplicata
                                        cdsAux.FieldByName('CTR_CODEMP').AsString,                                                        // Empresa da Duplicata
                                        '',                                                                  // Serie
                                        cdsAux.FieldByName('CTR_CODEVE').AsString,                           // Codigo do Evento
                                        '',                                                                  // Documento da Baixa
                                        lstBanCtr.fGetList,                                                  // Log Bancário
                                        0,
                                        0,
                                        '',
                                        '',
                                        '',
                                        '',
                                        '',
                                        '',
                                        1,
                                        False
                                       )) Then
              Begin
                FreeAndNil(lstBanCtr);
                Raise Exception.Create('Não foi possível gravar o movimento bancário!');
                Exit;
              End;

              FreeAndNil(lstBanCtr);
            End;
          End;
        End

        Else If (cdsAux.FieldByName('CTR_SEQBAI').AsInteger = 0) And
                (cdsAux.FieldByName('CTR_SEQCON').AsInteger > 0) And
                (cdsAux.FieldByName('CTR_ESPDOC').AsString = 'CC') And
                (Pos('CRÉDITO CONSIG', cdsAux.FieldByName('CTR_HIST01').AsString) > 0)Then
        Begin
          pEstornaDuplicataParcial(cdsAux);
        End

        Else If (cdsAux.FieldByName('CTR_SEQBAI').AsInteger = 0) Then
        begin
          pEstornaDuplicataSimples(cdsAux);
          {*********************************************}
          {* QUANDO FOR RECEBIMENTO COM TAXA BANCÁRIA, *}
          {* A DATA DO ESTORNO DA TAXA DEVE SER A MESMA*}
          {* DA CONTA ESTORNADA                        *}
          {******************************************AJ*}
          If Not blnEstDtaDoc Then
            dtaEstorn := VS_Date
          Else
            dtaEstorn := cdsAux.FieldByName('CTR_DTAREC').AsDateTime;

          If not fEmptyStr(cdsAux.FieldByName('CTR_AUTCTP').AsString) Then
            pEstornaContasAPagar(cdsAux.FieldByName('CTR_AUTCTP').AsString, dtaEstorn);

          If fVerificaDuplicatasReceberTarifaBancaria( cdsAux.FieldByName('AUTOINCREM').AsString ) Then
             pEstornaContasAReceberTarifa( cdsAux.FieldByName('AUTOINCREM').AsString, dtaEstorn);

          If untCadRec.DuplicataCreditoReferenteATroco(cdsAux.FieldByName('NUMDUP').AsString,
                                                       cdsAux.FieldByName('PARDUP').AsString,
                                                       cdsAux.FieldByName('CTR_ESPDOC').AsString,
                                                       cdsAux.FieldByName('CTR_CODEMP').AsString,
                                                       cdsAux.FieldByName('CTR_CODCLI').AsString,
                                                       cdsAux.FieldByName('CTR_SEQCON').AsInteger) Then
            untCadRec.fDeletaCadRec(cdsAux.FieldByName('AUTOINCREM').AsString,
                                    Self.Name,
                                    'EXCLUSÃO DE DUPLICATA TROCO');
        end
        Else
          pEstornaDuplicataParcial(cdsAux);

      End;

      If (intResCai = 0) And (cdsAux.fieldbyname('CTR_DTAREC').AsDateTime = 0) Then
        stlConjugadas.Add(cdsAux.FieldByName('AUTOINCREM').AsString);

      pRemoveLiberacaoDoctoParaExpedicaoAutomatico(cdsAux.FieldByName('NUMDUP').AsString,
                                                   cdsAux.FieldByName('CTR_ESPDOC').AsString,
                                                   cdsAux.FieldByName('CTR_CODEMP').AsString,
                                                   cdsAux.FieldByName('CTR_CODCLI').AsString,
                                                   cdsAux.FieldByName('PARDUP').AsString);

      if (cdsAux.FieldByName('CTR_TABELA').AsString = 'ADTCLI') and
         (cdsAux.FieldByName('CTR_CARTAO').AsFloat > 0) and
         (Pos('YAPAY', cdsAux.FieldByName('CTR_HIST01').AsString) > 0) then
      begin
        if not TYapayFacade.fPedidoPodeSerCancelado(cdsAux.FieldByName('NUMDUP').AsString, cdsAux.FieldByName('CTR_ESPDOC').AsString, cdsAux.FieldByName('CTR_CODEMP').AsString, strRetornoErro) then
          Raise ExceptionAutcom.Create(strRetornoErro);

        if (TYapayFacade.fAdiantamentoVinculadoCobrancaParaEstorno(cdsAux.FieldByName('AUTOINCREM').AsString)) then
        begin
          blnEstornouMovCarYapay := True;
          fEstornaMovCar(cdsAux.FieldByName('CTR_SEQCON').AsInteger,
                         cdsAux.FieldByName('CTR_EMPBAI').AsString,
                         cdsAux.FieldByName('CTR_DTABAI').AsDateTime);
        end;
      end;

      cdsAux.Next;
    End;

    blnResult := True;
    cdsAux.Filtered := False;
    cdsAux.Filter   := 'CTR_VALREC <> 0 AND CTR_MARDES = ' + QuotedStr('M');
    cdsAux.Filtered := True;

    If (intResCai = 1) And (dtaDtaRec = dtaDtaRcx) And (Not blnFechadoCaixa) And (cdsAux.FieldByName('CTR_ORIGEM').AsString <> 'CTR') Then
    Begin
      pDeterminaModEstornoRcx(cdsAux.FieldByName('CTR_SEQCON').AsInteger, cdsAux.FieldByName('CTR_EMPBAI').AsString,
                              dtaDtaRec, fltValDin, fltValCar, fltChqVis, fltChqPre, fltOrdRec, fltValFin,
                              fltValLan, fltTotGua, fltTotDol, fltTotEur, fltTotPes, fltTotRea, LRecebidoPorPix);

      strCreDeb := RetornaTipoMovimentacaoBancaria(fltValLan);

      {****************************************************************************}
      {* QUANDO O CLIENTE PAGAVA UMA DUPLICATA UTILIZANDO UM CREDITO O VALOR DO   *}
      {* LANCAMENTO É IGUAL À ZERO, PORTANTO NAO DEVE LANCAR UM LC COM VALOR ZERO *}
      {* EXEMPLO: NF 10 NO VALOR DE 50,00 REAIS, NO CAIXA É FEITO O RECEBIMENTO   *}
      {*          DA MESMA UTILIZANDO UM CREDITO DE EXATAMENTE 50,00 REAIS        *}
      {*************************************************************************JC*}

      If (fFormataFloat(fltValLan,2) <> 0.0) Then
      Begin
        LOperadorCaixa := EmptyStr;
        If cdsAux.Locate('CTR_ESPDOC', 'PD', []) Then
          LOperadorCaixa := objResumoDeCaixa.fRetornaDadosLancamentosCaixaSeqCon(cdsAux.FieldByName('CTR_SEQCON').AsString,
                                                                                 cdsAux.FieldByName('CTR_EMPBAI').AsString,
                                                                                 cdsAux.FieldByName('CTR_DTAREC').AsDateTime)
                                            .FieldByName('RCX_CODOPE').AsString;

        If LOperadorCaixa.IsEmpty Then
          LOperadorCaixa := IIF(Not fEmptyStr(cdsAux.FieldByName('CTR_OPEBAI').AsString),
                              cdsAux.FieldByName('CTR_OPEBAI').AsString,
                              strOpeBai);

        cdsAux.First;

        blnResult := fGravaCadRcx(strSeqRcx,
                                  IIF(cdsAux.RecordCount = 1, cdsAux.FieldByName('CTR_CODCLI').AsString, ''),        // Cliente
                                  LOperadorCaixa,                                                                    // Operador
                                  IIF(cdsAux.RecordCount = 1, cdsAux.FieldByName('CTR_NUMDUP').AsString, 'EST.CJ'),  // Documento
                                  IIF(strCreDeb = 'D', 'LD', 'LC'),                                                  // Espécie
                                  VS_strCodEmp,                                                                      // Empresa
                                  dtaDtaRcx,                                                                         // Data de Cadastro
                                  fTime(),                                                                           // Hora de Cadastro
                                  IIF(cdsAux.RecordCount = 1, cdsAux.FieldByName('NUMDUP').AsString, ''),            // Duplicata
                                  IIF(cdsAux.RecordCount = 1, cdsAux.FieldByName('PARDUP').AsString, ''),            // Parcela
                                  'REF. A ESTORNO. CTA. RECEBER',                                                    // Descrição
                                  '',                                                                                // Juros / Desconto
                                  '',                                                                                // Identificação de Fechamento
                                  '',                                                                                // Forma de Pagamento
                                  fltValLan * -1,                                                                    // Valor do Documento
                                  0.0,                                                                               // Valor do Desconto
                                  0.0,                                                                               // Valor do Juros
                                  fltValDin * -1,                                                                    // Dinheiro recebido
                                  fltChqVis * -1,                                                                    // Cheque a vista
                                  fltChqPre * -1,                                                                    // Cheque pre datado
                                  fltValCar * -1,                                                                    // Valor em Cartã
                                  fltOrdRec * -1,                                                                    // Valor em Ordem de Pagamento
                                  RetornaValorCreditoDaBaixa(cdsAux.FieldByName('CTR_SEQCON').AsInteger,
                                                             cdsAux.FieldByName('CTR_EMPBAI').AsString,
                                                             cdsAux.FieldByName('CTR_DTAREC').AsDateTime) * -1,      // Valor do Crédito
                                  fltValFin * -1,                                                                    // Valor em Financiamento
                                  0.0,                                                                               // Valor de outros
                                  0.0,                                                                               // Venda a prazo
                                  '',                                                                                // Num. do Romaneio
                                  StrToInt(fRetRcxCon),                                                              // Sequencial de Controle
                                  IIF(cdsAux.RecordCount = 1, cdsAux.FieldByName('CTR_SEQBAI').AsInteger, 0),        // Sequencial de Baixa (Duplicata)
                                  fCfgSisL('SQFCRX'),                                                                // Sequencial de Fechamento parcial de caixa
                                  IIF(cdsAux.RecordCount = 1, cdsAux.FieldByName('CTR_CODEMP').AsString, ''),        // Empresa da duplicata
                                  '',                                                                                // MotDes
                                  1,                                                                                 // Identificação do Caixa
                                  fltTotGua * -1,
                                  fltTotDol * -1,
                                  fltTotEur * -1,
                                  fltTotPes * -1,
                                  fltTotRea * -1,
                                  'N',
                                  strMotEst,
                                  strCodigoCaixa,
                                  '',
                                  0.00,
                                  False,
                                  0.00,
                                  '',
                                  0,
                                  LRecebidoPorPix);
      End
      Else
        LacarEstornoAnalíticoCaixaLancamentoZerado(cdsAux.FieldByName('CTR_SEQCON').AsInteger,
                                                   cdsAux.FieldByName('CTR_EMPBAI').AsString,
                                                   cdsAux.FieldByName('CTR_DTAREC').AsDateTime);
    End;

    If blnResult Then
    Begin
      If (intResCai = 1) And (dtaDtaRec = dtaDtaRcx) Then
      Begin
        LOperadorCaixa := EmptyStr;
        If cdsAux.Locate('CTR_ESPDOC', 'PD', []) Then
          LOperadorCaixa := objResumoDeCaixa.fRetornaDadosLancamentosCaixaSeqCon(cdsAux.FieldByName('CTR_SEQCON').AsString,
                                                                                 cdsAux.FieldByName('CTR_EMPBAI').AsString,
                                                                                 cdsAux.FieldByName('CTR_DTAREC').AsDateTime)
                                            .FieldByName('RCX_CODOPE').AsString;

        If LOperadorCaixa.IsEmpty Then
          LOperadorCaixa := IIF(Not fEmptyStr(cdsAux.FieldByName('CTR_OPEBAI').AsString),
                              cdsAux.FieldByName('CTR_OPEBAI').AsString,
                              strOpeBai);

        pRealizaLCDocumentosTransferidos(cdsAux.FieldByName('CTR_SEQCON').AsInteger, cdsAux.FieldByName('CTR_EMPBAI').AsString, dtaDtaRec, LOperadorCaixa);
      End;

      if not blnEstornouMovCarYapay then
        pApagaChequeCartao(cdsAux.FieldByName('CTR_SEQCON').AsString, cdsAux.FieldByName('CTR_EMPBAI').AsString, cdsAux.FieldByName('CTR_DTABAI').AsDateTime, fltValCar, fltChqVis, fltChqPre, fltValFin);

      If FRecebidoPorPix = 'S' Then
      Begin
        ApagaRegistroPix(cdsAux.FieldByName('CTR_SEQCON').AsInteger,
                         cdsAux.FieldByName('CTR_EMPBAI').AsString,
                         dtaDtaRec);

        pGeraLogLiberacao(edtNumDup.Text,
                          edtEspDoc.Text,
                          edtCodEmp.Text);
      End;

      fCommit;

      Result := True;

      If FGerarCreditoDevolucaoPix Then
      Begin
        If Not FGerouCreditoPix Then
          fMensagem('ATENÇÃO', 'Foi selecionado para gerar um Crédito referente ao recebimento do Pix, porém ' +
                               'a devolução do valor já tinha sido feita na conta do cliente.' + #13 +
                               'O crédito de cliente não foi gerado.', ['&Ok']);
      End;

      If Not fEmptyStr(strDocsNaoEnc) Then
        fMensagem('ATENÇÃO!', 'Não foram encontrados os ' + strDocsNaoEnc + '. Favor verificar.', ['&Ok']);

      If (intResCai = 0) And (stlConjugadas.Count > 1) Then
      Begin
        If fMensagem('', 'Deseja baixar as duplicatas novamente?', ['&Sim', '&Não'], 2) = 1 Then
        Begin
          pCriarFormularios(TfrmBaixaReceber, frmBaixaReceber);
          frmBaixaReceber.stlConjugadas := stlConjugadas;
          frmBaixaReceber.ShowModal;
          pFreeAndNil(frmBaixaReceber);
        End;
      End;

      If (Not blnEstornoAutomatico) Then
      Begin
        pMensagemOk('Duplicata(s) estornada(s) com sucesso!');

        If FSolicitarDevolucaoPix Then
          fMensagem('ATENÇÃO', 'O valor de ' + FormatFloat(',0.00', FRegistroMovPix.FieldByName('MPX_VALREC').AsFloat) +
                               ' foi devolvido por Pix ao cliente.', ['&Ok']);
      End;
    End
    Else
      fRollBack;

  Except
    On E: ExceptionAutCom Do
    Begin
      Result := False;
      fRollBack;

      If FSolicitarDevolucaoPix Then
      Begin
        If TFuncoesPixAutcom.ErroGeradoPelaDevolucaoDoPix(E.Message,
                                                          fRetornaStack,
                                                          FRegistroMovPix.FieldByName('AUTOINCREM').AsString,
                                                          Self.Name,
                                                          IIF(strCodOpe.IsEmpty, strLoginUsuarioLogado, strCodOpe)) Then
        Begin
          fStartTransaction;
          pGeraLogLiberacao(edtNumDup.Text,
                            edtEspDoc.Text,
                            edtCodEmp.Text);
          fCommit;

          FreeAndNil(cdsAux);
          FreeAndNil(stlConjugadas);
          Exit;
        End;
      End;

      if (blnEstornoAutomatico) and (Assigned(FobjFulFillmentLogBuilder)) then
        pEmitirMensagem('','Erro ao tentar estornar duplicatas:'+ E.Message, True, False, True)
      else
        pMensagemSonora(E.Message);
    End;

    On E: Exception Do
    Begin
      Result := False;
      fRollBack;

      if (blnEstornoAutomatico) and (Assigned(FobjFulFillmentLogBuilder)) then
        pEmitirMensagem('','Erro ao tentar estornar duplicatas:'+ E.Message, True, False, True)
      else
        pMensagensErro('Erro ao tentar estornar duplicatas:' + #13 + E.Message, '[pEstornaDuplicataConjug]');
    End;
  End;

  FreeAndNil(cdsAux);
  FreeAndNil(stlConjugadas);
end;

function TfrmEstornoReceber.fVerificaDuplicatasReceberTarifaBancaria( strAutInc : String ) : Boolean;
  Var
    qryGen    : TUniQuery;
    strSQL    : String;
Begin

  Try

    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_TARDUP = :AUTOIN ';

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ParamByName('AUTOIN').AsString   := strAutInc;
    qryGen.Open;
    Result := (qryGen.FieldByName('QTD').AsInteger > 0);
    qryGen.Close;

    FreeAndNil(qryGen);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

End;

Procedure TfrmEstornoReceber.pEstornaContasAReceberTarifa( strAutInc : String; dtaEstorn: TDate);
  Var
    strSQL: String;
    qryGen: TUniQuery;

    lstBanCtr    : TBanCtrRepository;

Begin

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE * FROM ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_TARDUP = :AUTOIN ';

    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTOIN').AsString := strAutInc;
      Open;

      first;

      While Not Eof Do
      Begin

        If Not fEmptyStr(qryGen.FieldByName('CTR_DTAREC').AsString) and (qryGen.FieldByName('CTR_VALREC').AsFloat > 0) Then
        Begin

          lstBanCtr := TBanCtrRepository.Create;
          lstBanCtr.fAdd(qryGen.FieldByName('CTR_NUMDUP').AsString,
                         qryGen.FieldByName('CTR_PARCEL').AsString,
                         qryGen.FieldByName('CTR_ESPDOC').AsString,
                         qryGen.FieldByName('CTR_EMPBAI').AsString,
                         qryGen.FieldByName('CTR_CODCLI').AsString,
                         qryGen.FieldByName('CTR_HIST01').AsString,
                         qryGen.FieldByName('CTR_HIST02').AsString,
                         qryGen.FieldByName('CTR_SEQBAI').AsInteger,
                         qryGen.FieldByName('CTR_VALREC').AsFloat,
                         0,
                         0,
                         0,
                         'S');

          If fEmptyStr(fGravaMovBan(qryGen.FieldByName('CTR_CTABAI').AsString,                           // Centro de Custo
                                    qryGen.FieldByName('CTR_PORBAI').AsString,                                                           // Portador da Baixa
                                    strLoginUsuarioLogado,                                               // Operador da Baixa
                                    dtaEstorn,                                                           // Data do Lançamento
                                    fTime(),                                                             // Hora do Lançamento
                                    qryGen.FieldByName('CTR_NUMDUP').AsString,                           // Numero do Documento
                                    'D',                                                                 // Credito / Debito
                                    qryGen.FieldByName('CTR_EMPBAI').AsString,                           // Empresa da Baixa
                                    qryGen.FieldByName('CTR_VALREC').AsFloat,                            // Valor Do Lançamento
                                    'ESTORNO DA DUPLICATA ' + qryGen.FieldByName('CTR_NUMDUP').AsString, // Histórico 1
                                    '',                                                                  // Histórico 2
                                    qryGen.FieldByName('CTR_CODCLI').AsString,                           // Cliente da Duplicata
                                    '',                                                                  // Fornecedor da Duplicata
                                    qryGen.FieldByName('CTR_NUMDUP').AsString,                           // Número da Duplicata
                                    0,                                                                   // Sequencial de Baixa
                                    qryGen.FieldByName('CTR_PARCEL').AsString,                           // Parcela da Duplicata
                                    qryGen.FieldByName('CTR_CODEMP').AsString,                                                        // Empresa da Duplicata
                                    '',                                                                  // Serie
                                    qryGen.FieldByName('CTR_CODEVE').AsString,                           // Codigo do Evento
                                    '',                                                                  // Documento da Baixa
                                    lstBanCtr.fGetList,                                                  // Log Bancário
                                    0,
                                    0,
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    1,
                                    False
                                   )) Then
          Begin
            FreeAndNil(lstBanCtr);
            Raise Exception.Create('Não foi possível gravar o movimento bancário!');
            Exit;
          End;
          FreeAndNil(lstBanCtr);

        End;

        fApagaDuplicataContasReceber(qryGen, Self.Name, 'EXCLUSÃO', False, True);
        Next;

      End;

      Close;
    End;

    FreeAndNil(qryGen);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

End;

function TfrmEstornoReceber.fEstornaCheque(intSeqCon: Integer; strEmpRcx, strTipChq: String; dtaDtaRec: TDateTime): Boolean;
  Var
    qryGen    : TUniQuery;
    strSQL    : String;
    strSQLDel : String;
    blnTemChq : Boolean;

    function fChequeExiste: Boolean;
    begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  COUNT(*) AS QTD ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADCHQ ';
      strSQL := strSQL + 'WHERE                       ';
      strSQL := strSQL + '   CHQ_SEQCON = :SEQCON AND ';
      strSQL := strSQL + '   CHQ_EMPRCX = :EMPRCX AND ';
      strSQL := strSQL + '   CHQ_DTACAD = :DTACAD AND ';
      strSQL := strSQL + '   CHQ_DTACAD ' + IIF(strTipChq = 'AVI', '=', '<') + ' CHQ_DTAVEN ';

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);
      qryGen.ParamByName('SEQCON').AsInteger  := intSeqCon;
      qryGen.ParamByName('EMPRCX').AsString   := strEmpRcx;
      qryGen.ParamByName('DTACAD').AsDateTime := dtaDtaRec;
      qryGen.Open;
      Result := (qryGen.FieldByName('QTD').AsInteger > 0);
      qryGen.Close;
    end;
Begin

  Try
    Result := True;

    If intSeqCon <= 0 Then
    Begin

      If Not fEmptyStr(strDocsNaoEnc) Then
        strDocsNaoEnc := strDocsNaoEnc + ' e/ou ';

      strDocsNaoEnc := strDocsNaoEnc + 'Cheques a ' + IIF(strTipChq = 'AVI', 'Vista', 'Prazo');
      Exit;
    End;

    blnTemChq := False;

    qryGen := fCriaQuery;

    strSQLDel := '';
    strSQLDel := strSQLDel +  ' DELETE FROM         ';
    strSQLDel := strSQLDel +  '  CADCHQ ';
    strSQLDel := strSQLDel +  ' WHERE                      ';
    strSQLDel := strSQLDel +  '   CHQ_SEQCON = :SEQCON AND ';
    strSQLDel := strSQLDel +  '   CHQ_EMPRCX = :EMPRCX AND ';
    strSQLDel := strSQLDel +  '   CHQ_DTACAD = :DTACAD AND ';
    strSQLDel := strSQLDel +  '   CHQ_DTACAD ' + IIF(strTipChq = 'AVI', '=', '<') + ' CHQ_DTAVEN ';

    If fChequeExiste Then
    Begin
      strSQL := '';
      strSQL := strSQL +  ' SELECT * FROM         ';
      strSQL := strSQL +  '  CADCHQ ';
      strSQL := strSQL +  ' WHERE                      ';
      strSQL := strSQL +  '   CHQ_SEQCON = :SEQCON AND ';
      strSQL := strSQL +  '   CHQ_EMPRCX = :EMPRCX AND ';
      strSQL := strSQL +  '   CHQ_DTACAD = :DTACAD AND ';
      strSQL := strSQL +  '   CHQ_DTACAD ' + IIF(strTipChq = 'AVI', '=', '<') + ' CHQ_DTAVEN ';

      blnTemChq := True;
      With qryGen, SQL Do
      Begin
        Close;
        Clear;
        Add(strSQL);
        ParamByName('SEQCON').AsInteger  := intSeqCon;
        ParamByName('EMPRCX').AsString   := strEmpRcx;
        ParamByName('DTACAD').AsDateTime := dtaDtaRec;
        Open;
      End;

      While Not qryGen.Eof Do
      Begin
        pLogChq(qryGen);
        qryGen.Next;
      End;
      qryGen.First;

      fVerificaIntegridade(Self.Name, 'CADCHQ', qryGen);

      With qryGen, Sql Do
      Begin
        Close;
        Clear;
        Add(strSQLDel);
        ParamByName('SEQCON').AsInteger  := intSeqCon;
        ParamByName('EMPRCX').AsString   := strEmpRcx;
        ParamByName('DTACAD').AsDateTime := dtaDtaRec;
        ExecSQL;
        Close;
      End;
    End;

    If (Not blnTemChq) Then
    Begin
      If Not fEmptyStr(strDocsNaoEnc) Then
        strDocsNaoEnc := strDocsNaoEnc + ' e/ou ';

      strDocsNaoEnc := strDocsNaoEnc + 'Cheques a ' + IIF(strTipChq = 'AVI', 'Vista', 'Prazo');
    End;

    FreeAndNil(qryGen);
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

{***************************************************************}
{* ESTA FUNÇÃO VERIFICA SE EXISTEM CONTAS BAIXADAS COM O MESMO *}
{* (CTR_SEQCON + CTR_EMPBAI) COM DATAS DIFERENTES. SE HOUVER,  *}
{* NÃO DEIXA ESTORNAR A DUPLICATA E EXIBE MENSAGEM.            *}
{************************************************************RV*}
function TfrmEstornoReceber.fVerificaDatasDiferentes(ACliente: TStringList; intSeqCon: Integer; strEmpRcx: String; dtaDtaBai: TDateTime): Boolean;
  Var
    strSql: String;
    qryAux: TUniQuery;
    AInd: Integer;
begin
  Result := True;

  If (StrToIntDef(strSeqCon, 0) <= 0) Then
  Begin
    Result := True;
    Exit;
  End;

  For AInd := 0 To ACliente.Count-1 Do
  begin
    strSql := '';
    strSql := strSql + ' SELECT  ';
    strSql := strSql + '   CTR_DTABAI ';
    strSql := strSql + ' FROM ';
    strSql := strSql + '   CADREC ';
    strSql := strSql + ' WHERE ';
    strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
    strSql := strSql + '   CTR_EMPBAI = :EMPBAI AND ';
    strSql := strSql + '   CTR_SEQCON = :SEQCON ';

    strSql := strSql + ' UNION ALL ';

    strSql := strSql + ' SELECT ';
    strSql := strSql + '   ADT_DTALAN AS CTR_DTABAI ';
    strSql := strSql + ' FROM ';
    strSql := strSql + '   ADTCLI ';
    strSql := strSql + ' WHERE ';
    strSQL := strSQL + '   ADT_CODCLI = :CODCLI AND ';
    strSql := strSql + '   ADT_EMPLAN = :EMPBAI AND ';
    strSql := strSql + '   ADT_SEQCON = :SEQCON ';

    strSql := ' SELECT SQL_NO_CACHE ' +
              '   COUNT(DISTINCT CTR_DTABAI) AS QTD ' +
              ' FROM ' +
              '   (' + strSql + ') T ';

    qryAux := fCriaQuery(Self);

    With qryAux, SQL Do
    Begin
      Clear;
      Add(strSql);
      ParamByName('CODCLI').AsString   := ACliente[AInd];
      ParamByName('EMPBAI').AsString   := strEmpRcx;
      ParamByName('SEQCON').AsInteger  := intSeqCon;
      Open;

      Result := (qryAux.FieldByName('QTD').AsInteger = 1);

      If Not Result Then
      Begin
        pEmitirMensagem('','Não é possível estornar esta Duplicata!' + #13 +
                        'Entre em contato com a Citel Software pois existem' + #13 +
                        'configurações a serem feitas antes da realização do estorno!' +#13 + #13 +
                        'Código: ' + IntToStr(intSeqCon) + '-' + strEmpRcx + '-' + FormatDateTime('dd/mm/yyyy',dtaDtaBai), True);
        Exit;
    End;
    End;
  End;

  FreeAndNil(qryAux);
end;

function TfrmEstornoReceber.fVerificaDocumentosBaixados(intSeqCon: Integer; strEmpRcx: String; dtaDtaCad: TDateTime;
                                                        ANumDup,AParcel,AEspDoc,ACodEmp,ACodCli,AAdtCli: String): Boolean;
  var
    LQuery : TUniQuery;
    LDadosDaBaixaContasReceber : TDadosDaBaixaContasReceber;
begin

  Result := False;

  If StrToIntDef(strSeqCon, 0) <= 0 Then
  Begin
    Result := True;
    Exit;
  End;

  LDadosDaBaixaContasReceber := untCadRec.RetornaDadosDaBaixa(ANumDup,AParcel,AEspDoc,
                                                              ACodEmp,ACodCli,AAdtCli,
                                                              strEmpRcx,intSeqCon);


  if (blnEstornoAutomatico) and (Assigned(FobjFulFillmentLogBuilder)) then
  Begin
    LQuery := fCriaQuery(Self);
    LQuery.SQL.Clear;
    LQuery.SQL.Add('SELECT SUM(A.QTD_REGISTRO) QTD_REGISTRO FROM '+
                   '(SELECT COUNT(*) QTD_REGISTRO '+
                   '   FROM MOVCAR '+
                   '  WHERE MCA_SEQCON = :SEQCON   AND '+
                   '        MCA_EMPRCX = :EMPRCX   AND '+
                   '        MCA_DTACAD = :DTACAD   AND '+
                   '        MCA_DTAREC IS NOT NULL AND '+
                   '        MCA_VALREC <> 0            '+
                   ' UNION ALL '+
                   '  SELECT COUNT(*) QTD_REGISTRO '+
                   '    FROM CADCHQ '+
                   '   WHERE CHQ_SEQCON = :SEQCON AND '+
                   '         CHQ_EMPRCX = :EMPRCX AND '+
                   '         CHQ_DTACAD = :DTACAD AND '+
                   '         CHQ_DTADEP IS NOT NULL) A ');
    LQuery.ParamByName('SEQCON').AsInteger  := LDadosDaBaixaContasReceber.FSeqCon;
    LQuery.ParamByName('EMPRCX').AsString   := LDadosDaBaixaContasReceber.FEmpBai;
    LQuery.ParamByName('DTACAD').AsDateTime := dtaDtaCad;
    LQuery.Open;
    if LQuery.FieldByName('QTD_REGISTRO').AsInteger > 0 then
    Begin
      Result := False;
      pEmitirMensagem('','Há cartões baixados, portanto não é permitido estornar. ' +
                         'Acesse o menu PRINCIPAL > CONTROLE FINANCEIRO > CONTROLE DE CARTÕES > ESTORNO DE CARTÕES '+
                         'e depois coloque o documento para reprocessar no painel do FULFILLMENT.', True)
    End
    Else
      Result := True;
    LQuery.Close;

    freeAndNil(LQuery);

    Exit;
  End
  Else
  Begin
    If Assigned(prcExecutaRelatorio) Then
    begin
      Result := not fncExecutaRelatorio(180, 7438, [7439],
                        ['SEQCON','EMPRCX','DTACAD'],
                        [IntToStr(LDadosDaBaixaContasReceber.FSeqCon),
                        LDadosDaBaixaContasReceber.FEmpBai,
                        DateToStr(dtaDtaCad)],
                        nil,
                        nil,
                        True,
                        False);
    End;
  End;

end;

procedure TfrmEstornoReceber.pApagaChequeCartao(strSeqCon, strEmpRcx: String; dtaDtaRec: TDateTime;
  fltValCar, fltChqVis, fltChqPre, fltValFin: Double);
begin
  Try
    If fFormataFloat(fltValCar, 2) > 0 Then
      fEstornaMovCar(StrToIntDef(strSeqCon, Default(Integer)), strEmpRcx, dtaDtaRec);

    If fFormataFloat(fltValFin, 2) > 0 Then
      fEstornaMovCar(StrToInt(strSeqCon), strEmpRcx, dtaDtaRec);

    If fFormataFloat(fltChqVis, 2) > 0 Then
      fEstornaCheque(StrToInt(strSeqCon), strEmpRcx, 'AVI', dtaDtaRec);

    If fFormataFloat(fltChqPre, 2) > 0 Then
      fEstornaCheque(StrToInt(strSeqCon), strEmpRcx, 'PRZ', dtaDtaRec);
  Except
    Raise;
  End;
end;

procedure TfrmEstornoReceber.FormShow(Sender: TObject);
begin
  inherited;
  pFormShow;
end;

procedure TfrmEstornoReceber.pEstornarLancamentoCreditoCaixa(strNumDup, strParcel, strCodEmp, strEspDoc, strCodCli, strPorBaiSelecionado: String; intSeqBai: Integer; oleDados: OleVariant; dtaEstorn, dtaDtaRec: TDate);
  Var
    cdsAux   : TUniClientDataSet;
    qryAux,
    qryRes   : TUniQuery;
    strSQL   : String;
    strPorBaiEstorno: String;
    strCtaBaiEstorno: String;
    lstBanCtr: TBanCtrRepository;

    function pDefinePortadorParaCredito: String;
    begin
      strPorBaiEstorno := '';
      strCtaBaiEstorno := '';

      cdsAux.First;
      While (Not cdsAux.Eof) Do
      Begin
        If cdsAux.FieldByName('CTR_ESPDOC').AsString <> 'CC' Then
        Begin
          strPorBaiEstorno := IIF(Not fEmptyStr(cdsAux.FieldByName('CTR_PORBAI').AsString),
                              cdsAux.FieldByName('CTR_PORBAI').AsString, strPorBaiSelecionado);
          strCtaBaiEstorno := cdsAux.FieldByName('CTR_CTABAI').AsString;
          Break;
        End;

        //isso foi feito para quando o operador baixa um CC positivo, gerando um CC negativo
        //e depois tenta estornar
        If cdsAux.FieldByName('CTR_ESPDOC').AsString.Contains('CC') Then
        Begin
          If fFormataFloat(cdsAux.FieldByName('CTR_VALORI').AsFloat, 2) > 0 Then
          Begin
            strPorBaiEstorno := IIF(Not fEmptyStr(cdsAux.FieldByName('CTR_PORBAI').AsString),
                                cdsAux.FieldByName('CTR_PORBAI').AsString, strPorBaiSelecionado);
            strCtaBaiEstorno := cdsAux.FieldByName('CTR_CTABAI').AsString;
          End;
        End;

        cdsAux.Next;
      End;

    End;
begin
  Try
    cdsAux := TUniClientDataSet.Create(Self);
    cdsAux.Data := oleDados;

    qryAux := fCriaQuery(Self);
    qryRes := fCriaQuery(Self);

    {**********************************************}
    {* DESCOBRIR SE ESSE CC FOI GERADO PELO CAIXA *}
    {*******************************************AJ*}
    strSQL := 'SELECT COALESCE(L.CTR_RESCAI, 0) AS LOG_RESCAI, ';
    strSQL := strSQL + ' CAST((SELECT CTR_DTAREC FROM CADREC WHERE CTR_SEQCON=L.CTR_SEQCON AND ';
    strSQL := strSQL + ' CTR_CODEMP = L.CTR_CODEMP AND CTR_CODCLI = L.CTR_CODCLI AND ';
    strSQL := strSQL + ' CTR_DTAREC IS NOT NULL LIMIT 1) AS DATE) AS DTAREC ';
    strSQL := strSQL + ' FROM LOGCTR L WHERE ';
    strSQL := strSQL + ' L.CTR_NUMDUP = :NUMDUP AND L.CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + ' L.CTR_CODEMP = :CODEMP AND L.CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + ' L.CTR_CODCLI = :CODCLI AND L.CTR_SEQBAI = :SEQBAI ';
    strSQL := strSQL + ' ORDER BY L.AUTOINCREM LIMIT 1';
    With qryRes do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString  := strNumDup;
      ParamByName('PARCEL').AsString  := strParcel;
      ParamByName('CODEMP').AsString  := strCodEmp;
      ParamByName('ESPDOC').AsString  := strEspDoc;
      ParamByName('CODCLI').AsString  := strCodCli;
      ParamByName('SEQBAI').AsInteger := intSeqBai;
      Open;
    End;

    strSQL := 'SELECT * FROM CADREC WHERE ';
    strSQL := strSQL + ' CTR_NUMDUP = :NUMDUP AND CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + ' CTR_CODEMP = :CODEMP AND CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + ' CTR_CODCLI = :CODCLI AND CTR_SEQBAI = :SEQBAI ';

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('NUMDUP').AsString  := strNumDup;
    qryAux.ParamByName('PARCEL').AsString  := strParcel;
    qryAux.ParamByName('CODEMP').AsString  := strCodEmp;
    qryAux.ParamByName('ESPDOC').AsString  := strEspDoc;
    qryAux.ParamByName('CODCLI').AsString  := strCodCli;
    qryAux.ParamByName('SEQBAI').AsInteger := intSeqBai;
    qryAux.Open;

    fVerificaIntegridade(Self.Name, 'CADREC', qryAux, True, False, 'ESTORNO DE CRÉDITO CONJUGADO');
    pDefinePortadorParaCredito; // essa função tem que ficar aqui antes do if abaixo

    {******************************************}
    {* GRAVA O MOVBAN DO CC GERADO PELA BAIXA *}
    {***************************************AJ*}
    dtaDtaRec := qryRes.FieldByName('DTAREC').AsDateTime;
    If DeveGravarMovimentacaoBancariaDoEstornoDeCreditoDoCaixa(qryRes.FieldByName('LOG_RESCAI').AsString,
                                                               cdsAux.FieldByName('CTR_SEQCON').AsInteger,
                                                               cdsAux,
                                                               dtaDtaRec) Then
    Begin
      lstBanCtr := TBanCtrRepository.Create;
      lstBanCtr.fAdd(qryAux.FieldByName('CTR_NUMDUP').AsString,
                     qryAux.FieldByName('CTR_PARCEL').AsString,
                     qryAux.FieldByName('CTR_ESPDOC').AsString,
                     qryAux.FieldByName('CTR_CODEMP').AsString,
                     qryAux.FieldByName('CTR_CODCLI').AsString,
                     qryAux.FieldByName('CTR_HIST01').AsString,
                     qryAux.FieldByName('CTR_HIST02').AsString,
                     qryAux.FieldByName('CTR_SEQBAI').AsInteger,
                     qryAux.FieldByName('CTR_VALDUP').AsFloat,
                     qryAux.FieldByName('CTR_VALJUR').AsFloat,
                     qryAux.FieldByName('CTR_VALDES').AsFloat,
                     qryAux.FieldByName('CTR_VALANT').AsFloat,
                     'S');

      If fEmptyStr(fGravaMovBan(strCtaBaiEstorno,                               // Centro de Custo
                                strPorBaiEstorno,                               // Portador da Baixa
                                strLoginUsuarioLogado,                          // Operador da Baixa
                                dtaEstorn,                                      // Data do Lançamento
                                fTime(),                                        // Hora do Lançamento
                                qryAux.FieldByName('CTR_NUMDUP').AsString,      // Numero do Documento
                                'D',                                            // Credito / Debito
                                qryAux.FieldByName('CTR_CODEMP').AsString,      // Empresa da Baixa
                                -qryAux.FieldByName('CTR_VALDUP').AsFloat,      // Valor Do Lançamento
                                'ESTORNO DO CRÉDITO ' + qryAux.FieldByName('CTR_NUMDUP').AsString +
                                qryAux.FieldByName('CTR_PARCEL').AsString,      // Histórico 1
                                '',                                             // Histórico 2
                                qryAux.FieldByName('CTR_CODCLI').AsString,      // Cliente da Duplicata
                                '',                                             // Fornecedor da Duplicata
                                qryAux.FieldByName('CTR_NUMDUP').AsString,      // Número da Duplicata
                                0,                                              // Sequencial de Baixa
                                qryAux.FieldByName('CTR_PARCEL').AsString,      // Parcela da Duplicata
                                qryAux.FieldByName('CTR_CODEMP').AsString,                                     // Empresa da Duplicata
                                '',                                             // Serie
                                qryAux.FieldByName('CTR_CODEVE').AsString,      // Codigo do Evento
                                '',                                             // Documento da Baixa
                                lstBanCtr.fGetList                              // Log Bancário
                               )) Then
      Begin
        Raise Exception.Create('Não foi possível gravar o movimento bancário!');
      End;
    End;

    {****************}
    {* GRAVA LOGCTR *}
    {*************JS*}
    untLogCtr.GravaLogCtr(strNumDup,
                          strEspDoc,
                          strCodCli,
                          strCodEmp,
                          strParcel,
                          intSeqBai,
                          'ESTORNO', Self.Name + IIF(blnResCai, 'RESCAI',''),
                          objLiberacao.strOperador,
                          LHistComplementar);

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('DELETE FROM CADREC WHERE ');
    qryAux.SQL.Add('  CTR_NUMDUP = :NUMDUP AND CTR_PARCEL = :PARCEL AND ');
    qryAux.SQL.Add('  CTR_CODEMP = :CODEMP AND CTR_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  CTR_CODCLI = :CODCLI AND CTR_SEQBAI = :SEQBAI ');

    qryAux.ParamByName('NUMDUP').AsString  := strNumDup;
    qryAux.ParamByName('PARCEL').AsString  := strParcel;
    qryAux.ParamByName('CODEMP').AsString  := strCodEmp;
    qryAux.ParamByName('ESPDOC').AsString  := strEspDoc;
    qryAux.ParamByName('CODCLI').AsString  := strCodCli;
    qryAux.ParamByName('SEQBAI').AsInteger := intSeqBai;
    qryAux.ExecSQL;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

  FreeAndNil(qryAux);
  FreeAndNil(cdsAux);
end;

procedure TfrmEstornoReceber.pFormShow;
  Var
    dtaDtaFec: TDateTime;
    fltSalFec: Double;
begin
  {*************************************}
  {* VERIFICA SE O CAIXA ESTÁ FECHADO  *}
  {**********************************AF*}
  If Not Assigned(objResumoDeCaixa) Then
    objResumoDeCaixa := TResumoDeCaixa.Create;

  LCaixaDoDiaFechado := False;
  If objResumoDeCaixa.strTipoFechamento <> 'C' Then
  Begin
    objResumoDeCaixa.fRetornaUltimoFechamento(fltSalFec, dtaDtaFec, strCodigoCaixa);
    LCaixaDoDiaFechado := (dtaDtaFec = VS_Date);
  End;

  If dtaDtaRcx <= 0 Then
    objResumoDeCaixa.fNecessitaFecharCaixa(False, dtaDtaRcx, strCodigoCaixa,False);

  If dtaDtaRcx <= 0 Then
    dtaDtaRcx := VS_Date;

  AClientesMarcados := TStringList.Create;
  AClientesMarcados.Duplicates := dupIgnore;

  FRealizarDevolucaoDoPix := fCfgSis('DEVPIX', varBoolean);

  If blnEstornoDocLocEqu Then
  Begin
    edtNumDup.Enabled := False;
    edtEspDoc.Enabled := False;
    edtParcel.Enabled := False;
    edtCodEmp.Enabled := False;
    edtCodCli.Enabled := False;

    strNumDoc := edtNumDup.Text;
    strEspDoc := edtEspDoc.Text;
    strCodCli := edtCodCli.Text;

    btnConsultar.Click;
    pSelecionaDuplicata;
  End;
end;

procedure TfrmEstornoReceber.pDeterminaModEstornoRcx(intSeqCon: Integer; strEmpBai: String; dtaDtaCad: TDateTime;
  Var fltValDin, fltValCar, fltChqVis, fltChqPre, fltOrdRec, fltValFin, fltValDoc, fltTotGua, fltTotDol,
      fltTotEur, fltTotPes, fltTotRea: Double; var ARecPix: String);
  Var
    qryAux: TUniQuery;
begin
  Try
    qryAux := fCriaQuery(Self);

    {***************************************}
    {* ACHA A DUPLICATA NO CAIXA           *}
    {************************************AF*}
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  SUM(IFNULL(RCX_VALDOC,0)) AS VALDOC, ');
    qryAux.SQL.Add('  SUM(IFNULL(RCX_DINREC,0)) AS DINREC, ');
    qryAux.SQL.Add('  SUM(IFNULL(RCX_CARREC,0)) AS CARREC, ');
    qryAux.SQL.Add('  SUM(IFNULL(RCX_CHQAVI,0)) AS CHQAVI, ');
    qryAux.SQL.Add('  SUM(IFNULL(RCX_CHQPRE,0)) AS CHQPRE, ');
    qryAux.SQL.Add('  SUM(IFNULL(RCX_ORDREC,0)) AS ORDREC, ');
    qryAux.SQL.Add('  SUM(IFNULL(RCX_VALFIN,0)) AS VALFIN, ');
    qryAux.SQL.Add('  SUM(IFNULL(RCX_TOTGUA,0)) AS TOTGUA, ');
    qryAux.SQL.Add('  SUM(IFNULL(RCX_TOTDOL,0)) AS TOTDOL, ');
    qryAux.SQL.Add('  SUM(IFNULL(RCX_TOTEUR,0)) AS TOTEUR, ');
    qryAux.SQL.Add('  SUM(IFNULL(RCX_TOTPES,0)) AS TOTPES, ');
    qryAux.SQL.Add('  SUM(IFNULL(RCX_TOTREA,0)) AS TOTREA, ');
    qryAux.SQL.Add('  SUM(IF(IFNULL(RCX_RECPIX,"N") = "N", 0, 1)) AS RECPIX  ');

    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  CADRCXX ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  RCX_SEQCON = :SEQCON AND ');
    qryAux.SQL.Add('  RCX_CODEMP = :EMPBAI AND ');
    qryAux.SQL.Add('  RCX_DTACAD = :DTACAD  ');
    //qryAux.SQL.Add('  (RCX_JURDES = "" OR RCX_JURDES IS NULL) ');

    qryAux.ParamByName('SEQCON').AsInteger  := intSeqCon;
    qryAux.ParamByName('EMPBAI').AsString   := strEmpBai;
    qryAux.ParamByName('DTACAD').AsDateTime := dtaDtaCad;

    qryAux.Open;

    fltValDoc := qryAux.FieldByName('VALDOC').AsFloat;
    fltValDin := qryAux.FieldByName('DINREC').AsFloat;
    fltValCar := qryAux.FieldByName('CARREC').AsFloat;
    fltChqVis := qryAux.FieldByName('CHQAVI').AsFloat;
    fltChqPre := qryAux.FieldByName('CHQPRE').AsFloat;
    fltOrdRec := qryAux.FieldByName('ORDREC').AsFloat;
    fltValFin := qryAux.FieldByName('VALFIN').AsFloat;

    fltTotGua := qryAux.FieldByName('TOTGUA').AsFloat;
    fltTotDol := qryAux.FieldByName('TOTDOL').AsFloat;
    fltTotEur := qryAux.FieldByName('TOTEUR').AsFloat;
    fltTotPes := qryAux.FieldByName('TOTPES').AsFloat;
    fltTotRea := qryAux.FieldByName('TOTREA').AsFloat;

    ARecPix := 'N';
    If qryAux.FieldByName('RECPIX').AsInteger > 0 Then
      ARecPix := 'S';

    qryAux.Close;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
  FreeAndNil(qryAux);
end;

function TfrmEstornoReceber.fAdtJaEstornado(strAutInc: String): Boolean;
begin
  Result := fCampoTabela('ADT_ESTORN', 'ADTCLI', ['AUTOINCREM'], [strAutInc]) = 'S';
  If Result Then
  Begin
    pEmitirMensagem('','Adiantamento do cliente já foi estornado em outra estação, carregue os dados novamente.');
  End;
end;

function TfrmEstornoReceber.fDupJaEstornada(strNumDup, strParcel, strSeqBai, strCodEmp, strEspDoc, strCodCli: String): Boolean;
  Var
    qryTab: TUniQuery;
    strSQL: String;
Begin
  Try
    qryTab := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   CTR_NUMDUP ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CTR_DTAREC IS NOT NULL AND ';
    strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '   CTR_SEQBAI = :SEQBAI AND ';
    strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   CTR_CODCLI = :CODCLI     ';

    With qryTab Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString   := strNumDup;
      ParamByName('PARCEL').AsString   := strParcel;
      ParamByName('SEQBAI').AsString   := strSeqBai;
      ParamByName('CODEMP').AsString   := strCodEmp;
      ParamByName('ESPDOC').AsString   := strEspDoc;
      ParamByName('CODCLI').AsString   := strCodCli;
      Open;

      If IsEmpty Then
      Begin
        pEmitirMensagem('','Duplicata: ' + strNumDup + strParcel + '-' + strEspDoc + '-' + strCodEmp +
                        ' encontra-se em aberto, possívelmente já foi estornado em outra estação, carregue os dados novamente.');
        Result := True;
      End
      Else
        Result := False;

      Close;
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

  FreeAndNil(qryTab);
End;

function TfrmEstornoReceber.fBloquearEstornoPedidoJaFaturado(strNumDoc, strEspDoc, strCodCli, strCodEmp: String): Boolean;
  Var
    strNumFat: String;

    fltSaldoAdiantamento: Double;
begin
  Result := False;

  If strEspDoc <> 'PD' Then
    Exit;

  if blnNotaDenegada then
    exit;

  strNumFat := fCampoTabela('CONCAT(FGO_NUMFAT,FGO_TIPFAT,FGO_EMPFAT)',
                            'FATGOR',
                           ['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP','FGO_CODCLI'],
                           [strNumDoc, strEspDoc, strCodEmp, strCodCli]);

  If strNumFat.IsEmpty Then
    Exit;

  If strNumFat = Concat(edtNumDup.Text, edtEspDoc.Text, edtCodEmp.Text) Then
    Exit;

  fltSaldoAdiantamento := fFormataFloat(TAdiantamento.fGetTotaisAdiantamento(strNumDoc, strEspDoc, strCodEmp).fltValLan, 2);
  If fltSaldoAdiantamento > 0 Then
    Exit;

  Result := True;
end;

function TfrmEstornoReceber.fBuscaDataEstornoSintetica(strNumDup : String = '';
                                                       strCodCli : String = '';
                                                       strCodEmp : String = '';
                                                       strParcel : String = '';
                                                       strEspDoc : String = ''): TDateTime;
Var qryBuscaData : TUniQuery;
          strSQL : String;
begin
  Result := 0;
  qryBuscaData := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + ' SELECT A.CTB_DTALAN FROM MOVBAN A ';
  strSQL := strSQL + ' WHERE A.CTB_SEQLAN IN (SELECT MAX(B.CTB_SEQLAN) FROM BANCTR B ';
  strSQL := strSQL + ' INNER JOIN MOVBAN C ON C.CTB_SEQLAN = B.CTB_SEQLAN'
  ;
  strSQL := strSQL + ' WHERE CTR_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '       CTR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '       CTR_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '       CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '       CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '       C.CTB_CREDEB = "C")      ';

  Try
    With qryBuscaData Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('PARCEL').AsString := strParcel;
      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('ESPDOC').AsString := strEspDoc;
      Open;

      If Not IsEmpty Then
        Result := FieldByName('CTB_DTALAN').AsDateTime;
    End;
  Finally
    FreeAndNil(qryBuscaData);
  End;
end;

{***************************************}
{* VERIFICA SE UM CRÉDITO GERADO FOI   *}
{* UTILIZADO EM OUTRA DUPLICATA OU ATÉ *}
{* MESMO RECEBIDO TOTALMENTE           *}
{************************************AF*}
function TfrmEstornoReceber.fCalculaFreteEstornaDuplicatasParcial(
  ACdsAux: TUniClientDataset): Double;
Var
  LValorFrete: Double;
begin
  LValorFrete := 0;
  LValorFrete := LValorFrete + ACdsAux.FieldByName('CTR_VALFRE').AsFloat;
  Result := LValorFrete;
end;

function TfrmEstornoReceber.fCreditoUtilizado(strNumDup,
                                              strParcel,
                                              strEspDoc,
                                              strCodEmp,
                                              strCodCli: String;
                                              intSeqBai,
                                              intSeqCon: Integer): Boolean;
  Var
    qryDupPrinc: TUniQuery;
Begin
  Result := False;
  qryDupPrinc := fCriaQuery(Nil);

  {******************************************}
  {* PRIMEIRO VERIFICA SE O PRÓPRIO CREDITO *}
  {* FOI BAIXADO                            *}
  {***************************************AF*}
  qryDupPrinc.Close;
  qryDupPrinc.SQL.Clear;
  qryDupPrinc.SQL.Add('SELECT ');
  qryDupPrinc.SQL.Add('  CTR_DTABAI, CTR_SEQCON ');
  qryDupPrinc.SQL.Add('FROM ');
  qryDupPrinc.SQL.Add('  CADREC ');
  qryDupPrinc.SQL.Add('WHERE ');
  qryDupPrinc.SQL.Add('  CTR_NUMDUP  = :NUMDUP AND ');
  qryDupPrinc.SQL.Add('  CTR_PARCEL  = :PARCEL AND ');
  qryDupPrinc.SQL.Add('  CTR_ESPDOC  = :ESPDOC AND ');
  qryDupPrinc.SQL.Add('  CTR_CODEMP  = :CODEMP AND ');
  qryDupPrinc.SQL.Add('  CTR_CODCLI  = :CODCLI AND ');
  qryDupPrinc.SQL.Add('  CTR_SEQBAI  = :SEQBAI AND ');
  qryDupPrinc.SQL.Add('  CTR_DTAREC IS NOT NULL  ');

  qryDupPrinc.ParamByName('NUMDUP').AsString  := strNumDup;
  qryDupPrinc.ParamByName('PARCEL').AsString  := strParcel;
  qryDupPrinc.ParamByName('ESPDOC').AsString  := strEspDoc;
  qryDupPrinc.ParamByName('CODEMP').AsString  := strCodEmp;
  qryDupPrinc.ParamByName('CODCLI').AsString  := strCodCli;
  qryDupPrinc.ParamByName('SEQBAI').AsInteger := intSeqBai;
  qryDupPrinc.Open;

  If Not qryDupPrinc.IsEmpty Then
  Begin
    pEmitirMensagem('','O crédito ' + strNumDup + strParcel + ' que foi gerado nesta baixa foi utilizado dia: ' +
                FormatDateTime('dd/mm/yyyy', qryDupPrinc.FieldByName('CTR_DTABAI').AsDateTime) + ', com o sequencial de controle: ' +
                       qryDupPrinc.FieldByName('CTR_SEQCON').AsString + '. Favor estornar primeiramente esse crédito.', True);
    Result := True;

    qryDupPrinc.Close;
    FreeAndNil(qryDupPrinc);

    Exit;
  End;

  {***************************************}
  {* ANALIZA SE FOI BAIXADO PARCIALMENTE *}
  {* O CRÉDITO GERADO NA BAIXA           *}
  {************************************AF*}
  qryDupPrinc.Close;
  qryDupPrinc.SQL.Clear;
  qryDupPrinc.SQL.Add('SELECT ');
  qryDupPrinc.SQL.Add('  CTR_DTABAI, CTR_SEQCON ');
  qryDupPrinc.SQL.Add('FROM ');
  qryDupPrinc.SQL.Add('  CADREC ');
  qryDupPrinc.SQL.Add('WHERE ');
  qryDupPrinc.SQL.Add('  CTR_NUMDUP  = :NUMDUP AND ');
  qryDupPrinc.SQL.Add('  CTR_PARCEL  = :PARCEL AND ');
  qryDupPrinc.SQL.Add('  CTR_ESPDOC  = :ESPDOC AND ');
  qryDupPrinc.SQL.Add('  CTR_CODEMP  = :CODEMP AND ');
  qryDupPrinc.SQL.Add('  CTR_CODCLI  = :CODCLI AND ');
  qryDupPrinc.SQL.Add('  CTR_SEQCON <> :SEQCON AND ');
  qryDupPrinc.SQL.Add('  CTR_SEQBAI  > :SEQBAI     ');

  qryDupPrinc.ParamByName('NUMDUP').AsString  := strNumDup;
  qryDupPrinc.ParamByName('PARCEL').AsString  := strParcel;
  qryDupPrinc.ParamByName('ESPDOC').AsString  := strEspDoc;
  qryDupPrinc.ParamByName('CODEMP').AsString  := strCodEmp;
  qryDupPrinc.ParamByName('CODCLI').AsString  := strCodCli;
  qryDupPrinc.ParamByName('SEQCON').AsInteger := intSeqCon;
  qryDupPrinc.ParamByName('SEQBAI').AsInteger := intSeqBai;
  qryDupPrinc.Open;

  If Not qryDupPrinc.IsEmpty Then
  Begin
    pEmitirMensagem('','O crédito ' + strNumDup + strParcel + ' que foi gerado nesta baixa foi baixado parcialmente dia: ' +
                FormatDateTime('dd/mm/yyyy', qryDupPrinc.FieldByName('CTR_DTABAI').AsDateTime) + ', com o sequencial de controle: ' +
                       qryDupPrinc.FieldByName('CTR_SEQCON').AsString + '. Favor estornar primeiramente as baixas parciais.', True);
    Result := True;
  End;

  qryDupPrinc.Close;
  FreeAndNil(qryDupPrinc);
End;

procedure TfrmEstornoReceber.pRemoveLiberacaoDoctoParaExpedicaoAutomatico(
  strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel: String);
begin
  If (fCfgSis('CXAEXP', VarString) = '2') Then
    Exit;

  If (fPodeRemoverLiberaracaoDoctoParaExpedicaoAutomatico(strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel)) Then
  Begin
    pMarcaDoctoComoNaoLiberadoParaExpedicao(strNumDup, strEspDoc, strCodEmp, strCodCli);
  End;
end;

function TfrmEstornoReceber.fPodeRemoverLiberaracaoDoctoParaExpedicaoAutomatico(
  strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel: String): Boolean;
Var
  strSQL: String;
  qryCtr: TUniQuery;
Begin

  Try

    qryCtr := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT                           ';
    strSQL := strSQL + '  CTR_NUMDUP                     ';
    strSQL := strSQL + 'FROM                             ';
    strSQL := strSQL + '  CADREC                         ';
    strSQL := strSQL + 'WHERE                            ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP    AND    ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC    AND    ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP    AND    ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI    AND    ';
    strSQL := strSQL + '  CTR_PARCEL = :PARCEL    AND    ';
    strSQL := strSQL + '  CTR_DTACAD = CTR_DTAVEN AND    ';  // SOMENTE PARA PARCELA A VISTA
    strSQL := strSQL + '  CTR_VALDUP > 0          AND    ';  // QUE TENHA VALOR EM ABERTO
    strSQL := strSQL + '  CTR_SEQBAI = 0                 ';

    With qryCtr Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('PARCEL').AsString := strParcel;
      Open;

      Result := (Not IsEmpty);
    End;

  Finally
    FreeAndNil(qryCtr);
  End;

end;

function TfrmEstornoReceber.fPossuiTransferenciaAutomaticaAtiva(ADadosDuplicata: OleVariant): Boolean;
var
  LConsulta: TUniQuery;
  LDatasetDuplicata: TUniClientDataSet;
  LDataRecebimento, LDataCaixa: String;
begin
  Result := False;

  LConsulta := fCriaQuery;
  LDatasetDuplicata := TUniClientDataSet.Create(Self);
  Try
    LDatasetDuplicata.Data := ADadosDuplicata;

    LDataRecebimento := FormatDateTime('dd/mm/yyyy', LDatasetDuplicata.FieldByName('CTR_DTAREC').AsDateTime);
    LDataCaixa := FormatDateTime('dd/mm/yyyy', dtaDtaRcx);

    If (LDataRecebimento <> LDataCaixa) Then
      Exit;

    If (blnFechadoCaixa) Then
      Exit;

    If Not objResumoDeCaixa.TransferenciaOrdemPagamentoAutomatica Then
      Exit;

    If (LDatasetDuplicata.FieldByName('CTR_RESCAI').AsInteger <> 1) Then
      Exit;

    If (LDatasetDuplicata.FieldByName('CTR_ORIGEM').AsString = 'CTR') Then
      Exit;

    If (LDatasetDuplicata.FieldByName('CTR_ORDPAG').AsFloat <= 0) Then
      Exit;

    If (LDatasetDuplicata.FieldByName('CTR_RECPIX').AsString = 'S') Then
    Begin
      If PossuiRegistroNaMovPix Then
        Exit;
    End;

    LConsulta.SQL.Text :=
      'SELECT 1 FROM CADRCXX '+
      'WHERE RCX_DTACAD = :DTACAD '+
      '  AND RCX_SQTFOP = :SEQCON '+
      '  AND RCX_CODEMP = :CODEMP '+
      '  AND RCX_ESPDOC = "TF" '+
      '  AND RCX_TFCANC = "N" ';

    LConsulta.ParamByName('DTACAD').AsDateTime := LDatasetDuplicata.FieldByName('CTR_DTAREC').AsDateTime;
    LConsulta.ParamByName('SEQCON').AsInteger := LDatasetDuplicata.FieldByName('CTR_SEQCON').AsInteger;
    LConsulta.ParamByName('CODEMP').AsString := LDatasetDuplicata.FieldByName('CTR_EMPBAI').AsString;
    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
    FreeAndNil(LDatasetDuplicata);
  End;
end;

function TfrmEstornoReceber.fRetornaValRecPix(ADataset: TDataset): Double;
begin
  Result := 0.00 ;
  ADataset.First ;
  while not ADataset.Eof do
  begin
    Result := Result + ADataset.FieldByName('MPX_VALREC').AsFloat ;
    ADataset.Next ;
  end ;
end;

function TfrmEstornoReceber.fSaldoCaixaSuficiente(intSeqCon: Integer;
  strEmpBai: String; dtaDtaBai: TDateTime; ARecebidoPorPix: Boolean): Boolean;
var
  fltValDin,
  fltValCar,
  fltChqVis,
  fltChqPre,
  fltOrdRec,
  fltValFin,
  fltValLan,
  fltTotGua,
  fltTotDol,
  fltTotEur,
  fltTotPes,
  fltTotRea: Double;
  blnDin,
  blnOrd,
  blnFin: Boolean;
  strModalidades,
  LRecebidoPorPix: String;
  LValorOrdemPagamento: Double;
  LValidaPixAvulso: Boolean;
begin
  pDeterminaModEstornoRcx(intSeqCon,
                          strEmpBai,
                          dtaDtaBai,
                          fltValDin,
                          fltValCar,
                          fltChqVis,
                          fltChqPre,
                          fltOrdRec,
                          fltValFin,
                          fltValLan,
                          fltTotGua,
                          fltTotDol,
                          fltTotEur,
                          fltTotPes,
                          fltTotRea,
                          LRecebidoPorPix);
  LValorOrdemPagamento := fFormataFloat(fltOrdRec, 2);
  LValidaPixAvulso := (Not PossuiRegistroNaMovPix) And LRecebidoPorPix.Equals('S');
  If ARecebidoPorPix Then
  Begin
    If FValorTotalPix < fltOrdRec Then
    Begin
      LValorOrdemPagamento := fFormataFloat(fltOrdRec - FValorTotalPix, 2);
      LValidaPixAvulso := True;
    End;
  End;

  blnDin := (fFormataFloat(fltValDin, 2) <= fFormataFloat(objResumoDeCaixa.fRetornaSaldoCaixaCampo('RCX_DINREC', strCodigoCaixa), 2));
  blnOrd := (fFormataFloat(LValorOrdemPagamento, 2) <= fFormataFloat(objResumoDeCaixa.fRetornaSaldoCaixaCampo('RCX_ORDREC', strCodigoCaixa, '', '', ARecebidoPorPix, Not PossuiRegistroNaMovPix, Not ARecebidoPorPix), 2));
  blnFin := (fFormataFloat(fltValFin, 2) <= fFormataFloat(objResumoDeCaixa.fRetornaSaldoCaixaCampo('RCX_VALFIN', strCodigoCaixa), 2));

  Result := blnDin And blnOrd And blnFin;

  If Not Result Then
  Begin
    strModalidades := '';

    If Not blnDin Then
    Begin
      strModalidades := strModalidades + 'Dinheiro';
      If Not (blnOrd Or blnFin) Then
        strModalidades := strModalidades + ', '
      Else If Not (blnOrd And blnFin) Then
        strModalidades := strModalidades + ' e '
    End;

    If Not blnOrd Then
    Begin
      strModalidades := strModalidades + IIF(Not LValidaPixAvulso, 'Ordem de pagamento', 'Pix avulso');
      If Not blnFin Then
        strModalidades := strModalidades + ' e ';
    End;

    If Not blnFin Then
      strModalidades := strModalidades + 'Financiamento';

    pEmitirMensagem('','Saldo insuficiente na(s) modalidade(s) ' + strModalidades + ' para efetuar o estorno.');
  End;
end;

procedure TfrmEstornoReceber.pMarcaDoctoComoNaoLiberadoParaExpedicao(strNumDup,
  strEspDoc, strCodEmp, strCodCli: String);
Var
  strSQL: String;
  qryCtr: TUniQuery;
Begin

  Try

    qryCtr := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'UPDATE                       ';
    strSQL := strSQL + '  MOVGER                     ';
    strSQL := strSQL + '  LEFT JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM ';
    strSQL := strSQL + 'SET                          ';
    strSQL := strSQL + '  GER_OPLBRC = NULL,         ';
    strSQL := strSQL + '  GER_DTLBRC = NULL,         ';
    strSQL := strSQL + '  GER_HRLBRC = NULL,         ';
    strSQL := strSQL + '  AUX_LBRCAU = "N"           ';
    strSQL := strSQL + 'WHERE                        ';
    strSQL := strSQL + '  GER_NUMDOC = :NUMDOC   AND ';
    strSQL := strSQL + '  GER_ESPDOC = :ESPDOC   AND ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP   AND ';
    strSQL := strSQL + '  GER_CODCLI = :CODCLI   AND ';
    strSQL := strSQL + '  GER_DTLBRC IS NOT NULL AND ';  // ATUALIZA SOMENTE SE TEVE LIBERAÇÃO
    strSQL := strSQL + '  GER_DTLBEX IS NULL     AND ';  // ATUALIZA SOMENTE SE O DOCUMENTO AINDA NÃO FOI EXPEDIDO
    strSQL := strSQL + '  AUX_LBRCAU = "S"           ';  // ATUALIZA SOMENTE SE TEVE LIBERAÇÃO AUTOMÁTICA REALIZADA PELO SISTEMA.

    With qryCtr Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString   := strNumDup;
      ParamByName('ESPDOC').AsString   := strEspDoc;
      ParamByName('CODEMP').AsString   := strCodEmp;
      ParamByName('CODCLI').AsString   := strCodCli;
      ExecSQL;
    End;

  Finally
    FreeAndNil(qryCtr);
  End;

end;

{*************************************************************}
{* CASO A BAIXA FOI EFETUADA COM  CARTÃO OU CHEQUE EMITE UM  *}
{* AVISO AO USUARIO PARA EFETUAR A TRANSFERENCIA             *}
{REQ45209**************************************************LE*}
function  TFrmEstornoReceber.fVerificaBaixaVinculadaCartoesChequesNaoTransferidos(dtaFechCai,dtaBaixa:TDateTime;intSeqCon:Integer;strEmpBai:String) : Boolean;
  Var
    qryTemp: TUniQuery;
    strSQL : String;
Begin
  Result := False;
  If  fCfgSis('RCXTCC') = '1' Then  //Somente quando for CFG_RCTCC = 2  deve executar a rotina.
    Exit;

  If Not strCodigoCaixa.IsEmpty Then
  Begin
    If objResumoDeCaixa.strTipoFechamento = 'C' Then
    Begin
      Result := objResumoDeCaixa.VerificaBaixaVinculadaComCartoesECheques(dtaFechCai,
                                                                          dtaBaixa,
                                                                          intSeqCon,
                                                                          strEmpBai,
                                                                          strCodigoCaixa);

      Exit;
    End;
  End;

  qryTemp := fCriaQuery(Self);

  strSQL := '';
  strSQL := 'SELECT RCX_DTACAD, RCX_ESPDOC from CADRCXX';
  strSQL := strSQL + ' Where RCX_DTACAD = :DTABAIDUP' ;
  strSQL := strSQL + ' AND RCX_ESPDOC = ' + QuotedStr('FC');
  strSQL := strSQL + ' AND RCX_CODEMP =' + QuotedStr(VS_strCodEmp);

  qryTemp.SQL.Add(strSQL);
  qryTemp.ParamByName('DTABAIDUP').AsDateTime := dtaFechCai;
  qryTemp.Open;

  If (qryTemp.FindFirst) Then
  Begin
      If (fHouveTransferenciaCartao(intSeqCon,
                                  strEmpBai,
                                  dtaBaixa,True)) Then
      Result := True;

      If (fHouveTransferenciaCheque(intSeqCon,
                                   strEmpBai,
                                  dtaBaixa,True)) Then
      Result := True;

  End
   //REQ 45176
   Else
   Begin
     If (fHouveTransferenciaCartao(intSeqCon,
                                  strEmpBai,
                                  dtaBaixa)) Then
     Result := True;

     If (fHouveTransferenciaCheque(intSeqCon,
                                  strEmpBai,
                                  dtaBaixa)) Then

     Result := True;

   End;
End;

function TFrmEstornoReceber.fDocumentoFaturado(oleDados: OleVariant): Boolean;
var qryTemp: TUniQuery;
    cdsTemp: TUniClientDataSet;
    strNumDoc, strEspDoc, strCodCli, strCodEmp: String;
    strNumFat, strTipFat, strEmpFat: String;

Begin
  Result := false ;

  try
    qryTemp := fCriaQuery(Self);
    cdsTemp := TUniClientDataSet.Create(Self);
    cdsTemp.Data := oleDados;

    cdsTemp.Filter   := 'CTR_MARDES = ' + QuotedStr('M');
    cdsTemp.Filtered := True;

    cdsTemp.First;

    While not cdsTemp.eof do
    Begin

      strNumDoc := cdsTemp.FieldByName('NUMDUP').AsString;
      strEspDoc := cdsTemp.FieldByName('CTR_ESPDOC').AsString;
      strCodCli := cdsTemp.FieldByName('CTR_CODCLI').AsString;
      strCodEmp := cdsTemp.FieldByName('CTR_CODEMP').AsString;

      With qryTemp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT GER_JAFATU, GER_NUMFAT, GER_TIPFAT, GER_EMPFAT ');
        SQL.Add('FROM MOVGER ');
        SQL.Add('WHERE GER_NUMDOC = :NUMDOC ');
        SQL.Add('  AND GER_ESPDOC = :ESPDOC ');
        SQL.Add('  AND GER_CODCLI = :CODCLI ');
        SQL.Add('  AND GER_CODEMP = :CODEMP ');
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODCLI').AsString := strCodCli;
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;

        if FieldByName('GER_JAFATU').DataType = ftInteger then
          Result := (FieldByName('GER_JAFATU').AsInteger = 1)
        Else
          Result := FieldByName('GER_JAFATU').AsBoolean;

        strNumFat := FieldByName('GER_NUMFAT').AsString;
        strTipFat := FieldByName('GER_TIPFAT').AsString;
        strEmpFat := FieldByName('GER_EMPFAT').AsString;
      End;

      if Result then
      Begin
        pEmitirMensagem('',' Não é permitido estornar a duplicata de um documento que já foi faturado.'  + #13#10 +
                        ' Docto Original: '+strNumDoc+' - '+strEspDoc+' - '+strCodEmp+'  Docto de Faturamento: '+strNumFat+' - '+strTipFat+' - '+strEmpFat+ #13#10 +
                        ' Realize o cancelamento do documento de faturamento e depois efetue o estorno da duplicata do documento original.'  +
                        ' Se não for possível realizar o cancelamento, devolva o documento de faturamento, realize a baixa da duplicata' +
                        ' de crédito gerada e gere um novo documento de venda .', True, True);

        Exit;
      End;

      cdsTemp.Next;
    End;

  Finally
    FreeAndNil(qryTemp);
    FreeAndNil(cdsTemp);
  End;

end;

function TFrmEstornoReceber.fVerificaExisteMovBanJurosDesc(strAutoIncrem: string): Boolean;
 Var
     qryTemp: TUniQuery;
Begin
  Result := false;

  Try

    qryTemp := fCriaQuery(Self);
    With qryTemp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT MOV_SEQCTB, MOV_EMPCTB ');
      SQL.Add('   FROM MOVCTR ');
      SQL.Add('  WHERE MOV_AUTCTR = :AUTOINCREM ');
      ParamByName('AUTOINCREM').AsString := strAutoIncrem;
      Open;

      If Not IsEmpty Then
         Result := True;
    End;

  Finally
    FreeAndNil(qryTemp);
  End;

end;

Procedure TFrmEstornoReceber.pExcluiMovCtrEstornada(strAutoIncrem: string);
 Var
     qryDel: TUniQuery;
     qryAut: TUniQuery;
Begin

  Try

    qryAut := fCriaQuery(Self);
    With qryAut Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT AUTOINCREM ');
      SQL.Add('   FROM MOVCTR ');
      SQL.Add('  WHERE MOV_AUTCTR = :AUTOINCREM ');
      ParamByName('AUTOINCREM').AsString := strAutoIncrem;
      Open;
    End;

    If Not qryAut.IsEmpty Then
       fGravaLogMovCtr( qryAut.FieldByName('AUTOINCREM').AsString, 'ESTORNO DE RECEBIMENTO', self.name, '');

    qryDel := fCriaQuery(Self);
    With qryDel Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' DELETE ');
      SQL.Add('   FROM MOVCTR ');
      SQL.Add('  WHERE MOV_AUTCTR = :AUTOINCREM ');
      ParamByName('AUTOINCREM').AsString := strAutoIncrem;
      ExecSQL;
    End;

  Finally
    FreeAndNil(qryDel);
    FreeAndNil(qryAut);
  End;

end;

Function TFrmEstornoReceber.fEstornaMovbanJurosDescto(strAutoIncrem: string; dtaEstorn: TDate) : Boolean;
 Var
     qryTemp   : TUniQuery;
     lstBanCtr : TBanCtrRepository;
     strCreDeb,
     strHist   : String;
Begin

  Try

    qryTemp    := fCriaQuery(Self);
    With qryTemp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT ');
      SQL.Add('  M.MOV_SEQCTB, M.MOV_EMPCTB, C.CTR_ESPDOC, ');
      SQL.Add('  B.CTB_NUMDUP, B.CTB_PARCEL, B.CTB_CODEMP, B.CTB_CODCLI, B.CTB_HIST01, B.CTB_HIST02, ');
      SQL.Add('  B.CTB_VALLAN, B.CTB_CREDEB, B.CTB_SEQBAI, B.CTB_CODCTA, B.CTB_CODPOR, B.CTB_NUMDOC, B.CTB_CODEVE ');
      SQL.Add('   FROM MOVCTR M ');
      SQL.Add('  INNER JOIN MOVBAN B ON  M.MOV_SEQCTB = B.CTB_SEQLAN ');
      SQL.Add('                      AND M.MOV_EMPCTB = B.CTB_CODEMP ');
      SQL.Add('  INNER JOIN CADREC C ON M.MOV_AUTCTR = C.AUTOINCREM  ');
      SQL.Add('  WHERE MOV_AUTCTR = :AUTOINCREM ');
      ParamByName('AUTOINCREM').AsString := strAutoIncrem;

      Open;

      If Not qryTemp.IsEmpty Then
      Begin
        first;
        While Not qryTemp.Eof Do
        Begin

            lstBanCtr := TBanCtrRepository.Create;
            lstBanCtr.fAdd(qryTemp.FieldByName('CTB_NUMDUP').AsString,
                           qryTemp.FieldByName('CTB_PARCEL').AsString,
                           qryTemp.FieldByName('CTR_ESPDOC').AsString,
                           qryTemp.FieldByName('CTB_CODEMP').AsString,
                           qryTemp.FieldByName('CTB_CODCLI').AsString,
                           qryTemp.FieldByName('CTB_HIST01').AsString,
                           qryTemp.FieldByName('CTB_HIST02').AsString,
                           qryTemp.FieldByName('CTB_SEQBAI').AsInteger,
                           qryTemp.FieldByName('CTB_VALLAN').AsFloat,
                           0,
                           0,
                           qryTemp.FieldByName('CTB_VALLAN').AsFloat,
                           'S');

            strCreDeb := IIF(qryTemp.FieldByName('CTB_CREDEB').AsString = 'D', 'C', 'D');

            strHist := '';
            strHist := IIF( Pos('REF. JUROS', qryTemp.FieldByName('CTB_HIST01').AsString) > 0,'REF. JUROS', IIF( Pos('REF. DESCTO.',qryTemp.FieldByName('CTB_HIST01').AsString) > 0, 'REF. DESCTO.', '') );


            If fEmptyStr(fGravaMovBan(qryTemp.FieldByName('CTB_CODCTA').AsString,                          // Centro de Custo
                                      qryTemp.FieldByName('CTB_CODPOR').AsString,                          // Portador da Baixa
                                      strLoginUsuarioLogado,                                               // Operador da Baixa
                                      dtaEstorn,                                                           // Data do Lançamento
                                      fTime(),                                                             // Hora do Lançamento
                                      qryTemp.FieldByName('CTB_NUMDOC').AsString,                          // Numero do Documento
                                      strCreDeb,                                                           // Credito / Debito
                                      qryTemp.FieldByName('CTB_CODEMP').AsString,                          // Empresa da Baixa
                                      qryTemp.FieldByName('CTB_VALLAN').AsFloat,                           // Valor Do Lançamento
                                      'ESTORNO '+ strHist +' DA DUPLICATA ' + qryTemp.FieldByName('CTB_NUMDOC').AsString,// Histórico 1
                                      '',                                                                  // Histórico 2
                                      qryTemp.FieldByName('CTB_CODCLI').AsString,                          // Cliente da Duplicata
                                      '',                                                                  // Fornecedor da Duplicata
                                      qryTemp.FieldByName('CTB_NUMDUP').AsString,                          // Número da Duplicata
                                      0,                                                                   // Sequencial de Baixa
                                      qryTemp.FieldByName('CTB_PARCEL').AsString,                          // Parcela da Duplicata
                                      qryTemp.FieldByName('CTB_CODEMP').AsString,                          // Empresa da Duplicata
                                      '',                                                                  // Serie
                                      qryTemp.FieldByName('CTB_CODEVE').AsString,                          // Codigo do Evento
                                      '',                                                                  // Documento da Baixa
                                      lstBanCtr.fGetList,                                                  // Log Bancário
                                      0,
                                      0,
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      1,
                                      False
                                     )) Then
            Begin
              Result := False;
              FreeAndNil(lstBanCtr);
              Raise Exception.Create('Não foi possível gravar o movimento bancário no estorno!');
              Exit;
            End;

          Next;
        End;

      End;

      Result := True;

    End;

  Finally
    FreeAndNil(qryTemp);
  End;

End;

Function TFrmEstornoReceber.fEstornaMovbanJurosDesctoSintetico(strAutoIncrem, strPorBai, strCtaBai : string; dtaEstorn: TDate) : Boolean;
 Var
     qryTemp   : TUniQuery;
     lstBanCtr : TBanCtrRepository;
     strCreDeb,
     PlConta_juros,
     PlConta_desc  : String;
Begin

  Try
    PlConta_juros := fCfgSis('PLJURM');
    PlConta_desc  := fCfgSis('PLDESM');

    qryTemp    := fCriaQuery(Self);
    With qryTemp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT DISTINCT MOV_AUTCTR, ');
      SQL.Add('       CTR_CODCTA, CTR_CODPOR, CTR_CODCLI, CTR_ESPDOC, ');
      SQL.Add('       CTR_NUMDUP, CTR_PARCEL, CTR_CODEMP, CTR_HIST01, CTR_HIST02, CTR_SEQBAI, CTR_VALREC, CTR_CODEVE, ');
      SQL.Add('       CTR_VALDES, CTR_VALJUR, CTR_VALORI, CTR_EMPBAI ');
      SQL.Add('  FROM MOVCTR M ');
      SQL.Add(' INNER JOIN CADREC C ON  M.MOV_AUTCTR = C.AUTOINCREM ');
      SQL.Add('   INNER JOIN MOVBAN B ON  M.MOV_SEQCTB = B.CTB_SEQLAN ');
      SQL.Add('                       AND M.MOV_EMPCTB = B.CTB_CODEMP ');
      SQL.Add(' WHERE MOV_AUTCTR = :AUTOINCREM ');
      ParamByName('AUTOINCREM').AsString := strAutoIncrem;
      Open;

      First;
      If Not qryTemp.IsEmpty Then
      Begin

        If (qryTemp.FieldByName('CTR_ESPDOC').AsString <> 'CC') Then
        Begin
          lstBanCtr := TBanCtrRepository.Create;
          lstBanCtr.fAdd(qryTemp.FieldByName('CTR_NUMDUP').AsString,
                         qryTemp.FieldByName('CTR_PARCEL').AsString,
                         qryTemp.FieldByName('CTR_ESPDOC').AsString,
                         qryTemp.FieldByName('CTR_EMPBAI').AsString,
                         qryTemp.FieldByName('CTR_CODCLI').AsString,
                         qryTemp.FieldByName('CTR_HIST01').AsString,
                         qryTemp.FieldByName('CTR_HIST02').AsString,
                         qryTemp.FieldByName('CTR_SEQBAI').AsInteger,
                         qryTemp.FieldByName('CTR_VALORI').AsFloat,
                         0,
                         0,
                         qryTemp.FieldByName('CTR_VALORI').AsFloat,
                         'S');

          strCreDeb := RetornaTipoMovimentacaoBancaria(qryTemp.FieldByName('CTR_VALORI').AsFloat);

          If fEmptyStr(fGravaMovBan(strCtaBai,                                                           // Centro de Custo
                                    strPorBai,                                                           // Portador da Baixa
                                    strLoginUsuarioLogado,                                               // Operador da Baixa
                                    dtaEstorn,                                                           // Data do Lançamento
                                    fTime(),                                                             // Hora do Lançamento
                                    qryTemp.FieldByName('CTR_NUMDUP').AsString + qryTemp.FieldByName('CTR_PARCEL').AsString,                          // Numero do Documento
                                    strCreDeb,                                                           // Credito / Debito
                                    qryTemp.FieldByName('CTR_EMPBAI').AsString,                          // Empresa da Baixa
                                    qryTemp.FieldByName('CTR_VALORI').AsFloat,                           // Valor Do Lançamento
                                    'ESTORNO DA DUPLICATA '+qryTemp.FieldByName('CTR_NUMDUP').AsString +
                                                            qryTemp.FieldByName('CTR_PARCEL').AsString,  // Histórico 1
                                    '',                                                                  // Histórico 2
                                    qryTemp.FieldByName('CTR_CODCLI').AsString,                          // Cliente da Duplicata
                                    '',                                                                  // Fornecedor da Duplicata
                                    qryTemp.FieldByName('CTR_NUMDUP').AsString,                          // Número da Duplicata
                                    0,                                                                   // Sequencial de Baixa
                                    qryTemp.FieldByName('CTR_PARCEL').AsString,                          // Parcela da Duplicata
                                    qryTemp.FieldByName('CTR_CODEMP').AsString,                          // Empresa da Duplicata
                                    '',                                                                  // Serie
                                    qryTemp.FieldByName('CTR_CODEVE').AsString,                          // Codigo do Evento
                                    '',                                                                  // Documento da Baixa
                                    lstBanCtr.fGetList,                                                  // Log Bancário
                                    0,
                                    0,
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    1,
                                    False
                                   )) Then
          Begin
            Result := False;
            FreeAndNil(lstBanCtr);
            Raise Exception.Create('Não foi possível gravar o movimento bancário no estorno!');
            Exit;
          End;

          // Juros
          If qryTemp.FieldByName('CTR_VALJUR').AsFloat > 0 Then
          Begin
            lstBanCtr := TBanCtrRepository.Create;
            lstBanCtr.fAdd(qryTemp.FieldByName('CTR_NUMDUP').AsString,
                           qryTemp.FieldByName('CTR_PARCEL').AsString,
                           qryTemp.FieldByName('CTR_ESPDOC').AsString,
                           qryTemp.FieldByName('CTR_EMPBAI').AsString,
                           qryTemp.FieldByName('CTR_CODCLI').AsString,
                           qryTemp.FieldByName('CTR_HIST01').AsString,
                           qryTemp.FieldByName('CTR_HIST02').AsString,
                           qryTemp.FieldByName('CTR_SEQBAI').AsInteger,
                           qryTemp.FieldByName('CTR_VALJUR').AsFloat,
                           0,
                           0,
                           qryTemp.FieldByName('CTR_VALJUR').AsFloat,
                           'S');

            strCreDeb := RetornaTipoMovimentacaoBancaria(qryTemp.FieldByName('CTR_VALORI').AsFloat);

            If fEmptyStr(fGravaMovBan(PlConta_juros,                                                       // Centro de Custo
                                      strPorBai,                                                           // Portador da Baixa
                                      strLoginUsuarioLogado,                                               // Operador da Baixa
                                      dtaEstorn,                                                           // Data do Lançamento
                                      fTime(),                                                             // Hora do Lançamento
                                      qryTemp.FieldByName('CTR_NUMDUP').AsString,                          // Numero do Documento
                                      strCreDeb,                                                           // Credito / Debito
                                      qryTemp.FieldByName('CTR_EMPBAI').AsString,                          // Empresa da Baixa
                                      qryTemp.FieldByName('CTR_VALJUR').AsFloat,                           // Valor Do Lançamento
                                      'ESTORNO REF. JUROS DA DUPLICATA '+qryTemp.FieldByName('CTR_NUMDUP').AsString+qryTemp.FieldByName('CTR_PARCEL').AsString,// Histórico 1
                                      '',                                                                  // Histórico 2
                                      qryTemp.FieldByName('CTR_CODCLI').AsString,                          // Cliente da Duplicata
                                      '',                                                                  // Fornecedor da Duplicata
                                      qryTemp.FieldByName('CTR_NUMDUP').AsString,                          // Número da Duplicata
                                      0,                                                                   // Sequencial de Baixa
                                      qryTemp.FieldByName('CTR_PARCEL').AsString,                          // Parcela da Duplicata
                                      qryTemp.FieldByName('CTR_CODEMP').AsString,                          // Empresa da Duplicata
                                      '',                                                                  // Serie
                                      qryTemp.FieldByName('CTR_CODEVE').AsString,                          // Codigo do Evento
                                      '',                                                                  // Documento da Baixa
                                      lstBanCtr.fGetList,                                                  // Log Bancário
                                      0,
                                      0,
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      1,
                                      False
                                     )) Then
            Begin
              Result := False;
              FreeAndNil(lstBanCtr);
              Raise Exception.Create('Não foi possível gravar o movimento bancário no estorno!');
              Exit;
            End;

          End;

          // Desconto
          If qryTemp.FieldByName('CTR_VALDES').AsFloat > 0 Then
          Begin
            lstBanCtr := TBanCtrRepository.Create;
            lstBanCtr.fAdd(qryTemp.FieldByName('CTR_NUMDUP').AsString,
                           qryTemp.FieldByName('CTR_PARCEL').AsString,
                           qryTemp.FieldByName('CTR_ESPDOC').AsString,
                           qryTemp.FieldByName('CTR_EMPBAI').AsString,
                           qryTemp.FieldByName('CTR_CODCLI').AsString,
                           qryTemp.FieldByName('CTR_HIST01').AsString,
                           qryTemp.FieldByName('CTR_HIST02').AsString,
                           qryTemp.FieldByName('CTR_SEQBAI').AsInteger,
                           qryTemp.FieldByName('CTR_VALDES').AsFloat,
                           0,
                           0,
                           qryTemp.FieldByName('CTR_VALDES').AsFloat,
                           'S');

            strCreDeb := 'C';
            If qryTemp.FieldByName('CTR_VALORI').AsFloat < 0 Then
              strCreDeb := 'D';

            If fEmptyStr(fGravaMovBan(PlConta_desc,                                                        // Centro de Custo
                                      strPorBai, //qryTemp.FieldByName('CTB_CODPOR').AsString,             // Portador da Baixa
                                      strLoginUsuarioLogado,                                               // Operador da Baixa
                                      dtaEstorn,                                                           // Data do Lançamento
                                      fTime(),                                                             // Hora do Lançamento
                                      qryTemp.FieldByName('CTR_NUMDUP').AsString,                          // Numero do Documento
                                      strCreDeb,                                                           // Credito / Debito
                                      qryTemp.FieldByName('CTR_EMPBAI').AsString,                          // Empresa da Baixa
                                      qryTemp.FieldByName('CTR_VALDES').AsFloat,                           // Valor Do Lançamento
                                      'ESTORNO REF. DESC. DA DUPLICATA '+qryTemp.FieldByName('CTR_NUMDUP').AsString+qryTemp.FieldByName('CTR_PARCEL').AsString,// Histórico 1
                                      '',                                                                  // Histórico 2
                                      qryTemp.FieldByName('CTR_CODCLI').AsString,                          // Cliente da Duplicata
                                      '',                                                                  // Fornecedor da Duplicata
                                      qryTemp.FieldByName('CTR_NUMDUP').AsString,                          // Número da Duplicata
                                      0,                                                                   // Sequencial de Baixa
                                      qryTemp.FieldByName('CTR_PARCEL').AsString,                          // Parcela da Duplicata
                                      qryTemp.FieldByName('CTR_CODEMP').AsString,                          // Empresa da Duplicata
                                      '',                                                                  // Serie
                                      qryTemp.FieldByName('CTR_CODEVE').AsString,                          // Codigo do Evento
                                      '',                                                                  // Documento da Baixa
                                      lstBanCtr.fGetList,                                                  // Log Bancário
                                      0,
                                      0,
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      1,
                                      False
                                     )) Then
            Begin
              Result := False;
              FreeAndNil(lstBanCtr);
              Raise Exception.Create('Não foi possível gravar o movimento bancário no estorno!');
              Exit;
            End;

          End;

        End
        Else
        Begin

          lstBanCtr := TBanCtrRepository.Create;
          lstBanCtr.fAdd(qryTemp.FieldByName('CTR_NUMDUP').AsString,
                         qryTemp.FieldByName('CTR_PARCEL').AsString,
                         qryTemp.FieldByName('CTR_ESPDOC').AsString,
                         qryTemp.FieldByName('CTR_EMPBAI').AsString,
                         qryTemp.FieldByName('CTR_CODCLI').AsString,
                         qryTemp.FieldByName('CTR_HIST01').AsString,
                         qryTemp.FieldByName('CTR_HIST02').AsString,
                         qryTemp.FieldByName('CTR_SEQBAI').AsInteger,
                         qryTemp.FieldByName('CTR_VALORI').AsFloat,  //qryTemp.FieldByName('CTR_VALREC').AsFloat,
                         0,
                         0,
                         qryTemp.FieldByName('CTR_VALORI').AsFloat,
                         'S'); //qryTemp.FieldByName('CTR_VALREC').AsFloat);

          strCreDeb := 'C';

          If fEmptyStr(fGravaMovBan(strCtaBai, //qryTemp.FieldByName('CTB_CODCTA').AsString,             // Centro de Custo
                                    strPorBai, //qryTemp.FieldByName('CTB_CODPOR').AsString,             // Portador da Baixa
                                    strLoginUsuarioLogado,                                               // Operador da Baixa
                                    dtaEstorn,                                                           // Data do Lançamento
                                    fTime(),                                                             // Hora do Lançamento
                                    qryTemp.FieldByName('CTR_NUMDUP').AsString + qryTemp.FieldByName('CTR_PARCEL').AsString,                          // Numero do Documento
                                    strCreDeb,                                                           // Credito / Debito
                                    qryTemp.FieldByName('CTR_EMPBAI').AsString,                          // Empresa da Baixa
                                    //qryTemp.FieldByName('CTR_VALREC').AsFloat,                         // Valor Do Lançamento
                                    qryTemp.FieldByName('CTR_VALORI').AsFloat,                           // Valor Do Lançamento
                                    'ESTORNO REF. CRED. ' + qryTemp.FieldByName('CTR_NUMDUP').AsString +
                                                            qryTemp.FieldByName('CTR_PARCEL').AsString,  // Histórico 1
                                    '',                                                                  // Histórico 2
                                    qryTemp.FieldByName('CTR_CODCLI').AsString,                          // Cliente da Duplicata
                                    '',                                                                  // Fornecedor da Duplicata
                                    qryTemp.FieldByName('CTR_NUMDUP').AsString,                          // Número da Duplicata
                                    0,                                                                   // Sequencial de Baixa
                                    qryTemp.FieldByName('CTR_PARCEL').AsString,                          // Parcela da Duplicata
                                    qryTemp.FieldByName('CTR_CODEMP').AsString,                          // Empresa da Duplicata
                                    '',                                                                  // Serie
                                    qryTemp.FieldByName('CTR_CODEVE').AsString,                          // Codigo do Evento
                                    '',                                                                  // Documento da Baixa
                                    lstBanCtr.fGetList,                                                  // Log Bancário
                                    0,
                                    0,
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    1,
                                    False
                                   )) Then
          Begin
            Result := False;
            FreeAndNil(lstBanCtr);
            Raise Exception.Create('Não foi possível gravar o movimento bancário no estorno!');
            Exit;
          End;

        End;

      End;

      Result := True;

    End;

  Finally
    FreeAndNil(qryTemp);
  End;

End;

function TfrmEstornoReceber.fMensagemEstornoNoMesmoDia(const strLanFec : String) : String;
begin
  Result := 'Estorno não permitido pois o recebimento foi feito pelo Resumo de Caixa.';

  If strLanFec = 'S' Then
    Result := Result + sLineBreak + 'Para realizar o estorno, deve ser cancelado o fechamento do caixa ou pode ser feito no dia posterior a baixa do título.'
  Else
    Result := Result + sLineBreak + 'Para realizar o estorno, deve ser feito pelo Resumo de Caixa ou pode ser feito com o caixa no dia posterior a baixa do título.';
end;

function TfrmEstornoReceber.fLiberouTravaPeloCancelamentoComSenha(const strLanFec : String; var blnExibiuTrava : Boolean) : Boolean;
  Var
    LMessage : String;
    LRowsMessage : TArray<String>;
    LText : String;
    LLiberacao : TLiberacao;
begin
  Result := False;
  If (strEstRec <> '(Cancelamento de Documentos)') Then
    Exit;
  If (fCfgSis('CNPECX', varString) = 'N') Then
    Exit;
  LLiberacao := TLiberacao.Create;
  Try
    blnExibiuTrava := True;
    LMessage := fMensagemEstornoNoMesmoDia(strLanFec);
    LRowsMessage := LMessage.Split([sLineBreak]);
    LLiberacao.Clear;
    LLiberacao.strDirAce := 'CNPECX';
    LLiberacao.strMsgSen := 'No cancelamento de documentos permitir estornar recebimento feito pelo caixa no mesmo dia mediante senha';
    LLiberacao.strCodOpe := strLoginUsuarioLogado;
    For LText In LRowsMessage Do
      LLiberacao.objMsgLibera.pAddTexto(LText);
    LLiberacao.objMsgLibera.pAddTexto('');
    LLiberacao.objMsgLibera.pAddTexto('Operador Logado: ' + strLoginUsuarioLogado + ' - Data e Hora: ' + FormatDateTime('dd/mm/yyyy HH:nn:ss', fRetDtaHraServidor));
    Result := LLiberacao.fLibera;
  Finally
    FreeAndNil(LLiberacao);
  End;
end;

function TfrmEstornoReceber.fGetLanFec(const ADataSetCaixa : TDataSet) : String;
begin
  Result := 'N';
  If Not Assigned(ADataSetCaixa) Then
    Exit;
  If Not ADataSetCaixa.Active Then
    Exit;
  If ADataSetCaixa.IsEmpty Then
    Exit;
  If Not Assigned(ADataSetCaixa.FindField('RCX_LANFEC')) Then
    Exit;
  Result := ADataSetCaixa.FieldByName('RCX_LANFEC').AsString;
end;

end.
