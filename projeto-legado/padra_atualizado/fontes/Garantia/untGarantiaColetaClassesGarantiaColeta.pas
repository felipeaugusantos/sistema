unit untGarantiaColetaClassesGarantiaColeta;

interface

uses
  Uni,
  DB,
  untFuncFat,
  untGarant,
  untGarantiaColetaClassesRetornoColeta,
  untGarantiaColetalibTypes,
  untGarantiaLibFuncoesFaturamento,
  untTypesSistema,
  UniClientDataSet;
Type
  TGarantiaColeta = class
  private
//    cdsDados: TUniClientDataSet;
    FatVenda: TFatVenda;
    FRetornoColeta: TRetornoColeta;
    strPortad: String;
    strClaFisGar: String;
    strClaFisInd: String;
    strNumDup: String;
    strCodOpe: String;
    procedure pCarregarConfiguracoesGarantia;
    procedure pCarregarDadosFatVendas;
    function fGeraReposicaoCliente: Boolean;
    function fInserirCredito(const fltValDup: Double; const strNumDup, strIncDoc, strHistoricoCredito : String): Boolean;
    function fIncluirItens: boolean;
    function fGravaItensGarantia(ItensRetornoColeta: TItensRetornoColeta; objMovGag: TMovGag): boolean;
    function fGravaGarantia(const TipoGarantia: TTipoGarantia): Boolean;
    function fRecebimentoClienteGarantia(TipoGarantia: TTipoGarantia): Boolean;
    function fObterIndClaFis(const strEstCli, strEstEmp: String): String;
    procedure pDefinirClafisInd;
    procedure pDefinirDataHoraEntrada;
    function fObterClassificacaoFiscal: String;
    function fOutrasSaidasFaturamento: Boolean;
    function fCriarCreditoMercadoriaSemAvaria: Boolean;
    function fGravaArquivos(objFatVenda: TFatVenda): Boolean;
    function fCriaCdsItensMovGad: TUniClientDataSet;
    procedure pTransferirDadosCdsMovGad(ItensRetornoColeta: TItensRetornoColeta; cdsDados: TUniClientDataSet);
    function fGravarRecebimentoCliente(ItensRetornoColeta: TItensRetornoColeta): Boolean;
  public
    strNumEnt: String;
    strIncGag: String;
    strNomFrm: String;
    dtaDtaEnt: TDateTime;
    constructor Create(Owner: TRetornoColeta);
    destructor Destroy;Override;
    function fExecutar:Boolean;
  end;

implementation
uses
  Math,
  System.strUtils, untFuncoes, untFatDadosFiscais, untGarantiaLibDiversos,
  untFuncoesSimples, System.SysUtils, untCadRec,
//  untGarantiaColetaLibfuncoes,
  System.DateUtils, untGravando, untFuncFatTypes;

{ TGarantiaColeta }

constructor TGarantiaColeta.Create(Owner: TRetornoColeta);
begin
  FRetornoColeta := Owner;
  pDefinirDataHoraEntrada;
  pCarregarConfiguracoesGarantia;

end;

destructor TGarantiaColeta.Destroy;
begin
  if Assigned(FatVenda) then
    FatVenda.Free;
  inherited;
end;

function TGarantiaColeta.fCriaCdsItensMovGad: TUniClientDataSet;
Var
  cdsDados: TUniClientDataSet;
begin
  cdsDados := TUniClientDataSet.Create(Nil);
  Result := cdsDados;
  cdsDados.FieldDefs.Add('CODITE',ftString,5);
  cdsDados.FieldDefs.Add('AUTINC',ftString,20);
  cdsDados.FieldDefs.Add('INCORI',ftString,20);
  cdsDados.CreateDataSet;
end;

function TGarantiaColeta.fCriarCreditoMercadoriaSemAvaria: Boolean;
Var
  fltValDup: Double;
  strNumDup: String;
begin
  fltValDup := FRetornoColeta.fTotalCreditoSemAvaria;
  Result := fltValDup > 0;
  if Result then
  begin
    strNumDup := fObterNumDuplicata;
    Result := fInserirCredito(fltValDup, strNumDup, FRetornoColeta.strIncGer, FRetornoColeta.fObterObsCredito);
  end;
end;

