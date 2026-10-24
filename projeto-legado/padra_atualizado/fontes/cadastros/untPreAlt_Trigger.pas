unit untPreAlt_Trigger;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  DAScript, UniScript, untConstantes, Uni,
{$ENDIF}
  System.AnsiStrings, System.strUtils, System.SysUtils, System.Classes, Data.DB;

Type

  TProcessaObjetosbancoPreAlt = class
    qryQuery: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery{$ENDIF};
    qryTrigger: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery{$ENDIF};
    Script: {$IFDEF LINUX} IScript {$ELSE } TUniScript{$ENDIF};
    lstConteudo: TStringList;
    lstTriggerAnalise: TStringList;
    blnEncontrouVersao: Boolean;
    strDataBase: String;

    strVersaoCurrent: String;
    fltVersaoTriggerCurrent: Double;
    FstrErro: String;

    ArrCamposTrigger : array of string;

    TriggerAlteracao: TStringList;

    procedure pProcessaTrigger;
    procedure pSetaVariaveisTrigger;
    function fInsereTrigger: String;
    procedure pCarregaVersao;
    function fLinha(strConteudo: String; blnDownTo: Boolean = False): Integer;
    function fEhPrecisoAtualizar: Boolean;
    procedure pTrataCall_procedure;
    class var lstComando: TStringList;
    procedure pSetaCamposTrigger;
    procedure pAddCamposTrigger(strNameField: String);

    procedure pSetCreateTrigger(strTriggerName: String);
    function fValidaChamadaProcedureNaTrigger: Boolean;
    function fSeparaChamadaProcedure: String;
    procedure pInsereRegistroLogTrg(strComNov, strComOld: String);


  public
    blnEncontrouProcedure: Boolean;
    strTriggerEncontrada: String;
    blnValidaSeTemQueRemoverEstrutura: Boolean;
    blnForcaValidacao : Boolean;

    property strErro: String read FstrErro;
    function fGetSQL_PINSEREPREALT: TStringList;
    function fGetSQL_CUSTOREAL: TStringList;
    function fGetSQL_COMPRALIQUIDO: TStringList;
    function fGetSQL_PREALT: TStringList;
    function fValidaTrigger: Boolean;
    procedure pGerenciaLog;
    procedure pAtualizaRegistroLogTrg;

    procedure pLogTrataAltTrigger;
    constructor Create;
    destructor Destroy; override;
    procedure pProcessaObjetos;
    function fGetSQL_Trigger: String;
  end;


procedure pPreAltDefineVariaveisAltPre(Agruapador: TDateTime;
                                       strLocal: String;
                                       strOperador: String;
                                       strEmpresa: string;
                                       var strChaveAgrupamento: String);

procedure pPreAltAtualizaEmpresa(strCodEmp: String; strChaveAgrupamento: string);
function  fValidaEstruturaTriggerPreAlt(var AErro: String): Boolean;
function  fConfiguracaoAtivaTriggerPreAlt(AblnForcaValidacao: Boolean = False): Boolean;

// Sempre que alterar a estrutura da trigger incrementar a versão, para que posssa ocorrer a atualização automatica
const strVersaoTrigger  = 'VERSAO 1.00';
const fltVersaoTrigger = 1.00;

implementation

{$IFNDEF LINUX}
uses untFuncoesSimples, untModuloReplicacao;
{$ENDIF}

procedure pPreAltDefineVariaveisAltPre(Agruapador: TDateTime;
                                       strLocal: String;
                                       strOperador: String;
                                       strEmpresa: string;
                                       var strChaveAgrupamento: String);
  var qryQuery: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery{$ENDIF};
Begin
  If Not VS_blnPreAltViaTrigger Then
    Exit;
  qryQuery:= fCriaQuery;
  try
    If strChaveAgrupamento <> '' Then
      Exit;
    strChaveAgrupamento := fRetAutoincrem('REGPRE', VS_strCodEmp);
    qryQuery.SQL.Add('INSERT INTO REGPRE(');
    qryQuery.SQL.Add('AUTOINCREM,');
    qryQuery.SQL.Add('PRE_AGRUPA,');
    qryQuery.SQL.Add('PRE_LOCAL_,');
    qryQuery.SQL.Add('PRE_CODEMP,');
    qryQuery.SQL.Add('PRE_CODOPE)VALUES(');
    qryQuery.SQL.Add(':AUTOINCREM,');
    qryQuery.SQL.Add(':PRE_AGRUPA,');
    qryQuery.SQL.Add(':PRE_LOCAL_,');
    qryQuery.SQL.Add(':PRE_CODEMP,');
    qryQuery.SQL.Add(':PRE_CODOPE)');

    qryQuery.ParamByName('AUTOINCREM').AsString := strChaveAgrupamento;
    qryQuery.ParamByName('PRE_AGRUPA').AsDateTime := fNow;
    qryQuery.ParamByName('PRE_LOCAL_').AsString := strLocal;
    qryQuery.ParamByName('PRE_CODEMP').AsString := strEmpresa;
    qryQuery.ParamByName('PRE_CODOPE').AsString := strOperador;

    qryQuery.ExecSQL;

  finally
  {$IFNDEF LINUX}
    FreeAndNil(qryQuery);
  {$ENDIF}
  End;

End;

procedure pPreAltAtualizaEmpresa(strCodEmp: String; strChaveAgrupamento: string);
  var qryQuery: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery{$ENDIF};
Begin
  qryQuery:= fCriaQuery;


  try
    qryQuery.SQL.Text := 'SELECT * FROM REGPRE WHERE AUTOINCREM = :AUTOINCREM AND PRE_CODEMP = :CODEMP';
    qryQuery.ParamByName('CODEMP').AsString := strCodEmp;
    qryQuery.ParamByName('AUTOINCREM').AsString := strChaveAgrupamento;
    qryQuery.Open;

    If Not qryQuery.IsEmpty Then
      Exit;

    qryQuery.SQL.Clear;

    qryQuery.SQL.Add('INSERT INTO REGPRE (AUTOINCREM, PRE_LOCAL_, PRE_CODEMP, PRE_CODOPE, PRE_AGRUPA )');
    qryQuery.SQL.Add('SELECT  AUTOINCREM,');
    qryQuery.SQL.Add('        PRE_LOCAL_,');
    qryQuery.SQL.Add('        :CODEMP,');
    qryQuery.SQL.Add('        PRE_CODOPE,');
    qryQuery.SQL.Add('        PRE_AGRUPA FROM REGPRE');
    qryQuery.SQL.Add('  WHERE AUTOINCREM = :AUTOINCREM');
    qryQuery.SQL.Add('    AND PRE_CODEMP <> :CODEMP');
    qryQuery.SQL.Add('    LIMIT 1');

    qryQuery.ParamByName('CODEMP').AsString := strCodEmp;
    qryQuery.ParamByName('AUTOINCREM').AsString := strChaveAgrupamento;
    qryQuery.ExecSQL;
  finally
  {$IFNDEF LINUX}
    FreeAndNil(qryQuery);
  {$ENDIF}
  End;

End;

function fValidaEstruturaTriggerPreAlt(var AErro: String): Boolean;
var ProcessaObjetosbancoPreAlt: TProcessaObjetosbancoPreAlt;
begin
  ProcessaObjetosbancoPreAlt := TProcessaObjetosbancoPreAlt.Create;

  Try
     Result := ProcessaObjetosbancoPreAlt.fValidaTrigger;
     AErro := ProcessaObjetosbancoPreAlt.strErro;
  Finally
    FreeAndNil(ProcessaObjetosbancoPreAlt);
  End;
End;

{ TProcessaObjetosbancoPreAlt }

