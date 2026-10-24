unit untProcessadorGravandoExecucaoSayerlackCores;

interface

uses
  untAbstractProcessadorGravandoExecucaoSayerlack, SysUtils, Classes, DB, untFuncoesSimples,
  Variants, untIGravando, Uni, ADODB,  untIProcessadorGravandoExecucaoArquivosInsert;

type
  TProcessadorGravandoExecucaoSayerlackCores = class(TAbstractProcessadorGravandoExecucaoSayerlack,
    IProcessadorGravandoExecucaoArquivosInsert)
  private
    dicCampos: TDicionario;
    function GetQuantidade(const qryOrigem, qryBase: TDataSet; const intPos: Integer): Double;
  protected
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
  public
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings); override;
    function GetSqlDestino(): string; override;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet); override;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
      const qryOrigem, qryDestino: TDataSet); override;
    function fGetNomeGravacao(): string; override;
    procedure LimparTabelas; override;
    constructor Create(); override;
    destructor Destroy; override;
  end;

implementation

uses
  untDDLFactory,untSayerLackComuns;

{ TProcessadorGravandoExecucaoSayerlackCores }

constructor TProcessadorGravandoExecucaoSayerlackCores.Create;
begin
  inherited Create();
  Self.dicCampos := TDicionario.Create;
end;

destructor TProcessadorGravandoExecucaoSayerlackCores.Destroy;
begin
  if Assigned(dicCampos) then FreeAndNil(dicCampos);
  inherited Destroy;
end;

function TProcessadorGravandoExecucaoSayerlackCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TProcessadorGravandoExecucaoSayerlackCores.GetQuantidade(const qryOrigem, qryBase: TDataSet; const intPos: Integer): Double;
var
  fltFatorOrigem: Double;
  fltFatorDestino: Double;
begin
  fltFatorOrigem := TSayerLackComuns.GetEmbala(qryOrigem.FieldByName('EMBALA').AsString);
  fltFatorDestino := TSayerLackComuns.fRetornaEmbala(qryBase.FieldByName('BAS_DESEMB').AsString);
  Result := fStrToFloat(StringReplace(qryOrigem.FieldByName('QNT' + IntToStr(intPos)).AsString, '.', ',', [rfReplaceAll])) *
    fltFatorDestino / fltFatorOrigem;
end;

function TProcessadorGravandoExecucaoSayerlackCores.GetSqlDestino: string;
begin
  Result := TDDLFactory.GetInsertDelayed('SAY_CADSAY');
end;

