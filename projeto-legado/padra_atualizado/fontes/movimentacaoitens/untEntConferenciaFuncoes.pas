unit untEntConferenciaFuncoes;

interface

Uses
  Classes,
  UniClientDataSet,
  DB,
  SysUtils,
  Uni,
  Math,
  EditFocus,
  DBGridCitel, DBGrids,
  frxClass,
  untFuncoesRel,
  untZClient,
  StrUtils,
  untIteBar,
  untTypesSistema, TypesRel,
  untFuncoesEtiquetas,
  untEntEmbalagens;

Type
  TAcaoPedidos = (acoPerguntar, acoLiberarTodos, acoNaoLiberarTodos);

  TArrString =  Array of String;
  TFuncUpItem = Function (strAutInc: String;
                          fltQtdUni, fltQtdEmb: Double;
                          Var fltQtdIte: Double;
                          Var strAutPcc: String): Boolean Of Object;

  TConfereEntrada = Class(TObject)
  Private
    objIteBar: TIteBar;
    objEmbala: TEntEmbalagens;

  //  blnTravaJaAssociados: Boolean;

    prmDllEtq: TParamDllEtiquetas;

    FSinEnt,
    FPcmCon,
    FPcmdet: TZClient;
    FPedidos,
    FEmpresas: TArrString;

    blnAutosize: Boolean;
    blnLibComps: Boolean;
    blnEtiDif  : Boolean;

    intDeqTem: Integer;
    intTamCod: Integer;

    blnBarCen : Boolean;

    Function fVeSeAtualizaPedidoCompraGrid(cdsPedidos: TUniClientDataSet; strNumPed, strCodEmp, strForEle, strForPed: String;
                                           blnAtualizaFornecedor: Boolean): Boolean;

    Function fVeSeAtualizaPedidoCompraGeral(strNumPed, strCodEmp, strForEle, strForPed: String; blnSalvaFornecedor: Boolean): Boolean;

    Function fSQLItensEtiq: String;

    Function fCarregaItensConferidos: Boolean;
    Function fCarregaPcmdetConferido: Boolean;
    Function fRetQtdContada(strCodIte: String): Double;
    Function fIncluiItem(strCodIte: String; fltQtdIte, fltQtdUni, fltQtdEmb: Double): Boolean;

    Function fAddItem(    strAutInc: String;
                          fltQtdUni, fltQtdEmb: Double;
                      Var fltQtdIte: Double;
                      Var strAutPcc: String): Boolean;

    Function fSubItem(    strAutInc: String;
                          fltQtdUni, fltQtdEmb: Double;
                      Var fltQtdIte: Double;
                      Var strAutPcc: String): Boolean;

    Function fSetaItem(fltQtdIte, fltQtdUni, fltQtdEmb: Double;
                       strAutInc, strAutPcc: String;
                       funUpdateItem: TFuncUpItem): Boolean;

    Function fRetQtdNaoContados(strAutInc: String): Double;
    Function fRetQtdContados(strAutInc: String): Double;

    function fRetQtdBai(strAutInc: String; var fltQtdBai: Double): Double;
    function fQtdItemOk(strCodIte: String; fltQtdIte: Double; Var strAutInc: String): Boolean;
    Function fSomaItem(fltQtdIte, fltQtdUni, fltQtdEmb: Double): Boolean;
    Function fSetaPedido: Boolean;
    Function fGravaLibArm(blnLiberaPedido: Boolean): Boolean;
    Function fVerificaItensAmenos(blnCriticas: Boolean): Boolean;
    Function fVerificaItensAmais(blnCriticas: Boolean): Boolean;
    function fVerificaSeParcial: Boolean;

    Function fRetQtdCon(strAutInc: String; Var fltQtdIte: Double; blnSomaQtdBai: Boolean = False): Double;
    Function fExcluiItem(strCodIte: String): Boolean;

//    Procedure pCopiaArray(Var arrDestino: TArrString; arrOrigem: Array of String);
    Procedure pAtualizaPcmdets(fltQtdIte, fltUnitar, fltPerIpi, fltPerSub: Double; strCodIte: String);
    procedure pInsereItemEtiqueta(intQtdEti: Integer; strBarDig: String);
    procedure pImprimeEtiqueta(intQtdIte: Integer; strBarDig: String);
    procedure pIncluiCritica(strCodIte,
                             strDesIte,
                             strRefere,
                             strDesUni,
                             strCodFab,
                             strLocFis: String;
                             fltQtdIte,
                             fltQtdCon,
                             fltSaldos: Double);

    Procedure pZeraQuantidadeSintetizada;
    procedure pImprimirLiberacaoArmazenamento;
    function fValidarImpressaoLiberacaoArmazenamento: Boolean;
//    Function fEfetivaBaixaPcmdet: Boolean;

  Public
    intDeqTpc : Integer;
    strCodDig : String;
    qryQtdIte : TUniQuery;
    dtsQtdIte : TDataSource;
    strCodFor : String;
    stlPedidos: TStringList;
    stlEmpresas: TStringList;
    blnParcial: Boolean;
    intRecNo  : Integer;
    cdsConsulta: TUniClientDataSet;
    cdsCriticas: TUniClientDataSet;
    cdsImpEtiIte: TZClient;
    dbgConsulta: TDBGridCitel;
    edtNumPed: TEditFocus;
    blnSintetico: Boolean;
    AfterScroll: TDataSetNotifyEvent;

    strCtlEst: String;

    blnMarcarTodos: Boolean;

    acoAcaoForDif: TAcaoPedidos;

    Function fVerificaQuantidadeSintetizada: Boolean;
    Function fPreparaBaixaPedidos: Boolean;
    Function fAtualizaDadosPcmDetSintetico(strCodIte: String;
                                           fltQtdIte,
                                           fltUnitar,
                                           fltPerIpi,
                                           fltPerSub,
                                           fltEmbala: Double): Boolean;
  //  Function fEfetivaBaixaPedidos: Boolean;

    function fSQLNotasPedido: String;
    function fSQLFonecedorNota: String;

    function fSqlSelecPedidos(blnLike, blnPreNota: Boolean): String;
    function fValidaPedidoSelec(cdsPedidos: TUniClientDataSet; strForSel: String;
                                blnAtualizaFornecedor: Boolean): Boolean;
    Function fPedidoCompleto(blnCriticas: Boolean): Boolean;
    Function fValidaQuantidade(edtQtdIte: TEditFocus): Boolean;
    Function fValidaPedido(strNumPed: String; edtLisPed: TEditFocus): Boolean;
    function fRetTotalItens: Boolean;
    Function fFinalizaPedido: Boolean;
    Function fListaLiberada(stlPedidos, stlEmpresas: TStringList): Boolean;
    Function fSqlConferencia(blnLike: Boolean): String;
    Function fRegistraItem(blnCodBar, blnCodFab: Boolean;
      edtCodIte, edtQtdIte, edtQtdEti: TEditFocus;
      blnSemelhante: Boolean; Var blnCodBarNaoEcontrado: Boolean): Boolean;
    Procedure pRetListaPedidos(stlPedidos, stlEmpresas, stlAutInc: TStringList; cdsPedidos: TDataSet);

    procedure pLiberaLista;
    Procedure pExcluiItem;
    procedure pConfirma(blnSolicitaRefugo : Boolean = False);

    Constructor Create(cdsConsultaP,
                       cdsCriticasP: TUniClientDataSet;
                       edtNumPedP: TEditFocus;
                       dbgConsultaP: TDBGridCitel;
                       AfterScrollp: TDataSetNotifyEvent;
                       blnAutosizeP: Boolean = False); overload;

    Constructor Create(stlPedidosP, stlEmpresasP: TStringList); overload;

    procedure pCarregaEtiqueta(strNomFrm: String);

    Procedure pAtualizaDataConf;

    Function  fRetAutIncPed(strNumPed: String): String;

    Destructor Destroy; override;
  End;


implementation

Uses
    untFuncoesSimples,
    untFuncoesPedidoSimples,
    untEntConfSintDifere,
    untCfgRel,
    untPesqAux,
    untFatSelecProduto,
    untEntConferenciaGarantiaDigRefugo,
    untQckLiberacaoArmazenamento;


Constructor TConfereEntrada.Create(cdsConsultaP,
                                   cdsCriticasP: TUniClientDataSet;
                                   edtNumPedP: TEditFocus;
                                   dbgConsultaP: TDBGridCitel;
                                   AfterScrollp: TDataSetNotifyEvent;
                                   blnAutosizeP: Boolean = False);
Begin
  intDeqTem   := fCfgSis('DEQTEM', varInteger);
  intDeqTpc   := fCfgSis('DEQTPC', varInteger);
  blnEtiDif   := fCfgSis('ETIDIF', varBoolean);
  objIteBar   := TIteBar.Create(opcFuncoes);
  objEmbala   := TEntEmbalagens.Create(Nil);
  blnBarCen   := (fCfgSis('BARCEN',varBoolean)) Or (fCfgSis('ITEBAR', varBoolean));
  intTamCod   := fTamCodIte;

  strCtlEst := fCfgSis('CTLEST');


//  blnTravaJaAssociados := Not fCfgSis('PERASS', varBoolean);

  acoAcaoForDif  := acoPerguntar;
  blnMarcarTodos := False;

  blnLibComps := True;
  blnAutosize := blnAutosizeP;
  cdsConsulta := cdsConsultaP;
  cdsCriticas := cdsCriticasP;
  edtNumPed   := edtNumPedP;
  dbgConsulta := dbgConsultaP;
  AfterScroll := AfterScrollp;

  qryQtdIte := fCriaQuery(Nil);
  dtsQtdIte := TDataSource.Create(Nil);
  dtsQtdIte.DataSet := qryQtdIte;
  stlPedidos := TStringList.Create;
  stlEmpresas := TStringList.Create;
  blnParcial   := False;
  blnSintetico := True;
  FSinEnt      := Nil;
  FPcmCon      := Nil;
  FPcmdet      := Nil;

  cdsImpEtiIte := Nil;
  prmDllEtq    := Nil;
End;

Constructor TConfereEntrada.Create(stlPedidosP, stlEmpresasP: TStringList);
Begin
  blnEtiDif    := fCfgSis('ETIDIF', varBoolean);
  objIteBar    := TIteBar.Create(opcFuncoes);

  strCtlEst := fCfgSis('CTLEST');

  blnLibComps  := False;
  stlPedidos   := stlPedidosP;
  stlEmpresas  := stlEmpresasP;
  FSinEnt      := Nil;
  FPcmCon      := Nil;
  FPcmdet      := Nil;
  cdsImpEtiIte := Nil;
  prmDllEtq    := Nil;

//  blnTravaJaAssociados := Not fCfgSis('PERASS', varBoolean);
End;

Destructor TConfereEntrada.Destroy;
Begin
  Inherited;

  If blnLibComps Then
  Begin
    qryQtdIte.Close;
    FreeAndNil(dtsQtdIte);
    FreeAndNil(qryQtdIte);
    {*************************************}
    {* LIBERA A LISTA DE LOCKS AO FECHAR *}
    {**********************************DP*}
    pLiberaLista;
    stlPedidos.Clear;
    FreeAndNil(stlPedidos);

    stlEmpresas.Clear;
    FreeAndNil(stlEmpresas);
  End;

  If Assigned(FSinEnt) Then
    FreeAndNil(FSinEnt);

  If Assigned(FPcmCon) Then
    FreeAndNil(FPcmCon);

  If Assigned(FPcmdet) Then
    FreeAndNil(FPcmdet);

  If Assigned(prmDllEtq) Then
    FreeAndNil(prmDllEtq);

  If Assigned(cdsImpEtiIte) Then
    FreeAndNil(cdsImpEtiIte);

  If Assigned(objIteBar) Then
    FreeAndNil(objIteBar);

  If Assigned(objEmbala) Then
    FreeAndNil(objEmbala);
End;

