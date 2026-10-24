unit untGerarEspelhoEntMerDev;

interface

uses
  untGerarEspelhoDevolucaoAD,
  Uni,
  untFuncFat,
  UniClientDataSet, untFuncFatTypes, untTypesSistema, untFuncoesSimples,
  System.SysUtils, StrUtils, untGarant, System.Generics.Collections,
  gerarEspelhoEntMerDev.DAO, gerarEspelhoEntMerDev.DTO, Faturamento.Classes.TFatVendaBase.DTO;

Type
  TGerarEspelhoDevolucaoAD = untGerarEspelhoDevolucaoAD.TGerarEspelhoDevolucaoAD;
  TGerarEspelhoEntMerDev = Class(TGerarEspelhoDevolucaoAD)
  private
    FCamposNaoAssociados: String;
    FCamposEspelhoNotaECamposDevolucao: TDictionary<String, String>;
    FEspelhoEntMerDevDAO: TEspelhoEntMerDevDAO;
    function CdsItensDevToItemDadosDTO(aQryGenIte: TUniQuery): TDadosItemDTO;
    procedure PreencherCamposEspelhoNotaECamposDevolucao;
    procedure pGerarEspelhoEntMerDevAntesCarregarItens(pFatVenda: TFatVenda);
    procedure AddCampoNaoEncontrado(aCampo: String);
    procedure PreencherDadosConsumidorFatVenda(aInput: TInputDadosConsumidorDTO);
    function fIncluirItens: Boolean;
    // Req. 450881: monta a fonte de itens (temporaria strTmpIteDev, sem ADEDET) para
    // reaproveitar o corpo do fluxo AD (fCarregaItensDevolucaoAD via qryIteDevExterno).
    function fCriaFonteItensDevolucaoAvulsa: TUniQuery;
  protected
    FCdsItensDev: TUniClientDataSet;
    blnOrigemEntradaDV: Boolean;
    procedure pCarregarItens;override;
    function fCdsItensFieldStr(aNameField: String): String;
    function fCdsItensFieldFlt(aNameField: String): Double;
    procedure pGerarEspelhoEntMerDevAntesExibirDadosFiscais(pfrmFatDadosFiscais:  TfrmFatDadosFiscais; Out pContinuar: Boolean);
  public
      constructor Create; override;
      destructor Destroy; override;
      function fGerarEspelhoDevolucao(strCodCli: String; cdsItensDev: TUniClientDataSet; AOrigemEntradaDV: Boolean = False): Boolean;


  End;

implementation

{ TGerarEspelhoEntMerDev }

procedure TGerarEspelhoEntMerDev.AddCampoNaoEncontrado(aCampo: String);
begin

  if FCamposNaoAssociados.Contains(aCampo) then
    exit;

  if FCamposNaoAssociados = '' then
    FCamposNaoAssociados := aCampo
  else
    FCamposNaoAssociados := FCamposNaoAssociados+', ' +aCampo;
end;

function TGerarEspelhoEntMerDev.CdsItensDevToItemDadosDTO(aQryGenIte: TUniQuery): TDadosItemDTO;
var
  recForTin: TForTin;
  strRepos: String;
  recMadeira  : TDadosMadeira;
