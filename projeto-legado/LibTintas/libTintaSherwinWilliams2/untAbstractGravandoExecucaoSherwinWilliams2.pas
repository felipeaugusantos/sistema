{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta SHWcolor *}
{********************************************************************************PH*}
unit untAbstractGravandoExecucaoSherwinWilliams2;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, Uni,
  untIConfTinta, UniClientDataSet, System.Classes, untIDataSet,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Vcl.Forms;

type
  TAbstractGravandoExecucaoSherwinWilliams2 = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    cdsDados     : TUniClientDataSet;
    conf         : IConfTinta;
    slArquivo    : TStringList;
    slQuebraLinha: TStringList;
    qryConf: TUniQuery;
    FDatabase : String;
    FUser_Name: String;
    FPassword : String;
    FPort     : String;
    FServer   : String;
    FDriverID : String;

    class function LimpaTexto(const strTexto: string): string;
    function GetUnidade(const fltVolume: Double): string;
    function fFormataAutInc(const intAutInc: Integer): String;
    function fValidaPath : Boolean;
    function GetPath : String;
    procedure CarregarDados(const gravando: IGravando);
    procedure pCriarTemporaria;
    function fInsertTemporaria(): String;
    function fTabelaExiste(strNomeTabela: String; Conexao: TUniConnection = Nil): Boolean;
    function fDropTable(strNomeTabela: String; Conexao: TUniConnection = Nil): Boolean;
    function fContaLinhas(strNomArq: String): Integer;
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

{ TGravandoExecucaoSherwinWilliams2Cores }

procedure TAbstractGravandoExecucaoSherwinWilliams2.CarregarDados(const gravando: IGravando);
Var
  qryTmp      : IDataSet;
  Arquivo     : TextFile;
  strLinha: String;
  iRecordCount: Integer;
  intLinha: Integer;
  intCont: Integer;
  FDDatabase  : TFDConnection;
  FDDriverLink: TFDPhysMySQLDriverLink;
  FDCursor    : TFDGUIxWaitCursor;
  qryCores    : TFDQuery;
  intContador : Integer;
  intQtd      : Integer;
begin

  If Not FileExists(GetPath)  Then
  Begin
    gravando.Texto := 'Arquivo para a geração não é válido...';
    gravando.Cancelar;
    Exit;
  End;

  If Not (fTabelaExiste('TMP_CORES_SHW')) Then
  Begin
    gravando.Texto := 'Arquivo Validado com Sucesso ...';

    gravando.Texto := 'Iniciando a geração da tabela temporária ...';

    Try
       FDDatabase   := TFDConnection.Create(Nil);
       FDDriverLink := TFDPhysMySQLDriverLink.Create(Nil);
       FDCursor     := TFDGUIxWaitCursor.Create(Nil);
       qryCores     := TFDQuery.Create(Nil);


       FDDatabase.Params.Add(FDatabase);
       FDDatabase.Params.Add(FUser_Name);
       FDDatabase.Params.Add(FPassword);
       FDDatabase.Params.Add(FPort);
       FDDatabase.Params.Add(FServer);
       FDDatabase.Params.Add(FDriverID);

       if FileExists(ExtractFilePath(Application.ExeName) + 'libmysql57.dll') then
         FDDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql57.dll'
       else
         FDDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql41.dll';

       FDDatabase.Connected := True;

      pCriarTemporaria;

      qryCores.Connection := FDDatabase;
      qryCores.SQL.Text := fInsertTemporaria();

      qryTmp := TAutcomTintaFactory.Get.fGetDataSet;
      qryTmp.SQL := 'SELECT * '+
                    '  FROM TMP_CORES_SHW '+
                    ' WHERE FALSE;';
      qryTmp.Open;

      iRecordCount  := fContaLinhas(GetPath);
      intLinha      := 1;
      intCont := iRecordCount;
      slArquivo     := TStringList.Create;
      slArquivo.StrictDelimiter := True;
      slArquivo.Delimiter := ';';

      AssignFile(Arquivo, GetPath);
      Reset(Arquivo);

      While Not Eof(Arquivo) Do
      begin
        qryCores.Params.ClearValues();
        qryCores.Params.ArraySize := 5000;
        intQtd := 0;


        For intContador := 1 To Pred(5000) Do
        Begin
          ReadLn(Arquivo, strLinha);
          slArquivo.DelimitedText := strLinha;


          If slArquivo[0] <> 'COLECAO' Then
          Begin
            qryCores.ParamByName('COD_COR').AsStrings[intQtd]    := LimpaTexto(slArquivo[1]);
            qryCores.ParamByName('NOME_COR').AsStrings[intQtd]   := LimpaTexto(slArquivo[2]);
            qryCores.ParamByName('OBSERVACAO').AsStrings[intQtd] := LimpaTexto(slArquivo[3]);
            qryCores.ParamByName('PRODUTO').AsStrings[intQtd]    := slArquivo[4];
            qryCores.ParamByName('BASE').AsStrings[intQtd]       := slArquivo[5];
            qryCores.ParamByName('EMBALAGEM').AsStrings[intQtd]  := slArquivo[6];
            qryCores.ParamByName('CAPACIDADE').AsStrings[intQtd] := slArquivo[7];
            qryCores.ParamByName('CORANTE').AsStrings[intQtd]    := slArquivo[8];
            qryCores.ParamByName('MLS').AsStrings[intQtd]        := slArquivo[10];
            Inc(intQtd, 1);
          End;

          If Eof(Arquivo) Then
            Break;

          Inc(intLinha);
          Gravando.RegistrarProgresso(1, intLinha, intCont - 1);
        End;

        qryCores.Execute(intQtd, 0);
      end;
    Finally
      FreeAndNil(FDDatabase);
      FreeAndNil(FDCursor);
      FreeAndNil(qryCores);
      FreeAndNil(FDDriverLink);
    End;
  End;

