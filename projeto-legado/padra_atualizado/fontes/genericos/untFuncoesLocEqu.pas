unit untFuncoesLocEqu;

interface

uses
  SysUtils, Classes, Controls, StrUtils, Uni, untTypesLocEqu;

  function fTpSitEquipamentoLocacaoToStr(const aTipoEquipamento: TTpEquipamentoLocacao): String;
  function fStrTipoEquipamentoLocacaoToTpEquipamentoLocacao(const strTipEquipamento: String): TTpEquipamentoLocacao;
  function fObtemDescricaoSitEquipamentoLocacao(const aSituacao: String): String;
  function fRetDescAcessorio(const strCodAcl: String): String;
  function fTipoCalculoVlLocacaoToStrTipoCalculoVlLocacao(const aTipoCalculo: TTipoCalculoValorLocacao): String;
  function fStrTipoCalculoVlLocacaoToTipoCalculoVlLocacao(const strTipoCalculo: String): TTipoCalculoValorLocacao;
  function fTipoCalculoVlLocacao(const aTipoCalculo: String): String;
  function fStrSituacaoContratoToStatusSituacaoContrato(const strStatus: String): TStatusContratoLocacao;
  function fStrSituacaoContrato(const aSituacaoContrato: String): String;
  function fStatusSituacaoContratoToStrSituacaoContrato(const aStatus: TStatusContratoLocacao): string;
  function fRetornaUltimoDiaMes(const aMesRef: String): TDateTime;
  function fRetornaPrimeiroDiaMes(const aMesRef: String): TDateTime;
  function fObtemData(const aData: TDateTime): TDateTime;
  function fObtemHora(const aData: TDateTime): TDateTime;
  function fNotaEntradaLocEquipamentoExiste(strNumDoc, strEspDoc,
             strSerie, strCliFor, strCodEmp, strTip_FC: String): Boolean;
  function fObtemDtaIniMes(const aMes: String): TDateTime;
  function fObtemDtaFiniMes(const aMes: String): TDateTime;
  function fValidaTravasContrato(const strAutInc: String; blnExibeMsg: Boolean = True): Boolean;
  function fValidaTravasEdicaoContrato(const strAutInc: String; blnExibeMsg: Boolean = True): Boolean;
  function fValidaTravasFaturamentoContrato(const strAutInc: String; blnExibeMsg: Boolean = True): Boolean;
  function fValidaTravasManutencaoContrato(const strAutInc: String; blnExibeMsg: Boolean = True): Boolean;
  function fRetNroContratoPelaFatura(const strEmpDoc, strEspDoc, strNumDoc: String): String;
  function fVerificaConsultaDadosCobranca(const strDocRef, strCodCli, strCodVen, strCodCnd, strCndPag, strForPag: String; strSenVen: String = ''; blnPedeSenha: Boolean = True): Boolean;
  function ValidaConfiguracoesLocEqu: Boolean;

implementation

uses
  untFuncoesSimples, DateUtils, untLiberacao, untConstantes;

function fTpSitEquipamentoLocacaoToStr(const aTipoEquipamento: TTpEquipamentoLocacao): String;
Begin
  Try
    Result := arrTpEquipamentoLocacao[aTipoEquipamento];
  Except
    Result := EmptyStr
  End;
End;

function fStrTipoEquipamentoLocacaoToTpEquipamentoLocacao(const strTipEquipamento: String): TTpEquipamentoLocacao;
Begin
  Case AnsiIndexStr(UpperCase(strTipEquipamento), arrTpEquipamentoLocacao) Of
    1 : Result := tpAcessorio
    Else
      Result := tpPrincipal;
  End;
End;

function fObtemDescricaoSitEquipamentoLocacao(const aSituacao: String): String;
Begin
  Result := '';

  Case AnsiIndexStr(UpperCase(aSituacao), arrTpSituacaoEquipamentoLocacao) Of
    0 : Result := 'ATIVO';
    1 : Result := 'INATIVO';
    2 : Result := 'BLOQUEADO';
  End;
