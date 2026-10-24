unit Faturamento.Classes.TValidarVenda;

interface
{$M+}

uses untFuncFat, UniClientDataSet, untTypesSistema, Classes, Variants,
  untMsgLiberacao, untConstantes, Uni, untFuncFatTypes;

Type
  TProgresso = procedure(strTexto: String; intAtual, intFinal: Integer) of object;
  TIgnorarCondicao = function(cdsItens: TUniClientDataSet): Boolean Of Object;
  TAtualizaPrecos = procedure(Var cdsDados: TUniClientDataSet; blnUnitarioLiquido: Boolean = False) Of Object;

  TValidarPedido = class
  private
    fatVenda: TFatVenda;
    FProgresso: TProgresso;
    FPedirSenha: Boolean;
    FProgValidPos: Integer;
    FProgValidMax: Integer;
    FMensagemItePreAltPdOr: Boolean;
    FIgnorarCondicao: TIgnorarCondicao;
    FAtualizaPrecos: TAtualizaPrecos;
    FValidarUnitarioIndividual: Boolean;
    FobjMsgMenCus : TMensagemLiberacao; // Mensagem para trava abaixo do custo
    FobjMsgMenMin : TMensagemLiberacao; // Mensagem para trava do valor minimo
    FIteMen: TStringList;
    FblnExecMontaMsgInterna: Boolean;
    FConsideraPromocao: Boolean;
  public
    function fValidaLimiteCredito: Boolean;
    function fValidaDebitosCliente: Boolean;
    function fValidaNaoCompra: Boolean;
    function fValidaVrMinimo: Boolean;
    function fValidaUnitario: Boolean;
    function fValidaEstoque: Boolean;
    function fValidaConsultaDeCredito: Boolean;
    function fValidaValorCrediario: Boolean;
    function fValidaUnitMargemCndPagto : Boolean;

    procedure pSetProgressValid(intPos, intMax: Integer);

    Constructor Create(objVenda: TFatVenda);
    destructor Destroy; override;
  published
    property onProgresso: TProgresso read FProgresso write FProgresso;
    property blnPedirSenha: Boolean Read FPedirSenha write FPedirSenha;
    property onIgnorarCondicao: TIgnorarCondicao read FIgnorarCondicao write FIgnorarCondicao;
    property onAtualizaPrecos: TAtualizaPrecos read FAtualizaPrecos write FAtualizaPrecos;
    property blnValidarUnitarioIndividual: Boolean read FValidarUnitarioIndividual write FValidarUnitarioIndividual;
    property objMsgMenMin: TMensagemLiberacao read FobjMsgMenMin;
    property objMsgMenCus: TMensagemLiberacao read FobjMsgMenCus;
    property stlIteMen: TStringList read FIteMen;
    property blnExecMontaMsgInterna: Boolean read FblnExecMontaMsgInterna write FblnExecMontaMsgInterna;
  end;

  TValidarFaturamento = class
  private
    FObjVen: TFatVenda;
  protected
    function fValidarCliente: Boolean;
    function fValidarServicos: Boolean;
    function fValidarProdutos: Boolean;
    function fValidarConfiguracao: Boolean;
    function fValidarFinanceiro: Boolean;
    function fValidarEspecie: Boolean;
    function fValidarImpostos: Boolean;
    function fValidarEntrega: Boolean;
  public
    constructor Create(AObjVenda: TFatVenda);
    class function Validate(AObjVenda: TFatVenda): Boolean;
  end;

  function fValidaUtilizarPedido(ANumDoc, AEspDoc, AEmpDoc, AOpcDoc: String): Boolean; overload;
  function fValidaUtilizarPedido(ANumDoc, AEspDoc, AEmpDoc, AOpcDoc: String; qryFatGor: TUniQuery; blnEhLiberacaoPedido: Boolean = False): Boolean; overload;
  function fValidaFaturarPedido(ANumPed, AEspPed, AEmpPed, AEspFat: string; AFatAut, ADmpPix: Boolean): Boolean;

  function fPreValidacoesFaturamentoExpedicao(AParams: TExpedicaoParams): Boolean;
  function fExtrairDocumentosDosItens(AParams: TExpedicaoParams): TDocumentos;

implementation

uses
  untPesqAux, SysUtils, untFuncoesSimples, untValidaSituacaoFinanceiraPedido, untFuncoes;

function fValidaUtilizarPedido(ANumDoc, AEspDoc, AEmpDoc, AOpcDoc: String): Boolean;
Var
  LQuery: TUniQuery;
begin
  LQuery := fCriarQuery(fGetSQLPedido);
  Try
    Result := fValidaUtilizarPedido(ANumDoc, AEspDoc, AEmpDoc, AOpcDoc, LQuery);
    If Result Then
      pLiberaBloqueioPedido(LQuery);
  Finally
    FreeAndNil(LQuery);
  End;
end;

function fValidaUtilizarPedido(ANumDoc, AEspDoc, AEmpDoc, AOpcDoc: String; qryFatGor: TUniQuery; blnEhLiberacaoPedido: Boolean = False): Boolean;
begin
  Result := TFatVenda.fValidaUtilizarPedidoOrcamento(ANumDoc, AEspDoc, AEmpDoc, AOpcDoc, qryFatGor) And fBloqueiaPedido(qryFatGor, blnEhLiberacaoPedido);
end;

function fValidaFaturarPedido(ANumPed, AEspPed, AEmpPed, AEspFat: string; AFatAut, ADmpPix: Boolean): Boolean;
var
  LIncPed, LMsgErro: String;
begin
  LIncPed := fRetornaInformacaoVenda(ANumPed, AEspPed, AEmpPed, 'AUTOINCREM');

  If AEspFat = 'IF' Then
    If fPedidoPossuiItensEntregaFutura(ANumPed, AEspPed, AEmpPed) Then
    Begin
      pMensagemOk(MSG_PEDIDO_POSSUI_ENTREGA_FUTURA_NFCE);
      Exit(False);
    End;

  If AEspFat = 'IF' Then
    If fPedidoPossuiSomenteItensEntregaImediata(ANumPed, AEspPed, AEmpPed) And fCfgSis('NPDF11', VarBoolean) Then
    Begin
      pMensagemOk(MSG_SOMENTE_ENTREGA_IMEDIATA_NFCE);
      Exit(False);
    End;

  If AEspFat = 'IF' Then
    If fTemServico(ANumPed, AEspPed, AEmpPed, '') Then
    Begin
      pMensagemOk(MSG_PEDIDO_POSSUI_SERVICOS_NFCE);
      Exit(False);
    End;

  If Not fValidaUtilizarPedido(ANumPed, AEspPed, AEmpPed, 'VN') Then
    Exit(False);

  If fPedidoFaturadoParcialmente(ANumPed, AEspPed, AEmpPed) Then
  Begin
    pMensagemOk(MSG_FATURADO_PARCIALMENTE);
    Exit(False);
  End;

  If fUsaRotinaWMS Then
    If Not TFatVenda.fValidarDefinicaoLotesPedidoWMS(ANumPed, AEspPed, AEmpPed, LMsgErro) Then
    Begin
      pMensagemOk(LMsgErro);
      Exit(False);
    End;

  If Not fValidarBaixaSeparacaoJaRealizada(ANumPed, AEspPed, AEmpPed) Then
  Begin
    pMensagemOk(MSG_IMPRESSAO_BAIXA_SEP_NAO_REALIZADA);
    Exit(False);
  End;

  Result := True;
