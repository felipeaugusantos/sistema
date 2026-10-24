unit untRequisicaoPedidoCompra;

interface

Uses
  DB,
  SysUtils,
  StrUtils,
  Classes,
  Controls,
  CxProgressBar,
  untFuncoesPedidoSimples,
  untFuncoesSimples,
  Uni, UniClientDataSet,
  untRecuperaPedido,
  untZClient,
  untTLock, 
  untMsgLiberacao,
  untLiberacaoFactory,
  Core.Funcoes;

Type
  TtpoOperacao = (tpoCotacao, tpoPedidoCompra, tpoPainel);

  TItemNotificacaoReqNegada = Record
    codReq,
    DtCadastro,
    cliente,
    item,
    referencia,
    qtdeReq,
    Motivo,
    codEmp: String;
  End;

  TArrItensNotificacaoReqNegada = array of TItemNotificacaoReqNegada;

  TNotificacaoReqNegada = record
    strCodCmp:String;
    strCodVen: String;
    index: integer;
    ArrItensNotificacaoReqNegada: TArrItensNotificacaoReqNegada;
    procedure AddItem(ItemNotificacaoReqNegada: TItemNotificacaoReqNegada);
    procedure pEnviaNotificacao;
  End;


  TArrNotificacaoReqNegada = array of TNotificacaoReqNegada;

  TGerenciaNotificacaoReqNegada = class
    ArrNotificacaoReqNegada: TArrNotificacaoReqNegada;
    procedure pAdicionaItem(ACodDestinatario: String; ACodVen: String; AItensNotificacaoReqNegada: TItemNotificacaoReqNegada);
    function fLocalizaDestinatario(ACodDestinatario: String): integer;
    procedure pEnviaNotificacoes;
  End;

  TRequisicaoPedidoCompra = Class
  private
    FNomeForm: String;
    FFiltrosGiro: String;

    FRecPed: TRecuperaPedido;

    FItensJaPesquisados: TStringList;

    FItensDesmarcados: TStringList;

    qryJaTemPedido,
    qryBuscaPedido,
    qryUpdate: TUniQuery;

    objGerenciaNotificacaoReqNegada: TGerenciaNotificacaoReqNegada;

    cdsSaldos: TZClient;

    Function fCarregaSaldos(cxgProgresso: TcxProgressBar): Boolean;

    Function fSetarPedidoDeCompra(strCodEmp, strNumPed, strEspDoc, strFiltrosGiro: String; objRecPed: TRecuperaPedido; recOpcGir: TRecOpcoesGiro): Boolean;

    Function fSQLPedidosDisponiveis: String;

    Function fCriaPedidosDisponiveis: Boolean;

    Procedure pCarregaSaldos;

    Procedure pGeraOcorrenciaDesvinculo(strPedVen, strEspVen, strEmpVen, strMensagem: String);
    function fProcessaDesmarcados(strAutIncPedidoCompra: String): Boolean;

    function fVendaNaoFaturada: Boolean;
    procedure pPedeSenhaLiberarTravaSemAdtBol;
  public
    strAutPedCom: String;

    strEmpSaldos: String;

    strCodCmp: String;

    qryColeta: TUniQuery;

    strDocOri: String;

    blnRQPDBA,
    blnConCol,
    blnUsarGiro,
    blnAlterouDados: Boolean;

    tpoOperacao: TtpoOperacao;

    cdsRequisicao: TZClient;

    cdsPedidosDisponiveis: TZClient;

    strCodItens: string;
    FProcIniciaCotacao : TProcIniciaCotacao;
    FProcIniciaPedComp : TProcIniciaPedComp;

    cdsItensPedido: TUniClientDataSet;

    recOpcGir: TRecOpcoesGiro;

    FstrNumPed: String;
    FstrEspDoc: String;
    FstrCodEmp: String;

    Constructor Create();
    Destructor Destroy; override;

    Function fPedeSenhaLiberarTrava: Boolean;
    function fTemVendaNaoFaturada: Boolean;

    Procedure pAssociaPedidoCompraRequisicoes;

    Class Function fRetChaveSelecao(strAutInc: String): String;

    Function fPodeSelecionarPedidoDisponivel: Boolean;

    Function fAlteradaEmOutraEstacao(strAutInc: String; blnDarMsgErro: Boolean): Boolean;

    Function fCarregaPedidosDisponiveis(strCodIte: String): Boolean;

    function fSelecionarRequisicoes(strCodEmp, strNumPed, strEspDoc, strCodIte: String;
                                    objRecPed: TRecuperaPedido;
                                    blnUsarGiro: Boolean;
                                    recOpcGir: TRecOpcoesGiro;
                                    blnShowForm: boolean = True;
                                    blnImportarTodos: Boolean = False;
                                    blnCarregandoPedido: Boolean = False): boolean;
    procedure pCarregaPainelRequisicoes;
    procedure Confirmar;
    procedure RecarregarRequisicoes;
    procedure ProcessaStatusPedidoRequisicaoRCD(strSeqRCD: String);

    function fAtualizarVinculoRequisicoes(blnPedMul: Boolean; strAutIncPedidoCompra: string; blnDeletarVinculo: Boolean = False): Boolean;

    Procedure pLimpaPCMIRQ(strRequisicoes: String);

    Function fDesmarcaPedidoDisponivel: Boolean;

    Function fSelecionaPedidoDisponivel: Boolean;

    Function fPossuiColeta(strCodIte: String): Boolean;

    Function fPodeMarcarDesmarcarRequisicao(blnDarMsgErro, blnTestarNegada: Boolean): Boolean;

    // Desmarca as requisicoes vinculadas ao item
    procedure pDesmarcaItem(strLisReq: string);

    // Desmarca a requisição corrente
    procedure pDesmarcaRequisicao;

    procedure pAdicionarItemDesmarcado;

    Function fAssociaPedidoCompra: Boolean;

    Function fRetiraVinculoItem(strLisReq, strIncMovRcd: String; Var blnAchou: Boolean): String;

    Function fNegaRequisicoesMotivoNaoVaiComprar(cdsRequisicao: TZClient; blnComTransacao: Boolean = True): Boolean;
    procedure GravarDEL_MOVRCD(AAutInc: String);
    procedure GravarDEL_MOVRCG(AStrCodReq: String);
    Function fNegaRequisicoesMotivoPossuiEstoque(cdsRequisicao: TZClient; blnComTransacao: Boolean = True): Boolean;

    Function fCarregaRequisicoes(strSeqGer: String; recOpcGir: TRecOpcoesGiro): Boolean;

    Function fConfirmaNegarRequisicoesSemPedidoVenda(Var blnCancelar: Boolean): Boolean;

    Class Function fRetQuantidadeRequisicaoPedido(strCodIte, strEmpresas: String): Double;

    procedure pMarcaTodos(intMarcado: Integer);

    Procedure pMostraPedidosDisponiveis;

    Procedure pFormataDisponiveis;

    Procedure pFormataCdsRequisicao;

    Class Procedure pCarregaRequisicoesPedido(qryDados: TUniQuery; strLisPed: String);

    Class Function fTravaRequisicoes(strAutInc: String; objLock: TLock): Boolean;

    Procedure pGeraOcorrenciasDesvinculo;

    Property  stlItensJaPesquisados: TStringList Read FItensJaPesquisados Write FItensJaPesquisados;
  End;

implementation

Uses
  Forms,
  cxFilter,
  untConstantes,
  untGravando,
  untMsgInterna,
  untCadCotItensImpRequisicao,
  untSaldoPedidoCompra,
  untMostraRequisicoes,
  untFuncoesConsulta,
  untSelPedidoRequisicao, 
  untAtualizaOcorrenciasCRM, 
  untTypesCRM,
  untILiberacao,
  Variants, untTSituacaoPedidoVenda;

{ TRequisicaoPedidoCompra }

procedure TRequisicaoPedidoCompra.Confirmar;
begin
  Self.fNegaRequisicoesMotivoNaoVaiComprar(cdsRequisicao, False);
  Self.fNegaRequisicoesMotivoPossuiEstoque(cdsRequisicao, False);

  Self.cdsRequisicao.First;
  While not Self.cdsRequisicao.Eof Do
  Begin
    If Self.cdsRequisicao.FieldByName('AUTDET_CONF').AsString <> Self.cdsRequisicao.FieldByName('AUTDET').AsString Then
    Begin
      Self.cdsRequisicao.Edit;
      Self.cdsRequisicao.FieldByName('AUTDET_CONF').Value := Self.cdsRequisicao.FieldByName('AUTDET').Value;
      Self.cdsRequisicao.Post;
    End;
    Self.cdsRequisicao.Next;
  End;

  Self.pAssociaPedidoCompraRequisicoes;

end;

constructor TRequisicaoPedidoCompra.Create();
begin
  strDocOri    := '';
  strAutPedCom := '';

  qryColeta := Nil;
  objGerenciaNotificacaoReqNegada := TGerenciaNotificacaoReqNegada.Create;
  blnRQPDBA := fCfgSis('RQPDBA', VarBoolean);
  blnConCol := fCfgSis('CONCOL', VarBoolean);

  cdsSaldos := TZClient.Create(Nil);

  qryJaTemPedido := fCriaQuery;
  qryJaTemPedido.SQL.Text := 'SELECT RCD_SEQPCD, RCD_ATETRA, RCD_REQNEG FROM MOVRCD WHERE AUTOINCREM = :AUTINC';

  qryBuscaPedido := fCriaQuery;
  qryBuscaPedido.SQL.Text := 'SELECT CONCAT(PCD_NUMPED, "-", PCD_CODEMP) AS NUMPED FROM PCMDET WHERE AUTOINCREM = :AUTINC';

  Fillchar(recOpcGir, SizeOf(recOpcGir), #0);
  blnUsarGiro := False;

  tpoOperacao := tpoCotacao;

  blnAlterouDados := False;

  strCodItens := '';

  FRecPed := Nil;

  cdsRequisicao := TZClient.Create(Nil);

  cdsItensPedido := Nil;

  qryUpdate:= fCriaQuery;

  FItensDesmarcados := TStringList.Create;
  FItensDesmarcados.Sorted := True;
  FItensDesmarcados.Duplicates := dupIgnore;

  FItensJaPesquisados := TStringList.Create;
  FItensJaPesquisados.Sorted := True;
  FItensJaPesquisados.Duplicates := dupIgnore;

  fCriaPedidosDisponiveis;
end;

destructor TRequisicaoPedidoCompra.Destroy;
begin
  FreeAndNil(cdsRequisicao);
  FreeAndNil(qryUpdate);
  FreeAndNil(FItensJaPesquisados);
  FreeAndNil(FItensDesmarcados);
  FreeAndNil(cdsSaldos);
  FreeAndNil(qryJaTemPedido);
  FreeAndNil(qryBuscaPedido);
  FreeAndNil(objGerenciaNotificacaoReqNegada);

  If Assigned(cdsPedidosDisponiveis) Then
    FreeAndNil(cdsPedidosDisponiveis);
end;

Procedure TRequisicaoPedidoCompra.pLimpaPCMIRQ(strRequisicoes: String);
  Var
    qryDados,
    qryDelete: TUniQuery;
Begin
  If strRequisicoes.IsEmpty Then
    Exit;

  qryDelete := fCriaQuery;
  qryDelete.SQL.Text := 'DELETE FROM PCMIRQ WHERE PCM_SEQDET = :SEQDET AND PCM_SEQREQ = :SEQREQ';

  qryDados := fCriaQuery;
  qryDados.SQL.Text := 'SELECT P.* FROM MOVRCD M ' +
                       'INNER JOIN PCMIRQ P ON P.PCM_SEQREQ = M.AUTOINCREM ' +
                       'WHERE M.AUTOINCREM IN (' + strRequisicoes + ' ) AND RCD_SEQPCD IS NULL';
  qryDados.Open;

  While Not qryDados.Eof Do
  Begin
    qryDelete.Close;
    qryDelete.ParamByName('SEQDET').AsString := qryDados.FieldByName('PCM_SEQDET').AsString;
    qryDelete.ParamByName('SEQREQ').AsString := qryDados.FieldByName('PCM_SEQREQ').AsString;
    qryDelete.Execute;

    qryDados.Next;
  End;

  FreeAndNil(qryDados);
  FreeAndNil(qryDelete);
End;

function TRequisicaoPedidoCompra.fAtualizarVinculoRequisicoes(blnPedMul: Boolean;
                                                              strAutIncPedidoCompra: string;
                                                              blnDeletarVinculo: Boolean = False): Boolean;
  Var
    strRequisicoes: string;
    qryUpdateEmpDes: TUniQuery;
    idxItem: Integer;

  procedure pSetSQL(blnDesvincularPedido: Boolean = False);
  Begin
    qryUpdate.Close;
    qryUpdate.SQL.Clear;
    qryUpdate.Sql.Add('  UPDATE MOVRCD');
    qryUpdate.Sql.Add('   INNER JOIN PCMGER ON PCMGER.AUTOINCREM = :AUTPCG');
    qryUpdate.Sql.Add('   INNER JOIN PCMDET ON PCD_CODITE = RCD_CODITE');
    qryUpdate.Sql.Add('                    AND PCD_NUMPED = PCMGER.PCG_NUMPED');
    qryUpdate.Sql.Add('                    AND PCD_CODEMP = PCMGER.PCG_CODEMP');
    qryUpdate.Sql.Add('                    AND PCD_ESPDOC = PCMGER.PCG_ESPDOC');

    If blnDesvincularPedido Then
    Begin
      qryUpdate.Sql.Add('                  AND PCMDET.AUTOINCREM = RCD_SEQPCD ');
      qryUpdate.Sql.Add('     SET RCD_SEQPCD  = NULL, ');
      qryUpdate.Sql.Add('         RCD_EMPDES  = NULL  ');
    End
    Else
      qryUpdate.Sql.Add('     SET RCD_SEQPCD = IF(RCD_ATETRA = 1, NULL, PCMDET.AUTOINCREM) ');

    If Not blnDesvincularPedido Then
    Begin
      qryUpdate.Sql.Add('   WHERE  ');
      qryUpdate.SQL.Add('         MOVRCD.AUTOINCREM IN (' + strRequisicoes + ' ) ');
      qryUpdate.Sql.Add('     AND IFNULL(RCD_SEQCOT, "") = ""');
      qryUpdate.Sql.Add('     AND IFNULL(RCD_SEQPCD, "") = ""');
    End;

    qryUpdate.ParamByName('AUTPCG').AsString := strAutIncPedidoCompra;
  End;

begin
  If (Not Assigned(cdsRequisicao)) Then
  begin
    Result := True;
    Exit;
  End;

  If (Not cdsRequisicao.Active) Then
  begin
    Result := True;
    Exit;
  End;

  If blnDeletarVinculo Then
  Begin
     pSetSQL(True);
     qryUpdate.ExecSQL;
  End
  Else
  Begin
    qryUpdateEmpDes := fCriaQuery;
    qryUpdateEmpDes.SQL.Text := 'UPDATE MOVRCD SET RCD_EMPDES = :EMPDES WHERE AUTOINCREM = :AUTINC';

    cdsRequisicao.Filter := 'MARDES = 1';
    cdsRequisicao.Filtered := True;
    cdsRequisicao.First;
    If Not cdsRequisicao.IsEmpty Then
    Begin
      strRequisicoes := '';

      While Not cdsRequisicao.Eof Do
      Begin
        strRequisicoes :=  strRequisicoes + '"' + cdsRequisicao.FieldByname('AUTOINCREM').AsString + '",';

        If blnPedMul And (Not fEmptyStr(cdsRequisicao.FieldByname('EMPDES').AsString)) Then
        Begin
          qryUpdateEmpDes.Close;
          qryUpdateEmpDes.ParamByName('EMPDES').AsString := cdsRequisicao.FieldByname('EMPDES').AsString;
          qryUpdateEmpDes.ParamByName('AUTINC').AsString := cdsRequisicao.FieldByname('AUTOINCREM').AsString;
          qryUpdateEmpDes.ExecSQL;
        End;

        idxItem := FItensDesmarcados.IndexOf(cdsRequisicao.FieldByname('AUTOINCREM').AsString);
        If idxItem > -1 Then
          FItensDesmarcados.Delete(idxItem);

        cdsRequisicao.Next;
      End;
      strRequisicoes := LeftStr(strRequisicoes, Length(strRequisicoes) -1);
      pSetSQL;
      qryUpdate.ExecSQL;

      FreeAndNil(qryUpdateEmpDes);

      pLimpaPCMIRQ(strRequisicoes);
    End;
  End;

  Result := fProcessaDesmarcados(strAutIncPedidoCompra);
end;

procedure TRequisicaoPedidoCompra.pAdicionarItemDesmarcado;
begin
  FItensDesmarcados.Add(cdsRequisicao.FieldByName('AUTOINCREM').AsString);
end;

function TRequisicaoPedidoCompra.fProcessaDesmarcados(strAutIncPedidoCompra: String): Boolean;
  function fListaToSql:String;
  var
    I:Integer;
  begin
    for I:=0 To FItensDesmarcados.Count-1 Do
    begin
      Result :=  Result + '"' + FItensDesmarcados[I] + '",';
    end;
    Result := LeftStr(Result, Length(Result) -1);
  end;
var
  qryUpdate: TUniQuery;
begin
  If Not (tpoOperacao = tpoPedidoCompra) then
    Exit(True);

  If FItensDesmarcados.Count = 0 Then
    Exit(True);

  Try
    Try
      qryUpdate := fCriaQuery;
      qryUpdate.SQL.Clear;
      qryUpdate.Sql.Add('  UPDATE MOVRCD                                         ');
      qryUpdate.Sql.Add('   INNER JOIN PCMGER ON PCMGER.AUTOINCREM = :AUTPCG     ');
      qryUpdate.Sql.Add('   INNER JOIN PCMDET ON PCD_CODITE = RCD_CODITE         ');
      qryUpdate.Sql.Add('                    AND PCD_NUMPED = PCMGER.PCG_NUMPED  ');
      qryUpdate.Sql.Add('                    AND PCD_CODEMP = PCMGER.PCG_CODEMP  ');
      qryUpdate.Sql.Add('                    AND PCD_ESPDOC = PCMGER.PCG_ESPDOC  ');
      qryUpdate.Sql.Add('   SET RCD_SEQPCD = NULL                                ');
      qryUpdate.Sql.Add('   WHERE                                                ');
      qryUpdate.SQL.Add('         MOVRCD.AUTOINCREM IN (' + fListaToSql + ' )    ');

      qryUpdate.ParamByName('AUTPCG').AsString := strAutIncPedidoCompra;

      qryUpdate.ExecSQL;

    Except
      On E:Exception Do
        pMensagensErro(E.Message, '[TRequisicaoPedidoCompra.pProcessaDesmarcados]');
    End;

    Result := True;
  Finally
    FreeAndNil(qryUpdate);
  End;

end;

function TRequisicaoPedidoCompra.fSelecionarRequisicoes(strCodEmp, strNumPed,
   strEspDoc, strCodIte: String; objRecPed: TRecuperaPedido;
   blnUsarGiro: Boolean;
   recOpcGir: TRecOpcoesGiro;
   blnShowForm: boolean = True;
   blnImportarTodos: Boolean = False;
   blnCarregandoPedido: Boolean = False): boolean;
  Var
    strFiltrosGiro: String;
begin
  If blnImportarTodos Then
    blnShowForm := False;

  If blnUsarGiro Or (Assigned(recOpcGir.objSalInt) And recOpcGir.objSalInt.blnEncontrouGiro) Then
  Begin
    strFiltrosGiro := fSQLFiltrosGiro(recOpcGir, fEmptyStr(strNumPed));

//    strFiltrosGiro := AnsiReplaceStr(strFiltrosGiro, ':CODGRU', QuotedStr(recOpcGir.strCodGru));
//    strFiltrosGiro := AnsiReplaceStr(strFiltrosGiro, ':CODMAR', QuotedStr(recOpcGir.strCodMar));
//    strFiltrosGiro := AnsiReplaceStr(strFiltrosGiro, ':CODUNI', QuotedStr(recOpcGir.strUnidade));
//    strFiltrosGiro := AnsiReplaceStr(strFiltrosGiro, ':CODDEP', QuotedStr(recOpcGir.strCodDep));
//    strFiltrosGiro := AnsiReplaceStr(strFiltrosGiro, ':PRDGRU', QuotedStr(recOpcGir.strPrdGru));
//    strFiltrosGiro := AnsiReplaceStr(strFiltrosGiro, ':GRUCMP', QuotedStr(recOpcGir.strGruCmp));
  End

  Else strFiltrosGiro := '';

  //Quando for alteração carrega sewm exibir o form para poder manipular os deletes e desvincular
  Result := fSetarPedidoDeCompra(strCodEmp, strNumPed, strEspDoc, strFiltrosGiro, objRecPed, recOpcGir);

  If blnImportarTodos Then
    pMarcaTodos(1);

  If blnShowForm Then
  Begin
    frmCadCotItensImpRequisicao := Nil;

    Try
      If Not fEmptyStr(strCodIte) Then
      Begin
        cdsRequisicao.Filter   := 'CODITE = ' + QuotedStr(strCodIte);
        cdsRequisicao.Filtered := True;
      End;

      If cdsRequisicao.IsEmpty And (Not fEmptyStr(strCodIte)) Then
      Begin
        pMensagemOk('Nenhuma requisição encontrada para o produto ' + strCodIte + '!');

        Result := False;
      End Else
      Begin

        pCriarFormularios(TfrmCadCotItensImpRequisicao, frmCadCotItensImpRequisicao);

        If (Not fEmptyStr(strCodIte)) Then
          frmCadCotItensImpRequisicao.Caption := 'Requisições do produto ' + cdsRequisicao.FieldByName('CODITE').AsString + ' - ' + cdsRequisicao.FieldByName('DESITE').AsString;

        frmCadCotItensImpRequisicao.btnNegar.Visible  := True;
        frmCadCotItensImpRequisicao.pImprimeDocumento := prcImprimeDocumento;

        frmCadCotItensImpRequisicao.objRequisicao := Self;

        Result := (frmCadCotItensImpRequisicao.ShowModal = mrOk);
      End;

    Finally

      FreeAndNil(frmCadCotItensImpRequisicao);

      cdsRequisicao.Filtered := False;
      cdsRequisicao.Filter   := '';
    End;

  End;
  if (Result) And (fCfgSis('VNDPGT', varBoolean)) And (Not blnCarregandoPedido) And (fTemVendaNaoFaturada)  then
    Result := fPedeSenhaLiberarTrava;
  if (Result) And (fCfgSis('VNDSBA', varBoolean)) then
    pPedeSenhaLiberarTravaSemAdtBol;
end;

procedure TRequisicaoPedidoCompra.pCarregaPainelRequisicoes;
  Var
    recOpcGir: TRecOpcoesGiro;
begin
  Try
    tpoOperacao := tpoPainel;

    fCarregaRequisicoes('', recOpcGir);

    frmCadCotItensImpRequisicao := Nil;
    Try
      If cdsRequisicao.IsEmpty  Then
        pMensagemOk('Nenhuma requisição encontrada!')
      Else
      Begin
        pCriarFormularios(TfrmCadCotItensImpRequisicao, frmCadCotItensImpRequisicao);
          frmCadCotItensImpRequisicao.Caption := 'Requisições';
        frmCadCotItensImpRequisicao.cxgReqViewSTATUS.Visible := fCfgSis('EXISTA', varBoolean);
        frmCadCotItensImpRequisicao.btnNegar.Visible  := True;
        frmCadCotItensImpRequisicao.FProcIniciaCotacao := FProcIniciaCotacao;
        frmCadCotItensImpRequisicao.FProcIniciaPedComp := FProcIniciaPedComp;
        frmCadCotItensImpRequisicao.objRequisicao := Self;
        frmCadCotItensImpRequisicao.cxgReqViewSalEnd.Visible := False;
        FNomeForm := frmCadCotItensImpRequisicao.Name;
        frmCadCotItensImpRequisicao.FecharFormAoConfirmar := False;
        frmCadCotItensImpRequisicao.ShowModal;
      End;
    Finally
      FreeAndNil(frmCadCotItensImpRequisicao);
      cdsRequisicao.Filtered := False;
      cdsRequisicao.Filter   := '';
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCarregaPainelRequisicoes]');
    End;
  End;