End;

function fRetDescAcessorio(const strCodAcl: String): String;
Begin
  Result := fCampoTabela('ACL_DESCRI', 'CADACL', ['ACL_CODIGO'], [strCodAcl], False);
End;

function fTipoCalculoVlLocacaoToStrTipoCalculoVlLocacao(const aTipoCalculo: TTipoCalculoValorLocacao): String;
Begin
  Try
    Result := arrTpCalculoVlLocacao[aTipoCalculo];
  Except
    Result := EmptyStr
  End;
End;

function fStrTipoCalculoVlLocacaoToTipoCalculoVlLocacao(const strTipoCalculo: String): TTipoCalculoValorLocacao;
Begin
  Case AnsiIndexStr(UpperCase(strTipoCalculo), arrTpCalculoVlLocacao) Of
    1 : Result := tpDiaria;
    3 : Result := tpMensal
    Else
      Result := tpHoras;
  End;
End;

function fTipoCalculoVlLocacao(const aTipoCalculo: String): String;
Begin
  Result := '';

  Case AnsiIndexStr(UpperCase(aTipoCalculo), arrTpCalculoVlLocacao) Of
    1 : Result := 'DIÁRIAS';
    3 : Result := 'MESES'
  Else
    Result := 'HORAS';
  End;
End;

function fStrSituacaoContratoToStatusSituacaoContrato(const strStatus: String): TStatusContratoLocacao;
Begin
  Case AnsiIndexStr(UpperCase(strStatus), arrSitContratoLocacao) Of
    1 : Result := stOrcamento;
    2 : Result := stAtivo;
    3 : Result := stFaturado;
    4 : Result := stCancelado
    Else
      Result := stNone;
  End;
End;

function fStrSituacaoContrato(const aSituacaoContrato: String): String;
Begin
  Result := '';

  Case AnsiIndexStr(UpperCase(aSituacaoContrato), arrSitContratoLocacao) Of
    1 : Result := 'ORÇAMENTO';
    2 : Result := 'ATIVO';
    3 : Result := 'FATURADO';
    4 : Result := 'CANCELADO'
  Else
    Result := '';
  End;
End;

function fStatusSituacaoContratoToStrSituacaoContrato(const aStatus: TStatusContratoLocacao): string;
Begin
  Result := fStrSituacaoContrato(arrSitContratoLocacao[aStatus]);
End;

function fRetornaUltimoDiaMes(const aMesRef: String): TDateTime;
var
  strPrimeiroDiaMes: String;
  dtaPrimeiroDiaMes: TDateTime;
  dtaUltimoDiaMes: TDateTime;
  strUltimoDiaMes: String;
Begin
  dtaUltimoDiaMes := 0;
  Try
    Try
      If fEmptyStr( aMesRef ) Then
      Begin
        Result := 0;
        Exit;
      End;

      strPrimeiroDiaMes := '01/' + aMesRef;
      dtaPrimeiroDiaMes := StrToDateTime(strPrimeiroDiaMes);

      strUltimoDiaMes := IntToStr(DaysInMonth(dtaPrimeiroDiaMes)) + '/' + aMesRef;
      dtaUltimoDiaMes := StrToDateTime(strUltimoDiaMes);
    Except
      dtaUltimoDiaMes := 0;
    End;
  Finally
    Result := dtaUltimoDiaMes;
  End;
End;

function fRetornaPrimeiroDiaMes(const aMesRef: String): TDateTime;
var
  strPrimeiroDiaMes: String;
  dtaPrimeiroDiaMes: TDateTime;
