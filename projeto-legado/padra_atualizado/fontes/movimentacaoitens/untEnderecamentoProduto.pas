unit untEnderecamentoProduto;

interface

uses Classes, Windows, SysUtils, StrUtils, ComCtrls, untAtualizaOcorrenciasCRM,
      untTypesSistema, Data.DB, UniClientDataSet, untTNumeroSerie,
      System.MaskUtils,
      untZClient, untRastreamentoEnderecamento , uni, math, untPesqItem;

type
  TEndItem = record
    strNumDoc,
    strSerie,
    strSeqIte,
    strCodIte,
    strCodMar,
    strDesIte,
    strRefere,
    strCodUni,
    strCodFor,
    strCodEmp,
    strLocFis,
    strLocAnt,
    strLocSup,
    strSupAnt,
    strTamLcF,
    strTamLcS,
    strCodAmz,
    strAutDet, // Autoincremento do MOVDET da nota de entrada
    strAutDetSer: String; //Autoincremento do Movdet Origem da DETSER
    blnIteAca: Boolean;
    strEmpAca: String;
    strCodAca: String;
    fltQtdIte: Double;
    blnRemLoc: Boolean;
    blnRefugo: Boolean;
    strNumLote: String;
    blnEnderecado: Boolean;
    strAutInc: String;
    strAutEnd: String; //AutInc do item do documento original
    blnhouveTrocaDeArmazemLote: Boolean; {quando utiliza armazem, preciso saber houve a troca do armazem}
    blnTemLote: Boolean;
    strAutIncLotPre: String;
  end;

type
  TEndItens = Array Of TEndItem;

type
  {$M+}
  TSituacaoEnderecamento = (seAEnderecar, seAguardandoDevolucao, seAguardandoConferencia);

  TEnderecamentoProduto = class
    private
      strCFG_COFTRA: String;
      FCdsPacotes: TUniClientDataSet;
      FcdsConsulta: TUniClientDataSet;
      LItensRecalculos: TArray<String>;
      LEmpresas: TArray<String>;

      FAutIncLot: String;
      FstrNumLot: String;
      FstrItensBalanco: String;
      FCancelamento : Boolean;
      FItens : TEndItens;
      FSeqFgo: String;
      FDocume: TEndDocumento;
      objOcoCrm: TAtuOcoCrm;
      FobjListaNumSerie: TListaSeries;
      FobjRastreamento : TRastreamentoEnderecamento;
      FBaixaPedidoNaoSeraEntregue : Boolean;
      FRetornoRemessaOutEnt: Boolean;
      FPedidoDeEnderecamentoFulfillment : Boolean;

      blnCadLoc: Boolean;
      FblnRastreamentoIndustrial : boolean;
      qryPedidosQueDevemHabilitarReserva: TUniQuery;
      FcdsItens: TUniClientDataSet;

      blnResEstPenLotpre: Boolean;
      blnResLtp: Boolean;

      function fGetStrEnderecamento: String;
      procedure pSetAutIncPed(Value: String);
      procedure pSetStrEnderecamento(Value: String);
      function fGetMovGerAutoinc(strCodEmp, strNumDoc, strEspDoc, strSerie, strCodCli, strTip_FC: string): string;
      procedure pSetRecEnderecamento(Value: TEndDocumento);
      procedure pCarregarAutoIncremPedido;
      function fBaixaPcmDet(strNumPed, strCodEmp, strNumDoc, strEspDoc: String): Boolean;

      Procedure pAfterPostTodosLotes(dataSet: TDataSet);
      procedure pCarregaPedidosQueDevemHabilitarReserva;
      procedure pExcluirFatDor(strAutInc: String);
      procedure pAjustaCampoSeMudouArmazemLote(strAutInc: String);
      procedure pAtualizarNumeroLote;
      function fExisteLote: Boolean;
      procedure pGerarNumeroLote;
      function fTeveAlteracarArmazeLote(strAutIncFatDor: String): Boolean;

      procedure pReprocessarSaldoProduto(strCodEmp, strCodIte: String);
    procedure pCriaCdsPacotes;
    public
      SeqFatEnd: String;
      blnPerQpc : Boolean;
      blnUDEVME: Boolean;
      blnCofEnd: Boolean;
      blnNumSer : Boolean;
      FDevWms : Boolean;
      blnConDev : Boolean;
      blnCofDev : Boolean;
      cdsTodosLotes: TZClient;
      blnGerouTA: Boolean;
      procedure pSetIdEnd;
      function fCarregarItens(cdsItens: TUniClientDataSet): TEnderecamentoProduto;
      function fGerarLote: TEnderecamentoProduto;
      function fInserirLote: TEnderecamentoProduto;
      function fAtualizarLote: TEnderecamentoProduto;
      function fItemBalanco: Boolean;
      function fGerarLotes: TEnderecamentoProduto;

      function fItensEnderecados: String;
      function fTodosEnderecados: Boolean;
      function fGerarPedidoParaReservarEstoque(prgProgresso: TProgressBar = Nil): Boolean;
      procedure pGravaSeriesEnderecamento(ASeqDetSer, ASeqFdo, ASeqMovDet: String);
      function fGetSqlItensPedido: String;
      function fGetQtdItens: Integer;
      function fGetSqlLoteItens(blnSoNumLot: Boolean = False; blnTransi: Boolean = True): String;
      procedure pLimpar;
      procedure pAddItem(item: TEndItem); Overload;
      procedure pAddItem(strCodIte, strNumLot: String; fltQtdIte : Double; strCodAca: String = ''; strEmpAca: String = ''; blnProAca: Boolean = False; AStrAutIncLotPre: String = ''); Overload;
      function fApagaPedidoReservaEstoque: Boolean;
      function ReprocessaSaldos: Boolean;

      procedure pLiberarRefugos;
      procedure pAtualizaLocalizacaoItens;

      function fValidaCrossDocking(cdsConsulta: TUniClientDataSet): Boolean;
      function fQtdItens: Integer;

      procedure pGetEnderecamentoByGERELE(strAutoincremGERELE: String);

      Procedure pCarregaLotes;

      constructor Create(blnCancelamento : Boolean = False); reintroduce;
      procedure pAtualizasaldoSaldoDosPedidosQueDevemPassarAReservarEstoque;
      Destructor Destroy; reintroduce;

      function fAtualizaLocFisAcager: Boolean;
      function fEhProdutoAcabado(ACodIte: String): Boolean;
      function SoTemProdutoAcabado: Boolean;
      Procedure pAdicionarItemReservaLotPre(AStrAutIncLotPre: String; ACdsLotes: TUniClientDataSet; AFltQtdIte: Double; AStrCodIte: String);
      function fMarcaEnderecamentoFinalizado: Boolean;
      procedure pMarcaEnderecamentoFinalizado;
      function fConsulta(cdsConsulta: TUniClientDataSet): TEnderecamentoProduto;
      function fGravarFatEnd: TEnderecamentoProduto;
      function fGravarQuantidadeParcialEnderecamento: TEnderecamentoProduto;
      procedure pAtualizaDadosEcommerce(strCodIte: String; fltPesoIt, fltExpAlt, fltExpLar, fltExpPro : Double);
      function fSituacaoEnderecamento(srtAutoIncrem: String): TSituacaoEnderecamento;
    published
      property endDocumento: TEndDocumento read FDocume write pSetRecEnderecamento;
      property strDocumento: String read fGetStrEnderecamento write pSetStrEnderecamento;
      property strAutIncPed: String read FSeqFgo write pSetAutIncPed;
      property objListaNumSerie: TListaSeries read FobjListaNumSerie;
      property objRastreamento : TRastreamentoEnderecamento read FobjRastreamento write FobjRastreamento;
      property blnRastreamentoIndustrial : boolean read FblnRastreamentoIndustrial;
      property blnDevWms : boolean read FDevWms write FDevWms;
      property blnBaixaPedidoNaoSeraEntregue : Boolean read FBaixaPedidoNaoSeraEntregue write FBaixaPedidoNaoSeraEntregue;
      property blnRetornoRemessaOutEnt: Boolean read FRetornoRemessaOutEnt write FRetornoRemessaOutEnt;
      property blnPedidoDeEnderecamentoFulfillment : Boolean read FPedidoDeEnderecamentoFulfillment write FPedidoDeEnderecamentoFulfillment;
  end;
  {$M-}
  function fEhPedidoReservaEstoqueEnderecamento(strNumPed, strEspPed, strCodEmp: String): Boolean;

implementation

uses
  Forms,
  untFuncoesSimples, untFuncoesCRM, untFatGor, untCadLote, untGarant,
     untMostraFaltaCrossdocking, untTypesCRM, untProdAcabado, untTFatEnd;

{ TEnderecamentoProduto }

constructor TEnderecamentoProduto.Create(blnCancelamento : Boolean);
begin
  inherited Create;
  blnCofDev := False;
  strCFG_COFTRA := fCfgSis('COFTRA');
  blnPerQpc := fCfgSis('PERQPC', varBoolean);
  blnUDEVME := (fCfgSis('UDEVME', varBoolean));
  blnCOFEND := (fCfgSis('COFEND', varBoolean)) And (fCfgSis('TIPPNT', varString) = 'D');
  blnConDev := fCfgSis('CONDEV', varBoolean);
  FBaixaPedidoNaoSeraEntregue := False;
  FPedidoDeEnderecamentoFulfillment := False;
  FRetornoRemessaOutEnt := False;

  qryPedidosQueDevemHabilitarReserva := fCriaQuery;
  FCancelamento := blnCancelamento;
  FobjListaNumSerie := TListaSeries.Create;
  FobjRastreamento := TRastreamentoEnderecamento.Create;
  blnNumSer := fCfgSis('NUMSER', varBoolean);
  FDevWms := False;
  pLimpar;

  blnCadLoc := fCfgSis('CADLOC', varBoolean);
  FblnRastreamentoIndustrial := fCfgSis('RASIND', varInteger) = 2;

  cdsTodosLotes := TZClient.Create(Nil);
  blnResLtp := fCfgSis('RESLTP', varBoolean);

  If blnPerQpc Then
    pCriaCdsPacotes;
end;

Destructor TEnderecamentoProduto.Destroy;
Begin
  FreeAndNil(FobjListaNumSerie);
  FreeAndNil(qryPedidosQueDevemHabilitarReserva);
  FreeAndNil(FobjRastreamento);
  FreeAndNil(cdsTodosLotes);
  If blnPerQpc Then
    FreeAndNil(FCdsPacotes);
  inherited;
End;


procedure TEnderecamentoProduto.pAddItem(item: TEndItem);
begin
  SetLength(FItens, Length(FItens) + 1);
  FItens[Length(FItens) -1] := item;
end;

procedure TEnderecamentoProduto.pAddItem(strCodIte, strNumLot: String; fltQtdIte : Double; strCodAca: String = '';
   strEmpAca: String = ''; blnProAca: Boolean = False; AStrAutIncLotPre: String = '');
  Var
    item: TEndItem;
    qryCadIte : TUniQuery;
begin
  Try
    qryCadIte := fCriaQuery();
    With qryCadIte, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT ITE_CODMAR,         ');
      Add('        ITE_DESITE,         ');
      Add('        ITE_REFERE,         ');
      Add('        ITE_CODUNI,         ');
      Add('        ITE_CODFOR          ');
      Add(' FROM CADITE                ');
      Add(' WHERE ITE_CODITE = :CODITE ');

      ParamByName('CODITE').AsString := strCodIte;
      Open;

      Item.strCodIte := strCodIte;
      Item.strCodMar := FieldByName('ITE_CODMAR').AsString;
      Item.strDesIte := FieldByName('ITE_DESITE').AsString;
      Item.strRefere := FieldByName('ITE_REFERE').AsString;
      Item.strCodUni := FieldByName('ITE_CODUNI').AsString;
      Item.strCodFor := FieldByName('ITE_CODFOR').AsString;
      Item.fltQtdIte := fltQtdIte;
      Item.strCodAmz := strNumLot;
      Item.blnRefugo := False;

      Item.blnIteAca := False;
      Item.strCodAca := '';
      Item.strEmpAca := '';

      If blnProAca Then
      Begin
        Item.blnIteAca := blnProAca;
        Item.strCodAca := strCodAca;
        Item.strEmpAca := strEmpAca;
      End;

      Item.strAutIncLotPre := AStrAutIncLotPre;

      pAddItem(Item);

    End;
  Finally
    FreeAndNil(qryCadIte);
  End;
end;


procedure TEnderecamentoProduto.pLiberarRefugos;
  var
    qryGen: TUniQuery;
    qryRef: TUniQuery;
    strSQL: String;

    strNumPedVen : String;
    strCodCliPed : String;
    strCodOpe    : String;
    strAutIncPed : String;
    recServicos  : TDadosServicos;
    objGarant    : TMovGag;
    strAutIncPedDet : String;
    strIncGau : String;
    arrDuplic : TarrDuplicata;
    strItensEnderecados: String;