End;

procedure TRequisicaoPedidoCompra.pDesmarcaItem(strLisReq: string);
  Var
    stlLista: TStringList;
    intContador: Integer;
begin
  If (Not Assigned(cdsRequisicao)) Then
    Exit;

  If (Not cdsRequisicao.Active) Then
  begin
    Exit;
  End;

  If (fEmptyStr(strLisReq)) Then
    Exit;

  stlLista := TStringList.Create;

  stlLista.CommaText := strLisReq;

  For intContador := 0 To stlLista.Count - 1 Do
    If cdsRequisicao.Locate('AUTOINCREM', stlLista[intContador], []) Then
      pDesmarcaRequisicao;

  FreeAndNil(stlLista);
End;

Function TRequisicaoPedidoCompra.fRetiraVinculoItem(strLisReq, strIncMovRcd: String; Var blnAchou: Boolean): String;
  Var
    stlLista: TStringList;
    intIndex: Integer;
Begin
  blnAchou := False;

  stlLista := TStringList.Create;
  stlLista.Sorted := True;

  stlLista.CommaText := strLisReq;

  If stlLista.Find(strIncMovRcd, intIndex) Then
  Begin
    stlLista.Delete(intIndex);
    blnAchou := True;
  End;

  Result := stlLista.CommaText;

  FreeAndNil(stlLista);
End;

procedure TRequisicaoPedidoCompra.pDesmarcaRequisicao;
Begin
  If (Not Assigned(cdsRequisicao)) Then
    Exit;

  If (Not cdsRequisicao.Active) Then
  begin
    Exit;
  End;

  fLock_Unlock(fRetChaveSelecao(cdsRequisicao.FieldByName('AUTOINCREM').AsString), False, False);

  cdsRequisicao.Edit;
  cdsRequisicao.FieldByName('MARDES').AsString := '0';
  cdsRequisicao.FieldByName('MARANT').AsString := '0';
  cdsRequisicao.Post;


end;

procedure TRequisicaoPedidoCompra.pMarcaTodos(intMarcado: Integer);
begin
  If cdsRequisicao.IsEmpty Then
    Exit;

  Try
    cdsRequisicao.DisableControls;

    cdsRequisicao.First;
    While Not cdsRequisicao.Eof Do
    Begin

      If (cdsRequisicao.FieldByName('NEGADA').AsInteger = 0) And
         fEmptyStr(cdsRequisicao.FieldByName('AUTDET').AsString) And
         (cdsRequisicao.FieldByName('MARDES').AsInteger <> intMarcado) And
         ((intMarcado = 0) Or (fLock_Unlock(fRetChaveSelecao(cdsRequisicao.FieldByName('AUTOINCREM').AsString), True, False))) Then
      Begin

        cdsRequisicao.Edit;
        cdsRequisicao.FieldByName('MARDES').AsInteger := intMarcado;
        cdsRequisicao.Post;

        If intMarcado = 0 Then
          fLock_Unlock(fRetChaveSelecao(cdsRequisicao.FieldByName('AUTOINCREM').AsString), False, False);

      End;

      cdsRequisicao.Next;
    End;

  Finally
    cdsRequisicao.EnableControls;
  End;

end;

Function TRequisicaoPedidoCompra.fSetarPedidoDeCompra(strCodEmp, strNumPed, strEspDoc, strFiltrosGiro: String;
   objRecPed: TRecuperaPedido; recOpcGir: TRecOpcoesGiro): Boolean;
begin
  Result := True;

  FstrNumPed  := strNumPed;
  FstrEspDoc  := strEspDoc;
  FstrCodEmp  := strCodEmp;
  FRecPed     := objRecPed;

  FFiltrosGiro := strFiltrosGiro;

  tpoOperacao := tpoPedidoCompra;

  If (cdsRequisicao.IsEmpty) And (Not cdsRequisicao.Filtered) Then
  Begin
    Result := fCarregaRequisicoes('', recOpcGir);

    If Not cdsRequisicao.IsEmpty Then
      cdsRequisicao.First;
  End
  Else
  Begin
    cdsRequisicao.Filter := '';
    cdsRequisicao.Filtered := False;
  End;
end;

Function TRequisicaoPedidoCompra.fCarregaRequisicoes(strSeqGer: String; recOpcGir: TRecOpcoesGiro): Boolean;
  Var
    strLinGru,
    strDesMar,
    strDesPrdgru,
    strDesUnidade,
    strDesCodFor,
    strDesCodDep,
    strDesGruCmp: String;
