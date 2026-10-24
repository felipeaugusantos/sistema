unit untCaixaRecalcPrecosCheckOut;

interface

uses
  Uni, untFuncFat, UniClientDataSet, untFuncoesSimples, System.SysUtils,
  untIteBar, untPesqAux, untCadPro, cxProgressBar, untTypesSistema, Vcl.StdCtrls,
  untGravando, untFuncFatTypes, System.Classes, System.Generics.Collections,
  Data.DB;

type
  TdictReplicarRecalculoPrecos = TObjectDictionary<String, TUniClientDataSet> ;

  TRecalcPrecosCheckOut = class
    private
      intPrzMed : Integer;
      fltDesCon: Double;
      fltUnitar: Double;
      strCodBar: String;
      strCodIteUni, strCodGruUni: String;
      fltQtdIteUni: Double;
      blnBuscaCodBar: Boolean;
      blnItemEstrutura : Boolean;
      fltQtdIte : Double;
      blnParticiona, blnPromo : Boolean;
      blnCodBarEmb : Boolean;
      fltUniOri: Double;
      fltTaxJur: Double;
      blnUniEspecial: Boolean;
      fltPreCus: Double;
      fltUniVis: Double;
      fltVal_RT: Double;
      fltDesMax: Double;
      strConPagAux : String;
      qryPesqItens: TUniQuery;
      FdictReplicarRecalculo: TdictReplicarRecalculoPrecos ;
      procedure pGuardaProdutoRecalculoPreco(var AdictReplicarRecalculo: TdictReplicarRecalculoPrecos; const AcdsItem: TuniClientDataSet) ;
      procedure pCarregaProdutoRecalculoPreco(const AdictReplicarRecalculo: TdictReplicarRecalculoPrecos; var AcdsItem: TuniClientDataSet) ;
      function fAdicionadoProdutoRecalculoPreco(const AstrCodigoProduto: String): boolean ;
      function fRetornaPreCusAndPromocao(const AfltPreCus: double):double ;
      function fVerificarSeFormaPagamentoPedidoEhCartao: Boolean;
      function fVerificaPrazoMedioAndUsaCnd : Boolean;
      function fVerificaUsaCndAndTaxCndF3InicioCx(blnCalculaTaxCndF3InicioCx : Boolean) : Boolean;
      function fVerificaPreCusAndPromocao : Boolean;
      function fVerificaBuscaCodBarAndItemEstruturaAndPrvEmb : Boolean;
      function fVerificaCodBarEmbAndTabPreAndPreEmb : Boolean;
      function fVerificaBarPreVenAndPreEmb : Boolean;
      procedure pEmbalagemFechadaItem(const AstrCodIte: string) ;
      function fVerificaEmbalagemFechadaItem : Boolean;
      function fVerificaEmbalagemFechadaItemPromocao(strTabPre : String): Boolean;
      function fVerificaNotPromocaoOuPrecoSugAtivaIgualPrecoTabela : Boolean;
      function fVerificaAbateDescontoAutomaticamente : Boolean;

      procedure pAplicaRegrasCondicoesDePagamento(fltTaxJur, fltUniOri : Double; var fltUnitar : Double);
      procedure pPesqItem(blnItemEstrutura, blnBuscaCodBar : Boolean);
      procedure pAplicaPromocaoProduto(strCodCli, strTabPre, strEntRet, strIteEntFut, strMotFut: String;
        fltQtdJaDigitada, fltQtdJaDigitadaPromoc: Double; objPromVlrMinTotalProdutos: TPromocaoVlrMinTotalProdutos);
      procedure pAplicaRegrasItensNormais;
      procedure pSetaVariaveisIndicadoras(strPromocAnt: String);
      procedure pAplicaRegrasValorUnitario(blnItemEspecial : Boolean; strTabPre : String);
      function fRetQtdDigitada(strCodIte,
                               strNumLot,
                               strAutInc: String;
                               blnSomenteItensEmPromocao: Boolean): Double;
      function fVaiRecalcularPreco(const AlstCodProd: TStringList; const AstrCodProd: String): boolean ;

    public
      fatVendas: TfatVenda;
      cdsItens : TUniClientDataSet;
      stlItensParaRecalcular: TStringList;
      blnItensEntraramOuSairamDePromocao: Boolean;
      blnItensTiveramUnitarModificados: Boolean;

      procedure pRecalculaPrecosItens(strConPag : String;
                                      blnCalculaTaxCndF3InicioCx : Boolean;
                                      strCodCli : String;
                                      strTabPre : String;
                                      blnItemEspecial : Boolean;
                                      strIteEntFut : String = 'N';
                                      strEntRet    : String = '';
                                      strMotFut    : String = '';
                                      blnManterPrecoDigitado: Boolean = False;
                                      objPromVlrMinTotalProdutos: TPromocaoVlrMinTotalProdutos = Nil);
      constructor Create;
      destructor Destroy; override;
  end;

