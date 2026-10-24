unit untImportaPAFECF;

interface

uses Windows, SysUtils, Classes, ComCtrls, Uni, untFuncFat, untTypesSistema,
     UniClientDataSet, StrUtils, Forms, DateUtils, UniDataSetProvider;

Type
  TImportaPAFECF = class(TObject)
    private
      FProgresso: TProgressBar;
      qryPafPrincipal: TUniQuery;

      fatVenda: TFatVenda;
      qryDadosItens: TUniQuery;

      strConPagPedido: String;
      fltVlrConCupom: Double;
      blnCreditoMaiorQueVenda: Boolean;

      qryCadRcx : TUniQuery;

      blnCampoObsColExiste : boolean;

      procedure pSetMax(intMax: Integer);
      procedure pStep(intStep: Integer);

      procedure pRetornaDadosORPD(strNumCoo, strNumSer: String;
        Var strNumDoc, strEspDoc, strCodEmp, strCodCnd, strCodRep, strCodDiv, strCodVe2, strMsgPd1, strMsgPd2: String;
        Var cdsProfiss: TUniClientDataSet);

      procedure pCarregarPafPrincipal;
      procedure pImportarPrincipal;
      function fJaExisteCadFis(): Boolean;

      procedure pImportarDocumento;
      procedure pCarregarItens;
      procedure pCarregaDadosCliente;
      procedure pCarregaDuplicatas(strCndOriginal: String);
      procedure pCarregaCartoes;
      procedure pCarregaCheques;
      procedure pCarregarModalidades;
      procedure pCarregaDuplicatasCreditoBaixadas;
      procedure pAcertaDigDuplicParaCreditoEModalidades;
      procedure pSetaZerDin;
      procedure pUtilizaIcmsGravado;
      procedure pCarregaDesEsp;
      procedure pCarregaLogVar;

      procedure pAtualizaTabelasPAF;
      procedure pAtualizaDadosCupom;
      procedure pAtualizaChaveAcesso(dtaDataOriginal: TDateTime);

      function fFormataIdLocal: String;
      procedure pRealizarPreValidacaoItens;

      function fTemCaixa(qryCaixa: TUniQuery): Boolean;
      procedure pValidaMovimentoAuxiliar(qryCaixa: TUniQuery);
      procedure pMarcarComoNaoConferido;
      procedure pLiberarObjetos;
      procedure pGravaLogVarPAF(strDirAce, strOpeLib, strCodOpe, strCodDig, strCodCli: String;
        dtaDtaCad, dtaHorCad: TDateTime; strObserv: String);

      function fRetUnitariosPedido(strIdLoc, strIdDoc, strCodIte: String; fltUnitar: Double; intSeqPd: Integer;
        Var fltUnitarOri, fltUnitarVis, fltUnitarDig, fltPreCus, fltPreMed, fltTaxaJuros: Double;
        Var strConPag: String): Boolean;

      procedure pRetInfoPedido(strIdLoc, strIdDoc: String; var strAutInc, strOrcEsp: String);

      function fVerificaInconsistenciasDados(strIdLoc, strIdDoc: String): Boolean;

      function fChequeExisteAutcom(qryCheque: TUniQuery): Boolean;

      procedure pApagaRegistrosCaixaSemValorESemLigacao;
      procedure pApagarRegistrosCaixaUtilizacaoCreditoMaiorVenda;
      procedure pCopiarRegistroCaixaReferenteACreditoDoPDV;

      function fGravarMovimentoBancarioSangria: string;
      function fGravouMovimentoBancarioSangria(strSeqLan: string): Boolean;

      function fRetornaEntregaRetiraPedido(strNumPed, strEspPed, strEmpPed, strCliPed, strCodIte: String): String;
    public
      constructor Create(pgbProgresso: TProgressBar);
      destructor Destroy; override;

      procedure pImportar;
  End;

Const
  TEMPO_EXECUCAO_IMPORTADOR_PDV = 10;

procedure pTestaInatividade;
function fArqInatividade: String;
function fLockInatividade: String;
function fIdLockAtividade: Integer;

implementation

uses  untFuncFatTypes, untFuncoes, untParCalculaPrecoCusto, untTConfiguracao,
      untTMatrizSaldosColorantes, untFuncoesSimples,  untFuncTinta, Data.DB,
      untMovBan, untTBanTrf, untDuplicatas, untCadRcxx;

{ TImportaPAFECF }

constructor TImportaPAFECF.Create(pgbProgresso: TProgressBar);
begin
  Self.FProgresso := pgbProgresso;
  Self.qryPafPrincipal := fCriaQuery;
  Self.fatVenda := Nil;
  qryCadRcx := fCriaQuery;

  With qryCadRcx Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT COUNT(*) AS CNT ');
    SQL.Add('   FROM CADRCXX ');
    SQL.Add('  WHERE RCX_CODEMP = :CODEMP ');
    SQL.Add('    AND RCX_DTACAD = :DTAMOV ');
  End;

  blnCampoObsColExiste := fCampoExiste('TINDOR', 'FDO_OBSCOL', True);
end;

destructor TImportaPAFECF.Destroy;
begin
  FreeAndNil(qryPafPrincipal);
  FreeAndNil(qryCadRcx);
  inherited;
end;

function TImportaPAFECF.fChequeExisteAutcom(qryCheque: TUniQuery): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add('SELECT COUNT(*) AS QTD FROM CADCHQ WHERE ');
    qryAux.SQL.Add('  CHQ_CODBCO = :CODBCO AND ');
    qryAux.SQL.Add('  CHQ_NUMAGE = :NUMAGE AND ');
    qryAux.SQL.Add('  CHQ_CONCOR = :CONCOR AND ');
    qryAux.SQL.Add('  CHQ_NUMCHQ = :NUMCHQ AND ');
    qryAux.SQL.Add('  CHQ_CODEMP = :CODEMP ');

    qryAux.ParamByName('CODBCO').AsString := qryCheque.FieldByName('CHQ_CODBCO').AsString;
    qryAux.ParamByName('NUMAGE').AsString := qryCheque.FieldByName('CHQ_NUMAGE').AsString;
    qryAux.ParamByName('CONCOR').AsString := qryCheque.FieldByName('CHQ_CONCOR').AsString;
    qryAux.ParamByName('NUMCHQ').AsString := qryCheque.FieldByName('CHQ_NUMCHQ').AsString;
    qryAux.ParamByName('CODEMP').AsString := qryCheque.FieldByName('CHQ_CODEMP').AsString;
    qryAux.Open;

    Result := qryAux.FieldByName('QTD').AsInteger > 0;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TImportaPAFECF.fFormataIdLocal: String;
begin
  Result := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString + '-' +
    qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
end;

function TImportaPAFECF.fGravouMovimentoBancarioSangria(strSeqLan: string): Boolean;
  var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery();
  Try
    qryAux.SQL.Add('SELECT CTB_SEQLAN FROM BANTRF WHERE CTB_SEQLAN = :SEQLAN');
    qryAux.ParamByName('SEQLAN').AsString := strSeqLan;
    qryAux.Open;

    Result := qryAux.RecordCount > 0;

    if not Result then
      Exit;

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT CTB_SEQLAN FROM MOVBAN WHERE CTB_SEQLAN = :SEQLAN');
    qryAux.ParamByName('SEQLAN').AsString := strSeqLan;
    qryAux.Open;

    Result := qryAux.RecordCount > 0;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TImportaPAFECF.fJaExisteCadFis(): Boolean;
  Var
    qryLocal: TUniQuery;
begin
  qryLocal := fCriaQuery();
  try
    qryLocal.SQL.Clear;
    qryLocal.SQL.Add('SELECT FIS_NUMSER, FIS_NUMCOO FROM CADFIS WHERE FIS_NUMSER = :NUMSER AND FIS_NUMCOO = :NUMCOO');
    qryLocal.ParamByName('NUMSER').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
    qryLocal.ParamByName('NUMCOO').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
    qryLocal.Open;

    Result := not qryLocal.IsEmpty;
  finally
    FreeAndNil(qryLocal);
  end;
end;

function TImportaPAFECF.fTemCaixa(qryCaixa: TUniQuery): Boolean;
  Var
    qryLocal: TUniQuery;
begin
  qryLocal := qryCaixa;
  Try
    If Not Assigned(qryCaixa) Then
    Begin
      qryLocal := fCriaQuery;
    End;

    qryLocal.SQL.Clear;
    qryLocal.SQL.Add('SELECT * FROM PAF_CAIXA WHERE RCX_ID_LOC = :ID_LOC AND RCX_ID_DOC = :ID_DOC');
    qryLocal.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
    qryLocal.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
    qryLocal.Open;

    Result := (Not qryLocal.IsEmpty);

    If Not Result Then
    Begin
      qryLocal.Close;
      qryLocal.SQL.Clear;
      qryLocal.SQL.Add('SELECT * FROM CADRCXX WHERE RCX_ID_LOC = :ID_LOC AND RCX_ID_DOC = :ID_DOC');
      qryLocal.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
      qryLocal.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
      qryLocal.Open;

      Result := (Not qryLocal.IsEmpty);
    End;
  Finally
    If qryLocal <> qryCaixa Then
    Begin
      FreeAndNil(qryLocal);
    End;
  End;
end;

function TImportaPAFECF.fVerificaInconsistenciasDados(strIdLoc,
  strIdDoc: String): Boolean;
  Var
    qryCheque: TUniQuery;
    qryVerificaPrincipal: TUniQuery;
begin
  Result := False;
  qryCheque := fCriaQuery(Nil);
  Try
    qryCheque.SQL.Add('SELECT * FROM PAF_CHEQUES WHERE CHQ_ID_LOC = :ID_LOC AND CHQ_ID_DOC = :ID_DOC');
    qryCheque.ParamByName('ID_LOC').AsString := strIdLoc;
    qryCheque.ParamByName('ID_DOC').AsString := strIdDoc;
    qryCheque.Open;

    While (Not qryCheque.Eof) Do
    Begin
      If fChequeExisteAutcom(qryCheque) Then
      Begin
        Result := True;

        qryCheque.Edit;
        qryCheque.FieldByName('CHQ_DUPLIC').AsInteger := 1;
        qryCheque.Post;
      End;

      qryCheque.Next;
    End;

    If Not Result Then
    Begin
      qryVerificaPrincipal := fCriaQuery(Nil);
      Try
        qryVerificaPrincipal.SQL.Add('SELECT PAF_EXPORT FROM PAF_PRINCIPAL WHERE ');
        qryVerificaPrincipal.SQL.Add('  PAF_ID_LOC = :ID_LOC AND ');
        qryVerificaPrincipal.SQL.Add('  PAF_ID_DOC = :ID_DOC ');

        qryVerificaPrincipal.ParamByName('ID_LOC').AsString := strIdLoc;
        qryVerificaPrincipal.ParamByName('ID_DOC').AsString := strIdDoc;
        qryVerificaPrincipal.Open;

        {*******************************************}
        {* CASO CARREGA UM DOCUMENTO APRA IMPORTAR *}
        {* QUE JÁ ESTEJA IMPORTADO, CONSIDERA COMO *}
        {* PENDÊNCIA E NÃO IMPORTA.                *}
        {****************************************MV*}
        If qryVerificaPrincipal.FieldByName('PAF_EXPORT').AsInteger  = 1 Then
        Begin
          Result := True;
        End;
      Finally
        FreeAndNil(qryVerificaPrincipal);
      End;
    End;
  Finally
    FreeAndNil(qryCheque);
  End;
end;

procedure TImportaPAFECF.pCarregarPafPrincipal;
begin
  qryPafPrincipal.SQL.Clear;
  qryPafPrincipal.SQL.Add('SELECT * FROM PAF_PRINCIPAL ');
  qryPafPrincipal.SQL.Add('WHERE PAF_CODEMP = :CODEMP AND PAF_EXPORT = 0 AND PAF_CONFER = 1 AND PAF_ID_LOC NOT LIKE "%PRODUCAO%"');
  qryPafPrincipal.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryPafPrincipal.Open;

  pSetMax(qryPafPrincipal.RecordCount);
end;

{**********************************}
{* NECESSÁRIO PARA GRAVAR LOGREP. *}
{*******************************MV*}
procedure TImportaPAFECF.pCopiarRegistroCaixaReferenteACreditoDoPDV;
  Var
    qryRcx: TUniQuery;
    qryInsRcx: TUniQuery;
    qryDel: TUniQuery;

    intContador: Integer;
    strNomCam: String;
begin
  qryRcx := fCriaQuery;
  qryInsRcx := fCriaQuery;
  qryDel := fCriaQuery;

  Try
    qryInsRcx.SQL.Add('SELECT * FROM CADRCXX WHERE FALSE ');
    qryInsRcx.Open;

    qryDel.SQL.Add('DELETE FROM CADRCXX WHERE ');
    qryDel.SQL.Add('  RCX_ID_LOC = :ID_LOC AND ');
    qryDel.SQL.Add('  RCX_ID_DOC = :ID_DOC AND ');
    qryDel.SQL.Add('  AUTOINCREM = :AUTINC ');

    qryRcx.SQL.Add('SELECT * FROM CADRCXX WHERE ');
    qryRcx.SQL.Add('  RCX_ID_LOC = :ID_LOC AND ');
    qryRcx.SQL.Add('  RCX_ID_DOC = :ID_DOC AND ');
    qryRcx.SQL.Add('  RCX_VALDOC < 0 ');

    qryRcx.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
    qryRcx.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
    qryRcx.Open;

    While (Not qryRcx.Eof) Do
    Begin
      qryInsRcx.Append;
      For intContador := 0 To qryInsRcx.Fields.Count -1 Do
      Begin
        strNomCam := qryInsRcx.Fields[intContador].FieldName;
        qryInsRcx.FieldByName(strNomCam).Value := qryRcx.FieldByName(strNomCam).Value;
      End;
      qryInsRcx.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADRCXX', VS_strCodEmp);
      qryInsRcx.Post;

      qryDel.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
      qryDel.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
      qryDel.ParamByName('AUTINC').AsString := qryRcx.FieldByName('AUTOINCREM').AsString;
      qryDel.ExecSQL;

      qryRcx.Next;
    End;

  Finally
    FreeAndNil(qryRcx);
    FreeAndNil(qryDel);
    FreeAndNil(qryInsRcx);
  End;
end;

function TImportaPAFECF.fGravarMovimentoBancarioSangria: string;
  Var
    strCtaTra: String;
    strCodPor: String;
    qryRcx: TUniQuery;
    lstBanTrf : TListaBanTrf;
    strCreditoDebito : string;

    LBanTrfDS: TBanTrfDS;
