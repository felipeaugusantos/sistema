unit untTValidaValorPedidoCompra;

interface

uses Classes, System.SysUtils, Data.DB, Uni, UniClientDataSet, System.StrUtils, System.Math, System.Variants,
     untZClient;

Type TValidaValorPedidoCompra = Class
  private
    FcdsTotalEmpresas: TZClient;

    FcdsItensMultLoja, //Cds com os itens multiloja
    FcdsItensPedido,   //Cds com os itens do pedido;
    FCdsFornecedores,  //Cds Com os Fornecedores, este é utilizado apenas na cotação.
    FcdsResumo: TUniClientDataSet;  //Cds calculado para ver se o tatal do pedido esta dentro do custo desejado.
    FblnExistePedidosComValoresInferiores: Boolean; //Quando terminar de processar define se tem documentos com valores abaixo do esperado.
    FblnCotacao: Boolean;  //marcador para saber se a class foi criado apartir da cotacao.
    FfltValorMinimo, //Valor minimo Campo FOR_MINPED da tabela CADFOR
    fltValFreGer,    //Valor do Frete
    fltDesAceGer: Double; //Valor das despesas
    qryCadEmp: TuniQuery;  //Todas as empresas para dar o loop qquando for multiloja
    FblnDesmebrandoPedido: Boolean;
    Procedure pProcessaValores;  //Processa os valores para saber o valor total dos pedidos. distribuindo para Multiloja ou Simples
    procedure pProcessaValoresMultiLoja; //Direciona o porcesso para multiloja porem separa por fornecedor quando processo inciado pela cotação
    procedure pProcessaValoresMultilojaAux(strCodForAtivo: string); //Processa os valores para pedido Multiloja.

    procedure pProcessaValoresMultilojaPedido; //Processa os valores para pedido Multiloja.

    function  fTrataNull(value: Variant): Variant;
    function  fTotalReformaPedido(ADataSet: TDataSet): Double;
    procedure pProcessaValoresPedidoSimples; //Processa os valores com pedido Simple (Sem ser Multi-loja)
    procedure pProcessaValoresPedidoSimplesAux(strCodForAtivo: string); //Processa os valores com pedido Simple (Sem ser Multi-loja)

    procedure pMontaEstruturaCdsResumo; //Monta a estrutura do CdsResumo
    procedure setValorMinimo(const Value: Double);
    function  fTrataCampoCdsItensSeCotacao(const Value: String): TAggregateField; //Se for cotação então trata o nome do campo do cds de Itens
    function  fIndice(intContador: Integer): String;
    function  fGetEmpresaLogadaQryEmpresa: String;//Carrega o código da empresa para quado for processamento simples
  public
    blnErroAoExecutar : Boolean;

    constructor Create(cdsItensMultLoja, cdsItensPedido, cdsFornecedores: TUniClientDataSet;
                         strCodFor: string; fltValDesAce: Double; fltValFrete: Double; blnDesmebrandoPedido: Boolean = False;
                         cdsTotalEmpresas: TZClient = Nil);

    destructor Destroy(); override;
    function fPedeSenhaLiberarTrava: Boolean;  //Chama a função fPedeSenha e monta os pedidos que vão ser liberados
    property intValorMinimo: double read FfltValorMinimo write setValorMinimo;  //Valor minimo do fornecedor Campo FOR_MINPED do cadastro de fornecedores
    property blnExistePedidosComValoresInferiores: boolean read  FblnExistePedidosComValoresInferiores ; //Property que marca quando for ter que solicitar senha
End;

var objValidaValorPedidoCompra: TValidaValorPedidoCompra;

implementation

{ TValidaValorPedidoCompra }

uses untFuncoesSimples, untTypesSistema,
  untILiberacao, untMsgLiberacao, untLiberacaoFactory;

constructor TValidaValorPedidoCompra.Create(cdsItensMultLoja, cdsItensPedido, cdsFornecedores: TUniClientDataSet; strCodFor: string;
  fltValDesAce: Double; fltValFrete: Double; blnDesmebrandoPedido: Boolean = False; cdsTotalEmpresas: TZClient = Nil);
