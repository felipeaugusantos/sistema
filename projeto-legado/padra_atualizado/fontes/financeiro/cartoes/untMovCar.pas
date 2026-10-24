unit untMovCar;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Uni, System.Variants, untFuncFatImp,
  untTypesSistema, UniClientDataSet, untLogMca, cxProgressBar, Vcl.Forms,
  System.StrUtils, untGravandoObs, untSubjectClass, untSubjectIntf, untLogBan,
  untGravaMovCar,  untConciliacaoCartoes;

  function fBaixaCartao(strNomFrmLogMca,
                        strDescriLogMca,
                        strAutInc,
                        strNumDup,
                        strParcel,
                        strCodCli,
                        strCodEmp: String;
                        dtaDtaRec: TDateTime;
                        fltValRec: Double;
                        strOpeBai,
                        strHisBai,
                        strPorBai,
                        strCtaBai,
                        strDocBan,
                        strPorBtx,
                        strCtaBtx,
                        strDocBtx,
                        strForBtx,
                        strCtaDeb,
                        strPorDeb: String;
                        strDocDeb: String;
                        strChaCon: String = '';
                        strEveDeb: String = '';
                        strCtaAnt: String = '';
                        strDocAnt: String = '';
                        fltAntTax: Double = 0;
                        strAutIncLogMCA: String = '';
                        AstrEventoCredito : string = '';
                        AstrEventoTaxa : string = '';
                        AFreteMarketPlace: Double = 0.00;
                        AAjusteMarketPlace: Double = 0.00;
                        AValorTaxaMarketPlace: Double = 0.00;
                        ACupomMarketPlace: Double = 0.00;
                        ADeveAtualizarValorBruto: Boolean = False;
                        ANovoValorBruto: Double = 0.00;
                        ASeqLanFrete: String = '';
                        ASeqLanAjuste: String = '';
                        ASeqLanCupom: String = ''): Boolean;

  function fDuplicataCartaoBaixada(strNumDup, strParcel, strCodCli, strCodEmp: String): Boolean;

  function fAcertaHistoricoMovCar(objCartoes: TCartoesResumoCaixaArray; strCodCli, strCodEmp: String; objFatVenda: TFatVendaImp): Boolean;
  procedure pAcertaHistoricoMovCarPeloDesmembramentoPedido(strNumDoc, strEspDoc, strCodEmp, strAutInc: String);

  procedure AtualizarConciliacaoConfirmacaoCartao(ANumNsu,ANumCcd,AParcel,AOperadora: String; ADtaCup : TDateTime);
  procedure LimparConciliacaoConfirmacaoCartao(ANumNsu,ANumCcd,AParcel,AOperadora: String; ADtaCup : TDateTime);

  function fGetSQLCartoes(objConcil: TCamposConcil): String;

  procedure pGravaLogMca(strAutInc, strDescricaoLog, strNomForm: String);
  procedure pApagaCartao(strAutInc, strNomFrm: String);

  function fExisteEstabelecimentosDuplicados(var AConfiguracao: String): Boolean;
  function ExisteChaveDeAutorizacaoDuplicada(AConcilidadora: String): Boolean;
  function RetornaConfiguracaoChaveApi(AConcilidadora: String): String;

  function fSetConcil(strNomCon: String): TConciliacaoCartoes;

  function fGetSqlAtualizaTipoParcelamentoTEF(ANumDup, ACodCli, ACodEmp, ATpParc: String; ASeqCon: Integer): String;

  function TransferenciaLiberada(AUsaLiberacaoTransferencia,
                                 AVeioResumoCaixa: Boolean;
                                 ACartaoLiberado: String): Boolean;

  function CartaoBloqueado(AQryMovCar: TDataSet; ARcxTcc: String = ''): Boolean;

  function RetornaDatasetCartoesTransferidos(ANumeroDuplicata,
                                             ACodigoEmpresa,
                                             ACodigoCliente: String;
                                             ADataCadastro: TDateTime;
                                             ASequencialTF: Integer = 0): TDataset;

implementation

uses untFuncoesSimples, untFuncoes,
     untConciliacaoKoncilia;

function fBaixaCartao(strNomFrmLogMca,
                      strDescriLogMca,
                      strAutInc,
                      strNumDup,
                      strParcel,
                      strCodCli,
                      strCodEmp: String;
                      dtaDtaRec: TDateTime;
                      fltValRec: Double;
                      strOpeBai,
                      strHisBai,
                      strPorBai,
                      strCtaBai,
                      strDocBan,
                      strPorBtx,
                      strCtaBtx,
                      strDocBtx,
                      strForBtx,
                      strCtaDeb,
                      strPorDeb: String;
                      strDocDeb: String;
                      strChaCon: String = '';
                      strEveDeb: String = '';
                      strCtaAnt: String = '';
                      strDocAnt: String = '';
                      fltAntTax: Double = 0;
                      strAutIncLogMCA: String = '';
                      AstrEventoCredito : string = '';
                      AstrEventoTaxa : string = '';
                      AFreteMarketPlace: Double = 0.00;
                      AAjusteMarketPlace: Double = 0.00;
                      AValorTaxaMarketPlace: Double = 0.00;
                      ACupomMarketPlace: Double = 0.00;
                      ADeveAtualizarValorBruto: Boolean = False;
                      ANovoValorBruto: Double = 0.00;
                      ASeqLanFrete: String = '';
                      ASeqLanAjuste: String = '';
                      ASeqLanCupom: String = ''): Boolean;
  Var
    strSQL   : String;
    qryGenCar: TUniQuery;

    LRecalculaTaxa: Boolean;

    LPercentualTaxa: String;
