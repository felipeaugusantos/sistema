unit untProcessarTarefaNFe;

interface

uses
{$IFDEF LINUX}
  NFe.Utils,
  NFe.Modulo,
{$ELSE}
  untUtil,
  untModulo,
  Windows,
  Forms,
{$ENDIF}
  SysUtils, Classes, untInterfaces;

Type
  TImprimirPDFBrowser = class(TInterfacedObject, IVirtualUIPrintPDF)
    public
      procedure PrintPDF(strFileName: String);
  end;

procedure pExecutarTarefaNFe;

implementation

uses
{$IFDEF LINUX}
{$ELSE}
  untConfiguracoes,
  VirtualUI_SDK,
  untIntegracaoCitel,
  untCoordenadorStatusNFe,
  untImportaXMLTerceiros,
  untEventoConciliacaoFinanceira,
  untAuditarDocumento,
  untComplementarDocumento,
{$ENDIF}
  untVerificarStatus, untLimparDanfes,
  untPendenciasDPEC, untLibNfe,
  {$IF Defined(UNIDAC)} untModuloReplicacao {$ELSE} untModuloReplicacaoZeos {$IFEND},
  untRegistrarTarefa, untEnviarXMLSat,
  untDicSis, untConfirmaXMLGravacao, untConsultaCadastro, untLogDanfe;

procedure pCarregarModulos;
begin
  pCarregarConfiguracoes;
  pAbrirBanco(frmModulo);

  {$IF Defined(UNIDAC)}
  pSetaPidMD5DicSisLibNfe(VS_PidMD5DicSis);
  {$IFEND}

  TLibNfe.pCarregaConfigNFE(frmModulo.Database);
  pSetaConfiguracoesPainel(VS_confignfe);
end;

procedure pFinalizarModulos;
begin
  pGeraRegistroParaLogGeneral(frmModulo.Database, 'pFinalizarModulos > frmModulo.Database.Disconnect');

  frmModulo.Database.Disconnect;

  FreeAndNil(frmModuloReplicacao);
  FreeAndNil(frmModulo);
end;

