unit untRecConferEntrada;

interface

uses StrUtils, SysUtils, Uni, Db, Classes, Forms, Variants, Controls, untTypesSistema,
     UniClientDataSet, UniDataSetProvider, untFuncoesSimples, untZClient,
     EditFocus,
     untConstantes, Math, untIteBar;

Type
  TfGravaEntradas = Function: Boolean Of Object;

  TRecConferEntrada = Class(TZClient)
  Private
    FblnGerTrf : Boolean;
    FcdsExcedentes : TUniClientDataSet;
    objIteBar: TIteBar;
    FConsulta: TUniClientDataSet;
    FListSeqGer, FListSeqNotGer,
    FListSelecao: TStringList;

    blnBarCen: Boolean;
    intDeqTpc: Integer;
    blnEtiDif: Boolean;
    intDeqTem: Integer;
    strCodFor : String;
    qryConIte: TUniQuery;
    qryUpdate: TUniQuery;

    Function fSQLItensCaixa(strAutIns: String; blnNotDet: Boolean): String;
    Function fSQLItens: String;
    Function fPedeLiberacao: Boolean;

    Function fInsereItem(strCodIte: String; fltQtdIte: Double; strTipBus: String): Boolean;

    function fQtdItemOk(strCodIte: String; var fltQtdIte: Double; out AblnRegistrouExcedente: Boolean): Boolean;
    procedure pRegistraExcedente(const AstrCodIte, AstrDesIte: String;
                              const AfltQtdExc: Double;
                              const AstrTipExc: String);
  Public
    strCTLEST,
    strNotas: String;

    fGravaEntradas: TfGravaEntradas;

    Constructor Create(Owner: TComponent;
                       cdsConsulta: TUniClientDataSet;
                       stlListSelecao: TStringList); Reintroduce;

    Destructor  Destroy; Override;

    Function fRetornaNotasDisplay: String;

    Procedure pExcluiItem;

    Function fSelecionaNotas: Boolean;

    Function fFinalizaEntrada: Boolean;
    Function fValidaQuantidade(edtQtdIte: TEditFocus): Boolean;

    Function fRegistraItem(blnCodBar, blnCodFab: Boolean;
      edtCodIte, edtQtdIte, edtQtdEti: TEditFocus; blnSemelhante: Boolean;
      Var blnCodBarNaoEcontrado: Boolean): Boolean;

    Function fValidaConferencia: Boolean;
    procedure pExcluirExcedentes;
  End;


implementation

Uses
  untPesqAux,
  untFatSelecProduto,
  untFuncFat, untLiberacao, untMsgLiberacao,
  untTransferenciaDivergenciaExcedente;

constructor TRecConferEntrada.Create(Owner: TComponent;
                                     cdsConsulta: TUniClientDataSet;
                                     stlListSelecao: TStringList);
begin
  Inherited Create(Owner, '');

  blnBarCen := fCfgSis('BARCEN',varBoolean);
  intDeqTpc := fCfgSis('DEQTPC', varInteger);
  blnEtiDif := fCfgSis('ETIDIF', varBoolean);
  intDeqTem := fCfgSis('DEQTEM', varInteger);
  strCtlEst := fCfgSis('CTLEST');

  strCodFor := '';

  objIteBar   := TIteBar.Create(opcFuncoes);

  FConsulta     := cdsConsulta;
  FListSelecao  := stlListSelecao;

  FListSeqGer := TStringList.Create;
  FListSeqNotGer := TStringList.Create;

  qryConIte := fCriaQuery(Self);
  qryUpdate := fCriaQuery(Self);


  FblnGerTrf := fCfgSis('GERTRF', varBoolean);

  FcdsExcedentes := TUniClientDataSet.Create(Self);
  FcdsExcedentes.FieldDefs.Add('CODITE', ftString, 20);
  FcdsExcedentes.FieldDefs.Add('DESITE', ftString, 100);
  FcdsExcedentes.FieldDefs.Add('QTDEXC', ftFloat);
  FcdsExcedentes.FieldDefs.Add('TIPEXC', ftString, 1);
  FcdsExcedentes.CreateDataSet;
  FcdsExcedentes.IndexFieldNames := 'CODITE;TIPEXC';
