unit untCadFis;
{*****************************************}
{* VALORES PARA ORIDOC:                  *}
{* V: VENDA(FATURAMENTO)                 *}
{* D: DEVOLUÇÃO PELA ENTRADA             *}
{* C: CADASTRO DE LIVRO FISCAL           *}
{* F: CONHECIMENTO DE FRETE              *}
{* "": ENTRADA NORMAL.                   *}
{**************************************MV*}

interface

uses
  Uni, untTypesSistema, untFuncFatTypes;

  function fGravaCadFis(Var strAutInc: String;
                        dtaDtaEnt: TDateTime;
                        strNumDoc,
                        strNumDo2,
                        strEspDoc,
                        strEntSai: String;
                        dtaDtaDoc: TDateTime;
                        strTip_Fc,
                        strForCli,
                        strHistor,
                        strNfComp,
                        strNotEsp,
                        strClfSc1: String;
                        fltVlCon1,
                        fltBasIc1,
                        fltAlqIc1,
                        fltVlrIc1,
                        fltOutra1,
                        fltIsent1,
                        fltRetid1,
                        fltBasIp1,
                        fltVlrIp1,
                        fltBcRet1,
                        fltDAces1,
                        fltValIs1: Double;
                        strClfSc2: String;
                        fltVlCon2,
                        fltBasIc2,
                        fltAlqIc2,
                        fltVlrIc2,
                        fltOutra2,
                        fltIsent2,
                        fltRetid2,
                        fltBasIp2,
                        fltVlrIp2,
                        fltBcRet2,
                        fltDAces2,
                        fltValIs2: Double;
                        strClfSc3: String;
                        fltVlCon3,
                        fltBasIc3,
                        fltAlqIc3,
                        fltVlrIc3,
                        fltOutra3,
                        fltIsent3,
                        fltRetid3,
                        fltBasIp3,
                        fltVlrIp3,
                        fltBcRet3,
                        fltDAces3,
                        fltValIs3: Double;
                        strClfSc4: String;
                        fltVlCon4,
                        fltBasIc4,
                        fltAlqIc4,
                        fltVlrIc4,
                        fltOutra4,
                        fltIsent4,
                        fltRetid4,
                        fltBasIp4,
                        fltVlrIp4,
                        fltBcRet4,
                        fltDAces4,
                        fltValIs4: Double;
                        strClfSc5: String;
                        fltVlCon5,
                        fltBasIc5,
                        fltAlqIc5,
                        fltVlrIc5,
                        fltOutra5,
                        fltIsent5,
                        fltRetid5,
                        fltBasIp5,
                        fltVlrIp5,
                        fltBcRet5,
                        fltDAces5,
                        fltValIs5,
                        fltTotPis,
                        fltTotCof,
                        fltBasPis,
                        fltBasCof,
                        fltAlqPis,
                        fltAlqCof: Double;
                        strCodEmp,
                        strSerie,
                        strEstado,
                        strNumSer,
                        strNumCoo,
                        strCodCon,
                        strDocCon: String;
                        strChaveAcesso: String;
                        strNumeroProtocolo,
                        strOriDoc: String;
                        strEmpAut: String = '';
                        fltImpMer: Double = 0;
                        fltImpSeg: Double = 0;
                        fltImpImp: Double = 0;
                        fltImpPro: Double = 0;
                        fltImpTax: Double = 0;
                        fltImpPis: Double = 0;
                        fltImpCof: Double = 0;
                        strImpIC1: String = '';
                        strImpIC2: String = '';
                        strModFre: String = '';
                        fltBasIss: Double = 0;
                        fltAlqIss: Double = 0;
                        fltValIss: Double = 0;
                        fltBaseII: Double = 0;
                        fltDesAdu: Double = 0;
                        fltValIOF: DOuble = 0;
                        fltBasAn1: Double = 0;
                        fltAntIc1: Double = 0;
                        fltBasAn2: Double = 0;
                        fltAntIc2: Double = 0;
                        fltBasAn3: Double = 0;
                        fltAntIc3: Double = 0;
                        fltBasAn4: Double = 0;
                        fltAntIc4: Double = 0;
                        fltBasAn5: Double = 0;
                        fltAntIc5: Double = 0;
                        strCstEnt: String = '';
                        blnGraCTP: Boolean = False;
                        fltBaeRe1: Double = 0;
                        fltVaeRe1: Double = 0;
                        fltBaeRe2: Double = 0;
                        fltVaeRe2: Double = 0;
                        fltBaeRe3: Double = 0;
                        fltVaeRe3: Double = 0;
                        fltBaeRe4: Double = 0;
                        fltVaeRe4: Double = 0;
                        fltBaeRe5: Double = 0;
                        fltVaeRe5: Double = 0;
                        fltBaeIP1: Double = 0;
                        fltVaeIP1: Double = 0;
                        fltBaeIP2: Double = 0;
                        fltVaeIP2: Double = 0;
                        fltBaeIP3: Double = 0;
                        fltVaeIP3: Double = 0;
                        fltBaeIP4: Double = 0;
                        fltVaeIP4: Double = 0;
                        fltBaeIP5: Double = 0;
                        fltVaeIP5: Double = 0;
                        strCtsPis: String = '';
                        strCtsCof: String = '';
                        strCodMod: String = '';
                        strVENCOM: String = '';
                        fltBFCPS1: Double = 0;
                        fltVFCPS1: Double = 0;
                        fltBFCPS2: Double = 0;
                        fltVFCPS2: Double = 0;
                        fltBFCPS3: Double = 0;
                        fltVFCPS3: Double = 0;
                        fltBFCPS4: Double = 0;
                        fltVFCPS4: Double = 0;
                        fltBFCPS5: Double = 0;
                        fltVFCPS5: Double = 0;
                        fltALQFCP: Double = 0;
                        fltTotRmm: Double = 0;
                        strCodTra: String = '';

                        fltIrSeRt: Double = 0; //FIS_REIRRF
                        fltPiSeRt: Double = 0; //FIS_VREPIS
                        fltCoSeRt: Double = 0; //FIS_VRECOF
                        fltCsSeRt: Double = 0; //FIS_RECSSL
                        fltRetISS: Double = 0; //FIS_RETISS
                        fltRetINS: Double = 0; //FIS_REINSS


                        fltBAFCP1: Double = 0;
                        fltVLFCP1: Double = 0;
                        fltBAFCP2: Double = 0;
                        fltVLFCP2: Double = 0;
                        fltBAFCP3: Double = 0;
                        fltVLFCP3: Double = 0;
                        fltBAFCP4: Double = 0;
                        fltVLFCP4: Double = 0;
                        fltBAFCP5: Double = 0;
                        fltVLFCP5: Double = 0;
                        strTipFre: String = '';
                        fltRFRBAS: Double = 0;
                        fltRFRALQ: Double = 0;
                        fltRFRVAL: Double = 0;
                        strCstIPI: String = '';
                        strNfCIAP: String = 'N';
                        fltPesCTE: Double = 0;
                        strEstornoNotaFiscal: String = '';
                        strEstornoNotaFiscalMotivo: String = '';
                        strNatOpe: String = '';
                        strTB01RE: String = '';
                        strTB06RE: String = '';
                        strBasFre: String = '';
                        blnDevSim: Boolean = False;
                        strCdsErv: String = '';
                        fltQBCMO1:  Double = 0;
                        fltQBCMO2:  Double = 0;
                        fltQBCMO3:  Double = 0;
                        fltQBCMO4:  Double = 0;
                        fltQBCMO5:  Double = 0;
                        fltQBCMO6:  Double = 0;
                        fltQBCMO7:  Double = 0;
                        fltQBCMO8:  Double = 0;
                        fltADREM1:  Double = 0;
                        fltADREM2:  Double = 0;
                        fltADREM3:  Double = 0;
                        fltADREM4:  Double = 0;
                        fltADREM5:  Double = 0;
                        fltADREM6:  Double = 0;
                        fltADREM7:  Double = 0;
                        fltADREM8:  Double = 0;
                        fltVALMO1:  Double = 0;
                        fltVALMO2:  Double = 0;
                        fltVALMO3:  Double = 0;
                        fltVALMO4:  Double = 0;
                        fltVALMO5:  Double = 0;
                        fltVALMO6:  Double = 0;
                        fltVALMO7:  Double = 0;
                        fltVALMO8:  Double = 0;
                        strNfsSub:  String = '';
                        strMesAno:  String = '';
                        strFinNfe:  String = '';
                        strFinTip:  String = '';
                        fltTotIbs:  Double = 0;
                        fltTotCbs:  Double = 0;
                        fltTotIs:   Double = 0;
                        fltTotProIs: Double = 0;
                        fltTotNf:   Double = 0;
                        strNumDPS:  String = '';
                        strSerDPS:  String = '';
                        strCodCCE:  String = ''; //FIS_CODCCE - Classe consumo energia eletrica (01..08)
                        strCodGRT:  String = ''; //FIS_CODGRT - Grupo de tensao (01..14)
                        pArrLivFis: PArrLivFis = Nil
                        ) : Boolean;
  procedure pGravaAuxFis(const strAutIncCadFis: String;
                         const arrLivFis: TArrLivFis;
                         const strCodEmp: String);

  function fGravaCadFisSimplificada(
                        Var strAutInc: String;
                        dtaDtaEnt: TDateTime;
                        strNumDoc,
                        strNumDo2,
                        strEspDoc,
                        strEntSai: String;
                        dtaDtaDoc: TDateTime;
                        strTip_Fc,
                        strForCli,
                        strHistor,
                        strNfComp,
                        strNotEsp,
                        strClfSc1: String;
                        fltVlCon1,
                        fltBasIc1,
                        fltAlqIc1,
                        fltVlrIc1,
                        fltOutra1,
                        fltIsent1,
                        fltRetid1,
                        fltBasIp1,
                        fltVlrIp1,
                        fltBcRet1,
                        fltDAces1,
                        fltValIs1: Double;
                        strClfSc2: String;
                        fltVlCon2,
                        fltBasIc2,
                        fltAlqIc2,
                        fltVlrIc2,
                        fltOutra2,
                        fltIsent2,
                        fltRetid2,
                        fltBasIp2,
                        fltVlrIp2,
                        fltBcRet2,
                        fltDAces2,
                        fltValIs2: Double;
                        strClfSc3: String;
                        fltVlCon3,
                        fltBasIc3,
                        fltAlqIc3,
                        fltVlrIc3,
                        fltOutra3,
                        fltIsent3,
                        fltRetid3,
                        fltBasIp3,
                        fltVlrIp3,
                        fltBcRet3,
                        fltDAces3,
                        fltValIs3: Double;
                        strClfSc4: String;
                        fltVlCon4,
                        fltBasIc4,
                        fltAlqIc4,
                        fltVlrIc4,
                        fltOutra4,
                        fltIsent4,
                        fltRetid4,
                        fltBasIp4,
                        fltVlrIp4,
                        fltBcRet4,
                        fltDAces4,
                        fltValIs4: Double;
                        strClfSc5: String;
                        fltVlCon5,
                        fltBasIc5,
                        fltAlqIc5,
                        fltVlrIc5,
                        fltOutra5,
                        fltIsent5,
                        fltRetid5,
                        fltBasIp5,
                        fltVlrIp5,
                        fltBcRet5,
                        fltDAces5,
                        fltValIs5,
                        fltTotPis,
                        fltTotCof,
                        fltBasPis,
                        fltBasCof,
                        fltAlqPis,
                        fltAlqCof: Double;
                        strCodEmp,
                        strSerie,
                        strEstado,
                        strNumSer,
                        strNumCoo,
                        strCodCon,
                        strDocCon: String;
                        strChaveAcesso: String;
                        strNumeroProtocolo,
                        strOriDoc: String;
                        const objParams: TCadFisParams): Boolean;

  function fGravaFisRef(
                        strSeqFis,
                        strCodEmp:  String;
                        strClatri:  String = '';
                        fltVlrCon:  Double = 0;
                        fltBasIs:   Double = 0;
                        fltCbsAlq:  Double = 0;
                        fltCbsDif:  Double = 0;
                        fltCbsRed:  Double = 0;
                        fltCbsVal:  Double = 0;
                        fltCbsVld:  Double = 0;
                        fltCbsVlr:  Double = 0;
                        fltCbsBas:  Double = 0;
                        fltCbsBad:  Double = 0;
                        fltCbsBar:  Double = 0;
                        fltIbsUfb:  Double = 0;
                        fltIbsUdb:  Double = 0;
                        fltIbsUrb:  Double = 0;
                        fltIbsUfa:  Double = 0;
                        fltIbsUfd:  Double = 0;
                        fltIbsUfr:  Double = 0;
                        fltIbsUfv:  Double = 0;
                        fltIbsUdv:  Double = 0;
                        fltIbsUrv:  Double = 0;
                        fltIbsMnb:  Double = 0;
                        fltIbsMdb:  Double = 0;
                        fltIbsMrb:  Double = 0;
                        fltIbsMna:  Double = 0;
                        fltIbsMnd:  Double = 0;
                        fltIbsMnr:  Double = 0;
                        fltIbsMnv:  Double = 0;
                        fltIbsMdv:  Double = 0;
                        fltIbsMrv:  Double = 0) : Boolean;