begin
  With cdsRequisicao.qryQuery, SQL Do
  Try
    Clear;

    Add('SELECT');

    Add('CASE');
    Add('  WHEN (FD2.AUTOINCREM IS NOT NULL) AND (IFNULL(FD2.FDO_ENTFUT, "N") = "S") THEN FD2.FDO_DTAFUT');
    Add('  WHEN (FD2.AUTOINCREM IS NOT NULL) THEN FD2.FDO_DTAENT');
    Add('  WHEN (FD2.AUTOINCREM IS NULL) THEN (');
    Add('SELECT');
    Add('	CASE');
    Add('	  WHEN IFNULL(DET_ENTFUT,"N") = "S" THEN DET_DTAFUT');
    Add('  	  ELSE DET_DTAENT');
    Add('	END');
    Add('FROM MOVDET');
    Add('WHERE DET_NUMDOC = RCD_DOCPDV AND DET_CODEMP = RCD_EMPPDV AND DET_ESPDOC = RCD_ESPPDV AND DET_CODITE = RCD_CODITE LIMIT 1');
    Add('  )');
    Add('END DTA_ENTREGA,');

    Add('  CAST("" AS CHAR(20)) AS AUTDET, ');       // AUTOINCREM DO NOVO PEDIDO DE COMPRA

    Add('  CAST("" AS CHAR(20)) AS AUTDET_CONF, ');  // AUTOINCREM DO NOVO PEDIDO DE COMPRA CONFIRMADO

    Add('  CAST("" AS CHAR(03)) AS EMPDES_NOV, ');  // EMPRESA DESTINO DO NOVO PEDIDO DE COMPRA
    Add('  CAST("" AS CHAR(20)) AS TABDET, ');  // TABELA DO PEDIDO

    Add('  0 AS NEGADA, ');
    Add('  0 AS MOTNEG, ');

    Add('  CAST("" AS CHAR(500)) AS JUSTIF, ');

    Add('  CAST(NULL AS DECIMAL(12,4)) AS SALDIS,');
    Add('  CAST(NULL AS DECIMAL(12,4)) AS SALEND,');
    Add('  CAST(NULL AS DECIMAL(12,4)) AS QTDPEN,');
    Add('  CAST(NULL AS DECIMAL(12,4)) AS QTDDIS,');
    Add('  CAST(NULL AS DECIMAL(12,4)) AS SALREQ,');

    Add('  CAST(NULL AS DECIMAL(12,4)) AS QTDPEN_TODAS,');
    Add('  CAST(NULL AS DECIMAL(12,4)) AS QTDDIS_TODAS,');

    Add('  IFNULL(S.STA_DESCRI, CAST("" AS CHAR(80))) AS FGO_STATUS, ');

    If Assigned(FRecPed) And FRecPed.recPcmger.blnRecuperaPedido Then
    Begin

      Add(' IF((SELECT COUNT(*) ');
      Add('     FROM PCMIRQ_RES RES');
      Add('     WHERE RES.PCM_SEQREQ = MOVRCD.AUTOINCREM AND ');
      Add('           RES.PCM_SEQDET IN (SELECT AUTOINCREM');
      Add('                              FROM PCMDET_RES');
      Add('                              WHERE ');
      Add('                                PCMDET_RES.PCD_SEQGER = :AUTINCPCG)');
      Add('           AND RES.EXCLUIDO = "N") > 0, 1, IF(IFNULL(RCD_SEQPCD, "") = "", 0, 1)) AS MARDES, ');

      Add(' IF((SELECT COUNT(*) ');
      Add('     FROM PCMIRQ_RES RES');
      Add('     WHERE RES.PCM_SEQREQ = MOVRCD.AUTOINCREM AND ');
      Add('           RES.PCM_SEQDET IN (SELECT AUTOINCREM');
      Add('                              FROM PCMDET_RES');
      Add('                              WHERE ');
      Add('                                 PCMDET_RES.PCD_SEQGER = :AUTINCPCG)');
      Add('           AND RES.EXCLUIDO = "N") > 0, 1, IF(IFNULL(RCD_SEQPCD, "") = "", 0, 1)) AS MARANT, ');

    End Else
    Begin

      If tpoOperacao = tpoCotacao Then
      Begin

        Add(' IF(IFNULL(RCD_SEQCOT, "") = "", 0, 1) AS MARDES, ');
        Add(' IF(IFNULL(RCD_SEQCOT, "") = "", 0, 1) AS MARANT, ');

      End Else If tpoOperacao = tpoPedidoCompra Then
      Begin

        Add(' IF(IFNULL(RCD_SEQPCD, "") = "", 0, 1) AS MARDES, ');
        Add(' IF(IFNULL(RCD_SEQPCD, "") = "", 0, 1) AS MARANT, ');

      End Else
      Begin
        if (tpoOperacao = tpoPainel) and fCfgSis('VPRPCC', varBoolean)Then
        Begin
          Add(' IF(IFNULL(RCD_SEQPCD, "") = "", 0, 1) AS MARDES, ');
          Add(' IF(IFNULL(RCD_SEQPCD, "") = "", 0, 1) AS MARANT, ');
          Add(' RCD_SEQPCD, ');
        End
        Else
        Begin
          Add(' 0 AS MARDES, ');
          Add(' 0 AS MARANT, ');
        End;

      End;

    End;

    Add('  MOVRCD.AUTOINCREM,');
    Add('  RCD_SEQCOT AS SEQCOT,');
    Add('  RCG_CODIGO AS CODREQ,');
    Add('  RCG_CODEMP AS CODEMP,');

    If Assigned(FRecPed) And FRecPed.recPcmger.blnRecuperaPedido Then
    Begin

      Add(' IFNULL((SELECT PR.PCD_EMPDES FROM PCDDET_RES PR ');
      Add('         WHERE PR.PCD_SEQPCG = :AUTINCPCG AND PR.PCD_CODITE = PCD_CODITE AND LOCATE(MOVRCD.AUTOINCREM, PR.PCD_INCIRQ) LIMIT 1), RCD_EMPDES) AS EMPDES,');

    End Else
    Begin
      Add('  RCD_EMPDES AS EMPDES,');
    End;

    Add('  ITE_CODFOR AS CODFOR,');
    Add('  FOR_NOMFOR AS NOMFOR,');
    Add('  MAR_DESMAR AS DESMAR,');
    Add('  I.ITE_CODITE AS CODITE,');
    Add('  RCD_DESITE AS DESITE,');
    Add('  RCG_DTACAD AS DTACAD,');
    Add('  RCG_CODVEN AS CODVEN,');
    Add('  VEN.OPE_MSGRCN,');
    Add('  CONCAT(RCG_CODVEN, "-", VEN.OPE_NOMOPE) AS NOMOPE,');
    Add('  CONCAT(RCG_CODCLI, "-", CLI_NOMCLI) AS NOMCLI,');
    Add('  CONCAT(RCD_CODITE, "-", ITE_DESITE) AS PRODUT,');
    Add('  ITE_REFERE AS REFERE,');
    Add('  UNI_SIGUNI AS SIGUNI,');
    Add('  UNI_CODUNI AS CODUNI,');
    Add('  ITE_CODFAB AS CODFAB,');

    Add('  RCD_QTDITE AS QTDORI,');

    Add('  ROUND(RCD_QTDITE - IFNULL((SELECT SUM(BAI_QTDREQ) FROM BAIREQ WHERE BAI_AUTREQ = MOVRCD.AUTOINCREM), 0), 4) AS QTDITE,');

    Add(' (SELECT GROUP_CONCAT(CONCAT(D.DET_ESPDOC, "-", D.DET_NUMDOC, "-", D.DET_CODEMP)) FROM BAIREQ');
    Add('  INNER JOIN MOVDET D ON D.AUTOINCREM = BAI_AUTDET WHERE BAI_AUTREQ = MOVRCD.AUTOINCREM) AS NOTAS, ');

    Add(' IFNULL((SELECT COUNT(*) FROM BAIREQ');
    Add('  INNER JOIN MOVDET D ON D.AUTOINCREM = BAI_AUTDET WHERE BAI_AUTREQ = MOVRCD.AUTOINCREM AND D.DET_DTAENT IS NULL), 0) AS NOTABE, ');

    Add(' ROUND( I.ITE_PRECOM ');
    Add('  * ((100 - IFNULL( I.ITE_DESF01, 0 )) / 100) ');
    Add('  * ((100 - IFNULL( I.ITE_DESF02, 0 )) / 100) ');
    Add('  * ((100 - IFNULL( I.ITE_DESF03, 0 )) / 100) ');
    Add('  * ((100 - IFNULL( I.ITE_DESF04, 0 )) / 100) ');
    Add('  * ((100 - IFNULL( I.ITE_DESF05, 0 )) / 100) ');
    Add('  * ((100 - IFNULL( I.ITE_DESF06, 0 )) / 100), 2) ');
    Add('     AS COMLIQ, ');

    if (tpoOperacao = tpoPainel) and fCfgSis('VPRPCC', varBoolean)Then
    Begin
      Add('  CONCAT(PD.PCD_NUMPED, "-", PCD_ESPDOC, "-", PCD_CODEMP) AS PCD_NUMPED, ');
      Add('  (SELECT CONCAT(PD.PCD_CODFOR,"-", F2.FOR_NOMFOR)  ');
      Add('     FROM CADFOR F2 WHERE F2.FOR_CODFOR = PD.PCD_CODFOR) AS  FORNEC,');
      Add('  PD.PCD_QTDITE - IFNULL(PCD_QTDBAI, 0) AS QTDPED, ');
      Add('  PD.PCD_DTAENT, ');

    End;

    Add('  RCD_SEQPCD AS SEQPCD, ');
    Add('  RCD_OBSERV AS OBSERV, ');
    Add('  RCD_DOCPDV AS DOCPDV, ');
    Add('  RCD_ESPPDV AS ESPPDV, ');
    Add('  IFNULL(EQUGER.EQU_NUMOSE, EQ.EQU_NUMOSE) AS EQU_NUMOSE,');
    Add('  IFNULL(EQUGER.EQU_CODEMP, EQ.EQU_CODEMP) AS EQU_CODEMP,');
    Add('  IFNULL(EQUGER.EQU_PROTOC, EQ.EQU_PROTOC) AS EQU_PROTOC,');
    Add('  ');
    Add('  CASE IFNULL(EQUGER.EQU_GARANT, EQ.EQU_GARANT)');
    Add('      WHEN "L" THEN "Garantia Loja"');
    Add('      WHEN "F" THEN "Garantia Fábrica"');
    Add('      WHEN "R" THEN "Retorno de Garantia"');
    Add('      ELSE "Não"');
    Add('  END AS EQU_GARANT,');
    Add('  IFNULL(RCD_EMPPDV, "") AS EMPPDV, ');
    Add('  IFNULL(DEP_DESCRI, "") AS DEPITE, ');
    Add('  IFNULL(IFNULL(FD1.FDO_EMPITE,FD2.FDO_EMPITE), IFNULL(FD1.FDO_CODEMP,FD2.FDO_CODEMP)) AS EMPITE, ');
    Add(' GRU_OPERES     AS OPERES, ');
    Add(' RES.OPE_NOMOPE AS NOMRES, ');
    Add(' LIN.GRU_DESGRU AS NOMLIN, ');
    Add(' GRU.GRU_DESGRU AS NOMGRU, ');
    Add(' IF( IFNULL(FD1.FDO_NUMDOC, IFNULL(FD2.FDO_NUMDOC, "") ) <> "", "S","N") AS TEMPED,     ');
    Add(' CAST(GROUP_CONCAT(IFNULL(CONCAT(FD1.FDO_NUMFAT, "-",FD1.FDO_TIPFAT, "-",FD1.FDO_EMPFAT),     ');
    Add('      (IFNULL(CONCAT(FD2.FDO_NUMFAT, "-",FD2.FDO_TIPFAT, "-",FD2.FDO_EMPFAT),""))  ');
    Add(' )) AS CHAR(200)) AS PEDFAT,     ');
    Add(' RCD_EMPPDV EMPPDV,');
    Add(' RCG_CODCLI CODCLI,');
    Add(' IFNULL(FD1.FDO_UNITAR, IFNULL(FD2.FDO_UNITAR, 0)) AS UNITAR,');
    Add('(SELECT "S" FROM ADTCLI ');
    Add('WHERE ADT_NUMDOC = RCD_DOCPDV AND ');
    Add('		       ADT_CODEMP = RCD_EMPPDV AND ');
    Add('		       ADT_ESPDOC = RCD_ESPPDV AND ');
    Add('		       ADT_CODCLI = RCG_CODCLI LIMIT 1) AS TEMADT,');

    Add('(SELECT "S" FROM CADREC  ');
    Add(' WHERE CTR_NUMDUP = RCD_DOCPDV AND  ');
    Add('	      CTR_ESPDOC = RCD_ESPPDV AND  ');
    Add('	      CTR_CODCLI = RCG_CODCLI AND  ');
    Add('		    CTR_CODEMP = RCD_EMPPDV AND  ');
    Add('		    COALESCE(CTR_NOSNUM,"") = "" AND');
    Add('       CTR_SEQBAI = 0  LIMIT 1) AS TEMBOL, ');
    Add('       MOVRCD.RCD_DTPREV AS RCD_DTPREV,');
    Add(' (IF(RCD_ESPPDV = "PD",FD2.FDO_NUMLOT,DET_NUMLOT)) AS NUMLOT');

    Add('FROM');
    Add('  MOVRCG');

    Add('  JOIN MOVRCD ON     RCD_CODIGO = RCG_CODIGO');
    Add('                 AND RCD_CODEMP = RCG_CODEMP');

    Add('  LEFT JOIN PREPRQ ON PRQ_SEQRCD = MOVRCD.AUTOINCREM');
    Add('  LEFT JOIN FDOABS ON ABS_SEQPRQ = PREPRQ.AUTOINCREM');
    Add('  LEFT JOIN FATDOR FD1 ON FD1.AUTOINCREM = ABS_SEQFDO');
    Add('  LEFT JOIN FATDOR FD2 ON FD2.FDO_NUMDOC = RCD_DOCPDV');
    Add('                      AND FD2.FDO_CODEMP = RCD_EMPPDV');
    Add('                      AND FD2.FDO_ESPDOC = RCD_ESPPDV');
    Add('                      AND FD2.FDO_CODITE = RCD_CODITE');
    Add('  LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO =  IFNULL(FD1.FDO_SEQGER,FD2.FDO_SEQGER)');
    Add('  LEFT JOIN CADOPE VEN ON VEN.OPE_CODOPE = RCG_CODVEN');

    Add('  LEFT JOIN EQUGER ON (EQU_EMPPED = RCD_EMPPDV');
    Add('                   AND EQU_TIPPED = RCD_ESPPDV');
    Add('                   AND EQU_NUMPED = RCD_DOCPDV)');

    Add('  LEFT JOIN EQUGOR ON EXTGOR.FGO_SEQFGO = EQUGOR.FGO_SEQFGO');
    Add('  LEFT JOIN EQUGER EQ ON (EQ.AUTOINCREM = EQUGOR.FGO_SEQEQU)');

    Add('  JOIN CADCLI ON CLI_CODCLI = RCG_CODCLI');

    Add('  JOIN CADITE C ON C.ITE_CODITE = RCD_CODITE');

    Add('  JOIN ITEGER I ON I.ITE_CODITE = RCD_CODITE AND I.ITE_CODEMP = RCD_CODEMP ');

    Add('  LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR');
    Add('  LEFT JOIN CADFOR ON FOR_CODFOR = ITE_CODFOR');
    Add('  LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI');
    Add('  LEFT JOIN CADDEP ON DEP_CODIGO = ITE_CODDEP ');

    Add('  LEFT JOIN GRU_COMPRA GC ON GC.GRU_CODIGO = C.ITE_GRUCMP ');

    Add('  LEFT JOIN CADOPE RES ON RES.OPE_CODOPE = GC.GRU_OPERES ');

    Add('  LEFT JOIN CADGRU LIN ON LIN.GRU_CODGRU = CONCAT(LEFT(ITE_CODGRU, 3), "000") ');

    Add('  LEFT JOIN CADGRU GRU ON GRU.GRU_CODGRU = ITE_CODGRU');
    Add('  LEFT JOIN FGOSTA S ON EXTGOR.FGO_STATUS = S.STA_CODIGO  ');
    if (tpoOperacao = tpoPainel) and fCfgSis('VPRPCC', varBoolean)Then
      Add('  LEFT JOIN PCMDET PD ON PD.AUTOINCREM =  RCD_SEQPCD AND ((PCD_QTDITE - IFNULL(PCD_QTDBAI, 0)) > 0)');

    Add(' LEFT JOIN MOVDET ON DET_NUMDOC = FD2.FDO_NUMFAT');
    Add('                 AND DET_ESPDOC = FD2.FDO_TIPFAT');
    Add('                 AND DET_CODEMP = FD2.FDO_EMPFAT');
    Add('                 AND DET_CODITE = FD2.FDO_CODITE');

    Add('WHERE TRUE');

    If tpoOperacao = tpoCotacao Then
    Begin
      Add(' AND RCD_REQNEG = "N" ');
      Add(' AND ');
      Add('  (((RCD_SEQCOT IS NULL) AND ');
      Add('    (RCD_SEQPCD IS NULL)) OR RCD_SEQCOT IN (SELECT AUTOINCREM');
      Add('                                              FROM COTITE ');
      Add('                                             WHERE COT_SEQGER = :SEQGER))');
      Add(' AND RCD_REQNEG = "N" ');
      Add(' AND RCD_ATETRA <> 1  ');
      Add(' AND IFNULL((SELECT SUM(B.BAI_QTDREQ) FROM BAIREQ B ');
      Add('             INNER JOIN MOVDET D ON D.AUTOINCREM = B.BAI_AUTDET AND D.DET_DTAENT IS NOT NULL WHERE BAI_AUTREQ = MOVRCD.AUTOINCREM), 0) < RCD_QTDITE ');
      Add(' AND ((IFNULL(RCD_DOCPDV, "") = "") OR ');
      Add('    (IFNULL((SELECT FGO_LIBERA AND FGO_LIBCOM FROM FATGOR WHERE FGO_NUMDOC = RCD_DOCPDV AND FGO_CODEMP = RCD_EMPPDV AND FGO_ESPDOC = RCD_ESPPDV), TRUE)))');
      Add(' GROUP BY MOVRCD.AUTOINCREM ');
      ParamByName('SEQGER').AsString := strSeqGer;
    End

    Else if (tpoOperacao = tpoPedidoCompra) Or (tpoOperacao = tpoPainel) Then
    Begin
      Add(' AND ');
      Add('(');

      Add('  ( ');

      if (tpoOperacao = tpoPainel) and fCfgSis('VPRPCC', varBoolean) Then
        Add('    (RCD_SEQCOT IS NULL) AND')
      Else
        Add('    (RCD_SEQPCD IS NULL) AND (RCD_SEQCOT IS NULL) AND') ;

      Add('         (IFNULL((SELECT COUNT(*) FROM PCMIRQ_RES PR INNER JOIN  PCMGER_RES ON PCMGER_RES.AUTOINCREM = PR.PCM_SEQPCG WHERE PR.PCM_SEQREQ = MOVRCD.AUTOINCREM  AND IF(PCMGER_RES.PCG_EXCLUI = "N", PR.EXCLUIDO = "N", FALSE)), 0 ) = 0) ');

      Add(' AND ((IFNULL(RCD_DOCPDV, "") = "") OR ');
      Add('    (IFNULL((SELECT FGO_LIBERA AND FGO_LIBCOM FROM FATGOR WHERE FGO_NUMDOC = RCD_DOCPDV AND FGO_CODEMP = RCD_EMPPDV AND FGO_ESPDOC = RCD_ESPPDV), TRUE)  ))');

      Add('  ) ');

      If Not fEmptyStr(FstrNumPed) Then
      Begin
        Add('      OR (RCD_SEQPCD IN (SELECT AUTOINCREM');
        Add('                          FROM PCMDET');
        Add('                         WHERE PCMDET.PCD_NUMPED = :NUMPED');
        Add('                           AND PCMDET.PCD_CODEMP = :PEDEMP');
        Add('                           AND IFNULL(PCMDET.PCD_ESPDOC, "") =  :ESPDOC');
        Add('                           AND PCMDET.PCD_BAIXAD = 0');
        Add('                         ))');
      End;

      If Assigned(FRecPed) And FRecPed.recPcmger.blnRecuperaPedido Then
      Begin
        Add('      OR ((SELECT COUNT(*) ');
        Add('           FROM PCMIRQ_RES RES');
        Add('           WHERE RES.PCM_SEQREQ = MOVRCD.AUTOINCREM AND ');
        Add('                 RES.PCM_SEQDET IN (SELECT AUTOINCREM');
        Add('                                    FROM PCMDET_RES');
        Add('                                    WHERE ');
        Add('                                      PCMDET_RES.PCD_SEQGER = :AUTINCPCG)');
        Add('                 AND RES.EXCLUIDO = "N") > 0)');
      End;

      Add('                       )');

      If Assigned(FRecPed) And FRecPed.recPcmger.blnRecuperaPedido Then
      Begin

        Add('      AND ((SELECT COUNT(*) ');
        Add('            FROM PCMIRQ_RES RES');
        Add('            WHERE RES.PCM_SEQREQ = MOVRCD.AUTOINCREM AND ');
        Add('                  RES.PCM_SEQDET IN (SELECT AUTOINCREM');
        Add('                                     FROM PCMDET_RES');
        Add('                                     WHERE ');
        Add('                                       PCMDET_RES.PCD_SEQGER = :AUTINCPCG)');
        Add('                 AND RES.EXCLUIDO = "S") = 0)');

      End;

      Add(' AND RCD_ATETRA <> 1  ');
      Add(' AND RCD_REQNEG = "N" ');

      Add(' AND IFNULL((SELECT SUM(B.BAI_QTDREQ) FROM BAIREQ B ');
      Add('             INNER JOIN MOVDET D ON D.AUTOINCREM = B.BAI_AUTDET AND D.DET_DTAENT IS NOT NULL WHERE BAI_AUTREQ = MOVRCD.AUTOINCREM), 0) < RCD_QTDITE ');

      if (tpoOperacao = tpoPedidoCompra) And (Not fEmptyStr(FFiltrosGiro)) Then
      Begin

         If Not fEmptyStr(FstrNumPed) Then
           Add('AND ((RCD_SEQPCD IS NOT NULL) OR (' + FFiltrosGiro + '))')
         Else
           Add('AND ' + FFiltrosGiro);
      End;

      If recOpcGir.blnLimReq And (tpoOperacao <> tpoPainel) Then
      Begin
        If recOpcGir.strEmpGir <> '' Then
          Add(' AND MOVRCG.RCG_CODEMP IN (' + recOpcGir.strEmpGir + ')')
        Else
          Add(' AND MOVRCG.RCG_CODEMP = "' + VS_StrCodEmp +'"');
      end
      //Se for pedido simples sem uso do giro carrega apenas as requisições da empresa do pedido
      Else If (fCfgSis('FILREQ', varBoolean)) And (recOpcGir.strPedMlj = 'N') And (recOpcGir.strNomFrm = '')  Then
      Begin
        If recOpcGir.strEmpGir <> '' Then
          Add(' AND MOVRCG.RCG_CODEMP IN (' + recOpcGir.strEmpGir + ',"' +VS_StrCodEmp+ '")')
        Else
          Add(' AND MOVRCG.RCG_CODEMP = "' + VS_StrCodEmp +'"');
      End;

      Add('GROUP BY AUTDET_CONF, EMPDES_NOV, TABDET, NEGADA, MOTNEG, JUSTIF, SALDIS, SALEND, QTDPEN,');
      Add('QTDDIS, SALREQ, QTDPEN_TODAS, QTDDIS_TODAS, MARDES, MARANT, AUTOINCREM, SEQCOT, CODREQ, CODEMP,');
      Add('EMPDES, CODFOR, NOMFOR, DESMAR, CODITE, DESITE, DTACAD, NOMOPE, NOMCLI, PRODUT, REFERE, SIGUNI,');
      Add('CODUNI, CODFAB, QTDORI, QTDITE, NOTAS, NOTABE, SEQPCD, OBSERV, DOCPDV, ESPPDV, EMPPDV, DEPITE,');
      Add('OPERES, NOMRES, NOMLIN, NOMGRU, CODVEN, NOMGRU, TEMPED, EMPPDV ');

      Add('HAVING (QTDITE > 0) OR (NOTAS IS NOT NULL)');

      If Not fEmptyStr(FstrNumPed) Then
      Begin
        ParamByName('NUMPED').AsString := FstrNumPed;
        ParamByName('ESPDOC').AsString := FstrEspDoc;
        ParamByName('PEDEMP').AsString := FstrCodEmp;
      End;

      If Assigned(FRecPed) And FRecPed.recPcmger.blnRecuperaPedido Then
        ParamByName('AUTINCPCG').AsString := FRecPed.recPcmger.strAutInc;

      If Not FFiltrosGiro.IsEmpty Then
      With recOpcGir Do
      Begin
        pSetaParam(strCodGru,  arrLinhaGrupo, strLinGru,     'CODGRU', cdsRequisicao.qryQuery);
        pSetaParam(strCodMar,  arrMarca,      strDesMar,     'CODMAR', cdsRequisicao.qryQuery);
        pSetaParam(strPrdGru,  arrPrdGru,     strDesPrdgru,  'PRDGRU', cdsRequisicao.qryQuery);
        pSetaParam(strUnidade, arrUnidade,    strDesUnidade, 'CODUNI', cdsRequisicao.qryQuery);
        pSetaParam(strCodDep,  arrCodDep,     strDesCodDep,  'CODDEP', cdsRequisicao.qryQuery);
        pSetaParam(strGruCmp,  arrGruCmp,     strDesGruCmp,  'GRUCMP', cdsRequisicao.qryQuery);
        If recOpcGir.strCodFor =  '00000000' Then
          pSetaParam(strCodFor,  arrCodFor,     strDesCodFor,  'CODFOR', cdsRequisicao.qryQuery);
      End;

    End;

    Result := cdsRequisicao.fLeDados('TRequisicaoPedidoCompra.fCarregaRequisicoes');

    pFormataCdsRequisicao;

    pCarregaSaldos;

  Finally

  End;
end;

Procedure TRequisicaoPedidoCompra.pCarregaSaldos;
  Var
    frmGravando: TfrmGravando;
Begin
  TfrmGravando.fExecuta(fCarregaSaldos, frmGravando, 'Carregando saldos...');
End;

Class Function TRequisicaoPedidoCompra.fRetQuantidadeRequisicaoPedido(strCodIte, strEmpresas: String): Double;
  Var
    qryPedPen: TUniQuery;
Begin
  qryPedPen := fCriaQuery;

  qryPedPen.SQL.Clear;
  qryPedPen.SQL.Add('SELECT ');
  qryPedPen.SQL.Add(' SUM(IFNULL((SELECT SUM(RCD_QTDITE) - IFNULL((SELECT SUM(BAI_QTDREQ) FROM BAIREQ WHERE BAI_AUTREQ = R.AUTOINCREM), 0) ');
  qryPedPen.SQL.Add('         FROM MOVRCD R ');
  qryPedPen.SQL.Add('         WHERE RCD_ATETRA <> 1 AND RCD_SEQPCD = PC.AUTOINCREM), 0)) AS QTDREQ ');

  qryPedPen.SQL.Add('FROM ');
  qryPedPen.SQL.Add('  PCMDET PC');

  qryPedPen.SQL.Add('  JOIN PCMGER ON PCG_NUMPED = PC.PCD_NUMPED AND ');
  qryPedPen.SQL.Add('                 PCG_CODEMP = PC.PCD_CODEMP AND ');
  qryPedPen.SQL.Add('                 PCG_ESPDOC = PC.PCD_ESPDOC AND ');
  qryPedPen.SQL.Add('                 PCG_NUMCTN = PC.PCD_NUMCTN     ');

  qryPedPen.SQL.Add('WHERE TRUE ');

  If Not fEmptyStr(strEmpresas) Then
    qryPedPen.SQL.Add(' AND IF(PCG_EMPDES IS NULL OR PCG_EMPDES = "", PC.PCD_CODEMP, PCG_EMPDES) IN (' + strEmpresas + ') ');

  qryPedPen.SQL.Add(' AND ROUND(PC.PCD_QTDITE - PC.PCD_QTDBAI,' + fCfgSis('DEQTPC') + ') > 0  ');
  qryPedPen.SQL.Add(' AND PC.PCD_BAIXAD = 0  ');
  qryPedPen.SQL.Add(' AND PC.PCD_NUMCTN = 0  ');
  qryPedPen.SQL.Add(' AND PC.PCD_ESPDOC = "PD" ');
  qryPedPen.SQL.Add(' AND PC.PCD_CODITE = :CODITE ');

  qryPedPen.ParamByName('CODITE').AsString := strCodIte;
  qryPedPen.Open;

  Result := qryPedPen.FieldByName('QTDREQ').AsFloat;

  FreeAndNil(qryPedPen);
End;

Function TRequisicaoPedidoCompra.fCarregaSaldos(cxgProgresso: TcxProgressBar): Boolean;
  Var
    intRecNo: Integer;
    strIndexFields: String;
