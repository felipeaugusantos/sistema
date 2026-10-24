unit untEntGer;

interface

uses
  SysUtils, Classes, DB,   Uni,
  Variants;


function fGravaEntGer(Var strAutInc: String;
                      strCodEmp,
                      strNumDoc,
                      strEspDoc,
                      strCodVen,
                      strCodTra,
                      strCodCli,
                      strSerIe_: String;
                      dtaDtaEnt,
                      dtaHorEnt: TDateTime;
                      strDtaDoc,
                      strConPag,
                      strEstAdo,
                      strNomCon,
                      strEndCon,
                      strBaiCon,
                      strCepCon,
                      strCidCon,
                      strEstCon,
                      strTelCon: String;
                      intCgcCpf: Integer;
                      strCgcCon,
                      strIesCon: String;
                      fltDesEsp,
                      fltVlrCon,
                      fltTotCus,
                      fltTotMed: Double;
                      strTipFre: String;
                      fltTotFre,
                      fltPesBru,
                      fltPesLiq,
                      fltVolUme: Double;
                      strEspEci,
                      strMarCa_,
                      strMen001,
                      strMen002: String;
                      fltVpar01,
                      fltVpar02,
                      fltVpar03,
                      fltVpar04,
                      fltVpar05,
                      fltVpar06,
                      fltVpar07,
                      fltVpar08,
                      fltVpar09,
                      fltVpar10,
                      fltVpar11,
                      fltVpar12: Double;
                      strCodDig: String;
                      strPorDes: Double;
                      strR_gCon,
                      strCodCnd,
                      strCodFpg,
                      strCodS01,
                      strCodS02,
                      strCodS03,
                      strCodS04,
                      strCodS05,
                      strCodS06,
                      strDesS01,
                      strDesS02,
                      strDesS03,
                      strDesS04,
                      strDesS05,
                      strDesS06: String;
                      fltValS01,
                      fltValS02,
                      fltValS03,
                      fltValS04,
                      fltValS05,
                      fltValS06: Double;
                      intPraEnt: Integer;
                      fltTotSer,
                      fltPerIss,
                      fltValIss: Double;
                      strNatOpe,
                      strOriDoc: String;
                      intQtdIte: Integer;
                      strEmpFor: String;
                      strMen003,
                      strMen004,
                      strMen005: String;
                      strEmpresaAbastecimentoOutrasSaidas: String = ''): Boolean;

function fGravaEntDet(strSeqGer,
                      strCodEmp,
                      strCodVen,
                      strCodIte,
                      strCodDiv,
                      strCodMar,
                      strCodCli,
                      strNumDoc,
                      strEspDoc,
                      strSerIe_: String;
                      dtaDtaEnt,
                      dtaHorEnt,
                      dtaDtaDoc: TDateTime;
                      strConPag,
                      strEstAdo,
                      strDesCri,
                      strDesOri,
                      strRefEre,
                      strUniDad,
                      strForIte: String;
                      fltQtdIte,
                      fltUniTar,
                      fltUniOri,
                      fltUniVis,
                      fltVlrCon,
                      fltTotCus,
                      fltTotMed,
                      fltDesCon,
                      fltTotFre,
                      fltDesEsp: Double;
                      strCodRep: String;
                      fltPerCom,
                      fltTotCom: Double;
                      strCodFis: String;
                      fltTotPes,
                      fltPerBas: Double;
                      strIdePro,
                      strIncPis,
                      strIteTin,
                      strIteCha,
                      strDesCor,
                      strTipEmb: String;
                      fltQtdEmb,
                      fltPreEmb: Double;
                      strTipPre: String;
                      fltPrvTin,
                      fltPrcTin,
                      fltFatTin: Double;
                      strProEmb,
                      strCodDig,
                      strCodCnd,
                      strCodFpg,
                      strIteEmb: String;
                      fltLazQua: Double;
                      strProMoc,
                      strSeqTin,
                      strCodVe2: String;
                      fltTotCo2,
                      fltQtdPul: Double;
                      strOriDoc,
                      strNumLot: String;
                      fltTaxJur: Double;
                      strLotAba: String;
                      strEmpresaAbastecimentoOutrasSaidas: String = '';
                      blnProAca: Boolean = False;
                      strCodAca: String = '';
                      strEmpAca: String = ''): Boolean;

implementation

uses untfuncoesSimples;

