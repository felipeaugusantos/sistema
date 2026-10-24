unit untFuncoesDiarias;

interface

Uses
  Classes, SysUtils, Uni, StrUtils, Controls, untTypesSistema,
  untFuncFat, Forms, cxProgressBar, untMsgInterna, DateUtils, System.Generics.Collections,
  Dialogs, Windows, IOUtils, UITypes, untCadIBPT, untAuditoriaGravacaoSaldo;

Type
  TMotivoTransferenciaCliente = Record
    ClienteNaoCompra_X_Dias           : Boolean;
    ClienteNaoTemOcorrenciaCRM_X_Dias : Boolean;
  end;

Type
  TPrecoPraticadoParaTinta = (tpValTinConformeNotaFinalEmitida, tpValTinConformeCadastroEmpresa);

Type
  TDadosClienteFilial = class(TObject)
    strCliNom: String;
    strCliEnd: String;
    strCliBai: String;
    strCliCep: String;
    strCliCid: String;
    strCliEst: String;
    strCliTel: String;
    intCgcCpf: Integer;
    strCliCgc: String;
    strCliIes: String;
  End;

Type
  TControleEntrega = class(TComponent)
    private
      FAutIncEnt: String;
      FVendaNF: TFatVenda;
      FblnAbastecimentoDeposito: Boolean;
      FAbastecimentoDeposito: Boolean;
      FRegimeEspecialPorProdutoComFaturamentoDuplo: Boolean;
      FRegimeEspecialPorEmpresaComFaturamentoDuplo: Boolean;
      FblnDevRegimeEspecial: Boolean;
      FblnAbastecimentoDepositoOperacaoVN: Boolean;
      FEspDocOri: String;
      FEhDevolucaoAbastecimentoDeposito: Boolean;
      FEmpresaAbastecimentoOutrasSaidas: String;

      objAuditoriaSaldo: IAuditoriaGravacaoSaldo;

      function fPrecoCustoTE():Boolean;

      function fProcessaEntGerMatrizPrg(pgbProgresso: TcxProgressBar): Boolean;
      function fProcessaEntGerMatrizNFPrg(pgbProgresso: TcxProgressBar): Boolean;

      function fTransferenciaParaEmpresaFaturamentoPedido: Boolean;
      procedure fAlimentaDadosEntGerMatrizNF;

      procedure pOperacaoEspelho(const blnEntrada: Boolean);

      function fGeraEntradaMercadoriasPrg(pgbProgresso: TcxProgressBar): Boolean;
      function fGeraEntradaMercadoriasNFPrg(pgbProgresso: TcxProgressBar): Boolean;

      function fRetDadosCliente(strCodCli: String; blnFornecedor: Boolean = False): TDadosClienteFilial;
      procedure pCopiaFatVenda(const Origem, Destino: TFatVenda);

      function fGravaDados: Boolean;
      procedure pAjustaItensAbastecimentoDeposito;
      procedure pAplicaPrecoCusto;
      procedure pAjustaDadosFiscais(const blnEntrada: Boolean);
      function fDefineEspecieDeDocumentoEntradaDeMercadoria: String;
      procedure pSetaMensagemDeCancelamento;
      function fCampoCadIte(Const strCampo, strCodIte: String): Variant;
      function fCampoIteGer(Const strCampo, strCodIte: String; Const strCodEmp: String = ''): Variant;
      function fRotinasFaturamentoDuplo: Boolean;
      function fAtualizaUltimaCompraPrecoMedio: Boolean;
      function fRetornaClassificacaoFiscal(Const strCodEmp, strCodFor, strCodFis: String; Const blnComLub: Boolean): String;
    protected
      FVenda: TFatVenda;

    public

      function fProcessaEntGerMatriz(strAutIncEnt: String = ''; strMensagem: String = ''; blnAbastecimentoDeposito: Boolean = False): Boolean;
      function fProcessaEntGerMatrizNF(const strAutIncEnt: String; blnAbastecimentoDeposito: Boolean = False): Boolean;

      function fGeraEntradaMercadorias(strAutIncEnt: String = ''; strMensagem: String = ''; blnAbastecimentoDeposito: Boolean = False): Boolean;
      function fGeraEntradaMercadoriasNF(const strAutIncEnt: String; blnAbastecimentoDeposito: Boolean = False; strEspDocOri: String = ''): Boolean;

      procedure pVerificaEntregas(blnLoopTravamento: Boolean = False);

      Constructor Create(Owner: TComponent); override;

      Destructor Destroy; override;

      property fatVenda: TFatVenda Read FVenda Write FVenda;
      property fatVendaNF: TFatVenda Read FVendaNF Write FVendaNF;
      property blnAbastecimentoDeposito: Boolean read FblnAbastecimentoDeposito Write FblnAbastecimentoDeposito;
      property blnRegimeEspecialPorProdutoComFaturamentoDuplo: Boolean read FRegimeEspecialPorProdutoComFaturamentoDuplo write FRegimeEspecialPorProdutoComFaturamentoDuplo;
      property blnRegimeEspecialPorEmpresaComFaturamentoDuplo: Boolean read FRegimeEspecialPorEmpresaComFaturamentoDuplo write FRegimeEspecialPorEmpresaComFaturamentoDuplo;
      property blnDevRegimeEspecial: Boolean read FblnDevRegimeEspecial Write FblnDevRegimeEspecial;
      property blnEhDevolucaoAbastecimentoDeposito: Boolean read FEhDevolucaoAbastecimentoDeposito write FEhDevolucaoAbastecimentoDeposito;
      property strEmpresaAbastecimentoOutrasSaidas: String read FEmpresaAbastecimentoOutrasSaidas write FEmpresaAbastecimentoOutrasSaidas;
  End;

  TFuncoesDiarias = Class(TComponent)
    private
      class function fInsereCadRecOS(strSeqEqu, strCodCli, strHistorico: String; fltTxaVal: Double): Boolean;

      Class Function fTransfereClienteVendedorCarteiraEmpresa(strVenRep    : String;
                                                              pgbProgresso : TcxProgressBar): Boolean;
      Class Function fTransfereClienteVen_Rep_CarteiraEmpresa(pgbProgresso : TcxProgressBar): Boolean;

      Class Procedure pGeraLogCliente(ACodCli,
                                      ACampoAlt,
                                      AInforAntC,
                                      AInforNovC : String);

    class procedure pMontaMensagemDeMediaDeAtraso(var stlMensagem: TStringList); static;

    protected

    public
      Class function fDeleteSqlErr(pgbProgresso: TcxProgressBar): Boolean;
      class function fDeletarLogsTxtAntigos(pgbProgresso: TcxProgressBar): Boolean;
      Class function fDeleteLogRef(pgbProgresso: TcxProgressBar): Boolean;
      Class function fDeleteLogRdZ(pgbProgresso: TcxProgressBar): Boolean;
      Class function fDeleteLogLck(pgbProgresso: TcxProgressBar): Boolean;
      Class function fDeleteFrmRep(pgbProgresso: TcxProgressBar): Boolean;
      Class function fDeleteCadMsg(pgbProgresso: TcxProgressBar): Boolean;
      Class function fDeleteLogCadCar(pgbProgresso: TcxProgressBar): Boolean;
      Class function fDeleteBloDen(pgbProgresso: TcxProgressBar): Boolean;
      Class function fDeleteLogLogTef(pgbProgresso: TcxProgressBar): Boolean;
      Class function fDeleteLogLogErrPinPad(pgbProgresso: TcxProgressBar): Boolean;
      Class function fDeleteApp_CadMsg(pgbProgresso: TcxProgressBar): Boolean;
      Class function fDeleteLogVar(pgbProgresso: TcxProgressBar): Boolean;
      Class function fDeleteMnuAce(pgbProgresso: TcxProgressBar): Boolean;
      Class function fDeleteLogFrm(pgbProgresso: TcxProgressBar): Boolean;
      Class function fDeleteLogThr(pgbProgresso: TcxProgressBar): Boolean;
      Class function fDeleteLogTmr(pgbProgresso: TcxProgressBar): Boolean;
      Class function fZeraLimteCredito(pgbProgresso: TcxProgressBar): Boolean;
      Class function fInativaClientePorTempoUltimaCompra(pgbProgresso: TcxProgressBar): Boolean;
      Class function fInativaClienteSemNenhumaCompra(pgbProgresso: TcxProgressBar): Boolean;
      Class Function fGeraInventarioEstoque2(pgbProgresso: TcxProgressBar): Boolean;
      Class Function fTransfereClienteVendedorCarteiraEmpresaVen(pgbProgresso: TcxProgressBar): Boolean;
      Class Function fTransfereClienteVendedorCarteiraEmpresaRep(pgbProgresso: TcxProgressBar): Boolean;
      Class Function fTransfereClienteVen_Rep_CarteiraEmpresaCRM(pgbProgresso: TcxProgressBar): Boolean;

      class function fAtualizarDataProximoEnvioGatilhosInformacao(pgbProgresso: TcxProgressBar): Boolean;
      class function fApagarNfeTempo(pgbProgresso: TcxProgressBar): Boolean;
      class function fAtualizaTipoPrecoTransferenciaCONEMP(pgbProgresso: TcxProgressBar): Boolean;
      class function fVerificarNovasConfiguracoes(pgbProgresso: TcxProgressBar): Boolean;
      class function fInsertTEPREV(pgbProgresso: TcxProgressBar): Boolean;
      class function fInsertTEPPRO(pgbProgresso: TcxProgressBar): Boolean;
      class function fInsertCFGPAT(pgbProgresso: TcxProgressBar): Boolean;
      class function fInsertCFGAUX(pgbProgresso: TcxProgressBar): Boolean;
      Class function fDeleteImagensEmailSemUso(pgbProgresso: TcxProgressBar): Boolean;
      Class function fRemoverVendedoresTemporariosClientes(pgbProgresso: TcxProgressBar): Boolean;
      class function fApagaPDFDireto(pgbProgresso: TcxProgressBar): Boolean;
      class function fMensagenEfetivacaoMovimentoFiscal(pgbProgresso: TcxProgressBar): Boolean;
      class function fMensagemContratoLocacaoAVencer(pgbProgresso: TcxProgressBar): Boolean;
      class function fGerarTaxaArmazenamentoOS(pgbProgresso: TcxProgressBar): Boolean;
      class function fMensagemMediaDeAtrasoClientes(pgbProgresso: TcxProgressBar): Boolean;
      class function fMensagemCertificadoDigital(pgbProgresso: TcxProgressBar): Boolean;
  End;

  procedure pGeraTransferencias;
  procedure pGeraRequisicoesCompra;
  Procedure pMontaInventarioFisico;
  Procedure pFuncoesDiarias(blnAutoGiro: Boolean = False);
  Function  fTransferenciaDoClienteParaCarteiraEmpresa : TMotivoTransferenciaCliente;
  procedure RemoverLckAtcMonitorExtratoCobranca;
  procedure pVerificaExpiracaoSenhasOperadores;

implementation

uses untMovGer, untCadIte, untCadClientes, untPreparaGeracaoTE, untThreadUtils,
     untFuncoesSimples, untFuncoes,untGravando, untGeraInventarioFin, untFatGor,
     Data.DB,untNetpoints, untConstantes, untTrocaVendedorTemp, untCfgRepositorio,
     untTPreparaRequisicaoCompra, untFuncFatTypes, untLibNfe,
     untDateTimeFromAPI, untPcmGer, untCalculoUltimaCompraImpostos, untCadRec,
     untGatilhosInformacao, untLogAltCadCli, untCertificadoDigitalAvisos;

{ TControleEntrega }

Constructor TControleEntrega.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  fatVenda := TFatVenda.CreateInstance('VN', False);
  fatVenda.strOpcDocTrue := 'FD';
  fatVenda.blnGravaMovDet2_3 := False;
  FAutIncEnt := '';
  FEspDocOri := '';
  FRegimeEspecialPorProdutoComFaturamentoDuplo := False;
  FRegimeEspecialPorEmpresaComFaturamentoDuplo := False;
  FblnDevRegimeEspecial := False;
  FblnAbastecimentoDepositoOperacaoVN := False;

  objAuditoriaSaldo := TAuditoriaGravacaoSaldo.New;
end;

Destructor TControleEntrega.Destroy;
Begin
  inherited;
  FreeAndNil(FVenda);
End;


function TControleEntrega.fGeraEntradaMercadorias(strAutIncEnt: String = '';
  strMensagem: String = ''; blnAbastecimentoDeposito: Boolean = False): Boolean;
var
  frmGravando: TfrmGravando;
Begin
  If strMensagem = '' Then
    strMensagem := 'Aguarde, processando Entrada de Mercadorias - Controle de Entrega...';
  FAutIncEnt := strAutIncEnt;
  FAbastecimentoDeposito := blnAbastecimentoDeposito;
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := strMensagem;
    frmGravando.fExecutarAcao := fGeraEntradaMercadoriasPrg;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;
  Finally
    pFreeAndNil(frmGravando);
  End;
End;

function TControleEntrega.fGeraEntradaMercadoriasNF(const strAutIncEnt: String; blnAbastecimentoDeposito: Boolean = False; strEspDocOri: String = ''): Boolean;
var
  frmGravando: TfrmGravando;
begin
  FAutIncEnt := strAutIncEnt;
  FAbastecimentoDeposito := blnAbastecimentoDeposito;
  FEspDocOri := strEspDocOri;

  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := 'Aguarde, processando Entrada de Mercadorias - Controle de Entrega...';
    frmGravando.fExecutarAcao := fGeraEntradaMercadoriasNFPrg;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TControleEntrega.pOperacaoEspelho(const blnEntrada: Boolean);
  Var
    strOpcDocEspelhoAux: String;
    intContador: Integer;
begin
  strOpcDocEspelhoAux := '';
  If (Not Assigned(fatVenda.objItensNotaEspelho)) Then
    fatVenda.objItensNotaEspelho := TItensNotaEspelho.Create(fatVenda)
  Else
    strOpcDocEspelhoAux := fatVenda.objItensNotaEspelho.strOpcDoc;

  fatVenda.objItensNotaEspelho.strOpcDoc := 'FD';

  pAjustaDadosFiscais(blnEntrada);

  fatVenda.fltTotMed := 0;
  fatVenda.fltTotPro := 0;
  fatVenda.fltTotGer := 0;
  fatVenda.fltDesEsp := 0;
  fatVenda.fltValFre := 0;

  for intContador := Low(fatVenda.arrMatItens) to High(fatVenda.arrMatItens) do
  begin
    fatVenda.fltTotPro := fatVenda.fltTotPro + fatVenda.arrMatItens[intContador].fltTotIte;
    fatVenda.fltTotMed := fatVenda.fltTotMed + fatVenda.arrMatItens[intContador].fltTotMed;
    fatVenda.fltValFre := fatVenda.fltValFre + fatVenda.arrMatItens[intContador].fltValFre;
    fatVenda.fltDesEsp := fatVenda.fltDesEsp + fatVenda.arrMatItens[intContador].fltDesEsp;

    fatVenda.arrMatItens[intContador].fltVlrCon := fatVenda.arrMatItens[intContador].fltTotIte -
                                                   fatVenda.arrMatItens[intContador].fltDesEsp +
                                                   fatVenda.arrMatItens[intContador].fltValFre +
                                                   fatVenda.arrMatItens[intContador].fltDesAce +
                                                   fatVenda.arrMatItens[intContador].fltValIpi +
                                                   fatVenda.arrMatItens[intContador].fltVaERet +
                                                   IIF((fatVenda.arrMatItens[intContador].fltValRet > 0), fatVenda.arrMatItens[intContador].recDifalFCP.fltValFcp, 0) +
                                                   fatVenda.arrMatItens[intContador].fltValRet +
                                                   fatVenda.arrMatItens[intContador].fltValCBS +
                                                   fatVenda.arrMatItens[intContador].fltValIBS +
                                                   fatVenda.arrMatItens[intContador].fltVal_IS;
    fatVenda.fltTotGer := fatVenda.fltTotGer + fatVenda.arrMatItens[intContador].fltVlrCon;
  end;
  fatVenda.fltTotGer := fFormataFloat(fatVenda.fltTotGer, 2);
  fatVenda.fltDesEsp := fFormataFloat(fatVenda.fltDesEsp, 2);
  fatVenda.fltValFre := fFormataFloat(fatVenda.fltValFre, 2);

  If (Not strOpcDocEspelhoAux.IsEmpty) Then
    fatVenda.objItensNotaEspelho.strOpcDoc := strOpcDocEspelhoAux
  Else
    FreeAndNil(fatVenda.objItensNotaEspelho);
end;

function TControleEntrega.fGeraEntradaMercadoriasNFPrg(
  pgbProgresso: TcxProgressBar): Boolean;
var
  blnInTransaction: Boolean;
  blnOperacaoEspelho: Boolean;
  strNumDoc: String;
  strSQL: String;
  qryDetAux: TUniQuery;
  qryGenGer: TUniQuery;
  qryGenGe2: TUniQuery;
  intContador: Integer;
  dcfDadosCliente: TDadosClienteFilial;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ENTGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP ';
    strSQL := strSQL + '  AND ENTGER.AUTOINCREM = ' + FAutIncEnt.QuotedString;

    qryGenGer := fCriaQuery;
    try
      qryGenGer.Close;
      qryGenGer.SQL.Clear;
      qryGenGer.SQL.Add(strSQL);
      qryGenGer.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGenGer.Open;

      blnInTransaction := fInTransaction;

      If Not blnInTransaction Then
        fStartTransaction;

      strNumDoc := Copy(qryGenGer.FieldByName('GER_DCTEMT').AsString, 01, 12);
      {*******************************************}
      {* CARREGA DADOS GERAIS                    *}
      {****************************************MV*}

      pCopiaFatVenda(FVendaNF, fatVenda);

      fatVenda.strNumDoc := strNumDoc;

      // Alimento dos dados como se fosse a nota de saída para gerar os dados fiscais
      fAlimentaDadosEntGerMatrizNF;

      FblnAbastecimentoDepositoOperacaoVN := (blnAbastecimentoDeposito) And (Pos(FVendaNF.strOpcDoc, 'VN_CP_') > 0);

      fatVenda.strEmpresaAbastecimentoOutrasSaidas := FEmpresaAbastecimentoOutrasSaidas;

      if blnAbastecimentoDeposito then
      begin
        If (FblnAbastecimentoDepositoOperacaoVN) Then
        Begin
          fatVenda.blnGravaIncPedFuncoesDiarias := True;
          fatVenda.blnGravaValRetCmpProFuncoesDiarias := True;
        End;
        fatVenda.strNumDocAbastecimento := FVendaNF.strNumDoc;
        fatVenda.strEspDocAbastecimento := FVendaNF.strEspDoc;
        fatVenda.strCodEmpAbastecimento := FVendaNF.strEmpOriPed;
        fatVenda.strCodCliAbastecimento := FVendaNF.strCodCli;

        If (blnEhDevolucaoAbastecimentoDeposito) Then
        Begin
          fatVenda.strTEPREV := fGetTEPREV(FVendaNF.strEmpDoc, fatVenda.strCodCli);
          fatVenda.strCodEmpAbastecimento := FVendaNF.strEmpDoc;
        End;
      end;

      If (Self.blnRegimeEspecialPorProdutoComFaturamentoDuplo Or Self.blnDevRegimeEspecial) Then
      begin
        If (Not Self.blnDevRegimeEspecial) Then
          fatVenda.blnGravaIncPedFuncoesDiarias := True;
        fatVenda.blnGravaValRetCmpProFuncoesDiarias := True;
        fatVenda.strNumDocRegimeEspecialPorProduto := FVendaNF.strNumDoc;
        fatVenda.strEspDocRegimeEspecialPorProduto := FVendaNF.strEspDoc;
        fatVenda.strCodEmpRegimeEspecialPorProduto := FVendaNF.strEmpDoc;
        fatVenda.strCodCliRegimeEspecialPorProduto := FVendaNF.strCodCli;
      end;

      If blnRegimeEspecialPorEmpresaComFaturamentoDuplo Then
      begin
        fatVenda.strNumDocRegimeEspecialPorEmpresa := FVendaNF.strNumDoc;
        fatVenda.strEspDocRegimeEspecialPorEmpresa := FVendaNF.strEspDoc;
        fatVenda.strCodEmpRegimeEspecialPorEmpresa := FVendaNF.strEmpOriPed;
        fatVenda.strCodCliRegimeEspecialPorEmpresa := FVendaNF.strCodCli;
      end;

      if not fMantemLoteInformadoEmCasoDeAbastecimentoDeposito(blnAbastecimentoDeposito) then
      begin
        for intContador := Low(fatVenda.arrMatItens) to High(fatVenda.arrMatItens) do
        begin
          if fAjustaLoteAbastecimentoDeposito(blnEhDevolucaoAbastecimentoDeposito) then
            fatVenda.arrMatItens[intContador].strNumLot := IfEmptyStr(fatVenda.arrMatItens[intContador].strNumLot, 'A DEFINIR')
          else
            fatVenda.arrMatItens[intContador].strNumLot := EmptyStr;
        end;
      end;

      If FblnDevRegimeEspecial Then
      Begin
        fatVenda.blnDevRegimeEspecial := True;
        If fEmptyStr(qryGenGer.FieldByName('GER_EMPFOR').AsString) Then
          fatVenda.strEmpOriTransfDevRegimeEspecial := fCfgSis('EMPMAT')
        Else
          fatVenda.strEmpOriTransfDevRegimeEspecial := qryGenGer.FieldByName('GER_EMPFOR').AsString;
      End;

      if fPrecoCustoTE then
        pAplicaPrecoCusto;

      blnOperacaoEspelho := False;
      If (Self.blnRegimeEspecialPorProdutoComFaturamentoDuplo Or FblnAbastecimentoDepositoOperacaoVN Or Self.blnDevRegimeEspecial) And (fatVenda.strEspDoc = 'NF') Then
      Begin
        qryDetAux := fCriaQuery;
        Try
          qryDetAux.SQL.Clear;
          qryDetAux.SQL.Add('SELECT D.AUTOINCREM, D.DET_SERIE_ FROM MOVDET D');
          qryDetAux.SQL.Add('       INNER JOIN MOVTRI T ON D.AUTOINCREM = T.DET_SEQGER');
          qryDetAux.SQL.Add('       INNER JOIN MOVAUX M ON D.AUTOINCREM = M.DET_SEQGER');
          qryDetAux.SQL.Add('       INNER JOIN AUXMOV A ON A.AUX_SEQGER = D.DET_SEQGER');
          qryDetAux.SQL.Add('       INNER JOIN CADEMP E ON E.EMP_CLIFIL = D.DET_CODCLI');
          qryDetAux.SQL.Add(' WHERE A.AUX_DOC_RE = :NUMDOC');
          qryDetAux.SQL.Add('   AND A.AUX_ESP_RE = :ESPDOC');
          qryDetAux.SQL.Add('   AND A.AUX_EMP_RE = :CODEMP');

          If Self.blnDevRegimeEspecial Then
            qryDetAux.SQL.Add(' AND T.DET_INCDEV = :AUTINC')
          Else
            qryDetAux.SQL.Add(' AND M.DET_INC_PD = :AUTINC');

          If FblnAbastecimentoDepositoOperacaoVN Then
            qryDetAux.SQL.Text := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(qryDetAux.SQL.Text, 'AUX_DOC_RE', 'AUX_DOCABA'), 'AUX_ESP_RE', 'AUX_ESPABA'), 'AUX_EMP_RE', 'AUX_EMPABA');

          For intContador := Low(fatVenda.arrMatItens) To High(fatVenda.arrMatItens) Do
          Begin
            qryDetAux.Close;
            qryDetAux.ParamByName('NUMDOC').AsString := FVendaNF.strNumDoc;
            qryDetAux.ParamByName('ESPDOC').AsString := FVendaNF.strEspDoc;
            qryDetAux.ParamByName('CODEMP').AsString := FVendaNF.strEmpDoc;
            If Self.blnDevRegimeEspecial Then
              qryDetAux.ParamByName('AUTINC').AsString := fatVenda.arrMatItens[intContador].strAiDvOr
            Else
              qryDetAux.ParamByName('AUTINC').AsString := fatVenda.arrMatItens[intContador].strSeqDet;
            qryDetAux.Open;

            If (Not qryDetAux.IsEmpty) Then
            Begin
              blnOperacaoEspelho := True;

              If (fatVenda.strSerFsc <> qryDetAux.FieldByName('DET_SERIE_').AsString) Then
                fatVenda.strSerFsc := qryDetAux.FieldByName('DET_SERIE_').AsString;

              fatVenda.arrMatItens[intContador].strIncEsp := qryDetAux.FieldByName('AUTOINCREM').AsString;
            End;
          End;
        Finally
          FreeAndNil(qryDetAux);
        End;
      End;

      If fEmptyStr(qryGenGer.FieldByName('GER_EMPFOR').AsString) Then
        fatVenda.strCodCli := fRetCodForFilial(fCfgSis('EMPMAT'))
      Else
        fatVenda.strCodCli := fRetCodForFilial(qryGenGer.FieldByName('GER_EMPFOR').AsString);

      If blnOperacaoEspelho Then
        pOperacaoEspelho(True)
      Else
        pAjustaDadosFiscais(True);

      If (FAbastecimentoDeposito) And (not fEmptyStr(fCfgSis('CFOPTR'))) And (not fEmptyStr(fatVenda.strClaFis)) Then
      Begin
        fatVenda.strClaFis := fatVenda.strClaFis[1] + fCfgSis('CFOPTR');

        for intContador := Low(fatVenda.arrMatItens) to High(fatVenda.arrMatItens) do
        begin
          if not fEmptyStr(fatVenda.arrMatItens[intContador].strClaFis) then
            fatVenda.arrMatItens[intContador].strClaFis := fatVenda.arrMatItens[intContador].strClaFis[1] + fCfgSis('CFOPTR');
        end;
      End;

      If FAbastecimentoDeposito Then
      Begin
        for intContador := Low(fatVenda.arrMatItens) to High(fatVenda.arrMatItens) do
        begin
          fatVenda.blnAbastecimentoDepositoComTintaEntrada := (fatVenda.arrMatItens[intContador].strIdePro <> 'NOR');

          If fatVenda.blnAbastecimentoDepositoComTintaEntrada Then
            Break;
        end;
      End;

      // Após gerar os dados fiscais troco os valores reais
      fatVenda.strEspDoc := fDefineEspecieDeDocumentoEntradaDeMercadoria;
      If blnRegimeEspecialPorEmpresaComFaturamentoDuplo Then
        fatVenda.strEspDoc := 'PD';

      fatVenda.strOpcDoc := 'EF';
      fatVenda.blnCliFil := True;
      fatVenda.strCliCon := 'N';
      fatVenda.blnGerNFE := fatVenda.strEspDoc = 'NF';
      fatVenda.blnAbastecimentoDeposito := FblnAbastecimentoDeposito;
      fatVenda.blnEhDevolucaoAbastecimentoDeposito := FEhDevolucaoAbastecimentoDeposito;
      fatVenda.blnRegimeEspecialPorEmpresaComFaturamentoDuplo := FRegimeEspecialPorEmpresaComFaturamentoDuplo;
      fatVenda.blnRegimeEspecialPorProdutoComFaturamentoDuplo := FRegimeEspecialPorProdutoComFaturamentoDuplo;

      dcfDadosCliente := fRetDadosCliente(fatVenda.strCodCli, True);
      If dcfDadosCliente <> Nil Then
      Begin
        fatVenda.strCliNom := dcfDadosCliente.strCliNom;
        fatVenda.strCliEnd := dcfDadosCliente.strCliEnd;
        fatVenda.strCliBai := dcfDadosCliente.strCliBai;
        fatVenda.strCliCep := dcfDadosCliente.strCliCep;
        fatVenda.strCliCid := dcfDadosCliente.strCliCid;

        If (Not fEmptyStr(dcfDadosCliente.strCliEst)) Then
          fatVenda.strCliEst := dcfDadosCliente.strCliEst;

        fatVenda.strCliTel := dcfDadosCliente.strCliTel;
        fatVenda.intCgcCpf := dcfDadosCliente.intCgcCpf;
        fatVenda.strCliCgc := dcfDadosCliente.strCliCgc;
        fatVenda.strCliIes := dcfDadosCliente.strCliIes;

        FreeAndNil(dcfDadosCliente);
      End;

      fatVenda.strTipFre := '2';
      fatVenda.strMen001 := 'REFERENTE A ENTREGA ' + qryGenGer.FieldByName('GER_NUMDOC').AsString + '-' + qryGenGer.FieldByName('GER_ESPDOC').AsString;
    finally
      FreeAndNil(qryGenGer);
    end;

    If (FAbastecimentoDeposito) And (Length(fatVenda.strClaFis) < 4) Then
    Begin
      fMensagem('Atenção','Não será possível finalizar o processo, verifique as Classificações Fiscais de Transferência do Cadastro da Empresa', ['&OK']);
      Result := False;
      Exit;
    End;

    Result := fGravaDados;

    If Result Then
      Result := fAtualizaUltimaCompraPrecoMedio;

    If Result and (Not fEmptyStr(FAutIncEnt)) Then
    Begin

      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  ENTGER ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  GER_DTTEFL = ' + fCurrentDate + ', ';
      strSQL := strSQL + '  GER_HOTEFL = ' + fCurrentTime + ', ';
      strSQL := strSQL + '  GER_DOCEFL = :NUMDOC ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  AUTOINCREM = ' + FAutIncEnt;

      qryGenGe2 := fCriaQuery;
      try
        qryGenGe2.Close;
        qryGenGe2.SQL.Clear;
        qryGenGe2.SQL.Add(strSQL);
        qryGenGe2.ParamByName('NUMDOC').AsString := fatVenda.strNumDoc + '-' + fatVenda.strEspDoc + '-' + VS_strCodEmp;
        qryGenGe2.ExecSQL;
        qryGenGe2.Close;
      finally
        FreeAndNil(qryGenGe2);
      end;

    End;

    If Not blnInTransaction Then
      If (Result) Then
        fCommit
      Else
        fRollBack;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[fGeraEntradaMercadoriasNFPrg]');
    End;
  End;

