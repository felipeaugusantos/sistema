unit untComplementarDocumento;

interface

uses
  {$IF Defined(UNIDAC)}
    Uni, UniSQLMonitor, MemDS, DBAccess
  {$ELSE}
    ZConnection, ZDataset
  {$IFEND}
  ,untRegistrarTarefa
  ,untInterfaces;

const
  cnstTagTipCom: String = '<TAG_TIP_COM>';

type
  TComplementarDocumento = class
  private
    FIntevaloDias: Integer;
    FConnection: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND};
    FTarefa : TRegistrarTarefa;
    function fAndSQLNFeNFCeAcessoOuFisAcessoNull: String;
    function fAndSQLNFeNFCeSemXml: String;
    procedure pInsereSQLBase(var AQry: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND});
    function fGerarDFeXml(ATipDFe: TTipDfe; AChaveAcesso: String; var AMensagem: String): Boolean;
    procedure pCarimbaUltimaExecucao;
  public
    procedure Executar;
    constructor Create(const ATarefa: TRegistrarTarefa);
  End;

implementation

uses
{$IFDEF LINUX}
  NFe.Utils,
  NFe.Modulo,
{$ELSE}
  untUtil,
  untModulo,
  Forms,
{$ENDIF}
  SysUtils, Variants, DB, StrUtils, untDicSis,
  untLibNfe;

{ TComplementarDocumento }

constructor TComplementarDocumento.Create(const ATarefa: TRegistrarTarefa);
begin
  inherited Create;
  FTarefa := ATarefa;
  FConnection := frmModulo.Database;
  FIntevaloDias := 8;
end;

procedure TComplementarDocumento.pCarimbaUltimaExecucao;
  Var
    qryAux : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  If fCampoExiste('NFE_LOCAL', 'NFE_ULTCPL') And
     fCampoExiste('NFE_LOCAL', 'NFE_HORULT') Then
  Begin
    qryAux := fCriaQuery(nil, FConnection);
    Try
      qryAux.Close;
      qryAux.SQL.Text := 'UPDATE NFE_LOCAL SET NFE_ULTCPL = CURRENT_TIMESTAMP WHERE NFE_CODEMP = "'+VS_strCodEmp+'" AND DATE(NFE_HORULT) = CURRENT_DATE LIMIT 1;';
      qryAux.ExecSQL;
    Finally
      FreeAndNil(qryAux);
    End;
  End;
end;