begin
  Result := TDadosItemDTO.Create;
  Result.CdsDados := cdsVenda;
  Result.BtnAdicionar := Nil;
  Result.strIdePro := 'NOR';
  Result.strCodGru := fCdsItensFieldStr('ITE_CODGRU');
  Result.strCodIte := fCdsItensFieldStr('DET_CODITE');
  Result.strDesOri := aQryGenIte.FieldByName('ITE_DESITE').AsString;
  Result.strDesIte := fCdsItensFieldStr('DESITE');
  Result.strDesFab := aQryGenIte.FieldByName('ITE_DESFAB').AsString;
  Result.strUnidad := aQryGenIte.FieldByName('UNI_CODUNI').AsString;
  Result.strCodUni := aQryGenIte.FieldByName('UNI_CODUNI').AsString;
  Result.strCodMar := aQryGenIte.FieldByName('ITE_CODMAR').AsString;
  Result.strCodFor := fCdsItensFieldStr('CODFOR');
  Result.strRefere := aQryGenIte.FieldByName('ITE_REFERE').AsString;
  Result.fltUniOri := fCdsItensFieldFlt('VALITE') / fCdsItensFieldFlt('QTDITE'); //uniori
  Result.fltUniVis := fCdsItensFieldFlt('VALITE') / fCdsItensFieldFlt('QTDITE'); //uniVis
  Result.fltUniTar := fCdsItensFieldFlt('VALITE') / fCdsItensFieldFlt('QTDITE'); //unitar
  Result.fltUniTmp := 0.0;
  Result.fltDesCon := 0.0;
  Result.fltQtdIte := fCdsItensFieldFlt('QTDITE');
  Result.fltTotIte := fCdsItensFieldFlt('VALITE'); //totite
  Result.strEntSai := IfThen(StrToIntDef(RightStr(fatVenda.strClaFis,1),0) >= 5,'S','E');
  Result.fltPreCus := fCdsItensFieldFlt('PRECUS');
  Result.fltTotCus := fFormataFloat(fCdsItensFieldFlt('PRECUS') * fCdsItensFieldFlt('QTDITE'), 2);
  Result.strComLub := aQryGenIte.FieldByName('ITE_COMLUB').AsString;
  Result.fltIpiSai := aQryGenIte.FieldByName('ITE_IPISAI').AsFloat;
  Result.fltDesMax := aQryGenIte.FieldByName('ITE_DESMAX').AsFloat;
  Result.fltPreVe1 := aQryGenIte.FieldByName('ITE_PREVE1').AsFloat;
  Result.fltPreVe2 := aQryGenIte.FieldByName('ITE_PREVE2').AsFloat;
  Result.fltPreVe3 := aQryGenIte.FieldByName('ITE_PREVE3').AsFloat;
  Result.fltPreVe4 := aQryGenIte.FieldByName('ITE_PREVE4').AsFloat;
  Result.fltPreVe5 := aQryGenIte.FieldByName('ITE_PREVE5').AsFloat;
  Result.fltPreVe6 := aQryGenIte.FieldByName('ITE_PREVE6').AsFloat;
  Result.fltPreVe7 := aQryGenIte.FieldByName('ITE_PREVE7').AsFloat;
  Result.fltMarLuc := 0.0;
  Result.fltSaldos := aQryGenIte.FieldByName('ITE_SALDOS').AsFloat;
  Result.strIncPis := 'N';
  Result.fltComVar := aQryGenIte.FieldByName('ITE_COMVAR').AsFloat;
  Result.fltComAta := aQryGenIte.FieldByName('ITE_COMATA').AsFloat;
  Result.fltComDis := aQryGenIte.FieldByName('ITE_COMDIS').AsFloat;
  Result.strDocDev := Copy(fCdsItensFieldStr('NUMDOC'), 1, fTamDocCadRec); //strDocDev
  Result.strEspDev := Copy(fCdsItensFieldStr('NUMDOC'), StrToInt(IfThen(fTamDocCadRec = 6, '8', '14')) , 2); //strEspDev
  Result.strEmpDev := fCdsItensFieldStr('EMPDOC'); //strEmpDev: String
  Result.fltQtdDev := 0;
  Result.fltUniDev := 0;
  Result.strIncDev := '';
  Result.fltTotUlt := aQryGenIte.FieldByName('ITE_PREULT').AsFloat * fCdsItensFieldFlt('QTDITE');
  Result.fltImpUlt := aQryGenIte.FieldByName('ITE_IMPULT').AsFloat;
  Result.fltPreUlt := aQryGenIte.FieldByName('ITE_PREULT').AsFloat;
  Result.fltPreMed := aQryGenIte.FieldByName('ITE_PREMED').AsFloat;
  Result.strClaIpi := aQryGenIte.FieldByName('ITE_CLAIPI').AsString;
  Result.strIteCha := '';
  Result.strIteTin := '';
  Result.strDesCor := '';
  Result.strTipPre := '';
  Result.intLazQua := 0;
  Result.strTipEmb := '';
  Result.fltQtdEmb := 0;
  Result.fltPreEmb := 0;
  Result.fltPrvTin := 0.00;
  Result.fltPrcTin := 0.00;
  Result.fltFatTin := 0.00;
  Result.strProEmb := 'N';
  Result.strIteEmb := '';
  Result.fltUniEmb := 0;
  Result.fltEmbAnt := 0;
  Result.strCodAbf := aQryGenIte.FieldByName('ABF_CODABF').AsString;
  Result.fltPesoIt := aQryGenIte.FieldByName('ITE_PESOIT').AsFloat;
  Result.fltPesLiq := aQryGenIte.FieldByName('ITE_PESLIQ').AsFloat;
  Result.strPromoc := 'N';
  Result.fltProPreCus := 0;
  Result.fltProPreVen := 0;
  Result.fltProComVar := 0;
  Result.fltProDesF07 := 0;
  Result.strTipTin := '';
  Result.fltGPeCom := fatVenda.fRetPerComGrupo(aQryGenIte.FieldByName('ITE_CODGRU').AsString);
  Result.strCodFab := aQryGenIte.FieldByName('ITE_CODFAB').AsString;
  Result.intSeqInd := -1;
  Result.fltQtdBai := 0;
  Result.strNumOrc := '';
  Result.strEspOrc := '';
  Result.strEmpOrc := '';
  Result.fltMarMin := aQryGenIte.FieldByName('ITE_MARMIN').AsFloat;
  Result.fltMarMSG := aQryGenIte.FieldByName('ITE_MARMSG').AsFloat;
  Result.fltMarMGe := aQryGenIte.FieldByName('ITE_MARMGE').AsFloat;
  Result.strMarca := fRetNomMarca(aQryGenIte.FieldByName('ITE_CODMAR').AsString);
  Result.strStatus := '';
  Result.fltComDev := 0;
  Result.fltDesDev := 0;
  Result.strSeqDet := '';
  Result.strCatalize := '';
  Result.strLinTin := '';
  Result.fltEmbala := 0;
  Result.strDesNes := '';
  Result.strSemEst := '';
  Result.strLibEst := '';
  Result.fltPreCom := aQryGenIte.FieldByName('ITE_PRECOM').AsFloat;
  Result.fltUniDig := fCdsItensFieldFlt('VALITE') / fCdsItensFieldFlt('QTDITE'); //unidig
  Result.fltQtdPon := aQryGenIte.FieldByName('ITE_QTPPRO').AsFloat;
  Result.strComple := '';
  Result.strDivDev := '';
  Result.strObrCpf := aQryGenIte.FieldByName('ITE_OBRCPF').AsString;
  Result.strMontad := '';
  Result.strA_n_o_ := '';
  Result.strSigUni := fRetSiglaUnidade(aQryGenIte.FieldByName('UNI_CODUNI').AsString);
  Result.fltVolPro := 0.00;
  Result.intOrdite := 0;
  Result.strChaFor := '';
  Result.strCodAca := '';
  Result.strEmpAca := '';
  Result.blnProAca := False;
  Result.strEspFut := '';
  Result.strDocFut := '';
  Result.strEmpFut := '';
  Result.fltOutVal := 0;
  Result.fltComTbl := 0;
  Result.fltDesOpe := 0;
  Result.fltICMSai := 0;
  Result.fltImpFed := 0;
  Result.fltDesMge := 0;
  Result.strDocCnf := '';
  Result.strEspCnf := '';
  Result.strEmpCnf := '';
  Result.strTabPre := IIF(fEmptyStr(fCdsItensFieldStr('TABPRE')),'1',fCdsItensFieldStr('TABPRE'));
  Result.fltIpiEnt := aQryGenIte.FieldByName('ITE_IPIENT').AsFloat;
  Result.fltFreEnt := aQryGenIte.FieldByName('ITE_FREENT').AsFloat;
  Result.strCodDil := '';
  Result.fltPorDil := 0.0;
  Result.strDilCon := '';
  Result.fltPorCat := 0.0;
  Result.strEntRet := 'R';
  Result.strLocRet := '';
  Result.strEntFut := 'N';
  Result.strMotFut := '';
  Result.dtaDtaEnt := 0;
  Result.fltQtdOri := fCdsItensFieldFlt('QTDITE');
  Result.fltDesEsp := 0.0;
  Result.fltDesBai := 0;
  Result.strImpDir := aQryGenIte.FieldByName('ITE_IMPDIR').AsString;
  Result.strLocFis := '';
  Result.fltPreCu2 := 0.00;
  Result.fltTotCu2 := 0.00;
  Result.fltProComAta := 0.00;
  Result.fltProComDis := 0;
  Result.fltTotPed := 0;
  Result.fltPanUti := 0;
  Result.fltTotDes := 0;
  Result.ftlTotFre := 0;
  Result.recForTin := recForTin;
  Result.strKey_EP := '';
  Result.strLotAnt := '';
  Result.strNumLot := IIF(fEmptyStr(strRepos) or (strRepos = 'S'), fCdsItensFieldStr('LOTSAI'), fCdsItensFieldStr('NUMLOT'));
  Result.strEmpPrd := '';
  Result.strVenCnf := '';
  Result.blnBxSbIt := False;
  Result.strPigBas := 'N';
  Result.strIdeDev := 'NOR';
  Result.fltQtdDet := 0;
  Result.strTabDev := '';
  Result.strCodBar := aQryGenIte.FieldByName('ITE_CODBAR').AsString;
  Result.strTipFin := '';
  Result.fltDesFin := 0;
  Result.fltPreLot := 0;
  Result.fltCoDvRp := 0;
  Result.strEmpIte := '';
  Result.fltFatAce := 1;
  Result.blnPodAlt := True;
  Result.strEmpSol := '';
  Result.strCndDev := '';
  Result.strCCndDv := '';
  Result.dtaEmiDev := 0;
  Result.fltCusIte := fCdsItensFieldFlt('PRECUS');
  Result.strDesSim := '';
  Result.strOrdPro := '';
  Result.recMadeira := recMadeira;
  Result.fltTotImp := aQryGenIte.FieldByName('ITE_IMPULT').AsFloat *fCdsItensFieldFlt('QTDITE');
  Result.fltVal_RT := 0;
  Result.fltTaxJur := 0;
  Result.strSeqGad := '';
  Result.fltQtdExp := 0;
  Result.strBarEmb := '';
  Result.strNumCmp := '';
  Result.intNItCmp := 0;
  Result.fltDeDVCf := 0;
  Result.strCodMec := '';
  Result.strSeqRcd := '';
  Result.intSeqInc := 0;
  Result.strCodVenIte := fCdsItensFieldStr('CODVEN');
  Result.strAltPCoIte := 'N';
  Result.fltPerComIte := 0;
  Result.fltFreDev := 0;
  Result.fltDeADev := 0;
  Result.blnAlterandoPDORCarregado := False;
  Result.blnInserindoPDORCarregado := False;
  Result.strCliBus := 'N';
  Result.strTurEnt := '';
  Result.intSeqCcr := 0;
  Result.fltDopTin := 0;
  Result.strCodVe2Ite := '';
  Result.strLibUni := 'N';
  Result.fltValDif := 0;
  Result.strLotAba := '';
  Result.strIncFut := '';
  Result.strSepExp := '';
  Result.strTabPreEmb := '';
  Result.strExcIpi := '';
  Result.fltDesMSu := 0.00;
  Result.strAiDvOr := '';
  Result.strClaFis := '';
  Result.strSeqOpI := '';
  Result.strRatDes := 'S';
  Result.strBrinde := 'N';
  Result.strCodPar := '';
  Result.strTipBri := '';
  Result.strSeqGer := '';
  Result.strBaseQtdZerada := '';
  Result.blnEdiPes := False;
  Result.fltPesoItCad := -1;
  Result.fltPesLiqCad := -1;
  Result.strPegou_ := 'N';
  Result.strIteAbf := '';
  Result.strAtivac := 'N';
  Result.intSeqCom := 0;
  Result.fltQtdAti := 0;
  Result.fltQtdCom := 0;
  Result.strTabCom := '';
  Result.fltPorGer := 0;
  Result.fltPorDet := 0;
  Result.intSeqEst := 0;
  Result.strIteEst := '';
  Result.fltUniEst := 0;
  Result.fltQtdSbi := 0;
  Result.fltUniSbi := 0;
  Result.strLotSep := '';
  Result.strObsColorista := '';
  Result.intTipoFormulacao := 0;
  Result.fltFreMkp := 0;
  Result.fltComMkp := 0;
  Result.blnJaFatu := False;
  Result.strTipFat := '';
  Result.strNumFat := '';
  Result.strEmpFat := '';
  Result.strVenFat := '';
  Result.strCndFat := '';
  Result.fltValFat := 0;
  Result.dtaDtaFat := 0;
  Result.fltComDig := 0;
  Result.fltBFCPST := 0;
  Result.fltPFCPST := 0;
  Result.fltVFCPST := 0;
  Result.intQDEntr := 0;
  Result.strNotC17 := '';
  Result.strCodCmg := '';
  Result.fltQtdSep := 0;
  Result.fltDesCnd := 0;
  Result.strProEsp := '';
  Result.strPorPer := '';
  Result.strExibSE := 'N';
  Result.strFdoIteRecalcPrecos := 'N';
  Result.strOpBxSe := '';
  Result.dtaDtBxSe := 0;
  Result.dtaHrBxSe := 0;
  Result.strEmpCar := '';
  Result.strAutoinDevCar := '';
  Result.strEntFutDocOri := '';
  Result.strTemNumSerie := '';
  Result.strOpSeEx := '';
  Result.strConExp := '';
  Result.strEmbExp := '';
  Result.strObsExp := '';
  Result.strChkOut := '';
  Result.fltDesMVM := 0;
  Result.fltDesMSM := 0;
  Result.fltDesMGM := 0;
  Result.fltMarMMV := aQryGenIte.FieldByName('ITE_MARMMV').AsFloat;
  Result.fltMarMMS := aQryGenIte.FieldByName('ITE_MARMMS').AsFloat;
  Result.fltMarMMG := aQryGenIte.FieldByName('ITE_MARMMG').AsFloat;
