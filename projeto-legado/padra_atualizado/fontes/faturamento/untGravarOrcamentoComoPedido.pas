unit untGravarOrcamentoComoPedido;

interface

uses Classes, untFuncFat, untFuncFatTypes, EditFocus, MaskEditFocus, Uni,
  cxProgressBar, stdCtrls, Forms, SysUtils, Windows, Graphics, TypInfo, UniClientDataSet,
  Faturamento.Classes.TValidarVenda, untConstantes, Variants, untMsgLiberacao;

Type
  TGravarOrcamentoComoPedido = class(TComponent)
    private
      fatVenda : TFatVenda;
      FValidarPedido: TValidarPedido;

      FNumOrc: String;
      FEmpOrc: String;

      FMemoLog: TMemo;
      FLabelInf: TLabel;
      FProgresso: TcxProgressBar;

      FBloqueio: Boolean;
      strInfoProcessamento: String;
      FblnOrigemCrm: Boolean;

      procedure pInserirItemServico;
      function fGetChaveBloqueio: String;
      function fGetSQLOrcamento: String;
      function fPodeCarregarOrcamento: Boolean;
      procedure pOnProcessaItem(const item: TDadosFechamento; index, count: Integer; AInfo: String = '');
      procedure SetProgresso(const Value: TcxProgressBar);
      procedure pRegistrarProgresso(strTexto: String; intAtual, intFinal: Integer);

      function AtualizaValorDoPix: Boolean;
    public
      qryFatGor: TUniQuery;

      function fPedeLojasTE: Boolean;
      function fPedeLojasColorantesTE: Boolean;
      function fValidacoesFinanceiras: Boolean;
      function fValidarEstoque: Boolean;
      function fProcessarRequisicaoCompra: Boolean;
      function fCarregarOrcamento: Boolean;
      function fItensSemEstoqueParaCorte: Boolean;
      function fDefineAbastecimentoItens(blnPerguntaSeDesejaDesmembrar:Boolean = False): Boolean;
      function fCarregarMatrizItens: Boolean;
      function fCalcularTotalVenda(blnCalcularPeso: Boolean = True): Boolean;

      function fDigitarDadosPedido: Boolean;
      function fDigitarDadosPedidoCompra: Boolean;

      function fGravarPedido: Boolean;
      procedure pTravasNaConversaoORPD;
      function fAbaterCreditosAutomaticamente(const fltTotalCadRec : Double): Boolean;

      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      property strNumOrc: String Read FNumOrc Write FNumOrc;
      property strEmpOrc: String Read FEmpOrc Write FEmpOrc;

      property objVenda : TFatVenda Read fatVenda;
      property objValidarPedido: TValidarPedido Read FValidarPedido;

      property blnBloqueio: Boolean Read FBloqueio write FBloqueio;
      property mmoInformacao: TMemo Read FMemoLog Write FMemoLog;
      property pgbProgresso: TcxProgressBar Read FProgresso Write SetProgresso;
      property lblInformacao: TLabel Read FLabelInf write FLabelInf;
      property blnOrigemCrm: Boolean Read FblnOrigemCrm write FblnOrigemCrm;
  end;

implementation

uses untGravando, untFuncoesSimples, untFuncoes, Data.DB, untTypesSistema,
  untAdiantamentoCliente, untFatRequisicaoCompras, untFatgor;

{ TGravarOrcamentoComoPedido }

function TGravarOrcamentoComoPedido.AtualizaValorDoPix: Boolean;
begin
  Result := True;

  If Not fatVenda.DadosPixDaVenda.GerarPixDaVenda Then
    Exit;

  If fatVenda.DadosPixDaVenda.ValorDoPix > 0 Then
    Exit;

  fatVenda.DadosPixDaVenda.ValorDoPix := fatVenda.fltTotGer;
  If fCfgSis('USABRI', varBoolean) Then
  Begin
    If fatVenda.fltTotProBri > 0 Then
    Begin
      fatVenda.DadosPixDaVenda.ValorDoPix := fFormataFloat(fatVenda.DadosPixDaVenda.ValorDoPix -
                                                           fatVenda.fltTotProBri, 2);

      Result := fFormataFloat(fatVenda.DadosPixDaVenda.ValorDoPix, 2) > 0;

        If Not Result Then
          fMensagem('ATENÇÃO', 'Não é possível gerar o Pix em Pedidos que possui apenas brindes nos produtos selecionados.' + #13 +
                               'Escolha outra condição de pagamento.', ['&Ok']);
    End;
  End;

  If fatVenda.DadosPixDaVenda.ValorDoPix <= 0 THen
  Begin
    fMensagem('ATENÇÃO', 'Não é possível gerar o Pix em Pedidos com o valor total menor ou igual a zero.', ['&Ok']);

    Result := False;
    Exit;
  End;