end;

destructor TRecConferEntrada.Destroy;
begin
  FreeAndNil(FListSeqGer);
  FreeAndNil(FListSeqNotGer);
  FreeAndNil(objIteBar);
  FreeAndNil(FcdsExcedentes);
  inherited Destroy;
end;

Function TRecConferEntrada.fRetornaNotasDisplay: String;
  Var
    intIndice: Integer;
Begin
  FListSeqGer.Clear;
  FListSeqNotGer.Clear;

  strNotas := '';
  Result   := '';

  If Not Assigned(FConsulta) Then
    Exit;

  For intIndice := 0 To FListSelecao.Count - 1 Do
  If FConsulta.Locate('AUTOINCREM', FListSelecao[intIndice], []) And
     (Not fEmptyStr(FConsulta.FieldByName('PCG_NUMPED').AsString)) Then
  Begin
    If intIndice <> 0 Then
      Result := Result + ', ';

    Result := Result + FConsulta.FieldByName('GER_NUMDOC').AsString + '-' +
                       FConsulta.FieldByName('GER_ESPDOC').AsString + '-' +
                       FConsulta.FieldByName('GER_CODEMP').AsString;

    If SameText(FConsulta.FieldByName('TABELA').AsString, 'MOVGER') Then
      FListSeqGer.Add(FConsulta.FieldByName('AUTOINCREM').AsString)
    Else
      FListSeqNotGer.Add(FConsulta.FieldByName('AUTOINCREM').AsString);
  End;

  strNotas := Result;
End;

Function TRecConferEntrada.fSQLItensCaixa(strAutIns: String; blnNotDet: Boolean): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '   DET_CODITE      AS CODITE, ';
  strSQL := strSQL + '   DET_DESCRI      AS DET_DESCRI, ';
  strSQL := strSQL + '   SUM(DET_QTDITE) AS QTDITE  ';

  If blnNotDet Then
  Begin
    strSQL := strSQL + ' FROM  NOTDET ';
  End
  Else
  Begin
    strSQL := strSQL + ' FROM  MOVDET ';
    strSQL := strSQL + ' LEFT JOIN CONDOC ON DOC_SEQGER = DET_SEQGER ';
    strSQL := strSQL + ' LEFT JOIN CONGER ON CONGER.AUTOINCREM = DOC_SEQCON ';
  End;

  strSQL := strSQL + ' WHERE ';

  If fEmptyStr(strAutIns) Then
  Begin
    strSQL := strSQL + '  FALSE ';
  End Else
  Begin
    strSQL := strSQL + '       DET_SEQGER IN (' + strAutIns + ')';
    If Not blnNotDet Then
      strSQL := strSQL + '   AND GER_DTAFIM IS NULL';

    if fCfgSis('EMSRCS', varBoolean) then
      strSQL := strSQL + '   AND DET_PROEMB <> "S" '
    else
      strSQL := strSQL + '   AND DET_PROEMB = "N" ';


    strSQL := strSQL + '   AND DET_CODITE <> :ITESER ';
    strSQL := strSQL + '   AND DET_CODITE <> :SERTER ';
  End;

  strSQL := strSQL + ' GROUP BY CODITE ';

  Result := strSQL;
End;

