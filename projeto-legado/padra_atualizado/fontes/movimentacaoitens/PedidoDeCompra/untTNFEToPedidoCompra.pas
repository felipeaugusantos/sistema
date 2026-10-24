unit untTNFEToPedidoCompra;


interface

uses Forms, untZClient, cxProgressBar, untGravando, untFuncoesSimples, SysUtils,
      Uni, untGerarOrcamentoCompraAuto, untPreNota, System.Classes, strUtils, Data.DB,
      untSaldoPedidoCompra, untTypesSistema, untFuncoesPedidoSimples, untLiberacao;

  type
  TNFEToPedidoCompra = class
  protected
    qryGerele : TZClient;
    blnUniCom: Boolean;
    OrigemNfeToPedidoCompra: tpeNfeToPedidoCompra;
    function fGerarPedidoCompra(pgbProgress: TcxProgressBar): Boolean;
    procedure pMarcaDesmarcaConferencia;
    function fDesfazerBaixaPedido(strPedidos, strCodEmp: String): Boolean;
  public
    class function fGeraPedidoCompra(AIncGerEle: String; OrigemNfeToPedidoCompra: tpeNfeToPedidoCompra): Boolean;
    class function fLibera(strAuxMensagem: string): Boolean;

  End;

  var
    NFEToPedidoCompra: TNFEToPedidoCompra;
implementation


class function TNFEToPedidoCompra.fLibera(strAuxMensagem: string): Boolean;
  var
    objLiberacao : TLiberacao;
begin
  objLiberacao := TLiberacao.create;

  Try
    objLiberacao.Clear;
    objLiberacao.strDirAce    := 'PDGXML';
    objLiberacao.strMsgSen    := 'Gerar Pedido de Compra pela Nota Fiscal Eletronica';
    objLiberacao.strCodOpe    := strLoginUsuarioLogado;
    objLiberacao.objMsgLibera.pAddTexto('Gerar Pedido de Compra pela Nota Fiscal Eletronica');
    objLiberacao.objMsgLibera.pAddTexto(strAuxMensagem);
    objLiberacao.objMsgLibera.pAddTexto('EMPRESA: ' + VS_StrCodEmp);

    Result := objLiberacao.fLibera;
  Finally
    FreeAndNil(objLiberacao);
  End;
end;

class function TNFEToPedidoCompra.fGeraPedidoCompra(AIncGerEle: String; OrigemNfeToPedidoCompra: tpeNfeToPedidoCompra): Boolean;
var
  strMensagem: String;
  strSQL, strMsgLiberacao: String;
  blnLiberado : Boolean;
  qryLiberacao: TUniQuery;
