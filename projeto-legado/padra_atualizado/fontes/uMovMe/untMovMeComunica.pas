unit untMovMeComunica;

interface

uses Data.Bind.ObjectScope, REST.Client, Vcl.StdCtrls, REST.Types, IPPeerClient,
  Classes, SysUtils, Forms, DateUtils, JSON, XMLDoc, XMLIntf, Variants,
  Uni, untMovMeTypes, untMovMeXML, StrUtils, untModulo,
  untImagemBase64, JPEG, Vcl.Imaging.pngimage, Graphics,
  untHisPed, untAtualizaOcorrenciasCRM, untFuncoesCRM,
  IdHTTP, Data.DB, IdTCPConnection, CRAccess,
  Dialogs;

type
  TMovMeComunica = Class(TComponent)
  private
    RESTReq: TRESTRequest;
    RESTCli: TRESTClient;
    RESTRes: TRESTResponse;
    strUrlApi: String;
    strTokAce: String;
    stlLog: TStringList;
    strIdCeNf: String;
    blnLogar: Boolean;
    blnLogApenErro: Boolean;
    dtaUltPos: TDateTime;
    intPosts: Integer;
    stlLogConsumo: TStringList;
    function fPost(strXMLData: String; strServico: String): Boolean;
    procedure pLog(strTexto: String);
    procedure pSaveLog;
    procedure pLogStatus;
    function fEncodeAsUTF8(UnicodeStr: string): string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure pConsumirDados;

    function fPostCliente(strXMLData: String): Boolean;
    function fChecarCliente(strCodCli: String): Boolean;

    function fPostNotasFiscais(strXMLData: String): Boolean;
    // function fPostItensNotasFiscais(strXMLData: String): Boolean;
    // function fPostItemNotasFiscais(strXMLData: String): Boolean;
    // function fAtualizaItemNotasFiscais(strXMLData: String; strId: String): Boolean;
    function fPostItens(strXMLData: String): Boolean;
    function fInsereGrupos(strXMLData: String): Boolean;
    function fAtualizaGrupos(strXMLData: String; strId: String): Boolean;
    function fInsereSubGrupos(strXMLData: String): Boolean;
    function fAtualizaSubGrupos(strXMLData: String; strId: String): Boolean;

    function fGetMotoristas: Boolean;
    procedure pChecarCADMOT(strLink: String);
    function fRetMotoristaCADMOT(strCPF: String): String;
    procedure pCadastrarMotorista(strXML, strCPF: String);
    function fProCodCadMot: String;

    function fPostSchedules(strXMLData: String): Boolean;
    function fPostScheduleItems(strXMLData: String): Boolean;
    function fPostScheduleRoutings(arrScheduleRoutings
      : TArrScheduleRoutings): Boolean;

    function fGetScheduleIds(strAltId: String): String;

    // Função para procurar uma tag no XML informado
    function fGetXML(strLink: String): String;
    function fBuscarXML(strXML, strTag: String): String;

    // Funções utilizadas no retorno da tarefa
    procedure pChecarStatusSchedules;
    procedure pAtualizarStatusTarefa(strNumRomaneio, strAutoIncrem,
      strEntGer: String);
    function fGetActivityHistoryHierarchical(strLink: String)
      : TrecRetornoTarefa;

    function fRemoverRomaneioTotal(strNumRom, strObs: String;
      recRetornoTarefa: TrecRetornoTarefa): Boolean;
    function fRomaneioRealizado(strNumRom, strNomRec: String;
      recRetornoTarefa: TrecRetornoTarefa): Boolean;

    procedure pInserirFotoFachada(strSeqEnt, strImg64: String);
    procedure pInserirFotoCanhoto(strSeqRom, strImg64: String);

    function fConfirmaBaixa(qryDocumento: TUniQuery;
      recRetornoTarefa: TrecRetornoTarefa): Boolean;
    function fGerarNovoPreRomaneio(Var strRomNov: String;
      strNumRom, strEmpRom, strNumDoc, strEspDoc, strCodEmp: String): Boolean;
    function fMarcarFlag(strNumDoc,
                     strEspDoc,
                     strCodEmp,
                     strCodCli,
                     strNumRom: String;
                     strBaiFlg: String): Boolean;
  End;

implementation

{ TMovMeComunica }

uses untFuncoesSimples, untRomGer, untTypesCRM, untMensagemExplicativa;

constructor TMovMeComunica.Create(AOwner: TComponent);
begin
  try
    inherited Create(AOwner);

    blnLogar := FileExists('uMovMe.debug');
    blnLogApenErro := FileExists('uMovMe.debugerr');

    // strUrlApi := 'https://api.umov.me/CenterWeb/api/';
    // strTokAce := '17898e4c7beb8b3f61c75154af26fc2a7d8bdf'; //'17898ee6ca8e4f6867befb6cb7e1d9596fdd75';
    // strIdCeNf := '100728'; // ID Custom Entity (Notas Fiscais)
    // strIdCeNfIt := '104311'; // ID Custom Entity (Itens da Nota Fiscal)
    // https://api.umov.me/CenterWeb/api/17898e25fe0a17b215f5744d166f2d7932ac03/customEntity/100728/customEntityEntry.xml  (Listar as NFs)
    // https://api.umov.me/CenterWeb/api/17898e25fe0a17b215f5744d166f2d7932ac03/customEntity/104311/customEntityEntry.xml  (Listar os Itens das NFs)

    strUrlApi := fCfgSis('URLMOV', varString);
    strTokAce := fCfgSis('TOKMOV', varString);
    strIdCeNf := fCfgSis('IDNFMV', varString);

    RESTCli := TRESTClient.Create(strUrlApi);
    RESTReq := TRESTRequest.Create(Self);
    RESTRes := TRESTResponse.Create(Self);

    stlLog := TStringList.Create;

    RESTReq.Client := RESTCli;
    RESTReq.Response := RESTRes;

    dtaUltPos := 0;
    intPosts := 0;
  except
    On E :Exception Do
    Begin
      pLog('Exception: ' + E.Message);
      pLogStatus;
    End;
  end;
end;

destructor TMovMeComunica.Destroy;
begin
  FreeAndNil(RESTCli);
  FreeAndNil(RESTReq);
  FreeAndNil(RESTRes);
  FreeAndNil(stlLog);

//  __VS_CONEXAO_UMOVME := Nil;
//  FreeAndNil(ConexaoUMovMe);

  inherited Destroy;
end;

function TMovMeComunica.fEncodeAsUTF8(UnicodeStr: String): String;
Var
  UTF8Str: UTF8String;
  intCnt: Integer;
begin
  UTF8Str := UTF8String(UnicodeStr);
  SetLength(Result, Length(UTF8Str));
  For intCnt := 1 To Length(UTF8Str) Do
    Result[intCnt] := Char(Ord(UTF8Str[intCnt]));
end;

procedure TMovMeComunica.pConsumirDados;
var
  strDir :String;
begin

  stlLogConsumo := TStringList.Create;

  try
    blnLogar := FileExists('uMovMe.debug');
    blnLogApenErro := FileExists('uMovMe.debugerr');

    strDir := ExtractFilePath(Application.ExeName) + 'uMovMeLogs\';

    If Not DirectoryExists(strDir) Then
      ForceDirectories(strDir);

    stlLogConsumo := TStringList.Create;
    strTokAce := fCfgSis('TOKMOV', varString);

    if blnLogar then
    begin
      stlLogConsumo.Add(Format('=== %s: Início do consumo automático de dados ===',
          [FormatDateTime('dd/mm/yyyy hh:nn:ss.zzz', fNow)]
        ));

      stlLogConsumo.Add('Token: ' +strTokAce);
      stlLogConsumo.Add('Empresa: ' +VS_strCodEmp);

      if fEmptyStr(strTokAce) then
      begin
        stlLogConsumo.Add(Format('== %s: Processo abortado por Token vazio ==',
          [FormatDateTime('dd/mm/yyyy hh:nn:ss.zzz', fNow)]
        ));

        stlLogConsumo.SaveToFile(strDir + FormatDateTime('AUTO_yyyymmdd_hhnnsszzz', fNow)
            + '.txt');

        Exit;
      end;
    end;

    if fEmptyStr(strTokAce) then
      Exit;

    IF blnLogar then
      stlLogConsumo.Add('== Iniciado envio de Motoristas ==');

    fGetMotoristas;

    if blnLogar then
      stlLogConsumo.Add('== Iniciada verificação dos Schedules ==');

    pChecarStatusSchedules;

    if blnLogar then
    begin
      stlLogConsumo.Add(Format('== %s: Processo finalizado com sucesso ==',
        [FormatDateTime('dd/mm/yyyy hh:nn:ss.zzz', fNow)]));

      stlLogConsumo.SaveToFile(strDir +'AUTO_' + FormatDateTime('yyyymmdd_hhnnsszzz', fNow)
        + '.txt');
    end;
  except
    on E: Exception do
    begin
      if blnLogar then
      begin
        stlLogConsumo.Add(Format('== %s Processo encerrado por exceção: %s ==',
          [FormatDateTime('dd/mm/yyyy hh:nn:ss.zzz', fNow), E.Message]
        ));

        stlLogConsumo.SaveToFile(strDir +'AUTO_' +FormatDateTime('yyyymmdd_hhnnsszzz', fNow)
          + '.txt');
      end;
    end;
  end;
end;

procedure TMovMeComunica.pInserirFotoFachada(strSeqEnt, strImg64: String);
var
  qryInsereFACIMG: TUniQuery;
begin
  try
    try
      qryInsereFACIMG := fCriaQuery;

      qryInsereFACIMG.Close;
      qryInsereFACIMG.SQL.Clear;
      qryInsereFACIMG.SQL.Append(' SELECT * FROM FACIMG ');
      qryInsereFACIMG.SQL.Append(' WHERE IMG_SEQENT = :SEQENT ');
      qryInsereFACIMG.ParamByName('SEQENT').AsString := strSeqEnt;
      qryInsereFACIMG.Open;

      qryInsereFACIMG.Edit;
      qryInsereFACIMG.FieldByName('IMG_SEQENT').AsString := strSeqEnt;
      qryInsereFACIMG.FieldByName('IMG_IMGB64').AsString := strImg64;
      qryInsereFACIMG.Post;
    except
      on E: Exception do
      begin
        pLog('Exception: ' + E.Message);
        pLogStatus;
      end;
    end;
  finally
    FreeAndNil(qryInsereFACIMG);
  end;
end;

procedure TMovMeComunica.pInserirFotoCanhoto(strSeqRom, strImg64: String);
var
  qryInsereFACIMG: TUniQuery;
