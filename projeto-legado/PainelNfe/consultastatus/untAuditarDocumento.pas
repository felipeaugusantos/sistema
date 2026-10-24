unit untAuditarDocumento;

interface

uses
{$IFDEF LINUX}
  NFe.Utils,
  NFe.Modulo,
{$ELSE}
  untUtil,
  untModulo,
  Windows,
{$ENDIF}
  Variants,
  SysUtils,
  Classes,
  Forms,
  StrUtils,
  DateUtils,
  DB,
  untConfigNFE,
  {$IF Defined(UNIDAC)}
    Uni, UniSQLMonitor, MemDS, DBAccess
  {$ELSE}
    ZConnection, ZDataset
  {$IFEND}
  ,untRegistrarTarefa
  ,untInterfaces;

const
  cnsOK = 'OK';

type
  TAuditarDocumento = class
  private
    AuditarDocumento: IAuditarDocumentoServiceFIT;
    objConfigSovos: TConfiguracoesNFE;
    FExisteLogCan: Boolean;
    FExisteOpcDoc: Boolean;
    FExisteOpcDel: Boolean;
    FMenorDtaEnt: TDateTime;
    FArqRel   : String;
    FCodEmpFit: String;
    FServico: String;
    FLogAux,
    FLogErr: TStringList;
    FInconsistenc: Integer;
    FIntevaloDias: Integer;
    FLogarLocal: Boolean;
    FLogarErros: Boolean;
    FConnection: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND};
    FTarefa : TRegistrarTarefa;

    function fEhRejeicaoPorDuplicidadeComDiferencaNaChaveDeAcesso(const strTextoErro: String): Boolean;
    function fDocumentoCancelado(const LDocumentos: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): Boolean;
    function fDocumentoCanceladoComValorCadFis(const LDocumentos: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): Boolean;
    function fSQLDocumentoPorChave: String;
    function fSQLDocumentosCancelados(const ANomeTabela: String; const ADias: Integer): String;
    function fSQLDocumentosCanceladosUltimosDias(const ADias: Integer): String;
    procedure pLogarLocal;
    procedure pCanceladosNoAutcom;
    procedure pCanceladosNaSovos;
    procedure pCarimbaUltimaExecucao;
  public
    procedure Executar;
    constructor Create(const ATarefa: TRegistrarTarefa);
    destructor Destroy; override;
  End;

implementation

uses
  untDicSis,
  untLibNfe;

{ TAuditarDocumento }

constructor TAuditarDocumento.Create(const ATarefa: TRegistrarTarefa);
  Var
    LValCfgMDEVAR: String;
begin
  inherited Create;
  FTarefa := ATarefa;
  FConnection := frmModulo.Database;
  FIntevaloDias := 8;
  FMenorDtaEnt  := 0;

  VS_strCodPnlDir := VS_strCodEmp;
  FLogAux := TStringList.Create;
  FLogErr := TStringList.Create;
  FArqRel := fPnlDir('log_aud.txt');
  If FileExists(FArqRel) Then
    FLogarLocal := True;

  objConfigSovos := TConfiguracoesNFE.Create;
  objConfigSovos.strFitUrlWebService := fCfgSisPainel('CITURL');
  objConfigSovos.strFitLicenca       := fCfgSisPainel('CITLIC');
  objConfigSovos.strFitUsuario       := fCfgSisPainel('CITUSU');
  objConfigSovos.strFitSenha         := fCfgSisPainel('CITSEN');
  LValCfgMDEVAR := '';
  If fExisteConfiguracao('MDEVAR') Then
    LValCfgMDEVAR := fCfgSisPainel('MDEVAR');

  FExisteLogCan := fCampoExiste('LOGCAN', 'LOG_NUMDOC') And
                   fCampoExiste('LOGCAN', 'LOG_ESPDOC') And
                   fCampoExiste('LOGCAN', 'LOG_CODEMP') And
                   fCampoExiste('LOGCAN', 'LOG_FORCLI') And
                   fCampoExiste('LOGCAN', 'LOG_ACESSO');

  FExisteOpcDoc := fCampoExiste('AUXMOV',     'AUX_OPCDOC') And
                   fCampoExiste('AUXNOT',     'AUX_OPCDOC') And
                   fCampoExiste('DEL_AUXMOV', 'AUX_OPCDOC') And
                   fCampoExiste('DEL_AUXNOT', 'AUX_OPCDOC');

  FExisteOpcDel := fCampoExiste('DEL_MOVGER', 'OPCDEL') And
                   fCampoExiste('DEL_NOTGER', 'OPCDEL');

  FCodEmpFit := fRetCodigoEmpresaNaFit;
  FServico   := 'CITEL';
  If (Pos('wsfit',       AnsiLowerCase(objConfigSovos.strFitUrlWebService)) > 0) Or
     (Pos('cloudfiscal', AnsiLowerCase(objConfigSovos.strFitUrlWebService)) > 0) Then
    FServico := 'SOVOS';

  If fExisteConfiguracao('EMP_ID') Then
  Begin
    If (FCodEmpFit = '') Then
      FCodEmpFit := Trim(fCfgSisPainel('EMP_ID'));

    If IfEmptyStr(Trim(fCfgSisPainel('EMP_ID')), FCodEmpFit) <> FCodEmpFit Then
      pGravaLogErr('PainelNFE', '[AuditarDocumento]'+#13+
                                'Incoerência entre o identificador da empresa "'+VS_strCodPnlDir+'" na '+FServico+': (CFG_EMP_ID = '+fCfgSisPainel('EMP_ID')+'), (fRetCodigoEmpresaNaFit = '+FCodEmpFit+'). Será usado: '+FCodEmpFit);
  End;

  If (FCodEmpFit = '') Then
    Exit;

  AuditarDocumento := fCriarAuditarDocumentoServiceFIT(objConfigSovos, LValCfgMDEVAR);
