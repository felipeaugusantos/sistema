unit Faturamento.Classes.TAlterarPedido;

interface

uses Classes, untFuncFat, untFuncFatTypes, EditFocus, MaskEditFocus, Uni, Vcl.Controls,
  cxProgressBar, stdCtrls, Windows, untTypesSistema, Faturamento.Classes.TValidarVenda, Math;

Type
  TAlterarPedido = class(TComponent)
    private
      qryConCnd: TUniQuery;
      qryConFpg: TUniQuery;
      fatVenda : TFatVenda;
      FValidarPedido: TValidarPedido;

      FNumPed: String;
      FEspPed: String;
      FEmpPed: String;

      FCodCnd: TEditFocus;
      FForPag: TEditFocus;
      FDesFpg: TEditFocus;
      FDesCnd: TEditFocus;
      FCndPag: TMaskEditFocus;

      blnFatVendaAssigned: Boolean;

      blnUtilizaVendaMadOuVidOuMtL: Boolean;

      strInfoProcessamento: String;
      FStlEmpresas: TStringList;
      blnExibeSaldoGrid: Boolean;

      FExibirTelaAbastecimento: TOpcaoExibirTelaAbastecimento;
      FRealizarDesmembramento: Boolean;
      FValidarMargemValorCndPagto: Boolean;
      FDesmembramentoAutomaticoPelaExpedicao: Boolean;
      FAlteraFormaPagamentoLiberacaoPedidoMultiEmp: Boolean;

      FSimulandoVenda: Boolean;

      FCodCli: String;
      FEnt_CD: Boolean;
      FEmp_CD: String;

      FBaixaPedidoNaoEntregue: Boolean;

      function fRecalculaVolumeSeFaturadorAutomatico: Boolean;
      procedure pInserirItemServico(strCodIte: String);
      procedure pRecalculaPrecos(pgbStatus: TcxProgressBar = nil);

      function fTabelaPrecoClienteOuVendedor: String;

      function fCarregarPedidoInterna(pgbStatus: TcxProgressBar = nil): Boolean;
      function fCalculaTotalPedidoInterna(pgbStatus: TcxProgressBar = nil): Boolean;

      procedure pOnProcessaItem(const item: TDadosFechamento; index, count: Integer; AInfo: String = '');
      procedure pRegistrarProgresso(strTexto: String; lblInformacao: TLabel; pgbProgresso: TcxProgressBar; intInicio, intAtual, intFinal: Integer);

      procedure SetfatVenda(const Value: TFatVenda);
      function fBaixaFutura(strNumDoc, strEspDoc, strCodEmp: String): Boolean;

      function fDefineAbastecimentoItens: Boolean;
      procedure pOnAdicionouItemDoPedido;
      procedure pLoadEmpSaldo;
      function fExpediuTotal: Boolean;
    public
      qryFatGor: TUniQuery;
      blnAtualizaTabPreCnd: Boolean;
      blnModuloAltCondPagtoPedido: Boolean;
      blnRecalcularPrecosAoMudarCondicaoDePagamento: Boolean;

      blnRecalculaPrecos: Boolean;
      blnRecalculaVolumeDireto: Boolean;
      blnPerguntaSeRecalculaVolume: Boolean;
      blnRecalcularSomentePrecosComCotacaoDolar: Boolean;
      blnZerarDescontoDoItemRecalculoPrecos: Boolean;

      blnVerUniOriginal: Boolean;
      blnAltTabelaPreco: Boolean;
      blnSolicitouAlteracaoPreco: Boolean;
      blnApenasVerificaSeItensTeraoModicacaoAposCondicaoPagamento: Boolean;
      blnItensEntraramOuSairamDePromocao: Boolean;
      blnItensTiveramUnitarModificados: Boolean;

      blnTelaDesmembramento: Boolean;
      blnDesmembramentoExpedicao: Boolean;
      strOpeExp,
      strSepExp,
      strObsExp: String;
      dtaDtlBex,
      horHrlBex: TDateTime;

      blnTrocaCliente: Boolean;

      blnAlterouCndPag: Boolean;

      blnOrigemTelaDesmembrarPedidoConfiguracaoDPDAFPLigada: Boolean;
      blnExpedicaoPedidoBaixaEntregaFutura: Boolean;

      function fCarregarPedido: Boolean;
      function fCalculaTotalPedido: Boolean;
      function fGravarPedido(blnComTransacao: Boolean = True): Boolean;
      function fDocumentoSemTravaDePreco: Boolean;

      procedure pCarregaCondicao(strCodCnd: String; dtaDtaBas: TDateTime = 0);
      procedure pCarregaForPag(strForPag: String);

      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      property strNumPed: String Read FNumPed Write FNumPed;
      property strEspPed: String Read FEspPed Write FEspPed;
      property strEmpPed: String Read FEmpPed Write FEmpPed;

      property objVenda : TFatVenda  Read fatVenda Write SetfatVenda;
      property objValidacoes: TValidarPedido read FValidarPedido;
      property edtCodCnd: TEditFocus Read FCodCnd  Write FCodCnd;
      property edtForPag: TEditFocus Read FForPag  Write FForPag;
      property edtDesFpg: TEditFocus Read FDesFpg  Write FDesFpg;
      property edtDesCnd: TEditFocus Read FDesCnd  Write FDesCnd;
      property mskCndPag: TMaskEditFocus Read FCndPag Write FCndPag;

      property stlEmpresas: TStringList Read FStlEmpresas;
      property blnDesmembramentoAutomaticoPelaExpedicao: Boolean Read FDesmembramentoAutomaticoPelaExpedicao Write FDesmembramentoAutomaticoPelaExpedicao;

      property opcExibirTelaAbastecimento: TOpcaoExibirTelaAbastecimento Read FExibirTelaAbastecimento Write FExibirTelaAbastecimento;
      property blnRealizarDesmembramento: Boolean Read FRealizarDesmembramento Write FRealizarDesmembramento;
      property blnValidarMargemValorCndPagto: Boolean Read FValidarMargemValorCndPagto Write FValidarMargemValorCndPagto;
      property blnSimulandoVenda: Boolean Read FSimulandoVenda Write FSimulandoVenda;

      property blnAlteraFormaPagamentoLiberacaoPedidoMultiEmp: Boolean Read FAlteraFormaPagamentoLiberacaoPedidoMultiEmp Write FAlteraFormaPagamentoLiberacaoPedidoMultiEmp;

      property strCodCli: String Read FCodCli Write FCodCli;
      property blnBaixaPedidoNaoEntregue: Boolean Read FBaixaPedidoNaoEntregue Write FBaixaPedidoNaoEntregue;
  end;

implementation

uses SysUtils, TypInfo, Forms, Graphics, untGravando, untPesqAux,
  untFuncoesSimples, untFuncoes, untCadPro, Data.DB, untAdiantamentoCliente,
  untLiberacao, System.StrUtils, untConstantes, untFatAbastecimentoItens,
  untAdiantamentoClienteGenerico,
  untFatSelecaoTabelaPreco, untTPixDao;

Var
  frmGravandoInterno: TfrmGravando;

{ TAltCndPagPed }

constructor TAlterarPedido.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  strEspPed := 'PD';

  FEnt_CD := False;
  FEmp_CD := '';

  FExibirTelaAbastecimento := oeNaoExibir;
  FRealizarDesmembramento  := False;
  FValidarMargemValorCndPagto := False;
  FBaixaPedidoNaoEntregue := False;

  blnAtualizaTabPreCnd := (fCfgSis('USACND', varBoolean)) And
                          (fCfgSis('TBPCND', varBoolean)) And
                          (fCfgSis('CNDVEN', varString) = 'I');

  blnModuloAltCondPagtoPedido := False;

  blnRecalcularPrecosAoMudarCondicaoDePagamento := fCfgSis('ATPRPO', varBoolean);

  blnUtilizaVendaMadOuVidOuMtL := fCfgSis('VENMAD', varBoolean) Or
                                  fCfgSis('VENVID', varBoolean) Or
                                  fCfgSis('VENMTL', varBoolean);

  blnFatVendaAssigned := False;  

  qryConCnd := fCriarQuery('SELECT * FROM CADCND WHERE FALSE', Self);
  qryConFpg := fCriarQuery('SELECT * FROM CADFPG WHERE FALSE', Self);
  qryFatGor := fCriarQuery(fGetSQLPedido, Self);

  blnRecalcularSomentePrecosComCotacaoDolar := False;
  blnZerarDescontoDoItemRecalculoPrecos := False;
  blnRecalculaPrecos := False;
  blnVerUniOriginal  := False;
  blnAltTabelaPreco  := False;
  blnRecalculaVolumeDireto := False;
  blnPerguntaSeRecalculaVolume := False;
  blnDesmembramentoExpedicao := False;
  blnTelaDesmembramento := False;

  strOpeExp := '';
  strSepExp := '';
  strObsExp := '';
  dtaDtlBex := 0;
  horHrlBex := 0;

  blnExibeSaldoGrid := False;
  blnSolicitouAlteracaoPreco := False;
  blnApenasVerificaSeItensTeraoModicacaoAposCondicaoPagamento := False;
  blnItensEntraramOuSairamDePromocao := False;
  blnItensTiveramUnitarModificados := False;

  If Assigned(AOwner) Then
    blnExibeSaldoGrid := fCfgSis('EXISAL', varBoolean) And
      (AOwner.ClassName = 'TfrmFatDesmembrarPedido');

  If blnExibeSaldoGrid Then
    pLoadEmpSaldo();

  FSimulandoVenda := False;
  blnAlterouCndPag := False;
  blnDesmembramentoAutomaticoPelaExpedicao := False;
  blnAlteraFormaPagamentoLiberacaoPedidoMultiEmp := False;
  blnOrigemTelaDesmembrarPedidoConfiguracaoDPDAFPLigada := False;
  blnExpedicaoPedidoBaixaEntregaFutura := False;