begin

  Try
    qryGenCar := fCriaQuery(nil);

    LRecalculaTaxa := AFreteMarketPlace = 0;
    If LRecalculaTaxa Then
    Begin
      LRecalculaTaxa := AAjusteMarketPlace = 0;

      If LRecalculaTaxa Then
        LRecalculaTaxa := ACupomMarketPlace = 0;
    End;

    LPercentualTaxa := '  MCA_PERCAR = (MCA_VALSTA - MCA_VALREC) / MCA_VALSTA * 100, ';
    If strChaCon.IsEmpty Then
    Begin
      If LRecalculaTaxa Then
        LPercentualTaxa := '  MCA_PERCAR = IF(MCA_VALTAX<>(MCA_VALSTA - MCA_VALREC), (MCA_VALSTA - MCA_VALREC) / MCA_VALSTA * 100, MCA_PERCAR), ';
    End;

    Try
      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  MOVCAR ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  MCA_VALANT = MCA_VALORI, ';
      strSQL := strSQL + '  MCA_TAXANT = MCA_VALTAX, ';
      strSQL := strSQL + '  MCA_FREANT = MCA_FREMKT, ';
      strSQL := strSQL + '  MCA_CUPANT = MCA_CUPMKT, ';
      strSQL := strSQL + '  MCA_BRUANT = MCA_VALSTA, ';

      If ADeveAtualizarValorBruto Then
      Begin
        If ANovoValorBruto > 0 Then
          strSQL := strSQL + ' MCA_VALSTA = :VALSTA, ';
      End;

      strSQL := strSQL + '  MCA_VALDUP = 0, ';
      strSQL := strSQL + '  MCA_DTAREC = :DTAREC, ';
      strSQL := strSQL + '  MCA_VALREC = :VALREC, ';
      strSQL := strSQL + '  MCA_VALORI = :VALREC, '; //ATUALIZANDO O VALORI PARA O VALREC (REQ 60844)

      If LRecalculaTaxa Then
      Begin
        strSQL := strSQL + LPercentualTaxa; // RECALCULA O VALOR DA TAXA
        strSQL := strSQL + '  MCA_VALTAX = (MCA_VALSTA - MCA_VALREC), '; // RECALCULA VALOR DA TAXA
      End
      Else
        strSQL := strSQL + '  MCA_VALTAX = :VALTAX, ' +
                           '  MCA_PERCAR = (:VALTAX / MCA_VALSTA) * 100, ';

      strSQL := strSQL + '  MCA_OPEBAI = :OPEBAI, ';
      strSQL := strSQL + '  MCA_HISBAI = :HISBAI, ';
      strSQL := strSQL + '  MCA_PORBAI = :PORBAI, ';
      strSQL := strSQL + '  MCA_CTABAI = :CTABAI, ';
      strSQL := strSQL + '  MCA_PORBTX = :PORBTX, ';
      strSQL := strSQL + '  MCA_CTABTX = :CTABTX, ';
      strSQL := strSQL + '  MCA_DOCBTX = :DOCBTX, ';
      strSQL := strSQL + '  MCA_DOCBAN = :DOCBAN, ';
      strSQL := strSQL + '  MCA_FORBTX = :FORBTX, ';
      strSQL := strSQL + '  MCA_CTADEB = :CTADEB, ';
      strSQL := strSQL + '  MCA_PORDEB = :PORDEB, ';
      strSQL := strSQL + '  MCA_CHACON = :CHACON, ';
      strSQL := strSQL + '  MCA_DOCDEB = :DOCDEB, ';
      strSQL := strSQL + '  MCA_DTABAI = ' + fCurrentDate + ', ';
      strSQL := strSQL + '  MCA_EVEDEB = :EVEDEB, ';
      strSQL := strSQL + '  MCA_CTAANT = :CTAANT, ';
      strSQL := strSQL + '  MCA_DOCANT = :DOCANT, ';
      strSQL := strSQL + '  MCA_ANTTAX = :ANTTAX, ';
      strSQL := strSQL + '  MCA_EVECRE = :EVECRE, ';
      strSQL := strSQL + '  MCA_EVETAX = :EVETAX, ';
      strSQL := strSQL + '  MCA_FREMKT = :FREMKT, ';
      strSQL := strSQL + '  MCA_VALAJU = :VALAJU, ';
      strSQL := strSQL + '  MCA_CUPMKT = :CUPMKT, ';
      strSQL := strSQL + '  MCA_DOCFRE = :DOCFRE, ';
      strSQL := strSQL + '  MCA_DOCAJU = :DOCAJU, ';
      strSQL := strSQL + '  MCA_DOCCUP = :DOCCUP  ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  AUTOINCREM = :AUTOIN ';

      With qryGenCar Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        {*****************************************}
        {* DADOS QUE SERÃO ATUALIZADOS           *}
        {**************************************MV*}
        ParamByName('DTAREC').AsDateTime := dtaDtaRec;
        ParamByName('VALREC').AsFloat    := fltValRec;
        ParamByName('ANTTAX').AsFloat    := fltAntTax;
        ParamByName('OPEBAI').AsString   := strOpeBai;
        ParamByName('HISBAI').AsString   := strHisBai;
        ParamByName('PORBAI').AsString   := strPorBai;
        ParamByName('CTABAI').AsString   := strCtaBai;
        ParamByName('FREMKT').AsFloat    := Abs(AFreteMarketPlace);
        ParamByName('VALAJU').AsFloat    := Abs(AAjusteMarketPlace);
        ParamByName('CUPMKT').AsFloat    := Abs(ACupomMarketPlace);
        ParamByName('PORBTX').AsString   := strPorBtx;
        If fEmptyStr(strPorBtx) Then
          ParamByName('PORBTX').Clear;

        ParamByName('CTABTX').AsString   := strCtaBtx;
        If fEmptyStr(strPorBtx) Then
          ParamByName('CTABTX').Clear;

        ParamByName('CHACON').AsString   := strChaCon;
        If fEmptyStr(strChaCon) Then
          ParamByName('CHACON').Clear;

        ParamByName('DOCBTX').AsString   := strDocBtx;
        If fEmptyStr(strDocBtx) Then
          ParamByName('DOCBTX').Clear;

        ParamByName('DOCBAN').AsString   := strDocBan;

        ParamByName('CTADEB').AsString   := strCtaDeb;
        If fEmptyStr(strCtaDeb) Then
          ParamByName('CTADEB').Clear;

        ParamByName('PORDEB').AsString   := strPorDeb;
        If fEmptyStr(strPorDeb) Then
          ParamByName('PORDEB').Clear;

        ParamByName('DOCDEB').AsString   := strDocDeb;
        If fEmptyStr(strDocDeb) Then
          ParamByName('DOCDEB').Clear;

        ParamByName('FORBTX').AsString   := strForBtx;
        If fEmptyStr(strForBtx) Then
          ParamByName('FORBTX').Clear;

        ParamByName('EVEDEB').AsString   := strEveDeb;
        If fEmptyStr(strEveDeb) Then
          ParamByName('EVEDEB').Clear;

        ParamByName('DOCANT').AsString   := strDocAnt;
        If fEmptyStr(strDocAnt) Then
          ParamByName('DOCANT').Clear;

        ParamByName('CTAANT').AsString   := strCtaAnt;
        If fEmptyStr(strCtaAnt) Then
          ParamByName('CTAANT').Clear;

        ParamByName('EVECRE').AsString   := AstrEventoCredito;
        If fEmptyStr(AstrEventoCredito) Then
          ParamByName('EVECRE').Clear;

        ParamByName('EVETAX').AsString   := AstrEventoTaxa;
        If fEmptyStr(AstrEventoTaxa) Then
          ParamByName('EVETAX').Clear;

        If Not LRecalculaTaxa Then
          ParamByName('VALTAX').AsFloat := AValorTaxaMarketPlace;

        If ADeveAtualizarValorBruto Then
        Begin
          If ANovoValorBruto > 0 Then
            ParamByName('VALSTA').AsFloat := ANovoValorBruto;
        End;

        qryGenCar.ParamByName('DOCFRE').Clear;
        If Not ASeqLanFrete.IsEmpty Then
          qryGenCar.ParamByName('DOCFRE').AsString := ASeqLanFrete;

        qryGenCar.ParamByName('DOCAJU').Clear;
        If Not ASeqLanAjuste.IsEmpty Then
          qryGenCar.ParamByName('DOCAJU').AsString := ASeqLanAjuste;

        qryGenCar.ParamByName('DOCCUP').Clear;
        If Not ASeqLanCupom.IsEmpty Then
          qryGenCar.ParamByName('DOCCUP').AsString := ASeqLanCupom;

        {*****************************************}
        {* DADOS DO FILTRO                       *}
        {**************************************MV*}
        ParamByName('AUTOIN').AsString := strAutInc;

        ExecSQL;
        Close;
      End;

      untLogMca.GravaLogMca(strAutInc,
                            strDescriLogMca,
                            strNomFrmLogMca,
                            strAutIncLogMCA);

      Result := True;

    Except
      On E: Exception Do
      Begin
        Result := False;
        Raise Exception.Create('Erro ao baixar Movimento de Cartão de Crédito: ' + E.Message);
      End;
    End;

  Finally
    FreeAndNil(qryGenCar);
  End;