Begin
  dtaPrimeiroDiaMes := 0;

  Try
    Try
      If fEmptyStr( aMesRef ) Then
      Begin
        Result := 0;
        Exit;
      End;

      strPrimeiroDiaMes := '01/' + aMesRef;
      dtaPrimeiroDiaMes := StrToDateTime(strPrimeiroDiaMes);
    Except
      dtaPrimeiroDiaMes := 0;
    End;
  Finally
    Result := dtaPrimeiroDiaMes;
  End;
End;

function fObtemData(const aData: TDateTime): TDateTime;
Begin
  Try
    Result := StrToDateTime(FormatDateTime('dd/mm/yyyy', aData));
  Except
    Result := aData;
  End;
End;

function fObtemHora(const aData: TDateTime): TDateTime;
Begin
  Try
    Result := StrToDateTime(FormatDateTime('hh:mm', aData));
  Except
    Result := aData;
  End;
End;

function fObtemDtaIniMes(const aMes: String): TDateTime;
Begin
  Result := fRetornaPrimeiroDiaMes(aMes);
End;

function fObtemDtaFiniMes(const aMes: String): TDateTime;
Begin
  Result := fRetornaUltimoDiaMes(aMes);
End;

function fNotaEntradaLocEquipamentoExiste(strNumDoc, strEspDoc,
  strSerie, strCliFor, strCodEmp, strTip_FC: String): Boolean;
Var
  strAutinc: String;
begin
  strAutinc := fCampoTabela('AUTOINCREM',
                             'MOVGER',
                             ['GER_NUMDOC',
                               'GER_ESPDOC',
                               'GER_SERIE_',
                               IIF(strTip_FC = 'C', 'GER_CODCLI', 'GER_CODFOR'),
                               'GER_CODEMP',
                               'GER_TIP_FC'],
                             [strNumDoc,
                               strEspDoc,
                               strSerie,
                               strCliFor,
                               strCodEmp,
                               strTip_FC]);

  Result := (Not fEmptyStr(strAutinc));
end;

function fValidaTravasEdicaoContrato(const strAutInc: String;
  blnExibeMsg: Boolean = True): Boolean;
Begin
  Result := True;

  If Not fEmptyStr(fGetHostLock(cst_TRAVA_CADCTR_LOCEQU + strAutInc)) Then
  Begin
    If blnExibeMsg Then
      fMensagem('ATENÇÃO', 'Essa operação já está em andamento em outra estação: ' + fGetHostLock(cst_TRAVA_CADCTR_LOCEQU + strAutInc), ['&Ok']);
    Result := False;
    Exit;
  End;

  If Not fEmptyStr(fGetHostLock(cst_TRAVA_PRORRO_LOCEQU + strAutInc)) Then
  Begin
    If blnExibeMsg Then
      fMensagem('ATENÇÃO', 'Essa operação já está em andamento em outra estação: ' + fGetHostLock(cst_TRAVA_PRORRO_LOCEQU + strAutInc), ['&Ok']);
    Result := False;
    Exit;
  End;

  If Not fEmptyStr(fGetHostLock(cst_TRAVA_INSPEC_LOCEQU + strAutInc)) Then
  Begin
    If blnExibeMsg Then
      fMensagem('ATENÇÃO', 'Essa operação já está em andamento em outra estação: ' + fGetHostLock(cst_TRAVA_INSPEC_LOCEQU + strAutInc), ['&Ok']);
    Result := False;
    Exit;
  End;
End;

function fValidaTravasFaturamentoContrato(const strAutInc: String;
  blnExibeMsg: Boolean = True): Boolean;
