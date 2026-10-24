unit untCalculoPrecoMedio;

interface

uses untIConfiguracao, Uni, StrUtils, untTypesSistema;

Type
  TCalculoPrecoMedio = class(TInterfacedObject)
    strict private
      class var objPreMed: TCalculoPrecoMedio;

      strCodFis,
      strClaFis: String;
      fltPreMed,
      fltSaldos,
      fltQtdNov,
      fltUniNov,
      fltAlqIcm,
      fltAlqFrete,
      fltValorOutrasDespesas,
      fltValIpi: Double;
      fltValRet,
      fltValGnr,
      fltValICMS,
      fltValICMSNaoCreditado,
      fltValTCIF,
      fltValTS,
      fltValAnt: Double;
      blnContribuinteIpi: Boolean;
      blnIncidePIS: Boolean;
      blnForFil: Boolean;
      fltValFre: Double;
      blnIpiNaoCreditado: Boolean;
      fltValorFundoCombateAPobreza: Double;
      strMemCal: String;


      objCfg: IConfiguracao;
      qryPreMed : TUniQuery;
      qryMovDet : TUniQuery;
      qryUpdMovDet : TUniQuery;

      Constructor Create(objCfg: IConfiguracao);

      procedure pIniciaValores;
      procedure pValidarValores;
      function fTemAntecipacaoIcms: Boolean;
    public
      Destructor Destroy; override;

      class function fGetPreMed(objCfg: IConfiguracao): TCalculoPrecoMedio;
      class procedure pLiberaMemoria;

      function CstIcms(strCst: String): TCalculoPrecoMedio;
      function ClassificaoFiscal(strClassif: String): TCalculoPrecoMedio;
      function PrecoMedio(fltPrecoMedio: Double): TCalculoPrecoMedio;
      function Saldo(fltSaldo: Double): TCalculoPrecoMedio;
      function NovaQuantidade(fltNovaQuantidade: Double): TCalculoPrecoMedio;
      function NovoUnitario(fltNovoUnitario: Double): TCalculoPrecoMedio;
      function AliquotaIcms(fltAlqIcms: Double): TCalculoPrecoMedio;
      function ValorIpi(fltValorIpi: Double): TCalculoPrecoMedio;
      function ValorRetido(fltValorRetido: Double): TCalculoPrecoMedio;

      function ValorGNRE(fltValorGNRE: Double): TCalculoPrecoMedio;
      function ValorICMS(fltValorValorICMS: Double): TCalculoPrecoMedio;
      function ValorICMSNaoCreditado(fltValorValorICMSNaoCreditado: Double): TCalculoPrecoMedio;
      function fValorTCIF(fltValorTCIF: Double): TCalculoPrecoMedio;
      function fValorTS(fltValorTS: Double): TCalculoPrecoMedio;

      function IcmsAntecipado(fltIcmsAntecipado: Double): TCalculoPrecoMedio;
      function ContribuinteIPI(blnConIPI: Boolean): TCalculoPrecoMedio;
      function IncidePIS(blnIncPis: Boolean): TCalculoPrecoMedio;
      function Frete(fltFrete: Double): TCalculoPrecoMedio;
      function AliquotaFrete(fltAliquotaFrete: Double): TCalculoPrecoMedio;
      function ValorOutrasDespesas(fltValorOutrasDespesas: Double): TCalculoPrecoMedio;
      function ValorFundoCombateAPobreza(fltValor: Double): TCalculoPrecoMedio;
      function FornecedorFilial(blnFornecFilial: Boolean): TCalculoPrecoMedio;
      function IpiNaoCreditado(AblnIpiNaoCreditado: Boolean):TCalculoPrecoMedio;


      function fPrecoMedio: Double;
      function fFormataValor(Valor: Double; Format: String): String;
      function fGravaCalcPreMed(strAutDet, strLocal : String; strCodIte: String = ''; fltMedNov: Double = 0; strAutIncPREMED: String = ''; blnUpdateDet_TotMed: Boolean = False) : Boolean;
  End;

implementation

uses SysUtils, untConstantes, untFuncoesSimples;

{ TCalculoPrecoMedio }