end;

destructor TAuditarDocumento.Destroy;
begin
  FreeAndNil(FLogAux);
  FreeAndNil(FLogErr);

  inherited;
end;

function TAuditarDocumento.fEhRejeicaoPorDuplicidadeComDiferencaNaChaveDeAcesso(const strTextoErro: String): Boolean;
begin
  Result := True;
  If (Pos('STATUS: 539', AnsiUpperCase(strTextoErro)) > 0) Then
    Exit;
  If (Pos('DUPLICIDADE DE NF-E COM DIFERENCA NA CHAVE DE ACESSO', AnsiUpperCase(strTextoErro)) > 0) Then
    Exit;
  If (Pos('DUPLICIDADE DE NFC-E COM DIFERENCA NA CHAVE DE ACESSO', AnsiUpperCase(strTextoErro)) > 0) Then
    Exit;
  Result := False;
end;

function TAuditarDocumento.fDocumentoCancelado(const LDocumentos: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): Boolean;
begin
  Result := False;

  If (Not LDocumentos.IsEmpty) Then
  Begin
    Result := (LDocumentos.FieldByName('HISTOR').AsString = 'CANCELADO') And
              (LDocumentos.FieldByName('INCDOC').IsNull) And
              (LDocumentos.FieldByName('VLRFIS').Value = 0);
  End;
end;

function TAuditarDocumento.fDocumentoCanceladoComValorCadFis(const LDocumentos: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): Boolean;
begin
  Result := False;

  If (Not LDocumentos.IsEmpty) Then
  Begin
    Result := (LDocumentos.FieldByName('HISTOR').AsString = 'CANCELADO') And
              (LDocumentos.FieldByName('INCDOC').IsNull) And
              (LDocumentos.FieldByName('VLRFIS').Value > 0);
  End;
end;