end;

{*****************************************}
{* RETORNA 'TRUE' CASO A DUPLICATA JA    *}
{* ESTEJA BAIXADA                        *}
{**************************************MV*}
function fDuplicataCartaoBaixada(strNumDup, strParcel, strCodCli, strCodEmp: String): Boolean;
  Var
    strSQL: String;
    qryGenCar : TUniQuery;
begin

  Try
    qryGenCar := fCriaQuery(nil);

    Result := False;
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  MCA_DTAREC AS DTAREC ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVCAR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  MCA_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  MCA_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  MCA_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  MCA_CODEMP = :CODEMP ';

    With qryGenCar Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('PARCEL').AsString := strParcel;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If Not FieldByName('DTAREC').IsNull Then
        Result := True;

      Close;
    End;

  Finally
    FreeAndNil(qryGenCar);
  End;

end;

function fAcertaHistoricoMovCar(objCartoes: TCartoesResumoCaixaArray; strCodCli, strCodEmp: String; objFatVenda: TFatVendaImp): Boolean;
  Var
    j: Integer;
    qryUpdMovCar: TUniQuery;
    strSQL, strHistorico: String;

  function fRetHistorico: String;
    Var
      i: Integer;
  begin
    Result := 'REF. AOS DOCS. ';

    For i := 0 To objFatVenda.ItemsCount - 1 Do Begin
      Result := Result + objFatVenda[i].strNumDoc + 'A-' + objFatVenda[i].strEspDoc + '-' + objFatVenda[i].strEmpDoc + ' / ';
    End;

    Result := Copy(Result, 1, Length(Result) - 3);
  end;

