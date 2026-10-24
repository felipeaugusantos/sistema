unit untVerificarStatus;

interface

uses
{$IFDEF LINUX}
  NFe.Utils,
  NFe.Modulo,
{$ELSE}
  untUtil,
  untModulo,
  Windows,
  Dialogs,
  Forms,
  ActiveX,
{$ENDIF}
  SysUtils,
  Classes,
  DB,
  DateUtils,
  StrUtils,

  {$IF Defined(UNIDAC)}
    Uni, UniSQLMonitor, MemDS, DBAccess
  {$ELSE}
    ZConnection, ZDataset
  {$IFEND}
  ;

  type
    TVerificarStatus = class
  private
    FNumDoc: String;
    FEspDoc: String;
    FCodEmp: String;
    FSerie: String;
    FCodCli: String;
    FTipFc: String;
    FStatusNFe: String;
    FJaExecutando: Boolean;

    Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND};
    FRetorno: Boolean;

    procedure pAjustaCSTIcmsDestinatarioNaoContribuinte;
    procedure pRecalculaIcmsParaEstadoDestino(strTabela: String);
    procedure pAjustarCadFisMovGer(strTabela: String);

    procedure pProcessarStatusGE;
    function fExisteTarefaRecente(const strStatus: String; intSegundos: Integer=30): Boolean;
    function fRetNumDocLog: String;
  public
    constructor Create(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTipFc, strStatusNFe: String);
    destructor Destroy; override;

    procedure Executar;

    property Retorno: Boolean Read FRetorno;

    property strNumDoc: String Read FNumDoc;
    property strEspDoc: String Read FEspDoc;
    property strCodEmp: String Read FCodEmp;
    property strSerie:  String Read FSerie;
    property strCodCli: String Read FCodCli;
    property strTipFc:  String Read FTipFc;
  end;

implementation

uses
  untLibNfe, {$IF Defined(UNIDAC)} untModuloReplicacao {$ELSE} untModuloReplicacaoZeos {$IFEND},
  untLogDanfe, untDicSis;

{ TTarefaStatusNFe }

constructor TVerificarStatus.Create(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli,
  strTipFc, strStatusNFe: String);
begin
  inherited Create;

  Banco := frmModulo.Database;

  objLogDanfe.objConexao := frmModulo.Database;
  objLogDanfe.strNumDoc := strNumDoc;
  objLogDanfe.strEspDoc := strEspDoc;
  objLogDanfe.strCodEmp := strCodEmp;
  objLogDanfe.strCodCli := strCodCli;
  objLogDanfe.strSerie_ := strSerie;

  objLogDanfe.AddLog('TVerificarStatus.Create');

  FNumDoc := strNumDoc;
  FEspDoc := strEspDoc;
  FCodEmp := strCodEmp;
  FSerie  := strSerie;
  FCodCli := strCodCli;
  FTipFc  := strTipFc;
  FStatusNFe := strStatusNFe;

  FRetorno := False;
end;

destructor TVerificarStatus.Destroy;
begin
  inherited;
  objLogDanfe.AddLog('TVerificarStatus.Destroy');
end;

procedure TVerificarStatus.Executar;
var
  LContador: Integer;
begin
  If FJaExecutando Then
    Exit;

  objLogDanfe.AddLog('TVerificarStatus.Executar');

  Try
    If (FStatusNFe = 'GE') And (FEspDoc <> 'NS') Then
    Begin
      // Anti-colisão AE
      If fExisteTarefaRecente('AE', 60) Then
      Begin
        pLogImp('TVerificarStatus.Executar > Existe uma tarefa AE recente e uma GE surgiu, vou ignorar. Comportamento atípico (Verifique a existência de eventos de banco para LOGNFE)');
        Exit;
      End;
    End;

    If Pos(FStatusNFe, 'GE_OF_') > 0 Then
    Begin
      pProcessarStatusGE;
    End
    Else If FStatusNFe = 'GC' Then
    Begin
      FRetorno := fProcessarRetornoCancelamentoLibNfe(FNumDoc, FEspDoc, FCodEmp, FSerie, FCodCli, FTipFc,
        Banco, False);
    End
    Else If FStatusNFe = 'GM' Then
    Begin
      FRetorno := fProcessarRetornoManifestoEletronico(FNumDoc, Banco, FCodEmp);
    End
    Else If FStatusNFe = 'CG' Then
    Begin
      FRetorno := fProcessarRetornoConhecimentoEletronico(FNumDoc, FSerie, Banco);
    End
    Else If FStatusNFe = 'AE' Then
    Begin
      FRetorno := False;

      If (fUsaNotaServicoEletronicaEnotas And (FEspDoc = 'NS')) Then
      Begin
        pLogImp('fProcessarRetornoEnvioLibNfe ' + fRetNumDocLog + '>');
        FRetorno := fProcessarRetornoEnvioLibNfe(FNumDoc, FEspDoc, FCodEmp, FSerie, FCodCli, FTipFc, Banco, False);
        pLogImp('</fProcessarRetornoEnvioLibNfe ' + fRetNumDocLog + '> Result = ' + IIF(FRetorno, 'True', 'False'));
      End;

      If not FRetorno Then
      Begin
        pLogImp('<fEnviarNotaLibNfe ' + fRetNumDocLog + '>');

        FRetorno := fEnviarNotaLibNfe(FNumDoc, FEspDoc, FCodEmp, FSerie, FCodCli, FTipFc, Banco, False);

        If FRetorno then
        Begin
          For LContador := 1 To 3 Do
          Begin
            pLogImp('pProcessarStatusGE T' + IntToStr(LContador));
            pProcessarStatusGE;
            If FRetorno Then
              Break;
            Sleep(2000);
          End;
        End;

        pLogImp('</fEnviarNotaLibNfe ' + fRetNumDocLog + '> Result = ' + IIF(FRetorno, 'True', 'False'));
      End;
    End
    Else if FStatusNFe = 'EP' Then //ENVIAR E PROCESSAR RETORNO
    Begin
      try
        FRetorno := fEnviarNotaLibNfe(FNumDoc, FEspDoc, FCodEmp, FSerie, FCodCli, FTipFc, Banco, False);
      finally
        pProcessarStatusGE;
      end;
    End;
  Except
    On E: Exception Do
    Begin
      objLogDanfe.AddLog(E.Message);
      pLogarErro('TVerificarStatus.Executar', E);
    End;
  End;
