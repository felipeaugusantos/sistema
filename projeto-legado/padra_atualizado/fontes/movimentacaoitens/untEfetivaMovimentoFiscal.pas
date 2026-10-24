unit untEfetivaMovimentoFiscal;

interface

Uses System.SysUtils, Uni, untEnderecamentoProduto, untFuncoes, untPcmGer,
untTypesSistema, untCalculoUltimaCompraImpostos, untFuncoesSimples, untCadIte,
untDefineBaixaPedido, StrUtils, Data.DB, untZClient, Classes,cxProgressBar, untTDistribuicaoConferencia, untLotePrecos,
untTEnderecamentoConferenciaParcial;

Type
  TNotaEletInfConf = class
    FAutInc: String;
    FDigEle: String;
    FDtaCon: TDateTime;
    FEntSim: String;
    FMovGer: String;
  End;

  TAtualizaPrecoEfetivacaoMovimentoFiscal = class
  private
    strEmpresas: String;
    strAgrupadorPreAlt: String;
    qryComand: TUniQuery;
    qryLotPre: TZClient;
    blnInfMat: Boolean;
    ObjLotePrecos: TLotePrecos;

    intInfFed: Integer;
    intInfOpe: Integer;
    intInfSai: Integer;

    procedure pAtualizaIteger(qryGenPre: TDataSet; strEmpresas: String; blnResFor: Boolean);
    function fGetSqlUpdateITEGER(blnResFor: Boolean): string;
    function fExecutaEfetivaLotPre(ANumDoc,AEspDoc, ASerie, ACodFor, ACodEmp: String): Boolean;
    function fGravaPrecos(pgbStatus: TcxProgressBar): Boolean;

  public
    class function fEfetivaLotPre(ANumDoc, AEspDoc, ASerie, ACodFor, ACodEmp: String): Boolean;
  End;


  TEfetivaMovimentoFiscal = class
  private
    strIncPcg : String;
    strAutIncEntradaGarantia : String;
    strAutIncPed : String;
    strNumPedVen : String;
    strCodCliPed : String;
    strCodOpe    : String;
    qryMovDet: TZClient;

    function fGravaFatGorGarantia: Boolean;
    function fGravaFatDorGarantia: Boolean;
    procedure pAbreMovDet(strTabela: String);
    function fRetIncValido(Lista: TStringList): String;


  public
    Constructor Create;
    Destructor Destroy; override;
    Class procedure pEfetiva(strNumDoc, strEspDoc, strSerie, strCodFor, strCodEmp : String;
       dteDtaEnt : TDateTime = 0; dteDtaSFo : TDateTime = 0; dteDtaCTr : TDateTime = 0;
       dteDtaCEm : TDateTime = 0; blnComTransacao : Boolean = True;
       strAutIncNatOperacao: string = ''; ANotaEletInfConf: TNotaEletInfConf = nil);

  End;


implementation

uses
  untProdAcabado,
  untIFatReservaSaldo,
  untTFatReservaSaldo, untGarant, untFatGor, untConstantes, untPreAlt_Trigger,
  untPreAlt, untFuncoesAuxiliares, untGravando, untLotePrecosEfetivacaoCx;


{ TEfetivaMovimentoFiscal }

constructor TEfetivaMovimentoFiscal.Create;
begin
  qryMovDet := TZClient.Create(nil);
end;

destructor TEfetivaMovimentoFiscal.Destroy;
begin
  FreeAndNil(qryMovDet);
end;

class procedure TEfetivaMovimentoFiscal.pEfetiva(strNumDoc, strEspDoc, strSerie, strCodFor, strCodEmp : String;
       dteDtaEnt : TDateTime = 0; dteDtaSFo : TDateTime = 0; dteDtaCTr : TDateTime = 0;
       dteDtaCEm : TDateTime = 0; blnComTransacao : Boolean = True;
       strAutIncNatOperacao: string = ''; ANotaEletInfConf: TNotaEletInfConf = nil);
  Var
    objEfetivaMovimentoFiscal : TEfetivaMovimentoFiscal;
    qryAuxili : TUniQuery;
    qryUpdate : TUniQuery;

    endItem: TEndItem;
    endDocumento: TEndDocumento;
    objEnderecamento: TEnderecamentoProduto;
    objImpUlt: TCalculoUltimaCompraImpostos;
    blnUtilizaEnderecamento: Boolean;

    blnRecebimentoDeGarantiaDaFilial,
    blnUltPis,
    blnDedIcm,
    blnAtualizouPrecoMedio,
    blnMedSe2,
    blnAtuMed,
    blnAtuUlt,
    blnContribuinteIPI,
    blnTemItem: Boolean;

    fltTotUlt,
    fltPreUlt,
    fltPreMed,
    fltIcmMed,
    fltUniImp : Double;
    strClaRet,
    strForFil,
    strNotEnt : String;
    blnNotaImp: Boolean;

    LstrFatGor: String;
    objBaixaPedido: TDefineBaixaPedido;
    blnFilKar,
    blnSucesso : boolean;
    blnZeraIPI: Boolean;
    blnMarcaProAca: Boolean;

    strClaFisBonificacao: String;

    CalculoPrecoMediAgrup: TCalculoPrecoMediAgrup;
    lDistribuicaoConferencia: TDistribuicaoConferencia;


    function fItem(strCampo : String) : Variant;
    Begin
      Result := fCampoTabela(strCampo, 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [qryAuxili.FieldByName('DET_CODITE').AsString, qryAuxili.FieldByName('DET_CODEMP').AsString]);
    End;

    function fItemC(strCampo : String) : Variant;
    Begin
      Result := fCampoTabela(strCampo, 'CADITE', ['ITE_CODITE'], [qryAuxili.FieldByName('DET_CODITE').AsString]);
    End;


    function fDocumentoGeraEnderecamento: Boolean;
    begin
      Result := True;
      If Pos(qryAuxili.FieldByName('DET_CLAFIS').AsString, '1922_2922_') > 0 Then
        Exit(False);

      If (qryAuxili.FieldByName('DET_CLARET').AsInteger = 1) and (Pos(qryAuxili.FieldByName('DET_CLAFIS').AsString, strClaRet) > 0) Then
        Exit(False);

      If Not fCfgSis('ENTEND', varBoolean) Then
        Exit(False);


      If Not Result Then
        Result := ((fCfgSis('USACON', varBoolean)) And (Pos(fCfgSis('CONFME'), '1_3_') > 0));
    end;

    procedure pDeletaPedidoReservaAntigo;
    var
     qryGenGer, qryGenDel : TUniQuery;
    Begin
      try
        qryGenGer := fCriaQuery(Nil);
        qryGenDel := fCriaQuery(Nil);

        qryGenGer.SQL.Clear;
        qryGenGer.SQL.Add('SELECT FGO_SEQFGO ');
        qryGenGer.SQL.Add('  FROM DEL_EXTGOR ');
        qryGenGer.SQL.Add(' WHERE FGO_DOCEND  = :NUMDOC ');

        qryGenGer.ParamByName('NUMDOC').AsString :=  objEnderecamento.strDocumento;
        qryGenGer.Close;
        qryGenGer.Open;

        If (Not qryGenGer.IsEmpty) Then
        Begin

          qryGenGer.First;
          While Not qryGenGer.Eof Do
          Begin
            qryGenDel.SQL.Clear;
            qryGenDel.SQL.Add('DELETE FROM DEL_FATGOR WHERE AUTOINCREM = :AUTINC ');
            qryGenDel.ParamByName('AUTINC').AsString :=  qryGenGer.FieldByName('FGO_SEQFGO').AsString;
            qryGenDel.ExecSQL;

            qryGenDel.SQL.Clear;
            qryGenDel.SQL.Add('DELETE FROM DEL_AUXGOR WHERE AUX_SEQGER = :AUTINC ');
            qryGenDel.ParamByName('AUTINC').AsString :=  qryGenGer.FieldByName('FGO_SEQFGO').AsString;
            qryGenDel.ExecSQL;

            qryGenDel.SQL.Clear;
            qryGenDel.SQL.Add('DELETE FROM DEL_EXTGOR WHERE FGO_SEQFGO = :AUTINC ');
            qryGenDel.ParamByName('AUTINC').AsString :=  qryGenGer.FieldByName('FGO_SEQFGO').AsString;
            qryGenDel.ExecSQL;

            qryGenDel.SQL.Clear;
            qryGenDel.SQL.Add('DELETE FROM DEL_FATDOR WHERE FDO_SEQGER = :AUTINC ');
            qryGenDel.ParamByName('AUTINC').AsString :=  qryGenGer.FieldByName('FGO_SEQFGO').AsString;
            qryGenDel.ExecSQL;

            qryGenGer.Next;
          End;

        End;

      finally
        FreeAndNil(qryGenGer);
        FreeAndNil(qryGenDel);
      End;
     End;