begin
  Try
    Result       := True;
    qryUpdMovCar := fCriaQuery(nil);

    If (objFatVenda.ItemsCount > 0) And (Length(objCartoes) > 0) Then Begin
      Result       := False;
      strHistorico := fRetHistorico();

      Try
        strSQL := strSQL + 'UPDATE ';
        strSQL := strSQL + '  MOVCAR ';
        strSQL := strSQL + 'SET ';
        strSQL := strSQL + '  MCA_HIST02 = :HIST02 ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  MCA_NUMDUP = :NUMDUP AND ';
        strSQL := strSQL + '  MCA_CODCLI = :CODCLI AND ';
        strSQL := strSQL + '  MCA_CODEMP = :CODEMP ';

        For j := 0 To Length(objCartoes) - 1 Do Begin
          With qryUpdMovCar Do Begin
            Close();
            SQL.Clear();
            SQL.Add(strSQL);
            ParamByName('NUMDUP').AsString := objCartoes[j].strNumDup;
            ParamByName('CODCLI').AsString := strCodCli;
            ParamByName('CODEMP').AsString := strCodEmp;
            ParamByName('HIST02').AsString := strHistorico;
            ExecSQL();
          End;
        End;

        Result := True;
      Except
        On E: Exception Do Begin
          Result := False;
          pMensagensErro('Erro ao atualizar o histórico de Movimento de Cartão: ' + E.Message,
            '[fAcertaHistoricoMovCar]');
        End;
      End;
    End;
  Finally
    FreeAndNil(qryUpdMovCar);
  End;
end;

procedure AtualizarConciliacaoConfirmacaoCartao(ANumNsu,ANumCcd,AParcel,AOperadora: String; ADtaCup : TDateTime);
  Var
    LExtMca: TUniQuery;
Begin
  Try
    LExtMca := fCriaQuery(Nil);

    Try
      LExtMca.Close;
      LExtMca.SQL.Clear;
      LExtMca.SQl.Text := 'UPDATE EXTMCA SET EXT_DTACLO = CURRENT_DATE,          '+
                          '                  EXT_HORCLO = CURRENT_TIME,           '+
                          '                  EXT_OPECLO = :OPECLO                '+
                          'WHERE ((EXT_CODAUT = :CODAUT AND EXT_CODAUT <> "")    '+
                          '    OR (EXT_NUMNSU = :NUMNSU AND EXT_NUMNSU <> ""))   '+
                          '    AND EXT_PARCEL = :PARCEL                          '+
                          '    AND EXT_DTACUP = :DTACUP                          '+
                          '    AND EXT_NOMCON = :NOMCON                          ';

      LExtMca.ParamByName('OPECLO').AsString := strLoginUsuarioLogado;

      LExtMca.ParamByName('CODAUT').AsString   := ANumCcd;
      LExtMca.ParamByName('NUMNSU').AsString   := ANumNsu;
      LExtMca.ParamByName('PARCEL').AsString   := AParcel;
      LExtMca.ParamByName('DTACUP').AsDateTime := ADtaCup;
      LExtMca.ParamByName('NOMCON').AsString   := AOperadora;
      LExtMca.ExecSQL;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LExtMca);
  End;
End;


procedure LimparConciliacaoConfirmacaoCartao(ANumNsu,ANumCcd,AParcel,AOperadora: String; ADtaCup : TDateTime);
  Var
    LExtMca: TUniQuery;
Begin
  Try
    LExtMca := fCriaQuery(Nil);

    Try
      LExtMca.Close;
      LExtMca.SQL.Clear;
      LExtMca.SQl.Text := 'UPDATE EXTMCA SET EXT_DTACLO = NULL,          '+
                          '                  EXT_HORCLO = NULL,          '+
                          '                  EXT_OPECLO = NULL           '+
                          'WHERE ((EXT_CODAUT = :CODAUT AND EXT_CODAUT <> "")    '+
                          '    OR (EXT_NUMNSU = :NUMNSU AND EXT_NUMNSU <> ""))   '+
                          '    AND EXT_PARCEL = :PARCEL                          '+
                          '    AND EXT_DTACUP = :DTACUP                          '+
                          '    AND EXT_NOMCON = :NOMCON                          ';

      LExtMca.ParamByName('CODAUT').AsString   := ANumCcd;
      LExtMca.ParamByName('NUMNSU').AsString   := ANumNsu;
      LExtMca.ParamByName('PARCEL').AsString   := AParcel;
      LExtMca.ParamByName('DTACUP').AsDateTime := ADtaCup;
      LExtMca.ParamByName('NOMCON').AsString   := AOperadora;
      LExtMca.ExecSQL;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LExtMca);
  End;
End;


procedure pAcertaHistoricoMovCarPeloDesmembramentoPedido(strNumDoc, strEspDoc, strCodEmp, strAutInc: String);
var
  qryHist: TUniQuery;
begin
  qryHist := fCriaQuery;

  try
    qryHist.Close;
    qryHist.SQL.Clear;
    qryHist.SQL.Add('UPDATE MOVCAR SET MCA_HIST02 = CONCAT(IFNULL(MCA_HIST02, " "), " ", :HIST02) WHERE MCA_SEQADT = :AUTINC');
    qryHist.ParamByName('HIST02').AsString := 'REF. AO DOC. '+strNumDoc+'-'+strEspDoc+'-'+strCodEmp+'';
    qryHist.ParamByName('AUTINC').AsString := strAutInc;
    qryHist.ExecSQL;
  finally
    FreeAndNil(qryHist);
  end;
end;