Begin
 If tpoOperacao = tpoPainel Then
 Begin
   cdsRequisicao.First;
   cdsRequisicao.DisableControls;
   Try
     While Not cdsRequisicao.Eof Do
     Begin
       cdsRequisicao.Edit;
       pGetSaldosReservados(cdsSaldos, cdsRequisicao.FieldByName('CODITE').AsString, VS_StrCodEmp,
                            blnUsarGiro Or (Assigned(recOpcGir.objSalInt) And recOpcGir.objSalInt.blnEncontrouGiro),
                            recOpcGir);

       cdsRequisicao.FieldByName('SALDIS').AsFloat := cdsSaldos.FieldByName('ITE_SALDIS').AsFloat;

       cdsRequisicao.FieldByName('QTDPEN').AsFloat := fRetQuantPendentePedidoCompra(cdsRequisicao.FieldByName('CODITE').AsString, '', VS_StrCodEmp, False);
       cdsRequisicao.FieldByName('QTDDIS').AsFloat := cdsRequisicao.FieldByName('QTDPEN').AsFloat - fRetQuantidadeRequisicaoPedido(cdsRequisicao.FieldByName('CODITE').AsString, VS_StrCodEmp);
       cdsRequisicao.FieldByName('QTDPEN_TODAS').AsFloat := fRetQuantPendentePedidoCompra(cdsRequisicao.FieldByName('CODITE').AsString, '', '', False);
       cdsRequisicao.FieldByName('QTDDIS_TODAS').AsFloat := cdsRequisicao.FieldByName('QTDPEN_TODAS').AsFloat - fRetQuantidadeRequisicaoPedido(cdsRequisicao.FieldByName('CODITE').AsString, '');
       cdsRequisicao.Post;

       cdsRequisicao.Next;
       cxgProgresso.Position := cxgProgresso.Position + 1;
       Application.ProcessMessages;
     End;
   Finally
     cdsRequisicao.First;
     cdsRequisicao.EnableControls;
   End;
 End
 Else
 Begin
    If Assigned(cdsItensPedido) Then
    Begin
      intRecNo       := cdsItensPedido.RecNo;
      strIndexFields := cdsItensPedido.IndexFieldNames;

      Try

        cdsItensPedido.IndexFieldNames := 'ITE_CODITE';

        cxgProgresso.Properties.Max := cdsRequisicao.RecordCount;

        While Not cdsRequisicao.Eof Do
        Begin
          cdsRequisicao.Edit;

          If cdsItensPedido.FindKey([cdsRequisicao.FieldByName('CODITE').AsString]) Then
          Begin
            cdsRequisicao.FieldByName('SALDIS').Value   := cdsItensPedido.FieldByName('ITE_SALBAS').Value - cdsItensPedido.FieldByName('ITE_SALEND').AsFloat;
            cdsRequisicao.FieldByName('SALEND').Value   := cdsItensPedido.FieldByName('ITE_SALEND').Value;

            cdsRequisicao.FieldByName('QTDPEN').Value   := cdsItensPedido.FieldByName('ITE_QTDPEN').Value;
            cdsRequisicao.FieldByName('SALREQ').Value   := cdsItensPedido.FieldByName('ITE_SALREQ').Value;
            cdsRequisicao.FieldByName('QTDDIS').AsFloat := cdsRequisicao.FieldByName('QTDPEN').AsFloat -
                                                                fRetQuantidadeRequisicaoPedido(cdsRequisicao.FieldByName('CODITE').AsString, strEmpSaldos);
          End Else
          Begin
            pGetSaldosReservados(cdsSaldos, cdsRequisicao.FieldByName('CODITE').AsString, strEmpSaldos,
                                 blnUsarGiro Or (Assigned(recOpcGir.objSalInt) And recOpcGir.objSalInt.blnEncontrouGiro),
                                 recOpcGir);

            cdsRequisicao.FieldByName('SALDIS').AsFloat := cdsSaldos.FieldByName('ITE_SALBAS').AsFloat - cdsSaldos.FieldByName('ITE_SALEND').AsFloat;
            cdsRequisicao.FieldByName('SALEND').Value   := cdsItensPedido.FieldByName('ITE_SALEND').Value;

            cdsRequisicao.FieldByName('QTDPEN').AsFloat := fRetQuantPendentePedidoCompra(cdsRequisicao.FieldByName('CODITE').AsString,
                                          IIF(recOpcGir.blnAgrSim, QuotedStr(cdsItensPedido.FieldByName('ITE_CODSIM').AsString), ''), strEmpSaldos, False);

            cdsRequisicao.FieldByName('QTDDIS').AsFloat := cdsRequisicao.FieldByName('QTDPEN').AsFloat -
                                                                fRetQuantidadeRequisicaoPedido(cdsRequisicao.FieldByName('CODITE').AsString, strEmpSaldos);
          End;

          cdsRequisicao.FieldByName('QTDPEN_TODAS').AsFloat := fRetQuantPendentePedidoCompra(cdsRequisicao.FieldByName('CODITE').AsString,
                                         IIF(recOpcGir.blnAgrSim, QuotedStr(cdsItensPedido.FieldByName('ITE_CODSIM').AsString), ''), '', False);

          cdsRequisicao.FieldByName('QTDDIS_TODAS').AsFloat := cdsRequisicao.FieldByName('QTDPEN_TODAS').AsFloat -
                                                                 fRetQuantidadeRequisicaoPedido(cdsRequisicao.FieldByName('CODITE').AsString, '');

          cdsRequisicao.Post;

          cdsRequisicao.Next;

          cxgProgresso.Position := cxgProgresso.Position + 1;
          Application.ProcessMessages;
        End;

        cdsRequisicao.First;

      Finally
        If (intRecNo > 0) And (cdsItensPedido.RecordCount >= intRecNo) Then
          cdsItensPedido.RecNo := intRecNo;

        cdsItensPedido.IndexFieldNames := strIndexFields;
      End;

    End;
  End;

  Result := True;
End;

Procedure TRequisicaoPedidoCompra.pFormataCdsRequisicao;
Begin
  cdsRequisicao.FieldByName('CODEMP').Alignment := taCenter;
  cdsRequisicao.FieldByName('CODREQ').Alignment := taCenter;
  cdsRequisicao.FieldByName('CODITE').Alignment := taCenter;
  cdsRequisicao.FieldByName('CODFOR').Alignment := taCenter;
  cdsRequisicao.FieldByName('DTACAD').Alignment := taCenter;
  cdsRequisicao.FieldByName('DOCPDV').Alignment := taCenter;
  cdsRequisicao.FieldByName('EMPPDV').Alignment := taCenter;
  cdsRequisicao.FieldByName('ESPPDV').Alignment := taCenter;
  cdsRequisicao.FieldByName('OPERES').Alignment := taCenter;

  (cdsRequisicao.FieldByName('QTDITE') As TFloatField).DisplayFormat := fMskDigitos(2);
End;

Function TRequisicaoPedidoCompra.fSQLPedidosDisponiveis: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                                      ';

  strSQL := strSQL + '   "PCMDET"                       AS TABDET, ';
  strSQL := strSQL + '   D.AUTOINCREM                   AS AUTDET, ';
  strSQL := strSQL + '   CAST("" AS CHAR(1000))         AS AUTREQ, ';

  strSQL := strSQL + '   CASE ';
  strSQL := strSQL + '     WHEN D.PCD_BAIXAD     THEN "Baixado" ';
  strSQL := strSQL + '     WHEN D.PCD_QTDBAI > 0 THEN "Baixado parcialmente" ';
  strSQL := strSQL + '     ELSE                     "Aberto"               ';
  strSQL := strSQL + '   END AS STATUS,                                    ';

  strSQL := strSQL + '   PCD_CODITE                     AS CODITE, ';
  strSQL := strSQL + '   PCD_DTAPED                     AS DTAPED, ';
  strSQL := strSQL + '   PCD_DTAENT                     AS DTAENT, ';
  strSQL := strSQL + '   PCD_NUMPED                     AS NUMPED, ';
  strSQL := strSQL + '   PCD_CODEMP                     AS CODEMP, ';
  strSQL := strSQL + '   PCD_CODFOR                     AS CODFOR, ';
  strSQL := strSQL + '   FOR_NOMFOR                     AS NOMFOR, ';

  strSQL := strSQL + '   IFNULL(PCG_EMPDES, PCD_CODEMP) AS EMPDES, ';

  If blnRQPDBA Then
  Begin
    strSQL := strSQL + '     PCMGER.PCG_ORDCON AS ORDCON, ';
    strSQL := strSQL + '     CAST((SELECT GROUP_CONCAT(MOVGER.GER_NUMDOC, "-", MOVGER.GER_ESPDOC, "-", MOVGER.GER_SERIE_ ) AS NOTA ';
    strSQL := strSQL + '             FROM MOVGER ';
    strSQL := strSQL + '            WHERE MOVGER.AUTOINCREM IN ((SELECT DET_SEQGER ';
    strSQL := strSQL + '                                           FROM BAIPED ';
    strSQL := strSQL + '                                          INNER JOIN MOVDET ON MOVDET.AUTOINCREM = BAI_AUTDET ';
    strSQL := strSQL + '                                          INNER JOIN MOVGER ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER ';
    strSQL := strSQL + '                                          WHERE BAIPED.BAI_AUTPED = D.AUTOINCREM ';
    strSQL := strSQL + '                                          GROUP BY  MOVGER.AUTOINCREM))) AS CHAR(255)) NOTENT, ';

    strSQL := strSQL + '   PCD_QTDITE * IF(PCD_EMBALA = 0 OR PCD_EMBALA IS NULL, 1, PCD_EMBALA) AS QTDPED, ';

    strSQL := strSQL + '   IFNULL((SELECT SUM(RCD_QTDITE) ';
    strSQL := strSQL + '           FROM MOVRCD R ';
    strSQL := strSQL + '           WHERE RCD_ATETRA <> 1 AND RCD_SEQPCD = D.AUTOINCREM), 0) AS QTDREQ, ';

    strSQL := strSQL + '   PCD_QTDITE * IF(PCD_EMBALA = 0 OR PCD_EMBALA IS NULL, 1, PCD_EMBALA) - ';
    strSQL := strSQL + '     IFNULL((SELECT SUM(RCD_QTDITE) ';
    strSQL := strSQL + '             FROM MOVRCD R ';
    strSQL := strSQL + '             WHERE RCD_ATETRA <> 1 AND RCD_SEQPCD = D.AUTOINCREM), 0) AS QTDDIS, ';
  End Else
  Begin
    strSQL := strSQL + '   (PCD_QTDITE - PCD_QTDBAI) * IF(PCD_EMBALA = 0 OR PCD_EMBALA IS NULL, 1, PCD_EMBALA) AS QTDPED, ';

    strSQL := strSQL + '   IFNULL((SELECT SUM(RCD_QTDITE) - IFNULL((SELECT SUM(BAI_QTDREQ) FROM BAIREQ WHERE BAI_AUTREQ = R.AUTOINCREM), 0) ';
    strSQL := strSQL + '           FROM MOVRCD R ';
    strSQL := strSQL + '           WHERE RCD_ATETRA <> 1 AND RCD_SEQPCD = D.AUTOINCREM), 0) AS QTDREQ, ';

    strSQL := strSQL + '   (PCD_QTDITE - PCD_QTDBAI) * IF(PCD_EMBALA = 0 OR PCD_EMBALA IS NULL, 1, PCD_EMBALA) - ';
    strSQL := strSQL + '     IFNULL((SELECT SUM(RCD_QTDITE) - IFNULL((SELECT SUM(BAI_QTDREQ) FROM BAIREQ WHERE BAI_AUTREQ = R.AUTOINCREM), 0) ';
    strSQL := strSQL + '             FROM MOVRCD R ';
    strSQL := strSQL + '             WHERE RCD_ATETRA <> 1 AND RCD_SEQPCD = D.AUTOINCREM), 0) AS QTDDIS, ';
  End;

  strSQL := strSQL + '   ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '   ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '   UNI_SIGUNI AS SIGUNI,  ';
  strSQL := strSQL + '   IF(LOCATE("PD", IFNULL(PCG_DOCORI, "")), "", IFNULL(PCG_DOCORI, "")) AS DOCORI ';

  strSQL := strSQL + ' FROM ';

  strSQL := strSQL + '   PCMDET D ';

  strSQL := strSQL + ' INNER JOIN PCMGER ON          ';
  strSQL := strSQL + '   PCG_NUMPED = PCD_NUMPED AND ';
  strSQL := strSQL + '   PCG_ESPDOC = PCD_ESPDOC AND ';
  strSQL := strSQL + '   PCG_CODEMP = PCD_CODEMP ';

  strSQL := strSQL + ' INNER JOIN CADFOR ON PCD_CODFOR = FOR_CODFOR ';

  strSQL := strSQL + ' LEFT JOIN CADUNI  ON UNI_CODUNI = PCD_CODUNI ';

  strSQL := strSQL + ' INNER JOIN CADITE ON ITE_CODITE = PCD_CODITE ';

  strSQL := strSQL + ' WHERE TRUE ';

  If blnRQPDBA Then
  Begin
    strSQL := strSQL + '  AND (D.PCD_QTDITE * D.PCD_EMBALA) > IFNULL((SELECT SUM(BAI_QTDREQ) FROM BAIREQ B WHERE B.BAI_AUTPED = D.AUTOINCREM), 0) ';
  End Else
  Begin
    strSQL := strSQL + '   AND PCG_BAIXAD = 0       ';
    strSQL := strSQL + '   AND PCD_BAIXAD = 0       ';
  End;

  strSQL := strSQL + '   AND PCD_ESPDOC = "PD"    ';
  strSQL := strSQL + '   AND PCD_NUMCTN = 0       ';
  strSQL := strSQL + '   AND PCG_NUMCTN = 0       ';
  strSQL := strSQL + '   AND PCD_CODITE = :CODITE ';

//  strSQL := strSQL + '   AND IFNULL(PCG_DOCORI, "")  = "" '; // RETIRA OS PEDIDOS DE TRANSFERENCIA

  strSQL := strSQL + '   AND (SELECT                               ';
  strSQL := strSQL + '          COUNT(*)                           ';
  strSQL := strSQL + '        FROM                                 ';
  strSQL := strSQL + '          PCDDET PD                          ';
  strSQL := strSQL + '        WHERE                                ';
  strSQL := strSQL + '          PD.PCD_NUMPED = D.PCD_NUMPED AND   ';
  strSQL := strSQL + '          PD.PCD_ESPDOC = D.PCD_ESPDOC AND   ';
  strSQL := strSQL + '          PD.PCD_CODEMP = D.PCD_CODEMP) = 0  ';

  If Not fEmptyStr(strAutPedCom) Then
    strSQL := strSQL + '  AND PCMGER.AUTOINCREM <> ' + QuotedStr(strAutPedCom);

  strSQL := strSQL + '  HAVING QTDDIS > 0 ';

  strSQL := strSQL + '  UNION ALL                                    ';

  strSQL := strSQL + ' SELECT                                         ';

  strSQL := strSQL + '   "PCDDET"                          AS TABDET, ';
  strSQL := strSQL + '   D.AUTOINCREM                      AS AUTDET, ';
  strSQL := strSQL + '   CAST("" AS CHAR(1000))            AS AUTREQ, ';

  strSQL := strSQL + '   CASE ';
  strSQL := strSQL + '     WHEN D.PCD_BAIXAD     THEN "Baixado" ';
  strSQL := strSQL + '     WHEN D.PCD_QTDBAI > 0 THEN "Baixado parcialmente" ';
  strSQL := strSQL + '     ELSE                     "Aberto"               ';
  strSQL := strSQL + '   END AS STATUS,                                    ';

  strSQL := strSQL + '   D.PCD_CODITE                      AS CODITE, ';
  strSQL := strSQL + '   PCG_DTAPED                        AS DTAPED, ';
  strSQL := strSQL + '   D.PCD_DTAENT                      AS DTAENT, ';
  strSQL := strSQL + '   PCG_NUMPED                        AS NUMPED, ';
  strSQL := strSQL + '   PCG_CODEMP                        AS CODEMP, ';
  strSQL := strSQL + '   PCG_CODFOR                        AS CODFOR, ';
  strSQL := strSQL + '   FOR_NOMFOR                        AS NOMFOR, ';

  strSQL := strSQL + '   PD.PCD_EMPDES                     AS EMPDES, ';

  If blnRQPDBA Then
  Begin

    strSQL := strSQL + '     PCMGER.PCG_ORDCON AS ORDCON, ';
    strSQL := strSQL + '     CAST((SELECT GROUP_CONCAT(MOVGER.GER_NUMDOC, "-", MOVGER.GER_ESPDOC, "-", MOVGER.GER_SERIE_ ) AS NOTA ';
    strSQL := strSQL + '             FROM MOVGER ';
    strSQL := strSQL + '            WHERE MOVGER.AUTOINCREM IN ((SELECT DET_SEQGER ';
    strSQL := strSQL + '                                           FROM BAIPED ';
    strSQL := strSQL + '                                          INNER JOIN MOVDET ON MOVDET.AUTOINCREM = BAI_AUTDET ';
    strSQL := strSQL + '                                          INNER JOIN MOVGER ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER ';
    strSQL := strSQL + '                                          WHERE BAIPED.BAI_AUTPED = D.AUTOINCREM ';
    strSQL := strSQL + '                                          GROUP BY  MOVGER.AUTOINCREM))) AS CHAR(255)) NOTENT, ';

    strSQL := strSQL + '   (PD.PCD_QTDITE - IFNULL(TRA_QTDITE, 0)) * IF(D.PCD_EMBALA = 0 OR D.PCD_EMBALA IS NULL, 1, D.PCD_EMBALA) AS QTDPED, ';

    strSQL := strSQL + '   IFNULL((SELECT SUM(RCD_QTDITE) ';
    strSQL := strSQL + '           FROM MOVRCD R ';
    strSQL := strSQL + '           WHERE RCD_ATETRA <> 1 AND RCD_SEQPCD = D.AUTOINCREM AND RCD_EMPDES = PD.PCD_CODEMP), 0) AS QTDREQ, ';

    strSQL := strSQL + '   (PD.PCD_QTDITE - IFNULL(TRA_QTDITE, 0))* IF(D.PCD_EMBALA = 0 OR D.PCD_EMBALA IS NULL, 1, D.PCD_EMBALA) - ';
    strSQL := strSQL + '     IFNULL((SELECT SUM(RCD_QTDITE) ';
    strSQL := strSQL + '             FROM MOVRCD R ';
    strSQL := strSQL + '             WHERE RCD_ATETRA <> 1 AND RCD_SEQPCD = D.AUTOINCREM AND RCD_EMPDES = PD.PCD_CODEMP), 0) AS QTDDIS, ';
  End Else
  Begin
    strSQL := strSQL + '   (PD.PCD_QTDITE - IFNULL(TRA_QTDITE, 0)) * IF(D.PCD_EMBALA = 0 OR D.PCD_EMBALA IS NULL, 1, D.PCD_EMBALA) AS QTDPED, ';

    strSQL := strSQL + '   IFNULL((SELECT SUM(RCD_QTDITE) - IFNULL((SELECT SUM(BAI_QTDREQ) FROM BAIREQ WHERE BAI_AUTREQ = R.AUTOINCREM), 0) ';
    strSQL := strSQL + '           FROM MOVRCD R ';
    strSQL := strSQL + '           WHERE RCD_ATETRA <> 1 AND RCD_SEQPCD = D.AUTOINCREM AND RCD_EMPDES = PD.PCD_CODEMP), 0) AS QTDREQ, ';

    strSQL := strSQL + '   (PD.PCD_QTDITE - IFNULL(TRA_QTDITE, 0)) * IF(D.PCD_EMBALA = 0 OR D.PCD_EMBALA IS NULL, 1, D.PCD_EMBALA) - ';
    strSQL := strSQL + '     IFNULL((SELECT SUM(RCD_QTDITE) - IFNULL((SELECT SUM(BAI_QTDREQ) FROM BAIREQ WHERE BAI_AUTREQ = R.AUTOINCREM), 0) ';
    strSQL := strSQL + '             FROM MOVRCD R ';
    strSQL := strSQL + '             WHERE RCD_ATETRA <> 1 AND RCD_SEQPCD = D.AUTOINCREM AND RCD_EMPDES = PD.PCD_CODEMP), 0) AS QTDDIS, ';
  End;

  strSQL := strSQL + '   ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '   ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '   UNI_SIGUNI AS SIGUNI,  ';
  strSQL := strSQL + '   IF(LOCATE("PD", IFNULL(PCG_DOCORI, "")), "", IFNULL(PCG_DOCORI, "")) AS DOCORI ';

  strSQL := strSQL + ' FROM ';

  strSQL := strSQL + '   PCDDET PD ';
  strSQL := strSQL + '   LEFT JOIN DETTRA PT ON PT.TRA_PCDDET = PD.AUTOINCREM ';
  strSQL := strSQL + ' INNER JOIN PCMDET D ON             ';
  strSQL := strSQL + '   PD.PCD_NUMPED = D.PCD_NUMPED AND ';
  strSQL := strSQL + '   PD.PCD_ESPDOC = D.PCD_ESPDOC AND ';
  strSQL := strSQL + '   PD.PCD_CODEMP = D.PCD_CODEMP AND ';
  strSQL := strSQL + '   PD.PCD_CODITE = D.PCD_CODITE     ';

  strSQL := strSQL + ' INNER JOIN PCMGER ON            ';
  strSQL := strSQL + '   PCG_NUMPED = D.PCD_NUMPED AND ';
  strSQL := strSQL + '   PCG_ESPDOC = D.PCD_ESPDOC AND ';
  strSQL := strSQL + '   PCG_CODEMP = D.PCD_CODEMP     ';

  strSQL := strSQL + ' INNER JOIN CADFOR ON PCG_CODFOR = FOR_CODFOR ';

  strSQL := strSQL + ' LEFT JOIN CADUNI  ON UNI_CODUNI = D.PCD_CODUNI ';

  strSQL := strSQL + ' INNER JOIN CADITE ON ITE_CODITE = D.PCD_CODITE ';

  strSQL := strSQL + ' WHERE TRUE ';

  If blnRQPDBA Then
  Begin
    strSQL := strSQL + '  AND (D.PCD_QTDITE * D.PCD_EMBALA) > IFNULL((SELECT SUM(BAI_QTDREQ) FROM BAIREQ B WHERE B.BAI_AUTPED = D.AUTOINCREM), 0) ';
  End Else
  Begin
    strSQL := strSQL + '   AND   PCG_BAIXAD = 0   ';
    strSQL := strSQL + '   AND D.PCD_BAIXAD = 0   ';
  End;

  strSQL := strSQL + '   AND   PCG_ESPDOC = "PD"    ';
  strSQL := strSQL + '   AND D.PCD_NUMCTN = 0       ';
  strSQL := strSQL + '   AND   PCG_NUMCTN = 0       ';
  strSQL := strSQL + '   AND D.PCD_CODITE = :CODITE ';

