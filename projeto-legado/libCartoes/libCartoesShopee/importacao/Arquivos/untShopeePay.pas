unit untShopeePay;

interface

uses System.Classes, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Controls,
     WinApi.Windows, Vcl.Graphics, Vcl.Buttons, System.StrUtils,
     System.SysUtils,Vcl.ComCtrls, System.Generics.Collections, System.DateUtils,
     System.Json, Data.DB,

     HTTPSend, blcksock, synautil, ssl_openssl, cxProgressBar, Uni,

     untTShopeeImportacaoCartao, untIShopeeIntegracaoLibCartoes,
     untShopeePayPgto, untShopeeTipos;

Type
  TChavesShopee = class
  private
  public
    Empresa,
    Store,
    UserEmail,
    Password,
    Token: String;

    DataCriacao: TDateTime;

    Expiracao: Integer;
  end;

Type
  TShopeePay = Class(TShopeeImportacaoCartao)
    procedure pGravarRegistros(var prgStatus: TcxProgressBar); override;
    procedure pAdicionaLinhas(var prgStatus: TcxProgressBar);  override;
    procedure pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar); override;
    procedure ProcessaArquivosSelecionados(AArquivos: TStringList; var prgStatus: TcxProgressBar); override;
    procedure CarregaArquivosSelecionados(AAquivos: TStringList);
    procedure pAdiciona(itrCartoes: ICartoesShopee; stlArqs: TStringList; var prgStatus: TcxProgressBar);
    function fCarregaArquivos(strExt: String; APath: String): Boolean;
  Private
    objPgto : ICartoesShopee;

    FArquivosPay: TStringList;

    FHTTPSend: THTTPSend;

    FListaChavesShopee: TList<TChavesShopee>;

    FTimeZone: Integer;

    FImportacaoOrderAllHub: Boolean;

    FPedidosJaImportados: TStringList;

    function RetornaValorJson(AObjeto: TJsonObject;
                              ANomeCampo: String;
                              ACampoFloat: Boolean = False;
                              ACampoDataHora: Boolean = False): String;

    function ImportarArquivo(ALinha, ANomeArquivo: String):Boolean;
    function ArquivoDetalhadoOrderAll(ALinha:String): Boolean;
    function ArquivoInformacoesDaConta(ALinha:String): Boolean;
    function ArquivoDeRepasse(ALinha:String): Boolean;
    function RetornaLinhaArquivo(AFile: String; ANumeroLinha: Integer): String;

    function RetornaListaChavesShopee(ACodigoEmpresa: String): TList<TChavesShopee>;
    function PossuiTodosOsDadosDoHubPreenchidos(AChaveShopee: TChavesShopee): Boolean;
    procedure CriarComponentesRequisicao;
    procedure GerarToken(var AChaveShopee: TChavesShopee);

    function RetornaErroFormatadoHub(AResposta, AIDPedido: String): String;
    procedure AdicionaDadosDosPedidosListaHubShopee(AJsonRetorno: TJsonObject);

    function RetornaDataPagamentoArquivo(AIDPedido: String): String;

    procedure ProcessaDownloadPedidos(pgbProg: TcxProgressBar);
    procedure DownloadListaPedidos(var AChaveShopee: TChavesShopee;
                                   AListaPedidos: TJsonArray);

    function ValidaVendasDosArquivosImportados(ACodigoEmpresa: String): Boolean;

    function RetornaEmpresasConfiguracaoHub(AEmpresaSelecionada: String): String;
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;

    class function GetNaoImportadosHub: TStringList;
  End;

implementation

uses untTShopeeFuncoes;

{ TShopeePay }

procedure TShopeePay.AdicionaDadosDosPedidosListaHubShopee(
  AJsonRetorno: TJsonObject);
  Var
    LPedido: TRegistroPedidoPgto;

    LPedidoObject,
    LOrderIncome,
    LPaymentInfo: TJsonObject;

    LJsonArray,
    LJsonArrayProducts: TJsonArray;

    LArrayItem,
    LArrayItemProduct: TJSONValue;

    LIndiceNaoEncontrado: Integer;