Begin
  LstrFatGor := '';
  blnSucesso := True;
  strNotEnt := '';

  blnContribuinteIPI := (fCfgSis('CONIPI', varBoolean));
  blnAtuMed := fCfgSis('ATUMED', varBoolean);
  blnAtuUlt := fCfgSis('ATUULT', varBoolean);
  blnMedSe2 := fCfgSis('MEDSE2', varBoolean);
  strForFil := fRetForFilialTodos;
  blnUtilizaEnderecamento := fCfgSis('ENTEND', varBoolean);


  objEfetivaMovimentoFiscal := TEfetivaMovimentoFiscal.Create;
  qryAuxili := fCriaQuery;
  qryUpdate := fCriaQuery;
  objEnderecamento := TEnderecamentoProduto.Create;
  CalculoPrecoMediAgrup := TCalculoPrecoMediAgrup.Create;
  Try
    Try
      If blnComTransacao Then
        fStartTransaction;

      //se for efetivação de uma entrada de Transferencia de Garantia, com GARMAT = S, nao cria endereçamento e sim reserva o saldo em estoque de garantia.
      blnRecebimentoDeGarantiaDaFilial := False;
      If (fCfgSis('GARMAT', varBoolean) And ( fCfgSis('EMPGAR', varString) = VS_strCodEmp) ) Then
      Begin
        qryAuxili.Close;
        qryAuxili.SQL.Clear;

        qryAuxili.SQL.Add(' SELECT PCG_OBS001, INCPCG, G.AUTOINCREM                      ');
        qryAuxili.SQL.Add(' FROM MOVGER G                                                ');
        qryAuxili.SQL.Add('    INNER JOIN                                                ');
        qryAuxili.SQL.Add('     (SELECT                                                  ');
        qryAuxili.SQL.Add('       PCMGER.AUTOINCREM AS INCPCG,                           ');
        qryAuxili.SQL.Add('       PCG_EMPDES,                                            ');
        qryAuxili.SQL.Add('       SUBSTRING(PCG_DOCORI, 1, 12) AS ORI_NUMDOC,            ');
        qryAuxili.SQL.Add('       SUBSTRING(PCG_DOCORI, 13, 2) AS ORI_ESPDOC,            ');
        qryAuxili.SQL.Add('       PCG_DTAENT,                                            ');
        qryAuxili.SQL.Add('       PCG_OBS001                                             ');
        qryAuxili.SQL.Add('     FROM                                                     ');
        qryAuxili.SQL.Add('       PCMGER                                                 ');
        qryAuxili.SQL.Add('     WHERE PCG_BAIXAD = 1                                     ');
        qryAuxili.SQL.Add('       AND IFNULL(PCG_DOCORI, "") <> "") AS TMP               ');
        qryAuxili.SQL.Add('      ON ORI_NUMDOC = GER_NUMDOC                              ');
        qryAuxili.SQL.Add('     AND IF(ORI_ESPDOC = "TE", "PD",ORI_ESPDOC) = GER_ESPDOC  ');
        qryAuxili.SQL.Add('     AND PCG_EMPDES = G.GER_CODEMP                            ');
        qryAuxili.SQL.Add('     AND PCG_DTAENT = G.GER_DTADOC                            ');
        qryAuxili.SQL.Add(' WHERE GER_CODEMP = :CODEMP                                   ');
        qryAuxili.SQL.Add('   AND GER_NUMDOC = :NUMDOC                                   ');
        qryAuxili.SQL.Add('   AND GER_ESPDOC = :ESPDOC                                   ');
        qryAuxili.SQL.Add('   AND GER_CODFOR = :CODFOR                                   ');
        qryAuxili.SQL.Add('   AND GER_SERIE_ = :SERIE_                                   ');

        qryAuxili.ParamByName('CODEMP').AsString := strCodEmp;
        qryAuxili.ParamByName('NUMDOC').AsString := strNumDoc;
        qryAuxili.ParamByName('ESPDOC').AsString := strEspDoc;
        qryAuxili.ParamByName('SERIE_').AsString := strSerie ;
        qryAuxili.ParamByName('CODFOR').AsString := strCodFor;

        qryAuxili.Open;

        blnRecebimentoDeGarantiaDaFilial := qryAuxili.FieldByName('PCG_OBS001').AsString.Equals('GARANTIA(TE)');
        objEfetivaMovimentoFiscal.strAutIncEntradaGarantia := qryAuxili.FieldByName('AUTOINCREM').AsString;
        objEfetivaMovimentoFiscal.strIncPcg := qryAuxili.FieldByName('INCPCG').AsString;
      End;

      If (Pos(strCodFor, strForFil) > 0) Then
        blnUltPis := fRetForFilialDeduzPisCofinsUltimaCompra(VS_strCodEmp, strCodFor)
      Else
        blnUltPis := fCfgSis('ULTPIS', VarBoolean);

      If (Pos(strCodFor, strForFil) > 0) Then
        blnDedIcm := fRetForFilialDeduzICMSUltimaCompra(VS_strCodEmp, strCodFor)
      Else
        blnDedIcm := fCfgSis('DEDICM', VarBoolean);

      qryAuxili.Close;
      qryAuxili.SQL.Clear;
      qryAuxili.SQL.Add(' UPDATE MOVGER SET GER_DTAENT = :DTAENT,');
      qryAuxili.SQL.Add('                   GER_HORENT = :HORENT ');
      qryAuxili.SQL.Add(' WHERE GER_NUMDOC = :NUMDOC             ');
      qryAuxili.SQL.Add('   AND GER_ESPDOC = :ESPDOC             ');
      qryAuxili.SQL.Add('   AND GER_SERIE_ = :SERIE_             ');
      qryAuxili.SQL.Add('   AND GER_CODFOR = :CODFOR             ');
      qryAuxili.SQL.Add('   AND GER_CODEMP = :CODEMP             ');
      qryAuxili.SQL.Add('   AND GER_DTAENT IS NULL               ');

      If dteDtaEnt = 0 Then
        qryAuxili.ParamByName('DTAENT').AsDateTime := fNow()
      Else
        qryAuxili.ParamByName('DTAENT').AsDateTime := dteDtaEnt ;

      qryAuxili.ParamByName('HORENT').AsDateTime := fNow();
      qryAuxili.ParamByName('NUMDOC').AsString   := strNumDoc;
      qryAuxili.ParamByName('ESPDOC').AsString   := strEspDoc;
      qryAuxili.ParamByName('SERIE_').AsString   := strSerie;
      qryAuxili.ParamByName('CODFOR').AsString   := strCodFor;
      qryAuxili.ParamByName('CODEMP').AsString   := strCodEmp;

      qryAuxili.ExecSQL;

      qryAuxili.Close;
      qryAuxili.SQL.Clear;
      qryAuxili.SQL.Add(' UPDATE CADFIS SET FIS_DTAENT = :DTAENT ');
      qryAuxili.SQL.Add(' WHERE FIS_NUMDOC = :NUMDOC             ');
      qryAuxili.SQL.Add('   AND FIS_ESPDOC = :ESPDOC             ');
      qryAuxili.SQL.Add('   AND FIS_SERIE_ = :SERIE_             ');
      qryAuxili.SQL.Add('   AND FIS_FORCLI = :CODFOR             ');
      qryAuxili.SQL.Add('   AND FIS_CODEMP = :CODEMP             ');
      qryAuxili.SQL.Add('   AND FIS_TIP_FC = "F"                 ');
      qryAuxili.SQL.Add('   AND FIS_DTAENT IS NULL               ');

      If dteDtaEnt = 0 Then
        qryAuxili.ParamByName('DTAENT').AsDateTime := fNow()
      Else
        qryAuxili.ParamByName('DTAENT').AsDateTime := dteDtaEnt;
      qryAuxili.ParamByName('NUMDOC').AsString   := strNumDoc;
      qryAuxili.ParamByName('ESPDOC').AsString   := strEspDoc;
      qryAuxili.ParamByName('SERIE_').AsString   := strSerie;
      qryAuxili.ParamByName('CODFOR').AsString   := strCodFor;
      qryAuxili.ParamByName('CODEMP').AsString   := strCodEmp;

      qryAuxili.ExecSQL;

      qryAuxili.Close;
      qryAuxili.SQL.Clear;
      qryAuxili.SQL.Add(' UPDATE CADPAG SET CTP_DTACAD = :DTAENT ');
      qryAuxili.SQL.Add(' WHERE CTP_NUMDUP = :NUMDOC             ');
      qryAuxili.SQL.Add('   AND CTP_SERIE_ = :SERIE_             ');
      qryAuxili.SQL.Add('   AND CTP_CODFOR = :CODFOR             ');
      qryAuxili.SQL.Add('   AND CTP_CODEMP = :CODEMP             ');
      qryAuxili.SQL.Add('   AND CTP_DTACAD IS NULL               ');

      If dteDtaEnt = 0 Then
        qryAuxili.ParamByName('DTAENT').AsDateTime := fNow()
      Else
        qryAuxili.ParamByName('DTAENT').AsDateTime := dteDtaEnt;

      qryAuxili.ParamByName('NUMDOC').AsString   := strNumDoc;
      qryAuxili.ParamByName('SERIE_').AsString   := strSerie;
      qryAuxili.ParamByName('CODFOR').AsString   := strCodFor;
      qryAuxili.ParamByName('CODEMP').AsString   := strCodEmp;

      qryAuxili.ExecSQL;

      {REF.OUTRAS DESPESA req 224901}
      strNotEnt    := strNumDoc + strEspDoc + strCodEmp + fstrEspaco(strSerie, 3) + strCodFor;
      qryAuxili.Close;
      qryAuxili.SQL.Clear;
      qryAuxili.SQL.Add(' UPDATE CADPAG SET CTP_DTACAD = :DTAENT ');
      qryAuxili.SQL.Add(' WHERE CTP_NOTENT = :NOTENT             ');
      qryAuxili.SQL.Add('   AND CTP_DTACAD IS NULL               ');

      If dteDtaEnt = 0 Then
        qryAuxili.ParamByName('DTAENT').AsDateTime := fNow()
      Else
        qryAuxili.ParamByName('DTAENT').AsDateTime := dteDtaEnt;

      qryAuxili.ParamByName('NOTENT').AsString   := strNotEnt;
      qryAuxili.ExecSQL;

      If (dteDtaSFo > 0) Or (dteDtaCTr > 0) Or (dteDtaCEm > 0) Then
      Begin
        qryAuxili.Close;
        qryAuxili.SQL.Clear;

        qryAuxili.SQL.Add(' UPDATE AUXMOV A INNER JOIN MOVGER B ON B.AUTOINCREM = AUX_SEQGER ');
        qryAuxili.SQL.Add('        SET AUX_DTASFO = :DTASFO,       ');
        qryAuxili.SQL.Add('            AUX_DTACTR = :DTACTR,       ');
        qryAuxili.SQL.Add('            AUX_DTACEM = :DTACEM        ');
        If Not fEmptyStr(strAutIncNatOperacao) Then
          qryAuxili.SQL.Add('         ,AUX_NATCFO = :NATCFO        ');
        qryAuxili.SQL.Add(' WHERE GER_NUMDOC = :NUMDOC             ');
        qryAuxili.SQL.Add('   AND GER_ESPDOC = :ESPDOC             ');
        qryAuxili.SQL.Add('   AND GER_SERIE_ = :SERIE_             ');
        qryAuxili.SQL.Add('   AND GER_CODFOR = :CODFOR             ');
        qryAuxili.SQL.Add('   AND GER_CODEMP = :CODEMP             ');

        If dteDtaSFo = 0 Then
          qryAuxili.ParamByName('DTASFO').Clear
        Else
          qryAuxili.ParamByName('DTASFO').AsDateTime := dteDtaSFo;

        If dteDtaCTr = 0 Then
          qryAuxili.ParamByName('DTACTR').Clear
        Else
          qryAuxili.ParamByName('DTACTR').AsDateTime := dteDtaCTr;

        If dteDtaCEm = 0 Then
          qryAuxili.ParamByName('DTACEM').Clear
        Else
          qryAuxili.ParamByName('DTACEM').AsDateTime := dteDtaCEm;

        if not fEmptyStr(strAutIncNatOperacao) Then
          qryAuxili.ParamByName('NATCFO').AsString := strAutIncNatOperacao;

        qryAuxili.ParamByName('NUMDOC').AsString   := strNumDoc;
        qryAuxili.ParamByName('ESPDOC').AsString   := strEspDoc;
        qryAuxili.ParamByName('SERIE_').AsString   := strSerie;
        qryAuxili.ParamByName('CODFOR').AsString   := strCodFor;
        qryAuxili.ParamByName('CODEMP').AsString   := strCodEmp;

        qryAuxili.ExecSQL;


      End;

      qryAuxili.Close;
      qryAuxili.SQL.Clear;
      qryAuxili.SQL.Add(' SELECT ');
      qryAuxili.SQL.Add('   IFNULL(T.DET_BASANT, 0) AS DET_BASANT, ');
      qryAuxili.SQL.Add('   IFNULL(T.DET_ICMANT, 0) AS DET_ICMANT, ');
      qryAuxili.SQL.Add('   IFNULL(T.DET_VENDOR, 0) AS DET_VENDOR, ');
      qryAuxili.SQL.Add('   IFNULL(T.DET_OUTDES, 0) AS DET_OUTDES, ');
      qryAuxili.SQL.Add('   IFNULL(T.DET_OUTICM, 0) AS DET_OUTICM, ');
      qryAuxili.SQL.Add('   IFNULL(T.DET_VLGNRE, 0) AS DET_VLGNRE, ');

      qryAuxili.SQL.Add('   IFNULL(T.DET_VALTCI, 0) AS DET_VALTCI, ');
      qryAuxili.SQL.Add('   IFNULL(T.DET_VAL_TS, 0) AS DET_VAL_TS, ');

      qryAuxili.SQL.Add('   IFNULL(T.DET_CONFRE, 0) AS DET_CONFRE, ');
      qryAuxili.SQL.Add('   IFNULL(T.DET_RPAFRE, 0) AS DET_RPAFRE, ');

      qryAuxili.SQL.Add('   IFNULL(T.DET_ISEICM, 0) AS DET_ISEICM, ');
      qryAuxili.SQL.Add('   IFNULL(T.DET_VAEIPI, 0) AS DET_VAEIPI, ');
      qryAuxili.SQL.Add('   IFNULL(T.DET_VAERET, 0) AS DET_VAERET, ');
      qryAuxili.SQL.Add('   IFNULL(T.DET_ALQPIS, 0) AS DET_ALQPIS, ');
      qryAuxili.SQL.Add('   IFNULL(T.DET_ALQCOF, 0) AS DET_ALQCOF, ');
      qryAuxili.SQL.Add('   IFNULL(T.DET_UNIVIS, 0) AS DET_UNIVIS, ');

      qryAuxili.SQL.Add('   IFNULL(T.DET_VFCPST,0) AS DET_VFCPST, ');
      qryAuxili.SQL.Add('   IFNULL(T.DET_BFCPST,0) AS DET_BFCPST, ');
      qryAuxili.SQL.Add('   IFNULL(T.DET_PFCPST,0) AS DET_PFCPST, ');

      qryAuxili.SQL.Add('   IFNULL(T.DET_ICMNCR, 0) AS DET_ICMNCR, ');
      qryAuxili.SQL.Add('   IFNULL(T.DET_FCPNCR, 0) AS DET_FCPNCR, ');

      qryAuxili.SQL.Add('   IFNULL(V.ICD_PERFCP, 0) AS ICD_PERFCP, ');
      qryAuxili.SQL.Add('   IFNULL(V.ICD_VALFCP, 0) AS ICD_VALFCP, ');

      qryAuxili.SQL.Add('   AUX_COTMOE,            ');
      qryAuxili.SQL.Add('   DET_CLARET,            ');
      qryAuxili.SQL.Add('   IFNULL(AUX_MATREV, FOR_MATREV) AS FOR_MATREV,    ');
      qryAuxili.SQL.Add('  IFNULL(T.DET_SISCOM, 0) AS DET_SISCOM, ');

      qryAuxili.SQL.Add('   T.DET_SEQGER AS SEQTRI,            ');
      qryAuxili.SQL.Add('   T.DET_ALQFRE,                      ');

      qryAuxili.SQL.Add('   D.*                    ');

      qryAuxili.SQL.Add(' FROM MOVDET D                      ');
      qryAuxili.SQL.Add(' INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ');
      qryAuxili.SQL.Add(' INNER JOIN AUXMOV   ON   AUX_SEQGER = D.DET_SEQGER  ');
      qryAuxili.SQL.Add(' INNER JOIN CADFOR   ON   FOR_CODFOR = D.DET_CODFOR');
      qryAuxili.SQL.Add('  LEFT JOIN MOVICD V ON ICD_SEQGER = D.AUTOINCREM ');
      qryAuxili.SQL.Add(' WHERE DET_NUMDOC = :NUMDOC ');
      qryAuxili.SQL.Add('   AND DET_ESPDOC = :ESPDOC ');
      qryAuxili.SQL.Add('   AND DET_SERIE_ = :SERIE_ ');
      qryAuxili.SQL.Add('   AND DET_CODFOR = :CODFOR ');
      qryAuxili.SQL.Add('   AND DET_CODEMP = :CODEMP ');
      qryAuxili.SQL.Add('   AND DET_DTAENT IS NULL   ');

      qryAuxili.ParamByName('NUMDOC').AsString   := strNumDoc;
      qryAuxili.ParamByName('ESPDOC').AsString   := strEspDoc;
      qryAuxili.ParamByName('SERIE_').AsString   := strSerie;
      qryAuxili.ParamByName('CODEMP').AsString   := strCodEmp;
      qryAuxili.ParamByName('CODFOR').AsString   := strCodFor;

      qryAuxili.Open;

      If blnUtilizaEnderecamento Then
      Begin
        objEnderecamento.pLimpar;

        endDocumento.strNumDoc := strNumDoc;
        endDocumento.strEspDoc := strEspDoc;
        endDocumento.strSerie_ := strSerie;
        endDocumento.strCodEmp := strCodEmp;
        endDocumento.strCliFor := strCodFor;
        endDocumento.strTip_FC := 'F';

        objEnderecamento.endDocumento := endDocumento;
      End;

      blnTemItem := False;

      strClaFisBonificacao := fRetornarClassificacoesBonificacaoEntrada;


      qryAuxili.First;

      //Movimenta o Estoque.
      While (Not qryAuxili.Eof) and blnSucesso Do
      Begin
        //Atualiza Preço Medio / Ultima Compra
        fltUniImp := (qryAuxili.FieldByName('DET_TOTITE').AsFloat - qryAuxili.FieldByName('DET_DESESP').AsFloat);
        blnNotaImp := Copy(qryAuxili.FieldByName('DET_CLAFIS').AsString, 1, 1) = '3';


        If qryAuxili.FieldByName('DET_QTDITE').AsFloat > 0 Then
          fltUniImp := (fltUniImp / qryAuxili.FieldByName('DET_QTDITE').AsFloat)
        Else
          fltUniImp := 0.0;

        fltUniImp := fFormataFloat(fltUniImp, 4);

        fltTotUlt := ( qryAuxili.FieldByName('DET_TOTITE').AsFloat - qryAuxili.FieldByName('DET_DESESP').AsFloat );
        fltPreUlt := fltTotUlt / qryAuxili.FieldByName('DET_QTDITE').AsFloat;
        fltPreUlt := fFormataFloat(fltPreUlt, 4);

        If (qryAuxili.FieldByName('DET_PROACA').AsString <> 'S') And
           ((qryAuxili.FieldByName('DET_TOTITE').AsFloat - qryAuxili.FieldByName('DET_DESESP').AsFloat) > 0) Then
        Begin
          If (Pos(qryAuxili.FieldByName('DET_CODFOR').AsString, strForFil) <= 0)  Or ((Pos(qryAuxili.FieldByName('DET_CODFOR').AsString, strForFil) > 0) And (fCfgSis('TRDPCI') = 'S')) Then
            fltIcmMed := IIF((fFormataFloat(qryAuxili.FieldByName('DET_TOTITE').AsFloat, 2) <> fFormataFloat(qryAuxili.FieldByName('DET_BASICM').AsFloat, 2)),
                                              fFormataFloat((qryAuxili.FieldByName('DET_VALICM').AsFloat / (qryAuxili.FieldByName('DET_TOTITE').AsFloat - qryAuxili.FieldByName('DET_DESESP').AsFloat)) * 100, 2),
                                              qryAuxili.FieldByName('DET_ALQICM').AsFloat + qryAuxili.FieldByName('ICD_PERFCP').AsFloat)
          Else
            fltIcmMed := 0;

          {*************************************************************}
          {* CONFIGURAÇÃO QUE PERMITE UTILIZAR O ÚLTIMO PRECO DE       *}
          {* COMPRA PARA FORMAÇÃO DO PRECO MÉDIO DO PRODUTO            *}
          {**************************** 22/07/09**************** AM ****}
          CalculoPrecoMediAgrup.strCodIteAtual := qryAuxili.FieldByName('DET_CODITE').AsString;
          If (fCfgSis('BASMED') <> 'S') Then
            fltPreMed := fCalculaPrecoMedio( qryAuxili.FieldByName('DET_CODFIS').AsString,        // Código Fiscal
                                           qryAuxili.FieldByName('DET_CLAFIS').AsString,        // Classificação Fiscal
                                           fItem('ITE_PREMED'),                         // Preço medio anterior
                                           fItem('ITE_SALDOS'),                         // Saldo anterior

                                           qryAuxili.FieldByName('DET_QTDITE').AsFloat,           // Quantidade de entrada
                                           fltUniImp,                                   // Unitario sem impostos
                                           fltIcmMed,                                  // Aliquota de ICMS do Item
                                           qryAuxili.FieldByName('DET_VALIPI').AsFloat +
                                           qryAuxili.FieldByName('DET_VAEIPI').AsFloat,           // Valor do IPI
                                           qryAuxili.FieldByName('DET_VALRET').AsFloat +
                                           qryAuxili.FieldByName('DET_VAERET').AsFloat,           // Valor de Substituição
                                           qryAuxili.FieldByName('DET_ICMANT').AsFloat,           // Valor ICMS Antecipado
                                           qryAuxili.FieldByName('DET_VLGNRE').AsFloat,

                                           qryAuxili.FieldByName('DET_VALTCI').AsFloat,
                                           qryAuxili.FieldByName('DET_VAL_TS').AsFloat,

                                           blnContribuinteIPI,                          // Contribuinte de IPI?
                                           (Pos(qryAuxili.FieldByName('DET_CODFOR').AsString, strForFil) > 0),    // Fornecedor Filial

                                           qryAuxili.FieldByName('DET_INCPIS').AsString,          // Indice se incide Pis
                                           qryAuxili.FieldByName('DET_TOTFRE').AsFloat +
                                           qryAuxili.FieldByName('DET_CONFRE').AsFloat +
                                           qryAuxili.FieldByName('DET_RPAFRE').AsFloat,
                                           qryAuxili.FieldByName('DET_OUTDES').AsFloat +
                                           qryAuxili.FieldByName('DET_VENDOR').AsFloat +
                                           qryAuxili.FieldByName('DET_DESACE').AsFloat,

                                           qryAuxili.FieldByName('DET_VALICM').AsFloat + qryAuxili.FieldByName('ICD_VALFCP').AsFloat,

                                           IIF((qryAuxili.FieldByName('DET_VALICM').AsFloat + qryAuxili.FieldByName('ICD_VALFCP').AsFloat) > 0,
                                               0,
                                               qryAuxili.FieldByName('DET_ICMNCR').AsFloat + qryAuxili.FieldByName('DET_FCPNCR').AsFloat),

                                           qryAuxili.FieldByName('DET_VFCPST').AsFloat,
                                           qryAuxili.FieldByName('DET_ALQFRE').AsFloat,
                                           CalculoPrecoMediAgrup,
                                           qryAuxili.FieldByName('DET_VAEIPI').AsFloat > 0)
          Else
            fltPreMed := fCalculaPrecoMedio( qryAuxili.FieldByName('DET_CODFIS').AsString,        // Código Fiscal
                                           qryAuxili.FieldByName('DET_CLAFIS').AsString,        // Classificação Fiscal
                                           fItem('ITE_PRECOM'),                         // Preço compra anterior
                                           fItem('ITE_SALDOS'),                         // Saldo anterior
                                           qryAuxili.FieldByName('DET_QTDITE').AsFloat,           // Quantidade de entrada
                                           fltUniImp,                                   // Unitario sem impostos
                                           fltIcmMed,                                   // Aliquota de ICMS do Item
                                           qryAuxili.FieldByName('DET_VALIPI').AsFloat +
                                           qryAuxili.FieldByName('DET_VAEIPI').AsFloat,           // Valor do IPI
                                           qryAuxili.FieldByName('DET_VALRET').AsFloat +
                                           qryAuxili.FieldByName('DET_VAERET').AsFloat,           // Valor de Substituição
                                           qryAuxili.FieldByName('DET_ICMANT').AsFloat,           // Valor ICMS Antecipado

                                           qryAuxili.FieldByName('DET_VLGNRE').AsFloat,
                                           qryAuxili.FieldByName('DET_VALTCI').AsFloat,
                                           qryAuxili.FieldByName('DET_VAL_TS').AsFloat,

                                           blnContribuinteIPI,                          // Contribuinte de IPI?
                                           (Pos(qryAuxili.FieldByName('DET_CODFOR').AsString, strForFil) > 0),    // Fornecedor Filial
                                           qryAuxili.FieldByName('DET_INCPIS').AsString,          // Indice se incide Pis
                                           qryAuxili.FieldByName('DET_TOTFRE').AsFloat +
                                           qryAuxili.FieldByName('DET_CONFRE').AsFloat +
                                           qryAuxili.FieldByName('DET_RPAFRE').AsFloat,
                                           qryAuxili.FieldByName('DET_OUTDES').AsFloat +
                                           qryAuxili.FieldByName('DET_VENDOR').AsFloat +
                                           qryAuxili.FieldByName('DET_DESACE').AsFloat,

                                           qryAuxili.FieldByName('DET_VALICM').AsFloat + qryAuxili.FieldByName('ICD_VALFCP').AsFloat,

                                           IIF((qryAuxili.FieldByName('DET_VALICM').AsFloat + qryAuxili.FieldByName('ICD_VALFCP').AsFloat) > 0,
                                               0,
                                               qryAuxili.FieldByName('DET_ICMNCR').AsFloat + qryAuxili.FieldByName('DET_FCPNCR').AsFloat),

                                           qryAuxili.FieldByName('DET_VFCPST').AsFloat,
                                           qryAuxili.FieldByName('DET_ALQFRE').AsFloat,
                                           CalculoPrecoMediAgrup,
                                           qryAuxili.FieldByName('DET_VAEIPI').AsFloat > 0)

        End
        Else
          fltPreMed := 0.0;

        If (Pos(qryAuxili.FieldByName('DET_CLAFIS').AsString, '1922_2922_') <= 0) And
           (qryAuxili.FieldByName('DET_PROACA').AsString <> 'S') And
           (((Pos(qryAuxili.FieldByName('DET_CLAFIS').AsString, VS_strClaCom + '_1117_2117_2116_1116' + strClaFisBonificacao) > 0) And (Not (Pos(qryAuxili.FieldByName('DET_CODFOR').AsString, strForFil) > 0))) Or
            ((blnAtuMed Or blnAtuUlt) And (Pos(qryAuxili.FieldByName('DET_CODFOR').AsString, strForFil) > 0))) And
             ((qryAuxili.FieldByName('DET_TOTITE').AsFloat - qryAuxili.FieldByName('DET_DESESP').AsFloat) > 0) Then
        Begin

          objImpUlt := TCalculoUltimaCompraImpostos.fCriaImpUlt
            .TotalItem(qryAuxili.FieldByName('DET_TOTITE').AsFloat)
            .DescontoEspecial(qryAuxili.FieldByName('DET_DESESP').AsFloat);
          try
            If blnUltPis Then
            Begin
              objImpUlt.AliquotaPis(qryAuxili.FieldByName('DET_ALQPIS').AsFloat).AliquotaCofins(qryAuxili.FieldByName('DET_ALQCOF').AsFloat);
            End
            Else
            Begin
              objImpUlt.AliquotaPis(0).AliquotaCofins(0);
            End;
            blnZeraIPI := fZeraIPI(qryAuxili.FieldByName('DET_CODITE').AsString);
            objImpUlt.blnUltPis := blnUltPis;

            objImpUlt
              .ValorIpi(IIf(blnZeraIPI, 0, qryAuxili.FieldByName('DET_VALIPI').AsFloat))
              .ValorIpiNaoCreditado(IIf(blnZeraIPI, 0, qryAuxili.FieldByName('DET_VAEIPI').AsFloat))

              .Frete(qryAuxili.FieldByName('DET_TOTFRE').AsFloat)
              .ConhecimentoFrete(qryAuxili.FieldByName('DET_CONFRE').AsFloat)
              .AliquotaICMSdoFrete(qryAuxili.FieldByName('DET_ALQFRE').AsFloat)

              .fRecebimentoPagamentoAutonomoFrete(qryAuxili.FieldByName('DET_RPAFRE').AsFloat)
              .OutrasDespesas(qryAuxili.FieldByName('DET_OUTDES').AsFloat)
              .Vendor(qryAuxili.FieldByName('DET_VENDOR').AsFloat)
              .DespesaAcessoria(qryAuxili.FieldByName('DET_DESACE').AsFloat)

              .ValorIcms(IIF(blnDedIcm and (not blnNotaImp), qryAuxili.FieldByName('DET_VALICM').AsFloat + qryAuxili.FieldByName('ICD_VALFCP').AsFloat, 0))

              .ValorIcmsNaoCreditado(IIF(blnDedIcm and (not blnNotaImp), IIF((qryAuxili.FieldByName('DET_VALICM').AsFloat + qryAuxili.FieldByName('ICD_VALFCP').AsFloat) > 0,
                                                        0,
                                                        qryAuxili.FieldByName('DET_ICMNCR').AsFloat) + qryAuxili.FieldByName('DET_FCPNCR').AsFloat, 0))

              .ValorIcmsAntecipado(qryAuxili.FieldByName('DET_ICMANT').AsFloat)
              .ValorIcmsAntecipadoFrete(0)
              .ValorGNRE(qryAuxili.FieldByName('DET_VLGNRE').AsFloat)
              .ValorTCIF(qryAuxili.FieldByName('DET_VALTCI').AsFloat)
              .ValorTS(qryAuxili.FieldByName('DET_VAL_TS').AsFloat)
              .ValorRetido(qryAuxili.FieldByName('DET_VALRET').AsFloat)
              .ValorRetidoNaoCreditado(qryAuxili.FieldByName('DET_VAERET').AsFloat)
              .ValorFundoCombateAPobreza(qryAuxili.FieldByName('DET_VFCPST').AsFloat)
              .FornecedorFilial(Pos(qryAuxili.FieldByName('DET_CODFOR').AsString, strForFil) > 0)
              .ItemIncidePis(qryAuxili.FieldByName('DET_INCPIS').AsString)
              .ValorSiscomex(IIf(blnNotaImp, qryAuxili.FieldByName('DET_SISCOM').AsFloat, 0))
              .ValorIcmsNotaImportacao(IIf(blnNotaImp, qryAuxili.FieldByName('DET_VALICM').AsFloat, 0));

            pAtualizaUltimaCompra(qryAuxili.FieldByName('DET_NUMDOC').AsString,
                                  qryAuxili.FieldByName('DET_ESPDOC').AsString,
                                  qryAuxili.FieldByName('DET_SERIE_').AsString,
                                  qryAuxili.FieldByName('DET_CODFOR').AsString,
                                  qryAuxili.FieldByName('DET_CODITE').AsString,
                                  qryAuxili.FieldByName('DET_CLAFIS').AsString,
                                  fItemC('ITE_CLAIPI'),
                                  strForFil,
                                  qryAuxili.FieldByName('DET_NUMLOT').AsString,
                                  fCfgSis('MEDEMP', varString), //strMedEmp,
                                  fEmpresasMedEmp, //strEmpMeds,
                                  blnAtuMed,
                                  blnAtuUlt,
                                  blnMedSe2,
                                  fltPreUlt,
                                  objImpUlt.fUnitario(qryAuxili.FieldByName('DET_QTDITE').AsFloat),
                                  fltPreMed,
                                  qryAuxili.FieldByName('DET_QTDITE').AsFloat,
                                  qryAuxili.FieldByName('AUX_COTMOE').AsFloat,
                                  VS_Date,
                                  False,
                                  Nil,
                                  False,
                                  blnAtualizouPrecoMedio);

            fAtualizaMovTriValoresCalculadosDoFrete(qryAuxili.FieldByName('AUTOINCREM').AsString, objImpUlt.ValorFreteCalculado, objImpUlt.ValorConhecimentoCalculado);

            If blnAtualizouPrecoMedio Then
            Begin
              blnSucesso := fGravaCalcPreMed(qryAuxili.FieldByName('AUTOINCREM').AsString, 'TfrmPlanoDeRecebimento.fEfetivaMovFiscal', '',True);

              If Not blnSucesso Then
                Raise Exception.Create('');

            End;
          finally
            FreeAndNil(objImpUlt);
          end;
        End;

        blnFilKar := False;

        If AnsiEndsText('933', qryAuxili.FieldByName('DET_CLAFIS').AsString) Then
          blnFilKar    := True;

        If Pos(qryAuxili.FieldByName('DET_CLAFIS').AsString, '1922_2922_') > 0 Then
          blnFilKar    := True;

        strClaRet := fTransform(fCfgSis('CLARET'), 4);

        If (qryAuxili.FieldByName('DET_CLARET').AsInteger = 1) and (Pos(qryAuxili.FieldByName('DET_CLAFIS').AsString, strClaRet) > 0) Then
            blnFilKar    := True;

        If (qryAuxili.FieldByName('FOR_MATREV').AsString = 'M')Then
           blnFilKar := True;

        If fIsItemEspecial(qryAuxili.FieldByName('DET_CODITE').AsString) Then
           blnFilKar := True;

        blnMarcaProAca := False;
        if (qryAuxili.FieldByName('DET_PROACA').AsString = 'S') then
        begin
          blnSucesso := blnSucesso and TProdAcabado.fAtualizaEstoque(qryAuxili.FieldByName('DET_CODACA').AsString,
                                                             qryAuxili.FieldByName('DET_EMPACA').AsString,
                                                             qryAuxili.FieldByName('DET_CODEMP').AsString,
                                                             'E',
                                                             qryAuxili.FieldByName('DET_QTDITE').AsFloat);

          ReprocessarItem(qryAuxili.FieldByName('DET_CODITE').AsString, '');

          If blnSucesso Then
            blnFilKar := True;

          blnMarcaProAca := blnFilKar;
        end
        else
        begin

          If (qryAuxili.FieldByName('DET_FILKAR').AsString = '1') Or (qryAuxili.FieldByName('DET_FILKAR').AsString = 'True') Then
          Begin
            If (Not blnFilKar) Then
              blnSucesso := blnSucesso And fAtualizaEstoqueCadIte(qryAuxili.FieldByName('DET_CODITE').AsString,
                                                          IfThen( StrToInt(LeftStr(qryAuxili.FieldByName('DET_CLAFIS').AsString, 1)) < 5, 'E', 'S'),
                                                          qryAuxili.FieldByName('DET_QTDITE').AsFloat,
                                                          0,
                                                          qryAuxili.FieldByName('DET_NUMLOT').AsString)
           Else
             blnSucesso := blnSucesso and blnFilKar;

          end;
        End;

        If (Not fIsItemEspecial(qryAuxili.FieldByName('DET_CODITE').AsString)) And
           (((Not blnFilKar) And (fDocumentoGeraEnderecamento) And (blnUtilizaEnderecamento) And (fCampoTabela('ITE_REAEND', 'CADITE', ['ITE_CODITE'], [qryAuxili.FieldByName('DET_CODITE').AsString]) <> 'N')) Or
            ((blnMarcaProAca) And (fDocumentoGeraEnderecamento) And (blnUtilizaEnderecamento)) And (Not fIsItemEspecial(qryAuxili.FieldByName('DET_CODITE').AsString)) )  Then
        Begin

          If Not (Pos(qryAuxili.FieldByName('DET_CLAFIS').AsString, '1922_2922_') > 0) Then
          Begin
            endItem.strCodIte := qryAuxili.FieldByName('DET_CODITE').AsString;
            endItem.strCodMar := qryAuxili.FieldByName('DET_CODMAR').AsString;
            endItem.strDesIte := qryAuxili.FieldByName('DET_DESCRI').AsString;
            endItem.strRefere := qryAuxili.FieldByName('DET_REFERE').AsString;
            endItem.strCodUni := qryAuxili.FieldByName('DET_UNIDAD').AsString;
            endItem.strCodFor := qryAuxili.FieldByName('DET_CODFOR').AsString;
            endItem.fltQtdIte := qryAuxili.FieldByName('DET_QTDITE').AsFloat;
            endItem.strCodAmz := qryAuxili.FieldByName('DET_NUMLOT').AsString;
            endItem.strAutDet := qryAuxili.FieldByName('AUTOINCREM').AsString;
            endItem.blnRefugo := False;

            endItem.strEmpAca := '';
            endItem.strCodAca := '';
            endItem.blnIteAca := qryAuxili.FieldByName('DET_PROACA').AsString = 'S';
            If endItem.blnIteAca Then
            Begin
              endItem.strEmpAca := qryAuxili.FieldByName('DET_EMPACA').AsString;
              endItem.strCodAca := qryAuxili.FieldByName('DET_CODACA').AsString;
            End;

            objEnderecamento.pAddItem(endItem);

            blnTemItem  := True;
          End;
        End;

        ReprocessarItem(qryAuxili.FieldByName('DET_CODITE').AsString, '');

        if  blnSucesso then
        begin
          qryUpdate.Close;
          qryUpdate.SQL.Clear;


          qryUpdate.SQL.Add(' UPDATE MOVDET SET DET_FILKAR = ' + intToStr(IIF(blnFilKar, 1, 0)) + ', ');
          qryUpdate.SQL.Add('                   DET_DTAENT = :DTAENT, ');
          qryUpdate.SQL.Add('                   DET_HORENT = :HORENT  ');
          qryUpdate.SQL.Add(' WHERE AUTOINCREM = :AUTINC              ');

          qryUpdate.ParamByName('AUTINC').AsString := qryAuxili.FieldByName('AUTOINCREM').AsString;