function TGarantiaColeta.fGeraReposicaoCliente: Boolean;
begin
  Try
    Try
      fatVenda                := TFatVenda.CreateInstance('VN');
      fatVenda.strOpcDocTrue  := 'GC';
      fatVenda.blnVerEstOrc   := False;
      fatVenda.strOpcDoc      := 'OU';
      fatVenda.strNomeForm    := 'frmFatVendas';
      fatVenda.blnComTansacao := True;
      fatVenda.strEntFat := 'S';
      pCarregarDadosFatVendas;
      pCarregaDadosClienteGarantia(FRetornoColeta.strCodCli, fatVenda);
      fatVenda.strClaFisRecGarantia := Self.strClaFisGar;
      Result := fOutrasSaidasFaturamento;
      If Result Then
        Result := fGravaArquivos(fatVenda);
    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TRetornoColefa.fGerarReposicaoCliente')
      End;
    End;
  Finally
    if Assigned(FatVenda) then
      FreeAndNil(FatVenda);
  End;
end;

function TGarantiaColeta.fGravaArquivos(objFatVenda: TFatVenda): Boolean;
Var
  cdsDados: TUniClientDataSet;
begin
  cdsDados := Nil;
  Try
    Try
      cdsDados := fCriaCdsItensMovGad;
      pTransferirDadosCdsMovGad(FRetornoColeta.ItensReposicao, cdsDados);
      objfatVenda.cdsMovGad  := cdsDados;

      if objfatVenda.strOpcDoc = 'OU' then
        objfatVenda.blnDTEXREP := True;

      pCriarFormularios(TfrmGravando,frmGravando);
      frmGravando.strChave            := 'FATFATURA';
      frmGravando.fExecutarAcao       := objfatVenda.fGravaArquivos;
      frmGravando.lblGravando.Caption := 'Aguarde, Gravando Recebimento Cliente (Garantia)...';
      frmGravando.ShowModal;
      Result                          := frmGravando.blnConfirma;

      pFreeAndNil(frmGravando);

      If (Not Result) Then
      Begin
        Exit;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fConfirmaVenda - frmGravando]');
        pFreeAndNil(frmGravando);
      End;
    End;
  Finally
    if Assigned(cdsDados) then
      FreeAndNil(cdsDados);
  End;

end;

function TGarantiaColeta.fGravaGarantia(const TipoGarantia: TTipoGarantia): Boolean;
Var
  objMovGag : TMovGag;
  strNumDup: String;
  ItensRetornoColeta: TItensRetornoColeta;
begin
  objMovGag := nil;
  ItensRetornoColeta := Nil;
  Try
    objMovGag := TMovGag.Create(Nil);
    if TipoGarantia = TTipoGarantia.CreditoCliente then
      strNumDup :=  fObterNumDuplicata;
    {$Region 'fGravaMovGag'}
    Result := objMovGag.fGravaMovGag(Self.dtaDtaEnt,
                                     Self.strCodOpe,
                                     FRetornoColeta.strCodCli,
                                     FRetornoColeta.strCodCli,
                                     strNumDup,
                                     True,
                                     '',
                                     '',
                                     '');
    {$Endregion}
    if Result then
    begin
      case TipoGarantia of
        TTipoGarantia.AguardarRetornoFornecedor: ItensRetornoColeta := FRetornoColeta.ItensEnvioFornecedor;
        TTipoGarantia.CreditoCliente: ItensRetornoColeta := FRetornoColeta.ItensCreditoCliente;
        TTipoGarantia.ReposicaoProduto: ItensRetornoColeta := FRetornoColeta.ItensReposicao;
      end;
      ItensRetornoColeta.strIncGag :=  objMovGag.strAutInc;
      ItensRetornoColeta.strNumEnt :=  objMovGag.strNumEnt;
      Result := fGravaItensGarantia(ItensRetornoColeta, objMovGag);
    end;

    if Result then
    begin
      Result := Self.fGravarRecebimentoCliente(ItensRetornoColeta);
    end;
  Finally
    if Assigned(objMovGag) then
      FreeAndNil(ObjMovGag);
  End;
end;

function TGarantiaColeta.fGravaItensGarantia(ItensRetornoColeta: TItensRetornoColeta; objMovGag: TMovGag): boolean;
Var
  aItem: TItemRetornoColeta;
  strAutInc: String;