var strFiltroCdsFornecedor,
    strFiltroCdsMultiLoja,
    strFiltroCdsItensPedido: String;
begin
  Try
    qryCadEmp := Nil;
    FcdsResumo := Nil;
    FcdsItensMultLoja := cdsItensMultLoja;
    FcdsTotalEmpresas := cdsTotalEmpresas;

    FblnDesmebrandoPedido := blnDesmebrandoPedido;
    FblnCotacao := False;
    strFiltroCdsMultiLoja   := '';
    strFiltroCdsItensPedido := '';
    strFiltroCdsFornecedor  := '';

    blnErroAoExecutar := False;

    FblnExistePedidosComValoresInferiores := False;

    If strCodFor <> '' Then
      FfltValorMinimo := fCampoTabela('FOR_MINPED', 'CADFOR', ['FOR_CODFOR' ], [strCodFor])
    Else
      FfltValorMinimo :=  0; //Utlizado apenas quando é Cotação

    If (FfltValorMinimo = 0) And (Not FblnCotacao)  Then
      Exit;

    qryCadEmp := fCriaQuery;
    qryCadEmp.SQL.Text := 'SELECT * FROM CADEMP';
    qryCadEmp.Open;

    FcdsResumo        := TUniClientDataSet.Create(Nil);

    //Utlizado apenas quando é Cotação
    If Assigned(cdsFornecedores) Then
    Begin
      FCdsFornecedores := cdsFornecedores;
      FblnCotacao:= True;
      If cdsFornecedores.Filtered Then
        FCdsFornecedores.Filtered := False;
      strFiltroCdsFornecedor := cdsFornecedores.Filter;
    End;

    If Assigned(cdsItensPedido) Then
    Begin
      FcdsItensPedido := cdsItensPedido;
      If cdsItensPedido.Filtered Then
        strFiltroCdsItensPedido := cdsItensPedido.Filter;
      FcdsItensPedido.Filtered := False;
    End;

    fltDesAceGer := fltValDesAce;
    fltValFreGer := fltValFrete ;

    pMontaEstruturaCdsResumo;
    If (FfltValorMinimo = 0) And (Not FblnCotacao)  Then
      Exit;
    pProcessaValores;
  Finally

    If Assigned(cdsItensMultLoja) Then
      cdsItensMultLoja.Filtered := False;
    If Assigned(cdsFornecedores) Then
      CdsFornecedores.Filtered := False;
    If Assigned(cdsItensPedido) Then
      cdsItensPedido.Filtered := False;

    If strFiltroCdsFornecedor <> '' Then
    Begin
      CdsFornecedores.Filtered := False;
      CdsFornecedores.Filter   := strFiltroCdsFornecedor;
      CdsFornecedores.Filtered  := True;
    End;

    If strFiltroCdsMultiLoja <> '' Then
    Begin
      cdsItensMultLoja.Filtered := False;
      cdsItensMultLoja.Filter   := strFiltroCdsMultiLoja;
      cdsItensMultLoja.Filtered := True;
    End;

    If strFiltroCdsItensPedido <> '' Then
    Begin
      cdsItensPedido.Filtered := False;
      cdsItensPedido.Filter   := strFiltroCdsItensPedido;
      cdsItensPedido.Filtered  := True;
    End;
  End;
end;

destructor TValidaValorPedidoCompra.Destroy;
begin
  If Assigned(FcdsResumo) Then
    FreeAndNil(FcdsResumo);

  If Assigned(qryCadEmp) Then
    FreeAndNil(qryCadEmp);
end;

function TValidaValorPedidoCompra.fPedeSenhaLiberarTrava: Boolean;
  Const
    cTitulo = 'PEDIDOS DE COMPRA COM VALORES MENORES QUE O PERMITIDO';
  Var
    strCodFor: String;
    objLiberacao : ILiberacao;
    objTabela : TRegistroMsgLiberaTabela;
	  objLinha  : TLinhaMsgLibera;
