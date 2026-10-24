unit untModuloSAT;

interface

uses
  SysUtils,
  Windows,
  Classes,
  ActiveX,
  DateUtils,
  StrUtils,
  untTLock,

  {$IF Defined(UNIDAC)}
    Uni, UniSQLMonitor, MemDS, DBAccess
  {$ELSE}
    ZConnection, ZDataset
  {$IFEND}
  ;

type
  TModuloSAT = class
  private
    Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND};

    FObjLock: TLock;

    FNumDoc: String;
    FEspDoc: String;
    FCodEmp: String;
    FSerie: String;
    FCodCli: String;
    FTipFc: String;
    FMotCan: String;
    FstrImpLogSat: String;

    function EnviarSAT: Boolean;
    function CancelarSAT: Boolean;
    function ImprimirSAT(const AstrChaveAcesso: String): Boolean;
    procedure pAtualizaLogSat(AConfirmado: Boolean; const AstrStatus: String; const AstrTipo: String);

    procedure pLogarErro(E: Exception);
    function fEhImpressaoPendente(const AblnConfirmado: Boolean): Boolean;
    function fChaveAcesso: String ;
    function fTerminalSomenteImpressao(AqryConsulta: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND} ): Boolean ;
  public
    constructor Create;
    Destructor Destroy; override;

    procedure Executar;

    property strNumDoc: String Read FNumDoc;
    property strEspDoc: String Read FEspDoc;
    property strCodEmp: String Read FCodEmp;
    property strSerie: String Read FSerie;
    property strCodCli: String Read FCodCli;
    property strTipFc: String Read FTipFc;
    property strImpLogSat: String Read FstrImpLogSat;
  end;

implementation

uses untLibNfe, untUtil, untModulo, untImpressaoDiretaCitel, untDicSis;

{ TModuloSAT }

constructor TModuloSAT.Create;
begin
  inherited Create;

  Banco := frmModulo.Database;
end;

destructor TModuloSAT.Destroy;
begin
  if Assigned(FObjLock) then
  begin
    FObjLock.pDestravarTodos(True);
    FreeAndNil(FObjLock);
  end ;

  inherited;
end;

procedure TModuloSAT.pLogarErro(E: Exception);
Var
  LErro: TStringList;
begin
  LErro := TStringList.Create;
  Try
    LErro.Add('Erro: ' + E.Message);
    LErro.SaveToFile('ERRO_INTEGRADOR_SAT.TXT');

    raise Exception.Create(e.Message) ;

  Finally
    FreeAndNil(LErro);
  End;
end;

function TModuloSAT.EnviarSAT: Boolean;
begin
  Result := fProcessarRetornoEnvioLibNfe(FNumDoc, FEspDoc, FCodEmp, FSerie, FCodCli, FTipFc, Banco, False);
end;

function TModuloSAT.CancelarSAT: Boolean;
begin
  Result := fEnviarCancelamentoLibNfe(FNumDoc, FEspDoc, FCodEmp, FSerie, FCodCli, FTipFc, FMotCan);
end;

procedure TModuloSAT.pAtualizaLogSat(AConfirmado: Boolean; const AstrStatus: String; const AstrTipo: String);
var
  qryUpdate: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LSQL: String;
  LstrStatus: String ;
begin

  if (AstrStatus <> 'IP') and fEhImpressaoPendente(AConfirmado) then
    LstrStatus := 'IP'
  else
    LstrStatus := IIF(AConfirmado, IIF(AstrTipo = 'CN', 'CN', 'OK'), 'EE') ;

  Try
    qryUpdate := fCriaQuery(Banco);

    Try
      LSQL := '';
      LSQL := LSQL + 'UPDATE LOGSAT SET NFE_STATUS = :STATUS ';
      LSQL := LSQL + 'WHERE NFE_NUMDOC = :NUMDOC ';
      LSQL := LSQL + '  AND NFE_ESPDOC = :ESPDOC ';
      LSQL := LSQL + '  AND NFE_CODEMP = :CODEMP ';
      LSQL := LSQL + '  AND NFE_CODCLI = :CODCLI ';
      LSQL := LSQL + '  AND NFE_SERIE_ = :SERIE_ ';
      LSQL := LSQL + '  AND NFE_TIP_FC = :TIP_FC ';

      qryUpdate.SQL.Clear;
      qryUpdate.SQL.Add(LSQL);

      qryUpdate.ParamByName('NUMDOC').AsString := FNumDoc;
      qryUpdate.ParamByName('ESPDOC').AsString := FEspDoc;
      qryUpdate.ParamByName('CODEMP').AsString := FCodEmp;
      qryUpdate.ParamByName('CODCLI').AsString := FCodCli;
      qryUpdate.ParamByName('SERIE_').AsString := FSerie;
      qryUpdate.ParamByName('TIP_FC').AsString := FTipFc;
      qryUpdate.ParamByName('STATUS').AsString := LstrStatus;

      qryUpdate.ExecSQL;

    Finally
      FreeAndNil(qryUpdate);
    End;

  Except
    On E: Exception Do
      pLogarErro(E);
  End;