Begin
  Result := True;

  If Not fEmptyStr(fGetHostLock(cst_TRAVA_FATMEN_LOCEQU + strAutInc)) Then
  Begin
    If blnExibeMsg Then
      fMensagem('ATENÇÃO', 'Essa operação já está em andamento em outra estação: ' + fGetHostLock(cst_TRAVA_FATMEN_LOCEQU + strAutInc), ['&Ok']);
    Result := False;
    Exit;
  End;

  If Not fEmptyStr(fGetHostLock(cst_TRAVA_FATURA_LOCEQU + strAutInc)) Then
  Begin
    If blnExibeMsg Then
      fMensagem('ATENÇÃO', 'Essa operação já está em andamento em outra estação: ' + fGetHostLock(cst_TRAVA_FATURA_LOCEQU + strAutInc), ['&Ok']);
    Result := False;
    Exit;
  End;

  If Not fEmptyStr(fGetHostLock(cst_TRAVA_ENVIO__LOCEQU + strAutInc)) Then
  Begin
    If blnExibeMsg Then
      fMensagem('ATENÇÃO', 'Essa operação já está em andamento em outra estação: ' + fGetHostLock(cst_TRAVA_ENVIO__LOCEQU + strAutInc), ['&Ok']);
    Result := False;
    Exit;
  End;

  If Not fEmptyStr(fGetHostLock(cst_TRAVA_RETORN_LOCEQU + strAutInc)) Then
  Begin
    If blnExibeMsg Then
      fMensagem('ATENÇÃO', 'Essa operação já está em andamento em outra estação: ' + fGetHostLock(cst_TRAVA_RETORN_LOCEQU + strAutInc), ['&Ok']);
    Result := False;
    Exit;
  End;

  If Not fEmptyStr(fGetHostLock(cst_TRAVA_CANCEL_LOCEQU + strAutInc)) Then
  Begin
    If blnExibeMsg Then
      fMensagem('ATENÇÃO', 'Essa operação já está em andamento em outra estação: ' + fGetHostLock(cst_TRAVA_CANCEL_LOCEQU + strAutInc), ['&Ok']);
    Result := False;
    Exit;
  End;
End;

function fValidaTravasManutencaoContrato(const strAutInc: String; blnExibeMsg: Boolean = True): Boolean;
Begin
  Result := True;

  If Not fEmptyStr(fGetHostLock(cst_TRAVA_MANUTE_LOCEQU + strAutInc)) Then
  Begin
    If blnExibeMsg Then
      fMensagem('ATENÇÃO', 'Essa operação já está em andamento em outra estação: ' + fGetHostLock(cst_TRAVA_MANUTE_LOCEQU + strAutInc), ['&Ok']);
    Result := False;
    Exit;
  End;

  If Not fEmptyStr(fGetHostLock(cst_TRAVA_LIBERA_LOCEQU + strAutInc)) Then
  Begin
    If blnExibeMsg Then
      fMensagem('ATENÇÃO', 'Essa operação já está em andamento em outra estação: ' + fGetHostLock(cst_TRAVA_LIBERA_LOCEQU + strAutInc), ['&Ok']);
    Result := False;
    Exit;
  End;

  If Not fEmptyStr(fGetHostLock(cst_TRAVA_TROCAS_LOCEQU + strAutInc)) Then
  Begin
    If blnExibeMsg Then
      fMensagem('ATENÇÃO', 'Essa operação já está em andamento em outra estação: ' + fGetHostLock(cst_TRAVA_TROCAS_LOCEQU + strAutInc), ['&Ok']);
    Result := False;
    Exit;
  End;

  If Not fEmptyStr(fGetHostLock(cst_TRAVA_REIMPC_LOCEQU + strAutInc)) Then
  Begin
    If blnExibeMsg Then
      fMensagem('ATENÇÃO', 'Essa operação já está em andamento em outra estação: ' + fGetHostLock(cst_TRAVA_REIMPC_LOCEQU + strAutInc), ['&Ok']);
    Result := False;
    Exit;
  End;
End;

function fValidaTravasContrato(const strAutInc: String; blnExibeMsg: Boolean = True): Boolean;
Begin
  Result := True;

  If Not(fValidaTravasEdicaoContrato(strAutInc, blnExibeMsg)) Then
  Begin
    Result := False;
    Exit;
  End;

  If Not(fValidaTravasFaturamentoContrato(strAutInc, blnExibeMsg)) Then
  Begin
    Result := False;
    Exit;
  End;

  If Not(fValidaTravasManutencaoContrato(strAutInc, blnExibeMsg)) Then
  Begin
    Result := False;
    Exit;
  End;

