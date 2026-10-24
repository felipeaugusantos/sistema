unit untTEnviaRegistrosFaturadosFusion;

interface

uses
  Data.DB,
  System.Classes,
  System.SysUtils,
  System.StrUtils,
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  Uni,
  CRAccess,
  untUtilMonitor,
//  untLegenda,
  Vcl.ExtCtrls,
  UniClientDataSet,
  untFuncoesSimples,
{$ENDIF LINUX}
  untFuncoesGenerica,
  System.Generics.Collections,
  System.DateUtils;

const
  spIdMonitorEnviaRegFusion           = 'MONITOR_ENVIA_REG_FUSION_%s';
  spIdInactivityMonitorEnviaRegFusion = 'TESTE_INATIVIDADE_ENVIA_REG_FUSION_%s';
  spEnviaRegMonitorExeName              = 'EnviaRegistrosFusion.exe';
  spTimeLimitMonitorEnviaRegFusion    = 30;
  spAttemptsLockMonitorEnviaRegFusion = 30;

  { *** PADRÃO *** }
  sqlCamposAEnviar                    = 'SELECT '+
                                        '  G.AUTOINCREM SEQGER, '+
                                        '  CONCAT(G.GER_NUMDOC, G.GER_ESPDOC, G.GER_CODEMP) AS DOCERP, '+
                                        '  G.GER_NUMDOC AS NUMDOC, '+
                                        '  G.GER_ESPDOC AS ESPDOC, '+
                                        '  G.GER_CODEMP AS EMPDOC, '+
                                        '  G.GER_CODCLI AS CODCLI, '+
                                        '  C.CLI_NOMCLI, '+
                                        '  CONCAT(G.GER_NUMDOC, "-", G.GER_ESPDOC, "-", G.GER_CODEMP) AS DOCUMENTO, '+
                                        '  CONCAT(G.GER_CODVEN ,"-", V.OPE_NOMOPE) AS NOMVEN, '+
                                        '  C.CLI_EMAIL_, '+
                                        '  C.CLI_EMAIL2, '+
                                        '  C.CLI_EMAIL3, '+
                                        '  C.CLI_C_G_C_, '+
                                        '  C.CLI_DTACAD, '+
                                        '  C.CLI_ULTCOM, '+
                                        '  G.GER_DTAENT AS DTAEMI, '+
                                        '  G.GER_CODFPG AS CODFPG, '+
                                        '  G.GER_DTAENT AS DTAFAT, '+
                                        '  G.GER_HORENT AS HORENT, '+
                                        '  G.GER_VLRCON AS VLRCON, '+
                                        '  G.GER_PESLIQ AS PESLIQ, '+
                                        '  C.CLI_ENDERE, '+
                                        '  C.CLI_ENDNUM, '+
                                        '  C.CLI_ENDCOM, '+

                                        '  IF(TR.TRA_CODTRA IS NULL,  '+
                                        '     IFNULL(EC.ETC_ENDENT, EC2.ETC_ENDENT), '+
                                        '     TR.TRA_ENDERE) AS ETC_ENDENT,  '+

                                        '  IF(TR.TRA_CODTRA IS NULL,  '+
                                        '     IFNULL(EC.ETC_CEPENT, EC2.ETC_CEPENT), '+
                                        '     TR.TRA_C_E_P_ ) AS ETC_CEPENT, '+

                                        '  IF(TR.TRA_CODTRA IS NULL,  '+
                                        '     IFNULL(EC.ETC_BAIENT, EC2.ETC_BAIENT), '+
                                        '     TR.TRA_BAIRRO) AS ETC_BAIENT, '+

                                        '  IF(TR.TRA_CODTRA IS NULL,  '+
                                        '     IFNULL(CD.CID_NOMCID, CD2.CID_NOMCID), '+
                                        '     CTR.CID_NOMCID) AS CID_NOMCID, '+

                                        '  IF(TR.TRA_CODTRA IS NULL,  '+
                                        '     IFNULL(CD.CID_ESTADO, CD2.CID_ESTADO), '+
                                        '     CTR.CID_ESTADO) AS CID_ESTADO, '+

                                        '  IFNULL(EC.ETC_ENDFAT, IFNULL(EC2.ETC_ENDFAT, "N")) AS ENDFAT, '+
                                        '  IFNULL(CD.CID_COIBGE, CD2.CID_COIBGE) AS CID_COIBGE, '+
                                        '  IFNULL(EC.AUTOINCREM, EC2.AUTOINCREM) AS CODENDERE, '+
                                        '  SUBSTRING_INDEX(IFNULL(EC.ETC_ENDENT, EC2.ETC_ENDENT), ",", 1) AS ENDERECO, '+
                                        '  SUBSTRING_INDEX(IFNULL(EC.ETC_ENDENT, EC2.ETC_ENDENT), ",", -1) AS NROENDER, '+
                                        '  IFNULL(EC.ETC_REFENT, EC2.ETC_REFENT) AS ETC_REFENT, '+
                                        '  IFNULL(EC.ETC_TELENT, EC2.ETC_TELENT) AS ETC_TELENT, '+
                                        '  G.GER_NUMDOC AS NUMFAT, '+
                                        '  G.GER_ESPDOC AS TIPFAT, '+
                                        '  IF(G.GER_EMPFAT <> "", G.GER_EMPFAT, IF(MD.DET_EMPFAT <> "", MD.DET_EMPFAT, G.GER_CODEMP)) AS EMPFAT, '+
                                        '  IF(G.GER_SERIE_ <> "", G.GER_SERIE_, MD.DET_SERIE_) AS SERFAT, '+
                                        '  MD.DET_CLAFIS, '+
                                        '  G.GER_CODEMP EMPEXP, '+
                                        '  SUM((((D.ITE_EXPALT / 100) * (D.ITE_EXPLAR / 100) * (D.ITE_EXPPRO / 100)) * MD.DET_QTDITE)) AS CUBAGEM, '+
                                        '  ATI_DESATI, '+
                                        '  G.GER_CONPAG, '+
                                        '  G.GER_NUMROM NUMROM, '+
                                        '  G.GER_EMPROM EMPROM ' ;

  sqlInnerAEnviar                     = 'INNER JOIN AUXMOV A ON G.AUTOINCREM = A.AUX_SEQGER '+
                                        'INNER JOIN MOVDET MD ON G.AUTOINCREM = MD.DET_SEQGER '+
                                        'INNER JOIN CADCLI C ON G.GER_CODCLI = C.CLI_CODCLI '+
                                        'INNER JOIN CADOPE V ON G.GER_CODVEN = V.OPE_CODOPE '+
                                        'LEFT JOIN ENTCLI EC ON A.AUX_ENTGER = EC.AUTOINCREM '+
                                        'LEFT JOIN ENTCLI EC2 ON G.GER_CODCLI = EC2.ETC_CODCLI '+
                                        '                    AND EC2.ETC_SEQIND = '+
                                        '                         (SELECT MIN(ETC_SEQIND) '+
                                        '                          FROM ENTCLI EC3 '+
                                        '                          WHERE EC3.ETC_CODCLI = G.GER_CODCLI) '+
                                        'LEFT JOIN CADCID CD ON EC.ETC_CIDENT = CD.CID_CODCID '+
                                        'LEFT JOIN CADCID CD2 ON EC2.ETC_CIDENT = CD2.CID_CODCID '+
                                        'LEFT JOIN CADITE I ON I.ITE_CODITE = MD.DET_CODITE '+
                                        'LEFT JOIN DESSIT D ON D.ITE_CODITE = I.ITE_CODITE '+
                                        'LEFT JOIN CADATI ON CLI_CODATI = ATI_CODATI '+
                                        'LEFT JOIN CADTRA TR ON A.AUX_TRARDP = TR.TRA_CODTRA AND TR.TRA_INTFUS = "S" '+
                                        'LEFT JOIN CADCID CTR ON TR.TRA_CODCID = CTR.CID_CODCID ';

  sqlCondicaoAEnviar                  = 'WHERE '+
                                        '  A.AUX_INTFUS = "N" AND '+
                                        '  G.GER_ESPDOC IN ("NF","IF") AND '+
                                        '  G.GER_ENTFAT = "S" AND '+
                                        '  G.GER_ENTFUT = "N" AND '+
                                        '  LOCATE(MD.DET_CLAFIS, CONCAT(:CLAVEN, "5117_6117_5910_")) > 0 AND '+
                                        '  MD.DET_CLAFIS > 5000 AND '+
                                        '  MD.DET_CLAFIS NOT IN ("5922","6922") AND '+
                                        '  G.GER_CODEMP = :CODEMP '+

                                        '  AND NOT EXISTS ('+
                                        '      SELECT R.AUTOINCREM '+
                                        '      FROM ROMGERX R '+
                                        '      WHERE R.GER_NUMDOC = G.GER_NUMDOC  '+
                                        '        AND R.GER_ESPDOC = G.GER_ESPDOC  '+
                                        '        AND R.GER_CODEMP = G.GER_CODEMP) '+

                                        '  AND ( EXISTS ( '+
                                        '        SELECT TRA_CODTRA '+
                                        '        FROM CADTRA '+
                                        '        WHERE TRA_CODTRA = G.GER_CODTRA '+
                                        '          AND TRA_INTFUS = "S") '+
                                        '       ) ';

  { *** SELECT *** }

  sqlVeiculosAEnviar                  = 'SELECT V.AUTOINCREM, VEI_PLAVEI, VEI_ANOVEI, ' +
                                        '  CONCAT(MAR_DESMAR, " ", MOD_DESMOD) AS DESCRICAO ' +
                                        'FROM CADVEI V ' +
                                        'INNER JOIN MARVEI MA ON V.VEI_CODMAR = MA.MAR_CODMAR ' +
                                        'INNER JOIN MODVEI MD ON V.VEI_CODMOD = MD.MOD_CODMOD ' +
                                        'WHERE VEI_STATUS = "A" ' +
                                        '  AND VEI_INTFUS = "N" ';

  sqlMotoristasAjudantesAEnviar       = 'SELECT AUTOINCREM, MOT_NOMMOT AS NOME, MOT_CPFMOT AS NUMCPF, MOT_CODMOT AS CODIGO, "Motorista" AS TIPO ' +
                                        'FROM CADMOT ' +
                                        'WHERE MOT_STATUS = "A" ' +
                                        '  AND MOT_INTFUS = "N" '+

                                        ' UNION ALL '+

                                        'SELECT AUTOINCREM, AJU_NOMAJU AS NOME, "11111111111" AS NUMCPF, AJU_CODAJU AS CODIGO, "Ajudante" AS TIPO ' +
                                        'FROM CADAJU ' +
                                        'WHERE AJU_STATUS = "A" ' +
                                        '  AND AJU_INTFUS = "N" ';

  sqlNotasAEnviar                     = sqlCamposAEnviar +
                                        'FROM MOVGER G ' +
                                        sqlInnerAEnviar +
                                        sqlCondicaoAEnviar +
                                        'GROUP BY G.AUTOINCREM ';

  sqlItensNota                        = 'SELECT DET_CODITE, DET_QTDITE, DET_UNITAR, DET_TOTITE, ITE_DESITE, UNI_SIGUNI ' +
                                        'FROM MOVDET ' +
                                        'INNER JOIN CADITE ON DET_CODITE = ITE_CODITE ' +
                                        'LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI ' +
                                        'WHERE DET_SEQGER = :SEQGER ';

  sqlRomaneioCancelado                = 'SELECT FUS_NUMROM, FUS_EMPROM, FUS_DTAINC, FUS_HRAINC ' +
                                        'FROM TARFUS ' +
                                        'WHERE FUS_EVENTO = "C" ' +
                                        '  AND IFNULL(FUS_NUMDOC, "") = "" ' +
                                        '  AND FUS_DTALEI IS NULL ' +
                                        '  AND FUS_EMPTAR = :CODEMP ';

  sqlNotaRomaneioCancelado         = 'SELECT CONCAT(DR.GER_NUMDOC, DR.GER_ESPDOC, DR.GER_CODEMP) AS DOCERP, '+
                                        '  IF(G.GER_EMPFAT <> "", G.GER_EMPFAT, IF(D.DET_EMPFAT <> "", D.DET_EMPFAT, DR.GER_EMPROM)) AS CODFIL '+
                                        'FROM TARFUS '+
                                        'INNER JOIN DEL_ROMGERX DR ON FUS_NUMROM = DR.GER_NUMROM AND FUS_EMPROM = DR.GER_EMPROM '+
                                        'LEFT JOIN MOVGER G ON DR.GER_NUMDOC = G.GER_NUMDOC AND DR.GER_ESPDOC = G.GER_ESPDOC AND DR.GER_CODEMP = G.GER_CODEMP '+
                                        'INNER JOIN MOVDET D ON G.AUTOINCREM = D.DET_SEQGER '+
                                        'WHERE FUS_EVENTO = "C" '+
                                        '  AND IFNULL(FUS_NUMDOC, "") = "" '+
                                        '  AND FUS_DTALEI IS NULL '+
                                        '  AND FUS_NUMROM = :NUMROM '+
                                        '  AND FUS_EMPROM = :EMPROM ';

  sqlNotasCanceladas               = sqlCamposAEnviar +
                                        'FROM TARFUS ' +
                                        'INNER JOIN DEL_MOVGER G ON FUS_NUMDOC = G.GER_NUMDOC ' +
                                        '                       AND FUS_ESPDOC = G.GER_ESPDOC ' +
                                        '                       AND FUS_EMPDOC = G.GER_CODEMP ' +
                                        'INNER JOIN DEL_AUXMOV A ON G.AUTOINCREM = A.AUX_SEQGER ' +
                                        'INNER JOIN DEL_MOVDET MD ON G.AUTOINCREM = MD.DET_SEQGER ' +
                                        'INNER JOIN CADCLI C ON G.GER_CODCLI = C.CLI_CODCLI ' +
                                        'INNER JOIN CADOPE V ON G.GER_CODVEN = V.OPE_CODOPE ' +
                                        'LEFT JOIN ENTCLI EC ON A.AUX_ENTGER = EC.AUTOINCREM ' +
                                        'LEFT JOIN ENTCLI EC2 ON G.GER_CODCLI = EC2.ETC_CODCLI ' +
                                        '                    AND EC2.ETC_SEQIND = ' +
                                        '                         (SELECT MIN(ETC_SEQIND) ' +
                                        '                          FROM ENTCLI EC3 ' +
                                        '                          WHERE EC3.ETC_CODCLI = G.GER_CODCLI) ' +
                                        'LEFT JOIN CADCID CD ON EC.ETC_CIDENT = CD.CID_CODCID ' +
                                        'LEFT JOIN CADCID CD2 ON EC2.ETC_CIDENT = CD2.CID_CODCID ' +
                                        'LEFT JOIN CADITE I ON I.ITE_CODITE = MD.DET_CODITE ' +
                                        'LEFT JOIN DESSIT D ON D.ITE_CODITE = I.ITE_CODITE ' +
                                        'LEFT JOIN CADATI ON CLI_CODATI = ATI_CODATI ' +
                                        'LEFT JOIN CADTRA TR ON A.AUX_TRARDP = TR.TRA_CODTRA AND TR.TRA_INTFUS = "S"' +
                                        'LEFT JOIN CADCID CTR ON TR.TRA_CODCID = CTR.CID_CODCID '+
                                        'WHERE FUS_EVENTO = "C" ' +
                                        '  AND IFNULL(FUS_NUMROM, "") = "" ' +
                                        '  AND FUS_EMPTAR = :CODEMP ' +
                                        '  AND FUS_DTALEI IS NULL ' +
                                        'GROUP BY G.AUTOINCREM ';

  sqlInclusaoNotaRomaneio             = sqlCamposAEnviar +
                                        'FROM TARFUS ' +
                                        'INNER JOIN MOVGER G ON FUS_NUMDOC = G.GER_NUMDOC ' +
                                        '                   AND FUS_ESPDOC = G.GER_ESPDOC ' +
                                        '                   AND FUS_EMPDOC = G.GER_CODEMP ' +
                                        sqlInnerAEnviar +
                                        'WHERE FUS_EVENTO = "I" ' +
                                        '  AND FUS_EMPTAR = :CODEMP ' +
                                        '  AND FUS_DTALEI IS NULL ' +
                                        'GROUP BY G.AUTOINCREM ';

  sqlExclusaoNotaRomaneio             = sqlCamposAEnviar +
                                        'FROM TARFUS ' +
                                        'INNER JOIN MOVGER G ON FUS_NUMDOC = G.GER_NUMDOC ' +
                                        '                   AND FUS_ESPDOC = G.GER_ESPDOC ' +
                                        '                   AND FUS_EMPDOC = G.GER_CODEMP ' +
                                        sqlInnerAEnviar +
                                        'WHERE FUS_EVENTO = "E" ' +
                                        '  AND FUS_EMPTAR = :CODEMP ' +
                                        '  AND FUS_DTALEI IS NULL ' +
                                        'GROUP BY G.AUTOINCREM ';

  sqlRomaneioFinalizado               = ' SELECT '+
                                        '   FUS_NUMROM, '+
                                        '   FUS_EMPROM, '+
                                        '   GER_CODMOT, '+
                                        '   CADVEI.AUTOINCREM AS CODVEI, '+
                                        '   MOT_NOMMOT, '+
                                        '   MOT_CPFMOT '+
                                        ' FROM '+
                                        '   TARFUS '+
                                        ' INNER JOIN ROMGERX '+
                                        '    ON FUS_NUMROM = GER_NUMROM '+
                                        '   AND FUS_EMPROM = GER_EMPROM '+
                                        ' INNER JOIN CADMOT '+
                                        '    ON GER_CODMOT = MOT_CODMOT '+
                                        ' INNER JOIN CADVEI '+
                                        '    ON GER_PLAVEI = VEI_PLAVEI '+
                                        ' WHERE FUS_EVENTO = "F" ' +
                                        '   AND FUS_EMPTAR = :CODEMP ' +
                                        '   AND FUS_DTALEI IS NULL ';

  { *** UPDATE *** }
  sqlAtualizaIntFusVeiculos           = 'UPDATE CADVEI ' +
                                        'SET VEI_INTFUS = "S" ' +
                                        'WHERE AUTOINCREM IN (%s)';

  sqlAtualizaIntFusMotoristas         = 'UPDATE CADMOT ' +
                                        'SET MOT_INTFUS = "S" ' +
                                        'WHERE MOT_CODMOT IN (%s)';

  sqlAtualizaIntFusAjudantes          = 'UPDATE CADAJU ' +
                                        'SET AJU_INTFUS = "S" ' +
                                        'WHERE AJU_CODAJU IN (%s)';

  sqlAtualizaIntFusNotasEnvio         = 'UPDATE '+
                                        '  AUXMOV A ' +
                                        'INNER JOIN MOVGER G '+
                                        '  ON A.AUX_SEQGER = G.AUTOINCREM ' +
                                        'SET '+
                                        '   A.AUX_INTFUS = "%s", ' +
                                        '   A.AUX_ENVFUS = :DTAENV ' +
                                        'WHERE '+
                                        '   GER_NUMDOC = "%s" AND '+
                                        '   GER_ESPDOC = "%s" AND '+
                                        '   GER_CODEMP = "%s" ';

  sqlAtualizaIntFusNotas              = 'UPDATE '+
                                        '  AUXMOV A ' +
                                        'INNER JOIN MOVGER G '+
                                        '  ON A.AUX_SEQGER = G.AUTOINCREM ' +
                                        'SET '+
                                        '   A.AUX_INTFUS = "%s" ' +
                                        'WHERE '+
                                        '   GER_NUMDOC = "%s" AND '+
                                        '   GER_ESPDOC = "%s" AND '+
                                        '   GER_CODEMP = "%s" ';

  sqlAtualizaTarefasPD                = 'UPDATE '+
                                       '   TARFUS ' +
                                        'SET '+
                                        '  FUS_DTALEI = CURRENT_DATE(), ' +
                                        '  FUS_HRALEI = CURRENT_TIME()  ' +
                                        'WHERE '+
                                        '  FUS_NUMDOC = "%s" AND '+
                                        '  FUS_ESPDOC = "%s" AND '+
                                        '  FUS_EMPDOC = "%s" AND '+
                                        '  FUS_DTALEI IS NULL ';

  sqlAtualizaTarefasRom               = 'UPDATE TARFUS ' +
                                        'SET FUS_DTALEI = CURRENT_DATE(), ' +
                                        '    FUS_HRALEI = CURRENT_TIME() ' +
                                        'WHERE FUS_EVENTO = :EVENTO '+
                                        '  AND FUS_NUMROM = :NUMROM ' +
                                        '  AND FUS_EMPROM = :EMPROM ' +
                                        '  AND FUS_DTALEI IS NULL ';

  CHAR_ESPECIAL                       = '#<>|*ªº°&"''%$¨@!?§={}[]´`^~¹²³£¢Ø¡';

