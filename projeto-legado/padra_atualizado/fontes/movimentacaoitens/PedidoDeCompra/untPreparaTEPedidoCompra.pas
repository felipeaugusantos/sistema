unit untPreparaTEPedidoCompra;

interface

Uses
  Classes, UniClientDataSet, DB, SysUtils, Forms, Windows, Controls,
  Uni, cxProgressBar, StrUtils, untTypesSistema, untPreparaGeracaoTE,
  untFuncoesRel, untCadLote, untZClient,
  untGravando, untFuncoesPedidoSimples;

Type


  TPreparaTEPedidoCompra = Class(TPreparaGeracaoTE)
  Private

    FOpcGir: TRecOpcoesGiro;

    FSoMarcados: Boolean;

    FEmpresas: TUniQuery;

    FEmpDes: String;

    frmGravando: TfrmGravando;

    Procedure pFiltraItensOriginais;

    Function fSQLItens: String;

    Function fGeraSpoolTransferenciaPrg(prgProgresso: TCxProgressBar): Boolean;

    Function fValidaRequisicoesPrg(prgProgresso: TcxProgressBar): Boolean;

    Function fGeraTransferenciaPrg(prgProgresso: TcxProgressBar): Boolean;
    procedure pApagaRes(strCodIte, strAutIncRes: String);

  Public

    strEmpresasOrigens: String;

    blnAgrupando,
    blnMediaAjustada,
    blnGerandoSpool,
    blnGerouTransferencia,
    blnComDadosProduto,
    blnMtlCom: Boolean;

    cdsFornecedoras: TUniClientDataSet;

    cdsItens: TZClient;

    cdsItensMult, cdsItensPed: TUniClientDataSet;

    pCalculaTotalItemQtdGrid: TDataSetNotifyEvent;

    Constructor Create(blnDadosPro: Boolean = False);  Overload;

    Destructor Destroy; Override;

    Procedure pAjustaDiasEstQtdTra(dataSet: TDataSet);

    Procedure pInicializaItem(strEmpDes: String; blnEnables: Boolean = True);
    procedure pCarregaRES(AAucIncRes: String);

    Procedure pVoltaQuantidades;

    Procedure pExcluiItem(strCodIte, strEmpDes: String; strAutIncRes: String = '');

    Function fGeraTransferencia(blnMarcados: Boolean = False): Boolean;

    Function fValidaQuantidades(fltQtdIte, fltQtdTra, fltQtdReq: Double;
                                blnRequisicaoAtendidaPelaTransferencia: Boolean): Boolean;

    Function fGeraSpoolTransferencia(recOpcGir: TRecOpcoesGiro): Boolean;

    Function fTemTransferencia: Boolean;

    Procedure pFiltraItensEdicao;

  Published

    Property recOpcGir: TRecOpcoesGiro Read FOpcGir;


  End;

implementation

Uses
  Math,
  Variants,
  untFuncoesSimples;

Constructor TPreparaTEPedidoCompra.Create(blnDadosPro: Boolean = False);
  Var
    indDef: TIndexDef;
Begin
  inherited Create;

  strEmpresasOrigens := '';

  blnAgrupando          := False;
  blnMediaAjustada      := False;
  blnGerandoSpool       := False;
  blnGerouTransferencia := False;

  FSoMarcados := False;

  blnComDadosProduto := blnDadosPro;

  blnMtlCom := False;

  pCalculaTotalItemQtdGrid := Nil;

  Try
    cdsItens := TZClient.Create(Nil, fSQLItens);
    cdsItens.pCriaSoma('QTDITE', 'TOT_QTDITE');

    cdsItens.BeforePost := pAjustaDiasEstQtdTra;

    If cdsItens.fAbreClient(True, 'TPreparaTEPedidoCompra.Create') Then
    Begin
      cdsItens.pAlinhaCampoCentro('CODEMP');
      cdsItens.pAlinhaCampoCentro('EMPDES');
      cdsItens.pAlinhaCampoCentro('CODITE');

      If cdsItens.FindField('SITITE') <> Nil Then
        cdsItens.pAlinhaCampoCentro('SITITE');

      If cdsItens.FindField('SIGUNI') <> Nil Then
        cdsItens.pAlinhaCampoCentro('SIGUNI');

      indDef := cdsItens.IndexDefs.AddIndexDef;
      indDef.Fields := 'SALUSU';
      indDef.Name := 'SALUSU';
      indDef.Options := [ixDescending];
    End;

    cdsFornecedoras := TUniClientDataSet.Create(Nil);

    FEmpresas := fCriaQuery;
    FEmpresas.SQL.Text := 'SELECT EMP_CODEMP, EMP_FORFIL FROM CADEMP';
    FEmpresas.Open;
    FEmpresas.KeyFields := 'EMP_CODEMP';

 Except
    FreeAndNil(FEmpresas);
    FreeAndNil(cdsFornecedoras);
    FreeAndNil(cdsItens);
    Raise;
  End;
End;

Destructor TPreparaTEPedidoCompra.Destroy;
Begin
  FreeAndNil(FEmpresas);
  FreeAndNil(cdsItens);
  FreeAndNil(cdsFornecedoras);

  inherited Destroy;
End;

Function TPreparaTEPedidoCompra.fSQLItens: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT   ';
  strSQL := strSQL + '   CAST(NULL AS CHAR('+IntToStr(fTamCodIte)+')) AS CODITE,  ';
  strSQL := strSQL + '   CAST(NULL AS CHAR('+IntToStr(fTamCodIte)+')) AS CODITE_GRUPO,  ';

  If blnComDadosProduto Then
  Begin
    strSQL := strSQL + '  CAST(NULL AS CHAR(4))  AS SIGUNI,  ';
    strSQL := strSQL + '  "N"                    AS MARDES,  ';
    strSQL := strSQL + '  CAST(NULL AS CHAR(70)) AS DESITE,  ';
    strSQL := strSQL + '  0.0000                 AS MINDES,  ';       // ESTOQUE MÍNIMO NO DESTINO
    strSQL := strSQL + '  0.0000                 AS SUGEST,  ';
    strSQL := strSQL + '  CAST(NULL AS CHAR(2))  AS SITITE,  ';

    strSQL := strSQL + '  0.0000                 AS SALFIS_DES,  ';
    strSQL := strSQL + '  0.0000                 AS SALDIS_DES,  ';
    strSQL := strSQL + '  0.0000                 AS SALBAS_DES,  ';
    strSQL := strSQL + '  0.0000                 AS DIAEST_DES,  ';
    strSQL := strSQL + '  0.0000                 AS DIATRA_DES,  ';

    strSQL := strSQL + '  0.0000                 AS AJUSTA_DES,  ';
    strSQL := strSQL + '  0.0000                 AS MEDIA__DES,  ';

    strSQL := strSQL + '  0.0000                 AS AJUSTA_ORI,  ';
    strSQL := strSQL + '  0.0000                 AS MEDIA__ORI,  ';

    strSQL := strSQL + '  0.0000                 AS QTDPEN_DES,  ';
  End;

  strSQL := strSQL + '   EMP_CODEMP AS EMPDES,  ';
  strSQL := strSQL + '   EMP_CODEMP AS CODEMP,  ';
  strSQL := strSQL + '   EMP_NOMEMP AS NOMEMP,  ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(255)) AS EMPORI, ';

  strSQL := strSQL + '   "P" AS ATEREQ,  ';

  strSQL := strSQL + '   CAST(NULL AS CHAR(500)) AS AUTREQ,  ';

  strSQL := strSQL + '   0.0000     AS QTDEXC,  ';       // QUANTIDADE EXCEDENTE  NA LOJA ORIGEM

  strSQL := strSQL + '   0.0000     AS SALFIS_ORI,  ';
  strSQL := strSQL + '   0.0000     AS SALDIS_ORI,  ';   // QUANTIDADE DISPONIVEL NA LOJA ORIGEM
  strSQL := strSQL + '   0.0000     AS SALBAS_ORI,  ';   // QUANTIDADE DISPONIVEL NA LOJA ORIGEM
  strSQL := strSQL + '   0.0000     AS DIAEST_ORI,  ';

  strSQL := strSQL + '   0.0000     AS ESTMIN,  ';
  strSQL := strSQL + '   0.0000     AS SALUSU,  ';
  strSQL := strSQL + '   0.0000     AS QTDITE,  ';
  strSQL := strSQL + '   0.0000     AS QTDANT,  ';

  strSQL := strSQL + '   "N"        AS QTDALT,  ';

  strSQL := strSQL + '   CAST(NULL AS CHAR(30)) AS  NUMLOT,  ';
  strSQL := strSQL + '   0.0000     AS PESOIT   ';
  strSQL := strSQL + ' FROM     ';
  strSQL := strSQL + '   CADEMP ';
  strSQL := strSQL + ' WHERE FALSE ';

  Result := strSQL;
End;

Procedure TPreparaTEPedidoCompra.pInicializaItem(strEmpDes: String; blnEnables: Boolean = True);
  Var
    strNumLot: String;
    intRecNo : Integer;
    fltSalFisDestino,
    fltSalDisDestino,
    fltSalBasDestino,
    fltDiaEstDestino,
    fltEstMinDestino,
    fltAjustaDestino,
    fltMedia_Destino,
    fltQtdPenDestino,
    fltQtdIte: Double;