end;

procedure TModuloSAT.Executar;
var
  qryDocumentos: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LSQL: String;
  LResult: Boolean;
begin

  Try
    qryDocumentos := fCriaQuery(Banco);

    Try
      LSQL := '';
      if VS_SomenteImpressao then
      begin
        LSQL := LSQL + '(SELECT * FROM LOGSAT ';
        LSQL := LSQL + 'WHERE NFE_NUMSER = :NUMSER ';
        LSQL := LSQL + '  AND NFE_CODEMP = :CODEMP ';
        LSQL := LSQL + '  AND NFE_STATUS = "IP" ';
        LSQL := LSQL + '  AND NFE_IMPRES = "'+VS_ImpressoraSat+'" ';
        LSQL := LSQL + 'ORDER BY NFE_NUMDOC, NFE_DTACAD) ';
      end
      else
      begin
        LSQL := LSQL + '(SELECT * FROM LOGSAT ';
        LSQL := LSQL + 'WHERE NFE_NUMSER = :NUMSER ';
        LSQL := LSQL + '  AND NFE_CODEMP = :CODEMP ';
        LSQL := LSQL + '  AND NFE_STATUS = "GE" ';
        LSQL := LSQL + 'ORDER BY NFE_NUMDOC, NFE_DTACAD ';
        LSQL := LSQL + 'LIMIT 5) ' ;
        LSQL := LSQL + ' UNION ALL ';
        LSQL := LSQL + '(SELECT * FROM LOGSAT ';
        LSQL := LSQL + 'WHERE NFE_NUMSER = :NUMSER ';
        LSQL := LSQL + '  AND NFE_CODEMP = :CODEMP ';
        LSQL := LSQL + '  AND NFE_STATUS = "IP" ';
        LSQL := LSQL + '  AND NFE_IMPRES = "'+VS_ImpressoraSat+'" ';
        LSQL := LSQL + 'ORDER BY NFE_NUMDOC, NFE_DTACAD) ';
      end;

      qryDocumentos.SQL.Clear;
      qryDocumentos.SQL.Add(LSQL);

      qryDocumentos.ParamByName('NUMSER').AsString := VS_NumSerSat;
      qryDocumentos.ParamByName('CODEMP').AsString := VS_strCodEmp;

      qryDocumentos.Open;

      pLogImp('VS_NumSerSat > ' + VS_NumSerSat );
      pLogImp('VS_strCodEmp > ' + VS_strCodEmp );
      pLogImp('qryDocumentos.Open > ' + IntToStr(qryDocumentos.RecordCount) );

      While Not qryDocumentos.Eof Do
      Begin
        FNumDoc := qryDocumentos.FieldByName('NFE_NUMDOC').AsString;
        FEspDoc := qryDocumentos.FieldByName('NFE_ESPDOC').AsString;
        FCodEmp := qryDocumentos.FieldByName('NFE_CODEMP').AsString;
        FSerie  := qryDocumentos.FieldByName('NFE_SERIE_').AsString;
        FCodCli := qryDocumentos.FieldByName('NFE_CODCLI').AsString;
        FTipFc  := qryDocumentos.FieldByName('NFE_TIP_FC').AsString;
        FMotCan := qryDocumentos.FieldByName('NFE_MOTCAN').AsString;
        FstrImpLogSat := qryDocumentos.FieldByName('NFE_IMPRES').AsString;

        Try
          If FObjLock.fLock_Unlock('IntegradorSAT' + FNumDoc + FEspDoc + FCodEmp + FSerie + FCodCli + FTipFc, True, False) Then
          Begin
            if fTerminalSomenteImpressao(qryDocumentos) then
            begin
              qryDocumentos.Next;
              Continue ;
            end ;

            If qryDocumentos.FieldByName('NFE_TIPINT').AsString = 'CN' Then
            Begin
              pLogImp('vai cancelar > ' + FNumDoc + FEspDoc + FCodEmp + FSerie + FCodCli + FTipFc);
              LResult := CancelarSAT;
            End
            Else
            Begin
              pLogImp('vai enviar > ' + FNumDoc + FEspDoc + FCodEmp + FSerie + FCodCli + FTipFc);
              LResult := EnviarSAT;
            End;

            pAtualizaLogSat(LResult, qryDocumentos.FieldByName('NFE_STATUS').AsString, qryDocumentos.FieldByName('NFE_TIPINT').AsString);
          End;
        Finally
          FObjLock.fLock_Unlock('IntegradorSAT' + FNumDoc + FEspDoc + FCodEmp + FSerie + FCodCli + FTipFc, False, False);
        End;

        qryDocumentos.Next;
      End;
    Finally
      FreeAndNil(qryDocumentos);
    End;

  Except
    On E: Exception Do
      pLogarErro(E);
  End;