function fGravaEntGer(Var strAutInc: String;
                                       strCodEmp,
                                       strNumDoc,
                                       strEspDoc,
                                       strCodVen,
                                       strCodTra,
                                       strCodCli,
                                       strSerIe_: String;
                                       dtaDtaEnt,
                                       dtaHorEnt: TDateTime;
                                       strDtaDoc,
                                       strConPag,
                                       strEstAdo,
                                       strNomCon,
                                       strEndCon,
                                       strBaiCon,
                                       strCepCon,
                                       strCidCon,
                                       strEstCon,
                                       strTelCon: String;
                                       intCgcCpf: Integer;
                                       strCgcCon,
                                       strIesCon: String;
                                       fltDesEsp,
                                       fltVlrCon,
                                       fltTotCus,
                                       fltTotMed: Double;
                                       strTipFre: String;
                                       fltTotFre,
                                       fltPesBru,
                                       fltPesLiq,
                                       fltVolUme: Double;
                                       strEspEci,
                                       strMarCa_,
                                       strMen001,
                                       strMen002: String;
                                       fltVpar01,
                                       fltVpar02,
                                       fltVpar03,
                                       fltVpar04,
                                       fltVpar05,
                                       fltVpar06,
                                       fltVpar07,
                                       fltVpar08,
                                       fltVpar09,
                                       fltVpar10,
                                       fltVpar11,
                                       fltVpar12: Double;
                                       strCodDig: String;
                                       strPorDes: Double;
                                       strR_gCon,
                                       strCodCnd,
                                       strCodFpg,
                                       strCodS01,
                                       strCodS02,
                                       strCodS03,
                                       strCodS04,
                                       strCodS05,
                                       strCodS06,
                                       strDesS01,
                                       strDesS02,
                                       strDesS03,
                                       strDesS04,
                                       strDesS05,
                                       strDesS06: String;
                                       fltValS01,
                                       fltValS02,
                                       fltValS03,
                                       fltValS04,
                                       fltValS05,
                                       fltValS06: Double;
                                       intPraEnt: Integer;
                                       fltTotSer,
                                       fltPerIss,
                                       fltValIss: Double;
                                       strNatOpe,
                                       strOriDoc: String;
                                       intQtdIte: Integer;
                                       strEmpFor: String;
                                       strMen003,
                                       strMen004,
                                       strMen005: String;
                                       strEmpresaAbastecimentoOutrasSaidas: String = ''): Boolean;
  Var
    qryEntGer: TUniQuery;
