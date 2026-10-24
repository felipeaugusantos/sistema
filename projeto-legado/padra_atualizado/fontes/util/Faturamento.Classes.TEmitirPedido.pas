unit Faturamento.Classes.TEmitirPedido;

interface

uses Classes, untFuncFat, untFuncFatTypes, EditFocus, MaskEditFocus, Uni,
  cxProgressBar, stdCtrls, Forms, SysUtils, Windows, Graphics, TypInfo, Math,
  UniClientDataSet, Faturamento.Classes.TValidarVenda, untFuncoesSimples, untTypesSistema,
  Faturamento.Origem.TOrigemFaturamento, Faturamento.Classes.TFatVendaBase;

Type
  TDadosPedido = Record
    strCodCli,
    strCodVen,
    strCodDig,
    strConPag,
    strCodCnd,
    strCodFpg,
    strMen001,
    strMen002,
    strTipPed,
    strTipFre,
    strTipFin,
    strTabPre,
    strEntFat,
    strNumPok,
    strNumCmp,
    strMenExp,
    strCodTra,
    strTipOpe,
    strEmp_CD,
    strAutEnt,
    strEspTra,
    strSepImp: String;
    fltValFre: Double;
    fltDesEsp: Double;
    dtaGraPed,
    dtaPreVis,
    dtaDtaOri,
    dtaHorImp,
    dtaDtaTra,
    dtaHorTra,
    dtaHorPed: TDateTime;
    blnEnt_CD: Boolean;
    sfaStsPagto: TSfaStatusPagamento;
    blnSfaPag: Boolean;
    strEmpLogSfa: String;
    strEspDoc: String;
    blnPedRemGar: Boolean;
    strCodVe2: String;
    strCodTpA: String;
    strEnvLib: String;
    fltDesOpeGor: Double;
    intQtdTra: Integer;
    blnConEqu: Boolean;
    strCodRot: String;
    blnGravarDavPv: Boolean;
    strCodDiv: string;
    cdsProfiss: TUniClientDataSet;
    cdsMovRcd: TUniClientDataSet;
    blnVenPre: Boolean;
    OrigemFaturamento: TOrigemFaturamento;
    strInRqCp: String;
    blnRequisicaoCompraConsertoEquip: Boolean;
    dtaEntrega: TDateTime;
    blnOrigemAtivacaoContrato: Boolean;
    strClaFis: String;
    strOpBxSe: String;
    strEmpFatSemSaldo: String;
    objFazenda: TDadosFazenda;
  end;

Type
  TDadosProduto = Record
    strCodIte,
    strDesIte,
    strEntRet,
    strLocRet,
    strEmpIte,
    strIdePro,
    strMd5Key: String;
    fltQtdIte,
    fltUnitar,
    fltUniOri,
    fltQtdExp,
    fltDesEsp: Double;
    strPromoc: String;
    strNumLot: String;
    strTabIte: String;
    blnBxSbIt: Boolean;
    intSeqEst: Integer;
    strIteEst: String;
    fltUniEst: Double;
    fltQtdSbi: Double;
    fltUniSbi: Double;
    recForTin : TForTin;
    strBrinde,
    strNumCmp,
    intNItCmp: String;
    recInfAut: TInfAut; //Informacoes para tinta automotiva
    dtaDtaPed: TDateTime; {Data do Pedido}
    strCodDiv: string;
    fltDesCnd: Double;
    strSemEst: String;
    fltDescon: Double;
    strReserv: String;
    strSeqEql: String;
    intSeqIte: Integer;
    strClaFis: String;
    dtaDtaCmp: TDateTime;
  end;

Type
  TEmitirPedido = class(TComponent)
    private

      fatVenda             : TFatVenda;
      FValidacao           : TValidarPedido;
      FMemoLog             : TMemo;
      FLabelInf            : TLabel;
      FProgresso           : TcxProgressBar;
      FblnModoRobo         : Boolean;
      qryDadosItem         : TUniQuery;
      qryDadosTinta        : TUniQuery;
      strInfoProcessamento : String;
      FblnCriaTmp: boolean;
      FblnIgnorarValidacaoCest: Boolean;
      FblnImportacaoSfaMobAndroid: Boolean;
      FDataEntrega : TDate;
      FMensagemErro: String;

      function fGetDocEmi: String;
      function fGetIcmsSaida(strEmpIte: string): Double;
      function fGetDescricaoItem: String;
      function fCarregaItem(strCodIte, strEmpIte: String): Boolean;
      function fCarregaTinta(strMd5Key, strIdePro: String): Boolean;
      function fCriaObjetoVenda(strEspDoc: String): Boolean;
      procedure pCalculaPrecoCusto(fltUnitar: Double; dadosProduto: TDadosProduto);
      procedure pOnProcessaItem(const item: TDadosFechamento; index, count: Integer; AInfo: String = '');
      procedure pRegistrarProgresso(strTexto: String; intAtual, intFinal: Integer);
      procedure pAtualizaInformacaoLabel(strTexto: String);
      procedure pAtualizaInformacaoMemo(strTexto: String);
      procedure pCriaQueryItem;
      function fRetDescriTinta(dadosProduto: TDadosProduto): String;
      procedure pCarregarCfgTinOrdemDescricao(var qryCfgTin: TUniQuery; strIdePro, strCodEmp: String);
      function fGetEspecieDefault: String;
      function fEspecieValida(strEspDoc: String): Boolean;
      function fRetornaPrvTin(dadosProduto: TDadosProduto): Double;
      procedure pExibirMensagemErro;
    public
      function fGetAutInc: String;
      function fGetNumDoc: String;
      function fGetLisOrcCrosDock: String;
      procedure fSetImprimeDocs(blnImprimeDocs: Boolean);
      procedure fSetNumDocs(strNumDoc: String);
      procedure fSetServicos(FRecSer: TDadosServicos; ACodEmp: String = '');
      function fIniciarPedido(dadosPedido: TDadosPedido): Boolean;
      function fInserirProduto(dadosProduto: TDadosProduto; dicRetorno: TDicionario = Nil): Boolean;
      function fCalcularTotais: Boolean;
      function fValidarPedido: Boolean;
      function fGravarPedido: Boolean;
      function fGravarNumCmp: Boolean;
      function fPedidoBloqueadoNaLiberacao: Boolean;
      function fGetMensagemErro: String;

      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      property strDocEmitido: String Read fGetDocEmi;
      property blnModoRobo: Boolean read FblnModoRobo Write FblnModoRobo;
      property mmoInformacao: TMemo Read FMemoLog Write FMemoLog;
      property pgbProgresso: TcxProgressBar Read FProgresso Write FProgresso;
      property lblInformacao: TLabel Read FLabelInf write FLabelInf;
      property objFatVenda: TFatVenda Read fatVenda;

      property blnCriaTmp: Boolean read FblnCriaTmp write FblnCriaTmp default True;
      property blnIgnorarValidacaoCest: Boolean read FblnIgnorarValidacaoCest write FblnIgnorarValidacaoCest;
      property blnImportacaoSfaMobAndroid: Boolean read FblnImportacaoSfaMobAndroid write FblnImportacaoSfaMobAndroid;
  end;

implementation

uses untGravando, untFuncoes, Data.DB,
     untParCalculaPrecoCusto, untTConfiguracao, untConstantes,
     untImportaTintometricosTerceirosTabelas, untCadPro, untFuncTinta,
     untTipoTinta;

{ TEmitirPedido }

constructor TEmitirPedido.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataEntrega := 0;
  pCriaQueryItem;
  qryDadosTinta := fCriaQuery(Self);
  FblnModoRobo := False;
  FblnCriaTmp := True;
  blnIgnorarValidacaoCest := False;
  blnImportacaoSfaMobAndroid := False;
end;

function TEmitirPedido.fCriaObjetoVenda(strEspDoc: String): Boolean;
begin
  Try

    Result := True;

    If cdsVenda = nil Then
      pCriarCdsVenda(Self);

    If Not Assigned(fatVenda) Then
    Begin

      fatVenda := TFatVenda.CreateInstance(strEspDoc, blnCriaTmp);
      fatVenda.strNomeForm    := 'frmFatVendas';
      fatVenda.strEspDoc      := strEspDoc;
      fatVenda.blnImpSfa      := True;
      fatVenda.blnImprimeDocs := True;
      fatVenda.blnIgnorarValidacaoCest := FblnIgnorarValidacaoCest;

      If ((Not fCfgSis('IMSESI', varBoolean)) And (SameText(ParamStr(1), PARAM_EXEC_SFAMOB))) Then
        fatVenda.blnImprimeSep := False
      Else
        fatVenda.blnImprimeSep := True;

      fatVenda.qryConIte := fCriarQueryIteGer(fatVenda);

      FValidacao := TValidarPedido.Create(fatVenda);
      FValidacao.blnValidarUnitarioIndividual := false;
      FValidacao.onProgresso := pRegistrarProgresso;
      FValidacao.blnPedirSenha := False;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

