unit untEmissaoNotaEspecial;

interface

uses
  untFuncFat, SysUtils, Uni, StrUtils, Buttons, Math, TypInfo, untTypesSistema, untFuncFatTypes,
  BitBtnLockedIncrem, untImpBoletoIndiv, untImpEtiDespacho, untFTFFNF, untLibNfe, untFuncFatImp;

Type
  TEmissaoNotaEspecial = class
    private
      FDocOri: String;
      FEspOri: String;
      FEmpOri: String;
      FCliOri: String;
      FVenOri: String;
      FRepOri: String;
      FOriDoc: String;
      FDtaEmi: TDateTime;      
      FFatEmi: Double;
      FTipFat: String;
      FstrEmpDes: String;
      FstrCodForEnt: String;
      //FDocEmi: String;
      fatVenda: TFatVenda;
      blnNS_DepostitoFechado: Boolean;

      fltTotCadRecNF: Double;
      fltTotCadRecFF: Double;
      fltTotCadRecGeral: Double;

      fltTotCreditos: Double;

      fltValAdtNF: Double;
      fltValAdtFF: Double;

      fltTotImpFF: Double;

      procedure pRaise(strMsg: String);
      procedure pCriaObjetos;
      procedure pDestroyObjetos;
      procedure pCarregaVendedor;
      procedure pCarregaCondicao;
      procedure pValidarDocumento;
      procedure pCarregaDocumentoNotaFator;
      procedure pCarregaDadosPagamentoCliente;
      function  fGravaRelacaoEntradaComNotaEspecial(strAutIncVen, strAutIncEnt: String): Boolean;
      function fGravaCadRecParaNotaEspecial(Var strChaveMeiaNota: String; fltValAdtOri: Double; fatVendaFF, fatVendaNF: TFatVenda): boolean;
      procedure pImprimeBoletoMeiaNota(strChaveMeiaNota: String);
      procedure pImprimeEtiquetaDespacho(strNumDoc, strEspDoc, strCodCli, strCodEmp: String; intQtdTra: Integer);

      function fGravaFTFFNF(fatVendaFF, fatVendaNF: TFatVenda; objFTFFNF: TFTFFNF): Boolean;

      function fDigDuplicEspecial(var arrDuplicata: TarrDuplicata; strConPag: String; dtaDtaBas: TDateTime; fltTotalCadRec: Double; fltImpFre: Double; blnFaturandoPedido: Boolean): Boolean;
      function fConsiderarIPSTnoCadRecFF: Boolean;
      function fRetAltImpostosFF(fatVendaFF, fatVendaNF: TFatVenda; blnAlterar: Boolean=False): Double;
      procedure pApuraTotaisFFeNF(fltValAdtOri: Double; fatVendaFF, fatVendaNF: TFatVenda);
      procedure pApagaDuplicatas(strNumDup, strEspDoc, strCodEmp, strCodCli, strNumPar: String);
      procedure pReconstroiParcelas(strNumDoc, strEspDoc, strCodEmp, strCodCli, strTabela: String; afatVenda: TFatVenda);
      procedure pAtualizaDuplicatasFFZerandoImpostos(strChaveMeiaNota: String; afatVenda: TFatVenda);
      function fRetornaPedidosDeVenda(fatVendaPV: TFatVenda): String;
      procedure pImprimePedidos(arrPedidos: TArrDadosImpressoesVenda);
      function fRetornaPedidosParaImpressao(fatVendaNF: TFatVenda): TArrDadosImpressoesVenda;
      function fCarregaMatrizDeItens(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): TMatrizFechamento;
      procedure pCancelaFF(strNumDoc, strCodCli, strCodEmp: String);
      function fDeveGerarCadRecParaFF(const ATotalDuplicata, AValorAdiantamento, ATotalImpostos : Double; const ACondicaoPagamento : String; const ADataBase : TDateTime; const AFaturandoPedido : Boolean): Boolean;
      function fValorDaPrimeiraParcela(const ATotalDuplicata, AValorAdiantamento, ATotalImpostos : Double; const ACondicaoPagamento : String; const ADataBase : TDateTime; const AFaturandoPedido : Boolean) : Double;
      procedure pVerificaSeDeveZerarTotalDaDuplicata(var ATotalDaDuplicata : Double; const AValorAdiantamento : Double);
      function fTotalDuplicatasFF : Double;
      function fTotalDuplicatasNF : Double;
      function fDataBase(const AFatVenda : TFatVenda) : TDateTime;
      function fImpostosDaFF : Double;
    public
      strMsgNota: String;
      constructor Create;
      destructor  Destroy; Override;
      procedure pCriaObjetosExt;
      procedure pSetaTransferenciaDepositoFechado(ACodFor: String = ''; ACodEmpDes: String = '');

      class procedure pCarregaItensNotaEspecial(fatVenda : TFatVenda; qryItens : TUniQuery;
                                                var blnAvisarOperadorVendaComPrecoCusto : Boolean;
                                                strEmpDes: String=''); static;
      class function fPermiteEmissaoAbaixoDoCusto(const strOpcDoc: String): Boolean;

      function fEmitirNotaEspecial(strNumDoc, strEspDoc, strCodEmp, strTipoFator: String; fltFator, fltPesBru, fltPesLiq: Double; blnRecalculaVolumes: Boolean; strAutIncEnt: String = ''; intQtdTra: integer = 0; blnImpEti: Boolean = False; fltValAdtOri: Double = 0; fatVendaFF: TFatVenda = Nil): Boolean;
  end;

implementation

uses untFuncoes, untConstantes, untFuncoesSimples, untPesqAux, untGravando,
     untMadeireira, Data.DB, untDuplicatas, untCadRec, untCancelamentoDocumentos;

{ TEmissaoNotaEspecial }

constructor TEmissaoNotaEspecial.Create;
begin
  inherited Create;
  blnNS_DepostitoFechado := False;

  fltTotCadRecNF := 0;
  fltTotCadRecFF := 0;
  fltTotCadRecGeral := 0;

  fltTotCreditos := 0;

  fltValAdtNF := 0;
  fltValAdtFF := 0;

  fltTotImpFF := 0;
end;

destructor TEmissaoNotaEspecial.Destroy;
begin
  pDestroyObjetos;
  inherited Destroy;
end;

procedure TEmissaoNotaEspecial.pDestroyObjetos;
begin
  pFreeCdsVenda;
  If Assigned(fatVenda) Then
    FreeAndNil(FatVenda);
end;

procedure TEmissaoNotaEspecial.pCancelaFF(strNumDoc, strCodCli, strCodEmp: String);
var
  frmCancelamentoDocumentos: TfrmCancelamentoDocumentos;
begin
  pCriarFormularios(TfrmCancelamentoDocumentos, frmCancelamentoDocumentos);

  try
    try
      frmCancelamentoDocumentos.pSetEspecie('FF');
      frmCancelamentoDocumentos.lsbEspecies.ItemIndex := frmCancelamentoDocumentos.IndiceEspecie;
      frmCancelamentoDocumentos.lsbEspeciesDblClick(frmCancelamentoDocumentos.lsbEspecies);

      frmCancelamentoDocumentos.edtNumDoc.Text  := strNumDoc;
      frmCancelamentoDocumentos.edtCliFor.Text  := strCodCli;
      frmCancelamentoDocumentos.blnCancelamentoDeFFPelaNotaEspecial := True;
      frmCancelamentoDocumentos.btnAdicionar.Click;

      If fCampoTabela('COUNT(*)', 'MOVGER', ['GER_NUMDOC','GER_CODEMP','GER_CODCLI','GER_ESPDOC'], [strNumDoc,strCodEmp,strCodCli,'FF']) > 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Não foi possível cancelar a FF '+strNumDoc+'. Favor cancelar manualmente!', ['&Ok']);
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Documento '+strNumDoc+'-FF-'+strCodEmp+' cancelado com sucesso.', ['&Ok']);
      End;
    except
      On E: Exception Do
        pMensagensErro(E.Message, '[TEmissaoNotaEspecial.fCancelaFF]');
    end;
  finally
    pFreeAndNil(frmCancelamentoDocumentos);
  end;
end;

function TEmissaoNotaEspecial.fCarregaMatrizDeItens(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: String): TMatrizFechamento;
var
  intPosicao : Integer;
  qryFatDor : TUniQuery;
begin
  SetLength(Result, 0);
  qryFatDor := fCriaQuery;
  Try
    qryFatDor.Close;
    qryFatDor.SQL.Clear;
    qryFatDor.SQL.Add(' SELECT FDO_CODITE, FDO_QTDITE, ITE_PESOIT, FDO_PESLIQ, ');
    qryFatDor.SQL.Add('        FDO_ENTRET, FDO_ENTFUT, FDO_CLAFIS ');
    qryFatDor.SQL.Add('   FROM FATDOR ');
    qryFatDor.SQL.Add('   JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ');
    qryFatDor.SQL.Add('   JOIN CADITE ON CADITE.ITE_CODITE = FATDOR.FDO_CODITE ');
    qryFatDor.SQL.Add('  WHERE FDO_NUMDOC = :NUMDOC ');
    qryFatDor.SQL.Add('    AND FDO_ESPDOC = :ESPDOC ');
    qryFatDor.SQL.Add('    AND FDO_CODEMP = :CODEMP ');
    qryFatDor.SQL.Add('    AND FDO_CODCLI = :CODCLI ');
    qryFatDor.ParamByName('NUMDOC').AsString := strNumDoc;
    qryFatDor.ParamByName('ESPDOC').AsString := strEspDoc;
    qryFatDor.ParamByName('CODEMP').AsString := strCodEmp;
    qryFatDor.ParamByName('CODCLI').AsString := strCodCli;
    qryFatDor.Open;

    if qryFatDor.IsEmpty then
      Exit;

    qryFatDor.First;
    While Not qryFatDor.Eof Do
    Begin
      SetLength(Result, Length(Result) + 1);
      intPosicao := Length(Result) - 1;
      Result[intPosicao].strCodIte := qryFatDor.FieldByName('FDO_CODITE').AsString;
      Result[intPosicao].fltQtdIte := qryFatDor.FieldByName('FDO_QTDITE').AsFloat;
      Result[intPosicao].strEntRet := qryFatDor.FieldByName('FDO_ENTRET').AsString;
      Result[intPosicao].strEntFut := qryFatDor.FieldByName('FDO_ENTFUT').AsString;
      Result[intPosicao].fltPesoIt := qryFatDor.FieldByName('ITE_PESOIT').AsFloat;
      Result[intPosicao].fltPesLiq := qryFatDor.FieldByName('FDO_PESLIQ').AsFloat;
      Result[intPosicao].strClaFis := qryFatDor.FieldByName('FDO_CLAFIS').AsString;

      qryFatDor.Next;
    End;
  Finally
    FreeAndNil(qryFatDor);
  End;
end;

function TEmissaoNotaEspecial.fDigDuplicEspecial(var arrDuplicata: TarrDuplicata; strConPag: String; dtaDtaBas: TDateTime; fltTotalCadRec: Double; fltImpFre: Double; blnFaturandoPedido: Boolean): Boolean;
begin
  Result := fDigDuplic(arrDuplicata, fTiraCaracEspeciaisParenteses(strConPag), 0, fltTotalCadRec,
                       False, False, False, dtaDtaBas, False, fltImpFre,
                       'N', fCfgSis('DUPRED', varBoolean), False, 0, False,
                       Nil, '', fCfgSis('FSDUDP', varBoolean), True, Nil, '', False, True, '', '', Nil, blnFaturandoPedido);
end;

procedure TEmissaoNotaEspecial.pImprimeBoletoMeiaNota(strChaveMeiaNota: String);
var
  qryBoleto: TUniQuery;
begin
  if fCampoTabela('CND_IMPBOL', 'CADCND', ['CND_CODIGO'], [fatVenda.strCodCnd], False) = 'N' Then
    Exit;

  qryBoleto := fCriaQuery;

  try
    qryBoleto.Close;
    qryBoleto.SQL.Clear;
    qryBoleto.SQL.Add('SELECT DISTINCT CTR_NUMDUP, CTR_ESPDOC, CTR_CODEMP, CTR_CODCLI');
    qryBoleto.SQL.Add('FROM CADREC');
    qryBoleto.SQL.Add('WHERE CTR_CHVPFF = :CHVPFF');
    qryBoleto.SQL.Add('AND CTR_VALDUP > 0');
    qryBoleto.ParamByName('CHVPFF').AsString := strChaveMeiaNota;
    qryBoleto.Open;

    if qryBoleto.IsEmpty then
      Exit;

    while not qryBoleto.Eof do
    begin
      TfrmImpBoletoIndiv.pImprimirBoletos(qryBoleto.FieldByName('CTR_NUMDUP').AsString, qryBoleto.FieldByName('CTR_ESPDOC').AsString, qryBoleto.FieldByName('CTR_CODEMP').AsString, qryBoleto.FieldByName('CTR_CODCLI').AsString, True);
      qryBoleto.Next;
    end;
  finally
    FreeAndNil(qryBoleto);
  end;
end;

procedure TEmissaoNotaEspecial.pImprimeEtiquetaDespacho(strNumDoc, strEspDoc,
  strCodCli, strCodEmp: String; intQtdTra: Integer);
  Var
    frmImpEtiDespacho : TfrmImpEtiDespacho;
begin
  Try
    If Pos(strEspDoc, 'NF_EL_IF_IV_D1_MI_FF_TE_TR_BR_UC_PD_OR_') <= 0 Then
    begin
      Exit;
    end;

    pCriarFormularios(TfrmImpEtiDespacho, frmImpEtiDespacho);
    frmImpEtiDespacho.edtNumDoc.Text := strNumDoc;
    frmImpEtiDespacho.edtEspDoc.Text := strEspDoc;
    frmImpEtiDespacho.edtCodEmp.Text := strCodEmp;
    frmImpEtiDespacho.strCodCli      := strCodCli;
    frmImpEtiDespacho.edtQtdVol.Text := IntToStr(intQtdTra);
    frmImpEtiDespacho.blnImpEti      := True;
    frmImpEtiDespacho.blnExpedi      := True;
    frmImpEtiDespacho.fCarregaVolume; //Caso use Sigep precisa chamar essa funçao para carregar os dados do correio.

    If (intQtdTra <= 0) Or (Not frmImpEtiDespacho.fValidarTodosCampos) Then
      frmImpEtiDespacho.ShowModal
    Else
      frmImpEtiDespacho.btnConfirma.Click;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[frmFatExpedicaoItens -> frmImpEtiDespacho]');
  End;
  pFreeAndNil(frmImpEtiDespacho);
