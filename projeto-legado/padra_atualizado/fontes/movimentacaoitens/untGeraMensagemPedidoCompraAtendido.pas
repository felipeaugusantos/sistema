unit untGeraMensagemPedidoCompraAtendido;

interface

uses SysUtils, strUtils, Classes, untZClient, untFuncoesSimples, Uni,
     cxProgressBar, DB, untGravando, forms, untMsgInterna;

Type
  TGeraMensagemPedidoCompraAtendido = Class
    Private
      FCdsItensMen: TZClient;
      qryConsulta: TUniQuery;
      frmGravando: TFrmGravando;
      qryOperadosMarcadosParaReceberNotificacao: TUniQuery;

      function  fRelacionaChavesPedidoEVenda(prgBarra: TcxProgressBar):Boolean;
      procedure pMontarCDS;
      procedure pMontarConsulta;

      procedure pAlimentarCDSComPedidos;
      function  fAlimentarCDSComPedidos(prgBarra: TCxProgressBar): boolean;

      procedure pCarregarDadosEntrada;
      function  fCarregarDadosEntrada(prgBarra: TcxProgressBar):Boolean;

      procedure pMontarMensagens;
      function  fMontarMensagens(prgBarra: TcxProgressBar):Boolean;

    Protected
      FstrCodOpe, FstrAutoIncEntrada: String;
      FstlPedidos: TStringList;
      msgMensagem: TMsgInterna;
      FQryEntMer: TUniQuery;
      function fGetSQL(blnConsulta: Boolean = False): string;
      procedure pProcessarDados;
    public
     constructor Create;
     Destructor  Destroy; override;
     class procedure pGerarNotificaoParaVendedoresComVendaPendente(strAutoIncEntrada: String; stlPedidos: TStringList; qryEntMer: TUniQuery; strCodOpe: String);
End;

implementation
{ TGeraMensagemPedidoCompraAtendido }


class procedure TGeraMensagemPedidoCompraAtendido.pGerarNotificaoParaVendedoresComVendaPendente(
  strAutoIncEntrada: String; stlPedidos: TStringList; qryEntMer: TUniQuery; strCodOpe: String);
  var
    objGeraMensagem: TGeraMensagemPedidoCompraAtendido;
begin
  If Not fCfgSis('UTNUPV', varBoolean) Then
    Exit;

  objGeraMensagem := TGeraMensagemPedidoCompraAtendido.Create;
  objGeraMensagem.FqryEntMer := qryEntMer;
  Try
    objGeraMensagem.FstrAutoIncEntrada := strAutoIncEntrada;
    If fEmptyStr(stlpedidos.Text) Then
    Begin
      If Assigned(qryEntMer) Then
      Begin
        pCriarFormularios(TfrmGravando, objGeraMensagem.frmGravando);
        objGeraMensagem.frmGravando.strChave := 'VALIDANDO ITENS PARA GERAR MENSAGEM DE PEDIDO DE COMPRA';
        objGeraMensagem.frmGravando.fExecutarAcao := objGeraMensagem.fRelacionaChavesPedidoEVenda;
        objGeraMensagem.frmGravando.ShowModal;
        FreeAndNil(objGeraMensagem.frmGravando);
      End
      Else
        Exit;
    End
    Else
      objGeraMensagem.Fstlpedidos.Text := stlPedidos.Text;
	  
    objGeraMensagem.FstrCodOpe := strCodOpe;
    {Faz todo o processo desde a manipulacao dos dados a geração da mensagem}
    If Not fEmptyStr(objGeraMensagem.Fstlpedidos.Text) Then
       objGeraMensagem.pProcessarDados;
  Finally
    FreeAndNil(objGeraMensagem);
  End
end;

procedure TGeraMensagemPedidoCompraAtendido.pProcessarDados;
begin
  pMontarConsulta;
  If qryConsulta.IsEmpty Then
    Exit;
  pMontarCDS;
  pAlimentarCDSComPedidos;
  pCarregarDadosEntrada;
  pMontarMensagens;
end;

procedure TGeraMensagemPedidoCompraAtendido.pMontarConsulta;
begin
  qryConsulta.SQL.Text := fGetSQL(True);
  qryConsulta.SQL.Add(' WHERE PCG.AUTOINCREM IN (' + fCommaText(FstlPedidos, True) +')');
  qryConsulta.Open;