end;

constructor TGravarOrcamentoComoPedido.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FBloqueio := True;

  qryFatGor := fCriarQuery(fGetSQLOrcamento, Self);

  pCriarCdsVenda(Self);

  fatVenda := TFatVenda.CreateInstance('OR');
  fatVenda.strOpcDocTrue := 'OP';
  fatVenda.strNomeForm := 'frmFatVendas';
  fatVenda.blnImprimeDocs := False;
  fatVenda.strNTrava := 'NNNNNNNNNNNNNNNNNNNN';

  fatVenda.qryConIte := fCriarQueryIteGer(Self);

  FValidarPedido := TValidarPedido.Create(fatVenda);
  FValidarPedido.onProgresso := pRegistrarProgresso;
end;

function TGravarOrcamentoComoPedido.fGetSqlOrcamento: String;
begin
  Result := '';
  Result := Result + fSelectFromFatgorLeftAuxiliares(False);
  Result := Result + 'WHERE ';
  Result := Result + '  F.FGO_NUMDOC = :NUMDOC AND ';
  Result := Result + '  F.FGO_ESPDOC = :ESPDOC AND ';
  Result := Result + '  F.FGO_CODEMP = :CODEMP ';
end;

function TGravarOrcamentoComoPedido.fCarregarMatrizItens: Boolean;
begin
  Result := True;
  pRegistrarProgresso('Inserindo Produtos. Etapa', 1, 1);
  strInfoProcessamento := 'Aguarde, Inserindo produto %s...';
  fatVenda.pPreencheMatrizFechamento('',pOnProcessaItem);
end;

function TGravarOrcamentoComoPedido.fCarregarOrcamento: Boolean;
  Var
    blnDeletou: Boolean;
    
  procedure pProgresso(strInformacao: String; intProgresso: Integer);
  begin
    pRegistrarProgresso(strInformacao, intProgresso, 4);
  End;