Function TRecConferEntrada.fSQLItens: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '   CODITE, ';
  strSQL := strSQL + '   SUM(QTDITE) AS QTDITE, ';
  strSQL := strSQL + '   0.0000      AS QTDCON, ';
  strSQL := strSQL + '   IFNULL(DET_DESCRI,ITE_DESITE)  AS DESITE, ';
  If fCfgSis('EXIAPL', varBoolean) Then
    strSQL := strSQL + ' ITE_APLICA AS APLICA, ';
  strSQL := strSQL + '   ITE_REFERE  AS REFERE, ';
  strSQL := strSQL + '   UNI_SIGUNI  AS SIGUNI,  ';
  strSQL := strSQL + '   NULL        AS TIPBUS,  ';
  strSQL := strSQL + '   COALESCE(                                            ';
  strSQL := strSQL + '     (SELECT CL.LOT_LOCFIS                              ';
  strSQL := strSQL + '      FROM CADLOT CL                                    ';
  strSQL := strSQL + '      WHERE CL.LOT_CODITE = CODITE                      ';
  strSQL := strSQL + '        AND CL.LOT_CODEMP = '+QuotedStr(VS_strCodEmp)+' ';
  strSQL := strSQL + '        AND CL.LOT_ARMPRI = "S"                         ';
  strSQL := strSQL + '        AND IFNULL(TRIM(CL.LOT_LOCFIS), "") <> ""       ';
  strSQL := strSQL + '      LIMIT 1),                                         ';
  strSQL := strSQL + '     G.ITE_LOCFIS                                       ';
  strSQL := strSQL + '   ) AS LOCFIS,                                         ';
  strSQL := strSQL + '   G.ITE_LOCSUP AS LOCSUP  ';

  strSQL := strSQL + ' FROM ( ';

  strSQL := strSQL +  fSQLItensCaixa(fCommaText(FListSeqGer, True), False);
  strSQL := strSQL + ' UNION ALL ';
  strSQL := strSQL +  fSQLItensCaixa(fCommaText(FListSeqNotGer, True), True);

  strSQL := strSQL + ' ) AS TAB ';

  strSQL := strSQL + ' INNER JOIN CADITE ON ITE_CODITE = CODITE ';
  strSQL := strSQL + ' INNER JOIN ITEGER G ON G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND G.ITE_CODITE = CODITE ';
  strSQL := strSQL + ' LEFT  JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
  strSQL := strSQL + ' GROUP BY CODITE ';

  Result := strSQL;
End;

Function TRecConferEntrada.fInsereItem(strCodIte: String; fltQtdIte: Double; strTipBus: String): Boolean;
Begin
  Try
    If Not Locate('CODITE', strCodIte, []) Then
    Begin
      Result := False;
      pMensagemOk('Esse item não se encontra nas notas selecionadas!');
      Exit;
    End;

    Edit;
    FieldByName('QTDCON').AsFloat := FieldByName('QTDCON').AsFloat + fltQtdIte;
    FieldByName('TIPBUS').AsString := strTipBus;
    Post;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TRecConferEntrada.fInsereItem]');
    End;
  End;
End;

Procedure TRecConferEntrada.pExcluiItem;
Begin
  If IsEmpty Then
     Exit;

  If fPergunta('Deseja excluir a conferência do item ' + FieldByName('CODITE').AsString + '?') Then
  Begin
    Edit;
    FieldbyName('QTDCON').AsFloat := 0;
    Post;
  End;
End;

Function TRecConferEntrada.fValidaConferencia: Boolean;
Begin
  Result := True;
  Try
    DisableControls;
    First;
    While Not Eof do
    Begin

      If RoundTo(FieldByName('QTDITE').AsFloat, -4) <>
         RoundTo(FieldByName('QTDCON').AsFloat, -4) Then
      Begin
        Result := False;
        Break;
      End;

      Next;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TRecConferEntrada.fValidaConferencia]');
    End;
  End;

  EnableControls;
End;

Function TRecConferEntrada.fPedeLiberacao: Boolean;
  Var
    objLiberacao : TLiberacao;
    objTabela : TRegistroMsgLiberaTabela;
  	objLinha  : TLinhaMsgLibera;
    blnTemExcedNaoConsta : Boolean;
    blnTemExcedQuantidade : Boolean;