end;

procedure TVerificarStatus.pProcessarStatusGE;
begin
  if (not fTabelaExiste('ICMUFD', Banco)) then
  begin
    pAjustaCSTIcmsDestinatarioNaoContribuinte;
  end;
  pLogImp('<fProcessarRetornoEnvioLibNfe ' + fRetNumDocLog + '>');
  FRetorno := fProcessarRetornoEnvioLibNfe(FNumDoc, FEspDoc, FCodEmp, FSerie, FCodCli, FTipFc, Banco, False);
  pLogImp('</fProcessarRetornoEnvioLibNfe ' + fRetNumDocLog + '> Result = ' + IIF(FRetorno, 'True', 'False'));
end;

function TVerificarStatus.fExisteTarefaRecente(const strStatus: String; intSegundos: Integer=30): Boolean;
Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strTarefa: String;
begin
  strTarefa := Trim('NFE_PROCESSAR_STATUS' + ' ' +
                    FNumDoc                + ' ' +
                    FEspDoc                + ' ' +
                    FCodEmp                + ' ' +
                    FSerie                 + ' ' +
                    FCodCli                + ' ' +
                    FTipFc                 + ' ' +
                    strStatus);

  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Text :=
       'SELECT NFE_TAREFA FROM NFE_TAREFAS ' +
       ' WHERE NFE_TAREFA = :TRF ' +
       '   AND NFE_INICIO IS NOT NULL ' +
       '   AND TIMESTAMPDIFF(SECOND, NFE_INICIO, CURRENT_TIMESTAMP) < :SEC ';

    qryAux.ParamByName('TRF').AsString  := strTarefa;
    qryAux.ParamByName('SEC').AsInteger := intSegundos;

    qryAux.Open;
    Result := Not qryAux.IsEmpty;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TVerificarStatus.pAjustaCSTIcmsDestinatarioNaoContribuinte;
  Var
    qryUpdate: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    qryCli: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    qryTab: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strTabela: String;
    strCliAti: String;

    strVALX90 : String;
    blnVALX90 : Boolean;
    blnAjusta : Boolean;

    procedure pWhere(qry: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
      blnFiltra90: Boolean);
    begin
      If blnFiltra90 Then
      Begin
        qry.SQL.Add('  DET_CLAFIS IN ("5922", "5929") AND ');
        qry.SQL.Add('  RIGHT(DET_CODFIS, 2) = "90" AND ');
      End;

      qry.SQL.Add('  DET_NUMDOC = :NUMDOC AND ');
      qry.SQL.Add('  DET_ESPDOC = :ESPDOC AND ');
      qry.SQL.Add('  DET_CODEMP = :CODEMP AND ');
      qry.SQL.Add('  DET_CODCLI = :CODCLI AND ');
      qry.SQL.Add('  DET_SERIE_ = :SERIE_ AND ');
      qry.SQL.Add('  DET_TIP_FC = :TIP_FC ');

      qry.ParamByName('NUMDOC').AsString := FNumDoc;
      qry.ParamByName('ESPDOC').AsString := FEspDoc;
      qry.ParamByName('CODEMP').AsString := FCodEmp;
      qry.ParamByName('CODCLI').AsString := FCodCli;
      qry.ParamByName('SERIE_').AsString := FSerie;
      qry.ParamByName('TIP_FC').AsString := FTipFc;
    end;
