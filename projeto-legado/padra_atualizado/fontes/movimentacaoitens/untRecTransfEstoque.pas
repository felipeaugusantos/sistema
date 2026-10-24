unit untRecTransfEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask, untCadLote,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, DBCtrls, DBEditFocus,
  BitBtnLockedIncrem, ComCtrls, cxProgressBar, Math, untEntAutorizacaoRedPreco,
  MemDS, DBAccess, Datasnap.Provider, frxClass, frxExportCSVTestabilidade,
  untTipoTinta, untRecConferEntrada, Datasnap.DBClient, untPcmGer,
  untEnderecamentoProduto, untEntradaSimplificada, untOrdPro, untCfgCfopCst, untTypesSistema,
  untParCalculaPrecoCusto, untLotePrecos, untFatorPreco, untZClient, untTLock, untPreAlt_Trigger,
  untEfetivaMovimentoFiscal, untAuditoriaGravacaoSaldo, untTDistribuicaoConferencia,
  untLogCancelamento, untGravando,
  untFuncFatTypes;

type
  TRecTotais = Record
    fltBasIpi,
    fltTotIpi,
    fltBasIcm,
    fltTotIcm,
    fltValRet,
    fltBasRet,
    fltValAnt,
    fltBasAnt,
    fltDesEsp,
    fltVlrCon,
    fltTotIte,
    fltValFre,
    fltDesAce: Double;
  End;

  TArrPrecos = Array[1..7] Of TRecPrecos;

  TArrDadLivFull = ARray[1..5] of Record
    strClaFis: String;
    strClaFisEntra: String;
    blnSubst: Boolean;
    fltAliquota: Double;
  End;

  TarrDadLiv = Array[1..5] Of Record
    blnSubst: Boolean;
    strClaFis: String;
    fltVlrCon,
    fltAlqIcm,
    fltIsento,
    fltRetido,
    fltBasIpi,
    fltValIpi,
    fltBasRet,
    fltDesAce,
    fltBasIcm,
    fltValIcm,
    fltOutras,
    fltValAnt,
    fltBasAnt,
    fltBaeIpi,
    fltVaeIpi,
    fltBaeRet,
    fltVaeRet,
    fltBFCPST,
    fltVFCPST,
    fltBasFcp,
    fltValFcp: Double;
    fltBasCbs,
    fltVlrCbs,
    fltBasIbs,
    fltVlrIbs,
    fltBas_IS,
    fltVlr_IS: Double;
  End;


  TEfetivarLotePreco = record
    strNumDoc: String;
    strEspDoc: String;
    strSerie: String;
    strCodFor: String;
  End;

  TarrEfetivarLotePreco = array of TEfetivarLotePreco;

  TInputBaixaPedidoTransf = record
    DocOri: String;
    NumPed: String;
    CodEmp: String;
    EspDoc: String;
    NumCtn: String;
  end;
  TfrmRecTransfEstoque = class(TfrmPaiOrdena)
    Label1: TLabel;
    Label2: TLabel;
    dbeMen001: TDBEditFocus;
    dbeMen002: TDBEditFocus;
    dbeCodDig: TDBEditFocus;
    dbeNomDig: TDBEditFocus;
    Label3: TLabel;
    btnGravar: TBitBtnLocked;
    qryPedido: TUniQuery;
    dspPedido: TUniDataSetProvider;
    cdsPedido: TUniClientDataSet;
    btnMarca: TBitBtnLocked;
    btnDesmarca: TBitBtnLocked;
    btnItens: TBitBtnLocked;
    pnlLegendas: TPanel;
    Shape1: TShape;
    Label4: TLabel;
    pnlLegendaColetor: TPanel;
    lblColetor: TLabel;
    shpConferenciaAndamendo: TShape;
    Label5: TLabel;
    shpConferenciaFinalizada: TShape;
    btnConferenciaColetor: TBitBtnLocked;
    mmoNotifica: TMemo;
    pnlLegendaConferencia: TPanel;
    lblConferenciaAguardando: TLabel;
    shpConferenciaAguardando: TShape;
    procedure FormShow(Sender: TObject);
    procedure btnMarcaClick(Sender: TObject);
    procedure btnDesmarcaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure btnItensClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtnLocked1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormDestroy(Sender: TObject);
    procedure btnConferenciaColetorClick(Sender: TObject);
    procedure dbgConsultaDblClick(Sender: TObject);
  private
    FstrFatGor: String;
    FblnCOFTRA: Boolean;
    strAutIncCadFis: String;

    frmGravando: TfrmGravando;

    strIdeDig : String;

    arrDuplicata: TarrDuplicata;
    recTotais: TRecTotais;
    blnSubstituido: Boolean;
    arrDadLivFull: TarrDadLivFull;
    blnZerIcL,
    blnAtpRau,
    blnAtpRen,
    blnGerarLotePrecos,
    blnUsaRotinaWms: Boolean;
    objConEnt: TRecConferEntrada;
    blnGarantia: Boolean;
    blnFornecedorIndustria: Boolean;
    blnEmpresaIndustria : Boolean;
    blnDeIndustriaParaRevenda: Boolean;
    blnDedIcm: Boolean;
    blnAtuUlt,
    blnGerouLotePrecos,
    blnAtuMed: Boolean;
    blnSimPau: Boolean;
    strForNE: String;
    strAgrupadorPreAlt: String;
    fltOscMed: Double;
    fltOscila: Double;

    intDeqTpc: Integer;

    blnLibPcm,
    blnAtuIcE: Boolean;
    blnAtuIpi: Boolean;
    blnAtuSub: Boolean;
    blnAtuIcS: Boolean;
    blnMarNeg: Boolean;
    blnNumSer,
    blnEntEnd: Boolean;

    arrEfetivarLotePreco : TarrEfetivarLotePreco;

    strMedEmp,
    strEmpMeds: String;

    blnATPVMB: array[1..7] of Boolean;

    cpcParams: TParCalculaPrecoCusto;
    objFatPre: TFatorPreco;

    objLotePrecos: TLotePrecos;
    objLock : TLock;

    blnCotDor: Boolean;

    objEnderecamento: TEnderecamentoProduto;

    intESTFLJ: Integer;

    strForFil: String;

    qryMovDet: TZClient;

    qryIteGer,
    qryGenMer: TUniQuery;
    dtaDtaEnt: TDate;

    strCodCta,
    strEstFor,
    strAutInc,
    strNumDoc,
    strEspDoc,
    strCodEmp,
    strSerie,
    strCodFor,
    strCndPag,
    strCodOpe,
    strCodVen,
    strCodDig,
    strCodRep,
    strClaFis,
    strClaFisDet,
    strNumPed,
    strEmpPed,
    strArqMovGer,
    strArqTabDetOri,
    strAutIncTmp,
    strEmpresas,
    strAutIncPedDet,
    strAutIncPed,
    strNumPedVen,
    strCodCliPed,
    strCnvEmb: String;
    strSONCEE: String;

    objCadLot: TCadLot;

    blnSaldoPendente,
    blnContribuinteIPI,
    blnBaixaCTPAVista,
    blnImprCP: Boolean;

    fltTotPis:    Double;
    fltTotBasPis: Double;
    fltTotAlqPis: Double;
    fltTotCof:    Double;
    fltTotBasCof: Double;
    fltTotAlqCof: Double;

    fltPreUlt,
    fltPreUltImp: Double;

    intTamNumDoc,
    intQtdeItensLotPre : Integer;

    pgbGravando : TcxProgressBar;
    stlMarcadosDeConfirmacao : TStringList;
    blnExiApl: Boolean;
    qryCFOPDoc: TUniQuery;
    strNomFor: String;
    objOrdPro: TOrdPro;

    objAuditoriaSaldo: IAuditoriaGravacaoSaldo;
    objLogCancelamento : TLogCancelamento;
    procedure BaixarPedidoTransferencia(input: TInputBaixaPedidoTransf);
    procedure pCarregaCFOPS(strAutoincrem: String; strTabela: String);
    procedure pLimparArrDadLivFull;
    Function fLocalizaDadLivFull(strCfo: string; strAlq: Double): Integer;
    Function fChecaChaveAcesso: Boolean;
    function fCancelaContasPagar(strNumDoc, strCodFor, strSerie: String): Boolean;

    Function fVerificaCadastroItens: Boolean;
    Function fProsseguir: Boolean;
    Function fMontaDuplicatas(fltValor, fltImpostos: Double; blnVlrPreDef: Boolean = False): Boolean;
    Function fGeraEntradaMercadorias(pgbProgresso: TcxProgressBar): Boolean;
    Function fGeraEntrada(intIndice: Integer): Boolean;

    Function fGeraEntradaEspecial(intIndice: integer): Boolean;
    Function fValorContabil_Igual_ValorParcelas: Boolean;
    Function fBaixaNotaConf: Boolean;
    Function fGravaNotGerEsp: Boolean;
    Function fGravaNotDetEsp: Boolean;
    Function fGravaCadFisEsp: Boolean;
    Function fGravaFinanceiroEsp: Boolean;
    function fCalculaValDup(AVrNF, ATotDupTE, ADupAberta: Double): Double;

    Function fTemMargemNegativa(recPrecos: TarrPrecos): Boolean;
    Function fValidaConfirmacaoTransfEstoque: Boolean;

    Procedure pIncluiMargemNegativa(cdsMarNeg: TZClient; recPrecos: TarrPrecos; fltPreCus: Double);

    Function fGravaMovGer: Boolean;
    Function fAtualizaMovGer(arrDadLiv: TarrDadLiv): Boolean;
    Function fGravaMovDet(blnTesteMargem: Boolean = False; blnOscilacaoPrecoMedio: Boolean = False): Boolean;
    Function fTemMamoreNaEntradasSimplificada: Boolean;
    Function fRetNumLot(blnTemPedidoEnderecamento: Boolean): String;

    Function fGravaFatDor: Boolean;
    Function fGravaFatGor: Boolean;

    Function fGravaFinanceiro: Boolean;

    Function fGeraLotePrecos(recPrecos: TarrPrecos;
                              fltPreCus: Double;
                              blnAltPre: Boolean;
                              fltPreCom,
                              fltAlqIcm: Double): Boolean;

    procedure pRecalculaPrecos(Var recPrecos: TarrPrecos;
                               Var fltPreCus: Double;
                               Var blnAltPre: Boolean;
                               fltPreCom,
                               fltAlqIcm: Double;
                               blnZeraIcms: Boolean = False);

    Function fAtualizaProduto(strNumLot: String; var blnAtualizouPreMed : Boolean;
                              Var recPrecos: TArrPrecos;
                              Var fltPreCom, fltPreCus, fltPreMedNov: Double;
                              Var  blnAltPre, blnAtualizouPreco: Boolean;
                              blnTesteMargem: Boolean;
                              CalculoPrecoMediAgrup: TCalculoPrecoMediAgrup): Boolean;

    Function fAtualizaPedido: Boolean;
    function fRetSQMovDet: String;
    Function fGravaCadFis: Boolean;
    Function fTrocaClaFis(strClaFis: String; blnSubst: Boolean = False): String;
    Function fCarregaConfig: Boolean;
    Function fCarregaConfigEmpresa: Boolean;
    Function fRetLivro(Var recTotais: TRecTotais): Boolean;
    function fVerificaTransfBaixada(strNumDoc, strEspDoc, strCodEmp,
      strCodCli, strSerie: String): Boolean;
    Function fVerificaConfBaixada(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;

    Function fRetTotalDuplicatasAbertas(strNumDoc, strEspDoc, strCodEmp, strCodFor: String): Double;
    Function fRetTotalDuplicatas(strNumDoc, strEspDoc, strCodEmp, strCodFor: String): Double;

    Function fSQLSomaDuplicatas(AApenasBaixada : Boolean = True): String;
    Function fSQLWhereDuplicatas(AApenasBaixada : Boolean = True): String;
    Function fSQLNotasConfirmadas: String;

    procedure pValidarLotesADefinir;

    function fGerarPedidosReservaEstoque(strDocEnt, strEspEnt, strSerEnt, strForEnt: String;
                                         Var blnGerarPedido: Boolean): Boolean;

    procedure pAbreMovDet(strTabela: String);
    procedure pCarregaFornecedor(strFornec: String);
    procedure pCarregaEmpresaIndustria;
    Procedure pAbreItensNota(qryIteNot: TUniQuery; blnTesCad: Boolean = False);
    Procedure pCriaLivroFiscal(qryGenFis: TUniQuery; Var arrDadLiv: TarrDadLiv);
    function fTabTri(strTabela: String): String;

    function fVerificaDocumentoExiste: String;
    Function fRetAutoincMovGer(strNumDoc, strCodFor, strSerie: String): String;
    Function fRealizaEntradaConferencia: Boolean;
    Function fGravaEntradas: Boolean;

    Procedure pFaturaNotasConfirmadas(strNumDoc, strSerie_, strCodFor, strNumFat, strTipFat: String);
    Procedure pSalvaDuplicatasConfirmadas(strAutInc, strNumDup, strCodFor, strSerie: String);
    Procedure pSelecionaCTPDET(qryCadPag, qryCtpDet: TUniQuery);

    Procedure pAtualizaPisCofinsMovGer(strSeqGer: String);
    Procedure pAtualizaPreco(recPrecos: TArrPrecos;  fltPreCom, fltPreCus: Double);
    function fGravaAgendamentoDeRecebimento(intIndice: Integer): Boolean;
    function fGeraAgendamento: Boolean;
    function fValidaTransportadoraAgendamento: Boolean;
    function fRetTransportadoraAgendamento: String;
    function fVerificaConferenciaColetor: boolean;
    {function fValidaLotesProdutosWMSComColetor: Boolean;}
    function fTranferenciaAutomaticaFulfillment: Boolean;
    function fExisteDocumento(strNumDoc, strEspDoc, strSerie_, strCodFor, strCodEmp : String): Boolean;

    function fMovimentaSubItemEmpCar(qryDados: TDataSet): Boolean;
    function fMovimentaSubItemEmpFul(qryDados: TDataSet): Boolean;

    function fGeraOrdemProducaoSubItem(strNumDoc, strEspDoc, strCodIte: String; fltQtdIte: Double): Boolean;

    procedure pRealizaEntradaAutomatica;
    function fEfetivaMvtoFiscal: Boolean;
    function fRetReaEnd(strCodIte: String): Boolean;
    function fCriaNumerosDeSerieEntrada(AStrAutIncMovDetGravada: String): Boolean;
    function fValidouSituacaoFiscalDoDocumento : Boolean;

    function fIniciaConferencia(strAutoIncrem: string): Boolean;
    function fFinalizaConferencia(strAutoIncrem: string): Boolean;
    function fGravaItensConferencia(objConEnt: TRecConferEntrada; strAutoincrem: string): Boolean;
    function fSomenteConferencia(strAutoIncrem, strTipSenha, strTabela: string): Boolean;
    function fConverteIncremConferencia(strAutoIncrem, strTipSenha, strTabela: string): string;
    function fGeraPlanoRecebimentoAutomatico(intIndice: Integer): Boolean;
    function fGravarDigCon: Boolean;
    function fAutoincremFatGor: String;
    function fTabRef(strTabela: String): String;
    procedure pCarregaRefTribItemOrigem(const strSeqDetOri: String;
      var objRef: TMovDetParams);
    procedure pCarregaTotaisReformaOrigem(var fltTotIbs, fltTotCbs, fltTotIs,
      fltTotProIs, fltTotNf: Double);
    { Private declarations }
  protected
    stlListaMovGer: TStringList;
    blnMarmore: Boolean;
    strIncAge: String;
    procedure pAddListaQuery; Override;
    function fGetSql(blnLike: Boolean): String; Override;
  public
    { Public declarations }
    objEntradaSimplificada: TEntradaSimplificada;
    blnFecharForm: Boolean;

    blnEntradaOk: boolean;
    strAutincrem,
    strMensagem: String;

    blnRealizarEntrada: Boolean;
    blnRealizarConferencia: Boolean;
    blnSomenteConferencia: Boolean;
    procedure pFormShow(Sender: TObject);

  end;

  ExceptionLotesADefinir = class(Exception);

var
  frmRecTransfEstoque: TfrmRecTransfEstoque;

implementation
{$R *.dfm}
uses  untPai, StrUtils,
      untPreAlt, untCadPag, untMovGer, untCadIte, untCadFis,untProdAcabado,
      untNotGer, untConstantes, untFuncoesAuxiliares, untRecTransfDivergencias,
      untCalculoPisCofins, untFuncTinta, untTConfiguracao,untFuncoes,
      untCalculoUltimaCompraImpostos, System.UITypes,
      untRecTransfEstoqueConfer, untFatGor, untGarant, untQckLiberacaoArmazenamento,
      untDuplicatas, untFuncoesSimples, untProdMargemNegativa,
      untDefineBaixaPedido, untManutencaoConferenciasEntradaSimplificadaColetor,
      untTypesCRM, untAtualizaOcorrenciasCRM, untModulo,
      untFuncoesRel, untFuncoesRel2, untEntradaValidacoes,
      untLotePrecosEfetivacaoCx, untPlanoDeRecebimento, untTNumeroSerie;


function TfrmRecTransfEstoque.fGetSql(blnLike: Boolean): String;
begin
  Result := objEntradaSimplificada.fGetSql(blnLike);
end;

procedure TfrmRecTransfEstoque.FormShow(Sender: TObject);
begin
  inherited;

  pFormShow(Sender);

end;

procedure TfrmRecTransfEstoque.pFormShow(Sender: TObject);
begin
  inherited;

  If Not blnFecharForm Then
  Begin
    if fCfgSis('CONSIM', varString) = 'C' then
    begin
      lblColetor.Visible := True;
      dbgConsulta.Columns[0].Visible := True;
      pnlLegendaColetor.Visible := True;
      btnConferenciaColetor.visible := True;
    end
    else
    begin
      lblColetor.Visible := False;
      dbgConsulta.Columns[0].Visible := False;
      pnlLegendaColetor.Visible := False;
      btnConferenciaColetor.visible := False;
    end;

    pnlLegendaConferencia.Visible := fCfgSis('EMSRCS', varBoolean);

    blnSempreRelerBanco := False;
    blnQuoteLista       := False;

    If  objEntradaSimplificada.recAutEntTe.blnPedidoCompra Then
    Begin
      lflLastField.intIndCol := 1;
      lflLastField.strNomCam := dbgConsulta.Columns[1].FieldName;
      lflLastField.strNomCol := dbgConsulta.Columns[1].Title.Caption;
      lflLastField.ftyTipCam := ftDateTime;
    End;

    fAbreConsulta(True);

    If objEntradaSimplificada.recAutEntTe.blnAutEnt Then
    Begin
      try
        btnDesmarca.Click;
        If cdsConsulta.Locate('GER_NUMDOC;GER_ESPDOC;GER_CODEMP;',
                              VarArrayOf([objEntradaSimplificada.recAutEntTe.strDocOri,
                                          objEntradaSimplificada.recAutEntTe.strEspOri,
                                          objEntradaSimplificada.recAutEntTe.strEmpOri]), []) Then
        Begin
          pAddListaQuery;
          BitBtnLocked1Click(Sender);
        End;
      Except
        On E: Exception Do
        Begin
          If fTranferenciaAutomaticaFulfillment Then
            strMensagem := E.Message
          Else
            pMensagensErro(E.Message, '[TfrmRecTransfEstoque.FormShow]');
        End;
      end;
      blnFecharForm := True;
    End

    Else If (Not strAutincrem.IsEmpty) Then
      pRealizaEntradaAutomatica;

  End;

end;

procedure TfrmRecTransfEstoque.pRealizaEntradaAutomatica;
Begin

  Try
    btnDesmarca.Click;

    If (not cdsConsulta.Locate('AUTOINCREM', strAutincrem, [])) And (fCfgSis('EMSRCS', varBoolean)) Then
      strAutincrem := fConverteIncremConferencia(strAutincrem, EmptyStr, EmptyStr);

    If cdsConsulta.Locate('AUTOINCREM', strAutincrem, []) Then
    Begin
      blnSomenteConferencia := fSomenteConferencia(strAutincrem, cdsConsulta.FieldByName('TIPSEN').AsString, cdsConsulta.FieldByName('TABELA').AsString);

      If blnRealizarEntrada Then
      Begin
        pAddListaQuery;

        If fInLista Then
          btnGravar.Click;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmRecTransfEstoque.pRealizaEntradaAutomatica]');
    End;
  end;

  blnFecharForm := blnRealizarEntrada;

End;

procedure TfrmRecTransfEstoque.btnMarcaClick(Sender: TObject);
var
  strConCol : String;
begin
  inherited;

  if fCfgSis('CONSIM', varString) = 'C' then
  begin
    case fGetMenu('Selecione o tipo de documentos que deseja marcar:', ['Conferidos no coletor', 'Não conferidos'], 1) of
      1: strConCol := 'F';
      2: strConCol := 'N';
    end;
  end
  else
    strConCol := 'N';

  stlListSelecao.Clear;
  objLock.pDestravarTodos;

  With cdsConsulta Do
  Begin

    DisableControls;
    First;

    While Not Eof Do
    Begin
      if fieldByName('CONCOL').AsString = strConCol then
        pAddListaQuery;
      Next;
    End;

    EnableControls;

  End;

  dbgConsulta.Repaint;
end;

procedure TfrmRecTransfEstoque.dbgConsultaDblClick(Sender: TObject);
begin
  blnSomenteConferencia := fSomenteConferencia(cdsConsulta.FieldByName('AUTOINCREM').AsString, cdsConsulta.FieldByName('TIPSEN').AsString, cdsConsulta.FieldByName('TABELA').AsString);

  inherited;
end;

procedure TfrmRecTransfEstoque.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
//  inherited;

  If Column.Index = lflLastField.intIndCol then
  Begin
    dbgConsulta.Canvas.Brush.Color:= clInfoBk;
    dbgConsulta.Canvas.Font.Color:= clWindowText;
    dbgConsulta.Canvas.FillRect(Rect);
  End;

  With dbgConsulta.Canvas Do
  Begin
    If cdsConsulta.IsEmpty Then
      Exit;

    case AnsiIndexStr(cdsConsulta.FieldByName('CONCOL').AsString, ['A','F']) of
      0: begin
           Brush.Color := shpConferenciaAndamendo.Brush.Color;
           Font.Color := clWindowText;
         end;
      1: begin
           Brush.Color := shpConferenciaFinalizada.Brush.Color;
           Font.Color := clWindowText;
         end;
    end;

    if fCfgSis('EMSRCS', varBoolean) then
    begin
      if cdsConsulta.FindField('BAIXADO') <> nil then
      begin
        if (cdsConsulta.FieldByName('CONCOL').AsString = 'A') And (cdsConsulta.FieldByName('BAIXADO').AsInteger = 1) then
        begin
          Brush.Color := shpConferenciaAguardando.Brush.Color;
          Font.Color := clWindowText;
        end;
      end;
    end;

    If (blnTemSelecao Or (stlListSelecao.Count > 0)) And fInLista Then
    Begin

      If Brush.Color = clHighLight Then
      Begin
        Font.Color := clHighLightText;
      End Else
      Begin
        Brush.Color := intCorSelecao;
      End;

    End

    Else If (SameText(cdsConsulta.FieldByName('TABELA').AsString, 'NOTGER')) And
            (fEmptyStr(cdsConsulta.FieldByName('PCG_NUMPED').AsString)) Then
    Begin
      Brush.Color := clSkyBlue;
    End;

  End;

  dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmRecTransfEstoque.btnConferenciaColetorClick(Sender: TObject);
begin
  inherited;
  if btnConferenciaColetor.visible then
  begin
    pCriarForm(TfrmManutencaoConferenciasEntradaSimplificadaColetor);
    cdsConsulta.Refresh;
  end;
end;

procedure TfrmRecTransfEstoque.btnDesmarcaClick(Sender: TObject);
begin

  inherited;
  stlListSelecao.Clear;
  objLock.pDestravarTodos;

  dbgConsulta.Repaint;
  cdsConsulta.First;
end;

procedure TfrmRecTransfEstoque.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_RETURN Then
    blnSomenteConferencia := fSomenteConferencia(cdsConsulta.FieldByName('AUTOINCREM').AsString, cdsConsulta.FieldByName('TIPSEN').AsString, cdsConsulta.FieldByName('TABELA').AsString);

  inherited;
  Case Key Of
    VK_F6 : btnItens.Click;
    VK_F7 : btnMarca.Click;
    VK_F8 : btnDesmarca.Click;
    VK_F10: btnGravar.Click;
    VK_F9 : btnConferenciaColetor.Click;
  End;
end;

procedure TfrmRecTransfEstoque.btnGravarClick(Sender: TObject);
begin
  inherited;


end;

{************************************************}
{* MOSTRA OS ITENS DO REGISTRO SELECIONADO      *}
{*********************************************LA*}
procedure TfrmRecTransfEstoque.btnItensClick(Sender: TObject);
begin
  inherited;

  If cdsConsulta.IsEmpty Or (Not cdsConsulta.Active) Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
  begin
      prcExecutaRelatorio(113, 5884, [5885],
                          ['NUMDOC','ESPDOC','CODEMP','CODCLI','CODFOR','OPCREL'],
                          [cdsConsulta.FieldByName('GER_NUMDOC').AsString,
                          cdsConsulta.FieldByName('GER_ESPDOC').AsString,
                          cdsConsulta.FieldByName('GER_CODEMP').AsString,
                          IfThen(cdsConsulta.FieldByName('TIPSEN').AsString = 'DEVOLU','',cdsConsulta.FieldByName('GER_CODCLI').AsString),
                          cdsConsulta.FieldByName('GER_CODFOR').AsString,
                          IfThen(SameText(cdsConsulta.FieldByName('TABELA').AsString,'MOVGER'),IfThen(blnExiApl,'1','3'),IfThen(blnExiApl,'2','4'))],
                          Sender,
                          nil,
                          True);
  End;

end;

Function TfrmRecTransfEstoque.fGravaNotGerEsp: Boolean;
  Var
    recServicos: TDadosServicos;
Begin
  FillChar(recTotais, SizeOf(recTotais), #0);
  FillChar(recServicos, SizeOf(recServicos), #0);

  strCodOpe := strLoginUsuarioLogado;
  strCodDig := strLoginUsuarioLogado;
  strCodRep := strLoginUsuarioLogado;
  strCodVen := strLoginUsuarioLogado;

  With cdsConsulta, recTotais Do
  Begin
    strArqMovGer := 'NOTGER';

    strForNe     := fCampoTabela('EMP_FORFIL','CADEMP',['EMP_CODEMP'],[FieldByName('GER_CODEMP').AsString]);

    strNumDoc    := fStrZero(FieldByName('GER_NUMDOC').AsString, intTamNumDoc);
    strEspDoc    := FieldByName('GER_ESPDOC').AsString;
    strSerie     := FieldByName('GER_SERIE_').AsString;

    fltDesEsp    := FieldByName('GER_DESESP').AsFloat;
    fltTotIte    := FieldByName('GER_TOTPRO').AsFloat;
    fltValFre    := FieldByName('GER_TOTFRE').AsFloat;
    fltVlrCon    := FieldByName('GER_VLRCON').AsFloat;


    pCarregaFornecedor(strForNE);
    pCarregaEmpresaIndustria;
    blnDeIndustriaParaRevenda := (blnFornecedorIndustria And (Not blnEmpresaIndustria));

    If fTranferenciaAutomaticaFulfillment Then
      pCarregaCFOPS(cdsConsulta.FieldByName('AUTOINCREM').AsString,  'NOTDET')
    Else
    strClaFis := fTrocaClaFis(FieldByName('GER_CLAFIS').AsString);

    If (Not fRetLivro(recTotais)) Then
    Begin
      Result := False;
      Exit;
    End;

    Result := fGravaNotGer(strAutInc,                                                  // Auto incremento (Retorno)
                           VS_strCodEmp,                                               // Empresa
                           strNumDoc,                                                  // Documento
                           strEspDoc,                                                  // Especie
                           '',                                                         // Cliente
                           '',                                                         // Transportadora
                           strCodVen,                                                  // Vendedor
                           strSerie,                                                   // Série
                           VS_Date,                                                    // Data de Entrada
                           fTime(),                                                    // Hora de Entrada
                           strCndPag,                                                  // Condição de Pagamento
                           strEstFor,                                                  // Estado
                           '',                                                         // Nome Consumidor
                           '',                                                         // Endereço Consumidor
                           '',                                                         // Bairro Consumidor
                           '',                                                         // Cep Consumidor
                           '',                                                         // Cidade Consumidor
                           '',                                                         // Estado Consumidor
                           '',                                                         // Telefone Consumidor
                           0,
                           '',                                                         // CNPJ / CPF Consumidor
                           '',                                                         // Número CNPJ Consumidor
                           '',                                                         // IES Consumidor
                           '',                                                         // Rg
                           0,                                                          // Base Simples Paulista
                           fltBasIpi,                                                  // Base IPI
                           0,                                                          // Alíquota IPI
                           fltTotIpi,                                                  // Total IPI
                           fltBasIcm,                                                  // Base ICMS
                           0,                                                          // Alíquota ICMS
                           fltTotIcm,                                                  // Total ICMS
                           fltValRet,                                                  // Total Retido
                           0,                                                          // Alíquota Retido
                           fltBasRet,                                                  // Base Retido
                           0,                                                          // Base Retido Simulado
                           fltDesEsp,                                                  // Desconto Especial
                           fltVlrCon,                                                  // Valor Contábil
                           fltTotIte,                                                  // Total Produtos
                           FieldByName('GER_TOTCUS').AsFloat,                          // Total de Custo
                           0,                                                          // Total Médio
                           '2',                                                        // Tipo de Frete
                           fltValFre,                                                  // Total de Frete
                           0,                                                          // Peso bruto
                           0,                                                          // Peso líquido
                           0,                                                          // Volume
                           '',                                                         // Espécie
                           '',                                                         // Marca
                           '',                                                         // Mensagem 1
                           '',                                                         // Mensagem 2
                           '',                                                         // Mensagem 3
                           '',                                                         // Mensagem 4
                           '',                                                         // Mensagem 5
                           False,                                                      // Ja Faturado
                           '',                                                         // Tipo Faturamento
                           '',                                                         // Número Faturamento
                           '',                                                         // Empresa do Faturamento
                           0,                                                          // Data Faturamento
                           '',                                                         // Vendedor do Faturamento
                           '',                                                         // Condição de Pagamento
                           0.0,                                                        // Valor do Faturamento
                           'S',                                                        // Nota Especial
                           arrDuplicata[00].curValor,                                  // Valor da 01a Parcela
                           arrDuplicata[01].curValor,                                  // Valor da 02a Parcela
                           arrDuplicata[02].curValor,                                  // Valor da 03a Parcela
                           arrDuplicata[03].curValor,                                  // Valor da 04a Parcela
                           arrDuplicata[04].curValor,                                  // Valor da 05a Parcela
                           arrDuplicata[05].curValor,                                  // Valor da 06a Parcela
                           arrDuplicata[06].curValor,                                  // Valor da 07a Parcela
                           arrDuplicata[07].curValor,                                  // Valor da 08a Parcela
                           arrDuplicata[08].curValor,                                  // Valor da 09a Parcela
                           arrDuplicata[09].curValor,                                  // Valor da 10a Parcela
                           arrDuplicata[10].curValor,                                  // Valor da 11a Parcela
                           arrDuplicata[11].curValor,                                  // Valor da 12a Parcela
                           arrDuplicata,                                               // arrDuplic
                           IIf(fTranferenciaAutomaticaFulfillment, ArrDadLivFull[1].strClaFisEntra ,strClaFis), // Classificação Fiscal
                           IIf(fTranferenciaAutomaticaFulfillment, ArrDadLivFull[2].strClaFisEntra, ''), // Classificação Fiscal 2
                           IIf(fTranferenciaAutomaticaFulfillment, ArrDadLivFull[3].strClaFisEntra, ''), // Classificação Fiscal 3
                           fRetDesCla(strClaFis),                                      // Natureza da Operação
                           0,                                                          // Percentual de Desconto
                           strCodDig,                                                  // Código do Digitador
                           '',                                                         // Código da Condicao
                           '',                                                         // Código da Forma de Pagamento
                           0,                                                          // Fator Para meia nota
                           recServicos,
                           fltDesAce,                                                  // Despesa Acessória
                           '',                                                         // Origem do Documento
                           'F',                                                        // Tipo: (C)liente (F)ornecedor
                           strForNE,                                                   // Código do Fornecedor
                           0,                                                          // Aliquota do IRPF (SERVIÇO)
                           0,                                                          // Valor do IRPF (SERVIÇO + PRODUTO)
                           0,                                                          // Aliquota do Pis (SERVIÇO)
                           0,                                                          // Valor do Pis (SERVIÇO + PRODUTO)
                           0,                                                          // Aliquota do Cofins (SERVIÇO)
                           0,                                                          // Valor do Cofins (SERVIÇO + PRODUTO)
                           0,                                                          // Aliquota do CSLL (SERVIÇO)
                           0,                                                          // Valor do CSLL (SERVIÇO + PRODUTO)
                           0,                                                          // Valor de IRPF que foi retido
                           0,                                                          // Valor de PIS que foi retido
                           0,                                                          // Valor de COFINS que foi retido
                           0,                                                          // Valor de CSLL que foi retido
                           '',                                                         // Notas de Documentos Acumulados
                           0,                                                          // Aliquota do IRPF (PRODUTOS)
                           0,                                                          // Aliquota do PIS (PRODUTOS)
                           0,                                                          // Aliquota do COFINS (PRODUTOS)
                           0,                                                          // Aliquota do CSLL (PRODUTOS)
                           0,                                                          // Valor de SERVIÇO que foi retido
                           '',                                                         // Notas de documentos acumulados (SERVIÇO)
                           0,                                                          // Percentual da Seguridade Social
                           0,                                                          // Valor da Seguridade Social
                           0,                                                          // Valor do IRPF Retido (Produto)
                           0,                                                          // Valor do IRPF Devido (Produto)
                           0,                                                          // Valor do IRPF Retido (Serviço)
                           0,                                                          // Valor do IRPF Devido (Serviço)
                           0,                                                          // Valor do PIS Retido (Produto)
                           0,                                                          // Valor do PIS Devido (Produto)
                           0,                                                          // Valor do PIS Retido (Serviço)
                           0,                                                          // Valor do PIS Devido (Serviço)
                           0,                                                          // Valor do COFINS Retido (Produto)
                           0,                                                          // Valor do COFINS Devido (Produto)
                           0,                                                          // Valor do COFINS Retido (Serviço)
                           0,                                                          // Valor do COFINS Devido (Serviço)
                           0,                                                          // Valor do CSLL Retido (Produto)
                           0,                                                          // Valor do CSLL Devido (Produto)
                           0,                                                          // Valor do CSLL Retido (Serviço)
                           0,                                                          // Valor do CSLL Devido (Serviço)
                           0,                                                          // Valor ja recebido na confirmação
                           0,                                                          // Valor do adiantamento
                           0,                                                          // Base Orgão Público
                           0,                                                          // ICMS Orgão Publico
                           0,                                                          // Número do Conhecimento de Frete
                           'N',                                                        // Entrega no faturamento
                           '',                                                         // Cliente de Faturamento
                           '',                                                         // Operador da Expedição
                           0,                                                          // Base do retido (caso tivesse) com ipi e frete de entrada
                           0,                                                          // Valor do retido considerando a base acima.
                           '',                                                         // Numero do Registro - Correios ou transportadora
                           0,                                                          // Sequencial para identificação de grupos de notas
                           IIf(fTranferenciaAutomaticaFulfillment, ArrDadLivFull[4].strClaFisEntra, ''),  // Classificação fiscal 4
                           '',                                                         // Evento
                           '',                                                         // AUTINC DO ENDEREÇO DE ENTREGA
                           '',                                                         // Conteúdo do CNFNFE
                           '',                                                         // Consumidor Final
                           0,
                           0,
                           0,                                                          // Data de Saida da Nota Fiscal (Eletronica)
                           0,                                                          // Hora de Saida da Nota Fiscal (Eletronica)
                           Nil,                                                        // Codigo da Financeira
                           0,                                                          // Imprime Duplicatas Confirmidas em Cupom Fiscal
                           '',          //strCodObr
                           '',          //strCodArt
                           '',          //strRetIss
                           '',          //strOpcDoc
                           fltBasAnt,
                           fltValAnt);  //VALOR DE ICMS ANTECIPADO


  End;

End;

function TfrmRecTransfEstoque.fIniciaConferencia(strAutoIncrem: string): Boolean;
Var
  qryInsert: TUniQuery;
  strAutIncremConger: string;
Begin
  qryInsert := fCriaQuery;

  try
    try
      qryInsert.SQL.Add('SELECT AUTOINCREM FROM CONDOC WHERE DOC_SEQGER = :SEQGER');
      qryInsert.ParamByName('SEQGER').AsString := strAutoIncrem;
      qryInsert.Open;

      if not qryInsert.IsEmpty then
        Exit(False);

      qryInsert.Close;
      qryInsert.SQL.Clear;
      qryInsert.SQL.Add('INSERT INTO CONGER (AUTOINCREM,');
      qryInsert.SQL.Add('GER_OPEINI, GER_DTAINI,');
      qryInsert.SQL.Add('GER_CODEMP, GER_CODCON) VALUES (');
      qryInsert.SQL.Add(':INCREM, :OPEINI, :DTAINI, :CODEMP, :CODCON)');

      strAutIncremConger := fRetAutoIncrem('CONGER', VS_strCodEmp);
      qryInsert.ParamByName('INCREM').AsString := strAutIncremConger;
      qryInsert.ParamByName('OPEINI').AsString := strLoginUsuarioLogado;
      qryInsert.ParamByName('DTAINI').AsDateTime := fNow();
      qryInsert.ParamByName('CODEMP').AsString := strCodEmp;
      qryInsert.ParamByName('CODCON').AsString := fAtualizaProCod('DIGELE', 'GER_CODCON', 'CONGER');

      qryInsert.ExecSQL;

      Result := qryInsert.RowsAffected > 0;

      if Result then
      begin
        qryInsert.Close;
        qryInsert.SQL.Clear;
        qryInsert.SQL.Add('INSERT INTO CONDOC (AUTOINCREM,');
        qryInsert.SQL.Add('DOC_SEQCON, DOC_SEQGER) VALUES (');
        qryInsert.SQL.Add(':INCREM, :SEQCON, :SEQGER)');

        qryInsert.ParamByName('INCREM').AsString := fRetAutoIncrem('CONDOC', VS_strCodEmp);
        qryInsert.ParamByName('SEQCON').AsString := strAutIncremConger;
        qryInsert.ParamByName('SEQGER').AsString := strAutoIncrem;

        qryInsert.ExecSQL;

        Result := qryInsert.RowsAffected > 0;
      end;
    Except
      On E: Exception Do
      Begin
        Result := False;
        If fTranferenciaAutomaticaFulfillment Then
          strMensagem := E.Message
        Else
          pMensagensErro(E.Message, '[TfrmRecTransfEstoque.FormShow]');
      End;
    End;
  finally
    begin
      FreeAndNil(qryInsert);
    end;
  end;
end;

Function TfrmRecTransfEstoque.fGravaNotDetEsp: Boolean;
Var CalcResult: TResultPisCofins;
    tmp: TCalculoPisCofins;
    intContador3: Integer;
    fltValIcm,
    fltAlqIcm,
    fltBasIcm,
    fltISEICM,
    fltOutIse,
    fltOutIcm: Double;
    strSitP_C: String;
    objExcecaoCfopCst: TCfgCfopCst;
    blnIsentas: Boolean;
Begin
  Result := False;

  fltTotPis := 0;
  fltTotCof := 0;
  fltTotBasPis := 0;
  fltTotBasCof := 0;

  pAbreMovDet('NOTDET');

  pgbGravando.Properties.Max := qryMovDet.RecordCount + 2; // Baixar + CadFis;

  strSitP_C := fDefineSit_P_C(VS_strCodEmp, strCodFor);


  With qryMovDet Do
  While (Not Eof) Do
  Begin
    strClaFisDet := '';
    If fTranferenciaAutomaticaFulfillment Then
    Begin
      intContador3 := fLocalizaDadLivFull(FieldByName('DET_CLAFIS').AsString, FieldByName('DET_ALQICM').AsFloat);
      strClaFisDet := ArrDadLivFull[intContador3].strClaFisEntra;
    End;
    If strClaFisDet = '' Then
    strClaFisDet := fTrocaClaFis(FieldByName('DET_CLAFIS').AsString);

    tmp := TCalculoPisCofins.Create;
    tmp.blnGerarException := True;


    CalcResult := tmp.fCalculoPisCofins(VS_strCodEmp,FieldByName('DET_CODITE').AsString,
                                        strClaFisDet,
                                        FieldByName('DET_CODFIS').AsString,
                                        strCodFor,IIf(fCfgSis('SIMPAU',varBoolean)and (fCfgSis('IGNSIM') = '1'), 'S', 'N'),
                                        strEspDoc,FieldByName('DET_TOTITE').AsFloat,
                                        FieldByName('DET_DESESP').AsFloat,FieldByName('DET_VALIPI').AsFloat,
                                        FieldByName('DET_VALRET').AsFloat + IIf(FieldByName('DET_VALRET').AsFloat > 0, FieldByName('DET_VFCPST').AsFloat, 0),
                                        FieldByName('DET_TOTFRE').AsFloat,
                                        FieldByName('DET_DESACE').AsFloat,
                                        FieldByName('DET_VALICM').AsFloat,
                                        0,
                                        'F',FieldByName('DET_INCPIS').AsString, strSitP_C, '',
                                        dtaDtaEnt,
                                        '',
                                        False,
                                        False,
                                        '',
                                        '',
                                        '',
                                        '',
                                        False,
                                        FieldByName('DET_CODFIS').AsString,
                                        FieldByName('DET_VALICM').AsFloat);



    tmp.Destroy;

    Result := CalcResult.blnResult;

    If Not Result Then
      Break;

    If CalcResult.dblBasePis > 0 Then
    Begin
      fltTotAlqPis := CalcResult.dblAlqPis;
      fltTotAlqCof := CalcResult.dblAlqCof;
    End;

    fltTotBasPis := fltTotBasPis + CalcResult.dblBasePis;
    fltTotBasCof := fltTotBasCof + CalcResult.dblBaseCof;
    fltTotPis := fltTotPis + CalcResult.dblValorPis;
    fltTotCof := fltTotCof + CalcResult.dblValorCof;

    blnSubstituido := (Pos(FieldByName('DET_CODFIS').AsString, CST_SUBSTITUICAO) > 0);

    If (blnSubstituido) Or (blnSimPau) Or ((fFornecedorFilial(strCodFor)) And ((fCfgSis('SIMPAU', varBoolean)) And (fCfgSis('IGNSIM') = '1')))
        Or (FieldByName('ITE_DIFICM').AsString = 'S')  Then
    Begin
      fltValIcm := 0;
      fltAlqIcm := 0;
      fltBasIcm := 0;
      fltOutIcm := fRetornaValorOutras(FieldByName('DET_VLRCON').AsFloat,
                                       0,
                                       FieldByName('DET_VALIPI').AsFloat,
                                       FieldByName('DET_VALRET').AsFloat,
                                       FieldByName('DET_VAERET').AsFloat,
                                       FieldByName('DET_VAEIPI').AsFloat,
                                       FieldByName('DET_VFCPST').AsFloat);
      fltISEICM := 0;
    End Else
    Begin
      fltValIcm := FieldByName('DET_VALICM').AsFloat;
      fltAlqIcm := FieldByName('DET_ALQICM').AsFloat;
      fltBasIcm := FieldByName('DET_BASICM').AsFloat;
      fltOutIcm := FieldByName('DET_OUTICM').AsFloat;
      fltISEICM := FieldByName('DET_ISEICM').AsFloat;
    End;

    fltOutIse := fltOutIcm + fltISEICM;

    If fltOutIse > 0 Then
    Begin
      objExcecaoCfopCst := TCfgCfopCst.Create(Nil, True);
      Try
        objExcecaoCfopCst.fCarregaDados;
        If objExcecaoCfopCst.fExcecaoDefinida(strClaFisDet, FieldByName('DET_CODFIS').AsString) Then
          blnIsentas := objExcecaoCfopCst.blnIsentas
        Else
          blnIsentas := fCodFisGravaIsentoDocEnt(strClaFisDet, FieldByName('DET_CODFIS').AsString);
      Finally
        FreeAndNil(objExcecaoCfopCst)
      End;

      If blnIsentas Then
      Begin
        fltISEICM := fltOutIse;
        fltOutIcm := 0;
      End
      Else
      Begin
        fltOutIcm := fltOutIse;
        fltISEICM := 0;
      End;
    end;

   Result := fGravaNotDet(strAutIncTmp,
                           strAutInc,
                           VS_strCodEmp,
                           '',
                           strNumDoc,
                           strEspDoc,
                           strSerie,
                           FieldByName('DET_CODITE').AsString,
                           '',
                           FieldByName('DET_CODMAR').AsString,
                           strCodVen,
                           VS_Date,
                           fTime(),
                           strCndPag,
                           strEstFor,
                           FieldByName('DET_DESCRI').AsString,
                           FieldByName('DET_REFERE').AsString,
                           FieldByName('DET_UNIDAD').AsString,
                           FieldByName('DET_CODFOR').AsString,
                           FieldByName('DET_QTDITE').AsFloat,                              // Quantidade do Item
                           FieldByName('DET_UNITAR').AsFloat,                              // Valor Unitario
                           FieldByName('DET_UNIORI').AsFloat,                              // Valor Unitário Original
                           FieldByName('DET_UNIVIS').AsFloat,                              // Valor Unitário Original sem juros
                           FieldByName('DET_TOTITE').AsFloat,                              // Total do Item
                           FieldByName('DET_VLRCON').AsFloat,                              // Valor Contábil do Item
                           FieldByName('DET_TOTCUS').AsFloat,                              // Valor Total de Custo
                           FieldByName('DET_TOTMED').AsFloat,                              // Valor Total Medio
                           0.0,                                                            // % Desconto do Item
                           FieldByName('DET_TOTFRE').AsFloat,                              // Valor do Frete
                           FieldByName('DET_DESESP').AsFloat,                              // Valor do Desconto Especial
                           FieldByName('DET_DESACE').AsFloat,
                           strCodRep,
                           '',
                           0, //fltPerCom
                           0, //fltTotCom
                           0, //fltTotCo2
                           strClaFisDet,
                           FieldByName('DET_CODFIS').AsString,                             // Código Fiscal
                           FieldByName('DET_VALIPI').AsFloat,                              // Valor IPI
                           FieldByName('DET_ALQIPI').AsFloat,                              // Aliquota IPI
                           FieldByName('DET_BASIPI').AsFloat,                              // Base IPI
                           fltValIcm,                                                      // Valor de ICMS
                           fltAlqIcm,                                                      // Aliquota de ICMS
                           fltBasIcm,                                                      // Base de ICMS
                           FieldByName('DET_VALRET').AsFloat,                              // Valor de Substituição
                           FieldByName('DET_ALQRET').AsFloat,                              // Aliquota de Substituição
                           FieldByName('DET_BASRET').AsFloat,                              // Base de Substituição
                           0.0,                                                            // Total de Peso
                           FieldByName('DET_PERBAS').AsFloat,                              // Percentual de Base de ICMS
                           0,
                           False,
                           '',
                           '',
                           '',  // Empresa do Faturamento
                           0,
                           '',
                           '',
                           0.0,
                           FieldByName('DET_IDEPRO').AsString,
                           FieldByName('DET_INCPIS').AsString,
                           'S',
                           strCodDig,
                           '',
                           '',
                           FieldByName('DET_PROEMB').AsString,
                           FieldByName('DET_ITEEMB').AsString,
                           fRetornaGrupoItem(FieldByName('DET_ITEEMB').AsString),
                           FieldByName('DET_LAZQUA').AsInteger,
                           FieldByName('DET_PROMOC').AsString,
                           '',
                           0.0,
                           '',
                           'F',
                           strForNE, // strCodFor
                           FieldByName('DET_QTDEMB').AsFloat,
                           FieldByName('DET_PREEMB').AsFloat,
                            '',
                           FieldByName('DET_BCAMIN').AsFloat,
                           FieldByName('DET_BCACOM').AsFloat,
                           FieldByName('DET_VOLPRO').AsFloat,
                           FieldByName('DET_TABPRE').AsString,
                           FieldByName('DET_UNIDIG').AsFloat,
                           FieldByName('DET_QTDPON').AsFloat,
                           'N',
                           '',
                           0,
                           FieldByName('DET_TOTCU2').AsFloat, //fltTotCu2
                           0, //fltTotExt
                           0, //fltPerExt,
                           FieldByName('DET_CODACA').AsString,                             // Código do produto acabado
                           FieldByName('DET_EMPACA').AsString,                             // Empresa do produto acabado
                           Not fEmptyStr(FieldByName('DET_CODACA').AsString),              // É produto acabado? (mesma lógica da kardex).
                           0, //fltTotUlt,
                           0, //fltImpUlt,
                           0, //fltBaRtSp,
                           0, //fltVaRtSp,
                           0, //fltIcOpPr
                           0,
                           CalcResult.dblAlqPis,
                           CalcResult.dblBasePis,
                           CalcResult.dblValorPis,
                           CalcResult.strCstPis,
                           CalcResult.dblAlqCof,
                           CalcResult.dblBaseCof,
                           CalcResult.dblValorCof,
                           CalcResult.strCstCof,
                           FieldByName('DET_CSTIPI').AsString,
                           FieldByName('DET_ENQIPI').AsString,
                           FieldByName('DET_PESLIQ').AsFloat,
                           FieldByName('DET_BASANT').AsFloat,  // Base do ICMS Antecipado
                           FieldByName('DET_ICMANT').AsFloat, // Valor do ICMS Antecipado
                           fltOutIcm,
                           fltISEICM,
                           0,
                           CalcResult.strNatRecPis,
                           CalcResult.strNatRecCof,
                           0,   //fltDeDVCf: Double = 0;
                           'N', //strRICMPR: String = 'N';
                           0,   //fltComLiq: Double = 0;
                           '',  //strNcmTin: String = '';
                           '',  //strNumLot: String = '';
                           0,   //fltValIva: Double = 0;
                           'N', //strCliBus: string = 'N';
                           '',  //strTurEnt: String = '';
                           0,   //fltPeBaST: Double = 0;
                           0,   //fltVal_RT: Double = 0;
                           0,   //fltImpPag: Double = 0;
                           0,   //fltTaxJur: Double = 0;
                           '',  //strNumCmp: String = '';
                           0,   //intNItCmp: Integer = 0;
                           '',  //strProBri: String = '';
                           0,   //fltPonBri: Double = 0;
                           0,   //fltOutVal: Double = 0;
                           0,   //fltIcmSai: Double = 0;
                           0,   //fltImpFed: Double = 0;
                           0,   //fltDesOpe: Double = 0;
                           0,   //fltValDif: Double = 0;
                           0,   //fltFedImp: Double = 0;
                           0,   //fltEstImp: Double = 0;
                           0,   //fltMunImp: Double = 0;
                           0,   //fltIcmOrg: Double = 0;
                           0,   //fltVrdIcm: Double = 0;
                           0,   //fltBasVrd: Double = 0;
                           '',  //strMtdIcm: String = '';
                           'N', //strAtivac: String = 'N';
                           0,   //intSeqCom: Integer = 0;
                           '',  //strSeqDet: String = '';
                           '',  //strDesNes: String = '';
                           '',  //strNotUlt: String = '';
                           FieldByName('DET_PICMEF').AsFloat,
                           FieldByName('DET_BICMEF').AsFloat,
                           FieldByName('DET_AICMEF').AsFloat,
                           FieldByName('DET_VICMEF').AsFloat,
                           FieldByName('DET_BSTANT').AsFloat,           {fltBSTANT: Double = 0; }
                           FieldByName('DET_VSTANT').AsFloat,           {fltVSTANT: Double = 0; }
                           '',                                          {strNotC17: String = '';}
                           FieldByName('DET_SICMEF').AsFloat,           {fltSICMEF: Double = 0;}
                           FieldByName('DET_BFCPST').AsFloat,
                           FieldByName('DET_PFCPST').AsFloat,
                           FieldByName('DET_VFCPST').AsFloat);

      If (Result) Then
        pGravarICMSUFDest(strAutIncTmp,
                          'NOTICD',
                          0,
                          qryMovDet.FieldByName('ICD_PERFCP').AsFloat,
                          0,
                          0,
                          0,
                          qryMovDet.FieldByName('ICD_VALFCP').AsFloat,
                          0,
                          0,
                          qryMovDet.FieldByName('ICD_BASFCP').AsFloat);

    If Not Result Then
      Break;

    pgbGravando.Position := pgbGravando.Position + 1;
    Application.ProcessMessages;

    If Not Result Then
      Break;

    Next;

  End;
End;

Function TfrmRecTransfEstoque.fChecaChaveAcesso: Boolean;
  Var
    qryGenFis: TUniQuery;
    strNumDocMsg,
    strSQL: String;
Begin
  strNumDocMsg := cdsConsulta.FieldByName('GER_NUMDOC').AsString + '-' +
                  cdsConsulta.FieldByName('GER_ESPDOC').AsString + '-' +
                  cdsConsulta.FieldByName('GER_CODEMP').AsString;

  Result := True;

  strSQL := '';
  strSQL := strSQL + 'SELECT                     ';
  strSQL := strSQL + '  FIS_ACESSO               ';
  strSQL := strSQL + 'FROM                       ';
  strSQL := strSQL + '  CADFIS                   ';
  strSQL := strSQL + 'WHERE                      ';
  strSQL := strSQL + '  FIS_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  FIS_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  FIS_CODEMP = :CODEMP AND ';

  If fEmptyStr(cdsConsulta.FieldByName('GER_SERIE_').AsString) Then
    strSQL := strSQL + '  IFNULL(FIS_SERIE_, "") = "" AND '
  Else
    strSQL := strSQL + '  FIS_SERIE_ = :SERIE_ AND ';

  strSQL := strSQL + '  FIS_FORCLI = :CODCLI     ';

  qryGenFis := fCriaQuery;

  With qryGenFis Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('NUMDOC').AsString := cdsConsulta.FieldByName('GER_NUMDOC').AsString;
    ParamByName('ESPDOC').AsString := cdsConsulta.FieldByName('GER_ESPDOC').AsString;
    ParamByName('CODEMP').AsString := cdsConsulta.FieldByName('GER_CODEMP').AsString;

    If Not fEmptyStr(cdsConsulta.FieldByName('GER_SERIE_').AsString) Then
      ParamByName('SERIE_').AsString := cdsConsulta.FieldByName('GER_SERIE_').AsString;

    ParamByName('CODCLI').AsString := cdsConsulta.FieldByName('GER_CODCLI').AsString;
    If fEmptyStr(ParamByName('CODCLI').AsString) Then
      ParamByName('CODCLI').AsString := cdsConsulta.FieldByName('GER_CODFOR').AsString;

    Open;

    If (Not IsEmpty) And fEmptyStr(FieldByName('FIS_ACESSO').AsString)Then
    Begin
      if not fAutComEmModoImportacao then
        fMensagem('ATENÇÃO', 'O Documento de Origem (' + strNumDocMsg + ') ainda não possui Chave de Acesso. Ainda não houve retorno da Nota Fiscal Eletrônica.', ['&Ok']);
      Result := False;
    End;
    Close;
  End;

  FreeAndNil(qryGenFis);
End;

function TfrmRecTransfEstoque.fConverteIncremConferencia(strAutoIncrem,
  strTipSenha, strTabela: string): string;
var
  qryBusca: TUniQuery;
begin
  if (SameText(strTipSenha, 'SENHA1')) And (SameText(strTabela, 'MOVGER')) then
  begin
    qryBusca := fCriaQuery;

    try
      qryBusca.SQL.Add('SELECT MV.AUTOINCREM FROM MOVGER');
      qryBusca.SQL.Add('INNER JOIN PCMGER ON PCG_ORIGND = GER_NUMDOC AND PCG_ORIGES = GER_ESPDOC AND PCG_EMPDES = GER_CODEMP AND PCG_DTAPED = GER_DTADOC ');
      qryBusca.SQL.Add('INNER JOIN MOVGER MV ON MV.GER_NUMDOC = PCG_ORIGND AND MV.GER_ESPDOC = PCG_ORIGES AND MV.GER_CODEMP = PCG_CODEMP');
      qryBusca.SQL.Add('INNER JOIN CONDOC ON DOC_SEQGER = MV.AUTOINCREM');
      qryBusca.SQL.Add('WHERE MOVGER.AUTOINCREM = :INCREM');
      qryBusca.ParamByName('INCREM').AsString := strAutoIncrem;
      qryBusca.Open;

      Result := qryBusca.FieldByName('AUTOINCREM').AsString;
    finally
      begin
        FreeAndNil(qryBusca);
      end;
    end;
  end
  else
  begin
    if (fEmptyStr(strTipSenha)) and (fEmptyStr(strTabela)) and (not fEmptyStr(strAutoIncrem))then
    begin
      qryBusca := fCriaQuery;

      try
        qryBusca.SQL.Add('SELECT MV.AUTOINCREM FROM MOVGER');
        qryBusca.SQL.Add('INNER JOIN PCMGER ON PCG_ORIGND = GER_NUMDOC AND PCG_ESPDOC = GER_ESPDOC AND PCG_EMPDES = GER_CODEMP AND PCG_DTAPED = GER_DTADOC ');
        qryBusca.SQL.Add('LEFT JOIN MOVGER MV ON MV.GER_NUMDOC = PCG_ORIGND AND MV.GER_ESPDOC = PCG_ORIGES AND MV.GER_CODEMP = PCG_CODEMP');
        qryBusca.SQL.Add('INNER JOIN CONDOC ON DOC_SEQGER = MV.AUTOINCREM');
        qryBusca.SQL.Add('INNER JOIN CONGER ON CONGER.AUTOINCREM = DOC_SEQCON  AND GER_DTAFIM IS NULL');
        qryBusca.SQL.Add('WHERE MOVGER.AUTOINCREM = :INCREM');
        qryBusca.ParamByName('INCREM').AsString := strAutoIncrem;
        qryBusca.Open;

        if qryBusca.IsEmpty then
          Result := strAutoIncrem
        else
          Result := qryBusca.FieldByName('AUTOINCREM').AsString;
        finally
        begin
          FreeAndNil(qryBusca);
        end;
      end;
    end
    else
    begin
      Result := strAutoIncrem;
    end
  end;
end;

function TfrmRecTransfEstoque.fExisteDocumento(strNumDoc, strEspDoc, strSerie_, strCodFor, strCodEmp: String): Boolean;
  Var
    qryGer : TUniQuery;
begin
  Result := False;
  qryGer := fCriaQuery(Nil);
  Try
    With qryGer Do
    Begin
      Close;
      SQL.Text :=
        '  SELECT COUNT(*) FROM (                 '+
        '  SELECT AUTOINCREM                      '+
        '  FROM MOVGER                            '+
        '  WHERE GER_NUMDOC = :NUMDOC             '+
        '    AND GER_ESPDOC = :ESPDOC             '+
        '    AND IFNULL(GER_SERIE_, "") = :SERIE_ '+
	      '    AND GER_CODFOR = :CODFOR             '+
        '    AND GER_CODEMP = :CODEMP             '+
        '    AND GER_CLAFIS < "5000"              '+
        '  UNION ALL                              '+
        '  SELECT AUTOINCREM                      '+
        '  FROM NOTGER                            '+
        '  WHERE GER_NUMDOC = :NUMDOC             '+
        '    AND GER_ESPDOC = :ESPDOC             '+
        '    AND IFNULL(GER_SERIE_, "") = :SERIE_ '+
        '    AND GER_CODFOR = :CODFOR             '+
        '    AND GER_CODEMP = :CODEMP             '+
        '    AND GER_CLAFIS < "5000"              '+
        ' ) AS TMP                                ';
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := IIf(strEspDoc =  'TE', 'PD', strEspDoc);
      ParamByName('SERIE_').AsString := strSerie_;
      ParamByName('CODFOR').AsString := strCodFor;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If Not IsEmpty Then
      Begin
        Result := Fields[0].AsInteger > 0;
      End;

      Close;
    End;
  Finally
    FreeAndNil(qryGer);
  end;
end;


function TfrmRecTransfEstoque.fFinalizaConferencia(strAutoIncrem: string): Boolean;
Var
  qryUpdate: TUniQuery;
Begin
  qryUpdate := fCriaQuery;

  try
    qryUpdate.SQL.Add('UPDATE CONGER SET ');
    qryUpdate.SQL.Add('GER_DTAFIM = :DTAFIM,');
    qryUpdate.SQL.Add('GER_OPEFIM = :OPEFIM');
    qryUpdate.SQL.Add('WHERE AUTOINCREM = (');
    qryUpdate.SQL.Add('SELECT DOC_SEQCON FROM CONDOC WHERE DOC_SEQGER = :INCREM)');

    qryUpdate.ParamByName('DTAFIM').AsDateTime := fNow();
    qryUpdate.ParamByName('OPEFIM').AsString := strLoginUsuarioLogado;
    qryUpdate.ParamByName('INCREM').AsString := strAutoIncrem;

    qryUpdate.ExecSQL;

    Result := qryUpdate.RowsAffected > 0;
  finally
    begin
      FreeAndNil(qryUpdate);
    end;
  end;
end;

Function TfrmRecTransfEstoque.fGravaCadFisEsp: Boolean;
  Var
    qryGenFis: TUniQuery;
    strSQL: String;
    arrDadLiv: TarrDadLiv;
    strNumDocMsg : String;
Begin
  qryGenFis := fCriaQuery;

  {*****************************************}
  {* GRAVA O CADFIS                        *}
  {**************************************LA*}
  strSQL := '';
  strSQL := strSQL + 'SELECT                     ';
  strSQL := strSQL + '  *                        ';
  strSQL := strSQL + 'FROM                       ';
  strSQL := strSQL + '  CADFIS                   ';
  strSQL := strSQL + 'WHERE                      ';
  strSQL := strSQL + '  FIS_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  FIS_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  FIS_CODEMP = :CODEMP AND ';

  If fEmptyStr(cdsConsulta.FieldByName('GER_SERIE_').AsString) Then
    strSQL := strSQL + '  IFNULL(FIS_SERIE_, "") = "" AND '
  Else
    strSQL := strSQL + '  FIS_SERIE_ = :SERIE_ AND ';

  strSQL := strSQL + '  FIS_FORCLI = :CODCLI     ';

  With qryGenFis Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('NUMDOC').AsString := cdsConsulta.FieldByName('GER_NUMDOC').AsString;
    ParamByName('ESPDOC').AsString := cdsConsulta.FieldByName('GER_ESPDOC').AsString;
    ParamByName('CODEMP').AsString := cdsConsulta.FieldByName('GER_CODEMP').AsString;

    If Not fEmptyStr(cdsConsulta.FieldByName('GER_SERIE_').AsString) Then
      ParamByName('SERIE_').AsString := cdsConsulta.FieldByName('GER_SERIE_').AsString;

    ParamByName('CODCLI').AsString := cdsConsulta.FieldByName('GER_CODCLI').AsString;
    If fEmptyStr(ParamByName('CODCLI').AsString) Then
      ParamByName('CODCLI').AsString := cdsConsulta.FieldByName('GER_CODFOR').AsString;

    Open;

    strNumDocMsg := cdsConsulta.FieldByName('GER_NUMDOC').AsString + '-' +
                    cdsConsulta.FieldByName('GER_ESPDOC').AsString + '-' +
                    cdsConsulta.FieldByName('GER_CODEMP').AsString;

    If IsEmpty Then
    Begin
      fRollBack;
      fMensagem('', 'Registro do Livro Fiscal não encontrado para o documento ' + strNumDocMsg, ['&Ok']);
      Result := False;
      Exit;
    End;

    pCriaLivroFiscal(qryGenFis, arrDadLiv);
    Result := fAtualizaMovGer(arrDadLiv);
    If not Result Then
      Exit;
//    strClaFis := fTrocaClaFis(arrDadLiv[1].strClaFis, arrDadLiv[1].blnSubst);

      Result := untCadFis.fGravaCadFis(strAutIncCadFis,
                                     dtaDtaEnt,                            // Data de Entrada
                                     strNumDoc,                            // Número do Documento
                                     '',                                   // Número do Documento 2
                                     strEspDoc,                            // Espécie
                                     'E',                                  // Entrada / Saida
                                     FieldByName('FIS_DTADOC').AsDateTime, // Data do Documento
                                     'F',                                  // Tipo (F)ornecedor / (C)liente
                                     strForNE,                             // Código Fornecedor / Cliente
                                     FieldByName('FIS_HISTOR').AsString,   // Histórico
                                     FieldByName('FIS_NFCOMP').AsString,   // ???
                                     FieldByName('FIS_NOTESP').AsString,   // ???
                                     arrDadLiv[1].strClaFis, // Classificação Fiscal 1
                                     arrDadLiv[1].fltVlrCon,               // Valor Contábil 1
                                     arrDadLiv[1].fltBasIcm,               // Base de ICMS 1
                                     arrDadLiv[1].fltAlqIcm,               // Aliquota de ICMS 1
                                     arrDadLiv[1].fltValIcm,               // Valor de ICMS 1
                                     arrDadLiv[1].fltOutras,               // Valor de Outras 1
                                     arrDadLiv[1].fltIsento,               // Valor de Isento 1
                                     arrDadLiv[1].fltRetido,               // Valor de Retido 1
                                     arrDadLiv[1].fltBasIpi,               // Base de IPI 1
                                     arrDadLiv[1].fltValIpi,               // Valor de IPI 1
                                     arrDadLiv[1].fltBasRet,               // Base de Substituição 1
                                     arrDadLiv[1].fltDesAce,               // Valor de Despesa Acessária 1
                                     0.0,                                  // Valor do ISS 1
                                     arrDadLiv[2].strClaFis, // Classificação Fiscal 2
                                     arrDadLiv[2].fltVlrCon,               // Valor Contábil 2
                                     arrDadLiv[2].fltBasIcm,               // Base de ICMS 2
                                     arrDadLiv[2].fltAlqIcm,               // Aliquota de ICMS 2
                                     arrDadLiv[2].fltValIcm,               // Valor de ICMS 2
                                     arrDadLiv[2].fltOutras,               // Valor de Outras 2
                                     arrDadLiv[2].fltIsento,               // Valor de Isento 2
                                     arrDadLiv[2].fltRetido,               // Valor de Retido 2
                                     arrDadLiv[2].fltBasIpi,               // Base de IPI 2
                                     arrDadLiv[2].fltValIpi,               // Valor de IPI 2
                                     arrDadLiv[2].fltBasRet,               // Base de Substituição 2
                                     arrDadLiv[2].fltDesAce,               // Valor de Despesa Acessária 21
                                     0.0,                                  // Valor do ISS 2
                                     arrDadLiv[3].strClaFis, // Classificação Fiscal 3
                                     arrDadLiv[3].fltVlrCon,               // Valor Contábil 3
                                     arrDadLiv[3].fltBasIcm,               // Base de ICMS 3
                                     arrDadLiv[3].fltAlqIcm,               // Aliquota de ICMS 3
                                     arrDadLiv[3].fltValIcm,               // Valor de ICMS 3
                                     arrDadLiv[3].fltOutras,               // Valor de Outras 3
                                     arrDadLiv[3].fltIsento,               // Valor de Isento 3
                                     arrDadLiv[3].fltRetido,               // Valor de Retido 3
                                     arrDadLiv[3].fltBasIpi,               // Base de IPI 3
                                     arrDadLiv[3].fltValIpi,               // Valor de IPI 3
                                     arrDadLiv[3].fltBasRet,               // Base de Substituição 3
                                     arrDadLiv[3].fltDesAce,               // Valor de Despesa Acessária 3
                                     0.0,                                  // Valor do ISS 3
                                     arrDadLiv[4].strClaFis,  // Classificação Fiscal 4
                                     arrDadLiv[4].fltVlrCon,               // Valor Contábil 4
                                     arrDadLiv[4].fltBasIcm,               // Base de ICMS 4
                                     arrDadLiv[4].fltAlqIcm,               // Aliquota de ICMS 4
                                     arrDadLiv[4].fltValIcm,               // Valor de ICMS 4
                                     arrDadLiv[4].fltOutras,               // Valor de Outras 4
                                     arrDadLiv[4].fltIsento,               // Valor de Isento 4
                                     arrDadLiv[4].fltRetido,               // Valor de Retido 4
                                     arrDadLiv[4].fltBasIpi,               // Base de IPI 4
                                     arrDadLiv[4].fltValIpi,               // Valor de IPI 4
                                     arrDadLiv[4].fltBasRet,               // Base de Substituição 4
                                     arrDadLiv[4].fltDesAce,               // Valor de Despesa Acessária 4
                                     0.0,                                  // Valor do ISS 4
                                     arrDadLiv[5].strClaFis,               // Classificação Fiscal 5
                                     arrDadLiv[5].fltVlrCon,               // Valor Contábil 5
                                     arrDadLiv[5].fltBasIcm,               // Base de ICMS 5
                                     arrDadLiv[5].fltAlqIcm,               // Aliquota de ICMS 5
                                     arrDadLiv[5].fltValIcm,               // Valor de ICMS 5
                                     arrDadLiv[5].fltOutras,               // Valor de Outras 5
                                     arrDadLiv[5].fltIsento,               // Valor de Isento 5
                                     arrDadLiv[5].fltRetido,               // Valor de Retido 5
                                     arrDadLiv[5].fltBasIpi,               // Base de IPI 5
                                     arrDadLiv[5].fltValIpi,               // Valor de IPI 5
                                     arrDadLiv[5].fltBasRet,               // Base de Substituição 5
                                     arrDadLiv[5].fltDesAce,               // Valor de Despesa Acessária 5
                                     0.0,                                  // Valor do ISS 5
                                     fltTotPis,                            // fltTotPis,
                                     fltTotCof,                            // fltTotCof,
                                     fltTotBasPis,                         // fltBasPis,
                                     fltTotBasCof,                         // fltBasCof,
                                     fltTotAlqPis,                         // fltAlqPis,
                                     fltTotAlqCof,                         // fltAlqCof,
                                     strCodEmp,                            // Empresa
                                     strSerie,                             // Série
                                     strEstFor,                            // Estado do Cliente / Fornecedor
                                     '',                                   // Número de Série
                                     '',                                   // Número COO
                                     '',                                   // Código da Conta Contábil
                                     '',                                   // Documento do conhecimento de frete
                                     FieldByName('FIS_ACESSO').AsString,   // Chave de Acesso NF-e
                                     FieldByName('FIS_PROTOC').AsString,   // Numero protocolo NF-e
                                     '',                                   // Origem do documento
                                     '', // strEmpAut
                                     0,  // fltImpMer
                                     0,  // fltImpSeg
                                     0,  // fltImpImp
                                     0,  // fltImpPro
                                     0,  // fltImpTax
                                     0,  // fltImpPis
                                     0,  // fltImpCof
                                     '', // strImpIC1
                                     '', // strImpIC2
                                     '', // strModFre
                                     0,  // fltBasIss
                                     0,  // fltAlqIss
                                     0,  // fltValIss
                                     arrDadLiv[1].fltBasAnt,
                                     arrDadLiv[1].fltValAnt,
                                     arrDadLiv[2].fltBasAnt,
                                     arrDadLiv[2].fltValAnt,
                                     arrDadLiv[3].fltBasAnt,
                                     arrDadLiv[3].fltValAnt,
                                     arrDadLiv[4].fltBasAnt,
                                     arrDadLiv[4].fltValAnt,
                                     arrDadLiv[5].fltBasAnt,
                                     arrDadLiv[5].fltValAnt);

    Close;

  End; {With}

  FreeAndNil(qryGenFis);

  pgbGravando.Position := pgbGravando.Position + 1;
  Application.ProcessMessages;

End;

Function TfrmRecTransfEstoque.fBaixaNotaConf: Boolean;
  Var
    qryNotGer: TUniQuery;
Begin
  qryNotGer := fCriaQuery;

  With qryNotGer, SQL do
  Begin
    Clear;

    Add('UPDATE NOTGER SET');
    Add('GER_NUMFAT = :NUMFAT,');
    Add('GER_TIPFAT = :TIPFAT,');
    Add('GER_EMPFAT = :EMPFAT ');

    Add('WHERE');
    Add('  IFNULL(GER_SERIE_, "") = :SERIE_ AND');
    if not fEmptyStr(cdsConsulta.FieldByName('GER_CODFOR').AsString) Then
      Add(' GER_CODFOR = :CODCLI AND ')
    Else
      Add('  GER_CODCLI = :CODCLI AND');
    Add('  GER_NUMDOC = :NUMDOC AND');
    Add('  GER_ESPDOC = :ESPDOC AND');
    Add('  GER_CODEMP = :CODEMP    ');

    ParamByName('NUMFAT').AsString := strNumDoc;
    ParamByName('TIPFAT').AsString := strEspDoc;

    If fEmptyStr(strCodEmp) Then
      ParamByName('EMPFAT').Value    := Null
    Else
      ParamByName('EMPFAT').AsString := strCodEmp;

    ParamByName('CODCLI').AsString := cdsConsulta.FieldByName('GER_CODCLI').AsString;
    ParamByName('NUMDOC').AsString := cdsConsulta.FieldByName('GER_NUMDOC').AsString;
    ParamByName('ESPDOC').AsString := cdsConsulta.FieldByName('GER_ESPDOC').AsString;
    ParamByName('CODEMP').AsString := cdsConsulta.FieldByName('GER_CODEMP').AsString;
    ParamByName('SERIE_').AsString := cdsConsulta.FieldByName('GER_SERIE_').AsString;
    If not fEmptyStr(cdsConsulta.FieldByName('GER_CODFOR').AsString) Then
      ParamByName('CODCLI').AsString := cdsConsulta.FieldByName('GER_CODFOR').AsString;
    ExecSQL;
  End;

  FreeAndNil(qryNotGer);

  Result := True;
End;

Function TfrmRecTransfEstoque.fGeraEntradaEspecial(intIndice: integer): Boolean;
var
  blnTransacaoExterna: Boolean;
Begin
  blnTransacaoExterna := frmModulo.GetCurrentConnection.InTransaction;
  blnGarantia := Copy(cdsConsulta.FieldByName('GER_MEN001').AsString,1,12) = 'GARANTIA(TE)';
  strCodFor := '';
  With cdsConsulta Do
  If fVerificaConfBaixada(FieldByName('GER_NUMDOC').AsString,
                          FieldByName('GER_ESPDOC').AsString,
                          FieldByName('GER_CODEMP').AsString,
                          FieldByName('GER_CODCLI').AsString) Then
  Begin
    Result := True;
    Exit;
  End;

  Try
    dtaDtaEnt := Vs_Date;

    // APENAS PARA MONTAR A CONDIÇÃO DE PAGAMENTO STRCNDPAG QUE SERÁ USADA NO NOTGER
    With cdsConsulta Do
    If Not fMontaDuplicatas(FieldByName('GER_VLRCON').AsFloat,
                            FieldByName('GER_VLRCON').AsFloat - FieldByName('GER_TOTPRO').AsFloat, fValorContabil_Igual_ValorParcelas) Then
    Begin
        Result := False;
        Exit;
      End;

    pgbGravando.Position := 0;

    If Not blnTransacaoExterna Then
      fStartTransaction;

    strAutIncCadFis := '';
    Result := fGravaNotGerEsp And
              fGravaNotDetEsp And
              fBaixaNotaConf  And
              fGravaCadFisEsp And
              fGravaFinanceiroEsp;{And
              fGravaAgendamentoDeRecebimento(intIndice) And
              fEfetivaMvtoFiscal;}

    If Not blnTransacaoExterna Then
    Begin
      If Result Then
      Begin
        fCommit;
      End
      Else
        fRollBack;
    End;

    pLimparArrDadLivFull;

  Except
    On E: ExceptionLotesADefinir Do
    Begin
      pgbGravando.Position := 0;
      Result := False;
      If Not blnTransacaoExterna Then
        fRollBack;
      pMensagemSonora(E.Message);
    End;

    On E: Exception Do
    Begin
      pgbGravando.Position := 0;
      Result := False;
      If Not blnTransacaoExterna Then
        fRollBack;
      pMensagensErro('', E.Message + ' [fGeraEntradaEspecial]');
    End;
  End;
End;

Function TfrmRecTransfEstoque.fGeraEntradaMercadorias(pgbProgresso: TcxProgressBar): Boolean;
  Var
    intIndice: Integer;
Begin
  pgbGravando := pgbProgresso;
  Result := True;

  pnlInfo.Caption := 'GRAVANDO...';

  strIncAge := '';

  Try
    With cdsConsulta Do
    Begin

      For intIndice := 0 To stlListSelecao.Count - 1 Do
      Begin
        If Locate('AUTOINCREM', stlListSelecao[intIndice], []) Then
        Begin

          If fEmptyStr(FieldByName('PCG_NUMPED').AsString) Then //Proveniente de Confirmacao de TE
            Result := fGeraEntradaEspecial(intIndice)
          Else
            Result := fGeraEntrada(intIndice);

          If Not Result Then
            Break;
        End;
      End;
    End;

    If Result Then
      fCommit
    Else
      fRollback;

    pgbGravando := nil;
    pnlInfo.Caption := '';
  Except On
    E:Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmRecTransfEstoque.fGeraEntradaMercadorias]');
    End;
  End;
End;

Function TfrmRecTransfEstoque.fGeraEntrada(intIndice: Integer): Boolean;
var intPosicao: Integer;
    fltOscMed: Double;
    strCodErrosAuditoria: String;
Begin
  FstrFatGor := '';
  Try
    fltOscMed := fCfgSis('OSCMED', varDouble);

    blnGarantia := Copy(cdsConsulta.FieldByName('GER_MEN001').AsString,1,12) = 'GARANTIA(TE)';

    If fVerificaTransfBaixada(cdsConsulta.FieldByName('GER_NUMDOC').AsString,
                              cdsConsulta.FieldByName('GER_ESPDOC').AsString,
                              cdsConsulta.FieldByName('GER_CODEMP').AsString,
                              cdsConsulta.FieldByName('GER_CODCLI').AsString,
                              cdsConsulta.FieldByName('GER_SERIE_').AsString) Then
    Begin
      Result := True;
      Exit;
    End;

    dtaDtaEnt := Vs_Date;

    If (Not objEntradaSimplificada.recAutEntTe.blnPedidoCompra) Then
      dtaDtaEnt := cdsConsulta.FieldByName('GER_DTADOC').AsDateTime;

    strCodFor := cdsConsulta.FieldByName('PCG_CODFOR').AsString;
    pCarregaFornecedor(strCodFor);
    pCarregaEmpresaIndustria;
    blnDeIndustriaParaRevenda := (blnFornecedorIndustria And (Not blnEmpresaIndustria));

    strArqTabDetOri := AnsiReplaceStr(cdsConsulta.FieldByName('TABELA').AsString, 'GER', 'DET');

    If not fTranferenciaAutomaticaFulfillment then
    Begin
      If TEntradaValidacoes.fDataDeEntradaDeMesesAnteriores(DateToStr(dtaDtaEnt)) Then
      Begin
        If Not TEntradaValidacoes.fLiberouDataDeEntradaDeMesesAnteriores(
          cdsConsulta.FieldByName('GER_NUMDOC').AsString, strCodFor, strNomFor,
          DateToStr(dtaDtaEnt), DateToStr(cdsConsulta.FieldByName('GER_DTADOC').AsDateTime),
          FloatToStr(cdsConsulta.FieldByName('GER_VLRCON').AsFloat)) Then
        Begin
          Result := False;
          Exit;
        End;
      End;
    End;

    If blnMarNeg And (Not blnGerarLotePrecos) And (Not fGravaMovDet(True)) Then
    Begin
      Result := False;
      Exit;
    End;

    If (fltOscMed > 0) And (blnAtuMed) And (Not fGravaMovDet(False, True)) Then
    Begin
      Result := False;
      Exit;
    End;

    If fGeraAgendamento And (not fValidaTransportadoraAgendamento) Then
    Begin
      Result := False;
      fMensagem('', 'A nota de fiscal de transferência está sem transportadora e a "CFG_TRASUG" não tem uma transportadora válida, informe uma transportadora sugestão para gerar o agendamento de recebimento!', ['&OK']);
      Exit;
    End;


    With cdsConsulta Do
    If Not fMontaDuplicatas(FieldByName('GER_VLRCON').AsFloat,
                            FieldByName('GER_VLRCON').AsFloat - FieldByName('GER_TOTPRO').AsFloat, fValorContabil_Igual_ValorParcelas) Then
    Begin
      Result := False;
      Exit;
    End;

    If Assigned(pgbGravando) Then
      pgbGravando.Position := 0;

    pInicializaImpressaoCP;

    objAuditoriaSaldo.Limpar;

    fStartTransaction;
    strAutIncCadFis := '';
    Result := fGravaMovGer     And
              fGravaMovDet     And
              fGravaFatGor     And
              fGravaFatDor     And
              fAtualizaPedido  And
              fGravaCadFis     And
              fGravaFinanceiro And
              fGravaAgendamentoDeRecebimento(intIndice) And
              fEfetivaMvtoFiscal And
              fGeraPlanoRecebimentoAutomatico(intIndice);

    If Result And (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
    Begin
      Result := False;
      fRollBack;
      pMostraErrosAuditoria(strCodErrosAuditoria);
    End;

    If Result Then
    Begin
      fCommit;
      If(fCfgSis('ENTEFE', varBoolean) And blnGerouLotePrecos And (Not fConferenciaDepoisDaEntrada)) And
        (Not (objEntradaSimplificada.recAutEntTe.blnAutEnt))Then
      Begin
        intPosicao := High(arrEfetivarLotePreco);
        If intPosicao = -1 Then
          intPosicao := 0;
        SetLength(arrEfetivarLotePreco, intPosicao+1);
        arrEfetivarLotePreco[intPosicao].strNumDoc := strNumDoc;
        arrEfetivarLotePreco[intPosicao].strEspDoc := IIf(strEspDoc = 'PD', 'TE',strEspDoc) ;
        arrEfetivarLotePreco[intPosicao].strSerie  := strSerie;
        arrEfetivarLotePreco[intPosicao].strCodFor := strCodFor;
      End;
      pImprimeCPs;
    End
    Else
      fRollBack;

    pLimparArrDadLivFull;

  Except
    On E: ExceptionLotesADefinir Do
    Begin
      pgbGravando.Position := 0;
      Result := False;
      fRollBack;
      pMensagemSonora(E.Message);
    End;

    On E: Exception Do
    Begin
      If Assigned(pgbGravando) Then
        pgbGravando.Position := 0;
      Result := False;
      fRollBack;

      If fTranferenciaAutomaticaFulfillment Then
        Raise Exception.Create(E.Message)
      Else
      begin
        If E is ExceptionNumeroSerie then
          pMensagemOk(E.Message)
        Else
          pMensagensErro('', E.Message + ' [fGeraEntrada]');
      end
    End;
  End;
End;

Function TfrmRecTransfEstoque.fGeraAgendamento : Boolean;
Begin
  Result := (blnUsaRotinaWms and fConferenciaDepoisDaEntrada And (fCfgSis('TPLREC', varString) <> 'N'));
End;

Function TfrmRecTransfEstoque.fRetTransportadoraAgendamento : String;
Begin
  Result := '';
  If fEmptyStr(fRetNomTransportadora(cdsConsulta.FieldByName('GER_CODTRA').AsString)) Then
  Begin
    If Not fEmptyStr(fRetNomTransportadora(fCfgSis('TRASUG', varString))) Then
      Result := fCfgSis('TRASUG', varString);
  End
  Else
    Result := cdsConsulta.FieldByName('GER_CODTRA').AsString;
End;

Function TfrmRecTransfEstoque.fValidaTransportadoraAgendamento : Boolean;
Begin
  Result := not fEmptyStr(fRetTransportadoraAgendamento);
End;

Function TfrmRecTransfEstoque.fGravaAgendamentoDeRecebimento(intIndice: Integer) : Boolean;
  Var
    qryInsert : TUniQuery;
    strIncEle: String;
    strAcesso : String;
    blnTransacaoExterna : boolean;
Begin
  If not fGeraAgendamento Then
    Exit(True);

  Result := True;

  qryInsert := fCriaQuery;
  cdsConsulta.DisableControls;

  Try
  cdsConsulta.First;

    With qryInsert, SQL Do
    Begin
      blnTransacaoExterna := frmModulo.GetCurrentConnection.InTransaction;

      if not blnTransacaoExterna then
        fStartTransaction();

      If cdsConsulta.Locate('AUTOINCREM', stlListSelecao[intIndice], []) Then
      Begin
        If fExisteDocumento(cdsConsulta.FieldByName('GER_NUMDOC').AsString,
                            cdsConsulta.FieldByName('GER_ESPDOC').AsString,
                            cdsConsulta.FieldByName('GER_SERIE_').AsString,
                            cdsConsulta.FieldByName('PCG_CODFOR').AsString,
                            VS_strCodEmp) Then
        Begin
          If strIncAge = '' then
          Begin
            Close;
            Clear;
            Add(' INSERT INTO AGEREC ( ');
            Add('      ARC_CODIGO,     ');
            Add('      ARC_CODTRA,     ');
            Add('      ARC_DTAENT,     ');
            Add('      ARC_STATUS,     ');
            Add('      AUTOINCREM,     ');
            Add('      ARC_CODEMP,     ');
            Add('      ARC_DTAREC,     ');
            Add('      ARC_HRAREC,     ');
            Add('      ARC_OPEREC,     ');
            Add('      ARC_IDEDIG,     ');
            Add('      ARC_NOMMOT,     ');
            Add('      ARC_PLACA_,     ');
            Add('      ARC_IDENTI,     ');
            Add('      ARC_MOVEFE)     ');
            Add(' VALUES (:CODIGO,     ');
            Add('         :CODTRA,     ');
            Add('         :DTAENT,     ');
            Add('         :STATUS,     ');
            Add('         :INCREM,     ');
            Add('         :CODEMP,     ');
            Add('         :DTAREC,     ');
            Add('         :HRAREC,     ');
            Add('         :OPEREC,     ');
            Add('         :IDEDIG,     ');
            Add('         :NOMMOT,     ');
            Add('         :PLACA_,     ');
            Add('         :IDENTI,     ');
            Add('         :MOVEFE)     ');

            strIncAge := fRetAutoIncrem('AGEREC', VS_strCodEmp);
            strIdeDig := fAtualizaProCod('DIGELE', 'ARC_IDEDIG', 'AGEREC');

            ParamByName('INCREM').AsString := strIncAge;
            ParamByName('CODIGO').AsString := fAtualizaProCod('AGEREC', 'ARC_CODIGO');
            ParamByName('CODTRA').AsString := fRetTransportadoraAgendamento;
            ParamByName('DTAENT').AsDateTime := fNow();
            ParamByName('DTAREC').AsDateTime := fNow();
            ParamByName('HRAREC').AsDateTime := fNow();
            ParamByName('STATUS').AsString := 'EC';
            ParamByName('CODEMP').AsString := VS_strCodEmp;
            ParamByName('PLACA_').AsString := 'AAA-0000';
            ParamByName('IDENTI').AsString := 'ES: ' + cdsConsulta.FieldByName('GER_NUMDOC').AsString + '-' + cdsConsulta.FieldByName('GER_ESPDOC').AsString;
            ParamByName('MOVEFE').AsString := 'N';
            ParamByName('OPEREC').AsString := strLoginUsuarioLogado;
            ParamByName('IDEDIG').AsString := strIdeDig;
            ParamByName('NOMMOT').AsString := 'ENTRADA SIMPLIFICADA';
            If blnGarantia Then
              ParamByName('NOMMOT').AsString := 'ENTRADA SIMPLIFICADA - GARANTIA';

            Try
              ExecSQL;
            Except
              On E : Exception Do
              Begin
                if not blnTransacaoExterna then
                  fRollBack;

                pMensagensErro(E.Message, 'TfrmRecTransfEstoque.fGravaAgendamentoDeRecebimento');
                Exit(False);
              End;

            End;

          End;

          Close;
          Clear;
          Add(' SELECT * FROM GERELE       ');
          Add(' WHERE B08_NNF    = :NUMDOC ');
          Add('   AND B07_SERIE  = :SERIE_ ');
          Add('   AND GER_CODEMP = :CODEMP ');
          Add('   AND GER_CODFOR = :CODFOR ');

          ParamByName('NUMDOC').AsString   := cdsConsulta.FieldByName('GER_NUMDOC').AsString;
          ParamByName('SERIE_').AsString   := cdsConsulta.FieldByName('GER_SERIE_').AsString;
          ParamByName('CODEMP').AsString   := VS_strCodEmp;
          ParamByName('CODFOR').AsString   := cdsConsulta.FieldByName('PCG_CODFOR').AsString;
          Open;

          If IsEmpty Then
          Begin
            Close;
            Clear;
            Add(' INSERT INTO GERELE(AUTOINCREM, ');
            Add('                    GER_DOCENT, ');
            Add('                    GER_ESPENT, ');
            Add('                    GER_EMPENT, ');
            Add('                    GER_CODEMP, ');
            Add('                    GER_CODFOR, ');
            Add('                    B08_NNF   , ');
            Add('                    B07_SERIE , ');
            Add('                    W07_VPROD , ');
            Add('                    W10_VDESC , ');
            Add('                    B09_DEMI  , ');
            Add('                    PR07_CHNFE, ');
            Add('                    GER_DTALIB, ');
            Add('                    GER_TIPXML, ');
            Add('                    GER_UNICOM, ');
            Add('                    GER_ENTSIM, ');
            Add('                    GER_IDEDIG) ');
            Add('             VALUES(:AUTINC,    ');
            Add('                    :DOCENT,    ');
            Add('                    :ESPENT,    ');
            Add('                    :CODEMP,    ');
            Add('                    :CODEMP,    ');
            Add('                    :CODFOR,    ');
            Add('                    :DOCENT,    ');
            Add('                    :SERIE_,    ');
            Add('                    :TOTITE,    ');
            Add('                    :DESESP,    ');
            Add('                    :DTAEMI,    ');
            Add('                    :ACESSO,    ');
            Add('                    :DTAEMI,    ');
            Add('                    :TIPXML,    ');
            Add('                    :UNICOM,    ');
            Add('                    :ENTSIM,    ');
            Add('                    :IDEDIG)    ');
            strIncEle := fRetAutoIncrem('GERELE', VS_strCodEmp);
            strAcesso := fRetChaveAcesso(cdsConsulta.FieldByName('GER_NUMDOC').AsString,
                                         IfThen(cdsConsulta.FieldByName('GER_ESPDOC').AsString = 'TE', 'PD', cdsConsulta.FieldByName('GER_ESPDOC').AsString),
                                         cdsConsulta.FieldByName('GER_CODCLI').AsString,
                                         cdsConsulta.FieldByName('GER_CODEMP').AsString,
                                         cdsConsulta.FieldByName('GER_SERIE_').AsString);

            ParamByName('AUTINC').AsString   := strIncEle;
            ParamByName('DOCENT').AsString   := cdsConsulta.FieldByName('GER_NUMDOC').AsString;
            ParamByName('ESPENT').AsString   :=IfThen(cdsConsulta.FieldByName('GER_ESPDOC').AsString = 'TE', 'PD', cdsConsulta.FieldByName('GER_ESPDOC').AsString);
            ParamByName('CODEMP').AsString   := VS_strCodEmp;
            ParamByName('ENTSIM').AsString   := 'S';

            If (cdsConsulta.FieldByName('PCG_CODFOR').AsString = '') And
               (cdsConsulta.FieldByName('EMP_FORFIL').AsString <> '') Then
              ParamByName('CODFOR').AsString   := cdsConsulta.FieldByName('EMP_FORFIL').AsString
            Else
              ParamByName('CODFOR').AsString   := cdsConsulta.FieldByName('PCG_CODFOR').AsString;
            ParamByName('SERIE_').AsString   := cdsConsulta.FieldByName('GER_SERIE_').AsString;
            ParamByName('DTAEMI').AsDateTime := cdsConsulta.FieldByName('GER_DTAENT').AsDateTime;
            ParamByName('TOTITE').AsFloat    := cdsConsulta.FieldByName('GER_TOTPRO').AsFloat;
            ParamByName('DESESP').AsFloat    := cdsConsulta.FieldByName('GER_DESESP').AsFloat;

            ParamByName('TIPXML').AsString   := '0';
            ParamByName('UNICOM').AsString   := 'N';
            ParamByName('ACESSO').AsString   := strAcesso;
            ParamByName('IDEDIG').AsString   := strIdeDig;

            Try
              ExecSQL;
            Except
              On E : Exception Do
              Begin
                if not blnTransacaoExterna then
                  fRollBack;

                pMensagensErro(E.Message, 'TfrmRecTransfEstoque.fGravaAgendamentoDeRecebimento');
                Exit(False);
              End;

            End;



            Close;
            Clear;

            Add(' INSERT INTO DETELE(AUTOINCREM, ');
            Add('                    DET_SEQGER, ');
            Add('                    DET_CODITE, ');
            Add('                    I04_XPROD , ');
            Add('                    I10_QCOM  , ');
            Add('                    I14_QTRIB , ');
            Add('                    I10A_VUNCOM,');
            Add('                    I11_VPROD)  ');
            Add('            VALUES (:AUTINC,    ');
            Add('                    :SEQGER,    ');
            Add('                    :CODITE,    ');
            Add('                    :DESCRI,    ');
            Add('                    :QTDITE,    ');
            Add('                    :QTDITE,    ');
            Add('                    :UNITAR,    ');
            Add('                    :TOTPRO)    ');

            If strArqTabDetOri = '' Then
              strArqTabDetOri := AnsiReplaceStr(cdsConsulta.FieldByName('TABELA').AsString, 'GER', 'DET');

            pAbreMovDet(strArqTabDetOri);

            While Not qryMovDet.Eof Do
            Begin
              ParamByName('AUTINC').AsString := fRetAutoIncrem('DETELE', VS_strCodEmp);
              ParamByName('SEQGER').AsString := strIncEle;
              ParamByName('CODITE').AsString := qryMovDet.FieldByName('ENT_CODITE').AsString;
              ParamByName('DESCRI').AsString := qryMovDet.FieldByName('DET_DESCRI').AsString;
              ParamByName('QTDITE').AsFloat  := qryMovDet.FieldByName('ENT_QTDITE').AsFloat;
              ParamByName('UNITAR').AsFloat  := qryMovDet.FieldByName('DET_UNITAR').AsFloat;
              ParamByName('TOTPRO').AsFloat  := qryMovDet.FieldByName('DET_TOTITE').AsFloat;

            Try
              ExecSQL;
            Except
              On E : Exception Do
              Begin
                  if not blnTransacaoExterna then
                    fRollBack;

                  pMensagensErro(E.Message, 'TfrmRecTransfEstoque.fGravaAgendamentoDeRecebimento');
                  Exit(False);
                End;

              End;
              qryMovDet.Next;
            End;

            If cdsConsulta.FieldByName('PCG_NUMPED').AsString <> '' Then
            Begin
              Close;
              Clear;
              Add(' INSERT INTO PEDELE(AUTOINCREM, ');
              Add('                    PEL_SEQELE, ');
              Add('                    PEL_NUMDOC, ');
              Add('                    PEL_ESPDOC, ');
              Add('                    PEL_CODEMP, ');
              Add('                    PEL_CODFOR) ');
              Add('             VALUES(:AUTINC,    ');
              Add('                    :SEQELE,    ');
              Add('                    :NUMDOC,    ');
              Add('                    :ESPDOC,    ');
              Add('                    :CODEMP,    ');
              Add('                    :CODFOR)    ');

              ParamByName('AUTINC').AsString := fRetAutoIncrem('PEDELE', VS_strCodEmp);
              ParamByName('SEQELE').AsString := strIncEle;
              ParamByName('NUMDOC').AsString := cdsConsulta.FieldByName('PCG_NUMPED').AsString;
              ParamByName('ESPDOC').AsString := cdsConsulta.FieldByName('PCG_ESPDOC').AsString;
              ParamByName('CODEMP').AsString := cdsConsulta.FieldByName('PCG_CODEMP').AsString;
              ParamByName('CODFOR').AsString   := cdsConsulta.FieldByName('PCG_CODFOR').AsString;

              Try
                ExecSQL;
              Except
                On E : Exception Do
                Begin
                  if not blnTransacaoExterna then
                    fRollBack;

                  pMensagensErro(E.Message, 'TfrmRecTransfEstoque.fGravaAgendamentoDeRecebimento');
                  Exit(False);
                End;

              End;
            End;
          End
          Else
          Begin
            strIncEle := qryInsert.FieldByName('AUTOINCREM').AsString;

            qryInsert.Edit;
            qryInsert.FieldByName('GER_DTALIB').AsDateTime := fNow();
            qryInsert.FieldByName('GER_IDEDIG').AsString   := strIdeDig;
            qryInsert.FieldByName('GER_DOCENT').AsString   := cdsConsulta.FieldByName('GER_NUMDOC').AsString;
            qryInsert.FieldByName('GER_ESPENT').AsString   := cdsConsulta.FieldByName('GER_ESPDOC').AsString;
            qryInsert.FieldByName('GER_EMPENT').AsString   := VS_strCodEmp;
            qryInsert.Post;

          End;

          Close;
          Clear;
          Add(' INSERT INTO AGEDOC ( ');
          Add('         AUTOINCREM,  ');
          Add('         ADC_SEQGER,  ');
          Add('         ADC_NUMDOC,  ');
          Add('         ADC_SERIE_,  ');
          Add('         ADC_CODFOR,  ');
          Add('         ADC_ESPDOC,  ');
          Add('         ADC_TIPINC,  ');
          Add('         ADC_CODEMP,  ');
          Add('         ADC_ACESSO)  ');
          Add(' VALUES (:AUTINC,     ');
          Add('         :SEQGER,     ');
          Add('         :NUMDOC,     ');
          Add('         :SERIE_,     ');
          Add('         :CODFOR,     ');
          Add('         :ESPDOC,     ');
          Add('         :TIPINC,     ');
          Add('         :CODEMP,     ');
          Add('         :ACESSO)     ');

          ParamByName('AUTINC').AsString := fRetAutoIncrem('AGEDOC', VS_strCodEmp);
          ParamByName('SEQGER').AsString := strIncAge;

          ParamByName('NUMDOC').AsString := cdsConsulta.FieldByName('GER_NUMDOC').AsString;
          ParamByName('SERIE_').AsString := cdsConsulta.FieldByName('GER_SERIE_').AsString;
          If (cdsConsulta.FieldByName('PCG_CODFOR').AsString = '') And
             (cdsConsulta.FieldByName('EMP_FORFIL').AsString <> '') Then
            ParamByName('CODFOR').AsString   := cdsConsulta.FieldByName('EMP_FORFIL').AsString
          Else
            ParamByName('CODFOR').AsString   := cdsConsulta.FieldByName('PCG_CODFOR').AsString;

          ParamByName('ESPDOC').AsString := IfThen(cdsConsulta.FieldByName('GER_ESPDOC').AsString = 'TE', 'PD', cdsConsulta.FieldByName('GER_ESPDOC').AsString);

          ParamByName('TIPINC').AsString := 'M';
          ParamByName('CODEMP').AsString := VS_strCodEmp;
          ParamByName('ACESSO').AsString := strAcesso;

          Try
            ExecSQL;
          Except
            On E : Exception Do
            Begin
              if not blnTransacaoExterna then
                fRollBack;

              pMensagensErro(E.Message, 'TfrmRecTransfEstoque.fGravaAgendamentoDeRecebimento');
              Exit(False);
            End;

          End;

        End;  {VerficaDocumentoEntradaExiste()}
      End;


      if not blnTransacaoExterna then
        fcommit;
      pLimparArrDadLivFull;

    End;

  Finally
    cdsConsulta.First;
    cdsConsulta.EnableControls;
    FreeAndNil(qryInsert);
  End;

End;

Function TfrmRecTransfEstoque.fCarregaConfig: Boolean;
Begin
  strCodEmp          := VS_strCodEmp;
  blnSaldoPendente   := (fCfgSis('SLPEPD', varBoolean));
  blnContribuinteIPI := (fCfgSis('CONIPI', varBoolean));
  blnBaixaCTPAVista  := (fCfgSis('CTPAVI', varBoolean));

  strEmpresas := VS_strCodEmp;

  If blnAtpRau And
     ((Pos(strCodFor, strForFil) = 0) Or blnAtpRen) Then
  Begin
    strEmpresas := fRetEmpresasUsamPrecoMatriz;
  End;

  Result := fCarregaConfigEmpresa;
End;

function TfrmRecTransfEstoque.fTranferenciaAutomaticaFulfillment: Boolean;
begin
  Result := objEntradaSimplificada.recAutEntTe.blnAutEnt And (Not objEntradaSimplificada.recAutEntTe.blnPedidoCompra);
end;

Function TfrmRecTransfEstoque.fTrocaClaFis(strClaFis: String; blnSubst: Boolean = False): String;
  Var
    intInd: Integer;
Begin
  Result := '';
  {******************************************}
  {* VERIFICA SE ESTÁ NO ARRAY DE EXCESSÕES *}
  {***************************************RV*}
  If blnDeIndustriaParaRevenda Then
  begin
    For intInd := 0 To Length(arrClaSaiInd) - 1 Do
    Begin
      If (arrClaSaiInd[intInd] = strClaFis) Then
        Result := arrClaEntDis[intInd];
    End;
  End;

  If Result = '' Then
  Begin
    For intInd := 0 To Length(arrClaSai) - 1 Do
    Begin
      If (arrClaSai[intInd] = strClaFis) Then
        Result := arrClaEnt[intInd];
    End;
  End;
  If (Result = '') Then
  Begin
    Result := fCfopConvertidoParaEntrada(strClaFis, blnSubst);
    If Result = '' Then
    Begin
      If LeftStr(strClaFis, 1) = '5' Then
        Result := '1' + RightStr(strClaFis, 3)

      Else If LeftStr(strClaFis, 1) = '6' Then
        Result := '2' + RightStr(strClaFis, 3)

      Else
        Result := '';
    End;
  End;
End;

function TfrmRecTransfEstoque.fGerarPedidosReservaEstoque(strDocEnt, strEspEnt, strSerEnt, strForEnt: String;
                                Var blnGerarPedido: Boolean): Boolean;
  Var
    endItem: TEndItem;
    endDocumento: TEndDocumento;
    blnCadLoc: Boolean;
begin
  blnCadLoc := fCfgSis('CADLOC', varBoolean);
  Try
    Result := True;

    endDocumento.strNumDoc := strDocEnt;
    endDocumento.strEspDoc := strEspEnt;
    endDocumento.strSerie_ := strSerEnt;
    endDocumento.strCodEmp := VS_strCodEmp;
    endDocumento.strCliFor := strForEnt;
    endDocumento.strTip_FC := 'F';

    objEnderecamento.endDocumento := endDocumento;

    qryMovDet.First;
    blnGerarPedido := False;

    While Not qryMovDet.Eof Do
    Begin
      If (qryMovDet.FieldByName('ITE_REAEND').AsString = 'S') Or ((blnMarmore) And (qryMovDet.FieldByName('ITE_GRAMAR').AsString = 'S')) And
         (Not fIsItemEspecial(qryMovDet.FieldByName('ITE_CODITE').AsString)) Then
      Begin
        qryMovDet.Edit;
        qryMovDet.FieldByName('AUTOINCREMENTO_GRAVACAO').AsString := fRetAutoIncrem('MOVDET', strCodEmp);
        qryMovDet.Post;

        If (Not fEmptyStr(qryMovDet.FieldByName('DET_CODACA').AsString)) And (Not blnCadLoc) then
        Begin
          qryMovDet.Next;
          Continue;
        End;

        endItem.strCodIte := qryMovDet.FieldByName('DET_CODITE').AsString;
        endItem.strCodMar := qryMovDet.FieldByName('DET_CODMAR').AsString;
        endItem.strDesIte := qryMovDet.FieldByName('DET_DESCRI').AsString;
        endItem.strRefere := qryMovDet.FieldByName('DET_REFERE').AsString;
        endItem.strCodUni := qryMovDet.FieldByName('DET_UNIDAD').AsString;
        endItem.strCodFor := qryMovDet.FieldByName('DET_FORITE').AsString;
        endItem.fltQtdIte := qryMovDet.FieldByName('DET_QTDITE').AsFloat;
        endItem.strCodAmz := fRetNumLot(True);
        endItem.blnRefugo := False;

        endItem.blnIteAca := False;
        If (Not fEmptyStr(qryMovDet.FieldByName('DET_CODACA').AsString)) And (intESTFLJ = 1) then
        Begin
          endItem.blnIteAca := True;
          endItem.strEmpAca := qryMovDet.FieldByName('DET_EMPACA').AsString;
          endItem.strCodAca := qryMovDet.FieldByName('DET_CODACA').AsString;
        End;

        endItem.strAutDet := qryMovDet.FieldByName('AUTOINCREMENTO_GRAVACAO').AsString;
        If blnNumSer Then
          endItem.strAutDetSer := qryMovDet.FieldByName('SER_NUMSER').AsString;

        objEnderecamento.pAddItem(endItem);
        blnGerarPedido := True;
      End;

      qryMovDet.Next;
    End;

    qryMovDet.First;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

end;

Function TfrmRecTransfEstoque.fGravaMovGer: Boolean;
  Var
    recServicos: TDadosServicos;
    arrDuplic : TarrDuplicata;
    fltTotIbsRT,
    fltTotCbsRT,
    fltTotIsRT,
    fltTotProIsRT,
    fltTotNfRT: Double;
Begin
  FillChar(recTotais, SizeOf(recTotais), #0);
  FillChar(recServicos, SizeOf(recServicos), #0);
  FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

  strCodOpe := strLoginUsuarioLogado;
  strCodDig := strLoginUsuarioLogado;
  strCodRep := strLoginUsuarioLogado;

  With cdsConsulta, recTotais Do
  Begin
    strCodFor    := FieldByName('PCG_CODFOR').AsString;
    pCarregaFornecedor(strCodFor);
    pCarregaEmpresaIndustria;
    blnEmpresaIndustria := (blnFornecedorIndustria And (Not blnEmpresaIndustria));

    strNumPed    := FieldByName('PCG_NUMPED').AsString;
    strEmpPed    := FieldByName('PCG_CODEMP').AsString;

    strNumDoc    := fStrZero(FieldByName('GER_NUMDOC').AsString, intTamNumDoc);

    strArqMovGer := FieldByName('TABELA').AsString;
    strArqTabDetOri := AnsiReplaceStr(FieldByName('TABELA').AsString, 'GER', 'DET');

    If Pos(FieldByName('GER_ESPDOC').AsString, 'NF_EL_IF_NS_') > 0 Then
      strEspDoc  := 'NF'
    Else
      strEspDoc  := 'PD';

    strArqMovGer := 'MOVGER';

    strSerie  := FieldByName('GER_SERIE_').AsString;

    fltDesEsp := FieldByName('GER_DESESP').AsFloat;
    fltTotIte := FieldByName('GER_TOTPRO').AsFloat;
    fltValFre := FieldByName('GER_TOTFRE').AsFloat;
    fltVlrCon := FieldByName('GER_VLRCON').AsFloat;

    If fTranferenciaAutomaticaFulfillment Then
      pCarregaCFOPS(cdsConsulta.FieldByName('AUTOINCREM').AsString, 'MOVDET')
    Else
    strClaFis := fTrocaClaFis(FieldByName('GER_CLAFIS').AsString);

    If SameText(strEspDoc, 'NF') And (Not fRetLivro(recTotais)) Then
    Begin
      Result := False;
      Exit;
    End;

  End;
  pCarregaTotaisReformaOrigem(fltTotIbsRT, fltTotCbsRT, fltTotIsRT, fltTotProIsRT, fltTotNfRT);
  With recTotais Do
  Result := untMovGer.fGravaMovGer(strAutInc,                                        // Auto Incremento (Retorno)
                                   strNumDoc,                                        // Numero Documento
                                   strEspDoc,                                        // Espécie
                                   strCodEmp,                                        // Empresa
                                   '',                                               // Transportadora
                                   strCodOpe,                                        // Vendedor
                                   strCodFor,                                        // Fornecedor
                                   '',                                               // Cliente
                                   'F',                                              // Tipo ((C)liente / (F)ornecedor)
                                   IIF(fConferenciaDepoisDaEntrada, 0, dtaDtaEnt),   // Data da Entrada
                                   IIF(fConferenciaDepoisDaEntrada, 0, fTime()),        // Hora da Entrada
                                   cdsConsulta.FieldByName('GER_DTADOC').AsDateTime, // Data do Documento
                                   strCndPag,                                        // Condição de Pagamento
                                   strEstFor,                                        // Estado do Cliente / Fornecedor
                                   '',                                               // Nome do Consumidor
                                   '',                                               // Endereço do Consumidor
                                   '',                                               // Bairro do Consumidor
                                   '',                                               // Cep do Consumidor
                                   '',                                               // Cidade do Consumidor
                                   '',                                               // Estado do Consumidor
                                   '',                                               // Telefone do Consumidor
                                   0,
                                   '',                                               // CNPJ / CGC
                                   '',                                               // CNPJ / CGC do consumidor
                                   '',                                               // Inscrição estadual do Consumidor
                                   '',                                               // RG do Consumidor
                                   0.0,                                              // Base Simples Paulista
                                   fltBasIpi,                                        // Base de IPI
                                   0.0,                                              // Aliquota de IPI
                                   fltTotIpi,                                        // Total de IPI
                                   fltBasIcm,                                        // Base de ICMS
                                   0.0,                                              // Aliquota de ICMS
                                   fltTotIcm,                                        // Total de ICMS
                                   fltValRet,                                        // Valor de Substituição
                                   0.0,
                                   0.0,                                              // Aliquota de Substituição
                                   fltBasRet,                                        // Base de Substituição
                                   fltDesEsp,                                        // Desconto Especial
                                   fltVlrCon,                                        // Valor Contábil
                                   fltTotIte,                                        // Total dos Itens
                                   cdsConsulta.FieldByName('GER_TOTCUS').AsFloat,    // Total de Custo
                                   0.0,                                              // Total Médio
                                   '2',                                              // Tipo de Frete
                                   fltValFre,                                        // Valor do Frete
                                   0.0,                                              // Peso Bruto
                                   0.0,                                              // Peso Liquido
                                   0.0,                                              // Volume
                                   '',                                               // Especie
                                   '',                                               // Marca
                                   '',                                               // Mensagem 1
                                   '',                                               // Mensagem 2
                                   '',                                               // Mensagem 3
                                   '',                                               // Mensagem 4
                                   '',                                               // Mensagem 5
                                   False,                                            // Indica se Faturado ou nao
                                   '',                                               // Tipo de Faturamento
                                   '',                                               // Numero de Faturamento
                                   '',                                               // Empresa do Faturamento
                                   0,                                                // Data de Faturamento
                                   '',                                               // Vendedor do Faturamento
                                   '',                                               // Condição de Pagamento do Faturamento
                                   False,                                            // Devolução Especial
                                   0.0,                                              // Valor do Faturamento
                                   0.0,                                              // Valor Parcela 01
                                   0.0,                                              // Valor Parcela 02
                                   0.0,                                              // Valor Parcela 03
                                   0.0,                                              // Valor Parcela 04
                                   0.0,                                              // Valor Parcela 05
                                   0.0,                                              // Valor Parcela 06
                                   0.0,                                              // Valor Parcela 07
                                   0.0,                                              // Valor Parcela 08
                                   0.0,                                              // Valor Parcela 09
                                   0.0,                                              // Valor Parcela 10
                                   0.0,                                              // Valor Parcela 11
                                   0.0,                                              // Valor Parcela 12
                                   arrDuplic,                                        // arrDuplic
                                   strSerie,                                         // Série
                                   'N',                                              // Nota Especial
                                   IIf(fTranferenciaAutomaticaFulfillment, ArrDadLivFull[1].strClaFisEntra, strClaFis), // Classificação Fiscal
                                   IIf(fTranferenciaAutomaticaFulfillment, ArrDadLivFull[2].strClaFisEntra, ''), // Classificação Fiscal 2
                                   IIf(fTranferenciaAutomaticaFulfillment, ArrDadLivFull[3].strClaFisEntra, ''), // Classificação Fiscal 3
                                   fRetDesCla(strClaFis),                            // Natureza da Operação
                                   0.0,                                              // Percentual de Desconto
                                   strCodDig,                                        // Código do Digitador
                                   '',                                               // Codigo da Condição
                                   '',                                               // Forma de Pagamento
                                   0.0,                                              // Fator para meia nota
                                   recServicos,
                                   fltDesAce,                                        // Despesa Acessória
                                   '',                                               // Origem do Documento - (D)evolução / (E)ntrada / (V)enda
                                   'N',                                              // Usa controle de entrega
                                   strCodRep,                                        // Representante
                                   0.0,                                              // Aliquota do IRPF (SERVIÇO)
                                   0.0,                                              // Valor do IRPF (SERVIÇO + PRODUTO)
                                   0.0,                                              // Aliquota do Pis (SERVIÇO)
                                   0.0,                                              // Valor do Pis (SERVIÇO + PRODUTO)
                                   0.0,                                              // Aliquota do Cofins (SERVIÇO)
                                   0.0,                                              // Valor do Cofins (SERVIÇO + PRODUTO)
                                   0.0,                                              // Aliquota do CSLL (SERVIÇO)
                                   0.0,                                              // Valor do CSLL (SERVIÇO + PRODUTO)
                                   0.0,                                              // Valor de IRPF que foi retido
                                   0.0,                                              // Valor de PIS que foi retido
                                   0.0,                                              // Valor de COFINS que foi retido
                                   0.0,                                              // Valor de CSLL que foi retido
                                   '',                                               // Notas de Documentos Acumulados
                                   0.0,                                              // Aliquota do IRPF (PRODUTOS)
                                   0.0,                                              // Aliquota do PIS (PRODUTOS)
                                   0.0,                                              // Aliquota do COFINS (PRODUTOS)
                                   0.0,                                              // Aliquota do CSLL (PRODUTOS)
                                   0.0,                                              // Valor de SERVIÇO que foi retido
                                   '',                                               // Notas de documentos acumulados (SERVIÇO)
                                   0.0,                                              // Percentual da Seguridade Social
                                   0.0,                                              // Valor da Seguridade Social
                                   0.0,                                              // Valor do IRPF Retido (Produto)
                                   0.0,                                              // Valor do IRPF Devido (Produto)
                                   0.0,                                              // Valor do IRPF Retido (Serviço)
                                   0.0,                                              // Valor do IRPF Devido (Serviço)
                                   0.0,                                              // Valor do PIS Retido (Produto)
                                   0.0,                                              // Valor do PIS Devido (Produto)
                                   0.0,                                              // Valor do PIS Retido (Serviço)
                                   0.0,                                              // Valor do PIS Devido (Serviço)
                                   0.0,                                              // Valor do COFINS Retido (Produto)
                                   0.0,                                              // Valor do COFINS Devido (Produto)
                                   0.0,                                              // Valor do COFINS Retido (Serviço)
                                   0.0,                                              // Valor do COFINS Devido (Serviço)
                                   0.0,                                              // Valor do CSLL Retido (Produto)
                                   0.0,                                              // Valor do CSLL Devido (Produto)
                                   0.0,                                              // Valor do CSLL Retido (Serviço)
                                   0.0,                                              // Valor do CSLL Devido (Serviço)
                                   '',                                               // Ordem de Produção
                                   0.0,                                              // Base Orgão Público
                                   0.0,                                              // ICMS Orgão Público
                                   0,                                                // Número do Conhecimento de Frete
                                   '',                                               // Consumidor final
                                   'N',                                              // Entrega no Faturamento
                                   '',                                               // CLiente de faturamento
                                   '',                                               // Operador da Expedição
                                   '',                                               // Separador da Expedição
                                   '',                                               // Tabela de preços utilizada
                                   '',
                                   'N',                                              // Entrega Futura
                                   FALSE,                                            // Baixa de Entrega Futura
                                   0,                                                // Margem de Lucro
                                   0.0,                                              // Base do retido (caso tivesse) com ipi e frete de entrada
                                   0.0,                                              // Valor do retido considerando a base acima.
                                   'N',
                                   '',
                                   VS_Date,                                          // Data de Entrega no Romaneio
                                   IIf(fTranferenciaAutomaticaFulfillment, ArrDadLivFull[4].strClaFisEntra, ''), // Classificação fiscal 4
                                   'N',                                              // AUTO-SERVIÇO
                                   '',                                               // Evento
                                   '',                                               // AUTOINC DO ENDEREÇO DE ENTREGA
                                   Trim(cdsConsulta.FieldByName('MOV_OBSERV').AsString),   // Conteúdo do CNFNFE
                                   '',  // strCodOco                                 // Motivo da Devolução
                                   '',  //strFasObr
                                   True,                                             // Imprime Duplicatas na NF-e
                                   0,   //fltValCre
                                   0,   //dtadtlBex
                                   '',  //strEmlCon
                                   0,   //dtaDtESNf
                                   0,   //tmrHrESNf
                                   Nil, //objFinanc
                                    '',  //Conhecimento de Frete
                                   '',  //strCodObr
                                   '',  //strCodArt

                                   'N', // Permuta para isenção de pagamento de comissão
                                   '',  //strRetIss
                                   '',  //strOpcDoc
                                   0,   //fltFreSug
                                   '',  //strNumAde
                                   fltBasAnt,            //BASE DE ICMS ANTECIPADO
                                   fltValAnt,           //VALOR DE ICMS ANTECIPADO
                                   '', // strNaoAtu
                                   '', // strEntUrg: String = '';
                                   '', // strMenExp: String = '';
                                   '', // strMenEx2: String = '';
                                   '', // strMenEx3: String = '';
                                   '', // strMenEx4: String = '';
                                   0,  // fltDupRec: Double = 0;
                                   0,  // fltValAdt: Double = 0;
                                   0,  // fltDeDVCf: Double = 0;
                                   '', // strPlaVei: String = '';
                                   '', // strKm_Vei: String = '';
                                   '', // strCliOri: String = '';
                                   '', // strCodMot: String = '';
                                   '', // strBetone: String = '';
                                   '', // strLacre_: String = '';
                                   '', // strTipMps: String = '';
                                   '', // strAbatim: String = '';
                                   '', // strBrita_: String = '';
                                   '', // strConBom: String = '';
                                   0,  // intFckDia: Integer = 0;
                                   0,  // fltImpPag: Double = 0;
                                   0,  // intPrzMed: integer = 0;
                                   False, // blnImpPdv: Boolean = False;
                                   False, // blnDTEXREP: Boolean = False;
                                   '', // strChvNfeDev: String = '';
                                   '', // strOpeSol: String = '';
                                   False, // blnEst_Dv: Boolean = False;
                                   '',    // strNumCOODev: String = '';
                                   '',    //  strNumSerDev: String = '';
                                   '',    //  strNumUSUDev: String = '';
                                   '',    // strTipDocDev: String = '';
                                   0,     // fltTotDif: Double = 0;
                                   Nil,   // objFazenda: Pointer = nil;
                                   0,     // fltFedImp   : Double = 0;
                                   0,     // fltEstImp   : Double = 0;
                                   0,     // fltMunImp   : Double = 0;
                                   0,     // fltTroco_: Double = 0;
                                   cdsConsulta.FieldByName('MOV_OBSFIS').AsString,
                                   'N', // strVenPre: String = 'N';
                                   '', // strSeqDocOri: String = '';
                                   False, // blnConEqu: Boolean = False;
                                   False, // blnDescIncond: Boolean = False;
                                   True,  // blnGraCTP: Boolean = True;
                                   '',    // strNumera: String = '';
                                   'N',   // strEdiPes: String = 'N';
                                   0,  // fltTaxEnt: Double = 0;
                                   0,  // fltVrdIcm: Double = 0;
                                   0,  // fltBasVrd: Double = 0;
                                   0,  // intNroBox: Integer = 0;
                                   '', // strCodEmbarcacao: String = '';
                                   0,  // fltTotBri: Double = 0;
                                   '', //  strTraRdp: String = '';
                                   '', // strCliCtt: String = '';
                                   '', // strCodMod: String = '';
                                   '', // strNumGui: String = '';
                                   '', // strHisCom: String = '';
                                   '', // strCodPrj: String = '';
                                   '', // strNatCfo: String = '';
                                   '', // strTpOper: String = '';
                                   '', // strCupDes: String = '';
                                   'S', // strNotPau: String = 'S';
                                   0,   // fltCotMoe: Double = 0;
                                   0,   // fltFreMkp: Double = 0;
                                   0,   // fltComMkp: Double = 0;
                                   '',  // strPlaFat: String = '';
                                   False, // blnDevWms: Boolean = False;
                                   False, // blnFulfillmentModoRobo : Boolean = False;
                                   0,     // fltFreCot: Double = 0;
                                   0,     // fltFreRat: Double = 0;
                                   'S',   // strEntSim
                                   '',    // strSeqDmp
                                   '',    // strEntFutOpc
                                   0,     // fltTotIpiEntFut
                                   0,     // fltTotRetEntFut
                                   0,     // fltTotFcpSTEntFut
                                   0,     // fltICMDes
                                   0,     // fltDesPis
                                   '',    // strOpFaEx
                                   '',    // strDocAba
                                   '',    // strEspAba
                                   '',    // strEmpAba
                                   '',    // strCliAba
                                   False, // blnColeta
                                   '',    // strNumeroRandomico
                                   '',    // strNumeroDrawback
                                   '',    // strCodFinalidadeAjuste
                                   '',    // strDoc_RE
                                   '',    // strEsp_RE
                                   '',    // strEmp_RE
                                   '',    // strCli_RE
                                   '',    // strDocRE2
                                   '',    // strEspRE2
                                   '',    // strEmpRE2
                                   '',    // strCliRE2
                                   '',    // strEmp_TE
                                   '',    // strAutIcv
                                   '',    // strEmp_PR
                                   '',    // strCliCEO
                                   0,     // fltVolSepExc
                                   0,     // fltVolSepNExc
                                   '',    // strSupGer
                                   '',    // strSupReg
                                   '',    // strCelCon
                                   'N',   // strAbaDep
                                   '',    // strEmpDep
                                   '',    // strAbf_Uf
                                   '',    // strEstornoNotaFiscal
                                   '',    // strCodTpA
                                   '',    // strMatRev
                                   '',    // strVchCdp
                                   '',    // strCodCno
                                   fltTotIbsRT,    // fltTotIbs
                                   fltTotCbsRT,    // fltTotCbs
                                   fltTotIsRT,     // fltTotIs
                                   fltTotProIsRT,  // fltTotProIs
                                   fltTotNfRT);    // fltTotNf

  If Result Then
    objAuditoriaSaldo.Adicionar(strAutInc, 'MOVGER');

  stlListaMovGer.Add(strAutInc);
End;

Procedure TfrmRecTransfEstoque.pAbreMovDet(strTabela: String);
  Var
    strSQL: String;
    intCont: Integer;
    strTabMovIcd,
    strTabMovAux: string;
    blnAtuFre: Boolean;
    blnFreIpi: Boolean;
    blnPerFre: Boolean;
Begin
  strSQL := '';

  blnAtuFre := fCfgSis('ATUFRE', varBoolean);
  blnFreIpi := fRateioFreteValorContabil(trfIndefinido);
  blnPerFre := (fCfgSis('PERFRE') = '1');

  strSQL := 'SET @N_ITEM := -1;';
  strSQL := strSQL +  ' SELECT ';

  If Pos('MOVDET', strTabela) > 0 Then
    strSQL := strSQL +  '  IF(DET_LOTABA <> "", DET_LOTABA, IFNULL(DET_NUMLOT,"")) AS DET_NUMLOT, ';


  strSQL := strSQL + '  (@N_ITEM := @N_ITEM + 1) AS N_ITEM, '; //ENT_N_ITEM
  strSQL := strSQL +  ' CAST("" AS CHAR(20)) AS AUTOINCREMENTO_GRAVACAO, ';
  strSQL := strSQL +  '  D.*, ';
  strSQL := strSQL +  '  DET_PESLIQ, ';
  strSQL := strSQL +  '  DET_CSTIPI, ';
  strSQL := strSQL +  '  DET_ENQIPI, ';
  strSQL := strSQL +  '  IFNULL(T.DET_BASANT, 0) AS DET_BASANT, ';
  strSQL := strSQL +  '  IFNULL(T.DET_ICMANT, 0) AS DET_ICMANT, ';
  strSQL := strSQL +  '  IFNULL(T.DET_VENDOR, 0) AS DET_VENDOR, ';
  strSQL := strSQL +  '  IFNULL(T.DET_OUTDES, 0) AS DET_OUTDES, ';
  strSQL := strSQL +  '  IFNULL(T.DET_OUTICM, 0) AS DET_OUTICM, ';
  strSQL := strSQL +  '  IFNULL(T.DET_VLGNRE, 0) AS DET_VLGNRE, ';

  strSQL := strSQL +  '  IFNULL(T.DET_ICMNCR, 0) AS DET_ICMNCR, ';
  strSQL := strSQL +  '  IFNULL(T.DET_FCPNCR, 0) AS DET_FCPNCR, ';

  strSQL := strSQL +  '  IFNULL(T.DET_VALTCI, 0) AS DET_VALTCI, ';
  strSQL := strSQL +  '  IFNULL(T.DET_VAL_TS, 0) AS DET_VAL_TS, ';

  strSQL := strSQL +  '  IFNULL(T.DET_VALTCI, 0) AS DET_VALTCI, ';
  strSQL := strSQL +  '  IFNULL(T.DET_VAL_TS, 0) AS DET_VAL_TS, ';

  If Pos('NOTDET', strTabela) > 0 Then
    strSQL := strSQL +  '  0.00 AS DET_CONFRE, '
  Else
    strSQL := strSQL +  '  IFNULL(T.DET_CONFRE, 0) AS DET_CONFRE, ';

  If fCfgSis('FRMCUS',varString ) = '1' Then
    strSql := strSql + '  ( ( ( DET_VALRET + T.DET_VAERET + T.DET_ICMANT + T.DET_VLGNRE ) / (DET_TOTITE - DET_DESESP + DET_VALIPI + IFNULL(T.DET_VAEIPI, 0))) * 100 ) AS PERSUB, '
  Else
    strSql := strSql + '  ( ( ( DET_VALRET + T.DET_VAERET + T.DET_ICMANT + T.DET_VLGNRE ) / (DET_TOTITE - DET_DESESP) ) * 100 ) AS PERSUB, ';

  strSQL := strSQL +  '  IFNULL(T.DET_ISEICM, 0) AS DET_ISEICM, ';
  strSQL := strSQL +  '  IFNULL(T.DET_ALEIPI, 0) AS DET_ALEIPI, ';
  strSQL := strSQL +  '  IFNULL(T.DET_VAEIPI, 0) AS DET_VAEIPI, ';
  strSQL := strSQL +  '  IFNULL(T.DET_ALERET, 0) AS DET_ALERET, ';
  strSQL := strSQL +  '  IFNULL(T.DET_VAERET, 0) AS DET_VAERET, ';
  strSQL := strSQL +  '  IFNULL(T.DET_BAERET, 0) AS DET_BAERET, ';
  strSQL := strSQL +  '  IFNULL(T.DET_ALQPIS, 0) AS DET_ALQPIS, ';
  strSQL := strSQL +  '  IFNULL(T.DET_ALQCOF, 0) AS DET_ALQCOF, ';
  strSQL := strSQL +  '  IFNULL(T.DET_UNIVIS, 0) AS DET_UNIVIS, ';

  (*********************************************************************)
  (* CAMPOS UTILIZADOS NA FUNCAO frmModuloPcmGer.fDefinePedidosABaixar *)
  (******************************************************************LA*)
  strSQL := strSQL + '  DET_CODITE AS ENT_CODITE, ';
  If SameText(strTabela, 'NOTDET') Then
    strSQL := strSQL + '  IFNULL(DET_NUMLOT,"") AS ENT_NUMLOT, '
  Else
    strSQL := strSQL + '  IF(DET_LOTABA <> "", DET_LOTABA, IFNULL(DET_NUMLOT,"")) AS ENT_NUMLOT, ';

  strSQL := strSQL + '  DET_QTDITE AS ENT_QTDITE, ';
  strSQL := strSQL + '  DET_UNITAR AS ENT_UNITAR, ';
  strSQL := strSQL + '  0.0000     AS ENT_PERSUB, ';
  strSQL := strSQL + '  0.0000     AS ENT_PERIPI, ';

  strSQL := strSQL + '  I.ITE_INCPIS, ';
  strSQL := strSQL + '  I.ITE_CODFOR, ';
  strSQL := strSQL + '  I.ITE_CODMAR, ';
  strSQL := strSQL + '  IFNULL(I.ITE_REAEND,"N") AS ITE_REAEND, ';
  strSQL := strSQL + '  UNI_SIGUNI AS ITE_SIGUNI, ';

  strSQL := strSQL + '  GC.GRU_OPERES AS ITE_OPERES, ';

  If blnCotDor Then
    strSQL := strSQL + '  G.ITE_PREDOL, '
  Else
    strSQL := strSQL + '  "N" AS ITE_PREDOL, ';

  strSQL := strSQL + '  G.ITE_FORULT, ';
  strSQL := strSQL + '  I.ITE_DIFICM, ';
  strSQL := strSQL + '  G.ITE_PREMED, ';
  strSQL := strSQL + '  I.ITE_RPRENT, ';

  For intCont := 1 To Length(VS_strTabPrc) Do
  Begin
    strSQL := strSQL + '  G.ITE_PREVE' + IntToStr(intCont) + ', ';
    strSQL := strSQL + '  G.ITE_MARBR' + IntToStr(intCont) + ', ';
    strSQL := strSQL + '  G.ITE_COMTB' + IntToStr(intCont) + ', ';
  End;

  strSQL := strSQL + '  G.ITE_PRECUS, ';
  strSQL := strSQL + '  G.ITE_SALDOS, ';
  strSQL := strSQL + '  G.ITE_PREMED, ';
  strSQL := strSQL + '  G.ITE_PRECOM, ';

  strSQL := strSQL + '  G.ITE_DESF01, ';
  strSQL := strSQL + '  G.ITE_DESF02, ';
  strSQL := strSQL + '  G.ITE_DESF03, ';
  strSQL := strSQL + '  G.ITE_DESF04, ';
  strSQL := strSQL + '  G.ITE_DESF05, ';
  strSQL := strSQL + '  G.ITE_DESF06, ';

  strSQL := strSQL + '  G.ITE_ICMENT, ';
  strSQL := strSQL + '  G.ITE_SUBFED, ';
  strSQL := strSQL + '  G.ITE_IPIENT, ';
  If blnAtuFre and blnPerFre Then
  Begin
    If Not blnFreIpi Then
      strSQL := strSQL + ' ( ( ( DET_TOTFRE) / (DET_TOTITE - DET_DESESP + DET_VALIPI + IFNULL(T.DET_VAEIPI, 0) + (DET_VALRET + DET_VAERET ) + DET_DESACE) ) * 100 ) AS ITE_FREENT, '
    Else
      strSQL := strSQL + ' ( ( ( DET_TOTFRE ) / (DET_TOTITE - DET_DESESP) ) * 100 )  AS ITE_FREENT, ';
    strSQL := strSQL + ' 0 AS ITE_VALFRE, ';
  End
  Else
  begin
    strSQL := strSQL + '  G.ITE_FREENT, ';
    strSQL := strSQL + '  G.ITE_VALFRE, ';
  End;

  strSQL := strSQL + '  G.ITE_ACRFIN, ';
  strSQL := strSQL + '  G.ITE_SUBSTI, ';
  strSQL := strSQL + '  G.ITE_DESADB, ';
  strSQL := strSQL + '  G.ITE_OUTVAL, ';
  If blnAtuICS Then
    strSQL := strSQL + '  ROUND(B.ABF_ALQICM_SAI_CNC * (B.ABF_BASICM_SAI_CNC / 100), 2) ITE_ICMSAI, '
  Else
  strSQL := strSQL + '  G.ITE_ICMSAI, ';
  strSQL := strSQL + '  G.ITE_IMPFED, ';
  strSQL := strSQL + '  G.ITE_DESOPE, ';
  strSQL := strSQL + '  G.ITE_DESMAX, ';
  strSQL := strSQL + '  G.ITE_MARMIN, ';
  strSQL := strSQL + '  G.ITE_TCIFCU, ';
  strSQL := strSQL + '  G.ITE_TSCUST, ';
  strSQL := strSQL + '  G.ITE_DEPICO, ';
  strSQL := strSQL + '  G.ITE_DEICMS, ';
  strSQL := strSQL + '  G.ITE_FATREG, ';

  strSQL := strSQL + '  IFNULL(ICD_BASFCP, 0) AS ICD_BASFCP, ';
  strSQL := strSQL + '  IFNULL(ICD_PERFCP, 0) AS ICD_PERFCP, ';
  strSQL := strSQL + '  IFNULL(ICD_VALFCP, 0) AS ICD_VALFCP, ';

  strSQL := strSQL + '  IFNULL(T.DET_VFCPST,0) AS DET_VFCPST, ';
  strSQL := strSQL + '  IFNULL(T.DET_BFCPST,0) AS DET_BFCPST, ';
  strSQL := strSQL + '  IFNULL(T.DET_PFCPST,0) AS DET_PFCPST, ';

  strSQL := strSQL + '  A.DET_PICMEF, ';
  strSQL := strSQL + '  A.DET_BICMEF, ';
  strSQL := strSQL + '  A.DET_AICMEF, ';
  strSQL := strSQL + '  A.DET_VICMEF, ';
  strSQL := strSQL + '  A.DET_BSTANT, ';
  strSQL := strSQL + '  I.ITE_GRAMAR, ';
  strSQL := strSQL + '  A.DET_VSTANT, ';
  strSQL := strSQL + '  A.DET_SICMEF AS DET_SICMEF, '; 

  If blnNumSer Then
  Begin
    If SameText(strTabela, 'MOVDET') Then
      strSQL := strSQL + ' (SELECT IF(COUNT(1) > 0, D.AUTOINCREM, "") AS AUTINC FROM DETSER WHERE DETSER.SER_SEQGER = D.AUTOINCREM) AS SER_NUMSER,  '
    Else
      strSQL := strSQL + '  CAST("" AS CHAR(1)) AS SER_NUMSER, ';
  End;

  strSQL := strSQL + ' (SELECT SEQ_PCMDET FROM SEQGAR WHERE SEQ_DET_TE = D.AUTOINCREM) AS ENT_SEQPCD ';

  strSQL := strSQL + ' FROM ' + strTabela + ' D ';

  strSQL := strSQL + ' LEFT JOIN ' + fRetNomTabMovTri(strTabela) + ' T ON T.DET_SEQGER = D.AUTOINCREM ';

  strSQL := strSQL + ' INNER JOIN CADITE I ON I.ITE_CODITE = DET_CODITE ';
  strSQL := strSQL + ' INNER JOIN ITEGER G ON G.ITE_CODITE = DET_CODITE AND ';
  strSQL := strSQL + '                        G.ITE_CODEMP = :CODEMP        ';

  strSQL := strSQL + ' LEFT JOIN CADUNI  ON UNI_CODUNI = ITE_CODUNI ';

  strSQL := strSQL + ' LEFT JOIN GRU_COMPRA GC ON I.ITE_GRUCMP = GC.GRU_CODIGO ';

  strTabMovIcd := 'MOVICD';
  strTabMovAux := 'MOVAUX';

  If SameText(strTabela, 'NOTDET') Then
  Begin
    strTabMovIcd := 'NOTICD';
    strTabMovAux := 'NOTAUX';
  End;

  strSQL := strSQL + ' LEFT JOIN ' + strTabMovIcd + ' ON  ICD_SEQGER = D.AUTOINCREM ';

  strSQL := strSQL + ' LEFT JOIN ' + strTabMovAux + ' A ON A.DET_SEQGER = D.AUTOINCREM ';

  If blnAtuICS Then
  Begin

    If fCfgSis('TIPABF') = '1' Then
      strSQL := strSQL + '  INNER JOIN ABFICM B ON B.ABF_CODABF = I.ITE_CODABF AND '
    Else
      strSQL := strSQL + '  INNER JOIN ABFICM B ON B.ABF_CODABF = G.ITE_CODABF AND ';

    strSQL := strSQL + '                         B.ABF_ESTADO = ' + QuotedStr(fCadEmpDes('ESTADO', VS_strCodEmp));

  End;


  strSQL := strSQL + ' WHERE D.DET_SEQGER = :SEQGER ';
  strSQL := strSQL + ' AND DET_PROEMB = "N" ';
  strSQL := strSQL + ' AND DET_CODITE <> :ITESER ';
  strSQL := strSQL + ' AND DET_CODITE <> :SERTER ';
  strSQL := strSQL + ' AND IFNULL(G.ITE_TIPPRO, "") <> "'+TIPO_PRODUTO_SPED[9,0]+'" ';

  With qryMovDet.qryQuery Do
  Begin
    SQL.Text := strSQL;

    ParamByName('SEQGER').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
    ParamByName('ITESER').AsString := fCfgSis('ITESER');
    ParamByName('SERTER').AsString := fCfgSis('SERTER');
    ParamByName('CODEMP').AsString := VS_strCodEmp;
  End;

  qryMovDet.fLeDados;
End;

Function TfrmRecTransfEstoque.fRetNumLot(blnTemPedidoEnderecamento: Boolean): String;
Begin
  With qryMovDet Do
  Begin
    //Quando usa rotina WMS na empresa CD existe lote, porem nas outras empresas nao utiliza
    //cadastro de lotes. Por isso antes de gravar precisa verificar se a empresa possui o lote.
    Result := FieldByName('DET_NUMLOT').AsString;

    If Not objCadLot.fExisteLote(FieldByName('DET_CODITE').AsString, strCodEmp,
                                 FieldByName('DET_NUMLOT').AsString, False, False) Then
    Begin
      Result := '';
    End;

    // AS EMPRESAS PODEM POSSUIR LOTES DIFERENTES
    If objCadLot.fExisteLote(FieldByName('DET_CODITE').AsString, strCodEmp, '', False, False) Then
    Begin
      If (objCadLot.tplTipLot = tplArmazem) Or blnUsaRotinaWms Then
      begin
        If fEmptyStr(Result) Then
        begin
          //Se nao realiza enderecamento e possuir lote principal para compras
          //deve carregar este lote para o produto e nao realizar o enderecamento
          If (Not fRetReaEnd(qryMovDet.FieldByName('DET_CODITE').AsString)) And
             (objCadLot.fRetArmazemPrincipalCompra(qryMovDet.FieldByName('DET_CODITE').AsString) <> '') Then
            Result := objCadLot.fRetArmazemPrincipalCompra(qryMovDet.FieldByName('DET_CODITE').AsString)
          Else
          If fEmptyStr(Result) Then
            Result := 'A DEFINIR';

          If Not objCadLot.fExisteLote(FieldByName('DET_CODITE').AsString, strCodEmp, Result, False, False) Then
            raise Exception.Create('O Item [' + FieldByName('DET_CODITE').AsString +  ' - ' +
                                                FieldByName('DET_DESCRI').AsString  + '] não tem um lote [A DEFINIR] cadastrado.');

        End
        Else If (objCadLot.tplTipLot = tplArmazem) And (Not fEmptyStr(Result)) Then
        Begin
          If (Not fRetReaEnd(qryMovDet.FieldByName('DET_CODITE').AsString)) And
             (objCadLot.fRetArmazemPrincipalCompra(qryMovDet.FieldByName('DET_CODITE').AsString) <> '') Then
            Result := objCadLot.fRetArmazemPrincipalCompra(qryMovDet.FieldByName('DET_CODITE').AsString)
          Else
            Result := 'A DEFINIR';
        End
        {Existe o Lote na empresa de destino, se uitliza wms, valida se gera endereçamento e coletor, se sim, altera o lote para A Definir}
        Else If (Not fEmptyStr(Result)) And fGeraAgendamento Then
        Begin
          If fRetReaEnd(FieldByName('DET_CODITE').AsString) Then
             Result := 'A DEFINIR';

          If Not objCadLot.fExisteLote(FieldByName('DET_CODITE').AsString, strCodEmp, Result, False, False) Then
            raise Exception.Create('O Item [' + FieldByName('DET_CODITE').AsString +  ' - ' +
                                                FieldByName('DET_DESCRI').AsString  + '] não tem um lote [A DEFINIR] cadastrado.');
        End;
      End
      //Armazem
      Else If fCfgSis('CTLEST') = '2' Then
      begin
        Result := 'A DEFINIR';
        If Not objCadLot.fExisteLote(FieldByName('DET_CODITE').AsString, strCodEmp,
                                     Result, False, False) Then
           raise Exception.Create('O Item [' + FieldByName('DET_CODITE').AsString +  ' - ' +
                                               FieldByName('DET_DESCRI').AsString  + '] não tem um lote [A DEFINIR] cadastrado.');
       End;

      If fEmptyStr(Result) Then
      Begin
        //Gera endereçamento
        If fRetReaEnd(FieldByName('DET_CODITE').AsString) And (blnTemPedidoEnderecamento) Then
        Begin
          Result := 'A DEFINIR';
        End
        Else
        Begin
          If (objCadLot.fExisteLotePrincipalCompra(FieldByName('DET_CODITE').AsString,strCodEmp ) <> '') Then
            Result := objCadLot.fExisteLotePrincipalCompra(FieldByName('DET_CODITE').AsString, strCodEmp)
          Else
          Begin
            raise Exception.Create('O Item [' + FieldByName('DET_CODITE').AsString +  ' - ' +
                                               FieldByName('DET_DESCRI').AsString  + '] não tem um lote Princial de compra cadastrado.');
          End;
        End;
      End;
    End; {If objCadLot.fExisteLote(FieldByName('DET_CODITE').AsString, strCodEmp, '', False, False) Then}

  End;
End;

function TfrmRecTransfEstoque.fRetReaEnd(strCodIte: String): Boolean;
begin
  Result := False;
  If blnEntEnd Then
    Result := (fCampoTabela('IFNULL(ITE_REAEND,"N")', 'CADITE', ['ITE_CODITE'], [strCodIte]) = 'S');
end;

function TfrmRecTransfEstoque.fTemMamoreNaEntradasSimplificada: Boolean;
begin
  qryMovDet.First;
  Try
    Result := False;
    While not qryMovDet.Eof Do
    begin
      If qryMovDet.FieldByName('ITE_GRAMAR').AsString = 'S' then
      Begin
        Exit(True);
      End;
      qryMovDet.Next;
    End;
  Finally
    qryMovDet.First;
  End;
end;

Function TfrmRecTransfEstoque.fTemMargemNegativa(recPrecos: TarrPrecos): Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;

  For intContador := 1 To Length(VS_strTabPrc) Do
    If (VS_strTabPrc[intContador] = 'S') And (recPrecos[intContador].fltMarBru < 0) Then
    Begin
      Result := True;
      Exit;
    End;
End;

Procedure TfrmRecTransfEstoque.pIncluiMargemNegativa(cdsMarNeg: TZClient; recPrecos: TarrPrecos; fltPreCus: Double);
  Var
    intContador: Integer;
Begin

  With qryMovDet Do
  Begin
    cdsMarNeg.Append;

    cdsMarNeg.FieldByName('ITE_CODITE').AsString := FieldByName('DET_CODITE').AsString;
    cdsMarNeg.FieldByName('ITE_DESITE').AsString := FieldByName('DET_DESCRI').AsString;
    cdsMarNeg.FieldByName('ITE_SIGUNI').AsString := FieldByName('ITE_SIGUNI').AsString;
    cdsMarNeg.FieldByName('ITE_PRECUS').AsFloat  := fltPreCus;

    For intContador := 1 To 7 Do
    Begin
      cdsMarNeg.FieldByName('ITE_PREVE' + IntToStr(intContador)).AsFloat := recPrecos[intContador].fltPreVen;
      cdsMarNeg.FieldByName('ITE_MARBR' + IntToStr(intContador)).AsFloat := recPrecos[intContador].fltMarBru;
    End;

    cdsMarNeg.Post;
  End;

End;

Function TfrmRecTransfEstoque.fGravaMovDet(blnTesteMargem: Boolean = False; blnOscilacaoPrecoMedio: Boolean = False): Boolean;
  Var
    blnFilKar: Boolean;
    CalcResult: TResultPisCofins;
    tmp: TCalculoPisCofins;
    dtaDtaDoc: TDateTime;
    strNumLot: String;

    blnGerarPedido,
    blnAtualizouPreco,
    blnAltPre,
    blnUpdatePreMed,
    blnUtiAbI,
    blnFinalizar: Boolean;

    recPrecos: TArrPrecos;
    intContador3: Integer;
    fltPreCom,
    fltPreCus,
    fltValIcm,
    fltAlqIcm,
    fltBasIcm,
    fltISEICM,
    fltVaeRet,
    fltAleRet,
    fltBaeRet,

    fltPremedAtu,
    fltPreMedNov,
    fltPreUltOriginal,
    fltPreImpUltOriginal,
    fltBasRet,
    fltAlqRet,
    fltValRet,
    fltOutIcm,
    fltOutIse: Double;

    strSeqDetOriginal: String;

    cdsMarNeg: TZClient;
    strSitP_C: String;
    strTipBus: String;
    strCSTIpi,
    strEnqIpi: String;

    blnIsentas: Boolean;
    objExcecaoCfopCst: TCfgCfopCst;
    CalculoPrecoMediAgrup: TCalculoPrecoMediAgrup;
    fltTotMed: Double;
    cdsItens: TUniClientDataSet;

    blnGeraEnderecamento: Boolean;
    objRefIte: TMovDetParams;
    function fDocumentoGeraEnderecamento: Boolean;
    begin
      If (Not (fCfgSis('MARMOR', varBoolean))) And (Not blnEntEnd) Then
        Exit(False);

       blnMarmore := (fCfgSis('MARMOR', varBoolean) And (fTemMamoreNaEntradasSimplificada));
       If  blnMarmore then
         Exit(True);


      (*Result := True;

      If blnUsaRotinaWms Then
      Begin
        If fConferenciaDepoisDaEntrada Then
          Result := False;
        Exit;
      End; *)

      Result := ((fCfgSis('USACON', varBoolean)) And (Pos(fCfgSis('CONFME'), '1_3_') > 0)) and (not blnGarantia);

      {*************************************************************************************************************}
      {* QUANDO USA ROTINA WMS SEMPRE DEVE ENDERECAR OS PRODUTOS, POIS SOMENTE PERMITE LOTE "A DEFINIR" NA ENTRADA *}
      {**********************************************************************************************************JC*}
      If blnUsaRotinaWms Then
      Begin
        If fConferenciaDepoisDaEntrada And (not blnGarantia) Then
          Result := False
        Else
          Result := not blnGarantia;
      End
      Else If Result And fConferenciaDepoisDaEntrada Then
      Begin
        Result := blnGarantia;
      End;

    end;

    procedure pDeletaPedidoReservaAntigo;
    var
      qryGenGer, qryGenDel : TUniQuery;
    Begin
      try
        qryGenGer := fCriaQuery(Nil);
        qryGenDel := fCriaQuery(Nil);

        qryGenGer.SQL.Clear;
        qryGenGer.SQL.Add('SELECT FGO_SEQFGO ');
        qryGenGer.SQL.Add('  FROM DEL_EXTGOR ');
        qryGenGer.SQL.Add(' WHERE FGO_DOCEND  = :NUMDOC ');

        qryGenGer.ParamByName('NUMDOC').AsString :=  objEnderecamento.strDocumento;
        qryGenGer.Close;
        qryGenGer.Open;

        If (Not qryGenGer.IsEmpty) Then
        Begin

          qryGenGer.First;
          While Not qryGenGer.Eof Do
          Begin
            qryGenDel.SQL.Clear;
            qryGenDel.SQL.Add('DELETE FROM DEL_FATGOR WHERE AUTOINCREM = :AUTINC ');
            qryGenDel.ParamByName('AUTINC').AsString :=  qryGenGer.FieldByName('FGO_SEQFGO').AsString;
            qryGenDel.ExecSQL;

            qryGenDel.SQL.Clear;
            qryGenDel.SQL.Add('DELETE FROM DEL_AUXGOR WHERE AUX_SEQGER = :AUTINC ');
            qryGenDel.ParamByName('AUTINC').AsString :=  qryGenGer.FieldByName('FGO_SEQFGO').AsString;
            qryGenDel.ExecSQL;

            qryGenDel.SQL.Clear;
            qryGenDel.SQL.Add('DELETE FROM DEL_EXTGOR WHERE FGO_SEQFGO = :AUTINC ');
            qryGenDel.ParamByName('AUTINC').AsString :=  qryGenGer.FieldByName('FGO_SEQFGO').AsString;
            qryGenDel.ExecSQL;

            qryGenDel.SQL.Clear;
            qryGenDel.SQL.Add('DELETE FROM DEL_FATDOR WHERE FDO_SEQGER = :AUTINC ');
            qryGenDel.ParamByName('AUTINC').AsString :=  qryGenGer.FieldByName('FGO_SEQFGO').AsString;
            qryGenDel.ExecSQL;

            qryGenGer.Next;
          End;

        End;

      finally
        FreeAndNil(qryGenGer);
        FreeAndNil(qryGenDel);
      End;
    End;

    procedure pCriaCampo(strNome: String; fdtTipo: TFieldType; intTamanho: Integer);
    begin
      With cdsItens.FieldDefs.AddFieldDef Do
      Begin
        Name     := strNome;
        DataType := fdtTipo;
        If intTamanho > 0 Then
          Size   := intTamanho;
      End;
    end;

    procedure pCriaDataSetItensPremed;
    Begin
      cdsItens := TUniClientDataSet.Create(Nil);
      pCriaCampo('CODITE', ftString, fTamCodIte);
      pCriaCampo('DESITE', ftString, 80);
      pCriaCampo('SIGUNI', ftString, 06);
      pCriaCampo('CLAFIS', ftString, 05);
      pCriaCampo('QTDITE', ftFloat,  00);
      pCriaCampo('MEDATU', ftFloat,  00);
      pCriaCampo('MEDNOV', ftFloat,  00);
      pCriaCampo('OSCILA', ftFloat,  00);
      pCriaCampo('AUTINC', ftString, 20);
      cdsItens.CreateDataSet;
      TFloatField(cdsItens.FieldByName('QTDITE')).DisplayFormat := '#,####0.0000';
      TFloatField(cdsItens.FieldByName('MEDATU')).DisplayFormat := '#,####0.0000';
      TFloatField(cdsItens.FieldByName('MEDNOV')).DisplayFormat := '#,####0.0000';
      TFloatField(cdsItens.FieldByName('OSCILA')).DisplayFormat := '#,####0.0000';
    End;

Begin
  blnGeraEnderecamento := False;
  blnGerarPedido := False;
  dtaDtaDoc := Vs_Date;
  strAgrupadorPreAlt:='';
  CalculoPrecoMediAgrup := TCalculoPrecoMediAgrup.Create;

  fltTotPis := 0;
  fltTotCof := 0;
  fltTotBasPis := 0;
  fltTotBasCof := 0;
  fltTotAlqPis := 0;
  fltTotAlqCof := 0;

  blnUtiAbI := fCfgSis('UTIABI', varBoolean);

  pAbreMovDet(strArqTabDetOri);

  If Assigned(pgbGravando) Then
    pgbGravando.Properties.Max := qryMovDet.RecordCount + 3; // Pedido + CadFis + Financeiro

  Result := False;

  cdsMarNeg := Nil;

  If blnTesteMargem Then
  Begin
    If Assigned(frmGravando) Then
      frmGravando.lblGravando.Caption := 'Avaliando margem dos produtos, aguarde...';
    Application.ProcessMessages;

    cdsMarNeg := TProdMargemNegativa.fCriaDadosItem('');

  End
  Else if blnOscilacaoPrecoMedio Then
  Begin
    If Assigned(frmGravando) Then
      frmGravando.lblGravando.Caption := 'Avaliando oscilação do preço médio dos produtos, aguarde...';
    Application.ProcessMessages;

    pCriaDataSetItensPremed;
  End
  Else
  Begin
    If Assigned(frmGravando) Then
      frmGravando.lblGravando.Caption := 'Gravando, aguarde...';
    Application.ProcessMessages;

    qryMovDet.First;
    While Not qryMovDet.Eof Do
    Begin
      qryMovDet.Edit;
      qryMovDet.FieldByName('AUTOINCREMENTO_GRAVACAO').AsString := fRetAutoIncrem('MOVDET', strCodEmp);
      qryMovDet.Post;
      qryMovDet.Next;
    End;

    qryMovDet.First;

    blnGeraEnderecamento := fDocumentoGeraEnderecamento;

    If blnGeraEnderecamento Then
    Begin
      If blnUsaRotinaWms Then
         pValidarLotesADefinir;

      objEnderecamento := TEnderecamentoProduto.Create;

      //gera o enderecamento dos produtos
      If Not fGerarPedidosReservaEstoque(strNumDoc, strEspDoc, strSerie, strCodFor, blnGerarPedido) Then
      Begin
        If Assigned(objEnderecamento) Then
          FreeAndNil(objEnderecamento);

        If Assigned(cdsMarNeg) Then
          FreeAndNil(cdsMarNeg);

        If blnOscilacaoPrecoMedio And Assigned(cdsItens) Then
          FreeAndNil(cdsItens);

        FreeAndNil(CalculoPrecoMediAgrup);

        Exit;
      End;

    End;

  End;

  blnFinalizar := True;

  qryMovDet.First;

  pPreAltDefineVariaveisAltPre(fNow, 'TRANSFERENCIA DE ESTOQUE', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);


  strSitP_C := fDefineSit_P_C(VS_strCodEmp, strCodFor);

  With qryMovDet Do
  While (Not Eof) Do
  Begin
    qryIteGer.Close;
    qryIteGer.ParamByName('CODITE').AsString := FieldByName('DET_CODITE').AsString;
    qryIteGer.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryIteGer.Open;

    If Not IsItemAtivo(qryMovDet.FieldByName('DET_CODITE').AsString) Then
    Begin
      Result := False;
      blnFinalizar := False;
      fRollBack;

      fMensagem('ATENÇÃO!', 'O item ' + qryMovDet.FieldByName('DET_CODITE').AsString + ' está Inativo! Verifique o cadastro.', ['&O k']);
      Break;
    End;

    blnFilKar := (Not fEmptyStr(FieldByName('DET_CODACA').AsString)) And (intESTFLJ = 1);

    strClaFisDet := '';
    If fTranferenciaAutomaticaFulfillment And (qryCFOPDoc.IsEmpty) Then
      pCarregaCFOPS(qryMovDet.qryQuery.ParamByName('SEQGER').Value, 'MOVDET');

      If fRegimeSubstituicaoTributaria = '1' Then
      Begin
        fltVaeRet := qryMovDet.FieldByName('DET_VALRET').AsFloat + qryMovDet.FieldByName('DET_VAERET').AsFloat;
        fltAleRet := IIf(qryMovDet.FieldByName('DET_ALQRET').AsFloat <> 0,
                         qryMovDet.FieldByName('DET_ALQRET').AsFloat,
                         qryMovDet.FieldByName('DET_ALERET').AsFloat);
        fltBaeRet := qryMovDet.FieldByName('DET_BASRET').AsFloat + qryMovDet.FieldByName('DET_BAERET').AsFloat;

        fltBasRet := 0;
        fltAlqRet := 0;
        fltValRet := 0;
      End
      Else
      Begin
        fltVaeRet := 0;
        fltAleRet := 0;
        fltBaeRet := 0;

        fltBasRet := qryMovDet.FieldByName('DET_BASRET').AsFloat + qryMovDet.FieldByName('DET_BAERET').AsFloat;
        fltAlqRet := IIf(qryMovDet.FieldByName('DET_ALQRET').AsFloat <> 0,
                         qryMovDet.FieldByName('DET_ALQRET').AsFloat,
                         qryMovDet.FieldByName('DET_ALERET').AsFloat);
        fltValRet := qryMovDet.FieldByName('DET_VALRET').AsFloat + qryMovDet.FieldByName('DET_VAERET').AsFloat;

      End;



    If fTranferenciaAutomaticaFulfillment Then
    Begin
      intContador3 := fLocalizaDadLivFull(qryMovDet.FieldByName('DET_CLAFIS').AsString, qryMovDet.FieldByName('DET_ALQICM').AsFloat);
      strClaFisDet := ArrDadLivFull[intContador3].strClaFisEntra;
    End;

    If strClaFisDet = '' Then
      strClaFisDet := fTrocaClaFis(FieldByName('DET_CLAFIS').AsString);

    If AnsiEndsText('933', strClaFisDet) Then
      blnFilKar    := True;

    If Pos(strClaFisDet, '1922_2922_') > 0 Then
      blnFilKar    := True;

    If fConferenciaDepoisDaEntrada Then
      blnFilKar := True;

    If fIsItemEspecial(FieldByName('DET_CODITE').AsString) Then
      blnFilKar := True;

    If FindField('DET_DTADOC') <> Nil Then
      dtaDtaDoc := FieldByName('DET_DTADOC').AsDateTime
    Else
      dtaDtaDoc := FieldByName('DET_DTAENT').AsDateTime;

    tmp := TCalculoPisCofins.Create;
    tmp.blnGerarException := True;

    CalcResult := tmp.fCalculoPisCofins(strCodEmp,FieldByName('DET_CODITE').AsString,
                                        strClaFisDet,
                                        FieldByName('DET_CODFIS').AsString,
                                        strCodFor,IIf(fCfgSis('SIMPAU',varBoolean) and (fCfgSis('IGNSIM') = '1'), 'S', 'N'),
                                        strEspDoc,FieldByName('DET_TOTITE').AsFloat,
                                        FieldByName('DET_DESESP').AsFloat,FieldByName('DET_VALIPI').AsFloat,
                                        FieldByName('DET_VALRET').AsFloat + IIf(FieldByName('DET_VALRET').AsFloat > 0, FieldByName('DET_VFCPST').AsFloat, 0),
                                        FieldByName('DET_TOTFRE').AsFloat,
                                        FieldByName('DET_DESACE').AsFloat,
                                        FieldByName('DET_VALICM').AsFloat,
                                        0,
                                        'F',FieldByName('DET_INCPIS').AsString, strSitP_C, '',
                                        dtaDtaEnt,
                                        '',
                                        False,
                                        False,
                                        '',
                                        '',
                                        '',
                                        '',
                                        False,
                                        FieldByName('DET_CODFIS').AsString,
                                        FieldByName('DET_VALICM').AsFloat);
    tmp.Destroy;

    Result := CalcResult.blnResult;

    If Not Result Then
      Break;

    If CalcResult.dblBasePis > 0 Then
    Begin
      fltTotAlqPis := CalcResult.dblAlqPis;
      fltTotAlqCof := CalcResult.dblAlqCof;
    End;

    fltTotBasPis := fltTotBasPis + CalcResult.dblBasePis;
    fltTotBasCof := fltTotBasCof + CalcResult.dblBaseCof;
    fltTotPis := fltTotPis + CalcResult.dblValorPis;
    fltTotCof := fltTotCof + CalcResult.dblValorCof;

    If FieldByName('DET_IDEPRO').AsString <> 'NOR' Then
    Begin
      If (Assigned(fTintaBaixaProduto)) Then
        If Not IsTintaExistente(qryMovDet.FieldByName('DET_IDEPRO').AsString) Then
        Begin
          Result := False;
          Break;
        End;
    End;

    strNumLot := fRetNumLot(blnGerarPedido);
    If blnGarantia Then
      strNumLot := objCadLot.fRetArmazemPrincipalGarantia(FieldByName('DET_CODITE').AsString);

    blnUpdatePreMed := False;

    objOrdPro.pLimpaDados;
    fltPremedAtu := qryIteGer.FieldByName('ITE_PREMED').AsFloat;
    fltPreMedNov := qryIteGer.FieldByName('ITE_PREMED').AsFloat;
    fltPreUltOriginal := qryIteGer.FieldByName('ITE_PREULT').AsFloat;
    fltPreImpUltOriginal := qryIteGer.FieldByName('ITE_IMPULT').AsFloat;
    strSeqDetOriginal :=  qryIteGer.FieldByName('DET_SEQDET').AsString;

    fltTotMed := fltPremedAtu * qryMovDet.FieldByName('DET_QTDITE').AsFloat;
    If CalculoPrecoMediAgrup.CalculoPreMed[FieldByName('DET_CODITE').AsString, ''].blnEncontrado Then
    Begin
      fltTotMed := CalculoPrecoMediAgrup.CalculoPreMed[qryMovDet.FieldByName('DET_CODITE').AsString, ''].PrecoMedioAnterior * qryMovDet.FieldByName('DET_QTDITE').AsFloat;

      fltPremedAtu := CalculoPrecoMediAgrup.CalculoPreMed[qryMovDet.FieldByName('DET_CODITE').AsString, ''].fltPreMedOriginal;
      fltPreUltOriginal := CalculoPrecoMediAgrup.CalculoPreMed[qryMovDet.FieldByName('DET_CODITE').AsString, ''].fltPreUltOriginal;
      fltPreImpUltOriginal := CalculoPrecoMediAgrup.CalculoPreMed[qryMovDet.FieldByName('DET_CODITE').AsString, ''].fltPreImpUltOriginal;
      strSeqDetOriginal :=  CalculoPrecoMediAgrup.CalculoPreMed[qryMovDet.FieldByName('DET_CODITE').AsString, ''].strSeqDetOriginal
    End;


    Result := fAtualizaProduto(strNumLot, blnUpdatePreMed, recPrecos,
                               fltPreCom, fltPreCus, fltPreMedNov, blnAltPre, blnAtualizouPreco,
                               (blnTesteMargem Or blnOscilacaoPrecoMedio),
                               CalculoPrecoMediAgrup);

    If Result And (Not fEmptyStr(objOrdPro.strCodPro)) Then
      blnFilKar := True;

    If Not Result Then
      Break;

    if blnTesteMargem then
    Begin
      If Assigned(cdsMarNeg) Then
      Begin

        If blnAtualizouPreco And fTemMargemNegativa(recPrecos) Then
          pIncluiMargemNegativa(cdsMarNeg, recPrecos, fltPreCus);

      End;
    End
    Else If blnOscilacaoPrecoMedio Then
    begin
      If Assigned(cdsItens)Then
      Begin
        CalculoPrecoMediAgrup.pSetPreMedOri(qryMovDet.FieldByName('DET_CODITE').AsString,
                                            fltPremedAtu,
                                            fltPreUltOriginal,
                                            fltPreImpUltOriginal,
                                            strSeqDetOriginal);

        If (fCampoTabela('ITE_PREMED', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [qryMovDet.FieldByName('DET_CODITE').AsString, VS_StrCodEmp]) > 0) And
           (fEmptyStr(qryMovDet.FieldByName('DET_CODACA').AsString)) Then
        Begin
          fltOscila := RoundTo(((fltPreMedNov / qryMovDet.FieldByName('ITE_PREMED').AsFloat) - 1) * 100 , -4);

          If Abs(RoundTo(fltOscila, -4)) > Abs(RoundTo(fltOscMed, -4)) Then
          Begin
            If (qryMovDet.FieldByName('ITE_RPRENT').AsString = 'S') Then
            Begin
              cdsItens.Append;
              cdsItens.FieldByName('CODITE').AsString := qryMovDet.FieldByName('DET_CODITE').AsString;
              cdsItens.FieldByName('DESITE').AsString := qryMovDet.FieldByName('DET_DESCRI').AsString;
              cdsItens.FieldByName('SIGUNI').AsString := fRetSiglaUni(FieldByName('DET_UNIDAD').AsString);
              cdsItens.FieldByName('CLAFIS').AsString := qryMovDet.FieldByName('DET_CLAFIS').AsString;
              cdsItens.FieldByName('MEDATU').AsFloat  := qryMovDet.FieldByName('ITE_PREMED').AsFloat;
              cdsItens.FieldByName('QTDITE').AsFloat  := qryMovDet.FieldByName('DET_QTDITE').AsFloat;
              cdsItens.FieldByName('MEDNOV').AsFloat  := fltPreMedNov;
              cdsItens.FieldByName('OSCILA').AsFloat  := fltOscila;
              cdsItens.FieldByName('AUTINC').AsString := qryMovDet.FieldByName('AUTOINCREM').AsString;
              cdsItens.Post;
            End;
          End;
        End;
      End;
    End
    Else
    Begin
      blnSubstituido := (Pos(FieldByName('DET_CODFIS').AsString, CST_SUBSTITUICAO) > 0);
      If (blnSubstituido) Or (blnSimPau) Or ((fFornecedorFilial(strCodFor)) And ((fCfgSis('SIMPAU', varBoolean)) And (fCfgSis('IGNSIM') = '1')))
              Or (FieldByName('ITE_DIFICM').AsString = 'S')  Then
      Begin
        fltValIcm := 0;
        fltAlqIcm := 0;
        fltBasIcm := 0;
        fltOutIcm := fRetornaValorOutras(FieldByName('DET_VLRCON').AsFloat,
                                         0,
                                         FieldByName('DET_VALIPI').AsFloat,
                                         FieldByName('DET_VALRET').AsFloat,
                                         FieldByName('DET_VAERET').AsFloat,
                                         FieldByName('DET_VAEIPI').AsFloat,
                                         FieldByName('DET_VFCPST').AsFloat);

        fltISEICM := 0;
      End Else
      Begin
        fltValIcm := FieldByName('DET_VALICM').AsFloat;
        fltAlqIcm := FieldByName('DET_ALQICM').AsFloat;
        fltBasIcm := FieldByName('DET_BASICM').AsFloat;
        fltOutIcm := FieldByName('DET_OUTICM').AsFloat;
        fltISEICM := FieldByName('DET_ISEICM').AsFloat;
      End;
      fltOutIse := fltOutIcm + fltISEICM;

      If fltOutIse > 0 Then
      Begin

        objExcecaoCfopCst := TCfgCfopCst.Create(Nil, True);
        Try
          objExcecaoCfopCst.fCarregaDados;
          If objExcecaoCfopCst.fExcecaoDefinida(strClaFisDet, FieldByName('DET_CODFIS').AsString) Then
            blnIsentas := objExcecaoCfopCst.blnIsentas
          Else
            blnIsentas := fCodFisGravaIsentoDocEnt(strClaFisDet, FieldByName('DET_CODFIS').AsString);
        Finally
          FreeAndNil(objExcecaoCfopCst)
        End;

        If blnIsentas Then
        Begin
          fltISEICM := fltOutIse;
          fltOutIcm := 0;
        End
        Else
        Begin
          fltOutIcm := fltOutIse;
          fltISEICM := 0;
        End;
      end;

      strAutIncTmp := FieldByName('AUTOINCREMENTO_GRAVACAO').AsString;

      strTipBus := '';
      If objConEnt.Active Then
      Begin
        objConEnt.Locate('CODITE',FieldByName('DET_CODITE').AsString, []);
        strTipBus := objConEnt.FieldByName('TIPBUS').AsString;
      End;

      strCSTIpi := '';
      strEnqIpi := '';
      If blnUtiAbI Then
      Begin
        If Not fRetornaCSTIPI(FieldByName('ENT_CODITE').AsString, strClaFisDet, strCSTIpi, strEnqIpi) Then
        Begin
          blnFinalizar := False;
          Result := False;
          fRollBack;

          fMensagem('ATENÇÃO!','Abreviação de IPI não configurada.'+ #13+#10 +
                               'Favor verificar cadastros de abreviação e produto.'+ #13+#10 +
                               'CFOP IPI ENTRADA: ' + strClaFisDet + #13+#10 +
                               'PRODUTO: ' + FieldByName('ENT_CODITE').AsString + ' ', ['&O k']);
          Break;
        End;
      End;


      If Length(strClaFisDet) < 4 Then
        raise Exception.Create('Foi encotrado um falha ao definir o CFOP da entrada, CFOP definido ['+strClaFisDet+']');
      pCarregaRefTribItemOrigem(FieldByName('AUTOINCREM').AsString, objRefIte);
      Result := untMovGer.fGravaMovDet(strAutIncTmp,                                                   // Retorna Auto-Incremento por Referencia
                                       strAutInc,                                                      // Sequencial do Arquivo Geral
                                       strNumDoc,                                                      // Numero do Documento
                                       strEspDoc,                                                      // Espécie
                                       strCodEmp,                                                      // Empresa
                                       FieldByName('DET_CODITE').AsString,                             // Cód. Item
                                       strCodOpe,                                                      // Vendedor
                                       '',                                                             // Código Diversos
                                       FieldByName('DET_CODMAR').AsString,                             // Código da Marca
                                       strCodFor,                                                      // Fornecedor
                                       '',                                                             // Cliente
                                       IIF(fConferenciaDepoisDaEntrada, 0, dtaDtaEnt),                 // Data da Entrada
                                       IIF(fConferenciaDepoisDaEntrada, 0, fTime()),                   // Hora da Entrada
                                       dtaDtaDoc,                                                      // Data do Documento
                                       strCndPag,                                                      // Condição de Pagamento
                                       'F',                                                            // Tipo: (C)liente / (F) Fornecedor
                                       strEstFor,                                                      // Estado do Fornecedor
                                       FieldByName('DET_DESCRI').AsString,                             // Descrição do Item
                                       FieldByName('DET_REFERE').AsString,                             // Referencia do Item
                                       FieldByName('DET_UNIDAD').AsString,                             // Cód. Unidade
                                       FieldByName('DET_CODFOR').AsString,                             // Fornecedor Item
                                       FieldByName('DET_QTDITE').AsFloat,                              // Quantidade do Item
                                       FieldByName('DET_UNITAR').AsFloat,                              // Valor Unitario
                                       FieldByName('DET_UNIORI').AsFloat,                              // Valor Unitário Original
                                       FieldByName('DET_UNIVIS').AsFloat,                              // Valor Unitário Original sem juros
                                       FieldByName('DET_TOTITE').AsFloat,                              // Total do Item
                                       FieldByName('DET_VLRCON').AsFloat,                              // Valor Contábil do Item
                                       FieldByName('DET_TOTCUS').AsFloat,                              // Valor Total de Custo
                                       fltTotMed,                                                      // Valor Total Medio
                                       0.0,                                                            // % Desconto do Item
                                       FieldByName('DET_TOTFRE').AsFloat,                              // Valor do Frete
                                       FieldByName('DET_DESESP').AsFloat,                              // Valor do Desconto Especial
                                       strCodRep,                                                      // Código do Representante
                                       '',                                                             // Código do vendedor2
                                       0,                                                              // Percentual de Comissão do Vendedor
                                       0,                                                              // Total de Comissão do Vendedor
                                       0,                                                              // Total de Comissão do Vendedor 2
                                       strClaFisDet,                                                   // Classificação Fiscal
                                       FieldByName('DET_CODFIS').AsString,                             // Código Fiscal
                                       IIf(blnDeIndustriaParaRevenda, 0, FieldByName('DET_VALIPI').AsFloat),                              // Valor IPI
                                       IIf(blnDeIndustriaParaRevenda, 0, FieldByName('DET_ALQIPI').AsFloat),                              // Aliquota IPI
                                       IIf(blnDeIndustriaParaRevenda, 0, FieldByName('DET_BASIPI').AsFloat),                              // Base IPI
                                       fltValIcm,                                                      // Valor de ICMS
                                       fltAlqIcm,                                                      // Aliquota de ICMS
                                       fltBasIcm,                                                      // Base de ICMS
                                       fltValRet,                                                      // Valor de Substituição
                                       fltAlqRet,                                                      // Aliquota de Substituição
                                       fltBasRet,                                                      // Base de Substituição
                                       0.0,                                                            // Total de Peso
                                       FieldByName('DET_PERBAS').AsFloat,                              // Percentual de Base de ICMS
                                       0.0,                                                            // Percentual de Redução de Base
                                       False,                                                          // Indica se ja esta Faturado
                                       '',                                                             // Tipo de Faturamento
                                       '',                                                             // Número do Faturamento
                                       '',                                                             // Empresa do Faturamento
                                       0,                                                              // Data do Faturamento
                                       '',                                                             // Vendedor do Faturamento
                                       '',                                                             // Condição de Pagamento Faturamento
                                       0.0,                                                            // Valor do Faturamento
                                       IIf(fEmptyStr(FieldByName('DET_CODACA').AsString), 'NOR', IIf(intESTFLJ = 1, 'NOR', FieldByName('DET_IDEPRO').AsString)),  // Identificação Produto ( Normal / Outros )
                                       FieldByName('DET_INCPIS').AsString,                             // Indice se incide Pis
                                       strSerie,                                                       // Série
                                       FieldByName('DET_DESACE').AsFloat,                              // Valor de Despesa Acessória
                                       'N',                                                            // Nota Especial
                                       '',                                                             // Documento da Devolução
                                       '',                                                             // Espécie da Devolução
                                       '',                                                             // Empresa da Devolução
                                       '',                                                             // Item de Chamada (TINTA DE MAQUINA)
                                       '',                                                             // Item da Tinta (TINTA DE MAQUINA)
                                       '',                                                             // Descrição da Cor (TINTA DE MAQUINA)
                                       '',                                                             // Tipo de Embalagem (TINTA DE MAQUINA)
                                       0.0,                                                            // Quantidade de Embalagem (TINTA DE MAQUINA)
                                       0.0,                                                            // Preço da Embalagem (TINTA DE MAQUINA)
                                       '',                                                             // Tipo de Preço (TINTA DE MAQUINA)
                                       0.0,                                                            // Preço de Venda da Tinta (TINTA DE MAQUINA)
                                       0.0,                                                            // Preço de Compra da Tinta (TINTA DE MAQUINA)
                                       0.0,                                                            // Fator da Tinta (TINTA DE MAQUINA)
                                       '',                                                             // Produto Embalagem (TINTA DE MAQUINA)
                                       strCodDig,                                                      // Código do Digitador
                                       '',                                                             // Codigo da Condição
                                       '',                                                             // Forma de Pagamento
                                       '',                                                             // Item da Embalagem
                                       '',                                                             // Grupo do Item da Embalagem
                                       0,                                                              // Quarto Lazzumix
                                       '',                                                             // Item promocional? (S/N)
                                       '',                                                             // Tipo de Tinta (1 / 2)
                                       0.0,                                                            // Quantidade de Pulsos
                                       strNumPed,                                                      // Número do Pedido de Compras
                                       '',                                                             // Origem do Documento - (D)evolução / (E)ntrada / (V)enda
                                       '',                                                             // Pedido de Venda - Número
                                       '',                                                             // Pedido de Venda - Espécie
                                       '',                                                             // Pedido de Venda - Empresa
                                       0,                                                              // Pedido de Venda - Sequencial
                                       objOrdPro.strCodPro,                                            // Ordem de Produção
                                       '',                                                             // Descrição para Nota Fiscal Especial
                                       '',                                                             // CLiente de faturamento
                                       0,                                                              // Boca de caixa - valor mínimo
                                       0,                                                              // Boca de caixa - comissao
                                       0.0,                                                            // Volume a produzir (Tinta de Máquina Venda Dinâmica)
                                       FieldByName('DET_CODACA').AsString,                             // Código do produto acabado
                                       FieldByName('DET_EMPACA').AsString,                             // Empresa do produto acabado
                                       IIf(fEmptyStr(FieldByName('DET_CODACA').AsString), False, IIf(intESTFLJ = 1, True, False)), // Identificação Produto ( Normal / Outros )
                                       blnFilKar,                                                      // Filtrar na Kardex?
                                       '',                                                             //  Especie da Entrega Fututa
                                       '',                                                             //  Documento da Entrega Fututa
                                       '',
                                       '',                                                             //  Empresa da Entrega Fututa
                                       strEmpPed,                                                      //  Empresa do pedido de compra
                                       '',
                                       '',
                                       '',
                                       0.0,
                                       '',
                                       0.0,
                                       0.0,
                                       0,                                                              //intQtdPon,
                                       'N',
                                       '',
                                       0,
                                       FieldByName('DET_TOTCU2').AsFloat,
                                       0,
                                       0,
                                       '',
                                       strNumLot,
                                       'N',
                                       IIf(blnDeIndustriaParaRevenda, FieldByName('DET_VALIPI').AsFloat, 0), // Valor IPI Não Creditado
                                       IIf(blnDeIndustriaParaRevenda, FieldByName('DET_ALQIPI').AsFloat, 0), // Aliquota IPI  Não Creditado
                                       IIf(blnDeIndustriaParaRevenda, FieldByName('DET_BASIPI').AsFloat, 0), // Base IPI  Não Creditado
                                       fltPreUlt * FieldByName('DET_QTDITE').AsFloat,  // Preço de Ultima Compra
                                       fltPreUltImp * FieldByName('DET_QTDITE').AsFloat,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       CalcResult.dblAlqPis,
                                       CalcResult.dblBasePis,
                                       CalcResult.dblValorPis,
                                       CalcResult.strCstPis,
                                       CalcResult.dblAlqCof,
                                       CalcResult.dblBaseCof,
                                       CalcResult.dblValorCof,
                                       CalcResult.strCstCof,
                                       IIF(blnUtiAbI, strCSTIpi, ''),
                                       IIF(blnUtiAbI, strEnqIpi, ''),
                                       fltVaeRet,
                                       fltAleRet,
                                       fltBaeRet,
                                       0,
                                       0,
                                       '',
                                       0,
                                       FieldByName('DET_BASANT').AsFloat,  // Base do ICMS Antecipado
                                       FieldByName('DET_ICMANT').AsFloat,  // Valor do ICMS Antecipado
                                       FieldByName('DET_VENDOR').AsFloat,
                                       FieldByName('DET_OUTDES').AsFloat,
                                       0,
                                       'P',
                                       fltOutIcm,
                                       fltISEICM,
                                       0,
                                       '',
                                       CalcResult.strNatRecPis,
                                       CalcResult.strNatRecCof,
                                       '',
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       '',
                                       0,
                                       0,
                                       '',
                                       'N',
                                       'N',
                                       fltPremedAtu,
                                       fltPreUltOriginal,
                                       fltPreImpUltOriginal,
                                       strSeqDetOriginal,
                                       {strRICMPR: String =} 'N',
                                       {fltComLiq: Double =} 0,
                                       {strNcmTin: String =} '',
                                       {fltValIva: Double =} 0,
                                       {strCliBus: String =} 'N',
                                       {strTurEnt: String =} '',
                                       {strIdeDev: String =} 'NOR',
                                       {fltPeBaST: Double =} 0,
                                       {fltVal_RT: Double =} 0,
                                       {fltDesCli: Double =} 0,
                                       {fltImpPag: Double =} 0,
                                       {fltTaxJur: Double =} 0,
                                       {fltSerRat: Double =} 0,
                                       {strProBri: String =} '',
                                       {fltPonBri: Double =} 0,
                                       {fltValDif: Double =} 0,
                                       {fltVaFrAn: Double =} 0,
                                       {strLotAba: String =} '',
                                       {fltFedImp: Double =} 0,
                                       {fltEstImp: Double =} 0,
                                       {fltMunImp: Double =} 0,
                                       {strIncDev: String =} '',
                                       {strBrinde: String =} 'N',
                                       {strCodPar: String =} '',
                                       {strTipBri: String =} '',
                                       {fltIcmOrg: Double =} 0,
                                       {strBaqtze: String =} '',
                                       {strIncFut: String =} '',
                                       {fltValFle: Double =} 0,
                                       {fltTaxEnt: Double =} 0,
                                       {fltVrdIcm: Double =} 0,
                                       {fltBasVrd: Double =} 0,
                                       {strMtdIcm: String =} '',
                                       IIF(fMovimentaSubItemEmpCar(qryMovDet), 'S', 'N'), //strBxSbIt
                                       {strIteAbf: String =} '',
                                       {strAtivac: String =} 'N',
                                       {intSeqCom: integer =} 0,
                                       {fltVICMDe: Double =} 0,
                                       {strNcmIte: String =} '',
                                       {fltComDig: Double =} 0,
                                       {fltPerDig: Double =} 0,
                                       {fltIcmPav: Double =} 0,
                                       {blnIcmSai: Boolean =} False,
                                       {fltAlDifa: Double =} 0,
                                       {strAutSai: String =}
                                       FieldByName('AUTOINCREM').AsString,
                                       FieldByName('DET_BFCPST').AsFloat,
                                       FieldByName('DET_PFCPST').AsFloat,
                                       FieldByName('DET_VFCPST').AsFloat,
                                       '', //   strDadSep: String = '';
                                       '', //   strAutEle: String = '';
                                       '', //   strNotUlt: String = '';
                                       FieldByName('DET_PICMEF').AsFloat,
                                       FieldByName('DET_BICMEF').AsFloat,
                                       FieldByName('DET_AICMEF').AsFloat,
                                       FieldByName('DET_VICMEF').AsFloat,
                                       FieldByName('DET_BSTANT').AsFloat,    {fltBSTANT}
                                       FieldByName('DET_VSTANT').AsFloat,    {fltVSTANT}
                                       '',                                   {strNotC17}
                                        0,                                   {fltAlq922}
                                        0,                                   {fltDesCnd}
                                        '',                                  {strProEsp}
                                        '',                                  {strCodPro}
                                        '',                                  {strInc_Pd}
                                        FieldByName('DET_SICMEF').AsFloat,   {fltSICMEF}
                                        0,
                                        0,
                                        0, // fltVal_TS: Double = 0;
                                        '',
                                        '',
                                        0,
                                        0,
                                        '',
                                        '',
                                        0, // fltQtdCom: Double = 0;
                                        0,
                                        '',
                                        '',
                                        '',
                                        0,
                                        0,
                                        0,
                                        0,
                                        0,
                                        0,
                                        0,
                                        0,
                                        False, // blnClaRet: Boolean = False;
                                        '',
                                        '',
                                        '',
                                        '',
                                        False,  //  blnAtoDeclaratorioDF: Boolean = False;
                                        '',
                                        0,
                                        '',
                                        '',
                                        strTipBus,
                                        '',
                                        '',
                                        '',
                                        '',
                                        0,
                                        0,
                                        False, // blnAltEst: Boolean = False;
                                        0,
                                        FieldByName('N_ITEM').AsInteger,
                                        0, // fltICMCFR: Double = 0;
                                        0, // fltFreteCalc: Double = 0;
                                        0, // fltFreConCalc: Double = 0;
                                        'N', // strPegou_ : String = 'N';
                                        0, // fltVFCPOP: Double = 0;
                                        0, // fltVFCPDF: Double = 0;
                                        0, // fltCubage: Double = 0;
                                        0, // fltCfbIpi: Double = 0;
                                        0, // fltCfaIpi: Double = 0;
                                        0, // fltCfvIpi: Double = 0;
                                        'N', // strCipiOK: String = 'N';
                                        '', // strDocIpi: String = '';
                                        '', // strEspIpi: String = '';
                                        '', // strEmpIpi: String = '';
                                        0, // intRemFil: Integer = 0;
                                        0, // fltQtdRemFil: Double = 0;
                                        False, // blnFulfillmentModoRobo: Boolean = False;
                                        True, // blnFilFul: Boolean = True;
                                        False, // blnBaiDev: Boolean = False;
                                        '', // strAutEnt: String = '';
                                        0, // dtaDtaCmp: TDateTime = 0;
                                        '', // strFullHubMkp: String = '';
                                        0, // fltOutValPD: Double = 0;
                                        '', // strFilFul_EntSai: String = '';
                                        '', // strIncOri: String = '';
                                        '', // strTckQbt: String = '';
                                        'N', // strEntTri: String = 'N';
                                        '', // strFulDif: String = '';
                                        '', // strClaFat
                                        IIF(FieldByName('DET_VALICM').AsFloat > 0, 0, FieldByName('DET_ICMNCR').AsFloat), // fltICMNCR
                                        IIF(FieldByName('ICD_VALFCP').AsFloat > 0, 0, FieldByName('DET_FCPNCR').AsFloat), // fltFCPNCR
                                        'N',   // strColoranteDeEntregaFutura
                                        '',    // strCbenef
                                        '',    // strCodPre
                                        0,     // fltBasPre
                                        0,     // fltPerPre
                                        0,     // fltValPre
                                        '',    // strCodCmg
                                        0,     // fltVimRet
                                        0,     // dobQIcmsMonRet
                                        0,     // dobAdBcMonRet
                                        0,     // dobVrEmIcmsRet
                                        0,     // fltValSeg
                                        0,     // fltPerDif
                                        0,     // fltAlqSTXML
                                        0,     // fltCliDes
                                        objRefIte.strRefCodCst,   // {Req. 410371 - MOVREF}
                                        objRefIte.strRefClaTri,
                                        objRefIte.fltRefValOpe,
                                        objRefIte.fltRefBasCal,
                                        objRefIte.fltRefCbsAlq,
                                        objRefIte.fltRefCbsAlD,
                                        objRefIte.fltRefCbsVlD,
                                        objRefIte.fltRefCbsAlR,
                                        objRefIte.fltRefCbsVlT,
                                        objRefIte.fltRefCbsAlE,
                                        objRefIte.fltRefCbsVal,
                                        objRefIte.fltRefIbsUfA,
                                        objRefIte.fltRefIbsUfD,
                                        objRefIte.fltRefIbsUvD,
                                        objRefIte.fltRefIbsUfR,
                                        objRefIte.fltRefIbsUfT,
                                        objRefIte.fltRefIbsUfE,
                                        objRefIte.fltRefIbsUfV,
                                        objRefIte.fltRefIbsMnA,
                                        objRefIte.fltRefIbsMnD,
                                        objRefIte.fltRefIbsMvD,
                                        objRefIte.fltRefIbsMnR,
                                        objRefIte.fltRefIbsMnT,
                                        objRefIte.fltRefIbsMnE,
                                        objRefIte.fltRefIbsMnV,
                                        objRefIte.strRefSelCst,
                                        objRefIte.strRefSelCla,
                                        objRefIte.fltRefSelBas,
                                        objRefIte.fltRefSelAlq,
                                        objRefIte.fltRefSelVal,
                                        objRefIte.strRefTriReg,
                                        objRefIte.strRefCrePre,
                                        objRefIte.strRefMonoFa,
                                        objRefIte.fltRefValIbs,
                                        objRefIte.strRefCesBas,
                                        objRefIte.strRefCstReg,
                                        objRefIte.strRefClaReg,
                                        objRefIte.fltRefAiuReg,
                                        objRefIte.fltRefTiuReg,
                                        objRefIte.fltRefAimReg,
                                        objRefIte.fltRefTimReg,
                                        objRefIte.fltRefCbsReg,
                                        objRefIte.fltRefTcbReg,
                                        0,     // fltIcmPrd
                                        0,     // fltSiscomex
                                        '',    // strChvRef
                                        '',    // strIteRef
                                        Nil,   // ABatch
                                        0,     // fltBimRet
                                        0,     // fltAimRet
                                        True); // blnRefEspelhaDocumento

      CalculoPrecoMediAgrup.pSetPreMedOri(qryMovDet.FieldByName('DET_CODITE').AsString,
                                          fltPremedAtu,
                                          fltPreUltOriginal,
                                          fltPreImpUltOriginal,
                                          strSeqDetOriginal);

      If (Result)  Then
        pGravarICMSUFDest(strAutIncTmp,
                          'MOVICD',
                          0,
                          qryMovDet.FieldByName('ICD_PERFCP').AsFloat,
                          0,
                          0,
                          0,
                          qryMovDet.FieldByName('ICD_VALFCP').AsFloat,
                          0,
                          0,
                          qryMovDet.FieldByName('ICD_BASFCP').AsFloat);

      If blnUpdatePreMed Then
        Result := Result And fGravaCalcPreMed(strAutIncTmp, 'TfrmRecTransfEstoque.fAtualizaProduto', '',True);

      If blnAtpRen And blnGerarLotePrecos And (Pos(strCodFor, strForFil) > 0) Then
      Begin
        Result := Result And fGeraLotePrecos(recPrecos,
                                             fltPreCus,
                                             blnAltPre,
                                             fltPreCom,
                                             fltAlqIcm);
        blnGerouLotePrecos := True;
      End;

      If (Not blnGeraEnderecamento) And blnNumSer And (strSONCEE = '2') Then
        Result := Result And fCriaNumerosDeSerieEntrada(strAutIncTmp);

      ReprocessarItem(FieldByName('DET_CODITE').AsString, '', False);
    End;

    If Assigned(pgbGravando) Then
      pgbGravando.Position := pgbGravando.Position + 1;
    Application.ProcessMessages;

    If Not Result Then
      Break;

    Next;

  End;

  strAgrupadorPreAlt := '';

  If blnFinalizar And Result Then
  Begin
    If intQtdeItensLotPre > 0 then
      objLotePrecos.pMensagemLotePrecoAtivar(intQtdeItensLotPre,DateToStr(dtaDtaDoc));

    If fTranferenciaAutomaticaFulfillment Then
      pAtualizaPisCofinsMovGer(strAutInc);

    If (objEntradaSimplificada.recAutEntTe.blnPedidoCompra) And blnGerarPedido Then
    begin
      pDeletaPedidoReservaAntigo;
      Result := Result And objEnderecamento.fGerarPedidoParaReservarEstoque;
      If Not fEmptyStr(objEnderecamento.strAutIncPed) Then
        FstrFatGor := objEnderecamento.strAutIncPed;
    End;
  End;

  If Assigned(objEnderecamento) Then
    FreeAndNil(objEnderecamento);

  If Assigned(cdsMarNeg) Then
  Begin
    If Result And (Not cdsMarNeg.IsEmpty) Then
      Result := TProdMargemNegativa.fLiberaMargemNegativa(cdsMarNeg, cdsMarNeg, rotEntradaMercadorias);

    FreeAndNil(cdsMarNeg);
  End;

  If blnOscilacaoPrecoMedio And Assigned(cdsItens) Then
  Begin
    Result := Result And fAbreTelaAutorizacao(cdsItens,
                                              strNumDoc,
                                              strEspDoc,
                                              VS_strCodEmp,
                                              strSerie,
                                              strCodFor);
    FreeAndNil(cdsItens);
  End;

  FreeAndNil(CalculoPrecoMediAgrup);
End;

procedure TfrmRecTransfEstoque.pLimparArrDadLivFull;
  var intContador: Integer;
Begin
  For intContador := Low(ArrDadLivFull) To High(ArrDadLivFull) Do
  Begin
    ArrDadLivFull[intContador].strClaFis := '';
    ArrDadLivFull[intContador].strClaFisEntra := '';
    ArrDadLivFull[intContador].blnSubst:= False;
    ArrDadLivFull[intContador].fltAliquota := 0;
  End;
End;

procedure TfrmRecTransfEstoque.pCarregaCFOPS(strAutoincrem: String; strTabela: String);
begin
  qryCFOPDoc.SQL.Clear;
  qryCFOPDoc.SQL.Add('SELECT DET_CLAFIS, DET_ALQICM,  LOCATE(DET_CODFIS, "' + CST_SUBSTITUICAO + '") > 0 AS SUBSTITUIDO FROM '+ strTabela);
  qryCFOPDoc.SQL.Add('WHERE DET_SEQGER = "' + strAutoincrem + '"');
  qryCFOPDoc.SQL.Add('   GROUP BY DET_CLAFIS, DET_ALQICM');
  qryCFOPDoc.Open;

  pLimparArrDadLivFull;


  While not qryCFOPDOc.Eof do
  Begin
    ArrDadLivFull[qryCFOPDoc.RecNo].strClaFis := qryCFOPDoc.FieldByName('DET_CLAFIS').AsString;
    ArrDadLivFull[qryCFOPDoc.RecNo].blnSubst := qryCFOPDoc.FieldByName('SUBSTITUIDO').AsFloat > 0;
    ArrDadLivFull[qryCFOPDoc.RecNo].strClaFisEntra := fTrocaClaFis(ArrDadLivFull[qryCFOPDoc.RecNo].strClaFis, qryCFOPDoc.FieldByName('SUBSTITUIDO').AsFloat > 0);
    ArrDadLivFull[qryCFOPDoc.RecNo].fltAliquota := qryCFOPDoc.FieldByName('DET_ALQICM').AsFloat;
    qryCFOPDOc.Next;
  End;
end;

procedure TfrmRecTransfEstoque.pCarregaEmpresaIndustria;
  var
    qryGen: TUniQuery;

begin
  Try
    qryGen := fCriaQuery;
    qryGen.SQL.Add('SELECT FOR_MATREV FROM CADEMP');
    qryGen.SQL.Add(' INNER JOIN CADFOR ON FOR_CODFOR = EMP_FORFIL');
    qryGen.SQL.Add(' WHERE EMP_CODEMP = "'+ VS_strCodemp +'"');
    qryGen.Open;
    blnEmpresaIndustria := qryGen.FieldByName('FOR_MATREV').AsString = 'I';
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmRecTransfEstoque.pCarregaFornecedor(strFornec: String);
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  FOR_SIMPAU, ';
  strSQL := strSQL + '  CID_ESTADO AS FOR_ESTADO, ';
  strSQL := strSQL + '  FOR_MATREV AS FOR_MATREV, ';
  strSQL := strSQL + '  FOR_NOMFOR ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFOR, ';
  strSQL := strSQL + '  CADCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FOR_CODCID = CID_CODCID AND ';
  strSQL := strSQL + '  FOR_CODFOR = :CODFOR ';

  qryGen := fCriaQuery;
  With qryGen Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODFOR').AsString := strFornec;
    Open;
    strEstFor := FieldByName('FOR_ESTADO').AsString;
    blnSimPau := FieldByName('FOR_SIMPAU').AsString = 'S';
    blnFornecedorIndustria := FieldByName('FOR_MATREV').AsString = 'I';
    strNomFor := FieldByName('FOR_NOMFOR').AsString;
    Close;
  End;

  FreeAndNil(qryGen);

end;

Function TfrmRecTransfEstoque.fRetLivro(Var recTotais: TRecTotais): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  SUM(IFNULL(FIS_VLCON1, 0) + IFNULL(FIS_VLCON2, 0) + IFNULL(FIS_VLCON3, 0) + IFNULL(FIS_VLCON4, 0) + IFNULL(FIS_VLCON5, 0)) AS VLCONT, ';

  strSQL := strSQL + '  SUM(IFNULL(FIS_BASIC1, 0) + IFNULL(FIS_BASIC2, 0) + IFNULL(FIS_BASIC3, 0) + IFNULL(FIS_BASIC4, 0) + IFNULL(FIS_BASIC5, 0)) AS BASICM, ';
  strSQL := strSQL + '  SUM(IFNULL(FIS_VLRIC1, 0) + IFNULL(FIS_VLRIC2, 0) + IFNULL(FIS_VLRIC3, 0) + IFNULL(FIS_VLRIC4, 0) + IFNULL(FIS_VLRIC5, 0)) AS VLRICM, ';

  strSQL := strSQL + '  SUM(IFNULL(FIS_BASIP1, 0) + IFNULL(FIS_BASIP2, 0) + IFNULL(FIS_BASIP3, 0) + IFNULL(FIS_BASIP4, 0) + IFNULL(FIS_BASIP5, 0)) AS BASIPI, ';
  strSQL := strSQL + '  SUM(IFNULL(FIS_VLRIP1, 0) + IFNULL(FIS_VLRIP2, 0) + IFNULL(FIS_VLRIP3, 0) + IFNULL(FIS_VLRIP4, 0) + IFNULL(FIS_VLRIP5, 0)) AS VLRIPI, ';

  strSQL := strSQL + '  SUM(IFNULL(FIS_BCRET1, 0) + IFNULL(FIS_BCRET2, 0) + IFNULL(FIS_BCRET3, 0) + IFNULL(FIS_BCRET4, 0) + IFNULL(FIS_BCRET5, 0)) AS BCRETI, ';
  strSQL := strSQL + '  SUM(IFNULL(FIS_RETID1, 0) + IFNULL(FIS_RETID2, 0) + IFNULL(FIS_RETID3, 0) + IFNULL(FIS_RETID4, 0) + IFNULL(FIS_RETID5, 0)) AS RETIDO, ';

  strSQL := strSQL + '  SUM(IFNULL(FIS_BASAN1, 0) + IFNULL(FIS_BASAN2, 0) + IFNULL(FIS_BASAN3, 0) + IFNULL(FIS_BASAN4, 0) + IFNULL(FIS_BASAN5, 0)) AS BASANT, ';
  strSQL := strSQL + '  SUM(IFNULL(FIS_ANTIC1, 0) + IFNULL(FIS_ANTIC2, 0) + IFNULL(FIS_ANTIC3, 0) + IFNULL(FIS_ANTIC4, 0) + IFNULL(FIS_ANTIC5, 0)) AS VALANT, ';

  strSQL := strSQL + '  SUM(IFNULL(FIS_DACES1, 0) + IFNULL(FIS_DACES2, 0) + IFNULL(FIS_DACES3, 0) + IFNULL(FIS_DACES4, 0) + IFNULL(FIS_DACES5, 0)) AS DACESS  ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFIS ';
  strSQL := strSQL + 'WHERE ';

  strSQL := strSQL + '  FIS_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  FIS_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  FIS_CODEMP = :CODEMP AND ';

  strSQL := strSQL + '  FIS_TIP_FC = "C" AND ';

  If fEmptyStr(cdsConsulta.FieldByName('GER_SERIE_').AsString) Then
    strSQL := strSQL + '  IFNULL(FIS_SERIE_, "") = "" AND '
  Else
    strSQL := strSQL + '  FIS_SERIE_ = :SERIE_ AND ';

  strSQL := strSQL + '  FIS_FORCLI = :CODCLI     ';

  qryGen := fCriaQuery;
  With qryGen, recTotais Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('NUMDOC').AsString := cdsConsulta.FieldByName('GER_NUMDOC').AsString;
    ParamByName('ESPDOC').AsString := cdsConsulta.FieldByName('GER_ESPDOC').AsString;
    ParamByName('CODEMP').AsString := cdsConsulta.FieldByName('GER_CODEMP').AsString;

    If Not fEmptyStr(cdsConsulta.FieldByName('GER_SERIE_').AsString) Then
      ParamByName('SERIE_').AsString := cdsConsulta.FieldByName('GER_SERIE_').AsString;

    ParamByName('CODCLI').AsString := cdsConsulta.FieldByName('GER_CODCLI').AsString;
    If fEmptyStr(ParamByName('CODCLI').AsString) Then
      ParamByName('CODCLI').AsString := cdsConsulta.FieldByName('GER_CODFOR').AsString;

    Open;

    If Not IsEmpty Then
    Begin
      fltVlrCon := FieldByName('VLCONT').AsFloat;
      fltDesAce := FieldByName('DACESS').AsFloat;

      fltBasIpi := FieldByName('BASIPI').AsFloat;
      fltTotIpi := FieldByName('VLRIPI').AsFloat;

      fltBasIcm := FieldByName('BASICM').AsFloat;
      fltTotIcm := FieldByName('VLRICM').AsFloat;

      fltBasRet := FieldByName('BCRETI').AsFloat;
      fltValRet := FieldByName('RETIDO').AsFloat;

      fltBasAnt := FieldByName('BASANT').AsFloat;
      fltValAnt := FieldByName('VALANT').AsFloat;

      If (blnSimPau) Or((fFornecedorFilial(strCodFor)) And ((fCfgSis('SIMPAU', varBoolean)) And (fCfgSis('IGNSIM') = '1'))) Then
      Begin
        fltBasIcm := 0;
        fltTotIcm := 0;
      End;

      Result := True;
    End Else
    Begin
      fRollBack;
      fMensagem('', 'Registro do Livro Fiscal não encontrado para o documento ' +
                cdsConsulta.FieldByName('GER_NUMDOC').AsString + '-' +
                cdsConsulta.FieldByName('GER_ESPDOC').AsString + '-' +
                cdsConsulta.FieldByName('GER_CODEMP').AsString, ['&Ok']);
      Result := False;
    End;

    Close;
  End;

End;

procedure TfrmRecTransfEstoque.FormCreate(Sender: TObject);
  Var
    intTabPre: Integer;
begin
  inherited;
  FblnCOFTRA := (fCfgSis('COFTRA', varBoolean))
    And (Not fUsaRotinaWMS)
    And (fCfgSis('CONSIM', varString) <> 'N');
  pZeraDigDuplic(arrDuplicata);
  strIncAge := '';
  blnMarmore := False;
  objEntradaSimplificada := TEntradaSimplificada.Create(Self);

  frmGravando := Nil;

  strAutincrem := '';

  qryCFOPDoc := fCriaQuery;
  blnCotDor := fCfgSis('COTDOR', varBoolean);
  pLimparArrDadLivFull;

  blnExiApl    := fCfgSis('EXIAPL', varBoolean);
  blnEntradaOk := False;
  strEmpMeds := fEmpresasMedEmp;
  strMedEmp  := fCfgSis('MEDEMP', varString);
  strMensagem  := '';

  blnLibPcm := fCfgSis('LIBPCM', varBoolean);
  intDeqTpc := fCfgSis('DEQTPC', varInteger);

  intESTFLJ := StrToIntDef(fCfgSis('ESTFLJ'), 1);

  objLotePrecos := TLotePrecos.Create(Self);
  objLock := TLock.Create;
  objOrdPro := TOrdPro.Create(Self, True);

  blnMarNeg := fCfgSis('MARNEG', varBoolean);

  If fCfgSis('FATPRE', varBoolean) Then
    objFatPre := TFatorPreco.Create
  Else
    objFatPre := Nil;

  For intTabPre := 1 to 7 Do
    blnAtpVmb[intTabPre] := (fCfgSis( IIF( intTabPre = 1, 'ATPVMB', 'ATPVM' + IntToStr(intTabPre) )) = 'P');

  blnGerarLotePrecos := fCfgSis('LOTPRE', varBoolean) And fCfgSis('LOTSIM', varBoolean);
  blnAtpRau := fCfgSis('ATPRAU', varBoolean);
  blnAtpRen := fCfgSis('ATPREN', varBoolean);
  blnZerIcL := fCfgSis('ZERICL', varBoolean);

  pnlHeader.Visible := blnCotDor And (blnAtpRau Or blnAtpRen) And (Not blnGerarLotePrecos);

  cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);

  strForFil := fRetForFilialTodos;

  qryMovDet := TZClient.Create(Self);

  qryGenMer := fCriaQuery(Self);
  objCadLot := TCadLot.Create(Self);

  objConEnt := TRecConferEntrada.Create(Self, cdsConsulta, stlListSelecao);
  objConEnt.fGravaEntradas := fGravaEntradas;
  blnUsaRotinaWms := fUsaRotinaWMS;

  blnFecharForm := fEmptyStr(objEntradaSimplificada.strCliFil);

  If blnFecharForm Then
    fMensagem('', 'A empresa não possui "Cliente Filial" cadastrado !', ['&O K']);

  blnAtuMed := fCfgSis('ATUMED', varBoolean);
  blnAtuUlt := fCfgSis('ATUULT', varBoolean);
  fltOscMed := fCfgSis('OSCMED', varDouble);
  blnAtuIcE := fCfgSis('ATUICE', varBoolean);
  blnAtuIpi := fCfgSis('ATUIPI', varBoolean);
  blnAtuSub := fCfgSis('ATUSUB', varBoolean);
  blnAtuIcS := fCfgSis('ATUICS', varBoolean);
  blnNumSer := fCfgSis('NUMSER', varBoolean);
  blnEntEnd := fCfgSis('ENTEND', varBoolean);
  strSONCEE := fCfgSis('SONCEE', varString);

  strCnvEmb := fCfgSis('CNVEMB');

  intTamNumDoc := fTamNumDoc;
  stlMarcadosDeConfirmacao := TStringList.Create;
  stlListaMovGer := TStringList.Create;

  objLogCancelamento := TLogCancelamento.Create;
  objAuditoriaSaldo := TAuditoriaGravacaoSaldo.New;

  qryIteGer := fCriaQuery(Self);
  With qryIteGer, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT TMP.*,');
    Add('       (SELECT  MAX(MOVDET.AUTOINCREM)');
    Add('          FROM MOVDET');
    Add('         WHERE DET_NUMDOC = TMP.NUMDOC');
    Add('           AND DET_ESPDOC = TMP.ESPDOC');
    Add('           AND DET_SERIE_ = TMP.SERIE_');
    Add('           AND DET_CODFOR = TMP.CODFOR');
    Add('           AND DET_CODEMP = TMP.CODEMP');
    Add('           AND DET_CODITE = TMP.ITE_CODITE ) AS DET_SEQDET');
    Add('  FROM (SELECT ITE_PREMED,');
    Add('               ITE_PREULT,');
    Add('               ITE_IMPULT,');
    Add('               ITE_NOTULT,');
    Add('               TRIM(SUBSTRING(ITE_NOTULT,1,12)) AS NUMDOC,');
    Add('               TRIM(SUBSTRING(ITE_NOTULT,13,2)) AS ESPDOC,');
    Add('               TRIM(SUBSTRING(ITE_NOTULT,18,3)) AS SERIE_,');
    Add('               TRIM(SUBSTRING(ITE_NOTULT,21,28)) AS CODFOR,');
    Add('               TRIM(SUBSTRING(ITE_NOTULT,15,3)) AS CODEMP,');
    Add('               ITE_CODITE');
    Add('          FROM ITEGER');
    Add('         WHERE ITE_CODITE = :CODITE');
    Add('           AND ITE_CODEMP = :CODEMP) TMP');
  End;

  blnRealizarConferencia := True;
  blnSomenteConferencia := False
end;

procedure TfrmRecTransfEstoque.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryCFOPDoc);
  FreeAndNil(qryIteGer);
  FreeAndNil(stlMarcadosDeConfirmacao);
  FreeAndNil(stlListaMovGer);
  FreeAndNil(objLock);
  FreeAndNil(cpcParams);
  FreeAndNil(objOrdPro);

  If Assigned(objFatPre) Then
    FreeAndNil(objFatPre);
  FreeAndNil(objLogCancelamento);
  inherited;
end;

procedure TfrmRecTransfEstoque.pAtualizaPisCofinsMovGer(strSeqGer: String);
var
 qryMovGer: TUniQuery;
begin

  qryMovGer := fCriaQuery(Nil);

  With qryMovGer Do
  Begin
    SQL.Clear;
    SQL.Add('UPDATE MOVGER SET GER_VALPIS = :TOTPIS, GER_VALCOF = :TOTCOF ');
    SQL.Add('WHERE AUTOINCREM = :AUTINC ');
    ParamByName('TOTPIS').AsFloat  := fltTotPis;
    ParamByName('TOTCOF').AsFloat  := fltTotCof;
    ParamByName('AUTINC').AsString := strSeqGer;
    ExecSQL;
  End;

  FreeAndNil(qryMovGer);
end;

Procedure TfrmRecTransfEstoque.pAtualizaPreco(recPrecos: TArrPrecos;  fltPreCom, fltPreCus: Double);
  Var
    strUpdIte: String;
    intTabPre: Integer;
Begin
  strUpdIte := '';
  strUpdIte := strUpdIte + 'UPDATE ';
  strUpdIte := strUpdIte + '  ITEGER ';
  strUpdIte := strUpdIte + 'SET ';
  strUpdIte := strUpdIte + '  ITE_PRECOM = :PRECOM, ';
  strUpdIte := strUpdIte + '  ITE_DESF01 = :DESF01, ';
  strUpdIte := strUpdIte + '  ITE_DESF02 = :DESF02, ';
  strUpdIte := strUpdIte + '  ITE_DESF03 = :DESF03, ';
  strUpdIte := strUpdIte + '  ITE_DESF04 = :DESF04, ';
  strUpdIte := strUpdIte + '  ITE_DESF05 = :DESF05, ';
  strUpdIte := strUpdIte + '  ITE_DESF06 = :DESF06, ';
  strUpdIte := strUpdIte + '  ITE_ICMENT = :ICMENT, ';
  strUpdIte := strUpdIte + '  ITE_SUBFED = :SUBFED, ';
  strUpdIte := strUpdIte + '  ITE_IPIENT = :IPIENT, ';
  strUpdIte := strUpdIte + '  ITE_FREENT = :FREENT, ';
  strUpdIte := strUpdIte + '  ITE_VALFRE = :VALFRE, ';
  strUpdIte := strUpdIte + '  ITE_ACRFIN = :ACRFIN, ';
  strUpdIte := strUpdIte + '  ITE_SUBSTI = :SUBSTI, ';
  strUpdIte := strUpdIte + '  ITE_OUTVAL = :OUTVAL, ';
  strUpdIte := strUpdIte + '  ITE_IMPFED = :IMPFED, ';
  strUpdIte := strUpdIte + '  ITE_DESOPE = :DESOPE, ';
  strUpdIte := strUpdIte + '  ITE_PRECUS = :PRECUS, ';
  strUpdIte := strUpdIte + '  ITE_ICMSAI = :ICMSAI,  ';
  strUpdIte := strUpdIte + '  ITE_PREALT = :PREALT  ';

  For intTabPre := 1 To Length(recPrecos) Do
  Begin
    strUpdIte := strUpdIte + ' , ITE_COMTB' + IntToStr(intTabPre) + ' = :COMTB' + IntToStr(intTabPre) + ', ';
    strUpdIte := strUpdIte + '   ITE_MARBR' + IntToStr(intTabPre) + ' = :MARBR' + IntToStr(intTabPre) + ', ';
    strUpdIte := strUpdIte + '   ITE_PREVE' + IntToStr(intTabPre) + ' = :PREVE' + IntToStr(intTabPre) + '  ';
  End;

  strUpdIte := Trim(strUpdIte);

  If (RightStr(strUpdIte, 1) = ',') Then
    strUpdIte := Copy(strUpdIte, 1, Length(strUpdIte)-1);

  strUpdIte := strUpdIte + ' ';

  strUpdIte := strUpdIte + 'WHERE ';
  strUpdIte := strUpdIte + '  ITE_CODITE = :CODITE AND ';
  strUpdIte := strUpdIte + '  LOCATE(ITE_CODEMP, :CODEMP) > 0 ';

  qryGenMer.Close;
  qryGenMer.SQL.Clear;
  qryGenMer.SQL.Add(strUpdIte);

  With qryMovDet Do
  Begin
    qryGenMer.ParamByName('PRECOM').AsFloat := fltPreCom;
    qryGenMer.ParamByName('DESF01').AsFloat := FieldByName('ITE_DESF01').AsFloat;
    qryGenMer.ParamByName('DESF02').AsFloat := FieldByName('ITE_DESF02').AsFloat;
    qryGenMer.ParamByName('DESF03').AsFloat := FieldByName('ITE_DESF03').AsFloat;
    qryGenMer.ParamByName('DESF04').AsFloat := FieldByName('ITE_DESF04').AsFloat;
    qryGenMer.ParamByName('DESF05').AsFloat := FieldByName('ITE_DESF05').AsFloat;
    qryGenMer.ParamByName('DESF06').AsFloat := FieldByName('ITE_DESF06').AsFloat;

    qryGenMer.ParamByName('ICMENT').AsFloat := cpcParams.curICMSEnt;

    qryGenMer.ParamByName('SUBFED').AsFloat := FieldByName('ITE_SUBFED').AsFloat;

    qryGenMer.ParamByName('IPIENT').AsFloat := cpcParams.curIPIEnt;

    qryGenMer.ParamByName('FREENT').AsFloat := FieldByName('ITE_FREENT').AsFloat;
    qryGenMer.ParamByName('VALFRE').AsFloat := FieldByName('ITE_VALFRE').AsFloat;
    qryGenMer.ParamByName('ACRFIN').AsFloat := FieldByName('ITE_ACRFIN').AsFloat;

    qryGenMer.ParamByName('SUBSTI').AsFloat := cpcParams.curSubsti;

    qryGenMer.ParamByName('OUTVAL').AsFloat := FieldByName('ITE_OUTVAL').AsFloat;
    qryGenMer.ParamByName('IMPFED').AsFloat := FieldByName('ITE_IMPFED').AsFloat;
    qryGenMer.ParamByName('DESOPE').AsFloat := FieldByName('ITE_DESOPE').AsFloat;
    qryGenMer.ParamByName('PRECUS').AsFloat := fltPreCus;
    qryGenMer.ParamByName('ICMSAI').AsFloat := FieldByName('ITE_ICMSAI').AsFloat;
    qryGenMer.ParamByName('PREALT').AsString := strAgrupadorPreAlt;

    For intTabPre := 1 To Length(recPrecos) Do
    Begin
      qryGenMer.ParamByName('COMTB' + IntToStr(intTabPre)).AsFloat := recPrecos[intTabPre].fltComiss;
      qryGenMer.ParamByName('MARBR' + IntToStr(intTabPre)).AsFloat := recPrecos[intTabPre].fltMarBru;
      qryGenMer.ParamByName('PREVE' + IntToStr(intTabPre)).AsFloat := recPrecos[intTabPre].fltPreVen;
    End;

    {*****************************************}
    {* DADOS DO FILTRO                       *}
    {**************************************MV*}
    qryGenMer.ParamByName('CODITE').AsString := FieldByName('DET_CODITE').AsString;
    qryGenMer.ParamByName('CODEMP').AsString := strEmpresas;

    qryGenMer.ExecSQL;
    qryGenMer.Close;
  End;
End;

procedure TfrmRecTransfEstoque.pRecalculaPrecos(Var recPrecos: TarrPrecos;
                                                Var fltPreCus: Double;
                                                Var blnAltPre: Boolean;
                                                fltPreCom,
                                                fltAlqIcm: Double;
                                                blnZeraIcms: Boolean = False);
  Var
    intTabPre: Integer;
Begin
  With qryMovDet Do
  Begin
    For intTabPre := 1 To Length(recPrecos) Do
    Begin
      recPrecos[intTabPre].fltPreVen := FieldByName('ITE_PREVE' + IntToStr(intTabPre)).AsFloat;
      recPrecos[intTabPre].fltMarBru := FieldByName('ITE_MARBR' + IntToStr(intTabPre)).AsFloat;
      recPrecos[intTabPre].fltComiss := FieldByName('ITE_COMTB' + IntToStr(intTabPre)).AsFloat;
    End;
    {**********************************}
    {* CALCULA PREÇOS DE CUSTO        *}
    {*******************************JB*}
    With cpcParams Do
    Begin
      curPreCom := fltPreCom;
      curDesF01 := FieldByName('ITE_DESF01').AsFloat;
      curDesF02 := FieldByName('ITE_DESF02').AsFloat;
      curDesF03 := FieldByName('ITE_DESF03').AsFloat;
      curDesF04 := FieldByName('ITE_DESF04').AsFloat;
      curDesF05 := FieldByName('ITE_DESF05').AsFloat;
      curDesF06 := FieldByName('ITE_DESF06').AsFloat;

      If blnZeraIcms Then
      Begin
        curICMSEnt := 0;
      End Else
      Begin
        If blnAtuIcE Then
          curICMSEnt := fFormataFloat((fltAlqIcm * FieldByName('DET_PERBAS').AsFloat) / 100, 2)
        Else
          curICMSEnt := FieldByName('ITE_ICMENT').AsFloat;
      End;

      If blnAtuIpi Then
        curIPIEnt := FieldByName('DET_ALQIPI').AsFloat + FieldByName('DET_ALEIPI').AsFloat
      Else
        curIPIEnt := FieldByName('ITE_IPIENT').AsFloat;

      curFrete  := FieldByName('ITE_FREENT').AsFloat;
      curValFre := FieldByName('ITE_VALFRE').AsFloat;
      curAcrFin := FieldByName('ITE_ACRFIN').AsFloat;

      If blnAtuSub Then
        curSubsti := FieldByName('PERSUB').AsFloat
      Else
        curSubsti := FieldByName('ITE_SUBSTI').AsFloat;

      curDesAdb := FieldByName('ITE_DESADB').AsFloat;
      curSubFed := FieldByName('ITE_SUBFED').AsFloat;

      if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
      begin
        curTCIFCu := FieldByName('ITE_TCIFCU').AsFloat;
        curTSCust := FieldByName('ITE_TSCUST').AsFloat;
        curDePiCo := FieldByName('ITE_DEPICO').AsFloat;
        curDeICMS := FieldByName('ITE_DEICMS').AsFloat;
        curFatReg := FieldByName('ITE_FATREG').AsFloat;
      end
      else
      begin
        curTCIFCu := 0;
        curTSCust := 0;
        curDePiCo := 0;
        curDeICMS := 0;
        curFatReg := 0;
      end;

    End;
    fltPreCus := cpcParams.fCalculaPrecoCusto();

    blnAltPre := False;

    For intTabPre := 1 To Length(recPrecos) Do
    Begin
      If blnATPVMB[intTabPre] Then
      Begin
        recPrecos[intTabPre].fltComiss := FieldByName('ITE_COMTB' + IntToStr(intTabPre)).AsFloat;

        If ((Not Assigned(objFatPre) Or (Assigned(objFatPre) And (Not objFatPre.fTabelaAtiva(intTabPre))))) Or (intTabPre = 1) Then

        Begin
          recPrecos[intTabPre].fltMarBru := FieldByName('ITE_MARBR' + IntToStr(intTabPre)).AsFloat;

          {*******************************************}
          {* CALCULA OS NOVOS PREÇOS DE VENDA        *}
          {****************************************MV*}
          recPrecos[intTabPre].fltPreVen := fCalculaPrecoVenda(1,
                                                               fltPreCus + FieldByName('ITE_OUTVAL').AsFloat,
                                                               0,
                                                               recPrecos[intTabPre].fltMarBru,
                                                               FieldByName('ITE_ICMSAI').AsFloat,
                                                               FieldByName('ITE_IMPFED').AsFloat,
                                                               FieldByName('ITE_DESOPE').AsFloat,
                                                               recPrecos[intTabPre].fltComiss);
          blnAltPre := True;
        End Else
        Begin
            recPrecos[intTabPre].fltPreVen :=
              objFatPre.fCalculaPrecoVendaFator(recPrecos[1].fltPreVen, intTabPre);

          blnAltPre := True;

          recPrecos[intTabPre].fltMarBru := fCalculaPrecoVenda(2,
                                                               fltPreCus + FieldByName('ITE_OUTVAL').AsFloat,
                                                               recPrecos[intTabPre].fltPreVen,
                                                               0,
                                                               FieldByName('ITE_ICMSAI').AsFloat,
                                                               FieldByName('ITE_IMPFED').AsFloat,
                                                               FieldByName('ITE_DESOPE').AsFloat,
                                                               recPrecos[intTabPre].fltComiss);
        End;

      End
      Else
      Begin
        recPrecos[intTabPre].fltComiss := FieldByName('ITE_COMTB' + IntToStr(intTabPre)).AsFloat;

        If ((Not Assigned(objFatPre) Or (Assigned(objFatPre) And (Not objFatPre.fTabelaAtiva(intTabPre))))) Or (intTabPre = 1) Then
          recPrecos[intTabPre].fltPreVen := FieldByName('ITE_PREVE' + IntToStr(intTabPre)).AsFloat
        Else
            recPrecos[intTabPre].fltPreVen :=
              objFatPre.fCalculaPrecoVendaFator(recPrecos[1].fltPreVen, intTabPre);

        {*******************************************}
        {* CALCULA AS NOVAS MARGENS BRUTAS         *}
        {****************************************MV*}
        recPrecos[intTabPre].fltMarBru := fCalculaPrecoVenda(2,
                                                             fltPreCus + FieldByName('ITE_OUTVAL').AsFloat,
                                                             recPrecos[intTabPre].fltPreVen,
                                                             0,
                                                             FieldByName('ITE_ICMSAI').AsFloat,
                                                             FieldByName('ITE_IMPFED').AsFloat,
                                                             FieldByName('ITE_DESOPE').AsFloat,
                                                             recPrecos[intTabPre].fltComiss);
      End;
    End;
  End;
End;

Function TfrmRecTransfEstoque.fGeraLotePrecos(recPrecos: TarrPrecos;
                                              fltPreCus: Double;
                                              blnAltPre: Boolean;
                                              fltPreCom,
                                              fltAlqIcm: Double): Boolean;
  Var
    recPreLot: TArrPrecos;
    fltCusLot,
    fltComLot: Double;
    blnAltLot: Boolean;
Begin
  With qryMovDet Do
  Begin
    objLotePrecos.strOpeRes := FieldByName('ITE_OPERES').AsString;

    objLotePrecos.strNumDoc := FieldByName('DET_NUMDOC').AsString;
    objLotePrecos.strEspDoc := FieldByName('DET_ESPDOC').AsString;
    objLotePrecos.strSerie  := FieldByName('DET_SERIE_').AsString;
    objLotePrecos.strCodEmp := VS_strCodEmp;
    objLotePrecos.strCodFor := strCodFor;

    recPreLot := recPrecos;

    With cpcParams Do
    fltComLot := objLotePrecos.fCalculaPrecoCompraBruto(fltPreCom,
                                                        [curDesF01, curDesF02, curDesF03,
                                                         curDesF04, curDesF05, curDesF06]);
    pRecalculaPrecos(recPreLot,
                     fltCusLot,
                     blnAltLot,
                     fltComLot,
                     fltAlqIcm,
                     blnZerIcL);

    Result := objLotePrecos.fGravaLoteAlteracaoPrecoItem(strAutIncTmp,

                                                         FieldByName('DET_CODITE').AsString,

                                                         FieldByName('ITE_PRECOM').AsFloat,
                                                         fltComLot,

                                                         FieldByName('ITE_DESF01').AsFloat,
                                                         cpcParams.curDesF01,

                                                         FieldByName('ITE_DESF02').AsFloat,
                                                         cpcParams.curDesF02,

                                                         FieldByName('ITE_DESF03').AsFloat,
                                                         cpcParams.curDesF03,

                                                         FieldByName('ITE_DESF04').AsFloat,
                                                         cpcParams.curDesF04,

                                                         FieldByName('ITE_DESF05').AsFloat,
                                                         cpcParams.curDesF05,

                                                         FieldByName('ITE_DESF06').AsFloat,
                                                         cpcParams.curDesF06,

                                                         FieldByName('ITE_ICMENT').AsFloat,
                                                         cpcParams.curICMSEnt,

                                                         FieldByName('ITE_SUBFED').AsFloat,
                                                         cpcParams.curSubFed,

                                                         FieldByName('ITE_IPIENT').AsFloat,
                                                         cpcParams.curIPIEnt,

                                                         FieldByName('ITE_FREENT').AsFloat,
                                                         cpcParams.curFrete,

                                                         FieldByName('ITE_VALFRE').AsFloat,
                                                         cpcParams.curValFre,

                                                         FieldByName('ITE_ACRFIN').AsFloat,
                                                         cpcParams.curAcrFin,

                                                         FieldByName('ITE_SUBSTI').AsFloat,
                                                         cpcParams.curSubsti,

                                                         FieldByName('ITE_DESADB').AsFloat,
                                                         cpcParams.curDesAdb,

                                                         FieldByName('ITE_OUTVAL').AsFloat,
                                                         FieldByName('ITE_OUTVAL').AsFloat,

                                                         FieldByName('ITE_IMPFED').AsFloat,
                                                         FieldByName('ITE_IMPFED').AsFloat,

                                                         FieldByName('ITE_DESOPE').AsFloat,
                                                         FieldByName('ITE_DESOPE').AsFloat,

                                                         FieldByName('ITE_PRECUS').AsFloat,
                                                         fltCusLot,

                                                         FieldByName('ITE_ICMSAI').AsFloat,
                                                         FieldByName('ITE_ICMSAI').AsFloat,

                                                         FieldByName('ITE_MARBR1').AsFloat,
                                                         recPreLot[01].fltMarBru,

                                                         FieldByName('ITE_PREVE1').AsFloat,
                                                         recPreLot[01].fltPreVen,

                                                         FieldByName('ITE_COMTB1').AsFloat,
                                                         recPreLot[01].fltComiss,

                                                         FieldByName('ITE_MARBR2').AsFloat,
                                                         recPreLot[02].fltMarBru,

                                                         FieldByName('ITE_PREVE2').AsFloat,
                                                         recPreLot[02].fltPreVen,

                                                         FieldByName('ITE_COMTB2').AsFloat,
                                                         recPreLot[02].fltComiss,

                                                         FieldByName('ITE_MARBR3').AsFloat,
                                                         recPreLot[03].fltMarBru,

                                                         FieldByName('ITE_PREVE3').AsFloat,
                                                         recPreLot[03].fltPreVen,

                                                         FieldByName('ITE_COMTB3').AsFloat,
                                                         recPreLot[03].fltComiss,

                                                         FieldByName('ITE_MARBR4').AsFloat,
                                                         recPreLot[04].fltMarBru,

                                                         FieldByName('ITE_PREVE4').AsFloat,
                                                         recPreLot[04].fltPreVen,

                                                         FieldByName('ITE_COMTB4').AsFloat,
                                                         recPreLot[04].fltComiss,

                                                         FieldByName('ITE_MARBR5').AsFloat,
                                                         recPreLot[05].fltMarBru,

                                                         FieldByName('ITE_PREVE5').AsFloat,
                                                         recPreLot[05].fltPreVen,

                                                         FieldByName('ITE_COMTB5').AsFloat,
                                                         recPreLot[05].fltComiss,

                                                         FieldByName('ITE_MARBR6').AsFloat,
                                                         recPreLot[06].fltMarBru,

                                                         FieldByName('ITE_PREVE6').AsFloat,
                                                         recPreLot[06].fltPreVen,

                                                         FieldByName('ITE_COMTB6').AsFloat,
                                                         recPrecos[06].fltComiss,

                                                         FieldByName('ITE_MARBR7').AsFloat,
                                                         recPreLot[07].fltMarBru,

                                                         FieldByName('ITE_PREVE7').AsFloat,
                                                         recPreLot[07].fltPreVen,

                                                         FieldByName('ITE_COMTB7').AsFloat,
                                                         recPreLot[07].fltComiss,

                                                         fltPreCom,
                                                         blnAltPre,
                                                         '',
                                                         FieldByName('ITE_TCIFCU').AsFloat,
                                                         cpcParams.curTCIFCu,
                                                         FieldByName('ITE_TSCUST').AsFloat,
                                                         cpcParams.curTSCust,
                                                         FieldByName('ITE_DEPICO').AsFloat,
                                                         cpcParams.curDePiCo,
                                                         FieldByName('ITE_DEICMS').AsFloat,
                                                         cpcParams.curDeICMS,
                                                         FieldByName('ITE_FATREG').AsFloat,
                                                         cpcParams.curFatReg);
    If Result then
      intQtdeItensLotPre := intQtdeItensLotPre + 1;
  End;

End;

function TfrmRecTransfEstoque.fGeraOrdemProducaoSubItem(strNumDoc, strEspDoc,
  strCodIte: String; fltQtdIte: Double): Boolean;
begin
  Result := False;
  Try
    objOrdPro.strNumDoc := strNumDoc;
    objOrdPro.strEspDoc := strEspDoc;
    objOrdPro.strCodEmp := VS_strCodEmp;
    objOrdPro.strCodCli := '';
    objOrdPro.strCodFor := Self.strCodFor;
    objOrdPro.strCodIte := strCodIte;
    objOrdPro.strQtdApr := FloatToStrF(fltQtdIte, ffFixed, 12, 4);
    objOrdPro.strQtdPro := '0.0';
    objOrdPro.strConfer := fRetNomVendRep(strLoginUsuarioLogado);
    objOrdPro.strDtaPro := FormatDateTime('DD/MM/YYYY', VS_Date);
    objOrdPro.strDtaCad := DateToStr(VS_Date);
    objOrdPro.strObs001 := 'GERADO PELA ENTRADA SIMPLIFICADA ENTRE LOJAS';
    objOrdPro.strObs002 := 'DOCUMENTO: ' + strNumDoc + '-' + strEspDoc;
    objOrdPro.blnTransacao := False;

    If (Not objOrdPro.fOrdemProducaoExiste) Then
    Begin
      Result := objOrdPro.fInsereOrdemProducao;

      If Result Then
      Begin
        objOrdPro.fCarregaOrdPro(objOrdPro.strCodPro);
        objOrdPro.fBaixaOrdProDV(fltQtdIte, objOrdPro.strConfer);
      End;
    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[Geração de Ordem de Produção]');
    End;
  End;
end;

Function TfrmRecTransfEstoque.fAtualizaProduto(strNumLot: String; var blnAtualizouPreMed : Boolean; Var recPrecos: TArrPrecos;
                                               Var fltPreCom, fltPreCus, fltPreMedNov: Double; Var blnAltPre, blnAtualizouPreco: Boolean;
                                               blnTesteMargem: Boolean;
                                               CalculoPrecoMediAgrup: TCalculoPrecoMediAgrup): Boolean;
  Var
    fltIcmMed,
    fltUniImp,
    fltPreMed,
    fltAlqPis,
    fltValIcm,
    fltSaldosPreMed: Double;
    blnUltPis: Boolean;
    blnMedSe2: Boolean;
    objImpUlt: TCalculoUltimaCompraImpostos;
    qryUpdate: TUniQuery;
    fltAlqIcm: Double;
    strClaFisBonificacao: String;
    blnZeraIPI : Boolean;
    strAutIncMovGer: String;
Begin
  Result := True;
  blnAtualizouPreco := False;

  objImpUlt := TCalculoUltimaCompraImpostos.fCriaImpUlt;

  If (Pos(strCodFor, strForFil) > 0) Then
    blnUltPis := fRetForFilialDeduzPisCofinsUltimaCompra(VS_strCodEmp, strCodFor)
  Else
    blnUltPis := fCfgSis('ULTPIS', VarBoolean);

  If (Pos(strCodFor, strForFil) > 0) Then
    blnDedICM := fRetForFilialDeduzICMSUltimaCompra(VS_strCodEmp, strCodFor)
  Else
    blnDedIcm := fCfgSis('DEDICM', varBoolean);

  objImpUlt.blnUltPis := blnUltPis;
  blnMedSe2 := fCfgSis('MEDSE2', varBoolean);

  With qryMovDet Do
  Begin
    {*****************************************}
    {* CALCULO DO PREÇO MÉDIO DO ITEM        *}
    {*                                       *}
    {* ------------> ATENÇÃO <-------------- *}
    {*                                       *}
    {* NÃO COLOCAR A GRAVAÇÃO DO PREÇO MEDIO *}
    {* APÓS A GRAVAÇÃO DO SALDO!!            *}
    {**************************************MV*}

    fltPreUlt := ( FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat );
    fltPreUlt := fltPreUlt / FieldByName('DET_QTDITE').AsFloat;
    fltPreUlt := fFormataFloat(fltPreUlt, 4);

    If blnUltPis Then
      fltAlqPis := (FieldByName('DET_ALQPIS').AsFloat + FieldByName('DET_ALQCOF').AsFloat)
    Else
      fltAlqPis := 0;

    blnSubstituido := (Pos(FieldByName('DET_CODFIS').AsString, CST_SUBSTITUICAO) > 0);

    If (blnSubstituido) Or (blnSimPau) Or ((fFornecedorFilial(strCodFor)) And ((fCfgSis('SIMPAU', varBoolean)) And (fCfgSis('IGNSIM') = '1'))) Then
    Begin
      fltValIcm := 0;
      fltAlqIcm := 0;
    End Else
    Begin
      fltValIcm := FieldByName('DET_VALICM').AsFloat + qryMovDet.FieldByName('ICD_VALFCP').AsFloat;
      fltAlqIcm := FieldByName('DET_ALQICM').AsFloat;
    End;
    blnZeraIPI := fZeraIPI(FieldByName('DET_CODITE').AsString);

    objImpUlt
      .TotalItem(FieldByName('DET_TOTITE').AsFloat)
      .DescontoEspecial(FieldByName('DET_DESESP').AsFloat)
      .AliquotaPis(fltAlqPis)
      .AliquotaCofins(0)
      .ValorIpi(IIf(blnZeraIPI, 0, FieldByName('DET_VALIPI').AsFloat))
      .ValorIpiNaoCreditado(IIf(blnZeraIPI, 0, FieldByName('DET_VAEIPI').AsFloat))
      .Frete(FieldByName('DET_TOTFRE').AsFloat)
      .ConhecimentoFrete(FieldByName('DET_CONFRE').AsFloat)
      .OutrasDespesas(FieldByName('DET_OUTDES').AsFloat)
      .Vendor(FieldByName('DET_VENDOR').AsFloat)
      .DespesaAcessoria(FieldByName('DET_DESACE').AsFloat)

      .ValorIcms(IIF(blnDedIcm, fltValIcm, 0))

      .ValorIcmsNaoCreditado(IIF(blnDedIcm, IIF(fltValIcm > 0,
                                                0,
                                                FieldByName('DET_ICMNCR').AsFloat + FieldByName('DET_FCPNCR').AsFloat), 0))

      .ValorIcmsAntecipado(FieldByName('DET_ICMANT').AsFloat)
      .ValorIcmsAntecipadoFrete(0)
      .ValorGNRE(FieldByName('DET_VLGNRE').AsFloat)
      .ValorTCIF(FieldByName('DET_VALTCI').AsFloat)
      .ValorTS(FieldByName('DET_VAL_TS').AsFloat)
      .ValorRetido(FieldByName('DET_VALRET').AsFloat)
      .ValorRetidoNaoCreditado(FieldByName('DET_VAERET').AsFloat)
      .ValorFundoCombateAPobreza(FieldByName('DET_VFCPST').AsFloat)
      .FornecedorFilial(Pos(strCodFor, strForFil) > 0)
      .ItemIncidePis(FieldByName('DET_INCPIS').AsString);

    fltPreUltImp := objImpUlt.fTotal;

    fltPreUltImp := fltPreUltImp / FieldByName('DET_QTDITE').AsFloat;
    fltPreUltImp := fFormataFloat(fltPreUltImp, 4);

    fltUniImp := (FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat);
    fltUniImp := (fltUniImp / FieldByName('DET_QTDITE').AsFloat);
    fltUniImp := fFormataFloat(fltUniImp, 4);

    If fEmptyStr(FieldByName('DET_CODACA').AsString) Then
    Begin

      If (Pos(strCodFor, strForFil) <= 0) Or ((Pos(strCodFor, strForFil) > 0) And (fCfgSis('TRDPCI') = 'S')) Then
        fltIcmMed := fFormataFloat((fltAlqIcm * FieldByName('DET_PERBAS').AsFloat) / 100, 2)
      Else
        fltIcmMed := 0;

      If strMedEmp = '1' Then
        fltSaldosPreMed := fSaldoEmpresas(FieldByName('DET_CODITE').AsString, strEmpMeds)
      Else
        fltSaldosPreMed := FieldByName('ITE_SALDOS').AsFloat;

      CalculoPrecoMediAgrup.strCodIteAtual := FieldByName('DET_CODITE').AsString;
      {*************************************************************}
      {* CONFIGURAÇÃO QUE PERMITE UTILIZAR O ÚLTIMO PRECO DE       *}
      {* COMPRA PARA FORMAÇÃO DO PRECO MÉDIO DO PRODUTO            *}
      {**************************** 22/07/09**************** AM ****}
      If fCfgSis('BASMED') <> 'S' Then
      Begin
        If FieldByName('ITE_PREMED').AsFloat < 0 Then
        Begin
          Result := False;
          fRollBack;

          pMensagemOk('O preço médio do Item ' + FieldByName('DET_CODITE').AsString + ' está negativo. É necessário fazer um ajuste no cadastro.');
          Exit;
        End;

        fltPreMed := fCalculaPrecoMedio(FieldByName('DET_CODFIS').AsString,          // Código Fiscal
                                        FieldByName('DET_CLAFIS').AsString,        // ClassificacaoFiscal
                                        FieldByName('ITE_PREMED').AsFloat,           // Preço medio anterior
                                        fltSaldosPreMed,                             // Saldo anterior
                                        FieldByName('DET_QTDITE').AsFloat,           // Quantidade de entrada
                                        fltUniImp,                                   // Unitario sem impostos
                                        fltIcmMed,                                   // Aliquota de ICMS do Item
                                        FieldByName('DET_VALIPI').AsFloat +
                                        FieldByName('DET_VAEIPI').AsFloat,           // Valor do IPI

                                        FieldByName('DET_VALRET').AsFloat +
                                        FieldByName('DET_VAERET').AsFloat,           // Valor de Substituição

                                        FieldByName('DET_ICMANT').AsFloat,           // Valor do ICMS Antecipado

                                        FieldByName('DET_VLGNRE').AsFloat,
                                        FieldByName('DET_VALTCI').AsFloat,
                                        FieldByName('DET_VAL_TS').AsFloat,

                                        blnContribuinteIPI,                          // Contribuinte de IPI?
                                        (Pos(strCodFor, strForFil) > 0),             // Fornec Filial
                                        FieldByName('DET_INCPIS').AsString,
                                        FieldByName('DET_TOTFRE').AsFloat +          // VALOR DO FRETE
                                        FieldByName('DET_CONFRE').AsFloat,
                                        FieldByName('DET_DESACE').AsFloat +
                                        FieldByName('DET_VENDOR').AsFloat,

                                        FieldByName('DET_VALICM').AsFloat + FieldByName('ICD_VALFCP').AsFloat,

                                        IIF((FieldByName('DET_VALICM').AsFloat + FieldByName('ICD_VALFCP').AsFloat) > 0,
                                            0,
                                            FieldByName('DET_ICMNCR').AsFloat + FieldByName('DET_FCPNCR').AsFloat),

                                        FieldByName('DET_VFCPST').AsFloat,
                                        0,
                                        CalculoPrecoMediAgrup,
                                        FieldByName('DET_VAEIPI').AsFloat > 0);
      End
      Else
        fltPreMed := fCalculaPrecoMedio(FieldByName('DET_CODFIS').AsString,          // Código Fiscal
                                        FieldByName('DET_CLAFIS').AsString,        // ClassificacaoFiscal
                                        FieldByName('ITE_PRECOM').AsFloat,           // Preço compra
                                        fltSaldosPreMed,                             // Saldo anterior
                                        FieldByName('DET_QTDITE').AsFloat,           // Quantidade de entrada
                                        fltUniImp,                                   // Unitario sem impostos
                                        fltIcmMed,                                   // Aliquota de ICMS do Item
                                        FieldByName('DET_VALIPI').AsFloat +
                                        FieldByName('DET_VAEIPI').AsFloat,           // Valor do IPI

                                        FieldByName('DET_VALRET').AsFloat +
                                        FieldByName('DET_VAERET').AsFloat,           // Valor de Substituição

                                        FieldByName('DET_ICMANT').AsFloat,           // Valor do ICMS Antecipado

                                        FieldByName('DET_VLGNRE').AsFloat,
                                        FieldByName('DET_VALTCI').AsFloat,
                                        FieldByName('DET_VAL_TS').AsFloat,

                                        blnContribuinteIPI,                          // Contribuinte de IPI?
                                        (Pos(strCodFor, strForFil) > 0), // Fornec Filial
                                        FieldByName('DET_INCPIS').AsString,
                                        FieldByName('DET_TOTFRE').AsFloat +          // VALOR DO FRETE
                                        FieldByName('DET_CONFRE').AsFloat,
                                        FieldByName('DET_DESACE').AsFloat +
                                        FieldByName('DET_VENDOR').AsFloat,

                                        FieldByName('DET_VALICM').AsFloat + FieldByName('ICD_VALFCP').AsFloat,

                                        IIF((FieldByName('DET_VALICM').AsFloat + FieldByName('ICD_VALFCP').AsFloat) > 0,
                                            0,
                                            FieldByName('DET_ICMNCR').AsFloat + FieldByName('DET_FCPNCR').AsFloat),

                                        FieldByName('DET_VFCPST').AsFloat,
                                        0,
                                        CalculoPrecoMediAgrup,
                                        FieldByName('DET_VAEIPI').AsFloat > 0);
    End
    Else
    Begin
      fltPreMed := 0.0;
    End;

    fltPreMedNov := fltPreMed;
    fltPreCom := FieldByName('DET_UNITAR').AsFloat;
    fltPreCus := FieldByName('ITE_PRECUS').AsFloat;

    {*******************************************}
    {* CASO USE O PREÇO MÉDIO COMO PREÇO DE    *}
    {* COMPRA                                  *}
    {****************************************MV*}
    If blnAtpRau And ((Pos(strCodFor, strForFil) = 0) Or blnAtpRen) Then
    Begin

      If (fCfgSis('ATUNMD') = 'M') Then
      Begin
        If SameText(strEspDoc, 'NF') Or blnMedSe2 Then
          fltPreCom := fltPreMed
        Else
          fltPreCom := FieldByName('ITE_PREMED').AsFloat;
      End
      Else If (fCfgSis('ATUNMD') = 'U') Then
        fltPreCom := fltPreUlt

      Else If (fCfgSis('ATUNMD') = 'D') Then
      Begin
        fltPreCom := fltPreUlt;

        If FieldByName('DET_QTDITE').AsFloat > 0 Then
          fltPreCom := fltPreCom + FieldByName('DET_OUTDES').AsFloat / FieldByName('DET_QTDITE').AsFloat;
      End;

    End;

    If blnAtpRau And ((Pos(strCodFor, strForFil) = 0) Or blnAtpRen) Then
    Begin

      pRecalculaPrecos(recPrecos,
                       fltPreCus,
                       blnAltPre,
                       fltPreCom,
                       fltAlqIcm);

    End;

    If fConferenciaDepoisDaEntrada Then
      Exit;

    strClaFisBonificacao := fRetornarClassificacoesBonificacaoEntrada;

    If (Not blnTesteMargem) And
       (not fEmptyStr(FieldByName('DET_CODACA').AsString)) And
       (((Pos(strClaFisDet, VS_strClaCom + '_1117_2117_1116_2116' + strClaFisBonificacao) > 0) And (Not (Pos(strCodFor, strForFil) > 0))) Or
        (blnAtuMed And (Pos(strCodFor, strForFil) > 0))) Then
    Begin

      qryUpdate := fCriaQuery(Self);
      With qryUpdate, SQl Do
      Begin
        Add(' UPDATE ACAGER SET          ');
        Add('   ACA_PREULT = :PREULT,    ');
        Add('   ACA_IMPULT = :ULTIMP    ');
        { Req: 314353, Retirado o update, pois não pode zerar o valor do preço médio, valor que já foi calculado na geração da acager pelo faturamento
         Add('   ,ACA_PREMED = :PREMED     ');}
        Add(' WHERE ACA_CODACA = :CODACA ');
        Add('   AND ACA_CODEMP = :CODEMP ');
        Add('   AND ACA_EMPEST = :EMPEST ');

        ParamByName('PREULT').AsFloat := fltPreUlt;
        ParamByName('ULTIMP').AsFloat := fltPreUltImp;
        {ParamByName('PREMED').AsFloat := fltPreMed;}

        ParamByName('CODACA').AsString := qryMovDet.FieldByName('DET_CODACA').AsString;
        ParamByName('CODEMP').AsString := qryMovDet.FieldByName('DET_EMPACA').AsString;
        ParamByName('EMPEST').AsString := VS_strCodEmp;

        ExecSQL;


      End;
      FreeAndNil(qryUpdate);
    End;

    If fEmptyStr(FieldByName('DET_CODACA').AsString) And
       (((Pos(strClaFisDet, VS_strClaCom + '_1117_2117_1116_2116' + strClaFisBonificacao) > 0) And (Not (Pos(strCodFor, strForFil) > 0))) Or
        ((blnAtuMed Or blnAtuUlt) And (Pos(strCodFor, strForFil) > 0))) Then
    Begin

      If (Not blnTesteMargem) Then
        pAtualizaUltimaCompra(FieldByName('DET_NUMDOC').AsString,
                              strEspDoc,
                              FieldByName('DET_SERIE_').AsString,
                              strCodFor,
                              FieldByName('DET_CODITE').AsString,
                              strClaFisDet, '',
                              strForFil,
                              strNumLot,
                              strMedEmp,
                              strEmpMeds,
                              blnAtuMed,
                              blnAtuUlt,
                              blnMedSe2,
                              fltPreUlt,
                              fltPreUltImp,
                              fltPreMed,
                              FieldByName('DET_QTDITE').AsFloat,
                              0,
                              VS_Date,
                              False,
                              Nil,
                              False,
                              blnAtualizouPreMed);

      If blnAtpRau And ((Pos(strCodFor, strForFil) = 0) Or blnAtpRen) Then
      Begin

        If blnGerarLotePrecos And (Pos(strCodFor, strForFil) > 0) Then
        Begin


        End Else
        Begin

          If FieldByName('ITE_PREDOL').AsString <> 'S' Then
          Begin
            If (Not blnTesteMargem) Then
              pAtualizaPreco(recPrecos, fltPreCom, fltPreCus);

            blnAtualizouPreco := True;
          End;

        End;

      End;

    End;

    If (Not blnTesteMargem) Then
    Begin

      {*********************************************}
      {* ATUALIZA ESTOQUE SE NAO FOR ITEW ESPECIAL *}
      {******************************************JB*}
      If Not fIsItemEspecial(FieldByName('DET_CODITE').AsString) Then
      Begin

        If fEmptyStr(FieldByName('DET_CODACA').AsString) Then
        Begin

          If fMovimentaSubItemEmpFul(qryMovDet) Then
            Result := Result And fGeraOrdemProducaoSubItem(strNumDoc, strEspDoc,
                                                           FieldByName('DET_CODITE').AsString,
                                                           FieldByName('DET_QTDITE').AsFloat)
          Else
          If fMovimentaSubItemEmpCar(qryMovDet) Then
            Result := Result And fGeraOrdemProducaoSubItem(strNumDoc, strEspDoc,
                                                           FieldByName('DET_CODITE').AsString,
                                                           FieldByName('DET_QTDITE').AsFloat)
          Else
            Result := Result And fAtualizaEstoqueCadIte(FieldByName('DET_CODITE').AsString,
                                                        'E', FieldByName('DET_QTDITE').AsFloat,
                                                        0.0, strNumLot);
        End
        Else
        Begin
         // validar endereçamento
          if intESTFLJ = 1 then
          begin
            Result := Result And TProdAcabado.fAtualizaEstoque(FieldByName('DET_CODACA').AsString,
                                                               FieldByName('DET_EMPACA').AsString,
                                                               VS_strCodEmp,
                                                               'E',
                                                               FieldByName('DET_QTDITE').AsFloat);
          end
          else
          begin
            Result := Result And fBaixaProdutoAcabadoDecomposto('', FieldByName('DET_CODACA').AsString,
              FieldByName('DET_EMPACA').AsString,

              FieldByName('DET_ESPDOC').AsString,         // Espécie da Devolução
              FieldByName('DET_NUMDOC').AsString,         // Documento da Devolução
              FieldByName('DET_CODEMP').AsString,         // Empresa da Devolução
              '', // strCodOco
              FieldByName('DET_CODEMP').AsString,
              strCndPag,
              strCodOpe,
              strNumDoc,
              strEspDoc,
              strCodEmp,
              strCodFor,
              strAutInc,
              strSerie,
              FieldByName('DET_QTDITE').AsFloat,
              FieldByName('DET_QTDITE').AsFloat,

              FieldByName('DET_VLRCON').AsFloat,
              FieldByName('DET_TOTITE').AsFloat,

              dtaDtaEnt,
              False,
              strAutIncMovGer,
              'F');

            If Result Then
              objAuditoriaSaldo.Adicionar(strAutIncMovGer, 'MOVGER');

             {***********************************************************
             ** Atualiza o saldo do item BASE da Tinta imobiliária.  ***
             ** Req. 204434                                          ***
             **********************************************************}
             If (fTipoTinta(FieldByName('DET_IDEPRO').AsString) = ttImobiliaria) Then
             Begin
               Result := Result And fAtualizaEstoqueCadIte(FieldByName('DET_CODITE').AsString,
                                'E', FieldByName('DET_QTDITE').AsFloat,
                                0.0, strNumLot);
             End;

          end;

        End;

      End;

      {*****************************************}
      {* GRAVA PREALT                          *}
      {**************************************MV*}
      If blnAtualizouPreco Then
      Begin
        If (Not VS_blnPreAltViaTrigger) Then
          Result := fGravaPreAlt(FieldByName('DET_CODITE').AsString,

                             FieldByName('ITE_PRECUS').AsFloat,
                             fltPreCus,

                             FieldByName('ITE_PREVE1').AsFloat,
                             recPrecos[01].fltPreVen,

                             FieldByName('ITE_MARBR1').AsFloat,
                             recPrecos[01].fltMarBru,

                             FieldByName('ITE_PREVE2').AsFloat,
                             recPrecos[02].fltPreVen,

                             FieldByName('ITE_MARBR2').AsFloat,
                             recPrecos[02].fltMarBru,

                             FieldByName('ITE_PREVE3').AsFloat,
                             recPrecos[03].fltPreVen,

                             FieldByName('ITE_MARBR3').AsFloat,
                             recPrecos[03].fltMarBru,

                             FieldByName('ITE_PREVE4').AsFloat,
                             recPrecos[04].fltPreVen,

                             FieldByName('ITE_MARBR4').AsFloat,
                             recPrecos[04].fltMarBru,

                             FieldByName('ITE_PREVE5').AsFloat,
                             recPrecos[05].fltPreVen,

                             FieldByName('ITE_MARBR5').AsFloat,
                             recPrecos[05].fltMarBru,

                             FieldByName('ITE_PREVE6').AsFloat,
                             recPrecos[06].fltPreVen,

                             FieldByName('ITE_MARBR6').AsFloat,
                             recPrecos[06].fltMarBru,

                             FieldByName('ITE_PREVE7').AsFloat,
                             recPrecos[07].fltPreVen,

                             FieldByName('ITE_MARBR7').AsFloat,
                             recPrecos[07].fltMarBru,

                             FieldByName('ITE_PRECOM').AsFloat,
                             fltPreCom,

                             'TRANSFERENCIA DE ESTOQUE',

                             Nil,
                             '',
                             strLoginUsuarioLogado);

        pAtualizaItensGrupoPrecos(FieldByName('DET_CODITE').AsString,
                                    'TRANSFERENCIA DE ESTOQUE', strAgrupadorPreAlt);

      End;

    End;

  End; {With}

  FreeAndNil(objImpUlt);
End;

function TfrmRecTransfEstoque.fAtualizaMovGer(arrDadLiv: TarrDadLiv): Boolean;
var strTabelaAux: String;
    intCol: integer;
    strClaFi1, strClaFi2, strClaFi3, strClaFi4: string;
    fltBasIpi,
    fltTotIpi,
    fltBasIcm,
    fltTotIcm,
    fltValRet,
    fltBasRet,
    fltBasAnt,
    fltValAnt: Double;
    qryComand: TUniQuery;
begin
  Result := True;
  Try
    strTabelaAux := 'AUXMOV';
    If strArqMovGer = 'NOTGER' Then
      strTabelaAux := 'AUXNOT';


    fltBasIpi := 0;
    fltTotIpi := 0;
    fltBasIcm := 0;
    fltTotIcm := 0;
    fltValRet := 0;
    fltBasRet := 0;
    fltBasAnt := 0;
    fltValAnt := 0;

    For intCol := 1 To 5 do
    Begin
      case intCol of
        1 : strClaFi1 :=  arrDadLiv[intCol].strClaFis;
        2 : strClaFi2 :=  arrDadLiv[intCol].strClaFis;
        3 : strClaFi3 :=  arrDadLiv[intCol].strClaFis;
        4 : strClaFi4 :=  arrDadLiv[intCol].strClaFis;
      end;

      fltBasIcm := fltBasIcm + arrDadLiv[intCol].fltBasIcm;
      fltTotIcm := fltTotIcm + arrDadLiv[intCol].fltValIcm;
      fltBasRet := fltBasRet + arrDadLiv[intCol].fltBasRet;
      fltValRet := fltValRet + arrDadLiv[intCol].fltRetido;
      fltBasAnt := fltBasAnt + arrDadLiv[intCol].fltBasAnt;
      fltValAnt := fltValAnt + arrDadLiv[intCol].fltValAnt;

      fltBasIpi := fltBasIpi + arrDadLiv[intCol].fltBasIpi;
      fltTotIpi := fltTotIpi + arrDadLiv[intCol].fltValIpi;
    End;

    qryComand := fCriaQuery;
    Try
      qryComand.SQL.Add('UPDATE ' + strArqMovGer + ' SET ');
      qryComand.SQL.Add('GER_CLAFIS = :GER_CLAFIS,');
      qryComand.SQL.Add('GER_CLAFI2 = :GER_CLAFI2,');
      qryComand.SQL.Add('GER_CLAFI3 = :GER_CLAFI3,');
      qryComand.SQL.Add('GER_CLAFI4 = :GER_CLAFI4,');
      qryComand.SQL.Add('');
      qryComand.SQL.Add('GER_BASIPI = :GER_BASIPI,');
      qryComand.SQL.Add('GER_TOTIPI = :GER_TOTIPI,');
      qryComand.SQL.Add('GER_BASICM = :GER_BASICM,');
      qryComand.SQL.Add('GER_TOTICM = :GER_TOTICM,');
      qryComand.SQL.Add('');
      qryComand.SQL.Add('GER_BASRET = :GER_BASRET,');
      qryComand.SQL.Add('GER_TOTRET = :GER_TOTRET');
      qryComand.SQL.Add('WHERE AUTOINCREM = "'+strAutInc+'"');

      qryComand.ParamByName('GER_BASIPI').AsFloat := fltValRet;
      qryComand.ParamByName('GER_TOTIPI').AsFloat := fltTotIpi;
      qryComand.ParamByName('GER_BASICM').AsFloat := fltBasIcm;
      qryComand.ParamByName('GER_TOTICM').AsFloat := fltTotIcm;
      qryComand.ParamByName('GER_BASRET').AsFloat := fltBasRet;
      qryComand.ParamByName('GER_TOTRET').AsFloat := fltValRet;


      qryComand.ParamByName('GER_CLAFIS').AsString := strClaFi1;
      qryComand.ParamByName('GER_CLAFI2').AsString := strClaFi2;
      qryComand.ParamByName('GER_CLAFI3').AsString := strClaFi3;
      qryComand.ParamByName('GER_CLAFI4').AsString := strClaFi4;

      qryComand.ExecSQL;

      qryComand.SQL.Clear;

      qryComand.SQL.Add('UPDATE ' + strTabelaAux + ' SET AUX_BASANT = :AUX_BASANT,   AUX_TOTANT = :AUX_TOTANT WHERE AUX_SEQGER =  "'+strAutInc+'"');
      qryComand.ParamByName('AUX_BASANT').AsFloat := fltBasAnt;
      qryComand.ParamByName('AUX_TOTANT').AsFloat := fltValAnt;
      qryComand.ExecSQL;
    Finally
      FreeAndNil(qryComand);
    End;
  Except
    On E: Exception do
    Begin
      If fTranferenciaAutomaticaFulfillment Then
        strMensagem := E.Message
      Else
        pMensagensErro(e.Message, '[TfrmRecTransfEstoque.fAtualizaMovGer]');
      Result := False;

    End;
  End;
end;

Function TfrmRecTransfEstoque.fAtualizaPedido: Boolean;
  Var
    cdsPedidos: TUniClientDataSet;
    stlPedidos: TStringList;
    oleItensPedidos: OleVariant;
    blnBaiPed: Boolean;

    objDefBaixa: TDefineBaixaPedido;
Begin
  Result := True;

  If fEmptyStr(strNumPed) Then
  Begin
    If Assigned(pgbGravando) Then
      pgbGravando.Position := pgbGravando.Position + 1;
    Application.ProcessMessages;
    Exit;
  End;

  stlPedidos := TStringList.Create;
  cdsPedidos := TUniClientDataSet.Create(Self);

  stlPedidos.Clear;
  stlPedidos.Add(strNumPed + strEmpPed);

  objDefBaixa := TDefineBaixaPedido.Create(Nil);

  If (blnGarantia) then
  Begin
    oleItensPedidos := fDefinePedidosABaixarGarantia(blnBaiPed, qryMovDet, fCfgSis('CNVEMB'),
                                                     {blnRefugo : Boolean =} False,
                                                     {blnBaixa  : Boolean =} False,
                                                     objDefBaixa,
                                                     'AUTOINCREMENTO_GRAVACAO');
  End Else
  Begin
    oleItensPedidos := fDefinePedidosABaixar(blnBaiPed,
                                             qryMovDet,
                                             stlPedidos,
                                             '',
                                             True,
                                             SameText(strArqMovGer, 'MOVGER') And SameText(cdsConsulta.FieldByName('TIPSEN').AsString, 'SENHA1'),
                                             objDefBaixa,
                                             'AUTOINCREMENTO_GRAVACAO');
  End;

  If Not blnBaiPed  then
  Begin
    FreeAndNil(stlPedidos);
    FreeAndNil(cdsPedidos);
    Result := False;
    Exit;
  End;

  If objDefBaixa.Active And (Not objDefBaixa.fSalva) Then
  begin
    FreeAndNil(stlPedidos);
    FreeAndNil(cdsPedidos);
    FreeAndNil(objDefBaixa);
    Result := False;
    Exit;
  End;

  FreeAndNil(objDefBaixa);


  If oleItensPedidos <> Null Then
  Begin
    cdsPedidos.Data := oleItensPedidos;
    cdsPedidos.IndexFieldNames := 'NUMPED;CODEMP;CODITE';
    cdsPedidos.Filtered := False;
    cdsPedidos.First;
  End;

  With cdsPedidos Do
  Begin
  
    While Not Eof Do
    Begin
      If Not fEmptyStr(strCodFor) Then
        Result := fGravaHistoricoEntradaMercadorias(strNumDoc,
                                                    strEspDoc,
                                                    strCodEmp,
                                                    strCodFor,
                                                    strSerie,
                                                    FieldByName('NUMPED').AsString,
                                                    FieldByName('CODEMP').AsString,
                                                    FieldByName('CODITE').AsString,
                                                    FieldByName('DESITE').AsString,
                                                    FieldByName('QTDITE').AsFloat,
                                                    FieldByName('UNITAR').AsFloat,
                                                    FieldByName('TOTITE').AsFloat,
                                                    FieldByName('QTDBAI').AsFloat,
                                                    FieldByName('UNIBAI').AsFloat,
                                                    FieldByName('TOTBAI').AsFloat,
                                                    FieldByName('EXCESS').AsFloat,
                                                    FieldByName('DIFQTD').AsFloat,
                                                    FieldByName('DIFUNI').AsFloat);

      If (Not Result) Then
        Break;

      If (FieldByName('QTDBAI').AsFloat > 0.0) Then
        Result := fAtualizaDadosPcmDet(FieldByName('QTDBAI').AsFloat + FieldByName('EXCESS').AsFloat,
                                       FieldByName('UNITAR').AsFloat,
                                       FieldByName('NUMPED').AsString,
                                       FieldByName('CODEMP').AsString,
                                       FieldByName('AUTINC').AsString,
                                       '',
                                       strCnvEmb,
                                       False,
                                       IIF(blnGarantia,False,blnSaldoPendente),
                                       blnLibPcm,
                                       strForFil,
                                       intDeqTpc);

       If (Not Result) Then
         Break;

       Next;  
    End; {While}


    if blnGarantia Then
      pAtualizaLoteMovGad(strNumPed, strEmpPed);

    {*****************************************}
    {* ATUALIZA O CAMPO 'PCD_BAIXAD' DE      *}
    {* ACORDO COM A CONFIGURAÇÃO DE USAR     *}
    {* SALDO PENDENTE OU NÃO                 *}
    {**************************************MV*}
    Result := Result And fBaixaPcmDet(strNumPed,
                                      strEmpPed,
                                      IIF(blnGarantia,strNumDoc,''),
                                      IIF(blnGarantia,strEspDoc,''),
                                      IIF(blnGarantia,strSerie,''),
                                      IIF(blnGarantia,False,blnSaldoPendente));

    Result := Result And fBaixaPcmGer(False,
                                      strNumPed,
                                      strEmpPed,
                                      IIF(blnGarantia,strNumDoc,''),
                                      IIF(blnGarantia,strEspDoc,''),
                                      True);

    If (VS_strHabilitarCRM) Then
    Begin
      TUpdateOccurrenceCRM.New()
        .NumDoc(strNumDoc)
        .EspDoc(strEspDoc)
        .CodEmp(strCodEmp)
        .AcaFat(afcPedidoEntradaMercadoria)
        .strNomFrm(Self.Name)
        .pRun();
    End;
  End;{With}

  FreeAndNil(cdsPedidos);
  FreeAndNil(stlPedidos);

  If Assigned(pgbGravando) Then
    pgbGravando.Position := pgbGravando.Position + 1;
  Application.ProcessMessages;
End;

Procedure TfrmRecTransfEstoque.pCriaLivroFiscal(qryGenFis: TUniQuery; Var arrDadLiv: TarrDadLiv);
  Var
    qryMovDet: TUniQuery;
    intCol : integer;
Begin
  arrDadLiv := Default(TarrDadLiv);

  qryMovDet := fCriaQuery;
  Try
    qryMovDet.SQL.Text := fRetSQMovDet;
    qryMovDet.Open;


    intCol := 1;
    While (Not qryMovDet.Eof) Do
    Begin
      arrDadLiv[intCol].strClaFis := qryMovDet.FieldByName('CLAFIS').AsString;
      arrDadLiv[intCol].fltVlrCon := qryMovDet.FieldByName('VLRCON').AsFloat;
      arrDadLiv[intCol].fltBasIcm := qryMovDet.FieldByName('BASICM').AsFloat;
      arrDadLiv[intCol].fltAlqIcm := qryMovDet.FieldByName('ALQICM').AsFloat;
      arrDadLiv[intCol].fltValIcm := qryMovDet.FieldByName('VALICM').AsFloat;
      arrDadLiv[intCol].fltOutras := qryMovDet.FieldByName('OUTICM').AsFloat;
      arrDadLiv[intCol].fltIsento := qryMovDet.FieldByName('ISEICM').AsFloat;
      arrDadLiv[intCol].fltBasRet := qryMovDet.FieldByName('BASRET').AsFloat;
      arrDadLiv[intCol].fltRetido := qryMovDet.FieldByName('VALRET').AsFloat;
      arrDadLiv[intCol].fltBasAnt := qryMovDet.FieldByName('BASANT').AsFloat;
      arrDadLiv[intCol].fltValAnt := qryMovDet.FieldByName('VALANT').AsFloat;
      arrDadLiv[intCol].fltBaeRet := qryMovDet.FieldByName('BAERET').AsFloat;
      arrDadLiv[intCol].fltVaeRet := qryMovDet.FieldByName('VAERET').AsFloat;
      arrDadLiv[intCol].fltBaeIpi := qryMovDet.FieldByName('BAEIPI').AsFloat;
      arrDadLiv[intCol].fltVaeIpi := qryMovDet.FieldByName('VAEIPI').AsFloat;
      arrDadLiv[intCol].fltBFCPST := qryMovDet.FieldByName('BFCPST').AsFloat;
      arrDadLiv[intCol].fltVFCPST := qryMovDet.FieldByName('VFCPST').AsFloat;
      arrDadLiv[intCol].fltBasFcp := qryMovDet.FieldByName('BASFCP').AsFloat;
      arrDadLiv[intCol].fltValFcp := qryMovDet.FieldByName('VALFCP').AsFloat;
      arrDadLiv[intCol].fltBasIpi := qryMovDet.FieldByName('BASIPI').AsFloat;
      arrDadLiv[intCol].fltValIpi := qryMovDet.FieldByName('VALIPI').AsFloat;
      arrDadLiv[intCol].fltBasCbs := qryMovDet.FieldByName('BASCBS').AsFloat;
      arrDadLiv[intCol].fltVlrCbs := qryMovDet.FieldByName('VLRCBS').AsFloat;
      arrDadLiv[intCol].fltBasIbs := qryMovDet.FieldByName('BASIBS').AsFloat;
      arrDadLiv[intCol].fltVlrIbs := qryMovDet.FieldByName('VLRIBS').AsFloat;
      arrDadLiv[intCol].fltBas_IS := qryMovDet.FieldByName('BAS_IS').AsFloat;
      arrDadLiv[intCol].fltVlr_IS := qryMovDet.FieldByName('VLR_IS').AsFloat;
      arrDadLiv[intCol].fltBasCbs := qryMovDet.FieldByName('BASCBS').AsFloat;
      arrDadLiv[intCol].fltVlrCbs := qryMovDet.FieldByName('VLRCBS').AsFloat;
      arrDadLiv[intCol].fltBasIbs := qryMovDet.FieldByName('BASIBS').AsFloat;
      arrDadLiv[intCol].fltVlrIbs := qryMovDet.FieldByName('VLRIBS').AsFloat;
      arrDadLiv[intCol].fltBas_IS := qryMovDet.FieldByName('BAS_IS').AsFloat;
      arrDadLiv[intCol].fltVlr_IS := qryMovDet.FieldByName('VLR_IS').AsFloat;


      Inc(intCol);
      qryMovDet.Next;
    End;
  finally
    FreeAndNil(qryMovDet)
  End;
End;

function TfrmRecTransfEstoque.fGravaFatDor: Boolean;
  var
    objGarant: TMovGag;
begin
  Result := True;
  {*****************************************************************}
  {* SE FOR UMA ENTRADA DE MERCADORIA, REFERENTE A UM PEDIDO DE    *}
  {* COMPRA GERADO ATRAVÉS DE UMA TRANSFERENCIA DE ESTOQUE DE      *}
  {* GARANTIA, GRAVA PEDIDO DE VENDA PARA RESERVAR O PRODUTO, POIS *}
  {* O MESMO NÃO PODE SER VENDIDO PELO FATO DE ESTAR COM DEFEITO.  *}
  {**************************************************************MM*}
  If (blnGarantia) and (not fConferenciaDepoisDaEntrada) Then
  Begin

    Result := False;

    pAbreMovDet('MOVDET');

    pgbGravando.Properties.Max := qryMovDet.RecordCount + 3; // Pedido + CadFis + Financeiro

    With qryMovDet Do
    While (Not Eof) Do
    Begin
      strAutIncPedDet := '';

      If fEmptyStr(FieldByName('ENT_SEQPCD').AsString) Then
      Begin
         fRollBack ;
         pMensagemOk('Não foi encontrado o pedido de compra referente a essa transferência de garantia. por favor entre em contato com a Citel.');
         Exit(False);
      End;


      Result := untFatGor.fGravaFatDor(strAutIncPedDet,
                                       strAutIncPed,
                                       strCodEmp,
                                       strCodCliPed,
                                       strCodOpe,
                                       FieldByName('DET_CODITE').AsString,
                                       FieldByName('DET_CODMAR').AsString,
                                       '',
                                       strNumPedVen,
                                       'PD',
                                       '',
                                       VS_Date,
                                       fTime(),
                                       '01000',
                                       '',
                                       FieldByName('DET_DESCRI').AsString,
                                       FieldByName('DET_REFERE').AsString,
                                       FieldByName('DET_UNIDAD').AsString,
                                       IfThen(fEmptyStr(FieldByName('DET_CODFOR').AsString), fRetFornecedorItem(FieldByName('DET_CODITE').AsString), FieldByName('DET_CODFOR').AsString),
                                       FieldByName('DET_QTDITE').AsFloat,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       fRetCodRepresCliente(fRetornaClienteFilial(strCodEmp)),
                                       '',
                                       0,
                                       0,
                                       0,
                                       '5999',
                                       '',
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       False,
                                       '',
                                       '',
                                       '',
                                       0,
                                       '',
                                       '',
                                       0.0,
                                       'NOR',
                                       '',
                                       '',
                                       '',
                                       '',
                                       '',
                                       '',
                                       '',
                                       '',
                                       '',
                                       0,
                                       0,
                                       '',
                                       0,
                                       0,
                                       0,
                                       '',
                                       '',
                                       0,
                                       '',
                                       '',
                                       0.0,
                                       0,
                                       0,
                                       0,
                                       '',
                                       0,
                                       '',
                                       '',
                                       False,
                                       '1',
                                       '',
                                       '',
                                       '',
                                       0,
                                       '',
                                       0,
                                       '',
                                       '',
                                       'N',
                                       '',
                                       0,
                                       0,
                                       0,
                                       0,
                                       '',
                                       '',
                                       '',
                                       False,
                                       '',
                                       '',
                                       '',
                                       '',
                                       '',
                                       '',
                                       0,
                                       0,
                                       '',
                                       '',
                                       0,
                                       '',
                                       '',
                                       0,
                                       0,
                                       0);

      If (Result) Then
      Begin
        Try
          objGarant := TMovGag.Create(Nil);
          Result := objGarant.objMovGad.fAtualizaSeqGarantia('SEQ_FATDOR', strAutIncPedDet, 'SEQ_PCMDET', FieldByName('ENT_SEQPCD').AsString);
        Except
          ON E : Exception Do
          Begin
            Result := False;
            pMensagensErro(e.message,'');
          End;
        End;

        FreeAndNil(objGarant);

      End;

      Next;
    end;

  End;

end;

function TfrmRecTransfEstoque.fGravaFatGor: Boolean;
  Var
    recServicos: TDadosServicos;
    arrDuplic : TarrDuplicata;
begin
  Result := True;
  FillChar(recServicos, SizeOf(recServicos), #0);
  FillChar(arrDuplic, Sizeof(arrDuplic) , #0);
  {*****************************************************************}
  {* SE FOR UMA ENTRADA DE MERCADORIA, REFERENTE A UM PEDIDO DE    *}
  {* COMPRA GERADO ATRAVÉS DE UMA TRANSFERENCIA DE ESTOQUE DE      *}
  {* GARANTIA, GRAVA PEDIDO DE VENDA PARA RESERVAR O PRODUTO, POIS *}
  {* O MESMO NÃO PODE SER VENDIDO PELO FATO DE ESTAR COM DEFEITO.  *}
  {**************************************************************MM*}
  If (blnGarantia) and (not fConferenciaDepoisDaEntrada) Then
  Begin
    strNumPedVen := fRetSequencialPedido;
    strCodCliPed := fRetornaClienteFilial(VS_strCodEmp);
    strCodOpe    := strLoginUsuarioLogado;

    Result := untFatGor.fGravaFatGor(strAutIncPed,
                                     VS_strCodEmp,
                                     strNumPedVen,
                                     'PD',
                                     strCodCliPed,
                                     strCodOpe,
                                     '',
                                     '',
                                     VS_Date,
                                     fTime(),
                                     '01000',
                                     fRetNomCidade(fRetNomGeral('CLI_CODCID', 'CLI_CODCLI', 'CADCLI', fStrToFloat(strCodCliPed)) ,1),
                                     '',
                                     '',
                                     '',
                                     '',
                                     '',
                                     '',
                                     '',
                                     '',
                                     0,
                                     '',
                                     '',
                                     '',
                                     '',
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     '',
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     arrDuplic,
                                     '',
                                     '',
                                     'GARANTIA',
                                     '',
                                     False,
                                     '',
                                     '',
                                     '',
                                     0,
                                     '',
                                     '',
                                     0.0,
                                     0,
                                     strCodOpe,
                                     '',
                                     '',
                                     recServicos,
                                     '',
                                     0,
                                     0,
                                     0,
                                     '',
                                     '',
                                     '',
                                     0,
                                     '',
                                     0,
                                     '1',
                                     '',
                                     0,
                                     '',
                                     '',
                                     False,
                                     '',
                                     '',
                                     '',
                                     '',
                                     '',
                                     '',
                                     '',
                                     False,
                                     VS_Date,
                                     'N',
                                     'V',
                                     VS_Date,
                                     '',
                                     0,
                                     '',
                                     '',
                                     '',
                                     False,
                                     '',
                                     Nil,
                                     '',
                                     '',
                                     0,
                                     0,
                                     0,
                                     '',
                                     Nil,
                                     '',
                                     0,
                                     0,
                                     '',
                                     '',
                                     0,
                                     '',
                                     0,
                                     '',
                                     '0',
                                     'N',
                                     'N');
  End;

end;

Function TfrmRecTransfEstoque.fGravaCadFis: Boolean;
  Var
    qryGenFis: TUniQuery;
    strSQL: String;
    arrDadLiv: TarrDadLiv;
    strNumDocMsg : String;
    arrLivFisRT: TArrLivFis;
    pArrLivFisRT: PArrLivFis;
    intBlocoRT: Integer;
    fltTotIbsRT,
    fltTotCbsRT,
    fltTotIsRT,
    fltTotProIsRT,
    fltTotNfRT: Double;
Begin
  Result := True;

  {*******************************************}
  {* SE FOR CAIXA 1 ENTAO GRAVA O LIVRO      *}
  {****************************************LA*}
  If SameText(strArqMovGer, 'MOVGER') And SameText(cdsConsulta.FieldByName('TIPSEN').AsString, 'SENHA1') Then
  Begin
    qryGenFis := fCriaQuery;

    {*****************************************}
    {* GRAVA O CADFIS                        *}
    {**************************************LA*}
    strSQL := '';
    strSQL := strSQL + 'SELECT                     ';
    strSQL := strSQL + '  *                        ';
    strSQL := strSQL + 'FROM                       ';
    strSQL := strSQL + '  CADFIS                   ';
    strSQL := strSQL + 'WHERE                      ';
    strSQL := strSQL + '  FIS_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  FIS_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  FIS_CODEMP = :CODEMP AND ';

    If fEmptyStr(cdsConsulta.FieldByName('GER_SERIE_').AsString) Then
      strSQL := strSQL + '  IFNULL(FIS_SERIE_, "") = "" AND '
    Else
      strSQL := strSQL + '  FIS_SERIE_ = :SERIE_ AND ';

    strSQL := strSQL + '  FIS_FORCLI = :CODCLI     ';

    With qryGenFis Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('NUMDOC').AsString := cdsConsulta.FieldByName('GER_NUMDOC').AsString;
      ParamByName('ESPDOC').AsString := cdsConsulta.FieldByName('GER_ESPDOC').AsString;
      ParamByName('CODEMP').AsString := cdsConsulta.FieldByName('GER_CODEMP').AsString;

      If Not fEmptyStr(cdsConsulta.FieldByName('GER_SERIE_').AsString) Then
        ParamByName('SERIE_').AsString := cdsConsulta.FieldByName('GER_SERIE_').AsString;

      ParamByName('CODCLI').AsString := cdsConsulta.FieldByName('GER_CODCLI').AsString;
      If fEmptyStr(ParamByName('CODCLI').AsString) Then
        ParamByName('CODCLI').AsString := cdsConsulta.FieldByName('GER_CODFOR').AsString;

      Open;

      strNumDocMsg := cdsConsulta.FieldByName('GER_NUMDOC').AsString + '-' +
                      cdsConsulta.FieldByName('GER_ESPDOC').AsString + '-' +
                      cdsConsulta.FieldByName('GER_CODEMP').AsString;

      If IsEmpty Then
      Begin
        fRollBack;
        fMensagem('', 'Registro do Livro Fiscal não encontrado para o documento ' +  strNumDocMsg, ['&Ok']);
        Result := False;
        Exit;
      End;

      pCriaLivroFiscal(qryGenFis, arrDadLiv);

      fltTotIbsRT   := FieldByName('FIS_TOTIBS').AsFloat;
      fltTotCbsRT   := FieldByName('FIS_TOTCBS').AsFloat;
      fltTotIsRT    := FieldByName('FIS_TOT_IS').AsFloat;
      fltTotProIsRT := FieldByName('FIS_TPROIS').AsFloat;
      fltTotNfRT    := FieldByName('FIS_TOT_NF').AsFloat;

      pArrLivFisRT := Nil;
      If (fltTotCbsRT + fltTotIbsRT + fltTotIsRT) > 0 Then
      Begin
        arrLivFisRT := Default(TArrLivFis);
        For intBlocoRT := 1 To 5 Do
        Begin
          arrLivFisRT[intBlocoRT].strClaFis := arrDadLiv[intBlocoRT].strClaFis;
          arrLivFisRT[intBlocoRT].fltBasCbs := arrDadLiv[intBlocoRT].fltBasCbs;
          arrLivFisRT[intBlocoRT].fltVlrCbs := arrDadLiv[intBlocoRT].fltVlrCbs;
          arrLivFisRT[intBlocoRT].fltBasIbs := arrDadLiv[intBlocoRT].fltBasIbs;
          arrLivFisRT[intBlocoRT].fltVlrIbs := arrDadLiv[intBlocoRT].fltVlrIbs;
          arrLivFisRT[intBlocoRT].fltBas_IS := arrDadLiv[intBlocoRT].fltBas_IS;
          arrLivFisRT[intBlocoRT].fltVlr_IS := arrDadLiv[intBlocoRT].fltVlr_IS;
        End;
        pArrLivFisRT := @arrLivFisRT;
      End;
      // strClaFis := fTrocaClaFis(arrDadLiv[1].strClaFis, arrDadLiv[1].blnSubst);
      Result := fAtualizaMovGer(arrDadLiv);
      If not Result Then
        Exit;
      Result := untCadFis.fGravaCadFis(strAutIncCadFis,
                                       IIF(fConferenciaDepoisDaEntrada, 0, dtaDtaEnt), // Data de Entrada
                                       strNumDoc,                            // Número do Documento
                                       '',                                   // Número do Documento 2
                                       strEspDoc,                            // Espécie
                                       'E',                                  // Entrada / Saida
                                       FieldByName('FIS_DTADOC').AsDateTime, // Data do Documento
                                       'F',                                  // Tipo (F)ornecedor / (C)liente
                                       strCodFor,                            // Código Fornecedor / Cliente
                                       FieldByName('FIS_HISTOR').AsString,   // Histórico
                                       FieldByName('FIS_NFCOMP').AsString,   // ???
                                       FieldByName('FIS_NOTESP').AsString,   // ???
                                       arrDadLiv[1].strClaFis, // Classificação Fiscal 1
                                       arrDadLiv[1].fltVlrCon,               // Valor Contábil 1
                                       arrDadLiv[1].fltBasIcm,               // Base de ICMS 1
                                       arrDadLiv[1].fltAlqIcm,               // Aliquota de ICMS 1
                                       arrDadLiv[1].fltValIcm,               // Valor de ICMS 1
                                       arrDadLiv[1].fltOutras,               // Valor de Outras 1
                                       arrDadLiv[1].fltIsento,               // Valor de Isento 1
                                       arrDadLiv[1].fltRetido,               // Valor de Retido 1
                                       arrDadLiv[1].fltBasIpi,               // Base de IPI 1
                                       arrDadLiv[1].fltValIpi,               // Valor de IPI 1
                                       arrDadLiv[1].fltBasRet,               // Base de Substituição 1
                                       arrDadLiv[1].fltDesAce,               // Valor de Despesa Acessária 1
                                       0.0,                                  // Valor do ISS 1
                                       arrDadLiv[2].strClaFis, // Classificação Fiscal 2
                                       arrDadLiv[2].fltVlrCon,               // Valor Contábil 2
                                       arrDadLiv[2].fltBasIcm,               // Base de ICMS 2
                                       arrDadLiv[2].fltAlqIcm,               // Aliquota de ICMS 2
                                       arrDadLiv[2].fltValIcm,               // Valor de ICMS 2
                                       arrDadLiv[2].fltOutras,               // Valor de Outras 2
                                       arrDadLiv[2].fltIsento,               // Valor de Isento 2
                                       arrDadLiv[2].fltRetido,               // Valor de Retido 2
                                       arrDadLiv[2].fltBasIpi,               // Base de IPI 2
                                       arrDadLiv[2].fltValIpi,               // Valor de IPI 2
                                       arrDadLiv[2].fltBasRet,               // Base de Substituição 2
                                       arrDadLiv[2].fltDesAce,               // Valor de Despesa Acessária 2
                                       0.0,                                  // Valor do ISS 2
                                       arrDadLiv[3].strClaFis, // Classificação Fiscal 3
                                       arrDadLiv[3].fltVlrCon,               // Valor Contábil 3
                                       arrDadLiv[3].fltBasIcm,               // Base de ICMS 3
                                       arrDadLiv[3].fltAlqIcm,               // Aliquota de ICMS 3
                                       arrDadLiv[3].fltValIcm,               // Valor de ICMS 3
                                       arrDadLiv[3].fltOutras,               // Valor de Outras 3
                                       arrDadLiv[3].fltIsento,               // Valor de Isento 3
                                       arrDadLiv[3].fltRetido,               // Valor de Retido 3
                                       arrDadLiv[3].fltBasIpi,               // Base de IPI 3
                                       arrDadLiv[3].fltValIpi,               // Valor de IPI 3
                                       arrDadLiv[3].fltBasRet,               // Base de Substituição 3
                                       arrDadLiv[3].fltDesAce,               // Valor de Despesa Acessária 3
                                       0.0,                                  // Valor do ISS 3
                                       arrDadLiv[4].strClaFis,  // Classificação Fiscal 4
                                       arrDadLiv[4].fltVlrCon,               // Valor Contábil 4
                                       arrDadLiv[4].fltBasIcm,               // Base de ICMS 4
                                       arrDadLiv[4].fltAlqIcm,               // Aliquota de ICMS 4
                                       arrDadLiv[4].fltValIcm,               // Valor de ICMS 4
                                       arrDadLiv[4].fltOutras,               // Valor de Outras 4
                                       arrDadLiv[4].fltIsento,               // Valor de Isento 4
                                       arrDadLiv[4].fltRetido,               // Valor de Retido 4
                                       arrDadLiv[4].fltBasIpi,               // Base de IPI 4
                                       arrDadLiv[4].fltValIpi,               // Valor de IPI 4
                                       arrDadLiv[4].fltBasRet,               // Base de Substituição 4
                                       arrDadLiv[4].fltDesAce,               // Valor de Despesa Acessária 4
                                       0.0,                                  // Valor do ISS 4
                                       arrDadLiv[5].strClaFis, // Classificação Fiscal 5
                                       arrDadLiv[5].fltVlrCon,               // Valor Contábil 5
                                       arrDadLiv[5].fltBasIcm,               // Base de ICMS 5
                                       arrDadLiv[5].fltAlqIcm,               // Aliquota de ICMS 5
                                       arrDadLiv[5].fltValIcm,               // Valor de ICMS 5
                                       arrDadLiv[5].fltOutras,               // Valor de Outras 5
                                       arrDadLiv[5].fltIsento,               // Valor de Isento 5
                                       arrDadLiv[5].fltRetido,               // Valor de Retido 5
                                       arrDadLiv[5].fltBasIpi,               // Base de IPI 5
                                       arrDadLiv[5].fltValIpi,               // Valor de IPI 5
                                       arrDadLiv[5].fltBasRet,               // Base de Substituição 5
                                       arrDadLiv[5].fltDesAce,               // Valor de Despesa Acessária 5
                                       0.0,                                  // Valor do ISS 5
                                       fltTotPis,                            // fltTotPis,
                                       fltTotCof,                            // fltTotCof,
                                       fltTotBasPis,                         // fltBasPis,
                                       fltTotBasCof,                         // fltBasCof,
                                       fltTotAlqPis,                         // fltAlqPis,
                                       fltTotAlqCof,                         // fltAlqCof,
                                       strCodEmp,                            // Empresa
                                       strSerie,                             // Série
                                       strEstFor,                            // Estado do Cliente / Fornecedor
                                       '',                                   // Número de Série
                                       '',                                   // Número COO
                                       '',                                   // Código da Conta Contábil
                                       '',                                   // Documento do conhecimento de frete
                                       FieldByName('FIS_ACESSO').AsString,   // Chave de Acesso NF-e
                                       FieldByName('FIS_PROTOC').AsString,   // Numero protocolo NF-e
                                       '',                                   // Origem do documento
                                       '', // strEmpAut
                                       0,  // fltImpMer
                                       0,  // fltImpSeg
                                       0,  // fltImpImp
                                       0,  // fltImpPro
                                       0,  // fltImpTax
                                       0,  // fltImpPis
                                       0,  // fltImpCof
                                       '', // strImpIC1
                                       '', // strImpIC2
                                       '', // strModFre
                                       0,  // fltBasIss
                                       0,  // fltAlqIss
                                       0,  // fltValIss
                                       0,  //fltBaseII: Double = 0;
                                       0,  //fltDesAdu: Double = 0;
                                       0,  //fltValIOF: DOuble = 0;
                                       arrDadLiv[1].fltBasAnt,        //fltBasAn1: Double = 0;
                                       arrDadLiv[1].fltValAnt,        //fltAntIc1: Double = 0;
                                       arrDadLiv[2].fltBasAnt,        //fltBasAn2: Double = 0;
                                       arrDadLiv[2].fltValAnt,        //fltAntIc2: Double = 0;
                                       arrDadLiv[3].fltBasAnt,        //fltBasAn3: Double = 0;
                                       arrDadLiv[3].fltValAnt,        //fltAntIc3: Double = 0;
                                       arrDadLiv[4].fltBasAnt,        //fltBasAn4: Double = 0;
                                       arrDadLiv[4].fltValAnt,        //fltAntIc4: Double = 0;
                                       arrDadLiv[5].fltBasAnt,        //fltBasAn5: Double = 0;
                                       arrDadLiv[5].fltValAnt,        //fltAntIc5: Double = 0;
                                       '',                            //strCstEnt: String = '';
                                       false,
                                       arrDadLiv[1].fltBaeRet,        //ffltBaeRe1: Double = 0;
                                       arrDadLiv[1].fltVaeRet,        //ffltVaeRe1: Double = 0;
                                       arrDadLiv[2].fltBaeRet,        //ffltBaeRe2: Double = 0;
                                       arrDadLiv[2].fltVaeRet,        //ffltVaeRe2: Double = 0;
                                       arrDadLiv[3].fltBaeRet,        //ffltBaeRe3: Double = 0;
                                       arrDadLiv[3].fltVaeRet,        //ffltVaeRe3: Double = 0;
                                       arrDadLiv[4].fltBaeRet,        //ffltBaeRe4: Double = 0;
                                       arrDadLiv[4].fltVaeRet,        //ffltVaeRe4: Double = 0;
                                       arrDadLiv[5].fltBaeRet,        //ffltBaeRe5: Double = 0;
                                       arrDadLiv[5].fltVaeRet,        //fltVaeRe5: Double = 0;
                                       arrDadLiv[1].fltBaeIpi,        //fltBaeIP1: Double = 0;
                                       arrDadLiv[1].fltVaeIpi,        //fltVaeIP1: Double = 0;
                                       arrDadLiv[2].fltBaeIpi,        //fltBaeIP2: Double = 0;
                                       arrDadLiv[2].fltVaeIpi,        //fltVaeIP2: Double = 0;
                                       arrDadLiv[3].fltBaeIpi,        //fltBaeIP3: Double = 0;
                                       arrDadLiv[3].fltVaeIpi,        //fltVaeIP3: Double = 0;
                                       arrDadLiv[4].fltBaeIpi,        //fltBaeIP4: Double = 0;
                                       arrDadLiv[4].fltVaeIpi,        //fltVaeIP4: Double = 0;
                                       arrDadLiv[5].fltBaeIpi,        //fltBaeIP5: Double = 0;
                                       arrDadLiv[5].fltVaeIpi,       //fltVaeIP5: Double = 0) : Boolean;
                                       '',
                                       '',
                                       '',
                                       '',
                                       arrDadLiv[1].fltBFCPST,
                                       arrDadLiv[1].fltVFCPST,
                                       arrDadLiv[2].fltBFCPST,
                                       arrDadLiv[2].fltVFCPST,
                                       arrDadLiv[3].fltBFCPST,
                                       arrDadLiv[3].fltVFCPST,
                                       arrDadLiv[4].fltBFCPST,
                                       arrDadLiv[4].fltVFCPST,
                                       arrDadLiv[5].fltBFCPST,
                                       arrDadLiv[5].fltVFCPST,
                                       0,
                                       0,
                                       '',
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       arrDadLiv[1].fltBASFCP,
                                       arrDadLiv[1].fltVALFCP,
                                       arrDadLiv[2].fltBASFCP,
                                       arrDadLiv[2].fltVALFCP,
                                       arrDadLiv[3].fltBASFCP,
                                       arrDadLiv[3].fltVALFCP,
                                       arrDadLiv[4].fltBASFCP,
                                       arrDadLiv[4].fltVALFCP,
                                       arrDadLiv[5].fltBASFCP,
                                       arrDadLiv[5].fltVALFCP,   // fltVLFCP5
                                       '',             // strTipFre
                                       0,              // fltRFRBAS
                                       0,              // fltRFRALQ
                                       0,              // fltRFRVAL
                                       '',             // strCstIPI
                                       'N',            // strNfCIAP
                                       0,              // fltPesCTE
                                       '',             // strEstornoNotaFiscal
                                       '',             // strEstornoNotaFiscalMotivo
                                       '',             // strNatOpe
                                       '',             // strTB01RE
                                       '',             // strTB06RE
                                       '',             // strBasFre
                                       False,          // blnDevSim
                                       '',             // strCdsErv
                                       0,              // fltQBCMO1
                                       0,              // fltQBCMO2
                                       0,              // fltQBCMO3
                                       0,              // fltQBCMO4
                                       0,              // fltQBCMO5
                                       0,              // fltQBCMO6
                                       0,              // fltQBCMO7
                                       0,              // fltQBCMO8
                                       0,              // fltADREM1
                                       0,              // fltADREM2
                                       0,              // fltADREM3
                                       0,              // fltADREM4
                                       0,              // fltADREM5
                                       0,              // fltADREM6
                                       0,              // fltADREM7
                                       0,              // fltADREM8
                                       0,              // fltVALMO1
                                       0,              // fltVALMO2
                                       0,              // fltVALMO3
                                       0,              // fltVALMO4
                                       0,              // fltVALMO5
                                       0,              // fltVALMO6
                                       0,              // fltVALMO7
                                       0,              // fltVALMO8
                                       '',             // strNfsSub
                                       '',             // strMesAno
                                       '',             // strFinNfe
                                       '',             // strFinTip
                                       fltTotIbsRT,    // fltTotIbs   -> FIS_TOTIBS
                                       fltTotCbsRT,    // fltTotCbs   -> FIS_TOTCBS
                                       fltTotIsRT,     // fltTotIs    -> FIS_TOT_IS
                                       fltTotProIsRT,  // fltTotProIs -> FIS_TPROIS
                                       fltTotNfRT,     // fltTotNf    -> FIS_TOT_NF
                                       '',             // strNumDPS
                                       '',             // strSerDPS
                                       '',             // strCodCCE
                                       '',             // strCodGRT
                                       pArrLivFisRT);  // pArrLivFis  -> AUXFIS

      Close;

    End; {With}

    FreeAndNil(qryGenFis);

  End; {If SameText(strEspDoc, 'NF') Then}

  If Assigned(pgbGravando) Then
    pgbGravando.Position := pgbGravando.Position + 1;
  Application.ProcessMessages;

End;

Function TfrmRecTransfEstoque.fGravaFinanceiro: Boolean;
  Var
    intContador : Integer;
    strHistorico: String;
    strSeqLan   : String;
Begin
  Result := True;

  If (fCfgSis('ENTCTP', varBoolean))     And
     (Pos(strClaFis, VS_strClaCom) > 0)  And
     (fFornecedorGravaCtp(strCodFor))    Then
  Begin

    intContador := 0;
    {*****************************************}
    {* INICIA A GRAVAÇÃO DO CONTAS A PAGAR   *}
    {**************************************MV*}
    While (ArrDuplicata[intContador].dtaDtaVen <> '') And
          (intContador < 24)                          And
          (Result)                                    Do
    Begin

      If (fCfgSis('HISCTP', varBoolean)) Then
        strHistorico := 'REF. AO DOCUMENTO No ' + fStrZero(strNumDoc, 12) + strEspDoc
      Else
        strHistorico := '';

      strSeqLan := '';

      If Pos(ArrDuplicata[intContador].strUsaChq, 'S_N_') <= 0 Then
        ArrDuplicata[intContador].strUsaChq := 'N';


      Result := fGravaCadPag('untRecTransfEstoque - fGravaFinanceiro',                      // Nome Form LogCtp
                             'TRANSFERENCIA DE ESTOQUE',                                    // Descrição LOGCTP
                             strCodFor,                                                     // Fornecedor
                             fStrZero(strNumDoc, 12),                                       // Numero da Duplicata
                             ArrDuplicata[intContador].strSequen,                           // Parcela
                             VS_strCodEmp,                                                  // Empresa
                             strCodCta,                                                     // Centro de Custo
                             strSerie,                                                      // Serie do Documento
                             0,                                                             // Sequencial de Baixa
                             IIF(fConferenciaDepoisDaEntrada, 0, VS_Date),                  // Data do lançamento
                             StrToDate(ArrDuplicata[intContador].dtaDtaVen),                // Data de Vencimento
                             ArrDuplicata[intContador].curValor,                            // Valor da Duplicata
                             ArrDuplicata[intContador].curValor,                            // Valor Original
                             'N',                                                           // Previsão?
                             'N',                                                           // Veio Boleto
                             'N',                                                           // Deposito
                             strHistorico, //'REF. AO DOCUMENTO No ' + fStrZero(strNumDoc, 12) + strEspDoc, // Histórico 1
                             '',                                                            // Histórico 2
                             '',                                                            // Histórico da Baixa
                             '',                                                            // Portador da Baixa
                             '',                                                            // Centro de Custo da Baixa
                             '',                                                            // Documento da Baixa
                             '',                                                            // Operador da Baixa
                             0,                                                             // Data do Pagamento
                             0,                                                             // Valor Pago
                             0,                                                             // Valor de Juros
                             0,                                                             // Valor Desconto
                             VS_strCodEmp,                                                  // Empresa
                             '',                                                            // Código do Evento
                             ArrDuplicata[intContador].strUsaChq,                           // Usa Cheque
                             '',                                                            // Codigo do Portador
                             fStrZero(strNumDoc, 12),                                       // Nro do Documento da Baixa
                             0.0,
                             0.0,
                             0,
                             False,
                             0,
                             '',
                             0,
                             'N',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             'N',
                             FormatDateTime('mm/YYYY',VS_Date),
                             '',
                             '',
                             '',
                             '',
                             0,
                             0,
                             0,
                             0,
                             '',
                             0,
                             0,
                             '',
                             '',
                             '',
                             '',
                             '',
                             '0',
                             '',
                             '',
                             '',
                             '',
                             'N',
                             '',
                             '',
                             '',
                             '',
                             0,
                             '',
                             0,
                             '',
                             0,
                             0,
                             0,
                             '',
                             '',
                             strAutIncCadFis,                                                      // AIncCadFis: string = '';
                             '',                                                            // strQrCode: string = '';
                             'N');                                                          // AUsaMca: String = '' -- Req. 462891

      If blnImprCP Then
        pAdicionaImpressaoCP(fStrZero(strNumDoc, 12),
                             ArrDuplicata[intContador].strSequen,
                             strCodFor,
                             strSerie, Self.Name);


      Inc(intContador);

    End;

  End;

  If Assigned(pgbGravando) Then
    pgbGravando.Position := pgbGravando.Position + 1;
  Application.ProcessMessages;

End;

Function TfrmRecTransfEstoque.fSQLWhereDuplicatas(AApenasBaixada : Boolean = True): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' FROM CADPAG ';
  strSQL := strSQL + ' WHERE ';

  If AApenasBaixada Then
  Begin
    strSQL := strSQL + '   CTP_DTAPAG IS NULL AND ';
    strSQL := strSQL + '   CTP_SEQBAI = 0 AND ';
  End;

  strSQL := strSQL + '   CTP_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '   CTP_CODFOR = :CODFOR AND ';
  strSQL := strSQL + '   IFNULL(CTP_SERIE_, "") = :SERIE_ AND ';
  strSQL := strSQL + '   CTP_CODEMP = :CODEMP ';

  Result := strSQL;
End;


Function TfrmRecTransfEstoque.fSQLSomaDuplicatas(AApenasBaixada : Boolean = True): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SUM(CTP_VALDUP) AS VALDUP ';
  strSQL := strSQL + fSQLWhereDuplicatas(AApenasBaixada);
  Result := strSQL;
End;

function TfrmRecTransfEstoque.fSomenteConferencia(strAutoIncrem, strTipSenha, strTabela: string): Boolean;
Var
  qryBusca: TUniQuery;
Begin
  qryBusca := fCriaQuery;

  try
    if not fCfgSis('EMSRCS', varBoolean) then
      Exit(False);

    qryBusca.SQL.Add('SELECT COUNT(1) AS QTD');
    qryBusca.SQL.Add('FROM CONDOC ');
    qryBusca.SQL.Add('LEFT JOIN CONGER ON CONGER.AUTOINCREM = DOC_SEQCON');
    qryBusca.SQL.Add('WHERE DOC_SEQGER = :SEQGER');
    qryBusca.SQL.Add('AND GER_DTAFIM IS NULL');
    qryBusca.ParamByName('SEQGER').AsString := strAutoIncrem;
    qryBusca.Open;

    Result := qryBusca.FieldByName('QTD').AsInteger > 0;

    if (not Result) And (SameText(strTipSenha, 'SENHA1')) And (SameText(strTabela, 'MOVGER')) then
    begin
      qryBusca.Close;
      qryBusca.SQL.Clear;

      qryBusca.SQL.Add('SELECT COUNT(1) AS QTD FROM MOVGER');
      qryBusca.SQL.Add('INNER JOIN PCMGER ON PCG_ORIGND = MOVGER.GER_NUMDOC AND PCG_ORIGES = MOVGER.GER_ESPDOC AND PCG_DTAPED = MOVGER.GER_DTADOC AND PCG_EMPDES = MOVGER.GER_CODEMP');
      qryBusca.SQL.Add('INNER JOIN MOVGER MV ON MV.GER_NUMDOC = PCG_ORIGND AND MV.GER_ESPDOC = PCG_ORIGES AND MV.GER_CODEMP = PCG_CODEMP');
      qryBusca.SQL.Add('INNER JOIN CONDOC ON DOC_SEQGER = MV.AUTOINCREM');
      qryBusca.SQL.Add('LEFT JOIN CONGER ON CONGER.AUTOINCREM = DOC_SEQCON AND CONGER.GER_DTAFIM IS NULL');
      qryBusca.SQL.Add('WHERE MOVGER.AUTOINCREM = :MOVSEQ');
      qryBusca.ParamByName('MOVSEQ').AsString := strAutoIncrem;
      qryBusca.Open;

      Result := qryBusca.FieldByName('QTD').AsInteger > 0;
    end;
  finally
    begin
      FreeAndNil(qryBusca);
    end;
  end;
End;

Function TfrmRecTransfEstoque.fSQLNotasConfirmadas: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE        ';
  strSQL := strSQL + '   GER_SERIE_,              ';
  strSQL := strSQL + '   GER_NUMDOC               ';
  strSQL := strSQL + ' FROM MOVGER                ';
  strSQL := strSQL + ' WHERE                      ';
  strSQL := strSQL + '   GER_ESPDOC = "TE"    AND ';
  strSQL := strSQL + '   GER_NUMFAT = :NUMFAT AND ';
  strSQL := strSQL + '   GER_TIPFAT = :TIPFAT AND ';
  strSQL := strSQL + '   GER_EMPFAT = :EMPFAT     ';

  Result := strSQL;
End;

Procedure TfrmRecTransfEstoque.pSelecionaCTPDET(qryCadPag, qryCtpDet: TUniQuery);
  Var
    strSQL   : String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CTPDET ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '  IFNULL(CTP_SERIE_, "") = :SERIE_ AND ';
  strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';
  strSQL := strSQL + '  CTP_CODEMP = :CODEMP ';

  qryCtpDet.Close;
  qryCtpDet.SQL.Clear;
  qryCtpDet.SQL.Add(strSQL);
  With qryCadPag Do
  Begin
    qryCtpDet.ParamByName('NUMDUP').AsString := FieldByName('CTP_NUMDUP').AsString;
    qryCtpDet.ParamByName('PARCEL').AsString := FieldByName('CTP_PARCEL').AsString;
    qryCtpDet.ParamByName('SERIE_').AsString := FieldByName('CTP_SERIE_').AsString;
    qryCtpDet.ParamByName('CODFOR').AsString := FieldByName('CTP_CODFOR').AsString;
    qryCtpDet.ParamByName('CODEMP').AsString := FieldByName('CTP_CODEMP').AsString;
  End;
  qryCtpDet.Open;
End;

function TfrmRecTransfEstoque.fCancelaContasPagar(strNumDoc, strCodFor, strSerie: String): Boolean;
  Var
    strSQL   : String;
    qryCadPag: TUniQuery;
    qryCtpDet: TUniQuery;
begin
  qryCadPag := fCriaQuery(Self);
  qryCtpDet := fCriaQuery(Self);

  Try
    Result := True;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + fSQLWhereDuplicatas;

    With qryCadPag Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := strNumDoc;
      ParamByName('CODFOR').AsString := strCodFor;
      ParamByName('SERIE_').AsString := strSerie;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      While (Not Eof) Do
      Begin
        {*******************************************}
        {* SELECIONA O REGISTRO NO CTPDET PARA SER *}
        {* GRAVADO NOS DELETADOS                   *}
        {****************************************LA*}
        pSelecionaCTPDET(qryCadPag, qryCtpDet);

        While (Not qryCtpDet.Eof) Do
        Begin
          fVerificaIntegridade(Self.Name, 'CTPDET', qryCtpDet);
          qryCtpDet.Delete;
        End;
        qryCtpDet.Close;

        fVerificaIntegridade(Self.Name, 'CADPAG', qryCadPag);

        qryCadPag.Delete;
      End;

      Close;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fCancelaContasPagar]');
      Result := False;
    End;
  End;

  FreeAndNil(qryCadPag);
  FreeAndNil(qryCtpDet);
end;

Procedure TfrmRecTransfEstoque.pFaturaNotasConfirmadas(strNumDoc, strSerie_, strCodFor, strNumFat, strTipFat: String);
  Var
    qryMovGer: TUniQuery;
Begin
  qryMovGer := fCriaQuery;
  With qryMovGer, SQL Do
  Begin
    Add('UPDATE MOVGER SET');
    Add('  GER_NUMFAT = :NUMFAT,');
    Add('  GER_EMPFAT = :EMPFAT,');
    Add('  GER_TIPFAT = :TIPFAT ');
    Add('WHERE ');
    Add('  GER_ESPDOC = "PD"    AND ');
    Add('  GER_CODEMP = :CODEMP AND ');
    Add('  GER_NUMDOC = :NUMDOC AND ');
    Add('  GER_CODFOR = :CODFOR AND ');
    Add('  IFNULL(GER_SERIE_, "") = :SERIE_  ');

    ParamByName('CODEMP').AsString  := VS_strCodEmp;
    ParamByName('NUMDOC').AsString  := strNumDoc;
    ParamByName('SERIE_').AsString  := strSerie_;
    ParamByName('CODFOR').AsString  := strCodFor;

    ParamByName('NUMFAT').AsString  := strNumFat;
    ParamByName('EMPFAT').AsString  := VS_strCodEmp;
    ParamByName('TIPFAT').AsString  := strTipFat;

    ExecSQL;
  End;
  FreeAndNil(qryMovGer);
End;

Procedure TfrmRecTransfEstoque.pSalvaDuplicatasConfirmadas(strAutInc, strNumDup, strCodFor, strSerie: String);
  Var
    strSQL   : String;
    qryCadPag: TUniQuery;
    qryCtpDet: TUniQuery;
    qryCtpCnf: TUniQuery;
    qryDetCnf: TUniQuery;

    Procedure pCopiaCadPag;
      Var
        intContador: Integer;
    Begin
      qryCtpCnf.Insert;

      With qryCadPag Do
      For intContador := 0 To Fields.Count - 1 Do
        qryCtpCnf.FieldByName(Fields[intContador].FieldName).Value := Fields[intContador].Value;

      qryCtpCnf.FieldByName('CTP_DOCCNF').AsString := strAutInc;
      qryCtpCnf.Post;
    end;

    Procedure pCopiaCtpDet;
      Var
        intContador: Integer;
    Begin
      qryDetCnf.Insert;

      With qryCtpDet Do
      For intContador := 0 To Fields.Count - 1 Do
        qryDetCnf.FieldByName(Fields[intContador].FieldName).Value := Fields[intContador].Value;

      qryDetCnf.FieldByName('CTP_SEQCTP').AsString := qryCadPag.FieldByName('AUTOINCREM').AsString;
      qryDetCnf.Post;
    end;

begin
  If fEmptyStr(strAutInc) Then
    Exit;

  qryCadPag := fCriaQuery(Self);
  qryCtpDet := fCriaQuery(Self);
  qryCtpCnf := fCriaQuery(Self);
  qryDetCnf := fCriaQuery(Self);

  qryCtpCnf.SQL.Text := 'SELECT * FROM CTPCNF WHERE FALSE';
  qryCtpCnf.Open;

  qryDetCnf.SQL.Text := 'SELECT * FROM CTPDETCNF WHERE FALSE';
  qryDetCnf.Open;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + fSQLWhereDuplicatas;

  With qryCadPag Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDUP').AsString := strNumDup;
    ParamByName('CODFOR').AsString := strCodFor;
    ParamByName('SERIE_').AsString := strSerie;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

    While (Not Eof) Do
    Begin
      pCopiaCadPag;

      pSelecionaCTPDET(qryCadPag, qryCtpDet);

      While Not qryCtpDet.Eof Do
      Begin
        pCopiaCtpDet;
        qryCtpDet.Next;
      End;

      Next;
    End;

  End;

  FreeAndNil(qryCadPag);
  FreeAndNil(qryCtpDet);
  FreeAndNil(qryCtpCnf);
  FreeAndNil(qryDetCnf);
End;

Function TfrmRecTransfEstoque.fRetAutoincMovGer(strNumDoc, strCodFor, strSerie: String): String;
  Var
    qryMovGer: TUniQuery;
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT AUTOINCREM FROM MOVGER WHERE';
  strSQL := strSQL + '   GER_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '   GER_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '   GER_CODFOR = :CODFOR AND ';
  strSQL := strSQL + '   IFNULL(GER_SERIE_, "") = :SERIE_ ';

  qryMovGer := fCriaQuery;
  With qryMovGer Do
  Begin
    SQL.Text := strSQL;

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('CODFOR').AsString := strCodFor;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('SERIE_').AsString := strSerie;

    Open;

    Result := FieldByName('AUTOINCREM').AsString;

    Close;
  End;
  FreeAndNil(qryMovGer);
End;

Function TfrmRecTransfEstoque.fRetTotalDuplicatasAbertas(strNumDoc, strEspDoc,
     strCodEmp, strCodFor: String): Double;
  Var
    qryCadPag: TUniQuery;
    qryMovGer: TUniQuery;
    strGerNumDoc: String;
Begin
  qryCadPag          := fCriaQuery;
  qryCadPag.SQL.Text := fSQLSomaDuplicatas;

  qryMovGer := fCriaQuery;

  With qryMovGer Do
  Begin
    SQL.Text := fSQLNotasConfirmadas;

    ParamByName('NUMFAT').AsString := RightStr(strNumDoc, fTamDocCadRec);
    ParamByName('TIPFAT').AsString := strEspDoc;
    ParamByName('EMPFAT').AsString := strCodEmp;

    Open;

    Result := 0;

    While Not Eof Do
    Begin
      strGerNumDoc := fStrZero(FieldByName('GER_NUMDOC').AsString, 12);

      pFaturaNotasConfirmadas(strGerNumDoc,
                              FieldByName('GER_SERIE_').AsString,
                              strForNE,
                              RightStr(strNumDoc, fTamDocCadRec),
                              strEspDoc);

      qryCadPag.Close;

      qryCadPag.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryCadPag.ParamByName('SERIE_').AsString := FieldByName('GER_SERIE_').AsString;
      qryCadPag.ParamByName('NUMDUP').AsString := strGerNumDoc;
      qryCadPag.ParamByName('CODFOR').AsString := strForNE;

      qryCadPag.Open;

      If Not qryCadPag.IsEmpty Then
        Result := Result + qryCadPag.FieldByName('VALDUP').AsFloat;

      pSalvaDuplicatasConfirmadas(fRetAutoincMovGer(strGerNumDoc, strForNE, FieldByName('GER_SERIE_').AsString),
                                  strGerNumDoc,
                                  strForNE,
                                  FieldByName('GER_SERIE_').AsString);

      If Not fCancelaContasPagar(strGerNumDoc, strForNE, FieldByName('GER_SERIE_').AsString) Then
        Raise Exception.Create('Erro ao excluir duplicatas!');

      Next;
    End;
  End;

  FreeAndNil(qryCadPag);
  FreeAndNil(qryMovGer);
End;


Function TfrmRecTransfEstoque.fRetTotalDuplicatas(strNumDoc, strEspDoc, strCodEmp, strCodFor: String): Double;
  Var
    qryCadPag: TUniQuery;
    qryMovGer: TUniQuery;
    strGerNumDoc: String;
Begin
  qryCadPag          := fCriaQuery;
  qryCadPag.SQL.Text := fSQLSomaDuplicatas(False);

  qryMovGer := fCriaQuery;

  With qryMovGer Do
  Begin
    SQL.Text := fSQLNotasConfirmadas;

    ParamByName('NUMFAT').AsString := RightStr(strNumDoc, fTamDocCadRec);
    ParamByName('TIPFAT').AsString := strEspDoc;
    ParamByName('EMPFAT').AsString := strCodEmp;

    Open;

    Result := 0;

    While Not Eof Do
    Begin
      strGerNumDoc := fStrZero(FieldByName('GER_NUMDOC').AsString, 12);

      qryCadPag.Close;

      qryCadPag.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryCadPag.ParamByName('SERIE_').AsString := FieldByName('GER_SERIE_').AsString;
      qryCadPag.ParamByName('NUMDUP').AsString := strGerNumDoc;
      qryCadPag.ParamByName('CODFOR').AsString := strForNE;

      qryCadPag.Open;

      If Not qryCadPag.IsEmpty Then
        Result := Result + qryCadPag.FieldByName('VALDUP').AsFloat;


      Next;
    End;
  End;

  FreeAndNil(qryCadPag);
  FreeAndNil(qryMovGer);
End;

function TfrmRecTransfEstoque.fCalculaValDup(AVrNF, ATotDupTE, ADupAberta: Double): Double;
var
  nDif: Double;
begin
  nDif := 0;

  if (ATotDupTE > 0) and (AVrNF > ATotDupTE) then
  begin
    nDif := AVrNF - ATotDupTE;
  end;

  Result := nDif + ADupAberta;
End;

Function TfrmRecTransfEstoque.fGravaFinanceiroEsp: Boolean;
  Var
    fltTotalAberto: Double;
    intContador : Integer;
    strHistorico: String;
    strSeqLan   : String;
Begin
  Result := True;

  If (fCfgSis('ENTCTP', varBoolean)) And
     (Pos(strClaFis, VS_strClaCom) > 0)  And
     (fFornecedorGravaCtp(strCodFor))    Then
  Begin
    If (fCfgSis('ECATEF') = '2') And (cdsConsulta.FieldByName('GER_ESPDOC').AsString = 'NF') Then
      fltTotalAberto := fCalculaValDup(cdsConsulta.FieldByName('GER_VLRCON').AsFloat,
                                       fRetTotalDuplicatas(strNumDoc, strEspDoc, cdsConsulta.FieldByName('GER_CODEMP').AsString, strCodFor),
                                       fRetTotalDuplicatasAbertas(strNumDoc, strEspDoc, cdsConsulta.FieldByName('GER_CODEMP').AsString, strCodFor))
    Else
      fltTotalAberto := fRetTotalDuplicatasAbertas(strNumDoc, strEspDoc, cdsConsulta.FieldByName('GER_CODEMP').AsString, strCodFor);

    If fltTotalAberto = 0 Then
      Exit;

    If Not fMontaDuplicatas(fltTotalAberto, 0) Then
    Begin
      Result := False;
      Exit;
    End;

    intContador := 0;
    {*****************************************}
    {* INICIA A GRAVAÇÃO DO CONTAS A PAGAR   *}
    {**************************************MV*}
    While (ArrDuplicata[intContador].dtaDtaVen <> '') And
          (intContador < 24)                          And
          (Result)                                    Do
    Begin

      If (fCfgSis('HISCTP', varBoolean)) Then
        strHistorico := 'REF. AO DOCUMENTO No ' + fStrZero(strNumDoc, 12) + strEspDoc
      Else
        strHistorico := '';

      strSeqLan := '';

      If Pos(ArrDuplicata[intContador].strUsaChq, 'S_N_') <= 0 Then
        ArrDuplicata[intContador].strUsaChq := 'N';


      Result := fGravaCadPag('untRecTransfEstoque - fGravaFinanceiroEsp',                   // Nome Form LOGCTP
                             'TRANSFERENCIA DE ESTOQUE',                                    // Descrição LOGCTP
                             strForNE,                                                      // Fornecedor
                             fStrZero(strNumDoc, 12),                                       // Numero da Duplicata
                             ArrDuplicata[intContador].strSequen,                           // Parcela
                             VS_strCodEmp,                                                  // Empresa
                             strCodCta,                                                     // Centro de Custo
                             strSerie,                                                      // Serie do Documento
                             0,                                                             // Sequencial de Baixa
                             VS_Date,                                                       // Data do lançamento
                             StrToDate(ArrDuplicata[intContador].dtaDtaVen),                // Data de Vencimento
                             ArrDuplicata[intContador].curValor,                            // Valor da Duplicata
                             ArrDuplicata[intContador].curValor,                            // Valor Original
                             'N',                                                           // Previsão?
                             'N',                                                           // Veio Boleto
                             'N',                                                           // Deposito
                             strHistorico, //'REF. AO DOCUMENTO No ' + fStrZero(strNumDoc, 12) + strEspDoc, // Histórico 1
                             '',                                                            // Histórico 2
                             '',                                                            // Histórico da Baixa
                             '',                                                            // Portador da Baixa
                             '',                                                            // Centro de Custo da Baixa
                             '',                                                            // Documento da Baixa
                             '',                                                            // Operador da Baixa
                             0,                                                             // Data do Pagamento
                             0,                                                             // Valor Pago
                             0,                                                             // Valor de Juros
                             0,                                                             // Valor Desconto
                             VS_strCodEmp,                                                  // Empresa
                             '',                                                            // Código do Evento
                             ArrDuplicata[intContador].strUsaChq,                           // Usa Cheque
                             '',                                                            // Codigo do Portador
                             fStrZero(strNumDoc, 12),                                       // Nro do Documento da Baixa
                             0.0,
                             0.0,
                             0,
                             False,
                             0,
                             '',
                             0,
                             'N',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             'N',
                             '',
                             '',
                             '',
                             '',
                             '',
                             0,
                             0,
                             0,
                             0,
                             '',
                             0,
                             0,
                             '',
                             '',
                             '',
                             '',
                             '',
                             '0',
                             '',
                             '',
                             '',
                             '',
                             'N',
                             '',
                             '',
                             '',
                             '',
                             0,
                             '',
                             0,
                             '',
                             0,
                             0,
                             0,
                             '',
                             '',
                             strAutIncCadFis,                                                      // AIncCadFis: string = '';
                             '',                                                            // strQrCode: string = '';
                             'N');                                                          // AUsaMca: String = '' -- Req. 462891

      If blnImprCP Then
        pAdicionaImpressaoCP(fStrZero(strNumDoc, 12),
                             ArrDuplicata[intContador].strSequen,
                             strForNE,
                             strSerie, Self.Name);


      Inc(intContador);

    End;
  End;

  pgbGravando.Position := pgbGravando.Position + 1;
  Application.ProcessMessages;
End;

function TfrmRecTransfEstoque.fGravaItensConferencia(objConEnt: TRecConferEntrada; strAutoincrem: string): Boolean;
Var
  qryInsert: TUniQuery;
Begin
  qryInsert := fCriaQuery;

  try
    objConEnt.First;

    while not objConEnt.Eof do
    begin
      qryInsert.Close;
      qryInsert.SQL.Clear;
      qryInsert.SQL.Add('INSERT INTO CONDIG (');
      qryInsert.SQL.Add('AUTOINCREM, DIG_SEQCON,');
      qryInsert.SQL.Add('DIG_CODITE, DIG_QTDITE) VALUES (');
      qryInsert.SQL.Add(':INCREM, (SELECT DOC_SEQCON FROM CONDOC WHERE DOC_SEQGER = :SEQGER), :CODITE, :QTDITE)');
      qryInsert.ParamByName('INCREM').AsString := fRetAutoIncrem('CONDIG', VS_strCodEmp);
      qryInsert.ParamByName('SEQGER').AsString := strAutoincrem;
      qryInsert.ParamByName('CODITE').AsString := objConEnt.FieldByName('CODITE').AsString;
      qryInsert.ParamByName('QTDITE').AsFloat := objConEnt.FieldByName('QTDITE').AsFloat;
      If (FblnCOFTRA) And (cdsConsulta.FieldByName('GER_ESPDOC').AsString <> 'TE') Then
        qryInsert.ParamByName('QTDITE').AsFloat := objConEnt.FieldByName('QTDCON').AsFloat;

      qryInsert.ExecSQL;

      objConEnt.Next;
    end;

    Result := True;
  finally
    begin
      FreeAndNil(qryInsert);
    end;
  end;
end;

Function TfrmRecTransfEstoque.fCarregaConfigEmpresa: Boolean;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;
begin
  Try

    qryGenEmp := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  EMP_IMPCTP, ';
    strSQL := strSQL + '  EMP_CTACTP  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If (Not IsEmpty) Then
      Begin
        blnImprCP := (FieldByName('EMP_IMPCTP').AsString = 'S');
        strCodCta := FieldByName('EMP_CTACTP').AsString;
      End;

      Result := Not fEmptyStr(strCodCta);

      If Not Result Then
        fMensagem('', 'Cadastre o Plano de Contas para o Contas a Pagar no Cadastro de Empresas', ['&Ok']);

      Close;
    End;

  Finally
    FreeAndNil(qryGenEmp);
  End;

end;

Function TfrmRecTransfEstoque.fMontaDuplicatas(fltValor, fltImpostos: Double; blnVlrPreDef: Boolean = False): Boolean;
  Var
    intContador: Integer;
    arrDatas: TDateArray;
    dtaDtaDoc: TDateTime;
Begin
  {********************************************}
  {* LIMPA A MATRIZ USADA NA FUNÇÃO DIGDUPLIC *}
  {*****************************************LA*}
  pZeraDigDuplic(arrDuplicata);

  With cdsConsulta Do
  Begin
    If FindField('GER_DTADOC') <> Nil Then
      dtaDtaDoc := FieldByName('GER_DTADOC').AsDateTime
    Else
      dtaDtaDoc := FieldByName('GER_DTAENT').AsDateTime;

    Result := fDigDuplic(arrDuplicata,
                         FieldByName('GER_CONPAG').AsString,
                         0,
                         fltValor,
                         False,
                         False,
                         False,
                         dtaDtaDoc,
                         False,
                         fltImpostos,
                         'S');
  End;

  If Result Then
  Begin

    intContador := 0;
    {*****************************************}
    {* REFAZ A CONDIÇÃO DE PAGAMENTO         *}
    {**************************************MV*}
    While (ArrDuplicata[intContador].dtaDtaVen <> '') And
          (intContador < 24)                         Do
    Begin

      SetLength(arrDatas, intContador+1);
      arrDatas[intContador] := StrToDate(ArrDuplicata[intContador].dtaDtaVen);
      If blnVlrPreDef Then
         ArrDuplicata[intContador].curValor := cdsConsulta.FieldByName('GER_VPAR' + fPadL(IntToStr(intContador+1), 2, '0')).AsFloat;
      Inc(intContador);

    End;

    strCndPag      := fRetornaCndPag(arrDatas, dtaDtaDoc);
  End;
End;

function TfrmRecTransfEstoque.fMovimentaSubItemEmpCar(qryDados: TDataSet): Boolean;
begin
  Result := False;

  If fCfgSis('BXSBIT') = '1' Then
    Exit;

  If Not fCfgSis('EMPCAR', varBoolean) Then
    Exit;

  If Not Assigned(qryDados.FindField('DET_ORDPRO')) Then
    Exit;

  If fEmptyStr(qryDados.FieldByName('DET_ORDPRO').AsString) Then
    Exit;

  Result := True;
end;

function TfrmRecTransfEstoque.fMovimentaSubItemEmpFul(qryDados: TDataSet): Boolean;
begin

  Result := False;

  If fCfgSis('BXSBIT') = '1' Then
    Exit;

  If Not fItemEstrutura(qryDados.FieldByName('DET_CODITE').AsString) Then
    Exit;

  If Not fTranferenciaAutomaticaFulfillment Then
    Exit;

  Result := True;

end;

procedure TfrmRecTransfEstoque.BaixarPedidoTransferencia(
  input: TInputBaixaPedidoTransf);
var
  qryUpdate : TUniQuery;
begin
  qryUpdate := nil;
  qryUpdate := fCriaQuery(Self);

  try
    qryUpdate.Sql.Add('UPDATE PCMGER SET PCG_BAIXAD = 1');
    qryUpdate.Sql.Add(' WHERE PCG_NUMPED = :NUMPED ');
    qryUpdate.Sql.Add('   AND PCG_CODEMP = :CODEMP ');
    qryUpdate.Sql.Add('   AND PCG_ESPDOC = :ESPDOC ');
    qryUpdate.Sql.Add('   AND PCG_NUMCTN = :NUMCTN ');

    qryUpdate.ParamByName('NUMPED').AsString := input.NumPed;
    qryUpdate.ParamByName('CODEMP').AsString := input.CodEmp;
    qryUpdate.ParamByName('ESPDOC').AsString := input.EspDoc;
    qryUpdate.ParamByName('NUMCTN').AsString := input.NumCtn;
    qryUpdate.ExecSQL;

    qryUpdate.Sql.Clear;
    qryUpdate.Sql.Add('UPDATE PCMDET SET PCD_BAIXAD = 1');
    qryUpdate.Sql.Add(' WHERE PCD_NUMPED = :NUMPED ');
    qryUpdate.Sql.Add('   AND PCD_CODEMP = :CODEMP ');
    qryUpdate.Sql.Add('   AND PCD_ESPDOC = :ESPDOC ');
    qryUpdate.Sql.Add('   AND PCD_NUMCTN = :NUMCTN ');

    qryUpdate.ParamByName('NUMPED').AsString := input.NumPed;
    qryUpdate.ParamByName('CODEMP').AsString := input.CodEmp;
    qryUpdate.ParamByName('ESPDOC').AsString := input.EspDoc;
    qryUpdate.ParamByName('NUMCTN').AsString := input.NumCtn;

    qryUpdate.ExecSQL;

    pLimpaPesquisa;
    fAbreConsulta(True);
  finally
    FreeAndNil(qryUpdate);
  end;

end;

procedure TfrmRecTransfEstoque.BitBtnLocked1Click(Sender: TObject);
  var
    frmQckLiberacaoArmazenamento: TfrmQckLiberacaoArmazenamento;
begin
  inherited;
  strIdeDig := '';
  SetLength(arrEfetivarLotePreco, 0);
  intQtdeItensLotPre := 0;
  stlListaMovGer.Clear;
  blnGerouLotePrecos := False;
	blnEntradaOk := False;

  If (Not cdsConsulta.Active) Or (cdsConsulta.IsEmpty) Then
    Exit;

  If stlListSelecao.Count = 0 Then
  Begin
    If Not objEntradaSimplificada.recAutEntTe.blnAutEnt Then
      fMensagem('', 'Selecione os documentos para a Entrada de Mercadorias!', ['&Ok']);
    Exit;
  End;

  If fCfgSis('CONEFE', varBoolean) And (fConferenciaDepoisDaEntrada) Then
  begin
    if Not fVerificaAcessoSistema('frmEntMercadoriasEfetivaMovFiscal') Then
    Begin
      pMensagemOk('Operador sem direito de acesso para efetivar movimento fiscal!');
      Exit;
    End;
  End;

  If (Not fValidouSituacaoFiscalDoDocumento) Then
    Exit;

  If Not fValidaConfirmacaoTransfEstoque Then
  Begin
    Exit;
  End;

  If Not fCarregaConfig Then
    Exit;

  {if blnUsaRotinaWms And fConferenciaDepoisDaEntrada and (fCfgSis('TPLREC', varString) <> 'N') Then
  Begin
    If not fValidaLotesProdutosWMSComColetor Then
      Exit;
  End;}

  if blnSomenteConferencia then
    blnRealizarConferencia := True
  else
    blnRealizarConferencia := Not fCfgSis('EMSRCS', varBoolean);

  Try

    If (Not objEntradaSimplificada.recAutEntTe.blnAutEnt) And (fCfgSis('CONSIM', varString) <> 'N') And
       (Not fEmptyStr(objConEnt.fRetornaNotasDisplay)) And blnRealizarConferencia Then
    Begin

      blnEntradaOk := fRealizaEntradaConferencia;

    End Else
    Begin

      If (Not objEntradaSimplificada.recAutEntTe.blnAutEnt) And
         (fMensagem('', 'Confirma a Entrada de Mercadorias?', ['&Sim', '&Não']) = 2) Then
      Begin
        Exit;
      End;

      (*
      If (Not recAutEntTe.blnAutEnt) And (fCfgSis('USACON', varBoolean)) and (not fConferenciaDepoisDaEntrada )  Then
      Begin
        For intIndice := 0 To stlListSelecao.Count - 1 Do
          If cdsConsulta.Locate('AUTOINCREM', stlListSelecao[intIndice], []) And
            (Not fEmptyStr(cdsConsulta.FieldByName('PCG_NUMPED').AsString)) Then
          Begin
            If fEmptyStr(cdsConsulta.FieldByName('PCG_DTALIB').AsString)   And
               ((cdsConsulta.FieldByName('PCG_EMPDES').AsString = VS_StrCodEmp) Or
                (cdsConsulta.FieldByName('PCG_CODEMP').AsString = VS_StrCodEmp)) Then
            Begin
              fMensagem('', 'Existem pedidos não conferidos!', ['&O k']);
              ffrmSenha(strSenha, 'Senha por direito de acesso!');
              strCodOpe := fRetCodVendedor(strSenha);
              If (Not fVerificaAcessoSistema('ENTPNL', strCodOpe)) Or fEmptyStr(strCodOpe) Then
              Begin
                fMensagem('', 'Usuario sem permissão de acesso!', ['&O k']);
                Exit;
              End
              Else
                Break;

            End;

          End;

      End;
      *)

      blnEntradaOk := fGravaEntradas;
    End;

  Except
    On E: Exception Do
    Begin
      If fTranferenciaAutomaticaFulfillment Then
        Raise Exception.Create(E.Message)
      Else
        pMensagensErro(E.Message, '[TfrmRecTransfEstoque.BitBtnLocked1Click]');
    End;
  End;

  If (fCfgSis('EMSILA', varBoolean)) and (blnEntradaOk) and (stlListaMovGer.count > 0) Then
  Begin
    pCriarFormularios(TfrmQckLiberacaoArmazenamento, frmQckLiberacaoArmazenamento);
    With frmQckLiberacaoArmazenamento Do
      pImprimir(stlListaMovGer, 'frmEntConferPreNota_LIBARM', '', oriLibEntradaMercadoriaSimplificada);
    FreeAndNil(frmQckLiberacaoArmazenamento);
  End;
end;

Function TfrmRecTransfEstoque.fGravaEntradas: Boolean;
Var
  intIndice: Integer;
  recEfetivarLotePreco: TEfetivarLotePreco;
  frmLotePrecosEfetivacaoCx: TfrmLotePrecosEfetivacaoCx;
  blnTransacaoExterna : Boolean;
Begin
  Result := False;

  if blnSomenteConferencia then
  begin
    Result := fFinalizaConferencia(fConverteIncremConferencia(cdsConsulta.FieldByName('AUTOINCREM').AsString, cdsConsulta.FieldByName('TIPSEN').AsString, cdsConsulta.FieldByName('TABELA').AsString));

    if Result then
      Result := fGravaItensConferencia(objConEnt, fConverteIncremConferencia(cdsConsulta.FieldByName('AUTOINCREM').AsString, cdsConsulta.FieldByName('TIPSEN').AsString, cdsConsulta.FieldByName('TABELA').AsString) );

    pLimpaPesquisa;
    fAbreConsulta(True);

    If (Not objEntradaSimplificada.recAutEntTe.blnAutEnt) Then
    Begin
      stlListSelecao.Clear;
      objLock.pDestravarTodos;
    End;

    Exit;
  end;

  Try

    cdsConsulta.DisableControls;

    Try
    blnGarantia := Copy(cdsConsulta.FieldByName('GER_MEN001').AsString,1,12) = 'GARANTIA(TE)';

    If fTranferenciaAutomaticaFulfillment Then
    Begin
      With cdsConsulta Do
      For intIndice := 0 To stlListSelecao.Count - 1 Do
        If Locate('AUTOINCREM', stlListSelecao[intIndice], []) Then
          Result := fGeraEntrada(intIndice);
    End
    Else
    Begin
      frmGravando := TfrmGravando.Create(Self);
        Try
      frmGravando.fExecutarAcao := fGeraEntradaMercadorias;
      frmGravando.ShowModal;

      Result := frmGravando.blnConfirma;

      If frmGravando.blnConfirma Then
      Begin
        blnTransacaoExterna := frmModulo.GetCurrentConnection.InTransaction;
        If not blnTransacaoExterna then
          fStartTransaction;
        try
          if fCfgSis('EMSRCS', varBoolean) then
          begin
            If Not fEmptyStr(cdsConsulta.FieldByName('PCG_NUMPED').AsString) Then //Proveniente de Confirmacao de T
              Result := fIniciaConferencia(cdsConsulta.FieldByName('AUTOINCREM').AsString);
          end
          else
          begin
            If (Not fEmptyStr(cdsConsulta.FieldByName('PCG_NUMPED').AsString)) Or FblnCOFTRA  Then //Proveniente de Confirmacao de T
            Begin
              For intIndice := 0 To stlListSelecao.Count - 1 Do
              Begin
                If cdsConsulta.Locate('AUTOINCREM', stlListSelecao[intIndice], []) Then
                Begin
                  Result := fIniciaConferencia(cdsConsulta.FieldByName('AUTOINCREM').AsString) And
                            fFinalizaConferencia(cdsConsulta.FieldByName('AUTOINCREM').AsString);

                  If Result Then
                  Begin
                    if intIndice = 0 then
                      If objConEnt.Active Then
                        Result := fGravaItensConferencia(objConEnt, cdsConsulta.FieldByName('AUTOINCREM').AsString)
                          And ((Not FblnCOFTRA) Or (fGravarDigCon));
                  End
                  Else
                    Result := fGravarDigCon;
                End;
              End;
            End;
          end;
          If not blnTransacaoExterna then
          begin
            If result then
              fCommit
            Else
              fRollback;
          end;

        except
          on e: Exception do
          begin
            If not blnTransacaoExterna then
              fRollback;
            raise e;
          end;
        end;

        pLimpaPesquisa;
        fAbreConsulta(True);
        If (Not objEntradaSimplificada.recAutEntTe.blnAutEnt) Then
        Begin
          stlListSelecao.Clear;
          objLock.pDestravarTodos;
          fMensagem('', 'Entrada de Mercadorias gerada com sucesso!', ['&Ok']);
        End;
      End;

        Finally
         If Assigned(frmGravando) Then
           FreeAndNil(frmGravando);
    End;
      End;

    Finally
      cdsConsulta.EnableControls;
    End;

  Except
    On E: Exception Do
    Begin
      If fTranferenciaAutomaticaFulfillment Then
        Raise Exception.Create(E.Message)
      Else If (Not objEntradaSimplificada.recAutEntTe.blnAutEnt) Then
        Raise Exception.Create(E.Message)
      Else
        pGravarErro(True, '[fGravaEntradas] ' + E.Message);
    End;
  End;

  For  recEfetivarLotePreco  in arrEfetivarLotePreco do
  Begin
    If recEfetivarLotePreco.strNumDoc <> '' Then
    Begin
      pCriarFormularios(TfrmLotePrecosEfetivacaoCx, frmLotePrecosEfetivacaoCx);
      Try
        frmLotePrecosEfetivacaoCx.pSetDocumentoDeEntradaLotePreco(recEfetivarLotePreco.strNumDoc,
                                                                  recEfetivarLotePreco.strEspDoc,
                                                                  recEfetivarLotePreco.strSerie,
                                                                  recEfetivarLotePreco.strCodFor,
                                                                  '',
                                                                  0);
        frmLotePrecosEfetivacaoCx.ShowModal;
      Finally
        FreeAndNil(frmLotePrecosEfetivacaoCx);
      End;
    End;
  End;
End;

procedure TfrmRecTransfEstoque.FormPaint(Sender: TObject);
begin
  inherited;
  If blnFecharForm Then
    Close;
end;

function TfrmRecTransfEstoque.fVerificaTransfBaixada(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie: String):Boolean;
Var
  strSQL: String;
  qryGen: TUniQuery;
  intNumReg : Integer;
begin

  Try
    qryGen := fCriaQuery;

    strSQl := '';
    strSQL := strSQl + 'SELECT SQL_NO_CACHE                                                            ';
    strSQL := strSQl + '  SUM(NUMREG) AS REGIST                                                        ';
    strSQL := strSQl + 'FROM                                                                           ';
    strSQL := strSQl + '  (SELECT                                                                      ';
    strSQL := strSQl + '     COUNT(*) AS NUMREG                                                        ';
    strSQL := strSQl + '   FROM                                                                        ';
    strSQL := strSQl + '     MOVGER ';
    If fCfgSis('CPDORI', varBoolean) Then
    Begin
      strSQL := strSQL + ' INNER JOIN PCMGER ON PCG_ORIGND = GER_NUMDOC ';
      strSQL := strSQL + '                  AND PCG_ORIGES = GER_ESPDOC ';
      strSQL := strSQL + '                  AND PCG_ORIGEP = GER_CODEMP ';
      strSQL := strSQL + '                  AND PCG_BAIXAD = 1 ';
      strSQL := strSQL + '                  AND PCG_DTAPED = GER_DTAENT ';
      strSQL := strSQL + '                  AND PCG_EMPDES = ' + QuotedStr(VS_strCodEmp) ;
    end
    Else
    Begin
      strSQL := strSQL + '     INNER JOIN                                                                ';
      strSQL := strSQL + '     ( SELECT                                                                  ';
      strSQL := strSQL + '        PCG_CODFOR,                                                            ';
      strSQL := strSQL + '        PCG_DTAPED AS DATAPEDIDO,                                              ';
      strSQL := strSQL + '        PCG_NUMPED,                                                            ';
      strSQL := strSQL + '        PCG_CODEMP,                                                            ';
      strSQL := strSQL + '        PCG_BAIXAD,                                                            ';
      strSQL := strSQL + '        SUBSTRING(PCG_DOCORI,1,' + IntToStr(fTamDocCadRec) + ') AS ORI_NUMDOC, ';
      strSQL := strSQL + '        SUBSTRING(PCG_DOCORI,' + IntToStr(IfThen(fTamDocCadRec = 6, 7, 13)) + ',2) AS ORI_ESPDOC, ';
      strSQL := strSQL + '        SUBSTRING(PCG_DOCORI,' + IntToStr(IfThen(fTamDocCadRec = 6, 9, 15)) + ',3) AS ORI_CODEMP  ';
      strSQL := strSQL + '       FROM                                                                    ';
      strSQL := strSQL + '        PCMGER                                                                 ';
      strSQL := strSQL + '       WHERE PCG_BAIXAD = 1                                                    ';
      strSQL := strSQL + '         AND IFNULL(PCG_DOCORI, "") <> ""                                      ';
      strSQL := strSQL + '         AND PCG_EMPDES = ' + QuotedStr(VS_strCodEmp) + ') AS TMP              ';
      strSQL := strSQL + '        ON ORI_NUMDOC = GER_NUMDOC AND                                         ';
      strSQL := strSQL + '        ORI_ESPDOC = GER_ESPDOC AND                                            ';
      strSQL := strSQL + '        ORI_CODEMP = GER_CODEMP AND                                            ';
      strSQL := strSQL + '        DATAPEDIDO = GER_DTAENT                                                ';
    End;
    strSQL := strSQl + '   WHERE TRUE                                                                  ';
    strSQL := strSQl + '     AND GER_NUMDOC = :NUMDOC                                                  ';
    strSQL := strSQl + '     AND GER_ESPDOC = :ESPDOC                                                  ';
    strSQL := strSQl + '     AND GER_CODEMP = :CODEMP                                                  ';
    strSQL := strSQl + '     AND GER_CODCLI = :CODCLI                                                  ';
    strSQL := strSQl + '     AND GER_SERIE_ = :SERIE_                                                  ';
    strSQL := strSQl + '   UNION ALL                                                                   ';
    strSQL := strSQl + '   SELECT COUNT(*) AS NUMREG                                                   ';
    strSQL := strSQl + '   FROM                                                                        ';
    strSQL := strSQl + '     NOTGER                                                                    ';
    If fCfgSis('CPDORI', varBoolean) Then
    Begin
      strSQL := strSQL + ' INNER JOIN PCMGER ON PCG_ORIGND = GER_NUMDOC ';
      strSQL := strSQL + '                  AND PCG_ORIGES = GER_ESPDOC ';
      strSQL := strSQL + '                  AND PCG_ORIGEP = GER_CODEMP ';
      strSQL := strSQL + '                  AND PCG_BAIXAD = 1 ';
      strSQL := strSQL + '                  AND PCG_DTAPED = GER_DTAENT ';
    End
    Else
    Begin
      strSQL := strSQL + '     INNER JOIN                                                                ';
      strSQL := strSQL + '     ( SELECT                                                                  ';
      strSQL := strSQL + '        PCG_CODFOR,                                                            ';
      strSQL := strSQL + '        PCG_DTAPED AS DATAPEDIDO,                                              ';
      strSQL := strSQL + '        PCG_NUMPED,                                                            ';
      strSQL := strSQL + '        PCG_CODEMP,                                                            ';
      strSQL := strSQL + '        PCG_BAIXAD,                                                            ';
      strSQL := strSQL + '        SUBSTRING(PCG_DOCORI,1,' + IntToStr(fTamDocCadRec) + ') AS ORI_NUMDOC, ';
      strSQL := strSQL + '        SUBSTRING(PCG_DOCORI,' + IntToStr(IfThen(fTamDocCadRec = 6, 7, 13)) + ',2) AS ORI_ESPDOC, ';
      strSQL := strSQL + '        SUBSTRING(PCG_DOCORI,' + IntToStr(IfThen(fTamDocCadRec = 6, 9, 15)) + ',3) AS ORI_CODEMP  ';
      strSQL := strSQL + '       FROM                                                                    ';
      strSQL := strSQL + '        PCMGER                                                                 ';
      strSQL := strSQL + '       WHERE                                                                   ';
      strSQL := strSQL + '         PCG_BAIXAD = 1 AND IFNULL(PCG_DOCORI, "") <> "") AS TMP               ';
      strSQL := strSQL + '        ON ORI_NUMDOC = GER_NUMDOC AND                                         ';
      strSQL := strSQL + '        ORI_ESPDOC = GER_ESPDOC AND                                            ';
      strSQL := strSQL + '        ORI_CODEMP = GER_CODEMP AND                                            ';
      strSQL := strSQL + '        DATAPEDIDO = GER_DTAENT                                                ';
    End;
    strSQL := strSQl + '   WHERE TRUE                                                                  ';
    strSQL := strSQl + '     AND GER_NUMDOC = :NUMDOC                                                  ';
    strSQL := strSQl + '     AND GER_ESPDOC = :ESPDOC                                                  ';
    strSQL := strSQl + '     AND GER_CODEMP = :CODEMP                                                  ';
    strSQL := strSQl + '     AND GER_CODCLI = :CODCLI                                                  ';
    strSQL := strSQl + '     AND GER_SERIE_ = :SERIE_                                                  ';
    strSQL := strSQl + '  ) AS TAB;                                                                    ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('SERIE_').AsString := strSerie;
      Open;

      intNumReg := FieldByName('REGIST').AsInteger;

      If intNumReg > 0 Then
        Result := True
      Else
        Result := False;

    End;

  Finally
    FreeAndNil(qryGen);
  End;

end;

procedure TfrmRecTransfEstoque.pAddListaQuery;
  Var
    strDocOri : String;
    strSql    : String;
    qryUpdate : TUniQuery;
    strDocume,
    strAcesso : String;
    intRecNo  : Integer;
    intIndex  : Integer;
    strNumFat : String;
    blnAddLis : Boolean;
    inputBaixaPedTransf: TInputBaixaPedidoTransf;
    L_strNumPed,
    L_strCodEmp,
    L_strEspDoc,
    L_strNumCtn: String;

  function fVerificaSeTodosItensDaNotaTemLoteDeGarantia : Boolean;
    Var
      qryPcmDet : TUniQuery;
      objCadLot : TCadLot;
      stlItens  : TStringList;
  Begin
    qryPcmDet := fCriaQuery;
    objCadLot := TCadLot.Create(Nil);
    stlItens  := TStringList.Create;
    Try
      qryPcmDet.SQL.Add(' SELECT PCD_CODITE FROM PCMDET ');
      qryPcmDet.SQL.Add(' WHERE PCD_NUMPED = :NUMPED    ');
      qryPcmDet.SQL.Add('   AND PCD_CODEMP = :CODEMP    ');
      qryPcmDet.SQL.Add('   AND PCD_ESPDOC = :ESPDOC    ');

      qryPcmDet.ParamByName('NUMPED').AsString := cdsConsulta.FieldByName('PCG_NUMPED').AsString;
      qryPcmDet.ParamByName('CODEMP').AsString := cdsConsulta.FieldByName('PCG_CODEMP').AsString;
      qryPcmDet.ParamByName('ESPDOC').AsString := cdsConsulta.FieldByName('PCG_ESPDOC').AsString;

      qryPcmDet.Open;

      While not qryPcmDet.Eof Do
      Begin
        if fUsaRotinaWMS or (objCadLot.fExisteLote(qryPcmDet.FieldByName('PCD_CODITE').AsString, VS_strCodEmp)) Then
        Begin
          if not objCadLot.fExisteLotePrincipalGarantia(qryPcmDet.FieldByName('PCD_CODITE').AsString, VS_strCodEmp) Then
          Begin
            if stlItens.IndexOf('"' + qryPcmDet.FieldByName('PCD_CODITE').AsString + '"') < 0 Then
              stlItens.Add('"' + qryPcmDet.FieldByName('PCD_CODITE').AsString + '"');
          End;
        End;

        qryPcmDet.Next;
      End;

      Result := stlItens.Count = 0;

      if not Result Then
        fMensagem('', 'Os itens abaixo não possuem lote principal de garantia, '+
                      'cadastre o lote de garantia antes de realizar a entrada!' + #13 +
                      fCommaText(stlItens), ['&OK']);

    Finally
      FreeAndNil(qryPcmDet);
      FreeAndNil(objCadLot);
      FreeAndNil(stlItens);
    End;
  End;

  Procedure pDesmarca;
  Begin
    With cdsConsulta Do
    Begin
      objLock.fLock_Unlock('TRANSF_' + FieldByName('GER_NUMDOC').AsString +
                                       FieldByName('GER_ESPDOC').AsString +
                                       FieldByName('GER_CODEMP').AsString +
                                       FieldByName('GER_CODCLI').AsString,
                                       False, False );

      intIndex := stlListSelecao.IndexOf(FieldByName('AUTOINCREM').AsString);
      If intIndex > -1 Then
        stlListSelecao.Delete( intIndex );

      intIndex := stlMarcadosDeConfirmacao.IndexOf(FieldByName('AUTOINCREM').AsString);
      if intIndex > -1 Then
        stlMarcadosDeConfirmacao.Delete( intIndex );
    End;
  End;

  procedure pControlaDocConfirmados;
  Begin
    with cdsConsulta Do
    begin
      if (FieldByName('TABELA').AsString = 'NOTGER') And
         fEmptyStr(cdsConsulta.FieldByName('PCG_NUMPED').AsString)  Then
      Begin
        // Marca Documentos de Confirmação;
        Try
          strNumFat := LeftStr(FieldByName('GER_DOCUME').AsString,fTamDocCadRec) + ' - ' + RightStr(FieldByName('GER_DOCUME').AsString,2);

          intRecNo := recNo;
          DisableControls;

          Filter   := 'GER_NUMFAT = ' + QuotedStr(strNumFat) ;
          Filtered := True;

          First;

          While Not Eof Do
          Begin

            if blnAddLis Then
            Begin
              If (not fInLista) Then
                stlListSelecao.Add(FieldByName('AUTOINCREM').AsString);

              if stlMarcadosDeConfirmacao.IndexOf(FieldByName('AUTOINCREM').AsString) = -1 Then
                stlMarcadosDeConfirmacao.Add(FieldByName('AUTOINCREM').AsString);
            End
            Else
            Begin
              pDesmarca;
            End;

            Next;
          End;

        Finally
          Filter   := '';
          Filtered := False;
          recNo := intRecNo;
          EnableControls;
        End;
      End

      Else If (not blnAddLis) and (stlMarcadosDeConfirmacao.IndexOf(FieldByName('AUTOINCREM').AsString) > -1) Then
      Begin
        // Desmarca todos que foram marcados;

        Try
          strNumFat := FieldByName('GER_NUMFAT').AsString;

          intRecNo := recNo;
          DisableControls;

          Filter   := ' GER_NUMFAT = ' + QuotedStr(strNumFat) + ' OR GER_DOCUME = ' + QuotedStr(strNumFat);
          Filtered := True;

          First;


          While Not Eof Do
          Begin
            pDesmarca;
            Next;
          End;

        Finally
          Filter   := '';
          Filtered := False;
          recNo := intRecNo;
          EnableControls;
        End;


      End;


    End;
  End;

Begin
  Try
    cdsConsulta.DisableControls;
    with cdsConsulta Do
    begin
      If not fInLista Then
      begin
        If FblnCOFTRA Then
          If (stlListSelecao.Count > 0) Then
          begin
            fMensagem('','Não é possível marcar mais de um documento com a configuração "COFTRA" ativa!', ['&Ok']);
            Exit;
          end;
      end;

      If fInLista Then
      Begin

        inherited; // Vai Desmarcar
        blnAddLis := False;
        pControlaDocConfirmados;

        objLock.fLock_Unlock('TRANSF_' + FieldByName('GER_NUMDOC').AsString +
                                         FieldByName('GER_ESPDOC').AsString +
                                         FieldByName('GER_CODEMP').AsString +
                                         FieldByName('GER_CODCLI').AsString,
                                         False, False );

      End

      Else If (fEmptyStr(cdsConsulta.FieldByName('PCG_NUMPED').AsString)) Or //Confirmacoes de TE
              (fVerificaCadastroItens And fProsseguir) Then                  //Transferencias por TE/NF ou confirmacoes de Ajustes
      Begin
        If Not fChecaChaveAcesso Then
          Exit;

        {********************************************}
        {* CONSIDERA A SÉRIE PARA BUSCAR A CHAVE DE *}
        {* ACESSO PARA GERAR A NOTA DE ENTRADA      *}
        {*********************************REQ 141308*}
        strAcesso := fRetChaveAcesso(FieldByName('GER_NUMDOC').AsString,
                                     FieldByName('GER_ESPDOC').AsString,
                                     FieldByName('GER_CODCLI').AsString,
                                     FieldByName('GER_CODEMP').AsString,
                                     FieldByName('GER_SERIE_').AsString);

        // Verifica se não não feito a entrada da transferência manualmente!
        If (Not (fEmptyStr(cdsConsulta.FieldByName('PCG_NUMPED').AsString))) And (not blnSomenteConferencia) Then
        Begin
          strDocOri := fVerificaDocumentoExiste;
          if not fEmptyStr(strDocOri) Then
          Begin
            L_strNumPed := cdsConsulta.FieldByName('PCG_NUMPED').AsString;
            L_strCodEmp := cdsConsulta.FieldByName('PCG_CODEMP').AsString;
            L_strEspDoc := cdsConsulta.FieldByName('PCG_ESPDOC').AsString;
            L_strNumCtn := cdsConsulta.FieldByName('PCG_NUMCTN').AsString;

            if fMensagem('ATENÇÃO!', 'Já existe um documento com esses dados!' + #13 + 'Deseja baixar o pedido de compra?', ['&Sim', '&Não']) = 1 Then
            Begin
              try
                qryUpdate := fCriaQuery(Self);

                strSql := 'UPDATE PCMGER SET PCG_BAIXAD = 1, ' +
                          '                  PCG_DOCORI = :DOCORI, ' +
                          '                  PCG_ORIGND = :ORIGND, ' +
                          '                  PCG_ORIGES = :ORIGES, ' +
                          '                  PCG_ORIGEP = :ORIGEP   ';
                strSql := strSql + ' WHERE PCG_NUMPED = :NUMPED ';
                strSql := strSql + '   AND PCG_CODEMP = :CODEMP ';
                strSql := strSql + '   AND PCG_ESPDOC = :ESPDOC ';
                strSql := strSql + '   AND PCG_NUMCTN = :NUMCTN ';

                With qryUpdate Do
                Begin
                  SQL.Clear;
                  SQL.Add(strSql);

                  ParamByName('DOCORI').AsString := strDocOri;
                  If strDocOri <> '' Then
                  begin
                    ParamByName('ORIGND').AsString :=  Copy(strDocOri, 1 , 12);
                    ParamByName('ORIGES').AsString :=  Copy(strDocOri, 13 , 2);
                    ParamByName('ORIGEP').AsString :=  Copy(strDocOri, 15 , 18);
                  End;
                  ParamByName('NUMPED').AsString := L_strNumPed;
                  ParamByName('CODEMP').AsString := L_strCodEmp;
                  ParamByName('ESPDOC').AsString := L_strEspDoc;
                  ParamByName('NUMCTN').AsString := L_strNumCtn;

                  ExecSQL;

                End;

                strSql := '';
                strSql := 'UPDATE PCMDET SET PCD_BAIXAD = 1, PCD_DOCORI = :DOCORI ';
                strSql := strSql + ' WHERE PCD_NUMPED = :NUMPED ';
                strSql := strSql + '   AND PCD_CODEMP = :CODEMP ';
                strSql := strSql + '   AND PCD_ESPDOC = :ESPDOC ';
                strSql := strSql + '   AND PCD_NUMCTN = :NUMCTN ';

                With qryUpdate Do
                Begin
                  SQL.Clear;
                  SQL.Add(strSql);

                  ParamByName('DOCORI').AsString := strDocOri;
                  ParamByName('NUMPED').AsString := L_strNumPed;
                  ParamByName('CODEMP').AsString := L_strCodEmp;
                  ParamByName('ESPDOC').AsString := L_strEspDoc;
                  ParamByName('NUMCTN').AsString := L_strNumCtn;

                  ExecSQL;

                  pLimpaPesquisa;
                  fAbreConsulta(True);
                End;

              Finally
                FreeAndNil(qryUpdate);
              End;

            End;
            Exit;
          End;
        End;

        If fExisteNotaEntradaChaveNFE(strAcesso, strDocume) Then
        Begin
          if fMensagem('ATENÇÃO!', 'Já existe um documento com a chave da Nota Eletrônica ' +
                     strAcesso + ' no Livro Fiscal: ' + strDocume + #13 + 'Deseja baixar pedido de transferência deste documento?', ['&Sim', '&Não']) = 1 Then
          begin
            inputBaixaPedTransf.docOri := strDocOri;
            inputBaixaPedTransf.NumPed := cdsConsulta.FieldByName('PCG_NUMPED').AsString;
            inputBaixaPedTransf.CodEmp := cdsConsulta.FieldByName('PCG_CODEMP').AsString;
            inputBaixaPedTransf.EspDoc := cdsConsulta.FieldByName('PCG_ESPDOC').AsString;
            inputBaixaPedTransf.NumCtn := cdsConsulta.FieldByName('PCG_NUMCTN').AsString;
            BaixarPedidoTransferencia(inputBaixaPedTransf);

          end;

          If fTranferenciaAutomaticaFulfillment Then
            Abort
          else
            Exit;
        End;

        if not fVerificaConferenciaColetor then
          Exit;

        If fPedidoDeCompraOriundoDeGarantiaFilial(FieldByName('PCG_NUMPED').AsString, FieldByName('PCG_CODEMP').AsString) Then
        Begin
          if not fVerificaSeTodosItensDaNotaTemLoteDeGarantia Then
            Exit;
        End;

        If Not objLock.fLock_Unlock('TRANSF_' + FieldByName('GER_NUMDOC').AsString +
                                                FieldByName('GER_ESPDOC').AsString +
                                                FieldByName('GER_CODEMP').AsString +
                                                FieldByName('GER_CODCLI').AsString,
                                                True, False) Then
        Begin

          fMensagem('', 'O Documento ' + FieldByName('GER_NUMDOC').AsString + '-' +
                                         FieldByName('GER_ESPDOC').AsString + '-' +
                                         FieldByName('GER_CODEMP').AsString + ' está sendo utilizado em Outra Estação por ' +

                  fGetHostLock('TRANSF_' + FieldByName('GER_NUMDOC').AsString +
                                           FieldByName('GER_ESPDOC').AsString +
                                           FieldByName('GER_CODEMP').AsString +
                                           FieldByName('GER_CODCLI').AsString)  + '!', ['&Ok'])
        End

        Else
        Begin
          blnAddLis := True;
          pControlaDocConfirmados;
          inherited;
        End;

      End;
    End;
  Finally
    cdsConsulta.EnableControls;
  End;
End;

function TfrmRecTransfEstoque.fVerificaConferenciaColetor : boolean;
var
  strConCol : String;
  intRecNo  : Integer;
begin
  Result := (fCfgSis('CONSIM', varString) <> 'C') OR (fCfgSis('EMSRCS', varBoolean));

  if not Result then
  begin
    intRecNo := cdsConsulta.recNo;
    Try
      strConCol := cdsConsulta.FieldByName('CONCOL').AsString;

      if strConCol = 'A' then
      begin
        fMensagem('','Não é possível marcar documentos com a conferência em andamento no coletor!', ['&Ok']);
        Exit(False);
      end;

      cdsConsulta.DisableControls;
      cdsConsulta.First;

      While Not cdsConsulta.Eof Do
      Begin
        Result := True;
        If fInLista Then
        begin
          if cdsConsulta.fieldByName('CONCOL').AsString <> strConCol then
          begin
            Result := False;
            break;
          end;
        end;

        cdsConsulta.Next;
      End;

      if not Result then
      begin
        case AnsiIndexStr(strConCol, ['F','N']) of
          0: fMensagem('','Existem documentos marcados conferidos no coletor, não é possível marcar documentos não conferidos!', ['&Ok']);
          1: fMensagem('','Existem documentos marcados não conferidos, não é possível marcar documentos conferidos no coletor!', ['&Ok']);
        end;
      end;

    Finally
      cdsConsulta.recNo := intRecNo;
      cdsConsulta.EnableControls;
    End;
  end;
end;

Function TfrmRecTransfEstoque.fVerificaConfBaixada(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: String): Boolean;
  Var
    qryNotGer: TUniQuery;
Begin
  qryNotGer := fCriaQuery;
  With qryNotGer, SQL Do
  Begin
    Clear;
    Add('SELECT GER_NUMFAT FROM NOTGER');
    Add('WHERE');
    Add('  IFNULL(GER_NUMFAT, "") <> "" AND');
    Add('  GER_NUMDOC = :NUMDOC AND');
    Add('  GER_ESPDOC = :ESPDOC AND');
    Add('  GER_CODEMP = :CODEMP AND');
    Add('  GER_CODCLI = :CODCLI    ');

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODCLI').AsString := strCodCli;
    ParamByName('CODEMP').AsString := strCodEmp;

    Open;

    Result := Not IsEmpty;

    Close;
  End;
  FreeAndNil(qryNotGer);
End;

function TfrmRecTransfEstoque.fVerificaDocumentoExiste: String;
  Var
    strSQL   : String;
    strEspDoc: String;
    qryGenGer: TUniQuery;
begin
  Result := '';
  qryGenGer := Nil;
  Try
    qryGenGer := fCriaQuery(Application);

    // Removida a atribuição de string vazia desnecessária
    strSQL := ' SELECT CONCAT(COALESCE(GER_NUMDOC, ''''), ' +
              '               COALESCE(GER_ESPDOC, ''''), ' +
              '               COALESCE(GER_CODEMP, '''')) AS NUMDOC ' +
              ' FROM MOVGER ' +
              ' WHERE GER_NUMDOC = :NUMDOC ' +
              '   AND GER_ESPDOC = :ESPDOC ' +
              '   AND GER_CODEMP = :CODEMP ' +
              '   AND GER_CODFOR = :CODFOR ' +
              '   AND COALESCE(GER_SERIE_, '''') = :SERIE_ ';

    qryGenGer.Close;
    qryGenGer.SQL.Clear;
    qryGenGer.SQL.Add(strSQL);

    If SameText(cdsConsulta.FieldByName('TABELA').AsString, 'NOTGER') Then
      strEspDoc := cdsConsulta.FieldByName('GER_ESPDOC').AsString
    Else
      strEspDoc := IIF(SameText(cdsConsulta.FieldByName('TIPSEN').AsString, 'SENHA1'), 'NF', 'PD');

    qryGenGer.ParamByName('NUMDOC').AsString := cdsConsulta.FieldByName('GER_NUMDOC').AsString;
    qryGenGer.ParamByName('ESPDOC').AsString := strEspDoc;
    qryGenGer.ParamByName('SERIE_').AsString := cdsConsulta.FieldByName('GER_SERIE_').AsString;
    qryGenGer.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGenGer.ParamByName('CODFOR').AsString := cdsConsulta.FieldByName('PCG_CODFOR').AsString;
    qryGenGer.Open;

    If Not qryGenGer.IsEmpty Then
      Result := qryGenGer.FieldByName('NUMDOC').AsString;

    qryGenGer.Close;

  Finally
    FreeAndNil(qryGenGer);
  End;
end;

Procedure TfrmRecTransfEstoque.pAbreItensNota(qryIteNot: TUniQuery; blnTesCad: Boolean = False);
  Var
    strNomTab: String;
Begin

  With qryIteNot, SQL Do
  Begin
    Clear;
    Add('SELECT');
    Add('  DET_CODITE,');

    If (Pos(cdsConsulta.FieldByName('TABELA').AsString, 'MOVGER') > 0) Then
      Add(' IF(DET_LOTABA <> "", DET_LOTABA, DET_NUMLOT) AS DET_NUMLOT, ')
    Else
      Add(' DET_NUMLOT, ');

    Add('  DET_DESCRI,');
    Add('  SUM(DET_QTDITE) AS DET_QTDITE');
    Add('FROM');

    If SameText(cdsConsulta.FieldByName('TABELA').AsString, 'MOVGER') Then
    Begin
      Add('MOVDET');
      strNomTab := 'MOVDET';
    End
    Else
    Begin
      Add('NOTDET');
      strNomTab := 'NOTDET';
    End;

    If (Pos(cdsConsulta.FieldByName('TABELA').AsString, 'MOVGER') > 0) Then
      Add('LEFT JOIN ' + fRetNomTabMovTri(strNomTab) + ' T ON T.DET_SEQGER = ' + strNomTab + '.AUTOINCREM');

    If blnTesCad Then
    Begin
      Add('LEFT JOIN CADITE C ON C.ITE_CODITE = DET_CODITE');
      Add('LEFT JOIN ITEGER I ON I.ITE_CODITE = DET_CODITE AND I.ITE_CODEMP ');
    End;

    Add('WHERE ' + strNomTab + '.DET_SEQGER = :AUTINC AND ');

    If blnTesCad Then
      Add('  ((I.ITE_CODITE IS NULL) OR (C.ITE_CODITE IS NULL)) AND ');
(*
    Add('  DET_CODEMP = :CODEMP AND ');
    Add('  DET_NUMDOC = :NUMDOC AND ');
    Add('  DET_ESPDOC = :ESPDOC AND ');
    Add('  IFNULL(DET_SERIE_, "") = :SERIE_ AND ');
    Add('  DET_CODCLI = :CODCLI AND '); *)
    Add('  DET_PROEMB = "N" ');

    Add('GROUP BY');
    Add('  DET_CODITE,');

    If (Pos(cdsConsulta.FieldByName('TABELA').AsString, 'MOVGER') > 0) Then
      Add(' IF(DET_LOTABA <> "", DET_LOTABA, DET_NUMLOT) ')
    Else
      Add(' DET_NUMLOT ');

    Close;
    ParamByName('AUTINC').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
(*    ParamByName('CODEMP').AsString := cdsConsulta.FieldByName('GER_CODEMP').AsString;
    ParamByName('NUMDOC').AsString := cdsConsulta.FieldByName('GER_NUMDOC').AsString;
    ParamByName('ESPDOC').AsString := cdsConsulta.FieldByName('GER_ESPDOC').AsString;
    ParamByName('CODCLI').AsString := cdsConsulta.FieldByName('GER_CODCLI').AsString;
    ParamByName('SERIE_').AsString := cdsConsulta.FieldByName('GER_SERIE_').AsString;*)
    Open;
  End;

End;

Function TfrmRecTransfEstoque.fProsseguir: Boolean;
  Var
    qryIteNot: TUniQuery;

  Procedure pAbreItensPedidos;
  Begin
    With qryPedido, SQL Do
    Begin
      Clear;
      Add('SELECT');
      Add('  PCD_CODITE AS CODITE,');
      Add('  PCD_NUMLOT AS NUMLOT,');
      Add('  PCD_DESITE AS DESITE,');

      If fCfgSis('CNVEMB') <> 'N' Then
        Add('  SUM((PCD_QTDITE - IFNULL(PCD_QTDBAI, 0)) * IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA)) AS QTDABE,')
      Else
        Add('  SUM(PCD_QTDITE - IFNULL(PCD_QTDBAI, 0)) AS QTDABE,');

      Add('  0.0000 AS QTDNOT ');
      Add('FROM');
      Add('  PCMDET');

      Add('WHERE');
      Add('  PCD_ESPDOC = "PD"    AND ');
      Add('  PCD_NUMCTN = 0       AND ');
      Add('  PCD_CODEMP = :CODEMP AND ');
      Add('  PCD_NUMPED = :NUMPED     ');
      Add('GROUP BY');
      Add('  PCD_CODITE,');
      Add('  PCD_NUMLOT ');

      Close;
      ParamByName('CODEMP').AsString := cdsConsulta.FieldByName('PCG_CODEMP').AsString;
      ParamByName('NUMPED').AsString := cdsConsulta.FieldByName('PCG_NUMPED').AsString;

      qryPedido.Open;
      pSetaClient(qryPedido);

      cdsPedido.Close;
      cdsPedido.Filter   := '';
      cdsPedido.Filtered := False;
      cdsPedido.Open;

      pSetaClient(cdsPedido);

      TFloatField(cdsPedido.FieldByName('QTDABE')).DisplayFormat := '#,##0.00';
      TFloatField(cdsPedido.FieldByName('QTDNOT')).DisplayFormat := '#,##0.00';

    End;
  End;

  Procedure pComparaItens;
  Begin
    With qryIteNot Do
    Begin
      First;

      While Not Eof Do
      Begin
        If cdsPedido.Locate('CODITE;NUMLOT',
             VarArrayOf([FieldByName('DET_CODITE').AsString,
                         FieldByName('DET_NUMLOT').AsString]), []) Then
        Begin
          cdsPedido.Edit;
          cdsPedido.FieldByName('QTDNOT').AsFloat := FieldByName('DET_QTDITE').AsFloat;
          cdsPedido.Post;
        End Else
        Begin
          cdsPedido.Insert;
          cdsPedido.FieldByName('CODITE').AsString := FieldByName('DET_CODITE').AsString;
          cdsPedido.FieldByName('NUMLOT').AsString := FieldByName('DET_NUMLOT').AsString;
          cdsPedido.FieldByName('DESITE').AsString := FieldByName('DET_DESCRI').AsString;
          cdsPedido.FieldByName('QTDABE').AsFloat  := 0;
          cdsPedido.FieldByName('QTDNOT').AsFloat  := FieldByName('DET_QTDITE').AsFloat;
          cdsPedido.Post;
        End;

        Next;
      End;
    End;
  End;

Begin
  Result := True;

  if blnSomenteConferencia then
    Exit;

  qryIteNot := fCriaQuery;

  pAbreItensPedidos;
  pAbreItensNota(qryIteNot);
  pComparaItens;

  With cdsPedido Do
  Begin
    Filter   := 'QTDABE <> QTDNOT';
    Filtered := True;

    If Not IsEmpty Then
    Begin
      pCriarFormularios(TfrmRecTransfDivergencias, frmRecTransfDivergencias);

      frmRecTransfDivergencias.Caption := 'Divergências entre o Pedido ' +
        cdsConsulta.FieldByName('PCG_NUMPED').AsString + '-' +
        cdsConsulta.FieldByName('PCG_CODEMP').AsString + ' e a Nota ' +
          cdsConsulta.FieldByName('GER_NUMDOC').AsString + '-' +
          cdsConsulta.FieldByName('GER_ESPDOC').AsString;

      frmRecTransfDivergencias.mmoInform.Lines.Add('  Há divergência de itens entre a nota e o pedido.');
      frmRecTransfDivergencias.mmoInform.Lines.Add('  Caso confirme a seleção da Nota a entrada será feita a partir da Nota e');
      frmRecTransfDivergencias.mmoInform.Lines.Add('  o pedido será baixado integralmente.');

      frmRecTransfDivergencias.dtsItens.DataSet := cdsPedido;
      Result := frmRecTransfDivergencias.ShowModal = mrOk;
      FreeAndNil(frmRecTransfDivergencias);
    End;

    qryPedido.Close;
    Close;
  End;

  FreeAndNil(qryIteNot);
End;

procedure TfrmRecTransfEstoque.pValidarLotesADefinir;
  Var
    strCodIte: String;
begin
  strCodIte := '';

  qryMovDet.First;

  While Not qryMovDet.Eof Do
  Begin
    If Not objCadLot.fExisteLote(qryMovDet.FieldByName('DET_CODITE').AsString,
                                 strCodEmp, 'A DEFINIR', False) Then
    Begin
      If Pos(qryMovDet.FieldByName('DET_CODITE').AsString, strCodIte) <= 0 Then
      Begin
        If Not fEmptyStr(strCodIte) Then
          strCodIte := strCodIte + ', ';
        strCodIte := strCodIte + qryMovDet.FieldByName('DET_CODITE').AsString;
      End;
    End;
    qryMovDet.Next;
  End;

  qryMovDet.First;

  If Not fEmptyStr(strCodIte) Then
    Raise ExceptionLotesADefinir.Create('Existem produtos que não possuem o lote "A DEFINIR". ' +
      'Não será possível realizar a entrada de mercadorias: ' + strCodIte);
end;

function TfrmRecTransfEstoque.fValorContabil_Igual_ValorParcelas: Boolean;
begin
  Result := RoundTo(cdsConsulta.FieldByName('GER_VLRCON').AsFloat, -2) =
            RoundTo(cdsConsulta.FieldByName('GER_VPAR01').AsFloat +
                  cdsConsulta.FieldByName('GER_VPAR02').AsFloat +
                  cdsConsulta.FieldByName('GER_VPAR03').AsFloat +
                  cdsConsulta.FieldByName('GER_VPAR04').AsFloat +
                  cdsConsulta.FieldByName('GER_VPAR05').AsFloat +
                  cdsConsulta.FieldByName('GER_VPAR06').AsFloat +
                  cdsConsulta.FieldByName('GER_VPAR07').AsFloat +
                  cdsConsulta.FieldByName('GER_VPAR08').AsFloat +
                  cdsConsulta.FieldByName('GER_VPAR09').AsFloat +
                  cdsConsulta.FieldByName('GER_VPAR10').AsFloat +
                  cdsConsulta.FieldByName('GER_VPAR11').AsFloat +
                  cdsConsulta.FieldByName('GER_VPAR12').AsFloat, -2)
end;

Function TfrmRecTransfEstoque.fVerificaCadastroItens: Boolean;
  Var
    qryIteNot: TUniQuery;
Begin
  qryIteNot := fCriaQuery;
  With qryIteNot Do
  Begin
    pAbreItensNota(qryIteNot, True);

    Result := IsEmpty;

    If Not Result Then
    Begin
      pCriarFormularios(TfrmRecTransfDivergencias, frmRecTransfDivergencias);
      frmRecTransfDivergencias.Caption := 'Itens da Nota não encontrados no cadastro. Verifique!!';
      frmRecTransfDivergencias.mmoInform.Lines.Add('Itens da Nota não encontrados no cadastro. Verifique!');

      frmRecTransfDivergencias.dtsItens.DataSet     := qryIteNot;
      frmRecTransfDivergencias.btnConfirma.Visible  := False;
      frmRecTransfDivergencias.btnSair.Caption      := '&Sair';

      frmRecTransfDivergencias.cxgColCodIte.DataBinding.FieldName := 'DET_CODITE';
      frmRecTransfDivergencias.cxgColDesIte.DataBinding.FieldName := 'DET_DESCRI';

      frmRecTransfDivergencias.cxgColQtdAbe.Visible := False;
      frmRecTransfDivergencias.cxgColQtdNot.Visible := False;

      frmRecTransfDivergencias.ShowModal;
      FreeAndNil(frmRecTransfDivergencias);
    End;

  End;
  FreeAndNil(qryIteNot);
End;

Function TfrmRecTransfEstoque.fRealizaEntradaConferencia: Boolean;
  function fVerificaNotasConferidasColetor : boolean;
  begin
    Result := fCfgSis('CONSIM', varString) = 'C';
    if Result then
    begin
      try
        Result := (blnTemSelecao Or (stlListSelecao.Count > 0));
        If Result Then
        begin
          cdsConsulta.First;
          while not cdsConsulta.eof do
          begin
            if fInLista then
            begin
              if cdsConsulta.FieldByName('CONCOL').AsString <> 'F' then
                exit(False);
            end;
            cdsConsulta.Next;
          end;
        end;

      except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, '[TfrmRecTransfEstoque.fRealizaEntradaConferencia]');
        End;
      end;
    end;

  end;
Begin
  Try
    Result := True;

    If Not fEmptyStr(objConEnt.strNotas) Then
    Begin


        If objConEnt.fSelecionaNotas Then
        Begin
          Result := fVerificaNotasConferidasColetor;
          if Result then
          begin
            Result := objConEnt.fFinalizaEntrada;
          end
          else begin
            pCriarFormularios(TfrmRecTransfEstoqueConfer, frmRecTransfEstoqueConfer);

            frmRecTransfEstoqueConfer.cxgItensView.DataController.DataSource := objConEnt.dtsSource;
            frmRecTransfEstoqueConfer.objConEnt     := objConEnt;
            frmRecTransfEstoqueConfer.mmoNotas.Text := objConEnt.strNotas;
            frmRecTransfEstoqueConfer.blnExiApl     := blnExiApl;
            Result := frmRecTransfEstoqueConfer.ShowModal = mrOk;

            pFreeAndNil(frmRecTransfEstoqueConfer);
          end;
        End
        Else Result := False;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmRecTransfEstoque.fRealizaEntradaConferencia]');
    End;
  End;
End;

function TfrmRecTransfEstoque.fValidaConfirmacaoTransfEstoque: Boolean;
var
  I: Integer;
  strDocs,
  strAutInc: String;
begin
  If fCfgSis('ENTSCN', varBoolean) Then
  Begin
    Result := True;
    Exit;
  End;

  For I := 0 To stlListSelecao.Count - 1 Do
  Begin
    strAutInc := stlListSelecao[I];
    If (cdsConsulta.Locate('AUTOINCREM', strAutInc, [])) And (Pos('TE', cdsConsulta.FieldByName('GER_DOCUME').AsString) > 0) Then
    Begin

      If cdsConsulta.FieldByName('GER_NUMFAT').AsString = ' - ' Then
        strDocs := strDocs + cdsConsulta.FieldByName('GER_DOCUME').AsString + ', ';
    End;
  End;

  If Not fEmptyStr(strDocs) Then
    fMensagem('', 'Entrada de mercadorias do(s) doc(s) '+ strDocs +' não pode ser realizada pois ainda não foi feita a confirmação da transferência ( não foi gerado o documento fiscal )', ['&Ok']);

  Result := fEmptyStr(strDocs);
end;

{Function TfrmRecTransfEstoque.fValidaLotesProdutosWMSComColetor : Boolean;
  Var
    qryItens : TUniQuery;
    intIndice: Integer;
    strAutInc: String;
    strSQL   : String;
    strAuxMsg: String;
Begin
  qryItens := fCriaQuery();
  strSQL   := '';
  Try
    For intIndice := 0 To stlListSelecao.Count - 1 Do
    Begin
      strAutInc := stlListSelecao[intIndice];
      If cdsConsulta.Locate('AUTOINCREM', strAutInc, []) Then
      Begin
        if not fEmptyStr(strSQL) Then
          strSQL := strSQL + ' UNION ALL ';

        strSQL := strSQL + ' SELECT DET_CODITE, DET_NUMLOT ';
        strSQL := strSQL + ' FROM ' + IfThen( cdsConsulta.FieldByName('TABELA').AsString = 'MOVGER', 'MOVDET', 'NOTDET' );
        strSQL := strSQL + '   INNER JOIN CADITE ON ITE_CODITE = DET_CODITE ';
        strSQL := strSQL + ' WHERE DET_SEQGER = ' + QuotedStr(strAutInc);
        strSQL := strSQL + '   AND ITE_RASTRE = "S" ';
      End;

    End;

    strSql := ' SELECT DET_CODITE, GROUP_CONCAT(DISTINCT DET_NUMLOT SEPARATOR "|$$$###|") AS LOTES FROM ( ' + strSQL + ') AS TMP ';
    strSql := strSQL + ' GROUP BY DET_CODITE ';
    strSql := strSQL + ' HAVING LOTES LIKE "%|$$$###|%" ';

    qryItens.Sql.Text := strSQL;
    qryItens.Open;

    Result := qryItens.IsEmpty;

    if not Result Then
    Begin
      While Not qryItens.Eof Do
      Begin
        if not fEmptyStr(strAuxMsg) Then
          strAuxMsg := strAuxMsg + #13;

        strAuxMsg := strAuxMsg + qryItens.FieldByName('DET_CODITE').AsString + ' Lotes: ' + ReplaceStr( qryItens.FieldByName('LOTES').AsString, '|$$$###|', ', ');

        qryItens.Next;
      End;

      fMensagem('','Não é possível receber mais de uma transferência do mesmo produto com mais de um lote definido!' + #13 +
                   'Verifique os produtos abaixo ou faça a entrada individualmente:' + #13 + strAuxMsg, ['&OK']);
    End;

  Finally
    FreeAndNil(qryItens);
  End;

End;}

function TfrmRecTransfEstoque.fLocalizaDadLivFull(strCfo: string; strAlq: Double): Integer;
var intContador: Integer;
begin
  Result := 1;
  For intContador := Low(ArrDadLivFull) To High(ArrDadLivFull) Do
  begin
    If (ArrDadLivFull[intContador].strClaFis = strCfo) And
       (ArrDadLivFull[intContador].fltAliquota = strAlq) Then
    Begin
       Result := intContador;
       Exit;
    End;

  End;

end;


function TfrmRecTransfEstoque.fRetSQMovDet: String;
var strTabela: String;
begin
  If strArqMovGer = 'NOTGER' then
    strTabela := 'NOTDET'
  Else
    strTabela := 'MOVDET';
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  DET_CLAFIS AS CLAFIS, ';
  Result := Result + '  DET_ALQICM AS ALQICM, ';
  Result := Result + '  SUM(IFNULL(DET_TOTITE, 0)+IFNULL(DET_VALIPI, 0)+IFNULL(DET_TOTFRE, 0)+IFNULL(DET_DESACE, 0)+IFNULL(DET_VALRET, 0)-';
  Result := Result + '  IFNULL(DET_DESESP, 0)+IFNULL(TRI.DET_VAEIPI,0)+IFNULL(TRI.DET_VAERET,0) + IFNULL(TRI.DET_VFCPST, 0) + ';

  If  strTabela = 'NOTDET' Then
  Begin
    Result := Result + '  IF(IFNULL(IMP_SEQDET, "") = "", 0, IFNULL(DET_VALICM, 0) + IFNULL(IMP_PISPAS, 0) + IFNULL(IMP_COFINS, 0) + ';
    Result := Result + '  IFNULL(IMP_VALIOF, 0) + IFNULL(IMP_DESADU, 0) + IFNULL(IMP_VAL_II, 0) + IFNULL(IMP_SISCOM, 0) + IFNULL(IMP_VAFRMM,0)) + ';
  End
  Else
  Begin
    Result := Result + '  IF(IFNULL(IMP_SQMVDT, "") = "", 0, IFNULL(DET_VALICM, 0) + IFNULL(IMP_PISPAS, 0) + IFNULL(IMP_COFINS, 0) + ';
    Result := Result + '  IFNULL(IMP_VALIOF, 0) + IFNULL(IMP_DESADU, 0) + IFNULL(IMP_VAL_II, 0) + IFNULL(IMP_VAFRMM,0)) + ';
  End;

  Result := Result + ' 0 ) AS VLRCON, ';


  Result := Result + '  SUM(DET_TOTITE) AS TOTPRO, ';
  Result := Result + '  SUM(DET_BASICM) AS BASICM, ';
  Result := Result + '  SUM(DET_VALICM) AS VALICM, ';
  Result := Result + '  SUM(DET_BASRET) AS BASRET, ';
  Result := Result + '  SUM(DET_VALRET) AS VALRET, ';
  Result := Result + '  SUM(IFNULL(TRI.DET_BAERET,0)) AS BAERET, ';
  Result := Result + '  SUM(IFNULL(TRI.DET_VAERET,0)) AS VAERET, ';
  Result := Result + '  SUM(IFNULL(DET_BASANT,0)) AS BASANT, ';
  Result := Result + '  SUM(IFNULL(DET_ICMANT,0)) AS VALANT, ';
  Result := Result + '  SUM(DET_DESACE) AS DESACE, ';
  Result := Result + '  SUM(DET_BASIPI) AS BASIPI, ';
  Result := Result + '  SUM(DET_VALIPI) AS VALIPI, ';
  Result := Result + '  SUM(IFNULL(TRI.DET_BAEIPI,0)) AS BAEIPI, ';
  Result := Result + '  SUM(IFNULL(TRI.DET_VAEIPI,0)) AS VAEIPI, ';
  Result := Result + '  SUM(DET_TOTFRE) AS TOTFRE, ';
  Result := Result + '  SUM(DET_DESESP) AS DESESP, ';

  Result := Result + '  MAX(IFNULL(TRI.DET_ALQPIS, 0)) AS ALQPIS, ';
  Result := Result + '  MAX(IFNULL(TRI.DET_ALQCOF, 0)) AS ALQCOF, ';

  Result := Result + '  SUM(IFNULL(TRI.DET_OUTICM, 0)) AS OUTICM, ';
  Result := Result + '  SUM(IFNULL(TRI.DET_ISEICM, 0)) AS ISEICM, ';

  Result := Result + '  SUM(IFNULL(TRI.DET_BASPIS, 0)) AS BASPIS, ';
  Result := Result + '  SUM(IFNULL(TRI.DET_VALPIS, 0)) AS VALPIS, ';
  Result := Result + '  SUM(IFNULL(TRI.DET_BASCOF, 0)) AS BASCOF, ';
  Result := Result + '  SUM(IFNULL(TRI.DET_VALCOF, 0)) AS VALCOF, ';
  Result := Result + '  MAX(IFNULL(DET_ALQICM,0)) AS ALQICM, ';
  Result := Result + '  MAX(IFNULL(DET_ALQIPI,0)) AS ALQIPI, ';
  Result := Result + '  SUM(IFNULL(DET_VICMDE,0)) AS VICMDE, ';
  Result := Result + '  SUM(IFNULL(TRI.DET_VFCPST, 0)) AS VFCPST, ';
  Result := Result + '  SUM(IFNULL(TRI.DET_BFCPST, 0)) AS BFCPST, ';
  Result := Result + '  SUM(IF(TRI.DET_BFCPST = ICD.ICD_BASFCP, 0, IFNULL(ICD.ICD_BASFCP, 0.00))) AS BASFCP, ';
  Result := Result + '  SUM(IF(TRI.DET_BFCPST = ICD.ICD_BASFCP, 0, IFNULL(ICD.ICD_VALFCP, 0.00))) AS VALFCP, ';
  Result := Result + '  SUM(IF(IFNULL(REF.REF_CBSVAL,0) = 0, 0, IFNULL(REF.REF_BASCAL,0))) AS BASCBS, ';
  Result := Result + '  SUM(IFNULL(REF.REF_CBSVAL,0)) AS VLRCBS, ';
  Result := Result + '  SUM(IF(IFNULL(REF.REF_VALIBS,0) = 0, 0, IFNULL(REF.REF_BASCAL,0))) AS BASIBS, ';
  Result := Result + '  SUM(IFNULL(REF.REF_VALIBS,0)) AS VLRIBS, ';
  Result := Result + '  SUM(IF(IFNULL(REF.REF_SELVAL,0) = 0, 0, IFNULL(REF.REF_BASCAL,0))) AS BAS_IS, ';
  Result := Result + '  SUM(IFNULL(REF.REF_SELVAL,0)) AS VLR_IS ';

  Result := Result + 'FROM  ';
  Result := Result +    strTabela + ' ';
  Result := Result + '  LEFT JOIN ' + fTabTri(strTabela) +  ' AS TRI ON ';
  Result := Result + '    TRI.DET_SEQGER = ' + strTabela + '.AUTOINCREM ';
  If  strTabela = 'NOTDET' Then
  Begin
    Result := Result + '  LEFT JOIN DOCIMP ON IMP_SEQDET = ' + strTabela + '.AUTOINCREM ';
    Result := Result + '  LEFT JOIN NOTICD AS ICD ON ICD_SEQGER = ' + strTabela + '.AUTOINCREM ';
  End
  Else
  Begin
    Result := Result + '  LEFT JOIN DOCIMP ON IMP_SQMVDT = MOVDET.AUTOINCREM ';
    Result := Result + '  LEFT JOIN MOVICD AS ICD ON ICD_SEQGER = ' + strTabela + '.AUTOINCREM ';
  End;
  Result := Result + '  LEFT JOIN ' + fTabRef(strTabela) + ' AS REF ON REF.REF_SEQGER = ' + strTabela + '.AUTOINCREM ';
  Result := Result + 'WHERE ' + strTabela + '.DET_SEQGER = "'+strAutInc+'"';

  Result := Result + 'GROUP BY ';
  Result := Result + '  DET_CLAFIS, ';
  Result := Result + '  DET_ALQICM  ';
End;



function TfrmRecTransfEstoque.fTabTri(strTabela: String): String;
begin
  Result := IIF(strTabela = 'MOVDET', 'MOVTRI', 'NOTTRI');
end;

function TfrmRecTransfEstoque.fEfetivaMvtoFiscal: Boolean;
Var
  lNotaEletInfConf: TNotaEletInfConf;
begin
  Result := True;
  If fCfgSis('CONEFE', varBoolean) And (fConferenciaDepoisDaEntrada) Then
  Begin
    Try
      lNotaEletInfConf := TNotaEletInfConf.Create;
      Try
        lNotaEletInfConf.FEntSim := 'S';
        lNotaEletInfConf.FMovGer := cdsConsulta.FieldByName('AUTOINCREM').AsString;

        TEfetivaMovimentoFiscal.pEfetiva(strNumDoc,
                                         strEspDoc,
                                         strSerie,
                                         strCodFor,
                                         strCodEmp,
                                         fNow,
                                         0, 0, 0, False, '',
                                         lNotaEletInfConf);
      Finally
        lNotaEletInfConf.Free;
      End;
    Except On
      E:Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmRecTransfEstoque.fEfetivaMvtoFiscal]');
      End;
    End;
  End;
end;

function TfrmRecTransfEstoque.fCriaNumerosDeSerieEntrada(AStrAutIncMovDetGravada: String): Boolean;
var
  objNumSerie: TNumeroSerie;
begin
  objNumSerie := TNumeroSerie.Create;

  Try
    objNumSerie.TipoRotina := tpEntradaSimplificada;
    objNumSerie.pInicia(AStrAutIncMovDetGravada, tpEntrada, qryMovDet.FieldByName('AUTOINCREM').AsString);
    Result := objNumSerie.fSalva;
  Finally
    FreeAndNil(objNumSerie);
  End;
end;

function TfrmRecTransfEstoque.fValidouSituacaoFiscalDoDocumento : Boolean;
  Var
    strStatus : String;
    intCnt : Integer;
    strAutInc : String;
    strCliFor : String;
    strTipFc : String;
    strProblemasDeAutorizacao : String;
    strProblemasNoCancelamento : String;
    strMensagemDaTrava : String;
    strChaveAcesso : String;
begin
  Result := True;
  strProblemasDeAutorizacao := EmptyStr;
  strProblemasNoCancelamento := EmptyStr;
  For intCnt := 0 To Pred(stlListSelecao.Count) Do
  Begin
    strAutInc := stlListSelecao[intCnt];
    If (Not cdsConsulta.Locate('AUTOINCREM', strAutInc, [])) Then
      Continue;
    If (cdsConsulta.FieldByName('GER_ESPDOC').AsString <> 'NF') Then
      Continue;

    If fEmptyStr(cdsConsulta.FieldByName('GER_CODFOR').AsString) Then
    Begin
      strCliFor := cdsConsulta.FieldByName('GER_CODCLI').AsString;
      strTipFc := 'C';
    End
    Else
    Begin
      strCliFor := cdsConsulta.FieldByName('GER_CODFOR').AsString;
      strTipFc := 'F';
    End;

    strChaveAcesso := fRetChaveAcesso(cdsConsulta.FieldByName('GER_NUMDOC').AsString,
                                      cdsConsulta.FieldByName('GER_ESPDOC').AsString,
                                      strCliFor,
                                      cdsConsulta.FieldByName('GER_CODEMP').AsString,
                                      cdsConsulta.FieldByName('GER_SERIE_').AsString,
                                      strTipFc);

    If (Not fEmptyStr(strChaveAcesso)) And (objLogCancelamento.fExisteCancelamentoPendentePorChaveAcesso(strChaveAcesso)) Then
    Begin
      strProblemasNoCancelamento := strProblemasNoCancelamento + cdsConsulta.FieldByName('GER_NUMDOC').AsString + '-' +
                                                                 cdsConsulta.FieldByName('GER_ESPDOC').AsString + '-' +
                                                                 cdsConsulta.FieldByName('GER_CODEMP').AsString + sLineBreak;
      Continue;
    End;

    strStatus := fPainelNFeStatusDocumento(cdsConsulta.FieldByName('GER_NUMDOC').AsString,
                                           cdsConsulta.FieldByName('GER_ESPDOC').AsString,
                                           cdsConsulta.FieldByName('GER_CODEMP').AsString,
                                           strCliFor,
                                           cdsConsulta.FieldByName('GER_SERIE_').AsString,
                                           strTipFc);

    If fEmptyStr(strStatus) Then
      Continue;

    If (strStatus = 'AT') Then
      Continue;

    strProblemasDeAutorizacao := strProblemasDeAutorizacao + cdsConsulta.FieldByName('GER_NUMDOC').AsString + '-' +
                                                             cdsConsulta.FieldByName('GER_ESPDOC').AsString + '-' +
                                                             cdsConsulta.FieldByName('GER_CODEMP').AsString + ' STATUS: ' + strStatus + sLineBreak;
  End;

  If fEmptyStr(strProblemasDeAutorizacao + strProblemasNoCancelamento) Then
    Exit;

  Result := False;

  strMensagemDaTrava := EmptyStr;

  If Not fEmptyStr(strProblemasDeAutorizacao) Then
    strMensagemDaTrava := strMensagemDaTrava + 'Documentos com problema de autorização: ' + sLineBreak + strProblemasDeAutorizacao + sLineBreak;

  If Not fEmptyStr(strProblemasNoCancelamento) Then
    strMensagemDaTrava := strMensagemDaTrava + 'Documentos em processo de cancelamento (LOGCAN): ' + sLineBreak + strProblemasNoCancelamento + sLineBreak;

  fMensagem('', strMensagemDaTrava, ['&OK']);
end;

function TfrmRecTransfEstoque.fGeraPlanoRecebimentoAutomatico(intIndice: Integer): Boolean;
var
  frmPlanoDeRecebimento: TFrmPlanoDeRecebimento;
begin
  //Só confirmo o plano de recebimento quando é o ultimo registro selecionado em caso de multi-seleção,
  //pois a IDEDIG é a mesma para N documentos selecionados e não pode efetivar mtvo fiscal para cada DOC,
  //apenas para o último. Assim vai gerar as AGEITE corretamente para todos itens de todos docs selecionados
  If (Not (intIndice = stlListSelecao.Count-1)) Then
    Exit(True);

  Result := True;
  If strIdeDig  <> '' Then
  Begin
     If fCfgSis('PLAAUT') = 'S' Then
     Begin
       pCriarFormularios(TfrmPlanoDeRecebimento, frmPlanoDeRecebimento);
       Try
         frmPlanoDeRecebimento.blnConfirmacaoAutomatica := True;
           frmPlanoDeRecebimento.edtIdeDig.Text :=  strIdeDig;
           frmPlanoDeRecebimento.tipValItem := tvIteAti;
           frmPlanoDeRecebimento.fValidacampoExterno(frmPlanoDeRecebimento.edtIdeDig, False);
           If fEmptyStr(frmPlanoDeRecebimento.strFalha) Then
             frmPlanoDeRecebimento.btnConfirmaClick(frmPlanoDeRecebimento.btnConfirma);

           If Not fEmptyStr(frmPlanoDeRecebimento.strFalha) Then
           Begin
             Result := False;
             fRollBack;
             pMensagensErro(frmPlanoDeRecebimento.strFalha, '[TfrmRecTransfEstoque.fGeraPlanoRecebimentoAutomatico]');
           End;
       Finally
         FreeAndNil(frmPlanoDeRecebimento)
       End;
     End;
  End;
End;

function TfrmRecTransfEstoque.fGravarDigCon: Boolean;
Begin
  Result := True;
  If fEmptyStr(FstrFatGor) Then
    FstrFatGor := fAutoincremFatGor;

  If  (FblnCOFTRA) And (Not fEmptyStr(FstrFatGor))  Then
  Begin
    Result := TDistribuicaoConferencia.fGerarDigConEntradaSimplificada(FstrFatGor);
  End;
End;

function TfrmRecTransfEstoque.fAutoincremFatGor: String;
var
  qryAux : TUniQuery;
begin
  Result := '';

  qryAux := fCriaQuery;
  try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT STRAIGHT_JOIN FATGOR.AUTOINCREM');
    qryAux.SQL.Add('  FROM MOVDET');
    qryAux.SQL.Add(' INNER JOIN EXTDOR');
    qryAux.SQL.Add('    ON EXTDOR.FDO_AUTDET = MOVDET.AUTOINCREM');
    qryAux.SQL.Add(' INNER JOIN FATDOR');
    qryAux.SQL.Add('    ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO');
    qryAux.SQL.Add(' INNER JOIN EXTGOR');
    qryAux.SQL.Add('    ON EXTGOR.FGO_SEQFGO = FATDOR.FDO_SEQGER');
    qryAux.SQL.Add(' INNER JOIN FATGOR');
    qryAux.SQL.Add('    ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO');
    qryAux.SQL.Add(' WHERE MOVDET.DET_SEQGER = :DET_SEQGER');
    qryAux.SQL.Add(' LIMIT 1');
    qryAux.ParamByName('DET_SEQGER').AsString := strAutInc;
    qryAux.Open;
    if not qryAux.IsEmpty then
      Result := qryAux.FieldByName('AUTOINCREM').AsString;
  finally
    qryAux.Free;
  end;
end;

function TfrmRecTransfEstoque.fTabRef(strTabela: String): String;
begin
  Result := IIF(Pos('NOTDET', strTabela) > 0, 'NOTREF', 'MOVREF');
end;

Procedure TfrmRecTransfEstoque.pCarregaTotaisReformaOrigem(Var fltTotIbs, fltTotCbs, fltTotIs, fltTotProIs, fltTotNf: Double);
Var
  qryAux: TUniQuery;
Begin
  fltTotIbs   := 0;
  fltTotCbs   := 0;
  fltTotIs    := 0;
  fltTotProIs := 0;
  fltTotNf    := 0;

  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Text := 'SELECT * FROM ' +
                       IIF(SameText(cdsConsulta.FieldByName('TABELA').AsString, 'NOTGER'), 'AUXNOT', 'AUXMOV') +
                       ' WHERE AUX_SEQGER = :SEQGER';
    qryAux.ParamByName('SEQGER').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
    qryAux.Open;

    If Not qryAux.IsEmpty Then
    Begin
      fltTotIbs   := qryAux.FieldByName('AUX_TOTIBS').AsFloat;
      fltTotCbs   := qryAux.FieldByName('AUX_TOTCBS').AsFloat;
      fltTotIs    := qryAux.FieldByName('AUX_TOT_IS').AsFloat;
      fltTotProIs := qryAux.FieldByName('AUX_TPROIS').AsFloat;
      fltTotNf    := qryAux.FieldByName('AUX_TOT_NF').AsFloat;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
End;

Procedure TfrmRecTransfEstoque.pCarregaRefTribItemOrigem(const strSeqDetOri: String; Var objRef: TMovDetParams);
  Var
    qryRef: TUniQuery;
Begin
  objRef.Init;

  If fEmptyStr(strSeqDetOri) Then
    Exit;

  qryRef := fCriaQuery;
  Try
    qryRef.SQL.Text := 'SELECT * FROM ' + fTabRef(strArqTabDetOri) + ' WHERE REF_SEQGER = :SEQGER';
    qryRef.ParamByName('SEQGER').AsString := strSeqDetOri;
    qryRef.Open;

    If qryRef.IsEmpty Then
      Exit;

    objRef.strRefCodCst := Trim(qryRef.FieldByName('REF_CODCST').AsString);
    objRef.strRefClaTri := Trim(qryRef.FieldByName('REF_CLATRI').AsString);
    objRef.fltRefValOpe := qryRef.FieldByName('REF_VALOPE').AsFloat;
    objRef.fltRefBasCal := qryRef.FieldByName('REF_BASCAL').AsFloat;
    objRef.fltRefCbsAlq := qryRef.FieldByName('REF_CBSALQ').AsFloat;
    objRef.fltRefCbsAlD := qryRef.FieldByName('REF_CBSALD').AsFloat;
    objRef.fltRefCbsVlD := qryRef.FieldByName('REF_CBSVLD').AsFloat;
    objRef.fltRefCbsAlR := qryRef.FieldByName('REF_CBSALR').AsFloat;
    objRef.fltRefCbsVlT := qryRef.FieldByName('REF_CBSVLT').AsFloat;
    objRef.fltRefCbsAlE := qryRef.FieldByName('REF_CBSALE').AsFloat;
    objRef.fltRefCbsVal := qryRef.FieldByName('REF_CBSVAL').AsFloat;
    objRef.fltRefIbsUfA := qryRef.FieldByName('REF_IBSUFA').AsFloat;
    objRef.fltRefIbsUfD := qryRef.FieldByName('REF_IBSUFD').AsFloat;
    objRef.fltRefIbsUvD := qryRef.FieldByName('REF_IBSUVD').AsFloat;
    objRef.fltRefIbsUfR := qryRef.FieldByName('REF_IBSUFR').AsFloat;
    objRef.fltRefIbsUfT := qryRef.FieldByName('REF_IBSUFT').AsFloat;
    objRef.fltRefIbsUfE := qryRef.FieldByName('REF_IBSUFE').AsFloat;
    objRef.fltRefIbsUfV := qryRef.FieldByName('REF_IBSUFV').AsFloat;
    objRef.fltRefIbsMnA := qryRef.FieldByName('REF_IBSMNA').AsFloat;
    objRef.fltRefIbsMnD := qryRef.FieldByName('REF_IBSMND').AsFloat;
    objRef.fltRefIbsMvD := qryRef.FieldByName('REF_IBSMVD').AsFloat;
    objRef.fltRefIbsMnR := qryRef.FieldByName('REF_IBSMNR').AsFloat;
    objRef.fltRefIbsMnT := qryRef.FieldByName('REF_IBSMNT').AsFloat;
    objRef.fltRefIbsMnE := qryRef.FieldByName('REF_IBSMNE').AsFloat;
    objRef.fltRefIbsMnV := qryRef.FieldByName('REF_IBSMNV').AsFloat;
    objRef.fltRefValIbs := qryRef.FieldByName('REF_VALIBS').AsFloat;
    objRef.strRefSelCst := Trim(qryRef.FieldByName('REF_SELCST').AsString);
    objRef.strRefSelCla := Trim(qryRef.FieldByName('REF_SELCLA').AsString);
    objRef.fltRefSelBas := qryRef.FieldByName('REF_SELBAS').AsFloat;
    objRef.fltRefSelAlq := qryRef.FieldByName('REF_SELALQ').AsFloat;
    objRef.fltRefSelVal := qryRef.FieldByName('REF_SELVAL').AsFloat;

    // Mantém o default do Init quando a origem vier vazia
    If Not fEmptyStr(qryRef.FieldByName('REF_TRIREG').AsString) Then
      objRef.strRefTriReg := Trim(qryRef.FieldByName('REF_TRIREG').AsString);
    If Not fEmptyStr(qryRef.FieldByName('REF_CREPRE').AsString) Then
      objRef.strRefCrePre := Trim(qryRef.FieldByName('REF_CREPRE').AsString);
    If Not fEmptyStr(qryRef.FieldByName('REF_MONOFA').AsString) Then
      objRef.strRefMonoFa := Trim(qryRef.FieldByName('REF_MONOFA').AsString);

    objRef.strRefCesBas := Trim(qryRef.FieldByName('REF_CESBAS').AsString);
    objRef.strRefCstReg := Trim(qryRef.FieldByName('REF_CSTREG').AsString);
    objRef.strRefClaReg := Trim(qryRef.FieldByName('REF_CLAREG').AsString);
    objRef.fltRefAiuReg := qryRef.FieldByName('REF_AIUREG').AsFloat;
    objRef.fltRefTiuReg := qryRef.FieldByName('REF_TIUREG').AsFloat;
    objRef.fltRefAimReg := qryRef.FieldByName('REF_AIMREG').AsFloat;
    objRef.fltRefTimReg := qryRef.FieldByName('REF_TIMREG').AsFloat;
    objRef.fltRefCbsReg := qryRef.FieldByName('REF_CBSREG').AsFloat;
    objRef.fltRefTcbReg := qryRef.FieldByName('REF_TCBREG').AsFloat;

  Finally
    FreeAndNil(qryRef);
  End;
End;


end.