end;

procedure TEmissaoNotaEspecial.pImprimePedidos(arrPedidos: TArrDadosImpressoesVenda);
var
  objFatVendaImp : TFatVendaImp;
  intIndice: integer;
begin
  if Length(arrPedidos) <= 0 then
    Exit;

  objFatVendaImp := TFatVendaImp.Create;

  try
    for intIndice := Low(arrPedidos) to High(arrPedidos) do
      objFatVendaImp.Add(arrPedidos[intIndice]);

    objFatVendaImp.pImprimirDocumentos(nil, nil, nil, nil);
  finally
    FreeAndNil(objFatVendaImp);
  end
end;

function TEmissaoNotaEspecial.fEmitirNotaEspecial(strNumDoc, strEspDoc,
  strCodEmp, strTipoFator: String; fltFator, fltPesBru, fltPesLiq: Double;
  blnRecalculaVolumes: Boolean; strAutIncEnt: String = ''; intQtdTra: integer = 0; blnImpEti: Boolean = False; fltValAdtOri: Double = 0; fatVendaFF: TFatVenda = Nil): Boolean;
var
  intTentativas: Integer;
  strChaveMeiaNota: String;
  blnPainelNfe: Boolean;
begin
  strMsgNota := '';
  blnPainelNfe := False;

  If Not blnNS_DepostitoFechado Then
    pCriaObjetos;

  If Assigned(fatVendaFF) Then
  Begin
    fatVenda.blnEmitindoNFDaNotaEspecialFatorPorValor := fatVendaFF.blnEmitindoFFDaNotaEspecialFatorPorValor;
    fatVenda.objDadosCte.Copy(fatVendaFF.objDadosCte);
  End;

  FDocOri := strNumDoc;
  FEspOri := strEspDoc;
  FEmpOri := strCodEmp;
  FFatEmi := fltFator;
  FTipFat := strTipoFator;

  If fEmptyStr(FTipFat) Then
    FTipFat := 'V'; //Fator no Valor

  Result  := False;

  If Not blnNS_DepostitoFechado Then
    pValidarDocumento;

  pCarregaDocumentoNotaFator;

  fatVenda.pPreencheMatrizFechamento;

  fatVenda.blnEmitindoNFDaNotaEspecialFatorPorValorSeraEnviadoPainel :=
                                       (fCfgSis('NFEUSA', varBoolean)) And
                                       (fCfgSis('PNLNFE', varBoolean)) And
                                       (fatVenda.blnEmitindoNFDaNotaEspecialFatorPorValor);

  If Length(fatVenda.arrMatItens) = 0 Then
    pRaise('Não há nenhum produto neste documento! Favor verificar.');

  If fltPesBru = -1 Then
    fatVenda.pCalculaPesBruLiq
  Else
  Begin
    fatVenda.fltPesBru := fltPesBru;
    fatVenda.fltPesLiq := fltPesLiq;

    If fCfgSis('PESLIQ') = 'FATOR' Then
      fatVenda.fltPesLiq := fFormataFloat(fatVenda.fltPesBru * fStrToFloat(fCfgSis('FATPLI', varDouble)), 3)
  End;

  fatVenda.pCalculaTotGer(False, False);

  If fatVenda.fAplicaDescontoIcmsOrgaoPublicoNoDescontoEspecial Then
  Begin
    If (fatVenda.fltDesEsp <= 0.00) And (fatVenda.fltIcmOrg > 0) Then
      fatVenda.fltDesEsp := fatVenda.fltIcmOrg;
  End;

  fatVenda.pDestacaRetencoes;
  fatVenda.pRetemImpostosNoDescontoEspecial;

  fatVenda.pCalculaTotGer(False, False);

  fatVenda.strEspDoc := 'NF';

  If Not fatVenda.fDadosCorretosParaClienteConsumidor(fatVenda.strEspDoc) Then
    pRaise('Não é permitido emitir Nota Fiscal sem preencher todos os dados do cliente.');

  fatVenda.pCalculaTotGer;

  fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

  If fCfgSis('VOLESP', varBoolean) Then
  Begin
    If fCfgSis('CALVOL', varBoolean) Then
    Begin
      fatVenda.intQtdTra := Floor(fatVenda.fRetVolumes);
      If fCfgSis('SEPEXC', varBoolean) Then
      Begin
        fatVenda.intQtdTraSepExc  := Floor(fatVenda.fRetVolumesSepExc);
        fatVenda.intQtdTraSepNExc := (fatVenda.intQtdTra - fatVenda.intQtdTraSepExc);
      End;
    End;
  End;

  {*********************************************************}
  {* CASO SEJA NOTA FISCAL, CHAMA A TELA DOS DADOS FISCAIS *}
  {******************************************************LU*}
{ If (fatVenda.strTipPed = 'A') And (fCfgSis('ADIEXP') = 'S') Then
  Begin
    Try
      pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);
      frmFatDadosFiscais.fatVenda := fatVenda;
      frmFatDadosFiscais.showModal;
      blnConfirma := frmFatDadosFiscais.blnConfirma;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[btnConfirmaClick_DadosFiscais]');
      End;
    End;
    pFreeAndNil(frmFatDadosFiscais);
  End
  Else
    blnConfirma := True;}
  If blnNS_DepostitoFechado Then
  Begin
    fatVenda.strDtaAtu := FormatDateTime('dd/mm/yyyy',VS_Date);
    fatVenda.strHorSai := FormatDateTime('hh:mm:ss', fTime());
  End
  Else
  begin
    Repeat
      //
    Until (fatVenda.fSolicitaDataHoraEntradaSaidaNotaFiscal);
  End;

  fatVenda.pCalculaTotalParaCadRec;

  fDigDuplic(fatVenda.arrDuplicata,
             fTiraCaracEspeciaisParenteses(fatVenda.strConPag), 0, fatVenda.fltTotCadRec,
             FAlse, False, False, VS_Date, False, fatVenda.fltImpFre, 'N', fCfgSis('DUPRED', varBoolean));

  fatVenda.pRateiaValores;

  If (fatVenda.fltTotIcm <= 0.0) Then
    fatVenda.fltAlqIcm := 0.0;

  If (fatVenda.fltTotIpi <= 0.0) Then
    fatVenda.fltAlqIpi := 0.0;

  If (Pos(fatVenda.strEspDoc,'NF_EL_NS_') > 0) And (fCfgSis('CPFOBR', varBoolean)) Then
  Begin
    If (fEmptyStr(fatVenda.strCliCgc)) Then
      pRaise('Cliente não possui CPF / CNPJ. Não será permitido emitir nota fiscal.');

    If (fReplicatorStr(fatVenda.strCliCgc[1], Length(fatVenda.strCliCgc)) = fatVenda.strCliCgc) And (fatVenda.strCliEst <> 'EX') Then
      pRaise('O CPF / CNPJ do cliente não é válido para emitir nota fiscal.');
  End;

  If blnNS_DepostitoFechado Then
    fatVenda.strNTrava := 'NNNNNNNNNNNNNNNNNNNN';

  fatVenda.strNomeForm := 'frmFatVendas';
  fatVenda.blnTranferenciaDepositoFechado := blnNS_DepostitoFechado;

  if (fatVenda.blnMeiaNota) And fCfgSis('FTNFES', varBoolean) And ((strTipoFator='V') Or (strTipoFator='Q')) then
  begin
    fatVenda.strNumFatFFEsp := FDocOri;
    fatVenda.strTipFatFFEsp := FEspOri;
    fatVenda.strEmpFatFFEsp := FEmpOri;
  end;

  Try
    If Assigned(fatVendaFF) Then
      Self.pApuraTotaisFFeNF(fltValAdtOri, fatVendaFF, Self.fatVenda);
    fatVenda.fltFatDaNF := Self.fltValAdtNF;
    fatVenda.fltFatDaFF := Self.fltValAdtFF;
    fatVenda.strPVEspe := fRetornaPedidosDeVenda(fatVenda);

    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.strChave := 'FATVENDAS';
    frmGravando.fExecutarAcao := fatVenda.fGravaArquivos;
    frmGravando.ShowModal;

    Result := frmGravando.blnConfirma;

    If Not Result Then
    Begin
      fMensagem('ATENÇÃO!', 'Houve um erro ao tentar gerar a Nota Especial. O Documento '+FDocOri+'-FF-'+FEmpOri+' sera cancelado.', ['&Ok']);
      pCancelaFF(FDocOri, fatVendaFF.strCodCli, FEmpOri);
    End;

    If (Result) And (fatVenda.fGerandoFFOuNFNaDeNotaEspecialPorValorComCadRecSeparado) Then
    Begin
      fStartTransaction;
      if fGravaCadRecParaNotaEspecial(strChaveMeiaNota, fltValAdtOri, fatVendaFF, Self.fatVenda) then
      begin
        if (fatVenda.blnEmitindoNFDaNotaEspecialFatorPorValorSeraEnviadoPainel) and (fatVenda.fDeveEmitirNotaEletronica(fatVenda.strEspDoc, fatVenda.strEmpDoc, blnPainelNfe)) and (blnPainelNfe) then
        begin
           pGravarLogNfe(fatVenda.strNumDoc, fatVenda.strEspDoc, fatVenda.strEmpDoc, fatVenda.strSerFsc,
                         IIF(fatVenda.strNotImp = 'S', fatVenda.strCodFor, fatVenda.strCodCli),
                         IIF(fatVenda.fDocumentoParaFornecedor Or (fatVenda.strNotImp = 'S'),'F','C'), 'EE', 'Utilize F1 do Painel para Reenviar...');
        end
        else
        begin
          blnPainelNfe := False;
        end;

        if fCommit then
        begin
          if blnPainelNfe then
            fExecutarModal(fatVenda.fEnviarNotaEletronicaPainel, 'Aguarde ...', '');

          if (intQtdTra > 0) and (blnImpEti) then
          Begin
            For intTentativas := 1 To 10 Do
            Begin
              Sleep(1000);
              If (not fEmptyStr(fRetChaveAcesso(fatVenda.strNumDoc, fatVenda.strEspDoc, fatVenda.strCodCli, fatVenda.strEmpDoc))) And
                 (fPainelNFeStatusDocumento(fatVenda.strNumDoc, fatVenda.strEspDoc, fatVenda.strEmpDoc, fatVenda.strCodCli, fatVenda.strSerFsc) = 'AT') Then
              Begin
                pImprimeEtiquetaDespacho(fatVenda.strNumDoc, fatVenda.strEspDoc, fatVenda.strCodCli, fatVenda.strEmpDoc, intQtdTra);
                Break;
              End;
            End
          End;

          fatVendaFF.objFatVendaImp.pImprimirDocumentos(nil, nil, nil, nil);

          if fCfgSis('PEDESP', varBoolean) then
            pImprimePedidos(fRetornaPedidosParaImpressao(fatVenda));

          if not fEmptyStr(strChaveMeiaNota) then
            pImprimeBoletoMeiaNota(strChaveMeiaNota);
        end;
      end
      else
      begin
        fRollBack;
        fMensagem('Atenção!', 'Nota Fiscal ('+fatVenda.strNumDoc+'-'+fatVenda.strEspDoc+') emitida. '+
                              'Porém ocorreu um erro durante a gravação do contas a receber. Cancele essa nota '+
                              'e cancele também a ('+fatVendaFF.strNumDoc+'-'+fatVendaFF.strEspDoc+'), '+
                              'repita a operação e confira os valores. Se o problema persistir entre em contato com a Citel!', ['&O k']);
        Result := False
      end;
    End
    Else if (Result) And Assigned(fatVendaFF) And (fatVendaFF.blnGerarEtiquetaDespachoNFEspecialFatorSemDUPREC) then
    begin
      if (intQtdTra > 0) and (blnImpEti) then
      Begin
        For intTentativas := 1 To 10 Do
        Begin
          Sleep(1000);
          If (not fEmptyStr(fRetChaveAcesso(fatVenda.strNumDoc, fatVenda.strEspDoc, fatVenda.strCodCli, fatVenda.strEmpDoc))) And
             (fPainelNFeStatusDocumento(fatVenda.strNumDoc, fatVenda.strEspDoc, fatVenda.strEmpDoc, fatVenda.strCodCli, fatVenda.strSerFsc) = 'AT') Then
          Begin
            pImprimeEtiquetaDespacho(fatVenda.strNumDoc, fatVenda.strEspDoc, fatVenda.strCodCli, fatVenda.strEmpDoc, intQtdTra);
            Break;
          End;
        End
      End;
    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'');
    End;
  End;

  If blnNS_DepostitoFechado Then
    Result := Result And fGravaRelacaoEntradaComNotaEspecial(fatVenda.strAutInc, strAutIncEnt);

  pFreeAndNil(frmGravando);

  If Result Then
  Begin
    If Not blnNS_DepostitoFechado Then
      pMensagemOk('Nota Fiscal (' + fatVenda.strNumDoc + '-' + fatVenda.strEspDoc + ') emitida com sucesso!')
    Else
      strMsgNota := 'Nota Especial de Transferência (' + fatVenda.strNumDoc + '-' + fatVenda.strEspDoc + ') emitida com sucesso!';
  End;

  If Not blnNS_DepostitoFechado Then
    pDestroyObjetos;
end;

function TEmissaoNotaEspecial.fConsiderarIPSTnoCadRecFF: Boolean;
begin
  Result := (fCfgSis('IPSTMF', varBoolean)) And (fCfgSis('DUIPST', varBoolean));
end;

function TEmissaoNotaEspecial.fRetAltImpostosFF(fatVendaFF, fatVendaNF: TFatVenda; blnAlterar: Boolean=False): Double;
  Var
    fltFator: Double;