Begin
  objLiberacao := TLiberacao.Create;
  try
    Try
      DisableControls;
      objLiberacao.objMsgLibera.pAddTexto('LIBERAÇÃO DE ENTRADA SIMPLIFICADA');
      objLiberacao.objMsgLibera.pAddTexto('AS QUANTIDADES DOS ITENS CONFERIDOS ESTÃO DIFERENTES DA(S) NOTA(S).');
      objLiberacao.objMsgLibera.pAddQuebra;


      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'CÓDIGO'     , fTamCodIte  , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'DESCRIÇÃO'  , 40 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'QTD. NOTA'  , 12 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'QTD. CONF'  , 12 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      Filter   := 'QTDCON <> QTDITE';
      Filtered := True;
      First;

      While Not Eof Do
      Begin

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('CÓDIGO'     , FieldByName('CODITE').AsString                              , fTamCodIte  , alEsquerda );
        objLinha.pAddColuna('DESCRIÇÃO'  , FieldByName('DESITE').AsString                              , 40 , alEsquerda );
        objLinha.pAddColuna('QTD. NOTA'  , FloatToStrF(FieldByName('QTDITE').AsFloat, ffNumber, 12, 2) , 12 , alDireita  );
        objLinha.pAddColuna('QTD. CONF'  , FloatToStrF(FieldByName('QTDCON').AsFloat, ffNumber, 12, 2) , 12 , alDireita  );
        objTabela.lstLinhas.Add(objLinha);

        Next;
      End;

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      Filtered := False;

      blnTemExcedNaoConsta := False;
      blnTemExcedQuantidade := False;
      If Assigned(FcdsExcedentes) And (FcdsExcedentes.RecordCount > 0) Then
      Begin
        FcdsExcedentes.First;
        While Not FcdsExcedentes.Eof Do
        Begin
          If FcdsExcedentes.FieldByName('TIPEXC').AsString = 'Q' Then
            blnTemExcedQuantidade := True
          Else
            blnTemExcedNaoConsta := True;

          If blnTemExcedNaoConsta And blnTemExcedQuantidade Then
            Break;
          FcdsExcedentes.Next;
        End;
      End;

      If blnTemExcedNaoConsta Then
      Begin
        objLiberacao.objMsgLibera.pAddQuebra;
        objLiberacao.objMsgLibera.pAddTexto('ITENS EXCEDENTES QUE NÃO CONSTAM NO DOCUMENTO:');
        objLiberacao.objMsgLibera.pAddQuebra;

        objTabela := TRegistroMsgLiberaTabela.Create;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlCabecalho;
        objLinha.pAddColuna('', 'CÓDIGO'    , fTamCodIte, alEsquerda, teAutcom);
        objLinha.pAddColuna('', 'DESCRIÇÃO' , 40        , alEsquerda, teAutcom);
        objLinha.pAddColuna('', 'QTD. EXC.' , 12        , alDireita , teAutcom);
        objTabela.lstLinhas.Add(objLinha);

        FcdsExcedentes.First;
        While Not FcdsExcedentes.Eof Do
        Begin
          If FcdsExcedentes.FieldByName('TIPEXC').AsString = 'I' Then
          Begin
            objLinha := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlValor;
            objLinha.pAddColuna('CÓDIGO'   , FcdsExcedentes.FieldByName('CODITE').AsString                              , fTamCodIte, alEsquerda);
            objLinha.pAddColuna('DESCRIÇÃO', FcdsExcedentes.FieldByName('DESITE').AsString                              , 40        , alEsquerda);
            objLinha.pAddColuna('QTD. EXC.', FloatToStrF(FcdsExcedentes.FieldByName('QTDEXC').AsFloat, ffNumber, 12, 2) , 12        , alDireita );
            objTabela.lstLinhas.Add(objLinha);
          End;
          FcdsExcedentes.Next;
        End;

        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
      End;

      If blnTemExcedQuantidade Then
      Begin
        objLiberacao.objMsgLibera.pAddQuebra;
        objLiberacao.objMsgLibera.pAddTexto('ITENS COM QUANTIDADE EXCEDENTE À NOTA:');
        objLiberacao.objMsgLibera.pAddQuebra;

        objTabela := TRegistroMsgLiberaTabela.Create;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlCabecalho;
        objLinha.pAddColuna('', 'CÓDIGO'    , fTamCodIte, alEsquerda, teAutcom);
        objLinha.pAddColuna('', 'DESCRIÇÃO' , 40        , alEsquerda, teAutcom);
        objLinha.pAddColuna('', 'QTD. EXC.' , 12        , alDireita , teAutcom);
        objTabela.lstLinhas.Add(objLinha);

        FcdsExcedentes.First;
        While Not FcdsExcedentes.Eof Do
        Begin
          If FcdsExcedentes.FieldByName('TIPEXC').AsString = 'Q' Then
          Begin
            objLinha := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlValor;
            objLinha.pAddColuna('CÓDIGO'   , FcdsExcedentes.FieldByName('CODITE').AsString                              , fTamCodIte, alEsquerda);
            objLinha.pAddColuna('DESCRIÇÃO', FcdsExcedentes.FieldByName('DESITE').AsString                              , 40        , alEsquerda);
            objLinha.pAddColuna('QTD. EXC.', FloatToStrF(FcdsExcedentes.FieldByName('QTDEXC').AsFloat, ffNumber, 12, 2) , 12        , alDireita );
            objTabela.lstLinhas.Add(objLinha);
          End;
          FcdsExcedentes.Next;
        End;

        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
      End;

      objLiberacao.strDirAce := 'LIBCONSIM';
      objLiberacao.strMsgSen := 'LIBERAÇÃO DE ENTRADA SIMPLIFICADA';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;
      objLiberacao.blnUsarSenhaFixa := False;
      objLiberacao.blnSempreVariavelUsuario := True;
      objLiberacao.tipCliFor := cfFornecedor;

      Result := objLiberacao.fLibera;


    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TRecConferEntrada.fPedeLiberacao]');
      End;
    End;
  finally
    FreeAndNil(objLiberacao);
    Filtered := False;
    EnableControls;
  end;