implementation

uses SysUtils, Variants, untfuncoesSimples;

procedure pGravaAuxFis(const strAutIncCadFis: String;
                       const arrLivFis: TArrLivFis;
                       const strCodEmp: String);
  Var
    qryAuxFis: TUniQuery;
    intBloco: Integer;
    strSufixo: String;
Begin
  If fEmptyStr(strAutIncCadFis) Then
    Exit;

  If Not fTabelaExiste('AUXFIS', True) Then
    Exit;

  qryAuxFis := fCriaQuery;
  Try
    qryAuxFis.SQL.Text := 'SELECT * FROM AUXFIS WHERE FALSE';
    qryAuxFis.Open;
    qryAuxFis.Insert;

    qryAuxFis.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('AUXFIS', strCodEmp);
    qryAuxFis.FieldByName('FIS_SEQFIS').AsString := strAutIncCadFis;

    For intBloco := Low(arrLivFis) To High(arrLivFis) Do
    Begin
      strSufixo := IntToStr(intBloco);

      qryAuxFis.FieldByName('FIS_BCCBS' + strSufixo).AsFloat := arrLivFis[intBloco].fltBasCbs;
      qryAuxFis.FieldByName('FIS_VLCBS' + strSufixo).AsFloat := arrLivFis[intBloco].fltVlrCbs;
      qryAuxFis.FieldByName('FIS_BCIBS' + strSufixo).AsFloat := arrLivFis[intBloco].fltBasIbs;
      qryAuxFis.FieldByName('FIS_VLIBS' + strSufixo).AsFloat := arrLivFis[intBloco].fltVlrIbs;
      qryAuxFis.FieldByName('FIS_BC_IS' + strSufixo).AsFloat := arrLivFis[intBloco].fltBas_IS;
      qryAuxFis.FieldByName('FIS_VL_IS' + strSufixo).AsFloat := arrLivFis[intBloco].fltVlr_IS;
    End;

    qryAuxFis.Post;
  Finally
    FreeAndNil(qryAuxFis);
  End;
End;