end;

procedure TGeraMensagemPedidoCompraAtendido.pMontarCDS;
begin
  FCdsItensMen := TZClient.Create(nil, fGetSQL);
  FCdsItensMen.fAbreClient(True, 'TGeraMensagemPedidoCompraAtendido.pMontarCDS');
  FCdsItensMen.IndexFieldNames := 'FGO_CODVEN;FDO_SEQGER';
end;

function TGeraMensagemPedidoCompraAtendido.fAlimentarCDSComPedidos(prgBarra: TCxProgressBar): boolean;
  var
    iCol :integer;
begin
  qryConsulta.First;
  prgBarra.Position := 0;
  prgBarra.Properties.Max := qryConsulta.RecordCount -1;
  Result := False;
  Try

    While Not qryConsulta.Eof Do
    Begin
      FCdsItensMen.Insert;
      For iCol := 0 To qryConsulta.Fields.Count -1 Do
      Begin
        FCdsItensMen.FieldByName(qryConsulta.Fields[iCol].FieldName).Value := qryConsulta.Fields[iCol].Value;
      End;
      FCdsItensMen.Post;
      qryConsulta.Next;
      prgBarra.Position := prgBarra.Position  + 1;
      Application.ProcessMessages;
    End;
    Result := True;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'TGeraMensagemPedidoCompraAtendido.fAlimentarCDSComPedidos');
  End;
end;

procedure TGeraMensagemPedidoCompraAtendido.pAlimentarCDSComPedidos;
begin
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.strChave := 'PROCESSANDO OS PEDIDOS QUE PODEM SER ATENDIDOS';
  frmGravando.fExecutarAcao := fAlimentarCDSComPedidos;
  frmGravando.ShowModal;
  FreeAndNil(frmGravando);
end;

procedure TGeraMensagemPedidoCompraAtendido.pCarregarDadosEntrada;
begin
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.strChave := 'PROCESSANDO OS PEDIDOS QUE PODEM SER ATENDIDOS';
  frmGravando.fExecutarAcao :=   fCarregarDadosEntrada;
  frmGravando.ShowModal;
  FreeAndNil(frmGravando);
end;

function TGeraMensagemPedidoCompraAtendido.fCarregarDadosEntrada(prgBarra: TcxProgressBar):Boolean;
begin
  Result := True;
  Try
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT DET_NUMDOC, ');
    qryConsulta.SQL.Add('       DET_ESPDOC, ');
    qryConsulta.SQL.Add('       DET_CODITE, ');
    qryConsulta.SQL.Add('       DET_CODEMP, ');
    qryConsulta.SQL.Add('       DET_CODCLI, ');
    qryConsulta.SQL.Add('       DET_CODFOR, ');

    qryConsulta.SQL.Add('       DET_DTAENT, ');
    qryConsulta.SQL.Add('       DET_QTDITE, ');
    qryConsulta.SQL.Add('       DET_CODFOR  ');
    qryConsulta.SQL.Add('  FROM MOVDET      ');
    qryConsulta.SQL.Add(' WHERE DET_SEQGER = :AUTINC');

    qryConsulta.ParamByName('AUTINC').AsString := FstrAutoIncEntrada;
    qryConsulta.Open;
    If qryConsulta.IsEmpty Then
       Exit;

    prgBarra.Position := 0;
    prgBarra.Properties.Max := qryConsulta.RecordCount -1;
    While Not qryConsulta.Eof do
    Begin
      If FCdsItensMen.Locate('FDO_CODITE', qryConsulta.FieldByName('DET_CODITE').AsString, []) Then
      Begin
        FCdsItensMen.Edit;
        FCdsItensMen.FieldByName('ENT_QTDENT').Value := qryConsulta.FieldByName('DET_QTDITE').Value;
        FCdsItensMen.FieldByName('ENT_SALDIS').Value := fRetornaSaldoDisponivel(qryConsulta.FieldByName('DET_CODITE').AsString);
        FCdsItensMen.FieldByName('DET_NUMDOC').Value := qryConsulta.FieldByName('DET_NUMDOC').Value;
        FCdsItensMen.FieldByName('DET_ESPDOC').Value := qryConsulta.FieldByName('DET_ESPDOC').Value;
        FCdsItensMen.FieldByName('DET_CODEMP').Value := qryConsulta.FieldByName('DET_CODEMP').Value;
        FCdsItensMen.FieldByName('DET_CODFOR').Value := qryConsulta.FieldByName('DET_CODFOR').Value;
        FCdsItensMen.FieldByName('DET_CODCLI').Value := qryConsulta.FieldByName('DET_CODCLI').Value;
        FCdsItensMen.FieldByName('DET_CODFOR').Value := qryConsulta.FieldByName('DET_CODFOR').Value;
        FCdsItensMen.FieldByName('DET_DTAENT').Value := qryConsulta.FieldByName('DET_DTAENT').Value;

        FCdsItensMen.FieldByName('ATENDIDO').AsInteger := IIf(qryConsulta.FieldByName('DET_QTDITE').AsFloat >=
                                                              FCdsItensMen.FieldByName('FDO_QTDITE').AsFloat,  1, 0);
        FCdsItensMen.Post;
      End;
      qryConsulta.Next;
      prgBarra.Position := prgBarra.Position  + 1;
      Application.ProcessMessages;

    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'TGeraMensagemPedidoCompraAtendido.fCarregarDadosEntrada');
      Result := False;
    End;
  End;