end;

function fExtrairDocumentosDosItens(AParams: TExpedicaoParams): TDocumentos;
  Var
    stlDocumentos : TStringList;
    strDocumento : String;
    intIndexResult : Integer;
begin
  SetLength(Result, 0);

  If Not Assigned(AParams) Then
    Exit;

  stlDocumentos := TStringList.Create;
  Try
    AParams.cdsItens.First;
    While (Not AParams.cdsItens.Eof) Do
    Begin
      strDocumento := AParams.cdsItens.FieldByName('NUMDOC').AsString +
                      AParams.cdsItens.FieldByName('ESPDOC').AsString +
                      AParams.cdsItens.FieldByName('CODEMP').AsString +
                      AParams.cdsItens.FieldByName('CODCLI').AsString;

      If stlDocumentos.IndexOf(strDocumento) >= 0 Then
      Begin
        AParams.cdsItens.Next;
        Continue;
      End;

      stlDocumentos.Add(strDocumento);
      SetLength(Result, Succ(Length(Result)));
      intIndexResult := Pred(Length(Result));
      FillChar(Result[intIndexResult], SizeOf(Result[intIndexResult]), #0);
      Result[intIndexResult].strNumDoc := AParams.cdsItens.FieldByName('NUMDOC').AsString;
      Result[intIndexResult].strEspDoc := AParams.cdsItens.FieldByName('ESPDOC').AsString;
      Result[intIndexResult].strCodEmp := AParams.cdsItens.FieldByName('CODEMP').AsString;
      Result[intIndexResult].strCodCli := AParams.cdsItens.FieldByName('CODCLI').AsString;

      AParams.cdsItens.Next;
    End;
  Finally
    FreeAndNil(stlDocumentos);
  End;
end;

function fPreValidacoesFaturamentoExpedicao(AParams: TExpedicaoParams): Boolean;
  Var
    LDocumentos : TDocumentos;
begin
  LDocumentos := fExtrairDocumentosDosItens(AParams);

  If fExistemProblemasNaEstruturaPedidoALPEExpedicao(LDocumentos) Then
    Exit(False);

  If fExistemProblemasNaEstruturaPedidoLinkPagamentoCitelExpedicao(LDocumentos) Then
    Exit(False);

  If fExistemProblemasNaEstruturaPedidoPagarMeExpedicao(LDocumentos) Then
    Exit(False);

  If fExistemProblemasNaEstruturaPedidoGarantiaExpedicao(LDocumentos) Then
    Exit(False);

  If fExistemInconsistenciasPedidoExpedicao(AParams) Then
    Exit(False);

  If fExistemInconsistenciasClienteExpedicao(AParams, LDocumentos) Then
    Exit(False);

  If fExistemInconsistenciasProdutosExpedicao(AParams) Then
    Exit(False);

  If fExistemProdutosComLotesDiferentesParaClienteFilialExpedicao(AParams) Then
    Exit(False);

  If Not fValidarExpedicaoParcial(AParams) Then
    Exit(False);

  If Not fValidarQuantidadeSeparadaVsExpedidaWMS(AParams) Then
    Exit(False);

  Result := True;
end;

{ TValidarPedido }

constructor TValidarPedido.Create(objVenda: TFatVenda);
begin
  fatVenda := objVenda;
  onIgnorarCondicao := Nil;
  onAtualizaPrecos := Nil;
  FIteMen := TStringList.Create;
  FValidarUnitarioIndividual := True;
  FobjMsgMenCus := TMensagemLiberacao.Create(nil);
  FobjMsgMenMin := TMensagemLiberacao.Create(nil);
  FMensagemItePreAltPdOr := False;
  FblnExecMontaMsgInterna := True;
end;

function TValidarPedido.fValidaUnitario: Boolean;
  Var
    strCcnAnt: String;
    fltUnitar: Double;
    fltTotal : Double;
    fltQtdJaDig: Double;
    fltQtdJaEmPromoc: Double;
    cdsDados : TUniClientDataSet;
    objTabelaCus : TRegistroMsgLiberaTabela;
    objTabelaMin : TRegistroMsgLiberaTabela;
    objLinha : TLinhaMsgLibera;
    blnExpandido: Boolean;
    intTamDes,
    intTamMar,
    intTamTabela: Integer;
    fltPrecoTabela : Double;
    strTabPreIteLocal: String;
    blnRemoveuPRMIN: Boolean;

  procedure pCalculaQtdJaDigitada;
  begin
    fltQtdJaDig := 0;
    fltQtdJaEmPromoc := 0;

    With cdsDados, fatVenda Do
    Begin
      pArmazenarItemNaListaDeItemForaPromo(FieldByName('ITE_CODITE').AsString, FieldByName('ITE_EMPITE').AsString);

      If (fItemPassivelDeVerificacaoPromo(FieldByName('ITE_CODITE').AsString, FieldByName('ITE_EMPITE').AsString)) Then
      Begin
        fltQtdJaDig := fRetQtdDigitada(FieldByName('ITE_CODITE').AsString,
                                       FieldByName('ITE_NUMLOT').AsString,
                                       FieldByName('AUTOINCREM').AsString,
                                       FieldByName('ITE_CODACA').AsString,
                                       FieldByName('ITE_EMPACA').AsString,
                                       FieldByName('ITE_EMPITE').AsString,
                                       False);

        fltQtdJaEmPromoc := fRetQtdDigitada(FieldByName('ITE_CODITE').AsString,
                                            FieldByName('ITE_NUMLOT').AsString,
                                            FieldByName('AUTOINCREM').AsString,
                                            FieldByName('ITE_CODACA').AsString,
                                            FieldByName('ITE_EMPACA').AsString,
                                            FieldByName('ITE_EMPITE').AsString,
                                            False,
                                            False,
                                            fatVenda.fDesconsiderarNaQtdLimDaPromoItensUnitarMaior,
                                            True {Somente em promocao});
      End;
    End;
  end;

  Procedure pPosicionaItem;
  Begin
    With cdsDados Do
    Begin
      //Precisamos posicionar a temporaria da venda para atualizar as variaveis utilizadas na trava de Preco
      fatVenda.strIdePro := FieldByName('ITE_IDEPRO').AsString;
      fatVenda.fltCusIte := FieldByName('ITE_CUSITE').AsFloat;
      fatVenda.fltPreCus := FieldByName('ITE_PRECUS').AsFloat;
      fatVenda.fltIcmSai := FieldByName('ITE_ICMSAI').AsFloat;
      fatVenda.fltImpFed := FieldByName('ITE_IMPFED').AsFloat;
      fatVenda.fltDesOpe := FieldByName('ITE_DESOPE').AsFloat;
      fatVenda.fltOutVal := FieldByName('ITE_OUTVAL').AsFloat;
      fatVenda.fltPreCu2 := FieldByName('ITE_PRECU2').AsFloat;
      fatVenda.fltPreVe1 := FieldByName('ITE_PREVE1').AsFloat;
      fatVenda.fltPreVe2 := FieldByName('ITE_PREVE2').AsFloat;
      fatVenda.fltPreVe3 := FieldByName('ITE_PREVE3').AsFloat;
      fatVenda.fltPreVe4 := FieldByName('ITE_PREVE4').AsFloat;
      fatVenda.fltPreVe5 := FieldByName('ITE_PREVE5').AsFloat;
      fatVenda.fltPreVe6 := FieldByName('ITE_PREVE6').AsFloat;
      fatVenda.fltPreVe7 := FieldByName('ITE_PREVE7').AsFloat;

      pPesquisaCadSem(fatVenda.qryConCit, fatVenda.qryConCit, FieldByName('ITE_CODITE').AsString, '', False, False);

      fatVenda.qryConIte.Close;
      fatVenda.qryConIte.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
      fatVenda.qryConIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
      fatVenda.qryConIte.Open;
    End;
  End;

  Procedure pLinhaCheia(Var arrAdd : TStringArray; intTam: Integer = 0);
  begin
    If intTam <> 0 Then
      pAddDados(arrAdd, StringOfChar('-', intTam))
    Else If fUsaTravaPorMargemMinimaLiquida Then
      pAddDados(arrAdd, StringOfChar('-', 128))
    Else
      pAddDados(arrAdd, StringOfChar('-', 106));
  end;

  function fItemCarregadoJuntoPDouOR: Boolean;
  begin
    Result := (Length(cdsDados.FieldByName('ITE_SEQDET').AsString) = 20) And
              (Not fEmptyStr(cdsDados.FieldByName('ITE_NUMORC').AsString)) And
              (Not fEmptyStr(cdsDados.FieldByName('ITE_ESPORC').AsString)) And
              (Not fEmptyStr(cdsDados.FieldByName('ITE_EMPORC').AsString));
  end;

Begin
  Result := True;

  If (VS_strTRVEPR = '2') Then
    Exit;

  FobjMsgMenCus.Clear;
  FobjMsgMenMin.Clear;

  FIteMen.Clear;

  Try
    cdsDados := TUniClientDataSet.Create(nil);
    pCloneDataSet(cdsDados, cdsVenda);
    cdsDados.LogChanges := False;

    If Assigned(onAtualizaPrecos) Then
      onAtualizaPrecos(cdsDados, True {unitario liquido});

    objTabelaCus := TRegistroMsgLiberaTabela.Create;
    objTabelaMin := TRegistroMsgLiberaTabela.Create;

    intTamDes := 24;
    intTamMar := 12;
    
    blnExpandido := False;

    With cdsDados Do
    Begin
      First;
      While Not Eof Do
      Begin
        If (Length(FieldByName('ITE_DESITE').AsString) > intTamDes) Then
        Begin
          intTamDes := fTamCodIte + (intTamDes+intTamMar) - 2;
          blnExpandido := True;
          Break;
        End;
        Next;
      End;

    End;  

    blnRemoveuPRMIN := False;
    If fatVenda.blnLiberacaoRemotaNoFinalVenda And fatVenda.blnEhTravaItemAItemFinalVenda Then
    Begin
      pRemoverTravaLogAvi('PRMIN',  fatVenda.strNTrava);
      pRemoverTravaLogAvi('PRMIN2', fatVenda.strNTrava);
      pRemoverTravaLogAvi('PRMIN3', fatVenda.strNTrava);
      pRemoverTravaLogAvi('PRMIN4', fatVenda.strNTrava);
      pRemoverTravaLogAvi('PRMIN5', fatVenda.strNTrava);
      pRemoverTravaLogAvi('PRMIN6', fatVenda.strNTrava);
      blnRemoveuPRMIN := True;
    End;

    With cdsDados Do
    Begin
      First;
      While Not Eof Do
      Begin
        If Assigned(onProgresso) Then
          onProgresso('Aguarde, Validando Valor Unitário dos Produtos...', RecNo, RecordCount);

        If Assigned(onIgnorarCondicao) Then
        Begin
          If onIgnorarCondicao(cdsDados) Then
          Begin
            Next;
            Continue;
          End;
        End;

        If fEhItemServico(FieldByName('ITE_CODITE').AsString) Then
        Begin
          Next;
          Continue;
        End;

        pPosicionaItem;
        pCalculaQtdJaDigitada;

        fltUnitar := FieldByName('ITE_UNITAR').AsFloat;

        If (fCfgSis('ALITPR', varBoolean)) And (FieldByName('ITE_PROMOC').AsString <> 'S') Then
          FConsideraPromocao := False
        Else
          FConsideraPromocao := True;

        If Not fatVenda.fValidaUnitario( fltUnitar,
                                         fltTotal,
                                         strCcnAnt,
                                         FieldByName('ITE_QTDITE').AsFloat,
                                         fltQtdJaDig,
                                         fltQtdJaEmPromoc,
                                         FieldByName('ITE_UNIORI').AsFloat,
                                         FieldByName('ITE_DESMGE').AsFloat,
                                         FieldByName('ITE_PREEMB').AsFloat,
                                         FieldByName('ITE_UNIDEV').AsFloat,
                                         FieldByName('ITE_EMBALA').AsFloat,
                                         0,
                                         FieldByName('ITE_PRCTIN').AsFloat,
                                         FieldByName('ITE_PRVTIN').AsFloat,
                                         FieldByName('ITE_CUSITE').AsFloat,
                                         FieldByName('ITE_QTDEMB').AsInteger,
                                         FieldByName('ITE_TOTITE').AsFloat,
                                         FieldByName('ITE_EMPITE').AsString,
                                         IIF(fCfgSis('TABITE', varBoolean), FieldByName('ITE_TABPRE').AsString, fatVenda.strTabPre),
                                         FieldByName('ITE_CODITE').AsString,
                                         FieldByName('ITE_DESITE').AsString,
                                         FieldByName('ITE_IDEPRO').AsString,
                                         FieldByName('ITE_TIPPRE').AsString,
                                         FieldByName('ITE_ITETIN').AsString,
                                         FieldByName('ITE_CATALI').AsString,
                                         FieldByName('ITE_PROMOC').AsString,
                                         FieldByName('ITE_ENTSAI').AsString,
                                         FieldByName('ITE_BRINDE').AsString,
                                         True,
                                         cdsDados,
                                         fatVenda.qryConCit,
                                         nil,
                                         cdsDados,
                                         FieldByName('ITE_PRELOT').AsFloat,
                                         fRetSiglaUnidadePorCodIte(FieldByName('ITE_CODITE').AsString),
                                         FieldByName('ITE_PREMED').AsFloat,
                                         FieldByName('ITE_IMPULT').AsFloat,
                                         FieldByName('ITE_PREULT').AsFloat,
                                         blnPedirSenha,
                                         ((FieldByName('ITE_ENTRET').AsString = 'E') And (FieldByName('ITE_ENTFUT').AsString = 'N')),
                                         ((FieldByName('ITE_ENTRET').AsString = 'E') And (FieldByName('ITE_ENTFUT').AsString = 'S')),
                                         FieldByName('ITE_MOTFUT').AsString,
                                         FieldByName('ITE_DESMSU').AsFloat,
                                         FieldByName('ITE_BAREMB').AsString,
                                         FieldByName('ITE_UNISBI').AsFloat,
                                         Nil,
                                         FieldByName('ITE_PROACA').AsInteger = 1,
                                         ((FieldByName('ITE_SEQCOM').AsInteger > 0) And (FieldByName('ITE_ATIVAC').AsString <> 'S')),
                                         '2',
                                         0,
                                         Nil,
                                         FblnExecMontaMsgInterna,
                                         FConsideraPromocao) Then
        Begin
          Result := False;

          FIteMen.Add(FieldByName('AUTOINCREM').AsString);
          If (fatVenda.recInfoTravaUnitario.strOpcTrvUnit = 'VECUS') Then
          Begin
            If FobjMsgMenCus.isEmpty Then
            Begin

              FobjMsgMenCus.pAddTexto('Valor menor que o preço de custo não é permitido!');

              objLinha := TLinhaMsgLibera.Create;
              objLinha.enuTipoLinha := tlCabecalho;
              objLinha.pAddColuna('', 'Item'     , fTamCodIte , alEsquerda, teAutcom );
              objLinha.pAddColuna('', 'Descrição', 50 , alEsquerda, teAutcom );
              objTabelaCus.lstLinhas.Add(objLinha);
            End;

            objLinha := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlValor;
            objLinha.pAddColuna('Item'      , FieldByName('ITE_CODITE').AsString  , fTamCodIte);
            objLinha.pAddColuna('Descrição' , FieldByName('ITE_DESITE').AsString  , 50 );
            objTabelaCus.lstLinhas.Add(objLinha);
          End
          Else If (fatVenda.recInfoTravaUnitario.strOpcTrvUnit = 'PRMIN4') Then
          Begin
            if FobjMsgMenMin.isEmpty Then
            Begin
              FobjMsgMenMin.pAddTexto('Valor Unitário Menor que o Preço Mínimo.');

              objLinha := TLinhaMsgLibera.Create;
              objLinha.enuTipoLinha := tlCabecalho;
              objLinha.pAddColuna('', 'Item'        , fTamCodIte , alEsquerda, teAutcom );
              If Not blnExpandido Then
              Begin
                objLinha.pAddColuna('', 'Descrição'   , intTamDes , alEsquerda, teAutcom );
                objLinha.pAddColuna('', 'Marca'       , intTamMar , alEsquerda, teAutcom );
              End
              Else
              Begin
                objLinha.pAddColuna('', 'Descrição'   , intTamDes , alEsquerda, teAutcom );
              End;  
                
              objLinha.pAddColuna('', 'Quantidade'  , 10 , alDireita , teAutcom );
              objLinha.pAddColuna('', 'Pr.Tabela'   , 10 , alDireita , teAutcom );
              objLinha.pAddColuna('', 'Pr.Digitado' , 10 , alDireita , teAutcom );
              if not fEmptyStr( varToStr( fatVenda.recInfoTravaUnitario.fltPreMin ) ) then
                objLinha.pAddColuna('', 'Preço Mínimo' , 10 , alDireita , teAutcom );

              If fUsaTravaPorMargemMinimaLiquida Then
              begin
                objLinha.pAddColuna('', 'Mar.Mín.' , 8 , alDireita , teAutcom );
                objLinha.pAddColuna('', 'Mar.Pra.' , 8 , alDireita , teAutcom );
              end;

              objTabelaMin.lstLinhas.Add(objLinha);
            End;

            intTamTabela := objTabelaMin.fGetTamanhoFinalCabecalho;

            If Not blnExpandido Then
            Begin
              objLinha := TLinhaMsgLibera.Create;
              objLinha.enuTipoLinha := tlValor;
              objLinha.pAddColuna('Item'        , FieldByName('ITE_CODITE').AsString, fTamCodIte, alEsquerda);
              objLinha.pAddColuna('Descrição'   , FieldByName('ITE_DESITE').AsString, intTamDes , alEsquerda);
              objLinha.pAddColuna('Marca'       , fRetNomMarcaItem(FieldByName('ITE_CODITE').AsString), intTamMar , alEsquerda);
            End
            Else
            Begin
              objLinha  := TLinhaMsgLibera.Create;
              objLinha.enuTipoLinha := tlValor;
              objLinha.pAddColuna('Item', FieldByName('ITE_CODITE').AsString, fTamCodIte, alEsquerda);
              objLinha.pAddColuna('Descrição', FieldByName('ITE_DESITE').AsString, intTamTabela-(fTamCodIte+5), alEsquerda);
              objTabelaMin.lstLinhas.Add(objLinha);

              objLinha  := TLinhaMsgLibera.Create;
              objLinha.enuTipoLinha := tlValor;
              objLinha.pAddColuna(''     , '', fTamCodIte, alEsquerda, teAutcom);
              objLinha.pAddColuna('Marca', fRetNomMarcaItem(FieldByName('ITE_CODITE').AsString), intTamTabela-(fTamCodIte+5), alEsquerda, teAutcom, True);
              objTabelaMin.lstLinhas.Add(objLinha);

              objLinha  := TLinhaMsgLibera.Create;
              objLinha.pAddColuna('', '', (fTamCodIte + intTamDes + 2), alEsquerda, teAutcom);
            End;

            strTabPreIteLocal := IIF(fCfgSis('TABITE', varBoolean), FieldByName('ITE_TABPRE').AsString, fatVenda.strTabPre);
            If fEmptyStr(strTabPreIteLocal) Then
              strTabPreIteLocal := '1';
 
            fltPrecoTabela := IIF(Pos(fatVenda.strOpcDoc, 'DV_PR_DD_CR_') > 0, FieldByName('ITE_UNIDEV').AsFloat, FieldByName('ITE_UNIORI').AsFloat);

            If (FieldByName('ITE_PROMOC').AsString <> 'S') Then
              If (fItemCarregadoJuntoPDouOR) Then
                fltPrecoTabela := FieldByName('ITE_PREVE' + strTabPreIteLocal).AsFloat;

            objLinha.pAddColuna('Quantidade'  , FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), FieldByName('ITE_QTDITE').AsFloat)                                                          , 10 , alDireita );
            objLinha.pAddColuna('Pr.Tabela'   , FormatFloat('#,####0.0000', fltPrecoTabela) , 10 , alDireita );
            objLinha.pAddColuna('Pr.Digitado' , FormatFloat('#,####0.0000', fatVenda.recInfoTravaUnitario.fltUniLiqCal)                                                                             , 10 , alDireita );
            if not fEmptyStr( varToStr( fatVenda.recInfoTravaUnitario.fltPreMin ) ) then
              objLinha.pAddColuna('Preço Mínimo' , FormatFloat('#,####0.0000', fatVenda.recInfoTravaUnitario.fltPreMin) ,  10 , alDireita  );

            If fUsaTravaPorMargemMinimaLiquida Then
            begin
              objLinha.pAddColuna('Mar.Mín.' , FormatFloat('#,####0.0000', fatVenda.recInfoTravaUnitario.fltMargMin) , 8 , alDireita);
              objLinha.pAddColuna('Mar.Pra.' , FormatFloat('#,####0.0000', fatVenda.recInfoTravaUnitario.fltMargPra) , 8 , alDireita);
            end;

            objTabelaMin.lstLinhas.Add(objLinha);

            If fatVenda.blnMensagemItePreAltPdOr Then
              FMensagemItePreAltPdOr := True;
              
          End;

          If (blnValidarUnitarioIndividual) Then
            Break;
        End
        Else If (Not blnRemoveuPRMIN) Then
        Begin
          If (Pos(fatVenda.strOpcDoc, 'PD_OR_VN_') > 0) Then
            pRemoverTravaLogAviPRMIN(FieldByName('ITE_CODITE').AsString, FieldByName('AUTOINCREM').AsInteger, fatVenda.strNTrava);
        End;

        Next;
      End;

      If Assigned(objTabelaCus) then
      begin
        if objTabelaCus.isEmpty Then
          FreeAndNil(objTabelacus)
        else
          FobjMsgMenCus.lstRegistros.Add(objTabelaCus);
      end;

      If Assigned(objTabelaMin) then
      begin
        If objTabelaMin.isEmpty Then
          FreeAndNil(objTabelaMin)
        else
        begin
          FobjMsgMenMin.lstRegistros.Add(objTabelaMin);
          If FMensagemItePreAltPdOr Then
          Begin
            fatVenda.blnMensagemItePreAltPdOr := False;
            FobjMsgMenMin.pAddTexto('(**) ATENÇÃO: HÁ ITENS QUE TIVERAM PREÇO DE TABELA ALTERADOS DEPOIS DA CRIAÇÃO DESTE DOCUMENTO!');
            FobjMsgMenMin.pAddTexto(' ');
          End;

        end  
      end;

      First;
    End;
  Finally
    If Assigned(cdsDados) Then
      FreeAndNil(cdsDados);
  End;