function fGravaCadFis(Var strAutInc: String;
                      dtaDtaEnt: TDateTime;
                      strNumDoc,
                      strNumDo2,
                      strEspDoc,
                      strEntSai: String;
                      dtaDtaDoc: TDateTime;
                      strTip_Fc,
                      strForCli,
                      strHistor,
                      strNfComp,
                      strNotEsp,
                      strClfSc1: String;
                      fltVlCon1,
                      fltBasIc1,
                      fltAlqIc1,
                      fltVlrIc1,
                      fltOutra1,
                      fltIsent1,
                      fltRetid1,
                      fltBasIp1,
                      fltVlrIp1,
                      fltBcRet1,
                      fltDAces1,
                      fltValIs1: Double;
                      strClfSc2: String;
                      fltVlCon2,
                      fltBasIc2,
                      fltAlqIc2,
                      fltVlrIc2,
                      fltOutra2,
                      fltIsent2,
                      fltRetid2,
                      fltBasIp2,
                      fltVlrIp2,
                      fltBcRet2,
                      fltDAces2,
                      fltValIs2: Double;
                      strClfSc3: String;
                      fltVlCon3,
                      fltBasIc3,
                      fltAlqIc3,
                      fltVlrIc3,
                      fltOutra3,
                      fltIsent3,
                      fltRetid3,
                      fltBasIp3,
                      fltVlrIp3,
                      fltBcRet3,
                      fltDAces3,
                      fltValIs3: Double;
                      strClfSc4: String;
                      fltVlCon4,
                      fltBasIc4,
                      fltAlqIc4,
                      fltVlrIc4,
                      fltOutra4,
                      fltIsent4,
                      fltRetid4,
                      fltBasIp4,
                      fltVlrIp4,
                      fltBcRet4,
                      fltDAces4,
                      fltValIs4: Double;
                      strClfSc5: String;
                      fltVlCon5,
                      fltBasIc5,
                      fltAlqIc5,
                      fltVlrIc5,
                      fltOutra5,
                      fltIsent5,
                      fltRetid5,
                      fltBasIp5,
                      fltVlrIp5,
                      fltBcRet5,
                      fltDAces5,
                      fltValIs5,
                      fltTotPis,
                      fltTotCof,
                      fltBasPis,
                      fltBasCof,
                      fltAlqPis,
                      fltAlqCof: Double;
                      strCodEmp,
                      strSerie,
                      strEstado,
                      strNumSer,
                      strNumCoo,
                      strCodCon,
                      strDocCon: String;
                      strChaveAcesso: String;
                      strNumeroProtocolo,
                      strOriDoc: String;
                      strEmpAut: String = '';
                      fltImpMer: Double = 0;
                      fltImpSeg: Double = 0;
                      fltImpImp: Double = 0;
                      fltImpPro: Double = 0;
                      fltImpTax: Double = 0;
                      fltImpPis: Double = 0;
                      fltImpCof: Double = 0;
                      strImpIC1: String = '';
                      strImpIC2: String = '';
                      strModFre: String = '';
                      fltBasIss: Double = 0;
                      fltAlqIss: Double = 0;
                      fltValIss: Double = 0;
                      fltBaseII: Double = 0;
                      fltDesAdu: Double = 0;
                      fltValIOF: DOuble = 0;
                      fltBasAn1: Double = 0;
                      fltAntIc1: Double = 0;
                      fltBasAn2: Double = 0;
                      fltAntIc2: Double = 0;
                      fltBasAn3: Double = 0;
                      fltAntIc3: Double = 0;
                      fltBasAn4: Double = 0;
                      fltAntIc4: Double = 0;
                      fltBasAn5: Double = 0;
                      fltAntIc5: Double = 0;
                      strCstEnt: String = '';
                      blnGraCTP: Boolean = False;
                      fltBaeRe1: Double = 0;
                      fltVaeRe1: Double = 0;
                      fltBaeRe2: Double = 0;
                      fltVaeRe2: Double = 0;
                      fltBaeRe3: Double = 0;
                      fltVaeRe3: Double = 0;
                      fltBaeRe4: Double = 0;
                      fltVaeRe4: Double = 0;
                      fltBaeRe5: Double = 0;
                      fltVaeRe5: Double = 0;
                      fltBaeIP1: Double = 0;
                      fltVaeIP1: Double = 0;
                      fltBaeIP2: Double = 0;
                      fltVaeIP2: Double = 0;
                      fltBaeIP3: Double = 0;
                      fltVaeIP3: Double = 0;
                      fltBaeIP4: Double = 0;
                      fltVaeIP4: Double = 0;
                      fltBaeIP5: Double = 0;
                      fltVaeIP5: Double = 0;
                      strCtsPis: String = '';
                      strCtsCof: String = '';
                      strCodMod: String = '';
                      strVENCOM: String = '';
                      fltBFCPS1: Double = 0;
                      fltVFCPS1: Double = 0;
                      fltBFCPS2: Double = 0;
                      fltVFCPS2: Double = 0;
                      fltBFCPS3: Double = 0;
                      fltVFCPS3: Double = 0;
                      fltBFCPS4: Double = 0;
                      fltVFCPS4: Double = 0;
                      fltBFCPS5: Double = 0;
                      fltVFCPS5: Double = 0;
                      fltALQFCP: Double = 0;
                      fltTotRmm: Double = 0;
                      strCodTra: String = '';

                      fltIrSeRt: Double = 0; //FIS_REIRRF
                      fltPiSeRt: Double = 0; //FIS_VREPIS
                      fltCoSeRt: Double = 0; //FIS_VRECOF
                      fltCsSeRt: Double = 0; //FIS_RECSSL
                      fltRetISS: Double = 0; //FIS_RETISS
                      fltRetINS: Double = 0; //FIS_REINSS


                      fltBAFCP1: Double = 0;
                      fltVLFCP1: Double = 0;
                      fltBAFCP2: Double = 0;
                      fltVLFCP2: Double = 0;
                      fltBAFCP3: Double = 0;
                      fltVLFCP3: Double = 0;
                      fltBAFCP4: Double = 0;
                      fltVLFCP4: Double = 0;
                      fltBAFCP5: Double = 0;
                      fltVLFCP5: Double = 0;
                      strTipFre: String = '';
                      fltRFRBAS: Double = 0;
                      fltRFRALQ: Double = 0;
                      fltRFRVAL: Double = 0;
                      strCstIPI: String = '';
                      strNfCIAP: String = 'N';
                      fltPesCTE: Double = 0;
                      strEstornoNotaFiscal: String = '';
                      strEstornoNotaFiscalMotivo: String = '';
                      strNatOpe: String = '';
                      strTB01RE: String = '';
                      strTB06RE: String = '';
                      strBasFre: String = '';
                      blnDevSim: Boolean = False;
                      strCdsErv: String = '';
                      fltQBCMO1:  Double = 0;
                      fltQBCMO2:  Double = 0;
                      fltQBCMO3:  Double = 0;
                      fltQBCMO4:  Double = 0;
                      fltQBCMO5:  Double = 0;
                      fltQBCMO6:  Double = 0;
                      fltQBCMO7:  Double = 0;
                      fltQBCMO8:  Double = 0;
                      fltADREM1:  Double = 0;
                      fltADREM2:  Double = 0;
                      fltADREM3:  Double = 0;
                      fltADREM4:  Double = 0;
                      fltADREM5:  Double = 0;
                      fltADREM6:  Double = 0;
                      fltADREM7:  Double = 0;
                      fltADREM8:  Double = 0;
                      fltVALMO1:  Double = 0;
                      fltVALMO2:  Double = 0;
                      fltVALMO3:  Double = 0;
                      fltVALMO4:  Double = 0;
                      fltVALMO5:  Double = 0;
                      fltVALMO6:  Double = 0;
                      fltVALMO7:  Double = 0;
                      fltVALMO8:  Double = 0;
                      strNfsSub:  String = '';
                      strMesAno:  String = '';
                      strFinNfe:  String = '';
                      strFinTip:  String = '';
                      fltTotIbs:  Double = 0;
                      fltTotCbs:  Double = 0;
                      fltTotIs:   Double = 0;
                      fltTotProIs: Double = 0;
                      fltTotNf:   Double = 0;
                      strNumDPS:  String = '';
                      strSerDPS:  String = '';
                      strCodCCE:  String = ''; //FIS_CODCCE - Classe consumo energia eletrica (01..08)
                      strCodGRT:  String = ''; //FIS_CODGRT - Grupo de tensao (01..14)
                      pArrLivFis: PArrLivFis = Nil
                      ) : Boolean;

  Var
    qryCadFis: TUniQuery;
    RegistroContabilidade: TrecRegistroContabilidade;