end;

procedure TGeraMensagemPedidoCompraAtendido.pMontarMensagens;
Begin
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.strChave := 'GERANDO MENSAGEM AOS VENDEDORES QUE PODEM SER ATENDIDOS POR ESTA ENTRADA.';
  frmGravando.fExecutarAcao := fMontarMensagens;
  frmGravando.ShowModal;
  FreeAndNil(frmGravando);
End;

constructor TGeraMensagemPedidoCompraAtendido.create;
begin
  qryConsulta := fCriaQuery(nil);
  msgMensagem := TMsgInterna.Create(nil);
  Fstlpedidos := TStringList.Create;

  qryOperadosMarcadosParaReceberNotificacao := fCriaQuery(nil);
  qryOperadosMarcadosParaReceberNotificacao.SQL.Add('SELECT OPE_CODOPE FROM CADOPE WHERE OPE_MSGCVA  = "S"');
  qryOperadosMarcadosParaReceberNotificacao.Open;
end;

destructor TGeraMensagemPedidoCompraAtendido.Destroy;
begin
  FreeAndNil(qryConsulta);
  FreeAndNil(msgMensagem);
  FreeAndNil(Fstlpedidos);
  FreeAndNil(qryOperadosMarcadosParaReceberNotificacao);
end;

function TGeraMensagemPedidoCompraAtendido.fgetSQL(blnConsulta: Boolean): string;
begin
  Result := Result + '  SELECT PCD_NUMPED, ';
  Result := Result + '         PCD_ESPDOC, ';
  Result := Result + '         PCD_CODEMP, ';
  Result := Result + '         PCD_DESITE, ';
  Result := Result + '         PCG_CODFOR, ';
  Result := Result + '         PCG_CODCMP, ';
  Result := Result + '         PCG_DTAPED, ';
  Result := Result + '         PCG_DTAENT, ';
  Result := Result + '         FGO_NUMDOC, ';
  Result := Result + '         FGO_CODCLI, ';
  Result := Result + '         FGO_CODVEN, ';
  Result := Result + '         FGO_CODCND, ';
  Result := Result + '         FGO_CONPAG, ';
  Result := Result + '         FGO_DTAENT, ';
  Result := Result + '         FGO_VLRCON, ';
  Result := Result + '         FDO_SEQGER, ';
  Result := Result + '         FDO_CODITE, ';
  Result := Result + '         FDO_DESCRI, ';
  Result := Result + '         UNI_SIGUNI AS FDO_SIGUNI, ';
  Result := Result + '         FDO_QTDITE, ';
  Result := Result + '         FDO_UNITAR, ';
  Result := Result + '         FDO_TOTITE  ';

  If Not blnConsulta Then
  Begin
     Result := Result + '     ,0 ENT_QTDENT, ';
     Result := Result + '      0 ENT_SALDIS, ';
     Result := Result + '      FDO_NUMDOC AS DET_NUMDOC, ';
     Result := Result + '      FDO_ESPDOC AS DET_ESPDOC, ';
     Result := Result + '      FDO_CODEMP AS DET_CODEMP, ';
     Result := Result + '      PCG_CODFOR AS DET_CODFOR, ';
     Result := Result + '      FGO_CODCLI AS DET_CODCLI, ';
     Result := Result + '      FGO_DTAENT AS DET_DTAENT, ';
     Result := Result + '      0 AS ATENDIDO ';
  End;
  Result := Result + '    FROM PCMDET PCD   ';
  Result := Result + '   INNER JOIN PCMGER PCG ON PCG.PCG_NUMPED = PCD.PCD_NUMPED ';
  Result := Result + '                        AND PCG.PCG_CODEMP = PCD.PCD_CODEMP ';
  Result := Result + '                        AND PCG.PCG_ESPDOC = PCD.PCD_ESPDOC ';
  Result := Result + '   INNER JOIN FATDOR FDO ON FDO.AUTOINCREM = PCD.PCD_SEQFDO ';
  Result := Result + '                        AND FDO.FDO_JAFATU = 0 ';
  Result := Result + '   INNER JOIN FATGOR FGO ON FGO.AUTOINCREM = FDO.FDO_SEQGER ';
  Result := Result + '   INNER JOIN CADUNI UNI ON UNI.UNI_CODUNI = FDO.FDO_UNIDAD ';
  If Not blnConsulta Then
    Result := Result + ' WHERE FALSE ';