end;

constructor TGerarEspelhoEntMerDev.Create;
begin
  inherited;
  strNomeForm := 'TGerarEspelhoEntMerDev';
  AntesGerarEspelho := pGerarEspelhoEntMerDevAntesCarregarItens;
  AntesExibirDadosFiscais := pGerarEspelhoEntMerDevAntesExibirDadosFiscais;
  FCamposEspelhoNotaECamposDevolucao := TDictionary<String, String>.Create;
  PreencherCamposEspelhoNotaECamposDevolucao;
  FEspelhoEntMerDevDAO := TEspelhoEntMerDevDAO.Create;
end;

destructor TGerarEspelhoEntMerDev.Destroy;
begin
  FreeAndNil(FCamposEspelhoNotaECamposDevolucao);
  FreeAndNil(FEspelhoEntMerDevDAO);
  inherited;
end;

function TGerarEspelhoEntMerDev.fCdsItensFieldFlt(aNameField: String): Double;
var
  nameField: String;

begin
  Result := 0;
  if not FCamposEspelhoNotaECamposDevolucao.TryGetValue(aNameField,nameField) then
    nameField := aNameField;

  if Assigned(FCdsItensDev.FindField(nameField)) then
  begin
    Result := FCdsItensDev.FieldByName(nameField).AsFloat;
  end
  else
    AddCampoNaoEncontrado(nameField);