function fGetSQLCartoes(objConcil: TCamposConcil): String;
begin
  Result := '';
  Result := Result + 'SELECT * FROM (SELECT                                   ';
  Result := Result + '  MOVCAR.AUTOINCREM AS AUTOINC,                         ';
  Result := Result + '  MCA_NUMDUP AS NRODUP,                                 ';
  Result := Result + '  MCA_PARCEL AS PARDUP,                                 ';
  Result := Result + '  CONCAT(MCA_NUMDUP, MCA_PARCEL) AS MCA_NUMDUP,         ';
  Result := Result + '  IF(COALESCE(MCA_EMPRCX, "") = "", MCA_CODEMP,         ';
  Result := Result + '     MCA_EMPRCX) AS EMPLOC,                             ';
  Result := Result + '  MCA_CODEMP,                                           ';
  Result := Result + '  MCA_EMPRCX,                                           ';
  Result := Result + '  MCA_DTAVEN,                                           ';
  Result := Result + '  MCA_VALDUP AS MCA_VALTOT,                             ';
  Result := Result + '  MCA_VALTAX,                                           ';
  Result := Result + '  MCA_VALSTA,                                           ';
  Result := Result + '  MCA_VALORI,                                           ';
  Result := Result + '  MCA_VALDUP,                                           ';
  Result := Result + '  MCA_PERCAR,                                           ';
  if objConcil.strTabCon.Equals('PGM_PMRECE') then
    Result := Result + '  MCA_VALTAX AS TAXA_ADM_ORIGINAL,                    '
  else
    Result := Result + '  MCA_PERCAR AS TAXA_ADM_ORIGINAL,                    ';
  Result := Result + '  MCA_TAXANT,                                           ';
  Result := Result + '  MCA_TRFLIB,                                           ';
  Result := Result + '  MCA_ORDEID,                                           ';
  Result := Result + '  MCA_CODCLI,                                           ';
  Result := Result + '  CLI_NOMCLI,                                           ';
  Result := Result + '  CLI_C_G_C_,                                           ';
  Result := Result + '  CAR_DESCAR,                                           ';
  Result := Result + '  CAR_CODBAN,                                           ';
  Result := Result + '  BAN_NOMBAN,                                           ';
  Result := Result + '  CONCAT(CAR_CODCAR, " - ", CAR_DESCAR) AS CARTAO,      ';
  Result := Result + '  CAR_CODEMP,                                           ';
  Result := Result + '  CAR_PERDES,                                           ';
  Result := Result + '  MCA_FREMKT,                                           ';
  Result := Result + '  IFNULL(MCA_CUPMKT, 0.00) AS MCA_CUPMKT,               ';
  Result := Result + '  MCA_HIST01,                                           ';
  Result := Result + '  MCA_HIST02,                                           ';
  Result := Result + '  CURRENT_TIMESTAMP AS HRAFILCAR,                       ';
  Result := Result + '  MCA_DTACAD,                                           ';
  If MatchStr(objConcil.strTabCon, ['RED_APPGTO','PGM_PMRECE']) Then
    Result := Result + '  LPAD(UPPER(MCA_NUMCCD), 6, "0") AS MCA_NUMCCD,        '
  Else If objConcil.strTabCon <> 'MLZ_MZPGTO' Then
    Result := Result + '  UPPER(MCA_NUMCCD) AS MCA_NUMCCD,                      '
  Else
    Result := Result + '  IF(IFNULL(MCA_NUMCCD, "") = "", MCA_NUMNSU, UPPER(MCA_NUMCCD)) AS MCA_NUMCCD, ';
  Result := Result + '  MCA_RESCAI,                                           ';
  Result := Result + '  MCA_DTATRA,                                           ';
  Result := Result + '  MCA_CODCAR,                                           ';
  Result := Result + '  MCA_CODFIN,                                           ';
  if objConcil.strTabCon.Equals('PGM_PMRECE') then
    Result := Result + 'TRIM(LEADING "0" FROM MCA_NUMNSU) AS MCA_NUMNSU, '
  else If Not MatchStr(objConcil.strTabCon, ['MER_MLPGTO', 'KON_KOPGTO', 'MLZ_MZPGTO']) Then
    Result := Result + '  LPAD(MCA_NUMNSU, 14, "0") AS MCA_NUMNSU,            '
  Else
    Result := Result + '  MCA_NUMNSU,                                         ';

  Result := Result + '  LPAD(RIGHT(MCA_NUMNSU,12),14,"0") AS NSU_B2W,         ';
  Result := Result + '  MCA_DOCUME,                                           ';
  Result := Result + '  MCA_CHACON,                                           ';
  Result := Result + '  CAST(" " AS CHAR(400)) AS  HISTORICO_BAIXA,           ';
  Result := Result + '  IFNULL(MCA_DTACUP, MCA_DTACAD) AS MCA_DTACUP,         ';
  Result := Result + '  MCA_NUMPOK,                                           ';
  if fCfgSis('PGMREC', varBoolean) then
    Result := Result + '  LEFT(RIGHT(MCA_NUMPOK,9),6) AS POKPGM,              '
  else
    Result := Result + '  RIGHT(MCA_NUMPOK,9) AS POKPGM,                      ';
  Result := Result + '  IFNULL(MCA_FREPED, 0) AS MCA_FREPED,                  ';
  Result := Result + '  FOR_NOMFOR,                                           ';
  Result := Result + '  E1.EVE_DESEVE DESC_EVE_DEBITO,                        ';
  Result := Result + '  E2.EVE_DESEVE DESC_EVE_CREDITO,                       ';
  Result := Result + '  E3.EVE_DESEVE DESC_EVE_TAXA,                          ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_PORBAI, CON.CON_PORCRE), "") AS CAR_PORBAI, ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_CTABAI, CON.CON_CTACRE), "") AS CAR_CTABAI, ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_PORTAX, CON.CON_PORTAX), "") AS CAR_PORTAX, ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_CTATAX, CON.CON_CTATAX), "") AS CAR_CTATAX, ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_FORTAX, CON.CON_FORTAX), "") AS CAR_FORTAX, ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_PORBAD, CON.CON_PORDEB), "") AS CAR_PORBAD, ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_CTABAD, CON.CON_CTADEB), "") AS CAR_CTABAD, ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_EVEDEB, CON.CON_EVEDEB), "") AS CAR_EVEDEB, ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_EVECRE, CON.CON_EVECRE), "") AS CAR_EVECRE, ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_EVETAX, CON.CON_EVETAX), "") AS CAR_EVETAX, ';
  Result := Result + '  CAST(" " AS CHAR(5)) AS MCA_EVECAN,                   ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_CTAANT, CON.CON_CTAANT), "") AS CAR_CTAANT, ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_CTAFRE, CON.CON_CTAFRE), "") AS CAR_CTAFRE, ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_CTAAJU, CON.CON_CTAAJU), "") AS CAR_CTAAJU, ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_CTACUP, CON.CON_CTACUP), "") AS CAR_CTACUP, ';
  Result := Result + '  COALESCE(CAR_MKTPLA, "N") AS CAR_MKTPLA,              ';
  Result := Result + '  MCA_DOCFRE,                                           ';
  Result := Result + '  MCA_DOCAJU,                                           ';
  Result := Result + '  MCA_DOCCUP,                                           ';
  Result := Result + '  SUBSTRING(MCA_DOCUME,1,IF(LOCATE("AG", MCA_DOCUME), LOCATE("AG", MCA_DOCUME) + 5, 21)) AS MCA_NUMNOT, ';
  Result := Result + '  "D"  AS MCA_MARDES,                                   ';
  Result := Result + '  0.00 AS MCA_VALREC,                                   ';
  Result := Result + '  CAST(NULL AS DATE) AS MCA_DTAREC,                     ';
  Result := Result + '  0.00 AS MCA_SELSTA,                                   ';
  Result := Result + '  0.00 AS MCA_TOTTAX,                                   ';
  Result := Result + '  0.00 AS MCA_SELTOT,                                   ';
  Result := Result + '  0.00 AS MCA_AJUTOT,                                   ';
  Result := Result + '  0.00 AS MCA_AJUSEL,                                   ';
  Result := Result + '  IF(IFNULL(MCA_VALTAX,0) > 0, "N", "S") AS MCA_ZERATX, ';
  Result := Result + '  0.00 AS MCA_ANTECI,                                   ';
  Result := Result + '  IFNULL(MCA_ANTTAX, 0.00) AS MCA_ANTTAX,               ';
  Result := Result + '  0.00 AS MCA_SELQTD,                                   ';
  Result := Result + '  "N" AS MCA_AJUSTE,                                    ';
  Result := Result + '  "N" AS MCA_ANT_SN,                                    ';
  Result := Result + '  CAST(" " AS CHAR(50)) AS MCA_ESTABE,                  ';
  Result := Result + '  CAST(" " AS CHAR(50)) AS MARKETPLACE,                 ';
  Result := Result + '  CAST(" " AS CHAR(400)) AS CHAVECONCILIACAO,           ';
  Result := Result + '  CAST(" " AS CHAR(80)) AS NUMEROOPERACAO,              ';
  Result := Result + '  "N" AS NEGOCIACAO,                                    ';
  Result := Result + '  "N" AS NEGOCIADO_ANTERIORMENTE,                       ';
  Result := Result + '  0.00 AS VALOR_TAXA_NEGOCIACAO,                        ';
  Result := Result + '  CAST(" " AS CHAR(7)) AS PLANODECONTASTXNEGOCIACAO,    ';
  Result := Result + '  "N" AS ALTERAR_BRUTO,                                 ';
  Result := Result + '  0.00 AS FRETE_MARKETPLACE,                            ';
  Result := Result + '  0.00 AS AJUSTE_MARKETPLACE,                           ';
  Result := Result + '  0.00 AS CUPOM_MARKETPLACE,                            ';
  Result := Result + '  0.00 AS SUBTRAIR_FRETE,                               ';
  Result := Result + '  CAST(" " AS CHAR(5)) AS PORTADOR_GRAVAME,        ';
  Result := Result + '  CAST(" " AS CHAR(5)) AS PORTADORTRANSFERENCIA,        ';
  Result := Result + '  CAST(" " AS CHAR(7)) AS PLANODECONTASTRANSFERENCIA,   ';
  Result := Result + '  CAST(" " AS CHAR(5)) AS CENTRODECUSTOSTRANSFERENCIA,  ';
  Result := Result + '  "N" AS REGISTROTRANSFERENCIA,                         ';
  Result := Result + '  IF((COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_PORBAI, CON.CON_PORCRE), "") = "") OR ';
  Result := Result + '     (COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_CTABAI, CON.CON_CTACRE), "") = "") OR ';
  Result := Result + '     (COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_PORTAX, CON.CON_PORTAX), "") = "") OR ';
  Result := Result + '     (COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_CTATAX, CON.CON_CTATAX), "") = "") OR ';
  Result := Result + '     (COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_FORTAX, CON.CON_FORTAX), "") = "")    ';

  if fCfgSis('CTPOBE', varBoolean) then
    Result := Result + ' OR (COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_EVECRE, CON.CON_EVECRE), "") = "")       '+
                       ' OR (COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_EVETAX, CON.CON_EVETAX), "") = "")       '+
                       ' OR ((COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_PORBAD, CON.CON_PORDEB), "") <> "") AND '+
                       '     (COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_EVEDEB, CON.CON_EVEDEB), "") = ""))     ';

  If (Not fEmptyStr(objConcil.strConfPr)) Then
  Begin
    If ((fCfgSis('BAIDEB') = 'S') And
       (fEmptyStr(fCfgSis(objConcil.strConfPr))) Or
       (fEmptyStr(fCfgSis(objConcil.strConfFo))) Or
       (fEmptyStr(objConcil.strConfCt))) Then
      Result := Result + ', "INCOMPLETO", "COMPLETO") AS SIT_CAD              '
    Else
      Result := Result + ' OR (COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_FORTAX, CON.CON_FORTAX), "") = ""), '+
                         ' "INCOMPLETO", "COMPLETO") AS SIT_CAD               ';
  End
  Else
    Result := Result + ' OR (COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_FORTAX, CON.CON_FORTAX), "") = ""), '+
                       ' "INCOMPLETO", "COMPLETO") AS SIT_CAD                 ';

  Result := Result + 'FROM                                                    ';
  Result := Result + '  MOVCAR                                                ';
  Result := Result + '  JOIN CADCAR ON CAR_CODCAR = MCA_CODCAR                ';
  Result := Result + '  JOIN CADBAN ON BAN_CODBAN = CADCAR.CAR_CODBAN         ';
  Result := Result + '  JOIN CADCLI ON CLI_CODCLI = MCA_CODCLI                ';
  Result := Result + '  LEFT JOIN CONPOR CON ON CON.CON_CODCAR = CADCAR.CAR_CODCAR ';
  Result := Result + '                      AND CON.CON_CODEMP = "' + VS_strCodEmp + '" ';
  Result := Result + '  LEFT JOIN CADFOR ON FOR_CODFOR = IF(CON.CON_PORCRE IS NULL, CAR_FORTAX, CON.CON_FORTAX) ';
  Result := Result + '  LEFT JOIN CADEVE E1 ON E1.EVE_CODEVE = IF(CON.CON_PORCRE IS NULL, CAR_EVEDEB, CON.CON_EVEDEB) ';
  Result := Result + '  LEFT JOIN CADEVE E2 ON E2.EVE_CODEVE = IF(CON.CON_PORCRE IS NULL, CAR_EVECRE, CON.CON_EVECRE) ';
  Result := Result + '  LEFT JOIN CADEVE E3 ON E3.EVE_CODEVE = IF(CON.CON_PORCRE IS NULL, CAR_EVETAX, CON.CON_EVETAX) ';
  Result := Result + 'WHERE                                                   ';
  Result := Result + '  MCA_DTAREC IS NULL                                    ';