begin
  try
    try
      qryInsereFACIMG := fCriaQuery;

      qryInsereFACIMG.Close;
      qryInsereFACIMG.SQL.Clear;
      qryInsereFACIMG.SQL.Append(' SELECT * FROM RECIMG ');
      qryInsereFACIMG.SQL.Append(' WHERE IMG_SEQROM = :SEQROM ');
      qryInsereFACIMG.ParamByName('SEQROM').AsString := strSeqRom;
      qryInsereFACIMG.Open;

      qryInsereFACIMG.Edit;
      qryInsereFACIMG.FieldByName('IMG_SEQROM').AsString := strSeqRom;
      qryInsereFACIMG.FieldByName('IMG_IMGB64').AsString := strImg64;
      qryInsereFACIMG.Post;
    except
      on E: Exception do
      begin
        pLog('Exception: ' + E.Message);
        pLogStatus;
      end;
    end;
  finally
    FreeAndNil(qryInsereFACIMG);
  end;
end;

function TMovMeComunica.fRemoverRomaneioTotal(strNumRom, strObs: String;
  recRetornoTarefa: TrecRetornoTarefa): Boolean;
Var
  strSQL: String;
  qryDocumentos: TUniQuery;
begin
  qryDocumentos := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GER_ROMIMP, ';
  strSQL := strSQL + '  GER_DTAENT, ';
  strSQL := strSQL + '  GER_HORENT, ';
  strSQL := strSQL + '  CONCAT(GER_NUMDOC, "-", GER_ESPDOC) GER_NUMDOC, ';
  strSQL := strSQL + '  GER_NUMDOC GER_DOCORI, ';
  strSQL := strSQL + '  GER_ESPDOC GER_ESPORI, ';
  strSQL := strSQL + '  GER_CODCLI GER_CLIORI, ';
  strSQL := strSQL + '  GER_CODEMP, ';
  strSQL := strSQL +
    '  IF(GER_NOMCON = "" OR GER_NOMCON IS NULL, CLI_NOMCLI, GER_NOMCON) GER_NOMCLI, ';
  strSQL := strSQL + '  CID_NOMCID, ';
  strSQL := strSQL + '  GER_CODVEN, ';
  strSQL := strSQL + '  TRA_NOMTRA, ';
  strSQL := strSQL + '  FORMAT(GER_VLRCON, 2) GER_VLRCON, ';
  strSQL := strSQL + '  CONCAT(GER_CODMOT, "-", MOT_NOMMOT) MOT_NOMMOT, ';
  strSQL := strSQL + '  GER_CODMOT, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ1, "-", A1.AJU_NOMAJU) AJU_NOMAJ1, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ2, "-", A2.AJU_NOMAJU) AJU_NOMAJ2, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ3, "-", A3.AJU_NOMAJU) AJU_NOMAJ3, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ4, "-", A4.AJU_NOMAJU) AJU_NOMAJ4, ';
  strSQL := strSQL + '  GER_NUMROM, ';
  strSQL := strSQL + '  GER_EMPROM, ';
  strSQL := strSQL + '  GER_NOMREC, ';
  strSQL := strSQL + '  GER_DTABAI, ';
  strSQL := strSQL + '  GER_HORBAI, ';
  strSQL := strSQL + '  GER_DTAROM, ';
  strSQL := strSQL + '  DATE_FORMAT(GER_HORROM, "%H:%i") AS GER_HORROM, ';
  strSQL := strSQL + '  "D" GER_MARDES, ';
  strSQL := strSQL + '  ROMGERX.AUTOINCREM, ';
  strSQL := strSQL + '  "' + strObs + '" GER_OBSERV, ';
  strSQL := strSQL + '  GER_NOMTAB, ';
  strSQL := strSQL + '  GER_DTAENT AS GER_DTADOC, ';
  strSQL := strSQL + '  GER_VOLUME ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ROMGERX ';
  strSQL := strSQL + '  LEFT JOIN CADTRA    ON TRA_CODTRA = GER_CODTRA ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A1 ON GER_CODAJ1 = A1.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A2 ON GER_CODAJ2 = A2.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A3 ON GER_CODAJ3 = A3.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A4 ON GER_CODAJ4 = A4.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADMOT    ON GER_CODMOT = MOT_CODMOT ';
  strSQL := strSQL + '  LEFT JOIN CADCLI    ON GER_CODCLI = CLI_CODCLI ';
  strSQL := strSQL +
    '  LEFT JOIN CADCID ON IF( GER_CIDCON IS NULL, CLI_CODCID, GER_CIDCON) = CID_CODCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GER_NUMFAT = :NUMFAT AND ';
  strSQL := strSQL + '  GER_TIPFAT = :TIPFAT AND ';
  strSQL := strSQL + '  GER_EMPROM = :EMPROM AND ';

  strSQL := strSQL + '  GER_DTABAI IS NULL       ';

  qryDocumentos.Close;
  qryDocumentos.SQL.Clear;
  qryDocumentos.SQL.Add(strSQL);
  qryDocumentos.ParamByName('NUMFAT').AsString :=
    SplitString(strNumRom, '-')[0];
  qryDocumentos.ParamByName('TIPFAT').AsString :=
    SplitString(strNumRom, '-')[1];
  qryDocumentos.ParamByName('EMPROM').AsString :=
    SplitString(strNumRom, '-')[2];

  qryDocumentos.Open;

  IF qryDocumentos.RecordCount > 0 Then
  Begin
    qryDocumentos.Edit;
    qryDocumentos.FieldByName('GER_NOMREC').Clear;
    qryDocumentos.FieldByName('GER_DTABAI').Clear;
    qryDocumentos.FieldByName('GER_HORBAI').Clear;
    qryDocumentos.Post;

    fConfirmaBaixa(qryDocumentos, recRetornoTarefa);
  End;

  qryDocumentos.Close;
  If Assigned(qryDocumentos) Then
    FreeAndNil(qryDocumentos);

  Result := True;
end;

function TMovMeComunica.fRetMotoristaCADMOT(strCPF: String): String;
Var
  strSQL: String;
  qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT                 ';
    strSQL := strSQL + '  MOT_CODMOT           ';
    strSQL := strSQL + 'FROM                   ';
    strSQL := strSQL + '  CADMOT               ';
    strSQL := strSQL + 'WHERE                  ';
    strSQL := strSQL + '  MOT_CPFMOT = :MOTCPF ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('MOTCPF').AsString := strCPF;
      Open;

      Result := FieldByName('MOT_CODMOT').AsString;

      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
end;

function TMovMeComunica.fRomaneioRealizado(strNumRom, strNomRec: String;
  recRetornoTarefa: TrecRetornoTarefa): Boolean;
Var
  strSQL: String;
  qryDocumentos: TUniQuery;
begin
  qryDocumentos := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GER_ROMIMP, ';
  strSQL := strSQL + '  GER_DTAENT, ';
  strSQL := strSQL + '  GER_HORENT, ';
  strSQL := strSQL + '  CONCAT(GER_NUMDOC, "-", GER_ESPDOC) GER_NUMDOC, ';
  strSQL := strSQL + '  GER_NUMDOC GER_DOCORI, ';
  strSQL := strSQL + '  GER_ESPDOC GER_ESPORI, ';
  strSQL := strSQL + '  GER_CODCLI GER_CLIORI, ';
  strSQL := strSQL + '  GER_CODEMP, ';
  strSQL := strSQL +
    '  IF(GER_NOMCON = "" OR GER_NOMCON IS NULL, CLI_NOMCLI, GER_NOMCON) GER_NOMCLI, ';
  strSQL := strSQL + '  CID_NOMCID, ';
  strSQL := strSQL + '  GER_CODVEN, ';
  strSQL := strSQL + '  TRA_NOMTRA, ';
  strSQL := strSQL + '  FORMAT(GER_VLRCON, 2) GER_VLRCON, ';
  strSQL := strSQL + '  CONCAT(GER_CODMOT, "-", MOT_NOMMOT) MOT_NOMMOT, ';
  strSQL := strSQL + '  GER_CODMOT, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ1, "-", A1.AJU_NOMAJU) AJU_NOMAJ1, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ2, "-", A2.AJU_NOMAJU) AJU_NOMAJ2, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ3, "-", A3.AJU_NOMAJU) AJU_NOMAJ3, ';
  strSQL := strSQL + '  CONCAT(GER_CODAJ4, "-", A4.AJU_NOMAJU) AJU_NOMAJ4, ';
  strSQL := strSQL + '  GER_NUMROM, ';
  strSQL := strSQL + '  GER_EMPROM, ';
  strSQL := strSQL + '  GER_NOMREC, ';
  strSQL := strSQL + '  GER_DTABAI, ';
  strSQL := strSQL + '  GER_HORBAI, ';
  strSQL := strSQL + '  GER_DTAROM, ';
  strSQL := strSQL + '  DATE_FORMAT(GER_HORROM, "%H:%i") AS GER_HORROM, ';
  strSQL := strSQL + '  "M" GER_MARDES, ';
  strSQL := strSQL + '  ROMGERX.AUTOINCREM, ';
  strSQL := strSQL + '  "" GER_OBSERV, ';
  strSQL := strSQL + '  GER_NOMTAB ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ROMGERX ';
  strSQL := strSQL + '  LEFT JOIN CADTRA    ON TRA_CODTRA = GER_CODTRA ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A1 ON GER_CODAJ1 = A1.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A2 ON GER_CODAJ2 = A2.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A3 ON GER_CODAJ3 = A3.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADAJU A4 ON GER_CODAJ4 = A4.AJU_CODAJU ';
  strSQL := strSQL + '  LEFT JOIN CADMOT    ON GER_CODMOT = MOT_CODMOT ';
  strSQL := strSQL + '  LEFT JOIN CADCLI    ON GER_CODCLI = CLI_CODCLI ';
  strSQL := strSQL +
    '  LEFT JOIN CADCID ON IF( GER_CIDCON IS NULL, CLI_CODCID, GER_CIDCON) = CID_CODCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GER_NUMFAT = :NUMFAT AND ';
  strSQL := strSQL + '  GER_TIPFAT = :TIPFAT AND ';
  strSQL := strSQL + '  GER_EMPROM = :EMPROM AND ';

  strSQL := strSQL + '  GER_DTABAI IS NULL       ';

  qryDocumentos.Close;
  qryDocumentos.SQL.Clear;
  qryDocumentos.SQL.Add(strSQL);
  qryDocumentos.ParamByName('NUMFAT').AsString :=
    SplitString(strNumRom, '-')[0];
  qryDocumentos.ParamByName('TIPFAT').AsString :=
    SplitString(strNumRom, '-')[1];
  qryDocumentos.ParamByName('EMPROM').AsString :=
    SplitString(strNumRom, '-')[2];

  qryDocumentos.Open;

  IF qryDocumentos.RecordCount > 0 Then
  Begin
    qryDocumentos.Edit;
    qryDocumentos.FieldByName('GER_DTABAI').AsDateTime := recRetornoTarefa.dtDataEntrega;
    qryDocumentos.FieldByName('GER_HORBAI').AsDateTime := recRetornoTarefa.dtHoraEntrega;
    qryDocumentos.FieldByName('GER_NOMREC').Text := strNomRec;
    qryDocumentos.Post;

    fConfirmaBaixa(qryDocumentos, recRetornoTarefa);
  End;

  qryDocumentos.Close;
  If Assigned(qryDocumentos) Then
    FreeAndNil(qryDocumentos);

  Result := True;
End;