begin
  Result := ItensRetornoColeta.count = 0;
  if Not Result then
  begin
    for aItem in ItensRetornoColeta do
    begin
      strAutInc := EmptyStr;
      {$Region 'fGravaMovGad'}
      Result :=   objMovGag.objMovGad.fGravaMovGad(objMovGag.strAutInc,
                                                   strAutInc,
                                                   FRetornoColeta.strNumDoc,
                                                   FRetornoColeta.strEspDoc,
                                                   FRetornoColeta.strEmpDoc,
                                                   Ifthen(aItem.fGerarReposicao,'S','N'),
                                                   aItem.strCodIte,
                                                   aItem.fObterValIteAvariado,
                                                   aItem.fltQtdAvaria,
                                                   Ifthen(aItem.fGerarReposicao,aItem.fltQtdAvaria,0),
                                                   0,
                                                   0,
                                                   0,
                                                   'Retorno de coleta',
                                                   '',
                                                   aItem.strGarFil,
                                                   aItem.strNumLot,
                                                   aItem.fLancarCredito,
                                                   aItem.strCodFor,
                                                   '');
      {$Endregion}
      if Result then
        aItem.strIncGad := strAutInc
      else
        Break;
    end;
  end;
end;

function TGarantiaColeta.fGravarRecebimentoCliente(ItensRetornoColeta: TItensRetornoColeta): Boolean;
Var
  Item: TItemRetornoColeta;
begin
  Result := False;
  for Item in ItensRetornoColeta do
  begin
    Result := TMovGag.fInsereMovGrc(Item.strIncGad,Item.strIncDet,'DV','F',Item.strIncOri);
    if Not Result then
      Break;
  end;
end;

procedure TGarantiaColeta.pCarregarConfiguracoesGarantia;
Var
  strClaFis: String;
begin
  Self.strPortad := fCfgSis('PORGAR', varString);
  strClaFis := fCfgSis('CREPGC');
  Self.strClaFisGar := Copy(strClaFis,1,3);
  Self.strCodOpe := strLoginUsuarioLogado;
  pDefinirClafisInd;
end;

procedure TGarantiaColeta.pCarregarDadosFatVendas;
begin
  pCriarCdsVenda(nil);
  cdsVenda.EmptyDataSet;
  fatVenda.strOriDoc := 'V';
  fatVenda.strCodVen := strLoginUsuarioLogado;
  fatVenda.strNomVen := fRetNomVendRep(fatVenda.strCodVen);
  fatVenda.strConPag := '01000';
  fatVenda.strEntFut := 'N';
  fatVenda.strEntFat := 'N';
  fatVenda.strCliOri := '';
  fatVenda.strEspDoc := 'NF';
  pCarregaDadosClienteGarantia(FRetornoColeta.strCodCli, FatVenda);
end;

procedure TGarantiaColeta.pDefinirClafisInd;
Var
  strEstEmp: String;
  strEstCli: String;
begin
  strEstEmp := fCadEmp('ESTADO');
  strEstCli := fRetNomCidade(FRetornoColeta.strCodCid,1);
  Self.strClaFisInd := fObterIndClaFis(strEstCli, strEstEmp);
end;

procedure TGarantiaColeta.pDefinirDataHoraEntrada;
begin
  Self.dtaDtaEnt := EncodeDateTime(YearOf(VS_Date),
                                   MonthOf(VS_Date),
                                   DayOf(VS_Date),
                                   Hourof(fNow),
                                   Minuteof(fNow),
                                   SecondOf(fNow),0);
end;

function TGarantiaColeta.fExecutar:Boolean;
Var
  Operacao: TTipoGarantia;
  Operacoes: TSetTipoGarantia;
begin
  Result := False;
  Operacoes :=  FRetornoColeta.fGetOperacoes;
  for Operacao in Operacoes do
  begin
    case Operacao of
      TTipoGarantia.Nenhum: Result :=  Self.fCriarCreditoMercadoriaSemAvaria;
      TTipoGarantia.AguardarRetornoFornecedor..TTipoGarantia.ReposicaoProduto:
        begin
          Result := Self.fRecebimentoClienteGarantia(Operacao) ;
        end
      Else
        Result := False;
    end;

    Exclude(Operacoes, Operacao);

    if Not Result then
      Break;
  end;
end;

procedure TGarantiaColeta.pTransferirDadosCdsMovGad(ItensRetornoColeta: TItensRetornoColeta; cdsDados: TUniClientDataSet);
Var
  aItem: TItemRetornoColeta;
