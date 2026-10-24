unit untGerarEspelhoDevolucaoAD;

interface

uses
  untFuncFat, SysUtils, Uni, StrUtils, Buttons, Math,
  BitBtnLockedIncrem,
  untFatDadosFiscais;

Type
  TfrmFatDadosFiscais = untFatDadosFiscais.TfrmFatDadosFiscais;
  TTipoLog = (tpInclusaoEsp, tpExclusaoEsp, tpErroGeracaoEspelho, tpErroGenerico, tpErroGrav, tpImpressao);
  TEAntesGerarEspelho = procedure(pFatVenda: TFatVenda) of Object;
  TEAntesExibirDadosFiscais = procedure(pfrmFatDadosFiscais:  TfrmFatDadosFiscais; Out pContinuar: Boolean) of Object;
  TLogEspeloAD = Class;
  TGerarEspelhoDevolucaoAD = class
    private
      FAntesGerarEspelho: TEAntesGerarEspelho;
      FAntesExibirDadosFiscais: TEAntesExibirDadosFiscais;
      FCodAde: String;
      FEmpAde: String;

      FLog: TLogEspeloAD;
      procedure pRaise(strMsg: String);
      procedure pCriaObjetos;
      procedure pDestroyObjetos;
      procedure pGerarEspelhoDevolucaoADAntesGerarEspelho(pFatVenda: TFatVenda);
    protected
      fatVenda: TFatVenda;

      FAutInc: String;
      FCodCli: String;
      FNumEsp: String;
      strNomeForm: String;
      procedure pCarregarItens;Virtual;
      function fGerarEspelhoExec(AOrigemEntradaDV: boolean = False): Boolean;
    public
      constructor Create; virtual;
      destructor Destroy; Override;

      function fGerarEspelho(strCodCli, strCodAde, strEmpAde: String; AOrigemEntradaDV: boolean = False): Boolean;
      procedure pGravarLog(const Tipo: TTipoLog; const strMensagem: String);
      class procedure pApagarEspelhoGeradoPelaAD(ADocumento, AEspecie, AEmpresa : String);

      property strNumeroEspelho: String Read FNumEsp;
      property AntesGerarEspelho:TEAntesGerarEspelho Read FAntesGerarEspelho Write FAntesGerarEspelho;
      property AntesExibirDadosFiscais: TEAntesExibirDadosFiscais Read FAntesExibirDadosFiscais Write FAntesExibirDadosFiscais;
  end;

  TLogEspeloAD = Class
  private
    FQuery: TUniQuery;
    FSqlInsert: String;
    FBlnGravarLog: Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    procedure pAddLog(TipLog: TTipoLog; strCodAde, strSeqEsp, strDescricao: String);
  End;

const
  arrTipLog: Array [TTipoLog] of String = ('I', 'E', 'X','G', 'A', 'P') ;
  arrDescricaoResumida: Array [TTipoLog] of String = ('GERAÇÃO DO ESPELHO', 'EXCLUSÃO DO ESPELHO', 'ERRO NA GERAÇÃO DO ESPELHO', 'ERRO GENÉRICO', 'ERRO NA GRAVAÇÃO DO ARQUIVO', 'IMPRESSAO DE DOCUMENTO') ;

implementation

uses untFuncoes, untConstantes, untFuncoesSimples, untGravando, untFuncFatTypes, Data.DB, untDuplicatas,
  untSeqTmp, untTypesSistema;

{ TGerarEspelhoDevolucaoAD }

constructor TGerarEspelhoDevolucaoAD.Create;
begin
  inherited Create;
  strNomeForm := 'TGerarEspelhoDevolucaoAD';
  FAntesGerarEspelho := pGerarEspelhoDevolucaoADAntesGerarEspelho;
  FAntesExibirDadosFiscais := Nil;
end;

destructor TGerarEspelhoDevolucaoAD.Destroy;
begin
  pDestroyObjetos;
  inherited Destroy;
end;

procedure TGerarEspelhoDevolucaoAD.pDestroyObjetos;
begin
  pFreeCdsVenda;
  If Assigned(fatVenda) Then
    FreeAndNil(FatVenda);
  If Assigned(FLog) Then
    FreeAndNil(FLog);

end;

procedure TGerarEspelhoDevolucaoAD.pGravarLog(const Tipo: TTipoLog;
  const strMensagem: String);
begin
  If fEmptyStr(FAutInc) Then
    Exit;

  If fEmptyStr(FCodAde) Then
    Exit;

  FLog.pAddLog(Tipo, FCodAde, FAutInc, strMensagem);