begin
  Try
    Try
      pProgresso('Validando Orçamento. Etapa', 1);

      Result := fPodeCarregarOrcamento;

      If Not Result Then
        Exit;

      pProgresso('Carregando Orçamento. Etapa', 2);

      With qryFatGor, SQL Do
      Begin
        Close;
        Clear;
        Add(fGetSQLOrcamento);

        ParamByName('CODEMP').AsString := FEmpOrc;
        ParamByName('NUMDOC').AsString := FNumOrc;
        ParamByName('ESPDOC').AsString := 'OR';

        Open;

        If IsEmpty Then
        Begin
          Result := False;
          Exit;
        End;
      End;

      fatVenda.strNumOrc := FNumOrc;
      fatVenda.strEspOrc := 'OR';
      fatVenda.strEmpOri := FEmpOrc;
      fatVenda.blnOrigemCrm  := FblnOrigemCrm;

      fatVenda.strEspDoc := 'PD';
      fatVenda.strTipFat := 'PEDIDO';

      pProgresso('Carregando Cliente. Etapa', 3);

      untFuncFat.pCarregarClientePedidoOrcamento(fatVenda);

      pProgresso('Carregando Produtos. Etapa', 4);

      fatVenda.blnFecharForm := False;
      fatVenda.blnVerEstOrc  := False;

      fatVenda.pCarregaPedidoOrcamento(qryFatGor, blnDeletou, FProgresso);

      If fClienteConsumidor(fatVenda.strCliOri, False, True) Then
        fatVenda.pCarregaDadosConsumidor(qryFatGor);

      pInserirItemServico;

      fatVenda.intQtdTra := qryFatGor.FieldByName('FGO_VOLUME').AsInteger;
      fatVenda.strEspTra := qryFatGor.FieldByName('FGO_ESPECI').AsString;
      fatVenda.fltPorDes := qryFatGor.FieldByName('FGO_PORDES').AsFloat;
      fatVenda.fltDesEsp := qryFatGor.FieldByName('FGO_DESESP').AsFloat;

      fatVenda.intPrzMed := fFloatToInt(fCalcMediaPagto(fatVenda.strConPag));

      fatVenda.fltDupRec := 0;
      fatVenda.fltValAdt := 0;

      If (fatVenda.strEspOrc = 'PD') Then
      Begin
        fatVenda.fltDupRec := fatVenda.fTotalDuplicataQuitada(fatVenda.strNumOrc,
                                                              fatVenda.strEspOrc,
                                                              VS_strCodEmp,
                                                              fatVenda.strCodCli);

        fatVenda.fltValAdt := TAdiantamento.fGetTotaisAdiantamento(fatVenda.strNumOrc,
                                                                   fatVenda.strEspOrc,
                                                                   VS_strCodEmp).fltValLan;
      End;

      fatVenda.pAtualizaInformacoesCondPagamento();

      If (fatVenda.blnFecharForm) Then
        Result := False;
    Except

      On E: ExceptionAutcom Do
      Begin
        Result := False;
        pMensagemOK(E.Message);
      End;

      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '');
      End;
    End;

  Finally

  End;
end;

function TGravarOrcamentoComoPedido.fDefineAbastecimentoItens(blnPerguntaSeDesejaDesmembrar:Boolean = False): Boolean;
begin
  Result := True;
  If (fCfgSis('SLTFRC', varBoolean)) And (fatVenda.strEspDoc = 'PD') Then
  Begin
    Result := fatVenda.fDefineAbastecimentoItens(oeNaoExibir);

    If Result And blnPerguntaSeDesejaDesmembrar Then
    Begin
      fatVenda.blnFinali := False;

      If (Not fatVenda.blnMulLoj) Then
        fatVenda.blnFinali := fatVenda.fHaveraDesmembramentoVenda(fatVenda.arrMatItens);

      If (fMensagem('Atenção!', 'Orçamento será desmembrado em Pedidos atendidos com abastecimento por "Pedido de Compra" e/ou ' +
                                '"Transferência de Estoque" definido de forma automática. Se deseja controlar como cada item será atendido, ' +
                                'carregue esse documento pela rotina de "Orçamento" e utilize a opção de fechamento em "Pedido" senão, '+
                                'clique em sim para proseguir!' + #13#10 +
                                'Deseja continuar?', ['&Sim', '&Não'], 1,False,1,0,False,0,False,False,False,0,0,3) = 2) Then
      Begin
        fatVenda.blnFinali := False;
        Result := False;
      End;
    End;
  End;
end;

function TGravarOrcamentoComoPedido.fDigitarDadosPedido: Boolean;
begin
  Result := fatVenda.fPedeDadosEmissaoPedidoVenda(qryFatGor);

  If Not fatVenda.fVerificaCondicaoBonificacaoPedidoVenda Then
    Result := False;
end;

procedure TGravarOrcamentoComoPedido.pTravasNaConversaoORPD;
begin
  fatVenda.blnOperadorEscolheuEnviarPedidoParaLiberacao := False;
  If fatVenda.blnLiberacaoRemotaNoFinalVenda Then
  Begin
    If (fatVenda.strEspDoc = 'PD') And fatVenda.blnUsaLiberacaoPedidosConformeEscolhaDoOperador Then
    Begin
      fatVenda.strEnvLib := IIF(fMensagem('','Enviar para Liberação de Pedidos?', ['',''], 2) = 2, 'N', 'S');
      fatVenda.blnOperadorEscolheuEnviarPedidoParaLiberacao := (fatVenda.strEnvLib = 'S');
    End
  End;
end;