Begin
  FEmpDes := strEmpDes;

  If Not cdsItensMult.Filtered Then
    Exit;

  If cdsItensMult.IsEmpty Then
    Exit;

  If cdsItensPed.IsEmpty Then
    Exit;

  If cdsItensPed.FieldByName('ITE_CODITE').AsString <> cdsItensMult.FieldByName('ITE_CODITE').AsString Then
    Exit;

  intRecNo := cdsItensMult.RecNo;

  Try
    If cdsItensMult.FieldByName('ITE_CODEMP').AsString <> FEmpDes Then
      cdsItensMult.Locate('ITE_CODEMP', FEmpDes, []);

    fltSalFisDestino := cdsItensMult.FieldByName('ITE_SALFIS').AsFloat;
    fltSalDisDestino := cdsItensMult.FieldByName('ITE_SALDIS').AsFloat;
    fltSalBasDestino := cdsItensMult.FieldByName('ITE_SALBAS').AsFloat;
    fltDiaEstDestino := cdsItensMult.FieldByName('ITE_DIAEST').AsFloat;
    fltEstMinDestino := cdsItensMult.FieldByName('ITE_ESTMIN').AsFloat;
    fltAjustaDestino := cdsItensMult.FieldByName('ITE_AJUSTA').AsFloat;
    fltMedia_Destino := cdsItensMult.FieldByName('ITE_MEDIA_').AsFloat;
    fltQtdPenDestino := cdsItensMult.FieldByName('ITE_QTDPEN').AsFloat;
    fltQtdIte        := cdsItensMult.FieldByName('ITE_QTDITE').AsFloat;

    cdsItens.IndexFieldNames := 'CODITE;EMPDES';
    cdsItens.Filter   := 'CODITE = ' + QuotedStr(cdsItensMult.FieldByName('ITE_CODITE').AsString) + ' AND EMPDES = ' + QuotedStr(strEmpDes);
    cdsItens.Filtered := True;

    If Not cdsItens.IsEmpty Then
      Exit;

    If objCadLot.fExisteLote(cdsItensPed.FieldByName('ITE_CODITE').AsString, strEmpDes, '', False) Then
      strNumLot := 'A DEFINIR'
    Else
      strNumLot := '';

    If blnEnables Then
      cdsItensMult.DisableControls;

    cdsItensMult.First;

    While Not cdsItensMult.Eof Do
    Begin

      If (cdsItensMult.FieldByName('ITE_CODEMP').AsString <> strEmpDes) And
         ((recOpcGir.opcChamada <> chaSpoolTransferencia) Or ((recOpcGir.opcChamada = chaSpoolTransferencia) And (Pos(strEmpDes, recOpcGir.strEmpresasDestino) > 0))) Then
      Begin
        cdsItens.Append;
        cdsItens.FieldByName('EMPDES').AsString := strEmpDes;

        cdsItens.FieldByName('CODITE').AsString := cdsItensMult.FieldByName('ITE_CODITE').AsString;
        cdsItens.FieldByName('CODEMP').AsString := cdsItensMult.FieldByName('ITE_CODEMP').AsString;

        cdsItens.FieldByName('NOMEMP').AsString := cdsItensMult.FieldByName('ITE_DESEMP').AsString;

        cdsItens.FieldByName('EMPORI').AsString := Concat(cdsItensMult.FieldByName('ITE_CODEMP').AsString, ' - ',
                                                          cdsItensMult.FieldByName('ITE_DESEMP').AsString);

        If FEmpresas.FindKey([cdsItensMult.FieldByName('ITE_CODEMP').AsString]) And
           (Not fEmptyStr(FEmpresas.FieldByName('EMP_FORFIL').AsString)) Then

        cdsItens.FieldByName('EMPORI').AsString := cdsItens.FieldByName('EMPORI').AsString + ' (FORN. ' + FEmpresas.FieldByName('EMP_FORFIL').AsString + ')';

        cdsItens.FieldByName('ESTMIN').Value    := cdsItensMult.FieldByName('ITE_ESTMIN').Value;

        cdsItens.FieldByName('SALFIS_ORI').Value:= cdsItensMult.FieldByName('ITE_SALFIS').Value;
        cdsItens.FieldByName('SALDIS_ORI').Value:= cdsItensMult.FieldByName('ITE_SALDIS').Value;
        cdsItens.FieldByName('SALBAS_ORI').Value:= cdsItensMult.FieldByName('ITE_SALBAS').Value;

        cdsItens.FieldByName('DIAEST_ORI').Value:= cdsItensMult.FieldByName('ITE_DIAEST').Value;

        cdsItens.FieldByName('QTDEXC').AsFloat :=  cdsItensMult.FieldByName('ITE_QTDEXC').AsFloat;

        cdsItens.FieldByName('SALUSU').AsFloat  := cdsItensMult.FieldByName('ITE_SALBAS').Value - cdsItensMult.FieldByName('ITE_ESTMIN').Value;

        If cdsItens.FieldByName('SALUSU').AsFloat < 0 Then
          cdsItens.FieldByName('SALUSU').AsFloat := 0;

        cdsItens.FieldByName('QTDITE').Value    := 0;
        cdsItens.FieldByName('QTDANT').Value    := 0;

        cdsItens.FieldByName('QTDALT').AsString := 'N';

        cdsItens.FieldByName('NUMLOT').AsString := strNumLot;

        cdsItens.FieldByName('AUTREQ').AsString := cdsItensMult.FieldByName('ITE_INCIRQ').AsString;

        If blnComDadosProduto Then
        Begin
          cdsItens.FieldByName('DESITE').AsString := cdsItensMult.FieldByName('ITE_DESITE').AsString;
          cdsItens.FieldByName('SIGUNI').AsString := cdsItensMult.FieldByName('ITE_SIGUNI').AsString;

          cdsItens.FieldByName('AJUSTA_ORI').AsFloat  := cdsItensMult.FieldByName('ITE_AJUSTA').AsFloat;
          cdsItens.FieldByName('MEDIA__ORI').AsFloat  := cdsItensMult.FieldByName('ITE_MEDIA_').AsFloat;

          cdsItens.FieldByName('SALFIS_DES').AsFloat  := fltSalFisDestino;
          cdsItens.FieldByName('SALDIS_DES').AsFloat  := fltSalDisDestino;
          cdsItens.FieldByName('SALBAS_DES').AsFloat  := fltSalBasDestino;
          cdsItens.FieldByName('DIAEST_DES').AsFloat  := fltDiaEstDestino;
          cdsItens.FieldByName('AJUSTA_DES').AsFloat  := fltAjustaDestino;
          cdsItens.FieldByName('MEDIA__DES').AsFloat  := fltMedia_Destino;
          cdsItens.FieldByName('QTDPEN_DES').AsFloat  := fltQtdPenDestino;

          cdsItens.FieldByName('MINDES').AsFloat  := fltEstMinDestino;
          cdsItens.FieldByName('SUGEST').AsFloat  := fltQtdIte;

          If cdsItens.FieldByName('SALBAS_DES').AsFloat <= 0 Then
            cdsItens.FieldByName('SITITE').AsString := 'S0'

          Else If cdsItens.FieldByName('SALBAS_DES').AsFloat < cdsItens.FieldByName('MINDES').AsFloat Then
            cdsItens.FieldByName('SITITE').AsString := 'AB'

          Else If cdsItens.FieldByName('SALBAS_DES').AsFloat >= cdsItens.FieldByName('MINDES').AsFloat Then
            cdsItens.FieldByName('SITITE').AsString := 'AC';
        End;

        cdsItens.FieldByName('PESOIT').AsFloat := fCampoTabela('ITE_PESOIT', 'CADITE', ['ITE_CODITE'], [cdsItens.FieldByName('CODITE').AsString]);

        cdsItens.Post;
      End;

      cdsItensMult.Next;
    End;

  Finally

    If blnEnables Then
    Begin
      cdsItensMult.RecNo := intRecNo;
      cdsItensMult.EnableControls;
    End;

  End;

End;

Procedure TPreparaTEPedidoCompra.pExcluiItem(strCodIte, strEmpDes: String; strAutIncRes: String = '');
Begin
  If Not Assigned(cdsItens) Then
    Exit;

  If Not cdsItens.Active Then
    Exit;

  If fEmptyStr(strEmpDes) Then
  Begin
    cdsItens.IndexFieldNames := 'CODITE';
    cdsItens.Filter := 'CODITE = ' + QuotedStr(strCodIte);
  End Else
  Begin
    cdsItens.IndexFieldNames := 'CODITE;EMPDES';
    cdsItens.Filter := 'CODITE = ' + QuotedStr(strCodIte) + ' AND EMPDES = ' + QuotedStr(strEmpDes);
  End;

  cdsItens.Filtered := True;

  While Not cdsItens.Eof Do
  begin
    pApagaRes(strCodIte, strAutIncRes);
    cdsItens.Delete;
  End;
End;

Function TPreparaTEPedidoCompra.fGeraTransferencia(blnMarcados: Boolean = False): Boolean;
Begin
  FSoMarcados := blnMarcados;

  Result := TfrmGravando.fExecuta(fGeraTransferenciaPrg, frmGravando, 'Gerando transferências, aguarde...');
End;

Function TPreparaTEPedidoCompra.fTemTransferencia: Boolean;
Begin
  Try
    cdsItens.DisableControls;
    cdsItens.Filter   := 'QTDITE > 0';
    cdsItens.Filtered := True;

    Result := cdsItens.RecordCount > 0;

  Finally
    cdsItens.EnableControls;
  End;
End;