{          If fIsItemEspecial(qryAuxili.FieldByName('DET_CODITE').AsString) Then
            qryUpdate.ParamByName('FILKAR').AsInteger := 1
          Else
            qryUpdate.ParamByName('FILKAR').AsInteger := 0;}

          If dteDtaEnt = 0 Then
            qryUpdate.ParamByName('DTAENT').AsDateTime := fNow()
          Else
            qryUpdate.ParamByName('DTAENT').AsDateTime := dteDtaEnt;

          qryUpdate.ParamByName('HORENT').AsDateTime:= fNow;

          qryUpdate.ExecSQL;
        end;

        qryAuxili.Next;
      End;


      If fCfgSis('CDEFAL') = 'S' Then
        blnSucesso := TAtualizaPrecoEfetivacaoMovimentoFiscal.fEfetivaLotPre(qryAuxili.FieldByName('DET_NUMDOC').AsString,
                                                                             qryAuxili.FieldByName('DET_ESPDOC').AsString,
                                                                             qryAuxili.FieldByName('DET_SERIE_').AsString,
                                                                             qryAuxili.FieldByName('DET_CODFOR').AsString,
                                                                             qryAuxili.FieldByName('DET_CODEMP').AsString);

      if (blnTemItem) And (blnUtilizaEnderecamento) and (not blnRecebimentoDeGarantiaDaFilial) Then
      Begin
        pDeletaPedidoReservaAntigo;
        blnSucesso := blnSucesso and objEnderecamento.fGerarPedidoParaReservarEstoque;
        If Not fEmptyStr(objEnderecamento.strAutIncPed) Then
          LstrFatGor := objEnderecamento.strAutIncPed;
      End
      Else if  blnRecebimentoDeGarantiaDaFilial Then
      Begin
        blnSucesso := blnSucesso and objEfetivaMovimentoFiscal.fGravaFatGorGarantia And objEfetivaMovimentoFiscal.fGravaFatDorGarantia;
      End;

      If fConferenciaDepoisDaEntrada Then
      Begin
        objBaixaPedido := TDefineBaixaPedido.Create(Nil);
        try
          blnSucesso := blnSucesso and fBaixaPedidosAtendidosDepoisDaEntrada(qryAuxili.FieldByName('DET_SEQGER').AsString);

          If blnSucesso And (Not fUsaEnderecamento) Then
          Begin

            blnSucesso := objBaixaPedido.fGeraTERequisicao(qryAuxili.FieldByName('DET_SEQGER').AsString);

            If blnSucesso Then
            Begin
              pEnviaMsgRequisicaoConcluida(qryAuxili.FieldByName('DET_SEQGER').AsString, False);
              objBaixaPedido.ProcessaStatusPedidoRequisicao(qryAuxili.FieldByName('DET_SEQGER').AsString);
            end;
          End;
          IF blnSucesso Then
            objBaixaPedido.ProcessaStatusPedidoPendenteEnderecamento(qryAuxili.FieldByName('DET_SEQGER').AsString);

        finally
          FreeAndNil(objBaixaPedido);
        end;
      End;

      If Assigned(ANotaEletInfConf) then
        If blnSucesso then
        Begin
          If (fCfgSis('UDEVME', VarBoolean)) or
             (TEnderecamentoConferenciaParcial.ConferenciaSemDigConCorretaPorDigEle(ANotaEletInfConf.FDigEle)) then
          Begin
            If ANotaEletInfConf.FDtaCon > 0 then
            begin
              lDistribuicaoConferencia := TDistribuicaoConferenciaFactory.CriarPorIDeDig(ANotaEletInfConf.FDigEle);
              try
                lDistribuicaoConferencia.EfetivacaoMovimentoFiscal := True;
                lDistribuicaoConferencia.fFinalizaConferencia;
              finally
                FreeAndNil(lDistribuicaoConferencia);
              End;
            End;
          End;
          If (ANotaEletInfConf.FEntSim = 'S') And (Not fEmptyStr(LstrFatGor)) then
            blnSucesso := blnSucesso And TDistribuicaoConferencia.fGerarDigConEntradaSimplificada(LstrFatGor);
        End;

      if not blnSucesso then
        raise Exception.Create('Erro ao efetivar o movimento fiscal!');

    Except
      On E : Exception Do
      Begin
        blnSucesso := False;
        raise;
      End;
    End;

  Finally
    FreeAndNil(CalculoPrecoMediAgrup);
    If blnComTransacao then
    begin
      if blnSucesso Then
        fCommit
      else
        fRollBack;
    end;

    If Assigned(qryAuxili) Then
      FreeAndNil(qryAuxili);

    If Assigned(qryUpdate) Then
      FreeAndNil(qryUpdate);

    If Assigned(objEnderecamento) Then
      FreeAndNil(objEnderecamento);

    If Assigned(objEfetivaMovimentoFiscal) Then
      FreeAndNil(objEfetivaMovimentoFiscal);
  End;