begin
  Result := '';
  qryRcx := fCriaQuery();
  Try
    qryRcx.SQL.Add(' SELECT RCX_VALDOC, RCX_DESCRI, RCX_CODOPE, RCX_CODEMP, ');
    qryRcx.SQL.Add('        RCX_DINREC, RCX_CHQAVI, RCX_CHQPRE, RCX_CARREC, ');
    qryRcx.SQL.Add('        RCX_ORDREC, RCX_VALFIN, RCX_ESPDOC ');
    qryRcx.SQL.Add('   FROM CADRCXX ');
    qryRcx.SQL.Add('  WHERE RCX_ID_LOC = :ID_LOC ');
    qryRcx.SQL.Add('    AND RCX_ID_DOC = :ID_DOC ');
    qryRcx.SQL.Add('    AND RCX_ESPDOC IN ("LD", "LC") ');

    qryRcx.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
    qryRcx.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
    qryRcx.Open;

    If Not qryRcx.IsEmpty Then
    Begin
      if (qryRcx.FieldByName('RCX_ESPDOC').AsString = 'LD') then
        strCreditoDebito := 'C'
      else
        strCreditoDebito := 'D';

      strCtaTra := fConverteCentroCusto(fCfgSis('CTATRA'));
      strCodPor := fCfgSis('PORDIN');

      LBanTrfDS := TBanTrfDS.Create;
      LBanTrfDS.strCodOpe := qryRcx.FieldByName('RCX_CODOPE').AsString;
      LBanTrfDS.strCodEmp := qryRcx.FieldByName('RCX_CODEMP').AsString;
      LBanTrfDS.strDescri := qryRcx.FieldByName('RCX_DESCRI').AsString;
      LBanTrfDS.fltValDoc := qryRcx.FieldByName('RCX_VALDOC').AsFloat;
      LBanTrfDS.fltDinRec := qryRcx.FieldByName('RCX_DINREC').AsFloat;
      LBanTrfDS.fltChqAvi := qryRcx.FieldByName('RCX_CHQAVI').AsFloat;
      LBanTrfDS.fltChqPre := qryRcx.FieldByName('RCX_CHQPRE').AsFloat;
      LBanTrfDS.fltCarRec := qryRcx.FieldByName('RCX_CARREC').AsFloat;
      LBanTrfDS.fltOrdRec := qryRcx.FieldByName('RCX_ORDREC').AsFloat;
      LBanTrfDS.fltValFin := qryRcx.FieldByName('RCX_VALFIN').AsFloat;

      lstBanTrf := TListaBanTrf.Create;
      lstBanTrf.Add(LBanTrfDS);

      Result    := fGravaMovBan(strCtaTra,                                          // Centro de Custo
                                strCodPor,                                          // Portador da Baixa
                                qryPafPrincipal.FieldByName('PAF_CODDIG').AsString, // Operador da Baixa
                                VS_Date,                                            // Data do Lançamento
                                fTime(),                                            // Hora do Lançamento
                                '',                                                 // Numero do Documento
                                strCreditoDebito,                                   // Credito / Debito
                                VS_strCodEmp,                                       // Empresa da Baixa
                                Abs(qryRcx.FieldByName('RCX_VALDOC').AsFloat),      // Valor Do Lançamento
                                qryRcx.FieldByName('RCX_DESCRI').AsString,          // Histórico 1
                                '',                                                 // Histórico 2
                                '',                                                 // Cliente da Duplicata
                                '',                                                 // Fornecedor da Duplicata
                                '',                                                 // Número da Duplicata
                                0,                                                  // Sequencial de Baixa
                                'A',                                                // Parcela da Duplicata
                                VS_strCodEmp,                                       // Empresa da Duplicata
                                '',                                                 // Série
                                //'',                                               // Sequencial de Lançamento
                                '',                                                 // Codigo do Evento
                                '',
                                Nil,
                                0,
                                0,
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                1,
                                True,
                                lstBanTrf);


      If fEmptyStr(Result) Then
        Raise Exception.Create('Não foi possível gravar o movimento bancário referente à sangria/suprimento.');
    End;
  Finally
    FreeAndNil(qryRcx);
    FreeAndNil(lstBanTrf);
  End;
end;

procedure TImportaPAFECF.pImportar;
begin
  pCarregarPafPrincipal;
  pImportarPrincipal;
end;

procedure TImportaPAFECF.pLiberarObjetos;
begin
  If Assigned(fatVenda) Then
    FreeAndNil(fatVenda);

  pFreeCdsVenda;

  If Assigned(qryDadosItens) Then
    FreeAndNil(qryDadosItens);
end;

procedure TImportaPAFECF.pImportarDocumento;
  Var
    strMsgErro: String;
    strPatIni: String;
    strAutoIncremPedido: String;
    strOrcEsp : String;
    strSeqLan: string;
begin
  pLIberarObjetos;
  pZerarTentativasLock('IMPORTACAO_PAF_' + VS_strCodEmp, False);

  If Assigned(untFuncoesSimples.dicConfiguracoes) Then
    untFuncoesSimples.dicConfiguracoes.Clear;

  pCriarCdsVenda(Nil);

  fatVenda := TFatVenda.CreateInstance('VN', True, False);
  fatVenda.VS_strClaVen  := fTransform(fCfgSis('CLAVEN'), 4);
  fatVenda.VS_strClaDev  := fTransform(fCfgSis('CLADEV'), 4);
  fatVenda.VS_strClaNfo  := fTransform(fCfgSis('CLANFO'), 4);

  If fCfgSis('DACPOR', varBoolean) Then
    strPortadoresOperador := fRetPortadoresOperador(strLoginUsuarioLogado);

  VS_strTipExp     := fCfgSis('TIPEXP', varString);
  strPatIni := fCfgSis('PATINI');
  strPatIni := strPatIni + '\OPCOES_LOCAIS.INI';

  If FileExists(strPatIni) Then
  Begin
    VS_strTipExp := fArqIniLocal(0, 'TIPO_FATURAMENTO', 'EXPEDICAO' , VS_strTipExp, strPatIni);
  End;

  fatVenda.strPaf_Id_Doc := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
  fatVenda.strPaf_Id_Loc := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
  fatVenda.blnImpPafEcf := True;
  fatVenda.VS_Date      := qryPafPrincipal.FieldByName('PAF_DTAEMI').AsDateTime;
  fatVenda.blnComTansacao := False;
  fatVenda.strNomeForm := 'frmFatVendas';
  fatVenda.strCodVen := qryPafPrincipal.FieldByName('PAF_CODVEN').AsString;
  fatVenda.strCodDig := qryPafPrincipal.FieldByName('PAF_CODDIG').AsString;
  fatVenda.strOriF11 := IIF(fCfgSis('F11PAF', varBoolean), 'S', 'N');
  If fEmptyStr(fatVenda.strCodDig) Then
  Begin
    fatVenda.strCodDig := fatVenda.strCodVen;
  End;

  fatVenda.strConPag := qryPafPrincipal.FieldByName('PAF_CONPAG').AsString;
  fatVenda.strCodFpg := qryPafPrincipal.FieldByName('PAF_CODFPG').AsString;

  fatVenda.strTipVen := fCampoTabela('OPE_INTEXT', 'CADOPE', ['OPE_CODOPE'], [qryPafPrincipal.FieldByName('PAF_CODVEN').AsString]);

  strConPagPedido := '';
  fltVlrConCupom := 0;
  blnCreditoMaiorQueVenda := False;

  pZerarTentativasLock('IMPORTACAO_PAF_' + VS_strCodEmp, False);

  pCarregarItens;
  pCarregarModalidades;

  pZerarTentativasLock('IMPORTACAO_PAF_' + VS_strCodEmp, False);

  If (Not qryDadosItens.IsEmpty) Then
  Begin
    If Pos(fatVenda.strCodFpg, '003_008_014_015') <= 0 Then
    Begin
      Try
        pRealizarPreValidacaoItens;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '');
          Exit;
        End;
      End;
    End;

    pZerarTentativasLock('IMPORTACAO_PAF_' + VS_strCodEmp, False);

    pCarregaDadosCliente;
    pCarregaDuplicatas(strConPagPedido);
    pCarregaCartoes;
    pCarregaCheques;
    pCarregaDuplicatasCreditoBaixadas;

    pRetInfoPedido(qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString,
                   qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString,
                   strAutoIncremPedido,
                   strOrcEsp);

    If (strOrcEsp = 'S') Then
      fatVenda.blnCupEsp := True;

    fatVenda.objEndEnt.pRetEnderecoEntregaOrcamento(strAutoIncremPedido, fatVenda.strCodCli);
    fatVenda.pEnderecoToFatVenda;
    If Not fEmptyStr(fatVenda.strAutEnt) Then
      fatVenda.blnForcEndEnt := True;

    pZerarTentativasLock('IMPORTACAO_PAF_' + VS_strCodEmp, False);

    fatVenda.pPreencheMatrizFechamento;

    If Not fatVenda.fConfirmacaoComEntregaRetiraDefinidaPelaSujRom Then
      fatVenda.strEntFat := IIF(fatVenda.fTemItensEntrega, 'S', 'N');

    pCarregaDesEsp;
    pCarregaLogVar;

    fatVenda.pCalculaTotGer;

    pSetaZerDin;

    fatVenda.pCalculaTotalParaCadRec;

    pUtilizaIcmsGravado;

    pZerarTentativasLock('IMPORTACAO_PAF_' + VS_strCodEmp, False);

    Try

      If Not fLockImportacaoValido Then
        Raise Exception.Create('Lock de importação não é mais válido. Será finalizado.');

      fStartTransaction;

      If Pos(qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString, 'NFE' + VS_strCodEmp + '_NFCE' + VS_strCodEmp) > 0 Then
      Begin
        pAtualizaTabelasPAF;
      End;

      pZerarTentativasLock('IMPORTACAO_PAF_' + VS_strCodEmp, False);

      If Not fatVenda.fGravaArquivos Then
      Begin
        strMsgErro := 'Não foi possível faturar o COO ' +
          qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString + ' do ECF ' +
          qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
        If Not fEmptyStr(fatVenda.strMsgErroAdicional) Then
          strMsgErro := strMsgErro + #13#10 + fatVenda.strMsgErroAdicional;

        Raise Exception.Create(strMsgErro);
      End;

      pZerarTentativasLock('IMPORTACAO_PAF_' + VS_strCodEmp, False);

      If Pos(qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString, 'NFE' + VS_strCodEmp + '_NFCE' + VS_strCodEmp) <= 0 Then
      Begin
        pAtualizaTabelasPAF;
      End;

      pAtualizaDadosCupom;

      pZerarTentativasLock('IMPORTACAO_PAF_' + VS_strCodEmp, False);

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollback;
        pMensagensErro(E.Message, '');

        pZerarTentativasLock('IMPORTACAO_PAF_' + VS_strCodEmp, False);
      End;
    End;
  End
  Else
  Begin
    Try
      fStartTransaction();
      strSeqLan := fGravarMovimentoBancarioSangria;
      if (not fEmptyStr(strSeqLan)) and (fGravouMovimentoBancarioSangria(strSeqLan)) then
      begin
        pAtualizaTabelasPAF;
        fCommit();
      end
      else
        fRollBack();
    Except
      On E: Exception Do
      Begin
        fRollBack();
        pMensagensErro(E.Message, '');

        pZerarTentativasLock('IMPORTACAO_PAF_' + VS_strCodEmp, False);
      End;
    End;
  End;

  pLiberarObjetos;
end;

procedure TImportaPAFECF.pCarregarItens;
  Var
    forTin: TForTin;
    dadosMadeira: TDadosMadeira;

    strNumOrc: String;
    strEspOrc: String;
    strEmpOrc: String;
    strCodCnd: String;
    strCodRep: String;
    strCodDiv: String;
    strCodVe2: String;
    strMen001: String;
    strMen002: String;
    cdsProfiss: TUniClientDataSet;

    fltIcmSaiIte: Double;
    strImpDir: String;
    fltPrecoCusto2: Double;

    parPreCus: TParCalculaPrecoCusto;
    intContador: Integer;
    fltPrecoCustoItem: Double;
    fltPrecoMedioItem: Double;
    fltImpUltItem: Double;
    fltPreUltItem: Double;

    fltUnitarOri: Double;
    fltUnitarVis: Double;
    fltTaxaJuros: Double;
    fltUnitarDig: Double;
    blnLocFor: Boolean;

    matrizSaldosAux: TClassMatrizSaldosColorantes;

    strEntRet: String;

