unit untConfDocs;

interface

uses
  Classes,
  Uni,
  DB,
  UniClientDataSet,
  ComCtrls,
  Windows,
  Forms,
  Math,
  System.Types,
  untFuncFat,
  untFuncoes,
  UniDataSetProvider,
  Variants,
  untTypesSistema;

Type
  TTipoDoc = (opcComProfissional, opcSemProfissional, opcNenhum);
  TSituacaoFinanceira = (stTodos, stQuitado, stEmAberto);
  TTipoAcao = (taConfirmacao, taBaixa, taCancelamentoBaixa);

type
  TPreparaDocumentoParaConfirmar = procedure(objVenda: TFatVenda) Of Object;

type
  TProcInformacao = procedure(strInfo: String) of object;

type
  TConfirmacaoDocumentos = class(TComponent)
    private
      FCodCli: String;
      FCliSeg: String;
      FNumDoc: String;
      FEspDoc: String;
      FEmpDoc: String;
      FDtaIni: TDateTime;
      FDtaFim: TDateTime;

      FCodFaz: String;
      FCodEmb: String;
      FTemSer: String;
      FTemCcr: String;

      FQtdDoc: String;
      FTotGer: String;
      FDupPag: String;
      FDesSuj: String;
      FJurSuj: String;
      FTotLiq: String;

      FQtdDocSel: String;
      FTotGerSel: String;
      FDupPagSel: String;
      FDesSujSel: String;
      FJurSujSel: String;
      FTotLiqSel: String;
      FTotTrvSel: String;

      FCodCnd: String;
      FConPag: String;
      FCodFpg: String;
      FTipFre: String;
      FCodVen: String;
      FCodVe2: String;

      FNomTab: String;
      FAutInc: String;

      FEstornoNotaFiscal: Boolean;
      FEstornoNotaFiscalEntregaFutura : Boolean;

      FProgress: TProgressBar;
      FDadosConf: OleVariant;

      FPrepDoc: TPreparaDocumentoParaConfirmar;
      FProcInfo: TProcInformacao;

      strEspSel: String;
      fatVenda : TFatVenda;
      intCriandoTemp: Integer;
      cdsItensConf  : TUniClientDataSet;
      blnCriouFatVendaInternamente: Boolean;
      stlDocQuitado: TStringList;

      cdsTotDev: TUniClientDataSet;

      FItensDocs: Integer;

      FFilEmp: Boolean;

      intQtdSer : Integer;

      FCodDiv: String;
      FConfTemFFComBol: Boolean;

      {**************************************************************}
      {* ARMAZENA TODOS OS NUMEROS DE DOCUMENTOS DE DEVOLUÇÃO,      *}
      {* CASO O DOCUMENTO É SINTETIZADO PARA A VISUAZALIÇÃO NO GRID *}
      {************************************************************FC}
      FcdsDocsDevSintetizado: TUniClientDataSet;

      FTipoDoc : TTipoDoc;
      FstlDocSel: TStringList;

      FAutoIncrenEnderecoEntrega : String;

      FSituacaoFinanceira : TSituacaoFinanceira;

      FCarregaItensJaFaturado : Boolean;

      function fSintetizarItensNaConfirmacaoDeDocumentos: Boolean;
      function fGetSemDocumentos: Boolean;
      function fGetConsiderarDV: Boolean;
      function fGetSintetizarDV: Boolean;
      function fGetQryConf: TUniQuery;

      function fFiltroProEmb: String;
      function fEhDuplicataAgrupada: Boolean;

      function fSQLRetValorDevolucao: String;
      function fSQLRetValorDocumento: String;

      procedure pCriaTemporariaConfirmacaoInt;

      procedure pCriaCdsTotDev;

      procedure pAddDevolucao( strDocDev,
                               strEspDev,
                               strEmpDev,
                               strNumDoc,
                               strEspDoc,
                               strEmpDoc: String;
                               fltValDev: Double );

      procedure pCalculaTotais;
      procedure pReverteValorDocumentos;

      procedure pSintentizaDevolucoes;
      procedure pDeletaDocDesmarcadosDevSintet;

      procedure pRetJurosDescontoSujerido( strNumDoc,
                                           strEspDoc,
                                           strCodEmp,
                                           strCodCli: String;
                                       Var fltJurSuj,
                                           fltDesSuj,
                                           fltValAbe: Double );

      function fGetValorDuplicatasRecebidas( strNumDup,
                                             strEspDoc,
                                             strCodEmp: String;
                                             fltVlrCon,
                                             fltDupRecAnt: Double;
                                         Var fltJurSuj,
                                             fltDesSuj,
                                             fltValAbe: Double ): Double;

      function fGetDuplicataBaixaTotal( strNumDup,
                                        strEspDoc,
                                        strCodEmp: String;
                                        var blnQuitadoTotal : Boolean ): Boolean;

      function fGetExisteDuplicataCad(strNumDup,
                                      strEspDoc,
                                      strCodEmp: String): Boolean;

      function fGetAfterScroll: TDataSetNotifyEvent;
      procedure pSetAfterScroll(const Value: TDataSetNotifyEvent);

      procedure pCarregaDadosGravadosDoCliente(strTabGer, strAutInc: String);
      function  fPodeSintetizarDoc(cdsIteConf: TUniClientDataSet;
                                   strNumDoc, strEspDoc, strCodEmp: String;
                                   Var stlDocNaoSin: TStringList;
                                   blnForcarComparacao: Boolean = False): Boolean;
      function  fCasoPerfeito(cdsIteTmp: TUniClientDataSet; fltUniDev, fltQtdDev: Double; blnForcarComparacao: Boolean = False): Boolean;
      procedure pMontaFiltro(strIncDev: String; recMadeira: TDadosMadeira; Var cdsIteTmp: TUniClientDataSet);

      procedure pCriaClientDocsSint;
      function fRetSeqMar: Integer;

      //function fEntregaFuturaTemDevolucao(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
      //function fEhDevolucaoDeBaixaDeEntFut(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;

      Function fTemProfissional(strNumDoc,
                                strEspDoc,
                                strCodCli,
                                strCodEmp: String;
                                blnFiltraMaisdeUmProfissional: Boolean = False): Boolean;
      Function fRetProfissional(strNumDoc,
                                strEspDoc,
                                strCodCli,
                                strCodEmp: String): String;
      Function fSetTipoDoc(strNumDoc, strEspDoc, strCodCli, strCodEmp: String): TTipoDoc;
      function fRetornaAutIncCadRec: String;
      function fRetornaDocQuitadoTotal(intQtdParcBx : Integer;
                                       strNumDup,
                                       strEspDoc,
                                       strCodEmp: String) : Boolean;
      function fRetornaSeDocTemBxParcial(strNumDup,
                                         strEspDoc,
                                         strCodCli,
                                         strCodEmp: String) : Boolean;

      function DocumentoComPixGeradoEAtivo(ANumeroDuplicata,
                                           AEspecieDocumento,
                                           ACodigoEmpresa,
                                           ACodigoCliente: String): Boolean;
    function fValidaProdutoTintaOutraEmpresa(ANumeroDocumento,
      AEspecieDocumento, ACodigoEmpresa, ACodigoCliente: String): Boolean;

    public
      strMsgTinta : String;

      procedure pCriaTemporariaConfirmacao;
      procedure pDeletaTemporariaConfirmacao;
      procedure pAtualizaTemporariaConfirmacao(blnMantemSintet: Boolean);
      procedure pDeletaDocDesmarcados;
      procedure pResintetizaDevolucoes;

      procedure pMarcarTodosDocumentos(blnMarcar: Boolean; strEntRet: String);

      function fDuplicataDeCreditoLiberada(ANumDup, AParcel, AEspDoc, ACodEmp, ACodCli: string): Boolean;
      
      function fMarcaDocumento(blnMarcar: Boolean; Var strMsgFunc: String; blnEmLoop: Boolean=False): Boolean;

      function fValidaValorRecebidoDocumentosSelecionados: Boolean;

      function fValidaDVsCorrelatasMarcadas: Boolean;

      procedure pCarregaItensDocumento;
      procedure pGeraStringDocsConfirmados;
      procedure pPegaPlacaAndKmVeiculo;

      function fCarregaItensConfirmacaoDocumentos: Boolean;
      function fChamaTelaParaConfirmacaoDosItens: Boolean;

      procedure pSetaClienteDocs(strCodCli: String);

      function fConfirmarDocumentos: Boolean;

      function fRetonaUnitarioLiq(cdsIteDoc: TUniClientDataSet): Double;

      function fEhDocPassivelDeSintetizacao(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
      procedure fVerificarMarcarComoNaoSintetizavel;
      procedure pMarcarDesmarcarPodeSintetizar(strNumDoc, strEspDoc, strCodEmp: String; strPodSin: String = 'N');
      function pMontaListaComDocFatDaDV(strNumDoc, strCodEmp: String): String;

      procedure pBaixarDocumentosMarcados;
      procedure pCancelarBaixaDocumentosMarcados;
      procedure pAtualizaDocumentosMarcados(ATipoAcao : TTipoAcao);

      constructor Create(AOwner: TComponent); override;
      constructor CreateInstance(AOwner: TComponent; objVenda: TFatVenda);
      destructor Destroy; override;

      function fVerificaDocumentosDigitalizados: Boolean;
      procedure pMarcarDocumentosMeiaNota;
      function fVerificaDocumentosFinanceiroAberto: Boolean;
    published
      property strNumDoc: String Read FNumDoc Write FNumDoc;
      property strEspDoc: String Read FEspDoc Write FEspDoc;
      property strEmpDoc: String Read FEmpDoc Write FEmpDoc;
      property strCodCli: String Read FCodCli Write FCodCli;
      property strCliSeg: String Read FCliSeg Write FCliSeg;

      property blnFiltrarEmp: Boolean Read FFilEmp Write FFilEmp;

      property dtaDtaIni: TDateTime Read FDtaIni Write FDtaIni;
      property dtaDtaFim: TDateTime Read FDtaFim Write FDtaFim;

      property strCodFaz: String Read FCodFaz;
      property strCodEmb: String Read FCodEmb;
      property strTemSer: String Read FTemSer;
      property strTemConcr: String Read FTemCcr;

      property prbProgresso: TProgressBar Read FProgress Write FProgress;
      property oleDadosConfirmacao: OleVariant Read FDadosConf Write FDadosConf;
      property pAtualizaDados: TDataSetNotifyEvent Read fGetAfterScroll Write pSetAfterScroll;

      property qryConfirmacao: TUniQuery Read fGetQryConf;

      property blnSintetizarDevolucao: Boolean read fGetSintetizarDV;

      property strQtdDoc: String Read FQtdDoc;
      property strTotGer: String Read FTotGer;
      property strDupPag: String Read FDupPag;
      property strDesSuj: String Read FDesSuj;
      property strJurSuj: String Read FJurSuj;
      property strTotLiq: String Read FTotLiq;

      property intQtdItensDocs: Integer Read FItensDocs;

      property strQtdDocSel: String Read FQtdDocSel;
      property strTotGerSel: String Read FTotGerSel;
      property strDupPagSel: String Read FDupPagSel;
      property strDesSujSel: String Read FDesSujSel;
      property strJurSujSel: String Read FJurSujSel;
      property strTotLiqSel: String Read FTotLiqSel;
      property strTotTrvSel: String Read FTotTrvSel;

      property strCodigoCondicaoPagamento: String Read FCodCnd;
      property strCondicaoPagamento: String Read FConPag;
      property strCodigoFormaPagamento: String Read FCodFpg;
      property strTipoFrete: String Read FTipFre;
      property strCodigoVendedor: String Read FCodVen;
      property strCodigoVendedor2: String Read FCodVe2;

      property strCodDiv: String Read FCodDiv;
      property blnConfTemFFComBol: Boolean Read FConfTemFFComBol;
      property blnConsiderarDV: Boolean Read fGetConsiderarDV;
      property blnEstornoNotaFiscal: Boolean Read FEstornoNotaFiscal Write FEstornoNotaFiscal;
      property blnEstornoNotaFiscalEntregaFutura: Boolean Read FEstornoNotaFiscalEntregaFutura Write FEstornoNotaFiscalEntregaFutura;
      property blnSemDocumentosParaConfirmar: Boolean Read fGetSemDocumentos;

      property pPreparaDocumentoParaConfirmar: TPreparaDocumentoParaConfirmar Read FPrepDoc Write FPrepDoc;
      property pInformacoes: TProcInformacao Read FProcInfo Write FProcInfo;

      property cdsDocsDevSintetizado: TUniClientDataSet Read FcdsDocsDevSintetizado Write FcdsDocsDevSintetizado;
      property stlDocSel: TStringList read FstlDocSel write FstlDocSel;
      property objFatVenda: TFatVenda read fatVenda;
      property AutoIncrenEnderecoEntrega : String read FAutoIncrenEnderecoEntrega write FAutoIncrenEnderecoEntrega;
      property SituacaoFinanceira : TSituacaoFinanceira read FSituacaoFinanceira write FSituacaoFinanceira;
      property CarregaItensJaFaturado : Boolean read FCarregaItensJaFaturado write FCarregaItensJaFaturado;
  end;

  Const
    strMensagemFixaTinta = 'O(s) documento(s) %s possui(em) Tinta de Máquina '+
                       'então não será(ão) carregado(s), '+
                       'pois a Empresa logada não utiliza Tinta de Máquina - [CFG_USATMQ]. Verifique!';
implementation


uses untFatMostraProdConfirmacao, untCadRec, untFuncTinta, untFatDadosFiscais, untGravando, untValidacaoCredito,
     untConstantes, untMadeireira, SysUtils, StrUtils, untFuncFatTypes,  untFuncoesSimples,
     untParCalculaPrecoCusto, untTConfiguracao, untDuplicatas, TypInfo,
     untMensagemExplicativa, untLiberacao, Faturamento.Classes.DigitalizacaoDocumentos,
     untNotGer, untTiposPix, untFatGor, untRecalculoSeqCombo;

{ TConfirmacaoDocumentos }

constructor TConfirmacaoDocumentos.Create(AOwner: TComponent);
begin
//  inherited;
  CreateInstance(AOwner, nil);
end;

constructor TConfirmacaoDocumentos.CreateInstance(AOwner: TComponent;
  objVenda: TFatVenda);
begin
  inherited Create(AOwner);

  blnCriouFatVendaInternamente := Not Assigned(objVenda);

  If blnCriouFatVendaInternamente Then
  Begin
    pCriarCdsVenda(Self);
    fatVenda := TFatVenda.CreateInstance('CF');
    fatVenda.strNomeForm := 'frmFatVendas';
  End
  Else
    fatVenda := objVenda;

  fatVenda.strOpcDocTrue := 'CF';

  FEstornoNotaFiscalEntregaFutura := False;
  fatVenda.stlCadRecDtaLogDocsConf.Clear;
  stlDocQuitado := TStringList.Create;

  FCodCli := fatVenda.strCodCli;

  pCriaCdsTotDev;
  intCriandoTemp := -1;
  strEspSel      := '';

  {*****************************************}
  {* VERIFICA SE PODE CONFIRMAR DOCUMENTOS *}
  {* DA FILIAL NA MATRIZ.                  *}
  {**************************************MV*}
  blnFiltrarEmp := True;

  intQtdSer := 0;

  FTipoDoc := opcNenhum;
  FCodDiv  := EmptyStr;
  FEmpDoc  := EmptyStr;
  FConfTemFFComBol := False;

  If (fCfgSis('CFFMAT', varBoolean)) Then
    blnFiltrarEmp := False;

  FstlDocSel := TStringList.Create;

  FSituacaoFinanceira := stTodos;

  FCarregaItensJaFaturado := False;
  strMsgTinta := '';;
end;

destructor TConfirmacaoDocumentos.Destroy;
begin
  If blnCriouFatVendaInternamente Then
  Begin
    pFreeCdsVenda;
    FreeAndNil(fatVenda);
  End;

  If Assigned(stlDocQuitado) Then
    FreeAndNil(stlDocQuitado);

  If Assigned(cdsTotDev) Then
    FreeAndNil(cdsTotDev);

  If Assigned(cdsItensConf) Then
    FreeAndNil(cdsItensConf);

  If (Assigned(FstlDocSel)) Then
    FreeAndNil(FstlDocSel);

  inherited Destroy;
end;

function TConfirmacaoDocumentos.DocumentoComPixGeradoEAtivo(
  ANumeroDuplicata, AEspecieDocumento, ACodigoEmpresa,
  ACodigoCliente: String): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Result := False;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT M.MPX_STATUS ' +
                          'FROM CADREC C ' +
                          'JOIN MOVPIX M ON M.MPX_CODEMP=C.CTR_EMPPIX ' +
                          '             AND M.MPX_TX_ID_=C.CTR_TX_PIX ' +
                          'WHERE C.CTR_NUMDUP=:NUMDUP ' +
                          '  AND C.CTR_ESPDOC=:ESPDOC ' +
                          '  AND C.CTR_CODEMP=:CODEMP ' +
                          '  AND C.CTR_CODCLI=:CODCLI ' +
                          '  AND C.CTR_TX_PIX IS NOT NULL ';

    LConsulta.ParamByName('NUMDUP').AsString := ANumeroDuplicata;
    LConsulta.ParamByName('ESPDOC').AsString := AEspecieDocumento;
    LConsulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LConsulta.ParamByName('CODCLI').AsString := ACodigoCliente;
    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit;

    While Not LConsulta.Eof Do
    Begin
      Result := MatchStr(LConsulta.FieldByName('MPX_STATUS').AsString, STATUS_PIX_ATIVO);

      If Result Then
        Exit;

      LConsulta.Next;
    End;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TConfirmacaoDocumentos.fValidaProdutoTintaOutraEmpresa(
  ANumeroDocumento, AEspecieDocumento, ACodigoEmpresa,
  ACodigoCliente: String): Boolean;
  Var
    LConsulta: TUniQuery;
begin

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT COUNT(MD.DET_IDEPRO) AS TOTAL  '+
                          'FROM MOVDET MD        '+
                          'WHERE MD.DET_NUMDOC = :NUMDOC  '+
                          '  AND MD.DET_CODEMP = :CODEMP  '+
                          '  AND MD.DET_CODCLI = :CODCLI  '+
                          '  AND MD.DET_ESPDOC = :ESPDOC  '+
                          '  AND MD.DET_IDEPRO <> ''NOR''';

    LConsulta.ParamByName('NUMDOC').AsString := ANumeroDocumento;
    LConsulta.ParamByName('ESPDOC').AsString := AEspecieDocumento;
    LConsulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LConsulta.ParamByName('CODCLI').AsString := ACodigoCliente;
    LConsulta.Open;

    Result := LConsulta.FieldByName('TOTAL').AsInteger > 0;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TConfirmacaoDocumentos.fGetSemDocumentos: Boolean;
begin
  Result := fatVenda.qryTemporariaConfirmacao.IsEmpty;
end;

function TConfirmacaoDocumentos.fGetConsiderarDV: Boolean;
begin
  Result := (blnSintetizarDevolucao) Or (fCfgSis('ENTDEV', varBoolean));
end;

function TConfirmacaoDocumentos.fSintetizarItensNaConfirmacaoDeDocumentos: Boolean;
begin
  Result := False;

  If blnEstornoNotaFiscal Then
    Exit;

  Result := (fCfgSis('SINCNF', varString) = 'S');
end;

function TConfirmacaoDocumentos.fGetSintetizarDV: Boolean;
begin
  If blnEstornoNotaFiscal Then
    Exit(False);

  {*********************************************************************************}
  {* COMENTADO A PEDIDO DO RONALDO, SOLICITAÇÃO DO CLIENTE: NOSSA LOJA, 10/10/2012 *}
  {******************************************************************************RN*}
  Result := fCfgSis('SINCNF', varBoolean) And
            (Not fatVenda.blnMeiaNota); {And
           (Not (fClienteConsumidor(fRetNomCliente(FCodCli), False, True)))};
end;

procedure TConfirmacaoDocumentos.pCriaTemporariaConfirmacao;
Begin

  If InterlockedIncrement(intCriandoTemp) = 0 Then
  Begin
    pCriaTemporariaConfirmacaoInt;
    InterlockedDecrement(intCriandoTemp);
  End
  Else
    InterlockedDecrement(intCriandoTemp);

End;

procedure TConfirmacaoDocumentos.pCriaTemporariaConfirmacaoInt;
  Var
    strSQL   : String;
    strNumDoc: String;
    intQtdIte: Integer;
    fltDupRec: Double;
    strDocAnt: String;
    strEspAnt: String;
    strEmpAnt: String;
    intDiaMis: Integer;

    intContador: Integer;

    dspProvider: TUniDataSetProvider;

    qryGenEmp : TUniQuery;
    qryGenDet : TUniQuery;

    fltTotIte: Double;
    fltVlrCon: Double;
    fltTotIpi: Double;
    fltTotRet: Double;

    fltJurSuj,
    fltDesSuj: Double;

    blnFFComBol,
    blnQuitado,
    blnQuitadoTotal,
    blnPedTemBxParcial,
    blnTotAber: Boolean;

    blnPoderaSintetizar: Boolean;

    fltValAbe: Double;//VALOR EM ABERTO DA DUPLICATA
    fltTotFre: Double;
    fltGerFre: Double;
    fltTotDesAce: Double;
    fltGerDesAce: Double;
    fltTotFreCot: Double;
    fltGerFreCot: Double;
    fltGetTotIpi: Double;
    fltGetTotRet: Double;
    fltTotRef: Double;
    fltGetTotRef: Double;

    function fGetSQLDVNaoEhDocumentoConfirmado(strCndAncora: String): String;
    begin
      Result :=  
        ' (SELECT IF(COUNT(*)>0,"S","N") FROM MOVDET DD '
      + '   INNER JOIN MOVTRI TT ON DD.AUTOINCREM = TT.DET_SEQGER '
      + '   INNER JOIN NOTDET NN ON NN.AUTOINCREM = TT.DET_INCDEV '
      + '   WHERE DD.DET_SEQGER = '+strCndAncora+' '
      + '     AND DD.DET_DOCDEV = NN.DET_NUMDOC '
      + '     AND DD.DET_ESPDEV = NN.DET_ESPDOC '
      + '     AND DD.DET_EMPDEV = NN.DET_CODEMP) ';
    end;

    function fGetSQLQtdRef: String;
    begin
      Result := ' (SELECT COUNT(DISTINCT CONCAT(DET_DOCDEV, DET_ESPDEV, DET_EMPDEV)) FROM MOVDET '
              + '         WHERE DET_SEQGER=MOVGER.AUTOINCREM '
              + '           AND CONCAT(IFNULL(DET_DOCDEV,""), IFNULL(DET_ESPDEV,""), IFNULL(DET_EMPDEV,"")) <> "") ';
    end;

    function fGetSQLIncDev: String;
    begin
      Result := ' IF (DET_INCDEV IS NOT NULL, '
              + '     DET_INCDEV, '
              + '     (SELECT M.AUTOINCREM FROM MOVDET M '
              + '                    WHERE M.DET_NUMDOC = MOVDET.DET_DOCDEV '
              + '                      AND M.DET_ESPDOC = MOVDET.DET_ESPDEV '
              + '                      AND M.DET_CODEMP = MOVDET.DET_EMPDEV '
              + '                      AND M.DET_CODITE = MOVDET.DET_CODITE '
              + ' LIMIT 1)) ';
    end;

    function fGetSQLTabDev: String;
    begin
      // Tabela do item referenciado no DET_INCDEV, pela mesma regra do fGetSQLDVNaoEhDocumentoConfirmado
      Result := ' IF((MOVTRI.DET_INCDEV IS NOT NULL) AND EXISTS(SELECT 1 FROM NOTDET N '
              + '                                      WHERE N.AUTOINCREM = MOVTRI.DET_INCDEV '
              + '                                        AND N.DET_NUMDOC = MOVDET.DET_DOCDEV '
              + '                                        AND N.DET_ESPDOC = MOVDET.DET_ESPDEV '
              + '                                        AND N.DET_CODEMP = MOVDET.DET_EMPDEV), '
              + '    "NOTDET", "MOVDET") ';
    end;
begin

  Try
    qryGenDet := fCriaQuery;
    qryGenEmp := fCriaQuery;

    dspProvider  := TUniDataSetProvider.Create(Self);
    cdsItensConf := TUniClientDataSet.Create(Self);

    dspProvider.DataSet := qryGenDet;
    cdsItensConf.SetProvider(dspProvider);

    intDiaMis := fCfgSis('DIAMIS', varInteger);

    FConfTemFFComBol := False;
    pDeletaTemporariaConfirmacao;
    fatVenda.qryTemporariaConfirmacao.Close;
    stlDocQuitado.Clear;

    fatVenda.qryTemporariaConfirmacao.DisableControls;

    {*******************************************}
    {* PEGA TODAS AS MI À VISTA COM DATA DE    *}
    {* ENTRADA > (DATE - DIAMI)                *}
    {****************************************MV*}

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  GER_NOMCON, ';
    strSQL := strSQL + '  GER_NUMDOC, ';
    strSQL := strSQL + '  GER_ESPDOC, ';
    strSQL := strSQL + '  GER_DTAENT, ';
    strSQL := strSQL + '  GER_JAFATU, ';
    strSQL := strSQL + '  GER_CODVEN, ';
    strSQL := strSQL + '  GER_DESESP, ';
    strSQL := strSQL + '  GER_VLRCON, ';
    strSQL := strSQL + '  GER_ENTFAT, ';
    strSQL := strSQL + '  GER_CODTRA, ';

    strSQL := strSQL + '  AUX_CODFAZ AS GER_CODFAZ, ';
    strSQL := strSQL + '  AUX_FASOBR AS GER_FASOBR, ';
    strSQL := strSQL + '  AUX_PLAVEI, ';
    strSQL := strSQL + '  AUX_KM_VEI, ';

    strSQL := strSQL + '  GER_CODS01, ';
    strSQL := strSQL + '  GER_CODS02, ';
    strSQL := strSQL + '  GER_CODS03, ';
    strSQL := strSQL + '  GER_CODS04, ';
    strSQL := strSQL + '  GER_CODS05, ';
    strSQL := strSQL + '  GER_CODS06, ';
    strSQL := strSQL + '  GER_CODS07, ';
    strSQL := strSQL + '  GER_CODS08, ';
    strSQL := strSQL + '  GER_CODS09, ';
    strSQL := strSQL + '  GER_CODS10, ';
    strSQL := strSQL + '  GER_CODS11, ';
    strSQL := strSQL + '  GER_CODS12, ';
    strSQL := strSQL + '  GER_CODS13, ';
    strSQL := strSQL + '  GER_CODS14, ';
    strSQL := strSQL + '  GER_CODS15, ';
    strSQL := strSQL + '  GER_CODS16, ';
    strSQL := strSQL + '  GER_CODS17, ';
    strSQL := strSQL + '  GER_CODS18, ';
    strSQL := strSQL + '  GER_CODS19, ';
    strSQL := strSQL + '  GER_CODS20, ';
    strSQL := strSQL + '  GER_CODS21, ';
    strSQL := strSQL + '  GER_CODS22, ';
    strSQL := strSQL + '  GER_CODS23, ';
    strSQL := strSQL + '  GER_CODS24, ';
    strSQL := strSQL + '  GER_CODS25, ';
    strSQL := strSQL + '  GER_CODS26, ';
    strSQL := strSQL + '  GER_CODS27, ';
    strSQL := strSQL + '  GER_CODS28, ';
    strSQL := strSQL + '  GER_CODS29, ';
    strSQL := strSQL + '  GER_CODS30, ';

    strSQL := strSQL + '  GER_DESS01, ';
    strSQL := strSQL + '  GER_DESS02, ';
    strSQL := strSQL + '  GER_DESS03, ';
    strSQL := strSQL + '  GER_DESS04, ';
    strSQL := strSQL + '  GER_DESS05, ';
    strSQL := strSQL + '  GER_DESS06, ';
    strSQL := strSQL + '  GER_DESS07, ';
    strSQL := strSQL + '  GER_DESS08, ';
    strSQL := strSQL + '  GER_DESS09, ';
    strSQL := strSQL + '  GER_DESS10, ';
    strSQL := strSQL + '  GER_DESS11, ';
    strSQL := strSQL + '  GER_DESS12, ';
    strSQL := strSQL + '  GER_DESS13, ';
    strSQL := strSQL + '  GER_DESS14, ';
    strSQL := strSQL + '  GER_DESS15, ';
    strSQL := strSQL + '  GER_DESS16, ';
    strSQL := strSQL + '  GER_DESS17, ';
    strSQL := strSQL + '  GER_DESS18, ';
    strSQL := strSQL + '  GER_DESS19, ';
    strSQL := strSQL + '  GER_DESS20, ';
    strSQL := strSQL + '  GER_DESS21, ';
    strSQL := strSQL + '  GER_DESS22, ';
    strSQL := strSQL + '  GER_DESS23, ';
    strSQL := strSQL + '  GER_DESS24, ';
    strSQL := strSQL + '  GER_DESS25, ';
    strSQL := strSQL + '  GER_DESS26, ';
    strSQL := strSQL + '  GER_DESS27, ';
    strSQL := strSQL + '  GER_DESS28, ';
    strSQL := strSQL + '  GER_DESS29, ';
    strSQL := strSQL + '  GER_DESS30, ';

    strSQL := strSQL + '  GER_QTDS01, ';
    strSQL := strSQL + '  GER_QTDS02, ';
    strSQL := strSQL + '  GER_QTDS03, ';
    strSQL := strSQL + '  GER_QTDS04, ';
    strSQL := strSQL + '  GER_QTDS05, ';
    strSQL := strSQL + '  GER_QTDS06, ';
    strSQL := strSQL + '  GER_QTDS07, ';
    strSQL := strSQL + '  GER_QTDS08, ';
    strSQL := strSQL + '  GER_QTDS09, ';
    strSQL := strSQL + '  GER_QTDS10, ';
    strSQL := strSQL + '  GER_QTDS11, ';
    strSQL := strSQL + '  GER_QTDS12, ';
    strSQL := strSQL + '  GER_QTDS13, ';
    strSQL := strSQL + '  GER_QTDS14, ';
    strSQL := strSQL + '  GER_QTDS15, ';
    strSQL := strSQL + '  GER_QTDS16, ';
    strSQL := strSQL + '  GER_QTDS17, ';
    strSQL := strSQL + '  GER_QTDS18, ';
    strSQL := strSQL + '  GER_QTDS19, ';
    strSQL := strSQL + '  GER_QTDS20, ';
    strSQL := strSQL + '  GER_QTDS21, ';
    strSQL := strSQL + '  GER_QTDS22, ';
    strSQL := strSQL + '  GER_QTDS23, ';
    strSQL := strSQL + '  GER_QTDS24, ';
    strSQL := strSQL + '  GER_QTDS25, ';
    strSQL := strSQL + '  GER_QTDS26, ';
    strSQL := strSQL + '  GER_QTDS27, ';
    strSQL := strSQL + '  GER_QTDS28, ';
    strSQL := strSQL + '  GER_QTDS29, ';
    strSQL := strSQL + '  GER_QTDS30, ';

    strSQL := strSQL + '  GER_UNIS01, ';
    strSQL := strSQL + '  GER_UNIS02, ';
    strSQL := strSQL + '  GER_UNIS03, ';
    strSQL := strSQL + '  GER_UNIS04, ';
    strSQL := strSQL + '  GER_UNIS05, ';
    strSQL := strSQL + '  GER_UNIS06, ';
    strSQL := strSQL + '  GER_UNIS07, ';
    strSQL := strSQL + '  GER_UNIS08, ';
    strSQL := strSQL + '  GER_UNIS09, ';
    strSQL := strSQL + '  GER_UNIS10, ';
    strSQL := strSQL + '  GER_UNIS11, ';
    strSQL := strSQL + '  GER_UNIS12, ';
    strSQL := strSQL + '  GER_UNIS13, ';
    strSQL := strSQL + '  GER_UNIS14, ';
    strSQL := strSQL + '  GER_UNIS15, ';
    strSQL := strSQL + '  GER_UNIS16, ';
    strSQL := strSQL + '  GER_UNIS17, ';
    strSQL := strSQL + '  GER_UNIS18, ';
    strSQL := strSQL + '  GER_UNIS19, ';
    strSQL := strSQL + '  GER_UNIS20, ';
    strSQL := strSQL + '  GER_UNIS21, ';
    strSQL := strSQL + '  GER_UNIS22, ';
    strSQL := strSQL + '  GER_UNIS23, ';
    strSQL := strSQL + '  GER_UNIS24, ';
    strSQL := strSQL + '  GER_UNIS25, ';
    strSQL := strSQL + '  GER_UNIS26, ';
    strSQL := strSQL + '  GER_UNIS27, ';
    strSQL := strSQL + '  GER_UNIS28, ';
    strSQL := strSQL + '  GER_UNIS29, ';
    strSQL := strSQL + '  GER_UNIS30, ';

    strSQL := strSQL + '  GER_VALS01, ';
    strSQL := strSQL + '  GER_VALS02, ';
    strSQL := strSQL + '  GER_VALS03, ';
    strSQL := strSQL + '  GER_VALS04, ';
    strSQL := strSQL + '  GER_VALS05, ';
    strSQL := strSQL + '  GER_VALS06, ';
    strSQL := strSQL + '  GER_VALS07, ';
    strSQL := strSQL + '  GER_VALS08, ';
    strSQL := strSQL + '  GER_VALS09, ';
    strSQL := strSQL + '  GER_VALS10, ';
    strSQL := strSQL + '  GER_VALS11, ';
    strSQL := strSQL + '  GER_VALS12, ';
    strSQL := strSQL + '  GER_VALS13, ';
    strSQL := strSQL + '  GER_VALS14, ';
    strSQL := strSQL + '  GER_VALS15, ';
    strSQL := strSQL + '  GER_VALS16, ';
    strSQL := strSQL + '  GER_VALS17, ';
    strSQL := strSQL + '  GER_VALS18, ';
    strSQL := strSQL + '  GER_VALS19, ';
    strSQL := strSQL + '  GER_VALS20, ';
    strSQL := strSQL + '  GER_VALS21, ';
    strSQL := strSQL + '  GER_VALS22, ';
    strSQL := strSQL + '  GER_VALS23, ';
    strSQL := strSQL + '  GER_VALS24, ';
    strSQL := strSQL + '  GER_VALS25, ';
    strSQL := strSQL + '  GER_VALS26, ';
    strSQL := strSQL + '  GER_VALS27, ';
    strSQL := strSQL + '  GER_VALS28, ';
    strSQL := strSQL + '  GER_VALS29, ';
    strSQL := strSQL + '  GER_VALS30, ';

    strSQL := strSQL + '  GER_DECS01, ';
    strSQL := strSQL + '  GER_DECS02, ';
    strSQL := strSQL + '  GER_DECS03, ';
    strSQL := strSQL + '  GER_DECS04, ';
    strSQL := strSQL + '  GER_DECS05, ';
    strSQL := strSQL + '  GER_DECS06, ';
    strSQL := strSQL + '  GER_DECS07, ';
    strSQL := strSQL + '  GER_DECS08, ';
    strSQL := strSQL + '  GER_DECS09, ';
    strSQL := strSQL + '  GER_DECS10, ';
    strSQL := strSQL + '  GER_DECS11, ';
    strSQL := strSQL + '  GER_DECS12, ';
    strSQL := strSQL + '  GER_DECS13, ';
    strSQL := strSQL + '  GER_DECS14, ';
    strSQL := strSQL + '  GER_DECS15, ';
    strSQL := strSQL + '  GER_DECS16, ';
    strSQL := strSQL + '  GER_DECS17, ';
    strSQL := strSQL + '  GER_DECS18, ';
    strSQL := strSQL + '  GER_DECS19, ';
    strSQL := strSQL + '  GER_DECS20, ';
    strSQL := strSQL + '  GER_DECS21, ';
    strSQL := strSQL + '  GER_DECS22, ';
    strSQL := strSQL + '  GER_DECS23, ';
    strSQL := strSQL + '  GER_DECS24, ';
    strSQL := strSQL + '  GER_DECS25, ';
    strSQL := strSQL + '  GER_DECS26, ';
    strSQL := strSQL + '  GER_DECS27, ';
    strSQL := strSQL + '  GER_DECS28, ';
    strSQL := strSQL + '  GER_DECS29, ';
    strSQL := strSQL + '  GER_DECS30, ';

    strSQL := strSQL + '  GER_IDES01, ';
    strSQL := strSQL + '  GER_IDES02, ';
    strSQL := strSQL + '  GER_IDES03, ';
    strSQL := strSQL + '  GER_IDES04, ';
    strSQL := strSQL + '  GER_IDES05, ';
    strSQL := strSQL + '  GER_IDES06, ';
    strSQL := strSQL + '  GER_IDES07, ';
    strSQL := strSQL + '  GER_IDES08, ';
    strSQL := strSQL + '  GER_IDES09, ';
    strSQL := strSQL + '  GER_IDES10, ';
    strSQL := strSQL + '  GER_IDES11, ';
    strSQL := strSQL + '  GER_IDES12, ';
    strSQL := strSQL + '  GER_IDES13, ';
    strSQL := strSQL + '  GER_IDES14, ';
    strSQL := strSQL + '  GER_IDES15, ';
    strSQL := strSQL + '  GER_IDES16, ';
    strSQL := strSQL + '  GER_IDES17, ';
    strSQL := strSQL + '  GER_IDES18, ';
    strSQL := strSQL + '  GER_IDES19, ';
    strSQL := strSQL + '  GER_IDES20, ';
    strSQL := strSQL + '  GER_IDES21, ';
    strSQL := strSQL + '  GER_IDES22, ';
    strSQL := strSQL + '  GER_IDES23, ';
    strSQL := strSQL + '  GER_IDES24, ';
    strSQL := strSQL + '  GER_IDES25, ';
    strSQL := strSQL + '  GER_IDES26, ';
    strSQL := strSQL + '  GER_IDES27, ';
    strSQL := strSQL + '  GER_IDES28, ';
    strSQL := strSQL + '  GER_IDES29, ';
    strSQL := strSQL + '  GER_IDES30, ';

    strSQL := strSQL + '  GER_BRIS01, ';
    strSQL := strSQL + '  GER_BRIS02, ';
    strSQL := strSQL + '  GER_BRIS03, ';
    strSQL := strSQL + '  GER_BRIS04, ';
    strSQL := strSQL + '  GER_BRIS05, ';
    strSQL := strSQL + '  GER_BRIS06, ';
    strSQL := strSQL + '  GER_BRIS07, ';
    strSQL := strSQL + '  GER_BRIS08, ';
    strSQL := strSQL + '  GER_BRIS09, ';
    strSQL := strSQL + '  GER_BRIS10, ';
    strSQL := strSQL + '  GER_BRIS11, ';
    strSQL := strSQL + '  GER_BRIS12, ';
    strSQL := strSQL + '  GER_BRIS13, ';
    strSQL := strSQL + '  GER_BRIS14, ';
    strSQL := strSQL + '  GER_BRIS15, ';
    strSQL := strSQL + '  GER_BRIS16, ';
    strSQL := strSQL + '  GER_BRIS17, ';
    strSQL := strSQL + '  GER_BRIS18, ';
    strSQL := strSQL + '  GER_BRIS19, ';
    strSQL := strSQL + '  GER_BRIS20, ';
    strSQL := strSQL + '  GER_BRIS21, ';
    strSQL := strSQL + '  GER_BRIS22, ';
    strSQL := strSQL + '  GER_BRIS23, ';
    strSQL := strSQL + '  GER_BRIS24, ';
    strSQL := strSQL + '  GER_BRIS25, ';
    strSQL := strSQL + '  GER_BRIS26, ';
    strSQL := strSQL + '  GER_BRIS27, ';
    strSQL := strSQL + '  GER_BRIS28, ';
    strSQL := strSQL + '  GER_BRIS29, ';
    strSQL := strSQL + '  GER_BRIS30, ';

    strSQL := strSQL + '  GER_PARS01, ';
    strSQL := strSQL + '  GER_PARS02, ';
    strSQL := strSQL + '  GER_PARS03, ';
    strSQL := strSQL + '  GER_PARS04, ';
    strSQL := strSQL + '  GER_PARS05, ';
    strSQL := strSQL + '  GER_PARS06, ';
    strSQL := strSQL + '  GER_PARS07, ';
    strSQL := strSQL + '  GER_PARS08, ';
    strSQL := strSQL + '  GER_PARS09, ';
    strSQL := strSQL + '  GER_PARS10, ';
    strSQL := strSQL + '  GER_PARS11, ';
    strSQL := strSQL + '  GER_PARS12, ';
    strSQL := strSQL + '  GER_PARS13, ';
    strSQL := strSQL + '  GER_PARS14, ';
    strSQL := strSQL + '  GER_PARS15, ';
    strSQL := strSQL + '  GER_PARS16, ';
    strSQL := strSQL + '  GER_PARS17, ';
    strSQL := strSQL + '  GER_PARS18, ';
    strSQL := strSQL + '  GER_PARS19, ';
    strSQL := strSQL + '  GER_PARS20, ';
    strSQL := strSQL + '  GER_PARS21, ';
    strSQL := strSQL + '  GER_PARS22, ';
    strSQL := strSQL + '  GER_PARS23, ';
    strSQL := strSQL + '  GER_PARS24, ';
    strSQL := strSQL + '  GER_PARS25, ';
    strSQL := strSQL + '  GER_PARS26, ';
    strSQL := strSQL + '  GER_PARS27, ';
    strSQL := strSQL + '  GER_PARS28, ';
    strSQL := strSQL + '  GER_PARS29, ';
    strSQL := strSQL + '  GER_PARS30, ';

    strSQL := strSQL + '  GER_TBRS01, ';
    strSQL := strSQL + '  GER_TBRS02, ';
    strSQL := strSQL + '  GER_TBRS03, ';
    strSQL := strSQL + '  GER_TBRS04, ';
    strSQL := strSQL + '  GER_TBRS05, ';
    strSQL := strSQL + '  GER_TBRS06, ';
    strSQL := strSQL + '  GER_TBRS07, ';
    strSQL := strSQL + '  GER_TBRS08, ';
    strSQL := strSQL + '  GER_TBRS09, ';
    strSQL := strSQL + '  GER_TBRS10, ';
    strSQL := strSQL + '  GER_TBRS11, ';
    strSQL := strSQL + '  GER_TBRS12, ';
    strSQL := strSQL + '  GER_TBRS13, ';
    strSQL := strSQL + '  GER_TBRS14, ';
    strSQL := strSQL + '  GER_TBRS15, ';
    strSQL := strSQL + '  GER_TBRS16, ';
    strSQL := strSQL + '  GER_TBRS17, ';
    strSQL := strSQL + '  GER_TBRS18, ';
    strSQL := strSQL + '  GER_TBRS19, ';
    strSQL := strSQL + '  GER_TBRS20, ';
    strSQL := strSQL + '  GER_TBRS21, ';
    strSQL := strSQL + '  GER_TBRS22, ';
    strSQL := strSQL + '  GER_TBRS23, ';
    strSQL := strSQL + '  GER_TBRS24, ';
    strSQL := strSQL + '  GER_TBRS25, ';
    strSQL := strSQL + '  GER_TBRS26, ';
    strSQL := strSQL + '  GER_TBRS27, ';
    strSQL := strSQL + '  GER_TBRS28, ';
    strSQL := strSQL + '  GER_TBRS29, ';
    strSQL := strSQL + '  GER_TBRS30, ';

    strSQL := strSQL + '  GER_VENS01, ';
    strSQL := strSQL + '  GER_VENS02, ';
    strSQL := strSQL + '  GER_VENS03, ';
    strSQL := strSQL + '  GER_VENS04, ';
    strSQL := strSQL + '  GER_VENS05, ';
    strSQL := strSQL + '  GER_VENS06, ';
    strSQL := strSQL + '  GER_VENS07, ';
    strSQL := strSQL + '  GER_VENS08, ';
    strSQL := strSQL + '  GER_VENS09, ';
    strSQL := strSQL + '  GER_VENS10, ';
    strSQL := strSQL + '  GER_VENS11, ';
    strSQL := strSQL + '  GER_VENS12, ';
    strSQL := strSQL + '  GER_VENS13, ';
    strSQL := strSQL + '  GER_VENS14, ';
    strSQL := strSQL + '  GER_VENS15, ';
    strSQL := strSQL + '  GER_VENS16, ';
    strSQL := strSQL + '  GER_VENS17, ';
    strSQL := strSQL + '  GER_VENS18, ';
    strSQL := strSQL + '  GER_VENS19, ';
    strSQL := strSQL + '  GER_VENS20, ';
    strSQL := strSQL + '  GER_VENS21, ';
    strSQL := strSQL + '  GER_VENS22, ';
    strSQL := strSQL + '  GER_VENS23, ';
    strSQL := strSQL + '  GER_VENS24, ';
    strSQL := strSQL + '  GER_VENS25, ';
    strSQL := strSQL + '  GER_VENS26, ';
    strSQL := strSQL + '  GER_VENS27, ';
    strSQL := strSQL + '  GER_VENS28, ';
    strSQL := strSQL + '  GER_VENS29, ';
    strSQL := strSQL + '  GER_VENS30, ';

    strSQL := strSQL + '  GER_VE2S01, ';
    strSQL := strSQL + '  GER_VE2S02, ';
    strSQL := strSQL + '  GER_VE2S03, ';
    strSQL := strSQL + '  GER_VE2S04, ';
    strSQL := strSQL + '  GER_VE2S05, ';
    strSQL := strSQL + '  GER_VE2S06, ';
    strSQL := strSQL + '  GER_VE2S07, ';
    strSQL := strSQL + '  GER_VE2S08, ';
    strSQL := strSQL + '  GER_VE2S09, ';
    strSQL := strSQL + '  GER_VE2S10, ';
    strSQL := strSQL + '  GER_VE2S11, ';
    strSQL := strSQL + '  GER_VE2S12, ';
    strSQL := strSQL + '  GER_VE2S13, ';
    strSQL := strSQL + '  GER_VE2S14, ';
    strSQL := strSQL + '  GER_VE2S15, ';
    strSQL := strSQL + '  GER_VE2S16, ';
    strSQL := strSQL + '  GER_VE2S17, ';
    strSQL := strSQL + '  GER_VE2S18, ';
    strSQL := strSQL + '  GER_VE2S19, ';
    strSQL := strSQL + '  GER_VE2S20, ';
    strSQL := strSQL + '  GER_VE2S21, ';
    strSQL := strSQL + '  GER_VE2S22, ';
    strSQL := strSQL + '  GER_VE2S23, ';
    strSQL := strSQL + '  GER_VE2S24, ';
    strSQL := strSQL + '  GER_VE2S25, ';
    strSQL := strSQL + '  GER_VE2S26, ';
    strSQL := strSQL + '  GER_VE2S27, ';
    strSQL := strSQL + '  GER_VE2S28, ';
  strSQL := strSQL + '  GER_VE2S29, ';
  strSQL := strSQL + '  GER_VE2S30, ';

  strSQL := strSQL + '  GER_DESACE, ';
  strSQL := strSQL + '  GER_TOTFRE, ';
  strSQL := strSQL + '  GER_CODEMP, ';
  strSQL := strSQL + '  GER_CODCND, ';
    strSQL := strSQL + '  GER_CONPAG, ';
    strSQL := strSQL + '  GER_CODFPG, ';
    strSQL := strSQL + '  GER_TIPFRE, ';
    strSQL := strSQL + '  GER_MEN001, ';
    strSQL := strSQL + '  GER_MEN002, ';
    strSQL := strSQL + '  GER_MEN003, ';
    strSQL := strSQL + '  GER_MEN004, ';
    strSQL := strSQL + '  GER_MEN005, ';
    strSQL := strSQL + '  AUX_DUPREC, ';
    strSQL := strSQL + '  "MOVGER" AS GER_TABELA, ';
    strSQL := strSQL + '  MOVGER.AUTOINCREM AS GER_AUTINC, ';
    strSQL := strSQL + '  GER_CLAFIS, ';
    strSQL := strSQL + '  GER_CODCLI, ';
    strSQL := strSQL + fGetSQLQtdRef + ' AS GER_QTDREF, ';
    strSQL := strSQL + fGetSQLDVNaoEhDocumentoConfirmado('MOVGER.AUTOINCREM') + ' AS GER_DEVCNF, ';
    strSQL := strSQL + '  AUX_VENPRE, ';
    strSQL := strSQL + '  GER_ENTFUT, ';
    strSQL := strSQL + '  AUX_EDIPES, ';
    strSQL := strSQL + '  GER_CONSUM, ';
    strSQL := strSQL + '  AUX_CODEMB, ';
    strSQL := strSQL + '  AUX_TPOPER, ';
    strSQL := strSQL + '  AUX_FRECOT, ';
    strSQL := strSQL + '  AUX_CODPRJ,  ';
    strSQL := strSQL + '  MOV_DISSER  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVGER ';
    strSQL := strSQL + '  LEFT JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM ';
    strSQL := strSQL + '  LEFT JOIN SERMOV ON GER_SEQGER = MOVGER.AUTOINCREM ';
    strSQL := strSQL + '  LEFT JOIN MOVOBS ON MOV_SEQGER = MOVGER.AUTOINCREM ';
    strSQL := strSQL + 'WHERE ';

    if FCarregaItensJaFaturado then
      strSQL := strSQL + '  GER_JAFATU = TRUE AND '+
                         '  GER_NUMDOC = GER_NUMFAT AND '
    Else
      strSQL := strSQL + '  GER_JAFATU = FALSE AND ';

    strSQL := strSQL + '  GER_CODCLI = :CODCLI AND ';

    If (Not fEmptyStr(FCliSeg)) And (Not fSintetizarItensNaConfirmacaoDeDocumentos) Then
      strSQL := strSQL + '  GER_NOMCON LIKE :NOMCON AND ';

    If (Not fEmptyStr(FNumDoc)) (*And (Not fGetSintetizarDV)*) Then
      strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';

    If (Not fEmptyStr(FEspDoc)) (*And (Not fGetSintetizarDV)*) Then
      strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';

    If FDtaFim > 0 (*And (Not fGetSintetizarDV)*) Then
      strSQL := strSQL + '  GER_DTAENT BETWEEN :DTAINI AND :DTAFIN AND';

    If (fCfgSis('ENTTRO', varBoolean)) Or (blnConsiderarDV) Or (blnEstornoNotaFiscal) Then
    Begin

      strSQL := strSQL + ' ( (GER_ESPDOC = "MI"  ';

      If (intDiaMis > 0) Then
        strSQL := strSQL + ' AND GER_DTAENT > CAST("' + FormatDateTime('yyyy-mm-dd', VS_Date - intDiaMis) + '" AS DATE) ';

      strSQL := strSQL + ' ) ';

      If (blnConsiderarDV) Then
        strSQL := strSQL + ' OR GER_ESPDOC = "DV" ';

      If (blnEstornoNotaFiscal) Then
        strSQL := strSQL + ' OR GER_ESPDOC = "NF" ';

      If (fCfgSis('ENTTRO', varBoolean)) Then
        strSQL := strSQL + ' OR GER_ESPDOC = "TR" ';

      strSQL := strSQL + ' ) AND ';

    End
    Else
    Begin

      strSQL := strSQL + '  GER_ESPDOC = "MI" AND ';

      If (intDiaMis > 0) Then
        strSQL := strSQL + ' GER_DTAENT > CAST("' + FormatDateTime('yyyy-mm-dd', VS_Date - intDiaMis) + '" AS DATE) AND ';

    End;

    strSQL := strSQL + '  GER_CONPAG = "01000" ';

    If (blnFiltrarEmp) Then
      strSQL := strSQL + '  AND GER_CODEMP = :CODEMP ';

    if not fEmptyStr(FAutoIncrenEnderecoEntrega) then
      strSQL := strSQL + ' AND AUXMOV.AUX_ENTGER = :ENTGER ';

    strSQL := strSQL + ' UNION ALL ';

    {*******************************************}
    {* PEGA TODAS AS FF ->E<- TODAS AS MI À    *}
    {* PRAZO                                   *}
    {****************************************MV*}
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  GER_NOMCON, ';
    strSQL := strSQL + '  GER_NUMDOC, ';
    strSQL := strSQL + '  GER_ESPDOC, ';
    strSQL := strSQL + '  GER_DTAENT, ';
    strSQL := strSQL + '  GER_JAFATU, ';
    strSQL := strSQL + '  GER_CODVEN, ';
    strSQL := strSQL + '  GER_DESESP, ';
    strSQL := strSQL + '  GER_VLRCON, ';
    strSQL := strSQL + '  GER_ENTFAT, ';
    strSQL := strSQL + '  GER_CODTRA, ';

    strSQL := strSQL + '  AUX_CODFAZ AS GER_CODFAZ, ';
    strSQL := strSQL + '  AUX_FASOBR AS GER_FASOBR, ';
    strSQL := strSQL + '  AUX_PLAVEI, ';
    strSQL := strSQL + '  AUX_KM_VEI, ';

    strSQL := strSQL + '  GER_CODS01, ';
    strSQL := strSQL + '  GER_CODS02, ';
    strSQL := strSQL + '  GER_CODS03, ';
    strSQL := strSQL + '  GER_CODS04, ';
    strSQL := strSQL + '  GER_CODS05, ';
    strSQL := strSQL + '  GER_CODS06, ';
    strSQL := strSQL + '  GER_CODS07, ';
    strSQL := strSQL + '  GER_CODS08, ';
    strSQL := strSQL + '  GER_CODS09, ';
    strSQL := strSQL + '  GER_CODS10, ';
    strSQL := strSQL + '  GER_CODS11, ';
    strSQL := strSQL + '  GER_CODS12, ';
    strSQL := strSQL + '  GER_CODS13, ';
    strSQL := strSQL + '  GER_CODS14, ';
    strSQL := strSQL + '  GER_CODS15, ';
    strSQL := strSQL + '  GER_CODS16, ';
    strSQL := strSQL + '  GER_CODS17, ';
    strSQL := strSQL + '  GER_CODS18, ';
    strSQL := strSQL + '  GER_CODS19, ';
    strSQL := strSQL + '  GER_CODS20, ';
    strSQL := strSQL + '  GER_CODS21, ';
    strSQL := strSQL + '  GER_CODS22, ';
    strSQL := strSQL + '  GER_CODS23, ';
    strSQL := strSQL + '  GER_CODS24, ';
    strSQL := strSQL + '  GER_CODS25, ';
    strSQL := strSQL + '  GER_CODS26, ';
    strSQL := strSQL + '  GER_CODS27, ';
    strSQL := strSQL + '  GER_CODS28, ';
    strSQL := strSQL + '  GER_CODS29, ';
    strSQL := strSQL + '  GER_CODS30, ';

    strSQL := strSQL + '  GER_DESS01, ';
    strSQL := strSQL + '  GER_DESS02, ';
    strSQL := strSQL + '  GER_DESS03, ';
    strSQL := strSQL + '  GER_DESS04, ';
    strSQL := strSQL + '  GER_DESS05, ';
    strSQL := strSQL + '  GER_DESS06, ';
    strSQL := strSQL + '  GER_DESS07, ';
    strSQL := strSQL + '  GER_DESS08, ';
    strSQL := strSQL + '  GER_DESS09, ';
    strSQL := strSQL + '  GER_DESS10, ';
    strSQL := strSQL + '  GER_DESS11, ';
    strSQL := strSQL + '  GER_DESS12, ';
    strSQL := strSQL + '  GER_DESS13, ';
    strSQL := strSQL + '  GER_DESS14, ';
    strSQL := strSQL + '  GER_DESS15, ';
    strSQL := strSQL + '  GER_DESS16, ';
    strSQL := strSQL + '  GER_DESS17, ';
    strSQL := strSQL + '  GER_DESS18, ';
    strSQL := strSQL + '  GER_DESS19, ';
    strSQL := strSQL + '  GER_DESS20, ';
    strSQL := strSQL + '  GER_DESS21, ';
    strSQL := strSQL + '  GER_DESS22, ';
    strSQL := strSQL + '  GER_DESS23, ';
    strSQL := strSQL + '  GER_DESS24, ';
    strSQL := strSQL + '  GER_DESS25, ';
    strSQL := strSQL + '  GER_DESS26, ';
    strSQL := strSQL + '  GER_DESS27, ';
    strSQL := strSQL + '  GER_DESS28, ';
    strSQL := strSQL + '  GER_DESS29, ';
    strSQL := strSQL + '  GER_DESS30, ';

    strSQL := strSQL + '  GER_QTDS01, ';
    strSQL := strSQL + '  GER_QTDS02, ';
    strSQL := strSQL + '  GER_QTDS03, ';
    strSQL := strSQL + '  GER_QTDS04, ';
    strSQL := strSQL + '  GER_QTDS05, ';
    strSQL := strSQL + '  GER_QTDS06, ';
    strSQL := strSQL + '  GER_QTDS07, ';
    strSQL := strSQL + '  GER_QTDS08, ';
    strSQL := strSQL + '  GER_QTDS09, ';
    strSQL := strSQL + '  GER_QTDS10, ';
    strSQL := strSQL + '  GER_QTDS11, ';
    strSQL := strSQL + '  GER_QTDS12, ';
    strSQL := strSQL + '  GER_QTDS13, ';
    strSQL := strSQL + '  GER_QTDS14, ';
    strSQL := strSQL + '  GER_QTDS15, ';
    strSQL := strSQL + '  GER_QTDS16, ';
    strSQL := strSQL + '  GER_QTDS17, ';
    strSQL := strSQL + '  GER_QTDS18, ';
    strSQL := strSQL + '  GER_QTDS19, ';
    strSQL := strSQL + '  GER_QTDS20, ';
    strSQL := strSQL + '  GER_QTDS21, ';
    strSQL := strSQL + '  GER_QTDS22, ';
    strSQL := strSQL + '  GER_QTDS23, ';
    strSQL := strSQL + '  GER_QTDS24, ';
    strSQL := strSQL + '  GER_QTDS25, ';
    strSQL := strSQL + '  GER_QTDS26, ';
    strSQL := strSQL + '  GER_QTDS27, ';
    strSQL := strSQL + '  GER_QTDS28, ';
    strSQL := strSQL + '  GER_QTDS29, ';
    strSQL := strSQL + '  GER_QTDS30, ';

    strSQL := strSQL + '  GER_UNIS01, ';
    strSQL := strSQL + '  GER_UNIS02, ';
    strSQL := strSQL + '  GER_UNIS03, ';
    strSQL := strSQL + '  GER_UNIS04, ';
    strSQL := strSQL + '  GER_UNIS05, ';
    strSQL := strSQL + '  GER_UNIS06, ';
    strSQL := strSQL + '  GER_UNIS07, ';
    strSQL := strSQL + '  GER_UNIS08, ';
    strSQL := strSQL + '  GER_UNIS09, ';
    strSQL := strSQL + '  GER_UNIS10, ';
    strSQL := strSQL + '  GER_UNIS11, ';
    strSQL := strSQL + '  GER_UNIS12, ';
    strSQL := strSQL + '  GER_UNIS13, ';
    strSQL := strSQL + '  GER_UNIS14, ';
    strSQL := strSQL + '  GER_UNIS15, ';
    strSQL := strSQL + '  GER_UNIS16, ';
    strSQL := strSQL + '  GER_UNIS17, ';
    strSQL := strSQL + '  GER_UNIS18, ';
    strSQL := strSQL + '  GER_UNIS19, ';
    strSQL := strSQL + '  GER_UNIS20, ';
    strSQL := strSQL + '  GER_UNIS21, ';
    strSQL := strSQL + '  GER_UNIS22, ';
    strSQL := strSQL + '  GER_UNIS23, ';
    strSQL := strSQL + '  GER_UNIS24, ';
    strSQL := strSQL + '  GER_UNIS25, ';
    strSQL := strSQL + '  GER_UNIS26, ';
    strSQL := strSQL + '  GER_UNIS27, ';
    strSQL := strSQL + '  GER_UNIS28, ';
    strSQL := strSQL + '  GER_UNIS29, ';
    strSQL := strSQL + '  GER_UNIS30, ';

    strSQL := strSQL + '  GER_VALS01, ';
    strSQL := strSQL + '  GER_VALS02, ';
    strSQL := strSQL + '  GER_VALS03, ';
    strSQL := strSQL + '  GER_VALS04, ';
    strSQL := strSQL + '  GER_VALS05, ';
    strSQL := strSQL + '  GER_VALS06, ';
    strSQL := strSQL + '  GER_VALS07, ';
    strSQL := strSQL + '  GER_VALS08, ';
    strSQL := strSQL + '  GER_VALS09, ';
    strSQL := strSQL + '  GER_VALS10, ';
    strSQL := strSQL + '  GER_VALS11, ';
    strSQL := strSQL + '  GER_VALS12, ';
    strSQL := strSQL + '  GER_VALS13, ';
    strSQL := strSQL + '  GER_VALS14, ';
    strSQL := strSQL + '  GER_VALS15, ';
    strSQL := strSQL + '  GER_VALS16, ';
    strSQL := strSQL + '  GER_VALS17, ';
    strSQL := strSQL + '  GER_VALS18, ';
    strSQL := strSQL + '  GER_VALS19, ';
    strSQL := strSQL + '  GER_VALS20, ';
    strSQL := strSQL + '  GER_VALS21, ';
    strSQL := strSQL + '  GER_VALS22, ';
    strSQL := strSQL + '  GER_VALS23, ';
    strSQL := strSQL + '  GER_VALS24, ';
    strSQL := strSQL + '  GER_VALS25, ';
    strSQL := strSQL + '  GER_VALS26, ';
    strSQL := strSQL + '  GER_VALS27, ';
    strSQL := strSQL + '  GER_VALS28, ';
    strSQL := strSQL + '  GER_VALS29, ';
    strSQL := strSQL + '  GER_VALS30, ';

    strSQL := strSQL + '  GER_DECS01, ';
    strSQL := strSQL + '  GER_DECS02, ';
    strSQL := strSQL + '  GER_DECS03, ';
    strSQL := strSQL + '  GER_DECS04, ';
    strSQL := strSQL + '  GER_DECS05, ';
    strSQL := strSQL + '  GER_DECS06, ';
    strSQL := strSQL + '  GER_DECS07, ';
    strSQL := strSQL + '  GER_DECS08, ';
    strSQL := strSQL + '  GER_DECS09, ';
    strSQL := strSQL + '  GER_DECS10, ';
    strSQL := strSQL + '  GER_DECS11, ';
    strSQL := strSQL + '  GER_DECS12, ';
    strSQL := strSQL + '  GER_DECS13, ';
    strSQL := strSQL + '  GER_DECS14, ';
    strSQL := strSQL + '  GER_DECS15, ';
    strSQL := strSQL + '  GER_DECS16, ';
    strSQL := strSQL + '  GER_DECS17, ';
    strSQL := strSQL + '  GER_DECS18, ';
    strSQL := strSQL + '  GER_DECS19, ';
    strSQL := strSQL + '  GER_DECS20, ';
    strSQL := strSQL + '  GER_DECS21, ';
    strSQL := strSQL + '  GER_DECS22, ';
    strSQL := strSQL + '  GER_DECS23, ';
    strSQL := strSQL + '  GER_DECS24, ';
    strSQL := strSQL + '  GER_DECS25, ';
    strSQL := strSQL + '  GER_DECS26, ';
    strSQL := strSQL + '  GER_DECS27, ';
    strSQL := strSQL + '  GER_DECS28, ';
    strSQL := strSQL + '  GER_DECS29, ';
    strSQL := strSQL + '  GER_DECS30, ';

    strSQL := strSQL + '  GER_IDES01, ';
    strSQL := strSQL + '  GER_IDES02, ';
    strSQL := strSQL + '  GER_IDES03, ';
    strSQL := strSQL + '  GER_IDES04, ';
    strSQL := strSQL + '  GER_IDES05, ';
    strSQL := strSQL + '  GER_IDES06, ';
    strSQL := strSQL + '  GER_IDES07, ';
    strSQL := strSQL + '  GER_IDES08, ';
    strSQL := strSQL + '  GER_IDES09, ';
    strSQL := strSQL + '  GER_IDES10, ';
    strSQL := strSQL + '  GER_IDES11, ';
    strSQL := strSQL + '  GER_IDES12, ';
    strSQL := strSQL + '  GER_IDES13, ';
    strSQL := strSQL + '  GER_IDES14, ';
    strSQL := strSQL + '  GER_IDES15, ';
    strSQL := strSQL + '  GER_IDES16, ';
    strSQL := strSQL + '  GER_IDES17, ';
    strSQL := strSQL + '  GER_IDES18, ';
    strSQL := strSQL + '  GER_IDES19, ';
    strSQL := strSQL + '  GER_IDES20, ';
    strSQL := strSQL + '  GER_IDES21, ';
    strSQL := strSQL + '  GER_IDES22, ';
    strSQL := strSQL + '  GER_IDES23, ';
    strSQL := strSQL + '  GER_IDES24, ';
    strSQL := strSQL + '  GER_IDES25, ';
    strSQL := strSQL + '  GER_IDES26, ';
    strSQL := strSQL + '  GER_IDES27, ';
    strSQL := strSQL + '  GER_IDES28, ';
    strSQL := strSQL + '  GER_IDES29, ';
    strSQL := strSQL + '  GER_IDES30, ';

    strSQL := strSQL + '  GER_BRIS01, ';
    strSQL := strSQL + '  GER_BRIS02, ';
    strSQL := strSQL + '  GER_BRIS03, ';
    strSQL := strSQL + '  GER_BRIS04, ';
    strSQL := strSQL + '  GER_BRIS05, ';
    strSQL := strSQL + '  GER_BRIS06, ';
    strSQL := strSQL + '  GER_BRIS07, ';
    strSQL := strSQL + '  GER_BRIS08, ';
    strSQL := strSQL + '  GER_BRIS09, ';
    strSQL := strSQL + '  GER_BRIS10, ';
    strSQL := strSQL + '  GER_BRIS11, ';
    strSQL := strSQL + '  GER_BRIS12, ';
    strSQL := strSQL + '  GER_BRIS13, ';
    strSQL := strSQL + '  GER_BRIS14, ';
    strSQL := strSQL + '  GER_BRIS15, ';
    strSQL := strSQL + '  GER_BRIS16, ';
    strSQL := strSQL + '  GER_BRIS17, ';
    strSQL := strSQL + '  GER_BRIS18, ';
    strSQL := strSQL + '  GER_BRIS19, ';
    strSQL := strSQL + '  GER_BRIS20, ';
    strSQL := strSQL + '  GER_BRIS21, ';
    strSQL := strSQL + '  GER_BRIS22, ';
    strSQL := strSQL + '  GER_BRIS23, ';
    strSQL := strSQL + '  GER_BRIS24, ';
    strSQL := strSQL + '  GER_BRIS25, ';
    strSQL := strSQL + '  GER_BRIS26, ';
    strSQL := strSQL + '  GER_BRIS27, ';
    strSQL := strSQL + '  GER_BRIS28, ';
    strSQL := strSQL + '  GER_BRIS29, ';
    strSQL := strSQL + '  GER_BRIS30, ';

    strSQL := strSQL + '  GER_PARS01, ';
    strSQL := strSQL + '  GER_PARS02, ';
    strSQL := strSQL + '  GER_PARS03, ';
    strSQL := strSQL + '  GER_PARS04, ';
    strSQL := strSQL + '  GER_PARS05, ';
    strSQL := strSQL + '  GER_PARS06, ';
    strSQL := strSQL + '  GER_PARS07, ';
    strSQL := strSQL + '  GER_PARS08, ';
    strSQL := strSQL + '  GER_PARS09, ';
    strSQL := strSQL + '  GER_PARS10, ';
    strSQL := strSQL + '  GER_PARS11, ';
    strSQL := strSQL + '  GER_PARS12, ';
    strSQL := strSQL + '  GER_PARS13, ';
    strSQL := strSQL + '  GER_PARS14, ';
    strSQL := strSQL + '  GER_PARS15, ';
    strSQL := strSQL + '  GER_PARS16, ';
    strSQL := strSQL + '  GER_PARS17, ';
    strSQL := strSQL + '  GER_PARS18, ';
    strSQL := strSQL + '  GER_PARS19, ';
    strSQL := strSQL + '  GER_PARS20, ';
    strSQL := strSQL + '  GER_PARS21, ';
    strSQL := strSQL + '  GER_PARS22, ';
    strSQL := strSQL + '  GER_PARS23, ';
    strSQL := strSQL + '  GER_PARS24, ';
    strSQL := strSQL + '  GER_PARS25, ';
    strSQL := strSQL + '  GER_PARS26, ';
    strSQL := strSQL + '  GER_PARS27, ';
    strSQL := strSQL + '  GER_PARS28, ';
    strSQL := strSQL + '  GER_PARS29, ';
    strSQL := strSQL + '  GER_PARS30, ';

    strSQL := strSQL + '  GER_TBRS01, ';
    strSQL := strSQL + '  GER_TBRS02, ';
    strSQL := strSQL + '  GER_TBRS03, ';
    strSQL := strSQL + '  GER_TBRS04, ';
    strSQL := strSQL + '  GER_TBRS05, ';
    strSQL := strSQL + '  GER_TBRS06, ';
    strSQL := strSQL + '  GER_TBRS07, ';
    strSQL := strSQL + '  GER_TBRS08, ';
    strSQL := strSQL + '  GER_TBRS09, ';
    strSQL := strSQL + '  GER_TBRS10, ';
    strSQL := strSQL + '  GER_TBRS11, ';
    strSQL := strSQL + '  GER_TBRS12, ';
    strSQL := strSQL + '  GER_TBRS13, ';
    strSQL := strSQL + '  GER_TBRS14, ';
    strSQL := strSQL + '  GER_TBRS15, ';
    strSQL := strSQL + '  GER_TBRS16, ';
    strSQL := strSQL + '  GER_TBRS17, ';
    strSQL := strSQL + '  GER_TBRS18, ';
    strSQL := strSQL + '  GER_TBRS19, ';
    strSQL := strSQL + '  GER_TBRS20, ';
    strSQL := strSQL + '  GER_TBRS21, ';
    strSQL := strSQL + '  GER_TBRS22, ';
    strSQL := strSQL + '  GER_TBRS23, ';
    strSQL := strSQL + '  GER_TBRS24, ';
    strSQL := strSQL + '  GER_TBRS25, ';
    strSQL := strSQL + '  GER_TBRS26, ';
    strSQL := strSQL + '  GER_TBRS27, ';
    strSQL := strSQL + '  GER_TBRS28, ';
    strSQL := strSQL + '  GER_TBRS29, ';
    strSQL := strSQL + '  GER_TBRS30, ';

    strSQL := strSQL + '  GER_VENS01, ';
    strSQL := strSQL + '  GER_VENS02, ';
    strSQL := strSQL + '  GER_VENS03, ';
    strSQL := strSQL + '  GER_VENS04, ';
    strSQL := strSQL + '  GER_VENS05, ';
    strSQL := strSQL + '  GER_VENS06, ';
    strSQL := strSQL + '  GER_VENS07, ';
    strSQL := strSQL + '  GER_VENS08, ';
    strSQL := strSQL + '  GER_VENS09, ';
    strSQL := strSQL + '  GER_VENS10, ';
    strSQL := strSQL + '  GER_VENS11, ';
    strSQL := strSQL + '  GER_VENS12, ';
    strSQL := strSQL + '  GER_VENS13, ';
    strSQL := strSQL + '  GER_VENS14, ';
    strSQL := strSQL + '  GER_VENS15, ';
    strSQL := strSQL + '  GER_VENS16, ';
    strSQL := strSQL + '  GER_VENS17, ';
    strSQL := strSQL + '  GER_VENS18, ';
    strSQL := strSQL + '  GER_VENS19, ';
    strSQL := strSQL + '  GER_VENS20, ';
    strSQL := strSQL + '  GER_VENS21, ';
    strSQL := strSQL + '  GER_VENS22, ';
    strSQL := strSQL + '  GER_VENS23, ';
    strSQL := strSQL + '  GER_VENS24, ';
    strSQL := strSQL + '  GER_VENS25, ';
    strSQL := strSQL + '  GER_VENS26, ';
    strSQL := strSQL + '  GER_VENS27, ';
    strSQL := strSQL + '  GER_VENS28, ';
    strSQL := strSQL + '  GER_VENS29, ';
    strSQL := strSQL + '  GER_VENS30, ';

    strSQL := strSQL + '  GER_VE2S01, ';
    strSQL := strSQL + '  GER_VE2S02, ';
    strSQL := strSQL + '  GER_VE2S03, ';
    strSQL := strSQL + '  GER_VE2S04, ';
    strSQL := strSQL + '  GER_VE2S05, ';
    strSQL := strSQL + '  GER_VE2S06, ';
    strSQL := strSQL + '  GER_VE2S07, ';
    strSQL := strSQL + '  GER_VE2S08, ';
    strSQL := strSQL + '  GER_VE2S09, ';
    strSQL := strSQL + '  GER_VE2S10, ';
    strSQL := strSQL + '  GER_VE2S11, ';
    strSQL := strSQL + '  GER_VE2S12, ';
    strSQL := strSQL + '  GER_VE2S13, ';
    strSQL := strSQL + '  GER_VE2S14, ';
    strSQL := strSQL + '  GER_VE2S15, ';
    strSQL := strSQL + '  GER_VE2S16, ';
    strSQL := strSQL + '  GER_VE2S17, ';
    strSQL := strSQL + '  GER_VE2S18, ';
    strSQL := strSQL + '  GER_VE2S19, ';
    strSQL := strSQL + '  GER_VE2S20, ';
    strSQL := strSQL + '  GER_VE2S21, ';
    strSQL := strSQL + '  GER_VE2S22, ';
    strSQL := strSQL + '  GER_VE2S23, ';
    strSQL := strSQL + '  GER_VE2S24, ';
    strSQL := strSQL + '  GER_VE2S25, ';
    strSQL := strSQL + '  GER_VE2S26, ';
    strSQL := strSQL + '  GER_VE2S27, ';
    strSQL := strSQL + '  GER_VE2S28, ';
  strSQL := strSQL + '  GER_VE2S29, ';
  strSQL := strSQL + '  GER_VE2S30, ';

  strSQL := strSQL + '  GER_DESACE, ';
  strSQL := strSQL + '  GER_TOTFRE, ';
  strSQL := strSQL + '  GER_CODEMP, ';
  strSQL := strSQL + '  GER_CODCND, ';
    strSQL := strSQL + '  GER_CONPAG, ';
    strSQL := strSQL + '  GER_CODFPG, ';
    strSQL := strSQL + '  GER_TIPFRE, ';
    strSQL := strSQL + '  GER_MEN001, ';
    strSQL := strSQL + '  GER_MEN002, ';
    strSQL := strSQL + '  GER_MEN003, ';
    strSQL := strSQL + '  GER_MEN004, ';
    strSQL := strSQL + '  GER_MEN005, ';
    strSQL := strSQL + '  AUX_DUPREC, ';
    strSQL := strSQL + '  "MOVGER" AS GER_TABELA, ';
    strSQL := strSQL + '  MOVGER.AUTOINCREM AS GER_AUTINC, ';
    strSQL := strSQL + '  GER_CLAFIS, ';
    strSQL := strSQL + '  GER_CODCLI, ';
    strSQL := strSQL + fGetSQLQtdRef + ' AS GER_QTDREF, ';
    strSQL := strSQL + fGetSQLDVNaoEhDocumentoConfirmado('MOVGER.AUTOINCREM') + ' AS GER_DEVCNF, ';
    strSQL := strSQL + '  AUX_VENPRE, ';
    strSQL := strSQL + '  GER_ENTFUT, ';
    strSQL := strSQL + '  AUX_EDIPES, ';
    strSQL := strSQL + '  GER_CONSUM, ';
    strSQL := strSQL + '  AUX_CODEMB, ';
    strSQL := strSQL + '  AUX_TPOPER, ';
    strSQL := strSQL + '  AUX_FRECOT, ';
    strSQL := strSQL + '  AUX_CODPRJ,  ';
    strSQL := strSQL + '  MOV_DISSER  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVGER ';
    strSQL := strSQL + '  LEFT JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM ';
    strSQL := strSQL + '  LEFT JOIN SERMOV ON GER_SEQGER = MOVGER.AUTOINCREM ';
    strSQL := strSQL + '  LEFT JOIN MOVOBS ON MOV_SEQGER = MOVGER.AUTOINCREM ';
    strSQL := strSQL + 'WHERE ';

    if FCarregaItensJaFaturado then
      strSQL := strSQL + '  GER_JAFATU = TRUE AND '+
                         '  GER_NUMDOC = GER_NUMFAT AND '
    Else
      strSQL := strSQL + '  GER_JAFATU = FALSE AND ';

    strSQL := strSQL + '  GER_CODCLI = :CODCLI AND ';

    If (Not fEmptyStr(FCliSeg)) And (Not fSintetizarItensNaConfirmacaoDeDocumentos) Then
      strSQL := strSQL + '  GER_NOMCON LIKE :NOMCON AND ';

    If (Not fEmptyStr(FNumDoc)) (*And (Not fGetSintetizarDV)*) Then
      strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';

    If (Not fEmptyStr(FEspDoc)) (*And (Not fGetSintetizarDV)*) Then
      strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';

    If FDtaFim > 0 (*And (Not fGetSintetizarDV)*) Then
      strSQL := strSQL + '  GER_DTAENT BETWEEN :DTAINI AND :DTAFIN AND';

    strSQL := strSQL + '  ((GER_ESPDOC = "FF") OR (';

    If (fCfgSis('ENTTRO', varBoolean)) Or (blnConsiderarDV) Or (blnEstornoNotaFiscal) Then
    Begin

      strSQL := strSQL + '  ( ';

      If (intDiaMis > 0) Then
        strSQL := strSQL + ' ( GER_ESPDOC = "MI"  AND GER_DTAENT > CAST("' + FormatDateTime('yyyy-mm-dd', VS_Date - intDiaMis) + '" AS DATE) ) '
      Else
        strSQL := strSQL + '   GER_ESPDOC = "MI" ';

      If (blnConsiderarDV) Then
        strSQL := strSQL + '   OR GER_ESPDOC = "DV" ';

      If (fCfgSis('ENTTRO', varBoolean)) Then
        strSQL := strSQL + '   OR GER_ESPDOC = "TR" ';

      If (blnEstornoNotaFiscal) Then
        strSQL := strSQL + '  OR GER_ESPDOC = "NF"';

      strSQL := strSQL + '   )) AND ';

    End
    Else
    Begin

      If (intDiaMis > 0) Then
        strSQL := strSQL + ' ( GER_ESPDOC = "MI"  AND GER_DTAENT > CAST("' + FormatDateTime('yyyy-mm-dd', VS_Date - intDiaMis) + '" AS DATE) ) ) AND '
      Else
        strSQL := strSQL + ' GER_ESPDOC = "MI" ) AND ';

    End;

    strSQL := strSQL + '  GER_CONPAG <> "01000") ';

    If (blnFiltrarEmp) Then
      strSQL := strSQL + ' AND GER_CODEMP = :CODEMP ';

    if not fEmptyStr(FAutoIncrenEnderecoEntrega) then
      strSQL := strSQL + ' AND AUXMOV.AUX_ENTGER = :ENTGER ';

    strSQL := strSQL + 'ORDER BY ';
    //strSQL := strSQL + '  1, 2, 28 ';
    strSQL := strSQL + '  GER_NOMCON, GER_NUMDOC, GER_ESPDOC, GER_CODEMP ';

    {*****************************************}
    {* MOVDET                                *}
    {**************************************MV*}
    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := FCodCli;

      If (Not fEmptyStr(FCliSeg)) And (Not fSintetizarItensNaConfirmacaoDeDocumentos) Then
        ParamByName('NOMCON').AsString := FCliSeg + '%';

      If (Not fEmptyStr(FNumDoc)) (*And (Not fGetSintetizarDV)*) Then
        ParamByName('NUMDOC').AsString := FNumDoc;

      If (Not fEmptyStr(FEspDoc)) (*And (Not fGetSintetizarDV)*) Then
        ParamByName('ESPDOC').AsString := FEspDoc;

      If FDtaFim > 0 (*And (Not fGetSintetizarDV)*) Then
      Begin
        ParamByName('DTAINI').AsDateTime := FDtaIni;
        ParamByName('DTAFIN').AsDateTime := FDtaFim;
      End;

      If (blnFiltrarEmp) Then
        ParamByName('CODEMP').AsString := IIF(FEmpDoc.IsEmpty, VS_strCodEmp, FEmpDoc);

      if not fEmptyStr(FAutoIncrenEnderecoEntrega) then
        ParamByName('ENTGER').AsString := FAutoIncrenEnderecoEntrega;

      Open;
    End;

    {*******************************************}
    {* PEGA TODAS AS MI À VISTA COM DATA DE    *}
    {* ENTRADA > (DATE - DIAMI)                *}
    {****************************************MV*}
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  MOVDET.*, ';
    strSQL := strSQL + fGetSQLIncDev + ' AS DET_INCDEV, ';
    strSQL := strSQL + fGetSQLTabDev + ' AS DET_TABDEV, ';
    strSQL := strSQL + '  0' + fSqlValorReformaRef('MOVREF', 'MOVDET.AUTOINCREM') + ' AS DET_VALREF, ';
    strSQL := strSQL + '  ' + fSqlCampoReformaRef('MOVREF', 'REF_CBSVAL', 'MOVDET.AUTOINCREM') + ' AS DET_VALCBS, ';
    strSQL := strSQL + '  ' + fSqlCampoReformaRef('MOVREF', 'REF_VALIBS', 'MOVDET.AUTOINCREM') + ' AS DET_VALIBS, ';
    strSQL := strSQL + '  ' + fSqlCampoReformaRef('MOVREF', 'REF_SELVAL', 'MOVDET.AUTOINCREM') + ' AS DET_VAL_IS, ';
    strSQL := strSQL + '  DET_UNIVIS, ';
    strSQL := strSQL + '  DET_TAXJUR, ';
    strSQL := strSQL + '  DET_VAL_RT, ';

    If fatVenda.fUtilizaVendaMadeiraOuVidroOuMetroLinear Then
    Begin
      strSQL := strSQL + '  DET_COMPEC, ';
      strSQL := strSQL + '  DET_LARPEC, ';
      strSQL := strSQL + '  DET_ESPPEC, ';

      strSQL := strSQL + '  DET_APAREL, ';
      strSQL := strSQL + '  DET_PERAPA, ';
      strSQL := strSQL + '  DET_BENEFI, ';
      strSQL := strSQL + '  DET_PERBEN, ';
    End;

    strSQL := strSQL + '  DET_NUMCMP, ';
    strSQL := strSQL + '  DET_NITCMP, ';
    strSQL := strSQL + '  DET_DTACMP, ';
    strSQL := strSQL + '  DET_NUMPLA, ';
    strSQL := strSQL + '  DET_PARNUM, ';
    strSQL := strSQL + '  DET_REQCOM, ';
    strSQL := strSQL + '  DET_DESNES, ';

    strSQL := strSQL + '  ITE_CODGRU, ';
    strSQL := strSQL + '  "N" AS DET_SINTET, ';
    strSQL := strSQL + '  DET_QTDITE AS SAV_QTDITE, ';
    strSQL := strSQL + '  DET_TOTCUS AS SAV_TOTCUS, ';
    strSQL := strSQL + '  DET_TOTITE AS SAV_TOTITE, ';
    strSQL := strSQL + '  DET_UNITAR AS SAV_UNITAR, ';
    strSQL := strSQL + '  DET_DESESP AS SAV_DESESP, ';

    strSQL := strSQL + ' (DET_TOTMED / DET_QTDITE) AS PREMED, ';
    strSQL := strSQL + ' (DET_IMPULT / DET_QTDITE) AS IMPULT, ';
    strSQL := strSQL + ' (DET_TOTULT / DET_QTDITE) AS PREULT, ';
    strSQL := strSQL + ' (DET_TOTCUS / DET_QTDITE) AS PRECUS, ';
    strSQL := strSQL + ' (DET_TOTCU2 / DET_QTDITE) AS PRECU2, ';
    strSQL := strSQL + ' (DET_OUTVAL / DET_QTDITE) AS OUTVAL, ';
    strSQL := strSQL + ' (DET_ICMSAI / (DET_TOTITE - DET_DESESP) * 100) AS ICMSAI, ';
    strSQL := strSQL + ' (DET_IMPFED / (DET_TOTITE - DET_DESESP) * 100) AS IMPFED, ';
    strSQL := strSQL + ' (DET_DESOPE / (DET_TOTITE - DET_DESESP) * 100) AS DESOPE, ';

    strSQL := strSQL + '  DET_CLIBUS, ';
    strSQL := strSQL + '  DET_PESLIQ, ';
    strSQL := strSQL + '  DET_ATIVAC, ';
    strSQL := strSQL + '  DET_SEQCOM, ';
    strSQL := strSQL + '  DET_EMPCAR, ';
    strSQL := strSQL + '  DET_VDESST, ';
    strSQL := strSQL + '  DET_MDESST, ';
    strSQL := strSQL + '  DET_FRECOT, ';
    strSQL := strSQL + '  DET_COMPLE, ';
    strSQL := strSQL + '  DET_INCDEV, ';

    If fCfgSis('NUMSER', varBoolean) Then
      strSQL := strSQL + '  (SELECT IF(COUNT(SER_SEQGER) > 0, "S", "N") FROM DETSER  WHERE SER_SEQGER = MOVDET.AUTOINCREM) AS DET_TEMSER, '
    Else
      strSQL := strSQL + '  "N" AS DET_TEMSER, ';

    strSQL := strSQL + '  MOVDET.AUTOINCREM AS DET_AUTOIN ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVDET ';
    strSQL := strSQL + '  JOIN MOVTRI ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER ';
    strSQL := strSQL + '  LEFT JOIN MOVAUX ON MOVDET.AUTOINCREM = MOVAUX.DET_SEQGER ';

    If Not fEmptyStr(FCliSeg) Then
      strSQL := strSQL + 'JOIN MOVGER G ON G.AUTOINCREM = DET_SEQGER ';

    strSQL := strSQL + 'JOIN CADITE ON ITE_CODITE = DET_CODITE ';

    If fatVenda.fUtilizaVendaMadeiraOuVidroOuMetroLinear Then
      strSQL := strSQL + ' LEFT JOIN MOVMAD M ON M.DET_SEQGER = MOVDET.AUTOINCREM  ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  DET_CODCLI = :CODCLI ';

    {* NÃO PODE MOSTRAR DOCUMENTOS DE BAIXA DE ENTREGA FUTURA *}
    strSQL := strSQL + '  AND (LOCATE(RIGHT(DET_CLAFIS, 3), ' + CLAFIS_ENTFUT_VEN_ABR + ') <= 0) ';

    If (Not fEmptyStr(FCliSeg)) And (Not fSintetizarItensNaConfirmacaoDeDocumentos) Then
      strSQL := strSQL + ' AND GER_NOMCON LIKE :NOMCON ';

    If (Not fEmptyStr(FNumDoc)) (*And (Not fGetSintetizarDV)*) Then
      strSQL := strSQL + ' AND DET_NUMDOC = :NUMDOC ';

    If (Not fEmptyStr(FEspDoc)) (*And (Not fGetSintetizarDV)*) Then
      strSQL := strSQL + ' AND DET_ESPDOC = :ESPDOC  ';

    If FDtaFim > 0 (*And (Not fGetSintetizarDV)*) Then
      strSQL := strSQL + ' AND DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

    strSQL := strSQL + '  AND IF((DET_SEQTIN IS NOT NULL AND DET_SEQTIN <> ""), DET_PROEMB <> "S", ' + fFiltroProEmb + ') ';

    if FCarregaItensJaFaturado then
      strSQL := strSQL + '  AND DET_JAFATU = TRUE '+
                         '  AND DET_NUMDOC = DET_NUMFAT '
    Else
      strSQL := strSQL + '  AND DET_JAFATU = FALSE ';

    If (fCfgSis('ENTTRO', varBoolean)) Or (blnConsiderarDV) Or (blnEstornoNotaFiscal) Then
    Begin

      strSQL := strSQL + ' AND ( (DET_ESPDOC = "MI"  ';

      If (intDiaMis > 0) Then
        strSQL := strSQL + ' AND DET_DTAENT > CAST("' + FormatDateTime('yyyy-mm-dd', VS_Date - intDiaMis) + '" AS DATE) ';

      strSQL := strSQL + ' ) ';

      If (blnConsiderarDV) Then
        strSQL := strSQL + ' OR DET_ESPDOC = "DV" ';

      If (blnEstornoNotaFiscal) Then
        strSQL := strSQL + ' OR DET_ESPDOC = "NF" ';

      If (fCfgSis('ENTTRO', varBoolean)) Then
        strSQL := strSQL + ' OR DET_ESPDOC = "TR" ';

      strSQL := strSQL + ' ) ';

    End
    Else
    Begin

      strSQL := strSQL + ' AND DET_ESPDOC = "MI" ';
      If (intDiaMis > 0)  Then
        strSQL := strSQL + ' AND DET_DTAENT > CAST("' + FormatDateTime('yyyy-mm-dd', VS_Date - intDiaMis) + '" AS DATE) ';

    End;

    strSQL := strSQL + ' AND DET_CONPAG = "01000" ';

    If (blnFiltrarEmp) Then
      strSQL := strSQL + ' AND DET_CODEMP = :CODEMP ';

    strSQL := strSQL + ' UNION ALL ';

    {*******************************************}
    {* PEGA TODAS AS FF ->E<- TODAS AS MI À    *}
    {* PRAZO                                   *}
    {****************************************MV*}
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  MOVDET.*, ';
    strSQL := strSQL + fGetSQLIncDev + ' AS DET_INCDEV, ';
    strSQL := strSQL + fGetSQLTabDev + ' AS DET_TABDEV, ';
    strSQL := strSQL + '  0' + fSqlValorReformaRef('MOVREF', 'MOVDET.AUTOINCREM') + ' AS DET_VALREF, ';
    strSQL := strSQL + '  ' + fSqlCampoReformaRef('MOVREF', 'REF_CBSVAL', 'MOVDET.AUTOINCREM') + ' AS DET_VALCBS, ';
    strSQL := strSQL + '  ' + fSqlCampoReformaRef('MOVREF', 'REF_VALIBS', 'MOVDET.AUTOINCREM') + ' AS DET_VALIBS, ';
    strSQL := strSQL + '  ' + fSqlCampoReformaRef('MOVREF', 'REF_SELVAL', 'MOVDET.AUTOINCREM') + ' AS DET_VAL_IS, ';
    strSQL := strSQL + '  DET_UNIVIS, ';
    strSQL := strSQL + '  DET_TAXJUR, ';
    strSQL := strSQL + '  DET_VAL_RT, ';

    If fatVenda.fUtilizaVendaMadeiraOuVidroOuMetroLinear Then
    Begin
      strSQL := strSQL + '  DET_COMPEC, ';
      strSQL := strSQL + '  DET_LARPEC, ';
      strSQL := strSQL + '  DET_ESPPEC, ';

      strSQL := strSQL + '  DET_APAREL, ';
      strSQL := strSQL + '  DET_PERAPA, ';
      strSQL := strSQL + '  DET_BENEFI, ';
      strSQL := strSQL + '  DET_PERBEN, ';
    End;

    strSQL := strSQL + '  DET_NUMCMP, ';
    strSQL := strSQL + '  DET_NITCMP, ';
    strSQL := strSQL + '  DET_DTACMP, ';
    strSQL := strSQL + '  DET_NUMPLA, ';
    strSQL := strSQL + '  DET_PARNUM, ';
    strSQL := strSQL + '  DET_REQCOM, ';
    strSQL := strSQL + '  DET_DESNES, ';

    strSQL := strSQL + '  ITE_CODGRU, ';
    strSQL := strSQL + '  "N" AS DET_SINTET, ';
    strSQL := strSQL + '  DET_QTDITE AS SAV_QTDITE, ';
    strSQL := strSQL + '  DET_TOTCUS AS SAV_TOTCUS, ';
    strSQL := strSQL + '  DET_TOTITE AS SAV_TOTITE, ';
    strSQL := strSQL + '  DET_UNITAR AS SAV_UNITAR, ';
    strSQL := strSQL + '  DET_DESESP AS SAV_DESESP, ';

    strSQL := strSQL + ' (DET_TOTMED / DET_QTDITE) AS PREMED, ';
    strSQL := strSQL + ' (DET_IMPULT / DET_QTDITE) AS IMPULT, ';
    strSQL := strSQL + ' (DET_TOTULT / DET_QTDITE) AS PREULT, ';
    strSQL := strSQL + ' (DET_TOTCUS / DET_QTDITE) AS PRECUS, ';
    strSQL := strSQL + ' (DET_TOTCU2 / DET_QTDITE) AS PRECU2, ';
    strSQL := strSQL + ' (DET_OUTVAL / DET_QTDITE) AS OUTVAL, ';
    strSQL := strSQL + ' (DET_ICMSAI / (DET_TOTITE - DET_DESESP) * 100) AS ICMSAI, ';
    strSQL := strSQL + ' (DET_IMPFED / (DET_TOTITE - DET_DESESP) * 100) AS IMPFED, ';
    strSQL := strSQL + ' (DET_DESOPE / (DET_TOTITE - DET_DESESP) * 100) AS DESOPE, ';

    strSQL := strSQL + '  DET_CLIBUS, ';
    strSQL := strSQL + '  DET_PESLIQ, ';
    strSQL := strSQL + '  DET_ATIVAC, ';
    strSQL := strSQL + '  DET_SEQCOM, ';
    strSQL := strSQL + '  DET_EMPCAR, ';
    strSQL := strSQL + '  DET_VDESST, ';
    strSQL := strSQL + '  DET_MDESST, ';
    strSQL := strSQL + '  DET_FRECOT, ';
    strSQL := strSQL + '  DET_COMPLE, ';
    strSQL := strSQL + '  DET_INCDEV, ';

    If fCfgSis('NUMSER', varBoolean) Then
      strSQL := strSQL + '  (SELECT IF(COUNT(SER_SEQGER) > 0, "S", "N") FROM DETSER  WHERE SER_SEQGER = MOVDET.AUTOINCREM) AS DET_TEMSER, '
    Else
      strSQL := strSQL + '  "N" AS DET_TEMSER, ';

    strSQL := strSQL + '  MOVDET.AUTOINCREM AS DET_AUTOIN ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVDET ';
    strSQL := strSQL + '  JOIN MOVTRI ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER ';
    strSQL := strSQL + '  LEFT JOIN MOVAUX ON MOVDET.AUTOINCREM = MOVAUX.DET_SEQGER ';

    If Not fEmptyStr(FCliSeg) Then
      strSQL := strSQL + 'JOIN MOVGER G ON G.AUTOINCREM = DET_SEQGER ';

    strSQL := strSQL + 'JOIN CADITE ON ITE_CODITE = DET_CODITE ';

    If fatVenda.fUtilizaVendaMadeiraOuVidroOuMetroLinear Then
      strSQL := strSQL + ' LEFT JOIN MOVMAD M ON M.DET_SEQGER = MOVDET.AUTOINCREM  ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  DET_CODCLI = :CODCLI ';

    {* NÃO PODE MOSTRAR DOCUMENTOS DE BAIXA DE ENTREGA FUTURA *}
    strSQL := strSQL + '  AND (LOCATE(RIGHT(DET_CLAFIS, 3), ' + CLAFIS_ENTFUT_VEN_ABR + ') <= 0) ';

    If (Not fEmptyStr(FCliSeg)) And (Not fSintetizarItensNaConfirmacaoDeDocumentos) Then
      strSQL := strSQL + ' AND GER_NOMCON LIKE :NOMCON ';

    If (Not fEmptyStr(FNumDoc)) (*And (Not fGetSintetizarDV)*) Then
      strSQL := strSQL + ' AND DET_NUMDOC = :NUMDOC ';

    If (Not fEmptyStr(FEspDoc)) (*And (Not fGetSintetizarDV)*) Then
      strSQL := strSQL + ' AND DET_ESPDOC = :ESPDOC  ';

    If FDtaFim > 0 (*And (Not fGetSintetizarDV)*) Then
      strSQL := strSQL + ' AND DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

    strSQL := strSQL + '  AND IF((DET_SEQTIN IS NOT NULL AND DET_SEQTIN <> ""), DET_PROEMB <> "S", ' + fFiltroProEmb + ') ';

    if FCarregaItensJaFaturado then
      strSQL := strSQL + '  AND DET_JAFATU = TRUE '+
                         '  AND DET_NUMDOC = DET_NUMFAT '
    Else
      strSQL := strSQL + '  AND DET_JAFATU = FALSE ';

    strSQL := strSQL + '  AND ((DET_ESPDOC = "FF") OR (';

    If (fCfgSis('ENTTRO', varBoolean)) Or (blnConsiderarDV) Or (blnEstornoNotaFiscal) Then
    Begin

      strSQL := strSQL + '  ( ';

      If (intDiaMis > 0) Then
        strSQL := strSQL + ' ( DET_ESPDOC = "MI" AND DET_DTAENT > CAST("' + FormatDateTime('yyyy-mm-dd', VS_Date - intDiaMis) + '" AS DATE) ) '
      Else
        strSQL := strSQL + '   DET_ESPDOC = "MI" ';

      If (blnConsiderarDV) Then
        strSQL := strSQL + ' OR DET_ESPDOC = "DV" ';

      If (fCfgSis('ENTTRO', varBoolean)) Then
        strSQL := strSQL + ' OR DET_ESPDOC = "TR" ';

      If (blnEstornoNotaFiscal) Then
        strSQL := strSQL + ' OR DET_ESPDOC = "NF"';

      strSQL := strSQL + ' )) ';

    End
    Else
    Begin

      If (intDiaMis > 0) Then
        strSQL := strSQL + ' ( DET_ESPDOC = "MI" AND DET_DTAENT > CAST("' + FormatDateTime('yyyy-mm-dd', VS_Date - intDiaMis) + '" AS DATE) ) ) '
      Else
        strSQL := strSQL + '  DET_ESPDOC = "MI") ';

    End;

    strSQL := strSQL + '  AND DET_CONPAG <> "01000") ';

    If (blnFiltrarEmp) Then
      strSQL := strSQL + ' AND DET_CODEMP = :CODEMP ';

    strSQL := strSQL + 'ORDER BY ';
    //strSQL := strSQL + '  11, 12, 3 ';
    strSQL := strSQL + '  DET_NUMDOC, DET_ESPDOC, DET_CODEMP, AUTOINCREM ';

    {*****************************************}
    {* MOVDET                                *}
    {**************************************MV*}
    With qryGenDet Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := FCodCli;

      If (Not fEmptyStr(FCliSeg)) And (Not fSintetizarItensNaConfirmacaoDeDocumentos) Then
        ParamByName('NOMCON').AsString := FCliSeg + '%';

      If (Not fEmptyStr(FNumDoc)) (*And (Not fGetSintetizarDV)*) Then
        ParamByName('NUMDOC').AsString := FNumDoc;

      If (Not fEmptyStr(FEspDoc)) (*And (Not fGetSintetizarDV)*) Then
        ParamByName('ESPDOC').AsString := FEspDoc;

      If FDtaFim > 0 (*And (Not fGetSintetizarDV)*) Then
      Begin
        ParamByName('DTAINI').AsDateTime := FDtaIni;
        ParamByName('DTAFIN').AsDateTime := FDtaFim;
      End;

      If (blnFiltrarEmp) Then
        ParamByName('CODEMP').AsString := IIF(FEmpDoc.IsEmpty, VS_strCodEmp, FEmpDoc);

      Open;
    End;

    pSetaClient(qryGenDet);
    cdsItensConf.Open;
    pSetaClient(cdsItensConf);
    cdsItensConf.SetProvider(Nil);

    pAtualizaTemporariaConfirmacao(False);

    With qryGenEmp Do
    Begin

      {*****************************************}
      {* PROCESSA MOVGER                       *}
      {**************************************MV*}

      If Assigned(FProgress) Then
      Begin
        FProgress.Visible := True;
        FProgress.Max := RecordCount;
        FProgress.Position := 0;
      End;

      fatVenda.fltValFre := 0;
      fatVenda.fltFreDig := 0;
      fatVenda.fltFreCot := 0;
      While Not Eof Do
      Begin

        intQtdIte := 0;
        fltVlrCon := 0.0;
        fltGerFre := 0.0;
        fltGerDesAce := 0.0;
        fltGerFreCot := 0.0;
        fltGetTotIpi := 0.0;
        fltGetTotRet := 0.0;
        fltGetTotRef := 0.0;

        If (Not cdsItensConf.Locate('DET_NUMDOC;DET_ESPDOC;DET_CODEMP',
          VarArrayOf([FieldByName('GER_NUMDOC').AsString, FieldByName('GER_ESPDOC').AsString,
                      FieldByName('GER_CODEMP').AsString]), [])) Then
        Begin
          Next;

          If Assigned(FProgress) Then
            FProgress.StepBy(1);

          Application.ProcessMessages;

          Continue;
        End;

        strDocAnt := cdsItensConf.FieldByName('DET_NUMDOC').AsString;
        strEspAnt := cdsItensConf.FieldByName('DET_ESPDOC').AsString;
        strEmpAnt := cdsItensConf.FieldByName('DET_CODEMP').AsString;

        {*****************************************}
        {* CALCULA QUANTIDADE DE ITENS NO DOC.   *}
        {**************************************MV*}
        While (Not cdsItensConf.Eof)                                        And
              (cdsItensConf.FieldByName('DET_NUMDOC').AsString = strDocAnt) And
              (cdsItensConf.FieldByName('DET_ESPDOC').AsString = strEspAnt) And
              (cdsItensConf.FieldByName('DET_CODEMP').AsString = strEmpAnt) Do
        Begin

          fltTotIte := (cdsItensConf.FieldByName('DET_TOTITE').AsFloat - cdsItensConf.FieldByName('DET_DESESP').AsFloat);
          fltTotFre := cdsItensConf.FieldByName('DET_TOTFRE').AsFloat;
          fltTotDesAce := cdsItensConf.FieldByName('DET_DESACE').AsFloat;
          fltTotFreCot := cdsItensConf.FieldByName('DET_FRECOT').AsFloat;
          fltTotIpi := cdsItensConf.FieldByName('DET_VALIPI').AsFloat;
          fltTotRet := cdsItensConf.FieldByName('DET_VALRET').AsFloat;
          fltTotRef := cdsItensConf.FieldByName('DET_VALREF').AsFloat;

          If (cdsItensConf.FieldByName('DET_CLAFIS').AsString < '5000') Then
          Begin
            fltTotIte := -fltTotIte;
            fltTotFre := -fltTotFre;
            fltTotFreCot := -fltTotFreCot;
            fltTotIpi := -fltTotIpi;
            fltTotRet := -fltTotRet;
            fltTotRef := -fltTotRef;
          End;

          fltVlrCon := fltVlrCon + (fltTotIte + fltTotFre);
          fltGerFre := fltGerFre + fltTotFre;
          fltGerDesAce := fltGerDesAce + fltTotDesAce;
          fltGerFreCot := fltGerFreCot + fltTotFreCot;
          fltGetTotIpi := fltGetTotIpi + fltTotIpi;
          fltGetTotRet := fltGetTotRet + fltTotRet;
          fltGetTotRef := fltGetTotRef + fltTotRef;

          Inc(intQtdIte);
          cdsItensConf.Next;
        End;

        fatVenda.fltValFre := fatVenda.fltValFre + fltGerFre;
        fatVenda.fltFreDig := fatVenda.fltFreDig + fltGerFre;
        if fCfgSis('CDADOC', varBoolean) then
          fatVenda.fltDesAce := fatVenda.fltDesAce + fltGerDesAce
        else fatVenda.fltDesAce := 0;
        fatVenda.fltFreCot := fatVenda.fltFreCot + fltGerFreCot;

        fltDupRec := 0;
        If (Not blnEstornoNotaFiscal) Then
        Begin
          fltDupRec := fGetValorDuplicatasRecebidas( FieldByName('GER_NUMDOC').AsString,
                                                     FieldByName('GER_ESPDOC').AsString,
                                                     FieldByName('GER_CODEMP').AsString,
                                                     fltVlrCon,
                                                     FieldByName('AUX_DUPREC').AsFloat,
                                                     fltJurSuj,
                                                     fltDesSuj,
                                                     fltValAbe );
        End;

        blnQuitado := fGetDuplicataBaixaTotal( FieldByName('GER_NUMDOC').AsString,
                                               FieldByName('GER_ESPDOC').AsString,
                                               FieldByName('GER_CODEMP').AsString,
                                               blnQuitadoTotal);

        blnPedTemBxParcial := False;
        if not blnQuitado then
        begin
          blnPedTemBxParcial := fRetornaSeDocTemBxParcial( FieldByName('GER_NUMDOC').AsString,
                                                           FieldByName('GER_ESPDOC').AsString,
                                                           FCodCli,
                                                           FieldByName('GER_CODEMP').AsString);
        end;

        blnFFComBol := fTemCadRecFFComBol(FieldByName('GER_NUMDOC').AsString,
                                          FieldByName('GER_ESPDOC').AsString,
                                          FieldByName('GER_CODEMP').AsString,
                                          FieldByName('GER_CODCLI').AsString);


        If (fCfgSis('TRAMIC', varBoolean)) then
        begin
          If fFormataFloat(Abs(fltDupRec),2) >= fFormataFloat(Abs(fltVlrCon),2) Then
          Begin
            stlDocQuitado.Add(FieldByName('GER_NUMDOC').AsString+
                              FieldByName('GER_ESPDOC').AsString+
                              FieldByName('GER_CODEMP').AsString);

            Next;

            If Assigned(FProgress) Then
              FProgress.StepBy(1);

            Application.ProcessMessages;

            Continue;
          End;
        End
        Else If (blnQuitado) And (FieldByName('GER_ESPDOC').AsString = 'DV') And(FieldByName('GER_DEVCNF').AsString = 'S') Then
        Begin
          Next;

          If Assigned(FProgress) Then
            FProgress.StepBy(1);

          Application.ProcessMessages;

          Continue;
        End
        Else
        Begin
          if ((FSituacaoFinanceira = stQuitado)  and (fFormataFloat(fltDupRec,2)  = 0)) or
             ((FSituacaoFinanceira = stEmAberto) and (fFormataFloat(fltDupRec,2) <> 0)) then
          Begin
            While cdsItensConf.Locate('DET_SEQGER', FieldByName('GER_AUTINC').AsString, []) Do
               cdsItensConf.Delete;

            Next;

            If Assigned(FProgress) Then
              FProgress.StepBy(1);

            Application.ProcessMessages;

            Continue;
          End;
        End;

        {*****************************************************************}
        {* COMENTADO ESSA TRAVA, REF AO REQUISITO 23545, DATA 09/09/2014 *}
        {**************************************************************FC*}
        {If (FieldByName('GER_ESPDOC').AsString = 'DV') Or (Pos(FieldByName('GER_CLAFIS').AsString, VS_strClaDev) > 0) Then
        Begin
          If fEhDevolucaoDeBaixaDeEntFut(FieldByName('GER_NUMDOC').AsString,
                                         FieldByName('GER_ESPDOC').AsString,
                                         FieldByName('GER_CODEMP').AsString,
                                         FieldByName('GER_CODCLI').AsString) Then
          Begin
            Next;

            If Assigned(FProgress) Then
              FProgress.StepBy(1);

            Application.ProcessMessages;

            Continue;
          End;
        End;}

        {*****************************************************************}
        {* COMENTADO ESSA TRAVA, REF AO REQUISITO 23545, DATA 09/09/2014 *}
        {**************************************************************FC*}
        {Else If (FieldByName('GER_ENTFUT').AsString = 'S') Then
        Begin
          If fEntregaFuturaTemDevolucao(FieldByName('GER_NUMDOC').AsString,
                                        FieldByName('GER_ESPDOC').AsString,
                                        FieldByName('GER_CODEMP').AsString) Then
          Begin
            Next;

            If Assigned(FProgress) Then
              FProgress.StepBy(1);

            Application.ProcessMessages;

            Continue;
          End;
        End;}

        {*****************************************}
        {* INSERE REGISTRO NA TEMPORARIA         *}
        {**************************************MV*}
        If fCfgSis('CONFFF', VarBoolean) Then
        Begin
          If fJaExisteConfirmacaoParaMeiaNota(FieldByName('GER_NUMDOC').AsString,
                                              FieldByName('GER_ESPDOC').AsString,
                                              FieldByName('GER_CODEMP').AsString) Then
          Begin
            While cdsItensConf.Locate('DET_SEQGER', FieldByName('GER_AUTINC').AsString, []) Do
               cdsItensConf.Delete;

            qryGenEmp.Next;

            If Assigned(FProgress) Then
              FProgress.StepBy(1);

            Application.ProcessMessages;

            Continue;
          End;
        End;

        if (not fatVenda.qryTemporariaConfirmacao.Active) then
          fatVenda.qryTemporariaConfirmacao.Open;

        fatVenda.qryTemporariaConfirmacao.Append;

        strNumDoc := FieldByName('GER_NUMDOC').AsString;
        strNumDoc := strNumDoc + IIF(FieldByName('GER_JAFATU').AsInteger = 1, 'q', '');

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DTAENT').AsDateTime := FieldByName('GER_DTAENT').AsDateTime;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString   := strNumDoc;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString   := FieldByName('GER_ESPDOC').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString   := FieldByName('GER_CODEMP').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODVEN').AsString   := FieldByName('GER_CODVEN').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NOMCON').AsString   := FieldByName('GER_NOMCON').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODCLI').AsString   := FCodCli;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ENTRET').AsString   := IfThen(FieldByName('GER_ENTFAT').AsString = 'S', 'E', 'R');

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_VLRCON').AsFloat    := fltVlrCon;
        fatVenda.qryTemporariaConfirmacao.FieldByName('SAV_VLRCON').AsFloat    := fltVlrCon;

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_TOTFRE').AsFloat    := fltGerFre;
        fatVenda.qryTemporariaConfirmacao.FieldByName('SAV_TOTFRE').AsFloat    := fltGerFre;

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DESACE').AsFloat    := fltGerDesAce;

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DESESP').AsFloat    := FieldByName('GER_DESESP').AsFloat;
        fatVenda.qryTemporariaConfirmacao.FieldByName('SAV_DESESP').AsFloat    := FieldByName('GER_DESESP').AsFloat;

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ITEDOC').AsInteger  := intQtdIte;
        fatVenda.qryTemporariaConfirmacao.FieldByName('SAV_ITEDOC').AsInteger  := intQtdIte;

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DUPREC').AsFloat    := fltDupRec;
        fatVenda.qryTemporariaConfirmacao.FieldByName('SAV_DUPREC').AsFloat    := fltDupRec;

        fatVenda.qryTemporariaConfirmacao.FieldByName('SAV_DHLOCT').AsDateTime := fRetUltimaAlteracaoCadRecGeral(FieldByName('GER_NUMDOC').AsString,
                                                                                                                 FieldByName('GER_ESPDOC').AsString,
                                                                                                                 FieldByName('GER_CODEMP').AsString,
                                                                                                                 FCodCli);

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DOCQUI').AsString   := IIF(FieldByName('GER_JAFATU').AsInteger = 1, 'S', 'N');
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_JURSUJ').AsFloat    := fltJurSuj;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DESSUJ').AsFloat    := fltDesSuj;

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString   := 'D';
        fatVenda.qryTemporariaConfirmacao.FieldByName('SAV_SINTET').AsString   := 'N';

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DUPBAI').AsString   := IIF(blnQuitado, 'S', 'N');

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_BAITOT').AsString   := IIF(blnQuitadoTotal, 'S', 'N');

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_BXPARC').AsString   := IIF(blnPedTemBxParcial, 'S', 'N');

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_TEMSER').AsString   := IIF(fEmptyStr(FieldByName('GER_CODS01').AsString), 'N', 'S');

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODFAZ').AsString   := FieldByName('GER_CODFAZ').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_FASOBR').AsString   := FieldByName('GER_FASOBR').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_PLAVEI').AsString   := FieldByName('AUX_PLAVEI').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_KM_VEI').AsString   := FieldByName('AUX_KM_VEI').AsString;

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MEN001').AsString   := FieldByName('GER_MEN001').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MEN002').AsString   := FieldByName('GER_MEN002').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MEN003').AsString   := FieldByName('GER_MEN003').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MEN004').AsString   := FieldByName('GER_MEN004').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MEN005').AsString   := FieldByName('GER_MEN005').AsString;

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODCND').AsString   := FieldByName('GER_CODCND').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CONPAG').AsString   := FieldByName('GER_CONPAG').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODFPG').AsString   := FieldByName('GER_CODFPG').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_TIPFRE').AsString   := FieldByName('GER_TIPFRE').AsString;

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NOMTAB').AsString   := FieldByName('GER_TABELA').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_AUTINC').AsString   := FieldByName('GER_AUTINC').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_VENPRE').AsString   := IfEmptyStr(FieldByName('AUX_VENPRE').AsString, 'N');
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_EDIPES').AsString   := FieldByName('AUX_EDIPES').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CONSUM').AsString   := FieldByName('GER_CONSUM').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMB').AsString   := FieldByName('AUX_CODEMB').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_TPOPER').AsString   := FieldByName('AUX_TPOPER').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODTRA').AsString   := FieldByName('GER_CODTRA').AsString;

        For intContador := 1 To 30 Do
        Begin
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODS' + fStrZero(intContador, 2)).AsString := FieldByName('GER_CODS' + fStrZero(intContador, 2)).AsString;
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DESS' + fStrZero(intContador, 2)).AsString := FieldByName('GER_DESS' + fStrZero(intContador, 2)).AsString;
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_IDES' + fStrZero(intContador, 2)).AsString := FieldByName('GER_IDES' + fStrZero(intContador, 2)).AsString;
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_QTDS' + fStrZero(intContador, 2)).AsFloat  := FieldByName('GER_QTDS' + fStrZero(intContador, 2)).AsFloat;
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_UNIS' + fStrZero(intContador, 2)).AsFloat  := FieldByName('GER_UNIS' + fStrZero(intContador, 2)).AsFloat;
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_VALS' + fStrZero(intContador, 2)).AsFloat  := FieldByName('GER_VALS' + fStrZero(intContador, 2)).AsFloat;
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DECS' + fStrZero(intContador, 2)).AsFloat  := FieldByName('GER_DECS' + fStrZero(intContador, 2)).AsFloat;
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_BRIS' + fStrZero(intContador, 2)).AsString := FieldByName('GER_BRIS' + fStrZero(intContador, 2)).AsString;
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_PARS' + fStrZero(intContador, 2)).AsString := FieldByName('GER_PARS' + fStrZero(intContador, 2)).AsString;
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_TBRS' + fStrZero(intContador, 2)).AsString := FieldByName('GER_TBRS' + fStrZero(intContador, 2)).AsString;
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_VENS' + fStrZero(intContador, 2)).AsString := FieldByName('GER_VENS' + fStrZero(intContador, 2)).AsString;
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_VE2S' + fStrZero(intContador, 2)).AsString := FieldByName('GER_VE2S' + fStrZero(intContador, 2)).AsString;
        End;

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_TEMCCR').AsString := 'N';

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_REC_PD').AsFloat  := FieldByName('AUX_DUPREC').AsFloat;

        If fCfgSis('USACCR', varBoolean) Then
        Begin
          If fDocumentoPossuiItemConcreto(FieldByName('GER_NUMDOC').AsString,
                                          FieldByName('GER_ESPDOC').AsString,
                                          FieldByName('GER_CODEMP').AsString) Then
          Begin
            fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_TEMCCR').AsString := 'S';
          End;
        End;

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_SEQMAR').AsInteger := 0;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CLAFIS').AsString := FieldByName('GER_CLAFIS').AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_FF_BOL').AsString := IIF(blnFFComBol, 'S', 'N');
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DEVCNF').AsString := FieldByName('GER_DEVCNF').AsString;

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_FRECOT').AsFloat := fltGerFreCot;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_TOTIPI').AsFloat := fltGetTotIpi;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_TOTRET').AsFloat := fltGetTotRet;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_TOTREF').AsFloat := fltGetTotRef;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DISSER').AsString := FieldByName('MOV_DISSER').AsString;

        If blnFFComBol Then
          FConfTemFFComBol := True;

        If fGetSintetizarDV Then
        Begin
          {***********************************************************************}
          {* REGRA Nº1 PARA EFEITO DE SINTETIZAÇÃO                               *}
          {* SOMENTE DOCUMENTOS COM DUPLICATAS TOTALMENTE QUITADAS OU TOTALMENTE *}
          {* ABERTAS (SEM BAIXA PARCIAL), É QUE PODEM SER SINTETIZADOS           *}
          {* TMP_PODSIN ESTANDO "S" NÃO SIGNIFICA QUE O MESMO SERÁ SINTETIZADO   *}
          {* TMP_PODSIN ESTANDO "S" SIGNIFICA QUE O DOCUMENTO ESTÁ ABERTO OU     *}
          {* QUITADO EM SUA TOTALIDADE, LIBERANDO-O PARA EVENTUAL SINTETIZAÇÃO   *}
          {********************************************************************VA*}
          blnTotAber := (Not blnQuitado) And (fltDupRec = 0);
          blnPoderaSintetizar := (blnQuitado) Or (blnTotAber);
          If blnPoderaSintetizar Then
          Begin
            {*****************************************************************}
            {* DEVOLUÇÕES REFERENTES A MAIS DE UM DOCUMENTO COM RECEBIMENTOS *}
            {* PARCIAIS OU TOTAIS, TAMBÉM NÃO PODEM SER SINTETIZADAS         *}
            {**************************************************************VA*}
            If (FieldByName('GER_ESPDOC').AsString = 'DV') And
               (FieldByName('GER_QTDREF').AsInteger > 1) And
               (Not blnTotAber) Then
              blnPoderaSintetizar := False;
          End;

          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_PODSIN').AsString := IIF(blnPoderaSintetizar, 'S', 'N');
        End;

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODPRJ').AsString := FieldByName('AUX_CODPRJ').AsString;

        fatVenda.qryTemporariaConfirmacao.Post;

        Next;

        If Assigned(FProgress) Then
          FProgress.StepBy(1);

        Application.ProcessMessages;

      End;

      {******************************************************************}
      {* PROCESSA A TABELA TEMPORARIA PARA ALIMENTAR O CAMPO TMP_REGCOR *}
      {***************************************************************LU*}
      With  fatVenda.qryTemporariaConfirmacao Do
      Begin
        DisableControls;
        First;

        If Assigned(FProgress) Then
        Begin
          FProgress.Max := RecordCount;
          FProgress.Position := 0;
        End;

        While not Eof Do
        Begin
          Edit;

          If SameText(FieldByName('TMP_DUPBAI').AsString, 'S') Then
          begin
            FieldByName('TMP_REGCOR').AsString := 'V';
            if SameText(FieldByName('TMP_BAITOT').AsString, 'N') then
              FieldByName('TMP_REGCOR').AsString := 'M';
          end
          else if SameText(FieldByName('TMP_BXPARC').AsString, 'S') then
            FieldByName('TMP_REGCOR').AsString := 'M';

          If fEhDuplicataAgrupada Then
            FieldByName('TMP_REGCOR').AsString := 'G'
          Else If Not fGetExisteDuplicataCad(FieldByName('TMP_NUMDOC').asString,
                                             FieldByName('TMP_ESPDOC').asString,
                                             FieldByName('TMP_CODEMP').asString) Then
            FieldByName('TMP_REGCOR').AsString := 'N';

          Post;

          Next;

          If Assigned(FProgress) Then
            FProgress.StepBy(1);

          Application.ProcessMessages;
        End;

        If Assigned(FProgress) Then
          FProgress.Visible := False;

        EnableControls;
      End;

      If fGetSintetizarDV Then
      Begin
        {*************************************************************************}
        {* REGRA Nº2 PARA EFEITO DE SINTETIZAÇÃO                                 *}
        {* DOS DOCUMENTOS PASSIVEIS DE SINTETIZACAO, VERIFICAR SE OS DOCUMENTOS  *}
        {* RELACIONADOS (DEVOLUÇÃO E SEUS DOCUMENTOS DE FATURAMENTO OU DOCUMENTO *}
        {* DE FATURAMENTO E SUAS EVENTUAIS DEVOLUÇÕES), ESTÃO NA MESMA SITUAÇÃO  *}
        {* FINANCEIRA, OU SEJA, TOTALMENTE ABERTO                                *}
        {**********************************************************************VA*}
        fVerificarMarcarComoNaoSintetizavel;
      End;

      {******************************************************************}
      {* BUG (?) SEM ESSE REFRESH TUDO QUE É FEITO A SEGUIR, EX A EDIÇÃO*}
      {* DO CAMPO TMP_MARDES FICA SÓ EM MEMÓRIA E NÃO VAI PARA O BANCO  *}
      {***************************************************************VA*}
      With  fatVenda.qryTemporariaConfirmacao Do
      Begin
        Close;
        Open;

        (FieldByName('TMP_VLRCON') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('TMP_DUPREC') As TFloatField).DisplayFormat := '#,##0.00';

        First;
      End;
    End;

    If Assigned(FProgress) Then
      FProgress.Visible := False;

    cdsItensConf.First;

    {*********************************************************************************}
    {* COMENTADO A PEDIDO DO RONALDO, SOLICITAÇÃO DO CLIENTE: NOSSA LOJA, 10/10/2012 *}
    {******************************************************************************RN*}
    If {(Not fClienteConsumidor(fRetNomCliente(FCodCli), False, True)) And} fGetSintetizarDV Then
    Begin
      pSintentizaDevolucoes;
      pReverteValorDocumentos;
      pAtualizaTemporariaConfirmacao(False);
    End;

    oleDadosConfirmacao := cdsItensConf.Data;

    pCalculaTotais;
  Finally
    fatVenda.qryTemporariaConfirmacao.EnableControls;

    FreeAndNil(qryGenDet);
    FreeAndNil(qryGenEmp);
  End;

end;

procedure TConfirmacaoDocumentos.pDeletaTemporariaConfirmacao;
begin

  If (Not fTabelaExiste(fatVenda.strTabelaConfMi)) Then
    Exit;

  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM ' + fatVenda.strTabelaConfMi);
    ExecSQL;
    Close;
  End;

end;


procedure TConfirmacaoDocumentos.pAtualizaDocumentosMarcados(ATipoAcao: TTipoAcao);
Var
    qryUpdDet,
    qryUpdGer : TUniQuery;
    intQtdDocBai : Integer;
    strTabGer,
    strTabDet : String;
begin
  qryUpdGer := fCriaQuery(Self);
  qryUpdDet := fCriaQuery(Self);
  Try
    fatVenda.qryTemporariaConfirmacao.DisableControls;
    intQtdDocBai := 0;
    fatVenda.qryTemporariaConfirmacao.First;
    While (Not fatVenda.qryTemporariaConfirmacao.Eof) Do
    Begin
      If fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString = 'M' Then
      Begin
        strTabGer := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NOMTAB').AsString;
        strTabDet := AnsiReplaceStr(AnsiReplaceStr(strTabGer, 'MOVGER', 'MOVDET'), 'NOTGER', 'NOTDET');

        qryUpdGer.Close;
        qryUpdGer.SQL.Clear;
        qryUpdGer.SQL.Add(' UPDATE ' + strTabGer);
        qryUpdGer.SQL.Add('    SET GER_NUMFAT = :NUMFAT, ');
        qryUpdGer.SQL.Add('        GER_TIPFAT = :TIPFAT, ');
        qryUpdGer.SQL.Add('        GER_EMPFAT = :EMPFAT, ');
        qryUpdGer.SQL.Add('        GER_CLIFAT = :CLIFAT, ');
        qryUpdGer.SQL.Add('        GER_DTAFAT = :DTAFAT, ');
        qryUpdGer.SQL.Add('        GER_VENFAT = :VENFAT, ');
        qryUpdGer.SQL.Add('        GER_CNDFAT = :CNDFAT, ');
        qryUpdGer.SQL.Add('        GER_VALFAT = :VALFAT, ');
        qryUpdGer.SQL.Add('        GER_JAFATU = :JAFATU  ');
        qryUpdGer.SQL.Add('  WHERE AUTOINCREM = :AUTINC  ');

        if ATipoAcao = taBaixa then
        begin
          qryUpdGer.ParamByName('NUMFAT').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString;
          qryUpdGer.ParamByName('TIPFAT').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString;
          qryUpdGer.ParamByName('EMPFAT').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString;
          qryUpdGer.ParamByName('CLIFAT').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODCLI').AsString;
          qryUpdGer.ParamByName('DTAFAT').AsDateTime := VS_Date;
          qryUpdGer.ParamByName('VALFAT').AsFloat := fatVenda.qryTemporariaConfirmacao.FieldByName('SAV_VLRCON').AsFloat;
          qryUpdGer.ParamByName('JAFATU').AsInteger := 1;
          qryUpdGer.ParamByName('AUTINC').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_AUTINC').AsString;

          If (fEmptyStr(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CONPAG').AsString)) Then
            qryUpdGer.ParamByName('CNDFAT').Value := Null
          Else
            qryUpdGer.ParamByName('CNDFAT').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CONPAG').AsString;

          If (fEmptyStr(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODVEN').AsString)) Then
            qryUpdGer.ParamByName('VENFAT').Value := Null
          Else
            qryUpdGer.ParamByName('VENFAT').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODVEN').AsString;
        end
        else
        Begin
          qryUpdGer.ParamByName('AUTINC').Value      := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_AUTINC').AsString;
          qryUpdGer.ParamByName('NUMFAT').Value      := Null;
          qryUpdGer.ParamByName('TIPFAT').Value      := Null;
          qryUpdGer.ParamByName('EMPFAT').Value      := Null;
          qryUpdGer.ParamByName('CLIFAT').Value      := Null;
          qryUpdGer.ParamByName('DTAFAT').Value      := Null;
          qryUpdGer.ParamByName('VALFAT').Value      := Null;
          qryUpdGer.ParamByName('JAFATU').AsInteger  := 0;
          qryUpdGer.ParamByName('CNDFAT').Value      := Null;
          qryUpdGer.ParamByName('VENFAT').Value      := Null;
        End;

        qryUpdDet.Close;
        qryUpdDet.SQL.Clear;
        qryUpdDet.SQL.Add(' UPDATE ' + strTabDet);
        qryUpdDet.SQL.Add('    SET DET_NUMFAT = :NUMFAT,    ');
        qryUpdDet.SQL.Add('        DET_TIPFAT = :TIPFAT,    ');
        qryUpdDet.SQL.Add('        DET_EMPFAT = :EMPFAT,    ');
        qryUpdDet.SQL.Add('        DET_CLIFAT = :CLIFAT,    ');
        qryUpdDet.SQL.Add('        DET_DTAFAT = :DTAFAT,    ');
        qryUpdDet.SQL.Add('        DET_VENFAT = :VENFAT,    ');
        qryUpdDet.SQL.Add('        DET_CNDFAT = :CNDFAT,    ');
        qryUpdDet.SQL.Add('        DET_VALFAT = DET_VLRCON, ');
        qryUpdDet.SQL.Add('        DET_JAFATU = :JAFATU     ');
        qryUpdDet.SQL.Add('  WHERE DET_SEQGER = :AUTINC     ');

        if ATipoAcao = taBaixa then
        begin
          qryUpdDet.ParamByName('NUMFAT').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString;
          qryUpdDet.ParamByName('TIPFAT').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString;
          qryUpdDet.ParamByName('EMPFAT').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString;
          qryUpdDet.ParamByName('CLIFAT').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODCLI').AsString;
          qryUpdDet.ParamByName('DTAFAT').AsDateTime := VS_Date;
          qryUpdDet.ParamByName('JAFATU').AsInteger := 1;
          qryUpdDet.ParamByName('AUTINC').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_AUTINC').AsString;

          If (fEmptyStr(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CONPAG').AsString)) Then
            qryUpdDet.ParamByName('CNDFAT').Value := Null
          Else
            qryUpdDet.ParamByName('CNDFAT').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CONPAG').AsString;

          If (fEmptyStr(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODVEN').AsString)) Then
            qryUpdDet.ParamByName('VENFAT').Value := Null
          Else
            qryUpdDet.ParamByName('VENFAT').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODVEN').AsString;
        end
        else
        Begin
          qryUpdDet.ParamByName('AUTINC').Value      := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_AUTINC').AsString;
          qryUpdDet.ParamByName('NUMFAT').Value      := Null;
          qryUpdDet.ParamByName('TIPFAT').Value      := Null;
          qryUpdDet.ParamByName('EMPFAT').Value      := Null;
          qryUpdDet.ParamByName('CLIFAT').Value      := Null;
          qryUpdDet.ParamByName('DTAFAT').Value      := Null;
          qryUpdDet.ParamByName('JAFATU').AsInteger  := 0;
          qryUpdDet.ParamByName('CNDFAT').Value      := Null;
          qryUpdDet.ParamByName('VENFAT').Value      := Null;
        End;

        qryUpdGer.ExecSQL;
        qryUpdDet.ExecSQL;

        intQtdDocBai := intQtdDocBai + qryUpdGer.RowsAffected;
      End;
      fatVenda.qryTemporariaConfirmacao.Next;
    End;

    If (intQtdDocBai > 0) Then
      fMensagem('ATENÇÃO!', 'Documentos '+IIF(ATipoAcao = taBaixa, 'baixados ', 'com baixas canceladas ')+
                '(' + IntToStr(intQtdDocBai) + ')', ['&OK']);
  Finally
    fatVenda.qryTemporariaConfirmacao.EnableControls;
    FreeAndNil(qryUpdDet);
    FreeAndNil(qryUpdGer);
  End;
end;

procedure TConfirmacaoDocumentos.pAtualizaTemporariaConfirmacao(blnMantemSintet: Boolean);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + fatVenda.strTabelaConfMi;
  strSQL := strSQL + ' WHERE TMP_VLRCON <> 0.0 ';

  If fGetSintetizarDV Then
  Begin
    If (Not fEmptyStr(FCliSeg)) Then
      strSQL := strSQL + '  AND TMP_NOMCON LIKE :NOMCON ';

    If Not fEmptyStr(FNumDoc) Then
      strSQL := strSQL + '  AND TMP_NUMDOC = :NUMDOC ';

    If Not fEmptyStr(FEspDoc) Then
      strSQL := strSQL + '  AND TMP_ESPDOC = :ESPDOC ';

    If FDtaFim > 0 Then
      strSQL := strSQL + '  AND TMP_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  End;

  If (blnMantemSintet) Then
  Begin
    strSQL := strSQL + ' OR SAV_SINTET = "S" ';
  End;

  strSQL := strSQL + ' ORDER BY TMP_SEQMAR, TMP_DTAENT  ';

  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If fGetSintetizarDV Then
    Begin
      If (Not fEmptyStr(FCliSeg)) Then
        ParamByName('NOMCON').AsString := FCliSeg + '%';

      If Not fEmptyStr(FNumDoc) Then
        ParamByName('NUMDOC').AsString := FNumDoc;

      If Not fEmptyStr(FEspDoc) Then
        ParamByName('ESPDOC').AsString := FEspDoc;

      If FDtaFim > 0 Then
      Begin
        ParamByName('DTAINI').AsDateTime := FDtaIni;
        ParamByName('DTAFIN').AsDateTime := FDtaFim;
      End;

    End;

    Open;

    (FieldByName('TMP_VLRCON') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('TMP_DUPREC') As TFloatField).DisplayFormat := '#,##0.00';

    {*******************}
    {* CALCULA O FRETE *}
    {****************AF*}
    fatVenda.fltValFre := 0;
    fatVenda.fltFreDig := 0;
    fatVenda.fltFreCot := 0;
    fatVenda.fltDesAce := 0;

    While Not Eof Do
    Begin
        fatVenda.fltValFre := fatVenda.fltValFre + FieldByName('TMP_TOTFRE').AsFloat;
        fatVenda.fltFreDig := fatVenda.fltFreDig + FieldByName('TMP_TOTFRE').AsFloat;
        fatVenda.fltFreCot := fatVenda.fltFreCot + FieldByName('TMP_FRECOT').AsFloat;
        if fCfgSis('CDADOC', varBoolean) then
          fatVenda.fltDesAce := fatVenda.fltDesAce + FieldByName('TMP_DESACE').AsFloat
        else fatVenda.fltDesAce := 0;

        Next;
      End;

  End;

  fatVenda.strConfDocsAutIncCadRec := fRetornaAutIncCadRec;

end;

procedure TConfirmacaoDocumentos.pBaixarDocumentosMarcados;
Begin
  pAtualizaDocumentosMarcados(taBaixa);
end;

// TOTAL DE DEVOLUCOES SINTETIZADAS POR DOCUMENTO
Procedure TConfirmacaoDocumentos.pCriaCdsTotDev;
Begin
  cdsTotDev := TUniClientDataSet.Create(Self);
  With cdsTotDev, FieldDefs Do
  Begin
    With AddFieldDef Do Begin Name := 'NUMDOC'; DataType := ftString; Required := False; End;
    With AddFieldDef Do Begin Name := 'ESPDOC'; DataType := ftString; Required := False; End;
    With AddFieldDef Do Begin Name := 'CODEMP'; DataType := ftString; Required := False; End;

    With AddFieldDef Do Begin Name := 'DOCDEV'; DataType := ftString; Required := False; End;
    With AddFieldDef Do Begin Name := 'ESPDEV'; DataType := ftString; Required := False; End;
    With AddFieldDef Do Begin Name := 'EMPDEV'; DataType := ftString; Required := False; End;

    With AddFieldDef Do Begin Name := 'TOTDEV'; DataType := ftFloat; End;

    CreateDataSet;
    Open;
  End;
End;

procedure TConfirmacaoDocumentos.pCriaClientDocsSint;
begin
  cdsDocsDevSintetizado := TUniClientDataSet.Create(Self);

  With cdsDocsDevSintetizado.FieldDefs.AddFieldDef Do //Esse campo vem o NUMDOC + ESPDOC + CODEMP do documento. Ex: 000001-MI-001
  Begin
    Name := 'DOCUMENTO';
    DataType := ftString;
    Size := 19;
  End;

  With cdsDocsDevSintetizado.FieldDefs.AddFieldDef Do //Somente o numero do documento da devolução
  Begin
    Name := 'DEVOLUCAO';
    DataType := ftString;
    Size := 12;
  End;

  cdsDocsDevSintetizado.CreateDataSet;
end;

{*******************************************}
{* FUNÇÃO QUE RETORNA O UNITÁRIO LÍQUIDO.  *}
{* CRIADA ESTA FUNÇÃO POIS NÃO SINTETIZAVA *}
{* AS DVs QUE TINHAM DESCONTO ESPECIAL,    *}
{* OU SEJA, QUANDO ESCOLHIDO "DEVOLVER     *}
{* DOCUMENTO COMPLETAMENTE".               *}
{****************************************PZ*}
function TConfirmacaoDocumentos.fRetonaUnitarioLiq(cdsIteDoc: TUniClientDataSet): Double;
Var
  strPrx: String;
begin
  {*****************************************************************************}
  {* SE A QUANTIDADE FOR MENOR OU IGUAL A ZERO É PORQUE O ITEM FOI SINTETIZADO.*}
  {* QUANDO SINTETIZADO OS VALORES DO TOTITE, DESESP, QTDITE SÃO SERADOS,      *}
  {* POR ISSO PEGO OS VALORES SALVOS.                                          *}
  {**************************************************************************PZ*}
  strPrx:=IIF(cdsIteDoc.FieldByName('DET_QTDITE').AsFloat <= 0,'SAV_','DET_');

  If (cdsIteDoc.FieldByName(strPrx+'DESESP').AsFloat <= 0) Then
    Result := cdsIteDoc.FieldByName(strPrx+'UNITAR').AsFloat
  Else
    Result := fFormataFloat((cdsIteDoc.FieldByName(strPrx+'TOTITE').AsFloat - cdsIteDoc.FieldByName(strPrx+'DESESP').AsFloat) / cdsIteDoc.FieldByName(strPrx+'QTDITE').AsFloat, 4);
end;

function TConfirmacaoDocumentos.fRetProfissional(strNumDoc, strEspDoc,
  strCodCli, strCodEmp: String): String;
  Var
    qryAux : TUniQuery;
begin
  qryAux := fCriaQuery(Self);

  With qryAux Do
  Begin
    SQL.Clear;
    SQL.Add('SELECT DISTINCT COM_CODPRO  ');
    SQL.Add('FROM   COMPRO               ');
    SQL.Add('WHERE  COM_NUMDOC = :NUMDOC ');
    SQL.Add('AND    COM_ESPDOC = :ESPDOC ');
    SQL.Add('AND    COM_CODEMP = :CODEMP ');
    SQL.Add('AND    COM_CODCLI = :CODCLI ');
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODCLI').AsString := strCodCli;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    If (Not qryAux.IsEmpty) And (qryAux.RecordCount = 1) Then
      Result := FieldByName('COM_CODPRO').AsString
    Else
      Result := EmptyStr;
  End;

  FreeAndNil(qryAux);
end;

function TConfirmacaoDocumentos.fRetSeqMar: Integer;
  Var
    strSQL: String;
    qrySeqMar : TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT MAX(TMP_SEQMAR) CNT ';
  strSQL := strSQL + '   FROM ';
  strSQL := strSQL + fatVenda.strTabelaConfMi;

  qrySeqMar := fCriaQuery(Self);

  With qrySeqMar Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
    Result := FieldByName('CNT').AsInteger + 1;
    Close;
  End;

  FreeAndNil(qrySeqMar);
end;

Procedure TConfirmacaoDocumentos.pAddDevolucao(strDocDev, strEspDev, strEmpDev,
  strNumDoc, strEspDoc, strEmpDoc: String; fltValDev: Double);
Begin
  With cdsTotDev Do
  Begin
    If Locate('NUMDOC;ESPDOC;CODEMP;DOCDEV;ESPDEV;EMPDEV',
       VarArrayOf([strNumDoc, strEspDoc, strEmpDoc, strDocDev, strEspDev, strEmpDev]), []) Then
    Begin
      Edit;
    End Else
    Begin
      Insert;

      FieldByName('NUMDOC').AsString := strNumDoc;
      FieldByName('ESPDOC').AsString := strEspDoc;
      FieldByName('CODEMP').AsString := strEmpDoc;

      FieldByName('DOCDEV').AsString := strDocDev;
      FieldByName('ESPDEV').AsString := strEspDev;
      FieldByName('EMPDEV').AsString := strEmpDev;

      FieldByName('TOTDEV').AsFloat := 0;

    End;

    FieldByName('TOTDEV').AsFloat := FieldByName('TOTDEV').AsFloat + fltValDev;
    Post;
  End;
End;

procedure TConfirmacaoDocumentos.pCarregaItensDocumento;
  Var
    strSQL: String;
    fltTotGer: Double;
    fltDesEsp: Double;
    fltTotSer: Double;
    fltTotIpi: Double;
    fltTotRet: Double;
    fltTotCbs: Double;
    fltTotIbs: Double;
    fltTotIs: Double;

    qryGenDet: TUniQuery;
    dtsGenDet: TDataSource;

    qryItens: TDataset;
    strFiltro: String;
    frmFatMostraProdConfirmacao : TfrmFatMostraProdConfirmacao;

begin

  Try
    If (Not Assigned(fatVenda.qryTemporariaConfirmacao)) Or
       (Not fatVenda.qryTemporariaConfirmacao.Active) Then
    begin
      Exit;
    end;

    qryGenDet := fCriaQuery;

    If fGetSintetizarDV Then
    Begin
      dtsGenDet := fCriaDataSource(cdsItensConf);

      strFiltro := strFiltro + 'DET_QTDITE > 0 AND ';
      strFiltro := strFiltro + 'DET_NUMDOC = ' + QuotedStr(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString) + ' AND ';
      strFiltro := strFiltro + 'DET_ESPDOC = ' + QuotedStr(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString) + ' AND ';
      strFiltro := strFiltro + 'DET_CODCLI = ' + QuotedStr(fatVenda.strCodCli) + ' AND ';
      strFiltro := strFiltro + 'DET_CODEMP = ' + QuotedStr(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString) + ' ';

      cdsItensConf.Filtered := False;
      cdsItensConf.Filter   := strFiltro + ' AND DET_CODITE IN (' + QuotedStr(fCfgSis('ITESER')) + ', ' + QuotedStr(fCfgSis('SERTER')) + ')  ';
      cdsItensConf.Filtered := True;

      qryItens := cdsItensConf;
    End
    Else
    Begin
      dtsGenDet := fCriaDataSource(qryGenDet);

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  DET_CODITE, ';
      strSQL := strSQL + '  DET_DESCRI, ';
      strSQL := strSQL + '  DET_UNIDAD, ';
      strSQL := strSQL + '  DET_QTDITE, ';
      strSQL := strSQL + '  DET_UNITAR, ';
      strSQL := strSQL + '  DET_TOTITE, ';
      strSQL := strSQL + '  DET_DESESP, ';
      strSQL := strSQL + '  DET_VALRET, ';
      strSQL := strSQL + '  DET_VALIPI, ';
      strSQL := strSQL + '  ' + fSqlCampoReformaRef('MOVREF', 'REF_CBSVAL', 'MOVDET.AUTOINCREM') + ' AS DET_VALCBS, ';
      strSQL := strSQL + '  ' + fSqlCampoReformaRef('MOVREF', 'REF_VALIBS', 'MOVDET.AUTOINCREM') + ' AS DET_VALIBS, ';
      strSQL := strSQL + '  ' + fSqlCampoReformaRef('MOVREF', 'REF_SELVAL', 'MOVDET.AUTOINCREM') + ' AS DET_VAL_IS, ';
      strSQL := strSQL + '  DET_CLAFIS ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  MOVDET ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  DET_JAFATU = FALSE AND ';
      strSQL := strSQL + '  IF((DET_SEQTIN IS NOT NULL AND DET_SEQTIN <> ""), DET_PROEMB <> "S", ' + fFiltroProEmb + ') AND ';
      strSQL := strSQL + '  DET_NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + '  DET_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  DET_CODCLI = :CODCLI AND ';
      strSQL := strSQL + '  DET_CODEMP = :CODEMP ';

      {*******************************************}
      {* TOTALIZA O SERVIÇO                      *}
      {****************************************MV*}
      With qryGenDet Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL + ' AND (DET_CODITE = :ITESER OR DET_CODITE = :SERTER) ');
        ParamByName('NUMDOC').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString;
        ParamByName('ESPDOC').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString;
        ParamByName('CODCLI').AsString := fatVenda.strCodCli;
        ParamByName('CODEMP').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString;
        ParamByName('ITESER').AsString := fCfgSis('ITESER');
        ParamByName('SERTER').AsString := fCfgSis('SERTER');
        Open;

      End;

      qryItens := qryGenDet;

    End;

    fltTotGer := 0.0;
    fltDesEsp := 0.0;
    fltTotSer := 0.0;
    fltTotIpi := 0.0;
    fltTotRet := 0.0;
    fltTotCbs := 0.0;
    fltTotIbs := 0.0;
    fltTotIs  := 0.0;

    While Not qryItens.Eof Do
    Begin
      fltTotSer := fltTotSer + qryItens.FieldByName('DET_TOTITE').AsFloat;
      qryItens.Next;
    End;

    If fGetSintetizarDV Then
    Begin
      cdsItensConf.Filtered := False;
      cdsItensConf.Filter   := strFiltro + ' AND DET_CODITE <> ' + QuotedStr(fCfgSis('ITESER')) + ' ';
      cdsItensConf.Filter   := cdsItensConf.Filter + ' AND DET_CODITE <> ' + QuotedStr(fCfgSis('SERTER')) + ' ';
      cdsItensConf.Filtered := True;
    End
    Else
    Begin

      With qryGenDet Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL + ' AND DET_CODITE <> :ITESER AND DET_CODITE <> :SERTER ');
        ParamByName('NUMDOC').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString;
        ParamByName('ESPDOC').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString;
        ParamByName('CODCLI').AsString := fatVenda.strCodCli;
        ParamByName('CODEMP').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString;
        ParamByName('ITESER').AsString := fCfgSis('ITESER');
        ParamByName('SERTER').AsString := fCfgSis('SERTER');
        Open;
      End;

    End;

    (qryItens.FieldByName('DET_QTDITE') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    (qryItens.FieldByName('DET_UNITAR') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
    (qryItens.FieldByName('DET_TOTITE') As TFloatField).DisplayFormat := '#,##0.00';

    While Not qryItens.Eof Do
    Begin
      fltTotGer := fltTotGer + qryItens.FieldByName('DET_TOTITE').AsFloat;
      fltDesEsp := fltDesEsp + qryItens.FieldByName('DET_DESESP').AsFloat;
      fltTotIpi := fltTotIpi + qryItens.FieldByName('DET_VALIPI').AsFloat;
      fltTotRet := fltTotRet + qryItens.FieldByName('DET_VALRET').AsFloat;
      fltTotCbs := fltTotCbs + qryItens.FieldByName('DET_VALCBS').AsFloat;
      fltTotIbs := fltTotIbs + qryItens.FieldByName('DET_VALIBS').AsFloat;
      fltTotIs  := fltTotIs  + qryItens.FieldByName('DET_VAL_IS').AsFloat;

      qryItens.Next;
    End;

    If (fatVenda.blnMeiaNota) Then
      fltDesEsp := 0;

    qryItens.First;

    Try
      pCriarFormularios(TfrmFatMostraProdConfirmacao, frmFatMostraProdConfirmacao);

      frmFatMostraProdConfirmacao.dbgItens.Columns[0].FieldName := 'DET_CODITE';
      frmFatMostraProdConfirmacao.dbgItens.Columns[1].FieldName := 'DET_DESCRI';
      frmFatMostraProdConfirmacao.dbgItens.Columns[2].FieldName := 'DET_UNIDAD';
      frmFatMostraProdConfirmacao.dbgItens.Columns[3].FieldName := 'DET_QTDITE';
      frmFatMostraProdConfirmacao.dbgItens.Columns[4].FieldName := 'DET_UNITAR';
      frmFatMostraProdConfirmacao.dbgItens.Columns[5].FieldName := 'DET_TOTITE';

      frmFatMostraProdConfirmacao.dbgItens.DataSource := dtsGenDet;
      frmFatMostraProdConfirmacao.edtTotSer.Text      := FormatFloat('#,##0.00', fltTotSer);
      frmFatMostraProdConfirmacao.edtTotGer.Text      := FormatFloat('#,##0.00', fltTotGer);
      frmFatMostraProdConfirmacao.edtTotIpi.Text      := FormatFloat('#,##0.00', fltTotIpi);
      frmFatMostraProdConfirmacao.edtTotST.Text       := FormatFloat('#,##0.00', fltTotRet);
      frmFatMostraProdConfirmacao.edtDesEsp.Text      := FormatFloat('#,##0.00', fltDesEsp);
      frmFatMostraProdConfirmacao.edtTotLiq.Text      := FormatFloat('#,##0.00', fltTotGer - fltDesEsp + fltTotSer + fltTotIpi + fltTotRet +
                                                                                 fltTotCbs + fltTotIbs + fltTotIs);
      frmFatMostraProdConfirmacao.pExibirNovosImpostos(fltTotCbs, fltTotIbs, fltTotIs);
      frmFatMostraProdConfirmacao.Caption             := frmFatMostraProdConfirmacao.Caption + fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString + ' - ' +
                                                                                               fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString + ' - ' +
                                                                                               fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString;
      frmFatMostraProdConfirmacao.showModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmFatConfDocumentos.pCarregaItensDocumento]');
      End;
    End;

    pFreeAndNil(frmFatMostraProdConfirmacao);

    (qryItens.FieldByName('DET_QTDITE') As TFloatField).DisplayFormat := '';
    (qryItens.FieldByName('DET_UNITAR') As TFloatField).DisplayFormat := '';
    (qryItens.FieldByName('DET_TOTITE') As TFloatField).DisplayFormat := '';

    qryItens.Filter   := '';
    qryItens.Filtered := False;

  Finally
    FreeAndNil(dtsGenDet);
    FreeAndNil(qryGenDet);
  End;

end;

procedure TConfirmacaoDocumentos.fVerificarMarcarComoNaoSintetizavel;
 Var
   strSQL: String;
   qryTabCnf : TUniQuery;
   strNumDocAux,
   strEspDocAux,
   strCodEmpAux,
   strStatusAux: String;
   intCont: Integer;

   Function fRetStatusDoc(strNumDoc, strEspDoc, strCodEmp: String): String;
   Begin
     Result := fCampoTabela('CONCAT(IFNULL(TMP_PODSIN, ""), IFNULL(TMP_DUPBAI, ""))',
               fatVenda.strTabelaConfMi,
               ['TMP_NUMDOC', 'TMP_ESPDOC', 'TMP_CODEMP'],
               [strNumDoc, strEspDoc, strCodEmp]);
   End;

   Procedure pAtribuiNumDoc(qry: TUniQuery);
   Begin
     strNumDocAux := qry.FieldByName('NUMDOC').AsString;
     strEspDocAux := qry.FieldByName('ESPDOC').AsString;
     strCodEmpAux := qry.FieldByName('CODEMP').AsString;
   End;

   Function fTemDivergencias(qry: TUniQuery; strPodSin, strDupBai: String): Boolean;
   Begin
     Result := False;

     qry.First;
     While Not qry.Eof Do
     Begin
       pAtribuiNumDoc(qry);
       strStatusAux := fRetStatusDoc(strNumDocAux, strEspDocAux, strCodEmpAux);

       //COMPARA SE O DOC ESTÁ LIBERADO PARA SINTETIZAÇÃO E A SITUAÇÃO FINANCEIRA ESTÁ IGUAL
       If (Not fEmptyStr(strStatusAux)) And (strStatusAux <> (strPodSin+strDupBai)) Then
       Begin
         Result := True;
         Break;
       End;

       qry.Next;
     End;
   End;

   Function fTemAoMenosUmDocRelacionadoVisivel(qry: TUniQuery): Boolean;
   Begin
     Result := False;

     qry.First;
     While Not qry.Eof Do
     Begin
       pAtribuiNumDoc(qry);
       strStatusAux := fRetStatusDoc(strNumDocAux, strEspDocAux, strCodEmpAux);

       If (Not fEmptyStr(strStatusAux)) Then
       Begin
         Result := True;
         Break;
       End;

       qry.Next;
     End;
   End;

   Procedure fMarcarTodosOsRegistrosFilhos(qry: TUniQuery; strPodSin: String);
   Begin
     qry.First;
     While Not qry.Eof Do
     Begin
       pAtribuiNumDoc(qry);
       pMarcarDesmarcarPodeSintetizar(strNumDocAux, strEspDocAux, strCodEmpAux, strPodSin);

       qry.Next;
     End;
   End;

   Procedure pBuscarMarcarDocsFaturamentoDaDevolucao(strNumDoc, strCodEmp, strDupBai, strPodSin: String);
     Var
      strSQL: String;
      qryDet : TUniQuery;
   Begin
     strSQL := '';
     strSQL := strSQL + ' SELECT DET_DOCDEV AS NUMDOC, ' ;
     strSQL := strSQL + '        DET_ESPDEV AS ESPDOC, ' ;
     strSQL := strSQL + '        DET_EMPDEV AS CODEMP ' ;
     strSQL := strSQL + ' FROM MOVDET       ' ;
     strSQL := strSQL + ' WHERE DET_NUMDOC = ' + QuotedStr(strNumDoc);
     strSQL := strSQL + '   AND DET_ESPDOC = "DV" ';
     strSQL := strSQL + '   AND DET_CODEMP = ' + QuotedStr(strCodEmp);

     qryDet := fCriarQuery(strSQL);
     Try
       qryDet.Open;

       If (strPodSin = 'S') Then
       Begin
         {**********************************************************************}
         {* CASO A "DV" SEJA PASSÍVEL DE SINTETIZAÇÃO AUTOMÁTICA, VERIFICA SE  *}
         {* TODOS DOCUMENTOS DE FATURAMENTO ESTÃO NA MESMA SITUAÇÃO FINANCEIRA *}
         {* CASO NÃO ESTEJA, MARCA A "DV" E OS DOCS DE FAT. COMO NÃO           *}
         {* SINTETIZÁVEL                                                       *}
         {*******************************************************************VA*}
         If fTemDivergencias(qryDet, strPodSin, strDupBai) Then
         Begin
           fMarcarTodosOsRegistrosFilhos(qryDet, 'N'); //DOCS. DE FATURAMENTO
           pMarcarDesmarcarPodeSintetizar(strNumDoc, 'DV', strCodEmp, 'N'); //DEVOLUÇÃO
         End;
       End
       Else If (strPodSin = 'N') Then
       Begin
         {**********************************************************************}
         {* CASO A "DV" JÁ VENHA COMO NÃO SINTETIZAVEL VERIFICA SE NA          *}
         {* TEMPORARIA DE CONFIRMAÇÃO EXISTE PELO MENOS UM DOC. DE FAT.        *}
         {* RELACIONADO QUE EVENTUALMENTE PODERIA SER SINTETIZADO              *}
         {* AUTOMATICAMENTE, CASO NÃO EXISTA PASSA VAZIO PARA O CAMPO          *}
         {* "TMP_PODSIN" SÓ PARA NÃO FICAR DESTACADO COM OUTRA COR,            *}
         {* MESMO PORQUE A ROTINA NUNCA CONSEGUIRIA FAZER SUA SINTETIZAÇÃO.    *}
         {* SENÃO, MARCA TODOS OS DOCS. DE FAT RELACIONADOS                    *}
         {*******************************************************************VA*}
         If Not fTemAoMenosUmDocRelacionadoVisivel(qryDet) Then
           pMarcarDesmarcarPodeSintetizar(strNumDoc, 'DV', strCodEmp, '') //DEVOLUÇÃO
         Else
           fMarcarTodosOsRegistrosFilhos(qryDet, 'N') //DOCS. DE FATURAMENTO
       End;

     Finally
       FreeAndNil(qryDet);
     End
   End;

   Procedure pBuscarMarcarDevolucoesDoDocFaturamento(strNumDoc, strEspDoc, strCodEmp, strDupBai, strPodSin: String);
     Var
      strSQL: String;
      qryDet : TUniQuery;
   Begin
     strSQL := '';
     strSQL := strSQL + ' SELECT DET_NUMDOC AS NUMDOC, ';
     strSQL := strSQL + '        DET_ESPDOC AS ESPDOC, ';
     strSQL := strSQL + '        DET_CODEMP AS CODEMP  ';
     strSQL := strSQL + ' FROM MOVDET       ' ;
     strSQL := strSQL + ' WHERE DET_DOCDEV = ' + QuotedStr(strNumDoc);
     strSQL := strSQL + '   AND DET_ESPDEV = ' + QuotedStr(strEspDoc);
     strSQL := strSQL + '   AND DET_EMPDEV = ' + QuotedStr(strCodEmp);

     qryDet := fCriarQuery(strSQL);
     Try
       qryDet.Open;

       If (strPodSin = 'S') Then
       Begin
         {**********************************************************************}
         {* CASO O DOC. DE FAT. SEJA PASSÍVEL DE SINTETIZAÇÃO AUTOMÁTICA,      *}
         {* VERIFICA SE TODOS DOCUMENTOS DE FATURAMENTO ESTÃO NA MESMA SITUAÇÃO*}
         {* FINANCEIRA CASO NÃO ESTEJA, MARCA O DOC DE FAT. E AS "DVS" E COMO  *}
         {* NÃO SINTETIZÁVEL                                                   *}
         {*******************************************************************VA*}
         If fTemDivergencias(qryDet, strPodSin, strDupBai) Then
         Begin
           fMarcarTodosOsRegistrosFilhos(qryDet, 'N'); //DEVOLUÇÕES
           pMarcarDesmarcarPodeSintetizar(strNumDoc, strEspDoc, strCodEmp, 'N'); //DOC. DE FATURAMENTO
         End;
       End
       Else If (strPodSin = 'N') Then
       Begin
         {**********************************************************************}
         {* SE NÃO PODE SINTETIZAR O DOC. DE FATURAMENTO AS DEVOLUÇÕES         *}
         {* CORRESPONDENTES TAMBÉM NÃO PODERÃO                                 *}
         {*******************************************************************VA*}
         fMarcarTodosOsRegistrosFilhos(qryDet, 'N') //DEVOLUÇÕES
       End;

     Finally
       FreeAndNil(qryDet);
     End
   End;

   procedure pProcessaTabCnf;
   begin
     qryTabCnf.First;

     If Assigned(FProgress) Then
     Begin
       FProgress.Visible := True;
       FProgress.Max := qryTabCnf.RecordCount;
       FProgress.Position := 0;
     End;

     While Not qryTabCnf.Eof Do
     Begin
       If (qryTabCnf.FieldByName('TMP_ESPDOC').AsString = 'DV') Then
       Begin
         pBuscarMarcarDocsFaturamentoDaDevolucao(qryTabCnf.FieldByName('TMP_NUMDOC').AsString,
                                                 qryTabCnf.FieldByName('TMP_CODEMP').AsString,
                                                 qryTabCnf.FieldByName('TMP_DUPBAI').AsString,
                                                 qryTabCnf.FieldByName('TMP_PODSIN').AsString);
       End
       Else
       Begin
         pBuscarMarcarDevolucoesDoDocFaturamento(qryTabCnf.FieldByName('TMP_NUMDOC').AsString,
                                                 qryTabCnf.FieldByName('TMP_ESPDOC').AsString,
                                                 qryTabCnf.FieldByName('TMP_CODEMP').AsString,
                                                 qryTabCnf.FieldByName('TMP_DUPBAI').AsString,
                                                 qryTabCnf.FieldByName('TMP_PODSIN').AsString);
       End;

       If Assigned(FProgress) Then
         FProgress.StepBy(1);

       Application.ProcessMessages;

       qryTabCnf.Next;
     End;

     If Assigned(FProgress) Then
       FProgress.Visible := False;
   end;

begin
  strSQL := '';
  strSQL := strSQL + ' SELECT TMP_NUMDOC, ';
  strSQL := strSQL + '        TMP_ESPDOC, ';
  strSQL := strSQL + '        TMP_CODEMP, ';
  strSQL := strSQL + '        TMP_DUPBAI, ';
  strSQL := strSQL + '        TMP_PODSIN  ';
  strSQL := strSQL + ' FROM ' + fatVenda.strTabelaConfMi;
  strSQL := strSQL + ' ORDER BY TMP_ESPDOC, TMP_PODSIN ';

  qryTabCnf := fCriarQuery(strSQL);
  Try
    {**********************************************************************}
    {* COMO É UMA RELAÇÃO MN, FAZ 4 INTERAÇÕES PARA MARCAR TODOS AS       *}
    {* "DVS" DOS "DOCS. FATS". X "FATS. DOCS." DAS "DVS"                  *}
    {*******************************************************************VA*}
    For intCont:=1 To 4 Do
    begin
      qryTabCnf.Close;
      qryTabCnf.Open;

      pProcessaTabCnf;
    End;

    qryTabCnf.First;
    While Not qryTabCnf.Eof Do
    Begin
      If (qryTabCnf.FieldByName('TMP_ESPDOC').AsString <> 'DV') Then
        pMarcarDesmarcarPodeSintetizar(qryTabCnf.FieldByName('TMP_NUMDOC').AsString,
                                       qryTabCnf.FieldByName('TMP_ESPDOC').AsString,
                                       qryTabCnf.FieldByName('TMP_CODEMP').AsString,
                                       '');

      qryTabCnf.Next;
    End;
  Finally
    FreeAndNil(qryTabCnf);
  End;
end;

function TConfirmacaoDocumentos.fDuplicataDeCreditoLiberada(ANumDup, AParcel, AEspDoc, ACodEmp, ACodCli: string): Boolean;
var
  FDuplicatas: TArrayDuplicatasCredito;
  FDuplicata: TDuplicatasCredito;
begin
  Result := True;

  If Pos(AEspDoc, 'NF_DV_') = 0 Then
    Exit;

  FDuplicata.NumDup := ANumDup;
  FDuplicata.Parcel := AParcel;
  FDuplicata.EspDoc := AEspDoc;
  FDuplicata.CodEmp := ACodEmp;
  FDuplicata.CodCli := ACodCli;

  SetLength(FDuplicatas, Length(FDuplicatas)+1);

  FDuplicatas[High(FDuplicatas)] := FDuplicata;

  Result := fDuplicataCreditoLiberada(FDuplicatas);

  SetLength(FDuplicatas, 0);
end;

function TConfirmacaoDocumentos.fMarcaDocumento(blnMarcar: Boolean; Var strMsgFunc: String; blnEmLoop: Boolean=False): Boolean;

  Var
    blnSomenteServ: Boolean;
    blnPossuiServ : Boolean;
    blnValidaServ : Boolean;
    blnValidaConcr: Boolean;
    strInformacao : String;
    strMsgAux     : String;
    strChaLck     : String;
    intSerDoc     : Integer;
    strVenPre     : String;
    strCliCon     : String;
    strCodTra     : String;
    blnSomenteServOutraEmpresa: Boolean;

    function fTemp(strCampo: String; blnComTmp: Boolean = True): TField;
    begin
      Result := fatVenda.qryTemporariaConfirmacao.FieldByName(IIF(blnComTmp, 'TMP_','') + strCampo);
    end;

    function fRetConsum():String;
    var
      qryAux: TUniQuery;
      strSQL: String;
    begin
      Result := '';
      qryAux := fCriaQuery();

      Try
        strSQL := '';
        strSQL := strSQL + '  SELECT                                                 ';
        strSQL := strSQL + '    DISTINCT(TMP_CONSUM) CONSUM                          ';
        strSQL := strSQL + '  FROM                                                   ';
        strSQL := strSQL + fatVenda.strTabelaConfMi;
        strSQL := strSQL + '  WHERE                                                  ';
        strSQL := strSQL + '    TMP_MARDES = "M"                                     ';
        strSQL := strSQL + '    AND (LOCATE(TMP_CLAFIS, "' + VS_strClaDev + '") = 0) ';

        qryAux.SQL.Add(strSQL);
        qryAux.Open;

        Result := qryAux.FieldByName('CONSUM').AsString;
      Finally
        FreeAndNil(qryAux);
      End;
    end;

begin
  Result    := False;
  intSerDoc := 0;

  If (fatVenda.qryTemporariaConfirmacao.IsEmpty) Then
    Exit;

  If fTravaMovDetMenor(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString,
                       fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString,
                       fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString,
                       fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODCLI').AsString) Then
  Begin
    fMensagem('ATENÇÃO!','O documento informado ainda não está totalmente replicado.'+#13+
                         'Por favor, aguarde alguns minutos e tente novamente.', ['&OK']);
    Exit;
  End;

  If DocumentoComPixGeradoEAtivo(fTemp('NUMDOC').AsString,
                                 fTemp('ESPDOC').AsString,
                                 fTemp('CODEMP').AsString,
                                 fTemp('CODCLI').AsString) Then
  Begin
    fMensagem('ATENÇÃO!','O documento informado não pode ser selecionado, pois possui Pix gerado e não recebido.' + #13 +
                         'Faça/aguarde o recebimento do Pix ou remova do documento em Relação de Documentos com Pix Gerados.', ['&OK']);
    Exit;
  End;

  If (fValidaProdutoTintaOutraEmpresa(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString,
                                      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString,
                                      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString,
                                      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODCLI').AsString)) And
     (Not fCfgSis('USATMQ', VarBoolean)) Then
  Begin
    strMsgTinta := strMsgTinta + fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString +'-'+
                                 fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString+'-'+
                                 fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString;
    fMensagem('', Format(strMensagemFixaTinta, [strMsgTinta]), ['&Ok']);
    Exit;
  End;

  If Assigned(pInformacoes) Then pInformacoes('Aguarde... Selecionando documento(s)!');

  fatVenda.stlCadRecDtaLogDocsConf.Add(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString +
                                       fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString +
                                       fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString +
                                       fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODCLI').AsString + '-' +
                                       fatVenda.qryTemporariaConfirmacao.FieldByName('SAV_DHLOCT').AsString);

  strChaLck := 'CADREC' +
               fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString +
               fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString +
               fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString +
               fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODCLI').AsString;

  If fCfgSis('USASER', varBoolean) Then
  Begin
    blnValidaServ := True;
    FTemSer       := fatVenda.fRetServDocMarcados(True);
    blnPossuiServ := fDocumentoPossuiServicos(fTemp('NUMDOC').AsString,
                                              fTemp('ESPDOC').AsString,
                                              fTemp('CODEMP').AsString,
                                              blnSomenteServ);

    If (blnPossuiServ) Then
      intSerDoc := fQtdServicos(fTemp('NUMDOC').AsString,
                                fTemp('ESPDOC').AsString,
                                fTemp('CODEMP').AsString);

    blnSomenteServOutraEmpresa := False;

    If blnPossuiServ And (not blnSomenteServ) And (VS_StrCodEmp <> fTemp('CODEMP').AsString) Then
    Begin
      fDocumentoPossuiServicos(fTemp('NUMDOC').AsString,
                               fTemp('ESPDOC').AsString,
                               fTemp('CODEMP').AsString,
                               blnSomenteServOutraEmpresa,
                               False, True);
    End;
  End
  Else
  Begin
    FTemSer       := '';
    blnValidaServ := False;
    blnPossuiServ := False;
    blnSomenteServOutraEmpresa := False;
  End;

  {****************************************************}
  {* DEFINE SE O PRIMEIRO DOCUMENTO FF SELECIONADO É: *}
  {*  * COM PROFISSIONAL                              *}
  {*  * SEM PROFISSIONAL                              *}
  {*************************************************MM*}
  If (fTemp('ESPDOC').AsString = 'FF') And
     (fCfgSis('TCOPRO') = '2')         And
     (fCfgSis('PREFEC', varBoolean))   And
     (FTipoDoc = opcNenhum) Then
  Begin
    FTipoDoc := fSetTipoDoc(fTemp('NUMDOC').AsString,
                            fTemp('ESPDOC').AsString,
                            fTemp('CODCLI').AsString,
                            fTemp('CODEMP').AsString);

    If FTipoDoc = opcComProfissional Then
      FCodDiv := fRetProfissional(fTemp('NUMDOC').AsString,
                                  fTemp('ESPDOC').AsString,
                                  fTemp('CODCLI').AsString,
                                  fTemp('CODEMP').AsString);
  End;

  fatVenda.strConfSer:= FTemSer;

  If fCfgSis('USACCR', varBoolean) Then
  Begin
    blnValidaConcr := True;
    FTemCcr        := fatVenda.fRetConcretosDocMarcados(True);
  End
  Else
  Begin
    FTemCcr        := '';
    blnValidaConcr := False;
  End;

  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    If (blnMarcar) And (fExisteDocumentoContaOrdemComRemessaNaoEmitidaNF(fTemp('NUMDOC').AsString,
                                                                         fTemp('ESPDOC').AsString,
                                                                         fTemp('CODEMP').AsString)) Then
    Begin
      Exit;
    End;

    If blnMarcar Then
    Begin

      {*****************************************}
      {* VERIFICA SE HÁ ALGUMA DUPLICATA TRAVA-*}
      {* DA NO RESUMO DE CAIXA.                *}
      {**************************************MV*}
      If Not fEmptyStr(fGetHostLock(strChaLck + '%')) Then
      Begin
        fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strChaLck + '%'), ['&Ok']);
        Exit;
      End;

      If (blnPossuiServ) Then
      Begin
        If ((intQtdSer + intSerDoc) > fCfgSis('LINSER',varInteger)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A quantidade de serviços selecionados ultrapassou o limite permitido!', ['&Ok']);
          Exit;
        End
        Else
          intQtdSer := intQtdSer + intSerDoc;
      End;

      If fCfgSis('USOREV', varBoolean) Then
      Begin
        strCliCon := fRetConsum();

        If (Not fEmptyStr(strCliCon)) And (strCliCon <> fTemp('CONSUM').AsString) Then
        Begin
          If (strCliCon = 'S') Then
            fMensagem('','Não é possível selecionar um documento gravado como Revenda. ' + #13#10 +
                         'Já foram selecionados documentos gravados como Uso/Consumo!', ['&Ok'])
          Else
            fMensagem('','Não é possível selecionar um documento gravado como Uso/Consumo.' + #13#10 +
                         'Já foram selecionados documentos gravados como Revenda!', ['&Ok']);
          Exit;
        End;

        If (fatVenda.strCliCon <> fTemp('CONSUM').AsString) Then
          fatVenda.strCliCon := fTemp('CONSUM').AsString;

        If (fatVenda.strTpOper <> fTemp('TPOPER').AsString) Then
          fatVenda.strTpOper := fTemp('TPOPER').AsString;

        fatVenda.pRedefineTipoAbf;
      End;

      strVenPre := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_VENPRE)', fatVenda.strTabelaConfMi, ['TMP_MARDES','SAV_SINTET','TMP_ESPDOC <>'], ['M','N','DV']);

      If (Not fEmptyStr(strVenPre)) And (strVenPre <> (qryConfirmacao.FieldByName('TMP_VENPRE').AsString)) Then
      Begin
        fMensagem('','Existem documentos com venda presencial e outros não, por isso não será possível selecionar este documento de venda!', ['&Ok']);
        Exit;
      End;

      If Not fPodeMarcarEntregaRetira(qryConfirmacao, fatVenda.strTabelaConfMi) Then
      Begin
        Exit;
      End;

      If blnMarcar And fCfgSis('CADFAZ', varBoolean) And (strToIntDef(FQtdDocSel, 0) > 0) Then
      Begin
        FCodFaz := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_CODFAZ)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);

        If FCodFaz <> fTemp('CODFAZ').AsString Then
        Begin
          fMensagem('','Não é possível selecionar documentos de Fazendas diferentes. ' + #13#10 +
                       'Já selecionado: (' + FCodFaz + ')' + #13#10 +
                       'Selecionando: (' + fTemp('CODFAZ').AsString + ')', ['&Ok']);
          Exit;
        End;
      End;

      If (blnMarcar) And 
         (fTemp('ESPDOC').AsString = 'DV') And 
         (fTemp('DEVCNF').AsString = 'S') And 
         (Not fDuplicataDeCreditoLiberada(fTemp('NUMDOC').AsString, 
                                          '',
                                          fTemp('ESPDOC').AsString, 
                                          fTemp('CODEMP').AsString, 
                                          fTemp('CODCLI').AsString)) Then
      Begin
        Exit;
      End;

      if (blnMarcar) and
         (not Self.CarregaItensJaFaturado) and
         (fDocumentoFaturado(fTemp('NUMDOC').AsString, fTemp('ESPDOC').AsString, fTemp('CODEMP').AsString, fTemp('CODCLI').AsString, fTemp('NOMTAB').AsString)) then
      begin
        fMensagem('','O documento selecionado já encontra-se faturado, favor efetuar a consulta novamente para recarregar os documentos!', ['&OK']);
        Exit;
      end;

      If blnMarcar And fCfgSis('CADEMB', varBoolean) And (strToIntDef(FQtdDocSel, 0) > 0) Then
      Begin
        FCodEmb := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_CODEMB)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);

        If (Pos(fTemp('CODEMB').AsString, FCodEmb) <= 0)  Then
        Begin
          If not (fEmptyStr(FCodEmb) And fEmptyStr(fTemp('CODEMB').AsString)) Then
          Begin
            fMensagem('','Não é possível selecionar documentos de Embarcações diferentes. ' + #13#10 +
                         'Já selecionado: (' + fRedCodEmb(AnsiReplaceStr(FCodEmb, ',', '')) + ')' + #13#10 +
                         'Selecionando: (' +   fRedCodEmb(fTemp('CODEMB').AsString) + ')', ['&Ok']);
            Exit;
          End;
        End;
      End;

      If (fCfgSis('CFFMAT', varBoolean)) And (fTemp('CODEMP').AsString <> VS_strCodEmp) Then
      Begin
        If (Not fEmptyStr(fCfgSis('EMPCNF'))) And (Pos(fTemp('CODEMP').AsString, fCfgSis('EMPCNF')) <= 0) Then
        Begin
          fMensagem('','Empresa não possui permissão para confirmar documentos da Empresa '+ fTemp('CODEMP').AsString +'!'+ sLineBreak +
                       'Verifique a configuração [CFG_EMPCNF].', ['&Ok']);
          Exit;
        End;
      End;

      If (fTemp('ESPDOC').AsString = 'FF') And
         (fCfgSis('TCOPRO') = '2')         And
         (fCfgSis('PREFEC', varBoolean))   Then
      Begin
        {***************************************************}
        {* NÃO PERMITE QUE O USUÁRIO SELECIONE UMA FF QUE  *}
        {* QUE PAGUE COMISSÃO PARA MAIS DE UM PROFISSIONAL *}
        {************************************************MM*}
        If (fTemProfissional(fTemp('NUMDOC').AsString,
                             fTemp('ESPDOC').AsString,
                             fTemp('CODCLI').AsString,
                             fTemp('CODEMP').AsString,
                             True)) Then
        Begin
          fMensagem('', 'Não é permitida a confirmação de documentos com dois ou mais profissionais cadastrados!', ['&Ok']);
          Exit;
        End;

        {*****************************************************}
        {* NÃO PERMITE QUE O USUÁRIO SELECIONE UMA FF QUE    *}
        {* SEJA DIFERENTE DO TIPO DA PRIMEIRA FF SELECIONADA *}
        {**************************************************MM*}
        If (FTipoDoc <> opcNenhum) And
           (FTipoDoc <> fSetTipoDoc(fTemp('NUMDOC').AsString,
                                    fTemp('ESPDOC').AsString,
                                    fTemp('CODCLI').AsString,
                                    fTemp('CODEMP').AsString)) Then
        Begin
          If FTipoDoc = opcComProfissional Then
            fMensagem('', 'Selecione somente documentos COM Profissional!', ['&Ok'])
          Else
            fMensagem('', 'Selecione somente documentos SEM Profissional!', ['&Ok']);
          Exit;
        End;

        {*******************************************************}
        {* NÃO PERMITE QUE O USUÁRIO SELECIONE UMA FF QUE TENHA*}
        {* UM PROFISSIONAL DIFERENTE DO QUE JÁ FOI SELECIONADO *}
        {****************************************************MM*}
        If (FTipoDoc = opcComProfissional) And
           (FCodDiv <> fRetProfissional(fTemp('NUMDOC').AsString,
                                        fTemp('ESPDOC').AsString,
                                        fTemp('CODCLI').AsString,
                                        fTemp('CODEMP').AsString)) Then
        Begin
          fMensagem('', 'Selecione somente documentos com o Profissional: ' + #13 +
                         FCodDiv + ' - ' + fRetNomeProfissional(FCodDiv), ['&Ok']);
          Exit;
        End;
      End;

      If (fCfgSis('TRADOC', varBoolean)) Then
      Begin
        strCodTra := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_CODTRA)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);

        If (Not fEmptyStr(strCodTra)) And (strCodTra <> fTemp('CODTRA').AsString) Then
        Begin
          If fMensagem('', 'Este documento tem Transportadora diferente da Transportadora dos documentos selecionados.' + sLineBreak +
                             'No final, será solicitado senha de liberação, para realização deste procedimento. Confirma?', ['&Sim', '&Não']) = 2 Then
            Exit;
        End;
      End;

      If fatVenda.fUltrapassouLimiteItensNFe(FItensDocs + fTemp('ITEDOC').AsInteger, '', strInformacao) Then
      Begin
        pMensagemSonora(strInformacao);
      End
      Else
      Begin

        If (Pos(fTemp('ESPDOC').AsString, 'MI_FF_') > 0) And
                 fEhConfirmacaoBaixa(fTemp('ESPDOC').AsString,
                                     fTemp('NUMDOC').AsString,
                                     fTemp('CODEMP').AsString) Then
        Begin
          fMensagem('', 'Documento de Baixa de Entrega Futura não pode ser confirmado. ' + #13 +
                        'Cancele o documento e baixe a Entrega Futura em Nota Fiscal se desejar.', ['&Ok']);
        End

        Else If blnValidaServ And blnPossuiServ And blnSomenteServOutraEmpresa Then
        Begin
          fMensagem('','O item serviço da loja logada é diferente da loja do documento selecionado.'+#13+
                       'É necessário alinhar o item serviço entre as lojas "CFG_ITESER" '+#13+
                       'ou emitir a nota na empresa de origem do documento', ['&OK']);
        End

        Else If blnValidaServ And blnPossuiServ And (Not blnSomenteServ) Then
        Begin
          fMensagem('','O documento possui produtos e serviços, portanto não é possível selecionar o mesmo!', ['&OK']);
        End

        Else If blnValidaServ And (Not fEmptyStr(FTemSer)) And (fTemp('TEMSER').AsString <> FTemSer) Then
        Begin
          If FTemSer = 'S' Then
            fMensagem('','Já existem documentos selecionados com serviços, portanto não é possível selecionar documento com produtos!', ['&OK'])
          Else
            fMensagem('','Já existem documentos selecionados com produtos, portanto não é possível selecionar documento com serviços!', ['&OK']);
        End

        Else If blnValidaConcr And (Not fEmptyStr(FTemCcr)) And (fTemp('TEMCCR').AsString <> FTemCcr) Then
        Begin
          If FTemCcr = 'S' Then
            fMensagem('','Já existem documentos selecionados com produtos concreto, portanto não é possível selecionar documento com outro tipo de produtos!', ['&OK'])
          Else
            fMensagem('','Já existem documentos selecionados com produtos não concreto, portanto não é possível selecionar documento com concreto!', ['&OK']);
        End

        Else If (fEmptyStr(strEspSel))                   Or
           (strEspSel = fTemp('ESPDOC').AsString)        Or
           (Pos(strEspSel, FstlDocSel.CommaText) <= 0)   Or
           (Pos(fTemp('ESPDOC').AsString, 'TR_DV_') > 0) Or
           (Pos(strEspSel, 'TR_DV_') > 0)                Then
        Begin

          If (Not fatVenda.objLock.fLock_Unlock(strChaLck, True, False)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strChaLck), ['&Ok']);
          End
          Else
          Begin
            If (Pos(fTemp('ESPDOC').AsString, 'TR_DV_') <= 0) Then
              strEspSel := fTemp('ESPDOC').AsString;

            Edit;
            fTemp('MARDES').AsString := 'M';
            fTemp('SEQMAR').AsInteger := fRetSeqMar;
            Post;

            FstlDocSel.Add(fTemp('NUMDOC').AsString + fTemp('ESPDOC').AsString + fTemp('CODEMP').AsString);

            If blnValidaServ And fEmptyStr(FTemSer) Then
              FTemSer := fTemp('TEMSER').AsString;

            If blnValidaConcr And fEmptyStr(FTemCcr) Then
              FTemCcr := fTemp('TEMCCR').AsString;

            FCodFaz := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_CODFAZ)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);
            FCodEmb := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_CODEMB)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);

            Result := True;
          End;

        End
        Else
        Begin
          strMsgAux := 'Só é permitido selecionar documentos de mesma espécie!';
          If blnEmLoop Then
          Begin
            If Pos(strMsgAux, strMsgFunc) <= 0 Then
              strMsgFunc := strMsgAux;
          End
          Else
            fMensagem('', strMsgAux, ['&Ok']);
        End;
      End;

    End
    Else
    Begin
      fatVenda.objLock.fLock_Unlock(strChaLck, False);

      If (blnPossuiServ) Then
        intQtdSer := intQtdSer - intSerDoc;

      Edit;
      fTemp('MARDES').AsString := 'D';
      fTemp('SEQMAR').AsInteger := 0;
      Post;

      FstlDocSel.Delete(FstlDocSel.IndexOf(fTemp('NUMDOC').AsString + fTemp('ESPDOC').AsString + fTemp('CODEMP').AsString));

      Result := True;
    End;

    pCalculaTotais;

    If (fEmptyStr(FQtdDocSel)) Or (StrToInt(FQtdDocSel) <= 0) {Or (fStrToFloat(FTotGerSel) < 0)} Then
    Begin
      strEspSel  := '';
      FTipoDoc   := opcNenhum;
      FcOdDiv    := EmptyStr;
    End;

  End;

end;

function TConfirmacaoDocumentos.fPodeSintetizarDoc(cdsIteConf: TUniClientDataSet;
                                                   strNumDoc, strEspDoc, strCodEmp: String;
                                                   Var stlDocNaoSin: TStringList;
                                                   blnForcarComparacao: Boolean = False): Boolean;
Var
  cdsIteDev: TUniClientDataSet;
  cdsIteDoc: TUniClientDataSet;
  strDocume: string;
  recMadeira: TDadosMadeira;
  strDocTmp: String;
begin

  Result := True;

  Try
    cdsIteDev := TUniClientDataSet.Create(Self);
    cdsIteDoc := TUniClientDataSet.Create(Self);

    pCloneDataSet(cdsIteDev, cdsIteConf);
    pCloneDataSet(cdsIteDoc, cdsIteConf);

    cdsIteDev.Open;
    cdsIteDoc.Open;

    {********************************************}
    {* FILTRA TODOS OS ITENS DA MESMA DEVOLUÇÃO *}
    {*****************************************PZ*}
    With cdsIteDev Do //DV
    Begin
      Filter := 'DET_NUMDOC = ' + QuotedStr(strNumDoc) +  ' AND ' +
                'DET_ESPDOC = ' + QuotedStr(strEspDoc) +  ' AND ' +
                'DET_CODEMP = ' + QuotedStr(strCodEmp);

      Filtered  := True;
      First;

      While Not Eof Do
      Begin

        If fatVenda.fUtilizaVendaMadeiraOuVidroOuMetroLinear Then
        Begin
          recMadeira.fltComPec := cdsIteDev.FieldByName('DET_COMPEC').AsFloat;
          recMadeira.fltLarPec := cdsIteDev.FieldByName('DET_LARPEC').AsFloat;
          recMadeira.fltEspPec := cdsIteDev.FieldByName('DET_ESPPEC').AsFloat;
        End;

       {****************************************}
       {* FILTRA O DOCUMENTO QUE FOI DEVOLVIDO *}
       {*************************************PZ*}
        pMontaFiltro(FieldByName('DET_INCDEV').AsString, recMadeira, cdsIteDoc);
        cdsIteDoc.Filtered := True;
        cdsIteDoc.IndexFieldNames := 'AUTOINCREM';
        cdsIteDoc.First;

        With cdsIteDoc Do
        Begin

          {**********************************}
          {* VERIFICA SE É UM CASO PERFEITO *}
          {*******************************PZ*}
          strDocTmp := cdsIteDev.FieldByName('DET_DOCDEV').AsString + '-' +
                       cdsIteDev.FieldByName('DET_ESPDEV').AsString + '-' +
                       cdsIteDev.FieldByName('DET_EMPDEV').AsString; //DOC.FAT.

          If (cdsIteDoc.IsEmpty) Or
             (Not fEhDocPassivelDeSintetizacao(cdsIteDev.FieldByName('DET_NUMDOC').AsString,
                                               cdsIteDev.FieldByName('DET_ESPDOC').AsString,
                                               cdsIteDev.FieldByName('DET_CODEMP').AsString)) Or
             (Not (fCasoPerfeito(cdsIteDoc, fRetonaUnitarioLiq(cdsIteDev), cdsIteDev.FieldByName('DET_QTDITE').AsFloat, blnForcarComparacao))) Then
          Begin
            strDocume := cdsIteDev.FieldByName('DET_NUMDOC').AsString + cdsIteDev.FieldByName('DET_ESPDOC').AsString + cdsIteDev.FieldByName('DET_CODEMP').AsString;
            stlDocNaoSin.Add(strDocume); //DV

            {************************************************************************}
            {* LIMPA O DATASET DE DOCUMENTOS SINTETIZADOS, CASO ALGUM DOS ITENS NÃO *}
            {* É CASO PERFEITO, ENTÃO O DOCUMENTO INTEIRO DEIXA DE SER SINTETIZADO  *}
            {**********************************************************************FC}
            While cdsDocsDevSintetizado.Locate('DOCUMENTO;DEVOLUCAO', VarArrayOf([strDocTmp, cdsIteDev.FieldByName('DET_NUMDOC').AsString]), []) Do
              cdsDocsDevSintetizado.Delete;

            Result := False;
            Break;
          End
          Else
          Begin
            If Not cdsDocsDevSintetizado.Locate('DOCUMENTO;DEVOLUCAO', VarArrayOf([strDocTmp, cdsIteDev.FieldByName('DET_NUMDOC').AsString]), []) Then
            Begin
              cdsDocsDevSintetizado.Append;
              cdsDocsDevSintetizado.FieldByName('DOCUMENTO').AsString := strDocTmp;
              cdsDocsDevSintetizado.FieldByName('DEVOLUCAO').AsString := cdsIteDev.FieldByName('DET_NUMDOC').AsString;
              cdsDocsDevSintetizado.Post;
            End;
          End;
        End;

        Next;

      End;
    end;

  Finally
    FreeAndNil(cdsIteDev);
    FreeAndNil(cdsIteDoc);
  End;

end;

procedure TConfirmacaoDocumentos.pCalculaTotais;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;
begin

  Try
    qryGenTmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS TOTDOC, ';
    strSQL := strSQL + '  SUM(TMP_VLRCON + TMP_TOTIPI + TMP_TOTRET + TMP_TOTREF) AS TOTGER, ';
    strSQL := strSQL + '  SUM(TMP_DUPREC) AS TOTPAG, ';
    strSQL := strSQL + '  SUM(TMP_DESSUJ) AS DESSUJ, ';
    strSQL := strSQL + '  SUM(TMP_JURSUJ) AS JURSUJ  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL +    fatVenda.strTabelaConfMi + ' ';
    strSQL := strSQL + 'WHERE  ';
    strSQL := strSQL + '  TMP_VLRCON <> 0.0 ';

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      FQtdDoc := FieldByName('TOTDOC').AsString;
      FTotGer := FormatFloat('#,##0.00', FieldByName('TOTGER').AsFloat);
      FDupPag := FormatFloat('#,##0.00', FieldByName('TOTPAG').AsFloat);
      FDesSuj := FormatFloat('#,##0.00', FieldByName('DESSUJ').AsFloat);
      FJurSuj := FormatFloat('#,##0.00', FieldByName('JURSUJ').AsFloat);

      FTotLiq := FormatFloat('#,##0.00', FieldByName('TOTGER').AsFloat - FieldByName('TOTPAG').AsFloat +
                                                FieldByName('JURSUJ').AsFloat - FieldByName('DESSUJ').AsFloat);

      Close;
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS TOTDOC, ';
    strSQL := strSQL + '  SUM(TMP_ITEDOC) AS ITEDOC, ';
    strSQL := strSQL + '  SUM(TMP_VLRCON + TMP_TOTIPI + TMP_TOTRET + TMP_TOTREF) AS TOTGER, ';
    strSQL := strSQL + '  SUM(TMP_DUPREC) AS TOTPAG, ';
    strSQL := strSQL + '  SUM(TMP_DESSUJ) AS DESSUJ, ';
    strSQL := strSQL + '  SUM(TMP_JURSUJ) AS JURSUJ  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + fatVenda.strTabelaConfMi + ' ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  TMP_MARDES = "M"    AND';
    strSQL := strSQL + '  TMP_VLRCON <> 0.0      ';

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      FItensDocs := FieldByName('ITEDOC').AsInteger;
      FQtdDocSel := FieldByName('TOTDOC').AsString;
      FTotGerSel := FormatFloat('#,##0.00', FieldByName('TOTGER').AsFloat);
      FDupPagSel := FormatFloat('#,##0.00', FieldByName('TOTPAG').AsFloat);
      FDesSujSel := FormatFloat('#,##0.00', FieldByName('DESSUJ').AsFloat);
      FJurSujSel := FormatFloat('#,##0.00', FieldByName('JURSUJ').AsFloat);
      FTotTrvSel := FormatFloat('#,##0.00', FieldByName('TOTGER').AsFloat);

      FTotLiqSel := FormatFloat('#,##0.00', FieldByName('TOTGER').AsFloat - FieldByName('TOTPAG').AsFloat +
                                            FieldByName('JURSUJ').AsFloat - FieldByName('DESSUJ').AsFloat);

      Close;
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS TOTDOC, ';
    strSQL := strSQL + '  SUM(TMP_VLRCON + TMP_TOTIPI + TMP_TOTRET + TMP_TOTREF) AS TOTGER  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + fatVenda.strTabelaConfMi + ' ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  TMP_MARDES = "M"    AND';
    strSQL := strSQL + '  TMP_ESPDOC = "TR"   AND';
    strSQL := strSQL + '  TMP_VLRCON <> 0.0      ';

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      If FieldByName('TOTDOC').AsInteger > 0 Then
        FTotTrvSel := FormatFloat('#,##0.00', fStrToFloat(FTotTrvSel) - FieldByName('TOTGER').AsFloat);

      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

procedure TConfirmacaoDocumentos.pCancelarBaixaDocumentosMarcados;
begin
  pAtualizaDocumentosMarcados(taCancelamentoBaixa);
end;

(********************************************************************************************)
(* SE SOBROU ALGUM ITEM NA DEVOLUCAO QUE NAO FOI SINTETIZADO RETORNA OS VALORES ORIGINAIS   *)
(* DO DOCUMENTO E DA DEVOLUCAO RESPECTIVA. POIS ESTA MOSTRANDO UM TOTAL NA TELA PARA OS     *)
(* DOCUMENTOS, MAS QUANDO CONFIRMA, NA TELA DA VENDA, VEM TODOS OS ITENS E O TOTAL ORIGINAL *)
(* DO DOCUMENTO.                                                                            *)
(*****************************************************************************************LA*)
procedure TConfirmacaoDocumentos.pReverteValorDocumentos;
  Var
    qryGen: TUniQuery;
begin
  Try

    qryGen := fCriaQuery;
    With fatVenda.qryTemporariaConfirmacao Do
    Begin
      DisableControls;

      First;

      While (Not Eof) Do
      Begin

        If (fFormataFloat(FieldByName('TMP_VLRCON').AsFloat, 2) <> 0) And
           (Pos(FieldByName('TMP_ESPDOC').AsString, 'TR_DV_') > 0) Then
        Begin

          qryGen.Close;
          qryGen.SQL.Text := fSQLRetValorDevolucao;
          qryGen.ParamByName('DOCDEV').AsString := FieldByName('TMP_NUMDOC').AsString;
          qryGen.ParamByName('ESPDEV').AsString := FieldByName('TMP_ESPDOC').AsString;
          qryGen.ParamByName('EMPDEV').AsString := FieldByName('TMP_CODEMP').AsString;
          qryGen.ExecSQL;

          qryGen.SQL.Text := fSQLRetValorDocumento;

          cdsTotDev.First;
          While Not cdsTotDev.Eof Do
          Begin
            If (cdsTotDev.FieldByName('DOCDEV').AsString = FieldByName('TMP_NUMDOC').AsString) And
               (cdsTotDev.FieldByName('ESPDEV').AsString = FieldByName('TMP_ESPDOC').AsString) And
               (cdsTotDev.FieldByName('EMPDEV').AsString = FieldByName('TMP_CODEMP').AsString) Then
             Begin

               qryGen.Close;
               qryGen.ParamByName('NUMDOC').AsString := cdsTotDev.FieldByName('NUMDOC').AsString;
               qryGen.ParamByName('ESPDOC').AsString := cdsTotDev.FieldByName('ESPDOC').AsString;
               qryGen.ParamByName('CODEMP').AsString := cdsTotDev.FieldByName('CODEMP').AsString;
               qryGen.ParamByName('VALDEV').AsFloat  := cdsTotDev.FieldByName('TOTDEV').AsFloat;
               qryGen.ExecSQL;

             End;


            cdsTotDev.Next;
          End;

        End;

        Next;

      End;
      First;

      EnableControls;
    End;

  Finally
    fatVenda.qryTemporariaConfirmacao.EnableControls;
    FreeAndNil(qryGen);
  End;
end;

procedure TConfirmacaoDocumentos.pDeletaDocDesmarcados;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;

begin
  Try

    qryGenTmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ' + fatVenda.strTabelaConfMi + ' ';
    strSQL := strSQL + 'WHERE TMP_MARDES <> "M"  ';

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

function TConfirmacaoDocumentos.fFiltroProEmb: String;
begin
  Result := ' DET_PROEMB <> "S" ';
end;

function TConfirmacaoDocumentos.fSetTipoDoc(strNumDoc, strEspDoc, strCodCli, strCodEmp: String): TTipoDoc;
Begin
  If fTemProfissional(strNumDoc,
                      strEspDoc,
                      strCodCli,
                      strCodEmp) Then
    Result := opcComProfissional
  Else
    Result := opcSemProfissional;
end;

Function TConfirmacaoDocumentos.fSQLRetValorDevolucao: String;
  Var
    strSQL: String;
Begin

  strSQL := '';
  strSQL := strSQL + ' UPDATE ';
  strSQL := strSQL + fatVenda.strTabelaConfMi;
  strSQL := strSQL + ' SET ';
  strSQL := strSQL + '   TMP_VLRCON = SAV_VLRCON,   ';
  strSQL := strSQL + '   TMP_ITEDOC = SAV_ITEDOC,   ';
  strSQL := strSQL + '   TMP_DESESP = SAV_DESESP,   ';
  strSQL := strSQL + '   TMP_TOTFRE = SAV_TOTFRE,   ';
  strSQL := strSQL + '   TMP_DEVOLU = "",           ';
  strSQL := strSQL + '   TMP_DDEVOL = "",           ';
  strSQL := strSQL + '   TMP_MARDES = "D",          ';
  strSQL := strSQL + '   SAV_SINTET = "N" ';

  strSQL := strSQL + ' WHERE ';

  strSQL := strSQL + '   TMP_NUMDOC = :DOCDEV AND ';
  strSQL := strSQL + '   TMP_ESPDOC = :ESPDEV AND ';
  strSQL := strSQL + '   TMP_CODEMP = :EMPDEV     ';

  Result := strSQL;
End;

Function TConfirmacaoDocumentos.fSQLRetValorDocumento: String;
  Var
    strSQL: String;
Begin

  strSQL := '';
  strSQL := strSQL + ' UPDATE ';
  strSQL := strSQL + fatVenda.strTabelaConfMi;
  strSQL := strSQL + ' SET ';
  strSQL := strSQL + '   TMP_VLRCON = TMP_VLRCON + :VALDEV ';

  strSQL := strSQL + ' WHERE ';

  strSQL := strSQL + '   TMP_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '   TMP_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '   TMP_CODEMP = :CODEMP     ';

  Result := strSQL;
End;


function TConfirmacaoDocumentos.fTemProfissional(strNumDoc,
                                                 strEspDoc,
                                                 strCodCli,
                                                 strCodEmp: String;
                                                 blnFiltraMaisdeUmProfissional: Boolean = False): Boolean;
  Var
    qryAux : TUniQuery;
begin
  qryAux := fCriaQuery(Self);

  With qryAux Do
  Begin
    SQL.Clear;
    SQL.Add('SELECT DISTINCT COM_CODPRO  ');
    SQL.Add('FROM   COMPRO               ');
    SQL.Add('WHERE  COM_NUMDOC = :NUMDOC ');
    SQL.Add('AND    COM_ESPDOC = :ESPDOC ');
    SQL.Add('AND    COM_CODEMP = :CODEMP ');
    SQL.Add('AND    COM_CODCLI = :CODCLI ');
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODCLI').AsString := strCodCli;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    If blnFiltraMaisdeUmProfissional Then
      Result := RecordCount > 1
    Else
      Result := RecordCount > 0;
  End;

  FreeAndNil(qryAux);
end;

function TConfirmacaoDocumentos.fEhDocPassivelDeSintetizacao(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
begin
  Result := fCampoTabela('IFNULL(TMP_PODSIN, "")', fatVenda.strTabelaConfMi, ['TMP_NUMDOC', 'TMP_ESPDOC', 'TMP_CODEMP'], [strNumDoc, strEspDoc, strCodEmp]) = 'S';
end;

function TConfirmacaoDocumentos.fEhDuplicataAgrupada : Boolean;
  Var
    qryGenAgr: TUniQuery;

begin
  Try

    qryGenAgr := fCriaQuery;

    With qryGenAgr Do
    Begin
      SQL.Add('SELECT ');
      SQL.Add('  CTR_NUMDUP AS NUMDUP ');
      SQL.Add('FROM ');
      SQL.Add('  DUPAGR ');
      SQL.Add('WHERE ');
      SQL.Add('  CTR_NUMDUP = :NUMDOC AND ');
      SQL.Add('  CTR_ESPDOC = :ESPDOC AND ');
      SQL.Add('  CTR_CODEMP = :CODEMP AND ');
      SQL.Add('  CTR_CODCLI = :CODCLI ');

      ParamByName('NUMDOC').Value := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').asString;
      ParamByName('ESPDOC').Value := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').asString;
      ParamByName('CODEMP').Value := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').asString;
      ParamByName('CODCLI').Value := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODCLI').asString;

      Open;

      If IsEmpty Then
        Result := False
      Else
        Result := True;

    End;

  Finally
    FreeAndNil(qryGenAgr);
  End;

end;

procedure TConfirmacaoDocumentos.pSetaClienteDocs(strCodCli: String);
begin
  fatVenda.strCodCli := strCodCli;
  fatVenda.strCliFat := strCodCli;
end;

procedure TConfirmacaoDocumentos.pSetAfterScroll(
  const Value: TDataSetNotifyEvent);
begin
  fatVenda.qryTemporariaConfirmacao.AfterScroll := Value;
end;

function TConfirmacaoDocumentos.fGetAfterScroll: TDataSetNotifyEvent;
begin
  Result := fatVenda.qryTemporariaConfirmacao.AfterScroll;
end;

function TConfirmacaoDocumentos.fGetQryConf: TUniQuery;
begin
  Result := fatVenda.qryTemporariaConfirmacao;
end;

procedure TConfirmacaoDocumentos.pSintentizaDevolucoes;
  Var
    strDocDev: String;
    strEspDev: String;
    strEmpDev: String;
    strIteDev: String;
    strIncDev: String;
    strAutIncDev: String;
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    fltQtdDev: Double;
    fltUniDev: Double;
    fltFreDev: Double;
    fltFreCotDev: Double;
    fltTotIpiDev: Double;
    fltTotRetDev: Double;
    fltTotRefDev: Double;
    fltVlrAux: Double;
    fltQtdTol: Double;
    fltDesEspTirar: Double;
    blnTirarItem: Boolean;
    intIndex: Integer;

    stlDocDevCtr: TStringList;
    stlDocNaoSin: TStringList;

    recMadeira: TDadosMadeira;

    procedure pRetornaRegistroAnterior;
    begin
      cdsItensConf.Filter := '';
      cdsItensConf.First;
      cdsItensConf.Locate('AUTOINCREM', strAutIncDev, []);
    end;

    procedure pAtualizaTabelaPrincipal;
      Var
        qryTmpPrincipal: TUniQuery;
        fltDupRecDv: Double;
        strNumDocDv: String;
        fltValDev: Double;
        fltValFre: Double;
        fltFreCot: Double;
        fltTotIpi: Double;
        fltTotRet: Double;
        fltTotRef: Double;
    begin

      qryTmpPrincipal := fatVenda.qryTemporariaConfirmacao;

      fltDupRecDv := 0.0;

      strNumDocDv := qryTmpPrincipal.FieldByName('TMP_NUMDOC').AsString +
                     qryTmpPrincipal.FieldByName('TMP_ESPDOC').AsString +
                     qryTmpPrincipal.FieldByName('TMP_CODEMP').AsString;

      If (stlDocDevCtr.IndexOf(strNumDocDv) < 0) And
         (qryTmpPrincipal.FieldByName('TMP_VLRCON').AsFloat <= 0) Then //Devolucoes e trocas negativas
      Begin
        fltDupRecDv := Abs(qryTmpPrincipal.FieldByName('TMP_DUPREC').AsFloat);
        stlDocDevCtr.Add(strNumDocDv);
      End;

      qryTmpPrincipal.Locate('TMP_NUMDOC;TMP_ESPDOC;TMP_CODEMP',
                             VarArrayOf([strDocDev, strEspDev, strEmpDev]), []);

      qryTmpPrincipal.Edit;
      qryTmpPrincipal.FieldByName('TMP_DUPREC').AsFloat  := qryTmpPrincipal.FieldByName('TMP_DUPREC').AsFloat - fltDupRecDv;

      fltValDev := (fFormataFloat(IIF(fEmptyStr(strAutIncDev), -fltQtdDev, fltQtdDev) * fltUniDev, 2));
      fltValFre := IIF(fEmptyStr(strAutIncDev), -fltFreDev, fltFreDev);
      fltFreCot := IIF(fEmptyStr(strAutIncDev), -fltFreCotDev, fltFreCotDev);
      fltTotIpi := IIF(fEmptyStr(strAutIncDev), -fltTotIpiDev, fltTotIpiDev);
      fltTotRet := IIF(fEmptyStr(strAutIncDev), -fltTotRetDev, fltTotRetDev);
      fltTotRef := IIF(fEmptyStr(strAutIncDev), -fltTotRefDev, fltTotRefDev);

      qryTmpPrincipal.FieldByName('TMP_VLRCON').AsFloat  := qryTmpPrincipal.FieldByName('TMP_VLRCON').AsFloat - fltValDev - fltValFre;
      qryTmpPrincipal.FieldByName('TMP_TOTFRE').AsFloat  := qryTmpPrincipal.FieldByName('TMP_TOTFRE').AsFloat - fltValFre;
      qryTmpPrincipal.FieldByName('TMP_FRECOT').AsFloat  := qryTmpPrincipal.FieldByName('TMP_FRECOT').AsFloat - fltFreCot;
      qryTmpPrincipal.FieldByName('TMP_TOTIPI').AsFloat  := qryTmpPrincipal.FieldByName('TMP_TOTIPI').AsFloat - fltTotIpi;
      qryTmpPrincipal.FieldByName('TMP_TOTRET').AsFloat  := qryTmpPrincipal.FieldByName('TMP_TOTRET').AsFloat - fltTotRet;
      qryTmpPrincipal.FieldByName('TMP_TOTREF').AsFloat  := qryTmpPrincipal.FieldByName('TMP_TOTREF').AsFloat - fltTotRef;

      If (blnTirarItem) Then
      Begin
        qryTmpPrincipal.FieldByName('TMP_ITEDOC').AsInteger := qryTmpPrincipal.FieldByName('TMP_ITEDOC').AsInteger - 1;
      End;

      If (Not fEmptyStr(strAutIncDev)) Then
      Begin
        pAddDevolucao(strNumDoc, strEspDoc, strCodEmp, strDocDev, strEspDev, strEmpDev, fltValDev);

        qryTmpPrincipal.FieldByName('TMP_DEVOLU').AsString := qryTmpPrincipal.FieldByName('TMP_DEVOLU').AsString +
                                                              strAutIncDev + '/';
        qryTmpPrincipal.FieldByName('TMP_DDEVOL').AsString := qryTmpPrincipal.FieldByName('TMP_DDEVOL').AsString +
                                                              strNumDoc + '-' + strEspDoc + '-' + strCodEmp + '/';
      End;

      qryTmpPrincipal.FieldByName('TMP_DESESP').AsFloat := qryTmpPrincipal.FieldByName('TMP_DESESP').AsFloat - fltDesEspTirar;

      fltVlrAux := fFormataFloat(qryTmpPrincipal.FieldByName('TMP_VLRCON').AsFloat, 2);
      fltQtdTol := 0.01;
      If (qryTmpPrincipal.FieldByName('TMP_ITEDOC').AsFloat = 0) Then
        fltQtdTol := 0.50;

      If (CompareValue(fltVlrAux,     0, fltQtdTol) = EqualsValue) Or
         (CompareValue(fltVlrAux, +0.01, fltQtdTol) = EqualsValue) Or
         (CompareValue(fltVlrAux, -0.01, fltQtdTol) = EqualsValue) Then
      Begin
        qryTmpPrincipal.FieldByName('TMP_MARDES').AsString := 'M';
        qryTmpPrincipal.FieldByName('SAV_SINTET').AsString := 'S';
        qryTmpPrincipal.FieldByName('TMP_VLRCON').AsFloat  := 0;
      End;

      qryTmpPrincipal.Post;
      fltDesEspTirar := 0.0;
      blnTirarItem   := False;

    end;

    procedure pAtualizaTabelaItens;
      Var
        fltQtdIteAnt: Double;
        fltCusUni: Double;
        fltIpiUni: Double;
        fltRetUni: Double;
        fltRefUni: Double;
    begin
      fltQtdIteAnt   := cdsItensConf.FieldByName('DET_QTDITE').AsFloat;
      fltDesEspTirar := cdsItensConf.FieldByName('DET_DESESP').AsFloat;
      cdsItensConf.Edit;

      fltCusUni := cdsItensConf.FieldByName('DET_TOTCUS').AsFloat / cdsItensConf.FieldByName('DET_QTDITE').AsFloat;
      fltIpiUni := cdsItensConf.FieldByName('DET_VALIPI').AsFloat / cdsItensConf.FieldByName('DET_QTDITE').AsFloat;
      fltRetUni := cdsItensConf.FieldByName('DET_VALRET').AsFloat / cdsItensConf.FieldByName('DET_QTDITE').AsFloat;
      fltRefUni := cdsItensConf.FieldByName('DET_VALREF').AsFloat / cdsItensConf.FieldByName('DET_QTDITE').AsFloat;

      cdsItensConf.FieldByName('DET_QTDITE').AsFloat  := cdsItensConf.FieldByName('DET_QTDITE').AsFloat -
                                                         fltQtdDev;

      cdsItensConf.FieldByName('DET_TOTCUS').AsFloat  := cdsItensConf.FieldByName('DET_QTDITE').AsFloat * fltCusUni;
      cdsItensConf.FieldByName('DET_VALIPI').AsFloat  := cdsItensConf.FieldByName('DET_QTDITE').AsFloat * fltIpiUni;
      cdsItensConf.FieldByName('DET_VALRET').AsFloat  := cdsItensConf.FieldByName('DET_QTDITE').AsFloat * fltRetUni;
      cdsItensConf.FieldByName('DET_VALREF').AsFloat  := cdsItensConf.FieldByName('DET_QTDITE').AsFloat * fltRefUni;

      cdsItensConf.FieldByName('DET_TOTITE').AsFloat  := cdsItensConf.FieldByName('DET_QTDITE').AsFloat *
                                                         cdsItensConf.FieldByName('DET_UNITAR').AsFloat;

      If (cdsItensConf.FieldByName('DET_QTDITE').AsFloat <= 0) Or
         (fltQtdIteAnt <= 0)                                  Then
        cdsItensConf.FieldByName('DET_DESESP').AsFloat := 0
      Else
      Begin
        cdsItensConf.FieldByName('DET_DESESP').AsFloat := fFormataFloat((cdsItensConf.FieldByName('DET_DESESP').AsFloat / fltQtdIteAnt) *
                                                                        (cdsItensConf.FieldByName('DET_QTDITE').AsFloat), 2);
      End;

      blnTirarItem := False;
      If (cdsItensConf.FieldByName('DET_QTDITE').AsFloat <= 0) Then
        blnTirarItem := True;

      fltDesEspTirar := fltDesEspTirar - cdsItensConf.FieldByName('DET_DESESP').AsFloat;
      If fltDesEspTirar < 0 Then
        fltDesEspTirar := 0;

      cdsItensConf.Post;
    end;

   Var
     blnNext: Boolean;
begin
  cdsTotDev.EmptyDataSet;

  stlDocDevCtr := TStringList.Create;
  stlDocNaoSin := TStringList.Create;

  pCriaClientDocsSint;

  If Assigned(FProgress) Then
  Begin
    FProgress.Visible := True;
    FProgress.Max := cdsItensConf.RecordCount;
    FProgress.Position := 0;
  End;

  cdsItensConf.IndexFieldNames := 'AUTOINCREM';
  cdsItensConf.First;
  While (Not cdsItensConf.Eof) Do
  Begin
    blnNext := False;

    If (fEmptyStr(cdsItensConf.FieldByName('DET_DOCDEV').AsString)) Or
       (Not fEhDocPassivelDeSintetizacao(cdsItensConf.FieldByName('DET_NUMDOC').AsString,
                                         cdsItensConf.FieldByName('DET_ESPDOC').AsString,
                                         cdsItensConf.FieldByName('DET_CODEMP').AsString)) Then
    Begin
      cdsItensConf.Next;

      If Assigned(FProgress) Then
        FProgress.StepBy(1);

      Application.ProcessMessages;

      Continue;
    End;

    {******************************************************************}
    {* DEVOLUÇÃO CUJO DOCUMENTO DEVOLVIDO ESTÁ TOTALMENTE QUITADO NÃO *}
    {* NÃO PODE SER SINTETIZADA                                       *}
    {***************************************************************VA*}
    If (Not fEmptyStr(cdsItensConf.FieldByName('DET_DOCDEV').AsString)) And
       (stlDocQuitado.Find(cdsItensConf.FieldByName('DET_DOCDEV').AsString +
                           cdsItensConf.FieldByName('DET_ESPDEV').AsString +
                           cdsItensConf.FieldByName('DET_EMPDEV').AsString, intIndex)) Then
    Begin
      cdsItensConf.Next;

      If Assigned(FProgress) Then
        FProgress.StepBy(1);

      Application.ProcessMessages;

      Continue;
    End;

    strDocDev    := cdsItensConf.FieldByName('DET_DOCDEV').AsString;
    strEspDev    := cdsItensConf.FieldByName('DET_ESPDEV').AsString;
    strEmpDev    := cdsItensConf.FieldByName('DET_EMPDEV').AsString;
    strIteDev    := cdsItensConf.FieldByName('DET_CODITE').AsString;
    strIncDev    := cdsItensConf.FieldByName('DET_INCDEV').AsString;
    strAutIncDev := cdsItensConf.FieldByName('AUTOINCREM').AsString;
    strNumDoc    := cdsItensConf.FieldByName('DET_NUMDOC').AsString;
    strEspDoc    := cdsItensConf.FieldByName('DET_ESPDOC').AsString;
    strCodEmp    := cdsItensConf.FieldByName('DET_CODEMP').AsString;
    fltQtdDev    := cdsItensConf.FieldByName('DET_QTDITE').AsFloat;
    fltUniDev    := fRetonaUnitarioLiq(cdsItensConf); //  cdsItensConf.FieldByName('DET_UNITAR').AsFloat;
    fltFreDev    := cdsItensConf.FieldByName('DET_TOTFRE').AsFloat;
    fltFreCotDev := cdsItensConf.FieldByName('DET_FRECOT').AsFloat;
    fltTotIpiDev := cdsItensConf.FieldByName('DET_VALIPI').AsFloat;
    fltTotRetDev := cdsItensConf.FieldByName('DET_VALRET').AsFloat;
    fltTotRefDev := cdsItensConf.FieldByName('DET_VALREF').AsFloat;

    If fatVenda.fUtilizaVendaMadeiraOuVidroOuMetroLinear Then
    Begin
      recMadeira.fltComPec := cdsItensConf.FieldByName('DET_COMPEC').AsFloat;
      recMadeira.fltLarPec := cdsItensConf.FieldByName('DET_LARPEC').AsFloat;
      recMadeira.fltEspPec := cdsItensConf.FieldByName('DET_ESPPEC').AsFloat;
    End;

    {*****************************************************************}
    {* SÓ IRÁ SINTETIZAR AS DV SE TODOS OS ITENS FOREM CASO PERFEITO *}
    {**************************************************************PZ*}
    If (stlDocNaoSin.Find(strNumDoc + strEspDoc + strCodEmp, intIndex)) Or (Not fPodeSintetizarDoc(cdsItensConf, strNumDoc, strEspDoc, strCodEmp, stlDocNaoSin, True)) Then
    Begin
      pRetornaRegistroAnterior;
      cdsItensConf.Next;

      If Assigned(FProgress) Then
        FProgress.StepBy(1);

      Application.ProcessMessages;

      Continue;
    End;

    pMontaFiltro(strIncDev, recMadeira, cdsItensConf);

    If (Not cdsItensConf.FindFirst) Then
    Begin
      pRetornaRegistroAnterior;
      cdsItensConf.Next;

      If Assigned(FProgress) Then
        FProgress.StepBy(1);

      Application.ProcessMessages;

      Continue;
    End;

    If (Not fatVenda.qryTemporariaConfirmacao.Locate('TMP_NUMDOC;TMP_ESPDOC;TMP_CODEMP', VarArrayOf([strNumDoc, strEspDoc, strCodEmp]), [])) Then
    Begin
      pRetornaRegistroAnterior;
      cdsItensConf.Next;

      If Assigned(FProgress) Then
        FProgress.StepBy(1);

      Application.ProcessMessages;

      Continue;
    End

    Else If (fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DUPBAI').AsString = 'N') And
            (fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DUPREC').AsFloat <> 0) Then
    Begin
      pRetornaRegistroAnterior;
      cdsItensConf.Next;

      If Assigned(FProgress) Then
        FProgress.StepBy(1);

      Application.ProcessMessages;

      Continue;
    End;

    If fCasoPerfeito(cdsItensConf, fRetonaUnitarioLiq(cdsItensConf), fltQtdDev) Then
    Begin

      pAtualizaTabelaItens;
      pAtualizaTabelaPrincipal;

      pRetornaRegistroAnterior;

      strDocDev    := cdsItensConf.FieldByName('DET_NUMDOC').AsString;
      strEspDev    := cdsItensConf.FieldByName('DET_ESPDOC').AsString;
      strEmpDev    := cdsItensConf.FieldByName('DET_CODEMP').AsString;
      strAutIncDev := '';

      pAtualizaTabelaItens;
      fltDesEspTirar := 0.0;
      pAtualizaTabelaPrincipal;

      cdsItensConf.Edit;
      cdsItensConf.FieldByName('DET_SINTET').AsString := 'S';
      cdsItensConf.Post;

      cdsItensConf.Next;

      If Assigned(FProgress) Then
        FProgress.StepBy(1);

      Application.ProcessMessages;

      Continue;

    End;

    While (cdsItensConf.FindNext) Do
    Begin

      If fCasoPerfeito(cdsItensConf, fRetonaUnitarioLiq(cdsItensConf), fltQtdDev) Then
      Begin

        pAtualizaTabelaItens;
        pAtualizaTabelaPrincipal;

        pRetornaRegistroAnterior;

        strDocDev    := cdsItensConf.FieldByName('DET_NUMDOC').AsString;
        strEspDev    := cdsItensConf.FieldByName('DET_ESPDOC').AsString;
        strEmpDev    := cdsItensConf.FieldByName('DET_CODEMP').AsString;
        strAutIncDev := '';

        pAtualizaTabelaItens;
        fltDesEspTirar := 0.0;
        pAtualizaTabelaPrincipal;

        cdsItensConf.Edit;
        cdsItensConf.FieldByName('DET_SINTET').AsString := 'S';
        cdsItensConf.Post;

        cdsItensConf.Next;
        blnNext := TRUE;

        If Assigned(FProgress) Then
          FProgress.StepBy(1);

        Application.ProcessMessages;

        Break;

      End;

    End;

    If Not blnNext Then
    Begin
      If Assigned(FProgress) Then
        FProgress.StepBy(1);

      Application.ProcessMessages;

      pRetornaRegistroAnterior;
      cdsItensConf.Next;
    End;
  End;

  stlDocDevCtr.Clear;
  FreeAndNil(stlDocDevCtr);
  FreeAndNil(stlDocNaoSin);

  If Assigned(FProgress) Then
    FProgress.Visible := False;
end;

procedure TConfirmacaoDocumentos.pResintetizaDevolucoes;

  Procedure pRollbackItensConf;
  Begin
    With cdsItensConf Do
    Begin
      First;
      While Not Eof Do
      Begin

//        If (FieldByName('DET_ESPDOC').AsString <> 'DV') Then
//        Begin

          If Not fatVenda.qryTemporariaConfirmacao.Locate('TMP_NUMDOC;TMP_ESPDOC;TMP_CODEMP',
                                         VarArrayOf([FieldByName('DET_NUMDOC').AsString,
                                                     FieldByName('DET_ESPDOC').AsString,
                                                     FieldByName('DET_CODEMP').AsString]), []) Then
          Begin
            Delete
          End
          Else
          Begin
            Edit;
            FieldByName('DET_QTDITE').AsFloat  := FieldByName('SAV_QTDITE').AsFloat;
            FieldByName('DET_TOTCUS').AsFloat  := FieldByName('SAV_TOTCUS').AsFloat;
            FieldByName('DET_TOTITE').AsFloat  := FieldByName('SAV_TOTITE').AsFloat;
            FieldByName('DET_UNITAR').AsFloat  := FieldByName('SAV_UNITAR').AsFloat;
            FieldByName('DET_DESESP').AsFloat  := FieldByName('SAV_DESESP').AsFloat;
            FieldByName('DET_SINTET').AsString := 'N';
            Post;
            Next;
          End;
//        End
//        Else
//          Next;


      End;
    End;
  End;

  procedure pRollbackTemporaria;
    Var
      strSQL: String;
      qryGen: TUniQuery;
  begin

    Try
      qryGen := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + ' UPDATE ';
      strSQL := strSQL + fatVenda.strTabelaConfMi;
      strSQL := strSQL + ' SET ';
      strSQL := strSQL + '   TMP_VLRCON = SAV_VLRCON,                            ';
      strSQL := strSQL + '   TMP_ITEDOC = SAV_ITEDOC,                            ';
      strSQL := strSQL + '   TMP_DESESP = SAV_DESESP,                            ';
      strSQL := strSQL + '   TMP_DUPREC = SAV_DUPREC,                            ';
      strSQL := strSQL + '   TMP_TOTFRE = SAV_TOTFRE,                            ';
      strSQL := strSQL + '   TMP_DEVOLU = "",                                    ';
      strSQL := strSQL + '   TMP_DDEVOL = "",                                    ';
      strSQL := strSQL + '   TMP_MARDES = IF(SAV_SINTET = "S", "D", TMP_MARDES), ';
      strSQL := strSQL + '   SAV_SINTET = "N" ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
      End;

    Finally
      FreeAndNil(qryGen);
    End;
  end;


Begin
  pAtualizaTemporariaConfirmacao(True);
  pRollbackItensConf;
  pRollbackTemporaria;

  pAtualizaTemporariaConfirmacao(False);
  pSintentizaDevolucoes;
  pDeletaDocDesmarcadosDevSintet;
End;

procedure TConfirmacaoDocumentos.pDeletaDocDesmarcadosDevSintet;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;

begin
  Try

    qryGenTmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ' + fatVenda.strTabelaConfMi + ' ';
    strSQL := strSQL + 'WHERE TMP_MARDES <> "M" OR (TMP_MARDES = "M" AND SAV_SINTET = "S" AND TMP_ESPDOC = "DV") ';

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

procedure TConfirmacaoDocumentos.pGeraStringDocsConfirmados;
begin
  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    First;

    fatVenda.strDocsConf := '';

    While (Not Eof) Do
    Begin
      If FieldByName('TMP_MARDES').AsString = 'M' Then
      Begin
        fatVenda.strDocsConf := fatVenda.strDocsConf + FieldByName('TMP_NUMDOC').AsString + '-' +
                                                       FieldByName('TMP_ESPDOC').AsString + '-' +
                                                       FieldByName('TMP_CODEMP').AsString + ',';

      End;

      Next;
    End;
    First;

    FCodCnd := FieldByName('TMP_CODCND').AsString;
    FConPag := FieldByName('TMP_CONPAG').AsString;
    FCodFpg := FieldByName('TMP_CODFPG').AsString;
    FTipFre := FieldByName('TMP_TIPFRE').AsString;
    FCodCli := FieldByName('TMP_CODCLI').AsString;
    FCodVen := FieldByName('TMP_CODVEN').AsString;
    FNomTab := FieldByName('TMP_NOMTAB').AsString;
    FAutInc := FieldByName('TMP_AUTINC').AsString;
  End;

  If Not fEMptyStr(fatVenda.strDocsConf) Then
  Begin
    fatVenda.strDocsConf := LeftStr(fatVenda.strDocsConf, Length(fatVenda.strDocsConf)-1);
  End;
end;

procedure TConfirmacaoDocumentos.pMarcarDesmarcarPodeSintetizar(strNumDoc,
  strEspDoc, strCodEmp: String; strPodSin: String = 'N');
  Var
    strSQL: String;
    qryGen : TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + ' UPDATE ';
  strSQL := strSQL + fatVenda.strTabelaConfMi;
  strSQL := strSQL + ' SET ';
  strSQL := strSQL + '   TMP_PODSIN = :PODSIN ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   TMP_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '   TMP_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '   TMP_CODEMP = :CODEMP     ';

  qryGen := fCriaQuery;
  Try
    qryGen.Close;
    qryGen.SQL.Text := strSQL;
    qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
    qryGen.ParamByName('ESPDOC').AsString := strEspDoc;
    qryGen.ParamByName('CODEMP').AsString := strCodEmp;
    qryGen.ParamByName('PODSIN').AsString := strPodSin;
    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen)
  End;
end;

procedure TConfirmacaoDocumentos.pMarcarDocumentosMeiaNota;
var
  arrMeiaNota: TArrMeiaNota;
  intCnt: Integer;
begin
  FillChar(arrMeiaNota, SizeOf(arrMeiaNota), #0);
  intCnt := 0;

  fatVenda.qryTemporariaConfirmacao.First;
  While Not fatVenda.qryTemporariaConfirmacao.Eof Do
  Begin
    If fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString = 'M' Then
    Begin
      SetLength(arrMeiaNota, Length(arrMeiaNota) + 1);
      arrMeiaNota[intCnt].strEmpDoc := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString;
      arrMeiaNota[intCnt].strEspDoc := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString;
      arrMeiaNota[intCnt].strNumDoc := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString;
      inc(intCnt);
    End;
    fatVenda.qryTemporariaConfirmacao.Next;
  End;

  If Assigned(arrMeiaNota) Then
  Begin
    fatVenda.arrDocMeiaNota := arrMeiaNota;
  End;

end;

procedure TConfirmacaoDocumentos.pMarcarTodosDocumentos(blnMarcar: Boolean; strEntRet: String);
  Var
    strInformacao: String;
    strMsg: String;
begin
  inherited;
  strMsgTinta := '';

  If (Not Assigned(qryConfirmacao)) Or
     (Not qryConfirmacao.Active) Or
     (qryConfirmacao.RecordCount = 0) Then
  Begin
    If blnMarcar Then
      fMensagem('ATENÇÃO!', 'Não há documentos para marcar!', ['&OK']);
    Exit;
  End;

  If (blnMarcar) And (Not fEmptyStr(strEntRet)) And (Not fPodeMarcarEntregaRetira(qryConfirmacao, fatVenda.strTabelaConfMi, strEntRet)) Then
  Begin
    Exit;
  End;

  With qryConfirmacao Do
  Begin
    First;
    While Not Eof Do
    Begin

      If (blnMarcar) Then
      Begin
        If (FieldByName('TMP_MARDES').AsString <> 'M') And
           (fEmptyStr(strEntRet) Or ((Not fEmptyStr(strEntRet)) And (FieldByName('TMP_ENTRET').AsString = strEntRet))) Then
        Begin
          If fatVenda.fUltrapassouLimiteItensNFe(intQtdItensDocs + FieldByName('TMP_ITEDOC').AsInteger, '', strInformacao) Then
          Begin
            pMensagemSonora(strInformacao);
            Break;
          End
          Else
          Begin
            If (fValidaProdutoTintaOutraEmpresa(FieldByName('TMP_NUMDOC').AsString,
                                                FieldByName('TMP_ESPDOC').AsString,
                                                FieldByName('TMP_CODEMP').AsString,
                                                FieldByName('TMP_CODCLI').AsString)) And
               (Not fCfgSis('USATMQ', VarBoolean)) Then
            Begin
              strMsgTinta := ' '+strMsgTinta + FieldByName('TMP_NUMDOC').AsString +'-'+
                                               FieldByName('TMP_ESPDOC').AsString+'-'+
                                               FieldByName('TMP_CODEMP').AsString+',';
            End
            Else
              fMarcaDocumento(True, strMsg, True);
          End;
        End;
      End
      Else
      Begin
        If (FieldByName('TMP_MARDES').AsString = 'M') And
           (fEmptyStr(strEntRet) Or ((Not fEmptyStr(strEntRet)) And (FieldByName('TMP_ENTRET').AsString = strEntRet))) Then
          fMarcaDocumento(False, strMsg, True);
      End;

      Next;
    End;

    If Not fEmptyStr(strMsg) Then
      fMensagem('', strMsg, ['&Ok']);

    If Not fEmptyStr(strMsgTinta) Then
    Begin
      strMsgTinta := Copy(strMsgTinta, 0, length(strMsgTinta) - 1);
      fMensagem('', Format(strMensagemFixaTinta, [strMsgTinta]), ['&Ok']);
    End;

    First;
  End;
end;

procedure TConfirmacaoDocumentos.pMontaFiltro(strIncDev: String; recMadeira: TDadosMadeira; Var cdsIteTmp: TUniClientDataSet);
begin

  cdsIteTmp.Filter := Format('AUTOINCREM = ''%s''', [strIncDev]);

  If fatVenda.fUtilizaVendaMadeiraOuVidroOuMetroLinear Then
    cdsIteTmp.Filter := cdsIteTmp.Filter +
                        ' AND DET_COMPEC = ' + FloatToStr(recMadeira.fltComPec) +
                        ' AND DET_LARPEC = ' + FloatToStr(recMadeira.fltLarPec) +
                        ' AND DET_ESPPEC = ' + FloatToStr(recMadeira.fltEspPec);

end;

function TConfirmacaoDocumentos.pMontaListaComDocFatDaDV(strNumDoc,
  strCodEmp: String): String;
  Var
   strSQL: String;
   qryDet : TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT DET_DOCDEV AS NUMDOC, ' ;
  strSQL := strSQL + '        DET_ESPDEV AS ESPDOC, ' ;
  strSQL := strSQL + '        DET_EMPDEV AS CODEMP ' ;
  strSQL := strSQL + ' FROM MOVDET       ' ;
  strSQL := strSQL + ' WHERE DET_NUMDOC = ' + QuotedStr(strNumDoc);
  strSQL := strSQL + '   AND DET_ESPDOC = "DV" ';
  strSQL := strSQL + '   AND DET_CODEMP = ' + QuotedStr(strCodEmp);

  qryDet := fCriarQuery(strSQL);
  Try
    qryDet.Open;

    qryDet.First;
    While Not qryDet.Eof Do
    Begin
      Result := Result + qryDet.FieldByName('NUMDOC').AsString + ' - ' +
                         qryDet.FieldByName('ESPDOC').AsString + ' -  '+
                         qryDet.FieldByName('CODEMP').AsString + #10#13;
      qryDet.Next;
    End;

    If Not fEmptyStr(Result) Then
    Begin
      Result :=  '------------------' + #10#13
               + 'DOCTO. - ESP - EMP' + #10#13
               + '------------------' + #10#13
               + Result
               + '------------------';
    End;

  Finally
    FreeAndNil(qryDet);
  End
End;

procedure TConfirmacaoDocumentos.pPegaPlacaAndKmVeiculo;
begin
  If fCfgSis('AUTCEN', varBoolean) Then
  Begin
    With fatVenda.qryTemporariaConfirmacao Do
    Begin
      First;

      fatVenda.strPlaVei := '';
      fatVenda.strKm_Vei := '';

      While (Not Eof) Do
      Begin
        If (FieldByName('TMP_MARDES').AsString = 'M') And fEmptyStr(fatVenda.strPlaVei) Then
        Begin
          fatVenda.strPlaVei := FieldByName('TMP_PLAVEI').AsString;
          fatVenda.strKm_Vei := FieldByName('TMP_KM_VEI').AsString;
          Break;
        End;

        Next;
      End;
    End;
  End;
end;

procedure TConfirmacaoDocumentos.pRetJurosDescontoSujerido(strNumDoc, strEspDoc, strCodEmp, strCodCli: String;
   Var fltJurSuj, fltDesSuj, fltValAbe: Double);
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE          ';
  strSQL := strSQL + '  SUM(CTR_VALDUP) AS VALDUP, ';
  strSQL := strSQL + '  SUM(CTR_JURSUJ) AS JURSUJ, ';
  strSQL := strSQL + '  SUM(CTR_DESSUJ) AS DESSUJ  ';
  strSQL := strSQL + 'FROM                         ';
  strSQL := strSQL + '  CADREC                     ';
  strSQL := strSQL + 'WHERE                        ';
  strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND   ';
  strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND   ';
  strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND   ';
  strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND   ';
  strSQL := strSQL + '  CTR_DTAREC IS NULL         ';

  qryGen := fCriaQuery;
  With qryGen Do
  Begin
    SQL.Text := strSQL;

    ParamByName('NUMDUP').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODCLI').AsString := strCodCli;
    ParamByName('CODEMP').AsString := strCodEmp;

    Open;

    fltJurSuj := FieldByName('JURSUJ').AsFloat;
    fltDesSuj := FieldByName('DESSUJ').AsFloat;
    fltValAbe := FieldByName('VALDUP').AsFloat;

    Close;
  End;
  FreeAndNil(qryGen);
End;

function TConfirmacaoDocumentos.fCarregaItensConfirmacaoDocumentos: Boolean;

  function fPegaMensagem: Boolean;
    Var
      intCnt : Integer;
  begin
    Result := False;
    For intCnt := 1 To 5 Do
    Begin
      If fEmptyStr(GetPropValue(fatVenda, 'strMen' + fStrZero(intCnt, 3))) Then
      Begin
        Result := True;
        Break;
      End;
    End;
  end;

  function fMensagemExiste(strMens: String): Boolean;
    Var
      intCnt : Integer;
      strTmpMsg : String;
  begin
    For intCnt := 1 To 5 Do
    Begin
      Result := False;
      strTmpMsg := GetPropValue(fatVenda, 'strMen' + fStrZero(intCnt, 3));
      If (strTmpMsg.Contains(strMens)) Then
      Begin
        Result := True;
        Break;
      End;
    End;
  end;

  Var
    strSQL: String;
    strItemAnt: String;
    fltUnitarioEmb: Double;
    intContServico: Integer;
    intContador: Integer;
    qryGenIte: TUniQuery;
    qryGenDet: TUniClientDataSet;

    strSiglaUnidade: String;

    blnPegMsg: Boolean;
    blnPegEndEnt: Boolean;

    recMadeira: TDadosMadeira;

    fltUnitar: Double;
    fltPreCus: Double;
    fltPreCu2: Double;

    fltIcmSai: Double;
    fltDesOpe: Double;
    fltImpFed: Double;
    fltOutVal: Double;

    fltPreMed: Double;
    fltPreUlt: Double;
    fltImpUlt: Double;
    fltImpUltAux: Double;

    recForTin: TForTin;
    blnDecidiuEndereco : Boolean;
    calcCustoReal: TCalcCustoReal;
    impSubIteEst : TImpostosSubItensEstrutura;

    stlIteEmb,
    stlIteAux: TStringList;

    fltItePreVe1,
    fltItePreVe2,
    fltItePreVe3,
    fltItePreVe4,
    fltItePreVe5,
    fltItePreVe6,
    fltItePreVe7: Double;

    blnCoenre,
    blnSugRom,
    blnEndRet: Boolean;

    fltPesBruTmp: Double;
    fltPesLiqTmp: Double;
    fltQtdIte   : Double;

    fltFatorPreco: Double;
    fltUniOri : Double;
    fltUniVis : Double;
    fltTtItem : Double;
    fltCusOri : Double;
    intContador2 : Integer;
    strBrinde : String;
    strCodSit,
    strCodAbf: String;
    fltDedCus: Double;
    strNotC17: String;
    blnUtilizaNumeroSerieDesNes: Boolean;
    blnCopiaDesNes: Boolean;

    objRecalculoSeqCombo: IRecalculoSeqComboController;

  function fRetornaSeqCom():Integer;
  begin
    If (Not Assigned(objRecalculoSeqCombo)) Then
      objRecalculoSeqCombo := TRecalculoSeqComboController.fNew();

    Result := objRecalculoSeqCombo.fRecalculaSeqCom(qryGenDet.FieldByName('DET_NUMDOC').AsString + '-' +
                                                    qryGenDet.FieldByName('DET_ESPDOC').AsString + '-' +
                                                    qryGenDet.FieldByName('DET_CODEMP').AsString,
                                                    qryGenDet.FieldByName('DET_SEQCOM').AsInteger);
  end;

begin
  qryGenIte := fCriaQuery(Self);
  qryGenDet := TUniClientDataSet.Create(Self);

  strItemAnt := '';

  blnUtilizaNumeroSerieDesNes := ((fCfgSis('NUMSER', varString) = 'S') And (fCfgSis('DETSER', varString) = 'S'));

  blnCopiaDesNes := ((fCfgSis('PDPCDN', varString) = 'S') Or (blnUtilizaNumeroSerieDesNes));

  fatVenda.fltDesEsp := 0.0;
  fatVenda.fltDeDVCf := 0.0;

  intContServico := 1;

  If Assigned(pInformacoes) Then pInformacoes('Aguarde... Carregando produtos do(s) documento(s)!');

  {*****************************************}
  {* DOCUMENTO DETALHADO                   *}
  {**************************************MV*}
  qryGenDet.Data := oleDadosConfirmacao;

  stlIteAux := TStringList.Create;
  stlIteAux.Sorted := True;
  stlIteAux.Duplicates := dupIgnore;
  Try
    qryGenDet.First;
    While (Not qryGenDet.Eof) Do
    Begin
      stlIteAux.Add(qryGenDet.FieldByName('DET_CODITE').AsString.QuotedString);

      qryGenDet.Edit;
      qryGenDet.FieldByName('DET_DESESP').AsFloat := fFormataFloat(qryGenDet.FieldByName('DET_DESESP').AsFloat, 2);
      qryGenDet.Post;

      qryGenDet.Next;
    End;
  Finally
    stlIteEmb := fRetornaSomenteItensComQtdEmbalagemFechadaDaLista(stlIteAux.CommaText);

    qryGenDet.First;
    While (Not qryGenDet.Eof) Do
    Begin
      If stlIteEmb.IndexOf(qryGenDet.FieldByName('DET_CODITE').AsString) = -1 Then
        fatVenda.stlItensNaoTemQtdeEmbFec.Add(qryGenDet.FieldByName('DET_CODITE').AsString);

      qryGenDet.Next;
    End;

    FreeAndNil(stlIteAux);
    FreeAndNil(stlIteEmb);
  End;

  {**************************************}
  {* SOLICITACAO GALASSO - REQ. 30833   *}
  {***********************************JC*}
  qryGenDet.IndexFieldNames := 'DET_NUMDOC;DET_ESPDOC;DET_CODEMP;AUTOINCREM';

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  I.ITE_DESITE, ';
  strSQL := strSQL + '  I.ITE_DESSIM, ';
  strSQL := strSQL + '  I.ITE_DESFAB, ';
  strSQL := strSQL + '  I.ITE_COMLUB, ';
  strSQL := strSQL + '  I.ITE_CLAIPI, ';
  strSQL := strSQL + '  I.ITE_EXCIPI, ';
  strSQL := strSQL + '  I.ITE_CODFAB, ';
  strSQL := strSQL + '  I.ITE_CODBAR, ';
  strSQL := strSQL + '  G.ITE_OUTVAL, ';
  strSQL := strSQL + '  G.ITE_IMPFED, ';
  strSQL := strSQL + '  G.ITE_ICMSAI, ';
  strSQL := strSQL + '  G.ITE_DESOPE, ';
  strSQL := strSQL + '  G.ITE_PREULT, ';
  strSQL := strSQL + '  G.ITE_IMPULT, ';
  strSQL := strSQL + '  G.ITE_QTDUCO, ';
  strSQL := strSQL + '  G.ITE_PRECUS, ';

  strSQL := strSQL + '  G.ITE_PREVE1, ';
  strSQL := strSQL + '  G.ITE_PREVE2, ';
  strSQL := strSQL + '  G.ITE_PREVE3, ';
  strSQL := strSQL + '  G.ITE_PREVE4, ';
  strSQL := strSQL + '  G.ITE_PREVE5, ';
  strSQL := strSQL + '  G.ITE_PREVE6, ';
  strSQL := strSQL + '  G.ITE_PREVE7, ';

  strSQL := strSQL + '  G.ITE_COMTB1, ';
  strSQL := strSQL + '  G.ITE_COMTB2, ';
  strSQL := strSQL + '  G.ITE_COMTB3, ';
  strSQL := strSQL + '  G.ITE_COMTB4, ';
  strSQL := strSQL + '  G.ITE_COMTB5, ';
  strSQL := strSQL + '  G.ITE_COMTB6, ';
  strSQL := strSQL + '  G.ITE_COMTB7, ';
  strSQL := strSQL + '  G.ITE_IPISAI, ';
  strSQL := strSQL + '  G.ITE_DESMAX, ';
  strSQL := strSQL + '  G.ITE_DESMGE, ';
  strSQL := strSQL + '  G.ITE_DESMSU, ';
  strSQL := strSQL + '  G.ITE_SALDOS, ';
  strSQL := strSQL + '  G.ITE_PREMED, ';
  strSQL := strSQL + '  G.ITE_COMVAR, ';
  strSQL := strSQL + '  G.ITE_COMATA, ';
  strSQL := strSQL + '  G.ITE_COMDIS, ';
  strSQL := strSQL + '  G.ITE_MARMIN, ';
  strSQL := strSQL + '  G.ITE_MARMSG, ';
  strSQL := strSQL + '  G.ITE_MARMGE, ';

  strSQL := strSQL + '  G.ITE_DESMVM, ';
  strSQL := strSQL + '  G.ITE_DESMSM, ';
  strSQL := strSQL + '  G.ITE_DESMGM, ';

  strSQL := strSQL + '  G.ITE_MARMMV, ';
  strSQL := strSQL + '  G.ITE_MARMMS, ';
  strSQL := strSQL + '  G.ITE_MARMMG, ';

  strSQL := strSQL + '  G.ITE_IPIENT, ';
  strSQL := strSQL + '  G.ITE_FREENT, ';
  strSQL := strSQL + '  G.ITE_LOCFIS, ';

  strSQL := strSQL + ' ( SELECT ABFICM.ABF_CODABF ';
  If fCfgSis('TIPABF') = '1' Then
  Begin
    strSQL := strSQL + ' FROM ABFICM ';
    strSQL := strSQL + ' WHERE ABFICM.ABF_CODABF = I.ITE_CODABF AND ';
    strSQL := strSQL + '       ABFICM.ABF_ESTADO = :ESTADO ';
  End
  Else
  Begin
    strSQL := strSQL + ' FROM ABFICM ';
    strSQL := strSQL + '      INNER JOIN ITEGER ON ABFICM.ABF_CODABF = ITEGER.ITE_CODABF ';
    strSQL := strSQL + ' WHERE ITEGER.ITE_CODITE = G.ITE_CODITE AND ';
    strSQL := strSQL + '       ITEGER.ITE_CODEMP = '+QuotedStr(VS_strCodEmp)+' AND ';
    strSQL := strSQL + '       ABFICM.ABF_ESTADO = :ESTADO ';
  End;
  strSQL := strSQL + ' LIMIT 1 ) AS ABF_CODABF, ';

  strSQL := strSQL + '  I.ITE_PESOIT, ';
  strSQL := strSQL + '  I.ITE_PESLIQ, ';
  strSQL := strSQL + '  M.MAR_DESMAR, ';
  strSQL := strSQL + '  I.ITE_OBRCPF, ';
  strSQL := strSQL + '  G.ITE_PRECOM, ';

  If fCfgSis('IMPDIG') = '1' Then
    strSQL := strSQL + '  I.ITE_IMPDIR,  '
  Else
    strSQL := strSQL + '  G.ITE_IMPDIR,  ';

  strSQL := strSQL + '  I.ITE_EMBALA,  ';
  strSQL := strSQL + '  I.ITE_NOTESP,  ';
  strSQL := strSQL + '  I.ITE_CODFOR   ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I, ';
  strSQL := strSQL + '  ITEGER G, ';
  strSQL := strSQL + '  CADMAR M  ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  I.ITE_CODMAR = M.MAR_CODMAR AND ';
  strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';
  strSQL := strSQL + '  I.ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP     ';

  {*****************************************}
  {* PREPARA A QUERY PARA RETORNAR DADOS   *}
  {* DO ITEM E DA ABREVIAÇÃO FISCAL        *}
  {**************************************MV*}
  With qryGenIte Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
  End;


  blnCoenre := fCfgSis('COENRE', varBoolean);
  blnSugRom := fCfgSis('SUJROM', varBoolean);
  blnEndRet := fCfgSis('ENDRET', varBoolean);

  If fGetSintetizarDV Then
  Begin
    fatVenda.pCriaCdsIteSin;
  End;

  With fatVenda.qryTemporariaConfirmacao Do
  Begin

    First;
    blnPegMsg    := True;

    fatVenda.strMen001 := '';
    fatVenda.strMen002 := '';
    fatVenda.strMen003 := '';
    fatVenda.strMen004 := '';
    fatVenda.strMen005 := '';

    While (Not Eof) Do
    Begin
      If fEmptyStr(fatVenda.strFasObr) Then
        fatVenda.strFasObr := FieldByName('TMP_FASOBR').AsString;

      If fEmptyStr(fatVenda.strCodPrj) Then
        fatVenda.strCodPrj := FieldByName('TMP_CODPRJ').AsString;

      {******************************************}
      {* PEGA AS MENSAGENS DO PRIMEIRO REGISTRO *}
      {* QUE POSSUI MENSAGENS GRAVADAS.         *}
      {***************************************PZ*}
      If (blnPegMsg) And
         ((Not fEmptyStr(FieldByName('TMP_MEN001').AsString)) Or
          (Not fEmptyStr(FieldByName('TMP_MEN002').AsString)) Or
          (Not fEmptyStr(FieldByName('TMP_MEN003').AsString)) Or
          (Not fEmptyStr(FieldByName('TMP_MEN004').AsString)) Or
          (Not fEmptyStr(FieldByName('TMP_MEN005').AsString))) And
         (FieldByName('TMP_SEQMAR').AsInteger > 0)   Then
      Begin
        For intContador := 1 To 5 Do
        Begin
          If fEmptyStr(GetPropValue(fatVenda, 'strMen' + fStrZero(intContador, 3))) Then
          Begin
            For intContador2 := 1 To 5 Do
            Begin
              If (Not fEmptyStr(FieldByName('TMP_MEN' + fStrZero(intContador2, 3)).AsString)) And (Not fMensagemExiste(FieldByName('TMP_MEN' + fStrZero(intContador2, 3)).AsString)) Then
              Begin
                SetPropValue(fatVenda, 'strMen' + fStrZero(intContador, 3), FieldByName('TMP_MEN' + fStrZero(intContador2, 3)).AsString);
                Break;
              End;
            End;
          End;
        End;
        blnPegMsg := fPegaMensagem;
      End;

      blnPegEndEnt := (blnEndRet) Or
                      (blnSugRom And (Not blnCoenre)) Or
                      (blnCoenre And (FieldByName('TMP_ENTRET').AsString = 'E'));

      If (blnPegEndEnt) And fEmptyStr(FCodFaz) Then
      Begin
        If (fatVenda.strCliFat = fatVenda.strCodCli) Then
        Begin
          fatVenda.pCarregaEnderecoEntrega(fatVenda,
                                           FieldByName('TMP_NOMTAB').AsString,
                                           FieldByName('TMP_AUTINC').AsString,
                                           True);

          blnPegEndEnt := fEmptyStr(fatVenda.strEndEnt);

          If Not blnPegEndEnt Then
            fatVenda.blnEndEntConfDoc := True;
        End
        Else
        Begin
          fatVenda.blnEndEntConfDoc := True;
        End;
      End;

      If (Pos(FieldByName('TMP_ESPDOC').AsString, 'MI_FF_TR_DV_PR_') > 0) Or (blnEstornoNotaFiscal) Then
      Begin

        For intContador := 1 To 30 Do
        Begin

          If (Not fEmptyStr(FieldByName('TMP_CODS' + fStrZero(intContador, 2)).AsString)) Then
          Begin
            fatVenda.pAtribuiValoresServico( intContServico,
                                             FieldByName('TMP_CODS' + fStrZero(intContador, 2)).AsString,
                                             FieldByName('TMP_DESS' + fStrZero(intContador, 2)).AsString,
                                             FieldByName('TMP_IDES' + fStrZero(intContador, 2)).AsString,
                                             FieldByName('TMP_BRIS' + fStrZero(intContador, 2)).AsString,
                                             FieldByName('TMP_PARS' + fStrZero(intContador, 2)).AsString,
                                             FieldByName('TMP_TBRS' + fStrZero(intContador, 2)).AsString,
                                             FieldByName('TMP_VENS' + fStrZero(intContador, 2)).AsString,
                                             FieldByName('TMP_VE2S' + fStrZero(intContador, 2)).AsString,
                                             FieldByName('TMP_QTDS' + fStrZero(intContador, 2)).AsFloat,
                                             FieldByName('TMP_UNIS' + fStrZero(intContador, 2)).AsFloat,
                                             FieldByName('TMP_VALS' + fStrZero(intContador, 2)).AsFloat,
                                             FieldByName('TMP_CUSS' + fStrZero(intContador, 2)).AsFloat,
                                             FieldByName('TMP_DECS' + fStrZero(intContador, 2)).AsFloat );
            Inc(intContServico);

          End;

        End;

        fatVenda.strDisSer := fatVenda.strDisSer + FieldByName('TMP_DISSER').AsString+ LineFeed;

        {**********************************************}
        {*         SOMA DUPLICATAS RECEBIDAS          *}
        {* QUANDO O DOC. FOI SINTETIZADO, NAO SOMA    *}
        {* A DUPREC PQ A DEVOL. NAO ESTARA MAIS       *}
        {* PRESENTE NA OPERACAO. A FF ESTA PRESENTE   *}
        {* POIS E NECESSARIO FATURALA, E ELA CARREGA  *}
        {* CONSIGO TODAS AS DEVOL. SINTETIZADAS.      *}
        {****************************************MV,JB*}
        If Not SameText(FieldByName('SAV_SINTET').AsString, 'S') Then
          fatVenda.fltDupRec := fatVenda.fltDupRec + FieldByName('TMP_DUPREC').AsFloat -
                                FieldByName('TMP_JURSUJ').AsFloat + FieldByName('TMP_DESSUJ').AsFloat;

        If FieldByName('TMP_VLRCON').AsFloat = 0.0 Then
        Begin
          Next;
          Continue;
        End;

        {*****************************************}
        {* SOMA DESCONTO ESPECIAL                *}
        {**************************************MV*}
//          fatVenda.fltDesEsp := fatVenda.fltDesEsp + FieldByName('TMP_DESESP').AsFloat;

        {*****************************************}
        {* CARREGA DOCUMENTO DETALHADO           *}
        {**************************************MV*}
        qryGenDet.Filtered := False;
        qryGenDet.Filter   := '';
        qryGenDet.Filter   := qryGenDet.Filter + 'DET_QTDITE > 0 AND ';
        qryGenDet.Filter   := qryGenDet.Filter + 'DET_NUMDOC = ' + QuotedStr(FieldByName('TMP_NUMDOC').AsString) + ' AND ';
        qryGenDet.Filter   := qryGenDet.Filter + 'DET_ESPDOC = ' + QuotedStr(FieldByName('TMP_ESPDOC').AsString) + ' AND ';
        qryGenDet.Filter   := qryGenDet.Filter + 'DET_CODEMP = ' + QuotedStr(FieldByName('TMP_CODEMP').AsString) + ' ';
        qryGenDet.Filtered := True;
        qryGenDet.First;

        If (FieldByName('TMP_EDIPES').AsString = 'S') Then
          fatVenda.strEdiPes := 'E';

        While (Not qryGenDet.Eof) Do
        Begin

          If qryGenDet.FieldByName('DET_QTDITE').AsFloat = 0.0 Then
          Begin
            qryGenDet.Next;
            Continue;
          End;

          {*****************************************}
          {* SÓ ADICIONA AS SAÍDAS                 *}
          {**************************************MV*}
          If (StrToInt(LeftStr(qryGenDet.FieldByName('DET_CLAFIS').AsString, 1)) < 5) And (not blnEstornoNotaFiscal) Then
          Begin
            fatVenda.fltDesEsp := fatVenda.fltDesEsp + (qryGenDet.FieldByName('DET_TOTITE').AsFloat - qryGenDet.FieldByName('DET_DESESP').AsFloat);
            fatVenda.fltDesSai := fatVenda.fltDesSai + (qryGenDet.FieldByName('DET_TOTITE').AsFloat - qryGenDet.FieldByName('DET_DESESP').AsFloat);
            fatVenda.fltDeDVCf := fatVenda.fltDeDVCf + (qryGenDet.FieldByName('DET_TOTITE').AsFloat - qryGenDet.FieldByName('DET_DESESP').AsFloat);

            qryGenDet.Next;
            Continue;
          End;

          If (fCfgSis('USASER', varBoolean)) Then
          Begin
            If fEhItemServico(qryGenDet.FieldByName('DET_CODITE').AsString) Then
            Begin
              qryGenDet.Next;
              Continue;
            End;
          End;

          {*****************************************}
          {* SOMA DESCONTO ESPECIAL                *}
          {**************************************MV*}
          If (Not fatVenda.blnMeiaNota) Then
            fatVenda.fltDesEsp := fatVenda.fltDesEsp + qryGenDet.FieldByName('DET_DESESP').AsFloat;

          If (strItemAnt <> qryGenDet.FieldByName('DET_CODITE').AsString) Then
          Begin

            {*****************************************}
            {* CARREGA ITEM                          *}
            {**************************************MV*}
            qryGenIte.Close;
            qryGenIte.ParamByName('CODITE').AsString := qryGenDet.FieldByName('DET_CODITE').AsString;
            qryGenIte.ParamByName('CODEMP').AsString := qryGenDet.FieldByName('DET_CODEMP').AsString;
            qryGenIte.ParamByName('ESTADO').AsString := qryGenDet.FieldByName('DET_ESTADO').AsString;
            qryGenIte.Open;

            fatVenda.pCarregaValoresCusto(qryGenDet.FieldByName('DET_CODITE').AsString,
                                          qryGenDet.FieldByName('DET_CODEMP').AsString,
                                          qryGenDet.FieldByName('DET_TABPRE').AsString);

            strItemAnt  := qryGenDet.FieldByName('DET_CODITE').AsString;

          End;

          If (qryGenDet.FieldByName('DET_QTDEMB').AsFloat > 0) Then
            fltUnitarioEmb := (qryGenDet.FieldByName('DET_PREEMB').AsFloat /
                               qryGenDet.FieldByName('DET_QTDEMB').AsFloat)
          Else
            fltUnitarioEmb := 0.0;

          strSiglaUnidade := fRetSiglaUnidade(qryGenDet.FieldByName('DET_UNIDAD').AsString);

          fltPesBruTmp := qryGenDet.FieldByName('DET_TOTPES').AsFloat / qryGenDet.FieldByName('SAV_QTDITE').AsFloat;
          fltPesLiqTmp := qryGenIte.FieldByName('ITE_PESLIQ').AsFloat;

          If (fatVenda.strEdiPes = 'E') Then
          Begin
            fltPesBruTmp := qryGenDet.FieldByName('DET_TOTPES').AsFloat / qryGenDet.FieldByName('SAV_QTDITE').AsFloat;
            fltPesLiqTmp := qryGenDet.FieldByName('DET_PESLIQ').AsFloat / qryGenDet.FieldByName('SAV_QTDITE').AsFloat;
          End;

          If fCfgSis('VENMAD', varBoolean) Or fCfgSis('VENVID', varBoolean) Or fCfgSis('VENMTL', varBoolean) Then
          Begin
            recMadeira.fltComPec := qryGenDet.FieldByName('DET_COMPEC').AsFloat;
            recMadeira.fltLarPec := qryGenDet.FieldByName('DET_LARPEC').AsFloat;
            recMadeira.fltEspPec := qryGenDet.FieldByName('DET_ESPPEC').AsFloat;

            recMadeira.fltQtdPec := fCalculaQuantidadePecas(qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                                            recMadeira.fltComPec,
                                                            recMadeira.fltLarPec,
                                                            recMadeira.fltEspPec,
                                                            fRetSiglaUnidade(qryGenDet.FieldByName('DET_UNIDAD').AsString));

            recMadeira.strAparel := qryGenDet.FieldByName('DET_APAREL').AsString;
            recMadeira.fltPerApa := qryGenDet.FieldByName('DET_PERAPA').AsFloat;
            recMadeira.strBenefi := qryGenDet.FieldByName('DET_BENEFI').AsString;
            recMadeira.fltPerBen := qryGenDet.FieldByName('DET_PERBEN').AsFloat;
          End;

          If (Not fUsaRomaneioNotaAbatendoDevolucao) And
             (Not fatVenda.blnMeiaNota) And
             (fSintetizarItensNaConfirmacaoDeDocumentos) And
             (qryGenDet.FieldByName('DET_TEMSER').AsString = 'N') And
             (qryGenDet.FieldByName('DET_IDEPRO').AsString = 'NOR') And
             (qryGenDet.FieldByName('DET_ENTFUT').AsString <> 'S') And
             (qryGenDet.FieldByName('DET_DESESP').AsFloat = 0) And
             (Pos('ITEM ESPECIAL',   qryGenIte.FieldByName('ITE_DESITE').AsString) <= 0) And
             (fatVenda.fLocalizaItem(qryGenDet.FieldByName('DET_CODITE').AsString,
                                     qryGenDet.FieldByName('DET_DESCRI').AsString,
                                     qryGenDet.FieldByName('DET_UNITAR').AsFloat,
                                     qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                     qryGenDet.FieldByName('DET_NUMLOT').AsString,
                                     recMadeira,
                                     qryGenDet.FieldByName('DET_NUMCMP').AsString,
                                     qryGenDet.FieldByName('DET_NITCMP').AsString,
                                     True,
                                     True)) Then
          Begin
            If (qryGenDet.FieldByName('DET_IDEPRO').AsString = 'NOR') Then
              fltImpUltAux := qryGenIte.FieldByName('ITE_IMPULT').AsFloat
            Else  
              fltImpUltAux := qryGenDet.FieldByName('IMPULT').AsFloat;
              
            fatVenda.fSomaNaTemporaria(qryGenDet.FieldByName('DET_CODITE').AsString,
                                       qryGenDet.FieldByName('DET_DESCRI').AsString,
                                       qryGenDet.FieldByName('DET_NUMLOT').AsString,
                                       qryGenDet.FieldByName('DET_UNITAR').AsFloat,
                                       qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                       qryGenDet.FieldByName('DET_TOTITE').AsFloat,
                                       qryGenDet.FieldByName('DET_TOTCUS').AsFloat,
                                       qryGenDet.FieldByName('DET_TOTCU2').AsFloat,
                                       qryGenDet.FieldByName('DET_QTDEMB').AsFloat,
                                       qryGenDet.FieldByName('DET_PREEMB').AsFloat,
                                       qryGenIte.FieldByName('ITE_IPISAI').AsFloat,
                                       recMadeira,
                                       qryGenDet.FieldByName('DET_CODVEN').AsString,
                                       '',
                                       fltImpUltAux * qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                       qryGenDet.FieldByName('DET_NUMDOC').AsString,
                                       qryGenDet.FieldByName('DET_ESPDOC').AsString,
                                       qryGenDet.FieldByName('DET_CODEMP').AsString,
                                       qryGenDet.FieldByName('DET_AUTOIN').AsString,
                                       qryGenDet.FieldByName('DET_NUMCMP').AsString,
                                       qryGenDet.FieldByName('DET_NITCMP').AsString);

          End
          Else
          Begin
            fltUnitar := qryGenDet.FieldByName('DET_UNITAR').AsFloat;

            If (qryGenDet.FieldByName('DET_IDEPRO').AsString = 'NOR') Then
            Begin
              strNotC17 := '';
              fltDedCus := 0;
              If (Pos(fCfgSis('MCAT17'),'D_A_C_M_V_') > 0) Then
              Begin
                fltDedCus := fatVenda.fRetornaPrecoCustoDeduzindoRessarcimentoCAT(
                                                       qryGenDet.FieldByName('DET_CODITE').AsString,
                                                       VS_strCodEmp,
                                                       fatVenda.fGetCodAbf(qryGenDet.FieldByName('DET_CODITE').AsString, VS_strCodEmp),
                                                       qryGenIte.FieldByName('ITE_CODFOR').AsString,
                                                       fatVenda.fRetPreCus(qryGenIte.FieldByName('ITE_PRECUS').AsFloat),
                                                       strNotC17);
              End;

              fltPreCus := fatVenda.fRetornaPrecoCusto(Preco_de_Custo,
                                                       qryGenDet.FieldByName('DET_CODITE').AsString,
                                                       '',
                                                       IIF((fltDedCus > 0), fltDedCus, fatVenda.fRetPreCus(qryGenDet.FieldByName('PRECUS').AsFloat)),
                                                       '',
                                                       Nil,
                                                       (Pos('ITEM ESPECIAL', qryGenDet.FieldByName('DET_DESCRI').AsString) > 0));

              calcCustoReal := TCalcCustoReal.Create;
              calcCustoReal.fltUnitar := fltUnitar;
              calcCustoReal.fltPreCus := fltPreCus;
              calcCustoReal.fltOutVal := fatVenda.fRetOutVal(qryGenIte.FieldByName('ITE_OUTVAL').AsFloat);
              calcCustoReal.fltIcmSai := fatVenda.fRetIcmSai(qryGenDet.FieldByName('DET_ALQICM').AsFloat);
              calcCustoReal.fltImpFed := fatVenda.fRetImpFed(qryGenIte.FieldByName('ITE_IMPFED').AsFloat);
              calcCustoReal.fltDesOpe := fatVenda.fRetDesOpe(qryGenIte.FieldByName('ITE_DESOPE').AsFloat) + fatVenda.fltDesOpeCli;

              strCodSit := '';
              strCodAbf := fatVenda.fGetCodAbf(qryGenDet.FieldByName('DET_CODITE').AsString, VS_strCodEmp);
              If (Not fEmptyStr(fatVenda.GetTipAbf)) And (fatVenda.fBuscaAbfIcm(qryGenDet.FieldByName('DET_CODITE').AsString, '', strCodAbf, fatVenda.fTrocaUFEndEntrega)) Then
                strCodSit := fatVenda.cdsAbfIcm.FieldByName('ABF_CODSIT' + fatVenda.GetTipAbf).AsString;

              calcCustoReal.fltDifal := fatVenda.fRetAlqDifIcms(qryGenDet.FieldByName('DET_CODITE').AsString,
                                                                VS_strCodEmp,
                                                                strCodAbf,
                                                                strCodSit,
                                                                fatVenda.fCalculaAliquota(qryGenDet.FieldByName('DET_CODITE').AsString, VS_strCodEmp, qryGenDet.FieldByName('DET_CODEMP').AsString, qryGenIte.FieldByName('ITE_IMPDIR').AsString));

              If (qryGenDet.FieldByName('DET_VALRET').AsFloat = 0) and (qryGenDet.FieldByName('DET_BASICM').AsFloat <> 0) Then
                calcCustoReal.fltFcp   := fatVenda.fGetAlqFcpIcms(qryGenDet.FieldByName('DET_CODITE').AsString,
                                                                  VS_strCodEmp,
                                                                  strCodAbf,
                                                                  strCodSit,
                                                                  fatVenda.fCalculaAliquota(qryGenDet.FieldByName('DET_CODITE').AsString, qryGenDet.FieldByName('DET_CODEMP').AsString, qryGenIte.FieldByName('ITE_IMPDIR').AsString),
                                                                  calcCustoReal.fltUnitar);

              fltPreCu2 := fatVenda.fRetornaPrecoCusto(Preco_de_Custo_Real,
                                                       qryGenDet.FieldByName('DET_CODITE').AsString,
                                                       '',
                                                       fltPreCus,
                                                       '',
                                                       calcCustoReal,
                                                       (Pos('ITEM ESPECIAL', qryGenDet.FieldByName('DET_DESCRI').AsString) > 0));

              If fatVenda.fUtilizaPrecoSubItensEstrutura(Pos('ITEM ESPECIAL', qryGenDet.FieldByName('DET_DESCRI').AsString) > 0,
                                                         qryGenDet.FieldByName('DET_CODITE').AsString) Then
              Begin
                impSubIteEst.strCodIte := qryGenDet.FieldByName('DET_CODITE').AsString;
                impSubIteEst.strEmpIte := '';
                impSubIteEst.fltUniPai := fltUnitar;
                impSubIteEst.fltQtdPai := qryGenDet.FieldByName('DET_QTDITE').AsFloat;

                fatVenda.pRetImpostosSubItensEstrutura(impSubIteEst);

                fltOutVal    := impSubIteEst.fltOutVal;
                fltIcmSai    := impSubIteEst.fltIcmSai;
                fltDesOpe    := impSubIteEst.fltDesOpe;
                fltImpFed    := impSubIteEst.fltImpFed;

                fltItePreVe1 := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,qryGenDet.FieldByName('DET_CODITE').AsString,'','S','1',fatVenda.fltMargem);
                fltItePreVe2 := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,qryGenDet.FieldByName('DET_CODITE').AsString,'','S','2',fatVenda.fltMargem);
                fltItePreVe3 := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,qryGenDet.FieldByName('DET_CODITE').AsString,'','S','3',fatVenda.fltMargem);
                fltItePreVe4 := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,qryGenDet.FieldByName('DET_CODITE').AsString,'','S','4',fatVenda.fltMargem);
                fltItePreVe5 := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,qryGenDet.FieldByName('DET_CODITE').AsString,'','S','5',fatVenda.fltMargem);
                fltItePreVe6 := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,qryGenDet.FieldByName('DET_CODITE').AsString,'','S','6',fatVenda.fltMargem);
                fltItePreVe7 := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,qryGenDet.FieldByName('DET_CODITE').AsString,'','S','7',fatVenda.fltMargem);
              End
              Else
              Begin
                fltOutVal    := fatVenda.fRetOutVal(qryGenIte.FieldByName('ITE_OUTVAL').AsFloat);
                fltIcmSai    := fatVenda.fRetIcmSai(qryGenDet.FieldByName('DET_ALQICM').AsFloat);
                fltDesOpe    := fatVenda.fRetDesOpe(qryGenIte.FieldByName('ITE_DESOPE').AsFloat);
                fltImpFed    := fatVenda.fRetImpFed(qryGenIte.FieldByName('ITE_IMPFED').AsFloat);
                fltItePreVe1 := qryGenIte.FieldByName('ITE_PREVE1').AsFloat;
                fltItePreVe2 := qryGenIte.FieldByName('ITE_PREVE2').AsFloat;
                fltItePreVe3 := qryGenIte.FieldByName('ITE_PREVE3').AsFloat;
                fltItePreVe4 := qryGenIte.FieldByName('ITE_PREVE4').AsFloat;
                fltItePreVe5 := qryGenIte.FieldByName('ITE_PREVE5').AsFloat;
                fltItePreVe6 := qryGenIte.FieldByName('ITE_PREVE6').AsFloat;
                fltItePreVe7 := qryGenIte.FieldByName('ITE_PREVE7').AsFloat;
              End;

              fltPreMed := qryGenIte.FieldByName('ITE_PREMED').AsFloat;
              fltPreUlt := qryGenIte.FieldByName('ITE_PREULT').AsFloat;
              fltImpUlt := qryGenIte.FieldByName('ITE_IMPULT').AsFloat;
            End
            Else
            Begin
              fltPreCus := qryGenDet.FieldByName('PRECUS').AsFloat;

              fltIcmSai := qryGenDet.FieldByName('ICMSAI').AsFloat;
              fltDesOpe := qryGenDet.FieldByName('DESOPE').AsFloat;
              fltImpFed := qryGenDet.FieldByName('IMPFED').AsFloat;
              fltOutVal := qryGenDet.FieldByName('OUTVAL').AsFloat;

              fltPreMed := qryGenDet.FieldByName('PREMED').AsFloat;
              fltPreUlt := qryGenDet.FieldByName('PREULT').AsFloat;
              fltImpUlt := qryGenDet.FieldByName('IMPULT').AsFloat;

              fltPreCu2 := qryGenDet.FieldByName('PRECU2').AsFloat;

              fltItePreVe1 := qryGenIte.FieldByName('ITE_PREVE1').AsFloat;
              fltItePreVe2 := qryGenIte.FieldByName('ITE_PREVE2').AsFloat;
              fltItePreVe3 := qryGenIte.FieldByName('ITE_PREVE3').AsFloat;
              fltItePreVe4 := qryGenIte.FieldByName('ITE_PREVE4').AsFloat;
              fltItePreVe5 := qryGenIte.FieldByName('ITE_PREVE5').AsFloat;
              fltItePreVe6 := qryGenIte.FieldByName('ITE_PREVE6').AsFloat;
              fltItePreVe7 := qryGenIte.FieldByName('ITE_PREVE7').AsFloat;
            End;

            If qryGenDet.FieldByName('DET_IDEPRO').AsString <> 'NOR' Then
            Begin
              If Not IsTintaExistente(qryGenDet.FieldByName('DET_IDEPRO').AsString) Then
              Begin
                Result := False;
                If Assigned(qryGenDet) Then FreeAndNil(qryGenDet);
                If Assigned(qryGenIte) Then FreeAndNil(qryGenIte);
                Exit;
              End;
            End;

            fltUniOri := qryGenDet.FieldByName('DET_UNIORI').AsFloat;
            fltUniVis := qryGenDet.FieldByName('DET_UNIVIS').AsFloat;
            fltTtItem := qryGenDet.FieldByName('DET_TOTITE').AsFloat;

            If (fatVenda.blnMeiaNota) Then
            Begin
              fltFatorPreco := fatVenda.fltFatNot;

              If (qryGenIte.FieldByName('ITE_NOTESP').AsString = 'N') Or
                 (fFormataFloat(fltFatorPreco, 4) <= 0) Then
                fltFatorPreco := 1;

              fltCusOri := qryGenDet.FieldByName('DET_TOTCUS').AsFloat / qryGenDet.FieldByName('DET_QTDITE').AsFloat;
              fltPreCus := qryGenDet.FieldByName('DET_TOTCUS').AsFloat * fltFatorPreco / qryGenDet.FieldByName('DET_QTDITE').AsFloat;
              fltPreCu2 := qryGenDet.FieldByName('DET_TOTCU2').AsFloat * fltFatorPreco / qryGenDet.FieldByName('DET_QTDITE').AsFloat;

              fltUnitar := (qryGenDet.FieldByName('DET_UNITAR').AsFloat * fltFatorPreco) -
                           ((qryGenDet.FieldByName('DET_DESESP').AsFloat / qryGenDet.FieldByName('DET_QTDITE').AsFloat) * fltFatorPreco);

              fltOutVal := fltOutVal * fltFatorPreco;

              fltItePreVe1 := fltItePreVe1 * fltFatorPreco;
              fltItePreVe2 := fltItePreVe2 * fltFatorPreco;
              fltItePreVe3 := fltItePreVe3 * fltFatorPreco;
              fltItePreVe4 := fltItePreVe4 * fltFatorPreco;
              fltItePreVe5 := fltItePreVe5 * fltFatorPreco;
              fltItePreVe6 := fltItePreVe6 * fltFatorPreco;
              fltItePreVe7 := fltItePreVe7 * fltFatorPreco;

              If (fFormataFloat(fltUnitar, fCfgSis('DECUNI', varInteger))) < (fFormataFloat(fltCusOri, fCfgSis('DECUNI', varInteger))) Then
                fltUnitar := fltCusOri;

              fltUniOri := fltUnitar;
              fltUniVis := fltUnitar;

              fltTtItem := fltUnitar * qryGenDet.FieldByName('DET_QTDITE').AsFloat;
            End;

            strBrinde := fCampoTabela('CASE WHEN COUNT(BRI_SEQDET) > 0 THEN "S" ELSE "N" END', 'BRIDET', ['BRI_SEQDET'], [qryGenDet.FieldByName('DET_AUTOIN').AsString], False);

            fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
                                                 Nil,
                                                 qryGenDet.FieldByName('DET_IDEPRO').AsString,
                                                 qryGenDet.FieldByName('ITE_CODGRU').AsString,
                                                 qryGenDet.FieldByName('DET_CODITE').AsString,
                                                 qryGenDet.FieldByName('DET_DESCRI').AsString,
                                                 qryGenDet.FieldByName('DET_DESCRI').AsString,
                                                 qryGenIte.FieldByName('ITE_DESFAB').AsString,
                                                 qryGenDet.FieldByName('DET_UNIDAD').AsString,
                                                 qryGenDet.FieldByName('DET_UNIDAD').AsString,
                                                 qryGenDet.FieldByName('DET_CODMAR').AsString,
                                                 qryGenDet.FieldByName('DET_FORITE').AsString,
                                                 qryGenDet.FieldByName('DET_REFERE').AsString,
                                                 fltUniOri,
                                                 fltUniVis,
                                                 fltUnitar,
                                                 fltUnitar,
                                                 qryGenDet.FieldByName('DET_DESCON').AsFloat,
                                                 qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                                 fltTtItem,
                                                 'S',
                                                 fltPreCus,
                                                 fltPreCus * qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                                 qryGenIte.FieldByName('ITE_COMLUB').AsString,
                                                 qryGenIte.FieldByName('ITE_IPISAI').AsFloat,
                                                 qryGenIte.FieldByName('ITE_DESMAX').AsFloat,
                                                 fltItePreVe1,
                                                 fltItePreVe2,
                                                 fltItePreVe3,
                                                 fltItePreVe4,
                                                 fltItePreVe5,
                                                 fltItePreVe6,
                                                 fltItePreVe7,

                                                 fCalculaPrecoVenda(2, fltPreCus + fltOutVal,
                                                                       fltUnitar,
                                                                       0,
                                                                       fltIcmSai,
                                                                       fltImpFed,
                                                                       fltDesOpe,
                                                                       qryGenIte.FieldByName('ITE_COMTB' +
                                                                         IIF(fEmptyStr(qryGenDet.FieldByName('DET_TABPRE').AsString), '1',
                                                                           qryGenDet.FieldByName('DET_TABPRE').AsString)).AsFloat,

                                                                       fatVenda.VS_strMARMKP),

                                                 qryGenIte.FieldByName('ITE_SALDOS').AsFloat,
                                                 qryGenDet.FieldByName('DET_INCPIS').AsString,
                                                 qryGenIte.FieldByName('ITE_COMVAR').AsFloat,
                                                 qryGenIte.FieldByName('ITE_COMATA').AsFloat,
                                                 qryGenIte.FieldByName('ITE_COMDIS').AsFloat,
                                                 IIF(blnEstornoNotaFiscal, qryGenDet.FieldByName('DET_DOCDEV').AsString, ''),
                                                 IIF(blnEstornoNotaFiscal, qryGenDet.FieldByName('DET_ESPDEV').AsString, ''),
                                                 IIF(blnEstornoNotaFiscal, qryGenDet.FieldByName('DET_EMPDEV').AsString, ''),
                                                 0.0,
                                                 0.0,
                                                 IIF(blnEstornoNotaFiscal, qryGenDet.FieldByName('DET_INCDEV').AsString, ''),
                                                 fltPreUlt * qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                                 fltImpUlt,
                                                 fltPreUlt,
                                                 fltPreMed,
                                                 qryGenIte.FieldByName('ITE_CLAIPI').AsString,
                                                 '',
                                                 qryGenDet.FieldByName('DET_ITETIN').AsString,
                                                 '',
                                                 '',
                                                 0,
                                                 '',
                                                 qryGenDet.FieldByName('DET_QTDEMB').AsFloat,
                                                 qryGenDet.FieldByName('DET_PREEMB').AsFloat,
                                                 0.0,
                                                 0.0,
                                                 0.0,
                                                 qryGenDet.FieldByName('DET_PROEMB').AsString,
                                                 qryGenDet.FieldByName('DET_ITEEMB').AsString,
                                                 fltUnitarioEmb,
                                                 fltUnitarioEmb,

                                                 qryGenIte.FieldByName('ABF_CODABF').AsString,
                                                 fltPesBruTmp,
                                                 fltPesLiqTmp,
                                                 qryGenDet.FieldByName('DET_PROMOC').AsString,
                                                 0.0,
                                                 0.0,
                                                 0.0,
                                                 0.0,
                                                 IIF(fEmptyStr(qryGenDet.FieldByName('DET_SEQTIN').AsString), '', '2'),
                                                 0.0,
                                                 qryGenIte.FieldByName('ITE_CODFAB').AsString,
                                                 -1,
                                                 0.0,
                                                 qryGenDet.FieldByName('DET_NUM_PD').AsString,
                                                 qryGenDet.FieldByName('DET_ESP_PD').AsString,
                                                 qryGenDet.FieldByName('DET_EMP_PD').AsString,
                                                 qryGenIte.FieldByName('ITE_MARMIN').AsFloat,
                                                 qryGenIte.FieldByName('ITE_MARMSG').AsFloat,
                                                 qryGenIte.FieldByName('ITE_MARMGE').AsFloat,
                                                 qryGenIte.FieldByName('MAR_DESMAR').AsString,
                                                 fatVenda.strStatus,
                                                 0.0,
                                                 0.0,
                                                 qryGenDet.FieldByName('AUTOINCREM').AsString,
                                                 '',
                                                 '',
                                                 qryGenIte.FieldByName('ITE_EMBALA').AsFloat,
                                                 IIF(blnCopiaDesNes, qryGenDet.FieldByName('DET_DESNES').AsString, ''),
                                                 '',
                                                 '',
                                                 qryGenIte.FieldByName('ITE_PRECOM').AsFloat,
                                                 fltUnitar,
                                                 qryGenDet.FieldByName('DET_QTDPON').AsFloat,
                                                 qryGenDet.FieldByName('DET_COMPLE').AsString,
                                                 '',
                                                 qryGenIte.FieldByName('ITE_OBRCPF').AsString,
                                                 '',
                                                 '',
                                                 strSiglaUnidade,
                                                 qryGenDet.FieldByName('DET_VOLPRO').AsFloat,
                                                 fatVenda.fOrdemItem(cdsVenda,'Adiciona',nil),
                                                 '',
                                                 qryGenDet.FieldByName('DET_CODACA').AsString,
                                                 qryGenDet.FieldByName('DET_EMPACA').AsString,
                                                 (qryGenDet.FieldByName('DET_PROACA').AsString = 'S'),
                                                 '',
                                                 '',
                                                 '',
                                                 fltOutVal,
                                                 qryGenIte.FieldByName('ITE_COMTB' +
                                                     IIF(fEmptyStr(qryGenDet.FieldByName('DET_TABPRE').AsString), '1',
                                                                   qryGenDet.FieldByName('DET_TABPRE').AsString)).AsFloat,
                                                 fltDesOpe,
                                                 fltIcmSai,
                                                 fltImpFed,
                                                 qryGenIte.FieldByName('ITE_DESMGE').AsFloat,
                                                 qryGenDet.FieldByName('DET_NUMDOC').AsString,
                                                 qryGenDet.FieldByName('DET_ESPDOC').AsString,
                                                 qryGenDet.FieldByName('DET_CODEMP').AsString,
                                                 qryGenDet.FieldByName('DET_TABPRE').AsString,
                                                 qryGenIte.FieldByName('ITE_IPIENT').AsFloat,
                                                 qryGenIte.FieldByName('ITE_FREENT').AsFloat,
                                                 '',
                                                 0.0,
                                                 '',
                                                 0.0,
                                                 IfThen(blnCoenre Or fatVenda.blnConfirmacaoDoCaixa, FieldByName('TMP_ENTRET').AsString, ''), //Entrega/Retira
                                                 '',
                                                 'N',
                                                 '',
                                                 0,
                                                 qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                                 0,
                                                 0,
                                                 qryGenIte.FieldByName('ITE_IMPDIR').AsString,
                                                 qryGenIte.FieldByName('ITE_LOCFIS').AsString,
                                                 fltPreCu2,
                                                 fltPreCu2 * qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                                 0,
                                                 0,
                                                 0,
                                                 0,
                                                 0,
                                                 0,
                                                 recForTin,
                                                 '',
                                                 '',
                                                 IIF(fatVenda.objCadLot.fExisteLote(qryGenDet.FieldByName('DET_CODITE').AsString, VS_strCodEmp),qryGenDet.FieldByName('DET_NUMLOT').AsString,''),
                                                 '',
                                                 qryGenDet.FieldByName('DET_CODVEN').AsString,
                                                 False,
                                                 'N',
                                                 'NOR',
                                                 0,
                                                 IIF(blnEstornoNotaFiscal, qryGenDet.FieldByName('DET_TABDEV').AsString, ''),
                                                 qryGenIte.FieldByName('ITE_CODBAR').AsString,
                                                 '',
                                                 0,
                                                 0,
                                                 0,
                                                 '', 
                                                 1,
                                                 True,
                                                 '',
                                                 '',
                                                 '',
                                                 0,
                                                 fltPreCus,
                                                 qryGenIte.FieldByName('ITE_DESSIM').AsString,
                                                 '',
                                                 recMadeira,
                                                 fltImpUlt * qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                                 qryGenDet.FieldByName('DET_VAL_RT').AsFloat,
                                                 qryGenDet.FieldByName('DET_TAXJUR').AsFloat,
                                                 '',
                                                 0,
                                                 '',
                                                 qryGenDet.FieldByName('DET_NUMCMP').AsString,
                                                 qryGenDet.FieldByName('DET_NITCMP').AsInteger,
                                                 0,
                                                 '',
                                                 '',
                                                 0,
                                                 '',
                                                 'N',
                                                 0,
                                                 0,
                                                 0,
                                                 False,
                                                 False,
                                                 qryGenDet.FieldByName('DET_CLIBUS').AsString,
                                                 '',
                                                 0,
                                                 0,
                                                 qryGenDet.FieldByName('DET_CODVE2').AsString,
                                                 'N',
                                                 0,
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 qryGenIte.FieldByName('ITE_EXCIPI').AsString,
                                                 qryGenIte.FieldByName('ITE_DESMSU').AsFloat,
                                                 '',
                                                 '',
                                                 '',
                                                 'S',
                                                 strBrinde,
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 (fatVenda.strEdiPes = 'E'),
                                                 qryGenIte.FieldByName('ITE_PESOIT').AsFloat,
                                                 qryGenIte.FieldByName('ITE_PESLIQ').AsFloat,
                                                 'N',
                                                 '',
                                                 qryGenDet.FieldByName('DET_ATIVAC').AsString,
                                                 fRetornaSeqCom(),
                                                 0,
                                                 0,
                                                 '',
                                                 0,
                                                 0,
                                                 0,
                                                 '',
                                                 0,
                                                 0,
                                                 0,
                                                 '',
                                                 '',
                                                 0,
                                                 0,
                                                 0,
                                                 False,
                                                 '',
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
                                                 strNotC17,
                                                 '',
                                                 0,
                                                 0,
                                                 '',
                                                 '',
                                                 'N',
                                                 'N',
                                                 '',
                                                 0,
                                                 0,
                                                 qryGenDet.FieldByName('DET_EMPCAR').AsString,
                                                 '',
                                                 qryGenDet.FieldByName('DET_ENTFUT').AsString,
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 qryGenIte.FieldByName('ITE_DESMVM').AsFloat,
                                                 qryGenIte.FieldByName('ITE_DESMSM').AsFloat,
                                                 qryGenIte.FieldByName('ITE_DESMGM').AsFloat,
                                                 qryGenIte.FieldByName('ITE_MARMMV').AsFloat,
                                                 qryGenIte.FieldByName('ITE_MARMMS').AsFloat,
                                                 qryGenIte.FieldByName('ITE_MARMMG').AsFloat,
                                                 qryGenDet.FieldByName('DET_VDESST').AsFloat,
                                                 qryGenDet.FieldByName('DET_MDESST').AsString,
                                                 'S',
                                                 '',
                                                 0,
                                                 '',
                                                 0,
                                                 0,
                                                 '',
                                                 False,
                                                 0,
                                                 qryGenDet.FieldByName('DET_NUMPLA').AsString,
                                                 qryGenDet.FieldByName('DET_PARNUM').AsString,
                                                 qryGenDet.FieldByName('DET_REQCOM').AsString,
                                                 '',
                                                 0,
                                                 False,
                                                 0,
                                                 0,
                                                 True,
                                                 True,
                                                 'N',
                                                 False,
                                                 '',
                                                 False,
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 False,
                                                 '',
                                                 0,
                                                 0,
                                                 0,
                                                 0,
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 'N',
                                                 '',
                                                 False,
                                                 qryGenDet.FieldByName('DET_DTACMP').AsDateTime);

            If qryGenDet.FieldByName('DET_PROACA').AsString = 'S' Then
              fatVenda.pAtualizaPrecoProdutoAcabadoConfirmacao(cdsVenda, qryGenDet);
          End;

          qryGenDet.Next;

          Application.ProcessMessages;

        End;

        fatVenda.blnVendaPresencial := FieldByName('TMP_VENPRE').AsString = 'S';

        fatVenda.pAcertaTabelaPrecoTinta(FieldByName('TMP_NUMDOC').AsString,
                                         FieldByName('TMP_ESPDOC').AsString,
                                         FieldByName('TMP_CODEMP').AsString);

      End;

      Next;

      Application.ProcessMessages;
    End;

    Result := True;
  End;

  {*****************************************}
  {* SE OCORREU UM ERRO DURANTE O PROCES-  *}
  {* SAMENTO, SAI                          *}
  {**************************************MV*}
  If (Not Result) Then
    Exit;

  If (fatVenda.fltDesSai = 0) And (Not fatVenda.blnMeiaNota) Then
  Begin
    cdsItensConf.First;
    While Not cdsItensConf.Eof do
    Begin
      If cdsVenda.Locate('ITE_SEQDET', cdsItensConf.FieldByName('DET_AUTOIN').AsString, []) Then
      Begin
        cdsVenda.Edit;
        cdsVenda.FieldByName('ITE_DESEXP').AsFloat := cdsItensConf.FieldByName('DET_DESESP').AsFloat;
        cdsVenda.Post;
      End;

      cdsItensConf.Next;
    End;
    cdsVenda.First;
    cdsItensConf.First;
  End;

  If fEmptyStr(fatVenda.fTrocaUFEndEntrega) Then
    fatVenda.pCarregaDadosClienteBaixa(FCodCli);

  Try
    {*****************************************}
    {* PREENCHE A MATRIZ COM OS ITENS        *}
    {**************************************MV*}
    fatVenda.pPreencheMatrizFechamento;

    {*****************************************}
    {* CALCULA TOTAL GERAL                   *}
    {**************************************MV*}
    fatVenda.pCalculaTotGer;
    fatVenda.pAtualizarReformaTributariaNoCdsVenda;

    If (fatVenda.blnEndEntConfDoc) Then
    Begin
      blnDecidiuEndereco := False;
      Repeat
        If (Not fatVenda.fAlteraEnderecoEntrega(False, True, True, True, True)) Then
        Begin
          If fMensagem('', 'Nenhum Endereço de Entrega foi Informado, Continuar?', ['&Sim', '&Não']) = 1 Then
          Begin
            fatVenda.blnEndEntConfDoc := False;
            fatVenda.pLimparEnderecoEntrega;
            fatVenda.pEnderecoToFatVenda;
            blnDecidiuEndereco := True;

            If fatVenda.fAtendeRegraFiscalEndEntrega Then
              fatVenda.pPreencheMatrizFechamento;
          End;
        End
        Else blnDecidiuEndereco := True;
      Until (blnDecidiuEndereco = True);
    End;

  Except
    On E: ExceptionAutCom Do
    Begin
      fMensagem('', E.Message, ['&O K']);
      Result := False;
      Exit;
    End;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmFatVendas.fCarregaItensConfirmacao]');
      Result := False;
      Exit;
    End;
  End;

  FreeAndNil(qryGenDet);
  FreeAndNil(qryGenIte);
end;

function TConfirmacaoDocumentos.fCasoPerfeito(cdsIteTmp: TUniClientDataSet; fltUniDev, fltQtdDev: Double; blnForcarComparacao: Boolean = False): Boolean;
Var
  fltValIte: Double;
  fltValDif: Double;
  blnMsmVal: Boolean;
  strPrx: String;
begin
  If (cdsIteTmp.FieldByName('DET_QTDITE').AsFloat > 0) Or (blnForcarComparacao) Then
  Begin
    {*****************************************************************************}
    {* SE A QUANTIDADE FOR MENOR OU IGUAL A ZERO É PORQUE O ITEM FOI SINTETIZADO.*}
    {* QUANDO SINTETIZADO OS VALORES DO TOTITE, DESESP, QTDITE SÃO SERADOS,      *}
    {* POR ISSO PEGO OS VALORES SALVOS.                                          *}
    {**************************************************************************PZ*}
    strPrx:=IIF(cdsIteTmp.FieldByName('DET_QTDITE').AsFloat <= 0,'SAV_','DET_');

    If (cdsIteTmp.FieldByName(strPrx+'DESESP').AsFloat <= 0.00) Then
      fltValIte := cdsIteTmp.FieldByName(strPrx+'UNITAR').AsFloat
    Else
      fltValIte := fFormataFloat((cdsIteTmp.FieldByName(strPrx+'TOTITE').AsFloat - cdsIteTmp.FieldByName(strPrx+'DESESP').AsFloat) / cdsIteTmp.FieldByName(strPrx+'QTDITE').AsFloat, 2);

    fltValDif := (fFormataFloat(fltValIte, 2) - fFormataFloat(fltUniDev, 2));
    fltValDif := (fFormataFloat(fltValDif, 2));

    blnMsmVal := (CompareValue(fltValDif,     0) = EqualsValue) Or
                 (CompareValue(fltValDif, +0.01) = EqualsValue) Or
                 (CompareValue(fltValDif, -0.01) = EqualsValue);

    Result := (blnMsmVal) And
              (fFormataFloat(fltQtdDev, 2) <= fFormataFloat(cdsIteTmp.FieldByName('DET_QTDITE').AsFloat, 2));
  End
  Else
    Result := False;

  If (Result) Then
    cdsIteTmp.Filter := '';
end;

function TConfirmacaoDocumentos.fChamaTelaParaConfirmacaoDosItens: Boolean;
  Var
    qryItens: TUniClientDataSet;
    dtsGenDet: TDataSource;
    frmFatMostraProdConfirmacao : TfrmFatMostraProdConfirmacao;
begin
  qryItens  := TUniClientDataSet.Create(Self);
  dtsGenDet := fCriaDataSource(qryItens);

  {*****************************************}
  {* MOSTRA ITENS DA CONFIRMAÇÃO           *}
  {**************************************MV*}
  pCloneDataSet(qryItens, cdsVenda);

  With qryItens Do
  Begin
    (FieldByName('ITE_QTDITE') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    (FieldByName('ITE_UNITAR') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
    (FieldByName('ITE_TOTITE') As TFloatField).DisplayFormat := '#,##0.00';
  End;

  If (fatVenda.blnMeiaNota) Then
    fatVenda.fltDesEsp := 0;

  If Not (fatVenda.strConfSer = 'S') Then
  Begin

    Try
      pCriarFormularios(TfrmFatMostraProdConfirmacao, frmFatMostraProdConfirmacao);
      frmFatMostraProdConfirmacao.dbgItens.DataSource := dtsGenDet;
      frmFatMostraProdConfirmacao.edtTotSer.Text      := FormatFloat('#,##0.00', fatVenda.fltTotSer);
      frmFatMostraProdConfirmacao.edtTotGer.Text      := FormatFloat('#,##0.00', fatVenda.fltTotPro);
      frmFatMostraProdConfirmacao.edtDesEsp.Text      := FormatFloat('#,##0.00', fatVenda.fltDesEsp);
      frmFatMostraProdConfirmacao.edtTotIpi.Text      := FormatFloat('#,##0.00', fatVenda.fltTotIpi);
      frmFatMostraProdConfirmacao.edtTotST.Text       := FormatFloat('#,##0.00', fatVenda.fltTotRet);
      frmFatMostraProdConfirmacao.edtValFre.Text      := FormatFloat('#,##0.00', fatVenda.fltValFre);
      frmFatMostraProdConfirmacao.edtTotLiq.Text      := FormatFloat('#,##0.00', fatVenda.fltTotPro - fatVenda.fltDesEsp +
                                                                                 fatVenda.fltTotSer + fatVenda.fltValFre +
                                                                                 fatVenda.fltTotIpi + fatVenda.fltTotRet +
                                                                                 fatVenda.fltTotCBS + fatVenda.fltTotIBS + fatVenda.fltTotIS);
      frmFatMostraProdConfirmacao.pExibirNovosImpostos(fatVenda.fltTotCBS, fatVenda.fltTotIBS, fatVenda.fltTotIS);

      frmFatMostraProdConfirmacao.blnExibeFrete := True;
      frmFatMostraProdConfirmacao.btnConfirma.Visible := True;
      frmFatMostraProdConfirmacao.Caption             := 'Itens da Confirmação de Documentos';
      frmFatMostraProdConfirmacao.showModal;

      Result := frmFatMostraProdConfirmacao.blnConfirma;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fCarregaItensConfirmacao]');
      End;
    End;

    pFreeAndNil(frmFatMostraProdConfirmacao);

  End
  Else
    Result:= True;

  FreeAndNil(qryItens);
end;

function TConfirmacaoDocumentos.fConfirmarDocumentos: Boolean;
  Var
    intContador: Integer;
    blnMudarInscricao: Boolean;
    LfrmGravando: TfrmGravando;
begin
  Result := True;

  fatVenda.blnGrvConfComFFComBol := Self.FConfTemFFComBol;

  If (fStrToFloat(FTotTrvSel) < 0.0) And (not blnEstornoNotaFiscal) Then
  Begin
    pMensagemOk('Não é possível confirmar um valor negativo!');
    Result := False;
    Exit;
  End;

  If fBloqueiaConfirmacaoOndeTodosDocumentosEstaoQuitados(fStrToFloat(FTotLiqSel)) Then
  Begin
    Result := False;
    Exit;
  End;

  If fMensagem('', IIF(blnEstornoNotaFiscal, 'Confirma o Estorno ?', 'Confirmar documento(s)?'), ['&Sim', '&Não']) = 2 Then
  Begin
    Result := False;
    Exit;
  End;

  If Assigned(pInformacoes) Then pInformacoes('Aguarde... Realizando confirmação do(s) documento(s)!');

  pDeletaDocDesmarcados;

  If blnSintetizarDevolucao Then
  Begin
    pResintetizaDevolucoes;
    pAtualizaTemporariaConfirmacao(True);
  End
  Else
    pAtualizaTemporariaConfirmacao(False);

  pGeraStringDocsConfirmados;
  pPegaPlacaAndKmVeiculo;

  fatVenda.strCliFat := FCodCli;
  fatVenda.strCodCli := FCodCli;

  fatVenda.pCarregaDadosClienteBaixa(FCodCli);

  pCarregaDadosGravadosDoCliente(FNomTab, FAutInc);

  If fCfgSis('CADFAZ', VarBoolean) And Not fEmptyStr(FCodFaz) Then
  Begin
    fatVenda.fSelecionarFazendaCliente(FCodCli, FCodFaz);
  End;

  If fCfgSis('CADEMB', VarBoolean) And Not fEmptyStr(FCodEmb) Then
  Begin
    fatVenda.strCodEmbarcacao := FCodEmb;
  End;

  fatVenda.strCodCnd := strCodigoCondicaoPagamento;
  fatVenda.strCodFpg := strCodigoFormaPagamento;
  fatVenda.strConPag := strCondicaoPagamento;
  fatVenda.strTipFre := strTipoFrete;

  If fatVenda.blnConfirmacaoDoCaixa Then
  Begin
    fatVenda.strCodTra := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODTRA').AsString;
    If (fatVenda.strCodFpg = '013') Then
      fatVenda.strCodFpg := IIF(fStatusCndPag(fatVenda.strConPag) = A_VISTA, '001', '008');
  End;

  fatVenda.pAtualizaInformacoesCondPagamento;

  If (fCfgSis('USADIG', varBoolean)) Then
  Begin
    fatVenda.strCodVen := strCodigoVendedor;
    fatVenda.strNomVen := fRetNomVendRep(strCodigoVendedor);
  End;

  If (fCfgSis('REPVEN', varBoolean)) Then
  Begin
    fatVenda.strCodVe2 := strCodigoVendedor2;
    fatVenda.strNomVe2 := fRetNomVendRep(strCodigoVendedor2);
  End;

  //Neste metodo podem ser setados informacoes como especie, cliente, condicao de pagamento etc...
  If Assigned(pPreparaDocumentoParaConfirmar) Then
    pPreparaDocumentoParaConfirmar(fatVenda);

  If (fatVenda.strEspDoc = 'D1') And fEmptyStr(fatVenda.strCodVen) Then
  Begin
    fatVenda.strCodVen := strCodigoVendedor;
    fatVenda.strNomVen := fRetNomVendRep(strCodigoVendedor);
  End;

  If (Pos(fatVenda.strEspDoc, 'NF_EL_NS_') > 0) Then
  Begin
    If Not fatVenda.fDadosCorretosParaClienteConsumidor(fatVenda.strEspDoc) Then
    Begin
      pMensagemOk('Não é permitido emitir '+fDescricaoDocFat(fatVenda.strEspDoc)+' sem preencher todos os dados do cliente.');
      Result := False;
      Exit;
    End;

    If fCfgSis('CPFOBR', varBoolean) Then
    Begin
      While (fEmptyStr(fatVenda.strCliCgc)) Do
      Begin
        pMensagemOk('Cliente não possui CPF/CNPJ. Não será permitido emitir '+fDescricaoDocFat(fatVenda.strEspDoc)+'.');

        If (Not fClienteConsumidor(fatVenda.strCliOri)) Or (Not fatVenda.fInformaCnpj) Then
        Begin
          Result := False;
          Exit;
        End;
      End;

      While Not (fValidaCnpjCpf(fatVenda.strCliCgc)) And (fatVenda.fTrocaUFEndEntrega <> 'EX') Do
      Begin
        pMensagemOk('O CPF/CNPJ do cliente não é válido para emitir '+fDescricaoDocFat(fatVenda.strEspDoc)+'.');

        If (Not fClienteConsumidor(fatVenda.strCliOri)) Or (Not fatVenda.fInformaCnpj) Then
        Begin
          Result := False;
          Exit;
        End;
      End;
    End;
  End
  Else If (Pos(fatVenda.strEspDoc, 'IF_') > 0) And (fClienteConsumidor(fatVenda.strCliOri)) Then
  Begin
    blnMudarInscricao := True;
    If (Not fEmptyStr(fatVenda.strCliCgc)) Then
    Begin
      While (Not fValidaCnpjCpf(fatVenda.strCliCgc)) And (blnMudarInscricao) Do
      Begin
        If fMensagem('ATENÇÃO!', 'O CPF/CNPJ do cliente não é válido! Deseja informar um novo número?', ['&Sim', '&Não']) = 1 Then
        Begin
          If (Not fatVenda.fInformaCnpj) Then
          Begin
            Result := False;
            Exit;
          End;
        End
        Else
          blnMudarInscricao := False;
      End;
    End;
  End;

  If fTravaEmissaoDeCupomParaEcommerce(fatVenda) Then
  Begin
    fMensagem('', 'Não é permitido emitir cupom fiscal para vendas online (e-commerce).', ['&Ok']);
    Result := False;
    Exit;
  End;

  If Not fPermiteEmitirCupomParaForaDoEstado(fatVenda) Then
  Begin
    Result := False;
    Exit;
  End;

  If Not fPermiteEmitirCupom(fatVenda) Then
  Begin
    Result := False;
    Exit;
  End;

  fatVenda.pPreencheMatrizFechamento;

  If (fatVenda.fItensObrNfe) Then
  Begin
    Result := False;
    Exit;
  End;

  If Length(fatVenda.arrMatItens) = 0 Then
  Begin
    pMensagemOk('Não há nenhum produto para realizar a confirmação! Favor verificar.');
    Result := False;
    Exit;
  End;

  fatVenda.pCalculaPesBruLiq;

  fatVenda.pCalculaTotGer(False, False);

  If fatVenda.fAplicaDescontoIcmsOrgaoPublicoNoDescontoEspecial Then
  Begin
    If (fatVenda.fltDesEsp <= 0.00) And (fatVenda.fltIcmOrg > 0) Then
      fatVenda.fltDesEsp := fatVenda.fltIcmOrg;
  End;

  fatVenda.pDestacaRetencoes;
  fatVenda.pRetemImpostosNoDescontoEspecial;

  fatVenda.pCalculaTotGer(False, False);

  If (Pos(fatVenda.strOpcDoc, 'CF_CI_') > 0) Then
  Begin
    fatVenda.fltDesEsp := 0.0;
    fatVenda.fltDupRec := 0.0;

    With fatVenda.qryTemporariaConfirmacao Do
    Begin

      First;

      fatVenda.fltDupRec := 0.0;
      fatVenda.fltDesEsp := 0.0;
      fatVenda.fltDeDVCf := 0.0;

      For intContador := 0 To Length(fatVenda.arrMatItens)-1 Do
      Begin
        If LeftStr(fatVenda.arrMatItens[intContador].strClaFis, 1) < '5' Then
        Begin
          fatVenda.fltDesEsp := fatVenda.fltDesEsp + fatVenda.arrMatItens[intContador].fltTotIte;
          fatVenda.fltDesSai := fatVenda.fltDesSai + fatVenda.arrMatItens[intContador].fltTotIte;
          fatVenda.fltDeDVCf := fatVenda.fltDeDVCf + fatVenda.arrMatItens[intContador].fltTotIte;
        End;
      End;

      While (Not Eof) Do
      Begin

        {**********************************************}
        {*         SOMA DUPLICATAS RECEBIDAS          *}
        {* QUANDO O DOC. FOI SINTETIZADO, NAO SOMA    *}
        {* A DUPREC PQ A DEVOL. NAO ESTARA MAIS       *}
        {* PRESENTE NA OPERACAO. A FF ESTA PRESENTE   *}
        {* POIS E NECESSARIO FATURALA, E ELA CARREGA  *}
        {* CONSIGO TODAS AS DEVOL. SINTETIZADAS.      *}
        {****************************************MV,JB*}
        If Not SameText(FieldByName('SAV_SINTET').AsString, 'S') Then
          fatVenda.fltDupRec := fatVenda.fltDupRec + FieldByName('TMP_DUPREC').AsFloat -
                                FieldByName('TMP_JURSUJ').AsFloat + FieldByName('TMP_DESSUJ').AsFloat;

        {*****************************************}
        {* SOMA DESCONTO ESPECIAL                *}
        {**************************************MV*}
        If (Not fatVenda.blnMeiaNota) Then
          fatVenda.fltDesEsp := fatVenda.fltDesEsp + FieldByName('TMP_DESESP').AsFloat;

        Next;
      End;

    End;

    fatVenda.fltDesEsp := fatVenda.fltDesEsp + fatVenda.fltDesSai;

  End;

  {*********************************************************************************************}
  {* NECESSARIO PARA NAO APLICAR O DESCONTO MAIS DE UMA VEZ NO PRECO UNITARIO (pCalculaTotGer) *}
  {*********************************************************************************************}
  If fatVenda.fRatearDescontoEspecialEmConfDocumentos Then
  Begin
    fatVenda.pPreencheMatrizFechamento;
  End;

  fatVenda.pAplicarFreteComoAcrescimoNFCe;

  fatVenda.pCalculaTotGer;

  fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

  If (FEstornoNotaFiscalEntregaFutura) Then
    fatVenda.strDesCla := 'ESTORNO DE SIMPLES FATURAMENTO';

  If fCfgSis('CALVOL', varBoolean) Then
  Begin
    fatVenda.intQtdTra := Floor(fatVenda.fRetVolumes);
    If fCfgSis('SEPEXC', varBoolean) Then
    Begin
      fatVenda.intQtdTraSepExc  := Floor(fatVenda.fRetVolumesSepExc);
      fatVenda.intQtdTraSepNExc := (fatVenda.intQtdTra - fatVenda.intQtdTraSepExc);
    End;
  End;

  If fatVenda.strEspDoc = 'IF' Then
  Begin
    If fatVenda.fPossuiBrindeProduto Then
    begin
      pMensagemOk('Não é permitido emitir cupom fiscal para produto de brinde.');
      Result := False;
      Exit;
    end
  end;

  If Pos(fatVenda.strEspDoc, 'NF_EL_NS_') > 0 Then
  Begin

    Try
      pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);
      frmFatDadosFiscais.fatVenda := fatVenda;
      frmFatDadosFiscais.showModal;
      Result := frmFatDadosFiscais.blnConfirma;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[btnConfirmaClick_DadosFiscais]');
      End;
    End;

    pFreeAndNil(frmFatDadosFiscais);
  End;

  If Not Result Then
    Exit;

  Repeat

  Until (fatVenda.fSolicitaDataHoraEntradaSaidaNotaFiscal);

  If blnEstornoNotaFiscal Then
    fatVenda.blnEst_Dv := True;

  fatVenda.pCalculaTotalParaCadRec;

  fDigDuplic(fatVenda.arrDuplicata,
             fTiraCaracEspeciaisParenteses(fatVenda.strConPag),
             0,
             fatVenda.fltTotCadRec,
             FAlse, False, False, VS_Date, False, fatVenda.fltImpFre, 'N', fCfgSis('DUPRED', varBoolean));

  fatVenda.pRateiaValores;

  If (fatVenda.fltTotIcm <= 0.0) Then
    fatVenda.fltAlqIcm := 0.0;

  If (fatVenda.fltTotIpi <= 0.0) Then
    fatVenda.fltAlqIpi := 0.0;

  If fCfgSis('COENRE', varBoolean) Then
    fatVenda.strEntFat := IIF(fatVenda.fTemItensEntrega, 'S', 'N');

  Try
    pCriarFormularios(TfrmGravando, LfrmGravando);
    LfrmGravando.strChave := 'FATVENDAS';
    LfrmGravando.fExecutarAcao := fatVenda.fGravaArquivos;
    LfrmGravando.ShowModal;

    Result := LfrmGravando.blnConfirma;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'');
    End;
  End;

  pFreeAndNil(LfrmGravando);

  If Result Then
    fMensagem('', fPadR(IIF(blnEstornoNotaFiscal, 'Estorno realizado com sucesso!', 'Confirmação realizada com sucesso!'), 35) + #13#10 +
                  fPadR('Documento...: ' + fatVenda.strNumDoc + '-' + fatVenda.strEspDoc, 35) + #13#10 +
                  fPadR('Data Emissão: ' + DateToStr(fatVenda.VS_Date), 35) + #13#10 +
                  fPadR('Valor Total.: ' + FormatFloat('#,##0.00', fatVenda.fltTotGer), 35), ['&Ok'], 1, False, 2);
end;

procedure TConfirmacaoDocumentos.pCarregaDadosGravadosDoCliente(strTabGer, strAutInc: String);
  Var
    strSql: String;
    qryGen: TUniQuery;
begin
  strSql := '';
  strSql := strSql + ' SELECT SQL_NO_CACHE ';
  strSql := strSql + '   GER_NOMCON, ';
  strSql := strSql + '   GER_ENDCON, ';
  strSql := strSql + '   GER_BAICON, ';
  strSql := strSql + '   GER_CEPCON, ';
  strSql := strSql + '   GER_CIDCON, ';
  strSql := strSql + '   GER_ESTCON, ';
  strSql := strSql + '   GER_TELCON, ';
  strSql := strSql + '   AUX_NASCON, ';
  strSql := strSql + '   GER_CGCCPF, ';
  strSql := strSql + '   GER_CGCCON, ';
  strSql := strSql + '   GER_IESCON, ';
  strSql := strSql + '   GER_R_GCON, ';
  strSql := strSql + '   GER_EMLCON  ';
  strSql := strSql + ' FROM ';
  strSql := strSql + '   ' + strTabGer;

  If strTabGer = 'MOVGER' Then
    strSql := strSql + '   INNER JOIN AUXMOV ON AUX_SEQGER = ' + strTabGer + '.AUTOINCREM '
  Else
    strSql := strSql + '   INNER JOIN AUXNOT ON AUX_SEQGER = ' + strTabGer + '.AUTOINCREM ';

  strSql := strSql + ' WHERE  ';
  strSql := strSql + '   AUTOINCREM = ' + QuotedStr(strAutInc);

  qryGen := fCriaQuery(Nil);

  With qryGen, SQL Do
  Begin
    Close;
    Clear;
    Add(strSql);
    Open;

    If Not IsEmpty Then
    Begin
      fatVenda.strCliNom := FieldByName('GER_NOMCON').AsString;
      fatVenda.strCliEnd := FieldByName('GER_ENDCON').AsString;
      fatVenda.strCliBai := FieldByName('GER_BAICON').AsString;
      fatVenda.strCliCep := FieldByName('GER_CEPCON').AsString;
      fatVenda.strCodCid := FieldByName('GER_CIDCON').AsString;
      fatVenda.strCliCid := fRetNomCidade(fatVenda.strCodCid);
      fatVenda.strCliEst := FieldByName('GER_ESTCON').AsString;
      fatVenda.strCliTel := FieldByName('GER_TELCON').AsString;
      fatVenda.dtaNasCon := FieldByName('AUX_NASCON').AsDateTime;
      fatVenda.intCgcCpf := FieldByName('GER_CGCCPF').AsInteger;
      fatVenda.strCliCgc := FieldByName('GER_CGCCON').AsString;
      fatVenda.strCliIes := FieldByName('GER_IESCON').AsString;
      fatVenda.strCli_Rg := FieldByName('GER_R_GCON').AsString;
      fatVenda.strCliEma := FieldByName('GER_EMLCON').AsString;
    End;

  End;

  FreeAndNil(qryGen);
end;

function TConfirmacaoDocumentos.fGetValorDuplicatasRecebidas( strNumDup,
                                                              strEspDoc,
                                                              strCodEmp: String;
                                                              fltVlrCon,
                                                              fltDupRecAnt: Double;
                                                          Var fltJurSuj,
                                                              fltDesSuj,
                                                              fltValAbe: Double ): Double;
  Var
    strSQL   : String;
    qryGenRec: TUniQuery;
    fltDupRec: Double;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  SUM(TOTPAG) AS TOTPAG ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '( ';

  strSQL := strSQL + '  SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '    SUM(IF('+fRetSQLCadRecFFComBol(' AND (CTR_DTAREC IS NULL) ')+',IFNULL(CTR_VALDUP,0), IFNULL(CTR_VALREC,0)) - IFNULL(CTR_VALJUR,0) - IFNULL(CTR_VALCOB,0) + IFNULL(CTR_VALDES,0)) AS TOTPAG ';
  strSQL := strSQL + '  FROM ';
  strSQL := strSQL + '    CADREC ';
  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '    CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '    CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '    CTR_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '    CTR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '    ((CTR_DTAREC IS NOT NULL) OR '+fRetSQLCadRecFFComBol+') ';

  strSQL := strSQL + '  UNION ALL ';

  {**********************************************}
  {* NÃO DEVE CONSIDERAR O CTR_VALDES NO SELECT *}
  {* ABAIXO, POIS O AGRUPAMENTO JÁ GERA CADREC  *}
  {* COM DESCONTO/ACRÉSCIMO                     *}
  {*REQ.224921********************************RP*}

  strSQL := strSQL + '  SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '    SUM(IFNULL(CTR_VALDUP, 0) - IFNULL(CTR_VALCOB, 0) + IFNULL(CTR_DESSUJ, 0) - IFNULL(CTR_JURSUJ, 0)) AS TOTPAG ';
  strSQL := strSQL + '  FROM ';
  strSQL := strSQL + '    DUPAGR ';
  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '    CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '    CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '    CTR_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '    CTR_CODEMP = :CODEMP ';

  strSQL := strSQL + ') AS TBL ';

  qryGenRec := fCriaQuery;

  {*****************************************}
  {* QUANTIDADE DE DUPLICATAS PAGAS        *}
  {**************************************MV*}
  qryGenRec.Close;
  qryGenRec.SQL.Clear;
  qryGenRec.SQL.Add(strSQL);
  qryGenRec.ParamByName('NUMDUP').AsString := strNumDup;
  qryGenRec.ParamByName('ESPDOC').AsString := strEspDoc;
  qryGenRec.ParamByName('CODCLI').AsString := FCodCli;
  qryGenRec.ParamByName('CODEMP').AsString := strCodEmp;
  qryGenRec.Open;

  fltDupRec := qryGenRec.FieldByName('TOTPAG').AsFloat;

  fltDupRec := fltDupRec + fltDupRecAnt;

  pRetJurosDescontoSujerido(strNumDup,
                            strEspDoc,
                            strCodEmp,
                            FCodCli,
                            fltJurSuj, fltDesSuj, fltValAbe);

//  If fltDupRec > fltVlrCon Then
//     fltDupRec := (fFormataFloat(fltVlrCon,2) - fFormataFloat(fltValAbe,2));

  Result := fltDupRec;

  qryGenRec.Close;

  FreeAndNil(qryGenRec);
end;

function TConfirmacaoDocumentos.fGetDuplicataBaixaTotal( strNumDup,
                                                         strEspDoc,
                                                         strCodEmp: String;
                                                         var blnQuitadoTotal : Boolean ): Boolean;
  Var
    qryGenRec: TUniQuery;
begin
  qryGenRec := fCriaQuery;

  {***********************************************}
  {* VERIFICA SE A DUPLICATA ESTA C\ BAIXA TOTAL *}
  {********************************************JB*}
  qryGenRec.Close;
  qryGenRec.SQL.Clear;
  qryGenRec.SQL.Add('SELECT SQL_NO_CACHE          ');
  qryGenRec.SQL.Add('  COUNT(*) AS QTD            ');
  qryGenRec.SQL.Add('FROM                         ');
  qryGenRec.SQL.Add('  CADREC                     ');
  qryGenRec.SQL.Add('WHERE                        ');
  qryGenRec.SQL.Add('  CTR_NUMDUP = :NUMDUP   AND ');
  qryGenRec.SQL.Add('  CTR_ESPDOC = :ESPDOC   AND ');
  qryGenRec.SQL.Add('  CTR_CODCLI = :CODCLI   AND ');
  qryGenRec.SQL.Add('  CTR_CODEMP = :CODEMP   AND ');
  qryGenRec.SQL.Add('  ((CTR_DTAREC IS NOT NULL) OR '+fRetSQLCadRecFFComBol(' AND (CTR_VALDUP=CTR_VALORI OR CTR_VALORI=CTR_VALREC) ')+') AND ');
  qryGenRec.SQL.Add('  CTR_SEQBAI = 0             ');

  qryGenRec.ParamByName('NUMDUP').AsString := strNumDup;
  qryGenRec.ParamByName('ESPDOC').AsString := strEspDoc;
  qryGenRec.ParamByName('CODCLI').AsString := FCodCli;
  qryGenRec.ParamByName('CODEMP').AsString := strCodEmp;
  qryGenRec.Open;

  Result := qryGenRec.FieldByName('QTD').asInteger > 0;

  blnQuitadoTotal := False;

  if Result then
  begin
    blnQuitadoTotal := fRetornaDocQuitadoTotal(qryGenRec.FieldByName('QTD').asInteger,
                                               strNumDup,
                                               strEspDoc,
                                               strCodEmp);
  end;

  qryGenRec.Close;

  FreeAndNil(qryGenRec);
end;

function TConfirmacaoDocumentos.fRetornaSeDocTemBxParcial(strNumDup,
                                                          strEspDoc,
                                                          strCodCli,
                                                          strCodEmp: String) : Boolean;
  Var
    qryGenRec: TUniQuery;
begin
  qryGenRec := fCriaQuery;

  try
    qryGenRec.Close;
    qryGenRec.SQL.Clear;
    qryGenRec.SQL.Add('SELECT SQL_NO_CACHE          ');
    qryGenRec.SQL.Add('  COUNT(*) AS QTD            ');
    qryGenRec.SQL.Add('FROM                         ');
    qryGenRec.SQL.Add('  CADREC                     ');
    qryGenRec.SQL.Add('WHERE                        ');
    qryGenRec.SQL.Add('  CTR_NUMDUP = :NUMDUP   AND ');
    qryGenRec.SQL.Add('  CTR_ESPDOC = :ESPDOC   AND ');
    qryGenRec.SQL.Add('  CTR_CODCLI = :CODCLI   AND ');
    qryGenRec.SQL.Add('  CTR_CODEMP = :CODEMP   AND ');
    qryGenRec.SQL.Add('  CTR_SEQBAI > 0             ');

    qryGenRec.ParamByName('NUMDUP').AsString := strNumDup;
    qryGenRec.ParamByName('ESPDOC').AsString := strEspDoc;
    qryGenRec.ParamByName('CODCLI').AsString := strCodCli;
    qryGenRec.ParamByName('CODEMP').AsString := strCodEmp;
    qryGenRec.Open;

    Result := qryGenRec.FieldByName('QTD').AsInteger > 0;
  finally
    FreeAndNil(qryGenRec);
  end;
end;


function TConfirmacaoDocumentos.fGetExisteDuplicataCad(strNumDup, strEspDoc,
  strCodEmp: String): Boolean;
  Var
    qryGenRec: TUniQuery;
    strSQL,
    strSQLTmp: String;
begin
  Result := False;

  strSQLTmp := '';
  strSQLTmp := strSQLTmp + ' SELECT SQL_NO_CACHE        ';
  strSQLTmp := strSQLTmp + '   COUNT(*) AS QTD          ';
  strSQLTmp := strSQLTmp + ' FROM                       ';
  strSQLTmp := strSQLTmp + '   CADREC                   ';
  strSQLTmp := strSQLTmp + ' WHERE                      ';
  strSQLTmp := strSQLTmp + '   CTR_NUMDUP = :NUMDUP AND ';
  strSQLTmp := strSQLTmp + '   CTR_ESPDOC = :ESPDOC AND ';
  strSQLTmp := strSQLTmp + '   CTR_CODCLI = :CODCLI AND ';
  strSQLTmp := strSQLTmp + '   CTR_CODEMP = :CODEMP     ';

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   SUM(QTD) AS QTD ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   (' + strSQLTmp + ') AS TAB ';

  qryGenRec := fCriaQuery;

  With qryGenRec Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('NUMDUP').AsString := strNumDup;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODCLI').AsString := FCodCli;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    If Not IsEmpty Then
      Result := FieldByName('QTD').asInteger > 0;

    Close;
  End;

  FreeAndNil(qryGenRec);
end;

function TConfirmacaoDocumentos.fValidaDVsCorrelatasMarcadas: Boolean;
  Var
    strNumDoc,
    strEspDoc,
    strCodEmp,
    strAux,
    strSQL: String;
    qryGen: TUniQuery;
    stlAux,
    stlDev: TStringList;
    intIdx: Integer;
begin
  Result := True;

  If Self.blnSintetizarDevolucao Then
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT TMP_DDEVOL AS TMP_DOCDEV, ';
    strSQL := strSQL + '        CONCAT(TMP_NUMDOC,"-",TMP_ESPDOC,"-",TMP_CODEMP) AS TMP_DOCFAT, ';
    strSQL := strSQL + '        TMP_MARDES ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + fatVenda.strTabelaConfMi;
    strSQL := strSQL + ' WHERE SAV_SINTET = "N" ';

    qryGen := fCriaQuery(Nil);
    stlDev := TStringList.Create;
    stlAux := TStringList.Create;
    Try
      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

        //LEVANTA TODOS DOC.FAT. QUE FORAM MARCADOS PARA CONFIRMAR CUJOS DOC.DEV. FORAM SINTETIZADOS;
        First;
        While Not Eof Do
        Begin
          If (FieldByName('TMP_MARDES').AsString='M') And (Not fEmptyStr(FieldByName('TMP_DOCDEV').AsString)) Then
          Begin
            stlAux.Clear;
            ExtractStrings(['/'], [], PChar(FieldByName('TMP_DOCDEV').AsString), stlAux);

            For intIdx:=0 To stlAux.Count-1 Do
            Begin
              strNumDoc := Copy(stlAux[intIdx],  1, 12);
              strEspDoc := Copy(stlAux[intIdx], 14,  2);
              strCodEmp := Copy(stlAux[intIdx], 17,  3);

              If fCampoTabela('IFNULL(SAV_SINTET, "")', fatVenda.strTabelaConfMi, ['TMP_NUMDOC', 'TMP_ESPDOC', 'TMP_CODEMP'], [strNumDoc, strEspDoc, strCodEmp]) = 'S' Then
              Begin
                If stlDev.IndexOf(stlAux[intIdx]) = -1 Then
                  stlDev.Add(stlAux[intIdx]);
              End;
            End;
          End;
          Next;
        End;

        //LEVANTA TODOS OS DOC.DEV. SINTETIZADOS EM DOC.FAT. MARCADOS PARA PARA CONFIRMAR MAS QUE TEM ITENS DE DOC.FAT. NÃO MARCADOS;
        stlAux.Clear;
        For intIdx:=0 To stlDev.Count-1 Do
        Begin
          First;
          While Not Eof Do
          Begin
             If (FieldByName('TMP_MARDES').AsString='D') And (Pos(stlDev[intIdx],FieldByName('TMP_DOCDEV').AsString) > 0) Then
               If stlAux.IndexOf(stlDev[intIdx]) = -1 Then
                 stlAux.Add(stlDev[intIdx]);
            Next;
          End;
        End;

        //DIZ AO OPERADOR TODOS OS DOCUMENTOS QUE OBRIGATORIAMENTE DEVEM SER CONFIRMADOS EM CONJUNTO;
        If (stlAux.Count>0) Then
        Begin
          Result := False;
          pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
          Try
            frmMensagemExplicativa.Caption := 'Atenção';
            frmMensagemExplicativa.mmoInstru.Font.Size := 9;
            frmMensagemExplicativa.mmoInstru.Font.Style := [];
            frmMensagemExplicativa.mmoInstru.Lines.Add('AS DEVOLUÇÕES SINTETIZADAS ABAIXO LISTADAS, SÃO REFERENTES A MAIS DE UM DOCUMENTO.');
            frmMensagemExplicativa.mmoInstru.Lines.Add('DOCUMENTOS DE FATURAMENTO NESSA SITUAÇÃO, SE CONFIRMADOS, DEVERÃO SER EM CONJUNTO!');
            frmMensagemExplicativa.mmoInstru.Lines.Add('');

            For intIdx:=0 To stlAux.Count-1 Do
            Begin
              strAux := stlAux[intIdx];
              First;
              While Not Eof Do
              Begin
                If (Pos(stlAux[intIdx],FieldByName('TMP_DOCDEV').AsString) > 0) Then
                Begin
                  frmMensagemExplicativa.mmoInstru.Lines.Add(IIF(fEmptyStr(strAux),fPadL('',21),strAux+': ')+FieldByName('TMP_DOCFAT').AsString);
                  strAux := '';
                End;
                Next;
              End;

              frmMensagemExplicativa.mmoInstru.Lines.Add('');
            End;

            frmMensagemExplicativa.ShowModal;
          Finally
            pFreeAndNil(frmMensagemExplicativa);
          End;
        End;

        Close;
      End;
    Finally
      FreeAndNil(stlDev);
      FreeAndNil(stlAux);
      FreeAndNil(qryGen);
    End;
  End;
end;

function TConfirmacaoDocumentos.fValidaValorRecebidoDocumentosSelecionados: Boolean;
  Var
    fltJurSuj,
    fltDesSuj,
    fltValAbe,
    fltDupRec: Double;
begin
  Result := True;

  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    First;
    While Not Eof Do
    Begin
      If FieldByName('TMP_MARDES').AsString = 'M' Then
      Begin
        fltDupRec := fGetValorDuplicatasRecebidas( FieldByName('TMP_NUMDOC').AsString,
                                                   FieldByName('TMP_ESPDOC').AsString,
                                                   FieldByName('TMP_CODEMP').AsString,
                                                   FieldByName('SAV_VLRCON').AsFloat,
                                                   FieldByName('TMP_REC_PD').AsFloat,
                                                   fltJurSuj,
                                                   fltDesSuj,
                                                   fltValAbe );

        Result := fFormataFloat(fltDupRec, 2) = fFormataFloat(FieldByName('SAV_DUPREC').AsFloat, 2);

        If Not Result Then
        Begin
          pMensagemOK('Documento ' + FieldByName('TMP_NUMDOC').AsString + '-' +
                                     FieldByName('TMP_ESPDOC').AsString + ' ' +
                      'com divergência no valor recebido. ' + #13#10 +
                      'Verifique se as duplicatas foram recebidas por outra estação. ' + #13#10 +
                      'É necessário carregar novamente o documento para confirmar o mesmo!');
          Break;
        End;

      End;

      Next;
    End;
    First;
  End;

end;

function TConfirmacaoDocumentos.fRetornaAutIncCadRec: String;
var strResultado: String;
begin
  Try
    fatVenda.qryTemporariaConfirmacao.First;

    While not fatVenda.qryTemporariaConfirmacao.Eof Do
    Begin
      strResultado := fCampoTabela('GROUP_CONCAT(AUTOINCREM)', 'CADREC', ['CTR_NUMDUP','CTR_ESPDOC','CTR_CODCLI','CTR_CODEMP'],
                                                                         [fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString,
                                                                          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString,
                                                                          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODCLI').AsString,
                                                                          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString], False);

      If fEmptyStr(Result) Then
        Result := strResultado
      Else
        Result := Result + ',' + strResultado;

      fatVenda.qryTemporariaConfirmacao.Next;
    End;

  Finally
    fatVenda.qryTemporariaConfirmacao.First;
  End;

end;

function TConfirmacaoDocumentos.fRetornaDocQuitadoTotal(intQtdParcBx: Integer;
                                                        strNumDup,
                                                        strEspDoc,
                                                        strCodEmp: String): Boolean;
Var
    qryGenRec: TUniQuery;
begin
  qryGenRec := fCriaQuery;

  try
    qryGenRec.Close;
    qryGenRec.SQL.Clear;
    qryGenRec.SQL.Add('SELECT SQL_NO_CACHE          ');
    qryGenRec.SQL.Add('  COUNT(*) AS QTD            ');
    qryGenRec.SQL.Add('FROM                         ');
    qryGenRec.SQL.Add('  CADREC                     ');
    qryGenRec.SQL.Add('WHERE                        ');
    qryGenRec.SQL.Add('  CTR_NUMDUP = :NUMDUP   AND ');
    qryGenRec.SQL.Add('  CTR_ESPDOC = :ESPDOC   AND ');
    qryGenRec.SQL.Add('  CTR_CODCLI = :CODCLI   AND ');
    qryGenRec.SQL.Add('  CTR_CODEMP = :CODEMP   AND ');
    qryGenRec.SQL.Add('  CTR_SEQBAI = 0             ');

    qryGenRec.ParamByName('NUMDUP').AsString := strNumDup;
    qryGenRec.ParamByName('ESPDOC').AsString := strEspDoc;
    qryGenRec.ParamByName('CODCLI').AsString := FCodCli;
    qryGenRec.ParamByName('CODEMP').AsString := strCodEmp;
    qryGenRec.Open;

    Result := intQtdParcBx = qryGenRec.FieldByName('QTD').asInteger;
  finally
    FreeAndNil(qryGenRec);
  end;

end;

function TConfirmacaoDocumentos.fVerificaDocumentosDigitalizados: Boolean;
var
  objLiberacao: TLiberacao;
  strDocumentos: String;
  intContador: Integer;
  lstDocumentos: TStringList;
begin
  Result := True;

  If not fCfgSis('MOVDIG', varBoolean) Then
    Exit;

  lstDocumentos := TStringList.Create;
  try

    qryConfirmacao.DisableControls;
    try
      strDocumentos := '';
      intContador := 0;

      qryConfirmacao.First;
      while not qryConfirmacao.Eof do
      begin
        if qryConfirmacao.FieldByName('TMP_MARDES').AsString = 'M' then
        begin
          if (not TDigitalizacaoDocumentos.fDocDigitalizado(qryConfirmacao.FieldByName('TMP_AUTINC').AsString)) then
          begin
            strDocumentos := strDocumentos +
                             qryConfirmacao.FieldByName('TMP_NUMDOC').AsString +
                             '-' +
                             qryConfirmacao.FieldByName('TMP_ESPDOC').AsString +
                             '-' +
                             qryConfirmacao.FieldByName('TMP_CODEMP').AsString +
                             ', ';
            Inc(intContador);

            if (intContador = 6) then
            begin
              intContador := 0;
              lstDocumentos.Add(strDocumentos);
              strDocumentos := '';
            end;
          end;

        end;

        qryConfirmacao.Next;
      end;
    finally
      qryConfirmacao.EnableControls;
    end;

    if not fEmptyStr(strDocumentos) then
    begin
      Delete(strDocumentos, Length(strDocumentos)-1, 2);
      lstDocumentos.Add(strDocumentos);
      strDocumentos := '';
    end;

    if lstDocumentos.Count = 0 then
      Exit;

    objLiberacao := TLiberacao.Create;
    try
      objLiberacao.objMsgLibera.pAddSeparador;
      objLiberacao.objMsgLibera.pAddTexto('Permitir confirmar documentos que não estão digitalizados');
      objLiberacao.objMsgLibera.pAddTexto('Documentos:');
      for intContador := 0 to Pred(lstDocumentos.Count) do
        objLiberacao.objMsgLibera.pAddTexto(lstDocumentos[intContador]);

      objLiberacao.objMsgLibera.pAddSeparador;

      objLiberacao.strDirAce := 'MOVDIG';
      objLiberacao.strMsgSen := 'Permitir confirmar documentos que não estão digitalizados';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;

      Result := objLiberacao.fLibera;
    finally
      FreeAndNil(objLiberacao);
    end;
  finally
    FreeAndNil(lstDocumentos);
  end;
end;

function TConfirmacaoDocumentos.fVerificaDocumentosFinanceiroAberto: Boolean;
  var
    objLiberacao: TLiberacao;
    intContador: Integer;
    lstDocumentos: TStringList;
Begin
  Result := True;

  If Not fCfgSis('LIFIAB', varBoolean) Then
    Exit;

  lstDocumentos := TStringList.Create;
  Try

    qryConfirmacao.DisableControls;
    Try
      lstDocumentos.Text := '';

      qryConfirmacao.First;
      While Not qryConfirmacao.Eof Do
      Begin
        If (qryConfirmacao.FieldByName('TMP_MARDES').AsString = 'M') Then
        Begin
          If (fFormataFloat(qryConfirmacao.FieldByName('TMP_DUPREC').AsFloat, 2) = 0) Then
          Begin
            lstDocumentos.Add(qryConfirmacao.FieldByName('TMP_NUMDOC').AsString +
                              '-' +
                              qryConfirmacao.FieldByName('TMP_ESPDOC').AsString +
                              '-' +
                              qryConfirmacao.FieldByName('TMP_CODEMP').AsString);

          End;

        End;

        qryConfirmacao.Next;
      End;
    Finally
      qryConfirmacao.EnableControls;
    End;

    If lstDocumentos.Count = 0 Then
      Exit;

    objLiberacao := TLiberacao.Create;
    Try
      objLiberacao.objMsgLibera.pAddSeparador;
      objLiberacao.objMsgLibera.pAddTexto('Confirmação de documentos que possuem financeiro em aberto');
      objLiberacao.objMsgLibera.pAddTexto('Documentos:');
      For intContador := 0 To Pred(lstDocumentos.Count) Do
        objLiberacao.objMsgLibera.pAddTexto(lstDocumentos[intContador]);

      objLiberacao.objMsgLibera.pAddSeparador;

      objLiberacao.strDirAce := 'LIFIAB';
      objLiberacao.strMsgSen := 'Permitir confirmar documento que possuem financeiro em aberto';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;

      Result := objLiberacao.fLibera;
    Finally
      FreeAndNil(objLiberacao);
    End;
  Finally
    FreeAndNil(lstDocumentos);
  End;
End;



end.