procedure TComplementarDocumento.pInsereSQLBase(var AQry: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND});
begin
  AQry.Close;
  AQry.SQL.Clear;
  AQry.SQL.Add('SELECT F.FIS_DTAENT, F.FIS_ACESSO, F.FIS_NUMDOC, F.FIS_ESPDOC, ');
  AQry.SQL.Add('       F.FIS_CODEMP, F.FIS_SERIE_, F.FIS_HISTOR, F.FIS_FORCLI, ');
  AQry.SQL.Add('       F.FIS_TIP_FC, L.NFE_STATUS, L.NFE_OBSERV,               ');
  AQry.SQL.Add('       IFNULL(NFE_PNDPEC, 0) AS NFE_PNDPEC,                    ');
  AQry.SQL.Add('       DATEDIFF(CURRENT_DATE, F.FIS_DTAENT) AS "NFE_QTDDIA"    ');
  AQry.SQL.Add('  FROM CADFIS F ');
  AQry.SQL.Add(' INNER JOIN EMPRESAS_NESTE_SERVIDOR S ON F.FIS_CODEMP = S.SRV_CODEMP     ');
  AQry.SQL.Add('  LEFT JOIN XMLNFE X                  ON F.FIS_ACESSO = X.NFE_ACESSO     ');
  AQry.SQL.Add('  LEFT JOIN NFEIMP I                  ON F.FIS_ACESSO = I.NFE_ACESSO     ');
  AQry.SQL.Add('  LEFT JOIN LOGNFE L                  ON L.NFE_NUMDOC = F.FIS_NUMDOC AND ');
  AQry.SQL.Add('                                         L.NFE_ESPDOC = F.FIS_ESPDOC AND ');
  AQry.SQL.Add('                                         L.NFE_CODEMP = F.FIS_CODEMP AND ');
  AQry.SQL.Add('                                         L.NFE_CODCLI = F.FIS_FORCLI AND ');
  AQry.SQL.Add('                                         L.NFE_TIP_FC = F.FIS_TIP_FC AND ');
  AQry.SQL.Add('                                         F.FIS_ORIDOC = "V"              ');
  AQry.SQL.Add('WHERE TRUE ');
  AQry.SQL.Add('  AND F.FIS_CODEMP = :CODEMP ');
  AQry.SQL.Add('  AND F.FIS_DTAENT >= (SELECT SUBDATE(CURRENT_DATE, INTERVAL '+IntToStr(FIntevaloDias)+' DAY)) ');
  AQry.SQL.Add('  AND F.FIS_DTAENT < CURRENT_DATE ');
  AQry.SQL.Add('  AND F.FIS_ESPDOC = "NF" ');
  AQry.SQL.Add('  AND F.FIS_ORIDOC = "V"  ');
  AQry.SQL.Add('  AND F.FIS_HISTOR NOT LIKE "%CANCEL%"     ');
  AQry.SQL.Add('  AND F.FIS_HISTOR NOT LIKE "%DENEGAD%"    ');
  AQry.SQL.Add('  AND F.FIS_HISTOR NOT LIKE "%INUTILIZAD%" ');
  AQry.SQL.Add('  AND L.NFE_STATUS = "AT" ');
  AQry.SQL.Add(cnstTagTipCom);

  If (fCfgSisPainel('USASAT') <> 'S') Then
  Begin
    AQry.SQL.Add('UNION ALL ');

    AQry.SQL.Add('SELECT F.FIS_DTAENT, F.FIS_ACESSO, F.FIS_NUMDOC, F.FIS_ESPDOC, ');
    AQry.SQL.Add('       F.FIS_CODEMP, F.FIS_SERIE_, F.FIS_HISTOR, F.FIS_FORCLI, ');
    AQry.SQL.Add('       F.FIS_TIP_FC, L.NFE_STATUS, L.NFE_OBSERV,               ');
    AQry.SQL.Add('       IFNULL(NFE_PNDPEC, 0) AS NFE_PNDPEC,                    ');
    AQry.SQL.Add('       DATEDIFF(CURRENT_DATE, F.FIS_DTAENT) AS "NFE_QTDDIA"    ');
    AQry.SQL.Add('  FROM CADFIS F ');
    AQry.SQL.Add(' INNER JOIN EMPRESAS_NESTE_SERVIDOR S ON F.FIS_CODEMP = S.SRV_CODEMP     ');
    AQry.SQL.Add('  LEFT JOIN XMLNFE X                  ON F.FIS_ACESSO = X.NFE_ACESSO     ');
    AQry.SQL.Add('  LEFT JOIN NFEIMP I                  ON F.FIS_ACESSO = I.NFE_ACESSO     ');
    AQry.SQL.Add('  LEFT JOIN LOGNFE L                  ON L.NFE_NUMDOC = F.FIS_NUMDOC AND ');
    AQry.SQL.Add('                                         L.NFE_ESPDOC = F.FIS_ESPDOC AND ');
    AQry.SQL.Add('                                         L.NFE_CODEMP = F.FIS_CODEMP AND ');
    AQry.SQL.Add('                                         L.NFE_CODCLI = F.FIS_FORCLI AND ');
    AQry.SQL.Add('                                         L.NFE_TIP_FC = F.FIS_TIP_FC AND ');
    AQry.SQL.Add('                                         F.FIS_ORIDOC = "V"              ');
    AQry.SQL.Add('WHERE TRUE ');
    AQry.SQL.Add('  AND F.FIS_CODEMP = :CODEMP ');
    AQry.SQL.Add('  AND F.FIS_DTAENT >= (SELECT SUBDATE(CURRENT_DATE, INTERVAL '+IntToStr(FIntevaloDias)+' DAY)) ');
    AQry.SQL.Add('  AND F.FIS_DTAENT < CURRENT_DATE ');
    AQry.SQL.Add('  AND F.FIS_ESPDOC = "IF" ');
    AQry.SQL.Add('  AND F.FIS_ORIDOC = "V"  ');
    AQry.SQL.Add('  AND F.FIS_HISTOR NOT LIKE "%CANCEL%"     ');
    AQry.SQL.Add('  AND F.FIS_HISTOR NOT LIKE "%DENEGAD%"    ');
    AQry.SQL.Add('  AND F.FIS_HISTOR NOT LIKE "%INUTILIZAD%" ');
    AQry.SQL.Add('  AND (IFNULL(F.FIS_NUMSER,"") = "") AND (IFNULL(F.FIS_NUMCOO,"") = "") /*SOMENTE NFCe*/ ');
    AQry.SQL.Add('  AND L.NFE_STATUS = "AT" ');
    AQry.SQL.Add(cnstTagTipCom);
  End;