implementation

procedure TRecalcPrecosCheckOut.pAplicaRegrasCondicoesDePagamento(fltTaxJur, fltUniOri : Double; var fltUnitar : Double);
var
  fltJuros: Double;
  fltUnitarNovo: Double;
begin
  if fltTaxJur <> 0 then
    Exit;

  if (fCfgSis('CNDVEN') = 'I') then
    Exit;

  fatVendas.pAtualizaInformacoesCondPagamento;
  If (Not ((fatVendas.strJurPro = 'N') And (fatVendas.strPromoc = 'S'))) and (fAplicarTaxaJurosPrecoDigitado) then
    Exit;

  if fatVendas.fltTxJCnd = 0 then
    Exit;

  fltJuros := fltUniOri * (fatVendas.fltTxJCnd / 100.0);
  fltJuros := fFormataFloatInterna(fltJuros, 2);

  fltUnitarNovo := fltUnitar + fltJuros;
  fltUnitar := fltUnitarNovo;
end;

procedure TRecalcPrecosCheckOut.pPesqItem(blnItemEstrutura,
  blnBuscaCodBar: Boolean);
  var
    objIteBar: TIteBar;
begin
  If (fCfgSis('ETIDIF', varBoolean)) And blnBuscaCodBar Then
  Begin
    try
      objIteBar := TIteBar.Create;
      If objIteBar.fLerCodigoBarrasUnidades(strCodBar,strCodIteUni, strCodGruUni, fltQtdIteUni) Then
      Begin
        blnBuscaCodBar := false;
      End;
    finally
      freeAndNil(objIteBar);
    end;

    if blnBuscaCodBar then
      strCodIteUni := strCodBar;

    pPesquisaCadIte(Nil, qryPesqItens, strCodIteUni, '', blnBuscaCodBar, False, True, True, False, False, False, False, True);
  End
  Else
    pPesquisaCadIte(Nil, qryPesqItens, strCodBar, '', blnBuscaCodBar, False, True, True, False, False, False, False, True);
end;

constructor TRecalcPrecosCheckOut.Create;
begin
  inherited Create;

  FdictReplicarRecalculo := TdictReplicarRecalculoPrecos.Create([doOwnsValues]);

  blnItensEntraramOuSairamDePromocao := False;
  blnItensTiveramUnitarModificados := False;
end;

destructor TRecalcPrecosCheckOut.Destroy;
begin
  FreeAndNil(FdictReplicarRecalculo) ;
  inherited;
end;

function TRecalcPrecosCheckOut.fAdicionadoProdutoRecalculoPreco(
  const AstrCodigoProduto: String): boolean;
begin
  result := False ;
  If not Assigned(stlItensParaRecalcular) Then
    exit ;

  result := FdictReplicarRecalculo.ContainsKey(AstrCodigoProduto) ;
end;

function TRecalcPrecosCheckOut.fRetornaPreCusAndPromocao(
  const AfltPreCus: double): double;
begin
  result := AfltPreCus ;
  If fVerificaPreCusAndPromocao Then
    result := fatVendas.fltProPreCus;
end;

function TRecalcPrecosCheckOut.fRetQtdDigitada(strCodIte,
                                               strNumLot,
                                               strAutInc: String;
                                               blnSomenteItensEmPromocao: Boolean): Double;
  Var
    cdsDados: TUniClientDataSet;