Function TConfereEntrada.fSQLItensEtiq: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';

  strSQL := strSQL + '   ITE_APLICA AS APLICA, ';
  strSQL := strSQL + '   ITE_CODBAR AS CODBAR, ';
  strSQL := strSQL + '   I.ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '   ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '   " "        AS EMPCGF, ';
  strSQL := strSQL + '   " "        AS NOMEMP, ';
  strSQL := strSQL + '   ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '   CONCAT(ITE_CODFAB, " - ", IFNULL(MAR_DESMAR, "")) AS FABMAR, ';
  strSQL := strSQL + '   I.ITE_TABEMF AS TABEMF, ';
  strSQL := strSQL + '   I.ITE_DESFEC AS DESFEC, ';
  strSQL := strSQL + '   I.ITE_EMBFEC AS EMBFEC, ';

  strSQL := strSQL + '   ITE_LOCFIS AS LOCFIS, ';
  strSQL := strSQL + '   MAR_DESMAR AS DESMAR, ';

  strSQL := strSQL + '   ITE_PREVE1 AS PREVE1, ';
  strSQL := strSQL + '   ITE_PREVE2 AS PREVE2, ';
  strSQL := strSQL + '   ITE_PREVE3 AS PREVE3, ';
  strSQL := strSQL + '   ITE_PREVE4 AS PREVE4, ';
  strSQL := strSQL + '   ITE_PREVE5 AS PREVE5, ';
  strSQL := strSQL + '   ITE_PREVE6 AS PREVE6, ';
  strSQL := strSQL + '   ITE_PREVE7 AS PREVE7, ';

  strSQL := strSQL + '   0.0000     AS PROMOC, ';
  strSQL := strSQL + '   ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '   UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '   ITE_PREVE1 AS VALITE, ';
  strSQL := strSQL + '   ITE_PREVE1 AS VALVIS  ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADITE C ';

  strSQL := strSQL + ' INNER JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE AND ';
  strSQL := strSQL + '                        I.ITE_CODEMP =  ' + QuotedStr(VS_strCodEmp);

  strSQL := strSQL + ' LEFT JOIN CADMAR ON ITE_CODMAR = MAR_CODMAR ';

  strSQL := strSQL + ' LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';

  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '   FALSE  ';

  Result := strSQL;
End;

procedure TConfereEntrada.pCarregaEtiqueta(strNomFrm: String);
  Var
    strNomImp,
    strTipImp: String;
Begin
  Try
    cdsImpEtiIte := TZClient.Create(Nil, fSQLItensEtiq);

    If cdsImpEtiIte.fAbreClient(True, 'TConfereEntrada.pCarregaEtiqueta') Then
    Begin

      pCarregaConfImprRel(strNomFrm, strNomImp, strTipImp);
      strNomImp := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');

      prmDllEtq := TParamDllEtiquetas.Create;

      With prmDllEtq Do
      Begin
        tpeTipEtq := tpeItensArgoxCodBarSPre;
        dtsImpres := cdsImpEtiIte;
        strNomFil := strNomImp;
        strNomFrm := strNomFrm;
        blnImpEti := Not fEmptyStr(strNomImp);
      End;
      
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TConfereEntrada.pCarregaEtiqueta]');
    End;
  End;

End;

procedure TConfereEntrada.pLiberaLista;
  Var
    intIndice: Integer;
Begin
  For intIndice := 0 To stlPedidos.Count - 1 Do
    fLock_Unlock('PEDCOMPD' + stlPedidos[intIndice] +  stlEmpresas[intIndice], False, False);
End;

procedure TConfereEntrada.pRetListaPedidos(stlPedidos, stlEmpresas, stlAutInc: TStringList; cdsPedidos: TDataSet);
  Var
    intContador: Integer;
    stlPedidosValidacao: TStringList;
Begin
  stlPedidos.Clear;
  stlEmpresas.Clear;
  stlPedidosValidacao := TStringList.Create; {validaçã para não incluir o mesmo pedido/empresa na lista stlPedidos, causando erro de duplicidade na PEDELE}
  Try
    For intContador := 0 To stlAutInc.Count - 1 Do
    With cdsPedidos Do
    If Locate('AUTOINCREM', stlAutInc[intContador], []) Then
    Begin
      if stlPedidosValidacao.IndexOf(FieldByName('NUMPEDCODEMP').AsString) < 0 Then
      Begin
        stlPedidos.Add(FieldByName('PCG_NUMPED').AsString);
        stlEmpresas.Add(FieldByName('PCG_CODEMP').AsString);
        stlPedidosValidacao.Add(FieldByName('NUMPEDCODEMP').AsString);
      End;
    End;
  Finally
    FreeAndNil(stlPedidosValidacao)
  End;
end;

Procedure TConfereEntrada.pAtualizaDataConf;
var
  qryUpd: TUniQuery;
  I: Integer;
Begin
  Try
  qryUpd := fCriaQuery;

    With qryUpd, SQL Do
    Begin
      Add('UPDATE PCMGER');
      Add(' SET PCG_INDCON =  :INDCON,');
      Add('     PCG_INHCON =  :INHCON ');
      Add('WHERE AUTOINCREM = :AUTINC ');
      Add('    AND PCG_INDCON IS NULL ');
      Add('    AND PCG_INHCON IS NULL ');

      ParamByName('INDCON').AsDate := Date;
      ParamByName('INHCON').AsTime := fTime();

      For I := 0 To stlPedidos.Count - 1 Do
      Begin
        ParamByName('AUTINC').AsString  := fRetAutIncPed(stlPedidos.Strings[I]);
        ExecSQL;
      End;
    End;

  Finally
    FreeAndNil(qryUpd);
  End;

End;

Function TConfereEntrada.fListaLiberada(stlPedidos, stlEmpresas: TStringList): Boolean;
  Var
    intIndice: Integer;
Begin
  Result := True;

  pLiberaLista;

  For intIndice := 0 To stlPedidos.Count - 1 Do
    If Not fLock_Unlock('PEDCOMPD' + stlPedidos[intIndice] + stlEmpresas[intIndice], True, False, TRUE) Then
    Begin
      Result := FALSE;

      {***********************************}
      {* TIROU PLIBERALISTA DAQUI        *}
      {* POIS A MESMA ESTAVA LIBERANDO   *}
      {* AO VERIFICAR QUE ESTAVA EM LOCK *}
      {********************************DP*}
      fMensagem('', 'Esse Documento está sendo utilizado em outra Estação por ' +
                     fGetHostLock('PEDCOMPD' + stlPedidos[intIndice] +  stlEmpresas[intIndice])  + '!', ['&Ok'],
                1, False, 1, 0, blnAutosize);

      Break;
    End;

End;

Function TConfereEntrada.fSetaItem(fltQtdIte, fltQtdUni, fltQtdEmb: Double;
                                   strAutInc, strAutPcc: String;
                                   funUpdateItem: TFuncUpItem): Boolean;
  Var
    stlListaReg: TStringList;
    intIndice: Integer;
Begin
  Result := True;
  Try
    stlListaReg := TStringList.Create;

    stlListaReg.CommaText := strAutInc;

    For intIndice := 0 To stlListaReg.Count - 1 Do
    Begin
      If Not funUpdateItem(stlListaReg[intIndice],
                           fltQtdUni,
                           fltQtdEmb,
                           fltQtdIte,
                           strAutPcc) Then
      Begin
        Result := False;
        Break;
      End;

      If fltQtdIte = 0 Then
        Break;
    End;

    FreeAndNil(stlListaReg);

  Except

    On E: Exception Do
    Begin
      Result := FALSE;
      pMensagensErro(E.Message, '[fSetaItem]');
    End;

  End;

End;

Function TConfereEntrada.fRetQtdNaoContados(strAutInc: String): Double;
  Var
    qryIns: TUniQuery;
Begin
  qryIns := fCriaQuery;
  With qryIns, SQL Do
  Begin

    Clear;
    Add('SELECT ((PCD_QTDITE - IFNULL(PCD_QTDBAI, 0)) *  ');

    If fCfgSis('CNVEMB') <> 'N' Then
      Add(' IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA) ')

    Else
      Add(' 1 ');

    Add('    - IFNULL(PCD_QTDCON, 0)) AS NAO_CONTADOS FROM PCMDET D');

    Add('WHERE');
    Add('  D.AUTOINCREM = :AUTINC');

    ParamByName('AUTINC').AsString := strAutInc;
    Open;

    If Not IsEmpty Then
    Begin
      Result := FieldByName('NAO_CONTADOS').AsFloat;
    End Else
    Begin
      Result := 0;
    End;

  End;

  FreeAndNil(qryIns);
End;

Function TConfereEntrada.fRetQtdContados(strAutInc: String): Double;
  Var
    qryIns: TUniQuery;
Begin
  qryIns := fCriaQuery;
  With qryIns, SQL Do
  Begin

    Clear;
    Add('SELECT IFNULL(PCD_QTDCON, 0) AS CONTADOS FROM PCMDET');
    Add('WHERE');
    Add('  AUTOINCREM = :AUTINC');

    ParamByName('AUTINC').AsString := strAutInc;
    Open;

    If Not IsEmpty Then
    Begin
      Result := FieldByName('CONTADOS').AsFloat;
    End Else
    Begin
      Result := 0;
    End;

  End;

  FreeAndNil(qryIns);
End;

Function TConfereEntrada.fRetQtdCon(strAutInc: String; Var fltQtdIte: Double; blnSomaQtdBai: Boolean = False): Double;
  Var
    qryIns: TUniQuery;
Begin
  qryIns := fCriaQuery;
  With qryIns, SQL Do
  Begin

    Clear;
    Add('SELECT  ');

    If fCfgSis('CNVEMB') <> 'N' Then
    Begin
      Add('  (PCD_QTDITE * IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA)) AS PCD_QTDITE, ');
      Add('  (PCD_QTDBAI * IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA)) AS PCD_QTDBAI, ');
    End

    Else
    Begin
      Add('  PCD_QTDITE, ');
      Add('  PCD_QTDBAI, ');
    End;

    Add('   PCD_QTDCON ');

    Add('FROM PCMDET D');

    Add('WHERE');
    Add('  D.AUTOINCREM = :AUTINC');

    ParamByName('AUTINC').AsString := strAutInc;
    Open;

    If Not IsEmpty Then
    Begin
      fltQtdIte := FieldByName('PCD_QTDITE').AsFloat;

      If Not blnSomaQtdBai Then
        Result := FieldByName('PCD_QTDBAI').AsFloat - FieldByName('PCD_QTDCON').AsFloat
      Else
        Result := FieldByName('PCD_QTDBAI').AsFloat + FieldByName('PCD_QTDCON').AsFloat;

    End Else
    Begin
      Result := 0;
    End;

  End;

  FreeAndNil(qryIns);
End;

Function TConfereEntrada.fRetQtdContada(strCodIte: String): Double;
  Var
    qryQtd: TUniQuery;
    strSQL: String;
    intContador: Integer;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                      ';
  strSQL := strSQL + '   SUM(PCD_QTDCON) AS QTDCON ';
  strSQL := strSQL + ' FROM                        ';
  strSQL := strSQL + '   PCMDET D                  ';
  strSQL := strSQL + ' INNER JOIN PCMGER P ON P.PCG_NUMPED = D.PCD_NUMPED AND ';
  strSQL := strSQL + '                        P.PCG_ESPDOC = D.PCD_ESPDOC AND ';
  strSQL := strSQL + '                        P.PCG_CODEMP = D.PCD_CODEMP     ';
  strSQL := strSQL + ' INNER JOIN CADITE I ON I.ITE_CODITE = PCD_CODITE       ';
  strSQL := strSQL + ' INNER JOIN ITEGER G ON G.ITE_CODITE = PCD_CODITE AND   ';
  strSQL := strSQL + '                        G.ITE_CODEMP = '+ QuotedStr(VS_strCodEmp) + ' ';

  strSQL := strSQL + ' LEFT  JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ';

  strSQL := strSQL + ' WHERE      ';
  strSQL := strSQL + '   PCD_CODITE = :CODITE AND ';
  strSQL := strSQL + '   PCD_ESPDOC = "PD" AND ';
  strSQL := strSQL + '   ROUND(PCD_QTDITE - PCD_QTDBAI, 4) > 0 AND  ';

  strSQL := strSQL + '   PCD_NUMPED IN (' + stlPedidos.CommaText + ') AND ';

  strSQL := strSQL + '   (FALSE  ';

  For IntContador := 0 To stlPedidos.Count - 1 Do
    strSQL := strSQL + '  OR (PCG_NUMPED = ' + QuotedStr(stlPedidos[intContador]) + ' AND PCG_CODEMP = ' + QuotedStr(stlEmpresas[intContador]) + ') ';

  strSQL := strSQL + '   )  ';
  strSQL := strSQL + ' GROUP BY PCD_CODITE ';

  qryQtd := fCriaQuery;
  With qryQtd, SQL Do
  Begin
    SQL.Text := strSQL;

    //ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CODITE').AsString := strCodIte;
    Open;

    If Not IsEmpty Then
    Begin
      Result := FieldByName('QTDCON').AsFloat;
    End Else
    Begin
      Result := 0;
    End;

  End;

  FreeAndNil(qryQtd);
End;

Function TConfereEntrada.fSubItem(strAutInc: String;
                                  fltQtdUni, fltQtdEmb: Double;
                                  Var fltQtdIte: Double;
                                  Var strAutPcc: String): Boolean;
  Var
    qryIns: TUniQuery;
    fltQtdAnt: Double;