begin
  strConPagPedido := '';
  strEntRet := 'R';

  qryDadosItens := fCriaQuery;
  Try
    qryDadosItens.SQL.Add('SELECT ');
    qryDadosItens.SQL.Add('  MOVDET.*, ');
    qryDadosItens.SQL.Add('  FORTIN.*, ');
    qryDadosItens.SQL.Add('  CADITE.ITE_REFERE, ');
    qryDadosItens.SQL.Add('  CADITE.ITE_CODGRU, ');
    qryDadosItens.SQL.Add('  CADITE.ITE_CODMAR, ');
    qryDadosItens.SQL.Add('  CADITE.ITE_CODFOR, ');
    qryDadosItens.SQL.Add('  CADITE.ITE_INCPIS, ');
    qryDadosItens.SQL.Add('  CADITE.ITE_CLAIPI, ');
    qryDadosItens.SQL.Add('  CADITE.ITE_EXCIPI, ');

    If fCfgSis('TIPABF') = '1' Then
      qryDadosItens.SQL.Add('  CADITE.ITE_CODABF, ')
    Else
      qryDadosItens.SQL.Add('  ITEGER.ITE_CODABF, ');

    qryDadosItens.SQL.Add('  CADITE.ITE_COMLUB, ');
    qryDadosItens.SQL.Add('  CADITE.ITE_PESOIT, ');
    qryDadosItens.SQL.Add('  CADITE.ITE_PESLIQ, ');
    qryDadosItens.SQL.Add('  CADITE.ITE_EMBALA, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_LOCFIS, ');
    qryDadosItens.SQL.Add('  CADITE.ITE_CODBAR, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_COMVAR, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_COMATA, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_COMDIS, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_PREVE1, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_PREVE2, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_PREVE3, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_PREVE4, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_PREVE5, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_PREVE6, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_PREVE7, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_PRECUS, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_PREULT, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_IMPULT, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_PREMED, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_MARMIN, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_MARMSG, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_MARMGE, ');

    qryDadosItens.SQL.Add('  ITEGER.ITE_DESMVM, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_DESMSM, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_DESMGM, ');

    qryDadosItens.SQL.Add('  ITEGER.ITE_MARMMV, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_MARMMS, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_MARMMG, ');

    qryDadosItens.SQL.Add('  ITEGER.ITE_PRECOM, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_QTPPRO, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_OUTVAL, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_COMTB1, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_COMTB2, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_COMTB3, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_COMTB4, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_COMTB5, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_COMTB6, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_COMTB7, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_DESOPE, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_ICMSAI, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_IMPFED, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_DESMGE, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_DESMSU, ');

    qryDadosItens.SQL.Add('  CADITE.ITE_IMPDIR CADITE_ITE_IMPDIR, ');
    qryDadosItens.SQL.Add('  ITEGER.ITE_IMPDIR ITEGER_ITE_IMPDIR, ');

    qryDadosItens.SQL.Add('  TINDOR.FDO_MONTAD, ');
    qryDadosItens.SQL.Add('  TINDOR.FDO_A_N_O_, ');

    qryDadosItens.SQL.Add('  FATDOR.FDO_IDEPRO, ');
    qryDadosItens.SQL.Add('  FATDOR.FDO_CODITE, ');
    qryDadosItens.SQL.Add('  FATDOR.FDO_NUMDOC, ');
    qryDadosItens.SQL.Add('  FATDOR.FDO_CODEMP, ');
    qryDadosItens.SQL.Add('  FATDOR.FDO_EMPITE, ');
    qryDadosItens.SQL.Add('  FATDOR.FDO_DESCRI, ');
    qryDadosItens.SQL.Add('  FATDOR.FDO_QTDITE, ');
    qryDadosItens.SQL.Add('  FATDOR.FDO_ITECHA, ');
    qryDadosItens.SQL.Add('  FATDOR.FDO_ITETIN, ');
    qryDadosItens.SQL.Add('  FATDOR.FDO_DESCOR, ');
    qryDadosItens.SQL.Add('  FATDOR.FDO_TIPPRE, ');
    qryDadosItens.SQL.Add('  FATDOR.FDO_LAZQUA, ');
    qryDadosItens.SQL.Add('  FATDOR.FDO_TIPEMB, ');
    qryDadosItens.SQL.Add('  FATDOR.FDO_QTDEMB, ');
    qryDadosItens.SQL.Add('  FATDOR.FDO_PREEMB, ');
    qryDadosItens.SQL.Add('  FATDOR.FDO_PRVTIN, ');
    qryDadosItens.SQL.Add('  FATDOR.FDO_PRCTIN, ');
    qryDadosItens.SQL.Add('  FATDOR.FDO_FATTIN, ');
    qryDadosItens.SQL.Add('  FATDOR.FDO_PROEMB, ');
    qryDadosItens.SQL.Add('  FATDOR.FDO_ITEEMB, ');
    qryDadosItens.SQL.Add('  FATDOR.FDO_VOLPRO, ');
    qryDadosItens.SQL.Add('  FATDOR.FDO_CATALI, ');
    qryDadosItens.SQL.Add('  FATDOR.FDO_EMPPRD, ');
    qryDadosItens.SQL.Add('  FATDOR.FDO_CODREP, ');
    qryDadosItens.SQL.Add('  TINDOR.FDO_LINLIN, ');
    qryDadosItens.SQL.Add('  TINDOR.FDO_CODDIL, ');
    qryDadosItens.SQL.Add('  TINDOR.FDO_PORDIL, ');
    qryDadosItens.SQL.Add('  TINDOR.FDO_DILCON, ');
    qryDadosItens.SQL.Add('  TINDOR.FDO_PORCAT, ');

    if (blnCampoObsColExiste) then
      qryDadosItens.SQL.Add('  TINDOR.FDO_OBSCOL, ')
    else
      qryDadosItens.SQL.Add('  CAST("" AS CHAR(01)) AS FDO_OBSCOL, ');

    qryDadosItens.SQL.Add('  IFNULL(FATGOR.FGO_OPRFLJ, "N") AS FGO_OPRFLJ, ');

    qryDadosItens.SQL.Add('  MOVGER.GER_VLRCON AS VLRCON_CUPOM, ');
    qryDadosItens.SQL.Add('  MOVGER.AUTOINCREM AS AUTINC_GER, ');
    qryDadosItens.SQL.Add('  MOVGER.GER_CGCCPF AS GER_CGCCPF, ');
    qryDadosItens.SQL.Add('  MOVGER.GER_TABPRE AS GER_TABPRE, ');
    qryDadosItens.SQL.Add('  MOVGER.GER_ESTADO AS GER_ESTADO, ');
    For intContador := 1 To 12 Do
    Begin
      qryDadosItens.SQL.Add('  MOVGER.GER_VPAR' + fStrZero(intContador, 2) + ', ');
    End;

    qryDadosItens.SQL.Add('  FATDOR.FDO_TOTCU2, ');

    qryDadosItens.SQL.Add('  CADCLI.CLI_DESOPE, ');
    qryDadosItens.SQL.Add('  IFNULL(LOT_PRECUS, 0) LOT_PRECUS, ');

    qryDadosItens.SQL.Add('  IFNULL(ACA_PRECUS, 0) AS ACA_PRECUS, ');
    qryDadosItens.SQL.Add('  IFNULL(ACA_PREMED, 0) AS ACA_PREMED, ');
    qryDadosItens.SQL.Add('  IFNULL(ACA_IMPULT, 0) AS ACA_IMPULT, ');
    qryDadosItens.SQL.Add('  IFNULL(ACA_PREULT, 0) AS ACA_TOTULT, ');

    qryDadosItens.SQL.Add('  IFNULL(PAF_ITENS.DET_PROMOC, "N") AS PROMOC, ');
    qryDadosItens.SQL.Add('  IFNULL(PAF_ITENS.DET_PROCVA, 0.0) AS DET_PROCVA, ');
    qryDadosItens.SQL.Add('  IFNULL(PAF_ITENS.DET_PROCAT, 0.0) AS DET_PROCAT, ');
    qryDadosItens.SQL.Add('  IFNULL(PAF_ITENS.DET_PROCDI, 0.0) AS DET_PROCDI ');

    qryDadosItens.SQL.Add('FROM ');
    qryDadosItens.SQL.Add('  MOVDET ');
    qryDadosItens.SQL.Add('JOIN CADITE ON CADITE.ITE_CODITE = DET_CODITE ');
    qryDadosItens.SQL.Add('JOIN ITEGER ON ITEGER.ITE_CODITE = DET_CODITE AND ');
    qryDadosItens.SQL.Add('               ITEGER.ITE_CODEMP = DET_CODEMP ');
    qryDadosItens.SQL.Add('JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ');
    qryDadosItens.SQL.Add('LEFT JOIN TINDOR ON TINDOR.FDO_CODACA = MOVDET.DET_CODACA AND ');
    qryDadosItens.SQL.Add('                    TINDOR.FDO_EMPACA = MOVDET.DET_EMPACA AND ');
    qryDadosItens.SQL.Add('                    TINDOR.FDO_NUMDOC = MOVDET.DET_NUM_PD AND ');
    qryDadosItens.SQL.Add('                    TINDOR.FDO_ESPDOC = MOVDET.DET_ESP_PD AND ');
    qryDadosItens.SQL.Add('                    TINDOR.FDO_CODEMP = MOVDET.DET_CODEMP ');
    qryDadosItens.SQL.Add('LEFT JOIN FORTIN ON MOVDET.DET_CODACA = FORTIN.FOR_CODACA AND ');
    qryDadosItens.SQL.Add('                    MOVDET.DET_EMPACA = FORTIN.FOR_EMPACA ');
    qryDadosItens.SQL.Add('LEFT JOIN FATDOR ON FATDOR.FDO_CODACA = MOVDET.DET_CODACA AND ');
    qryDadosItens.SQL.Add('                    FATDOR.FDO_EMPACA = MOVDET.DET_EMPACA AND ');
    qryDadosItens.SQL.Add('                    FATDOR.FDO_NUMDOC = MOVDET.DET_NUM_PD AND ');
    qryDadosItens.SQL.Add('                    FATDOR.FDO_ESPDOC = MOVDET.DET_ESP_PD AND ');
    qryDadosItens.SQL.Add('                    FATDOR.FDO_CODEMP = MOVDET.DET_CODEMP ');
    qryDadosItens.SQL.Add('LEFT JOIN FATGOR ON FATGOR.FGO_NUMDOC = FATDOR.FDO_NUMDOC AND ');
    qryDadosItens.SQL.Add('                    FATGOR.FGO_ESPDOC = FATDOR.FDO_ESPDOC AND ');
    qryDadosItens.SQL.Add('                    FATGOR.FGO_CODEMP = FATDOR.FDO_CODEMP AND ');
    qryDadosItens.SQL.Add('                    FATGOR.FGO_CODCLI = FATDOR.FDO_CODCLI ');
    qryDadosItens.SQL.Add('LEFT JOIN ACAGER ON ACAGER.ACA_CODACA = MOVDET.DET_CODACA AND ');
    qryDadosItens.SQL.Add('                    ACAGER.ACA_CODEMP = MOVDET.DET_CODEMP AND ');
    qryDadosItens.SQL.Add('                    ACAGER.ACA_EMPEST = MOVDET.DET_CODEMP ');
    qryDadosItens.SQL.Add('JOIN CADCLI ON CADCLI.CLI_CODCLI = MOVDET.DET_CODCLI ');
    qryDadosItens.SQL.Add('JOIN AUXMOV ON AUXMOV.AUX_ID_LOC = MOVTRI.DET_ID_LOC AND ');
    qryDadosItens.SQL.Add('               AUXMOV.AUX_ID_DOC = MOVTRI.DET_ID_DOC ');
    qryDadosItens.SQL.Add('JOIN MOVGER ON MOVGER.AUTOINCREM = AUXMOV.AUX_SEQGER ');
    qryDadosItens.SQL.Add('LEFT JOIN PAF_ITENS ON PAF_ITENS.DET_ID_LOC = MOVTRI.DET_ID_LOC AND ');
    qryDadosItens.SQL.Add('                       PAF_ITENS.DET_ID_DOC = MOVTRI.DET_ID_DOC AND ');
    qryDadosItens.SQL.Add('                       PAF_ITENS.DET_SEQGER = MOVDET.AUTOINCREM ');
    qryDadosItens.SQL.Add('LEFT JOIN CADLOT ON MOVDET.DET_CODITE = LOT_CODITE AND ');
    qryDadosItens.SQL.Add('                    MOVDET.DET_CODEMP = LOT_CODEMP AND ');
    qryDadosItens.SQL.Add('                    MOVDET.DET_NUMLOT = LOT_NUMLOT     ');
    qryDadosItens.SQL.Add('WHERE ');
    qryDadosItens.SQL.Add('  MOVTRI.DET_ID_LOC = :ID_LOC AND ');
    qryDadosItens.SQL.Add('  MOVTRI.DET_ID_DOC = :ID_DOC ');

    qryDadosItens.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
    qryDadosItens.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
    qryDadosItens.Open;

    pRetornaDadosORPD(qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString,
                      qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString,
                      strNumOrc, strEspOrc, strEmpOrc, strCodCnd, strCodRep,
                      strCodDiv, strCodVe2, strMen001, strMen002, cdsProfiss);

    If Not qryDadosItens.IsEmpty Then
    Begin
      fltVlrConCupom := qryDadosItens.FieldByName('VLRCON_CUPOM').AsFloat;

      fatVenda.strTipPed  := 'C';
      fatVenda.strNumOrc  := strNumOrc;
      fatVenda.strEspOrc  := strEspOrc;
      fatVenda.strCodCnd  := strCodCnd;
      fatVenda.strCodRep  := strCodRep;
      fatVenda.strCodDiv  := strCodDiv;
      fatVenda.cdsProfiss := cdsProfiss;
      fatVenda.strCodVe2  := strCodVe2;
      fatVenda.strMen001  := 'IMPORTAÇÃO PAF-ECF - ' + strMen001;
      fatVenda.strMen002  := strMen002;
      fatVenda.strCodCli  := qryDadosItens.FieldByName('DET_CODCLI').AsString;
      fatVenda.strTabPre  := qryDadosItens.FieldByName('GER_TABPRE').AsString;
      fatVenda.strCliEst  := qryDadosItens.FieldByName('GER_ESTADO').AsString;

      If Not fEmptyStr(qryDadosItens.FieldByName('GER_CGCCPF').AsString) Then
        fatVenda.intCgcCpf := qryDadosItens.FieldByName('GER_CGCCPF').AsInteger;

      While Not qryDadosItens.Eof Do
      Begin
        If qryDadosItens.FieldByName('DET_ESPDOC').AsString = 'IF' Then
        Begin
          If Pos('NFCE', qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString) > 0 Then
          Begin
            fatVenda.strNumDoc := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
            fatVenda.strEspDoc := 'IF';
            fatVenda.blnNovoSequencial := False;
          End
          Else
          Begin
            fatVenda.strNumDoc := '';
            fatVenda.strEspDoc := 'IF';
            fatVenda.blnNovoSequencial := True;
          End;
          Break;
        End
        Else If qryDadosItens.FieldByName('DET_ESPDOC').AsString = 'NF' Then
        Begin
          fatVenda.strNumDoc := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
          fatVenda.strEspDoc := 'NF';
          fatVenda.blnNovoSequencial := False;
          Break;
        End;
        qryDadosItens.Next;
      End;

      qryDadosItens.First;

      fatVenda.strOprFlj := 'N';
      While Not qryDadosItens.Eof Do
      Begin
        If qryDadosItens.FieldByName('FGO_OPRFLJ').AsString = 'S' Then
        Begin
          fatVenda.strOprFlj := 'S';
          Break;
        End;
        qryDadosItens.Next;
      End;

      qryDadosItens.First;
      While (Not qryDadosItens.Eof) Do
      Begin
        If (qryDadosItens.FieldByName('DET_ESPDOC').AsString = 'ML') Or
           (qryDadosItens.FieldByName('DET_PROEMB').AsString = 'S')  Then
        Begin
          //
        End
        Else
        Begin

          If qryDadosItens.FieldByName('LOT_PRECUS').AsFloat > 0 Then
          Begin
            fltPrecoCustoItem := qryDadosItens.FieldByName('LOT_PRECUS').AsFloat;
            fltPrecoMedioItem := qryDadosItens.FieldByName('ITE_PREMED').AsFloat;
            fltImpUltItem := qryDadosItens.FieldByName('ITE_IMPULT').AsFloat;
            fltPreUltItem := qryDadosItens.FieldByName('ITE_PREULT').AsFloat;
          End
          Else
          Begin
            If qryDadosItens.FieldByName('DET_PROACA').AsString = 'S' Then
            Begin
              fltPrecoCustoItem := qryDadosItens.FieldByName('ACA_PRECUS').AsFloat;
              fltPrecoMedioItem := qryDadosItens.FieldByName('ACA_PREMED').AsFloat;
              fltImpUltItem := qryDadosItens.FieldByName('ACA_IMPULT').AsFloat;
              fltPreUltItem := qryDadosItens.FieldByName('ACA_TOTULT').AsFloat;
            End
            Else
            Begin
              fltPrecoCustoItem := qryDadosItens.FieldByName('ITE_PRECUS').AsFloat;
              fltPrecoMedioItem := qryDadosItens.FieldByName('ITE_PREMED').AsFloat;
              fltImpUltItem := qryDadosItens.FieldByName('ITE_IMPULT').AsFloat;
              fltPreUltItem := qryDadosItens.FieldByName('ITE_PREULT').AsFloat;
            End;
          End;

          strImpDir := IIF(fCfgSis('IMPDIG') = '1', qryDadosItens.FieldByName('CADITE_ITE_IMPDIR').AsString, qryDadosItens.FieldByName('ITEGER_ITE_IMPDIR').AsString);
          fltIcmSaiIte := IIF(fCfgSis('IMPCF4') = 'S',
                              fatVenda.fCalculaAliquota(qryDadosItens.FieldByName('DET_CODITE').AsString, qryDadosItens.FieldByName('DET_CODEMP').AsString, strImpDir),
                              qryDadosItens.FieldByName('ITE_ICMSAI').AsFloat);

          fatVenda.pProcessarDespesasOperacionaisComplementar(qryDadosItens.FieldByName('CLI_DESOPE').AsFloat);

          If qryDadosItens.FieldByName('DET_IDEPRO').AsString <> 'NOR' Then
          Begin
            fltPrecoCusto2 := qryDadosItens.FieldByName('FDO_TOTCU2').AsFloat / qryDadosItens.FieldByName('DET_QTDITE').AsFloat;
          End
          Else
          Begin
            parPreCus := TParCalculaPrecoCusto.Create(Nil, TConfiguracao.fGetConfiguracao);
            fltPrecoCusto2 := parPreCus.fCalculaPrecoCustoRealVenda(qryDadosItens.FieldByName('DET_UNITAR').AsFloat,
                                                                    fltPrecoCustoItem,
                                                                    qryDadosItens.FieldByName('ITE_OUTVAL').AsFloat,
                                                                    fltIcmSaiIte,
                                                                    qryDadosItens.FieldByName('ITE_IMPFED').AsFloat,
                                                                    qryDadosItens.FieldByName('ITE_DESOPE').AsFloat + fatVenda.fltDesOpeCli,
                                                                    0,
                                                                    0);
            FreeAndNil(parPreCus);
          End;

          forTin.intModDil := IfNull(qryDadosItens.FieldByName('FOR_MODDIL').Value, 0);
          forTin.strTextBase := IfNull(qryDadosItens.FieldByName('FOR_TEXBAS').Value, '');
          forTin.strTipCor := IfNull(qryDadosItens.FieldByName('FOR_TIPCOR').Value, '');
          forTin.strCompB := IfNull(qryDadosItens.FieldByName('FOR_ITECOB').Value, '');
          forTin.strUniver := IfNull(qryDadosItens.FieldByName('FOR_UNIVER').Value, '');
          forTin.strCatali := IfNull(qryDadosItens.FieldByName('FOR_CATALI').Value, '');

          If Not ((Not fEmptyStr(qryDadosItens.FieldByName('DET_EMP_PD').AsString)) And
                 (qryDadosItens.FieldByName('DET_IND_PD').AsInteger > 0) And
                 (fRetUnitariosPedido(qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString,
                                      qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString,
                                      qryDadosItens.FieldByName('DET_CODITE').AsString,
                                      qryDadosItens.FieldByName('DET_UNITAR').AsFloat,
                                      qryDadosItens.FieldByName('DET_IND_PD').AsInteger,
                                      fltUnitarOri,
                                      fltUnitarVis,
                                      fltUnitarDig,
                                      fltPrecoCustoItem,
                                      fltPrecoMedioItem,
                                      fltTaxaJuros,
                                      strConPagPedido))) Then
          Begin
            fltUnitarOri := qryDadosItens.FieldByName('DET_UNITAR').AsFloat;
            fltUnitarVis := qryDadosItens.FieldByName('DET_UNITAR').AsFloat;
            fltUnitarDig := qryDadosItens.FieldByName('DET_UNITAR').AsFloat;
            fltTaxaJuros := 0;
          End;

          strEntRet := fRetornaEntregaRetiraPedido(strNumOrc, strEspOrc, strEmpOrc, qryDadosItens.FieldByName('DET_CODCLI').AsString, qryDadosItens.FieldByName('DET_CODITE').AsString);

          fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
            Nil,
            qryDadosItens.FieldByName('DET_IDEPRO').AsString,
            qryDadosItens.FieldByName('ITE_CODGRU').AsString,
            qryDadosItens.FieldByName('DET_CODITE').AsString,
            qryDadosItens.FieldByName('DET_DESCRI').AsString,
            qryDadosItens.FieldByName('DET_DESCRI').AsString,
            '',
            qryDadosItens.FieldByName('DET_UNIDAD').AsString,
            qryDadosItens.FieldByName('DET_UNIDAD').AsString,
            qryDadosItens.FieldByName('ITE_CODMAR').AsString,
            qryDadosItens.FieldByName('ITE_CODFOR').AsString,
            qryDadosItens.FieldByName('ITE_REFERE').AsString,
            fltUnitarOri,
            fltUnitarVis,
            qryDadosItens.FieldByName('DET_UNITAR').AsFloat,
            qryDadosItens.FieldByName('DET_UNITAR').AsFloat,
            0,
            qryDadosItens.FieldByName('DET_QTDITE').AsFloat,
            qryDadosItens.FieldByName('DET_TOTITE').AsFloat,
            'S',
            fltPrecoCustoItem,
            fltPrecoCustoItem * qryDadosItens.FieldByName('DET_QTDITE').AsFloat,
            qryDadosItens.FieldByName('ITE_COMLUB').AsString,
            0,
            0,
            qryDadosItens.FieldByName('ITE_PREVE1').AsFloat,
            qryDadosItens.FieldByName('ITE_PREVE2').AsFloat,
            qryDadosItens.FieldByName('ITE_PREVE3').AsFloat,
            qryDadosItens.FieldByName('ITE_PREVE4').AsFloat,
            qryDadosItens.FieldByName('ITE_PREVE5').AsFloat,
            qryDadosItens.FieldByName('ITE_PREVE6').AsFloat,
            qryDadosItens.FieldByName('ITE_PREVE7').AsFloat,
            0,
            0,
            qryDadosItens.FieldByName('ITE_INCPIS').AsString,
            qryDadosItens.FieldByName('ITE_COMVAR').AsFloat,
            qryDadosItens.FieldByName('ITE_COMATA').AsFloat,
            qryDadosItens.FieldByName('ITE_COMDIS').AsFloat,
            '',
            '',
            '',
            0,
            0,
            '',
            fFormataFloat(fltPreUltItem * qryDadosItens.FieldByName('DET_QTDITE').AsFloat, 2),
            fltImpUltItem,
            fltPreUltItem,
            fltPrecoMedioItem,
            qryDadosItens.FieldByName('ITE_CLAIPI').AsString,
            qryDadosItens.FieldByName('FDO_ITECHA').AsString,
            qryDadosItens.FieldByName('FDO_ITETIN').AsString,
            qryDadosItens.FieldByName('FDO_DESCOR').AsString,
            qryDadosItens.FieldByName('FDO_TIPPRE').AsString,
            qryDadosItens.FieldByName('FDO_LAZQUA').AsInteger,
            qryDadosItens.FieldByName('FDO_TIPEMB').AsString,
            qryDadosItens.FieldByName('FDO_QTDEMB').AsFloat,
            qryDadosItens.FieldByName('FDO_PREEMB').AsFloat,
            qryDadosItens.FieldByName('FDO_PRVTIN').AsFloat,
            qryDadosItens.FieldByName('FDO_PRCTIN').AsFloat,
            qryDadosItens.FieldByName('FDO_FATTIN').AsFloat,
            qryDadosItens.FieldByName('FDO_PROEMB').AsString,
            qryDadosItens.FieldByName('FDO_ITEEMB').AsString,
            qryDadosItens.FieldByName('FDO_PREEMB').AsFloat,
            qryDadosItens.FieldByName('FDO_PREEMB').AsFloat,
            qryDadosItens.FieldByName('ITE_CODABF').AsString,
            qryDadosItens.FieldByName('ITE_PESOIT').AsFloat,
            qryDadosItens.FieldByName('ITE_PESLIQ').AsFloat,
            qryDadosItens.FieldByName('PROMOC').AsString,
            IIF(qryDadosItens.FieldByName('PROMOC').AsString='S', qryDadosItens.FieldByName('DET_TOTCUS').AsFloat / qryDadosItens.FieldByName('DET_QTDITE').AsFloat, 0),
            IIF(qryDadosItens.FieldByName('PROMOC').AsString='S', qryDadosItens.FieldByName('DET_UNITAR').AsFloat, 0),
            qryDadosItens.FieldByName('DET_PROCVA').AsFloat,
            0,
            IIF(qryDadosItens.FieldByName('DET_IDEPRO').AsString<>'NOR', '1', ''),
            0,
            '',
            qryDadosItens.FieldByName('DET_IND_PD').AsInteger,
            0,
            strNumOrc,
            strEspOrc,
            strEmpOrc,
            qryDadosItens.FieldByName('ITE_MARMIN').AsFloat,
            qryDadosItens.FieldByName('ITE_MARMSG').AsFloat,
            qryDadosItens.FieldByName('ITE_MARMGE').AsFloat,
            '',
            '',
            0,
            0,
            qryDadosItens.FieldByName('AUTOINCREM').AsString,
            qryDadosItens.FieldByName('FDO_CATALI').AsString,
            qryDadosItens.FieldByName('FDO_LINLIN').AsString,
            qryDadosItens.FieldByName('ITE_EMBALA').AsFloat,
            '',
            'N',
            'N',
            qryDadosItens.FieldByName('ITE_PRECOM').AsFloat,
            fltUnitarDig,
            qryDadosItens.FieldByName('ITE_QTPPRO').AsFloat,
            '',
            '',
            'N',
            qryDadosItens.FieldByName('FDO_MONTAD').AsString,
            qryDadosItens.FieldByName('FDO_A_N_O_').AsString,
            fRetSiglaUnidade(qryDadosItens.FieldByName('DET_UNIDAD').AsString),
            qryDadosItens.FieldByName('FDO_VOLPRO').AsFloat,
            0,
            '',
            qryDadosItens.FieldByName('DET_CODACA').AsString,
            qryDadosItens.FieldByName('DET_EMPACA').AsString,
            qryDadosItens.FieldByName('DET_PROACA').AsString='S',
            '',
            '',
            '',
            qryDadosItens.FieldByName('ITE_OUTVAL').AsFloat,
            qryDadosItens.FieldByName('ITE_COMTB' + qryDadosItens.FieldByName('DET_TABPRE').AsString).AsFloat,
            qryDadosItens.FieldByName('ITE_DESOPE').AsFloat,
            fltIcmSaiIte,
            qryDadosItens.FieldByName('ITE_IMPFED').AsFloat,
            qryDadosItens.FieldByName('ITE_DESMGE').AsFloat,
            '',
            '',
            '',
            qryDadosItens.FieldByName('DET_TABPRE').AsString,
            0,
            0,
            qryDadosItens.FieldByName('FDO_CODDIL').AsString,
            qryDadosItens.FieldByName('FDO_PORDIL').AsFloat,
            qryDadosItens.FieldByName('FDO_DILCON').AsString,
            qryDadosItens.FieldByName('FDO_PORCAT').AsFloat,
            strEntRet,
            '',
            'N',
            '',
            0,
            0,
            qryDadosItens.FieldByName('DET_DESESP').AsFloat,
            0,
            strImpDir,
            qryDadosItens.FieldByName('ITE_LOCFIS').AsString,
            fltPrecoCusto2,
            fltPrecoCusto2 * qryDadosItens.FieldByName('DET_QTDITE').AsFloat,
            qryDadosItens.FieldByName('DET_PROCAT').AsFloat,
            qryDadosItens.FieldByName('DET_PROCDI').AsFloat,
            0,
            0,
            0,
            0,
            forTin,
            '',
            '',
            qryDadosItens.FieldByName('DET_NUMLOT').AsString,
            qryDadosItens.FieldByName('FDO_EMPPRD').AsString,
            '',
            False,
            'N',
            '',
            0,
            '',
            qryDadosItens.FieldByName('ITE_CODBAR').AsString,
            '',
            0,
            0,
            0,
            qryDadosItens.FieldByName('DET_CODEMP').AsString,
            qryDadosItens.FieldByName('FOR_FATACE').AsFloat,
            True,
            '',
            '',
            '',
            0,
            fltPrecoCustoItem,
            '',
            '',
            dadosMadeira,
            fFormataFloat(fltImpUltItem * qryDadosItens.FieldByName('DET_QTDITE').AsFloat, 2),
            0,
            fltTaxaJuros,
            '',
            0,
            '',
            '',
            0,
            0,
            '',
            '',
            0,
            qryDadosItens.FieldByName('DET_CODVEN').AsString,
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
            strCodVe2,
            'N',
            0,
            '',
            '',
            '',
            '',
            qryDadosItens.FieldByName('ITE_EXCIPI').AsString,
            qryDadosItens.FieldByName('ITE_DESMSU').AsFloat,
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
            qryDadosItens.FieldByName('FDO_OBSCOL').AsString,
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
            qryDadosItens.FieldByName('ITE_DESMVM').AsFloat,
            qryDadosItens.FieldByName('ITE_DESMSM').AsFloat,
            qryDadosItens.FieldByName('ITE_DESMGM').AsFloat,
            qryDadosItens.FieldByName('ITE_MARMMV').AsFloat,
            qryDadosItens.FieldByName('ITE_MARMMS').AsFloat,
            qryDadosItens.FieldByName('ITE_MARMMG').AsFloat);

            If (qryDadosItens.FieldByName('DET_IDEPRO').AsString <> 'NOR') And (Assigned(fDesfragmentaTintaSaldosOR)) Then
            Begin
              matrizSaldosAux := fDesfragmentaTintaSaldosOR(qryDadosItens, blnLocFor, True);
              fatVenda.pCarregardicFormulasOrcamento(matrizSaldosAux, cdsVenda.FieldByName('AUTOINCREM').AsString);
            End;
        End;

        qryDadosItens.Next;
      End;
    End;
  Finally
  End;