function TMovMeComunica.fGetMotoristas: Boolean;
var
  Doc: IXMLDocument;
  Motoristas, Motorista: IXMLNode;
  MotoristaLst: IXMLNodeList;
  strLink: String;
  i: Integer;
begin
  Try
    Doc := LoadXMLDocument(strUrlApi + strTokAce + '/agent.xml');
    Doc.Active := True;
    Motoristas := Doc.DocumentElement;
    Motoristas := Motoristas.ChildNodes.FindNode('entries');

    for i := 0 to Motoristas.ChildNodes.Count - 1 do
    begin
      Sleep(1000);
      Application.ProcessMessages;

      Motorista := Motoristas.ChildNodes[i];
      MotoristaLst := Motorista.AttributeNodes;

      strLink := MotoristaLst.FindNode('link').Text;

      if blnLogar then
        stlLogConsumo.Add(strLink);

      pChecarCADMOT(strLink);
    end;

    Result := True;
  except
    Result := False;
  end;
end;

function TMovMeComunica.fGetScheduleIds(strAltId: String): String;
var
  Doc: IXMLDocument;
  Schedules, Schedule: IXMLNode;
  ScheduleLst: IXMLNodeList;
  i: Integer;
  strScheduleId: String;
begin
  Doc := LoadXMLDocument(strUrlApi + strTokAce +
    '/schedule.xml?alternativeIdentifier=' + strAltId);
  Doc.Active := True;
  Schedules := Doc.DocumentElement;
  Schedules := Schedules.ChildNodes.FindNode('entries');

  for i := 0 to Schedules.ChildNodes.Count - 1 do
  begin
    Schedule := Schedules.ChildNodes[i];
    ScheduleLst := Schedule.AttributeNodes;

    strScheduleId := ScheduleLst.FindNode('id').Text;
  end;

  Result := strScheduleId;
End;

procedure TMovMeComunica.pChecarCADMOT(strLink: String);
var
  strCPF, strXML: WideString;
begin
  strXML := fGetXML(strLink);

  If strXML <> '' Then
  Begin
    strCPF := fReplaceStr(fRemoveAcentoPontos(fBuscarXML(strXML, 'PSA__CPF')
      ), '-', '');

    pCadastrarMotorista(strXML, strCPF);
  End;
end;

procedure TMovMeComunica.pChecarStatusSchedules;
var
  qryRomaneios: TUniQuery;
begin
  {
    Seleciona todos os Romaneios cujo status seja "A"

    Status:
    A - Andamento
    L - Aguardando Liberação
    B - Baixada
  }

  qryRomaneios := fCriaQuery;

  with qryRomaneios do
  begin
    Close;
    SQL.Clear;
    SQL.Append(' SELECT                                         ');
    SQL.Append
      (' CONCAT(IFNULL(GER_NUMFAT, ""), "-", IFNULL(GER_TIPFAT, ""), "-", IFNULL(GER_EMPFAT, GER_EMPROM)) AS DOCROM, ');
    SQL.Append('   IF(                                          ');
    SQL.Append('     GER_DTABAI IS NULL,                        ');
    SQL.Append('     IF(                                        ');
    SQL.Append('       GER_LIBENT = "S",                        ');
    SQL.Append('       "A",                                     ');
    SQL.Append('       "L"                                      ');
    SQL.Append('     ),                                         ');
    SQL.Append('     "B"                                        ');
    SQL.Append('   ) AS STAENT,                                 ');
    SQL.Append('   AUTOINCREM,                                  ');
    SQL.Append('   GER_ENTGER FROM ROMGERX                      ');
    SQL.Append(' HAVING STAENT = "A"                            ');
    Open;

    while not Eof do
    begin
      if blnLogar then
        stlLogConsumo.Add('Checando documento: '
          +FieldByName('DOCROM').AsString +FieldByName('AUTOINCREM').AsString
            +FieldByName('GER_ENTGER').AsString);

      pAtualizarStatusTarefa(FieldByName('DOCROM').AsString,
        FieldByName('AUTOINCREM').AsString, FieldByName('GER_ENTGER').AsString);

      Next;
    end;
  end;

  qryRomaneios.Close;
  If Assigned(qryRomaneios) Then
   FreeAndNil(qryRomaneios);
end;

procedure TMovMeComunica.pAtualizarStatusTarefa(strNumRomaneio, strAutoIncrem,
  strEntGer: String);
var
  Doc: IXMLDocument;
  Schedules, Schedule: IXMLNode;
  ScheduleLst: IXMLNodeList;
  strLink: String;
  i: Integer;
  recRetornoTarefaTmp, recRetornoTarefa: TrecRetornoTarefa;
begin
  try
    // strUrlApi + strTokAce
    // activityHistory.xml?schedule.alternativeIdentifier=

    Doc := LoadXMLDocument(strUrlApi + strTokAce +
      '/activityHistory.xml?schedule.alternativeIdentifier=' + strNumRomaneio);
    Doc.Active := True;
    Schedules := Doc.DocumentElement;
    Schedules := Schedules.ChildNodes.FindNode('entries');

    if blnLogar then
      stlLogConsumo.Add(strUrlApi + strTokAce
        +'/activityHistory.xml?schedule.alternativeIdentifier=' + strNumRomaneio);

    for i := 0 to Schedules.ChildNodes.Count - 1 do
    begin
      Schedule := Schedules.ChildNodes[i];
      ScheduleLst := Schedule.AttributeNodes;

      strLink := ScheduleLst.FindNode('link').Text;

      if blnLogar then
        stlLogConsumo.Add('>' +strLink);

      recRetornoTarefaTmp := fGetActivityHistoryHierarchical(strLink);

      If (recRetornoTarefa.strImgFachada <> '') And
        (recRetornoTarefaTmp.strImgFachada = '') Then
        recRetornoTarefaTmp.strImgFachada := recRetornoTarefa.strImgFachada;

      If (recRetornoTarefa.strImgFotoCanhoto <> '') And
        (recRetornoTarefaTmp.strImgFotoCanhoto = '') Then
        recRetornoTarefaTmp.strImgFotoCanhoto :=
          recRetornoTarefa.strImgFotoCanhoto;

      If (recRetornoTarefa.strNomeRecebedor <> '') Then
        recRetornoTarefaTmp.strNomeRecebedor := recRetornoTarefa.strNomeRecebedor;

      If (recRetornoTarefa.dtDataEntrega <> 0) Then
        recRetornoTarefaTmp.dtDataEntrega := recRetornoTarefa.dtDataEntrega;

      If (recRetornoTarefa.dtHoraEntrega <> 0) Then
        recRetornoTarefaTmp.dtHoraEntrega := recRetornoTarefa.dtHoraEntrega;

      If (length(recRetornoTarefa.strItensDevolvidos) > 0) Then
        recRetornoTarefaTmp.strItensDevolvidos := recRetornoTarefa.strItensDevolvidos;

      If (recRetornoTarefa.strSituacao = '50') Then
        recRetornoTarefaTmp.strSituacao := recRetornoTarefa.strSituacao;

      If ((recRetornoTarefa.strStatusTarefa = '443124') Or
         (recRetornoTarefa.strStatusTarefa = '443126')) Then
        recRetornoTarefaTmp.strStatusTarefa := recRetornoTarefa.strStatusTarefa;

      recRetornoTarefa := recRetornoTarefaTmp;

//      If (recRetornoTarefa.strSituacao = '50') And
//        ((recRetornoTarefa.strStatusTarefa = '443124') Or
//        (recRetornoTarefa.strStatusTarefa = '443126')) Then
//        Break;
    End;

    If recRetornoTarefa.strSituacao = '50' Then
    Begin
      If recRetornoTarefa.strStatusTarefa = '443124' Then
      Begin
        recRetornoTarefa.strStatusTarefa := 'Entrega Não Realizada';
        fRemoverRomaneioTotal(strNumRomaneio,
          recRetornoTarefa.strMotivoNaoEntrega, recRetornoTarefa);
      End

      // Entrega Realizada pode ser completa ou parcial
      Else If recRetornoTarefa.strStatusTarefa = '443126' Then
      Begin
        If (length(recRetornoTarefa.strItensDevolvidos) > 0) Then
          recRetornoTarefa.strStatusTarefa := 'Entrega Parcial'
        else
          recRetornoTarefa.strStatusTarefa := 'Entrega Realizada';

        fRomaneioRealizado(strNumRomaneio, recRetornoTarefa.strNomeRecebedor,
          recRetornoTarefa);
      End

      Else
        recRetornoTarefa.strStatusTarefa := '[API] Retorno ' +
          recRetornoTarefa.strStatusTarefa;

      if blnLogar then
        stlLogConsumo.Add('>> ' +recRetornoTarefa.strStatusTarefa);

      If (recRetornoTarefa.strImgFachada <> '') Then
        pInserirFotoFachada(strEntGer, recRetornoTarefa.strImgFachada);

      If (recRetornoTarefa.strImgFotoCanhoto <> '') Then
        pInserirFotoCanhoto(strAutoIncrem, recRetornoTarefa.strImgFotoCanhoto);
    End;
  except
  end;
End;

function TMovMeComunica.fGetActivityHistoryHierarchical(strLink: String)
  : TrecRetornoTarefa;
var
  Doc: IXMLDocument;
  Node, SubNode, SubNode2, SubNode3: IXMLNode;
  NodeAttributes: IXMLNodeList;
  strProdTmp, strQtdDevTmp: String;
  i, j, k: Integer;
  recRetornoTarefa: TrecRetornoTarefa;
  objJPEG: TJPEGImage;
  FS: TFormatSettings;
begin
  // strUrlApi + strTokAce
  // activityHistoryHierarchical.xml?schedule.alternativeIdentifier=

  if blnLogar then
    stlLogConsumo.Add('>>>'
      +strUrlApi + strTokAce
        +AnsiReplaceStr(strLink, 'activityHistory',
          'activityHistoryHierarchical'));

  Doc := LoadXMLDocument(strUrlApi + strTokAce + AnsiReplaceStr(strLink,
    'activityHistory', 'activityHistoryHierarchical'));
  Doc.Active := True;
  Node := Doc.DocumentElement;
  Node := Node.ChildNodes.FindNode('schedule');
  Node := Node.ChildNodes.FindNode('situation');

  NodeAttributes := Node.AttributeNodes;
  recRetornoTarefa.strSituacao := Node.ChildNodes.FindNode('id').NodeValue;

  If (recRetornoTarefa.strSituacao = '50') Or (recRetornoTarefa.strSituacao = '40') Then
  Begin
    if blnLogar then
      stlLogConsumo.Add('>>>' +strUrlApi + strTokAce
        + AnsiReplaceStr(strLink, 'activityHistory',
          'activityHistoryHierarchical'));

    Doc := LoadXMLDocument(strUrlApi + strTokAce + AnsiReplaceStr(strLink,
      'activityHistory', 'activityHistoryHierarchical'));
    Doc.Active := True;
    Node := Doc.DocumentElement;
    Node := Node.ChildNodes.FindNode('activity');

    recRetornoTarefa.strStatusTarefa := Node.ChildNodes.FindNode('id')
      .NodeValue;

    Node := Doc.DocumentElement;
    recRetornoTarefa.blnRealizada :=
      (Node.ChildNodes.FindNode('finishTimeOnSystem').NodeValue <> '');

    Node := Doc.DocumentElement;
    Node := Node.ChildNodes.FindNode('schedule');
    Node := Node.ChildNodes.FindNode('serviceLocal');

    If Node.ChildNodes.FindNode('geoCoordinate').NodeValue <> Null Then
      recRetornoTarefa.strGeoLoc := Node.ChildNodes.FindNode('geoCoordinate')
        .NodeValue;

    Node := Doc.DocumentElement;
    Node := Node.ChildNodes.FindNode('sections');