Begin
  qryIns := fCriaQuery;
  With qryIns, SQL Do
  Begin

    fltQtdAnt := fRetQtdContados(strAutInc);

    If fltQtdAnt > 0 Then
    Begin
      Clear;
      Add('UPDATE PCMDET D');
      Add('SET');
      Add('  PCD_QTDCON = IF(ROUND(PCD_QTDCON - :QTDCON, ' + fCfgSis('DEQTPC') + ') >= 0, PCD_QTDCON - :QTDCON, 0) ');
      Add('WHERE');
      Add('  D.AUTOINCREM = :AUTINC');

      ParamByName('AUTINC').AsString := strAutInc;
      ParamByName('QTDCON').AsFloat  := fltQtdIte;
      ExecSQL;

      If RoundTo(fltQtdAnt - fltQtdIte, -2) >= 0 Then
        fltQtdIte := 0
      Else
        fltQtdIte := fltQtdIte - fltQtdAnt;
    End;

    Clear;

    If blnSintetico Then
    Begin
      Add('DELETE FROM PCMCON');
      Add('WHERE');
      Add('  AUTOINCREM IN (SELECT CON_SEQGER FROM PCDCON WHERE CON_SEQDET = :AUTINC)');
      ParamByName('AUTINC').AsString := strAutInc;
    End Else
    Begin
      Add('DELETE FROM PCMCON');
      Add('WHERE');
      Add('  AUTOINCREM = :AUTINC');
      ParamByName('AUTINC').AsString := strAutPcc;
    End;

    ExecSQL;
    Close;
  End;

  Result := True;
  FreeAndNil(qryIns);
End;

Function TConfereEntrada.fExcluiItem(strCodIte: String): Boolean;
Begin
  With qryQtdIte Do
  Begin
    If blnSintetico  Then
    Begin
      Result := Locate('CODITE', strCodIte, []) And
                fSetaItem(FieldByName('QTDITE').AsFloat, 0, 0,
                          FieldByName('AUTINC').AsString, '', fSubItem);
    End Else
    Begin
      Result := Locate('CODITE', strCodIte, []) And
                fSetaItem(cdsConsulta.FieldByName('ITE_QTDCON').AsFloat, 0, 0,
                          cdsConsulta.FieldByName('AUTOINCREM').AsString,
                          cdsConsulta.FieldByName('AUTOINCPCC').AsString,
                          fSubItem);
    End;
  End;
End;

Procedure TConfereEntrada.pExcluiItem;
Begin
  If (Not cdsConsulta.Active) Or cdsConsulta.IsEmpty Then
    Exit;

  With cdsConsulta Do
  If fMensagem('', 'Deseja excluir o item ' +
     FieldByName('ITE_CODITE').AsString + ' ?', ['&Sim', '&Não'], 1, False, 1, 0, blnAutosize) = 1 Then
  Begin
    Try

      fStartTransaction;

      If fExcluiItem(FieldByName('ITE_CODITE').AsString) Then
        Delete
      Else
        fRollBack;

      fCommit;

    Except

      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[btnExcluirClick]');
      End;

    End;

  End;
End;

Function TConfereEntrada.fSqlConferencia(blnLike: Boolean): String;
  Var
    intContador: Integer;
Begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE                                              ';
  Result := Result + '   IF(IFNULL(PCG_EMPDES, "") = "", PCG_CODEMP, PCG_EMPDES) AS PCG_CODEMP,     ';
  Result := Result + '   PCD_CODITE AS ITE_CODITE,                                      ';

  If blnSintetico Then
  Begin
    Result := Result + '   CAST(GROUP_CONCAT(D.AUTOINCREM) AS CHAR(1000)) AS AUTOINCREM,                    ';
    Result := Result + '   " "                        AS AUTOINCPCC,                    ';
    Result := Result + '   0.0000                     AS ITE_QTDUNI,                    ';
    Result := Result + '   0.0000                     AS ITE_QTDEMB,                    ';
    Result := Result + '   SUM(PCD_QTDCON)            AS ITE_QTDCON,                    ';
  End Else
  Begin
    Result := Result + '   CAST(GROUP_CONCAT(DISTINCT CON_SEQDET) AS CHAR(1000)) AS AUTOINCREM,             ';
    Result := Result + '   M.AUTOINCREM                      AS AUTOINCPCC,             ';
    Result := Result + '   PCC_QTDUNI                        AS ITE_QTDUNI,             ';
    Result := Result + '   PCC_QTDEMB                        AS ITE_QTDEMB,             ';
    Result := Result + '   PCC_QTDUNI * PCC_QTDEMB           AS ITE_QTDCON,             ';
  End;

  Result := Result + '   ITE_FICINS,                                                   ';

  Result := Result + '   IF(IFNULL(ITE_CODBAR,"") = "", "-", ITE_CODBAR) AS ITE_CODBAR, ';
  Result := Result + '   IFNULL((SELECT BAR_CODBAR FROM ITEBAR WHERE BAR_CODITE = PCD_CODITE AND BAR_CODFOR = PCD_CODFOR ORDER BY BAR_COMPRA DESC LIMIT 1), IF(IFNULL(ITE_BAREMB,"") = "", "-", ITE_BAREMB)) AS ITE_BAREMB, ';
  Result := Result + '   IF(IFNULL(ITE_CODFAB,"") = "", "-", ITE_CODFAB) AS ITE_CODFAB, ';
  Result := Result + '   IF(IFNULL(ITE_DESITE,"") = "", "-", ITE_DESITE) AS ITE_DESITE, ';
  Result := Result + '   IF(IFNULL(ITE_REFERE,"") = "", "-", ITE_REFERE) AS ITE_REFERE, ';
  Result := Result + '   IF(IFNULL(UNI_DESUNI,"") = "", "-", UNI_DESUNI) AS ITE_DESUNI, ';
  Result := Result + '   IF(IFNULL(ITE_LOCFIS,"") = "", "-", ITE_LOCFIS) AS ITE_LOCFIS, ';
  Result := Result + '   IFNULL((SELECT BAR_EMBALA FROM ITEBAR WHERE BAR_CODITE = PCD_CODITE AND BAR_CODFOR = PCD_CODFOR ORDER BY BAR_COMPRA DESC LIMIT 1), IF(IFNULL(ITE_EMBALA, 0) <= 0, 1, ITE_EMBALA)) AS ITE_EMBALA, ';
  Result := Result + '   ITE_SALDOS                                      AS ITE_SALDOS  ';

  Result := Result + ' FROM          ';
  Result := Result + '   PCMDET D    ';

  Result := Result + ' INNER JOIN PCMGER   ON PCG_NUMPED = PCD_NUMPED AND ';
  Result := Result + '                        PCG_ESPDOC = PCD_ESPDOC AND ';
  Result := Result + '                        PCG_CODEMP = PCD_CODEMP     ';
  Result := Result + ' INNER JOIN CADITE I ON I.ITE_CODITE = PCD_CODITE ';

  Result := Result + ' INNER JOIN ITEGER G ON G.ITE_CODITE = PCD_CODITE AND ';
  Result := Result + '                        G.ITE_CODEMP = '+ QuotedStr(VS_strCodEmp) + ' ';

  Result := Result + ' LEFT  JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';

  If Not blnSintetico Then
  Begin
    Result := Result + ' INNER JOIN PCDCON N ON N.CON_SEQDET = D.AUTOINCREM ';
    Result := Result + ' INNER JOIN PCMCON M ON M.AUTOINCREM = N.CON_SEQGER ';
  End;

  Result := Result + ' WHERE      ';
  Result := Result + '   PCG_BAIXAD = 0 AND ';
  Result := Result + '   PCD_QTDCON > 0 AND ';
  Result := Result + '   PCD_ESPDOC = "PD" AND ';

  Result := Result + '   PCD_NUMPED IN (' + stlPedidos.CommaText + ') AND ';

  Result := Result + '   (FALSE  ';

  For IntContador := 0 To stlPedidos.Count - 1 Do
    Result := Result + '  OR (PCG_NUMPED = ' + QuotedStr(stlPedidos[intContador]) + ' AND PCG_CODEMP = ' + QuotedStr(stlEmpresas[intContador]) + ') ';

  Result := Result + '   )  ';

  Result := Result + ' GROUP BY      ';

  If blnSintetico Then
  Begin
    Result := Result + '  PCD_CODITE  ';
  End Else
  Begin
    Result := Result + ' M.AUTOINCREM ';
  End;

End;

function TConfereEntrada.fRetTotalItens: Boolean;
  Var
    strSQL: String;
    intContador: Integer;
Begin
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT                    ';
    strSQL := strSQL + '   GROUP_CONCAT(D.AUTOINCREM) AS AUTINC, ';
    strSQL := strSQL + '   PCD_DESITE AS DESITE,   ';
    strSQL := strSQL + '   I.ITE_REFERE AS REFERE,   ';
    strSQL := strSQL + '   PCD_CODITE AS CODITE,   ';

    If fCfgSis('CNVEMB') <> 'N' Then
    Begin
      strSQL := strSQL + '   SUM(PCD_QTDITE * IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA)) AS QTDITE, ';
      strSQL := strSQL + '   SUM(PCD_QTDBAI * IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA)) AS QTDBAI, ';
    End
    Else
    Begin
      strSQL := strSQL + '   SUM(PCD_QTDITE) AS QTDITE, ';
      strSQL := strSQL + '   SUM(PCD_QTDBAI) AS QTDBAI, ';
    End;

    strSQL := strSQL + '   SUM(PCD_QTDCON) AS QTDCON, ';
    strSQL := strSQL + '   G.ITE_LOCFIS AS LOCFIS,   ';
    strSQL := strSQL + '   I.ITE_CODFAB AS CODFAB,   ';
    strSQL := strSQL + '   I.ITE_CODBAR AS CODBAR,   ';
    strSQL := strSQL + '   I.ITE_BAREMB AS BAREMB,   ';
    strSQL := strSQL + '   IFNULL((SELECT BAR_EMBALA FROM ITEBAR WHERE BAR_CODITE = PCD_CODITE AND BAR_CODFOR = PCD_CODFOR ORDER BY BAR_COMPRA DESC LIMIT 1), IF(IFNULL(I.ITE_EMBALA, 0) <= 0, 1, I.ITE_EMBALA)) AS EMBALA,   ';
    strSQL := strSQL + '   ITE_SALDOS AS SALDOS,   ';
    strSQL := strSQL + '   UNI_SIGUNI AS DESUNI    ';
    strSQL := strSQL + ' FROM                      ';
    strSQL := strSQL + '   PCMDET D                ';

    strSQL := strSQL + ' INNER JOIN PCMGER P ON P.PCG_NUMPED = D.PCD_NUMPED AND ';
    strSQL := strSQL + '                        P.PCG_ESPDOC = D.PCD_ESPDOC AND ';
    strSQL := strSQL + '                        P.PCG_CODEMP = D.PCD_CODEMP     ';

    strSQL := strSQL + ' INNER JOIN CADITE I ON I.ITE_CODITE = PCD_CODITE       ';

    strSQL := strSQL + ' INNER JOIN ITEGER G ON G.ITE_CODITE = PCD_CODITE AND   ';
    strSQL := strSQL + '                        G.ITE_CODEMP = '+ QuotedStr(VS_strCodEmp) + ' ';

    strSQL := strSQL + ' LEFT  JOIN CADUNI ON I.ITE_CODUNI = UNI_CODUNI ';

    strSQL := strSQL + ' WHERE      ';
    strSQL := strSQL + '   PCG_BAIXAD = 0 AND ';
    strSQL := strSQL + '   PCD_ESPDOC = "PD" AND ';
    strSQL := strSQL + '   ROUND(PCD_QTDITE - PCD_QTDBAI, 4) > 0 AND  ';

    strSQL := strSQL + '   PCD_NUMPED IN (' + stlPedidos.CommaText + ') AND ';

    strSQL := strSQL + '   (FALSE  ';

    For IntContador := 0 To stlPedidos.Count - 1 Do
      strSQL := strSQL + '  OR (PCG_NUMPED = ' + QuotedStr(stlPedidos[intContador]) + ' AND PCG_CODEMP = ' + QuotedStr(stlEmpresas[intContador]) + ') ';

    strSQL := strSQL + '   )  ';

    strSQL := strSQL + ' GROUP BY PCD_CODITE ';

    With qryQtdIte Do
    Begin
      SQL.Text := strSQL;

      If FindParam('CODEMP') <> Nil Then
        ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;

      Result := TRUE;
    End;

  Except

    On E: Exception Do
    Begin
      Result := FALSE;
      pMensagensErro(E.Message, '[fRetTotalItens]');
    End;

  End;

End;