End;

function fRetNroContratoPelaFatura(const strEmpDoc, strEspDoc, strNumDoc: String): String;
var
  qryLocEqu: TUniQuery;
begin
  Result := '';

  qryLocEqu := fCriaQuery;
  try
    qryLocEqu.Close;
    qryLocEqu.SQL.Text :=
      'SELECT MAX(EQL_NROCON) AS EQL_NROCON ' +
      'FROM CONEQL ' +
      'INNER JOIN EQLFAT ON (CONEQL.AUTOINCREM = EQF_SEQCON) '+
      'WHERE EQF_EMPDOC = :EMPDOC ' +
      '  AND EQF_ESPDOC = :ESPDOC ' +
      '  AND EQF_NUMDOC = :NUMDOC ' ;

    qryLocEqu.ParamByName('EMPDOC').AsString := strEmpDoc;
    qryLocEqu.ParamByName('ESPDOC').AsString := strEspDoc;
    qryLocEqu.ParamByName('NUMDOC').AsString := strNumDoc;
    qryLocEqu.Open;

    If Not qryLocEqu.IsEmpty Then
      Result := qryLocEqu.FieldByName('EQL_NROCON').AsString;

  finally
    FreeAndNil(qryLocEqu);
  end;
end;

function fVerificaConsultaDadosCobranca(const strDocRef, strCodCli, strCodVen, strCodCnd, strCndPag, strForPag: String; strSenVen: String = ''; blnPedeSenha: Boolean = True): Boolean;
var
  intTVCLQD: Integer;
  strTravaSemConsultaDeCredito: string;
  strTravaSemConsultaDeDadosDeCobranca: string;
  strTVCLCP: string;
  dteDataConsDadosCob: TDateTime;
  strCondicaoPag: String;
  objLiberacao : TLiberacao;
  strTipoDocReferencia: string;