Begin
  Result := True;

  If (fltBasIc1 = 0.0) Then
    fltAlqIc1 := 0.0;

  If (fltBasIc2 = 0.0) Then
    fltAlqIc2 := 0.0;

  If (fltBasIc3 = 0.0) Then
    fltAlqIc3 := 0.0;

  If (fltBasIc4 = 0.0) Then
    fltAlqIc4 := 0.0;

  If (fltBasIc5 = 0.0) Then
    fltAlqIc5 := 0.0;


  If fEmptyStr(strCodMod) And  (Not fEmptyStr(strChaveAcesso)) Then
    strCodMod := Copy(strChaveAcesso, 21, 2);

  Try
    qryCadFis := fCriarQuery('SELECT * FROM CADFIS WHERE FALSE');

    If fEmptyStr(strEmpAut) Then
      strAutInc := fRetAutoIncrem('CADFIS', strCodEmp)
    Else
      strAutInc := fRetAutoIncrem('CADFIS', strEmpAut);

    With qryCadFis Do
    Begin
      Open;
      Insert;

      If (dtaDtaEnt = 0) Then
        FieldByName('FIS_DTAENT').Clear
      Else
        FieldByName('FIS_DTAENT').AsDateTime := dtaDtaEnt;

      FieldByName('FIS_NUMDOC').AsString   := strNumDoc;
      FieldByName('FIS_NUMDO2').AsString   := strNumDo2;
      FieldByName('FIS_ESPDOC').AsString   := strEspDoc;
      FieldByName('FIS_ENTSAI').AsString   := strEntSai;
      FieldByName('FIS_DTADOC').AsDateTime := dtaDtaDoc;
      FieldByName('FIS_TIP_FC').AsString   := strTip_Fc;
      FieldByName('FIS_FORCLI').AsString   := strForCli;
      FieldByName('FIS_HISTOR').AsString   := strHistor;
      FieldByName('FIS_NFCOMP').AsString   := strNfComp;
      FieldByName('FIS_NOTESP').AsString   := strNotEsp;
      FieldByName('FIS_CLFSC1').AsString   := strClfSc1;
      FieldByName('FIS_VLCON1').AsFloat    := fltVlCon1;
      FieldByName('FIS_BASIC1').AsFloat    := fltBasIc1;
      FieldByName('FIS_ALQIC1').AsFloat    := fltAlqIc1;
      FieldByName('FIS_VLRIC1').AsFloat    := fltVlrIc1;
      FieldByName('FIS_OUTRA1').AsFloat    := IIF(fltOutra1 < 0, 0, fltOutra1);
      FieldByName('FIS_ISENT1').AsFloat    := fltIsent1;
      FieldByName('FIS_RETID1').AsFloat    := fltRetid1;
      FieldByName('FIS_BASIP1').AsFloat    := fltBasIp1;
      FieldByName('FIS_VLRIP1').AsFloat    := fltVlrIp1;
      FieldByName('FIS_BCRET1').AsFloat    := fltBcRet1;
      FieldByName('FIS_DACES1').AsFloat    := fltDAces1;
      FieldByName('FIS_VALIS1').AsFloat    := fltValIs1;
      FieldByName('FIS_CLFSC2').AsString   := strClfSc2;
      FieldByName('FIS_VLCON2').AsFloat    := fltVlCon2;
      FieldByName('FIS_BASIC2').AsFloat    := fltBasIc2;
      FieldByName('FIS_ALQIC2').AsFloat    := fltAlqIc2;
      FieldByName('FIS_VLRIC2').AsFloat    := fltVlrIc2;
      FieldByName('FIS_OUTRA2').AsFloat    := IIF(fltOutra2 < 0, 0, fltOutra2);
      FieldByName('FIS_ISENT2').AsFloat    := fltIsent2;
      FieldByName('FIS_RETID2').AsFloat    := fltRetid2;
      FieldByName('FIS_BASIP2').AsFloat    := fltBasIp2;
      FieldByName('FIS_VLRIP2').AsFloat    := fltVlrIp2;
      FieldByName('FIS_BCRET2').AsFloat    := fltBcRet2;
      FieldByName('FIS_DACES2').AsFloat    := fltDAces2;
      FieldByName('FIS_VALIS2').AsFloat    := fltValIs2;
      FieldByName('FIS_CLFSC3').AsString   := strClfSc3;
      FieldByName('FIS_VLCON3').AsFloat    := fltVlCon3;
      FieldByName('FIS_BASIC3').AsFloat    := fltBasIc3;
      FieldByName('FIS_ALQIC3').AsFloat    := fltAlqIc3;
      FieldByName('FIS_VLRIC3').AsFloat    := fltVlrIc3;
      FieldByName('FIS_OUTRA3').AsFloat    := IIF(fltOutra3 < 0, 0, fltOutra3);
      FieldByName('FIS_ISENT3').AsFloat    := fltIsent3;
      FieldByName('FIS_RETID3').AsFloat    := fltRetid3;
      FieldByName('FIS_BASIP3').AsFloat    := fltBasIp3;
      FieldByName('FIS_VLRIP3').AsFloat    := fltVlrIp3;
      FieldByName('FIS_BCRET3').AsFloat    := fltBcRet3;
      FieldByName('FIS_DACES3').AsFloat    := fltDAces3;
      FieldByName('FIS_VALIS3').AsFloat    := fltValIs3;
      FieldByName('FIS_CLFSC4').AsString   := strClfSc4;
      FieldByName('FIS_VLCON4').AsFloat    := fltVlCon4;
      FieldByName('FIS_BASIC4').AsFloat    := fltBasIc4;
      FieldByName('FIS_ALQIC4').AsFloat    := fltAlqIc4;
      FieldByName('FIS_VLRIC4').AsFloat    := fltVlrIc4;
      FieldByName('FIS_OUTRA4').AsFloat    := IIF(fltOutra4 < 0, 0, fltOutra4);
      FieldByName('FIS_ISENT4').AsFloat    := fltIsent4;
      FieldByName('FIS_RETID4').AsFloat    := fltRetid4;
      FieldByName('FIS_BASIP4').AsFloat    := fltBasIp4;
      FieldByName('FIS_VLRIP4').AsFloat    := fltVlrIp4;
      FieldByName('FIS_BCRET4').AsFloat    := fltBcRet4;
      FieldByName('FIS_DACES4').AsFloat    := fltDAces4;
      FieldByName('FIS_VALIS4').AsFloat    := fltValIs4;
      FieldByName('FIS_CLFSC5').AsString   := strClfSc5;
      FieldByName('FIS_VLCON5').AsFloat    := fltVlCon5;
      FieldByName('FIS_BASIC5').AsFloat    := fltBasIc5;
      FieldByName('FIS_ALQIC5').AsFloat    := fltAlqIc5;
      FieldByName('FIS_VLRIC5').AsFloat    := fltVlrIc5;
      FieldByName('FIS_OUTRA5').AsFloat    := IIF(fltOutra5 < 0, 0, fltOutra5);
      FieldByName('FIS_ISENT5').AsFloat    := fltIsent5;
      FieldByName('FIS_RETID5').AsFloat    := fltRetid5;
      FieldByName('FIS_BASIP5').AsFloat    := fltBasIp5;
      FieldByName('FIS_VLRIP5').AsFloat    := fltVlrIp5;
      FieldByName('FIS_BCRET5').AsFloat    := fltBcRet5;
      FieldByName('FIS_DACES5').AsFloat    := fltDAces5;
      FieldByName('FIS_VALIS5').AsFloat    := fltValIs5;
      FieldByName('FIS_CODEMP').AsString   := strCodEmp;
      FieldByName('FIS_ESTADO').AsString   := strEstado;
      FieldByName('AUTOINCREM').AsString   := strAutInc;

      FieldByName('FIS_TOTPIS').AsFloat    := fltTotPis;
      FieldByName('FIS_TOTCOF').AsFloat    := fltTotCof;

      FieldByName('FIS_BASPIS').AsFloat    := fltBasPis;
      FieldByName('FIS_BASCOF').AsFloat    := fltBasCof;

      FieldByName('FIS_ALQPIS').AsFloat    := fltAlqPis;
      FieldByName('FIS_ALQCOF').AsFloat    := fltAlqCof;

      FieldByName('FIS_CSTPIS').AsString   := strCtsPis;
      FieldByName('FIS_CSTCOF').AsString   := strCtsCof;

      FieldByName('FIS_REIRRF').AsFloat    := fltIrSeRt;
      FieldByName('FIS_VREPIS').AsFloat    := fltPiSeRt;
      FieldByName('FIS_VRECOF').AsFloat    := fltCoSeRt;
      FieldByName('FIS_RECSSL').AsFloat    := fltCsSeRt;
      FieldByName('FIS_RETISS').AsFloat    := fltRetISS;
      FieldByName('FIS_REINSS').AsFloat    := fltRetINS;

      If fEmptyStr(strSerie) Then
        FieldByName('FIS_SERIE_').AsString := ''
      Else
        FieldByName('FIS_SERIE_').AsString   := strSerie;

      If (fEmptyStr(strNumSer)) Then
        FieldByName('FIS_NUMSER').Value := Null
      Else
        FieldByName('FIS_NUMSER').AsString := strNumSer;

      If (fEmptyStr(strNumCoo)) Then
        FieldByName('FIS_NUMCOO').Value := Null
      Else
        FieldByName('FIS_NUMCOO').AsString := strNumCoo;


      If strCodCon = '00' Then
        strCodCon := '';

      FieldByName('FIS_CODCON').AsString := strCodCon;
      FieldByName('FIS_DOCCON').AsString := strDocCon;

      If fEmptyStr(FieldByName('FIS_CODCON').AsString) Then
        FieldByName('FIS_CODCON').Clear;

      {*******************************************}
      {* NOTA FISCAL ELETRONICA                  *}
      {****************************************PH*}
      FieldByName('FIS_ACESSO').AsString := strChaveAcesso;
      FieldByName('FIS_PROTOC').AsString := strNumeroProtocolo;

      FieldByName('FIS_ORIDOC').AsString := strOriDoc;

      FieldByName('FIS_IMPMER').AsFloat  := fltImpMer;
      FieldByName('FIS_IMPSEG').AsFloat  := fltImpSeg;
      FieldByName('FIS_IMPIMP').AsFloat  := fltImpImp;
      FieldByName('FIS_IMPPRO').AsFloat  := fltImpPro;
      FieldByName('FIS_IMPTAX').AsFloat  := fltImpTax;
      FieldByName('FIS_IMPPIS').AsFloat  := fltImpPis;
      FieldByName('FIS_IMPCOF').AsFloat  := fltImpCof;
      FieldByName('FIS_IMPIC1').AsString := strImpIC1;
      FieldByName('FIS_IMPIC2').AsString := strImpIC2;

      if fCfgSis('LIMCNH', varInteger) > 0 then
      begin
        If (Pos(strClfSc1, VS_strClaVen) > 0) And (Pos(strClfSc1, VS_strClaDev) <= 0) and (not fEmptyStr(strCodTra)) Then
          FieldByName('FIS_CNHREC').AsString := IIF(fCampoTabela('TRA_CNHREC','CADTRA', ['TRA_CODTRA'], [strCodTra]) = 'S','N','S')
        else
          FieldByName('FIS_CNHREC').AsString := 'S';
      end
      else
        FieldByName('FIS_CNHREC').AsString := 'N';

      FieldByName('FIS_MODFRE').AsString := strModFre;

      If (fltBasIss = 0) Then
        FieldByName('FIS_BASISS').Value := Null
      Else
        FieldByName('FIS_BASISS').AsFloat := fltBasIss;

      If (fltAlqIss = 0) Then
        FieldByName('FIS_ALQISS').Value := Null
      Else
        FieldByName('FIS_ALQISS').AsFloat := fltAlqIss;

      If (fltValIss = 0) Then
        FieldByName('FIS_VALISS').Value := Null
      Else
        FieldByName('FIS_VALISS').AsFloat := fltValIss;

      FieldByName('FIS_BASEII').AsFloat  := fltBaseII;
      FieldByName('FIS_DESADU').AsFloat  := fltDesAdu;
      FieldByName('FIS_VALIOF').AsFloat  := fltValIOF;

      FieldByName('FIS_BASAN1').AsFloat  := fltBasAn1;
      FieldByName('FIS_ANTIC1').AsFloat  := fltAntIc1;
      FieldByName('FIS_BASAN2').AsFloat  := fltBasAn2;
      FieldByName('FIS_ANTIC2').AsFloat  := fltAntIc2;
      FieldByName('FIS_BASAN3').AsFloat  := fltBasAn3;
      FieldByName('FIS_ANTIC3').AsFloat  := fltAntIc3;
      FieldByName('FIS_BASAN4').AsFloat  := fltBasAn4;
      FieldByName('FIS_ANTIC4').AsFloat  := fltAntIc4;
      FieldByName('FIS_BASAN5').AsFloat  := fltBasAn5;
      FieldByName('FIS_ANTIC5').AsFloat  := fltAntIc5;
      FieldByName('FIS_CSTENT').AsString := strCstEnt;
      FieldByName('FIS_GRACTP').AsString := IIf(blnGraCtp, 'S', 'N');
      FieldByName('FIS_BAERE1').AsFloat  := fltBaeRe1;
      FieldByName('FIS_BAEIP1').AsFloat  := fltBaeIP1;
      FieldByName('FIS_VAERE1').AsFloat  := fltVaeRe1;
      FieldByName('FIS_VAEIP1').AsFloat  := fltVaeIP1;

      FieldByName('FIS_BAERE2').AsFloat  := fltBaeRe2;
      FieldByName('FIS_BAEIP2').AsFloat  := fltBaeIP2;
      FieldByName('FIS_VAERE2').AsFloat  := fltVaeRe2;
      FieldByName('FIS_VAEIP2').AsFloat  := fltVaeIP2;

      FieldByName('FIS_BAERE3').AsFloat  := fltBaeRe3;
      FieldByName('FIS_BAEIP3').AsFloat  := fltBaeIP3;
      FieldByName('FIS_VAERE3').AsFloat  := fltVaeRe3;
      FieldByName('FIS_VAEIP3').AsFloat  := fltVaeIP3;

      FieldByName('FIS_BAERE4').AsFloat  := fltBaeRe4;
      FieldByName('FIS_BAEIP4').AsFloat  := fltBaeIP4;
      FieldByName('FIS_VAERE4').AsFloat  := fltVaeRe4;
      FieldByName('FIS_VAEIP4').AsFloat  := fltVaeIP4;

      FieldByName('FIS_BAERE5').AsFloat  := fltBaeRe5;
      FieldByName('FIS_BAEIP5').AsFloat  := fltBaeIP5;
      FieldByName('FIS_VAERE5').AsFloat  := fltVaeRe5;
      FieldByName('FIS_VAEIP5').AsFloat  := fltVaeIP5;

      FieldByName('FIS_BFCPS1').AsFloat  := fltBFCPS1;
      FieldByName('FIS_VFCPS1').AsFloat  := fltVFCPS1;
      FieldByName('FIS_BFCPS2').AsFloat  := fltBFCPS2;
      FieldByName('FIS_VFCPS2').AsFloat  := fltVFCPS2;
      FieldByName('FIS_BFCPS3').AsFloat  := fltBFCPS3;
      FieldByName('FIS_VFCPS3').AsFloat  := fltVFCPS3;
      FieldByName('FIS_BFCPS4').AsFloat  := fltBFCPS4;
      FieldByName('FIS_VFCPS4').AsFloat  := fltVFCPS4;
      FieldByName('FIS_BFCPS5').AsFloat  := fltBFCPS5;
      FieldByName('FIS_VFCPS5').AsFloat  := fltVFCPS5;

      FieldByName('FIS_BAFCP1').AsFloat  := fltBAFCP1;
      FieldByName('FIS_VLFCP1').AsFloat  := fltVLFCP1;
      FieldByName('FIS_BAFCP2').AsFloat  := fltBAFCP2;
      FieldByName('FIS_VLFCP2').AsFloat  := fltVLFCP2;
      FieldByName('FIS_BAFCP3').AsFloat  := fltBAFCP3;
      FieldByName('FIS_VLFCP3').AsFloat  := fltVLFCP3;
      FieldByName('FIS_BAFCP4').AsFloat  := fltBAFCP4;
      FieldByName('FIS_VLFCP4').AsFloat  := fltVLFCP4;
      FieldByName('FIS_BAFCP5').AsFloat  := fltBAFCP5;
      FieldByName('FIS_VLFCP5').AsFloat  := fltVLFCP5;
      FieldByName('FIS_TIPFRE').AsString  := strTipFre;
      FieldByName('FIS_PESCTE').AsFloat  := fltPesCTE;
      FieldByName('FIS_CTEPES').AsFloat  := fltPesCTE;
	  

      FieldByName('FIS_ALQFCP').AsFloat  := fltALQFCP;

      If (fEmptyStr(strCodMod)) Then
        FieldByName('FIS_CODMOD').Value := Null
      Else
        FieldByName('FIS_CODMOD').AsString := strCodMod;
      If Not fEmptyStr(strVENCOM) Then
        FieldByName('FIS_VENCOM').AsString := strVenCom
      Else
        FieldByName('FIS_VENCOM').Value  := Null;

      if fCampoExiste('CADFIS', 'FIS_VAFRMM', True) then
      begin
        FieldByName('FIS_VAFRMM').AsFloat := fltTotRmm;
      end;

      FieldByName('FIS_RFRBAS').AsFloat  := fltRFRBAS;
      FieldByName('FIS_RFRALQ').AsFloat  := fltRFRALQ;
      FieldByName('FIS_RFRVAL').AsFloat  := fltRFRVAL;

      FieldByName('FIS_CSTIPI').AsString := strCstIPI;
      FieldByName('FIS_NFCIAP').AsString := strNfCIAP;

      FieldByName('FIS_ESTNFE').AsString := strEstornoNotaFiscal;
      FieldByName('FIS_ESTMOT').AsString := strEstornoNotaFiscalMotivo;
      FieldByName('FIS_NATOPE').AsString := strNatOpe;

      FieldByName('FIS_TB01RE').AsString := strTB01RE;
      FieldByName('FIS_TB06RE').AsString := strTB06RE;

      If (Not fEmptyStr(strBasFre)) Then
        FieldByName('FIS_CODBFR').AsString := strBasFre;

      If FindField('FIS_QBCMO1') <> nil Then
        FieldByName('FIS_QBCMO1').AsFloat  := fltQBCMO1;
      If FindField('FIS_QBCMO2') <> nil Then
        FieldByName('FIS_QBCMO2').AsFloat  := fltQBCMO2;
      If FindField('FIS_QBCMO3') <> nil Then
        FieldByName('FIS_QBCMO3').AsFloat  := fltQBCMO3;
      If FindField('FIS_QBCMO4') <> nil Then
        FieldByName('FIS_QBCMO4').AsFloat  := fltQBCMO4;
      If FindField('FIS_QBCMO5') <> nil Then
        FieldByName('FIS_QBCMO5').AsFloat  := fltQBCMO5;
      If FindField('FIS_QBCMO6') <> nil Then
        FieldByName('FIS_QBCMO6').AsFloat  := fltQBCMO6;
      If FindField('FIS_QBCMO7') <> nil Then
        FieldByName('FIS_QBCMO7').AsFloat  := fltQBCMO7;
      If FindField('FIS_QBCMO8') <> nil Then
        FieldByName('FIS_QBCMO8').AsFloat  := fltQBCMO8;

      If FindField('FIS_ADREM1') <> nil Then
        FieldByName('FIS_ADREM1').AsFloat  := fltADREM1;
      If FindField('FIS_ADREM2') <> nil Then
        FieldByName('FIS_ADREM2').AsFloat  := fltADREM2;
      If FindField('FIS_ADREM3') <> nil Then
        FieldByName('FIS_ADREM3').AsFloat  := fltADREM3;
      If FindField('FIS_ADREM4') <> nil Then
        FieldByName('FIS_ADREM4').AsFloat  := fltADREM4;
      If FindField('FIS_ADREM5') <> nil Then
        FieldByName('FIS_ADREM5').AsFloat  := fltADREM5;
      If FindField('FIS_ADREM6') <> nil Then
        FieldByName('FIS_ADREM6').AsFloat  := fltADREM6;
      If FindField('FIS_ADREM7') <> nil Then
        FieldByName('FIS_ADREM7').AsFloat  := fltADREM7;
      If FindField('FIS_ADREM8') <> nil Then
        FieldByName('FIS_ADREM8').AsFloat  := fltADREM8;

      If FindField('FIS_VALMO1') <> nil Then
        FieldByName('FIS_VALMO1').AsFloat  := fltVALMO1;
      If FindField('FIS_VALMO2') <> nil Then
        FieldByName('FIS_VALMO2').AsFloat  := fltVALMO2;
      If FindField('FIS_VALMO3') <> nil Then
        FieldByName('FIS_VALMO3').AsFloat  := fltVALMO3;
      If FindField('FIS_VALMO4') <> nil Then
        FieldByName('FIS_VALMO4').AsFloat  := fltVALMO4;
      If FindField('FIS_VALMO5') <> nil Then
        FieldByName('FIS_VALMO5').AsFloat  := fltVALMO5;
      If FindField('FIS_VALMO6') <> nil Then
        FieldByName('FIS_VALMO6').AsFloat  := fltVALMO6;
      If FindField('FIS_VALMO7') <> nil Then
        FieldByName('FIS_VALMO7').AsFloat  := fltVALMO7;
      If FindField('FIS_VALMO8') <> nil Then
        FieldByName('FIS_VALMO8').AsFloat  := fltVALMO8;

      If FindField('FIS_NFSSUB') <> nil Then
        FieldByName('FIS_NFSSUB').AsString := strNfsSub;

      If FindField('FIS_MESANO') <> nil Then
        FieldByName('FIS_MESANO').AsString := strMesAno;

      If FindField('FIS_FINNFE') <> nil Then
        FieldByName('FIS_FINNFE').AsString := strFinNfe;

      If FindField('FIS_TIPFIN') <> nil Then
        FieldByName('FIS_TIPFIN').AsString := strFinTip;

      qryCadFis.FieldByName('FIS_TOTIBS').AsFloat := fltTotIbs;
      qryCadFis.FieldByName('FIS_TOTCBS').AsFloat := fltTotCbs;
      qryCadFis.FieldByName('FIS_TOT_IS').AsFloat := fltTotIs;
      qryCadFis.FieldByName('FIS_TPROIS').AsFloat := fltTotProIs;
      qryCadFis.FieldByName('FIS_TOT_NF').AsFloat := fltTotNf;

      If FindField('FIS_CDSERV') <> nil Then
      Begin
        qryCadFis.FieldByName('FIS_CDSERV').Clear;
        If Not fEmptyStr(strCdsErv) Then
          FieldByName('FIS_CDSERV').AsString := strCdsErv;
      End;

      If FindField('FIS_NUMDPS') <> nil Then
      Begin
        qryCadFis.FieldByName('FIS_NUMDPS').Clear;
        If Not fEmptyStr(strNumDPS) Then
          FieldByName('FIS_NUMDPS').AsString := strNumDPS;
      End;

      If FindField('FIS_SERDPS') <> nil Then
      Begin
        qryCadFis.FieldByName('FIS_SERDPS').Clear;
        If Not fEmptyStr(strSerDPS) Then
          FieldByName('FIS_SERDPS').AsString := strSerDPS;
      End;

      If FindField('FIS_CODCCE') <> Nil Then
      Begin
        qryCadFis.FieldByName('FIS_CODCCE').Clear;
        If Not fEmptyStr(strCodCCE) Then
          FieldByName('FIS_CODCCE').AsString := strCodCCE;
      End;

      If FindField('FIS_CODGRT') <> Nil Then
      Begin
        qryCadFis.FieldByName('FIS_CODGRT').Clear;
        If Not fEmptyStr(strCodGRT) Then
          FieldByName('FIS_CODGRT').AsString := strCodGRT;
      End;
      Post;
    End;

    If Assigned(pArrLivFis) Then
      pGravaAuxFis(strAutInc, pArrLivFis^, IIF(fEmptyStr(strEmpAut), strCodEmp, strEmpAut));

    RegistroContabilidade.ttpTabela := ttCadFis;
    RegistroContabilidade.strClafis := strClfSc1;
    RegistroContabilidade.strEspDoc := strEspDoc;
    RegistroContabilidade.strSeqGer := strAutInc;
    RegistroContabilidade.mlModLan := mlInclusao;
    RegistroContabilidade.strEmpLan := strCodEmp;
    pGravaRegistroContabilidade(RegistroContabilidade);

    FreeAndNil(qryCadFis);

  Except
    On E: Exception Do
    Begin
      If Assigned(qryCadFis) Then
        qryCadFis.Cancel;
      pMensagensErro(E.Message, '[fGravaCadFis]');
      Result := False;
      Raise;
    End;
  End;
