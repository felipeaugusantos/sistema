unit untUnificacaoPedidos;

interface

uses StrUtils, SysUtils, Uni, Db, Classes, Forms, Variants, Controls, untTypesSistema,
     UniClientDataSet, UniDataSetProvider, untZClient, cxProgressBar, untDuplicatasPedidoCompra,
     untTLock;

Type
  TRecDadosFechamento = Record
    dtaDtaEnt,
    dtaDtaFat: TDateTime;

    blnPagVis: Boolean;

    intCarPag: Integer;

    strCodCmp,
    strConPag,
    strCodTra,
    strCodTraRedespacho,
    strNomTra,
    strEntTra,
    strCidTra,
    strTipFre,
    strTipFreRedespacho,
    strNomEnt,
    strEntEnt,
    strCidEnt,
    strCodEve,
    strCodCta,
    strPedVen,
    strObser1,
    strObser2,
    strObser3,
    strObser4,
    strObser5,
    strAtenca,
    strCodOco: String;

    fltValFre,
    fltDesAce: Double;
  End;

  TUnificacaoPedidos = Class(TZClient)
  Private

    strForFil   : String;

    blnUsaColeta,
    blnLibPcm   : Boolean;
    intDeqTpc   : Integer;

    strCampoSaldoSub,
    strCampoSaldoAdd: String;

    fltALPISP,
    fltALCOFP: Double;

    FDtaPed: TDateTime;
    FHorPed: TTime;

    FAutGer,
    FCodFor,
    FEmpDesConsulta,

    FEmpDes,
    FNumPed: String;

    cdsItens: TZClient;

    blnConferenciaDespoisDaEntrada,
    blnZonaFranca: Boolean;

    recFechamento: TRecDadosFechamento;
    stlPedidos: TStringList;

    objDuplicatasPedido: TDuplicatasPedidoCompra;
    objLock: TLock;

    Function fSQLPedidos(strCodEmp: String): String;
    Function fSQLItens: String;
    function fIniciaPedidoCompra: Boolean;
    function fTotalImpostosReformaUnificacao: Double;
    Function fUnificaPedidosPrg(prgProgressBar: TcxProgressBar): Boolean;
    Function fCarregaPedidosPrg(prgProgresso: TcxProgressBar): Boolean;
    Function fBaixaPedidos: Boolean;
    Function fExcluiControleDeColetaAbertos(strAutInc: String): Boolean;

    Procedure pAjustaValor(blnMarcar: Boolean);
    Procedure pCarregaItens;
    Procedure pGravaItens;
    procedure pCarregaFornecedor;

    Function fPedeEmpresaDestino(Var strEmpDes: String): Boolean;

    Function fVerificaPedidos: Boolean;

  Public
    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor  Destroy; Override;

    Function fCarregaPedidos(strCodFor, strCodEmp: String): Boolean;
    Function fInList(strAutInc: String): Boolean;
    Function fPedidosSelecionados: Boolean;
    Function fPedeObservacoes: Boolean;

    Procedure pUnificacaoPedidos;
    function fValidaSituacaoPedido(qryPedido: TUniQuery; strBaixas: String; intContador: integer): Boolean;

    Function  fUnificaPedidos: Boolean;
    Procedure pMarcaDesmarca;
    Procedure pMarcaTodos(blnMarcar: Boolean);

  End;

implementation

Uses
  untFuncoesSimples, untPedeUnificacaoPedidos, untDigObservacoes,
  untFuncoesPedidoSimples, untSaldoPedidoCompra,
  untTipoFreteAtc, untGravacaoPedido, untConstantes, untGravando,
  untTMontaSQLPedidoCompra,
  untPedeEmpresaUnif, untMensagemExplicativa;

constructor TUnificacaoPedidos.Create(Owner: TComponent);
begin
  Inherited Create(Owner);

  blnConferenciaDespoisDaEntrada := fConferenciaDepoisDaEntrada;

  strForFil := fRetForFilialTodos;
  blnLibPcm := fCfgSis('LIBPCM', varBoolean);
  intDeqTpc := fCfgSis('DEQTPC', varInteger);

  strCampoSaldoSub := '';
  strCampoSaldoAdd := '';

  stlPedidos        := TStringList.Create;
  stlPedidos.Sorted := True;

  cdsItens := TZClient.Create(Self);

  cdsItens.pCriaSoma('TOTITE');

  cdsItens.pCriaSoma('BASIPI');
  cdsItens.pCriaSoma('TOTIPI');

  cdsItens.pCriaSoma('VALCBS');
  cdsItens.pCriaSoma('VALIBS');
  cdsItens.pCriaSoma('VAL_IS');

  cdsItens.pCriaSoma('BASSUB');
  cdsItens.pCriaSoma('TOTSUB');
  cdsItens.pCriaSoma('TOTDAR');

  cdsItens.pCriaSoma('SUBFCP');

  cdsItens.pCriaSoma('VALCOF');
  cdsItens.pCriaSoma('BASCOF');

  cdsItens.pCriaSoma('VALPIS');
  cdsItens.pCriaSoma('BASPIS');

  cdsItens.pCriaSoma('VALICM');
  cdsItens.pCriaSoma('BASICM');

  cdsItens.pCriaSoma('DESPIS');

  objDuplicatasPedido := TDuplicatasPedidoCompra.Create;
  objLock := TLock.Create;

  fltALPISP := fCfgSis('ALPISP', varDouble);
  fltALCOFP := fCfgSis('ALCOFP', varDouble);

  blnZonaFranca := fEhEstadoRegraZonaFranca(fCadEmp('ESTADO'));
End;

destructor TUnificacaoPedidos.Destroy;
begin
  stlPedidos.Clear;
  FreeAndNil(stlPedidos);

  FreeAndNil(objDuplicatasPedido);
  FreeAndNil(objLock);

  inherited Destroy;
end;

Function TUnificacaoPedidos.fInList(strAutInc: String): Boolean;
  Var
    intIndex: Integer;
Begin
  Result := stlPedidos.Find(strAutInc, intIndex);
End;

Procedure TUnificacaoPedidos.pMarcaDesmarca;
  Var
    intIndex: Integer;
Begin
  If IsEmpty Then
    Exit;

  If stlPedidos.Find(FieldByName('AUTINC').AsString, intIndex) Then
  Begin
    stlPedidos.Delete(intIndex);

    objLock.fLock_Unlock('PEDCOM' + FieldByName('NUMPED').AsString + 'PD' + FieldByName('EMPORI').AsString, False, False);
    pAjustaValor(False);
  End

  Else If Not fEmptyStr(FieldByName('NOTAS').AsString) Then
  Begin
    pMensagemOk('Esse pedido já está em Pré-Nota!');
  End

  Else If (FieldByName('QTD_BAIPED').AsInteger > 0) Then
  Begin
    pMensagemOk('Esse pedido já tem baixas pré-definidas para a Efetivação de Movimento Fiscal!');
  End

  Else If (Not objLock.fLock_Unlock('PEDCOM' + FieldByName('NUMPED').AsString + 'PD' +
                                               FieldByName('EMPORI').AsString, True, False)) Then
  Begin
    pMensagemOk('Este documento está sendo utilizado por outra estação: ' + fGetHostLock('PEDCOM' + FieldByName('NUMPED').AsString + 'PD' +
                                                                                          FieldByName('EMPORI').AsString));
  End

  Else
  Begin
    stlPedidos.Add(FieldByName('AUTINC').AsString);
    pAjustaValor(True);
  End;