function TConfereEntrada.fVerificaSeParcial: Boolean;
begin
  fRetTotalItens;
  Result := False;
  With cdsConsulta Do
  Begin
    DisableControls;
    qryQtdIte.First;
    While Not qryQtdIte.Eof Do
    Begin
      If Not fCfgSis('PERCPA', varBoolean) Then
      Begin

        If Not Locate('ITE_CODITE',qryQtdIte.FieldByName('CODITE').AsString, []) Then
        Begin
          Result := True;
          Break;
        End (*

        Else If (qryQtdIte.FieldByName('QTDCON').AsFloat + qryQtdIte.FieldByName('QTDBAI').AsFloat < qryQtdIte.FieldByName('QTDITE').AsFloat) Then
        Begin
          Result := True;
          Break;
        End*);

      End
      Else
      Begin
        If Locate('ITE_CODITE', qryQtdIte.FieldByName('CODITE').AsString, []) Then
        Begin
          If (qryQtdIte.FieldByName('QTDCON').AsFloat + qryQtdIte.FieldByName('QTDBAI').AsFloat < qryQtdIte.FieldByName('QTDITE').AsFloat) Then
          Begin
            Result := True;
            Break;
          End;
        End
        Else
        Begin
          Result := True;
          Break;
        End;
      End;
      qryQtdIte.Next;
    End;
    EnableControls;
  End;
end;

procedure TConfereEntrada.pIncluiCritica(strCodIte,
                                         strDesIte,
                                         strRefere,
                                         strDesUni,
                                         strCodFab,
                                         strLocFis: String;
                                         fltQtdIte,
                                         fltQtdCon,
                                         fltSaldos: Double);
Begin
  If Assigned(cdsCriticas) Then
  With cdsCriticas Do
  If Not cdsCriticas.Locate('CODITE', strCodIte, []) Then
  Begin
    Insert;
    FieldByName('CODITE').AsString := strCodIte;
    FieldByName('DESITE').AsString := strDesIte;
    FieldByName('REFERE').AsString := strRefere;
    FieldByName('CODFAB').AsString := strCodFab;
    FieldByName('LOCFIS').AsString := strLocFis;
    FieldByName('DESUNI').AsString := strDesUni;
    FieldByName('QTDITE').AsFloat  := fltQtdIte;
    FieldByName('QTDCON').AsFloat  := fltQtdCon;
    FieldByName('SALDOS').AsFloat  := fltSaldos;
    Post;
  End;
End;

Function TConfereEntrada.fVerificaItensAmais(blnCriticas: Boolean): Boolean;
Begin
  Result := True;
  With cdsConsulta Do
  Begin
    DisableControls;

    First;
    While Not Eof Do
    Begin

      If qryQtdIte.Locate('CODITE',FieldByName('ITE_CODITE').AsString, []) Then
      Begin

        If blnCriticas Then
        Begin
          pIncluiCritica(FieldByName('ITE_CODITE').AsString,
                         FieldByName('ITE_DESITE').AsString,
                         FieldByName('ITE_REFERE').AsString,
                         FieldByName('ITE_DESUNI').AsString,
                         FieldByName('ITE_CODFAB').AsString,
                         FieldByName('ITE_LOCFIS').AsString,
                         qryQtdIte.FieldByName('QTDITE').AsFloat,
                         FieldByName('ITE_QTDCON').AsFloat,
                         FieldByName('ITE_SALDOS').AsFloat);
        End;

        If RoundTo(qryQtdIte.FieldByName('QTDITE').AsFloat, -2) <>
           RoundTo(FieldByName('ITE_QTDCON').AsFloat, -2) Then
        Begin

          If Not blnParcial And Not fCfgSis('PERCPA', varBoolean) Then
          Begin
            Result := False;
            If Not blnCriticas Then
            Begin
              fMensagem('ATENÇÃO!', 'A quantidade do Item ' + FieldByName('ITE_CODITE').AsString + ' no pedido (' +
                        FloatToStrF(qryQtdIte.FieldByName('QTDITE').AsFloat, ffNumber, 12, fCfgSis('DECQTD', varInteger)) +
                        ') difere da quantidade informada (' +  FloatToStrF(FieldByName('ITE_QTDCON').AsFloat, ffNumber, 12,
                        fCfgSis('DECQTD', varInteger)) + ').', ['&O k'], 1, False, 1, 0, blnAutosize);
              Break;
            End;
          End;

        End;

      End
      Else
      Begin

        If blnCriticas Then
        Begin
          pIncluiCritica(FieldByName('ITE_CODITE').AsString,
                         FieldByName('ITE_DESITE').AsString,
                         FieldByName('ITE_REFERE').AsString,
                         FieldByName('ITE_DESUNI').AsString,
                         FieldByName('ITE_CODFAB').AsString,
                         FieldByName('ITE_LOCFIS').AsString,
                         0,
                         FieldByName('ITE_QTDCON').AsFloat,
                         FieldByName('ITE_SALDOS').AsFloat);
          Result := False;
        End
        Else If Not blnParcial And Not fCfgSis('PERCPA', varBoolean) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Item ' + FieldByName('ITE_CODBAR').AsString +
            ' não se encontra no pedido!', ['&O k'], 1, False, 1, 0, blnAutosize);
          Result := False;
          Break;
        End;

      End;

      Next;
    End;

    EnableControls;
  End;
End;

Function TConfereEntrada.fVerificaItensAmenos(blnCriticas: Boolean): Boolean;
Begin
  Result := True;
  With cdsConsulta Do
  Begin
    DisableControls;

    qryQtdIte.First;

    While Not qryQtdIte.Eof Do
    Begin

      If Locate('ITE_CODITE',qryQtdIte.FieldByName('CODITE').AsString, []) Then
      Begin

        If blnCriticas And (qryQtdIte.FieldByName('QTDCON').AsFloat + qryQtdIte.FieldByName('QTDBAI').AsFloat < qryQtdIte.FieldByName('QTDITE').AsFloat) Then
        Begin
          Result := False;
          pIncluiCritica(qryQtdIte.FieldByName('CODITE').AsString,
                         qryQtdIte.FieldByName('DESITE').AsString,
                         qryQtdIte.FieldByName('REFERE').AsString,
                         qryQtdIte.FieldByName('DESUNI').AsString,
                         qryQtdIte.FieldByName('CODFAB').AsString,
                         qryQtdIte.FieldByName('LOCFIS').AsString,
                         qryQtdIte.FieldByName('QTDITE').AsFloat,
                         qryQtdIte.FieldByName('QTDCON').AsFloat,
                         qryQtdIte.FieldByName('SALDOS').AsFloat);
        End

      End
      Else
      Begin

        If blnCriticas Then
        Begin
          Result := False;
          pIncluiCritica(qryQtdIte.FieldByName('CODITE').AsString,
                         qryQtdIte.FieldByName('DESITE').AsString,
                         qryQtdIte.FieldByName('REFERE').AsString,
                         qryQtdIte.FieldByName('DESUNI').AsString,
                         qryQtdIte.FieldByName('CODFAB').AsString,
                         qryQtdIte.FieldByName('LOCFIS').AsString,
                         qryQtdIte.FieldByName('QTDITE').AsFloat,
                         0,
                         qryQtdIte.FieldByName('SALDOS').AsFloat);
        End
        Else If Not blnParcial And Not fCfgSis('PERCPA', varBoolean) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Item ' + qryQtdIte.FieldByName('CODBAR').AsString +
            ' não se encontra na conferência!', ['&O k'], 1, False, 1, 0, blnAutosize);
          Result := False;
          Break;
        End;

      End;

      qryQtdIte.Next;
    End;

    EnableControls;
  End;
End;

Function TConfereEntrada.fPedidoCompleto(blnCriticas: Boolean): Boolean;
  Var
    blnRes1,
    blnRes2: Boolean;
Begin
  Result := FALSE;

  If Not cdsConsulta.Active Then
    Exit;

  If Assigned(cdsCriticas) Then
  Begin
    cdsCriticas.EmptyDataSet;
    cdsCriticas.Filtered := FALSE;
  End;

  blnRes1 := fVerificaItensAmais(blnCriticas);

  blnRes2 := FALSE;

  If blnRes1 Or blnCriticas Then
    blnRes2 := fVerificaItensAMenos(blnCriticas);

  Result := blnRes1 And blnRes2;
End;

Function TConfereEntrada.fSetaPedido: Boolean;
  Var
    cdsAux    : TUniClientDataSet;
    stlAutIncs: TStringList;
    fltQtdIte : Double;
    fltQtdCon : Double;
    intCont   : Integer;

    function fRetAutIncSelecao(strCodIte: String): String;
      Var
        qryGen: TUniQuery;
        intContador: Integer;
    Begin
      qryGen := fCriaQuery;
      With qryGen, SQL Do
      Begin
        Clear;

        Add('SELECT ');
        Add('  GROUP_CONCAT(PCMDET.AUTOINCREM) AS AUTINC ');
        Add('FROM ');
        Add('  PCMDET ');
        Add('  JOIN PCMGER ON PCG_NUMPED = PCD_NUMPED AND ');
        Add('                 PCG_ESPDOC = PCD_ESPDOC AND ');
        Add('                 PCG_CODEMP = PCD_CODEMP     ');
        Add('WHERE');
        Add('  PCD_CODITE = :CODITE AND ');
        Add('  PCD_ESPDOC = "PD" AND ');

        Add('  PCD_NUMPED IN (' + stlPedidos.CommaText + ') AND ');

        Add('   (FALSE  ');

        For IntContador := 0 To stlPedidos.Count - 1 Do
          Add('  OR (PCG_NUMPED = ' + QuotedStr(stlPedidos[intContador]) + ' AND PCG_CODEMP = ' + QuotedStr(stlEmpresas[intContador]) + ') ');

        Add('   )  ');

        ParamByName('CODITE').AsString := strCodIte;

        Open;
        Result := FieldByName('AUTINC').AsString;
        Close;
      End;
      FreeAndNil(qryGen);
    End;

    function fSetToQuoted(strLista: String): String;
      Var
        stlAux: TStringList;
        intCon: Integer;
    Begin
      stlAux := TStringList.Create;
      stlAux.CommaText := strLista;

      For intCon := 0 To stlAux.Count-1 Do
        stlAux[intCon] := QuotedStr(stlAux[intCon]);

      Result := stlAux.CommaText;
      FreeAndNil(stlAux);
    End;

    function fAtualiza(strAutInc: String): Boolean;
      Var
        qryGen: TUniQuery;
    Begin
      qryGen := fCriaQuery;
      With qryGen, SQL Do
      Begin
        Clear;

        Add('UPDATE PCMGER, PCMDET ');
        Add('SET');
        Add(' PCG_DTALIB = :DTALIB,');
        Add(' PCG_HORLIB = :HORLIB,');
        Add(' PCG_OPELIB = :OPELIB,');
        Add(' PCG_LIBERA = 1 ');
        Add('WHERE');
        Add('  PCG_NUMPED = PCD_NUMPED AND ');
        Add('  PCG_ESPDOC = PCD_ESPDOC AND ');
        Add('  PCG_CODEMP = PCD_CODEMP AND ');
        Add('  PCMDET.AUTOINCREM = :AUTINC ');

        ParamByName('AUTINC').AsString := strAutInc;
        ParamByName('DTALIB').AsDate   := VS_Date;
        ParamByName('HORLIB').AsTime   := fTime();
        ParamByName('OPELIB').AsString := strLoginUsuarioLogado;

        ExecSQL;
      End;
      FreeAndNil(qryGen);

      Result := True;
    End;

Begin
  Try
    stlAutIncs  := TStringList.Create;
    cdsAux      := TUniClientDataSet.Create(Nil);
    cdsAux.Data := cdsConsulta.Data;

    cdsAux.First;
    While Not cdsAux.Eof Do
    Begin

      fltQtdIte := 0;
      stlAutIncs.Clear;
      stlAutIncs.CommaText := fRetAutIncSelecao(cdsAux.FieldByName('ITE_CODITE').AsString);

      For intCont := 0 To stlAutIncs.Count-1 Do
      Begin
        fltQtdCon := fRetQtdCon(stlAutIncs[intCont], fltQtdIte, True);

        If fFormataFloat(fltQtdCon,2) >= 0 Then
          fAtualiza(stlAutIncs[intCont]);
      End;

      cdsAux.Next;
    End;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fSetaPedido]');
    End;
  End;
End;

Function TConfereEntrada.fGravaLibArm(blnLiberaPedido: Boolean): Boolean;
Begin
  cdsConsulta.DisableControls;
  Result := FALSE;
  Try

    fStartTransaction;

    If ((Not blnLiberaPedido) Or fSetaPedido) Then
    Begin
      //Grava Ocorrência CRM
      Result := objEmbala.fConverteItensConferencia And fCommit;

      If Not Result Then
        fRollBack;

      If fValidarImpressaoLiberacaoArmazenamento Then
        pImprimirLiberacaoArmazenamento;

      cdsConsulta.Close;
    End Else
    Begin

      fRollBack;
      fMensagem('ATENÇÃO!', 'Erro de Gravação. Os registros não foram atualizados!', ['&Ok'],
                1, False, 1, 0, blnAutosize);
    End;

  Except

    On E: Exception Do
    Begin
      Result := FALSE;
      fRollBack;
      pMensagensErro(E.Message, '[pGravaLibArm]');
    End;

  End;

  cdsConsulta.EnableControls;