end;

procedure TImportaPAFECF.pCarregarModalidades;
  Var
    qryMod: TUniQuery;
    qryRcx: TUniQuery;
begin
  qryMod := fCriaQuery();
  qryRcx := fCriaQuery();
  Try
    qryMod.SQL.Add('SELECT * FROM PAFMOD WHERE MOD_ID_LOC = :ID_LOC AND MOD_ID_DOC = :ID_DOC ');
    qryMod.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
    qryMod.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
    qryMod.Open;

    qryMod.First;
    While not qryMod.Eof do
    Begin
      If (qryMod.FieldByName('MOD_CODFPG').AsString = '002') Then
        fatVenda.fltValCqP := fatVenda.fltValCqP + qryMod.FieldByName('MOD_VALMOD').AsFloat

      Else If (qryMod.FieldByName('MOD_CODFPG').AsString = '006') Then
        fatVenda.fltValCqV := fatVenda.fltValCqV + qryMod.FieldByName('MOD_VALMOD').AsFloat

      Else If Pos(qryMod.FieldByName('MOD_CODFPG').AsString, '007') > 0 Then
        fatVenda.fltValCar := fatVenda.fltValCar + qryMod.FieldByName('MOD_VALMOD').AsFloat

      Else If (qryMod.FieldByName('MOD_CODFPG').AsString = '008') Then
        fatVenda.fltFatura := fatVenda.fltFatura + qryMod.FieldByName('MOD_VALMOD').AsFloat

      Else If (qryMod.FieldByName('MOD_CODFPG').AsString = '010') Then
        fatVenda.fltValVle := fatVenda.fltValVle + qryMod.FieldByName('MOD_VALMOD').AsFloat

      Else If (qryMod.FieldByName('MOD_CODFPG').AsString = '012') Then
        fatVenda.fltValOrd := fatVenda.fltValOrd + qryMod.FieldByName('MOD_VALMOD').AsFloat

      Else If (qryMod.FieldByName('MOD_CODFPG').AsString = '013') Then
        fatVenda.fltValCre := fatVenda.fltValCre + qryMod.FieldByName('MOD_VALMOD').AsFloat

      Else If (qryMod.FieldByName('MOD_CODFPG').AsString = '016') Then
        fatVenda.fltValFin := fatVenda.fltValFin + qryMod.FieldByName('MOD_VALMOD').AsFloat

      Else If (Pos(qryMod.FieldByName('MOD_CODFPG').AsString, '014_015') <= 0) Then
        fatVenda.fltValDin := fatVenda.fltValDin + qryMod.FieldByName('MOD_VALMOD').AsFloat;

      qryMod.Next;
    End;

    qryRcx.SQL.Add('SELECT * FROM PAF_CAIXA WHERE RCX_ID_LOC = :ID_LOC AND RCX_ID_DOC = :ID_DOC ');
    qryRcx.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
    qryRcx.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
    qryRcx.Open;

    If qryRcx.IsEmpty Then
    Begin
      qryRcx.Close;
      qryRcx.SQL.Clear;
      qryRcx.SQL.Add('SELECT SUM(RCX_VALDOC) AS VALDOC FROM CADRCXX WHERE ');
      qryRcx.SQL.Add('  RCX_VALDOC < 0 AND ');
      qryRcx.SQL.Add('  RCX_ID_LOC = :ID_LOC AND ');
      qryRcx.SQL.Add('  RCX_ID_DOC = :ID_DOC ');

      qryRcx.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
      qryRcx.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
      qryRcx.Open;

      fatVenda.fltValCre := qryRcx.FieldByName('VALDOC').AsFloat;
      blnCreditoMaiorQueVenda := True;
    End;
  Finally
    FreeAndNil(qryMod);
    FreeAndNil(qryRcx);
  End;
end;

procedure TImportaPAFECF.pImportarPrincipal;
  Var
    dtaOriginal: TDateTime;
    blnTrCxPdv : Boolean;
    fltUltFec: Double;
    dtaDtaFec: TDateTime;
    dtaDtaLim: TDateTime;

  function fLockDocAtual: String;
  begin
    Result := 'IF_' + qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString + '_' +
                      qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
  end;

  function fTemMovimento(dtaDtaMov: TDateTime): Boolean;
  begin
    qryCadRcx.Close;
    qryCadRcx.ParamByName('DTAMOV').AsDateTime := dtaDtaMov;
    qryCadRcx.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCadRcx.Open;
    Result := (qryCadRcx.FieldByName('CNT').AsInteger > 0);
    qryCadRcx.Close;
  end;