End;

Procedure TUnificacaoPedidos.pAjustaValor(blnMarcar: Boolean);
Begin
  Edit;
  If blnMarcar Then
  Begin
    FieldByName('ITESEL').AsFloat := FieldByName('TOTITE').AsFloat;
    FieldByName('IPISEL').AsFloat := FieldByName('TOTIPI').AsFloat;;
    FieldByName('CBSSEL').AsFloat := FieldByName('TOTCBS').AsFloat;
    FieldByName('IBSSEL').AsFloat := FieldByName('TOTIBS').AsFloat;
    FieldByName('IS_SEL').AsFloat := FieldByName('TOT_IS').AsFloat;
    FieldByName('SUBSEL').AsFloat := FieldByName('TOTSUB').AsFloat;;
    FieldByName('DARSEL').AsFloat := FieldByName('TOTDAR').AsFloat;;
    FieldByName('FCPSEL').AsFloat := FieldByName('SUBFCP').AsFloat;;
    FieldByName('GERSEL').AsFloat := FieldByName('TOTGER').AsFloat;;
  End Else
  Begin
    FieldByName('ITESEL').AsFloat := 0;
    FieldByName('IPISEL').AsFloat := 0;
    FieldByName('CBSSEL').AsFloat := 0;
    FieldByName('IBSSEL').AsFloat := 0;
    FieldByName('IS_SEL').AsFloat := 0;
    FieldByName('SUBSEL').AsFloat := 0;
    FieldByName('DARSEL').AsFloat := 0;
    FieldByName('FCPSEL').AsFloat := 0;
    FieldByName('GERSEL').AsFloat := 0;
  End;
  Post;
End;

Procedure TUnificacaoPedidos.pMarcaTodos(blnMarcar: Boolean);
Begin
  stlPedidos.Clear;
  objLock.pDestravarTodos;

  First;
  While Not Eof Do
  Begin

    If blnMarcar Then
    Begin

      If fEmptyStr(FieldByName('NOTAS').AsString) And (FieldByName('QTD_BAIPED').AsInteger = 0) And
         objLock.fLock_Unlock('PEDCOM' + FieldByName('NUMPED').AsString + 'PD' + FieldByName('EMPORI').AsString, True, False) Then
      Begin
        stlPedidos.Add(FieldByName('AUTINC').AsString);
        pAjustaValor(blnMarcar);
      End;

    End

    Else pAjustaValor(blnMarcar);

    Next;
  End;
End;

Procedure TUnificacaoPedidos.pUnificacaoPedidos;
  Var
    frmPedeUnificacaoPedidos : TfrmPedeUnificacaoPedidos;
Begin
  pCriarFormularios(TfrmPedeUnificacaoPedidos, frmPedeUnificacaoPedidos);

  Try
    frmPedeUnificacaoPedidos.cxgItens.DataController.DataSource := dtsSource;
    frmPedeUnificacaoPedidos.objUnificacao := Self;
    frmPedeUnificacaoPedidos.ShowModal;
  Finally
    pFreeAndNil(frmPedeUnificacaoPedidos);
  End;
End;

function TUnificacaoPedidos.fValidaSituacaoPedido(qryPedido: TUniQuery; strBaixas: String; intContador: integer): Boolean;
Begin
  Result := True;
  If Not fEmptyStr(qryPedido.FieldByName('NOTAS').AsString) Then
  Begin
    pMensagemOk('Pedido já está em Pré-Nota!');
    Exit(False);
  End;

  If blnConferenciaDespoisDaEntrada Then
  Begin
    qryPedido.Close;
    qryPedido.SQL.Text := strBaixas;
    qryPedido.ParamByName('AUTINC').AsString := stlPedidos[intContador];
    qryPedido.Open;

    If qryPedido.FieldByName('BAIXAS').AsInteger > 0 Then
    Begin
      pMensagemOk('Pedido já tem baixas pré-definidas para a Efetivação de Movimento Fiscal!');
      Exit(False);
    End;
  End;
End;

Function TUnificacaoPedidos.fVerificaPedidos: Boolean;
  Var
    intContador: Integer;
    strNotas,
    strBaixas,
    strSQL: String;
    qryPedido: TUniQuery;
    strAutIncPedidos,
    strCodItens,
    strMensamgem,
    strCodItemAux: String;
    stlListaItens: TStringList;
    frmMensagemExplicativa: TfrmMensagemExplicativa;
