{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta ProfissionalAutomotiva *}
{********************************************************************************PH*}
unit untAbstractGravandoExecucaoProfissionalAutomotiva;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untIConfTinta, untIDataSet, Classes, untStatusGravando, Windows,
  ActiveX, Uni, UniClientDataSet, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Vcl.Forms, Winapi.ShellAPI;

type
  TAbstractGravandoExecucaoProfissionalAutomotiva = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    cdsBases: TUniClientDataSet;
    cdsCatali: TUniClientDataSet;
    FPastas: TStringList;
    FNomeArqBases,
    FNomeArqFormulas,
    FNomeCatalisadoresBases: String;
    FDatabase : String;
    FUser_Name: String;
    FPassword : String;
    FPort     : String;
    FServer   : String;
    FDriverID : String;
    slArquivo    : TStringList;

    procedure pCriarTemporariaCores;
    procedure pCriarTemporariaBasesCatalisadores;
    procedure pCarregarCores(const Gravando: IGravando; AArquivo: String);
    procedure pCarregarBasesCatalisadores(const Gravando: IGravando; AArquivo: String);
    function fInsertTemporariaCores(): String;
    function fInsertTemporariaBasesCatalisadores(): String;
    procedure pCarregarBases(const Gravando: IGravando; intPasta: Integer);
    procedure pCarregarCatalisadores(const Gravando: IGravando; intPasta: Integer);
    Procedure pCriarDataSetBases;
    Procedure pCriarDataSetCatalisadores;
    class function LimpaTexto(const strTexto: string): string;
    function fContaLinhas(strNomArq: String): Integer;
    function fValidarPath(intPasta: Integer): Boolean;
    function LimpaCaracteres(const strTexto: string): string;
    procedure GetTabelas(const qryOrigem: TADOQuery; const stlTabelas: TStrings);
    procedure Animar(const gravando: IGravando);
    procedure CarregarDados(const gravando: IGravando; var qryOrigem: TDataSet;
      const strNomeArquivo: string; var qryDestino: IDataSet);
    function fTipoColecao(AContador: Integer): String;
    //Abstract
    function GetAdoQuery(var strNomeArquivo:String):TADOQuery; virtual; abstract;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; virtual; abstract;
    function GetSqlDestino(): string; virtual; abstract;
    function fGetPath(intPasta: Integer): String; virtual; abstract;
    function IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList): Boolean; virtual; abstract;
    procedure GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList); virtual; abstract;
    //Virtuais
    function GetDataSetOrigem(const strNomeArquivo: string): TDataSet; virtual;
    function GetDataSetDestino(): IDataSet; virtual;
    procedure AtribuirDiretorios(Diretorio: String);
    function TemAtributo(Attr, Val: Integer): Boolean;
    procedure ListarArquivo(strDiretorio: String);
  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;

  TDataSetHelper = Class Helper For TDataSet
  public
    procedure Filtrar(const strFiltro: string);
  end;

  TProcedureGravandoExecucao = procedure (const gravando: IGravando) Of Object;
  TGetDataSetOrigem =  function (const strNomeArquivo: string): TDataSet Of Object;
  TGetDataSetDestino = function(): IDataSet Of Object;

  TThreadCarregar = class(TThread)
  private
    GetDataSetOrigem: TGetDataSetOrigem;
    GetDataSetDestino: TGetDataSetDestino;
    strNomeArquivo: string;
    dataSetOrigem: TDataSet;
    dataSetDestino: IDataSet;
  protected
    procedure Execute; override;
  public
    constructor Create(const GetDataSetOrigem: TGetDataSetOrigem; const GetDataSetDestino: TGetDataSetDestino;
      const strNomeArquivo: string); reintroduce;
    destructor Destroy; override;

    property Origem: TDataSet read dataSetOrigem;
    property Destino: IDataSet read dataSetDestino;
  end;


implementation

uses
  untAutcomTintaFactory, untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt,
  untDefinicaoTxtCharacterSet, untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo,
  untDefinicaoTxtCampoTipo, untADOTxtFactory, StrUtils;

{ TGravandoExecucaoProfissionalAutomotivaCores }


procedure TAbstractGravandoExecucaoProfissionalAutomotiva.Animar(const gravando: IGravando);
begin
  Gravando.AnimarEsperar;
  Sleep(100);
end;

procedure TAbstractGravandoExecucaoProfissionalAutomotiva.AtribuirDiretorios(
  Diretorio: String);