begin
  FillChar(recServicos, SizeOf(recServicos), #0);
  strItensEnderecados := fItensEnderecados;

  If fEmptyStr(strItensEnderecados) Then
    Exit;

  Try
    qryGen := fCriaQuery(nil);
    qryRef := fCriaQuery(nil);

    If (fCfgSis('REFENT', varBoolean) And (not fCfgSis('GARMAT', varBoolean))) Or
        fCfgSis('GARMAT', varBoolean) And fCfgSis('REFENT', varBoolean, fCfgSis('EMPGAR', varString)) And (fCfgSis('EMPGAR', varString) = VS_strCodEmp ) Then
    Begin

      With qryGen, SQL Do
      Begin
        Close;
        Clear;

        Add('SELECT DET_CODITE,                                                          ');
        Add('       ITE_CODMAR,                                                          ');
        Add('       ITE_DESITE,                                                          ');
        Add('       ITE_REFERE,                                                          ');
        Add('       ITE_CODUNI,                                                          ');
        Add('       ITE_CODFOR,                                                          ');
        Add('       DET_QTDITE,                                                          ');
        Add('       SEQGAR.*                                                             ');
        Add('                                                                            ');
        Add('FROM FATDOR                                                                 ');
        Add('  INNER JOIN FATGOR G ON G.AUTOINCREM = FDO_SEQGER                          ');
        Add('  INNER JOIN EXTGOR E ON E.FGO_SEQFGO = G.AUTOINCREM                        ');
        Add(' INNER JOIN MOVDET D ON D.DET_NUMDOC  = SUBSTRING(FGO_DOCEND, 01, 12)       ');
        Add('                     AND D.DET_ESPDOC = SUBSTRING(FGO_DOCEND, 13, 02)       ');
        Add('                     AND D.DET_SERIE_ = TRIM(SUBSTRING(FGO_DOCEND, 15, 03)) ');
        Add('                     AND D.DET_CODITE = FDO_CODITE                          ');
        Add('  INNER JOIN SEQGAR ON SEQ_DET_TE = D.AUTOINCREM                            ');
        Add('  INNER JOIN CADITE ON ITE_CODITE = DET_CODITE                              ');
        Add('WHERE FATDOR.AUTOINCREM IN (' + strItensEnderecados + ')'                    );
        Open;

        If not IsEmpty Then
        Begin
          strNumPedVen := fRetSequencialPedido;
          strCodCliPed := fRetornaClienteFilial(VS_strCodEmp);
          strCodOpe    := strLoginUsuarioLogado;
          FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

          If fGravaFatGor(strAutIncPed,
                          VS_strCodEmp,
                          strNumPedVen,
                          'PD',
                          strCodCliPed,
                          strCodOpe,
                          '',
                          '',
                          VS_Date,
                          fTime(),
                          '01000',
                          fRetNomCidade(fRetNomGeral('CLI_CODCID', 'CLI_CODCLI', 'CADCLI', fStrToFloat(strCodCliPed)) ,1),
                          '',
                          '',
                          '',
                          '',
                          '',
                          '',
                          '',
                          '',
                          0,
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
                          0,
                          0,
                          0,
                          0,
                          0,
                          0,
                          0,
                          0,
                          '',
                          0,
                          0,
                          0,
                          0,
                          0,
                          0,
                          0,
                          0,
                          0,
                          0,
                          0,
                          0,
                          0,
                          0,
                          0,
                          0,
                          0,
                          arrDuplic,
                          '',
                          '',
                          'GARANTIA',
                          '',
                          False,
                          '',
                          '',
                          '',
                          0,
                          '',
                          '',
                          0.0,
                          0,
                          strCodOpe,
                          '',
                          '',
                          recServicos,
                          '',
                          0,
                          0,
                          0,
                          '',
                          '',
                          '',
                          0,
                          '',
                          0,
                          '1',
                          '',
                          0,
                          '',
                          '',
                          False,
                          '',
                          '',
                          '',
                          '',
                          '',
                          '',
                          '',
                          False,
                          VS_Date,
                          'N',
                          'V',
                          VS_Date,
                          '',
                          0,
                          '',
                          '',
                          '',
                          False,
                          '',
                          Nil,
                          '',
                          '',
                          0,
                          0,
                          0,
                          '',
                          Nil,
                          '',
                          0,
                          0,
                          '',
                          '',
                          0,
                          '',
                          0,
                          '',
                          '0',
                          'N',
                          'N') Then
          Begin
            While (Not Eof) Do
            Begin
              strAutIncPedDet := '';
              If fGravaFatDor(strAutIncPedDet,
                              strAutIncPed,
                              VS_strCodEmp,
                              strCodCliPed,
                              strCodOpe,
                              FieldByName('DET_CODITE').AsString,
                              FieldByName('ITE_CODMAR').AsString,
                              '',
                              strNumPedVen,
                              'PD',
                              '',
                              VS_Date,
                              fTime(),
                              '01000',
                              '',
                              FieldByName('ITE_DESITE').AsString,
                              FieldByName('ITE_REFERE').AsString,
                              FieldByName('ITE_CODUNI').AsString,
                              FieldByName('ITE_CODFOR').AsString,
                              FieldByName('DET_QTDITE').AsFloat,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              fRetCodRepresCliente(fRetornaClienteFilial(VS_strCodEmp)),
                              '',
                              0,
                              0,
                              0,
                              '5999',
                              '',
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              False,
                              '',
                              '',
                              '',
                              0,
                              '',
                              '',
                              0.0,
                              'NOR',
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              0,
                              0,
                              '',
                              0,
                              0,
                              0,
                              '',
                              '',
                              0,
                              '',
                              '',
                              0.0,
                              0,
                              0,
                              0,
                              '',
                              0,
                              '',
                              '',
                              False,
                              '1',
                              '',
                              '',
                              '',
                              0,
                              '',
                              0,
                              '',
                              '',
                              'N',
                              '',
                              0,
                              0,
                              0,
                              0,
                              '',
                              '',
                              '',
                              False,
                              '',
                              '',
                              '',
                              '',
                              '',
                              '',
                              0,
                              0,
                              '',
                              '',
                              0,
                              '',
                              '',
                              0,
                              0,
                              0) Then
              Begin
                Try
                  objGarant := TMovGag.Create(Nil);
                  objGarant.objMovGad.fAtualizaSeqGarantia('SEQ_FATDOR', strAutIncPedDet, 'SEQ_PCMDET', FieldByName('SEQ_PCMDET').AsString);
                Except
                  On E : Exception Do
                    pMensagensErro(e.message,'');

                End;

                FreeAndNil(objGarant);

              End;

              Next;
            End;
          End;
        End;
      End;

      //se é conferencia apos a entrada entao não foi gravado os registros de retorno do fornecedor
      //precisa atualizar as qtdes retornadas e gravar a MOVGAU.
      // SE A CONFERENCIA FOR ANTES, A MOVGAU EH GRAVADO NA ENTRADA, NO ENDEREÇAMENTO PRECISA LIBERAR APENAS O REFUGO;
      With qryGen, SQL Do
      Begin
        Close;
        Clear;
        Add(' SELECT MOVGAE.*,                                                 ');
        Add('        GAD_CODITE,                                               ');
        Add('        SUBSTRING(FGO_DOCEND, 1, 12) AS DOCENT,                   ');
        Add('        SUBSTRING(FGO_DOCEND, 13, 2) AS ESPENT,                   ');
        Add('        SUBSTRING(FGO_DOCEND, 15, 3) AS SERENT,                   ');
        Add('        SUBSTRING(FGO_DOCEND, 18, 3) AS EMPENT,                   ');
        Add('        MOVDET.AUTOINCREM AS INCDET,                              ');
        Add('        MOVGAD.AUTOINCREM AS INCGAD                               ');

        Add(' FROM EXTGOR                                                      ');
        Add('   INNER JOIN GERELE ON GER_DOCENT = SUBSTRING(FGO_DOCEND, 1, 12) ');
        Add('                    AND GER_ESPENT = SUBSTRING(FGO_DOCEND, 13, 2) ');
        Add('                    AND B07_SERIE  = SUBSTRING(FGO_DOCEND, 15, 3) ');
        Add('                    AND GER_EMPENT = SUBSTRING(FGO_DOCEND, 18, 3) ');

        Add('   INNER JOIN PEDELE ON PEL_SEQELE = GERELE.AUTOINCREM            ');

        Add('   INNER JOIN PCMDET ON PCD_NUMPED = PEL_NUMDOC                   ');
        Add('                    AND PCD_ESPDOC = PEL_ESPDOC                   ');
        Add('                    AND PCD_CODEMP = PEL_CODEMP                   ');
        Add('                    AND PCD_CODFOR = PEL_CODFOR                   ');

        Add('   INNER JOIN MOVGAE ON GAE_NUMENV = SUBSTRING(PCD_DOCORI,1,12)   ');
        Add('                    AND GAE_ESPENV = SUBSTRING(PCD_DOCORI,13,2)   ');
        Add('                     AND GAE_DTAENV = PCD_DTAPED                  ');
        Add('                     AND GAE_EMPENV = PCD_CODEMP                  ');
        Add('   INNER JOIN MOVGAD ON MOVGAD.AUTOINCREM = GAE_SEQGAD            ');
        Add('                    AND GAD_CODITE = PCD_CODITE                   ');

        Add('   INNER JOIN MOVDET ON DET_NUMDOC = SUBSTRING(FGO_DOCEND, 1, 12) ');
        Add('                    AND DET_ESPDOC = SUBSTRING(FGO_DOCEND, 13, 2) ');
        Add('                    AND DET_SERIE_ = SUBSTRING(FGO_DOCEND, 15, 3) ');
        Add('                    AND DET_CODEMP = SUBSTRING(FGO_DOCEND, 18, 3) ');
        Add('                    AND DET_CODITE = PCD_CODITE                   ');

        Add('   INNER JOIN FATDOR ON FATDOR.FDO_SEQGER = EXTGOR.FGO_SEQFGO');
        Add('   AND FATDOR.FDO_CODITE = MOVDET.DET_CODITE ');
        Add('WHERE FATDOR.AUTOINCREM IN (' + strItensEnderecados + ')');
        Add('   AND ((GAE_RETCON > 0) OR (GAE_REFCON > 0)) ');

        Open;

      End;

      //Grava MovGau
      With qryRef, SQL Do
      Begin
        Close;
        Clear;
        If fConferenciaDepoisDaEntrada Then
        Begin
          objGarant := TMovGag.Create(Nil);
          Add(objGarant.objMovGad.fSQLInsereTabelaAux);
          FreeAndNil(objGarant);

          While not qryGen.Eof Do
          Begin
            strIncGau := fRetAutoIncrem('MOVGAU', VS_strCodEmp);

            ParamByName('AUTINC').AsString := strIncGau;
            ParamByName('SEQGAD').AsString := qryGen.FieldByName('GAE_SEQGAD').AsString;
            ParamByName('ESPDOC').AsString := qryGen.FieldByName('ESPENT').AsString;
            ParamByName('CODITE').AsString := qryGen.FieldByName('GAD_CODITE').AsString;
            ParamByName('QTDRET').AsFloat  := qryGen.FieldByName('GAE_RETCON').AsFloat;
            ParamByName('QTDREF').AsFloat  := qryGen.FieldByName('GAE_REFCON').AsFloat;
            ParamByName('SEQDET').AsString := qryGen.FieldByName('INCDET').AsString;
            ParamByName('SEQGAE').AsString := qryGen.FieldByName('AUTOINCREM').AsString;

            ExecSQL;

            qryGen.Next;
          End;

        End;

        Close;
        Clear;

        If fConferenciaDepoisDaEntrada Then
        Begin
          Add(' UPDATE MOVGAD                                              ');
          Add(' SET GAD_QTDRET = IFNULL(GAD_QTDRET,0) + IFNULL(:RETCON,0), ');
          Add('     GAD_QTDREF = IFNULL(GAD_QTDREF,0) + IFNULL(:REFCON,0), ');
          Add('     GAD_DTARET = ' + fCurrentDate + ',                     ');
          Add('     GAD_NUMRET = :NUMRET                                   ');
          Add(' WHERE MOVGAD.AUTOINCREM = :AUTINC                          ');

          qryGen.First;
          While not qryGen.Eof Do
          Begin
            ParamByName('AUTINC').AsString := qryGen.FieldByName('INCGAD').AsString;
            ParamByName('NUMRET').AsString := qryGen.FieldByName('DOCENT').AsString;
            ParamByName('RETCON').AsFloat  := qryGen.FieldByName('GAE_RETCON').AsFloat;
            ParamByName('REFCON').AsFloat  := qryGen.FieldByName('GAE_REFCON').AsFloat;

            ExecSQL;
            qryGen.Next;
          End;

        End
        Else
        Begin
          Add(' UPDATE MOVGAD                                   ');
          Add(' SET GAD_QTDREF = IFNULL(GAD_QTDREF,0) + :QTDREF ');
          Add(' WHERE AUTOINCREM = :AUTINC                      ');

          qryGen.First;
          While not qryGen.Eof Do
          Begin
            ParamByName('QTDREF').AsFloat  := qryGen.FieldByName('GAE_REFCON').AsFloat;
            ParamByName('AUTINC').AsString := qryGen.FieldByName('INCGAD').AsString;
            ExecSQL;
            qryGen.Next;
          End;

        End;

        Close;
        Clear;
        If fConferenciaDepoisDaEntrada Then
        Begin
          Add(' UPDATE MOVGAE SET GAE_QTDRET = IFNULL(GAE_QTDRET,0) + IFNULL(GAE_RETCON,0), ');
          Add('                   GAE_QTDREF = IFNULL(GAE_QTDREF,0) + IFNULL(GAE_REFCON,0), ');
          Add('                   GAE_RETCON = 0,                                           ');
          Add('                   GAE_REFCON = 0                                            ');
          Add(' WHERE AUTOINCREM = :AUTINC                                                  ');
        End
        Else
        Begin
          Add(' UPDATE MOVGAE SET GAE_RETCON = 0, ');
          Add('                   GAE_REFCON = 0  ');
          Add(' WHERE AUTOINCREM = :AUTINC        ');
        End;

        qryGen.First;
        While not qryGen.Eof Do
        Begin
          ParamByName('AUTINC').AsString := qryGen.FieldByName('AUTOINCREM').AsString;
          ExecSQL;
          qryGen.Next;
        End;

      End;
    End
    Else
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT PCD_NUMPED,                                                                    ';
      strSQL := strSQL + '        PCD_CODEMP,                                                                    ';
      strSQL := strSQL + '        SUBSTRING(FGO_DOCEND, 01, 12) AS NUMDOC,                                       ';
      strSQL := strSQL + '        SUBSTRING(FGO_DOCEND, 13, 02) AS ESPDOC                                        ';
      strSQL := strSQL + ' FROM FATDOR                                                                           ';
      strSQL := strSQL + '   INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM                                 ';
      strSQL := strSQL + '   INNER JOIN EXTGOR ON FGO_SEQFGO = FDO_SEQGER                                        ';
      strSQL := strSQL + '   LEFT JOIN PCMDET U ON PCD_DOCORI = CONCAT(SUBSTRING(FGO_DOCEND, 01, 14), SUBSTRING(FGO_DOCEND, 18, 03)) ';
      strSQL := strSQL + ' WHERE FATDOR.AUTOINCREM IN (' + strItensEnderecados + ')';

      With qryGen, SQL Do
      Begin
        Close;
        Clear;
        Add(strSQL);
        Open;

        If not IsEmpty Then
        Begin
          fBaixaPcmDet(FieldByName('PCD_NUMPED').AsString,
                       FieldByName('PCD_CODEMP').AsString,
                       FieldByName('NUMDOC').AsString,
                       FieldByName('ESPDOC').AsString);
        End;
        Close;
      End;

    End;
  Finally
    FreeAndNil(qryRef);
    FreeAndNil(qryGen);
  End;
End;

function TEnderecamentoProduto.fBaixaPcmDet(strNumPed, strCodEmp, strNumDoc,strEspDoc: String): Boolean;
  Var
    strSQL: String;
    qryGenDet: TUniQuery;
begin

  Try
    Result := True;
    qryGenDet := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  PCMDET ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  PCD_BAIXAD = :BAIXAD, ';
    strSQL := strSQL + '  PCD_DOCEMI = :NUMDOC, ';
    strSQL := strSQL + '  PCD_ESPEMI = :ESPDOC  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PCD_NUMCTN = 0 AND ';
    strSQL := strSQL + '  PCD_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCD_ESPDOC = "PD"    AND ';
    strSQL := strSQL + '  PCD_CODEMP = :CODEMP ';

    Try
      qryGenDet.Close;
      qryGenDet.SQL.Clear;
      qryGenDet.SQL.Add(strSQL);

      qryGenDet.ParamByName('BAIXAD').AsInteger := 1;
      qryGenDet.ParamByName('NUMDOC').AsString  := strNumDoc;
      qryGenDet.ParamByName('ESPDOC').AsString  := strEspDoc;

      qryGenDet.ParamByName('NUMPED').AsString  := strNumPed;
      qryGenDet.ParamByName('CODEMP').AsString  := strCodEmp;

      qryGenDet.ExecSQL;
      qryGenDet.Close;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fBaixaPcmDet]');
      End;
    End;

  Finally
    FreeAndNil(qryGenDet);
  End;

end;

function TEnderecamentoProduto.fApagaPedidoReservaEstoque: Boolean;
  var
    qryGen, qryAux: TUniQuery;
    strSQL: String;
    strItensEnderecados: String;
    blnTodosEnderecados,
    blnArmazem: Boolean;
begin
  Result := True;

  strItensEnderecados := fItensEnderecados;
  blnTodosEnderecados := fTodosEnderecados;

  blnArmazem := fCfgSis('CTLEST', varString) = '2';

  qryGen := fCriaQuery(nil);
  qryAux := fCriaQuery;
  strSQL := '';
  strSQL := strSQL + 'SELECT   ';
  strSQL := strSQL + '  *      ';
  strSQL := strSQL + 'FROM     ';
  strSQL := strSQL + '  FATGOR ';
  strSQL := strSQL + 'WHERE    ';
  strSQL := strSQL + '  AUTOINCREM = ' + QuotedStr(FSeqFgo);



  With qryGen, SQL Do
  Begin
    Close;
    Clear;
    Add(strSQL);
    Open;

    If qryGen.IsEmpty Then
    Begin
      Exit(False);
    End;

    If (VS_strHabilitarCRM) And
       (blnTodosEnderecados) Then
    Begin
        objOcoCrm := fAtualizaInformacoesCRM(FieldByName('FGO_NUMDOC').AsString,
                                             FieldByName('FGO_ESPDOC').AsString,
                                             FieldByName('FGO_CODEMP').AsString,
                                             FieldByName('FGO_CODCLI').AsString,
                                             FieldByName('FGO_NUMDOC').AsString,
                                             FieldByName('FGO_ESPDOC').AsString,
                                             strLoginUsuarioLogado,
                                             afcPedidoEnderecado);
        objOcoCrm.strNomFrm := '[TEnderecamentoProduto.fApagaPedidoReservaEstoque]';
        TAtuOcoCrm(objOcoCrm).pProcessaFatOcorrenciasCRM;
    End;


    if blnTodosEnderecados then
    Begin
      {****************************************************}
      {* SALVA NA TABELA DE REGISTROS DELETADOS FATGOR    *}
      {*************************************************JC*}
      fVerificaIntegridade(TEnderecamentoProduto.ClassName, 'FATGOR', qryGen, True, False, 'ENDERECAMENTO PRODUTOS');
      {****************************************************}
      {* SALVA NA TABELA DE REGISTROS DELETADOS EXTGOR    *}
      {*************************************************JC*}
      strSQL := AnsiReplaceStr(AnsiReplaceStr(strSQL, 'FATGOR', 'EXTGOR'), 'AUTOINCREM', 'FGO_SEQFGO');
      Close;
      Clear;
      Add(strSQL);
      Open;
      fVerificaIntegridade(TEnderecamentoProduto.ClassName, 'EXTGOR', qryGen, True, False, 'ENDERECAMENTO PRODUTOS');
      {****************************************************}
      {* SALVA NA TABELA DE REGISTROS DELETADOS FATDOR    *}
      {*************************************************JC*}
    End;

    If (Not blnTodosEnderecados) And fEmptyStr(strItensEnderecados) Then
      Exit(False);

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  *      ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  FATDOR ';
    strSQL := strSQL + 'WHERE FDO_SEQGER = ' +  QuotedStr(FSeqFgo);
    if Not blnTodosEnderecados then
      strSQL := strSQL + ' AND FATDOR.AUTOINCREM IN (' + strItensEnderecados + ')';

    Close;
    Clear;
    Add(strSQL);
    Open;

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  *      ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  EXTDOR ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  FDO_SEQFDO = :SEQFDO ';
    SetLength(LItensRecalculos, 0);
    SetLength(LItensRecalculos, qryGen.recordcount);

    If qryGen.IsEmpty Then
    Begin
      Exit(False);
    End;

    qryGen.First;
    While Not qryGen.Eof Do
    Begin

      {******************************************}
      {* SALVA NA TABELA DE REGISTROS DELETADOS *}
      {***************************************JC*}

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(strSQL);
      qryAux.ParamByName('SEQFDO').AsString := qryGen.FieldByName('AUTOINCREM').AsString;
      qryAux.Open;
  		fVerificaIntegridade(TEnderecamentoProduto.ClassName, 'EXTDOR', qryAux, True, False, 'ENDERECAMENTO PRODUTOS');

      fVerificaIntegridade(TEnderecamentoProduto.ClassName, 'FATDOR', qryGen, True, False, 'ENDERECAMENTO PRODUTOS');

      {*****************************}
      {* REPROCESSA SALDOS DO ITEM *}
      {*****************************}
      SetLength(LEmpresas, 0);
      LEmpresas := fGetEmpresasReprocessarItemPedido(qryGen.FieldByName('AUTOINCREM').AsString);

      LItensRecalculos[qryGen.recno-1] := (qryGen.FieldByName('FDO_CODITE').AsString);

      if Not blnTodosEnderecados then
      Begin
        pExcluirFatDor(qryGen.FieldByName('AUTOINCREM').AsString);

        qryAux.SQL.Clear;
        qryAux.SQL.Add('SELECT COUNT(1) AS QTD');
        qryAux.SQL.Add(' FROM FATDOR          ');
        qryAux.SQL.Add('WHERE FDO_SEQGER = ' + QuotedStr(FSeqFgo));
        qryAux.Open;

        blnTodosEnderecados := qryAux.FieldByName('QTD').AsInteger = 0;

        If blnArmazem Then
          pAjustaCampoSeMudouArmazemLote(qryGen.FieldByName('AUTOINCREM').AsString);
      End;

      qryGen.Next;
    End;

    {*************************************}
    {* APAGA O REGISTRO NA TABELA FATGOR *}
    {**********************************JC*}
    if blnTodosEnderecados then
    Begin
      qryGen.SQL.Clear;
      strSQL := '';

      strSQL := strSQL + 'DELETE FROM ';
      strSQL := strSQL + '  FATGOR ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  AUTOINCREM = ' + QuotedStr(FSeqFgo);
      strSQL := strSQL + ' /* ';
      strSQL := strSQL + ' FDocume.strNumDoc = ' + FDocume.strNumDoc;
      strSQL := strSQL + ' FDocume.strEspDoc = ' + FDocume.strEspDoc;
      strSQL := strSQL + ' FDocume.strSerie_ = ' + FDocume.strSerie_;
      strSQL := strSQL + ' FDocume.strCodEmp = ' + FDocume.strCodEmp;
      strSQL := strSQL + ' FDocume.strCliFor = ' + FDocume.strCliFor;
      strSQL := strSQL + ' FDocume.strTip_FC = ' + FDocume.strTip_FC;
      strSQL := strSQL + ' */';

      Close;

      SQL.Clear;
      SQL.Add(strSQL);

      ExecSQL;

      Result := (RowsAffected > 0);
    End;


  End;

  FreeAndNil(qryGen);
  FreeAndNil(qryAux);