Function TPreparaTEPedidoCompra.fGeraTransferenciaPrg(prgProgresso: TcxProgressBar): Boolean;
  Var
    stlListaReq: TStringList;
    qryMovRcd: TUniQuery;
    strNumLot: String;
Begin
  Try
    blnGerouTransferencia := False;

    If cdsItens.State = dsEdit Then
      cdsItens.Post;

    cdsItens.DisableControls;

    qryMovRcd := fCriaQuery;

    Result := True;

    stlListaReq := TStringList.Create;

    cdsItens.IndexFieldNames := 'CODEMP;EMPDES;CODITE';

    If FSoMarcados Then
      cdsItens.Filter   := 'QTDITE > 0 AND MARDES = ' + QuotedStr('S')
    Else
      cdsItens.Filter   := 'QTDITE > 0';

    cdsItens.Filtered := True;

    If FSoMarcados And (cdsItens.RecordCount = 0) Then
    Begin
      pMensagemOk('Não há itens selecionados com quantidade maior que zero para transferir!');
      Result := False;
      Exit;
    End;

    cdsItens.First;

    prgProgresso.Properties.Max := cdsItens.RecordCount;

    While Not cdsItens.Eof Do
    Begin
      stlListaReq.CommaText := cdsItens.FieldByName('AUTREQ').AsString;

      // DEVE BAIXAR AS REQUISIÇÕES ATENDIDAS POR TRANSFEÊNCIA
      If (cdsItens.FieldByName('ATEREQ').AsString = 'T') And (stlListaReq.Count > 0) Then
      Begin
        qryMovRcd.Close;
        qryMovRcd.SQL.Text := 'UPDATE MOVRCD SET RCD_ATETRA = 1 WHERE AUTOINCREM IN (' +  fCommaText(stlListaReq, True) + ')';
        qryMovRcd.ExecSQL;
      End;

      If objCadLot.fExisteLote(cdsItensPed.FieldByName('ITE_CODITE').AsString, cdsItens.FieldByName('CODEMP').AsString, cdsItens.FieldByName('NUMLOT').AsString, False) Then
        strNumLot := cdsItens.FieldByName('NUMLOT').AsString
      Else
        strNumLot := '';

      Result := Result And fSalvaPreparacao(cdsItens.FieldByName('CODITE').AsString,
                              strNumLot,
                              cdsItens.FieldByName('CODEMP').AsString,
                              cdsItens.FieldByName('EMPDES').AsString,
                              cdsItens.FieldByName('QTDITE').AsFloat,
                              False,
                              stlListaReq,
                              False);

      blnGerouTransferencia := Result;

      If Not Result Then
        Break;

      cdsItens.Next;

      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    FreeAndNil(stlListaReq);
    FreeAndNil(qryMovRcd);

  Finally
    pFiltraItensEdicao;

    cdsItens.EnableControls;
  End;

End;

Procedure TPreparaTEPedidoCompra.pVoltaQuantidades;
Begin
  cdsItens.First;

  While Not cdsItens.Eof Do
  Begin
    cdsItens.Edit;
    cdsItens.FieldByName('QTDITE').Value := cdsItens.FieldByName('QTDANT').Value;
    cdsItens.Post;

    cdsItens.Next;
  End;
End;

Function TPreparaTEPedidoCompra.fValidaQuantidades(fltQtdIte, fltQtdTra, fltQtdReq: Double;
                                                   blnRequisicaoAtendidaPelaTransferencia: Boolean): Boolean;
  Var
    fltQAtReq,
    fltQAtReqAnt,
    fltQtdTraAnt,
    fltQtdIteAnt: Double;
Begin
  Result := True;

  If (RoundTo(fltQtdIte, -4) < RoundTo(fltQtdReq, -4)) And (RoundTo(fltQtdTra, -4) < RoundTo(fltQtdReq, -4)) Then
  Begin
    Result := False;
    pMensagemOk('A requisição deve ser atendida completamente ou pelo pedido de compra ou pela transferência!');
    Exit;
  End;

  fltQtdIte := fltQtdIte / IIF(cdsItensPed.FieldByName('ITE_QTDEMB').AsFloat = 0, 1, cdsItensPed.FieldByName('ITE_QTDEMB').AsFloat);

  If Not cdsItensMult.Locate('ITE_CODEMP;ITE_CODITE', VarArrayOf([FEmpDes, cdsItensPed.FieldByName('ITE_CODITE').AsString]), []) Then
  Begin
    pMensagemOk('Erro interno - Item não econtrado!');
    Exit;
  End;

  cdsItens.DisableControls;

  Try
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      cdsItens.Edit;

      cdsItens.FieldByName('QTDANT').Value := cdsItens.FieldByName('QTDITE').Value;

      If blnRequisicaoAtendidaPelaTransferencia And (cdsItens.FieldByName('QTDITE').AsFloat > 0) Then
      Begin
        cdsItens.FieldByName('ATEREQ').AsString := 'T';
        cdsItens.FieldByName('AUTREQ').AsString := cdsItensMult.FieldByName('ITE_INCIRQ').AsString;
      End Else
      Begin
        cdsItens.FieldByName('ATEREQ').Clear;
        cdsItens.FieldByName('AUTREQ').AsString := '';
      End;

      cdsItens.Post;

      cdsItens.Next;
    End;

    fltQtdIteAnt := cdsItensMult.FieldByName('ITE_QTDITE').AsFloat;
    fltQtdTraAnt := cdsItensMult.FieldByName('ITE_QTDTRA').AsFloat;

    If cdsItensMult.FieldByName('ITE_ATEREQ').AsString = 'T' Then
      fltQAtReqAnt := 0
    Else
      fltQAtReqAnt := cdsItensMult.FieldByName('ITE_QTDREQ').AsFloat;

    cdsItensMult.Edit;
    cdsItensMult.FieldByName('ITE_QTDTRA').AsFloat := fltQtdTra;
    cdsItensMult.FieldByName('ITE_QTDITE').AsFloat := fltQtdIte;

    fltQAtReq := fltQtdReq;

    If blnRequisicaoAtendidaPelaTransferencia And (fltQtdReq > 0) Then
    Begin
      cdsItensMult.FieldByName('ITE_ATEREQ').AsString := 'T';
      fltQAtReq := 0;
    End Else
    Begin
      cdsItensMult.FieldByName('ITE_ATEREQ').Clear;
    End;

    If Assigned(pCalculaTotalItemQtdGrid) Then
      pCalculaTotalItemQtdGrid(cdsItensMult);

    cdsItensMult.Post;

    cdsItensPed.Edit;
    cdsItensPed.FieldByName('ITE_QTDITE').AsFloat := cdsItensPed.FieldByName('ITE_QTDITE').AsFloat + (fltQtdIte - fltQtdIteAnt);
    cdsItensPed.FieldByName('ITE_QTDTRA').AsFloat := cdsItensPed.FieldByName('ITE_QTDTRA').AsFloat + (fltQtdTra - fltQtdTraAnt);
    cdsItensPed.FieldByName('ITE_QATREQ').AsFloat := cdsItensPed.FieldByName('ITE_QATREQ').AsFloat + (fltQAtReq - fltQAtReqAnt);

    If Assigned(pCalculaTotalItemQtdGrid) Then
      pCalculaTotalItemQtdGrid(cdsItensPed);

    cdsItensPed.Post;

  Finally
    cdsItens.EnableControls;
  End;

End;

Function TPreparaTEPedidoCompra.fGeraSpoolTransferencia(recOpcGir: TRecOpcoesGiro): Boolean;
begin
  blnGerandoSpool       := True;

  FOpcGir := recOpcGir;

  Result := TfrmGravando.fExecuta(fGeraSpoolTransferenciaPrg, frmGravando, 'Calculando transferências, aguarde...');

  blnGerandoSpool       := False;
End;

Procedure TPreparaTEPedidoCompra.pAjustaDiasEstQtdTra(dataSet: TDataSet);
Begin
  With DataSet Do
  Begin
    FieldByName('CODITE_GRUPO').AsString := FieldByName('CODITE').AsString;

    If Assigned(FindField('MEDIA__DES')) And (IIF(FOpcGir.blnMedAju, FieldByName('AJUSTA_DES').AsFloat, FieldByName('MEDIA__DES').AsFloat) > 0) Then
      FieldByName('DIATRA_DES').AsInteger := Trunc((FieldByName('SALBAS_DES').AsFloat + FieldByName('QTDITE').AsFloat +
                                                     IfThen(FOpcGir.blnConsPedPen, FieldByName('QTDPEN_DES').AsFloat)) /
                                                                           (IIF(FOpcGir.blnMedAju,
                                                                                 FieldByName('AJUSTA_DES').AsFloat,
                                                                                 FieldByName('MEDIA__DES').AsFloat) / 30));
  End;
End;

Procedure TPreparaTEPedidoCompra.pFiltraItensOriginais;
Begin
  If Not recOpcGir.blnAllIte Then
  Begin
    cdsItensPed.Filter   := 'ITE_QTDITE > 0';
    cdsItensPed.Filtered := True;
  End Else
  Begin
    cdsItensPed.Filtered := False;
  End;
End;

Procedure TPreparaTEPedidoCompra.pFiltraItensEdicao;
Begin
  If recOpcGir.blnAllIte Then
    cdsItens.Filter   := 'QTDEXC > 0'
  Else
    cdsItens.Filter   := 'QTDANT > 0';

  cdsItens.Filtered := True;
End;