function TGravarOrcamentoComoPedido.fItensSemEstoqueParaCorte: Boolean;
begin
  Result := fatVenda.fVerificaSeItensSemEstoqueIraGerarVendasPerdidas;
end;

function TGravarOrcamentoComoPedido.fDigitarDadosPedidoCompra: Boolean;
  var
    blnInformouPedidoDeCompraNaDigMensagem : Boolean;
begin

  Result := True;

  If (Not fEhObrigatorioInformarPedidoDeCompraNosItensParaCliente(fatVenda.strCodCli)) or
     (not FatVenda.fRotinaValidaTravaDePedidoDeCompra('PD')) Then
    Exit;

  blnInformouPedidoDeCompraNaDigMensagem := (Length(fatVenda.npcNumCmp) > 0);

  If (Not fatVenda.fFoiInformadoPedidoDeCompraEmTodosOsItens) And (Not blnInformouPedidoDeCompraNaDigMensagem) Then
    Result := fatVenda.fValidarAcessoGravacaoFaturamentoSemInformarPedidoDeCompra(fatVenda.strCodCli);

end;

function TGravarOrcamentoComoPedido.fPedeLojasColorantesTE: Boolean;
begin
  Result := fatVenda.fPedeLojasColorantesTE;
end;

function TGravarOrcamentoComoPedido.fPedeLojasTE: Boolean;
begin
  Result := fatVenda.fPedeLojasTE;
end;

function TGravarOrcamentoComoPedido.fPodeCarregarOrcamento: Boolean;
  Var
    blnJaFatu, blnJaBaix, blnImpresso, blnSepImpresso: Boolean;
    strCodVen : String;
