unit untGravaMovCar;

interface

uses
 {$IFDEF LINUX}
   {$I '..\..\..\core\services.core.uses.inc'},
 {$ELSE }
  untFuncoesSimples, Uni,
 {$ENDIF LINUX}
  Variants, SysUtils, DB, untLogMca;

  Type
    TDocumentoCartao = record
      strNumDoc : String;
      strEspDoc : String;
      strEmpDoc : String;
    End;

  function fGravaMovCar(strNomFrmLogMca,
                        strDescriLogMca,
                        strNumDup,
                        strCodCli,
                        strParCel,
                        strCodEmp,
                        strCodCar: String;
                        dtaDtaCad,
                        dtaDtaVen: TDateTime;
                        fltValOri,
                        fltValDup: Double;
                        strHisT01,
                        strHisT02,
                        strConPag: String;
                        dtaDtaRec: TDateTime;
                        fltValRec: Double;
                        strOpeBai,
                        strHisBai,
                        strPorBai,
                        strCtaBai,
                        strDocBan,
                        strPorBtx,
                        strCtaBtx,
                        strDocBtx: String;
                        fltPerCar,
                        fltValSta,
                        fltValTax: Double;
                        strNumCcd,
                        strDocume: String;
                        strSeqCom: String;
                        intSeqCon: Integer;
                        strEmpRcx: String;
                        strCodOpe: String = '';
                        blnResCai: Boolean = False;
                        strEmp_Pd: String = '';
                        strTipBai: String = 'F';
                        strCodFin: String = '';
                        strTipCar: string = 'TEF';
                        fltValIpi: Double = 0;
                        fltValRet: Double = 0;
                        fltValAce: Double = 0;
                        fltValFre: Double = 0;
                        strNumNsu: String = '';
                        strNumPok: String = '';
                        dtaDtaCup: TDateTime = 0;
                        fltVlTxGe: Double = 0;
                        fltVlTxPc: Double = 0;
                        dtaDtaTra: TDateTime = 0;
                        strCodigoCaixa: String = '';
                        blnRotinaYapay: boolean = False;
                        strSeqAnt: String = '';
                        strChaPix: String = '';
                        strPixS_N: String = 'N';
                        fltFreMKt: Double = 0;
                        blnRotinaFulfillment: boolean = False;
                        strCodigoCarteiraDigital: string = '';
                        AstrControle: String = '';
                        strAutIncAdt: String = '';
                        fltCupomMarketPlace: Double = 0;
                        strPorCar: String = '' ;
                        strCtaCar: String = '';
                        strCodVen: String = '';
                        fltValCbs: Double = 0;
                        fltValIbs: Double = 0;
                        fltVal_Is: Double = 0): Boolean;

  function fgetValorMinimoTaxaAdministracao(ACodigoCartao : String) : Double;

  function fAjustarTaxaDeAdministracao(ACodigoCartao,
                                        AValorAVista : TField;
                                        const ATaxaAdministracao,
                                              AValorOriginal,
                                              AValorDuplicata,
                                              APercentualCartao : TField) : Boolean; overload;

  function fAjustarTaxaDeAdministracao(ACodigoCartao : string;
                                       AValorAVista  : double;
                                       Var ATaxaAdministracao,
                                           AValorOriginal,
                                           AValorDuplicata,
                                           APercentualCartao : double) : Boolean; overload;

  procedure pArredondarValorDaTaxaAdministrativa(AValorBruto,
                                                 ATaxaAdministrativa: Double;
                                                 out AValorOriginal,
                                                     AValorDuplicata,
                                                     AValorTaxaAdministrativa: Double);
implementation

uses System.StrUtils;

function fRetSomenteNumeros(const AstrValor: String): String;
var
  LintCnt: Integer ;
begin
  Result := '' ;
  for LintCnt := 1 to Length(AstrValor) do
    if CharInSet(AstrValor[LintCnt], ['0'..'9']) then
      Result := Result + AstrValor[LintCnt] ;
end;