//    Transferido para dentro do loop, várias tags <section>
//    Node := Node.ChildNodes.FindNode('section');
//    Node := Node.ChildNodes.FindNode('items');
//    Node := Node.ChildNodes.FindNode('item');
//    Node := Node.ChildNodes.FindNode('fields');

    // Acessa o subnode sections > section(todos) > items > item > fields
    for i := 0 to Node.ChildNodes.Count - 1 do
    begin
      SubNode := Node.ChildNodes[i];

// Vira ChildNodes[i]
//      SubNode := SubNode.ChildNodes.FindNode('section');
      SubNode := SubNode.ChildNodes.FindNode('items');
      SubNode := SubNode.ChildNodes.FindNode('item');
      SubNode := SubNode.ChildNodes.FindNode('fields');

      for j := 0 to SubNode.ChildNodes.Count - 1 do
      begin
        SubNode2 := SubNode.ChildNodes[j];

        If SubNode2.ChildNodes.FindNode('id').NodeValue = '2712439' Then
        Begin
          SubNode2 := SubNode2.ChildNodes.FindNode('fieldHistory');
          recRetornoTarefa.strNomeRecebedor := SubNode2.ChildNodes.FindNode
            ('value').NodeValue;

          Continue;
        End;

        If (Pos('FOTO', AnsiUpperCase(SubNode2.ChildNodes.FindNode('description').NodeValue)) > 0) And
           (Pos('ENTREGA', AnsiUpperCase(SubNode2.ChildNodes.FindNode('description').NodeValue)) > 0)
        Then
        Begin
          SubNode2 := SubNode2.ChildNodes.FindNode('fieldHistory');
          recRetornoTarefa.strImgFachada := SubNode2.ChildNodes.FindNode('value')
            .NodeValue;

          try
            objJPEG := fGetImageByUrl(recRetornoTarefa.strImgFachada);
            recRetornoTarefa.strImgFachada := fBase64FromIMG(objJPEG);
          except
            recRetornoTarefa.strImgFachada := '';
          end;

          Continue;
        End;

        If (Pos('ASSINA', AnsiUpperCase(SubNode2.ChildNodes.FindNode('description').NodeValue)) > 0)
        Then
        Begin
          SubNode2 := SubNode2.ChildNodes.FindNode('fieldHistory');
          recRetornoTarefa.strImgFotoCanhoto := SubNode2.ChildNodes.FindNode
            ('value').NodeValue;

          try
            objJPEG := fGetImageByUrl(recRetornoTarefa.strImgFotoCanhoto);
            recRetornoTarefa.strImgFotoCanhoto := fBase64FromIMG(objJPEG);
          except
            recRetornoTarefa.strImgFotoCanhoto := '';
          end;

          Continue;
        End;

        If SubNode2.ChildNodes.FindNode('id').NodeValue = '2401087' Then
        Begin
          SubNode2 := SubNode2.ChildNodes.FindNode('fieldHistory');
          recRetornoTarefa.strMotivoNaoEntrega :=
            SubNode2.ChildNodes.FindNode('value').NodeValue;

          Continue;
        End;

        If (Pos('DATA', AnsiUpperCase(SubNode2.ChildNodes.FindNode('description').NodeValue)) > 0) And
           (Pos('CHEGADA', AnsiUpperCase(SubNode2.ChildNodes.FindNode('description').NodeValue)) > 0)
        Then
        Begin
          SubNode2 := SubNode2.ChildNodes.FindNode('fieldHistory');

          FS:= TFormatSettings.Create;
          FS.DateSeparator:= '-';
          FS.ShortDateFormat:= 'yyyy-mm-dd';
          recRetornoTarefa.dtDataEntrega := StrToDate(SubNode2.ChildNodes.FindNode('value').NodeValue, FS);

          //SubNode2 := SubNode2.ChildNodes.FindNode('fieldHistory');
          //recRetornoTarefa.dtDataEntrega := StrToDateDef(SubNode2.ChildNodes.FindNode('value').NodeValue, 0);

          Continue;
        End;

        If (Pos('HORA', AnsiUpperCase(SubNode2.ChildNodes.FindNode('description').NodeValue)) > 0) And
           (Pos('CHEGADA', AnsiUpperCase(SubNode2.ChildNodes.FindNode('description').NodeValue)) > 0)
        Then
        Begin
          SubNode2 := SubNode2.ChildNodes.FindNode('fieldHistory');
          recRetornoTarefa.dtHoraEntrega := StrToDateTimeDef(SubNode2.ChildNodes.FindNode('value').NodeValue, 0);

          Continue;
        End;
      end;
    End;

    Node := Doc.DocumentElement;
    Node := Node.ChildNodes.FindNode('sections');

    for i := 0 to Node.ChildNodes.Count - 1 do
    begin
      SubNode := Node.ChildNodes[i];

      If SubNode.ChildNodes.FindNode('id').NodeValue = '564583' Then
      Begin
        SubNode := SubNode.ChildNodes.FindNode('items');

        for j := 0 to SubNode.ChildNodes.Count - 1 do
        begin
          SubNode2 := SubNode.ChildNodes[j];

          strProdTmp := SubNode2.ChildNodes.FindNode('alternativeIdentifier')
            .NodeValue;
          strQtdDevTmp := '0';

          SubNode2 := SubNode2.ChildNodes.FindNode('fields');

          for k := 0 to SubNode2.ChildNodes.Count - 1 do
          begin
            SubNode3 := SubNode2.ChildNodes[k];

            If SubNode3.ChildNodes.FindNode('id').NodeValue = '2760121' Then
            Begin
              SubNode3 := SubNode3.ChildNodes.FindNode('fieldHistory');
              strQtdDevTmp := SubNode3.ChildNodes.FindNode('value').NodeValue;
            End;
          end;

          If fStrToFloat(strQtdDevTmp) > 0 Then
          Begin
            SetLength(recRetornoTarefa.strItensDevolvidos,
              Length(recRetornoTarefa.strItensDevolvidos) + 1);
            recRetornoTarefa.strItensDevolvidos
              [Length(recRetornoTarefa.strItensDevolvidos) - 1] := strProdTmp +
              '-' + strQtdDevTmp;
          End;
        End;
      End;
    end;
  End;

  Result := recRetornoTarefa;
end;

procedure TMovMeComunica.pCadastrarMotorista(strXML, strCPF: String);
var
  strSQL, strIdMot: String;
  qryGen: TUniQuery;
begin
  try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT * FROM CADMOT WHERE MOT_CPFMOT = :CPFMOT ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CPFMOT').AsString := strCPF;
      Open;

      strIdMot := fBuscarXML(strXML, 'id');

      If FieldByName('MOT_CODBAR').AsString <> strIdMot Then
      Begin
        If RecordCount = 0 Then
          Insert
        Else If FieldByName('MOT_CODBAR').AsString <> strIdMot Then
          Edit;

        If (State = dsEdit) Or (State = dsInsert) Then
        Begin
          If (State = dsInsert) Then
            FieldByName('MOT_CODMOT').AsString := fProCodCadMot;

          FieldByName('MOT_NOMMOT').AsString := fBuscarXML(strXML, 'name');
          FieldByName('MOT_CPFMOT').AsString :=
            fReplaceStr(fRemoveAcentoPontos(fBuscarXML(strXML, 'PSA__CPF')
            ), '-', '');
          FieldByName('MOT_CODEMP').AsString := VS_strCodEmp;
          FieldByName('MOT_STATUS').AsString := 'A';
          FieldByName('MOT_CODBAR').AsString := strIdMot;
          FieldByName('AUTOINCREM').AsString :=
            fRetAutoIncrem('CADMOT', VS_strCodEmp);

          Post;
        End;
      End;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TMovMeComunica.fGetXML(strLink: String): String;
begin
  try
    Result := LoadXMLDocument(strUrlApi + strTokAce + strLink).XML.Text;
  except
    Result := '';
  end;
end;

function TMovMeComunica.fBuscarXML(strXML, strTag: String): String;
  function fPesquisaXML(var Node: IXMLNode; Campo: string;
    out Valor: Variant): Boolean;
  var
    index: Integer;
    Node_Tmp: IXMLNode;
  begin
    Result := False;
    for Index := 0 to Node.ChildNodes.Count - 1 do
    begin
      Node_Tmp := Node.ChildNodes[Index];
      if SameText(Node_Tmp.NodeName, Campo) then
      begin
        Result := True;
        Valor := Node_Tmp.NodeValue;
        Exit;
      end
      else if Node_Tmp.ChildNodes.Count > 0 then
      begin
        Result := fPesquisaXML(Node_Tmp, Campo, Valor);
        if Result then
          Exit;
      end;
    end;
  end;

var
  Node_Geral: IXMLNode;
  res: Variant;
  XML: IXMLDocument;
begin
  Result := '';

  try
    XML := LoadXMLData(strXML);
    XML.Active := True;
    Node_Geral := XML.DocumentElement;
    if fPesquisaXML(Node_Geral, strTag, res) then
    begin
      If res <> Null Then
      Begin
        SetLength(Result, Length(res));
        Result := VarToStr(res);
      End
      Else
        Result := '';
    end
    else
      Result := '';
  finally
  end;
end;

procedure TMovMeComunica.pLog(strTexto: String);
begin
  If Not(blnLogar Or blnLogApenErro) Then
    Exit;

  stlLog.Add(FormatDateTime('dd/mm/yyyy hh:nn:ss', fNow()) + ' - ' + strTexto);
end;