end;

procedure pGravaLogMca(strAutInc, strDescricaoLog, strNomForm: String);
begin
  Try
    untLogMca.GravaLogMca(strAutInc,
                          strDescricaoLog,
                          strNomForm);
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[pGravaLogMca]');
  End;
end;

procedure pApagaCartao(strAutInc, strNomFrm: String);
  Var
    LConsulta: TUniQuery;
begin
  If strAutInc.IsEmpty Then
    Exit;

  LConsulta := fCriaQuery;
  Try
    Try
      LConsulta.SQL.Text := 'SELECT * FROM MOVCAR WHERE AUTOINCREM=:AUTINC';

      LConsulta.ParamByName('AUTINC').AsString := strAutInc;
      LConsulta.Open;

      If LConsulta.isEmpty Then
        Exit;

      untLogMca.GravaLogMca(strAutInc,
                            'EXCLUSÃO',
                            strNomFrm);

      fVerificaIntegridade(strNomFrm, 'MOVCAR', LConsulta);

      LConsulta.Delete;
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

function fExisteEstabelecimentosDuplicados(var AConfiguracao: String): Boolean;
  Var
    strSQL  : String;
    qryTotal: TUniQuery;
Begin
  If AConfiguracao = 'CFG_MEREST' Then
    Exit(False);

  strSQL := '';
  strSQL := strSQL + 'SELECT COUNT(SIS_VALCFG) AS TOTAL, ';
  strSQL := strSQL + '   SIS_VALCFG                      ';
  strSQL := strSQL + 'FROM CFGSIS                        ';
  strSQL := strSQL + 'WHERE SIS_CODCFG IN ([CODCFG]) AND ';
  strSQL := strSQL + '  SIS_VALCFG IS NOT NULL AND       ';
  strSQL := strSQL + '  SIS_VALCFG <> ""                 ';
  strSQL := strSQL + 'GROUP BY SIS_VALCFG                ';
  strSQL := strSQL + '   HAVING COUNT(SIS_VALCFG) > 1    ';

  AConfiguracao := '("' + AConfiguracao + '")';
  If AConfiguracao = '("CFG_CIEEST")' Then
    AConfiguracao := '("CFG_CIEEST", "CFG_CIELNK")'
  Else If AConfiguracao = '("CFG_STOEST")' Then
    AConfiguracao := '("CFG_STOEST", "CFG_STOLNK")';

  strSQL := strSQL.Replace('([CODCFG])', AConfiguracao);

  qryTotal := fCriaQuery();

  Try
    qryTotal.SQL.Text := strSQL;

    qryTotal.Open;

    Result := Not qryTotal.IsEmpty;
  Finally
    FreeAndNil(qryTotal);
  End;