begin
  for aItem in ITensRetornoColeta do
  begin
    cdsDados.Append;
    cdsDados.FieldByName('CODITE').AsString := aItem.strCodIte;
    cdsDados.FieldByName('AUTINC').AsString := aItem.strIncGad;
    cdsDados.FieldByName('INCORI').AsString := aItem.strincDet;
    cdsDados.Post;
  end;
end;

function TGarantiaColeta.fIncluirItens: boolean;
  Var
    qryGenIte   : TUniQuery;
    intContador : Integer;
    recForTin   : TForTin;
    recMadeira  : TDadosMadeira;
    RegTempParametros: TParametrosPAdicionarRegistroTemporaria;
    ItemRetornoColeta: TItemRetornoColeta;
begin
  Try
    Try
      Result := True;
      intContador := 0;
      qryGenIte := fCriaQuery();
      for ItemRetornoColeta in FRetornoColeta.ItensReposicao do
      begin
        inc(intContador);

        If (intContador = 1) Then
        Begin
          fatVenda.strCodVen    := Self.strCodOpe;
          fatVenda.strNomVen    := fRetNomVendRep(fatVenda.strCodVen);
        End;

        fGetItem(qryGenIte,ItemRetornoColeta.strCodite);

        {$REGION 'ADICIONAR TABELA TEMPORARIA'}
        RegTempParametros := TParametrosPAdicionarRegistroTemporaria.Create(cdsVenda, Nil, recMadeira);
        RegTempParametros.cdsDados :=         cdsVenda;
        RegTempParametros.btnAdicionar :=     Nil;
        RegTempParametros.strIdePro :=        'NOR';
        RegTempParametros.strCodIte :=        ItemRetornoColeta.strCodIte;
        RegTempParametros.strCodFor :=        ItemRetornoColeta.strCodFor;
        RegTempParametros.fltUniOri :=        ItemRetornoColeta.fltUnitar;
        RegTempParametros.fltUniVis :=        ItemRetornoColeta.fltUnitar;
        RegTempParametros.fltUniTar :=        ItemRetornoColeta.fltUnitar;
        RegTempParametros.fltQtdIte :=        ItemRetornoColeta.fltQtdAvaria;
        RegTempParametros.fltTotIte :=        ItemRetornoColeta.fObterValIteReposicao;
        RegTempParametros.fltPreCus :=        ItemRetornoColeta.fltPreCus;
        RegTempParametros.strDocDev :=        FRetornoColeta.strNumDoc;
        RegTempParametros.strEspDev :=        FRetornoColeta.strEspDoc;
        RegTempParametros.strEmpDev :=        FRetornoColeta.strEmpDoc;
        RegTempParametros.fltUniDig :=        ItemRetornoColeta.fltUnitar;
        RegTempParametros.strTabPre :=        ItemRetornoColeta.strTabpre;
        RegTempParametros.fltCusIte :=        ItemRetornoColeta.fltPrecus;
        RegTempParametros.strCodVenIte :=     Self.strCodOpe;
        RegTempParametros.strNumLot :=        ItemRetornoColeta.strLotSai;
        RegTempParametros.fltQtdOri :=        ItemRetornoColeta.fltQtdAvaria;
        RegTempParametros.fltTotCus :=        ItemRetornoColeta.fCustoTotalReposicao;
        RegTempParametros.strEntSai :=        'S';
        RegTempParametros.strCodGru :=        qryGenIte.FieldByName('ITE_CODGRU').AsString;
        RegTempParametros.strDesOri :=        qryGenIte.FieldByName('ITE_DESITE').AsString;
        RegTempParametros.strDesFab :=        qryGenIte.FieldByName('ITE_DESFAB').AsString;
        RegTempParametros.strUnidad :=        qryGenIte.FieldByName('UNI_CODUNI').AsString;
        RegTempParametros.strCodUni :=        qryGenIte.FieldByName('UNI_CODUNI').AsString;
        RegTempParametros.strCodMar :=        qryGenIte.FieldByName('ITE_CODMAR').AsString;
        RegTempParametros.strRefere :=        qryGenIte.FieldByName('ITE_REFERE').AsString;
        RegTempParametros.strComLub :=        qryGenIte.FieldByName('ITE_COMLUB').AsString;
        RegTempParametros.fltIpiSai :=        qryGenIte.FieldByName('ITE_IPISAI').AsFloat;
        RegTempParametros.fltDesMax :=        qryGenIte.FieldByName('ITE_DESMAX').AsFloat;
        RegTempParametros.fltPreVe1 :=        qryGenIte.FieldByName('ITE_PREVE1').AsFloat;
        RegTempParametros.fltPreVe2 :=        qryGenIte.FieldByName('ITE_PREVE2').AsFloat;
        RegTempParametros.fltPreVe3 :=        qryGenIte.FieldByName('ITE_PREVE3').AsFloat;
        RegTempParametros.fltPreVe4 :=        qryGenIte.FieldByName('ITE_PREVE4').AsFloat;
        RegTempParametros.fltPreVe5 :=        qryGenIte.FieldByName('ITE_PREVE5').AsFloat;
        RegTempParametros.fltPreVe6 :=        qryGenIte.FieldByName('ITE_PREVE6').AsFloat;
        RegTempParametros.fltPreVe7 :=        qryGenIte.FieldByName('ITE_PREVE7').AsFloat;
        RegTempParametros.fltSaldos :=        qryGenIte.FieldByName('ITE_SALDOS').AsFloat;
        RegTempParametros.fltComVar :=        qryGenIte.FieldByName('ITE_COMVAR').AsFloat;
        RegTempParametros.fltComAta :=        qryGenIte.FieldByName('ITE_COMATA').AsFloat;
        RegTempParametros.fltComDis :=        qryGenIte.FieldByName('ITE_COMDIS').AsFloat;
        RegTempParametros.fltTotUlt :=        qryGenIte.FieldByName('ITE_PREULT').AsFloat * ItemRetornoColeta.fltQtdAvaria;
        RegTempParametros.fltImpUlt :=        qryGenIte.FieldByName('ITE_IMPULT').AsFloat;
        RegTempParametros.fltPreUlt :=        qryGenIte.FieldByName('ITE_PREULT').AsFloat;
        RegTempParametros.fltPreMed :=        qryGenIte.FieldByName('ITE_PREMED').AsFloat;
        RegTempParametros.strClaIpi :=        qryGenIte.FieldByName('ITE_CLAIPI').AsString;
        RegTempParametros.strCodAbf :=        qryGenIte.FieldByName('ABF_CODABF').AsString;
        RegTempParametros.fltPesoIt :=        qryGenIte.FieldByName('ITE_PESOIT').AsFloat;
        RegTempParametros.fltPesLiq :=        qryGenIte.FieldByName('ITE_PESLIQ').AsFloat;
        RegTempParametros.fltGPeCom :=        fatVenda.fRetPerComGrupo(qryGenIte.FieldByName('ITE_CODGRU').AsString);
        RegTempParametros.strCodFab :=        qryGenIte.FieldByName('ITE_CODFAB').AsString;
        RegTempParametros.fltMarMin :=        qryGenIte.FieldByName('ITE_MARMIN').AsFloat;
        RegTempParametros.fltMarMSG :=        qryGenIte.FieldByName('ITE_MARMSG').AsFloat;
        RegTempParametros.fltMarMGe :=        qryGenIte.FieldByName('ITE_MARMGE').AsFloat;
        RegTempParametros.strMarca :=         fRetNomMarca(qryGenIte.FieldByName('ITE_CODMAR').AsString);
        RegTempParametros.fltPreCom :=        qryGenIte.FieldByName('ITE_PRECOM').AsFloat;
        RegTempParametros.fltQtdPon :=        qryGenIte.FieldByName('ITE_QTPPRO').AsFloat;
        RegTempParametros.strObrCpf :=        qryGenIte.FieldByName('ITE_OBRCPF').AsString;
        RegTempParametros.strSigUni :=        fRetSiglaUnidade(qryGenIte.FieldByName('UNI_CODUNI').AsString);
        RegTempParametros.fltIpiEnt :=        qryGenIte.FieldByName('ITE_IPIENT').AsFloat;
        RegTempParametros.fltFreEnt :=        qryGenIte.FieldByName('ITE_FREENT').AsFloat;
        RegTempParametros.strCodBar :=        qryGenIte.FieldByName('ITE_CODBAR').AsString;
        RegTempParametros.strImpDir :=        qryGenIte.FieldByName('ITE_IMPDIR').AsString;
        RegTempParametros.fltTotImp :=        qryGenIte.FieldByName('ITE_IMPULT').AsFloat * ItemRetornoColeta.fltQtdAvaria;
        RegTempParametros.strDesIte :=        ItemRetornoColeta.strDesIte;
        RegTempParametros.strIncPis :=        'N';
        RegTempParametros.strEntFut :=        'N';
        RegTempParametros.recForTin :=        recForTin;
        RegTempParametros.blnBxSbIt :=        False;
        RegTempParametros.strPigBas :=        'N';
        RegTempParametros.strIdeDev :=        'NOR';
        RegTempParametros.fltFatAce :=        1;
        RegTempParametros.blnPodAlt :=        True;
        RegTempParametros.dtaEmiDev :=        0;
        RegTempParametros.strAltPCoIte :=     'N';
        RegTempParametros.strCliBus :=        'N';
        RegTempParametros.strLibUni :=        'N';
        RegTempParametros.strClaFis :=        Self.fObterClassificacaoFiscal;
        RegTempParametros.strProEmb :=        'N';
        RegTempParametros.strPromoc :=        'N';
        RegTempParametros.intSeqInd :=        -1;
        RegTempParametros.fltVolPro :=        0.00;
        RegTempParametros.intOrdite :=        intContador;
        RegTempParametros.blnProAca :=        False;
        TParametrosPAdicionarRegistroTemporaria.pAdicionarRegistroTemporaria(fatVenda,RegTempParametros);
        RegTempParametros.Free;
        {$ENDREGION}
      End;

      FreeAndNil(qryGenIte);

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message,'[TfrmGarantiaColeta.fIncluiItens]');
      End;
    End;
  Finally
    if Assigned(QryGenIte) then
      QryGenIte.Free;
  End;
