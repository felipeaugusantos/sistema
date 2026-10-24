unit untCadRcxx;

interface

uses Uni, untTCadRcxx, Data.DB;

  procedure pRetornaUltimoFechamento(var fltUltFec: Double; var dtaDtaFec: TDateTime; strCodEmp: String = ''; strCodCaixa: String = '');
  procedure pRetornaUltimoLancamento(var dtaUltLan: TDateTime; strCodEmp: String = '');


  function fRetornaSaldoCaixa(Var dtaDtaCai: TDateTime; strCodEmp: String = ''): Double;
  function fRetornaSaldoCaixaCampo(strCampo: String; strCodEmp: String = ''; strCodOpe: String = ''; ARecebidoPorPix: Boolean = False; ARecebidoPorPixAvulso: Boolean = False; AApenasOrdemPagamento: Boolean = False):Double;

  function fGetMinAutIncRcx(intSeqCon: Integer; strCodEmp: String): String; overload;
  function fGetMinAutIncRcx(intSeqCon: Integer; strCodEmp: String; dtaDtaRef: TDateTime): String; overload;
  function fGravouCaixaCorreto(Var strMsgDif: String; const intSeqCon: Integer): Boolean;
  function fVerificaGrvCartaoCheque(Var strMsgDif: String; const intSeqCon: Integer; const strEmpRcx: String): Boolean;

  function fGetSQLTransfValores(strCodGpo: String = '';
                                strCodVen: String = '';
                                blnAgrOpe: Boolean = False): String;

  function fNecessitaFecharCaixa(blnFaturamento: Boolean; var dtaDtaLan: TDateTime; blnMostraMsg: Boolean = True; strCodEmp: String = ''; strCodCaixa: String = ''): Boolean;
  function fNecessitaFecharCaixaInterno(blnFaturamento: Boolean; var dtaDtaLan: TDateTime; var strMsgRetorno: String; blnMostraMsg: Boolean = True; strCodEmp: String = ''; strCodCaixa: String = ''): Boolean;

  function fCaixaTemMovimento(dtaDtaCai: TDateTime; qryCaixa: TUniQuery; strCodEmp: String = '';
    blnSoma: Boolean = False; dtaDtaFin: TDateTime = 0): Boolean;
  function fMovimentoFechamentoCaixa(dtaDtaCai: TDateTime; qryCaixa: TUniQuery; strCodEmp: String = ''): Boolean;
  function fVerificaSaldoMaximo(fltValor: Double; strCodOpe: String; const blnEmTransacao: Boolean = False): Boolean;

  function fRetornaDadosUltimoFechamento(strCodigoEmpresa: String): TDataset;
  function fGravaCadRcx(ARcx: TCadRcxx): Boolean; Overload;
  function fGravaCadRcx(Var strAutInc: String;
                        strCodCli,
                        strCodOpe,
                        strNumDoc,
                        strEspDoc,
                        strCodEmp: String;
                        dtaDtaCad,
                        dtaHorCad: TDateTime;
                        strNumDup,
                        strParcel,
                        strDescri,
                        strJurDes,
                        strIdeFec,
                        strForPag: String;
                        fltValDoc,
                        fltValDes,
                        fltValJur,
                        fltDinRec,
                        fltChqAvi,
                        fltChqPre,
                        fltCarRec,
                        fltOrdRec,
                        fltValCre,
                        fltValFin,
                        fltOutros,
                        fltVenPrz: Double;
                        strNumRom: String;
                        intSeqCon,
                        intSeqBai,
                        intSqFcRx: Integer;
                        strEmpDup: String;
                        strMotDes: String;
                        intIdeCai: Integer;
                        fltTotGua: Double = 0;
                        fltTotDol: Double = 0;
                        fltTotEur: Double = 0;
                        fltTotPes: Double = 0;
                        fltTotRea: Double = 0;
                        strTFCanc: String = 'N';
                        strMotEst: String = '';
                        strCodCax: String = '';
                        strNumLac: String = '';
                        fltFunCax: Double = 0.00;
                        blnFecDiv: Boolean = False;
                        fltValDiv: Double = 0.00;
                        strOpePer: String = '';
                        dtaDtaPer: TDateTime = 0;
                        strRecPix: String = 'N';
                        intSqTfOp: Integer = 0;
                        strJusPgt: String = '';
                        ARaiseException: Boolean = False;
                        strCTR_CC : String = ''): Boolean; Overload;

  procedure SomaModalidadesParaEstornoCaixa(ASeqcon: Integer;
                                            ACodigoEmpresa: String;
                                            ADataCadastro: TDateTime;
                                            var ADinheiro,
                                            ACartao,
                                            AChequeAVista,
                                            AChequePre,
                                            AOrdemPagamento: Double);

  Var
    strDocume: String;
    strDocChq: String;
    intContaReg: Integer;


implementation

uses SysUtils, Variants, untFuncoesSimples, untObjectManager,
  untTypesSistema, untLiberacaoFactory, untILiberacao, DateUtils;

function fGravaCadRcx(Var strAutInc: String;
                      strCodCli,
                      strCodOpe,
                      strNumDoc,
                      strEspDoc,
                      strCodEmp: String;
                      dtaDtaCad,
                      dtaHorCad: TDateTime;
                      strNumDup,
                      strParcel,
                      strDescri,
                      strJurDes,
                      strIdeFec,
                      strForPag: String;
                      fltValDoc,
                      fltValDes,
                      fltValJur,
                      fltDinRec,
                      fltChqAvi,
                      fltChqPre,
                      fltCarRec,
                      fltOrdRec,
                      fltValCre,
                      fltValFin,
                      fltOutros,
                      fltVenPrz: Double;
                      strNumRom: String;
                      intSeqCon,
                      intSeqBai,
                      intSqFcRx: Integer;
                      strEmpDup: String;
                      strMotDes: String;
                      intIdeCai: Integer;
                      fltTotGua: Double = 0;
                      fltTotDol: Double = 0;
                      fltTotEur: Double = 0;
                      fltTotPes: Double = 0;
                      fltTotRea: Double = 0;
                      strTFCanc: String = 'N';
                      strMotEst: String = '';
                      strCodCax: String = '';
                      strNumLac: String = '';
                      fltFunCax: Double = 0.00;
                      blnFecDiv: Boolean = False;
                      fltValDiv: Double = 0.00;
                      strOpePer: String = '';
                      dtaDtaPer: TDateTime = 0;
                      strRecPix: String = 'N';
                      intSqTfOp: Integer = 0;
                      strJusPgt: String = '';
                      ARaiseException: Boolean = False;
                      strCTR_CC : String = ''): Boolean;
  Var
    qryCadRcxX: TUniQuery;