End;

Function TConfereEntrada.fFinalizaPedido: Boolean;
Begin
  Result := FALSE;

  If fPedidoCompleto(FALSE) Then
  Begin

    If fGravaLibArm(TRUE) Then
    Begin
      Result := TRUE;
      fMensagem('ATENÇÃO!', 'Pedido(s) finalizado(s) com sucesso!', ['&Ok'],
                 1, False, 1, 0, blnAutosize);
      edtNumPed.Enabled := True;
      pSetFocus(edtNumPed);
      stlPedidos.Clear;
      stlEmpresas.Clear;
      strCodFor := '';
      Exit;
    End;

  End

  Else If fCfgSis('PERCPA', varBoolean) Then
  Begin
    edtNumPed.Enabled := True;
    pSetFocus(edtNumPed);
  End;

End;

procedure TConfereEntrada.pConfirma(blnSolicitaRefugo : Boolean);
  Var
    blnRefugo : Boolean;
    strCodOpe,
    strSenha: String;
begin

  If (fMensagem('', 'Confirma a finalização da conferência?', ['&Sim', '&Não'],
                1, False, 1, 0, blnAutosize) = 1) Then
  Begin
    If blnSolicitaRefugo Then
    Begin
      If fMensagem('', 'Pedido referente a garantia, retorno de fornecedor, deseja informar refugo?', ['&Sim', '&Não']) = 1 Then
      Begin
        Repeat
          blnRefugo := TfrmEntConferenciaGarantiaDigRefugo.fDigitaRefugos(stlPedidos);
          If not blnRefugo Then
            blnRefugo := fMensagem('','Deseja continuar sem digitar o refugo?', ['&Sim', '&Não'], 2) = 1;
        Until blnRefugo;
      End;

    End;

    If fVerificaSeParcial Then
    Begin

      fMensagem('', 'Existem itens não conferidos!', ['&O k'], 1, False, 1, 0, blnAutosize);

      If Not fCfgSis('PERCPA', varBoolean) Then
        Exit;

      If (fMensagem('', 'Pedido Parcial?', ['&Sim', '&Não'], 1, False, 1, 0, blnAutosize) = 1) Then
      Begin

        If (Not fVerificaAcessoSistema('CONMEP', strLoginUsuarioLogado)) Then
        Begin
          ffrmSenha(strSenha, 'Senha por direito de acesso!');
          strCodOpe := fRetCodVendedor(strSenha);

          If (Not fVerificaAcessoSistema('CONMEP', strCodOpe)) Or fEmptyStr(strCodOpe) Then
          Begin
            fMensagem('', 'Usuario sem permissão de acesso!', ['&O k'], 1, False, 1, 0, blnAutosize);
            Exit;
          End;
        End;

        If Not objEmbala.fVerificaEmbalagensConferencia(stlPedidos, stlEmpresas) Then
          Exit;

        blnParcial := True;
      End
      Else
        Exit;
    End;

    fFinalizaPedido;
  End;
end;

function TConfereEntrada.fRetAutIncPed(strNumPed: String): String;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;

  With qryAux, SQL Do
  Begin
    Add('       SELECT AUTOINCREM ');
    Add('             FROM PCMGER ');
    Add('                   WHERE ');
    Add('  PCG_NUMPED   = :NUMPED ');
    Add('AND PCG_ESPDOC = :ESPDOC ');
    Add('AND PCG_CODEMP = :CODEMP ');

    ParamByName('NUMPED').AsString := strNumPed;
    ParamByName('ESPDOC').AsString := 'PD';
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    Result := FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(qryAux);

end;

function TConfereEntrada.fRetQtdBai(strAutInc: String;
  var fltQtdBai: Double): Double;
  Var
    qryIns: TUniQuery;
    sltAutInc: TStringList;
    strLista: String;
    intIndice: Integer;
Begin
  sltAutInc := TStringList.Create;
  sltAutInc.CommaText := strAutInc;

  strLista := '';

  For intIndice := 0 To sltAutInc.Count - 1 Do
  Begin
    strLista := strLista + QuotedStr(sltAutInc[intIndice]);
    If intIndice <> sltAutInc.Count - 1 Then
      strLista := strLista + ',';
  End;

  qryIns := fCriaQuery;
  With qryIns, SQL Do
  Begin
    Clear;
    Add('SELECT');

    If fCfgSis('CNVEMB') <> 'N' Then
      Add('  PCD_QTDBAI * IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA) AS PCD_QTDBAI')

    Else
      Add('  PCD_QTDBAI');

    Add('FROM PCMDET D');

    Add('WHERE');
    Add('  D.AUTOINCREM IN (' + strLista + ')');

    Open;

    If Not IsEmpty Then
      Result := FieldByName('PCD_QTDBAI').AsFloat
    Else
      Result := 0;
  End;
  FreeAndNil(qryIns);
end;

function TConfereEntrada.fQtdItemOk(strCodIte: String; fltQtdIte: Double; Var strAutInc: String): Boolean;
  Var
    fltQtdBai: Double;
    strDesIte: String;
    strCodRef: String;
    strCodBar: String;
    strRefere: String;
    strCodUni: String;
    strCodFab: String;
    strLocFis: String;
    strLocSup: String;
    strFicIns: String;
    strAplica: String;
    fltEmbala: Double;
Begin
  With qryQtdIte Do
  Begin
    Result := True;

    If Locate('CODITE', strCodIte, []) Then
    Begin

      strAutInc := FieldByName('AUTINC').AsString;

      If (FieldByName('QTDITE').AsFloat < (fltQtdIte + fRetQtdBai(strAutInc, fltQtdBai))) Then
      Begin
        pMensagemSonora('O Item ' + strCodIte + ' ultrapassou a quantidade do(s) pedido(s)!', blnAutosize);
        Result := False;
      End;

    End
    Else
    Begin
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
                        strCtlEst,
                        fltEmbala);
      pMensagemSonora('O Item ' + strCodBar + ' não se encontra no pedido!', blnAutosize);
      Result := False;
    End;

  End;
End;

Function TConfereEntrada.fAddItem(    strAutInc: String;
                                      fltQtdUni, fltQtdEmb: Double;
                                  Var fltQtdIte: Double;
                                  Var strAutPcc: String): Boolean;
  Var
    qryIns: TUniQuery;
    fltQtdDisp: Double;
Begin
  qryIns := fCriaQuery;
  With qryIns, SQL Do
  Begin

    fltQtdDisp := fRetQtdNaoContados(strAutInc);

    If fltQtdDisp > 0 Then
    Begin
      Clear;
      Add('UPDATE PCMDET D');

      Add('SET');

      Add('  PCD_QTDCON = IF(ROUND(PCD_QTDCON + :QTDCON, ' + fCfgSis('DEQTPC') + ') ');

      If fCfgSis('CNVEMB') <> 'N' Then
      Begin
        Add('     > ROUND((PCD_QTDITE - PCD_QTDBAI) * IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA), ' + fCfgSis('DEQTPC') + '),      ');
        Add('      (PCD_QTDITE - PCD_QTDBAI) * IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA), PCD_QTDCON + :QTDCON)                   ');
      End

      Else
      Begin
        Add('     > ROUND((PCD_QTDITE - PCD_QTDBAI), ' + fCfgSis('DEQTPC') + '),      ');
        Add('      (PCD_QTDITE - PCD_QTDBAI), PCD_QTDCON + :QTDCON)                   ');
      End;

      Add('WHERE');
      Add('  D.AUTOINCREM = :AUTINC');

      ParamByName('AUTINC').AsString := strAutInc;
      ParamByName('QTDCON').AsFloat  := fltQtdIte;
      ExecSQL;

      If fEmptyStr(strAutPcc) Then
      Begin
        strAutPcc := fRetAutoIncrem('PCMCON', VS_strCodEmp);

        Clear;
        Add('INSERT INTO PCMCON');
        Add('(PCC_QTDUNI, PCC_QTDEMB, AUTOINCREM) VALUES');
        Add('(:QTDUNI, :QTDEMB, :AUTPCC)');

        ParamByName('QTDUNI').AsFloat  := fltQtdUni;
        ParamByName('QTDEMB').AsFloat  := fltQtdEmb;
        ParamByName('AUTPCC').AsString := strAutPcc;
        ExecSQL;
        Close;
      End;

      Clear;
      Add('INSERT INTO PCDCON');
      Add('(CON_QTDITE, CON_SEQDET, CON_SEQGER) VALUES');
      Add('(:QTDITE, :SEQDET, :SEQGER)');

      If fltQtdDisp > fltQtdIte Then
        ParamByName('QTDITE').AsFloat  := fltQtdIte
      Else
        ParamByName('QTDITE').AsFloat  := fltQtdDisp;

      ParamByName('SEQDET').AsString := strAutInc;
      ParamByName('SEQGER').AsString := strAutPcc;

      ExecSQL;
      Close;

      If RoundTo(fltQtdDisp, -2) >= RoundTo(fltQtdIte, -2) Then
        fltQtdIte := 0
      Else
        fltQtdIte := fltQtdIte - fltQtdDisp;

    End;

  End;

  Result := True;
  FreeAndNil(qryIns);
End;

Function TConfereEntrada.fSomaItem(fltQtdIte, fltQtdUni, fltQtdEmb: Double): Boolean;
  Var
    strAutInc: String;
    fltQtdContada: Double;
Begin
  Result := FALSE;

  With cdsConsulta Do
  Begin
    If blnSintetico Then
      fltQtdContada := FieldByName('ITE_QTDCON').AsFloat
    Else
      fltQtdContada := fRetQtdContada(FieldByName('ITE_CODITE').AsString);

    If Not fQtdItemOk(FieldByName('ITE_CODITE').AsString,
                      fltQtdContada + fltQtdIte, strAutInc) Then
      Exit;

    Try
      fStartTransaction;

      If fSetaItem(fltQtdIte, fltQtdUni, fltQtdEmb, strAutInc, '', fAddItem) Then
      Begin
        Edit;
        FieldByName('ITE_QTDCON').AsFloat := FieldByName('ITE_QTDCON').AsFloat + fltQtdIte;
        Post;
        Result := TRUE;
      End

      Else fRollBack;

      fCommit;

    Except

      On E: Exception Do
      Begin
        fRollBack;
        Result := FALSE;
        pMensagensErro(E.Message, '[fSomaItem]');
      End;

    End;

  End;
End;

Function TConfereEntrada.fIncluiItem(strCodIte: String; fltQtdIte, fltQtdUni, fltQtdEmb: Double): Boolean;
  Var
    strDesIte,
    strCodRef,
    strCodBar,
    strRefere,
    strCodUni,
    strAutInc,
    strCodFab,
    strLocFis,
    strLocSup,
    strFicIns,
    strAplica: String;
    fltEmbala,
    fltQtdContada: Double;
Begin
  Result := FALSE;

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
                    strCtlEst,
                    fltEmbala,
                    Length(strCodIte) > intTamCod);

  If fEmptyStr(strDesIte) And (Length(strCodIte) > intTamCod) Then
  Begin
    pRetProdutoSimilar(strCodIte,
                       strCodRef,
                       strDesIte,
                       strRefere,
                       strCodUni,
                       strCodFab,
                       strLocFis,
                       strLocSup,
                       strFicIns,
                       strAplica,
                       strCtlEst,
                       fltEmbala);

    If Not fEmptyStr(strDesIte) Then
      strCodBar := strCodIte;
  End;

  If fEmptyStr(strDesIte) Then
    pMensagemSonora('Item ' + strCodIte + ' não encontrado!', blnAutosize)

  Else
  With cdsConsulta Do
  Begin
    If blnSintetico Then
      fltQtdContada := 0
    Else
      fltQtdContada := fRetQtdContada(strCodIte);

    If Not fQtdItemOk(strCodRef, fltQtdContada + fltQtdIte, strAutInc) Then
      Exit;

    cdsConsulta.Tag := 1;

    Try
      fStartTransaction;

      If fSetaItem(fltQtdIte, fltQtdUni, fltQtdEmb, strAutInc, '', fAddItem) Then
      Begin
        cdsConsulta.Insert;

        FieldByName('AUTOINCREM').AsString   := strAutInc;
        FieldByName('ITE_CODITE').AsString   := strCodRef;
        FieldByName('ITE_QTDCON').AsFloat    := fltQtdIte;
        FieldByName('ITE_QTDUNI').AsFloat    := fltQtdUni;
        FieldByName('ITE_QTDEMB').AsFloat    := fltQtdEmb;
        FieldByName('ITE_EMBALA').AsFloat    := fltEmbala;
        FieldByName('ITE_CODBAR').AsString   := IIF(fEmptyStr(strCodBar), '-', strCodBar);
        FieldByName('ITE_DESITE').AsString   := IIF(fEmptyStr(strDesIte), '-', strDesIte);
        FieldByName('ITE_REFERE').AsString   := IIF(fEmptyStr(strRefere), '-', strRefere);
        FieldByName('ITE_DESUNI').AsString   := IIF(fEmptyStr(fRetSiglaUnidade(strCodUni)), '-', fRetSiglaUnidade(strCodUni));
        FieldByName('ITE_CODFAB').AsString   := IIF(fEmptyStr(strCodFab), '-', strCodFab);
        FieldByName('ITE_LOCFIS').AsString   := IIF(fEmptyStr(strLocFis), '-', strLocFis);
        FieldByName('ITE_FICINS').AsString   := strFicIns;

        If Fields.FindField('ITE_LOCSUP') <> Nil Then
          FieldByName('ITE_LOCSUP').AsString   := IIF(fEmptyStr(strLocSup), '-', strLocSup);

        Post;

        AfterScroll(cdsConsulta);
        dbgConsulta.Repaint;
      End

      Else fRollBack;

      fCommit;

      Result := TRUE;

    Except

      On E: Exception Do
      Begin
        fRollBack;
        Result := FALSE;
        pMensagensErro(E.Message, '[fIncluiItem]');
      End;

    End;

    cdsConsulta.Tag := 0;

  End;