function TEmitirPedido.fEspecieValida(strEspDoc: String): Boolean;
begin
  Result := (SameText(strEspDoc, 'PD')) Or (SameText(strEspDoc, 'OR'));
end;

procedure TEmitirPedido.pCriaQueryItem;
begin
  qryDadosItem := fCriaQuery(Self);

  With qryDadosItem, SQL Do
  Begin
    Add(' SELECT ');
    Add('   ITE_CLAIPI, ');

    If fCfgSis('TIPABF') = '1' Then
      Add('   CADITE.ITE_CODABF AS ITE_CODABF, ')
    Else
      Add('   ITEGER.ITE_CODABF AS ITE_CODABF, ');

    Add('   ITE_CODBAR, ');
    Add('   ITE_CODFAB, ');
    Add('   ITE_CODFOR, ');
    Add('   ITE_CODGRU, ');
    Add('   CADITE.ITE_CODITE, ');
    Add('   ITE_CODMAR, ');
    Add('   ITE_CODUNI, ');
    Add('   ITE_COMATA, ');
    Add('   ITE_COMDIS, ');
    Add('   ITE_COMLUB, ');
    Add('   ITE_COMTB1, ');
    Add('   ITE_COMTB2, ');
    Add('   ITE_COMTB3, ');
    Add('   ITE_COMTB4, ');
    Add('   ITE_COMTB5, ');
    Add('   ITE_COMTB6, ');
    Add('   ITE_COMTB7, ');
    Add('   ITE_COMVAR, ');
    Add('   ITE_DESFAB, ');
    Add('   ITE_DESITE, ');
    Add('   ITE_DESMAX, ');
    Add('   ITE_DESMGE, ');
    Add('   ITE_DESMSU, ');

    Add('   ITE_DESMVM, ');
    Add('   ITE_DESMSM, ');
    Add('   ITE_DESMGM, ');

    Add('   ITE_MARMMV, ');
    Add('   ITE_MARMMS, ');
    Add('   ITE_MARMMG, ');

    Add('   ITE_DESOPE, ');
    Add('   ITE_DESSIM, ');
    Add('   ITE_FREENT, ');
    Add('   ITE_ICMSAI, ');

    If (fCfgSis('IMPDIG') = '1') Then
      Add('   CADITE.ITE_IMPDIR AS ITE_IMPDIR, ')
    Else
      Add('   ITEGER.ITE_IMPDIR AS ITE_IMPDIR, ');

    Add('   ITE_IMPFED, ');
    Add('   ITE_IMPULT, ');
    Add('   ITE_INCPIS, ');
    Add('   ITE_IPIENT, ');
    Add('   ITE_IPISAI, ');
    Add('   ITE_LOCFIS, ');
    Add('   ITE_MARMGE, ');
    Add('   ITE_MARMIN, ');
    Add('   ITE_MARMSG, ');
    Add('   ITE_OBRCPF, ');
    Add('   ITE_OUTVAL, ');
    Add('   ITE_PESLIQ, ');
    Add('   ITE_PESOIT, ');
    Add('   ITE_PRECOM, ');
    Add('   ITE_PRECUS, ');
    Add('   ITE_PREMED, ');
    Add('   ITE_PREULT, ');
    Add('   ITE_PREVE1, ');
    Add('   ITE_PREVE2, ');
    Add('   ITE_PREVE3, ');
    Add('   ITE_PREVE4, ');
    Add('   ITE_PREVE5, ');
    Add('   ITE_PREVE6, ');
    Add('   ITE_PREVE7, ');
    Add('   ITE_QTPPRO, ');
    Add('   ITE_REFERE, ');
    Add('   ITE_SALDOS, ');
    Add('   ITE_CILVAS, ');
    Add('   ITE_EMBALA  ');
    Add(' FROM CADITE ');
    Add('   INNER JOIN ITEGER ');
    Add(' ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE ');
    Add('     AND ITEGER.ITE_CODEMP = :CODEMP ');
    Add('     AND CADITE.ITE_CODITE = :CODITE ');
  End;

end;

function TEmitirPedido.fIniciarPedido(dadosPedido: TDadosPedido): Boolean;

  procedure pProgresso(strInformacao: String; intProgresso: Integer);
  begin
    pRegistrarProgresso(strInformacao, intProgresso, 6);
  End;