constructor TCalculoPrecoMedio.Create(objCfg: IConfiguracao);
begin
  Inherited Create;
  pIniciaValores;
  Self.objCfg := objCfg;

  qryMovDet := fCriaQuery;
  qryUpdMovDet := fCriaQuery;
  qryUpdMovDet.SQL.Text := 'UPDATE MOVDET SET DET_TOTMED = :TOTMED * DET_QTDITE WHERE AUTOINCREM = :AUTINC';
  With qryMovDet, SQL Do
  Begin
    Close;
    Clear;
    Add(' SELECT DET_CODITE,         ');
    Add('        DET_CODEMP          ');
    Add(' FROM MOVDET                ');
    Add(' WHERE AUTOINCREM = :AUTINC ');
  End;

  qryPreMed := fCriaQuery;
  With qryPreMed, SQL Do
  Begin
    Close;
    Clear;
    Add('  INSERT INTO PREMED (AUTOINCREM, ');
    Add('                      MED_DTAALT, ');
    Add('                      MED_HRAALT, ');
    Add('                      DET_SEQGER, ');
    Add('                      ITE_CODITE, ');
    Add('                      ITE_CODEMP, ');
    Add('                      ITE_SALANT, ');
    Add('                      ITE_MEDANT, ');
    Add('                      ITE_COMANT, ');
    Add('                      ITE_INCPIS, ');
    Add('                      CFG_CONIPI, ');
    Add('                      CFG_ICMPRM, ');
    Add('                      CFG_DEDPIS, ');
    Add('                      CFG_ALQPIS, ');
    Add('                      CFG_ALQCOF, ');
    Add('                      CFG_FREMED, ');
    Add('                      CFG_ATUMED, ');
    Add('                      CFG_CLACOM, ');
    Add('                      CFG_MEDSE2, ');
    Add('                      ITE_SALNOV, ');
    Add('                      ITE_MEDNOV, ');
    Add('                      PRM_LOCAL_, ');
    Add('                      ITE_MECALC) ');
    Add('               VALUES( :AUTINC,   ');
    Add('                       :DTAALT,   ');
    Add('                       :HRAALT,   ');
    Add('                       :SEQGER,   ');
    Add('                       :CODITE,   ');
    Add('                       :CODEMP,   ');
    Add('                       :SALANT,   ');
    Add('                       :MEDANT,   ');
    Add('                       :COMANT,   ');
    Add('                       :INCPIS,   ');
    Add('                       :CONIPI,   ');
    Add('                       :ICMPRM,   ');
    Add('                       :DEDPIS,   ');
    Add('                       :ALQPIS,   ');
    Add('                       :ALQCOF,   ');
    Add('                       :FREMED,   ');
    Add('                       :ATUMED,   ');
    Add('                       :CLACOM,   ');
    Add('                       :MEDSE2,   ');
    Add('                       :SALNOV,   ');
    Add('                       :MEDNOV,   ');
    Add('                       :LOCAL_,   ');
    Add('                       :MECALC)   ');

  End;

end;

procedure TCalculoPrecoMedio.pIniciaValores;
Begin
  strClaFis          := '';
  strCodFis          := '';
  fltPreMed          := -1;
  fltSaldos          := -1;
  fltQtdNov          := -1;
  fltUniNov          := -1;
  fltAlqIcm          := -1;
  fltValIpi          := -1;
  fltValRet          := -1;
  fltValGnr          := 0;
  fltValICMS         := 0;
  fltValICMSNaoCreditado := 0;
  fltValTCIF         := 0;
  fltValTS           := 0;

  fltValAnt          := -1;
  blnContribuinteIpi := False;
  blnIncidePIS       := False;
  blnForFil          := False;
  fltValFre          := -1;

  strMemCal          := '';

End;

class function TCalculoPrecoMedio.fGetPreMed(objCfg: IConfiguracao): TCalculoPrecoMedio;
begin
  If Not Assigned(objPreMed) Then
    objPreMed := TCalculoPrecoMedio.Create(objCfg);

  Result := objPreMed;
end;