begin
  Result := True;

  strTVCLCP := fCfgSis('TVCLCP', varString);
  intTVCLQD := fCfgSis('TVCLQD', varInteger);

  strTipoDocReferencia := strDocRef;

  If fCfgSis('USACND', varBoolean) And
     fCfgSis('PFLCLI', varBoolean) Then
  begin
    If strTipoDocReferencia = 'OR' Then
    Begin
      strTravaSemConsultaDeCredito := fCampoTabela('CND_TRORCR', 'CADCND', ['CND_CODIGO'], [strCodCnd]);
      strTravaSemConsultaDeDadosDeCobranca := fCampoTabela('CND_TRORCB', 'CADCND', ['CND_CODIGO'], [strCodCnd]);
    End
    Else
    Begin
      strTravaSemConsultaDeCredito := fCampoTabela('CND_TRCLCR', 'CADCND', ['CND_CODIGO'], [strCodCnd]);
      strTravaSemConsultaDeDadosDeCobranca := fCampoTabela('CND_TRCLCB', 'CADCND', ['CND_CODIGO'], [strCodCnd]);
    End;
  End
  Else
  Begin
    strTravaSemConsultaDeCredito := fCfgSis('TVCLOP', varString);
    strTravaSemConsultaDeDadosDeCobranca := fCfgSis('TVCLOP', varString);
  End;

  If ((strTravaSemConsultaDeCredito = 'N') Or (intTVCLQD = 0)) And
     (strTravaSemConsultaDeDadosDeCobranca = 'N') Then
  begin
    Exit;
  end;

  dteDataConsDadosCob := fCampoTabela('CLI_DTCOCB', 'CADCLI', ['CLI_CODCLI'], [strCodCli]);

  strCondicaoPag := strCndPag;

  {************************************************}
  {* CARTAO DEVE SER CONSIDERADO A VISTA NA TRAVA *}
  {************************************************}
  If strForPag = '007' Then
    strCondicaoPag := '01000';

  If (Pos(strTVCLCP, 'P_V_') > 0) And (Not fEmptyStr(strCondicaoPag)) Then
  Begin
     If ((strTVCLCP = 'P') And (fStatusCndPag(strCondicaoPag) <> A_PRAZO)) Or
        ((strTVCLCP = 'V') And (fStatusCndPag(strCondicaoPag) <> A_VISTA)) Then
     begin
       Exit;
     end;
  End;

  If ((Pos(strTravaSemConsultaDeCredito, 'A_T_') > 0) or (Pos(strTravaSemConsultaDeDadosDeCobranca, 'A_T_') > 0)) And
     ((dteDataConsDadosCob + intTVCLQD) <= VS_Date) Then
  Begin
    objLiberacao := TLiberacao.Create;
    Try
      If dteDataConsDadosCob = 0 Then
        objLiberacao.objMsgLibera.pAddTexto('É necessário atualizar os dados de cobrança do cliente.')
      Else
      Begin
        objLiberacao.objMsgLibera.pAddTexto('É necessário atualizar os dados de cobrança do cliente.');
        objLiberacao.objMsgLibera.pAddTexto('Expirou o prazo da última consulta, ' + Trim(FloatToStr(VS_Date - (dteDataConsDadosCob + intTVCLQD))) + ' dia(s).');
        objLiberacao.objMsgLibera.pAddQuebra;
        objLiberacao.objMsgLibera.pAddTextoCaption('Data da última consulta', FormatDateTime('dd/mm/yyyy', dteDataConsDadosCob));
      End;

      objLiberacao.strDirAce := 'CLCDCB';
      objLiberacao.blnTraTel := (strTravaSemConsultaDeCredito = 'T') or (strTravaSemConsultaDeDadosDeCobranca = 'T');
      objLiberacao.strMsgSen := 'Senha consulta de dados de cobrança';
      objLiberacao.strCodOpe := IIF(fEmptyStr(strCodVen), strSenVen, strCodVen);
      objLiberacao.strCodDig := strLoginUsuarioLogado;
      objLiberacao.strCliente := strCodCli + '-' + fRetNomCliente(strCodCli);
      objLiberacao.strCpfCnpj := fRetCgcCpf(strCodCli);
      objLiberacao.tipCliFor := cfCliente;

      Result :=  objLiberacao.fLibera;
    Finally
      FreeAndNil(objLiberacao);
    End;
  End;

end;

function ValidaConfiguracoesLocEqu: Boolean;
Begin
  If Not(fCfgSis('LOCEQU', VarBoolean)) Then
  Begin
    fMensagem('Atenção', 'Módulo Locação de Equipamentos não está ativo. Verifique a configuração [CFG_LOCEQU]',['&OK']);
    Exit(False);
  End;

  If fEmptyStr(fCfgSis('SRLCEQ', varString)) Then
  Begin
    fMensagem('Atenção', 'Verifique o preenchimento da configuração [CFG_SRLCEQ] para prosseguir.',['&OK']);
    Exit(False);
  End;

  If fEmptyStr(fCfgSis('SRRPEQ', varString)) Then
  Begin
    fMensagem('Atenção', 'Verifique o preenchimento da configuração [CFG_SRRPEQ] para prosseguir.',['&OK']);
    Exit(False);
  End;

  If (fCfgSis('CPGCTR', varBoolean)) And (fEmptyStr(fCfgSis('TRASUG', varString))) Then
  Begin
    fMensagem('Atenção', 'Verifique o preenchimento da configuração [CFG_TRASUG] para prosseguir.',['&OK']);
    Exit(False);
  End;

  Result := True;
End;

end.