end;

function TValidarPedido.fValidaEstoque: Boolean;
begin
  If Assigned(onProgresso) Then
    onProgresso('Aguarde, Verificando Estoque dos Produtos...', FProgValidPos, FProgValidMax);

  If fExibiraTelaParaTransferenciaPD(fatVenda.strEspDoc, fatVenda.blnEnt_CD) Then
    Exit(True);

  Result := fatVenda.fVerificaEstoqueItens(fatVenda.strEspDoc, '', True, False, True, -1, Not blnPedirSenha);
end;

function TValidarPedido.fValidaDebitosCliente: Boolean;
begin
  If Assigned(onProgresso) Then
    onProgresso('Aguarde, Verificando Débitos em Atraso do Cliente...', FProgValidPos, FProgValidMax);

  Result := fatVenda.fDebitoCliente(fatVenda.strCodFpg, fatVenda.strConPag, 2, fatVenda.strEspDoc, blnPedirSenha);
end;

function TValidarPedido.fValidaConsultaDeCredito: Boolean;
begin
  If Assigned(onProgresso) Then
    onProgresso('Aguarde, Verificando Consulta de Crédito do Cliente...', FProgValidPos, FProgValidMax);

  Result := fatVenda.fVerificaConsultaDeCredito(fatVenda.strConPag, fatVenda.strCodFpg, fatVenda.strOpcDoc, '', blnPedirSenha);