begin
  Result := 0.0;

  cdsDados := TUniClientDataSet.Create(Nil);
  Try
    Try
      pCloneDataSet(cdsDados, cdsItens);

      If blnSomenteItensEmPromocao Then
        cdsDados.Filter := cdsDados.Filter + ' (ITE_PROMOC = ''S'') ';

      cdsDados.Filtered := True;

      cdsDados.First;
      While Not cdsDados.Eof Do
      Begin
        If fEmptyStr(strAutInc) Then
        Begin
          If (cdsDados.FieldByName('ITE_CODITE').AsString = strCodIte) And
             (fEmptyStr(strNumLot) Or SameText(cdsDados.FieldByName('ITE_NUMLOT').AsString, strNumLot)) Then
            Result := Result + cdsDados.FieldByName('ITE_QTDITE').AsFloat;
        End
        Else
        Begin
          If (cdsDados.FieldByName('ITE_CODITE').AsString = strCodIte) And
             (cdsDados.FieldByName('ITE_AUTINC').AsString <> strAutInc) And
             (fEmptyStr(strNumLot) Or SameText(cdsDados.FieldByName('ITE_NUMLOT').AsString, strNumLot)) Then
            Result := Result + cdsDados.FieldByName('ITE_QTDITE').AsFloat;
        End;

        cdsDados.Next;
      End;
    Except
      On E: Exception Do
      Begin
        Result := 0;
        pMensagensErro(E.Message,'');
      End;
    End;
  Finally
    FreeAndNil(cdsDados);
  End;
end;

function TRecalcPrecosCheckOut.fVaiRecalcularPreco(
  const AlstCodProd: TStringList; const AstrCodProd: String): boolean;
begin
  Result := True ;
  If Assigned(AlstCodProd) Then
    If (AlstCodProd.Count > 0) And (AlstCodProd.IndexOf(AstrCodProd) = -1) Then
      Result := False ;
end;

function TRecalcPrecosCheckOut.fVerificaAbateDescontoAutomaticamente: Boolean;
begin
  If not (fatVendas.strCAbDes = 'S') Then
    Exit(False);

  If not (fVerificaNotPromocaoOuPrecoSugAtivaIgualPrecoTabela) Then
    Exit(False);

  If (fAplicarTaxaJurosPrecoDigitado) Then
    Exit(False);

  If (fatVendas.fUsandoF3PuroComCondicaoNoFinal) Then
    Exit(False);

  Result := True;
end;

function TRecalcPrecosCheckOut.fVerificaBarPreVenAndPreEmb: Boolean;
begin
  If not (qryPesqItens.FieldByName('BAR_PREVEN').AsFloat > 0.00) Then
    Exit(False);

  If not (fCfgSis('PREEMB', VarInteger) = 1) Then
    Exit(False);

  Result := True;
end;

function TRecalcPrecosCheckOut.fVerificaBuscaCodBarAndItemEstruturaAndPrvEmb: Boolean;
begin
  if not (blnBuscaCodBar) then
    Exit(False);

  if (blnItemEstrutura) then
    Exit(False);

  if not (fCfgSis('PRVEMB', VarBoolean)) then
    Exit(False);

  Result := True;
end;

function TRecalcPrecosCheckOut.fVerificaCodBarEmbAndTabPreAndPreEmb: Boolean;
begin
  if fEmptyStr(qryPesqItens.FieldByName('BAR_TABPRE').AsString) then
    Exit(False);

  if (SameText(qryPesqItens.FieldByName('BAR_TABPRE').AsString, 'F')) then
    Exit(False);

  if not (fCfgSis('PREEMB', VarInteger) = 2) Then
    Exit(False);

  Result := True;
end;

function TRecalcPrecosCheckOut.fVerificaEmbalagemFechadaItem: Boolean;
begin
  If not (fatVendas.stlItensNaoTemQtdeEmbFec.IndexOf(qryPesqItens.FieldByName('ITE_CODITE').AsString) = -1) Then
    Exit(False);

  If (fTemQuantEmbalagemFechada(qryPesqItens.FieldByName('ITE_CODITE').AsString)) Then
    Exit(False);

  Result := True;
end;

function TRecalcPrecosCheckOut.fVerificaEmbalagemFechadaItemPromocao(strTabPre : String): Boolean;
begin
  Result := fatVendas.fVerificaEmbalagemFechadaItemPromocao(qryPesqItens.FieldByName('ITE_CODITE').AsString,
                                                            strTabPre,
                                                            fatVendas.strPromoc,
                                                            fltQtdIte);
end;

function TRecalcPrecosCheckOut.fVerificaNotPromocaoOuPrecoSugAtivaIgualPrecoTabela: Boolean;
begin
  Result := False;

  If (fatVendas.strPromoc <> 'S') Then
    Result := True;

  If (fatVendas.fRegraPrecoSugestaoAtiva = TRegraPrecoSugestao.PrecoDeTabela) Then
    Result := True;