End;

function ExisteChaveDeAutorizacaoDuplicada(AConcilidadora: String): Boolean;
  Var
    strSQL  : String;
    qryTotal: TUniQuery;
    LConfiguracao : String;
Begin

  LConfiguracao := RetornaConfiguracaoChaveApi(AConcilidadora);

  If fEmptyStr(LConfiguracao) Then
    Exit(False);

  strSQL := '';
  strSQL := strSQL + 'SELECT COUNT(SIS_VALCFG) AS TOTAL, ';
  strSQL := strSQL + '   SIS_VALCFG                      ';
  strSQL := strSQL + 'FROM CFGSIS                        ';
  strSQL := strSQL + 'WHERE SIS_CODCFG=:CODCFG AND       ';
  strSQL := strSQL + '  SIS_VALCFG IS NOT NULL AND       ';
  strSQL := strSQL + '  SIS_VALCFG <> ""                 ';
  strSQL := strSQL + 'GROUP BY SIS_VALCFG                ';
  strSQL := strSQL + '   HAVING COUNT(SIS_VALCFG) > 1    ';

  qryTotal := fCriaQuery();

  Try
    qryTotal.SQL.Text := strSQL;

    qryTotal.ParamByName('CODCFG').AsString := LConfiguracao;
    qryTotal.Open;

    Result := Not qryTotal.IsEmpty;
  Finally
    FreeAndNil(qryTotal);
  End;