end;

function TComplementarDocumento.fAndSQLNFeNFCeAcessoOuFisAcessoNull: String;
begin
  Result := '  AND ((IFNULL(F.FIS_ACESSO, "") = "") OR (IFNULL(L.NFE_ACESSO, "") = "")) ';
end;

function TComplementarDocumento.fAndSQLNFeNFCeSemXml: String;
begin
  Result := '  AND X.NFE_ARQXML IS NULL '+
            '  AND I.NFE_ARQXML IS NULL '+
            '  AND IFNULL(F.FIS_ACESSO, "") <> "" '+
            '  AND IFNULL(L.NFE_ACESSO, "") <> "" ';
end;

procedure TComplementarDocumento.Executar;
  Var
    libNfe: TLibNfe;
    LPendentes : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    LMensagem : String;
    LMensagemErro : String;
    LRecusadaRejeitada: Boolean;
    LContingenciaAutorizada: Boolean;
    LRegenerando: Boolean;
    LTipDFe: TTipDfe;

    procedure pLogarErros(const strTit: String);
      Var
        strAux: String;
    begin
      strAux := '';
      strAux := strAux + strTit + #13;
      strAux := strAux + 'DOCUMENTO............: '+ Concat(LPendentes.FieldByName('FIS_NUMDOC').AsString, '-',
                                                           LPendentes.FieldByName('FIS_ESPDOC').AsString, '-',
                                                           LPendentes.FieldByName('FIS_CODEMP').AsString, '-',
                                                           LPendentes.FieldByName('FIS_SERIE_').AsString, '-',
                                                           LPendentes.FieldByName('FIS_FORCLI').AsString) + #13;
      strAux := strAux + 'DIAS DESDE A EMISSÃO.: '+ LPendentes.FieldByName('NFE_QTDDIA').AsString + #13;
      strAux := strAux + 'SQL UTILIZADO........: '+ #13#13 + LPendentes.SQL.Text + #13;

      pGravaLogErr('[AUDIT-5995-DOCSEMXML]', strAux, True);
    end;

