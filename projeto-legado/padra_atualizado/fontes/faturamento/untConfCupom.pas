unit untConfCupom;

interface

uses

  Classes,
  Uni,
  DB,
  UniClientDataSet,
  DBCtrls,
  strUtils,
  SysUtils,
  Forms,
  Math,
  Variants,
  untFuncFat,
  untTypesSistema;

type
  TConfirmacaoCupom = class(TComponent)
    private
      FCodCli: String;
      FNumCup: String;
      FEspCup: String;
      FDtaIni: TDateTime;
      FDtaFim: TDateTime;
      FCupEsp: Boolean;

      FQtdDoc: String;
      FTotGer: String;
      FDupPag: String;
      FTotLiq: String;

      FQtdDocSel: String;
      FTotGerSel: String;
      FDupPagSel: String;
      FTotLiqSel: String;

      FCodCnd: String;
      FConPag: String;
      FCodFpg: String;
      FTipFre: String;
      FCodVen: String;
      FCodVe2: String;
      FCodFaz: String;
      FCodEmb: String;

      FNomTab: String;
      FAutInc: String;

      FItensDocs: Integer;
      FCodNovCli: String;

      fatVenda : TFatVenda;
      strEspSel: String;
      strForSel: String;
      strNotEsp: String;

      strTemConcr: String;

      blnCriouFatVendaInternamente: Boolean;
      function fGetQryConf: TUniQuery;

      procedure pCalculaTotais;

      procedure pCarregaDadosGravadosDoCliente(strTabGer, strAutInc: String);

      function fTemAgrupamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
      function fRetFormaPagto: String;
      function fGetSemCupons: Boolean;

      function fExisteCadRec(strNumDup, strEspDoc, strCodEmp, strCodCli: String): Boolean;
      function fRetTotPag(strNumDup, strEspDoc, strCodEmp, strCodCli: String;
        fltVlrCon, fltDupRecAnt: Double): Double;
      function fDupRecAlterado(strNumDup, strEspDoc, strCodEmp, strCodCli: String;
        fltVlrCon, fltDupRecAnt: Double): Boolean;
      function fTravaBoletoRemessa(strNumDup, strEspDoc, strCodEmp, strCodCli: String): Boolean;
      procedure pRetJurosDescontoSujerido( strNumDoc,
                                           strEspDoc,
                                           strCodEmp,
                                           strCodCli: String;
                                       Var fltValAbe: Double);
    public
      procedure pDeletaTemporariaConfirmacao;
      procedure pCriaTemporariaConfirmacao;
      procedure pAtualizaTemporariaConfirmacao;
      procedure pDeletaCuponsDesmarcados;
      procedure pExibirProdutosDocumento;
      procedure pCarregaDadosDocumentoGeraStringCuponsConfirmados;
      procedure pPegaPlacaAndKmVeiculo;
      procedure pDestravarTodos;

      procedure pMarcarTodosDocumentos(blnMarcar: Boolean; strEntRet: String);
      function fMarcaDocumento(blnMarcar: Boolean): Boolean;

      function fCarregaItensConfirmacaoCupomFiscal: Boolean;
      function fMostraProdutosConfirmacao: Boolean;

      function fConfirmarCupomFiscalEmNota: Boolean;

      procedure pSetaClienteCupom(strCodCli: String);

      constructor Create(AOwner: TComponent); override;
      constructor CreateInstance(AOwner: TComponent; objVenda: TFatVenda);

      destructor Destroy; override;

    published
      property blnCarregarCupomEspecial: Boolean Read FCupEsp Write FCupEsp;
      property strCodigoCliente: String Read FCodCli Write FCodCli;
      property strCodigoNovoCliente: string read FCodNovCli write FCodNovCli;
      property strNumeroCupom: String Read FNumCup Write FNumCup;
      property strEspecieCupom: String Read FEspCup Write FEspCup;
      property dtaDataInicial: TDateTime Read FDtaIni Write FDtaIni;
      property dtaDataFinal: TDateTime Read FDtaFim Write FDtaFim;

      property strQuantidadeDocumentos: String Read FQtdDoc;
      property strDuplicatasPagas: String Read FDupPag;
      property strTotalLiquido: String Read FTotLiq;
      property strTotalGeral: String Read FTotGer;

      property intQtdItensDocs: Integer Read FItensDocs;

      property strQuantidadeDocumentosSelecionados: String Read FQtdDocSel;
      property strDuplicatasPagasSelecionados: String Read FDupPagSel;
      property strTotalLiquidoSelecionados: String Read FTotLiqSel;
      property strTotalGeralSelecionados: String Read FTotGerSel;

      property strConfirmacaoCupomEspecial: String Read strNotEsp;

      property strCodigoCondicaoPagamento: String Read FCodCnd;
      property strCondicaoPagamento: String Read FConPag;
      property strCodigoFormaPagamento: String Read FCodFpg;
      property strTipoFrete: String Read FTipFre;
      property strCodigoVendedor: String Read FCodVen;
      property strCodigoVendedor2: String Read FCodVe2;

      property strCodFaz: String Read FCodFaz;
      property strCodEmb: String Read FCodEmb;

      property blnSemCuponsParaConfirmar: Boolean Read fGetSemCupons;

      property objFatVenda: TFatVenda Read fatVenda;

      property qryConfirmacao: TUniQuery Read fGetQryConf;
  end;


implementation


uses untFatMostraProdConfirmacao, untFatDadosFiscais, untGravando,
     untMadeireira, untFuncoes, untConstantes, untFuncoesSimples, untFuncFatTypes,
     untFuncTinta, untNetpoints, untDuplicatas;

constructor TConfirmacaoCupom.Create(AOwner: TComponent);
begin
//  inherited;
  CreateInstance(AOwner, nil);
end;

constructor TConfirmacaoCupom.CreateInstance(AOwner: TComponent; objVenda: TFatVenda);
begin
  inherited Create(AOwner);

  blnCriouFatVendaInternamente := Not Assigned(objVenda);

  If blnCriouFatVendaInternamente Then
  Begin
    pCriarCdsVenda(Self);
    fatVenda := TFatVenda.CreateInstance('CI');
    fatVenda.strNomeForm := 'frmFatVendas';
  End
  Else
    fatVenda := objVenda;

  if ( fatVenda <> nil ) then
    fatVenda.strOpcDocTrue := 'CI';

  strEspSel   := '';
  strForSel   := '';
  strTemConcr := '';
  strNotEsp   := '';
end;

destructor TConfirmacaoCupom.Destroy;
begin
  If blnCriouFatVendaInternamente Then
  Begin
    pFreeCdsVenda;
    FreeAndNil(fatVenda);
  End;

  inherited Destroy;
end;

function TConfirmacaoCupom.fCarregaItensConfirmacaoCupomFiscal: Boolean;
  Var
    strSQL: String;
    strItemAnt: String;
    fltUnitarioEmb: Double;
    intContServico: Integer;
    intContador: Integer;

    qryGenIte: TUniQuery;
    qryGenDet: TUniQuery;

    recMadeira: TDadosMadeira;
    fltCusIte: Double;

    recForTin: TForTin;    
    blnPegEndEnt: Boolean;
    blnDecidiuEndereco : Boolean;
    calcCustoReal: TCalcCustoReal;
    impSubIteEst : TImpostosSubItensEstrutura;

    fltOutVal,
    fltIcmSai,
    fltDesOpe,
    fltImpFed: Double;

    fltItePreVe1,
    fltItePreVe2,
    fltItePreVe3,
    fltItePreVe4,
    fltItePreVe5,
    fltItePreVe6,
    fltItePreVe7: Double;

    blnCoenre,
    blnSugRom,
    blnEndRet: Boolean;

    fltPesBruTmp: Double;
    fltPesLiqTmp: Double;
begin

  qryGenIte := fCriaQuery(Self);
  qryGenDet := fCriaQuery(Self);

  strItemAnt  := '';

  fatVenda.fltDesEsp := 0.0;
  fatVenda.fltDesAce := 0.0;
  intContServico := 1;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  DET_NUMDOC, ';
  strSQL := strSQL + '  DET_ESPDOC, ';
  strSQL := strSQL + '  DET_CODEMP, ';
  strSQL := strSQL + '  DET_IDEPRO, ';
  strSQL := strSQL + '  DET_CODITE, ';
  strSQL := strSQL + '  ITE_CODGRU, ';
  strSQL := strSQL + '  DET_DESCRI, ';
  strSQL := strSQL + '  DET_UNIDAD, ';
  strSQL := strSQL + '  DET_UNIDAD, ';
  strSQL := strSQL + '  DET_CODMAR, ';
  strSQL := strSQL + '  DET_FORITE, ';
  strSQL := strSQL + '  DET_REFERE, ';
  strSQL := strSQL + '  DET_VAL_RT, ';
  strSQL := strSQL + '  DET_UNIORI, ';
  strSQL := strSQL + '  DET_UNIVIS, ';
  strSQL := strSQL + '  DET_TAXJUR, ';
  strSQL := strSQL + '  DET_UNITAR, ';
  strSQL := strSQL + '  DET_UNITAR, ';
  strSQL := strSQL + '  DET_DESCON, ';
  strSQL := strSQL + '  DET_QTDITE, ';

  If fCfgSis('VENMAD', varBoolean) Or fCfgSis('VENVID', varBoolean) Or fCfgSis('VENMTL', varBoolean) Then
  Begin
    strSQL := strSQL + '  DET_COMPEC, ';
    strSQL := strSQL + '  DET_LARPEC, ';
    strSQL := strSQL + '  DET_ESPPEC, ';

    strSQL := strSQL + '  DET_APAREL, ';
    strSQL := strSQL + '  DET_PERAPA, ';
    strSQL := strSQL + '  DET_BENEFI, ';
    strSQL := strSQL + '  DET_PERBEN, ';
  End;

  strSQL := strSQL + '  DET_TOTITE, ';
  strSQL := strSQL + '  DET_TOTCUS, ';
  strSQL := strSQL + '  DET_TOTCU2, ';
  strSQL := strSQL + '  DET_INCPIS, ';
  strSQL := strSQL + '  DET_QTDEMB, ';
  strSQL := strSQL + '  DET_PREEMB, ';
  strSQL := strSQL + '  DET_TOTPES, ';
  strSQL := strSQL + '  DET_PESLIQ, ';
  strSQL := strSQL + '  DET_PROMOC, ';
  strSQL := strSQL + '  DET_CLAFIS, ';
  strSQL := strSQL + '  DET_CODEMP, ';
  strSQL := strSQL + '  DET_QTDEMB, ';
  strSQL := strSQL + '  DET_PREEMB, ';
  strSQL := strSQL + '  DET_ESPDOC, ';
  strSQL := strSQL + '  DET_SEQTIN, ';
  strSQL := strSQL + '  DET_TABPRE, ';
  strSQL := strSQL + '  D.AUTOINCREM, ';
  strSQL := strSQL + '  DET_ESTADO, ';
  strSQL := strSQL + '  DET_QTDPON, ';
  strSQL := strSQL + '  DET_ITETIN, ';
  strSQL := strSQL + '  DET_TOTFRE, ';
  strSQL := strSQL + '  DET_NUMLOT, ';
  strSQL := strSQL + '  DET_CODVEN, ';
  strSQL := strSQL + '  DET_CODVE2, ';
  strSQL := strSQL + '  DET_CODACA, ';
  strSQL := strSQL + '  DET_EMPACA, ';
  strSQL := strSQL + '  DET_PROACA, ';
  strSQL := strSQL + '  DET_ATIVAC, ';
  strSQL := strSQL + '  DET_SEQCOM, ';

  strSQL := strSQL + ' (DET_ICMSAI / (DET_TOTITE - DET_DESESP) * 100) AS DET_ICMSAI, ';
  strSQL := strSQL + ' (DET_IMPFED / (DET_TOTITE - DET_DESESP) * 100) AS DET_IMPFED, ';
  strSQL := strSQL + ' (DET_DESOPE / (DET_TOTITE - DET_DESESP) * 100) AS DET_DESOPE, ';
  strSQL := strSQL + ' (DET_TOTMED / DET_QTDITE) AS DET_PREMED, ';
  strSQL := strSQL + ' (DET_IMPULT / DET_QTDITE) AS DET_IMPULT, ';
  strSQL := strSQL + ' (DET_TOTULT / DET_QTDITE) AS DET_PREULT  ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET D ';
  strSQL := strSQL + 'JOIN CADITE ON ITE_CODITE = DET_CODITE ';

  If fCfgSis('VENMAD', varBoolean) Or fCfgSis('VENVID', varBoolean) Or fCfgSis('VENMTL', varBoolean) Then
    strSQL := strSQL + ' LEFT JOIN MOVMAD M ON M.DET_SEQGER = D.AUTOINCREM  ';

  strSQL := strSQL + ' LEFT JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM  ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  DET_PROEMB <> "S" AND ';
  strSQL := strSQL + '  DET_DTAENT = :DTAENT AND ';
  strSQL := strSQL + '  DET_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  DET_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  DET_CODEMP = :CODEMP ';

  strSQL := strSQL + '  UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL,'MOVDET','NOTDET'),'MOVMAD','NOTMAD'), 'MOVTRI', 'NOTTRI');

  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  AUTOINCREM ';

  {*****************************************}
  {* DOCUMENTO DETALHADO                   *}
  {**************************************MV*}
  With qryGenDet Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  I.ITE_DESITE, ';
  strSQL := strSQL + '  I.ITE_DESSIM, ';
  strSQL := strSQL + '  I.ITE_DESFAB, ';
  strSQL := strSQL + '  I.ITE_COMLUB, ';
  strSQL := strSQL + '  I.ITE_CLAIPI, ';
  strSQL := strSQL + '  I.ITE_EXCIPI, ';
  strSQL := strSQL + '  I.ITE_CODFAB, ';
  strSQL := strSQL + '  I.ITE_CODBAR, ';
  strSQL := strSQL + '  G.ITE_OUTVAL, ';
  strSQL := strSQL + '  G.ITE_IMPFED, ';
  strSQL := strSQL + '  G.ITE_ICMSAI, ';
  strSQL := strSQL + '  G.ITE_PRECUS, ';
  strSQL := strSQL + '  G.ITE_DESOPE, ';
  strSQL := strSQL + '  G.ITE_PREULT, ';
  strSQL := strSQL + '  G.ITE_IMPULT, ';
  strSQL := strSQL + '  G.ITE_QTDUCO, ';

  strSQL := strSQL + '  G.ITE_PREVE1, ';
  strSQL := strSQL + '  G.ITE_PREVE2, ';
  strSQL := strSQL + '  G.ITE_PREVE3, ';
  strSQL := strSQL + '  G.ITE_PREVE4, ';
  strSQL := strSQL + '  G.ITE_PREVE5, ';
  strSQL := strSQL + '  G.ITE_PREVE6, ';
  strSQL := strSQL + '  G.ITE_PREVE7, ';

  strSQL := strSQL + '  G.ITE_COMTB1, ';
  strSQL := strSQL + '  G.ITE_COMTB2, ';
  strSQL := strSQL + '  G.ITE_COMTB3, ';
  strSQL := strSQL + '  G.ITE_COMTB4, ';
  strSQL := strSQL + '  G.ITE_COMTB5, ';
  strSQL := strSQL + '  G.ITE_COMTB6, ';
  strSQL := strSQL + '  G.ITE_COMTB7, ';

  strSQL := strSQL + '  G.ITE_IPISAI, ';
  strSQL := strSQL + '  G.ITE_DESMAX, ';
  strSQL := strSQL + '  G.ITE_DESMGE, ';
  strSQL := strSQL + '  G.ITE_DESMSU, ';
  strSQL := strSQL + '  G.ITE_SALDOS, ';
  strSQL := strSQL + '  G.ITE_PREMED, ';
  strSQL := strSQL + '  G.ITE_COMVAR, ';
  strSQL := strSQL + '  G.ITE_COMATA, ';
  strSQL := strSQL + '  G.ITE_COMDIS, ';
  strSQL := strSQL + '  G.ITE_MARMIN, ';
  strSQL := strSQL + '  G.ITE_MARMSG, ';
  strSQL := strSQL + '  G.ITE_MARMGE, ';

  strSQL := strSQL + '  G.ITE_DESMVM, ';
  strSQL := strSQL + '  G.ITE_DESMSM, ';
  strSQL := strSQL + '  G.ITE_DESMGM, ';

  strSQL := strSQL + '  G.ITE_MARMMV, ';
  strSQL := strSQL + '  G.ITE_MARMMS, ';
  strSQL := strSQL + '  G.ITE_MARMMG, ';

  strSQL := strSQL + '  G.ITE_IPIENT, ';
  strSQL := strSQL + '  G.ITE_FREENT, ';
  strSQL := strSQL + '  G.ITE_LOCFIS, ';
  strSQL := strSQL + '  A.ABF_CODABF, ';
  strSQL := strSQL + '  I.ITE_PESOIT, ';
  strSQL := strSQL + '  I.ITE_PESLIQ, ';
  strSQL := strSQL + '  I.ITE_OBRCPF, ';
  strSQL := strSQL + '  G.ITE_PRECOM, ';  

  If fCfgSis('IMPDIG') = '1' Then
    strSQL := strSQL + '  I.ITE_IMPDIR  '
  Else
    strSQL := strSQL + '  G.ITE_IMPDIR  ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I, ';
  strSQL := strSQL + '  ITEGER G, ';
  strSQL := strSQL + '  ABFICM A ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';

  If fCfgSis('TIPABF') = '1' Then
    strSQL := strSQL + '  I.ITE_CODABF = A.ABF_CODABF AND '
  Else
    strSQL := strSQL + '  G.ITE_CODABF = A.ABF_CODABF AND ';

  strSQL := strSQL + '  I.ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  A.ABF_ESTADO = :ESTADO ';

  {*****************************************}
  {* PREPARA A QUERY PARA RETORNAR DADOS   *}
  {* DO ITEM E DA ABREVIAÇÃO FISCAL        *}
  {**************************************MV*}
  With qryGenIte Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
  End;

  Try
    fatVenda.strIfCfNf := 'CUPONS CONFIRMADOS: ';

    blnCoenre := fCfgSis('COENRE', varBoolean);
    blnSugRom := fCfgSis('SUJROM', varBoolean);
    blnEndRet := fCfgSis('ENDRET', varBoolean);

    With fatVenda.qryTemporariaConfirmacao Do
    Begin

      First;

      While (Not Eof) Do
      Begin
        If fEmptyStr(fatVenda.strFasObr) Then
          fatVenda.strFasObr := FieldByName('TMP_FASOBR').AsString;

        If (Pos(FieldByName('TMP_ESPDOC').AsString, 'IF_IV_') > 0) Then
        Begin

          blnPegEndEnt := (blnEndRet) Or
                          (blnSugRom And (Not blnCoenre)) Or
                          (blnCoenre And (FieldByName('TMP_ENTRET').AsString = 'E'));

          If (blnPegEndEnt) And fEmptyStr(FCodFaz) Then
          Begin
            If (fatVenda.strCliFat = fatVenda.strCodCli) Then
            Begin
              fatVenda.pCarregaEnderecoEntrega(fatVenda,
                                               FieldByName('TMP_NOMTAB').AsString,
                                               FieldByName('TMP_AUTINC').AsString,
                                               True);

              blnPegEndEnt := fEmptyStr(fatVenda.strEndEnt);

              If Not blnPegEndEnt Then
                fatVenda.blnEndEntConfDoc := True;
            End
            Else
            Begin
              fatVenda.blnEndEntConfDoc := True;
            End;
          End;

          For intContador := 1 To 30 Do
          Begin

            If (Not fEmptyStr(FieldByName('TMP_CODS' + fStrZero(intContador, 2)).AsString)) Then
            Begin

              fatVenda.pAtribuiValoresServico(intContServico,
                                              FieldByName('TMP_CODS' + fStrZero(intContador, 2)).AsString,
                                              FieldByName('TMP_DESS' + fStrZero(intContador, 2)).AsString,
                                              FieldByName('TMP_IDES' + fStrZero(intContador, 2)).AsString,
                                              FieldByName('TMP_BRIS' + fStrZero(intContador, 2)).AsString,
                                              FieldByName('TMP_PARS' + fStrZero(intContador, 2)).AsString,
                                              FieldByName('TMP_TBRS' + fStrZero(intContador, 2)).AsString,
                                              FieldByName('TMP_VENS' + fStrZero(intContador, 2)).AsString,
                                              FieldByName('TMP_VE2S' + fStrZero(intContador, 2)).AsString,
                                              FieldByName('TMP_QTDS' + fStrZero(intContador, 2)).AsFloat,
                                              FieldByName('TMP_UNIS' + fStrZero(intContador, 2)).AsFloat,
                                              FieldByName('TMP_VALS' + fStrZero(intContador, 2)).AsFloat,
                                              FieldByName('TMP_CUSS' + fStrZero(intContador, 2)).AsFloat,
                                              FieldByName('TMP_DECS' + fStrZero(intContador, 2)).AsFloat );
              Inc(intContServico);

            End;

          End;

          {*****************************************}
          {* SOMA DUPLICATAS RECEBIDAS             *}
          {**************************************MV*}
          fatVenda.fltDupRec := fatVenda.fltDupRec + FieldByName('TMP_DUPREC').AsFloat;

          {*****************************************}
          {* SOMA DESCONTO ESPECIAL                *}
          {**************************************MV*}
          fatVenda.fltDesEsp := fatVenda.fltDesEsp + FieldByName('TMP_DESESP').AsFloat;

          {*******************************************}
          {* MONTA STRING DOS CUPONS CONFIRMADOS     *}
          {****************************************MV*}
          fatVenda.strIfCfNf := fatVenda.strIfCfNf + FieldByName('TMP_NUMDOC').AsString + ',';

          {*****************************************}
          {* CARREGA VALOR DESPESAS ACESSÓRIAS     *}
          {**************************************WL*}
          If (fatVenda.blnConfirmacaoDoCaixa) And
             (FieldByName('TMP_ESPDOC').AsString = 'IF') And
             (fatVenda.strOpcDoc = 'CI') And
             (FieldByName('TMP_DESACE').AsFloat > 0) Then
            fatVenda.fltDesAce := FieldByName('TMP_DESACE').AsFloat
          Else
            fatVenda.fltDesAce :=  fatVenda.fltDesAce + FieldByName('TMP_DESACE').AsFloat;

          if not fCfgSis('CDADOC', varBoolean) then
            fatVenda.fltDesAce := 0;

          {*****************************************}
          {* CARREGA DOCUMENTO DETALHADO           *}
          {**************************************MV*}
          qryGenDet.Close;
          qryGenDet.ParamByName('DTAENT').AsDate   := FieldByName('TMP_DTAENT').AsDateTime;
          qryGenDet.ParamByName('NUMDOC').AsString := FieldByName('TMP_NUMDOC').AsString;
          qryGenDet.ParamByName('ESPDOC').AsString := FieldByName('TMP_ESPDOC').AsString;
          qryGenDet.ParamByName('CODEMP').AsString := VS_strCodEmp;
          qryGenDet.Open;

          If (FieldByName('TMP_EDIPES').AsString = 'S') Then
            fatVenda.strEdiPes := 'E';

          While (Not qryGenDet.Eof) Do
          Begin

            {*****************************************}
            {* SÓ ADICIONA AS SAÍDAS                 *}
            {**************************************MV*}