begin

  Try
    strAutInc := fRetAutoIncrem('CADRCXX', strCodEmp);

    qryCadRcxX := fCriarQuery('SELECT * FROM CADRCXX WHERE FALSE');
    qryCadRcxX.Open;
    qryCadRcxX.Insert;

    If fEmptyStr(strCodCli) Then
      qryCadRcxX.FieldByName('RCX_CODCLI').Value := Null
    Else
      qryCadRcxX.FieldByName('RCX_CODCLI').AsString := strCodCli;

    If fEmptyStr(strCodOpe) Then
      qryCadRcxX.FieldByName('RCX_CODOPE').Value := Null
    Else
      qryCadRcxX.FieldByName('RCX_CODOPE').AsString := strCodOpe;

    qryCadRcxX.FieldByName('RCX_NUMDOC').AsString   := strNumDoc;
    qryCadRcxX.FieldByName('RCX_ESPDOC').AsString   := strEspDoc;
    qryCadRcxX.FieldByName('RCX_CODEMP').AsString   := strCodEmp;

    If dtaDtaCad = 0 Then
      qryCadRcxX.FieldByName('RCX_DTACAD').AsDateTime := VS_Date
    Else
      qryCadRcxX.FieldByName('RCX_DTACAD').AsDateTime := dtaDtaCad;

    qryCadRcxX.FieldByName('RCX_HORCAD').AsDateTime := dtaHorCad;

    If fEmptyStr(strNumDup) Then
      qryCadRcxX.FieldByName('RCX_NUMDUP').Value := Null
    Else
      qryCadRcxX.FieldByName('RCX_NUMDUP').AsString := strNumDup;

    qryCadRcxX.FieldByName('RCX_PARCEL').AsString   := strParcel;
    qryCadRcxX.FieldByName('RCX_DESCRI').AsString   := strDescri;
    qryCadRcxX.FieldByName('RCX_JURDES').AsString   := strJurDes;
    qryCadRcxX.FieldByName('RCX_IDEFEC').AsString   := strIdeFec;

    If fEmptyStr(strForPag) Then
      qryCadRcxX.FieldByName('RCX_CODFPG').Value := Null
    Else
      qryCadRcxX.FieldByName('RCX_CODFPG').Value := strForPag;

    qryCadRcxX.FieldByName('RCX_VALDOC').AsFloat    := fltValDoc;
    qryCadRcxX.FieldByName('RCX_VALDES').AsFloat    := fltValDes;
    qryCadRcxX.FieldByName('RCX_VALJUR').AsFloat    := fltValJur;
    qryCadRcxX.FieldByName('RCX_DINREC').AsFloat    := fltDinRec;
    qryCadRcxX.FieldByName('RCX_CHQAVI').AsFloat    := fltChqAvi;
    qryCadRcxX.FieldByName('RCX_CHQPRE').AsFloat    := fltChqPre;
    qryCadRcxX.FieldByName('RCX_CARREC').AsFloat    := fltCarRec;
    qryCadRcxX.FieldByName('RCX_ORDREC').AsFloat    := fltOrdRec;
    qryCadRcxX.FieldByName('RCX_VALCRE').AsFloat    := fltValCre;
    qryCadRcxX.FieldByName('RCX_VALFIN').AsFloat    := fltValFin;
    qryCadRcxX.FieldByName('RCX_OUTROS').AsFloat    := fltOutros;
    qryCadRcxX.FieldByName('RCX_VENPRZ').AsFloat    := fltVenPrz;
    qryCadRcxX.FieldByName('AUTOINCREM').AsString   := strAutInc;

    If fEmptyStr(strNumRom) Then
      qryCadRcxX.FieldByName('RCX_NUMROM').Value := Null
    Else
      qryCadRcxX.FieldByName('RCX_NUMROM').Value := strNumRom;

    qryCadRcxX.FieldByName('RCX_SEQCON').AsInteger  := intSeqCon;
    qryCadRcxX.FieldByName('RCX_SEQBAI').AsInteger  := intSeqBai;
    qryCadRcxX.FieldByName('RCX_RCXTCC').AsString := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_RCXTCC', VS_strCodEmp]);
    qryCadRcxX.FieldByName('RCX_SQFCRX').AsInteger  := intSqFcRx;
    qryCadRcxX.FieldByName('RCX_MOTDES').AsString   := strMotDes;

    If fEmptyStr(strEmpDup) Then
      qryCadRcxX.FieldByName('RCX_EMPDUP').Value := Null
    Else
      qryCadRcxX.FieldByName('RCX_EMPDUP').AsString := strEmpDup;

    qryCadRcxX.FieldByName('RCX_IDECAI').AsString := IntToStr(intIdeCai);

    qryCadRcxX.FieldByName('RCX_TOTGUA').AsFloat    := fltTotGua;
    qryCadRcxX.FieldByName('RCX_TOTDOL').AsFloat    := fltTotDol;
    qryCadRcxX.FieldByName('RCX_TOTEUR').AsFloat    := fltTotEur;
    qryCadRcxX.FieldByName('RCX_TOTPES').AsFloat    := fltTotPes;
    qryCadRcxX.FieldByName('RCX_TOTREA').AsFloat    := fltTotRea;

    qryCadRcxX.FieldByName('RCX_TFCANC').AsString := strTFCanc;

    qryCadRcxX.FieldByName('RCX_DTAGRV').AsDateTime := fCampoTabela('CURRENT_TIMESTAMP',
                                                                    'DUAL', [], []);
    If strEspDoc = 'FC' Then
      qryCadRcxX.FieldByName('RCX_DTAGRV').AsDateTime := IncSecond(qryCadRcxX.FieldByName('RCX_DTAGRV').AsDateTime, 2);

    qryCadRcxX.FieldByName('RCX_CODCAX').Value := Null;
    If Not strCodCax.IsEmpty Then
      qryCadRcxX.FieldByName('RCX_CODCAX').AsString := strCodCax;

    qryCadRcxX.FieldByName('RCX_NUMLAC').Value := Null;
    If Not strNumLac.IsEmpty Then
      qryCadRcxX.FieldByName('RCX_NUMLAC').AsString := strNumLac;

    qryCadRcxX.FieldByName('RCX_OPEPER').Value := Null;
    If Not strOpePer.IsEmpty Then
      qryCadRcxX.FieldByName('RCX_OPEPER').AsString := strOpePer;

    qryCadRcxX.FieldByName('RCX_FECDIV').AsString := 'N';
    If blnFecDiv Then
      qryCadRcxX.FieldByName('RCX_FECDIV').AsString := 'S';

    qryCadRcxX.FieldByName('RCX_FUNCAX').AsFloat := fltFunCax;
    qryCadRcxX.FieldByName('RCX_VALDIV').AsFloat := fltValDiv;

    qryCadRcxX.FieldByName('RCX_DTAPER').Value := Null;
    If dtaDtaPer <> 0 Then
      qryCadRcxX.FieldByName('RCX_DTAPER').AsDateTime := dtaDtaPer;

    if strMotEst <> '' then
      qryCadRcxX.FieldByName('RCX_MOTEST').AsString := strMotEst;

    qryCadRcxX.FieldByName('RCX_RECPIX').AsString := 'N';
    If Not strRecPix.IsEmpty Then
      qryCadRcxX.FieldByName('RCX_RECPIX').AsString := strRecPix;

    qryCadRcxX.FieldByName('RCX_SQTFOP').Value := Null;
    If intSqTfOp <> 0 Then
      qryCadRcxX.FieldByName('RCX_SQTFOP').AsInteger := intSqTfOp;

    qryCadRcxX.FieldByName('RCX_JUSPGT').AsString := strJusPgt;

    If fEmptyStr(strCTR_CC) Then
      qryCadRcxX.FieldByName('RCX_CTR_CC').Value := Null
    Else
      qryCadRcxX.FieldByName('RCX_CTR_CC').AsString := strCTR_CC;

    qryCadRcxX.Post;
    Result := True;

    If intContaReg > 1 Then
    Begin
      strDocume := 'DIVERSOS';
      strDocChq := 'DIVERSOS-';
    End
    Else
    Begin
      strDocChq := fStrZero(strNumDoc, 12) + strParcel + strEspDoc + IIF(fEmptyStr(strEmpDup), strCodEmp, strEmpDup);

      If fEmptyStr(strParcel) Then
        strParcel := ' ';
      strDocume := fStrZero(strNumDoc, 12) + '-' + strParcel + '-' + strEspDoc + '-' + IIF(fEmptyStr(strEmpDup), strCodEmp, strEmpDup);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      If Assigned(qryCadRcxX) And (qryCadRcxX.State in [dsInsert, dsEdit]) Then
        qryCadRcxX.Cancel;

      If Not ARaiseException Then
        pMensagensErro(E.Message, '[fGravaResCai]')
      Else
        Raise Exception.Create(E.Message + ' - [fGravaResCai]');
    End;
  End;

  FreeAndNil(qryCadRcxX);