begin
  blnTrCxPdv := FileExists(ExtractFilePath(Application.ExeName) + '\travarcaixa.rcx');

  fltUltFec := 0;
  dtaDtaFec := 0;
  dtaDtaLim := 0;

  If (blnTrCxPdv) Then
  Begin
    pRetornaUltimoFechamento(fltUltFec, dtaDtaFec, VS_strCodEmp);

    If (dtaDtaFec > 0) Then
    Begin
      If (dtaDtaFec >= VS_Date) Then
        Exit
      Else
      Begin
        dtaDtaLim := dtaDtaFec;

        repeat
          dtaDtaLim := IncDay(dtaDtaLim);

          If fTemMovimento(dtaDtaLim) Then
            Break;

        until (dtaDtaLim >= VS_Date);
      End;
    End
    Else
      blnTrCxPdv := False;
  End;

  qryPafPrincipal.First;
  While Not qryPafPrincipal.Eof Do
  Begin
    If VS_strLockImportacaoPDV <> fGetIdConnectionLock('IMPORTACAO_PAF_' + VS_strCodEmp, False) Then
    Begin
      Break;
    End;

    If (blnTrCxPdv) Then
    Begin
      If (qryPafPrincipal.FieldByName('PAF_DTAEMI').AsDateTime > dtaDtaLim) Then
      Begin
        qryPafPrincipal.Next;
        Continue;
      End;
    End;

    if (fJaExisteCadFis()) then
    begin
      qryPafPrincipal.Edit;
      qryPafPrincipal.FieldByName('PAF_EXPORT').AsInteger := 1;
      qryPafPrincipal.Post;
      qryPafPrincipal.Next;
      pStep(1);
      Continue;
    end;

    pDestravaLockForcado(fLockDocAtual, 60);

    If fLock_Unlock(fLockDocAtual, True, False, False, '', False) Then
    Begin
      dtaOriginal := VS_Date;
      Try
        If Not fVerificaInconsistenciasDados(qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString,
                                             qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString) Then
        Begin
          VS_Date := qryPafPrincipal.FieldByName('PAF_DTAEMI').AsDateTime;
          pImportarDocumento;
        End;
      Finally
        VS_Date := dtaOriginal;
        fLock_Unlock(fLockDocAtual, False, False, False, '', False)
      End;
    End
    Else
    Begin
      Sleep(3000);
    End;

    qryPafPrincipal.Next;
    pStep(1);
  End;
end;

procedure TImportaPAFECF.pMarcarComoNaoConferido;
  Var
    qryUpd: TUniQuery;
begin
  qryUpd := fCriaQuery();
  Try
    qryUpd.SQL.Add('UPDATE PAF_PRINCIPAL SET PAF_CONFER = 0 WHERE PAF_ID_LOC = :ID_LOC AND PAF_ID_DOC = :ID_DOC');
    qryUpd.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
    qryUpd.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
    qryUpd.ExecSQL;
  Finally
    FreeAndNil(qryUpd);
  End;
end;

procedure TImportaPAFECF.pRealizarPreValidacaoItens;
  Var
    qryCaixa: TUniQuery;
begin
  qryCaixa := fCriaQuery;
  Try
    If Not fTemCaixa(qryCaixa) Then
    Begin
      pMarcarComoNaoConferido;
      Raise Exception.Create('Dados para gravação do caixa não encontrado. ID: ' + fFormataIdLocal);
    End;
    pValidaMovimentoAuxiliar(qryCaixa);
  Finally
    FreeAndNil(qryCaixa);
  End;
end;

procedure TImportaPAFECF.pRetInfoPedido(strIdLoc, strIdDoc: String; var strAutInc, strOrcEsp: String);
  Var
    qryAux: TUniQuery;
begin
  strAutInc := '';
  strOrcEsp := 'N';
  qryAux := fCriaQuery(Nil);
  Try
    With qryAux Do
    Begin
      SQL.Add(' SELECT FATGOR.AUTOINCREM, ');
      SQL.Add('        FATGOR.FGO_ESPDOC, ');
      SQL.Add(' IFNULL(EXTGOR.FGO_ORCESP, "N") AS FGO_ORCESP ');
      SQL.Add('   FROM DAVPVG ');
      SQL.Add('   JOIN FATGOR ON DPG_NUMDOC = FATGOR.FGO_NUMDOC ');
      SQL.Add('              AND DPG_ESPDOC = FATGOR.FGO_ESPDOC ');
      SQL.Add('              AND DPG_CODEMP = FATGOR.FGO_CODEMP ');
      SQL.Add('              AND DPG_CODCLI = FATGOR.FGO_CODCLI ');
      SQL.Add('   LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ');
      SQL.Add('  WHERE DPG_COO_CF = :ID_DOC ');
      SQL.Add('    AND DPG_SER_CF = :ID_LOC ');
      ParamByName('ID_DOC').AsString := strIdDoc;
      ParamByName('ID_LOC').AsString := strIdLoc;
      Open;

      If (Not IsEmpty) Then
      Begin
        strAutInc := FieldByName('AUTOINCREM').AsString;

        If (FieldByName('FGO_ESPDOC').AsString = 'OR') And (FieldByName('FGO_ORCESP').AsString = 'S') Then
          strOrcEsp := 'S'
        Else
          strOrcEsp := 'N';
      End;

      Close;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TImportaPAFECF.pRetornaDadosORPD(strNumCoo, strNumSer: String;
  var strNumDoc, strEspDoc, strCodEmp, strCodCnd, strCodRep, strCodDiv, strCodVe2, strMsgPd1, strMsgPd2: String;
  Var cdsProfiss: TUniClientDataSet);
  Var
    qryOrc,
    qryGen: TUniQuery;
    dspProfiss: TUniDataSetProvider;
    strProfis: String;
begin
  qryOrc := fCriaQuery;
  Try
    qryOrc.SQL.Add('SELECT ');
    qryOrc.SQL.Add('  DPG_NUMDOC, ');
    qryOrc.SQL.Add('  DPG_ESPDOC, ');
    qryOrc.SQL.Add('  DPG_CODEMP, ');
    qryOrc.SQL.Add('  DPG_CODCND, ');

    qryOrc.SQL.Add('  (SELECT ');
    qryOrc.SQL.Add('     COALESCE(FDO_CODREP, "") ');
    qryOrc.SQL.Add('   FROM ');
    qryOrc.SQL.Add('     FATDOR ');
    qryOrc.SQL.Add('   WHERE ');
    qryOrc.SQL.Add('     FDO_NUMDOC = DPG_NUMDOC AND ');
    qryOrc.SQL.Add('     FDO_ESPDOC = DPG_ESPDOC AND ');
    qryOrc.SQL.Add('     FDO_CODEMP = DPG_CODEMP AND ');
    qryOrc.SQL.Add('     FDO_CODCLI = DPG_CODCLI LIMIT 1) AS DPG_CODREP, ');

    qryOrc.SQL.Add('  (SELECT ');
    qryOrc.SQL.Add('     COALESCE(FDO_CODVE2, "") ');
    qryOrc.SQL.Add('   FROM ');
    qryOrc.SQL.Add('     FATDOR ');
    qryOrc.SQL.Add('   WHERE ');
    qryOrc.SQL.Add('     FDO_NUMDOC = DPG_NUMDOC AND ');
    qryOrc.SQL.Add('     FDO_ESPDOC = DPG_ESPDOC AND ');
    qryOrc.SQL.Add('     FDO_CODEMP = DPG_CODEMP AND ');
    qryOrc.SQL.Add('     FDO_CODCLI = DPG_CODCLI LIMIT 1) AS DPG_CODVE2, ');

    qryOrc.SQL.Add('  (SELECT ');
    qryOrc.SQL.Add('     COALESCE(FDO_SEQGER, "") ');
    qryOrc.SQL.Add('   FROM ');
    qryOrc.SQL.Add('     FATDOR ');
    qryOrc.SQL.Add('   WHERE ');
    qryOrc.SQL.Add('     FDO_NUMDOC = DPG_NUMDOC AND ');
    qryOrc.SQL.Add('     FDO_ESPDOC = DPG_ESPDOC AND ');
    qryOrc.SQL.Add('     FDO_CODEMP = DPG_CODEMP AND ');
    qryOrc.SQL.Add('     FDO_CODCLI = DPG_CODCLI LIMIT 1) AS AUTOINCREM, ');

    qryOrc.SQL.Add('  (SELECT ');
    qryOrc.SQL.Add('     COALESCE(FDO_CODDIV, "") ');
    qryOrc.SQL.Add('   FROM ');
    qryOrc.SQL.Add('     FATDOR ');
    qryOrc.SQL.Add('   WHERE ');
    qryOrc.SQL.Add('     FDO_NUMDOC = DPG_NUMDOC AND ');
    qryOrc.SQL.Add('     FDO_ESPDOC = DPG_ESPDOC AND ');
    qryOrc.SQL.Add('     FDO_CODEMP = DPG_CODEMP AND ');
    qryOrc.SQL.Add('     FDO_CODCLI = DPG_CODCLI LIMIT 1) AS DPG_CODDIV, ');

    qryOrc.SQL.Add('  (SELECT ');
    qryOrc.SQL.Add('     COALESCE(FGO_MEN001, "") ');
    qryOrc.SQL.Add('   FROM ');
    qryOrc.SQL.Add('     FATGOR ');
    qryOrc.SQL.Add('   WHERE ');
    qryOrc.SQL.Add('     FGO_NUMDOC = DPG_NUMDOC AND ');
    qryOrc.SQL.Add('     FGO_ESPDOC = DPG_ESPDOC AND ');
    qryOrc.SQL.Add('     FGO_CODEMP = DPG_CODEMP AND ');
    qryOrc.SQL.Add('     FGO_CODCLI = DPG_CODCLI LIMIT 1) AS DPG_MEN001, ');

    qryOrc.SQL.Add('  (SELECT ');
    qryOrc.SQL.Add('     COALESCE(FGO_MEN002, "") ');
    qryOrc.SQL.Add('   FROM ');
    qryOrc.SQL.Add('     FATGOR ');
    qryOrc.SQL.Add('   WHERE ');
    qryOrc.SQL.Add('     FGO_NUMDOC = DPG_NUMDOC AND ');
    qryOrc.SQL.Add('     FGO_ESPDOC = DPG_ESPDOC AND ');
    qryOrc.SQL.Add('     FGO_CODEMP = DPG_CODEMP AND ');
    qryOrc.SQL.Add('     FGO_CODCLI = DPG_CODCLI LIMIT 1) AS DPG_MEN002 ');

    qryOrc.SQL.Add('FROM ');
    qryOrc.SQL.Add('  DAVPVG ');
    qryOrc.SQL.Add('WHERE ');
    qryOrc.SQL.Add('  DPG_COO_CF = :NUMCCF AND ');
    qryOrc.SQL.Add('  DPG_SER_CF = :NUMSER ');

    qryOrc.ParamByName('NUMCCF').AsString := strNumCoo;
    qryOrc.ParamByName('NUMSER').AsString := strNumSer;
    qryOrc.Open;

    strNumDoc := qryOrc.FieldByName('DPG_NUMDOC').AsString;
    strEspDoc := qryOrc.FieldByName('DPG_ESPDOC').AsString;
    strCodEmp := qryOrc.FieldByName('DPG_CODEMP').AsString;
    strCodCnd := qryOrc.FieldByName('DPG_CODCND').AsString;
    strCodRep := qryOrc.FieldByName('DPG_CODREP').AsString;
    strCodVe2 := qryOrc.FieldByName('DPG_CODVE2').AsString;
    strMsgPd1 := qryOrc.FieldByName('DPG_MEN001').AsString;
    strMsgPd2 := qryOrc.FieldByName('DPG_MEN002').AsString;

    strCodDiv := '';
    If Assigned(cdsProfiss) Then
      FreeAndNil(cdsProfiss);

    If (fCfgSis('NROPRO') = '2') Then
      strCodDiv := qryOrc.FieldByName('DPG_CODDIV').AsString
    Else If (fCfgSis('NROPRO') = '3') Then
    Begin
      qryGen := fCriaQuery;

      dspProfiss := TUniDataSetProvider.Create(Nil);
      dspProfiss.DataSet := qryGen;

      cdsProfiss := TUniClientDataSet.Create(Nil);
      cdsProfiss.SetProvider(dspProfiss);

      strProfis := '';
      strProfis := strProfis + ' SELECT ';
      strProfis := strProfis + '   F.DIV_CODDIV, ';
      strProfis := strProfis + '   D.DIV_NOMDIV, ';
      strProfis := strProfis + '   D.DIV_CODATI, ';
      strProfis := strProfis + '   A.ATI_DESATI ';
      strProfis := strProfis + ' FROM ';
      strProfis := strProfis + '   DIVFAT F, ';
      strProfis := strProfis + '   CADDIV D, ';
      strProfis := strProfis + '   CADATI A  ';
      strProfis := strProfis + ' WHERE  ';
      strProfis := strProfis + '   F.DIV_CODDIV = D.DIV_CODDIV AND ';
      strProfis := strProfis + '   D.DIV_CODATI = A.ATI_CODATI AND  ';
      strProfis := strProfis + '   F.DIV_SEQGER = :AUTINC ';

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strProfis);
      qryGen.ParamByName('AUTINC').AsString := qryOrc.FieldByName('AUTOINCREM').AsString;
      qryGen.Open;

      pSetaClient(qryGen);

      If Not qryGen.IsEmpty Then
        cdsProfiss.Open;

      FreeAndNil(qryGen);
    End;
  Finally
    FreeAndNil(qryOrc);
  End;
end;

function TImportaPAFECF.fRetornaEntregaRetiraPedido(strNumPed, strEspPed,
  strEmpPed, strCliPed, strCodIte: String): String;
Var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.Close;
    qryAux.SQL.Text := 'SELECT '+
                       '  EXT.FDO_ENTRET '+
                       'FROM '+
                       '  FATDOR FDO '+
                       '  JOIN EXTDOR EXT '+
                       '    ON EXT.FDO_SEQFDO = FDO.AUTOINCREM '+
                       'WHERE FDO.FDO_NUMDOC = :NUMDOC '+
                       '  AND FDO.FDO_ESPDOC = :ESPDOC '+
                       '  AND FDO.FDO_CODEMP = :CODEMP '+
                       '  AND FDO.FDO_CODCLI = :CODCLI '+
                       '  AND FDO.FDO_CODITE = :CODITE ';

    qryAux.ParamByName('NUMDOC').AsString := strNumPed;
    qryAux.ParamByName('ESPDOC').AsString := strEspPed;
    qryAux.ParamByName('CODEMP').AsString := strEmpPed;
    qryAux.ParamByName('CODCLI').AsString := strCliPed;
    qryAux.ParamByName('CODITE').AsString := strCodIte;
    qryAux.Open;

    Result := qryAux.FieldByName('FDO_ENTRET').AsString;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TImportaPAFECF.fRetUnitariosPedido(strIdLoc, strIdDoc, strCodIte: String; fltUnitar: Double;
  intSeqPd: Integer; var fltUnitarOri, fltUnitarVis, fltUnitarDig,
  fltPreCus, fltPreMed, fltTaxaJuros: Double; Var strConPag: String): Boolean;
  Var
    qryAux: TUniQuery;
    strQtdDec: String;

  function fSQLRetUnitPed(blnUsaSeqInd: Boolean; blnUsaUnitar: Boolean): String;
  begin
    Result := '';
    Result := Result + ' SELECT FGO_CONPAG, ';
    Result := Result + '        FGO_CODFPG, ';
    Result := Result + '        FDO_UNIORI, ';
    Result := Result + '        FDO_UNIVIS, ';
    Result := Result + '        FDO_TAXJUR, ';
    Result := Result + '        FDO_UNIDIG, ';
    Result := Result + '        ROUND(FDO_TOTCUS / FDO_QTDITE, ' + strQtdDec + ') AS CUSTO, ';
    Result := Result + '        ROUND(FDO_TOTMED / FDO_QTDITE, ' + strQtdDec + ') AS MEDIO ';
    Result := Result + '   FROM DAVPVD ';
    Result := Result + '   JOIN DAVPVG ON DAVPVG.AUTOINCREM = DPD_SEQGER ';
    Result := Result + '   JOIN FATDOR ON DPG_NUMDOC = FDO_NUMDOC ';
    Result := Result + '              AND DPG_ESPDOC = FDO_ESPDOC ';
    Result := Result + '              AND DPG_CODEMP = FDO_CODEMP ';
    Result := Result + '              AND DPD_CODITE = FDO_CODITE ';
    Result := Result + '              AND DPD_SEQIND = FDO_SEQIND ';
    Result := Result + '   JOIN FATGOR ON FGO_NUMDOC = FDO_NUMDOC ';
    Result := Result + '              AND FGO_ESPDOC = FDO_ESPDOC ';
    Result := Result + '              AND FGO_CODEMP = FDO_CODEMP ';
    Result := Result + '              AND FGO_CODCLI = FDO_CODCLI ';
    Result := Result + '   LEFT JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ';
    Result := Result + '  WHERE DPG_COO_CF = :ID_DOC ';
    Result := Result + '    AND DPG_SER_CF = :ID_LOC ';
    Result := Result + '    AND DPD_CODITE = :CODITE ';

    If (blnUsaSeqInd) Then
      Result := Result + '  AND DPD_SEQIND = :SEQIND ';

    If (blnUsaUnitar) Then
      Result := Result + '  AND DPD_UNITAR = :UNITAR ';
  end;

  procedure pAtribuirValores;
  begin
    fltUnitarVis := qryAux.FieldByName('FDO_UNIVIS').AsFloat;
    fltTaxaJuros := qryAux.FieldByName('FDO_TAXJUR').AsFloat;
    fltUnitarOri := qryAux.FieldByName('FDO_UNIORI').AsFloat;
    fltUnitaRDig := qryAux.FieldByName('FDO_UNIDIG').AsFloat;
    fltPreCus := qryAux.FieldByName('CUSTO').AsFloat;
    fltPreMed := qryAux.FieldByName('MEDIO').AsFloat;
    strConPag := qryAux.FieldByName('FGO_CONPAG').AsString;
  end;

  procedure pSetParams;
  begin
    qryAux.ParamByName('ID_DOC').AsString := strIdDoc;
    qryAux.ParamByName('ID_LOC').AsString := strIdLoc;
    qryAux.ParamByName('CODITE').AsString := strCodIte;

    If qryAux.Params.FindParam('SEQIND') <> Nil Then
      qryAux.ParamByName('SEQIND').AsInteger := intSeqPd;

    If qryAux.Params.FindParam('UNITAR') <> Nil Then
      qryAux.ParamByName('UNITAR').AsFloat := fltUnitar;
  end;