begin

  Try
    qryEntGer := fCriarQuery('SELECT * FROM ENTGER WHERE FALSE', nil);
    With qryEntGer Do
    Begin
      strAutInc := fRetAutoIncrem('ENTGER', strCodEmp);

      If Not Active Then
        Open;

      Insert;

      FieldByName('AUTOINCREM').AsString   := strAutInc;
      FieldByName('GER_CODEMP').AsString   := strCodEmp;
      FieldByName('GER_NUMDOC').AsString   := strNumDoc;
      FieldByName('GER_ESPDOC').AsString   := strEspDoc;
      FieldByName('GER_CODVEN').AsString   := strCodVen;

      If (fEmptyStr(strCodTra)) Then
        FieldByName('GER_CODTRA').Value    := Null
      Else
        FieldByName('GER_CODTRA').AsString := strCodTra;

      If (fEmptyStr(strCodDig)) Then
        FieldByName('GER_CODDIG').Value    := Null
      Else
        FieldByName('GER_CODDIG').AsString := strCodDig;

      if fEmptyStr(strEmpresaAbastecimentoOutrasSaidas) then
        FieldByName('GER_CODCLI').AsString   := strCodCli
      else
        FieldByName('GER_CODFOR').AsString   := strCodCli;

      FieldByName('GER_SERIE_').AsString   := strSerIe_;
      FieldByName('GER_DTAENT').AsDateTime := dtaDtaEnt;
      FieldByName('GER_HORENT').AsDateTime := dtaHorEnt;
      FieldByName('GER_DTADOC').AsString   := strDtaDoc;
      FieldByName('GER_CONPAG').AsString   := strConPag;
      FieldByName('GER_ESTADO').AsString   := strEstAdo;
      FieldByName('GER_NOMCON').AsString   := strNomCon;
      FieldByName('GER_ENDCON').AsString   := strEndCon;
      FieldByName('GER_BAICON').AsString   := strBaiCon;
      FieldByName('GER_CEPCON').AsString   := strCepCon;

      if fEmptyStr(strCidCon) then
        FieldByName('GER_CIDCON').Value    := Null
      Else
        FieldByName('GER_CIDCON').AsString := strCidCon;

      FieldByName('GER_ESTCON').AsString   := strEstCon;
      FieldByName('GER_TELCON').AsString   := strTelCon;
      FieldByName('GER_CGCCPF').AsInteger  := intCgcCpf;
      FieldByName('GER_CGCCON').AsString   := strCgcCon;
      FieldByName('GER_IESCON').AsString   := strIesCon;
      FieldByName('GER_DESESP').AsFloat    := fltDesEsp;
      FieldByName('GER_VLRCON').AsFloat    := fltVlrCon;
      FieldByName('GER_TOTCUS').AsFloat    := fltTotCus;
      FieldByName('GER_TOTMED').AsFloat    := fltTotMed;
      FieldByName('GER_TIPFRE').AsString   := strTipFre;
      FieldByName('GER_TOTFRE').AsFloat    := fltTotFre;
      FieldByName('GER_PESBRU').AsFloat    := fltPesBru;

      If fFormataFloat(fltPesLiq,2) <= 0 Then
        FieldByName('GER_PESLIQ').AsFloat  := fltPesBru
      Else
        FieldByName('GER_PESLIQ').AsFloat  := fltPesLiq;

      FieldByName('GER_VOLUME').AsFloat    := fltVolUme;
      FieldByName('GER_ESPECI').AsString   := strEspEci;
      FieldByName('GER_MARCA_').AsString   := strMarCa_;
      FieldByName('GER_MEN001').AsString   := strMen001;
      FieldByName('GER_MEN002').AsString   := strMen002;
      FieldByName('GER_VPAR01').AsFloat    := fltVpar01;
      FieldByName('GER_VPAR02').AsFloat    := fltVpar02;
      FieldByName('GER_VPAR03').AsFloat    := fltVpar03;
      FieldByName('GER_VPAR04').AsFloat    := fltVpar04;
      FieldByName('GER_VPAR05').AsFloat    := fltVpar05;
      FieldByName('GER_VPAR06').AsFloat    := fltVpar06;
      FieldByName('GER_VPAR07').AsFloat    := fltVpar07;
      FieldByName('GER_VPAR08').AsFloat    := fltVpar08;
      FieldByName('GER_VPAR09').AsFloat    := fltVpar09;
      FieldByName('GER_VPAR10').AsFloat    := fltVpar10;
      FieldByName('GER_VPAR11').AsFloat    := fltVpar11;
      FieldByName('GER_VPAR12').AsFloat    := fltVpar12;
      FieldByName('GER_PORDES').AsFloat    := strPorDes;
      FieldByName('GER_R_GCON').AsString   := strR_gCon;

      If fEmptyStr(strCodCnd) Then
        FieldByName('GER_CODCND').Value    := Null
      Else
        FieldByName('GER_CODCND').AsString := strCodCnd;

      If fEmptyStr(strCodFpg) Then
        FieldByName('GER_CODFPG').Value := Null
      Else
        FieldByName('GER_CODFPG').AsString := strCodFpg;

      FieldByName('GER_CODS01').AsString   := strCodS01;
      FieldByName('GER_CODS02').AsString   := strCodS02;
      FieldByName('GER_CODS03').AsString   := strCodS03;
      FieldByName('GER_CODS04').AsString   := strCodS04;
      FieldByName('GER_CODS05').AsString   := strCodS05;
      FieldByName('GER_CODS06').AsString   := strCodS06;
      FieldByName('GER_DESS01').AsString   := strDesS01;
      FieldByName('GER_DESS02').AsString   := strDesS02;
      FieldByName('GER_DESS03').AsString   := strDesS03;
      FieldByName('GER_DESS04').AsString   := strDesS04;
      FieldByName('GER_DESS05').AsString   := strDesS05;
      FieldByName('GER_DESS06').AsString   := strDesS06;
      FieldByName('GER_VALS01').AsFloat    := fltValS01;
      FieldByName('GER_VALS02').AsFloat    := fltValS02;
      FieldByName('GER_VALS03').AsFloat    := fltValS03;
      FieldByName('GER_VALS04').AsFloat    := fltValS04;
      FieldByName('GER_VALS05').AsFloat    := fltValS05;
      FieldByName('GER_VALS06').AsFloat    := fltValS06;
      FieldByName('GER_PRAENT').AsInteger  := intPraEnt;
      FieldByName('GER_TOTSER').AsFloat    := fltTotSer;
      FieldByName('GER_PERISS').AsFloat    := fltPerIss;
      FieldByName('GER_VALISS').AsFloat    := fltValIss;
      FieldByName('GER_NATOPE').AsString   := strNatOpe;
      FieldByName('GER_ORIDOC').AsString   := strOriDoc;
      FieldByName('GER_QTDITE').AsInteger  := intQtdIte;
      FieldByName('GER_EMPFOR').AsString   := strEmpFor;

      Post;
      Result := True;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaEntGer]');
    End;
  End;

  FreeAndNil(qryEntGer);