function TAuditarDocumento.fSQLDocumentoPorChave: String;
begin
  Result := '';
  Result := Result + '   SELECT F.AUTOINCREM                                             AS INCFIS, ';
  Result := Result + '          IF(G.AUTOINCREM IS NOT NULL, G.AUTOINCREM, N.AUTOINCREM) AS INCDOC, ';
  Result := Result + '          F.FIS_ACESSO AS CHAACE, ';
  Result := Result + '          E.EMP_C_G_C_ AS C_G_C_, ';
  Result := Result + '          F.FIS_NUMDOC AS NUMDOC, ';
  Result := Result + '          F.FIS_ESPDOC AS ESPDOC, ';
  Result := Result + '          F.FIS_SERIE_ AS SERIE_, ';
  Result := Result + '          F.FIS_CODEMP AS CODEMP, ';
  Result := Result + '          IF(G.AUTOINCREM IS NOT NULL, "MOVGER", IF(N.AUTOINCREM IS NOT NULL, "NOTGER", IF(GD.AUTOINCREM IS NOT NULL, "DEL_MOVGER", IF(ND.AUTOINCREM IS NOT NULL, "DEL_NOTGER", NULL)))) AS TABELA, ';

  If FExisteLogCan Then
    Result := Result + '        (SELECT CAST(IF(COUNT(*) > 0, "EXISTE", NULL) AS CHAR(6)) FROM LOGCAN C WHERE C.LOG_ACESSO = F.FIS_ACESSO) AS LOGCAN, '
  Else
    Result := Result + '        CAST(NULL AS CHAR(6)) AS LOGCAN, ';

  Result := Result + '          IF(G.AUTOINCREM IS NOT NULL, G.GER_DTAENT, N.GER_DTAENT) AS DTAENT, ';
  Result := Result + '          IF(GD.AUTOINCREM IS NOT NULL, GD.DTADEL, ND.DTADEL)      AS DTADEL, ';

  If FExisteOpcDel Then
    Result := Result + '        IF(GD.AUTOINCREM IS NOT NULL, GD.OPCDEL, ND.OPCDEL)      AS OPCDEL, '
  Else
    Result := Result + '        CAST(NULL AS CHAR(2)) AS OPCDEL, ';

  If FExisteOpcDoc Then
    Result := Result + '        IF(XG.AUX_SEQGER IS NOT NULL, XG.AUX_OPCDOC, IF(XN.AUX_SEQGER IS NOT NULL, XN.AUX_OPCDOC, IF(XGD.AUX_SEQGER IS NOT NULL, XGD.AUX_OPCDOC, IF(XND.AUX_SEQGER IS NOT NULL, XND.AUX_OPCDOC, NULL)))) AS OPCDOC, '
  Else
    Result := Result + '        CAST(NULL AS CHAR(2)) AS OPCDOC, ';

  Result := Result + '          CONCAT(F.FIS_NUMDOC, "-", F.FIS_ESPDOC, "-", F.FIS_CODEMP, "-", F.FIS_TIP_FC, "-", F.FIS_SERIE_, "-", F.FIS_FORCLI) AS DOCTIT, ';
  Result := Result + '          FIS_HISTOR AS HISTOR, ';
  Result := Result + '          IFNULL(FIS_VLCON1, 0) AS VLCON1, ';
  Result := Result + '          IFNULL(FIS_VLCON2, 0) AS VLCON2, ';
  Result := Result + '          IFNULL(FIS_VLCON3, 0) AS VLCON3, ';
  Result := Result + '          IFNULL(FIS_VLCON4, 0) AS VLCON4, ';
  Result := Result + '          IFNULL(FIS_VLCON5, 0) AS VLCON5, ';
  Result := Result + '          (IFNULL(FIS_VLCON1, 0)+IFNULL(FIS_VLCON2, 0)+IFNULL(FIS_VLCON3, 0)+IFNULL(FIS_VLCON4, 0)+IFNULL(FIS_VLCON5, 0)) AS VLRFIS ';
  Result := Result + '   FROM CADFIS F';

  Result := Result + '   LEFT JOIN MOVGER G ON G.GER_NUMDOC = F.FIS_NUMDOC ';
  Result := Result + '                     AND G.GER_ESPDOC = F.FIS_ESPDOC ';
  Result := Result + '                     AND G.GER_CODEMP = F.FIS_CODEMP ';
  Result := Result + '                     AND G.GER_TIP_FC = F.FIS_TIP_FC ';
  Result := Result + '                     AND G.GER_SERIE_ = F.FIS_SERIE_ ';
  Result := Result + '                     AND G.GER_ORIDOC = F.FIS_ORIDOC ';
  Result := Result + '                     AND IF(F.FIS_TIP_FC = "C", G.GER_CODCLI, G.GER_CODFOR) = F.FIS_FORCLI ';
  Result := Result + '   LEFT JOIN AUXMOV XG ON XG.AUX_SEQGER = G.AUTOINCREM ';

  Result := Result + '   LEFT JOIN NOTGER N ON N.GER_NUMDOC = F.FIS_NUMDOC ';
  Result := Result + '                     AND N.GER_ESPDOC = F.FIS_ESPDOC ';
  Result := Result + '                     AND N.GER_CODEMP = F.FIS_CODEMP ';
  Result := Result + '                     AND N.GER_TIP_FC = F.FIS_TIP_FC ';
  Result := Result + '                     AND N.GER_SERIE_ = F.FIS_SERIE_ ';
  Result := Result + '                     AND N.GER_ORIDOC = F.FIS_ORIDOC ';
  Result := Result + '                     AND IF(F.FIS_TIP_FC = "C", N.GER_CODCLI, N.GER_CODFOR) = F.FIS_FORCLI ';
  Result := Result + '   LEFT JOIN AUXNOT XN ON XN.AUX_SEQGER = N.AUTOINCREM';

  Result := Result + '   LEFT JOIN DEL_MOVGER GD ON GD.GER_NUMDOC = F.FIS_NUMDOC ';
  Result := Result + '                          AND GD.GER_ESPDOC = F.FIS_ESPDOC ';
  Result := Result + '                          AND GD.GER_CODEMP = F.FIS_CODEMP ';
  Result := Result + '                          AND GD.GER_TIP_FC = F.FIS_TIP_FC ';
  Result := Result + '                          AND GD.GER_SERIE_ = F.FIS_SERIE_ ';
  Result := Result + '                          AND GD.GER_ORIDOC = F.FIS_ORIDOC ';
  Result := Result + '                          AND IF(F.FIS_TIP_FC = "C", GD.GER_CODCLI, GD.GER_CODFOR) = F.FIS_FORCLI ';
  Result := Result + '   LEFT JOIN DEL_AUXMOV XGD ON XGD.AUX_SEQGER = GD.AUTOINCREM ';

  Result := Result + '   LEFT JOIN DEL_NOTGER ND ON ND.GER_NUMDOC = F.FIS_NUMDOC ';
  Result := Result + '                          AND ND.GER_ESPDOC = F.FIS_ESPDOC ';
  Result := Result + '                          AND ND.GER_CODEMP = F.FIS_CODEMP ';
  Result := Result + '                          AND ND.GER_TIP_FC = F.FIS_TIP_FC ';
  Result := Result + '                          AND ND.GER_SERIE_ = F.FIS_SERIE_ ';
  Result := Result + '                          AND ND.GER_ORIDOC = F.FIS_ORIDOC ';
  Result := Result + '                          AND IF(F.FIS_TIP_FC = "C", ND.GER_CODCLI, ND.GER_CODFOR) = F.FIS_FORCLI ';
  Result := Result + '  LEFT JOIN DEL_AUXNOT XND ON XND.AUX_SEQGER = ND.AUTOINCREM ';

  Result := Result + '   LEFT JOIN CADCLI C ON C.CLI_CODCLI = F.FIS_FORCLI ';
  Result := Result + '   LEFT JOIN CADFOR R ON R.FOR_CODFOR = F.FIS_FORCLI ';
  Result := Result + '   LEFT JOIN CADEMP E ON E.EMP_CODEMP = F.FIS_CODEMP ';
  Result := Result + '  WHERE F.FIS_ACESSO = :CHAACE ';
  Result := Result + '    AND F.FIS_ORIDOC = "V"     ';