procedure TMovMeComunica.pLogStatus;
begin
  If Not(blnLogar Or blnLogApenErro) Then
    Exit;

  If (blnLogApenErro) And (RESTRes.Status.Success) Then
    Exit;

  pLog('---------------------------------------------------------------------');
  pLog('URL.........: ' + RESTRes.FullRequestURI);
  pLog('Content.....: ' + RESTRes.Content);
  pLog('StatusCode..: ' + IntToStr(RESTRes.StatusCode));
  pLog('ErrorMessage: ' + RESTRes.ErrorMessage);
  pLog('StatusText..: ' + RESTRes.StatusText);
  pLog('Status.Success.....................: ' +
    fBoleanoToStr(RESTRes.Status.Success));
  pLog('Status.ClientError.................: ' +
    fBoleanoToStr(RESTRes.Status.ClientError));
  pLog('Status.SuccessOK_200...............: ' +
    fBoleanoToStr(RESTRes.Status.SuccessOK_200));
  pLog('Status.SucessCreated_201...........: ' +
    fBoleanoToStr(RESTRes.Status.SucessCreated_201));
  pLog('Status.ClientErrorBadRequest_400...: ' +
    fBoleanoToStr(RESTRes.Status.ClientErrorBadRequest_400));
  pLog('Status.ClientErrorUnauthorized_401.: ' +
    fBoleanoToStr(RESTRes.Status.ClientErrorUnauthorized_401));
  pLog('Status.ClientErrorForbidden_403....: ' +
    fBoleanoToStr(RESTRes.Status.ClientErrorForbidden_403));
  pLog('Status.ClientErrorNotFound_404.....: ' +
    fBoleanoToStr(RESTRes.Status.ClientErrorNotFound_404));
  pLog('Status.ClientErrorNotAcceptable_406: ' +
    fBoleanoToStr(RESTRes.Status.ClientErrorNotAcceptable_406));
  pLog('Status.ClientErrorDuplicate_409....: ' +
    fBoleanoToStr(RESTRes.Status.ClientErrorDuplicate_409));
  pLog('---------------------------------------------------------------------');
end;

function TMovMeComunica.fPost(strXMLData: String; strServico: String): Boolean;
Var
  dtaAgora: TDateTime;
  strDir: String;
  stlLogPost: TStringList;
begin

  Result := False;
  stlLogPost := TStringList.Create;

  try

    blnLogar := FileExists('uMovMe.debug');

    strDir := ExtractFilePath(Application.ExeName) + 'uMovMeLogs\';

    If Not DirectoryExists(strDir) Then
      ForceDirectories(strDir);

    If (intPosts >= 5) Then
    Begin
      While (FormatDateTime('hhnnss', fNow()) = FormatDateTime('hhnnss',
        dtaUltPos)) Do
      begin
        Application.ProcessMessages;
        Sleep(500);
      end;
    End;

    RESTReq.Method := rmPost;
    RESTReq.Params.Clear;
    RESTReq.Params.AddItem;
    RESTReq.Params.Items[0].name := 'data';
    RESTReq.Params.Items[0].Value := fEncodeAsUTF8(strXMLData);
    RESTReq.Params.Items[0].ContentType := ctAPPLICATION_X_WWW_FORM_URLENCODED;
    RESTReq.Params.Items[0].Kind := pkGETorPOST;

    if copy(strServico, 1, 1) <> '/' then
      RESTCli.BaseURL := strUrlApi + strTokAce + '/' + strServico
    else
      RESTCli.BaseURL := strUrlApi + strTokAce + strServico;

    RESTReq.Execute;

    dtaAgora := fNow();

    If (FormatDateTime('hhnnss', dtaAgora) <> FormatDateTime('hhnnss',
      dtaUltPos)) Then
    Begin
      dtaUltPos := dtaAgora;
      intPosts := 1;
    End
    Else
      intPosts := intPosts + 1;

    Result := RESTRes.Status.Success;

    stlLogPost.Add(Format('=== %s: Resultado OK POST ===',
        [FormatDateTime('dd/mm/yyyy hh:nn:ss.zzz', fNow)]
      ));

    stlLogPost.Add('---------------------------------------------------------------------');
    stlLogPost.Add('URL.........: ' + RESTRes.FullRequestURI);
    stlLogPost.Add('Content.....: ' + RESTRes.Content);
    stlLogPost.Add('StatusCode..: ' + IntToStr(RESTRes.StatusCode));
    stlLogPost.Add('ErrorMessage: ' + RESTRes.ErrorMessage);
    stlLogPost.Add('StatusText..: ' + RESTRes.StatusText);
    stlLogPost.Add('Status.Success.....................: ' +
      fBoleanoToStr(RESTRes.Status.Success));
    stlLogPost.Add('Status.ClientError.................: ' +
      fBoleanoToStr(RESTRes.Status.ClientError));
    stlLogPost.Add('Status.SuccessOK_200...............: ' +
      fBoleanoToStr(RESTRes.Status.SuccessOK_200));
    stlLogPost.Add('Status.SucessCreated_201...........: ' +
      fBoleanoToStr(RESTRes.Status.SucessCreated_201));
    stlLogPost.Add('Status.ClientErrorBadRequest_400...: ' +
      fBoleanoToStr(RESTRes.Status.ClientErrorBadRequest_400));
    stlLogPost.Add('Status.ClientErrorUnauthorized_401.: ' +
      fBoleanoToStr(RESTRes.Status.ClientErrorUnauthorized_401));
    stlLogPost.Add('Status.ClientErrorForbidden_403....: ' +
      fBoleanoToStr(RESTRes.Status.ClientErrorForbidden_403));
    stlLogPost.Add('Status.ClientErrorNotFound_404.....: ' +
      fBoleanoToStr(RESTRes.Status.ClientErrorNotFound_404));
    stlLogPost.Add('Status.ClientErrorNotAcceptable_406: ' +
      fBoleanoToStr(RESTRes.Status.ClientErrorNotAcceptable_406));
    stlLogPost.Add('Status.ClientErrorDuplicate_409....: ' +
      fBoleanoToStr(RESTRes.Status.ClientErrorDuplicate_409));
    stlLogPost.Add('---------------------------------------------------------------------');

    if blnLogar then
      stlLogPost.SaveToFile(strDir +'POST_' + FormatDateTime('yyyymmdd_hhnnsszzz', fNow)
          + '.txt');
  except
    on E: Exception do
    begin
      strDir := ExtractFilePath(Application.ExeName) + 'uMovMeLogs\';

      If Not DirectoryExists(strDir) Then
        ForceDirectories(strDir);

      stlLogPost.Add(Format('=== %s: Erro em rotina POST: %s ===',
          [FormatDateTime('dd/mm/yyyy hh:nn:ss.zzz', fNow), E.Message]
        ));

      if blnLogar then
        stlLogPost.SaveToFile(strDir +'POST_' + FormatDateTime('yyyymmdd_hhnnsszzz', fNow)
            + '.txt');
    end;
  end;

end;

function TMovMeComunica.fPostCliente(strXMLData: String): Boolean;
begin

  Try
    Result := fPost(strXMLData, 'batch/serviceLocals.xml');
    pLogStatus;

    If not Result Then
    begin

      Try
        pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
        frmMensagemExplicativa.Caption := 'Atenção!';
        frmMensagemExplicativa.mmoInstru.Font.Size := 12;
        frmMensagemExplicativa.mmoInstru.Font.Style := [];
        frmMensagemExplicativa.mmoInstru.Lines.Add('Erro na exportação de clientes:');
        frmMensagemExplicativa.mmoInstru.Lines.Add(RESTRes.Content);
        frmMensagemExplicativa.mmoInstru.Alignment := taCenter;
        frmMensagemExplicativa.ShowModal;
      Except
        On E: Exception Do
          pMensagensErro(e.Message, '[TfrmRomaneioBusca.btnHlpLinClick]')
      End;

      pFreeAndNil(frmMensagemExplicativa);
    end;

  Except

    On E: Exception Do
    Begin
      Result := False;

      pLog('Exception: ' + E.Message);
      pLogStatus;
    End;

  End;

  pSaveLog;

end;

function TMovMeComunica.fInsereGrupos(strXMLData: String): Boolean;
begin
  Try
    Result := fPost(strXMLData, '/group.xml');
//    pLogStatus;
  Except
    On E: Exception Do
    Begin
      Result := False;
//      pLog('Exception: ' + E.Message);
//      pLogStatus;
    End;
  End;
  pSaveLog;
end;

function TMovMeComunica.fAtualizaGrupos(strXMLData: String;
  strId: String): Boolean;
begin
  Try
    Result := fPost(strXMLData, '/group/alternativeIdentifier/' + strId
      + '.xml');
//    pLogStatus;
  Except
    On E: Exception Do
    Begin
      Result := False;
//      pLog('Exception: ' + E.Message);
//      pLogStatus;
    End;
  End;
  pSaveLog;
end;

function TMovMeComunica.fInsereSubGrupos(strXMLData: String): Boolean;
begin
  Try
    Result := fPost(strXMLData, '/subGroup.xml');
//    pLogStatus;
  Except
    On E: Exception Do
    Begin
      Result := False;
//      pLog('Exception: ' + E.Message);
//      pLogStatus;
    End;
  End;
  pSaveLog;
end;

function TMovMeComunica.fAtualizaSubGrupos(strXMLData, strId: String): Boolean;
begin
  Try
    Result := fPost(strXMLData, '/subGroup/alternativeIdentifier/' + strId
      + '.xml');
//    pLogStatus;
  Except
    On E: Exception Do
    Begin
      Result := False;
//      pLog('Exception: ' + E.Message);
//      pLogStatus;
    End;
  End;
  pSaveLog;
end;

function TMovMeComunica.fPostItens(strXMLData: String): Boolean;
begin
  Try
    Result := fPost(strXMLData, '/batch/items.xml');
    pLogStatus;

    If not Result Then
    begin
        Try
          pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
          frmMensagemExplicativa.Caption := 'Atenção!';
          frmMensagemExplicativa.mmoInstru.Font.Size := 12;
          frmMensagemExplicativa.mmoInstru.Font.Style := [];
          frmMensagemExplicativa.mmoInstru.Lines.Add('Erro na exportação de itens:');
          frmMensagemExplicativa.mmoInstru.Lines.Add(RESTRes.Content);
          frmMensagemExplicativa.mmoInstru.Alignment := taCenter;
          frmMensagemExplicativa.ShowModal;
        Except
          On E: Exception Do
            pMensagensErro(e.Message, '[TfrmRomaneioBusca.btnHlpLinClick]')
        End;

        pFreeAndNil(frmMensagemExplicativa);
    end;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pLog('Exception: ' + E.Message);
      pLogStatus;
    End;

  End;

  pSaveLog;
end;

// function TMovMeComunica.fPostItemNotasFiscais(strXMLData: String): Boolean;
// begin
// Try
// Result := fPost(strXMLData, '/customEntity/' + strIdCeNfIt + '/customEntityEntry.xml' );
// pLogStatus;
// Except
// On E: Exception Do
// Begin
// Result := False;
// pLog('Exception: ' + E.Message);
// pLogStatus;
// End;
// End;
// pSaveLog;
// end;

// function TMovMeComunica.fAtualizaItemNotasFiscais(strXMLData: String; strId: String): Boolean;
// begin
// Try
// Result := fPost(strXMLData, '/customEntity/' + strIdCeNfIt + '/customEntityEntry/alternativeIdentifier/' + strId + '.xml' );
// pLogStatus;
// Except
// On E: Exception Do
// Begin
// Result := False;
// pLog('Exception: ' + E.Message);
// pLogStatus;
// End;
// End;
// pSaveLog;
// end;