//            If (StrToInt(LeftStr(qryGenDet.FieldByName('DET_CLAFIS').AsString, 1)) < 5) Then
//            Begin
//              fatVenda.fltDesEsp := fatVenda.fltDesEsp + qryGenDet.FieldByName('DET_TOTITE').AsFloat;
//              fatVenda.fltDesSai := fatVenda.fltDesSai + qryGenDet.FieldByName('DET_TOTITE').AsFloat;
//
//              qryGenDet.Next;
//              Continue;
//            End;

            If (StrToInt(LeftStr(qryGenDet.FieldByName('DET_CLAFIS').AsString, 1)) < 5) Then
            Begin
              Raise Exception.Create('Classificação fiscal menor que 5000. Favor verificar.');
            End;

            If fEhItemServico(qryGenDet.FieldByName('DET_CODITE').AsString) Then
            Begin
              qryGenDet.Next;
              Continue;
            End;

            {*****************************************}
            {* SOMA O FRETE.                         *}
            {**************************************MV*}
            fatVenda.fltValFre := fatVenda.fltValFre + qryGenDet.FieldByName('DET_TOTFRE').AsFloat;
            fatVenda.fltFreDig := fatVenda.fltFreDig + qryGenDet.FieldByName('DET_TOTFRE').AsFloat;

            If (strItemAnt <> qryGenDet.FieldByName('DET_CODITE').AsString) Then
            Begin

              {*****************************************}
              {* CARREGA ITEM                          *}
              {**************************************MV*}
              qryGenIte.Close;
              qryGenIte.ParamByName('CODITE').AsString := qryGenDet.FieldByName('DET_CODITE').AsString;
              qryGenIte.ParamByName('CODEMP').AsString := qryGenDet.FieldByName('DET_CODEMP').AsString;
              qryGenIte.ParamByName('ESTADO').AsString := qryGenDet.FieldByName('DET_ESTADO').AsString;
              qryGenIte.Open;

              fatVenda.pCarregaValoresCusto(qryGenDet.FieldByName('DET_CODITE').AsString,
                                            qryGenDet.FieldByName('DET_CODEMP').AsString,
                                            qryGenDet.FieldByName('DET_TABPRE').AsString);

              strItemAnt  := qryGenDet.FieldByName('DET_CODITE').AsString;
            End;

            If (qryGenDet.FieldByName('DET_QTDEMB').AsFloat > 0) Then
              fltUnitarioEmb := (qryGenDet.FieldByName('DET_PREEMB').AsFloat /
                                 qryGenDet.FieldByName('DET_QTDEMB').AsFloat)
            Else
              fltUnitarioEmb := 0.0;

            fltPesBruTmp := qryGenDet.FieldByName('DET_TOTPES').AsFloat / qryGenDet.FieldByName('DET_QTDITE').AsFloat;
            fltPesLiqTmp := qryGenIte.FieldByName('ITE_PESLIQ').AsFloat;

            If (fatVenda.strEdiPes = 'E') Then
            Begin
              fltPesBruTmp := qryGenDet.FieldByName('DET_TOTPES').AsFloat / qryGenDet.FieldByName('DET_QTDITE').AsFloat;
              fltPesLiqTmp := qryGenDet.FieldByName('DET_PESLIQ').AsFloat / qryGenDet.FieldByName('DET_QTDITE').AsFloat;
            End;

            If fCfgSis('VENMAD', varBoolean) Or fCfgSis('VENVID', varBoolean) Or fCfgSis('VENMTL', varBoolean) Then
            Begin
              recMadeira.fltComPec := qryGenDet.FieldByName('DET_COMPEC').AsFloat;
              recMadeira.fltLarPec := qryGenDet.FieldByName('DET_LARPEC').AsFloat;
              recMadeira.fltEspPec := qryGenDet.FieldByName('DET_ESPPEC').AsFloat;

              recMadeira.fltQtdPec := fCalculaQuantidadePecas(qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                                              recMadeira.fltComPec,
                                                              recMadeira.fltLarPec,
                                                              recMadeira.fltEspPec,
                                                              fRetSiglaUnidade(qryGenDet.FieldByName('DET_UNIDAD').AsString));

              recMadeira.strAparel := qryGenDet.FieldByName('DET_APAREL').AsString;
              recMadeira.fltPerApa := qryGenDet.FieldByName('DET_PERAPA').AsFloat;
              recMadeira.strBenefi := qryGenDet.FieldByName('DET_BENEFI').AsString;
              recMadeira.fltPerBen := qryGenDet.FieldByName('DET_PERBEN').AsFloat;
            End;

            fltCusIte := qryGenDet.FieldByName('DET_TOTCUS').AsFloat / qryGenDet.FieldByName('DET_QTDITE').AsFloat;

            If qryGenDet.FieldByName('DET_IDEPRO').AsString <> 'NOR' Then
            Begin
              If Not IsTintaExistente(qryGenDet.FieldByName('DET_IDEPRO').AsString) Then
              Begin
                Result := False;
                If Assigned(qryGenIte) Then FreeAndNil(qryGenIte);
                If Assigned(qryGenDet) Then FreeAndNil(qryGenDet);
                Exit;
              End;
            End;

            If fatVenda.fUtilizaPrecoSubItensEstrutura(Pos('ITEM ESPECIAL', qryGenDet.FieldByName('DET_DESCRI').AsString) > 0,
                                                       qryGenDet.FieldByName('DET_CODITE').AsString) Then
            Begin
              impSubIteEst.strCodIte := qryGenDet.FieldByName('DET_CODITE').AsString;
              impSubIteEst.strEmpIte := '';
              impSubIteEst.fltUniPai := qryGenDet.FieldByName('DET_UNITAR').AsFloat;
              impSubIteEst.fltQtdPai := qryGenDet.FieldByName('DET_QTDITE').AsFloat;

              fatVenda.pRetImpostosSubItensEstrutura(impSubIteEst);

              fltOutVal    := impSubIteEst.fltOutVal;
              fltIcmSai    := impSubIteEst.fltIcmSai;
              fltDesOpe    := impSubIteEst.fltDesOpe;
              fltImpFed    := impSubIteEst.fltImpFed;

              fltItePreVe1 := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,qryGenDet.FieldByName('DET_CODITE').AsString,'','S','1',fatVenda.fltMargem);
              fltItePreVe2 := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,qryGenDet.FieldByName('DET_CODITE').AsString,'','S','2',fatVenda.fltMargem);
              fltItePreVe3 := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,qryGenDet.FieldByName('DET_CODITE').AsString,'','S','3',fatVenda.fltMargem);
              fltItePreVe4 := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,qryGenDet.FieldByName('DET_CODITE').AsString,'','S','4',fatVenda.fltMargem);
              fltItePreVe5 := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,qryGenDet.FieldByName('DET_CODITE').AsString,'','S','5',fatVenda.fltMargem);
              fltItePreVe6 := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,qryGenDet.FieldByName('DET_CODITE').AsString,'','S','6',fatVenda.fltMargem);
              fltItePreVe7 := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,qryGenDet.FieldByName('DET_CODITE').AsString,'','S','7',fatVenda.fltMargem);
            End
            Else
            Begin
              fltOutVal    := fatVenda.fRetOutVal(qryGenIte.FieldByName('ITE_OUTVAL').AsFloat);
              fltIcmSai    := fatVenda.fRetIcmSai(qryGenIte.FieldByName('ITE_ICMSAI').AsFloat);
              fltDesOpe    := fatVenda.fRetDesOpe(qryGenIte.FieldByName('ITE_DESOPE').AsFloat);
              fltImpFed    := fatVenda.fRetImpFed(qryGenIte.FieldByName('ITE_IMPFED').AsFloat);
              fltItePreVe1 := qryGenIte.FieldByName('ITE_PREVE1').AsFloat;
              fltItePreVe2 := qryGenIte.FieldByName('ITE_PREVE2').AsFloat;
              fltItePreVe3 := qryGenIte.FieldByName('ITE_PREVE3').AsFloat;
              fltItePreVe4 := qryGenIte.FieldByName('ITE_PREVE4').AsFloat;
              fltItePreVe5 := qryGenIte.FieldByName('ITE_PREVE5').AsFloat;
              fltItePreVe6 := qryGenIte.FieldByName('ITE_PREVE6').AsFloat;
              fltItePreVe7 := qryGenIte.FieldByName('ITE_PREVE7').AsFloat;
            End;

            fatVenda.pAdicionaRegistroTemporaria( cdsVenda,
                                                  Nil,
                                                  qryGenDet.FieldByName('DET_IDEPRO').AsString,
                                                  qryGenDet.FieldByName('ITE_CODGRU').AsString,
                                                  qryGenDet.FieldByName('DET_CODITE').AsString,
                                                  qryGenDet.FieldByName('DET_DESCRI').AsString,
                                                  qryGenDet.FieldByName('DET_DESCRI').AsString,
                                                  qryGenIte.FieldByName('ITE_DESFAB').AsString,
                                                  qryGenDet.FieldByName('DET_UNIDAD').AsString,
                                                  qryGenDet.FieldByName('DET_UNIDAD').AsString,
                                                  qryGenDet.FieldByName('DET_CODMAR').AsString,
                                                  qryGenDet.FieldByName('DET_FORITE').AsString,
                                                  qryGenDet.FieldByName('DET_REFERE').AsString,
                                                  qryGenDet.FieldByName('DET_UNIORI').AsFloat,
                                                  qryGenDet.FieldByName('DET_UNIVIS').AsFloat,
                                                  qryGenDet.FieldByName('DET_UNITAR').AsFloat,
                                                  qryGenDet.FieldByName('DET_UNITAR').AsFloat,
                                                  qryGenDet.FieldByName('DET_DESCON').AsFloat,
                                                  qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                                  qryGenDet.FieldByName('DET_TOTITE').AsFloat,
                                                  'S',
                                                  qryGenDet.FieldByName('DET_TOTCUS').AsFloat / qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                                  qryGenDet.FieldByName('DET_TOTCUS').AsFloat,
                                                  qryGenIte.FieldByName('ITE_COMLUB').AsString,
                                                  qryGenIte.FieldByName('ITE_IPISAI').AsFloat,
                                                  qryGenIte.FieldByName('ITE_DESMAX').AsFloat,
                                                  fltItePreVe1,
                                                  fltItePreVe2,
                                                  fltItePreVe3,
                                                  fltItePreVe4,
                                                  fltItePreVe5,
                                                  fltItePreVe6,
                                                  fltItePreVe7,

                                                  fCalculaPrecoVenda(2, fltCusIte + fltOutVal,
                                                                        qryGenDet.FieldByName('DET_UNITAR').AsFloat,
                                                                        0,
                                                                        IfThen(qryGenDet.FieldByName('DET_IDEPRO').AsString <> 'NOR', qryGenDet.FieldByName('DET_ICMSAI').AsFloat, fltIcmSai),
                                                                        IfThen(qryGenDet.FieldByName('DET_IDEPRO').AsString <> 'NOR', qryGenDet.FieldByName('DET_IMPFED').AsFloat, fltImpFed),
                                                                        IfThen(qryGenDet.FieldByName('DET_IDEPRO').AsString <> 'NOR', qryGenDet.FieldByName('DET_DESOPE').AsFloat, fltDesOpe),
                                                                        qryGenIte.FieldByName('ITE_COMTB' +
                                                                          IIF(fEmptyStr(qryGenDet.FieldByName('DET_TABPRE').AsString), '1',
                                                                            qryGenDet.FieldByName('DET_TABPRE').AsString)).AsFloat, fatVenda.VS_strMARMKP),

                                                  qryGenIte.FieldByName('ITE_SALDOS').AsFloat,
                                                  qryGenDet.FieldByName('DET_INCPIS').AsString,
                                                  qryGenIte.FieldByName('ITE_COMVAR').AsFloat,
                                                  qryGenIte.FieldByName('ITE_COMATA').AsFloat,
                                                  qryGenIte.FieldByName('ITE_COMDIS').AsFloat,
                                                  '',
                                                  '',
                                                  '',
                                                  0.0,
                                                  0.0,
                                                  '',
                                                  IfThen(qryGenDet.FieldByName('DET_IDEPRO').AsString <> 'NOR', qryGenDet.FieldByName('DET_PREULT').AsFloat, qryGenIte.FieldByName('ITE_PREULT').AsFloat) * qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                                  IfThen(qryGenDet.FieldByName('DET_IDEPRO').AsString <> 'NOR', qryGenDet.FieldByName('DET_IMPULT').AsFloat, qryGenIte.FieldByName('ITE_IMPULT').AsFloat),
                                                  IfThen(qryGenDet.FieldByName('DET_IDEPRO').AsString <> 'NOR', qryGenDet.FieldByName('DET_PREULT').AsFloat, qryGenIte.FieldByName('ITE_PREULT').AsFloat),
                                                  IfThen(qryGenDet.FieldByName('DET_IDEPRO').AsString <> 'NOR', qryGenDet.FieldByName('DET_PREMED').AsFloat, qryGenIte.FieldByName('ITE_PREMED').AsFloat),
                                                  qryGenIte.FieldByName('ITE_CLAIPI').AsString,
                                                  '',
                                                  qryGenDet.FieldByName('DET_ITETIN').AsString,  //CODIGO DA TINTA
                                                  '',
                                                  '',
                                                  0,
                                                  '',
                                                  qryGenDet.FieldByName('DET_QTDEMB').AsFloat,
                                                  qryGenDet.FieldByName('DET_PREEMB').AsFloat,
                                                  0.0,
                                                  0.0,
                                                  0.0,
                                                  'N',
                                                  '',
                                                  fltUnitarioEmb,
                                                  fltUnitarioEmb,

                                                  qryGenIte.FieldByName('ABF_CODABF').AsString,
                                                  fltPesBruTmp,
                                                  fltPesLiqTmp,
                                                  qryGenDet.FieldByName('DET_PROMOC').AsString,
                                                  0.0,
                                                  0.0,
                                                  0.0,
                                                  0.0,
                                                  IIF(fEmptyStr(qryGenDet.FieldByName('DET_SEQTIN').AsString), '', '2'),
                                                  0.0,
                                                  qryGenIte.FieldByName('ITE_CODFAB').AsString,
                                                  -1,
                                                  0.0,
                                                  '',
                                                  '',
                                                  '',
                                                  qryGenIte.FieldByName('ITE_MARMIN').AsFloat,
                                                  qryGenIte.FieldByName('ITE_MARMSG').AsFloat,
                                                  qryGenIte.FieldByName('ITE_MARMGE').AsFloat,
                                                  FatVenda.strDesMar,
                                                  fatVenda.strStatus,
                                                  0.0,
                                                  0.0,
                                                  qryGenDet.FieldByName('AUTOINCREM').AsString,
                                                  '',
                                                  '',
                                                  0.0,
                                                  '',
                                                  '',
                                                  '',
                                                  qryGenIte.FieldByName('ITE_PRECOM').AsFloat,
                                                  qryGenDet.FieldByName('DET_UNITAR').AsFloat,
                                                  qryGenDet.FieldByName('DET_QTDPON').AsFloat,
                                                  '',
                                                  '',
                                                  qryGenIte.FieldByName('ITE_OBRCPF').AsString,
                                                  '',
                                                  '',
                                                  fRetSiglaUnidade(qryGenDet.FieldByName('DET_UNIDAD').AsString),
                                                  0.0,
                                                  fatVenda.fOrdemItem(cdsVenda,'Adiciona',nil),
                                                  '',
                                                  qryGenDet.FieldByName('DET_CODACA').AsString,
                                                  qryGenDet.FieldByName('DET_EMPACA').AsString,
                                                  (qryGenDet.FieldByName('DET_PROACA').AsString = 'S'),
                                                  '',
                                                  '',
                                                  '',
                                                  fltOutVal,
                                                  qryGenIte.FieldByName('ITE_COMTB' +
                                                    IIF(fEmptyStr(qryGenDet.FieldByName('DET_TABPRE').AsString), '1',
                                                                  qryGenDet.FieldByName('DET_TABPRE').AsString) ).AsFloat,
                                                  IfThen(qryGenDet.FieldByName('DET_IDEPRO').AsString <> 'NOR', qryGenDet.FieldByName('DET_DESOPE').AsFloat, fltDesOpe),
                                                  IfThen(qryGenDet.FieldByName('DET_IDEPRO').AsString <> 'NOR', qryGenDet.FieldByName('DET_ICMSAI').AsFloat, fltIcmSai),
                                                  IfThen(qryGenDet.FieldByName('DET_IDEPRO').AsString <> 'NOR', qryGenDet.FieldByName('DET_IMPFED').AsFloat, fltImpFed),
                                                  qryGenIte.FieldByName('ITE_DESMGE').AsFloat,
                                                  qryGenDet.FieldByName('DET_NUMDOC').AsString,
                                                  qryGenDet.FieldByName('DET_ESPDOC').AsString,
                                                  qryGenDet.FieldByName('DET_CODEMP').AsString,
                                                  qryGenDet.FieldByName('DET_TABPRE').AsString,
                                                  qryGenIte.FieldByName('ITE_IPIENT').AsFloat,
                                                  qryGenIte.FieldByName('ITE_FREENT').AsFloat,
                                                  '',
                                                  0.0,
                                                  '',
                                                  0.0,
                                                  IfThen(blnCoenre Or fatVenda.blnConfirmacaoDoCaixa, FieldByName('TMP_ENTRET').AsString, ''), //Entrega/Retira
                                                  '',
                                                  'N',
                                                  '',
                                                  0,
                                                  qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                                  0,
                                                  0,
                                                  qryGenIte.FieldByName('ITE_IMPDIR').AsString,
                                                  qryGenIte.FieldByName('ITE_LOCFIS').AsString,

                                                  qryGenDet.FieldByName('DET_TOTCU2').AsFloat / qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                                  qryGenDet.FieldByName('DET_TOTCU2').AsFloat,
                                                  0,
                                                  0,
                                                  0,
                                                  0,
                                                  0,
                                                  0,
                                                  recForTin,
                                                  '',
                                                  '',
                                                  qryGenDet.FieldByName('DET_NUMLOT').AsString,
                                                  '',
                                                  qryGenDet.FieldByName('DET_CODVEN').AsString,
                                                  False,
                                                  'N',
                                                  'NOR',
                                                  0,
                                                  '',
                                                  qryGenIte.FieldByName('ITE_CODBAR').AsString,
                                                  '',
                                                  0,
                                                  0,
                                                  0,
                                                  '',
                                                  1,
                                                  True,
                                                  '',
                                                  '',
                                                  '',                                                  
                                                  0,
                                                  fltCusIte,
                                                  qryGenIte.FieldByName('ITE_DESSIM').AsString,
                                                  '',
                                                  recMadeira,
                                                  IfThen(qryGenDet.FieldByName('DET_IDEPRO').AsString <> 'NOR', qryGenDet.FieldByName('DET_IMPULT').AsFloat, qryGenIte.FieldByName('ITE_IMPULT').AsFloat) * qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                                  qryGenDet.FieldByName('DET_VAL_RT').AsFloat,
                                                  qryGenDet.FieldByName('DET_TAXJUR').AsFloat,
                                                  '',
                                                  0,
                                                  '',
                                                  '',
                                                  0,
                                                  0,
                                                  '',
                                                  '',
                                                  0,
                                                  '',
                                                  'N',
                                                  0,
                                                  0,
                                                  0,
                                                  False,
                                                  False,
                                                  'N',
                                                  '',
                                                  0,
                                                  0,
                                                  qryGenDet.FieldByName('DET_CODVE2').AsString,
                                                  'N',
                                                  0,
                                                  '',
                                                  '',
                                                  '',
                                                  '',
                                                  qryGenIte.FieldByName('ITE_EXCIPI').AsString,
                                                  qryGenIte.FieldByName('ITE_DESMSU').AsFloat,
                                                  '',
                                                  '',
                                                  '',
                                                  'S',
                                                  'N',
                                                  '',
                                                  '',
                                                  '',
                                                  '',
                                                  fatVenda.strEdiPes = 'E',
                                                  qryGenIte.FieldByName('ITE_PESOIT').AsFloat,
                                                  qryGenIte.FieldByName('ITE_PESLIQ').AsFloat,
                                                  'N',
                                                  '',
                                                  qryGenDet.FieldByName('DET_ATIVAC').AsString,
                                                  qryGenDet.FieldByName('DET_SEQCOM').AsInteger,
                                                  0,
                                                  0,
                                                  '',
                                                  0,
                                                  0,
                                                  0,
                                                  '',
                                                  0,
                                                  0,
                                                  0,
                                                  '',
                                                  '',
                                                  0,
                                                  0,
                                                  0,
                                                  False,
                                                  '',
                                                  '',
                                                  '',
                                                  '',
                                                  '',
                                                  0,
                                                  0,
                                                  0,
                                                  0,
                                                  0,
                                                  0,
                                                  0,
                                                  '',
                                                  '',
                                                  0,
                                                  0,
                                                  '',
                                                  '',
                                                  'N',
                                                  'N',
                                                  '',
                                                  0,
                                                  0,
                                                  '',
                                                  '',
                                                  '',
                                                  '',
                                                  '',
                                                  '',
                                                  '',
                                                  '',
                                                  '',
                                                  qryGenIte.FieldByName('ITE_DESMVM').AsFloat,
                                                  qryGenIte.FieldByName('ITE_DESMSM').AsFloat,
                                                  qryGenIte.FieldByName('ITE_DESMGM').AsFloat,
                                                  qryGenIte.FieldByName('ITE_MARMMV').AsFloat,
                                                  qryGenIte.FieldByName('ITE_MARMMS').AsFloat,
                                                  qryGenIte.FieldByName('ITE_MARMMG').AsFloat);

            qryGenDet.Next;

            Application.ProcessMessages;

          End;

        End;

        fatVenda.blnVendaPresencial := FieldByName('TMP_VENPRE').AsString = 'S';
        fatVenda.blnConfirmandoUtiNps := (FieldByName('TMP_UTINPS').AsString = 'S');

        Next;

        Application.ProcessMessages;
      End;

      Result := True;
    End;

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fCarregaItensConfirmacaoCupomFiscal]');
    End;

  End;

  fatVenda.strIfCfNf := LeftStr(fatVenda.strIfCfNf, Length(fatVenda.strIfCfNf)-1);

  {*****************************************}
  {* SE OCORREU UM ERRO DURANTE O PROCES-  *}
  {* SAMENTO, SAI                          *}
  {**************************************MV*}
  If (Not Result) Then
    Exit;

  {*****************************************}
  {* PREENCHE A MATRIZ COM OS ITENS        *}
  {**************************************MV*}
  Try
    fatVenda.pPreencheMatrizFechamento;

    If (fatVenda.blnEndEntConfDoc) Then
    Begin
      blnDecidiuEndereco := False;
      Repeat
        If (Not fatVenda.fAlteraEnderecoEntrega(False, True, True, True, True)) Then
        Begin
          If fMensagem('', 'Nenhum Endereço de Entrega foi Informado, Continuar?', ['&Sim', '&Não']) = 1 Then
          Begin
            fatVenda.blnEndEntConfDoc := False;
            fatVenda.pLimparEnderecoEntrega;
            fatVenda.pEnderecoToFatVenda;
            blnDecidiuEndereco := True;
          End;
        End
        Else blnDecidiuEndereco := True;
      Until (blnDecidiuEndereco = True);
    End;

  Except
    On E: ExceptionAutCom Do
    Begin
      fMensagem('', E.Message, ['&O K']);
      Result := False;
      Exit;
    End;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmFatVendas.fCarregaItensConfirmacaoCupomFiscal]');
      Result := False;
      Exit;
    End;
  End;

  If fatVenda.fAtendeRegraFiscalEndEntrega Then
    fatVenda.pPreencheMatrizFechamento;

  {*****************************************}
  {* CALCULA TOTAL GERAL                   *}
  {**************************************MV*}
  fatVenda.pCalculaTotGer;

  FreeAndNil(qryGenIte);
  FreeAndNil(qryGenDet);