begin
  Result := False;

  blnLiberado := fVerificaAcessoSistema('PDGXML');
  If Not blnLiberado Then
  Begin
    If fCfgSis('GPNETA') = 'T' Then
    Begin
      try
        qryLiberacao := fCriaQuery;
        qryLiberacao.SQL.Add('SELECT B08_NNF AS NUMDOC, C03_XNOME AS RAZSOC, ');
        qryLiberacao.SQL.Add('IF(G.GER_TIP_FC = "C", G.GER_CODCLI, G.GER_CODFOR) AS CODFOR ');
        qryLiberacao.SQL.Add('FROM GERELE G WHERE AUTOINCREM = :AUTOINCREM');
        qryLiberacao.ParamByName('AUTOINCREM').AsString := AIncGerEle;
        qryLiberacao.Open;

        strMsgLiberacao := 'NOTA FISCAL: ' + qryLiberacao.FieldByName('NUMDOC').AsString + #13;
        strMsgLiberacao := strMsgLiberacao + 'FORNECEDOR: ' + qryLiberacao.FieldByName('CODFOR').AsString +
          ' - ' + qryLiberacao.FieldByName('RAZSOC').AsString;

        blnLiberado := fLibera(strMsgLiberacao);
      finally
        FreeAndNil(qryLiberacao);
      end;
    End;
  End;

  NFEToPedidoCompra := TNFEToPedidoCompra.Create;
  NFEToPedidoCompra.OrigemNfeToPedidoCompra := OrigemNfeToPedidoCompra;

  If blnLiberado  Then
  Begin
    Try
      strSQL := '';
      strSQL := strSQL + ' SELECT       ';
      strSQL := strSQL + '   G.AUTOINCREM,         ';
      strSQL := strSQL + '   B09_DEMI   AS DTAEMI, ';
      strSQL := strSQL + '   B07_SERIE  AS SERIE_, ';
      strSQL := strSQL + '   B08_NNF    AS NUMDOC, ';
      strSQL := strSQL + '   IFNULL(G.GER_CONPAG, "01000") AS GER_CONPAG, ';
      strSQL := strSQL + '   W07_VPROD + IFNULL(W18_VSERV, 0) - W10_VDESC AS VALDOC, ';
      strSQL := strSQL + '   IF(G.GER_TIP_FC = "C", G.GER_CODCLI, G.GER_CODFOR) AS CODFOR, ';
      strSQL := strSQL + '   G.GER_CODCLI, ';
      strSQL := strSQL + '   G.GER_CODFOR, ';
      strSQL := strSQL + '   C04_XFANT  AS NOMFAN, ';
      strSQL := strSQL + '   C03_XNOME  AS RAZSOC, ';
      strSQL := strSQL + '   IF(GER_DOCENT IS NULL, "N", "S") AS BAIXAD, ';
      strSQL := strSQL + '   IF(IFNULL(GER_TIPENT, "E") = "M", "S", "N") AS MANUAL, ';
      strSQL := strSQL + '   G.GER_CODEMP AS CODEMP, ';
      strSQL := strSQL + '   GER_CSTCAD AS CSTCAD, ';
      strSQL := strSQL + '   IFNULL(GER_CONDIR, "N") AS CONDIR, ';
      strSQL := strSQL + '   IFNULL(GER_ENTDIR, "N") AS ENTDIR, ';
      strSQL := strSQL + '   G.GER_TIP_FC, ';
      strSQL := strSQL + '   W08_VFRETE, ';
      strSQL := strSQL + '   W15_VOUTRO, ';
      strSQL := strSQL + '   W09_VSEG, ';
      strSQL := strSQL + '   PR07_CHNFE, ';
      strSQL := strSQL + '   X31_PESOL, ';
      strSQL := strSQL + '   X32_PESOB, ';
      strSQL := strSQL + '   X33_MODFRETE, ';
      strSQL := strSQL + '   X34_CNPJ, ';
      strSQL := strSQL + '   GER_DTALIB AS DTALIB, ';
      strSQL := strSQL + '   GER_DTACON AS DTACON, ';
      strSQL := strSQL + '   E02_CNPJ   AS C_G_C_, ';
      strSQL := strSQL + '   "XML_OK" AS STATUS,   ';
      strSQL := strSQL + '   GER_PEDCOM, ';
      strSQL := strSQL +     fSQLDescontoNotaXML + ' AS DESCONTO, ';
      strSQL := strSQL + '   GER_TIPXML,            ';
      strSQL := strSQL + '   IFNULL(G.GER_MATREV, F.FOR_MATREV) AS MATREV ';
      strSQL := strSQL + ' FROM                    ';
      strSQL := strSQL + '   GERELE G              ';
      strSQL := strSQL + '   INNER JOIN CADFOR F ON F.FOR_CODFOR = GER_CODFOR              ';
      strSQL := strSQL + ' WHERE G.AUTOINCREM = ' + QuotedStr(AIncGerEle);

      NFEToPedidoCompra.qryGerele := TZClient.Create(nil, strSQL);
      NFEToPedidoCompra.qryGerele.fAbreClient(False, 'TfrmEntImportaNotaElet.btnGerarPedidoCompraClick');

      strMensagem := '';
      If ((NFEToPedidoCompra.qryGerele.FieldByName('DTACON').AsDateTime <> 0) And (Not (fCfgSis('FLUPDC', varBoolean)))) Or
         ((NFEToPedidoCompra.qryGerele.FieldByName('DTACON').AsDateTime <> 0) And (fCfgSis('FLUPDC', varBoolean)) And (NFEToPedidoCompra.qryGerele.FieldByName('MATREV').AsString <> 'M')) Then
      Begin
        strMensagem := 'Essa nota já foi conferida!'
      End
      Else If NFEToPedidoCompra.qryGerele.FieldByName('CONDIR').AsString = 'S' Then
        strMensagem := 'Nota enviada diretamente para conferencia.'
      Else If NFEToPedidoCompra.qryGerele.FieldByName('DTALIB').AsString = 'S' Then
        strMensagem := 'Nota já liberada.'
      Else If NFEToPedidoCompra.qryGerele.FieldByName('BAIXAD').AsString = 'S' Then
        strMensagem := 'Nota já foi feita a entrada.'
      Else If (Not NFEToPedidoCompra.qryGerele.fieldByName('DTALIB').IsNull) And (NFEToPedidoCompra.qryGerele.fieldByName('CONDIR').AsString = 'N') Then
        strMensagem := 'Já existe uma pré-nota para esse documento!';

      If Not fEmptyStr(strMensagem) Then
      Begin
        pMensagemOk(strMensagem);
        exit(False);
      End;

      NFEToPedidoCompra.blnUniCom := False;

      pCriarFormularios(TfrmGravando, frmGravando);
      Try
        With frmGravando Do
        Begin
          lblGravando.Caption := 'Aguarde, preparando dados...';
          fExecutarAcao := NFEToPedidoCompra.fGerarPedidoCompra;
          ShowModal;
          Result := frmGravando.blnConfirma;
        end;
      Finally
        FreeAndNil(frmGravando);
      End

    Finally
      FreeAndNil(NFEToPedidoCompra.qryGerele);
    End;
  End
  Else
    pMensagemOk('Usuário sem acesso a este recurso.');