End;

procedure TConfereEntrada.pInsereItemEtiqueta(intQtdEti: Integer; strBarDig: String);
Begin
  With cdsImpEtiIte Do
  Begin
    EmptyDataSet;

    Insert;
    FieldByName('NOMEMP').AsString := fRetNomeEmpresa;
    FieldByName('CODITE').AsString := cdsConsulta.FieldByName('ITE_CODITE').AsString;
    FieldByName('DESITE').AsString := cdsConsulta.FieldByName('ITE_DESITE').AsString;
    FieldByName('CODBAR').AsString := strBarDig;
    FieldByName('REFERE').AsString := cdsConsulta.FieldByName('ITE_REFERE').AsString;
    FieldByName('SIGUNI').AsString := cdsConsulta.FieldByName('ITE_DESUNI').AsString;
    FieldByName('CODFAB').AsString := cdsConsulta.FieldByName('ITE_CODFAB').AsString;
    FieldByName('LOCFIS').AsString := cdsConsulta.FieldByName('ITE_LOCFIS').AsString;
    Post;
  End;
End;

procedure TConfereEntrada.pImprimeEtiqueta(intQtdIte: Integer; strBarDig: String);
  Var
    intIndice: Integer;
Begin
  pInsereItemEtiqueta(intQtdIte, strBarDig);

  If Assigned(prmDllEtq) Then
    For intIndice := 1 To intQtdIte Do
      fImprimeEtiqueta(prmDllEtq, 'fImprimeEtiquetaGeral');
End;

Function TConfereEntrada.fRegistraItem(blnCodBar, blnCodFab: Boolean;
  edtCodIte, edtQtdIte, edtQtdEti: TEditFocus; blnSemelhante: Boolean;
  Var blnCodBarNaoEcontrado: Boolean): Boolean;

  Var
    strCamBus,
    strCodIte,
    strCodBar,
    strCodIteUni, strCodGruUni: String;
    qryConIte: TUniQuery;
    qryUpdate: TUniQuery;
    blnBuscaCodBar: Boolean;
    fltEmbala,
    fltTotal,
    fltQtdIteUni: Double;

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
              pMensagensErro(E.Message, '[TfrmEntConferencia.fRegistraItem]');
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

  qryConIte := fCriaQuery;
  qryUpdate := fCriaQuery;

  strCamBus := 'ITE_CODFAB';
  blnBuscaCodBar := False;

  If blnCodBar Then
  Begin

    If (Length(edtCodIte.Text) > intTamCod) or blnBarCen  Then
    Begin
      strCamBus := 'ITE_CODBAR';
      blnBuscaCodBar := True;
    End
    Else
    Begin
      strCamBus := 'ITE_CODITE';
      edtCodIte.Text := fStrZero(edtCodIte.Text, intTamCod);
    End;


  End;
  strCodIte := edtCodIte.Text;

  With cdsConsulta Do
  Begin

    pPesquisaItem;

    If (qryConIte.RecordCount = 0) And blnEtiDif And
       objIteBar.fLerCodigoBarrasUnidades(edtCodIte.Text, strCodIteUni, strCodGruUni, fltQtdIteUni) Then
    Begin

      strCodIte      := strCodIteUni;
      edtCodIte.Text := strCodIteUni;
      edtQtdIte.Text := FloatToStrF(fltQtdIteUni, ffFixed, 12, 2);
      pPesquisaCadIteSemSemelhante(Nil, qryConIte, edtCodIte.Text, False, False);
      fltEmbala := 1;

    End

    Else If (qryConIte.RecordCount = 0) And
         objIteBar.fLerCodigoFabricaMaiorFornecedor(edtCodIte.Text, strCodIteUni, fltQtdIteUni) Then
    Begin

      strCodIte      := strCodIteUni;
      edtCodIte.Text := strCodIteUni;
      edtQtdIte.Text := FloatToStrF(fltQtdIteUni, ffFixed, 12, 2);

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

    If qryConIte.RecordCount > 0 Then
    Begin
      strCodIte := qryConIte.FieldByName('ITE_CODITE').AsString;
      strCamBus := 'ITE_CODITE';

      If blnSintetico And Locate(strCamBus,strCodIte,[]) Then
        Result := fSomaItem(fltTotal, fStrToFloat(edtQtdIte.Text), fltEmbala)
      Else
        Result := fIncluiItem(strCodIte, fltTotal, fStrToFloat(edtQtdIte.Text), fltEmbala);

      If Result Then
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
            End;

          End;

        End;
      End;

      If Result And Assigned(edtQtdEti) And (edtQtdEti.Visible) Then
        pImprimeEtiqueta(StrToIntDef(edtQtdEti.Text,0),
           IIF(blnBuscaCodBar And (qryConIte.FieldByName('BAR_EMBALA').AsFloat > 0),
                qryConIte.FieldByName('BAR_CODBAR').AsString,
                qryConIte.FieldByName('ITE_CODBAR').AsString));

    End
    Else
    Begin
      pMensagemSonora('Item ' + edtCodIte.Text + ' não existe!', blnAutosize);

      blnCodBarNaoEcontrado := blnCodBar And (Length(edtCodIte.Text) > intTamCod);

    End;
  End;

  edtCodIte.Clear;

  edtQtdIte.Text := FormatFloat(fMskDigitos(intDeqTpc), 1);
  If Assigned(edtQtdEti) Then
    edtQtdEti.Text := fCfgSis('ETICEM');

  FreeAndNil(qryConIte);
  FreeAndNil(qryUpdate);
end;

Function TConfereEntrada.fValidaPedido(strNumPed: String; edtLisPed: TEditFocus): Boolean;
  Var
    blnBonificacao,
    blnLiberado,
    blnConferido,
    blnBaixado,
    blnOriundo,
    blnImportado,
    blnMaisDeUm,
    blnOriundoImportacaoNotaEletronica: Boolean;
    strEmpDes,
    strEmpres,
    strPreNot,
    strAutInc: String;
Begin
  Result := True;

  If Not fEmptyStr(strNumPed) Then
  Begin

    If Not fPedidoCompraCadastrado(strNumPed, VS_strCodEmp, 'PD', blnBonificacao, blnLiberado, blnConferido,
      blnBaixado, blnOriundo, blnImportado, blnMaisDeUm, strEmpDes, strEmpres, strCodFor, strPreNot, strAutInc, blnOriundoImportacaoNotaEletronica) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse Pedido não está cadastrado!', ['&O k'], 1, False, 1, 0, blnAutosize);
      Result := FALSE;
    End;

    If blnConferido Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse Pedido já foi conferido!', ['&O k'], 1, False, 1, 0, blnAutosize);
      Result := FALSE;
    End

    Else If blnBaixado Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse Pedido já está baixado!', ['&O k'], 1, False, 1, 0, blnAutosize);
      Result := FALSE;
    End

    Else If Not fEmptyStr(strPreNot) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse Pedido já está associado à Nota Eletrônica ' + strPreNot  + ' !', ['&O k'], 1, False, 1, 0{, blnAutosize});
      Result := FALSE;
    End
    
    Else If Not fLock_Unlock('PEDCOMPD' + edtNumPed.Text +  VS_strCodEmp, True, False, TRUE) Then
    Begin
      Result := FALSE;
      fMensagem('', 'Esse Documento está sendo utilizado em outra Estação por ' +
                 fGetHostLock('PEDCOMPD' + strNumPed+  VS_strCodEmp)  + '!', ['&Ok'],
                 1, False, 1, 0, blnAutosize);
    End

    Else If (fCfgSis('LIBPCM', varBoolean)) And (Not blnLiberado) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse Pedido ainda não foi liberado (Liberação de Pedidos de Compra)!',
                ['&O k'], 1, False, 1, 0, blnAutosize);
      Result := FALSE;
    End

    Else
    Begin
      edtLisPed.Visible := False;
      edtLisPed.Clear;
    End;

  End

  Else If stlPedidos.Count = 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhum pedido selecionado!', ['&O k'], 1, False, 1, 0, blnAutosize);
    Result := FALSE;
  End

  Else If Not fListaLiberada(stlPedidos, stlEmpresas) Then
  Begin
    Result := FALSE;
  End;

  If Result And (stlPedidos.Count = 0) Then
  Begin
    stlPedidos.Add(strNumPed);
    stlEmpresas.Clear;
    stlEmpresas.Add(strEmpres);
  End;

  If stlPedidos.Count = 0 Then
    strCodFor := '';  
End;

Function TConfereEntrada.fValidaQuantidade(edtQtdIte: TEditFocus): Boolean;
Begin
  Result := True;

  If (fEmptyStr(edtQtdIte.Text)) Then
  Begin
    pMensagemSonora('A quantidade deve ser preenchida!', blnAutosize);
    Result := False;
  End
  Else If (fStrToFloat(edtQtdIte.Text) <= 0.0) Then
  Begin
    pMensagemSonora('A quantidade deve ser maior que zero!', blnAutosize);
    Result := False;
  End
End;

function TConfereEntrada.fSQLNotasPedido: String;
Var
  strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT GROUP_CONCAT(B08_NNF) FROM GERELE G ';
  strSQL := strSQL + ' INNER JOIN PEDELE ON PEL_SEQELE = G.AUTOINCREM ';
  strSQL := strSQL + ' WHERE                                     ';
  strSQL := strSQL + '   GER_DOCENT IS NULL                      ';
  strSQL := strSQL + '   AND PEL_NUMDOC =   PCG_NUMPED           ';
  strSQL := strSQL + '   AND PEL_ESPDOC =   PCG_ESPDOC           ';
  strSQL := strSQL + '   AND PEL_CODEMP =   PCG_CODEMP           ';

  Result := strSQL;
End;

function TConfereEntrada.fSQLFonecedorNota: String;
Var
  strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT GROUP_CONCAT(DISTINCT GER_CODFOR) FROM GERELE G ';
  strSQL := strSQL + ' INNER JOIN PEDELE ON PEL_SEQELE = G.AUTOINCREM         ';
  strSQL := strSQL + ' WHERE                                     ';
  strSQL := strSQL + '   GER_DOCENT IS NULL                      ';
  strSQL := strSQL + '   AND PEL_NUMDOC =   PCG_NUMPED           ';
  strSQL := strSQL + '   AND PEL_ESPDOC =   PCG_ESPDOC           ';
  strSQL := strSQL + '   AND PEL_CODEMP =   PCG_CODEMP           ';

  Result := strSQL;
End;