begin
  objLiberacao := TLiberacaoFactory.fGetLiberacao;
  objLiberacao.Clear;

  objLiberacao.objMsgLibera.pAddSeparador(138);
  objLiberacao.objMsgLibera.pAddTexto(cTitulo, alCentro, teAmbos, '', 138);


  If Not FblnCotacao Then
  Begin
    objLiberacao.objMsgLibera.pAddSeparador(138);
    objLiberacao.objMsgLibera.pAddTextoCaption('VALOR MINIMO EXIGIDO PELO FORNECEDOR', FormatFloat('#0.00', FfltValorMinimo));
  End;


  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'COD'            , 5  , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'EMPRESA'        , 25 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'TOT.ITENS'      , 15 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'TOT.IPI'        , 15 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'TOT.ST'         , 15 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'TOT.FRETE'      , 15 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'TOT.DESP.ACES.' , 16 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'TOT.GERAL'      , 15 , alDireita  , teAutcom);
  objTabela.lstLinhas.Add(objLinha);


  FcdsResumo.IndexFieldNames := 'CODFOR;CODEMP';
  FCdsResumo.First;

  While Not FcdsResumo.Eof Do
  Begin
    If strCodFor <> FCdsResumo.FieldByName('CODFOR').AsString Then
    Begin
      strCodFor := FCdsResumo.FieldByName('CODFOR').AsString;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('FORNECEDOR'  , strCodFor + ' - ' + fCampoTabela('FOR_NOMFOR', 'CADFOR', ['FOR_CODFOR' ], [strCodFor]) , 145  , alEsquerda);
      objTabela.lstLinhas.Add(objLinha);


      FfltValorMinimo := fCampoTabela('FOR_MINPED', 'CADFOR', ['FOR_CODFOR' ], [strCodFor]);

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('VALOR MINIMO EXIGIDO PELO FORNECEDOR' , FormatFloat('#0.00', FfltValorMinimo) , 145 , alEsquerda,  teAmbos, True);
      objTabela.lstLinhas.Add(objLinha);

    End;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('COD'            , FcdsResumo.FieldByName('CODEMP').AsString  , 5  , alCentro  );
    objLinha.pAddColuna('EMPRESA'        , FcdsResumo.FieldByName('NOMEMP').AsString , 25 , alEsquerda);
    objLinha.pAddColuna('TOT.ITENS'      , FormatFloat('#0.00', FcdsResumo.FieldByName('TOTITE').AsFloat) , 15 , alDireita );
    objLinha.pAddColuna('TOT.IPI'        , FormatFloat('#0.00', FcdsResumo.FieldByName('TOTIPI').AsFloat) , 15 , alDireita );
    objLinha.pAddColuna('TOT.ST'         , FormatFloat('#0.00', FcdsResumo.FieldByName('TOTSUB').AsFloat) , 15 , alDireita );
    objLinha.pAddColuna('TOT.FRETE'      , FormatFloat('#0.00', FcdsResumo.FieldByName('TOTFRE').AsFloat) , 15 , alDireita );
    objLinha.pAddColuna('TOT.DESP.ACES.' , FormatFloat('#0.00', FcdsResumo.FieldByName('TOTDES').AsFloat) , 16 , alDireita );
    objLinha.pAddColuna('TOT.GERAL'      , FormatFloat('#0.00', FcdsResumo.FieldByName('TOTGER').AsFloat) , 15 , alDireita );
    objTabela.lstLinhas.Add(objLinha);

    FcdsResumo.Next;
  End;

  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  objLiberacao.strDirAce := 'PEDMIN';
  objLiberacao.strMsgSen := cTitulo;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.blnSempreVariavelUsuario := True;

  Result := objLiberacao.fLibera;
End;