end;

function TControleEntrega.fGeraEntradaMercadoriasPrg(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strSQL: String;
    strIncGer: String;
    strAutInc: String;
    strNumDoc: String;
    strCodFor: String;
    qryGenDet: TUniQuery;
    qryGenGer: TUniQuery;
    qryGenGe2: TUniQuery;
    strAutIncTmp: String;
    recServicos: TDadosServicos;
    blnInTransaction: Boolean;
    arrDuplic: TarrDuplicata;
    intContador: integer;
    strClaFis: String;
    strCodErrosAuditoria: String;
begin
  FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

  qryGenDet := fCriaQuery;
  qryGenGer := fCriaQuery;
  qryGenGe2 := fCriaQuery;

  Result := True;

  blnInTransaction := fInTransaction;

  Try
    Application.ProcessMessages;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ENTGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  GER_DTTEMT IS NOT NULL AND ';
    strSQL := strSQL + '  GER_DTTEFL IS NULL ';

    If FAutIncEnt <> '' Then
      strSQL := strSQL + ' AND ENTGER.AUTOINCREM = ' + FAutIncEnt.QuotedString;

    qryGenGer.Close;
    qryGenGer.SQL.Clear;
    qryGenGer.SQL.Add(strSQL);
    qryGenGer.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGenGer.Open;

    strIncGer := '';

    If fEmptyStr(qryGenGer.FieldByName('GER_EMPFOR').AsString) Then
      strCodFor := fRetCodForFilial(fCfgSis('EMPMAT'))
    Else
      strCodFor := fRetCodForFilial(qryGenGer.FieldByName('GER_EMPFOR').AsString);

    pgbProgresso.Position       := 0;
    pgbProgresso.Properties.Max := qryGenGer.RecordCount;
    Application.ProcessMessages;

    fatVenda.strEmpresaAbastecimentoOutrasSaidas := FEmpresaAbastecimentoOutrasSaidas;

    objAuditoriaSaldo.Limpar;

    While (Not qryGenGer.Eof) Do
    Begin
      If Not blnInTransaction Then
        fStartTransaction;
      {*******************************************}
      {* CARREGA DADOS DETALHADOS                *}
      {****************************************MV*}
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  ENTDET.*, ';
      strSQL := strSQL + '  ITE_CODGRU ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  ENTDET ';
      strSQL := strSQL + 'JOIN CADITE ON ITE_CODITE = DET_CODITE ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  DET_SEQGER = :SEQGER ';

      qryGenDet.Close;
      qryGenDet.SQL.Clear;
      qryGenDet.SQL.Add(strSQL);
      qryGenDet.ParamByName('SEQGER').AsString := qryGenGer.FieldByName('AUTOINCREM').AsString;
      qryGenDet.Open;
      qryGenDet.First;

      strIncGer := QuotedStr(qryGenGer.FieldByName('AUTOINCREM').AsString);

      strNumDoc := fAtualizaProCod('ENTGER', 'GER_NUMDOC', 'MOVGER', 1, Nil,
        function (const AValue: String) : String
        begin
          Result := 'E' + RightStr(AValue, fTamDocCadRec - 1);
        end
      );

      If (FAbastecimentoDeposito) And (not fEmptyStr(fCfgSis('CFOPTR'))) And (not fEmptyStr(fatVenda.strClaFis)) Then
      Begin
        fatVenda.strClaFis := fatVenda.strClaFis[1] + fCfgSis('CFOPTR');

        for intContador := Low(fatVenda.arrMatItens) to High(fatVenda.arrMatItens) do
        begin
          if not fEmptyStr(fatVenda.arrMatItens[intContador].strClaFis) then
            fatVenda.arrMatItens[intContador].strClaFis := fatVenda.arrMatItens[intContador].strClaFis[1] + fCfgSis('CFOPTR');
        end;
      End;

      strClaFis := '1101';

      If blnRegimeEspecialPorProdutoComFaturamentoDuplo Then
        strClaFis := fRetornaClassificacaoFiscal(VS_strCodEmp, strCodFor,
                                                 qryGenDet.FieldByName('DET_CODFIS').AsString,
                                                 (fCampoCadIte('ITE_COMLUB', qryGenDet.FieldByName('DET_CODITE').AsString) = 'S'));

      Result := fGravaMovGer(strAutInc,
                             strNumDoc,
                             'PD',
                             VS_strCodEmp,
                             '',
                             qryGenGer.FieldByName('GER_CODVEN').AsString,
                             strCodFor,
                             '',
                             'F',
                             VS_Date,
                             fTime(),
                             VS_Date,
                             '01000',
                             qryGenGer.FieldByName('GER_ESTADO').AsString,
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
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             qryGenGer.FieldByName('GER_VLRCON').AsFloat,
                             qryGenGer.FieldByName('GER_VLRCON').AsFloat,
                             qryGenGer.FieldByName('GER_TOTCUS').AsFloat,
                             qryGenGer.FieldByName('GER_TOTMED').AsFloat,
                             '2',
                             0.0,
                             0.0,
                             0.0,
                             0,
                             '',
                             '',
                             'REFERENTE A ENTREGA ' + qryGenGer.FieldByName('GER_NUMDOC').AsString + '-' + qryGenGer.FieldByName('GER_ESPDOC').AsString,
                             '',
                             '',
                             '',
                             '',
                             False,
                             '',
                             '',
                             '',  // Empresa do Faturamento
                             0,
                             '',
                             '',
                             False,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             arrDuplic,
                             '',
                             'N',
                             strClaFis,
                             '',
                             '',
                             '',
                             0.0,
                             '',
                             '',
                             '',
                             0.0,
                             recServicos,
                             0.0,
                             '',   // GER_ORIDOC DEVE SER NULL
                             'N',
                             fatVenda.strCodRep,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             '',
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             '',
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             '',
                             0.0,
                             0.0,
                             0,
                             fatVenda.strCliCon,  // Consumidor final
                             'N',
                             fatVenda.strCliFat,
                             fatVenda.strOpeExp,  // Operador da Expedição
                             fatVenda.strSepExp,  // Separador da Expedição
                             fatVenda.strTabPre,
                             '',
                             fatVenda.strEntFut,     // Entrega Futura
                             fatVenda.blnBaiEntFut, // Baixa de Entrega Futura
                             fatVenda.fltMargem,    // Margem de Lucro
                             0.0,                   // Base do retido (caso tivesse) com ipi e frete de entrada
                             0.0,                   // Valor do retido considerando a base acima.
                             'N',                   // Gerar produção fora da loja
                             '',                    // Numero do Registro - Correios ou Transportadora
                             VS_Date,               // Data de Entrega no Romaneio
                             '',                    // Classificação fiscal 4
                             'N',
                             '',                    //Codigo do Evento
                             '',                    // ENDEREÇO DE ENTREGA
                             '',                    // Conteúdo do CNFNFE
                             '',                    // Motivo da Devolução
                             '',
                             True,                  // Imprime Duplicatas na NF-e
                             0,                   // fltValCre: Double    = 0;
                             0,                   // dtadtlBex: TDateTime = 0;
                             '',                  // strEmlCon: String    = '';
                             0,                   // dtaDtESNf: TDateTime = 0;
                             0,                   // tmrHrESNf: TDateTime = 0;
                             Nil,                 // objFinanc: Pointer = Nil;
                             '',                  // strDocCon: String = '';            // Conhecimento de Frete
                             '',                  // strCodObr: String = '';
                             '',                  // strCodArt: String = '';
                             'N',                 // strPermut: String = 'N'; // Permuta para isenção de pagamento de comissão
                             '',                  // strRetIss: String = '';
                             '',                  // strOpcDoc: String = '';
                             0,                   // fltFreSug: Double = 0;
                             '',                  // strNumAde: String = '';
                             0,                   // fltBasAnt: Double = 0;            //BASE DE ICMS ANTECIPADO
                             0,                   // fltValAnt: Double = 0;            //VALOR DE ICMS ANTECIPADO
                             '',                  // strNaoAtu: String = '';
                             '',                  // strEntUrg: String = '';
                             '',                  // strMenExp: String = '';
                             '',                  // strMenEx2: String = '';
                             '',                  // strMenEx3: String = '';
                             '',                  // strMenEx4: String = '';
                             0,                   // fltDupRec: Double = 0;
                             0,                   // fltValAdt: Double = 0;
                             0,                   // fltDeDVCf: Double = 0;
                             '',                  // strPlaVei: String = '';
                             '',                  // strKm_Vei: String = '';
                             '',                  // strCliOri: String = '';
                             '',                  // strCodMot: String = '';
                             '',                  // strBetone: String = '';
                             '',                  // strLacre_: String = '';
                             '',                  // strTipMps: String = '';
                             '',                  // strAbatim: String = '';
                             '',                  // strBrita_: String = '';
                             '',                  // strConBom: String = '';
                             0,                   // intFckDia: Integer = 0;
                             0,                   // fltImpPag: Double = 0;
                             0,                   // intPrzMed: integer = 0;
                             False,               // blnImpPdv: Boolean = False;
                             False,               // blnDTEXREP: Boolean = False;
                             '',                  // strChvNfeDev: String = '';
                             '',                  // strOpeSol: String = '';
                             False,               // blnEst_Dv: Boolean = False;
                             '',                  // strNumCOODev: String = '';
                             '',                  // strNumSerDev: String = '';
                             '',                  // strNumUSUDev: String = '';
                             '',                  // strTipDocDev: String = '';
                             0,                   // fltTotDif: Double = 0;
                             Nil,                 // objFazenda: Pointer = nil;
                             0,                   // fltFedImp   : Double = 0;
                             0,                   // fltEstImp   : Double = 0;
                             0,                   // fltMunImp   : Double = 0;
                             0,                   // fltTroco_: Double = 0;
                             '',                  // strObsNfeFis: String = '';
                             'N',                 // strVenPre: String = 'N';
                             '',                  // strSeqDocOri: String = '';
                             False,               // blnConEqu: Boolean = False;
                             False,               // blnDescIncond: Boolean = False;
                             True,                // blnGraCTP: Boolean = True;
                             '',                  // strNumera: String = '';
                             'N',                 // strEdiPes: String = 'N';
                             0,                   // fltTaxEnt: Double = 0;
                             0,                   // fltVrdIcm: Double = 0;
                             0,                   // fltBasVrd: Double = 0;
                             0,                   // intNroBox: Integer = 0;
                             '',                  // strCodEmbarcacao: String = '';
                             0,                   // fltTotBri: Double = 0;
                             '',                  // strTraRdp: String = '';
                             '',                  // strCliCtt: String = '';
                             '',                  // strCodMod: String = '';
                             '',                  // strNumGui: String = '';
                             '',                  // strHisCom: String = '';
                             '',                  // strCodPrj: String = '';
                             '',                  // strNatCfo: String = '';
                             '',                  // strTpOper: String = '';
                             '',                  // strCupDes: String = '';
                             'S',                 // strNotPau: String = 'S';
                             0,                   // fltCotMoe: Double = 0;
                             0,                   // fltFreMkp: Double = 0;
                             0,                   // fltComMkp: Double = 0;
                             '',                  // strPlaFat: String = '';
                             False,               // blnDevWms: Boolean = False;
                             False,               // blnFulfillmentModoRobo : Boolean = False;
                             0,                   // fltFreCot: Double = 0;
                             0,                   // fltFreRat: Double = 0;
                             'N',                 // strEntSim: String = 'N';
                             '',                  // strSeqDmp: String = '';
                             '',                  // strEntFutOpc: String = '';
                             0,                   // fltTotIpiEntFut: Double = 0;
                             0,                   // fltTotRetEntFut: Double = 0;
                             0,                   // fltTotFcpSTEntFut: Double = 0;
                             0,                   // fltICMDes: Double = 0;
                             0,                   // fltDesPis: Double = 0;
                             '',                  // strOpFaEx: String = '';
                             IIF(FAbastecimentoDeposito, fatVenda.strNumDoc, '' ),    // strDocAba: String = '';
                             IIF(FAbastecimentoDeposito, fatVenda.strEspDoc, '' ),    // strEspAba: String = '';
                             IIF(FAbastecimentoDeposito, IIF(FEhDevolucaoAbastecimentoDeposito, fatVenda.strEmpDoc, fatVenda.strEmpOriPed), '' ), // strEmpAba: String = '';
                             IIF(FAbastecimentoDeposito, fatVenda.strCodCli, '' ),    // strCliAba: String = ''
                             False,
                             '',
                             '',
                             '',
                             IIF(blnRegimeEspecialPorProdutoComFaturamentoDuplo, qryGenGer.FieldByName('GER_NUMDOC').AsString, '' ),
                             IIF(blnRegimeEspecialPorProdutoComFaturamentoDuplo, qryGenGer.FieldByName('GER_ESPDOC').AsString, '' ),
                             IIF(blnRegimeEspecialPorProdutoComFaturamentoDuplo, qryGenGer.FieldByName('GER_CODEMP').AsString, '' ),
                             IIF(blnRegimeEspecialPorProdutoComFaturamentoDuplo, qryGenGer.FieldByName('GER_CODCLI').AsString, '' ),
                             IIF(blnRegimeEspecialPorEmpresaComFaturamentoDuplo, fatVenda.strNumDoc, '' ),
                             IIF(blnRegimeEspecialPorEmpresaComFaturamentoDuplo, fatVenda.strEspDoc, '' ),
                             IIF(blnRegimeEspecialPorEmpresaComFaturamentoDuplo, fatVenda.strEmpOriPed, '' ),
                             IIF(blnRegimeEspecialPorEmpresaComFaturamentoDuplo, fatVenda.strCodCli, '' ));

      If Result Then
        objAuditoriaSaldo.Adicionar(strAutInc, 'MOVGER');

      If (Not Result) Then
      Begin
        fRollBack;
        If blnInTransaction Then
          Exit
        Else
        Begin
          qryGenGer.Next;

          pgbProgresso.Position := pgbProgresso.Position + 1;
          Application.ProcessMessages;

          Continue;
        End;
      End;

      With qryGenDet Do
      Begin
        While (Not Eof) Do
        Begin
          strAutIncTmp := '';

          If blnRegimeEspecialPorProdutoComFaturamentoDuplo Then
            strClaFis := fRetornaClassificacaoFiscal(VS_strCodEmp, strCodFor,
                                                     FieldByName('DET_CODFIS').AsString,
                                                     (fCampoCadIte('ITE_COMLUB', FieldByName('DET_CODITE').AsString) = 'S'));

          Result := fGravaMovDet(strAutIncTmp,
                                 strAutInc,
                                 strNumDoc,
                                 'PD',
                                 VS_strCodEmp,
                                 qryGenDet.FieldByName('DET_CODITE').AsString,
                                 qryGenDet.FieldByName('DET_CODVEN').AsString,
                                 '',
                                 qryGenDet.FieldByName('DET_CODMAR').AsString,
                                 strCodFor,
                                 qryGenGer.FieldByName('GER_CODCLI').AsString,
                                 VS_Date,
                                 fTime(),
                                 VS_Date,
                                 '01000',
                                 'F',
                                 qryGenGer.FieldByName('GER_ESTADO').AsString,
                                 qryGenDet.FieldByName('DET_DESCRI').AsString,
                                 qryGenDet.FieldByName('DET_REFERE').AsString,
                                 qryGenDet.FieldByName('DET_UNIDAD').AsString,
                                 qryGenDet.FieldByName('DET_FORITE').AsString,
                                 qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                 qryGenDet.FieldByName('DET_UNITAR').AsFloat,
                                 qryGenDet.FieldByName('DET_UNIORI').AsFloat,
                                 qryGenDet.FieldByName('DET_UNIVIS').AsFloat,
                                 qryGenDet.FieldByName('DET_VLRCON').AsFloat,
                                 qryGenDet.FieldByName('DET_VLRCON').AsFloat,
                                 qryGenDet.FieldByName('DET_TOTCUS').AsFloat,
                                 qryGenDet.FieldByName('DET_TOTMED').AsFloat,
                                 0.0,
                                 0.0,
                                 0.0,
                                 '',
                                 '',
                                 0.0,
                                 0.0,
                                 0.0,
                                 strClaFis,
                                 qryGenDet.FieldByName('DET_CODFIS').AsString,
                                 0.0,
                                 0.0,
                                 0.0,
                                 0.0,
                                 0.0,
                                 0.0,
                                 0.0,
                                 0.0,
                                 0.0,
                                 0.0,
                                 0.0,
                                 0.0,
                                 False,
                                 '',
                                 '',
                                 '',  // Empresa do Faturamento
                                 0,
                                 '',
                                 '',
                                 0.0,
                                 'NOR',
                                 qryGenDet.FieldByName('DET_INCPIS').AsString,
                                 '',
                                 0.0,
                                 'N',
                                 '',
                                 '',
                                 '',
                                 '',
                                 '',
                                 '',
                                 '',
                                 0.0,
                                 0.0,
                                 '',
                                 0.0,
                                 0.0,
                                 0,
                                 qryGenDet.FieldByName('DET_PROEMB').AsString,
                                 '',
                                 '',
                                 '',
                                 '',
                                 '',
                                 0,
                                 'N',
                                 '',
                                 0.0,
                                 '',
                                 '',
                                 '',
                                 '',
                                 '',
                                 0,
                                 '',
                                 '',
                                 fatVenda.strCliFat,
                                 0,
                                 0,
                                 0.0,
                                 '',
                                 '',
                                 False,
                                 False,
                                 '',
                                 '',
                                 '',
                                 '',
                                 '',
                                 '',
                                 '',
                                 '',
                                 0.0,
                                 '',
                                 0.0,
                                 0.0,
                                 0,
                                 'N',
                                 '',
                                 0,
                                 0,
                                 0,
                                 0,
                                 '',
                                 qryGenDet.FieldByName('DET_NUMLOT').AsString,
                                 'N',
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
                                 '',
                                 '',
                                 '',
                                 0,
                                 0,
                                 0,
                                 0);

          If (Not Result) Then
            Break;

          Result := fAtualizaEstoqueCadIte(qryGenDet.FieldByName('DET_CODITE').AsString,
                                           'E',
                                           qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                           0.0,
                                           qryGenDet.FieldByName('DET_NUMLOT').AsString);

          If (Not Result) Then
            Break;

          Next;

        End;

        Close;

      End;

      If (Not Result) Then
      Begin
        fRollBack;
        If blnInTransaction Then
          Exit
        Else
        Begin
          qryGenGer.Next;

          pgbProgresso.Position := pgbProgresso.Position + 1;
          Application.ProcessMessages;

          Continue;
        End;
      End;

      If (Not fEmptyStr(strIncGer)) Then
      Begin

        strSQL := '';
        strSQL := strSQL + 'UPDATE ';
        strSQL := strSQL + '  ENTGER ';
        strSQL := strSQL + 'SET ';
        strSQL := strSQL + '  GER_DTTEFL = ' + fCurrentDate + ', ';
        strSQL := strSQL + '  GER_HOTEFL = ' + fCurrentTime + ', ';
        strSQL := strSQL + '  GER_DOCEFL = :NUMDOC ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  AUTOINCREM = ' + strIncGer;

        With qryGenGe2 Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('NUMDOC').AsString := strNumDoc + '-PD-' + VS_strCodEmp;
          ExecSQL;
          Close;
        End;

      End;

      If Result And (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
      Begin
        Result := False;
        fRollBack;
        pMostraErrosAuditoria(strCodErrosAuditoria);
      End;

      If Not blnInTransaction Then
        If (Result) Then
          fCommit
        Else
          fRollBack;

      qryGenGer.Next;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[fGeraEntradaMercadorias]');
    End;
  End;

  FreeAndNil(qryGenDet);
  FreeAndNil(qryGenGer);
  FreeAndNil(qryGenGe2);

end;

function TControleEntrega.fGravaDados: Boolean;

  procedure pLimparArrLivFis(var arrLivFis: TArrLivFis);
  var
    intContador: Integer;
  begin
    FillChar(arrLivFis, Length(arrLivFis), #0);
    for intContador := Low(arrLivFis) to High(arrLivFis) do
    begin
      arrLivFis[intContador].strClaFis := '';
      arrLivFis[intContador].fltVlrCon := 0.0;
      arrLivFis[intContador].fltBasIcm := 0.0;
      arrLivFis[intContador].fltAlqIcm := 0.0;
      arrLivFis[intContador].fltValIcm := 0.0;
      arrLivFis[intContador].fltOutras := 0.0;
      arrLivFis[intContador].fltIsento := 0.0;
      arrLivFis[intContador].fltRetido := 0.0;
      arrLivFis[intContador].fltBasIpi := 0.0;
      arrLivFis[intContador].fltValIpi := 0.0;
      arrLivFis[intContador].fltBcReti := 0.0;
      arrLivFis[intContador].fltDAcess := 0.0;
      arrLivFis[intContador].fltValIss := 0.0;
      arrLivFis[intContador].strCstPis := '';
      arrLivFis[intContador].fltBasPis := 0.0;
      arrLivFis[intContador].fltAlqPis := 0.0;
      arrLivFis[intContador].fltValPis := 0.0;
      arrLivFis[intContador].strCstCof := '';
      arrLivFis[intContador].fltBasCof := 0.0;
      arrLivFis[intContador].fltAlqCof := 0.0;
      arrLivFis[intContador].fltValCof := 0.0;
      arrLivFis[intContador].fltBasFCP := 0.0;
      arrLivFis[intContador].fltValFCP := 0.0;
      arrLivFis[intContador].fltAlqFCP := 0.0;
      arrLivFis[intContador].fltIrSeRt := 0.0;
      arrLivFis[intContador].fltPiSeRt := 0.0;
      arrLivFis[intContador].fltCoSeRt := 0.0;
      arrLivFis[intContador].fltCsSeRt := 0.0;
      arrLivFis[intContador].fltBasFcpST := 0.0;
      arrLivFis[intContador].fltValFcpST := 0.0;
      arrLivFis[intContador].fltBasIbs := 0;
      arrLivFis[intContador].fltBasCbs := 0;
      arrLivFis[intContador].fltBas_IS := 0;
      arrLivFis[intContador].fltVlrIbs := 0;
      arrLivFis[intContador].fltVlrCbs := 0;
      arrLivFis[intContador].fltVlr_IS := 0;
    end;
  end;

var
  arrLivFis: TArrLivFis;
  blnPainelNfe: Boolean;
begin
  Result := True;
  {*****************************************}
  {* GRAVA MOVGER                          *}
  {**************************************MV*}
  If (Not fatVenda.fGMovGer) Then
  Begin
    fRollBack;
    Result := False;
    pSetaMensagemDeCancelamento;
    Exit;
  End;

  {*****************************************}
  {* GRAVA MOVDET                          *}
  {**************************************MV*}
  If (Not fatVenda.fGMovDet) Then
  Begin
    fRollBack;
    Result := False;
    pSetaMensagemDeCancelamento;
    Exit;
  End;

  If fatVenda.strEspDoc = 'NF' then
  begin
    {*****************************************}
    {* GRAVAÇÃO DO LIVRO FISCAL              *}
    {**************************************MV*}
    pLimparArrLivFis(arrLivFis);
    fatVenda.pCalculaCadFis(arrLivFis);

    If (Not fatVenda.fGCadFisRe(arrLivFis)) Then
    Begin
      fRollBack;
      Result := False;
      pSetaMensagemDeCancelamento;
      Exit;
    End;

    If (StrToIntDef(fatVenda.strClaFis[1], 0) >= 5) and fatVenda.fDeveEmitirNotaEletronica(fatVenda.strEspDoc, fatVenda.strEmpDoc, blnPainelNfe) And blnPainelNfe Then
    Begin

      pGravarLogNfe(
        fatVenda.strNumDoc,
        fatVenda.strEspDoc,
        fatVenda.strEmpDoc,
        fatVenda.strSerFsc,
        IIF(fatVenda.strNotImp = 'S', fatVenda.strCodFor, fatVenda.strCodCli),
        IIF(fatVenda.fDocumentoParaFornecedor Or (fatVenda.strNotImp = 'S'),'F','C'),
        'EE',
        'Utilize F1 do Painel para Reenviar...');

      fatVendaNF.strEntregaNumDoc := fatVenda.strNumDoc;
      fatVendaNF.strEntregaEspDoc := fatVenda.strEspDoc;
      fatVendaNF.strEntregaCodEmp := fatVenda.strEmpDoc;
      fatVendaNF.strEntregaSerie_ := fatVenda.strSerFsc;
      fatVendaNF.strEntregaCodCli := IIF(fatVenda.strNotImp = 'S', fatVenda.strCodFor, fatVenda.strCodCli);
      fatVendaNF.strEntregaTip_FC := IIF(fatVenda.fDocumentoParaFornecedor Or (fatVenda.strNotImp = 'S'),'F','C');
    End;
  end;

end;

procedure TControleEntrega.pAjustaDadosFiscais(const blnEntrada: Boolean);
var
  intContador: Integer;
  strCodEmpBkp: String;
  strClaFisTmp: String;

  fltVlrConTmp: Double;
  fltBasIcmTmp: Double;
  fltValIcmTmp: Double;
  fltOutrasTmp: Double;
  fltIsentoTmp: Double;

  procedure pApurarVlrConOutIcmIseIcm;
  begin
    strClaFisTmp := fatVenda.arrMatItens[intContador].strClaFis;
    If FAbastecimentoDeposito And (Not fEmptyStr(fCfgSis('CFOPTR'))) Then
      If Not fEmptyStr(fatVenda.arrMatItens[intContador].strClaFis) Then
        strClaFisTmp := strClaFisTmp[1] + fCfgSis('CFOPTR');

    fltVlrConTmp := fatVenda.arrMatItens[intContador].fltTotIte -
                    fatVenda.arrMatItens[intContador].fltDesEsp +
                    fatVenda.arrMatItens[intContador].fltValFre +
                    fatVenda.arrMatItens[intContador].fltDesAce +
                    fatVenda.arrMatItens[intContador].fltValIpi +
                    IIF((fatVenda.arrMatItens[intContador].fltValRet > 0), fatVenda.arrMatItens[intContador].recDifalFCP.fltValFcp, 0) +
                    fatVenda.arrMatItens[intContador].fltValRet+
                    fatVenda.arrMatItens[intContador].fltVaERet +
                    fatVenda.arrMatItens[intContador].fltValCBS +
                    fatVenda.arrMatItens[intContador].fltValIBS +
                    fatVenda.arrMatItens[intContador].fltVal_IS;

    fltBasIcmTmp := fatVenda.arrMatItens[intContador].fltBasIcm;
    fltValIcmTmp := fatVenda.arrMatItens[intContador].fltValIcm;

    fltOutrasTmp := fltVlrConTmp -
                    fatVenda.arrMatItens[intContador].fltBasIcm -
                    fatVenda.arrMatItens[intContador].fltValIpi -
                    IIF((fatVenda.arrMatItens[intContador].fltValRet > 0), fatVenda.arrMatItens[intContador].recDifalFCP.fltValFcp, 0) -
                    fatVenda.arrMatItens[intContador].fltValRet -
                    fatVenda.arrMatItens[intContador].fltVaERet -
                    fatVenda.arrMatItens[intContador].fltValCBS -
                    fatVenda.arrMatItens[intContador].fltValIBS -
                    fatVenda.arrMatItens[intContador].fltVal_IS;

    If (fltOutrasTmp < 0.0) Then
      fltOutrasTmp := 0.0;

    fltIsentoTmp := 0.0;
    If (((Pos(strClaFisTmp, CFOP_TRANSF_DEPOSITO_FECHADO) > 0)) And (Not fatVenda.arrMatItens[intContador].strCodFis.Contains('41'))) Or
       ((AnsiRightStr(strClaFisTmp, 3) = '910') And (fCfgSis('CONIPI', varBoolean))) Or
       (fatVenda.fCstGravaIsento(VS_strCodEmp, fatVenda.arrMatItens[intContador].strCodFis, strClaFisTmp)) Then
    Begin
      If ( AnsiRightStr(strClaFisTmp, 3) <> '922') Or
         ((AnsiRightStr(strClaFisTmp, 3) =  '922') And (fatVenda.arrMatItens[intContador].strCodFis.Contains('41'))) Then
      Begin
        fltIsentoTmp := fltOutrasTmp;
        fltOutrasTmp := 0.0;
      End;
    End;

    fatVenda.arrMatItens[intContador].fltOutIcm := fltOutrasTmp;
    fatVenda.arrMatItens[intContador].fltIseIcm := fltIsentoTmp;
  end;

begin
  If (FVendaNF.blnEmissaoEntFutPorFatPedEntCd) Then
  Begin
    For intContador := Low(fatVenda.arrMatItens) to High(fatVenda.arrMatItens) Do
    Begin
      fatVenda.arrMatItens[intContador].strEntFut := 'N';
      fatVenda.arrMatItens[intContador].strMotFut := '';
      fatVenda.arrMatItens[intContador].dtaDtEntr := VS_Date;
    End;
  End;

  if blnEntrada then
  begin
    strCodEmpBkp := VS_strCodEmp;
    pSetaEmpresaLogada(fatvenda.strEmp_CD);
  end;

  fatVenda.pAtualizaClassTransferencias(blnEntrada);

  try
    fatVenda.pCalculaTotGer;
    fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);
  finally
    if blnEntrada then
      pSetaEmpresaLogada(strCodEmpBkp);
  end;

  if (blnEntrada) then
  begin
    If (FAbastecimentoDeposito) And (fEmptyStr(fCfgSis('CFOPTR'))) Then
    Begin
      For intContador := Low(fatVenda.arrMatItens) To High(fatVenda.arrMatItens) Do
      Begin
        strClaFisTmp := fRetornaClassificacaoFiscal(VS_strCodEmp,
                                                    fatVenda.strCodCli,
                                                    fatVenda.arrMatItens[intContador].strCodFis,
                                                    (fatVenda.arrMatItens[intContador].strComLub = 'S'));

        If (Not fEmptyStr(strClaFisTmp)) Then
          fatVenda.arrMatItens[intContador].strClaFis := strClaFisTmp;
      End;

      strClaFisTmp := '';
    End;

    fatVenda.pSintetizaClassificacoes(False);

    if not fEmptyStr(fatVenda.strClafis) then
    begin
      case fatVenda.strClafis[1] of
        '5': fatVenda.strClafis := '1' + RightStr(fatVenda.strClafis, 3);
        '6': fatVenda.strClafis := '2' + RightStr(fatVenda.strClafis, 3);
      end;

      fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);
    end;

    for intContador := Low(fatVenda.arrMatItens) to High(fatVenda.arrMatItens) do
    begin
      if not fEmptyStr(fatVenda.arrMatItens[intContador].strClaFis) then
        case fatVenda.arrMatItens[intContador].strClaFis[1] of
          '5': fatVenda.arrMatItens[intContador].strClaFis := '1' + RightStr(fatVenda.arrMatItens[intContador].strClaFis, 3);
          '6': fatVenda.arrMatItens[intContador].strClaFis := '2' + RightStr(fatVenda.arrMatItens[intContador].strClaFis, 3);
        end;

      if (Pos(fatVenda.arrMatItens[intContador].strCodFis, CST_SUBSTITUICAO) > 0) then
      begin
        fatVenda.fltBasIcm := fatVenda.fltBasIcm - fatVenda.arrMatItens[intContador].fltBasIcm;
        fatVenda.fltTotIcm := fatVenda.fltTotIcm - fatVenda.arrMatItens[intContador].fltValIcm;

        fatVenda.arrMatItens[intContador].fltBasIcm := 0;
        fatVenda.arrMatItens[intContador].fltAlqIcm := 0;
        fatVenda.arrMatItens[intContador].fltValIcm := 0;

        If fatVenda.fGravaValorRetidoEntradaNosCamposProprios(FblnAbastecimentoDepositoOperacaoVN Or FRegimeEspecialPorProdutoComFaturamentoDuplo) Then
        Begin
          If fRegimeSubstituicaoTributaria('', fatVenda.fOpcDocClaSub) = '1' Then
          Begin
            fatVenda.arrMatItens[intContador].fltBaERet := fatVenda.arrMatItens[intContador].fltBasRet;
            fatVenda.arrMatItens[intContador].fltVaERet := fatVenda.arrMatItens[intContador].fltValRet;

            fatVenda.fltBasRet := fatVenda.fltBasRet - fatVenda.arrMatItens[intContador].fltBasRet;
            fatVenda.fltTotRet := fatVenda.fltTotRet - fatVenda.arrMatItens[intContador].fltValRet;

            fatVenda.arrMatItens[intContador].fltBasRet := 0;
            fatVenda.arrMatItens[intContador].fltValRet := 0;
            fatVenda.arrMatItens[intContador].fltAlqRet := 0;
          End
          Else
          Begin
            fatVenda.arrMatItens[intContador].fltAlqRet := fatVenda.arrMatItens[intContador].fltAlERet;

            fatVenda.arrMatItens[intContador].fltBaERet := 0;
            fatVenda.arrMatItens[intContador].fltVaERet := 0;
            fatVenda.arrMatItens[intContador].fltAlERet := 0;
          End;
        End;
      end;

      pApurarVlrConOutIcmIseIcm;
    end;
  end
  else
  begin
    fatVenda.fltTotMed := 0;
    fatVenda.fltTotPro := 0;
    for intContador := Low(fatVenda.arrMatItens) to High(fatVenda.arrMatItens) do
    begin
      fatVenda.fltTotPro := fatVenda.fltTotPro + fatVenda.arrMatItens[intContador].fltTotIte;
      fatVenda.fltTotMed := fatVenda.fltTotMed + fatVenda.arrMatItens[intContador].fltTotMed;
      fatVenda.arrMatItens[intContador].fltVlrCon := fatVenda.arrMatItens[intContador].fltTotIte -
                                                     fatVenda.arrMatItens[intContador].fltDesEsp +
                                                     fatVenda.arrMatItens[intContador].fltValFre +
                                                     fatVenda.arrMatItens[intContador].fltDesAce +
                                                     fatVenda.arrMatItens[intContador].fltValIpi +
                                                     IIF((fatVenda.arrMatItens[intContador].fltValRet > 0), fatVenda.arrMatItens[intContador].recDifalFCP.fltValFcp, 0) +
                                                     fatVenda.arrMatItens[intContador].fltValRet +
                                                     fatVenda.arrMatItens[intContador].fltValCBS +
                                                     fatVenda.arrMatItens[intContador].fltValIBS +
                                                     fatVenda.arrMatItens[intContador].fltVal_IS;

      pApurarVlrConOutIcmIseIcm;
    end;
  end;
end;

procedure TControleEntrega.pAjustaItensAbastecimentoDeposito;
Var
  itemPedido: TDadosFechamento;
  itensNovos: TMatrizFechamento;
  intIdxItem: Integer;
  qryLotDor : TUniQuery;

  fltTotIteAcu : Double;
  fltTotCusAcu : Double;
  fltTotCu2Acu : Double;
  fltTotMedAcu : Double;
  fltTotUltAcu : Double;
  fltTotImpAcu : Double;
  fltVlrConAcu : Double;

  fltPercentual: Double;

  procedure pAddItemNovo;
  Begin
    SetLength(itensNovos, Length(itensNovos) + 1 );
    itensNovos[High(itensNovos)] := itemPedido;
    itensNovos[High(itensNovos)].intAutInc := High(itensNovos) + 1;
  End;
begin
  qryLotDor := fCriaQuery(Nil);
  Try
    qryLotDor.Close;
    qryLotDor.SQL.Clear;

    qryLotDor.SQL.Add(' SELECT SQL_NO_CACHE        ');
    qryLotDor.SQL.Add('        LDO_NUMLOT,         ');
    qryLotDor.SQL.Add('        LDO_QTDITE          ');
    qryLotDor.SQL.Add(' FROM LOTDOR                ');
    qryLotDor.SQL.Add(' WHERE LDO_SEQFDO = :SEQFDO ');

    fatVenda.blnExpedicaoTeveQuebraDeItensRastreaveis := False;
    SetLength(itensNovos,0);
    For itemPedido in fatVenda.arrMatItens Do
    Begin
      If fProdutoRastreavel(itemPedido.strCodIte) Then
        pAddItemNovo
      Else
      Begin
        qryLotDor.Close;
        qryLotDor.ParamByName('SEQFDO').AsString := itemPedido.strSeqDet;
        qryLotDor.Open;

        If qryLotDor.IsEmpty Then
          pAddItemNovo
        Else
        Begin
          fltTotIteAcu := 0.00;
          fltTotCusAcu := 0.00;
          fltTotCu2Acu := 0.00;
          fltTotMedAcu := 0.00;
          fltTotUltAcu := 0.00;
          fltTotImpAcu := 0.00;
          fltVlrConAcu := 0.00;

          qryLotDor.First;
          While Not qryLotDor.Eof Do
          Begin
            pAddItemNovo;

            intIdxItem := High(itensNovos);
            itensNovos[intIdxItem].strNumLot := qryLotDor.FieldByName('LDO_NUMLOT').AsString;

            If qryLotDor.RecNo <> qryLotDor.RecordCount Then
            Begin
              fatVenda.blnExpedicaoTeveQuebraDeItensRastreaveis := True;

              fltPercentual := qryLotDor.FieldByName('LDO_QTDITE').AsFloat / itensNovos[intIdxItem].fltQtdIte * 100;

              itensNovos[intIdxItem].fltQtdIte := qryLotDor.FieldByName('LDO_QTDITE').AsFloat;

              itensNovos[intIdxItem].fltTotIte := fFormataFloat( itensNovos[intIdxItem].fltTotIte * fltPercentual / 100, 2);
              itensNovos[intIdxItem].fltTotCus := fFormataFloat( itensNovos[intIdxItem].fltTotCus * fltPercentual / 100, 2);
              itensNovos[intIdxItem].fltTotCu2 := fFormataFloat( itensNovos[intIdxItem].fltTotCu2 * fltPercentual / 100, 2);
              itensNovos[intIdxItem].fltTotMed := fFormataFloat( itensNovos[intIdxItem].fltTotMed * fltPercentual / 100, 2);
              itensNovos[intIdxItem].fltTotUlt := fFormataFloat( itensNovos[intIdxItem].fltTotUlt * fltPercentual / 100, 2);
              itensNovos[intIdxItem].fltTotImp := fFormataFloat( itensNovos[intIdxItem].fltTotImp * fltPercentual / 100, 2);
              itensNovos[intIdxItem].fltVlrCon := fFormataFloat( itensNovos[intIdxItem].fltVlrCon * fltPercentual / 100, 2);

              fltTotIteAcu := fltTotIteAcu + itensNovos[intIdxItem].fltTotIte;
              fltTotCusAcu := fltTotCusAcu + itensNovos[intIdxItem].fltTotCus;
              fltTotCu2Acu := fltTotCu2Acu + itensNovos[intIdxItem].fltTotCu2;
              fltTotMedAcu := fltTotMedAcu + itensNovos[intIdxItem].fltTotMed;
              fltTotUltAcu := fltTotUltAcu + itensNovos[intIdxItem].fltTotUlt;
              fltTotImpAcu := fltTotImpAcu + itensNovos[intIdxItem].fltTotImp;
              fltVlrConAcu := fltVlrConAcu + itensNovos[intIdxItem].fltVlrCon;

            End
            Else
            Begin
              itensNovos[intIdxItem].fltQtdIte := qryLotDor.FieldByName('LDO_QTDITE').AsFloat;

              itensNovos[intIdxItem].fltTotIte := fFormataFloat( itensNovos[intIdxItem].fltTotIte - fltTotIteAcu, 2);
              itensNovos[intIdxItem].fltTotCus := fFormataFloat( itensNovos[intIdxItem].fltTotCus - fltTotCusAcu, 2);
              itensNovos[intIdxItem].fltTotCu2 := fFormataFloat( itensNovos[intIdxItem].fltTotCu2 - fltTotCu2Acu, 2);
              itensNovos[intIdxItem].fltTotMed := fFormataFloat( itensNovos[intIdxItem].fltTotMed - fltTotMedAcu, 2);
              itensNovos[intIdxItem].fltTotUlt := fFormataFloat( itensNovos[intIdxItem].fltTotUlt - fltTotUltAcu, 2);
              itensNovos[intIdxItem].fltTotImp := fFormataFloat( itensNovos[intIdxItem].fltTotImp - fltTotImpAcu, 2);
              itensNovos[intIdxItem].fltVlrCon := fFormataFloat( itensNovos[intIdxItem].fltVlrCon - fltVlrConAcu, 2);
            End;

            qryLotDor.Next;
          End;
        End;
      End;
    End;

    //Copia o Array Novo para a Matriz do FatVenda
    SetLength(fatVenda.arrMatItens,0);
    SetLength(fatVenda.arrMatItens, Length(itensNovos) );
    For intIdxItem := Low(itensNovos) To High(itensNovos) Do
      fatVenda.arrMatItens[intIdxItem] := itensNovos[intIdxItem];

  Finally
    FreeAndNil(qryLotDor);
  End;
end;

procedure TControleEntrega.pAplicaPrecoCusto;
var
  intContador: Integer;
begin
  fatVenda.fltTotPro := fatVendaNF.fltTotCus;
  fatVenda.fltTotGer := fatVendaNF.fltTotCus;
  fatVenda.fltDesEsp := 0;
  fatVenda.fltValFre := 0;

  For intContador := Low(fatVenda.arrMatItens) To High(fatVenda.arrMatItens) Do
  begin
    fatVenda.arrMatItens[intContador].fltUniTmp := fatVendaNF.arrMatItens[intContador].fltTotCus / fatVendaNF.arrMatItens[intContador].fltQtdIte;
    fatVenda.arrMatItens[intContador].fltUniTar := fatVendaNF.arrMatItens[intContador].fltTotCus / fatVendaNF.arrMatItens[intContador].fltQtdIte;
    fatVenda.arrMatItens[intContador].fltUniOri := fatVendaNF.arrMatItens[intContador].fltTotCus / fatVendaNF.arrMatItens[intContador].fltQtdIte;
    fatVenda.arrMatItens[intContador].fltUniVis := fatVendaNF.arrMatItens[intContador].fltTotCus / fatVendaNF.arrMatItens[intContador].fltQtdIte;
    fatVenda.arrMatItens[intContador].fltTotIte := fatVendaNF.arrMatItens[intContador].fltTotCus;
    fatVenda.arrMatItens[intContador].fltUniDig := fatVendaNF.arrMatItens[intContador].fltTotCus / fatVendaNF.arrMatItens[intContador].fltQtdIte;
    fatVenda.arrMatItens[intContador].fltVlrCon := fatVendaNF.arrMatItens[intContador].fltTotCus;
    fatVenda.arrMatItens[intContador].fltTaxJur := 0;
    fatVenda.arrMatItens[intContador].fltDesCon := 0;
    fatVenda.arrMatItens[intContador].fltDesEsp := 0;
    fatVenda.arrMatItens[intContador].fltValFre := 0;
  end;
end;

function TControleEntrega.fAtualizaUltimaCompraPrecoMedio: Boolean;
  Var
    item: TDadosFechamento;
    blnAtualizouPreMed: Boolean;
    strEmpMeds, strMedEmp, strForFil: String;
    blnAtuMed, blnAtuUlt, blnMedSe2, blnConIpi, blnUltPis, blnZeraIPI, blnDedIcm: Boolean;
    objImpUlt: TCalculoUltimaCompraImpostos;
    fltPreMed: Double;
begin
  Result := True;

  If Not fRotinasFaturamentoDuplo Then
    Exit;

  Try
    strEmpMeds := fEmpresasMedEmp;
    strMedEmp := fCfgSis('MEDEMP', varString);
    blnAtuMed := fCfgSis('ATUMED', varBoolean);
    blnAtuUlt := fCfgSis('ATUULT', varBoolean);
    blnMedSe2 := fCfgSis('MEDSE2', varBoolean);
    blnConIpi := fCfgSis('CONIPI', varBoolean);
    strForFil := fRetForFilialTodos;

    If Pos(fatVenda.strCodCli, strForFil) > 0 Then
    Begin
      blnUltPis := fRetForFilialDeduzPisCofinsUltimaCompra(VS_strCodEmp, fatVenda.strCodCli);
      blnDedIcm := fRetForFilialDeduzICMSUltimaCompra(VS_strCodEmp, fatVenda.strCodCli);
    End
    Else
    Begin
      blnUltPis := fCfgSis('ULTPIS', varBoolean);
      blnDedIcm := fCfgSis('DEDICM', VarBoolean);
    End;

    For item In fatVenda.arrMatItens Do
    Begin
      objImpUlt := TCalculoUltimaCompraImpostos.fCriaImpUlt
        .TotalItem(item.fltTotIte)
        .DescontoEspecial(item.fltDesEsp);
      Try
        If blnUltPis Then
          objImpUlt.AliquotaPis(item.fltAlqPis).AliquotaCofins(item.fltAlqCof)
        Else
          objImpUlt.AliquotaPis(0).AliquotaCofins(0);

        blnZeraIPI := fZeraIPI(item.strCodIte);

        objImpUlt
          .ValorIpi(IIf(blnZeraIPI, 0, item.fltValipi))
          .ValorIpiNaoCreditado(0)
          .Frete(item.fltValFre)
          .ConhecimentoFrete(0)
          .fRecebimentoPagamentoAutonomoFrete(0)
          .OutrasDespesas(0)
          .Vendor(0)
          .DespesaAcessoria(item.fltDesAce)
          .ValorIcms(IIF(blnDedIcm, item.fltValIcm, 0))
          .ValorIcmsAntecipado(item.fltIcmAnt)
          .ValorIcmsAntecipadoFrete(0)
          .ValorGNRE(0)
          .ValorTCIF(0)
          .ValorTS(0)
          .ValorRetido(item.fltValRet)
          .ValorRetidoNaoCreditado(0)
          .ValorFundoCombateAPobreza(IIF((item.fltValRet > 0), item.recDifalFCP.fltValFcp, 0))
          .FornecedorFilial(Pos(fatVenda.strCodCli, strForFil) > 0)
          .FornecedorFilial(Pos(fatVenda.strCodCli, strForFil) > 0)
          .ItemIncidePis(item.strIncPis);

        fltPreMed := fCalculaPrecoMedio(item.strCodFis,
                                        item.strClaFis,
                                        IIF(fCfgSis('BASMED') <> 'S',
                                            fCampoIteGer('ITE_PREMED', item.strCodIte),
                                            fCampoIteGer('ITE_PRECOM', item.strCodIte)),
                                        item.fltSaldos,
                                        item.fltQtdIte,
                                        item.fltUniTar,
                                        item.fltAlqIcm,
                                        item.fltValIpi,
                                        item.fltValRet,
                                        item.fltIcmAnt,
                                        0,
                                        0,
                                        0,
                                        blnConIpi,
                                        (Pos(fatVenda.strCodCli, strForFil) > 0),
                                        item.strIncPis,
                                        item.fltValFre,
                                        0,
                                        item.fltValIcm,
                                        0,
                                        IIF((item.fltValRet > 0), item.recDifalFCP.fltValFcp, 0),
                                        0,
                                        NIL,
                                        False);

        pAtualizaUltimaCompra(fatVenda.strNumDoc,
                              fatVenda.strEspDoc,
                              fatVenda.strSerFsc,
                              fatVenda.strCodCli,
                              item.strCodIte,
                              item.strClaFis,
                              item.strClaIpi,
                              strForFil,
                              item.strNumLot,
                              strMedEmp,
                              strEmpMeds,
                              blnAtuMed,
                              blnAtuUlt,
                              blnMedSe2,
                              item.fltUniTar,
                              objImpUlt.fUnitario(item.fltQtdIte),
                              fltPreMed,
                              item.fltQtdIte,
                              0,
                              VS_Date,
                              False,
                              Nil,
                              False,
                              blnAtualizouPreMed);
      Finally
        FreeAndNil(objImpUlt);
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fAtualizaUltimaCompraPrecoMedio]');
    End;
  End;