Var
  F: TSearchRec;
  Retorno: Integer;
begin
  //Inicia a Busca
  Retorno := FindFirst(Diretorio + '\*.*', faAnyFile, F);
  FPastas.Clear;
  Try
    While Retorno = 0 Do
    Begin
      If (F.Name <> '.') Then
      Begin
        If F.Name <> '..' Then
        Begin
          If TemAtributo(F.Attr, faDirectory) Then
            FPastas.Add(F.Name);
        End;
      End;
      Retorno := FindNext(F);
    End;
  Finally
  End;
end;

procedure TAbstractGravandoExecucaoProfissionalAutomotiva.CarregarDados(
  const gravando: IGravando; var qryOrigem: TDataSet;
  const strNomeArquivo: string; var qryDestino: IDataSet);
Var
  ThreadCarregar: TThreadCarregar;
begin
  ThreadCarregar := Nil;
  Try
    Try
      ThreadCarregar := TThreadCarregar.Create(GetDataSetOrigem,
        GetDataSetDestino, strNomeArquivo);

      While Not ThreadCarregar.Terminated Do
      Begin
        If Gravando.Status in [sgCancelado, sgFinalizado] Then
        Begin
          ThreadCarregar.Terminate;
          TerminateThread(ThreadCarregar.Handle, 0);
        End
        Else
          Animar(Gravando);

        ThreadCarregar.WaitFor;
        qryOrigem  := ThreadCarregar.Origem;
        qryDestino := ThreadCarregar.Destino;
      End;
    Except
      On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally
    If Assigned(ThreadCarregar) Then FreeAndNil(ThreadCarregar);
  End;
end;

constructor TAbstractGravandoExecucaoProfissionalAutomotiva.Create;
Var
  qryConf : TUniQuery;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('PFA');
  FPastas := TStringList.Create();
  pCriarDataSetBases;
  pCriarDataSetCatalisadores;
  AtribuirDiretorios(Conf.fGet('PATPFA'));

  qryConf := TAutcomTintaFactory.Get.fCriaQuery();
  FDriverID  := 'DriverID=MySQL';
  FDatabase  := 'Database=' + qryConf.Connection.Database;
  FUser_Name := 'User_Name=' + qryConf.Connection.Username;
  FPassword  := 'Password=' + qryConf.Connection.Password;
  FPort      := 'Port=' + IntToStr(qryConf.Connection.Port);
  FServer    := 'Server=' + qryConf.Connection.Server;
  FreeAndNil(qryConf);
end;

destructor TAbstractGravandoExecucaoProfissionalAutomotiva.Destroy;
begin
  inherited;

  If Assigned(FPastas) Then
    FreeAndNil(FPastas);

  If Assigned(cdsBases) Then
    FreeAndNil(cdsBases);

  If Assigned(cdsCatali) Then
    FreeAndNil(cdsCatali);

  If Assigned(slArquivo) Then FreeAndNil(slArquivo);

  TAutcomTintaFactory.Get.DropTable('TMP_CORES_PFA');
  TAutcomTintaFactory.Get.DropTable('TMP_CATALISADORES_PFA');
end;