begin
  Result := 0;

  If (fConsiderarIPSTnoCadRecFF) Then
  Begin
    fltFator := (1 - (fatVendaNF.fltTotCadRec / fatVendaFF.fltTotCadRec));

    If blnAlterar Then
    Begin
      fatVendaFF.fltTotRet   := fFormataFloat(fatVendaFF.fltTotRet * fltFator, 2);
      fatVendaFF.fltTotFcpST := fFormataFloat(fatVendaFF.fltTotFcpST * fltFator, 2);
      fatVendaFF.fltTotIpi   := fFormataFloat(fatVendaFF.fltTotIpi * fltFator, 2);
      fatVendaFF.fltTotCBS   := fFormataFloat(fatVendaFF.fltTotCBS * fltFator, 2);
      fatVendaFF.fltTotIBS   := fFormataFloat(fatVendaFF.fltTotIBS * fltFator, 2);
      fatVendaFF.fltTotIS    := fFormataFloat(fatVendaFF.fltTotIS * fltFator, 2);
    End
    Else
    Begin
      Result := Result + fFormataFloat(fatVendaFF.fltTotRet * fltFator, 2);
      Result := Result + fFormataFloat(fatVendaFF.fltTotFcpST * fltFator, 2);
      Result := Result + fFormataFloat(fatVendaFF.fltTotIpi * fltFator, 2);
      Result := Result + fFormataFloat(fatVendaFF.fltTotCBS * fltFator, 2);
      Result := Result + fFormataFloat(fatVendaFF.fltTotIBS * fltFator, 2);
      Result := Result + fFormataFloat(fatVendaFF.fltTotIS * fltFator, 2);

      Result := fFormataFloat(Result, 2);
    End;
  End;
end;

procedure TEmissaoNotaEspecial.pApuraTotaisFFeNF(fltValAdtOri: Double; fatVendaFF, fatVendaNF: TFatVenda);
  Var
    fltFator: Double;
begin
  fltTotImpFF := fRetAltImpostosFF(fatVendaFF, fatVendaNF);

  fltTotCadRecNF := fatVendaNF.fltTotCadRec;
  If (fConsiderarIPSTnoCadRecFF) Then
  Begin
    fltFator := (1 - (fatVendaNF.fltTotCadRec / fatVendaFF.fltTotCadRec));
    fltTotCadRecFF := fFormataFloat(fatVendaFF.fltTotCadRec * fltFator, 2);
  End
  Else
  Begin
    fltTotCadRecFF := fFormataFloat((fatVendaFF.fltTotPro - fatVendaFF.fltDesEsp) - (fatVendaNF.fltTotPro - fatVendaNF.fltDesEsp), 2);
  End;
  fltTotCadRecGeral := fltTotCadRecFF + fltTotCadRecNF;

  fltTotCreditos := 0;
  fltValAdtNF    := 0;
  fltValAdtFF    := 0;

  If (fFormataFloat(fltValAdtOri, 2) > 0) And (fFormataFloat(fltTotCadRecGeral, 2) > 0) Then
  Begin
    fltValAdtNF := fFormataFloat(fltValAdtOri * (fltTotCadRecNF/fltTotCadRecGeral), 2);
    fltValAdtFF := fFormataFloat(fltValAdtOri * (fltTotCadRecFF/fltTotCadRecGeral), 2);

    If (fFormataFloat(fltValAdtOri, 2) >= fFormataFloat(fltTotCadRecGeral, 2)) Then
    Begin
      fltTotCreditos := fFormataFloat(fltValAdtOri - fltTotCadRecGeral, 2);
      fltValAdtNF := fFormataFloat((fltValAdtOri-fltTotCreditos) * (fltTotCadRecNF/fltTotCadRecGeral), 2);
      fltValAdtFF := fFormataFloat((fltValAdtOri-fltTotCreditos) * (fltTotCadRecFF/fltTotCadRecGeral), 2);

      fltTotCadRecNF := 0;
      fltTotCadRecFF := 0;
    End;
  End;
end;

function TEmissaoNotaEspecial.fGravaCadRecParaNotaEspecial(Var strChaveMeiaNota: String; fltValAdtOri: Double; fatVendaFF, fatVendaNF: TFatVenda): boolean;
var
  dtaDtaBas: TDateTime;
  intPar: Integer;
  intIndice: Integer;
  intSeqConFF: Integer;
  intSeqConNF: Integer;
  fltTotImp: Double;
  fltTotDup: Double;
  objFTFFNF: TFTFFNF;
  strComplementoHistoricoCredito: String;
  blnDeveGerarCadRecParaFF : Boolean;
begin
  Result := True;
  Try
    intSeqConFF := fatVendaFF.intSeqCon;
    intSeqConNF := fatVendaNF.intSeqCon;;

    objFTFFNF := TFTFFNF.Create;
    Try
      strChaveMeiaNota := fatVendaFF.strNumDoc + '_' + fatVendaFF.strEspDoc + '_' + fatVendaFF.strEmpDoc + '_' + fatVendaFF.strCodCli;

      fatVendaNF.strChaveMeiaNota := strChaveMeiaNota;
      fatVendaFF.strChaveMeiaNota := strChaveMeiaNota;

      fatVendaFF.pSetRcxCon(intSeqConFF, intSeqConFF); //USA O MESMO SEQCON DA FF
      fatVendaNF.pSetRcxCon(intSeqConFF, intSeqConFF); //USA O MESMO SEQCON DA FF

      pApuraTotaisFFeNF(fltValAdtOri, fatVendaFF, fatVendaNF);

      SetPropValue(objFTFFNF, 'VlrConFat', fltTotCadRecGeral);

      For intIndice := Low(fatVendaFF.arrMatItens) To High(fatVendaFF.arrMatItens) Do
      Begin
        If fEmptyStr(fatVendaFF.arrMatItens[intIndice].strNumOrc) Then
          Continue;

        Try
          fatVendaNF.arrMatItens[intIndice].strNumOrc := fatVendaFF.arrMatItens[intIndice].strNumOrc;
          fatVendaNF.arrMatItens[intIndice].strEspOrc := fatVendaFF.arrMatItens[intIndice].strEspOrc;
          fatVendaNF.arrMatItens[intIndice].strEmpOrc := fatVendaFF.arrMatItens[intIndice].strEmpOrc;
        Except

        End;
      End;

      //GRAVA CADREC NF [INÍCIO]...
      dtaDtaBas := fDataBase(fatVendaNF);

      fltTotImp := 0;

      if (fCfgSis('IMPSUB', varBoolean)) then
        fltTotImp := fltTotImp + fatVendaNF.fltTotRet + fatVendaNF.fltTotFcpST;

      if (fCfgSis('IMPIPI', varBoolean)) then
        fltTotImp := fltTotImp + fatVendaNF.fltTotIpi;

      if (fCfgSis('IMPCBS', varBoolean)) then
        fltTotImp := fltTotImp + fatVendaNF.fltTotCBS + fatVendaNF.fltTotIBS + fatVendaNF.fltTotIS;

      if (fCfgSis('IMPFRE', varBoolean)) then
        fltTotImp := fltTotImp + fatVendaNF.fltValFre;

      blnDeveGerarCadRecParaFF := fDeveGerarCadRecParaFF(fTotalDuplicatasFF,
                                                         fltValAdtFF,
                                                         fImpostosDaFF,
                                                         fatVendaFF.strConPag,
                                                         fDataBase(fatVendaFF),
                                                         fatVendaFF.fFaturandoPedido);

      If (blnDeveGerarCadRecParaFF) Then
        fltTotDup := fTotalDuplicatasNF
      Else
        fltTotDup := fTotalDuplicatasNF + fTotalDuplicatasFF;

      fatVendaNF.fltValAdt := fltValAdtNF;

      pVerificaSeDeveZerarTotalDaDuplicata(fltTotDup, fatVendaNF.fltValAdt);

      Result := Result And fDigDuplicEspecial(fatVendaNF.arrDuplicata, fatVendaNF.strConPag, dtaDtaBas, fltTotDup, fltTotImp, fatVendaNF.fFaturandoPedido);

      If fltValAdtNF > 0 Then
        Result := Result And fatVendaNF.fAdicionaAdiantamentoPrimeiraParcela(False, True, True);

      Result := Result And fatVendaNF.fGCadRec;

      If Result Then
        pReconstroiParcelas(fatVendaNF.strNumDoc, fatVendaNF.strEspDoc, fatVendaNF.strEmpDoc, fatVendaNF.strCodCli, 'NOTGER', fatVendaNF);

      intPar := 0;
      For intIndice := Low(fatVendaNF.arrDuplicata) To High(fatVendaNF.arrDuplicata) Do
      Begin
        If fatVendaNF.intSeqDupBaiAdtCli = intIndice Then
          Continue;

        Inc(intPar);
        SetPropValue(objFTFFNF, 'VParNF'+ fStrZero(IntToStr(intPar), 2), fatVendaNF.arrDuplicata[intIndice].curValor);
      End;
      //...GRAVA CADREC NF [FINAL]


      //**********************************************************************//


      //GRAVA CADREC FF [INÍCIO]...
      If Result Then
        pApagaDuplicatas(FDocOri, FEspOri, FEmpOri, fatVendaNF.strCodCli, ''); //APAGA A CADREC GERADA NA EMISSÃO DA FF

      dtaDtaBas := fDataBase(fatVendaFF);

      fltTotImp := fImpostosDaFF; //FF NÃO VAI GRAVAR IMPOSTOS

      If (fltTotImpFF <> 0) Then
      Begin
        fatVendaFF.pSetBackupVar(['fltTotRet', 'fltTotFcpST', 'fltTotIpi', 'fltTotCBS', 'fltTotIBS', 'fltTotIS']);

        fRetAltImpostosFF(fatVendaFF, fatVendaNF, True);

        If (fCfgSis('IMPSUB', varBoolean)) Then
          fltTotImp := fltTotImp + fatVendaFF.fltTotRet + fatVendaFF.fltTotFcpST;

        If (fCfgSis('IMPIPI', varBoolean)) Then
          fltTotImp := fltTotImp + fatVendaFF.fltTotIpi;

        If (fCfgSis('IMPCBS', varBoolean)) Then
          fltTotImp := fltTotImp + fatVendaFF.fltTotCBS + fatVendaFF.fltTotIBS + fatVendaFF.fltTotIS;
      End;

      If (blnDeveGerarCadRecParaFF) Then
        fltTotDup := fTotalDuplicatasFF
      Else
        fltTotDup := 0;

      fatVendaFF.fltValAdt := fltValAdtFF;

      pVerificaSeDeveZerarTotalDaDuplicata(fltTotDup, fatVendaFF.fltValAdt);

      Result := Result And fDigDuplicEspecial(fatVendaFF.arrDuplicata, fatVendaFF.strConPag, dtaDtaBas, fltTotDup, fltTotImp, fatVendaFF.fFaturandoPedido);

      If fltValAdtFF > 0 Then
        Result := Result And fatVendaFF.fAdicionaAdiantamentoPrimeiraParcela(False, True, True);

      Result := Result And fatVendaFF.fGCadRec;

      If Result Then
        pReconstroiParcelas(fatVendaFF.strNumDoc, fatVendaFF.strEspDoc, fatVendaFF.strEmpDoc, fatVendaFF.strCodCli, 'MOVGER', fatVendaFF);

      If Result Then
        pAtualizaDuplicatasFFZerandoImpostos(strChaveMeiaNota, fatVendaFF); //ZERA TODOS IMPOSTOS QUE EVENTUALMENTE TENHAM SIDOS GRAVADOS

      intPar := 0;
      For intIndice := Low(fatVendaFF.arrDuplicata) To High(fatVendaFF.arrDuplicata) Do
      Begin
        If fatVendaFF.intSeqDupBaiAdtCli = intIndice Then
          Continue;

        Inc(intPar);
        SetPropValue(objFTFFNF, 'VParFF'+ fStrZero(IntToStr(intPar), 2), fatVendaFF.arrDuplicata[intIndice].curValor);
      End;
      //...GRAVA CADREC FF [FINAL]

      SetPropValue(objFTFFNF, 'VlrCredit', 0);
      If (Result) And (fltTotCreditos > 0) Then
      Begin
        SetPropValue(objFTFFNF, 'VlrCredit', fltTotCreditos);
        strComplementoHistoricoCredito := ' NA EMISSAO DE: '+fatVendaFF.strNumDoc+'-'+fatVendaFF.strEspDoc+'-'+fatVendaFF.strEmpDoc+'/'+fatVendaNF.strNumDoc+'-'+fatVendaNF.strEspDoc+'-'+fatVendaNF.strEmpDoc+'.';
        fatVendaFF.fGerarCreditoSaldoAdiantamento(fatVendaFF.fRetPedidosDosItens(fatVendaFF.arrMatItens), strComplementoHistoricoCredito);
      End;

      If Result Then
        If (fltTotImpFF <> 0) Then
          fatVendaFF.pGetBackupVar(['fltTotRet', 'fltTotFcpST', 'fltTotIpi', 'fltTotCBS', 'fltTotIBS', 'fltTotIS']);

      If Result Then
        Result := fGravaFTFFNF(fatVendaFF, fatVendaNF, objFTFFNF);
    Finally
      FreeAndNil(objFTFFNF);
      fatVendaNF.strChaveMeiaNota := '';
      fatVendaFF.strChaveMeiaNota := '';
      fatVendaFF.pSetRcxCon(intSeqConFF, -1);
      fatVendaNF.pSetRcxCon(intSeqConNF, -1);
    End;
  Except
    Result := False;
  End;
end;