End;

function fGravaCadFisSimplificada(
                        Var strAutInc: String;
                        dtaDtaEnt: TDateTime;
                        strNumDoc,
                        strNumDo2,
                        strEspDoc,
                        strEntSai: String;
                        dtaDtaDoc: TDateTime;
                        strTip_Fc,
                        strForCli,
                        strHistor,
                        strNfComp,
                        strNotEsp,
                        strClfSc1: String;
                        fltVlCon1,
                        fltBasIc1,
                        fltAlqIc1,
                        fltVlrIc1,
                        fltOutra1,
                        fltIsent1,
                        fltRetid1,
                        fltBasIp1,
                        fltVlrIp1,
                        fltBcRet1,
                        fltDAces1,
                        fltValIs1: Double;
                        strClfSc2: String;
                        fltVlCon2,
                        fltBasIc2,
                        fltAlqIc2,
                        fltVlrIc2,
                        fltOutra2,
                        fltIsent2,
                        fltRetid2,
                        fltBasIp2,
                        fltVlrIp2,
                        fltBcRet2,
                        fltDAces2,
                        fltValIs2: Double;
                        strClfSc3: String;
                        fltVlCon3,
                        fltBasIc3,
                        fltAlqIc3,
                        fltVlrIc3,
                        fltOutra3,
                        fltIsent3,
                        fltRetid3,
                        fltBasIp3,
                        fltVlrIp3,
                        fltBcRet3,
                        fltDAces3,
                        fltValIs3: Double;
                        strClfSc4: String;
                        fltVlCon4,
                        fltBasIc4,
                        fltAlqIc4,
                        fltVlrIc4,
                        fltOutra4,
                        fltIsent4,
                        fltRetid4,
                        fltBasIp4,
                        fltVlrIp4,
                        fltBcRet4,
                        fltDAces4,
                        fltValIs4: Double;
                        strClfSc5: String;
                        fltVlCon5,
                        fltBasIc5,
                        fltAlqIc5,
                        fltVlrIc5,
                        fltOutra5,
                        fltIsent5,
                        fltRetid5,
                        fltBasIp5,
                        fltVlrIp5,
                        fltBcRet5,
                        fltDAces5,
                        fltValIs5,
                        fltTotPis,
                        fltTotCof,
                        fltBasPis,
                        fltBasCof,
                        fltAlqPis,
                        fltAlqCof: Double;
                        strCodEmp,
                        strSerie,
                        strEstado,
                        strNumSer,
                        strNumCoo,
                        strCodCon,
                        strDocCon: String;
                        strChaveAcesso: String;
                        strNumeroProtocolo,
                        strOriDoc: String;
                        const objParams: TCadFisParams): Boolean;