end;

function TAuditarDocumento.fSQLDocumentosCancelados(const ANomeTabela: String; const ADias: Integer): String;
  Var
    strEspDoc: String;
begin
  strEspDoc := '"NF"';
  If (fCfgSisPainel('USASAT') <> 'S') Then
    strEspDoc := strEspDoc +  ' ,"IF"';

  Result := '';
  Result := Result + ' SELECT F.AUTOINCREM AS INCFIS,          ';
  Result := Result + '        G.AUTOINCREM AS INCDOC,          ';
  Result := Result + '        F.FIS_ACESSO AS CHAACE,          ';
  Result := Result + '        E.EMP_C_G_C_ AS C_G_C_,          ';
  Result := Result + '        G.GER_NUMDOC AS NUMDOC,          ';
  Result := Result + '        G.GER_ESPDOC AS ESPDOC,          ';
  Result := Result + '        G.GER_SERIE_ AS SERIE_,          ';
  Result := Result + '        G.GER_CODEMP AS CODEMP,          ';
  Result := Result + '        "DEL_' + ANomeTabela + '" AS TABELA, ';
  Result := Result + '        F.FIS_HISTOR AS HISTOR,          ';
  Result := Result + '        G.GER_DTAENT AS DTAENT,          ';
  Result := Result + '        G.DTADEL,                        ';

  If FExisteOpcDel Then
    Result := Result + '      G.OPCDEL,                        '
  Else
    Result := Result + '      CAST(NULL AS CHAR(2)) AS OPCDEL, ';

  If FExisteOpcDoc Then
    Result := Result + '      A.AUX_OPCDOC AS OPCDOC,          '
  Else
    Result := Result + '      CAST(NULL AS CHAR(2)) AS OPCDOC, ';

  If FExisteLogCan Then
  Begin
    Result := Result + '     (SELECT CAST(IF(COUNT(*) > 0, "EXISTE", NULL) AS CHAR(6)) FROM LOGCAN C ';
    Result := Result + '       WHERE ((C.LOG_ACESSO = F.FIS_ACESSO) OR        ';
    Result := Result + '              (C.LOG_NUMDOC = G.GER_NUMDOC AND        ';
    Result := Result + '               C.LOG_ESPDOC = G.GER_ESPDOC AND        ';
    Result := Result + '               C.LOG_CODEMP = G.GER_CODEMP AND        ';
    Result := Result + '               C.LOG_FORCLI = IFNULL(G.GER_CODCLI, G.GER_CODFOR)))) AS LOGCAN, ';
  End
  Else
  Begin
    Result := Result + '      CAST(NULL AS CHAR(6)) AS LOGCAN, '
  End;

  Result := Result + '        (SELECT NFE_OBSERV FROM LOGNFE L   ';
  Result := Result + '         WHERE L.NFE_NUMDOC = F.FIS_NUMDOC ';
  Result := Result + '           AND L.NFE_ESPDOC = F.FIS_ESPDOC ';
  Result := Result + '           AND L.NFE_CODEMP = F.FIS_CODEMP ';
  Result := Result + '           AND L.NFE_CODCLI = F.FIS_FORCLI ';
  Result := Result + '           AND L.NFE_SERIE_ = F.FIS_SERIE_) AS NFEOBS, ';
  Result := Result + '        CONCAT(G.GER_NUMDOC, "-", G.GER_ESPDOC, "-", G.GER_CODEMP, "-", G.GER_TIP_FC, "-", G.GER_SERIE_, "-", IFNULL(G.GER_CODCLI, G.GER_CODFOR)) AS DOCTIT ';
  Result := Result + '   FROM DEL_' + ANomeTabela + ' G ';
  Result := Result + '        LEFT JOIN CADFIS F ON F.FIS_NUMDOC = G.GER_NUMDOC ';
  Result := Result + '                          AND F.FIS_ESPDOC = G.GER_ESPDOC ';
  Result := Result + '                          AND F.FIS_CODEMP = G.GER_CODEMP ';
  Result := Result + '                          AND F.FIS_TIP_FC = G.GER_TIP_FC ';
  Result := Result + '                          AND F.FIS_FORCLI = IFNULL(G.GER_CODCLI, G.GER_CODFOR) ';
  Result := Result + '                          AND F.FIS_ORIDOC = G.GER_ORIDOC ';
  Result := Result + '                          AND F.FIS_SERIE_ = G.GER_SERIE_ ';
  Result := Result + '        LEFT JOIN CADEMP E ON E.EMP_CODEMP = G.GER_CODEMP ';
  Result := Result + '        LEFT JOIN CADCLI C ON C.CLI_CODCLI = G.GER_CODCLI ';
  Result := Result + '        LEFT JOIN CADFOR R ON R.FOR_CODFOR = G.GER_CODFOR ';
  Result := Result + '        LEFT JOIN NFEIMP I ON I.NFE_ACESSO = F.FIS_ACESSO ';

  If FExisteOpcDoc Or FExisteOpcDel Then
  Begin
    If (ANomeTabela = 'NOTGER') Then
      Result := Result + '    LEFT JOIN DEL_AUXNOT A ON G.AUTOINCREM = A.AUX_SEQGER '
    Else
      Result := Result + '    LEFT JOIN DEL_AUXMOV A ON G.AUTOINCREM = A.AUX_SEQGER '
  End;

  Result := Result + '  WHERE G.GER_ESPDOC IN ('+ strEspDoc +') ';
  Result := Result + '    AND G.GER_ORIDOC = "V" ';
  Result := Result + '    AND G.DTADEL >= DATE_SUB(CURRENT_DATE, INTERVAL '+IntToStr(ADias)+' DAY) ';
  Result := Result + '    AND I.NFE_ACESSO IS NULL   ';
  Result := Result + '    AND G.GER_CODEMP = :CODEMP ';
  If (ANomeTabela = 'NOTGER') Then
    Result := Result + '  AND LEFT(G.GER_CLAFIS, 1) <> "3" ';