end;

function TGerarEspelhoEntMerDev.fCdsItensFieldStr(aNameField: String): String;
var
  nameField: String;
begin
  Result := '';
  if not FCamposEspelhoNotaECamposDevolucao.TryGetValue(aNameField,nameField) then
    nameField := aNameField;

  if Assigned(FCdsItensDev.FindField(nameField)) then
    Result := FCdsItensDev.FieldByName(nameField).AsString
  else
    AddCampoNaoEncontrado(nameField);

end;

function TGerarEspelhoEntMerDev.fGerarEspelhoDevolucao(strCodCli: String; cdsItensDev: TUniClientDataSet; AOrigemEntradaDV: Boolean = False): Boolean;
begin
  FCodCli := strCodCli;
  FCdsItensDev := cdsItensDev;
  blnOrigemEntradaDV := AOrigemEntradaDV;
  Result := fGerarEspelhoExec;

end;


function TGerarEspelhoEntMerDev.fIncluirItens: Boolean;
var
  qryGenIte   : TUniQuery;
  inputDadosConsumidor: TInputDadosConsumidorDTO;
  itemEspelho: TDadosItemDTO;
begin

  Try
    qryGenIte := fCriaQuery;

    inputDadosConsumidor.NumDoc := FCdsItensDev.FieldByName('DET_NUMDOC').AsString;
    inputDadosConsumidor.EspDoc := FCdsItensDev.FieldByName('DET_ESPDOC').AsString;
    inputDadosConsumidor.CodEmp := FCdsItensDev.FieldByName('DET_CODEMP').AsString;

    PreencherDadosConsumidorFatVenda(inputDadosConsumidor);