Begin
  Result := fGravaCadFis(
               strAutInc,
               dtaDtaEnt,
               strNumDoc,
               strNumDo2,
               strEspDoc,
               strEntSai,
               dtaDtaDoc,
               strTip_Fc,
               strForCli,
               strHistor,
               strNfComp,
               strNotEsp,
               strClfSc1,
               fltVlCon1,
               fltBasIc1,
               fltAlqIc1,
               fltVlrIc1,
               fltOutra1,
               fltIsent1,
               fltRetid1,
               fltBasIp1,
               fltVlrIp1,
               fltBcRet1,
               fltDAces1,
               fltValIs1,
               strClfSc2,
               fltVlCon2,
               fltBasIc2,
               fltAlqIc2,
               fltVlrIc2,
               fltOutra2,
               fltIsent2,
               fltRetid2,
               fltBasIp2,
               fltVlrIp2,
               fltBcRet2,
               fltDAces2,
               fltValIs2,
               strClfSc3,
               fltVlCon3,
               fltBasIc3,
               fltAlqIc3,
               fltVlrIc3,
               fltOutra3,
               fltIsent3,
               fltRetid3,
               fltBasIp3,
               fltVlrIp3,
               fltBcRet3,
               fltDAces3,
               fltValIs3,
               strClfSc4,
               fltVlCon4,
               fltBasIc4,
               fltAlqIc4,
               fltVlrIc4,
               fltOutra4,
               fltIsent4,
               fltRetid4,
               fltBasIp4,
               fltVlrIp4,
               fltBcRet4,
               fltDAces4,
               fltValIs4,
               strClfSc5,
               fltVlCon5,
               fltBasIc5,
               fltAlqIc5,
               fltVlrIc5,
               fltOutra5,
               fltIsent5,
               fltRetid5,
               fltBasIp5,
               fltVlrIp5,
               fltBcRet5,
               fltDAces5,
               fltValIs5,
               fltTotPis,
               fltTotCof,
               fltBasPis,
               fltBasCof,
               fltAlqPis,
               fltAlqCof,
               strCodEmp,
               strSerie,
               strEstado,
               strNumSer,
               strNumCoo,
               strCodCon,
               strDocCon,
               strChaveAcesso,
               strNumeroProtocolo,
               strOriDoc,
               objParams.strEmpAut,
               objParams.fltImpMer,
               objParams.fltImpSeg,
               objParams.fltImpImp,
               objParams.fltImpPro,
               objParams.fltImpTax,
               objParams.fltImpPis,
               objParams.fltImpCof,
               objParams.strImpIC1,
               objParams.strImpIC2,
               objParams.strModFre,
               objParams.fltBasIss,
               objParams.fltAlqIss,
               objParams.fltValIss,
               objParams.fltBaseII,
               objParams.fltDesAdu,
               objParams.fltValIOF,
               objParams.fltBasAn1,
               objParams.fltAntIc1,
               objParams.fltBasAn2,
               objParams.fltAntIc2,
               objParams.fltBasAn3,
               objParams.fltAntIc3,
               objParams.fltBasAn4,
               objParams.fltAntIc4,
               objParams.fltBasAn5,
               objParams.fltAntIc5,
               objParams.strCstEnt,
               objParams.blnGraCTP,
               objParams.fltBaeRe1,
               objParams.fltVaeRe1,
               objParams.fltBaeRe2,
               objParams.fltVaeRe2,
               objParams.fltBaeRe3,
               objParams.fltVaeRe3,
               objParams.fltBaeRe4,
               objParams.fltVaeRe4,
               objParams.fltBaeRe5,
               objParams.fltVaeRe5,
               objParams.fltBaeIP1,
               objParams.fltVaeIP1,
               objParams.fltBaeIP2,
               objParams.fltVaeIP2,
               objParams.fltBaeIP3,
               objParams.fltVaeIP3,
               objParams.fltBaeIP4,
               objParams.fltVaeIP4,
               objParams.fltBaeIP5,
               objParams.fltVaeIP5,
               objParams.strCtsPis,
               objParams.strCtsCof,
               objParams.strCodMod,
               objParams.strVENCOM,
               objParams.fltBFCPS1,
               objParams.fltVFCPS1,
               objParams.fltBFCPS2,
               objParams.fltVFCPS2,
               objParams.fltBFCPS3,
               objParams.fltVFCPS3,
               objParams.fltBFCPS4,
               objParams.fltVFCPS4,
               objParams.fltBFCPS5,
               objParams.fltVFCPS5,
               objParams.fltALQFCP,
               objParams.fltTotRmm,
               objParams.strCodTra,
               objParams.fltIrSeRt,
               objParams.fltPiSeRt,
               objParams.fltCoSeRt,
               objParams.fltCsSeRt,
               objParams.fltRetISS,
               objParams.fltRetINS,
               objParams.fltBAFCP1,
               objParams.fltVLFCP1,
               objParams.fltBAFCP2,
               objParams.fltVLFCP2,
               objParams.fltBAFCP3,
               objParams.fltVLFCP3,
               objParams.fltBAFCP4,
               objParams.fltVLFCP4,
               objParams.fltBAFCP5,
               objParams.fltVLFCP5,
               objParams.strTipFre,
               objParams.fltRFRBAS,
               objParams.fltRFRALQ,
               objParams.fltRFRVAL,
               objParams.strCstIPI,
               objParams.strNfCIAP,
               objParams.fltPesCTE,
               objParams.strEstornoNotaFiscal,
               objParams.strEstornoNotaFiscalMotivo,
               objParams.strNatOpe,
               objParams.strTB01RE,
               objParams.strTB06RE,
               objParams.strBasFre,
               objParams.blnDevSim,
               objParams.strCdsErv,
               objParams.fltQBCMO1,
               objParams.fltQBCMO2,
               objParams.fltQBCMO3,
               objParams.fltQBCMO4,
               objParams.fltQBCMO5,
               objParams.fltQBCMO6,
               objParams.fltQBCMO7,
               objParams.fltQBCMO8,
               objParams.fltADREM1,
               objParams.fltADREM2,
               objParams.fltADREM3,
               objParams.fltADREM4,
               objParams.fltADREM5,
               objParams.fltADREM6,
               objParams.fltADREM7,
               objParams.fltADREM8,
               objParams.fltVALMO1,
               objParams.fltVALMO2,
               objParams.fltVALMO3,
               objParams.fltVALMO4,
               objParams.fltVALMO5,
               objParams.fltVALMO6,
               objParams.fltVALMO7,
               objParams.fltVALMO8,
               objParams.strNfsSub,
               objParams.strMesAno,
               objParams.strFinNfe,
               objParams.strFinTip,
               objParams.fltTotIbs,
               objParams.fltTotCbs,
               objParams.fltTotIs,
               objParams.fltTotProIs,
               objParams.fltTotNf
             )
