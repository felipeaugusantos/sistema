unit untTecladoSEAT;

interface

uses
  untSubjectIntf, System.Classes, VCL.Forms, Vcl.ExtCtrls;

type
  TOrigemAvaliacao = (oaCaixa, oaAutoCenter, oaAmbos);

  TCodigoAvaliacao = (caRuim = 0, caRegular = 1, caBom = 2, caOtimo = 3, caNaoDefinido = 4, caExpirou = 5);

  TCodigoAvaliacaoHelper = record helper for TCodigoAvaliacao
    function fRetNome : String;
    function fRetCodVal(AValue : String) : TCodigoAvaliacao; Overload;
    function fRetCodVal : Integer; Overload;
  end;

  TStatusTeclado = (stDefault, stAvaliando, stConcluiu, stFalhou);

  TStatusTecladoHelper = record helper for TStatusTeclado
    function fRetNome : String;
    function fRetMSG_ : String;
    function fRetCor_ : String;
  end;

  TTecladoSEAT = Class(TInterfacedObject, ISubject_)
  const
    cAVALIA    = 'avalia.txt';
    cAVALIANDO = 'avaliando.txt';
    cCONCLUIU  = 'concluiu.txt';
    cFALHOU    = 'falhou.txt';
  private
    FNumDoc : String;
    FEspDoc : String;
    FEmpDoc : String;
    FCodAva    : TCodigoAvaliacao;
    FStatus    : TStatusTeclado;
    FObservers : TInterfaceList;
    FMonitor   : TTimer;

    class function fRetornaDiretorioDeOperacao : String;

    function fDocumentoFoiInformado : Boolean;
    function fMonitorandoDiretorio : Boolean;
    function pGetCodAva : TCodigoAvaliacao;

    procedure pCriarArquivoAvaliaTXT;
    procedure pSetCodAva(const AValue : TCodigoAvaliacao);
    procedure pSetStatus(const AValue : TStatusTeclado);
    procedure pLimparCamposEDiretorio;
    procedure pLimparDiretorio;
    procedure pLigarMonitoramento;
    procedure pMonitoramento(Sender: TObject);
  public

    constructor Create;
    destructor  Destroy; Override;

    procedure pSetNumDoc(const AValue : String);
    procedure pSetEspDoc(const AValue : String);
    procedure pSetEmpDoc(const AValue : String);
    procedure pIniciarAvaliacao;
    procedure pDesligarMonitoramento(const ANotificarObservers : Boolean = False);

    class function fUtilizaIntegracaoComTecladoDeSatisfacaoSEAT(AOrigem: TOrigemAvaliacao = oaAmbos) : Boolean;
    class function fDocumentoJaFoiAvaliado(const ANumDoc, AEspDoc, AEmpDoc : String) : Boolean;

    function fSetDadosDocumentoJaFoiAvaliado(const ANumDoc, AEspDoc, AEmpDoc : String) : Boolean;
    function fGravarAvaliacao : Boolean;
    function fEmOperacao : Boolean;

    procedure pAddObserver(Observer: IObserver_);
    procedure pDeleteObserver(Observer: IObserver_);
    procedure pNotify(const Parameters: array of String; AVisualizarProgresso: Boolean = True);

    property Status : TStatusTeclado read FStatus;

    function fDeletarAvaliacao(const ANomForm, ANumDoc, AEspDoc, AEmpDoc : String) : Boolean;

  end;

  TLogSeat = class
  public
    class var Iniciou: Boolean;
    class var Desligado: Boolean;
    class procedure Log(const strTexto: String);
    class procedure Inicializar;
    class function AptoAEfetivarLog: Boolean;
    class function ArquivosNoDiretorio: String;
  end;

implementation

uses
  untFuncoesSimples, System.SysUtils, System.IOUtils, Uni;

{ TTecladoSEAT }

procedure TTecladoSEAT.pAddObserver(Observer: IObserver_);
begin
  FObservers.Add(Observer);
end;

procedure TTecladoSEAT.pLimparCamposEDiretorio;
begin

  FNumDoc := '';
  FEspDoc := '';
  FEmpDoc := '';
  FCodAva := caNaoDefinido;
  FStatus := stDefault;

  If Not Assigned(FObservers) Then
    FObservers := TInterfaceList.Create;

  If Not Assigned(FMonitor) Then
  Begin
    FMonitor := TTimer.Create(Nil);
    FMonitor.Enabled  := False;
    FMonitor.OnTimer  := pMonitoramento;
    FMonitor.Interval := 1000;
  End;

  FObservers.Clear;
  pLimparDiretorio;