{$Region 'agrupamento de itens'}
//    With cdsItens Do
//    Begin
//      DisableControls;
//      First;
//
//      While Not Eof Do
//      Begin
//        cdsGroup.Close;
//        cdsGroup.Open;
//
//        If (FieldByName('REPOST').AsString = 'S') Or
//           (FieldByName('REPOST').AsString = strRepos) Then
//        Begin
//          If Not cdsGroup.Locate('CODITE;NUMDOC;INCORI;LOTSAI', VarArrayOf([FieldByName('CODITE').AsString,
//                                                                            FieldByName('NUMDOC').AsString,
//                                                                            FieldByName('INCORI').AsString,
//                                                                            FieldByName('LOTSAI').AsString]), []) Then
//          Begin
//            cdsGroup.Insert;
//            cdsGroup.FieldByName('NUMENT').AsString     := FieldByName('NUMENT').AsString;
//            cdsGroup.FieldByName('DTAENT').AsDateTime   := FieldByName('DTAENT').AsDateTime;
//            cdsGroup.FieldByName('CODVEN').AsString     := FieldByName('CODVEN').AsString;
//            cdsGroup.FieldByName('CODCLI').AsString     := FieldByName('CODCLI').AsString;
//            cdsGroup.FieldByName('CODFOR').AsString     := FieldByName('CODFOR').AsString;
//            cdsGroup.FieldByName('CODITE').AsString     := FieldByName('CODITE').AsString;
//            cdsGroup.FieldByName('LOTSAI').AsString     := FieldByName('LOTSAI').AsString;
//            cdsGroup.FieldByName('DESITE').AsString     := FieldByName('DESITE').AsString;
//            cdsGroup.FieldByName('NUMDOC').AsString     := FieldByName('NUMDOC').AsString;
//            cdsGroup.FieldByName('EMPDOC').AsString     := FieldByName('EMPDOC').AsString;
//            cdsGroup.FieldByName('QTDITE').AsFloat      := FieldByName('QTDITE').AsFloat;
//            cdsGroup.FieldByName('VALITE').AsFloat      := FieldByName('VALITE').AsFloat;
//            cdsGroup.FieldByName('REPOST').AsString     := FieldByName('REPOST').AsString;
//            cdsGroup.FieldByName('REFERE').AsString     := FieldByName('REFERE').AsString;
//            cdsGroup.FieldByName('DESUNI').AsString     := FieldByName('DESUNI').AsString;
//            cdsGroup.FieldByName('OBSP_1').AsString     := FieldByName('OBSP_1').AsString;
//            cdsGroup.FieldByName('OBSP_2').AsString     := FieldByName('OBSP_2').AsString;
//            cdsGroup.FieldByName('AUTINC').AsString     := FieldByName('AUTINC').AsString;
//            cdsGroup.FieldByName('QTDDEV').AsFloat      := FieldByName('QTDDEV').AsFloat;
//            cdsGroup.FieldByName('DTAENV').AsDateTime   := FieldByName('DTAENV').AsDateTime;
//            cdsGroup.FieldByName('JA_GRAVADO').AsString := FieldByName('JA_GRAVADO').AsString;
//            cdsGroup.FieldByName('CODFAB').AsString     := FieldByName('CODFAB').AsString;
//            cdsGroup.FieldByName('PRECUS').AsFloat      := FieldByName('PRECUS').AsFloat;
//            cdsGroup.FieldByName('TABPRE').AsString     := FieldByName('TABPRE').AsString;
//            cdsGroup.FieldByName('NUMLOT').AsString     := FieldByName('NUMLOT').AsString;
//            cdsGroup.FieldByName('DESACE').AsFloat      := FieldByName('DESACE').AsFloat;
//            cdsGroup.FieldByName('INCORI').AsString     := FieldByName('INCORI').AsString;
//            fltDesAce :=  fltDesAce + FieldByName('DESACE').AsFloat ;
//
//            cdsGroup.Post;
//          End
//          Else
//          Begin
//            cdsGroup.Edit;
//            cdsGroup.FieldByName('QTDITE').AsFloat := cdsGroup.FieldByName('QTDITE').AsFloat +
//                                                      FieldByName('QTDITE').AsFloat;
//
//            cdsGroup.FieldByName('DESACE').AsFloat := cdsGroup.FieldByName('DESACE').AsFloat +
//                                                      FieldByName('DESACE').AsFloat;
//
//            fltDesAce :=  fltDesAce + FieldByName('DESACE').AsFloat ;
//
//            cdsGroup.Post;
//          End;
//        End;
//
//        Next;
//      End;
//
//      EnableControls;
//    End;
//
{$EndRegion 'agrupamento de itens'}
    //Verificar com o tester se agrupa os itens
    FCdsItensDev.DisableControls;

    fatVenda.fltDesEsp := 0;

    FCdsItensDev.First;
    FCamposNaoAssociados := '';
    While Not FCdsItensDev.Eof Do
    Begin

      if fCdsItensFieldFlt('QTDITE') > 0 then
      Begin

        fatVenda.blnRaiseError := True;
        fGetItem(qryGenIte,fCdsItensFieldStr('CODITE'));

        try
          itemEspelho := CdsItensDevToItemDadosDTO(qryGenIte);
          fatVenda.pAdicionaRegistroTemporariaNew(itemEspelho);
        finally
          FreeAndNil(itemEspelho);
        end;
      end;

      FCdsItensDev.Next;

    End;
    if FCamposNaoAssociados <> '' then
      pMensagemOk(FCamposNaoAssociados);
    FCdsItensDev.EnableControls;

    Result := True;

    FreeAndNil(qryGenIte);

  Except
    On E: Exception Do
    Begin
      Result := False;
      If E.Message <> 'Falha FuncFat' Then
  			pMensagensErro(E.Message,'[TGerarEspelhoEntMerDev.fIncluiItens]');
    End else
      raise;

  End;