end;

function TAuditarDocumento.fSQLDocumentosCanceladosUltimosDias(const ADias: Integer): String;
begin
  Result := Result + fSQLDocumentosCancelados('MOVGER', ADias);
  Result := Result + '  UNION ALL ';
  Result := Result + fSQLDocumentosCancelados('NOTGER', ADias);
  Result := Result + '  ORDER BY DTADEL ';
end;

procedure TAuditarDocumento.pCanceladosNoAutcom;
  Var
    LDocumentos : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    retornoFit: TRetornoNFE;

    function fVerificaInutilizacao: Boolean;
    begin
      Result := (fEmptyStr(LDocumentos.FieldByName('CHAACE').AsString))     And
                (Not fEmptyStr(LDocumentos.FieldByName('INCFIS').AsString)) And
                (Not fEmptyStr(LDocumentos.FieldByName('C_G_C_').AsString)) And
                (Not fEmptyStr(LDocumentos.FieldByName('SERIE_').AsString)) And
                (Not fEmptyStr(LDocumentos.FieldByName('NUMDOC').AsString));
    end;

    procedure pCarregaLogTmp(const strRetFit, strSituacao: String; strSolucao: String='');
    begin
      If (strSituacao <> cnsOK) Or (FLogarLocal) Then
      Begin
        If (strSituacao <> cnsOK) Then
          Inc(FInconsistenc);

        FLogAux.Add(Concat(LDocumentos.FieldByName('DOCTIT').AsString,'|',
                           LDocumentos.FieldByName('TABELA').AsString,'|',
                           LDocumentos.FieldByName('DTAENT').AsString,'|',
                           LDocumentos.FieldByName('DTADEL').AsString,'|',
                           LDocumentos.FieldByName('LOGCAN').AsString,'|',
                           LDocumentos.FieldByName('OPCDEL').AsString,'|',
                           LDocumentos.FieldByName('OPCDOC').AsString,'|',
                           strSolucao,'|',
                           LDocumentos.FieldByName('INCDOC').AsString,'|',
                           LDocumentos.FieldByName('INCFIS').AsString,'|',
                           LDocumentos.FieldByName('CHAACE').AsString,'|',
                           LDocumentos.FieldByName('HISTOR').AsString,'|',
                           fBlinda(strRetFit),'|',
                           strSituacao));
      End;
    end;