end;

function TModuloSAT.fChaveAcesso: String;
var
  LqryLogNfe: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  LstrSql: String ;
begin
  LqryLogNfe := fCriaQuery(Banco);
  try
    LstrSql := '' ;
    LstrSql := LstrSql + ' SELECT NFE_ACESSO ' ;
    LstrSql := LstrSql + ' FROM LOGNFE ' ;
    LstrSql := LstrSql + ' WHERE NFE_NUMDOC = :NUMDOC AND ' ;
    LstrSql := LstrSql + '       NFE_ESPDOC = :ESPDOC AND ' ;
    LstrSql := LstrSql + '       NFE_CODEMP = :CODEMP AND ' ;
    LstrSql := LstrSql + '       NFE_CODCLI = :CODCLI AND ' ;
    LstrSql := LstrSql + '       NFE_SERIE_ = :SERIE_ AND ' ;
    LstrSql := LstrSql + '       NFE_TIP_FC = :TIP_FC ' ;

    LqryLogNfe.SQL.Clear;
    LqryLogNfe.SQL.Add(LstrSql);
    LqryLogNfe.ParamByName('NUMDOC').AsString := FNumDoc ;
    LqryLogNfe.ParamByName('ESPDOC').AsString := FespDoc ;
    LqryLogNfe.ParamByName('CODEMP').AsString := FCodEmp ;
    LqryLogNfe.ParamByName('CODCLI').AsString := FCodCli ;
    LqryLogNfe.ParamByName('SERIE_').AsString := FSerie ;
    LqryLogNfe.ParamByName('TIP_FC').AsString := FTipFc ;
    LqryLogNfe.Open ;
    Result := LqryLogNfe.FieldByName('NFE_ACESSO').AsString ;
  finally
    FreeAndNil(LqryLogNfe) ;
  end ;
end;

function TModuloSAT.fEhImpressaoPendente(
  const AblnConfirmado: Boolean): Boolean;
begin
  Result := False ;
  if not AblnConfirmado then
    Exit ;

  if fEmptyStr(FstrImpLogSat) then
    Exit ;

  if FstrImpLogSat = VS_ImpressoraSat then
    Exit ;

  Result := True ;
end;

function TModuloSAT.fTerminalSomenteImpressao(AqryConsulta: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND}): Boolean;
var
  LblnResult: Boolean ;
  LstrChaveAcesso: String ;
begin
  Result := False ;
  If (AqryConsulta.FieldByName('NFE_STATUS').AsString = 'IP') and (FstrImpLogSat = VS_ImpressoraSat) Then
  Begin
    LstrChaveAcesso := fChaveAcesso ;
    if fEmptyStr(LstrChaveAcesso) then
      Exit(True) ;

    pLogImp('vai imprimir > ' + FNumDoc + FEspDoc + FCodEmp + FSerie + FCodCli + FTipFc);
    LblnResult := ImprimirSAT(LstrChaveAcesso);
    pLogImp('imprimiu > ' + FNumDoc + FEspDoc + FCodEmp + FSerie + FCodCli + FTipFc);
    pAtualizaLogSat(LblnResult, AqryConsulta.FieldByName('NFE_STATUS').AsString, AqryConsulta.FieldByName('NFE_TIPINT').AsString);
    exit(True) ;
  End ;

  If AqryConsulta.FieldByName('NFE_STATUS').AsString = 'IP' then
    Exit(True) ;

  if not VS_SomenteImpressao then
    Exit ;

  Result := True ;
end;

function TModuloSAT.ImprimirSAT(const AstrChaveAcesso: String): Boolean;
begin
  Try
    TImpressaoDiretaCitel.pImprimir(FCodEmp, VS_ImpressoraSat, AstrChaveAcesso, 'NFCE', False, VS_PidMD5DicSis);
    Result := True;
  Except
    On E: Exception Do
    Begin
      Raise E
    End;
  End;
end;

end.