constructor TProcessaObjetosbancoPreAlt.Create;
begin
  FstrErro := '';
  blnForcaValidacao := false;
  blnValidaSeTemQueRemoverEstrutura := True;
  lstComando := TStringList.Create;
  lstConteudo := TStringList.Create;
  TriggerAlteracao := TStringList.Create;
  lstTriggerAnalise := TStringList.Create;

  qryQuery:= fCriaQuery;
  qryTrigger:= fCriaQuery;
  Script := fCriaScript;

{$IFDEF LINUX}
  strDataBase := objConnectionsManager.CurrentConnection.Database;
{$ELSE}
  strDataBase := qryQuery.Connection.Database;
{$ENDIF}

  blnEncontrouVersao := False;
  blnEncontrouProcedure := False;
  strTriggerEncontrada := '';
  pSetaCamposTrigger;
end;

destructor TProcessaObjetosbancoPreAlt.Destroy;
begin
 {$IFNDEF LINUX}
  FreeAndNil(qryQuery);
  FreeAndNil(qryTrigger);
  FreeAndNil(Script);
 {$ENDIF}
  FreeAndNil(TriggerAlteracao);
  FreeAndNil(lstTriggerAnalise);
  FreeAndNil(lstConteudo);
  FreeAndNil(lstComando);
  inherited;
end;

procedure TProcessaObjetosbancoPreAlt.pSetCreateTrigger(strTriggerName: String);
var
  i,
  intPosIni: Integer;
begin
  qryTrigger.SQL.Text := 'SHOW CREATE TRIGGER '+strTriggerName;

  qryTrigger.Open;


  lstConteudo.Text := qryTrigger.FieldByName('SQL Original Statement').AsString;
  lstTriggerAnalise.Text := qryTrigger.FieldByName('SQL Original Statement').AsString;

  intPosIni := fLinha('BEGIN');

  For i := 0 To intPosIni Do
    lstConteudo.Delete(0);

  intPosIni := fLinha('END', True) + 1;
  For i := intPosIni To  lstConteudo.Count-1 do
   lstConteudo.Delete(intPosIni);

  lstConteudo.Insert(0, 'BEGIN');


end;

function TProcessaObjetosbancoPreAlt.fGetSQL_COMPRALIQUIDO: TStringList;
begin
  lstComando.Clear;
  lstComando.Add('DELIMITER $$');
  lstComando.Add('');
  lstComando.Add('USE `'+strDataBase+'`$$');
  lstComando.Add('');
  lstComando.Add('DROP FUNCTION IF EXISTS `fPrecoCompraLiquido_PREALT`$$');
  lstComando.Add('');
  lstComando.Add('CREATE DEFINER=`dbacitel`@`localhost` FUNCTION `fPrecoCompraLiquido_PREALT`(fltPreCom DOUBLE, fltDesf01 DOUBLE, fltDesf02 DOUBLE,');
  lstComando.Add('fltDesf03 DOUBLE, fltDesf04 DOUBLE, fltDesf05 DOUBLE, fltDesf06 DOUBLE) RETURNS DOUBLE');
  lstComando.Add('BEGIN');
  lstComando.Add('      DECLARE Result DOUBLE;');
  lstComando.Add('');
  lstComando.Add('      SET Result := fltPreCom;');
  lstComando.Add('      SET Result := Result - ( Result * ( fltDesf01 / 100 ) );');
  lstComando.Add('      SET Result := Result - ( Result * ( fltDesf02 / 100 ) );');
  lstComando.Add('      SET Result := Result - ( Result * ( fltDesf03 / 100 ) );');
  lstComando.Add('      SET Result := Result - ( Result * ( fltDesf04 / 100 ) );');
  lstComando.Add('      SET Result := Result - ( Result * ( fltDesf05 / 100 ) );');
  lstComando.Add('      SET Result := Result - ( Result * ( fltDesf06 / 100 ) );');
  lstComando.Add('');
  lstComando.Add('      RETURN Result;');
  lstComando.Add('END $$');
  lstComando.Add('DELIMITER ;');
  Result := lstComando;
End;

function TProcessaObjetosbancoPreAlt.fGetSQL_CUSTOREAL: TStringList;
begin
  lstComando.Clear;
  lstComando.Add('DELIMITER $$');
  lstComando.Add('USE `'+strDataBase+'`$$');
  lstComando.Add('DROP FUNCTION IF EXISTS `fCalculaCustoReal_PREALT`$$');
  lstComando.Add('CREATE DEFINER=`dbacitel`@`localhost` FUNCTION `fCalculaCustoReal_PREALT`(pPRECUS DOUBLE(14,4),');
  lstComando.Add(' pICMSAI DOUBLE(14,4), pIMPFED DOUBLE(14,4),pDESOPE DOUBLE(14,4), pOUTVAL DOUBLE(14,4)) RETURNS DOUBLE(14,4)');
  lstComando.Add('    DETERMINISTIC');
  lstComando.Add('BEGIN');
  lstComando.Add('	DECLARE vCUSTO  DOUBLE(14,4);');
  lstComando.Add('	DECLARE vCALTMP DOUBLE (14,4);');
  lstComando.Add('	SET vCALTMP := (1 - (pICMSAI + pIMPFED + pDESOPE)/100);');
  lstComando.Add('	SET vCUSTO := (pPRECUS + pOUTVAL);');
  lstComando.Add('        RETURN (vCUSTO/vCALTMP);');
  lstComando.Add('END $$');
  lstComando.Add('DELIMITER ;');
  Result := lstComando;
end;