end;

function fVerificaSaldoMaximo(fltValor: Double; strCodOpe: String; const blnEmTransacao: Boolean = False): Boolean;
  Var
    fltValConfig : Double;
    fltSaldo     : Double;
    objLiberacao : ILiberacao;
begin
  objLiberacao := TLiberacaoFactory.fGetLiberacao();

  fltValConfig := fFormataFloat(fCfgSis('RCXSDM', varDouble), 2);

  If (fltValConfig <> 0) Then
    fltValConfig := fFormataFloat(fCfgSisL('RCXSDM', varDouble), 2);

  Result := True;

  If (fltValConfig > 0) And (fltValor > 0) Then
  Begin
    fltSaldo := fRetornaSaldoCaixaCampo('RCX_DINREC', '', strCodOpe);
    If (fFormataFloat(fltSaldo + fltValor, 2) > fltValConfig) Then
    Begin
      If (blnEmTransacao) Then
        fRollback;

      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Liberar saldo maior que o permitido nas configurações');
      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddTexto('Com esta operação de R$ ' + FormatFloat('#,##0.00', fltValor) + ' em DINHEIRO,');
      objLiberacao.objMsgLibera.pAddTexto('o caixa do operador ' + strCodOpe + ' - ' + fRetNomeOperador(strCodOpe));
      objLiberacao.objMsgLibera.pAddTexto('irá ultrapassar o valor máximo permitido de R$ ' + FormatFloat('#,##0.00', fltValConfig));

      If (blnEmTransacao) Then
      Begin
        objLiberacao.objMsgLibera.pAddQuebra;
        objLiberacao.objMsgLibera.pAddTexto('*** Será necessário liberar o limite na configuração: CFG_RCXSDM. ***');
        objLiberacao.blnTratel := False;
      End
      Else
        objLiberacao.objMsgLibera.pAddTexto('Será necessário senha de liberação para prosseguir.');

      objLiberacao.strDirAce := 'DIRRCXSALDOMAIORQUEPERMITIDO';
      objLiberacao.strMsgSen := 'Lançamento no caixa  - Saldo maior que o máximo permitido';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := strCodOpe;
      objLiberacao.strCodDig := strCodOpe;

      If (blnEmTransacao) Then
      Begin
        objLiberacao.fLibera;
        Result := False;
      End
      Else
        Result := objLiberacao.fLibera;
    End;
  End;
end;

function fGravaCadRcx(ARcx: TCadRcxx): Boolean;
  Var
    blnCriouObj: Boolean;
begin

  frwk := fCriaObjManager(blnCriouObj);
  Try
    ARcx.strAutInc := fRetAutoIncrem('CADRCXX', ARcx.strCodEmp);
    ARcx.strRcxTcc := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_RCXTCC', VS_strCodEmp]);
    frwk.objDBManager.Save(ARcx);

    If intContaReg > 1 Then
    Begin
      strDocume := 'DIVERSOS';
      strDocChq := 'DIVERSOS-';
    End
    Else
    Begin
      strDocChq := fStrZero(ARcx.strNumDoc, 12) + fValN(ARcx.strParcel) + fValN(ARcx.strEspDoc) +
                   IIF(ARcx.strEmpDup.HasValue, ARcx.strCodEmp, fValN(ARcx.strEmpDup));

      strDocume := fStrZero(ARcx.strNumDoc, 12) + '-' + IIF(ARcx.strParcel.HasValue,' ', fValN(ARcx.strParcel)) + '-' +
                   fValN(ARcx.strEspDoc) + '-' + IIF(ARcx.strEmpDup.HasValue, ARcx.strCodEmp, fValN(ARcx.strEmpDup));
    End;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaResCai]');
    End;
  End;

  If blnCriouObj Then FreeAndNil(frwk);

end;

function fNecessitaFecharCaixa(blnFaturamento: Boolean; var dtaDtaLan: TDateTime; blnMostraMsg: Boolean = True; strCodEmp: String = ''; strCodCaixa: String = ''): Boolean;
var
  strMsgRet: String;
Begin
  Result := fNecessitaFecharCaixaInterno(blnFaturamento, dtaDtaLan, strMsgRet, blnMostraMsg, strCodEmp, strCodCaixa);
End;

function fNecessitaFecharCaixaInterno(blnFaturamento: Boolean; var dtaDtaLan: TDateTime; var strMsgRetorno: String;
  blnMostraMsg: Boolean = True; strCodEmp: String = ''; strCodCaixa: String = ''): Boolean;
  Var
    dtaUltFec: TDateTime;
    dtaUltLan: TDateTime;
    fltUltFec: Double;
    strSQL   : String;
    qryGenRcx: TUniQuery;
begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  Result    := True;
  dtaDtaLan := VS_Date;
  dtaUltLan := 0;

  If Not fCfgSis('USARCX', varBoolean, strCodEmp) Then
    Exit;

  qryGenRcx := fCriaQuery;

  {**********************************************}
  {* NO DIA SEGUINTE, CASO O CAIXA NÃO TENHA    *}
  {* SIDO FECHADO, AVISA QUE O CAIXA ANTERIOR   *}
  {* NÃO FOI FECHADO E QUE TODOS OS LANÇAMENTOS *}
  {* EFETUADOS SERÃO GRAVADOS COM A DATA QUE    *}
  {* DEVERIA SER FEITO O FECHAMENTO             *}
  {*******************************************MV*}
  pRetornaUltimoFechamento(fltUltFec, dtaUltFec, strCodEmp, strCodCaixa);

  {*******************************************}
  {* SE NÃO HOUVER FECHAMENTO, EGA A ÚLTIMA  *}
  {* DATA PARA EFETUAR OS NOVOS LANÇAMENTOS  *}
  {****************************************MV*}
  If (dtaUltFec = 0) Then
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  MAX(RCX_DTACAD) AS ULTDTA ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADRCXX ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  RCX_CODEMP = :CODEMP ';
    If (Not fEmptyStr(strCodCaixa)) Then
      strSQL := strSQL + '  AND RCX_CODCAX = :CODCAX  ';


    With qryGenRcx Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;

      If (Not fEmptyStr(strCodCaixa)) Then
        ParamByName('CODCAX').AsString := strCodCaixa;

      Open;
      If (Not FieldByName('ULTDTA').IsNull) Then
        dtaDtaLan := FieldByName('ULTDTA').AsDateTime;
      Close;
    End;

  End
  {*******************************************}
  {* SE EXISTIR ALGUM FECHAMENTO, VERIFICA   *}
  {* SE A DATA DO FECHAMENTO É INFERIOR DA   *}
  {* ÚLTIMA DATA DE LANÇAMENTO DOS DOCS      *}
  {****************************************MV*}
  Else
  Begin
    dtaUltLan := VS_Date;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  MAX(RCX_DTACAD) AS ULTDTA ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADRCXX ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  RCX_CODEMP = :CODEMP ';

    If (Not fEmptyStr(strCodCaixa)) Then
      strSQL := strSQL + '  AND RCX_CODCAX = :CODCAX  ';

    With qryGenRcx Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;

      If (Not fEmptyStr(strCodCaixa)) Then
        ParamByName('CODCAX').AsString := strCodCaixa;

      Open;
      If (Not FieldByName('ULTDTA').IsNull) Then
        dtaUltLan := FieldByName('ULTDTA').AsDateTime;
      Close;
    End;

  End;

  If (dtaUltFec < dtaUltLan) Then
    dtaDtaLan := dtaUltLan;
  
  Result := (dtaDtaLan >= VS_Date);

  If (Not Result) Then
  Begin
    If (blnFaturamento) Then
    Begin
      strMsgRetorno := 'O caixa do dia ' + DateToStr(dtaDtaLan) + ' ainda não foi fechado!';
    End
    Else
    Begin
      strMsgRetorno := 'O caixa do dia ' + DateToStr(dtaDtaLan) + ' ainda não foi fechado,' + #13#10 +
                       'por isso, todos os lançamentos efetuados serão gravados com a data acima!';
    End;
  End;

  If blnMostraMsg And (Not Result) Then
  Begin
    fMensagem('', strMsgRetorno, ['&Ok']);
  End;

  FreeAndNil(qryGenRcx);

end;

function fCaixaTemMovimento(dtaDtaCai: TDateTime; qryCaixa: TUniQuery; strCodEmp: String = '';
  blnSoma: Boolean = False; dtaDtaFin: TDateTime = 0): Boolean;
  Var
    strSQL: String;
    blnAssigned: Boolean;
begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';

  If Not blnSoma Then
    strSQL := strSQL + '  * '
  Else
  Begin
    strSQL := strSQL + ' SUM(RCX_DINREC) AS RCX_DINREC, ';
    strSQL := strSQL + ' SUM(RCX_CHQAVI) AS RCX_CHQAVI, ';
    strSQL := strSQL + ' SUM(RCX_CHQPRE) AS RCX_CHQPRE, ';
    strSQL := strSQL + ' SUM(RCX_CARREC) AS RCX_CARREC, ';
    strSQL := strSQL + ' SUM(RCX_ORDREC) AS RCX_ORDREC, ';
    strSQL := strSQL + ' SUM(RCX_VALFIN) AS RCX_VALFIN  ';
  End;

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADRCXX ';
  strSQL := strSQL + 'WHERE ';

  If blnSoma Then
    strSQL := strSQL + '  RCX_DTACAD BETWEEN :DTAINI AND :DTAFIN AND '
  Else
    strSQL := strSQL + '  RCX_DTACAD >= :DTACAD AND ';

  strSQL := strSQL + '  RCX_CODEMP = :CODEMP '; //AND ';
  //strSQL := strSQL + '  ( RCX_VENPRZ <= 0 OR ( RCX_VENPRZ > 0 AND RCX_DINREC+RCX_CHQAVI+RCX_CHQPRE+RCX_CARREC+RCX_ORDREC+ABS(RCX_VALCRE)+RCX_VALFIN <> 0 )) ';

  If blnSoma Then
  Begin
    strSQL := strSQL + ' AND RCX_ESPDOC <> "FC" ';
    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  RCX_CODEMP ';
  End
  Else
  Begin
    strSQL := strSQL + 'ORDER BY ';
    strSQL := strSQL + '  RCX_DTACAD, RCX_ESPDOC, RCX_NUMDOC ';
  End;

  blnAssigned := Assigned(qryCaixa);

  If Not blnAssigned Then
    qryCaixa := fCriaQuery;

  With qryCaixa Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If blnSoma Then
    Begin
      ParamByName('DTAINI').AsDateTime := dtaDtaCai;
      ParamByName('DTAFIN').AsDateTime := dtaDtaFin;
    End
    Else
      ParamByName('DTACAD').AsDateTime := dtaDtaCai;

    ParamByName('CODEMP').AsString   := strCodEmp;
    Open;

    Result := Not IsEmpty;
  End;

  If Not blnAssigned Then
    FreeAndNil(qryCaixa);
end;