Begin
  Result := True;

  qryPedido := fCriaQuery;

  strSQL := '';
  strAutIncPedidos := '';
  strCodItens := '';
  strMensamgem := '';


  Try
    strSQL := strSQL + ' SELECT GROUP_CONCAT(    DISTINCT CONCAT("NF-", B08_NNF, "-", GER_CODEMP)   ) AS NOTAS   FROM    GERELE L ';
    strSQL := strSQL + '   INNER JOIN DEFBAI       ON DEF_GERELE = L.AUTOINCREM ';
    strSQL := strSQL + '  WHERE DEF_AUTPCG = :AUTINC ';

    strNotas := strSQL;

    strSQL := '';
    strSQL := strSQL + '   SELECT COUNT(*) AS BAIXAS FROM PCMDET P        ';
    strSQL := strSQL + '    INNER JOIN BAIPED ON BAI_AUTPED = P.AUTOINCREM ';
    strSQL := strSQL + '    INNER JOIN PCMGER G ON  ';
    strSQL := strSQL + '        PCD_NUMPED = PCG_NUMPED ';
    strSQL := strSQL + '    AND PCD_ESPDOC = PCG_ESPDOC ';
    strSQL := strSQL + '    AND PCD_BAIXAD = 0          ';
    strSQL := strSQL + '    AND PCD_NUMCTN = PCG_NUMCTN ';
    strSQL := strSQL + '    AND PCD_CODEMP = PCG_CODEMP ';
    strSQL := strSQL + '  WHERE G.AUTOINCREM = :AUTINC ';
    strBaixas := strSQL;

    For intContador := 0 To stlPedidos.Count - 1 Do
    Begin
      qryPedido.Close;
      qryPedido.SQL.Text := strNotas;
      qryPedido.ParamByName('AUTINC').AsString := stlPedidos[intContador];
      qryPedido.Open;

      If not fValidaSituacaoPedido(qryPedido, strBaixas, intContador) Then
      Begin
        Result := False;
        Break;
        Exit;
      End;

      If fEmptyStr(strAutIncPedidos) Then
        strAutIncPedidos := '"' + stlPedidos[intContador] + '"'
      Else
        strAutIncPedidos := strAutIncPedidos + ',"' + stlPedidos[intContador] + '"';
    End;


    { Validar se os pedidos selecionados e os itens do mesmo código estão com divergência entre a descrição/Valor Unitário }
    { Req.: 253599 }
    qryPedido.Close;
    qryPedido.SQL.Clear;
    qryPedido.SQL.Add(' SELECT * FROM ( ');
    qryPedido.SQL.Add('  SELECT ');
    qryPedido.SQL.Add('   PCD_CODITE, PCD_DESITE, PCD_UNITAR ');
    qryPedido.SQL.Add('   FROM PCMDET P ');
    qryPedido.SQL.Add('      INNER JOIN PCMGER G ');
    qryPedido.SQL.Add('       ON PCD_NUMPED = PCG_NUMPED ');
    qryPedido.SQL.Add('      AND PCD_ESPDOC = PCG_ESPDOC ');
    qryPedido.SQL.Add('      AND PCD_NUMCTN = PCG_NUMCTN ');
    qryPedido.SQL.Add('      AND PCD_CODEMP = PCG_CODEMP ');
    qryPedido.SQL.Add('      AND PCD_BAIXAD = 0 ');
    qryPedido.SQL.Add('  WHERE G.AUTOINCREM IN ('+ strAutIncPedidos + ') ');
    qryPedido.SQL.Add('  GROUP BY PCD_CODITE, PCD_DESITE, PCD_UNITAR ');
    qryPedido.SQL.Add(' ) AS TAB ');
    qryPedido.SQL.Add(' GROUP BY TAB.PCD_CODITE ');
    qryPedido.SQL.Add(' HAVING COUNT(1) > 1 ');
    qryPedido.Open;

    If (not qryPedido.IsEmpty) Then
    Begin
      qryPedido.First;
      While not qryPedido.Eof Do
      Begin
        If fEmptyStr(strCodItens) Then
          strCodItens := '"' + qryPedido.FieldByName('PCD_CODITE').AsString +'" '
        Else
          strCodItens := strCodItens + ',"' + qryPedido.FieldByName('PCD_CODITE').AsString + '" ';

        qryPedido.Next;
      End;

      qryPedido.Close;
      qryPedido.SQL.Clear;
      qryPedido.SQL.Add(' SELECT ');
      qryPedido.SQL.Add('  CONCAT(PCD_NUMPED,"-", PCD_ESPDOC,"-", PCD_CODEMP) AS NUMPED, PCD_CODITE,  PCD_DESITE,  Round(PCD_UNITAR,4) AS PCD_UNITAR ');
      qryPedido.SQL.Add(' FROM ');
      qryPedido.SQL.Add('   PCMDET P ');
      qryPedido.SQL.Add('   INNER JOIN PCMGER G ');
      qryPedido.SQL.Add('      ON PCD_NUMPED = PCG_NUMPED ');
      qryPedido.SQL.Add('     AND PCD_ESPDOC = PCG_ESPDOC ');
      qryPedido.SQL.Add('     AND PCD_NUMCTN = PCG_NUMCTN ');
      qryPedido.SQL.Add('     AND PCD_CODEMP = PCG_CODEMP ');
      qryPedido.SQL.Add('     AND PCD_BAIXAD = 0 ');
      qryPedido.SQL.Add(' WHERE TRUE ');
      qryPedido.SQL.Add('   AND  G.AUTOINCREM IN ('+ strAutIncPedidos + ') ');
      qryPedido.SQL.Add('   AND PCD_CODITE IN ('+ strCodItens + ') ');
      qryPedido.SQL.Add('   ORDER BY PCD_CODITE, NUMPED ');

      qryPedido.Open;
      qryPedido.First;
      pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
      stlListaItens := TStringList.Create;
      Try
        frmMensagemExplicativa.Caption := 'Unificação de Pedidos de Compra';
        frmMensagemExplicativa.Width   := 800;
        frmMensagemExplicativa.Height  := 550;
        frmMensagemExplicativa.AutoSize := True;

        strCodItemAux := qryPedido.FieldByName('PCD_CODITE').AsString;
        stlListaItens.Add('O Pedidos Selecionados não podem ser unificados pois, ');
        stlListaItens.Add('os itens abaixo estão com divergência: descrição ou valor unitário ');
        stlListaItens.Add('------------------------------------------------------------------ ');
        While not qryPedido.Eof Do
        Begin
           If Not SameText(strCodItemAux, qryPedido.FieldByName('PCD_CODITE').AsString) Then
           Begin
              stlListaItens.Add('------------------------------------------------------------------');
              strCodItemAux := qryPedido.FieldByName('PCD_CODITE').AsString;
           End;

           stlListaItens.Add(qryPedido.FieldByName('NUMPED').AsString + ' - ' +
                             qryPedido.FieldByName('PCD_CODITE').AsString + ' - ' +
                             qryPedido.FieldByName('PCD_DESITE').AsString + ' - Valor Unitário: ' +
                             qryPedido.FieldByName('PCD_UNITAR').AsString );


           qryPedido.Next
        End;

        frmMensagemExplicativa.mmoInstru.Lines.Text := stlListaItens.Text;
        frmMensagemExplicativa.ShowModal;
        Exit(False);
      Finally
        FreeAndNil(frmMensagemExplicativa);
        FreeAndNil(stlListaItens);
      End;
    End;

  Finally
    FreeAndNil(qryPedido);
  End;
End;