function TProcessaObjetosbancoPreAlt.fGetSQL_PINSEREPREALT: TStringList;
begin

  {$region 'Montagem do sql'}
  lstComando.Clear;

  lstComando.Add('DELIMITER $$');
  lstComando.Add('');
  lstComando.Add('USE `'+strDataBase+'`$$');
  lstComando.Add('');
  lstComando.Add('DROP PROCEDURE IF EXISTS `pSetaVariaveisPreAlt`$$');
  lstComando.Add('');
  lstComando.Add(' CREATE DEFINER=`dbacitel`@`localhost` PROCEDURE `pSetaVariaveisPreAlt`(strAutoInc CHAR(20), strCodEmp CHAR(3))');
  lstComando.Add('BEGIN');
  lstComando.Add('  SET @LOCAL_PREALT     :=  (SELECT PRE_LOCAL_ FROM REGPRE  WHERE REGPRE.AUTOINCREM = strAutoInc AND REGPRE.PRE_CODEMP = strCodEmp);');
  lstComando.Add('  SET @EMPRESA_PREALT   :=  (SELECT PRE_CODEMP FROM REGPRE  WHERE REGPRE.AUTOINCREM = strAutoInc AND REGPRE.PRE_CODEMP = strCodEmp);');
  lstComando.Add('  SET @OPERADOR_PREALT  :=  (SELECT PRE_CODOPE FROM REGPRE  WHERE REGPRE.AUTOINCREM = strAutoInc AND REGPRE.PRE_CODEMP = strCodEmp);');
  lstComando.Add('  SET @AGRUPADOR_PREALT :=  (SELECT PRE_AGRUPA FROM REGPRE  WHERE REGPRE.AUTOINCREM = strAutoInc AND REGPRE.PRE_CODEMP = strCodEmp);');
  lstComando.Add('');
  lstComando.Add('END$$');
  lstComando.Add('');
  lstComando.Add('DELIMITER ;');
  lstComando.Add('');
  lstComando.Add('');
  lstComando.Add('');
  lstComando.Add('');
  lstComando.Add('');

  lstComando.Add('DELIMITER $$');
  lstComando.Add('');
  lstComando.Add('USE `'+strDataBase+'`$$');
  lstComando.Add('');
  lstComando.Add('DROP PROCEDURE IF EXISTS `pInserePreAlt`$$');
  lstComando.Add('');
  lstComando.Add(' CREATE DEFINER=`dbacitel`@`localhost` PROCEDURE `pInserePreAlt`(VAL_CODEMP CHAR(3),');
  lstComando.Add('                                                                VAL_CODITE VARCHAR(5),');
  lstComando.Add('                                                                VAL_CODOPE CHAR(3),');
  lstComando.Add('                                                                VAL_AGRUAP DATETIME,');
  lstComando.Add('                                                                VAL_NOMFRM VARCHAR(100),');
  lstComando.Add('                                                                VAL_DOLANT CHAR(1),');
  lstComando.Add('                                                                VAL_DOLATU CHAR(1),');
  lstComando.Add('                                                                VAL_CUSANT DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_CUSATU DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_VE1ANT DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_VE1ATU DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_MA1ANT DECIMAL(18,8),');
  lstComando.Add('                                                                VAL_MA1ATU DECIMAL(18,8),');
  lstComando.Add('                                                                VAL_VE2ANT DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_VE2ATU DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_MA2ANT DECIMAL(18,8),');
  lstComando.Add('                                                                VAL_MA2ATU DECIMAL(18,8),');
  lstComando.Add('                                                                VAL_VE3ANT DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_VE3ATU DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_MA3ANT DECIMAL(18,8),');
  lstComando.Add('                                                                VAL_MA3ATU DECIMAL(18,8),');
  lstComando.Add('                                                                VAL_VE4ANT DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_VE4ATU DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_MA4ANT DECIMAL(18,8),');
  lstComando.Add('                                                                VAL_MA4ATU DECIMAL(18,8),');
  lstComando.Add('                                                                VAL_VE5ANT DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_VE5ATU DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_MA5ANT DECIMAL(18,8),');
  lstComando.Add('                                                                VAL_MA5ATU DECIMAL(18,8),');
  lstComando.Add('                                                                VAL_VE6ANT DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_VE6ATU DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_MA6ANT DECIMAL(18,8),');
  lstComando.Add('                                                                VAL_MA6ATU DECIMAL(18,8),');
  lstComando.Add('                                                                VAL_VE7ANT DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_VE7ATU DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_MA7ANT DECIMAL(18,8),');
  lstComando.Add('                                                                VAL_MA7ATU DECIMAL(18,8),');
  lstComando.Add('                                                                VAL_COMANT DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_COMATU DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_DF1ANT DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_DF1ATU DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_DF2ANT DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_DF2ATU DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_DF3ANT DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_DF3ATU DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_DF4ANT DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_DF4ATU DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_DF5ANT DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_DF5ATU DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_DF6ANT DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_DF6ATU DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_SFDANT DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_SFDATU DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_IPIANT DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_IPIATU DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_FREANT DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_FREATU DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_VFRANT DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_VFRATU DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_AFNANT DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_AFNATU DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_STIANT DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_STIATU DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_DABANT DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_DABATU DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_OTVANT DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_OTVATU DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_IMSANT DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_IMSATU DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_FEDANT DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_FEDATU DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_DESANT DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_DESATU DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_ICEANT DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_ICEATU DECIMAL(12,2),');

  lstComando.Add('                                                                VAL_TCIANT DECIMAL(12,6),');
  lstComando.Add('                                                                VAL_TCIATU DECIMAL(12,6),');
  lstComando.Add('                                                                VAL_TSCANT DECIMAL(12,6),');
  lstComando.Add('                                                                VAL_TSCATU DECIMAL(12,6),');
  lstComando.Add('                                                                VAL_DEPANT DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_DEPATU DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_DEIANT DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_DEIATU DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_FATANT DECIMAL(12,2),');
  lstComando.Add('                                                                VAL_FATATU DECIMAL(12,2),');

  lstComando.Add('                                                                VAL_CM1ANT DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_CM1ATU DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_CM2ANT DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_CM2ATU DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_CM3ANT DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_CM3ATU DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_CM4ANT DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_CM4ATU DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_CM5ANT DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_CM5ATU DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_CM6ANT DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_CM6ATU DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_CM7ANT DECIMAL(12,4),');
  lstComando.Add('                                                                VAL_CM7ATU DECIMAL(12,4),');
  lstComando.Add('                                                                KEY_PREALT VARCHAR(20))  ');

  lstComando.Add('BEGIN');

  lstComando.Add('  DECLARE BLNALTEROU BOOLEAN; ');

  lstComando.Add('  SET BLNALTEROU := (VAL_CUSANT <> VAL_CUSATU) OR');
  lstComando.Add('     (VAL_VE1ANT <> VAL_VE1ATU) OR (VAL_MA1ANT <> VAL_MA1ATU) OR');
  lstComando.Add('     (VAL_MA2ANT <> VAL_MA2ATU) OR (VAL_VE2ANT <> VAL_VE2ATU) OR');
  lstComando.Add('     (VAL_VE3ANT <> VAL_VE3ATU) OR (VAL_MA3ANT <> VAL_MA3ATU) OR');
  lstComando.Add('     (VAL_VE4ANT <> VAL_VE4ATU) OR (VAL_MA4ANT <> VAL_MA4ATU) OR');
  lstComando.Add('     (VAL_VE5ANT <> VAL_VE5ATU) OR (VAL_MA5ANT <> VAL_MA5ATU) OR');
  lstComando.Add('     (VAL_VE6ANT <> VAL_VE6ATU) OR (VAL_MA6ANT <> VAL_MA6ATU) OR');
  lstComando.Add('     (VAL_VE7ANT <> VAL_VE7ATU) OR (VAL_MA7ANT <> VAL_MA7ATU) OR');
  lstComando.Add('     (VAL_COMANT <> VAL_COMATU) OR');
  lstComando.Add('     (VAL_DF1ANT <> VAL_DF1ATU) OR (VAL_DF2ANT <> VAL_DF2ATU) OR');
  lstComando.Add('     (VAL_DF3ANT <> VAL_DF3ATU) OR (VAL_DF4ANT <> VAL_DF4ATU) OR');
  lstComando.Add('     (VAL_DF5ANT <> VAL_DF5ATU) OR (VAL_DF6ANT <> VAL_DF6ATU) OR');
  lstComando.Add('     (VAL_SFDANT <> VAL_SFDATU) OR (VAL_IPIANT <> VAL_IPIATU) OR');
  lstComando.Add('     (VAL_FREANT <> VAL_FREATU) OR (VAL_VFRANT <> VAL_VFRATU) OR');
  lstComando.Add('     (VAL_AFNANT <> VAL_AFNATU) OR (VAL_STIANT <> VAL_STIATU) OR');
  lstComando.Add('     (VAL_DABANT <> VAL_DABATU) OR (VAL_OTVANT <> VAL_OTVATU) OR');
  lstComando.Add('     (VAL_IMSANT <> VAL_IMSATU) OR (VAL_FEDANT <> VAL_FEDATU) OR');
  lstComando.Add('     (VAL_DESANT <> VAL_DESATU) OR (VAL_ICEANT <> VAL_ICEATU) OR ');
  lstComando.Add('     (VAL_CM1ANT <> VAL_CM1ATU) OR (VAL_CM2ANT <> VAL_CM2ATU) OR');
  lstComando.Add('     (VAL_CM3ANT <> VAL_CM3ATU) OR (VAL_CM4ANT <> VAL_CM4ATU) OR');
  lstComando.Add('     (VAL_CM5ANT <> VAL_CM5ATU) OR (VAL_CM6ANT <> VAL_CM6ATU) OR');
  lstComando.Add('     (VAL_TCIANT <> VAL_TCIATU) OR (VAL_TSCANT <> VAL_TSCATU) OR');
  lstComando.Add('     (VAL_DEPANT <> VAL_DEPATU) OR (VAL_DEIANT <> VAL_DEIATU) OR');
  lstComando.Add('     (VAL_FATANT <> VAL_FATATU) OR ');
  lstComando.Add('     (VAL_CM7ANT <> VAL_CM7ATU);');

  lstComando.Add('  IF BLNALTEROU THEN');
  lstComando.Add('     SET @AUTINC_PREALT = (SELECT PRO_AUTINC FROM PROINC WHERE PRO_NOMARQ = '+ QuotedStr('PREALT')+ ');');
  lstComando.Add('     SET @AUTOINCREM = CONCAT('+QuotedStr('001')+', RIGHT(CONCAT('+QuotedStr('0000000000000000')+', @AUTINC_PREALT:=@AUTINC_PREALT + 1), 14) , '+QuotedStr('001')+');');
  lstComando.Add('     UPDATE PROINC SET PRO_AUTINC = @AUTINC_PREALT WHERE PRO_NOMARQ = '+ QuotedStr('PREALT')+ ';');
  lstComando.Add('     INSERT INTO PREALT (ALT_CODEMP,');
  lstComando.Add('                         ALT_CODITE,');
  lstComando.Add('                         ALT_CODOPE,');
  lstComando.Add('                         ALT_AGRUAP,');
  lstComando.Add('                         AUTOINCREM,');
  lstComando.Add('                         ALT_NOMFRM,');
  lstComando.Add('                         ALT_DTAALT,');
  lstComando.Add('                         ALT_HORALT,');
  lstComando.Add('                         ALT_CUSANT,');
  lstComando.Add('                         ALT_CUSATU,');
  lstComando.Add('                         ALT_VE1ANT,');
  lstComando.Add('                         ALT_VE1ATU,');
  lstComando.Add('                         ALT_MA1ANT,');
  lstComando.Add('                         ALT_MA1ATU,');
  lstComando.Add('                         ALT_MA2ANT,');
  lstComando.Add('                         ALT_MA2ATU,');
  lstComando.Add('                         ALT_VE2ANT,');
  lstComando.Add('                         ALT_VE2ATU,');
  lstComando.Add('                         ALT_VE3ANT,');
  lstComando.Add('                         ALT_VE3ATU,');
  lstComando.Add('                         ALT_MA3ANT,');
  lstComando.Add('                         ALT_MA3ATU,');
  lstComando.Add('                         ALT_VE4ANT,');
  lstComando.Add('                         ALT_VE4ATU,');
  lstComando.Add('                         ALT_MA4ANT,');
  lstComando.Add('                         ALT_MA4ATU,');
  lstComando.Add('                         ALT_VE5ANT,');
  lstComando.Add('                         ALT_VE5ATU,');
  lstComando.Add('                         ALT_MA5ANT,');
  lstComando.Add('                         ALT_MA5ATU,');
  lstComando.Add('                         ALT_VE6ANT,');
  lstComando.Add('                         ALT_VE6ATU,');
  lstComando.Add('                         ALT_MA6ANT,');
  lstComando.Add('                         ALT_MA6ATU,');
  lstComando.Add('                         ALT_VE7ANT,');
  lstComando.Add('                         ALT_VE7ATU,');
  lstComando.Add('                         ALT_MA7ANT,');
  lstComando.Add('                         ALT_MA7ATU,');
  lstComando.Add('                         ALT_COMATU,');
  lstComando.Add('                         ALT_COMANT,');
  lstComando.Add('                         ALT_DF1ANT,');
  lstComando.Add('                         ALT_DF1ATU,');
  lstComando.Add('                         ALT_DF2ANT,');
  lstComando.Add('                         ALT_DF2ATU,');
  lstComando.Add('                         ALT_DF3ANT,');
  lstComando.Add('                         ALT_DF3ATU,');
  lstComando.Add('                         ALT_DF4ANT,');
  lstComando.Add('                         ALT_DF4ATU,');
  lstComando.Add('                         ALT_DF5ANT,');
  lstComando.Add('                         ALT_DF5ATU,');
  lstComando.Add('                         ALT_DF6ANT,');
  lstComando.Add('                         ALT_DF6ATU,');
  lstComando.Add('                         ALT_SFDANT,');
  lstComando.Add('                         ALT_SFDATU,');
  lstComando.Add('                         ALT_IPIANT,');
  lstComando.Add('                         ALT_IPIATU,');
  lstComando.Add('                         ALT_FREANT,');
  lstComando.Add('                         ALT_FREATU,');
  lstComando.Add('                         ALT_VFRANT,');
  lstComando.Add('                         ALT_VFRATU,');
  lstComando.Add('                         ALT_AFNANT,');
  lstComando.Add('                         ALT_AFNATU,');
  lstComando.Add('                         ALT_STIANT,');
  lstComando.Add('                         ALT_STIATU,');
  lstComando.Add('                         ALT_DABANT,');
  lstComando.Add('                         ALT_DABATU,');
  lstComando.Add('                         ALT_OTVANT,');
  lstComando.Add('                         ALT_OTVATU,');
  lstComando.Add('                         ALT_IMSANT,');
  lstComando.Add('                         ALT_IMSATU,');
  lstComando.Add('                         ALT_FEDANT,');
  lstComando.Add('                         ALT_FEDATU,');
  lstComando.Add('                         ALT_DESANT,');
  lstComando.Add('                         ALT_DESATU,');
  lstComando.Add('                         ALT_CURANT,');
  lstComando.Add('                         ALT_CURATU,');
  lstComando.Add('                         ALT_ICEANT,');
  lstComando.Add('                         ALT_ICEATU,');
  lstComando.Add('                         ALT_LIQANT,');
  lstComando.Add('                         ALT_LIQATU,');
  lstComando.Add('                         ALT_CM1ANT,');
  lstComando.Add('                         ALT_CM1ATU,');
  lstComando.Add('                         ALT_CM2ANT,');
  lstComando.Add('                         ALT_CM2ATU,');
  lstComando.Add('                         ALT_CM3ANT,');
  lstComando.Add('                         ALT_CM3ATU,');
  lstComando.Add('                         ALT_CM4ANT,');
  lstComando.Add('                         ALT_CM4ATU,');
  lstComando.Add('                         ALT_CM5ANT,');
  lstComando.Add('                         ALT_CM5ATU,');
  lstComando.Add('                         ALT_CM6ANT,');
  lstComando.Add('                         ALT_CM6ATU,');
  lstComando.Add('                         ALT_CM7ANT,');
  lstComando.Add('                         ALT_CM7ATU,');

  lstComando.Add('                         ALT_TCIANT,');
  lstComando.Add('                         ALT_TCIATU,');
  lstComando.Add('                         ALT_TSCANT,');
  lstComando.Add('                         ALT_TSCATU,');
  lstComando.Add('                         ALT_DEPANT,');
  lstComando.Add('                         ALT_DEPATU,');
  lstComando.Add('                         ALT_DEIANT,');
  lstComando.Add('                         ALT_DEIATU,');
  lstComando.Add('                         ALT_FATANT,');
  lstComando.Add('                         ALT_FATATU,');

  lstComando.Add('                         ALT_DOLANT,');
  lstComando.Add('                         ALT_DOLATU,');
  lstComando.Add('                         ALT_PERRES,');
  lstComando.Add('                         ALT_KEYALT');
  lstComando.Add('                         ) VALUES (');
  lstComando.Add('                         VAL_CODEMP,');
  lstComando.Add('                         VAL_CODITE,');
  lstComando.Add('                         VAL_CODOPE,');
  lstComando.Add('                         VAL_AGRUAP,');
  lstComando.Add('                         @AUTOINCREM,');
  lstComando.Add('                         VAL_NOMFRM,');
  lstComando.Add('                         CURDATE(),');
  lstComando.Add('                         CURTIME(),');
  lstComando.Add('                         VAL_CUSANT,');
  lstComando.Add('                         VAL_CUSATU,');
  lstComando.Add('                         VAL_VE1ANT,');
  lstComando.Add('                         VAL_VE1ATU,');
  lstComando.Add('                         VAL_MA1ANT,');
  lstComando.Add('                         VAL_MA1ATU,');
  lstComando.Add('                         VAL_MA2ANT,');
  lstComando.Add('                         VAL_MA2ATU,');
  lstComando.Add('                         VAL_VE2ANT,');
  lstComando.Add('                         VAL_VE2ATU,');
  lstComando.Add('                         VAL_VE3ANT,');
  lstComando.Add('                         VAL_VE3ATU,');
  lstComando.Add('                         VAL_MA3ANT,');
  lstComando.Add('                         VAL_MA3ATU,');
  lstComando.Add('                         VAL_VE4ANT,');
  lstComando.Add('                         VAL_VE4ATU,');
  lstComando.Add('                         VAL_MA4ANT,');
  lstComando.Add('                         VAL_MA4ATU,');
  lstComando.Add('                         VAL_VE5ANT,');
  lstComando.Add('                         VAL_VE5ATU,');
  lstComando.Add('                         VAL_MA5ANT,');
  lstComando.Add('                         VAL_MA5ATU,');
  lstComando.Add('                         VAL_VE6ANT,');
  lstComando.Add('                         VAL_VE6ATU,');
  lstComando.Add('                         VAL_MA6ANT,');
  lstComando.Add('                         VAL_MA6ATU,');
  lstComando.Add('                         VAL_VE7ANT,');
  lstComando.Add('                         VAL_VE7ATU,');
  lstComando.Add('                         VAL_MA7ANT,');
  lstComando.Add('                         VAL_MA7ATU,');
  lstComando.Add('                         VAL_COMATU,');
  lstComando.Add('                         VAL_COMANT,');
  lstComando.Add('                         VAL_DF1ANT,');
  lstComando.Add('                         VAL_DF1ATU,');
  lstComando.Add('                         VAL_DF2ANT,');
  lstComando.Add('                         VAL_DF2ATU,');
  lstComando.Add('                         VAL_DF3ANT,');
  lstComando.Add('                         VAL_DF3ATU,');
  lstComando.Add('                         VAL_DF4ANT,');
  lstComando.Add('                         VAL_DF4ATU,');
  lstComando.Add('                         VAL_DF5ANT,');
  lstComando.Add('                         VAL_DF5ATU,');
  lstComando.Add('                         VAL_DF6ANT,');
  lstComando.Add('                         VAL_DF6ATU,');
  lstComando.Add('                         VAL_SFDANT,');
  lstComando.Add('                         VAL_SFDATU,');
  lstComando.Add('                         VAL_IPIANT,');
  lstComando.Add('                         VAL_IPIATU,');
  lstComando.Add('                         VAL_FREANT,');
  lstComando.Add('                         VAL_FREATU,');
  lstComando.Add('                         VAL_VFRANT,');
  lstComando.Add('                         VAL_VFRATU,');
  lstComando.Add('                         VAL_AFNANT,');
  lstComando.Add('                         VAL_AFNATU,');
  lstComando.Add('                         VAL_STIANT,');
  lstComando.Add('                         VAL_STIATU,');
  lstComando.Add('                         VAL_DABANT,');
  lstComando.Add('                         VAL_DABATU,');
  lstComando.Add('                         VAL_OTVANT,');
  lstComando.Add('                         VAL_OTVATU,');
  lstComando.Add('                         VAL_IMSANT,');
  lstComando.Add('                         VAL_IMSATU,');
  lstComando.Add('                         VAL_FEDANT,');
  lstComando.Add('                         VAL_FEDATU,');
  lstComando.Add('                         VAL_DESANT,');
  lstComando.Add('                         VAL_DESATU,');
  lstComando.Add('                         fCalculaCustoReal_PREALT(VAL_CUSANT, VAL_IMSANT, VAL_FEDANT, VAL_DESANT, VAL_OTVANT),');
  lstComando.Add('                         fCalculaCustoReal_PREALT(VAL_CUSATU, VAL_IMSATU, VAL_FEDATU, VAL_DESATU, VAL_OTVATU),');
  lstComando.Add('                         VAL_ICEANT,');
  lstComando.Add('                         VAL_ICEATU,');
  lstComando.Add('                         fPrecoCompraLiquido_PREALT(VAL_COMANT, VAL_DF1ANT, VAL_DF2ANT, VAL_DF3ANT, VAL_DF4ANT, VAL_DF5ANT, VAL_DF6ANT),');
  lstComando.Add('                         fPrecoCompraLiquido_PREALT(VAL_COMATU, VAL_DF1ATU, VAL_DF2ATU, VAL_DF3ATU, VAL_DF4ATU, VAL_DF5ATU, VAL_DF6ATU),');
  lstComando.Add('                         VAL_CM1ANT,');
  lstComando.Add('                         VAL_CM1ATU,');
  lstComando.Add('                         VAL_CM2ANT,');
  lstComando.Add('                         VAL_CM2ATU,');
  lstComando.Add('                         VAL_CM3ANT,');
  lstComando.Add('                         VAL_CM3ATU,');
  lstComando.Add('                         VAL_CM4ANT,');
  lstComando.Add('                         VAL_CM4ATU,');
  lstComando.Add('                         VAL_CM5ANT,');
  lstComando.Add('                         VAL_CM5ATU,');
  lstComando.Add('                         VAL_CM6ANT,');
  lstComando.Add('                         VAL_CM6ATU,');
  lstComando.Add('                         VAL_CM7ANT,');
  lstComando.Add('                         VAL_CM7ATU,');
  lstComando.Add('                         VAL_TCIANT,');
  lstComando.Add('                         VAL_TCIATU,');
  lstComando.Add('                         VAL_TSCANT,');
  lstComando.Add('                         VAL_TSCATU,');
  lstComando.Add('                         VAL_DEPANT,');
  lstComando.Add('                         VAL_DEPATU,');
  lstComando.Add('                         VAL_DEIANT,');
  lstComando.Add('                         VAL_DEIATU,');
  lstComando.Add('                         VAL_FATANT,');
  lstComando.Add('                         VAL_FATATU,');

  lstComando.Add('                         VAL_DOLANT,');
  lstComando.Add('                         VAL_DOLATU,');
  lstComando.Add('                         "S",       ');
  lstComando.Add('                         KEY_PREALT);');
  lstComando.Add('END IF;');
  lstComando.Add('END $$');
  lstComando.Add('DELIMITER ;');
  {$endregion}
  Result := lstComando;