end;

function TEnderecamentoProduto.ReprocessaSaldos: Boolean;
Var
  LEmpresa: String;
  LItemRecalculo: String;
begin
  Result := true;
  Try
    For LItemRecalculo in LItensRecalculos Do
    Begin
      IF (LItemRecalculo <> '') then
      Begin
        For LEmpresa In LEmpresas Do
        Begin
           IF (LEmpresa <> '') then
             Result := Result And ReprocessarItem(LItemRecalculo, LEmpresa);
        End;
      End;
    End;
  Except
    {}
  End;
End;

procedure TEnderecamentoProduto.pLimpar;
begin
  strDocumento := '';
  SetLength(FItens, 0);

  FobjListaNumSerie.LimparLista;
  FobjRastreamento.pClear;
end;

procedure TEnderecamentoProduto.pSetAutIncPed(Value: String);
begin
  pLimpar;
  strDocumento := fCampoTabela('FGO_DOCEND', 'EXTGOR', ['FGO_SEQFGO'], [Value]);
end;

procedure TEnderecamentoProduto.pSetRecEnderecamento(Value: TEndDocumento);
begin
  FDocume := Value;
  pCarregarAutoIncremPedido;
end;

procedure TEnderecamentoProduto.pSetStrEnderecamento(Value: String);
begin
  pEnderecamentoToDocumento(Value, FDocume);

  FDocume.strAutInc := fGetMovGerAutoinc(FDocume.strCodEmp,
                                         FDocume.strNumDoc,
                                         FDocume.strEspDoc,
                                         FDocume.strSerie_,
                                         FDocume.strCliFor,
                                         FDocume.strTip_FC);
  pCarregarAutoIncremPedido;
  pCarregaPedidosQueDevemHabilitarReserva;


end;

procedure TEnderecamentoProduto.pCarregaPedidosQueDevemHabilitarReserva;
begin
  qryPedidosQueDevemHabilitarReserva.SQL.Clear;
  qryPedidosQueDevemHabilitarReserva.SQL.Add('SELECT MOVGER.AUTOINCREM, MOVRCD.RCD_QTDITE,');
  qryPedidosQueDevemHabilitarReserva.SQL.Add('       MOVDET.DET_QTDITE, OSX.FDO_SEQFDO,');
  qryPedidosQueDevemHabilitarReserva.SQL.Add('       FDO_CODITE,');
  qryPedidosQueDevemHabilitarReserva.SQL.Add('       FDO_CODEMP,');
  qryPedidosQueDevemHabilitarReserva.SQL.Add('       (SELECT SUM(BAI_QTDREQ)');
  qryPedidosQueDevemHabilitarReserva.SQL.Add('          FROM BAIREQ');
  qryPedidosQueDevemHabilitarReserva.SQL.Add('         WHERE BAI_AUTREQ = MOVRCD.AUTOINCREM ) TOTAL_REQ_BAIXADA,');
  qryPedidosQueDevemHabilitarReserva.SQL.Add('       IFNULL((SELECT SUM(EXT_QTDATD) FROM RREEXT WHERE EXT_SEQDOR = OSD.AUTOINCREM), 0) + MOVDET.DET_QTDITE AS  TOTAL_REQ_ATENDIDA');
  qryPedidosQueDevemHabilitarReserva.SQL.Add('  FROM MOVGER');
  qryPedidosQueDevemHabilitarReserva.SQL.Add(' INNER JOIN MOVDET ON DET_SEQGER = MOVGER.AUTOINCREM');
  qryPedidosQueDevemHabilitarReserva.SQL.Add(' INNER JOIN BAIREQ ON BAI_AUTDET = MOVDET.AUTOINCREM');
  qryPedidosQueDevemHabilitarReserva.SQL.Add(' INNER JOIN MOVRCD ON MOVRCD.AUTOINCREM =  BAI_AUTREQ');
  qryPedidosQueDevemHabilitarReserva.SQL.Add(' INNER JOIN FATGOR OS ON OS.FGO_NUMDOC = RCD_DOCPDV');
  qryPedidosQueDevemHabilitarReserva.SQL.Add('                     AND OS.FGO_CODEMP = RCD_EMPPDV');
  qryPedidosQueDevemHabilitarReserva.SQL.Add('                     AND OS.FGO_ESPDOC = RCD_ESPPDV');
  qryPedidosQueDevemHabilitarReserva.SQL.Add(' INNER JOIN FATDOR OSD ON OSD.FDO_SEQGER = OS.AUTOINCREM AND OSD.FDO_CODITE = MOVDET.DET_CODITE');
  qryPedidosQueDevemHabilitarReserva.SQL.Add(' INNER JOIN EXTDOR OSX ON OSX.FDO_SEQFDO = OSD.AUTOINCREM AND  FDO_RESERV = "N"');
  qryPedidosQueDevemHabilitarReserva.SQL.Add(' WHERE MOVGER.AUTOINCREM = "'+FDocume.strAutInc+'"');
  qryPedidosQueDevemHabilitarReserva.Open;
end;


procedure TEnderecamentoProduto.pCarregarAutoIncremPedido;
begin
  If fEmptyStr(strDocumento) Then
    FSeqFgo := EmptyStr
  Else
    FSeqFgo := fCampoTabela('FGO_SEQFGO', 'EXTGOR', ['FGO_DOCEND'], [strDocumento]);
end;

procedure TEnderecamentoProduto.pExcluirFatDor(strAutInc: String);
Var
  qryFatDor: TUniQuery;
Begin
  qryFatDor := fCriaQuery();
  Try
    qryFatDor.Close;
    qryFatDor.SQL.Text := 'DELETE FROM FATDOR WHERE AUTOINCREM = :AUTINC';
    qryFatDor.ParamByName('AUTINC').AsString := strAutInc;
    qryFatDor.ExecSQL;
  Finally
    FreeAndNil(qryFatDor);
  End;
end;

function TEnderecamentoProduto.fGerarPedidoParaReservarEstoque(prgProgresso: TProgressBar = Nil): Boolean;
  Var
    strAutFdo,
    strNumDoc,
    strCodCli,
    strMens01,
    strMens02: String;
    intIdxIte: Integer;
    recServicos: TDadosServicos;
    arrDuplic : TarrDuplicata;

  function fMarcaDocumentoEnderecamento: Boolean;
  begin
    Result := fExecutaSQL(' UPDATE ' +
                          '   EXTGOR ' +
                          ' SET ' +
                          '   FGO_DOCEND = ' + QuotedStr(IIf(Self.blnResEstPenLotpre, 'PE', '') + strDocumento) +
                          ' WHERE ' +
                          '   FGO_SEQFGO = ' + QuotedStr(FSeqFgo));
  end;

  procedure pSetRefugo;
    Var
      qryExtDor : TUniQuery;
  Begin
    qryExtDor := fCriaQuery;
    With qryExtDor, SQL Do
    Begin
      Close;
      Clear;
      Add(' UPDATE EXTDOR SET FDO_REFUGO = "S" WHERE FDO_SEQFDO = :SEQFDO ');
      ParamByName('SEQFDO').AsString := strAutFdo;
      ExecSQL;
    End;
  End;