begin
  Try
    pProgresso('Criando Novo Pedido de Venda. Etapa', 1);

    If (fEmptyStr(dadosPedido.strEspDoc)) Or (Not fEspecieValida(dadosPedido.strEspDoc)) Then
      dadosPedido.strEspDoc := fGetEspecieDefault;

    Result := fCriaObjetoVenda(dadosPedido.strEspDoc);
    fatVenda.strMen001 := dadosPedido.strMen001;
    If Not Result Then
      Exit;

    If cdsVenda <> nil Then
      cdsVenda.EmptyDataSet;

    pProgresso('Carregando Cliente. Etapa', 2);

    if (dadosPedido.blnConEqu) then
    begin
      fatVenda.strAutEnt := dadosPedido.strAutEnt;
      fatVenda.blnConEqu := True;
      fatVenda.blnComTansacao := False;
    end;

    fatVenda.fClienteFilialVenda(dadosPedido.strCodCli);
    fatVenda.pCarregaDadosClienteBaixa(dadosPedido.strCodCli);

    If (fatVenda.blnCliFil) Then
    Begin
      fatVenda.fltFat_TE := fatVenda.recDadCli.fltFat_TE;
      fatVenda.strTEPREV := fatVenda.recDadCli.strTEPREV;
      fatVenda.pAtualizaClassTransferencias;
    End;

    pProgresso('Carregando Condição de Pagamento. Etapa', 3);

    Self.FDataEntrega := dadosPedido.dtaEntrega;
    fatVenda.strClaFis := dadosPedido.strClaFis;
    fatVenda.blnGravarDavPv := dadosPedido.blnGravarDavPv;
    fatVenda.strCodTpA := dadosPedido.strCodTpA;
    fatVenda.strEnvLib := dadosPedido.strEnvLib;
    fatVenda.strEmpLogSfa := dadosPedido.strEmpLogSfa;
    fatVenda.sfaStsPagto := dadosPedido.sfaStsPagto;
    fatVenda.blnSfaPag := dadosPedido.blnSfaPag;
    fatVenda.strCodCnd := dadosPedido.strCodCnd;
    fatVenda.strCodFpg := dadosPedido.strCodFpg;
    fatVenda.strConPag := dadosPedido.strConPag;
    fatVenda.intPrzMed := fFloatToInt(fCalcMediaPagto(dadosPedido.strConPag));
    fatVenda.strEmp_CD := dadosPedido.strEmp_CD;
    fatVenda.blnEnt_CD := dadosPedido.blnEnt_CD;
    fatVenda.pAtualizaInformacoesCondPagamento;

    fatVenda.fltDesOpeGor := dadosPedido.fltDesOpeGor;
    fatVenda.fltDesOpeCli := fatVenda.fltDesOpeCli + dadosPedido.fltDesOpeGor;
    fatVenda.blnTaxVpr    := fAplicarTaxaJurosPrecoDigitado;

    pProgresso('Carregando Dados do Vendedor. Etapa', 4);

    fatVenda.strCodVen := dadosPedido.strCodVen;
    fatVenda.strCodVe2 := dadosPedido.strCodVe2;
    fatVenda.strCodDig := dadosPedido.strCodDig;

    fatVenda.strNomVen := fRetNomVendRep(dadosPedido.strCodVen);
    fatVenda.strNomVe2 := fRetNomVendRep(dadosPedido.strCodVe2);
    fatVenda.strNomDig := fRetNomVendRep(dadosPedido.strCodDig);

    fatVenda.fltComVen := fCampoTabela('OPE_PERCOM', 'CADOPE', ['OPE_CODOPE'], [fatVenda.strCodVen]);
    fatVenda.strTipVen := fCampoTabela('OPE_INTEXT', 'CADOPE', ['OPE_CODOPE'], [fatVenda.strCodVen]);

    pProgresso('Carregando Informacoes do Pedido. Etapa', 5);

    fatVenda.strMen001 := dadosPedido.strMen001;
    fatVenda.strMen002 := dadosPedido.strMen002;
    fatVenda.strMenExp := copy(dadosPedido.strMenExp, 1, 70);
    fatVenda.strMenEx2 := copy(dadosPedido.strMenExp, 71, 70);
    fatVenda.strMenEx3 := copy(dadosPedido.strMenExp, 141, 70);
    fatVenda.strMenEx4 := copy(dadosPedido.strMenExp, 211, 70);
    fatVenda.strTipPed := dadosPedido.strTipPed;
    fatVenda.strTipFre := dadosPedido.strTipFre;
    fatVenda.strTipFin := dadosPedido.strTipFin;
    fatVenda.strTabPre := dadosPedido.strTabPre;
    fatVenda.strEntFat := dadosPedido.strEntFat;
    fatVenda.strCodTra := dadosPedido.strCodTra;
    fatVenda.intQtdTra := dadosPedido.intQtdTra;
    fatVenda.strEspTra := dadosPedido.strEspTra;
    fatVenda.fltValFre := dadosPedido.fltValFre;
    fatVenda.fltFreDig := dadosPedido.fltValFre;
    fatVenda.fltDesEsp := dadosPedido.fltDesEsp;
    fatVenda.strTipOpe := dadosPedido.strTipOpe;
    fatVenda.blnPedRemGar := dadosPedido.blnPedRemGar;
    fatVenda.strCodRot := dadosPedido.strCodRot;
    fatVenda.strCodDiv := dadosPedido.strCodDiv;

    pProgresso('Carregando Informacoes do Pedido de Origem. Etapa', 6);

    fatVenda.strNumPok := dadosPedido.strNumPok;
    fatVenda.strNumCmp := dadosPedido.strNumCmp;
    fatVenda.dtaGraPed := dadosPedido.dtaGraPed;
    fatVenda.dtaPreVis := dadosPedido.dtaPreVis;
    fatVenda.dtaDtaOri := dadosPedido.dtaDtaOri;
    fatVenda.dtaHorImp := dadosPedido.dtaHorImp;
    fatVenda.dtaDtaTra := dadosPedido.dtaDtaTra;
    fatVenda.dtaHorTra := dadosPedido.dtaHorTra;
    fatVenda.strAutEnt := dadosPedido.strAutEnt;

    If Not fEmptyStr(fatVenda.strAutEnt) Then
      fatVenda.blnForcEndEnt := True;

    fatVenda.blnConEqu := dadosPedido.blnConEqu;
    fatVenda.strSepImpPdOS := dadosPedido.strSepImp;
    fatVenda.dtaHorPed := dadosPedido.dtaHorPed;
    fatVenda.blnVendaPresencial := dadosPedido.blnVenPre;
    fatVenda.OrigemFaturamento := dadosPedido.OrigemFaturamento;
    fatVenda.strInRqCp := dadosPedido.strInRqCp;

    fatVenda.strCodDiv := dadosPedido.strCodDiv;
    if Assigned(dadosPedido.cdsProfiss) then
      pCloneDataSet(fatVenda.cdsProfiss, dadosPedido.cdsProfiss);

    if Assigned(dadosPedido.cdsMovRcd) then
      pCloneDataSet(fatVenda.cdsMovRcd, dadosPedido.cdsMovRcd);

    fatVenda.blnOrigemAtivacaoContrato := dadosPedido.blnOrigemAtivacaoContrato;

    fatVenda.blnRequisicaoCompraConsertoEquip := dadosPedido.blnRequisicaoCompraConsertoEquip;

    if fDataValida(dadosPedido.dtaEntrega) then
      fatVenda.dtaDtEntr:= dadosPedido.dtaEntrega;

    if dadosPedido.blnConEqu and (fCfgSis('FLXSEP', varBoolean)) then
    begin
      fatVenda.strOpBxSe := dadosPedido.strOpBxSe;
    end;

    If fCfgSis('FATSSA', varBoolean) Then
      fatVenda.strEmpFatSemSaldo := dadosPedido.strEmpFatSemSaldo;

    if fCfgSis('CADFAZ', varBoolean) and Assigned(dadosPedido.objFazenda) then
    begin
      if not fEmptyStr(dadosPedido.objFazenda.strCodFaz) then
      begin
        fatVenda.objFazenda.strCodCli := dadosPedido.strCodCli;
        fatVenda.objFazenda.strCodFaz := dadosPedido.objFazenda.strCodFaz;
        fatVenda.objFazenda.pCarregarDadosFazenda;
      end;
    end;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

function TEmitirPedido.fInserirProduto(dadosProduto: TDadosProduto; dicRetorno: TDicionario = Nil): Boolean;
  Var
    recMadeira: TDadosMadeira;
    fltUniDig : Double;
    fltPerDes : Double;
    strEntSai : String;
    strRefere : String;
    fltPrvTin : Double;
    fltPrcTin : Double;
    strDesCor : String;
    strEmpPrd : String;
    strChaFor : String;
    strDesIte : String;
    fltDifIpi : Double;
    intDecUni : Integer;
    fltQtdDis : Double;
    blnParticiona: Boolean;
    blnPromo: Boolean;
    dtaDtaLocal : TDateTime;
    fltPreCus, fltPreCu2, fltPreMed,
    fltPreUlt, fltImpUlt, fltPreVe1,
    fltPreVe2, fltPreVe3, fltPreVe4,
    fltPreVe5, fltPreVe6, fltPreve7,
    fltDesOpe, fltImpFed, fltOutVal,
    fltIcmSai: Double;