procedure TPreparaTEPedidoCompra.pApagaRes(strCodIte, strAutIncRes: String);
var qryDelete: TUniQuery;
begin
  qryDelete := fCriaQuery;
  Try
    qryDelete.SQL.Add('DELETE FROM PCDTRA_RES');
    qryDelete.SQL.Add(' WHERE AUTOINCREM = "'+strAutIncRes+'"');
    qryDelete.SQL.Add('   AND TRA_CODITE = "'+strCodIte+'"');
    qryDelete.ExecSQL;
  Finally
    FreeAndNil(qryDelete);
  End;
end;

procedure TPreparaTEPedidoCompra.pCarregaRES(AAucIncRes: String);
var qryRes: TUniQuery;
    fltSalFisDestino,
    fltSalDisDestino,
    fltSalBasDestino,
    fltDiaEstDestino,
    fltEstMinDestino,
    fltAjustaDestino,
    fltMedia_Destino,
    fltQtdPenDestino,
    fltQtdIte: Double;
    strNumLot: String;

    cdsItensEnabled,
    cdsItensMultEnabled,
    cdsItensPedEnabled: Boolean;

begin
  cdsItensEnabled := False;
  cdsItensMultEnabled := False;
  cdsItensPedEnabled := False;

  If Not cdsItens.ControlsDisabled Then
  begin
    cdsItens.DisableControls;
    cdsItensEnabled := True;
  End;
  If Not cdsItensMult.ControlsDisabled Then
  begin
    cdsItensMult.DisableControls;
    cdsItensMultEnabled := True;
  End;
  If Not cdsItensPed.ControlsDisabled Then
  begin
    cdsItensPed.DisableControls;
    cdsItensPedEnabled := True;
  End;

  Try


    qryRes := fCriaQuery;
    Try
      qryRes.SQL.Add('SELECT PCDTRA_RES.*, EO.EMP_NOMEMP FROM PCDTRA_RES');
      qryRes.SQL.Add('INNER JOIN CADEMP EO ON EO.EMP_CODEMP = TRA_EMPORI');
      qryRes.SQL.Add(' WHERE TRA_SEQGER = "'+AAucIncRes+'"');
      qryRes.Open;

      while not qryRes.Eof Do
      Begin
        cdsItensMult.Locate('ITE_CODEMP;ITE_CODITE', VarArrayOF([qryRes.FieldByName('TRA_EMPORI').AsString, qryRes.FieldByName('TRA_CODITE').AsString]), []);

        fltSalFisDestino := cdsItensMult.FieldByName('ITE_SALFIS').AsFloat;
        fltSalDisDestino := cdsItensMult.FieldByName('ITE_SALDIS').AsFloat;
        fltSalBasDestino := cdsItensMult.FieldByName('ITE_SALBAS').AsFloat;
        fltDiaEstDestino := cdsItensMult.FieldByName('ITE_DIAEST').AsFloat;
        fltEstMinDestino := cdsItensMult.FieldByName('ITE_ESTMIN').AsFloat;
        fltAjustaDestino := cdsItensMult.FieldByName('ITE_AJUSTA').AsFloat;
        fltMedia_Destino := cdsItensMult.FieldByName('ITE_MEDIA_').AsFloat;
        fltQtdPenDestino := cdsItensMult.FieldByName('ITE_QTDPEN').AsFloat;
        fltQtdIte        := qryRes.FieldByName('TRA_QTDTRA').AsFloat;


        If objCadLot.fExisteLote(qryRes.FieldByName('TRA_CODITE').AsString, qryRes.FieldByName('TRA_EMPDES').AsString, '', False) Then
           strNumLot := 'A DEFINIR'
        Else
          strNumLot := '';


        cdsItens.Append;
        cdsItens.FieldByName('EMPDES').AsString := qryRes.FieldByName('TRA_EMPDES').AsString;

        cdsItens.FieldByName('CODITE').AsString := cdsItensMult.FieldByName('ITE_CODITE').AsString;
        cdsItens.FieldByName('CODEMP').AsString := qryRes.FieldByName('TRA_EMPORI').AsString;
        cdsItens.FieldByName('NOMEMP').AsString := qryRes.FieldByName('EMP_NOMEMP').AsString;
        cdsItens.FieldByName('ESTMIN').Value    := cdsItensMult.FieldByName('ITE_ESTMIN').Value;

        cdsItens.FieldByName('SALFIS_ORI').Value:= cdsItensMult.FieldByName('ITE_SALFIS').Value;
        cdsItens.FieldByName('SALDIS_ORI').Value:= cdsItensMult.FieldByName('ITE_SALDIS').Value;
        cdsItens.FieldByName('SALBAS_ORI').Value:= cdsItensMult.FieldByName('ITE_SALBAS').Value;
        cdsItens.FieldByName('DIAEST_ORI').Value:= cdsItensMult.FieldByName('ITE_DIAEST').Value;

        cdsItens.FieldByName('SALUSU').AsFloat  := cdsItensMult.FieldByName('ITE_SALBAS').Value - cdsItensMult.FieldByName('ITE_ESTMIN').Value;

        If cdsItens.FieldByName('SALUSU').AsFloat < 0 Then
          cdsItens.FieldByName('SALUSU').AsFloat := 0;

        cdsItens.FieldByName('QTDITE').Value    := 0;
        cdsItens.FieldByName('QTDANT').Value    := 0;

        cdsItens.FieldByName('QTDALT').AsString := 'N';

        cdsItens.FieldByName('NUMLOT').AsString := strNumLot;

        cdsItens.FieldByName('AUTREQ').AsString := cdsItensMult.FieldByName('ITE_INCIRQ').AsString;
        cdsItens.FieldByName('QTDITE').AsFloat := fltQtdIte;

        If blnComDadosProduto Then
        Begin
          cdsItens.FieldByName('DESITE').AsString := cdsItensMult.FieldByName('ITE_DESITE').AsString;
          cdsItens.FieldByName('SIGUNI').AsString := cdsItensMult.FieldByName('ITE_SIGUNI').AsString;

          cdsItens.FieldByName('AJUSTA_ORI').AsFloat  := cdsItensMult.FieldByName('ITE_AJUSTA').AsFloat;
          cdsItens.FieldByName('MEDIA__ORI').AsFloat  := cdsItensMult.FieldByName('ITE_MEDIA_').AsFloat;

          cdsItens.FieldByName('SALFIS_DES').AsFloat  := fltSalFisDestino;
          cdsItens.FieldByName('SALDIS_DES').AsFloat  := fltSalDisDestino;
          cdsItens.FieldByName('SALBAS_DES').AsFloat  := fltSalBasDestino;
          cdsItens.FieldByName('DIAEST_DES').AsFloat  := fltDiaEstDestino;
          cdsItens.FieldByName('AJUSTA_DES').AsFloat  := fltAjustaDestino;
          cdsItens.FieldByName('MEDIA__DES').AsFloat  := fltMedia_Destino;
          cdsItens.FieldByName('QTDPEN_DES').AsFloat  := fltQtdPenDestino;

          cdsItens.FieldByName('MINDES').AsFloat  := fltEstMinDestino;
          cdsItens.FieldByName('SUGEST').AsFloat  := fltQtdIte;

          If cdsItens.FieldByName('SALBAS_DES').AsFloat <= 0 Then
            cdsItens.FieldByName('SITITE').AsString := 'S0'
          Else If cdsItens.FieldByName('SALBAS_DES').AsFloat < cdsItens.FieldByName('MINDES').AsFloat Then
            cdsItens.FieldByName('SITITE').AsString := 'AB'

          Else If cdsItens.FieldByName('SALBAS_DES').AsFloat >= cdsItens.FieldByName('MINDES').AsFloat Then
            cdsItens.FieldByName('SITITE').AsString := 'AC';
        End;

        cdsItens.Post;

        qryRes.Next;
      End;


      qryRes.SQL.Clear;
      qryRes.SQL.Add('SELECT TRA_EMPDES, TRA_CODITE, SUM(TRA_QTDTRA) AS QTD  FROM PCDTRA_RES');
      qryRes.SQL.Add(' WHERE TRA_SEQGER = "'+AAucIncRes+'"');
      qryRes.SQL.Add('   AND TRA_QTDTRA > 0');
      qryRes.SQL.Add(' GROUP BY TRA_EMPDES, TRA_CODITE');
      qryRes.Open;
      cdsItensMult.First;
      while not qryRes.Eof Do
      begin
        If cdsItensMult.Locate('ITE_CODEMP;ITE_CODITE', VarArrayOF([qryRes.FieldByName('TRA_EMPDES').AsString, qryRes.FieldByName('TRA_CODITE').AsString]), []) Then
          Begin
          cdsItensMult.Edit;
          cdsItensMult.FieldByName('ITE_QTDTRA').AsFloat := qryRes.FieldByName('QTD').AsFloat;
          cdsItensMult.Post;
        End;
        qryRes.Next;
      End;

      qryRes.SQL.Clear;
      qryRes.SQL.Add('SELECT TRA_CODITE, SUM(TRA_QTDTRA) AS QTD  FROM PCDTRA_RES');
      qryRes.SQL.Add(' WHERE TRA_SEQGER = "'+AAucIncRes+'"');
      qryRes.SQL.Add('   AND TRA_QTDTRA > 0');
      qryRes.SQL.Add(' GROUP BY TRA_CODITE');
      qryRes.Open;
      cdsItensPed.First;
      while not qryRes.Eof Do
      begin
        If cdsItensPed.Locate('ITE_CODITE', qryRes.FieldByName('TRA_CODITE').AsString, []) Then
        begin
          cdsItensPed.Edit;
          cdsItensPed.FieldByName('ITE_QTDTRA').AsFloat := qryRes.FieldByName('QTD').AsFloat;
          cdsItensPed.FieldByName('ITE_QTDALT').AsString := IIf(cdsItensPed.FieldByName('ITE_TRAINC').AsFloat <>
                                                                cdsItensPed.FieldByName('ITE_QTDTRA').AsFloat, 'S', 'N');
          cdsItensPed.Post;
        End;
        qryRes.Next;
      End;



    Finally
      FreeAndNIl(qryRes);
    End;
  Finally
    If cdsItensEnabled Then
      cdsItens.EnableControls;
    If cdsItensMultEnabled Then
      cdsItensMult.EnableControls;
    If cdsItensPedEnabled Then
      cdsItensPed.EnableControls;
  End;