begin
  FInconsistenc := 0;

  FLogAux.Add('>B[T] LADO: CANCELADOS NO AUTCOM E NÃO CANCELADOS NA '+FServico);
  FLogAux.Add('>C DOCUMENTO [NUM-ESP-EMP-TFC-SER-CLI]|TABELA|DT. EMIS.|DT. CANC.|LOGCAN|OPCDEL|OPCDOC|SOLUÇÃO|INCDOC|INCFIS|CHAVE ACESSO|HISTÓRICO CADFIS|RETORNO ('+FServico+')|DETALHAMENTO DA SITUAÇÃO');

  LDocumentos := fCriaQuery(nil, FConnection);
  Try
    FTarefa.pAtualizarInformacao(FTarefa.strDescricao);

    //PREPARAÇÃO...
    LDocumentos.SQL.Text := fSQLDocumentosCanceladosUltimosDias(FIntevaloDias);
    LDocumentos.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LDocumentos.Open;
    LDocumentos.First;
    //...PREPARAÇÃO

    //PROCESSAMENTO...
    While Not LDocumentos.Eof Do
    Begin
      FTarefa.pSinalizarExecutando;

      If FTarefa.blnBloquear Then
        Break;

      FTarefa.pAtualizarInformacao(FTarefa.strDescricao + ' AUT > ' + Copy(FServico,1,3) + ' ' + LDocumentos.FieldByName('DOCTIT').AsString);

      If (FMenorDtaEnt = 0) Or (LDocumentos.FieldByName('DTAENT').AsDateTime < FMenorDtaEnt) Then
        FMenorDtaEnt := LDocumentos.FieldByName('DTAENT').AsDateTime;

      If (LDocumentos.FieldByName('HISTOR').AsString = 'CANCELADO') And
         (fEmptyStr(LDocumentos.FieldByName('CHAACE').AsString)) And
         (Not fEmptyStr(LDocumentos.FieldByName('INCFIS').AsString)) And
         (Not fEmptyStr(LDocumentos.FieldByName('INCDOC').AsString)) And
         (fEhRejeicaoPorDuplicidadeComDiferencaNaChaveDeAcesso(LDocumentos.FieldByName('NFEOBS').AsString)) Then
      Begin
        //CASO 1
        pCarregaLogTmp('Rejeição: Duplicidade de NF-e com diferença na Chave de Acesso', cnsOK);

        LDocumentos.Next;
        Continue;
      End;

      If (fVerificaInutilizacao) Then
      Begin
        retornoFit := AuditarDocumento.fConsultaSituacaoInutilizacaoTraduzido(LDocumentos.FieldByName('C_G_C_').AsString,
                                                                              LDocumentos.FieldByName('SERIE_').AsString,
                                                                              LDocumentos.FieldByName('NUMDOC').AsString+IIF(LDocumentos.FieldByName('ESPDOC').AsString='IF','|65',''));

        If retornoFit.Inutilizada Or retornoFit.Denegada Then
        begin
          pCarregaLogTmp(retornoFit.Mensagem, cnsOK);
        end
        Else
        Begin
          //CASO 2
          pCarregaLogTmp('', 'CANCELADO: NO AUTCOM [SIM] / NA '+FServico+' [NÃO] (FIS_ACESSO = NULL, sugere que deveria estar "DENEGADA" ou "INUTILIZADA")', 'Consultar situação no site da '+FServico+', restaurar da DEL e realizar operação correta no Autcom');
        end;

        LDocumentos.Next;
        Continue;
      End;

      If (fEmptyStr(LDocumentos.FieldByName('CHAACE').AsString)) And
         (fEmptyStr(LDocumentos.FieldByName('INCFIS').AsString)) Then
      Begin
        //CASO 3
        pCarregaLogTmp('', 'CANCELADO: NO AUTCOM [SIM] / NA '+FServico+' [???] (Existe DEL_MOVGER/DEL_NOTGER porém sem CADFIS relacionada (CADFIS foi apagada via banco ?))', 'Restaurar CADFIS correspondente no Autcom e após, CANCELAR/INUTILIZAR');

        LDocumentos.Next;
        Continue;
      End;

      retornoFit := AuditarDocumento.fConsultaStatusDFeTraduzido(LDocumentos.FieldByName('CHAACE').AsString);

      If (retornoFit.Denegada Or retornoFit.Cancelada Or retornoFit.Inutilizada) Then
      begin
        pCarregaLogTmp(retornoFit.Mensagem, cnsOK)
      end
      Else
      Begin
        //CASO 4
        pCarregaLogTmp(retornoFit.Mensagem, 'CANCELADO: NO AUTCOM [SIM] / NA '+FServico+' [NÃO] (Deveria estar "CANCELADA" na Sovos)', 'CANCELAR na Sovos, ou resturar da DEL para CANCELAR no Autcom');
      End;

      LDocumentos.Next;
    End;
    //...PROCESSAMENTO

  Finally
    If (FInconsistenc > 0) Then
      FLogarErros := True;

    If (FInconsistenc = 0)  Then
      FLogAux.Add('>B[B] NÃO EXISTEM DOCUMENTOS COM PROBLEMA');

    FreeAndNil(LDocumentos);
  End;
end;

procedure TAuditarDocumento.pCanceladosNaSovos;
  Var
    LDocumentos : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    LLstChv : TStringList;
    LPeriodo: Integer;
    LIntIdx:  Integer;
    LdtaLis,
    LdtaIni,
    LdtaFin: TDateTime;
    LChaAce: String;

    procedure pCarregaListaChave(const strLis: WideString);
      Var
        lstAux: TStringList;
        intIdx: Integer;
        strChv: String;
    begin
      lstAux := TStringList.Create;
      lstAux.Text := strLis;
      Try
        For intIdx := 0 To lstAux.Count-1 Do
        Begin
          strChv := lstAux[intIdx];
          If (Length(strChv) = 44) And (LLstChv.IndexOf(strChv) = -1) Then
            LLstChv.Add(strChv);
        End;
      Finally
        FreeAndNil(lstAux);
      End;
    end;

    procedure pCarregaLogTmp(const strSituacao: String; strSolucao: String='');
    begin
      If (strSituacao <> cnsOK) Or (FLogarLocal) Then
      Begin
        If (strSituacao <> cnsOK) Then
          Inc(FInconsistenc);

        FLogAux.Add(Concat(LChaAce,'|',
                           LDocumentos.FieldByName('DOCTIT').AsString,'|',
                           strSolucao,'|',
                           LDocumentos.FieldByName('INCFIS').AsString,'|',
                           LDocumentos.FieldByName('HISTOR').AsString,'|',
                           LDocumentos.FieldByName('TABELA').AsString,'|',
                           LDocumentos.FieldByName('DTADEL').AsString,'|',
                           LDocumentos.FieldByName('LOGCAN').AsString,'|',
                           LDocumentos.FieldByName('OPCDEL').AsString,'|',
                           LDocumentos.FieldByName('OPCDOC').AsString,'|',
                           FormatFloat('#,##0.00', LDocumentos.FieldByName('VLRFIS').AsFloat),'|',
                           strSituacao));
      End;
    end;