begin
  Result := True;

  If (Not fDocumentoFatExiste(qryFatGor, FNumOrc, 'OR', FEmpOrc, blnJaFatu, blnJaBaix, blnImpresso, strCodVen, blnSepImpresso)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse documento não está cadastrado!', ['&O k']);
    Result := False;
  End

  Else If (blnJaFatu) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse documento já foi faturado!', ['&O k']);
    Result := False;
  End

  Else If (Not fEmptyStr(FNumOrc)) And (Not fVerificaAcessoSistema('VERORC')) And (strCodVen <> strLoginUsuarioLogado) And (Not fEmptyStr(strCodVen)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Acesso ao documento não permitido!', ['&O k']);
    Result := False;
  End

  Else If FBloqueio And Not fLock_Unlock(fGetChaveBloqueio, True, False) Then
  Begin
    fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' +
                  fGetHostLock(fGetChaveBloqueio)  + '!', ['&Ok']);
    Result := False;
  End;

end;

function TGravarOrcamentoComoPedido.fProcessarRequisicaoCompra: Boolean;
Var
  cdsVendasSemEstoq : TUniClientDataSet;
  frmFatRequisicaoCompras : TfrmFatRequisicaoCompras;
  objMsg : TMensagemLiberacao;
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
begin

  Result := True;

  fatVenda.blnFaltaProduto := (fCfgSis('FALPRO', varBoolean)) And ((fatVenda.strEspDoc = 'PD') Or (fatVenda.strOpcDoc = 'PD')) And (fatVenda.fEhFaltaDeProduto);

  If (((fatVenda.strEspDoc = 'PD') Or (fatVenda.strOpcDoc = 'PD')) And
     (Not fCfgSis('SLTFRC', varBoolean)) And
     (fCfgSis('SLRQPV', varBoolean)) And
     (Pos(fCfgSis('SLDPED'), 'A_T_') > 0) And (fatVenda.fTemItemSemEstoque)) Or (fatVenda.blnFaltaProduto) Then
  Begin

    Try

      cdsVendasSemEstoq := TUniClientDataSet.Create(Self);
      pCriarFormularios(TfrmFatRequisicaoCompras, frmFatRequisicaoCompras);

      Try

        cdsVendasSemEstoq.Data       := cdsVenda.Data;
        cdsVendasSemEstoq.LogChanges := False;
        cdsVendasSemEstoq.Filtered   := False;
        cdsVendasSemEstoq.Filter     := ' (ITE_OPCABS <> ' + IntToStr(Integer(oaSolicitTransf)) + ') ';
        cdsVendasSemEstoq.Filtered   := True;

        While cdsVendasSemEstoq.Locate('ITE_PODALT', False, []) Do
          cdsVendasSemEstoq.Delete;

        While cdsVendasSemEstoq.Locate('ITE_CODITE', fCfgSis('ITESER'), []) Do
          cdsVendasSemEstoq.Delete;

        While cdsVendasSemEstoq.Locate('ITE_CODITE', fCfgSis('SERTER'), []) Do
          cdsVendasSemEstoq.Delete;

        While cdsVendasSemEstoq.Locate('ITE_CODITE', fCfgSis('ITEFRE'), []) Do
          cdsVendasSemEstoq.Delete;

        While cdsVendasSemEstoq.Locate('ITE_CODITE', fCfgSis('ITEMAN'), []) Do
          cdsVendasSemEstoq.Delete;

        While cdsVendasSemEstoq.Locate('ITE_CODITE', fCfgSis('ITELAN'), []) Do
          cdsVendasSemEstoq.Delete;

        While cdsVendasSemEstoq.Locate('ITE_CODITE', fCfgSis('ITEBOM'), []) Do
          cdsVendasSemEstoq.Delete;

        While cdsVendasSemEstoq.Locate('ITE_CODITE', fCfgSis('ITETAX'), []) Do
          cdsVendasSemEstoq.Delete;

        While cdsVendasSemEstoq.Locate('ITE_PEGOU_', 'S', []) Do
          cdsVendasSemEstoq.Delete;

        While cdsVendasSemEstoq.Locate('ITE_ENTRET;ITE_LOCRET', VarArrayOf(['R','C']), []) Do
          cdsVendasSemEstoq.Delete;

        If (Not cdsVendasSemEstoq.IsEmpty) Then
        Begin
          frmFatRequisicaoCompras.strCodUsu                  := IIF(fCfgSis('USADIG') = 'S', fatVenda.strCodDig, fatVenda.strCodVen);
          frmFatRequisicaoCompras.edtCodigo.ReadOnly         := True;
          frmFatRequisicaoCompras.edtCodCli.Text             := fatVenda.strCodCli;
          frmFatRequisicaoCompras.edtCodCli.ReadOnly         := True;
          frmFatRequisicaoCompras.edtNomCli.Text             := fatVenda.strCliOri;
          frmFatRequisicaoCompras.edtSenVen.Text             := fRetSenhaVendedor(fatVenda.strCodVen);
          frmFatRequisicaoCompras.edtNomVen.Text             := fRetNomVendRep(fatVenda.strCodVen);
          frmFatRequisicaoCompras.edtCodIte.ReadOnly         := True;
          frmFatRequisicaoCompras.blnVaiGravarComFaturamento := True;
          frmFatRequisicaoCompras.cdsVenda                   := cdsVendasSemEstoq;
          frmFatRequisicaoCompras.strCodigo                  := fCampoTabela('RCG_CODIGO', 'MOVRCG', ['AUTOINCREM'], [fatVenda.strInRqCp]);
          frmFatRequisicaoCompras.strNumOrc                  := fatVenda.strNumOrc;
          frmFatRequisicaoCompras.blnEntCD                   := fatVenda.blnEnt_CD;
          frmFatRequisicaoCompras.strEmpCD                   := fatVenda.strEmp_CD;
          frmFatRequisicaoCompras.blnFaltaProduto            := fatVenda.blnFaltaProduto;
          frmFatRequisicaoCompras.strCodVen                  := fatVenda.strCodVen;
          frmFatRequisicaoCompras.strCodCnd                  := fatVenda.strCodCnd;
          frmFatRequisicaoCompras.strCodFpg                  := fatVenda.strCodFpg;

          frmFatRequisicaoCompras.ShowModal();

          Result := frmFatRequisicaoCompras.blnConfirma;

          If Result Then
            pCloneDataSet(fatVenda.cdsMovRcd, frmFatRequisicaoCompras.cdsConsulta)
          Else
          If Not fatVenda.cdsMovRcd.isEmpty then
          Begin

            Try

              fatVenda.cdsMovRcd.Filtered := False;
              fatVenda.cdsMovRcd.Filter   := 'RCD_SEQCOT = '''' AND RCD_SEQPCD = ''''';
              fatVenda.cdsMovRcd.Filtered := True;

              While Not fatVenda.cdsMovRcd.IsEmpty Do
                fatVenda.cdsMovRcd.Delete;

            Finally
              fatVenda.cdsMovRcd.Filtered := False;
              fatVenda.cdsMovRcd.Filter   := '';
            End;

          End;

        End;

        if (not Result) and (fCfgSis('LBSRCP',varBoolean)) then
        begin

          objTabela := TRegistroMsgLiberaTabela.Create;
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlCabecalho;
          objLinha.pAddColuna('', 'ITEM'      , 5 , alEsquerda, teAutcom);
          objLinha.pAddColuna('', 'DESCRIÇÃO' , 50, alEsquerda, teAutcom);
          objLinha.pAddColuna('', 'QUANTIDADE', 10, alDireita , teAutcom);
          objTabela.lstLinhas.Add(objLinha);

          cdsVendasSemEstoq.First;
          while not cdsVendasSemEstoq.Eof do
          begin
            objLinha  := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlValor;
            objLinha.pAddColuna('ITEM'      , cdsVendasSemEstoq.FieldByName('ITE_CODITE').AsString                                                        , 5 , alEsquerda );
            objLinha.pAddColuna('DESCRIÇÃO' , cdsVendasSemEstoq.FieldByName('ITE_DESITE').AsString                                                        , 50, alEsquerda );
            objLinha.pAddColuna('QUANTIDADE', FloatToStrf(cdsVendasSemEstoq.FieldByName('ITE_QTDITE').AsFloat, ffFixed, 11, fCfgSis('DECQTD', varInteger)), 10, alDireita  );
            objTabela.lstLinhas.Add(objLinha);
            cdsVendasSemEstoq.Next;
          end;

          objMsg := TMensagemLiberacao.Create(nil);
          objMsg.pAddTexto('FECHAMENTO DE PEDIDO SEM REQUISIÇÃO DE COMPRA. ');
          objMsg.lstRegistros.Add(objTabela);
          objMsg.pAddQuebra(teAmbos);

          Result := fSenhaLiberacaoSemRequisicaoCompra(fatVenda.strCodVen,
                                   fatVenda.strCodDig,
                                   fatVenda.strNtrava,
                                   fatVenda.stlNumLib,
                                   objMsg,
                                   TRUE,
                                   'PD',
                                   False,
                                   True,
                                   fatVenda.strCodCli + ' - '+ fatVenda.strCliNom + ' - CPF/CNPJ ' + fatVenda.strCliCgc);
          FreeAndNil(objMsg);
        end;

      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TGravarOrcamentoComoPedido.fProcessarRequisicaoCompra]');
      End;
    Finally
      pFreeAndNil(frmFatRequisicaoCompras);
      pFreeAndNil(cdsVendasSemEstoq);
      fatVenda.blnChamouRequisicaoFaltaProdutoNaEmissaoPedido := fatVenda.blnFaltaProduto;
      fatVenda.blnFaltaProduto := False
    End;
  End;