end;

function TGeraMensagemPedidoCompraAtendido.fMontarMensagens(
  prgBarra: TcxProgressBar): Boolean;
  Var stlMensagem,
    stlPedidoCompra: TStringList;
    strVendedor,
    strLinha,
    strPedidoVenda,
    strPedidoCompra: string;
    //Variavel de contole para saber quando devera imprimir os titulos dos itens;
     blnNovoPedido: Boolean;

  procedure pMontaLinha(strMensagem: string; intPosicao: integer; stlDestino: TStringList = nil); overload;
  Begin
    Insert(strMensagem, strLinha, intPosicao);
    If Assigned(stlDestino) Then
    Begin
      stlDestino.Add(Copy(strLinha,0, 105));
      strLinha := StringOfChar(' ', 105);
    End;
  End;

  procedure pMontaLinha(strMensagem: string; intPosicao: integer; intLength: Integer; stlDestino: TStringList = nil); overload;
  Begin
    strMensagem := Copy(strMensagem, 0, intLength);
    pMontaLinha(strMensagem, intPosicao, stlDestino);
  End;

  procedure pMontaLinhaAlgDireita(strMensagem: string; intPosIni, intPosFin: Integer; stlDestino: TStringList = nil);
  Begin
    If (IntPosFin-intPosIni - Length(strMensagem)) < 0  Then
      strMensagem := Copy (strMensagem, ((IntPosFin-intPosIni-Length(strMensagem)) * -1), Length(strMensagem));
    pMontaLinha(strMensagem, intPosFin - Length(strMensagem) + 1, stlDestino);
  End;

  Procedure pAddLinha(sltDestino: TStringList);
  Begin
    strLinha := StringOfChar('-', 105);
    sltDestino.Add(strLinha);
    strLinha := StringOfChar(' ', 105);
  End;

  Function fValue(strField: string; intFormatFloat: integer = 0) :String;
  Begin
    If intFormatFloat > 0 Then
      Result := FloatToStrF(FCdsItensMen.FieldByName(strField).AsFloat, ffNumber, 12, intFormatFloat)
    Else
      Result := FCdsItensMen.FieldByName(strField).AsString
  End;

  procedure pEnvia(strDestino: String);
  begin
      msgMensagem.fEnviaMensagem('NOVA ENTRADA DE MERCADORIA COM PEDIDO DE VENDA PENDENTE',
                                 stlMensagem.Text,
                                 FstrCodOpe,
                                 strDestino,
                                 'N',
                                 '');

  End;

  procedure pEscreveMensagem;
  Begin
    stlMensagem.Text := ReplaceText(stlMensagem.Text, '#LISTPEDCOM#', stlPedidoCompra.Text);

    pEnvia(strVendedor);

    qryOperadosMarcadosParaReceberNotificacao.First;
    While Not qryOperadosMarcadosParaReceberNotificacao.Eof Do
    Begin
      If qryOperadosMarcadosParaReceberNotificacao.FieldByName('OPE_CODOPE').AsString <> strVendedor Then
        pEnvia(qryOperadosMarcadosParaReceberNotificacao.FieldByName('OPE_CODOPE').AsString);
      qryOperadosMarcadosParaReceberNotificacao.Next;
    End
  End;