end;

function TControleEntrega.fCampoCadIte(Const strCampo, strCodIte: String): Variant;
begin
  Result := fCampoTabela(strCampo, 'CADITE', ['ITE_CODITE'], [strCodIte], False);
end;

function TControleEntrega.fCampoIteGer(Const strCampo, strCodIte: String; Const strCodEmp: String = ''): Variant;
begin
  Result := fCampoTabela(strCampo, 'ITEGER', ['ITE_CODITE','ITE_CODEMP'],
    [strCodIte, IIF(fEmptyStr(strCodEmp), VS_strCodEmp, strCodEmp)], False);
end;

function TControleEntrega.fProcessaEntGerMatriz(strAutIncEnt: String = '';
  strMensagem: String = ''; blnAbastecimentoDeposito: Boolean = False): Boolean;
var
  frmGravando: TfrmGravando;
Begin
  If strMensagem = '' Then
    strMensagem := 'Aguarde, processando Controle de Entrega...';
  FAutIncEnt := strAutIncEnt;
  FAbastecimentoDeposito := blnAbastecimentoDeposito;
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := strMensagem;
    frmGravando.fExecutarAcao := fProcessaEntGerMatrizPrg;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;
  Finally
    pFreeAndNil(frmGravando);
  End;
End;

function TControleEntrega.fProcessaEntGerMatrizNF(
  const strAutIncEnt: String; blnAbastecimentoDeposito: Boolean = False): Boolean;
var
  frmGravando: TfrmGravando;
begin
  FAutIncEnt := strAutIncEnt;
  FAbastecimentoDeposito := blnAbastecimentoDeposito;

  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := 'Aguarde, processando Controle de Entrega...';
    frmGravando.fExecutarAcao := fProcessaEntGerMatrizNFPrg;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

function TControleEntrega.fTransferenciaParaEmpresaFaturamentoPedido: Boolean;
begin
  Result := False;
  If Assigned(Self.FVendaNF) Then
    Result := Self.FVendaNF.blnTransferenciaParaEmpresaFaturamentoPedidoWms;
end;

procedure TControleEntrega.fAlimentaDadosEntGerMatrizNF;
var
  strSQL: String;
  qryGenGer: TUniQuery;
  dcfDadosCliente: TDadosClienteFilial;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GER_CODEMP ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ENTGER ';
  strSQL := strSQL + 'WHERE ENTGER.AUTOINCREM = ' + FAutIncEnt.QuotedString;

  qryGenGer := fCriaQuery;
  try
    qryGenGer.Close;
    qryGenGer.SQL.Clear;
    qryGenGer.SQL.Add(strSQL);
    qryGenGer.Open;

    fatVenda.strEspDoc := 'NF';
    fatVenda.strClafis := VS_strClaT01;
    fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

    fatVenda.strCodCli := fRetornaClienteFilial(qryGenGer.FieldByName('GER_CODEMP').AsString);
    fatVenda.blnCliFil := True;
    fatVenda.strEntFat := fCfgSis('SUG_TE', varString);
    fatVenda.strCliCon := 'S';

    fatVenda.strTEPREV := fGetTEPREV(VS_strCodEmp, fatVenda.strCodCli);
    fatVenda.strTEPPRO := fGetTEPPRO(VS_strCodEmp, fatVenda.strCodCli);

    dcfDadosCliente := fRetDadosCliente(fatVenda.strCodCli);
    If dcfDadosCliente <> Nil Then
    Begin
      fatVenda.strCliNom := dcfDadosCliente.strCliNom;
      fatVenda.strCliEnd := dcfDadosCliente.strCliEnd;
      fatVenda.strCliBai := dcfDadosCliente.strCliBai;
      fatVenda.strCliCep := dcfDadosCliente.strCliCep;
      fatVenda.strCliCid := dcfDadosCliente.strCliCid;

      If (Not fEmptyStr(dcfDadosCliente.strCliEst)) Then
        fatVenda.strCliEst := dcfDadosCliente.strCliEst;

      fatVenda.strCliTel := dcfDadosCliente.strCliTel;
      fatVenda.intCgcCpf := dcfDadosCliente.intCgcCpf;
      fatVenda.strCliCgc := dcfDadosCliente.strCliCgc;
      fatVenda.strCliIes := dcfDadosCliente.strCliIes;

      FreeAndNil(dcfDadosCliente);
    End;

    fatVenda.strTipFre := fCfgSis('TIPFRE');
    fatVenda.pCarregaEnderecoEntrega(fatVenda, '', '', True);
  finally
    FreeAndNil(qryGenGer);
  end;
end;

function TControleEntrega.fDefineEspecieDeDocumentoEntradaDeMercadoria: String;
begin
  Result := 'NF';

  If (FVendaNF.strTipPed = 'A') Then
    Exit;

  If ((FVendaNF.strTipPed = 'C') And (FAbastecimentoDeposito)) Then
    Exit;

  If (Self.FEspDocOri = 'NF') Then
    Exit;

  Result := 'PD';
end;

function TControleEntrega.fPrecoCustoTE():Boolean;
begin
  Result := (fatVenda.strTEPREV = 'CUS');
end;

function TControleEntrega.fProcessaEntGerMatrizNFPrg(
  pgbProgresso: TcxProgressBar): Boolean;
var
  blnInTransaction: Boolean;
  blnOperacaoEspelho: Boolean;
  ValorAliquotaIBPT : TValorAliquotaIBPT;
  strCodAbf: String;
  strNumDoc: String;
  strSQL: String;
  qryGenGe2,
  qryIteGer,
  qryDetAux: TUniQuery;
  intContador: integer;