function TProcessadorGravandoExecucaoSayerlackCores.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result :=
    ' SELECT                           ' +
    '     P.F2 AS [COLORCODE]          ' +
    '   , C.F6 AS [COMMENT]            ' +
    '   , C.F9 AS [PROD]               ' +
    '   , C.F3 AS [DESC]               ' +
    '   , P.F3 AS [EMBALA]             ' +
    '   , P.F4 AS [CNT1]               ' +
    '   , P.F6 AS [CNT2]               ' +
    '   , P.F8 AS [CNT3]               ' +
    '   , P.F10 AS [CNT4]              ' +
    '   , P.F12 AS [CNT5]              ' +
    '   , P.F14 AS [CNT6]              ' +
    '   , P.F16 AS [CNT7]              ' +
    '   , P.F5 AS [QNT1]               ' +
    '   , P.F7 AS [QNT2]               ' +
    '   , P.F9 AS [QNT3]               ' +
    '   , P.F11 AS [QNT4]              ' +
    '   , P.F13 AS [QNT5]              ' +
    '   , P.F15 AS [QNT6]              ' +
    '   , P.F17 AS [QNT7]              ' +
    ' FROM                             ' +
    '   [COLOR$] AS C,                 ' +
    '   [COLPIGMPACK$] AS P            ' +
    ' WHERE P.F2 = C.F2                ' +
    ' AND P.F2 <> ''ColorCode''        ' +
    ' AND C.F2 <> ''ColorCode''        ' +
    ' AND C.F2 <> ''9995 BS''          ' + // Não tem formulação
    ' AND C.F2 <> ''''                 ' ;
end;

procedure TProcessadorGravandoExecucaoSayerlackCores.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'SAY_CADSAY';
end;

procedure TProcessadorGravandoExecucaoSayerlackCores.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
var
  qryGrava: TUniQuery;
  qryBase: TUniQuery;
  intCont: Integer;
begin
  qryGrava := TUniQuery(qryDestino);
  qryGrava.Params.Clear;
  qryGrava.SQL.Text := GetSqlDestino;

  qryBase := fCriaQuery;
  Try
    qryBase.Close;
    qryBase.SQL.Text := 'SELECT ' +
                        '  BAS_BASE__, BAS_CODBAS, BAS_DESEMB '+
                        'FROM '+
                        '  SAY_CADBAS '+
                        'WHERE '+
                        '  BAS_PRODUT = '''+ qryOrigem.FieldByName('PROD').AsString + '''';
    qryBase.Open;
    qryBase.First;

    While not qryBase.Eof Do
    Begin
      qryGrava.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('SAY_CADSAY', VS_strCodEmp);
      qryGrava.ParamByName('SAY_CODEMP').AsString := VS_strCodEmp;
      qryGrava.ParamByName('SAY_BASE__').AsString := qryBase.FieldByName('BAS_BASE__').AsString;
      qryGrava.ParamByName('SAY_CODBAS').AsString := qryBase.FieldByName('BAS_CODBAS').AsString;
      qryGrava.ParamByName('SAY_PRODUT').AsString := qryOrigem.FieldByName('PROD').AsString;
      qryGrava.ParamByName('SAY_DESEMB').AsString := qryBase.FieldByName('BAS_DESEMB').AsString;
      qryGrava.ParamByName('SAY_DESCRI').AsString := qryOrigem.FieldByName('DESC').AsString;
      qryGrava.ParamByName('SAY_COMENT').AsString := qryOrigem.FieldByName('COMMENT').AsString;
      qryGrava.ParamByName('SAY_CODIGO').AsString := qryOrigem.FieldByName('COLORCODE').AsString;

      for intCont := 1 to 7 do
      begin
        if fEmptyStr(qryOrigem.FieldByName('CNT' + IntToStr(intCont)).AsString) then
          Break;

        qryGrava.ParamByName('SAY_FORM' + fStrZero(intCont, 2)).AsString := qryOrigem.FieldByName('CNT' + IntToStr(intCont)).AsString;
        qryGrava.ParamByName('SAY_QTDC' + fStrZero(intCont, 2)).AsFloat := GetQuantidade(qryOrigem, qryBase, intCont);
      end;

      qryGrava.ParamByName('SAY_MD5KEY').AsString := GetMD5(qryGrava.ParamByName('SAY_BASE__').AsString +
        qryGrava.ParamByName('SAY_CODBAS').AsString +
        qryGrava.ParamByName('SAY_PRODUT').AsString +
        qryGrava.ParamByName('SAY_CODIGO').AsString +
        qryGrava.ParamByName('SAY_DESEMB').AsString);

      qryGrava.ExecSQL;
      qryBase.Next;
    End;
  Finally
    FreeAndNil(qryBase);
  End;
end;

function TProcessadorGravandoExecucaoSayerlackCores.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := False;
end;

procedure TProcessadorGravandoExecucaoSayerlackCores.LimparTabelas;
begin
  TruncateTable('SAY_CADSAY');
end;

procedure TProcessadorGravandoExecucaoSayerlackCores.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível gravar a cor [%s %s %s], [%s: %s]',
    [qryOrigem.FieldByName('DESC').AsString, qryOrigem.FieldByName('COLORCODE').AsString,
    qryOrigem.FieldByName('PROD').AsString,
    E.ClassName, E.Message]);
end;

end.