end;

function TConfirmacaoCupom.fGetQryConf: TUniQuery;
begin
  Result := fatVenda.qryTemporariaConfirmacao;
end;

function TConfirmacaoCupom.fGetSemCupons: Boolean;
begin
  Result := fatVenda.qryTemporariaConfirmacao.IsEmpty;
end;

function TConfirmacaoCupom.fMostraProdutosConfirmacao: Boolean;
  Var
    cdsItens : TUniClientDataSet;
    dtsGenDet: TDataSource;
    frmFatMostraProdConfirmacao : TfrmFatMostraProdConfirmacao;
begin
  cdsItens  := TUniClientDataSet.Create(Self);
  dtsGenDet := fCriaDataSource(cdsItens);

  {*****************************************}
  {* MOSTRA ITENS DA CONFIRMAÇÃO           *}
  {**************************************MV*}
  pCloneDataSet(cdsItens, cdsVenda);

  With cdsItens Do
  Begin
    (FieldByName('ITE_QTDITE') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ITE_UNITAR') As TFloatField).DisplayFormat := '#,####0.0000';
    (FieldByName('ITE_TOTITE') As TFloatField).DisplayFormat := '#,##0.00';
  End;

  Try
    pCriarFormularios(TfrmFatMostraProdConfirmacao, frmFatMostraProdConfirmacao);
    frmFatMostraProdConfirmacao.dbgItens.DataSource := dtsGenDet;
    frmFatMostraProdConfirmacao.edtTotSer.Text      := FormatFloat('#,##0.00', fatVenda.fltTotSer);
    frmFatMostraProdConfirmacao.edtTotGer.Text      := FormatFloat('#,##0.00', fatVenda.fltTotPro);
    frmFatMostraProdConfirmacao.edtDesEsp.Text      := FormatFloat('#,##0.00', fatVenda.fltDesEsp);
    frmFatMostraProdConfirmacao.edtTotLiq.Text      := FormatFloat('#,##0.00', fatVenda.fltTotPro - fatVenda.fltDesEsp +
                                                                               fatVenda.fltTotSer);
    frmFatMostraProdConfirmacao.pExibirNovosImpostos(fatVenda.fltTotCBS, fatVenda.fltTotIBS, fatVenda.fltTotIS);
    frmFatMostraProdConfirmacao.btnConfirma.Visible := True;
    frmFatMostraProdConfirmacao.Caption             := 'Itens da Confirmação de Documentos';
    frmFatMostraProdConfirmacao.showModal;

    Result := frmFatMostraProdConfirmacao.blnConfirma;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fCarregaItensConfirmacaoCupomFiscal]');
    End;
  End;

  pFreeAndNil(frmFatMostraProdConfirmacao);
  FreeAndNil(cdsItens);
end;

procedure TConfirmacaoCupom.pDeletaTemporariaConfirmacao;
begin

  If (Not fTabelaExiste(fatVenda.strTabelaConfMi)) Then
    Exit;

  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM ' + fatVenda.strTabelaConfMi);
    ExecSQL;
    Close;
  End;

end;

procedure TConfirmacaoCupom.pDestravarTodos;
begin
  fatVenda.objLock.pDestravarTodos;
end;

procedure TConfirmacaoCupom.pAtualizaTemporariaConfirmacao;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + fatVenda.strTabelaConfMi;

  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    (FieldByName('TMP_VLRCON') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('TMP_DUPREC') As TFloatField).DisplayFormat := '#,##0.00';
  End;

end;

procedure TConfirmacaoCupom.pCriaTemporariaConfirmacao;
  Var
    strSQL: String;
    strNotGer: String;
    strNumDoc: String;
    intQtdIte: Integer;
    fltDupRec: Double;
    strDocAnt: String;
    strEspAnt: String;
    strNumPdAnt: String;
    strEspPdAnt: String;
    strEmpPdAnt: String;

    blnTemCtr: Boolean;
    intContador: Integer;
    qryGenDet  : TUniQuery;
    qryGenGer  : TUniQuery;
    blnTemNps : Boolean;