end;

function TGravarOrcamentoComoPedido.fValidacoesFinanceiras: Boolean;
begin
  Result := True;

  objValidarPedido.blnPedirSenha := True;

  If Not objValidarPedido.fValidaLimiteCredito Then
    Exit(False);

  If Not objValidarPedido.fValidaNaoCompra Then
    Exit(False);

  If Not objValidarPedido.fValidaUnitario Then
    Exit(False);

  If Not objValidarPedido.fValidaVrMinimo Then
    Exit(False);

  If Not objValidarPedido.fValidaDebitosCliente Then
    Exit(False);
end;

function TGravarOrcamentoComoPedido.fAbaterCreditosAutomaticamente(const fltTotalCadRec : Double): Boolean;
begin
  Result := True;

  If (fFormataFloat(fltTotalCadRec, 2) <= 0.0) Then
    Exit;

  If (Not fatVenda.fDescontaCreditoAutomatico(fatVenda.blnUtiAbaAutoCredPend)) Then
    Exit;

  Result := fatVenda.objFormasPagtoNegociada.fPedeFormasPagamento(fatVenda.strOpcDoc,
                                                                  fatVenda.strCodCli,
                                                                  fatVenda.strCodFpg,
                                                                  fatVenda.strCodCnd,
                                                                  fatVenda.strConPag,
                                                                  fatVenda.blnEnt_CD,
                                                                  False,
                                                                  fatVenda.fltTotCadRec - fatVenda.fltValAdt - fatVenda.fltBolAdt,
                                                                  False,
                                                                  True,
                                                                  True);

  If Result And fatVenda.fBaixaAdiantamentoAutomatico And (fatVenda.objFormasPagtoNegociada.fFormaPagtoSelecionada('013')) Then
  Begin
    fatVenda.blnBaixaAdiantamentoAutomatico := True;
    fatVenda.stlDupCreditos.Text := fatVenda.objFormasPagtoNegociada.fBuscaDuplicatasSelecionadas;
    fatVenda.fltCredUtilizados := fatVenda.objFormasPagtoNegociada.fValorFormaPagtoSelecionada('013');
  End;

  If (fatVenda.fltCredUtilizados > 0) Then
    fatVenda.fltTotCredAutomatico := fatVenda.fltCredUtilizados;