function TCalculoPrecoMedio.fGravaCalcPreMed(strAutDet, strLocal: String; strCodIte: String = ''; fltMedNov: Double = 0; strAutIncPREMED: String = ''; blnUpdateDet_TotMed: Boolean = False): Boolean;
begin
  Result := True;
  Try
    If Not fEmptyStr(strAutDet) Then
    With qryMovDet, SQL Do
    Begin
      Close;
      ParamByName('AUTINC').AsString := strAutDet;
      Open;
    End;

    With qryPreMed, SQL Do
    Begin
      If strAutIncPREMED.IsEmpty Then
        ParamByName('AUTINC').AsString := fRetAutoIncrem('PREMED', VS_strCodEmp)
      Else
        ParamByName('AUTINC').AsString := strAutIncPREMED;

      ParamByName('MEDANT').Clear;
      ParamByName('COMANT').Clear;

      If Not fEmptyStr(strAutDet) Then
      Begin
        ParamByName('SEQGER').AsString := strAutDet;
        ParamByName('CODITE').AsString := qryMovDet.FieldByName('DET_CODITE').AsString;
        ParamByName('CODEMP').AsString := qryMovDet.FieldByName('DET_CODEMP').AsString;

        ParamByName('MEDNOV').AsFloat  := fPrecoMedio;

        If (fCfgSis('BASMED') <> 'S') Then
          ParamByName('MEDANT').AsFloat := fltPreMed
        Else
          ParamByName('COMANT').AsFloat := fltPreMed;
      End;

      If Not fEmptyStr(strCodIte) Then
      Begin
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('MEDNOV').AsFloat  := fltMedNov;
        ParamByName('MEDANT').AsFloat  := fltPreMed;
      End;

      ParamByName('SALANT').AsFloat    := fltSaldos;
      ParamByName('DTAALT').AsDateTime := VS_Date;
      ParamByName('HRAALT').AsDateTime := fTime();

      ParamByName('INCPIS').AsString := IfThen(blnIncidePIS, 'S', 'N');

      ParamByName('CONIPI').AsString := fCfgSis('CONIPI', varString);
      ParamByName('ICMPRM').AsString := fCfgSis('ICMPRM', varString);
      ParamByName('DEDPIS').AsString := fCfgSis('DEDPIS', varString);
      ParamByName('ALQPIS').AsFloat  := fCfgSis('ALQPIS', varDouble);
      ParamByName('ALQCOF').AsFloat  := fCfgSis('ALQCOF', varDouble);
      ParamByName('FREMED').AsString := fCfgSis('FREMED', varString);
      ParamByName('ATUMED').AsString := fCfgSis('ATUMED', varString);
      ParamByName('CLACOM').AsString := fCfgSis('CLACOM', varString);
      ParamByName('MEDSE2').AsString := fCfgSis('MEDSE2', varString);

      ParamByName('SALNOV').AsFloat  := fltSaldos + fltQtdNov;

      ParamByName('LOCAL_').AsString := strLocal;
      ParamByName('MECALC').AsString := strMemCal;

      ExecSQL;
      If blnUpdateDet_TotMed and (not fEmptyStr(strAutDet)) Then
      begin
        qryUpdMovDet.paramByName('TOTMED').AsFloat := fPrecoMedio;
        qryUpdMovDet.paramByName('AUTINC').AsString :=  strAutDet;
        qryUpdMovDet.ExecSQL;
      end;
    End;

    pIniciaValores;
  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TCalculoPrecoMedio.fGravaCalcPreMed');
    End;
  End;
end;

function TCalculoPrecoMedio.fFormataValor(Valor: Double; Format: String): String;
Begin
  Result := FormatFloat(Format, StrToFloat(AnsiReplaceStr(FloatToStr(Valor), '.', '')));
End;

function TCalculoPrecoMedio.fPrecoMedio: Double;
  Var
    fltPreAtu : Double;
    fltSalAtu : Double;
    fltPreNov : Double;
    fltSalNov : Double;
    fltGnre: Double;

    fltIcmFin : Double;
    fltIcmFinPisCof : Double;
    fltIpiFin : Double;
    fltRetFin : Double;
    fltAntFin : Double;
    fltPisFin : Double;
    fltOutDes: Double;
    fltAlqCof: Double;
    fltAlqPis : Double;
    fltPisCof : Double;
    fltFreUni : Double;
    fltVFCPST,
    fltBasPis,
    fltValPis,
    fltValCof : Double;
    fltTotSubFre: Double;
    blnDeduzirPisCofinsIPIPrecoMedio,
    blnDeduzirPisCofinsSTPrecoMedio,
    blnSomaIpi: Boolean;
    blnDPCPRM: Boolean;
    blnDICMFR: Boolean;
    blnPermiteDeduzirPisCofins_e_Icms_Em_Transferencia,
    blnDeduzirICMSdaBaseCalculoPisCofins,
    blnSomarFretenaBaseCalculoPisCofins: Boolean;

    const x51 = '_051_151_251_351_451_551_651_751_' ;