End;

function RetornaConfiguracaoChaveApi(AConcilidadora: String): String;
Begin
  Result := '';

  If AConcilidadora.Equals('Koncili')Then
    Result := 'CFG_KONKEY';
End;


function fSetConcil(strNomCon: String): TConciliacaoCartoes;
begin
  Result := Nil;

  If UpperCase(strNomCon) = 'KONCILI' Then
    Result := TConcilKoncilia.Create;
end;

function fGetSqlAtualizaTipoParcelamentoTEF(ANumDup, ACodCli, ACodEmp, ATpParc: String; ASeqCon: Integer): String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' UPDATE MOVCAR ';
  strSQL := strSQL + '   SET MCA_TPPARC = ' + ATpParc.QuotedString; //[L]ojista/[O]peradora
  strSQL := strSQL + ' WHERE MCA_NUMDUP = ' + ANumDup.QuotedString;
  strSQL := strSQL + '   AND MCA_CODCLI = ' + ACodCli.QuotedString;
  strSQL := strSQL + '   AND MCA_CODEMP = ' + ACodEmp.QuotedString;
  strSQL := strSQL + '   AND MCA_SEQCON = ' + ASeqCon.ToString;
  strSQL := strSQL + '   AND MCA_TIPCAR = "TEF";';

  Result := strSQL;
end;

function TransferenciaLiberada(AUsaLiberacaoTransferencia,
                               AVeioResumoCaixa: Boolean;
                               ACartaoLiberado: String): Boolean;
Begin
  Result := True;

  If Not AUsaLiberacaoTransferencia Then
    Exit;

  If Not AVeioResumoCaixa Then
    Exit;

  Result := ACartaoLiberado <> 'N';
End;

function CartaoBloqueado(AQryMovCar: TDataSet; ARcxTcc: String = ''): Boolean;
begin
  Result := False;

  {** Se o cartão foi recebido via financiamento, a baixa não deve ser bloqueada **}
  {** devido à falta de transferência, pois cartões recebidos por financiamento  **}
  {** não possuem vínculo direto com a transferência do resumo de caixa. **********}

  if not AQryMovCar.FieldByName('MCA_CODFIN').AsString.IsEmpty then
    Exit;

  if ARcxTcc.IsEmpty then
    ARcxTcc := fCfgSis('RCXTCC');

  Result := (ARcxTcc.Equals('2'))                                and
            (AQryMovCar.FieldByName('MCA_RESCAI').AsInteger = 1) and
            (AQryMovCar.FieldByName('MCA_DTATRA').IsNull);

  if not Result then
    Result := not TransferenciaLiberada(fCfgSis('USAAUT', varBoolean),
                                        AQryMovCar.FieldByName('MCA_RESCAI').AsInteger = 1,
                                        AQryMovCar.FieldByName('MCA_TRFLIB').AsString);
end;

function RetornaDatasetCartoesTransferidos(ANumeroDuplicata,
                                           ACodigoEmpresa,
                                           ACodigoCliente: String;
                                           ADataCadastro: TDateTime;
                                           ASequencialTF: Integer = 0): TDataset;
  Var
    LConsulta: TUniQuery;
Begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT AUTOINCREM, ' +
                          '       MCA_NUMDUP, ' +
                          '       MCA_PARCEL, ' +
                          '       MCA_CODEMP, ' +
                          '       MCA_CODCLI, ' +
                          '       MCA_DTACAD, ' +
                          '       MCA_DTAVEN, ' +
                          '       MCA_DTATRA, ' +
                          '       MCA_SEQTRF  ' +
                          'FROM MOVCAR ' +
                          'WHERE MCA_NUMDUP=:NUMDUP  ' +
                          '  AND MCA_CODEMP=:CODEMP  ' +
                          '  AND MCA_CODCLI=:CODCLI  ' +
                          '  AND MCA_DTACAD=:DTACAD ';

    If ASequencialTF > 0 Then
      LConsulta.SQL.Add('  AND MCA_SEQTRF=' + ASequencialTF.ToString);

    LConsulta.ParamByName('NUMDUP').AsString := ANumeroDuplicata;
    LConsulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LConsulta.ParamByName('CODCLI').AsString := ACodigoCliente;
    LConsulta.ParamByName('DTACAD').AsDateTime := ADataCadastro;

    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta);
    Result.Open;

    Result.First;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
End;

end.