function TConfereEntrada.fSqlSelecPedidos(blnLike, blnPreNota: Boolean): String;
Var
  strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  PCG_NUMPED, ';
  strSQL := strSQL + '  PCG_INDCON, ';
  strSQL := strSQL + '  PCG_INHCON, ';
  strSQL := strSQL + '  PCG_ESPDOC, ';
  strSQL := strSQL + '  PCG_CODEMP, ';
  strSQL := strSQL + '  PCG_CODFOR, ';
  strSQL := strSQL + '  FOR_NOMFOR, ';
  strSQL := strSQL + '  PCG_DTAPED, ';
  strSQL := strSQL + '  PCG_DTAENT, ';
  strSQL := strSQL + '  PCG_CONPAG, ';
  strSQL := strSQL + '  PCG_TOTITE, ';
  strSQL := strSQL + '  PCG_TOTIPI, ';
  strSQL := strSQL + '  PCG_TOTGER, ';
  strSQL := strSQL + '  PCG_DOCORI, ';
  strSQL := strSQL + '  PCG_MOEDA_, ';
  strSQL := strSQL + '  CONCAT(PCG_NUMPED,"-",PCG_CODEMP) AS NUMPEDCODEMP, ';

  strSQL := strSQL + '  IF(PCG_MOEDA_ = 1, "Sim", "Não") AS EM_DOLAR, ';

  If blnPreNota Then
  Begin
    strSQL := strSQL + ' CAST((' + fSQLNotasPedido + ')   AS CHAR(100)) AS PRE_NOTAS,         ';
    strSQL := strSQL + ' CAST((' + fSQLFonecedorNota + ') AS CHAR(100)) AS FORNEC_PRE_NOTAS,  ';
  End Else
  Begin
    strSQL := strSQL + ' (NULL) AS PRE_NOTAS,         ';
    strSQL := strSQL + ' (NULL) AS FORNEC_PRE_NOTAS,  ';
  End;

  strSQL := strSQL + '  ( SELECT IF(GROUP_CONCAT( DISTINCT PCD_DOCORI) IS NULL, "N", "S") ';
  strSQL := strSQL + '    FROM PCMDET                                                     ';
  strSQL := strSQL + '    INNER JOIN MOVGAE ON SUBSTRING(PCD_DOCORI,1,12) = GAE_NUMENV    ';
  strSQL := strSQL + '                     AND SUBSTRING(PCD_DOCORI,13,2) = GAE_ESPENV    ';
  strSQL := strSQL + '                     AND PCD_CODEMP = GAE_EMPENV                    ';
  strSQL := strSQL + '    WHERE PCG_NUMPED = PCD_NUMPED                                   ';
  strSQL := strSQL + '      AND PCG_CODEMP = PCD_CODEMP                                   ';
  strSQL := strSQL + '      AND PCG_ESPDOC = PCD_ESPDOC ) AS PEDGAR,                      ';

  strSQL := strSQL + '  PCMGER.AUTOINCREM, ';

  strSQL := strSQL + '  IF(PCG_DTALIB IS NULL,"N","S") AS CONFER ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PCMGER ';
  strSQL := strSQL + 'INNER JOIN CADFOR ON FOR_CODFOR = PCG_CODFOR ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PCG_ESPDOC = "PD" ';

  If Not blnPreNota Then
    strSQL := strSQL + '  AND PCG_DTALIB IS NULL ';

  strSQL := strSQL + '  AND PCG_NUMCTN = 0 ';
  strSQL := strSQL + '  AND (PCG_BAIXAD <> 1 OR PCG_BAIXAD IS NULL) ';
  strSQL := strSQL + '  AND IF(IFNULL(PCG_EMPDES, "") = "", PCG_CODEMP = ' + QuotedStr(VS_strCodEmp) + ', PCG_EMPDES = ' + QuotedStr(VS_strCodEmp) + ') ';

  If Not fEmptyStr(strCodFor) Then
  Begin
    strSQL := strSQL + '  AND ((PCG_CODFOR = ' + QuotedStr(strCodFor) + ') OR ';
    strSQL := strSQL + '      ((FOR_C_G_C_ LIKE ' +
     QuotedStr(LeftStr(fTiraCaracEspeciaisPonto(fCampoTabela('FOR_C_G_C_', 'CADFOR', ['FOR_CODFOR', 'FOR_CGCCPF'], [strCodFor, '1'])), 8) + '%') +
                               ') AND (NOT LOCATE(FOR_CODFOR, ' + QuotedStr(fRetForFilialTodos) + '))) )';
  End;

  If blnPreNota And fCfgSis('LIBPCM', varBoolean) Then
    strSQL := strSQL + ' AND IFNULL(PCG_PEDLIB, "") <> "" ';

  Result := strSQL;
End;

Function TConfereEntrada.fVeSeAtualizaPedidoCompraGeral(strNumPed, strCodEmp, strForEle, strForPed: String; blnSalvaFornecedor: Boolean): Boolean;
Begin
  { Se o fonecedor do pedido pertencer ao mesmo grupo da nota e não for filial então libera atualizar o pedido}
  Result := fFornecedoresMesmoGrupo(strForEle, strForPed) And (Not fFornecedorFilial(strForPed));

  If Result Then
  Begin
    Case acoAcaoForDif Of
      acoPerguntar: Begin
                      Result := fPergunta('Os fornecedores do XML e do Pedido de Compra são diferentes, porém seus CNPJ''s são do mesmo grupo de empresas. ' +
                                           'Será possivel trocar o fornecedor do pedido automaticamente. Deseja prosseguir?');

                      If blnMarcarTodos Then
                      Begin
                        If Result Then
                          acoAcaoForDif := acoLiberarTodos
                        Else
                          acoAcaoForDif := acoNaoLiberarTodos;
                      End;

                    End;

      acoLiberarTodos   : Result := True;

      acoNaoLiberarTodos: Result := False;
    End;

  End;

  If Result And blnSalvaFornecedor Then
    Result := fAtualizaFornecedorPedido(strNumPed, strCodEmp, strForEle);
End;

Function TConfereEntrada.fVeSeAtualizaPedidoCompraGrid(cdsPedidos: TUniClientDataSet; strNumPed, strCodEmp, strForEle, strForPed: String;
                                                       blnAtualizaFornecedor: Boolean): Boolean;
Begin
  Result := fVeSeAtualizaPedidoCompraGeral(strNumPed, strCodEmp, strForEle, strForPed, blnAtualizaFornecedor);

  If Result And blnAtualizaFornecedor Then
  With cdsPedidos Do
  Begin
    Edit;
    FieldByName('PCG_CODFOR').AsString := strForEle;
    If FindField('FOR_NOMFOR') <> Nil Then
      FieldByName('FOR_NOMFOR').AsString := fRetNomFornecedor(strForEle);
    Post;
  End;
End;

function TConfereEntrada.fValidaPedidoSelec(cdsPedidos: TUniClientDataSet;
                                            strForSel: String;
                                            blnAtualizaFornecedor: Boolean): Boolean;
  Var
    blnBonificacao,
    blnLiberado,
    blnConferido,
    blnOriundo,
    blnBaixado,
    blnImportado,
    blnMaisDeUm,
    blnOriundoImportacaoNotaEletronica: Boolean;
    strEmpDes,
    strEmpres,
    strCodForPes,
    strPreNot,
    strAutInc: String;
Begin
  Result := True;

  With cdsPedidos Do
  Begin

    If fEhPedidoCompraMultiLoja(FieldByName('PCG_NUMPED').AsString, 'PD', FieldByName('PCG_CODEMP').AsString) Then
    Begin
      If Not fCfgSis('PDCGTR', varBoolean) Then
      Begin

        pMensagemOk('Esse pedido de compra é multi-loja e deve ser desmembrado para utilização!');
        Result := False;
        Exit;
      End;
    End;

   (*
    If blnTravaJaAssociados And (Not fEmptyStr(strForSel)) And (Not SameText(strForSel, FieldByName('PCG_CODFOR').AsString)) And
       (FindField('FORNEC_PRE_NOTAS') <> Nil) And (Not FieldByName('FORNEC_PRE_NOTAS').IsNull) Then
    Begin
      pMensagemOk('Esse pedido já está associado com a(s) nota(s) ' + FieldByName('PRE_NOTAS').AsString + #13#10 +
                  'do fornecedor ' + FieldByName('FORNEC_PRE_NOTAS').AsString + ' - ' + fRetNomFornecedor(FieldByName('FORNEC_PRE_NOTAS').AsString) + #13#10 +
                  'e somente poderá ser utilizado após a entrada de mercadorias das notas listadas!');
      Result := False;
      Exit;
    End; *)

    If (Not fEmptyStr(strForSel)) And (Not SameText(strForSel, FieldByName('PCG_CODFOR').AsString)) And
       (Not fVeSeAtualizaPedidoCompraGrid(cdsPedidos,
                                          FieldByName('PCG_NUMPED').AsString,
                                          FieldByName('PCG_CODEMP').AsString,
                                          strForSel,
                                          FieldByName('PCG_CODFOR').AsString,
                                          blnAtualizaFornecedor)) Then
    Begin
      If acoAcaoForDif = acoPerguntar Then
        fMensagem('','Selecione pedidos de mesmo fornecedor!', ['&Ok']);
      If acoAcaoForDif <> acoLiberarTodos Then
        Result := False;
    End

    Else If Not fPedidoCompraCadastrado(FieldByName('PCG_NUMPED').AsString, FieldByName('PCG_CODEMP').AsString, 'PD', blnBonificacao, blnLiberado,
      blnConferido, blnBaixado, blnOriundo, blnImportado, blnMaisDeUm,
      strEmpDes, strEmpres, strCodForPes, strPreNot, strAutInc, blnOriundoImportacaoNotaEletronica, False) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse Pedido não está cadastrado!', ['&O k']);
      Result := False;
    End

    Else If blnConferido Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse pedido já foi conferido!', ['&O k']);

      Result := False;
    End;

  End;
End;

Function TConfereEntrada.fPreparaBaixaPedidos: Boolean;
Begin
  Result := fCarregaItensConferidos And fCarregaPcmdetConferido;
End;

(*
Procedure TConfereEntrada.pCopiaArray(Var arrDestino: TArrString; arrOrigem: Array of String);
  Var
    intIndice: Integer;
Begin
  SetLength(arrDestino, Length(arrOrigem));
  For intIndice := Low(arrOrigem) To High(arrOrigem) Do
    arrDestino[intIndice] := arrOrigem[intIndice];
End;
*)

Function TConfereEntrada.fCarregaItensConferidos: Boolean;
  Var
    strSQL: String;
    intContador: Integer;
Begin
  Result := True;

  If Not Assigned(FPcmcon) Then
    Exit;

  strSQL := '';
  strSQL := strSQL + ' SELECT DISTINCT         ';
  strSQL := strSQL + '   N.*,                  ';
  strSQL := strSQL + '   PCD_CODITE AS CODITE, ';
  strSQL := strSQL + '   0.0000 AS BAIXAD      ';
  strSQL := strSQL + ' FROM        ';
  strSQL := strSQL + '  PCMGER PG  ';
  strSQL := strSQL + '  INNER JOIN PCMDET P ';
  strSQL := strSQL + '     ON  PG.PCG_NUMPED = P.PCD_NUMPED ';
  strSQL := strSQL + '     AND PG.PCG_CODEMP = P.PCD_CODEMP ';
  strSQL := strSQL + '     AND PG.PCG_ESPDOC = P.PCD_ESPDOC ';
  strSQL := strSQL + '     AND PG.PCG_NUMCTN = P.PCD_NUMCTN ';

  strSQL := strSQL + ' INNER JOIN PCDCON D ON P.AUTOINCREM = D.CON_SEQDET ';
  strSQL := strSQL + ' INNER JOIN PCMCON N ON N.AUTOINCREM = D.CON_SEQGER ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   P.PCD_QTDCON > 0 AND ';
  strSQL := strSQL + '   P.PCD_NUMCTN = 0 AND ';
  strSQL := strSQL + '   P.PCD_ESPDOC = "PD" AND ';

  strSQL := strSQL + ' ( ';
  For intContador := Low(FPedidos) To High(FPedidos) Do
  Begin
    strSQL := strSQL + ' ( ';
    strSQL := strSQL + ' PG.PCG_NUMPED = ' + QuotedStr(FPedidos[intContador]) + ' AND ';
    strSQL := strSQL + ' PG.PCG_CODEMP = ' + QuotedStr(FEmpresas[intContador]);
    strSQL := strSQL + ' ) ';

    If intContador <> High(FPedidos) Then
      strSQL := strSQL + ' OR ';
  End;
  strSQL := strSQL + ' ) ';

  With FPcmcon Do
  Begin
    qryQuery.SQL.Text := strSQL;
    Result := fAbreClient(True, 'TConfereEntrada.fCarregaItensConferidos');
  End;
End;

Function TConfereEntrada.fCarregaPcmdetConferido: Boolean;
  Var
    strSQL: String;
    intContador: Integer;