end;

function TValidarPedido.fValidaValorCrediario: Boolean;
begin
  If Assigned(onProgresso) Then
    onProgresso('Aguarde, Verificando Valor de Crediário do Cliente...', FProgValidPos, FProgValidMax);

  Result := fatVenda.fVerificaValorCrediario('', blnPedirSenha);
end;

function TValidarPedido.fValidaLimiteCredito: Boolean;
  Var
    fltValorCompra : Double;
begin
  If Assigned(onProgresso) Then
    onProgresso('Aguarde, Validando Limite de Crédito do Cliente...', FProgValidPos, FProgValidMax);

  Result := True;

  fltValorCompra := fatVenda.fltTotPro - fatVenda.fltDesEsp + fatVenda.fltTotSer;

  If (Not fatVenda.blnCliFil) And
     (Not fClienteConsumidor(fatVenda.strCliOri,True, True)) Then
  Begin
    Result := fatVenda.fDebitoCliente('', '', 0) And
              fatVenda.fVerificaLimiteCredito(fatVenda.strConPag, fLimiteCreditoCliente(fatVenda.strCodCli), fltValorCompra, blnPedirSenha);
  End;

end;

function TValidarPedido.fValidaNaoCompra: Boolean;
  Var
    blnTravaNaoCompra: Boolean;