end;

procedure TTecladoSEAT.pLimparDiretorio;
  var
    LDir : String;
begin

  LDir := fRetornaDiretorioDeOperacao + '\' + cCONCLUIU;
  If FileExists(LDir) Then
    DeleteFile(LDir);

end;

procedure TTecladoSEAT.pDeleteObserver(Observer: IObserver_);
begin
  FObservers.Remove(Observer);
end;

procedure TTecladoSEAT.pDesligarMonitoramento(const ANotificarObservers : Boolean = False);
  const
    IDX_STATUS = 0;
    IDX_COR    = 1;
  var
    LParameters : array of String;
begin

  FMonitor.Enabled := False;
  pLimparDiretorio;

  If (ANotificarObservers) Then
  Begin

    SetLength(LParameters, 2);
    LParameters[IDX_STATUS] := '';
    LParameters[IDX_COR]    := '';
    pNotify(LParameters, True);

    pLimparCamposEDiretorio;

  End;

end;

function TTecladoSEAT.pGetCodAva: TCodigoAvaliacao;
  var
    LDir : String;
    LMem : TStringList;
    CodigoAvaliacao : TCodigoAvaliacao;
begin

  Result := caNaoDefinido;

  LDir := fRetornaDiretorioDeOperacao + '\' + cCONCLUIU;

  If FileExists(LDir) Then
  Begin
    Sleep(1000);
    LMem := TStringList.Create;
    Try
      LMem.LoadFromFile(LDir, TEncoding.UTF8);
      TLogSeat.Log('Conteúdo do Arquivo: ' + cCONCLUIU + ' - ' + LMem.Text);
      Result := CodigoAvaliacao.fRetCodVal(LMem.Text.Trim);
    Finally
      FreeAndNil(LMem);
    End;
  End
  Else
    TLogSeat.Log('Não conseguiu recuperar o conteúdo do arquivo: ' + cCONCLUIU);
end;

procedure TTecladoSEAT.pCriarArquivoAvaliaTXT;
  var
    LDir : String;
    LTxt : TextFile;
begin

  LDir := fRetornaDiretorioDeOperacao + '\' + cAVALIA;

  If FileExists(LDir) Then
    Exit;

  Try
    AssignFile(LTxt, LDir);
    Rewrite(LTxt);
  Finally
    CloseFile(LTxt);
  End;

end;

procedure TTecladoSEAT.pMonitoramento(Sender: TObject);
begin
  Sleep(1000);

  If fMonitorandoDiretorio Then
  Begin
    Application.ProcessMessages;
    Exit;
  End;

  If (FStatus = stConcluiu) Then
  Begin
    TLogSeat.Log('FStatus = stConcluiu');
    pSetCodAva(pGetCodAva);
    pDesligarMonitoramento;
  End;

  If (FStatus = stFalhou) Then
  Begin
    TLogSeat.Log('FStatus = stFalhou, vai setar caNaoDefinido');
    pSetCodAva(caNaoDefinido);
    pDesligarMonitoramento;
  End;

end;

procedure TTecladoSEAT.pNotify(const Parameters: array of String; AVisualizarProgresso: Boolean);
  var
    i : Integer;
begin
  for i := 0 to FObservers.Count - 1 do
    IObserver_(FObservers.Items[i]).pUpdate(Parameters, AVisualizarProgresso);
end;

constructor TTecladoSEAT.Create;
begin
  pLimparCamposEDiretorio;
end;

destructor TTecladoSEAT.Destroy;
begin

  If Assigned(FObservers) Then
    FreeAndNil(FObservers);

  If Assigned(FMonitor) Then
    FreeAndNil(FMonitor);

end;

procedure TTecladoSEAT.pIniciarAvaliacao;

  const
    QUANTIDADE_DE_TENTATIVAS = 3;

  var
    LContador : Integer;
    LIniciouComSucesso : Boolean;

  function fIniciouTeclado : Boolean;
  begin

    Result := True;

    Try
      pCriarArquivoAvaliaTXT;
    Except
      On E: EInOutError Do
      Begin
        Result := False;
        pGravarErro(True, 'Teclado SEAT [pIniciarAvaliacao]: ' + E.Message);
      End;
    End;

  end;