function fGravaMovCar(strNomFrmLogMca,
                      strDescriLogMca,
                      strNumDup,
                      strCodCli,
                      strParCel,
                      strCodEmp,
                      strCodCar: String;
                      dtaDtaCad,
                      dtaDtaVen: TDateTime;
                      fltValOri,
                      fltValDup: Double;
                      strHisT01,
                      strHisT02,
                      strConPag: String;
                      dtaDtaRec: TDateTime;
                      fltValRec: Double;
                      strOpeBai,
                      strHisBai,
                      strPorBai,
                      strCtaBai,
                      strDocBan,
                      strPorBtx,
                      strCtaBtx,
                      strDocBtx: String;
                      fltPerCar,
                      fltValSta,
                      fltValTax: Double;
                      strNumCcd,
                      strDocume: String;
                      strSeqCom: String;
                      intSeqCon: Integer;
                      strEmpRcx: String;
                      strCodOpe: String = '';
                      blnResCai: Boolean = False;
                      strEmp_Pd: String = '';
                      strTipBai: String = 'F';
                      strCodFin: String = '';
                      strTipCar: String = 'TEF';
                      fltValIpi: Double = 0;
                      fltValRet: Double = 0;
                      fltValAce: Double = 0;
                      fltValFre: Double = 0;
                      strNumNsu: String = '';
                      strNumPok: String = '';
                      dtaDtaCup: TDateTime = 0;
                      fltVlTxGe: Double = 0;
                      fltVlTxPc: Double = 0;
                      dtaDtaTra: TDateTime = 0;
                      strCodigoCaixa: String = '';
                      blnRotinaYapay: boolean = False;
                      strSeqAnt: String = '';
                      strChaPix: String = '';
                      strPixS_N: String = 'N';
                      fltFreMKt: Double = 0;
                      blnRotinaFulfillment: boolean = False;
                      strCodigoCarteiraDigital: string = '';
                      AstrControle: String = '';
                      strAutIncAdt: String = '';
                      fltCupomMarketPlace: Double = 0;
                      strPorCar: String = '' ;
                      strCtaCar: String = '';
                      strCodVen: String = '';
                      fltValCbs: Double = 0;
                      fltValIbs: Double = 0;
                      fltVal_Is: Double = 0): Boolean;

  Var
    strAutInc: String;
    qryMovCar: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