end;

function TRecalcPrecosCheckOut.fVerificaPrazoMedioAndUsaCnd: Boolean;
begin
  If not (fCfgSis('PRZPRO') = 'S') then
    Exit(False);

  if not (fCfgSis('USACND') = 'S') Then
    Exit(False);

   Result := True;
end;

function TRecalcPrecosCheckOut.fVerificaPreCusAndPromocao: Boolean;
begin
  If not (fatVendas.strPromoc = 'S') then
    Exit(False);

  if not (fatVendas.fltProPreCus > 0) Then
    Exit(False);

  Result := True;
end;

function TRecalcPrecosCheckOut.fVerificarSeFormaPagamentoPedidoEhCartao: Boolean;
const
  strFORMA_PAGAMENTO_CARTAO = 007;
begin
  if not fatVendas.strCodFpg.IsEmpty then
    exit(False);

  if not fCfgSis('USAFPG', varBoolean) then
    exit(False);

  if fatVendas.strCodCnd.IsEmpty then
    exit(False);

  result := strFORMA_PAGAMENTO_CARTAO = fCampoTabela('CND_CODFPG',
                                                     'CADCND',
                                                     ['CND_CODIGO'],
                                                     [fatVendas.strCodCnd]);
end;

function TRecalcPrecosCheckOut.fVerificaUsaCndAndTaxCndF3InicioCx(blnCalculaTaxCndF3InicioCx : Boolean): Boolean;
begin
  Result := True;

  If not (fCfgSis('USACND') = 'S') then
    Exit(False);

  if (blnCalculaTaxCndF3InicioCx) Then
    Exit(False);
end;

procedure TRecalcPrecosCheckOut.pRecalculaPrecosItens(strConPag : String;
                                                      blnCalculaTaxCndF3InicioCx : Boolean;
                                                      strCodCli : String;
                                                      strTabPre : String;
                                                      blnItemEspecial : Boolean;
                                                      strIteEntFut : String = 'N';
                                                      strEntRet    : String = '';
                                                      strMotFut    : String = '';
                                                      blnManterPrecoDigitado: Boolean = False;
                                                      objPromVlrMinTotalProdutos: TPromocaoVlrMinTotalProdutos = Nil);

  Var
    fltQtdJaDigitada,
    fltQtdJaDigitadaPromoc: Double;
    strPromocAnt: String;