begin

  for LContador := 1 to QUANTIDADE_DE_TENTATIVAS do
  begin

    LIniciouComSucesso := fIniciouTeclado;

    If LIniciouComSucesso Then
      Break;

    Sleep(1000);

  end;

  If LIniciouComSucesso Then
    pLigarMonitoramento
  Else
    pSetStatus(stFalhou);

end;

procedure TTecladoSEAT.pLigarMonitoramento;
begin
  FMonitor.Enabled := True;
end;

function TTecladoSEAT.fDeletarAvaliacao(const ANomForm, ANumDoc, AEspDoc, AEmpDoc: String): Boolean;
  Var
    qryAvaliacao: TUniQuery;
begin

  qryAvaliacao := fCriaQuery;

  Try

    qryAvaliacao.Close;
    qryAvaliacao.SQL.Clear;

    qryAvaliacao.SQL.Add('SELECT ');
    qryAvaliacao.SQL.Add('  *    ');
    qryAvaliacao.SQL.Add('FROM   ');
    qryAvaliacao.SQL.Add('  FGSEAT ');
    qryAvaliacao.SQL.Add('WHERE  ');
    qryAvaliacao.SQL.Add('  FGS_NUMDOC = :NUMDOC AND FGS_ESPDOC = :ESPDOC AND FGS_CODEMP = :EMPDOC');

    qryAvaliacao.ParamByName('NUMDOC').AsString := ANumDoc;
    qryAvaliacao.ParamByName('ESPDOC').AsString := AEspDoc;
    qryAvaliacao.ParamByName('EMPDOC').AsString := AEmpDoc;

    qryAvaliacao.Open;

    While Not qryAvaliacao.IsEmpty Do
    Begin
      fVerificaIntegridade(ANomForm, 'FGSEAT', qryAvaliacao, True);
      qryAvaliacao.Delete;
    End;

    qryAvaliacao.Close;
    qryAvaliacao.SQL.Clear;
    qryAvaliacao.SQL.Add('SELECT ');
    qryAvaliacao.SQL.Add('  *    ');
    qryAvaliacao.SQL.Add('FROM   ');
    qryAvaliacao.SQL.Add('  MGSEAT ');
    qryAvaliacao.SQL.Add('WHERE  ');
    qryAvaliacao.SQL.Add('  MGS_NUMDOC = :NUMDOC AND MGS_ESPDOC = :ESPDOC AND MGS_CODEMP = :EMPDOC');

    qryAvaliacao.ParamByName('NUMDOC').AsString := ANumDoc;
    qryAvaliacao.ParamByName('ESPDOC').AsString := AEspDoc;
    qryAvaliacao.ParamByName('EMPDOC').AsString := AEmpDoc;

    qryAvaliacao.Open;

    While Not qryAvaliacao.IsEmpty Do
    Begin
      fVerificaIntegridade(ANomForm, 'MGSEAT', qryAvaliacao, True);
      qryAvaliacao.Delete;
    End;

    Result := True;

  Finally
    FreeAndNil(qryAvaliacao);
  End;

end;

function TTecladoSEAT.fDocumentoFoiInformado: Boolean;
begin

  Result := False;

  If FNumDoc.IsEmpty Then
    Exit;

  If FEspDoc.IsEmpty Then
    Exit;

  If FEmpDoc.IsEmpty Then
    Exit;

  Result := True;

end;

class function TTecladoSEAT.fDocumentoJaFoiAvaliado(const ANumDoc, AEspDoc, AEmpDoc: String): Boolean;
  var
    qryAux : TUniQuery;
    strSQL : String;
    strTab : String;
    strSig : String;
    blnPD_ : Boolean;
begin

  Result := False;

  If ANumDoc.IsEmpty Then
    Exit;

  If AEspDoc.IsEmpty Then
    Exit;

  If AEmpDoc.IsEmpty Then
    Exit;

  blnPD_ := (AEspDoc.Equals('PD') Or AEspDoc.Equals('OR'));

  strTab := IIF(blnPD_, 'FGSEAT', 'MGSEAT');
  strSig := IIF(blnPD_, 'FGS'   , 'MGS');

  strSQL := 'SELECT COUNT(*) AS TOT FROM [TAB] WHERE [SIG]_NUMDOC = :NUMDOC AND [SIG]_ESPDOC = :ESPDOC AND [SIG]_CODEMP = :EMPDOC';
  strSQL := strSQL.Replace('[TAB]', strTab);
  strSQL := strSQL.Replace('[SIG]', strSig);

  qryAux := fCriaQuery;

  Try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('NUMDOC').AsString := ANumDoc;
    qryAux.ParamByName('ESPDOC').AsString := AEspDoc;
    qryAux.ParamByName('EMPDOC').AsString := AEmpDoc;
    qryAux.Open;

    Result := (Not qryAux.IsEmpty) And (qryAux.FieldByName('TOT').AsInteger > 0);

  Finally
    FreeAndNil(qryAux);
  End;