End;

Function TRecConferEntrada.fSelecionaNotas: Boolean;
Begin
  qryQuery.SQL.Text := fSQLItens;

  qryQuery.ParamByName('ITESER').AsString := fCfgSis('ITESER');
  qryQuery.ParamByName('SERTER').AsString := fCfgSis('SERTER');

  Result := fAbreClient(True, 'TRecConferEntrada.fSelecionaNotas');
  IndexFieldNames := 'CODITE';
End;

function TRecConferEntrada.fFinalizaEntrada: Boolean;
var
  LServico: TTransferenciaDivergenciaExcedente;
begin
  Result := False;

  if not (fValidaConferencia or fPedeLiberacao) then
    Exit;

  if not FblnGerTrf then
    Exit(fGravaEntradas);

  LServico := TTransferenciaDivergenciaExcedente.fNovo
    .fDocumentos(FConsulta)
    .fItensTransferencia(Self)
    .fItensExcedentes(FcdsExcedentes)
    .fSelecionados(FListSelecao)
    .fDeqTem(intDeqTem)
    .fGerarTransferencia(True)
    .fEmpresaAtual(VS_strCodEmp);

  try
    fStartTransaction;
    try
      Result := LServico.fExecutar;

      if Result then
        Result := fGravaEntradas;

      if Result then
        fCommit
      else if fInTransaction then
        fRollBack;
    except
      on E: Exception do
      begin
        if fInTransaction then
          fRollBack;
        Result := False;
        pMensagensErro(E.Message, '[TRecConferEntrada.fFinalizaEntrada]');
      end;
    end;
  finally
    FreeAndNil(LServico);
  end;
end;

Function TRecConferEntrada.fValidaQuantidade(edtQtdIte: TEditFocus): Boolean;
Begin
  Result := True;

  If (fEmptyStr(edtQtdIte.Text)) Then
  Begin
    pMensagemSonora('A quantidade deve ser preenchida!');
    Result := False;
  End
  Else If (fStrToFloat(edtQtdIte.Text) <= 0.0) Then
  Begin
    pMensagemSonora('A quantidade deve ser maior que zero!');
    Result := False;
  End
End;