begin
  If Assigned(onProgresso) Then
    onProgresso('Aguarde, Validando dias que não compra do cliente...', FProgValidPos, FProgValidMax);

  Result := fatVenda.fVerificaNaoCompra(blnTravaNaoCompra, fatVenda.strCodVen, fatVenda.strEspDoc, blnPedirSenha);
end;

function TValidarPedido.fValidaVrMinimo: Boolean;
begin
  If Assigned(onProgresso) Then
    onProgresso('Aguarde, Validando Valor Mínimo da Venda...', FProgValidPos, FProgValidMax);

  Result := True;
  If (VS_strTRVEPR = '2') Or (fatVenda.fltDesEsp > 0) Or (fatVenda.fltPorDes > 0) Then
  Begin
    Result := fatVenda.fVerificaVrMinimo(fatVenda.fltTotGer, fatVenda.fltTotGer, fatVenda.intPrzMed, fatVenda.strEspDoc, blnPedirSenha);
  End;
end;

destructor TValidarPedido.Destroy;
begin
  FreeAndNil(FIteMen);
  FreeAndNil(FobjMsgMenCus);
  FreeAndNil(FobjMsgMenMin);
  inherited Destroy;
end;

procedure TValidarPedido.pSetProgressValid(intPos, intMax: Integer);
begin
  FProgValidPos := intPos;
  FProgValidMax := intMax;
end;