End;


function TEfetivaMovimentoFiscal.fGravaFatDorGarantia: Boolean;
  var
    objGarant: TMovGag;
    strAutIncPcd,
    strAutIncPedDet : String;
    Lista : TStringList;

begin
  Lista := TStringList.Create;
  Lista.Delimiter := ',';

  Try
    {*****************************************************************}
    {* SE FOR UMA ENTRADA DE MERCADORIA, REFERENTE A UM PEDIDO DE    *}
    {* COMPRA GERADO ATRAVÉS DE UMA TRANSFERENCIA DE ESTOQUE DE      *}
    {* GARANTIA, GRAVA PEDIDO DE VENDA PARA RESERVAR O PRODUTO, POIS *}
    {* O MESMO NÃO PODE SER VENDIDO PELO FATO DE ESTAR COM DEFEITO.  *}
    {**************************************************************MM*}
    Result := False;

    pAbreMovDet('MOVDET');

    With qryMovDet Do
    While (Not Eof) Do
    Begin
      strAutIncPedDet := '';
      strAutIncPcd := '';
      Result := untFatGor.fGravaFatDor(strAutIncPedDet,
                                       strAutIncPed,
                                       VS_strCodEmp,
                                       strCodCliPed,
                                       strCodOpe,
                                       FieldByName('DET_CODITE').AsString,
                                       FieldByName('DET_CODMAR').AsString,
                                       '',
                                       strNumPedVen,
                                       'PD',
                                       '',
                                       VS_Date,
                                       fTime(),
                                       '01000',
                                       '',
                                       FieldByName('DET_DESCRI').AsString,
                                       FieldByName('DET_REFERE').AsString,
                                       FieldByName('DET_UNIDAD').AsString,
                                       IfThen(fEmptyStr(FieldByName('DET_CODFOR').AsString), fRetFornecedorItem(FieldByName('DET_CODITE').AsString), FieldByName('DET_CODFOR').AsString),
                                       FieldByName('DET_QTDITE').AsFloat,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       fRetCodRepresCliente(fRetornaClienteFilial(VS_strCodEmp)),
                                       '',
                                       0,
                                       0,
                                       0,
                                       '5999',
                                       '',
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       False,
                                       '',
                                       '',
                                       '',
                                       0,
                                       '',
                                       '',
                                       0.0,
                                       'NOR',
                                       '',
                                       '',
                                       '',
                                       '',
                                       '',
                                       '',
                                       '',
                                       '',
                                       '',
                                       0,
                                       0,
                                       '',
                                       0,
                                       0,
                                       0,
                                       '',
                                       '',
                                       0,
                                       '',
                                       '',
                                       0.0,
                                       0,
                                       0,
                                       0,
                                       '',
                                       0,
                                       '',
                                       '',
                                       False,
                                       '1',
                                       '',
                                       '',
                                       '',
                                       0,
                                       '',
                                       0,
                                       '',
                                       '',
                                       'N',
                                       '',
                                       0,
                                       0,
                                       0,
                                       0,
                                       '',
                                       '',
                                       '',
                                       False,
                                       '',
                                       '',
                                       '',
                                       '',
                                       '',
                                       '',
                                       0,
                                       0,
                                       '',
                                       '',
                                       0,
                                       '',
                                       '',
                                       0,
                                       0,
                                       0);

      If (Result) Then
      Begin
        Try
          objGarant := TMovGag.Create(Nil);

          Lista.Commatext := FieldByName('ENT_SEQPCD').AsString;
          strAutIncPcd :=  fRetIncValido(Lista);

          Result := objGarant.objMovGad.fAtualizaSeqGarantia('SEQ_FATDOR', strAutIncPedDet, 'SEQ_PCMDET', strAutIncPcd);
        Except
          ON E : Exception Do
          Begin
            Result := False;
            pMensagensErro(e.message,'');
          End;
        End;

        FreeAndNil(objGarant);

      End;

      Next;
    End;
  Finally
    FreeAndNil(Lista);
  End;