//  strSQL := strSQL + '   AND IFNULL(PCG_DOCORI, "")  = "" '; // RETIRA OS PEDIDOS DE TRANSFERENCIA

  If Not fEmptyStr(strAutPedCom) Then
    strSQL := strSQL + '  AND PCMGER.AUTOINCREM <> ' + QuotedStr(strAutPedCom);

  strSQL := strSQL + '  HAVING QTDDIS > 0 ';

  Result := strSQL;
End;

Procedure TRequisicaoPedidoCompra.pFormataDisponiveis;
Begin
  cdsPedidosDisponiveis.pAlinhaCampoCentro('CODITE');
  cdsPedidosDisponiveis.pAlinhaCampoCentro('DTAPED');
  cdsPedidosDisponiveis.pAlinhaCampoCentro('DTAENT');
  cdsPedidosDisponiveis.pAlinhaCampoCentro('NUMPED');
  cdsPedidosDisponiveis.pAlinhaCampoCentro('CODEMP');
  cdsPedidosDisponiveis.pAlinhaCampoCentro('EMPDES');
  cdsPedidosDisponiveis.pAlinhaCampoCentro('CODFOR');
End;

Function TRequisicaoPedidoCompra.fCriaPedidosDisponiveis: Boolean;
Begin
  cdsPedidosDisponiveis := TZClient.Create(Nil, fSQLPedidosDisponiveis);
  Result := cdsPedidosDisponiveis.fLeDados('fCriaPedidosDisponiveis');

  If Result Then
  Begin
    cdsPedidosDisponiveis.IndexFieldNames := 'CODITE;AUTDET;EMPDES';

    pFormataDisponiveis;
  End;
End;

Function TRequisicaoPedidoCompra.fCarregaPedidosDisponiveis(strCodIte: String): Boolean;
   Var
     cdsPedidos: TZClient;
     intContador: Integer;
Begin
  Result := True;

  If FItensJaPesquisados.Find(strCodIte, intContador) Then
    Exit;

  FItensJaPesquisados.Add(strCodIte);

  cdsPedidos := TZClient.Create(Nil, fSQLPedidosDisponiveis);
  cdsPedidos.qryQuery.ParamByName('CODITE').AsString := strCodIte;

  Result := cdsPedidos.fLeDados('fCarregaPedidosDisponiveis');

  If Result Then
  Begin

    While Not cdsPedidos.Eof Do
    Begin
      If Not cdsPedidosDisponiveis.FindKey([cdsPedidos.FieldByName('CODITE').AsString,
                                            cdsPedidos.FieldByName('AUTDET').AsString,
                                            cdsPedidos.FieldByName('EMPDES').AsString]) Then
      Begin
        cdsPedidosDisponiveis.Insert;

        for intContador := 0 to cdsPedidos.FieldCount - 1 do
          cdsPedidosDisponiveis.Fields[intContador].Value := cdsPedidos.Fields[intContador].Value;

        cdsPedidosDisponiveis.Post;
      End;

      cdsPedidos.Next;
    End; {While Not cdsPedidos.Eof Do}

  End;

End;

Class Function TRequisicaoPedidoCompra.fRetChaveSelecao(strAutInc: String): String;
Begin
  Result := 'REQUISICAO_' + strAutInc;
End;

Function TRequisicaoPedidoCompra.fPodeSelecionarPedidoDisponivel: Boolean;
Begin
  Result := True;

  With cdsPedidosDisponiveis Do
  Begin

    If Not fEmptyStr(FieldByName('DOCORI').AsString) Then
    Begin

      pMensagemOk('Pedidos de Transferência não podem ser associados a requisições!');

      Result := False;
    End

    Else If FieldByName('QTDDIS').AsFloat < cdsRequisicao.FieldByName('QTDITE').AsFloat Then
    Begin

      pMensagemOk('A quantidade disponível desse pedido não atende a requisição!');

      Result := False;
    End

    Else if (fCfgSis('VNDPGT', varBoolean)) And fVendaNaoFaturada then
      Result := fPedeSenhaLiberarTrava;
  End;

End;

Function TRequisicaoPedidoCompra.fSelecionaPedidoDisponivel: Boolean;
Begin
  With cdsPedidosDisponiveis Do
  Begin
    Edit;

    If fEmptyStr(FieldByName('AUTREQ').AsString) Then
      FieldByName('AUTREQ').AsString := cdsRequisicao.FieldByName('AUTOINCREM').AsString
    Else
      FieldByName('AUTREQ').AsString := FieldByName('AUTREQ').AsString + ',' + cdsRequisicao.FieldByName('AUTOINCREM').AsString;

    FieldByName('QTDDIS').AsFloat := FieldByName('QTDDIS').AsFloat - cdsRequisicao.FieldByName('QTDITE').AsFloat;
    FieldByName('QTDREQ').AsFloat := FieldByName('QTDREQ').AsFloat + cdsRequisicao.FieldByName('QTDITE').AsFloat;

    Post;

    cdsRequisicao.Edit;
    cdsRequisicao.FieldByName('AUTDET').AsString     := FieldByName('AUTDET').AsString;
    cdsRequisicao.FieldByName('EMPDES_NOV').AsString := FieldByName('EMPDES').AsString;
    cdsRequisicao.FieldByName('TABDET').AsString     := FieldByName('TABDET').AsString;

    // TEM QUE DESMARCAR O PEDIDO CARREGADO SE ESTIVER ASSOCIADO
    cdsRequisicao.FieldByName('MARDES').AsInteger := 0;
    fLock_Unlock(fRetChaveSelecao(cdsRequisicao.FieldByName('AUTOINCREM').AsString), False);

    cdsRequisicao.Post;

    Result := True;
  End;
End;

Function TRequisicaoPedidoCompra.fDesmarcaPedidoDisponivel: Boolean;
  Var
    blnAchou: Boolean;
Begin
  cdsPedidosDisponiveis.Edit;

  cdsPedidosDisponiveis.FieldByName('QTDDIS').AsFloat :=
     cdsPedidosDisponiveis.FieldByName('QTDDIS').AsFloat + cdsRequisicao.FieldByName('QTDITE').AsFloat;

  cdsPedidosDisponiveis.FieldByName('QTDREQ').AsFloat :=
     cdsPedidosDisponiveis.FieldByName('QTDREQ').AsFloat - cdsRequisicao.FieldByName('QTDITE').AsFloat;

  cdsPedidosDisponiveis.FieldByName('AUTREQ').AsString :=
       fRetiraVinculoItem(cdsPedidosDisponiveis.FieldByName('AUTREQ').AsString,
                          cdsRequisicao.FieldByName('AUTOINCREM').AsString, blnAchou);

  (*
  IF fEmptyStr(cdsPedidosDisponiveis.FieldByName('AUTREQ').AsString) tHEN
     fLock_Unlock(fRetChaveSelecao, False, False); *)

  cdsPedidosDisponiveis.Post;

  cdsRequisicao.Edit;
  cdsRequisicao.FieldByName('AUTDET').Clear;
  cdsRequisicao.FieldByName('EMPDES_NOV').Clear;
  cdsRequisicao.FieldByName('TABDET').Clear;
  cdsRequisicao.FieldByName('MARDES').Value := cdsRequisicao.FieldByName('MARANT').Value;
  cdsRequisicao.Post;

  Result := True;
End;

Function TRequisicaoPedidoCompra.fAssociaPedidoCompra: Boolean;
  Var
    qryMovRcd: TUniQuery;
    strSQL: String;
Begin
  Result := False;

  If fEmptyStr(cdsRequisicao.FieldByName('AUTDET').AsString) Then
    Exit;

  Try
    fStartTransaction;

    strSQL := '';
    strSQL := strSQL + ' UPDATE MOVRCD SET ';
    strSQL := strSQL + '   RCD_SEQPCD = :AUTDET ';

    If SameText(cdsRequisicao.FieldByName('TABDET').AsString, 'PCDDET') Then
      strSQL := strSQL + ' , RCD_EMPDES = :EMPDES ';

    strSQL := strSQL + '  WHERE ';
    strSQL := strSQL + '    AUTOINCREM = :AUTREQ; ';

    strSQL := strSQL + '  INSERT INTO PCMIRQ SET ';
    strSQL := strSQL + '    PCM_SEQDET = :AUTDET, ';
    strSQL := strSQL + '    PCM_SEQREQ = :AUTREQ;  ';

    qryMovRcd := fCriaQuery;
    qryMovRcd.SQL.Text := strSQL;

    If SameText(cdsRequisicao.FieldByName('TABDET').AsString, 'PCDDET') Then
      qryMovRcd.ParamByName('EMPDES').AsString := cdsRequisicao.FieldByName('EMPDES_NOV').AsString;

    qryMovRcd.ParamByName('AUTREQ').AsString := cdsRequisicao.FieldByName('AUTOINCREM').AsString;
    qryMovRcd.ParamByName('AUTDET').AsString := cdsRequisicao.FieldByName('AUTDET').AsString;

    qryMovRcd.ExecSQL;

    ProcessaStatusPedidoRequisicaoRCD(cdsRequisicao.FieldByName('AUTOINCREM').AsString);

    If blnRQPDBA Then
    Begin
      strSQL := '';
      strSQL := strSQL + ' INSERT INTO BAIREQ ';
      strSQL := strSQL + ' (BAI_AUTDET, BAI_AUTPED, BAI_AUTREQ, BAI_QTDREQ, AUTOINCREM) ';
      strSQL := strSQL + ' SELECT  ';
      strSQL := strSQL + '   B.BAI_AUTDET, ';
      strSQL := strSQL + '   :AUTDET,      ';
      strSQL := strSQL + '   :AUTREQ,      ';
      strSQL := strSQL + '   :QTDREQ,      ';
      strSQL := strSQL + '   :AUTINC       ';
      strSQL := strSQL + ' FROM            ';
      strSQL := strSQL + '   PCMDET D ';
      strSQL := strSQL + ' INNER JOIN BAIPED B ON B.BAI_AUTPED = D.AUTOINCREM ';
      strSQL := strSQL + ' WHERE   ';
      strSQL := strSQL + '       D.PCD_BAIXAD = 1 ';
      strSQL := strSQL + '   AND D.AUTOINCREM = :AUTDET ';
      strSQL := strSQL + ' LIMIT 1 ';

      qryMovRcd.Close;
      qryMovRcd.SQL.Text := strSQL;
      qryMovRcd.ParamByName('AUTDET').AsString := cdsRequisicao.FieldByName('AUTDET').AsString;
      qryMovRcd.ParamByName('AUTREQ').AsString := cdsRequisicao.FieldByName('AUTOINCREM').AsString;
      qryMovRcd.ParamByName('QTDREQ').AsFloat  := cdsRequisicao.FieldByName('QTDITE').AsFloat;
      qryMovRcd.ParamByName('AUTINC').AsString := fRetAutoIncrem('BAIREQ', VS_strCodEmp);
      qryMovRcd.ExecSQL;
    End;

    If blnConCol Then
    Begin
      strSQL := '';
      strSQL := strSQL + ' INSERT INTO CONCOL (';
      strSQL := strSQL + '   AUTOINCREM, ';
      strSQL := strSQL + '   CON_AUTDET, ';
      strSQL := strSQL + '   CON_NUMPED, ';
      strSQL := strSQL + '   CON_ESPDOC, ';
      strSQL := strSQL + '   CON_CODEMP, ';
      strSQL := strSQL + '   CON_EMPDES, ';
      strSQL := strSQL + '   CON_NUMCTN, ';
      strSQL := strSQL + '   CON_CODITE, ';
      strSQL := strSQL + '   CON_AUTREQ, ';
      strSQL := strSQL + '   CON_ULTALT, ';
      strSQL := strSQL + '   CON_HORALT, ';
      strSQL := strSQL + '   CON_CODOPE, ';
      strSQL := strSQL + '   CON_BAIXAD) ';
      strSQL := strSQL + ' SELECT          ';
      strSQL := strSQL + '   :AUTINC,      ';
      strSQL := strSQL + '   D.AUTOINCREM, ';
      strSQL := strSQL + '   D.PCD_NUMPED, ';
      strSQL := strSQL + '   D.PCD_ESPDOC, ';
      strSQL := strSQL + '   D.PCD_CODEMP, ';
      strSQL := strSQL + '   IFNULL(PCG_EMPDES, D.PCD_CODEMP), ';
      strSQL := strSQL + '   PCD_NUMCTN, ';
      strSQL := strSQL + '   PCD_CODITE, ';
      strSQL := strSQL + '   :AUTREQ,    ';
      strSQL := strSQL + '   CURDATE(),  ';
      strSQL := strSQL + '   CURTIME(),  ';
      strSQL := strSQL + '   :CODOPE,    ';
      strSQL := strSQL + '   "N"         ';
      strSQL := strSQL + ' FROM   ';
      strSQL := strSQL + '   PCMDET D ';

      strSQL := strSQL + ' INNER JOIN PCMGER ON          ';
      strSQL := strSQL + '   PCG_NUMPED = D.PCD_NUMPED AND ';
      strSQL := strSQL + '   PCG_ESPDOC = D.PCD_ESPDOC AND ';
      strSQL := strSQL + '   PCG_CODEMP = D.PCD_CODEMP ';

      strSQL := strSQL + ' LEFT JOIN CONCOL C ON C.CON_AUTREQ = :AUTREQ ';
      strSQL := strSQL + ' WHERE   ';
      strSQL := strSQL + '       C.CON_AUTREQ IS NULL   ';
      strSQL := strSQL + '   AND D.AUTOINCREM = :AUTDET ';

      qryMovRcd.Close;
      qryMovRcd.SQL.Text := strSQL;
      qryMovRcd.ParamByName('AUTDET').AsString := cdsRequisicao.FieldByName('AUTDET').AsString;
      qryMovRcd.ParamByName('AUTREQ').AsString := cdsRequisicao.FieldByName('AUTOINCREM').AsString;
      qryMovRcd.ParamByName('AUTINC').AsString := fRetAutoIncrem('CONCOL', VS_strCodEmp);
      qryMovRcd.ExecSQL;
    End;

    FreeAndNil(qryMovRcd);

    fCommit;

    Result := True;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[TRequisicaoPedidoCompra.fAssociaPedidoCompra]');
    End;
  End;

End;

Procedure TRequisicaoPedidoCompra.pAssociaPedidoCompraRequisicoes;
Begin
  Try
    If Not Assigned(cdsRequisicao) Then
      Exit;

    If Not cdsRequisicao.Active Then
      Exit;

    cdsRequisicao.Filter   := 'AUTDET_CONF <> ' + QuotedStr('');
    cdsRequisicao.Filtered := True;

    cdsRequisicao.First;

    While Not cdsRequisicao.Eof Do
    Begin
      If fAssociaPedidoCompra Then
        cdsRequisicao.Delete
      Else
        cdsRequisicao.Next;
    End;

  Finally
    cdsRequisicao.Filtered := False;
    cdsRequisicao.Filter   := '';
  End;
End;

Procedure TRequisicaoPedidoCompra.pMostraPedidosDisponiveis;
  Var
    frmSelPedidoRequisicao: TfrmSelPedidoRequisicao;
Begin
  If cdsRequisicao.IsEmpty Then
    Exit;

  If Not fCarregaPedidosDisponiveis(cdsRequisicao.FieldByName('CODITE').AsString) Then
    Exit;

  Try
    cdsPedidosDisponiveis.Filter   := '(CODITE = ' + QuotedStr(cdsRequisicao.FieldByName('CODITE').AsString) + ')';

    cdsPedidosDisponiveis.Filtered := True;

    If cdsPedidosDisponiveis.IsEmpty Then
    Begin
      pMensagemOk('Não há pedidos de compra disponíveis para esse produto!');
      Exit;
    End;

    pCriarFormularios(TfrmSelPedidoRequisicao, frmSelPedidoRequisicao);

    frmSelPedidoRequisicao.objRequisicao := Self;
    frmSelPedidoRequisicao.dtsRequisicao.DataSet := cdsRequisicao;
    frmSelPedidoRequisicao.cxvPedidos.DataController.DataSource := cdsPedidosDisponiveis.dtsSource;

    If frmSelPedidoRequisicao.ShowModal = mrOk Then
    Begin

      If frmSelPedidoRequisicao.blnAlterouDados Then
        blnAlterouDados := True;

    End Else
    Begin

    End;

  Finally
    cdsPedidosDisponiveis.Filtered := False;
    pFreeAndNil(frmSelPedidoRequisicao);
  End;