function TAbstractGravandoExecucaoProfissionalAutomotiva.fContaLinhas(
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

function TAbstractGravandoExecucaoProfissionalAutomotiva.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoProfissionalAutomotiva.fInsertTemporariaBasesCatalisadores: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO TMP_CATALISADORES_PFA(    ';
  Result := Result + '    CAT_CODBAS,                 ';
  Result := Result + '    CAT_CODCAT,                 ';
  Result := Result + '    CAT_TIPBAS)                 ';
  Result := Result + '  VALUES(                       ';
  Result := Result + '    :CAT_CODBAS,                ';
  Result := Result + '    :CAT_CODCAT,                ';
  Result := Result + '    :CAT_TIPBAS);               ';
end;

function TAbstractGravandoExecucaoProfissionalAutomotiva.fInsertTemporariaCores: String;
begin
  Result := '';
  Result := Result + '  INSERT INTO TMP_CORES_PFA(    ';
  Result := Result + '    PFA_LINHA_,                 ';
  Result := Result + '    PFA_TIPLIN,                 ';
  Result := Result + '    PFA_CODCOR,                 ';
  Result := Result + '    PFA_NOMCOR,                 ';
  Result := Result + '    PFA_PRODUT,                 ';
  Result := Result + '    PFA_CODBAS,                 ';
  Result := Result + '    PFA_DESEMB,                 ';
  Result := Result + '    PFA_VOLEMB,                 ';
  Result := Result + '    PFA_TIPPRO,                 ';
  Result := Result + '    PFA_CODPRO,                 ';
  Result := Result + '    PFA_QTDMLS,                 ';
  Result := Result + '    PFA_QTDGRS)                 ';
  Result := Result + '  VALUES(                       ';
  Result := Result + '    :PFA_LINHA_,                ';
  Result := Result + '    :PFA_TIPLIN,                ';
  Result := Result + '    :PFA_CODCOR,                ';
  Result := Result + '    :PFA_NOMCOR,                ';
  Result := Result + '    :PFA_PRODUT,                ';
  Result := Result + '    :PFA_CODBAS,                ';
  Result := Result + '    :PFA_DESEMB,                ';
  Result := Result + '    :PFA_VOLEMB,                ';
  Result := Result + '    :PFA_TIPPRO,                ';
  Result := Result + '    :PFA_CODPRO,                ';
  Result := Result + '    :PFA_QTDMLS,                ';
  Result := Result + '    :PFA_QTDGRS);               ';
end;

function TAbstractGravandoExecucaoProfissionalAutomotiva.fTipoColecao(
  AContador: Integer): String;
begin
  Result := '';

  If AContador = 0 Then
    Result :=  'AQ'
  Else If AContador = 1 Then
    Result := 'UN';
end;

function TAbstractGravandoExecucaoProfissionalAutomotiva.fValidarPath(intPasta: Integer): Boolean;
begin
  Result := True;

  If Not FileExists(fGetPath(intPasta)) Then
  Begin
    Result := False;
    Exit;
  End;
end;

function TAbstractGravandoExecucaoProfissionalAutomotiva.GetDataSetDestino: IDataSet;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;
  Result.SQL := GetSqlDestino;
  Result.Open;
end;

function TAbstractGravandoExecucaoProfissionalAutomotiva.GetDataSetOrigem(
  const strNomeArquivo: string): TDataSet;
Var
  strArquivo: String;
  stlTabelas: TStringList;
begin
  stlTabelas := Nil;
  Result := Nil;
  Try
    Try
      stlTabelas := TStringList.Create;
      strArquivo := strNomeArquivo;
      Result     := GetAdoQuery(strArquivo);
      TADOQuery(Result).SQL.Text := GetSqlOrigem(strArquivo, stlTabelas);
      TADOQuery(Result).Open;
    Except
      On E: EAbstractError Do
      Begin
        Raise Exception.CreateFmt('[%s] %s', [Self.ClassName, E.Message]);
      End;

      On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally
    If Assigned(stlTabelas) Then FreeAndNil(stlTabelas);
  End;
end;

procedure TAbstractGravandoExecucaoProfissionalAutomotiva.GetTabelas(
  const qryOrigem: TADOQuery; const stlTabelas: TStrings);
Var
  conOrigem: TADOConnection;
begin
  Try
    Try
      conOrigem := TADOConnection.Create(qryOrigem);
      conOrigem.ConnectionString := qryOrigem.ConnectionString;
      conOrigem.LoginPrompt := False;
      conOrigem.Open();
      conOrigem.GetTableNames(stlTabelas);
    Except
      On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally
    If Assigned(conOrigem) Then FreeAndNil(conOrigem);
  End;
end;

function TAbstractGravandoExecucaoProfissionalAutomotiva.LimpaCaracteres(
  const strTexto: string): string;
begin
  Result := TAutcomTintaFactory.Get.fTiraCaracEspeciaisPonto(strTexto);
end;

class function TAbstractGravandoExecucaoProfissionalAutomotiva.LimpaTexto(
  const strTexto: string): string;
begin
  Result := AnsiUpperCase(Trim(TAutcomTintaFactory.Get.fRemoveAcento(strTexto)));
end;

procedure TAbstractGravandoExecucaoProfissionalAutomotiva.ListarArquivo(
  strDiretorio: String);
Var
  Pesquisa: TSearchRec;
  intContador: Integer;
  TempNome: String;
begin
  intContador := FindFirst(strDiretorio + '\*.txt', faAnyFile, Pesquisa);

  Try
    While intContador = 0 Do
    Begin
      If TemAtributo(Pesquisa.Attr, faDirectory) Then
      Begin
        If (Pesquisa.Name <> '.') Then
        Begin
          If (Pesquisa.Name <> '..') Then
          Begin
            TempNome := strDiretorio + '\' + Pesquisa.Name;
            ListarArquivo(TempNome);
          End;
        End;
      End
      Else
      Begin
        If Pos('Pingmentos', Pesquisa.Name) > 0 Then
          FNomeArqBases := Pesquisa.Name
        Else If Pos('Catalisadores_Bases', Pesquisa.Name) > 0 Then
          FNomeCatalisadoresBases := Pesquisa.Name
        Else
          FNomeArqFormulas:= Pesquisa.Name;
      End;

      intContador := FindNext(Pesquisa);
    End;
  Finally

  End;
end;

procedure TAbstractGravandoExecucaoProfissionalAutomotiva.pCarregarBases(
  const Gravando: IGravando; intPasta: Integer);
Var
  LRecordCount, LLinha: Integer;
  LArquivo: TextFile;
  LText: TStringList;
  LStrLinha: RawByteString;

  FBase,
  FDescricao: String;
  LDescricao: String;
  FNomeArquivo: String;
begin
  Try
    Gravando.Texto := 'Verificando Path [BASES]...';

    FNomeArquivo := Conf.fGet('PATPFA') + '\' + FPastas[intPasta] +  '\' + FNomeArqBases;

    If Not FileExists(FNomeArquivo) Then
    Begin
      Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(Conf.fGet('PABPFA'), '"', '')]);
      Exit;
    End;

    Gravando.Texto := 'Carregando Bases...';

    cdsBases.EmptyDataSet;
    cdsBases.Close;
    cdsBases.Open;

    LRecordCount := fContaLinhas(FNomeArquivo);
    LLinha := 1;

    LText := TStringList.Create();
    LText.StrictDelimiter := True;
    LText.Delimiter := ';';

    AssignFile(LArquivo, FNomeArquivo);
    Reset(LArquivo);

    While Not Eof(LArquivo) Do
    Begin
      ReadLn(LArquivo, LStrLinha);
      LText.DelimitedText := UTF8ToWideString(LStrLinha);


      If LText[0] = 'BASE' Then
      Begin
        LDescricao := LText[2];
        FBase := Trim(Copy(LDescricao, 1, Pos('-', LDescricao) - 1));

        LDescricao := Trim(Copy(LDescricao, Pos('-', LDescricao) + 1, Length(LDescricao)));
        FDescricao := Trim(Copy(LDescricao, 1, Pos('-', LDescricao)));
      End
      Else If LText[0] = 'CATALISADOR' Then
      Begin
        LDescricao := LText[2];
        FBase := Trim(Copy(LDescricao, Pos('.', LDescricao) - 3, 8));
        FBase := AnsiReplaceStr(FBase, '.', '-');
        FDescricao := LText[2];
      End
      Else
      Begin
        LDescricao := LText[2];
        FBase := Trim(Copy(LDescricao, 1, Pos('-', LDescricao) - 1));
        FDescricao := Trim(Copy(LDescricao, Pos('-', LDescricao) + 1, Length(LDescricao)));
      End;

      If (LText[0] <> 'TIPO') Then
      Begin
        cdsBases.Append;
        cdsBases.FieldByName('TIPO').AsString := LText[0];
        cdsBases.FieldByName('COD_PRODUTO').AsString := LText[1];
        cdsBases.FieldByName('BASE').AsString := AnsiReplaceStr(FBase, '.', '-');
        cdsBases.FieldByName('DESCRICAO').AsString := LimpaTexto(AnsiReplaceStr(FDescricao, '-', ''));
        cdsBases.FieldByName('TIPO_LINHA').AsString := LText[4];
        cdsBases.FieldByName('EMBALA').AsFloat := StrToFloat(AnsiReplaceStr(LText[3], '.', ','));

        If cdsBases.FieldByName('EMBALA').AsFloat = 0 Then
          cdsBases.FieldByName('EMBALA').AsFloat := 900;

        cdsBases.FieldByName('PESESP').AsFloat := StrToFloat(AnsiReplaceStr(LText[5], '.', ','));
        cdsBases.FieldByName('COD_BARRA').AsString := LText[6];
        cdsBases.FieldByName('SKU_FAB').AsString := LText[7];
        cdsBases.FieldByName('BASORI').AsString := LText[8];
        cdsBases.FieldByName('COD_CATALISADOR').AsString := LText[9];
        cdsBases.Post;
      End;

      Inc(LLinha);
      Gravando.RegistrarProgresso(0, LLinha, LRecordCount);
    End;
  Finally
    If Assigned(LText) Then FreeAndNil(LText);
    CloseFile(LArquivo);
  End;