function TEmissaoNotaEspecial.fGravaFTFFNF(fatVendaFF, fatVendaNF: TFatVenda; objFTFFNF: TFTFFNF): Boolean;
begin
  objFTFFNF.AutInc := fRetAutoIncrem('FTFFNF', VS_strCodEmp);
  objFTFFNF.DtaFat := fRetDataServidor;
  objFTFFNF.CodCli := fatVendaNF.strCodCli;
  objFTFFNF.NumPed    := fCampoTabela('FGO_NUMDOC', 'FATGOR', ['FGO_NUMFAT', 'FGO_TIPFAT', 'FGO_EMPFAT'], [fatVendaFF.strNumDoc, fatVendaFF.strEspDoc, fatVendaFF.strEmpDoc], False);
  objFTFFNF.EspPed    := fCampoTabela('FGO_ESPDOC', 'FATGOR', ['FGO_NUMFAT', 'FGO_TIPFAT', 'FGO_EMPFAT'], [fatVendaFF.strNumDoc, fatVendaFF.strEspDoc, fatVendaFF.strEmpDoc], False);
  objFTFFNF.CodEmp    := fCampoTabela('FGO_CODEMP', 'FATGOR', ['FGO_NUMFAT', 'FGO_TIPFAT', 'FGO_EMPFAT'], [fatVendaFF.strNumDoc, fatVendaFF.strEspDoc, fatVendaFF.strEmpDoc], False);
  objFTFFNF.TotProPed := fCampoTabela('FGO_TOTPRO', 'FATGOR', ['FGO_NUMFAT', 'FGO_TIPFAT', 'FGO_EMPFAT'], [fatVendaFF.strNumDoc, fatVendaFF.strEspDoc, fatVendaFF.strEmpDoc], False);
  objFTFFNF.VlrConPed := fCampoTabela('FGO_VLRCON', 'FATGOR', ['FGO_NUMFAT', 'FGO_TIPFAT', 'FGO_EMPFAT'], [fatVendaFF.strNumDoc, fatVendaFF.strEspDoc, fatVendaFF.strEmpDoc], False);

  objFTFFNF.TotProFat := fatVendaFF.fltTotPro;
  objFTFFNF.DesEspFat := fatVendaFF.fltDesEsp;

  objFTFFNF.Num_FF   := fatVendaFF.strNumDoc;
  objFTFFNF.Esp_FF   := fatVendaFF.strEspDoc;
  objFTFFNF.Emp_FF   := fatVendaFF.strEmpDoc;
  objFTFFNF.TotProFF := fatVendaFF.fltTotPro;
  objFTFFNF.DesEspFF := fatVendaFF.fltDesEsp;
  objFTFFNF.TotIpiFF := fatVendaFF.fltTotIpi;
  objFTFFNF.TotRetFF := fatVendaFF.fltTotRet;
  objFTFFNF.TotCbsFF := fatVendaFF.fltTotCBS;
  objFTFFNF.TotIbsFF := fatVendaFF.fltTotIBS;
  objFTFFNF.Tot_IsFF := fatVendaFF.fltTotIS;
  objFTFFNF.Fcp_STFF := fatVendaFF.fltTotFcpST;
  objFTFFNF.TotFreFF := fatVendaFF.fltValFre;
  objFTFFNF.DesAceFF := fatVendaFF.fltDesAce;
  objFTFFNF.VlrConFF := fatVendaFF.fltTotGer;

  objFTFFNF.Num_NF   := fatVendaNF.strNumDoc;
  objFTFFNF.Esp_NF   := fatVendaNF.strEspDoc;
  objFTFFNF.Emp_NF   := fatVendaNF.strEmpDoc;
  objFTFFNF.TotProNF := fatVendaNF.fltTotPro;
  objFTFFNF.DesEspNF := fatVendaNF.fltDesEsp;
  objFTFFNF.TotIpiNF := fatVendaNF.fltTotIpi;
  objFTFFNF.TotRetNF := fatVendaNF.fltTotRet;
  objFTFFNF.TotCbsNF := fatVendaNF.fltTotCBS;
  objFTFFNF.TotIbsNF := fatVendaNF.fltTotIBS;
  objFTFFNF.Tot_IsNF := fatVendaNF.fltTotIS;
  objFTFFNF.Fcp_STNF := fatVendaNF.fltTotFcpST;
  objFTFFNF.TotFreNF := fatVendaNF.fltValFre;
  objFTFFNF.DesAceNF := fatVendaNF.fltDesAce;
  objFTFFNF.VlrConNF := fatVendaNF.fltTotGer;

  objFTFFNF.FatNot := FFatEmi;

  Result := objFTFFNF.fGrava;
end;

function TEmissaoNotaEspecial.fGravaRelacaoEntradaComNotaEspecial(strAutIncVen, strAutIncEnt: String): Boolean;
var
  qryInsert: TUniQuery;
begin
  If fEmptyStr(strAutIncEnt) Then
    Exit(True);
  Try
    qryInsert := fCriaQuery;
    Try
      qryInsert.SQL.Add('INSERT INTO ENTDES (ENT_SEQENT, ENT_SEQNES) VALUES (:SEQENT, :SEQNES)');
      qryInsert.ParamByName('SEQENT').AsString := strAutIncEnt;
      qryInsert.ParamByName('SEQNES').AsString := strAutIncVen;
      qryInsert.ExecSQL;
      Result := True;
    Finally
      FreeAndNil(qryInsert)
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TEmissaoNotaEspecial.fGravaRelacaoEntradaComNotaEspecial');
      Result := False;
    End;
  End
end;

class function TEmissaoNotaEspecial.fPermiteEmissaoAbaixoDoCusto(
  const strOpcDoc: String): Boolean;
begin
  Result := False;

  If (strOpcDoc = 'CO') Then
    Result := True;
end;

function TEmissaoNotaEspecial.fRetornaPedidosDeVenda(
  fatVendaPV: TFatVenda): String;
var
  intContador: integer;
  strChave: string;
begin
  Result := EmptyStr;
  for intContador := Low(fatVendaPV.arrMatItens) to High(fatVendaPV.arrMatItens) do
  begin
    strChave := fatVendaPV.arrMatItens[intContador].strNumOrc + '-' + fatVendaPV.arrMatItens[intContador].strEspOrc + '-' + fatVendaPV.arrMatItens[intContador].strEmpOrc;
    pIncrementaListaStr(strChave, Result, False, False, ';', False);
  end;
end;

function TEmissaoNotaEspecial.fRetornaPedidosParaImpressao(fatVendaNF: TFatVenda): TArrDadosImpressoesVenda;
var
  qryFatGor: TUniQuery;
  intIndice: integer;
  strPedidos: string;