begin
  pValidarValores;

  If Pos(strClaFis, fRetornarClassificacoesBonificacaoEntrada) > 0 Then
    fltUniNov := 0;

  fltPreAtu := fltPreMed;
  fltSalAtu := fltSaldos;
  fltPreNov := fltUniNov;
  fltSalNov := fltQtdNov;
  fltAlqPis := objCfg.fCfgSis('ALPISP', varDouble);
  fltAlqCof := objCfg.fCfgSis('ALCOFP', varDouble);
  fltPisCof := fltAlqPis + fltAlqCof;
  blnSomaIpi := objCfg.fCfgSis('BASPIS') = '2';
  blnDPCPRM := fCfgSis('DPCPRM') = 'S';
  blnDICMFR := fCfgSis('DICMFR') = 'S';
  blnPermiteDeduzirPisCofins_e_Icms_Em_Transferencia := fCfgSis('TRDPCI') = 'S';
  fltIcmFin := 0;
  fltIpiFin := 0;
  fltRetFin := 0;
  fltAntFin := 0;
  fltPisFin := 0;
  fltVFCPST := 0;
  fltOutDes := 0;
  fltValPis := 0;
  fltValCof := 0;

  strMemCal:= '';

  blnDeduzirPisCofinsIPIPrecoMedio     := fCfgSis('DPCIPM') = 'S';
  blnDeduzirPisCofinsSTPrecoMedio      := fCfgSis('DPCIPS') = 'S';
  blnDeduzirICMSdaBaseCalculoPisCofins := fCfgSis('DICPIS') = 'S';
  blnSomarFretenaBaseCalculoPisCofins  := fCfgSis('PISFRP') = 'S';

  If ((Pos(strCodFis, CST_TRIBUTADO) > 0) Or (Pos(strCodFis, x51) > 0) And (fltValICMS > 0)) And (objCfg.fCfgSis('ICMPRM', varBoolean)) And ((Not blnForFil) Or (blnForFil And blnPermiteDeduzirPisCofins_e_Icms_Em_Transferencia)) Then
  Begin
    If (Pos(strCodFis, x51) > 0) And (fltValICMS > 0) Then
      fltIcmFin := fltValICMS/fltQtdNov
    Else
      fltIcmFin := ((fltPreNov * fltAlqIcm )/100);
  End;

  If blnContribuinteIpi and blnIpiNaoCreditado then
  Begin
    fltIpiFin := (fltValIpi / fltQtdNov);

    If blnDeduzirPisCofinsIPIPrecoMedio And ((blnIncidePIS) And objCfg.fCfgSis('DEDPIS', varBoolean) And ((Not blnForFil) Or (blnForFil And blnPermiteDeduzirPisCofins_e_Icms_Em_Transferencia))) Then
      fltIpiFin := (fltIpiFin * (1- (fltPisCof/100)));
  End
  Else If (Not blnContribuinteIpi) Then
  Begin
    If ((objCfg.fCfgSis('IMPDIR', varBoolean) And blnIpiNaoCreditado) Or ((Not objCfg.fCfgSis('IMPDIR', varBoolean)))) Then
    Begin
      fltIpiFin := (fltValIpi / fltQtdNov);

      If blnDeduzirPisCofinsIPIPrecoMedio And ((blnIncidePIS) And objCfg.fCfgSis('DEDPIS', varBoolean) And ((Not blnForFil) Or (blnForFil And blnPermiteDeduzirPisCofins_e_Icms_Em_Transferencia))) Then
        fltIpiFin := (fltIpiFin * (1- (fltPisCof/100)));
    End;
  End;

  If (blnIncidePIS) And objCfg.fCfgSis('DEDPIS', varBoolean) And ((Not blnForFil) Or (blnForFil And blnPermiteDeduzirPisCofins_e_Icms_Em_Transferencia)) Then
  Begin
    fltBasPis := fltPreNov;

    If blnSomaIpi Then
      fltBasPis := fltBasPis + fltIpiFin;

    If blnDeduzirICMSdaBaseCalculoPisCofins Then
    Begin
      fltIcmFinPisCof := (fltValICMS + fltValICMSNaoCreditado) / fltQtdNov;
      fltBasPis := fltBasPis - fltIcmFinPisCof;
    End;

    If blnSomarFretenaBaseCalculoPisCofins Then
      fltBasPis := fltBasPis + fltValFre / fltQtdNov;

    fltPisFin := ((fltBasPis * fltPisCof ) / 100);

    // APENAS PARA MEMÓRIA DE CÁLCULO
    fltValPis := ((fltBasPis * fltAlqPis ) / 100);
    fltValCof := ((fltBasPis * fltAlqCof ) / 100);
  End;

  If (Pos(strCodFis, CST_SUBSTITUICAO) > 0) Then
  Begin
    fltRetFin := (fltValRet / fltQtdNov);
    If blnDeduzirPisCofinsSTPrecoMedio And ((blnIncidePIS) And objCfg.fCfgSis('DEDPIS', varBoolean) And ((Not blnForFil) Or (blnForFil And blnPermiteDeduzirPisCofins_e_Icms_Em_Transferencia))) Then
      fltRetFin := (fltRetFin * (1- (fltPisCof/100)));
  End;

  fltGnre := (fltValGnr + fltValTCIF + fltValTS) / fltQtdNov;

  If (Pos(strCodFis, CST_ANTECIPACAO_ICMS) > 0) And fTemAntecipacaoIcms Then
  Begin
    fltAntFin := (fltValAnt / fltQtdNov);
  End;

  If (Not objCfg.fCfgSis('FREMED', varBoolean)) Or (fltQtdNov = 0.0) Then
  Begin
    fltFreUni := 0
  End
  Else
  Begin
    fltTotSubFre := 0;

    If blnDPCPRM And ((blnIncidePIS) And objCfg.fCfgSis('DEDPIS', varBoolean)) Then
      fltTotSubFre := ((fltValFre * fltPisCof) /100);

    If blnDICMFR Then
      fltTotSubFre := fltTotSubFre + ((fltValFre * fltAlqFrete) /100);

    fltFreUni := (fltValFre - fltTotSubFre) / fltQtdNov;

    fltOutDes := fltValorOutrasDespesas / fltQtdNov;
  End;

  if fltValorFundoCombateAPobreza > 0 then
  Begin
    fltVFCPST := fltValorFundoCombateAPobreza / fltQtdNov;
  End;

  strMemCal := strMemCal + 'Preço Novo: ';
  strMemCal := strMemCal + 'Preço Item ('+fFormataValor(fltPreNov, '#,##0.0000')+')'+ #$A;
  strMemCal := strMemCal +'          - '+ 'ICMS ('+fFormataValor(fltIcmFin, '#,##0.0000')+')'+ #$A;
  strMemCal := strMemCal +'          + '+ 'IPI ('+fFormataValor(fltIpiFin, '#,##0.0000')+')' + #$A;
  strMemCal := strMemCal +'          + '+ 'ICMS Subst. ('+fFormataValor(fltRetFin, '#,##0.0000')+')' + #$A;
  strMemCal := strMemCal +'          + '+ 'Vlr. GNRE ('+fFormataValor(fltGnre, '#,##0.0000')+')' + #$A;
  strMemCal := strMemCal +'          + '+ 'Ant. ICMS ('+ fFormataValor(fltAntFin, '#,##0.0000')+')' + #$A;
  strMemCal := strMemCal +'          - '+ 'PIS ('+ fFormataValor(fltValPis, '#,##0.0000')+')' + #$A;
  strMemCal := strMemCal +'          - '+ 'COFINS ('+ fFormataValor(fltValCof, '#,##0.0000')+')' + #$A;
  strMemCal := strMemCal +'          + '+ 'Frete ('+fFormataValor(fltFreUni, '#,##0.0000')+')' + #$A;
  strMemCal := strMemCal +'          + '+ 'Outras Despesas ('+fFormataValor(fltOutDes, '#,##0.0000')+')' + #$A;
  strMemCal := strMemCal +'          + '+ 'Fundo de Comb. ST ('+ fFormataValor(fltVFCPST, '#,##0.0000')+')' + #$A;

  fltPreNov := fltPreNov - fltIcmFin + fltIpiFin + fltRetFin + fltAntFin - fltPisFin + fltFreUni + fltOutDes + fltVFCPST + fltGnre;

  strMemCal := strMemCal + '          = '+fFormataValor(fltPreNov, '#,##0.0000')+'' + #$A#$D;

  If fltPreNov < 0 Then
    fltPreNov := 0;

  If (fltPreAtu <= 0.0) Or (fltSalAtu <= 0.0) Then
  Begin
    Result := fltPreNov;
  End
  Else
  Begin
    Result := ((fltPreAtu * fltSalAtu) + (fltPreNov * fltSalNov));
    strMemCal:= strMemCal + 'Preço do Estoque:  Preço Atual(' + fFormataValor(fltPreAtu, '#,##0.0000') + ') * Saldo Atual(' + fFormataValor(fltSalAtu, '#,##0.00') + ')' + #$A;
    strMemCal:= strMemCal + '                 + Preço Novo (' + fFormataValor(fltPreNov, '#,##0.0000') + ') * Saldo Novo(' + fFormataValor(fltSalNov, '#,##0.00')+ ')' + #$A;
    strMemCal:= strMemCal + '                 = ' +  fFormataValor(Result, '#,##0.00') + #$A;

    strMemCal:= strMemCal + 'Preço Médio:  Preço do Estoque('+ fFormataValor(Result, '#,##0.0000') + ') / ' +
                                                          ' (Saldo Atual(' + fFormataValor(fltSalAtu, '#,##') + ') + Saldo Novo(' + fFormataValor(fltSalNov, '#,##0.00') + '))' + #$A;

    Result := (Result / (fltSalAtu + fltSalNov));

    strMemCal:= strMemCal + '            = ' +  fFormataValor(Result, '#,##0.0000');
  End;

  Result := fFormataFloat(Result, 4);