begin
  qryCli := nil;
  qryTab := nil;
  qryUpdate := nil;

  //ANOTAÇÃO DURANTE REVISÃO DE SQL'S UTILIZADOS PARA ENVIAR UMA NOTA:
  //
  //1-ESSA PROCEDURE pAjustaCSTIcmsDestinatarioNaoContribuinte FOI CRIADA NO REQUISITO 40635 / REVISÃO 126097
  //  ISSO AINDA É NECESSÁRIO??? UMA VEZ QUE CFG_CLIATI, JÁ NÃO É MAIS UMA CFG MAS SIM A TABELA CLIATI, OU SEJA,
  //  PARECE QUE NÃO ESTÁ MUITO COERENTE A REGRA AQUI COM A UNIT untFonteDados.pas NO QUE TANGE A strCliAti
  //  (REQUISITO 57885 / REVISÃO 137200). ACREDITO QUE TUDO ISSO DEVERIA VIR DE DENTRO DO AUTCOM.
  //
  //2-A FUNÇÃO ABAIXO pRecalculaIcmsParaEstadoDestino, SÓ É EXECUTADA SE "NÃO" EXISTE O CAMPO CADABF->ABF_SITDIF
  //  (OLHAR DESVIO DENTO DA MESMA) E TAMBÉM SE NÃO EXISTE A ABFICM, OU SEJA, APARAMENTEMENTE SÓ RESTOU ESSA
  //  OPERAÇÃO DE TROCA DE X90 PARA X41 QUE EXISTE TAMBÉM DENTRO DA untFonteDados.pas (OPERAÇÃO QUE ME PARECE
  //  ESTRANHA TAMBÉM).
  //
  //  UM AJUSTE FOI FEITO PARA EVITAR AO MÁXIMO QUE ISSO SEJA EXECUTADO MAS CASO A CFG_VALX90 NÃO EXISTA OU ESTEJA
  //  "S" PELO MENOS A QUERY qryCli É EXECUTADA A CADA "GE"
  //
  //  NOTA: PONTOS DE RASTREIO: BUSCAR POR 'VALX90' E 'ABF_SITDIF'

  If (FTipFc = 'F') Or
     (Not fCampoExiste('CADCLI', 'CLI_IESUNI', Banco)) Then
  Begin
    Exit;
  End;

  strCliAti := fCfgSisPainel('CLIATI');
  strVALX90 := fCfgSisPainel('VALX90');
  blnVALX90 := (fEmptyStr(strVALX90) Or (strVALX90 = 'S'));

  blnAjusta := (blnVALX90) Or (Not fTabelaExiste('ABFICM'));

  If (Not blnAjusta) Then
    Exit;

  qryCli := fCriaQuery(Nil);
  qryCli.SQL.Add('SELECT CLI_I_E_S_, CLI_IESUNI, CLI_CONSUM, CLI_CODATI FROM CADCLI WHERE CLI_CODCLI = :CODCLI');
  qryCli.ParamByName('CODCLI').AsString := FCodCli;
  qryCli.Open;

  If strCliAti <> qryCli.FieldByName('CLI_CODATI').AsString Then
  Begin
    If (Not fEmptyStr(qryCli.FieldByName('CLI_I_E_S_').AsString)) Or
       (qryCli.FieldByName('CLI_IESUNI').AsString='N') Then
    Begin
      FreeAndNil(qryCli);
      Exit;
    End;
  End;

  strTabela := '';

  qryTab := fCriaQuery(Nil);
  qryTab.SQL.Add('SELECT GROUP_CONCAT(DET_ESTADO) AS DET_ESTADO, GROUP_CONCAT(CID_ESTADO) AS CID_ESTADO, ');
  qryTab.SQL.Add('COUNT(*) AS QTD, SUM(IF(DET_CLAFIS IN ("5922", "5929") AND RIGHT(DET_CODFIS, 2) = "90", 1, 0)) AS QTD90 FROM MOVDET ');
  qryTab.SQL.Add('JOIN CADEMP ON EMP_CODEMP = DET_CODEMP ');
  qryTab.SQL.Add('JOIN CADCID ON CID_CODCID = EMP_CODCID ');
  qryTab.SQL.Add('WHERE ');
  pWhere(qryTab, False);
  qryTab.Open;
  If qryTab.FieldByName('QTD').AsInteger > 0 Then
  Begin
    strTabela := 'MOVDET';
  End
  Else
  Begin
    qryTab.Close;
    qryTab.SQL.Clear;
    qryTab.SQL.Add('SELECT GROUP_CONCAT(DET_ESTADO) AS DET_ESTADO, GROUP_CONCAT(CID_ESTADO) AS CID_ESTADO, ');
    qryTab.SQL.Add('COUNT(*) AS QTD, SUM(IF(DET_CLAFIS IN ("5922", "5929") AND RIGHT(DET_CODFIS, 2) = "90", 1, 0)) AS QTD90 FROM NOTDET ');
    qryTab.SQL.Add('JOIN CADEMP ON EMP_CODEMP = DET_CODEMP ');
    qryTab.SQL.Add('JOIN CADCID ON CID_CODCID = EMP_CODCID ');
    qryTab.SQL.Add('WHERE ');
    pWhere(qryTab, False);
    qryTab.Open;

    If qryTab.FieldByName('QTD').AsInteger > 0 Then
    Begin
      strTabela := 'NOTDET';
    End;
  End;

  If (blnVALX90) And (Not fEmptyStr(strTabela)) And
     (qryTab.FieldByName('QTD90').AsInteger > 0) Then
  Begin
    qryUpdate := fCriaQuery(Nil);
    qryUpdate.SQL.Add('UPDATE ' + strTabela + ' SET ');
    qryUpdate.SQL.Add('  DET_CODFIS = CONCAT(LEFT(DET_CODFIS,1), "41") ');
    qryUpdate.SQL.Add('WHERE ');
    pWhere(qryUpdate, True);
    qryUpdate.ExecSQL;
  End;

  If LeftStr(qryTab.FieldByName('DET_ESTADO').AsString, 2) <> LeftStr(qryTab.FieldByName('CID_ESTADO').AsString, 2) Then
  Begin
    If (Not fTabelaExiste('ABFICM')) Then
    Begin
      If (qryCli.FieldByName('CLI_CONSUM').AsString = 'S') Then
      Begin
        pRecalculaIcmsParaEstadoDestino(strTabela);
      End
      Else If (Pos(strCliAti, qryCli.FieldByName('CLI_CODATI').AsString) > 0) Then
      Begin
        pRecalculaIcmsParaEstadoDestino(strTabela);
      End;
    End;
  End;

  If Assigned(qryCli) Then
    FreeAndNil(qryCli);
  If Assigned(qryUpdate) Then
    FreeAndNil(qryUpdate);
  If Assigned(qryTab) Then
    FreeANdNil(qryTab);