end;

function TAlterarPedido.fBaixaFutura(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
Var
  qryTmp: TUniQuery;
  strSQL: String;
Begin
  qryTmp := fCriaQuery(Self);

  With qryTmp Do
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT COUNT(ED.FDO_INCFUT) AS REG FROM FATDOR FD ';
    strSQL := strSQL + 'INNER JOIN EXTDOR ED ON FD.AUTOINCREM = ED.FDO_SEQFDO ';
    strSQL := strSQL + 'WHERE IFNULL(ED.FDO_INCFUT,"") <> "" ';
    strSQL := strSQL + '  AND FD.FDO_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '  AND FD.FDO_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '  AND FD.FDO_CODEMP = :CODEMP ';

    SQL.Text := strSQL;
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    result := (FieldByName('REG').AsInteger > 0);
  end;

  FreeAndNil(qryTmp);

end;

function TAlterarPedido.fCarregarPedidoInterna(pgbStatus: TcxProgressBar = Nil): Boolean;

  Var
    blnDeletouItens : Boolean;

  procedure pProgresso(strInformacao: String; intProgresso: Integer);
  begin
    If Assigned(pgbStatus) Then
      pRegistrarProgresso(strInformacao,
                          TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')),
                          pgbStatus, 0, intProgresso, 3);
  End;

begin
  pProgresso('Carregando documento. Etapa', 1);

  Result := True;

  If Not blnFatVendaAssigned Then
  Begin
    With qryFatGor, SQL Do
    Begin
      Close;
      Clear;
      Add(fGetSQLPedido);

      ParamByName('CODEMP').AsString := strEmpPed;
      ParamByName('NUMDOC').AsString := strNumPed;
      ParamByName('ESPDOC').AsString := strEspPed;

      Open;

      If IsEmpty Then
      Begin
        Result := False;
        Exit;
      End;
    End;

    pCriarCdsVenda(Self);

    fatVenda := TFatVenda.CreateInstance(strEspPed);
    FValidarPedido := TValidarPedido.Create(fatVenda);

    fatVenda.blnBaixaPedidoNaoEntregue := blnBaixaPedidoNaoEntregue;
    fatVenda.blnDesmembramentoExpedicao := Self.blnDesmembramentoExpedicao;
    fatVenda.blnTelaDesmembramento := Self.blnTelaDesmembramento;
    fatVenda.blnDesmembraPedRegEsp := qryFatGor.FieldByName('FGO_REGDES').AsString = 'S';
    fatVenda.blnOrigemTelaDesmembrarPedidoConfiguracaoDPDAFPLigada := blnOrigemTelaDesmembrarPedidoConfiguracaoDPDAFPLigada;

    If (fatVenda.fEhDesmembramentoExpedicaoRegimeEspecial) Then
    Begin
      fatVenda.blnManLib    := True;
    End;

    fatVenda.strNomeForm := 'frmFatVendas';
    fatVenda.blnImprimeDocs := False;

    fatVenda.strNumOrc := strNumPed;
    fatVenda.strEspOrc := strEspPed;
    fatVenda.strEmpOri := strEmpPed;
    fatVenda.strNumDoc := strNumPed;
    fatVenda.strEspDoc := strEspPed;

    if blnAlteraFormaPagamentoLiberacaoPedidoMultiEmp then
    begin
      fatVenda.strEmpDoc := strEmpPed;
      fatVenda.strPedEmp := strEmpPed;
      fatVenda.blnAlteraFormaPagamentoLiberacaoPedidoMultiEmp := blnAlteraFormaPagamentoLiberacaoPedidoMultiEmp;
    end;

    If (blnExpedicaoPedidoBaixaEntregaFutura) Then
      fatVenda.strCfgENFUOP := IfEmptyStr(qryFatGor.FieldByName('AUX_ENFUOP').AsString, '1');

    pProgresso('Carregando Cliente. Etapa', 2);

    untFuncFat.pCarregarClientePedidoOrcamento(fatVenda,
                                               strEmpPed,
                                               False,
                                               qryFatGor.FieldByName('FGO_ENT_CD').AsString = 'S');

    {************************************************************}
    {* ESTA FUNCAO DEVE FICAR APOS CARREGAR OS DADOS DO CLIENTE *}
    {*********************************************************JC*}
    fatVenda.fCarregaLiberacaoPedido(strNumPed,
                                     strEspPed,
                                     strEmpPed,
                                     True);

    pProgresso('Carregando Produtos. Etapa', 3);

    fatVenda.blnFecharForm := False;
    fatVenda.blnVerEstOrc  := False;
    fatVenda.blnCndBasDtaPre := True;

    If fBaixaFutura(strNumPed,strEspPed,strEmpPed) then
    Begin
      FatVenda.blnBaiEntFut := True;
      FatVenda.dicDesEspItens := TDicionario.Create;
      FatVenda.dicDesEspItens.Limpar;
    End;

    fatVenda.OnAdicionouItemDoPedido := pOnAdicionouItemDoPedido;
    fatVenda.pCarregaPedidoOrcamento(qryFatGor, blnDeletouItens, pgbStatus);
    fatVenda.qryFatGor := qryFatGor;

    {Manter as travas!}
    fatVenda.strNTrava := qryFatGor.FieldByName('FGO_NTRAVA').AsString;

    {Manter o bloqueio comercial!}
    fatVenda.blnPedBlo := (qryFatGor.FieldByName('FGO_LIBCOM').AsInteger = 0);

    FEnt_CD := False;
    FEmp_CD := '';
    If fCfgSis('EMPFAT', VarBoolean) Then
    Begin
      FEnt_CD := fatVenda.blnEnt_CD;
      FEmp_CD := fatVenda.strEmp_CD;

      fatVenda.blnEnt_CD := False;
      fatVenda.strEmp_CD := '';
    End;

    pInserirItemServico(fCfgSis('ITESER'));
    
    If fCfgSis('AUTCEN', VarBoolean) And (fCfgSis('ITESER') <> fCfgSis('SERTER')) Then
      pInserirItemServico(fCfgSis('SERTER'));

    fatVenda.intQtdTra := qryFatGor.FieldByName('FGO_VOLUME').AsInteger;
    fatVenda.strEspTra := qryFatGor.FieldByName('FGO_ESPECI').AsString;
    fatVenda.fltPorDes := qryFatGor.FieldByName('FGO_PORDES').AsFloat;
    fatVenda.fltDesEsp := qryFatGor.FieldByName('FGO_DESESP').AsFloat;

    fatVenda.fltDupRec := 0;
    fatVenda.fltValAdt := 0;

    If (fatVenda.strEspOrc = 'PD') Then
    Begin

      fatVenda.fltDupRec := fatVenda.fTotalDuplicataQuitada(fatVenda.strNumOrc, fatVenda.strEspOrc,
                                                            VS_strCodEmp, fatVenda.strCodCli);

      fatVenda.fltValAdt := TAdiantamento.fGetTotaisAdiantamento(fatVenda.strNumOrc,
                                                                 fatVenda.strEspOrc,
                                                                 VS_strCodEmp).fltValLan;

   	End;

    If fatVenda.fPedidoAPrazoComEntradaQuitada(fatVenda.strNumOrc, fatVenda.strEspOrc, VS_strCodEmp, fatVenda.FConPag) Then
    Begin
      fatVenda.pAlteraCondicaoPagamentoRemovendoEntrada(fatVenda.FConPag);
    End;

    If (fatVenda.blnFecharForm) Then
      Result := False;

    strOpeExp := qryFatGor.FieldByName('FGO_OPEEXP').AsString;
    strSepExp := qryFatGor.FieldByName('FGO_SEPEXP').AsString;
    strObsExp := qryFatGor.FieldByName('FGO_OBSEXP').AsString;
    dtaDtlBex := qryFatGor.FieldByName('FGO_DTLBEX').AsDateTime;
    horHrlBex := qryFatGor.FieldByName('FGO_HRLBEX').AsDateTime;

    fatVenda.DadosPixDaVenda.TxIdPix := qryFatGor.FieldByName('FGO_TX_PIX').AsString;
    fatVenda.DadosPixDaVenda.EmpresaDoPix := qryFatGor.FieldByName('FGO_EMPPIX').AsString;
    fatVenda.DadosPixDaVenda.AlterarCondicaoDePagamento := False;
    If Not MatchStr(fatVenda.strOpcDoc, ['VN']) Then
      fatVenda.DadosPixDaVenda.AlterarCondicaoDePagamento := Not fatVenda.DadosPixDaVenda.TxIdPix.IsEmpty;
    fatVenda.DadosPixDaVenda.GerarPixDaVenda := Not fatVenda.DadosPixDaVenda.TxIdPix.IsEmpty;
    fatVenda.DadosPixDaVenda.RecebidoPorPix := 'N';
    fatVenda.DadosPixDaVenda.UtilizaShipay := TPixDao.RetornaDadosDoPix(qryFatGor.FieldByName('FGO_TX_PIX').AsString,
                                                                        qryFatGor.FieldByName('FGO_EMPPIX').AsString)
                                                     .FieldByName('MPX_USASHP').AsString;
  End;

end;

function TAlterarPedido.fDefineAbastecimentoItens: Boolean;
Var
  objAbastecimentoItensPedido : TAbastecimentoItensPedido;
  LExibirProdutoEmEstoque: Boolean;
begin

  Result := True;

  If fatVenda.strEspDoc <> 'PD' Then
    Exit;

  If Not fCfgSis('SLTFRC', varBoolean) Then
    Exit;

  If FExibirTelaAbastecimento In [oeNaoExibir] Then
  Begin
    objAbastecimentoItensPedido := TAbastecimentoItensPedido.Create(fatVenda);
    Try
      objAbastecimentoItensPedido.pApagarAbastecimentosAnteriorSemPedidoCompra;
      If objAbastecimentoItensPedido.AbastecimentosPedido.Count = 0 Then
        fatVenda.strInRqCp := '';
    Finally
      objAbastecimentoItensPedido.Free;
    End;
  End;

  LExibirProdutoEmEstoque := FRealizarDesmembramento And
    (FExibirTelaAbastecimento In [oeExibirSempre]);

  Result := fatVenda.fDefineAbastecimentoItens(FExibirTelaAbastecimento,
    LExibirProdutoEmEstoque);

  If Result Then
  Begin
    If Assigned(fatVenda.objAbastecimentoItensPedido) Then
    Begin
      If fatVenda.objAbastecimentoItensPedido.TeveAlgumTipoAbastecimento Then
      Begin
        If (FExibirTelaAbastecimento = oeNaoExibir) And (Not FRealizarDesmembramento) Then
        Begin
          fMensagem('Atenção', 'Esse pedido necessita de algum tipo de abastecimento (Requisão de Compra ou Transferência de Estoque). Solicite a(o) operador(a) '+
                    fatVenda.strCodDig+'-'+fRetNomVendRep(fatVenda.strCodDig)+' para que o(a) mesmo(a) faça a alteração via a rotina de "Emissão de Faturamento > Pedido"', ['&Ok']);
          Result := False;
        End;
      End;
    End;
  End;
end;

function TAlterarPedido.fCarregarPedido: Boolean;
begin
  If Not VS_ExibirMensagemAguarde Then
    Exit(fCarregarPedidoInterna);
  Try
    pCriarFormularios(TfrmGravando, frmGravandoInterno);
    try
      frmGravandoInterno.fExecutarAcao := fCarregarPedidoInterna;
      frmGravandoInterno.ShowModal;
      Result := frmGravandoInterno.blnConfirma;
    finally
      pFreeAndNil(frmGravandoInterno);
    end;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

destructor TAlterarPedido.Destroy;
begin
  If Assigned(qryFatGor) Then FreeAndNil(qryFatGor);

  If Not blnFatVendaAssigned Then
  Begin
    If Assigned(fatVenda) Then FreeAndNil(fatVenda);
    pFreeCdsVenda;
  End;

  If Assigned(FStlEmpresas) Then
    FStlEmpresas.Free;

  inherited;
end;

function TAlterarPedido.fCalculaTotalPedido: Boolean;
begin
  If Not VS_ExibirMensagemAguarde Then
    Exit(fCalculaTotalPedidoInterna);
  Try
    pCriarFormularios(TfrmGravando, frmGravandoInterno);
    try
      frmGravandoInterno.fExecutarAcao := fCalculaTotalPedidoInterna;
      frmGravandoInterno.ShowModal;
      Result := frmGravandoInterno.blnConfirma;
    finally
      pFreeAndNil(frmGravandoInterno);
    end;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

function TAlterarPedido.fCalculaTotalPedidoInterna(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    arrDatas: TDateArray;
    blnMostraDigDuplic: Boolean;

  procedure pProgresso(strInformacao: String; intProgresso: Integer);
  begin
    If Assigned(pgbStatus) Then
      pRegistrarProgresso(strInformacao,
                          TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')),
                          pgbStatus, 0, intProgresso, 6);
  End;

begin
  Result := True;

  If blnRecalculaPrecos Then
  Begin
    fatVenda.pCalculaTaxVpr;
    If blnAlterouCndPag and (fatVenda.fltTaxVpr > 0) Then
      fatVenda.blnTaxVpr := True;

    pRecalculaPrecos(pgbStatus);

    If blnApenasVerificaSeItensTeraoModicacaoAposCondicaoPagamento Then
      Exit
  End;

  pProgresso('Inserindo Produtos. Etapa', 1);

  strInfoProcessamento := 'Aguarde, Inserindo produto %s...';

  fatVenda.pPreencheMatrizFechamento('', pOnProcessaItem);

  fatVenda.blnDeCndF := (fCfgSis('CNDVEN') = 'F');

  fatVenda.blnApagaPedOrcOrigem := False;
  If (fatVenda.fEhDesmembramentoExpedicaoRegimeEspecial) Then
  Begin
    If (fatVenda.fFatPedidoOutraLojaEmPedidoComEntCDOndeCDEhLojaAtual(fatVenda.arrMatItens)) Then
    Begin
      fatVenda.strNumOrigem := fatVenda.strNumOrc;
      fatVenda.strEspOrigem := fatVenda.strEspOrc;
      fatVenda.strEmpOrigem := fatVenda.strEmpOri;
      fatVenda.strNumOrc := '';//Necessario para gravar um novo documento
      fatVenda.strEspOrc := '';//Necessario para gravar um novo documento
      fatVenda.blnApagaPedOrcOrigem := True;
    End;
  End;

  If (fatVenda.blnEhTelaAltItensPed) Then
  Begin   
    fatVenda.fltValFre := fatVenda.fRetornaTotFreProporcionalConformeOriginal;
  End;

  If fatVenda.blnTaxVpr Then
    fatVenda.pCalculaTaxVpr;

  If (Pos(fatVenda.strOpcDoc, 'PD_OR_VN_CP_') > 0) And (fCfgSis('TAXENT', varBoolean)) Then
  Begin
    fatVenda.blnAplicaTaxaEntrega := True;
    fatVenda.pAtualizaValorTaxaEntrega;
  End;

  pProgresso('Calculando Peso Produtos. Etapa', 2);

  fatVenda.pCalculaPesBruLiq;

  If (fPermiteInformarPesoNoPedidoDeVenda) And (Not qryFatGor.IsEmpty) Then
  Begin
    fatVenda.fltPesBru := qryFatGor.FieldByName('FGO_PESBRU').AsFloat;
    fatVenda.fltPesLiq := qryFatGor.FieldByName('FGO_PESLIQ').AsFloat;
  End;

  If fCfgSis('CALVOL', varBoolean) Or (fRecalculaVolumeSeFaturadorAutomatico) Then
  Begin
    If (blnRecalculaVolumeDireto Or blnPerguntaSeRecalculaVolume) Then
    Begin
      If (Floor(fatVenda.fRetVolumes) <> fatVenda.intQtdTra) Then
      Begin
        If blnRecalculaVolumeDireto Then
        Begin
          fatVenda.intQtdTra := Floor(fatVenda.fRetVolumes);
        End
        Else If fMensagem('', 'Deseja atualizar a quantidade de volumes do pedido original e do novo pedido?', ['','']) = 1 Then
        Begin
          fatVenda.intQtdTra := Floor(fatVenda.fRetVolumes);
          blnRecalculaVolumeDireto := True;
        End
        Else If blnPerguntaSeRecalculaVolume Then
        Begin
          blnPerguntaSeRecalculaVolume := False;
        End;
      End;
    End;
  End;

  pProgresso('Calculando Valor Total. Etapa', 4);

  strInfoProcessamento := 'Aguarde, Calculando valor do produto %s...';

  if (fatVenda.blnCondicaoEspecial) and (fatVenda.blnCndEsp) then
  Begin
    if blnZerarDescontoDoItemRecalculoPrecos then
    Begin
      fatVenda.pSetBackupVar(VARIAVEIS_ZERA_PERCENTUAIS_DESCONTO_TRUE);
      fatVenda.pCalculaTotGer(blnZerarDescontoDoItemRecalculoPrecos, False, pOnProcessaItem);
      fatVenda.pGetBackupVar(VARIAVEIS_ZERA_PERCENTUAIS_DESCONTO_TRUE);
    End;
  End
  Else
    fatVenda.pCalculaTotGer(False, False, pOnProcessaItem);

  If fatVenda.fAplicaDescontoIcmsOrgaoPublicoNoDescontoEspecial Then
  Begin
    If (fatVenda.fltDesEsp <= 0.00) And (fatVenda.fltIcmOrg > 0) Then
      fatVenda.fltDesEsp := fatVenda.fltIcmOrg;
  End;

  fatVenda.pDestacaRetencoes;
  fatVenda.pRetemImpostosNoDescontoEspecial;

  If fRateiaFreteItensTransportadora(fatVenda.strCodTra, fatVenda.strTipFre) And (fatVenda.fltValFre > 0) Then
  Begin
    fatVenda.fltFreRat := fatVenda.fltValFre;
    fatVenda.fltValFre := 0.00;
    fatVenda.fltFreDig := 0.00;
  End;

  If (Not fatVenda.fHaveraDesmembramentoVenda(fatVenda.arrMatItens)) And
     (fatVenda.strEspDoc = 'IF') And fCfgSis('FRECUP', VarBoolean) Then
  Begin
    fatVenda.pInsereItemFreteNoCupomFiscal;
  End;

  fatVenda.pAplicarFreteComoAcrescimoNFCe;

  If fRateiaFreteItensTransportadora(fatVenda.strCodTra, fatVenda.strTipFre) And (fatVenda.fltValFre > 0) Then
  Begin
    fatVenda.fltFreRat := fatVenda.fltValFre;
    fatVenda.fltValFre := 0.00;
    fatVenda.fltFreDig := 0.00;
  End;

  if (fatVenda.blnCondicaoEspecial) and (fatVenda.blnCndEsp) then
  Begin
    if blnZerarDescontoDoItemRecalculoPrecos then
    Begin
      fatVenda.pSetBackupVar(VARIAVEIS_ZERA_PERCENTUAIS_DESCONTO_TRUE);
      fatVenda.pCalculaTotGer(blnZerarDescontoDoItemRecalculoPrecos, True, pOnProcessaItem);
      fatVenda.pGetBackupVar(VARIAVEIS_ZERA_PERCENTUAIS_DESCONTO_TRUE);
    End;
  End
  Else
    fatVenda.pCalculaTotGer(False, True, pOnProcessaItem);

  fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

  pProgresso('Calculando Total Parcelas. Etapa', 5);

  fatVenda.pCalculaTotalParaCadRec;

  If (fatVenda.fltValAdt > 0) And
     (fatVenda.blnEhTelaAltItensPed) Then
  Begin   
    fatVenda.fltTotCadRec := fatVenda.fltTotCadRec - fFormataFloat(fatVenda.fRetornaTotFreJaBaixado -
                                                                   fatVenda.fRetornaDesEspJaBaixado, 2);
  End;

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

function TAlterarPedido.fGravarPedido(blnComTransacao: Boolean = True): Boolean;

  function fRealizaValidacoes: Boolean;
  begin
    With FValidarPedido Do
    Begin
      blnPedirSenha := True;

      if blnSolicitouAlteracaoPreco then
      begin
        Result := fValidaUnitario And
                  fValidaVrMinimo;
      end
      else
      begin
        Result := fValidaLimiteCredito And
                  fValidaNaoCompra And
                  fValidaUnitario And
                  fValidaVrMinimo And
                  fValidaDebitosCliente And
                  fValidaEstoque And
                  fatVenda.fPedeLojasTE And
                  fatVenda.fPedeLojasColorantesTE;
      end;
    End;
  end;

  procedure pAtualizaDadosExpedicao;
    Var
      qryUpd: TUniQuery;
      strSQL: String;
  Begin
    qryUpd := fCriaQuery(Self);

    With qryUpd Do
    Begin
      strSQL := '';
      strSQL := strSQL + 'UPDATE     ';
      strSQL := strSQL + '  EXTGOR E ';
      strSQL := strSQL + '  INNER JOIN FATGOR F ON F.AUTOINCREM = E.FGO_SEQFGO ';
      strSQL := strSQL + 'SET      ';

      If Not fEmptyStr(strOpeExp) Then
        strSQL := strSQL + '  E.FGO_OPEEXP = :OPEEXP, ';

      If Not fEmptyStr(strSepExp) Then
        strSQL := strSQL + '  E.FGO_SEPEXP = :SEPEXP, ';

      strSQL := strSQL + '  E.FGO_OBSEXP = :OBSEXP, ';
      strSQL := strSQL + '  E.FGO_DTLBEX = :DTLBEX, ';
      strSQL := strSQL + '  E.FGO_HRLBEX = :HRLBEX  ';
      strSQL := strSQL + 'WHERE    ';
      strSQL := strSQL + '  F.FGO_NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + '  F.FGO_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  F.FGO_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  F.FGO_CODCLI = :CODCLI     ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(strOpeExp) Then
        ParamByName('OPEEXP').AsString := strOpeExp;

      If Not fEmptyStr(strSepExp) Then
        ParamByName('SEPEXP').AsString := strSepExp;

      ParamByName('OBSEXP').AsString   := strObsExp;
      ParamByName('DTLBEX').AsDatetime := dtaDtlBex;
      ParamByName('HRLBEX').AsDatetime := horHrlBex;

      ParamByName('NUMDOC').AsString   := fatVenda.strNumDoc;
      ParamByName('ESPDOC').AsString   := fatVenda.strEspDoc;
      ParamByName('CODEMP').AsString   := VS_strCodEmp;
      ParamByName('CODCLI').AsString   := fatVenda.strCodCli;
      ExecSQL;
    End;

    FreeAndNil(qryUpd);
  End;

begin
  Result := True;

  {************************************************************************************************************}
  {* Caso for emissao de pedido, configurado para travar a forma de pagamento negociada (F11-Resumo de caixa) *}
  {* e foi selecionado forma de pagamento Parcelado, entao pede as formas de pagamento                        *}
  {* negociadas com o cliente para travar no resumo de caixa...                                               *}
  {*********************************************************************************************************JC*}
  If (fatVenda.strEspDoc = 'PD') And (fatVenda.VS_blnUsaFpg) And
     (fCfgSis('TFPF11', varBoolean) Or fCfgSis('SFPGPD', varBoolean)) And
     fPos(fatVenda.strCodFpg, '009_013_') Then
  Begin
    With fatVenda, objFormasPagtoNegociada Do
    Begin
      strCodCar := '';
      intQtdPaC := 0;

      If fatVenda.fPedidoAPrazoComEntradaQuitada(fatVenda.strNumOrc, fatVenda.strEspOrc, VS_strCodEmp, fatVenda.FConPag) Then
      Begin
        pLimparFormasNegociadas;
        pAdicionarModalidadesNovoPedidoF11('008', fatVenda.FConPag, fltTotCadRec);
      End
      Else
        Result := fPedeFormasPagamento( strOpcDoc, strCodCli, strCodFpg,
                                        strCodCnd, strConPag, blnEnt_CD,
                                        fltDupRec + fltValAdt > 0, //Tem recebimento
                                        fltTotCadRec - fltValAdt,  //Valor Recebimento
                                        strCodFpg <> '013' );      //Pede Tela?

      If Result And fFormaPagtoSelecionada('007') Then
      Begin
        strCodCar := cdsFormasNegociadas.FieldByName('CODCAR').AsString;
        intQtdPaC := cdsFormasNegociadas.FieldByName('QTDPAR').AsInteger;
      End;
    End;
  End;

  If FValidarMargemValorCndPagto Then
    Result := Result And fatVenda.fVerificaIntervaloMargemValorCndPagto;

  If fatVenda.blnSolicitouFecharOREmPD Then
    Result := Result And fRealizaValidacoes();

  if blnSolicitouAlteracaoPreco then
    Result := Result And fRealizaValidacoes();

  Result := Result And fDefineAbastecimentoItens();

  If FRealizarDesmembramento And Result Then
  Begin
    If (Not fatVenda.blnFinali) And (Not fatVenda.blnMulLoj) Then
      fatVenda.blnFinali := fatVenda.fHaveraDesmembramentoVenda(fatVenda.arrMatItens);

    If (Not fatVenda.blnFinali) And (Length(fatVenda.arrMatItens) > 0) Then
      fatVenda.strFatTot := IIF(fatVenda.arrMatItens[0].blnFatPar, 'N', 'S');

    If (fatVenda.blnFinali) And
       (fatVenda.fEfetivarValidacaoDoPerfilDaCondicaoNosDocumentosDesmembrados) Then
    Begin
      If (Not fatVenda.fValidouValorMinimoNosDocumentosDesmembrados(True)) Then
        Exit(False);
    End;
  End;

  If fatVenda.DadosPixDaVenda.GerarPixDaVenda Then
    fatVenda.DadosPixDaVenda.ValorDoPix := fatVenda.fltTotGer;

  if blnTrocaCliente then
  begin
    fatVenda.strCodCli := Self.strCodCli;
    fatVenda.strNomCli := fRetNomCliente(Self.strCodCli);
  end;

  fatVenda.blnComTansacao := blnComTransacao;

  If Not Result Then
    Exit;

  Try
    If fatVenda.blnFinali Then
      fatVenda.dtaPreAnt := fatVenda.dtaPreVis;

    If Not VS_ExibirMensagemAguarde Then
    Begin
      If fatVenda.blnFinali Then
      Begin
        Result := fatVenda.fDesmembraPDORMultiLoja
      End
      Else
      Begin
        If FRealizarDesmembramento Then
        Begin
          fatVenda.blnEnt_CD := FEnt_CD;
          fatVenda.strEmp_CD := FEmp_CD;
        End;
        Result := fatVenda.fGravaArquivosDesmembrandoVenda;
      End;
    End
    Else
    Begin
      pCriarFormularios(TfrmGravando,frmGravandoInterno);
      try
        frmGravandoInterno.strChave := 'FATVENDAS';
        If fatVenda.blnFinali Then
        Begin
          frmGravandoInterno.fExecutarAcao := fatVenda.fDesmembraPDORMultiLoja
        End
        Else
        Begin
          If FRealizarDesmembramento Then
          Begin
            fatVenda.blnEnt_CD := FEnt_CD;
            fatVenda.strEmp_CD := FEmp_CD;
          End;
          frmGravandoInterno.fExecutarAcao := fatVenda.fGravaArquivosDesmembrandoVenda;
        End;
        frmGravandoInterno.ShowModal;
        Result := frmGravandoInterno.blnConfirma;
      finally
        pFreeAndNil(frmGravandoInterno);
      end;
    End;

    If Result And ((dtaDtlBex = 0) And (Not fEmptyStr(strOpeExp))) And (blnDesmembramentoAutomaticoPelaExpedicao) And (fExpediuTotal) Then // Se for expedição parcial
    Begin
      dtaDtlBex := VS_Date;
      horHrlBex := fTime();
    End;

    {***********************************************}
    {* SE O PEDIDO ALTERADO JÁ TINHA SIDO EXPEDIDO,*}
    {* DEVE MANTER AS INFORMAÇÕES DA EXPEDIÇÃO     *}
    {********************************************MM*}
    If Result And ((dtaDtlBex > 0) Or ((dtaDtlBex = 0) And (Not fEmptyStr(strOpeExp)))) Then //Caso dtaDtlBex seja zero mantem pelo menos c CÓDIGO DO SEPARADOR E CONFERENTE caso tenha - Req: 225192
      pAtualizaDadosExpedicao;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'');
    End;
  End;
end;

function TAlterarPedido.fTabelaPrecoClienteOuVendedor: String;
begin
  Result := fCampoTabela('CLI_TABPRE', 'CADCLI', ['CLI_CODCLI'], [fatVenda.strCodCli], False);
  If fEmptyStr(Result) And fCfgSis('HIETAB', VarBoolean) Then
    Result := fCampoTabela('OPE_TABPRE', 'CADOPE', ['OPE_CODOPE'], [fatVenda.strCodVen], False);
end;

function TAlterarPedido.fDocumentoSemTravaDePreco: Boolean;
var
  strBkpVS_strTRVEPR: string;
begin
  try
    blnAvisaTravaAtualizaPreco := True;
    strBkpVS_strTRVEPR := VS_strTRVEPR;
    VS_strTRVEPR := '2';
    Result := FValidarPedido.fValidaVrMinimo;
  finally
    VS_strTRVEPR := strBkpVS_strTRVEPR;
    blnAvisaTravaAtualizaPreco := False;
  end;

end;

function TAlterarPedido.fExpediuTotal: Boolean;
var
  qryDados: TUniQuery;
begin
  Result := False;

  qryDados := fCriaQuery;

  try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add('SELECT (SUM(FDO_QTDITE) - SUM(FDO_QTDEXP)) AS TOTAL ');
    qryDados.SQL.Add('FROM FATDOR');
    qryDados.SQL.Add('INNER JOIN EXTDOR');
    qryDados.SQL.Add('ON(FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO)');
    qryDados.SQL.Add('WHERE FDO_NUMDOC = :NUMDOC');
    qryDados.SQL.Add('AND FDO_ESPDOC = :ESPDOC');
    qryDados.SQL.Add('AND FDO_CODEMP = :CODEMP');
    qryDados.SQL.Add('AND FDO_CODCLI = :CODCLI');

    qryDados.ParamByName('NUMDOC').AsString := fatVenda.strNumDoc;
    qryDados.ParamByName('ESPDOC').AsString := fatVenda.strEspDoc;
    qryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryDados.ParamByName('CODCLI').AsString := fatVenda.strCodCli;

    qryDados.Open;

    if qryDados.IsEmpty then
      Exit;

    Result := qryDados.FieldByName('TOTAL').AsFloat = 0;
  finally
    FreeAndNil(qryDados);
  end;
end;

function TAlterarPedido.fRecalculaVolumeSeFaturadorAutomatico: Boolean;
begin
  Result := False;

  If Assigned(Self.fatVenda) Then
  Begin
    If (Self.fatVenda.blnExecutandoFaturadorAutomatico) And (Self.fatVenda.intQtdTra = 0) Then
    Begin
      Self.blnRecalculaVolumeDireto     := True;
      Self.blnPerguntaSeRecalculaVolume := False;
      Result := True;
    End;
  End;
end;

procedure TAlterarPedido.pInserirItemServico(strCodIte: String);
  Var
    qryCadIte,
    qryIteGer,
    qryAbfIcm: TUniQuery;
begin

  If fatVenda.fltTotSer <= 0 Then
    Exit;

  If fEmptyStr(strCodIte) Then
    Raise Exception.Create('Item de serviço não configurado.');

  qryCadIte := fCriaQuery(Self);
  qryIteGer := fCriaQuery(Self);
  qryAbfIcm := fCriaQuery(Self);

  qryCadIte.SQL.Add('SELECT * FROM CADITE WHERE ITE_CODITE = :CODITE');
  qryCadIte.ParamByName('CODITE').AsString := strCodIte;
  qryCadIte.Open;

  qryIteGer.SQL.Add('SELECT * FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP');
  qryIteGer.ParamByName('CODITE').AsString := strCodIte;
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

procedure TAlterarPedido.pLoadEmpSaldo;
begin
  FStlEmpresas := TStringList.Create;
  FStlEmpresas.Text := AnsiReplaceStr(
    fCampoTabela('GROUP_CONCAT(EMP_CODEMP, "-", EMP_NOMFAN ORDER BY EMP_CODEMP SEPARATOR "' +
      STRING_QUEBRA + '")', 'CADEMP', [], []), STRING_QUEBRA, STRING_ENTER);
end;

procedure TAlterarPedido.pCarregaForPag(strForPag: String);
begin
  If Assigned(edtForPag) Then
    edtForPag.Text := strForPag;

  If Not fEmptyStr(strForPag) Then
  Begin
    fatVenda.strCodFpg := strForPag;
    fatVenda.strDesFpg := fRetDesFpg(strForPag);

    If Assigned(edtDesFpg) Then
      edtDesFpg.Text     := fatVenda.strDesFpg;
  End
  Else
  Begin
    fatVenda.strCodFpg := '';
    fatVenda.strDesFpg := '';

    If Assigned(edtDesFpg) Then
      edtDesFpg.Text := '';
  End;
end;

procedure TAlterarPedido.pCarregaCondicao(strCodCnd: String; dtaDtaBas: TDateTime = 0);
  Var
    dtaBasTmp: TDateTime;
    strTabPrecoFat: string;
    intIndice: integer;
    frmFatSelecaoTabelaPreco: TfrmFatSelecaoTabelaPreco;
begin
  If (dtaDtaBas > 0) And (dtaDtaBas >= VS_Date) Then
    dtaBasTmp := dtaDtaBas
  Else
    dtaBasTmp := Vs_Date;
    
  pPesquisaCadCnd(qryConCnd, qryConCnd, strCodCnd);

  If Assigned(edtCodCnd) Then
    edtCodCnd.Text := strCodCnd;

  If ( Not qryConCnd.IsEmpty ) Then
  Begin

    With qryConCnd Do
    Begin

      If ( FieldByName('CND_TIPFOR').AsString = 'OUTROS' ) Then
      Begin
        If (Not fatVenda.blnMeiaNota) And (Not fatVenda.blnCortPD) Then
          fatVenda.strConPag := FieldByName('CND_CNDPAG').AsString;

        If Assigned(mskCndPag) Then
        Begin
          mskCndPag.Enabled     := True;
          mskCndPag.Color       := clWindow;
          mskCndPag.NormalColor := clWindow;
          mskCndPag.Text        := fatVenda.strConPag;
        End;

      End
      Else
      Begin
        fatVenda.strConPag := fRetCondicao(fatVenda.fRetConPagRef(FieldByName('CND_CODIGO').AsString),
                                           fatVenda.dtaUltDtaAlt,
                                           FieldByName('CND_CODIGO').AsString,
                                           FieldByName('CND_TIPFOR').AsString,
                                           FieldByName('CND_CNDPAG').AsString,
                                           dtaBasTmp,
                                           strEspPed,
                                           fatVenda.strCodCid);

        If Assigned(mskCndPag) Then
        Begin
          mskCndPag.Enabled     := False;
          mskCndPag.Color       := $00FFDFB8;
          mskCndPag.NormalColor := $00FFDFB8;
          mskCndPag.Text        := fatVenda.strConPag;
        End;

      End;

      If Not fatVenda.fDocumentoParaFornecedor Then
      Begin
        fatVenda.strConPag := fRetCondicaoDiaFixoCliente(fatVenda.fRetConPagRef(FieldByName('CND_CODIGO').AsString), fatVenda.dtaUltDtaAlt, fatVenda.strCodCli, fatVenda.strConPag, dtaBasTmp, strEspPed, fatVenda.strCodCid);

        If Assigned(mskCndPag) Then
          mskCndPag.Text := fatVenda.strConPag;
      End;

      If fatVenda.VS_blnUsaFpg And Not fEmptyStr(FieldByName('CND_CODFPG').AsString) Then
      Begin
        fatVenda.strCodFpg := FieldByName('CND_CODFPG').AsString;

        If Assigned(edtForPag) Then
        Begin
          edtForPag.Text     := FieldByName('CND_CODFPG').AsString;
          edtForPag.ReadOnly := True;
        End;

        pCarregaForPag(fatVenda.strCodFpg);
      End
      Else If Assigned(edtForPag) Then
        edtForPag.ReadOnly := False;

      If (Not fEmptyStr(Trim(StringReplace(FieldbyName('CND_PRETAB').AsString,'N','',[rfReplaceAll, rfIgnoreCase])))) And
         (blnAtualizaTabPreCnd) And (fEmptyStr(fatVenda.strCodCnd) Or (fatVenda.strCodCnd <> qryConCnd.FieldByName('CND_CODIGO').AsString)) Then
      begin
        strTabPrecoFat := fDevolveTabelaPreco(FieldbyName('CND_PRETAB').AsString);
        if (Length(strTabPrecoFat) > 1) And (Not blnSimulandoVenda) then
        begin
          try
            pCriarFormularios(TfrmFatSelecaoTabelaPreco,frmFatSelecaoTabelaPreco);
            frmFatSelecaoTabelaPreco.cbbTabPre.Clear;
            frmFatSelecaoTabelaPreco.cbbTabPre.Items.Add('');
            for intIndice := 1 to Length(strTabPrecoFat) do
            begin
              frmFatSelecaoTabelaPreco.cbbTabPre.Items.Add(strTabPrecoFat[intIndice]);
            end;
            frmFatSelecaoTabelaPreco.cbbTabPre.ItemIndex := 0;
            frmFatSelecaoTabelaPreco.ShowModal;
            if frmFatSelecaoTabelaPreco.ModalResult = mrOk then
            begin
              strTabPrecoFat := frmFatSelecaoTabelaPreco.cbbTabPre.Text;
            end;
          finally
            pFreeAndNil(frmFatSelecaoTabelaPreco);
          end;
        end
        else if (Length(strTabPrecoFat) > 1) And (blnSimulandoVenda) then
        begin
          if (fEmptyStr(fatVenda.strTabPre)) Then
            strTabPrecoFat := strTabPrecoFat[1]
          else
            strTabPrecoFat := fatVenda.strTabPre;
        end;
        fatVenda.strTabPre := strTabPrecoFat;
      End;

      fatVenda.strCodCnd := FieldByName('CND_CODIGO').AsString;
      fatVenda.strDesCnd := FieldByName('CND_DESCRI').AsString;
      fatVenda.blnCndEsp := (fRetEspConPag(FieldByName('CND_CODIGO').AsString) = 'S');

      fatVenda.DadosPixDaVenda.GerarPixDaVenda := False;
      If fCfgSis('USAPIX', varBoolean) Then
        fatVenda.DadosPixDaVenda.GerarPixDaVenda := FieldByName('CND_RECPIX').AsString = 'S';

      If Assigned(edtDesCnd) Then
        edtDesCnd.Text := fatVenda.strDesCnd;
    End;
  End
  Else If Assigned(edtDesCnd) Then
    edtDesCnd.Clear;

  fatVenda.pAtualizaInformacoesCondPagamento(qryConCnd);    
end;

procedure TAlterarPedido.pRecalculaPrecos(pgbStatus: TcxProgressBar = nil);
  Var
    fltDescontoCndDestacado,
    fltUniDol,
    fltUnitar,
    fltDesMax,
    fltComTbl: Double;
    strTabela: String;
    fltQtdDis,
    fltUniLot: Double;
    blnParticiona: Boolean;
    blnPromo: Boolean;
    blnItemEspecial: Boolean;
    prcScroll: TprcScroll;
    blnAplicarTaxaJuros : Boolean;

  procedure pProgresso(strInformacao: String; intProgresso: Integer);
  begin
    If Assigned(pgbStatus) Then
      pRegistrarProgresso(strInformacao,
                          TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')),
                          pgbStatus, 0, intProgresso, cdsVenda.RecordCount);
  End;

  function fRetEmpresaItem: String;
  Begin
    With cdsVenda Do
      Result := IIF(fatVenda.blnEmpFat, IIF(fEmptyStr(FieldByName('ITE_EMPITE').AsString),
        VS_strCodEmp, FieldByName('ITE_EMPITE').AsString), VS_strCodEmp);
  End;

  function fUnitariosDiferentes: Boolean;
  begin
    Result := (fFormataFloat(fltUnitar, 4) <> fFormataFloat(cdsVenda.FieldByName('ITE_UNITAR').AsFloat, 4));
  end;
  
  function fPodeAplicarDescontoCondicaoPagamento: Boolean;
  begin
    Result := True;

    If fatVenda.fItemPromocaoUsandoF3PuroComCondicaoNoFinal And fUnitariosDiferentes Then
    Begin
      //Se item em promoção e unitários diferentes não pode aplicar desconto da condição
      Result := False;
    End;
  end;

begin
  Try
    pDisableControls(cdsVenda, prcScroll);

    fatVenda.intPrzMed := fFloatToInt(fCalcMediaPagto(fatVenda.strConPag));

    If fEmptyStr(fatVenda.strTabPre) then
      fatVenda.strTabPre := '1';

    With cdsVenda Do
    Begin
      First;

      While Not Eof Do
      Begin
        pProgresso('Recalculando Preços ', RecNo);

        fatVenda.strIdePro := FieldByName('ITE_IDEPRO').AsString;

        blnItemEspecial := (Pos('ITEM ESPECIAL', FieldByName('ITE_DESORI').AsString) > 0);

        fatVenda.fltPreVe1 := FieldByName('ITE_PREVE1').AsFloat;
        fatVenda.fltPreVe2 := FieldByName('ITE_PREVE2').AsFloat;
        fatVenda.fltPreVe3 := FieldByName('ITE_PREVE3').AsFloat;
        fatVenda.fltPreVe4 := FieldByName('ITE_PREVE4').AsFloat;
        fatVenda.fltPreVe5 := FieldByName('ITE_PREVE5').AsFloat;
        fatVenda.fltPreVe6 := FieldByName('ITE_PREVE6').AsFloat;
        fatVenda.fltPreVe7 := FieldByName('ITE_PREVE7').AsFloat;
        fatVenda.fltPreLot := FieldByName('ITE_PRELOT').AsFloat;

        If blnApenasVerificaSeItensTeraoModicacaoAposCondicaoPagamento Then
          fltUnitar := 0.00;

        {************************************}
        { DEFINI A TABELA DE PRECO DE ACORDO }
        { COM A CONFIGURACAO                 }
        {*********************************JB*}
        If (fatVenda.strIdePro = 'NOR') Then
        Begin
          If (fCfgSis('TABITE', varBoolean)) And (Not blnAltTabelaPreco) And (FieldByName('ITE_TABPRE').AsString <> '') Then
            strTabela := FieldByName('ITE_TABPRE').AsString
          Else
            strTabela := fatVenda.strTabPre;
        End
        Else
        Begin
          If (fCfgSis('PRTTIN') = 'S') Then
          Begin
            If (fCfgSis('TABITE', varBoolean)) And (Not blnAltTabelaPreco) And (FieldByName('ITE_TABPRE').AsString <> '') Then
              strTabela := FieldByName('ITE_TABPRE').AsString
            Else
              strTabela := fatVenda.strTabPre;
          End
          Else If fEmptyStr(fatVenda.strTabTin) And fEmptyStr(fTabelaPrecoClienteOuVendedor) Then
          Begin
            strTabela := fatVenda.strTabPre;
          End
          Else
          Begin
            If fEmptyStr(fatVenda.strTabTin) Then
              strTabela := fTabelaPrecoClienteOuVendedor
            Else
              strTabela := fatVenda.strTabTin;
          End;
        End;

        If (fatVenda.stlItensNaoTemQtdeEmbFec.IndexOf(FieldByName('ITE_CODITE').AsString) = -1) And
           (Not fTemQuantEmbalagemFechada(FieldByName('ITE_CODITE').AsString)) Then
        Begin
          fatVenda.stlItensNaoTemQtdeEmbFec.Add(FieldByName('ITE_CODITE').AsString);
        End;

        If (fatVenda.stlItensNaoEhEstrutura.IndexOf(FieldByName('ITE_CODITE').AsString) = -1) And
           (Not fItemEstrutura(FieldByName('ITE_CODITE').AsString)) Then
        Begin
          fatVenda.stlItensNaoEhEstrutura.Add(FieldByName('ITE_CODITE').AsString);
        End;

        If (fatVenda.stlItensNaoTemLote.IndexOf(FieldByName('ITE_CODITE').AsString) = -1) And
           (fatVenda.objCadLot.fItemSemNenhumLote(FieldByName('ITE_CODITE').AsString)) Then
        Begin
          fatVenda.stlItensNaoTemLote.Add(FieldByName('ITE_CODITE').AsString);
        End;

        {*********************************************}
        {* ATUALIZA A VARIAVEL DO PREÇO COM DESCONTO *}
        {* PARA PODER USA-LA NO RECALCULO.           *}
        {* fltProPreVen                             *}
        {******************************************AC*}
        fatVenda.strPromoc := 'N';
        If (Not fatVenda.blnCliFil) And (fatVenda.strIdePro = 'NOR') And
           (fatVenda.fItemPassivelDeVerificacaoPromo(FieldByName('ITE_CODITE').AsString, fRetEmpresaItem)) Then
        Begin
          If fRetornaPrecosPromocao(FieldByName('ITE_CODITE').AsString,  //aqui promoc
                                    fatVenda.strCodCli,
                                    VS_Date,
                                    FieldByName('ITE_QTDITE').AsFloat,

                                    fatVenda.fRetQtdDigitada(FieldByName('ITE_CODITE').AsString,
                                                             '',
                                                             FieldByName('AUTOINCREM').AsString,
                                                             '',
                                                             '',
                                                             FieldByName('ITE_EMPITE').AsString,
                                                             False),

                                    fatVenda.fRetQtdDigitada(FieldByName('ITE_CODITE').AsString,
                                                             '',
                                                             FieldByName('AUTOINCREM').AsString,
                                                             '',
                                                             '',
                                                             FieldByName('ITE_EMPITE').AsString,
                                                             False,
                                                             False,
                                                             fatVenda.fDesconsiderarNaQtdLimDaPromoItensUnitarMaior,
                                                             True {Somente em promocao}),

                                    fatVenda.intPrzMed,
                                    fatVenda.fltProPreCus,
                                    fatVenda.fltProPreVen,
                                    fatVenda.fltProComVar,
                                    fatVenda.fltProComAta,
                                    fatVenda.fltProComDis,
                                    fltQtdDis,
                                    fatVenda.fltProDesF07,
                                    fatVenda.strComPro,
                                    fatVenda.strCodPro,
                                    blnParticiona,
                                    blnPromo,
                                    strTabela,
                                    fatVenda.strCodCnd,
                                    '',
                                    '',
                                    True,
                                    False,
                                    '-1',
                                    ((FieldByName('ITE_ENTRET').AsString = 'E') And (FieldByName('ITE_ENTFUT').AsString = 'N')),
                                    ((FieldByName('ITE_ENTRET').AsString = 'E') And (FieldByName('ITE_ENTFUT').AsString = 'S')),
                                    FieldByName('ITE_MOTFUT').AsString,
                                    fRetEmpresaItem,
                                    fatVenda.strNumOrc,
                                    fatVenda.strEspOrc) Then
          Begin
            If Not blnParticiona Then
              fatVenda.strPromoc := 'S';
          End;
        End;

        fltUniDol := 0.0;

        If blnRecalcularSomentePrecosComCotacaoDolar Then
        Begin
          If Not fItemUtilizaPrecoEmDolar(FieldByName('ITE_CODITE').AsString) Then
          Begin
            Next;
            Continue;
          End;

          If fFormataFloat(fatVenda.fltVlCtVn, 6) <= 0 Then
          Begin
            Next;
            Continue;
          End;

          fltUniDol := FieldByName('ITE_UNIDOL').AsFloat;

          If fFormataFloat(fltUniDol, 6) <= 0 Then
          Begin
            Next;
            Continue;
          End;
        End;

        {**************************************}
        {* CASO ESTIVER CONFIGURADO NO AUTTIN *}
        {* PARA UTILIZAR PREÇO DA TABELA FIXA *}
        {* RECALCULAR UTILIZANDO TAL TABELA.  *}
        {***********************************MV*}
        If ((fatVenda.strIdePro <> 'NOR') Or Not fEmptyStr(FieldByName('ITE_CODACA').AsString)) And
           (fCfgSis('PREGER') = '1') And
           (fCfgSis('PRTTIN') = 'N') Then
        Begin
          strTabela := fCfgSis('TABPRE');
        End;

        If strTabela = FieldByName('ITE_TABPRE').AsString Then
          fltComTbl := FieldByName('ITE_COMTBL').AsFloat
        Else
          fltComTbl := fCampoTabela('ITE_COMTB' + strTabela,
                                    'ITEGER',
                                    ['ITE_CODITE', 'ITE_CODEMP'],
                                    [FieldByName('ITE_CODITE').AsString, VS_StrCodEmp]);

        If (fatVenda.stlItensNaoTemLote.IndexOf(FieldByName('ITE_CODITE').AsString) = -1) And

           (Not fatVenda.fEhEmissaoDocumentoWMS) And

           (Not fatVenda.fEmpresaParaFaturamentoUsaWMS(FieldByName('ITE_EMPITE').AsString)) And

           (fatVenda.objCadLot.fExisteLote(FieldByName('ITE_CODITE').AsString,
                                           IIF(fatVenda.blnEmpFat,
                                           FieldByName('ITE_EMPITE').AsString,
                                           VS_strCodEmp),
                                           FieldByName('ITE_NUMLOT').AsString)) And

           fatVenda.fCalculaPrecosLote(FieldByName('ITE_QTDITE').AsFloat, fltUniLot, strTabela) Then
        Begin
          fatVenda.fltUniVis := fltUniLot;
          fltUnitar := fatVenda.fltUniVis;
          fatVenda.fltTaxJur := 0.00;

          If fatVenda.fAplicaTaxaJuros And fAplicarTaxaJurosPrecoSugestao Then
          Begin
            fatVenda.fltTaxJur := fatVenda.fGetTaxVprItem(FieldByName('ITE_CODITE').AsString, FieldByName('ITE_EMPITE').AsString);
            fltUnitar := fltUnitar + fFormataFloat(fltUnitar * (fatVenda.fGetTaxVprItem(FieldByName('ITE_CODITE').AsString, FieldByName('ITE_EMPITE').AsString) / 100.0), 04);
          End;
        End

        Else If SameText(fCfgSis('SUGVLE'), '1') Then
          fltUnitar := fatVenda.fPegaPrecoVenda( cdsVenda, FieldByName('ITE_EMPITE').AsString, FieldByName('ITE_ENTSAI').AsString,
                                                 fatVenda.fltMargem, blnItemEspecial,
                                                 fatVenda.strIdePro, strTabela, True, fatVenda.FTaxJur, fatVenda.FUniVis )
        Else
        Begin

          If (fatVenda.stlItensNaoEhEstrutura.IndexOf(FieldByName('ITE_CODITE').AsString) = -1) Then
          Begin
            blnAplicarTaxaJuros := fatVenda.fAplicaTaxaJuros And fAplicarTaxaJurosPrecoSugestao;
            fatVenda.fltUniVis := fatVenda.fCalculaPrecoEstrutura( blnAplicarTaxaJuros,
                                                                   Preco_de_Venda,
                                                                   FieldByName('ITE_CODITE').AsString,
                                                                   FieldByName('ITE_EMPITE').AsString,
                                                                   FieldByName('ITE_ENTSAI').AsString,
                                                                   strTabela,
                                                                   fatVenda.fltMargem );
            fltUnitar := fatVenda.fltUniVis;
            fatVenda.fltTaxJur := 0.00;

            If blnAplicarTaxaJuros Then
            Begin
              fatVenda.fltTaxJur := fatVenda.fGetTaxVprItem(FieldByName('ITE_CODITE').AsString, FieldByName('ITE_EMPITE').AsString);
              fltUnitar := fltUnitar + fFormataFloat(fltUnitar * (fatVenda.fGetTaxVprItem(FieldByName('ITE_CODITE').AsString, FieldByName('ITE_EMPITE').AsString) / 100.0), 04);
            End;
          End

          Else fltUnitar := fatVenda.fPegaPrecoVenda( cdsVenda, FieldByName('ITE_EMPITE').AsString, FieldByName('ITE_ENTSAI').AsString,
                                                      fatVenda.fltMargem, blnItemEspecial,
                                                      fatVenda.strIdePro, strTabela, True,
                                                      fatVenda.FTaxJur, fatVenda.FUniVis );
        End;

        fatVenda.pCalculaValorRT(fltUnitar, fatVenda.FVal_RT);

        fatVenda.fltUniOri := fltUnitar;

        {************************************************}
        {* VERIFICA SE EH MULTIPLO DE EMBALAGEM FECHADA *}
        {* APLICA O DESCONTO PARA EMBALAGEM FECHADA     *}
        {********************************************JC**}
        If (fatVenda.stlItensNaoTemQtdeEmbFec.IndexOf(FieldByName('ITE_CODITE').AsString) = -1) And
           (fEhEmbalagemFechadaItem(FieldByName('ITE_CODITE').AsString, strTabela, FieldByName('ITE_QTDITE').AsFloat)) And
           (fatVenda.strPromoc <> 'S') Then
        Begin
          fltUnitar := fltUnitar * ( 1 - ( fPercDescEmbalagemFechadaItem(FieldByName('ITE_CODITE').AsString, strTabela, FieldByName('ITE_QTDITE').AsFloat, '') / 100 ) );
        End;

        If Not fEmptyStr(FieldByName('ITE_BAREMB').AsString) And fCfgSis('PRVEMB', VarBoolean) And (fatVenda.strPromoc <> 'S') Then
        Begin
          If fRetornaPrecoCodBarraEmb( FieldByName('ITE_CODITE').AsString,
                                       FieldByName('ITE_BAREMB').AsString,
                                       VS_strCodEmp,
                                       strTabela,
                                       False) > 0 Then
          Begin
            fltUnitar := fRetornaPrecoCodBarraEmb( FieldByName('ITE_CODITE').AsString,
                                                   FieldByName('ITE_BAREMB').AsString,
                                                   VS_strCodEmp,
                                                   strTabela,
                                                   False);
            fatVenda.fltUniOri := fltUnitar;
          End;
        End;

        {**************************************************}
        {* ATUALIZA A TAB DE PREÇOS DO ITEM NA TEMPORARIA *}
        {***********************************************LU*}
        If blnAltTabelaPreco Or ((fatVenda.strIdePro <> 'NOR') And (FieldByName('ITE_TABPRE').AsString <> strTabela) And (fCfgSis('PRTTIN') = 'N')) Then
        Begin
          If (Not blnApenasVerificaSeItensTeraoModicacaoAposCondicaoPagamento) Then
          Begin
            Edit;
            FieldByName('ITE_TABPRE').AsString := strTabela;
            Post;
          End;
        End;

        If (Not blnRecalcularSomentePrecosComCotacaoDolar) And (blnVerUniOriginal) Then
        Begin

          If (fFormataFloat(fltUnitar, 2) = fFormataFloat(FieldByName('ITE_UNIORI').AsFloat, 2)) Then
          Begin
            Next;
            Continue;
          End;

        End;

        If (Not blnRecalcularSomentePrecosComCotacaoDolar) And
           (IIF(blnModuloAltCondPagtoPedido, Not Self.blnAtualizaTabPreCnd, True)) And
           ((fatVenda.strPromoc = 'N') And (fConfiguradoParaRecalcularSomenteItensEmPromocao)) Then
        Begin
          Next;
          Continue;
        End;

        fltDescontoCndDestacado := 0; 
        {*******************************************}
        {* CASO ABATE O DESCONTO AUTOMATICAMENTE,  *}
        {* APLICA O PERCENTUAL DE DESCONTO         *}
        {****************************************MV*}
        If (fatVenda.strCAbDes = 'S') And
           ((fCfgSis('CNDVEN') = 'I') Or (fatVenda.fUsandoF3PuroComCondicaoNoFinal)) And
           ((fatVenda.strPromoc <> 'S') Or (fPodeAplicarDescontoCondicaoPagamento And (fatVenda.fRegraPrecoSugestaoAtiva = TRegraPrecoSugestao.PrecoDeTabela))) And
           (Not fAplicarTaxaJurosPrecoDigitado) Then
        Begin
          {********************************************************************}
          {* CASO ESTEJA CONFIGURADO PARA UTILIZAR DESC. MÁX POR LINHA/GRUPO  *}
          {* DO PRODUTO E CONDIÇÃO INFORMADOS, ALTERA fltDMGCnd/fltDMVCnd     *}
          {****************************************************************MM**}
          fltDesMax := fatVenda.fRetornaDescLinGru(FieldByName('ITE_CODITE').AsString, fatVenda.strCodCnd);

          If fCfgSis('DESCND',varBoolean) Then
          Begin
            If fCampoTabela('ITE_DESCND','CADITE', ['ITE_CODITE'], [FieldByName('ITE_CODITE').AsString]) = 'S' Then
            Begin
              fltUnitar               := fatVenda.fltUniOri;
              fltDescontoCndDestacado := fltDesMax;
            End
            Else
              fltUnitar := fatVenda.fltUniOri;
          End

          Else If (fatVenda.strCodFpg = '007') Then
          Begin
            If (fatVenda.strAbDeCc = 'S') Then
              fltUnitar :=  fltUnitar - fatVenda.fRetornaVrDesconto(2, fltUnitar, fltDesMax);
          End
          Else
            fltUnitar :=  fltUnitar - fatVenda.fRetornaVrDesconto(2, fltUnitar, fltDesMax);
        End;

        If blnUtilizaVendaMadOuVidOuMtL Then
          fltUnitar := fltUnitar + fatVenda.fRetornaVrAcrescApaBen(fltUnitar, FieldByName('ITE_PERAPA').AsFloat, FieldByName('ITE_PERBEN').AsFloat);

        If fAplicarTaxaJurosPrecoDigitado Then
          fltUnitar := FieldByName('ITE_UNIDIG').AsFloat;

        If (blnApenasVerificaSeItensTeraoModicacaoAposCondicaoPagamento) Then
        Begin
          If fCfgSis('PROCXA', VarBoolean) Then
          Begin
            If (fCfgSis('RECCND', varBoolean)) Or (fCfgSis('RECPRO', varBoolean)) Then
            Begin
              If (Not blnItensEntraramOuSairamDePromocao) Then
              Begin
                If (fCfgSis('PRMF11', varInteger) = 1) Then
                Begin
                  //PRMF11 = 1 - Preço Promoção
                  blnItensEntraramOuSairamDePromocao := (fatVenda.strPromoc <> FieldByName('ITE_PROMOC').AsString);
                End
                Else
                Begin
                  //PRMF11 = 2 - Preço Tabela
                  If fatVenda.strPromoc = 'S' Then
                  Begin
                    If (fCfgSis('RECCND', varBoolean)) And (fltUnitar > 0.00) Then 
                      blnItensEntraramOuSairamDePromocao := (fUnitariosDiferentes);
                  End;  
                End;                                      
              End;
            End;
          End;
          
          If fCfgSis('CNDCXA', VarBoolean) Then
          Begin
            If (fCfgSis('RECCND', varBoolean)) And (fltUnitar > 0.00) Then
            Begin
              If (Not blnItensTiveramUnitarModificados) Then
              Begin
                blnItensTiveramUnitarModificados := (fUnitariosDiferentes);
              End;
            End;
          End;

          Next;
          Continue;
        End;

        Edit;
        
        FieldByName('ITE_COMTBL').AsFloat := fltComTbl;
        FieldByName('ITE_TAXJUR').AsFloat := fatVenda.fltTaxJur;
        FieldByName('ITE_UNIVIS').AsFloat := fatVenda.fltUniVis;
        FieldByName('ITE_UNIORI').AsFloat := fatVenda.fltUniOri;
        FieldByName('ITE_VAL_RT').AsFloat := fatVenda.fltVal_RT;

        If blnRecalcularSomentePrecosComCotacaoDolar Then
        Begin
          FieldByName('ITE_DESCON').AsFloat  := 0.0;
          FieldByName('ITE_UNIDIG').AsFloat  := fFormataFloat(fltUniDol * fatVenda.fltVlCtVn, fatVenda.VS_intDecUni);
          FieldByName('ITE_UNITAR').AsFloat  := fFormataFloat(fltUniDol * fatVenda.fltVlCtVn, fatVenda.VS_intDecUni);
          FieldByName('ITE_TOTITE').AsFloat  := fFormataFloat(FieldByName('ITE_UNITAR').AsFloat * FieldByName('ITE_QTDITE').AsInteger, 2);
        End
        Else
        Begin
          FieldByName('ITE_UNIDIG').AsFloat := fFormataFloat(fltUnitar, fCfgSis('DECUNI', varInteger));

          If fatVenda.fAplicaTaxaJuros Then
          Begin
            If fAplicarTaxaJurosPrecoDigitado Then
            Begin
              fatVenda.fltTaxJur := fatVenda.fGetTaxVprItem(FieldByName('ITE_CODITE').AsString, FieldByName('ITE_EMPITE').AsString);

              fltUnitar := fltUnitar + (fltUnitar * fatVenda.fltTaxJur / 100.0);

              FieldByName('ITE_TAXJUR').AsFloat := fatVenda.fltTaxJur;
            End;
          End;

          If (fCfgSis('DESCND',varBoolean)) And
             (fCampoTabela('ITE_DESCND','CADITE', ['ITE_CODITE'], [FieldByName('ITE_CODITE').AsString]) = 'S') Then
          Begin
            fltUnitar := fltUnitar - fatVenda.fRetornaVrDesconto(2, fltUnitar, fltDescontoCndDestacado);
            FieldByName('ITE_DESCON').AsFloat := fltDescontoCndDestacado;
          End
          Else
          begin
            fltUnitar := fltUnitar - fatVenda.fRetornaVrDesconto(2, fltUnitar, FieldByName('ITE_DESCON').AsFloat)
          End;

          FieldByName('ITE_UNITAR').AsFloat := fltUnitar;

          FieldByName('ITE_TOTITE').AsFloat := fFormataFloat(FieldByName('ITE_QTDITE').AsFloat * fltUnitar, 02);
        End;

        If (fatVenda.strIdePro <> 'NOR') Then
        Begin
          FieldByName('ITE_PRVTIN').AsFloat := fltUnitar;
        End;

        fatVenda.pCarregaValoresCusto(FieldByName('ITE_CODITE').AsString, fatVenda.fGetEmpCalculoItem(fRetEmpresaItem), fatVenda.strTabPre);

        FieldByName('ITE_MARLUC').AsFloat := fCalculaPrecoVenda(2, fatVenda.fRetPreCus(FieldByName('ITE_PRECUS').AsFloat) + fatVenda.fRetOutVal(FieldByName('ITE_OUTVAL').AsFloat),
                                                                   fltUnitar,
                                                                   0,
                                                                   fatVenda.fRetIcmSai(FieldByName('ITE_ICMSAI').AsFloat),
                                                                   fatVenda.fRetImpFed(FieldByName('ITE_IMPFED').AsFloat),
                                                                   fatVenda.fRetDesOpe(FieldByName('ITE_DESOPE').AsFloat),
                                                                   fltComTbl, fatVenda.VS_strMARMKP); //(%) COMISSAO DA TABELA DE PRECO DO ITEM

        FieldByName('FLG_STATUS').AsString:= fatVenda.strStatus;
        FieldByName('ITE_PROMOC').AsString:= fatVenda.strPromoc;
        FieldByName('ITE_CODPRO').AsString:= fatVenda.strCodPro;

        If FieldByName('ITE_UNIORI').AsFloat <> 0 Then
          FieldByName('ITE_VARTAB').AsFloat := ( ( FieldByName('ITE_UNITAR').AsFloat /
                                                   FieldByName('ITE_UNIORI').AsFloat ) - 1 ) * 100;

        Post;
        Next;
      End;

    End;

    fatVenda.fltPreVe1 := 0.0;
    fatVenda.fltPreVe2 := 0.0;
    fatVenda.fltPreVe3 := 0.0;
    fatVenda.fltPreVe4 := 0.0;
    fatVenda.fltPreVe5 := 0.0;
    fatVenda.fltPreVe6 := 0.0;
    fatVenda.fltPreVe7 := 0.0;
    fatVenda.fltPreLot := 0.0;
  Finally
    pEnableControls(cdsVenda, prcScroll);  
  End;

end;

procedure TAlterarPedido.pRegistrarProgresso(strTexto: String;
  lblInformacao: TLabel; pgbProgresso: TcxProgressBar; intInicio, intAtual, intFinal: Integer);
begin
  pgbProgresso.Properties.Max := intFinal;
  pgbProgresso.Properties.Min := intInicio;
  pgbProgresso.Position := intAtual;
  lblInformacao.Caption := Format('%s %d / %d',  [strTexto ,intAtual, intFinal]);
  pProcessMessages;
end;

procedure TAlterarPedido.pOnAdicionouItemDoPedido;
Var
  recItem: TThreadCarregarSaldoEmpresasGrid.TItem;
  recEmpSal: TThreadCarregarSaldoEmpresasGrid.TEmpSaldo;
begin
  If blnExibeSaldoGrid Then
  Begin
    recItem := TThreadCarregarSaldoEmpresasGrid.GetSaldoLojas(cdsVenda.FieldByName('ITE_CODITE').AsString,
                                                              cdsVenda.FieldByName('ITE_NUMLOT').AsString,
                                                              cdsVenda.FieldByName('ITE_EMPITE').AsString,
                                                              fatVenda);
    cdsVenda.Edit;
    cdsVenda.FieldByName('ESTFIL').AsFloat := recItem.fltEstFil;
    cdsVenda.FieldByName('ESTLOJ').AsFloat := recItem.fltEstLoj;
    For recEmpSal In recItem.arrEmpSal Do
      cdsVenda.FieldByName('EST_EMP_' + recEmpSal.strCodEmp).AsFloat := recEmpSal.fltSalDis;
    cdsVenda.Post;
  End;
end;

procedure TAlterarPedido.pOnProcessaItem(const item: TDadosFechamento; index, count: Integer; AInfo: String = '');
begin
  If Assigned(frmGravandoInterno) Then
  Begin
    If AInfo.IsEmpty Then
      AInfo := strInfoProcessamento;
    pRegistrarProgresso(Format(AInfo, [item.strCodIte + '-' + fPadR(item.strDesIte, 5)]),
      frmGravandoInterno.lblGravando, frmGravandoInterno.pgbStatus, 0, Succ(index), count);
  End;
end;

procedure TAlterarPedido.SetfatVenda(const Value: TFatVenda);
begin
  fatVenda := Value;
  blnFatVendaAssigned := Assigned(fatVenda);
end;

end.