end;

function TProcessaObjetosbancoPreAlt.fGetSQL_PREALT: TStringList;
begin
  lstComando.Clear;
  Result := lstComando;
  {$Region 'Montagem do Result'}
  Result.Add('-- INICIO_PREALT');
  Result.Add('   IF IFNULL(@LOCAL_ALTPRE_COMPLEMENTO, "") <> "" THEN');
  Result.Add('   SET @LOCAL_PREALT = CONCAT(@LOCAL_ALTPRE_COMPLEMENTO +  @LOCAL_PREALT);');
  Result.Add('   END IF;');

  Result.Add('   CALL pSetaVariaveisPreAlt(NEW.ITE_PREALT, OLD.ITE_CODEMP); ');

  Result.Add('  SET @ITE_PREALT = NEW.ITE_PREALT; ');
  Result.Add('  SET NEW.ITE_PREALT := NULL; ');

  Result.Add('   IF ((IFNULL(@EMPRESA_PREALT, "") <> "") AND (@EMPRESA_PREALT = NEW.ITE_CODEMP)) OR ((IFNULL(@EMPRESA_PREALT, "") = "") AND (@ITE_PREALT = "")) THEN');
  Result.Add('   CALL pInserePreAlt(IF(IFNULL(@EMPRESA_PREALT, "") = "", NEW.ITE_CODEMP, @EMPRESA_PREALT),');
  Result.Add('                       NEW.ITE_CODITE,');
  Result.Add('                       IF(IFNULL(@OPERADOR_PREALT , "") = "", NULL, @OPERADOR_PREALT),');
  Result.Add('                       IF(IFNULL(@AGRUPADOR_PREALT,  0) = 0 , CURRENT_TIMESTAMP(), @AGRUPADOR_PREALT),');
  Result.Add('                       IF(IFNULL(@LOCAL_PREALT , "") = "", "", @LOCAL_PREALT),');
  Result.Add('                       OLD.ITE_PREDOL,');
  Result.Add('                       NEW.ITE_PREDOL,');
  Result.Add('                       OLD.ITE_PRECUS,');
  Result.Add('                       NEW.ITE_PRECUS ,');
  Result.Add('                       OLD.ITE_PREVE1,');
  Result.Add('                       NEW.ITE_PREVE1,');
  Result.Add('                       OLD.ITE_MARBR1,');
  Result.Add('                       NEW.ITE_MARBR1,');
  Result.Add('                       OLD.ITE_PREVE2,');
  Result.Add('                       NEW.ITE_PREVE2,');
  Result.Add('                       OLD.ITE_MARBR2,');
  Result.Add('                       NEW.ITE_MARBR2,');
  Result.Add('                       OLD.ITE_PREVE3,');
  Result.Add('                       NEW.ITE_PREVE3,');
  Result.Add('                       OLD.ITE_MARBR3,');
  Result.Add('                       NEW.ITE_MARBR3,');
  Result.Add('                       OLD.ITE_PREVE4,');
  Result.Add('                       NEW.ITE_PREVE4,');
  Result.Add('                       OLD.ITE_MARBR4,');
  Result.Add('                       NEW.ITE_MARBR4,');
  Result.Add('                       OLD.ITE_PREVE5,');
  Result.Add('                       NEW.ITE_PREVE5,');
  Result.Add('                       OLD.ITE_MARBR5,');
  Result.Add('                       NEW.ITE_MARBR5,');
  Result.Add('                       OLD.ITE_PREVE6,');
  Result.Add('                       NEW.ITE_PREVE6,');
  Result.Add('                       OLD.ITE_MARBR6,');
  Result.Add('                       NEW.ITE_MARBR6,');
  Result.Add('                       OLD.ITE_PREVE7,');
  Result.Add('                       NEW.ITE_PREVE7,');
  Result.Add('                       OLD.ITE_MARBR7,');
  Result.Add('                       NEW.ITE_MARBR7,');
  Result.Add('                       OLD.ITE_PRECOM,');
  Result.Add('                       NEW.ITE_PRECOM,');
  Result.Add('                       OLD.ITE_DESF01,');
  Result.Add('                       NEW.ITE_DESF01,');
  Result.Add('                       OLD.ITE_DESF02,');
  Result.Add('                       NEW.ITE_DESF02,');
  Result.Add('                       OLD.ITE_DESF03,');
  Result.Add('                       NEW.ITE_DESF03,');
  Result.Add('                       OLD.ITE_DESF04,');
  Result.Add('                       NEW.ITE_DESF04,');
  Result.Add('                       OLD.ITE_DESF05,');
  Result.Add('                       NEW.ITE_DESF05,');
  Result.Add('                       OLD.ITE_DESF06,');
  Result.Add('                       NEW.ITE_DESF06,');
  Result.Add('                       OLD.ITE_SUBFED,');
  Result.Add('                       NEW.ITE_SUBFED,');
  Result.Add('                       OLD.ITE_IPIENT,');
  Result.Add('                       NEW.ITE_IPIENT,');
  Result.Add('                       OLD.ITE_FREENT,');
  Result.Add('                       NEW.ITE_FREENT,');
  Result.Add('                       OLD.ITE_VALFRE,');
  Result.Add('                       NEW.ITE_VALFRE,');
  Result.Add('                       OLD.ITE_ACRFIN,');
  Result.Add('                       NEW.ITE_ACRFIN,');
  Result.Add('                       OLD.ITE_SUBSTI,');
  Result.Add('                       NEW.ITE_SUBSTI,');
  Result.Add('                       OLD.ITE_DESADB,');
  Result.Add('                       NEW.ITE_DESADB,');
  Result.Add('                       OLD.ITE_OUTVAL,');
  Result.Add('                       NEW.ITE_OUTVAL,');
  Result.Add('                       OLD.ITE_ICMSAI,');
  Result.Add('                       NEW.ITE_ICMSAI,');
  Result.Add('                       OLD.ITE_IMPFED,');
  Result.Add('                       NEW.ITE_IMPFED,');
  Result.Add('                       OLD.ITE_DESOPE,');
  Result.Add('                       NEW.ITE_DESOPE,');
  Result.Add('                       OLD.ITE_ICMENT,');
  Result.Add('                       NEW.ITE_ICMENT,');

  Result.Add('                       OLD.ITE_TCIFCU,');  //   OLD.ITE_TCIFCU
  Result.Add('                       NEW.ITE_TCIFCU,');  //   NEW.ITE_TCIFCU
  Result.Add('                       OLD.ITE_TSCUST,');  //   OLD.ITE_TSCUST
  Result.Add('                       NEW.ITE_TSCUST,');  //   NEW.ITE_TSCUST
  Result.Add('                       OLD.ITE_DEPICO,');  //   OLD.ITE_DEPICO
  Result.Add('                       NEW.ITE_DEPICO,');  //   NEW.ITE_DEPICO
  Result.Add('                       OLD.ITE_DEICMS,');  //   OLD.ITE_DEICMS
  Result.Add('                       NEW.ITE_DEICMS,');  //   NEW.ITE_DEICMS
  Result.Add('                       OLD.ITE_FATREG,');  //   OLD.ITE_FATREG
  Result.Add('                       NEW.ITE_FATREG,');  //   NEW.ITE_FATREG

  Result.Add('                       OLD.ITE_COMTB1,');
  Result.Add('                       NEW.ITE_COMTB1,');
  Result.Add('                       OLD.ITE_COMTB2,');
  Result.Add('                       NEW.ITE_COMTB2,');
  Result.Add('                       OLD.ITE_COMTB3,');
  Result.Add('                       NEW.ITE_COMTB3,');
  Result.Add('                       OLD.ITE_COMTB4,');
  Result.Add('                       NEW.ITE_COMTB4,');
  Result.Add('                       OLD.ITE_COMTB5,');
  Result.Add('                       NEW.ITE_COMTB5,');
  Result.Add('                       OLD.ITE_COMTB6,');
  Result.Add('                       NEW.ITE_COMTB6,');
  Result.Add('                       OLD.ITE_COMTB7,');
  Result.Add('                       NEW.ITE_COMTB7,');
  Result.Add('                       @ITE_PREALT);');

  Result.Add('   END IF;');
  Result.Add('-- FIM_PREALT');
  {$endregion}