begin
  blnBuscaCodBar := True;
  blnUniEspecial := False;

  qryPesqItens := fCriaQuery(nil);

  Try
    Try
      cdsItens.First;
      while not cdsItens.Eof do
      begin
        If not fVaiRecalcularPreco(stlItensParaRecalcular, cdsItens.FieldByName('ITE_CODITE').AsString) Then
        Begin
          cdsItens.Next;
          Continue;
        End;

        if not fAdicionadoProdutoRecalculoPreco(cdsItens.FieldByName('ITE_CODITE').AsString) then
        begin
          blnItemEstrutura := not fEmptyStr(cdsItens.FieldByName('ITE_ITEEST').AsString);
          strPromocAnt := cdsItens.FieldByName('ITE_PROMOC').AsString;

          strCodBar := cdsItens.FieldByName('ITE_CODBAR').AsString;

          If (not blnItemEstrutura) Then
            blnBuscaCodBar := False;

          pPesqItem(blnItemEstrutura, blnBuscaCodBar);

          blnCodBarEmb := blnBuscaCodBar And (qryPesqItens.RecordCount = 1) And
                          (qryPesqItens.FieldByName('BAR_EMBALA').AsFloat > 1);

          fltUnitar := 0;

          fltQtdJaDigitada       := fRetQtdDigitada(cdsItens.FieldByName('ITE_CODITE').AsString,'',cdsItens.FieldByName('ITE_AUTINC').AsString, False);
          fltQtdJaDigitadaPromoc := fRetQtdDigitada(cdsItens.FieldByName('ITE_CODITE').AsString,'',cdsItens.FieldByName('ITE_AUTINC').AsString, True);

          cdsItens.Edit;

          fltPreCus := cdsItens.FieldByName('ITE_PRECUS').AsFloat;
          fltQtdIte := cdsItens.FieldByName('ITE_QTDITE').AsFloat;

          if fVerificaPrazoMedioAndUsaCnd then
          Begin
            intPrzMed := fFloatToInt(fCalcMediaPagto(strConPag));
          End;

          strConPagAux := '';
          fatVendas.blnCalculaTaxCndF3Inicio := False;
          If fVerificaUsaCndAndTaxCndF3InicioCx(blnCalculaTaxCndF3InicioCx) Then
          Begin
            strConPagAux := strConPag;
            fatVendas.blnCalculaTaxCndF3Inicio := blnCalculaTaxCndF3InicioCx;
          End;

          pAplicaPromocaoProduto(strCodCli, strTabPre, strEntRet, strIteEntFut, strMotFut, fltQtdJaDigitada, fltQtdJaDigitadaPromoc, objPromVlrMinTotalProdutos);

          fltPreCus := fRetornaPreCusAndPromocao(fltPreCus) ;

          fltUniVis := fltUnitar;
          fltTaxJur := 0.00;
          fltVal_RT := 0.00;
          fltDesCon := 0.00;

          fltUnitar := fatVendas.fPegaPrecoVenda(cdsItens, VS_strCodEmp, 'S', 0, blnItemEspecial, 'NOR', fatVendas.strTabPre, True, fltTaxJur, fltUniVis, False, 0, 'F', strConPagAux);

          fatVendas.pCalculaValorRT(fltUnitar, fltVal_RT);

          fltUniOri := fltUnitar;

          pAplicaRegrasValorUnitario(blnItemEspecial, strTabPre);

          If fCfgSis('DESCND',varBoolean) Then
            fatVendas.strDstCnd := qryPesqItens.FieldByName('ITE_DESCND').AsString;

          pEmbalagemFechadaItem(qryPesqItens.FieldByName('ITE_CODITE').AsString) ;

          { ************************************************ }
          { * VERIFICA SE EH MULTIPLO DE EMBALAGEM FECHADA * }
          { * APLICA O DESCONTO PARA EMBALAGEM FECHADA     * }
          { ********************************************JC** }
          If fVerificaEmbalagemFechadaItemPromocao(strTabPre) Then
          Begin
            fltUnitar := fltUnitar * (1 - (fPercDescEmbalagemFechadaItem(qryPesqItens.FieldByName('ITE_CODITE').AsString, IIF(fEmptyStr(strTabPre), strTabPre,
                         strTabPre), fltQtdIte, '') / 100));
          End;

          pAplicaRegrasItensNormais;
          pSetaVariaveisIndicadoras(strPromocAnt);

          cdsItens.FieldByName('ITE_UNIORI').AsFloat := fltUniOri;
          cdsItens.FieldByName('ITE_UNIVIS').AsFloat := fltUniVis;
          If (Not blnManterPrecoDigitado) Then
            cdsItens.FieldByName('ITE_UNITAR').AsFloat := fltUnitar;
          cdsItens.FieldByName('ITE_DESCON').AsFloat := fltDesCon;
          cdsItens.FieldByName('ITE_TAXJUR').AsFloat := fltTaxJur;
          cdsItens.FieldByName('ITE_VAL_RT').AsFloat := fltVal_RT;
          cdsItens.FieldByName('ITE_TOTITE').AsFloat := (fltQtdIte * fltUnitar);
          cdsItens.FieldByName('ITE_TOTCUS').AsFloat := (fltQtdIte * fltPreCus);
          cdsItens.FieldByName('ITE_TABPRE').AsString := strTabPre;

          cdsItens.Post;

          pGuardaProdutoRecalculoPreco(FdictReplicarRecalculo, cdsItens) ;
        end
        else
        begin
          //somente promoção
          pCarregaProdutoRecalculoPreco(FdictReplicarRecalculo, cdsItens) ;
        end ;

        cdsItens.Next
      end;
    Finally
      FreeAndNil(qryPesqItens);
    End;
  Except
    On E: Exception Do
    Begin
      cdsItens.Cancel;
      pMensagensErro(E.Message,'');
      Exit;
    End;
  End;
end;

procedure TRecalcPrecosCheckOut.pAplicaPromocaoProduto(strCodCli, strTabPre, strEntRet, strIteEntFut, strMotFut: String;
  fltQtdJaDigitada, fltQtdJaDigitadaPromoc: Double; objPromVlrMinTotalProdutos: TPromocaoVlrMinTotalProdutos);
var
  fltQtdDis : Double;
