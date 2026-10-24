unit untFuncGrava;

interface

uses SysUtils, Variants, StrUtils, untFuncFatTypes;

  function fGravaTinGer(Var strAutInc: String;
                        strCodEmp,
                        strCodVen,
                        strNumDoc,
                        strEspDoc: String;
                        dtaDtaEnt,
                        dtaHorEnt: TDateTime;
                        strConPag,
                        strCodCli,
                        strEstado,
                        strNomCon,
                        strEndCon,
                        strBaiCon,
                        strCepCon,
                        strCidCon,
                        strEstCon,
                        strTelCon: String;
                        intCgcCpf: Integer;
                        strCgcCon,
                        strIesCon,
                        strCli_Rg,
                        strJaProd: String): Boolean;

  function fGravaTinDet(Var strAutIncTdt: String;
                        strSeqGer: String;
                        strCodEmp,
                        strCodDiv,
                        strCodMar,
                        strCodIte,
                        strCodVen,
                        strCodCli,
                        strNumDoc,
                        strEspDoc: String;
                        dtaDtaEnt,
                        dtaHorEnt: TDateTime;
                        strConPag,
                        strEstado,
                        strDescri,
                        strRefere,
                        strUnidad,
                        strForIte: String;
                        fltQtdIte: Double;
                        strIncPis,
                        strNotEsp,
                        strIdePro,
                        strIteTin,
                        strIteCha,
                        strDesCor,
                        strTipEmb: String;
                        fltQtdEmb,
                        fltPreEmb: Double;
                        strTipPre,
                        strMontad,
                        strA_n_o_,
                        strForm01: String;
                        fltQtdb01: Double;
                        strForm02: String;
                        fltQtdb02: Double;
                        strForm03: String;
                        fltQtdb03: Double;
                        strForm04: String;
                        fltQtdb04: Double;
                        strForm05: String;
                        fltQtdb05: Double;
                        strForm06: String;
                        fltQtdb06: Double;
                        strForm07: String;
                        fltQtdb07: Double;
                        strForm08: String;
                        fltQtdb08: Double;
                        strForm09: String;
                        fltQtdb09: Double;
                        strForm10: String;
                        fltQtdb10: Double;
                        strForm11: String;
                        fltQtdb11: Double;
                        strForm12: String;
                        fltQtdb12: Double;
                        strForm13: String;
                        fltQtdb13: Double;
                        strForm14: String;
                        fltQtdb14: Double;
                        strForm15: String;
                        fltQtdb15: Double;
                        strForm16: String;
                        fltQtdb16: Double;
                        strForm17: String;
                        fltQtdb17: Double;
                        strForm18: String;
                        fltQtdb18: Double;
                        strForm19: String;
                        fltQtdb19: Double;
                        strForm20: String;
                        fltQtdb20: Double;
                        strCodDig,
                        strCodAca,
                        strEmpAca,
                        strCatali,
                        strLinTin: String;
                        blnGerOpr: Boolean;
                        strEmpPrd: String;
                        intLazQua: Integer;
                        fltVolPro: Double;
                        strCodDil: String;
                        fltPorDil: Double;
                        strDilCon: String;
                        fltPorCat: Double;
                        recForTin: TForTin;
                        fltFatAce: Double;
                        blnBaixad: Boolean = False;
                        strObsCol : String = '';
                        intTipFor : Integer = 0): Boolean;

  



implementation

uses untFuncoesSimples, Uni, untAutcomDllTinta;

function fGravaTinGer(Var strAutInc: String;
                      strCodEmp,
                      strCodVen,
                      strNumDoc,
                      strEspDoc: String;
                      dtaDtaEnt,
                      dtaHorEnt: TDateTime;
                      strConPag,
                      strCodCli,
                      strEstado,
                      strNomCon,
                      strEndCon,
                      strBaiCon,
                      strCepCon,
                      strCidCon,
                      strEstCon,
                      strTelCon: String;
                      intCgcCpf: Integer;
                      strCgcCon,
                      strIesCon,
                      strCli_Rg,
                      strJaProd: String): Boolean;
  Var
    qryTinGer: TUniQuery;