Function TRecConferEntrada.fRegistraItem(blnCodBar, blnCodFab: Boolean;
  edtCodIte, edtQtdIte, edtQtdEti: TEditFocus; blnSemelhante: Boolean;
  Var blnCodBarNaoEcontrado: Boolean): Boolean;

  Var
    strCamBus,strTipBus,
    strCodIte,
    strCodBar,
    strCodIteUni, strCodGruUni: String;
    blnBuscaCodBar: Boolean;
    fltEmbala,
    fltTotal,
    fltQtdIteUni: Double;
    LblnExcRegistrado : Boolean;
    LblnInseriu       : Boolean;
    Procedure pPesquisaItem(strCodFor: String = '');
    Begin

      If blnSemelhante Then
      Begin
        {***************************************}
        {* PESQUISA NO CADASTRO DE SEMELHANTES *}
        {************************************AF*}
        pPesquisaCadSem(Nil, qryConIte, edtCodIte.Text, strCodFor, blnBuscaCodBar, blnCodFab);

        If (qryConIte.RecordCount > 1) Then
        Begin

          Try
            pCriarFormularios(TfrmFatSelecProduto, frmFatSelecProduto);
            frmFatSelecProduto.qryItens := qryConIte;
            frmFatSelecProduto.ShowModal;
          Except
            On E: Exception Do
              pMensagensErro(E.Message, '[TRecConferEntrada.fRegistraItem]');
          End;
          pFreeAndNil(frmFatSelecProduto);

        End;

      End Else
      Begin

        pPesquisaCadIteSemSemelhante(Nil, qryConIte, edtCodIte.Text, blnBuscaCodBar, blnCodFab,
                                    '', False, True, strCodFor);

      End;

    End;