Function TUnificacaoPedidos.fSQLPedidos(strCodEmp: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   G.AUTOINCREM AS AUTINC, ';
  strSQL := strSQL + '   PCG_NUMPED   AS NUMPED, ';
  strSQL := strSQL + '   PCG_CODEMP   AS EMPORI, ';

  strSQL := strSQL + '   IF(PCG_EMPDES = "" OR PCG_EMPDES IS NULL, PCG_CODEMP, PCG_EMPDES) AS EMPDES, ';

  strSQL := strSQL + '   PCG_DTAPED AS DTAPED, ';
  strSQL := strSQL + '   PCG_DTAENT AS DTAENT, ';
  strSQL := strSQL + '   PCG_CONPAG AS CONPAG, ';

  strSQL := strSQL + '   PCG_TOTITE AS TOTITE, ';
  strSQL := strSQL + '   PCG_TOTIPI AS TOTIPI, ';
  strSQL := strSQL + '   IFNULL(PCG_VALCBS, 0) AS TOTCBS, ';
  strSQL := strSQL + '   IFNULL(PCG_VALIBS, 0) AS TOTIBS, ';
  strSQL := strSQL + '   IFNULL(PCG_VAL_IS, 0) AS TOT_IS, ';
  strSQL := strSQL + '   PCG_TOTSUB AS TOTSUB, ';
  strSQL := strSQL + '   PCG_TOTDAR AS TOTDAR, ';
  strSQL := strSQL + '   PCG_SUBFCP AS SUBFCP, ';
  strSQL := strSQL + '   PCG_TOTGER AS TOTGER, ';

(*  strSQL := strSQL + '   (SELECT GROUP_CONCAT(DISTINCT CONCAT("NF-", B08_NNF, "-", GER_CODEMP)) FROM GERELE L ';
  strSQL := strSQL + '    INNER JOIN PEDELE ON PEL_SEQELE = L.AUTOINCREM ';
  strSQL := strSQL + '    WHERE ';
  strSQL := strSQL + '          PEL_NUMDOC = PCG_NUMPED ';
  strSQL := strSQL + '      AND PEL_ESPDOC = PCG_ESPDOC ';
  strSQL := strSQL + '      AND PEL_CODEMP = PCG_CODEMP) AS NOTAS, ';  *)

  strSQL := strSQL + '   (SELECT GROUP_CONCAT(    DISTINCT CONCAT("NF-", B08_NNF, "-", GER_CODEMP)   )   FROM    GERELE L';
  strSQL := strSQL + '     INNER JOIN DEFBAI       ON DEF_GERELE = L.AUTOINCREM';
  strSQL := strSQL + '   WHERE DEF_AUTPCG = G.AUTOINCREM) AS NOTAS,';


  If blnConferenciaDespoisDaEntrada Then
  Begin
    strSQL := strSQL + '   (SELECT COUNT(*) FROM PCMDET P                  ';
    strSQL := strSQL + '    INNER JOIN BAIPED ON BAI_AUTPED = P.AUTOINCREM ';
    strSQL := strSQL + '    WHERE ';
    strSQL := strSQL + '        PCD_NUMPED = PCG_NUMPED ';
    strSQL := strSQL + '    AND PCD_ESPDOC = PCG_ESPDOC ';
    strSQL := strSQL + '    AND PCD_BAIXAD = 0          ';
    strSQL := strSQL + '    AND PCD_NUMCTN = PCG_NUMCTN ';
    strSQL := strSQL + '    AND PCD_CODEMP = PCG_CODEMP) AS QTD_BAIPED, ';
  End

  Else strSQL := strSQL + '  0 AS QTD_BAIPED, ';

  strSQL := strSQL + '   0.00       AS ITESEL, ';
  strSQL := strSQL + '   0.00       AS IPISEL, ';
  strSQL := strSQL + '   0.00       AS CBSSEL, ';
  strSQL := strSQL + '   0.00       AS IBSSEL, ';
  strSQL := strSQL + '   0.00       AS IS_SEL, ';
  strSQL := strSQL + '   0.00       AS SUBSEL, ';
  strSQL := strSQL + '   0.00       AS DARSEL, ';
  strSQL := strSQL + '   0.00       AS FCPSEL, ';
  strSQL := strSQL + '   0.00       AS GERSEL  ';

  strSQL := strSQL + ' FROM      ';
  strSQL := strSQL + '   PCMGER G ';
  strSQL := strSQL + ' WHERE     ';
  strSQL := strSQL + '   PCG_ESPDOC = "PD" AND ';
  strSQL := strSQL + '   PCG_PEDIMP = "N"  AND ';
  strSQL := strSQL + '   PCG_PEDBON = "N"  AND ';
  strSQL := strSQL + '   PCG_PEDINT = "N"  AND ';
  strSQL := strSQL + '   PCG_BAIXAD = 0    AND ';
  strSQL := strSQL + '   PCG_NUMCTN = 0    AND ';
  strSQL := strSQL + '   PCG_CODFOR = :CODFOR  ';

  strSQL := strSQL + ' AND PCG_PEDMLJ = "N" ';

  If Not fEmptyStr(strCodEmp) Then
    strSQL := strSQL + ' AND IFNULL(PCG_EMPDES, PCG_CODEMP) = :CODEMP  ';

  Result := strSQL;
End;

Function TUnificacaoPedidos.fCarregaPedidos(strCodFor, strCodEmp: String): Boolean;
Begin
  stlPedidos.Clear;
  objLock.pDestravarTodos;

  FCodFor := strCodFor;
  FEmpDesConsulta := strCodEmp;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    Try
      With frmGravando Do
      Begin
        lblGravando.Caption := 'Carregando pedidos, aguarde...';
        fExecutarAcao := fCarregaPedidosPrg;
        ShowModal;
        Result := blnConfirma;
      End;
    Finally
      pFreeAndNil(frmGravando);
    End
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TUnificacaoPedidos.fCarregaPedidos');
    End;
  End;
End;

Function TUnificacaoPedidos.fCarregaPedidosPrg(prgProgresso: TcxProgressBar): Boolean;
Begin
  Try
    With qryQuery Do
    Begin
      SQL.Text := fSQLPedidos(FEmpDesConsulta);

      ParamByName('CODFOR').AsString := FCodFor;

      If Not fEmptyStr(FEmpDesConsulta) Then
        ParamByName('CODEMP').AsString := FEmpDesConsulta;

      Result := fAbreClient(True, 'TUnificacaoPedidos.fCarregaPedidosPrg');

      pAlinhaCampoCentro('NUMPED');
      pAlinhaCampoCentro('EMPORI');
      pAlinhaCampoCentro('EMPDES');
      pAlinhaCampoCentro('DTAPED');
      pAlinhaCampoCentro('DTAENT');
    End;

    TStringField(FieldByName('CONPAG')).EditMask := MASK_CONPAG;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TUnificacaoPedidos.fCarregaPedidosPrg');
    End;

  End;
End;

Function TUnificacaoPedidos.fPedidosSelecionados: Boolean;
Begin
  Result := stlPedidos.Count > 1;
End;

Function TUnificacaoPedidos.fPedeEmpresaDestino(Var strEmpDes: String): Boolean;
  Var
    intContador: Integer;
    stlDestino: TStringList;
    qryCadEmp: TUniQuery;
Begin
  qryCadEmp := fCriaQuery;
  stlDestino := TStringList.Create;
  pCriarFormularios(TfrmPedeEmpresaUnif, frmPedeEmpresaUnif);
  Try
    stlDestino.Sorted := True;
    stlDestino.Duplicates := dupIgnore;

    For intContador := 0 To stlPedidos.Count - 1 Do
      If Locate('AUTINC', stlPedidos[intContador], []) Then
      Begin
        stlDestino.Add(FieldByName('EMPDES').AsString);
      End;

    With qryCadEmp, SQL Do
    Begin
      Add('SELECT');
      Add('  EMP_CODEMP AS CODEMP,');
      Add('  EMP_NOMEMP AS NOMEMP ');
      Add('FROM');
      Add('  CADEMP');
      Add('WHERE');
      Add('  EMP_CODEMP IN (' + fCommaText(stlDestino, True) + ')');

      Open;
    End;

    frmPedeEmpresaUnif.dtsCadEmp.DataSet := qryCadEmp;

    If stlDestino.Count = 1 Then
    Begin
      frmPedeEmpresaUnif.edtCodEmp.Text := stlDestino[0];
      frmPedeEmpresaUnif.edtNomEmp.Text := fRetNomeEmpresa(stlDestino[0]);
    End;

    Result := frmPedeEmpresaUnif.ShowModal = mrOk;

    If Result Then
      strEmpDes := frmPedeEmpresaUnif.edtCodEmp.Text;

    If VS_strCodEmp = strEmpDes Then
      strEmpDes := '';
  Finally
    pFreeAndNil(frmPedeEmpresaUnif);
    FreeAndNil(qryCadEmp);
    FreeAndNil(stlDestino);
  End;
End;

procedure TUnificacaoPedidos.pCarregaFornecedor;
  Var
    strSQL: String;
    qryConFor: TUniQuery;
begin
  qryConFor := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  FOR_CNDPAG, ';
  strSQL := strSQL + '  FOR_CARPAG  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FOR_CODFOR = :CODFOR ';

  With qryConFor, recFechamento Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODFOR').AsString := FCodFor;
    Open;

    strConPag      := FieldByName('FOR_CNDPAG').AsString;
    intCarPag      := FieldByName('FOR_CARPAG').AsInteger;
  End;

  FreeAndNil(qryConFor);
end;


Function TUnificacaoPedidos.fPedeObservacoes: Boolean;
  Var strNomEmp, strEndEmp, strCidEmp: String;
Begin
  pCarregaFornecedor;
  pCriarFormularios(TfrmDigObservacoes, frmDigObservacoes);
  Try
    objDuplicatasPedido.pCarregaParcelas('');

    With frmDigObservacoes, recFechamento Do
    Begin
      pnlDadosIniciais.Visible := True;
      gpbFinalPed.Visible := False;

      pDadosEntregaPedido(strNomEmp, strEndEmp, strCidEmp, VS_strCodEmp);

      frmDigObservacoes.intCarPag := recFechamento.intCarPag;

      frmDigObservacoes.mskCndPag.Text := strConPag;

      frmDigObservacoes.edtNomEmp.Text := strNomEmp;
      frmDigObservacoes.edtEndEmp.Text := strEndEmp;
      frmDigObservacoes.edtCidEmp.Text := strCidEmp;

      frmDigObservacoes.fltTotIte := fDoubleAggregate(cdsItens, 'SUM_TOTITE');

      frmDigObservacoes.fltTotPed := fDoubleAggregate(cdsItens, 'SUM_TOTITE') +
                                     fDoubleAggregate(cdsItens, 'SUM_TOTIPI') +
                                     fDoubleAggregate(cdsItens, 'SUM_TOTSUB') +
                                     fDoubleAggregate(cdsItens, 'SUM_SUBFCP') +
                                     fTotalImpostosReformaUnificacao;

      frmDigObservacoes.objDuplicatasPedido := Self.objDuplicatasPedido;

      ShowModal;

      Result := blnConfirma;

      If Result Then
      Begin
        If (not fEmptyDate(mskDtaPed.Text)) Then
          dtaDtaEnt := StrToDate(mskDtaPed.Text);
        If (not fEmptyDate(mskDtaFat.Text)) Then
          dtaDtaFat := StrToDate(mskDtaFat.Text);
        blnPagVis := chkPgAVis.Checked;
        strCodCmp := fRetCodVendedor(edtCodCmp.Text);
        strConPag := mskCndPag.Text;
        strCodTra := edtCodTra.Text;
        strCodTraRedespacho := edtCodTraRedespacho.Text;
        strNomTra := edtNomTra.Text;
        strEntTra := edtEndere.Text;
        strCidTra := edtCidade.Text;
        strTipFre := fTipoFrete(cmbTipFre.Text);
        strTipFreRedespacho := fTipoFrete(cmbTipFreRedespacho.Text);
        strNomEnt := edtNomEmp.Text;
        strEntEnt := edtEndEmp.Text;
        strCidEnt := edtCidEmp.Text;
        strCodEve := fraCentroCusto.edtCodEve.Text;
        strCodCta := fraPlanoDeContas.MskCodCta.Text;
        strPedVen := edtPedVen.Text;
        strObserv1  := Copy(memObserv.Lines.Text, 1, 240);
        strObserv2  := Copy(memObserv.Lines.Text, 241, 240);
        strObserv3  := Copy(memObserv.Lines.Text, 481, 240);
        strObserv4  := Copy(memObserv.Lines.Text, 721, 240);
        strObserv5  := Copy(memObserv.Lines.Text, 961, 240);
        strObserv6  := Copy(memObserv.Lines.Text, 1221, 240);

        strAtenca := edtAtenca.Text;
        strCodOco := edtCodOco.Text;
        fltValFre := fStrToFloat(edtValFre.Text);
        fltDesAce := fStrToFloat(edtDesAce.Text);
      End;

    End;
  Finally
    pFreeAndNil(frmDigObservacoes);
  End;
End;

Function TUnificacaoPedidos.fUnificaPedidos: Boolean;
Begin
  Try
    Result := False;

    If fEmptyStr(FEmpDesConsulta) Then
    Begin

      If Not fPedeEmpresaDestino(FEmpDes) Then
        Exit;

    End Else
    Begin

      FEmpDes := FEmpDesConsulta;
    End;

    pCarregaItens;

    If Not fPedeObservacoes Then
      Exit;

    If Not fVerificaPedidos Then
      Exit;

    pCriarFormularios(TfrmGravando, frmGravando);
    Try
      With frmGravando Do
      Begin
        lblGravando.Caption := 'Gravando pedido, aguarde...';
        fExecutarAcao := fUnificaPedidosPrg;
        ShowModal;
        Result := blnConfirma;
      End;

      If Result Then
      Begin
        stlPedidos.Clear;
        pMensagemOk('Novo pedido gerado: PD-' + FNumPed);
      End;
    Finally
      pFreeAndNil(frmGravando);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TUnificacaoPedidos.fUnificaPedidos');
    End;
  End;
End;

Function TUnificacaoPedidos.fUnificaPedidosPrg(prgProgressBar: TcxProgressBar): Boolean;
Begin
  Try
    prgProgressBar.Properties.Max := cdsItens.RecordCount * 2 + 2 + stlPedidos.Count;

    fStartTransaction;

    prgProgressBar.Position := prgProgressBar.Position + 1;
    Application.ProcessMessages;

    Result := fIniciaPedidoCompra;

    If Result Then
    Begin
      pGravaItens;

      Result := fBaixaPedidos;
    End;

    If Result Then
    Begin
      fCommit;

      objLock.pDestravarTodos;
    End Else
      fRollBack;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, 'TUnificacaoPedidos.fUnificaPedidos');
    End;
  End;