begin
  fatVendas.strPromoc := 'N';
  cdsItens.FieldByName('ITE_PROMOC').AsString := 'N';
  cdsItens.FieldByName('ITE_PROCUS').AsFloat  := 0;
  cdsItens.FieldByName('ITE_PROVEN').AsFloat  := 0;
  cdsItens.FieldByName('ITE_PROCVA').AsFloat  := 0;
  cdsItens.FieldByName('ITE_DESF07').AsFloat  := 0;
  cdsItens.FieldByName('ITE_PROCAT').AsFloat  := 0;
  cdsItens.FieldByName('ITE_PROCDI').AsFloat  := 0;
  If (fRetornaPrecosPromocao(cdsItens.FieldByName('ITE_CODITE').AsString,
                             strCodCli,
                             VS_Date,
                             cdsItens.FieldByName('ITE_QTDITE').AsFloat,
                             fltQtdJaDigitada,
                             fltQtdJaDigitadaPromoc,
                             intPrzMed,
                             fatVendas.fltProPreCus,
                             fatVendas.fltProPreVen,
                             fatVendas.fltProComVar,
                             fatVendas.fltProComAta,
                             fatVendas.fltProComDis,
                             fltQtdDis,
                             fatVendas.fltProDesF07,
                             fatVendas.strComPro,
                             fatVendas.strCodPro,
                             blnParticiona,
                             blnPromo,
                             strTabPre,
                             fatVendas.strCodCnd,
                             '',
                             '',
                             True,
                             False,
                             '-1',
                             ((strEntRet = 'E') And (strIteEntFut = 'N')),
                             ((strEntRet = 'E') And (strIteEntFut = 'S')),
                             strMotFut,
                             '', '', '', Nil, False, '', objPromVlrMinTotalProdutos)) Then
  Begin

    If Not blnParticiona Then
    Begin
      cdsItens.FieldByName('ITE_PROMOC').AsString := 'S';
      cdsItens.FieldByName('ITE_COMPRO').AsString  := fatVendas.strComPro;
      cdsItens.FieldByName('ITE_CODPRO').AsString  := fatVendas.strCodPro;
      cdsItens.FieldByName('ITE_PROCUS').AsFloat   := fatVendas.fltProPreCus;
      cdsItens.FieldByName('ITE_PROVEN').AsFloat   := fatVendas.fltProPreVen;
      cdsItens.FieldByName('ITE_PROCVA').AsFloat   := fatVendas.fltProComVar;
      cdsItens.FieldByName('ITE_DESF07').AsFloat   := fatVendas.fltProDesF07;
      cdsItens.FieldByName('ITE_PROCAT').AsFloat   := fatVendas.fltProComAta;
      cdsItens.FieldByName('ITE_PROCDI').AsFloat   := fatVendas.fltProComDis;

      fatVendas.strPromoc := 'S';
    End;

  End;
end;

procedure TRecalcPrecosCheckOut.pAplicaRegrasValorUnitario(blnItemEspecial : Boolean; strTabPre : String);
begin
  If fVerificaBuscaCodBarAndItemEstruturaAndPrvEmb Then
  Begin
    cdsItens.FieldByName('ITE_BAREMB').AsString := qryPesqItens.FieldByName('BAR_CODBAR').AsString;

    If (Not fEmptyStr(qryPesqItens.FieldByName('BAR_DESCRI').AsString)) Then
      cdsItens.FieldByName('ITE_DESITE').AsString := qryPesqItens.FieldByName('BAR_DESCRI').AsString;

    If (blnCodBarEmb) Then
    begin
      if fVerificaCodBarEmbAndTabPreAndPreEmb Then
      Begin
        If (SameText(VS_strTabVen[StrToInt(qryPesqItens.FieldByName('BAR_TABPRE').AsString)], 'N')) Then
        Begin
          cdsItens.Cancel;
          cdsItens.Next;
        End;

        fatVendas.strTabPre := qryPesqItens.FieldByName('BAR_TABPRE').AsString;
        fltUnitar := fRetornaPrecoCodBarraEmb(qryPesqItens.FieldByName('ITE_CODITE').AsString,
                                              qryPesqItens.FieldByName('BAR_CODBAR').AsString,
                                              VS_strCodEmp,
                                              fatVendas.strTabPre,
                                              False);
        fltUniOri := fltUnitar;

        cdsItens.FieldByName('ITE_TABPRE').AsString := qryPesqItens.FieldByName('BAR_TABPRE').AsString;
      End;
    end;

    If (not blnCodBarEmb) Then
    Begin
      if fVerificaCodBarEmbAndTabPreAndPreEmb Then
      Begin
        fatVendas.strTabPre := qryPesqItens.FieldByName('BAR_TABPRE').AsString;
        fltUnitar := fatVendas.fPegaPrecoVenda(cdsItens, VS_strCodEmp, 'S', 0, blnItemEspecial, 'NOR', fatVendas.strTabPre, True, fltTaxJur, fltUniVis, False, 0, 'F', strConPagAux);
        fltUniOri := fltUnitar;

        cdsItens.FieldByName('ITE_TABPRE').AsString := qryPesqItens.FieldByName('BAR_TABPRE').AsString;
      End;
    End;

    If fVerificaBarPreVenAndPreEmb Then
      fltUnitar := qryPesqItens.FieldByName('BAR_PREVEN').AsFloat;

    If (qryPesqItens.FieldByName('BAR_EMBALA').AsFloat > 0.00) Then
      fltQtdIte := fltQtdIte * qryPesqItens.FieldByName('BAR_EMBALA').AsFloat;

    fatVendas.pCalculaValorRT(fltUnitar, fltVal_RT);

    strTabPre := fatVendas.strTabPre;
  End;