end;

procedure TAbstractGravandoExecucaoProfissionalAutomotiva.pCarregarBasesCatalisadores(
  const Gravando: IGravando; AArquivo: String);
Var
  Arquivo     : TextFile;
  strLinha: RawByteString;
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
  Try
    TAutcomTintaFactory.Get.DropTable('TMP_CATALISADORES_PFA');

    gravando.Texto := 'Iniciando a geração da tabela temporária de catalisadores/bases ...';
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

    If FileExists(ExtractFilePath(Application.ExeName) + 'libmysql57.dll') Then
      FDDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql57.dll'
    Else
      FDDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql41.dll';

     FDDatabase.Connected := True;

    pCriarTemporariaBasesCatalisadores;

    qryCores.Connection := FDDatabase;
    qryCores.SQL.Text := fInsertTemporariaBasesCatalisadores();

    iRecordCount  := fContaLinhas(AArquivo);
    intLinha      := 1;
    intCont := iRecordCount;
    slArquivo     := TStringList.Create;
    slArquivo.StrictDelimiter := True;
    slArquivo.Delimiter := ';';

    AssignFile(Arquivo, AArquivo);
    Reset(Arquivo);

    While Not Eof(Arquivo) Do
    begin
      qryCores.Params.ClearValues();
      qryCores.Params.ArraySize := 5000;
      intQtd := 0;


      For intContador := 1 To Pred(5000) Do
      Begin
        ReadLn(Arquivo, strLinha);
        slArquivo.DelimitedText := UTF8ToWideString(strLinha);


        If (slArquivo[0] <> 'COD_BASE') Then
        Begin
          qryCores.ParamByName('CAT_CODBAS').AsStrings[intQtd] := LimpaTexto(slArquivo[0]);
          qryCores.ParamByName('CAT_CODCAT').AsStrings[intQtd] := LimpaTexto(slArquivo[1]);
          qryCores.ParamByName('CAT_TIPBAS').AsStrings[intQtd] := 'CATALISADOR';
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
end;