End;

Function TUnificacaoPedidos.fExcluiControleDeColetaAbertos(strAutInc: String): Boolean;
  Var
    qryItens: TUniQuery;
    strSQL: String;
Begin
  Result := True;
  strSQL := '';
  strSQL := strSQL + ' DELETE FROM CONCOL ';
  strSQL := strSQL + ' USING CONCOL, PCMGER, PCMDET ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '       PCMGER.AUTOINCREM = :AUTINC ';
  strSQL := strSQL + '   AND PCG_NUMPED = PCD_NUMPED ';
  strSQL := strSQL + '   AND PCG_CODEMP = PCD_CODEMP ';
  strSQL := strSQL + '   AND PCG_ESPDOC = PCD_ESPDOC ';
  strSQL := strSQL + '   AND PCG_NUMCTN = PCD_NUMCTN ';
  strSQL := strSQL + '   AND CON_AUTDET = PCMDET.AUTOINCREM ';
  strSQL := strSQL + '   AND PCD_BAIXAD = 0                 ';

  qryItens := fCriaQuery;
  Try
    qryItens.SQL.Text := strSQL;

    qryItens.ParamByName('AUTINC').AsString := strAutInc;
    qryItens.ExecSQL;
  Finally
    FreeAndNil(qryItens);
  End;