end;

function TTecladoSEAT.fGravarAvaliacao : Boolean;
  const
    SELECT = 'SELECT * FROM [TABELA] WHERE FALSE';
  var
    qryAux : TUniQuery;
    strTab : String;
    strSig : String;
begin

  Result := False;

  If Not fDocumentoFoiInformado Then
    Exit;

  qryAux := fCriaQuery;

  strTab := IIF(FEspDoc.Equals('PD') Or FEspDoc.Equals('OR'), 'FGSEAT', 'MGSEAT');
  strSig := IIF(FEspDoc.Equals('PD') Or FEspDoc.Equals('OR'), 'FGS_'  , 'MGS_');

  Try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(SELECT.Replace('[TABELA]', strTab));
    qryAux.Open;

    qryAux.Append;
    qryAux.FieldByName('AUTOINCREM').AsString        := fRetAutoIncrem(strTab, VS_strCodEmp);
    qryAux.FieldByName(strSig + 'NUMDOC').AsString   := FNumDoc;
    qryAux.FieldByName(strSig + 'ESPDOC').AsString   := FEspDoc;
    qryAux.FieldByName(strSig + 'CODEMP').AsString   := FEmpDoc;
    qryAux.FieldByName(strSig + 'DTAAVA').AsDateTime := fRetDataServidor;
    qryAux.FieldByName(strSig + 'HRAAVA').AsDateTime := fRetHoraServidor;
    qryAux.FieldByName(strSig + 'CODAVA').AsInteger  := FCodAva.fRetCodVal;
    qryAux.FieldByName(strSig + 'DESAVA').AsString   := FCodAva.fRetNome;
    qryAux.FieldByName(strSig + 'FALHOU').AsString   := IIF(FStatus = stFalhou, 'S', 'N');
    qryAux.Post;

    Result := True;

  Finally
    FreeAndNil(qryAux);
    pDesligarMonitoramento;
  End;

end;

function TTecladoSEAT.fMonitorandoDiretorio: Boolean;
  var
    LDir : String;
begin

  Result := True;

  LDir := fRetornaDiretorioDeOperacao + '\' + cAVALIA;
  If FileExists(LDir) Then
  Begin
    TLogSeat.Log('Existe: ' + LDir);
    pSetStatus(stDefault);
    Exit;
  End;

  LDir := fRetornaDiretorioDeOperacao + '\' + cAVALIANDO;
  If FileExists(LDir) Then
  Begin
    TLogSeat.Log('Existe: ' + LDir);
    pSetStatus(stAvaliando);
    Exit;
  End;

  LDir := fRetornaDiretorioDeOperacao + '\' + cCONCLUIU;
  If FileExists(LDir) Then
  Begin
    TLogSeat.Log('Existe: ' + LDir);
    pSetStatus(stConcluiu);
    Exit(False);
  End;

  LDir := fRetornaDiretorioDeOperacao + '\' + cFALHOU;
  If FileExists(LDir) Then
  Begin
    TLogSeat.Log('Existe: ' + LDir);
    pSetStatus(stFalhou);
    Exit(False);
  End;

end;

class function TTecladoSEAT.fRetornaDiretorioDeOperacao: String;
  var
    LDir : String;
begin
  LDir   := fCfgSis('TECDIR', varString);
  Result := IIF(DirectoryExists(LDir), LDir, '');
end;

function TTecladoSEAT.fSetDadosDocumentoJaFoiAvaliado(const ANumDoc, AEspDoc, AEmpDoc: String): Boolean;
  const
    SELECT = 'SELECT COUNT(*) AS TOT, FGS_DESAVA, FGS_FALHOU FROM FGSEAT WHERE FGS_NUMDOC = :NUMDOC AND FGS_ESPDOC = :ESPDOC AND FGS_CODEMP = :EMPDOC';
  var
    LqryAux : TUniQuery;
    LCodAva : TCodigoAvaliacao;