begin
  If AJsonRetorno.GetValue('response') = Nil Then
    Exit;

  LJsonArray := Nil;
  LPedidoObject := Nil;
  LOrderIncome := Nil;
  LPaymentInfo := Nil;
  LJsonArrayProducts := Nil;
  Try
    LJsonArray := TJsonObject.ParseJSONValue(AJsonRetorno.GetValue('response').ToJson) As TJsonArray;
    If LJsonArray = Nil Then
      Exit;

    For LArrayItem In LJsonArray Do
    Begin
      TShopeeFuncoes.FreeAndNilObjeto(LOrderIncome);
      TShopeeFuncoes.FreeAndNilObjeto(LJsonArrayProducts);
      TShopeeFuncoes.FreeAndNilObjeto(LPaymentInfo);
      TShopeeFuncoes.FreeAndNilObjeto(LPedidoObject);

      LPedidoObject := TJsonObject.ParseJSONValue((LArrayItem As TJsonObject).GetValue('escrow_detail').ToJSON) As TJsonObject;

      LPedido.IDPedido := RetornaValorJson(LPedidoObject, 'order_sn');

      If LPedidoObject.GetValue('order_income') = Nil Then
      Begin
        FPedidosNaoEncontradosNoHub.Add(LPedido.IDPedido);

        Continue;
      End;

      LOrderIncome := TJsonObject.ParseJSONValue(LPedidoObject.GetValue('order_income').ToJson) As TJsonObject;

      LPedido.StatusPedido := 'COMPLETED';
      LPedido.NumeroRastreamento := '';

      LPedido.OpcaoEnvio := 'Shopee Xpress';
      If RetornaValorJson(LOrderIncome, 'actual_shipping_fee') = '0' Then
        LPedido.OpcaoEnvio := 'Shopee Entrega Direta';

      LPedido.MetodoEnvio := 'Retirada'; //não vem informação no hub
      LPedido.DataCriacaoPedido := RetornaDataPagamentoArquivo(LPedido.IDPedido);
      LPedido.DataPagamentoPedido := LPedido.DataCriacaoPedido;
      LPedido.DataPrevistaEnvio := '';  //não vem infomração no hub
      LPedido.PesoTotalPedido := ''; //não vem infomração no hub
      LPedido.ImportadoPelaAPI := 'S';
      LPedido.Empresa := strCodEmp;

      LPedido.DescontoVendedor1 := RetornaValorJson(LOrderIncome, 'seller_discount');
      LPedido.DescontoVendedor2 := RetornaValorJson(LOrderIncome, 'order_seller_discount');
      LPedido.ReembolsoShopee := RetornaValorJson(LOrderIncome, 'voucher_from_seller');

      If LOrderIncome.GetValue('seller_voucher_code') <> Nil Then
        LPedido.CodigoCupom := (LOrderIncome.GetValue('seller_voucher_code') As TJsonArray).ToJSON.Replace('[', EmptyStr)
                                                                                                  .Replace(']', EmptyStr)
                                                                                                  .Replace('"', EmptyStr);

      LPedido.CupomVendedor := RetornaValorJson(LOrderIncome, 'voucher_from_seller');
      LPedido.CupomShopee := RetornaValorJson(LOrderIncome, 'voucher_from_shopee');
      LPedido.ReembolsoShopee := RetornaValorJson(LOrderIncome, 'shopee_discount');
      LPedido.DescontoLeveMaisPorMenosVendedor := ''; //não vem infomração no hub
      LPedido.DescontoShopeeLeveMaisPorMenos := ''; //não vem infomração no hub
      LPedido.CompensarMoedasShopee := RetornaValorJson(LOrderIncome, 'coins');
      LPedido.TotalDescontadoCartaoCredito := RetornaValorJson(LOrderIncome, 'credit_card_transaction_fee');
      LPedido.TaxaEnvioPagaPeloComprador := RetornaValorJson(LOrderIncome, 'buyer_paid_shipping_fee');
      LPedido.DescontoFreteAproximado := RetornaValorJson(LOrderIncome, 'shopee_shipping_rebate');
      LPedido.TaxaEnvioReversa := RetornaValorJson(LOrderIncome, 'reverse_shipping_fee');
      LPedido.TaxaTransacao := RetornaValorJson(LOrderIncome, 'seller_transaction_fee');
      LPedido.TaxaTransacaoComprador := RetornaValorJson(LOrderIncome, 'buyer_transaction_fee');
      LPedido.TaxaComissao := RetornaValorJson(LOrderIncome, 'commission_fee');
      LPedido.TaxaServico := RetornaValorJson(LOrderIncome, 'service_fee');
      LPedido.TaxaProtecaoEnvio := RetornaValorJson(LOrderIncome, 'shipping_seller_protection_fee_amount');
      LPedido.TotalGlobal := RetornaValorJson(LOrderIncome, 'buyer_total_amount');
      LPedido.ValorEstimadoFrete := RetornaValorJson(LOrderIncome, 'estimated_shipping_fee');
      LPedido.ValorFreteAtual := RetornaValorJson(LOrderIncome, 'actual_shipping_fee');
      LPedido.ValorComisaoAMS := RetornaValorJson(LOrderIncome, 'order_ams_commission_fee');
      LPedido.ValorTotalAjustado := RetornaValorJson(LOrderIncome, 'total_adjustment_amount');
      LPedido.CoinCashback := RetornaValorJson(LOrderIncome, 'seller_coin_cash_back');
      LPedido.ValorTotalRecebido := RetornaValorJson(LOrderIncome, 'escrow_amount');
      LPedido.ValorDevolucao := RetornaValorJson(LOrderIncome, 'seller_return_refund');
      LPedido.DescontoOriginalShopee := RetornaValorJson(LOrderIncome, 'original_shopee_discount');
      LPedido.DescontoShopee := RetornaValorJson(LOrderIncome, 'shopee_discount');
      LPedido.DescontoPix := RetornaValorJson(LOrderIncome, 'pix_discount');
      LPedido.TaxaPublicidade := RetornaValorJson(LOrderIncome, 'ads_escrow_top_up_fee_or_technical_support_fee');
      LPedido.ReembolsoAjustavelDisputa := RetornaValorJson(LOrderIncome, 'drc_adjustable_refund');

      //buyer_payment_info
      LPaymentInfo := TJsonObject.ParseJSONValue(LPedidoObject.GetValue('buyer_payment_info').ToJson) As TJsonObject;

      LPedido.ValorFinalFrete :=  RetornaValorJson(LPaymentInfo, 'shipping_fee');
      LPedido.ValorTotal := RetornaValorJson(LPaymentInfo, 'merchant_subtotal'); //deve somar no final com modedas e cupons

      FPedidosJaImportados.Add(LPedido.IDPedido);

      LIndiceNaoEncontrado := FPedidosNaoEncontradosNoHub.IndexOf(LPedido.IDPedido);
      If LIndiceNaoEncontrado > -1 Then
        FPedidosNaoEncontradosNoHub.Delete(LIndiceNaoEncontrado);

      //items
      LJsonArrayProducts := TJsonObject.ParseJSONValue(LOrderIncome.GetValue('items').ToJson) As TJsonArray;

      For LArrayItemProduct In LJsonArrayProducts Do
      Begin
        LPedido.NomeProduto := RetornaValorJson(LArrayItemProduct As TJsonObject, 'item_name');
        LPedido.NumeroSKUPrincipal := RetornaValorJson(LArrayItemProduct As TJsonObject, 'item_sku');
        LPedido.NomeVariacao := RetornaValorJson(LArrayItemProduct As TJsonObject, 'model_name');
        LPedido.NumeroSKU := RetornaValorJson(LArrayItemProduct As TJsonObject, 'model_sku');
        LPedido.PrecoOriginal := RetornaValorJson(LArrayItemProduct As TJsonObject, 'original_price');
        LPedido.PrecoAcordado := RetornaValorJson(LArrayItemProduct As TJsonObject, 'discounted_price');
        LPedido.SubtotalProduto := RetornaValorJson(LArrayItemProduct As TJsonObject, 'discounted_price');
        LPedido.Quantidade := RetornaValorJson(LArrayItemProduct As TJsonObject, 'quantity_purchased');
        LPedido.QuantidadePedidos := RetornaValorJson(LArrayItemProduct As TJsonObject, 'quantity_purchased');
        LPedido.PesoTotalSKU := ''; //não vem infomração no hub

        SetLength(FRegShopeePayPgtoPedido, Length(FRegShopeePayPgtoPedido) + 1);
        FRegShopeePayPgtoPedido[Length(FRegShopeePayPgtoPedido) - 1] := LPedido;
      End;
    End;
  Finally
    TShopeeFuncoes.FreeAndNilObjeto(LOrderIncome);
    TShopeeFuncoes.FreeAndNilObjeto(LJsonArrayProducts);
    TShopeeFuncoes.FreeAndNilObjeto(LPaymentInfo);
    TShopeeFuncoes.FreeAndNilObjeto(LPedidoObject);

    TShopeeFuncoes.FreeAndNilObjeto(LJsonArray);
  End;