begin
  blnCodBarNaoEcontrado := False;
  Result := FALSE;

  qryConIte.Close;
  qryUpdate.Close;

  strCamBus := 'ITE_CODFAB';
  blnBuscaCodBar := False;
  strTipBus := '';

  If blnCodBar Then
  Begin

    If (Length(edtCodIte.Text) > fTamCodIte) or blnBarCen Then
    Begin
      strCamBus := 'ITE_CODBAR';
      blnBuscaCodBar := True;
    End
    Else
    Begin
      strCamBus := 'ITE_CODITE';
      edtCodIte.Text := fStrZero(edtCodIte.Text, fTamCodIte);
    End;


  End;
  strCodIte := edtCodIte.Text;

  pPesquisaItem;

  If (qryConIte.RecordCount = 0) And blnEtiDif And
     objIteBar.fLerCodigoBarrasUnidades(edtCodIte.Text, strCodIteUni, strCodGruUni, fltQtdIteUni) Then
  Begin

    strCodIte      := strCodIteUni;
    edtCodIte.Text := strCodIteUni;
    edtQtdIte.Text := FloatToStrF(fltQtdIteUni, ffFixed, 12, intDeqTem);
    pPesquisaCadIteSemSemelhante(Nil, qryConIte, edtCodIte.Text, False, False);
    fltEmbala := 1;

  End

  Else If (qryConIte.RecordCount = 0) And
       objIteBar.fLerCodigoFabricaMaiorFornecedor(edtCodIte.Text, strCodIteUni, fltQtdIteUni) Then
  Begin

    strCodIte      := strCodIteUni;
    edtCodIte.Text := strCodIteUni;
    edtQtdIte.Text := FloatToStrF(fltQtdIteUni, ffFixed, 12, intDeqTem);

    blnBuscaCodBar := False;
    blnCodFab      := True;
    pPesquisaItem(strCodFor);

    fltEmbala := 1;

  End Else
  Begin

    If (qryConIte.RecordCount = 1) And blnBuscaCodBar And
       (qryConIte.FieldByName('BAR_EMBALA').AsFloat > 1) Then
      fltEmbala := qryConIte.FieldByName('BAR_EMBALA').AsFloat
    Else
      fltEmbala := 1;

  End;

  fltTotal := (fltEmbala * fStrToFloat(edtQtdIte.Text));

  fltTotal := fFormataFloat(fltTotal, intDeqTem);

  If (qryConIte.RecordCount > 0) And
     ((Pos(strCamBus, 'ITE_CODITE-ITE_CODFAB') = 0) Or (qryConIte.FieldByName('ITE_OBRBAR').AsString = 'N')) Then
  Begin

    strCodIte := qryConIte.FieldByName('ITE_CODITE').AsString;
    If fEmptyStr(strCamBus) Then
      strCamBus := 'ITE_CODITE';

     Case AnsiIndexStr(strCamBus, ['ITE_CODITE','ITE_CODFAB','ITE_CODBAR']) of
      0: strTipBus := 'C'; {Conferência por Código Item}
      1: strTipBus := 'F'; {Conferência por Código Fábrica}
      2: strTipBus := 'B'; {Conferência por Código de Barras}
     End;

    Result := fQtdItemOk(strCodIte, fltTotal, LblnExcRegistrado);

    LblnInseriu := False;
    If Result Then
    Begin
      Result := fInsereItem(strCodIte, fltTotal, strTipBus);
      LblnInseriu := Result;
    End
    Else If LblnExcRegistrado Then
      Result := True;

    If Result And LblnInseriu Then
    Begin
      If blnCodFab Then
      Begin

        If (edtCodIte.Text = qryConIte.FieldByName('ITE_CODFAB').AsString) Then
        Begin

          If fEmptyStr(qryConIte.FieldByName('ITE_CODBAR').AsString) And ffrmCodBarra(strCodBar) Then
          Begin
            qryUpdate.Close;
            qryUpdate.SQL.Clear;
            qryUpdate.SQL.Add('UPDATE CADITE SET ITE_CODBAR = :CODBAR WHERE AUTOINCREM = :AUTINC');
            qryUpdate.ParamByName('CODBAR').AsString := strCodBar;
            qryUpdate.ParamByName('AUTINC').AsString := qryConIte.FieldByName('AUTITE').AsString;
            qryUpdate.ExecSQL;

            fAtualizaBarFabIte(qryConIte.FieldByName('ITE_CODITE').AsString);
          End;

        End
        Else
        Begin

          If fEmptyStr(qryConIte.FieldByName('BARSEM').AsString) And ffrmCodBarra(strCodBar) Then
          Begin
            qryUpdate.Close;
            qryUpdate.SQL.Clear;
            qryUpdate.SQL.Add('UPDATE CADSEM SET SEM_CODBAR = :CODBAR WHERE AUTOINCREM = :AUTINC');
            qryUpdate.ParamByName('CODBAR').AsString := strCodBar;
            qryUpdate.ParamByName('AUTINC').AsString := qryConIte.FieldByName('AUTSEM').AsString;
            qryUpdate.ExecSQL;

            fAtualizaBarFabIte(qryConIte.FieldByName('ITE_CODITE').AsString);
          End;

        End;

      End;
    End;

  End
  Else
  Begin
    If Not(fEmptyStr(fCfgSis('PRBPNE', varString))) Then
      pMensagemSonora('Item ' + strCodIte + ' não existe!', 'PRBPNE')
    Else
      pMensagemSonora('Item ' + edtCodIte.Text + ' não existe!');

    blnCodBarNaoEcontrado := blnCodBar And (Length(edtCodIte.Text) > fTamCodIte);
  End;

  edtCodIte.Clear;

  edtQtdIte.Text := FormatFloat(fMskDigitos(intDeqTem), 1);
end;

function TRecConferEntrada.fQtdItemOk(strCodIte: String; var fltQtdIte: Double; out AblnRegistrouExcedente: Boolean): Boolean;
var
  strDesIte  : String;
  strCodRef  : String;
  strCodBar  : String;
  strRefere  : String;
  strCodUni  : String;
  strCodFab  : String;
  strLocFis  : String;
  strLocSup,
  strFicIns,
  strAplica  : String;
  fltEmbala  : Double;
  fltQtdDoc  : Double;
  fltQtdCon  : Double;
  fltAcomoda : Double;
  fltExcede  : Double;