begin

  qryGenDet := fCriaQuery(Self);
  qryGenGer := fCriaQuery(Self);

  pDeletaTemporariaConfirmacao;

  {*******************************************}
  {* PEGA TODOS OS CUPONS NÃO BAIXADOS       *}
  {****************************************MV*}
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  GER_NOTESP,';
  strSQL := strSQL + '  GER_NUMDOC, ';
  strSQL := strSQL + '  GER_SERIE_, ';
  strSQL := strSQL + '  GER_ESPDOC, ';
  strSQL := strSQL + '  GER_DTAENT, ';
  strSQL := strSQL + '  GER_JAFATU, ';
  strSQL := strSQL + '  GER_CODVEN, ';
  strSQL := strSQL + '  GER_CODCLI, ';
  strSQL := strSQL + '  GER_DESESP, ';
  strSQL := strSQL + '  GER_VLRCON, ';
  strSQL := strSQL + '  GER_ENTFAT, ';

  strSQL := strSQL + '  AUX_CODFAZ AS GER_CODFAZ, ';
  strSQL := strSQL + '  AUX_FASOBR AS GER_FASOBR, ';
  strSQL := strSQL + '  AUX_PLAVEI, ';
  strSQL := strSQL + '  AUX_KM_VEI, ';

  strSQL := strSQL + '  GER_CODS01, ';
  strSQL := strSQL + '  GER_CODS02, ';
  strSQL := strSQL + '  GER_CODS03, ';
  strSQL := strSQL + '  GER_CODS04, ';
  strSQL := strSQL + '  GER_CODS05, ';
  strSQL := strSQL + '  GER_CODS06, ';
  strSQL := strSQL + '  GER_CODS07, ';
  strSQL := strSQL + '  GER_CODS08, ';
  strSQL := strSQL + '  GER_CODS09, ';
  strSQL := strSQL + '  GER_CODS10, ';
  strSQL := strSQL + '  GER_CODS11, ';
  strSQL := strSQL + '  GER_CODS12, ';
  strSQL := strSQL + '  GER_CODS13, ';
  strSQL := strSQL + '  GER_CODS14, ';
  strSQL := strSQL + '  GER_CODS15, ';
  strSQL := strSQL + '  GER_CODS16, ';
  strSQL := strSQL + '  GER_CODS17, ';
  strSQL := strSQL + '  GER_CODS18, ';
  strSQL := strSQL + '  GER_CODS19, ';
  strSQL := strSQL + '  GER_CODS20, ';
  strSQL := strSQL + '  GER_CODS21, ';
  strSQL := strSQL + '  GER_CODS22, ';
  strSQL := strSQL + '  GER_CODS23, ';
  strSQL := strSQL + '  GER_CODS24, ';
  strSQL := strSQL + '  GER_CODS25, ';
  strSQL := strSQL + '  GER_CODS26, ';
  strSQL := strSQL + '  GER_CODS27, ';
  strSQL := strSQL + '  GER_CODS28, ';
  strSQL := strSQL + '  GER_CODS29, ';
  strSQL := strSQL + '  GER_CODS30, ';

  strSQL := strSQL + '  GER_DESS01, ';
  strSQL := strSQL + '  GER_DESS02, ';
  strSQL := strSQL + '  GER_DESS03, ';
  strSQL := strSQL + '  GER_DESS04, ';
  strSQL := strSQL + '  GER_DESS05, ';
  strSQL := strSQL + '  GER_DESS06, ';
  strSQL := strSQL + '  GER_DESS07, ';
  strSQL := strSQL + '  GER_DESS08, ';
  strSQL := strSQL + '  GER_DESS09, ';
  strSQL := strSQL + '  GER_DESS10, ';
  strSQL := strSQL + '  GER_DESS11, ';
  strSQL := strSQL + '  GER_DESS12, ';
  strSQL := strSQL + '  GER_DESS13, ';
  strSQL := strSQL + '  GER_DESS14, ';
  strSQL := strSQL + '  GER_DESS15, ';
  strSQL := strSQL + '  GER_DESS16, ';
  strSQL := strSQL + '  GER_DESS17, ';
  strSQL := strSQL + '  GER_DESS18, ';
  strSQL := strSQL + '  GER_DESS19, ';
  strSQL := strSQL + '  GER_DESS20, ';
  strSQL := strSQL + '  GER_DESS21, ';
  strSQL := strSQL + '  GER_DESS22, ';
  strSQL := strSQL + '  GER_DESS23, ';
  strSQL := strSQL + '  GER_DESS24, ';
  strSQL := strSQL + '  GER_DESS25, ';
  strSQL := strSQL + '  GER_DESS26, ';
  strSQL := strSQL + '  GER_DESS27, ';
  strSQL := strSQL + '  GER_DESS28, ';
  strSQL := strSQL + '  GER_DESS29, ';
  strSQL := strSQL + '  GER_DESS30, ';

  strSQL := strSQL + '  GER_QTDS01, ';
  strSQL := strSQL + '  GER_QTDS02, ';
  strSQL := strSQL + '  GER_QTDS03, ';
  strSQL := strSQL + '  GER_QTDS04, ';
  strSQL := strSQL + '  GER_QTDS05, ';
  strSQL := strSQL + '  GER_QTDS06, ';
  strSQL := strSQL + '  GER_QTDS07, ';
  strSQL := strSQL + '  GER_QTDS08, ';
  strSQL := strSQL + '  GER_QTDS09, ';
  strSQL := strSQL + '  GER_QTDS10, ';
  strSQL := strSQL + '  GER_QTDS11, ';
  strSQL := strSQL + '  GER_QTDS12, ';
  strSQL := strSQL + '  GER_QTDS13, ';
  strSQL := strSQL + '  GER_QTDS14, ';
  strSQL := strSQL + '  GER_QTDS15, ';
  strSQL := strSQL + '  GER_QTDS16, ';
  strSQL := strSQL + '  GER_QTDS17, ';
  strSQL := strSQL + '  GER_QTDS18, ';
  strSQL := strSQL + '  GER_QTDS19, ';
  strSQL := strSQL + '  GER_QTDS20, ';
  strSQL := strSQL + '  GER_QTDS21, ';
  strSQL := strSQL + '  GER_QTDS22, ';
  strSQL := strSQL + '  GER_QTDS23, ';
  strSQL := strSQL + '  GER_QTDS24, ';
  strSQL := strSQL + '  GER_QTDS25, ';
  strSQL := strSQL + '  GER_QTDS26, ';
  strSQL := strSQL + '  GER_QTDS27, ';
  strSQL := strSQL + '  GER_QTDS28, ';
  strSQL := strSQL + '  GER_QTDS29, ';
  strSQL := strSQL + '  GER_QTDS30, ';

  strSQL := strSQL + '  GER_UNIS01, ';
  strSQL := strSQL + '  GER_UNIS02, ';
  strSQL := strSQL + '  GER_UNIS03, ';
  strSQL := strSQL + '  GER_UNIS04, ';
  strSQL := strSQL + '  GER_UNIS05, ';
  strSQL := strSQL + '  GER_UNIS06, ';
  strSQL := strSQL + '  GER_UNIS07, ';
  strSQL := strSQL + '  GER_UNIS08, ';
  strSQL := strSQL + '  GER_UNIS09, ';
  strSQL := strSQL + '  GER_UNIS10, ';
  strSQL := strSQL + '  GER_UNIS11, ';
  strSQL := strSQL + '  GER_UNIS12, ';
  strSQL := strSQL + '  GER_UNIS13, ';
  strSQL := strSQL + '  GER_UNIS14, ';
  strSQL := strSQL + '  GER_UNIS15, ';
  strSQL := strSQL + '  GER_UNIS16, ';
  strSQL := strSQL + '  GER_UNIS17, ';
  strSQL := strSQL + '  GER_UNIS18, ';
  strSQL := strSQL + '  GER_UNIS19, ';
  strSQL := strSQL + '  GER_UNIS20, ';
  strSQL := strSQL + '  GER_UNIS21, ';
  strSQL := strSQL + '  GER_UNIS22, ';
  strSQL := strSQL + '  GER_UNIS23, ';
  strSQL := strSQL + '  GER_UNIS24, ';
  strSQL := strSQL + '  GER_UNIS25, ';
  strSQL := strSQL + '  GER_UNIS26, ';
  strSQL := strSQL + '  GER_UNIS27, ';
  strSQL := strSQL + '  GER_UNIS28, ';
  strSQL := strSQL + '  GER_UNIS29, ';
  strSQL := strSQL + '  GER_UNIS30, ';

  strSQL := strSQL + '  GER_VALS01, ';
  strSQL := strSQL + '  GER_VALS02, ';
  strSQL := strSQL + '  GER_VALS03, ';
  strSQL := strSQL + '  GER_VALS04, ';
  strSQL := strSQL + '  GER_VALS05, ';
  strSQL := strSQL + '  GER_VALS06, ';
  strSQL := strSQL + '  GER_VALS07, ';
  strSQL := strSQL + '  GER_VALS08, ';
  strSQL := strSQL + '  GER_VALS09, ';
  strSQL := strSQL + '  GER_VALS10, ';
  strSQL := strSQL + '  GER_VALS11, ';
  strSQL := strSQL + '  GER_VALS12, ';
  strSQL := strSQL + '  GER_VALS13, ';
  strSQL := strSQL + '  GER_VALS14, ';
  strSQL := strSQL + '  GER_VALS15, ';
  strSQL := strSQL + '  GER_VALS16, ';
  strSQL := strSQL + '  GER_VALS17, ';
  strSQL := strSQL + '  GER_VALS18, ';
  strSQL := strSQL + '  GER_VALS19, ';
  strSQL := strSQL + '  GER_VALS20, ';
  strSQL := strSQL + '  GER_VALS21, ';
  strSQL := strSQL + '  GER_VALS22, ';
  strSQL := strSQL + '  GER_VALS23, ';
  strSQL := strSQL + '  GER_VALS24, ';
  strSQL := strSQL + '  GER_VALS25, ';
  strSQL := strSQL + '  GER_VALS26, ';
  strSQL := strSQL + '  GER_VALS27, ';
  strSQL := strSQL + '  GER_VALS28, ';
  strSQL := strSQL + '  GER_VALS29, ';
  strSQL := strSQL + '  GER_VALS30, ';

  strSQL := strSQL + '  GER_BRIS01, ';
  strSQL := strSQL + '  GER_BRIS02, ';
  strSQL := strSQL + '  GER_BRIS03, ';
  strSQL := strSQL + '  GER_BRIS04, ';
  strSQL := strSQL + '  GER_BRIS05, ';
  strSQL := strSQL + '  GER_BRIS06, ';
  strSQL := strSQL + '  GER_BRIS07, ';
  strSQL := strSQL + '  GER_BRIS08, ';
  strSQL := strSQL + '  GER_BRIS09, ';
  strSQL := strSQL + '  GER_BRIS10, ';
  strSQL := strSQL + '  GER_BRIS11, ';
  strSQL := strSQL + '  GER_BRIS12, ';
  strSQL := strSQL + '  GER_BRIS13, ';
  strSQL := strSQL + '  GER_BRIS14, ';
  strSQL := strSQL + '  GER_BRIS15, ';
  strSQL := strSQL + '  GER_BRIS16, ';
  strSQL := strSQL + '  GER_BRIS17, ';
  strSQL := strSQL + '  GER_BRIS18, ';
  strSQL := strSQL + '  GER_BRIS19, ';
  strSQL := strSQL + '  GER_BRIS20, ';
  strSQL := strSQL + '  GER_BRIS21, ';
  strSQL := strSQL + '  GER_BRIS22, ';
  strSQL := strSQL + '  GER_BRIS23, ';
  strSQL := strSQL + '  GER_BRIS24, ';
  strSQL := strSQL + '  GER_BRIS25, ';
  strSQL := strSQL + '  GER_BRIS26, ';
  strSQL := strSQL + '  GER_BRIS27, ';
  strSQL := strSQL + '  GER_BRIS28, ';
  strSQL := strSQL + '  GER_BRIS29, ';
  strSQL := strSQL + '  GER_BRIS30, ';

  strSQL := strSQL + '  GER_PARS01, ';
  strSQL := strSQL + '  GER_PARS02, ';
  strSQL := strSQL + '  GER_PARS03, ';
  strSQL := strSQL + '  GER_PARS04, ';
  strSQL := strSQL + '  GER_PARS05, ';
  strSQL := strSQL + '  GER_PARS06, ';
  strSQL := strSQL + '  GER_PARS07, ';
  strSQL := strSQL + '  GER_PARS08, ';
  strSQL := strSQL + '  GER_PARS09, ';
  strSQL := strSQL + '  GER_PARS10, ';
  strSQL := strSQL + '  GER_PARS11, ';
  strSQL := strSQL + '  GER_PARS12, ';
  strSQL := strSQL + '  GER_PARS13, ';
  strSQL := strSQL + '  GER_PARS14, ';
  strSQL := strSQL + '  GER_PARS15, ';
  strSQL := strSQL + '  GER_PARS16, ';
  strSQL := strSQL + '  GER_PARS17, ';
  strSQL := strSQL + '  GER_PARS18, ';
  strSQL := strSQL + '  GER_PARS19, ';
  strSQL := strSQL + '  GER_PARS20, ';
  strSQL := strSQL + '  GER_PARS21, ';
  strSQL := strSQL + '  GER_PARS22, ';
  strSQL := strSQL + '  GER_PARS23, ';
  strSQL := strSQL + '  GER_PARS24, ';
  strSQL := strSQL + '  GER_PARS25, ';
  strSQL := strSQL + '  GER_PARS26, ';
  strSQL := strSQL + '  GER_PARS27, ';
  strSQL := strSQL + '  GER_PARS28, ';
  strSQL := strSQL + '  GER_PARS29, ';
  strSQL := strSQL + '  GER_PARS30, ';

  strSQL := strSQL + '  GER_TBRS01, ';
  strSQL := strSQL + '  GER_TBRS02, ';
  strSQL := strSQL + '  GER_TBRS03, ';
  strSQL := strSQL + '  GER_TBRS04, ';
  strSQL := strSQL + '  GER_TBRS05, ';
  strSQL := strSQL + '  GER_TBRS06, ';
  strSQL := strSQL + '  GER_TBRS07, ';
  strSQL := strSQL + '  GER_TBRS08, ';
  strSQL := strSQL + '  GER_TBRS09, ';
  strSQL := strSQL + '  GER_TBRS10, ';
  strSQL := strSQL + '  GER_TBRS11, ';
  strSQL := strSQL + '  GER_TBRS12, ';
  strSQL := strSQL + '  GER_TBRS13, ';
  strSQL := strSQL + '  GER_TBRS14, ';
  strSQL := strSQL + '  GER_TBRS15, ';
  strSQL := strSQL + '  GER_TBRS16, ';
  strSQL := strSQL + '  GER_TBRS17, ';
  strSQL := strSQL + '  GER_TBRS18, ';
  strSQL := strSQL + '  GER_TBRS19, ';
  strSQL := strSQL + '  GER_TBRS20, ';
  strSQL := strSQL + '  GER_TBRS21, ';
  strSQL := strSQL + '  GER_TBRS22, ';
  strSQL := strSQL + '  GER_TBRS23, ';
  strSQL := strSQL + '  GER_TBRS24, ';
  strSQL := strSQL + '  GER_TBRS25, ';
  strSQL := strSQL + '  GER_TBRS26, ';
  strSQL := strSQL + '  GER_TBRS27, ';
  strSQL := strSQL + '  GER_TBRS28, ';
  strSQL := strSQL + '  GER_TBRS29, ';
  strSQL := strSQL + '  GER_TBRS30, ';

  strSQL := strSQL + '  GER_VENS01, ';
  strSQL := strSQL + '  GER_VENS02, ';
  strSQL := strSQL + '  GER_VENS03, ';
  strSQL := strSQL + '  GER_VENS04, ';
  strSQL := strSQL + '  GER_VENS05, ';
  strSQL := strSQL + '  GER_VENS06, ';
  strSQL := strSQL + '  GER_VENS07, ';
  strSQL := strSQL + '  GER_VENS08, ';
  strSQL := strSQL + '  GER_VENS09, ';
  strSQL := strSQL + '  GER_VENS10, ';
  strSQL := strSQL + '  GER_VENS11, ';
  strSQL := strSQL + '  GER_VENS12, ';
  strSQL := strSQL + '  GER_VENS13, ';
  strSQL := strSQL + '  GER_VENS14, ';
  strSQL := strSQL + '  GER_VENS15, ';
  strSQL := strSQL + '  GER_VENS16, ';
  strSQL := strSQL + '  GER_VENS17, ';
  strSQL := strSQL + '  GER_VENS18, ';
  strSQL := strSQL + '  GER_VENS19, ';
  strSQL := strSQL + '  GER_VENS20, ';
  strSQL := strSQL + '  GER_VENS21, ';
  strSQL := strSQL + '  GER_VENS22, ';
  strSQL := strSQL + '  GER_VENS23, ';
  strSQL := strSQL + '  GER_VENS24, ';
  strSQL := strSQL + '  GER_VENS25, ';
  strSQL := strSQL + '  GER_VENS26, ';
  strSQL := strSQL + '  GER_VENS27, ';
  strSQL := strSQL + '  GER_VENS28, ';
  strSQL := strSQL + '  GER_VENS29, ';
  strSQL := strSQL + '  GER_VENS30, ';

  strSQL := strSQL + '  GER_VE2S01, ';
  strSQL := strSQL + '  GER_VE2S02, ';
  strSQL := strSQL + '  GER_VE2S03, ';
  strSQL := strSQL + '  GER_VE2S04, ';
  strSQL := strSQL + '  GER_VE2S05, ';
  strSQL := strSQL + '  GER_VE2S06, ';
  strSQL := strSQL + '  GER_VE2S07, ';
  strSQL := strSQL + '  GER_VE2S08, ';
  strSQL := strSQL + '  GER_VE2S09, ';
  strSQL := strSQL + '  GER_VE2S10, ';
  strSQL := strSQL + '  GER_VE2S11, ';
  strSQL := strSQL + '  GER_VE2S12, ';
  strSQL := strSQL + '  GER_VE2S13, ';
  strSQL := strSQL + '  GER_VE2S14, ';
  strSQL := strSQL + '  GER_VE2S15, ';
  strSQL := strSQL + '  GER_VE2S16, ';
  strSQL := strSQL + '  GER_VE2S17, ';
  strSQL := strSQL + '  GER_VE2S18, ';
  strSQL := strSQL + '  GER_VE2S19, ';
  strSQL := strSQL + '  GER_VE2S20, ';
  strSQL := strSQL + '  GER_VE2S21, ';
  strSQL := strSQL + '  GER_VE2S22, ';
  strSQL := strSQL + '  GER_VE2S23, ';
  strSQL := strSQL + '  GER_VE2S24, ';
  strSQL := strSQL + '  GER_VE2S25, ';
  strSQL := strSQL + '  GER_VE2S26, ';
  strSQL := strSQL + '  GER_VE2S27, ';
  strSQL := strSQL + '  GER_VE2S28, ';
  strSQL := strSQL + '  GER_VE2S29, ';
  strSQL := strSQL + '  GER_VE2S30, ';

  strSQL := strSQL + '  GER_MEN001, ';
  strSQL := strSQL + '  GER_MEN002, ';
  strSQL := strSQL + '  GER_TIPFRE, ';
  strSQL := strSQL + '  "MOVGER" AS GER_TABELA, ';
  strSQL := strSQL + '  G.AUTOINCREM AS GER_AUTINC, ';
  strSQL := strSQL + '  GER_CODCND, ';
  strSQL := strSQL + '  GER_CONPAG, ';
  strSQL := strSQL + '  GER_CODFPG, ';
  strSQL := strSQL + '  GER_CODEMP, ';
  strSQL := strSQL + '  IFNULL(AUX_VALCRE, 0) AS GER_VALCRE, ';
  strSQL := strSQL + '  AUX_DUPREC, ';
  strSQL := strSQL + '  IF(GER_IMPRES = 1, "S", "N") AS GER_IMPRES, ';
  strSQL := strSQL + '  AUX_VENPRE, ';
  strSQL := strSQL + '  AUX_EDIPES, ';
  strSQL := strSQL + '  GER_CLAFIS, ';
  strSQL := strSQL + '  GER_SERIE_, ';
  strSQL := strSQL + '  GER_CGCCON, ';
  strSQL := strSQL + '  AUX_CODEMB, ';
  strSQL := strSQL + '  FIS_ACESSO, ';
  strSQL := strSQL + '  GER_DESACE  ';
  strSQL := strSQL + 'FROM ';

  strSQL := strSQL + '  MOVGER G ';

  strSQL := strSQL + '  LEFT JOIN AUXMOV ON G.AUTOINCREM = AUX_SEQGER ';
  strSQL := strSQL + '  LEFT JOIN SERMOV ON G.AUTOINCREM = GER_SEQGER ';

  strSQL := strSQL + '  LEFT JOIN CADFIS ON FIS_NUMDOC = G.GER_NUMDOC AND ';
  strSQL := strSQL + '                      FIS_ESPDOC = G.GER_ESPDOC AND ';
  strSQL := strSQL + '                      FIS_CODEMP = G.GER_CODEMP AND ';
  strSQL := strSQL + '                      FIS_FORCLI = IF(FIS_TIP_FC = "C", G.GER_CODCLI, G.GER_CODFOR) AND ';
  strSQL := strSQL + '                      FIS_SERIE_ = G.GER_SERIE_     ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GER_NUMDOC NOT LIKE "F%" AND GER_JAFATU = 0 AND  ';

  If Not fEmptyStr(strNumeroCupom) Then
    strSQL := strSQL + '  GER_NUMDOC = :NUMCUP AND ';

  If Not fEmptyStr(strCodigoCliente) Then
    strSQL := strSQL + '  GER_CODCLI = :CODCLI AND ';

  If Not fEmptyStr(strEspecieCupom) Then
    strSQL := strSQL + '  GER_ESPDOC = :ESPCUP AND '
  Else
    strSQL := strSQL + '  GER_ESPDOC IN ("IF", "IV") AND ';

  If dtaDataFinal > 0 Then
    strSQL := strSQL + '  GER_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';

  If Not blnCarregarCupomEspecial Then
    strSQL := strSQL + '  GER_NOTESP <> "S" AND ';

  strSQL := strSQL + '  GER_CODEMP = :CODEMP ';

  strNotGer := AnsiReplaceStr(AnsiReplaceStr(
               AnsiReplaceStr(AnsiReplaceStr(
               AnsiReplaceStr(strSQL, 'AUXMOV'    , 'AUXNOT'),
                                      'SERMOV'    , 'SERNOT'),
                                      'MOVGER'    , 'NOTGER'),
                                      'AUX_DUPREC', 'GER_DUPREC'),
                                      'AUX_FASOBR', '""');

  For intContador := 1 To 30 Do
  Begin
    strNotGer := AnsiReplaceStr(strNotGer, 'GER_BRIS' + fStrZero(intContador, 2), '""');
    strNotGer := AnsiReplaceStr(strNotGer, 'GER_PARS' + fStrZero(intContador, 2), '""');
    strNotGer := AnsiReplaceStr(strNotGer, 'GER_TBRS' + fStrZero(intContador, 2), '""');
    strNotGer := AnsiReplaceStr(strNotGer, 'GER_VENS' + fStrZero(intContador, 2), '""');
    strNotGer := AnsiReplaceStr(strNotGer, 'GER_VE2S' + fStrZero(intContador, 2), '""');
  End;

  strSQL := strSQL + '  UNION ALL ' + strNotGer;

  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  GER_NUMDOC, GER_ESPDOC ';

  With qryGenGer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If Not fEmptyStr(strNumeroCupom) Then
      ParamByName('NUMCUP').AsString := strNumeroCupom;

    If Not fEmptyStr(strCodigoCliente) Then
      ParamByName('CODCLI').AsString := strCodigoCliente;

    If Not fEmptyStr(strEspecieCupom) Then
      ParamByName('ESPCUP').AsString := strEspecieCupom;

    If dtaDataFinal > 0 Then
    Begin
      ParamByName('DTAINI').AsDateTime := dtaDataInicial;
      ParamByName('DTAFIN').AsDateTime := dtaDataFinal;
    End;

    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  DET_NUMDOC, ';
  strSQL := strSQL + '  DET_ESPDOC, ';
  strSQL := strSQL + '  DET_CODCLI, ';
  strSQL := strSQL + '  DET_NUM_PD, ';
  strSQL := strSQL + '  DET_ESP_PD, ';
  strSQL := strSQL + '  DET_EMP_PD, ';
  strSQL := strSQL + '  DET_CODEMP ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET ';
  strSQL := strSQL + 'WHERE ';

  If Not fEmptyStr(strNumeroCupom) Then
    strSQL := strSQL + '  DET_NUMDOC = :NUMCUP AND ';

  If Not fEmptyStr(strCodigoCliente) Then
    strSQL := strSQL + '  DET_CODCLI = :CODCLI AND ';

  strSQL := strSQL + '  DET_PROEMB <> "S" AND ';
  strSQL := strSQL + '  DET_JAFATU = FALSE AND ';

  If Not fEmptyStr(strEspecieCupom) Then
    strSQL := strSQL + '  DET_ESPDOC = :ESPCUP AND '
  Else
    strSQL := strSQL + '  DET_ESPDOC IN ("IF", "IV") AND ';

  If dtaDataFinal > 0 Then
    strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';

  strSQL := strSQL + '  DET_CODEMP = :CODEMP ';

  strSQL := strSQL + ' UNION ALL ';

  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  DET_NUMDOC, ';
  strSQL := strSQL + '  DET_ESPDOC, ';
  strSQL := strSQL + '  DET_CODCLI, ';
  strSQL := strSQL + '  "" AS DET_NUM_PD, ';
  strSQL := strSQL + '  "" AS DET_ESP_PD, ';
  strSQL := strSQL + '  "" AS DET_EMP_PD, ';
  strSQL := strSQL + '  DET_CODEMP ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  NOTDET ';
  strSQL := strSQL + 'WHERE ';

  If Not fEmptyStr(strNumeroCupom) Then
    strSQL := strSQL + '  DET_NUMDOC = :NUMCUP AND ';

  If Not fEmptyStr(strCodigoCliente) Then
    strSQL := strSQL + '  DET_CODCLI = :CODCLI AND ';

  strSQL := strSQL + '  DET_PROEMB <> "S" AND ';
  strSQL := strSQL + '  DET_JAFATU = FALSE AND ';

  If Not fEmptyStr(strEspecieCupom) Then
    strSQL := strSQL + '  DET_ESPDOC = :ESPCUP AND '
  Else
    strSQL := strSQL + '  DET_ESPDOC IN ("IF", "IV") AND ';

  If dtaDataFinal > 0 Then
    strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';

  strSQL := strSQL + '  DET_CODEMP = :CODEMP ';

  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  DET_NUMDOC, DET_ESPDOC ';

  {*****************************************}
  {* MOVDET                                *}
  {**************************************MV*}
  With qryGenDet Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If Not fEmptyStr(strNumeroCupom) Then
      ParamByName('NUMCUP').AsString := strNumeroCupom;

    If Not fEmptyStr(strCodigoCliente) Then
      ParamByName('CODCLI').AsString := strCodigoCliente;

    If Not fEmptyStr(strEspecieCupom) Then
      ParamByName('ESPCUP').AsString := strEspecieCupom;

    If dtaDataFinal > 0 Then
    Begin
      ParamByName('DTAINI').AsDateTime := dtaDataInicial;
      ParamByName('DTAFIN').AsDateTime := dtaDataFinal;
    End;

    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;
  End;

  pAtualizaTemporariaConfirmacao;