procedure pExecutarTarefaNFe;
  Var
    intParam: Integer;
    strValPar: String;
    strMsgAux: String;
    strParFis: String;
    strParams: String;
    strTarefa: String;
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strSerie_: String;
    strCodCli: String;
    strTipFc_: String;
    strStatus: String;
    strMinTmp: String;
    objTarefa: TRegistrarTarefa;
    objVerificarStatus: TVerificarStatus;
    objPendenciasDPEC: TPendenciasDPEC;
    objEnviaXMLSat: TEnviarXMLSat;
    objLimparDanfe: TLimparDanfes;
   {$IFNDEF LINUX}
    objImportarXMLTerceiros: TImportaXMLTerceiros;
    objAuditarDocumento: TAuditarDocumento;
    objIntegracaoCitel: TIntegracaoCitel;
    objCoordenadorStatus: TCoordenadorStatusNFe;
    objComplementarDocumento : TComplementarDocumento;
    objEventoConciliacaoFinanceira: TEventoConciliacaoFinanceira;
   {$ENDIF}
    blnTodosParametosPorTag: Boolean;
    blnTodosParametosPorPos: Boolean;
    objConfirmaXMLGravacao : TConfirmaXMLGravacao;
    objConsultaCadastro : TConsultaCadastro;

    function fEhProcessamentoDeErroDoPainelCitel: Boolean;
    begin
      Result := ((Pos('NFE_PAINEL_CITEL', strTarefa) > 0) And (strStatus = 'EE'));
    end;

    procedure pNormalizaParametros;
      Var
        strParAux: String;
        intQtdMaxPar: Integer;
    begin
      If Pos('NFE_PROCESSAR_STATUS', strTarefa) > 0 Then
      Begin
        intQtdMaxPar := IIF(VS_PidMD5DicSis = '', 8, 9);

        strNumDoc := ParamStr(2);
        strEspDoc := ParamStr(3);
        strCodEmp := ParamStr(4);
        strSerie_ := ParamStr(5);
        strCodCli := ParamStr(6);
        strTipFc_ := ParamStr(7);
        strStatus := ParamStr(8);

        If (ParamCount < intQtdMaxPar) Then
        Begin
          If (Pos(ParamStr(6), fProcessosSemCliFor) > 0) Then
          Begin
            strNumDoc := ParamStr(2);
            strEspDoc := ParamStr(3);
            strCodEmp := ParamStr(4);
            strSerie_ := ParamStr(5);
            strCodCli := '0';
            strTipFc_ := '0';
            strStatus := ParamStr(6);
          End
          Else If (strEspDoc = 'NS') Then
          Begin
            strNumDoc := ParamStr(2);
            strEspDoc := ParamStr(3);
            strCodEmp := ParamStr(4);
            strSerie_ := '';
            strCodCli := ParamStr(5);
            strTipFc_ := ParamStr(6);
            strStatus := ParamStr(7);
          End;

          strParAux := strTarefa  + ' ' +
                       strNumDoc  + ' ' +
                       strEspDoc  + ' ' +
                       strCodEmp  + ' ' +
                       strSerie_  + ' ' +
                       strCodCli  + ' ' +
                       strTipFc_  + ' ' +
                       strStatus  +
                       IIF(VS_PidMD5DicSis='', '', ' ' + VS_PidMD5DicSis);


          strParAux := Trim(strParAux);
          If (strParams <> strParAux) Then
          Begin
            strParams := strParAux;

            pLogImp('Entrou > pNormalizaParametros > Para ajustar os parâmetros de ['+strParams+'] para ['+strParAux+'] pois essa tarefa não tem Cliente/Fornecedor');
          End;
        End;
      End;
    end;

    function fRetNumDocLog: String;
    begin
      Result := Concat(strNumDoc, '-', strEspDoc, '-', strCodEmp, '-', strSerie_, '-', strCodCli, '-', strTipFc_, '-', strStatus);
    end;