End;

Function TRequisicaoPedidoCompra.fNegaRequisicoesMotivoNaoVaiComprar(cdsRequisicao: TZClient; blnComTransacao: Boolean = True): Boolean;
  Var
    qryFatGor,
    qryMovRcd     : TUniQuery;
    strPedAnt,
    strEspPed,
    strEmpPed     : String;
    stlMensag     : TStringList;
    objMensag     : TMsgInterna;
    blnIniciouMsg,
    blnExiSta : Boolean;
    blnGravarDEL_MOVRCD: Boolean;

   procedure pIncluiOperadorNegou;
   Begin
     //                       1         2         3         4         5          6
     //               12345678901234567890123456789012345678901234567890123456789012345
     stlMensag.Add('|-------------------------------------------------------------------|');
     stlMensag.Add('| ' + fPadR('Operador que negou: ' + strLoginUsuarioLogado + ' - ' + fRetNomeOperador(strLoginUsuarioLogado), 65) + ' |');
     stlMensag.Add('.-------------------------------------------------------------------.');
   End;

   Function fEnviaMensagem: Boolean;
   begin
     Result := True;

     If blnIniciouMsg Then
     Begin
       pIncluiOperadorNegou;

       Result := objMensag.fEnviaMensagem(MSG_ASSUNTO_REQUISICAO_NEGADA,
                                stlMensag.Text,
                                strLoginUsuarioLogado,
                                qryFatGor.FieldByName('FGO_CODVEN').AsString,
                                'N',
                                '');

       stlMensag.Clear;
       blnIniciouMsg := False;
     End;

   End;

   Function fSQLPedidoVenda: String;
     Var
       strSQL: String;
   Begin
     strSQL := '';
     strSQL := strSQL + ' SELECT ';

     strSQL := strSQL + '   FGO_CODEMP, ';
     strSQL := strSQL + '   FGO_NUMDOC, ';
     strSQL := strSQL + '   FGO_ESPDOC, ';

     strSQL := strSQL + '   CONCAT(FGO_CODCLI, "-", CLI_NOMCLI) AS NOMCLI, ';

     strSQL := strSQL + '   FGO_CODVEN, ';
     strSQL := strSQL + '   FGO_DTAENT, ';
     strSQL := strSQL + '   FGO_CODCND, ';
     strSQL := strSQL + '   CND_DESCRI, ';
     strSQL := strSQL + '   FGO_CONPAG, ';
     strSQL := strSQL + '   FGO_CODFPG, ';
     strSQL := strSQL + '   FPG_DESCRI, ';
     strSQL := strSQL + '   FGO_VLRCON  ';

     strSQL := strSQL + ' FROM ';
     strSQL := strSQL + '   FATGOR ';

     strSQL := strSQL + ' LEFT JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI ';

     strSQL := strSQL + ' LEFT JOIN CADCND ON CND_CODIGO = FGO_CODCND ';

     strSQL := strSQL + ' LEFT JOIN CADFPG ON FPG_CODIGO = FGO_CODFPG ';

     strSQL := strSQL + ' WHERE ';

     strSQL := strSQL + '   FGO_CODEMP = :CODEMP AND ';
     strSQL := strSQL + '   FGO_NUMDOC = :NUMDOC AND ';
     strSQL := strSQL + '   FGO_ESPDOC = :ESPDOC     ';

     Result := strSQL;
   End;

   procedure pIncluiReqNegada;
     Var
       intContador: Integer;
       stlLista: TStringList;
       ItensNotificacaoReqNegada: TItemNotificacaoReqNegada;
   Begin
    If fEmptyStr(cdsRequisicao.FieldByName('DOCPDV').AsString) Then
    begin
      if not (cdsRequisicao.FieldByName('OPE_MSGRCN').AsString = 'S') then
        exit;

      ItensNotificacaoReqNegada.codReq     := fPadR(cdsRequisicao.FieldByName('CODREQ').AsString,10)+' | ';
      ItensNotificacaoReqNegada.DtCadastro := fPadR(cdsRequisicao.FieldByName('DTACAD').AsString,13)+' | ';
      ItensNotificacaoReqNegada.cliente    := fPadR(cdsRequisicao.FieldByName('NOMCLI').AsString,24)+' | ';
      ItensNotificacaoReqNegada.item       := fPadR(cdsRequisicao.FieldByName('PRODUT').AsString,24)+' | ';
      ItensNotificacaoReqNegada.referencia := fPadR(cdsRequisicao.FieldByName('REFERE').AsString,14)+' | ';
      ItensNotificacaoReqNegada.qtdeReq    := fPadR(cdsRequisicao.FieldByName('QTDITE').AsString,15)+' | ';
      ItensNotificacaoReqNegada.codEmp     := fPadR(cdsRequisicao.FieldByName('CODEMP').AsString,8)+' | ';
      ItensNotificacaoReqNegada.Motivo     := cdsRequisicao.FieldByName('JUSTIF').AsString;
      objGerenciaNotificacaoReqNegada.pAdicionaItem(cdsRequisicao.FieldByName('NOMOPE').AsString,
                                                    cdsRequisicao.FieldByName('CODVEN').AsString,
                                                    ItensNotificacaoReqNegada);


    end
    else
    Begin
     If Not blnIniciouMsg Then
     With qryFatGor Do
     Begin
       Close;
       ParamByName('CODEMP').AsString := cdsRequisicao.FieldByName('EMPPDV').AsString;
       ParamByName('NUMDOC').AsString := cdsRequisicao.FieldByName('DOCPDV').AsString;
       ParamByName('ESPDOC').AsString := cdsRequisicao.FieldByName('ESPPDV').AsString;
       Open;

       If IsEmpty Then
         Exit;

//     .-------------------------------------------------------------------.
//     |     Requisição de compra negada pelo Departamento de Compras      |
//     |-------------------------------------------------------------------|
//     | Pedido Venda: 123456789012-PD-001          Dt.Emissao: 99/99/9999 |
//     | Vendedor    : 999-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX |
//     | Cond.Pagto  : 99-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX |
//     |               (99)123.123.123.123.123.123.123.123.123.123.123.123 |
//     | Forma Pagto : 99-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX |
//     | Vr.Pedido   : 9.999.999,99                                        |
//     |-------------------------------------------------------------------|
//     | Produtos:                                                         |

       stlMensag.Add('.-------------------------------------------------------------------.');
       stlMensag.Add('|     Requisição de compra negada pelo Departamento de Compras      |');
       stlMensag.Add('|-------------------------------------------------------------------|');

       stlMensag.Add('| ' + fPadR('Pedido Venda: ' + FieldByName('FGO_NUMDOC').AsString + '-' +
                                                     FieldByName('FGO_ESPDOC').AsString + '-' +
                                                     FieldByName('FGO_CODEMP').AsString +
                          '  Data Emissão : ' + IIF(FieldByName('FGO_DTAENT').IsNull, '', FormatDateTime('DD/MM/YYYY', FieldByName('FGO_DTAENT').AsDateTime)), 65)  + ' |');

       stlMensag.Add('| ' + fPadR('     Cliente: ' + FieldByName('NOMCLI').AsString, 65) + ' |');

       If Not fEmptyStr(FieldByName('FGO_CODCND').AsString) Then
       Begin
         stlMensag.Add('| ' + fPadR('Cond.Pagto  : ' + FieldByName('FGO_CODCND').AsString + '-' + FieldByName('CND_DESCRI').AsString, 65) + ' |');
         stlMensag.Add('| ' + fPadR('              ' + fFormataCondPag(FieldByName('FGO_CONPAG').AsString), 65) + ' |');
       End Else
       Begin
         stlMensag.Add('| ' + fPadR('Cond.Pagto  : ' + fFormataCondPag(FieldByName('FGO_CONPAG').AsString), 65) + ' |');
       End;

       stlMensag.Add('| ' + fPadR('Forma Pagto : ' + FieldByName('FGO_CODFPG').AsString + '-' + FieldByName('FPG_DESCRI').AsString, 65) + ' |');

       stlMensag.Add('| ' + fPadR('Vr.Pedido   : ' + FormatFloat('#,##0.00', FieldByName('FGO_VLRCON').AsFloat), 65) + ' |');

       stlMensag.Add('|-------------------------------------------------------------------|');
       stlMensag.Add('| Produtos:                                                         |');

       blnIniciouMsg := True;
     End;

     //                       1         2         3         4         5
     //              12345678901234567890123456789012345678901234567890123456789
     //      | 12345-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX |
     //      | Qtd: 999.999,99 UN                                                |

     With cdsRequisicao Do
     Begin
       stlMensag.Add('|                                                                   |');
       stlMensag.Add('| ' + fPadR(FieldByName('PRODUT').AsString, 65) + ' |');
       stlMensag.Add('| Requisição ' + FieldByName('CODREQ').AsString + ' - Qtd: ' + fPadL(FormatFloat('#,##0.00', FieldByName('QTDITE').AsFloat), 12) + '   UN: ' + fPadR( FieldByName('SIGUNI').AsString, 21)  + ' |');
       stlMensag.Add('| Justificativa:                                                    |');

       stlLista      := TStringList.Create;
       stlLista.Text := FieldByName('JUSTIF').AsString;

       For intContador := 0 To stlLista.Count - 1 Do
         stlMensag.Add('| ' + fPadR(stlLista[intContador], 65) + ' |');

       stlMensag.Add('|                                                                   |');

       FreeAndNil(stlLista);
     End;

   End;

  End;

Begin

  Result := True;

  If (Not Assigned(cdsRequisicao)) Then
    Exit;

  blnExiSta := fCfgSis('EXISTA', VarBoolean);

  blnGravarDEL_MOVRCD := Not blnExiSta;

  With cdsRequisicao Do
  Try

    Filter := 'NEGADA = 1 AND MOTNEG = 0';
    Filtered := True;

    If Not IsEmpty Then
    Begin

      stlMensag     := TStringList.Create;
      objMensag     := TMsgInterna.Create(Nil);
      blnIniciouMsg := False;

      qryMovRcd := fCriaQuery;
      qryFatGor := fCriaQuery;
      qryFatGor.SQL.Text := fSQLPedidoVenda;

      IndexFieldNames := 'DOCPDV;CODREQ;CODITE';

      First;

      Try

        If blnComTransacao Then
          fStartTransaction;

        strPedAnt := '';
        strEmpPed := '';
        strEspPed := '';

        While Not Eof Do
        Begin

          pIncluiReqNegada;

          fExecutaSQL('UPDATE MOVRCD SET RCD_REQNEG = "S", RCD_MOTNEG = 0, RCD_SEQPCD = (NULL) WHERE AUTOINCREM = ' + QuotedStr(FieldByName('AUTOINCREM').AsString) + ';');

          If blnGravarDEL_MOVRCD Then
          Begin
            GravarDEL_MOVRCG(FieldByName('CODREQ').AsString);
            GravarDEL_MOVRCD(FieldByName('AUTOINCREM').AsString);
          End;

          qryMovRcd.Close;
          qryMovRcd.SQL.Clear;
          qryMovRcd.SQL.Add('DELETE FROM PCMIRQ WHERE PCM_SEQREQ = ' + QuotedStr(FieldByName('AUTOINCREM').AsString) + ';');
          {Quando utiliza CFG_EXISTA, não deve excluir a requisição, pois o robô precisa do registro para ajustar a mensagem na expedição, req 253928}

          If blnGravarDEL_MOVRCD Then
            qryMovRcd.SQL.Add('DELETE FROM MOVRCD WHERE AUTOINCREM = ' + QuotedStr(FieldByName('AUTOINCREM').AsString)+ ';');

          qryMovRcd.ExecSQL;

          strPedAnt := FieldByName('DOCPDV').AsString;
          strEmpPed := FieldByName('EMPPDV').AsString;
          strEspPed := FieldByName('ESPPDV').AsString;

          If (tpoOperacao = tpoPainel) Then
            fLock_Unlock(fRetChaveSelecao(cdsRequisicao.FieldByName('AUTOINCREM').AsString), False, False);

          Next;

          If (strPedAnt <> FieldByName('DOCPDV').AsString) Or (Eof) Then
          Begin

            stlMensag.Add('|-------------------------------------------------------------------|');

            If (VS_strHabilitarCRM) Then
              TUpdateOccurrenceCRM.New()
                .NumDoc(strPedAnt)
                .EspDoc(strEspPed)
                .CodEmp(strEmpPed)
                .AcaFat(afcReqCompraNaoVaiComprar)
                .Descri(stlMensag.Text)
                .pRun();

            Result := fEnviaMensagem;

            If Not Result Then
              Break;

          End;

        End;
        objGerenciaNotificacaoReqNegada.pEnviaNotificacoes;
        If blnComTransacao Then
        Begin
          If Result Then
          begin

            fCommit;

            First;
            While Not Eof Do
              Delete;

          End Else
            fRollBack;
        End;

      Except

        On E: Exception Do
        Begin
          fRollBack;
          Result := False;
          pMensagensErro(E.Message, '[]');
        End;

      End;

      FreeAndNil(qryMovRcd);
      FreeAndNil(qryFatGor);

      FreeAndNil(stlMensag);
      FreeAndNil(objMensag);

    End;

  Finally
    Filtered := False;
  End;

End;

Function TRequisicaoPedidoCompra.fNegaRequisicoesMotivoPossuiEstoque(cdsRequisicao: TZClient; blnComTransacao: Boolean = True): Boolean;
  Var
    qryFatGor,
    qryMovRcd: TUniQuery;
    strPedAnt,
    strEspPed,
    strEmpPed,
    strCodAnt: String;
    stlMensag: TStringList;
    objMensag: TMsgInterna;
    blnIniciouMsg: Boolean;

   procedure pExcluiPrepaRQ(strCodReq, strCodEmp, strCodIte: String; fltQtdIte: Double);
     Var
       qryDel: TUniQuery;
   begin
     qryDel := fCriaQuery;
     Try
       qryDel.SQL.Text := ' DELETE FROM PREPRQ WHERE PRQ_CODREQ = :CODREQ AND ' +
         'PRQ_EMPREQ = :EMPREQ AND PRQ_CODITE = :CODITE AND PRQ_QTDITE = :QTDITE ';
       qryDel.ParamByName('CODREQ').AsString := strCodReq;
       qryDel.ParamByName('EMPREQ').AsString := strCodEmp;
       qryDel.ParamByName('CODITE').AsString := strCodIte;
       qryDel.ParamByName('QTDITE').AsFloat  := fltQtdIte;
       qryDel.ExecSQL;
     Finally
      qryDel.Free;
     End;
   end;

   Procedure pExcluiMasterReq;
   Begin
     qryMovRcd.Close;
     qryMovRcd.SQL.Text := ' SELECT COUNT(1) AS CNT FROM MOVRCG                WHERE RCG_CODEMP = ' + QuotedStr(VS_strCodEmp) +
                           ' AND RCG_CODIGO = ' + QuotedStr(strCodAnt) +
                           ' AND (SELECT COUNT(*) FROM MOVRCD WHERE RCD_CODEMP = ' + QuotedStr(VS_strCodEmp) +
                           ' AND RCD_CODIGO = ' + QuotedStr(strCodAnt) + ') = 0 ';
     qryMovRcd.Open;
     If qryMovRcd.FieldByName('CNT').AsInteger > 0 Then
       GravarDEL_MOVRCG(strCodAnt);

     qryMovRcd.Close;
     qryMovRcd.SQL.Text := 'DELETE FROM MOVRCG                WHERE RCG_CODEMP = ' + QuotedStr(VS_strCodEmp) +
                           ' AND RCG_CODIGO = ' + QuotedStr(strCodAnt) +
                           ' AND (SELECT COUNT(*) FROM MOVRCD WHERE RCD_CODEMP = ' + QuotedStr(VS_strCodEmp) +
                           ' AND RCD_CODIGO = ' + QuotedStr(strCodAnt) + ') = 0 ';
     qryMovRcd.ExecSQL;

     If qryMovRcd.RowsAffected > 0 Then
     Begin
       qryMovRcd.Close;
       qryMovRcd.SQL.Clear;
       qryMovRcd.SQL.Add('DELETE FROM PREPRQ');
       qryMovRcd.SQL.Add('WHERE PRQ_CODREQ = :CODIGO AND PRQ_EMPREQ = :CODEMP');

       qryMovRcd.ParamByName('CODIGO').AsString := strCodAnt;
       qryMovRcd.ParamByName('CODEMP').AsString := VS_strCodEmp;

       qryMovRcd.ExecSQL;
     End;
   End;

   procedure pIncluiOperadorNegou;
   Begin
     //                       1         2         3         4         5          6
     //               12345678901234567890123456789012345678901234567890123456789012345
     stlMensag.Add('|-------------------------------------------------------------------|');
     stlMensag.Add('| ' + fPadR('Operador que negou: ' + strLoginUsuarioLogado + ' - ' + fRetNomeOperador(strLoginUsuarioLogado), 65) + ' |');
     stlMensag.Add('.-------------------------------------------------------------------.');
   End;

   Function fEnviaMensagem: Boolean;
   begin
     Result := True;

     If blnIniciouMsg Then
     Begin
       pIncluiOperadorNegou;

       Result := objMensag.fEnviaMensagem(MSG_ASSUNTO_REQUISICAO_NEGADA,
                                stlMensag.Text,
                                strLoginUsuarioLogado,
                                qryFatGor.FieldByName('FGO_CODVEN').AsString,
                                'N',
                                '');

       stlMensag.Clear;
       blnIniciouMsg := False;
     End;

   End;

   Function fSQLPedidoVenda: String;
     Var
       strSQL: String;
   Begin
     strSQL := '';
     strSQL := strSQL + ' SELECT ';

     strSQL := strSQL + '   FGO_CODEMP, ';
     strSQL := strSQL + '   FGO_NUMDOC, ';
     strSQL := strSQL + '   FGO_ESPDOC, ';

     strSQL := strSQL + '   CONCAT(FGO_CODCLI, "-", CLI_NOMCLI) AS NOMCLI, ';

     strSQL := strSQL + '   FGO_CODVEN, ';
     strSQL := strSQL + '   FGO_DTAENT, ';
     strSQL := strSQL + '   FGO_CODCND, ';
     strSQL := strSQL + '   CND_DESCRI, ';
     strSQL := strSQL + '   FGO_CONPAG, ';
     strSQL := strSQL + '   FGO_CODFPG, ';
     strSQL := strSQL + '   FPG_DESCRI, ';
     strSQL := strSQL + '   FGO_VLRCON  ';

     strSQL := strSQL + ' FROM ';
     strSQL := strSQL + '   FATGOR ';

     strSQL := strSQL + ' LEFT JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI ';

     strSQL := strSQL + ' LEFT JOIN CADCND ON CND_CODIGO = FGO_CODCND ';

     strSQL := strSQL + ' LEFT JOIN CADFPG ON FPG_CODIGO = FGO_CODFPG ';

     strSQL := strSQL + ' WHERE ';

     strSQL := strSQL + '   FGO_CODEMP = :CODEMP AND ';
     strSQL := strSQL + '   FGO_NUMDOC = :NUMDOC AND ';
     strSQL := strSQL + '   FGO_ESPDOC = :ESPDOC     ';

     Result := strSQL;
   End;

   procedure pIncluiReqNegada;
     Var
       intContador: Integer;
       stlLista: TStringList;
   Begin
     With cdsRequisicao Do
     If fEmptyStr(FieldByName('DOCPDV').AsString) Then
       Exit;

     If Not blnIniciouMsg Then
     With qryFatGor Do
     Begin
       Close;
       ParamByName('CODEMP').AsString := cdsRequisicao.FieldByName('EMPPDV').AsString;
       ParamByName('NUMDOC').AsString := cdsRequisicao.FieldByName('DOCPDV').AsString;
       ParamByName('ESPDOC').AsString := cdsRequisicao.FieldByName('ESPPDV').AsString;
       Open;

       If IsEmpty Then
         Exit;