begin
  strQtdDec := fCfgSis('DECUNI');

  qryAux := fCriaQuery(Nil);
  Try
    Result := False;

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add( fSQLRetUnitPed(True, False) );
    pSetParams;
    qryAux.Open;

    If (Not qryAux.IsEmpty) Then
    Begin
      pAtribuirValores;
      Result := True;
    End
    Else
    Begin
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add( fSQLRetUnitPed(False, False) );
      pSetParams;
      qryAux.Open;

      If (Not qryAux.IsEmpty) And (qryAux.RecordCount = 1) Then
      Begin
        pAtribuirValores;
        Result := True;
      End
      Else
      Begin
        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add(fSQLRetUnitPed(False, True));
        pSetParams;
        qryAux.Open;

        If (Not qryAux.IsEmpty) Then
        Begin
          pAtribuirValores;
          Result := True;
        End;
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TImportaPAFECF.pSetMax(intMax: Integer);
begin
  If Assigned(FProgresso) Then
  Begin
    FProgresso.Max := intMax;
    FProgresso.Position := 0;
  End;
end;

procedure TImportaPAFECF.pStep(intStep: Integer);
begin
  If Assigned(FProgresso) Then
    FProgresso.StepBy(intStep);
end;

procedure TImportaPAFECF.pUtilizaIcmsGravado;
  Var
    intContador: Integer;
begin
  If (qryDadosItens.IsEmpty) Then
    Exit;

  For intContador := Low(fatVenda.arrMatItens) To High(fatVenda.arrMatItens) Do
  Begin
    qryDadosItens.First;
    While (Not qryDadosItens.Eof) Do
    Begin
      If qryDadosItens.FieldByName('AUTOINCREM').AsString = fatVenda.arrMatItens[intContador].strSeqDet Then
      Begin
        With fatVenda.arrMatItens[intContador] Do
        Begin
          strCodFis := qryDadosItens.FieldByName('DET_CODFIS').AsString;
          fltDesEsp := qryDadosItens.FieldByName('DET_DESESP').AsFloat;
          fltBasIcm := qryDadosItens.FieldByName('DET_BASICM').AsFloat;
          fltAlqIcm := qryDadosItens.FieldByName('DET_ALQICM').AsFloat;
          fltValIcm := qryDadosItens.FieldByName('DET_VALICM').AsFloat;

          If Pos(strCodFis, '010_070_') > 0 Then
          Begin
            strCodFis := '060';
        End;
        End;
        Break;
      End;

      qryDadosItens.Next;
    End;
  End;
end;

procedure TImportaPAFECF.pValidaMovimentoAuxiliar(qryCaixa: TUniQuery);
  Var
    qryMca: TUniQuery;
    qryChq: TUniQuery;

    strMsg: String;
begin
  strMsg := '';

  If qryCaixa.FieldByName('RCX_CARREC').AsFloat > 0 Then
  Begin
    qryMca := fCriaQuery;
    qryMca.SQL.Add('SELECT SUM(MCA_VALSTA) AS VAL FROM PAF_CARTOES ');
    qryMca.SQL.Add('WHERE ');
    qryMca.SQL.Add('  MCA_ID_LOC = :ID_LOC AND MCA_ID_DOC = :ID_DOC ');
    qryMca.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
    qryMca.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
    qryMca.Open;

    If fFormataFloat(qryMca.FieldByName('VAL').AsFloat, 2) <> fFormataFloat(qryCaixa.FieldByName('RCX_CARREC').AsFloat, 2) Then
    Begin
      strMsg := strMsg + 'Os registros de cartão de credito não foram exportados corretamente. ';
    End;

    FreeAndNil(qryMca);
  End;

  If qryCaixa.FieldByName('RCX_CHQPRE').AsFloat+qryCaixa.FieldByName('RCX_CHQAVI').AsFloat > 0 Then
  Begin
    qryChq := fCriaQuery;
    qryChq.SQL.Add('SELECT SUM(CHQ_VALCHQ) AS VAL FROM PAF_CHEQUES ');
    qryChq.SQL.Add('WHERE ');
    qryChq.SQL.Add('  CHQ_ID_LOC = :ID_LOC AND CHQ_ID_DOC = :ID_DOC ');
    qryChq.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
    qryChq.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
    qryChq.Open;

    If fFormataFloat(qryChq.FieldByName('VAL').AsFloat, 2) <>
       fFormataFloat(qryCaixa.FieldByName('RCX_CHQPRE').AsFloat+qryCaixa.FieldByName('RCX_CHQAVI').AsFloat, 2) Then
    Begin
      strMsg := strMsg + 'Os registros de cheques não foram exportados corretamente. ';
    End;

    FreeAndNil(qryChq);
  End;

  If Not fEmptyStr(strMsg) Then
  Begin
    pMarcarComoNaoConferido;
    Raise Exception.Create(strMsg + 'ID: ' + fFormataIdLocal);
  End;
end;

procedure TImportaPAFECF.pAcertaDigDuplicParaCreditoEModalidades;
  Var
    fltTotDup: Double;
    intContador: Integer;
begin
  If (fFormataFloat(fatVenda.fltTotGer, 2) > fFormataFloat(fatVenda.fltCredUtilizados, 2)) And
     (fatVenda.fltCredUtilizados > 0)                                                      Then
  Begin
    fltTotDup := fatVenda.fltTotGer - fatVenda.fltCredUtilizados;
    
    fDigDuplic(fatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses(fatVenda.strConPag), 0, fltTotDup,
                                             FAlse, False, False, VS_Date, False,
                                             0, 'N', True, False, 0,
                                             False, Nil, '', fCfgSis('FSDUDP', varBoolean),
                                             True, Nil, '', False, True, '', '', Nil, False, False, Nil, False, False, 0, '', fatVenda.strCodCid );
    fatVenda.intSeqDupBaiUtiCred := 1;

    For intContador := High(fatVenda.arrDuplicata)-1 DownTo 1 Do
    Begin
      fatVenda.arrDuplicata[intContador+1] := fatVenda.arrDuplicata[intContador];
    End;

    fatVenda.arrDuplicata[1].strSequen := 'A';
    fatVenda.arrDuplicata[1].curValor  := fatVenda.fltCredUtilizados;
    fatVenda.arrDuplicata[1].dtaDtaVen := DateToStr(VS_Date);

  End
end;

procedure TImportaPAFECF.pSetaZerDin;
Var
  blnCalcDigDuplic: Boolean;
  function fGetValorAVista: Double;
  begin
    Result := fatVenda.fltValDin +
              fatVenda.fltValCqP +
              fatVenda.fltValCqV +
              fatVenda.fltValCar +
              fatVenda.fltValFin +
              fatVenda.fltValOrd +
              fatVenda.fltVlARec +
              fatVenda.fltCredUtilizados;
  end;
begin
  blnCalcDigDuplic := True;
  fatVenda.intSeqDupBaiUtiCred := -1;

  If (fatVenda.strCodFpg = '009') Then
  Begin
    fatVenda.blnZerDin := False;

    If (fatVenda.fltFatura > 0) Or (fatVenda.fltValVle > 0) Then
    Begin
      If (fFormataFloat(fGetValorAVista, 2) > 0) Then
      Begin
        blnCalcDigDuplic := False;

        If fFormataFloat(fatVenda.fltFatura + fatVenda.fltValVle, 2) > 0 Then
        Begin
          If fatVenda.fltCredUtilizados > 0 Then
          Begin
            If fFormataFloat(fGetValorAVista,2) = fFormataFloat(fatVenda.fltCredUtilizados,2) Then
            begin
              fatVenda.blnZerDin := True;
              fatVenda.intSeqDupBaiUtiCred := 0;
            end;
          End;
        End;
      End;
    End;
  End;

  If (blnCalcDigDuplic) Then
    pAcertaDigDuplicParaCreditoEModalidades
end;

procedure TImportaPAFECF.pApagaRegistrosCaixaSemValorESemLigacao;
  Var
    qryAux: TUniQuery;
    strSeqCon: String;
    strAutoIncrem: String;
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add('SELECT RCX_SEQCON, AUTOINCREM FROM CADRCXX WHERE ');
    qryAux.SQL.Add('  RCX_ID_LOC = :ID_LOC AND ');
    qryAux.SQL.Add('  RCX_ID_DOC = :ID_DOC AND ');
    qryAux.SQL.Add('  RCX_VALDOC > 0 AND ');
    qryAux.SQL.Add('  RCX_DINREC+RCX_CARREC+RCX_CHQPRE+RCX_CHQAVI+RCX_ORDREC = 0 ');

    qryAux.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
    qryAux.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
    qryAux.Open;

    If Not qryAux.IsEmpty Then
    Begin
      strSeqCon := qryAux.FieldByName('RCX_SEQCON').AsString;
      strAutoIncrem := qryAux.FieldByName('AUTOINCREM').AsString;

      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT ');
      qryAux.SQL.Add('  COUNT(*) AS QTD ');
      qryAux.SQL.Add('FROM ');
      qryAux.SQL.Add('  CADRCXX ');
      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  RCX_SEQCON = :SEQCON AND ');
      qryAux.SQL.Add('  RCX_CODEMP = :CODEMP AND ');
      qryAux.SQL.Add('  AUTOINCREM <> :AUTINC ');

      qryAux.ParamByName('SEQCON').AsString := strSeqCon;
      qryAux.ParamByName('CODEMP').AsString := qryPafPrincipal.FieldByName('PAF_CODEMP').AsString;
      qryAux.ParamByName('AUTINC').AsString := strAutoIncrem;
      qryAux.Open;

      If qryAux.FieldByName('QTD').AsInteger = 0 Then
      Begin
        qryAux.SQL.Clear;
        qryAux.SQL.Add('DELETE FROM CADRCXX WHERE ');
        qryAux.SQL.Add('  RCX_ID_LOC = :ID_LOC AND ');
        qryAux.SQL.Add('  RCX_ID_DOC = :ID_DOC AND ');
        qryAux.SQL.Add('  RCX_VALDOC > 0 AND ');
        qryAux.SQL.Add('  RCX_DINREC+RCX_CARREC+RCX_CHQPRE+RCX_CHQAVI+RCX_ORDREC = 0 AND ');
        qryAux.SQL.Add('  AUTOINCREM = :AUTINC ');

        qryAux.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
        qryAux.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
        qryAux.ParamByName('AUTINC').AsString := strAutoIncrem;
        qryAux.ExecSQL;
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TImportaPAFECF.pApagarRegistrosCaixaUtilizacaoCreditoMaiorVenda;
  Var
    qryRcx: TUniQuery;

    blnRcxIf: Boolean;
    blnRcxPdv: Boolean;
begin
  If Not blnCreditoMaiorQueVenda Then
  Begin
    Exit;
  End;

  qryRcx := fCriaQuery;
  Try
    qryRcx.SQL.Add('SELECT COUNT(*) AS QTD FROM CADRCXX WHERE ');
    qryRcx.SQL.Add('  RCX_NUMDOC = :NUMDOC AND ');
    qryRcx.SQL.Add('  RCX_ESPDOC = :ESPDOC AND ');
    qryRcx.SQL.Add('  RCX_CODEMP = :CODEMP AND ');
    qryRcx.SQL.Add('  RCX_CODCLI = :CODCLI AND ');
    qryRcx.SQL.Add('  RCX_VALDOC > 0 AND ');
    qryRcx.SQL.Add('  RCX_DINREC+RCX_CARREC+RCX_CHQPRE+RCX_CHQAVI+RCX_ORDREC = 0 ');

    qryRcx.ParamByName('NUMDOC').AsString := fatVenda.strNumDoc;
    qryRcx.ParamByName('ESPDOC').AsString := fatVenda.strEspDoc;
    qryRcx.ParamByName('CODEMP').AsString := qryPafPrincipal.FieldByName('PAF_CODEMP').AsString;
    qryRcx.ParamByName('CODCLI').AsString := fatVenda.strCodCli;
    qryRcx.Open;

    blnRcxIf := qryRcx.FieldByName('QTD').AsInteger > 0;

    qryRcx.Close;
    qryRcx.SQL.Clear;
    qryRcx.SQL.Add('SELECT COUNT(*) AS QTD FROM CADRCXX WHERE ');
    qryRcx.SQL.Add('  RCX_ID_LOC = :ID_LOC AND ');
    qryRcx.SQL.Add('  RCX_ID_DOC = :ID_DOC AND ');
    qryRcx.SQL.Add('  RCX_NUMDOC LIKE "F%" AND ');
    qryRcx.SQL.Add('  RCX_VALDOC > 0 AND ');
    qryRcx.SQL.Add('  RCX_DINREC+RCX_CARREC+RCX_CHQPRE+RCX_CHQAVI+RCX_ORDREC = 0 ');

    qryRcx.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
    qryRcx.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
    qryRcx.Open;

    blnRcxPdv := qryRcx.FieldByName('QTD').AsInteger > 0;

    If (blnRcxIf And blnRcxPdv) Then
    Begin
      qryRcx.Close;
      qryRcx.SQL.Clear;
      qryRcx.SQL.Add('DELETE FROM CADRCXX WHERE ');
      qryRcx.SQL.Add('  RCX_ID_LOC = :ID_LOC AND ');
      qryRcx.SQL.Add('  RCX_ID_DOC = :ID_DOC AND ');
      qryRcx.SQL.Add('  RCX_NUMDOC LIKE "F%" AND ');
      qryRcx.SQL.Add('  RCX_VALDOC > 0 AND ');
      qryRcx.SQL.Add('  RCX_DINREC+RCX_CARREC+RCX_CHQPRE+RCX_CHQAVI+RCX_ORDREC = 0 ');

      qryRcx.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
      qryRcx.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
      qryRcx.ExecSQL;
    End;
  Finally
    FreeAndNil(qryRcx);
  End;