function TValidaValorPedidoCompra.fTrataCampoCdsItensSeCotacao(const Value: String): TAggregateField;
begin
  Result := nil;
  If FblnCotacao Then
  Begin
    If Value = 'TOT_TOTITE' Then
      Result := TAggregateField(FcdsItensMultLoja.FieldByName('TOT_VRTESC'))
    Else If Value = 'TOT_TOTSUB' Then
      Result := TAggregateField(FcdsItensMultLoja.FieldByName('TOT_ST_ESC'))
    Else If Value = 'TOT_TOTIPI' Then
      Result := TAggregateField(FcdsItensMultLoja.FieldByName('TOT_IPIESC'))
  End
  Else
    Result := TAggregateField(FcdsItensMultLoja.FieldByName(Value));
end;

function TValidaValorPedidoCompra.fTotalReformaPedido(ADataSet: TDataSet): Double;
begin
  Result := 0;
  // Na cotacao a soma usa os totais do fornecedor escolhido (TOT_VRTESC/IPIESC/ST_ESC), sem equivalente de CBS/IBS/IS
  If fSomarNovosImpostosDaReformaAoValorContabil And (Not FblnCotacao) Then
    Result := fTrataNull(TAggregateField(ADataSet.FieldByName('TOT_VALCBS')).Value) +
              fTrataNull(TAggregateField(ADataSet.FieldByName('TOT_VALIBS')).Value) +
              fTrataNull(TAggregateField(ADataSet.FieldByName('TOT_VAL_IS')).Value);
end;

function TValidaValorPedidoCompra.fTrataNull(value: Variant): Variant;
begin
  If Value = null Then
    Exit(0);
  Exit(Value);
end;

procedure TValidaValorPedidoCompra.pMontaEstruturaCdsResumo;
  procedure addField(Nome: string; Tipo: TFieldType; Tamanho: Integer);
  Begin
    With FcdsResumo.FieldDefs.AddFieldDef Do
    Begin
      Name := Nome;
      DataType := Tipo;
      Size := Tamanho;
    End;
  End;
Begin
  addField('TOTITE', ftFloat, 0);
  addField('TOTIPI', ftFloat, 0);
  addField('TOTSUB', ftFloat, 0);
  addField('TOTFRE', ftFloat, 0);
  addField('TOTDES', ftFloat, 0);
  addField('TOTGER', ftFloat, 0);
  addField('CODFOR', ftString, 9);
  addField('CODEMP', ftString, 3);
  addField('NOMEMP', ftString, 70);

  FcdsResumo.CreateDataSet;
end;

procedure TValidaValorPedidoCompra.pProcessaValores;

  function fProcessoComMultiLoja: boolean;
  Begin
    Result := False;
    If Assigned(FcdsItensMultLoja) Then
      If Not FcdsItensMultLoja.IsEmpty Then
        Result := True;
  End;

begin

  If ((FblnDesmebrandoPedido) Or (FblnCotacao)) And (fProcessoComMultiLoja) Then
    pProcessaValoresMultiLoja
  Else
    pProcessaValoresPedidoSimples;

  FblnExistePedidosComValoresInferiores := Not FcdsResumo.IsEmpty;
end;

procedure TValidaValorPedidoCompra.pProcessaValoresPedidoSimples;
Begin
  Try
    If FblnCotacao Then
    Begin
      FcdsFornecedores.First;
      While (Not FcdsFornecedores.Eof)  Do
      Begin

        FfltValorMinimo   := fCampoTabela('FOR_MINPED', 'CADFOR', ['FOR_CODFOR' ], [FcdsFornecedores.FieldByName('COT_CODFOR').AsString]);

        If FfltValorMinimo > 0 Then
        Begin
          FcdsItensPedido.Filter   := '(FORESC = ' + QuotedStr(FcdsFornecedores.FieldByName('COT_CODFOR').AsString )+ ') AND (QTDITE > 0) AND (PREESC > 0)';
          FcdsItensPedido.Filtered := True;
          pProcessaValoresPedidoSimplesAux(FcdsFornecedores.FieldByName('COT_CODFOR').AsString);
        End;

        FcdsFornecedores.Next;

      End;
    End
    Else
      pProcessaValoresPedidoSimplesAux('');
  Except
    On e: Exception do
    Begin
      blnErroAoExecutar := True;
      pMensagensErro(E.Message, '[TValidaValorPedidoCompra.pProcessaValoresMultiLoja]');
    End;
  End;