procedure TAbstractGravandoExecucaoProfissionalAutomotiva.pCarregarCatalisadores(
  const Gravando: IGravando; intPasta: Integer);
Var
  LRecordCount, LLinha: Integer;
  LArquivo: TextFile;
  LText: TStringList;
  LStrLinha: RawByteString;

  FBase,
  FDescricao: String;
  LDescricao: String;
  FNomeArquivo: String;
begin
  Try
    Gravando.Texto := 'Verificando Path [BASES]...';

    FNomeArquivo := Conf.fGet('PATPFA') + '\' + FPastas[intPasta] +  '\' + FNomeArqBases;

    If Not FileExists(FNomeArquivo) Then
    Begin
      Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(Conf.fGet('PABPFA'), '"', '')]);
      Exit;
    End;

    Gravando.Texto := 'Carregando Bases...';

    cdsCatali.EmptyDataSet;
    cdsCatali.Close;
    cdsCatali.Open;

    LRecordCount := fContaLinhas(FNomeArquivo);
    LLinha := 1;

    LText := TStringList.Create();
    LText.StrictDelimiter := True;
    LText.Delimiter := ';';

    AssignFile(LArquivo, FNomeArquivo);
    Reset(LArquivo);

    While Not Eof(LArquivo) Do
    Begin
      ReadLn(LArquivo, LStrLinha);
      LText.DelimitedText := UTF8ToWideString(LStrLinha);

      If LText[0] <> 'CATALISADOR' Then
      Begin
        Inc(LLinha);
        Gravando.RegistrarProgresso(0, LLinha, LRecordCount);
        Continue;
      End;

      LDescricao := LText[2];
      FBase := Trim(Copy(LDescricao, Pos('.', LDescricao) - 3, 8));
      FBase := AnsiReplaceStr(FBase, '.', '-');
      FDescricao := LText[2];

      cdsCatali.Append;
      cdsCatali.FieldByName('TIPO').AsString := LText[0];
      cdsCatali.FieldByName('COD_PRODUTO').AsString := LText[1];
      cdsCatali.FieldByName('BASE').AsString := AnsiReplaceStr(FBase, '.', '-');
      cdsCatali.FieldByName('DESCRICAO').AsString := LimpaTexto(AnsiReplaceStr(FDescricao, '-', ''));
      cdsCatali.FieldByName('TIPO_LINHA').AsString := LText[4];
      cdsCatali.FieldByName('EMBALA').AsFloat := StrToFloat(AnsiReplaceStr(LText[3], '.', ','));

      If cdsCatali.FieldByName('EMBALA').AsFloat = 0 Then
        cdsCatali.FieldByName('EMBALA').AsFloat := 900;

      cdsCatali.FieldByName('PESESP').AsFloat := StrToFloat(AnsiReplaceStr(LText[5], '.', ','));
      cdsCatali.FieldByName('COD_BARRA').AsString := LText[6];
      cdsCatali.FieldByName('SKU_FAB').AsString := LText[7];
      cdsCatali.FieldByName('BASORI').AsString := LText[8];
      cdsCatali.FieldByName('COD_CATALISADOR').AsString := LText[9];
      cdsCatali.Post;

      Inc(LLinha);
      Gravando.RegistrarProgresso(0, LLinha, LRecordCount);
    End;
  Finally
    If Assigned(LText) Then FreeAndNil(LText);
    CloseFile(LArquivo);
  End;