begin
  If (Not fTabelaExiste('XMLNFE', FConnection)) Then
    Exit;
  If (Not fTabelaExiste('EMPRESAS_NESTE_SERVIDOR', FConnection)) Then
    Exit;
  If (Not fTabelaExiste('NFEIMP', FConnection)) Then
    Exit;

  LRegenerando := True;

  LPendentes := fCriaQuery(nil, FConnection);
  Try
    FTarefa.pAtualizarInformacao(FTarefa.strDescricao);

    //TAREFA 1
    {**************************************************************************}
    {* NFe/NFCe EMITIDAS E AUTORIZADAS (SEM FIS_ACESSO E/OU NFE_ACESSO)       *}
    {**************************************************************************}
    pInsereSQLBase(LPendentes);
    LPendentes.SQL.Text := AnsiReplaceStr(LPendentes.SQL.Text, cnstTagTipCom, fAndSQLNFeNFCeAcessoOuFisAcessoNull);
    LPendentes.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LPendentes.Open;
    LPendentes.First;

    If (Not LPendentes.IsEmpty) Then
      libNfe := TLibNfe.Create(FConnection);

    While Not LPendentes.Eof Do
    Begin
      FTarefa.pSinalizarExecutando;

      If FTarefa.blnBloquear Then
       Break;

      If (LPendentes.FieldByName('NFE_PNDPEC').AsInteger > 0) Then
      Begin
        LPendentes.Next;
        Continue;
      End;

      FTarefa.pAtualizarInformacao(FTarefa.strDescricao +' '+ Concat(LPendentes.FieldByName('FIS_NUMDOC').AsString, '-',
                                                                     LPendentes.FieldByName('FIS_ESPDOC').AsString, '-',
                                                                     LPendentes.FieldByName('FIS_CODEMP').AsString));

      If libNfe.fAcertaChaveAcessoNotaFiscal(LPendentes.FieldByName('FIS_NUMDOC').AsString,
                                             LPendentes.FieldByName('FIS_ESPDOC').AsString,
                                             LPendentes.FieldByName('FIS_CODEMP').AsString,
                                             LPendentes.FieldByName('FIS_SERIE_').AsString,
                                             LPendentes.FieldByName('FIS_FORCLI').AsString,
                                             LPendentes.FieldByName('FIS_TIP_FC').AsString,
                                             LRecusadaRejeitada,
                                             LMensagemErro,
                                             LContingenciaAutorizada,
                                             LRegenerando) Then
      Begin
        //
      End
      Else
      Begin
        pLogarErros('NFe/NFCe EMITIDAS E AUTORIZADAS (SEM FIS_ACESSO E/OU NFE_ACESSO)');
      End;

      LPendentes.Next;
    End;


    //TAREFA 2
    {**************************************************************************}
    {* NFe/NFCe EMITIDAS E AUTORIZADAS (SEM XMLNFE)                           *}
    {**************************************************************************}
    pInsereSQLBase(LPendentes);
    LPendentes.SQL.Text := AnsiReplaceStr(LPendentes.SQL.Text, cnstTagTipCom, fAndSQLNFeNFCeSemXml);
    LPendentes.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LPendentes.Open;
    LPendentes.First;

    While Not LPendentes.Eof Do
    Begin
      FTarefa.pSinalizarExecutando;

      If FTarefa.blnBloquear Then
       Break;

      If (LPendentes.FieldByName('NFE_PNDPEC').AsInteger > 0) Then
      Begin
        LPendentes.Next;
        Continue;
      End;

      FTarefa.pAtualizarInformacao(FTarefa.strDescricao +' '+ Concat(LPendentes.FieldByName('FIS_NUMDOC').AsString, '-',
                                                                     LPendentes.FieldByName('FIS_ESPDOC').AsString, '-',
                                                                     LPendentes.FieldByName('FIS_CODEMP').AsString));
      LTipDFe := ENulo;
      If (LPendentes.FieldByName('FIS_ESPDOC').AsString = 'NF') Then
        LTipDFe := NFe
      Else If (LPendentes.FieldByName('FIS_ESPDOC').AsString = 'IF') Then
        LTipDFe := NFCe;

      If (LTipDFe <> ENulo) Then
      Begin
        If fGerarDFeXml(LTipDFe, LPendentes.FieldByName('FIS_ACESSO').AsString, LMensagem) Then
        Begin
          //
        End;

        If (fCampoTabela('COUNT(*)', 'XMLNFE', ['NFE_ACESSO'], [LPendentes.FieldByName('FIS_ACESSO').AsString], FConnection) = 0) Then
          pLogarErros('NFe/NFCe EMITIDAS E AUTORIZADAS (SEM XMLNFE)');
      End;

      LPendentes.Next;
    End;
  Finally
    If (Not FTarefa.blnBloquear) Then
      pCarimbaUltimaExecucao;

    If Assigned(LPendentes) Then
      FreeAndNil(LPendentes);

    If Assigned(libNfe) Then
      FreeAndNil(libNfe);
  End;
end;

function TComplementarDocumento.fGerarDFeXml(ATipDFe: TTipDfe; AChaveAcesso: String; var AMensagem: String): Boolean;
var
  LTipo: String;
  LEmpresa: String;
  LImpressora: String;
  LComando: String;
  LNfeImprimirExe: String;
  LAguardarAteTerminar: Boolean;
begin
  Result := False;

  LNfeImprimirExe := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'NFeImpressao.exe';
  LAguardarAteTerminar := True;

  If Not FileExists(LNfeImprimirExe) then
  Begin
    AMensagem := 'Arquivo não existe: ' + LNfeImprimirExe;
    Exit;
  End;

  Case ATipDFe of
    NFe  : LTipo := 'NFE';
    NFCe : LTipo := 'NFCE';
  End;

  LTipo       := LTipo + '_GERAR_XML';
  LEmpresa    := VS_strCodEmp;
  LImpressora := 'NENHUMA';

  Try
    LComando := fTagComValorToParam(LTipo,           consTagParamsTrf) +
                fTagComValorToParam(LEmpresa,        consTagParamsEmp) +
                fTagComValorToParam(AChaveAcesso,    consTagParamsChv) +
                fTagComValorToParam(LImpressora,     consTagParamsImp) +
                fTagComValorToParam(VS_PidMD5DicSis, consTagParamsPid, mpiNaoIncluirTagSeValorVazio);

    StartProcess(LNfeImprimirExe, LComando, False, LAguardarAteTerminar);

    Result := True;
  Except
    On E: Exception Do
    Begin
      AMensagem := E.Message;
    End;
  End;
end;

end.