end;

function TShopeePay.ArquivoDeRepasse(ALinha: String): Boolean;
begin
  Result := True;

  ALinha := AnsiUpperCase(ALinha);

  If Not (Pos('DATA', ALinha) > 0) Then
    Result := False
  Else If Not (Pos('BENEFICIÁRIO', ALinha) > 0) Then
    Result := False
  Else If Not (Pos('PAGAMENTO', ALinha) > 0) Then
    Result := False
  Else If Not (Pos('DESCRIÇÃO', ALinha) > 0) Then
    Result := False;

  If Result Then
    Result := ALinha.Trim.Length = 39;
end;


function TShopeePay.ArquivoDetalhadoOrderAll(ALinha: String): Boolean;
begin
  Result := True;

  ALinha := AnsiUpperCase(ALinha);

  If Not (Pos('ID DO PEDIDO', ALinha) > 0) Then
    Result := False
  Else If Not (Pos('STATUS DO PEDIDO', ALinha) > 0) Then
    Result := False
  Else If Not (Pos('HORA DO PAGAMENTO DO PEDIDO', ALinha) > 0) Then
    Result := False
  Else If Not (Pos('VALOR TOTAL', ALinha) > 0) Then
    Result := False
  Else If Not (Pos('NOME DO PRODUTO', ALinha) > 0) Then
    Result := False
  Else If Not (Pos('PESO TOTAL SKU', ALinha) > 0) Then
    Result := False;
end;

function TShopeePay.ArquivoInformacoesDaConta(ALinha: String): Boolean;
begin
  Result := True;

  ALinha := AnsiUpperCase(ALinha);

  If Not (Pos('INFORMAÇÕES DA CONTA', ALinha) > 0) Then
    Result := False
end;

procedure TShopeePay.CarregaArquivosSelecionados(AAquivos: TStringList);
  Var
    I: Integer;
    strLinha  : String;
    txtArquivo: TextFile;
    LNomeArquivo : String;
Begin
  Try

    For I := 0 to AAquivos.Count - 1 Do
    Begin
      LNomeArquivo := System.SysUtils.ExtractFileName( AAquivos[I]);

      AssignFile(txtArquivo, AAquivos[I]);
      Reset(txtArquivo);
      Readln(txtArquivo, strLinha);
      strLinha := TShopeeFuncoes.fConverteParaAcento(strLinha);

      If ImportarArquivo(strLinha, LNomeArquivo) Or
         ImportarArquivo(RetornaLinhaArquivo(AAquivos[I],5), LNomeArquivo)  Then
        stlPgto.Add(AAquivos[I]);

      Flush(txtArquivo);
      Close(txtArquivo);
    End;

  Except
    Raise Exception.Create('Ocorreu um erro ao abrir o arquivo ' + LNomeArquivo  +
                           '. Verifique se esse não está aberto em outro programa.');
  End;
end;

constructor TShopeePay.Create(Owner: TComponent);
begin
  inherited;
  objPgto    := TShopeePayPgto.Create;

  FArquivosPay := TStringList.Create;

  FListaChavesShopee := TList<TChavesShopee>.Create;

  FTimeZone := TShopeeFuncoes.PegaTimeZone;

  FPedidosJaImportados := TStringList.Create;

  CriarComponentesRequisicao;

  strNomCon := 'ShopeePay';
  strMenCon := 'A conciliação é feita a partir do Relatório de Repasses da Shopee.';
end;