begin

  Result := False;

  If ANumDoc.IsEmpty Then
    Exit;

  If AEspDoc.IsEmpty Then
    Exit;

  If AEmpDoc.IsEmpty Then
    Exit;

  If Not (AEspDoc.Equals('PD') Or AEspDoc.Equals('OR')) Then
    Exit;

  LqryAux := fCriaQuery;

  Try

    LqryAux.Close;
    LqryAux.SQL.Clear;
    LqryAux.SQL.Add(SELECT);
    LqryAux.ParamByName('NUMDOC').AsString := ANumDoc;
    LqryAux.ParamByName('ESPDOC').AsString := AEspDoc;
    LqryAux.ParamByName('EMPDOC').AsString := AEmpDoc;
    LqryAux.Open;

    If LqryAux.IsEmpty Then
      Exit;

    LCodAva := LCodAva.fRetCodVal(LqryAux.FieldByName('FGS_DESAVA').AsString);
    pSetCodAva(LCodAva);

    FStatus := IIF(LqryAux.FieldByName('FGS_FALHOU').AsString = 'S', stFalhou, stConcluiu);
    Result  := True;

  Finally
    FreeAndNil(LqryAux);
  End;

end;

function TTecladoSEAT.fEmOperacao: Boolean;
begin

  Result := True;

  If (FStatus in [stAvaliando, stConcluiu, stFalhou]) Then
    Exit;

  Result := False;

end;

class function TTecladoSEAT.fUtilizaIntegracaoComTecladoDeSatisfacaoSEAT(AOrigem: TOrigemAvaliacao = oaAmbos) : Boolean;
begin

  Result := False;

  If fRetornaDiretorioDeOperacao.IsEmpty Then
    Exit;

  Case AOrigem Of
    oaCaixa      : Result := fCfgSis('TECSAT', varBoolean);
    oaAutoCenter : Result := fCfgSis('TECCEN', varBoolean);
    oaAmbos      : Result := fCfgSis('TECSAT', varBoolean) Or fCfgSis('TECCEN', varBoolean);
  End;

end;

procedure TTecladoSEAT.pSetCodAva(const AValue: TCodigoAvaliacao);
begin
  FCodAva := AValue;
end;

procedure TTecladoSEAT.pSetEmpDoc(const AValue: String);
begin
  FEmpDoc := AValue;
end;

procedure TTecladoSEAT.pSetEspDoc(const AValue: String);
begin
  FEspDoc := AValue;
end;

procedure TTecladoSEAT.pSetNumDoc(const AValue: String);
begin
  FNumDoc := AValue
end;

procedure TTecladoSEAT.pSetStatus(const AValue: TStatusTeclado);
  const
    IDX_STATUS = 0;
    IDX_COR    = 1;
  var
    LParameters : array of String;
begin

  FStatus := AValue;

  SetLength(LParameters, 2);
  LParameters[IDX_STATUS] := FStatus.fRetMSG_;
  LParameters[IDX_COR]    := FStatus.fRetCor_;

  pNotify(LParameters, True);

end;

{ TCodigoAvaliacaoHelper }

function TCodigoAvaliacaoHelper.fRetCodVal(AValue: String): TCodigoAvaliacao;
  var
    strDescricao : String;
begin

  strDescricao := AnsiUpperCase(AValue);
  strDescricao := fRemoveAcento(strDescricao);

  If strDescricao.Equals('RUIM') Then
    Exit(caRuim);

  If strDescricao.Equals('REGULAR') Then
    Exit(caRegular);

  If strDescricao.Equals('BOM') Then
    Exit(caBom);

  If strDescricao.Equals('OTIMO') Then
    Exit(caOtimo);

  If strDescricao.Equals('EXPIROU') Then
    Exit(caExpirou);

  Result := caNaoDefinido;

end;

function TCodigoAvaliacaoHelper.fRetCodVal: Integer;
begin
  Case Self Of
    caRuim    : Result := 0;
    caRegular : Result := 1;
    caBom     : Result := 2;
    caOtimo   : Result := 3;
    caExpirou : Result := 5;
    Else
      Result := 4;
  End;
end;