Begin
  Try
    qryTinGer := fCriarQuery('SELECT * FROM TINGER WHERE FALSE');
    qryTinGer.Open;

    strAutInc := fRetAutoIncrem('TINGER', strCodEmp);
    Try
      With qryTinGer Do
      Begin
        Insert;

        FieldByName('GER_CODEMP').AsString   := strCodEmp;
        FieldByName('GER_CODVEN').AsString   := strCodVen;
        FieldByName('GER_NUMDOC').AsString   := strNumDoc;
        FieldByName('GER_ESPDOC').AsString   := strEspDoc;
        FieldByName('GER_DTAENT').AsDateTime := dtaDtaEnt;
        FieldByName('GER_HORENT').AsDateTime := dtaHorEnt;
        FieldByName('GER_CONPAG').AsString   := strConPag;
        FieldByName('GER_CODCLI').AsString   := strCodCli;

        FieldByName('GER_NOMCON').AsString   := strNomCon;
  //      If (fClienteConsumidor(strCodCli)) Then
        If (fEmptyStr(strNomCon)) Then
        Begin
          FieldByName('GER_NOMCON').Value := Null;
          FieldByName('GER_ESTADO').Value := Null;
          FieldByName('GER_ENDCON').Value := Null;
          FieldByName('GER_BAICON').Value := Null;
          FieldByName('GER_CEPCON').Value := Null;
          FieldByName('GER_CIDCON').Value := Null;
          FieldByName('GER_ESTCON').Value := Null;
          FieldByName('GER_TELCON').Value := Null;
          FieldByName('GER_CGCCPF').Value := Null;
          FieldByName('GER_CGCCON').Value := Null;
          FieldByName('GER_IESCON').Value := Null;
          FieldByName('GER_R_GCON').Value := Null;
        End
        Else
        Begin
          FieldByName('GER_NOMCON').AsString   := strNomCon;
          FieldByName('GER_ESTADO').AsString   := strEstado;
          FieldByName('GER_ENDCON').AsString   := strEndCon;
          FieldByName('GER_BAICON').AsString   := strBaiCon;
          FieldByName('GER_CEPCON').AsString   := strCepCon;
          FieldByName('GER_CIDCON').AsString   := strCidCon;
          FieldByName('GER_ESTCON').AsString   := strEstCon;
          FieldByName('GER_TELCON').AsString   := strTelCon;
          FieldByName('GER_CGCCPF').AsInteger  := intCgcCpf;
          FieldByName('GER_CGCCON').AsString   := strCgcCon;

          If (intCgcCpf = 2) Then
          Begin
            FieldByName('GER_R_GCON').AsString   := strCli_Rg;
            FieldByName('GER_IESCON').AsString   := '';
          End
          Else
          Begin
            FieldByName('GER_R_GCON').AsString   := '';
            FieldByName('GER_IESCON').AsString   := strIesCon;
          End;

        End;
        FieldByName('GER_JAPROD').AsString   := strJaProd;
        FieldByName('AUTOINCREM').AsString   := strAutInc;

        Post;
      End;
    Finally
      FreeAndNil(qryTinGer);
    End;

    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fGravaTinGer]');
      Result := False;
    End;
  End;
  
end;

function fGravaTinDet(Var strAutIncTdt: String;
                      strSeqGer: String;
                      strCodEmp,
                      strCodDiv,
                      strCodMar,
                      strCodIte,
                      strCodVen,
                      strCodCli,
                      strNumDoc,
                      strEspDoc: String;
                      dtaDtaEnt,
                      dtaHorEnt: TDateTime;
                      strConPag,
                      strEstado,
                      strDescri,
                      strRefere,
                      strUnidad,
                      strForIte: String;
                      fltQtdIte: Double;
                      strIncPis,
                      strNotEsp,
                      strIdePro,
                      strIteTin,
                      strIteCha,
                      strDesCor,
                      strTipEmb: String;
                      fltQtdEmb,
                      fltPreEmb: Double;
                      strTipPre,
                      strMontad,
                      strA_n_o_,
                      strForm01: String;
                      fltQtdb01: Double;
                      strForm02: String;
                      fltQtdb02: Double;
                      strForm03: String;
                      fltQtdb03: Double;
                      strForm04: String;
                      fltQtdb04: Double;
                      strForm05: String;
                      fltQtdb05: Double;
                      strForm06: String;
                      fltQtdb06: Double;
                      strForm07: String;
                      fltQtdb07: Double;
                      strForm08: String;
                      fltQtdb08: Double;
                      strForm09: String;
                      fltQtdb09: Double;
                      strForm10: String;
                      fltQtdb10: Double;
                      strForm11: String;
                      fltQtdb11: Double;
                      strForm12: String;
                      fltQtdb12: Double;
                      strForm13: String;
                      fltQtdb13: Double;
                      strForm14: String;
                      fltQtdb14: Double;
                      strForm15: String;
                      fltQtdb15: Double;
                      strForm16: String;
                      fltQtdb16: Double;
                      strForm17: String;
                      fltQtdb17: Double;
                      strForm18: String;
                      fltQtdb18: Double;
                      strForm19: String;
                      fltQtdb19: Double;
                      strForm20: String;
                      fltQtdb20: Double;
                      strCodDig,
                      strCodAca,
                      strEmpAca,
                      strCatali,
                      strLinTin: String;
                      blnGerOpr: Boolean;
                      strEmpPrd: String;
                      intLazQua: Integer;
                      fltVolPro: Double;
                      strCodDil: String;
                      fltPorDil: Double;
                      strDilCon: String;
                      fltPorCat: Double;
                      recForTin: TForTin;
                      fltFatAce: Double;
                      blnBaixad: Boolean = False;
                      strObsCol: String = '';
                      intTipFor: Integer = 0): Boolean;

  Var
    qryTinDet: TUniQuery;