Begin
  Result := True;

  If Not Assigned(FPcmdet) Then
    Exit;

  strSQL := '';
  strSQL := strSQL + ' SELECT DISTINCT ';
  strSQL := strSQL + '   P.AUTOINCREM AS AUT_PCMDET, ';
  strSQL := strSQL + '   P.PCD_CODITE,               ';

  If fCfgSis('CNVEMB') <> 'N' Then
  Begin
    strSQL := strSQL + '   P.PCD_QTDITE * IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA) AS PCD_QTDITE, ';
    strSQL := strSQL + '   P.PCD_QTDBAI * IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA) AS PCD_QTDBAI, ';
  End

  Else
  Begin
    strSQL := strSQL + '   P.PCD_QTDITE AS PCD_QTDITE, ';
    strSQL := strSQL + '   P.PCD_QTDBAI AS PCD_QTDBAI, ';
  End;

  strSQL := strSQL + '   P.PCD_QTDCON,               ';
  strSQL := strSQL + '   P.PCD_UNITAR,               ';
  strSQL := strSQL + '   0.0000 AS BAIXAD,           ';
  strSQL := strSQL + '   0.0000 AS PERIPI,           ';
  strSQL := strSQL + '   0.0000 AS PERSUB            ';
  strSQL := strSQL + ' FROM        ';
  strSQL := strSQL + '  PCMGER PG  ';
  strSQL := strSQL + '  INNER JOIN PCMDET P ';
  strSQL := strSQL + '     ON  PG.PCG_NUMPED = P.PCD_NUMPED ';
  strSQL := strSQL + '     AND PG.PCG_CODEMP = P.PCD_CODEMP ';
  strSQL := strSQL + '     AND PG.PCG_ESPDOC = P.PCD_ESPDOC ';
  strSQL := strSQL + '     AND PG.PCG_NUMCTN = P.PCD_NUMCTN ';

  strSQL := strSQL + '  INNER JOIN PCDCON D ON P.AUTOINCREM = D.CON_SEQDET ';
  strSQL := strSQL + '  INNER JOIN PCMCON N ON N.AUTOINCREM = D.CON_SEQGER ';

  strSQL := strSQL + ' WHERE                 ';
  strSQL := strSQL + '  P.PCD_QTDCON > 0 AND ';
  strSQL := strSQL + '  P.PCD_NUMCTN = 0 AND ';
  strSQL := strSQL + '  (P.PCD_BAIXAD = FALSE OR P.PCD_BAIXAD IS NULL) AND ';
  strSQL := strSQL + '  P.PCD_ESPDOC = "PD" AND ';

  strSQL := strSQL + ' ( ';
  For intContador := Low(FPedidos) To High(FPedidos) Do
  Begin
    strSQL := strSQL + ' ( ';
    strSQL := strSQL + ' PG.PCG_NUMPED = ' + QuotedStr(FPedidos[intContador]) + ' AND ';
    strSQL := strSQL + ' PG.PCG_CODEMP = ' + QuotedStr(FEmpresas[intContador]);
    strSQL := strSQL + ' ) ';

    If intContador <> High(FPedidos) Then
      strSQL := strSQL + ' OR ';
  End;
  strSQL := strSQL + ' ) ';

  With FPcmdet Do
  Begin
    qryQuery.SQL.Text := strSQL;
    Result := fAbreClient(True, 'TConfereEntrada.fCarregaPcmdetConferido');
  End;
End;

Function TConfereEntrada.fAtualizaDadosPcmDetSintetico(strCodIte: String;
                                                       fltQtdIte,
                                                       fltUnitar,
                                                       fltPerIpi,
                                                       fltPerSub,
                                                       fltEmbala: Double): Boolean;
  Var
    fltQtdEmb,
    fltDispon: Double;
Begin
  Result := True;
  
  If Not Assigned(FPcmcon) Then
    Exit;

  Try
    With FPcmCon Do
    Begin
      Filter   := 'CODITE = ' + QuotedStr(strCodIte);
      Filtered := True;
      First;

      fltQtdEmb := fltQtdIte;
      While (Not Eof) And (RoundTo(fltQtdEmb, -2) > 0) Do
      Begin

        If (RoundTo(FieldByName('PCC_QTDEMB').AsFloat, -2) = RoundTo(fltEmbala, -2)) And
           (RoundTo(FieldByName('PCC_QTDUNI').AsFloat, -2) > RoundTo(FieldByName('PCC_EMBBAI').AsFloat, -2)) Then
        Begin
          Edit;

          fltDispon := RoundTo(FieldByName('PCC_QTDUNI').AsFloat - FieldByName('PCC_EMBBAI').AsFloat, -2);
          If fltDispon >= RoundTo(fltQtdEmb, -2) Then
          Begin
            FieldByName('PCC_EMBBAI').AsFloat := FieldByName('PCC_EMBBAI').AsFloat + fltQtdEmb;
            FieldByName('BAIXAD').AsFloat     := FieldByName('BAIXAD').AsFloat + fltQtdEmb;
            pAtualizaPcmdets(fltQtdEmb * fltEmbala, fltUnitar, fltPerIpi, fltPerSub, strCodIte);
            fltQtdEmb := 0;
          End Else
          Begin
            FieldByName('PCC_EMBBAI').AsFloat := FieldByName('PCC_EMBBAI').AsFloat + fltDispon;
            FieldByName('BAIXAD').AsFloat     := FieldByName('BAIXAD').AsFloat + fltDispon;
            pAtualizaPcmdets(fltDispon * fltEmbala, fltUnitar, fltPerIpi, fltPerSub, strCodIte);
            fltQtdEmb := fltQtdEmb - fltDispon;
          End;

          Post;
        End;

        Next;
      End;
    End;

    Result := True;

  Except

    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[fAtualizaDadosPcmDetSintetico]');
      Result := False;
    End;

  End;
End;

Procedure TConfereEntrada.pAtualizaPcmdets(fltQtdIte, fltUnitar, fltPerIpi, fltPerSub: Double; strCodIte: String);
  Var
    intDecQtd: Integer;
    fltDispon: Double;
Begin
  If Not Assigned(FPcmdet) Then
    Exit;

  With FPcmdet Do
  Begin
    intDecQtd := fCfgSis('DEQTEM', varInteger);
    Filter    := 'PCD_CODITE = ' + QuotedStr(strCodIte);
    Filtered  := True;
    First;

    While (Not Eof) And (RoundTo(fltQtdIte, -intDecQtd) > 0) Do
    Begin
      fltDispon := RoundTo(FieldByName('PCD_QTDITE').AsFloat - FieldByName('PCD_QTDBAI').AsFloat, -intDecQtd);

      If fltDispon > 0 Then
      Begin
        Edit;

        If fltDispon > fltQtdIte Then
        Begin
          FieldByName('PCD_QTDBAI').AsFloat := FieldByName('PCD_QTDBAI').AsFloat + fltQtdIte;
          FieldByName('BAIXAD').AsFloat     := FieldByName('BAIXAD').AsFloat + fltQtdIte;
          fltQtdIte := 0
        End Else
        Begin
          FieldByName('PCD_QTDBAI').AsFloat := FieldByName('PCD_QTDBAI').AsFloat + fltDispon;
          FieldByName('BAIXAD').AsFloat     := FieldByName('BAIXAD').AsFloat + fltDispon;
          fltQtdIte := fltQtdIte - fltDispon;
        End;

        FieldByName('PCD_UNITAR').AsFloat := fltUnitar;
        FieldByName('PERIPI').AsFloat     := fltPerIpi;
        FieldByName('PERSUB').AsFloat     := fltPerSub;

        Post;
      End;

      Next;
    End;

  End;
End;

(*
Function TConfereEntrada.fEfetivaBaixaPcmdet: Boolean;
Begin
  Result := True;

  If Not Assigned(FPcmdet) Then
    Exit;

  With FPcmdet Do
  Begin
    Filtered := False;
    First;
    While Not Eof Do
    Begin
      If FieldByName('BAIXAD').AsFloat > 0 Then
        Result := fAtualizaDadosPcmDet(FieldByName('BAIXAD').AsFloat,
                                       FieldByName('PCD_UNITAR').AsFloat,
                                       '',
                                       '',
                                       FieldByName('AUT_PCMDET').AsString);

      If Not Result Then
        Break;

      Next;
    End;
  End;
End;

Function TConfereEntrada.fEfetivaBaixaPedidos: Boolean;
Begin
  pEfetivaBaixaPcmcon;
  Result := fEfetivaBaixaPcmdet;
End;
*)

Procedure TConfereEntrada.pZeraQuantidadeSintetizada;
Begin
  If Not Assigned(FSinEnt) Then
    Exit;

  With FSinEnt Do
  Begin

    While Locate('QTDCON', 0, []) Do
      Delete;

    First;
    While Not Eof Do
    Begin
      Edit;
      FieldByName('QTDENT').AsFloat := 0;
      Post;
      Next;
    End;
  End;
End;

Function TConfereEntrada.fVerificaQuantidadeSintetizada: Boolean;
  Var
    qryEntMer: TUniQuery;
    blnTemEmb: Boolean;
    cdsOcorre: TUniClientDataSet;
Begin
  Result := True;

  If Not Assigned(FSinEnt) Then
    Exit;

  pZeraQuantidadeSintetizada;

  qryEntMer := fCriaQuery;
  With qryEntMer, SQL Do
  Begin
    Clear;
    Add('SELECT * FROM TMP_ENTMER');
    Open;

    While Not Eof Do
    Begin

      blnTemEmb := False;
      FSinEnt.Filter   := 'CODITE = ' + QuotedStr(FieldByName('ENT_CODITE').AsString);
      FSinEnt.Filtered := True;

      FSinEnt.First;
      While Not FSinEnt.Eof Do
      Begin
        If RoundTo(FSinEnt.FieldByName('EMBALA').AsFloat, -2) =
           RoundTo(FieldByName('ENT_EMBALA').AsFloat, -2) Then
        Begin
          FSinEnt.Edit;
          FSinEnt.FieldByName('QTDENT').AsFloat := FSinEnt.FieldByName('QTDENT').AsFloat +
                                                   FieldByName('ENT_QTDITE').AsFloat;
          FSinEnt.Post;
          blnTemEmb := True;
          break;
       End;
        FSinEnt.Next;
      End;

      If Not blnTemEmb Then
      Begin
        FSinEnt.Insert;
        FSinEnt.FieldByName('CODITE').AsString := FieldByName('ENT_CODITE').AsString;
        FSinEnt.FieldByName('DESITE').AsString := FieldByName('ENT_DESITE').AsString;
        FSinEnt.FieldByName('EMBALA').AsFloat  := FieldByName('ENT_EMBALA').AsFloat;
        FSinEnt.FieldByName('QTDENT').AsFloat  := FieldByName('ENT_QTDITE').AsFloat;
        FSinEnt.FieldByName('QTDCON').AsFloat  := 0;
        FSinEnt.Post;
      End;

      Next;
    End;

  End;

  With FSinEnt Do
  Begin
    Filtered := False;

    cdsOcorre := TUniClientDataSet.Create(Nil);
    cdsOcorre.Data := Data;
    cdsOcorre.First;

    TFloatField(cdsOcorre.FieldByName('EMBALA')).DisplayFormat := fMskDigitos(fCfgSis('DEQTEM', varInteger));
    TFloatField(cdsOcorre.FieldByName('QTDENT')).DisplayFormat := fMskDigitos(fCfgSis('DEQTEM', varInteger));
    TFloatField(cdsOcorre.FieldByName('QTDCON')).DisplayFormat := fMskDigitos(fCfgSis('DEQTEM', varInteger));

    While Not cdsOcorre.Eof Do
    Begin
      If RoundTo(cdsOcorre.FieldByName('QTDENT').AsFloat, -2) <=
         RoundTo(cdsOcorre.FieldByName('QTDCON').AsFloat, -2) Then
      Begin
        cdsOcorre.Delete;
      End

      Else cdsOcorre.Next;
    End;

    If Not cdsOcorre.IsEmpty Then
    Begin
      Result := False;
      pCriarFormularios(TfrmEntConfSintDifere, frmEntConfSintDifere);
      Try
        frmEntConfSintDifere.dtsItens.DataSet := cdsOcorre;
        frmEntConfSintDifere.ShowModal;
      Finally
        FreeAndNil(frmEntConfSintDifere);
      End;
    End;

  End;

  FreeAndNil(cdsOcorre);
  FreeAndNil(qryEntMer);
End;

procedure TConfereEntrada.pImprimirLiberacaoArmazenamento;
Var
  strIdeDig: String;
  frmQckLiberacaoArmazenamento: TfrmQckLiberacaoArmazenamento;
Begin
  pCriarFormularios(TfrmQckLiberacaoArmazenamento, frmQckLiberacaoArmazenamento);
  Try
    strIdeDig := stlPedidos.CommaText;
    frmQckLiberacaoArmazenamento.pUtilizarCadSem;
    frmQckLiberacaoArmazenamento.blnSQLPedidoCompra := true;
    frmQckLiberacaoArmazenamento.pImprimir(strIdeDig, 'frmEntConferPreNota_LIBARM', '', oriLibConferenciaEntradaMercadoria);
  Finally
    FreeAndNil(frmQckLiberacaoArmazenamento);
  End;
End;

function TConfereEntrada.fValidarImpressaoLiberacaoArmazenamento: Boolean;
Begin
  {Conferencia por Pedido e LIBPNT = S}
  Result :=(Pos(fCfgSis('CONFME'), '2_3_') > 0) And fCfgSis('LIBPNT',varBoolean);
End;

end.