begin
  Result := True;
  Try
    stlMensagem := TStringList.Create;
    blnNovoPedido := False;
    stlPedidoCompra := TStringList.Create;
    FCdsItensMen.Filter := ' ATENDIDO = 1';
    FCdsItensMen.Filtered := True;
    strPedidoVenda  := '';
    strPedidoCompra := '';
    strVendedor  := '';
    prgBarra.Position := 0;
    prgBarra.Properties.Max := FCdsItensMen.RecordCount -1;

    Try

       While Not FCdsItensMen.Eof do
       Begin
         //Vai ser impresso por pedido de venda
         If (strPedidoVenda <> fValue('FDO_SEQGER')) Then
         Begin
           //Se mudar o pedido Envia a mensagem;
           //Se o strPedidoVenda = '' Quer dizer que ja foi montado para um pedido anterior;
           If Not fEmptyStr(strPedidoVenda) Then
           Begin
             //Ajusta a mensagem para receber os pedidos de compras relacionados a este pedido
             strPedidoVenda := fValue('FDO_SEQGER');

             pEscreveMensagem;
             stlMensagem.Clear;
             stlPedidoCompra.Clear;

           End;
           //Armazena o vendedor para poder enviar a mensagem para o vendedor correto
           strVendedor := fValue('FGO_CODVEN');
           strPedidoVenda := fValue('FDO_SEQGER');
           pAddLinha(stlMensagem);
           pMontaLinha('NOVA ENTRADA DE MERCADORIA COM PEDIDO DE VENDA PENDENTE', 29, stlMensagem);
           pAddLinha(stlMensagem);
           //Imprime o Pedido de Venda
           pMontaLinha('Pedido de Venda      : ' + fValue('FGO_NUMDOC') + '-' + fValue('PCD_ESPDOC') + '-' + fValue('PCD_CODEMP'), 0, stlMensagem);
           pMontaLinha('Cliente              : ' + fValue('FGO_CODCLI') + '-' + fRetNomCliente(fValue('FGO_CODCLI')), 0, stlMensagem);
           pMontaLinha('Vendedor             : ' + fValue('FGO_CODVEN') + '-' + fRetNomVendRep(fValue('FGO_CODVEN')), 0, stlMensagem);
           pMontaLinha('Condição de Pagamento: ' + fValue('FGO_CODCND') + '-' + fRetDesConPag(fValue('FGO_CODCND')), 0, stlMensagem);
           pMontaLinha('                         ' + fFormataCondPag(fValue('FGO_CONPAG')) , 0, stlMensagem);
           pMontaLinha('Data do Pedido       : ' + fValue('FGO_DTAENT'), 0);
           pMontaLinha('Valor Total: ' + fValue('FGO_VLRCON', 2) , 59, stlMensagem);

           //Imprime a nota de entrada
           pAddLinha(stlMensagem);
           pMontaLinha('Nota de Entrada      : ' + fValue('DET_NUMDOC') + '-' + fValue('DET_ESPDOC') + '-' + fValue('DET_CODEMP'), 0, stlMensagem);
           If Not fEmptyStr(fValue('DET_CODFOR')) Then
             pMontaLinha('Fornecedor           : ' + fValue('DET_CODFOR') + '-' + fRetNomFornecedor(fValue('DET_CODFOR')), 0, stlMensagem)
           Else
             pMontaLinha('Cliente              : ' + fValue('DET_CODCLI') + '-' + fRetNomCliente(fValue('DET_CODCLI')), 0, stlMensagem);

           pMontaLinha('Data da Compra:      : ' + fValue('DET_DTAENT'), 0, stlMensagem);
           pMontaLinha('#LISTPEDCOM#', 0, stlMensagem);
           blnNovoPedido := True;
         End;
         //Imprime os pedidos de compra
         If strPedidoCompra <> fValue('FDO_SEQGER') Then
         Begin
           strPedidoCompra := fValue('FDO_SEQGER');
           pAddLinha(stlPedidoCompra);
           pMontaLinha('Pedido de Compra     : ' + fValue('PCD_NUMPED') + '-' + fValue('PCD_ESPDOC') + '-' + fValue('PCD_CODEMP'), 0, stlPedidoCompra);
           pMontaLinha('Fornecedor           : ' + fValue('PCG_CODFOR') + '-' + fRetNomFornecedor(fValue('PCG_CODFOR')) ,  0, stlPedidoCompra);
           pMontaLinha('Comprador            : ' + fValue('PCG_CODCMP') + '-' + fRetNomVendRep(fValue('PCG_CODCMP')), 0, stlPedidoCompra);
           pMontaLinha('Data do Pedido       : ' + fValue('PCG_DTAPED'), 0, stlPedidoCompra);
           pMontaLinha('Data de Entrega      : ' + fValue('PCG_DTAENT'), 0, stlPedidoCompra);
           pAddLinha(stlPedidoCompra);
         End;
         //Imprime os itens do pedido
         If blnNovoPedido Then
         Begin
           pMontaLinha('ITENS QUE PODEM SER ATENDIDAS ATRAVÉS DA ENTRADA', 32, stlMensagem);
           pAddLinha(stlMensagem);
           pMontaLinha('PRODUTO                         UN    QTD.PEDIDO  QTD.ENTRADA  VR.UNITARIO     VR.TOTAL  SALDO DISPONIVEL', 0, stlMensagem);
    //Regua             123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345
    //Regua                      1         2         3         4         5         6         7         8         9         1

           pAddLinha(stlMensagem);
         End;
         pMontaLinha(fValue('FDO_CODITE') + '-' + fValue('FDO_DESCRI'), 0, 30);
         pMontaLinha(fValue('FDO_SIGUNI'), 33, 5);
         pMontaLinhaAlgDireita(fValue('FDO_QTDITE', 2), 39, 48);
         pMontaLinhaAlgDireita(fValue('ENT_QTDENT', 2), 51, 61);
         pMontaLinhaAlgDireita(fValue('FDO_UNITAR', 2), 64, 74);
         pMontaLinhaAlgDireita(fValue('FDO_TOTITE', 2), 77, 87);
         pMontaLinhaAlgDireita(fValue('ENT_SALDIS', 2), 90, 105, stlMensagem);
         blnNovoPedido := False;
         FCdsItensMen.Next;
         prgBarra.Position := prgBarra.Position  + 1;
         Application.ProcessMessages;
       End;
       pEscreveMensagem;
    Finally
      FreeAndNil(stlMensagem);
      FreeAndNil(stlPedidoCompra);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'TGeraMensagemPedidoCompraAtendido.fMontarMensagens');
      Result := False;
    End;
  End;