End;

procedure TValidaValorPedidoCompra.pProcessaValoresPedidoSimplesAux(
  strCodForAtivo: string);
  var
    fltSoma: Double;
Begin
  Try
    FcdsItensPedido.AggregatesActive := True;

    If FblnCotacao Then
    Begin
      fltSoma := TZClient(FcdsItensPedido).fRetSoma('SUM_VALTOT' + fIndice(FCdsFornecedores.FieldByName('POSICAO').AsInteger)) +
                 TZClient(FcdsItensPedido).fRetSoma('SUM_SUBTOT' + fIndice(FCdsFornecedores.FieldByName('POSICAO').AsInteger)) +
                 TZClient(FcdsItensPedido).fRetSoma('SUM_IPITOT' + fIndice(FCdsFornecedores.FieldByName('POSICAO').AsInteger)) +
                 fltValFreGer +
                 fltDesAceGer;
    End
    Else
    Begin
      fltSoma := fDoubleAggregate(FcdsItensPedido, 'TOT_TOTITE') +
                 fDoubleAggregate(FcdsItensPedido, 'TOT_TOTSUB') +
                 fDoubleAggregate(FcdsItensPedido, 'TOT_TOTIPI') +
                 fTotalReformaPedido(FcdsItensPedido) +
                 fltValFreGer +
                 fltDesAceGer;
    End;

    If fltSoma < FfltValorMinimo Then
    Begin

      FcdsResumo.Insert;
      If FblnCotacao Then
      Begin
        FcdsResumo.FieldByName('TOTITE').Value := TZClient(FcdsItensPedido).fRetSoma('SUM_VALTOT' + fIndice(FCdsFornecedores.FieldByName('POSICAO').AsInteger));
        FcdsResumo.FieldByName('TOTIPI').Value := TZClient(FcdsItensPedido).fRetSoma('SUM_IPITOT' + fIndice(FCdsFornecedores.FieldByName('POSICAO').AsInteger));
        FcdsResumo.FieldByName('TOTSUB').Value := TZClient(FcdsItensPedido).fRetSoma('SUM_SUBTOT' + fIndice(FCdsFornecedores.FieldByName('POSICAO').AsInteger));
      End
      Else
      Begin
        FcdsResumo.FieldByName('TOTITE').Value := TAggregateField(FcdsItensPedido.FieldByName('TOT_TOTITE')).Value;
        FcdsResumo.FieldByName('TOTIPI').Value := TAggregateField(FcdsItensPedido.FieldByName('TOT_TOTIPI')).Value;
        FcdsResumo.FieldByName('TOTSUB').Value := TAggregateField(FcdsItensPedido.FieldByName('TOT_TOTSUB')).Value;
      End;


      FcdsResumo.FieldByName('CODEMP').AsString := VS_StrCodEmp;
      FcdsResumo.FieldByName('NOMEMP').AsString := fGetEmpresaLogadaQryEmpresa;
      FcdsResumo.FieldByName('TOTFRE').Value := fltValFreGer;
      FcdsResumo.FieldByName('TOTDES').Value := fltDesAceGer;
      FcdsResumo.FieldByName('TOTGER').Value := fltSoma;
      FcdsResumo.Post;
    End;
  Except
    On e: Exception do
    Begin
      blnErroAoExecutar := True;
      pMensagensErro(E.Message, '[TValidaValorPedidoCompra.pProcessaValoresPedidoSimplesAux]');

    End;
  End;
end;

procedure TValidaValorPedidoCompra.pProcessaValoresMultiLoja;
Begin
  Try