begin
  SetLength(Result, 0);
  qryFatGor := fCriaQuery;
  strPedidos := EmptyStr;

  try
    qryFatGor.Close;
    qryFatGor.SQL.Clear;
    qryFatGor.SQL.Add('SELECT FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP, FGO_CODCLI, FGO_VLRCON, FGO_ENT_CD');
    qryFatGor.SQL.Add('FROM FATGOR');
    qryFatGor.SQL.Add('WHERE FGO_NUMDOC = :NUMDOC');
    qryFatGor.SQL.Add('AND FGO_ESPDOC = :ESPDOC');
    qryFatGor.SQL.Add('AND FGO_CODEMP = :CODEMP');

    for intIndice := Low(fatVendaNF.arrMatItens) to High(fatVendaNF.arrMatItens) do
    begin
      if Pos(fatVendaNF.arrMatItens[intIndice].strNumOrc +
             fatVendaNF.arrMatItens[intIndice].strEspOrc +
             fatVendaNF.arrMatItens[intIndice].strEmpOrc, strPedidos) <= 0 then
      begin
        strPedidos := strPedidos +
                      fatVendaNF.arrMatItens[intIndice].strNumOrc +
                      fatVendaNF.arrMatItens[intIndice].strEspOrc +
                      fatVendaNF.arrMatItens[intIndice].strEmpOrc + '_';

        qryFatGor.Close;
        qryFatGor.ParamByName('NUMDOC').AsString := fatVendaNF.arrMatItens[intIndice].strNumOrc;
        qryFatGor.ParamByName('ESPDOC').AsString := fatVendaNF.arrMatItens[intIndice].strEspOrc;
        qryFatGor.ParamByName('CODEMP').AsString := fatVendaNF.arrMatItens[intIndice].strEmpOrc;
        qryFatGor.Open;

        if qryFatGor.IsEmpty then
          Continue;

        SetLength(Result, Length(Result) + 1);
        FillChar(Result[Length(Result)-1], SizeOf(Result[Length(Result)-1]), #0);
        Result[Length(Result)-1].strCodCli := qryFatGor.FieldByName('FGO_CODCLI').AsString;
        Result[Length(Result)-1].strNumDoc := qryFatGor.FieldByName('FGO_NUMDOC').AsString;
        Result[Length(Result)-1].strEspDoc := qryFatGor.FieldByName('FGO_ESPDOC').AsString;
        Result[Length(Result)-1].strEmpDoc := qryFatGor.FieldByName('FGO_CODEMP').AsString;
        Result[Length(Result)-1].strOpcDoc := qryFatGor.FieldByName('FGO_ESPDOC').AsString;
        Result[Length(Result)-1].blnEnt_CD := (qryFatGor.FieldByName('FGO_ENT_CD').AsString = 'S');
        Result[Length(Result)-1].fltTotGer := qryFatGor.FieldByName('FGO_VLRCON').AsFloat;
        Result[Length(Result)-1].blnImprimeSep := False;

        Result[Length(Result)-1].arrMatItens := fCarregaMatrizDeItens(qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                                                      qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                                                      qryFatGor.FieldByName('FGO_CODEMP').AsString,
                                                                      qryFatGor.FieldByName('FGO_CODCLI').AsString);
      end;
    end;
  finally
    FreeAndNil(qryFatGor);
  end;
end;

procedure TEmissaoNotaEspecial.pValidarDocumento;
  const
    ESPECIES_PERMITIDAS = 'MI_FF_';
begin
  If Pos(FEspOri, ESPECIES_PERMITIDAS) <= 0 Then
    pRaise('Espécie de documento não permitida (' + FEspOri + ')');

  If Not fVerificaVendaExiste(FDocOri, FEspOri, FEmpOri, FCliOri, FVenOri, FRepOri, FOriDoc, FDtaEmi) Then
    pRaise('Documento de venda original não encontrado (' + FDocOri + '-' + FEspOri + ')');
end;

procedure TEmissaoNotaEspecial.pCarregaDadosPagamentoCliente;
  Var
    qryConCnd: TUniQuery;
begin
  qryConCnd := fCriaQuery(fatVenda);
  Try
    pPesquisaCadCnd(qryConCnd, qryConCnd, fatVenda.strCodCnd);
    If not qryConCnd.IsEmpty Then
      fatVenda.strCodFpg := qryConCnd.FieldByName('CND_CODFPG').AsString;
  Finally
    FreeAndNil(qryConCnd);
  End;
end;

procedure TEmissaoNotaEspecial.pCarregaDocumentoNotaFator;
  Var
    strSQL: String;
    strPreIte,
    strTePrev: String;
    qryGenGer: TUniQuery;
    strTabela: String;
    strMovMad: String;
    strTabela2:String;
    blnAvisarOperadorVendaComPrecoCusto : Boolean;
begin
  qryGenGer := fCriaQuery(fatVenda);

  fatVenda.fltFatNot    := FFatEmi;
  fatVenda.strTipFatNEs := FTipFat;
  fatVenda.blnMeiaNota  := True;

  {*******************************************}
  {* CARREGA DADOS DO CABECALHO              *}
  {****************************************MV*}
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CADCLI.*,   ';
  strSQL := strSQL + '   GER_NUMDOC, ';
  strSQL := strSQL + '   GER_ESPDOC, ';
  strSQL := strSQL + '   GER_CODEMP, ';
  If blnNS_DepostitoFechado Then
  Begin
    strSQL := strSQL + '   CLI_CODCLI AS GER_CODCLI, ';
    strSQL := strSQL + '   CND_CODCND, ';
    strSQL := strSQL + '   CND_CNDPAG, ';
  End
  Else
    strSQL := strSQL + '   GER_CODCLI, ';
  strSQL := strSQL + '   GER_CONPAG, ';
  strSQL := strSQL + '   GER_CONSUM, ';
  If fEmptyStr(FstrEmpDes) Then
    strSQL := strSQL + '   GER_TABPRE, '
  Else
    strSQL := strSQL + '  ' + IntToStr(fRetPrimeiraTabPrecoAtiva) + ' AS  GER_TABPRE, ';
  strSQL := strSQL + '   IF( GER_NOMCON IS NULL, CLI_NOMCLI, GER_NOMCON) AS GER_NOMCLI, ';
  strSQL := strSQL + '   IF( GER_ENDCON IS NULL, CLI_ENDERE, GER_ENDCON) AS GER_ENDCLI, ';
  strSQL := strSQL + '   IF( GER_ENDCON IS NULL, CLI_ENDNUM, "") AS GER_ENDNUM, ';
  strSQL := strSQL + '   IF( GER_BAICON IS NULL, CLI_BAIRRO, GER_BAICON) AS GER_BAICLI, ';
  strSQL := strSQL + '   IF( GER_CEPCON IS NULL, CLI_C_E_P_, GER_CEPCON) AS GER_CEPCLI, ';
  strSQL := strSQL + '   IF( GER_CIDCON IS NULL, CLI_CODCID, GER_CIDCON) AS GER_CIDCLI, ';
  strSQL := strSQL + '   CID_NOMCID AS GER_NOMCID, ';
  strSQL := strSQL + '   IF( GER_ESTCON IS NULL, CID_ESTADO, GER_ESTCON) AS GER_ESTCLI, ';
  strSQL := strSQL + '   IF( GER_TELCON IS NULL, CLI_FONE01, GER_TELCON) AS GER_TELCLI, ';
  strSQL := strSQL + '   IF( AUX_NASCON IS NULL, CLI_NASCIM, AUX_NASCON) AS AUX_NASCON, ';
  strSQL := strSQL + '   IF( GER_CGCCPF IS NULL, CLI_CGCCPF, GER_CGCCPF) AS GER_CGCCPF, ';
  strSQL := strSQL + '   IF( GER_CGCCON IS NULL, CLI_C_G_C_, GER_CGCCON) AS GER_CGCCLI, ';
  strSQL := strSQL + '   IF( GER_IESCON IS NULL, CLI_I_E_S_, GER_IESCON) AS GER_IESCLI, ';
  strSQL := strSQL + '   IF( GER_R_GCON IS NULL, CLI_NUMR_G, GER_R_GCON) AS GER_R_GCLI, ';
  strSQL := strSQL + '   GER_CODFPG, ';
  strSQL := strSQL + '   GER_CODCND, ';
  strSQL := strSQL + '   GER_CODVEN, ';
  strSQL := strSQL + '   GER_CODDIG, ';
  strSQL := strSQL + '   GER_MEN001, ';
  strSQL := strSQL + '   GER_MEN002, ';
  strSQL := strSQL + '   GER_MEN003, ';
  strSQL := strSQL + '   GER_MEN004, ';
  strSQL := strSQL + '   GER_MEN005, ';
  strSQL := strSQL + '   GER_TIPFRE, ';
  strSQL := strSQL + '   GER_TOTFRE, ';
  strSQL := strSQL + '   GER_DESACE, ';
  strSQL := strSQL + '   GER_DTAENT, ';
  strSQL := strSQL + '   GER_CODTRA, ';
  strSQL := strSQL + '   GER_VOLUME, ';
  strSQL := strSQL + '   GER_ESPECI, ';
  strSQL := strSQL + '   GER_DESESP, ';
  strSQL := strSQL + '   AUX_ENTGER  ';
  strSQL := strSQL + '  FROM MOVGER  ';
  If blnNS_DepostitoFechado Then
  Begin
    strSQL := strSQL + '  JOIN CADCLI ON CLI_CODCLI = "' + fRetornaClienteFilial(FstrEmpDes) + '"';
    strSQL := strSQL + '  LEFT JOIN CLICND ON CLI_CODCLI = CND_CODCLI  AND CND_SUGEST = "S" AND CND_CODCND IS NOT NULL ';
  End
  Else
    strSQL := strSQL + '  JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ';
  strSQL := strSQL + '  JOIN CADCID ON IF(GER_CIDCON IS NULL, CLI_CODCID, GER_CIDCON) = CID_CODCID ';
  strSQL := strSQL + '  LEFT JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM ';
  strSQL := strSQL + ' WHERE GER_NUMDOC = :NUMDOC ';
  strSQL := strSQL + '   AND GER_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '   AND GER_CODEMP = :CODEMP ';

  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(strSQL,'MOVGER','NOTGER'), 'AUXMOV', 'AUXNOT') + ' LIMIT 1 ';

  With qryGenGer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := FDocOri;
    ParamByName('ESPDOC').AsString := FEspOri;
    ParamByName('CODEMP').AsString := FEmpOri;
    Open;
  End;

  fatVenda.strCodCli := qryGenGer.FieldByName('GER_CODCLI').AsString;
  fatVenda.strCodFpg := qryGenGer.FieldByName('GER_CODFPG').AsString;

  If (fCfgSis('CNDESP', varInteger) = 1) Then
  Begin
    fatVenda.strCodCnd := fCfgSis('CNDAVI', varString);
    fatVenda.strConPag := '01000';
  End
  Else
  Begin
    fatVenda.strCodCnd := qryGenGer.FieldByName('GER_CODCND').AsString;
    fatVenda.strConPag := qryGenGer.FieldByName('GER_CONPAG').AsString;
  End;

  If blnNS_DepostitoFechado Then
  Begin
    fatVenda.strCodCnd := qryGenGer.FieldByName('CND_CODCND').AsString;
    fatVenda.strConPag := qryGenGer.FieldByName('CND_CNDPAG').AsString;
    pCarregaDadosPagamentoCliente;
  End;

  pCarregaCondicao;

  If blnNS_DepostitoFechado Then
  Begin
    fatVenda.strMen001 := 'Transf. Auto. Depósito Fechado. Doc. Origem:' + FDocOri + '-' + FEspOri + '-' + FEmpOri;
    fatVenda.strTipFre := '9'; //Sem Frete
    fatVenda.fltValFre := 0;
    fatVenda.strCodTra := '';
    fatVenda.strNumDocAbastecimento := FDocOri;
    fatVenda.strEspDocAbastecimento := FEspOri;
    fatVenda.strCodEmpAbastecimento := FEmpOri;
  End
  Else
  Begin
    If (Not fEmptyStr(qryGenGer.FieldByName('AUX_ENTGER').AsString)) Then
    Begin
      fatVenda.objEndEnt.pRetEnderecoEntrega(qryGenGer.FieldByName('AUX_ENTGER').AsString, qryGenGer.FieldByName('GER_CODCLI').AsString);
      fatVenda.pEnderecoToFatVenda;
    End;

    fatVenda.strMen001 := qryGenGer.FieldByName('GER_MEN001').AsString;
    fatVenda.strMen002 := qryGenGer.FieldByName('GER_MEN002').AsString;
    fatVenda.strMen003 := qryGenGer.FieldByName('GER_MEN003').AsString;
    fatVenda.strMen004 := qryGenGer.FieldByName('GER_MEN004').AsString;
    fatVenda.strMen005 := qryGenGer.FieldByName('GER_MEN005').AsString;

    fatVenda.strTipFre := qryGenGer.FieldByName('GER_TIPFRE').AsString;
    fatVenda.fltValFre := qryGenGer.FieldByName('GER_TOTFRE').AsFloat;
    fatVenda.strCodTra := qryGenGer.FieldByName('GER_CODTRA').AsString;

    If fatVenda.blnEmitindoNFDaNotaEspecialFatorPorValor Then
      fatVenda.fltDesAce := qryGenGer.FieldByName('GER_DESACE').AsFloat;
  End;

  fatVenda.intQtdTra := qryGenGer.FieldByName('GER_VOLUME').AsInteger;
  fatVenda.strEspTra := qryGenGer.FieldByName('GER_ESPECI').AsString;

  If fEmptyStr(fatVenda.strCodTra) Then
    fatVenda.strCodTra := fCfgSis('TRASUG');

  If fEmptyStr(fatVenda.strTipFre) Then
    fatVenda.strTipFre := '1';

  fatVenda.strTabPre := qryGenGer.FieldByName('GER_TABPRE').AsString;

  fatVenda.strCodDig := qryGenGer.FieldByName('GER_CODDIG').AsString;
  fatVenda.strCodVen := qryGenGer.FieldByName('GER_CODVEN').AsString;
  pCarregaVendedor;

  fatVenda.strCliNom := qryGenGer.FieldByName('GER_NOMCLI').AsString;
  fatVenda.strCliOri := qryGenGer.FieldByName('GER_NOMCLI').AsString;
  fatVenda.strCliEnd := qryGenGer.FieldByName('GER_ENDCLI').AsString;
  fatVenda.strCliNum := qryGenGer.FieldByName('GER_ENDNUM').AsString;
  fatVenda.strCliBai := qryGenGer.FieldByName('GER_BAICLI').AsString;
  fatVenda.strCliCep := qryGenGer.FieldByName('GER_CEPCLI').AsString;
  fatVenda.strCodCid := qryGenGer.FieldByName('GER_CIDCLI').AsString;
  fatVenda.strCliCid := qryGenGer.FieldByName('GER_NOMCID').AsString;
  fatVenda.strCliEst := qryGenGer.FieldByName('GER_ESTCLI').AsString;
  fatVenda.strCliTel := qryGenGer.FieldByName('GER_TELCLI').AsString;
  fatVenda.dtaNasCon := qryGenGer.FieldByName('AUX_NASCON').AsDateTime;
  fatVenda.strCliCgc := qryGenGer.FieldByName('GER_CGCCLI').AsString;
  fatVenda.intCgcCpf := qryGenGer.FieldByName('GER_CGCCPF').AsInteger;
  fatVenda.strCliIes := qryGenGer.FieldByName('GER_IESCLI').AsString;
  fatVenda.strCli_Rg := qryGenGer.FieldByName('GER_R_GCLI').AsString;

  fatVenda.strCliEma := qryGenGer.FieldByName('CLI_EMAIL3').AsString;                   //         - Email NFe
  fatVenda.strCliEm2 := qryGenGer.FieldByName('CLI_EMAIL2').AsString;                   //         - Email 2
  fatVenda.strCluFid := qryGenGer.FieldByName('CLI_CLUFID').AsString;                   //         - Clube Fidelidade
  fatVenda.strCliFid := qryGenGer.FieldByName('CLI_CLIFID').AsString;                   //         - Cliente Fidelidade

  fatVenda.strCliAti := qryGenGer.FieldByName('CLI_CODATI').AsString;                   //         - Atividade
  fatVenda.blnConstr := fAtividadeConstrutora(qryGenGer.FieldByName('CLI_CODATI').AsString); // Cliente construtora ????
  fatVenda.strObserv := qryGenGer.FieldByName('CLI_OBSERV').AsString;                   //         - Observações
  fatVenda.strCliDAc := qryGenGer.FieldByName('CLI_CODEAC').AsString;                   //         - Cobrar despesas acessórias do cliente

  {***************************}
  {* DADOS DE COBRANÇA       *}
  {***********************MV**}
  fatVenda.strEndCob := qryGenGer.FieldByName('CLI_ENDCOB').AsString;
  fatVenda.strBaiCob := qryGenGer.FieldByName('CLI_BAICOB').AsString;
  fatVenda.strCepCob := qryGenGer.FieldByName('CLI_CEPCOB').AsString;
  fatVenda.strCidCob := fRetNomCidade(qryGenGer.FieldByName('CLI_CIDCOB').AsString);
  fatVenda.strEstCob := fRetNomCidade(qryGenGer.FieldByName('CLI_CIDCOB').AsString, 1);

  fatVenda.strDiferi := qryGenGer.FieldByName('CLI_DIFERI').AsString;
  fatVenda.fltRedIcmsCli := qryGenGer.FieldByName('CLI_REDICM').AsFloat;

  fatVenda.pProcessarDespesasOperacionaisComplementar(qryGenGer.FieldByName('CLI_DESOPE').AsFloat);

  fatVenda.fltDescProfissional := fRetDescontoCliente(fatVenda.strCodCli);
  fatVenda.fltDescFidelidade   := fRetDescontoFidelidade(fatVenda.strCodCli);

  fatVenda.strCliImp := qryGenGer.FieldByName('CLI_I_M_P_').AsString;                   //         - Insc. Municipal Produtor
  fatVenda.strProRur := qryGenGer.FieldByName('CLI_PRORUR').AsString;                   //         - Produtor Rural
  fatVenda.strMicEmp := qryGenGer.FieldByName('CLI_MICEMP').AsString;                   //         - MEI-Micro Empreendedor Individual
  fatVenda.strCliOrg := qryGenGer.FieldByName('CLI_ORGPUB').AsString;                   //         - Orgao Publico
  fatVenda.strDesPis := qryGenGer.FieldByName('CLI_DESPIS').AsString;                   //         - Orgao Publico
  fatVenda.strZonFra := qryGenGer.FieldByName('CLI_ZONFRA').AsString;                   //         - Zona Franca de Manaus
  fatVenda.strCodZfm := qryGenGer.FieldByName('CLI_SUFRAM').AsString;                   //         - Código Sufram
  fatVenda.blnCliExportacaoIndireta := qryGenGer.FieldByName('CLI_EXPIND').AsString = 'S';  //     - Cliente Exportação Indireta
  fatVenda.strCodReg := qryGenGer.FieldByName('CLI_CODREG').AsString;                   //         - Código da Região
  fatVenda.strDesReg := fRetDesRegiao(qryGenGer.FieldByName('CLI_CODREG').AsString);    //         - Descrição da Região
  fatVenda.strCliCon := qryGenGer.FieldByName('GER_CONSUM').AsString;                   //         - Consumidor Final (S/N)

  fatVenda.strCodRep := qryGenGer.FieldByName('CLI_CODREP').AsString;                   //         - Código do Representante
  fatVenda.strNomRep := fRetNomVendRep(qryGenGer.FieldByName('CLI_CODREP').AsString);   //         - Nome do Representante

  if (fCfgSis('SIMPAU', varBoolean) and fCfgSis('RETIMP', varBoolean)) then
  begin
    fatVenda.strRetPCo := 'N';                                                              //         - Retenção de Pis e Cofins
    fatVenda.strRetIrf := 'N';                                                              //         - Retenção de IRPF
    fatVenda.strCDesPI := 'N';                                                              //         - Retenção de Pis e Cofins
  end
  else
  begin
    fatVenda.strRetPCo := qryGenGer.FieldByName('CLI_RETPCO').AsString;                   //         - Retenção de Pis e Cofins
    fatVenda.strRetIrf := qryGenGer.FieldByName('CLI_RETIRF').AsString;                   //         - Retenção de IRPF
    fatVenda.strCDesPI := qryGenGer.FieldByName('CLI_CDESPI').AsString;                   //         - Retenção de Pis e Cofins
  end;

  fatVenda.strSitIPI := qryGenGer.FieldByName('CLI_SITIPI').AsString;                   //         - Isento de IPI
  fatVenda.strEnqIPI := qryGenGer.FieldByName('CLI_ENQIPI').AsString;                   //         - Enquadramento do IPI
  fatVenda.strMenIPI := qryGenGer.FieldByName('CLI_MENIPI').AsString;                   //         - Mensagem do IPI
  fatVenda.strRetIss := qryGenGer.FieldByName('CLI_RETISS').AsString;                   //         - Retenção de ISS
  fatVenda.strOrPuRD := qryGenGer.FieldByName('CLI_ORPURD').AsString;                   //         - Tipo de Desconto (Rateio / Desconto)
  fatVenda.strCalIcm := qryGenGer.FieldByName('CLI_CALICM').AsString;                   //         - Calcula Desconto de ICMS (Orgão Public)
  fatVenda.strSegSoc := qryGenGer.FieldByName('CLI_SEGSOC').AsString;                   //         - Seguridade Social

  fatVenda.strPerEmp := qryGenGer.FieldByName('CLI_PEREMP').AsString;                   //         - Permite Emprestimo

  fatVenda.pCarregaAliquotasRetencao;

  {*****************************************}
  {* SETA A VARIAVEL CLIENTE FILIAL        *}
  {**************************************MV*}
  fatVenda.blnCliFil := fatVenda.fClienteFilialVenda(qryGenGer.FieldByName('CLI_CODCLI').AsString);
  fatVenda.fltFat_TE := fatVenda.recDadCli.fltFat_TE;
  fatVenda.strTEPREV := fatVenda.recDadCli.strTEPREV;

  If (fatVenda.blnCliFil) Then
  Begin
    fatVenda.pAtualizaClassTransferencias;
  End;

  strTePrev := fGetTEPREV(VS_strCodEmp, qryGenGer.FieldByName('CLI_CODCLI').AsString, blnNS_DepostitoFechado);
  If SameText(strTePrev, 'IMP') Then
    strPreIte := 'ITE_IMPULT'
  Else If SameText(strTePrev , 'SIC') Then
    strPreIte := 'ITE_MEDSIC'
  Else
    strPreIte := 'ITE_PRE' + strTePrev;

  strTabela := 'MOVDET';
  strMovMad := 'MOVMAD';
  strTabela2:= 'MOVTRI';

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  DET_CODITE, ';
  strSQL := strSQL + '  DET_CODEMP, ';
  strSQL := strSQL + '  DET_ESTADO, ';
  If Not fEmptyStr(FstrEmpDes) Then
  begin
    strSQL := strSQL + ' ' +   strPreIte + ' AS DET_UNITAR, ';
    strSQL := strSQL + ' ' +   strPreIte + ' * DET_QTDITE AS DET_TOTCUS, ';
    strSQL := strSQL + ' ' +   strPreIte + ' * DET_QTDITE AS DET_TOTCU2, ';
    strSQL := strSQL + ' 0 DET_DESESP, ';
  End
  Else
  Begin
    strSQL := strSQL + '  DET_UNITAR, ';
    strSQL := strSQL + '  DET_TOTCUS, ';
    strSQL := strSQL + '  DET_TOTCU2, ';
    strSQL := strSQL + '  DET_DESESP, ';
  End;

  strSQL := strSQL + '  DET_TOTULT, ';
  strSQL := strSQL + '  DET_IMPULT, ';
  strSQL := strSQL + '  DET_TOTMED, ';
  strSQL := strSQL + '  DET_TOTCUS - (IFNULL(ITE_VALFRE, 0) * DET_QTDITE) AS DET_CUSFRE, ';

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
  If fEmptyStr(FstrEmpDes) Then
    strSQL := strSQL + '  DET_TABPRE, '
  Else
    strSQL := strSQL + '  ' + IntToStr(fRetPrimeiraTabPrecoAtiva) + ' AS  DET_TABPRE, ';

  strSQL := strSQL + '  DET_INCPIS, ';
  strSQL := strSQL + '  DET_IDEPRO, ';
  strSQL := strSQL + '  DET_DESCRI, ';
  strSQL := strSQL + '  DET_UNIDAD, ';
  strSQL := strSQL + '  DET_CODMAR, ';
  strSQL := strSQL + '  DET_FORITE, ';
  strSQL := strSQL + '  DET_REFERE, ';
  strSQL := strSQL + '  DET_DESCON, ';
  strSQL := strSQL + '  DET_TOTPES, ';
  strSQL := strSQL + '  DET_NUMLOT, ';
  strSQL := strSQL + '  DET_CODDIV, ';
  strSQL := strSQL + '  DET_CODVE2, ';
  strSQL := strSQL + '  DET_ENTFUT, ';
  strSQL := strSQL + '  DET_MOTFUT, ';
  strSQL := strSQL + '  DET_DTAFUT, ';
  strSQL := strSQL + '  ITE_CODGRU, ';
  strSQL := strSQL + '  UNI_ITEFRA, ';
  strSQL := strSQL + '  DET_CODACA, ';
  strSQL := strSQL + '  DET_EMPACA, ';
  strSQL := strSQL + '  DET_PROACA, ';
  strSQL := strSQL + '  DET_NUM_PD, ';
  strSQL := strSQL + '  DET_ESP_PD, ';
  strSQL := strSQL + '  DET_EMP_PD  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ' + strTabela + ' D ';
  strSQL := strSQL + 'JOIN CADITE ON ITE_CODITE = DET_CODITE ';
  strSQL := strSQL + 'LEFT JOIN CADUNI ON UNI_CODUNI = DET_UNIDAD ';
  strSQL := strSQL + ' INNER JOIN ITEGER G ON G.ITE_CODITE = DET_CODITE AND G.ITE_CODEMP = DET_CODEMP ';

  strSQL := strSQL + 'LEFT JOIN ' + strTabela2 + ' T ON T.DET_SEQGER = D.AUTOINCREM ';

  If fCfgSis('VENMAD', varBoolean) Or fCfgSis('VENVID', varBoolean) Or fCfgSis('VENMTL', varBoolean) Then
    strSQL := strSQL + ' LEFT JOIN ' + strMovMad + ' M ON M.DET_SEQGER = D.AUTOINCREM  ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  DET_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  DET_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  DET_CODEMP = :CODEMP AND ';
  If blnNS_DepostitoFechado Then
  begin
    strSQL := strSQL + '  DET_CODFOR = :CODFOR  ';
  End
  Else
  Begin
    strSQL := strSQL + '  DET_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  DET_ORIDOC = "V"         ';
  End;

  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL,'MOVDET','NOTDET'),'MOVMAD','NOTMAD'),'MOVTRI', 'NOTTRI');

  {*******************************************}
  {* CARREGA ITENS DO DOCUMENTO              *}
  {****************************************MV*}
  With qryGenGer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := FDocOri;
    ParamByName('ESPDOC').AsString := FEspOri;
    ParamByName('CODEMP').AsString := FEmpOri;
    If blnNS_DepostitoFechado Then
      ParamByName('CODFOR').AsString := FstrCodForEnt
    Else
      ParamByName('CODCLI').AsString := FCliOri;
    Open;
  End;

  pCarregaItensNotaEspecial(fatVenda, qryGenGer, blnAvisarOperadorVendaComPrecoCusto, FstrEmpDes);

  FreeAndNil(qryGenGer);