begin
  intDecUni := fCfgSis('DECUNI', varInteger);
  Try
    Try
      fatVenda.strIdePro := dadosProduto.strIdePro;

      Result := fCarregaItem(dadosProduto.strCodIte, dadosProduto.strEmpIte);

      If (Result) And (dadosProduto.strIdePro <> 'NOR') Then
        Result := fCarregaTinta(dadosProduto.strMd5Key, dadosProduto.strIdePro);

      If Not Result Then
        Exit;

      With qryDadosItem Do
      Begin

        If (FieldByName('ITE_IPISAI').AsFloat > 0) And (fCfgSis('RDIPTB', varBoolean)) Then
        Begin
          fltDifIpi := fFormataFloat((dadosProduto.fltUnitar * FieldByName('ITE_IPISAI').AsFloat) / 100, intDecUni);
          dadosProduto.fltUnitar := dadosProduto.fltUnitar - fFormataFloat(((dadosProduto.fltUnitar * ((fltDifIpi * 100) / (dadosProduto.fltUnitar + fltDifIpi))) / 100), intDecUni);
        End;

        pCalculaPrecoCusto(dadosProduto.fltUnitar, dadosProduto);

        If fEmptyStr(dadosProduto.strDesIte) Then
          dadosProduto.strDesIte := fGetDescricaoItem;

        If fEmptyStr(dadosProduto.strTabIte) Then
          dadosProduto.strTabIte := fatVenda.strTabPre;

        dadosProduto.strCodDiv := fatVenda.strCodDiv;

        if fEmptyStr(dadosProduto.strReserv) then
          dadosProduto.strReserv := 'S';

        If (dadosProduto.strIdePro <> 'NOR') Then
        Begin
          strRefere := qryDadosTinta.FieldByName('REFERE').AsString;

          If dadosProduto.recInfAut.fltPrcTin > 0 Then
            fltPrvTin := dadosProduto.recInfAut.fltPrcTin
          Else
            fltPrvTin := fRetornaPrvTin(dadosProduto);

          strDesCor := qryDadosTinta.FieldByName('NOMCOR').AsString;
          strEmpPrd := VS_strCodEmp;
          strChaFor := qryDadosTinta.FieldByName('DESCRI').AsString + ' ' + qryDadosTinta.FieldByName('REFERE').AsString;
          strDesIte := fRetDescriTinta(dadosProduto);

          If dicRetorno <> Nil Then
          Begin
            fltPreCus := IfNull(dicRetorno['precus'], fatVenda.fltPreCus);
            fltPreCu2 := IfNull(dicRetorno['precu2'], fatVenda.fltPreCu2);
            fltPreMed := IfNull(dicRetorno['premed'], FieldByName('ITE_PREMED').AsFloat);
            fltPreUlt := IfNull(dicRetorno['preult'], FieldByName('ITE_PREULT').AsFloat);
            fltImpUlt := IfNull(dicRetorno['impult'], FieldByName('ITE_IMPULT').AsFloat);
            fltPrcTin := IfNull(dicRetorno['prctin'], 0);
            fltDesOpe := IfNull(dicRetorno['desope'], FieldByName('ITE_DESOPE').AsFloat);
            fltImpFed := IfNull(dicRetorno['impfed'], FieldByName('ITE_IMPFED').AsFloat);
            fltOutVal := IfNull(dicRetorno['outval'], FieldByName('ITE_OUTVAL').AsFloat);
            fltIcmSai := IfNull(dicRetorno['icmsai'], FieldByName('ITE_ICMSAI').AsFloat);
            fltPreVe1 := IfNull(dicRetorno['preve1'], FieldByName('ITE_PREVE1').AsFloat);
            fltPreVe2 := IfNull(dicRetorno['preve2'], FieldByName('ITE_PREVE2').AsFloat);
            fltPreVe3 := IfNull(dicRetorno['preve3'], FieldByName('ITE_PREVE3').AsFloat);
            fltPreVe4 := IfNull(dicRetorno['preve4'], FieldByName('ITE_PREVE4').AsFloat);
            fltPreVe5 := IfNull(dicRetorno['preve5'], FieldByName('ITE_PREVE5').AsFloat);
            fltPreVe6 := IfNull(dicRetorno['preve6'], FieldByName('ITE_PREVE6').AsFloat);
            fltPreVe7 := IfNull(dicRetorno['preve7'], FieldByName('ITE_PREVE7').AsFloat);
          End
          Else
          Begin
            fltPreCus := fatVenda.fltPreCus;
            fltPreCu2 := fatVenda.fltPreCu2;
            fltPreMed := FieldByName('ITE_PREMED').AsFloat;
            fltPreUlt := FieldByName('ITE_PREULT').AsFloat;
            fltImpUlt := FieldByName('ITE_IMPULT').AsFloat;
            fltPrcTin := 0;
            fltDesOpe := FieldByName('ITE_DESOPE').AsFloat;
            fltImpFed := FieldByName('ITE_IMPFED').AsFloat;
            fltOutVal := FieldByName('ITE_OUTVAL').AsFloat;
            fltIcmSai := fGetIcmsSaida(dadosProduto.strEmpIte);
            fltPreVe1 := FieldByName('ITE_PREVE1').AsFloat;
            fltPreVe2 := FieldByName('ITE_PREVE2').AsFloat;
            fltPreVe3 := FieldByName('ITE_PREVE3').AsFloat;
            fltPreVe4 := FieldByName('ITE_PREVE4').AsFloat;
            fltPreVe5 := FieldByName('ITE_PREVE5').AsFloat;
            fltPreVe6 := FieldByName('ITE_PREVE6').AsFloat;
            fltPreVe7 := FieldByName('ITE_PREVE7').AsFloat;
          End;
        End
        Else
        Begin
          strRefere := FieldByName('ITE_REFERE').AsString;
          fltPrvTin := 0;
          strDesCor := '';
          strEmpPrd := '';
          strChaFor := '';
          strDesIte := dadosProduto.strDesIte;

          fltPreCus := fatVenda.fltPreCus;
          fltPreCu2 := fatVenda.fltPreCu2;
          fltPreMed := FieldByName('ITE_PREMED').AsFloat;
          fltPreUlt := FieldByName('ITE_PREULT').AsFloat;
          fltImpUlt := FieldByName('ITE_IMPULT').AsFloat;
          fltPrcTin := 0;
          fltDesOpe := FieldByName('ITE_DESOPE').AsFloat;
          fltImpFed := FieldByName('ITE_IMPFED').AsFloat;
          fltOutVal := FieldByName('ITE_OUTVAL').AsFloat;
          fltIcmSai := fGetIcmsSaida(dadosProduto.strEmpIte);
          fltPreVe1 := FieldByName('ITE_PREVE1').AsFloat;
          fltPreVe2 := FieldByName('ITE_PREVE2').AsFloat;
          fltPreVe3 := FieldByName('ITE_PREVE3').AsFloat;
          fltPreVe4 := FieldByName('ITE_PREVE4').AsFloat;
          fltPreVe5 := FieldByName('ITE_PREVE5').AsFloat;
          fltPreVe6 := FieldByName('ITE_PREVE6').AsFloat;
          fltPreVe7 := FieldByName('ITE_PREVE7').AsFloat;
        End;

        strEntSai := 'S';

        If fCfgSis('IMPPRE') = '2' then
          fltUniDig := dadosProduto.fltUniOri
        Else
          fltUniDig := dadosProduto.fltUnitar;

        fltPerDes := fatVenda.fRetPercentualDescontoCondPagamento(FieldByName('ITE_CODGRU').AsString, dadosProduto.strCodIte, strEntSai);

        fatVenda.blnDeCndF := (fCfgSis('CNDVEN') = 'F');

        {**************************************************************************************}
        {* CASO ESTEJA CONFIGURADO PARA APLICAR DESCONTO REFERENTE A CONDIÇÃO DE PAGAMENTO,   *}
        {* GRAVA O UNIDIG COM O VALOR BRUTO, OU SEJA, DESCONSIDERANDO O DESCONTO DA CONDIÇÃO. *}
        {* ESTE PROCEDIMENTO É NECESSÁRIO PARA NÃO DUPLICAR O DESCONTO NA ALTERAÇÃO DO PEDIDO *}
        {***********************************************************************************PZ*}
        If (fatVenda.fAplicaDescontoCondPagamento(fltPerDes, dadosProduto.strPromoc, 'N')) Then
          fltUniDig := fFormataFloat(fltUniDig / (1- (fltPerDes / 100)), intDecUni);

        {**********************************************************}
        {* SETA FALSO PARA NÃO DUPLICAR O DESCONTO DA CONDIÇÃO DE *}
        {* PAGAMENTO  QUANDO PASSAR PELA PCALCULATOTGERINTERNA.   *}
        {*******************************************************PZ*}
        fatVenda.blnDeCndF := False;

        {Função "fRetornaPrecosPromocao" utilizada para identificar valores da promoção.}
        fatVenda.fltProPreCus := 0;
        fatVenda.fltProPreVen := 0;
        fatVenda.fltProComVar := 0;
        fatVenda.fltProComAta := 0;
        fatVenda.fltProComDis := 0;
        fatVenda.strPromoc    := dadosProduto.strPromoc;

        if dadosProduto.strPromoc = 'S' then
        begin

          {Req: 105114 - Identifica promoção pela data do PEDIDO!}
          If fDataValida(dadosProduto.dtaDtaPed) Then
            dtaDtaLocal := dadosProduto.dtaDtaPed
          Else
            dtaDtaLocal := fatVenda.VS_Date;

          fRetornaPrecosPromocao(dadosProduto.strCodIte,
                                 fatVenda.strCodCli,
                                 dtaDtaLocal,
                                 dadosProduto.fltQtdIte,
                                 0,
                                 0,
                                 fatVenda.intPrzMed,
                                 {Out}
                                 fatVenda.fltProPreCus,
                                 fatVenda.fltProPreVen,
                                 fatVenda.fltProComVar,
                                 fatVenda.fltProComAta,
                                 fatVenda.fltProComDis,
                                 fltQtdDis,
                                 fatVenda.fltProDesF07,
                                 fatVenda.strComPro,
                                 fatVenda.strCodPro,
                                 blnParticiona,
                                 blnPromo,
                                 dadosProduto.strTabIte,
                                 fatVenda.strCodCnd,
                                 '',
                                 '',
                                 True,
                                 False,
                                 '-1',
                                 dadosProduto.strEntRet = 'E',
                                 False);

        end;

        if fatVenda.blnTaxVpr and (fatvenda.fltTxJCnd > 0) and (fltUniDig = dadosProduto.fltUnitar) then
        begin
          fltUniDig := RoundTo(fltUniDig / (1+(fatvenda.fltTxJCnd / 100)), -2);
        end;

        fatVenda.pCarregaValoresCusto(dadosProduto.strCodIte, fatVenda.fGetEmpCalculoItem(dadosProduto.strEmpIte), dadosProduto.strTabIte);

        fatVenda.pAdicionaRegistroTemporaria( cdsVenda,
                                              Nil,
                                              dadosProduto.strIdePro,
                                              FieldByName('ITE_CODGRU').AsString,
                                              dadosProduto.strCodIte,
                                              FieldByName('ITE_DESITE').AsString,
                                              strDesIte,
                                              FieldByName('ITE_DESFAB').AsString,
                                              dadosProduto.recInfAut.strTipEmb,
                                              dadosProduto.recInfAut.strTipEmb,
                                              FieldByName('ITE_CODMAR').AsString,
                                              FieldByName('ITE_CODFOR').AsString,
                                              strRefere,
                                              dadosProduto.fltUniOri,
                                              dadosProduto.fltUniOri,
                                              dadosProduto.fltUnitar,
                                              dadosProduto.fltUnitar,
                                              dadosProduto.fltDescon,
                                              dadosProduto.fltQtdIte,
                                              dadosProduto.fltQtdIte * dadosProduto.fltUnitar,
                                              strEntSai,
                                              fltPreCus,
                                              fltPreCus * dadosProduto.fltQtdIte,
                                              FieldByName('ITE_COMLUB').AsString,
                                              FieldByName('ITE_IPISAI').AsFloat,
                                              FieldByName('ITE_DESMAX').AsFloat,
                                              fltPreVe1,
                                              fltPreVe2,
                                              fltPreVe3,
                                              fltPreVe4,
                                              fltPreVe5,
                                              fltPreVe6,
                                              fltPreVe7,

                                              fCalculaPrecoVenda(2, fatVenda.fRetPreCus(fltPreCus) + fatVenda.fRetOutVal(fltOutVal),
                                                                    dadosProduto.fltUnitar,
                                                                    0,
                                                                    fatVenda.fRetIcmSai(fltIcmSai),
                                                                    fatVenda.fRetImpFed(fltImpFed),
                                                                    fatVenda.fRetDesOpe(fltDesOpe) + fatVenda.fltDesOpeCli,
                                                                    FieldByName('ITE_COMTB' + dadosProduto.strTabIte).AsFloat, fatVenda.VS_strMARMKP),

                                              FieldByName('ITE_SALDOS').AsFloat,
                                              FieldByName('ITE_INCPIS').AsString,
                                              FieldByName('ITE_COMVAR').AsFloat,
                                              FieldByName('ITE_COMATA').AsFloat,
                                              FieldByName('ITE_COMDIS').AsFloat,
                                              '',
                                              '',
                                              '',
                                              0.0,
                                              0.0,
                                              '',
                                              fltPreUlt * dadosProduto.fltQtdIte,
                                              fltImpUlt,
                                              fltPreUlt,
                                              fltPreMed,
                                              FieldByName('ITE_CLAIPI').AsString,
                                              '',
                                              dadosProduto.strMd5Key,
                                              strDesCor,
                                              dadosProduto.recInfAut.strTipPre,
                                              0,
                                              dadosProduto.recInfAut.strTipEmb,
                                              dadosProduto.recInfAut.fltQtdEmb,
                                              dadosProduto.recInfAut.fltPreEmb,
                                              fltPrvTin,
                                              fltPrcTin,
                                              0.0,
                                              'N',
                                              dadosProduto.recInfAut.strCodEmb,
                                              0.0,
                                              0.0,

                                              FieldByName('ITE_CODABF').AsString,
                                              FieldByName('ITE_PESOIT').AsFloat,
                                              FieldByName('ITE_PESLIQ').AsFloat,
                                              dadosProduto.strPromoc,
                                              fatVenda.fltProPreCus,
                                              fatVenda.fltProPreVen,
                                              fatVenda.fltProComVar,
                                              fatVenda.fltProDesF07,
                                              '',
                                              fatVenda.fRetPerComGrupo(FieldByName('ITE_CODGRU').AsString),
                                              FieldByName('ITE_CODFAB').AsString,
                                              cdsVenda.RecordCount + 1,
                                              0.0,
                                              '',
                                              '',
                                              '',
                                              FieldByName('ITE_MARMIN').AsFloat,
                                              FieldByName('ITE_MARMSG').AsFloat,
                                              FieldByName('ITE_MARMGE').AsFloat,
                                              FatVenda.strDesMar,
                                              fatVenda.strStatus,
                                              0.0,
                                              0.0,
                                              '',
                                              '',
                                              dadosProduto.recInfAut.strLinha_,
                                              IIF(dadosProduto.strIdePro = 'NOR',
                                                  qryDadosItem.FieldByName('ITE_EMBALA').AsFloat,
                                                  dadosProduto.recInfAut.fltVolume),
                                              '',
                                              dadosProduto.strSemEst,
                                              '',
                                              FieldByName('ITE_PRECOM').AsFloat,
                                              fltUniDig,
                                              FieldByName('ITE_QTPPRO').AsFloat,
                                              '',
                                              '',
                                              FieldByName('ITE_OBRCPF').AsString,
                                              '',
                                              '',
                                              fRetSiglaUnidade(FieldByName('ITE_CODUNI').AsString),
                                              dadosProduto.recInfAut.fltVolume,
                                              fatVenda.fOrdemItem(cdsVenda,'Adiciona',nil),
                                              strChaFor,
                                              '',
                                              '',
                                              False,
                                              '',
                                              '',
                                              '',
                                              fatVenda.fRetOutVal(fltOutVal),
                                              FieldByName('ITE_COMTB' + dadosProduto.strTabIte).AsFloat,
                                              fatVenda.fRetDesOpe(FieldByName('ITE_DESOPE').AsFloat),
                                              fatVenda.fRetIcmSai(fGetIcmsSaida(dadosProduto.strEmpIte)),
                                              fatVenda.fRetImpFed(FieldByName('ITE_IMPFED').AsFloat),
                                              FieldByName('ITE_DESMGE').AsFloat,
                                              '',
                                              '',
                                              '',
                                              dadosProduto.strTabIte,
                                              FieldByName('ITE_IPIENT').AsFloat,
                                              FieldByName('ITE_FREENT').AsFloat,
                                              dadosProduto.recInfAut.strCodDil,
                                              dadosProduto.recInfAut.fltPorDil,
                                              '',
                                              0.0,
                                              dadosProduto.strEntRet,
                                              dadosProduto.strLocRet,
                                              'N',
                                              '',
                                              IIF(dadosProduto.strEntRet = 'E',  IIF(fDataValida(FDataEntrega), FDataEntrega, fatVenda.dtaPreVis), 0),
                                              dadosProduto.fltQtdIte,
                                              dadosProduto.fltDesEsp,
                                              0,
                                              FieldByName('ITE_IMPDIR').AsString,
                                              FieldByName('ITE_LOCFIS').AsString,
                                              fltPreCu2,
                                              fltPreCu2 * dadosProduto.fltQtdIte,
                                              fatVenda.fltProComAta,
                                              fatVenda.fltProComDis,
                                              0,
                                              0,
                                              0,
                                              0,
                                              dadosProduto.recForTin,
                                              '',
                                              '',
                                              dadosProduto.strNumLot,
                                              strEmpPrd,
                                              '',
                                              dadosProduto.blnBxSbIt, // blnBxSbIt
                                              'N',
                                              'NOR',
                                              0,
                                              '',
                                              FieldByName('ITE_CODBAR').AsString,
                                              '',
                                              0,
                                              0,
                                              0,
                                              dadosProduto.strEmpIte, // strEmpIte
                                              1,
                                              True,
                                              '',
                                              '',
                                              '',
                                              0,
                                              fatVenda.fRetPreCus(fltPreCus),
                                              FieldByName('ITE_DESSIM').AsString,
                                              '',
                                              recMadeira,
                                              fltImpUlt * dadosProduto.fltQtdIte,
                                              0,
                                              IIF(fatVenda.blnTaxVpr, fatvenda.fltTxJCnd, 0),
                                              '',
                                              dadosProduto.fltQtdExp,
                                              '',
                                              dadosProduto.strNumCmp,
                                              StrToIntDef( dadosProduto.intNItCmp, 0 ),
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
                                              '',
                                              'N',
                                              0,
                                              '',
                                              '',
                                              '',
                                              '',
                                              '',
                                              FieldByName('ITE_DESMSU').AsFloat,
                                              '',
                                              dadosProduto.strClaFis,
                                              '',
                                              'S',
                                              dadosProduto.strBrinde,
                                              '',
                                              '',
                                              '',
                                              '',
                                              False,
                                              -1,
                                              -1,
                                              'N',
                                              '',
                                              'N',
                                              0,
                                              0,
                                              0,
                                              '',
                                              0,
                                              0,
                                              dadosProduto.intSeqEst,
                                              dadosProduto.strIteEst,
                                              dadosProduto.fltUniEst,
                                              dadosProduto.fltQtdSbi,
                                              dadosProduto.fltUniSbi,
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
                                              FieldByName('ITE_DESMVM').AsFloat,
                                              FieldByName('ITE_DESMSM').AsFloat,
                                              FieldByName('ITE_DESMGM').AsFloat,
                                              FieldByName('ITE_MARMMV').AsFloat,
                                              FieldByName('ITE_MARMMS').AsFloat,
                                              FieldByName('ITE_MARMMG').AsFloat,
                                              0,
                                              '',
                                              dadosProduto.strReserv,
                                              '',
                                              0,
                                              dadosProduto.strSeqEql,
                                              0,
                                              dadosProduto.intSeqIte,
                                              EmptyStr,
                                              False,
                                              0,
                                              EmptyStr,
                                              EmptyStr,
                                              EmptyStr,
                                              EmptyStr,
                                              0,
                                              False,
                                              0,
                                              0,
                                              False,
                                              False,
                                              FieldByName('ITE_CILVAS').AsString,
                                              False,
                                              '',
                                              False,
                                              '',
                                              '',
                                              '',
                                              '',
                                              '',
                                              False,
                                              '',
                                              0,
                                              0,
                                              0,
                                              0,
                                              '',
                                              '',
                                              '',
                                              '',
                                              'N',
                                              '',
                                              False,
                                              dadosProduto.dtaDtaCmp);

        fatVenda.strPromoc    := 'N';
      End;

      Result := True;
    Except
      On E: Exception Do
      Begin
        Result := False;
        FMensagemErro := E.Message;
        pExibirMensagemErro;
      End;
    End;
  Finally
    fatVenda.strIdePro := '';
  End;