end;

procedure TRecalcPrecosCheckOut.pCarregaProdutoRecalculoPreco(
  const AdictReplicarRecalculo: TdictReplicarRecalculoPrecos;
  var AcdsItem: TuniClientDataSet);
var
  LcdsCloneProduto: TUniClientDataSet ;
  LintCnt: integer ;
  LstrFieldName: String ;
  LfltPreCus: double ;
begin
  LcdsCloneProduto := AdictReplicarRecalculo.Items[AcdsItem.FieldByName('ITE_CODITE').AsString] ;
  AcdsItem.Edit ;
  for LintCnt := 0 to AcdsItem.Fields.Count-1 do
  begin
    LstrFieldName := AcdsItem.Fields.Fields[LintCnt].FieldName ;
    if LstrFieldName = 'ITE_AUTINC' then
      Continue ;
    if LstrFieldName = 'ITE_QTDITE' then
      Continue ;
    if LstrFieldName = 'ITE_CHKOUT' then
      Continue ;
    if LstrFieldName = 'ITE_NUMITE' then
      Continue ;
    if LstrFieldName = 'ITE_ITEPED' then
      Continue ;
    if AcdsItem.Fields.Fields[LintCnt].FieldKind <> fkData then
      Continue ;
    If LstrFieldName = 'ITE_QTDEXP' Then
      Continue;
    if AcdsItem.FieldByName(LstrFieldName).AsVariant <> LcdsCloneProduto.FieldByName(LstrFieldName).AsVariant then
      AcdsItem.FieldByName(LstrFieldName).AsVariant := LcdsCloneProduto.FieldByName(LstrFieldName).AsVariant ;
  end ;
  ///recalculo com base na qtd
  AcdsItem.FieldByName('ITE_TOTITE').AsFloat := AcdsItem.FieldByName('ITE_UNITAR').AsFloat * AcdsItem.FieldByName('ITE_QTDITE').AsFloat ;
  LfltPreCus := fRetornaPreCusAndPromocao(AcdsItem.FieldByName('ITE_PRECUS').AsFloat) ;
  AcdsItem.FieldByName('ITE_TOTCUS').AsFloat := LfltPreCus * AcdsItem.FieldByName('ITE_QTDITE').AsFloat ;
  AcdsItem.Post ;
end;

procedure TRecalcPrecosCheckOut.pEmbalagemFechadaItem(const AstrCodIte: string);
begin
  If fVerificaEmbalagemFechadaItem Then
    fatVendas.stlItensNaoTemQtdeEmbFec.Add(AstrCodIte);
end;

procedure TRecalcPrecosCheckOut.pGuardaProdutoRecalculoPreco(
  var AdictReplicarRecalculo: TdictReplicarRecalculoPrecos;
  const AcdsItem: TuniClientDataSet);
var
  LcdsCloneProduto: TUniClientDataSet ;