function TValidarPedido.fValidaUnitMargemCndPagto : Boolean;
  Var
    strCcnAnt: String;
    fltUnitar: Double;
    fltTotal : Double;
    fltQtdJaDig: Double;
    fltQtdJaEmPromoc: Double;
    cdsDados : TUniClientDataSet;

  procedure pCalculaQtdJaDigitada;
  begin
    fltQtdJaDig := 0;
    fltQtdJaEmPromoc := 0;

    With cdsDados, fatVenda Do
    Begin
      pArmazenarItemNaListaDeItemForaPromo(FieldByName('ITE_CODITE').AsString, FieldByName('ITE_EMPITE').AsString);

      If (fItemPassivelDeVerificacaoPromo(FieldByName('ITE_CODITE').AsString, FieldByName('ITE_EMPITE').AsString)) Then
      Begin
        fltQtdJaDig := fRetQtdDigitada(FieldByName('ITE_CODITE').AsString,
                                       FieldByName('ITE_NUMLOT').AsString,
                                       FieldByName('AUTOINCREM').AsString,
                                       FieldByName('ITE_CODACA').AsString,
                                       FieldByName('ITE_EMPACA').AsString,
                                       FieldByName('ITE_EMPITE').AsString,
                                       False);

        fltQtdJaEmPromoc := fRetQtdDigitada(FieldByName('ITE_CODITE').AsString,
                                            FieldByName('ITE_NUMLOT').AsString,
                                            FieldByName('AUTOINCREM').AsString,
                                            FieldByName('ITE_CODACA').AsString,
                                            FieldByName('ITE_EMPACA').AsString,
                                            FieldByName('ITE_EMPITE').AsString,
                                            False,
                                            False,
                                            fatVenda.fDesconsiderarNaQtdLimDaPromoItensUnitarMaior,
                                            True {Somente em promocao});
      End;
    End;
  end;

  Procedure pPosicionaItem;
  Begin
    With cdsDados Do
    Begin
      //Precisamos posicionar a temporaria da venda para atualizar as variaveis utilizadas na trava de Preco
      fatVenda.strIdePro := FieldByName('ITE_IDEPRO').AsString;
      fatVenda.fltCusIte := FieldByName('ITE_CUSITE').AsFloat;
      fatVenda.fltPreCus := FieldByName('ITE_PRECUS').AsFloat;
      fatVenda.fltIcmSai := FieldByName('ITE_ICMSAI').AsFloat;
      fatVenda.fltImpFed := FieldByName('ITE_IMPFED').AsFloat;
      fatVenda.fltDesOpe := FieldByName('ITE_DESOPE').AsFloat;
      fatVenda.fltOutVal := FieldByName('ITE_OUTVAL').AsFloat;
      fatVenda.fltPreCu2 := FieldByName('ITE_PRECU2').AsFloat;
      fatVenda.fltPreVe1 := FieldByName('ITE_PREVE1').AsFloat;
      fatVenda.fltPreVe2 := FieldByName('ITE_PREVE2').AsFloat;
      fatVenda.fltPreVe3 := FieldByName('ITE_PREVE3').AsFloat;
      fatVenda.fltPreVe4 := FieldByName('ITE_PREVE4').AsFloat;
      fatVenda.fltPreVe5 := FieldByName('ITE_PREVE5').AsFloat;
      fatVenda.fltPreVe6 := FieldByName('ITE_PREVE6').AsFloat;
      fatVenda.fltPreVe7 := FieldByName('ITE_PREVE7').AsFloat;

      pPesquisaCadSem(fatVenda.qryConCit, fatVenda.qryConCit, FieldByName('ITE_CODITE').AsString, '', False, False);

      fatVenda.qryConIte.Close;
      fatVenda.qryConIte.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
      fatVenda.qryConIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
      fatVenda.qryConIte.Open;
    End;
  End;

  Procedure pLinhaCheia(Var arrAdd : TStringArray; intTam: Integer = 0);
  begin
    If intTam <> 0 Then
      pAddDados(arrAdd, StringOfChar('-', intTam))
    Else If fUsaTravaPorMargemMinimaLiquida Then
      pAddDados(arrAdd, StringOfChar('-', 128))
    Else
      pAddDados(arrAdd, StringOfChar('-', 106));
  end;

  function fItemCarregadoJuntoPDouOR: Boolean;
  begin
    Result := (Length(cdsDados.FieldByName('ITE_SEQDET').AsString) = 20) And
              (Not fEmptyStr(cdsDados.FieldByName('ITE_NUMORC').AsString)) And
              (Not fEmptyStr(cdsDados.FieldByName('ITE_ESPORC').AsString)) And
              (Not fEmptyStr(cdsDados.FieldByName('ITE_EMPORC').AsString));
  end;

Begin
  Result := True;
  FIteMen.Clear;
  Try
    cdsDados := TUniClientDataSet.Create(nil);
    pCloneDataSet(cdsDados, cdsVenda);

    If Assigned(onAtualizaPrecos) Then
      onAtualizaPrecos(cdsDados, True {unitario liquido});

    With cdsDados Do
    Begin
      First;
      While Not Eof Do
      Begin
        If Assigned(onProgresso) Then
          onProgresso('Aguarde, Validando Valor Unitário dos Produtos...', RecNo, RecordCount);

        If Assigned(onIgnorarCondicao) Then
        Begin
          If onIgnorarCondicao(cdsDados) Then
          Begin
            Next;
            Continue;
          End;
        End;

        If fEhItemServico(FieldByName('ITE_CODITE').AsString) Then
        Begin
          Next;
          Continue;
        End;

        pPosicionaItem;
        pCalculaQtdJaDigitada;

        fltUnitar := FieldByName('ITE_UNITAR').AsFloat;

        if not fatVenda.fValidaMargemCondPatgo(fltUnitar,
                                               fltTotal,
                                               strCcnAnt,
                                               FieldByName('ITE_QTDITE').AsFloat,
                                               fltQtdJaDig,
                                               fltQtdJaEmPromoc,
                                               FieldByName('ITE_UNIORI').AsFloat,
                                               FieldByName('ITE_DESMGE').AsFloat,
                                               FieldByName('ITE_PREEMB').AsFloat,
                                               FieldByName('ITE_UNIDEV').AsFloat,
                                               FieldByName('ITE_EMBALA').AsFloat,
                                               0,
                                               FieldByName('ITE_PRCTIN').AsFloat,
                                               FieldByName('ITE_PRVTIN').AsFloat,
                                               FieldByName('ITE_CUSITE').AsFloat,
                                               FieldByName('ITE_QTDEMB').AsInteger,
                                               FieldByName('ITE_TOTITE').AsFloat,
                                               FieldByName('ITE_EMPITE').AsString,
                                               IIF(fCfgSis('TABITE', varBoolean), FieldByName('ITE_TABPRE').AsString, fatVenda.strTabPre),
                                               FieldByName('ITE_CODITE').AsString,
                                               FieldByName('ITE_DESITE').AsString,
                                               FieldByName('ITE_IDEPRO').AsString,
                                               FieldByName('ITE_TIPPRE').AsString,
                                               FieldByName('ITE_ITETIN').AsString,
                                               FieldByName('ITE_CATALI').AsString,
                                               FieldByName('ITE_PROMOC').AsString,
                                               FieldByName('ITE_ENTSAI').AsString,
                                               FieldByName('ITE_BRINDE').AsString,
                                               True,
                                               cdsDados,
                                               fatVenda.qryConCit,
                                               nil,
                                               cdsDados,
                                               FieldByName('ITE_PRELOT').AsFloat,
                                               fRetSiglaUnidadePorCodIte(FieldByName('ITE_CODITE').AsString),
                                               FieldByName('ITE_PREMED').AsFloat,
                                               FieldByName('ITE_IMPULT').AsFloat,
                                               blnPedirSenha,
                                               ((FieldByName('ITE_ENTRET').AsString = 'E') And (FieldByName('ITE_ENTFUT').AsString = 'N')),
                                               ((FieldByName('ITE_ENTRET').AsString = 'E') And (FieldByName('ITE_ENTFUT').AsString = 'S')),
                                               FieldByName('ITE_MOTFUT').AsString,
                                               FieldByName('ITE_DESMSU').AsFloat,
                                               FieldByName('ITE_BAREMB').AsString,
                                               FieldByName('ITE_UNISBI').AsFloat,
                                               Nil,
                                               FieldByName('ITE_PROACA').AsInteger = 1,
                                               ((FieldByName('ITE_SEQCOM').AsInteger > 0) And (FieldByName('ITE_ATIVAC').AsString <> 'S')),
                                               '2') Then
        Begin
          Result := False;

          If (blnValidarUnitarioIndividual) Then
            Break;
        End;

        Next;
      End;

      First;
    End;
  Finally
    If Assigned(cdsDados) Then
      FreeAndNil(cdsDados);
  End;
