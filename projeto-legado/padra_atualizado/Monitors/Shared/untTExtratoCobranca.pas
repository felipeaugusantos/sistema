unit untTExtratoCobranca;

interface

uses System.Classes,System.SysUtils,Forms,untTypesSistema,untFuncoesSimples,
     System.StrUtils,System.IOUtils,Winapi.Windows,Uni;
Type
  TMonitorExtratoCobranca = class
  strict private
    class function GetExeName: String; static;
  public
    const
      ID_MONITOR = 'MONITOR_ENVIO_EXTRATO_COBRANCA_%s_%s';
      ID_INATIVIDADE_MONITOR = 'TESTE_INATIVIDADE_EXTRATO_COBRANCA_%s';
      TEMPO_LIMITE_MONITOR = 30;
      TENTATIVAS_LOCK_MONITOR = 30;
      PARAMETROS = '%s %s %s';

    class var ProcessoMonitor: TProcessInformation;
    class var DataUltimaExecucaoMonitor: TDateTime;
    class var Operador: String;

    class property ExeName: string read GetExeName;
  end;


  function ExiteExtratoParaSeremEnviados(Var AListaExtratos: TStringList): Boolean;
  function CarregaVariaveisEmail(AExtrato:String):TDadosDisparaEmail;
  function RetornaDiretorioAEnviar:String;
  function RetornaDiretorioEnviados:String;
  function RetornaDiretorioNaoEnviados:String;
  procedure MoverArquivoPasta(AArquivo:String; AEnviou:String);
  function ExecutarRobo:Boolean;
  function fQuantidadeRobosDeMonitaramentoExecutando(ALike: String = '.MONITOR_'): Integer;

Var
  MonitorExtratoCobranca: TMonitorExtratoCobranca;

implementation

function fQuantidadeRobosDeMonitaramentoExecutando(ALike: String = '.MONITOR_'): Integer;
  Var
    qryLock: TUniQuery;
Begin
  qryLock := fCriaQuery(Nil);
  With qryLock Do
  Begin
    SQL.Add('SELECT SQL_NO_CACHE COUNT(0) FROM LCKATC WHERE LCK_CHAACE LIKE "%' + ALike +'%" ');
    Open;
    Result := Fields[0].AsInteger;
  End;
  FreeAndNil(qryLock);
end;

function ExecutarRobo:Boolean;
  Var
    LMonitorExtratoCobranca: TMonitorExtratoCobranca;
    LIDMOnitor: String;
Begin
  Result := True;
  Try
    LMonitorExtratoCobranca := TMonitorExtratoCobranca.Create;
    LIDMonitor := LMonitorExtratoCobranca.ID_MONITOR;
    LIDMonitor := Format(LIDMonitor, ['%', '%']);

    If (fQuantidadeRobosDeMonitaramentoExecutando('MONITOR_EXTRATO_COBRANCA_ATIVADO') = 0) Then
      Exit(False);

    If Not (fQuantidadeRobosDeMonitaramentoExecutando(LIDMonitor) < fCfgSis('MAXETC', VarInteger)) Then
      Exit(False);

  Finally
    FreeAndNil(LMonitorExtratoCobranca);
  End;
End;

procedure MoverArquivoPasta(AArquivo:String; AEnviou:String);
  Var
    LDiretorio : String;
Begin
  LDiretorio := IIF((AEnviou = 'N'),RetornaDiretorioNaoEnviados,RetornaDiretorioEnviados);
  LDiretorio := LDiretorio + AArquivo;
  AArquivo := RetornaDiretorioAEnviar + AArquivo;

  If System.IOUtils.TFile.Exists(LDiretorio) Then
    System.IOUtils.TFile.Delete(LDiretorio);

  System.IOUtils.TFile.Move(AArquivo, LDiretorio);
End;

function RetornaDiretorioNaoEnviados:String;
  Var
    LDiretorio:String;
Begin
  LDiretorio := ExtractFilePath(Application.ExeName) + 'EXTRATO COBRANCA NAO ENVIADOS\';

  If Not DirectoryExists(LDiretorio) Then
    CreateDir(ExtractFilePath(LDiretorio));

  Result := LDiretorio
End;

function RetornaDiretorioEnviados:String;
  Var
    LDiretorio:String;
Begin
  LDiretorio := ExtractFilePath(Application.ExeName) + 'EXTRATO COBRANCA ENVIADOS\';

  If Not DirectoryExists(LDiretorio) Then
    CreateDir(ExtractFilePath(LDiretorio));

  Result := LDiretorio
End;

function RetornaDiretorioAEnviar:String;
  Var
    LDiretorio:String;
Begin
  LDiretorio := ExtractFilePath(Application.ExeName) + 'EXTRATO PARA COBRANCA\';

  If Not DirectoryExists(LDiretorio) Then
    CreateDir(ExtractFilePath(LDiretorio));

  Result := LDiretorio
End;

function CarregaVariaveisEmail(AExtrato:String):TDadosDisparaEmail;
  Var
    LDiretorio: String;
    recArquivos: TArray<TRecArquivosGatilhos>;
Begin
  Result.strCodCli   := Copy(AExtrato, Pos('_', AExtrato) + 1, 8);
  Result.strEmailCli := fRetornaEmailsCobrancaCliente(Result.strCodCli);

  LDiretorio := RetornaDiretorioAEnviar + AExtrato;

  SetLength(recArquivos, Length(recArquivos)+1);
  recArquivos[High(recArquivos)] := TRecArquivosGatilhos.Create('EXTRATO', LDiretorio, EmptyStr);

  Result.RecArquivos := recArquivos;
End;

function ExiteExtratoParaSeremEnviados(Var AListaExtratos: TStringList): Boolean;
var
  I: Integer;
  SearchRec: TSearchRec;
  LDiretorio: String;
begin
  Result := False;
  LDiretorio := RetornaDiretorioAEnviar;

  AListaExtratos := TStringList.Create;
  try
    I := FindFirst(LDiretorio + '*.pdf' , 0, SearchRec);
    while I = 0 do
    begin
      Result := True;
      AListaExtratos.Add(SearchRec.Name);
      I := FindNext(SearchRec);
    end;
  except
    //
  end;
end;

{ TMonitorExtratoCobranca }

class function TMonitorExtratoCobranca.GetExeName: String;
begin
  Result := 'EnviaEmailBoletoMonitor.exe';
end;

end.