end;

procedure TAbstractGravandoExecucaoProfissionalAutomotiva.pCarregarCores(const Gravando: IGravando; AArquivo: String);
Var
  Arquivo     : TextFile;
  strLinha: RawByteString;
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
  Try
    TAutcomTintaFactory.Get.DropTable('TMP_CORES_PFA');

    gravando.Texto := 'Iniciando a geração da tabela temporária das formulas ...';
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

    If FileExists(ExtractFilePath(Application.ExeName) + 'libmysql57.dll') Then
      FDDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql57.dll'
    Else
      FDDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql41.dll';

     FDDatabase.Connected := True;

    pCriarTemporariaCores;

    qryCores.Connection := FDDatabase;
    qryCores.SQL.Text := fInsertTemporariaCores();

    iRecordCount  := fContaLinhas(AArquivo);
    intLinha      := 1;
    intCont := iRecordCount;
    slArquivo     := TStringList.Create;
    slArquivo.StrictDelimiter := True;
    slArquivo.Delimiter := ';';

    AssignFile(Arquivo, AArquivo);
    Reset(Arquivo);

    While Not Eof(Arquivo) Do
    begin
      qryCores.Params.ClearValues();
      qryCores.Params.ArraySize := 5000;
      intQtd := 0;


      For intContador := 1 To Pred(5000) Do
      Begin
        ReadLn(Arquivo, strLinha);
        slArquivo.DelimitedText := UTF8ToWideString(strLinha);


        If (slArquivo[0] <> 'LINHA') And  (slArquivo[7] = '900')  Then
        Begin
          qryCores.ParamByName('PFA_LINHA_').AsStrings[intQtd] := LimpaTexto(slArquivo[0]);
          qryCores.ParamByName('PFA_TIPLIN').AsStrings[intQtd] := LimpaTexto(slArquivo[1]);
          qryCores.ParamByName('PFA_CODCOR').AsStrings[intQtd] := LimpaTexto(slArquivo[2]);
          qryCores.ParamByName('PFA_NOMCOR').AsStrings[intQtd] := LimpaTexto(slArquivo[3]);
          qryCores.ParamByName('PFA_PRODUT').AsStrings[intQtd] := LimpaTexto(slArquivo[4]);
          qryCores.ParamByName('PFA_CODBAS').AsStrings[intQtd] := LimpaTexto(slArquivo[5]);
          qryCores.ParamByName('PFA_DESEMB').AsStrings[intQtd] := LimpaTexto(slArquivo[6]);
          qryCores.ParamByName('PFA_VOLEMB').AsFloats[intQtd]  := StrToFloat(slArquivo[7]);
          qryCores.ParamByName('PFA_TIPPRO').AsStrings[intQtd] := LimpaTexto(slArquivo[8]);
          qryCores.ParamByName('PFA_CODPRO').AsStrings[intQtd] := LimpaTexto(slArquivo[9]);
          qryCores.ParamByName('PFA_QTDMLS').AsStrings[intQtd] := LimpaTexto(slArquivo[10]);
          qryCores.ParamByName('PFA_QTDGRS').AsStrings[intQtd] := LimpaTexto(slArquivo[11]);
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
end;