end;


{ TValidarFaturamento }

function TValidarFaturamento.fValidarProdutos: Boolean;
Var
  LInfo: String;
begin
  If Length(FObjVen.arrMatItens) = 0 then
  Begin
    pMensagemOk(MSG_NAO_HA_PRODUTOS_PARA_FATURAR);
    Exit(False);
  End;

  If Not FObjVen.fValidarLoteVazio Then
    Exit(False);

  If Not FObjVen.fValidaQuantSerieItens Then
    Exit(False);

  If Not FObjVen.fVerificaQuantidadeItensCupom Then
    Exit(False);

  If FObjVen.fItensObrNfe(False) Then
  Begin
    pMensagemOk(MSG_ITENS_OBRIGATORIEDADE_NFE);
    Exit(False);
  End;

  If Not FObjVen.fValidouItensBonificados Then
    Exit(False);

  If Not FObjVen.fVerificaItensCupomAbf Then
    Exit(False);

  If FObjVen.fTemComboComItemBrindeEntregaFutura(True) Then
    Exit(False);

  If FObjVen.fExistemProblemasNaEstruturaTabelaExtDor Then
    Exit(False);

  If Not FObjVen.fValidarItemAgrotoxicoEmCupom Then
    Exit(False);

  If Not FObjVen.fVerificaItemObrigCodIbama Then
    Exit(False);

  If FObjVen.fTrocaUFEndEntrega <> UF_EXTERIOR Then
    If Not FObjVen.fVerificaItemObrigCpfCnpj Then
      Exit(False);

  If FObjVen.fTemProdutosComboVigenciaVencida Then
    Exit(False);

  If FObjVen.fExistemProdutosQuantidadeZerada Then
    Exit(False);

  If FObjVen.fUltrapassouLimiteItensNFe(LInfo) Then
  Begin
    pMensagemOk(LInfo);
    Exit(False);
  End;

  If Not FObjVen.blnExpedi Then
    If Not FObjVen.blnExecutandoPagueFacil Then
      If Not FObjVen.fVerificaEstoqueItens(FObjVen.strOpcDoc) Then
        Exit(False);

  If Not FObjVen.blnExecutandoPagueFacil Then
    If Not FObjVen.fVerificaPesoItensRateioFrete Then
      Exit(False);

  Result := True;
end;

function TValidarFaturamento.fValidarServicos: Boolean;
begin
  If Not FObjVen.fValidarPermissaoEmitirDocumentoComServicos() Then
    Exit(False);

  Result := True;
end;

function TValidarFaturamento.fValidarEntrega: Boolean;
begin
  If Not fValidarControleRotasRegioesCidades(FObjVen) Then
    Exit(False);

  Result := True;
end;

function TValidarFaturamento.fValidarEspecie: Boolean;
begin
  If FObjVen.blnExecutandoDesmembramentoPedidoPIX Then
    If Not fFaturamentoVaiGerarSomenteNovosPedidosF11(FObjVen) Then
    Begin
      pMensagemOk(MSG_PEDIDO_NAO_IRA_GERAR_SOMENTE_NOVOS_PEDIDOS_F11);
      Exit(False);
    End;

  If FObjVen.blnExecutandoDesmembramentoPedidoPIX Then
    If fPedidoOriginadoOutroPedidoPeloF11Caixa(FObjVen.strNumOrc, FObjVen.strEmpOri) Then
    Begin
      pMensagemOk(MSG_PEDIDO_ORIGEM_F11_FATURAR_PELA_EXPEDICAO);
      Exit(False);
    End;

  If fVerificaSeImpNFAvulsa(FObjVen.strEspDoc, teNaoPermite) Then
    Exit(False);

  If (FObjVen.strEspDoc = 'NF') Then
    If (Not FObjVen.fVerificaValorMinimoEmitirNF(FObjVen.blnExpedi)) Then
    Begin
      pMensagemOk(MSG_VALOR_MINIMO_EMITIR_NF);
      Exit(False);
    End;

  If FObjVen.strEspDoc = 'IF' Then
    If Not FObjVen.fValidarValorEmissaoNFCePorEstado('NFCe') Then
      Exit(False);

  If (Not fPermiteEmissaoEspecie(FObjVen.strEspDoc)) Then
  Begin
    fMensagem('ATENÇÃO!',Format(MSG_ESPECIE_EMISSAO_NAO_PERMITIDA, [fGetConfiguracaoPermiteEmissaoEspecie(FObjVen.strEspDoc)]) , ['&OK']);
    Exit(False);
  End;

  If FObjVen.fTravaEmissaoDeCupomParaEcommerce Then
  Begin
    fMensagem('', 'Não é permitido emitir cupom fiscal para vendas online (e-commerce).', ['&Ok']);
    Exit(False);
  End;

  If Not FObjVen.fValidarBrindeEmCupom Then
    Exit(False);

  If Not fPermiteEmitirCupom(FObjVen) Then
    Exit(False);

  If Not FObjVen.fValidarTipoFaturamentoRetencoes Then
    Exit(False);

  If Not fPermiteEmitirCupomParaForaDoEstado(FObjVen) Then
    Exit(False);

  If Not fPermiteEmissaoEspecieMIFF(FObjVen) Then
    Exit(False);

  If Not fVerificaEmissaoTranfMesmaEmpresa(FObjVen) Then
    Exit(False);

  If Not fValidarEmitirCTe(FObjVen) Then
    Exit(False);

  If Not fValidarEmissaoNotaEspecialExpedicao(FObjVen) Then
    Exit(False);

  Result := True;
end;

class function TValidarFaturamento.Validate(AObjVenda: TFatVenda): Boolean;
var
  objValidacoes: TValidarFaturamento;
begin
  objValidacoes := TValidarFaturamento.Create(AObjVenda);
  Try
    If Not objValidacoes.fValidarConfiguracao Then
      Exit(False);

    If Not objValidacoes.fValidarCliente Then
      Exit(False);

    If Not objValidacoes.fValidarServicos Then
      Exit(False);

    If Not objValidacoes.fValidarProdutos Then
      Exit(False);

    If Not objValidacoes.fValidarFinanceiro Then
      Exit(False);

    If Not objValidacoes.fValidarEspecie Then
      Exit(False);

    If Not objValidacoes.fValidarImpostos Then
      Exit(False);

    If Not objValidacoes.fValidarEntrega Then
      Exit(False);

    Result := True;
  Finally
    FreeAndNil(objValidacoes);
  End;