end;

class procedure TEmissaoNotaEspecial.pCarregaItensNotaEspecial(fatVenda : TFatVenda;
                                                               qryItens : TUniQuery;
                                                               var blnAvisarOperadorVendaComPrecoCusto : Boolean;
                                                               strEmpDes: String='');
  Var
    qryGenIte: TUniQuery;
    strSQL   : String;
    strCmpRefNotEsp: String;
    fltUnitar: Double;
    fltUniDig: Double;
    fltValUniNotEsp: Double;
    fltCusIte: Double;
    fltPreCus: Double;
    fltPreCu2: Double;
    fltQtdIte: Double;
    recMadeira: TDadosMadeira;
    fltFatorPreco: Double;
    fltFatorQtde : Double;
    btnAdicionar: TBitBtnLocked;
    recForTin: TForTin;
    impSubIteEst: TImpostosSubItensEstrutura;
    fltOutValIte,
    fltDesOpeIte,
    fltIcmSaiIte,
    fltImpFedIte,
    fltPreVe1Ite,
    fltPreVe2Ite,
    fltPreVe3Ite,
    fltPreVe4Ite,
    fltPreVe5Ite,
    fltPreVe6Ite,
    fltPreVe7Ite: Double;
    strPromoc: String;
    strNum_PD : String;
    strEsp_PD : String;
    strEmp_PD : String;
    fltCUSFRE: Double;
    fltICMSSai: Double;
    fltImpFed: Double;
    fltDesOpe: Double;


    function fRetFatorCustoNotaEspecial: Double;
    begin
      Result := 1;

      If fEmptyStr(strEmpDes) Then
        If (Not fPermiteEmissaoAbaixoDoCusto(fatVenda.strOpcDoc)) Then
          If (fCfgSis('FTCUNE', varDouble) <> 0) Then
            Result := fCfgSis('FTCUNE', varDouble);
    end;