function fMovimentoFechamentoCaixa(dtaDtaCai: TDateTime; qryCaixa: TUniQuery; strCodEmp: String = ''): Boolean;
  Var
    strSQL     : String;
    dteDtaFec  : TDateTime;
    blnAssigned: Boolean;

  function fBuscarDataUltFechamento: TDateTime;
    Var
      qryTemp: TUniQuery;
  begin
    Result := 0;

    Try
      qryTemp := fCriaQuery;

      Try
        qryTemp.Close();
        qryTemp.SQL.Clear();
        qryTemp.SQL.Text := 'SELECT ' +
                            '  MAX(RCX_DTACAD) AS DTAFEC ' +
                            'FROM ' +
                            '  CADRCXX ' +
                            'WHERE RCX_DTACAD < :DTACAD ' +
                            '  AND RCX_CODEMP = :CODEMP ' +
                            '  AND RCX_ESPDOC = "FC" ' +
                            '  AND ( ' +
                            '    RCX_VENPRZ <= 0 ' +
                            '    OR ( ' +
                            '      RCX_VENPRZ > 0 ' +
                            '      AND RCX_DINREC + RCX_CHQAVI + RCX_CHQPRE + RCX_CARREC + RCX_ORDREC + ABS(RCX_VALCRE) <> 0 ' +
                            '    ) ' +
                            '  ) ';
        qryTemp.ParamByName('DTACAD').AsDateTime := dtaDtaCai;
        qryTemp.ParamByName('CODEMP').AsString   := strCodEmp;
        qryTemp.Open();

        Result := qryTemp.FieldByName('DTAFEC').AsDateTime;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[fMovimentoFechamentoCaixa.fBuscarDataUltFechamento]');
      End;
    Finally
      FreeAndNil(qryTemp);
    End;
  end;
begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + ' RCX_DINREC AS RCX_DINREC, ';
  strSQL := strSQL + ' RCX_CHQAVI AS RCX_CHQAVI, ';
  strSQL := strSQL + ' RCX_CHQPRE AS RCX_CHQPRE, ';
  strSQL := strSQL + ' RCX_CARREC AS RCX_CARREC, ';
  strSQL := strSQL + ' RCX_ORDREC AS RCX_ORDREC, ';
  strSQL := strSQL + ' RCX_VALFIN AS RCX_VALFIN  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADRCXX ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  RCX_DTACAD = :DTAFEC AND ';
  strSQL := strSQL + '  RCX_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  ( RCX_VENPRZ <= 0 OR ( RCX_VENPRZ > 0 AND RCX_DINREC+RCX_CHQAVI+RCX_CHQPRE+RCX_CARREC+RCX_ORDREC+ABS(RCX_VALCRE) <> 0 )) ';
  strSQL := strSQL + ' AND RCX_ESPDOC = "FC" ';
  strSQL := strSQL + 'GROUP BY ';
  strSQL := strSQL + '  RCX_CODEMP ';

  blnAssigned := Assigned(qryCaixa);

  dteDtaFec := fBuscarDataUltFechamento();

  If (dteDtaFec > 0) Then Begin

    If Not blnAssigned Then
      qryCaixa := fCriaQuery;

    With qryCaixa Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('DTAFEC').AsDateTime := dteDtaFec;
      ParamByName('CODEMP').AsString   := strCodEmp;

      Open;

      Result := Not IsEmpty;
    End;

  End Else Begin
    Result := False;
  End;

  If Not blnAssigned Then
    FreeAndNil(qryCaixa);
end;

procedure pRetornaUltimoFechamento(Var fltUltFec: Double; Var dtaDtaFec: TDateTime; strCodEmp: String = ''; strCodCaixa: String = '');
  Var
    strSQL   : String;
    qryGenRcx: TUniQuery;
begin

  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  Try
    qryGenRcx := fCriaQuery;

    fltUltFec := 0.0;
    dtaDtaFec := 0;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  RCX_ESPDOC, ';
    strSQL := strSQL + '  RCX_VALDOC, ';
    strSQL := strSQL + '  RCX_DTACAD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADRCXX ';
    strSQL := strSQL + 'WHERE RCX_CODEMP = :CODEMP ';
    strSQL := strSQL + '  AND RCX_IDEFEC = "X" ';
    If (Not fEmptyStr(strCodCaixa)) Then
      strSQL := strSQL + '  AND RCX_CODCAX = :CODCAX  ';

    strSQL := strSQL + 'ORDER BY ';
    strSQL := strSQL + '  RCX_IDEFEC DESC, RCX_DTACAD DESC ';
    strSQL := strSQL + 'LIMIT 1 ';

    With qryGenRcx Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;

      If (Not fEmptyStr(strCodCaixa)) Then
        ParamByName('CODCAX').AsString := strCodCaixa;

      Open;
      If (Not IsEmpty) Then
      Begin
        If (FieldByName('RCX_ESPDOC').AsString = 'FC') Then
        Begin
          fltUltFec := FieldByName('RCX_VALDOC').AsFloat;
          dtaDtaFec := FieldByName('RCX_DTACAD').AsDateTime;
        End;
      End;
      Close;
    End;

  Finally
    FreeAndNil(qryGenRcx);
  End;

end;

procedure pRetornaUltimoLancamento(var dtaUltLan: TDateTime; strCodEmp: String = '');
Var
  strSQL    : String;
  qryGenRcx : TUniQuery;
begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  qryGenRcx := fCriaQuery;
  Try
    dtaUltLan := 0;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  MAX(RCX_DTACAD) AS ULTDTA ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADRCXX ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  RCX_CODEMP = :CODEMP ';

    qryGenRcx.Close;
    qryGenRcx.SQL.Text := strSQL;
    qryGenRcx.ParamByName('CODEMP').AsString := strCodEmp;
    qryGenRcx.Open;

    If (Not qryGenRcx.FieldByName('ULTDTA').IsNull) Then
      dtaUltLan := qryGenRcx.FieldByName('ULTDTA').AsDateTime;

    qryGenRcx.Close;
  Finally
    FreeAndNil(qryGenRcx);
  End;
end;

function fRetornaSaldoCaixa(Var dtaDtaCai: TDateTime; strCodEmp: String = ''): Double;
  Var
    fltSalFec: Double;
    dtaDtaFec: TDateTime;
    qryGenRcx: TUniQuery;
begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  qryGenRcx := fCriaQuery(nil);

  pRetornaUltimoFechamento(fltSalFec, dtaDtaFec, strCodEmp);
  fNecessitaFecharCaixa(False, dtaDtaCai, False, strCodEmp);

  If (dtaDtaFec <> dtaDtaCai) And fCaixaTemMovimento(dtaDtaFec+1, qryGenRcx, strCodEmp) Then
  Begin
    While (Not qryGenRcx.Eof) Do
    Begin
      fltSalFec := fltSalFec + qryGenRcx.FieldByName('RCX_VALDOC').AsFloat;
      qryGenRcx.Next;
    End;
    qryGenRcx.Close;
  End;

  Result := fltSalFec;

  FreeAndNil(qryGenRcx);
end;

function fRetornaSaldoCaixaCampo(strCampo: String; strCodEmp: String = ''; strCodOpe: String = ''; ARecebidoPorPix: Boolean = False;  ARecebidoPorPixAvulso: Boolean = False; AApenasOrdemPagamento: Boolean = False): Double;
var
  qrySaldo: TUniQuery;
  dteUltFech: TDateTime;
  fltSaldo: Double;
  strSQL: String;
  strOpeFech: String;
begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  qrySaldo := fCriaQuery(nil);
  try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ' + strCampo + ', ';
    strSQL := strSQL + '  RCX_DTACAD, ';
    strSQL := strSQL + '  RCX_CODOPE  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADRCXX ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  RCX_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  RCX_IDEFEC = ''X'' ';
    strSQL := strSQL + 'ORDER BY ';
    strSQL := strSQL + '  RCX_IDEFEC DESC, RCX_DTACAD DESC ';
    strSQL := strSQL + 'LIMIT 1 ';

    qrySaldo.SQL.Clear;
    qrySaldo.SQL.Add(strSQL);
    qrySaldo.ParamByName('CODEMP').AsString := strCodEmp;
    qrySaldo.Open;

    dteUltFech := qrySaldo.FieldByName('RCX_DTACAD').AsDateTime;
    fltSaldo   := qrySaldo.FieldByName(strCampo).AsFloat;
    strOpeFech := qrySaldo.FieldByName('RCX_CODOPE').AsString;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  SUM(' + strCampo + ') AS TOTLAN ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADRCXX ';
    strSQL := strSQL + 'WHERE RCX_DTACAD > :DTACAD ';
    strSQL := strSQL + '  AND RCX_CODEMP = :CODEMP ';
    strSQL := strSQL + '  AND ' + strCampo + ' <> 0 ';
    If Not fEmptyStr(strCodOpe) Then
      strSQL := strSQL + '  AND RCX_CODOPE = :CODOPE ';

    If ARecebidoPorPix Then
    Begin
      If ARecebidoPorPixAvulso Then
        strSQL := strSQL + '  AND (RCX_RECPIX="S") '
      Else
        strSQL := strSQL + '  AND NOT (RCX_ESPDOC="TF" AND RCX_RECPIX="S") ';
    End
    Else If AApenasOrdemPagamento Then
      strSQL := strSQL + '  AND (RCX_RECPIX="N") ';

    qrySaldo.Close;
    qrySaldo.SQL.Clear;
    qrySaldo.SQL.Add(strSQL);
    qrySaldo.ParamByName('DTACAD').AsDateTime := dteUltFech;
    qrySaldo.ParamByName('CODEMP').AsString   := strCodEmp;
    If Not fEmptyStr(strCodOpe) Then
      qrySaldo.ParamByName('CODOPE').AsString   := strCodOpe;
    qrySaldo.Open;

    If (fEmptyStr(strCodOpe) Or (strCodOpe = strOpeFech)) And
       (Not (ARecebidoPorPix And ARecebidoPorPixAvulso))  Then
      fltSaldo  := fltSaldo + qrySaldo.FieldByName('TOTLAN').AsFloat
    Else
      fltSaldo  := qrySaldo.FieldByName('TOTLAN').AsFloat;

    Result := fltSaldo;
  finally
    FreeAndNil(qrySaldo);
  end;
end;

function fGetMinAutIncRcx(intSeqCon: Integer; strCodEmp: String): String;
  Var
    qryGen : TUniQuery;
    strBase: String;
    strMods1: String;
    strMods2: String;
    strEsp : String;

  procedure pAbreQuery(strSQL:String);
  begin
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ParamByName('CODEMP').AsString  := strCodEmp;
    qryGen.ParamByName('SEQCON').AsInteger := intSeqCon;
    qryGen.Open;
  end;
Begin
  qryGen := fCriaQuery;

  strBase := '';
  strBase := strBase + '  SELECT MIN(AUTOINCREM) AS MININC FROM CADRCXX  ';
  strBase := strBase + '  WHERE RCX_SEQCON = :SEQCON AND RCX_CODEMP = :CODEMP  ';

  //PARA PEGAR OP PRIMEIRO DOCUMENTO QUE POSSUA AO MENOS UMA MODALIDADE DE PAGAMENTO
  strMods1 := '';
  strMods1 := strMods1 + '  AND (                    ';
  strMods1 := strMods1 + '    (RCX_DINREC <> 0) OR   ';
  strMods1 := strMods1 + '    (RCX_CHQAVI <> 0) OR   ';
  strMods1 := strMods1 + '    (RCX_CHQPRE <> 0) OR   ';
  strMods1 := strMods1 + '    (RCX_CARREC <> 0) OR   ';
  strMods1 := strMods1 + '    (RCX_ORDREC <> 0) OR   ';
  strMods1 := strMods1 + '    (RCX_VALFIN <> 0)      ';
  strMods1 := strMods1 + '    )                      ';

  strMods2 := '';
  strMods2 := strMods2 + '  AND (                    ';
  strMods2 := strMods2 + '    (RCX_DINREC <> 0) OR   ';
  strMods2 := strMods2 + '    (RCX_CHQAVI <> 0) OR   ';
  strMods2 := strMods2 + '    (RCX_CHQPRE <> 0) OR   ';
  strMods2 := strMods2 + '    (RCX_CARREC <> 0) OR   ';
  strMods2 := strMods2 + '    (RCX_ORDREC <> 0) OR   ';
  strMods2 := strMods2 + '    (RCX_VALFIN <> 0) OR   ';
  strMods2 := strMods2 + '    (RCX_VALCRE <> 0)      ';
  strMods2 := strMods2 + '    )                      ';

  strEsp := '  AND RCX_ESPDOC <> "CC"  ';

  pAbreQuery(strBase + strMods1 + strEsp);

  If fEmptyStr(qryGen.FieldByName('MININC').AsString) Then
    pAbreQuery(strBase + strMods2 + strEsp);

  If fEmptyStr(qryGen.FieldByName('MININC').AsString) Then
    pAbreQuery(strBase + strMods1);

  Result := qryGen.FieldByName('MININC').AsString;

  qryGen.Close;

  FreeAndNil(qryGen);
End;

function fGetMinAutIncRcx(intSeqCon: Integer; strCodEmp: String; dtaDtaRef: TDateTime): String;
  Var
    qryGen : TUniQuery;
    strBase: String;
    strMods1: String;
    strMods2: String;
    strEsp: String;

  procedure pAbreQuery(strSQL:String);
  begin
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ParamByName('CODEMP').AsString  := strCodEmp;
    qryGen.ParamByName('SEQCON').AsInteger := intSeqCon;
    qryGen.ParamByName('DTAREF').AsDateTime := dtaDtaRef;
    qryGen.Open;
  end;