//  fatVenda.strMen001 := qryGenGer.FieldByName('GER_MEN001').AsString;
//  fatVenda.strMen002 := qryGenGer.FieldByName('GER_MEN002').AsString;

  With qryGenGer Do
  Begin

    {*****************************************}
    {* PROCESSA MOVGER                       *}
    {**************************************MV*}
    While Not Eof Do
    Begin

      intQtdIte := 0;

      If (Not qryGenDet.Locate('DET_NUMDOC;DET_ESPDOC;DET_CODEMP',
        VarArrayOf([FieldByName('GER_NUMDOC').AsString, FieldByName('GER_ESPDOC').AsString,
                    FieldByName('GER_CODEMP').AsString]), [])) Then
      Begin
        Next;
        Continue;
      End;

      strDocAnt := qryGenDet.FieldByName('DET_NUMDOC').AsString;
      strEspAnt := qryGenDet.FieldByName('DET_ESPDOC').AsString;

      strNumPdAnt := qryGenDet.FieldByName('DET_NUM_PD').AsString;
      strEspPdAnt := qryGenDet.FieldByName('DET_ESP_PD').AsString;
      strEmpPdAnt := qryGenDet.FieldByName('DET_EMP_PD').AsString;

      {*****************************************}
      {* CALCULA QUANTIDADE DE ITENS NO DOC.   *}
      {**************************************MV*}
      While (Not qryGenDet.Eof)                                        And
            (qryGenDet.FieldByName('DET_NUMDOC').AsString = strDocAnt) And
            (qryGenDet.FieldByName('DET_ESPDOC').AsString = strEspAnt) Do
      Begin

        {*******************************************}
        {* VALIDAR AQUI PRODUTO EMBALAGEM (PROEMB) *}
        {****************************************MV*}
        //If proemb Then
        //  Continue;

        Inc(intQtdIte);
        qryGenDet.Next;
      End;

      blnTemCtr := fExisteCadRec(FieldByName('GER_NUMDOC').AsString,
                                 FieldByName('GER_ESPDOC').AsString,
                                 FieldByName('GER_CODEMP').AsString,
                                 FieldByName('GER_CODCLI').AsString);

      fltDupRec := fRetTotPag(FieldByName('GER_NUMDOC').AsString,
                              FieldByName('GER_ESPDOC').AsString,
                              FieldByName('GER_CODEMP').AsString,
                              FieldByName('GER_CODCLI').AsString,
                              FieldByName('GER_VLRCON').AsFloat,
                              FieldByName('AUX_DUPREC').AsFloat);

      {*******************************************************}
      { VERIFICA SE O DOCUMENTO ANTERIOR A CONFIRMACAO        }
      { JA ESTAVA BAIXADO, PARA QUE O TOTPAG NAO FIQUE ZERADO }
      { E CONTAS A RECEBER NAO SEJA GERADO NOVAMENTE          }
      {****************************************************JB*}
      If (fltDupRec = 0)            And
         (SameText(FieldByName('GER_TABELA').asString, 'NOTGER')) And
         (Not blnTemCtr)                                          Then
      Begin
        fltDupRec := fFormataFloat(FieldByName('GER_VLRCON').AsFloat,2);
      End;

      If (fFormataFloat(fltDupRec,2) = 0.00) And (Not fEmptyStr(strNumPdAnt)) Then
      Begin
        fltDupRec := fRetTotPag(strNumPdAnt,
                                strEspPdAnt,
                                strEmpPdAnt,
                                FieldByName('GER_CODCLI').AsString,
                                FieldByName('GER_VLRCON').AsFloat,
                                FieldByName('AUX_DUPREC').AsFloat);
      End;

      {*****************************************}
      {* INSERE REGISTRO NA TEMPORARIA         *}
      {**************************************MV*}
      fatVenda.qryTemporariaConfirmacao.Append;

      strNumDoc := FieldByName('GER_NUMDOC').AsString;
      strNumDoc := strNumDoc + IIF(FieldByName('GER_JAFATU').AsInteger = 1, 'q', '');

      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CGCCON').AsString   := FieldByName('GER_CGCCON').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_VALCRE').AsFloat    := FieldByName('GER_VALCRE').AsFloat;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NOTESP').AsString   := IIF(FieldByName('GER_NOTESP').AsString = 'S', 'S', 'N');
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DTAENT').AsDateTime := FieldByName('GER_DTAENT').AsDateTime;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString   := strNumDoc;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_SERDOC').AsString   := FieldByName('GER_SERIE_').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString   := FieldByName('GER_ESPDOC').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString   := VS_strCodEmp;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODVEN').AsString   := FieldByName('GER_CODVEN').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODCLI').AsString   := FieldByName('GER_CODCLI').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_VLRCON').AsFloat    := FieldByName('GER_VLRCON').AsFloat;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DESESP').AsFloat    := FieldByName('GER_DESESP').AsFloat;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ITEDOC').AsInteger  := intQtdIte;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DUPREC').AsFloat    := fltDupRec;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ENTRET').AsString   := IfThen(FieldByName('GER_ENTFAT').AsString = 'S', 'E', 'R');

      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODFAZ').AsString   := FieldByName('GER_CODFAZ').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_FASOBR').AsString   := FieldByName('GER_FASOBR').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_PLAVEI').AsString   := FieldByName('AUX_PLAVEI').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_KM_VEI').AsString   := FieldByName('AUX_KM_VEI').AsString;

      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DOCQUI').AsString   := IIF(FieldByName('GER_JAFATU').AsInteger = 1, 'S', 'N');
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString   := 'D';
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_TIPFRE').AsString   := FieldByName('GER_TIPFRE').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODCND').AsString   := FieldByName('GER_CODCND').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CONPAG').AsString   := FieldByName('GER_CONPAG').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODFPG').AsString   := FieldByName('GER_CODFPG').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NOMTAB').AsString   := FieldByName('GER_TABELA').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_AUTINC').AsString   := FieldByName('GER_AUTINC').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUM_PD').AsString   := strNumPdAnt;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESP_PD').AsString   := strEspPdAnt;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_EMP_PD').AsString   := strEmpPdAnt;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_VENPRE').AsString   := IfEmptyStr(FieldByName('AUX_VENPRE').AsString, 'N');

      If fCfgSis('UTINPS', varBoolean) Then
      Begin
        blnTemNps := TNetpoints.fTemCadNps(FieldByName('GER_NUMDOC').AsString,
                                           FieldByName('GER_ESPDOC').AsString,
                                           FieldByName('GER_CODEMP').AsString,
                                           FieldByName('GER_CODCLI').AsString,
                                           FieldByName('GER_SERIE_').AsString);

        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_UTINPS').AsString := IIF(blnTemNps, 'S', 'N');
      End
      Else
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_UTINPS').AsString := 'N';

      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_EDIPES').AsString   := FieldByName('AUX_EDIPES').AsString;

      For intContador := 1 To 30 Do
      Begin
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODS' + fStrZero(intContador, 2)).AsString := FieldByName('GER_CODS' + fStrZero(intContador, 2)).AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DESS' + fStrZero(intContador, 2)).AsString := FieldByName('GER_DESS' + fStrZero(intContador, 2)).AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_QTDS' + fStrZero(intContador, 2)).AsFloat  := FieldByName('GER_QTDS' + fStrZero(intContador, 2)).AsFloat;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_UNIS' + fStrZero(intContador, 2)).AsFloat  := FieldByName('GER_UNIS' + fStrZero(intContador, 2)).AsFloat;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_VALS' + fStrZero(intContador, 2)).AsFloat  := FieldByName('GER_VALS' + fStrZero(intContador, 2)).AsFloat;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_BRIS' + fStrZero(intContador, 2)).AsString := FieldByName('GER_BRIS' + fStrZero(intContador, 2)).AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_PARS' + fStrZero(intContador, 2)).AsString := FieldByName('GER_PARS' + fStrZero(intContador, 2)).AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_TBRS' + fStrZero(intContador, 2)).AsString := FieldByName('GER_TBRS' + fStrZero(intContador, 2)).AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_VENS' + fStrZero(intContador, 2)).AsString := FieldByName('GER_VENS' + fStrZero(intContador, 2)).AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_VE2S' + fStrZero(intContador, 2)).AsString := FieldByName('GER_VE2S' + fStrZero(intContador, 2)).AsString;
      End;