begin
  fltFatorPreco := 1;
  fltFatorQtde  := 1;
  blnAvisarOperadorVendaComPrecoCusto := False;

  btnAdicionar := TBitBtnLocked.Create(fatVenda);

  qryGenIte := fCriaQuery(fatVenda);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  I.ITE_DESITE, ';
  strSQL := strSQL + '  I.ITE_DESSIM, ';
  strSQL := strSQL + '  I.ITE_DESFAB, ';
  strSQL := strSQL + '  I.ITE_COMLUB, ';
  strSQL := strSQL + '  I.ITE_CODFAB, ';
  strSQL := strSQL + '  I.ITE_CODBAR, ';
  strSQL := strSQL + '  I.ITE_OBRCPF, ';
  strSQL := strSQL + '  I.ITE_NOTESP, ';
  strSQL := strSQL + '  I.ITE_CLAIPI, ';
  strSQL := strSQL + '  I.ITE_EXCIPI, ';
  strSQL := strSQL + '  G.ITE_OUTVAL, ';
  strSQL := strSQL + '  G.ITE_IMPFED, ';
  strSQL := strSQL + '  G.ITE_ICMSAI, ';
  strSQL := strSQL + '  G.ITE_DESOPE, ';
  strSQL := strSQL + '  G.ITE_PRECOM, ';
  strSQL := strSQL + '  G.ITE_PREULT, ';
  strSQL := strSQL + '  G.ITE_IMPULT, ';
  strSQL := strSQL + '  G.ITE_PRECUS, ';

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
  strSQL := strSQL + '  G.ITE_SALDOS, ';
  strSQL := strSQL + '  G.ITE_COMVAR, ';
  strSQL := strSQL + '  G.ITE_COMATA, ';
  strSQL := strSQL + '  G.ITE_COMDIS, ';
  strSQL := strSQL + '  G.ITE_MARMIN, ';
  strSQL := strSQL + '  G.ITE_MARMSG, ';
  strSQL := strSQL + '  G.ITE_MARMGE, ';
  strSQL := strSQL + '  G.ITE_DESMGE, ';
  strSQL := strSQL + '  G.ITE_DESMSU, ';

  strSQL := strSQL + '  G.ITE_DESMVM, ';
  strSQL := strSQL + '  G.ITE_DESMSM, ';
  strSQL := strSQL + '  G.ITE_DESMGM, ';

  strSQL := strSQL + '  G.ITE_MARMMV, ';
  strSQL := strSQL + '  G.ITE_MARMMS, ';
  strSQL := strSQL + '  G.ITE_MARMMG, ';

  strSQL := strSQL + '  G.ITE_IPIENT, ';
  strSQL := strSQL + '  G.ITE_FREENT, ';
  strSQL := strSQL + '  G.ITE_QTPPRO, ';
  strSQL := strSQL + '  G.ITE_LOCFIS, ';
  strSQL := strSQL + '  A.ABF_CODABF, ';
  strSQL := strSQL + '  I.ITE_PESLIQ, ';
  strSQL := strSQL + '  I.ITE_EMBALA, ';
  strSQL := strSQL + '  M.MAR_DESMAR, ';

  If fCfgSis('IMPDIG') = '1' Then
    strSQL := strSQL + '  I.ITE_IMPDIR  '
  Else
    strSQL := strSQL + '  G.ITE_IMPDIR  ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I, ';
  strSQL := strSQL + '  ITEGER G, ';
  strSQL := strSQL + '  ABFICM A, ';
  strSQL := strSQL + '  CADMAR M ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  I.ITE_CODMAR = M.MAR_CODMAR AND ';
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

  With qryItens Do
  Begin
    First;

    While (Not Eof) Do
    Begin

      If (fatVenda.strTipFatNEs = 'V') Then
        fltFatorPreco := fatVenda.fltFatNot
      Else
        fltFatorQtde  := fatVenda.fltFatNot;

      qryGenIte.Close;
      qryGenIte.ParamByName('CODITE').AsString := FieldByName('DET_CODITE').AsString;
      qryGenIte.ParamByName('CODEMP').AsString := FieldByName('DET_CODEMP').AsString;
      qryGenIte.ParamByName('ESTADO').AsString := FieldByName('DET_ESTADO').AsString;;
      qryGenIte.Open;

      fltQtdIte := FieldByName('DET_QTDITE').AsFloat;

      strNum_PD := '';
      strEsp_PD := '';
      strEmp_PD := '';

      If (FindField('DET_NUM_PD') <> Nil) Then
      Begin
        strNum_PD := FieldByName('DET_NUM_PD').AsString;
        strEsp_PD := FieldByName('DET_ESP_PD').AsString;
        strEmp_PD := FieldByName('DET_EMP_PD').AsString;
      End;

      If (fCfgSis('ITEDIV', varString) = 'P') And (Not fEmptyStr(strNum_PD)) Then
      Begin
        if fCampoTabela('IFNULL(E.FDO_NOTESP, "N")','FATDOR F INNER JOIN EXTDOR E ON(F.AUTOINCREM = E.FDO_SEQFDO)',['FDO_NUMDOC','FDO_ESPDOC','FDO_CODEMP','FDO_CODITE'],[strNum_PD,strEsp_PD,strEmp_PD,FieldByName('DET_CODITE').AsString],False) = 'N' then
        Begin
          fltFatorPreco := 1;
          fltFatorQtde  := 1;
        End
      End
      Else
      Begin
        If (qryGenIte.FieldByName('ITE_NOTESP').AsString = 'N') Then
        Begin
          fltFatorPreco := 1;
          fltFatorQtde  := 1;
        End;
      End;


      strCmpRefNotEsp := 'DET_TOTCUS';

      If fEmptyStr(strEmpDes) Then
      Begin
        If fCfgSis('VLCUNE') = 'PRECUS' Then
          strCmpRefNotEsp := 'DET_TOTCUS'
        Else If fCfgSis('VLCUNE') = 'PREULT' Then
          strCmpRefNotEsp := 'DET_TOTULT'
        Else If fCfgSis('VLCUNE') = 'IMPULT' Then
          strCmpRefNotEsp := 'DET_IMPULT'
        Else If fCfgSis('VLCUNE') = 'PREMED' Then
          strCmpRefNotEsp := 'DET_TOTMED'
        Else If Pos(fCfgSis('VLCUNE', varString), 'CUSFRE_FREIMP_') > 0 Then
          strCmpRefNotEsp := 'DET_CUSFRE';

        If (fFormataFloat(FieldByName(strCmpRefNotEsp).AsFloat, 4) = 0.000) Then
          strCmpRefNotEsp := 'DET_TOTCUS';
      End;

      If fCfgSis('VLCUNE') = 'FREIMP' Then
      Begin
        fltCUSFRE := (FieldByName(strCmpRefNotEsp).AsFloat / fltQtdIte);

        fltICMSSai := qryGenIte.FieldByName('ITE_ICMSAI').AsFloat;
        fltICMSSai := IIF(fltICMSSai = 0, fltICMSSai, fltICMSSai / 100);

        fltImpFed := qryGenIte.FieldByName('ITE_IMPFED').AsFloat;
        fltImpFed := IIF(fltImpFed = 0, fltImpFed, fltImpFed / 100);

        fltDesOpe := qryGenIte.FieldByName('ITE_DESOPE').AsFloat;
        fltDesOpe := IIF(fltDesOpe = 0, fltDesOpe, fltDesOpe / 100);

        fltValUniNotEsp := ((fltCUSFRE) / (1 - (fltICMSSai + fltImpFed + fltDesOpe))) * fRetFatorCustoNotaEspecial;
        fltValUniNotEsp := fFormataFloat(fltValUniNotEsp, 2);
      End
      Else
      Begin
        fltValUniNotEsp := (FieldByName(strCmpRefNotEsp).AsFloat / fltQtdIte) * fRetFatorCustoNotaEspecial;
      End;

      fltPreCus := FieldByName('DET_TOTCUS').AsFloat * fltFatorPreco / fltQtdIte;
      fltPreCu2 := FieldByName('DET_TOTCU2').AsFloat * fltFatorPreco / fltQtdIte;

      If Pos(fatVenda.strOpcDoc,'CO_MF_') > 0 Then
      begin
        fltUnitar := FieldByName('DET_UNITAR').AsFloat * fltFatorPreco;
        if (FieldByName('DET_DESCON').AsFloat > 0) then
          fltUniDig := FieldByName('DET_UNIORI').AsFloat * fltFatorPreco
        else
          fltUniDig := fltUnitar;
      end
      Else
      begin
        fltUnitar := (FieldByName('DET_UNITAR').AsFloat * fltFatorPreco) -
                    ((FieldByName('DET_DESESP').AsFloat / fltQtdIte) * fltFatorPreco);
        fltUniDig := fltUnitar;
      end;

      If fCfgSis('VENMAD', varBoolean) Or fCfgSis('VENVID', varBoolean) Or fCfgSis('VENMTL', varBoolean) Then
      Begin
        recMadeira.fltComPec := FieldByName('DET_COMPEC').AsFloat;
        recMadeira.fltLarPec := FieldByName('DET_LARPEC').AsFloat;
        recMadeira.fltEspPec := FieldByName('DET_ESPPEC').AsFloat;

        recMadeira.fltQtdPec := fCalculaQuantidadePecas(fltQtdIte,
                                                        recMadeira.fltComPec,
                                                        recMadeira.fltLarPec,
                                                        recMadeira.fltEspPec,
                                                        fRetSiglaUnidade(FieldByName('DET_UNIDAD').AsString));

        recMadeira.strAparel := FieldByName('DET_APAREL').AsString;
        recMadeira.fltPerApa := FieldByName('DET_PERAPA').AsFloat;
        recMadeira.strBenefi := FieldByName('DET_BENEFI').AsString;
        recMadeira.fltPerBen := FieldByName('DET_PERBEN').AsFloat;
      End;

      fltCusIte := fltPreCus;

      {**************************************}
      {* APLICA O FATOR SOBRE A QUANTIDADE  *}
      {***********************************JC*}
      If fatVenda.strTipFatNEs = 'Q' Then
      Begin
        fltQtdIte := fltQtdIte * fltFatorQtde;

        If (Frac(fltQtdIte) > 0.0) And //Caso seja fracionado
           (FieldByName('UNI_ITEFRA').AsString <> 'S') Then //caso nao permita fracionario
        Begin
          fltQtdIte := Succ(Floor(fltQtdIte)); //vai para o proximo valor inteiro
        End;
      End
      Else If (fltUnitar < fltValUniNotEsp) And (Not fPermiteEmissaoAbaixoDoCusto(fatVenda.strOpcDoc)) Then
      Begin
        If fEmptyStr(strEmpDes) And (fltValUniNotEsp > FieldByName('DET_UNITAR').AsFloat) Then //REQ.: 232462
          fltUnitar := FieldByName('DET_UNITAR').AsFloat
        Else
          fltUnitar := fltValUniNotEsp;
        blnAvisarOperadorVendaComPrecoCusto := True;
      End;  

      If fatVenda.fUtilizaPrecoSubItensEstrutura(Pos('ITEM ESPECIAL', qryGenIte.FieldByName('ITE_DESITE').AsString) > 0,
                                                 FieldByName('DET_CODITE').AsString) Then
      Begin
        impSubIteEst.strCodIte := FieldByName('DET_CODITE').AsString;
        impSubIteEst.strEmpIte := '';
        impSubIteEst.fltUniPai := fltUnitar;
        impSubIteEst.fltQtdPai := fltQtdIte;

        fatVenda.pRetImpostosSubItensEstrutura(impSubIteEst);

        fltOutValIte := impSubIteEst.fltOutVal * fltFatorPreco;
        fltDesOpeIte := impSubIteEst.fltDesOpe;
        fltImpFedIte := impSubIteEst.fltImpFed;
        fltIcmSaiIte := impSubIteEst.fltIcmSai;
        fltPreVe1Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','1',fatVenda.fltMargem);
        fltPreVe2Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','2',fatVenda.fltMargem);
        fltPreVe3Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','3',fatVenda.fltMargem);
        fltPreVe4Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','4',fatVenda.fltMargem);
        fltPreVe5Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','5',fatVenda.fltMargem);
        fltPreVe6Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','6',fatVenda.fltMargem);
        fltPreVe7Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','7',fatVenda.fltMargem);
      End
      Else
      Begin
        fltOutValIte := qryGenIte.FieldByName('ITE_OUTVAL').AsFloat * fltFatorPreco;
        fltDesOpeIte := qryGenIte.FieldByName('ITE_DESOPE').AsFloat;
        fltImpFedIte := qryGenIte.FieldByName('ITE_IMPFED').AsFloat;
        fltIcmSaiIte := IIF(fCfgSis('IMPCF4') = 'S', fatVenda.fCalculaAliquota(FieldByName('DET_CODITE').AsString, FieldByName('DET_CODEMP').AsString, qryGenIte.FieldByName('ITE_IMPDIR').AsString), qryGenIte.FieldByName('ITE_ICMSAI').AsFloat);
        fltPreVe1Ite := qryGenIte.FieldByName('ITE_PREVE1').AsFloat;
        fltPreVe2Ite := qryGenIte.FieldByName('ITE_PREVE2').AsFloat;
        fltPreVe3Ite := qryGenIte.FieldByName('ITE_PREVE3').AsFloat;
        fltPreVe4Ite := qryGenIte.FieldByName('ITE_PREVE4').AsFloat;
        fltPreVe5Ite := qryGenIte.FieldByName('ITE_PREVE5').AsFloat;
        fltPreVe6Ite := qryGenIte.FieldByName('ITE_PREVE6').AsFloat;
        fltPreVe7Ite := qryGenIte.FieldByName('ITE_PREVE7').AsFloat;
      End;

      strPromoc := 'N';
      If FindField('DET_PROMOC') <> Nil Then
        strPromoc := IfThen(FieldByName('DET_PROMOC').AsString = 'S', 'S', 'N');

      fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
                                          btnAdicionar,
                                          'NOR',
                                          FieldByName('ITE_CODGRU').AsString,
                                          FieldByName('DET_CODITE').AsString,
                                          qryGenIte.FieldByName('ITE_DESITE').AsString,
                                          FieldByName('DET_DESCRI').AsString,
                                          qryGenIte.FieldByName('ITE_DESFAB').AsString,
                                          FieldByName('DET_UNIDAD').AsString,
                                          FieldByName('DET_UNIDAD').AsString,
                                          FieldByName('DET_CODMAR').AsString,
                                          FieldByName('DET_FORITE').AsString,
                                          FieldByName('DET_REFERE').AsString,
                                          fltUnitar,
                                          fltUnitar,
                                          fltUnitar,
                                          fltUnitar,
                                          FieldByName('DET_DESCON').AsFloat,
                                          fltQtdIte,
                                          fltQtdIte * fltUnitar,
                                          'S',
                                          fltPreCus,
                                          fltPreCus * fltQtdIte,
                                          qryGenIte.FieldByName('ITE_COMLUB').AsString,
                                          qryGenIte.FieldByName('ITE_IPISAI').AsFloat,
                                          qryGenIte.FieldByName('ITE_DESMAX').AsFloat,
                                          fltPreVe1Ite * fltFatorPreco,
                                          fltPreVe2Ite * fltFatorPreco,
                                          fltPreVe3Ite * fltFatorPreco,
                                          fltPreVe4Ite * fltFatorPreco,
                                          fltPreVe5Ite * fltFatorPreco,
                                          fltPreVe6Ite * fltFatorPreco,
                                          fltPreVe7Ite * fltFatorPreco,
                                          fCalculaPrecoVenda(2, fltCusIte + fltOutValIte,
                                                                fltUnitar,
                                                                0,
                                                                fltIcmSaiIte,
                                                                fltImpFedIte,
                                                                fltDesOpeIte,
                                                                qryGenIte.FieldByName('ITE_COMTB' +
                                                                   IIF(fEmptyStr(FieldByName('DET_TABPRE').AsString), '1',
                                                                       FieldByName('DET_TABPRE').AsString)).AsFloat, fatVenda.VS_strMARMKP),
                                          qryGenIte.FieldByName('ITE_SALDOS').AsFloat,
                                          FieldByName('DET_INCPIS').AsString,
                                          qryGenIte.FieldByName('ITE_COMVAR').AsFloat,
                                          qryGenIte.FieldByName('ITE_COMATA').AsFloat,
                                          qryGenIte.FieldByName('ITE_COMDIS').AsFloat,
                                          '',
                                          '',
                                          '',
                                          0.0,
                                          0.0,
                                          '',
                                          qryGenIte.FieldByName('ITE_PREULT').AsFloat * fltQtdIte,
                                          qryGenIte.FieldByName('ITE_IMPULT').AsFloat,
                                          qryGenIte.FieldByName('ITE_PREULT').AsFloat,
                                          0.0,
                                          qryGenIte.FieldByName('ITE_CLAIPI').AsString,
                                          '',
                                          '',
                                          '',
                                          '',
                                          0,
                                          '',
                                          0,
                                          0.0,
                                          0.0,
                                          0.0,
                                          0.0,
                                          'N',
                                          '',
                                          0.0,
                                          0.0,

                                          qryGenIte.FieldByName('ABF_CODABF').AsString,
                                          FieldByName('DET_TOTPES').AsFloat / FieldByName('DET_QTDITE').AsFloat,
                                          qryGenIte.FieldByName('ITE_PESLIQ').AsFloat,
                                          strPromoc,
                                          0.0,
                                          0.0,
                                          0.0,
                                          0.0,
                                          '',
                                          fatVenda.fRetPerComGrupo(FieldByName('ITE_CODGRU').AsString),
                                          qryGenIte.FieldByName('ITE_CODFAB').AsString,
                                          -1,
                                          0.0,
                                          strNum_PD,
                                          strEsp_PD,
                                          strEmp_PD,
                                          qryGenIte.FieldByName('ITE_MARMIN').AsFloat,
                                          qryGenIte.FieldByName('ITE_MARMSG').AsFloat,
                                          qryGenIte.FieldByName('ITE_MARMGE').AsFloat,
                                          qryGenIte.FieldByName('MAR_DESMAR').AsString,
                                          fatVenda.strStatus,
                                          0.0,
                                          0.0,
                                          '',
                                          '',
                                          '',
                                          qryGenIte.FieldByName('ITE_EMBALA').AsFloat,
                                          '',
                                          '',
                                          '',
                                          qryGenIte.FieldByName('ITE_PRECOM').AsFloat,
                                          fltUniDig,
                                          qryGenIte.FieldByName('ITE_QTPPRO').AsFloat,
                                          '',
                                          '',
                                          qryGenIte.FieldByName('ITE_OBRCPF').AsString,
                                          '',
                                          '',
                                          fRetSiglaUnidade(FieldByName('DET_UNIDAD').AsString),
                                          0.0,
                                          fatVenda.fOrdemItem(cdsVenda,'Adiciona',btnAdicionar),
                                          '',
                                          qryItens.FieldByName('DET_CODACA').AsString,
                                          qryItens.FieldByName('DET_EMPACA').AsString,
                                          (qryItens.FieldByName('DET_PROACA').AsString = 'S'),
                                          '',
                                          '',
                                          '',
                                          fltOutValIte,
                                          qryGenIte.FieldByName('ITE_COMTB' +
                                             IIF(fEmptyStr(FieldByName('DET_TABPRE').AsString), '1',
                                                           FieldByName('DET_TABPRE').AsString) ).AsFloat,
                                          fltDesOpeIte,
                                          fltIcmSaiIte,
                                          fltImpFedIte,
                                          qryGenIte.FieldByName('ITE_DESMGE').AsFloat,
                                          '',
                                          '',
                                          '',
                                          FieldByName('DET_TABPRE').AsString,
                                          qryGenIte.FieldByName('ITE_IPIENT').AsFloat,
                                          qryGenIte.FieldByName('ITE_FREENT').AsFloat,
                                          '',
                                          0.0,
                                          '',
                                          0.0,
                                          '',
                                          '',
                                          FieldByName('DET_ENTFUT').AsString,
                                          FieldByName('DET_MOTFUT').AsString,
                                          IIF(FieldByName('DET_ENTFUT').AsString = 'S', FieldByName('DET_DTAFUT').AsDateTime, VS_Date),
                                          fltQtdIte,
                                          0,
                                          0,
                                          qryGenIte.FieldByName('ITE_IMPDIR').AsString,
                                          qryGenIte.FieldByName('ITE_LOCFIS').AsString,

                                          fltPreCu2,
                                          fltPreCu2 * fltQtdIte,
                                          0,
                                          0,
                                          0,
                                          0,
                                          0,
                                          0,
                                          recForTin,
                                          '',
                                          '',
                                          FieldByName('DET_NUMLOT').AsString,
                                          '',
                                          '',
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
                                          0,
                                          True,
                                          '',
                                          '',
                                          '',
                                          0,
                                          fltCusIte,
                                          qryGenIte.FieldByName('ITE_DESSIM').AsString,
                                          '',
                                          recMadeira,
                                          qryGenIte.FieldByName('ITE_IMPULT').AsFloat * fltQtdIte,
                                          0,
                                          0,
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
                                          '',
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

      fatVenda.pAdicionaDesEspOri(cdsVenda.FieldByName('ITE_CODITE').AsString,
                                  cdsVenda.FieldByName('AUTOINCREM').AsInteger,
                                  FieldByName('DET_DESESP').AsFloat,
                                  fltQtdIte);

      fatVenda.strCodDiv := FieldByName('DET_CODDIV').AsString;
      fatVenda.strCodVe2 := FieldByName('DET_CODVE2').AsString;

      If (RecNo = 1) Then
        fatVenda.intIdxPri := IDX_RETIRA;

      Next;
    End;

  End;

  FreeAndNil(qryGenIte);
  FreeAndNil(btnAdicionar);

end;

procedure TEmissaoNotaEspecial.pReconstroiParcelas(strNumDoc, strEspDoc, strCodEmp, strCodCli, strTabela: String; afatVenda: TFatVenda);
  Const
    arrLetra : Array[0..25] Of Char = ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');
  Var
    intIndice,
    intPar: Integer;
    qryTabGer: TUniQuery;
    strTabGer,
    strTabCnd: String;

  procedure pGravaTabelaCndPar(strAutInc: String; arrDuplic: TarrDuplicata);
    Var
      qryTabCnd: TUniQuery;
      intIndice: Integer;
  Begin
    Try
      qryTabCnd := fCriaQuery(Nil);

      With qryTabCnd Do
      Begin
        Close;
        SQL.Text := 'DELETE FROM '+strTabCnd+' WHERE GER_SEQGER = '+QuotedStr(strAutInc);
        ExecSQL;

        Close;
        SQL.Text := 'SELECT * FROM '+strTabCnd+' WHERE FALSE';
        Open;

        intPar := 0;
        For intIndice := Low(arrDuplic) To High(arrDuplic) Do
        Begin
          If afatVenda.intSeqDupBaiAdtCli = intIndice Then
            Continue;

          If arrDuplic[intIndice].curValor > 0 Then
          Begin
            qryTabCnd.Insert;
            FieldByName('GER_SEQGER').AsString := strAutInc;
            FieldByName('GER_PARCEL').AsString := arrLetra[intPar];
            FieldByName('GER_VALPAR').AsFloat  := arrDuplic[intIndice].curValor;
            qryTabCnd.Post;
            intPar := intPar + 1;
          End;
        End;
      End;
    Finally
      FreeAndNil(qryTabCnd);
    End;
  End;