end;

function TEmitirPedido.fPedidoBloqueadoNaLiberacao: Boolean;
begin
  Result := False;
  If Assigned(fatVenda) Then
    Result := Not fPedLiberado(fatVenda.strNumDoc, fatVenda.strEmpDoc);
end;

procedure TEmitirPedido.pCarregarCfgTinOrdemDescricao(var qryCfgTin: TUniQuery; strIdePro, strCodEmp: String);
begin
  qryCfgTin := fCriaQuery(Self);

  qryCfgTin.SQL.Text := ' SELECT CFG_VALCFG FROM CFGTIN ' +
                        '  WHERE CFG_GRUCFG = "ORDEM DA DESCRICAO" ' +
                        '    AND CFG_IDEPRO = :IDEPRO ' +
                        '    AND CFG_CODEMP = :CODEMP ' +
                        '  ORDER BY CFG_CODCFG ';

  qryCfgTin.ParamByName('IDEPRO').AsString := strIdePro;
  qryCfgTin.ParamByName('CODEMP').AsString := strCodEmp;
  qryCfgTin.Open;
end;

function TEmitirPedido.fRetDescriTinta(dadosProduto: TDadosProduto): String;
  Var
    qryTinta : TUniQuery;
    qryCfgTin : TUniQuery;
    strCampo : String;
    intPos : Integer;
    strDescricao : String;
    slCamposPPG : TStringList;