// function TMovMeComunica.fPostItensNotasFiscais(strXMLData: String): Boolean;
// begin
// Try
// Result := fPost(strXMLData, '/batch/customEntity/' + strIdCeNfIt + '/customEntityEntries.xml' );
// pLogStatus;
// Except
// On E: Exception Do
// Begin
// Result := False;
// pLog('Exception: ' + E.Message);
// pLogStatus;
// End;
// End;
// pSaveLog;
// end;

function TMovMeComunica.fPostNotasFiscais(strXMLData: String): Boolean;
begin
  Try
    Result := fPost(strXMLData, '/batch/customEntity/' + strIdCeNf +
      '/customEntityEntries.xml');
    pLogStatus;

    If not Result Then
    begin
        Try
          pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
          frmMensagemExplicativa.Caption := 'Atenção!';
          frmMensagemExplicativa.mmoInstru.Font.Size := 12;
          frmMensagemExplicativa.mmoInstru.Font.Style := [];
          frmMensagemExplicativa.mmoInstru.Lines.Add('Erro na exportação de notas fiscais:');
          frmMensagemExplicativa.mmoInstru.Lines.Add(RESTRes.Content);
          frmMensagemExplicativa.mmoInstru.Alignment := taCenter;
          frmMensagemExplicativa.ShowModal;
        Except
          On E: Exception Do
            pMensagensErro(e.Message, '[TfrmRomaneioBusca.btnHlpLinClick]')
        End;

        pFreeAndNil(frmMensagemExplicativa);
    end;

  Except
    On E: Exception Do
    Begin
      Result := False;

      pLog('Exception: ' + E.Message);
      pLogStatus;
    End;

  End;

  pSaveLog;
end;

function TMovMeComunica.fPostSchedules(strXMLData: String): Boolean;
begin
  Try
    Result := fPost(strXMLData, '/batch/schedules.xml');
    pLogStatus;

    If not Result Then
    begin
        Try
          pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
          frmMensagemExplicativa.Caption := 'Atenção!';
          frmMensagemExplicativa.mmoInstru.Font.Size := 12;
          frmMensagemExplicativa.mmoInstru.Font.Style := [];
          frmMensagemExplicativa.mmoInstru.Lines.Add('Erro na exportação de Romaneios (Schedules):');
          frmMensagemExplicativa.mmoInstru.Lines.Add(RESTRes.Content);
          frmMensagemExplicativa.mmoInstru.Alignment := taCenter;
          frmMensagemExplicativa.ShowModal;
        Except
          On E: Exception Do
            pMensagensErro(e.Message, '[TfrmRomaneioBusca.btnHlpLinClick]')
        End;

        pFreeAndNil(frmMensagemExplicativa);
    end;

  Except
    On E: Exception Do
    Begin
      Result := False;

      pLog('Exception: ' + E.Message);
      pLogStatus;
    End;

  End;

  pSaveLog;
end;

function TMovMeComunica.fPostScheduleItems(strXMLData: String): Boolean;
begin
  Try
    Result := fPost(strXMLData, '/batch/scheduleItems.xml');
    pLogStatus;
  Except
    On E: Exception Do
    Begin
      Result := False;

      pLog('Exception: ' + E.Message);
      pLogStatus;
    End;
  End;

  pSaveLog;
end;

function TMovMeComunica.fPostScheduleRoutings(arrScheduleRoutings
  : TArrScheduleRoutings): Boolean;
var
  intCnt: Integer;
begin
  Result := True;

  Try
    For intCnt := Low(arrScheduleRoutings) To High(arrScheduleRoutings) Do
    Begin

      Result := fPost(fXMLScheduleRouting(arrScheduleRoutings[intCnt]),
        '/scheduleRouting.xml');
      pLogStatus;

      If not Result Then
      begin
        Try
          pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
          frmMensagemExplicativa.Caption := 'Atenção!';
          frmMensagemExplicativa.mmoInstru.Font.Size := 12;
          frmMensagemExplicativa.mmoInstru.Font.Style := [];
          frmMensagemExplicativa.mmoInstru.Lines.Add('Erro na criação de Roteirização (ScheduleRouting):');
          frmMensagemExplicativa.mmoInstru.Lines.Add(RESTRes.Content);
          frmMensagemExplicativa.mmoInstru.Alignment := taCenter;
          frmMensagemExplicativa.ShowModal;
        Except
          On E: Exception Do
            pMensagensErro(e.Message, '[TfrmRomaneioBusca.btnHlpLinClick]')
        End;

        pFreeAndNil(frmMensagemExplicativa);
      end;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;

      pLog('Exception: ' + E.Message);
      pLogStatus;
    End;

  End;

  pSaveLog;
end;

function TMovMeComunica.fProCodCadMot: String;
Var
  strSQL: String;
  qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL +
      ' SELECT A.MOT_CODMOT+1 AS PROCOD                        ';
    strSQL := strSQL +
      ' FROM CADMOT AS A                                       ';
    strSQL := strSQL +
      ' LEFT JOIN CADMOT AS B ON A.MOT_CODMOT+1 = B.MOT_CODMOT ';
    strSQL := strSQL +
      ' WHERE B.MOT_CODMOT IS NULL                             ';
    strSQL := strSQL +
      ' ORDER BY A.MOT_CODMOT LIMIT 1                          ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      Result := fPadL(FieldByName('PROCOD').AsString, 5, '0');

      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TMovMeComunica.pSaveLog;
Var
  strDir: String;
begin
  If (blnLogar) Or (blnLogApenErro) Then
  Begin
    strDir := ExtractFilePath(Application.ExeName) + 'uMovMeLogs\';
    If Not DirectoryExists(strDir) Then
      ForceDirectories(strDir);

    If (stlLog.Count > 0) Then
      stlLog.SaveToFile(strDir + FormatDateTime('yyyymmdd_hh.nn.ss.zzz', fNow)
        + '.txt');

    stlLog.Clear;
  End;
end;

function TMovMeComunica.fConfirmaBaixa(qryDocumento: TUniQuery;
  recRetornoTarefa: TrecRetornoTarefa): Boolean;