end;

function fGravaEntDet(strSeqGer,
                      strCodEmp,
                      strCodVen,
                      strCodIte,
                      strCodDiv,
                      strCodMar,
                      strCodCli,
                      strNumDoc,
                      strEspDoc,
                      strSerIe_: String;
                      dtaDtaEnt,
                      dtaHorEnt,
                      dtaDtaDoc: TDateTime;
                      strConPag,
                      strEstAdo,
                      strDesCri,
                      strDesOri,
                      strRefEre,
                      strUniDad,
                      strForIte: String;
                      fltQtdIte,
                      fltUniTar,
                      fltUniOri,
                      fltUniVis,
                      fltVlrCon,
                      fltTotCus,
                      fltTotMed,
                      fltDesCon,
                      fltTotFre,
                      fltDesEsp: Double;
                      strCodRep: String;
                      fltPerCom,
                      fltTotCom: Double;
                      strCodFis: String;
                      fltTotPes,
                      fltPerBas: Double;
                      strIdePro,
                      strIncPis,
                      strIteTin,
                      strIteCha,
                      strDesCor,
                      strTipEmb: String;
                      fltQtdEmb,
                      fltPreEmb: Double;
                      strTipPre: String;
                      fltPrvTin,
                      fltPrcTin,
                      fltFatTin: Double;
                      strProEmb,
                      strCodDig,
                      strCodCnd,
                      strCodFpg,
                      strIteEmb: String;
                      fltLazQua: Double;
                      strProMoc,
                      strSeqTin,
                      strCodVe2: String;
                      fltTotCo2,
                      fltQtdPul: Double;
                      strOriDoc,
                      strNumLot: String;
                      fltTaxJur: Double;
                      strLotAba: String;
                      strEmpresaAbastecimentoOutrasSaidas: String = '';
                      blnProAca: Boolean = False;
                      strCodAca: String = '';
                      strEmpAca: String = ''): Boolean;
  Var
    strAutInc: String;
    qryEntDet: TUniQuery;