end;

function TGerarEspelhoEntMerDev.fCriaFonteItensDevolucaoAvulsa: TUniQuery;
var
  qryTmp: TUniQuery; // dataset "vivo" sobre a temporaria, para inserir os itens
  qryOri: TUniQuery; // linha de origem (MOVDET/NOTDET) do item selecionado
  intAutInc: Integer;
  strTabela: String;
  strAutOri: String;
  fltQtdDev: Double;
  fltUniOri: Double;
begin
  Result := nil;
  qryTmp := fCriaQuery;
  qryOri := fCriaQuery;
  Try
    // A temporaria ja foi criada (vazia) por pCriaTemporariaIteDev; garante limpeza e abre "viva".
    qryTmp.SQL.Text := 'DELETE FROM ' + fatVenda.strTmpIteDev;
    qryTmp.ExecSQL;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Text := 'SELECT * FROM ' + fatVenda.strTmpIteDev;
    qryTmp.Open;

    intAutInc := 1;

    FCdsItensDev.DisableControls;
    Try
      FCdsItensDev.First;
      While Not FCdsItensDev.Eof Do
      Begin
        fltQtdDev := FCdsItensDev.FieldByName('QTDDEV').AsFloat;

        // RN05: somente itens com quantidade a devolver entram no espelho.
        If fltQtdDev > 0 Then
        Begin
          strTabela := FCdsItensDev.FieldByName('TABELA').AsString;      // MOVDET / NOTDET
          strAutOri := FCdsItensDev.FieldByName('AUTOINCREM').AsString;  // id do item na origem

          qryOri.Close;
          qryOri.SQL.Text := 'SELECT * FROM ' + strTabela + ' WHERE AUTOINCREM = :INC';
          qryOri.ParamByName('INC').AsString := strAutOri;
          qryOri.Open;

          // RN04: item sem quantidade original nao gera linha (evita divisao por zero na proporcao QTDDEV/QTDORI)
          If (Not qryOri.IsEmpty) And (qryOri.FieldByName('DET_QTDITE').AsFloat > 0) Then
          Begin
            fltUniOri := qryOri.FieldByName('DET_UNITAR').AsFloat;

            qryTmp.Insert;

            // Identificacao / chaves
            qryTmp.FieldByName('AUTOINCREM').AsInteger := intAutInc;             // PK propria da temporaria
            qryTmp.FieldByName('DET_AUTOIN').AsString  := strAutOri;            // strIncDev: chave da origem p/ objItensNotaEspelho (tributos proporcionais)
            qryTmp.FieldByName('DET_TABELA').AsString  := strTabela;            // origem MOVDET/NOTDET
            qryTmp.FieldByName('DET_TIP_FC').AsString  := 'C';
            qryTmp.FieldByName('DET_SEQGER').AsString  := qryOri.FieldByName('DET_SEQGER').AsString;
            qryTmp.FieldByName('DET_NUMDOC').AsString  := qryOri.FieldByName('DET_NUMDOC').AsString;
            qryTmp.FieldByName('DET_ESPDOC').AsString  := qryOri.FieldByName('DET_ESPDOC').AsString;
            qryTmp.FieldByName('DET_CODEMP').AsString  := qryOri.FieldByName('DET_CODEMP').AsString;
            qryTmp.FieldByName('DET_EMPORI').AsString  := qryOri.FieldByName('DET_CODEMP').AsString;
            qryTmp.FieldByName('DET_SERIE_').AsString  := qryOri.FieldByName('DET_SERIE_').AsString;
            qryTmp.FieldByName('DET_FORCLI').AsString  := qryOri.FieldByName('DET_CODCLI').AsString;

            // Item / descricao
            qryTmp.FieldByName('DET_CODITE').AsString  := qryOri.FieldByName('DET_CODITE').AsString;
            qryTmp.FieldByName('DET_DESCRI').AsString  := qryOri.FieldByName('DET_DESCRI').AsString;
            qryTmp.FieldByName('DET_REFERE').AsString  := qryOri.FieldByName('DET_REFERE').AsString;
            qryTmp.FieldByName('DET_UNIDAD').AsString  := qryOri.FieldByName('DET_UNIDAD').AsString;
            qryTmp.FieldByName('DET_CODMAR').AsString  := qryOri.FieldByName('DET_CODMAR').AsString;
            qryTmp.FieldByName('DET_CODDIV').AsString  := qryOri.FieldByName('DET_CODDIV').AsString;
            qryTmp.FieldByName('DET_CODVEN').AsString  := qryOri.FieldByName('DET_CODVEN').AsString;
            qryTmp.FieldByName('DET_CODVE2').AsString  := qryOri.FieldByName('DET_CODVE2').AsString;
            qryTmp.FieldByName('DET_IDEPRO').AsString  := qryOri.FieldByName('DET_IDEPRO').AsString;
            qryTmp.FieldByName('DET_NUMLOT').AsString  := qryOri.FieldByName('DET_NUMLOT').AsString;
            qryTmp.FieldByName('DET_TABPRE').AsString  := qryOri.FieldByName('DET_TABPRE').AsString;
            // DET_ORDPRO existe em MOVDET mas nao em NOTDET: leitura protegida (default vazio).
            If Assigned(qryOri.FindField('DET_ORDPRO')) Then
              qryTmp.FieldByName('DET_ORDPRO').AsString := qryOri.FieldByName('DET_ORDPRO').AsString;
            qryTmp.FieldByName('DET_CODACA').AsString  := qryOri.FieldByName('DET_CODACA').AsString;
            qryTmp.FieldByName('DET_EMPACA').AsString  := qryOri.FieldByName('DET_EMPACA').AsString;
            qryTmp.FieldByName('DET_PROACA').AsString  := qryOri.FieldByName('DET_PROACA').AsString;

            // Tributacao de origem: o motor (TDefineCFOP) re-deriva CFOP/CST da operacao DV a partir do DET_CODFIS.
            qryTmp.FieldByName('DET_CODFIS').AsString  := qryOri.FieldByName('DET_CODFIS').AsString;
            qryTmp.FieldByName('DET_CLAFIS').AsString  := ''; // CFOP de devolucao definido pelo motor (nao copia o da venda)

            // Datas / pagamento
            qryTmp.FieldByName('DET_DTAENT').AsDateTime := qryOri.FieldByName('DET_DTAENT').AsDateTime;
            qryTmp.FieldByName('DET_CONPAG').AsString   := qryOri.FieldByName('DET_CONPAG').AsString;
            qryTmp.FieldByName('DET_CODCND').AsString   := qryOri.FieldByName('DET_CODCND').AsString;

            // Percentuais copiados (alicotas nao sao proporcionalizadas - RN01)
            qryTmp.FieldByName('DET_PERCOM').AsFloat := qryOri.FieldByName('DET_PERCOM').AsFloat;
            qryTmp.FieldByName('DET_PERREP').AsFloat := qryOri.FieldByName('DET_PERREP').AsFloat;
            qryTmp.FieldByName('DET_UNIORI').AsFloat := qryOri.FieldByName('DET_UNIORI').AsFloat;

            // Quantidade / valores (RF01/RF02/RF03/RN02): unitario da origem, total = unit x qtd devolvida.
            qryTmp.FieldByName('DET_QTDITE').AsFloat := fltQtdDev;
            qryTmp.FieldByName('DET_QTDDET').AsFloat := fltQtdDev;
            qryTmp.FieldByName('DET_QTDORI').AsFloat := qryOri.FieldByName('DET_QTDITE').AsFloat; // qtd original vendida
            qryTmp.FieldByName('DET_UNITAR').AsFloat := fltUniOri;
            qryTmp.FieldByName('DET_UNIVIS').AsFloat := fltUniOri;
            qryTmp.FieldByName('DET_TOTITE').AsFloat := fFormataFloat(fltQtdDev * fltUniOri, 2);

            // Custo (nao fiscal) - preserva o custo unitario da origem quando disponivel
            If qryOri.FieldByName('DET_QTDITE').AsFloat > 0 Then
              qryTmp.FieldByName('DET_PRECUS').AsFloat := fFormataFloat(qryOri.FieldByName('DET_TOTCUS').AsFloat / qryOri.FieldByName('DET_QTDITE').AsFloat, 4);

            qryTmp.Post;

            Inc(intAutInc);
          End;
        End;

        FCdsItensDev.Next;
      End;
    Finally
      FCdsItensDev.EnableControls;
    End;

    qryOri.Close;

    // Fonte no mesmo contrato do qryIteDev do AD (D.* da temporaria), porem sem ADEDET.
    Result := fCriaQuery;
    try
      Result.SQL.Text := 'SELECT D.* FROM ' + fatVenda.strTmpIteDev + ' D';
      Result.Open;
    except
      on e: Exception do
      begin
        FreeAndNil(Result);
        pMensagensErro(e.message, '[TGerarEspelhoEntMerDev.fCriaFonteItensDevolucaoAvulsa]');
      end;
    end;

  Finally
    FreeAndNil(qryTmp);
    FreeAndNil(qryOri);
  End;