begin
  qryTinta := fCriaQuery(Self);

  Try
    slCamposPPG := Nil;

    Try
      qryTinta.SQL.Text := TImportaTintometrico.fGetSelectConsultaPorMd5(dadosProduto.strIdePro);
      qryTinta.ParamByName('MD5KEY').AsString := dadosProduto.strMd5Key;
      qryTinta.Open;

      slCamposPPG := TStringList.Create;

      If Not qryTinta.IsEmpty Then
      Begin
        pCarregarCfgTinOrdemDescricao(qryCfgTin, dadosProduto.strIdePro, VS_strCodEmp);

        strDescricao := '';

        qryCfgTin.First;

        While Not qryCfgTin.Eof Do
        Begin
          intPos := Pos('.', qryCfgTin.FieldByName('CFG_VALCFG').AsString);

          If intPos > 0 Then
            strCampo := Copy(qryCfgTin.FieldByName('CFG_VALCFG').AsString, intPos + 1, Length(qryCfgTin.FieldByName('CFG_VALCFG').AsString))
          Else
            strCampo := qryCfgTin.FieldByName('CFG_VALCFG').AsString;


          If (dadosProduto.strIdePro = 'PPG') And (qryTinta.FindField(strCampo) = Nil) Then
          begin

            If (pos('PPG_A_N_O_', strCampo ) > 0) And (slCamposPPG.IndexOf('PPG_A_N_O_') = -1)  Then
            begin
              strCampo := 'PPG_A_N_O_';
              slCamposPPG.Add(strCampo);
            End;

          end;

          If qryTinta.FindField(strCampo) <> Nil Then
          Begin
            If fEmptyStr(strDescricao) Then
              strDescricao := qryTinta.FieldByName(strCampo).AsString
            Else
              strDescricao := strDescricao + ' ' + qryTinta.FieldByName(strCampo).AsString;
          End;

          qryCfgTin.Next;
        End;

        If Not fTintaBaixaProduto(dadosProduto.strIdePro) And (dadosProduto.strIdePro = 'PPG') Then
          Result := FloatToStrF(dadosProduto.recInfAut.fltVolume, ffFixed, 12, 3) + ' '+
            dadosProduto.recInfAut.strTipEmb +' ' + strDescricao + ' '+
            IIF(fEmptyStr(dadosProduto.recInfAut.strCodDil), 'CONCENTRADO', 'DILUÍDO')
        else
          Result := strDescricao;
      End;

      qryTinta.Close;

      If fEmptyStr(Result) Then
        Result := dadosProduto.strDesIte;
    Except
      On E: Exception Do
        Result := dadosProduto.strDesIte;
    End;
  Finally
    If Assigned(qryTinta)    Then FreeAndNil(qryTinta);
    If Assigned(qryCfgTin)   Then FreeAndNil(qryCfgTin);
    If Assigned(slCamposPPG) Then FreeAndNil(slCamposPPG);
  End;
end;

function TEmitirPedido.fRetornaPrvTin(dadosProduto: TDadosProduto): Double;
  function fCampoPreVen: String;
  begin
    If dadosProduto.recInfAut.strTipPre = 'C' Then
      Result := 'PREC' + dadosProduto.recInfAut.strTipEmb
    Else
      Result := 'PRED' + dadosProduto.recInfAut.strTipEmb;
  end;
begin
  If (fTipoTinta(dadosProduto.strIdePro) = ttAutomotiva) Then
    Result := qryDadosTinta.FieldByName(fCampoPreVen).AsFloat
  Else
    Result := qryDadosTinta.FieldByName('PREVEN').AsFloat;
end;

destructor TEmitirPedido.Destroy;
begin

  If Assigned(fatVenda) Then
    FreeAndNil(fatVenda);

  pFreeCdsVenda;

  If Assigned(qryDadosItem) Then
    FreeAndNil(qryDadosItem);

  If Assigned(FValidacao) Then
    FreeAndNil(FValidacao);

  FreeAndNil(qryDadosTinta);

  inherited;

end;

function TEmitirPedido.fCalcularTotais: Boolean;
  Var
    arrDatas: TDateArray;
    blnMostraDigDuplic: Boolean;

  procedure pProgresso(strInformacao: String; intProgresso: Integer);
  begin
    pRegistrarProgresso(strInformacao, intProgresso, 7);
  End;

begin
  Result := True;

  pProgresso('Inserindo Produtos. Etapa', 1);

  strInfoProcessamento := 'Aguarde, Inserindo produto %s...';

  fatVenda.pPreencheMatrizFechamento('', pOnProcessaItem);

  If fatVenda.blnTaxVpr Then
    fatVenda.pCalculaTaxVpr;

  pProgresso('Calculando Peso Produtos. Etapa', 2);

  fatVenda.pCalculaPesBruLiq;

  If (fatVenda.intQtdTra = 0) And fCfgSis('CALVOL', varBoolean) Then
    fatVenda.intQtdTra := Floor(fatVenda.fRetVolumes);

  pProgresso('Calculando Valor Total. Etapa', 4);

  strInfoProcessamento := 'Aguarde, Calculando valor do produto %s...';

  fatVenda.pDestacaRetencoes;
  fatVenda.pRetemImpostosNoDescontoEspecial;

  fatVenda.pCalculaTotGer(False, True, pOnProcessaItem);

  fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

  pProgresso('Calculando Total Parcelas. Etapa', 5);

  fatVenda.pCalculaTotalParaCadRec;

  fatVenda.pRateiaValores;

  blnMostraDigDuplic := False;

  fatVenda.fDigitaDuplicata(blnMostraDigDuplic,
                            arrDatas, fatVenda.dtaPreVis,
                            True, fatVenda.arrDuplicCop);

  If (fatVenda.blnConEqu) And (fatVenda.fPedeDuplicata) And (fatVenda.strConPag <> '01999') Then
    fatVenda.strConPag := fRetornaCndPag(arrDatas, fatVenda.dtaDigDup);

  If fatVenda.fltValAdt > 0 Then
  Begin
    Result := Result And fatVenda.fAdicionaAdiantamentoPrimeiraParcela;
  End;

  pProgresso('Atualizando Valor das Parcelas. Etapa', 6);

  Result := Result And (fFormataFloat(fatVenda.fltTotGer, 2) >= 0);

  If Not Result Then
    pProgresso('Valor Total do Pedido Incorreto: [ ' + FloatToStrf(fatVenda.fltTotGer, ffFixed, 10, 2) + ' ]. Etapa', 7)
  Else
    pProgresso('Etapa', 7);
end;

function TEmitirPedido.fCarregaTinta(strMd5Key,
  strIdePro: String): Boolean;