end;

destructor TCalculoPrecoMedio.Destroy;
begin
  FreeAndNil(qryPreMed);
  FreeAndNil(qryMovDet);
  FreeAndNil(qryUpdMovDet);
  Inherited;
end;

class procedure TCalculoPrecoMedio.pLiberaMemoria;
begin
  If Assigned(objPreMed) Then
    FreeAndNil(objPreMed);
end;

Function TCalculoPrecoMedio.fTemAntecipacaoIcms: Boolean;
Begin
  Result := objCfg.fCfgSis('ANTICM', varBoolean);
End;

function TCalculoPrecoMedio.AliquotaFrete(fltAliquotaFrete: Double): TCalculoPrecoMedio;
begin
  Self.fltAlqFrete := fltAliquotaFrete;
  Result := Self;

end;

function TCalculoPrecoMedio.ValorOutrasDespesas(fltValorOutrasDespesas: Double): TCalculoPrecoMedio;
begin
  Self.fltValorOutrasDespesas := fltValorOutrasDespesas;
  Result := Self;

end;

function TCalculoPrecoMedio.AliquotaIcms(
  fltAlqIcms: Double): TCalculoPrecoMedio;
begin
  Self.fltAlqIcm := fltAlqIcms;
  Result := Self;
end;

function TCalculoPrecoMedio.ContribuinteIPI(
  blnConIPI: Boolean): TCalculoPrecoMedio;