type
  TTypeEnvioFusionFaturados = (tpVeiculos, tpMotoristasAjudantes, tpNotas, tpRomaneioCancelado,
    tpNotaCancelada, tpExclusaoNotaRomaneio, tpInclusaoNotaRomaneio, tpRomaneioFinalizado);

  TEnviaRegistrosFaturadosFusion = class sealed(TInterfacedObject,
    {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX})
  private
    FParam: TTypeEnvioFusionFaturados;
    FClaVen: String;

    class var FLastProcessamento: TDateTime;

    procedure pEnviaVeiculos;
    procedure pEnviaMotoristasAjudantes;
    procedure pEnviaNotas(ATipoEnvio: TTypeEnvioFusionFaturados; ASQL: String);
    procedure pEnviaCancelamentoRomaneio;
    procedure pEnviaStatusRomaneioFinalizado;

    procedure pAtualizaEnvioVeiculos(ARetorno: String);
    procedure pAtualizaEnvioMotoristasAjudantes(ARetorno, ATipo: String);
    procedure pAtualizaEnvioNotas(ARetorno, AStatus: String; ADataEnvio: TDateTime = 0);
    procedure pAtualizaEnvioTarefas(ARetorno: String); overload;
    procedure pAtualizaEnvioTarefas(ANumRom, AEmpRom, AEvento: String); overload;
  protected
    constructor Create(AParam: TTypeEnvioFusionFaturados); overload;
  public
    procedure pExecute;
    procedure pExecuteAll;
    function fExecute: TResultExecute;

    destructor Destroy; Override;

    class function New(AParam: TTypeEnvioFusionFaturados):
      {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX}; overload;
    class function New:
      {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX}; overload;
  end;