//    FcdsItensMultLoja.DisableControls;
    Try
      If FblnCotacao Then
      Begin
        FcdsFornecedores.First;
        While (Not FcdsFornecedores.Eof)  Do
        Begin
          FfltValorMinimo   := fCampoTabela('FOR_MINPED', 'CADFOR', ['FOR_CODFOR' ], [FcdsFornecedores.FieldByName('COT_CODFOR').AsString]);
          If FfltValorMinimo > 0 Then
            pProcessaValoresMultilojaAux(FcdsFornecedores.FieldByName('COT_CODFOR').AsString);
          FcdsFornecedores.Next;
        End;
      End
      Else
        pProcessaValoresMultilojaPedido;

    Finally
//      FcdsItensMultLoja.EnableControls;

    End;
  Except
    On e: Exception do
    Begin
      blnErroAoExecutar := True;
      pMensagensErro(E.Message, '[TValidaValorPedidoCompra.pProcessaValoresMultiLoja]');
    End;
  End;
End;

procedure TValidaValorPedidoCompra.pProcessaValoresMultilojaAux(strCodForAtivo: string);
  var
    fltSoma,
    fltTotal,
    fltPropFrete,
    fltProDesAce: Double;
begin
  Try
    FcdsItensMultLoja.AggregatesActive := False;
    If FblnCotacao Then
    Begin
      FcdsItensMultLoja.Filtered  := False;
      FcdsItensMultLoja.Filter := 'ITE_QTDITE > 0  AND ITE_FORESC = ' + QuotedStr(strCodForAtivo) ;
      FcdsItensMultLoja.Filtered  := True;
    End;

    FcdsItensMultLoja.AggregatesActive := True;
    fltTotal := fTrataNull(fTrataCampoCdsItensSeCotacao('TOT_TOTITE').Value);
    qryCadEmp.First;
    While not qryCadEmp.Eof Do
    Begin
      FcdsItensMultLoja.AggregatesActive := False;
      FcdsItensMultLoja.Filtered := False;
      FcdsItensMultLoja.Filter := 'ITE_QTDITE > 0 AND ITE_CODEMP = ' + QuotedStr(qryCadEmp.FieldByName('EMP_CODEMP').AsString);
      If FblnCotacao Then
        FcdsItensMultLoja.Filter := FcdsItensMultLoja.Filter + ' AND ITE_FORESC  = ' + QuotedStr(strCodForAtivo);

      FcdsItensMultLoja.Filtered := True;
      FcdsItensMultLoja.AggregatesActive := True;

      If Not FCdsItensMultLoja.IsEmpty Then
      begin
        If fTrataNull(fTrataCampoCdsItensSeCotacao('TOT_TOTITE').Value) > 0 Then
        Begin

          fltPropFrete := (fltValFreGer * ((fTrataNull(fTrataCampoCdsItensSeCotacao('TOT_TOTITE').Value) * 100)/fltTotal)) / 100;
          fltProDesAce := (fltDesAceGer * ((fTrataNull(fTrataCampoCdsItensSeCotacao('TOT_TOTITE').Value) * 100)/fltTotal)) / 100;
          fltSoma := fTrataNull(fTrataCampoCdsItensSeCotacao('TOT_TOTITE').Value) +
                     fTrataNull(fTrataCampoCdsItensSeCotacao('TOT_TOTSUB').Value) +
                     fTrataNull(fTrataCampoCdsItensSeCotacao('TOT_TOTIPI').Value) +
                     fltPropFrete +
                     fltProDesAce +
                     fTotalReformaPedido(FcdsItensMultLoja);

          If fltSoma < FfltValorMinimo Then
          Begin
            FcdsResumo.Insert;
            FcdsResumo.FieldByName('CODEMP').AsString := qryCadEmp.FieldByName('EMP_CODEMP').AsString;
            FcdsResumo.FieldByName('NOMEMP').AsString := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
            FcdsResumo.FieldByName('TOTITE').Value := fTrataCampoCdsItensSeCotacao('TOT_TOTITE').Value;
            FcdsResumo.FieldByName('TOTIPI').Value := fTrataCampoCdsItensSeCotacao('TOT_TOTIPI').Value;
            FcdsResumo.FieldByName('TOTSUB').Value := fTrataCampoCdsItensSeCotacao('TOT_TOTSUB').Value;
            FcdsResumo.FieldByName('TOTFRE').Value := fltPropFrete;
            FcdsResumo.FieldByName('TOTDES').Value := fltProDesAce;
            FcdsResumo.FieldByName('TOTGER').Value := fltSoma;
            If FblnCotacao Then
              FcdsResumo.FieldByName('CODFOR').AsString := strCodForAtivo;

            FcdsResumo.Post;
          End;
        End;
      End;
      qryCadEmp.Next;
    End;
  Except
    On e: Exception do
    Begin
      blnErroAoExecutar := True;
      pMensagensErro(E.Message, '[TValidaValorPedidoCompra.pProcessaValoresMultilojaAux]');
    End;
  End;