begin
  if not Assigned(stlItensParaRecalcular) then
    exit ;

  LcdsCloneProduto := TUniClientDataSet.Create(Nil) ;
  LcdsCloneProduto.Data := AcdsItem.Data ;
  LcdsCloneProduto.Filter := 'ITE_AUTINC=' + AcdsItem.FieldByName('ITE_AUTINC').AsString ;
  LcdsCloneProduto.Filtered := True ;

  AdictReplicarRecalculo.Add(AcdsItem.FieldByName('ITE_CODITE').AsString, LcdsCloneProduto);

end;

procedure TRecalcPrecosCheckOut.pAplicaRegrasItensNormais;
begin
  If (not blnItemEstrutura) Then
  Begin
    If (blnUniEspecial) Then
    Begin
      fltUnitar := CdsItens.FieldByName('ITE_UNITAR').AsFloat;
      fltUniVis := fltUnitar;
      fltUniOri := fltUnitar;
      fltTaxJur := 0.00;
      fltVal_RT := 0.00;
    End;

    { ******************************************* }
    { * CASO ABATE O DESCONTO AUTOMATICAMENTE,  * }
    { * APLICA O PERCENTUAL DE DESCONTO         * }
    { ****************************************MV* }
    If fVerificaAbateDescontoAutomaticamente Then
    Begin
      { ******************************************************************** }
      { * CASO ESTEJA CONFIGURADO PARA UTILIZAR DESC. MÁX POR LINHA/GRUPO  * }
      { * DO PRODUTO E CONDIÇÃO INFORMADOS, ALTERA fltDMGCnd/fltDMVCnd     * }
      { ****************************************************************MM** }
      fltDesMax := fatVendas.fRetornaDescLinGru(qryPesqItens.FieldByName('ITE_CODITE').AsString, fatVendas.strCodCnd);

      If fCfgSis('DESCND',varBoolean) Then
      Begin
        If (fatVendas.strDstCnd = 'S') Then
        Begin
          fltDesCon := fatVendas.fRetornaVrDesconto(2, fltUnitar, fltDesMax);
          fltUnitar := fltUnitar - fatVendas.fRetornaVrDesconto(2, fltUnitar, fltDesMax);
        End;
      End
      Else If (fatVendas.strCodFpg = '007') or (fVerificarSeFormaPagamentoPedidoEhCartao) Then
      Begin
        If (fatVendas.strAbDeCc = 'S') Then
          fltUnitar := fltUnitar - fatVendas.fRetornaVrDesconto(2, fltUnitar, fltDesMax);
      End
      Else
        fltUnitar := fltUnitar - fatVendas.fRetornaVrDesconto(2, fltUnitar, fltDesMax);
    End;

    pAplicaRegrasCondicoesDePagamento(fltTaxJur, fltUniOri, fltUnitar);

  End;
end;

procedure TRecalcPrecosCheckOut.pSetaVariaveisIndicadoras(strPromocAnt: String);

  function fUnitariosDiferentes: Boolean;
  begin
    Result := (fFormataFloat(fltUnitar, 4) <> fFormataFloat(cdsItens.FieldByName('ITE_UNITAR').AsFloat, 4));
  end;

begin
  If fCfgSis('PROCXA', VarBoolean) Then
  Begin
    If (fCfgSis('RECCND', varBoolean)) Or (fCfgSis('RECPRO', varBoolean)) Then
    Begin
      If (Not blnItensEntraramOuSairamDePromocao) Then
      Begin
        If (fCfgSis('PRMF11', varInteger) = 1) Then
        Begin
          //PRMF11 = 1 - Preço Promoção
          blnItensEntraramOuSairamDePromocao := (IfEmptyStr(fatVendas.strPromoc, 'N') <> IfEmptyStr(strPromocAnt, 'N'));
        End
        Else
        Begin
          //PRMF11 = 2 - Preço Tabela
          If fatVendas.strPromoc = 'S' Then
          Begin
            If (fCfgSis('RECCND', varBoolean)) And (fltUnitar > 0.00) Then
              blnItensEntraramOuSairamDePromocao := (fUnitariosDiferentes);
          End;
        End;
      End;
    End;
  End;

  If fCfgSis('CNDCXA', VarBoolean) Then
  Begin
    If (fCfgSis('RECCND', varBoolean)) And (fltUnitar > 0.00) Then
    Begin
      If (Not blnItensTiveramUnitarModificados) Then
      Begin
        blnItensTiveramUnitarModificados := (fUnitariosDiferentes);
      End;
    End;
  End;
end;

end.