begin
  FInconsistenc := 0;

  FLogAux.Add('>L');
  FLogAux.Add('>L');
  FLogAux.Add('>B[T] LADO: CANCELADOS NA '+FServico+' E NÃO CANCELADOS NO AUTCOM');
  FLogAux.Add('>C CHAVE ACESSO|DOCUMENTO [NUM-ESP-EMP-TFC-SER-CLI]|SOLUÇÃO|INCFIS|HISTÓRICO CADFIS|TABELA|DT. CANC.|LOGCAN|OPCDEL|OPCDOC|VL. CADFIS|DETALHAMENTO DA SITUAÇÃO');

  LDocumentos := fCriaQuery(nil, FConnection);
  LDocumentos.SQL.Text := fSQLDocumentoPorChave;

  LLstChv := TStringList.Create;
  Try
    FTarefa.pAtualizarInformacao(FTarefa.strDescricao);

    //PREPARAÇÃO...
    LdtaFin := DateOf(nOw());
    LdtaIni := IncDay(DateOf(nOw()), -FIntevaloDias);

    If (FMenorDtaEnt > 0) And (FMenorDtaEnt < LdtaIni) Then
      LdtaIni := FMenorDtaEnt;

    FTarefa.pAtualizarInformacao(FTarefa.strDescricao + ' Cancelamentos de: ' +FormatDateTime('dd/mm/yyyy',LdtaIni)+' à '+FormatDateTime('dd/mm/yyyy',LdtaFin));

    pCarregaListaChave(AuditarDocumento.fRetornaListaCanceladasPorDataCancelamento(FCodEmpFit, '', LdtaIni, LdtaFin, NFe));
    pCarregaListaChave(AuditarDocumento.fRetornaListaCanceladasPorDataCancelamento(FCodEmpFit, '', LdtaIni, LdtaFin, NFCe));

    If (LLstChv.Count >= 1000) Then
    Begin
      //SE MAIOR QUE 1000, VAI DIA A DIA PARA GARANTIR QUE TODAS AS CHAVES SERÃO CARREGADAS
      LLstChv.Clear;
      LPeriodo := Abs(DaysBetween(LdtaFin, LdtaIni));
      LdtaLis  := DateOf(nOw());

      Repeat
        FTarefa.pSinalizarExecutando;

        If FTarefa.blnBloquear Then
          Break;

        FTarefa.pAtualizarInformacao(FTarefa.strDescricao + ' Cancelamentos em: ' + FormatDateTime('dd/mm/yyyy',LdtaLis) + ' AUT < '+ Copy(FServico,1,3));

        pCarregaListaChave(AuditarDocumento.fRetornaListaCanceladasPorDataCancelamento(FCodEmpFit, '', LdtaLis, LdtaLis, NFe));
        pCarregaListaChave(AuditarDocumento.fRetornaListaCanceladasPorDataCancelamento(FCodEmpFit, '', LdtaLis, LdtaLis, NFCe));

        LdtaLis := IncDay(LdtaLis, -1);

        LPeriodo := LPeriodo -1;

      Until LPeriodo < 0;
    End;
    //...PREPARAÇÃO

    //PROCESSAMENTO
    For LIntIdx := 0 To LLstChv.Count-1 Do
    Begin
      LChaAce := LLstChv[LIntIdx];

      FTarefa.pSinalizarExecutando;

      If FTarefa.blnBloquear Then
        Break;

      FTarefa.pAtualizarInformacao(FTarefa.strDescricao + ' AUT < ' + Copy(FServico,1,3) + ' ' + Copy(LChaAce,1,33));

      LDocumentos.Close;
      LDocumentos.ParamByName('CHAACE').AsString := LChaAce;
      LDocumentos.Open;

      If (Not fEmptyStr(LDocumentos.FieldByName('CODEMP').AsString)) And
         (LDocumentos.FieldByName('CODEMP').AsString <> VS_strCodEmp) Then
      Begin
        LDocumentos.Next;
        Continue;
      End;

      If fDocumentoCancelado(LDocumentos) Then
      Begin
        pCarregaLogTmp(cnsOK)
      End
      Else If fDocumentoCanceladoComValorCadFis(LDocumentos) Then
      Begin
        //CASO 1
        pCarregaLogTmp('CANCELADO: NA '+FServico+' [SIM] / NO AUTCOM [???] (Documento cancelado no Autcom mas ainda possui valores preenchidos FIS_VLCON1, FIS_VLCON2, etc...na CADFIS)', 'Zerar os valores no livro fiscal');
      End
      Else If (Not LDocumentos.FieldByName('INCDOC').IsNull) Then
      Begin
        //CASO 2
        pCarregaLogTmp('CANCELADO: NA '+FServico+' [SIM] / NO AUTCOM [NÃO] (Documento ainda está na MOVGER/NOTGER)', 'CANCELAR no Autcom');
      End
      Else If (Not LDocumentos.FieldByName('INCFIS').IsNull) And (LDocumentos.FieldByName('TABELA').IsNull) Then
      Begin
        //CASO 3
        pCarregaLogTmp('CANCELADO: NA '+FServico+' [SIM] / NO AUTCOM [???] (CADFIS com histórico incompatível à um documento cancelado. Não possui MOVGER/NOTGER/DEL_MOVGER/DEL_NOTGER)', 'Zerar os valores no livro fiscal e mudar histórico para CANCELADO');
      End
      Else If (Not LDocumentos.FieldByName('INCFIS').IsNull) And (Pos('DEL_', LDocumentos.FieldByName('TABELA').AsString) > 0) Then
      Begin
        //CASO 4
        pCarregaLogTmp('CANCELADO: NA '+FServico+' [SIM] / NO AUTCOM [???] (CADFIS com histórico incompatível à um documento cancelado', 'Mudar histórico para CANCELADO');
      End
      Else
      Begin
        //CASO 5
        pCarregaLogTmp('CANCELADO: NA '+FServico+' [SIM] / NO AUTCOM [???] (Esssa chave pertence a empresa '+VS_strCodEmp+'?)', 'Inconsistência indefinida. Consultar situação no site '+FServico);
      End;
    End;
    //...PROCESSAMENTO

  Finally
    If (FInconsistenc > 0) Then
      FLogarErros := True;

    If (FInconsistenc = 0)  Then
      FLogAux.Add('>B[B] NÃO EXISTEM DOCUMENTOS COM PROBLEMA');

    FreeAndNil(LDocumentos);
    FreeAndNil(LLstChv);
  End;