end;

function TGarantiaColeta.fInserirCredito(const fltValDup: Double; const strNumDup, strIncDoc, strHistoricoCredito: String): boolean;
Var
  fltValor: Double;
begin
  fltValor := fltValDup * -1;
  {$Region 'fGravaCadRec'}
  Result := fGravaCadRec(Self.strNomFrm,
                         'INCLUSÃO',
                         strNumDup,
                         'A',                                                                // Parcela
                         0,                                                                  // Sequencial de Baixa
                         'CC',                                                               // Espécie
                         FRetornoColeta.strCodCli,                                                     // Cliente
                         VS_strCodEmp,                                                       // Empresa
                         Self.strCodOpe,                                                     // Vendedor
                         Self.strCodOpe,                                                     // Digitador
                         Self.strPortad,                                                          // Portador
                         Self.dtaDtaEnt,                                                            // Data de Cadastro
                         Self.dtaDtaEnt,                                                            // Data de Vencimento
                         fltValor,                                                         // Valor da Duplicata
                         fltValor,                                                         // Valor Original
                         0.0,                                                                // Despesa de Cobrança
                         'N',                                                                // Desconto
                         strHistoricoCredito,                                               // Histórico 1
                         '',                                                                 // Histórico 2
                         '',                                                                 // Portador da Baixa
                         '',                                                                 // Centro de Custo da Baixa
                         '',                                                                 // Operador da Baixa
                         '',                                                                 // Documento da Baixa
                         0.0,                                                                // Valor do Recebimento
                         0,                                                                  // Data do Recebimento
                         'N',
                         '',                                                                 // Código do Evento
                         '',                                                                 // Código Velho (CONVERSÃO)
                         '',                                                                 // Tipo de Fora (Condição de Pagamento)
                         '',                                                                 // Código da Condição de Pagamento
                         False,
                         '',                                                                 // Codigo do Centro de Custo
                         0,                                                                  // Sequencial de Controle
                         0,
                         '',                                                                 // Observação de Agrupamento 1
                         '',                                                                 // Observação de Agrupamento 2
                         '',                                                                // Observação de Agrupamento 3
                         '',    //   strCtaSer
                         0,     //   fltValSer
                         0,     //   intResCai
                         0,     //   fltVlrCom
                         0,     //   fltFatCom
                         '',    //   strEmpBai
                         '',    //   strEmp_PD
                         '',    //   strDocDiv
                         '',    //   strEspDiv
                         '',    //   strEmpDiv
                         '',    //   strCliDiv
                         0,     //   fltVlrRep
                         0,     //   fltFatRep
                         '',    //   strCodRep
                         0,     //   fltValIPI
                         0,     //   fltValRet
                         'N',   //   strOriF11
                         0,     //   fltDesSuj
                         0,     //   fltJurSuj
                         0,     //   fltValCqP
                         0,     //   fltValCqV
                         0,     //   fltValDin
                         0,     //   fltValCar
                         0,     //   fltValOrd
                         0,     //   fltValFin
                         '',    //   strBarCon
                         0,     //   fltPerDPo
                         0,     //  intQtdDAV
                         0,     //   fltVrTrDv
                         '',    //   strHisBai
                         0,     //   fltValAce
                         0,     //   fltValFre
                         0,     //   fltDifOri
                         0,     //   fltValAnt
                         0,     //   fltComDiv
                         0,     //   fltFatDiv
                         '',    //   strCodDiv
                         0,     //   fltValFCP
                         'INCLUSÃO', //     strStatusDEPS:
                         '',  //    strOpcDoc:
                         '',  //     strAutincMovGerFC:
                         strIncDoc); //   strINCDOC:
  {$Endregion}