procedure TAbstractGravandoExecucaoProfissionalAutomotiva.pCriarDataSetBases;
begin
  cdsBases := TUniClientDataSet.Create(Nil);

  cdsBases.FieldDefs.AddFieldDef;
  cdsBases.FieldDefs[0].DataType := ftString;
  cdsBases.FieldDefs[0].Name := 'TIPO';
  cdsBases.FieldDefs[0].Size := 30;

  cdsBases.FieldDefs.AddFieldDef;
  cdsBases.FieldDefs[1].DataType := ftString;
  cdsBases.FieldDefs[1].Name := 'COD_PRODUTO';
  cdsBases.FieldDefs[1].Size := 10;

  cdsBases.FieldDefs.AddFieldDef;
  cdsBases.FieldDefs[2].DataType := ftString;
  cdsBases.FieldDefs[2].Name := 'BASE';
  cdsBases.FieldDefs[2].Size := 10;

  cdsBases.FieldDefs.AddFieldDef;
  cdsBases.FieldDefs[3].DataType := ftString;
  cdsBases.FieldDefs[3].Name := 'BASORI';
  cdsBases.FieldDefs[3].Size := 10;

  cdsBases.FieldDefs.AddFieldDef;
  cdsBases.FieldDefs[4].DataType := ftString;
  cdsBases.FieldDefs[4].Name := 'DESCRICAO';
  cdsBases.FieldDefs[4].Size := 60;

  cdsBases.FieldDefs.AddFieldDef;
  cdsBases.FieldDefs[5].DataType := ftString;
  cdsBases.FieldDefs[5].Name := 'TIPO_LINHA';
  cdsBases.FieldDefs[5].Size := 30;

  cdsBases.FieldDefs.AddFieldDef;
  cdsBases.FieldDefs[6].DataType := ftFloat;
  cdsBases.FieldDefs[6].Name := 'EMBALA';

  cdsBases.FieldDefs.AddFieldDef;
  cdsBases.FieldDefs[7].DataType := ftFloat;
  cdsBases.FieldDefs[7].Name := 'PESESP';

  cdsBases.FieldDefs.AddFieldDef;
  cdsBases.FieldDefs[8].DataType := ftString;
  cdsBases.FieldDefs[8].Name := 'COD_BARRA';
  cdsBases.FieldDefs[8].Size := 30;

  cdsBases.FieldDefs.AddFieldDef;
  cdsBases.FieldDefs[9].DataType := ftString;
  cdsBases.FieldDefs[9].Name := 'SKU_FAB';
  cdsBases.FieldDefs[9].Size := 30;

  cdsBases.FieldDefs.AddFieldDef;
  cdsBases.FieldDefs[10].DataType := ftString;
  cdsBases.FieldDefs[10].Name := 'COD_CATALISADOR';
  cdsBases.FieldDefs[10].Size := 10;

  cdsBases.CreateDataSet;
end;

procedure TAbstractGravandoExecucaoProfissionalAutomotiva.pCriarDataSetCatalisadores;
begin
  cdsCatali := TUniClientDataSet.Create(Nil);

  cdsCatali.FieldDefs.AddFieldDef;
  cdsCatali.FieldDefs[0].DataType := ftString;
  cdsCatali.FieldDefs[0].Name := 'TIPO';
  cdsCatali.FieldDefs[0].Size := 30;

  cdsCatali.FieldDefs.AddFieldDef;
  cdsCatali.FieldDefs[1].DataType := ftString;
  cdsCatali.FieldDefs[1].Name := 'COD_PRODUTO';
  cdsCatali.FieldDefs[1].Size := 10;

  cdsCatali.FieldDefs.AddFieldDef;
  cdsCatali.FieldDefs[2].DataType := ftString;
  cdsCatali.FieldDefs[2].Name := 'BASE';
  cdsCatali.FieldDefs[2].Size := 10;

  cdsCatali.FieldDefs.AddFieldDef;
  cdsCatali.FieldDefs[3].DataType := ftString;
  cdsCatali.FieldDefs[3].Name := 'BASORI';
  cdsCatali.FieldDefs[3].Size := 10;

  cdsCatali.FieldDefs.AddFieldDef;
  cdsCatali.FieldDefs[4].DataType := ftString;
  cdsCatali.FieldDefs[4].Name := 'DESCRICAO';
  cdsCatali.FieldDefs[4].Size := 60;

  cdsCatali.FieldDefs.AddFieldDef;
  cdsCatali.FieldDefs[5].DataType := ftString;
  cdsCatali.FieldDefs[5].Name := 'TIPO_LINHA';
  cdsCatali.FieldDefs[5].Size := 30;

  cdsCatali.FieldDefs.AddFieldDef;
  cdsCatali.FieldDefs[6].DataType := ftFloat;
  cdsCatali.FieldDefs[6].Name := 'EMBALA';

  cdsCatali.FieldDefs.AddFieldDef;
  cdsCatali.FieldDefs[7].DataType := ftFloat;
  cdsCatali.FieldDefs[7].Name := 'PESESP';

  cdsCatali.FieldDefs.AddFieldDef;
  cdsCatali.FieldDefs[8].DataType := ftString;
  cdsCatali.FieldDefs[8].Name := 'COD_BARRA';
  cdsCatali.FieldDefs[8].Size := 30;

  cdsCatali.FieldDefs.AddFieldDef;
  cdsCatali.FieldDefs[9].DataType := ftString;
  cdsCatali.FieldDefs[9].Name := 'SKU_FAB';
  cdsCatali.FieldDefs[9].Size := 30;

  cdsCatali.FieldDefs.AddFieldDef;
  cdsCatali.FieldDefs[10].DataType := ftString;
  cdsCatali.FieldDefs[10].Name := 'COD_CATALISADOR';
  cdsCatali.FieldDefs[10].Size := 10;

  cdsCatali.CreateDataSet;