Var
  strEntreg: String;
  objHisPed: THisPed;
  qryRomObs: TUniQuery;
  qryPedido: TUniQuery;
  qryItens: TUniQuery;

  i: Integer;

  objOcoCrm: TAtuOcoCrm;

  strNumeroNovoPreRomaneio: String;

  strNumPedTmp: String;
  strEmpPedTmp: String;

  strSQL: String;

  curTotalDevolvido: Currency;

  procedure pCancelar;
  begin
    FreeAndNil(objHisPed);
    FreeAndNil(qryRomObs);
    FreeAndNil(qryPedido);
    qryDocumento.EnableControls;
  End;

  procedure fAtualizaInformacoesCRMLocal(strNumDoc, strEspDoc,
    strCodEmp: String; strNumOrc: String = ''; strEspOrc: String = '');
  begin
    objOcoCrm := fAtualizaInformacoesCRM(strNumDoc, strEspDoc, strCodEmp,
      qryDocumento.FieldByName('GER_CLIORI').AsString, strNumOrc, strEspOrc,
      strLoginUsuarioLogado, afcRomaneioBaixa);

    objOcoCrm.strDHBaix := FormatDateTime('dd/mm/yyyy hh:nn', Date);
    objOcoCrm.strNomRec := qryDocumento.FieldByName('GER_NOMCLI').AsString;
    objOcoCrm.strNumRom := qryDocumento.FieldByName('GER_NUMROM').AsString;
    objOcoCrm.strNomFrm := Self.Name;

    TAtuOcoCrm(objOcoCrm).pProcessaFatOcorrenciasCRM;
  end;

  Function fRetValSel: String;
  Begin
    Result := '(DET_QTDBAI * DET_UNITAR) - (DET_QTDBAI * (DET_DESESP / DET_QTDITE)) DET_VALSEL ';
  End;

  function fDocumentoVazio(strNumRom, strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  var
    qryRomDet: TUniQuery;
  begin
    try
      try
        qryRomDet := fCriaQuery;

        qryRomDet.Close;
        qryRomDet.SQL.Add(' SELECT COUNT(AUTOINCREM) AS ITENS FROM ROMDETX ');
        qryRomDet.SQL.Add(' WHERE DET_NUMROM = :NUMROM ');
        qryRomDet.SQL.Add(' AND DET_NUMDOC = :NUMFAT ');
        qryRomDet.SQL.Add(' AND DET_ESPDOC = :TIPFAT ');
        qryRomDet.SQL.Add(' AND DET_CODEMP = :EMPFAT ');

        qryRomDet.ParamByName('NUMROM').AsString := strNumRom;
        qryRomDet.ParamByName('NUMFAT').AsString := strNumDoc;
        qryRomDet.ParamByName('TIPFAT').AsString := strEspDoc;
        qryRomDet.ParamByName('EMPFAT').AsString := strCodEmp;

        qryRomDet.Open;

        Result := (qryRomDet.FieldByName('ITENS').AsInteger = 0);
      except
        Result := False;
      end;
    finally
      FreeAndNil(qryRomDet);
    end;
  end;

begin
  Result := False;

  strNumeroNovoPreRomaneio := '';

  qryDocumento.DisableControls;
  objHisPed := THisPed.Create(Self);

  qryRomObs := fCriaQuery;
  qryRomObs.Options.SetFieldsReadOnly := False;

  qryItens := fCriaQuery;

  qryPedido := fCriaQuery;
  qryPedido.SQL.Add('SELECT FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP');
  qryPedido.SQL.Add('FROM FATGOR');
  qryPedido.SQL.Add('WHERE FGO_NUMFAT = :NUMDOC');
  qryPedido.SQL.Add('  AND FGO_TIPFAT = :ESPDOC');
  qryPedido.SQL.Add('  AND FGO_EMPFAT = :CODEMP');

  Try
    qryDocumento.First;
    fStartTransaction;

    While (Not qryDocumento.Eof) Do
    Begin
      If Not fEmptyStr(qryDocumento.FieldByName('GER_OBSERV').AsString) Then
      Begin
        qryRomObs.Close;
        qryRomObs.SQL.Clear;
        qryRomObs.SQL.Add(' SELECT * ');
        qryRomObs.SQL.Add('   FROM ROMOBSX ');
        qryRomObs.SQL.Add('  WHERE OBS_NUMROM = ' +
          Quotedstr(qryDocumento.FieldByName('GER_NUMROM').AsString));
        qryRomObs.SQL.Add('    AND OBS_NUMDOC = ' +
          Quotedstr(qryDocumento.FieldByName('GER_DOCORI').AsString));
        qryRomObs.SQL.Add('    AND OBS_ESPDOC = ' +
          Quotedstr(qryDocumento.FieldByName('GER_ESPORI').AsString));
        qryRomObs.SQL.Add('    AND OBS_EMPDOC = ' +
          Quotedstr(qryDocumento.FieldByName('GER_CODEMP').AsString));
        qryRomObs.SQL.Add('    AND OBS_CODCLI = ' +
          Quotedstr(qryDocumento.FieldByName('GER_CLIORI').AsString));
        qryRomObs.Open;

        If (qryRomObs.IsEmpty) Then
          qryRomObs.Append
        Else
          qryRomObs.Edit;

        qryRomObs.FieldByName('AUTOINCREM').AsString :=
          fRetAutoIncrem('ROMOBSX', VS_strCodEmp);
        qryRomObs.FieldByName('OBS_NUMROM').AsString :=
          qryDocumento.FieldByName('GER_NUMROM').AsString;
        qryRomObs.FieldByName('OBS_EMPROM').AsString :=
          qryDocumento.FieldByName('GER_EMPROM').AsString;
        qryRomObs.FieldByName('OBS_NUMDOC').AsString :=
          qryDocumento.FieldByName('GER_DOCORI').AsString;
        qryRomObs.FieldByName('OBS_ESPDOC').AsString :=
          qryDocumento.FieldByName('GER_ESPORI').AsString;
        qryRomObs.FieldByName('OBS_EMPDOC').AsString :=
          qryDocumento.FieldByName('GER_CODEMP').AsString;
        qryRomObs.FieldByName('OBS_CODCLI').AsString :=
          qryDocumento.FieldByName('GER_CLIORI').AsString;
        qryRomObs.FieldByName('OBS_OBSERV').AsString :=
          recRetornoTarefa.strMotivoNaoEntrega;
        qryRomObs.Post;
      End;

      If (qryDocumento.FieldByName('GER_MARDES').AsString = 'M') Then
        strEntreg := 'S'
      Else
        strEntreg := 'N';

      Result := objHisPed.fAtualizarHistorico
        (qryDocumento.FieldByName('GER_DOCORI').AsString,
        qryDocumento.FieldByName('GER_ESPORI').AsString,
        qryDocumento.FieldByName('GER_CODEMP').AsString,
        qryDocumento.FieldByName('GER_NUMROM').AsString,
        qryDocumento.FieldByName('GER_NOMREC').AsString,
        IIF(qryDocumento.FieldByName('GER_DTABAI').AsDateTime = 0, VS_Date,
        qryDocumento.FieldByName('GER_DTABAI').AsDateTime),
        IIF(qryDocumento.FieldByName('GER_HORBAI').AsDateTime = 0, fTime(),
        qryDocumento.FieldByName('GER_HORBAI').AsDateTime), strEntreg,
        qryDocumento.FieldByName('GER_OBSERV').AsString);

      If (Result) And (VS_strHabilitarCRM) And
        (Not fEmptyStr(fCfgSis('VENORC', varString))) And
        (Not fEmptyStr(fCfgSis('VENPED', varString))) Then
      begin
        If fCfgSis('OPCROM', varInteger) = 1 Then
        Begin
          fAtualizaInformacoesCRMLocal(qryDocumento.FieldByName('GER_DOCORI')
            .AsString, qryDocumento.FieldByName('GER_ESPORI').AsString,
            qryDocumento.FieldByName('GER_CODEMP').AsString);
        End
        Else
        Begin
          qryPedido.Close;
          qryPedido.ParamByName('NUMDOC').AsString :=
            qryDocumento.FieldByName('GER_DOCORI').AsString;
          qryPedido.ParamByName('ESPDOC').AsString :=
            qryDocumento.FieldByName('GER_ESPORI').AsString;
          qryPedido.ParamByName('CODEMP').AsString :=
            qryDocumento.FieldByName('GER_CODEMP').AsString;
          qryPedido.Open;

          If Not qryPedido.IsEmpty Then
          Begin
            qryPedido.First;
            While Not qryPedido.Eof Do
            Begin
              fAtualizaInformacoesCRMLocal
                (qryDocumento.FieldByName('GER_DOCORI').AsString,
                qryDocumento.FieldByName('GER_ESPORI').AsString,
                qryPedido.FieldByName('FGO_CODEMP').AsString,
                qryPedido.FieldByName('FGO_NUMDOC').AsString,
                qryPedido.FieldByName('FGO_ESPDOC').AsString);

              qryPedido.Next;
            End;
          End;
        End;
      end;

      If (Not Result) Then
      Begin
        fRollBack;
        Break;
      End;

      If (strEntreg = 'N') Then
      Begin
        Result := fMarcarFlag(qryDocumento.FieldByName('GER_DOCORI').AsString,
                              qryDocumento.FieldByName('GER_ESPORI').AsString,
                              qryDocumento.FieldByName('GER_CODEMP').AsString,
                              qryDocumento.FieldByName('GER_CLIORI').AsString,
                              qryDocumento.FieldByName('GER_NUMROM').AsString,
                              'P');
      End
      Else
      Begin
        Try
          strSQL := '';
          strSQL := strSQL + ' SELECT SQL_NO_CACHE    ';
          strSQL := strSQL + '          DET_SEQGER,   ';
          strSQL := strSQL + '          DET_CODITE,   ';
          strSQL := strSQL + '          DET_DESCRI,   ';
          strSQL := strSQL + '          DET_NUMLOT,   ';
          strSQL := strSQL + '          DET_QTDITE,   ';
          strSQL := strSQL + '          DET_QTDBAI,   ';
          strSQL := strSQL + '   "M" AS DET_MARDES,   ';
          strSQL := strSQL + '          DET_NUMROM,   ';
          strSQL := strSQL + '          DET_CODEMP,   ';
          strSQL := strSQL + '          AUTOINCREM,   ';
          strSQL := strSQL + '          DET_AUTINC,   ';
          strSQL := strSQL + '          DET_UNITAR,   ';
          strSQL := strSQL + '          DET_DESESP,   ';
          strSQL := strSQL + '      ' + fRetValSel;
          strSQL := strSQL + ' FROM                   ';
          strSQL := strSQL + '   ROMDETX              ';
          strSQL := strSQL + ' WHERE                  ';
          strSQL := strSQL + '   DET_SEQGER = :SEQGER ';

          qryItens.Close;
          qryItens.SQL.Clear;
          qryItens.SQL.Add(strSQL);
          qryItens.ParamByName('SEQGER').AsString :=
            qryDocumento.FieldByName('AUTOINCREM').AsString;
          qryItens.Open;

          pSetaClient(qryItens);
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '');
          End;
        End;

        If (qryItens.Active) Then
        Begin
          qryItens.Filtered := False;
          // qryItens.Filter   := 'DET_SEQGER = ' + QuotedStr(qryDocumento.FieldByName('AUTOINCREM').AsString) + ' AND DET_MARDES <> ' + QuotedStr('M');
          qryItens.Filter := 'DET_SEQGER = ' +
            Quotedstr(qryDocumento.FieldByName('AUTOINCREM').AsString);
          qryItens.Filtered := True;

          If Length(recRetornoTarefa.strItensDevolvidos) > 0 Then
          Begin
            for i := 0 to Length(recRetornoTarefa.strItensDevolvidos) - 1 do
            begin
              qryItens.First;

              while not qryItens.Eof do
              begin
                If (qryItens.FieldByName('DET_CODITE').AsString)
                  = (SplitString(recRetornoTarefa.strItensDevolvidos[i],
                  '-')[0]) Then
                Begin
                  curTotalDevolvido :=
                    fStrToFloat(SplitString(recRetornoTarefa.strItensDevolvidos
                    [i], '-')[1]);

                  Result := fRemoverItemDocto
                    (qryDocumento.FieldByName('GER_DOCORI').AsString,
                    qryDocumento.FieldByName('GER_ESPORI').AsString,
                    qryDocumento.FieldByName('GER_CODEMP').AsString,
                    qryDocumento.FieldByName('GER_CLIORI').AsString,
                    qryDocumento.FieldByName('GER_NUMROM').AsString,
                    qryItens.FieldByName('DET_CODITE').AsString,

                    ((fStrToFloat(SplitString
                    (recRetornoTarefa.strItensDevolvidos[i], '-')[1]) *
                    qryItens.FieldByName('DET_UNITAR').AsFloat) -
                    (fStrToFloat(SplitString(recRetornoTarefa.strItensDevolvidos
                    [i], '-')[1]) * (qryItens.FieldByName('DET_DESESP').AsFloat
                    / qryItens.FieldByName('DET_QTDITE').AsFloat))),
                    curTotalDevolvido,
                    qryItens.FieldByName('DET_AUTINC').AsString,
                    qryDocumento.FieldByName('GER_NOMTAB').AsString);

                  If (Result) and (curTotalDevolvido = qryItens.FieldByName('DET_QTDITE').AsCurrency) Then
                  begin
                    Result := fRemoverRomDet(qryItens.FieldByName('DET_NUMROM')
                      .AsString, qryItens.FieldByName('DET_SEQGER').AsString,
                      qryItens.FieldByName('DET_CODEMP').AsString,
                      qryItens.FieldByName('AUTOINCREM').AsString,
                      qryDocumento.FieldByName('GER_DOCORI').AsString,
                      qryDocumento.FieldByName('GER_ESPORI').AsString,
                      qryDocumento.FieldByName('GER_CLIORI').AsString,
                      qryDocumento.FieldByName('GER_CODVEN').AsString,
                      Copy(qryDocumento.FieldByName('MOT_NOMMOT').AsString, 1,
                      5), qryDocumento.FieldByName('GER_DTAENT').AsDateTime,
                      qryDocumento.FieldByName('GER_HORENT').AsDateTime,
                      qryItens.FieldByName('DET_CODITE').AsString,
                      qryItens.FieldByName('DET_QTDITE').AsFloat,
                      fStrToFloat
                      (SplitString(recRetornoTarefa.strItensDevolvidos
                      [i], '-')[1]),
                      qryItens.FieldByName('DET_AUTINC').AsString,
                      '',
                      '',
                      qryDocumento.FieldByName('GER_DTADOC').AsDateTime,
                      qryDocumento.FieldByName('GER_VOLUME').AsFloat);
                  end;
                End;

                qryItens.Next;
              End;
            End;
          End;

          qryItens.Filtered := False;
          qryItens.EnableControls;
        End;

        If (Result) Then
        begin
          if fDocumentoVazio(qryDocumento.FieldByName('GER_NUMROM').AsString,
              qryDocumento.FieldByName('GER_DOCORI').AsString,
              qryDocumento.FieldByName('GER_ESPORI').AsString,
              qryDocumento.FieldByName('GER_CODEMP').AsString) then
          begin
            Result :=
              fRemoverDocumento(qryDocumento.FieldByName('GER_DOCORI').AsString,
                qryDocumento.FieldByName('GER_ESPORI').AsString,
                qryDocumento.FieldByName('GER_CODEMP').AsString,
                qryDocumento.FieldByName('GER_CLIORI').AsString,
                qryDocumento.FieldByName('GER_NUMROM').AsString,
                qryDocumento.FieldByName('GER_CODVEN').AsString,
                qryDocumento.FieldByName('GER_CODMOT').AsString,
                qryDocumento.FieldByName('GER_DTAENT').AsDateTime,
                qryDocumento.FieldByName('GER_HORENT').AsDateTime,
                'DOCUMENTO REMOVIDO AUTOMATICAMENTE PELA INTEGRAÇÃO DO ROTEIRIZADOR');
          end
          else
          begin
            Result := fBaixarDocumento(qryDocumento.FieldByName('GER_DOCORI')
              .AsString, qryDocumento.FieldByName('GER_ESPORI').AsString,
              qryDocumento.FieldByName('GER_CODEMP').AsString,
              qryDocumento.FieldByName('GER_CLIORI').AsString,
              qryDocumento.FieldByName('GER_NUMROM').AsString,
              qryDocumento.FieldByName('GER_NOMREC').AsString,
              IIF(qryDocumento.FieldByName('GER_DTABAI').AsDateTime = 0, VS_Date,
              qryDocumento.FieldByName('GER_DTABAI').AsDateTime),
              IIF(qryDocumento.FieldByName('GER_HORBAI').AsDateTime = 0, fRetHoraServidor,
              qryDocumento.FieldByName('GER_HORBAI').AsDateTime), strEntreg, 'S', '','','',
              qryDocumento.FieldByName('GER_DTAROM').AsDateTime,
              qryDocumento.FieldByName('GER_DTADOC').AsDateTime,
              qryDocumento.FieldByName('GER_VOLUME').AsFloat);
          end;
        end;
      End;

      If (Not Result) Then
      Begin
        fRollBack;
        Break;
      End;

      qryDocumento.Next;
    End;

    If (Result) Then
    Begin
      fCommit;
      Result := True;
    End
    Else
      fRollBack;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[fConfirmaBaixa]');
    End;
  End;

  If (Result) Then
  Begin
    qryDocumento.First;

    While (Not qryDocumento.Eof) Do
    Begin
      pRetNumeroPedidoVenda(qryDocumento.FieldByName('GER_DOCORI').AsString,
        qryDocumento.FieldByName('GER_ESPORI').AsString,
        qryDocumento.FieldByName('GER_CODEMP').AsString,
        qryDocumento.FieldByName('GER_CLIORI').AsString, strNumPedTmp,
        strEmpPedTmp);

      qryDocumento.Next;
    End;
  End;

  pCancelar;