end;

function TProcessaObjetosbancoPreAlt.fLinha(strConteudo: String; blnDownTo: Boolean = False): Integer;
var i: integer;
begin
  Result := -1;
  If Not blnDownTo Then
  Begin
    For i:= 0 To  lstConteudo.Count -1 do
    begin
      If Pos(strConteudo, lstConteudo[i])> 0 Then
      begin
        Result := i;
        break;
      End;
    End
  End
  Else
  Begin
    For i := lstConteudo.Count -1 DownTo  0 do
    begin
      If Pos(strConteudo, lstConteudo[i])> 0 Then
      begin
        Result := i;
        break;
      End;
    End
  End;
end;

function TProcessaObjetosbancoPreAlt.fSeparaChamadaProcedure: String;
var posIni: integer;
    posFim: integer;
begin
  Result := lstConteudo.Text;
  posIni := pos('pInserePreAlt', Result);
  Result := Copy(Result, posIni, Length(Result));
  posFim := pos(');', Result) + 1;
  Result := Copy(Result,0, posFim);
end;

function TProcessaObjetosbancoPreAlt.fValidaChamadaProcedureNaTrigger: Boolean;
 var
   strChamadaProcedure: String;
   i: integer;

begin
  FstrErro := '';
  strChamadaProcedure := fSeparaChamadaProcedure;
  If strChamadaProcedure <> '' Then
  Begin
    For i := 0 To High(ArrCamposTrigger) Do
    Begin
      If pos(ArrCamposTrigger[i], strChamadaProcedure) = 0 Then
       FstrErro := FstrErro + '[' + ArrCamposTrigger[i] + ']' + #$A#$D
    End
  End;

  If FstrErro <> '' Then
    FstrErro := 'Na trigger ' + strTriggerEncontrada + ' não tem os campos necessários : ' + #$A#$D + strErro;


  TriggerAlteracao.Text := fGetSQL_Trigger;


  Result := FstrErro = '';