end;

function TGarantiaColeta.fObterClassificacaoFiscal: String;
begin
  Result := Self.strClaFisInd + Self.strClaFisGar;
end;

function TGarantiaColeta.fObterIndClaFis(const strEstCli, strEstEmp: String): String;
begin
  If SameText(strEstCli, strEstEmp) Then
    Result := '5'
  Else
    Result := '6';
end;

function TGarantiaColeta.fOutrasSaidasFaturamento: Boolean;
  Var
    blnConfirma: Boolean;
    strEstEmp: String;
begin
  Result      := False;
  blnConfirma := False;

  Try
    blnConfirma := fIncluirItens;

    If (blnConfirma) Then
    Begin
      fatVenda.pCarregaAliquotasRetencao;

      fatVenda.pPreencheMatrizFechamento;

      fatVenda.pCalculaPesBruLiq;

      fatVenda.pCalculaTotGer(False, False);

      If Not SameText(fatVenda.strCliOrg,'S') then
        if Not (fatVenda.fltDesEsp > 0) Then
          fatVenda.fltDesEsp := fatVenda.fltDesEsp + fatVenda.fltIcmOrg;

      fatVenda.pCalculaTotGer(False, False);

      fatVenda.pCalculaTotGer;

      fatVenda.strClaFis := fObterClassificacaoFiscal;
      fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

      fatVenda.pDestacaRetencoes;
      fatVenda.pRetemImpostosNoDescontoEspecial;
      fatVenda.pCalculaTotalParaCadRec;

      fatVenda.pRateiaValores;

      If (fatVenda.strEspDoc = 'NF') Then
      Begin
        Try
          pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);


          strEstEmp := fRetUFEmpresa;

          frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text    := fatVenda.strClafis;
          frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Text    := fatVenda.strDesCla;
          frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled := False;
          frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Enabled := False;
          frmFatDadosFiscais.blnForcaEdiBas    := True;
          frmFatDadosFiscais.fatVenda := fatVenda;

          frmFatDadosFiscais.Caption := frmFatDadosFiscais.Caption;
          frmFatDadosFiscais.ShowModal;

          blnConfirma := frmFatDadosFiscais.blnConfirma;

        Except
          On E: Exception Do
          Begin
            blnConfirma := False;
            pMensagensErro(E.Message, '[TGarantiaColeta.fOutrasSaidasFaturamento_1]');
          End;
        End;

        pFreeAndNil(frmFatDadosFiscais);
      End;

      If (Not blnConfirma) Then
      Begin
        Exit;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TGarantiaColeta.fOutrasSaidasFaturamento_2]');
    End;
  End;

  Result := blnConfirma;
end;

function TGarantiaColeta.fRecebimentoClienteGarantia(TipoGarantia: TTipoGarantia): Boolean;
begin
  Result := Self.fGravaGarantia(TipoGarantia);
  if Result then
  begin
    case TipoGarantia of
      TTipoGarantia.CreditoCliente:
        begin
          Self.strNumDup := fObterNumDuplicata;
          Result := Self.fInserirCredito(FRetornoColeta.fTotalCreditoAvaria,
                                         Self.strNumDup,
                                         FRetornoColeta.strIncGer,
                                         FRetornoColeta.fObterObsCredito);
        end;

      TTipoGarantia.ReposicaoProduto:
        begin
          Result := Self.fGeraReposicaoCliente;
        end;
    end;
  end;
end;

end.