end;

Function TPreparaTEPedidoCompra.fGeraSpoolTransferenciaPrg(prgProgresso: TCxProgressBar): Boolean;
  Var
    blnHabilitaPed,
    blnHabilitaMult,
    blnTemExcednte: Boolean;
    fltQtdExc: Double;

    strCodIte: String;

    prcAfterPost: TprcScroll;

    stlLisEmp: TStringList;

    blnFiltered: Boolean;
    strIndex,
    strFilter: String;
    eveAfterScroll: TDataSetNotifyEvent;

    Procedure pCalculaQuantidadeExcedente;
      Var
        strMedia: String;
    Begin
      If blnMediaAjustada Then
        strMedia := 'ITE_AJUSTA'
      Else
        strMedia := 'ITE_MEDIA_';

      blnTemExcednte := False;

      cdsItensMult.Filter   := 'ITE_CODITE = ' + QuotedStr(strCodIte);
      cdsItensMult.Filtered := True;

      cdsItensMult.First;

      While Not cdsItensMult.Eof Do
      Begin

        If (cdsItensMult.FieldByName('ITE_QTDORI').AsFloat = 0) And
           (fEmptyStr(strEmpresasOrigens) Or (Pos(cdsItensMult.FieldByName('ITE_CODEMP').AsString, strEmpresasOrigens) > 0)) Then
        Begin
          fltQtdExc := 0;

        //  ESTOQUE > 75% DO GIRO E > QUE MINIMO.  SE SIM LIBERA, SE NAO NAO LIBERA.

          If (cdsItensMult.FieldByName('ITE_SALBAS').AsFloat > cdsItensMult.FieldByName('ITE_ESTMIN').AsFloat) And
             (cdsItensMult.FieldByName('ITE_SALBAS').AsFloat > 0.75 * cdsItensMult.FieldByName(strMedia).AsFloat) Then
          Begin
            fltQtdExc := cdsItensMult.FieldByName('ITE_SALBAS').AsFloat - Max(cdsItensMult.FieldByName('ITE_ESTMIN').AsFloat,
                                                                    0.75 * cdsItensMult.FieldByName(strMedia).AsFloat);
            If (FOpcGir.opcChamada = chaSpoolTransferencia) And (FOpcGir.blnConsEndere) Then
              fltQtdExc := fltQtdExc - cdsItensMult.FieldByName('ITE_SALEND').AsFloat;


            If ((FOpcGir.opcChamada = chaPedido) or (FOpcGir.opcChamada = chaSpoolTransferencia)) And (FOpcGir.blnConsPedPen) Then
              fltQtdExc := fltQtdExc - cdsItensMult.FieldByName('ITE_QTDPEN').AsFloat;

            If fltQtdExc < 0 Then
              fltQtdExc := 0;

            If fltQtdExc > 0 Then
              blnTemExcednte := True;

            fltQtdExc := Floor(fltQtdExc);
          End;

          cdsItensMult.Edit;
          cdsItensMult.FieldByName('ITE_QTDEXC').AsFloat := fltQtdExc;
          cdsItensMult.FieldByName('ITE_QTDREM').AsFloat := fltQtdExc;
          cdsItensMult.Post;
        End;

        cdsItensMult.Next;
      End;
    End;

    Procedure pGeraRegistros;
    // INCLUI OS REGISTPOS CANDIDADOS A TRANSFERENCIA NO CLIENT DE TRANSFERENCIA COM AS QUANTIDADES VAZIAS
      Var
        intContador: Integer;
    Begin
      stlLisEmp.Clear;

      cdsItensMult.Filter   := 'ITE_CODITE = ' + QuotedStr(strCodIte);
      cdsItensMult.Filtered := True;

      cdsItensMult.First;

      While Not cdsItensMult.Eof Do
      Begin
        If (recOpcGir.blnAllIte Or (cdsItensMult.FieldByName('ITE_QTDITE').AsFloat > 0)) Then
          stlLisEmp.Add(cdsItensMult.FieldByName('ITE_CODEMP').AsString);

        cdsItensMult.Next;
      End;

      For intContador := 0 To stlLisEmp.Count - 1 Do
        pInicializaItem(stlLisEmp[intContador], False);
    End;

    Procedure pDistribuiExcedente;
      Var
        strEmpDes: String;
        fltQtdTra: Double;
    Begin
      cdsItens.Filter   := 'CODITE = ' + QuotedStr(strCodIte);
      cdsItens.Filtered := True;

      // FILTRA TODOS QUE PRECISAM SER ABASTECIDAS  - EMPRESAS DESTINOS
      cdsItensMult.Filter := 'ITE_CODITE = ' + QuotedStr(strCodIte) + ' AND ITE_QTDITE > 0';
      cdsItensMult.IndexFieldNames := 'ITE_CODEMP';

      // ORDENA PELA LOJA QUE TEM MAIOR EXCEDENTE  EMPRESAS ORIGENS
      cdsFornecedoras.IndexFieldNames := 'ITE_QTDEXC';
      cdsFornecedoras.Last;

      While Not cdsFornecedoras.Bof Do
      Begin
        While (cdsFornecedoras.FieldByName('ITE_QTDREM').AsFloat > 0) And (Not cdsItensMult.IsEmpty) Do
        Begin
          cdsItensMult.First;

          While (Not cdsItensMult.Eof) And (cdsFornecedoras.FieldByName('ITE_QTDREM').AsFloat > 0) Do
          Begin
            strEmpDes := cdsItensMult.FieldByName('ITE_CODEMP').AsString;

            If (cdsFornecedoras.FieldByName('ITE_CODEMP').AsString <> cdsItensMult.FieldByName('ITE_CODEMP').AsString) Then
            Begin
              If Not cdsItens.Locate('CODEMP;EMPDES', VarArrayOf([cdsFornecedoras.FieldByName('ITE_CODEMP').AsString,
                                                                  cdsItensMult.FieldByName('ITE_CODEMP').AsString]), []) Then
                Exit;  // DEVERIA SEMPRE ACHAR

              cdsItensMult.Edit;
              cdsFornecedoras.Edit;
              cdsItens.Edit;

              If cdsItensMult.FieldByName('ITE_QTDCAL').IsNull Or (cdsItensMult.FieldByName('ITE_QTDCAL').AsFloat = 0) Then
                cdsItensMult.FieldByName('ITE_QTDCAL').AsFloat := cdsItensMult.FieldByName('ITE_QTDITE').AsFloat;

              If cdsItensMult.FieldByName('ITE_QTDORI').IsNull Or (cdsItensMult.FieldByName('ITE_QTDORI').AsFloat = 0) Then
              Begin
                If Not blnAgrupando Then
                  cdsItensMult.FieldByName('ITE_SUGEST').AsFloat := cdsItensMult.FieldByName('ITE_QTDCAL').AsFloat;

                cdsItensMult.FieldByName('ITE_QTDORI').AsFloat := cdsItensMult.FieldByName('ITE_QTDCAL').AsFloat;
                cdsItensMult.FieldByName('ITE_BKPQTI').AsFloat := cdsItensMult.FieldByName('ITE_QTDITE').AsFloat;
                cdsItensMult.FieldByName('ITE_QTDITE').AsFloat := cdsItensMult.FieldByName('ITE_QTDCAL').AsFloat;
              End;

              fltQtdTra := Floor(0.25 * cdsItensMult.FieldByName('ITE_QTDORI').AsFloat);

              If fltQtdTra = 0 Then
                fltQtdTra := 1;

              If fltQtdTra > cdsItensMult.FieldByName('ITE_QTDITE').AsFloat Then
                fltQtdTra := cdsItensMult.FieldByName('ITE_QTDITE').AsFloat;

              If fltQtdTra > cdsFornecedoras.FieldByName('ITE_QTDREM').AsFloat Then
                fltQtdTra := cdsFornecedoras.FieldByName('ITE_QTDREM').AsFloat;

              // ATUALIZA A QUANTIDADE A SER TRANSFERIDA
              cdsItens.FieldByName('QTDITE').AsFloat            := cdsItens.FieldByName('QTDITE').AsFloat + fltQtdTra;

              cdsItens.FieldByName('QTDANT').AsFloat            := cdsItens.FieldByName('QTDITE').AsFloat;

              // ATUALIZA A QUANTIDADE A REMANESCENTE - DISPONÍVEL PARA TRANSFERÊNCIA
              cdsFornecedoras.FieldByName('ITE_QTDREM').AsFloat := cdsFornecedoras.FieldByName('ITE_QTDREM').AsFloat - fltQtdTra;

              // ATUALIZA A QUANTIDADE A COMPRAR NO PEDIDO DE COMPRA
              cdsItensMult.FieldByName('ITE_QTDITE').AsFloat    := cdsItensMult.FieldByName('ITE_QTDITE').AsFloat - fltQtdTra;
              cdsItensMult.FieldByName('ITE_QTDTRA').AsFloat    := cdsItensMult.FieldByName('ITE_QTDTRA').AsFloat + fltQtdTra;

              cdsFornecedoras.FieldByName('ITE_REATRA').AsFloat := cdsFornecedoras.FieldByName('ITE_REATRA').AsFloat + fltQtdTra;

              If cdsItensMult.FieldByName('ITE_QTDITE').AsFloat  < 0 Then
                cdsItensMult.FieldByName('ITE_QTDITE').AsFloat := 0;

              If (cdsItensMult.FieldByName('ITE_QTDREQ').AsFloat > 0) And
                 (cdsItensMult.FieldByName('ITE_QTDTRA').AsFloat >= cdsItensMult.FieldByName('ITE_QTDREQ').AsFloat) Then
                cdsItensMult.FieldByName('ITE_ATEREQ').AsString := 'T';

              /// ????? - VÁLIDO SOMENTE SE HOUVER REQUISIÃO - TERIA Q MARCAR TODOAS QUNADO MARCAR A DE BAIXO
              /// cdsItens.FieldByName('ATEREQ').AsString := 'T';

              If Assigned(pCalculaTotalItemQtdGrid) Then
                pCalculaTotalItemQtdGrid(cdsItensMult);

              cdsItens.FieldByName('QTDEXC').AsFloat := cdsFornecedoras.FieldByName('ITE_QTDEXC').AsFloat;

              If blnComDadosProduto Then
                cdsItens.FieldByName('MARDES').AsString := 'S';

              cdsItensMult.Post;
              cdsFornecedoras.Post;

              cdsItens.Post;
            End;

            If strEmpDes = cdsItensMult.FieldByName('ITE_CODEMP').AsString Then
              cdsItensMult.Next;

          End; {(Not cdsItensMult.Eof) And (cdsFornecedoras.FieldByName('ITE_QTDREM').AsFloat > 0) Do}

        End; {While (cdsFornecedoras.FieldByName('ITE_QTDREM').AsFloat > 0) And (Not cdsItensMult.IsEmpty) Do }
        If cdsFornecedoras.FieldByName('ITE_REATRA').AsFloat > 0 Then
        begin
          cdsItensMult.Filtered :=  False;
          cdsItensMult.Filter := 'ITE_CODITE = ' + QuotedStr(strCodIte);
          cdsItensMult.Filtered :=  True;

          If cdsItensMult.Locate('ITE_CODEMP', cdsFornecedoras.FieldByName('ITE_CODEMP').AsString, []) Then
          Begin
            cdsItensMult.edit;
            cdsItensMult.FieldByName('ITE_REATRA').AsFloat :=  cdsFornecedoras.FieldByName('ITE_REATRA').AsFloat;
            cdsItensMult.Post;
          End;

          cdsItensMult.Filtered :=  False;
          cdsItensMult.Filter := 'ITE_CODITE = ' + QuotedStr(strCodIte) + ' AND ITE_QTDITE > 0';
          cdsItensMult.Filtered :=  True;
        End;
        cdsFornecedoras.Prior;
      End;

    End;

    Procedure pAtualizaQuantidadesPedido;
      Var
        fltQtdTra,
        fltQtdIte: Double;
    Begin
      fltQtdIte := 0;
      fltQtdTra := 0;

      cdsItensMult.Filter   := 'ITE_CODITE = ' + QuotedStr(strCodIte);
      cdsItensMult.Filtered := True;

      cdsItensMult.First;

      While Not cdsItensMult.Eof Do
      Begin
        fltQtdIte := fltQtdIte + cdsItensMult.FieldByName('ITE_QTDITE').AsFloat;
        fltQtdTra := fltQtdTra + cdsItensMult.FieldByName('ITE_QTDTRA').AsFloat;

        cdsItensMult.Next;
      End;

      cdsItensPed.Edit;

      cdsItensPed.FieldByName('ITE_QTDITE').AsFloat := fltQtdIte;
      cdsItensPed.FieldByName('ITE_QTDINC').AsFloat := fltQtdIte;

      cdsItensPed.FieldByName('ITE_QTDTRA').AsFloat := fltQtdTra;
      cdsItensPed.FieldByName('ITE_TRAINC').AsFloat := fltQtdTra;

      If Assigned(pCalculaTotalItemQtdGrid) Then
        pCalculaTotalItemQtdGrid(cdsItensPed);

      cdsItensPed.Post;
    End;

    Procedure pCalculaExcedente;
    Begin
      prgProgresso.Properties.Max := cdsItensPed.RecordCount;

      frmGravando.lblGravando.Caption := 'Calculando quantidade excedente, aguarde...';

      cdsItensMult.IndexFieldNames := 'ITE_CODITE;ITE_CODEMP';

      cdsItensPed.First;

      While Not cdsItensPed.Eof Do
      Begin
        strCodIte := cdsItensPed.FieldByName('ITE_CODITE').AsString;

        pCalculaQuantidadeExcedente;

        If strCodIte = cdsItensPed.FieldByName('ITE_CODITE').AsString Then
          cdsItensPed.Next;

        prgProgresso.Position := prgProgresso.Position + 1;
        Application.ProcessMessages;
      End; {While Not cdsItensPed.Eof Do}

      If cdsFornecedoras.Active Then
        cdsFornecedoras.EmptyDataSet;

      cdsFornecedoras.Data := cdsItensMult.Data;
    End;

    Procedure pMontaTransferencia;
    Begin
      frmGravando.lblGravando.Caption := 'Distribuindo quantidade excedente, aguarde...';
      prgProgresso.Position := 0;
      prgProgresso.Properties.Max := cdsItensPed.RecordCount;

      cdsItensPed.First;

      While Not cdsItensPed.Eof Do
      Begin
        strCodIte := cdsItensPed.FieldByName('ITE_CODITE').AsString;

        cdsItensMult.Filter   := 'ITE_CODITE = ' + QuotedStr(strCodIte);
        cdsItensMult.Filtered := True;

      // FILTRA AS QUE TEM EXCEDENTE E NÃO PRECISAM DE PRODUTOS
        cdsFornecedoras.Filter   := 'ITE_QTDEXC > 0 AND ITE_QTDITE = 0 AND ITE_CODITE = ' + QuotedStr(strCodIte);
        cdsFornecedoras.Filtered := True;

        If Not cdsFornecedoras.IsEmpty Then
        Begin
          pGeraRegistros;
          pDistribuiExcedente;
          pAtualizaQuantidadesPedido;
        End;

        If strCodIte = cdsItensPed.FieldByName('ITE_CODITE').AsString Then
          cdsItensPed.Next;

        prgProgresso.Position := prgProgresso.Position + 1;
        Application.ProcessMessages;
      End; {While Not cdsItensPed.Eof Do}
    End;

    Procedure pAjustaMultiploCompra;
      Var
        fltSugMult,
        fltQtdDif,
        fltQtdMul,
        fltMltCom: Double;
        blnAlterouQuantidade: Boolean;
        strCodEmpMult,
        strFiltro,
        strCodEmp: String;
    Begin
      cdsItensPed.Filter   := 'ITE_QTDTRA > 0 AND ITE_MLTCOM <> 1 AND ITE_MLTCOM <> 0';
      cdsItensPed.Filtered := True;

      frmGravando.lblGravando.Caption := 'Ajustando múltiplo de compra, aguarde...';
      prgProgresso.Position := 0;
      prgProgresso.Properties.Max := cdsItensPed.RecordCount;

      cdsItensPed.First;

      While Not cdsItensPed.Eof Do
      Begin
        strCodIte := cdsItensPed.FieldByName('ITE_CODITE').AsString;

        blnAlterouQuantidade := False;

        fltMltCom := cdsItensPed.FieldByName('ITE_MLTCOM').AsFloat;

        If (fltMltCom <> 0) And (fltMltCom <> 1) Then
        Begin
          cdsItensMult.Filter   := 'ITE_QTDTRA > 0 AND ITE_CODITE = ' + QuotedStr(strCodIte);
          cdsItensMult.Filtered := True;
          cdsItensMult.First;

          cdsFornecedoras.Filter   := 'ITE_CODITE = ' + QuotedStr(strCodIte);
          cdsFornecedoras.Filtered := True;

          While Not cdsItensMult.Eof Do
          Begin
            strCodEmpMult := cdsItensMult.FieldByName('ITE_CODEMP').AsString;

            If ((cdsItensMult.FieldByName('ITE_ABAMLT').AsString = 'S') And (cdsItensMult.FieldByName('ITE_MLTSPO').AsSTring  = 'N')) Or
               ((cdsItensMult.FieldByName('ITE_ABAMLT').AsString = 'N') And (cdsItensMult.FieldByName('ITE_MLTSPO').AsSTring  = 'N')) Then
            Begin
              cdsItens.Filter   := 'CODITE = ' + QuotedStr(strCodIte) + ' AND QTDITE > 0 AND EMPDES = ' + QuotedStr(cdsItensMult.FieldByName('ITE_CODEMP').AsString);

              cdsItens.Filtered := True;
              cdsItens.First;

              While Not cdsItens.Eof Do
              Begin
                strCodEmp := cdsItens.FieldByName('CODEMP').AsString;

                // ARREDONDA PARA BAIXO
                fltQtdMul := (Int(cdsItens.FieldByName('QTDITE').AsFloat / fltMltCom)) * fltMltCom;

                If (RoundTo(fltQtdMul, -4) {<>} < RoundTo(cdsItens.FieldByName('QTDITE').AsFloat, -4)) And
                    cdsFornecedoras.Locate('ITE_CODEMP', cdsItens.FieldByName('CODEMP').AsString, []) Then
                Begin

                  fltQtdDif := (fltQtdMul + fltMltCom) - cdsItens.FieldByName('QTDITE').AsFloat;

                  // ARREDONDA PARA CIMA SE TEM SALDO
                  If (cdsFornecedoras.FieldByName('ITE_QTDREM').AsFloat >= fltQtdDif) Then
                    fltQtdMul := fltQtdMul + fltMltCom;

                  If (fltQtdMul > cdsItens.FieldByName('QTDITE').AsFloat) Or        // SE AUMENTOU A QUANTIDADE A TRANSFERIR
                     (cdsItensMult.FieldByName('ITE_ATEREQ').AsString <> 'T') Or    // SE A REQUISIÇÃO VAI SER ATENDIDA PELO PEDIDO DE COMPRA
                     (cdsItensMult.FieldByName('ITE_QTDREQ').AsFloat = 0) Or        // SE NÃO TEM REQUISIÇÃO
                     (cdsItensMult.FieldByName('ITE_QTDITE').AsFloat - fltQtdDif >= cdsItensMult.FieldByName('ITE_QTDREQ').AsFloat) Then
                  Begin
                    cdsItens.Edit;
                    cdsItensMult.Edit;
                    cdsFornecedoras.Edit;

                    cdsItens.FieldByName('QTDITE').AsFloat := fltQtdMul;

                    cdsItensMult.FieldByName('ITE_QTDTRA').AsFloat := cdsItensMult.FieldByName('ITE_QTDTRA').AsFloat +
                                               (cdsItens.FieldByName('QTDITE').AsFloat - cdsItens.FieldByName('QTDANT').AsFloat);

                    If (cdsItensMult.FieldByName('ITE_ATEREQ').AsString = 'T') Or    // SE A REQUISIÇÃO VAI SER ATENDIDA PELA TRANSFERENCIA
                       (cdsItensMult.FieldByName('ITE_QTDREQ').AsFloat = 0) Or       // SE NÃO TEM REQUISIÇÃO
                       (cdsItensMult.FieldByName('ITE_QTDORI').AsFloat - cdsItensMult.FieldByName('ITE_QTDTRA').AsFloat >
                               cdsItensMult.FieldByName('ITE_QTDITE').AsFloat) Or    // AUMENTANDO A QUANTIDADE A COMPRAR
                       (cdsItensMult.FieldByName('ITE_QTDORI').AsFloat - cdsItensMult.FieldByName('ITE_QTDTRA').AsFloat >=
                               cdsItensMult.FieldByName('ITE_QTDREQ').AsFloat) Then  // O NOVO VALOR É MAIOR QUE A REQUISIÇÃO
                    Begin
                      If fltQtdMul > 0 Then
                        cdsItensMult.FieldByName('ITE_QTDITE').AsFloat := cdsItensMult.FieldByName('ITE_QTDCAL').AsFloat -
                                                                          cdsItensMult.FieldByName('ITE_QTDTRA').AsFloat
                      Else
                        cdsItensMult.FieldByName('ITE_QTDITE').AsFloat := cdsItensMult.FieldByName('ITE_BKPQTI').AsFloat;

                      If cdsItensMult.FieldByName('ITE_QTDITE').AsFloat < 0 Then
                        cdsItensMult.FieldByName('ITE_QTDITE').AsFloat := 0;
                    End;
                    cdsFornecedoras.FieldByName('ITE_REATRA').AsFloat := cdsFornecedoras.FieldByName('ITE_REATRA').AsFloat +
                                                                         (cdsItens.FieldByName('QTDITE').AsFloat - cdsItens.FieldByName('QTDANT').AsFloat);
                    cdsFornecedoras.FieldByName('ITE_QTDREM').AsFloat := cdsFornecedoras.FieldByName('ITE_QTDREM').AsFloat -
                                             (cdsItens.FieldByName('QTDITE').AsFloat - cdsItens.FieldByName('QTDANT').AsFloat);

                    cdsItens.FieldByName('QTDANT').AsFloat := fltQtdMul;

                    If Assigned(pCalculaTotalItemQtdGrid) Then
                      pCalculaTotalItemQtdGrid(cdsItensMult);

                    cdsItens.Post;
                    cdsItensMult.Post;
                    cdsFornecedoras.Post;

                    blnAlterouQuantidade := True;
                  End;

                End; {If RoundTo(fltQtdMul, -4) <> RoundTo(cdsItens.FieldByName('QTDITE').AsFloat, -4) Then}

                If strCodEmp = cdsItens.FieldByName('CODEMP').AsString Then
                  cdsItens.Next;
              End;

            End; {If cdsItensMult.FieldByName('ITE_ABAMLT').AsString = 'S' Then}

            // AJUSTA O MULTIPLO DA QUANTIDADE A COMPRAR
            If blnMtlCom And (cdsItensMult.FieldByName('ITE_QTDITE').AsFloat > 0) Then
            Begin
              cdsItensMult.Edit;

              fltSugMult := (round(cdsItensMult.FieldByName('ITE_QTDITE').AsFloat /
                                   cdsItensMult.fieldbyname('ITE_MLTCOM').asfloat)) * cdsItensMult.fieldbyname('ITE_MLTCOM').asfloat;

              If fltSugMult < cdsItensMult.FieldByName('ITE_QTDITE').AsFloat Then
                cdsItensMult.FieldByName('ITE_QTDITE').AsFloat := (round(cdsItensMult.FieldByName('ITE_QTDITE').AsFloat /
                                                   cdsItensMult.fieldbyname('ITE_MLTCOM').asfloat) + 1) * cdsItensMult.fieldbyname('ITE_MLTCOM').asfloat
              Else
                cdsItensMult.FieldByName('ITE_QTDITE').AsFloat := fltSugMult;

              cdsItensMult.FieldByName('ITE_QTDITE').AsFloat  := Ceil(cdsItensMult.FieldByName('ITE_QTDITE').AsFloat);

              If cdsItensMult.FieldByName('ITE_QTDITE').AsFloat >= cdsItensMult.FieldByName('ITE_QTDCAL').AsFloat Then
                cdsItensMult.FieldByName('ITE_QTDTRA').AsFloat := 0;

              If Assigned(pCalculaTotalItemQtdGrid) Then
                pCalculaTotalItemQtdGrid(cdsItensMult);

              blnAlterouQuantidade := True;

              // NÃO PRECISA TRANSFERIR NADA PORQUE A COMPRA JÁ COBRE AS TRANSFERENCIAS
              If cdsItensMult.FieldByName('ITE_QTDITE').AsFloat >= cdsItensMult.FieldByName('ITE_QTDCAL').AsFloat Then
              Begin
                cdsItens.Filter   := 'CODITE = ' + QuotedStr(strCodIte) + ' AND QTDITE > 0 AND EMPDES = ' + QuotedStr(cdsItensMult.FieldByName('ITE_CODEMP').AsString);

                cdsItens.Filtered := True;
                cdsItens.First;

                While Not cdsItens.Eof Do
                Begin
                  strCodEmp := cdsItens.FieldByName('CODEMP').AsString;

                  cdsItens.Edit;
                  cdsItens.FieldByName('QTDITE').AsFloat := 0;
                  cdsItens.Post;

                  If strCodEmp = cdsItens.FieldByName('CODEMP').AsString Then
                    cdsItens.Next;
                End;

              End;

              cdsItensMult.Post;
            End;

            If strCodEmpMult = cdsItensMult.FieldByName('ITE_CODEMP').AsString Then
              cdsItensMult.Next;
          End;

          cdsItensMult.Filtered :=  False;
          cdsItensMult.Filter := 'ITE_CODITE = ' + QuotedStr(strCodIte);
          cdsItensMult.Filtered :=  True;

          If cdsItensMult.Locate('ITE_CODEMP', cdsFornecedoras.FieldByName('ITE_CODEMP').AsString, []) Then
          Begin
            cdsItensMult.edit;
            cdsItensMult.FieldByName('ITE_REATRA').AsFloat :=  cdsFornecedoras.FieldByName('ITE_REATRA').AsFloat;
            cdsItensMult.Post;
          End;

          cdsFornecedoras.First;

          strFiltro := cdsItensMult.Filter;
          cdsItensMult.Filtered :=  False;
          cdsItensMult.Filter := 'ITE_CODITE = ' + QuotedStr(strCodIte);
          cdsItensMult.Filtered :=  True;

          while not cdsFornecedoras.Eof Do
          Begin
            If cdsFornecedoras.FieldByName('ITE_REATRA').AsFloat > 0 Then
            Begin
             If cdsItensMult.Locate('ITE_CODEMP', cdsFornecedoras.FieldByName('ITE_CODEMP').AsString, []) Then
              Begin
                cdsItensMult.edit;
                cdsItensMult.FieldByName('ITE_REATRA').AsFloat :=  cdsFornecedoras.FieldByName('ITE_REATRA').AsFloat;
                cdsItensMult.Post;
              End;
            End;
            cdsFornecedoras.Next;
          End;

          If strFiltro <> '' Then
          Begin
            cdsItensMult.Filtered :=  False;
            cdsItensMult.Filter := strFiltro;
            cdsItensMult.Filtered :=  True;
          End;

        End; {If (fltMltCom <> 0) And (fltMltCom <> 1) Then}

        If blnAlterouQuantidade Then
          pAtualizaQuantidadesPedido;
        If strCodIte = cdsItensPed.FieldByName('ITE_CODITE').AsString Then
          cdsItensPed.Next;

        prgProgresso.Position := prgProgresso.Position + 1;
        Application.ProcessMessages;
      End; {While Not cdsItensPed.Eof Do}

    End;