end;


function TProcessaObjetosbancoPreAlt.fValidaTrigger: Boolean;
begin
  Result := true;
  pProcessaObjetos;
  If strErro <> '' Then
    Exit(False);
  If blnValidaSeTemQueRemoverEstrutura Then
  Begin
    If Result Then
      If (Not fConfiguracaoAtivaTriggerPreAlt) Then
      Begin
        If blnEncontrouProcedure Then
        Begin
          Result := False;
          FstrErro := 'A Configuração CFG_RESPRE esta inativa porem foi encontrado na trigger ' + strTriggerEncontrada + ' a chamada da procedure  pInserePreAlt, para prosseguir esta parte deve ser removida da trigger.';
        End;
      End
  End;

  pLogTrataAltTrigger;
end;

function TProcessaObjetosbancoPreAlt.fGetSQL_Trigger: String;
  var
    strTrigger: String;
begin
  If lstConteudo.Text <> '' Then
  begin
    qryQuery.SQL.Clear;
    qryQuery.SQL.Add('SHOW CREATE TRIGGER ' + strTriggerEncontrada);
    qryQuery.Open;
    lstConteudo.Clear;
    lstConteudo.Add('DELIMITER $$ ');
    lstConteudo.Add(' USE `'+strDataBase+'`$$');
    lstConteudo.Add(' DROP TRIGGER /*!50032 IF EXISTS */ `'+strTriggerEncontrada+'`$$ ');
    strTrigger := qryQuery.FieldByName('SQL Original Statement').AsString;

    lstConteudo.Text := lstConteudo.Text + strTrigger;
    lstConteudo.Add('$$');
    lstConteudo.Add('DELIMITER ;');

    pTrataCall_procedure;

    Result := lstConteudo.Text;
  End
  Else
    Result := fInsereTrigger;