end;

procedure TVerificarStatus.pAjustarCadFisMovGer(strTabela: String);
  Var
    qryDet: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strUpdFis: String;
    intContador: Integer;
    qryUpdFis: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    qryUpdGer: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

    fltTotIcms: Double;
    fltTotBasIcms: Double;
begin
  fltTotIcms := 0;
  fltTotBasIcms := 0;

  strUpdFis := 'UPDATE CADFIS SET ';
  For intContador := 1 To 5 Do
  Begin
    strUpdFis := strUpdFis + 'FIS_CLFSC' + IntToStr(intContador) + ' = :CLFSC' + IntToStr(intContador) + ', ';
    strUpdFis := strUpdFis + 'FIS_VLCON' + IntToStr(intContador) + ' = :VLCON' + IntToStr(intContador) + ', ';
    strUpdFis := strUpdFis + 'FIS_BASIC' + IntToStr(intContador) + ' = :BASIC' + IntToStr(intContador) + ', ';
    strUpdFis := strUpdFis + 'FIS_ALQIC' + IntToStr(intContador) + ' = :ALQIC' + IntToStr(intContador) + ', ';
    strUpdFis := strUpdFis + 'FIS_VLRIC' + IntToStr(intContador) + ' = :VALIC' + IntToStr(intContador) + ', ';
    strUpdFis := strUpdFis + 'FIS_RETID' + IntToStr(intContador) + ' = :RETID' + IntToStr(intContador) + ', ';
    strUpdFis := strUpdFis + 'FIS_BCRET' + IntToStr(intContador) + ' = :BCRET' + IntToStr(intContador) + ', ';
    strUpdFis := strUpdFis + 'FIS_BASIP' + IntToStr(intContador) + ' = :BASIP' + IntToStr(intContador) + ', ';
    strUpdFis := strUpdFis + 'FIS_VLRIP' + IntToStr(intContador) + ' = :VLRIP' + IntToStr(intContador) + ', ';
    strUpdFis := strUpdFis + 'FIS_OUTRA' + IntToStr(intContador) + ' = :OUTRA' + IntToStr(intContador) + ', ';
    strUpdFis := strUpdFis + 'FIS_ISENT' + IntToStr(intContador) + ' = :ISENT' + IntToStr(intContador) + ' ';

    If intContador < 5 Then
    Begin
      strUpdFis := strUpdFis + ', ';
    End;
  End;

  strUpdFis := strUpdFis + 'WHERE ';
  strUpdFis := strUpdFis + '  FIS_NUMDOC = :NUMDOC AND ';
  strUpdFis := strUpdFis + '  FIS_ESPDOC = :ESPDOC AND ';
  strUpdFis := strUpdFis + '  FIS_CODEMP = :CODEMP AND ';
  strUpdFis := strUpdFis + '  FIS_FORCLI = :CODCLI AND ';
  strUpdFis := strUpdFis + '  FIS_SERIE_ = :SERIE_ AND ';
  strUpdFis := strUpdFis + '  FIS_TIP_FC = :TIP_FC ';

  qryUpdFis := fCriaQuery(Nil);
  qryUpdFis.SQL.Add(strUpdFis);
  qryUpdFis.ParamByName('NUMDOC').AsString := FNumDoc;
  qryUpdFis.ParamByName('ESPDOC').AsString := FEspDoc;
  qryUpdFis.ParamByName('CODEMP').AsString := FCodEmp;
  qryUpdFis.ParamByName('CODCLI').AsString := FCodCli;
  qryUpdFis.ParamByName('SERIE_').AsString := FSerie;
  qryUpdFis.ParamByName('TIP_FC').AsString := FTipFc;

  qryDet := fCriaQuery(Nil);
  qryDet.SQL.Add('SELECT ');
  qryDet.SQL.Add('  DET_CLAFIS, ');
  qryDet.SQL.Add('  DET_ALQICM, ');
  qryDet.SQL.Add('  SUM(DET_VLRCON) AS VLRCON, ');
  qryDet.SQL.Add('  SUM(DET_BASICM) AS BASICM, ');
  qryDet.SQL.Add('  SUM(DET_VALICM) AS VALICM, ');
  qryDet.SQL.Add('  SUM(DET_BASRET) AS BASRET, ');
  qryDet.SQL.Add('  SUM(DET_VALRET) AS VALRET, ');
  qryDet.SQL.Add('  SUM(DET_BASIPI) AS BASIPI, ');
  qryDet.SQL.Add('  SUM(DET_VALIPI) AS VALIPI ');

  If fCampoExiste(strTabela, 'DET_OUTICM', Banco) Then
  Begin
    qryDet.SQL.Add('  , SUM(DET_OUTICM) AS OUTROS, ');
    qryDet.SQL.Add('  SUM(DET_ISEICM) AS ISENTO ');
  End;
  qryDet.SQL.Add('FROM ');
  qryDet.SQL.Add('  ' + strTabela + ' ');
  qryDet.SQL.Add('JOIN ' + IIF(strTabela='MOVDET', 'MOVTRI', 'NOTTRI') + ' T ON T.DET_SEQGER = AUTOINCREM ');
  qryDet.SQL.Add('WHERE ');
  qryDet.SQL.Add('  DET_NUMDOC = :NUMDOC AND ');
  qryDet.SQL.Add('  DET_ESPDOC = :ESPDOC AND ');
  qryDet.SQL.Add('  DET_CODEMP = :CODEMP AND ');
  qryDet.SQL.Add('  DET_CODCLI = :CODCLI AND ');
  qryDet.SQL.Add('  DET_SERIE_ = :SERIE_ AND ');
  qryDet.SQL.Add('  DET_TIP_FC = :TIP_FC ');
  qryDet.SQL.Add('GROUP BY DET_CLAFIS, DET_ALQICM ');

  qryDet.ParamByName('NUMDOC').AsString := FNumDoc;
  qryDet.ParamByName('ESPDOC').AsString := FEspDoc;
  qryDet.ParamByName('CODEMP').AsString := FCodEmp;
  qryDet.ParamByName('CODCLI').AsString := FCodCli;
  qryDet.ParamByName('SERIE_').AsString := FSerie;
  qryDet.ParamByName('TIP_FC').AsString := FTipFc;
  qryDet.Open;

  intContador := 1;
  While Not qryDet.Eof Do
  Begin
    qryUpdFis.ParamByName('CLFSC' + IntToStr(intContador)).AsString := qryDet.FieldByName('DET_CLAFIS').AsString;
    qryUpdFis.ParamByName('VLCON' + IntToStr(intContador)).AsFloat := qryDet.FieldByName('VLRCON').AsFloat;
    qryUpdFis.ParamByName('BASIC' + IntToStr(intContador)).AsFloat := qryDet.FieldByName('BASICM').AsFloat;
    qryUpdFis.ParamByName('ALQIC' + IntToStr(intContador)).AsFloat := qryDet.FieldByName('DET_ALQICM').AsFloat;
    qryUpdFis.ParamByName('VALIC' + IntToStr(intContador)).AsFloat := qryDet.FieldByName('VALICM').AsFloat;
    qryUpdFis.ParamByName('RETID' + IntToStr(intContador)).AsFloat := qryDet.FieldByName('VALRET').AsFloat;
    qryUpdFis.ParamByName('BCRET' + IntToStr(intContador)).AsFloat := qryDet.FieldByName('BASRET').AsFloat;
    qryUpdFis.ParamByName('BASIP' + IntToStr(intContador)).AsFloat := qryDet.FieldByName('BASIPI').AsFloat;
    qryUpdFis.ParamByName('VLRIP' + IntToStr(intContador)).AsFloat := qryDet.FieldByName('VALIPI').AsFloat;

    If qryDet.FindField('OUTROS') <> Nil Then
    Begin
      qryUpdFis.ParamByName('OUTRA' + IntToStr(intContador)).AsFloat := qryDet.FieldByName('OUTROS').AsFloat;
      qryUpdFis.ParamByName('ISENT' + IntToStr(intContador)).AsFloat := qryDet.FieldByName('ISENTO').AsFloat;
    End
    Else
    Begin
      qryUpdFis.ParamByName('OUTRA' + IntToStr(intContador)).AsFloat := qryDet.FieldByName('VLRCON').AsFloat -
                                                                        qryDet.FieldByName('BASICM').AsFloat -
                                                                        qryDet.FieldByName('VALRET').AsFloat -
                                                                        qryDet.FieldByName('VALIPI').AsFloat;
      qryUpdFis.ParamByName('ISENT' + IntToStr(intContador)).AsFloat := 0;
    End;

    fltTotIcms := fltTotIcms + qryDet.FieldByName('VALICM').AsFloat;
    fltTotBasIcms := fltTotBasIcms + qryDet.FieldByName('BASICM').AsFloat;

    qryDet.Next;
    Inc(intContador);
  End;
  qryUpdFis.ExecSQL;

  qryUpdGer := fCriaQuery(Nil);
  qryUpdGer.SQL.Add('UPDATE ' + IIF(strTabela='MOVDET', 'MOVGER', 'NOTGER') + ' SET ');
  qryUpdGer.SQL.Add('  GER_BASICM = :BASICM, GER_TOTICM = :VALICM ');
  qryUpdGer.SQL.Add('WHERE ');
  qryUpdGer.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
  qryUpdGer.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
  qryUpdGer.SQL.Add('  GER_CODEMP = :CODEMP AND ');
  qryUpdGer.SQL.Add('  GER_CODCLI = :CODCLI AND ');
  qryUpdGer.SQL.Add('  GER_SERIE_ = :SERIE_ AND ');
  qryUpdGer.SQL.Add('  GER_TIP_FC = :TIP_FC ');

  qryUpdGer.ParamByName('BASICM').AsFloat := fltTotBasIcms;
  qryUpdGer.ParamByName('VALICM').AsFloat := fltTotIcms;

  qryUpdGer.ParamByName('NUMDOC').AsString := FNumDoc;
  qryUpdGer.ParamByName('ESPDOC').AsString := FEspDoc;
  qryUpdGer.ParamByName('CODEMP').AsString := FCodEmp;
  qryUpdGer.ParamByName('CODCLI').AsString := FCodCli;
  qryUpdGer.ParamByName('SERIE_').AsString := FSerie;
  qryUpdGer.ParamByName('TIP_FC').AsString := FTipFc;
  qryUpdGer.ExecSQL;

  FreeAndNil(qryDet);
  FreeAndNil(qryUpdFis);
  FreeAndNil(qryUpdGer);