implementation

uses
  untFusionVeiculo, untFusionMotoristaAjudante, untFusionEntregaServico, untFusionEntregaServicoItens,
  untFusionCarga, untFusionIntegWS, untConstantes, untFusionAtualizaCarga;

{ TEnviaRegistrosFusion }

constructor TEnviaRegistrosFaturadosFusion.Create(AParam: TTypeEnvioFusionFaturados);
begin
  FParam := AParam;
  FClaVen := fTransform(fCfgSis('CLAVEN'), 4);
end;

destructor TEnviaRegistrosFaturadosFusion.Destroy;
begin

  inherited;
end;

function TEnviaRegistrosFaturadosFusion.fExecute: TResultExecute;
begin
  FillChar(Result, SizeOf(Result), #0);
  pExecute;
end;

class function TEnviaRegistrosFaturadosFusion.New: {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX};
begin
  Result := TEnviaRegistrosFaturadosFusion.Create;
end;

class function TEnviaRegistrosFaturadosFusion.New(AParam: TTypeEnvioFusionFaturados): {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX};
begin
  Result := TEnviaRegistrosFaturadosFusion.Create(AParam);
end;

procedure TEnviaRegistrosFaturadosFusion.pAtualizaEnvioMotoristasAjudantes(ARetorno, ATipo: String);
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  if (fEmptyStr(ARetorno)) then
    Exit;

  LQry := fCriaQuery();

  try
    LQry.SQL.Text := Format(IIF(ATipo = 'Motorista', sqlAtualizaIntFusMotoristas, sqlAtualizaIntFusAjudantes), [ARetorno]);
    LQry.ExecSQL();
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  end;
end;

procedure TEnviaRegistrosFaturadosFusion.pAtualizaEnvioNotas(ARetorno, AStatus: String; ADataEnvio: TDateTime = 0);
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  arrDocs: TArray<String>;
  intCont: Integer;
  strNumDoc,
  strEspDoc,
  strCodEmp: String;
begin
  if (fEmptyStr(ARetorno)) then
    Exit;

  LQry := fCriaQuery();

  try
    arrDocs := ARetorno.Split([',']);
    for intCont := 0 to Length(arrDocs)-1 do
    begin
      strNumDoc := Trim(Copy(arrDocs[intCont], 0, 12));
      strEspDoc := Trim(Copy(arrDocs[intCont], 13, 2));
      strCodEmp := Trim(Copy(arrDocs[intCont], 15, 3));

      if (ADataEnvio > 0) then
      begin
        LQry.SQL.Text := Format(sqlAtualizaIntFusNotasEnvio, [AStatus, strNumDoc, UpperCase(strEspDoc), strCodEmp]);
        LQry.ParamByName('DTAENV').AsDateTime := ADataEnvio;
        LQry.ExecSQL();
      end
      else
      begin
        LQry.SQL.Text := Format(sqlAtualizaIntFusNotas, [AStatus, strNumDoc, UpperCase(strEspDoc), strCodEmp]);
        LQry.ExecSQL();
      end;

    end;
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  end;
end;

procedure TEnviaRegistrosFaturadosFusion.pAtualizaEnvioTarefas(ARetorno: String);
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  arrDocs: TArray<String>;
  intCont: Integer;
  strNumDoc,
  strEspDoc,
  strCodEmp: String;
begin
  LQry := fCriaQuery();

  try
    arrDocs := ARetorno.Split([',']);
    for intCont := 0 to Length(arrDocs)-1 do
    begin
      strNumDoc := Trim(Copy(arrDocs[intCont], 0, 12));
      strEspDoc := Trim(Copy(arrDocs[intCont], 13, 2));
      strCodEmp := Trim(Copy(arrDocs[intCont], 15, 3));

      LQry.SQL.Text := Format(sqlAtualizaTarefasPD, [strNumDoc, UpperCase(strEspDoc), strCodEmp]);
      LQry.ExecSQL();
    end;
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  end;
end;

procedure TEnviaRegistrosFaturadosFusion.pAtualizaEnvioTarefas(ANumRom, AEmpRom, AEvento: String);
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LQry := fCriaQuery();

  try
    LQry.SQL.Text := sqlAtualizaTarefasRom;
    LQry.ParamByName('NUMROM').AsString := ANumRom;
    LQry.ParamByName('EMPROM').AsString := AEmpRom;
    LQry.ParamByName('EVENTO').AsString := AEvento;
    LQry.ExecSQL();
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  end;
end;

procedure TEnviaRegistrosFaturadosFusion.pAtualizaEnvioVeiculos(ARetorno: String);
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  if (fEmptyStr(ARetorno)) then
    Exit;

  LQry := fCriaQuery();

  try
    LQry.SQL.Text := Format(sqlAtualizaIntFusVeiculos, [ARetorno]);
    LQry.ExecSQL();
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  end;
end;

procedure TEnviaRegistrosFaturadosFusion.pEnviaCancelamentoRomaneio;
var
  LRetorno: String;
  LNotas: String;
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LQryNota: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LobjCarga: TFusionCarga;
  LobjNota: TFusionPedidosCarga;
begin
  LQry := fCriaQuery();
  LQryNota := fCriaQuery();

  try
    LQryNota.SQL.Text := sqlNotaRomaneioCancelado;

    LQry.SQL.Text := sqlRomaneioCancelado;
    LQry.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQry.Open();

    while not LQry.Eof do
    begin
      LobjCarga := TFusionCarga.Create;

      try
        LobjCarga.codigo_erp := LQry.FieldByName('FUS_NUMROM').AsString;
        LobjCarga.dt_cancel := FormatDateTime('yyyy-mm-dd', LQry.FieldByName('FUS_DTAINC').AsDateTime) + ' '
            + FormatDateTime('hh:nn:ss', LQry.FieldByName('FUS_HRAINC').AsDateTime);

        LQryNota.Close;
        LQryNota.ParamByName('NUMROM').AsString := LQry.FieldByName('FUS_NUMROM').AsString;
        LQryNota.ParamByName('EMPROM').AsString := LQry.FieldByName('FUS_EMPROM').AsString;
        LQryNota.Open;

        LNotas := '';

        while not LQryNota.Eof do
        begin
          LobjNota := TFusionPedidosCarga.Create;
          LobjNota.id := LQryNota.FieldByName('DOCERP').AsString;
          LobjNota.filial := LQryNota.FieldByName('CODFIL').AsString;

          if (not fEmptyStr(LNotas)) then
            LNotas := LNotas + ',' + LQryNota.FieldByName('DOCERP').AsString
          else
            LNotas := LNotas + LQryNota.FieldByName('DOCERP').AsString;

          SetLength(LobjCarga.arrPedidos, Length(LobjCarga.arrPedidos) + 1);
          LobjCarga.arrPedidos[Length(LobjCarga.arrPedidos) - 1] := LobjNota;

          LQryNota.Next;
        end;

        LRetorno := TFusionIntegWS.New.fCancelarCarga(LobjCarga).fRetornoSucesso;

        if (not fEmptyStr(LRetorno)) then
        begin
          pAtualizaEnvioTarefas(LQry.FieldByName('FUS_NUMROM').AsString,
                                LQry.FieldByName('FUS_EMPROM').AsString,
                                'C');

          pAtualizaEnvioNotas(LNotas, 'E');
        end;
      finally
        LobjCarga.Free;
      end;

      LQry.Next();
    end;
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
    FreeAndNil(LQryNota);
{$ENDIF LINUX}
  end;
end;

procedure TEnviaRegistrosFaturadosFusion.pEnviaMotoristasAjudantes;
var
  LCont: Integer;
  LRetorno: String;
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LobjMotoristaAjudante: TFusionMotoristaAjudante;
  LarrMotoristasAjudantes: Array of TFusionMotoristaAjudante;
begin
  LQry := fCriaQuery();

  try
    LQry.SQL.Add(sqlMotoristasAjudantesAEnviar);
    LQry.Open();

    if LQry.IsEmpty then
      Exit;

    LCont := 0;

    while not LQry.Eof do
    begin
      LCont := LCont + 1;
      LobjMotoristaAjudante := TFusionMotoristaAjudante.Create;

      LobjMotoristaAjudante.seq_id := LQry.FieldByName('CODIGO').AsString;
      LobjMotoristaAjudante.codigo_erp := LQry.FieldByName('CODIGO').AsString + Copy(LQry.FieldByName('TIPO').AsString,1,1); //	Codigo do Motorista ou Ajudante no sistema ERP.
      LobjMotoristaAjudante.nome := fTiraCaracEspeciais(LQry.FieldByName('NOME').AsString, False, False, False, False, False, False, False, CHAR_ESPECIAL);
      LobjMotoristaAjudante.cpf := LQry.FieldByName('NUMCPF').AsString;
      LobjMotoristaAjudante.tipo := LQry.FieldByName('TIPO').AsString; // ** Motorista ou Ajudante

      SetLength(LarrMotoristasAjudantes, Length(LarrMotoristasAjudantes) + 1);
      LarrMotoristasAjudantes[Length(LarrMotoristasAjudantes) - 1] := LobjMotoristaAjudante;

      if (LCont mod 10 = 0) or (LQry.RecNo = LQry.RecordCount) then
      begin
        LRetorno := TFusionIntegWS.New.fEnviar(LarrMotoristasAjudantes).fRetornoSucesso;

        pAtualizaEnvioMotoristasAjudantes(LRetorno, LQry.FieldByName('TIPO').AsString);

        LCont := 0;

        for LobjMotoristaAjudante in LarrMotoristasAjudantes do
          LobjMotoristaAjudante.Free;

        SetLength(LarrMotoristasAjudantes, 0);
      end;

      LQry.Next;
    end;
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  end;
end;

procedure TEnviaRegistrosFaturadosFusion.pEnviaNotas(ATipoEnvio: TTypeEnvioFusionFaturados; ASQL: String);
var
  LCont: Integer;
  LRetorno: String;
  LStatusNota: String;
  LOpenedTransaction: Boolean;
  LAtualizaTarefasFusion: Boolean;
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LQryItens: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LobjNota: TFusionEntregaServico;
  LobjProduto: TFusionEntregaServicoItens;
  LarrNotas: Array of TFusionEntregaServico;
begin
  LQry := fCriaQuery();
  LQryItens := fCriaQuery();

  try
    if (ATipoEnvio = tpNotaCancelada) then
      LQryItens.SQL.Add(StringReplace(sqlItensNota, 'MOVDET', 'DEL_MOVDET', [rfReplaceAll]))
    else
      LQryItens.SQL.Add(sqlItensNota);

    LOpenedTransaction := fInTransaction();

    try
      LQry.SQL.Add(ASQL);
      LQry.ParamByName('CODEMP').AsString := VS_strCodEmp;

      if ATipoEnvio = tpNotas then
        LQry.ParamByName('CLAVEN').AsString := FClaVen;

      LQry.Open();

      if LQry.IsEmpty then
        Exit;

      LCont := 0;
      LAtualizaTarefasFusion := ATipoEnvio in [tpNotaCancelada, tpExclusaoNotaRomaneio, tpInclusaoNotaRomaneio];

      if (not LOpenedTransaction) then
        fStartTransaction();

      while not LQry.Eof do
      begin
        if fDocumentoTravado('MOVGER',
                             LQry.FieldByName('NUMDOC').AsString,
                             LQry.FieldByName('ESPDOC').AsString,
                             LQry.FieldByName('EMPDOC').AsString,
                             LQry.FieldByName('CODCLI').AsString) then
        begin
          LQry.Next;
          Continue;
        end;

        LCont := LCont + 1;
        LobjNota := TFusionEntregaServico.Create;

        LobjNota.nf := LQry.FieldByName('NUMFAT').AsString; //	numero da nota fiscal
        LobjNota.serie := LQry.FieldByName('SERFAT').AsString; //	codigo da serie da nota fiscal(nao obrig)
        LobjNota.tipo := LQry.FieldByName('TIPFAT').AsString; // da nota fiscal(nao obrig)
        LobjNota.ent_ou_serv := 'Entrega'; // Se for Entrega ou Serviço
        LobjNota.pedido_erp := LQry.FieldByName('DOCERP').AsString; // codigo do pedido no seu sistem(ERP)
        LobjNota.forma_pgto := LQry.FieldByName('CODFPG').AsString;
        LobjNota.status := '1'; //	status 1 são normalmente para  coletas. 9 canceladas
        LobjNota.obs := ''; // Caso for um endereço alternativo, pode-se colocar nesse campo @CEP, sendo o cep no formatao 00000-000
        LobjNota.num_ped_conf := LQry.FieldByName('DOCERP').AsString;

        {carga: preenchido par incluir PD no romaneio / 0 para retirar de um romaneio / em branco enquanto não pertence a um romaneio}
        {podeformarcarga: S - pode formar carga / N - não pode formar carga (PD cancelado ou baixado)}

        LStatusNota := 'E';

        case ATipoEnvio of
          tpNotas:
            begin
              LobjNota.carga := '';
              LobjNota.podeformarcarga := 'S'; // S pode formar carga
            end;
          tpNotaCancelada:
            begin
              LobjNota.carga := IIF(fEmptyStr(LQry.FieldByName('NUMROM').AsString), '', '0');
              LobjNota.podeformarcarga := 'N'; // N para não incluir em novo romaneio
              LobjNota.status := '9';
            end;
          tpExclusaoNotaRomaneio:
            begin
              LobjNota.carga := '0'; // 0 para remover de um romaneio
              LobjNota.podeformarcarga := 'S'; // S para permitir incluir em um novo romaneio pela Fusion
            end;
          tpInclusaoNotaRomaneio:
            begin
              LobjNota.carga := LQry.FieldByName('NUMROM').AsString;
              LobjNota.podeformarcarga := 'N'; // N pois é sendo incluido em um romaneio e assim não poderá ser incluido em outro
              LStatusNota := 'R';
            end;
        end;

        LobjNota.cubagem := FormatFloat('#0.00', LQry.FieldByName('CUBAGEM').AsFloat).Replace(FormatSettings.DecimalSeparator, '.'); //	Sim, mas não precisa ser metro cubico obrigatoriamente. Pode ser qualquer unidade que voce pode trabalhar.
        LobjNota.valor := FormatFloat('#0.00', LQry.FieldByName('VLRCON').AsFloat).Replace(FormatSettings.DecimalSeparator, '.'); //	Sim, caso não exista pode passar zero.
        LobjNota.peso := FormatFloat('#0.00', LQry.FieldByName('PESLIQ').AsFloat).Replace(FormatSettings.DecimalSeparator, '.');
        LobjNota.valor_st :=	'0';
        LobjNota.empresa_fat := LQry.FieldByName('EMPFAT').AsString; //	filial da fatura no ERP
        LobjNota.empresa_log := LQry.FieldByName('EMPEXP').AsString; //	filial da logistica no ERP. onde será enviado os produtos.
        LobjNota.empresa_digit := LQry.FieldByName('EMPDOC').AsString; //	filial da digitação no ERP.
        LobjNota.pedido_orig := LQry.FieldByName('DOCERP').AsString; //	codigo do pedido do ERP

        LobjNota.dt_list_nf :=
          StrToDateTime(FormatDateTime('dd/mm/yyyy', LQry.FieldByName('DTAEMI').AsDateTime) +' '
            +FormatDateTime('hh:nn:ss', LQry.FieldByName('HORENT').AsDateTime)); //	será a data da coleta.

        LobjNota.nf_cod_rota_erp := ''; //	Necessário?
        LobjNota.nf_descricao_rota := ''; //	Necessário?
        LobjNota.descr_cliente := fTiraCaracEspeciais(LQry.FieldByName('CLI_NOMCLI').AsString, False, False, False, False, False, False, False, CHAR_ESPECIAL); //	descrição do cliente.
        LobjNota.cnpj_cliente :=	fTiraCaracEspeciaisPonto(LQry.FieldByName('CLI_C_G_C_').AsString); //	sim, pode colocar o cpf
        LobjNota.end_cliente := fTiraCaracEspeciais(LQry.FieldByName('ETC_ENDENT').AsString, False, False, False, False, False, False, False, CHAR_ESPECIAL); // endereço
        LobjNota.bairro_cliente :=	fTiraCaracEspeciais(LQry.FieldByName('ETC_BAIENT').AsString, False, False, False, False, False, False, False, CHAR_ESPECIAL); // bairro
        LobjNota.num_end_cliente := '';
        LobjNota.uf_cliente :=	LQry.FieldByName('CID_ESTADO').AsString; // uf do endereço do cliente
        LobjNota.cidade_cliente :=	fTiraCaracEspeciais(LQry.FieldByName('CID_NOMCID').AsString, False, False, False, False, False, False, False, CHAR_ESPECIAL); // cidade do cliente
        LobjNota.cep_cliente := LQry.FieldByName('ETC_CEPENT').AsString; //	cep do cliente
        LobjNota.email1_cliente :=	LQry.FieldByName('CLI_EMAIL_').AsString; // email do cliente
        LobjNota.email2_cliente :=	LQry.FieldByName('CLI_EMAIL2').AsString; // email do cliente
        LobjNota.email3_cliente :=	LQry.FieldByName('CLI_EMAIL3').AsString; // email do cliente
        LobjNota.tel1_cliente :=	LQry.FieldByName('ETC_TELENT').AsString;	// telefone do cliente
        LobjNota.tel2_cliente :=	''; // telefone do cliente
        LobjNota.tel3_cliente :=	''; // telefone do cliente
        LobjNota.vlr_credito_cliente := '0'; // Necessário?
        LobjNota.data_cadastro_cliente := LQry.FieldByName('CLI_DTACAD').AsDateTime;
        LobjNota.saldo_disp_cliente :=	'0'; // Necessário?
        LobjNota.vlr_tits_vencido_cliente :=	'0';
        LobjNota.vlr_tits_vencer_cliente :=	'0';
        LobjNota.status_cred_cliente := 'C';
        LobjNota.codigo_cliente :=	LQry.FieldByName('CODCLI').AsString; //	É o codigo do cliente no erp
        LobjNota.cod_segmento :=	LQry.FieldByName('ATI_DESATI').AsString; // Necessário?
        LobjNota.descr_segmento :=	''; // Necessário?
        LobjNota.filial_padrao := LQry.FieldByName('EMPDOC').AsString;
        LobjNota.data_ult_compra := LQry.FieldByName('CLI_ULTCOM').AsDateTime;
        LobjNota.forma_pgto_cliente :=	'0'; // Necessário?
        LobjNota.retem_icms_cliente :=	'N';
        LobjNota.permite_retira_cliente :=	'N';
        LobjNota.rede_loja_cliente := LQry.FieldByName('EMPDOC').AsString; // Necessário?
        LobjNota.vendedor_erp :=	LQry.FieldByName('NOMVEN').AsString;
        LobjNota.praca_cod_erp := '1';
        LobjNota.praca_descricao := 'PADRAO';
        LobjNota.rota_cod_erp := '1';
        LobjNota.rota_descricao := 'PADRAO';

        LobjNota.data_pedido :=
          StrToDateTime(FormatDateTime('dd/mm/yyyy', LQry.FieldByName('DTAEMI').AsDateTime) +' '
            +FormatDateTime('hh:nn:ss', LQry.FieldByName('HORENT').AsDateTime)); // data do processamento do pedido.


        if (LQry.FieldByName('ENDFAT').AsString = 'S') then
          LobjNota.codigo_endereco_alt := '0'
        else
          LobjNota.codigo_endereco_alt := LQry.FieldByName('CODENDERE').AsString;

        LQryItens.Close;
        LQryItens.ParamByName('SEQGER').AsString := LQry.FieldByName('SEQGER').AsString;
        LQryItens.Open;

        SetLength(LobjNota.arrProdutos, 0);

        while not LQryItens.Eof do
        begin
          LobjProduto := TFusionEntregaServicoItens.Create;

          LobjProduto.cod_produto_erp := LQryItens.FieldByName('DET_CODITE').AsString;
          LobjProduto.descricao	:= StringReplace(fTiraCaracEspeciais(LQryItens.FieldByName('ITE_DESITE').AsString, False, False, False, False, False, False, False, CHAR_ESPECIAL), '"', '', [rfReplaceAll]);
          LobjProduto.qtd := FormatFloat('#0.00', LQryItens.FieldByName('DET_QTDITE').AsFloat).Replace(FormatSettings.DecimalSeparator, '.');
          LobjProduto.preco := FormatFloat('#0.00', LQryItens.FieldByName('DET_UNITAR').AsFloat).Replace(FormatSettings.DecimalSeparator, '.');
          LobjProduto.subtotal := FormatFloat('#0.00', LQryItens.FieldByName('DET_TOTITE').AsFloat).Replace(FormatSettings.DecimalSeparator, '.');
          LobjProduto.unidade := LQryItens.FieldByName('UNI_SIGUNI').AsString;

          SetLength(LobjNota.arrProdutos, Length(LobjNota.arrProdutos) + 1);
          LobjNota.arrProdutos[Length(LobjNota.arrProdutos) - 1] := LobjProduto;

          LQryItens.Next;
        end;

        SetLength(LarrNotas, Length(LarrNotas) + 1);
        LarrNotas[Length(LarrNotas) - 1] := LobjNota;

        if (LCont mod 5 = 0) or (LQry.RecNo = LQry.RecordCount) then
        begin
          LRetorno := TFusionIntegWS.New.fEnviar(LarrNotas).fRetornoSucesso;
          LRetorno := AnsiReplaceStr(LRetorno, '"', '');
          pAtualizaEnvioNotas(LRetorno, LStatusNota, IIF((ATipoEnvio = tpNotas), VS_Date + fTime(), 0));

          if LAtualizaTarefasFusion then
            pAtualizaEnvioTarefas(LRetorno);

          LCont := 0;

          for LobjNota in LarrNotas do
            LobjNota.Free;

          SetLength(LarrNotas, 0);
        end;

        LQry.Next;
      end;

      if (not LOpenedTransaction) then
        fCommit();
    except on E: Exception do
    begin
        if (not LOpenedTransaction) then
          fRollBack();
        raise;
      end;
    end;
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
    FreeAndNil(LQryItens);
{$ENDIF LINUX}
  end;
end;

procedure TEnviaRegistrosFaturadosFusion.pEnviaStatusRomaneioFinalizado;
var
  FusionAtualizaCarga: TFusionAtualizaCarga;
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  blnCargaAtualizada: Boolean;
begin
  LQry := fCriaQuery;
  FusionAtualizaCarga := TFusionAtualizaCarga.Create;
  try
    LQry.Close;
    LQry.SQL.Text := sqlRomaneioFinalizado;
    LQry.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQry.Open;

    while not LQry.Eof do
    begin
      FusionAtualizaCarga.carga.codigo_erp := LQry.FieldByName('FUS_NUMROM').AsString;
      FusionAtualizaCarga.carga.status := 'FINALIZADO';
      FusionAtualizaCarga.carga.codmotorista := LQry.FieldByName('GER_CODMOT').AsString;
      FusionAtualizaCarga.carga.codveiculo := LQry.FieldByName('CODVEI').AsString;
      FusionAtualizaCarga.motorista.nome := LQry.FieldByName('MOT_NOMMOT').AsString;
      FusionAtualizaCarga.motorista.cpf := LQry.FieldByName('MOT_CPFMOT').AsString;
      FusionAtualizaCarga.motorista.tipo := 'MOTORISTA';
      FusionAtualizaCarga.veiculo.tipo_combustivel := 'GASOLINA';

      blnCargaAtualizada := (TFusionIntegWS.New.fAtualizaCarga(FusionAtualizaCarga).fRetornoSucesso.ToLower = 'true');
      if blnCargaAtualizada then
        pAtualizaEnvioTarefas(LQry.FieldByName('FUS_NUMROM').AsString, LQry.FieldByName('FUS_EMPROM').AsString, 'F');

      LQry.Next;
    end;
  finally
    FreeAndNil(FusionAtualizaCarga);
    {$IFNDEF LINUX}
    FreeAndNil(LQry);
    {$ENDIF LINUX}
  end;
end;

procedure TEnviaRegistrosFaturadosFusion.pEnviaVeiculos;
var
  LCont: Integer;
  LRetorno: String;
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LobjVeiculo: TFusionVeiculo;
  LarrVeiculos: Array of TFusionVeiculo;
begin
  LQry := fCriaQuery();

  try
    LQry.SQL.Add(sqlVeiculosAEnviar);
    LQry.Open();

    if LQry.IsEmpty then
      ExiT;

    LCont := 0;

    while not LQry.Eof do
    begin
      LCont := LCont + 1;
      LobjVeiculo := TFusionVeiculo.Create;

      LobjVeiculo.codigo_erp :=	LQry.FieldByName('AUTOINCREM').AsString; //	código do veiculo no erp
      LobjVeiculo.placa	:= LQry.FieldByName('VEI_PLAVEI').AsString; // placa do veiculo
      LobjVeiculo.descricao	:= fTiraCaracEspeciais(LQry.FieldByName('DESCRICAO').AsString, False, False, False, False, False, False, False, CHAR_ESPECIAL); //	descricao do veiculo
      LobjVeiculo.modelo :=	fTiraCaracEspeciais(LQry.FieldByName('DESCRICAO').AsString, False, False, False, False, False, False, False, CHAR_ESPECIAL); //	modelo do veiculo
      LobjVeiculo.anoModelo := LQry.FieldByName('VEI_ANOVEI').AsString; //	ano do modelo do veiculo
      LobjVeiculo.anoFabricacao :=	LQry.FieldByName('VEI_ANOVEI').AsString; //	ano fabricado
      LobjVeiculo.status_inicial :=	'Livre'; // normalmente é vindo com padrão, que o status é Livre

      SetLength(LarrVeiculos, Length(LarrVeiculos) + 1);
      LarrVeiculos[Length(LarrVeiculos) - 1] := LobjVeiculo;

      if (LCont mod 10 = 0) or (LQry.RecNo = LQry.RecordCount) then
      begin
        LRetorno := TFusionIntegWS.New.fEnviar(LarrVeiculos).fRetornoSucesso;
        pAtualizaEnvioVeiculos(LRetorno);

        LCont := 0;

        for LobjVeiculo in LarrVeiculos do
          LobjVeiculo.Free;

        SetLength(LarrVeiculos, 0);
      end;

      LQry.Next;
    end;
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  end;
end;

procedure TEnviaRegistrosFaturadosFusion.pExecute;
begin
  case FParam of
    tpVeiculos: pEnviaVeiculos;
    tpMotoristasAjudantes: pEnviaMotoristasAjudantes;
    tpNotas: pEnviaNotas(tpNotas, sqlNotasAEnviar);
    tpRomaneioCancelado: pEnviaCancelamentoRomaneio;
    tpNotaCancelada: pEnviaNotas(tpNotaCancelada, sqlNotasCanceladas);
    tpExclusaoNotaRomaneio: pEnviaNotas(tpExclusaoNotaRomaneio, sqlExclusaoNotaRomaneio);
    tpInclusaoNotaRomaneio: pEnviaNotas(tpInclusaoNotaRomaneio, sqlInclusaoNotaRomaneio);
    tpRomaneioFinalizado: pEnviaStatusRomaneioFinalizado;
  end;
end;

procedure TEnviaRegistrosFaturadosFusion.pExecuteAll;
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LTempoReprocessar: Integer;
begin
  if (not fCfgSis('FUSUSA', varBoolean)) then
    Exit;

  if (fEmptyStr(fCfgSis('FUSUSR', varString)) or fEmptyStr(fCfgSis('FUSSEN', varString))) then
    Exit;

  FClaVen := fTransform(fCfgSis('CLAVEN'), 4);

  try
    LTempoReprocessar := fCfgSis('FUSINT', VarInteger);
  except
    LTempoReprocessar := 10;
  end;

  if MinutesBetween(VS_Date + fTime(True), FLastProcessamento) <= LTempoReprocessar then
    Exit;

  FLastProcessamento := VS_Date + fTime(True);
  LQry := fCriaQuery();

  try
    { *** Envia Veículos *** }
    {$IFDEF LINUX}
    if not GetParamValue('-s').IsEmpty then
      Sleep(StrToIntDef(GetParamValue('-s'), 100))
    else
      Sleep(100);
    {$ENDIF LINUX}

    TEnviaRegistrosFaturadosFusion.New(tpVeiculos).pExecute();

    { *** Envia Motoristas *** }
    {$IFDEF LINUX}
    if not GetParamValue('-s').IsEmpty then
      Sleep(StrToIntDef(GetParamValue('-s'), 100))
    else
      Sleep(100);
    {$ENDIF LINUX}

    TEnviaRegistrosFaturadosFusion.New(tpMotoristasAjudantes).pExecute();

    { *** Envia Notas *** }
    {$IFDEF LINUX}
    if not GetParamValue('-s').IsEmpty then
      Sleep(StrToIntDef(GetParamValue('-s'), 100))
    else
      Sleep(100);
    {$ENDIF LINUX}

    TEnviaRegistrosFaturadosFusion.New(tpNotas).pExecute();

    { *** Envia Romaneio cancelado *** }
    {$IFDEF LINUX}
    if not GetParamValue('-s').IsEmpty then
      Sleep(StrToIntDef(GetParamValue('-s'), 100))
    else
      Sleep(100);
    {$ENDIF LINUX}

    TEnviaRegistrosFaturadosFusion.New(tpRomaneioCancelado).pExecute();

    { *** Envia notas canceladas *** }
    {$IFDEF LINUX}
    if not GetParamValue('-s').IsEmpty then
      Sleep(StrToIntDef(GetParamValue('-s'), 100))
    else
      Sleep(100);
    {$ENDIF LINUX}

    TEnviaRegistrosFaturadosFusion.New(tpNotaCancelada).pExecute();

    { *** Envia Notas incluídos Romaneio *** }
    {$IFDEF LINUX}
    if not GetParamValue('-s').IsEmpty then
      Sleep(StrToIntDef(GetParamValue('-s'), 100))
    else
      Sleep(100);
    {$ENDIF LINUX}

    TEnviaRegistrosFaturadosFusion.New(tpInclusaoNotaRomaneio).pExecute();

    { *** Envia notas removidas de Romaneio *** }
    {$IFDEF LINUX}
    if not GetParamValue('-s').IsEmpty then
      Sleep(StrToIntDef(GetParamValue('-s'), 100))
    else
      Sleep(100);
    {$ENDIF LINUX}

    TEnviaRegistrosFaturadosFusion.New(tpExclusaoNotaRomaneio).pExecute();

    { *** Envia status romaneio FINALIZADO *** }
    {$IFDEF LINUX}
    if not GetParamValue('-s').IsEmpty then
      Sleep(StrToIntDef(GetParamValue('-s'), 100))
    else
      Sleep(100);
    {$ENDIF LINUX}

    TEnviaRegistrosFaturadosFusion.New(tpRomaneioFinalizado).pExecute();
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  end;
end;

end.