Begin
  strIndex    := cdsItensMult.IndexFieldNames;
  blnFiltered := cdsItensMult.Filtered;
  strFilter   := cdsItensMult.Filter;

  eveAfterScroll := cdsItensPed.AfterScroll;
  cdsItensPed.AfterScroll := Nil;

  prcAfterPost := cdsItensMult.AfterPost;
  cdsItensMult.AfterPost := Nil;

  blnHabilitaPed  := Not cdsItensPed.ControlsDisabled;
  blnHabilitaMult := Not cdsItensMult.ControlsDisabled;

  Try
    stlLisEmp := TStringList.Create;

    cdsItensPed.DisableControls;
    cdsItensMult.DisableControls;

    pCalculaExcedente;

    pFiltraItensOriginais;

    pMontaTransferencia;

    Result := fValidaRequisicoesPrg(prgProgresso);

    If Result Then
      pAjustaMultiploCompra;

    Result := True;

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TPreparaTEPedidoCompra.fGeraSpoolTransferencia]');
      Result := False;
    End;

  End;

  cdsItensMult.Filtered        := blnFiltered;
  cdsItensMult.Filter          := strFilter;
  cdsItensMult.IndexFieldNames := strIndex;

  cdsItensMult.AfterPost := prcAfterPost;

  cdsItensPed.AfterScroll := eveAfterScroll;

  If blnHabilitaMult Then
    cdsItensMult.EnableControls;

  If blnHabilitaPed Then
    cdsItensPed.EnableControls;

  FreeAndNil(stlLisEmp);
  cdsItensPed.Filtered := False;
  cdsItensPed.Filter   := '';