//      If Not fCupomTemMesmoValorCtr(FieldByName('GER_VLRCON').AsFloat,
//                                    FieldByName('GER_NUMDOC').AsString,
//                                    FieldByName('GER_ESPDOC').AsString,
//                                    VS_strCodEmp,
//                                    FieldByName('GER_CODCLI').AsString) Then
//        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_GCTRCI').AsString   := 'F'
//      Else
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_GCTRCI').AsString   := 'T';

      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_IMPRES').AsString  := FieldByName('GER_IMPRES').AsString;

      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_TEMCCR').AsString := 'N';
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_REC_PD').AsFloat  := FieldByName('AUX_DUPREC').AsFloat;

      If fCfgSis('USACCR', varBoolean) Then
      Begin
        If fDocumentoPossuiItemConcreto(FieldByName('GER_NUMDOC').AsString,
                                        FieldByName('GER_ESPDOC').AsString,
                                        FieldByName('GER_CODEMP').AsString) Then
        Begin
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_TEMCCR').AsString := 'S';
        End;
      End;

      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CLAFIS').AsString := FieldByName('GER_CLAFIS').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMB').AsString := FieldByName('AUX_CODEMB').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ACESSO').AsString := FieldByName('FIS_ACESSO').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DESACE').AsFloat  := FieldByName('GER_DESACE').AsFloat;

      fatVenda.qryTemporariaConfirmacao.Post;

      Next;

    End;
    fatVenda.qryTemporariaConfirmacao.First;

  End;

  qryGenGer.Close;

  FreeAndNil(qryGenDet);
  FreeAndNil(qryGenGer);

  pCalculaTotais;

end;

procedure TConfirmacaoCupom.pExibirProdutosDocumento;
  Var
    strSQL: String;
    fltTotGer: Double;
    fltDesEsp: Double;
    fltTotSer: Double;
    qryGenDet: TUniQuery;
    dtsGenDet: TDataSource;
    frmFatMostraProdConfirmacao : TfrmFatMostraProdConfirmacao;
begin
  qryGenDet := fCriaQuery(Self);
  dtsGenDet := fCriaDataSource(qryGenDet);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  DET_CODITE AS ITE_CODITE, ';
  strSQL := strSQL + '  DET_DESCRI AS ITE_DESITE, ';
  strSQL := strSQL + '  DET_UNIDAD AS ITE_UNIDAD, ';
  strSQL := strSQL + '  DET_QTDITE AS ITE_QTDITE, ';
  strSQL := strSQL + '  DET_UNITAR AS ITE_UNITAR, ';
  strSQL := strSQL + '  DET_TOTITE AS ITE_TOTITE, ';
  strSQL := strSQL + '  DET_DESESP AS ITE_DESESP, ';
  strSQL := strSQL + '  DET_CLAFIS AS ITE_CLAFIS ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET ';
  strSQL := strSQL + 'WHERE ';
  //strSQL := strSQL + '  (DET_NUMFAT IS NULL OR DET_TIPFAT = "") AND ';
  strSQL := strSQL + '  DET_PROEMB <> "S" AND ';
  strSQL := strSQL + '  DET_JAFATU = FALSE AND ';
  strSQL := strSQL + '  DET_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  DET_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  DET_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  DET_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  DET_CODITE <OPE> (:ITESER, :SERTER) ';

  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(strSQL, 'MOVDET', 'NOTDET');

  {*******************************************}
  {* TOTALIZA O SERVIÇO                      *}
  {****************************************MV*}
  With qryGenDet Do
  Begin
    Close;
    SQL.Clear;
    //SQL.Add(strSQL + ' AND DET_CODITE = :CODITE ');
    SQL.Add(AnsiReplaceStr(strSQL, '<OPE>', 'IN'));
    ParamByName('NUMDOC').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString;
    ParamByName('ESPDOC').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString;
    ParamByName('CODCLI').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODCLI').AsString;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('ITESER').AsString := fCfgSis('ITESER');
    ParamByName('SERTER').AsString := fCfgSis('SERTER');
    Open;

    fltTotGer := 0.0;
    fltDesEsp := 0.0;
    fltTotSer := 0.0;

    While Not Eof Do
    Begin
      fltTotSer := fltTotSer + FieldByName('ITE_TOTITE').AsFloat;
      Next;
    End;
    
  End;


  With qryGenDet Do
  Begin
    Close;
    SQL.Clear;
    //SQL.Add(strSQL + ' AND DET_CODITE <> :CODITE ');
    SQL.Add(AnsiReplaceStr(strSQL, '<OPE>', 'NOT IN'));
    ParamByName('NUMDOC').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString;
    ParamByName('ESPDOC').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString;
    ParamByName('CODCLI').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODCLI').AsString;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('ITESER').AsString := fCfgSis('ITESER');
    ParamByName('SERTER').AsString := fCfgSis('SERTER');
    Open;

    (FieldByName('ITE_QTDITE') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ITE_UNITAR') As TFloatField).DisplayFormat := '#,####0.0000';
    (FieldByName('ITE_TOTITE') As TFloatField).DisplayFormat := '#,##0.00';

    While Not Eof Do
    Begin
      fltTotGer := fltTotGer + FieldByName('ITE_TOTITE').AsFloat;
      fltDesEsp := fltDesEsp + FieldByName('ITE_DESESP').AsFloat;
      Next;
    End;

    First;

    Try
      pCriarFormularios(TfrmFatMostraProdConfirmacao, frmFatMostraProdConfirmacao);
      frmFatMostraProdConfirmacao.dbgItens.DataSource := dtsGenDet;
      frmFatMostraProdConfirmacao.edtTotSer.Text      := FormatFloat('#,##0.00', fltTotSer);
      frmFatMostraProdConfirmacao.edtTotGer.Text      := FormatFloat('#,##0.00', fltTotGer);
      frmFatMostraProdConfirmacao.edtDesEsp.Text      := FormatFloat('#,##0.00', fltDesEsp);
      frmFatMostraProdConfirmacao.edtTotLiq.Text      := FormatFloat('#,##0.00', fltTotGer - fltDesEsp + fltTotSer);
      frmFatMostraProdConfirmacao.Caption             := frmFatMostraProdConfirmacao.Caption + fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString + ' - ' +
                                                                                               fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString;
      frmFatMostraProdConfirmacao.showModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmFatConfCupomFiscal.pCarregaItensDocumento]');
      End;
    End;
    
    pFreeAndNil(frmFatMostraProdConfirmacao);

  End;

  FreeAndNil(dtsGenDet);
  FreeAndNil(qryGenDet);

end;

procedure TConfirmacaoCupom.pRetJurosDescontoSujerido(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: String; Var fltValAbe: Double);
  Var
    strSQL: String;
    qryGen: TUniquery;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE          ';
  strSQL := strSQL + '  SUM(CTR_VALDUP) AS VALDUP  ';
  strSQL := strSQL + 'FROM                         ';
  strSQL := strSQL + '  CADREC                     ';
  strSQL := strSQL + 'WHERE                        ';
  strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND   ';
  strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND   ';
  strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND   ';
  strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND   ';
  strSQL := strSQL + '  CTR_DTAREC IS NULL         ';

  qryGen := fCriaQuery;
  With qryGen Do
  Begin
    SQL.Text := strSQL;

    ParamByName('NUMDUP').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODCLI').AsString := strCodCli;
    ParamByName('CODEMP').AsString := strCodEmp;

    Open;

    fltValAbe := FieldByName('VALDUP').AsFloat;

    Close;
  End;
  FreeAndNil(qryGen);
end;

procedure TConfirmacaoCupom.pPegaPlacaAndKmVeiculo;
begin
  If fCfgSis('AUTCEN', varBoolean) Then
  Begin
    pAtualizaTemporariaConfirmacao;

    With fatVenda.qryTemporariaConfirmacao Do
    Begin
      First;

      fatVenda.strPlaVei := '';
      fatVenda.strKm_Vei := '';

      While (Not Eof) Do
      Begin
        If (FieldByName('TMP_MARDES').AsString = 'M') And fEmptyStr(fatVenda.strPlaVei) Then
        Begin
          fatVenda.strPlaVei := FieldByName('TMP_PLAVEI').AsString;
          fatVenda.strKm_Vei := FieldByName('TMP_KM_VEI').AsString;
          Break;
        End;

        Next;
      End;
    End;
  End;
end;

procedure TConfirmacaoCupom.pSetaClienteCupom(strCodCli: String);
begin
  fatVenda.strCodCli := strCodCli;
  fatVenda.strCliFat := strCodCli;
end;

procedure TConfirmacaoCupom.pDeletaCuponsDesmarcados;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;

begin
  Try

    qryGenTmp := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ' + fatVenda.strTabelaConfMi + ' ';
    strSQL := strSQL + 'WHERE TMP_MARDES <> "M" ';

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

procedure TConfirmacaoCupom.pMarcarTodosDocumentos(blnMarcar: Boolean; strEntRet: String);
  Var
    strInformacao: String;
begin
  inherited;

  If (Not Assigned(qryConfirmacao)) Or
     (Not qryConfirmacao.Active) Or
     (qryConfirmacao.RecordCount = 0) Then
  Begin
    If blnMarcar Then
      fMensagem('ATENÇÃO!', 'Não há documentos para marcar!', ['&OK']);
    Exit;
  End;

  If (blnMarcar) And (Not fEmptyStr(strEntRet)) And (Not fPodeMarcarEntregaRetira(qryConfirmacao, fatVenda.strTabelaConfMi, strEntRet)) Then
  Begin
    Exit;
  End;

  With qryConfirmacao Do
  Begin
    First;
    While Not Eof Do
    Begin

      If (blnMarcar) Then
      Begin
        If (FieldByName('TMP_MARDES').AsString <> 'M') And
           (fEmptyStr(strEntRet) Or ((Not fEmptyStr(strEntRet)) And (FieldByName('TMP_ENTRET').AsString = strEntRet))) Then
        Begin
          If fatVenda.fUltrapassouLimiteItensNFe(intQtdItensDocs + FieldByName('TMP_ITEDOC').AsInteger, '', strInformacao) Then
          Begin
            pMensagemSonora(strInformacao);
            Break;
          End
          Else
          Begin
            fMarcaDocumento(True);
          End;
        End;
      End
      Else
      Begin
        If (FieldByName('TMP_MARDES').AsString = 'M') And
           (fEmptyStr(strEntRet) Or ((Not fEmptyStr(strEntRet)) And (FieldByName('TMP_ENTRET').AsString = strEntRet))) Then
          fMarcaDocumento(False);
      End;

      Next;
    End;
    First;
  End;
end;

function TConfirmacaoCupom.fMarcaDocumento(blnMarcar: Boolean): Boolean;
  Var
    blnValidaConcr: Boolean;
    strInformacao: String;
    strChaLck: String;
    strVenPre: String;
    strUtiNps: String;
    blnValidaDuplicatasAgrupadas: Boolean;