begin
  Try
    blnInTransaction := fInTransaction;

    If Not blnInTransaction Then
      fStartTransaction;

    {*******************************************}
    {* CARREGA DADOS GERAIS                    *}
    {****************************************MV*}

    pCopiaFatVenda(FVendaNF, fatVenda);

    strNumDoc := fatVenda.fRetornaSeqNota;
    fatVenda.strNumDoc := strNumDoc;
    fatVenda.strSerFsc := fCfgSis('SERFSC', varString, VS_strCodEmp);

    fAlimentaDadosEntGerMatrizNF;

    FblnAbastecimentoDepositoOperacaoVN := (blnAbastecimentoDeposito) And (Pos(FVendaNF.strOpcDoc, 'VN_CP_') > 0);

    if blnAbastecimentoDeposito then
    begin
      If (FblnAbastecimentoDepositoOperacaoVN) Then
        fatVenda.blnGravaIncPedFuncoesDiarias := True;
      fatVenda.strNumDocAbastecimento := FVendaNF.strNumDoc;
      fatVenda.strEspDocAbastecimento := FVendaNF.strEspDoc;
      fatVenda.strCodEmpAbastecimento := FVendaNF.strEmpOriPed;
      fatVenda.strCodCliAbastecimento := FVendaNF.strCodCli;

      If (blnEhDevolucaoAbastecimentoDeposito) Then
      Begin
        fatVenda.strTEPREV := fGetTEPREV(FVendaNF.strEmpDoc, fatVenda.strCodCli);
        fatVenda.strCodEmpAbastecimento := FVendaNF.strEmpDoc;
      End;
    end;

    If (Self.blnRegimeEspecialPorProdutoComFaturamentoDuplo Or Self.blnDevRegimeEspecial) Then
    begin
      If (Not Self.blnDevRegimeEspecial) Then
        fatVenda.blnGravaIncPedFuncoesDiarias := True;
      fatVenda.blnGravaValRetCmpProFuncoesDiarias := True;
      fatVenda.strNumDocRegimeEspecialPorProduto := FVendaNF.strNumDoc;
      fatVenda.strEspDocRegimeEspecialPorProduto := FVendaNF.strEspDoc;
      fatVenda.strCodEmpRegimeEspecialPorProduto := FVendaNF.strEmpDoc;
      fatVenda.strCodCliRegimeEspecialPorProduto := FVendaNF.strCodCli;
      fatVenda.strNumDocPR := FVendaNF.strNumDocPR;
      fatVenda.strEmpDocPR := FVendaNF.strEmpDocPR;
    end;

    If blnRegimeEspecialPorEmpresaComFaturamentoDuplo Then
    begin
      fatVenda.strNumDocRegimeEspecialPorEmpresa := FVendaNF.strNumDoc;
      fatVenda.strEspDocRegimeEspecialPorEmpresa := FVendaNF.strEspDoc;
      fatVenda.strCodEmpRegimeEspecialPorEmpresa := FVendaNF.strEmpOriPed;
      fatVenda.strCodCliRegimeEspecialPorEmpresa := FVendaNF.strCodCli;
    end;

    fatVenda.strEmpresaAbastecimentoOutrasSaidas := FEmpresaAbastecimentoOutrasSaidas;

    If (Self.blnRegimeEspecialPorProdutoComFaturamentoDuplo) Or (Self.blnAbastecimentoDeposito) Then
      fatVenda.strCliCon := fCampoTabela('CLI_CONSUM', 'CADCLI', ['CLI_CODCLI'], [fatVenda.strCodCli], False);

    if fPrecoCustoTE then
      pAplicaPrecoCusto;

    blnOperacaoEspelho := False;
    If (Self.blnRegimeEspecialPorProdutoComFaturamentoDuplo Or FblnAbastecimentoDepositoOperacaoVN Or Self.blnDevRegimeEspecial) And (fatVenda.strEspDoc = 'NF') Then
    Begin
      qryIteGer := fCriaQuery;
      qryDetAux := fCriaQuery;
      Try
        qryIteGer.SQL.Text := 'SELECT * FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP';

        qryDetAux.SQL.Add('SELECT DET_ENT.AUTOINCREM');
        qryDetAux.SQL.Add('  FROM MOVDET DET_VEN');
        qryDetAux.SQL.Add('       INNER JOIN MOVAUX MOV_VEN ON DET_VEN.AUTOINCREM = MOV_VEN.DET_SEQGER');
        qryDetAux.SQL.Add('       INNER JOIN MOVAUX MOV_ENT ON MOV_ENT.DET_INC_PD = MOV_VEN.DET_INC_PD');
        qryDetAux.SQL.Add('       INNER JOIN MOVDET DET_ENT ON DET_ENT.AUTOINCREM = MOV_ENT.DET_SEQGER');
        qryDetAux.SQL.Add('       INNER JOIN AUXMOV AUX_ENT ON AUX_ENT.AUX_SEQGER = DET_ENT.DET_SEQGER');
        qryDetAux.SQL.Add('                                AND AUX_ENT.AUX_DOC_RE = DET_VEN.DET_NUMDOC');
        qryDetAux.SQL.Add('                                AND AUX_ENT.AUX_ESP_RE = DET_VEN.DET_ESPDOC');
        qryDetAux.SQL.Add('                                AND AUX_ENT.AUX_EMP_RE = DET_VEN.DET_CODEMP');
        qryDetAux.SQL.Add('       INNER JOIN CADEMP EMP_ENT ON EMP_ENT.EMP_CLIFIL = DET_ENT.DET_CODCLI');
        qryDetAux.SQL.Add('WHERE DET_VEN.AUTOINCREM = :AUTINC');

        If FblnAbastecimentoDepositoOperacaoVN Then
          qryDetAux.SQL.Text := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(qryDetAux.SQL.Text, 'AUX_DOC_RE', 'AUX_DOCABA'), 'AUX_ESP_RE', 'AUX_ESPABA'), 'AUX_EMP_RE', 'AUX_EMPABA');

        For intContador := Low(fatVenda.arrMatItens) To High(fatVenda.arrMatItens) Do
        Begin
          If Self.blnDevRegimeEspecial Then
          Begin
            qryDetAux.Close;
            qryDetAux.ParamByName('AUTINC').AsString := fatVenda.arrMatItens[intContador].strAiDvOr;
            qryDetAux.Open;

            If (Not qryDetAux.IsEmpty) Then
            Begin
              blnOperacaoEspelho := True;
              fatVenda.arrMatItens[intContador].strIncEsp := qryDetAux.FieldByName('AUTOINCREM').AsString;
            End;
          End;

          If (blnOperacaoEspelho) Then
            Continue;

          If (fatVenda.arrMatItens[intContador].strIdePro <> 'NOR') Then
            If (fCfgSis('FTDPTI', varInteger) = tpValTinConformeNotaFinalEmitida) Then
              Continue;

          qryIteGer.Close;
          qryIteGer.ParamByName('CODITE').AsString := fatVenda.arrMatItens[intContador].strCodIte;
          qryIteGer.ParamByName('CODEMP').AsString := VS_strCodEmp;
          qryIteGer.Open;

          fatVenda.arrMatItens[intContador].fltUniTmp := fatVenda.fPegaPrecoVenda(qryIteGer, VS_strCodEmp,
                                                                                  'S',
                                                                                  0,
                                                                                  False,
                                                                                  fatVenda.strIdePro,
                                                                                  '',
                                                                                  True,
                                                                                  fatVenda.FTaxJur,
                                                                                  fatVenda.FUniVis);

          strCodAbf := fGetCodAbf(fatVenda.arrMatItens[intContador].strCodIte, VS_strCodEmp);
          If (Not fEmptyStr(fatVenda.GetTipAbf)) And (fatVenda.fBuscaAbfIcm(fatVenda.arrMatItens[intContador].strCodIte, VS_strCodEmp, strCodAbf, fatVenda.fTrocaUFEndEntrega)) Then
          Begin
            If (fCfgSis('IMPPAG', varInteger) = 1) Then
            Begin
              fatVenda.arrMatItens[intContador].fltPeImPg := fatVenda.cdsAbfIcm.FieldByName('ABF_PEIMPG').AsFloat
            End
            Else
            Begin
              ValorAliquotaIBPT := TCadIBPT.fBuscaAlqIBPT(fTiraCaracEspeciais(fCampoCadIte('ITE_CLAIPI', fatVenda.arrMatItens[intContador].strCodIte)), fCampoCadIte('ITE_EXCIPI', fatVenda.arrMatItens[intContador].strCodIte));

              fatVenda.arrMatItens[intContador].fltPeImFd := IIF((LeftStr(fatVenda.cdsAbfIcm.FieldByName('ABF_CODSIT' + fatVenda.GetTipAbf).AsString, 1) <> '0'), ValorAliquotaIBPT.fltImportado, ValorAliquotaIBPT.fltNacional);
              fatVenda.arrMatItens[intContador].fltPeImEs := ValorAliquotaIBPT.fltEstadual;
              fatVenda.arrMatItens[intContador].fltPeImMn := ValorAliquotaIBPT.fltMunicipal;
            End;
          End;

          fatVenda.arrMatItens[intContador].fltUniTar := fatVenda.arrMatItens[intContador].fltUniTmp;
          fatVenda.arrMatItens[intContador].fltUniDig := fatVenda.arrMatItens[intContador].fltUniTmp;
          fatVenda.arrMatItens[intContador].fltUniOri := fatVenda.arrMatItens[intContador].fltUniTmp;
          fatVenda.arrMatItens[intContador].fltUniVis := fatVenda.arrMatItens[intContador].fltUniTmp;
          fatVenda.arrMatItens[intContador].fltPreVe1 := fatVenda.arrMatItens[intContador].fltUniTmp;
          fatVenda.arrMatItens[intContador].fltPesoIt := fRetPesBru(fatVenda.arrMatItens[intContador].strCodIte);
          fatVenda.arrMatItens[intContador].fltPreMed := fCampoIteGer('ITE_PREMED', fatVenda.arrMatItens[intContador].strCodIte);
          fatVenda.arrMatItens[intContador].fltTotMed := fFormataFloat(fatVenda.arrMatItens[intContador].fltPreMed * fatVenda.arrMatItens[intContador].fltQtdIte, 2);
          fatVenda.arrMatItens[intContador].fltDesOpe := fCampoIteGer('ITE_DESOPE', fatVenda.arrMatItens[intContador].strCodIte);
          fatVenda.arrMatItens[intContador].fltImpFed := fCampoIteGer('ITE_IMPFED', fatVenda.arrMatItens[intContador].strCodIte);
          fatVenda.arrMatItens[intContador].fltIcmSai := fCampoIteGer('ITE_ICMSAI', fatVenda.arrMatItens[intContador].strCodIte);
          fatVenda.arrMatItens[intContador].fltOutVal := fCampoIteGer('ITE_OUTVAL', fatVenda.arrMatItens[intContador].strCodIte);
          fatVenda.arrMatItens[intContador].strEntSai := 'S';
        End;
      Finally
        FreeAndNil(qryIteGer);
        FreeAndNil(qryDetAux);
      End;
    End;

    pAjustaItensAbastecimentoDeposito;

    If blnOperacaoEspelho Then
      pOperacaoEspelho(False)
    Else
      pAjustaDadosFiscais(False);

    If (FAbastecimentoDeposito) And (not fEmptyStr(fCfgSis('CFOPTR'))) And (not fEmptyStr(fatVenda.strClaFis)) Then
    Begin
      fatVenda.strClaFis := fatVenda.strClaFis[1] + fCfgSis('CFOPTR');
      fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

      for intContador := Low(fatVenda.arrMatItens) to High(fatVenda.arrMatItens) do
      begin
        if not fEmptyStr(fatVenda.arrMatItens[intContador].strClaFis) then
          fatVenda.arrMatItens[intContador].strClaFis := fatVenda.arrMatItens[intContador].strClaFis[1] + fCfgSis('CFOPTR');
      end;
    End;

    If FAbastecimentoDeposito Then
    Begin
      for intContador := Low(fatVenda.arrMatItens) to High(fatVenda.arrMatItens) do
      begin
        fatVenda.blnAbastecimentoDepositoComTintaSaida := (fatVenda.arrMatItens[intContador].strIdePro <> 'NOR');

        If fatVenda.blnAbastecimentoDepositoComTintaSaida Then
          Break;
      end;
    End;

    If (FAbastecimentoDeposito) And (Length(fatVenda.strClaFis) < 4) Then
    Begin
      fMensagem('Atenção','Não será possível finalizar o processo, verifique as Classificações Fiscais de Transferência do Cadastro da Empresa', ['&OK']);
      Result := False;
      Exit;
    End;

    Result := fGravaDados;

    {*******************************************}
    {* ATUALIZA DATA / HORA DA MATRIZ          *}
    {****************************************MV*}
    If (Result) And (Not fEmptyStr(FAutIncEnt)) Then
    Begin

      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  ENTGER ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  GER_DTTEMT = ' + fCurrentDate + ', ';
      strSQL := strSQL + '  GER_HOTEMT = ' + fCurrentTime + ', ';
      strSQL := strSQL + '  GER_DCTEMT = :NUMDOC ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  AUTOINCREM = :SEQGER ';

      qryGenGe2 := fCriaQuery;
      try
        qryGenGe2.Close;
        qryGenGe2.SQL.Clear;
        qryGenGe2.SQL.Add(strSQL);
        qryGenGe2.ParamByName('NUMDOC').AsString := fatVenda.strNumDoc + '-' + fatVenda.strEspDoc + '-' + VS_strCodEmp;
        qryGenGe2.ParamByName('SEQGER').AsString := FAutIncEnt;
        qryGenGe2.ExecSQL;
        qryGenGe2.Close;
      finally
        FreeAndNil(qryGenGe2);
      end;

    End;

    If Not blnInTransaction Then
      If (Result) Then
        fCommit
      Else
        fRollBack;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[fProcessaEntGerMatriz]');
    End;
  End;

end;

function TControleEntrega.fRetDadosCliente(strCodCli: String; blnFornecedor: Boolean = False): TDadosClienteFilial;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
Begin
  Result := Nil;

  strSQL := '';
  if blnFornecedor then
  begin
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   FOR_NOMFOR AS NOME__, ';
    strSQL := strSQL + '   FOR_ENDERE AS ENDERE, ';
    strSQL := strSQL + '   FOR_BAIRRO AS BAIRRO, ';
    strSQL := strSQL + '   FOR_C_E_P_ AS C_E_P_, ';
    strSQL := strSQL + '   FOR_CODCID AS CODCID, ';
    strSQL := strSQL + '   CID_ESTADO AS ESTADO, ';
    strSQL := strSQL + '   FOR_FONE01 AS FONE01, ';
    strSQL := strSQL + '   FOR_CGCCPF AS CGCCPF, ';
    strSQL := strSQL + '   FOR_C_G_C_ AS C_G_C_, ';
    strSQL := strSQL + '   FOR_I_E_S_ AS I_E_S_ ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADFOR ';
    strSQL := strSQL + ' JOIN CADCID ON (CADCID.CID_CODCID = CADFOR.FOR_CODCID) ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   FOR_CODFOR = :CODIGO ';
  end
  else
  begin
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   CLI_NOMCLI AS NOME__, ';
    strSQL := strSQL + '   CLI_ENDERE AS ENDERE, ';
    strSQL := strSQL + '   CLI_BAIRRO AS BAIRRO, ';
    strSQL := strSQL + '   CLI_C_E_P_ AS C_E_P_, ';
    strSQL := strSQL + '   CLI_CODCID AS CODCID, ';
    strSQL := strSQL + '   CID_ESTADO AS ESTADO, ';
    strSQL := strSQL + '   CLI_FONE01 AS FONE01, ';
    strSQL := strSQL + '   CLI_CGCCPF AS CGCCPF, ';
    strSQL := strSQL + '   CLI_C_G_C_ AS C_G_C_, ';
    strSQL := strSQL + '   CLI_I_E_S_ AS I_E_S_  ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADCLI ';
    strSQL := strSQL + ' JOIN CADCID ON (CADCID.CID_CODCID = CADCLI.CLI_CODCID) ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CLI_CODCLI = :CODIGO ';
  end;

  Try
    qryTmp := fCriaQuery;

    With qryTmp Do
    Begin
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODIGO').AsString := strCodCli;
      Open;

      If Not IsEmpty Then
      Begin
        Result := TDadosClienteFilial.Create;

        Result.strCliNom := FieldByName('NOME__').AsString;
        Result.strCliEnd := FieldByName('ENDERE').AsString;
        Result.strCliBai := FieldByName('BAIRRO').AsString;
        Result.strCliCep := FieldByName('C_E_P_').AsString;
        Result.strCliCid := FieldByName('CODCID').AsString;
        Result.strCliEst := FieldByName('ESTADO').AsString;
        Result.strCliTel := FieldByName('FONE01').AsString;
        Result.intCgcCpf := FieldByName('CGCCPF').AsInteger;
        Result.strCliCgc := FieldByName('C_G_C_').AsString;
        Result.strCliIes := FieldByName('I_E_S_').AsString;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[fRetDadosCliente]');
    End;
  End;

  FreeAndNil(qryTmp);
End;

function TControleEntrega.fRetornaClassificacaoFiscal(Const strCodEmp, strCodFor,
  strCodFis: String; Const blnComLub: Boolean): String;
  Var
    strClaFis: String;
    qryGenAbf: TUniQuery;
begin
  qryGenAbf := fCriaQuery;
  Try
    qryGenAbf.SQL.Add('SELECT');
    qryGenAbf.SQL.Add('  EMP_CLATE1,');
    qryGenAbf.SQL.Add('  EMP_CLATE2,');
    qryGenAbf.SQL.Add('  EMP_CLATE3,');
    qryGenAbf.SQL.Add('  EMP_CLTEV1,');
    qryGenAbf.SQL.Add('  EMP_CLTEV2,');
    qryGenAbf.SQL.Add('  EMP_CLTEV3,');
    qryGenAbf.SQL.Add('  (SELECT CON_TIPOPE FROM CONEMP');
    qryGenAbf.SQL.Add('   WHERE CON_EMPORI = EMP_CODEMP AND CON_EMPDES = :EMPORI) AS TIPOPE');
    qryGenAbf.SQL.Add('FROM CADEMP');
    qryGenAbf.SQL.Add('WHERE EMP_FORFIL = :CODFOR');

    qryGenAbf.ParamByName('CODFOR').AsString := strCodFor;
    qryGenAbf.ParamByName('EMPORI').AsString := VS_strCodEmp;
    qryGenAbf.Open;

    If qryGenAbf.FieldByName('TIPOPE').AsString = '2' Then
    Begin
      If Pos(strCodFis, CST_SUBSTITUICAO) > 0 Then
      Begin
        strClaFis := qryGenAbf.FieldByName('EMP_CLATE2').AsString;
        If blnComLub Then
          strClaFis := qryGenAbf.FieldByName('EMP_CLATE3').AsString;
      End
      Else
        strClaFis := qryGenAbf.FieldByName('EMP_CLATE1').AsString;
    End
    Else
    Begin
      If Pos(strCodFis, CST_SUBSTITUICAO) > 0 Then
      Begin
        strClaFis := qryGenAbf.FieldByName('EMP_CLTEV2').AsString;
        If blnComLub Then
          strClaFis := qryGenAbf.FieldByName('EMP_CLTEV3').AsString;
      End
      Else
        strClaFis := qryGenAbf.FieldByName('EMP_CLTEV1').AsString;
    End;

    If Not fEmptyStr(strClaFis) Then
      strClaFis := IIF(fEstadoFornecedor(strCodFor) = fCadEmp('ESTADO'), '1', '2') + RightStr(strClaFis, 3);

    Result := strClaFis;
  Finally
    FreeAndNil(qryGenAbf);
  End;
end;

function TControleEntrega.fRotinasFaturamentoDuplo: Boolean;
begin
  Result := True;

  If blnAbastecimentoDeposito Then
    Exit;

  If blnRegimeEspecialPorEmpresaComFaturamentoDuplo Then
    Exit;

  If blnRegimeEspecialPorProdutoComFaturamentoDuplo Then
    Exit;

  Result := False;
end;