Begin
  qryGen := fCriaQuery;

  strBase := '';
  strBase := strBase + '  SELECT MIN(AUTOINCREM) AS MININC FROM CADRCXX  ';
  strBase := strBase + '  WHERE RCX_SEQCON = :SEQCON AND RCX_CODEMP = :CODEMP  ';

  If fCfgSis('TPFCCX') <> 'C' Then
    strBase := strBase + '  AND RCX_DTACAD > :DTAREF  '
  Else
  Begin
    strBase := strBase + '  AND RCX_DTACAD >= :DTAREF  ';
    strBase := strBase + '  AND RCX_LANFEC = "N"       ';
  End;

  strMods1 := '';
  strMods1 := strMods1 + '  AND (                    ';
  strMods1 := strMods1 + '    (RCX_DINREC <> 0) OR   ';
  strMods1 := strMods1 + '    (RCX_CHQAVI <> 0) OR   ';
  strMods1 := strMods1 + '    (RCX_CHQPRE <> 0) OR   ';
  strMods1 := strMods1 + '    (RCX_CARREC <> 0) OR   ';
  strMods1 := strMods1 + '    (RCX_ORDREC <> 0) OR   ';
  strMods1 := strMods1 + '    (RCX_VALFIN <> 0)      ';
  strMods1 := strMods1 + '    )                      ';

  strMods2 := '';
  strMods2 := strMods2 + '  AND (                    ';
  strMods2 := strMods2 + '    (RCX_DINREC <> 0) OR   ';
  strMods2 := strMods2 + '    (RCX_CHQAVI <> 0) OR   ';
  strMods2 := strMods2 + '    (RCX_CHQPRE <> 0) OR   ';
  strMods2 := strMods2 + '    (RCX_CARREC <> 0) OR   ';
  strMods2 := strMods2 + '    (RCX_ORDREC <> 0) OR   ';
  strMods2 := strMods2 + '    (RCX_VALFIN <> 0) OR   ';
  strMods2 := strMods2 + '    (RCX_VALCRE <> 0)      ';
  strMods2 := strMods2 + '    )                      ';

  strEsp := '  AND RCX_ESPDOC <> "CC"  ';

  pAbreQuery(strBase + strMods1 + strEsp);

  If fEmptyStr(qryGen.FieldByName('MININC').AsString) Then
    pAbreQuery(strBase + strMods2 + strEsp);

  If fEmptyStr(qryGen.FieldByName('MININC').AsString) Then
    pAbreQuery(strBase + strMods1);

  Result := qryGen.FieldByName('MININC').AsString;

  qryGen.Close;

  FreeAndNil(qryGen);
End;

function fGravouCaixaCorreto(Var strMsgDif: String; const intSeqCon: Integer): Boolean;
  Var
    strSQL   : String;
    qryGenRcx: TUniQuery;

begin
  Try
    qryGenRcx := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(AUTOINCREM) AS QTDREGISTRO, ';
    strSQL := strSQL + '  SUM(RCX_VALDOC) AS VALDOC, ';
    strSQL := strSQL + '  SUM(RCX_DINREC + RCX_CARREC + RCX_CHQAVI + RCX_CHQPRE + RCX_ORDREC + IFNULL(RCX_VALFIN, 0)) AS VALMOD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADRCXX ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  RCX_SEQCON = :SEQCON AND ';
    strSQL := strSQL + '  RCX_CODEMP = :CODEMP ';

    qryGenRcx.Close;
    qryGenRcx.SQL.Clear;
    qryGenRcx.SQL.Add(strSQL);
    qryGenRcx.ParamByName('SEQCON').AsInteger := intSeqCon;
    qryGenRcx.ParamByName('CODEMP').AsString  := VS_strCodEmp;
    qryGenRcx.Open;

    Result := fFormataFloat(qryGenRcx.FieldByName('VALDOC').AsFloat, 2) = fFormataFloat(qryGenRcx.FieldByName('VALMOD').AsFloat, 2);

    if qryGenRcx.FieldByName('QTDREGISTRO').AsFloat <= 0 then
      Result := False;

    {***************************************}
    {* RETORNA A DIFERENÇA DAS MODALIDADES *}
    {*26/02/2015*REQ:22285***************AF*}
    If Not Result Then
      strMsgDif := 'ValDoc: ' + FloatToStrF(fFormataFloat(qryGenRcx.FieldByName('VALDOC').AsFloat, 2), ffFixed, 12, 2) + ' ' +
                   'ValMod: ' + FloatToStrF(fFormataFloat(qryGenRcx.FieldByName('VALMOD').AsFloat, 2), ffFixed, 12, 2) + ' ' +
                   'Qtde Registros: ' + IntToStr(qryGenRcx.FieldByName('QTDREGISTRO').AsInteger);

    qryGenRcx.Close;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'');
    End;
  End;

  FreeAndNil(qryGenRcx);
End;

function fGetSQLTransfValores(strCodGpo: String = '';
                              strCodVen: String = '';
                              blnAgrOpe: Boolean = False): String;
  Var
    strSQL : String;
begin
  strSQL := ' SELECT ';

  If (blnAgrOpe) Then
  Begin
    strSQL := strSQL + ' CONCAT(RCX_CODOPE, "-", CADOPE.OPE_NOMOPE) AS RCX_CODOPE, ';
    strSQL := strSQL + ' SUM(RCX_DINREC + RCX_CHQAVI + RCX_CHQPRE + RCX_CARREC + RCX_ORDREC + RCX_VALFIN) AS RCX_TOTGER,  ';
  End;

  strSQL := strSQL + '  SUM(RCX_DINREC) AS RCX_DINREC, ';
  strSQL := strSQL + '  SUM(RCX_CHQAVI) AS RCX_CHQAVI, ';
  strSQL := strSQL + '  SUM(RCX_CHQPRE) AS RCX_CHQPRE, ';
  strSQL := strSQL + '  SUM(RCX_CARREC) AS RCX_CARREC, ';
  strSQL := strSQL + '  SUM(RCX_ORDREC) AS RCX_ORDREC, ';
  strSQL := strSQL + '  SUM(RCX_VALFIN) AS RCX_VALFIN  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '  CADRCXX ';

  If (blnAgrOpe) Then
    strSQL := strSQL + ' LEFT JOIN CADOPE ON RCX_CODOPE = CADOPE.OPE_CODOPE ';

  If Not fEmptyStr(strCodGpo) Then
    strSQL := strSQL + ' JOIN OPEGPO ON RCX_CODOPE = OPEGPO.OPE_CODOPE AND GPO_CODGPO = ' + QuotedStr(strCodGpo);

  strSQL := strSQL + ' WHERE ';

  If Not fEmptyStr(strCodVen) Then
    strSQL := strSQL + ' RCX_CODOPE = ' + QuotedStr(strCodVen) + ' AND ';

  strSQL := strSQL + '  RCX_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  ( RCX_DTACAD > :DTACAD OR ';
  strSQL := strSQL + '  (RCX_DTACAD = :DTACAD AND RCX_ESPDOC = "FC") ) ';

  If (blnAgrOpe) Then
    strSQL := strSQL + ' GROUP BY RCX_CODOPE ';

  Result := strSQL;