end;

function TGravarOrcamentoComoPedido.fValidarEstoque: Boolean;
begin
  Result := fatVenda.fValidarEstoqueQuandoOrcamentoGravandoEmPedido();
end;

function TGravarOrcamentoComoPedido.fGetChaveBloqueio: String;
begin
  Result := 'FATGOR' + FNumOrc + 'OR' + FEmpOrc;
end;

destructor TGravarOrcamentoComoPedido.Destroy;
begin
  If Assigned(qryFatGor) Then FreeAndNil(qryFatGor);
  If Assigned(fatVenda)  Then FreeAndNil(fatVenda);
  pFreeCdsVenda;
  If Assigned(FValidarPedido) Then FreeAndNil(FValidarPedido);

  If FBloqueio Then fLock_Unlock(fGetChaveBloqueio, False, False );

  inherited;
end;

function TGravarOrcamentoComoPedido.fCalcularTotalVenda(blnCalcularPeso: Boolean = True): Boolean;
  Var
    arrDatas: TDateArray;
    blnMostraDigDuplic: Boolean;

  procedure pProgresso(strInformacao: String; intProgresso: Integer);
  begin
    pRegistrarProgresso(strInformacao, intProgresso, 6);
  End;

begin
  Result := True;

  fatVenda.blnDeCndF := (fCfgSis('CNDVEN') = 'F');

  If fatVenda.blnTaxVpr Then
    fatVenda.pCalculaTaxVpr;

  fatVenda.pAjustarItensOrcamentoOrdSer();

  if blnCalcularPeso then
  begin
    pProgresso('Calculando Peso Produtos. Etapa', 2);

    fatVenda.pCalculaPesBruLiq;

    If (fPermiteInformarPesoNoPedidoDeVenda) And (Not qryFatGor.IsEmpty) Then
    Begin
      fatVenda.fltPesBru := qryFatGor.FieldByName('FGO_PESBRU').AsFloat;
      fatVenda.fltPesLiq := qryFatGor.FieldByName('FGO_PESLIQ').AsFloat;
    End;
  end;

  pProgresso('Calculando Valor Total. Etapa', 4);

  strInfoProcessamento := 'Aguarde, Calculando valor do produto %s...';

  fatVenda.pDestacaRetencoes;
  fatVenda.pRetemImpostosNoDescontoEspecial;

  fatVenda.pCalculaTotGer(False, True, pOnProcessaItem);

  If Not AtualizaValorDoPix Then
    Exit(False);

  fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

  pProgresso('Calculando Total Parcelas. Etapa', 5);

  fatVenda.pCalculaTotalParaCadRec;

  fatVenda.pRateiaValores;

  blnMostraDigDuplic := False;

  fatVenda.fDigitaDuplicata(blnMostraDigDuplic,
                            arrDatas, fatVenda.dtaPreVis,
                            True, fatVenda.arrDuplicCop);

  If fatVenda.fltValAdt > 0 Then
  Begin
    Result := Result And fatVenda.fAdicionaAdiantamentoPrimeiraParcela;
  End;

  pProgresso('Atualizando Valor das Parcelas. Etapa', 6);