function TControleEntrega.fProcessaEntGerMatrizPrg(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strSQL: String;
    qryGenDet : TUniQuery;
    qryGenGer : TUniQuery;
    qryGenGe2 : TUniQuery;
    qryIteGer : TUniQuery;
    strNumDoc : String;
    strSeqGer : String;
    dcfDadosCliente: TDadosClienteFilial;
    blnInTransaction: Boolean;
    intContador: integer;
    strTabelaPreco: String;
    fltTotPro: Double;
    strCodAcaAux: String;
    strEmpAcaAux: String;
begin

  Result := True;

  fltTotPro := 0;

  qryGenDet := fCriaQuery(Self);
  qryGenGer := fCriaQuery(Self);
  qryGenGe2 := fCriaQuery(Self);
  qryIteGer := fCriaQuery(Self);

  Try
    Try
      Application.ProcessMessages;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  ENTGER ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  GER_DTTEMT IS NULL AND ';

      If ((fCfgSis('EMPGER', varBoolean))) Then
        strSQL := strSQL + ' ((GER_EMPFOR IS NULL) OR (GER_EMPFOR = :CODEMP)) '
      Else
        strSQL := strSQL + ' (GER_EMPFOR = :CODEMP) ';

      If FAutIncEnt <> '' Then
        strSQL := strSQL + ' AND ENTGER.AUTOINCREM = ' + FAutIncEnt.QuotedString;

      qryGenGer.Close;
      qryGenGer.SQL.Clear;
      qryGenGer.SQL.Add(strSQL);
      qryGenGer.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGenGer.Open;

      blnInTransaction := fInTransaction;

      If (Not qryGenGer.IsEmpty) And fEmptyStr(fRetornaClienteFilial(qryGenGer.FieldByName('GER_CODEMP').AsString)) Then
      Begin
        If blnInTransaction Then
          fRollback;

        fMensagem('','O cliente filial da empresa ' + qryGenGer.FieldByName('GER_CODEMP').AsString + ' não está configurado, favor configurar!', ['&OK']);
        Result := False;
        Exit;
      End;

      qryIteGer.SQL.Text := 'SELECT * FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP';

      pgbProgresso.Position       := 0;
      pgbProgresso.Properties.Max := qryGenGer.RecordCount;
      Application.ProcessMessages;

      While (Not qryGenGer.Eof) Do
      Begin
        If Not blnInTransaction Then
          fStartTransaction;

        strNumDoc := fRetSequencial_TE;
        {*******************************************}
        {* CARREGA DADOS GERAIS                    *}
        {****************************************MV*}
        fatVenda.blnTemTinta := False;
        fatVenda.strNumDoc := strNumDoc;
        fatVenda.strEspDoc := 'TE';
        fatVenda.strCodVen := qryGenGer.FieldByName('GER_CODVEN').AsString;
        fatVenda.strCodTra := qryGenGer.FieldByName('GER_CODTRA').AsString;
        fatVenda.strCodCli := fRetornaClienteFilial(qryGenGer.FieldByName('GER_CODEMP').AsString); //qryGenGer.FieldByName('GER_CODCLI').AsString;
        fatVenda.dtaDtaEnt := qryGenGer.FieldByName('GER_DTAENT').AsDateTime;
        fatVenda.strConPag := '01000';
        fatVenda.strCliEst := qryGenGer.FieldByName('GER_ESTADO').AsString;
        fatVenda.strEntFat := fCfgSis('SUG_TE', varString);

        If (FAbastecimentoDeposito) And (not fEmptyStr(fCfgSis('CFOPTR'))) And (not fEmptyStr(fatVenda.strClaFis)) Then
        Begin
          fatVenda.strClaFis := fatVenda.strClaFis[1] + fCfgSis('CFOPTR');

          for intContador := Low(fatVenda.arrMatItens) to High(fatVenda.arrMatItens) do
          begin
            if not fEmptyStr(fatVenda.arrMatItens[intContador].strClaFis) then
              fatVenda.arrMatItens[intContador].strClaFis := fatVenda.arrMatItens[intContador].strClaFis[1] + fCfgSis('CFOPTR');
          end;
        End;

        dcfDadosCliente := fRetDadosCliente(fatVenda.strCodCli);

        fatVenda.strTEPREV := fGetTEPREV(VS_strCodEmp, fatVenda.strCodCli);
        fatVenda.strTEPPRO := fGetTEPPRO(VS_strCodEmp, fatVenda.strCodCli);
        fatVenda.strEmpresaAbastecimentoOutrasSaidas := FEmpresaAbastecimentoOutrasSaidas;

        if blnAbastecimentoDeposito then
        begin
          fatVenda.strNumDocAbastecimento := FVendaNF.strNumDoc;
          fatVenda.strEspDocAbastecimento := FVendaNF.strEspDoc;
          fatVenda.strCodEmpAbastecimento := FVendaNF.strEmpOriPed;
          fatVenda.strCodCliAbastecimento := FVendaNF.strCodCli;

          If (blnEhDevolucaoAbastecimentoDeposito) Then
          Begin
            fatVenda.strTEPREV := fGetTEPREV(FVendaNF.strEmpDoc, fatVenda.strCodCli);
            fatVenda.strCodEmpAbastecimento := FVendaNF.strEmpDoc;
          End;
        end;

        If blnRegimeEspecialPorProdutoComFaturamentoDuplo Then
        begin
          fatVenda.strNumDocRegimeEspecialPorProduto := FVendaNF.strNumDoc;
          fatVenda.strEspDocRegimeEspecialPorProduto := FVendaNF.strEspDoc;
          fatVenda.strCodEmpRegimeEspecialPorProduto := FVendaNF.strEmpDoc;
          fatVenda.strCodCliRegimeEspecialPorProduto := FVendaNF.strCodCli;
        end;

        If blnRegimeEspecialPorEmpresaComFaturamentoDuplo Then
        begin
          fatVenda.strNumDocRegimeEspecialPorEmpresa := FVendaNF.strNumDoc;
          fatVenda.strEspDocRegimeEspecialPorEmpresa := FVendaNF.strEspDoc;
          fatVenda.strCodEmpRegimeEspecialPorEmpresa := FVendaNF.strEmpOriPed;
          fatVenda.strCodCliRegimeEspecialPorEmpresa := FVendaNF.strCodCli;
        end;

        If dcfDadosCliente <> Nil Then
        Begin
          fatVenda.strCliNom := dcfDadosCliente.strCliNom;
          fatVenda.strCliEnd := dcfDadosCliente.strCliEnd;
          fatVenda.strCliBai := dcfDadosCliente.strCliBai;
          fatVenda.strCliCep := dcfDadosCliente.strCliCep;
          fatVenda.strCliCid := dcfDadosCliente.strCliCid;

          If (Not fEmptyStr(dcfDadosCliente.strCliEst)) Then
            fatVenda.strCliEst := dcfDadosCliente.strCliEst;

          fatVenda.strCliTel := dcfDadosCliente.strCliTel;
          fatVenda.intCgcCpf := dcfDadosCliente.intCgcCpf;
          fatVenda.strCliCgc := dcfDadosCliente.strCliCgc;
          fatVenda.strCliIes := dcfDadosCliente.strCliIes;

          FreeAndNil(dcfDadosCliente);
        End
        Else
        Begin
          fatVenda.strCliNom := qryGenGer.FieldByName('GER_NOMCON').AsString;
          fatVenda.strCliEnd := qryGenGer.FieldByName('GER_ENDCON').AsString;
          fatVenda.strCliBai := qryGenGer.FieldByName('GER_BAICON').AsString;
          fatVenda.strCliCep := qryGenGer.FieldByName('GER_CEPCON').AsString;
          fatVenda.strCliCid := qryGenGer.FieldByName('GER_CIDCON').AsString;

          If (Not fEmptyStr(qryGenGer.FieldByName('GER_ESTCON').AsString)) Then
            fatVenda.strCliEst := qryGenGer.FieldByName('GER_ESTCON').AsString;

          fatVenda.strCliTel := qryGenGer.FieldByName('GER_TELCON').AsString;
          fatVenda.intCgcCpf := qryGenGer.FieldByName('GER_CGCCPF').AsInteger;
          fatVenda.strCliCgc := qryGenGer.FieldByName('GER_CGCCON').AsString;
          fatVenda.strCliIes := qryGenGer.FieldByName('GER_IESCON').AsString;
        End;
      
        fatVenda.fltDesEsp := qryGenGer.FieldByName('GER_DESESP').AsFloat;
        fatVenda.fltTotGer := qryGenGer.FieldByName('GER_VLRCON').AsFloat;
        fatVenda.fltTotPro := fatVenda.fltTotGer;
        fatVenda.fltTotCus := qryGenGer.FieldByName('GER_TOTCUS').AsFloat;
        fatVenda.fltTotMed := qryGenGer.FieldByName('GER_TOTMED').AsFloat;
        fatVenda.strTipFre := qryGenGer.FieldByName('GER_TIPFRE').AsString;
        fatVenda.fltValFre := qryGenGer.FieldByName('GER_TOTFRE').AsFloat;
        fatVenda.fltPesBru := qryGenGer.FieldByName('GER_PESBRU').AsFloat;
        fatVenda.fltPesLiq := qryGenGer.FieldByName('GER_PESLIQ').AsFloat;
        fatVenda.intQtdTra := qryGenGer.FieldByName('GER_VOLUME').AsInteger;
        fatVenda.strEspTra := qryGenGer.FieldByName('GER_ESPECI').AsString;
        fatVenda.strMarTra := qryGenGer.FieldByName('GER_MARCA_').AsString;
        fatVenda.strMen001 := qryGenGer.FieldByName('GER_MEN001').AsString;
        fatVenda.strMen002 := qryGenGer.FieldByName('GER_MEN002').AsString;
  //      fatVenda.strMen003 := qryGenGer.FieldByName('GER_MEN003').AsString;
  //      fatVenda.strMen004 := qryGenGer.FieldByName('GER_MEN004').AsString;
  //      fatVenda.strMen005 := qryGenGer.FieldByName('GER_MEN005').AsString;
        fatVenda.strCodDig := qryGenGer.FieldByName('GER_CODDIG').AsString;
        fatVenda.fltPorDes := qryGenGer.FieldByName('GER_PORDES').AsFloat;
        fatVenda.strCli_Rg := qryGenGer.FieldByName('GER_R_GCON').AsString;
        fatVenda.strCodCnd := qryGenGer.FieldByName('GER_CODCND').AsString;
        fatVenda.strCodFpg := qryGenGer.FieldByName('GER_CODFPG').AsString;
        fatVenda.strCodS01 := qryGenGer.FieldByName('GER_CODS01').AsString;
        fatVenda.strCodS02 := qryGenGer.FieldByName('GER_CODS02').AsString;
        fatVenda.strCodS03 := qryGenGer.FieldByName('GER_CODS03').AsString;
        fatVenda.strCodS04 := qryGenGer.FieldByName('GER_CODS04').AsString;
        fatVenda.strCodS05 := qryGenGer.FieldByName('GER_CODS05').AsString;
        fatVenda.strCodS06 := qryGenGer.FieldByName('GER_CODS06').AsString;
        fatVenda.strDesS01 := qryGenGer.FieldByName('GER_DESS01').AsString;
        fatVenda.strDesS02 := qryGenGer.FieldByName('GER_DESS02').AsString;
        fatVenda.strDesS03 := qryGenGer.FieldByName('GER_DESS03').AsString;
        fatVenda.strDesS04 := qryGenGer.FieldByName('GER_DESS04').AsString;
        fatVenda.strDesS05 := qryGenGer.FieldByName('GER_DESS05').AsString;
        fatVenda.strDesS06 := qryGenGer.FieldByName('GER_DESS06').AsString;
        fatVenda.fltValS01 := qryGenGer.FieldByName('GER_VALS01').AsFloat;
        fatVenda.fltValS02 := qryGenGer.FieldByName('GER_VALS02').AsFloat;
        fatVenda.fltValS03 := qryGenGer.FieldByName('GER_VALS03').AsFloat;
        fatVenda.fltValS04 := qryGenGer.FieldByName('GER_VALS04').AsFloat;
        fatVenda.fltValS05 := qryGenGer.FieldByName('GER_VALS05').AsFloat;
        fatVenda.fltValS06 := qryGenGer.FieldByName('GER_VALS06').AsFloat;
        fatVenda.intPraEnt := qryGenGer.FieldByName('GER_PRAENT').AsInteger;
        fatVenda.fltTotSer := qryGenGer.FieldByName('GER_TOTSER').AsFloat;
        fatVenda.fltBasIss := qryGenGer.FieldByName('GER_TOTSER').AsFloat;
        fatVenda.fltPerIss := qryGenGer.FieldByName('GER_PERISS').AsFloat;
        fatVenda.fltValIss := qryGenGer.FieldByName('GER_VALISS').AsFloat;
        fatVenda.strDesCla := qryGenGer.FieldByName('GER_NATOPE').AsString;

        If Self.blnAbastecimentoDeposito Or
           Self.blnRegimeEspecialPorProdutoComFaturamentoDuplo Or
           Self.blnDevRegimeEspecial Or
           Self.blnRegimeEspecialPorEmpresaComFaturamentoDuplo Then
        begin
          fatVenda.strClaFis := VS_strClaT01;
          fatVenda.blnCliFil := True;
          fatVenda.strCliCon := 'S';
        end
        else
          fatVenda.strClaFis := '5999';

        If (Self.blnRegimeEspecialPorProdutoComFaturamentoDuplo) Or (Self.blnAbastecimentoDeposito) Then
          fatVenda.strCliCon := fCampoTabela('CLI_CONSUM', 'CADCLI', ['CLI_CODCLI'], [fatVenda.strCodCli], False);

        If fPrecoCustoTE Then
        Begin
          fatVenda.fltTotPro := qryGenGer.FieldByName('GER_TOTCUS').AsFloat;
          fatVenda.fltTotGer := qryGenGer.FieldByName('GER_TOTCUS').AsFloat;
          fatVenda.fltDesEsp := 0;
          fatVenda.fltValFre := 0;
        End;

        strSeqGer := qryGenGer.FieldByName('AUTOINCREM').AsString;

        {*******************************************}
        {* CARREGA DADOS DETALHADOS                *}
        {****************************************MV*}
        strSQL := '';
        strSQL := strSQL + 'SELECT ';
        strSQL := strSQL + '  ENTDET.*, ';
        strSQL := strSQL + '  ITE_CODGRU ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  ENTDET ';
        strSQL := strSQL + 'JOIN CADITE ON ITE_CODITE = DET_CODITE ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  DET_SEQGER = :SEQGER ';
        With qryGenDet Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('SEQGER').AsString := strSeqGer;
          Open;

          {*******************************************}
          {* VERIFICA SE A QUANTIDADE DE DADOS BATE  *}
          {* COD O TOTAL DE ITENS GRAVADO NO ENTGER  *}
          {****************************************AF*}
          If qryGenGer.FieldByName('GER_QTDITE').AsInteger <> RecordCount Then
          Begin
            fRollBack;
            Result := False;

            qryGenGer.Next;
            pgbProgresso.Position := pgbProgresso.Position + 1;
            Application.ProcessMessages;

            Continue;
          End;

          SetLength(fatVenda.arrMatItens, RecordCount);

          While (Not Eof) Do
          Begin

            fatVenda.arrMatItens[RecNo-1].intAutInc := RecNo;
            fatVenda.arrMatItens[RecNo-1].strCodIte := FieldByName('DET_CODITE').AsString;
            fatVenda.arrMatItens[RecNo-1].strCodGru := FieldByName('ITE_CODGRU').AsString;
            fatVenda.arrMatItens[RecNo-1].strCodMar := FieldByName('DET_CODMAR').AsString;
            fatVenda.arrMatItens[RecNo-1].strDesIte := FieldByName('DET_DESCRI').AsString;
            fatVenda.arrMatItens[RecNo-1].strDesOri := FieldByName('DET_DESORI').AsString;
            fatVenda.arrMatItens[RecNo-1].strCodUni := FieldByName('DET_UNIDAD').AsString;
            fatVenda.arrMatItens[RecNo-1].strCodFor := FieldByName('DET_FORITE').AsString;
            fatVenda.arrMatItens[RecNo-1].fltQtdIte := FieldByName('DET_QTDITE').AsFloat;
            fatVenda.arrMatItens[RecNo-1].fltUniTar := FieldByName('DET_UNITAR').AsFloat;
            fatVenda.arrMatItens[RecNo-1].fltUniOri := FieldByName('DET_UNIORI').AsFloat;
            fatVenda.arrMatItens[RecNo-1].fltUniVis := FieldByName('DET_UNIVIS').AsFloat;
            fatVenda.arrMatItens[RecNo-1].fltTaxJur := FieldByName('DET_TAXJUR').AsFloat;
            fatVenda.arrMatItens[RecNo-1].fltTotIte := FieldByName('DET_VLRCON').AsFloat;
            fatVenda.arrMatItens[RecNo-1].fltTotCus := FieldByName('DET_TOTCUS').AsFloat;
            fatVenda.arrMatItens[RecNo-1].fltTotCu2 := 0;
            fatVenda.arrMatItens[RecNo-1].fltTotMed := FieldByName('DET_TOTMED').AsFloat;
            fatVenda.arrMatItens[RecNo-1].fltDesCon := FieldByName('DET_DESCON').AsFloat;
            fatVenda.arrMatItens[RecNo-1].fltValFre := FieldByName('DET_TOTFRE').AsFloat;
            fatVenda.arrMatItens[RecNo-1].fltDesEsp := FieldByName('DET_DESESP').AsFloat;
            fatVenda.arrMatItens[RecNo-1].strCodFis := FieldByName('DET_CODFIS').AsString;
            fatVenda.arrMatItens[RecNo-1].strIdePro := FieldByName('DET_IDEPRO').AsString;
            fatVenda.arrMatItens[RecNo-1].strIncPis := FieldByName('DET_INCPIS').AsString;
            fatVenda.arrMatItens[RecNo-1].strIteTin := FieldByName('DET_ITETIN').AsString;
            fatVenda.arrMatItens[RecNo-1].strIteCha := FieldByName('DET_ITECHA').AsString;
            fatVenda.arrMatItens[RecNo-1].strDesCor := FieldByName('DET_DESCOR').AsString;
            fatVenda.arrMatItens[RecNo-1].strTipEmb := FieldByName('DET_TIPEMB').AsString;
            fatVenda.arrMatItens[RecNo-1].fltQtdEmb := FieldByName('DET_QTDEMB').AsFloat;
            fatVenda.arrMatItens[RecNo-1].fltPreEmb := FieldByName('DET_PREEMB').AsFloat;
            fatVenda.arrMatItens[RecNo-1].strTipPre := FieldByName('DET_TIPPRE').AsString;
            fatVenda.arrMatItens[RecNo-1].fltPrvTin := FieldByName('DET_PRVTIN').AsFloat;
            fatVenda.arrMatItens[RecNo-1].fltPrcTin := FieldByName('DET_PRCTIN').AsFloat;
            fatVenda.arrMatItens[RecNo-1].fltFatTin := FieldByName('DET_FATTIN').AsFloat;
            fatVenda.arrMatItens[RecNo-1].strProEmb := FieldByName('DET_PROEMB').AsString;
            fatVenda.arrMatItens[RecNo-1].strIteEmb := FieldByName('DET_ITEEMB').AsString;
            fatVenda.arrMatItens[RecNo-1].intLazQua := FieldByName('DET_LAZQUA').AsInteger;
            fatVenda.arrMatItens[RecNo-1].strPromoc := FieldByName('DET_PROMOC').AsString;
            fatVenda.arrMatItens[RecNo-1].blnProAca := (FieldByName('DET_PROACA').AsString = 'S');
            fatVenda.arrMatItens[RecNo-1].strCodAca := FieldByName('DET_CODACA').AsString;
            fatVenda.arrMatItens[RecNo-1].strEmpAca := FieldByName('DET_EMPACA').AsString;
            fatVenda.arrMatItens[RecNo-1].strClaFis := '5999';

            strTabelaPreco := EmptyStr;
            strTabelaPreco := fCampoTabela('CON_CODTEP', 'CONEMP', ['CON_EMPORI','CON_EMPDES', 'CON_TIPOPE'], [VS_strCodEmp, FieldByName('DET_CODEMP').AsString, '2'], False);

            if fEmptyStr(strTabelaPreco) then
            begin
              fatVenda.arrMatItens[RecNo-1].strTabPre := '1';
            end
            else
            begin
              fatVenda.blnCliFil := True;
              if (Pos(Copy(strTabelaPreco, 3,1), '1_2_3_4_5_6_7_') > 0) then
                fatVenda.arrMatItens[RecNo-1].strTabPre := Copy(strTabelaPreco, 3,1)
              else
                fatVenda.arrMatItens[RecNo-1].strTabPre := '';
            end;

            If Self.blnAbastecimentoDeposito Or
               Self.blnRegimeEspecialPorProdutoComFaturamentoDuplo Or
               Self.blnDevRegimeEspecial Or
               Self.blnRegimeEspecialPorEmpresaComFaturamentoDuplo Or
               Self.fTransferenciaParaEmpresaFaturamentoPedido Then
            begin
              fatVenda.arrMatItens[RecNo-1].strNumLot := FieldByName('DET_NUMLOT').AsString;
              fatVenda.arrMatItens[RecNo-1].strRefere := FieldByName('DET_REFERE').AsString;

              fatVenda.arrMatItens[RecNo-1].fltTotCu2 := fatVenda.arrMatItens[RecNo-1].fltTotCus;
              fatVenda.arrMatItens[RecNo-1].fltPreCus := fatVenda.arrMatItens[RecNo-1].fltTotCus / fatVenda.arrMatItens[RecNo-1].fltQtdIte;
              fatVenda.arrMatItens[RecNo-1].fltPreMed := fatVenda.arrMatItens[RecNo-1].fltTotMed / fatVenda.arrMatItens[RecNo-1].fltQtdIte;
              fatVenda.arrMatItens[RecNo-1].fltCusIte := fatVenda.arrMatItens[RecNo-1].fltPreCus;

              fatVenda.arrMatItens[RecNo-1].fltUniTmp := FieldByName('DET_UNITAR').AsFloat;
              fatVenda.arrMatItens[RecNo-1].fltUniDig := FieldByName('DET_UNITAR').AsFloat;
              fatVenda.arrMatItens[RecNo-1].fltVlrCon := FieldByName('DET_UNITAR').AsFloat;
            end
            else
              fatVenda.arrMatItens[RecNo-1].strNumLot := IIF(fEmptyStr(FieldByName('DET_LOTABA').AsString), FieldByName('DET_NUMLOT').AsString, FieldByName('DET_LOTABA').AsString);

            If (Self.blnAbastecimentoDeposito) And (fatVenda.strEspDoc = 'TE') And (FieldByName('DET_IDEPRO').AsString <> 'NOR') Then
            Begin
              If fRetornaProdutoAcabadoTinDet(FieldByName('DET_NUMDOC').AsString,
                                              FieldByName('DET_ESPDOC').AsString,
                                              FieldByName('DET_CODEMP').AsString,
                                              FieldByName('DET_CODITE').AsString,
                                              FieldByName('DET_ITETIN').AsString,
                                              strCodAcaAux,
                                              strEmpAcaAux) Then
              Begin
                fatVenda.arrMatItens[RecNo-1].strCodAca := strCodAcaAux;
                fatVenda.arrMatItens[RecNo-1].strEmpAca := strEmpAcaAux;
              End;
            End;

            If (fatVenda.arrMatItens[RecNo-1].strIdePro <> 'NOR') Then
              fatVenda.blnTemTinta := True;

            If (Self.blnRegimeEspecialPorProdutoComFaturamentoDuplo Or Self.blnDevRegimeEspecial Or (Not fEmptyStr(strTabelaPreco))) And (fatVenda.strEspDoc = 'TE') Then
            begin
              qryIteGer.Close;
              qryIteGer.ParamByName('CODITE').AsString := fatVenda.arrMatItens[RecNo-1].strCodIte;
              qryIteGer.ParamByName('CODEMP').AsString := VS_strCodEmp;
              qryIteGer.Open;

              if fEmptyStr(strTabelaPreco) then
              begin
                fatVenda.arrMatItens[RecNo-1].fltUniTmp := fatVenda.fPegaPrecoVenda(qryIteGer, VS_strCodEmp,
                                                                                    'S',
                                                                                    0,
                                                                                    False,
                                                                                    fatVenda.strIdePro,
                                                                                    '',
                                                                                    True,
                                                                                    fatVenda.FTaxJur,
                                                                                    fatVenda.FUniVis);
              end
              else
              begin
                fatVenda.arrMatItens[RecNo-1].fltUniTmp := fatVenda.fPegaPrecoVenda(qryIteGer, FieldByName('DET_CODEMP').AsString,
                                                                                    'S',
                                                                                    0,
                                                                                    False,
                                                                                    fatVenda.strIdePro,
                                                                                    '',
                                                                                    True,
                                                                                    fatVenda.FTaxJur,
                                                                                    fatVenda.FUniVis);

                fatVenda.arrMatItens[RecNo-1].fltTotIte := fatVenda.arrMatItens[RecNo-1].fltUniTmp * FieldByName('DET_QTDITE').AsFloat;
                fltTotPro := fltTotPro + fatVenda.arrMatItens[RecNo-1].fltTotIte;
              end;

              fatVenda.arrMatItens[RecNo-1].fltUniTar := fatVenda.arrMatItens[RecNo-1].fltUniTmp;
              fatVenda.arrMatItens[RecNo-1].fltUniDig := fatVenda.arrMatItens[RecNo-1].fltUniTmp;
              fatVenda.arrMatItens[RecNo-1].fltUniOri := fatVenda.arrMatItens[RecNo-1].fltUniTmp;
              fatVenda.arrMatItens[RecNo-1].fltUniVis := fatVenda.arrMatItens[RecNo-1].fltUniTmp;
              fatVenda.arrMatItens[RecNo-1].fltPreVe1 := fatVenda.arrMatItens[RecNo-1].fltUniTmp;
              fatVenda.arrMatItens[RecNo-1].fltPesoIt := fRetPesBru(fatVenda.arrMatItens[RecNo-1].strCodIte);
              fatVenda.arrMatItens[RecNo-1].fltPreMed := fCampoIteGer('ITE_PREMED', fatVenda.arrMatItens[RecNo-1].strCodIte);
              fatVenda.arrMatItens[RecNo-1].fltTotMed := fFormataFloat(fatVenda.arrMatItens[RecNo-1].fltPreMed * fatVenda.arrMatItens[RecNo-1].fltQtdIte, 2);
              fatVenda.arrMatItens[RecNo-1].fltDesOpe := fCampoIteGer('ITE_DESOPE', fatVenda.arrMatItens[RecNo-1].strCodIte);
              fatVenda.arrMatItens[RecNo-1].fltImpFed := fCampoIteGer('ITE_IMPFED', fatVenda.arrMatItens[RecNo-1].strCodIte);
              fatVenda.arrMatItens[RecNo-1].fltIcmSai := fCampoIteGer('ITE_ICMSAI', fatVenda.arrMatItens[RecNo-1].strCodIte);
              fatVenda.arrMatItens[RecNo-1].fltOutVal := fCampoIteGer('ITE_OUTVAL', fatVenda.arrMatItens[RecNo-1].strCodIte);
            end
            Else If fPrecoCustoTE Then
            Begin
              fatVenda.arrMatItens[RecNo-1].fltUniTmp := FieldByName('DET_TOTCUS').AsFloat / FieldByName('DET_QTDITE').AsFloat;
              fatVenda.arrMatItens[RecNo-1].fltUniDig := FieldByName('DET_TOTCUS').AsFloat / FieldByName('DET_QTDITE').AsFloat;
              fatVenda.arrMatItens[RecNo-1].fltVlrCon := FieldByName('DET_TOTCUS').AsFloat;
              fatVenda.arrMatItens[RecNo-1].fltUniTar := FieldByName('DET_TOTCUS').AsFloat / FieldByName('DET_QTDITE').AsFloat;
              fatVenda.arrMatItens[RecNo-1].fltUniOri := FieldByName('DET_TOTCUS').AsFloat / FieldByName('DET_QTDITE').AsFloat;
              fatVenda.arrMatItens[RecNo-1].fltUniVis := FieldByName('DET_TOTCUS').AsFloat / FieldByName('DET_QTDITE').AsFloat;
              fatVenda.arrMatItens[RecNo-1].fltTotIte := FieldByName('DET_TOTCUS').AsFloat;
              fatVenda.arrMatItens[RecNo-1].fltTaxJur := 0;
              fatVenda.arrMatItens[RecNo-1].fltDesCon := 0;
              fatVenda.arrMatItens[RecNo-1].fltDesEsp := 0;
              fatVenda.arrMatItens[RecNo-1].fltValFre := 0;
            End;

            Next;
          End;

          Close;
        End;

        If Self.blnAbastecimentoDeposito Or
           Self.blnRegimeEspecialPorProdutoComFaturamentoDuplo Or
           Self.blnDevRegimeEspecial Or
           Self.blnRegimeEspecialPorEmpresaComFaturamentoDuplo Then
          pAjustaDadosFiscais(False);

        if FAbastecimentoDeposito and (not fEmptyStr(fCfgSis('CFOPTR'))) and (fatVenda.strEspDoc = 'TE') And (not fEmptyStr(fatVenda.strClaFis)) then
        begin
          fatVenda.strClaFis := fatVenda.strClaFis[1] + fCfgSis('CFOPTR');

          for intContador := Low(fatVenda.arrMatItens) to High(fatVenda.arrMatItens) do
          begin
            if not fEmptyStr(fatVenda.arrMatItens[intContador].strClaFis) then
              fatVenda.arrMatItens[intContador].strClaFis := fatVenda.arrMatItens[intContador].strClaFis[1] + fCfgSis('CFOPTR');
          end;
        end;

        If FAbastecimentoDeposito Then
        Begin
          for intContador := Low(fatVenda.arrMatItens) to High(fatVenda.arrMatItens) do
          begin
            fatVenda.blnAbastecimentoDepositoComTintaSaida := (fatVenda.arrMatItens[intContador].strIdePro <> 'NOR');

            If fatVenda.blnAbastecimentoDepositoComTintaSaida Then
              Break;
          end;
        End;

        if Not fEmptyStr(strTabelaPreco) then
        begin
          fatVenda.fltTotGer := fltTotPro;
          fatVenda.fltTotPro := fltTotPro;
        end;

        Result := fGravaDados;

        {*******************************************}
        {* ATUALIZA DATA / HORA DA MATRIZ          *}
        {****************************************MV*}
        If (Result) And (Not fEmptyStr(strSeqGer)) Then
        Begin

          strSQL := '';
          strSQL := strSQL + 'UPDATE ';
          strSQL := strSQL + '  ENTGER ';
          strSQL := strSQL + 'SET ';
          strSQL := strSQL + '  GER_DTTEMT = ' + fCurrentDate + ', ';
          strSQL := strSQL + '  GER_HOTEMT = ' + fCurrentTime + ', ';
          strSQL := strSQL + '  GER_DCTEMT = :NUMDOC ';
          strSQL := strSQL + 'WHERE ';
          strSQL := strSQL + '  AUTOINCREM = :SEQGER ';

          With qryGenGe2 Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('NUMDOC').AsString := strNumDoc + '-TE-' + VS_strCodEmp;
            ParamByName('SEQGER').AsString := strSeqGer;
            ExecSQL;
            Close;
          End;

        End;

        If Not blnInTransaction Then
          If (Result) Then
            fCommit
          Else
            fRollBack;

        qryGenGer.Next;

        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;
      End;

      qryGenGer.Close;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        Result := False;
        pMensagensErro(E.Message, '[fProcessaEntGerMatriz]');
      End;
    End;

  Finally
    FreeAndNil(qryGenDet);
    FreeAndNil(qryGenGer);
    FreeAndNil(qryGenGe2);
    FreeAndNil(qryIteGer);
  End;
end;

procedure TControleEntrega.pCopiaFatVenda(const Origem, Destino: TFatVenda);
var
  intContador: Integer;
begin
  if (not Assigned(Origem)) or (not Assigned(Destino)) then
    Exit;

  Destino.strNumDoc := Origem.strNumDoc;
  Destino.strEspDoc := Origem.strEspDoc;
  Destino.strCodVen := Origem.strCodVen;
  Destino.strCodTra := Origem.strCodTra;
  Destino.dtaDtaEnt := Origem.dtaDtaEnt;
  Destino.strConPag := Origem.strConPag;
  Destino.strCliEst := Origem.strCliEst;
  Destino.strEntFat := Origem.strEntFat;
  Destino.strCodCli := Origem.strCodCli;
  Destino.strCliNom := Origem.strCliNom;
  Destino.strCliEnd := Origem.strCliEnd;
  Destino.strCliBai := Origem.strCliBai;
  Destino.strCliCep := Origem.strCliCep;
  Destino.strCliCid := Origem.strCliCid;
  Destino.strCliEst := Origem.strCliEst;
  Destino.strCliTel := Origem.strCliTel;
  Destino.intCgcCpf := Origem.intCgcCpf;
  Destino.strCliCgc := Origem.strCliCgc;
  Destino.strCliIes := Origem.strCliIes;
  Destino.fltDesEsp := Origem.fltDesEsp;
  Destino.fltTotGer := Origem.fltTotGer;
  Destino.fltTotPro := Origem.fltTotPro;
  Destino.fltTotCus := Origem.fltTotCus;
  Destino.fltTotMed := Origem.fltTotMed;
  Destino.strTipFre := Origem.strTipFre;
  Destino.fltValFre := Origem.fltValFre;
  Destino.fltPesBru := Origem.fltPesBru;
  Destino.fltPesLiq := Origem.fltPesLiq;
  Destino.intQtdTra := Origem.intQtdTra;
  Destino.strEspTra := Origem.strEspTra;
  Destino.strMarTra := Origem.strMarTra;
//  Destino.strMen001 := Origem.strMen001;
//  Destino.strMen002 := Origem.strMen002;
//  Destino.strMen003 := Origem.strMen003;
//  Destino.strMen004 := Origem.strMen004;
//  Destino.strMen005 := Origem.strMen005;
  Destino.strCodDig := Origem.strCodDig;
  Destino.fltPorDes := Origem.fltPorDes;
  Destino.strCli_Rg := Origem.strCli_Rg;
  Destino.strCodCnd := Origem.strCodCnd;
  Destino.strCodFpg := Origem.strCodFpg;
  Destino.strCodS01 := Origem.strCodS01;
  Destino.strCodS02 := Origem.strCodS02;
  Destino.strCodS03 := Origem.strCodS03;
  Destino.strCodS04 := Origem.strCodS04;
  Destino.strCodS05 := Origem.strCodS05;
  Destino.strCodS06 := Origem.strCodS06;
  Destino.strDesS01 := Origem.strDesS01;
  Destino.strDesS02 := Origem.strDesS02;
  Destino.strDesS03 := Origem.strDesS03;
  Destino.strDesS04 := Origem.strDesS04;
  Destino.strDesS05 := Origem.strDesS05;
  Destino.strDesS06 := Origem.strDesS06;
  Destino.fltValS01 := Origem.fltValS01;
  Destino.fltValS02 := Origem.fltValS02;
  Destino.fltValS03 := Origem.fltValS03;
  Destino.fltValS04 := Origem.fltValS04;
  Destino.fltValS05 := Origem.fltValS05;
  Destino.fltValS06 := Origem.fltValS06;
  Destino.intPraEnt := Origem.intPraEnt;
  Destino.fltTotSer := Origem.fltTotSer;
  Destino.fltBasIss := Origem.fltBasIss;
  Destino.fltPerIss := Origem.fltPerIss;
  Destino.fltValIss := Origem.fltValIss;
  Destino.strDesCla := Origem.strDesCla;
  Destino.strClaFis := Origem.strClaFis;
  Destino.blnTemTinta := Origem.blnTemTinta;
  Destino.strSerFsc := Origem.strSerFsc;

  SetLength(Destino.arrMatItens, Length(Origem.arrMatItens));
  For intContador := Low(Origem.arrMatItens) To High(Origem.arrMatItens) Do
    Destino.arrMatItens[intContador] := Origem.arrMatItens[intContador];

  For intContador := Low(Destino.arrMatItens) To High(Destino.arrMatItens) Do
  begin
    Destino.arrMatItens[intContador].strNumOrc := '';
    Destino.arrMatItens[intContador].strEspOrc := '';
    Destino.arrMatItens[intContador].strEmpOrc := '';

    If (Self.blnRegimeEspecialPorProdutoComFaturamentoDuplo Or Self.blnDevRegimeEspecial) Then
    Begin
      Destino.arrMatItens[intContador].strDocDev := '';
      Destino.arrMatItens[intContador].strEspDev := '';
      Destino.arrMatItens[intContador].strEmpDev := '';
    End;

    Destino.arrMatItens[intContador].intSeqInd := 0;
    Destino.arrMatItens[intContador].fltIseIcm := 0;
  end;

end;

procedure TControleEntrega.pSetaMensagemDeCancelamento;
begin
  If (Not blnAbastecimentoDeposito) Then
    Exit;

  If (Not Assigned(FVendaNF)) Then
    Exit;

  If (Not Assigned(fatVenda)) Then
    Exit;

  If (fEmptyStr(fatVenda.strMsgCancelamento)) Then
    Exit;

  FVendaNF.strMsgCancelamento := fatVenda.strMsgCancelamento;
end;

procedure TControleEntrega.pVerificaEntregas(blnLoopTravamento: Boolean = False);
begin

  If (Not fCfgSis('CONENT', varBoolean)) Then
    Exit;

  If Not fLock_Unlock('CONENTREGA', True, blnLoopTravamento, True, '', True) Then
    Exit;

  fProcessaEntGerMatriz;
  fGeraEntradaMercadorias;

  fLock_Unlock('CONENTREGA', False, blnLoopTravamento, True, '', False);

end;

{******************************}
{* GERA INVENTARIO DE ESTOQUE *}
{***************************AF*}
Class Function TFuncoesDiarias.fGeraInventarioEstoque2(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strSQL      : String;
    strNomTabela: String;
    strMesInvent: String;
    strAnoInvent: String;
    qryDados    : TUniQuery;
    qryGen      : TUniQuery;
    qryGenIte   : TUniQuery;
Begin
  Try

    Try
      pgbProgresso.Position       := 0;
      pgbProgresso.Properties.Max := 3;
      if fCfgSis('ESTEXT', varBoolean) then
        pgbProgresso.Properties.Max := 4;
      Application.ProcessMessages;

      qryGenIte := fCriaQuery;
      qryDados  := fCriaQuery;
      qryGen    := fCriaQuery;

      strMesInvent := FormatDateTime('mm',VS_Date);
      strAnoInvent := FormatDateTime('yyyy',VS_Date);

      If strMesInvent = '01' Then
      Begin
        strMesInvent := '12';
        strAnoInvent := IntToStr(StrToInt(strAnoInvent) - 1);
      End
      Else
        strMesInvent := IntToStr(strtoint(strMesInvent) - 1);

      If Length(strMesInvent) = 1 Then
        strMesInvent := '0' + strMesInvent;

      strNomTabela := 'I_' + strAnoInvent + strMesInvent;

      strSQL := strSQL + ' SELECT * FROM ITEGER WHERE FALSE ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

        strSQL := '';
        strSQL := strSQL + ' CREATE TABLE ' + strNomTabela;
        strSQL := strSQL + '  SELECT G.*,  ';

        {*
        For intIndex := 0 To Fields.Count -1 Do
          strSQL := strSQL + ' G.' + Fields[intIndex].FieldName + ', ' ;
        *}
        strSQL := strSQL + '    I.ITE_CODUNI,            ';
        strSQL := strSQL + '    I.ITE_DESITE,            ';
        strSQL := strSQL + '    I.ITE_REFERE,            ';
        strSQL := strSQL + '    I.ITE_CLAIPI,            ';
        strSQL := strSQL + '    I.ITE_CODGRU,            ';
        strSQL := strSQL + '    I.ITE_ITEATI,            ';
        strSQL := strSQL + '    I.ITE_CNV_ML,            ';
        strSQL := strSQL + '    I.ITE_INCPIS,             ';
        strSQL := strSQL + '    A.ABF_BASE_E AS ITE_BASE_E,  ';
        strSQL := strSQL + '    A.ABF_BASE_S AS ITE_BASE_S,  ';
        strSQL := strSQL + '    A.ABF_ALQ__E AS ITE_ALQ__E,  ';
        strSQL := strSQL + '    A.ABF_ALQ__S AS ITE_ALQ__S,  ';
        strSQL := strSQL + '    A.ABF_CODSIT AS ITE_CODSIT,  ';
        strSQL := strSQL + '    A.ABF_SITCON AS ITE_SITCON   ';
        strSQL := strSQL + '  FROM                       ';
        strSQL := strSQL + '    ITEGER G  JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ';
        strSQL := strSQL + '    JOIN CADEMP ON EMP_CODEMP = ' + VS_StrCodEmp ;
        strSQL := strSQL + '    JOIN CADCID ON CID_CODCID = EMP_CODCID ';
        strSQL := strSQL + '    LEFT JOIN CADABF A ON ABF_CODABF = G.ITE_CODABF AND ABF_ESTADO = CID_ESTADO ';

        If fCfgSIs('TIPABF') = '1' Then
          strSQL := AnsiReplaceStr(strSql, 'G.ITE_CODABF', 'I.ITE_CODABF');

        strSQL := strSQL + ';  ALTER TABLE ' + strNomTabela + ' ADD CONSTRAINT PRIMARY KEY (AUTOINCREM); ';

        Close;

        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;

        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;

        pCriaIndices(strNomTabela, 'ITE_CODITE');
        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;

        pCriaIndices(strNomTabela, 'ITE_DESITE');
        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;

        if fCfgSis('ESTEXT', varBoolean) then
        begin
          strNomTabela := 'FUL_' + strAnoInvent + strMesInvent;

          strSQL := '';
          strSQL := strSQL + ' CREATE TABLE ' + strNomTabela;
          strSQL := strSQL + '  SELECT *  ';
          strSQL := strSQL + '  FROM      ';
          strSQL := strSQL + '    ESTEXT  ';
          strSQL := strSQL + ';  ALTER TABLE ' + strNomTabela + ' ADD CONSTRAINT PRIMARY KEY (AUTOINCREM); ';
          strSQL := strSQL + ' CREATE INDEX ';
          strSQL := strSQL + '  IDX_' + strNomTabela + '_01';
          strSQL := strSQL + ' ON ';
          strSQL := strSQL + ' ' + strNomTabela + ' ';
          strSQL := strSQL + ' (EXT_CODITE, EXT_CODEMP, EXT_CODEEE); ';

          SQL.Clear;
          SQL.Add(strSQL);
          ExecSQL;

          pgbProgresso.Position := pgbProgresso.Position + 1;
          Application.ProcessMessages;
        end;

        Result := True;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'fGeraInventarioEstoque');
      End;
    End;

  Finally
    FreeAndNil(qryGen);
    FreeAndNil(qryDados);
    FreeAndNil(qryGenIte);
  End;
End;

class function TFuncoesDiarias.fGerarTaxaArmazenamentoOS(
  pgbProgresso: TcxProgressBar): Boolean;
var
  strSQL,
  strSQLUpd,
  strHistorico: String;
  fltTxaVal,
  fltTxaVad: Double;
  intTxaDia,
  intTxaNov: Integer;
  dtaDataUltTaxa: TDateTime;
  blnAtualizarData: Boolean;
  qryEquArm,
  qryAtuEqu: TUniQuery;
begin
  Result := True;

  if (not fCfgSis('TXAUTI', varBoolean)) then
    Exit;

  intTxaDia := fCfgSis('TXADIA', varInteger);
  fltTxaVal := fCfgSis('TXAVAL', varDouble);
  intTxaNov := fCfgSis('TXANOV', varInteger);
  fltTxaVad := fCfgSis('TXAVAD', varDouble);

  qryEquArm := fCriaQuery;
  qryAtuEqu := fCriaQuery;

  try
    fStartTransaction;

    strSQLUpd := '';
    strSQLUpd := strSQLUpd + 'UPDATE EQUGER ';
    strSQLUpd := strSQLUpd + 'SET EQU_DTTXAR = :DTTXAR ';
    strSQLUpd := strSQLUpd + 'WHERE AUTOINCREM = :SEQEQU ';
    qryAtuEqu.SQL.Text := strSQLUpd;

    strSQL := '';
    strSQL := strSQL + 'SELECT G.AUTOINCREM SEQEQU, G.EQU_NUMOSE, G.EQU_CODEMP, G.EQU_CODCLI, G.EQU_DTAFIN, G.EQU_DTAARM, ';
    strSQL := strSQL + '  ADDDATE(IF(G.EQU_DTAARM IS NULL, G.EQU_DTAFIN, G.EQU_DTAARM), ' + IntToStr(intTxaDia) + ') DTAARM, G.EQU_DTTXAR, ';
    strSQL := strSQL + '  E.EQU_CODIGO CODEQU, E.EQU_DESCRI DESEQU, MAR_DESMAR DESMAR ';
    strSQL := strSQL + 'FROM EQUGER G ';
    strSQL := strSQL + 'INNER JOIN CADEQU E ON E.EQU_CODIGO = G.EQU_CODEQU ';
    strSQL := strSQL + 'LEFT JOIN CADMAR ON E.EQU_CODMAR = MAR_CODMAR ';
    strSQL := strSQL + 'WHERE G.EQU_CODEMP = :CODEMP ';
    strSQL := strSQL + '  AND (G.EQU_FLXSIT = "AR" OR G.EQU_FLXCOM = "AR") ';
    strSQL := strSQL + '  AND (G.EQU_DTAARM IS NOT NULL OR G.EQU_DTAFIN IS NOT NULL) ';
    strSQL := strSQL + '  AND ADDDATE(IF(G.EQU_DTAARM IS NULL, G.EQU_DTAFIN, G.EQU_DTAARM), ' + IntToStr(intTxaDia) + ') <= CURRENT_DATE ';

    qryEquArm.SQL.Text := strSQL;
    qryEquArm.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryEquArm.Open;

    while not qryEquArm.Eof do
    begin
      blnAtualizarData := False;
      strHistorico := 'O.S Nº: ' + qryEquArm.FieldByName('EQU_NUMOSE').AsString + '-' + qryEquArm.FieldByName('EQU_CODEMP').AsString;
      strHistorico := strHistorico + ' | DATA ARMAZENAMENTO: ' + DateToStr(qryEquArm.FieldByName('DTAARM').AsDateTime);
      strHistorico := strHistorico + ' | EQUIPAMENTO: ' + qryEquArm.FieldByName('CODEQU').AsString + '-' + qryEquArm.FieldByName('DESEQU').AsString;
      strHistorico := strHistorico + ' | MARCA: ' + qryEquArm.FieldByName('DESMAR').AsString;

      if (qryEquArm.FieldByName('EQU_DTTXAR').AsDateTime = 0) then
      begin
        if (not fInsereCadRecOS(qryEquArm.FieldByName('SEQEQU').AsString, qryEquArm.FieldByName('EQU_CODCLI').AsString, strHistorico, fltTxaVal)) then
          Exit;

        dtaDataUltTaxa := qryEquArm.FieldByName('DTAARM').AsDateTime;
        blnAtualizarData := True;
      end
      else
        dtaDataUltTaxa := qryEquArm.FieldByName('EQU_DTTXAR').AsDateTime;

      if ((intTxaNov > 0) and (fltTxaVad > 0) and (dtaDataUltTaxa < VS_Date)) then
      begin
        while (IncDay(dtaDataUltTaxa, intTxaNov) <= VS_Date) do
        begin
          dtaDataUltTaxa := IncDay(dtaDataUltTaxa, intTxaNov);

          if (not fInsereCadRecOS(qryEquArm.FieldByName('SEQEQU').AsString, qryEquArm.FieldByName('EQU_CODCLI').AsString, strHistorico, fltTxaVad)) then
            Exit;

          blnAtualizarData := True;
        end;
      end;

      if (blnAtualizarData) then
      begin
        try
          qryAtuEqu.Close;
          qryAtuEqu.ParamByName('SEQEQU').AsString := qryEquArm.FieldByName('SEQEQU').AsString;
          qryAtuEqu.ParamByName('DTTXAR').AsDateTime := dtaDataUltTaxa;
          qryAtuEqu.ExecSQL;
        except
          on E: Exception do
          begin
            fRollback;
            Result := False;
            pMensagensErro(E.Message, '[fGerarTaxaArmazenamentoOS]');
            Exit;
          end;
        end;
      end;

      qryEquArm.Next;
    end;

    fCommit;
  finally
    FreeAndNil(qryEquArm);
    FreeAndNil(qryAtuEqu);
  end;
end;

class procedure TFuncoesDiarias.pGeraLogCliente(ACodCli,
                                                ACampoAlt,
                                                AInforAntC,
                                                AInforNovC : String);
Var
  strSQL      : String;
  qryGravaLog : TUniQuery;
begin

  qryGravaLog := fCriaQuery;

  Try

    Try

      strSQL := '';
      strSQL := strSQL + ' INSERT INTO LOGCLI ( ';
      strSQL := strSQL + '   AUTOINCREM, ';
      strSQL := strSQL + '   CLI_CODCLI, ';
      strSQL := strSQL + '   CLI_DTAALT, ';
      strSQL := strSQL + '   CLI_HRAALT, ';
      strSQL := strSQL + '   CLI_OPEALT, ';
      strSQL := strSQL + '   CLI_CPOALT, ';
      strSQL := strSQL + '   CLI_INFANC, ';
      strSQL := strSQL + '   CLI_INFNOC, ';
      strSQL := strSQL + '   CLI_AUTOMA, ';
      strSQL := strSQL + '   CLI_OPELOG )';
      strSQL := strSQL + ' VALUES ( ';
      strSQL := strSQL + '   :AUTOIN, ';
      strSQL := strSQL + '   :CODCLI, ';
      strSQL := strSQL + '   CURRENT_DATE, ';
      strSQL := strSQL + '   CURRENT_TIME, ';
      strSQL := strSQL + '   :OPEALT, ';
      strSQL := strSQL + '   :CPOALT, ';
      strSQL := strSQL + '   :INFANC, ';
      strSQL := strSQL + '   :INFNOC, ';
      strSQL := strSQL + '   "S",     ';
      strSQL := strSQL + '   :OPELOG) ';

      With qryGravaLog Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('AUTOIN').AsString := fRetAutoIncrem('LOGCLI', VS_strCodEmp);
        ParamByName('CODCLI').AsString := ACodCli;
        ParamByName('OPEALT').AsString := strLoginUsuarioLogado;
        ParamByName('CPOALT').AsString := ACampoAlt;
        ParamByName('INFANC').AsString := AInforAntC;
        ParamByName('INFNOC').AsString := AInforNovC;
        ParamByName('OPELOG').AsString := strLoginUsuarioLogado;
        ExecSQL;
        Close;
      End;

    Except
      On E : Exception do
        Raise Exception.Create(E.Message);
    End;

  Finally
    FreeAndNil(qryGravaLog);
  End;

end;

Procedure pGeraInventarioFisico;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, gerando Inventário Físico...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fGeraInventarioEstoque2;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

Procedure pMontaInventarioFisico;
  Var
    strMesInvent: String;
    strAnoInvent: String;
    strNomTabela: String;
    objGerInv   : TGeraInventarioFin;
Begin

  {*************************************}
  {* MONTA TABELA DO INVENTARIO FISICO *}
  {**********************************AF*}
  strMesInvent := FormatDateTime('mm',VS_Date);
  strAnoInvent := FormatDateTime('yyyy',VS_Date);

  If strMesInvent = '01' Then
  Begin
    strMesInvent := '12';
    strAnoInvent := IntToStr(StrToInt(strAnoInvent) - 1);
  End
  Else
    strMesInvent := IntToStr(strtoint(strMesInvent) - 1);

  If Length(strMesInvent) = 1 Then
    strMesInvent := '0' + strMesInvent;

  strNomTabela := 'I_' + strAnoInvent + strMesInvent;

  If (Not fTabelaExiste(strNomTabela)) Then
    pGeraInventarioFisico;

  {*****************************************}
  {* MONTA TABELA DO INVENTARIO FINANCEIRO *}
  {**************************************IV*}

  If fCfgSis('INVFIN', varBoolean) Then
  Begin

    strNomTabela := 'CTR_' + strAnoInvent + strMesInvent;

    If (Not fTabelaExiste(strNomTabela)) Or (Not fTemInvFin(strNomTabela, 'CTR')) Then
    Begin
      objGerInv := TGeraInventarioFin.Create(Nil);
      objGerInv.pGeraInventarioFinanceiro(strAnoInvent, strMesInvent);
      FreeAndNil(objGerInv);
    End;

  End;
End;

class function TFuncoesDiarias.fDeletarLogsTxtAntigos(pgbProgresso: TcxProgressBar): Boolean;
  Var
    dtaFileDateTime : TDateTime;
    strNomDir : String;
    strNomArq : String;
    SearchFile : TSearchRec;
begin
  Result := True;

  strNomDir := ExtractFilePath(Application.ExeName) + 'temp\log\';

  If (Not DirectoryExists(strNomDir)) Then
    Exit;

  Try
    If FindFirst(strNomDir + '*.txt', faArchive, SearchFile) <> 0 Then
      Exit;
    Repeat
      strNomArq := strNomDir + SearchFile.Name;
      FileAge(strNomArq, dtaFileDateTime);
      If (DaysBetween(DateOf(dtaFileDateTime), VS_Date) > 30) Then
        TFile.Delete(strNomArq);
    Until FindNext(SearchFile) <> 0;
  Finally
    SysUtils.FindClose(SearchFile);
  End;
end;

Class function TFuncoesDiarias.fDeleteSqlErr(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryLogLck: TUniQuery;
Begin
  Try
    qryLogLck := fCriaQuery;
    Try
      qryLogLck.SQL.Clear;
      qryLogLck.SQL.Add('DELETE FROM SQLERR WHERE ERR_DTAERR <= :DTALOG');
      qryLogLck.ParamByName('DTALOG').AsDate := (VS_Date - 180);
      qryLogLck.ExecSQL;
    Finally
      FreeAndNil(qryLogLck);
    End;
    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFuncoesDiarias.fDeleteSqlErr]');
      Result := False;
    End;
  End;
End;

Class function TFuncoesDiarias.fDeleteLogRef(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryLogRef: TUniQuery;
Begin
  Try
    qryLogRef := fCriaQuery;
    Try
      qryLogRef.SQL.Clear;
      qryLogRef.SQL.Add('DELETE FROM LOGREF WHERE REF_DTAHRA < :DTALOG');
      qryLogRef.ParamByName('DTALOG').AsDate := (VS_Date - 90);
      qryLogRef.ExecSQL;
    Finally
      FreeAndNil(qryLogRef);
    End;
    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFuncoesDiarias.fDeleteLogRef]');
      Result := False;
    End;
  End;
End;

Class function TFuncoesDiarias.fDeleteLogRdZ(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryLogRdz: TUniQuery;
Begin
  Try
    Application.ProcessMessages;

    qryLogRdz := fCriaQuery;

    With qryLogRdz, SQL Do
    Begin
      Clear;
      Add('DELETE FROM LOGRDZ WHERE RDZ_DTAIMP <= :DTAIMP');
      ParamByName('DTAIMP').AsDate := (VS_Date - 45);
      ExecSQL;
    End;

    FreeAndNil(qryLogRdz);

    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFuncoesDiarias.fDeleteLogRdZ]');
      Result := False;
    End;
  End;
End;

Class function TFuncoesDiarias.fDeleteLogLck(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryLogLck: TUniQuery;
Begin
  Try
    Application.ProcessMessages;

    qryLogLck := fCriaQuery;

    With qryLogLck, SQL Do
    Begin
      Clear;
      Add('DELETE FROM LCKATC_LOG WHERE LCK_DTALOG <= :DTALOG');
      ParamByName('DTALOG').AsDate := (VS_Date - 90);
      ExecSQL;
    End;

    FreeAndNil(qryLogLck);

    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFuncoesDiarias.fDeleteLogLck]');
      Result := False;
    End;
  End;
End;

class function TFuncoesDiarias.fDeleteLogLogErrPinPad(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  LqryLogVar: TUniQuery;
Begin

  Try
    Application.ProcessMessages;

    LqryLogVar := fCriaQuery;
    try
      LqryLogVar.SQL.Clear;
      LqryLogVar.SQL.Add('DELETE FROM LOGERR_PIX WHERE LOG_DESCRI = "PinPad" AND LOG_DTAERR < ' + fCurrentDate(VS_Date - 90));
      LqryLogVar.ExecSQL;
    finally
      FreeAndNil(LqryLogVar);
    end ;

    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFuncoesDiarias.fDeleteLogLogTef]');
      Result := False;
    End;
  End;

end;

class function TFuncoesDiarias.fDeleteLogLogTef(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  LqryLogVar: TUniQuery;
Begin

  Try
    Application.ProcessMessages;

    LqryLogVar := fCriaQuery;
    try
      LqryLogVar.SQL.Clear;
      LqryLogVar.SQL.Add('DELETE FROM LOGTEF WHERE LOG_DTALOG < ' + fCurrentDate(VS_Date - 180));
      LqryLogVar.ExecSQL;
    finally
      FreeAndNil(LqryLogVar);
    end ;

    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFuncoesDiarias.fDeleteLogLogTef]');
      Result := False;
    End;
  End;
end;

class function TFuncoesDiarias.fApagarNfeTempo(
  pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('DELETE FROM NFE_TEMPO');
  qryAux.ExecSQL;
  FreeAndNil(qryAux);

  Result := True;
end;

class function TFuncoesDiarias.fAtualizarDataProximoEnvioGatilhosInformacao(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  TGatilhosInformacao.AtualizarDataProximoEnvio;
  Result := True;
end;

Class function TFuncoesDiarias.fDeleteCadMsg(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryCadMsg: TUniQuery;
Begin
  Try
    Application.ProcessMessages;

    qryCadMsg := fCriaQuery;

    With qryCadMsg, SQL Do
    Begin
      Clear;
      Add('DELETE FROM CADMSG WHERE MSG_DTAENV <> ' + fCurrentDate + ' AND MSG_NUMLIB IS NOT NULL AND MSG_NUMLIB <> "";');
      ExecSQL;
    End;

    FreeAndNil(qryCadMsg);

    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFuncoesDiarias.fDeleteCadMsg]');
      Result := False;
    End;
  End;
End;

class function TFuncoesDiarias.fDeleteFrmRep(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryDel: TUniQuery;
Begin
  Result := True;

  Application.ProcessMessages;

  If Not VS_blnExisteTabelaLogFormReplicacao Then
    Exit;

  Try
    Application.ProcessMessages;

    qryDel := fCriaQuery;

    With qryDel, SQL Do
    Begin
      Clear;
      Add('DELETE FROM FRMREP WHERE LOG_DTALOG <= :DTALOG');
      ParamByName('DTALOG').AsDate := (VS_Date - 10);
      ExecSQL;
    End;

    FreeAndNil(qryDel);
  Except
    VS_blnExisteTabelaLogFormReplicacao := False;
  End;

end;

Class function TFuncoesDiarias.fDeleteApp_CadMsg(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryAppCadMsg: TUniQuery;
Begin
  Try
    Application.ProcessMessages;

    qryAppCadMsg := fCriaQuery;

    With qryAppCadMsg, SQL Do
    Begin
      Clear;
      Add('DELETE FROM APP_CADMSG WHERE MSG_DTAENV <> ' + fCurrentDate + ' AND MSG_ATIVA_ = "N"');
      ExecSQL;
    End;

    FreeAndNil(qryAppCadMsg);

    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFuncoesDiarias.fDeleteApp_CadMsg]');
      Result := False;
    End;
  End;
End;

class function TFuncoesDiarias.fDeleteImagensEmailSemUso(
  pgbProgresso: TcxProgressBar): Boolean;
Var
   SearchFile: TSearchRec;
   FindResult: Integer;
   strPatImg : String;
   qryImg    : TUniQuery;

   function fImagemEstaSendoUtilizada(strNomIma: String): Boolean;
   Var
     strSQL: String;
   Begin

     strSQL := '';
     strSQL := strSQL + 'SELECT                 ';
     strSQL := strSQL + '  COUNT(*) AS QTDREG   ';
     strSQL := strSQL + 'FROM                   ';
     strSQL := strSQL + '  IMGMOD               ';
     strSQL := strSQL + 'WHERE                  ';
     strSQL := strSQL + '  IMG_NOMIMG = :NOMIMG ';

     With qryImg Do
     Begin
       Close;
       SQL.Clear;
       SQL.Add(strSQL);
       ParamByName('NOMIMG').AsString := strNomIma;
       Open;
       Result := FieldByName('QTDREG').AsInteger > 0;
     End;

   End;

begin

  try
    qryImg     := fCriaQuery(Nil);
    strPatImg  := ExtractFilePath(Application.ExeName) + PASTA_IMAGEM_EMAIL_AUT + '\';
    FindResult := FindFirst(strPatImg + '*.*', faArchive, SearchFile);

    While FindResult = 0 do
    begin
      If Not (fImagemEstaSendoUtilizada(SearchFile.name)) Then
        TFile.Delete(strPatImg + SearchFile.name);

      FindResult := FindNext(SearchFile)
    end;

    Result := True;

  finally
    SysUtils.FindClose(SearchFile);
    FreeAndNil(qryImg);
  end;

end;

class function TFuncoesDiarias.fAtualizaTipoPrecoTransferenciaCONEMP(
  pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryAux : TUniQuery;
    strTePrev : String;
begin
  Result := True;
  strTePrev := fCfgSis('TEPREV');
  If Not fEmptyStr(strTePrev) Then
  Begin
    qryAux := fCriaQuery(Nil);
    Try
      qryAux.SQL.Add(' UPDATE CONEMP ');
      qryAux.SQL.Add('    SET CON_CODTEP = :CODTEP ');
      qryAux.SQL.Add('  WHERE CON_EMPORI = :CODEMP ');
      qryAux.SQL.Add('    AND CON_CODTEP IS NULL ');
      qryAux.SQL.Add('    AND (SELECT COUNT(1) FROM TEPREV ');
      qryAux.SQL.Add('          WHERE TEP_CODIGO = :CODTEP) > 0 ');

      qryAux.ParamByName('CODTEP').AsString := strTePrev;
      qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryAux.ExecSQL;
    Finally
      FreeAndNil(qryAux);
    End;
  End;
end;

class function TFuncoesDiarias.fInsertTEPREV(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := untFuncoesSimples.fInsertTEPREV;
end;

class function TFuncoesDiarias.fMensagemCertificadoDigital(
  pgbProgresso: TcxProgressBar): Boolean;
  Var
    objCertificadoDigitalAvisos : TCertificadoDigitalAvisos;
begin
  objCertificadoDigitalAvisos := TCertificadoDigitalAvisos.Create(pgbProgresso);
  Try
    objCertificadoDigitalAvisos.DispararMensagens;
    Result := True;
  Finally
    FreeAndNil(objCertificadoDigitalAvisos);
  End;
end;

class function TFuncoesDiarias.fMensagemContratoLocacaoAVencer(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  qryOperadores : TUniQuery;
  qryDocumentos : TUniQuery;
  strEmpresas: string;
  msgInt: TMsgInterna;
  stlMsg: TStringList;
begin
  Result := False;

  If Not fCfgSis('LOCEQU', varBoolean) Then
    Exit;

  qryOperadores := fCriaQuery;
  Try
    qryOperadores.SQL.Add('SELECT OPE_CODOPE FROM CADOPE WHERE OPE_MSGCTL  = "S"');
    qryOperadores.Open;
    If qryOperadores.IsEmpty Then
      Exit(True);
    msgInt := TMsgInterna.Create(Nil);
    stlMsg := TStringList.Create();

    qryDocumentos := fCriaQuery;
    Try
      While not qryOperadores.Eof Do
      Begin
        strEmpresas := fRetEmpAcessoUsuario(qryOperadores.FieldByName('OPE_CODOPE').AsString);
        qryDocumentos.SQL.Clear;
        qryDocumentos.SQL.Add('SELECT EQL_CODEMP,');
        qryDocumentos.SQL.Add('       EQL_NROCON,');
        qryDocumentos.SQL.Add('       EQL_CODCLI,');
        qryDocumentos.SQL.Add('       CLI_NOMCLI,');
        qryDocumentos.SQL.Add('       CLI_NOMCLI,');
        qryDocumentos.SQL.Add('       (CASE WHEN EQL_TIPDUR = "M" THEN EQL_MESINI  ');
        qryDocumentos.SQL.Add('        ELSE EQL_DTAINI END) AS EQL_DTAINI,         ');
        qryDocumentos.SQL.Add('       EQL_HORINI,');
        qryDocumentos.SQL.Add('       (CASE WHEN EQL_TIPDUR = "M" THEN EQL_MESFIN  ');
        qryDocumentos.SQL.Add('        ELSE EQL_DTAFIN END) AS EQL_DTAFIN,         ');
        qryDocumentos.SQL.Add('       EQL_HORFIN ');
        qryDocumentos.SQL.Add('  FROM CONEQL     ');
        qryDocumentos.SQL.Add('  INNER JOIN CADCLI ON EQL_CODCLI = CLI_CODCLI              ');
        qryDocumentos.SQL.Add(' WHERE (((EQL_TIPDUR <> "M") AND (EQL_DTAFIN = :DTAFIN))    ');
        qryDocumentos.SQL.Add('   OR   ((EQL_TIPDUR =  "M") AND (EQL_MESFIN = :DTAFIN)))   ');
        qryDocumentos.SQL.Add('   AND ((EQL_STATUS = "A") OR (EQL_STATUS = "O"))           ');
        If strEmpresas <> '' Then
          qryDocumentos.SQL.Add('   AND LOCATE(EQL_CODEMP, "'+strEmpresas+'") > 0');
        qryDocumentos.ParamByName('DTAFIN').AsDateTime := VS_Date + 1;
        qryDocumentos.Open;

        If Not qryDocumentos.IsEmpty Then
        Begin
          stlMsg.Clear;
          stlMsg.Add('Data Envio: ' + FormatDateTime('DD/MM/YYYY', VS_Date + 1));
          stlMsg.Add('Assunto   : Contratos de Locação que irão vencer no dia ' + FormatDateTime('DD/MM/YYYY', VS_Date + 1));
          stlMsg.Add('');
          stlMsg.Add('------------------------------------------------------------------------------------------------------------------');
          stlMsg.Add('|Empresa |Contrato            |Cliente                                 |Início              |Término             |');
          stlMsg.Add('------------------------------------------------------------------------------------------------------------------');
          While not qryDocumentos.Eof Do
          Begin
            stlMsg.Add('|' +  fPadR(qryDocumentos.FieldByName('EQL_CODEMP').AsString, 8 , ' ') +
                       '|' +  fPadR(qryDocumentos.FieldByName('EQL_NROCON').AsString, 20, ' ') +
                       '|' +  fPadR(qryDocumentos.FieldByName('EQL_CODCLI').AsString + '-' + qryDocumentos.FieldByName('CLI_NOMCLI').AsString, 40, ' ') +
                       '|' +  fPadR(qryDocumentos.FieldByName('EQL_DTAINI').AsString + ' ' + qryDocumentos.FieldByName('EQL_HORINI').AsString, 20, ' ') +
                       '|' +  fPadR(qryDocumentos.FieldByName('EQL_DTAFIN').AsString + ' ' + qryDocumentos.FieldByName('EQL_HORFIN').AsString, 20, ' ') + '|');
            qryDocumentos.Next;
          End;
          stlMsg.Add('------------------------------------------------------------------------------------------------------------------');
          Result := msgInt.fEnviaMensagem('Contratos de Locação que irão vencer', stlMsg.Text, strLoginUsuarioLogado, qryOperadores.FieldByName('OPE_CODOPE').AsString, 'N','');
        End;
        qryOperadores.Next;
      End;
    Finally
      FreeAndNil(msgInt);
      FreeAndNil(stlMsg);
      FreeAndNil(qryDocumentos);
    End;
  Finally
    FreeAndNil(qryOperadores);
  End;

end;

class function TFuncoesDiarias.fMensagemMediaDeAtrasoClientes(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryOperadores: TUniQuery;
    objMsgInt: TMsgInterna;
    stlMsgInt: TStringList;
begin
  Result := False;

  If (Not fCfgSis('CREAUT', VarBoolean)) Or (Not fCfgSis('MSGCRE', VarBoolean)) Then
    Exit;

  qryOperadores := fCriaQuery;
  objMsgInt := TMsgInterna.Create(Nil);
  stlMsgInt := TStringList.Create();

  Try
    qryOperadores.Close;
    qryOperadores.SQL.Clear;
    qryOperadores.SQL.Text := 'SELECT OPE_CODOPE FROM CADOPE WHERE OPE_MSGMDA = "S"';
    qryOperadores.Open;
    qryOperadores.First;

    pMontaMensagemDeMediaDeAtraso(stlMsgInt);

    While (Not qryOperadores.Eof) Do
    Begin
      Result := objMsgInt.fEnviaMensagem('Clientes com média de atraso superior ao configurado',
        stlMsgInt.Text, strLoginUsuarioLogado, qryOperadores.FieldByName('OPE_CODOPE').AsString, 'N','');
      qryOperadores.Next;
    End;
  Finally
    FreeAndNil(qryOperadores);
  End;
end;

class procedure TFuncoesDiarias.pMontaMensagemDeMediaDeAtraso(Var stlMensagem: TStringList);
  Var
    qryClientes: TUniQuery;
    fltMediaAtr: Double;
    blnAchouMed: Boolean;
begin
  qryClientes := fCriaQuery;
  blnAchouMed := False;

  Try
    qryClientes.Close;
    qryClientes.SQL.Clear;
    qryClientes.SQL.Text := 'SELECT CLI_CODCLI, CLI_NOMCLI FROM CADCLI WHERE CLI_STATUS = "A"';
    qryClientes.Open;
    qryClientes.First;

    stlMensagem.Clear;
    stlMensagem.Add('Data Envio: ' + FormatDateTime('DD/MM/YYYY', VS_Date));
    stlMensagem.Add('Assunto   : Clientes com média de atraso maior que ' + FloatToStr(fCfgSis('MEDCRE', varDouble)));
    stlMensagem.Add('');
    stlMensagem.Add('-----------------------------------------------------------------------------------');
    stlMensagem.Add('|Cliente                                                     |Média de Atraso     |');
    stlMensagem.Add('|---------------------------------------------------------------------------------|');

    While (Not qryClientes.Eof) Do
    Begin
      fltMediaAtr := fBuscaMediaDeAtraso(qryClientes.FieldByName('CLI_CODCLI').AsString, '', False, fCfgSis('AJUDTA', varBoolean));

      If (fltMediaAtr > fCfgSis('MEDCRE', varDouble)) Then
      Begin
        blnAchouMed := True;
        stlMensagem.Add('|' +  fPadR(qryClientes.FieldByName('CLI_CODCLI').AsString + '-' + qryClientes.FieldByName('CLI_NOMCLI').AsString, 60, ' ') +
                        '|' +  fPadR(FormatFloat('#0.00', fltMediaAtr), 20, ' ') + '|');
      End;

      qryClientes.Next;
    End;

    If (Not blnAchouMed) Then
      stlMensagem.Clear
    Else
      stlMensagem.Add('-----------------------------------------------------------------------------------');
  Finally
    FreeAndNil(qryClientes);
  End;
end;

class function TFuncoesDiarias.fMensagenEfetivacaoMovimentoFiscal(
  pgbProgresso: TcxProgressBar): Boolean;
  var qryOperadores: TUniQuery;
      qryDocumentos: TUniQuery;
      strEmpresas: string;
      msgInt: TMsgInterna;
      stlMsg: TStringList;
      strDias: String ;
begin
  {}
  Result := True;
  If fCfgSis('DMEFEM', varInteger) = 0 Then
    Exit(True);

  strDias := fCfgSis('DMEFEM');

  qryOperadores := fCriaQuery;
  Try
    qryOperadores.SQL.Add('SELECT * FROM CADOPE WHERE OPE_DMEFEM  = "S"');
    qryOperadores.Open;
    If qryOperadores.IsEmpty Then
      Exit(True);
    msgInt := TMsgInterna.Create(Nil);
    stlMsg := TStringList.Create();

    qryDocumentos := fCriaQuery;
    Try
      While not qryOperadores.Eof Do
      Begin
        strEmpresas := fRetEmpresaOperador(qryOperadores.FieldByName('OPE_NOMOPE').AsString);
        qryDocumentos.SQL.Clear;
        qryDocumentos.SQL.Add('SELECT GER_NUMDOC,');
        qryDocumentos.SQL.Add('       GER_ESPDOC,');
        qryDocumentos.SQL.Add('       GER_SERIE_,');
        qryDocumentos.SQL.Add('       GER_CODEMP,');
        qryDocumentos.SQL.Add('       GER_CODFOR,');
        qryDocumentos.SQL.Add('       FOR_NOMFOR,');
        qryDocumentos.SQL.Add('       GER_DTADOC,');
        qryDocumentos.SQL.Add('       GER_TOTPRO,');
        qryDocumentos.SQL.Add('       GER_VLRCON,');
        qryDocumentos.SQL.Add('       GER_CODTRA,');
        qryDocumentos.SQL.Add('       TRA_NOMTRA,');
        qryDocumentos.SQL.Add('       "N" AS EFETIVA,');
        qryDocumentos.SQL.Add('       DATEDIFF(CURDATE(), GER_DTALAN) AS DIASATR');
        qryDocumentos.SQL.Add('  FROM MOVGER');
        qryDocumentos.SQL.Add(' INNER JOIN CADFOR ON FOR_CODFOR = GER_CODFOR');
        qryDocumentos.SQL.Add('  LEFT JOIN CADTRA ON  TRA_CODTRA = GER_CODTRA');
        qryDocumentos.SQL.Add(' WHERE GER_DTAENT IS NULL');
        qryDocumentos.SQL.Add('   AND DATEDIFF(CURDATE(), GER_DTALAN) >= '+ fCfgSis('DMEFEM'));
        If strEmpresas <> '' Then
          qryDocumentos.SQL.Add('   NAD LOCATE(GER_CODEMP, "'+strEmpresas+'") > 0');
        qryDocumentos.Open;

        If Not qryDocumentos.IsEmpty Then
        Begin
          stlMsg.Clear;
          stlMsg.Add('Data Envio: ' + FormatDateTime('DD/MM/YYYY', fNow));
          stlMsg.Add('Assunto   : Efetivação do Movimento Fiscal Pendente');
          stlMsg.Add('');
          stlMsg.Add('Os documentos abaixo estão há mais de '+strDias+' dias lançados no sistema e ainda não foi feita a Efetivação do Movimento Fiscal');
          stlMsg.Add('');
          stlMsg.Add('--------------------------------------------------------------------------------------------------------------------------------------------------------------------------');
          stlMsg.Add('|Documento   |Espécie|Série|Empresa|Cod. For.|Fornecedor                      |Data Doc.   |      Tot. Prod.|        Tot. Doc.|Cod. Transp.|Transp.                       |');
          //                     12       7     5       7         9                               32           12               16                17           12                             30
          stlMsg.Add('--------------------------------------------------------------------------------------------------------------------------------------------------------------------------');
          //          123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
          //                   1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17

          While not qryDocumentos.Eof Do
          Begin
            stlMsg.Add('|' +  fPadR(qryDocumentos.FieldByName('GER_NUMDOC').AsString, 12, ' ') +
                       '|' +  fPadR(qryDocumentos.FieldByName('GER_ESPDOC').AsString, 7, ' ') +
                       '|' +  fPadR(qryDocumentos.FieldByName('GER_SERIE_').AsString, 5, ' ') +
                       '|' +  fPadR(qryDocumentos.FieldByName('GER_CODEMP').AsString, 7, ' ') +
                       '|' +  fPadR(qryDocumentos.FieldByName('GER_CODFOR').AsString, 9, ' ') +
                       '|' +  fPadR(qryDocumentos.FieldByName('FOR_NOMFOR').AsString, 32, ' ') +
                       '|' +  fPadR(qryDocumentos.FieldByName('GER_DTADOC').AsString, 12, ' ') +
                       '|' +  fPadL(FormatFloat('#0.00', qryDocumentos.FieldByName('GER_TOTPRO').AsFloat), 16, ' ') +
                       '|' +  fPadL(FormatFloat('#0.00', qryDocumentos.FieldByName('GER_VLRCON').AsFloat), 17, ' ') +
                       '|' +  fPadR(qryDocumentos.FieldByName('GER_CODTRA').AsString, 12, ' ') +
                       '|' +  fPadR(qryDocumentos.FieldByName('TRA_NOMTRA').AsString, 30, ' ') + '|');
            qryDocumentos.Next;
          End;
          stlMsg.Add('--------------------------------------------------------------------------------------------------------------------------------------------------------------------------');
          msgInt.fEnviaMensagem('Efetivação do Movimento Fiscal Pendente', stlMsg.Text, strLoginUsuarioLogado, qryOperadores.FieldByName('OPE_CODOPE').AsString, 'N','');
        End;
        qryOperadores.Next;
      End;
    Finally
      FreeAndNil(msgInt);
      FreeAndNil(stlMsg);
      FreeAndNil(qryDocumentos);
    End;
  Finally
    FreeAndNil(qryOperadores);
  End;
end;

class function TFuncoesDiarias.fRemoverVendedoresTemporariosClientes(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True;

  Try
    Application.ProcessMessages;

    TfrmAltVendTemp.fRemoverVendedorTemporario(True, Trunc(fNow()), Trunc(fNow()), '');
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TFuncoesDiarias.fRemoverVendedoresTemporariosClientes]');
  End;
end;

class function TFuncoesDiarias.fInsertCFGPAT(pgbProgresso: TcxProgressBar): Boolean;
begin
  If (fCfgSis('PATDIA', varString) = 'N') Then
    Exit(True);
  Result := untFuncoesSimples.fInsertCFGPAT(pgbProgresso);
end;

class function TFuncoesDiarias.fInsereCadRecOS(strSeqEqu, strCodCli, strHistorico: String; fltTxaVal: Double): Boolean;
var
  strTxaPor: String;
begin
  strTxaPor := fCfgSis('TXAPOR', varString);

  try
    Result := fGravaCadRec('untFuncoesDiarias',
                           'INCLUSÃO',
                           fRetSequencial('TXASEQ', VS_strCodEmp, fTamDocCadRec),              // Duplicata
                           'A',                                                                // Parcela
                           0,                                                                  // Sequencial de Baixa
                           'EQ',                                                               // Espécie
                           strCodCli,                                                          // Cliente
                           VS_strCodEmp,                                                       // Empresa
                           strLoginUsuarioLogado,                                              // Vendedor
                           strLoginUsuarioLogado,                                              // Digitador
                           strTxaPor,                                                          // Portador
                           VS_Date,                                                            // Data de Cadastro
                           VS_Date,                                                            // Data de Vencimento
                           fltTxaVal,                                                          // Valor da Duplicata
                           fltTxaVal,                                                          // Valor Original
                           0.0,                                                                // Despesa de Cobrança
                           'N',                                                                // Desconto
                           strHistorico,                                                       // Histórico 1
                           '',                                                                 // Histórico 2
                           '',                                                                 // Portador da Baixa
                           '',                                                                 // Centro de Custo da Baixa
                           '',                                                                 // Operador da Baixa
                           '',                                                                 // Documento da Baixa
                           0.0,                                                                // Valor do Recebimento
                           0,                                                                  // Data do Recebimento
                           'N',
                           '',                                                                 // Código do Evento
                           '',                                                                 // Código Velho (CONVERSÃO)
                           '',                                                                 // Tipo de Fora (Condição de Pagamento)
                           '',                                                                 // Código da Condição de Pagamento
                           False,
                           '',                                                                 // Codigo do Centro de Custo
                           0,                                                                  // Sequencial de Controle
                           0.0,
                           '',
                          '',
                          '',
                          '',
                          0,
                          0,
                          0,
                          0,
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
                          'N',
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
                          '',
                          0,
                          0,
                          0,
                          0,
                          0,
                          0,
                          '',
                          0,
                          'INCLUSÃO',
                          '',
                          '',
                          '',
                          'N',
                          'N',
                          '',
                          '',
                          '',
                          strSeqEqu);
  except
    on E: Exception do
    begin
      fRollback;
      Result := False;
      pMensagensErro(E.Message, '[fInsereCadRecOS]');
    end;
  end;
end;

class function TFuncoesDiarias.fInsertCFGAUX(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := untFuncoesSimples.fInsertCFGAUX(pgbProgresso);
end;

class function TFuncoesDiarias.fInsertTEPPRO(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := untFuncoesSimples.fInsertTEPPRO;
end;

Class function TFuncoesDiarias.fDeleteLogVar(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryLogVar: TUniQuery;
Begin
  Try
    Application.ProcessMessages;

    qryLogVar := fCriaQuery;

    With qryLogVar, SQL Do
    Begin
      Clear;
      Add('DELETE FROM LOGVAR WHERE LOG_DTAPED <> ' + fCurrentDate);
      ExecSQL;
    End;

    FreeAndNil(qryLogVar);

    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFuncoesDiarias.fDeleteLogVar]');
      Result := False;
    End;
  End;

End;

Class function TFuncoesDiarias.fDeleteMnuAce(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryLogVar: TUniQuery;
Begin
  Try
    Application.ProcessMessages;

    qryLogVar := fCriaQuery;

    With qryLogVar, SQL Do
    Begin
      Clear;
      Add('DELETE FROM MNUACE WHERE ACE_HORINI < ' + fCurrentDate(VS_Date - 90));
      ExecSQL;
    End;

    FreeAndNil(qryLogVar);

    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFuncoesDiarias.fDeleteMnuAce]');
      Result := False;
    End;
  End;

End;

Class function TFuncoesDiarias.fDeleteBloDen(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryBloDen: TUniQuery;
Begin
  Try
    Application.ProcessMessages;
    qryBloDen := fCriaQuery;
    try
      qryBloDen.SQL.Clear;
      qryBloDen.SQL.Add('DELETE FROM BLODEN');
      qryBloDen.ExecSQL;
    finally
      FreeAndNil(qryBloDen);
    end;
    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFuncoesDiarias.fDeleteBloDen]');
      Result := False;
    End;
  End;
end;

class function TFuncoesDiarias.fDeleteLogCadCar(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  qryLogVar: TUniQuery;
Begin

  Try
    Application.ProcessMessages;

    qryLogVar := fCriaQuery;
    try
      qryLogVar.SQL.Clear;
      qryLogVar.SQL.Add('DELETE FROM LOGCAR WHERE LOG_DTACAD < ' + fCurrentDate(VS_Date - 120));
      qryLogVar.ExecSQL;
    finally
      FreeAndNil(qryLogVar);
    end ;

    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFuncoesDiarias.fDeleteMnuAce]');
      Result := False;
    End;
  End;

end;

Class function TFuncoesDiarias.fDeleteLogFrm(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryLogFrm: TUniQuery;
Begin
  Try
    Application.ProcessMessages;

    qryLogFrm := fCriaQuery;

    With qryLogFrm, SQL Do
    Begin
      Clear;
      Add('DELETE FROM LOGFRM WHERE LOG_DTALOG < ' + fCurrentDate(VS_Date - 30));
      ExecSQL;
    End;

    FreeAndNil(qryLogFrm);

    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFuncoesDiarias.fDeleteLogFrm]');
      Result := False;
    End;
  End;

End;

Class function TFuncoesDiarias.fDeleteLogTmr(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryLogTmr: TUniQuery;
Begin
  Try
    Application.ProcessMessages;

    qryLogTmr := fCriaQuery;

    With qryLogTmr, SQL Do
    Begin
      Clear;
      Add('DELETE FROM LOGTMR WHERE LOG_INITMR < ' + fCurrentDate(VS_Date - 7));
      ExecSQL;
    End;

    FreeAndNil(qryLogTmr);

    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFuncoesDiarias.fDeleteLogTmr]');
      Result := False;
    End;
  End;

End;

Class function TFuncoesDiarias.fDeleteLogThr(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryLogThr: TUniQuery;
Begin
  Try
    Application.ProcessMessages;

    qryLogThr := fCriaQuery;

    With qryLogThr, SQL Do
    Begin
      Clear;
      Add('DELETE FROM LOGTHR WHERE LOG_INITHR < ' + fCurrentDate(VS_Date - 7));
      ExecSQL;
    End;

    FreeAndNil(qryLogThr);

    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TFuncoesDiarias.fDeleteLogThr]');
      Result := False;
    End;
  End;

End;


{*****************************************************************************}
{* ZERAR LIMITE DE CRÉDITO DO CLIENTE QUANDO A QTD DE MESES DA ÚLTIMA COMPRA *}
{* FOR SUPERIOR AO NÚMERO DE MESES INFORMADO NA CONFIGURAÇÃO DE CLIENTES     *}
{**************************************************************************RL*}
Class function TFuncoesDiarias.fZeraLimteCredito(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strSQL   : String;
    qryLstCli: TUniQuery;
    listUpdate : TList<String>;
    hraHraUpd : TDateTime;
    strAutIncLogCli : String;

  procedure pUpdateClientes;
  begin
    If listUpdate.Count = 0 Then
      Exit;
    fStartTransaction;
    Try
      fExecutaSQL(fTListStringToStr(listUpdate, sLineBreak), True);
      fCommit;
      listUpdate.Clear;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        Raise;
      End;
    End;
    hraHraUpd := fTime();
  end;
Begin
  Try
    Application.ProcessMessages;
    
    qryLstCli := fCriaQuery;
    Try
      strSQL := '';
      strSQL := strSQL + 'SELECT CLI_CODCLI, CLI_LIMCRE FROM CADCLI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CLI_ULTCOM IS NOT NULL ';
      strSQL := strSQL + '  AND CLI_LIMCRE <> 0 ';
      strSQL := strSQL + '  AND DATEDIFF(' + fCurrentDate + ', CLI_ULTCOM) > ' + IntToStr(fCfgSis('QTDMES', varInteger) * 30);
      strSQL := strSQL + '  AND CLI_CODCLI NOT IN (' + IIF(fEmptyStr(VS_strCliFil),'""',VS_strCliFil) + ') ';

      qryLstCli.Close;
      qryLstCli.SQL.Clear;
      qryLstCli.SQL.Add(strSQL);
      qryLstCli.Open;

      If (qryLstCli.IsEmpty) Then
        Exit(True);

      pgbProgresso.Position       := 0;
      pgbProgresso.Properties.Max := qryLstCli.RecordCount;
      Application.ProcessMessages;

      listUpdate := TList<String>.Create;
      Try
        strAutIncLogCli := fRetAutoIncrem('LOGCLI', VS_strCodEmp, qryLstCli.RecordCount);
        hraHraUpd := fTime();

        qryLstCli.First;
        While Not qryLstCli.Eof do
        Begin
          listUpdate.Add('UPDATE CADCLI SET CLI_LIMCRE = 0, CLI_ULTALT = ' + QuotedStr(FormatDateTime('YYYY-MM-DD hh:mm:ss', VS_Date + hraHraUpd)) + ' WHERE CLI_CODCLI = ' + QuotedStr(qryLstCli.FieldByName('CLI_CODCLI').AsString) + ';');
          listUpdate.Add('INSERT INTO LOGCLI (AUTOINCREM, CLI_CODCLI, CLI_DTAALT, CLI_HRAALT, CLI_OPEALT, ' +
                                             'CLI_CPOALT, CLI_INFANC, CLI_INFNOC, CLI_INFANN, CLI_INFNON, ' +
                                             'CLI_AUTOMA, CLI_OPELOG) ' +
                                     'VALUES (' +
                                     '       ' + QuotedStr(strAutIncLogCli) + ', ' +
                                     '       ' + QuotedStr(qryLstCli.FieldByName('CLI_CODCLI').AsString) + ', ' +
                                     '       ' + QuotedStr(FormatDateTime('YYYY-MM-DD', VS_Date)) + ', ' +
                                     '       ' + QuotedStr(FormatDateTime('hh:mm:ss', hraHraUpd)) + ', ' +
                                     '       ' + QuotedStr(fCfgSis('OPEAUT')) + ', ' +
                                     '       ' + QuotedStr('CLI_LIMCRE') + ', ' +
                                     '       ' + QuotedStr('') + ', ' +
                                     '       ' + QuotedStr('') + ', ' +
                                     '       ' + fFloatToStrPonto(qryLstCli.FieldByName('CLI_LIMCRE').AsFloat, 12, 2) + ', ' +
                                     '       ' + '0' + ', ' +
                                     '       ' + QuotedStr('S') + ', ' +
                                     '       ' + QuotedStr(strLoginUsuarioLogado) +
                                     '       );     ' );
          strAutIncLogCli := fNextAutoIncrem(strAutIncLogCli);

          qryLstCli.Next;

          If (qryLstCli.Eof) Or (listUpdate.Count >= 250) Then
            pUpdateClientes;

          pgbProgresso.Position := pgbProgresso.Position + 1;
          Application.ProcessMessages;
        End;

        pUpdateClientes;
      Finally
        FreeAndNil(listUpdate);
      End;

      Result := True;
    Except
      On E : Exception do
      Begin
        Result := False;
        fRollBack;
        pMensagensErro(E.Message, '[Erro ao Gravar o Log]');
      End;
    End;
  Finally
    FreeAndNil(qryLstCli);
  End;
End;

Class function TFuncoesDiarias.fInativaClientePorTempoUltimaCompra(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strSQL   : String;
    strCliPD : String;
    intQtdMes: Integer;
    qryLstCli: TUniQuery;
    listUpdate : TList<String>;
    hraHraUpd : TDateTime;
    strAutIncLogCli : String;

  Function fAtividadePD : String;
    Var
      strSQLCli : String;
      qryTmp : TUniQuery;
  Begin
    Result := '';
    strSQLCli :=             ' SELECT FGO_CODCLI CODCLI,                          ';
    strSQLCli := strSQLCli + '        IFNULL(C.CLI_ULTCOM,0) ULTCOM,              ';
    strSQLCli := strSQLCli + '        DATEDIFF(' + fCurrentDate + ', IFNULL(IF(MAX(FGO_DTAENT) > IFNULL(C.CLI_ULTCOM, 0), ';
    strSQLCli := strSQLCli + '        MAX(FGO_DTAENT), C.CLI_ULTCOM), 0)) DIF     ';
    strSQLCli := strSQLCli + '   FROM FATGOR                                      ';
    strSQLCli := strSQLCli + '  INNER JOIN CADCLI C ON C.CLI_CODCLI = FGO_CODCLI  ';
    strSQLCli := strSQLCli + '  WHERE FGO_ESPDOC = "PD"                           ';
    strSQLCli := strSQLCli + '    AND FGO_JAFATU = "0"                            ';
    strSQLCli := strSQLCli + '  GROUP BY FGO_CODCLI                               ';
    strSQLCli := strSQLCli + ' HAVING MAX(FGO_DTAENT) > ULTCOM AND DIF <= :QTDMES ';

    qryTmp := fCriaQuery;

    Try

      With qryTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQLCli);
        ParamByName('QTDMES').AsInteger := intQtdMes;
        Open;
        First;
        While Not Eof Do
        Begin         
          Result := Result + '"' + FieldByName('CODCLI').AsString + '"';
          Next;
          If (Not Eof) Then
            Result := Result + ',';
        End;
        Close;
      End;

    Finally
      FreeAndNil(qryTmp);
    End;
  End;

  procedure pUpdateClientes;
  begin
    If listUpdate.Count = 0 Then
      Exit;
    fStartTransaction;
    Try
      fExecutaSQL(fTListStringToStr(listUpdate, sLineBreak), True);
      fCommit;
      listUpdate.Clear;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        Raise;
      End;
    End;
    hraHraUpd := fTime();
  end;

Begin
  Try
    Application.ProcessMessages;

    qryLstCli := fCriaQuery;
    Try
      intQtdMes := (fCfgSis('QTDMES', varInteger) * 30);
      strCliPD  := fAtividadePD;

      strSQL := '';
      strSQL := strSQL + 'SELECT CLI_CODCLI FROM CADCLI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '      CLI_ULTCOM IS NOT NULL ';
      strSQL := strSQL + '  AND CLI_STATUS <> "I" ';
      strSQL := strSQL + '  AND DATEDIFF(' + fCurrentDate + ', IFNULL(CLI_ULTCOM, 0)) > ' + IntToStr(intQtdMes);
      strSQL := strSQL + '  AND CLI_CODCLI NOT IN (' + IIF(fEmptyStr(VS_strCliFil),'""',VS_strCliFil) + ') ';
      strSQL := strSQL + '  AND CLI_NOMCLI NOT LIKE "%CONSUMIDOR%" ';
      strSQL := strSQL + '  AND CLI_NOMCLI NOT LIKE "%BALCAO%" ';
      strSQL := strSQL + '  AND CLI_NOMCLI NOT LIKE "%BALCÃO%" ';

      { ESTA CONF. INATIVA CLIENTES DE DERTERMINADA EMPRESA OU TODAS }
      if (fCfgSis('ICLEMP') = 'S') then
        strSQL := strSQL + '  AND CLI_CODEMP = ' + QuotedStr(VS_strCodEmp);

      If Not fEmptyStr(strCliPD) Then
        strSQL := strSQL + '  AND CLI_CODCLI NOT IN (' + strCliPD + ' ) ';

      qryLstCli.Close;
      qryLstCli.SQL.Clear;
      qryLstCli.SQL.Add(strSQL);
      qryLstCli.Open;

      If (qryLstCli.IsEmpty) Then
        Exit(True);

      pgbProgresso.Position       := 0;
      pgbProgresso.Properties.Max := qryLstCli.RecordCount;
      Application.ProcessMessages;

      listUpdate := TList<String>.Create;
      Try
        strAutIncLogCli := fRetAutoIncrem('LOGCLI', VS_strCodEmp, qryLstCli.RecordCount);
        hraHraUpd := fTime();

        qryLstCli.First;
        While Not qryLstCli.Eof do
        Begin
          listUpdate.Add('UPDATE CADCLI SET CLI_STATUS = "I", CLI_ULTALT = ' + QuotedStr(FormatDateTime('YYYY-MM-DD hh:mm:ss', VS_Date + hraHraUpd)) + ' WHERE CLI_CODCLI = ' + QuotedStr(qryLstCli.FieldByName('CLI_CODCLI').AsString) + ';');
          listUpdate.Add('INSERT INTO LOGCLI (AUTOINCREM, CLI_CODCLI, CLI_DTAALT, CLI_HRAALT, CLI_OPEALT, ' +
                                             'CLI_CPOALT, CLI_INFANC, CLI_INFNOC, CLI_INFANN, CLI_INFNON, ' +
                                             'CLI_AUTOMA, CLI_OPELOG) ' +
                                     'VALUES (' +
                                     '       ' + QuotedStr(strAutIncLogCli) + ', ' +
                                     '       ' + QuotedStr(qryLstCli.FieldByName('CLI_CODCLI').AsString) + ', ' +
                                     '       ' + QuotedStr(FormatDateTime('YYYY-MM-DD', VS_Date)) + ', ' +
                                     '       ' + QuotedStr(FormatDateTime('hh:mm:ss', hraHraUpd)) + ', ' +
                                     '       ' + QuotedStr(fCfgSis('OPEAUT')) + ', ' +
                                     '       ' + QuotedStr('CLI_STATUS') + ', ' +
                                     '       ' + QuotedStr('A') + ', ' +
                                     '       ' + QuotedStr('I') + ', ' +
                                     '       ' + '0' + ', ' +
                                     '       ' + '0' + ', ' +
                                     '       ' + QuotedStr('S') + ', ' +
                                     '       ' + QuotedStr(strLoginUsuarioLogado) +
                                     '       );     ' );
          strAutIncLogCli := fNextAutoIncrem(strAutIncLogCli);

          qryLstCli.Next;

          If (qryLstCli.Eof) Or (listUpdate.Count >= 250) Then
            pUpdateClientes;

          pgbProgresso.Position := pgbProgresso.Position + 1;
          Application.ProcessMessages;
        End;

        pUpdateClientes;
      Finally
        FreeAndNil(listUpdate);
      End;

      Result := True;
    Except
      On E : Exception do
      Begin
        Result := False;
        fRollBack;
        pMensagensErro(E.Message, '[Erro ao Gravar o Log]');
      End;
    End;
  Finally
    FreeAndNil(qryLstCli);
  End;
End;

Class function TFuncoesDiarias.fInativaClienteSemNenhumaCompra(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strSQL   : String;
    qryLstCli: TUniQuery;
    listUpdate : TList<String>;
    hraHraUpd : TDateTime;
    strAutIncLogCli : String;

    procedure pUpdateClientes;
    begin
      If listUpdate.Count = 0 Then
        Exit;
      fStartTransaction;
      Try
        fExecutaSQL(fTListStringToStr(listUpdate, sLineBreak), True);
        fCommit;
        listUpdate.Clear;
      Except
        On E: Exception Do
        Begin
          fRollBack;
          Raise;
        End;
      End;
      hraHraUpd := fTime();
    end;

Begin
  Try
    Application.ProcessMessages;

    qryLstCli := fCriaQuery;
    Try
      strSQL := '';
      strSQL := strSQL + 'SELECT CLI_CODCLI FROM CADCLI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '      CLI_ULTCOM IS NULL ';
      strSQL := strSQL + '  AND CLI_STATUS <> "I" ';
      strSQL := strSQL + '  AND DATEDIFF(' + fCurrentDate + ', IFNULL(CLI_DTACAD, 0)) > ' + IntToStr(fCfgSis('DIAINA', varInteger));
      strSQL := strSQL + '  AND CLI_CODCLI NOT IN (' + IIF(fEmptyStr(VS_strCliFil),'""',VS_strCliFil) + ') ';
      strSQL := strSQL + '  AND CLI_NOMCLI NOT LIKE "%CONSUMIDOR%" ';
      strSQL := strSQL + '  AND CLI_NOMCLI NOT LIKE "%BALCAO%" ';
      strSQL := strSQL + '  AND CLI_NOMCLI NOT LIKE "%BALCÃO%" ';

      { ESTA CONF. INATIVA CLIENTES DE DERTERMINADA EMPRESA OU TODAS }
      if (fCfgSis('ICLEMP') = 'S') then
        strSQL := strSQL + '  AND CLI_CODEMP = ' + QuotedStr(VS_strCodEmp);

      qryLstCli.Close;
      qryLstCli.SQL.Clear;
      qryLstCli.SQL.Add(strSQL);
      qryLstCli.Open;

      If (qryLstCli.IsEmpty) Then
        Exit(True);

      pgbProgresso.Position       := 0;
      pgbProgresso.Properties.Max := qryLstCli.RecordCount;
      Application.ProcessMessages;

      listUpdate := TList<String>.Create;
      Try
        strAutIncLogCli := fRetAutoIncrem('LOGCLI', VS_strCodEmp, qryLstCli.RecordCount);
        hraHraUpd := fTime();

        qryLstCli.First;
        While Not qryLstCli.Eof do
        Begin
          listUpdate.Add('UPDATE CADCLI SET CLI_STATUS = "I", CLI_ULTALT = ' + QuotedStr(FormatDateTime('YYYY-MM-DD hh:mm:ss', VS_Date + hraHraUpd)) + ' WHERE CLI_CODCLI = ' + QuotedStr(qryLstCli.FieldByName('CLI_CODCLI').AsString) + ';');
          listUpdate.Add('INSERT INTO LOGCLI (AUTOINCREM, CLI_CODCLI, CLI_DTAALT, CLI_HRAALT, CLI_OPEALT, ' +
                                             'CLI_CPOALT, CLI_INFANC, CLI_INFNOC, CLI_INFANN, CLI_INFNON, ' +
                                             'CLI_AUTOMA, CLI_OPELOG) ' +
                                     'VALUES (' +
                                     '       ' + QuotedStr(strAutIncLogCli) + ', ' +
                                     '       ' + QuotedStr(qryLstCli.FieldByName('CLI_CODCLI').AsString) + ', ' +
                                     '       ' + QuotedStr(FormatDateTime('YYYY-MM-DD', VS_Date)) + ', ' +
                                     '       ' + QuotedStr(FormatDateTime('hh:mm:ss', hraHraUpd)) + ', ' +
                                     '       ' + QuotedStr(fCfgSis('OPEAUT')) + ', ' +
                                     '       ' + QuotedStr('CLI_STATUS') + ', ' +
                                     '       ' + QuotedStr('A') + ', ' +
                                     '       ' + QuotedStr('I') + ', ' +
                                     '       ' + '0' + ', ' +
                                     '       ' + '0' + ', ' +
                                     '       ' + QuotedStr('S') + ', ' +
                                     '       ' + QuotedStr(strLoginUsuarioLogado) +
                                     '       );     ' );
          strAutIncLogCli := fNextAutoIncrem(strAutIncLogCli);

          qryLstCli.Next;

          If (qryLstCli.Eof) Or (listUpdate.Count >= 250) Then
            pUpdateClientes;

          pgbProgresso.Position := pgbProgresso.Position + 1;
          Application.ProcessMessages;
        End;

        pUpdateClientes;
      Finally
        FreeAndNil(listUpdate);
      End;

      Result := True;
    Except
      On E : Exception do
      Begin
        Result := False;
        fRollBack;
        pMensagensErro(E.Message, '[Erro ao Gravar o Log]');
      End;
    End;
  Finally
    FreeAndNil(qryLstCli);
  End;
End;

procedure pGeraTransferencias;
  Var
    objPreparaGer: TPreparaGeracaoTE;
begin
  objPreparaGer := TPreparaGeracaoTE.Create(fGravaFatGor, fGravaFatDor);
  objPreparaGer.fGeraPedidosVenda;
  FreeAndNil(objPreparaGer);
end;

procedure pGeraRequisicoesCompra;
  Var
    objRequisicoesCompra: TPreparaRequisicaoCompra;
begin
  Try
    objRequisicoesCompra := TPreparaRequisicaoCompra.Create();
    objRequisicoesCompra.pGerarRequisicoesMultiLoja();
  Finally
    FreeAndNil(objRequisicoesCompra);
  End;
end;

procedure pInativaClientePorTempoUltimaCompra;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, atualizando status dos clientes...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fInativaClientePorTempoUltimaCompra;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

procedure pInativaClienteSemNenhumaCompra;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, atualizando status dos clientes sem compra...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fInativaClienteSemNenhumaCompra;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

procedure pAtualizarTipoPrecoTransferenciaCONEMP;
begin
  TFuncoesDiarias.fAtualizaTipoPrecoTransferenciaCONEMP(nil);
end;

procedure pAtualizarRegistrosTEPREV;
begin
  TFuncoesDiarias.fInsertTEPREV(nil);
end;

procedure pAtualizarRegistrosTEPPRO;
begin
  TFuncoesDiarias.fInsertTEPPRO(nil);
end;

procedure pVerificarNovasConfiguracoes;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, Verificando novas configurações ...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fVerificarNovasConfiguracoes;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
end;

procedure pAtualizarRegistrosCFGPAT;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, Listando configurações de Paths para validação ...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fInsertCFGPAT;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
end;

procedure pAtualizarRegistrosCFGAUX;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, Atualizando tabela auxiliar das configurações ...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fInsertCFGAUX;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
end;

procedure pAtualizaTaxaArmazenamentoOS;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, Atualizando taxa de armazenamento dos equipamentos ...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fGerarTaxaArmazenamentoOS;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
end;

procedure pGerarInterfaceAnalitica;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, enviando interface analítica (NETPOINTS)...';
  frmGravando.fExecutarAcao := TNetpoints.fGerarInterfaceAnalitica;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
end;

procedure pGerarInterfaceConciliacao;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, verificando conciliação de acúmulo e resgate (NETPOINTS)...';
  frmGravando.fExecutarAcao := TNetpoints.fGerarInterfaceConciliacao;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

{*****************************************************************************}
{* ZERAR LIMITE DE CRÉDITO DO CLIENTE QUANDO A QTD DE MESES DA ÚLTIMA COMPRA *}
{* FOR SUPERIOR AO NÚMERO DE MESES INFORMADO NA CONFIGURAÇÃO DE CLIENTES     *}
{**************************************************************************RL*}
procedure pZerarLimteCredito;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, atualizando limite de crédito...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fZeraLimteCredito;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

Procedure pDeleteLogRdZ;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, Otimizando Log de Reduções Z - Impressoras Fiscais...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fDeleteLogRdZ;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

procedure pDeletarLogsTxtAntigos;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := 'Aguarde, Otimizando Logs Txt \temp\log\';
    frmGravando.fExecutarAcao := TFuncoesDiarias.fDeletarLogsTxtAntigos;
    frmGravando.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure pDeletarRegistrosSqlErrAntigos;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := 'Aguarde, Deletando SQLERR antigos';
    frmGravando.fExecutarAcao := TFuncoesDiarias.fDeleteSqlErr;
    frmGravando.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure pDeletarRegistrosLogRefAntigos;
begin
  If (Not fTabelaExiste('LOGREF', True)) Then
    Exit;
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := 'Aguarde, Deletando LOGREF antigos';
    frmGravando.fExecutarAcao := TFuncoesDiarias.fDeleteLogRef;
    frmGravando.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

Procedure pDeleteLogLck;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, Otimizando Log de Travas Automáticas e Manuais...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fDeleteLogLck;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

Procedure pDeleteFrmRep;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, Otimizando Log de formulários replicação...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fDeleteFrmRep;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

Procedure pDeleteCadMsg;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, organizando liberações remotas - cadastro de mensagens...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fDeleteCadMsg;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

Procedure pDeleteLogCadCar;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, organizando log do cadastro de cartões...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fDeleteLogCadCar;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

procedure pDeleteBloDen;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, deletando consultas clientes denegados...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fDeleteBloDen;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

Procedure pDeleteLogLogTef;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, organizando log do Tef...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fDeleteLogLogTef;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

Procedure pDeleteLogLogErrPinPad;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, organizando log do PinPad...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fDeleteLogLogErrPinPad;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

Procedure pDeleteApp_CadMsg;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, organizando liberações remotas - cadastro de mensagens APP...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fDeleteApp_CadMsg;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

Procedure pDeleteImagensEmailSemUso;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, removendo imagens de Emails sem uso...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fDeleteImagensEmailSemUso;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

Procedure pRemoverVendedoresTemporariosClientes;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, removendo vendedores temporários clientes...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fRemoverVendedoresTemporariosClientes;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

Procedure pDeleteLogVar;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, organizando liberações remotas - logs de liberação...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fDeleteLogVar;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

Procedure pDeleteMnuAce;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, organizando menus recentemente acessados...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fDeleteMnuAce;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

Procedure pDeleteLogFrm;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, organizando log de formulários acessados...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fDeleteLogFrm;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

Procedure pDeleteLogTmr;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, organizando log de timers...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fDeleteLogTmr;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

Procedure pDeleteLogThr;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, organizando log de threads...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fDeleteLogThr;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

Procedure pTransfereClienteVendedorCarteiraEmpresaVen;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, atualizando carteira vendedor...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fTransfereClienteVendedorCarteiraEmpresaVen;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

Procedure pTransfereClienteVendedorCarteiraEmpresaRep;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, atualizando carteira representante...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fTransfereClienteVendedorCarteiraEmpresaRep;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

Procedure pTransfereClienteVen_Rep_CarteiraEmpresaCRM;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, atualizando carteira vendedor/representante...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fTransfereClienteVen_Rep_CarteiraEmpresaCRM;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

procedure pApagarNfeTempo;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, atualizando carteira representante...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fApagarNfeTempo;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
end;

procedure pAtualizarDataProximoEnvioGatilhosInformacao;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.lblGravando.Caption := 'Aguarde, atualizando data próximo envio gatilho de informação...';
  frmGravando.fExecutarAcao := TFuncoesDiarias.fAtualizarDataProximoEnvioGatilhosInformacao;
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
end;

procedure pDesativaNFCeOffLine;
  Var
    qryAux : TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add(' UPDATE CFGSIS ');
    qryAux.SQL.Add('    SET SIS_VALCFG = "N" ');
    qryAux.SQL.Add('  WHERE SIS_CODEMP = :CODEMP ');
    qryAux.SQL.Add('    AND SIS_CODCFG = "CFG_USAOFF" ');
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
End;

class function TFuncoesDiarias.fApagaPDFDireto(pgbProgresso: TcxProgressBar): Boolean;
Var
   SearchFile: TSearchRec;
   FindResult: Integer;
   strPatPDF : String;
begin

  try
    strPatPDF  := ExtractFilePath(Application.ExeName) + PASTA_PDF_IMPRESSAO_DIRETA + '\';
    FindResult := FindFirst(strPatPDF + '*.pdf', faArchive, SearchFile);

    While FindResult = 0 do
    begin
      TFile.Delete(strPatPDF + SearchFile.name);

      FindResult := FindNext(SearchFile)
    end;

    Result := True;

  finally
    SysUtils.FindClose(SearchFile);
  end;

end;

Procedure pApagaFDFdDireto;
  Var
    frmGravando: TfrmGravando;
Begin
  TfrmGravando.fExecuta(TFuncoesDiarias.fApagaPDFDireto, frmGravando, 'Apagando arquivos PDF da impressão direta...')
End;

Procedure pMensagenEfetivacaoMovimentoFiscal;
  Var
    frmGravando: TfrmGravando;
Begin
  TfrmGravando.fExecuta(TFuncoesDiarias.fMensagenEfetivacaoMovimentoFiscal, frmGravando, 'Gerando mensagens de documentos sem efetivação de Movimento Fiscal...')
End;

Procedure pMensagemContratoLocacaoAVencer;
  Var
    frmGravando: TfrmGravando;
Begin
  TfrmGravando.fExecuta(TFuncoesDiarias.fMensagemContratoLocacaoAVencer, frmGravando, 'Gerando mensagens de Contratos de Locação a Vencer...')
End;

Procedure pMensagemCertificadoDigital;
  Var
    frmGravando: TfrmGravando;
Begin
  TfrmGravando.fExecuta(TFuncoesDiarias.fMensagemCertificadoDigital, frmGravando, 'Gerando mensagens referente ao certificado digital...')
End;

Procedure pMensagemMediaDeAtrasoClientes;
  Var
    frmGravando: TfrmGravando;
Begin
  TfrmGravando.fExecuta(TFuncoesDiarias.fMensagemMediaDeAtrasoClientes, frmGravando, 'Gerando mensagens de médias de atrasos dos clientes...')
End;

Procedure pFuncoesDiarias(blnAutoGiro: Boolean = False);
  Var
    strMsgDivergencia: String;
    curDateTimeFromApi: TDateTime;
    dtaDtaTmp: TDate;
    ctrConEnt: TControleEntrega;
Begin
  {*******************************************}
  {* CARREGA O VETOR PROCOD COM AS TABELAS   *}
  {****************************************JC*}
  pVerificaProCod;

  dtaDtaTmp := fCampoTabela('APG_DTAAPG','APGTMP',[],[], True, '', Nil, True);//blnUsarMax: nao depender da ordem das linhas

  VS_ExecutandoFuncoesDiarias := (dtaDtaTmp <> VS_Date);
  Try
    fAjustaDataSistema;//Retorna a data do servidor (Linux onde mysql instalado)

    If (dtaDtaTmp <> VS_Date) And fCfgSis('VERDTA', varBoolean) Then
    Begin
      If fTryGetUTCDatetimeFromApi(curDateTimeFromApi) And (Abs(HoursBetween(VS_Date + fTime(), curDateTimeFromApi)) > 12) Then
      Begin
        TThreadFinalizarAutcomMonitor.Monitorar;
        strMsgDivergencia :=
        '------------------------------------------------------------------------------------------------------' + #13#10 +
        'Inconsistência de data e hora ao executar funções diárias do sistema.'                                  + #13#10 +
          '------------------------------------------------------------------------------------------------------' + #13#10 +
          'Data e hora retornada do servidor de banco de dados.: ' + DateTimeToStr(VS_Date + fTime())              + #13#10 +
          'Data e hora de referência de api externa (GMT/UTC)..: ' + DateTimeToStr(curDateTimeFromApi)             + #13#10 +
          'Tolerância máxima de divergência....................: 12 horas           '                              + #13#10 +
          '------------------------------------------------------------------------------------------------------' + #13#10 +
          '*** Entre em contato com a Citel ***'                                                                   + #13#10 +
          '------------------------------------------------------------------------------------------------------';
        pGravarErro(True, 'Inconsistência de data e hora ao executar funções diárias do sistema', strMsgDivergencia);
        pMensagemSonora(strMsgDivergencia, False, 12, 800);
        If Not TerminateProcess(GetCurrentProcess, 0) Then
          Application.Terminate;
      End;
    End;

    pAtualizaApgTmp;

    {*****************************************}
    {* ZERAR LIMITE DE CRÉDITO DO CLIENTE    *}
    {**************************************RL*}
    If (dtaDtaTmp <> VS_Date) And (fCfgSis('ZERCRE', varBoolean)) Then
    Begin
      pZerarLimteCredito;
    End;

    If (dtaDtaTmp <> VS_Date) And (fCfgSis('INACLI', varBoolean)) Then
    Begin
      pInativaClientePorTempoUltimaCompra;
      pInativaClienteSemNenhumaCompra;
    End;

    If (dtaDtaTmp <> VS_Date) Then
    Begin

      If (fTransferenciaDoClienteParaCarteiraEmpresa.ClienteNaoCompra_X_Dias) Then
      Begin
        pTransfereClienteVendedorCarteiraEmpresaVen;
        pTransfereClienteVendedorCarteiraEmpresaRep;
      End;

      If (fTransferenciaDoClienteParaCarteiraEmpresa.ClienteNaoTemOcorrenciaCRM_X_Dias) Then
        pTransfereClienteVen_Rep_CarteiraEmpresaCRM;

    End;

    If (dtaDtaTmp <> VS_Date) Then
    Begin
      pAtualizarRegistrosCFGPAT;
      pAtualizarRegistrosCFGAUX;
      pVerificarNovasConfiguracoes;
      pDeleteCadMsg;
      pDeleteApp_CadMsg;
      pDeleteLogVar;
      pDeleteMnuAce;
      pDeleteLogFrm;
      pDeleteLogTmr;
      pDeleteLogThr;
      pDeleteLogRdZ;
      pDeleteImagensEmailSemUso;
      pRemoverVendedoresTemporariosClientes();
      pDeleteLogLck;
      pDeleteFrmRep;
      pApagaFDFdDireto;
      pMensagenEfetivacaoMovimentoFiscal;
      pDeleteLogCadCar;
      pDeleteLogLogTef;
      pDeleteLogLogErrPinPad;

      pAtualizaTaxaArmazenamentoOS;

      If (fTabelaExiste('NFE_TEMPO')) Then
        pApagarNfeTempo;

      pMensagemCertificadoDigital;
      pDeleteBloDen;
      pMensagemContratoLocacaoAVencer;
      pMensagemMediaDeAtrasoClientes;
      pAtualizarDataProximoEnvioGatilhosInformacao;
      RemoverLckAtcMonitorExtratoCobranca;
      pDeletarLogsTxtAntigos;
      pDeletarRegistrosSqlErrAntigos;
      pDeletarRegistrosLogRefAntigos;
    End;

    {*****************************************}
    {* ZERA O SEQUENCIAL DO MOVBAN SE NECES- *}
    {* SÁRIO                                 *}
    {**************************************MV*}
    pZeraCodigoMovBan(blnAutoGiro);

    {*******************************************}
    {* VERIFICA ENTREGAS DO SISTEMA            *}
    {****************************************MV*}
    If (fCfgSis('CONENT', varBoolean)) And
       (fCfgSis('TIPSAB') = 'M')       Then //TIPO DE ABASTECIMENTO = MANUAL
    Begin
      ctrConEnt := TControleEntrega.Create(nil);
      ctrConEnt.pVerificaEntregas;
      FreeAndNil(ctrConEnt);
    End;

    If fTabelaExiste('TEPREV', True) And fCampoExiste('CONEMP', 'CON_CODTEP', True) Then
    Begin
      pAtualizarRegistrosTEPREV;
      pAtualizarTipoPrecoTransferenciaCONEMP;
    End;

    If fTabelaExiste('TEPPRO', True) And fCampoExiste('CONEMP', 'CON_TEPPRO', True) Then
      pAtualizarRegistrosTEPPRO;

    if not fCfgSis('UTIFEC',varBoolean) then
      pMontaInventarioFisico;

    If fCfgSis('UTINPS', varBoolean) Then
    Begin
      pGerarInterfaceAnalitica;
      pGerarInterfaceConciliacao;
    End;

    If (dtaDtaTmp <> VS_Date) Then
      pDesativaNFCeOffLine;

    If dtaDtaTmp <> VS_Date Then
      pVerificaExpiracaoSenhasOperadores;
  Finally
    VS_ExecutandoFuncoesDiarias := False;
  End;

End;

Function fTransferenciaDoClienteParaCarteiraEmpresa : TMotivoTransferenciaCliente;
Var
  LConfig : String;
Begin

  FillChar(Result, SizeOf(Result), #0);
  LConfig := fCfgSis('TRFCAR', varString);

  Result.ClienteNaoCompra_X_Dias           := LConfig[Low(LConfig)]  = 'S';
  Result.ClienteNaoTemOcorrenciaCRM_X_Dias := IIF(LConfig.Length > 1, (LConfig[High(LConfig)] = 'S'), False);

End;

procedure RemoverLckAtcMonitorExtratoCobranca;
Begin
  fLock_Unlock('MONITOR_EXTRATO_COBRANCA_ATIVADO',
               False,
               False,
               False,
               '',
               False,
               'MONITOR_EXTRATO_COBRANCA_ATIVADO');

End;

Class Function TFuncoesDiarias.fTransfereClienteVendedorCarteiraEmpresa(strVenRep: String; pgbProgresso: TcxProgressBar): Boolean;
Var
  strSQL   : String;
  strCodVen: String;
  strDiaTol: String;
  strCampo : String;
  qryCli   : TUniQuery;
  LogAltCadCli  : TLogAltCadCli;
Begin
  LogAltCadCli := TLogAltCadCli.Create(nil);
  qryCli := fCriaQuery(Nil);

  Try
    Try
      Result := True;

      Application.ProcessMessages;

      strDiaTol := fCfgSis('TRFDIA', varString);

      If (strVenRep = 'VEN') Then
      Begin
        strCodVen := fCfgSis('TRFVEN', varString);
        strCampo := 'CLI_CODVEN';
      End
      Else
      Begin
        strCodVen := fCfgSis('TRFREP', varString);
        strCampo := 'CLI_CODREP';
      End;

      If (fEmptyStr(fRetNomeOperador(strCodVen))) Then
        Exit;

      strSQL := '';
      strSQL := strSQL + 'SELECT AUTOINCREM, CLI_CODCLI, CLI_ULTCOM, CLI_CODVEN, CLI_CODREP ';
      strSQL := strSQL + 'FROM CADCLI ';
      strSQL := strSQL + 'WHERE DATEDIFF(' + fCurrentDate + ', CLI_ULTCOM) > :DIATOL ';
      strSQL := strSQL + '  AND CLI_ULTCOM IS NOT NULL ';
      strSQL := strSQL + '  AND ' + strCampo + ' <> :CODVEN ';

      qryCli.Close;
      qryCli.SQL.Clear;
      qryCli.SQL.Add(strSQL);
      qryCli.ParamByName('DIATOL').AsInteger := StrToIntDef(strDiaTol, 0);
      qryCli.ParamByName('CODVEN').AsString := strCodVen;
      qryCli.Open;

      if (not qryCli.IsEmpty) then
      begin
        qryCli.First;

        while not qryCli.Eof do
        begin
          LogAltCadCli.pLogAdd('CADCLI', ['AUTOINCREM'], 'CLI_CODCLI = ' + QuotedStr(qryCli.FieldByName('CLI_CODCLI').AsString));

          qryCli.Edit;
          qryCli.FieldByName(strCampo).AsString := strCodVen;
          qryCli.Post;

          LogAltCadCli.UltCompra.AddOrSetValue(strCampo, qryCli.FieldByName('CLI_ULTCOM').AsDateTime);
          LogAltCadCli.pProcessarLogs;
          LogAltCadCli.pClearDataSets;

          qryCli.Next;
        end;
      end;

      Result := True;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fTransfereClienteVendedorCarteiraEmpresa]');
        Result := False;
      End;
    End;
  Finally
    FreeAndNil(qryCli);
    FreeAndNil(LogAltCadCli);
  End;
End;

Class Function TFuncoesDiarias.fTransfereClienteVendedorCarteiraEmpresaVen(pgbProgresso: TcxProgressBar): Boolean;
Begin
  Result := fTransfereClienteVendedorCarteiraEmpresa('VEN', pgbProgresso);
End;

class function TFuncoesDiarias.fTransfereClienteVen_Rep_CarteiraEmpresa(pgbProgresso: TcxProgressBar) : Boolean;
Var
  strCodVen : String;
  strCodRep : String;
  strDiaTol : String;
  qryCli    : TUniQuery;
  qryCrm    : TUniQuery;

  Function fRetComandoSQLClientesSemMovimentacaoCRM : String;
  Begin

    Result := 'SELECT                    ' +
              '  C.CLI_CODCLI AS CODCLI, ' +
              '  C.CLI_CODVEN AS CODVEN, ' +
              '  C.CLI_CODREP AS CODREP  ' +
              'FROM           ' +
              '  CADCLI C     ' +
              'WHERE          ' +
              '  (DATEDIFF(CURRENT_DATE, (SELECT MAX(O.OCO_DTAINC) FROM MOVOCO O WHERE O.OCO_CODCLI = C.CLI_CODCLI)) > :DIATOL) AND ' +
              '  (DATEDIFF(CURRENT_DATE, (SELECT MAX(H.HIS_DTAINC) FROM MOVOCO O INNER JOIN HISOCO H ON (H.HIS_CODOCO = O.OCO_CODOCO) WHERE O.OCO_CODCLI = C.CLI_CODCLI)) > :DIATOL) ';

    If Not strCodVen.IsEmpty Then
      Result := Result + '  AND C.CLI_CODVEN <> ' + strCodVen.QuotedString;

    If Not strCodRep.IsEmpty Then
      Result := Result + '  AND C.CLI_CODREP <> ' + strCodRep.QuotedString;

  End;

  Function fRetComandoSQLUpdate : String;
  Begin

    Result := '';
    Result := Result + 'UPDATE   ';
    Result := Result + '  CADCLI ';
    Result := Result + 'SET      ';

    If Not strCodVen.IsEmpty Then
      Result := Result + '  CLI_CODVEN = :CODVEN ' + IIF(Not strCodRep.IsEmpty, ',', '');

    If Not strCodRep.IsEmpty Then
      Result := Result + '  CLI_CODREP = :CODREP ';

    Result := Result + 'WHERE    ';
    Result := Result + '  CLI_CODCLI = :CODCLI ';

  End;

Begin

  Result := True;

  strDiaTol := fCfgSis('TRFCRM', varString);
  strCodVen := fCfgSis('TRFVEN', varString);
  strCodRep := fCfgSis('TRFREP', varString);

  If Not VS_strHabilitarCRM Then
    Exit;

  If (fRetNomeOperador(strCodVen).IsEmpty) And
     (fRetNomeOperador(strCodRep).IsEmpty) Then
    Exit;

  qryCli := fCriaQuery(Nil);
  qryCrm := fCriaQuery(Nil);

  Try

    qryCrm.Close;
    qryCrm.SQL.Clear;
    qryCrm.SQL.Add(fRetComandoSQLClientesSemMovimentacaoCRM);
    qryCrm.ParamByName('DIATOL').AsInteger := StrToIntDef(strDiaTol, 0);
    qryCrm.Open;

    pgbProgresso.Properties.Max := qryCrm.RecordCount;
    pgbProgresso.Position       := 0;

    Try

      fStartTransaction;

      qryCrm.First;
      While Not qryCrm.Eof Do
      Begin

        qryCli.Close;
        qryCli.SQL.Clear;
        qryCli.SQL.Add(fRetComandoSQLUpdate);
        qryCli.ParamByName('CODCLI').AsString := qryCrm.FieldByName('CODCLI').AsString;

        If Not strCodVen.IsEmpty Then
        Begin

          qryCli.ParamByName('CODVEN').AsString := strCodVen;

          pGeraLogCliente(qryCrm.FieldByName('CODCLI').AsString,
                          'CLI_CODVEN',
                          qryCrm.FieldByName('CODVEN').AsString,
                          strCodVen);

        End;

        If Not strCodRep.IsEmpty Then
        Begin

          qryCli.ParamByName('CODREP').AsString := strCodRep;

          pGeraLogCliente(qryCrm.FieldByName('CODCLI').AsString,
                          'CLI_CODREP',
                          qryCrm.FieldByName('CODREP').AsString,
                          strCodRep);

        End;

        qryCli.ExecSQL;

        Application.ProcessMessages;
        pgbProgresso.Position := pgbProgresso.Position +1;
        qryCrm.Next;

      End;

      fCommit;
      Result := True;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fTransfereClienteVen_Rep_CarteiraEmpresa]');
        Result := False;
      End;
    End;

  Finally

    If Assigned(qryCli) Then
      FreeAndNil(qryCli);

    If Assigned(qryCrm) Then
      FreeAndNil(qryCrm);

  End;

End;

class function TFuncoesDiarias.fTransfereClienteVen_Rep_CarteiraEmpresaCRM(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := fTransfereClienteVen_Rep_CarteiraEmpresa(pgbProgresso);
end;

class function TFuncoesDiarias.fVerificarNovasConfiguracoes(pgbProgresso: TcxProgressBar): Boolean;
const
  MSG_PROGRESSO = 'Aguarde, Verificando novas configurações da empresa %s (%s) ...';
var
  intContador: Integer;
  qryEmpresas: TUniQuery;
  qryCodCfg: TUniQuery;
  dicCodCfg: TDictionary<string, boolean>;
  strCodCfg: String;

  procedure pProgresso;
  begin
    if (intContador mod 50 = 0) or (pgbProgresso.PercentDone > 95) then
    begin
      pgbProgresso.Position := Succ(intContador);
      pInformacao(Format(MSG_PROGRESSO, [qryEmpresas.FieldByName('SRV_CODEMP').AsString, pgbProgresso.PercentDone.ToString + '%']), pgbProgresso);
    end;
  end;

begin
  qryEmpresas := fCriaQuery(nil);
  dicCodCfg := TDictionary<string, boolean>.Create;
  try
    qryEmpresas.SQL.Text := 'SELECT * FROM EMPRESAS_NESTE_SERVIDOR';
    qryEmpresas.Open;

    qryCodCfg := fCriaQuery(nil);
    Try
      qryCodCfg.SQL.Text := 'SELECT CONCAT(SIS_CODEMP,SIS_CODCFG) FROM CFGSIS ORDER BY SIS_CODEMP, SIS_CODCFG';
      qryCodCfg.Open;
      qryCodCfg.First;
      While Not qryCodCfg.Eof Do
      Begin
        dicCodCfg.AddOrSetValue(Trim(AnsiUpperCase(qryCodCfg.Fields[0].Text)), True);
        qryCodCfg.Next;
      End;
    Finally
      FreeAndNil(qryCodCfg);
    End;

    if not Assigned(arrCamposCfg) then
      TfrmCfgRepositorio.pMontaArrConfiguracoes();

    qryEmpresas.First;
    while not qryEmpresas.Eof do
    begin
      pgbProgresso.Properties.Max := Length(arrCamposCfg);
      for intContador := 0 to Length(arrCamposCfg) - 1 do
      begin
        strCodCfg := Trim(AnsiUpperCase(Copy(arrCamposCfg[intContador].strCodCfg, 5, 10)));

        If dicCodCfg.ContainsKey(Trim(AnsiUpperCase(qryEmpresas.FieldByName('SRV_CODEMP').AsString+'CFG_'+strCodCfg))) Then
        Begin
          pProgresso;
          Continue;
        End;

        fCfgSisL(strCodCfg, varString, qryEmpresas.FieldByName('SRV_CODEMP').AsString, nil, False);
        pProgresso;
      end;
      qryEmpresas.Next;
    end;
    Result := True;
  finally
    FreeAndNil(qryEmpresas);
    FreeAndNil(dicCodCfg);
  end;
end;

Class Function TFuncoesDiarias.fTransfereClienteVendedorCarteiraEmpresaRep(pgbProgresso: TcxProgressBar): Boolean;
Begin
  Result := fTransfereClienteVendedorCarteiraEmpresa('REP', pgbProgresso);
End;

procedure pVerificaExpiracaoSenhasOperadores;
begin
  Try
    If fCfgSis('EXPSEN', varInteger) <= 0 Then
      Exit;

    If Not fExpirarSenhasVencidasOperadores(VS_strCodEmp) Then
      fMensagem('Aviso', 'A verificação de expiração de senhas não pôde ser concluída.', ['&Ok']);

  Except
    On E: Exception Do
    Begin
      Raise Exception.CreateFmt('Erro no processo de Expiração de Senhas: %s ', [E.Message]);
    End;
  End;
end;

end.