end;

procedure TGerarEspelhoEntMerDev.pCarregarItens;
var
  qryFonte: TUniQuery;
  inputDadosConsumidor: TInputDadosConsumidorDTO;
begin
  qryFonte := nil;
  If not blnOrigemEntradaDV then
    fIncluirItens
  Else
  begin
    // Preserva o comportamento SEM AD de carregar os dados do consumidor da nota (GAG).
    FCdsItensDev.First;
    inputDadosConsumidor.NumDoc := FCdsItensDev.FieldByName('DET_NUMDOC').AsString;
    inputDadosConsumidor.EspDoc := FCdsItensDev.FieldByName('DET_ESPDOC').AsString;
    inputDadosConsumidor.CodEmp := FCdsItensDev.FieldByName('DET_CODEMP').AsString;
    PreencherDadosConsumidorFatVenda(inputDadosConsumidor);

    // Req. 450881: em vez de montar o DTO manualmente (que invertia unitario x total, nao levava
    // DET_CODFIS e deixava strIncDev vazio), reaproveita o corpo do fluxo AD alimentando-o com os
    // itens selecionados via temporaria (qryIteDevExterno). Assim qtd/unitario/total e os tributos
    // (CST/IPI/ICMS/ST) saem iguais ao fluxo COM AD.
    Try
      qryFonte := fCriaFonteItensDevolucaoAvulsa;
      fatVenda.qryIteDevExterno := qryFonte;
      Try
        fatVenda.fCarregaItensDevolucaoAD(nil);
      Finally
        fatVenda.qryIteDevExterno := nil;
      End;
    Finally
      If Assigned(qryFonte) then
        FreeAndNil(qryFonte);
    End;
  end;