end;

procedure TAbstractGravandoExecucaoProfissionalAutomotiva.pCriarTemporariaBasesCatalisadores;
var
  qryTmp : IDataSet;
begin
  qryTmp := TAutcomTintaFactory.Get.fGetDataSet;
  qryTmp.SQL :=  'CREATE TABLE TMP_CATALISADORES_PFA     '+
                 '   (CAT_CODBAS  VARCHAR(10),   '+
                 '    CAT_CODCAT  VARCHAR(10),   '+
                 '    CAT_TIPBAS  VARCHAR(25))   ';
  qryTmp.ExecSQL;
end;

procedure TAbstractGravandoExecucaoProfissionalAutomotiva.pCriarTemporariaCores;
var
  qryTmp : IDataSet;
begin
  qryTmp := TAutcomTintaFactory.Get.fGetDataSet;
  qryTmp.SQL :=  'CREATE TABLE TMP_CORES_PFA     '+
                 '   (PFA_LINHA_  VARCHAR(50),   '+
                 '    PFA_TIPLIN  VARCHAR(30),   '+
                 '    PFA_CODCOR  VARCHAR(20),   '+
                 '    PFA_NOMCOR  VARCHAR(50),   '+
                 '    PFA_PRODUT  VARCHAR(60),   '+
                 '    PFA_CODBAS  VARCHAR(15),   '+
                 '    PFA_DESEMB  VARCHAR(20),   '+
                 '    PFA_VOLEMB  DECIMAL(12,4), '+
                 '    PFA_TIPPRO  VARCHAR(20),   '+
                 '    PFA_CODPRO  VARCHAR(10),   '+
                 '    PFA_QTDMLS  DECIMAL(12,4), '+
                 '    PFA_QTDGRS  DECIMAL(12,4)) ';
  qryTmp.ExecSQL;
end;

function TAbstractGravandoExecucaoProfissionalAutomotiva.TemAtributo(Attr,
  Val: Integer): Boolean;
begin
  Result := False;

  If Attr = Val Then
  Begin
    If Val = Val Then
      Result := True;
  End;
end;

{ TDataSetHelper }

procedure TDataSetHelper.Filtrar(const strFiltro: string);
begin
  If strFiltro <> Self.Filter Then
  Begin
    Self.Filtered := False;
    Self.Filter   := strFiltro;
    Self.Filtered := True;
  End;
end;

{ TThreadCarregar }

constructor TThreadCarregar.Create(const GetDataSetOrigem: TGetDataSetOrigem;
  const GetDataSetDestino: TGetDataSetDestino; const strNomeArquivo: string);
begin
  inherited Create(False);

  Self.GetDataSetOrigem  := GetDataSetOrigem;
  Self.GetDataSetDestino := GetDataSetDestino;
  Self.strNomeArquivo    := strNomeArquivo;
end;

destructor TThreadCarregar.Destroy;
begin
  inherited;
end;

procedure TThreadCarregar.Execute;
begin
  Try
    CoInitializeEx(Nil, COINIT_MULTITHREADED);
    Self.DataSetOrigem  := GetDataSetOrigem(strNomeArquivo);
    Self.dataSetDestino := GetDataSetDestino;
  Finally
    CoUninitialize;
    Terminate;
  End;
end;

end.