begin
  FillChar(recServicos, SizeOf(recServicos), #0);

  Try

    With FDocume Do
    Begin
      If (FRetornoRemessaOutEnt) Then
      Begin
        strMens01 := 'PEDIDO DE RESERVA DE ESTOQUE PARA RETORNO DE VENDA FORA DO ESTABELECIMENTO - REF. A ' + strEspDoc + ' ' + strNumDoc + ' - ' + strCodEmp;
        strMens02 := 'CLIENTE: ' + strCliFor + '-' + fRetNomCliente(strCliFor);
      End
      Else If FPedidoDeEnderecamentoFulfillment Then
      Begin
        strMens01 := 'PEDIDO DE RESERVA DE ESTOQUE PARA ENTRADA REF. AO FULFILLMENT - REF. A ' + strEspDoc + ' ' + strNumDoc + ' - ' + strCodEmp;
        strMens02 := 'CLIENTE: ' + strCliFor + '-' + fRetNomCliente(strCliFor);
      End
      Else
      If FBaixaPedidoNaoSeraEntregue Then
      Begin
        strMens01 := 'PEDIDO DE RESERVA DE ESTOQUE BAIXA DO DOCUMENTO: ' + strNumDoc + '-' + strEspDoc + ' ' + strSerie_;
        strMens02 := 'CLIENTE: ' + strCliFor + '-' + fRetNomCliente(strCliFor);
      End
      Else
      If FCancelamento Then
      Begin
        strMens01 := 'PEDIDO DE RESERVA DE ESTOQUE CANCELAMENTO DO DOCUMENTO: ' + strNumDoc + '-' + strEspDoc + ' ' + strSerie_;
        strMens02 := 'CLIENTE: ' + strCliFor + '-' + fRetNomCliente(strCliFor);
      End
      Else
      Begin
        If strTip_FC = 'F' Then
        Begin
          If blnResEstPenLotpre Then
          Begin
            strMens01 := 'PEDIDO DE RESERVA DE ESTOQUE ENDEREÇAMENTO COM PEND. DE ATIVAÇÃO DE LOTE DE PREÇO REF. A ' + strNumDoc + '-' + strEspDoc + ' ' + strSerie_;
            strMens02 := 'FORNECEDEDOR: ' + strCliFor + '-' + fRetNomFornecedor(strCliFor);
          End
          Else
          Begin
            strMens01 := 'PEDIDO DE RESERVA DE ESTOQUE PRE-NOTA ' + strNumDoc + '-' + strEspDoc + ' ' + strSerie_;
            strMens02 := 'FORNECEDEDOR: ' + strCliFor + '-' + fRetNomFornecedor(strCliFor);
          End;
        End
        Else
        Begin
           If strEspDoc = 'TA' Then
            strMens01 := 'PEDIDO DE RESERVA DE ESTOQUE TRANSFERENCIA ' + strNumDoc + '-' + strEspDoc
           Else
            strMens01 := 'PEDIDO DE RESERVA DE ESTOQUE DEVOLUCAO ' + strNumDoc + '-' + strEspDoc + ' ' + strSerie_;

          strMens02 := 'CLIENTE: ' + strCliFor + '-' + fRetNomCliente(strCliFor);
        End;
      End;
    End;

    If Assigned(prgProgresso) Then
    Begin
      prgProgresso.Position := 0;
      prgProgresso.Max := Length(FItens) + 1;
    End;

    strCodCli := fCadEmp('CLIFIL');

    strNumDoc := fRetSequencialPedido;

    FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

    Result := fGravaFatGor(FSeqFgo,                    //  strIncrem
                           VS_strCodEmp,               //  strCodEmp
                           strNumDoc,                  //  strNumDoc
                           'PD',                       //  strEspDoc
                           strCodCli,                  //  strCodCli
                           strLoginUsuarioLogado,      //  strCodVen
                           '',                         //  strCodTra
                           '',                         //  strSerie:
                           VS_Date,                    //  dtaDtaEnt
                           fTime(),                    //  dtaHorEnt
                           '01000',                    //  strConPag
                           '',                         //  strEstado
                           '',                         //  strNomCom
                           '',                         //  strEndCon
                           '',                         //  strBaiCon
                           '',                         //  strCepCon
                           '',                         //  strCidCon
                           '',                         //  strEstCon
                           '',                         //  strCodAti
                           '',                         //  strTelCon
                           0,                          //  dtaNasCon
                           '',                         //  strCgcCpf
                           '',                         //  strCgcCon
                           '',                         //  strIesCon
                           '',                         //  strCli_Rg
                           0.0,                        //  fltBasSim
                           0.0,                        //  fltBasIpi
                           0.0,                        //  fltAlqIpi
                           0.0,                        //  fltTotIpi
                           0.0,                        //  fltBasIcm
                           0.0,                        //  fltAlqIcm
                           0.0,                        //  fltTotIcm
                           0.0,                        //  fltTotRet
                           0.0,                        //  fltAlqRet
                           0.0,                        //  fltBasRet
                           0.0,                        //  fltDesEsp
                           0.0,                        //  fltVlrCon
                           0.0,                        //  fltTotPro
                           0.0,                        //  fltTotCus
                           0.0,                        //  fltTotMed
                           '1',                        //  strTipFre
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,
                           0.0,

                           0.0,                        //  fltTotFre
                           0.0,                        //  fltTotFre
                           0.0,                        //  fltPesBru
                           0.0,                        //  fltPesLiq
                           0,                          //  fltVolume
                           arrDuplic,                  //  arrDuplic
                           '',                         //  strEspeci
                           '',                         //  strMarca,
                           strMens01,                  //  strMen001
                           strMens02,                  //  strMen002
                           False,                      //  blnJaFatu
                           '',                         //  strTipFat
                           '',                         //  strNumFat
                           '',                         //  strEmpFat
                           0,                          //  dtaDtaFat
                           '',                         //  strVenFat
                           '',                         //  strCndFat
                           0.0,                        //  fltValFat
                           0.0,                        //  fltPorDes
                           strLoginUsuarioLogado,      //  strCodDig
                           '',                         //  strCodCnd
                           '',                         //  strCodFpg
                           recServicos,                //  Servicos
                           '',                         //  strConEnt
                           VS_Date,                    //  dtaPreVis
                           0.0,                        //  fltVPgAnt
                           VS_Date,                    //  dtaUltAlt
                           '',                         //  strNTrava
                           'A',                        //  strTipPed
                           '',                         //  sreCliCtt
                           0,                          //  intLibera
                           'S',                        //  strEntFat
                           0.0,                        //  fltDesCon
                           '1',                        //  strTabPre
                           '',                         //  strEntFut
                           0.0,                        //  fltMargem
                           '',                         //  strNumPok
                           '',                         //  strEmp_CD
                           False,                      //  blnEnt_CD
                           'N',                        //  strOprFlj
                           '',                         //  strMenExp
                           '',                         //  strMenExp
                           '',                         //  strMenExp
                           '',                         //  strMenExp
                           '',
                           '',
                           False,                       //  blnPedLib
                           0.0,
                           'N',
                           '',
                           0,
                           'P',                        //strTipFin
                           0,                          //fltDesFin
                           '',                         //strAutEnt
                           '',
                           '',
                           False,
                           '',
                           Nil,
                           '',
                           '',
                           0,
                           0,
                           0,
                           '',
                           Nil,
                           '',
                           0,
                           0,
                           '',
                           '',
                           0,
                           '',
                           0,
                           '',
                           '',
                           '0',
                           'N',
                           '',
                           '',
                           '',
                           '',
                           '',
                           '',
                           '',
                           False,
                           False,
                           0,
                           0,
                           '',
                           '',
                           '',
                           '',
                           '',
                           nil,
                           'S',
                           0,
                           '',
                           '',
                           '',
                           '',
                           '',
                           'N',
                           'N',
                           'N',
                           0,
                           '',
                           'N',
                           '',
                           '',
                           False,
                           '',
                           0,
                           '',
                           '',
                           '',
                           '',
                           'S',
                           0,
                           '',
                           0,
                           0,
                           False,
                           0,
                           'N',
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
                           0,
                           nil,
                           'N',
                           '',
                           '',
                           '',
                           '',
                           '',
                           '',
                           0,
                           0,
                           '',
                           '',
                           '',
                           '',
                           0,
                           0,
                           FDevWms);

    Result := Result And fMarcaDocumentoEnderecamento;

    If Assigned(prgProgresso) Then
    Begin
      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    If Result Then
    Begin
      strAutFdo := fRetAutoIncrem('FATDOR', VS_strCodEmp, Length(FItens));

      For intIdxIte := 0 To Length(FItens) -1 Do
      Begin

        Result := Result And fGravaFatDor(strAutFdo,
                                          FSeqFgo,                                     // strSeqGer
                                          VS_strCodEmp,                                //  strCodEmp
                                          strCodCli,                                   //  strCodCli
                                          strLoginUsuarioLogado,                       //  strCodVen
                                          FItens[intIdxIte].strCodIte,                 //  strCodIte
                                          FItens[intIdxIte].strCodMar,                 //  strCodMar
                                          '',                                          //  strCodDiv
                                          strNumDoc,                                   //  strNumDoc
                                          'PD',                                        //  strEspDoc
                                          '',                                          //  strSerie:
                                          VS_Date,
                                          fTime(),                                     //  dtaHorEnt
                                          '01000',                                     //  strConPag
                                          '',                                          //  strEstado
                                          FItens[intIdxIte].strDesIte,                 //  strDescri
                                          FItens[intIdxIte].strRefere,                 //  strRefere
                                          FItens[intIdxIte].strCodUni,                 //  strUnidad
                                          FItens[intIdxIte].strCodFor,                 //  strForIte
                                          FItens[intIdxIte].fltQtdIte,                 //  fltQtdIte
                                          0.0,                                         //  fltUnitar
                                          0.0,                                         //  fltUniOri
                                          0.0,                                         //  fltUniVis
                                          0.0,                                         //  fltTotIte
                                          0.0,                                         //  fltVlrCon
                                          0.0,                                         //  fltTotCus
                                          0.0,                                         //  fltTotMed
                                          0.0,                                         //  fltDesCon
                                          0.0,                                         //  fltTotFre
                                          0.0,                                         //  fltDesEsp
                                          0.0,                                         //  fltDesAce
                                          '',                                          //  strCodRep
                                          '',                                          //  strCodVe2
                                          0.0,                                         //  fltPerCom
                                          0.0,                                         //  fltTotCom
                                          0.0,                                         //  fltTotCo2
                                          '',                                          //  strClaFis
                                          '',                                          //  strCodFis
                                          0.0,                                         //  fltValIpi
                                          0.0,                                         //  fltAlqIpi
                                          0.0,                                         //  fltBasIpi
                                          0.0,                                         //  fltValIcm
                                          0.0,                                         //  fltAlqIcm
                                          0.0,                                         //  fltBasIcm
                                          0.0,                                         //  fltValRet
                                          0.0,                                         //  fltAlqRet
                                          0.0,                                         //  fltBasRet
                                          0.0,                                         //  fltTotPes
                                          0.0,                                         //  fltPerBas
                                          0.0,                                         //  fltPerRed
                                          False,                                       //  blnJaFatu
                                          '',                                          //  strTipFat
                                          '',                                          //  strNumFat
                                          '',                                          //  strEmpFat
                                          0,                                           //  dtaDtaFat
                                          '',                                          //  strVenFat
                                          '',                                          //  strCndFat
                                          0.0,                                         //  fltValFat
                                          'NOR',                                       //  strIdePro
                                          'N',                                         //  strIncPis
                                          strLoginUsuarioLogado,                       //  strCodDig
                                          '',                                          //  strConPag
                                          '',                                          //  strProEmb
                                          '',                                          //  strCodFpg
                                          '',                                          //  strIteCha
                                          '',                                          //  strIteTin
                                          '',                                          //  strDesCor
                                          '',                                          //  strTipEmb
                                          0.0,                                         //  fltQtdEmb
                                          0.0,                                         //  fltPreEmb
                                          '',                                          //  strTipPre
                                          0.0,                                         //  fltPrvTin
                                          0.0,                                         //  fltPrcTin
                                          0.0,                                         //  fltFatTin
                                          '',                                          //  strIteEmb
                                          '',                                          //  strGruEmb
                                          0,                                           //  intLazQua
                                          'N',                                         //  strPromoc
                                          '',                                          //  strSeqTin
                                          0.0,                                         //  fltQtdPul
                                          intIdxIte,                                   //  intSeqInd
                                          0.0,                                         //  fltQtdBai
                                          0.0,                                         //  fltUniDig
                                          '',                                          //  strComple
                                          0.0,                                         //  fltVolPro
                                          FItens[intIdxIte].strCodAca,                 //  strCodAca
                                          FItens[intIdxIte].strEmpAca,                 //  strEmpAca
                                          FItens[intIdxIte].blnIteAca,                 //  blnProAca
                                          '',                                          //  strTabPre
                                          '',                                          //  strLinha:
                                          '',                                          //  strCatali
                                          '',                                          //  strCodDil
                                          0.0,                                         //  fltPorDil
                                          '',                                          //  strDilCon
                                          0.0,                                         //  fltPorCat
                                          '',                                          //  strEntRet
                                          '',                                          //  strLocRet
                                          '',                                          //  strEntFut
                                          '',                                          //  strMotFut
                                          0,                                           //  dtaDtEntr
                                          0,                                           //  fltTotCu2
                                          0,                                           //  fltComRep
                                          0,                                           //  fltPerRep
                                          '',                                          //  strKey_EP
                                          FItens[intIdxIte].strCodAmz,                 //  strNumLot
                                          '',                                          //  strEmpPrd
                                          False,                                       //  blnBxSbIt
                                          '',                                          //  strEmpIte
                                          '',                                          //  strDocDev
                                          '',                                          //  strEspDev
                                          '',                                          //  strEmpDev
                                          '',                                          //  strEmpFor
                                          '',                                          //  strOrdPro
                                          0,                                           //  fltFreSug
                                          0,                                           //  fltQtdExp
                                          '',                                          //  strBarEmb
                                          '',                                          //  strNumCmp
                                          0,                                           //  intNItCmp
                                          '',                                          //  strCodMec
                                          '',                                          //  strSeqRcd
                                          0,                                           //  intSeqInc
                                          0,                                           //  intOrdIte
                                          0,                                           //  fltPesLiq
                                          'N',   // strAltPCo: String = 'N';
                                          'N',   // strCliBus: string = 'N';
                                          '',    // strTurEnt: String = '';
                                          0,     // fltVal_RT: Double = 0;
                                          0,     // fltTaxJur: Double = 0;
                                          False, // blnInseridoOuAlterado: Boolean=False;
                                          '',    // strLotAba: String = '';
                                          '',    // strLotAnt: String = '';
                                          '',    // strIncFut: String = '';
                                          0,     // fltSerRat: Double = 0;
                                          '',    // strSepExp: String = '';
                                          0,     // fltFreRat: Double = 0;
                                          'N',   // strPigBas: String = 'N';
                                          '',    // strIncDev: String = '';
                                          '',    // strSeqOpI: String = '';
                                          'N',   // strBrinde: String = 'N';
                                          '',    // strCodPar: String = '';
                                          '',    // strTipBri: String = '';
                                          '',    // strBaqtze: String = '';
                                          0,     // fltDesMax: Double = 0;
                                          0,     // fltValFle: Double = 0;
                                          'N',   // strPegou_: String = 'N';
                                          0,     // fltTaxEnt: Double = 0;
                                          'N',   // strAtivac: String = 'N';
                                          0,     // intSeqCom: Integer = 0;
                                          0,     // fltQtdAti: Double  = 0;
                                          0,     // fltQtdCom: Double  = 0;
                                          '',    // strTabCom: String = '';
                                          '',    // strDesNes: String = '';
                                          False, // blnIcmSai: Boolean = False;
                                          0,     // fltIcmPav: Double = 0;
                                          0,     // fltIcmSai: Double = 0;
                                          0,     // fltImpFed: Double = 0;
                                          0,     // fltDesOpe: Double = 0;
                                          0,     // fltAlDifa: Double = 0;
                                          FItens[intIdxIte].strAutDet,      //strAutDet
                                          0,     // fltValFCP: Double = 0;
                                          0,     // fltPesBru: Double = 0;
                                          0,     // intSeqUlt: Integer = 0;
                                          0,     // intQDEntr: Integer = 0;
                                          '',    // strNcmTin: String = '';
                                          '',    // strNotC17: String = '';
                                          0,     // fltAlq922: Double = 0;
                                          '',    // strCodCmg: String = '';
                                          0,     // fltQtdSep: Double = 0;
                                          0,     // fltDesCnd: Double = 0;
                                          0,     // intSeqEst: Integer = 0;
                                          '',    // strIteEst: String = '';
                                          0,     // fltUniEst: Double = 0;
                                          0,     // fltQtdSbi: Double = 0;
                                          0,     // fltUniSbi: Double = 0;
                                          0,     // fltFreMkp: Double = 0;
                                          0,     // fltComMkp: Double = 0;
                                          '',    // strProEsp: String = '';
                                          '',    // strVenCbo: String = '';
                                          '',    // strCodPro: String = '';
                                          0,     // fltUniDol: Double = 0;
                                          0,     // fltTotDol: Double = 0;
                                          0,     // fltQtdRco: Double = 0;
                                          True,  // blnExiBSe: Boolean = True;
                                          '',    // strAIdKitPromocao : String = '';
                                          '',    // strOpBxSe: String = '';
                                          0,     // dtaDtBxSe: TDateTime = 0;
                                          0,     // dtaHrBxSe: TDateTime = 0;
                                          '',    // strEmpCar: String = '';
                                          0,     // fltDesBai: Double = 0;
                                          '',    // strTemNumSerie: String = '';
                                          0,     // fltVDesST: Double = 0;
                                          '',    // strMDesST: String = '';
                                          'S',   // strReserv: String = 'S';
                                          0,     // intSeqInv: Integer = 0 ;
                                          '',    // strSeqEql: String = '';
                                          '',    // strNumDrw: String = '';
                                          False, // blnMntPrc: Boolean = False;
                                          0,     // fltQtdRet: Double = 0;
                                          '',    // strNumPla: String = '';
                                          '',    // strParNum: String = '';
                                          '',    // strReqCom: String = '';
                                          FItens[intIdxIte].strAutEnd,
                                          '',
                                          0,
                                           False,
                                           0,
                                           False,
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          0,
                                          '',
                                          0,
                                          0,
                                          0,
                                          0,
                                          0,
                                          0,
                                          0,
                                          0,
                                          '',
                                          FItens[intIdxIte].strAutIncLotPre);
        If FItens[intIdxIte].blnRefugo Then
          pSetRefugo;

        If Result Then
          If (Not fEmptyStr(FItens[intIdxIte].strAutDetSer)) Then
            pGravaSeriesEnderecamento(FItens[intIdxIte].strAutDetSer, strAutFdo, FItens[intIdxIte].strAutDet);

        If Assigned(prgProgresso) Then
        Begin
          prgProgresso.Position := prgProgresso.Position + 1;
          Application.ProcessMessages;
        End;

        strAutFdo := fNextAutoIncrem(strAutFdo);
      End;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

end;

function TEnderecamentoProduto.fGetMovGerAutoinc(strCodEmp, strNumDoc,
  strEspDoc, strSerie, strCodCli, strTip_FC: string): String;
  var qryConsulta: TUniQuery;
begin
  Result := '';
  If strNumDoc = '' Then
    Exit;
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT AUTOINCREM FROM MOVGER');
    qryConsulta.SQL.Add(' WHERE GER_NUMDOC = :NUMDOC');
    qryConsulta.SQL.Add('   AND GER_ESPDOC = :ESPDOC');
    qryConsulta.SQL.Add('   AND GER_CODEMP = :CODEMP');
    qryConsulta.SQL.Add('   AND COALESCE(GER_SERIE_, "") = :SERIE_');
    If SameText(strTip_FC, 'F') Then
      qryConsulta.SQL.Add('   AND GER_CODFOR = :CODCLI')
    Else
      qryConsulta.SQL.Add('   AND GER_CODCLI = :CODCLI');

    qryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString := strCodEmp;
    qryConsulta.ParamByName('SERIE_').AsString := strSerie;
    qryConsulta.ParamByName('CODCLI').AsString := strCodCli;

    qryConsulta.Open;
    If Not qryConsulta.IsEmpty Then
      Result := qryConsulta.FieldByName('AUTOINCREM').AsString;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TEnderecamentoProduto.fGetQtdItens: Integer;
begin
  Result := Length(FItens);
end;

function TEnderecamentoProduto.fGetSqlItensPedido: String;
Var
  blnUsaQtdPen: Boolean;
  blnEndParc: Boolean;
Const
    STR_LOTCRO = 'IFNULL((SELECT LOT_NUMLOT FROM CADLOT WHERE LOT_CODEMP = FDO_CODEMP AND LOT_CODITE = FDO_CODITE AND LOT_CRODOC = "S" AND LOT_STATUS = "S" LIMIT 1), "")';
begin

  blnUsaQtdPen := (Not fCfgSis('BEFTRG', VarBoolean)) Or fUsaQtdPendenteEntregaFutura;
  blnEndParc := (Not fUsaRotinaWMS) And (fCfgSis('TPLREC', varString) = 'N');
  Result := '';
  Result := Result + ' SET @CALC := 0; ';
  Result := Result + ' SET @CONF_FIN_SEM_CONF := 0; ';
  Result := Result + ' SET @ITE_QTDCOF := 0; ';
  Result := Result + ' SET @IDEDIG := 0; ';
  Result := Result + ' SET @ITE_QTDCOF_2 := 0; ';
  Result := Result + ' SET @ITE_QTDEND_1 := 0; ';
  Result := Result + ' SET @ITE_QTDDSP := 0; ';
  Result := Result + ' SET @ITE_QTDNOT := 0; ';
  Result := Result + ' SET @FDO_QTDITE := 0; ';
  Result := Result + ' SET @ITE_QTDEND := 0; ';

  Result := Result + 'SET @TEM_DIGCON := (SELECT COUNT(1) FROM DIGCON WHERE DIC_SEQGER = ' + QuotedStr(FSeqFgo)+ ');';
  If ((blnUDEVME) Or (blnCofEnd)) and (not blnCofDev)Then
    Result := Result + 'SELECT * FROM (';
  Result := Result + 'SELECT DISTINCT ';
  Result := Result + '  @TEM_DIGCON AS TEM_DIGCON, ';
  Result := Result + '  D.AUTOINCREM AS SEQDET, ';
  Result := Result + '  D.DET_CODFOR,     ';
  Result := Result + '  ITE_DIGCON,       ';
  Result := Result + '  FDO_SEQIND,       ';
  Result := Result + '  DET_NITEM_,       ';
  Result := Result + '  FDO_NUMDOC,       ';
  Result := Result + '  FDO_ESPDOC,       ';
  Result := Result + '  FDO_CODEMP,       ';
  Result := Result + '  FDO_CODITE,       ';
  Result := Result + '  IF(FDO_PROACA = "S" , "", FDO_NUMLOT) AS FDO_NUMLOT,       ';
  Result := Result + '  FDO_DESCRI,       ';
  Result := Result + '  FDO_REFERE,       ';
  Result := Result + '  UNI_SIGUNI,       ';
   Result := Result + ' CAST(IF(LOCATE("DEVOLUÇÃO", UPPER(FGO_MEN001)) > 0 , "S", "N") AS CHAR(1)) AS DEVOLU, ';

  If (blnCOFEND) OR (blnUDEVME) Then
  Begin
    Result := Result + '@CONF_FIN_SEM_CONF := IFNULL(DIC_SEMCON, "N") = "S" AS CONF_FIN_SEM_CONF, ';
    Result := Result + '@ITE_QTDCOF := @ITE_QTDCOF := IFNULL(DIC_QTDITE, 0) AS ITE_QTDCOF_DIGCON, ';

    Result := Result + '  @IDEDIG := DIC_IDEDIG AS IDEDIG, ';

    Result := Result + '  @ITE_QTDCOF_2 := IFNULL((SELECT SUM(DIG_QTDITE) FROM DIGELE ';
    Result := Result + '                          WHERE DIG_IDEDIG = DIC_IDEDIG ';
    Result := Result + '                            AND DIG_CODITE = FDO_CODITE) , 0) AS ITE_QTDCOF, ';

    Result := Result + ' @ITE_QTDEND_1 := IFNULL(FDO_QTDBAI, 0) - IFNULL((SELECT DEV_QTDBAI FROM DEVVEN WHERE DEV_INCFDO = FATDOR.AUTOINCREM), 0) AS ITE_QTDEND, ';
    Result := Result + '@ITE_QTDDSP := FDO_QTDITE - IFNULL(PRD_QTDITE,0) ' + IIF(blnEndParc, ' - IFNULL(FDO_QTDBAI,0)','') + ' AS ITE_QTDDSP, ';
    Result := Result + '@ITE_QTDNOT := FDO_QTDITE AS ITE_QTDNOT, ';
  End
  Else
  Begin
    Result := Result + '  @ITE_QTDCOF := 0.0000 ITE_QTDCOF,       ';
    Result := Result + '  @ITE_QTDNOT := 0.0000 ITE_QTDNOT,       ';
    Result := Result + '  @ITE_QTDEND := 0.0000 ITE_QTDEND,       ';
    Result := Result + '  @ITE_QTDDSP := 0.0000 ITE_QTDDSP,       ';
  End;

  If ((blnCofEnd) or (blnUDEVME)) And (Not blnCofDev) Then
  Begin
    Result := Result + '@FDO_QTDITE := IF((IFNULL(AUX_ENTSIM, "N") = "S" AND (fCfgSis("CFG_COFTRA",  FDO_CODEMP) = "N")) OR (@TEM_DIGCON =0), ';
    Result := Result + ' ( FDO_QTDITE - IFNULL(PRD_QTDITE,0) ' + IIF(blnEndParc, ' - IFNULL(FDO_QTDBAI,0)','') + ') , ';
    Result := Result + ' ( IFNULL(DIC_QTDITE, 0) + IFNULL(DIC_QTDLDE, 0) - @ITE_QTDEND_1 ))AS FDO_QTDITE, '
  End
  Else
    Result := Result + ' @FDO_QTDITE := FDO_QTDITE - IFNULL(PRD_QTDITE,0) ' + IIF(blnEndParc, ' - IFNULL(FDO_QTDBAI,0)','') + ' AS FDO_QTDITE,       ';

  If blnCofEnd Then
    Result := Result + ' IFNULL(@ITE_QTDCOF_2 , 0) - IFNULL(DIC_QTDITE, 0)   AS QTD_CONF_NAO_LIB_END,  '
  Else
    Result := Result + ' 0.00 AS QTD_CONF_NAO_LIB_END,  ';

  Result := Result + '  @ITE_QTDEND := CONVERT(IF(IFNULL(FDO_NUMLOT, "A DEFINIR") <> "A DEFINIR", @FDO_QTDITE,  0.0000), DECIMAL(18,4)) ITE_QTDENR,       ';

  Result := Result + '  I.ITE_SALDOS,     ';
  Result := Result + '  C.ITE_CNV_ML,     ';

  Result := Result + '  FDO_PROACA,     ';
  Result := Result + '  FDO_CODACA,     ';
  Result := Result + '  FDO_EMPACA,     ';
  Result := Result + '  FDO_IDEPRO,     ';

  Result := Result + '  I.ITE_SALDOS + IF(IFNULL(C.ITE_CNV_ML, 0) > 0, ';
  Result := Result + '  IFNULL(I.ITE_SAL_ML, 0) / C.ITE_CNV_ML, 0) + ' ;
  Result := Result +  IIf(blnUsaQtdPen, fGetSQLSomaCamposEntregaFutura('I'), '0')+' AS ITE_SALFIS, ';

  Result := Result + '  0 AS ITE_SALDSP,  ';
  Result := Result + '  C.ITE_CODBAR,     ';
  Result := Result + '  C.ITE_CODFAB,     ';
  Result := Result + '  IF(FDO_PROACA = "S", (SELECT  ACA_LOCFIS FROM ACAGER G ';
  Result := Result + '                         WHERE G.ACA_CODACA = FDO_CODACA ';
  Result := Result + '                           AND G.ACA_CODEMP = FDO_EMPACA ';
  Result := Result + '                           AND G.ACA_EMPEST = FDO_CODEMP) , I.ITE_LOCFIS) ITE_LOCFIS,     ';
  Result := Result + '  I.ITE_LOCSUP,     ';
  Result := Result + '  IF(G.GER_ORIDOC = "V","N", I.ITE_USASER) AS ITE_USASER,';

  Result := Result + '  I.ITE_LOCFIS AS LOCTST, ';
  Result := Result + '  I.ITE_LOCSUP AS SUPTST, ';

  Result := Result + '  I.ITE_LOCFIS AS LOCANT, ';
  Result := Result + '  I.ITE_LOCSUP AS SUPANT, ';

  Result := Result + '  I.ITE_TAMLCF,     ';
  Result := Result + '  I.ITE_TAMLCS,     ';
  Result := Result + '  C.ITE_NVLGIR,     ';
  Result := Result + '  0 AS DEFSER,     ';
  If (blnUDEVME) Or (blnCofEnd) Then
    Result := Result + '   DIGCON.AUTOINCREM AS DIGCON_AUTOINCREM, ';
  If (blnConDev) Or (((blnUDEVME) Or (blnCofEnd)) and (not blnCofDev)) Then
    Result := Result + ' AUX_ENTSIM, '
  Else
    Result := Result + ' CAST("N" AS CHAR(1)) AUX_ENTSIM, ';
  If blnResLtp Then
  Begin
    Result := Result + '  LTP.AUTOINCREM AS LTP_AUTINC,     ';
    Result := Result + '  CAST(IF(LTP.AUTOINCREM IS NOT NULL,"S","N") AS CHAR(1)) AS LTP_PENDEN,   ';
  End;

  If blnConDev Then
  Begin
    Result := Result + ' C.ITE_APLICA, ';

    If blnCofEnd Then
    Begin
      Result := Result + ' CAST(CASE ' +
        'WHEN @ITE_QTDNOT = @ITE_QTDCOF THEN "S" ' +
        'WHEN @ITE_QTDCOF > @ITE_QTDNOT THEN "E" ' +
        'WHEN @ITE_QTDCOF = 0 THEN " " ' +
        'ELSE "N" ' +
        'END AS CHAR(1)) AS ITE_STACON, ';
      Result := Result + ' CAST(IFNULL(@FDO_QTDITE,0.0000) AS DECIMAL(12,4)) AS ITE_QTDCON, '
    End
    Else
    Begin
      Result := Result + ' CAST("N" AS CHAR(1)) AS ITE_STACON, ';
      Result := Result + ' 0.0000 AS ITE_QTDCON, ';
    End;

    Result := Result + ' AUX.AUX_OPCDOC, ';
  End;

  Result := Result + '   DE2.AUTOINCREM AS INCDET,  ';

  Result := Result + '  IF((SELECT COUNT(*) FROM CADLOT       ';
  Result := Result + '      WHERE LOT_CODEMP = FDO_CODEMP AND ';
  Result := Result + '            LOT_CODITE = FDO_CODITE)    ';
  Result := Result + '      > 0,  ';

  If fCfgSis('LOTCRO', VarBoolean) Then
    Result := Result + ' @CODAMZ:= IF(FDO_PROACA = "S", "", IF(' + STR_LOTCRO + ' = "", IF(IFNULL(FDO_NUMLOT, "") = "", "A DEFINIR", FDO_NUMLOT), ' +  STR_LOTCRO + '))'
  Else
    Result := Result + ' @CODAMZ:= IF(FDO_PROACA = "S", "", IF(IFNULL(FDO_NUMLOT, "") = "", "A DEFINIR", FDO_NUMLOT))';

  Result := Result + '   , " ") AS ARMAZE, '; // NOME DO ARMAZEM QUANDO É UM SO

  Result := Result + '  "0" AS DISTRI, ';                // SE FOI DISTRIBUIDO ENTRE VARIOS ARMAZENS
  Result := Result + '  (IFNULL(FDO_QTDITE, 0) ' + IIF(blnEndParc, ' - IFNULL(FDO_QTDBAI,0)','') + ' + IFNULL(CL.LOT_SALDOS, 0) + IFNULL(CL.LOT_QTEF_A, 0) + IFNULL(CL.LOT_QTEF_F, 0) + IFNULL(CL.LOT_QTEF_P, 0)) AS LOT_SALDOS, ';

  Result := Result + ' IF((SELECT COUNT(*) FROM CADLOT ';
  Result := Result + '     WHERE ';
  Result := Result + '       LOT_CODITE = FDO_CODITE AND ';
  Result := Result + '       LOT_CODEMP = FDO_CODEMP AND LOT_STATUS = "S") > 0, "1", "0") AS TEMLOT, ';   // SE O ITEM POSSUI LOTE (ARMAZENS)

  Result := Result + '  "N" AS REMLOC, ';                // SE O ITEM POSSUI LOTE (ARMAZENS)
  Result := Result + '  FDO_REFUGO AS REFUGO, ';
  Result := Result + '  I.ITE_QTEF_A AS QTDEFA, '; //Quantidade de Entrega Futura Aguardando Cliente
  Result := Result + '  I.ITE_QTEF_F AS QTDEFF, '; //Quantidade de entrega Futura Falta produto.
  Result := Result + '  FGO_MEN001 AS MEN001, ';


  Result := Result + ' IF(IFNULL(G.AUTOINCREM, "") <> "",                                       ';
  Result := Result + '       (SELECT COUNT(1)                                                   ';
  Result := Result + '        FROM SEQGAR                                                       ';
  Result := Result + '        WHERE SEQ_PCMDET IN (SELECT B.AUTOINCREM                          ';
  Result := Result + '                             FROM MOVDET A                                ';
  Result := Result + '                             JOIN PCMDET B ON B.PCD_NUMPED = A.DET_PEDCOM ';
  Result := Result + '                                          AND B.PCD_ESPDOC = "PD"         ';
  Result := Result + '                                          AND B.PCD_CODEMP = A.DET_CODEMP ';
  Result := Result + '                                          AND B.PCD_CODFOR = A.DET_CODFOR ';
  Result := Result + '                                          AND B.PCD_CODITE = A.DET_CODITE ';
  Result := Result + '                             WHERE A.DET_SEQGER = G.AUTOINCREM)),0) > 0 AS GARANT, ';

  If fCfgSis('LOTCRO', VarBoolean) Then
  Begin
    // BUSCA ITENS COM PEDIDOS DE VENDA VINCULADOS AS REQUISIÇÕES DE COMPRA,
    //  POR SUA VEZ VINCULADAS AOS PEDIDOS DE COMPRA, VINCULADOS A NOTA DE ENTRADA,
    //  VINCULADA À RESERVA DE ESTOQUE
    Result := Result + ' CAST((SELECT GROUP_CONCAT(DISTINCT CONCAT(M.RCD_ESPPDV, "-", M.RCD_DOCPDV, "-", M.RCD_EMPPDV)) ';
    Result := Result + '  FROM                                             ';
    Result := Result + '    BAIPED                                         ';
    Result := Result + '  INNER JOIN PCMIRQ R ON R.PCM_SEQDET = BAI_AUTPED   ';
    Result := Result + '  INNER JOIN MOVRCD M ON M.AUTOINCREM = R.PCM_SEQREQ AND IFNULL(RCD_DOCPDV, "") <> "" ';
    Result := Result + '  WHERE                                            ';
    Result := Result + '    BAI_AUTDET = D.AUTOINCREM) AS CHAR(255)) AS PEDIDOS_VENDA_NORMAL,   ';

    // ENTRADA SIMPLIFICADA
    Result := Result + ' CAST((SELECT  ';
    Result := Result + '    GROUP_CONCAT(DISTINCT CONCAT(GF.FGO_ESPDAB, "-", GF.FGO_NMPDAB, "-", GF.FGO_EMPDAB))  ';
    Result := Result + '  FROM                                                                  ';
    Result := Result + '  MOVDET NV                                                             ';
    Result := Result + '  INNER JOIN FATDOR PF ON PF.FDO_TIPFAT = NV.DET_ESPDOC AND PF.FDO_NUMFAT = NV.DET_NUMDOC AND PF.FDO_EMPFAT = NV.DET_CODEMP ';
    Result := Result + '  INNER JOIN EXTGOR GF ON GF.FGO_SEQFGO = PF.FDO_SEQGER AND IFNULL(FGO_NMPDAB, "") <> "" ';
    Result := Result + '  WHERE  ';
    Result := Result + '     NV.AUTOINCREM = D.AUTOINCREM) AS CHAR(255)) AS PEDIDOS_VENDA_SIMPLIFICADA,  ';

    Result := Result + ' IFNULL((SELECT COUNT(*) FROM CADLOT WHERE LOT_CODEMP = FDO_CODEMP AND LOT_CODITE = FDO_CODITE AND LOT_STATUS = "S"), 0) AS QTDLOT,  ';

    Result := Result +  STR_LOTCRO + ' AS LOTCRO, ';
  End;

  Result := Result + '  FATDOR.AUTOINCREM, ';

  If fCfgSis('CTLEST') = '2' Then
    Result := Result + '  (SELECT AMZ_DESCRI FROM CADAMZ WHERE AMZ_CODAMZ = @CODAMZ AND AMZ_CODEMP = I.ITE_CODEMP) AS AMZDES '
  Else
    Result := Result + '  CONVERT("", CHAR(20)) AS AMZDES ';
  Result := Result + '  ,CL.LOT_DTAVAL, ';
  Result := Result + '   MAR_DESMAR AS DESMAR, ';

  Result := Result + ' C.ITE_PESOIT AS PESOIT, ';
  Result := Result + ' DS.ITE_EXPALT AS EXPALT, ';
  Result := Result + ' DS.ITE_EXPLAR AS EXPLAR, ';
  Result := Result + ' DS.ITE_EXPPRO AS EXPPRO ';

  If blnPerQpc Then
  Begin
    Result := Result + ' ,1 AS QTDPAC ';
    Result := Result + ' ,FDO_QTDITE AS QTDFRA  ';
  End;
  If blnPerQpc Then
    Result := Result + ',CAST("1" AS CHAR(1)) AS DEFPAC ';
  Result := Result + '  ,FATDOR.FDO_SEQGER ';
  Result := Result + ' , (SELECT CASE WHEN COUNT(1) > 0 THEN "SIM" ELSE "NÃO" END FROM MOVRCD INNER JOIN MOVRCG ON MOVRCG.RCG_CODIGO = MOVRCD.RCD_CODIGO AND MOVRCG.RCG_CODEMP = MOVRCD.RCD_CODEMP WHERE RCD_CODITE = FDO_CODITE) AS TEMREQ ';

  Result := Result + 'FROM                ';
  Result := Result + '  FATDOR            ';
  Result := Result + '  INNER JOIN EXTDOR   ON FATDOR.AUTOINCREM = FDO_SEQFDO ';
  Result := Result + '  INNER JOIN FATGOR   ON FATGOR.AUTOINCREM = FDO_SEQGER ';
  Result := Result + '  LEFT  JOIN EXTGOR   ON FGO_SEQFGO = FATGOR.AUTOINCREM AND IFNULL(FGO_BKPEND, "") = ""';

  Result := Result + '  LEFT JOIN DETELE DE2 ON DE2.AUTOINCREM = EXTDOR.FDO_DETELE ';


  Result := Result + '  LEFT JOIN MOVGER G  ON G.GER_NUMDOC =  TRIM(MID(FGO_DOCEND, 01, 12)) ';
  Result := Result + '                     AND G.GER_ESPDOC =  MID(FGO_DOCEND, 13, 2) ';
  Result := Result + '                     AND G.GER_SERIE_ =  TRIM(MID(FGO_DOCEND, 15, 3)) ';
  Result := Result + '                     AND G.GER_CODEMP =  MID(FGO_DOCEND, 18, 3) ';
  If blnConDev Then
    Result := Result + ' AND IF(MID(FGO_DOCEND, 29, 1)  = "C", IFNULL(G.GER_CODCLI, "") = MID(FGO_DOCEND, 21, 8), IFNULL(G.GER_CODFOR, "") = MID(FGO_DOCEND, 21, 8)) '
  Else
    Result := Result + '                     AND IFNULL(G.GER_CODFOR, "") =  MID(FGO_DOCEND, 21, 8) ';

  If (blnConDev) Or (((blnUDEVME) Or (blnCofEnd)) and (not blnCofDev)) Then
    Result := Result + ' LEFT JOIN AUXMOV AUX ON AUX.AUX_SEQGER = G.AUTOINCREM ';

  Result := Result + '  INNER JOIN CADITE C ON C.ITE_CODITE = FDO_CODITE ';
  Result := Result + '  INNER JOIN ITEGER I ON I.ITE_CODITE = FDO_CODITE AND I.ITE_CODEMP = FDO_CODEMP ';
  Result := Result + '  INNER JOIN CADUNI   ON   FDO_UNIDAD = UNI_CODUNI ';
  Result := Result + '  LEFT JOIN CADMAR ON MAR_CODMAR = C.ITE_CODMAR ';

  Result := Result + '  LEFT JOIN MOVDET  D ON D.AUTOINCREM = FDO_AUTDET ';       // ENCONTRA A NOTA DE ENTRADA QUE RESERVOU O PEDIDO
  Result := Result + '  LEFT JOIN MOVTRI TRI ON TRI.DET_SEQGER = D.AUTOINCREM                ';
  Result := Result + '  LEFT JOIN CADLOT CL ON CL.LOT_NUMLOT = FDO_NUMLOT AND CL.LOT_CODEMP = FDO_CODEMP AND CL.LOT_CODITE = FDO_CODITE ';
  Result := Result + '  LEFT JOIN MOVPRD PRD ON PRD.PRD_SEQDET = D.AUTOINCREM ';       // ENCONTRA QUANTIDADE PERDIDA
  Result := Result + '  LEFT JOIN DESSIT DS ON DS.ITE_CODITE = C.ITE_CODITE ';

  If blnResLtp Then
  Begin
    Result := Result + '  LEFT JOIN LOTPRE LTP ON LTP_SEQDET = D.AUTOINCREM  ';
    Result := Result + '                      AND IFNULL(LTP_DTAATU,"") = "" ';
    Result := Result + '                      AND IFNULL(LTP_BAIXAD,"N")="N" ';
  End;
  If (blnUDEVME) Or (blnCofEnd) Then
  Begin
    Result := Result + '  LEFT JOIN GERELE GER ON GER.GER_DOCENT = G.GER_NUMDOC ';
    Result := Result + '        AND GER.B07_SERIE = G.GER_SERIE_ ';
    Result := Result + '               AND IFNULL(GER.GER_ESPENT, "NF") = G.GER_ESPDOC ';
    Result := Result + '               AND GER.GER_CODFOR = G.GER_CODFOR ';
    Result := Result + '               AND GER.GER_EMPENT = G.GER_CODEMP ';
    Result := Result + '  LEFT JOIN DIGELE DIG ON GER.GER_IDEDIG = DIG.DIG_IDEDIG ';
    Result := Result + '                           AND DIG.DIG_CODITE = FDO_CODITE ';
    Result := Result + '                           AND GER.GER_CODEMP = DIG.DIG_CODEMP ';
    Result := Result + '  LEFT JOIN DIGCON ON DIC_MOVDET = D.AUTOINCREM ';
  End;

  Result := Result + 'WHERE               ';
  Result := Result + '  FATGOR.AUTOINCREM = ' + QuotedStr(FSeqFgo);
  If blnEndParc Then
    Result := Result + ' AND (FDO_QTDITE - IFNULL(FDO_QTDBAI,0)) > 0'
  Else
    Result := Result + '  AND FDO_QTDITE > 0 ';

  If fCfgSis('ENDBAI', varBoolean) And fUsaEnderecamento And (endDocumento.strEspDoc = 'OI') And (Not fCfgSis('OPISUG', varBoolean)) Then
    Result := Result + ' AND FDO_NUMLOT = "A DEFINIR" ';

  If ((blnUDEVME) Or (blnCofEnd)) and (not blnCofDev)Then
  Begin
    Result := Result + ') TMP HAVING FDO_QTDITE > 0'
  End;
end;

function TEnderecamentoProduto.fValidaCrossDocking(cdsConsulta: TUniClientDataSet): Boolean;
  Var
    frmMostraFaltaCrossdocking: TfrmMostraFaltaCrossdocking;
Begin
  Result := True;

  If fCfgSis('LOTCRO', VarBoolean) Then
  With cdsConsulta Do
  Try

    Filter := '(QTDLOT > 0) AND (LOTCRO = ' + QuotedStr('') + ') AND ((PEDIDOS_VENDA_NORMAL <> ' + QuotedStr('') + ') OR (PEDIDOS_VENDA_SIMPLIFICADA <> ' + QuotedStr('') + '))';

    Filtered := True;

    If Not IsEmpty Then
    Begin
      Result := False;

      FieldByName('FDO_CODITE').Alignment := taCenter;

      pCriarFormularios(TfrmMostraFaltaCrossdocking, frmMostraFaltaCrossdocking);

      With frmMostraFaltaCrossdocking Do
      Begin
        dtsConsulta.DataSet := cdsConsulta;

        ShowModal;
      End;

      pFreeAndNil(frmMostraFaltaCrossdocking);

    End;

  Finally

    Filtered := False;
    Filter   := '';

  End;

End;

function TEnderecamentoProduto.fGetSqlLoteItens(blnSoNumLot: Boolean = False; blnTransi: Boolean = True): String;
var
  blnEndParc: Boolean;
  strCFG_COFTRA : string;
begin
  strCFG_COFTRA := fCfgSis('COFTRA');
  blnEndParc := (Not fUsaRotinaWMS) And (fCfgSis('TPLREC', varString) = 'N');
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE  ';

  If blnSoNumLot Then
  Begin
    Result := Result + ' "N"               AS MARCAD, ';
    Result := Result + ' CADLOT.LOT_NUMLOT AS NUMLOT, ';
    Result := Result + ' COUNT(*)          AS QTDREG  ';
  End Else
  Begin
    Result := Result + '  FDO_CODITE,        ';
    Result := Result + '  FDO_NUMLOT,        ';
    Result := Result + '  @ITE_QTDEND_1 := IFNULL((SELECT SUM(FTE_QTDITE) FROM FATEND WHERE FTE_SEQGER = D.AUTOINCREM),0.0000) AS ITE_QTDEND, ';
    If ((blnCofEnd) or (blnUDEVME)) And (Not blnCofDev) Then
    Begin
      Result := Result + ' @FDO_QTDITE := IF((IFNULL(AUX_ENTSIM, "N") = "S" AND ("' + strCFG_COFTRA + '" = "N")) OR (DIGCON.AUTOINCREM IS NULL), ';
      Result := Result + ' ( FDO_QTDITE - IFNULL(PRD_QTDITE,0) ' + IIF(blnEndParc, ' - IFNULL(FDO_QTDBAI,0)','') + ') , ';
      Result := Result + ' ( IFNULL(DIC_QTDITE, 0) + IFNULL(DIC_QTDLDE, 0) - @ITE_QTDEND_1 ))AS FDO_QTDITE, '
    End
    Else
      Result := Result + '  FDO_QTDITE - IFNULL(PRD_QTDITE,0) ' + IIF(blnEndParc, ' - IFNULL(FDO_QTDBAI,0)','') + ' AS FDO_QTDITE,       ';
    Result := Result + '  FATDOR.AUTOINCREM AS SEQDET, ';
    Result := Result + '  CADLOT.*,           ';
    Result := Result + '  CADAMZ.AMZ_DESCRI AS AMZDES ';
  End;

  Result := Result + 'FROM                 ';
  Result := Result + '  FATDOR             ';
  Result := Result + '  INNER JOIN FATGOR   ON FATGOR.AUTOINCREM = FDO_SEQGER ';
  Result := Result + '  LEFT JOIN EXTDOR   ON FATDOR.AUTOINCREM = FDO_SEQFDO ';
  Result := Result + '  LEFT  JOIN EXTGOR   ON FGO_SEQFGO = FATGOR.AUTOINCREM AND IFNULL(FGO_BKPEND, "") = ""';
  Result := Result + '  INNER JOIN CADLOT ON LOT_CODITE = FDO_CODITE AND ';
  Result := Result + '                       LOT_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND ';
  Result := Result + '                       LOT_NUMLOT <> "A DEFINIR"  ';

  If (fCfgSis('GARANT', varBoolean)) And (Not fCfgSis('GARMAT', varBoolean)) Then
    Result := Result + '                     AND  LOT_NUMLOT <> "GARANTIA"   ';

  Result := Result + '                   AND LOT_STATUS = "S"   ';

  If (Not blnTransi) Then
    Result := Result + '                   AND LOT_TRANSI = "N"   ';

  Result := Result + '  LEFT JOIN CADAMZ ON LOT_NUMLOT = AMZ_CODAMZ AND AMZ_CODEMP =  LOT_CODEMP ';
  Result := Result + '  LEFT JOIN CADLOC L ON LOT_LOCFIS = L.LOC_CODLOC ';
  Result := Result + '                    AND LOT_CODEMP = L.LOC_CODEMP ';

  If fCfgSis('CTRAMZ', varBoolean) Then
  Begin
    Result := Result + ' INNER JOIN OPEAMZ Z ON Z.OPE_CODOPE = ' + QuotedStr(strLoginUsuarioLogado);
    Result := Result + '                    AND Z.OPE_CODAMZ = CADAMZ.AUTOINCREM ';
  End;

  Result := Result + '  LEFT JOIN DETELE ON DETELE.AUTOINCREM = EXTDOR.FDO_DETELE ';

  Result := Result + '  LEFT JOIN MOVGER G  ON G.GER_NUMDOC =  TRIM(MID(FGO_DOCEND, 01, 12)) ';
  Result := Result + '                     AND G.GER_ESPDOC =  MID(FGO_DOCEND, 13, 2) ';
  Result := Result + '                     AND G.GER_SERIE_ =  TRIM(MID(FGO_DOCEND, 15, 3)) ';
  Result := Result + '                     AND G.GER_CODEMP =  MID(FGO_DOCEND, 18, 3) ';
  If blnConDev Then
    Result := Result + ' AND IF(MID(FGO_DOCEND, 29, 1)  = "C", IFNULL(G.GER_CODCLI, "") = MID(FGO_DOCEND, 21, 8), IFNULL(G.GER_CODFOR, "") = MID(FGO_DOCEND, 21, 8)) '
  Else
    Result := Result + '                     AND IFNULL(G.GER_CODFOR, "") =  MID(FGO_DOCEND, 21, 8) ';

  If (blnConDev) Or (((blnUDEVME) Or (blnCofEnd)) and (not blnCofDev)) Then
    Result := Result + ' LEFT JOIN AUXMOV AUX ON AUX.AUX_SEQGER = G.AUTOINCREM ';

  Result := Result + '  LEFT JOIN MOVDET  D ON D.AUTOINCREM = FDO_AUTDET ';       // ENCONTRA A NOTA DE ENTRADA QUE RESERVOU O PEDIDO
  Result := Result + '  LEFT JOIN MOVTRI TRI ON TRI.DET_SEQGER = D.AUTOINCREM                ';
  If (blnUDEVME) Or (blnCofEnd) Then
  Begin
    Result := Result + '  LEFT JOIN GERELE GER ON GER.GER_DOCENT = G.GER_NUMDOC ';
    Result := Result + '        AND GER.B07_SERIE = G.GER_SERIE_ ';
    Result := Result + '               AND IFNULL(GER.GER_ESPENT, "NF") = G.GER_ESPDOC ';
    Result := Result + '               AND GER.GER_CODFOR = G.GER_CODFOR ';
    Result := Result + '               AND GER.GER_EMPENT = G.GER_CODEMP ';
    Result := Result + '  LEFT JOIN DIGELE DIG ON GER.GER_IDEDIG = DIG.DIG_IDEDIG ';
    Result := Result + '                           AND DIG.DIG_CODITE = FDO_CODITE ';
    Result := Result + '                           AND GER.GER_CODEMP = DIG.DIG_CODEMP ';
    Result := Result + '  LEFT JOIN DIGCON ON DIC_MOVDET = D.AUTOINCREM ';
  End;
  Result := Result + '  LEFT JOIN MOVPRD PRD ON PRD.PRD_SEQDET = D.AUTOINCREM ';       // ENCONTRA QUANTIDADE PERDIDA
  Result := Result + 'WHERE               ';
  Result := Result + '  FATGOR.AUTOINCREM = ' + QuotedStr(FSeqFgo);

  If blnSoNumLot Then
    Result := Result + ' GROUP BY NUMLOT ';
end;

Procedure TEnderecamentoProduto.pCarregaLotes;
Begin
  cdsTodosLotes.qryQuery.SQL.Text := fGetSqlLoteItens(True);
  cdsTodosLotes.fLeDados('TEnderecamentoProduto.pCarregaLotes');
  cdsTodosLotes.AfterPost := pAfterPostTodosLotes;

  If (cdsTodosLotes.IsEmpty) And (fCfgSis('CTRAMZ', varBoolean)) Then
  Begin
    pMensagemOk('O usuário logado não tem acesso a nenhum armazém. Por favor, verifique na rotina Controle de Armazém por Operadores');
  End;
End;

Procedure TEnderecamentoProduto.pAfterPostTodosLotes(dataSet: TDataSet);
  Var
    recNo: Integer;
Begin

  If dataSet.FieldByName('MARCAD').AsString = 'S' Then
  Begin
    Try
      dataSet.AfterPost := Nil;
      recNo := dataSet.RecNo;

      dataSet.First;
      While Not dataSet.Eof Do
      Begin

        If (recNo <> dataSet.RecNo) And (dataSet.FieldByName('MARCAD').AsString = 'S') Then
        Begin
          dataSet.Edit;
          dataSet.FieldByName('MARCAD').AsString := 'N';
          dataSet.Post;
        End;

        dataSet.Next;
      End;

      dataSet.RecNo := recNo;

    Finally
      dataSet.AfterPost := pAfterPostTodosLotes;
    End;

  End;
End;

procedure TEnderecamentoProduto.pAjustaCampoSeMudouArmazemLote(strAutInc: String);
Var
 qryAux : TUniQuery;
Begin

  If fTeveAlteracarArmazeLote(strAutInc) Then
    Exit;

  qryAux := fCriaQuery;
  Try
    qryAux.Close;
    qryAux.SQL.Add('UPDATE DEL_EXTDOR SET FDO_ALTAMZ = "N" WHERE FDO_SEQFDO = :AUTINC ');
    qryAux.ParamByName('AUTINC').AsString := strAutInc;
    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
End;

function TEnderecamentoProduto.fTeveAlteracarArmazeLote(strAutIncFatDor: String):Boolean;
  Var
    intIdxIte: Integer;
Begin
  Result := False;
  For intIdxIte := 0 To Length(FItens) -1 Do
  Begin
    If (FItens[intIdxIte].strAutInc.Equals(strAutIncFatDor) ) Then
    Begin
      Result := FItens[intIdxIte].blnhouveTrocaDeArmazemLote;
      Exit;
    End
  End;
End;

function TEnderecamentoProduto.fGetStrEnderecamento: String;
begin
  Result := '';

  Result := Result + fPadL(FDocume.strNumDoc , fTamNumDoc);
  Result := Result + fPadR(FDocume.strEspDoc , 02);
  Result := Result + fPadR(FDocume.strSerie_ , 03);
  Result := Result + fPadR(FDocume.strCodEmp , 03);
  Result := Result + fPadR(FDocume.strCliFor , 08);
  Result := Result + fPadR(FDocume.strTip_FC , 01);
end;

function TEnderecamentoProduto.fItensEnderecados: String;
Var
  intIdxIte: Integer;
Begin
  Result := EmptyStr;
  For intIdxIte := 0 To Length(FItens) -1 Do
  Begin
    If (FItens[intIdxIte].blnEnderecado) Then
      Result := Result + FItens[intIdxIte].strAutInc.QuotedString('"') + ',';
  End;
  Result := String.Join(',',Result.Split([',']));
end;

procedure TEnderecamentoProduto.pGetEnderecamentoByGERELE(strAutoincremGERELE : String);
var
  qryGERELE : TUniQuery;
begin

  qryGERELE := fCriaQuery(nil);
  try
    qryGERELE.SQL.Add('SELECT                     ');
    qryGERELE.SQL.Add('  GER_DOCENT,              ');
    qryGERELE.SQL.Add('  GER_ESPENT,              ');
    qryGERELE.SQL.Add('  GER_EMPENT,              ');
    qryGERELE.SQL.Add('  B07_SERIE,               ');
    qryGERELE.SQL.Add('  GER_CODFOR               ');
    qryGERELE.SQL.Add('FROM                       ');
    qryGERELE.SQL.Add('  GERELE                   ');
    qryGERELE.SQL.Add('WHERE                      ');
    qryGERELE.SQL.Add('  AUTOINCREM = :AUTOINCREM ');

    qryGERELE.ParamByName('AUTOINCREM').AsString := strAutoincremGERELE;
    qryGERELE.Open;

    FDocume.strNumDoc := qryGERELE.FieldByName('GER_DOCENT').AsString;
    FDocume.strEspDoc := qryGERELE.FieldByName('GER_ESPENT').AsString;
    FDocume.strCodEmp := qryGERELE.FieldByName('GER_EMPENT').AsString;
    FDocume.strSerie_ := qryGERELE.FieldByName('B07_SERIE').AsString;
    FDocume.strCliFor := qryGERELE.FieldByName('GER_CODFOR').AsString;
    FDocume.strTip_FC := 'F';

    qryGERELE.Close;

    pCarregarAutoIncremPedido();

    If (FSeqFgo = '') And (FDocume.strNumDoc = '') Then
    Begin
      qryGERELE.SQL.Clear;
      qryGERELE.SQL.Add('SELECT * FROM MOVGER ');
      qryGERELE.SQL.Add('WHERE MOVGER.AUTOINCREM = "' + strAutoincremGERELE + '"');
      qryGERELE.Open;

      FDocume.strNumDoc := qryGERELE.FieldByName('GER_NUMDOC').AsString;
      FDocume.strEspDoc := qryGERELE.FieldByName('GER_ESPDOC').AsString;
      FDocume.strCodEmp := qryGERELE.FieldByName('GER_CODEMP').AsString;
      FDocume.strSerie_ := qryGERELE.FieldByName('GER_SERIE_').AsString;
      FDocume.strCliFor := qryGERELE.FieldByName('GER_CODFOR').AsString;
      FDocume.strTip_FC := 'F';
      pCarregarAutoIncremPedido();
      strAutIncPed := FSeqFgo;
    End
    Else
    Begin
      qryGERELE.SQL.Clear;
      qryGERELE.SQL.Add('SELECT');
      qryGERELE.SQL.Add('  FATGOR.AUTOINCREM');
      qryGERELE.SQL.Add('FROM');
      qryGERELE.SQL.Add('  EXTGOR');
      qryGERELE.SQL.Add('  INNER JOIN FATGOR ON FATGOR.AUTOINCREM = FGO_SEQFGO');
      qryGERELE.SQL.Add('  LEFT JOIN CADCLI ON CLI_CODCLI = MID(FGO_DOCEND, 21, 8)');
      qryGERELE.SQL.Add('  LEFT JOIN CADFOR ON FOR_CODFOR = MID(FGO_DOCEND, 21, 8)');
      qryGERELE.SQL.Add('  LEFT JOIN MOVGER ON GER_NUMDOC = TRIM(MID(FGO_DOCEND, 01, 12))');
      qryGERELE.SQL.Add('    AND GER_ESPDOC = MID(FGO_DOCEND, 13, 2)');
      qryGERELE.SQL.Add('    AND GER_CODEMP = MID(FGO_DOCEND, 18, 3)');
      qryGERELE.SQL.Add('    AND ((GER_CODFOR = MID(FGO_DOCEND, 21, 8) AND GER_TIP_FC = MID(FGO_DOCEND, 29, 1))');
      qryGERELE.SQL.Add('      OR (GER_CODCLI = MID(FGO_DOCEND, 21, 8) AND GER_TIP_FC = MID(FGO_DOCEND, 29, 1))) ');
      qryGERELE.SQL.Add('    AND GER_SERIE_ = MID(FGO_DOCEND, 15, 3)');
      qryGERELE.SQL.Add('  LEFT JOIN GERELE ON GERELE.GER_DOCENT = MOVGER.GER_NUMDOC');
      qryGERELE.SQL.Add('                  AND GERELE.GER_ESPENT = MOVGER.GER_ESPDOC');
      qryGERELE.SQL.Add('                  AND GERELE.GER_EMPENT = MOVGER.GER_CODEMP');
      qryGERELE.SQL.Add('                  AND GERELE.GER_CODFOR = MOVGER.GER_CODFOR');
      qryGERELE.SQL.Add('                  AND IFNULL(GERELE.B07_SERIE, "")  = IFNULL(GER_SERIE_, "")');
      qryGERELE.SQL.Add('    ');
      qryGERELE.SQL.Add('WHERE TRUE');
      qryGERELE.SQL.Add('  AND FGO_DOCEND IS NOT NULL');
      qryGERELE.SQL.Add('  AND MID(FGO_DOCEND, 18, 3) = "'+FDocume.strCodEmp+'"');
      qryGERELE.SQL.Add('  AND GERELE.AUTOINCREM =  "'+strAutoincremGERELE+'"');
      qryGERELE.Open;

      strAutIncPed := qryGERELE.FieldByName('AUTOINCREM').AsString;
    End;
  Finally
    FreeAndNil(qryGERELE);
  end;
end;

procedure TEnderecamentoProduto.pGravaSeriesEnderecamento(ASeqDetSer, ASeqFdo, ASeqMovDet: String);
var qrySql, qryInsert: TUniQuery;
begin
  If ASeqDetSer = ''  Then
    Exit;
  qrySql := fCriaQuery;
  qryInsert := fCriaQuery;
  Try
    qrySql.Close;
    qrySql.SQL.Clear;
    qrySql.SQL.Add(' SELECT SER_NUMSER FROM DETSER WHERE SER_SEQGER = :AUTINC ');
    qrySql.ParamByName('AUTINC').AsString := ASeqDetSer;
    qrySql.Open;

    If (Not qrySql.IsEmpty) Then
    Begin
      qrySql.First;

      While Not qrySql.Eof Do
      Begin
        qryInsert.Close;
        qryInsert.SQL.Clear;
        qryInsert.SQL.Add('INSERT INTO ENTSER (AUTOINCREM, ENT_SEQFDO, ENT_SEQDET, ENT_NUMSER)');
        qryInsert.SQL.Add('VALUES (:AUTINC, :SEQFDO, :SEQDET, :NUMSER)');
        qryInsert.ParamByName('AUTINC').AsString := fRetAutoIncrem('ENTSER',VS_strCodEmp);
        qryInsert.ParamByName('SEQFDO').AsString := ASeqFdo;
        qryInsert.ParamByName('SEQDET').AsString := ASeqMovDet;
        qryInsert.ParamByName('NUMSER').AsString := qrySql.FieldByName('SER_NUMSER').AsString;
        qryInsert.ExecSQL;

        qrySql.Next;
      End;
    End;
  Finally
    FreeAndNil(qrySql);
    FreeAndNil(qryInsert);
  End;
end;

function TEnderecamentoProduto.fQtdItens: Integer;
begin
  Result := High(FItens)+1;
end;

function TEnderecamentoProduto.fTodosEnderecados: Boolean;
Var
  intIdxIte: Integer;
Begin
  Result := True;
  For intIdxIte := 0 To Length(FItens) -1 Do
    If Not FItens[intIdxIte].blnEnderecado Then
      Exit(False);
end;

procedure TEnderecamentoProduto.pAtualizaLocalizacaoItens;
  var
    qryUpdate: TUniQuery;
    intIdxIte: Integer;
    objCadLot: TCadLot;
begin
  inherited;

  objCadLot := TCadLot.Create(Nil);

  qryUpdate := fCriaQuery;

  With qryUpdate, SQL Do
  Begin
    Close;
    Clear;

    Add('UPDATE ITEGER              ');
    Add('SET ITE_LOCFIS = :LOCFIS,  ');
    Add('    ITE_LOCSUP = :LOCSUP,  ');
    Add('    ITE_TAMLCF = :TAMLCF,  ');
    Add('    ITE_TAMLCS = :TAMLCS   ');
    Add('WHERE                      ');
    Add('  ITE_CODITE = :CODITE AND ');
    Add('  ITE_CODEMP = :CODEMP     ');

    For intIdxIte := 0 To Length(FItens) -1 Do
    Begin
      If FItens[intIdxIte].blnRefugo And
        (Not FItens[intIdxIte].blnEnderecado) Then
        Continue;

      {se tem lote o item, nao pode atualizar a localização física da iteger}
      If FItens[intIdxIte].blnTemLote Then
        Continue;

      ParamByName('LOCFIS').AsString := FItens[intIdxIte].strLocFis;
      ParamByName('LOCSUP').AsString := FItens[intIdxIte].strLocSup;
      ParamByName('TAMLCF').AsString := FItens[intIdxIte].strTamLcF;
      ParamByName('TAMLCS').AsString := FItens[intIdxIte].strTamLcS;
      ParamByName('CODITE').AsString := FItens[intIdxIte].strCodIte;
      ParamByName('CODEMP').AsString := FItens[intIdxIte].strCodEmp;

      ExecSQL;

      If (Not fEmptyStr(FItens[intIdxIte].strCodAmz)) And blnCadLoc And
         FItens[intIdxIte].blnRemLoc Then
        objCadLot.fTrocaLocFisica(FItens[intIdxIte].strCodIte,
                                  FItens[intIdxIte].strCodAmz,
                                  FItens[intIdxIte].strLocFis);

      If fGeraLogLocFis(FItens[intIdxIte].strLocAnt, FItens[intIdxIte].strLocFis) Then
      Begin
        fGravaLogLocFisica(FItens[intIdxIte].strCodIte,
                           FItens[intIdxIte].strLocAnt,
                           FItens[intIdxIte].strLocFis,
                           1,
                           '');
      End;

      If fGeraLogLocFis(FItens[intIdxIte].strSupAnt, FItens[intIdxIte].strLocSup) Then
      Begin
        fGravaLogLocFisica(FItens[intIdxIte].strCodIte,
                           FItens[intIdxIte].strSupAnt,
                           FItens[intIdxIte].strLocSup,
                           1,
                           '');
      End;

    End;

  End;

  FreeAndNil(qryUpdate);
  FreeAndNil(objCadLot);
end;

procedure TEnderecamentoProduto.pAtualizasaldoSaldoDosPedidosQueDevemPassarAReservarEstoque;
var qryComand : TUniQuery;
begin
  If Not fCfgSis('FXRESS', varBoolean) Then
    Exit;
  If not qryPedidosQueDevemHabilitarReserva.IsEmpty Then
  Begin
    qryComand := fCriaQuery;
    try
      qryPedidosQueDevemHabilitarReserva.First;
      while not qryPedidosQueDevemHabilitarReserva.Eof do
      begin
        If RoundTo(qryPedidosQueDevemHabilitarReserva.FieldByName('RCD_QTDITE').AsFloat, -2) =
           RoundTo(qryPedidosQueDevemHabilitarReserva.FieldByName('TOTAL_REQ_ATENDIDA').AsFloat, -2) Then
        begin
          qryComand.SQL.Clear;
          qryComand.SQL.Add('UPDATE EXTDOR SET FDO_RESERV = "S"');
          qryComand.SQL.Add(' WHERE FDO_SEQFDO = "'+qryPedidosQueDevemHabilitarReserva.FieldByName('FDO_SEQFDO').AsString+'"');
          qryComand.ExecSQL;
          qryComand.SQL.Clear;
          qryComand.SQL.Add('UPDATE ITEGER SET ITE_REPAUD = "S"');
          qryComand.SQL.Add(' WHERE ITE_CODITE = "'+qryPedidosQueDevemHabilitarReserva.FieldByName('FDO_CODITE').AsString+'"');
          qryComand.SQL.Add('   AND ITE_CODEMP = "'+qryPedidosQueDevemHabilitarReserva.FieldByName('FDO_CODEMP').AsString+'"');
          qryComand.ExecSQL;
        end;

        qryComand.SQL.Clear;
        qryComand.SQL.Add('INSERT INTO RREEXT(EXT_SEQDOR, EXT_SEQGER, EXT_QTDATD) VALUES ');
        qryComand.SQL.Add('                  (:EXT_SEQDOR, :EXT_SEQGER, :EXT_QTDATD)');
        qryComand.ParamByName('EXT_SEQDOR').AsString := qryPedidosQueDevemHabilitarReserva.FieldByName('FDO_SEQFDO').AsString;
        qryComand.ParamByName('EXT_SEQGER').AsString := qryPedidosQueDevemHabilitarReserva.FieldByName('AUTOINCREM').AsString;
        qryComand.ParamByName('EXT_QTDATD').AsFloat  := qryPedidosQueDevemHabilitarReserva.FieldByName('DET_QTDITE').AsFloat;

        qryComand.ExecSQL;

        qryPedidosQueDevemHabilitarReserva.Next;
      end;

    Finally
      freeAndNil(qryComand);
    end;
  End;


end;

function fEhPedidoReservaEstoqueEnderecamento(strNumPed, strEspPed, strCodEmp: String): Boolean;
begin

  Result := False;

  If fEmptyStr(strNumPed) And fEmptyStr(strCodEmp) Then
    Exit;

  Result := Not fEmptyStr(fCampoTabela('FGO_DOCEND',
                                       'FATGOR INNER JOIN EXTGOR ON AUTOINCREM = FGO_SEQFGO',
                                       ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'],
                                       [strNumPed, strEspPed, strCodEmp],
                                       False));

end;


function TEnderecamentoProduto.fGerarLote: TEnderecamentoProduto;
begin
  Result := Self;
  pGerarNumeroLote;
  If Not fExisteLote Then
    fInserirLote
  Else
    fAtualizarLote;
  pAtualizarNumeroLote;
end;

function TEnderecamentoProduto.fGerarLotes: TEnderecamentoProduto;
Begin
  Result := Self;
  FcdsItens.First;
  FcdsItens.DisableControls;
  FstrItensBalanco := '';
  While Not FcdsItens.Eof Do
  Begin
    If fItemBalanco Then
      FstrItensBalanco := FstrItensBalanco +
        IfThen(fEmptyStr(FstrItensBalanco),'', ',') +
        FcdsItens.FieldByName('FDO_CODITE').AsString
    Else
      fGerarLote;

    FcdsItens.Next;
  End;
  FcdsItens.EnableControls;

  If Not fEmptyStr(FstrItensBalanco ) Then
    pMensagemOk('NÃO FOI POSSIVEL CRIAR LOTES PARA OS PRODUTOS ABAIXO, POIS O MESMO ENCONTRA-SE EM CONTAGEM DE BALANÇO.' +
      ' É PRECISO CONCLUIR AS CONTAGENS PARA CRIAR OS LOTES E FINALIZAR O ENDEREÇAMENTO. ' +
      ' PRODUTOS: ' +  FstrItensBalanco);
End;

function TEnderecamentoProduto.fEhProdutoAcabado(ACodIte: String): Boolean;
var i: integer;
begin
  Result := False;
  For i := 0 tO High(FItens) Do
  Begin
    If FItens[i].strCodIte =  ACodIte Then
      If FItens[i].blnIteAca Then
        Exit(true);
  End;
end;

function TEnderecamentoProduto.SoTemProdutoAcabado: Boolean;
var i: integer;
begin
  Result := True;
  For i := 0 tO High(FItens) Do
  Begin
   If Not FItens[i].blnIteAca Then
     Exit(False);
  End;
end;

function TEnderecamentoProduto.fExisteLote: Boolean;
Var
  qryTemp: TUniQuery;
Begin
  Result := False;
  qryTemp := fCriaQuery;
  Try
    qryTemp.SQL.Add('SELECT AUTOINCREM FROM CADLOT WHERE LOT_CODEMP = ' + endDocumento.strCodEmp.QuotedString +
      ' AND LOT_NUMLOT = ' + FstrNumLot.QuotedString);
    qryTemp.Open;
    FAutIncLot := qryTemp.FieldByName('AUTOINCREM').AsString;
    Result := Not qryTemp.IsEmpty;
  Except
    On E:Exception Do
      pMensagensErro(E.Message, '[fExisteLote]');
  End;
End;

procedure TEnderecamentoProduto.pGerarNumeroLote;
Var
  intNumDoc,
  intCodFor: Largeint;

  strSerie,
  strSeqIte: String;
Begin
  intNumDoc := FDocume
    .strNumDoc
    .ToInt64;

  intCodFor := FDocume
    .strCliFor
    .ToInt64;

  strSerie := FDocume
    .strSerie_;

  strSeqIte := FcdsItens
    .FieldByName('DET_NITEM_')
    .AsString;

  FstrNumLot :=
    intNumDoc
      .ToString +  '.' +
    intCodFor
      .ToString +  '.' +
    fStrZero(strSerie,3) + '.' +
    fStrZero(strSeqIte,4);
End;


function TEnderecamentoProduto.fInserirLote: TEnderecamentoProduto;
Var
  qryTemp: TUniQuery;
  strAutInc: String;
  strCodIte,
  strCodEmp,
  strLocFis: String;
Begin
  Result := Self;

  qryTemp := fCriaQuery;
  Try
    strCodIte := FcdsItens.FieldByName('FDO_CODITE').AsString;
    strCodEmp := endDocumento.strCodEmp;
    strLocFis := FcdsItens.FieldByName('ITE_LOCFIS').AsString;

    strAutInc := fRetAutoIncrem('CADLOT', strCodEmp);

    qryTemp.SQL.Add(' INSERT INTO CADLOT(AUTOINCREM, ');
    qryTemp.SQL.Add('                    LOT_NUMLOT, ');
    qryTemp.SQL.Add('                    LOT_CODEMP, ');
    qryTemp.SQL.Add('                    LOT_CODITE, ');
    qryTemp.SQL.Add('                    LOT_DTAFAB, ');
    qryTemp.SQL.Add('                    LOT_DTAVAL, ');
    qryTemp.SQL.Add('                    LOT_DTABAL, ');
    qryTemp.SQL.Add('                    LOT_SALBAL, ');
    qryTemp.SQL.Add('                    LOT_SALDOS, ');
    qryTemp.SQL.Add('                    LOT_LOCFIS, ');
    qryTemp.SQL.Add('                    LOT_STATUS) ');
    qryTemp.SQL.Add('            VALUES (:AUTINC,    ');
    qryTemp.SQL.Add('                    :NUMLOT,    ');
    qryTemp.SQL.Add('                    :CODEMP,    ');
    qryTemp.SQL.Add('                    :CODITE,    ');
    qryTemp.SQL.Add('                    :DTAFAB,    ');
    qryTemp.SQL.Add('                    :DTAVAL,    ');
    qryTemp.SQL.Add('                    :DTABAL,    ');
    qryTemp.SQL.Add('                    :SALBAL,    ');
    qryTemp.SQL.Add('                    :SALDOS,    ');
    qryTemp.SQL.Add('                    :LOCFIS,    ');
    qryTemp.SQL.Add('                    :STATUS)    ');


    qryTemp.ParamByName('AUTINC').AsString   := strAutInc;
    qryTemp.ParamByName('NUMLOT').AsString   := FstrNumLot;
    qryTemp.ParamByName('CODEMP').AsString   := strCodEmp;
    qryTemp.ParamByName('CODITE').AsString   := strCodIte;
    qryTemp.ParamByName('DTAFAB').AsDateTime   := fNow();
    qryTemp.ParamByName('DTAVAL').AsDateTime   := fNow();
    qryTemp.ParamByName('DTABAL').AsDateTime := fNow - 1;
    qryTemp.ParamByName('SALBAL').AsFloat    := 0.00;
    qryTemp.ParamByName('SALDOS').AsFloat    := 0.00;
    qryTemp.ParamByName('LOCFIS').AsString   := strLocFis;
    qryTemp.ParamByName('STATUS').AsString   := 'S';
    qryTemp.ExecSQL;

  Except
    On E:Exception Do
      pMensagensErro(E.Message, '[fGerarLote]');
  End;
End;

function TEnderecamentoProduto.fAtualizaLocFisAcager: Boolean;
var EndItem: TEndItem;
begin
  Result := True;
  For EndItem in FItens do
    If (EndItem.blnIteAca) And (Not fEmptyStr(EndItem.strLocFis)) then
      Result := Result and TProdAcabado.fAtualizaLocFis(EndItem.strCodAca,
                                                        EndItem.strEmpAca,
                                                        VS_StrCodEmp,
                                                        EndItem.strLocFis);

end;

function TEnderecamentoProduto.fAtualizarLote: TEnderecamentoProduto;
Var
  qryTemp: TUniQuery;
Begin
  Result := Self;
  qryTemp := fCriaQuery;
  Try
    qryTemp.SQL.Add(' UPDATE CADLOT SET');
    qryTemp.SQL.Add(' LOT_LOCFIS = :LOCFIS ');
    qryTemp.SQL.Add('WHERE AUTOINCREM = :AUTINC AND IFNULL(:LOCFIS,"") <> ""');
    qryTemp.ParamByName('LOCFIS').AsString   := FcdsItens.FieldByName('ITE_LOCFIS').AsString;
    qryTemp.ParamByName('AUTINC').AsString   := FAutIncLot;
    qryTemp.ExecSQL;
  Except
    On E:Exception Do
      pMensagensErro(E.Message, '[fGerarLote]');
  End;
End;


procedure TEnderecamentoProduto.pAtualizarNumeroLote;
Begin
  FcdsItens.Edit;
  FcdsItens.FieldByName('ARMAZE').AsString := FstrNumLot;
  FcdsItens.Post;
End;

Function TEnderecamentoProduto.fCarregarItens(cdsItens: TUniClientDataSet): TEnderecamentoProduto;
Begin
  Result := Self;
  FcdsItens := cdsItens;
  SeqFatEnd := '';
End;

Function TEnderecamentoProduto.fItemBalanco: Boolean;
Begin
  Result := FcdsItens.FieldByName('ITE_DIGCON').AsString = 'S';
End;

Procedure TEnderecamentoProduto.pAdicionarItemReservaLotPre(AStrAutIncLotPre: String; ACdsLotes: TUniClientDataSet; AFltQtdIte: Double; AStrCodIte: String);
Begin
  blnResEstPenLotpre := True;
  Try
    If Assigned(ACdsLotes) Then
    Begin
      If (Not ACdsLotes.isEmpty) Then
      Begin
        ACdsLotes.DisableControls;
        ACdsLotes.First;
        While Not ACdsLotes.Eof Do
        Begin
          pAddItem(ACdsLotes.FieldByName('CODITE').AsString, ACdsLotes.FieldByName('NUMLOT').AsString, ACdsLotes.FieldByName('QTDITE').AsFloat, '', '', False, AStrAutIncLotPre);
          ACdsLotes.Next;
        End;
      End
      Else
        pAddItem(AStrCodIte,'',AFltQtdIte,'','',False, AStrAutIncLotPre);
    End
    Else
      pAddItem(AStrCodIte,'',AFltQtdIte,'','',False, AStrAutIncLotPre);
  Finally
    If Assigned(ACdsLotes) Then
      ACdsLotes.EnableControls;
  End;
End;


procedure TEnderecamentoProduto.pMarcaEnderecamentoFinalizado;
var qryComand: TUniQuery;
begin
  qryComand := fCriaQuery;
  Try
    qryComand.SQL.Add(' UPDATE GERELE SET GER_ENDFIN = "S"');
    qryComand.SQL.Add(' WHERE B08_NNF = "' + endDocumento.strNumDoc + '"');
    qryComand.SQL.Add('   AND GER_ESPENT = "' +endDocumento.strEspDoc + '"');
    qryComand.SQL.Add('   AND IFNULL(B07_SERIE, "") =  "' +endDocumento.strSerie_ + '"');
    qryComand.SQL.Add('   AND GER_EMPENT = "' +endDocumento.strCodEmp + '"');
    qryComand.SQL.Add('   AND GER_CODFOR = "' +endDocumento.strCliFor + '"');
    qryComand.ExecSQL;
  Finally
    FreeAndNil(qryComand);
  End;

End;

function TEnderecamentoProduto.fMarcaEnderecamentoFinalizado: Boolean;
var qryConsulta: TUniQuery;
begin
  Result := False;

  If Not ((fCfgSis('COFEND', varBoolean)) And (fCfgSis('TIPPNT', varString) = 'D')) Then
    Exit;
  //Verifica se a conferencia foi finalizada
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT COUNT(1) QTD');
    qryConsulta.SQL.Add('  FROM GERELE');
    qryConsulta.SQL.Add(' WHERE B08_NNF = "' + endDocumento.strNumDoc + '"');
    qryConsulta.SQL.Add('   AND GER_ESPENT = "' +endDocumento.strEspDoc + '"');
    qryConsulta.SQL.Add('   AND IFNULL(B07_SERIE, "") =  "' +endDocumento.strSerie_ + '"');
    qryConsulta.SQL.Add('   AND GER_EMPENT = "' +endDocumento.strCodEmp + '"');
    qryConsulta.SQL.Add('   AND GER_CODFOR = "' +endDocumento.strCliFor + '"');
    qryConsulta.SQL.Add('   AND GER_DTACON IS NOT NULL');
    qryConsulta.Open;
    //Se a conferencia ainda não foi finalizada não pode finalizar o enderecamento
    If qryConsulta.FieldByName('QTD').AsInteger = 0 Then
      Exit;

    qryConsulta.SQL.Clear;

    qryConsulta.SQL.Add(fGetSqlItensPedido);
    qryConsulta.Open;

    If qryConsulta.IsEmpty Then
      Exit(True);
  Finally
    FreeAndNil(qryConsulta);
  End
{}
End;

function TEnderecamentoProduto.fConsulta(cdsConsulta: TUniClientDataSet): TEnderecamentoProduto;
Begin
  Result := Self;
  FcdsConsulta := cdsConsulta;
End;


function TEnderecamentoProduto.fGravarFatEnd: TEnderecamentoProduto;
Var
  dobQtdIte: Double;
Begin
  Result := Self;
  FcdsConsulta.First;
  While Not FcdsConsulta.Eof Do
  Begin
    case FcdsConsulta.FieldByName('TEMLOT').AsInteger Of
      0: dobQtdIte := FcdsConsulta.FieldByName('FDO_QTDITE').AsCurrency;
      1: dobQtdIte := FcdsConsulta.FieldByName('ITE_QTDENR').AsCurrency;
    else
      dobQtdIte := 0;
    End;
    If dobQtdIte > 0 Then
    Begin
      SeqFatEnd := TFatEnd
        .fNew
        .fSeqGer(FcdsConsulta.FieldByName('SEQDET').AsString)
        .fCodIte(FcdsConsulta.FieldByName('FDO_CODITE').AsString)
        .fQtdIte(dobQtdIte)
        .fExecutar.fGetSequenciaGerada;

      pReprocessarSaldoProduto(FcdsConsulta.FieldByName('FDO_CODEMP').AsString,
        FcdsConsulta.FieldByName('FDO_CODITE').AsString);
    End;
    FcdsConsulta.Next;
  End;
End;

function TEnderecamentoProduto.fGravarQuantidadeParcialEnderecamento: TEnderecamentoProduto;
Var
  objQuery: TUniQuery;
  objQryDigCon: TUniQuery;
  dobQtdIte: Double;

Begin
  Result := Self;
  objQuery := fCriaQuery;
  objQryDigCon := fCriaQuery;
  objQuery.SQL.text := 'UPDATE FATDOR SET FDO_QTDBAI = FDO_QTDBAI + :QTDITE WHERE AUTOINCREM = :AUTOINCREM';
  objQryDigCon.SQL.Text := 'UPDATE DIGCON ' +
                           ' INNER JOIN FATDOR ON FATDOR.AUTOINCREM =  DIGCON.DIC_SEQDOR' +
                           ' SET DIC_DIVEND = DIC_QTDLDE, ' +
                           '                  DIC_QTDEND = IFNULL(FDO_QTDBAI, 0) - IFNULL((SELECT DEV_QTDBAI FROM DEVVEN WHERE DEV_INCFDO = DIGCON.DIC_SEQDOR), 0) ' +
                           ' WHERE DIGCON.DIC_SEQDOR = :AUTOINCREM';
  Try
    FcdsConsulta.First;
    While Not FcdsConsulta.Eof Do
    Begin
      case FcdsConsulta.FieldByName('TEMLOT').AsInteger Of
        0: dobQtdIte := FcdsConsulta.FieldByName('FDO_QTDITE').AsCurrency;
        1: dobQtdIte := FcdsConsulta.FieldByName('ITE_QTDENR').AsCurrency;
      Else
        dobQtdIte := 0;
      End;
      If dobQtdIte > 0 Then
      Begin
        objQuery.ParamByName('QTDITE').AsCurrency := dobQtdIte;
        objQuery.ParamByName('AUTOINCREM').AsString := FcdsConsulta.FieldByName('AUTOINCREM').AsString;
        objQryDigCon.ParamByName('AUTOINCREM').AsString := FcdsConsulta.FieldByName('AUTOINCREM').AsString;
        objQuery.ExecSQL;
        objQryDigCon.ExecSQL;
      End;
      FcdsConsulta.Next;
    End;
  Finally
    FreeAndNil(objQuery);
    FreeAndNil(objQryDigCon);
  End;
End;

procedure TEnderecamentoProduto.pSetIdEnd;
begin
  SeqFatEnd := TFatEnd.fNew.fSetSequencia(SeqFatEnd).fGetSequenciaGerada;
end;

procedure TEnderecamentoProduto.pReprocessarSaldoProduto(strCodEmp, strCodIte: String);
var
  qryComand : TUniQuery;
Begin
  qryComand := fCriaQuery;
  Try
    qryComand.SQL.Add('UPDATE ITEGER SET ITE_REPAUD = "S"');
    qryComand.SQL.Add(' WHERE ITE_CODITE = "' + strCodIte + '"');
    qryComand.SQL.Add('   AND ITE_CODEMP = "' + strCodEmp + '"');
    qryComand.ExecSQL;
  Finally
    FreeAndNil(qryComand);
  End;
End;

procedure TEnderecamentoProduto.pAtualizaDadosEcommerce(strCodIte: String; fltPesoIt, fltExpAlt, fltExpLar, fltExpPro : Double);
var
  qryComand : TUniQuery;
Begin
  qryComand := fCriaQuery;
  Try
    qryComand.Close;
    qryComand.SQL.Clear;
    qryComand.SQL.Add('UPDATE CADITE SET ');
    qryComand.SQL.Add('     ITE_PESOIT =:PESOIT  ');
    qryComand.SQL.Add(' WHERE ITE_CODITE =:CODITE ');
    qryComand.ParamByName('CODITE').AsString := strCodIte;
    qryComand.ParamByName('PESOIT').AsFloat  := fltPesoit;
    qryComand.ExecSQL;

    qryComand.Close;
    qryComand.SQL.Clear;
    qryComand.SQL.Add('UPDATE DESSIT SET ');
    qryComand.SQL.Add('     ITE_EXPALT =:EXPALT, ');
    qryComand.SQL.Add('     ITE_EXPLAR =:EXPLAR, ');
    qryComand.SQL.Add('     ITE_EXPPRO =:EXPPRO  ');
    qryComand.SQL.Add(' WHERE ITE_CODITE =:CODITE ');
    qryComand.ParamByName('CODITE').AsString := strCodIte;
    qryComand.ParamByName('EXPALT').AsFloat  := fltExpAlt;
    qryComand.ParamByName('EXPLAR').AsFloat  := fltExpLar;
    qryComand.ParamByName('EXPPRO').AsFloat  := fltExpPro;
    qryComand.ExecSQL;
  Finally
    FreeAndNil(qryComand);
  End;
End;

function TEnderecamentoProduto.fSituacaoEnderecamento(srtAutoIncrem: String): TSituacaoEnderecamento;
var
  qryComand : TUniQuery;
  intAguardandoDevolucao: Integer;
  intAguardandoConferencia: Integer;
Begin
  Result := seAEnderecar;
  intAguardandoDevolucao := Ord(seAguardandoDevolucao);
  intAguardandoConferencia := Ord(seAguardandoConferencia);
  qryComand := fCriaQuery;
  Try
    qryComand.SQL.Add('SET @DEVOLUCAO := ' + IntToStr(intAguardandoDevolucao) + ';');
    qryComand.SQL.Add('SET @CONFERENCIA := '  + IntToStr(intAguardandoConferencia) +';');
    qryComand.SQL.Add('SET @AUTOINCREM := "' + srtAutoIncrem + '";');

    qryComand.SQL.Add('SELECT');
    qryComand.SQL.Add('    @QTDNOT := SUM(DIC_QTDTOT) AS QTDNOT,');
    qryComand.SQL.Add('    @QTDCONF := SUM(DIC_QTDITE) AS QTDCONF,');
    qryComand.SQL.Add('    @QTDDEV := SUM(DIC_QTDDEV) AS QTDDEV,');
    qryComand.SQL.Add('    CASE');
    qryComand.SQL.Add('        WHEN SUM(DIC_QTDTOT) = SUM(DIC_QTDDEV) THEN  @DEVOLUCAO');
    qryComand.SQL.Add('        WHEN SUM(DIC_QTDITE) + SUM(DIC_QTDDEV) < SUM(DIC_QTDTOT) THEN @CONFERENCIA');
    qryComand.SQL.Add('        WHEN SUM(DIC_QTDITE) + SUM(DIC_QTDDEV) = SUM(DIC_QTDTOT) THEN @DEVOLUCAO ');
    qryComand.SQL.Add('    END AS STATUS_RESERVA');
    qryComand.SQL.Add('FROM DIGCON');
    qryComand.SQL.Add('WHERE DIC_SEQGER = @AUTOINCREM');
    qryComand.Open;

    If Not qryComand.IsEmpty Then
      Result := TSituacaoEnderecamento(qryComand.FieldByName('STATUS_RESERVA').AsInteger);
  Finally
    FreeAndNil(qryComand);
  End;
End;

Procedure TEnderecamentoProduto.pCriaCdsPacotes;
Begin
  FCdsPacotes := TUniClientDataSet.Create(Nil);
  With FCdsPacotes.FieldDefs.AddFieldDef Do Begin Name := 'AUTINC'; DataType := ftString; Size := 20; Required := False; End;
  With FCdsPacotes.FieldDefs.AddFieldDef Do Begin Name := 'QTDPAC'; DataType := ftFloat; End;
  With FCdsPacotes.FieldDefs.AddFieldDef Do Begin Name := 'QTDFRA'; DataType := ftFloat; End;

  FCdsPacotes.CreateDataSet;
  TFloatField(FCdsPacotes.FieldByName('QTDPAC')).DisplayFormat := fMskDigitos(4);
  TFloatField(FCdsPacotes.FieldByName('QTDFRA')).DisplayFormat := fMskDigitos(4);
  With FCdsPacotes.Aggregates.Add Do
  Begin
    Expression := 'SUM(QTDPAC * QTDFRA)';
    AggregateName := 'TOTAL';
    Active := True;
  End;

End;

end.