End;

Function TUnificacaoPedidos.fBaixaPedidos: Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;

  For intContador := 0 To stlPedidos.Count -1 Do
  Begin
    Result := fExcluiControleDeColetaAbertos(stlPedidos[intContador]) And
              fBaixaPedidoNaoEntregue(stlPedidos[intContador],
                                      'UNIFICADO NO PEDIDO ' + FNumPed + '-PD',
                                      recFechamento.strCodOco,
                                      False,
                                      opcSemRequisicao,
                                      0,
                                      '');

    If Not Result Then
      Break;

    frmGravando.pgbStatus.Position := frmGravando.pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;

End;

Function TUnificacaoPedidos.fSQLItens: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';

  strSQL := strSQL + '   PCD_CODITE AS CODITE, ';
  strSQL := strSQL + '   PCD_DESITE AS DESITE, ';
  strSQL := strSQL + '   PCD_CODUNI AS CODUNI, ';
  strSQL := strSQL + '   PCD_UNITAR AS UNITAR, ';
  strSQL := strSQL + '   PCD_DESUNI AS DESUNI, ';

  strSQL := strSQL + '   PCD_SUBUSU AS SUBUSU, ';

  strSQL := strSQL + '   IFNULL(PCD_DESUN2, 0) AS DESUN2, ';
  strSQL := strSQL + '   IFNULL(PCD_DESUN3, 0) AS DESUN3, ';
  strSQL := strSQL + '   IFNULL(PCD_DESUN4, 0) AS DESUN4, ';
  strSQL := strSQL + '   IFNULL(PCD_DESUN5, 0) AS DESUN5, ';
  strSQL := strSQL + '   IFNULL(PCD_DESUN6, 0) AS DESUN6, ';

  strSQL := strSQL + '   PCD_SEQFDO AS SEQFDO, ';
  strSQL := strSQL + '   IFNULL(PCD_EMBALA, 1) AS EMBALA, ';

  strSQL := strSQL + '   ITE_INCPIS AS INCPIS, ';

  strSQL := strSQL + '   IFNULL(PCD_PERIPI, 0) AS PERIPI, ';
  strSQL := strSQL + '   SUM(PCD_BASIPI) AS BASIPI, ';
  strSQL := strSQL + '   SUM(PCD_TOTIPI - PCD_IPIBAI) AS TOTIPI, ';

  strSQL := strSQL + '   IFNULL(PCD_ALQCBS, 0) AS ALQCBS, ';
  strSQL := strSQL + '   IFNULL(PCD_ALQIBS, 0) AS ALQIBS, ';
  strSQL := strSQL + '   IFNULL(PCD_ALQ_IS, 0) AS ALQ_IS, ';
  strSQL := strSQL + '   ROUND(SUM(IFNULL(PCD_VALCBS, 0) * (PCD_QTDITE - IFNULL(PCD_QTDBAI, 0)) / PCD_QTDITE), 2) AS VALCBS, ';
  strSQL := strSQL + '   ROUND(SUM(IFNULL(PCD_VALIBS, 0) * (PCD_QTDITE - IFNULL(PCD_QTDBAI, 0)) / PCD_QTDITE), 2) AS VALIBS, ';
  strSQL := strSQL + '   ROUND(SUM(IFNULL(PCD_VAL_IS, 0) * (PCD_QTDITE - IFNULL(PCD_QTDBAI, 0)) / PCD_QTDITE), 2) AS VAL_IS, ';

  strSQL := strSQL + '   SUM(PCD_BASPIS) AS BASPIS, ';
  strSQL := strSQL + '   SUM(PCD_VALPIS) AS VALPIS, ';

  strSQL := strSQL + '   SUM(PCD_BASCOF) AS BASCOF, ';
  strSQL := strSQL + '   SUM(PCD_VALCOF) AS VALCOF, ';

  strSQL := strSQL + '   PCD_ALQICM      AS ALQICM, ';
  strSQL := strSQL + '   SUM(PCD_BASICM) AS BASICM, ';
  strSQL := strSQL + '   SUM(PCD_VALICM) AS VALICM, ';
  strSQL := strSQL + '   SUM(PCD_DESPIS) AS DESPIS, ';

  strSQL := strSQL + '   PCD_PERSUB      AS PERSUB, ';
  strSQL := strSQL + '   PCD_PERFCP      AS PERFCP, ';
  strSQL := strSQL + '   SUM(PCD_TOTSUB - PCD_SUBBAI) AS TOTSUB, ';
  strSQL := strSQL + '   SUM(PCD_TOTDAR - IFNULL(PCD_DARBAI, 0)) AS TOTDAR, ';
  strSQL := strSQL + '   SUM(PCD_SUBFCP - PCD_FCPBAI) AS SUBFCP, ';
  strSQL := strSQL + '   SUM(PCD_BASSUB) AS BASSUB, ';
  strSQL := strSQL + '   SUM((PCD_QTDITE - IFNULL(PCD_QTDBAI, 0)) * PCD_UNITAR) AS TOTITE, ';

  strSQL := strSQL + '   SUM(PCD_VALFRE) AS VALFRE, ';
  strSQL := strSQL + '   SUM(PCD_DESACE) AS DESACE, ';

  strSQL := strSQL + '   SUM(ROUND(PCD_QTDITE - IFNULL(PCD_QTDBAI, 0), 4)) AS QTDITE, ';

  strSQL := strSQL + '   GROUP_CONCAT((SELECT GROUP_CONCAT(R.AUTOINCREM) FROM MOVRCD R WHERE R.RCD_SEQPCD = P.AUTOINCREM)) AS REQUISICOES ';