begin
  If (ParamCount = 0) Or (fParametrosMisturados(strMsgAux)) Then
  Begin
    pLogImp(strMsgAux);

    If Not KillProcess(GetCurrentProcessId) Then
      Application.Terminate;
  End;

  blnTodosParametosPorTag := fTodosParametosPorTag;
  blnTodosParametosPorPos := fTodosParametosPorPos;

  strParams := '';
  For intParam := 1 To ParamCount Do
  Begin
    strValPar := ParamStr(intParam);

    strParFis := strParFis + ' ' + strValPar;

    If blnTodosParametosPorTag Then
      strParams := strParams + ' ' + fExtraiValorParam(strValPar)
    Else
      strParams := strParams + ' ' + strValPar;

    pExtraiValorParam(strValPar, consTagParamsPid, VS_PidMD5DicSis);

    If blnTodosParametosPorTag then
    Begin
      pExtraiValorParam(strValPar, consTagParamsTrf, strTarefa);
      pExtraiValorParam(strValPar, consTagParamsDoc, strNumDoc);
      pExtraiValorParam(strValPar, consTagParamsEsp, strEspDoc);
      pExtraiValorParam(strValPar, consTagParamsEmp, strCodEmp);
      pExtraiValorParam(strValPar, consTagParamsSer, strSerie_);
      pExtraiValorParam(strValPar, consTagParamsCli, strCodCli);
      pExtraiValorParam(strValPar, consTagParamsTfc, strTipFc_);
      pExtraiValorParam(strValPar, consTagParamsSta, strStatus);
      pExtraiValorParam(strValPar, consTagParamsMin, strMinTmp);
    End;
  End;

  {*************************************************************************************}
  {* A IDÉIA É QUE NO FUTURO TODOS OS PROGRAMAS FAÇAM A CHAMADA COM PARÂMETROS VIA     *}
  {* TAG IDENTIFICADORA O QUE FACILITA A INCLUSÃO DE NOVOS PARÂMETROS E EVITA ERROS    *}
  {* POIS NÚMEROS DE PARÂMETROS PODEM VARIAR CONFORME A NECESSIDADE (VIDE A            *}
  {* FRAGILIDADE DA FUNÇÃO pNormalizaParametros). ALÉM DO MAIS, A IDENTIFICAÇÃO POR    *}
  {* TAG PERMITE QUE VOCÊ PASSE OS PARÂMETROS NA ORDEM QUE QUISER. ENTÃO AS BOOLEANAS  *}
  {* blnTodosParametosPorPos E blnTodosParametosPorTag DETERMINAM NUM PERÍODO DE       *}
  {* TRANSIÇÃO COMO O NfeStatus.exe, NO CASO, DEVE ENTER A CHAMADA. NUM FUTURO ONDE SE *}
  {* SABE QUE TODOS OS PAINÉIS ESTÃO ATUALIZADOS E NÃO EXISTE MAIS PROGRAMADAS QUE     *}
  {* ENVOCAM O NfeStatus.exe SEM OS TRECHOS REFERENTES À blnTodosParametosPorPos PODEM *}
  {* SER REMOVIDOS, POR HORA O PROGRAMA FUNCIONA DAS DUAS FORMAS.                      *}
  {**********************************************************************************VA*}
  If blnTodosParametosPorPos Then
  Begin
    strTarefa := ParamStr(1);
    If Pos('NFE_PAINEL_CITEL', strTarefa) > 0 Then
      strStatus := ParamStr(2)
    Else If Pos('NFE_LIMPAR_DANFES', strTarefa) > 0 Then
      strMinTmp := ParamStr(2)
  End;

  If Pos('NFE_LIMPAR_DANFES', strTarefa) > 0 Then
  Begin
    If fDirectoryIsEmpty(fRetornaCaminhoLimparDiretorioDanfe) Then
    Begin
      If Not KillProcess(GetCurrentProcessId) Then
        Application.Terminate;
    End;
  End;

  strParams := Trim(strParams);
  strParFis := Trim(strParFis);

  pCarregarModulos;

  If blnTodosParametosPorPos Then
  Begin
    {***************************************************************************}
    {* NÃO CRIAR NOVOS PARÂMETROS IDENTIFICADOS POR POSIÇÃO!                   *}
    {* PARA NOVOS PARÂMETROS, CRIAR NOVAS TAG'S PARA IDENTIFICÁ-LOS.           *}
    {* ESSE BLOCO EXISTE SOMENTE PARA MANTER COMPATIBILIDADE COM AUTCOM ANTIGO.*}
    {************************************************************************VA*}

    pNormalizaParametros;
  End;

  If Assigned(objLogDanfe) Then
  Begin
    objLogDanfe.objConexao := frmModulo.Database;
    objLogDanfe.strNumDoc := '...';
    objLogDanfe.strEspDoc := '...';
    objLogDanfe.strCodEmp := VS_strCodEmp;
    objLogDanfe.strSerie_ := '...';
    objLogDanfe.strCodCli := '...';
  End;

  If blnTodosParametosPorTag Then
    pLogImp('Entrou > pExecutarTarefaNFe > Parâmetros Chamada: ' + strParFis + ' | ' + 'Parâmetros Convertidos: ' + strParams + ' ' + '[TodosParametosPorTag]')
  Else
    pLogImp('Entrou > pExecutarTarefaNFe > Parâmetros Chamada: ' + strParams + ' | ' + '[TodosParametosPorPos]');

  pRemoverTarefasInativas;

  objTarefa := TRegistrarTarefa.Create(strParams);
  Try
    Try
      If Pos('NFE_IMPORTAR_XML_TERCEIROS', strTarefa) > 0 Then
        objTarefa.blnOculInfo := True;

      objTarefa.pRegistrarTarefa;

      If (not fEhProcessamentoDeErroDoPainelCitel) and objTarefa.blnJaExecutando Then
      Begin
        pLogImp('Tarefa já está sendo executada ...');
        Exit;
      End;

      If Pos('NFE_CONSULTA_CADASTRO', strTarefa) > 0 Then
      Begin
        objConsultaCadastro := TConsultaCadastro.Create(objTarefa, tccDestinatario);
        Try
          objConsultaCadastro.NumeroMaxConsultas := StrToIntDef(fCfgSisPainel('MCNCCI'), 5);
          objConsultaCadastro.CodigoEmpresa := strCodEmp;
          pLogImp('Consulta Cadastro ( Inscrição Denegada ) - NumeroMaxConsultas: ' + IntToStr(objConsultaCadastro.NumeroMaxConsultas));
          objConsultaCadastro.Executar;
        Finally
          objConsultaCadastro.Destroy;
        End;
      End

      Else If Pos('NFE_EMITENTE_CONSULTA_CADASTRO', strTarefa) > 0 Then
      Begin
        objConsultaCadastro := TConsultaCadastro.Create(objTarefa, tccEmitente);
        Try
          objConsultaCadastro.CodigoEmpresa := strCodEmp;
          pLogImp('Consulta Cadastro Emitente');
          objConsultaCadastro.Executar;
        Finally
          objConsultaCadastro.Destroy;
        End;
      End

      Else If Pos('NFE_PROCESSAR_STATUS', strTarefa) > 0 Then
      Begin
        If Assigned(objLogDanfe) Then
        Begin
          objLogDanfe.strNumDoc := strNumDoc;
          objLogDanfe.strEspDoc := strEspDoc;
          objLogDanfe.strCodEmp := strCodEmp;
          objLogDanfe.strSerie_ := strSerie_;
          objLogDanfe.strCodCli := strCodCli;
        End;
        pLogImp('<NFE_PROCESSAR_STATUS '+fRetNumDocLog+'> [INI]');
        Try
          objVerificarStatus := TVerificarStatus.Create(strNumDoc,
                                                        strEspDoc,
                                                        strCodEmp,
                                                        strSerie_,
                                                        strCodCli,
                                                        strTipFc_,
                                                        strStatus);
          Try
            objVerificarStatus.Executar;
          Finally
            objVerificarStatus.Destroy;
          End;
        Finally
          pLogImp('<NFE_PROCESSAR_STATUS '+fRetNumDocLog+'> [FIM]');
        End;
      End
      Else If Pos('NFE_COORDENADOR_STATUS', strTarefa) > 0 Then
      Begin
       {$IFDEF LINUX}
        Writeln('NFE_COORDENADOR_STATUS ainda não possui implementação linux');
       {$ELSE}
        objCoordenadorStatus := TCoordenadorStatusNFe.Create(objTarefa, StrToIntDef(fCfgSisPainel('TAMLOT'), 5));
        Try
          objCoordenadorStatus.Executar;
        Finally
          objCoordenadorStatus.Destroy;
        End;
       {$ENDIF}
      End
      Else If Pos('NFE_PENDENCIAS_DPEC', strTarefa) > 0 Then
      Begin
        objPendenciasDPEC := TPendenciasDPEC.Create(objTarefa);
        Try
          objPendenciasDPEC.Executar;
        Finally
          objPendenciasDPEC.Destroy;
        End;
      End
      Else If Pos('NFE_IMPORTAR_XML_TERCEIROS', strTarefa) > 0 Then
      Begin
       {$IFDEF LINUX}
        Writeln('NFE_IMPORTAR_XML_TERCEIROS ainda não possui implementação linux');
       {$ELSE}
        objImportarXMLTerceiros := TImportaXMLTerceiros.Create(objTarefa);
        Try
          objImportarXMLTerceiros.Executar;
        Finally
          objImportarXMLTerceiros.Destroy;
        End;
       {$ENDIF}
      End
      Else If Pos('NFE_EVENTO_CONCILIACAO_FINANCEIRA', strTarefa) > 0 Then
      Begin
       {$IFDEF LINUX}
        Writeln('NFE_EVENTO_CONCILIACAO_FINANCEIRA ainda não possui implementação linux');
       {$ELSE}
        objEventoConciliacaoFinanceira := TEventoConciliacaoFinanceira.Create(objTarefa);
        Try
          objEventoConciliacaoFinanceira.Executar;
        Finally
          objEventoConciliacaoFinanceira.Destroy;
        End;
       {$ENDIF}
      End
      Else If Pos('NFE_ENVIAR_XML_SAT', strTarefa) > 0 Then
      Begin
        objEnviaXMLSat := TEnviarXMLSat.Create(objTarefa);
        Try
          objEnviaXMLSat.Executar;
        Finally
          objEnviaXMLSat.Destroy;
        End;
      End
      Else If Pos('NFE_PAINEL_CITEL', strTarefa) > 0 Then
      Begin
       {$IFDEF LINUX}
        Writeln('NFE_PAINEL_CITEL ainda não possui implementação linux');
       {$ELSE}
        objIntegracaoCitel := TIntegracaoCitel.Create(objTarefa);
        Try
          objIntegracaoCitel.strStatus := strStatus;
          objIntegracaoCitel.Executar;
        Finally
          objIntegracaoCitel.Destroy;
        End;
       {$ENDIF}
      End
      Else If Pos('NFE_LIMPAR_DANFES', strTarefa) > 0 Then
      Begin
        objLimparDanfe  := TLimparDanfes.Create(objTarefa);
        Try
          objLimparDanfe.intLimiarApagarArquivo := StrToIntDef(strMinTmp, 300);
          objLimparDanfe.Executar;
        Finally
          objLimparDanfe.Destroy;
        End;
      End
      Else If Pos('NFE_CONFIRMAR_GRAVACAO_XML', strTarefa) > 0 Then
      Begin
        objConfirmaXMLGravacao := TConfirmaXMLGravacao.Create(objTarefa);
        Try
          objConfirmaXMLGravacao.Executar;
        Finally
          objConfirmaXMLGravacao.Destroy;
        End;
      End
      Else If Pos('NFE_COMPLEMENTAR_DOCUMENTO', strTarefa) > 0 Then
      Begin
       {$IFDEF LINUX}
        Writeln('NFE_COMPLEMENTAR_DOCUMENTO ainda não possui implementação linux');
       {$ELSE}
        objComplementarDocumento := TComplementarDocumento.Create(objTarefa);
        Try
          objComplementarDocumento.Executar;
        Finally
          objComplementarDocumento.Destroy;
        End;
       {$ENDIF}
      End
      Else If Pos('NFE_AUDITAR_DOCUMENTO', strTarefa) > 0 Then
      Begin
       {$IFDEF LINUX}
        Writeln('NFE_AUDITAR_DOCUMENTO ainda não possui implementação linux');
       {$ELSE}
        objAuditarDocumento := TAuditarDocumento.Create(objTarefa);
        Try
          objAuditarDocumento.Executar;
        Finally
          objAuditarDocumento.Destroy;
        End;
       {$ENDIF}
      End

    Except
      On E: Exception Do
        pLogarErro('procedure pExecutarTarefaNFe', E);
    End;

  Finally
    pLogImp('pExecutarTarefaNFe <');
    Try
      If (Not objTarefa.blnJaExecutando) Or (objTarefa.blnTerminar) Or (objTarefa.blnTerminar) Then
        objTarefa.pRemoverTarefa;

      If Assigned(objTarefa) Then
        FreeAndNil(objTarefa);

      pFinalizarModulos;
    Finally
      If Not KillProcess(GetCurrentProcessId) Then
        Application.Terminate;
    End;
  End;
end;

{ TImprimirPDFBrowser }

procedure TImprimirPDFBrowser.PrintPDF(strFileName: String);
begin
  inherited;
 {$IFNDEF LINUX}
  If VirtualUI.Active Then
    VirtualUI.PrintPdf(strFileName);
 {$ENDIF}
end;

end.