procedure TShopeePay.CriarComponentesRequisicao;
begin
  FHTTPSend := THTTPSend.Create;
  FHTTPSend.MimeType  := 'application/json';
  FHTTPSend.UserAgent := 'Mozilla/4.0';
  FHTTPSend.Protocol  := '1.1';
  FHTTPSend.KeepAlive := True;

  FHTTPSend.Sock.SSL.SSLType:= LT_TLSv1_2;

  FHTTPSend.Sock.SetTimeout( 15000 );
  FHTTPSend.Sock.ConnectionTimeout   := 15000;
  FHTTPSend.Sock.InterPacketTimeout  := False;
  FHTTPSend.Sock.NonblockSendTimeout := 15000;
  FHTTPSend.Sock.SocksTimeout        := 15000;
  FHTTPSend.Sock.HTTPTunnelTimeout   := 15000;
end;

destructor TShopeePay.Destroy;
begin
  If Assigned(FArquivosPay) Then
    FreeAndNil(FArquivosPay);

  If Assigned(FHTTPSend) Then
    FreeAndNil(FHTTPSend);

  If Assigned(FPedidosJaImportados) Then
    FreeAndNil(FPedidosJaImportados);

  If Assigned(FListaChavesShopee) Then
    FreeAndNil(FListaChavesShopee);

  objPgto := nil;
  inherited;
end;

procedure TShopeePay.DownloadListaPedidos(var AChaveShopee: TChavesShopee;
  AListaPedidos: TJsonArray);
  Const
    LINK_HUB: String = 'https://hub.citelsoftware.com.br/api/public/v1/orders/order-marketplace-info-list';

  Var
    LResposta: String;

    LParametros: TStringList;

    LFDataReq,
    LFDataResp: TMemoryStream;

    LJsonObject: TJsonObject;
begin
  LParametros := TStringList.Create;
  Try
    GerarToken(AChaveShopee);

    FHTTPSend.Headers.Clear;

    LParametros.Clear;
    LParametros.Add('authorization: Bearer ' + AChaveShopee.Token);
    FHTTPSend.Headers.AddStrings(LParametros);

    Try
      LFDataReq := TMemoryStream.Create;
      WriteStrToStream(LFDataReq, AnsiString(UTF8Encode('{"orderIds": ' + AListaPedidos.ToJSON + '}')));
      FHTTPSend.Document.LoadFromStream(LFDataReq);
    Finally
      FreeAndNil(LFDataReq);
    End;

    If FHTTPSend.HTTPMethod('POST', LINK_HUB) Then
    Begin

      FHTTPSend.Document.Position := 0;

      Try
        LFDataResp := TMemoryStream.Create;
        LFDataResp.LoadFromStream(FHTTPSend.Document);

        LFDataResp.Position := 0;
        LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

        If Not FHTTPSend.ResultCode.ToString.Equals('200') Then
          Raise Exception.Create(RetornaErroFormatadoHub(LResposta, AListaPedidos.ToString));

        LJsonObject := TJSONObject.ParseJSONValue(LResposta) As TJsonObject;

        AdicionaDadosDosPedidosListaHubShopee(LJsonObject);

        FreeAndNil(LJsonObject);
      Finally
        FreeAndNil(LFDataResp);
      End;
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

function TShopeePay.fCarregaArquivos(strExt: String; APath: String): Boolean;
  Var
    arqArquivo: TSearchRec;
    txtArquivo: TextFile;
    strLinha  : String;
