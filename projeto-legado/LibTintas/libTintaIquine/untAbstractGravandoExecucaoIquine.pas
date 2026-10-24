{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Iquine *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoIquine;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, Uni,
  untIConfTinta, UniClientDataSet, System.Classes, untIDataSet;

type
  TAbstractGravandoExecucaoIquine = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    cdsDados     : TUniClientDataSet;
    conf         : IConfTinta;
    slArquivo    : TStringList;
    slQuebraLinha: TStringList;
    function GetUnidade(const fltVolume: Double): string;
    function fFormataAutInc(const intAutInc: Integer): String;
    function fValidaPath : Boolean;
    function GetPath : String;
    procedure CarregarDados(const gravando: IGravando);
    procedure ProcessaDados(qryTmp: IDataSet; const gravando: IGravando);
    procedure pCriarTemporaria;
    function fTabelaExiste(strNomeTabela: String; Conexao: TUniConnection = Nil): Boolean;
    function fDropTable(strNomeTabela: String; Conexao: TUniConnection = Nil): Boolean;

  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;

implementation

uses
  untAutcomTintaFactory, untStrUtils;

{ TGravandoExecucaoIquineCores }


procedure TAbstractGravandoExecucaoIquine.CarregarDados(
  const gravando: IGravando);
Var
  qryTmp      : IDataSet;
begin
  If Not FileExists(GetPath)  Then
  Begin
    gravando.Texto := 'Arquivo para a geração não é válido...';
    gravando.Cancelar;
    Exit;
  End;

  If Not (fTabelaExiste('TMP_CORES_IQU')) Then
  Begin
    gravando.Texto := 'Arquivo Validado com Sucesso ...';

    gravando.Texto := 'Iniciando a geração da tabela temporária ...';

    Try
      slArquivo     := TStringList.Create;
      slQuebraLinha := TStringList.Create;

      slArquivo.LoadFromFile(GetPath);

      pCriarTemporaria;

      qryTmp := TAutcomTintaFactory.Get.fGetDataSet;
      qryTmp.SQL := 'SELECT * '+
                    '  FROM TMP_CORES_IQU '+
                    ' WHERE FALSE;';
      qryTmp.Open;

      ProcessaDados(qryTmp, Gravando);
    Finally
    End;
  End;
end;

constructor TAbstractGravandoExecucaoIquine.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('IQU');
end;

destructor TAbstractGravandoExecucaoIquine.Destroy;
begin
  inherited;

  If (fTabelaExiste('TMP_CORES_IQU')) Then
    fDropTable('TMP_CORES_IQU');

  If Assigned(slArquivo) Then FreeAndNil(slArquivo);
  If Assigned(slQuebraLinha) Then FreeAndNil(slQuebraLinha);
end;

function TAbstractGravandoExecucaoIquine.fDropTable(strNomeTabela: String;
  Conexao: TUniConnection): Boolean;
var
  qryTmp : IDataSet;
begin
  Result := True;

  qryTmp := TAutcomTintaFactory.Get.fGetDataSet;
  qryTmp.SQL := ' DROP TABLE ' + strNomeTabela;

  Try
    If Not fTabelaExiste(strNomeTabela, Conexao) Then
      Exit;

    qryTmp.ExecSQL;
  Except
    On E: Exception Do
    Begin
      Result := False;
    End;
  End;
end;

function TAbstractGravandoExecucaoIquine.fFormataAutInc(
  const intAutInc: Integer): String;
begin
  Result := TAutcomTintaFactory.Get.GetCodEmp + TStrUtils.fPadL(IntToStr(intAutInc) + TAutcomTintaFactory.Get.GetCodEmp, 17, '0');
end;

function TAbstractGravandoExecucaoIquine.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoIquine.fTabelaExiste(strNomeTabela: String;
  Conexao: TUniConnection): Boolean;
Var
  qryGenTmp: IDataSet;
begin
  Result := False;

  qryGenTmp := TAutcomTintaFactory.Get.fGetDataSet;

  Try
    If (TStrUtils.fEmptyStr(strNomeTabela)) Then
      Exit;

    qryGenTmp.SQL := 'DESC ' + strNomeTabela;
    qryGenTmp.Open;

    Result := True;

  Except
    On E: Exception do
    Begin
      Result := False;
    End;
  End;
end;

function TAbstractGravandoExecucaoIquine.fValidaPath : Boolean;

begin
  Result := True;

  If (Not FileExists(GetPath)) Then
    Result := false;
end;

function TAbstractGravandoExecucaoIquine.GetPath: String;
begin
  Result := conf.fGet('PATIQU');
end;

function TAbstractGravandoExecucaoIquine.GetUnidade(
  const fltVolume: Double): string;
begin
  If RoundTo(fltVolume, -3) <= 0.9 Then
    Result := 'LT'
  Else If RoundTo(fltVolume, -3) <= 3.6 Then
    Result := 'GL'
  Else
    Result := 'LA';
end;

procedure TAbstractGravandoExecucaoIquine.pCriarTemporaria;
var
  qryTmp : IDataSet;
begin
  qryTmp := TAutcomTintaFactory.Get.fGetDataSet;
  qryTmp.SQL :=  'CREATE TEMPORARY  TABLE TMP_CORES_IQU '+
                 '   (COD_COR    VARCHAR(15), '+
                 '    COLECAO    VARCHAR(50), '+
                 '    NOME_COR   VARCHAR(50), '+
                 '    OBSERVACAO VARCHAR(60), '+
                 '    PRODUTO    VARCHAR(60), '+
                 '    BASE       VARCHAR(10), '+
                 '    EMBALAGEM  VARCHAR(10), '+
                 '    CAPACIDADE VARCHAR(10), '+
                 '    CORANTE    VARCHAR(10), '+
                 '    MLS        VARCHAR(10)) ';
  qryTmp.ExecSQL;
end;

procedure TAbstractGravandoExecucaoIquine.ProcessaDados(qryTmp: IDataSet;
  const gravando: IGravando);
Var
  intCont: Integer;
begin
  for intCont := 0 to slArquivo.Count - 1 do
  begin
    If intCont = 0 Then
      Continue;

    slQuebraLinha.Delimiter := ';';
    slQuebraLinha.StrictDelimiter := True;
    slQuebraLinha.DelimitedText := slArquivo[intCont];

    qryTmp.Insert;
    qryTmp.FieldByName('COLECAO').AsString    := slQuebraLinha[0];
    qryTmp.FieldByName('COD_COR').AsString    := slQuebraLinha[1];
    qryTmp.FieldByName('NOME_COR').AsString   := slQuebraLinha[2];
    qryTmp.FieldByName('OBSERVACAO').AsString := slQuebraLinha[3];
    qryTmp.FieldByName('PRODUTO').AsString    := slQuebraLinha[4];
    qryTmp.FieldByName('BASE').AsString       := slQuebraLinha[5];
    qryTmp.FieldByName('EMBALAGEM').AsString  := slQuebraLinha[6];
    qryTmp.FieldByName('CAPACIDADE').AsString := slQuebraLinha[7];
    qryTmp.FieldByName('CORANTE').AsString    := slQuebraLinha[8];
    qryTmp.FieldByName('MLS').AsString        := slQuebraLinha[9];
    qryTmp.Post;

    gravando.RegistrarProgresso(0, intCont, slArquivo.Count);
  end;
end;

end.