begin
  Self.blnContribuinteIpi := blnConIPI;
  Result := Self;
end;

function TCalculoPrecoMedio.CstIcms(strCst: String): TCalculoPrecoMedio;
begin
  Self.strCodFis := strCst;
  Result := Self;
end;

function TCalculoPrecoMedio.ClassificaoFiscal(strClassif: String): TCalculoPrecoMedio;
begin
  Self.strClaFis  := strClassif;
  Result := Self;
end;

function TCalculoPrecoMedio.Frete(fltFrete: Double): TCalculoPrecoMedio;
begin
  Self.fltValFre := fltFrete;
  Result := Self;
end;

function TCalculoPrecoMedio.IcmsAntecipado(
  fltIcmsAntecipado: Double): TCalculoPrecoMedio;
begin
  Self.fltValAnt := fltIcmsAntecipado;
  Result := Self;
end;

function TCalculoPrecoMedio.IncidePIS(blnIncPis: Boolean): TCalculoPrecoMedio;
begin
  Self.blnIncidePIS := blnIncPis;
  Result := Self;
end;

function TCalculoPrecoMedio.IpiNaoCreditado(
  AblnIpiNaoCreditado: Boolean): TCalculoPrecoMedio;
begin
  Self.blnIpiNaoCreditado := AblnIpiNaoCreditado;
  Result := Self;