end;

procedure TGerarEspelhoEntMerDev.pGerarEspelhoEntMerDevAntesCarregarItens(pFatVenda: TFatVenda);
begin
//  fatVenda.strMotDev := '';
  fatVenda.blnEspelhoDevolucaoClienteGarantia := False;
  // Req. 450881: habilita o espelhamento dos tributos da nota de origem (CST/IPI/ICMS/ST).
  // O gate fEhDevolucaoEspelhoOuParaFornecedor exige blnDvComDta quando o CRM (UTICRM) nao esta ativo.
  fatVenda.blnDvComDta := True;
end;

procedure TGerarEspelhoEntMerDev.pGerarEspelhoEntMerDevAntesExibirDadosFiscais(
  pfrmFatDadosFiscais: TfrmFatDadosFiscais; out pContinuar: Boolean);
begin
  pContinuar := False;
  pfrmFatDadosFiscais.pAplicarModoSomenteVisualizacaoEspelhoDevolucao(blnOrigemEntradaDV);
  pfrmFatDadosFiscais.ShowModal;
end;

procedure TGerarEspelhoEntMerDev.PreencherCamposEspelhoNotaECamposDevolucao;
begin
  FCamposEspelhoNotaECamposDevolucao.Add('QTDITE', 'QTDDEV');
  FCamposEspelhoNotaECamposDevolucao.Add('CODITE', 'DET_CODITE');
  FCamposEspelhoNotaECamposDevolucao.Add('DESITE', 'DET_DESCRI');
  FCamposEspelhoNotaECamposDevolucao.Add('NUMDOC', 'DET_NUMDOC');
  FCamposEspelhoNotaECamposDevolucao.Add('EMPDOC', 'DET_CODEMP');
  FCamposEspelhoNotaECamposDevolucao.Add('CODFAB', 'ITE_CODFAB');
  FCamposEspelhoNotaECamposDevolucao.Add('VALITE', 'DET_UNITAR');
  FCamposEspelhoNotaECamposDevolucao.Add('PRECUS', 'DET_PRECUS');
  FCamposEspelhoNotaECamposDevolucao.Add('NUMLOT', 'DET_NUMLOT');
  FCamposEspelhoNotaECamposDevolucao.Add('CODFOR', 'DET_CODFOR');
  FCamposEspelhoNotaECamposDevolucao.Add('TABPRE', 'DET_TABPRE');
  FCamposEspelhoNotaECamposDevolucao.Add('LOTSAI', 'DET_NUMLOT');

end;

procedure TGerarEspelhoEntMerDev.PreencherDadosConsumidorFatVenda(aInput: TInputDadosConsumidorDTO);
var
  qryConsumidor: TUniQuery;
begin
  qryConsumidor := nil;
  try

    qryConsumidor := FEspelhoEntMerDevDAO.ObterDadosConsumidor(aInput);

    If Not fEmptyStr(qryConsumidor.FieldByName('GAG_NOMCON').AsString) Then
    Begin
      fatVenda.strCliNom := qryConsumidor.FieldByName('GAG_NOMCON').AsString; // Nome do Consumidor
      fatVenda.strCliEnd := qryConsumidor.FieldByName('GAG_ENDCON').AsString; // Endereço do Consumidor
      fatVenda.strCliBai := qryConsumidor.FieldByName('GAG_BAICON').AsString; // Bairro do Consumidor
      fatVenda.strCliCep := qryConsumidor.FieldByName('GAG_CEPCON').AsString; // Cep do Consumidor
      fatVenda.strCodCid := qryConsumidor.FieldByName('GAG_CIDCON').AsString; // Cidade do Consumidor
      fatVenda.strCliEst := qryConsumidor.FieldByName('GAG_ESTCON').AsString; // Estado do Consumidor
      fatVenda.strCliTel := qryConsumidor.FieldByName('GAG_TELCON').AsString; // Telefone do Consumidor


      fatVenda.intCgcCpf := qryConsumidor.FieldByName('GAG_CGCCPF').AsInteger; // CNPJ / CGC
      fatVenda.strCliCgc := qryConsumidor.FieldByName('GAG_CGCCON').AsString; // CNPJ / CGC do consumidor
      fatVenda.strCliIes := qryConsumidor.FieldByName('GAG_IESCON').AsString; // Inscrição estadual do Consumidor
      fatVenda.strCli_Rg := qryConsumidor.FieldByName('GAG_R_GCON').AsString; // Rg do Consumidor

      If (fCfgSis('PRECAD', varBoolean)) Then
        fatVenda.strCodAti := qryConsumidor.FieldByName('GAG_CODATI').AsString;
    End;
  finally
    FreeAndNil(qryConsumidor);
  end;
end;

end.