begin
  Result := True;

  strChaLck := 'CADREC' +
               fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString +
               fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString +
               fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString +
               fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODCLI').AsString;

  If fCfgSis('USACCR', varBoolean) Then
  Begin
    blnValidaConcr := True;
    strTemConcr    := fatVenda.fRetConcretosDocMarcados;
  End
  Else
  Begin
    strTemConcr    := '';
    blnValidaConcr := False;
  End;

  If blnMarcar Then
  Begin
    {*****************************************}
    {* VERIFICA SE HÁ ALGUMA DUPLICATA TRAVA-*}
    {* DA NO RESUMO DE CAIXA.                *}
    {**************************************MV*}
    If Not fEmptyStr(fGetHostLock(strChaLck + '%')) Then
    Begin
      fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strChaLck + '%'), ['&Ok']);
      Result := False;
      Exit;
    End;

    With fatVenda.qryTemporariaConfirmacao Do
    Begin
      If fDupRecAlterado(FieldByName('TMP_NUMDOC').AsString,
                         FieldByName('TMP_ESPDOC').AsString,
                         FieldByName('TMP_CODEMP').AsString,
                         FieldByName('TMP_CODCLI').AsString,
                         FieldByName('TMP_VLRCON').AsFloat,
                         FieldByName('TMP_REC_PD').AsFloat) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'As parcelas do cupom selecionado sofreram alteração, por favor, faça uma nova consulta para atualizar os valores!', ['&OK']);
        Exit;
      End;
    End;

    if fDocumentoFaturado(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString,
                          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString,
                          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString,
                          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODCLI').AsString,
                          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NOMTAB').AsString) then
    begin
      Result := False;
      fMensagem('','O documento selecionado já encontra-se faturado, favor efetuar a consulta novamente para recarregar os documentos!', ['&OK']);
      Exit;
    end;

    If (fCfgSis('TRCLCC', varString) = 'D') And
       (Not fEmptyStr(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CGCCON').AsString)) And
       (strCodigoCliente <> strCodigoNovoCliente) Then
    Begin
      Result := False;
      fMensagem('','O sistema está configurado para permitir trocar o cliente na confirmação de cupom somente quando o documento '+
                   'não possui cpf/cnpj informado e o documento selecionado possui. Sendo assim, não será possível selecioná-lo para essa confirmação. [CFG_TRCLCC]', ['&OK']);
      Exit;
    End;

    if fCfgSis('USNFCE', varBoolean) then //utiliza nfc-e
    begin
      if SameText(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString, 'IF') then //somente IF executa a trava
      begin
        if SameText(fCfgSis('SERNFC'), fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_SERDOC').AsString) then //documento é da série corrente
        begin
          if fEmptyStr(fGetChaveAcesso(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString,
                                       fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString,
                                       strCodigoCliente,
                                       fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString,
                                       fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_SERDOC').AsString,
                                       'C',
                                       True)) then
          begin
            fMensagem('ATENÇÃO!', 'Documento ' + fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString + ' Nº: ' + fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString + ' Serie: ' + fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_SERDOC').AsString + ' ainda não foi autorizado pela SEFAZ.', ['&Ok']);
            Result := False;
            Exit;
          end;
        end;

        If fGetCampoDPECNFe(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString,
                            fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString,
                            fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString,
                            fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_SERDOC').AsString,
                            strCodigoCliente) > 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Documento '+ fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString +'-'+
                                fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString +'-'+
                                fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString +
                                ' foi autorizado em contingência.'+ sLineBreak +
                                'A confirmação somente será permitida quando ocorrer a autorização definitiva pela Sefaz. '+
                                'Aguarde até o serviço da Sefaz voltar a operar normalmente e tente novamente.', ['&Ok']);
          Result := False;
          Exit;
        End;
      end;
    end;

    With fatVenda.qryTemporariaConfirmacao Do
    Begin
      If (fTravaBoletoRemessa(FieldByName('TMP_NUMDOC').AsString,
                              FieldByName('TMP_ESPDOC').AsString,
                              FieldByName('TMP_CODEMP').AsString,
                              FieldByName('TMP_CODCLI').AsString)) Then
      Begin
        Result := False;
        Exit;
      End;

      strVenPre := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_VENPRE)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);

      If (Not fEmptyStr(strVenPre)) And (strVenPre <> (qryConfirmacao.FieldByName('TMP_VENPRE').AsString)) Then
      Begin
        Result := False;
        fMensagem('','Existem cupons com venda presencial e outros não, por isso não será possível selecionar este cupom fiscal!', ['&Ok']);
        Exit;
      End;

      strUtiNps := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_UTINPS)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);

      If (fCfgSis('UTINPS', varBoolean)) And (Not fEmptyStr(strUtiNps)) And (strUtiNps <> (qryConfirmacao.FieldByName('TMP_UTINPS').AsString)) Then
      Begin
        Result := False;
        fMensagem('','Existem cupons em que foi solicitado Netpoints e outros não, por isso não será possível selecionar este cupom fiscal!', ['&OK']);
        Exit;
      End;

      If Not fPodeMarcarEntregaRetira(qryConfirmacao, fatVenda.strTabelaConfMi) Then
      Begin
        Result := False;
        Exit;
      End;

      If fCfgSis('CADFAZ', varBoolean) And (strToIntDef(FQtdDocSel, 0) > 0) Then
      Begin
        FCodFaz := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_CODFAZ)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);

        If FCodFaz <> FieldByName('TMP_CODFAZ').AsString Then
        Begin
          fMensagem('','Não é possível selecionar documentos de Fazendas diferentes. ' + #13#10 +
                       'Já selecionado: (' + FCodFaz + ')' + #13#10 +
                       'Selecionando: (' + FieldByName('TMP_CODFAZ').AsString + ')', ['&Ok']);
          Exit;
        End;
      End;

      If blnMarcar And fCfgSis('CADEMB', varBoolean) And (strToIntDef(FQtdDocSel, 0) > 0) Then
      Begin
        FCodEmb := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_CODEMB)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);

        If (Pos(FieldByName('TMP_CODEMB').AsString, FCodEmb) <= 0)  Then
        Begin
          If not (fEmptyStr(FCodEmb) And fEmptyStr(FieldByName('TMP_CODEMB').AsString)) Then
          Begin
            fMensagem('','Não é possível selecionar documentos de Embarcações diferentes. ' + #13#10 +
                         'Já selecionado: (' + fRedCodEmb(AnsiReplaceStr(FCodEmb, ',', '')) + ')' + #13#10 +
                         'Selecionando: (' +   fRedCodEmb(FieldByName('TMP_CODEMB').AsString) + ')', ['&Ok']);
            Exit;
          End;
        End;
      End;
    End;

    If (Not fatVenda.objLock.fLock_Unlock(strChaLck, True, False)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strChaLck), ['&Ok']);
      Result := False;
      Exit;
    End;

    With fatVenda.qryTemporariaConfirmacao Do
    Begin
      blnValidaDuplicatasAgrupadas := fTemAgrupamento(FieldByName('TMP_NUMDOC').AsString,
                                                      FieldByName('TMP_ESPDOC').AsString,
                                                      FieldByName('TMP_CODEMP').AsString,
                                                      FieldByName('TMP_CODCLI').AsString);

      If (blnValidaDuplicatasAgrupadas) And
         (fCfgSis('PROCTR') = '1') Then
      Begin
        blnValidaDuplicatasAgrupadas := (blnValidaDuplicatasAgrupadas) And
                                        (Not fCfgSis('PRCFRA',varBoolean));
      End;

      If blnValidaDuplicatasAgrupadas Then
      Begin
        fMensagem('','O documento possui duplicatas agrupadas. Não pode ser confirmado!', ['&OK']);
        Result := False;
        fatVenda.objLock.fLock_Unlock(strChaLck, False);
      End

      Else If (Not fCfgSis('INFIEL', varBoolean)) And
              (Not fEmptyStr(strForSel)) And
              (Not SameText(strForSel, fRetFormaPagto)) Then
      Begin
        fMensagem('','Só é permitido selecionar documentos com a mesma forma e condição de pagamento!', ['&OK']);
        Result := False;
        fatVenda.objLock.fLock_Unlock(strChaLck, False);
      End

      Else If blnValidaConcr And (Not fEmptyStr(strTemConcr)) And (FieldByName('TMP_TEMCCR').AsString <> strTemConcr) Then
      Begin
        If strTemConcr = 'S' Then
          fMensagem('','Já existem documentos selecionados com produtos concreto, portanto não é possível selecionar documento com outro tipo de produtos!', ['&OK'])
        Else
          fMensagem('','Já existem documentos selecionados com produtos não concreto, portanto não é possível selecionar documento com concreto!', ['&OK']);

        Result := False;
        fatVenda.objLock.fLock_Unlock(strChaLck, False);
      End

      Else If (FieldByName('TMP_IMPRES').AsString <> 'S') Then
      Begin
        fMensagem('','Este cupom ainda não foi impresso, portanto não é possível confirmar o mesmo!', ['&OK']);
        Result := False;
        fatVenda.objLock.fLock_Unlock(strChaLck, False);
      End

      Else If fatVenda.fUltrapassouLimiteItensNFe(FItensDocs + FieldByName('TMP_ITEDOC').AsInteger, '', strInformacao) Then
      Begin
        pMensagemSonora(strInformacao);
        Result := False;
        fatVenda.objLock.fLock_Unlock(strChaLck, False);
      End

      Else If (fEmptyStr(strEspSel))                                                               Or
         (strEspSel = fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString)        Or
         (Pos(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString, 'TR_DV_') > 0) Or
         (Pos(strEspSel, 'TR_DV_') > 0)                                                            Then
      Begin

        If (fEmptyStr(strNotEsp))                                                                    Or
           (strNotEsp = fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NOTESP').AsString)        Then
        Begin
          If (Pos(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString, 'TR_DV_') <= 0) Then
            strEspSel := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString;

          strNotEsp := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NOTESP').AsString;

          strForSel := fRetFormaPagto;

          fatVenda.qryTemporariaConfirmacao.Edit;
          fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString := 'M';
          fatVenda.qryTemporariaConfirmacao.Post;

          If blnValidaConcr And fEmptyStr(strTemConcr) Then
            strTemConcr := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_TEMCCR').AsString;

          FCodFaz := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_CODFAZ)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);
          FCodEmb := fCampoTabela('GROUP_CONCAT(DISTINCT TMP_CODEMB)', fatVenda.strTabelaConfMi, ['TMP_MARDES'], ['M']);
        End

        Else
        Begin
          fMensagem('', 'Só é permitido selecionar documentos do mesmo tipo!', ['&Ok']);
          Result := False;
          fatVenda.objLock.fLock_Unlock(strChaLck, False);
        End;

      End
      Else
      Begin
        fMensagem('', 'Só é permitido selecionar documentos de mesma espécie!', ['&Ok']);
        Result := False;
        fatVenda.objLock.fLock_Unlock(strChaLck, False);
      End;
    End;
  End
  Else
  Begin
    fatVenda.objLock.fLock_Unlock(strChaLck, False);

    fatVenda.qryTemporariaConfirmacao.Edit;
    fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString := 'D';
    fatVenda.qryTemporariaConfirmacao.Post;
  End;

  pCalculaTotais;

  If (fEmptyStr(FQtdDocSel)) Or (StrToInt(FQtdDocSel) <= 0) Or (fStrToFloat(FTotGerSel) < 0) Then
  Begin
    strEspSel := '';
    strForSel := '';
    strNotEsp := '';
  End;

end;

procedure TConfirmacaoCupom.pCalculaTotais;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;

begin
  Try

    qryGenTmp := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS TOTDOC, ';
    strSQL := strSQL + '  SUM(TMP_VLRCON) AS TOTGER, ';
    strSQL := strSQL + '  SUM(TMP_DUPREC) AS TOTPAG ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + fatVenda.strTabelaConfMi;

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      FQtdDoc := FieldByName('TOTDOC').AsString;
      FTotGer := FormatFloat('#,##0.00', FieldByName('TOTGER').AsFloat);
      FDupPag := FormatFloat('#,##0.00', FieldByName('TOTPAG').AsFloat);
      FTotLiq := FormatFloat('#,##0.00', FieldByName('TOTGER').AsFloat - FieldByName('TOTPAG').AsFloat);

      Close;
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS TOTDOC, ';
    strSQL := strSQL + '  SUM(TMP_ITEDOC) AS ITEDOC, ';    
    strSQL := strSQL + '  SUM(TMP_VLRCON) AS TOTGER, ';
    strSQL := strSQL + '  SUM(TMP_DUPREC) AS TOTPAG ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + fatVenda.strTabelaConfMi + ' ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  TMP_MARDES = "M" ';

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      FQtdDocSel := FieldByName('TOTDOC').AsString;
      FItensDocs := FieldByName('ITEDOC').AsInteger;      
      FTotGerSel := FormatFloat('#,##0.00', FieldByName('TOTGER').AsFloat);
      FDupPagSel := FormatFloat('#,##0.00', FieldByName('TOTPAG').AsFloat);
      FTotLiqSel := FormatFloat('#,##0.00', FieldByName('TOTGER').AsFloat - FieldByName('TOTPAG').AsFloat);

      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

function TConfirmacaoCupom.fTemAgrupamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
  Var
    qryGenAgr: TUniQuery;

begin
  Try

    qryGenAgr := fCriaQuery;

    With qryGenAgr Do
    Begin
      SQL.Add('SELECT ');
      SQL.Add('  CTR_NUMDUP AS NUMDUP ');
      SQL.Add('FROM ');
      SQL.Add('  DUPAGR ');
      SQL.Add('WHERE ');
      SQL.Add('  CTR_NUMDUP = :NUMDOC AND ');
      SQL.Add('  CTR_ESPDOC = :ESPDOC AND ');
      SQL.Add('  CTR_CODEMP = :CODEMP AND ');
      SQL.Add('  CTR_CODCLI = :CODCLI ');

      ParamByName('NUMDOC').Value := strNumDoc;
      ParamByName('ESPDOC').Value := strEspDoc;
      ParamByName('CODEMP').Value := strCodEmp;
      ParamByName('CODCLI').Value := strCodCli;

      Open;

      Result := Not IsEmpty;

      Close;

    End;

  Finally
    FreeAndNil(qryGenAgr);
  End;
End;

function TConfirmacaoCupom.fTravaBoletoRemessa(strNumDup, strEspDoc, strCodEmp,
  strCodCli: String): Boolean;

  function fSQLCadRec(strNomTab: String): String;
  begin
    Result := '';
    Result := Result + ' SELECT CTR_NOSNUM, CTR_DTAENV ';
    Result := Result + '   FROM ' + strNomTab + ' ';
    Result := Result + '  WHERE CTR_NUMDUP = :NUMDUP ';
    Result := Result + '    AND CTR_ESPDOC = :ESPDOC ';
    Result := Result + '    AND CTR_CODCLI = :CODCLI ';
    Result := Result + '    AND CTR_CODEMP = :CODEMP ';
    Result := Result + '    AND CTR_DTAREC IS NULL   ';
  end;

  Var
    qryGenRec : TUniQuery;
    blnTrava  : Boolean;
    blnAvisa  : Boolean;
    strMensa  : String;
begin
  Result := False;

  If (fCfgSis('PROCTR') = '1') Then
    Exit;

  blnTrava := False;
  blnAvisa := False;

  qryGenRec := fCriaQuery(Self);

  With qryGenRec Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(fSQLCadRec('CADREC'));
    ParamByName('NUMDUP').AsString := strNumDup;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODCLI').AsString := strCodCli;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    If (RecordCount > 0) Then
    Begin
      First;
      While Not Eof Do
      Begin

        If (Not fEmptyStr(FieldByName('CTR_NOSNUM').AsString)) Then
        Begin
          // foi gerado o boleto
          blnAvisa := True;
        End;

        If (Not FieldByName('CTR_DTAENV').IsNull) Then
        Begin
          // foi enviado a remessa
          blnTrava := True;
          Break;
        End;

        Next;
      End;
    End;

    Close;

    If (blnTrava) Then
    Begin
      Result := True;
      
      strMensa := 'Este documento [%s] possui títulos encaminhados para remessa bancária.' + Chr(13) +
                  'Se necessário favor restaurar a remessa bancária pelo controle financeiro.' ;
      
      fMensagem('ATENÇÃO', Format(strMensa, [strNumDup + '-' + strEspDoc + '-' + strCodEmp]), ['&OK']);
    End
    Else If (blnAvisa) Then
    Begin
      strMensa := 'Já foi gerado boleto do documento [%s], porém o mesmo não foi enviado remessa para o banco.' + Chr(13) +
                  'O boleto não será mais válido. Deseja continuar?';

      Result := (fMensagem('ATENÇÃO', Format(strMensa, [strNumDup + '-' + strEspDoc + '-' + strCodEmp]), ['&Sim', '&Não'], 2) = 2);
    End
    Else
      Result := False;

  End;

  FreeAndNil(qryGenRec);
end;

Function TConfirmacaoCupom.fRetFormaPagto: String;
Begin
  With fatVenda.qryTemporariaConfirmacao Do
    Result := FieldByName('TMP_CODFPG').AsString +
              FieldByName('TMP_CODCND').AsString +
              FieldByName('TMP_CONPAG').AsString;
End;

function TConfirmacaoCupom.fRetTotPag(strNumDup, strEspDoc, strCodEmp,
  strCodCli: String; fltVlrCon, fltDupRecAnt: Double): Double;
  Var
    strSQL: String;
    qryGenRec : TUniQuery;
    fltDupRec,
    fltValAbe : Double;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  SUM(TOTPAG) AS TOTPAG ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '( ';

  strSQL := strSQL + '  SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '    SUM(IFNULL(CTR_VALREC,0) - IFNULL(CTR_VALJUR,0) - IFNULL(CTR_VALCOB,0) + IFNULL(CTR_VALDES,0)) AS TOTPAG ';
  strSQL := strSQL + '  FROM ';
  strSQL := strSQL + '   CADREC ';
  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '    CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '    CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '    CTR_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '    CTR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '    CTR_DTAREC IS NOT NULL ';

  strSQL := strSQL + '  UNION ALL ';

  strSQL := strSQL + '  SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '    SUM(IFNULL(CTR_VALDUP, 0) + IFNULL(CTR_VALDES, 0) - IFNULL(CTR_VALCOB, 0) + IFNULL(CTR_DESSUJ, 0) - IFNULL(CTR_JURSUJ, 0)) AS TOTPAG ';
  strSQL := strSQL + '  FROM ';
  strSQL := strSQL + '    DUPAGR ';
  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '    CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '    CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '    CTR_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '    CTR_CODEMP = :CODEMP ';

  strSQL := strSQL + ') AS TBL ';

  qryGenRec := fCriaQuery;

  {*****************************************}
  {* QUANTIDADE DE DUPLICATAS PAGAS        *}
  {**************************************MV*}
  qryGenRec.Close;
  qryGenRec.SQL.Clear;
  qryGenRec.SQL.Add(strSQL);
  qryGenRec.ParamByName('NUMDUP').AsString := strNumDup;
  qryGenRec.ParamByName('ESPDOC').AsString := strEspDoc;
  qryGenRec.ParamByName('CODCLI').AsString := strCodCli;
  qryGenRec.ParamByName('CODEMP').AsString := strCodEmp;
  qryGenRec.Open;

  fltValAbe := 0.00;
  fltDupRec := qryGenRec.FieldByName('TOTPAG').AsFloat;
  fltDupRec := fltDupRec + fltDupRecAnt;

  pRetJurosDescontoSujerido(strNumDup,
                            strEspDoc,
                            strCodEmp,
                            strCodCli,
                            fltValAbe);

  If fltDupRec > fltVlrCon Then
     fltDupRec := (fFormataFloat(fltVlrCon,2) - fFormataFloat(fltValAbe,2));

  Result := fltDupRec;

  qryGenRec.Close;

  FreeAndNil(qryGenRec);
end;

procedure TConfirmacaoCupom.pCarregaDadosDocumentoGeraStringCuponsConfirmados;
  Var
    strSQL: String;
    qryMsg: TUniQuery;

    procedure pCarregaMsg(strNumDoc, strCodEmp, strCodCli: String);
    begin
      qryMsg := fCriaQuery(Nil);
      With qryMsg Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT GER_MEN001,GER_MEN002 FROM MOVGER');
        SQL.Add(' WHERE GER_NUMDOC =:NUMDOC AND GER_ESPDOC IN ("IF", "IV") AND GER_CODEMP =:CODEMP AND GER_CODCLI = :CODCLI ');
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODCLI').AsString := strCodCli;
        Open;
        fatVenda.strMen001 := Fields[0].AsString;
        fatVenda.strMen002 := Fields[1].AsString;
        Close;
      End;
      FreeAndNil(qryMsg);
    end;

begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ' + fatVenda.strTabelaConfMi + '.*, ';
  strSQL := strSQL + '  FIS_NUMCOO, ';
  strSQL := strSQL + '  FIS_NUMSER ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + fatVenda.strTabelaConfMi + ' ';
  strSQL := strSQL + 'LEFT JOIN CADFIS ON FIS_NUMDOC = TMP_NUMDOC AND ';
  strSQL := strSQL + '                    FIS_ESPDOC = TMP_ESPDOC AND ';
  strSQL := strSQL + '                    FIS_CODEMP = TMP_CODEMP AND ';
  strSQL := strSQL + '                    FIS_FORCLI = TMP_CODCLI AND ';
  strSQL := strSQL + '                    FIS_SERIE_ = TMP_SERDOC AND ';
  strSQL := strSQL + '                    FIS_TIP_FC = "C" ';

  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    FCodCnd := FieldByName('TMP_CODCND').AsString;
    FConPag := FieldByName('TMP_CONPAG').AsString;
    FCodFpg := FieldByName('TMP_CODFPG').AsString;
    FTipFre := FieldByName('TMP_TIPFRE').AsString;
    FCodCli := FieldByName('TMP_CODCLI').AsString;
    FCodVen := FieldByName('TMP_CODVEN').AsString;
    FNomTab := FieldByName('TMP_NOMTAB').AsString;
    FAutInc := FieldByName('TMP_AUTINC').AsString;

    (FieldByName('TMP_VLRCON') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('TMP_DUPREC') As TFloatField).DisplayFormat := '#,##0.00';
  End;


  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    First;
    pCarregaMsg(FieldByName('TMP_NUMDOC').AsString,
                FieldByName('TMP_CODEMP').AsString,
                FieldByName('TMP_CODCLI').AsString);

    fatVenda.strCupCon     := '';
    fatVenda.strCupCha     := '';
    fatVenda.strCupConDev  := '';
    fatVenda.strCupConDta  := '';
    fatVenda.strDocsConfIF := '';
    fatVenda.fltCreCnf     := 0;

    While (Not Eof) Do
    Begin
      fatVenda.fltCreCnf     := fatVenda.fltCreCnf + FieldByName('TMP_VALCRE').AsFloat;

      fatVenda.strDocsConfIF := fatVenda.strDocsConfIF + FieldByName('TMP_NUMDOC').AsString + '-' +
                                                         FieldByName('TMP_ESPDOC').AsString + '-' +
                                                         FieldByName('TMP_CODEMP').AsString;


      fatVenda.strCupCon := fatVenda.strCupCon + FieldByName('TMP_NUMDOC').AsString + '-' +
                                                 FieldByName('TMP_ESPDOC').AsString + ' de ' +
                                                 DateToStr(FieldByName('TMP_DTAENT').AsDateTime) + ' ' +
                                                 iif( FieldByName('FIS_NUMCOO').AsString = '', '', ' COO:' + FieldByName('FIS_NUMCOO').AsString ) +
                                                 iif( FieldByName('FIS_NUMSER').AsString = '', '', ' N.SER: ' + fPadR(FieldByName('FIS_NUMSER').AsString, 20) );

      fatVenda.strCupCha := fatVenda.strCupCha + FieldByName('TMP_ACESSO').AsString;

      fatVenda.strCupConDev := fatVenda.strCupConDev + FieldByName('TMP_NUMDOC').AsString + '-' +
                                                       FieldByName('TMP_ESPDOC').AsString + ' ' +
                                                       iif( FieldByName('FIS_NUMCOO').AsString = '', '', ' COO:' + FieldByName('FIS_NUMCOO').AsString ) +
                                                       iif( FieldByName('FIS_NUMSER').AsString = '', '', ' N.SER: ' + fPadR(FieldByName('FIS_NUMSER').AsString, 20) );

      fatVenda.strCupConDta := fatVenda.strCupConDta + FieldByName('TMP_NUMDOC').AsString + '-' +
                                                       FieldByName('TMP_ESPDOC').AsString + ' ' +
                                                       FieldByName('TMP_DTAENT').AsString + ' ' +
                                                       iif( FieldByName('FIS_NUMSER').AsString = '', '', ' N.SER: ' + fPadR(FieldByName('FIS_NUMSER').AsString, 20) ) +
                                                       iif( FieldByName('FIS_NUMCOO').AsString = '', '', ' COO:' + FieldByName('FIS_NUMCOO').AsString );


      If (RecNO < RecordCount) Then
      Begin
        fatVenda.strCupCon := fatVenda.strCupCon + ',';
        fatVenda.strCupCha := fatVenda.strCupCha + ',';
        fatVenda.strCupConDev := fatVenda.strCupConDev + ',';
        fatVenda.strDocsConfIF := fatVenda.strDocsConfIF + ', ';
      End;

      Next;
    End;
  End;
end;

function TConfirmacaoCupom.fConfirmarCupomFiscalEmNota: Boolean;
  Var
    intContador: Integer;
    strMsgTmp  : String;
begin
  Result  := False;

  If (fStrToFloat(strTotalGeralSelecionados) < 0.0) Then
  Begin
    pMensagemOk('Não é possivel confirmar um valor negativo!');
    Exit;
  End;

  If fBloqueiaConfirmacaoOndeTodosDocumentosEstaoQuitados(fStrToFloat(strTotalLiquidoSelecionados)) Then
  Begin
    Exit;
  End;

  If fMensagem('', 'Confirmar Cupom Fiscal?', ['&Sim', '&Não']) = 2 Then
  Begin
    Exit;
  End;

  pDeletaCuponsDesmarcados;
  pCarregaDadosDocumentoGeraStringCuponsConfirmados;
  pPegaPlacaAndKmVeiculo;

  fatVenda.strEspDoc := 'NF';
  fatVenda.strOpcDoc := 'CI';

  fatVenda.strNotEspConf := strConfirmacaoCupomEspecial;

  fatVenda.strCliFat := strCodigoCliente;
  fatVenda.strCodCli := strCodigoCliente;

  fatVenda.pCarregaDadosClienteBaixa(strCodigoCliente);

  pCarregaDadosGravadosDoCliente(FNomTab, FAutInc);

  If fCfgSis('CADFAZ', VarBoolean) And Not fEmptyStr(FCodFaz) Then
  Begin
    fatVenda.fSelecionarFazendaCliente(FCodCli, FCodFaz);
  End;

  If fCfgSis('CADEMB', VarBoolean) And Not fEmptyStr(FCodEmb) Then
  Begin
    fatVenda.strCodEmbarcacao := FCodEmb;
  End;

  fatVenda.strCodCnd := strCodigoCondicaoPagamento;
  fatVenda.strCodFpg := strCodigoFormaPagamento;
  fatVenda.strConPag := strCondicaoPagamento;

  If (fatVenda.strCodFpg = '013') And (Not fCadRecCIQuitado(fatVenda.strTabelaConfMi, strMsgTmp))  Then
  Begin
    pMsgTravaConfCupomUtilizacaoCredito(strMsgTmp);
    Exit;
  End;

  fatVenda.pAtualizaInformacoesCondPagamento;

  If (fCfgSis('USADIG', varBoolean)) Then
  Begin
    fatVenda.strCodVen := strCodigoVendedor;
    fatVenda.strNomVen := fRetNomVendRep(strCodigoVendedor);
  End;

  If (fCfgSis('REPVEN', varBoolean)) Then
  Begin
    fatVenda.strCodVe2 := strCodigoVendedor2;
    fatVenda.strNomVe2 := fRetNomVendRep(strCodigoVendedor2);
  End;

  If Not fatVenda.fDadosCorretosParaClienteConsumidor(fatVenda.strEspDoc) Then
  Begin
    pMensagemOk('Não é permitido emitir Nota Fiscal sem preencher todos os dados do cliente.');
    Exit;
  End;

  If fCfgSis('CPFOBR', varBoolean) Then
  Begin
    While (fEmptyStr(fatVenda.strCliCgc)) Do
    Begin
      pMensagemOk('Cliente não possui CPF/CNPJ. Não será permitido emitir nota fiscal.');

      If (Not fClienteConsumidor(fatVenda.strCliOri)) Or (Not fatVenda.fInformaCnpj) Then
        Exit;
    End;

    While (fReplicatorStr(fatVenda.strCliCgc[1], Length(fatVenda.strCliCgc)) = fatVenda.strCliCgc) And (fatVenda.strCliEst <> 'EX') Do
    Begin
      pMensagemOk('O CPF/CNPJ do cliente não é válido para emitir nota fiscal.');

      If (Not fClienteConsumidor(fatVenda.strCliOri)) Or (Not fatVenda.fInformaCnpj) Then
        Exit;
    End;
  End;

  fatVenda.pPreencheMatrizFechamento;

  If Length(fatVenda.arrMatItens) = 0 Then
  Begin
    pMensagemOk('Não há nenhum produto para realizar a confirmação! Favor verificar.');
    Exit;
  End;

  fatVenda.pCalculaPesBruLiq;

  fatVenda.pCalculaTotGer(False, False);

  If fatVenda.fAplicaDescontoIcmsOrgaoPublicoNoDescontoEspecial Then
  Begin
    If (fatVenda.fltDesEsp <= 0.00) And (fatVenda.fltIcmOrg > 0) Then
      fatVenda.fltDesEsp := fatVenda.fltIcmOrg;
  End;

  fatVenda.pDestacaRetencoes;
  fatVenda.pRetemImpostosNoDescontoEspecial;

  fatVenda.pCalculaTotGer(False, False);

  If (Pos(fatVenda.strOpcDoc, 'CF_CI_') > 0) Then
  Begin
    fatVenda.fltDesEsp := 0.0;
    fatVenda.fltDupRec := 0.0;

    With fatVenda.qryTemporariaConfirmacao Do
    Begin

      First;

      fatVenda.fltDupRec := 0.0;
      fatVenda.fltDesEsp := 0.0;

      For intContador := 0 To Length(fatVenda.arrMatItens)-1 Do
      Begin
        If LeftStr(fatVenda.arrMatItens[intContador].strClaFis, 1) < '5' Then
        Begin
          fatVenda.fltDesEsp := fatVenda.fltDesEsp + fatVenda.arrMatItens[intContador].fltTotIte;
          fatVenda.fltDesSai := fatVenda.fltDesSai + fatVenda.arrMatItens[intContador].fltTotIte;
        End;
      End;

      While (Not Eof) Do
      Begin

        {**********************************************}
        {*         SOMA DUPLICATAS RECEBIDAS          *}
        {* QUANDO O DOC. FOI SINTETIZADO, NAO SOMA    *}
        {* A DUPREC PQ A DEVOL. NAO ESTARA MAIS       *}
        {* PRESENTE NA OPERACAO. A FF ESTA PRESENTE   *}
        {* POIS E NECESSARIO FATURALA, E ELA CARREGA  *}
        {* CONSIGO TODAS AS DEVOL. SINTETIZADAS.      *}
        {****************************************MV,JB*}
        If Not SameText(FieldByName('SAV_SINTET').AsString, 'S') Then
          fatVenda.fltDupRec := fatVenda.fltDupRec + FieldByName('TMP_DUPREC').AsFloat -
                                FieldByName('TMP_JURSUJ').AsFloat + FieldByName('TMP_DESSUJ').AsFloat;

        {*****************************************}
        {* SOMA DESCONTO ESPECIAL                *}
        {**************************************MV*}
        fatVenda.fltDesEsp := fatVenda.fltDesEsp + FieldByName('TMP_DESESP').AsFloat;

        Next;
      End;

    End;

    fatVenda.fltDesEsp := fatVenda.fltDesEsp + fatVenda.fltDesSai;

  End;

  fatVenda.pCalculaTotGer;

  fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

  If fCfgSis('CALVOL', varBoolean) Then
  Begin
    fatVenda.intQtdTra := Floor(fatVenda.fRetVolumes);
    If fCfgSis('SEPEXC', varBoolean) Then
    Begin
      fatVenda.intQtdTraSepExc  := Floor(fatVenda.fRetVolumesSepExc);
      fatVenda.intQtdTraSepNExc := (fatVenda.intQtdTra - fatVenda.intQtdTraSepExc);
    End;
  End;

  Try
    pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);
    frmFatDadosFiscais.fatVenda := fatVenda;
    frmFatDadosFiscais.showModal;
    Result := frmFatDadosFiscais.blnConfirma;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[btnConfirmaClick_DadosFiscais]');
    End;
  End;

  pFreeAndNil(frmFatDadosFiscais);

  If Not Result Then
    Exit;

  Repeat

  Until (fatVenda.fSolicitaDataHoraEntradaSaidaNotaFiscal);

  fatVenda.pCalculaTotalParaCadRec;

  fDigDuplic(fatVenda.arrDuplicata,
             fTiraCaracEspeciaisParenteses(fatVenda.strConPag), 0, fatVenda.fltTotCadRec,
             FAlse, False, False, VS_Date, False, fatVenda.fltImpFre, 'N', fCfgSis('DUPRED', varBoolean));
  fatVenda.pRateiaValores;

  If (fatVenda.fltTotIcm <= 0.0) Then
    fatVenda.fltAlqIcm := 0.0;

  If (fatVenda.fltTotIpi <= 0.0) Then
    fatVenda.fltAlqIpi := 0.0;

  If fCfgSis('COENRE', varBoolean) Then
    fatVenda.strEntFat := IIF(fatVenda.fTemItensEntrega, 'S', 'N');

  Try
    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.strChave := 'FATVENDAS';
    frmGravando.fExecutarAcao := fatVenda.fGravaArquivos;
    frmGravando.ShowModal;

    Result := frmGravando.blnConfirma;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'');
    End;
  End;

  pFreeAndNil(frmGravando);

  If Result Then
    pMensagemOk('Nota Fiscal (' + fatVenda.strNumDoc + '-' + fatVenda.strEspDoc + ') emitida com sucesso!');
end;

function TConfirmacaoCupom.fDupRecAlterado(strNumDup, strEspDoc, strCodEmp,
  strCodCli: String; fltVlrCon, fltDupRecAnt: Double): Boolean;
  Var
    blnTemCtr : Boolean;
    fltDupRec : Double;
begin
  blnTemCtr := fExisteCadRec(strNumDup,
                             strEspDoc,
                             strCodEmp,
                             strCodCli);

  fltDupRec := fRetTotPag(strNumDup,
                          strEspDoc,
                          strCodEmp,
                          strCodCli,
                          fltVlrCon,
                          fltDupRecAnt);

  If (fltDupRec = 0) And
     (SameText(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NOMTAB').AsString, 'NOTGER')) And
     (Not blnTemCtr) Then
    fltDupRec := fFormataFloat(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_VLRCON').AsFloat, 2);

  If (fFormataFloat(fltDupRec,2) = 0.00) And
     (Not fEmptyStr(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUM_PD').AsString)) Then
  Begin
    fltDupRec := fRetTotPag(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUM_PD').AsString,
                            fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESP_PD').AsString,
                            fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_EMP_PD').AsString,
                            strCodCli,
                            0,
                            0);
  End;

  Result := fFormataFloat(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DUPREC').AsFloat, 2) <>
            fFormataFloat(fltDupRec, 2);
end;

function TConfirmacaoCupom.fExisteCadRec(strNumDup, strEspDoc, strCodEmp,
  strCodCli: String): Boolean;
  Var
    qryGenRec : TUniQuery;
begin
  qryGenRec := fCriaQuery(Self);

  With qryGenRec Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add('  CTR_NUMDUP ');
    SQL.Add('FROM ');
    SQL.Add('  CADREC ');
    SQL.Add('WHERE ');
    SQL.Add('  CTR_NUMDUP = :NUMDUP AND ');
    SQL.Add('  CTR_ESPDOC = :ESPDOC AND ');
    SQL.Add('  CTR_CODCLI = :CODCLI AND ');
    SQL.Add('  CTR_CODEMP = :CODEMP     ');
    SQL.Add('ORDER BY ');
    SQL.Add('  CTR_NUMDUP, CTR_ESPDOC ');
    ParamByName('NUMDUP').AsString := strNumDup;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODCLI').AsString := strCodCli;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;
    Result := (Not IsEmpty);
    Close;
  End;

  FreeAndNil(qryGenRec);
end;

procedure TConfirmacaoCupom.pCarregaDadosGravadosDoCliente(strTabGer, strAutInc: String);
  Var
    strSql: String;
    qryGen: TUniQuery;
begin
  strSql := '';
  strSql := strSql + ' SELECT SQL_NO_CACHE ';
  strSql := strSql + '   GER_NOMCON, ';
  strSql := strSql + '   GER_ENDCON, ';
  strSql := strSql + '   GER_BAICON, ';
  strSql := strSql + '   GER_CEPCON, ';
  strSql := strSql + '   GER_CIDCON, ';
  strSql := strSql + '   GER_ESTCON, ';
  strSql := strSql + '   GER_TELCON, ';
  strSql := strSql + '   AUX_NASCON, ';
  strSql := strSql + '   GER_CGCCPF, ';
  strSql := strSql + '   GER_CGCCON, ';
  strSql := strSql + '   GER_IESCON, ';
  strSql := strSql + '   GER_R_GCON, ';
  strSql := strSql + '   GER_EMLCON  ';
  strSql := strSql + ' FROM ';
  strSql := strSql + '   ' + strTabGer;

  If strTabGer = 'MOVGER' Then
    strSql := strSql + '   INNER JOIN AUXMOV ON AUX_SEQGER = ' + strTabGer + '.AUTOINCREM '
  Else
    strSql := strSql + '   INNER JOIN AUXNOT ON AUX_SEQGER = ' + strTabGer + '.AUTOINCREM ';

  strSql := strSql + ' WHERE  ';
  strSql := strSql + '   AUTOINCREM = ' + QuotedStr(strAutInc);

  qryGen := fCriaQuery(Nil);

  With qryGen, SQL Do
  Begin
    Close;
    Clear;
    Add(strSql);
    Open;

    If Not IsEmpty Then
    Begin
      fatVenda.strCliNom := FieldByName('GER_NOMCON').AsString;
      fatVenda.strCliEnd := FieldByName('GER_ENDCON').AsString;
      fatVenda.strCliBai := FieldByName('GER_BAICON').AsString;
      fatVenda.strCliCep := FieldByName('GER_CEPCON').AsString;
      fatVenda.strCodCid := FieldByName('GER_CIDCON').AsString;
      fatVenda.strCliCid := fRetNomCidade(fatVenda.strCodCid);
      fatVenda.strCliEst := FieldByName('GER_ESTCON').AsString;
      fatVenda.strCliTel := FieldByName('GER_TELCON').AsString;
      fatVenda.dtaNasCon := FieldByName('AUX_NASCON').AsDateTime;
      fatVenda.intCgcCpf := FieldByName('GER_CGCCPF').AsInteger;
      fatVenda.strCliCgc := FieldByName('GER_CGCCON').AsString;
      fatVenda.strCliIes := FieldByName('GER_IESCON').AsString;
      fatVenda.strCli_Rg := FieldByName('GER_R_GCON').AsString;
      fatVenda.strCliEma := FieldByName('GER_EMLCON').AsString;
    End;

  End;

  FreeAndNil(qryGen);
end;

end.