end;

procedure TAuditarDocumento.pCarimbaUltimaExecucao;
  Var
    qryAux : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  If fCampoExiste('NFE_LOCAL', 'NFE_ULTAUD') And
     fCampoExiste('NFE_LOCAL', 'NFE_HORULT') Then
  Begin
    qryAux := fCriaQuery(nil, FConnection);
    Try
      qryAux.Close;
      qryAux.SQL.Text := 'UPDATE NFE_LOCAL SET NFE_ULTAUD = CURRENT_TIMESTAMP WHERE NFE_CODEMP = "'+VS_strCodEmp+'" AND DATE(NFE_HORULT) = CURRENT_DATE LIMIT 1;';
      qryAux.ExecSQL;
    Finally
      FreeAndNil(qryAux);
    End;
  End;
end;

procedure TAuditarDocumento.pLogarLocal;
  Var
    dtaFileDateTime: TDateTime;
    intIdx: Integer;
begin
  If (Not FLogarLocal) Then
    Exit;

  If FileExists(FArqRel) Then
  Begin
    Try
      FileAge(FArqRel,dtaFileDateTime);

      If (dtaFileDateTime < Date) Then
      Begin
        SysUtils.DeleteFile(FArqRel);
        Exit;
      End;
    Except
      //
    End;
  End;

  FLogErr.SaveToFile(FArqRel);
  FLogErr.Clear;
  FLogAux.Clear;

  FLogErr.LoadFromFile(FArqRel);
  For intIdx := 0 To FLogErr.Count -1 Do
  Begin
    If (Pos('| OK  ', FLogErr[intIdx]) = 0) Then
      FLogAux.Add(FLogErr[intIdx]);
  End;

  FLogErr.Text := FLogAux.Text;
end;

procedure TAuditarDocumento.Executar;
begin
  If (FCodEmpFit = '') Then
  Begin
    Exit;
  End;

  FLogErr.Clear;
  FLogAux.Clear;

  FLogAux.Add('>B/C AUDITORIA DE DOCUMENTOS CANCELADOS [LICENÇA: '+objConfigSovos.strFitLicenca+'  -  EMP: '+VS_strCodEmp+'  ***  ID_'+FServico+': '+FCodEmpFit+']');
  FLogAux.Add('>L');
  FLogAux.Add('>L');
  FLogarErros := False;

  Try
    pCanceladosNoAutcom;
    pCanceladosNaSovos;

    FLogAux.Add('>L');
    FLogAux.Add('>L');
    FLogAux.Add('>L [???] = (Olhar a coluna LOGCAN. Se tiver o texto "EXISTE" é porque cancelou via Autcom mas houve falha, senão, indica possível manipulação por fora do sistema!)');

    If (Not FExisteLogCan) Or (fCampoTabela('COUNT(*)', 'LOGCAN', ['LOG_CODEMP'], [VS_strCodEmp], FConnection) = 0) Then
      FLogAux.Add('>L Essa empresa não possui registros na LOGCAN');

    FTarefa.pAtualizarInformacao(FTarefa.strDescricao + ' Finalizando Relatório');

    FLogErr.Add(fTabulaTexto(FLogAux));

    pLogarLocal;

    If (FLogarErros) Then
       pGravaLogErr('[AUDIT-120-DOCERRCANCEL]', FLogErr.Text, True);
  Finally
    If (Not FTarefa.blnBloquear) Then
      pCarimbaUltimaExecucao;
  End;
end;

end.