end;

constructor TAbstractGravandoExecucaoSherwinWilliams2.Create;
begin
  inherited Create;

  conf := TAutcomTintaFactory.Get.fGetConfTinta('SHW');

  qryConf := TAutcomTintaFactory.Get.fCriaQuery();

  FDriverID  := 'DriverID=MySQL';
  FDatabase  := 'Database=' + qryConf.Connection.Database;
  FUser_Name := 'User_Name=' + qryConf.Connection.Username;
  FPassword  := 'Password=' + qryConf.Connection.Password;
  FPort      := 'Port=' + IntToStr(qryConf.Connection.Port);
  FServer    := 'Server=' + qryConf.Connection.Server;

  FreeAndNil(qryConf);

  If (fTabelaExiste('TMP_CORES_SHW')) Then
    fDropTable('TMP_CORES_SHW');
end;


function TAbstractGravandoExecucaoSherwinWilliams2.fContaLinhas(
  strNomArq: String): Integer;
Var
  Arquivo: TextFile;
begin
  Result := 0;
  AssignFile(Arquivo, strNomArq);
  Reset(Arquivo);

  While Not Eof(Arquivo) Do
  Begin
    Readln(Arquivo);
    Result := Result + 1;
  End;

  CloseFile(Arquivo);
end;

function TAbstractGravandoExecucaoSherwinWilliams2.fDropTable(strNomeTabela: String; Conexao: TUniConnection = Nil): Boolean;
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

destructor TAbstractGravandoExecucaoSherwinWilliams2.Destroy;
begin
  inherited;

  If (fTabelaExiste('TMP_CORES_SHW')) Then
    fDropTable('TMP_CORES_SHW');

  If Assigned(slArquivo) Then FreeAndNil(slArquivo);
  If Assigned(slQuebraLinha) Then FreeAndNil(slQuebraLinha);
end;

function TAbstractGravandoExecucaoSherwinWilliams2.fFormataAutInc(const intAutInc: Integer): String;
begin
  Result := TAutcomTintaFactory.Get.GetCodEmp + TStrUtils.fPadL(IntToStr(intAutInc) + TAutcomTintaFactory.Get.GetCodEmp, 17, '0');
end;

function TAbstractGravandoExecucaoSherwinWilliams2.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoSherwinWilliams2.fInsertTemporaria: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO TMP_CORES_SHW(    ';
  Result := Result + '    COD_COR,                    ';
  Result := Result + '    NOME_COR,                   ';
  Result := Result + '    OBSERVACAO,                 ';
  Result := Result + '    PRODUTO,                    ';
  Result := Result + '    BASE,                       ';
  Result := Result + '    EMBALAGEM,                  ';
  Result := Result + '    CAPACIDADE,                 ';
  Result := Result + '    CORANTE,                    ';
  Result := Result + '    MLS)                        ';
  Result := Result + '  VALUES(                       ';
  Result := Result + '    :COD_COR,                   ';
  Result := Result + '    :NOME_COR,                  ';
  Result := Result + '    :OBSERVACAO,                ';
  Result := Result + '    :PRODUTO,                   ';
  Result := Result + '    :BASE,                      ';
  Result := Result + '    :EMBALAGEM,                 ';
  Result := Result + '    :CAPACIDADE,                ';
  Result := Result + '    :CORANTE,                   ';
  Result := Result + '    :MLS);                      ';
end;

function TAbstractGravandoExecucaoSherwinWilliams2.fTabelaExiste(
  strNomeTabela: String; Conexao: TUniConnection): Boolean;
Var
  qryGenTmp: IDataSet;
Begin
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

function TAbstractGravandoExecucaoSherwinWilliams2.fValidaPath : Boolean;
begin
  Result := True;

  If (Not FileExists(GetPath)) Then
    Result := false;
end;


function TAbstractGravandoExecucaoSherwinWilliams2.GetPath: String;
begin
  Result := conf.fGet('PATSHW');
end;

function TAbstractGravandoExecucaoSherwinWilliams2.GetUnidade(const fltVolume: Double): string;
begin
  if RoundTo(fltVolume, -3) <= 0.9 then
    Result := 'LT'
  else if RoundTo(fltVolume, -3) <= 3.6 then
    Result := 'GL'
  else
    Result := 'LA';
end;

class function TAbstractGravandoExecucaoSherwinWilliams2.LimpaTexto(
  const strTexto: string): string;
begin
  Result := AnsiUpperCase(Trim(TAutcomTintaFactory.Get.fRemoveAcento(strTexto)));
end;

procedure TAbstractGravandoExecucaoSherwinWilliams2.pCriarTemporaria;
var
  qryTmp : IDataSet;
begin
  qryTmp := TAutcomTintaFactory.Get.fGetDataSet;
  qryTmp.SQL :=  'CREATE TABLE TMP_CORES_SHW '+
                 '   (COD_COR    VARCHAR(50), '+
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

end.