end;

function TGeraMensagemPedidoCompraAtendido.fRelacionaChavesPedidoEVenda(
  prgBarra: TcxProgressBar): Boolean;
  var strAutInc: String;
      intPos: Integer;
begin
  FqryEntMer.First;
  Result := True;
  Try

    prgBarra.Position := 0;
    prgBarra.Properties.Max := FqryEntMer.RecordCount -1;

    While not FqryEntMer.Eof Do
    Begin
      // Pela entrada proucura as chaves do pedido de compra para poder identificar os itens relacionados
      If Not fEmptyStr(FqryEntMer.FieldByName('ENT_NUMPED').AsString)Then
      Begin
        strAutInc     := fCampoTabela('AUTOINCREM', 'PCMGER', ['PCG_NUMPED', 'PCG_CODEMP'],
                                      [FqryEntMer.FieldByName('ENT_NUMPED').AsString,
                                       FqryEntMer.FieldByName('ENT_CODEMP').AsString]);
         If (Not Fstlpedidos.Find(strAutInc, intPos)) Then
           Fstlpedidos.Add(strAutInc);
      End;
      FqryEntMer.Next;
      prgBarra.Position := prgBarra.Position  + 1;
      Application.ProcessMessages;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'TGeraMensagemPedidoCompraAtendido.fRelacionaChavesPedidoEVenda');
      Result := False;
    End;
  End;
end;

end.