end;

function TCalculoPrecoMedio.FornecedorFilial(blnFornecFilial: Boolean): TCalculoPrecoMedio;
begin
  Self.blnForFil := blnFornecFilial;
  Result := Self;
end;

function TCalculoPrecoMedio.NovaQuantidade(
  fltNovaQuantidade: Double): TCalculoPrecoMedio;
begin
  Self.fltQtdNov := fltNovaQuantidade;
  Result := Self;
end;

function TCalculoPrecoMedio.NovoUnitario(
  fltNovoUnitario: Double): TCalculoPrecoMedio;
begin
  Self.fltUniNov := fltNovoUnitario;
  Result := Self;
end;

function TCalculoPrecoMedio.PrecoMedio(
  fltPrecoMedio: Double): TCalculoPrecoMedio;
begin
  Self.fltPreMed := fltPrecoMedio;
  Result := Self;
end;

procedure TCalculoPrecoMedio.pValidarValores;
begin
  If fltPreMed < 0 Then
    Raise Exception.Create('O preço médio do item está negativo.');

  If fltQtdNov < 0 Then
    Raise Exception.Create('Quantidade de entrada está negativa para o cálculo do preço médio.');

  If fltUniNov < 0 Then
    Raise Exception.Create('O novo unitário está negativo para o cálculo do preço médio.');

  If fltAlqIcm < 0 Then
    Raise Exception.Create('A alíquota de ICMS está negativo para o cálculo do preço médio.');

  If fltValIpi < 0 Then
    Raise Exception.Create('O valor do IPI está negativo para o cálculo do preço médio.');

  If fltValRet < 0 Then
    Raise Exception.Create('O valor de ICMS retido está negativo para o cálculo do preço médio.');

  If fltValAnt < 0 Then
    Raise Exception.Create('O valor icms antecipado está negativo para o cálculo do preço médio.');

  If fltValFre < 0 Then
    Raise Exception.Create('O valor do frete está negativo para o cálculo do preço médio.');

  If (fltValIcmsNaoCreditado > 0) And (fltValIcms > 0) Then
    Raise Exception.Create('Os valores de ICMS e ICMS não creditado não podem ser ambos maiores que zero.');
end;

function TCalculoPrecoMedio.Saldo(fltSaldo: Double): TCalculoPrecoMedio;
begin
  Self.fltSaldos := fltSaldo;
  Result := Self;
end;

function TCalculoPrecoMedio.ValorICMS(
  fltValorValorICMS: Double): TCalculoPrecoMedio;
begin
  Self.fltValICMS := fltValorValorICMS;
  Result := Self;
end;

function TCalculoPrecoMedio.ValorICMSNaoCreditado(
  fltValorValorICMSNaoCreditado: Double): TCalculoPrecoMedio;
begin
  Self.fltValICMSNaoCreditado := fltValorValorICMSNaoCreditado;
  Result := Self;
end;

function TCalculoPrecoMedio.ValorIpi(fltValorIpi: Double): TCalculoPrecoMedio;
begin
  Self.fltValIpi := fltValorIpi;
  Result := Self;
end;

function TCalculoPrecoMedio.ValorRetido(fltValorRetido: Double): TCalculoPrecoMedio;
begin
  Self.fltValRet := fltValorRetido;
  Result := Self;
end;

function TCalculoPrecoMedio.ValorFundoCombateAPobreza(
  fltValor: Double): TCalculoPrecoMedio;
begin
  Self.fltValorFundoCombateAPobreza := fltValor;
  Result := Self;
end;

function TCalculoPrecoMedio.ValorGNRE(fltValorGNRE: Double): TCalculoPrecoMedio;
begin
  Self.fltValGnr := fltValorGNRE;
  Result := Self;
end;

function TCalculoPrecoMedio.fValorTCIF(fltValorTCIF: Double): TCalculoPrecoMedio;
begin
  Self.fltValTCIF := fltValorTCIF;
  Result := Self;

end;

function TCalculoPrecoMedio.fValorTS(fltValorTS: Double): TCalculoPrecoMedio;
begin
  Self.fltValTS := fltValorTS;
  Result := Self;

end;




end.