//  strSQL := strSQL + '   GROUP_CONCAT((SELECT QUOTE(R.AUTOINCREM) FROM MOVRCD R WHERE R.RCD_SEQPCD = P.AUTOINCREM)) AS REQUISICOES_QUOTED ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   PCMDET P ';

  strSQL := strSQL + ' INNER JOIN CADITE   ON ITE_CODITE = PCD_CODITE    ';

  strSQL := strSQL + ' INNER JOIN PCMGER G ON PCG_NUMPED = PCD_NUMPED AND ';
  strSQL := strSQL + '                        PCG_ESPDOC = PCD_ESPDOC AND ';
  strSQL := strSQL + '                        PCG_CODEMP = PCD_CODEMP     ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '   G.AUTOINCREM IN (' +  fCommaText(stlPedidos, True) + ') AND ';
  strSQL := strSQL + '   PCD_BAIXAD = 0 AND ';
  strSQL := strSQL + '   ROUND(PCD_QTDITE - IFNULL(PCD_QTDBAI, 0), 4) > 0 ';

  strSQL := strSQL + ' GROUP BY ';
  strSQL := strSQL + '   PCD_CODITE, PCD_CODUNI, PCD_UNITAR, PCD_DESUNI, PCD_DESUN2, PCD_DESUN3, PCD_DESUN4, PCD_DESUN5, PCD_DESUN6, PCD_PERIPI, ';
  strSQL := strSQL + '   IFNULL(PCD_ALQCBS, 0), IFNULL(PCD_ALQIBS, 0), IFNULL(PCD_ALQ_IS, 0), ';
  strSQL := strSQL + '   PCD_SEQFDO, IFNULL(PCD_EMBALA, 1) ';

  Result := strSQL;
End;

Procedure TUnificacaoPedidos.pCarregaItens;
Begin
  With cdsItens Do
  Begin
    Close;
    qryQuery.SQL.Text := fSQLItens;

    fAbreClient(True, 'TUnificacaoPedidos.pCarregaItens');
  End;
End;

function TUnificacaoPedidos.fTotalImpostosReformaUnificacao: Double;
begin
  Result := 0;
  If fSomarNovosImpostosDaReformaAoValorContabil Then
    Result := fDoubleAggregate(cdsItens, 'SUM_VALCBS') +
              fDoubleAggregate(cdsItens, 'SUM_VALIBS') +
              fDoubleAggregate(cdsItens, 'SUM_VAL_IS');
end;

function TUnificacaoPedidos.fIniciaPedidoCompra: Boolean;
  Var
    fltTotIPI,
    fltTotSub,
    fltTotDar,
    fltSubFCP,
    fltTotIte,
    fltTotGer,

    fltValCof,
    fltValPis,
    fltValIcm,
    fltDesPis,

    fltBasCof,
    fltBasIcm,
    fltBasIpi,
    fltBasSub,
    fltBasPis: Double;
Begin
  Try
    FNumPed := '';

    blnUsaColeta := fCfgSis('CONCOL', varBoolean) And (fCampoTabela('FOR_CONCOL', 'CADFOR', ['FOR_CODFOR'], [FCodFor]) = 'S');

    fltBasIpi := fDoubleAggregate(cdsItens, 'SUM_BASIPI');
    fltTotIPI := fDoubleAggregate(cdsItens, 'SUM_TOTIPI');

    fltBasSub := fDoubleAggregate(cdsItens, 'SUM_BASSUB');
    fltTotSub := fDoubleAggregate(cdsItens, 'SUM_TOTSUB');
    fltTotDar := fDoubleAggregate(cdsItens, 'SUM_TOTDAR');
    fltSubFCP := fDoubleAggregate(cdsItens, 'SUM_SUBFCP');

    fltBasCof := fDoubleAggregate(cdsItens, 'SUM_BASCOF');
    fltValCof := fDoubleAggregate(cdsItens, 'SUM_VALCOF');

    fltBasPis := fDoubleAggregate(cdsItens, 'SUM_BASPIS');
    fltValPis := fDoubleAggregate(cdsItens, 'SUM_VALPIS');

    fltBasIcm := fDoubleAggregate(cdsItens, 'SUM_BASICM');
    fltValIcm := fDoubleAggregate(cdsItens, 'SUM_VALICM');

    fltDesPis := fDoubleAggregate(cdsItens, 'SUM_DESPIS');;

    fltTotIte := fDoubleAggregate(cdsItens, 'SUM_TOTITE');

    fltTotGer := fDoubleAggregate(cdsItens, 'SUM_TOTITE') +
                 fDoubleAggregate(cdsItens, 'SUM_TOTSUB') +
                 fDoubleAggregate(cdsItens, 'SUM_SUBFCP') +
                 fDoubleAggregate(cdsItens, 'SUM_TOTIPI') +
                 fTotalImpostosReformaUnificacao
                  - IIF(blnZonaFranca, (fltValIcm + fltDesPis), 0);

    If fltTotIte > 0 Then
    Begin
      FNumPed := fSeqPedidoCompra;
      FDtaPed := VS_Date;
      FHorPed := fTime();

      With recFechamento Do
      pGravaPcmGer(False,
                   Nil,
                   objDuplicatasPedido,
                   FNumPed,                          // Número do Pedido
                   VS_strCodEmp,                     // Empresa
                   'PD',                             // Espécie (PD / OR)
                   FCodFor,                          // Fornecedor
                   strCodTra,                        // Transportadora
                   strCodTraRedespacho,                        // Transportadora
                   strConPag,                        // Cond. Pagamento
                   FDtaPed,                          // Data do Pedido
                   FHorPed,                          // Fora do Pedido
                   dtaDtaEnt,                        // Data de Entrega
                   strCodCmp,                        // Comprador
                   fltTotIpi,                        // Total de IPI
                   fltTotSub,                        // Total de SUB
                   fltTotDar,                        // Total de DARE
                   fltSubFCP,                        // Total de SUB FCP
                   fltTotIte,                        // Total de Itens

                   fltTotGer + fltValFre + fltDesAce,// Total de Itens+IPI+SUB

                   '',                               // Observação 1
                   '',                               // Observação 2
                   '',                               // Observação 3
                   '',                               // Observação 4
                   '',                               // Observação 5
                   strObser1,                        // Observ PD 1
                   strObser2,                        // Observ PD 2
                   strObser3,                        // Observ PD 3
                   strPedVen,                        // Pedido de venda
                   strAtenca,                        // Atenção de
                   strTipFre,                        // Tipo de Frete
                   strTipFreRedespacho,                        // Tipo de Frete
                   '',                               // Origem do Documento (Faturamento)
                   0,                                // Número do Container
                   'N',                              // Pedido de Importação?
                   'N',                              // Pedido Intrepostado
                   FEmpDes,                          // Codigo da empresa destino
                   0,                                // Desconto Adicionsl
                   'N',                              // Pedido Multi Lojas?
                   fltValFre,                        // fltValFre
                   fltDesAce,                        // fltDesAce
                   dtaDtaFat,                        // Data do Faturamento
                   strCodEve,                        // Código do Evento
                   strCodCta,                        // Centro de Custo
                   strNomEnt,
                   strEntEnt,
                   strCidEnt,
                   '',
                   nivNenhum,
                   0,
                   0,
                   0,
                   0,
                   fltBasCof,
                   fltValCof,
                   fltBasPis,
                   fltValPis,
                   fltBasIcm,
                   fltValIcm,
                   fltBasIpi,
                   fltBasSub,
                   IIF(fStatusCndPag(strConPag) = A_VISTA, 'S', 'N'),
                   '',
                   '',
                   'N',
                   'N',
                   'P',
                   0,
                   'N',
                   '',
                   0,
                   0,
                   fltDesPis,
                   FAutGer,
                   'N',
                   False,     // blnTabRestaura
                   '',        // strCodDig
                   '',        // strNumPok
                   moeReal,   // moeMoeda
                   'N',       // strPreOrc
                   'S',       // strBStFre
                   'S',       // strBStAce
                   '',        // strOrdCon
                   '',        // strTipCodFabProd
                   '',        // strObsPd4
                   '',        // strObsPd5
                   '',        // strObsPd6
                   'N',       // strIpiFre
                   False,     // blnPagamentoCartaoCredito
                   '',        // strObs006
                   fDoubleAggregate(cdsItens, 'SUM_VALCBS'),
                   fDoubleAggregate(cdsItens, 'SUM_VALIBS'),
                   fDoubleAggregate(cdsItens, 'SUM_VAL_IS'));

      strCampoSaldoAdd := fRetCampoAtualizaSaldoPedidoCompra(FAutGer,
                                                             '',
                                                             '',
                                                             blnLibPcm,
                                                             strForFil);

      frmGravando.pgbStatus.Position := frmGravando.pgbStatus.Position + 1;
      Application.ProcessMessages;

      Result := True;

    End Else
    Begin
      pMensagemOk('Não há itens para agrupar!');
      Result := False;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fIniciaPedidoCompra]');
    End;
  End;