//     .-------------------------------------------------------------------.
//     |     Requisição de compra negada pelo Departamento de Compras      |
//     |-------------------------------------------------------------------|
//     | Pedido Venda: 123456789012-PD-001          Dt.Emissao: 99/99/9999 |
//     | Vendedor    : 999-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX |
//     | Cond.Pagto  : 99-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX |
//     |               (99)123.123.123.123.123.123.123.123.123.123.123.123 |
//     | Forma Pagto : 99-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX |
//     | Vr.Pedido   : 9.999.999,99                                        |
//     |-------------------------------------------------------------------|
//     | Produtos:                                                         |

       stlMensag.Add('.-------------------------------------------------------------------.');
       stlMensag.Add('|   Requisição de compra negada - Produto(s) com saldo em estoque   |');
       stlMensag.Add('|-------------------------------------------------------------------|');

       stlMensag.Add('| ' + fPadR('Pedido Venda: ' + FieldByName('FGO_NUMDOC').AsString + '-' +
                                                     FieldByName('FGO_ESPDOC').AsString + '-' +
                                                     FieldByName('FGO_CODEMP').AsString +
                          '  Data Emissão : ' + IIF(FieldByName('FGO_DTAENT').IsNull, '', FormatDateTime('DD/MM/YYYY', FieldByName('FGO_DTAENT').AsDateTime)), 65)  + ' |');

       stlMensag.Add('| ' + fPadR('     Cliente: ' + FieldByName('NOMCLI').AsString, 65) + ' |');

       If Not fEmptyStr(FieldByName('FGO_CODCND').AsString) Then
       Begin
         stlMensag.Add('| ' + fPadR('Cond.Pagto  : ' + FieldByName('FGO_CODCND').AsString + '-' + FieldByName('CND_DESCRI').AsString, 65) + ' |');
         stlMensag.Add('| ' + fPadR('              ' + fFormataCondPag(FieldByName('FGO_CONPAG').AsString), 65) + ' |');
       End Else
       Begin
         stlMensag.Add('| ' + fPadR('Cond.Pagto  : ' + fFormataCondPag(FieldByName('FGO_CONPAG').AsString), 65) + ' |');
       End;

       stlMensag.Add('| ' + fPadR('Forma Pagto : ' + FieldByName('FGO_CODFPG').AsString + '-' + FieldByName('FPG_DESCRI').AsString, 65) + ' |');

       stlMensag.Add('| ' + fPadR('Vr.Pedido   : ' + FormatFloat('#,##0.00', FieldByName('FGO_VLRCON').AsFloat), 65) + ' |');

       stlMensag.Add('|-------------------------------------------------------------------|');
       stlMensag.Add('| Produtos:                                                         |');

       blnIniciouMsg := True;
     End;

     //                       1         2         3         4         5
     //              12345678901234567890123456789012345678901234567890123456789
     //      | 12345-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX |
     //      | Qtd: 999.999,99 UN                                                |

     With cdsRequisicao Do
     Begin
       stlMensag.Add('|                                                                   |');
       stlMensag.Add('| ' + fPadR(FieldByName('PRODUT').AsString, 65) + ' |');
       stlMensag.Add('| Requisição ' + FieldByName('CODREQ').AsString + ' - Qtd: ' + fPadL(FormatFloat('#,##0.00', FieldByName('QTDITE').AsFloat), 12) + '   UN: ' + fPadR( FieldByName('SIGUNI').AsString, 21)  + ' |');
       stlMensag.Add('| Justificativa:                                                    |');

       stlLista      := TStringList.Create;
       stlLista.Text := FieldByName('JUSTIF').AsString;

       For intContador := 0 To stlLista.Count - 1 Do
         stlMensag.Add('| ' + fPadR(stlLista[intContador], 65) + ' |');

       stlMensag.Add('|                                                                   |');


       FreeAndNil(stlLista);
     End;

   End;

Begin

  Result := True;

  If (Not Assigned(cdsRequisicao)) Then
    Exit;

  With cdsRequisicao Do
  Try

    Filter := 'NEGADA = 1 AND MOTNEG = 1';
    Filtered := True;

    If Not IsEmpty Then
    Begin

      stlMensag := TStringList.Create;
      objMensag := TMsgInterna.Create(Nil);
      blnIniciouMsg := False;

      qryMovRcd := fCriaQuery;
      qryFatGor := fCriaQuery;
      qryFatGor.SQL.Text := fSQLPedidoVenda;

      strCodAnt := FieldByName('CODREQ').AsString;
      IndexFieldNames := 'DOCPDV;CODREQ;CODITE';

      First;

      Try

        If blnComTransacao Then
          fStartTransaction;

        strCodAnt := '';
        strPedAnt := '';
        strEmpPed := '';
        strEspPed := '';

        While Not Eof Do
        Begin
          fExecutaSQL('UPDATE MOVRCD SET RCD_REQNEG = "S", RCD_MOTNEG = 1, RCD_SEQPCD = (NULL) WHERE AUTOINCREM = ' + QuotedStr(FieldByName('AUTOINCREM').AsString) + ';');

          GravarDEL_MOVRCD(FieldByName('AUTOINCREM').AsString);

          pIncluiReqNegada;

          pExcluiPrepaRQ(FieldByName('CODREQ').AsString,
                         FieldByName('CODEMP').AsString,
                         FieldByName('CODITE').AsString,
                         FieldByName('QTDORI').AsFloat);


          qryMovRcd.Close;
          qryMovRcd.SQL.Text := 'DELETE FROM MOVRCD WHERE AUTOINCREM = ' + QuotedStr(FieldByName('AUTOINCREM').AsString);
          qryMovRcd.ExecSQL;

          If (tpoOperacao = tpoPainel) Then
           fLock_Unlock(fRetChaveSelecao(cdsRequisicao.FieldByName('AUTOINCREM').AsString), False, False);

          strCodAnt := FieldByName('CODREQ').AsString;
          strPedAnt := FieldByName('DOCPDV').AsString;
          strEmpPed := FieldByName('EMPPDV').AsString;
          strEspPed := FieldByName('ESPPDV').AsString;

          Next;

          If (strCodAnt <> FieldByName('CODREQ').AsString) Or (Eof) Then
            pExcluiMasterReq;

          If (strPedAnt <> FieldByName('DOCPDV').AsString) Or (Eof) Then
          Begin

            stlMensag.Add('|-------------------------------------------------------------------|');

            If (VS_strHabilitarCRM) Then
              TUpdateOccurrenceCRM.New()
                .NumDoc(strPedAnt)
                .EspDoc(strEspPed)
                .CodEmp(strEmpPed)
                .AcaFat(afcReqCompraPossuiEstoque)
                .Descri(stlMensag.Text)
                .strNomFrm('[TRequisicaoPedidoCompra.fNegaRequisicoesMotivoPossuiEstoque]')
                .pRun();

            Result := fEnviaMensagem;

            If Not Result Then
              Break;

          End;

        End;

        If blnComTransacao Then
        Begin
          If Result Then
          begin
            fCommit;

            First;
            While Not Eof Do
              Delete;

          End Else
            fRollBack;
        End;

      Except

        On E: Exception Do
        Begin
          fRollBack;
          Result := False;
          pMensagensErro(E.Message, '[]');
        End;

      End;

      FreeAndNil(qryMovRcd);
      FreeAndNil(qryFatGor);

      FreeAndNil(stlMensag);
      FreeAndNil(objMensag);
    End; {If Not IsEmpty Then}

  Finally
    Filtered := False;
  End;

End;

Class Procedure TRequisicaoPedidoCompra.pCarregaRequisicoesPedido(qryDados: TUniQuery; strLisPed: String);
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT     ';
  strSQL := strSQL + '   CONCAT(PCG_NUMPED, "-", PCG_CODEMP) AS NUMPED,              ';
  strSQL := strSQL + '   GROUP_CONCAT(CONCAT(RCD_CODIGO, "-", RCD_CODEMP)) AS NUMRCD ';
  strSQL := strSQL + ' FROM       ';
  strSQL := strSQL + '   PCMGER G ';

  strSQL := strSQL + ' INNER JOIN PCMDET D ON PCG_NUMPED = PCD_NUMPED AND ';
  strSQL := strSQL + '                        PCG_CODEMP = PCD_CODEMP AND ';
  strSQL := strSQL + '                        PCG_ESPDOC = PCD_ESPDOC AND ';
  strSQL := strSQL + '                        PCG_NUMCTN = PCD_NUMCTN     ';

  strSQL := strSQL + ' INNER JOIN MOVRCD   ON RCD_SEQPCD = D.AUTOINCREM   ';

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   PCD_BAIXAD = 0 AND                                                                               ';
  strSQL := strSQL + '   RCD_QTDITE > IFNULL(PCD_QTDBAI, 0) * IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA) AND ';
  strSQL := strSQL + '   G.AUTOINCREM IN (' + strLisPed + ')';

  strSQL := strSQL + '   AND RCD_QTDITE - IFNULL((SELECT SUM(BAI_QTDREQ) FROM BAIREQ WHERE BAI_AUTREQ = MOVRCD.AUTOINCREM), 0) > 0 ';

  strSQL := strSQL + ' GROUP BY G.AUTOINCREM ';

  qryDados.SQL.Text := strSQL;

  qryDados.Open;
End;

Class Function TRequisicaoPedidoCompra.fTravaRequisicoes(strAutInc: String; objLock: TLock): Boolean;
  Var
    strSQL: String;
    qryDados: TUniQuery;
Begin
  Result := True;

  strSQL := '';
  strSQL := strSQL + ' SELECT     ';
  strSQL := strSQL + '   M.AUTOINCREM, ';
  strSQL := strSQL + '   M.RCD_CODEMP, ';
  strSQL := strSQL + '   M.RCD_CODIGO  ';
  strSQL := strSQL + ' FROM       ';
  strSQL := strSQL + '   PCMGER G ';

  strSQL := strSQL + ' INNER JOIN PCMDET D ON PCG_NUMPED = PCD_NUMPED AND ';
  strSQL := strSQL + '                        PCG_CODEMP = PCD_CODEMP AND ';
  strSQL := strSQL + '                        PCG_ESPDOC = PCD_ESPDOC AND ';
  strSQL := strSQL + '                        PCG_NUMCTN = PCD_NUMCTN     ';

  strSQL := strSQL + ' INNER JOIN MOVRCD M ON RCD_SEQPCD = D.AUTOINCREM   ';

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   PCD_BAIXAD = 0 AND                                                                               ';
  strSQL := strSQL + '   RCD_QTDITE > IFNULL(PCD_QTDBAI, 0) * IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA) AND ';
  strSQL := strSQL + '   G.AUTOINCREM = ' +  QuotedStr(strAutInc);

  strSQL := strSQL + '   AND RCD_QTDITE - IFNULL((SELECT SUM(BAI_QTDREQ) FROM BAIREQ WHERE BAI_AUTREQ = M.AUTOINCREM), 0) > 0 ';

  qryDados := fCriaQuery;
  qryDados.SQL.Text := strSQL;

  qryDados.Open;

  While Not qryDados.Eof Do
  Begin

    Result := fLock_Unlock(fRetChaveSelecao(qryDados.FieldByName('AUTOINCREM').AsString), True, False);

    If Not Result Then
    Begin
      pMensagemOk('A requisição ' + qryDados.FieldByName('RCD_CODIGO').AsString + '-' + qryDados.FieldByName('RCD_CODEMP').AsString +
                  ' está sendo utilizada em outra estação por ' +
                  fGetHostLock(fRetChaveSelecao(qryDados.FieldByName('AUTOINCREM').AsString))  + '!');

      Break;
    End;

    objLock.pAdicionaTrava(fRetChaveSelecao(qryDados.FieldByName('AUTOINCREM').AsString));

    qryDados.Next;
  End;

  FreeAndNil(qryDados);
End;

Procedure TRequisicaoPedidoCompra.pGeraOcorrenciasDesvinculo;
  Var
    strPedido,
    strItens,
    strIndex: String;
Begin
  With cdsRequisicao Do
  Try
    strIndex := IndexFieldNames;

    Filter   := 'SEQPCD IS NOT NULL AND MARDES = 0';
    Filtered := True;

    If Not IsEmpty Then
    Begin

      IndexFieldNames := 'DOCPDV;ESPPDV;EMPPDV;CODITE';

      First;

      strPedido := (FieldByName('DOCPDV').AsString + FieldByName('ESPPDV').AsString + FieldByName('EMPPDV').AsString);

      While Not Eof Do
      Begin

        If strPedido <> (FieldByName('DOCPDV').AsString + FieldByName('ESPPDV').AsString + FieldByName('EMPPDV').AsString) Then
        Begin
          pGeraOcorrenciaDesvinculo(FieldByName('DOCPDV').AsString,
                                    FieldByName('ESPPDV').AsString,
                                    FieldByName('EMPPDV').AsString,
                                    'REQUISIÇÕES DESVINCULADAS DO PEDIDO DE COMRA ' + FstrNumPed + '-' + FstrCodEmp + ':<<csq>>' +
                                    strItens);

          strItens := '';

          strPedido := (FieldByName('DOCPDV').AsString + FieldByName('ESPPDV').AsString + FieldByName('EMPPDV').AsString);
        End;

        strItens := strItens + '<<csq>>' +
         'REQUISIÇÃO ' + FieldByName('CODREQ').AsString + '-' + FieldByName('CODEMP').AsString + '<<csq>>' +
         'PRODUTO ' + FieldByName('CODITE').AsString + '-' + FieldByName('DESITE').AsString + ',  QUANTIDADE: ' + FormatFloat('#,##0.00', FieldByName('QTDITE').AsFloat) + '<<csq>>';

        Next;
      End;

      pGeraOcorrenciaDesvinculo(FieldByName('DOCPDV').AsString,
                                FieldByName('ESPPDV').AsString,
                                FieldByName('EMPPDV').AsString,
                                FstrNumPed + '-' + FstrCodEmp + ':<<csq>>' +
                                'COMPRADOR: ' + strCodCmp + fRetNomeOperador(strCodCmp) + '<<csq>>' +  '<<csq>>' +
                                strItens);

    End; {If Not IsEmpty Then}

  Finally
    Filtered := False;
    IndexFieldNames := strIndex;
  End;
End;

Procedure TRequisicaoPedidoCompra.pGeraOcorrenciaDesvinculo(strPedVen, strEspVen, strEmpVen, strMensagem: String);
Begin
  TUpdateOccurrenceCRM.New()
    .NumDoc(strPedVen)
    .EspDoc(strEspVen)
    .CodEmp(strEmpVen)
    .AcaFat(afcReqCompraDesvinculada)
    .Descri(strMensagem)
    .strNomFrm('[TRequisicaoPedidoCompra.pGeraOcorrenciaDesvinculo]')
    .pRun();
End;

Function TRequisicaoPedidoCompra.fAlteradaEmOutraEstacao(strAutInc: String; blnDarMsgErro: Boolean): Boolean;
Begin
  Result := False;

  qryJaTemPedido.Close;
  qryJaTemPedido.ParamByName('AUTINC').AsString := strAutInc;
  qryJaTemPedido.Open;

  If qryJaTemPedido.IsEmpty Then
    Exit;

  If qryJaTemPedido.FieldByName('RCD_REQNEG').AsString = 'S' Then
  Begin
    If blnDarMsgErro Then
      pMensagemOk('Essa requisição já se encontra negada!');

    Result := True;
  End;

  If qryJaTemPedido.FieldByName('RCD_ATETRA').AsInteger = 1 Then
  Begin
    If blnDarMsgErro Then
      pMensagemOk('Essa requisição já foi atendida por transferência!');

    Result := True;
  End;

  If Not fEmptyStr(qryJaTemPedido.FieldByName('RCD_SEQPCD').AsString) Then
  Begin
    Result := True;

    qryBuscaPedido.Close;
    qryBuscaPedido.ParamByName('AUTINC').AsString := qryJaTemPedido.FieldByName('RCD_SEQPCD').AsString;
    qryBuscaPedido.Open;

    If blnDarMsgErro Then
      pMensagemOk('Essa requisição já está vinculada ao Pedido de Compra: ' + qryBuscaPedido.FieldByName('NUMPED').AsString + '!');

  End;
End;

Function TRequisicaoPedidoCompra.fPossuiColeta(strCodIte: String): Boolean;
Begin
  If Not Assigned(qryColeta) Then
  Begin
    Result := False;
    Exit;
  End;

  If Not qryColeta.Active Then
  Begin
    Result := False;
    Exit;
  End;

  Result := qryColeta.Locate('CON_CODITE', strCodIte, []);
End;

Function TRequisicaoPedidoCompra.fPodeMarcarDesmarcarRequisicao(blnDarMsgErro, blnTestarNegada: Boolean): Boolean;
Begin
  Result := False;

  With cdsRequisicao Do
  Begin

    If blnTestarNegada And (FieldByName('MARDES').AsInteger = 0) And (FieldByName('NEGADA').AsInteger = 1) Then
    Begin
      If blnDarMsgErro Then
        pMensagemOk('Essa requisição já está marcada como "Negada"!');
      Exit;
    End;

    If (FieldByName('MARDES').AsInteger = 0) And
       fEmptyStr(FieldByName('SEQPCD').AsString) And // SE JÁ ESTÁ VINCULADA AO PROPRIO PEDIDO
       fAlteradaEmOutraEstacao(FieldByName('AUTOINCREM').AsString, blnDarMsgErro) Then
    Begin
      Exit;
    End;

    If Not fEmptyStr(FieldByName('AUTDET').AsString) Then
    Begin
      If blnDarMsgErro Then
        pMensagemOk('Essa requisição já está vinculada a outro pedido!');
      Exit;
    End;

    If Not fEmptyStr(FieldByName('NOTAS').AsString) Then
    Begin

      If blnDarMsgErro Then
      Begin
        If ((FieldByName('QTDITE').AsFloat < FieldByName('QTDORI').AsFloat)) And
           (FieldByName('NOTABE').AsInteger = 0) Then
          pMensagemOk('Essa requisição já está associada à nota de entrada ' + FieldByName('NOTAS').AsString  + '!' + #13#10 +
                      'Altere a quantidade da requisição para ' + FormatFloat('#,##0.00', FieldByName('QTDORI').AsFloat - FieldByName('QTDITE').AsFloat) +
                      ' no Cadastro de Requisições para que a mesma seja desvinculada do pedido de compra!')
        Else
          pMensagemOk('Essa requisição já está associada à nota de entrada ' + FieldByName('NOTAS').AsString  + '!');
      End;

      Exit;
    End;

    If (FieldByName('MARDES').AsInteger = 1) And
        fPossuiColeta(FieldByName('CODITE').AsString) And
       (Not fPergunta('Essa requisição possui Controle de Coleta. Confirma o desmarque?')) Then
      Exit;
  End;

  Result := True;