Begin

  Try
    strAutInc := fRetAutoIncrem('MOVCAR', VS_strCodEmp);

    if not blnRotinaYapay And Not blnRotinaFulfillment then
    begin
      pArredondarValorDaTaxaAdministrativa(fltValSta,
                                           fltPerCar,
                                           fltValOri,
                                           fltValDup,
                                           fltValTax);

      fAjustarTaxaDeAdministracao(strCodCar,
                                  fltValSta,
                                  fltValTax,
                                  fltValOri,
                                  fltValDup,
                                  fltPerCar);
    end;

    qryMovCar := fCriarQuery('SELECT * FROM MOVCAR WHERE FALSE');

    If (Not qryMovCar.Active) Then
      qryMovCar.Open;

    qryMovCar.Append;

    qryMovCar.FieldByName('MCA_NUMDUP').AsString   := strNumDup;
    qryMovCar.FieldByName('MCA_CODCLI').AsString   := strCodCli;
    qryMovCar.FieldByName('MCA_PARCEL').AsString   := strParCel;
    qryMovCar.FieldByName('MCA_CODEMP').AsString   := strCodEmp;
    qryMovCar.FieldByName('MCA_CODCAR').AsString   := strCodCar;
    qryMovCar.FieldByName('MCA_DTACAD').AsDateTime := dtaDtaCad;

    qryMovCar.FieldByName('MCA_DTAVEN').AsDateTime := dtaDtaVen;
    If dtaDtaVen < dtaDtaCad Then
      qryMovCar.FieldByName('MCA_DTAVEN').AsDateTime := dtaDtaCad;

    qryMovCar.FieldByName('MCA_VALORI').AsFloat    := fltValOri;
    qryMovCar.FieldByName('MCA_VALDUP').AsFloat    := fltValDup;
    qryMovCar.FieldByName('MCA_HIST01').AsString   := strHisT01;
    qryMovCar.FieldByName('MCA_HIST02').AsString   := strHisT02;
    qryMovCar.FieldByName('MCA_CONPAG').AsString   := strConPag;

    pAtribuirSetandoNullEmZero(qryMovCar.FieldByName('MCA_DTAREC'), dtaDtaRec);

    pAtribuirSetandoNullEmVazio(qryMovCar.FieldByName('MCA_DOCUME'), strDocume);

    qryMovCar.FieldByName('MCA_VALREC').AsFloat    := fltValRec;

    pAtribuirSetandoNullEmVazio(qryMovCar.FieldByName('MCA_OPEBAI'), strOpeBai);

    qryMovCar.FieldByName('MCA_HISBAI').AsString   := strHisBai;

    pAtribuirSetandoNullEmVazio(qryMovCar.FieldByName('MCA_PORBAI'), strPorBai);

    pAtribuirSetandoNullEmVazio(qryMovCar.FieldByName('MCA_CTABAI'), strCtaBai);

    qryMovCar.FieldByName('MCA_DOCBAN').AsString   := strDocBan;

    pAtribuirSetandoNullEmVazio(qryMovCar.FieldByName('MCA_PORBTX'), strPorBtx);

    pAtribuirSetandoNullEmVazio(qryMovCar.FieldByName('MCA_CTABTX'), strCtaBtx);

    qryMovCar.FieldByName('MCA_RESCAI').AsInteger := IIF(blnResCai, 1, 0);

    qryMovCar.FieldByName('MCA_DOCBTX').AsString   := strDocBtx;
    qryMovCar.FieldByName('MCA_PERCAR').AsFloat    := fltPerCar;
    qryMovCar.FieldByName('MCA_VALSTA').AsFloat    := fltValSta;
    qryMovCar.FieldByName('MCA_VALTAX').AsFloat    := fltValTax;
    qryMovCar.FieldByName('MCA_NUMCCD').AsString   := UpperCase(strNumCcd);

    pAtribuirSetandoClearEmVazio(qryMovCar.FieldByName('MCA_SEQCOM'), strSeqCom);

    qryMovCar.FieldByName('MCA_SEQCON').AsInteger  := intSeqCon;
    qryMovCar.FieldByName('MCA_EMPRCX').AsString   := IIF(fEmptyStr(strEmpRcx), strCodEmp, strEmpRcx);

    pAtribuirDesconsiderandoVazio(qryMovCar.FieldByName('MCA_EMP_PD'), strEmp_Pd);

    qryMovCar.FieldByName('AUTOINCREM').AsString   := strAutInc;
    qryMovCar.FieldByName('MCA_TIPBAI').AsString   := strTipBai;
    qryMovCar.FieldByName('MCA_TIPCAR').AsString   := strTipCar;

    pAtribuirSetandoClearEmVazio(qryMovCar.FieldByName('MCA_CODFIN'), strCodFin);

    qryMovCar.FieldByName('MCA_VALIPI').AsFloat := fltValIpi;
    qryMovCar.FieldByName('MCA_VALRET').AsFloat := fltValRet;
    qryMovCar.FieldByName('MCA_VALACE').AsFloat := fltValAce;
    qryMovCar.FieldByName('MCA_VALFRE').AsFloat := fltValFre;
    qryMovCar.FieldByName('MCA_VALCBS').AsFloat := fltValCbs;
    qryMovCar.FieldByName('MCA_VALIBS').AsFloat := fltValIbs;
    qryMovCar.FieldByName('MCA_VAL_IS').AsFloat := fltVal_Is;

    If fEmptyStr(strNumNsu) Then
      qryMovCar.FieldByName('MCA_NUMNSU').Clear
    Else If (blnRotinaFulfillment or blnRotinaYapay) Then
      qryMovCar.FieldByName('MCA_NUMNSU').AsString := strNumNsu
    Else
      qryMovCar.FieldByName('MCA_NUMNSU').AsString := fPadL(strNumNsu, 14, '0');

    pAtribuirSetandoNullEmVazio(qryMovCar.FieldByName('MCA_CODOPE'), strCodOpe);

    qryMovCar.FieldByName('MCA_NUMPOK').AsString := strNumPok;

    If (dtaDtaCup = 0) Then
      qryMovCar.FieldByName('MCA_DTACUP').Value := qryMovCar.FieldByName('MCA_DTACAD').Value
    Else
      qryMovCar.FieldByName('MCA_DTACUP').AsDateTime := dtaDtaCup;

    pAtribuirSetandoNullEmZero(qryMovCar.FieldByName('MCA_DTATRA'), dtaDtaTra);

    qryMovCar.FieldByName('MCA_VLTXGE').AsFloat := fltVlTxGe;
    qryMovCar.FieldByName('MCA_VLTXPC').AsFloat := fltVlTxPc;

    pAtribuirSetandoNullEmVazio(qryMovCar.FieldByName('MCA_CODCAX'), strCodigoCaixa);

    pAtribuirSetandoNullEmVazio(qryMovCar.FieldByName('MCA_SEQANT'), strSeqAnt);

    qryMovCar.FieldByName('MCA_CHAPIX').AsString := strChaPix;
    qryMovCar.FieldByName('MCA_PIXS_N').AsString := strPixS_N;
    qryMovCar.FieldByName('MCA_FREMKT').AsFloat  := fltFreMKt;

    qryMovCar.FieldByName('MCA_TRFLIB').AsString := 'S';

    qryMovCar.FieldByName('MCA_CARDIG').AsString := strCodigoCarteiraDigital;
    qryMovCar.FieldByName('MCA_CONTRO').AsString := AstrControle;
    qryMovCar.FieldByName('MCA_SEQADT').AsString := strAutIncAdt;

    pAtribuirSetandoNullEmVazio(qryMovCar.FieldByName('MCA_PORCAR'), strPorCar);
    pAtribuirSetandoNullEmVazio(qryMovCar.FieldByName('MCA_CTACAR'), strCtaCar);

    If fltCupomMarketPlace <> 0 Then
      qryMovCar.FieldByName('MCA_CUPMKT').AsFloat := fltCupomMarketPlace;

    pAtribuirSetandoNullEmVazio(qryMovCar.FieldByName('MCA_CODVEN'), strCodVen);

    qryMovCar.Post;

    Result := True;

    {$IFDEF LINUX}
      untLogMca.pGravaLogMca(strAutInc, strDescriLogMca, strNomFrmLogMca);
    {$ELSE }
      untLogMca.GravaLogMca(strAutInc, strDescriLogMca, strNomFrmLogMca);

      FreeAndNil(qryMovCar);
    {$ENDIF LINUX}
  Except
    On E: Exception Do
    Begin
      {$IFDEF LINUX}
      Raise;
      {$ELSE }
      Result := False;
      If (Not blnRotinaFulfillment) Then
        pMensagensErro(E.Message, '[fGravaMovCar]')
      Else
        Raise Exception.Create(E.Message);
      {$ENDIF LINUX}
    End;
  End;