End;

procedure TProcessaObjetosbancoPreAlt.pTrataCall_procedure;
  var
    intPosIni,
    intQuantidade,
    i,
    intPosFim : Integer;
begin

  If blnEncontrouProcedure Then
  Begin
    intPosIni := fLinha('-- INICIO_PREALT');
    intPosFim := fLinha('-- FIM_PREALT');
    intQuantidade := intPosFim - intPosIni;

    If intPosIni > -1 Then
    begin
      For i := 0 to intQuantidade do
        lstConteudo.Delete(intPosIni);
    End
  End;

  IntPosIni := fLinha('END', True) -1;

  If Not blnEncontrouVersao Then
    lstConteudo[intPosIni] := lstConteudo[intPosIni] + #$A#$D + '-- #' + strVersaoTrigger + #$A#$D + fGetSQL_PREALT.Text
  Else
  Begin
    lstConteudo.Text := StringReplace(lstConteudo.Text, strVersaoCurrent, '-- #' + strVersaoTrigger, [rfReplaceAll, rfIgnoreCase]);
    lstConteudo[intPosIni] := lstConteudo[intPosIni] + fGetSQL_PREALT.Text;
  End;

End;

function TProcessaObjetosbancoPreAlt.fEhPrecisoAtualizar: Boolean;
begin
  Result := False;
  If Not blnEncontrouProcedure Then
    Exit(True);
  If fltVersaoTriggerCurrent < fltVersaoTrigger Then
    Exit(True);
end;

procedure TProcessaObjetosbancoPreAlt.pCarregaVersao;
var
  intIndex: integer;
  strVersaoCurrentLocal: String;
begin
  fltVersaoTriggerCurrent := 0.0;
  blnEncontrouVersao := False;
  If Pos('#VERSAO', lstConteudo.Text)> 0 Then
  Begin
    blnEncontrouVersao := True;
    intIndex := fLinha('#VERSAO');

    strVersaoCurrent := lstConteudo[intIndex];

    strVersaoCurrentLocal := StringReplace(strVersaoCurrent, '--', '', [rfReplaceAll, rfIgnoreCase]);
    strVersaoCurrentLocal := StringReplace(strVersaoCurrentLocal, ' ', '', [rfReplaceAll, rfIgnoreCase]);
    strVersaoCurrentLocal := StringReplace(strVersaoCurrentLocal, 'VERSAO', '', [rfReplaceAll, rfIgnoreCase]);
    strVersaoCurrentLocal := StringReplace(strVersaoCurrentLocal, '#', '', [rfReplaceAll, rfIgnoreCase]);
    strVersaoCurrentLocal := Trim(strVersaoCurrentLocal);
    strVersaoCurrentLocal := StringReplace(strVersaoCurrentLocal, '.', ',', [rfReplaceAll, rfIgnoreCase]);

    fltVersaoTriggerCurrent := StrToFloat(strVersaoCurrentLocal);
  End;
End;



procedure TProcessaObjetosbancoPreAlt.pGerenciaLog;
begin
  qryQuery.SQL.Clear;
  qryQuery.SQL.Add('SELECT * FROM LOGTRG');
  qryQuery.SQL.Add(' WHERE TRG_NOMTRG = :NOMTRG');
  qryQuery.SQL.Add(' ORDER BY TRG_DTAALT DESC LIMIT 1');

  qryQuery.ParamByName('NOMTRG').AsString := strTriggerEncontrada;

  qryQuery.Open;

  If qryQuery.IsEmpty Then
    pInsereRegistroLogTrg(lstTriggerAnalise.Text, '')
  Else
    pAtualizaRegistroLogTrg;
end;

procedure TProcessaObjetosbancoPreAlt.pAtualizaRegistroLogTrg;
var lstTriggerGravada : TStringList;
begin
  lstTriggerGravada := TStringList.Create;
  Try
    lstTriggerGravada.Text := qryQuery.FieldByName('TRG_COMNOV').AsString;
    If lstTriggerAnalise.Text <> lstTriggerGravada.Text Then
      pInsereRegistroLogTrg(lstTriggerAnalise.Text, lstTriggerGravada.Text)
  finally
    FreeAndNil(lstTriggerGravada);
  End;

end;

procedure TProcessaObjetosbancoPreAlt.pInsereRegistroLogTrg(strComNov, strComOld: String);

begin
  qryQuery.SQL.Clear;
  qryQuery.SQL.Add('INSERT INTO LOGTRG (AUTOINCREM, TRG_DTAALT, TRG_COMNOV, TRG_COMOLD, TRG_NOMTRG) VALUES ');
  qryQuery.SQL.Add('                   (:AUTOINCREM, :TRG_DTAALT, :TRG_COMNOV, :TRG_COMOLD, :TRG_NOMTRG)');

  fInsereProCod('LOGTRG');
  qryQuery.ParamByName('AUTOINCREM').AsString := fRetAutoincrem('LOGTRG', VS_StrCodEmp);
  qryQuery.ParamByName('TRG_DTAALT').AsDateTime := fNow;
  qryQuery.ParamByName('TRG_COMNOV').AsString := strComNov;
  qryQuery.ParamByName('TRG_COMOLD').AsString := strComOld;
  qryQuery.ParamByName('TRG_NOMTRG').AsString := strTriggerEncontrada;

  qryQuery.ExecSQL;

  {}
end;



procedure TProcessaObjetosbancoPreAlt.pLogTrataAltTrigger;
begin
  If fConfiguracaoAtivaTriggerPreAlt Then
    If blnEncontrouProcedure Then
       pGerenciaLog;