Begin
  strAutIncTdt := '';

  Try
    qryTinDet := fCriarQuery('SELECT * FROM TINDET WHERE FALSE');
    qryTinDet.Open;

    strAutIncTdt := fRetAutoIncrem('TINDET', strCodEmp);
    Try
      With qryTinDet Do
      Begin
        Insert;

        FieldByName('DET_SEQGER').AsString   := strSeqGer;
        FieldByName('DET_CODEMP').AsString   := strCodEmp;

        If fEmptyStr(strCodDiv) Then
          FieldByName('DET_CODDIV').Value := Null
        Else
          FieldByName('DET_CODDIV').AsString := strCodDiv;

        If (fEmptyStr(strCodMar)) Then
          FieldByName('DET_CODMAR').Value := Null
        Else
          FieldByName('DET_CODMAR').AsString := strCodMar;

        FieldByName('DET_CODITE').AsString   := strCodIte;
        FieldByName('DET_CODVEN').AsString   := strCodVen;
        FieldByName('DET_CODCLI').AsString   := strCodCli;
        FieldByName('DET_NUMDOC').AsString   := strNumDoc;
        FieldByName('DET_ESPDOC').AsString   := strEspDoc;
        FieldByName('DET_DTAENT').AsDateTime := dtaDtaEnt;
        FieldByName('DET_HORENT').AsDateTime := dtaHorEnt;
        FieldByName('DET_CONPAG').AsString   := strConPag;
        FieldByName('DET_ESTADO').AsString   := strEstado;
        FieldByName('DET_DESCRI').AsString   := strDescri;
        FieldByName('DET_REFERE').AsString   := strRefere;
        FieldByName('DET_UNIDAD').AsString   := strUnidad;

        If (fEmptyStr(strForIte)) Then
          FieldByName('DET_FORITE').Value := Null
        Else
          FieldByName('DET_FORITE').AsString  := strForIte;

        FieldByName('DET_QTDITE').AsFloat    := fltQtdIte;
        FieldByName('DET_INCPIS').AsString   := strIncPis;
        FieldByName('DET_NOTESP').AsString   := strNotEsp;
        FieldByName('DET_IDEPRO').AsString   := strIdePro;
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
        FieldByName('DET_MONTAD').AsString   := strMontad;
        FieldByName('DET_A_N_O_').AsString   := strA_n_o_;
        FieldByName('DET_FORM01').AsString   := strForm01;
        FieldByName('DET_QTDB01').AsFloat    := fltQtdb01;
        FieldByName('DET_FORM02').AsString   := strForm02;
        FieldByName('DET_QTDB02').AsFloat    := fltQtdb02;
        FieldByName('DET_FORM03').AsString   := strForm03;
        FieldByName('DET_QTDB03').AsFloat    := fltQtdb03;
        FieldByName('DET_FORM04').AsString   := strForm04;
        FieldByName('DET_QTDB04').AsFloat    := fltQtdb04;
        FieldByName('DET_FORM05').AsString   := strForm05;
        FieldByName('DET_QTDB05').AsFloat    := fltQtdb05;
        FieldByName('DET_FORM06').AsString   := strForm06;
        FieldByName('DET_QTDB06').AsFloat    := fltQtdb06;
        FieldByName('DET_FORM07').AsString   := strForm07;
        FieldByName('DET_QTDB07').AsFloat    := fltQtdb07;
        FieldByName('DET_FORM08').AsString   := strForm08;
        FieldByName('DET_QTDB08').AsFloat    := fltQtdb08;
        FieldByName('DET_FORM09').AsString   := strForm09;
        FieldByName('DET_QTDB09').AsFloat    := fltQtdb09;
        FieldByName('DET_FORM10').AsString   := strForm10;
        FieldByName('DET_QTDB10').AsFloat    := fltQtdb10;
        FieldByName('DET_FORM11').AsString   := strForm11;
        FieldByName('DET_QTDB11').AsFloat    := fltQtdb11;
        FieldByName('DET_FORM12').AsString   := strForm12;
        FieldByName('DET_QTDB12').AsFloat    := fltQtdb12;
        FieldByName('DET_FORM13').AsString   := strForm13;
        FieldByName('DET_QTDB13').AsFloat    := fltQtdb13;
        FieldByName('DET_FORM14').AsString   := strForm14;
        FieldByName('DET_QTDB14').AsFloat    := fltQtdb14;
        FieldByName('DET_FORM15').AsString   := strForm15;
        FieldByName('DET_QTDB15').AsFloat    := fltQtdb15;
        FieldByName('DET_FORM16').AsString   := strForm16;
        FieldByName('DET_QTDB16').AsFloat    := fltQtdb16;
        FieldByName('DET_FORM17').AsString   := strForm17;
        FieldByName('DET_QTDB17').AsFloat    := fltQtdb17;
        FieldByName('DET_FORM18').AsString   := strForm18;
        FieldByName('DET_QTDB18').AsFloat    := fltQtdb18;
        FieldByName('DET_FORM19').AsString   := strForm19;
        FieldByName('DET_QTDB19').AsFloat    := fltQtdb19;
        FieldByName('DET_FORM20').AsString   := strForm20;
        FieldByName('DET_QTDB20').AsFloat    := fltQtdb20;
        FieldByName('AUTOINCREM').AsString   := strAutIncTdt;

        If fEmptyStr(strCodDig) Then
          FieldByName('DET_CODDIG').Value    := Null
        Else
          FieldByName('DET_CODDIG').AsString := strCodDig;

        If fEmptyStr(strCodAca) Then
          FieldByName('DET_CODACA').Value := Null
        Else
          FieldByName('DET_CODACA').AsString := strCodAca;

        If fEmptyStr(strEmpAca) Then
          FieldByName('DET_EMPACA').Value := Null
        Else
          FieldByName('DET_EMPACA').AsString := strEmpAca;

        FieldByName('DET_CATALI').AsString := strCatali;
        FieldByName('DET_LINTIN').AsString := strLinTin;

        FieldByName('DET_GEROPR').AsInteger := IIF(blnGerOpr, 1, 0);
        FieldByName('DET_EMPPRD').AsString  := strEmpPrd;
        FieldByName('DET_LAZQUA').AsInteger := intLazQua;
        FieldByName('DET_VOLPRO').AsFloat   := fltVolPro;


        FieldByName('DET_CODDIL').AsString  := strCodDil;
        FieldByName('DET_PORDIL').AsFloat  := fltPorDil;
        FieldByName('DET_DILCON').AsString  := strDilCon;
        FieldByName('DET_PORCAT').AsFloat  := fltPorCat;
        FieldByName('DET_BAIXAD').AsString := IIF(blnBaixad, '1', 'N');  //'N';

        If blnBaixad Then
        Begin
          FieldByName('DET_OPEBAI').AsString   := strLoginUsuarioLogado;
          FieldByName('DET_DTABAI').AsDateTime := dtaDtaEnt;
          FieldByName('DET_HORBAI').AsDateTime := dtaHorEnt;
          FieldByName('DET_MOTBAI').AsString   := 'FORMULACAO TINTA DE MAQUINA - PEDIDO JÁ BAIXADO';
        End;

        FieldByName('DET_OBSCOL').AsString  := strObsCol;
        FieldByName('DET_TIPFOR').AsInteger := intTipFor;

        If Not fEmptyStr(strCodAca) Then
        Begin
          fGravaForTin(strCodAca, recForTin.strTextBase, recForTin.strTipCor,
            recForTin.intModDil, strEmpAca, recForTin.strCompB, recForTin.strUniver,
            fltFatAce, recForTin.strCatali);
        End;

        Post;
      End;
    Finally
      FreeAndNil(qryTinDet);
    End;

    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fGravaTinDet]');
      Result := False;
    End;
  End;

End;

end.