end;

function fVerificaGrvCartaoCheque(Var strMsgDif: String; const intSeqCon: Integer; const strEmpRcx: String): Boolean;
  Var
    strSQL   : String;
    qryGenRcx: TUniQuery;
    qryGenAux: TUniQuery;

  function fGetSQLCartoes: String;
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  MCA_DTACAD, MCA_SEQCON, MCA_CODEMP, SUM( MCA_VALSTA ) AS MCA_VALSTA ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVCAR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  MCA_SEQCON = :SEQCON AND ';
    strSQL := strSQL + '  MCA_EMPRCX = :CODEMP ';
    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  MCA_SEQCON ';

    Result := strSQL;
  End;

  function fGetSQLCheques: String;
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  SUM( CHQ_VALCHQ ) AS CHQ_VALCHQ ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCHQ ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CHQ_SEQCON = :SEQCON AND ';
    strSQL := strSQL + '  CHQ_EMPRCX = :CODEMP ';
    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  CHQ_SEQCON ';

    Result := strSQL;
  End;

begin
  Try
    Result := True;

    qryGenRcx := fCriaQuery(Nil);
    qryGenAux := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  SUM( RCX_VALFIN ) AS VALFIN, ';
    strSQL := strSQL + '  SUM( RCX_CARREC ) AS CARREC, ';
    strSQL := strSQL + '  SUM( RCX_CHQAVI ) AS CHQAVI, ';
    strSQL := strSQL + '  SUM( RCX_CHQPRE ) AS CHQPRE  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADRCXX ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  RCX_SEQCON = :SEQCON AND ';
    strSQL := strSQL + '  RCX_CODEMP = :CODEMP ';

    With qryGenRcx Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQCON').AsInteger := intSeqCon;
      ParamByName('CODEMP').AsString  := strEmpRcx;
      Open;
    End;

    {********************}
    {* VERIFICA CARTÕES *}
    {*****************AF*}
    With qryGenAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLCartoes);
      ParamByName('SEQCON').AsInteger := intSeqCon;
      ParamByName('CODEMP').AsString  := strEmpRcx;
      Open;
    End;
    If Not qryGenAux.IsEmpty Then
    Begin
      Result := fFormataFloat(qryGenAux.FieldByName('MCA_VALSTA').AsFloat, 2) = fFormataFloat(qryGenRcx.FieldByName('CARREC').AsFloat, 2);

      //016-Financiamento tambem grava cartoes
      If Not Result Then
        Result := fFormataFloat(qryGenAux.FieldByName('MCA_VALSTA').AsFloat, 2) = fFormataFloat(qryGenRcx.FieldByName('VALFIN').AsFloat, 2);

      If Not Result Then
        strMsgDif := 'ValCar: ' + FloatToStrF(fFormataFloat(qryGenAux.FieldByName('MCA_VALSTA').AsFloat, 2), ffFixed, 12, 2) + ' ' +
                     'ValMod: ' + FloatToStrF(fFormataFloat(qryGenRcx.FieldByName('CARREC').AsFloat, 2), ffFixed, 12, 2);
    End;

    {*******************}
    {* VERIFICA CHEQUE *}
    {****************AF*}
    With qryGenAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLCheques);
      ParamByName('SEQCON').AsInteger := intSeqCon;
      ParamByName('CODEMP').AsString  := strEmpRcx;
      Open;
    End;
    If Result And (Not qryGenAux.IsEmpty) Then
    Begin
      Result := fFormataFloat(qryGenAux.FieldByName('CHQ_VALCHQ').AsFloat, 2) = fFormataFloat(qryGenRcx.FieldByName('CHQAVI').AsFloat +
                                                                                              qryGenRcx.FieldByName('CHQPRE').AsFloat, 2);

      If Not Result Then
        strMsgDif := 'ValChq: ' + FloatToStrF(fFormataFloat(qryGenAux.FieldByName('CHQ_VALCHQ').AsFloat, 2), ffFixed, 12, 2) + ' ' +
                     'ValMod: ' + FloatToStrF(fFormataFloat(qryGenRcx.FieldByName('CHQAVI').AsFloat +
                                                            qryGenRcx.FieldByName('CHQPRE').AsFloat, 2), ffFixed, 12, 2);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  FreeAndNil(qryGenAux);
  FreeAndNil(qryGenRcx);
end;

function fRetornaDadosUltimoFechamento(strCodigoEmpresa: String): TDataset;
  Var
    qryConsulta: TUniQuery;
begin
  Try
    qryConsulta := fCriarQuery('SELECT * FROM ' +
                               '    CADRCXX WHERE RCX_ESPDOC = "FC" AND ' +
                               '                  RCX_CODEMP = ' + strCodigoEmpresa.QuotedString +
                               ' ORDER BY RCX_DTACAD DESC LIMIT 1');
    qryConsulta.Open;

    Result := fCriaClientDatset(qryConsulta);
    Result.Open;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure SomaModalidadesParaEstornoCaixa(ASeqcon: Integer;  ACodigoEmpresa: String;
  ADataCadastro: TDateTime; var ADinheiro, ACartao, AChequeAVista, AChequePre,
  AOrdemPagamento: Double);
  Var
    LConsulta: TUniQuery;
Begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT IFNULL(SUM(RCX_DINREC), 0) AS RCX_DINREC, ' +
                          '       IFNULL(SUM(RCX_CARREC), 0) AS RCX_CARREC, ' +
                          '       IFNULL(SUM(RCX_CHQAVI), 0) AS RCX_CHQAVI, ' +
                          '       IFNULL(SUM(RCX_CHQPRE), 0) AS RCX_CHQPRE, ' +
                          '       IFNULL(SUM(RCX_ORDREC), 0) AS RCX_ORDREC  ' +
                          'FROM CADRCXX ' +
                          'WHERE RCX_DTACAD=:DTACAD ' +
                          '  AND RCX_CODEMP=:CODEMP ' +
                          '  AND RCX_SEQCON=:SEQCON ';

    LConsulta.ParamByName('DTACAD').AsDateTime := ADataCadastro;
    LConsulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LConsulta.ParamByName('SEQCON').AsInteger := ASeqCon;
    LConsulta.Open;

    ADinheiro := fFormataFloat(LConsulta.FieldByName('RCX_DINREC').AsFloat, 2);
    ACartao := fFormataFloat(LConsulta.FieldByName('RCX_CARREC').AsFloat, 2);
    AChequeAVista := fFormataFloat(LConsulta.FieldByName('RCX_CHQAVI').AsFloat, 2);
    AChequePre := fFormataFloat(LConsulta.FieldByName('RCX_CHQPRE').AsFloat, 2);
    AOrdemPagamento := fFormataFloat(LConsulta.FieldByName('RCX_ORDREC').AsFloat, 2);
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
End;

end.