end;

constructor TValidarFaturamento.Create(AObjVenda: TFatVenda);
begin
  Self.FObjVen := AObjVenda;
end;

function TValidarFaturamento.fValidarCliente: Boolean;
begin
  If Not FObjVen.fDadosCorretosParaClienteConsumidor(FObjVen.strEspDoc) Then
  Begin
    pMensagemOk(MSG_CLIENTE_DADOS_INCORRETOS_EMITIR_NFE);
    Exit(False);
  End;

  If (Not FObjVen.fValidarClienteEstoqueExterno(FObjVen.strCodCli)) Then
    Exit(False);

  If (Not FObjVen.fValidarClientePermiteFaturamentoDiaSemana(FObjVen.strCodCli)) Then
    Exit(False);

  If FObjVen.fTravarVendaClientePessoaFisica(FObjVen.strCodCli, FObjVen.intCgcCpf.ToString()) Then
    Exit(False);

  If Not FObjVen.fValidarCpfObrigatorio Then
    Exit(False);

  If Not FObjVen.fValidarCondicaoPrazoConsumidor Then
    Exit(False);

  If Not FObjVen.fValidarTipoFaturamentoEmail Then
    Exit(False);

  If Not fValidarCanhotoNotaFiscalPendente(FObjVen) Then
    Exit(False);

  If Not FObjVen.fVerificaFornedorMarcaNaoPermitidosParaCliente Then
    Exit(False);

  If (FObjVen.fClienteComProblemaNaConsultaDeSituacaoCadastral(FObjVen.strCodCli, FObjVen.strEspDoc, EmptyStr)) Then
    Exit(False);

  Result := True;
end;

function TValidarFaturamento.fValidarConfiguracao: Boolean;
begin
  If FObjVen.strEspDoc = 'NF' Then
    If Not fCfgSis('NFEUSA', varBoolean) Then
    Begin
      pMensagemOk(MSG_NAO_CONFIGURADO_NFE);
      Exit(False);
    End;

  If FObjVen.strEspDoc = 'IF' Then
    If (Not fCfgSis('USNFCE', varBoolean)) And (Not fUsaSat) Then
    Begin
      pMensagemOk(MSG_NAO_CONFIGURADO_NFCE);
      Exit(False);
    End;

  If fUsaRotinaWMS Then
    If Not VS_AutoatendimentoPagueFacil Then
      If Not FObjVen.blnExpedi Then
        If Not FObjVen.blnExecutandoFaturadorAutomatico Then
        Begin
          pMensagemOk(MSG_UTILIZA_ROTINA_WMS_FAT_EXP);
          Exit(False);
        End;

  If fUsaOndaSeparacaoExpedicao Then
    If Not VS_AutoatendimentoPagueFacil Then
      If Not FObjVen.blnExpedi Then
        If Not FObjVen.blnExecutandoFaturadorAutomatico Then
        Begin
          pMensagemOk(MSG_UTILIZA_ONDA_SEPARACAO_FAT_EXP);
          Exit(False);
        End;

  If fUsaOndaSeparacaoExpedicaoWMS Then
    If Not VS_AutoatendimentoPagueFacil Then
      If Not FObjVen.blnExpedi Then
        If Not FObjVen.blnExecutandoFaturadorAutomatico Then
        Begin
          pMensagemOk(MSG_UTILIZA_ONDA_SEPARACAO_WMS_FAT_EXP);
          Exit(False);
        End;

  Result := True;
end;

function TValidarFaturamento.fValidarFinanceiro: Boolean;
var
  LPendenciasFinanceiras: String;
begin
  If Not FObjVen.blnExpedi Then
    If Not FObjVen.blnExecutandoPagueFacil Then
      If Not fValidaSituacaoFinanceiraPedido(FObjVen.strNumOrc, FObjVen.strEspOrc, FObjVen.strEmpOri, LPendenciasFinanceiras) Then
      Begin
        pMensagemOk(LPendenciasFinanceiras);
        Exit(False);
      End;

  If FObjVen.blnExecutandoFaturadorAutomatico Then
    If fFormataFloat(FObjVen.fltValAdt, 2) >= fFormataFloat(FObjVen.fltTotGer, 2) Then
      Exit(True);

  If FObjVen.blnExecutandoPagueFacil Or FObjVen.blnExecutandoDesmembramentoPedidoPIX Then
    If FObjVen.fltValAdt <= 0 Then
    Begin
      pMensagemOk(MSG_PEDIDO_NAO_POSSUI_ADIANTAMENTO);
      Exit(False);
    End;

  If FObjVen.blnExecutandoPagueFacil Or FObjVen.blnExecutandoDesmembramentoPedidoPIX Then
    If fFormataFloat(FObjVen.fltValAdt,2) < fFormataFloat(FObjVen.fltTotGer,2) Then
    Begin
      pMensagemOk(MSG_PEDIDO_COM_ADIANTAMENTO_MENOR_TOTAL);
      Exit(False);
    End;

  If Not FObjVen.blnExecutandoPagueFacil Then
    If Not fVerificaFormaPagamento(FObjVen) Then
      Exit(False);

  If Not FObjVen.blnExecutandoPagueFacil Then
    If Not fVerificaCondicaoPagamento(FObjVen) Then
      Exit(False);

  If Not FObjVen.blnExpedi Then
    If Not FObjVen.blnExecutandoPagueFacil Then
      If Not fVerificaDebitosCliente(FObjVen) Then
        Exit(False);

  If Not FObjVen.blnExpedi Then
    If Not FObjVen.blnExecutandoPagueFacil Then
      If Not fVerificaLimiteCreditoPadrao(FObjVen) Then
        Exit(False);

  If FObjVen.blnExpedi Then
    If Not FObjVen.blnExecutandoPagueFacil Then
      If Not fVerificaLimiteCreditoExpedicao(FObjVen) Then
        Exit(False);

  If Not FObjVen.blnExpedi Then
    If Not FObjVen.blnExecutandoPagueFacil Then
      If (Not FObjVen.fVerificaIntervaloMargemValorCndPagto(FObjVen.strCodCnd)) Then
        Exit(False);

  If FObjVen.blnExpedi Then
    If Not fValidarPerfilCondicaoPagamentoExpedicao(FObjVen) Then
      Exit(False);

  If Not FObjVen.blnExecutandoPagueFacil Then
    If Not FObjVen.fVerificaValorMinimoParcela Then
      Exit(False);

  If Not FObjVen.blnExecutandoPagueFacil Then
    If Not FObjVen.fValidaValorMinimoVendaPrazo Then
      Exit(False);

  Result := True;
end;

function TValidarFaturamento.fValidarImpostos: Boolean;
begin
  If Not FObjVen.blnExpedi Then
    If Not FObjVen.fValidarDivergenciaST Then
      Exit(False);

  If FObjVen.blnExpedi Then
    If fExisteDivergenciaImpostosItensExpedidos(FObjVen) Then
      Exit(False);

  Result := True;
end;

end.