end;

class procedure TGerarEspelhoDevolucaoAD.pApagarEspelhoGeradoPelaAD(ADocumento, AEspecie, AEmpresa: String);
  var
    LQuery : TUniQuery;
    LstrIdEspelho : String;
    LLog: TLogEspeloAD;
    LstrCodAde: String;
begin
  LQuery := fCriaQuery;
  LLog := TLogEspeloAD.Create;
  Try
    LQuery.Sql.Text := 'SELECT E.AUTOINCREM, '+
                       '       E.GER_CODADE  '+
                       '  FROM ADEDET A '+
                       ' INNER JOIN ESPGER E ON A.DET_CODADE = E.GER_CODADE '+
                       ' WHERE A.DET_NUMDOC = :NUMDOC '+
                       '   AND A.DET_ESPDOC = :ESPDOC '+
                       '   AND A.DET_CODEMP = :CODEMP ';
    LQuery.ParamByName('NUMDOC').AsString := ADocumento;
    LQuery.ParamByName('ESPDOC').AsString := AEspecie;
    LQuery.ParamByName('CODEMP').AsString := AEmpresa;
    LQuery.Open;
    LstrIdEspelho := LQuery.FieldByName('AUTOINCREM').AsString;
    LstrCodAde    := LQuery.FieldByName('GER_CODADE').AsString;
    LQuery.Close;

    if fEmptyStr(LstrIdEspelho) then
      Exit
    else
    Begin
      LQuery.Sql.Clear;
      LQuery.Sql.Text := 'DELETE FROM ESPDET  '+
                         '  WHERE DET_SEQGER = :SEQGER '+
                         '    AND DET_SEQDET IN (SELECT AUTOINCREM '+
                         '                         FROM MOVDET '+
                         '                        WHERE DET_NUMDOC = :NUMDOC '+
                         '                          AND DET_ESPDOC = :ESPDOC '+
                         '                          AND DET_CODEMP = :CODEMP) ';
      LQuery.ParamByName('SEQGER').AsString := LstrIdEspelho;
      LQuery.ParamByName('NUMDOC').AsString := ADocumento;
      LQuery.ParamByName('ESPDOC').AsString := AEspecie;
      LQuery.ParamByName('CODEMP').AsString := AEmpresa;
      LQuery.ExecSQL;

      LLog.pAddLog(tpExclusaoEsp, LstrCodAde, LstrIdEspelho, 'Exclusão de espelho processado. Rotina pApagarEspelhoGeradoPelaAD - Comamdo Delete 1: ' + LQuery.Sql.Text +
                                                             'Documento: ' + ADocumento + '; ' +
                                                             'Especie: ' + AEspecie + '; ' +
                                                             'Empresa: ' + AEmpresa + '; ');


      {********************************************************************
      Fazendo essa verificação pois pode ser que tenha itens de outros
      documentos no espelho. Se apagou todos ai remove a capa também
      {***************************************************************GD***}
      LQuery.Sql.Clear;
      LQuery.Sql.Text := 'SELECT * FROM ESPDET WHERE DET_SEQGER = :SEQGER ';
      LQuery.ParamByName('SEQGER').AsString := LstrIdEspelho;
      LQuery.Open;
      if LQuery.IsEmpty then
      Begin
        LQuery.Close;
        LQuery.Sql.Clear;
        LQuery.Sql.Text := 'DELETE FROM ESPGER WHERE AUTOINCREM = :SEQGER ';
        LQuery.ParamByName('SEQGER').AsString := LstrIdEspelho;
        LQuery.ExecSQL;

        LLog.pAddLog(tpExclusaoEsp, LstrCodAde, LstrIdEspelho, 'Exclusão de espelho processado. Rotina pApagarEspelhoGeradoPelaAD - Comamdo Delete 2: ' + LQuery.Sql.Text);
      End;
    End;

  Finally
    FreeAndNil(LQuery);
    FreeAndNil(LLog);
  End;
end;

function TGerarEspelhoDevolucaoAD.fGerarEspelho(strCodCli, strCodAde, strEmpAde: String; AOrigemEntradaDV: boolean = False): Boolean;
begin
  FNumEsp := '';
  FAutInc := '';
  FCodCli := strCodCli;
  FCodAde := strCodAde;
  FEmpAde := strEmpAde;
  Result := fGerarEspelhoExec;
end;

function TGerarEspelhoDevolucaoAD.fGerarEspelhoExec(AOrigemEntradaDV: boolean = False): Boolean;
Var
  blnContinuar: Boolean;
begin
  pCriaObjetos;
  Try
    Try
      if Assigned(FAntesGerarEspelho) Then
        FAntesGerarEspelho(fatVenda);

      fatVenda.blnEspelhoDevolucaoCliente := True;
      fatVenda.blnImprimeDocs := False;
      fatVenda.blnGerarNfePainel := False;

      Repeat
        fatVenda.strTmpIteDev := 'TMP_ITEDEV' + fRetSeqTmp;
      Until (Not fTabelaExiste(fatVenda.strTmpIteDev));

      fatVenda.pCriaTemporariaIteDev;

      pCarregarItens;

      fatVenda.strCodCli := FCodCli;
      fatVenda.pCarregaDadosClienteBaixa(FCodCli);

      fatVenda.strCodVen := fatVenda.strCodOpe;
      fatVenda.strCodDig := fatVenda.strCodOpe;
      fatVenda.strNomVen := fRetNomVendRep(fatVenda.strCodVen);
      fatVenda.strNomDig := fRetNomVendRep(fatVenda.strCodDig);

      fatVenda.strCodCnd := fCfgSis('CNDAVI', varString);
      fatVenda.pAtualizaInformacoesCondPagamento();

      fatVenda.strCodFpg := '001';
      fatVenda.strConPag := '01000';

      fatVenda.strCodTra := fCfgSis('TRASUG');
      fatVenda.strTipFre := '1';
      fatVenda.blnFiltrarDiaDev := False;

      if Not fEmptyStr(FCodAde) Then
      begin
        pCriarFormularios(TfrmGravando,frmGravando);
        Try
          Try
            frmGravando.strChave := 'FATVENDAS';
            frmGravando.fExecutarAcao := fatVenda.fCarregaItensDevolucaoAD;
            frmGravando.ShowModal;
            Result := frmGravando.blnConfirma;
          Except
            On E: Exception Do
            Begin
              Result := False;
              FLog.pAddLog(tpErroGeracaoEspelho, FCodAde, fatVenda.strAutInc, 'Espelho não processado. Erro em fGerarEspelho - fatVenda.fCarregaItensDevolucaoAD: ' + #13#10 +  E.Message);
              pMensagensErro('Espelho não processado: ' + E.Message,'[TGerarEspelhoDevolucaoAD.fGerarEspelho - fatVenda.fCarregaItensDevolucaoAD]');
              Exit;
            End;
          End;
        Finally
          pFreeAndNil(frmGravando);
        End;

      end;

      fatVenda.pPreencheMatrizFechamento;
      If Length(fatVenda.arrMatItens) = 0 Then
      Begin
        Result := False;
        FLog.pAddLog(tpInclusaoEsp, FCodAde, fatVenda.strAutInc, 'Espelho não processado. Não há nenhum produto: fGerarEspelho - fatVenda.arrMatItens = 0 ');
        pMensagensErro('Espelho não processado: Nenhum produto carregado.', '[TGerarEspelhoDevolucaoAD.fGerarEspelho - fatVenda.pPreencheMatrizFechamento]');
        pRaise('Espelho não processado: Nenhum produto carregado.');
        Exit;
      End;

      fatVenda.pCalculaPesBruLiq;
      fatVenda.pCalculaTotGer(False, False);

      If fatVenda.fAplicaDescontoIcmsOrgaoPublicoNoDescontoEspecial Then
      Begin
        If (fatVenda.fltDesEsp <= 0.00) And (fatVenda.fltIcmOrg > 0) Then
          fatVenda.fltDesEsp := fatVenda.fltIcmOrg;
      End;

      fatVenda.pDestacaRetencoes;
      fatVenda.pRetemImpostosNoDescontoEspecial;

      If (fatVenda.fEhDevolucaoEspelhoOuParaFornecedor) Then
      Begin
        fatVenda.pCalculaFreteDespAcessDevolucaoFornecedor;
        fatVenda.pCalculaDescontoEspecialDevolucaoFornecedor;
      End;

      fatVenda.pCalculaTotGer(False, False);

      fatVenda.strEspDoc := 'NF';

      fatVenda.pCalculaTotGer;

      fatVenda.intQtdTra := Floor(fatVenda.fRetVolumes);

      fatVenda.blnEspelhoDevolucaoClienteFatDadosFiscais := True;

      fatVenda.pCalculaTotGer(False, True, nil, False);

      fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

      Try
        pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);
        frmFatDadosFiscais.fatVenda := fatVenda;
        frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text    := fatVenda.strClafis;
        frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Text    := fatVenda.strDesCla;
        frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled := False;
        frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Enabled := False;

        if Assigned(FAntesExibirDadosFiscais) then
          FAntesExibirDadosFiscais(frmFatDadosFiscais, blnContinuar)
        else
          blnContinuar := True;

        if blnContinuar Then
        begin
          frmFatDadosFiscais.ShowModal;
          If Not frmFatDadosFiscais.blnConfirma Then
          Begin
            Result := False;
            FLog.pAddLog(tpInclusaoEsp, FCodAde, fatVenda.strAutInc, 'Espelho não processado. Dados fiscais não processados. ');
            Exit;
          End;
        end
        else
        begin
          Result := False;
          Exit;
        end

      Finally
        pFreeAndNil(frmFatDadosFiscais);
      End;

      fatVenda.pCalculaTotalParaCadRec;

      fDigDuplic(fatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses(fatVenda.strConPag), 0, fatVenda.fltTotCadRec,
                                                 FAlse, False, False, VS_Date, False, fatVenda.fltImpFre, 'N', fCfgSis('DUPRED', varBoolean));
      fatVenda.pRateiaValores;

      If (fatVenda.fEhDevolucaoEspelhoOuParaFornecedor) Then
        fatVenda.pAjustarDescontoEspecialDevolucaoFornecedorConformeNotasOriginais;

      If (fatVenda.fltTotIcm <= 0.0) Then
        fatVenda.fltAlqIcm := 0.0;

      If (fatVenda.fltTotIpi <= 0.0) Then
        fatVenda.fltAlqIpi := 0.0;

      fatVenda.strNomeForm := strNomeForm;


      pCriarFormularios(TfrmGravando,frmGravando);
      Try
        Try
          frmGravando.strChave := 'FATVENDAS';
          frmGravando.fExecutarAcao := fatVenda.fGravaArquivos;
          frmGravando.ShowModal;
          Result := frmGravando.blnConfirma;
        Except
          On E: Exception Do
          Begin
            Result := False;
            FLog.pAddLog(tpErroGeracaoEspelho, FCodAde, '', 'Espelho não processado. Erro em fGerarEspelho - fatVenda.fGravaArquivos: ' + #13#10 +  E.Message);
            pMensagensErro('Espelho não processado: ' + E.Message,'[TGerarEspelhoDevolucaoAD.fGerarEspelho - fatVenda.fGravaArquivos]');
          End;
        End;
      Finally
        pFreeAndNil(frmGravando);
      End;

      If Result Then
      Begin
        FNumEsp := fatVenda.strNumDoc;
        FAutInc := fatVenda.strAutInc;
        FLog.pAddLog(tpInclusaoEsp, FCodAde, fatVenda.strAutInc, 'Espelho processado. NumEsp:' + fatVenda.strNumDoc);
      End
      Else
        FLog.pAddLog(tpInclusaoEsp, FCodAde, fatVenda.strAutInc, 'Espelho não processado. NumEsp:' + fatVenda.strNumDoc);

    Except
      On E: Exception Do
      Begin
        Result := False;
        If Assigned(FLog) Then
        Begin
          If Assigned(fatVenda) Then
            FLog.pAddLog(tpErroGeracaoEspelho, FCodAde, fatVenda.strAutInc, 'Espelho não processado. Erro em fGerarEspelho:' + #13#10 + E.Message)
          Else
            FLog.pAddLog(tpErroGeracaoEspelho, FCodAde, '', 'Espelho não processado. Erro em fGerarEspelho:' + #13#10 + E.Message);
        End;
        pMensagensErro(E.Message,'[TGerarEspelhoDevolucaoAD.fGerarEspelho]');
      End;
    End;

  Finally
    pDestroyObjetos;
  End;
end;

procedure TGerarEspelhoDevolucaoAD.pGerarEspelhoDevolucaoADAntesGerarEspelho(
  pFatVenda: TFatVenda);
begin
  fatVenda.strCodAde := FCodAde;
  fatVenda.strMotDev := fCampoTabela('DET_CODMOT', 'ADEDET', ['DET_CODADE','DET_CODEMP'], [FCodAde, VS_strCodEmp]);
  fatVenda.blnEspelhoDevolucaoClienteGarantia := (fCampoTabela('COUNT(*)', 'ADEDET', ['DET_CODADE','DET_CODEMP','DET_GARANT'], [FCodAde, VS_strCodEmp, 'S']) > 0);
end;

procedure TGerarEspelhoDevolucaoAD.pCarregarItens;
Var
  dtaDtaIni: TDateTime;
  dtaDtaFin: TDateTime;
begin

  dtaDtaIni := fCampoTabela('CAST(MIN(IF(IFNULL(DT.DET_DTAENT, "") = "", NT.DET_DTAENT, DT.DET_DTAENT)) AS DATE)', ADEDET_JOIN_MOVDET, ['AD.DET_CODADE','AD.DET_CODEMP'], [FCodAde, VS_strCodEmp]);
  dtaDtaFin := fCampoTabela('CAST(MAX(IF(IFNULL(DT.DET_DTAENT, "") = "", NT.DET_DTAENT, DT.DET_DTAENT)) AS DATE)', ADEDET_JOIN_MOVDET, ['AD.DET_CODADE','AD.DET_CODEMP'], [FCodAde, VS_strCodEmp]);

  fatVenda.pCarregaItensDevolucao(FCodCli, '', '', '', '', VS_strCodEmp, dtaDtaIni, dtaDtaFin, fatVenda.strCodAde, nil);

end;

procedure TGerarEspelhoDevolucaoAD.pCriaObjetos;
begin

  fatVenda := TFatVenda.CreateInstance('DV');
  pCriarCdsVenda(fatVenda);
  If (fCfgSis('ESPDEV',varBoolean)) Then
    fatVenda.objItensNotaEspelho := TItensNotaEspelho.Create(fatVenda);

  FLog := TLogEspeloAD.Create;
end;

procedure TGerarEspelhoDevolucaoAD.pRaise(strMsg: String);
begin
  pDestroyObjetos;
  Raise ExceptionAutCom.Create(strMsg);
end;

{ TLogEspeloAD }

constructor TLogEspeloAD.Create;
begin
  FBlnGravarLog := fCfgSis('LOGESP', varBoolean);

  FSqlInsert := 'INSERT INTO LOGESP ( ' +
                'AUTOINCREM, LOG_DESCRI, LOG_DTALOG, ' +
                'LOG_HRALOG, LOG_CODEMP, LOG_CODADE, ' +
                'LOG_TIPLOG, LOG_SEQESP, LOG_DESRES) ' +
                '  VALUES (' +
                ':AUTOINCREM, :LOG_DESCRI, :LOG_DTALOG, ' +
                ':LOG_HRALOG, :LOG_CODEMP, :LOG_CODADE, ' +
                ':LOG_TIPLOG, :LOG_SEQESP, :LOG_DESRES)';
  FQuery := fCriaQuery;
  FQuery.DisableControls;
  FQuery.SQl.Add(FSqlInsert);
  FQuery.Prepare;
end;

destructor TLogEspeloAD.Destroy;
begin
  FreeAndNil(FQuery);

  inherited;
end;

procedure TLogEspeloAD.pAddLog(TipLog: TTipoLog; strCodAde, strSeqEsp,
  strDescricao: String);
var
  strAutInc: String;
begin

  If Not FBlnGravarLog Then
  Begin
    Exit;
  End;

  Try
    strAutInc := fRetAutoIncrem('LOGESP', VS_strCodEmp);
    FQuery.ParamByName('AUTOINCREM').AsString :=  strAutInc;
    FQuery.ParamByName('LOG_DESCRI').AsString :=  strDescricao;
    FQuery.ParamByName('LOG_DTALOG').AsDateTime := fNow;
    FQuery.ParamByName('LOG_HRALOG').AsDateTime := fNow;
    FQuery.ParamByName('LOG_CODEMP').AsString :=  VS_strCodEmp;
    FQuery.ParamByName('LOG_CODADE').AsString := strCodAde;
    FQuery.ParamByName('LOG_TIPLOG').AsString := arrTipLog[TipLog];
    FQuery.ParamByName('LOG_DESRES').AsString := arrDescricaoResumida[TipLog];
    If Not fEmptyStr(strSeqEsp) Then
      FQuery.ParamByName('LOG_SEQESP').AsString := strSeqEsp
    Else
      FQuery.ParamByName('LOG_SEQESP').Clear;

    FQuery.ExecSql;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TLogEspeloAD.pAddLog]');
    End;
  End;
end;

end.