Begin
  Result := True;
  If (FindFirst(APath + '\*.' + strExt, faAnyFile, arqArquivo) = 0) Then
  Begin

    Repeat

      Try
        AssignFile(txtArquivo, APath + '\' + arqArquivo.Name);
        Reset(txtArquivo);
        Readln(txtArquivo, strLinha);

        strLinha := TShopeeFuncoes.fConverteParaAcento(StringReplace(strLinha,',',#13,[rfReplaceAll]));

        If ImportarArquivo(strLinha, arqArquivo.Name) Or
           ImportarArquivo(RetornaLinhaArquivo(APath + '\' + arqArquivo.Name,5), arqArquivo.Name) Then
          stlPgto.Add(APath + '\' + arqArquivo.Name);

        Flush(txtArquivo);
        Close(txtArquivo);
      Except
        On E: Exception Do
        Begin
          If (UpperCase(E.Message) = 'I/O ERROR 32') Then
            Raise Exception.Create('O arquivo '+arqArquivo.Name+' está em uso por outro processo!')
          Else
            Raise Exception.Create(E.Message);
        End;
      End;

    Until (FindNext(arqArquivo) <> 0);

  End;
  FindClose(arqArquivo);
End;

procedure TShopeePay.GerarToken(var AChaveShopee: TChavesShopee);
  Var
    LDadosRequisicao,
    LJsonObject: TJsonObject;

    LResposta: String;

    LParametros: TStringList;

    LFDataReq,
    LFDataResp: TMemoryStream;
begin
  If Not AChaveShopee.Token.IsEmpty Then
  Begin
    if IncSecond(AChaveShopee.DataCriacao, AChaveShopee.Expiracao -20 - FTimeZone) <= TShopeeFuncoes.fNow then
      AChaveShopee.Token := EmptyStr;
  End;

  If Not AChaveShopee.Token.IsEmpty Then
    Exit;

  LParametros := TStringList.Create;
  Try
    Try
      FHTTPSend.Headers.Clear;
      LParametros.Add('Content-Type: application/json');
      LParametros.Add('Accept: */*');
      FHTTPSend.Headers.AddStrings(LParametros);

      LDadosRequisicao := TJsonObject.Create;
      LDadosRequisicao.Addpair('store', AChaveShopee.Store);
      LDadosRequisicao.Addpair('userEmail', AChaveShopee.UserEmail);
      LDadosRequisicao.Addpair('password', AChaveShopee.Password);

      Try
        LFDataReq := TMemoryStream.Create;
        WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(LDadosRequisicao.ToJSON)));
        FHTTPSend.Document.LoadFromStream(LFDataReq);
      Finally
        FreeAndNil(LFDataReq);
        FreeAndNil(LDadosRequisicao);
      End;

      If FHTTPSend.HTTPMethod('POST', 'https://hub.citelsoftware.com.br/api/public/v1/authenticate/login') Then
      Begin

        FHTTPSend.Document.Position := 0;

        Try
          LFDataResp := TMemoryStream.Create;
          LFDataResp.LoadFromStream(FHTTPSend.Document);

          LFDataResp.Position := 0;
          LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

          If Not FHTTPSend.ResultCode.ToString.Equals('200') Then
            Raise Exception.Create(RetornaErroFormatadoHub(LResposta, EmptyStr));

          LJsonObject := TJSONObject.ParseJSONValue(LResposta) As TJsonObject;

          AChaveShopee.Token := RetornaValorJson(LJsonObject, 'accessToken');
          If Not TryStrToInt(RetornaValorJson(LJsonObject, 'expiresIn'), AChaveShopee.Expiracao) Then
            AChaveShopee.Expiracao := 14400;
          If Not TryStrToDateTime(RetornaValorJson(LJsonObject, 'createdDate', False, True), AChaveShopee.DataCriacao) Then
          Begin
            AChaveShopee.DataCriacao := TShopeeFuncoes.RetornaDataHoraServidor;
            AChaveShopee.Expiracao := 300;
          End;

          FreeAndNil(LJsonObject);
        Finally
          FreeAndNil(LFDataResp);
        End;

      End;
    Except
      Raise;
    End;
  Finally
    FreeAndNil(LParametros);
  End;

end;

class function TShopeePay.GetNaoImportadosHub: TStringList;
begin
  If Not Assigned(FPedidosNaoEncontradosNoHub) Then
    FPedidosNaoEncontradosNoHub := TStringList.Create;

  Result := FPedidosNaoEncontradosNoHub;
end;

function TShopeePay.ImportarArquivo(ALinha, ANomeArquivo: String): Boolean;
begin
  Result := False;

  If (Pos('Declaração de conta - Shopee Cingapura', ALinha) > 0) Then
    Result := True
  Else If (Pos('Account statement - Shopee', ALinha) > 0) Then
    Result := True
  Else If ArquivoDeRepasse(ALinha) Then
    Result := True
  Else If ArquivoDetalhadoOrderAll(ALinha) Then
    Result := True
  Else If ArquivoInformacoesDaConta(ALinha) Then
  Begin
    If FArquivosPay.IndexOf(ANomeArquivo) = -1 Then
      FArquivosPay.Add(ANomeArquivo);

    Result := True;
  End;
end;

procedure TShopeePay.pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar);
  Var
    LArquivoAtual,
    LListaArquivos,
    LMensagemSucesso: String;
begin
  Try
    pDisableControls(True);
    Try
      FListaChavesShopee := RetornaListaChavesShopee(Empresa);

      If Not fCarregaArquivos('csv',strPath) Then
        Exit;

      If (stlPgto.Count = 0) Then
      Begin
        TShopeeFuncoes.fMensagem('AVISO','Nenhum arquivo na pasta para importar!',['&OK']);
        Exit;
      End;

      pAdicionaLinhas(prgStatus);
      If FImportacaoOrderAllHub Then
        ProcessaDownloadPedidos(prgStatus);
      pGravarRegistros(prgStatus);

      untShopeePayPgto.FPossuiTodosRegistros := ValidaVendasDosArquivosImportados(EmptyStr);

      LMensagemSucesso := 'Dados importados com sucesso';

      If (Not untShopeePayPgto.FPossuiTodosRegistros) And FImportacaoOrderAllHub And (FPedidosNaoEncontradosNoHub.Count > 0) Then
        LMensagemSucesso := LMensagemSucesso + ', porém ' + FPedidosNaoEncontradosNoHub.Count.ToString + ' pedido(s) não foi(ram) importado(s) pelo Hub.' + #13 +
                                               'Verifique se o arquivo é realmente da empresa selecionada.'
      Else If Not untShopeePayPgto.FPossuiTodosRegistros Then
        LMensagemSucesso := LMensagemSucesso + ', porém possui registros de pagamentos de vendas não importadas no período.'
      Else
        LMensagemSucesso := LMensagemSucesso + '!';

      TShopeeFuncoes.fMensagem('',LMensagemSucesso,['&OK']);

     If Not untShopeePayPgto.FPossuiTodosRegistros Then
      Begin
        LListaArquivos := '';
        For LArquivoAtual In FArquivosPay Do
          LListaArquivos := LListaArquivos + LArquivoAtual + ',';

        VS_FuncoesExternas.prcIExecutaRelatorio(543,
                                                37227,
                                                [],
                                                ['LISTA_ARQUIVOS',
                                                 'CODEMP'],
                                                [LeftStr(LListaArquivos, LListaArquivos.Length - 1),
                                                 Empresa],
                                                 nil,
                                                 [],
                                                 True);
      End;

      SetLength(FRegShopeePayPgtoPedido,0);
      frmImportacaoCartoes.Close;
    Except
      On E: Exception Do
      Begin
        TShopeeFuncoes.fMensagem('ATENÇÃO', E.Message, ['&OK']);

        objPgto := TShopeePayPgto.Create;

        stlPgto.Clear;
      End;
    End;
  Finally
    SetLength(FRegShopeePayPgto,0);
    SetLength(FRegShopeePayPgtoPedido,0);
    SetLength(FRegShopeePayPgtoRepasse,0);

    pDisableControls(False);
  End;
end;

procedure TShopeePay.ProcessaArquivosSelecionados(AArquivos: TStringList;
  var prgStatus: TcxProgressBar);
  Var
    LArquivoAtual,
    LListaArquivos,
    LMensagemSucesso : String;
begin
  Try
    Try
      FListaChavesShopee := RetornaListaChavesShopee(edtCodigoEmpresa.Text);

      CarregaArquivosSelecionados(AArquivos);
      If (stlPgto.Count = 0) Then
      Begin
        TShopeeFuncoes.fMensagem('','Nenhum arquivo na pasta para importar!',['&OK']);
        Exit;
      End;

      pAdicionaLinhas(prgStatus);
      If FImportacaoOrderAllHub Then
        ProcessaDownloadPedidos(prgStatus);
      pGravarRegistros(prgStatus);

      untShopeePayPgto.FPossuiTodosRegistros := ValidaVendasDosArquivosImportados(Empresa);

      LMensagemSucesso := 'Dados importados com sucesso';

      If (Not untShopeePayPgto.FPossuiTodosRegistros) And FImportacaoOrderAllHub And (FPedidosNaoEncontradosNoHub.Count > 0) Then
        LMensagemSucesso := LMensagemSucesso + ', porém ' + FPedidosNaoEncontradosNoHub.Count.ToString + ' pedido(s) não foi(ram) importado(s) pelo Hub.' + #13 +
                                               'Verifique se o arquivo é realmente da empresa selecionada.'
      Else If Not untShopeePayPgto.FPossuiTodosRegistros Then
        LMensagemSucesso := LMensagemSucesso + ', porém possui registros de pagamentos de vendas não importadas no período.'
      Else
        LMensagemSucesso := LMensagemSucesso + '!';

      TShopeeFuncoes.fMensagem('',LMensagemSucesso,['&OK']);

      If Not untShopeePayPgto.FPossuiTodosRegistros Then
      Begin
        LListaArquivos := '';
        For LArquivoAtual In FArquivosPay Do
          LListaArquivos := LListaArquivos + LArquivoAtual + ',';

        VS_FuncoesExternas.prcIExecutaRelatorio(543,
                                                37227,
                                                [],
                                                ['LISTA_ARQUIVOS',
                                                 'CODEMP'],
                                                [LeftStr(LListaArquivos, LListaArquivos.Length - 1),
                                                 Empresa],
                                                 nil,
                                                 [],
                                                 True);
      End;

      SetLength(FRegShopeePayPgtoPedido,0);
      frmImportacaoCartoes.Close;
    Except
      On E: Exception Do
      Begin
        TShopeeFuncoes.fMensagem('ATENÇÃO', E.Message, ['&OK']);

        objPgto := TShopeePayPgto.Create;

        stlPgto.Clear;
      End;
    End;
  Finally
    SetLength(FRegShopeePayPgto,0);
    SetLength(FRegShopeePayPgtoPedido,0);
    SetLength(FRegShopeePayPgtoRepasse,0);
  End;
end;

procedure TShopeePay.ProcessaDownloadPedidos(pgbProg: TcxProgressBar);
  Var
    LChaveShopee: TChavesShopee;

    LContador,
    LContadorPedidosLista,
    LContadorPedidos: Integer;

    LListaPedidos: TJsonArray;
begin
  TShopeeFuncoes.ValidaLibsWebService;

  If FListaChavesShopee.Count = 0 Then
    Exit;

  If FListaChavesShopee.Count > 0 Then
    SetLength(FRegShopeePayPgtoPedido, 0);

  If Assigned(FPedidosJaImportados) Then
    FreeAndNil(FPedidosJaImportados);
  FPedidosJaImportados := TStringList.Create;

  FPedidosNaoEncontradosNoHub.Clear;

  pgbProg.Properties.Max := Length(FRegShopeePayPgto);

  For LContador := 0 To FListaChavesShopee.Count - 1 Do
  Begin
    pgbProg.Position := 0;

    LChaveShopee := FListaChavesShopee[LContador];

    LContadorPedidosLista := 0;

    LListaPedidos := TJSONArray.Create;

    Try
      TShopeeFuncoes.pStepStatusGravacao(pgbProg, 'Aguarde... Importando detalhes dos pedidos.', False);
      For LContadorPedidos := 0 To Length(FRegShopeePayPgto) - 1 Do
      Begin
        TShopeeFuncoes.pStepStatusGravacao(pgbProg);

        If Not MatchStr(FRegShopeePayPgto[LContadorPedidos].LBenefi, ['Renda do pedido', 'Ajuste']) Then
          Continue;

        If FPedidosJaImportados.IndexOf(FRegShopeePayPgto[LContadorPedidos].LCodAut) > -1 Then
          Continue;

        If MatchStr(Trim(FRegShopeePayPgto[LContadorPedidos].LCodAut), ['', '-']) Then
          Continue;

        LListaPedidos.Add(FRegShopeePayPgto[LContadorPedidos].LCodAut);
        Inc(LContadorPedidosLista);

        If LContadorPedidosLista < 20 Then
        Begin
          If LContadorPedidos < Length(FRegShopeePayPgto) - 1 Then
           Continue;
        End;

        Try
          DownloadListaPedidos(LChaveShopee,
                               LListaPedidos);

          FListaChavesShopee[LContador] := LChaveShopee;

          pgbProg.Position := LContadorPedidos;

          LContadorPedidosLista := 0;

          LListaPedidos := TJSONArray.Create;
        Except
          Raise;
        End;
      End;

      If LContadorPedidosLista > 0 Then
      Begin
        Try
          DownloadListaPedidos(LChaveShopee,
                               LListaPedidos);

          FListaChavesShopee[LContador] := LChaveShopee;

          Application.ProcessMessages;
        Except
          Raise;
        End;
      End;
    Finally
      FreeAndNil(LListaPedidos);
    End;
  End;
end;

procedure TShopeePay.pAdiciona(itrCartoes: ICartoesShopee; stlArqs: TStringList;
  var prgStatus: TcxProgressBar);
  Var
    intCont: Integer;
    intLin : Integer;
    stlAux : TStringList;
begin
  stlAux := TStringList.Create;

  Try
    If SelecionarArquivos Then
      untShopeePayPgto.strCodEmp := Copy(Empresa, 1, 3);

    For intCont := 0 To stlArqs.Count -1 Do
    Begin
      Application.ProcessMessages;
      stlAux.LoadFromFile(stlArqs[intCont]);
      untShopeePayPgto.strNomArq := ExtractFileName(stlArqs[intCont]);
      untShopeePayPgto.FArquivoOrderAll := ArquivoDetalhadoOrderAll(stlAux.Text);
      untShopeePayPgto.FArquivoInformacaoConta  := ArquivoInformacoesDaConta(RetornaLinhaArquivo(stlArqs[intCont],5));

      If untShopeePayPgto.FArquivoOrderAll Then
        stlAux.Text := stlAux.Text.Replace(#13#10 + ';', ';')
                                  .Replace(#13 + ';', ';')
                                  .Replace(#13#10#13#10, #13#10)
                                  .Replace(#13#13, #13)
                                  .Replace(#10 + '"', '"')
                                  .Replace(#13 + '"', '"');

      prgStatus.Position := 0;
      prgStatus.Properties.Max := (stlAux.Count -1);
      For intLin := 0 To stlAux.Count -1 Do
      Begin

        If intLin = 0 Then
          untShopeePayPgto.FArquivoRepasse  := ArquivoDeRepasse(stlAux[intLin]);

        itrCartoes.pAdicionaLinha(stlAux[intLin]);
        TShopeeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Lendo arquivos.');
      End;

      stlAux.Clear;
    End;

    prgStatus.Position := 0;

  Finally
    FreeAndNil(stlAux);
  End;
end;

procedure TShopeePay.pAdicionaLinhas(var prgStatus: TcxProgressBar);
Begin
  Try
    SetLength(FRegShopeePayPgto , 0);
    pAdiciona(objPgto, stlPgto, prgStatus);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
End;

procedure TShopeePay.pGravarRegistros(var prgStatus: TcxProgressBar);
Var
  intCont: Integer;
begin
  TShopeeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Gravando registros.', False);
  objPgto.pGravarRegistros(prgStatus);

  For intCont := 0 to stlPgto.Count - 1 do
  Begin
    If (FileExists(AnsiReplaceStr(stlPgto[intCont], ExtractFileExt(stlPgto[intCont]), '.imp'))) Then
      DeleteFile(AnsiReplaceStr(stlPgto[intCont], ExtractFileExt(stlPgto[intCont]), '.imp'));
    TShopeeFuncoes.pRenomeiaAquivo(stlPgto[intCont], AnsiReplaceStr(stlPgto[intCont], ExtractFileExt(stlPgto[intCont]), '.imp'));
  end;
end;


function TShopeePay.PossuiTodosOsDadosDoHubPreenchidos(
  AChaveShopee: TChavesShopee): Boolean;
begin
  If Not Assigned(AChaveShopee) Then
    Exit(False);

  If AChaveShopee.Store.Trim.IsEmpty Then
    Exit(False);

  If AChaveShopee.UserEmail.Trim.IsEmpty Then
    Exit(False);

  If AChaveShopee.Password.Trim.IsEmpty Then
    Exit(False);

  Result := True;
end;

function TShopeePay.RetornaDataPagamentoArquivo(AIDPedido: String): String;
  Var
    LPedido: TRegistroPgto;
begin
  Result := '';

  For LPedido In FRegShopeePayPgto Do
  Begin
    If LPedido.LCodAut.Equals(AIDPedido) Then
      Exit(LPedido.LDtaDec + ' ' + LPedido.LHraDec);
  End;
end;

function TShopeePay.RetornaEmpresasConfiguracaoHub(
  AEmpresaSelecionada: String): String;
  Var
    LEmpresasCfg: String;
begin
  Result := AEmpresaSelecionada;

  LEmpresasCfg := VS_FuncoesExternas.fICfgSis('SHOHEM', varString, AEmpresaSelecionada);
  If LEmpresasCfg.Length < 3 Then
    Exit;

  Result := LEmpresasCfg;
end;

function TShopeePay.RetornaErroFormatadoHub(AResposta, AIDPedido: String): String;
begin
  Result := 'Erro código: ' + FHTTPSend.ResultCode.ToString;

  Case FHTTPSend.ResultCode Of
    204:      Result := Result + ' - O pedido ' + AIDPedido + ' não foi encontrado.';
    400, 415: Result := Result + ' - Requisição formada incorretamente.';
    401, 403: Result := Result + ' - Erro ao realizar a autenticação. Verifique as configurações de acesso ao Hub Citel!';
    404:      Result := Result + ' - Recurso ou pedido não encontrado.';
    500:      Result := Result + ' - Erro interno no servidor ao processar a requisição.';
  End;

  If Not FHTTPSend.Sock.LastErrorDesc.IsEmpty Then
    Result := Result + #13 + 'Descrição do erro: ' + FHTTPSend.Sock.LastErrorDesc;

  If Not AResposta.IsEmpty Then
    Result := Result + #13 + 'Retorno requisição: ' + AResposta;

  If Result.Contains('Verifique se o token está configurado em:') Then
    Result := Result.Replace('Verifique se o token está configurado em:', #13 + 'Verifique no portal Citel Hub se o token está configurado em:');
end;

function TShopeePay.RetornaLinhaArquivo(AFile: String; ANumeroLinha: Integer): String;
  Var
    MyFile: TextFile;
    LLinha: String;
    LineNumber: Integer;
begin
  Result := '';
  Try
    AssignFile(MyFile, AFile);
    Reset(MyFile);
    try
      LineNumber := 0;
      while not Eof(MyFile) do
      begin
        Readln(MyFile, LLinha);
        Inc(LineNumber);

        If LineNumber = ANumeroLinha then
        begin
            Result := LLinha;
            Break;
        end;
      end;
    finally
      CloseFile(MyFile);
    end;
  Except
    Result := '';
  End;
end;

function TShopeePay.RetornaListaChavesShopee(
  ACodigoEmpresa: String): TList<TChavesShopee>;
  Var
    LConsulta: TUniQuery;

    LChave: TChavesShopee;

    LEmpresasIn: String;
begin
  FImportacaoOrderAllHub := False;

  Result := TList<TChavesShopee>.Create;

  If ACodigoEmpresa.IsEmpty Then
    ACodigoEmpresa := Empresa;

  If VS_FuncoesExternas.fICfgSis('SHOHUB', varString, ACodigoEmpresa) <> 'S' Then
    Exit;

  LEmpresasIn := RetornaEmpresasConfiguracaoHub(ACodigoEmpresa);

  LConsulta := VS_FuncoesExternas.fICriaQuery;
  Try
    LConsulta.SQL.Text := 'SELECT H.* ' +
                          'FROM HUBCIT_CFGSIS H ' +
                          'WHERE H.SIS_HUBMKP = "HubCitel" ' +
                          '  AND H.SIS_CODCFG IN ("CFG_LOJA") ' +
                          '  AND H.SIS_CODEMP IN (' + TShopeeFuncoes.fRetStrToSQLIn(LEmpresasIn) + ')';

    LConsulta.Open;

    Try
      If LConsulta.IsEmpty Then
        Raise Exception.Create('A empresa está configurada para utilizar a conciliação de recebíveis com HUB Citel, ' +
                               'mas não possui as configurações de acesso preenchidas.' + #13 +
                               'Para utilizar a CFG_SHOHUB igual a Sim, deve preecher as configurações de acesso ao Hub Citel.');

      While Not LConsulta.Eof Do
      Begin
        LChave := TChavesShopee.Create;
        LChave.Empresa := LConsulta.FieldByName('SIS_CODEMP').AsString;
        LChave.Store := LConsulta.FieldByName('SIS_VALCFG').AsString;
        LChave.UserEmail := TShopeeFuncoes.RetornaValorConfiguracaoHub('CFG_USER', LChave.Empresa);
        LChave.Password := TShopeeFuncoes.RetornaValorConfiguracaoHub('CFG_SENHA', LChave.Empresa);

        If Not PossuiTodosOsDadosDoHubPreenchidos(LChave) Then
          Raise Exception.Create('A empresa ' + LConsulta.FieldByName('SIS_CODEMP').AsString +
                                 ' está configurada para utilizar a conciliação de recebíveis com HUB Citel, ' +
                                 'mas não possui as configurações de acesso preenchidas.' + #13 +
                                 'Para utilizar a CFG_SHOHUB igual a Sim, deve preecher as configurações de acesso ao Hub Citel.');

        Result.Add(LChave);

        LConsulta.Next;
      End;

      FImportacaoOrderAllHub := True;
    Except
      Raise;
    End;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

function TShopeePay.RetornaValorJson(AObjeto: TJsonObject; ANomeCampo: String;
  ACampoFloat: Boolean = False; ACampoDataHora: Boolean = False): String;
begin
  Result := EmptyStr;
  If AObjeto.GetValue(ANomeCampo) <> Nil Then
  Begin
    Result := AObjeto.GetValue<string>(ANomeCampo);
    If ACampoFloat Then
      Result := Result.Replace('.',',')
    Else If ACampoDataHora Then
      Result := Copy(Result, 9, 2) + '/' +
                Copy(Result, 6, 2) + '/' +
                Copy(Result, 1, 4) + ' ' +
                Copy(Result, 12, 8);
  End
end;

function TShopeePay.ValidaVendasDosArquivosImportados(ACodigoEmpresa: String): Boolean;
  Var
    LConsulta: TUniQuery;

    LArquivo,
    LInArquivos: String;
begin
  Result := True;

  If FArquivosPay.Count = 0 Then
    Exit;

  LInArquivos := '';
  For LArquivo In FArquivosPay Do
    LInArquivos := LInArquivos + '"' + LArquivo + '",';

  LInArquivos := LeftStr(LInArquivos, Length(LInArquivos) - 1);

  LConsulta := VS_FuncoesExternas.fICriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT SHO_SHPGTO.*, SHO_PDPGTO.SHO_ID_PED ' +
                          'FROM SHO_SHPGTO ' +
                          'LEFT JOIN SHO_PDPGTO ON SHO_PDPGTO.SHO_ID_PED=SHO_SHPGTO.SHO_CODAUT ';

    If Not ACodigoEmpresa.IsEmpty Then
      LConsulta.SQL.Add('  AND SHO_PDPGTO.SHO_CODEMP=SHO_SHPGTO.SHO_CODEMP ');

    LConsulta.SQL.Add('WHERE SHO_SHPGTO.SHO_NOMARQ IN (' + LInArquivos + ') ' +
                      '  AND SHO_PDPGTO.SHO_ID_PED IS NULL ');

    If Not ACodigoEmpresa.IsEmpty Then
      LConsulta.SQL.Add('  AND SHO_SHPGTO.SHO_CODEMP="' + ACodigoEmpresa + '"');

    LConsulta.Open;

    Result := LConsulta.IsEmpty;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

end.