End;

Procedure TUnificacaoPedidos.pGravaItens;
  Var
    strAutIncPcd: String;
    qryInsert: TUniquery;
    intQtdConCol: Integer;
Begin
  qryInsert := fCriaQuery;
  Try
    With cdsItens Do
    Begin
      First;

      intQtdConCol := 0;

      While Not Eof Do
      Begin
        strAutIncPcd :=  fRetAutoIncrem('PCMDET', VS_strCodEmp);

        qryInsert.SQL.Clear;
        With recFechamento Do
          qryInsert.SQL.Add(fGravaPcmDet(
                     intQtdConCol,
                     Nil,
                     blnUsaColeta,
                     '', // strEmpDes
                     strCampoSaldoSub,
                     strCampoSaldoAdd,
                     intDeqTpc,
                     FNumPed,                                  // Número do Pedido
                     VS_strCodEmp,                             // Empresa
                     'PD',                                     // Espécie (PD / OR)
                     FCodFor,                                  // Fornecedor
                     FieldByName('CODITE').AsString,           // Código Item
                     FieldByName('CODUNI').AsString,           // Código Unidade
                     dtaDtaEnt,                                // Data Entrega
                     FHorPed,                                  // Hora do Pedido
                     FDtaPed,                                  // Data do Pedido
                     strConPag,                                // Cond. Pagamento
                     FieldByName('DESITE').AsString,           // Descrição Item
                     FieldByName('QTDITE').AsFloat,            // Quantidade
                     FieldByName('UNITAR').AsFloat,            // Preço Unitario
                     FieldByName('DESUNI').AsFloat,            // % desconto 1 unitário
                     FieldByName('DESUN2').AsFloat,            // % desconto 2 unitário
                     FieldByName('DESUN3').AsFloat,            // % desconto 3 unitário
                     FieldByName('DESUN4').AsFloat,            // % desconto 4 unitário
                     FieldByName('DESUN5').AsFloat,            // % desconto 5 unitário
                     FieldByName('DESUN6').AsFloat,            // % desconto 6 unitário
                     FieldByName('TOTITE').AsFloat,            // Total Itens S
                     FieldByName('PERIPI').AsFloat,            // Percentual IPI
                     FieldByName('TOTIPI').AsFloat,            // Total IPI
                     FieldByName('PERSUB').AsFloat,            // Percentual SUB
                     FieldByName('TOTSUB').AsFloat,            // Total SUB
                     FieldByName('TOTDAR').AsFloat,            // Total DARE
                     FieldByName('PERFCP').AsFloat,            // Percentual SUB FCP
                     FieldByName('SUBFCP').AsFloat,            // Total SUB FCP
                     0,                                        // Quantidade Baixa
                     0,                                        // Total Baixado
                     0,                                        // IPI Baixado
                     0,                                        // SUB Baixado
                     0,                                        // DARE Baixado
                     0,                                        // SUB FCP Baixado
                     0,                                        // FRE Baixado
                     0,                                        // ACE Baixado
                     FieldByName('VALFRE').AsFloat,            // Frete
                     FieldByName('DESACE').AsFloat,            // Des Ace
                     0,                                        // Baixado?
                     '',                                       // Origem do Documento (Faturamento)
                     0,                                        // Número do Container
                     'N',                                      // Pedido de Importação?
                     'N',                                      // Pedido Intrepostado
                     'N',                                      // Proveninete de Importação?
                     0,
                     0,
                     strAutIncPcd,                             // Auto Incremento
                     '',                                       // Código do produto acabado
                     '',                                       // Empresa do produto acabado
                     '',                                       // Produto acabado? (S/N)
                     0,                                        // Conferencia de entrada
                     FieldByName('BASSUB').AsFloat,
                     FieldByName('BASIPI').AsFloat,
                     FieldByName('BASICM').AsFloat,
                     100,
                     FieldByName('ALQICM').AsFloat,
                     FieldByName('VALICM').AsFloat,
                     FieldByName('INCPIS').AsString = 'S',
                     FieldByName('REQUISICOES').AsString,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     FieldByName('SEQFDO').AsString,
                     FieldByName('EMBALA').AsFloat,

                     fltALPISP,
                     fltALCOFP,
                     FieldByName('SUBUSU').AsString,
                     FieldByName('DESPIS').AsFloat,
                     False, {blnTabRestaura}
                     '',    {strSeqGer}
                     True,  {blnInsere}
                     '',    {strAutoin}
                     False, {blnVeioAutIncPcdInclusao}
                     -1,    {fltQtdOrc}
                     0,     {dtaDatEdt}
                     0,     {fltUniLiq}
                     FieldByName('ALQCBS').AsFloat,
                     FieldByName('ALQIBS').AsFloat,
                     FieldByName('ALQ_IS').AsFloat,
                     FieldByName('VALCBS').AsFloat,
                     FieldByName('VALIBS').AsFloat,
                     FieldByName('VAL_IS').AsFloat));

        qryInsert.SQL.Text := TMontaSQLPedidoCompra.fAjustaAutoIncControleDeColeta(intQtdConCol, qryInsert.SQL.Text);

        qryInsert.ExecSQL;

        Next;

        frmGravando.pgbStatus.Position := frmGravando.pgbStatus.Position + 1;
        Application.ProcessMessages;
      End;

    End;

  Finally
    FreeAndNil(qryInsert);
  End;
End;

end.