End;

function fgetValorMinimoTaxaAdministracao(ACodigoCartao : String) : Double;
Var LQuery : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
Begin
  Result := 0.00;

  LQuery := fCriaQuery();
  Try
    LQuery.SQL.Text := 'SELECT CAR_TAXMIN FROM CADCAR WHERE CAR_CODCAR = :CODCAR ';
    LQuery.ParamByName('CODCAR').AsString := ACodigoCartao;
    LQuery.Open;
    if not LQuery.IsEmpty then
      Result := LQuery.FieldByName('CAR_TAXMIN').AsFloat;
    LQuery.Close;
  Finally
    {$IFNDEF LINUX}
    FreeAndNil(LQuery);
    {$ENDIF LINUX}
  End;
end;

function fAjustarTaxaDeAdministracao(ACodigoCartao, AValorAVista : TField; const ATaxaAdministracao,
  AValorOriginal, AValorDuplicata, APercentualCartao : TField) : Boolean;
var LValorTaxaMinimoAdministracao : Double;
begin
  Result := False;

  if (ACodigoCartao.IsNull) or (AValorAVista.IsNull) then
    Exit;

  ATaxaAdministracao.Value := AValorAVista.Value - AValorDuplicata.Value;

  LValorTaxaMinimoAdministracao := fgetValorMinimoTaxaAdministracao(ACodigoCartao.Value);
  if (LValorTaxaMinimoAdministracao > 0) and
     (LValorTaxaMinimoAdministracao > ATaxaAdministracao.Value) then
  begin
    ATaxaAdministracao.Value := LValorTaxaMinimoAdministracao;
    AValorOriginal.Value     := AValorAVista.Value - ATaxaAdministracao.Value;
    AValorDuplicata.Value    := AValorAVista.Value - ATaxaAdministracao.Value;
    APercentualCartao.Value  := (LValorTaxaMinimoAdministracao/AValorAVista.Value)*100;

    Result := True;
  end;
end;

function fAjustarTaxaDeAdministracao(ACodigoCartao : string; AValorAVista  : double;  Var ATaxaAdministracao,
  AValorOriginal, AValorDuplicata, APercentualCartao : double) : Boolean;
var LValorTaxaMinimoAdministracao : Double;
begin
  Result := False;

  LValorTaxaMinimoAdministracao := fgetValorMinimoTaxaAdministracao(ACodigoCartao);
  if (LValorTaxaMinimoAdministracao > 0) and
     (LValorTaxaMinimoAdministracao > ATaxaAdministracao) then
  begin
    ATaxaAdministracao := LValorTaxaMinimoAdministracao;
    AValorOriginal     := AValorAVista - ATaxaAdministracao;
    AValorDuplicata    := AValorAVista - ATaxaAdministracao;
    APercentualCartao  := (LValorTaxaMinimoAdministracao/AValorAVista)*100;

    Result := True;
  end;
end;

procedure pArredondarValorDaTaxaAdministrativa(AValorBruto,
                                               ATaxaAdministrativa: Double;
                                               out AValorOriginal,
                                                   AValorDuplicata,
                                                   AValorTaxaAdministrativa: Double);
Begin
  AValorTaxaAdministrativa := fFormataFloat(AValorBruto * (ATaxaAdministrativa / 100), 2);

  AValorOriginal  := fFormataFloat(AValorBruto - AValorTaxaAdministrativa, 2);
  AValorDuplicata := fFormataFloat(AValorBruto - AValorTaxaAdministrativa, 2);
End;

end.