end;

function TMovMeComunica.fGerarNovoPreRomaneio(Var strRomNov: String;
  strNumRom, strEmpRom, strNumDoc, strEspDoc, strCodEmp: String): Boolean;
Var
  qryUpd: TUniQuery;
  qryGer: TUniQuery;
  qryDet: TUniQuery;
  intCnt: Integer;
  strFieldName: String;

  procedure pSetaParametrosUpdate(qry: TUniQuery);
  begin
    If qry.FindParam('ROMNOV') <> Nil Then
      qry.ParamByName('ROMNOV').AsString := strRomNov;

    If qry.FindParam('NUMROM') <> Nil Then
      qry.ParamByName('NUMROM').AsString := strNumRom;

    If qry.FindParam('EMPROM') <> Nil Then
      qry.ParamByName('EMPROM').AsString := strEmpRom;

    If qry.FindParam('NUMDOC') <> Nil Then
      qry.ParamByName('NUMDOC').AsString := strNumDoc;

    If qry.FindParam('ESPDOC') <> Nil Then
      qry.ParamByName('ESPDOC').AsString := strEspDoc;

    If qry.FindParam('CODEMP') <> Nil Then
      qry.ParamByName('CODEMP').AsString := strCodEmp;
  end;

begin
  Result := True;

  If fEmptyStr(strRomNov) Then
    strRomNov := fAtualizaProCod('ROMGERX', 'GER_NUMROM');

  qryUpd := fCriaQuery;
  qryGer := fCriaQuery;
  qryDet := fCriaQuery;
  fStartTransaction;
  Try
    Try
      With qryGer Do
      begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT * ');
        SQL.Add('   FROM ROMGERX ');
        SQL.Add('  WHERE GER_NUMROM = :NUMROM ');
        SQL.Add('    AND GER_EMPROM = :EMPROM ');
        SQL.Add('    AND GER_NUMDOC = :NUMDOC ');
        SQL.Add('    AND GER_ESPDOC = :ESPDOC ');
        SQL.Add('    AND GER_CODEMP = :CODEMP ');
        pSetaParametrosUpdate(qryGer);
        Open;
      end;

      With qryDet Do
      begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT * ');
        SQL.Add('   FROM ROMDETX ');
        SQL.Add('  WHERE DET_NUMROM = :NUMROM ');
        SQL.Add('    AND DET_EMPROM = :EMPROM ');
        SQL.Add('    AND DET_NUMDOC = :NUMDOC ');
        SQL.Add('    AND DET_ESPDOC = :ESPDOC ');
        SQL.Add('    AND DET_CODEMP = :CODEMP ');
        pSetaParametrosUpdate(qryDet);
        Open;
      end;

      qryUpd.Close;
      qryUpd.SQL.Clear;
      qryUpd.SQL.Add(' DELETE ');
      qryUpd.SQL.Add('   FROM ROMGERX ');
      qryUpd.SQL.Add('  WHERE GER_NUMROM = :NUMROM ');
      qryUpd.SQL.Add('    AND GER_EMPROM = :EMPROM ');
      qryUpd.SQL.Add('    AND GER_NUMDOC = :NUMDOC ');
      qryUpd.SQL.Add('    AND GER_ESPDOC = :ESPDOC ');
      qryUpd.SQL.Add('    AND GER_CODEMP = :CODEMP ');
      pSetaParametrosUpdate(qryUpd);
      qryUpd.ExecSQL;

      qryUpd.Close;
      qryUpd.SQL.Text := 'SELECT * FROM ROMGERX WHERE FALSE ';
      qryUpd.Open;

      qryUpd.Append;

      For intCnt := 0 To qryUpd.FieldCount - 1 Do
      Begin
        strFieldName := qryUpd.Fields[intCnt].FieldName;
        If qryGer.FindField(strFieldName) <> Nil Then
          qryUpd.FieldByName(strFieldName).Value :=
            qryGer.FieldByName(strFieldName).Value;
      End;
      qryUpd.FieldByName('GER_NUMROM').AsString := strRomNov;
      qryUpd.FieldByName('GER_STATUS').AsString := 'P';
      qryUpd.FieldByName('GER_CODREG').Value := Null;
      qryUpd.FieldByName('GER_FRETE_').AsFloat := 0;
      qryUpd.FieldByName('GER_ADIFRE').AsFloat := 0;
      qryUpd.FieldByName('GER_PERFRE').AsFloat := 0;
      qryUpd.Post;

      qryUpd.Close;
      qryUpd.SQL.Text := 'SELECT * FROM ROMDETX WHERE FALSE ';
      qryUpd.Open;

      qryDet.First;
      While Not qryDet.Eof Do
      Begin
        qryUpd.Append;
        For intCnt := 0 To qryUpd.FieldCount - 1 Do
        Begin
          strFieldName := qryUpd.Fields[intCnt].FieldName;
          If qryDet.FindField(strFieldName) <> Nil Then
            qryUpd.FieldByName(strFieldName).Value :=
              qryDet.FieldByName(strFieldName).Value;
        End;
        qryUpd.FieldByName('DET_NUMROM').AsString := strRomNov;
        qryUpd.Post;

        qryDet.Next;
      End;

      qryUpd.Close;
      qryUpd.SQL.Text := ' UPDATE FATGOR ' + '   SET FGO_NUMROM = :ROMNOV ' +
        ' WHERE FGO_NUMROM = :NUMROM AND ' + '       FGO_NUMDOC = :NUMDOC AND '
        + '       FGO_ESPDOC = :ESPDOC AND ' +
        '       FGO_CODEMP = :CODEMP     ';

      pSetaParametrosUpdate(qryUpd);
      qryUpd.ExecSQL;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message,
          '[TfrmFatBaixaRomaneio.fGerarNovoPreRomaneio]');
      End;
    End;
  Finally
    FreeAndNil(qryUpd);
    FreeAndNil(qryGer);
    FreeAndNil(qryDet);
  End;
end;

function TMovMeComunica.fChecarCliente(strCodCli: String): Boolean;
var
  Doc: IXMLDocument;
  Schedules, Schedule: IXMLNode;
  ScheduleLst: IXMLNodeList;
  strLink: String;
  i: Integer;
  strGeocoordinates: String;
begin
  // strUrlApi + strTokAce
  // activityHistory.xml?schedule.alternativeIdentifier=
  strGeocoordinates := '';
  Result := False;

  Doc := LoadXMLDocument(strUrlApi + strTokAce +
    '/serviceLocal.xml?alternativeIdentifier=' + strCodCli);
  Doc.Active := True;
  Schedules := Doc.DocumentElement;
  Schedules := Schedules.ChildNodes.FindNode('entries');

  for i := 0 to Schedules.ChildNodes.Count - 1 do
  begin
    Schedule := Schedules.ChildNodes[i];
    ScheduleLst := Schedule.AttributeNodes;

    strLink := ScheduleLst.FindNode('link').Text;

    Doc := LoadXMLDocument(strUrlApi + strTokAce + strLink);
    Doc.Active := True;

    Schedules := Doc.DocumentElement;
    Schedules := Schedules.ChildNodes.FindNode('isToSearchGeocorder');

    If Assigned(Schedules) And (Schedules.NodeValue <> 'true') Then
    begin
      Schedules := Doc.DocumentElement;
      Schedules := Schedules.ChildNodes.FindNode('geoCoordinate');

      If Assigned(Schedules) And (Schedules.NodeValue <> Null) Then
        strGeocoordinates := Schedules.NodeValue
      Else
        strGeocoordinates := '';

      Result := not(strGeocoordinates.IsEmpty);
    end
    else
    begin
      Application.ProcessMessages;
      Sleep(2500);
      Result := fChecarCliente(strCodCli);
    end;
  End;

End;

function TMovMeComunica.fMarcarFlag(strNumDoc,
                     strEspDoc,
                     strCodEmp,
                     strCodCli,
                     strNumRom: String;
                     strBaiFlg: String): Boolean;
Var
  strSQL   : String;
  qryGenGer: TUniQuery;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  ROMGERX ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  GER_BAIFLG = :BAIFLG ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';

    If (strEspDoc <> 'OX') Then
      strSQL := strSQL + '  GER_CODCLI = :CODCLI AND ';

    strSQL := strSQL + '  GER_NUMROM = :NUMROM AND ';
    strSQL := strSQL + '  GER_EMPROM = :EMPROM ';

    qryGenGer := fCriaQuery;

    qryGenGer.SQL.Clear;
    qryGenGer.SQL.Add(strSQL);

    qryGenGer.ParamByName('BAIFLG').AsString := strBaiFlg;

    qryGenGer.ParamByName('NUMDOC').AsString := strNumDoc;
    qryGenGer.ParamByName('ESPDOC').AsString := strEspDoc;
    qryGenGer.ParamByName('CODEMP').AsString := strCodEmp;

    If (strEspDoc <> 'OX') Then
      qryGenGer.ParamByName('CODCLI').AsString := strCodCli;

    qryGenGer.ParamByName('NUMROM').AsString := strNumRom;
    qryGenGer.ParamByName('EMPROM').AsString := VS_strCodEmp;

    qryGenGer.ExecSQL;
    FreeAndNil(qryGenGer);

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMarcarFlag]');
    End;
  End;
end;

end.