begin
  Try
    Result := True;
    qryDadosTinta.Close;
    qryDadosTinta.SQL.Text := TImportaTintometrico.fGetSQLDadosTinta(strIdePro, strMd5Key);
    qryDadosTinta.Open;
    If qryDadosTinta.IsEmpty Then
      Result := False;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

function TEmitirPedido.fGravarNumCmp: Boolean;
var
  qryNumCmp: TUniQuery;
begin
  Result := fEmptyStr(fatVenda.strNumCmp);

  if not Result then
  begin
    qryNumCmp := fCriarQuery('SELECT * FROM NUMCMP WHERE FALSE');

    If Not qryNumCmp.Active Then
      qryNumCmp.Open;

    Try
      qryNumCmp.Insert;
      qryNumCmp.FieldByName('AUTOINCREM').AsString :=
        fRetAutoIncrem('NUMCMP', fatVenda.strEmpFatGor);
      qryNumCmp.FieldByName('CMP_NUMDOC').AsString :=
        fatVenda.strNumDoc;
      qryNumCmp.FieldByName('CMP_ESPDOC').AsString :=
        fatVenda.strEspDoc;
      qryNumCmp.FieldByName('CMP_CODEMP').AsString :=
        fatVenda.strEmpFatGor;
      qryNumCmp.FieldByName('CMP_CODCLI').AsString :=
        fatVenda.strCodCli;
      qryNumCmp.FieldByName('CMP_NUMCMP').AsString :=
        fatVenda.strNumCmp;
      qryNumCmp.FieldByName('CMP_SEQGER').AsString :=
        fatVenda.strAutIncFatGor;
      qryNumCmp.Post;

      qryNumCmp.Close;

      Result := True;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TEmitirPedido.fGravarNumCmp]');
      End;
    End;

    FreeAndNil(qryNumCmp);
  end;
end;

function TEmitirPedido.fGravarPedido: Boolean;
begin
  If (Not fEmptyStr(fatVenda.strNumPok)) And
     (fCampoTabela('COUNT(*)', 'FATGOR', ['FGO_NUMPOK'], [fatVenda.strNumPok]) > 0) Then
  Begin
    Result := False;
  End
  Else
  Begin
    If FblnModoRobo Then
    Begin
      Result := fatVenda.fGravaArquivos;
    End
    Else
    Begin
      pAtualizaInformacaoLabel('Aguarde... Gravando Pedido de Venda...');
      Try
        If (fCfgSis('CDTCLV', varBoolean)) And
           (Pos(fatVenda.strEspDoc, 'FF_IF_NF_') > 0) Then
        Begin
          If (Not fatVenda.blnFinali) And
             (fatVenda.fExisteCilindroVasilhameFaturamento) Then
            fatVenda.blnFinali := True;
        End;

        pCriarFormularios(TfrmGravando,frmGravando);
        frmGravando.strChave := 'FATVENDAS';

        If (fCfgSis('CDTCLV', varBoolean)) And
           (Pos(fatVenda.strEspDoc, 'PD_FF_IF_NF_') > 0) And
           (fatVenda.fExisteCilindroVasilhameFaturamento) Then
          frmGravando.fExecutarAcao := fatVenda.fDesmembraPDORMultiLoja
        Else
          frmGravando.fExecutarAcao := fatVenda.fGravaArquivos;

        frmGravando.ShowModal;
        Result := frmGravando.blnConfirma;
      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message,'');
        End;
      End;

      pFreeAndNil(frmGravando);
    End;
  End;
end;

procedure TEmitirPedido.pRegistrarProgresso(strTexto: String; intAtual, intFinal: Integer);
begin
  If FblnModoRobo Then
    Exit;

  If Assigned(FProgresso) Then
  Begin
    pgbProgresso.Properties.Min := 0;
    pgbProgresso.Properties.Max := intFinal;
    pgbProgresso.Position := intAtual;
  End;

  pAtualizaInformacaoMemo (Format('%s %d / %d',  [strTexto ,intAtual, intFinal]));
  pAtualizaInformacaoLabel(Format('%s %d / %d',  [strTexto ,intAtual, intFinal]));

  pProcessMessages;
end;

procedure TEmitirPedido.pAtualizaInformacaoMemo(strTexto: String);
begin
  If Assigned(FMemoLog) Then
  Begin
    FMemoLog.Lines.Add(FormatDateTime('hh:mm:ss', fNow()) + ' - ' + strTexto);
  End;
end;

procedure TEmitirPedido.pAtualizaInformacaoLabel(strTexto: String);
begin
  If Assigned(lblInformacao) Then
  Begin
    lblInformacao.Caption := strTexto;
  End;
end;

procedure TEmitirPedido.pOnProcessaItem(const item: TDadosFechamento; index, count: Integer; AInfo: String = '');
begin
  If AInfo.IsEmpty Then
    AInfo := strInfoProcessamento;
  pRegistrarProgresso(Format(AInfo, [item.strCodIte + '-' + fPadR(item.strDesIte, 30)]), Succ(index), count);
end;

function TEmitirPedido.fCarregaItem(strCodIte, strEmpIte: String): Boolean;
begin

  Try
    Result := True;

    qryDadosItem.Close;
    qryDadosItem.ParamByName('CODEMP').AsString := fatVenda.fGetEmpCalculoItem(strEmpIte);
    qryDadosItem.ParamByName('CODITE').AsString := strCodIte;
    qryDadosItem.Open;

    If qryDadosItem.IsEmpty Then
      Result := False;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

end;

procedure TEmitirPedido.pCalculaPrecoCusto(fltUnitar: Double; dadosProduto: TDadosProduto);
  Var
    parPreCus: TParCalculaPrecoCusto;
Begin

  parPreCus := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);
  fatVenda.pCarregaValoresCusto(dadosProduto.strCodIte, fatVenda.fGetEmpCalculoItem(dadosProduto.strEmpIte), dadosProduto.strTabIte);

  With qryDadosItem Do
  Begin
    fatVenda.fltPreCus := fatVenda.fRetPreCus(FieldByName('ITE_PRECUS').AsFloat);
    fatVenda.fltPreCu2 := parPreCus.fCalculaPrecoCustoRealVenda(fltUnitar,
                                                                fatVenda.fRetPreCus(FieldByName('ITE_PRECUS').AsFloat),
                                                                fatVenda.fRetOutVal(FieldByName('ITE_OUTVAL').AsFloat),
                                                                fatVenda.fRetIcmSai(fGetIcmsSaida(dadosProduto.strEmpIte)),
                                                                fatVenda.fRetImpFed(FieldByName('ITE_IMPFED').AsFloat),
                                                                fatVenda.fRetDesOpe(FieldByName('ITE_DESOPE').AsFloat) + fatVenda.fltDesOpeCli,
                                                                0,
                                                                0);
  End;

  FreeAndNil(parPreCus);
End;

function TEmitirPedido.fGetAutInc: String;
begin
  If Assigned(fatVenda) Then
    Result := fatVenda.strAutIncFatGor;
end;

function TEmitirPedido.fGetDescricaoItem: String;
begin
  With qryDadosItem Do
  Begin
    Result := FieldByName('ITE_DESITE').AsString + IIF(fCfgSis('IMPREF', varBoolean), ' ' + FieldByName('ITE_REFERE').AsString, '');
  End;
end;

function TEmitirPedido.fGetDocEmi: String;
begin
  If Assigned(fatVenda) Then
    Result := fatVenda.strNumDoc + '-' + fatVenda.strEspDoc;
end;

function TEmitirPedido.fGetEspecieDefault: String;
begin
  Result := fCfgSis('TPDSFM');
  If (fEmptyStr(Result)) Or (Not fEspecieValida(Result)) Then
    Result := 'PD';
end;

function TEmitirPedido.fGetIcmsSaida(strEmpIte: string): Double;
begin
  With qryDadosItem Do
  Begin
    If (fCfgSis('IMPCF4') = 'S') Then
      Result := fatVenda.fCalculaAliquota(FieldByName('ITE_CODITE').AsString, strEmpIte, FieldByName('ITE_IMPDIR').AsString)
    Else
      Result := FieldByName('ITE_ICMSAI').AsFloat;
  End;
end;

function TEmitirPedido.fGetLisOrcCrosDock: String;
begin
  Result := EmptyStr;

  If Assigned(fatVenda) Then
    Result := fatVenda.strLisOrcCrosDock;
end;