end;

procedure TValidaValorPedidoCompra.pProcessaValoresMultilojaPedido;
  var
    fltSoma: Double;
begin
  Try

    qryCadEmp.First;
    While not qryCadEmp.Eof Do
    Begin

      If FcdsTotalEmpresas.FindKey([qryCadEmp.FieldByName('EMP_CODEMP').AsString]) Then
      begin

        fltSoma := FcdsTotalEmpresas.FieldByName('TOT_TOTITE').AsFloat +
                   FcdsTotalEmpresas.FieldByName('TOT_TOTSUB').AsFloat +
                   FcdsTotalEmpresas.FieldByName('TOT_TOTIPI').AsFloat +
                   FcdsTotalEmpresas.FieldByName('TOT_VALFRE').AsFloat +
                   FcdsTotalEmpresas.FieldByName('TOT_DESACE').AsFloat;

        If fSomarNovosImpostosDaReformaAoValorContabil Then
          fltSoma := fltSoma + FcdsTotalEmpresas.FieldByName('TOT_VALCBS').AsFloat +
                               FcdsTotalEmpresas.FieldByName('TOT_VALIBS').AsFloat +
                               FcdsTotalEmpresas.FieldByName('TOT_VAL_IS').AsFloat;

        If (fltSoma > 0) And (fltSoma < FfltValorMinimo) Then
        Begin
          FcdsResumo.Insert;
          FcdsResumo.FieldByName('CODEMP').AsString := qryCadEmp.FieldByName('EMP_CODEMP').AsString;
          FcdsResumo.FieldByName('NOMEMP').AsString := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
          FcdsResumo.FieldByName('TOTITE').Value    := FcdsTotalEmpresas.FieldByName('TOT_TOTITE').Value;
          FcdsResumo.FieldByName('TOTIPI').Value    := FcdsTotalEmpresas.FieldByName('TOT_TOTIPI').Value;
          FcdsResumo.FieldByName('TOTSUB').Value    := FcdsTotalEmpresas.FieldByName('TOT_TOTSUB').Value;
          FcdsResumo.FieldByName('TOTFRE').Value    := FcdsTotalEmpresas.FieldByName('TOT_VALFRE').Value;
          FcdsResumo.FieldByName('TOTDES').Value    := FcdsTotalEmpresas.FieldByName('TOT_DESACE').Value;
          FcdsResumo.FieldByName('TOTGER').Value    := fltSoma;
          FcdsResumo.Post;
        End;

      End;

      qryCadEmp.Next;
    End;
  Except
    On e: Exception do
    Begin
      blnErroAoExecutar := True;
      pMensagensErro(E.Message, '[TValidaValorPedidoCompra.pProcessaValoresMultilojaAux]');
    End;
  End;
end;

procedure TValidaValorPedidoCompra.setValorMinimo(const Value: Double);
begin
  If FfltValorMinimo <> Value Then
     FfltValorMinimo := Value;
end;

function TValidaValorPedidoCompra.fGetEmpresaLogadaQryEmpresa: String;
begin
  qryCadEmp.First;
  If qryCadEmp.Locate('EMP_CODEMP', VS_strCodEmp, []) Then
    Result := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
end;

Function TValidaValorPedidoCompra.fIndice(intContador: Integer): String;
Begin
  Result := RightStr('0' + IntToStr(intContador), 2);
End;

end.