end;

function TProcessaObjetosbancoPreAlt.fInsereTrigger: String;
begin
  Script.SQL.Clear;

  Script.SQL.Add('DELIMITER $$') ;
  Script.SQL.Add('') ;
  Script.SQL.Add('USE `' + strDataBase +'`$$') ;
  Script.SQL.Add('') ;
  Script.SQL.Add('DROP TRIGGER /*!50032 IF EXISTS */ `T_BU_ITEGER_PREALT`$$') ;
  Script.SQL.Add('') ;
  Script.SQL.Add('CREATE') ;
  Script.SQL.Add('    /*!50017 DEFINER = ' +QuotedStr('dbacitel') +'@' + QuotedStr('localhost') +' */') ;
  Script.SQL.Add('    TRIGGER `T_BU_ITEGER_PREALT` BEFORE UPDATE ON `ITEGER`') ;
  Script.SQL.Add('    FOR EACH ROW BEGIN') ;
  Script.SQL.Add('    -- #' + strVersaoTrigger) ;
  Script.SQL.Add('') ;
  Script.SQL.Add(    fGetSQL_PREALT.Text) ;
  Script.SQL.Add('') ;
  Script.SQL.Add('  END;') ;
  Script.SQL.Add('$$') ;
  Script.SQL.Add('') ;
  Script.SQL.Add('DELIMITER ;') ;
  Result := Script.SQL.Text;
end;

procedure TProcessaObjetosbancoPreAlt.pProcessaObjetos;
begin
  pProcessaTrigger;
end;

procedure TProcessaObjetosbancoPreAlt.pProcessaTrigger;
begin
  FstrErro := '';
  qryQuery.SQL.Add('SELECT * FROM information_schema.triggers');
  qryQuery.SQL.Add('WHERE  information_schema.triggers.trigger_schema =' + QuotedStr(strDataBase));
  qryQuery.SQL.Add(' AND information_schema.triggers.EVENT_MANIPULATION = "UPDATE"');
  qryQuery.SQL.Add(' AND EVENT_OBJECT_TABLE = "ITEGER"');
  qryQuery.SQL.Add(' AND ACTION_TIMING = "BEFORE"');

  pSetaVariaveisTrigger;

  If blnEncontrouProcedure Then
  Begin
    If Not fValidaChamadaProcedureNaTrigger Then
      Exit;
  End
  Else
  Begin
    if fConfiguracaoAtivaTriggerPreAlt(blnForcaValidacao) Then
    Begin
      If strTriggerEncontrada <> '' Then
        FstrErro := 'Não foi encontrado na Trigger ' + strTriggerEncontrada + ' a chamada do metodo "pInserePreAlt".'
      Else
        FstrErro := 'Não foi encontrado trigger com o evento Before Update na tabela ITEGER ';
    End;
  End;



  If FStrErro <> '' Then
    Exit;

End;

procedure TProcessaObjetosbancoPreAlt.pAddCamposTrigger(strNameField: String);
var pos: Integer;
begin
  SetLength(ArrCamposTrigger, Length(ArrCamposTrigger) + 1);
  pos := Length(ArrCamposTrigger);
  ArrCamposTrigger[pos-1] := strNameField;
end;


procedure TProcessaObjetosbancoPreAlt.pSetaCamposTrigger;
begin
  pAddCamposTrigger('ITE_PRECUS');
  pAddCamposTrigger('ITE_PREVE1');
  pAddCamposTrigger('ITE_MARBR1');
  pAddCamposTrigger('ITE_PREVE2');
  pAddCamposTrigger('ITE_MARBR2');
  pAddCamposTrigger('ITE_PREVE3');
  pAddCamposTrigger('ITE_MARBR3');
  pAddCamposTrigger('ITE_PREVE4');
  pAddCamposTrigger('ITE_MARBR4');
  pAddCamposTrigger('ITE_PREVE5');
  pAddCamposTrigger('ITE_MARBR5');
  pAddCamposTrigger('ITE_PREVE6');
  pAddCamposTrigger('ITE_MARBR6');
  pAddCamposTrigger('ITE_PREVE7');
  pAddCamposTrigger('ITE_MARBR7');
  pAddCamposTrigger('ITE_PRECOM');
  pAddCamposTrigger('ITE_DESF01');
  pAddCamposTrigger('ITE_DESF02');
  pAddCamposTrigger('ITE_DESF03');
  pAddCamposTrigger('ITE_DESF04');
  pAddCamposTrigger('ITE_DESF05');
  pAddCamposTrigger('ITE_DESF06');
  pAddCamposTrigger('ITE_SUBFED');
  pAddCamposTrigger('ITE_IPIENT');
  pAddCamposTrigger('ITE_FREENT');
  pAddCamposTrigger('ITE_VALFRE');
  pAddCamposTrigger('ITE_ACRFIN');
  pAddCamposTrigger('ITE_SUBSTI');
  pAddCamposTrigger('ITE_DESADB');
  pAddCamposTrigger('ITE_OUTVAL');
  pAddCamposTrigger('ITE_ICMSAI');
  pAddCamposTrigger('ITE_IMPFED');
  pAddCamposTrigger('ITE_DESOPE');
  pAddCamposTrigger('ITE_ICMENT');
  pAddCamposTrigger('ITE_COMTB1');
  pAddCamposTrigger('ITE_COMTB2');
  pAddCamposTrigger('ITE_COMTB3');
  pAddCamposTrigger('ITE_COMTB4');
  pAddCamposTrigger('ITE_COMTB5');
  pAddCamposTrigger('ITE_COMTB6');
  pAddCamposTrigger('ITE_COMTB7');

  pAddCamposTrigger('ITE_TCIFCU');
  pAddCamposTrigger('ITE_TCIFCU');
  pAddCamposTrigger('ITE_TSCUST');
  pAddCamposTrigger('ITE_TSCUST');
  pAddCamposTrigger('ITE_DEPICO');
  pAddCamposTrigger('ITE_DEPICO');
  pAddCamposTrigger('ITE_DEICMS');
  pAddCamposTrigger('ITE_DEICMS');
  pAddCamposTrigger('ITE_FATREG');
  pAddCamposTrigger('ITE_FATREG');

end;

procedure TProcessaObjetosbancoPreAlt.pSetaVariaveisTrigger;
begin
  qryQuery.Open;
  blnEncontrouVersao := False;
  blnEncontrouProcedure := False;
  strTriggerEncontrada := '';
  while not qryQuery.Eof do
  Begin
    pSetCreateTrigger(qryQuery.FieldByName('TRIGGER_NAME').AsString);
    If pos('pInserePreAlt', lstConteudo.Text) > 0 Then
      blnEncontrouProcedure := True;

    If blnEncontrouProcedure Then
    begin
       strTriggerEncontrada := qryQuery.FieldByName('TRIGGER_NAME').AsString;
       Exit;
    End;
    qryQuery.Next;
  End;

  If strTriggerEncontrada = ''  Then
  Begin
    qryQuery.First;
    strTriggerEncontrada := qryQuery.FieldByName('TRIGGER_NAME').AsString;
  End
end;

function fConfiguracaoAtivaTriggerPreAlt(AblnForcaValidacao: Boolean = False): Boolean;
  var
    qryConsulta: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery{$ENDIF};
begin
  if AblnForcaValidacao Then
    Exit(True);
  qryConsulta:= fCriaQuery;
  Try

    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD FROM CFGSIS');
    qryConsulta.SQL.Add(' WHERE SIS_CODCFG = "CFG_RESPRE"');
    qryConsulta.SQL.Add('   AND SIS_VALCFG = "S"');

    qryConsulta.Open;

    Result := qryConsulta.FieldByName('QTD').AsInteger > 0;
  Finally
  {$IFNDEF LINUX}
    FreeAndNil(qryConsulta);
  {$ENDIF}
  End;
end;

end.