function TCodigoAvaliacaoHelper.fRetNome: String;
begin
  Case Self Of
    caRuim    : Result := 'Ruim';
    caRegular : Result := 'Regular';
    caBom     : Result := 'Bom';
    caOtimo   : Result := 'Ótimo';
    caExpirou : Result := 'Expirou';
    Else
      Result := 'Não Definido';
  End;
end;

{ TStatusTecladoHelper }

function TStatusTecladoHelper.fRetCor_: String;
  const
    VERMELHO = 'VERMELHO';
    VERDE    = 'VERDE';
begin
  Case Self Of
    stDefault   : Result := VERMELHO;
    stAvaliando : Result := VERMELHO;
    stConcluiu  : Result := VERDE;
    stFalhou    : Result := VERMELHO;
  end;
end;

function TStatusTecladoHelper.fRetMSG_: String;
begin
  Case Self Of
    stDefault   : Result := 'Teclado de Satisfação: Avaliação Pendente';
    stAvaliando : Result := 'Teclado de Satisfação: Avaliando...';
    stConcluiu  : Result := 'Teclado de Satisfação: Avaliação Realizada';
    stFalhou    : Result := 'Teclado de Satisfação: Falhou';
  end;
end;

function TStatusTecladoHelper.fRetNome: String;
begin
  Case Self Of
    stDefault   : Result := 'Avaliação Pendente';
    stAvaliando : Result := 'Avaliando';
    stConcluiu  : Result := 'Concluiu';
    stFalhou    : Result := 'Falhou';
  end;
end;

{ TLogSeat }

class function TLogSeat.AptoAEfetivarLog: Boolean;
begin
  Result := False;

  If (Not TLogSeat.Iniciou) Then
    Exit;

  If (TLogSeat.Desligado) Then
    Exit;

  If (strLoginUsuarioLogado.IsEmpty) Then
    Exit;

  Result := True;
end;

class function TLogSeat.ArquivosNoDiretorio: String;
  var
    strDiretorio : String;
    stlArquivos : TStringList;
begin
  Result := EmptyStr;

  Try
    strDiretorio := TTecladoSeat.fRetornaDiretorioDeOperacao;
  Except
    Exit;
  End;

  If (strDiretorio.IsEmpty) Then
    Exit;

  If (Not DirectoryExists(strDiretorio)) Then
    Exit;

  If (Not strDiretorio.EndsWith('\')) Then
    strDiretorio := strDiretorio + '\';

  strDiretorio := strDiretorio + '*.*';

  stlArquivos := fRetArquivosDir(strDiretorio);
  Try
    Result := stlArquivos.CommaText;
  Finally
    FreeAndNil(stlArquivos);
  End;
end;

class procedure TLogSeat.Inicializar;
begin
  If TLogSeat.Iniciou Then
    Exit;

  TLogSeat.Iniciou := True;
  If (Not fTabelaExiste('LOG_TECLADO_SEAT', True)) Then
  Begin
    TLogSeat.Desligado := True;
    Exit;
  End;
end;

class procedure TLogSeat.Log(const strTexto: String);
  var
    qryLogSeat : TUniQuery;
    strSQL : String;
    strArquivosNoDiretorio : String;
begin
  TLogSeat.Inicializar;

  If (Not TLogSeat.AptoAEfetivarLog) Then
    Exit;

  qryLogSeat := fCriaQuery(nil);
  Try
    strArquivosNoDiretorio := TLogSeat.ArquivosNoDiretorio;
    strSQL := EmptyStr;
    strSQL := strSQL + ' INSERT INTO LOG_TECLADO_SEAT (DATA, HORA, OPERADOR, TEXTO ) ';
    strSQL := strSQL + ' VALUES (:DATA, :HORA, :OPERADOR, :TEXTO) ';
    qryLogSeat.SQL.Text := strSQL;
    qryLogSeat.ParamByName('DATA').AsDate := VS_Date;
    qryLogSeat.ParamByName('HORA').AsTime := fRetHoraServidor;
    qryLogSeat.ParamByName('OPERADOR').AsString := strLoginUsuarioLogado;
    qryLogSeat.ParamByName('TEXTO').AsString := strTexto + ' / Arquivos no Diretorio: ' + strArquivosNoDiretorio;
    qryLogSeat.ExecSQL;
  Finally
    FreeAndNil(qryLogSeat);
  End;
end;

initialization
  TLogSeat.Iniciou := False;
  TLogSeat.Desligado := False;

end.