end;

function TEfetivaMovimentoFiscal.fGravaFatGorGarantia: Boolean;
  Var
    recServicos: TDadosServicos;
    arrDuplic : TarrDuplicata;
begin
  FillChar(recServicos, SizeOf(recServicos), #0);
  {*****************************************************************}
  {* SE FOR UMA ENTRADA DE MERCADORIA, REFERENTE A UM PEDIDO DE    *}
  {* COMPRA GERADO ATRAVÉS DE UMA TRANSFERENCIA DE ESTOQUE DE      *}
  {* GARANTIA, GRAVA PEDIDO DE VENDA PARA RESERVAR O PRODUTO, POIS *}
  {* O MESMO NÃO PODE SER VENDIDO PELO FATO DE ESTAR COM DEFEITO.  *}
  {**************************************************************MM*}
  strNumPedVen := fRetSequencialPedido;
  strCodCliPed := fRetornaClienteFilial(VS_strCodEmp);
  strCodOpe    := strLoginUsuarioLogado;

  FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

  Result := untFatGor.fGravaFatGor(strAutIncPed,
                                   VS_strCodEmp,
                                   strNumPedVen,
                                   'PD',
                                   strCodCliPed,
                                   strCodOpe,
                                   '',
                                   '',
                                   VS_Date,
                                   fTime(),
                                   '01000',
                                   fRetNomCidade(fRetNomGeral('CLI_CODCID', 'CLI_CODCLI', 'CADCLI', fStrToFloat(strCodCliPed)) ,1),
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   0,
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
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   '',
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   arrDuplic,
                                   '',
                                   '',
                                   'GARANTIA',
                                   '',
                                   False,
                                   '',
                                   '',
                                   '',
                                   0,
                                   '',
                                   '',
                                   0.0,
                                   0,
                                   strCodOpe,
                                   '',
                                   '',
                                   recServicos,
                                   '',
                                   0,
                                   0,
                                   0,
                                   '',
                                   '',
                                   '',
                                   0,
                                   '',
                                   0,
                                   '1',
                                   '',
                                   0,
                                   '',
                                   '',
                                   False,
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   False,
                                   VS_Date,
                                   'N',
                                   'V',
                                   VS_Date,
                                   '',
                                   0,
                                   '',
                                   '',
                                   '',
                                   False,
                                   '',
                                   Nil,
                                   '',
                                   '',
                                   0,
                                   0,
                                   0,
                                   '',
                                   Nil,
                                   '',
                                   0,
                                   0,
                                   '',
                                   '',
                                   0,
                                   '',
                                   0,
                                   '',
                                   '0',
                                   'N',
                                   'N');
end;

function TEfetivaMovimentoFiscal.fRetIncValido(Lista: TStringList): String;
var qryConsulta: TUniQuery;
    i: integer;
begin
  Result := '';
  qryConsulta := fCriaQuery;
  Try
    For i := 0 To Lista.Count -1 do
    Begin
      qryConsulta.Close;
      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD FROM SEQGAR WHERE SEQ_PCMDET = "' +Lista[i]+ '" AND IFNULL(SEQ_FATDOR,"") = ""');
      qryConsulta.Open;
      If qryConsulta.FieldByName('QTD').AsInteger = 1 Then
        Exit(Lista[i]);
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

Procedure TEfetivaMovimentoFiscal.pAbreMovDet(strTabela: String);
  Var
    strSQL: String;
    intCont: Integer;
    strTabMovIcd: string;
    blnAtuICS : Boolean;
Begin
  blnAtuICS := fCfgSis('ATUICS', varBoolean);

  strSQL := '';
  strSQL := strSQL +  ' SELECT ';

  If Pos('MOVDET', strTabela) > 0 Then
    strSQL := strSQL +  '  IF(DET_LOTABA <> "", DET_LOTABA, IFNULL(DET_NUMLOT,"")) AS DET_NUMLOT, ';

  strSQL := strSQL +  ' CAST("" AS CHAR(20)) AS AUTOINCREMENTO_GRAVACAO, ';

  strSQL := strSQL +  '  D.*, ';
  strSQL := strSQL +  '  DET_PESLIQ, ';
  strSQL := strSQL +  '  DET_CSTIPI, ';
  strSQL := strSQL +  '  DET_ENQIPI, ';
  strSQL := strSQL +  '  IFNULL(T.DET_BASANT, 0) AS DET_BASANT, ';
  strSQL := strSQL +  '  IFNULL(T.DET_ICMANT, 0) AS DET_ICMANT, ';
  strSQL := strSQL +  '  IFNULL(T.DET_VENDOR, 0) AS DET_VENDOR, ';
  strSQL := strSQL +  '  IFNULL(T.DET_OUTDES, 0) AS DET_OUTDES, ';
  strSQL := strSQL +  '  IFNULL(T.DET_OUTICM, 0) AS DET_OUTICM, ';
  strSQL := strSQL +  '  IFNULL(T.DET_VLGNRE, 0) AS DET_VLGNRE, ';
  strSQL := strSQL +  '  IFNULL(T.DET_VALTCI, 0) AS DET_VALTCI, ';
  strSQL := strSQL +  '  IFNULL(T.DET_VAL_TS, 0) AS DET_VAL_TS, ';

  If Pos('NOTDET', strTabela) > 0 Then
    strSQL := strSQL +  '  0.00 AS DET_CONFRE, '
  Else
    strSQL := strSQL +  '  IFNULL(T.DET_CONFRE, 0) AS DET_CONFRE, ';

  If fCfgSis('FRMCUS',varString ) = '1' Then
    strSql := strSql + '  ( ( ( DET_VALRET + T.DET_VAERET + T.DET_ICMANT + T.DET_VLGNRE ) / (DET_TOTITE - DET_DESESP + DET_VALIPI + IFNULL(T.DET_VAEIPI, 0))) * 100 ) AS PERSUB, '
  Else
    strSql := strSql + '  ( ( ( DET_VALRET + T.DET_VAERET + T.DET_ICMANT + T.DET_VLGNRE ) / (DET_TOTITE - DET_DESESP) ) * 100 ) AS PERSUB, ';

  strSQL := strSQL +  '  IFNULL(T.DET_SISCOM, 0) AS DET_SISCOM, ';
  strSQL := strSQL +  '  IFNULL(T.DET_ISEICM, 0) AS DET_ISEICM, ';
  strSQL := strSQL +  '  IFNULL(T.DET_ALEIPI, 0) AS DET_ALEIPI, ';
  strSQL := strSQL +  '  IFNULL(T.DET_VAEIPI, 0) AS DET_VAEIPI, ';
  strSQL := strSQL +  '  IFNULL(T.DET_VAERET, 0) AS DET_VAERET, ';
  strSQL := strSQL +  '  IFNULL(T.DET_ALQPIS, 0) AS DET_ALQPIS, ';
  strSQL := strSQL +  '  IFNULL(T.DET_ALQCOF, 0) AS DET_ALQCOF, ';
  strSQL := strSQL +  '  IFNULL(T.DET_UNIVIS, 0) AS DET_UNIVIS, ';

  (*********************************************************************)
  (* CAMPOS UTILIZADOS NA FUNCAO frmModuloPcmGer.fDefinePedidosABaixar *)
  (******************************************************************LA*)
  strSQL := strSQL + '  DET_CODITE AS ENT_CODITE, ';
  strSQL := strSQL + '  IFNULL(DET_NUMLOT,"") AS ENT_NUMLOT, ';
  strSQL := strSQL + '  DET_QTDITE AS ENT_QTDITE, ';
  strSQL := strSQL + '  DET_UNITAR AS ENT_UNITAR, ';
  strSQL := strSQL + '  0.0000     AS ENT_PERSUB, ';
  strSQL := strSQL + '  0.0000     AS ENT_PERIPI, ';

  strSQL := strSQL + '  I.ITE_INCPIS, ';
  strSQL := strSQL + '  I.ITE_CODFOR, ';
  strSQL := strSQL + '  I.ITE_CODMAR, ';
  strSQL := strSQL + '  I.ITE_REAEND, ';
  strSQL := strSQL + '  UNI_SIGUNI AS ITE_SIGUNI, ';

  strSQL := strSQL + '  GC.GRU_OPERES AS ITE_OPERES, ';

  strSQL := strSQL + '  G.ITE_FORULT, ';
  strSQL := strSQL + '  G.ITE_PREMED, ';

  For intCont := 1 To Length(VS_strTabPrc) Do
  Begin
    strSQL := strSQL + '  G.ITE_PREVE' + IntToStr(intCont) + ', ';
    strSQL := strSQL + '  G.ITE_MARBR' + IntToStr(intCont) + ', ';
    strSQL := strSQL + '  G.ITE_COMTB' + IntToStr(intCont) + ', ';
  End;

  strSQL := strSQL + '  G.ITE_PRECUS, ';
  strSQL := strSQL + '  G.ITE_SALDOS, ';
  strSQL := strSQL + '  G.ITE_PREMED, ';
  strSQL := strSQL + '  G.ITE_PRECOM, ';

  strSQL := strSQL + '  G.ITE_DESF01, ';
  strSQL := strSQL + '  G.ITE_DESF02, ';
  strSQL := strSQL + '  G.ITE_DESF03, ';
  strSQL := strSQL + '  G.ITE_DESF04, ';
  strSQL := strSQL + '  G.ITE_DESF05, ';
  strSQL := strSQL + '  G.ITE_DESF06, ';

  strSQL := strSQL + '  G.ITE_ICMENT, ';
  strSQL := strSQL + '  G.ITE_SUBFED, ';
  strSQL := strSQL + '  G.ITE_IPIENT, ';
  strSQL := strSQL + '  G.ITE_FREENT, ';
  strSQL := strSQL + '  G.ITE_VALFRE, ';
  strSQL := strSQL + '  G.ITE_ACRFIN, ';
  strSQL := strSQL + '  G.ITE_SUBSTI, ';
  strSQL := strSQL + '  G.ITE_DESADB, ';
  strSQL := strSQL + '  G.ITE_OUTVAL, ';
  If blnAtuICS Then
    strSQL := strSQL + '  ROUND(B.ABF_ALQICM_SAI_CNC * (B.ABF_BASICM_SAI_CNC / 100), 2) ITE_ICMSAI, '
  Else
  strSQL := strSQL + '  G.ITE_ICMSAI, ';
  strSQL := strSQL + '  G.ITE_IMPFED, ';
  strSQL := strSQL + '  G.ITE_DESOPE, ';
  strSQL := strSQL + '  G.ITE_DESMAX, ';
  strSQL := strSQL + '  G.ITE_MARMIN, ';

  strSQL := strSQL + '  IFNULL(ICD_BASFCP, 0) AS ICD_BASFCP, ';
  strSQL := strSQL + '  IFNULL(ICD_PERFCP, 0) AS ICD_PERFCP, ';
  strSQL := strSQL + '  IFNULL(ICD_VALFCP, 0) AS ICD_VALFCP, ';

  strSQL := strSQL + '  IFNULL(T.DET_VFCPST,0) AS DET_VFCPST, ';
  strSQL := strSQL + '  IFNULL(T.DET_BFCPST,0) AS DET_BFCPST, ';
  strSQL := strSQL + '  IFNULL(T.DET_PFCPST,0) AS DET_PFCPST, ';

//  strSQL := strSQL + ' (SELECT SEQ_PCMDET FROM SEQGAR WHERE SEQ_DET_TE = D.AUTOINCREM) AS ENT_SEQPCD ';

  strSQL := strSQL + ' ( SELECT GROUP_CONCAT(PCD.AUTOINCREM)';
  strSQL := strSQL + '   FROM PCMGER G2                                            ';
  strSQL := strSQL + '     INNER JOIN PCMDET PCD ON PCD.PCD_NUMPED = G2.PCG_NUMPED ';
  strSQL := strSQL + '                          AND PCD.PCD_CODEMP = G2.PCG_CODEMP ';
  strSQL := strSQL + '                          AND PCD.PCD_ESPDOC = G2.PCG_ESPDOC ';
  strSQL := strSQL + '   WHERE G2.AUTOINCREM = :INCPCG                             ';
  strSQL := strSQL + '     AND PCD.PCD_CODITE = D.DET_CODITE                       ';
  strSQL := strSQL + '     AND PCD.PCD_QTDITE = D.DET_QTDITE ) AS ENT_SEQPCD       ';

  strSQL := strSQL + ' FROM ' + strTabela + ' D ';

  strSQL := strSQL + ' LEFT JOIN ' + fRetNomTabMovTri(strTabela) + ' T ON T.DET_SEQGER = D.AUTOINCREM ';

  strSQL := strSQL + ' INNER JOIN CADITE I ON I.ITE_CODITE = DET_CODITE ';
  strSQL := strSQL + ' INNER JOIN ITEGER G ON G.ITE_CODITE = DET_CODITE AND ';
  strSQL := strSQL + '                        G.ITE_CODEMP = :CODEMP        ';

  strSQL := strSQL + ' LEFT JOIN CADUNI  ON UNI_CODUNI = ITE_CODUNI ';

  strSQL := strSQL + ' LEFT JOIN GRU_COMPRA GC ON I.ITE_GRUCMP = GC.GRU_CODIGO ';
  strTabMovIcd := 'MOVICD';
  If  SameText(strTabela, 'NOTDET') Then
    strTabMovIcd := 'NOTICD';

  strSQL := strSQL + ' LEFT JOIN ' + strTabMovIcd + ' ON  ICD_SEQGER = D.AUTOINCREM ';
  If blnAtuICS Then
  Begin

    If fCfgSis('TIPABF') = '1' Then
      strSQL := strSQL + '  INNER JOIN ABFICM B ON B.ABF_CODABF = I.ITE_CODABF AND '
    Else
      strSQL := strSQL + '  INNER JOIN ABFICM B ON B.ABF_CODABF = G.ITE_CODABF AND ';

    strSQL := strSQL + '                         B.ABF_ESTADO = ' + QuotedStr(fCadEmpDes('ESTADO', VS_strCodEmp));

  End;

  strSQL := strSQL + ' WHERE D.DET_SEQGER = :SEQGER ';
  strSQL := strSQL + ' AND DET_CODITE <> :ITESER ';
  strSQL := strSQL + ' AND DET_CODITE <> :SERTER ';
  strSQL := strSQL + ' AND G.ITE_TIPPRO <> ' + QuotedStr(TIPO_PRODUTO_SPED[9,0]) + ' ';

  With qryMovDet.qryQuery Do
  Begin
    SQL.Text := strSQL;

    ParamByName('INCPCG').AsString := strIncPcg;
    ParamByName('SEQGER').AsString := strAutIncEntradaGarantia;
    ParamByName('ITESER').AsString := fCfgSis('ITESER');
    ParamByName('SERTER').AsString := fCfgSis('SERTER');
    ParamByName('CODEMP').AsString := VS_strCodEmp;
  End;

  qryMovDet.fLeDados;
End;

{ TAtualizaPrecoEfetivacaoMovimentoFiscal }

procedure TAtualizaPrecoEfetivacaoMovimentoFiscal.pAtualizaIteger(qryGenPre: TDataSet; strEmpresas: String; blnResFor: Boolean);
var i: Integer;
Begin
  qryComand.Close;
  qryComand.SQL.Clear;
  qryComand.SQL.Text := fGetSqlUpdateITEGER( blnResFor);

  qryComand.ParamByName('PREALT').AsString  := strAgrupadorPreAlt;
  qryComand.ParamByName('PRECOM').AsFloat  := qryGenPre.FieldByName('LTP_PRECOM').AsFloat;
  qryComand.ParamByName('DESF01').AsFloat  := qryGenPre.FieldByName('LTP_DESF01').AsFloat;
  qryComand.ParamByName('DESF02').AsFloat  := qryGenPre.FieldByName('LTP_DESF02').AsFloat;
  qryComand.ParamByName('DESF03').AsFloat  := qryGenPre.FieldByName('LTP_DESF03').AsFloat;
  qryComand.ParamByName('DESF04').AsFloat  := qryGenPre.FieldByName('LTP_DESF04').AsFloat;
  qryComand.ParamByName('DESF05').AsFloat  := qryGenPre.FieldByName('LTP_DESF05').AsFloat;
  qryComand.ParamByName('DESF06').AsFloat  := qryGenPre.FieldByName('LTP_DESF06').AsFloat;
  qryComand.ParamByName('ICMENT').AsFloat  := qryGenPre.FieldByName('LTP_ICMENT').AsFloat;
  qryComand.ParamByName('SUBFED').AsFloat  := qryGenPre.FieldByName('LTP_SUBFED').AsFloat;
  qryComand.ParamByName('IPIENT').AsFloat  := qryGenPre.FieldByName('LTP_IPIENT').AsFloat;
  qryComand.ParamByName('FREENT').AsFloat  := qryGenPre.FieldByName('LTP_FREENT').AsFloat;
  qryComand.ParamByName('VALFRE').AsFloat  := qryGenPre.FieldByName('LTP_VALFRE').AsFloat;
  qryComand.ParamByName('ACRFIN').AsFloat  := qryGenPre.FieldByName('LTP_ACRFIN').AsFloat;
  qryComand.ParamByName('SUBSTI').AsFloat  := qryGenPre.FieldByName('LTP_SUBSTI').AsFloat;
  qryComand.ParamByName('DESADB').AsFloat  := qryGenPre.FieldByName('LTP_DESADB').AsFloat;
  qryComand.ParamByName('TCIFCU').AsFloat  := qryGenPre.FieldByName('LTP_TCIFCU').AsFloat;
  qryComand.ParamByName('TSCUST').AsFloat  := qryGenPre.FieldByName('LTP_TSCUST').AsFloat;
  qryComand.ParamByName('DEPICO').AsFloat  := qryGenPre.FieldByName('LTP_DEPICO').AsFloat;
  qryComand.ParamByName('DEICMS').AsFloat  := qryGenPre.FieldByName('LTP_DEICMS').AsFloat;
  qryComand.ParamByName('FATREG').AsFloat  := qryGenPre.FieldByName('LTP_FATREG').AsFloat;
  qryComand.ParamByName('PRECUS').AsFloat  := qryGenPre.FieldByName('LTP_PRECUS').AsFloat;

  If Not blnResFor Then
  Begin
    qryComand.ParamByName('OUTVAL').AsFloat  := qryGenPre.FieldByName('LTP_OUTVAL').AsFloat;
    qryComand.ParamByName('ICMSAI').AsFloat  := qryGenPre.FieldByName('LTP_ICMSAI').AsFloat;
    qryComand.ParamByName('IMPFED').AsFloat  := qryGenPre.FieldByName('LTP_IMPFED').AsFloat;
    qryComand.ParamByName('DESOPE').AsFloat  := qryGenPre.FieldByName('LTP_DESOPE').AsFloat;

    for i:=  1 To 7 do
    Begin
      qryComand.ParamByName('MARBR' + i.ToString).AsFloat  := qryGenPre.FieldByName('LTP_MARBR' + i.ToString).AsFloat;
      qryComand.ParamByName('COMTB' + i.ToString).AsFloat  := qryGenPre.FieldByName('LTP_COMTB' + i.ToString).AsFloat;
      qryComand.ParamByName('PREVE' + i.ToString).AsFloat  := qryGenPre.FieldByName('LTP_PREVE' + i.ToString).AsFloat;
    end;
  End;
  qryComand.ParamByName('CODITE').AsString := qryGenPre.FieldByName('ITE_CODITE').AsString;
  qryComand.ParamByName('CODEMP').AsString := strEmpresas;


  qryComand.ExecSQL;
  qryComand.Close;

  If blnInfMat Then
    pRecalculaItensResponsavelFornecedor(strEmpresas, qryGenPre.FieldByName('ITE_CODITE').AsString, blnResFor);


end;

function TAtualizaPrecoEfetivacaoMovimentoFiscal.fGetSqlUpdateITEGER(blnResFor: Boolean): string;
begin
    Result := Result + ' UPDATE ITEGER                                        ' +
                       '  INNER JOIN CADEMP ON EMP_CODEMP = ITEGER.ITE_CODEMP ' +
                       '  INNER JOIN CADCID ON CID_CODCID = EMP_CODCID        ' +
                       '    SET                                               ' +
                       '        ITE_PRECOM = :PRECOM,                         ' +
                       '        ITE_DESF01 = :DESF01,                         ' +
                       '        ITE_DESF02 = :DESF02,                         ' +
                       '        ITE_DESF03 = :DESF03,                         ' +
                       '        ITE_DESF04 = :DESF04,                         ' +
                       '        ITE_DESF05 = :DESF05,                         ' +
                       '        ITE_DESF06 = :DESF06,                         ' +
                       '        ITE_ICMENT = :ICMENT,                         ' +
                       '        ITE_SUBFED = :SUBFED,                         ' +
                       '        ITE_IPIENT = :IPIENT,                         ' +
                       '        ITE_FREENT = :FREENT,                         ' +
                       '        ITE_VALFRE = :VALFRE,                         ' +
                       '        ITE_ACRFIN = :ACRFIN,                         ' +
                       '        ITE_PREALT = :PREALT,                         ' +
                       '        ITE_SUBSTI = :SUBSTI,                         ' +
                       '        ITE_DESADB = :DESADB,                         ' +
                       '        ITE_TCIFCU = :TCIFCU,                         ' +
                       '        ITE_TSCUST = :TSCUST,                         ' +
                       '        ITE_DEPICO = :DEPICO,                         ' +
                       '        ITE_DEICMS = :DEICMS,                         ' +
                       '        ITE_FATREG = :FATREG,                         ' +
                       '        ITE_PRECUS = :PRECUS                          ';


    If Not blnResFor Then
    Begin
      Result := Result + ', ';

      If blnInfMat And (intInfSai = 1) Then
        Result := Result + '  ITE_ICMSAI = IF(:EMPLOG = ITE_CODEMP, :ICMSAI, ITE_ICMSAI), '
      Else
        Result := Result + '  ITE_ICMSAI = :ICMSAI, ';

      If blnInfMat And (intInfFed = 1) Then
        Result := Result + '  ITE_IMPFED = IF(:EMPLOG = ITE_CODEMP, :IMPFED, ITE_IMPFED), '
      Else
        Result := Result + '  ITE_IMPFED = :IMPFED, ';

      If blnInfMat And (intInfOpe = 1) Then
        Result := Result + '  ITE_DESOPE = IF(:EMPLOG = ITE_CODEMP, :DESOPE, ITE_DESOPE), '
      Else
        Result := Result + '  ITE_DESOPE = :DESOPE, ';

      Result := Result + '  ITE_OUTVAL = :OUTVAL, ';


      Result := Result + '  ITE_MARBR1 = :MARBR1, ' +
                         '  ITE_MARBR2 = :MARBR2, ' +
                         '  ITE_MARBR3 = :MARBR3, ' +
                         '  ITE_MARBR4 = :MARBR4, ' +
                         '  ITE_MARBR5 = :MARBR5, ' +
                         '  ITE_MARBR6 = :MARBR6, ' +
                         '  ITE_MARBR7 = :MARBR7, ' +
                         '  ITE_COMTB1 = :COMTB1, ' +
                         '  ITE_COMTB2 = :COMTB2, ' +
                         '  ITE_COMTB3 = :COMTB3, ' +
                         '  ITE_COMTB4 = :COMTB4, ' +
                         '  ITE_COMTB5 = :COMTB5, ' +
                         '  ITE_COMTB6 = :COMTB6, ' +
                         '  ITE_COMTB7 = :COMTB7, ' +
                         '  ITE_PREVE1 = :PREVE1, ' +
                         '  ITE_PREVE2 = :PREVE2, ' +
                         '  ITE_PREVE3 = :PREVE3, ' +
                         '  ITE_PREVE4 = :PREVE4, ' +
                         '  ITE_PREVE5 = :PREVE5, ' +
                         '  ITE_PREVE6 = :PREVE6, ' +
                         '  ITE_PREVE7 = :PREVE7 ';

    End;
    Result := Result + 'WHERE ITE_CODITE = :CODITE AND ';

    If blnResFor Then
      Result := Result + '  LOCATE(ITE_CODEMP, :CODEMP) = 0 '
    Else
      Result := Result + '  LOCATE(ITE_CODEMP, :CODEMP) > 0 ';
end;

function TAtualizaPrecoEfetivacaoMovimentoFiscal.fGravaPrecos(
  pgbStatus: TcxProgressBar): Boolean;
begin
  Result := True;

  strEmpresas := fRetEmpresasUsamPrecoMatriz;

  Try
    If qryLotPre.IsEmpty Then
      Exit;

    pgbStatus.Properties.max :=  qryLotPre.RecordCount -1;
    pPreAltDefineVariaveisAltPre(fNow, 'EFETIVAÇÂO DE MOVIMENTO FISCAL', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);

    while Not qryLotPre.Eof Do
    Begin
      pAtualizaIteger(qryLotPre, strEmpresas, False);

      If blnInfMat And fEhEmpresaResponsavelFornecedor(fRetFornecedorItem(qryLotPre.FieldByName('ITE_CODITE').AsString)) Then
        pAtualizaIteger(qryLotPre, strEmpresas, True);


      If (Not VS_blnPreAltViaTrigger) Then
        fGravaPreAlt(qryLotPre.FieldByName('ITE_CODITE').AsString,
                     qryLotPre.FieldByName('LTP_PRECUS_ANT').AsFloat,
                     qryLotPre.FieldByName('LTP_PRECUS').AsFloat,
                     qryLotPre.FieldByName('LTP_PREVE1_ANT').AsFloat,
                     qryLotPre.FieldByName('LTP_PREVE1').AsFloat,
                     qryLotPre.FieldByName('LTP_MARBR1_ANT').AsFloat,
                     qryLotPre.FieldByName('LTP_MARBR1').AsFloat,
                     qryLotPre.FieldByName('LTP_PREVE2_ANT').AsFloat,
                     qryLotPre.FieldByName('LTP_PREVE2').AsFloat,
                     qryLotPre.FieldByName('LTP_MARBR2_ANT').AsFloat,
                     qryLotPre.FieldByName('LTP_MARBR2').AsFloat,
                     qryLotPre.FieldByName('LTP_PREVE3_ANT').AsFloat,
                     qryLotPre.FieldByName('LTP_PREVE3').AsFloat,
                     qryLotPre.FieldByName('LTP_MARBR3_ANT').AsFloat,
                     qryLotPre.FieldByName('LTP_MARBR3').AsFloat,
                     qryLotPre.FieldByName('LTP_PREVE4_ANT').AsFloat,
                     qryLotPre.FieldByName('LTP_PREVE4').AsFloat,
                     qryLotPre.FieldByName('LTP_MARBR4_ANT').AsFloat,
                     qryLotPre.FieldByName('LTP_MARBR4').AsFloat,
                     qryLotPre.FieldByName('LTP_PREVE5_ANT').AsFloat,
                     qryLotPre.FieldByName('LTP_PREVE5').AsFloat,
                     qryLotPre.FieldByName('LTP_MARBR5_ANT').AsFloat,
                     qryLotPre.FieldByName('LTP_MARBR5').AsFloat,
                     qryLotPre.FieldByName('LTP_PREVE6_ANT').AsFloat,
                     qryLotPre.FieldByName('LTP_PREVE6').AsFloat,
                     qryLotPre.FieldByName('LTP_MARBR6_ANT').AsFloat,
                     qryLotPre.FieldByName('LTP_MARBR6').AsFloat,
                     qryLotPre.FieldByName('LTP_PREVE7_ANT').AsFloat,
                     qryLotPre.FieldByName('LTP_PREVE7').AsFloat,
                     qryLotPre.FieldByName('LTP_MARBR7_ANT').AsFloat,
                     qryLotPre.FieldByName('LTP_MARBR7').AsFloat,

                     qryLotPre.FieldByName('LTP_PRECOM_ANT').AsFloat,
                     qryLotPre.FieldByName('LTP_PRECOM').AsFloat,

                     'EFETIVAÇÂO DE MOVIMENTO FISCAL',

                     Nil,
                     '',
                     strLoginUsuarioLogado);

      pAtualizaItensGrupoPrecos(qryLotPre.FieldByName('ITE_CODITE').AsString,
                                'EFETIVAÇÂO DE MOVIMENTO FISCAL', strAgrupadorPreAlt);

      qryComand.SQL.Clear;
      qryComand.SQL.Add(' DELETE FROM LOTPRE      ');
      qryComand.SQL.Add(' WHERE                   ');
      qryComand.SQL.Add('   AUTOINCREM = :AUTINC  ');
      qryComand.ParamByName('AUTINC').AsString := qryLotPre.FieldByName('AUTOINCREM').AsString;
      qryComand.ExecSQL;


      qryLotPre.Next;
      pgbStatus.Position :=  qryLotPre.RecNo;


    End;


  Except
    on e: Exception do
    Begin
      pMensagensErro(e.message, '[TAtualizaPrecoEfetivacaoMovimentoFiscal.fEfetivaLotPre]');
      Result := False;
    End;
  End;
end;

class function TAtualizaPrecoEfetivacaoMovimentoFiscal.fEfetivaLotPre(ANumDoc,AEspDoc, ASerie, ACodFor, ACodEmp: String): Boolean;
var AtualizaPrecoEfetivacaoMovimentoFiscal : TAtualizaPrecoEfetivacaoMovimentoFiscal;
begin
  AtualizaPrecoEfetivacaoMovimentoFiscal := TAtualizaPrecoEfetivacaoMovimentoFiscal.Create;
  Try
    Result := AtualizaPrecoEfetivacaoMovimentoFiscal.fExecutaEfetivaLotPre(ANumDoc,AEspDoc, ASerie, ACodFor, ACodEmp);
  finally
    FreeAndNil(AtualizaPrecoEfetivacaoMovimentoFiscal);
  End;
end;

function TAtualizaPrecoEfetivacaoMovimentoFiscal.fExecutaEfetivaLotPre(ANumDoc,AEspDoc, ASerie, ACodFor, ACodEmp: String): Boolean;
var LfrmGravando: TfrmGravando;
begin
  Result := True;
  blnInfMat := fCfgSis('INFMAT', varBoolean);
  intInfFed := fCfgSis('INFFED', varInteger);
  intInfOpe := fCfgSis('INFOPE', varInteger);
  intInfSai := fCfgSis('INFSAI', varInteger);

  qryComand := fCriaQuery;
  ObjLotePrecos := TLotePrecos.Create(nil);
  Try
    If ObjLotePrecos.fCarregaDadosLotePreco(ANumDoc, AEspDoc, ACodEmp, ASerie, ACodFor, '') then
    begin
      If Not ObjLotePrecos.fAbreConsulta(False) Then
         Exit;
      qryLotPre := ObjLotePrecos.cdsConsulta;
      pCriarFormularios(TfrmGravando, LfrmGravando);
      Try
        LfrmGravando.lblGravando.Caption := 'Efetivando lote de preços definidos na entrada.';
        LfrmGravando.pgbStatus.Visible := False;
        LfrmGravando.fExecutarAcao := fGravaPrecos;
        LfrmGravando.ShowModal;
        Result := LfrmGravando.blnConfirma;
      Finally
        pFreeAndNil(LfrmGravando);
      End;
    end;
  Finally
    FreeAndNil(ObjLotePrecos);
    FreeAndNil(qryComand);
  End;

End;



end.