End;

function fGravaFisRef(
                      strSeqFis,
                      strCodEmp:  String;
                      strClatri:  String = '';
                      fltVlrCon:  Double = 0;
                      fltBasIs:   Double = 0;
                      fltCbsAlq:  Double = 0;
                      fltCbsDif:  Double = 0;
                      fltCbsRed:  Double = 0;
                      fltCbsVal:  Double = 0;
                      fltCbsVld:  Double = 0;
                      fltCbsVlr:  Double = 0;
                      fltCbsBas:  Double = 0;
                      fltCbsBad:  Double = 0;
                      fltCbsBar:  Double = 0;
                      fltIbsUfb:  Double = 0;
                      fltIbsUdb:  Double = 0;
                      fltIbsUrb:  Double = 0;
                      fltIbsUfa:  Double = 0;
                      fltIbsUfd:  Double = 0;
                      fltIbsUfr:  Double = 0;
                      fltIbsUfv:  Double = 0;
                      fltIbsUdv:  Double = 0;
                      fltIbsUrv:  Double = 0;
                      fltIbsMnb:  Double = 0;
                      fltIbsMdb:  Double = 0;
                      fltIbsMrb:  Double = 0;
                      fltIbsMna:  Double = 0;
                      fltIbsMnd:  Double = 0;
                      fltIbsMnr:  Double = 0;
                      fltIbsMnv:  Double = 0;
                      fltIbsMdv:  Double = 0;
                      fltIbsMrv:  Double = 0) : Boolean;
  Var
    qryFisRef: TUniQuery;