begin

  Try
    qryEntDet := fCriarQuery('SELECT * FROM ENTDET WHERE FALSE', nil);
    With qryEntDet Do
    Begin

      If (Not Active) Then
        Active := True;

      strAutInc := fRetAutoIncrem('ENTDET', strCodEmp);

      Insert;

      FieldByName('AUTOINCREM').AsString   := strAutInc;
      FieldByName('DET_SEQGER').AsString   := strSeqGer;
      FieldByName('DET_CODEMP').AsString   := strCodEmp;
      FieldByName('DET_CODVEN').AsString   := strCodVen;
      FieldByName('DET_CODITE').AsString   := strCodIte;

      If (fEmptyStr(strCodDiv)) Then
        FieldByName('DET_CODDIV').Value := Null
      Else
        FieldByName('DET_CODDIV').AsString   := strCodDiv;

      If (fEmptyStr(strCodDig)) Then
        FieldByName('DET_CODDIG').Value := Null
      Else
        FieldByName('DET_CODDIG').AsString   := strCodDig;

      FieldByName('DET_CODMAR').AsString   := strCodMar;

      if fEmptyStr(strEmpresaAbastecimentoOutrasSaidas) then
        FieldByName('DET_CODCLI').AsString   := strCodCli
      else
        FieldByName('DET_CODFOR').AsString   := strCodCli;

      FieldByName('DET_NUMDOC').AsString   := strNumDoc;
      FieldByName('DET_ESPDOC').AsString   := strEspDoc;
      FieldByName('DET_SERIE_').AsString   := strSerIe_;
      FieldByName('DET_DTAENT').AsDateTime := dtaDtaEnt;
      FieldByName('DET_HORENT').AsDateTime := dtaHorEnt;
      FieldByName('DET_DTADOC').AsDateTime := dtaDtaDoc;
      FieldByName('DET_CONPAG').AsString   := strConPag;
      FieldByName('DET_ESTADO').AsString   := strEstAdo;
      FieldByName('DET_DESCRI').AsString   := strDesCri;
      FieldByName('DET_DESORI').AsString   := strDesOri;
      FieldByName('DET_REFERE').AsString   := strRefEre;
      FieldByName('DET_UNIDAD').AsString   := strUniDad;

      If fEmptyStr(strForIte) Then
        FieldByName('DET_FORITE').Value := Null
      Else
        FieldByName('DET_FORITE').AsString := strForIte;

      FieldByName('DET_QTDITE').AsFloat    := fltQtdIte;
      FieldByName('DET_UNITAR').AsFloat    := fltUniTar;
      FieldByName('DET_UNIORI').AsFloat    := fltUniOri;
      FieldByName('DET_UNIVIS').AsFloat    := fltUniVis;
      FieldByName('DET_TAXJUR').AsFloat    := fltTaxJur;
      FieldByName('DET_VLRCON').AsFloat    := fltVlrCon;
      FieldByName('DET_TOTCUS').AsFloat    := fltTotCus;
      FieldByName('DET_TOTMED').AsFloat    := fltTotMed;
      FieldByName('DET_DESCON').AsFloat    := fltDesCon;
      FieldByName('DET_TOTFRE').AsFloat    := fltTotFre;
      FieldByName('DET_DESESP').AsFloat    := fltDesEsp;

      If (fEmptyStr(strCodRep)) Then
        FieldByName('DET_CODREP').Value := Null
      Else
        FieldByName('DET_CODREP').AsString := strCodRep;

      FieldByName('DET_PERCOM').AsFloat    := fltPerCom;
      FieldByName('DET_TOTCOM').AsFloat    := fltTotCom;
      FieldByName('DET_CODFIS').AsString   := strCodFis;
      FieldByName('DET_TOTPES').AsFloat    := fltTotPes;
      FieldByName('DET_PERBAS').AsFloat    := fltPerBas;
      FieldByName('DET_IDEPRO').AsString   := strIdePro;
      FieldByName('DET_INCPIS').AsString   := strIncPis;
      FieldByName('DET_ITETIN').AsString   := strIteTin;

      If (fEmptyStr(strIteCha)) Then
        FieldByName('DET_ITECHA').Value := Null
      Else
        FieldByName('DET_ITECHA').AsString  := strIteCha;

      FieldByName('DET_DESCOR').AsString   := strDesCor;
      FieldByName('DET_TIPEMB').AsString   := strTipEmb;
      FieldByName('DET_QTDEMB').AsFloat    := fltQtdEmb;
      FieldByName('DET_PREEMB').AsFloat    := fltPreEmb;
      FieldByName('DET_TIPPRE').AsString   := strTipPre;
      FieldByName('DET_PRVTIN').AsFloat    := fltPrvTin;
      FieldByName('DET_PRCTIN').AsFloat    := fltPrcTin;
      FieldByName('DET_FATTIN').AsFloat    := fltFatTin;
      FieldByName('DET_PROEMB').AsString   := strProEmb;

      If fEmptyStr(strCodCnd) Then
        FieldByName('DET_CODCND').Value    := Null
      Else
        FieldByName('DET_CODCND').AsString := strCodCnd;

      If fEmptyStr(strCodFpg) Then
        FieldByName('DET_CODFPG').Value := Null
      Else
        FieldByName('DET_CODFPG').AsString := strCodFpg;

      If (fEmptyStr(strIteEmb)) Then
        FieldByName('DET_ITEEMB').Value := Null
      Else
        FieldByName('DET_ITEEMB').AsString  := strIteEmb;

      FieldByName('DET_LAZQUA').AsFloat    := fltLazQua;
      FieldByName('DET_PROMOC').AsString   := strProMoc;
      FieldByName('DET_SEQTIN').AsString   := strSeqTin;

      If Not fEmptyStr(strCodVe2) Then
        FieldByName('DET_CODVE2').AsString := strCodVe2
      Else
        FieldByName('DET_CODVE2').Value    := Null;

      FieldByName('DET_TOTCO2').AsFloat    := fltTotCo2;
      FieldByName('DET_QTDPUL').AsFloat    := fltQtdPul;
      FieldByName('DET_ORIDOC').AsString   := strOriDoc;
      FieldByName('DET_NUMLOT').AsString   := strNumLot;
      FieldByName('DET_LOTABA').AsString   := strLotAba;
      FieldByName('DET_PROACA').AsString   := IIF(blnProAca, 'S', 'N');
      FieldByName('DET_CODACA').AsString   := strCodAca;
      FieldByName('DET_EMPACA').AsString   := strEmpAca;
      Post;

    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaEntDet]');
    End;
  End;

  FreeAndNil(qryEntDet);
end;

end.