function TEmitirPedido.fValidarPedido: Boolean;
  Type
    TFunctionValida = function(): Boolean Of Object;

  Const
    MAX_TRAVAS = 7;

  function fExecutarValidacao(strDirAce: String; fValidaTrava: TFunctionValida; intNoTrava: Integer): Boolean;
    Var
      blnValidou: Boolean;
      strNivel: String;
  begin
    Result := True;
    strNivel := '';

    FValidacao.pSetProgressValid(intNoTrava,MAX_TRAVAS);
    blnValidou := fValidaTrava;

    If FValidacao.blnPedirSenha And Not blnValidou Then
      Result := False;

    if VS_blnNivel2 or VS_blnNivel3 then
       strNivel := iif(VS_blnNivel3,'3','2');

    If Not FValidacao.blnPedirSenha And Not blnValidou Then
    Begin
      pAdicionarDirAceStringNTrava(strDirAce, fatVenda.strNTrava);

      {*************************************************************************}
      {* Necessario alimentar o arrLogAvi pois o mesmo é utilizado pela funcao *}
      {* TFatVenda.fPedidoBloqueado, que define se o pedido esta bloqueado     *}
      {**********************************************************************JC*}
      if strDirAce = 'PRMIN' then
      begin
        If Not FValidacao.objMsgMenMin.fGetMensagem.IsEmpty Then
        Begin
          SetLength(arrLogAvi, Length(arrLogAvi) + 1);
          arrLogAvi[Length(arrLogAvi) - 1].strDirAce := strDirAce+strNivel;
          arrLogAvi[Length(arrLogAvi) - 1].strInfBlo := FValidacao.objMsgMenMin.fGetMensagem;
          arrLogAvi[Length(arrLogAvi) - 1].strInfLib := FValidacao.objMsgMenMin.fGetMensagem;
        End;

        If Not FValidacao.objMsgMenCus.fGetMensagem.IsEmpty Then
        Begin
          SetLength(arrLogAvi, Length(arrLogAvi) + 1);
          arrLogAvi[Length(arrLogAvi) - 1].strDirAce := 'VECUS';
          arrLogAvi[Length(arrLogAvi) - 1].strInfBlo := FValidacao.objMsgMenCus.fGetMensagem;
          arrLogAvi[Length(arrLogAvi) - 1].strInfLib := FValidacao.objMsgMenCus.fGetMensagem;
        End;
      end
      else
      begin
        SetLength(arrLogAvi, Length(arrLogAvi) + 1);
        arrLogAvi[Length(arrLogAvi) - 1].strDirAce := strDirAce+strNivel;
        arrLogAvi[Length(arrLogAvi) - 1].strInfBlo := VS_strInfUltBlo;
        arrLogAvi[Length(arrLogAvi) - 1].strInfLib := VS_strInfUltLib;
      end;

      VS_blnNivel2 := False;
      VS_blnNivel3 := False;
      VS_strInfUltBlo := '';
      VS_strInfUltLib := '';
    End;
  end;

  procedure pDefineSeAguardaLiberacaoComercial;
    Var
      blnAgdLib: Boolean;
  begin
    fatVenda.blnPedBlo := False;
    fatVenda.strMotBlo := '';
    blnAgdLib          := False;

    If fCfgSis('LIBPED', varBoolean) And (fatVenda.strOpcDoc = 'PD') Then
    Begin
      {**************************************************}
      { AGUARDAR LIBERAÇÃO DA GERÊNCIA PARA PEDIDOS BONS }
      {***********************************************RV*}

      blnAgdLib := false;
      
      If (fCfgSis('LPPDBL') = 'S') And (Not fatVenda.fPedidoBloqueado) Then
      Begin
        blnAgdLib := (fCfgSis('AGDLIB', VarBoolean));
      End;

      {******************************************************}
      { AGUARDAR LIBERAÇÃO DA GERÊNCIA PARA TODOS OS PEDIDOS }
      {***************************************************RV*}
      If fCfgSis('AGDLBT', VarBoolean) Then
      Begin
        blnAgdLib := True;
        fatVenda.strMotBlo := 'AGUARDANDO LIBERAÇÃO DA GERÊNCIA...';
        fatVenda.blnPedBlo := Not (fClienteConsumidor(fatVenda.strCliOri, True, True) And (fStatusCndPag(fatVenda.strConPag) = A_VISTA));
      End;
    End;

    If blnAgdLib And fatVenda.fTemProdutosComMargemEmDinheiroNegativa Then
    Begin
      fatVenda.blnPedBlo := True;
      fatVenda.strMotBlo := 'MARGEM NEGATIVA';
    End;

    If Not fCfgSis('AGDLBT', VarBoolean) Then
    Begin
      If (fatVenda.strTipOpe = 'B') And (fCfgSis('AGDLIB', VarBoolean)) Then
      Begin
        fatVenda.blnPedBlo := False;
        fatVenda.strMotBlo := '';
      End;
    End;
  end;

begin
  SetLength(arrLogAvi, 0);
  fatVenda.strNTrava := 'NNNNNNNNNNNNNNNNNNNN';

  If fCfgSis('LIBSFA', VarBoolean) Then
  Begin
    Result := fExecutarValidacao('LIMCR', FValidacao.fValidaLimiteCredito,     1) And
              fExecutarValidacao('COMPR', FValidacao.fValidaNaoCompra,         2) And
              fExecutarValidacao('PRMIN4',FValidacao.fValidaUnitario,          3) And
              fExecutarValidacao('VEMIN4',FValidacao.fValidaVrMinimo,          4) And
              fExecutarValidacao('DEATR', FValidacao.fValidaDebitosCliente,    5) And
              fExecutarValidacao('CONCC', FValidacao.fValidaConsultaDeCredito, 6) And
              fExecutarValidacao('VLCRE', FValidacao.fValidaValorCrediario,    7);

    pDefineSeAguardaLiberacaoComercial;
  End
  Else
    Result := True;
end;

function TEmitirPedido.fGetNumDoc: String;
begin
  If Assigned(fatVenda) Then
    Result := fatVenda.strNumDoc;
end;

procedure TEmitirPedido.fSetImprimeDocs(blnImprimeDocs: Boolean);
begin
  If Assigned(fatVenda) Then
  begin
    fatVenda.blnImprimeDocs := blnImprimeDocs;
    fatVenda.blnImprimeSep  := blnImprimeDocs;
  end;
end;

procedure TEmitirPedido.fSetNumDocs(strNumDoc: String);
begin
  If Assigned(fatVenda) Then
  begin
    fatVenda.strNumDoc := strNumDoc;
    fatVenda.blnNovoSequencial := false;
  end;
end;

procedure TEmitirPedido.fSetServicos(FRecSer: TDadosServicos; ACodEmp: String = '');
Var
  strCodIte: String;
  qryCadIte,
  qryIteGer,
  qryAbfIcm: TUniQuery;
begin
  If Assigned(fatVenda) Then
  begin
    strCodIte := fCfgSis('ITESER');

    If fEmptyStr(strCodIte) Then
      Raise Exception.Create('Item de serviço não configurado.');

    qryCadIte := fCriaQuery(Nil);
    qryIteGer := fCriaQuery(Nil);
    qryAbfIcm := fCriaQuery(Nil);

    qryCadIte.SQL.Add('SELECT * FROM CADITE WHERE ITE_CODITE = :CODITE');
    qryCadIte.ParamByName('CODITE').AsString := strCodIte;
    qryCadIte.Open;

    qryIteGer.SQL.Add('SELECT * FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP');
    qryIteGer.ParamByName('CODITE').AsString := strCodIte;
    qryIteGer.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryIteGer.Open;

    qryAbfIcm.SQL.Add('SELECT * FROM ABFICM WHERE ABF_CODABF = :CODABF AND ABF_ESTADO = :ESTADO');

    If fCfgSis('TIPABF') = '1' Then
      qryAbfIcm.ParamByName('CODABF').AsString := qryCadIte.FieldByName('ITE_CODABF').AsString
    Else
      qryAbfIcm.ParamByName('CODABF').AsString := qryIteGer.FieldByName('ITE_CODABF').AsString;

    qryAbfIcm.ParamByName('ESTADO').AsString := fatVenda.strCliEst;
    qryAbfIcm.Open;

    fatVenda.pInserirItemServico(Nil, qryCadIte, qryIteGer, qryAbfIcm, ACodEmp);

    FreeAndNil(qryCadIte);
    FreeAndNil(qryIteGer);
    FreeAndNil(qryAbfIcm);

    fatVenda.FRecSer := FRecSer;
  end;

end;

function TEmitirPedido.fGetMensagemErro: String;
begin
  Result := FMensagemErro;
end;

procedure TEmitirPedido.pExibirMensagemErro;
begin
  If not (fatVenda.strOpcDocTrue = 'MO') Then
  Begin
    pMensagensErro(FMensagemErro, '');
    Exit;
  End;

  fRollBack;

  If not FblnModoRobo Then
    Exit;

  fMensagem('', FMensagemErro, ['&Ok']);
end;

end.