begin
  Result := True;
  AblnRegistrouExcedente := False;
  if Locate('CODITE', strCodIte, []) then
  begin
    fltQtdDoc := fFormataFloat(FieldByName('QTDITE').AsFloat, intDeqTem);
    fltQtdCon := fFormataFloat(FieldByName('QTDCON').AsFloat, intDeqTem);

    if fltQtdDoc < fFormataFloat(fltQtdIte + fltQtdCon, intDeqTem) then
    begin
      if FblnGerTrf then
      begin
        if not fPergunta('O Item ' + strCodIte +
                         ' ultrapassou a quantidade da(s) Nota(s)! ' +
                         'Ao confirmar, no final será gerado um pedido de transferência. ' +
                         'Deseja confirmar o item?') then
        begin
          Result := False;
          Exit;
        end;

        {Capacidade restante em QTDCON antes de estourar QTDITE}
        fltAcomoda := fFormataFloat(fltQtdDoc - fltQtdCon, intDeqTem);
        if fltAcomoda < 0 then
          fltAcomoda := 0;

        fltExcede := fFormataFloat(fltQtdIte - fltAcomoda, intDeqTem);

        if fltExcede > 0 then
          pRegistraExcedente(FieldByName('CODITE').AsString,
                             FieldByName('DESITE').AsString,
                             fltExcede,
                             'Q');

        AblnRegistrouExcedente := True;
        fltQtdIte := fltAcomoda;
        Result    := (fltAcomoda > 0);
        Exit;
      end;

      pMensagemSonora('O Item ' + strCodIte + ' ultrapassou a quantidade da(s) Nota(s)!');
      Result := False;
    end;
  end
  else
  begin
    pRetProdutoCodBar(strCodIte,
                      strDesIte,
                      strCodRef,
                      strCodBar,
                      strRefere,
                      strCodUni,
                      strCodFab,
                      strLocFis,
                      strLocSup,
                      strFicIns,
                      strAplica,
                      strCTLEST,
                      fltEmbala);

    if FblnGerTrf then
    begin
      if not fPergunta('O Item ' + strCodBar +
                       ' não se encontra na(s) Nota(s)! ' +
                       'Ao confirmar, no final será gerado um pedido de transferência. ' +
                       'Deseja confirmar o item?') then
      begin
        Result := False;
        Exit;
      end;

      pRegistraExcedente(strCodIte, strDesIte, fltQtdIte, 'I');
      AblnRegistrouExcedente := True;
      Result := False;
      Exit;
    end;

    pMensagemSonora('O Item ' + strCodBar + ' não se encontra na(s) Nota(s)!');
    Result := False;
  end;
end;


procedure TRecConferEntrada.pRegistraExcedente(const AstrCodIte, AstrDesIte: String;
                                                const AfltQtdExc: Double;
                                                const AstrTipExc: String);
Begin
  If FcdsExcedentes.Locate('CODITE;TIPEXC', VarArrayOf([AstrCodIte, AstrTipExc]), []) Then
  Begin
    FcdsExcedentes.Edit;
    FcdsExcedentes.FieldByName('QTDEXC').AsFloat :=
      FcdsExcedentes.FieldByName('QTDEXC').AsFloat + AfltQtdExc;
    FcdsExcedentes.Post;
  End
  Else
  Begin
    FcdsExcedentes.Append;
    FcdsExcedentes.FieldByName('CODITE').AsString := AstrCodIte;
    FcdsExcedentes.FieldByName('DESITE').AsString := AstrDesIte;
    FcdsExcedentes.FieldByName('QTDEXC').AsFloat  := AfltQtdExc;
    FcdsExcedentes.FieldByName('TIPEXC').AsString := AstrTipExc;
    FcdsExcedentes.Post;
  End;
End;

procedure TRecConferEntrada.pExcluirExcedentes;
begin
  If Assigned(FcdsExcedentes) Then
    FcdsExcedentes.EmptyDataSet;
end;

end.