end;

procedure TImportaPAFECF.pAtualizaChaveAcesso(dtaDataOriginal: TDateTime);
  Var
    qryAcesso: TUniQuery;
    strAcesso: String;
begin
  Sleep(60000);
  qryAcesso := fCriaQuery();
  Try
    qryAcesso.SQL.Add('SELECT NFE_ACESSO FROM LOGNFE WHERE ');
    qryAcesso.SQL.Add('  NFE_NUMDOC = :NUMDOC AND ');
    qryAcesso.SQL.Add('  NFE_ESPDOC = :ESPDOC AND ');
    qryAcesso.SQL.Add('  NFE_CODEMP = :CODEMP AND ');
    qryAcesso.SQL.Add('  NFE_CODCLI = :CODCLI ');

    qryAcesso.ParamByName('NUMDOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
    qryAcesso.ParamByName('ESPDOC').AsString := fatVenda.strEspDoc;
    qryAcesso.ParamByName('CODEMP').AsString := qryPafPrincipal.FieldByName('PAF_CODEMP').AsString;;
    qryAcesso.ParamByName('CODCLI').AsString := fatVenda.strCodCli;
    qryAcesso.Open;

    strAcesso := qryAcesso.FieldByName('NFE_ACESSO').AsString;

    qryAcesso.SQL.Clear;
    qryAcesso.SQL.Add('UPDATE CADFIS SET FIS_ACESSO = :ACESSO, FIS_DTAENT = :DTAENT WHERE ');
    qryAcesso.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
    qryAcesso.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
    qryAcesso.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
    qryAcesso.SQL.Add('  FIS_FORCLI = :CODCLI ');

    qryAcesso.ParamByName('DTAENT').AsDateTime := dtaDataOriginal;
    qryAcesso.ParamByName('ACESSO').AsString := strAcesso;

    qryAcesso.ParamByName('NUMDOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
    qryAcesso.ParamByName('ESPDOC').AsString := fatVenda.strEspDoc;
    qryAcesso.ParamByName('CODEMP').AsString := qryPafPrincipal.FieldByName('PAF_CODEMP').AsString;
    qryAcesso.ParamByName('CODCLI').AsString := fatVenda.strCodCli;
    qryAcesso.ExecSQL;
  Finally
    FreeAndNil(qryAcesso);
  End;
end;

procedure TImportaPAFECF.pAtualizaDadosCupom;
  Var
    qryUpd: TUniQuery;
    qrySel: TUniQuery;
    dtaDataOriginal: TDateTime;
begin
  If qryDadosItens.IsEmpty Then
    Exit;

  qryUpd := fCriaQuery;
  qrySel := fCriaQuery;

  Try
    dtaDataOriginal := qryDadosItens.FieldByName('DET_DTAENT').AsDateTime;

    qrySel.SQL.Clear;
    qrySel.SQL.Add('SELECT COUNT(*) AS QTD FROM CADREC WHERE   ');
    qrySel.SQL.Add('  CTR_ID_LOC = :ID_LOC AND ');
    qrySel.SQL.Add('  CTR_ID_DOC = :ID_DOC ');
    qrySel.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
    qrySel.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
    qrySel.Open;

    If qrySel.FieldByName('QTD').AsInteger > 0 Then
    Begin
      qryUpd.SQL.Clear;
      qryUpd.SQL.Add('UPDATE CADREC SET ');
      qryUpd.SQL.Add('  CTR_SEQCON = :SEQGER ');
      qryUpd.SQL.Add('WHERE ');
      qryUpd.SQL.Add('  CTR_ID_LOC = :ID_LOC AND ');
      qryUpd.SQL.Add('  CTR_ID_DOC = :ID_DOC ');

      qryUpd.ParamByName('SEQGER').AsInteger := fatVenda.intSeqCon;
      qryUpd.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
      qryUpd.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
      qryUpd.ExecSQL;
    End;

    qrySel.SQL.Clear;
    qrySel.SQL.Add('SELECT COUNT(*) AS QTD FROM CADRCXX WHERE   ');
    qrySel.SQL.Add('  RCX_ID_LOC = :ID_LOC AND ');
    qrySel.SQL.Add('  RCX_ID_DOC = :ID_DOC AND ');
    qrySel.SQL.Add('  (RCX_DINREC+RCX_CARREC+RCX_CHQPRE+RCX_CHQAVI+RCX_ORDREC) = 0 AND RCX_VALCRE = 0 ');
    qrySel.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
    qrySel.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
    qrySel.Open;

    If qrySel.FieldByName('QTD').AsInteger > 0 Then
    Begin
      qryUpd.SQL.Clear;
      qryUpd.SQL.Add('UPDATE CADRCXX SET ');
      qryUpd.SQL.Add('  RCX_SEQCON = :SEQCON ');
      qryUpd.SQL.Add('WHERE ');
      qryUpd.SQL.Add('  RCX_ID_LOC = :ID_LOC AND ');
      qryUpd.SQL.Add('  RCX_ID_DOC = :ID_DOC AND ');
      qryUpd.SQL.Add('  (RCX_DINREC+RCX_CARREC+RCX_CHQPRE+RCX_CHQAVI+RCX_ORDREC) = 0 AND RCX_VALCRE = 0 ');

      qryUpd.ParamByName('SEQCON').AsInteger := fatVenda.intSeqCon;
      qryUpd.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
      qryUpd.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;

      qryUpd.ExecSQL;
    End;

    qrySel.SQL.Clear;
    qrySel.SQL.Add('SELECT COUNT(*) AS QTD FROM CADRCXX WHERE   ');
    qrySel.SQL.Add('  RCX_ID_LOC = :ID_LOC AND ');
    qrySel.SQL.Add('  RCX_ID_DOC = :ID_DOC AND ');
    qrySel.SQL.Add('  (RCX_DINREC+RCX_CARREC+RCX_CHQPRE+RCX_CHQAVI+RCX_ORDREC) = 0 AND RCX_VALCRE > 0 ');
    qrySel.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
    qrySel.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
    qrySel.Open;

    If qrySel.FieldByName('QTD').AsInteger > 0 Then
    Begin
      qryUpd.SQL.Clear;
      qryUpd.SQL.Add('UPDATE CADRCXX SET ');
      qryUpd.SQL.Add('  RCX_NUMDOC = :NUMDOC, ');
      qryUpd.SQL.Add('  RCX_NUMDUP = :NUMDOC, ');
      qryUpd.SQL.Add('  RCX_SEQCON = :SEQCON ');
      qryUpd.SQL.Add('WHERE ');
      qryUpd.SQL.Add('  RCX_ID_LOC = :ID_LOC AND ');
      qryUpd.SQL.Add('  RCX_ID_DOC = :ID_DOC AND ');
      qryUpd.SQL.Add('  (RCX_DINREC+RCX_CARREC+RCX_CHQPRE+RCX_CHQAVI+RCX_ORDREC) = 0 AND RCX_VALCRE > 0 ');

      qryUpd.ParamByName('SEQCON').AsInteger := fatVenda.intSeqCon;
      qryUpd.ParamByName('NUMDOC').AsString := fatVenda.strNumDoc;
      qryUpd.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
      qryUpd.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;

      qryUpd.ExecSQL;
    End;

    If (fatVenda.strEspDoc <> 'IF') Or (Pos('NFCE', qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString) > 0) Then
    Begin
      pAtualizaChaveAcesso(dtaDataOriginal);
    End
    Else
    Begin
      qryUpd.SQL.Clear;
      qryUpd.SQL.Add('UPDATE CADFIS SET ');
      qryUpd.SQL.Add('  FIS_NUMSER = :NUMSER, ');
      qryUpd.SQL.Add('  FIS_NUMCOO = :NUMCOO ');
      qryUpd.SQL.Add('WHERE ');
      qryUpd.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
      qryUpd.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
      qryUpd.SQL.Add('  FIS_CODEMP = :CODEMP ');

      qryUpd.ParamByName('NUMSER').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
      qryUpd.ParamByName('NUMCOO').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;

      qryUpd.ParamByName('NUMDOC').AsString := fatVenda.strNumDoc;
      qryUpd.ParamByName('ESPDOC').AsString := fatVenda.strEspDoc;
      qryUpd.ParamByName('CODEMP').AsString := qryPafPrincipal.FieldByName('PAF_CODEMP').AsString;
      qryUpd.ExecSQL;
    End;
  Finally
    FreeAndNil(qryUpd);
    FreeAndNil(qrySel);
  End;
end;

procedure TImportaPAFECF.pAtualizaTabelasPAF;
  Var
    qryUpd: TUniQuery;
    qryRcx: TUniQuery;
begin
  qryUpd := fCriaQuery;
  qryRcx := fCriaQuery;

  Try
    qryUpd.SQL.Clear;
    qryUpd.SQL.Add('UPDATE PAF_PRINCIPAL SET ');
    qryUpd.SQL.Add('  PAF_EXPORT = 1 ');
    qryUpd.SQL.Add('WHERE ');
    qryUpd.SQL.Add('  PAF_ID_LOC = :ID_LOC AND PAF_ID_DOC = :ID_DOC ');

    qryUpd.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
    qryUpd.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
    qryUpd.ExecSQL;

    If (Not qryDadosItens.IsEmpty) Then
    Begin
      qryUpd.SQL.Clear;
      qryUpd.SQL.Add('DELETE FROM MOVDET WHERE AUTOINCREM = :AUTINC ');

      qryDadosItens.First;
      While Not qryDadosItens.Eof Do
      Begin
        qryUpd.ParamByName('AUTINC').AsString := qryDadosItens.FieldByName('AUTOINCREM').AsString;
        qryUpd.ExecSQL;

        qryDadosItens.Next;
      End;

      qryRcx.SQL.Clear;
      qryRcx.SQL.Add('SELECT AUTOINCREM FROM CADRCXX ');
      qryRcx.SQL.Add('WHERE ');
      qryRcx.SQL.Add('  RCX_ID_LOC = :ID_LOC AND RCX_ID_DOC = :ID_DOC AND ');
      qryRcx.SQL.Add('  (RCX_DINREC+RCX_CARREC+RCX_CHQPRE+RCX_CHQAVI+RCX_ORDREC) > 0');
      qryRcx.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
      qryRcx.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
      qryRcx.Open;

      While (Not qryRcx.Eof) Do
      Begin
        qryUpd.SQL.Clear;
        qryUpd.SQL.Add('DELETE FROM CADRCXX ');
        qryUpd.SQL.Add('WHERE ');
        qryUpd.SQL.Add('  AUTOINCREM = :AUTINC AND ');
        qryUpd.SQL.Add('  RCX_ID_LOC = :ID_LOC AND RCX_ID_DOC = :ID_DOC AND ');
        qryUpd.SQL.Add('  (RCX_DINREC+RCX_CARREC+RCX_CHQPRE+RCX_CHQAVI+RCX_ORDREC) > 0');

        qryUpd.ParamByName('AUTINC').AsString := qryRcx.FieldByName('AUTOINCREM').AsString;
        qryUpd.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
        qryUpd.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
        qryUpd.ExecSQL;

        qryRcx.Next;
      End;

      qryUpd.SQL.Clear;
      qryUpd.SQL.Add('DELETE FROM MOVGER WHERE AUTOINCREM = :AUTINC ');
      qryUpd.ParamByName('AUTINC').AsString := qryDadosItens.FieldByName('AUTINC_GER').AsString;
      qryUpd.ExecSQL;

      pApagaRegistrosCaixaSemValorESemLigacao;
      pApagarRegistrosCaixaUtilizacaoCreditoMaiorVenda;
      pCopiarRegistroCaixaReferenteACreditoDoPDV;
    End;
  Finally
    FreeAndNil(qryUpd);
    FreeAndNil(qryRcx);
  End;
end;

procedure TImportaPAFECF.pCarregaCartoes;
  Var
    qryCartoes: TUniQuery;
begin
  qryCartoes := fCriaQuery;
  Try
    qryCartoes.SQL.Add('SELECT * FROM PAF_CARTOES ');
    qryCartoes.SQL.Add('JOIN CADCAR ON CAR_CODCAR = MCA_CODCAR ');
    qryCartoes.SQL.Add('WHERE MCA_ID_LOC = :ID_LOC AND MCA_ID_DOC = :ID_DOC ');
    qryCartoes.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
    qryCartoes.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
    qryCartoes.Open;

    SetLength(fatVenda.arrCartoes, qryCartoes.RecordCount);
    While (Not qryCartoes.Eof) Do
    Begin
      With fatVenda.arrCartoes[qryCartoes.RecNo-1] Do
      Begin
        fltPerDes := IIF(qryCartoes.FieldByName('CAR_TIPTAX').AsString.ToUpper = 'P',
                         qryCartoes.FieldByName('CAR_PERDES').AsFloat,
                         (qryCartoes.FieldByName('CAR_PERDES').AsFloat / qryCartoes.FieldByName('MCA_VALSTA').AsFloat) * 100);
        intCodSeq := qryCartoes.FieldByName('MCA_CODSEQ').AsInteger;
        strCodCar := qryCartoes.FieldByName('MCA_CODCAR').AsString;
        fltValDig := qryCartoes.FieldByName('MCA_VALSTA').AsFloat;
        fltValDes := fFormataFloat(fCalculaValDocCartao(fltValDig,
                                                        fltPerDes), 2);
        strCndPag := qryCartoes.FieldByName('MCA_CNDPAG').AsString;
        strTipCar := qryCartoes.FieldByName('MCA_TIPCAR').AsString;
        strNumNsu := fPadL(qryCartoes.FieldByName('MCA_NUMNSU').AsString, 14, '0');
        strNumCcd := qryCartoes.FieldByName('MCA_NUMCCD').AsString;
        strConteudoArquivo := qryCartoes.FieldByName('MCA_ESPTEF').AsString;
        strCodOpe := qryCartoes.FieldByName('MCA_CODOPE').AsString;
        If Not qryCartoes.FieldByName('MCA_DTACAD').IsNull Then
          dtaDtaCad := qryCartoes.FieldByName('MCA_DTACAD').AsDateTime
        Else
          dtaDtaCad := 0;
      End;

      qryCartoes.Next;
    End;
  Finally
    FreeAndNil(qryCartoes);
  End;
end;

procedure TImportaPAFECF.pCarregaCheques;
  Var
    qryCheques: TUniQuery;
    strCampo: String;

  procedure pCopiar(cdsChq: TUniClientDataSet);
    Var
      intContador: Integer;
  begin
    cdsChq.Append;
    For intContador := 0 To qryCheques.FieldCount -1 Do
    Begin
      strCampo := qryCheques.Fields[intContador].FieldName;

      If Pos(strCampo, 'CHQ_ID_LOC, CHQ_ID_DOC, CHQ_EXPORT, CHQ_DUPLIC') <= 0 Then
      Begin
        cdsChq.FieldByName(strCampo).Value := qryCheques.FieldByName(strCampo).Value;
      End;
    End;

    If (cdsChq.FindField('CHQ_NAODEP') <> Nil) And
       (fEmptyStr(cdsChq.FieldByName('CHQ_NAODEP').AsString)) Then
      cdsChq.FieldByName('CHQ_NAODEP').AsString := 'N';

    cdsChq.Post;
  end;
begin
  qryCheques := fCriaQuery;
  Try
    qryCheques.SQL.Add('SELECT * FROM PAF_CHEQUES ');
    qryCheques.SQL.Add('WHERE CHQ_ID_LOC = :ID_LOC AND CHQ_ID_DOC = :ID_DOC ');
    qryCheques.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
    qryCheques.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
    qryCheques.Open;

    While Not qryCheques.Eof Do
    Begin
      If qryCheques.FieldByName('CHQ_DTACAD').AsDateTime <> qryCheques.FieldByName('CHQ_DTAVEN').AsDateTime Then
      Begin
        pCopiar(fatVenda.cdsChequePre);
      End
      Else
      Begin
        pCopiar(fatVenda.cdsChequeVis);
      End;

      qryCheques.Next;
    End;
  Finally
    FreeAndNil(qryCheques);
  End;
end;

procedure TImportaPAFECF.pCarregaDadosCliente;
  Var
    qryCli: TUniQuery;
begin
  qryCli := fCriaQuery(Nil);
  Try
    qryCli.SQL.Add('SELECT ');
    qryCli.SQL.Add('  CLI_CODCLI, CLI_NOMCLI, CLI_NOMCLI, CLI_ENDNUM, CLI_ENDCOM, ');
    qryCli.SQL.Add('  CLI_ENDERE, CLI_ENDNUM, CLI_ENDCOM, CLI_BAIRRO, CLI_C_E_P_, ');
    qryCli.SQL.Add('  CLI_CODCID, CLI_FONE01, CLI_EMAIL3, CLI_EMAIL2, CLI_CLUFID, ');
    qryCli.SQL.Add('  CLI_CLIFID, CLI_CODATI, CLI_CODATI, CLI_NUMR_G, CLI_C_G_C_, ');
    qryCli.SQL.Add('  CLI_OBSERV, CLI_CODEAC ');
    qryCli.SQL.Add('FROM ');
    qryCli.SQL.Add('  CADCLI ');
    qryCli.SQL.Add('WHERE ');
    qryCli.SQL.Add('  CLI_CODCLI = :CODCLI ');
    qryCli.ParamByName('CODCLI').AsString := fatVenda.strCodCli;

    qryCli.Open;

    If Not qryCli.IsEmpty Then
    Begin
      fatVenda.strCodCli := qryCli.FieldByName('CLI_CODCLI').AsString;
      fatVenda.strCliNom := qryCli.FieldByName('CLI_NOMCLI').AsString;
      fatVenda.strCliOri := qryCli.FieldByName('CLI_NOMCLI').AsString;
      fatVenda.strCliCgc := qryCli.FieldByName('CLI_C_G_C_').AsString;

      fatVenda.strCliNum := qryCli.FieldByName('CLI_ENDNUM').AsString;
      fatVenda.strCliCom := qryCli.FieldByName('CLI_ENDCOM').AsString;
      fatVenda.strCliEnd := qryCli.FieldByName('CLI_ENDERE').AsString + ', ' +
                            qryCli.FieldByName('CLI_ENDNUM').AsString + '  ' +
                            qryCli.FieldByName('CLI_ENDCOM').AsString;

      fatVenda.strCliBai := qryCli.FieldByName('CLI_BAIRRO').AsString;
      fatVenda.strCliCep := qryCli.FieldByName('CLI_C_E_P_').AsString;
      fatVenda.strCodCid := qryCli.FieldByName('CLI_CODCID').AsString;
      fatVenda.strCliTel := qryCli.FieldByName('CLI_FONE01').AsString;
      fatVenda.strCliEma := qryCli.FieldByName('CLI_EMAIL3').AsString;
      fatVenda.strCliEm2 := qryCli.FieldByName('CLI_EMAIL2').AsString;
      fatVenda.strCluFid := qryCli.FieldByName('CLI_CLUFID').AsString;
      fatVenda.strCliFid := qryCli.FieldByName('CLI_CLIFID').AsString;

      fatVenda.strCliCid := fRetNomCidade(fatVenda.strCodCid);
      fatVenda.strCliEst := fRetNomCidade(fatVenda.strCodCid, 1);

      fatVenda.strCliAti := qryCli.FieldByName('CLI_CODATI').AsString;
      fatVenda.blnConstr := (fAtividadeConstrutora(qryCli.FieldByName('CLI_CODATI').AsString));
      fatVenda.strCli_Rg := qryCli.FieldByName('CLI_NUMR_G').AsString;

      fatVenda.strObserv := qryCli.FieldByName('CLI_OBSERV').AsString;

      fatVenda.strCliDAc := qryCli.FieldByName('CLI_CODEAC').AsString;

      If Not fEmptyStr(qryPafPrincipal.FieldByName('PAF_NOMCLI').AsString) Then
         fatVenda.strCliNom := qryPafPrincipal.FieldByName('PAF_NOMCLI').AsString;

      If Not fEmptyStr(qryPafPrincipal.FieldByName('PAF_ENDERE').AsString) THen
         fatVenda.strCliEnd := qryPafPrincipal.FieldByName('PAF_ENDERE').AsString;

      If Not fEmptyStr(qryPafPrincipal.FieldByName('PAF_CGCCLI').AsString) THen
         fatVenda.strCliCgc := qryPafPrincipal.FieldByName('PAF_CGCCLI').AsString;
    End
    Else
      Raise Exception.Create('Cliente não encontrado: ' + fatVenda.strCodCli);
  Finally
    FreeAndNil(qryCli);
  End;
end;

procedure TImportaPAFECF.pCarregaDesEsp;
  Var
    intContador: Integer;
begin
  If (qryDadosItens.IsEmpty) Then
    Exit;

  fatVenda.fltDesEsp := 0;
  For intContador := Low(fatVenda.arrMatItens) To High(fatVenda.arrMatItens) Do
  Begin
    qryDadosItens.First;
    While (Not qryDadosItens.Eof) Do
    Begin
      If qryDadosItens.FieldByName('AUTOINCREM').AsString = fatVenda.arrMatItens[intContador].strSeqDet Then
      Begin
        With fatVenda.arrMatItens[intContador] Do
        Begin
          fatVenda.fltDesEsp := fatVenda.fltDesEsp + qryDadosItens.FieldByName('DET_DESESP').AsFloat;
        End;
        Break;
      End;
      qryDadosItens.Next;
    End;
  End;
end;

procedure TImportaPAFECF.pCarregaDuplicatas(strCndOriginal: String);
  Var
    intContador: Integer;
    intNumPar: Integer;
    blnRecalculaComValor: Boolean;
    fltValAvi: Double;
    fltValor: Double;
    arrDuplicataTmp: Array[0..23] Of TArrDigDuplic;
begin
  blnRecalculaComValor := False;
  If (qryPafPrincipal.FieldByName('PAF_CODFPG').AsString = '009') And
     (fatVenda.strConPag = '02000001') And
     (Not fEmptyStr(strCndOriginal)) And
     (LeftStr(strCndOriginal, 2) <> '01') And
     (Length(strCndOriginal) > 5) And
     (fltVlrConCupom > 0) Then
  Begin
    intNumPar := StrToInt(LeftStr(strCndOriginal, 2)) - 1;
    If intNumPar > 0 Then
    Begin
      fatVenda.strConPag := fStrZero(intNumPar, 2) + Copy(strCndOriginal, 6, Length(strCndOriginal));
      blnRecalculaComValor := True;
    End;
  End;

  pZeraDigDuplic(fatVenda.arrDuplicata);

  If Not blnRecalculaComValor Then
  Begin
    fDigDuplic(fatVenda.arrDuplicata, fatVenda.strConPag,
      0, 0, False, False, False, qryDadosItens.FieldByName('DET_DTAENT').AsDateTime,
      False);

    For intContador := Low(fatVenda.arrDuplicata) To High(fatVenda.arrDuplicata) Do
    Begin
      if (intContador+1) > 12 then
        Break;

      fatVenda.arrDuplicata[intContador].curValor := qryDadosItens.FieldByName('GER_VPAR' + fStrZero(intContador+1, 2)).AsFloat;
    End;
  End
  Else
  Begin
    fltValAvi := fatVenda.fltValDin +
                 fatVenda.fltValCqP +
                 fatVenda.fltValCqV +
                 fatVenda.fltValCar +
                 fatVenda.fltValFin +
                 fatVenda.fltValOrd;
    fltValor := fltVlrConCupom - fltValAvi;

    fDigDuplic(fatVenda.arrDuplicata, fatVenda.strConPag,
      0, fltValor, False, False, False, qryDadosItens.FieldByName('DET_DTAENT').AsDateTime,
      False);

    For intContador := Low(fatVenda.arrDuplicata) To High(fatVenda.arrDuplicata) Do
    Begin
      arrDuplicataTmp[intContador] := fatVenda.arrDuplicata[intContador];
    End;

    fatVenda.strConPag := strCndOriginal;

    fDigDuplic(fatVenda.arrDuplicata, fatVenda.strConPag,
      0, 0, False, False, False, qryDadosItens.FieldByName('DET_DTAENT').AsDateTime,
      False);

    fatVenda.arrDuplicata[0].curValor := fltValAvi;

    For intContador := Low(fatVenda.arrDuplicata)+1 To High(fatVenda.arrDuplicata) Do
    Begin
      fatVenda.arrDuplicata[intContador].curValor := arrDuplicataTmp[intContador-1].curValor;
    End;
  End;
end;

procedure TImportaPAFECF.pCarregaDuplicatasCreditoBaixadas;
  Var
    qryRec: TUniQuery;
begin
  qryRec := fCriaQuery;
  Try
    qryRec.SQL.Add('SELECT ');
    qryRec.SQL.Add('  "CADREC" AS TABELA, ');
    qryRec.SQL.Add('  AUTOINCREM AS AUTINC, ');
    qryRec.SQL.Add('  CTR_VALREC AS TOTCRE ');
    qryRec.SQL.Add('FROM ');
    qryRec.SQL.Add('  CADREC ');
    qryRec.SQL.Add('WHERE ');
    qryRec.SQL.Add('  CTR_ID_LOC = :ID_LOC AND CTR_ID_DOC = :ID_DOC ');

    qryRec.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
    qryRec.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
    qryRec.Open;

    fatVenda.fltCredUtilizados := 0;

    While (Not qryRec.Eof) Do
    Begin
      fatVenda.fltCredUtilizados := fatVenda.fltCredUtilizados + qryRec.FieldByName('TOTCRE').AsFloat;
      fatVenda.stlDupCreditos.Add(qryRec.FieldByName('AUTINC').AsString);
      qryRec.Next;
    End;
  Finally
    FreeAndNil(qryRec);
  End;
end;

procedure TImportaPAFECF.pCarregaLogVar;
  Var
    qryLogVar: TUniQuery;
begin
  qryLogVar := fCriaQuery(Nil);
  Try
    qryLogVar.SQL.Add('SELECT * FROM PAF_LOGVAR WHERE LOG_ID_LOC = :ID_LOC AND LOG_ID_DOC = :ID_DOC');
    qryLogVar.ParamByName('ID_LOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_LOC').AsString;
    qryLogVar.ParamByName('ID_DOC').AsString := qryPafPrincipal.FieldByName('PAF_ID_DOC').AsString;
    qryLogVar.Open;

    While Not qryLogVar.Eof Do
    Begin
      pGravaLogVarPAF(qryLogVar.FieldByName('LOG_DIRACE').AsString,
        qryLogVar.FieldByName('LOG_OPELIB').AsString,
        qryLogVar.FieldByName('LOG_CODVEN').AsString,
        qryLogVar.FieldByName('LOG_CODDIG').AsString,
        qryLogVar.FieldByName('LOG_CODCLI').AsString,
        qryLogVar.FieldByName('LOG_DTACAD').AsDateTime,
        qryLogVar.FieldByName('LOG_HORCAR').AsDateTime,
        qryLogVar.FieldByName('LOG_OBSERV').AsString);

      qryLogVar.Next;
    End;
  Finally
    FreeAndNil(qryLogVar);
  End;
end;

procedure TImportaPAFECF.pGravaLogVarPAF(strDirAce, strOpeLib, strCodOpe, strCodDig, strCodCli: String;
  dtaDtaCad, dtaHorCad: TDateTime; strObserv: String);
  Var
    qryGen: TUniQuery;
    strAutInc: String;
Begin
  fStartTransaction;

  qryGen := fCriaQuery;
  Try
    With qryGen, SQL Do
    Begin
      Close;
      Clear;
      Add('INSERT INTO LOGVAR (');
      Add('  AUTOINCREM,');
      Add('  LOG_INFORM,');
      Add('  LOG_OPELIB,');
      Add('  LOG_CODVEN,');
      Add('  LOG_CODDIG,');
      Add('  LOG_CODEMP,');
      Add('  LOG_DTAPED,');
      Add('  LOG_HORPED,');
      Add('  LOG_CODCLI ');
      Add(') VALUES (');
      Add('  :AUTOIN,');
      Add('  :INFORM,');
      Add('  :OPELIB,');
      Add('  :CODVEN,');
      Add('  :CODDIG,');
      Add('  :CODEMP,');
      Add('  :DTAPED,');
      Add('  :HORPED,');
      Add('  :CODCLI ');
      Add(')');

      strAutInc := fRetAutoIncrem('LOGVAR',VS_strCodEmp);

      ParamByName('AUTOIN').AsString := strAutInc;
      ParamByName('INFORM').AsString := strObserv;
      ParamByName('OPELIB').AsString := strOpeLib;

      If Not fEmptyStr(strCodOpe) Then
        ParamByName('CODVEN').AsString := strCodOpe;

      If Not fEmptyStr(strCodDig) Then
        ParamByName('CODDIG').AsString := strCodDig;

      If fEmptyStr(strCodDig) Or (Not fCfgSis('USADIG', varBoolean)) Then
        ParamByName('CODDIG').Clear;

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('DTAPED').AsDate   := VS_Date;
      ParamByName('HORPED').AsTime   := fTime();
      ParamByName('CODCLI').AsString := strCodCli;

      Try

        ExecSQL;

        If RowsAffected = 0 Then
        Begin
          fRollBack;
          Raise Exception.Create('Falha na gravação do Log da senha de liberação (LOGVAR). Por favor tente novamente.');
        End;

        If (RowsAffected > 0) Then
          fCommit;
      Except
        On E: Exception Do
        Begin
          fRollBack;
          Raise Exception.Create('Falha na gravação do Log da senha de liberação (LOGVAR). Por favor tente novamente.' + #13#10 + E.Message);
        End;
      End;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
End;


function fArqInatividade: String;
begin
  Result := ExtractFilePath(Application.ExeName) + '\INATIVIDADE_' + VS_strCodEmp + '.TXT';
end;

function fLockInatividade: String;
begin
  Result := 'TESTE_INATIVIDADE_' + VS_strCodEmp;
end;

function fIdLockAtividade: Integer;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add('SELECT IS_USED_LOCK("IMPORTACAO_PAF_' + VS_strCodEmp + '")');
    qryAux.Open;

    If qryAux.Fields[0].IsNull Then
    Begin
      Result := -1;
    End
    Else
    Begin
      Result := qryAux.Fields[0].AsInteger;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure pTestaInatividade;
  function fHoraInicio(const strArq: String): TDateTime;
    Var
      stlArq: TStringList;
  begin
    stlArq := TStringList.Create;
    stlArq.LoadFromFile(strArq);
    If stlArq.Count > 0 Then
    Begin
      Result := StrToDateTimeDef(stlArq[0], 0);
    End
    Else
    Begin
      Result := 0;
    End;
    FreeAndNil(stlArq);
  end;

  procedure pCriaArquivoInatividade;
    Var
      stlArq: TStringList;
  begin
    stlArq := TStringList.Create;
    stlArq.Add(DateTimeToStr(VS_Date + fTime()));
    stlArq.SaveToFile(fArqInatividade);
    FreeAndNil(stlArq);
  end;

begin
  pDestravaLockForcado(fLockInatividade);
  If fLock_Unlock(fLockInatividade, True, False, False, '', False) Then
  Begin
    Try
      If MinutesBetween(fNow(), VS_dtaUltimaExecucaoImportadorPDV) >= TEMPO_EXECUCAO_IMPORTADOR_PDV+5 Then
      Begin
        Try
          TerminateProcess(VS_objProcessoImportadorPDV.hProcess, 0);
          VS_dtaUltimaExecucaoImportadorPDV := fNow();
        Except
        End;
      End;
    Finally
      fLock_Unlock(fLockInatividade, False, False, False, '', False);
    End;
  End;
end;

end.