End;

function TNFEToPedidoCompra.fGerarPedidoCompra(pgbProgress: TcxProgressBar): Boolean;
  var
    qryDados : TZClient;
    qryComand: TUniQuery;
    objGeraOrc : TGeraOrc;
    item: TItem;
    intDecUni,
    intDecQua: Integer;
    strEmbala,
    strpedidos,
    strpedidosNaoEntregue,
    strLogLib,
    strDecQua: String;
    objPreNota: TPreNota;
    blnMaisDeUm: boolean;
    strNumPedGerados: String;
    strNumPedGeradosIn: String;
    qtdMaxOcorrencias: Integer;
    ItensOcorrencia: TStringList;
    strAutIncDet: String;
    i: integer;
    intOpcao: Integer;
    function fGetQtdOcorrencia(ACodIte: string): integer;
      var i: integer;
    Begin
      Result := 0;

      For i := 0 To  ItensOcorrencia.Count -1 do
      begin
        If ItensOcorrencia.Strings[i] = ACodIte then
          Inc(Result);
      End;
      If Result = 0 Then
        ItensOcorrencia.Add(ACodIte);
    End;
begin
  Result := True;
  strNumPedGeradosIn := '';
  qryDados   := TZClient.Create(nil, '');
  qryComand := fCriaQuery;
  intDecQua := fCfgSis('DEQTPC', varInteger);
  strDecQua := IntToStr(intDecQua);
  ItensOcorrencia := TStringList.Create;

  Try
    qryDados.qryQuery.SQl.Clear;
    qryDados.qryQuery.SQl.Add('SELECT GERELE.GER_CODEMP AS CODEMP,');
    qryDados.qryQuery.SQl.Add('       GER_CODFOR AS CODFOR,');
    qryDados.qryQuery.SQl.Add('       DET_CODITE AS CODITE,');
    qryDados.qryQuery.SQl.Add('       C.ITE_CODMAR AS CODMAR,');
    qryDados.qryQuery.SQl.Add('       C.ITE_CODUNI AS CODUNI,');
    qryDados.qryQuery.SQl.Add('       C.ITE_DESITE AS DESITE,');
    qryDados.qryQuery.SQl.Add('       O13_PIPI,');
    qryDados.qryQuery.SQl.Add('       O14_VIPI,');
    qryDados.qryQuery.SQl.Add('       N22_PICMSST,');
    qryDados.qryQuery.SQl.Add('       N23_VICMSST,');
    qryDados.qryQuery.SQl.Add('       N17B_PFCP,');
    qryDados.qryQuery.SQl.Add('       N17C_VFCP, ');
    qryDados.qryQuery.SQl.Add('       I15_VFRETE, ');
    qryDados.qryQuery.SQl.Add('       DETELE.AUTOINCREM AS DET_AUTINC, ');
    If Not blnUniCom Then
    Begin
      qryDados.qryQuery.SQl.Add('       I10A_VUNCOM AS VLRUNI,');
      qryDados.qryQuery.SQl.Add('       I10_QCOM AS QTDSUG,');
    End
    Else
    Begin

      strEmbala := fSQLEmbala('C', 'F', 'GER_CODFOR', True);
      qryDados.qryQuery.SQl.Add('   ROUND((I11_VPROD - ' + fSQLDescontoXML + ') / I10_QCOM, 4) / ' + strEmbala + ' AS VLRUNI,     ');
      qryDados.qryQuery.SQl.Add('   ROUND(ROUND(I10_QCOM , ' + strDecQua + ') *  ' + strEmbala + ' , ' + strDecQua + ') AS QTDSUG,     ');
    End;

    qryDados.qryQuery.SQl.Add('       CONCAT(LPAD(XPED,12,"0"), " - " , GER_CODEMP, " - PD") AS PEDIDO,');
    qryDados.qryQuery.SQl.Add('       IF(IFNULL(XPED, "") = "", 0, (SELECT COUNT(1) FROM PCMGER');
    qryDados.qryQuery.SQl.Add('                                      WHERE PCG_NUMPED = LPAD(XPED,12,"0")');
    qryDados.qryQuery.SQl.Add('                                        AND PCG_CODEMP = GER_CODEMP');
    qryDados.qryQuery.SQl.Add('                                        AND PCG_ESPDOC = "PD")) AS TEMPED');

    qryDados.qryQuery.SQl.Add(',LPAD(XPED,12,"0") AS XPED');
    qryDados.qryQuery.SQl.Add(',  IF(');
    qryDados.qryQuery.SQl.Add('    IFNULL(XPED, "") = "",');
    qryDados.qryQuery.SQl.Add('    0,');
    qryDados.qryQuery.SQl.Add('    (SELECT');
    qryDados.qryQuery.SQl.Add('      COUNT(1)');
    qryDados.qryQuery.SQl.Add('    FROM');
    qryDados.qryQuery.SQl.Add('      PCMGER');
    qryDados.qryQuery.SQl.Add('      INNER JOIN PCMDET');
    qryDados.qryQuery.SQl.Add('        ON PCD_NUMPED = PCG_NUMPED');
    qryDados.qryQuery.SQl.Add('        AND PCD_CODEMP = PCG_CODEMP');
    qryDados.qryQuery.SQl.Add('        AND PCD_ESPDOC = PCG_ESPDOC');
    qryDados.qryQuery.SQl.Add('    WHERE PCG_NUMPED = LPAD(XPED, 12, "0")');
    qryDados.qryQuery.SQl.Add('      AND PCG_CODEMP = GER_CODEMP');
    qryDados.qryQuery.SQl.Add('      AND PCG_ESPDOC = "PD" ');
    qryDados.qryQuery.SQl.Add('      AND PCG_BAIXAD = 1');
    qryDados.qryQuery.SQl.Add('      AND PCD_ENTREG = "N")');
    qryDados.qryQuery.SQl.Add('  ) AS NAOENTREGUE,');

    qryDados.qryQuery.SQl.Add(' 0 QTD_OCOORE');

    qryDados.qryQuery.SQl.Add('  FROM GERELE');
    qryDados.qryQuery.SQl.Add('  INNER JOIN DETELE ON DET_SEQGER = GERELE.AUTOINCREM');
    qryDados.qryQuery.SQl.Add('  INNER JOIN CADITE C ON ITE_CODITE = DET_CODITE');
    qryDados.qryQuery.SQl.Add('  LEFT JOIN ITEFOR F ON F.ITE_CODITE = C.ITE_CODITE AND ');
    qryDados.qryQuery.SQl.Add('                        F.ITE_CODFOR =   GER_CODFOR     ');

    If fCfgSis('TABPRF', varBoolean) Then
    Begin
      qryDados.qryQuery.SQl.Add('   AND (SELECT COUNT(*) FROM TABPRE     ');
      qryDados.qryQuery.SQl.Add('       WHERE F.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S" ) > 0 ');
    End Else
    Begin
      qryDados.qryQuery.SQl.Add('  AND F.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF  ');
      qryDados.qryQuery.SQl.Add('                       WHERE FF.ITE_CODITE = C.ITE_CODITE AND   ');
      qryDados.qryQuery.SQl.Add('                             FF.ITE_CODFOR = GER_CODFOR)        ');
    End;

    qryDados.qryQuery.SQl.Add(' WHERE GERELE.AUTOINCREM = "' + qryGerele.fieldByName('AUTOINCREM').AsString + '"');
    qryDados.fAbreClient(False, 'TNFEToPedidoCompra.fGerarPedidoCompra');

    If qryDados.IsEmpty Then
      Exit;

    strpedidos := '';
    strpedidosNaoEntregue := '';
    strNumPedGerados := '';
    while not qryDados.Eof Do
    begin
      If qryDados.FieldByName('TEMPED').AsInteger > 0 Then
        If Not (Pos(qryDados.FieldByName('PEDIDO').AsString, strPedidos) > 0) Then
          strpedidos := strpedidos + qryDados.FieldByName('PEDIDO').AsString + #$A#$D;
      If qryDados.FieldByName('NAOENTREGUE').AsInteger > 0 Then
        If Pos(qryDados.FieldByName('XPED').AsString, strpedidosNaoEntregue) <= 0 Then
          strpedidosNaoEntregue := strpedidosNaoEntregue + qryDados.FieldByName('XPED').AsString + ',';
      qryDados.Next;
    End;

    If Not fEmptyStr(strpedidos) Then
    Begin
      pMensagemOk('O(s) Pedido(s) informado(s) na tag <xPed> já existem. ' + strpedidos);
      Exit;
    End;

    If (fCfgSis('CNVEMB') = 'S') Then
    Begin
      intOpcao  := fMensagem('', 'A Nota está em unidade de: ', ['&Compra', '&Venda'], 1, True);
      NFEToPedidoCompra.blnUniCom := intOpcao = 1;

      If (NFEToPedidoCompra.blnUniCom) Or (intOpcao > 0) Then
        NFEToPedidoCompra.pMarcaDesmarcaConferencia;
    End;

    If Not fEmptyStr(strpedidosNaoEntregue) Then
    Begin
      If fMensagem('Aviso!', 'O(S) PEDIDO(S) DE COMPRA: ' + strpedidosNaoEntregue + ' JÁ ESTÁ(ÃO BAIXADO(S) COMO "NÃO SERÁ ENTREGUE".' +
          ' DESEJA RESTAURAR O(S) PEDIDO(S) DE COMPRA PARA QUE O MESMO SEJA VINCULADO?',  ['&Sim', '&Não'], 1) = 1 Then
      Begin
        fDesfazerBaixaPedido(strpedidosNaoEntregue,
        qryDados.FieldByName('CODEMP').AsString);
        strPedidos := '';
        strNumPedGerados := strNumPedGerados + IIf(strNumPedGerados = '', '', ',') + strpedidosNaoEntregue.Replace(',',#$A#$D);
      end
      Else
        strpedidosNaoEntregue := '';
    End;

    If High(strpedidosNaoEntregue.Split([','])) > 0 Then
    Begin
      pMensagemOk('Restauraçao dos pedidos realizado com sucesso! Será necessário realizar a pré-nota dos pedidos ' + strpedidosNaoEntregue + ' acessando o menu');
      Exit;
    End;

    If fEmptyStr(strpedidosNaoEntregue) Then
    Begin
      pgbProgress.Position := 0;
      pgbProgress.Properties.Max := qryDados.RecordCount;
      Application.ProcessMessages;
      intDecUni := fCfgSis('DECUNI');
      qryDados.First;
      qtdMaxOcorrencias := 0;
      while not qryDados.Eof Do
      begin
        qryDados.Edit;
        qryDados.FieldByName('QTD_OCOORE').AsInteger := (fGetQtdOcorrencia(qryDados.FieldByName('CODITE').AsString) + 1);
        If qtdMaxOcorrencias <  qryDados.FieldByName('QTD_OCOORE').AsInteger Then
          qtdMaxOcorrencias := qryDados.FieldByName('QTD_OCOORE').AsInteger;
        qryDados.Post;
        qryDados.Next;
      End;

      strAutIncDet := '';
      For i := 1 To  qtdMaxOcorrencias do
      begin
        objGeraOrc := TGeraOrc.Create;
        Try
          qryDados.Filtered := False;
          qryDados.Filter :=  'QTD_OCOORE = ' + i.Tostring;
          qryDados.Filtered := True;

          qryDados.First;
          strAutIncDet := '';
          While Not qryDados.Eof Do
          Begin
            item.strCodEmp := qryDados.FieldByName('CODEMP').AsString;
            item.strCodFor := qryDados.FieldByName('CODFOR').AsString;
            item.strCodIte := qryDados.FieldByName('CODITE').AsString;
            item.strCodMar := qryDados.FieldByName('CODMAR').AsString;
            item.strCodUni := qryDados.FieldByName('CODUNI').AsString;
            item.strDesIte := qryDados.FieldByName('DESITE').AsString;

            item.fltPerIpi := qryDados.FieldByName('O13_PIPI').AsFloat;
            item.fltValIpi := qryDados.FieldByName('O14_VIPI').AsFloat;
            item.fltPerSub := qryDados.FieldByName('N22_PICMSST').AsFloat;
            item.fltTotSub := qryDados.FieldByName('N23_VICMSST').AsFloat;
            item.fltPerFCP := qryDados.FieldByName('N17B_PFCP').AsFloat;
            item.fltSubFCP := qryDados.FieldByName('N17C_VFCP').AsFloat;
            item.fltValFre := qryDados.FieldByName('I15_VFRETE').AsFloat;

            item.fltPreCus := fFormataFloatInterna(qryDados.FieldByName('VLRUNI').AsFloat, intDecUni);

            item.fltQtdIte := qryDados.FieldByName('QTDSUG').AsFloat;

            item.fltEmbala := 1;

            objGeraOrc.pAddItem(item, 0);

            pgbProgress.Position :=  pgbProgress.Position + 1;
            Application.ProcessMessages;

            qryDados.Next;
            strAutIncDet := strAutIncDet + IIf(strAutIncDet <> '', ',', '') + '"' + qryDados.FieldByName('DET_AUTINC').AsString + '"';
          End;

          If Assigned(frmGravando) Then
          Begin
            frmGravando.lblGravando.Caption := 'Aguarde, gerando pedido de compra...';
            Application.ProcessMessages;
          End;

          objGeraOrc.pgbProgress := pgbProgress;
          objGeraOrc.strCndPagDefExterno := qryGerele.FieldByName('GER_CONPAG').AsString;
          objGeraOrc.strTipFre    := TPreNota.fTraduzFrete(qryGerele.FieldByName('X33_MODFRETE').ASString);
          objGeraOrc.blnCalculoIPI_ST_Externo := True;
          objGeraOrc.fltValFre := qryGerele.FieldByName('W08_VFRETE').AsFloat;
          objGeraOrc.strCodTra := fCodTransportadoraPeloCnpj(qryGerele.FieldByName('X34_CNPJ').AsString);

          fStartTransaction();
          Try
            If OrigemNfeToPedidoCompra = ImpNotaEletronica Then
              objGeraOrc.pGerarOrcamentos(True, 'GERADO PELA IMPORTAÇÃO DE NOTA FISCAL ELETRÔNICA', True, strLoginUsuarioLogado)
            Else If OrigemNfeToPedidoCompra = FluxoCompras Then
              objGeraOrc.pGerarOrcamentos(True, 'GERADO PELO FLUXO DE COMPRAS', True, strLoginUsuarioLogado);

            { Libera o Pedido de Compra }
            If objGeraOrc.intQtdOrcamentoGerado > 0 Then
            Begin
              qryComand.SQL.Clear;
              qryComand.SQL.Add('UPDATE');
              qryComand.SQL.Add('    PCMGER                    ');
              qryComand.SQL.Add('  SET                         ');
              qryComand.SQL.Add('    PCG_PEDLIB = :PEDLIB      ');
              qryComand.SQL.Add('  WHERE                       ');
              qryComand.SQL.Add('    PCG_NUMPED = :NUMPED AND  ');
              qryComand.SQL.Add('    PCG_CODEMP = :CODEMP AND  ');
              qryComand.SQL.Add('    PCG_ESPDOC = "PD"         ');
              fCommit;
            End
            Else
            Begin
              fRollBack();
              fMensagem('', 'Nenhum orçamento gerado!', ['&Ok']);
              Exit;
            End;
          Except
            On E: Exception Do
            begin
              fRollBack();
              pMensagensErro(E.Message, 'TNFEToPedidoCompra.fGerarPedidoCompra');
              Exit;
            End;
          End;

          strLogLib := strLoginUsuarioLogado + FormatDateTime('ddmmyyyy', VS_Date) + FormatDateTime('hhmmss', fTime());
          qryComand.ParamByName('PEDLIB').AsString := strLogLib;
          qryComand.ParamByName('NUMPED').AsString := AnsiReplaceStr(objGeraOrc.strNumPedGerados, #$A#$D, '') ;
          qryComand.ParamByName('CODEMP').AsString := VS_StrCodEmp;

          pEstornaSaldoPedidoCompra(AnsiReplaceStr(objGeraOrc.strNumPedGerados, #$A#$D, ''), 'PD', VS_StrCodEmp);

          qryComand.ExecSQL;

          pAtualizaSaldoPedidoCompra(AnsiReplaceStr(objGeraOrc.strNumPedGerados, #$A#$D, ''), 'PD', VS_StrCodEmp);

          qryComand.ParamByName('CODEMP').AsString := VS_StrCodEmp;
          strNumPedGerados := strNumPedGerados + IIf(strNumPedGerados = '', '', ',') + objGeraOrc.strNumPedGerados;

          qryComand.SQL.Clear;
          qryComand.SQL.Add('UPDATE GERELE SET GER_PEDCOM  = CONCAT(IFNULL(GER_PEDCOM,""), IF(IFNULL(GER_PEDCOM,"") = "", "", ","),') ;
          qryComand.SQL.Add(' IFNULL((SELECT PCMGER.AUTOINCREM');
          qryComand.SQL.Add('    FROM PCMGER');
          qryComand.SQL.Add('   WHERE PCG_NUMPED = :NUMPED');
          qryComand.SQL.Add('     AND PCG_CODEMP = :CODEMP');
          qryComand.SQL.Add('     AND PCG_ESPDOC = "PD"), ""))');
          qryComand.SQL.Add(' WHERE AUTOINCREM = "' + qryGerele.fieldByName('AUTOINCREM').AsString +'"');
          qryComand.ParamByName('NUMPED').AsString := AnsiReplaceStr(objGeraOrc.strNumPedGerados, #$A#$D, '') ;
          qryComand.ParamByName('CODEMP').AsString := VS_StrCodEmp;
          qryComand.ExecSQL;

          qryComand.SQL.Clear;
          //Atualiza XPED Com o novo pedido
          strNumPedGeradosIn := strNumPedGeradosIn + IIf(strNumPedGeradosIn <> '' , ',', '') + '"' + AnsiReplaceStr(objGeraOrc.strNumPedGerados, #$A#$D, '') + '"';
          qryComand.SQL.Add('UPDATE DETELE SET XPED = "' + AnsiReplaceStr(objGeraOrc.strNumPedGerados, #$A#$D, '') + '"');
          qryComand.SQL.Add(' WHERE DET_SEQGER = "' + qryGerele.fieldByName('AUTOINCREM').AsString +'"');
          If strAutIncDet <> '' Then
            qryComand.SQL.Add(' AND AUTOINCREM IN ('+strAutIncDet+')');
          qryComand.ExecSQL;

        Finally
          FreeAndNil(objGeraOrc);
        End;
      End;
    End;

    If strNumPedGerados <> '' Then
    Begin
      fMensagem('', 'Pedido de Compra gerado '+ strNumPedGerados, ['&Ok']);

      //Se não usa pré-nota, Finaliza.
      If (Not (fCfgSis('USACON', varBoolean))) Then
        Exit(True);
    End;

    frmGravando.lblGravando.Caption := 'Aguarde, gerando Pré-Nota ...';
    { Gera a pré-nota }

    objPreNota := TPreNota.Create(nil);

    //objPreNota.fCarregaPedidosNotaEletronica(cdsConsulta.fieldByName('AUTOINCREM').AsString);

    qryComand.SQL.Clear;

    with objPreNota Do
    Begin
      recNotEle.strAutInc := qryGerele.FieldByName('AUTOINCREM').AsString;
      recNotEle.strCodFor := qryGerele.FieldByName('GER_CODFOR').AsString;
      recNotEle.strCodCli := qryGerele.FieldByName('GER_CODCLI').AsString;
      recNotEle.strTip_FC := qryGerele.FieldByName('GER_TIP_FC').AsString;
      recNotEle.strNumDoc := qryGerele.FieldByName('NUMDOC').AsString;
      recNotEle.strSerDoc := qryGerele.FieldByName('SERIE_').AsString;
      recNotEle.fltValFre := qryGerele.FieldByName('W08_VFRETE').AsFloat;
      recNotEle.fltValDes := qryGerele.FieldByName('DESCONTO').AsFloat;
      recNotEle.fltOutras := qryGerele.FieldByName('W15_VOUTRO').AsFloat;
      recNotEle.fltValSeg := qryGerele.FieldByName('W09_VSEG').AsFloat;
      recNotEle.strTipFre := TPreNota.fTraduzFrete(qryGerele.FieldByName('X33_MODFRETE').ASString);

      recNotEle.dtaDtaDoc := qryGerele.FieldByName('DTAEMI').AsDateTime;
      recNotEle.str_Chave := qryGerele.FieldByName('PR07_CHNFE').AsString;
      recNotEle.fltPesLiq := qryGerele.FieldByName('X31_PESOL').AsFloat;
      recNotEle.fltPesBru := qryGerele.FieldByName('X32_PESOB').AsFloat;
      recNotEle.strConPag := qryGerele.FieldByName('GER_CONPAG').AsString;
      If recNotEle.strConPag = '' Then
        recNotEle.strConPag := '01000';
      recNotEle.strModFre := qryGerele.FieldByName('X33_MODFRETE').AsString;

      recNotEle.strNotas  := qryGerele.FieldByName('NUMDOC').AsString + ' - ' +
                             qryGerele.FieldByName('CODFOR').AsString + '-' +
                             fRetNomFornecedor(qryGerele.FieldByName('CODFOR').AsString);

      recNotEle.finalidadeXML := tpeFinalidadeXML(qryGerele.FieldByName('GER_TIPXML').AsInteger);
    End;

    blnMaisDeUm := False;


    objPreNota.pCarregaListPedidos(strNumPedGeradosIn);

    objPreNota.fValidaPedido('',
                             blnUniCom,
                             False,
                             True,
                             blnMaisDeUm);

    objPreNota.blnPedidoGeradoAuto  := True;

    If Not objPreNota.fConfirma Then
    Begin
      objPreNota.pClose(True);
      pMensagemOk('Falha ao gerar Pré-Nota');
      Result := False;
    End
    Else
    Begin
      Result := True;
    End;

  Finally
    If Assigned(objPreNota) Then
      FreeAndNil(objPreNota);
    FreeAndNil(qryDados);
    FreeAndNil(qryComand);
    FreeAndNil(ItensOcorrencia);
  end;
end;

procedure TNFEToPedidoCompra.pMarcaDesmarcaConferencia;
  Var
    qryGereleUpdate: TUniQuery;
    intRecno: Integer;
Begin
  Try
    qryGereleUpdate := fCriaQuery;

    With qryGereleUpdate, SQL Do
    Begin
      Add('UPDATE GERELE SET ');
      Add('  GER_DTALIB = :DTALIB,');
      Add('  GER_HORLIB = :HORLIB,');
      Add('  GER_OPELIB = :OPELIB,');
      Add('  GER_UNICOM = :UNICOM,');
      Add('  GER_CONDIR = :CONDIR ');

      Add('WHERE AUTOINCREM = :AUTINC');

      If qryGerele.fieldByName('CONDIR').AsString = 'S' Then
      Begin
        ParamByName('CONDIR').AsString := 'N';

        ParamByName('DTALIB').Clear;
        ParamByName('HORLIB').Clear;
        ParamByName('OPELIB').Clear;
       End Else
      Begin
        ParamByName('CONDIR').AsString := 'S';

        ParamByName('DTALIB').AsDate   := VS_Date;
        ParamByName('HORLIB').AsTime   := fTime();
        ParamByName('OPELIB').AsString := strLoginUsuarioLogado;
      End;

      If blnUniCom Then
        ParamByName('UNICOM').AsString := 'S'
      Else
        ParamByName('UNICOM').AsString := 'N';

      ParamByName('AUTINC').AsString := qryGerele.fieldByName('AUTOINCREM').AsString;

      ExecSQL;
    End;

    FreeAndNil(qryGereleUpdate);

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TNFEToPedidoCompra.pMarcaDesmarcaConferencia]');
      Exit;
    End;

  End;

  intRecno := qryGerele.Recno;
  With qryGerele Do
  Begin
    Edit;

     If FieldByName('CONDIR').AsString = 'S' Then
       FieldByName('CONDIR').AsString := 'N'
     Else
       FieldByName('CONDIR').AsString := 'S';

    Post;
  End;
  qryGerele.Recno := intRecno;

  pMensagemOk('Opção de conferência atualizada com sucesso!');
End;

function TNFEToPedidoCompra.fDesfazerBaixaPedido(strPedidos, strCodEmp: String): Boolean;
Var
  arrPedidos: TArray<String>;
  intContador: Integer;
Begin
  Result := False;
  Try
    arrPedidos := strPedidos.Split([',']);
    For intContador := Low(arrPedidos) To High(arrPedidos) Do
    Begin
      fDesfazerBaixaPedidoNaoEntregue(
        arrPedidos[intContador]
        ,'PD'
        ,strCodEmp
        ,false);
    End;
    Result := True;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[fDesfazerBaixaPedido]');
  End;
End;





end.