begin
  strTabGer := 'MOVGER';
  strTabCnd := 'GERCND';

  If (strTabela = 'NOTGER') Then
  Begin
    strTabGer := 'NOTGER';
    strTabCnd := 'NOTCND';
  End;

  qryTabGer := fCriaQuery(Nil);
  Try
    qryTabGer.Close;
    qryTabGer.SQL.Add(' SELECT * FROM '+strTabGer);
    qryTabGer.SQL.Add('  WHERE GER_NUMDOC = :NUMDOC ');
    qryTabGer.SQL.Add('    AND GER_ESPDOC = :ESPDOC ');
    qryTabGer.SQL.Add('    AND GER_CODEMP = :CODEMP ');
    qryTabGer.SQL.Add('    AND GER_CODCLI = :CODCLI ');
    qryTabGer.ParamByName('NUMDOC').AsString := strNumDoc;
    qryTabGer.ParamByName('ESPDOC').AsString := strEspDoc;
    qryTabGer.ParamByName('CODEMP').AsString := strCodEmp;
    qryTabGer.ParamByName('CODCLI').AsString := strCodCli;
    qryTabGer.Open;

    qryTabGer.Edit;

    For intIndice := 1 To 12 Do
      qryTabGer.FieldByName('GER_VPAR' + fStrZero(intIndice, 2)).AsFloat := 0;

    intPar := 1;
    For intIndice := 1 To 12 Do
    Begin
      If afatVenda.intSeqDupBaiAdtCli = Pred(intIndice) Then
        Continue;

      If (fFormataFloat(afatVenda.arrDuplicata[Pred(intIndice)].curValor, 2) > 0) Then
      Begin
        qryTabGer.FieldByName('GER_VPAR' + fStrZero(intPar, 2)).AsFloat := afatVenda.arrDuplicata[Pred(intIndice)].curValor;
        intPar := intPar + 1;
      End;
    End;

    qryTabGer.Post;

    pGravaTabelaCndPar(qryTabGer.FieldByName('AUTOINCREM').AsString, afatVenda.arrDuplicata);
  Finally
    FreeAndNil(qryTabGer);
  End;
end;

procedure TEmissaoNotaEspecial.pAtualizaDuplicatasFFZerandoImpostos(strChaveMeiaNota: String; afatVenda: TFatVenda);
  Var
    intIndice : Integer;
    qryUpdRec : TUniQuery;
begin
  qryUpdRec := fCriaQuery(Nil);
  Try
    qryUpdRec.Close;
    qryUpdRec.SQL.Clear;
    qryUpdRec.SQL.Add(' UPDATE CADREC ');
    qryUpdRec.SQL.Add('    SET CTR_HIST01 = CONCAT(CTR_HIST01, " ", :HIST01) ');
    qryUpdRec.SQL.Add('       ,CTR_CHVPFF = :CHVPFF ');

    If (fltTotImpFF = 0) Then
    Begin
      qryUpdRec.SQL.Add('     ,CTR_VALIPI := 0 ');
      qryUpdRec.SQL.Add('     ,CTR_VALRET := 0 ');
      qryUpdRec.SQL.Add('     ,CTR_VALFCP := 0 ');
      qryUpdRec.SQL.Add('     ,CTR_VALCBS := 0 ');
      qryUpdRec.SQL.Add('     ,CTR_VALIBS := 0 ');
      qryUpdRec.SQL.Add('     ,CTR_VAL_IS := 0 ');
    End;

    qryUpdRec.SQL.Add('       ,CTR_VALFRE := 0 ');
    qryUpdRec.SQL.Add('       ,CTR_VALACE := 0 ');

    qryUpdRec.SQL.Add('  WHERE CTR_NUMDUP = :NUMDUP ');
    qryUpdRec.SQL.Add('    AND CTR_ESPDOC = :ESPDOC ');
    qryUpdRec.SQL.Add('    AND CTR_CODEMP = :CODEMP ');
    qryUpdRec.SQL.Add('    AND CTR_CODCLI = :CODCLI ');
    qryUpdRec.SQL.Add('    AND CTR_PARCEL = :PARCEL ');
    qryUpdRec.SQL.Add('    AND CTR_SEQBAI = 0 ');

    For intIndice := Low(afatVenda.arrDuplicata) To High(afatVenda.arrDuplicata) Do
    Begin
      If (fFormataFloat(afatVenda.arrDuplicata[intIndice].curValor, 2) > 0) Then
      Begin
        qryUpdRec.Close;
        qryUpdRec.ParamByName('NUMDUP').AsString := FDocOri;
        qryUpdRec.ParamByName('ESPDOC').AsString := FEspOri;
        qryUpdRec.ParamByName('CODEMP').AsString := FEmpOri;
        qryUpdRec.ParamByName('CODCLI').AsString := FCliOri;
        qryUpdRec.ParamByName('CHVPFF').AsString := strChaveMeiaNota;
        qryUpdRec.ParamByName('PARCEL').AsString := afatVenda.arrDuplicata[intIndice].strSequen;
        qryUpdRec.ParamByName('HIST01').AsString := 'REFERENTE NF - ' + afatVenda.strNumDoc + '-' + afatVenda.strEspDoc + '-' + afatVenda.strEmpDoc;
        qryUpdRec.ExecSQL;
      End;
    End;
  Finally
    FreeAndNil(qryUpdRec);
  End;
end;

procedure TEmissaoNotaEspecial.pCarregaCondicao;
  Var
    qryConCnd: TUniQuery;
begin
  qryConCnd := fCriaQuery(fatVenda);

  pPesquisaCadCnd(qryConCnd, qryConCnd, fatVenda.strCodCnd);
  If ( Not qryConCnd.IsEmpty ) Then
  Begin
    With qryConCnd Do
    Begin
      fatVenda.strCodCnd := FieldByName('CND_CODIGO').AsString;
      fatVenda.strDesCnd := FieldByName('CND_DESCRI').AsString;
      fatVenda.pAtualizaInformacoesCondPagamento(qryConCnd);
    End;
  End;

  FreeAndNil(qryConCnd);
end;

procedure TEmissaoNotaEspecial.pCarregaVendedor;
  Var
    qryConOpe: TUniQuery;
begin
  qryConOpe := fCriaQuery(fatVenda);

  pPesquisaCadOpe(qryConOpe, qryConOpe, FatVenda.strCodVen);

  With qryConOpe Do
  Begin
    fatVenda.strCodVen := FieldByName('OPE_CODOPE').AsString;
    fatVenda.strNomVen := FieldByName('OPE_NOMOPE').AsString;
    fatVenda.fltComVen := FieldByName('OPE_PERCOM').AsFloat;
    fatVenda.strTipVen := FieldByName('OPE_INTEXT').AsString;
  End;

  FreeAndNil(qryConOpe);
end;                    

procedure TEmissaoNotaEspecial.pCriaObjetos;
begin
  fatVenda := TFatVenda.CreateInstance('VN');
  pCriarCdsVenda(fatVenda);
end;

procedure TEmissaoNotaEspecial.pCriaObjetosExt;
begin
 pCriaObjetos
end;

procedure TEmissaoNotaEspecial.pRaise(strMsg: String);
begin
  pDestroyObjetos;
  Raise ExceptionAutCom.Create(strMsg);
end;

procedure TEmissaoNotaEspecial.pSetaTransferenciaDepositoFechado(ACodFor,
  ACodEmpDes: String);
begin
  blnNS_DepostitoFechado :=  ACodFor <> '';
  FstrEmpDes    := ACodEmpDes;
  FstrCodForEnt := ACodFor;
End;

procedure TEmissaoNotaEspecial.pApagaDuplicatas(strNumDup, strEspDoc, strCodEmp, strCodCli, strNumPar: String);
  Var
    qryDel : TUniQuery;
    qryDup : TUniQuery;

    procedure pCarregaParcelaExecuta(strNumParLoc: String);
    begin
      qryDel.Close;
      qryDel.ParamByName('NUMDUP').AsString := strNumDup;
      qryDel.ParamByName('ESPDOC').AsString := strEspDoc;
      qryDel.ParamByName('CODEMP').AsString := strCodEmp;
      qryDel.ParamByName('CODCLI').AsString := strCodCli;
      qryDel.ParamByName('PARCEL').AsString := strNumParLoc;

      pGravaLogCtr(qryDel.ParamByName('NUMDUP').AsString,
                   qryDel.ParamByName('ESPDOC').AsString,
                   qryDel.ParamByName('CODCLI').AsString,
                   qryDel.ParamByName('CODEMP').AsString,
                   qryDel.ParamByName('PARCEL').AsString,
                   0,
                   'EXCLUSÃO POR AJUSTE APÓS EMISSÃO NOTA ESPECIAL', 'TEmissaoNotaEspecial.fGravaCadRecParaNotaEspecial');
      qryDel.ExecSQL;
    end;

begin
  qryDup := fCriaQuery;
  qryDel := fCriaQuery;
  Try
    qryDel.Close;
    qryDel.SQL.Clear;
    qryDel.SQL.Add('DELETE FROM CADREC');
    qryDel.SQL.Add(' WHERE CTR_NUMDUP = :NUMDUP');
    qryDel.SQL.Add('   AND CTR_ESPDOC = :ESPDOC');
    qryDel.SQL.Add('   AND CTR_CODEMP = :CODEMP');
    qryDel.SQL.Add('   AND CTR_CODCLI = :CODCLI');
    qryDel.SQL.Add('   AND CTR_PARCEL = :PARCEL');

    If fEmptyStr(strNumPar) Then
    Begin
      qryDup.Close;
      qryDup.SQL.Clear;
      qryDup.SQL.Add('SELECT CTR_PARCEL');
      qryDup.SQL.Add('  FROM CADREC');
      qryDup.SQL.Add('WHERE CTR_NUMDUP = :NUMDUP');
      qryDup.SQL.Add('  AND CTR_ESPDOC = :ESPDOC');
      qryDup.SQL.Add('  AND CTR_CODEMP = :CODEMP');
      qryDup.SQL.Add('  AND CTR_CODCLI = :CODCLI');
      qryDup.SQL.Add('  AND CTR_DTAREC IS NULL');

      qryDup.ParamByName('NUMDUP').AsString := strNumDup;
      qryDup.ParamByName('ESPDOC').AsString := strEspDoc;
      qryDup.ParamByName('CODEMP').AsString := strCodEmp;
      qryDup.ParamByName('CODCLI').AsString := strCodCli;
      qryDup.Open;
      qryDup.First;

      If Not qryDup.IsEmpty Then
      Begin
        While Not qryDup.Eof Do
        Begin
          pCarregaParcelaExecuta(qryDup.FieldByName('CTR_PARCEL').AsString);
          qryDup.Next;
        End;
      End;
    End
    Else
    Begin
      pCarregaParcelaExecuta(strNumPar);
    End;
  Finally
    FreeAndNil(qryDup);
    FreeAndNil(qryDel);
  End;
end;

function TEmissaoNotaEspecial.fDeveGerarCadRecParaFF(const ATotalDuplicata, AValorAdiantamento, ATotalImpostos : Double; const ACondicaoPagamento : String; const ADataBase : TDateTime; const AFaturandoPedido : Boolean): Boolean;
  Var
    fltMinimo : Double;
    fltPrimeiraParcelaFF : Double;
begin
  Result := True;
  If (fCfgSis('DUPREC', varString) = 'N') Then
    Exit;
  fltMinimo := fCfgSis('GCTRFF', varDouble);
  If (fFormataFloat(fltMinimo, 2) <= 0) Then
    Exit;
  fltPrimeiraParcelaFF := fValorDaPrimeiraParcela(ATotalDuplicata, AValorAdiantamento, ATotalImpostos, ACondicaoPagamento, ADataBase, AFaturandoPedido);
  If (fFormataFloat(fltPrimeiraParcelaFF, 2) <= 0) Then
    Exit;
  Result := (fFormataFloat(fltPrimeiraParcelaFF, 2) > fFormataFloat(fltMinimo, 2));
end;

procedure TEmissaoNotaEspecial.pVerificaSeDeveZerarTotalDaDuplicata(var ATotalDaDuplicata : Double; const AValorAdiantamento : Double);
begin
  If ((ATotalDaDuplicata < 0) And (AValorAdiantamento <> 0)) Or ((AValorAdiantamento > 0) And (Abs(ATotalDaDuplicata) <= TOLERANCIA_DIFERENCA_EXPEDICAO_PARCIAL)) Then
    ATotalDaDuplicata := 0;
end;

function TEmissaoNotaEspecial.fValorDaPrimeiraParcela(const ATotalDuplicata, AValorAdiantamento, ATotalImpostos : Double; const ACondicaoPagamento : String; const ADataBase : TDateTime; const AFaturandoPedido : Boolean) : Double;
  Var
    fltTotalDuplicata : Double;
    arrDuplicata : TarrDuplicata;
begin
  Result := 0;
  fltTotalDuplicata := ATotalDuplicata;
  pVerificaSeDeveZerarTotalDaDuplicata(fltTotalDuplicata, AValorAdiantamento);
  If fDigDuplicEspecial(arrDuplicata, ACondicaoPagamento, ADataBase, fltTotalDuplicata, ATotalImpostos, AFaturandoPedido) Then
  Begin
    If (Length(arrDuplicata) > 0) Then
      Result := arrDuplicata[0].curValor;
  End;
end;

function TEmissaoNotaEspecial.fTotalDuplicatasFF : Double;
begin
  Result := fltTotCadRecFF - fltValAdtFF;
end;

function TEmissaoNotaEspecial.fTotalDuplicatasNF : Double;
begin
  Result := fltTotCadRecNF - fltValAdtNF;
end;

function TEmissaoNotaEspecial.fDataBase(const AFatVenda : TFatVenda) : TDateTime;
begin
  Result := VS_Date;
  If (fUtilizarComoDataBaseCtrDataEmissaoPedido(AFatVenda.fFaturandoPedido, AFatVenda.fUtilizarDataEmissaoCalcularDiaVencimento)) Then
    Result := AFatVenda.dtaDtaEntOri;
end;

function TEmissaoNotaEspecial.fImpostosDaFF : Double;
begin
  Result := 0;
end;

end.