End;

Function TRequisicaoPedidoCompra.fConfirmaNegarRequisicoesSemPedidoVenda(Var blnCancelar: Boolean): Boolean;
  Var
    frmMostraRequisicoes: TfrmMostraRequisicoes;
Begin
  Result      := False;
  blnCancelar := False;

  cdsRequisicao.DisableControls;

  Try
    cdsRequisicao.Filter   := 'MARDES = 1 AND EMPPDV = ' + QuotedStr('');
    cdsRequisicao.Filtered := True;
    cdsRequisicao.First;

    If Not cdsRequisicao.IsEmpty Then
    Begin
      cdsRequisicao.Filtered := False;
      cdsRequisicao.Filter   := '';
      cdsRequisicao.EnableControls;

      pCriarFormularios(TfrmMostraRequisicoes, frmMostraRequisicoes);
      frmMostraRequisicoes.cxgReqView.DataController.DataSource := cdsRequisicao.dtsSource;

      frmMostraRequisicoes.cxgReqView.DataController.Filter.BeginUpdate;

      Try
        frmMostraRequisicoes.cxgReqView.DataController.Filter.Root.Clear;

        frmMostraRequisicoes.cxgReqView.DataController.Filter.Root.AddItem(frmMostraRequisicoes.cxgReqView.GetColumnByFieldName('DOCPDV'),
                                                                           foEqual, '', '');

        frmMostraRequisicoes.cxgReqView.DataController.Filter.Root.AddItem(frmMostraRequisicoes.cxgReqView.GetColumnByFieldName('MARDES'),
                                                                           foEqual, '1', '1');

       Finally
         frmMostraRequisicoes.cxgReqView.DataController.Filter.EndUpdate;
         frmMostraRequisicoes.cxgReqView.DataController.Filter.Active := true;
       End;

      frmMostraRequisicoes.ShowModal;

      Case frmMostraRequisicoes.opOperacao Of
        opCancela:    Begin
                        Result      := False;
                        blnCancelar := True;
                      End;

        opDesvincula: Begin
                        Result      := False;
                        blnCancelar := False;
                       End;

        opNega      : Begin
                        Result      := True;
                        blnCancelar := False;
                      End;
      End;

      pFreeAndNil(frmMostraRequisicoes);
    End;

  Finally
    cdsRequisicao.Filtered := False;
    cdsRequisicao.Filter   := '';
    cdsRequisicao.EnableControls;
  End;
End;

Function TRequisicaoPedidoCompra.fPedeSenhaLiberarTrava: Boolean;
Const
  cTitulo = 'LIBERAR REQUISICOES DE COMPRA.';
Var
  objLiberacao : ILiberacao;
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
  strFilterBkp, strCodReq, strAutoincrem: String;
  blnFilteredBkp: boolean;
begin
  Result := True;
  strCodReq:= cdsRequisicao.FieldByName('CODREQ').AsString;
  strAutoincrem:= cdsRequisicao.FieldByName('AUTOINCREM').AsString;
  strFilterBkp :=  cdsRequisicao.Filter;
  blnFilteredBkp :=  cdsRequisicao.Filtered;
  Try
    cdsRequisicao.Filtered := False;
    cdsRequisicao.Filter := '(TEMPED =''S'') AND (PEDFAT = '''') AND (MARDES = ''1'')  ';
    cdsRequisicao.Filtered := True;

    objLiberacao := TLiberacaoFactory.fGetLiberacao;
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddSeparador(138);
    objLiberacao.objMsgLibera.pAddTexto(cTitulo, alCentro, teAmbos, '', 138);
    objLiberacao.objMsgLibera.pAddSeparador(138);
    objLiberacao.objMsgLibera.pAddTexto('Requisição de compra com pedido de venda não faturado', alEsquerda, teAmbos, '', 138);


    objTabela := TRegistroMsgLiberaTabela.Create;
    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'REQUISICAO'  , 10  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'DT.PEDIDO'   , 10 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'PEDIDO VENDA', 20 , alEsquerda  , teAutcom);
    objLinha.pAddColuna(''  , 'CLIENTE'     , 50 , alEsquerda  , teAutcom);
    objLinha.pAddColuna(''  , 'VEN'         , 03 , alDireita  , teAutcom);

    objTabela.lstLinhas.Add(objLinha);

    cdsRequisicao.First;
    While Not cdsRequisicao.Eof Do
    Begin
      If cdsRequisicao.FieldByName('MARDES').AsString = '0' Then
      Begin
        cdsRequisicao.Next;
        Continue;
      End;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('REQUISICAO'   , cdsRequisicao.FieldByName('CODREQ').AsString +
        '-' + cdsRequisicao.FieldByName('EMPPDV').AsString
        , 10 , alCentro  );
      objLinha.pAddColuna('DT.PEDIDO'    , cdsRequisicao.FieldByName('DTACAD').AsString , 10 , alEsquerda);
      objLinha.pAddColuna('PEDIDO VENDA' , cdsRequisicao.FieldByName('DOCPDV').AsString +
        '-' + cdsRequisicao.FieldByName('ESPPDV').AsString +
        '-' + cdsRequisicao.FieldByName('EMPPDV').AsString
        , 20 , alEsquerda );
      objLinha.pAddColuna('CLIENTE'      , cdsRequisicao.FieldByName('NOMCLI').AsString , 50 , alEsquerda );
      objLinha.pAddColuna('VEN'          , cdsRequisicao.FieldByName('CODVEN').AsString , 03 , alEsquerda );

      objTabela.lstLinhas.Add(objLinha);

      cdsRequisicao.Next;
    End;

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    objLiberacao.strDirAce := 'VNDPGT';
    objLiberacao.strMsgSen := cTitulo;
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.blnSempreVariavelUsuario := True;

    If (Not objLiberacao.fLibera)  then
    Begin
      cdsRequisicao.First;
      While Not cdsRequisicao.Eof Do
      Begin
        If cdsRequisicao.FieldByName('MARDES').AsString = '1' Then
          pDesmarcaRequisicao;

        cdsRequisicao.Next;
      End;
      Result := False;
    End;

  Finally
    cdsRequisicao.Filtered := False;
    cdsRequisicao.Filter := strFilterBkp;
    cdsRequisicao.Filtered := blnFilteredBkp;
    If cdsRequisicao.Filtered Then
      cdsRequisicao.First
    Else
      cdsRequisicao.Locate('CODREQ;AUTOINCREM', VarArrayOf([strCodReq, strAutoincrem]), []);
  End;
End;

function TRequisicaoPedidoCompra.fVendaNaoFaturada: Boolean;
Begin
  Result :=(cdsRequisicao.FieldByName('MARDES').AsString = '1')
    // TEMPED -> 'S' = REQUISIÇÃO COM PEDIDO, N = REQUISIÇÃO SEM PEDIDO
    And (cdsRequisicao.FieldByName('TEMPED').AsString = 'S')
    // PEDFAT -> NÚMERO DO DOCUMENTO FATURADO DO PEDIDO, SE VAZIO O PEDIDO NÃO FOI FATURADO.
    And (cdsRequisicao.FieldByName('PEDFAT').AsString = '' );
End;

procedure TRequisicaoPedidoCompra.GravarDEL_MOVRCD(AAutInc: String);
var
  qryDados: TUniQuery;
begin
  qryDados := fCriaQuery();
  qryDados.SQL.Clear();
  qryDados.SQL.Add('SELECT * FROM MOVRCD ');
  qryDados.SQL.Add('WHERE AUTOINCREM  = "'+AAutInc+'"');
  qryDados.Open;
  If Not qryDados.isEmpty Then
    fVerificaIntegridade(FNomeForm, 'MOVRCD', qryDados);
end;

procedure TRequisicaoPedidoCompra.GravarDEL_MOVRCG(AStrCodReq: String);
var
  qryDados: TUniQuery;
begin
  qryDados := fCriaQuery();
  qryDados.SQL.Clear();
  qryDados.SQL.Add('SELECT * FROM MOVRCG ');
  qryDados.SQL.Add('WHERE RCG_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND RCG_CODIGO  = "' + AStrCodReq + '"');
  qryDados.Open;
  If Not qryDados.isEmpty Then
    fVerificaIntegridade(FNomeForm, 'MOVRCG', qryDados);

end;

function TRequisicaoPedidoCompra.fTemVendaNaoFaturada: Boolean;
Begin
  Result := false;
  cdsRequisicao.DisableControls;

  cdsRequisicao.First;
  while (Not cdsRequisicao.Eof) And (Not Result) do
  Begin
    Result := fVendaNaoFaturada;
    cdsRequisicao.Next;
  end;
  cdsRequisicao.EnableControls;
End;

procedure TRequisicaoPedidoCompra.pPedeSenhaLiberarTravaSemAdtBol;
Const
  cTitulo = 'LIBERAR REQUISICOES DE COMPRA.';
Var
  objLiberacao : ILiberacao;
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
  strFilterBkp: String;
  blnFilteredBkp: boolean;
begin
  strFilterBkp :=  cdsRequisicao.Filter;
  blnFilteredBkp :=  cdsRequisicao.Filtered;
  Try
    cdsRequisicao.Filtered := False;
    cdsRequisicao.Filter := '(TEMBOL <> ''S'') AND (TEMADT <> ''S'') AND (MARDES = ''1'')  ';
    cdsRequisicao.Filtered := True;

    objLiberacao := TLiberacaoFactory.fGetLiberacao;
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddSeparador(138);
    objLiberacao.objMsgLibera.pAddTexto(cTitulo, alCentro, teAmbos, '', 138);
    objLiberacao.objMsgLibera.pAddSeparador(138);
    objLiberacao.objMsgLibera.pAddTexto('Pedido de Venda associado à Requisição ainda não possui Adiantamento ou Boleto de pagamento.', alEsquerda, teAmbos, '', 138);


    objTabela := TRegistroMsgLiberaTabela.Create;
    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'Número Requisição'     , 22, alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'Número Pedido de Venda', 22, alEsquerda  , teAutcom);
    objLinha.pAddColuna(''  , 'Data Pedido de Venda'  , 22, alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'Cliente'               , 50, alEsquerda  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    cdsRequisicao.First;
    While Not cdsRequisicao.Eof Do
    Begin
      If cdsRequisicao.FieldByName('MARDES').AsString = '0' Then
      Begin
        cdsRequisicao.Next;
        Continue;
      End;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('Número Requisição'   , cdsRequisicao.FieldByName('CODREQ').AsString +
        '-' + cdsRequisicao.FieldByName('EMPPDV').AsString
        , 22, alCentro  );
      objLinha.pAddColuna('Número Pedido de Venda' , cdsRequisicao.FieldByName('DOCPDV').AsString +
        '-' + cdsRequisicao.FieldByName('ESPPDV').AsString +
        '-' + cdsRequisicao.FieldByName('EMPPDV').AsString
        , 22, alEsquerda );
      objLinha.pAddColuna('Data Pedido de Venda'    , cdsRequisicao.FieldByName('DTACAD').AsString , 22 , alEsquerda);

      objLinha.pAddColuna('Cliente'      , cdsRequisicao.FieldByName('NOMCLI').AsString , 50 , alEsquerda );
      objTabela.lstLinhas.Add(objLinha);
      cdsRequisicao.Next;
    End;

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    objLiberacao.strDirAce := 'VNDSBA';
    objLiberacao.strMsgSen := cTitulo;
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.blnSempreVariavelUsuario := True;

    If (Not cdsRequisicao.IsEmpty) And (Not objLiberacao.fLibera)  then
    Begin
      cdsRequisicao.First;
      While Not cdsRequisicao.Eof Do
      Begin
        If cdsRequisicao.FieldByName('MARDES').AsString = '1' Then
          pDesmarcaRequisicao;
        cdsRequisicao.Next;
      End;
    End;
  Finally
    cdsRequisicao.Filtered := False;
    cdsRequisicao.Filter := strFilterBkp;
    cdsRequisicao.Filtered := blnFilteredBkp;
    cdsRequisicao.First;
  End;
End;

procedure TRequisicaoPedidoCompra.RecarregarRequisicoes;
begin
  fCarregaRequisicoes('', recOpcGir);
end;

procedure TRequisicaoPedidoCompra.ProcessaStatusPedidoRequisicaoRCD(strSeqRCD: String);
  Var
    qryRequis: TUniQuery;
begin
  qryRequis := fCriaQuery;
  try

    qryRequis.SQL.Add('SELECT DISTINCT FATGOR.FGO_NUMDOC, FATGOR.FGO_ESPDOC, FATGOR.FGO_CODEMP, FATGOR.FGO_CODCLI');
    qryRequis.SQL.Add(' FROM MOVRCD ');
    qryRequis.SQL.Add('INNER JOIN FATGOR ON FGO_NUMDOC = RCD_DOCPDV AND FGO_CODEMP =  RCD_EMPPDV AND FGO_ESPDOC = RCD_ESPPDV');
    qryRequis.SQL.Add(' WHERE MOVRCD.AUTOINCREM = "' + strSeqRCD + '"');

    qryRequis.Open;

    while not qryRequis.Eof do
    Begin
      TUpdateStatus.New(TParamStatus.New()
                              .NumDoc(qryRequis.FieldByName('FGO_NUMDOC').AsString)
                              .EspDoc(qryRequis.FieldByName('FGO_ESPDOC').AsString)
                              .CodEmp(qryRequis.FieldByName('FGO_CODEMP').AsString)
                              .CodCli(qryRequis.FieldByName('FGO_CODCLI').AsString)).pExecute();
      qryRequis.Next;
    End;
  finally
    FreeAndNil(qryRequis)
  End;

end;


{ TGerenciaNotificacaoReqNegada }

function TGerenciaNotificacaoReqNegada.fLocalizaDestinatario(
  ACodDestinatario: String): integer;
  var NotificacaoReqNegada: TNotificacaoReqNegada ;
begin
  Result := -1;
  For NotificacaoReqNegada in ArrNotificacaoReqNegada do
  begin
    If NotificacaoReqNegada.strCodCmp = ACodDestinatario then
      Exit(NotificacaoReqNegada.Index);
  End;
end;

procedure TGerenciaNotificacaoReqNegada.pAdicionaItem(ACodDestinatario: String;ACodVen: String;
  AItensNotificacaoReqNegada: TItemNotificacaoReqNegada);
var
  intDestinatario: integer;
begin
  intDestinatario := fLocalizaDestinatario(ACodDestinatario);
  If intDestinatario = -1 Then
  begin
    SetLength(ArrNotificacaoReqNegada, succ(Length(ArrNotificacaoReqNegada)));
    intDestinatario := High(ArrNotificacaoReqNegada);
    ArrNotificacaoReqNegada[intDestinatario].strCodCmp :=  ACodDestinatario;
    ArrNotificacaoReqNegada[intDestinatario].index     :=  intDestinatario;
    ArrNotificacaoReqNegada[intDestinatario].strCodVen :=  ACodVen;
  End;
  ArrNotificacaoReqNegada[intDestinatario].AddItem(AItensNotificacaoReqNegada);
end;

procedure TGerenciaNotificacaoReqNegada.pEnviaNotificacoes;
  var NotificacaoReqNegada : TNotificacaoReqNegada ;
begin
  For NotificacaoReqNegada in ArrNotificacaoReqNegada do
    NotificacaoReqNegada.pEnviaNotificacao;

end;

{ TNotificacaoReqNegada }

procedure TNotificacaoReqNegada.AddItem(
  ItemNotificacaoReqNegada: TItemNotificacaoReqNegada);
var intItem: Integer;
begin
  SetLength(ArrItensNotificacaoReqNegada, succ(Length(ArrItensNotificacaoReqNegada)));
  intItem := High(ArrItensNotificacaoReqNegada);
  ArrItensNotificacaoReqNegada[intItem].codReq := ItemNotificacaoReqNegada.codReq;
  ArrItensNotificacaoReqNegada[intItem].DtCadastro := ItemNotificacaoReqNegada.DtCadastro;
  ArrItensNotificacaoReqNegada[intItem].cliente := ItemNotificacaoReqNegada.cliente;
  ArrItensNotificacaoReqNegada[intItem].item := ItemNotificacaoReqNegada.item;
  ArrItensNotificacaoReqNegada[intItem].referencia := ItemNotificacaoReqNegada.referencia;
  ArrItensNotificacaoReqNegada[intItem].qtdeReq := ItemNotificacaoReqNegada.qtdeReq;
  ArrItensNotificacaoReqNegada[intItem].codEmp := ItemNotificacaoReqNegada.codEmp;
  ArrItensNotificacaoReqNegada[intItem].Motivo := ItemNotificacaoReqNegada.Motivo;
end;

procedure TNotificacaoReqNegada.pEnviaNotificacao;
var stlMensag: TStringList;
    ItensNotificacaoReqNegada: TItemNotificacaoReqNegada;
    objMensag: TMsgInterna;

begin
  stlMensag := TStringList.Create;
  objMensag := TMsgInterna.Create(Nil);

  Try
    stlMensag.Add('| '+ fPadR('Caro Sr(a). '+Self.strCodCmp, 125) + ' |');
    stlMensag.Add('| '+ fPadR('', 125) + ' |');
    stlMensag.Add('| '+ fPadR('EM '+DateToStr(VS_Date)+' foi negada/excluida a(s) Requisições de Compra abaixo:', 125) + ' |');
    stlMensag.Add('| '+ fPadR('', 125) + ' |');
    stlMensag.Add('| '+ fPadR('', 125,'-') + ' |');

    stlMensag.Add('| '+ fPadR('Requisição',10)+' | '
                        +fPadR('Data Cadastro',13)+' | '
                        +fPadR('Cliente',24)+' | '
                        +fPadR('Item',24)+' | '
                        +fPadR('Referencia',14)+' | '
                        +fPadR('Qtd. Requisição',15)+' | '
                        +fPadR('Empresa', 7) + ' |');

    For ItensNotificacaoReqNegada in Self.ArrItensNotificacaoReqNegada do
    Begin
      stlMensag.Add('| '+ fPadR(ItensNotificacaoReqNegada.codReq+
                                ItensNotificacaoReqNegada.DtCadastro+
                                ItensNotificacaoReqNegada.cliente+
                                ItensNotificacaoReqNegada.item+
                                ItensNotificacaoReqNegada.referencia+
                                ItensNotificacaoReqNegada.qtdeReq+
                                ItensNotificacaoReqNegada.codEmp, 125) + ' |');
      stlMensag.Add('| '+ fPadR('Justificativa:', 125) + ' |');
      stlMensag.Add('| '+ '-> ' + fPadR(TCoreFuncoes.fTiraEnter(ItensNotificacaoReqNegada.Motivo) , 122) + ' |');
    End;
    stlMensag.Add('| '+ fPadR('', 125,'-') + ' |');

    stlMensag.Add('| '+fPadR('',125,'-')+' |');
    stlMensag.Add('| ' +fPadR('Operador que negou: ' + strLoginUsuarioLogado + ' - ' + fRetNomeOperador(strLoginUsuarioLogado), 125) + ' |');
    stlMensag.Add('| '+fPadR('',125,'-')+' |');
    objMensag.fEnviaMensagem(MSG_ASSUNTO_REQUISICAO_NEGADA,
                            stlMensag.Text,
                            strLoginUsuarioLogado,
                            Self.strCodVen,
                            'N',
                            '');
  Finally
    FreeAndNil(stlMensag);
    FreeAndNil(objMensag);
  End;


end;
end.