End;

Function TPreparaTEPedidoCompra.fValidaRequisicoesPrg(prgProgresso: TcxProgressBar): Boolean;

  Procedure pAtualizaTransferencia;
  Begin
    cdsItens.IndexFieldNames := 'CODITE;EMPDES';

    cdsItensMult.Filter   := 'ITE_ATEREQ = ' + QuotedStr('T');
    cdsItensMult.Filtered := True;

    If Not cdsItensMult.IsEmpty Then
    Begin
      frmGravando.lblGravando.Caption := 'Determinando atendimento de requisições, aguarde...';
      prgProgresso.Position := 0;
      prgProgresso.Properties.Max := cdsItensMult.RecordCount;
    End;

    cdsItensMult.First;

    While Not cdsItensMult.Eof Do
    Begin
      // MARCA AS REQUISIÇÕES COMO "T" - ATENDIDAS POR TRANSFERENCIA
      cdsItens.Filter   := 'CODITE = ' + QuotedStr(cdsItensMult.FieldByName('ITE_CODITE').AsString) +
                             ' AND EMPDES = ' + QuotedStr(cdsItensMult.FieldByName('ITE_CODEMP').AsString);

      cdsItens.Filtered := True;

      cdsItens.First;
      While Not cdsItens.Eof Do
      Begin
        cdsItens.Edit;
        cdsItens.FieldByName('ATEREQ').AsString :=  'T';

        If Not fEmptyStr(cdsItensMult.FieldByName('ITE_INCIRQ').AsString) Then
        Begin

          If fEmptyStr(cdsItens.FieldByName('AUTREQ').AsString) Then
            cdsItens.FieldByName('AUTREQ').AsString := cdsItensMult.FieldByName('ITE_INCIRQ').AsString
          Else
            cdsItens.FieldByName('AUTREQ').AsString := cdsItens.FieldByName('AUTREQ').AsString + ',' + cdsItensMult.FieldByName('ITE_INCIRQ').AsString;

        End;

        cdsItens.Post;

        cdsItens.Next;
      End;

      cdsItensMult.Next;

      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
    End;

  End;

  procedure pAjustaRequisicao;
    Var
      fltQtdRes,
      fltQtdDif: Double;
  Begin
    cdsItensMult.Filter   := '(ITE_QTDREQ > 0) AND (ITE_QTDREQ > ITE_QTDITE) AND (ITE_QTDREQ > ITE_QTDTRA)';
    cdsItensMult.Filtered := True;

    If Not cdsItensMult.IsEmpty Then
    Begin
      frmGravando.lblGravando.Caption := 'Ajustando quantidade para requisições, aguarde...';
      prgProgresso.Position := 0;
      prgProgresso.Properties.Max := cdsItensMult.RecordCount;
      cdsItensMult.IndexFieldNames := 'ITE_CODITE';
    End;

    cdsItensMult.First;

    While Not cdsItensMult.Eof Do
    Begin
      fltQtdDif := cdsItensMult.FieldByName('ITE_QTDREQ').AsFloat - cdsItensMult.FieldByName('ITE_QTDITE').AsFloat;

      If fltQtdDif > 0 Then  // SÓ PRA GARANTIR
      Begin
        cdsItensMult.Edit;

        cdsItensMult.FieldByName('ITE_QTDITE').AsFloat := cdsItensMult.FieldByName('ITE_QTDITE').AsFloat + fltQtdDif;

        If cdsItensMult.FieldByName('ITE_QTDTRA').AsFloat >= fltQtdDif Then
        Begin
          cdsItensMult.FieldByName('ITE_QTDTRA').AsFloat := cdsItensMult.FieldByName('ITE_QTDTRA').AsFloat - fltQtdDif;

          // TEM QUE REAJUSTAR AS TRANSFERENCIAS
          cdsItens.Filter   := 'QTDITE > 0 AND CODITE = ' + QuotedStr(cdsItensMult.FieldByName('ITE_CODITE').AsString) +
                                 ' AND EMPDES = ' + QuotedStr(cdsItensMult.FieldByName('ITE_CODEMP').AsString);

          cdsItens.Filtered := True;

          cdsItens.IndexFieldNames := 'QTDITE';

          cdsItens.Last;

          fltQtdRes := fltQtdDif;

          While (Not cdsItens.Bof) And (fltQtdRes > 0) Do
          Begin
            cdsItens.Edit;

            If cdsItens.FieldByName('QTDITE').AsFloat >= fltQtdRes Then
            Begin
              cdsItens.FieldByName('QTDITE').AsFloat := cdsItens.FieldByName('QTDITE').AsFloat - fltQtdRes;

              fltQtdRes := 0;
            End Else
            Begin
              fltQtdRes := fltQtdRes - cdsItens.FieldByName('QTDITE').AsFloat;

              cdsItens.FieldByName('QTDITE').AsFloat := 0;
            End;

            If cdsFornecedoras.Active And
               cdsFornecedoras.Locate('ITE_CODEMP;ITE_CODITE',
                  VarArrayOf([cdsItens.FieldByName('CODEMP').AsString, cdsItens.FieldByName('CODITE').AsString]), []) Then
            Begin
              cdsFornecedoras.Edit;
              cdsFornecedoras.FieldByName('ITE_QTDREM').AsFloat := cdsFornecedoras.FieldByName('ITE_QTDREM').AsFloat +
                (cdsItens.FieldByName('QTDANT').AsFloat -  cdsItens.FieldByName('QTDITE').AsFloat);
              cdsFornecedoras.Post;
            End;

            cdsItens.FieldByName('QTDANT').AsFloat := cdsItens.FieldByName('QTDITE').AsFloat;

            cdsItens.Post;

            cdsItens.Prior;
          End;

        End;

        If Assigned(pCalculaTotalItemQtdGrid) Then
          pCalculaTotalItemQtdGrid(cdsItensMult);

        cdsItensMult.Post;

        If (cdsItensPed.FieldByName('ITE_CODITE').AsString = cdsItensMult.FieldByName('ITE_CODITE').AsString) Or
           cdsItensPed.Locate('ITE_CODITE', cdsItensMult.FieldByName('ITE_CODITE').AsString, []) Then
        Begin
          cdsItensPed.Edit;
          cdsItensPed.FieldByName('ITE_QTDITE').AsFloat := cdsItensPed.FieldByName('ITE_QTDITE').AsFloat + fltQtdDif;

          If Assigned(pCalculaTotalItemQtdGrid) Then
            pCalculaTotalItemQtdGrid(cdsItensMult);

          cdsItensPed.Post;
        End;

      End; {If fltQtdDif > 0 Then }

      cdsItensMult.Next;

      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
    End;

  End;


Begin
  Result := True;

  If cdsFornecedoras.Active Then
  Begin
    cdsFornecedoras.Filtered := False;
    cdsFornecedoras.IndexFieldNames := 'ITE_CODEMP;ITE_CODITE';
  End;

  Try

    pAjustaRequisicao;

    pAtualizaTransferencia;

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TPreparaTEPedidoCompra.fValidaRequisicoesPrg]');
      Result := False;
    End;

  End;

End;

end.