end;

function TGravarOrcamentoComoPedido.fGravarPedido: Boolean;
begin

  Try
    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.strChave := 'FATVENDAS';
    If fatVenda.blnFinali Then
      frmGravando.fExecutarAcao := fatVenda.fDesmembraPDORMultiLoja
    Else
      frmGravando.fExecutarAcao := fatVenda.fGravaArquivos;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'');
    End;
  End;

  pFreeAndNil(frmGravando);
  
end;

procedure TGravarOrcamentoComoPedido.pInserirItemServico;
  Var
    qryCadIte,
    qryIteGer,
    qryAbfIcm: TUniQuery;
    strIteSer: String;
begin

  If (fatVenda.fltTotSer <= 0) And (Not fatVenda.fPossuiBrindeServico()) Then
    Exit;

  strIteSer := fCfgSis('ITESER');

  If fEmptyStr(strIteSer) Then
    Raise Exception.Create('Item de serviço não configurado.');

  qryCadIte := fCriaQuery(Self);
  qryIteGer := fCriaQuery(Self);
  qryAbfIcm := fCriaQuery(Self);

  qryCadIte.SQL.Add('SELECT * FROM CADITE WHERE ITE_CODITE = :CODITE');
  qryCadIte.ParamByName('CODITE').AsString := strIteSer;
  qryCadIte.Open;

  qryIteGer.SQL.Add('SELECT * FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP');
  qryIteGer.ParamByName('CODITE').AsString := strIteSer;
  qryIteGer.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryIteGer.Open;

  qryAbfIcm.SQL.Add('SELECT * FROM ABFICM WHERE ABF_CODABF = :CODABF AND ABF_ESTADO = :ESTADO');

  If fCfgSis('TIPABF') = '1' Then
    qryAbfIcm.ParamByName('CODABF').AsString := qryCadIte.FieldByName('ITE_CODABF').AsString
  Else
    qryAbfIcm.ParamByName('CODABF').AsString := qryIteGer.FieldByName('ITE_CODABF').AsString;

  qryAbfIcm.ParamByName('ESTADO').AsString := fatVenda.strCliEst;
  qryAbfIcm.Open;

  fatVenda.pInserirItemServico(Nil, qryCadIte, qryIteGer, qryAbfIcm);

  FreeAndNil(qryCadIte);
  FreeAndNil(qryIteGer);
  FreeAndNil(qryAbfIcm);
end;

procedure TGravarOrcamentoComoPedido.pRegistrarProgresso(strTexto: String; intAtual, intFinal: Integer);
begin
  If Assigned(FProgresso) Then
  Begin
    pgbProgresso.Properties.Min := 0;
    pgbProgresso.Properties.Max := intFinal;
    pgbProgresso.Position := intAtual;
  End;

  If Assigned(FMemoLog) Then
  Begin
    FMemoLog.Lines.Add(FormatDateTime('hh:mm:ss', fNow()) + ' - ' + Format('%s %d / %d',  [strTexto ,intAtual, intFinal]));
    FMemoLog.Lines.Add(fReplicatorStr('-',200));
  End;

  If Assigned(lblInformacao) Then
  Begin
    lblInformacao.Caption := Format('%s %d / %d',  [strTexto ,intAtual, intFinal]);
  End;

  pProcessMessages;
end;

procedure TGravarOrcamentoComoPedido.SetProgresso(const Value: TcxProgressBar);
begin
  FProgresso := Value;
end;

procedure TGravarOrcamentoComoPedido.pOnProcessaItem(const item: TDadosFechamento; index, count: Integer; AInfo: String = '');
begin
  If AInfo.IsEmpty Then
    AInfo := strInfoProcessamento;
  pRegistrarProgresso(Format(AInfo, [item.strCodIte + '-' + fPadR(item.strDesIte, 28)]), Succ(index), count);
end;

end.