Begin
  Result := True;
  Try
    qryFisRef := fCriarQuery('SELECT * FROM FISREF WHERE FALSE');
    Try
      qryFisRef.Open;
      qryFisRef.Insert;
      qryFisRef.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('FISREF', strCodEmp);
      qryFisRef.FieldByName('FIS_SEQFIS').AsString  := strSeqFis;
      qryFisRef.FieldByName('FIS_CLATRI').AsString  := strClatri;
      qryFisRef.FieldByName('FIS_VLRCON').AsFloat   := fltVlrCon;
      qryFisRef.FieldByName('FIS_BASEIS').AsFloat   := fltBasIs;
      qryFisRef.FieldByName('FIS_CBSALQ').AsFloat   := fltCbsAlq;
      qryFisRef.FieldByName('FIS_CBSDIF').AsFloat   := fltCbsDif;
      qryFisRef.FieldByName('FIS_CBSRED').AsFloat   := fltCbsRed;
      qryFisRef.FieldByName('FIS_CBSVAL').AsFloat   := fltCbsVal;
      qryFisRef.FieldByName('FIS_CBSVLD').AsFloat   := fltCbsVld;
      qryFisRef.FieldByName('FIS_CBSVLR').AsFloat   := fltCbsVlr;
      qryFisRef.FieldByName('FIS_CBSBAS').AsFloat   := fltCbsBas;
      qryFisRef.FieldByName('FIS_CBSBAD').AsFloat   := fltCbsBad;
      qryFisRef.FieldByName('FIS_CBSBAR').AsFloat   := fltCbsBar;
      qryFisRef.FieldByName('FIS_IBSUFB').AsFloat   := fltIbsUfb;
      qryFisRef.FieldByName('FIS_IBSUDB').AsFloat   := fltIbsUdb;
      qryFisRef.FieldByName('FIS_IBSURB').AsFloat   := fltIbsUrb;
      qryFisRef.FieldByName('FIS_IBSUFA').AsFloat   := fltIbsUfa;
      qryFisRef.FieldByName('FIS_IBSUFD').AsFloat   := fltIbsUfd;
      qryFisRef.FieldByName('FIS_IBSUFR').AsFloat   := fltIbsUfr;
      qryFisRef.FieldByName('FIS_IBSUFV').AsFloat   := fltIbsUfv;
      qryFisRef.FieldByName('FIS_IBSUDV').AsFloat   := fltIbsUdv;
      qryFisRef.FieldByName('FIS_IBSURV').AsFloat   := fltIbsUrv;
      qryFisRef.FieldByName('FIS_IBSMNB').AsFloat   := fltIbsMnb;
      qryFisRef.FieldByName('FIS_IBSMDB').AsFloat   := fltIbsMdb;
      qryFisRef.FieldByName('FIS_IBSMRB').AsFloat   := fltIbsMrb;
      qryFisRef.FieldByName('FIS_IBSMNA').AsFloat   := fltIbsMna;
      qryFisRef.FieldByName('FIS_IBSMND').AsFloat   := fltIbsMnd;
      qryFisRef.FieldByName('FIS_IBSMNR').AsFloat   := fltIbsMnr;
      qryFisRef.FieldByName('FIS_IBSMNV').AsFloat   := fltIbsMnv;
      qryFisRef.FieldByName('FIS_IBSMDV').AsFloat   := fltIbsMdv;
      qryFisRef.FieldByName('FIS_IBSMRV').AsFloat   := fltIbsMrv;
      qryFisRef.Post;
    Finally
      FreeAndNil(qryFisRef);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fGravaFisRef]');
      Raise;
    End;
  End;
End;

end.