end;

procedure TVerificarStatus.pRecalculaIcmsParaEstadoDestino(strTabela: String);
  Var
    qryDet: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    qryAbf: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    qryEditDet: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    qryEditTri: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    blnAlterouItem: Boolean;
    fltFatorBaseTotIte: Double;
    fltBaseIcmsDiretaOriginal: Double;

    fltOutros: Double;
    strCstOriginal: String;
    blnSimPau: Boolean;
    blnZerSim: Boolean;
    blnAbfItegerExiste : Boolean;
begin
  If fCampoExiste('CADABF', 'ABF_SITDIF', Banco) Then
  Begin
    Exit;
  End;

  blnSimPau := False;
  blnZerSim := False;
  blnAbfItegerExiste := fCampoExiste('ITEGER', 'ITE_CODABF', Banco);

  If fExisteConfiguracao('SIMPAU', Banco) Then
    blnSimPau := fCfgSis('SIMPAU', varBoolean, VS_strCodEmp, Banco);

  If fExisteConfiguracao('ZERSIM', Banco) Then
    blnZerSim := fCfgSis('ZERSIM', varBoolean, VS_strCodEmp, Banco);

  blnAlterouItem := False;
  qryAbf := fCriaQuery(Nil);
  qryAbf.SQL.Add('SELECT * FROM CADABF WHERE ABF_CODABF = :CODABF AND ABF_ESTADO IN(:ESTORI, :ESTDES)');

  qryDet := fCriaQuery(Nil);
  qryDet.SQL.Add('SELECT ');
  qryDet.SQL.Add('  ' + strTabela + '.AUTOINCREM, DET_VLRCON, DET_CODFIS, DET_VALIPI, DET_DESACE, DET_TOTFRE, DET_CLAFIS, DET_CODEMP, DET_TOTITE, DET_DESESP, DET_BASICM, DET_ALQICM, DET_VALICM, DET_ESTADO, ');
  qryDet.SQL.Add('  CADITE.ITE_CODABF CADITE_CODABF, ');

  If (blnAbfItegerExiste) Then
    qryDet.SQL.Add('  ITEGER.ITE_CODABF ITEGER_CODABF, ');

  qryDet.SQL.Add('  CID_ESTADO ');
  qryDet.SQL.Add('FROM ' + strTabela + ' ');
  qryDet.SQL.Add('JOIN CADITE ON CADITE.ITE_CODITE = DET_CODITE ');
  qryDet.SQL.Add('JOIN ITEGER ON ITEGER.ITE_CODITE = DET_CODITE AND ITEGER.ITE_CODEMP = DET_CODEMP ');
  qryDet.SQL.Add('JOIN CADEMP ON EMP_CODEMP = DET_CODEMP ');
  qryDet.SQL.Add('JOIN CADCID ON CID_CODCID = EMP_CODCID ');
  qryDet.SQL.Add('WHERE ');
  qryDet.SQL.Add('  DET_NUMDOC = :NUMDOC AND ');
  qryDet.SQL.Add('  DET_ESPDOC = :ESPDOC AND ');
  qryDet.SQL.Add('  DET_CODEMP = :CODEMP AND ');
  qryDet.SQL.Add('  DET_CODCLI = :CODCLI AND ');
  qryDet.SQL.Add('  DET_SERIE_ = :SERIE_ AND ');
  qryDet.SQL.Add('  DET_TIP_FC = :TIP_FC AND ');
  qryDet.SQL.Add('  LEFT(DET_CLAFIS,1) = "6" AND ');

  If blnSimPau Then
  Begin
    qryDet.SQL.Add('  RIGHT(DET_CODFIS,2) IN ("10", "30", "60", "70") ');
  End
  Else
  Begin
    qryDet.SQL.Add('  RIGHT(DET_CODFIS,2) IN ("00", "20", "10", "30", "60", "70") ');
  End;

  qryEditDet := fCriaQuery(Nil);
  qryEditDet.SQL.Add('SELECT AUTOINCREM, DET_CODEMP, DET_TOTITE, DET_DESESP, DET_BASICM, DET_ALQICM, DET_VALICM, DET_PERRED, DET_PERBAS, DET_CODFIS ');
  qryEditDet.SQL.Add('FROM ' + strTabela + ' WHERE AUTOINCREM = :AUTINC ');

  If (fCampoExiste('MOVTRI', 'DET_OUTICM', Banco)) And
     (fCampoExiste('MOVTRI', 'DET_ISEICM', Banco)) Then
  Begin
    qryEditTri := fCriaQuery(Nil);
    qryEditTri.SQL.Add('SELECT DET_SEQGER, DET_OUTICM, DET_ISEICM ');
    qryEditTri.SQL.Add('FROM ' + IIF(strTabela='MOVDET', 'MOVTRI', 'NOTTRI') + ' WHERE DET_SEQGER = :SEQGER ');
  End;

  qryDet.ParamByName('NUMDOC').AsString := FNumDoc;
  qryDet.ParamByName('ESPDOC').AsString := FEspDoc;
  qryDet.ParamByName('CODEMP').AsString := FCodEmp;
  qryDet.ParamByName('CODCLI').AsString := FCodCli;
  qryDet.ParamByName('SERIE_').AsString := FSerie;
  qryDet.ParamByName('TIP_FC').AsString := FTipFc;
  qryDet.Open;

  Banco.StartTransaction;
  Try
    While (Not qryDet.Eof) Do
    Begin
      blnAlterouItem := True;

      strCstOriginal := qryDet.FieldByName('DET_CODFIS').AsString;

      qryAbf.Close;

      If (fCfgSis('TIPABF', varString, FCodEmp, Banco) = '1') Or (Not blnAbfItegerExiste) Then
      Begin
        qryAbf.ParamByName('CODABF').AsString := qryDet.FieldByName('CADITE_CODABF').AsString;
      End
      Else
      Begin
        qryAbf.ParamByName('CODABF').AsString := qryDet.FieldByName('ITEGER_CODABF').AsString;
      End;

      qryAbf.ParamByName('ESTORI').AsString := qryDet.FieldByName('CID_ESTADO').AsString;
      qryAbf.ParamByName('ESTDES').AsString := qryDet.FieldByName('DET_ESTADO').AsString;
      qryAbf.Open;

      qryAbf.Locate('ABF_ESTADO', qryDet.FieldByName('CID_ESTADO').AsString, []);
      fltBaseIcmsDiretaOriginal := fFormataFloat((qryDet.FieldByName('DET_TOTITE').AsFloat-qryDet.FieldByName('DET_DESESP').AsFloat) *
                                                  qryAbf.FieldByName('ABF_BASE_S').AsFloat / 100, 2);

      fltFatorBaseTotIte := 1;
      If (qryDet.FieldByName('DET_BASICM').AsFloat > (fltBaseIcmsDiretaOriginal)) And (fltBaseIcmsDiretaOriginal > 0) Then
      Begin
        fltFatorBaseTotIte := (qryDet.FieldByName('DET_BASICM').AsFloat / fltBaseIcmsDiretaOriginal);
      End;

      qryAbf.Locate('ABF_ESTADO', qryDet.FieldByName('DET_ESTADO').AsString, []);

      qryEditDet.Close;
      qryEditDet.ParamByName('AUTINC').AsString := qryDet.FieldByName('AUTOINCREM').AsString;
      qryEditDet.Open;

      qryEditDet.Edit;

      qryEditDet.FieldByName('DET_BASICM').AsFloat := (qryEditDet.FieldByName('DET_TOTITE').AsFloat-qryEditDet.FieldByName('DET_DESESP').AsFloat);

      If Pos(RightStr(strCstOriginal,2), '10,30,60,70') > 0 Then
      Begin
        qryEditDet.FieldByName('DET_BASICM').AsFloat := qryEditDet.FieldByName('DET_BASICM').AsFloat +
                                                        qryDet.FieldByName('DET_TOTFRE').AsFloat +
                                                        qryDet.FieldByName('DET_DESACE').AsFloat;
      End;

      qryEditDet.FieldByName('DET_BASICM').AsFloat := qryEditDet.FieldByName('DET_BASICM').AsFloat * qryAbf.FieldByName('ABF_BASE_S').AsFloat / 100;
      qryEditDet.FieldByName('DET_BASICM').AsFloat := fFormataFloat(qryEditDet.FieldByName('DET_BASICM').AsFloat * fltFatorBaseTotIte, 2);

      If Not blnSimPau Then
      Begin
        qryEditDet.FieldByName('DET_ALQICM').AsFloat := qryAbf.FieldByName('ABF_ALQ__S').AsFloat;
      End
      Else
      Begin
        qryEditDet.FieldByName('DET_ALQICM').AsFloat := StrToFloatDef(fCfgSisPainel('ICMSIM', Banco), 0);
      End;

      qryEditDet.FieldByName('DET_VALICM').AsFloat := fFormataFloat(qryEditDet.FieldByName('DET_BASICM').AsFloat *
                                                                    qryEditDet.FieldByName('DET_ALQICM').AsFloat / 100, 2);

      If blnSimPau And blnZerSim Then
      Begin
        qryEditDet.FieldByName('DET_ALQICM').AsFloat := 0;
        qryEditDet.FieldByName('DET_BASICM').AsFloat := 0;
        qryEditDet.FieldByName('DET_VALICM').AsFloat := 0;
      End;

      qryEditDet.FieldByName('DET_PERBAS').AsFloat := qryAbf.FieldByName('ABF_BASE_S').AsFloat;
      qryEditDet.FieldByName('DET_PERRED').AsFloat := 100 - qryAbf.FieldByName('ABF_BASE_S').AsFloat;

      If qryAbf.FindField('ABF_SITCON') <> Nil Then
      Begin
        qryEditDet.FieldByName('DET_CODFIS').AsString := qryAbf.FieldByName('ABF_SITCON').AsString;
      End
      Else
      Begin
        qryEditDet.FieldByName('DET_CODFIS').AsString := qryAbf.FieldByName('ABF_CODSIT').AsString;
      End;

      qryEditDet.Post;

      If (Assigned(qryEditTri)) Then
      Begin
        qryEditTri.Close;
        qryEditTri.ParamByName('SEQGER').AsString := qryDet.FieldByName('AUTOINCREM').AsString;
        qryEditTri.Open;

        fltOutros := qryDet.FieldByName('DET_VLRCON').AsFloat -
                     qryDet.FieldByName('DET_VALIPI').AsFloat -
                     qryEditDet.FieldByName('DET_BASICM').AsFloat -
                     qryDet.FieldByName('DET_DESACE').AsFloat -
                     qryDet.FieldByName('DET_TOTFRE').AsFloat;

        qryEditTri.Edit;
        If qryEditTri.FieldByName('DET_ISEICM').AsFloat > 0 Then
        Begin
          qryEditTri.FieldByName('DET_ISEICM').AsFloat := fltOutros;
        End
        Else
        Begin
          qryEditTri.FieldByName('DET_OUTICM').AsFloat := fltOutros;
        End;
        qryEditTri.Post;
      End;

      qryDet.Next;
    End;

    If blnAlterouItem Then
    Begin
      pAjustarCadFisMovGer(strTabela);
    End;
    Banco.Commit;
  Except
    On E: Exception Do
    Begin
      Banco.Rollback;
      Raise;
    End;
  End;

  FreeAndNil(qryEditDet);

  If Assigned(qryEditTri) Then
     FreeAndNil(qryEditTri);
     
  FreeAndNil(qryDet);
  FreeAndNil(qryAbf);
end;

function TVerificarStatus.fRetNumDocLog: String;
begin
  Result := Concat(FNumDoc, '-', FEspDoc, '-', FCodEmp, '-', FSerie, '-', FCodCli, '-', FTipFc);
end;

initialization
  {$IF Defined(UNIDAC)}
    EnableUniSQL := False;
    dxInitializeLibNfe;
  {$IFEND}
  {$IFNDEF LINUX}
  CoInitialize(Nil);
  {$ENDIF}
finalization
  {$IF Defined(UNIDAC)}
    dxFinalizeLibNfe;
  {$IFEND}
  {$IFNDEF LINUX}
  CoUninitialize;
  {$ENDIF}
end.
