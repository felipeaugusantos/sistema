unit untProcessadorGravandoExecucaoEucatexCores;

interface

uses
  untAbstractAdoProcessadorGravandoExecucaoArquivos, Classes, DB, SysUtils, untIGravando, untIConfTinta,
  Variants, ADODB, Windows,
  StrUtils, Uni, untIProcessadorGravandoExecucaoArquivosInsert;

type
  TProcessadorGravandoExecucaoEucatexCores = class(TAbstractAdoProcessadorGravandoExecucaoArquivos, IProcessadorGravandoExecucaoArquivosInsert)
  private
    conf: IConfTinta;
    arrUnidades: array[0..2] of string;
    intCodSeq: Integer;
    function GetFator(const strUnidade: string): Double;
  protected
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    function GetAdoQuery(var strNomeArquivo: string): TADOQuery; override;
  public
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings); override;
    procedure GetArquivosProcessar(const stlArquivos: TStrings); override;
    function GetSqlDestino(): string; override;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet); override;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
      const qryOrigem, qryDestino: TDataSet); override;
    function fGetNomeGravacao(): string; override;
    constructor Create();
    destructor Destroy; override;
    procedure LimparTabelas; override;
  end;

implementation

uses untDDLFactory,untFuncoesSimples, untFuncTinta,untDefinicaoTxtFormato,untDefinicaoTxtCharacterSet, untIDefinicaoTxtCampo,untIDefinicaoTxt, untADOTxtFactory, untGenericDefinicaoTxt;

{ TProcessadorGravandoExecucaoEucatexCores }

constructor TProcessadorGravandoExecucaoEucatexCores.Create;
begin
  inherited Create();
  conf := fGetConfTinta('EUC');
  arrUnidades[0] := conf.fGet('EUCQUA');
  arrUnidades[1] := conf.fGet('EUCGAL');
  arrUnidades[2] := conf.fGet('EUCLAT');
  intCodSeq := 1;  
end;

function TProcessadorGravandoExecucaoEucatexCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TProcessadorGravandoExecucaoEucatexCores.GetAdoQuery(var strNomeArquivo: string): TADOQuery;
var
  definicao: IDefinicaoTxt;
begin
  definicao := TGenericDefinicaoTxt.Create(strNomeArquivo, dtfCustom, ',', dtcsAnsi, '.',
    TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo([]));
  strNomeArquivo := definicao.NomeArquivo;
  TADOTxtFactory.Registrar(definicao);
  Result := TADOTxtFactory.GetTxt12Query(ExtractFileDir(strNomeArquivo));
end;

procedure TProcessadorGravandoExecucaoEucatexCores.GetArquivosProcessar(const stlArquivos: TStrings);
begin
  stlArquivos.Text := conf.fGet('EUCPAT');
end;

function TProcessadorGravandoExecucaoEucatexCores.GetFator(const strUnidade: string): Double;
begin
  Result := 1;
  if MatchText(strUnidade, [arrUnidades[1], 'Galao']) then
    Result := 3.6
  else if MatchText(strUnidade, [arrUnidades[0], 'Quarto']) then
    Result := 0.9
  else if MatchText(strUnidade, [arrUnidades[2], 'Lata']) then
    Result := 18;
end;

function TProcessadorGravandoExecucaoEucatexCores.GetSqlDestino: string;
begin
  Result := TDDLFactory.GetInsertDelayed('EUC_CADEUC');
end;

function TProcessadorGravandoExecucaoEucatexCores.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
var
  intCont: Integer;
begin
  Result := '';

  for intCont := 0 to Length(arrUnidades) - 1 do
  begin
    Result := Result + Format(
      ' UNION                ' +
      ' SELECT               ' +
      '   T.*                ' +
      '   , ' + QuotedStr(arrUnidades[intCont]) + ' AS CODUNI     ' +
      ' FROM                 ' +
      '   [%s] AS T          ' +
      ' WHERE                ' +
      '   KEY1 <> ''''       ',
      [StringReplace(ExtractFileName(strNomeArquivo), '.', '#', [rfReplaceAll])]);
  end;

  Result := Trim(Result);
  Result := Copy(Result, Length('UNION') + 1, Length(Result));
  Result := Trim(Result);
end;

procedure TProcessadorGravandoExecucaoEucatexCores.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'EUC_CADEUC';
end;

procedure TProcessadorGravandoExecucaoEucatexCores.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
var
  qryGrava: TUniQuery;
  intCont: Integer;
begin
  qryGrava := TUniQuery(qryDestino);
  qryGrava.Params.Clear;
  qryGrava.SQL.Clear;
  qryGrava.SQL.Text := GetSqlDestino;
  qryGrava.ParamByName('EUC_CODSEQ').AsString := fStrZero(fInc(intCodSeq), 6);
  qryGrava.ParamByName('AUTOINCREM').AsString := fFormataAutInc(intCodSeq, VS_strCodEmp);
  qryGrava.ParamByName('EUC_CODEMP').AsString := VS_strCodEmp;
  qryGrava.ParamByName('EUC_CODCOR').AsString := Trim(AnsiUpperCase(qryOrigem.FieldByName('Key1').AsString));
  qryGrava.ParamByName('EUC_DESCOR').AsString := Trim(AnsiUpperCase(qryOrigem.FieldByName('Key2').AsString));
  qryGrava.ParamByName('EUC_PRODUT').AsString := Trim(AnsiUpperCase(qryOrigem.FieldByName('SUBP').AsString));
  qryGrava.ParamByName('EUC_DESBAS').AsString := Trim(AnsiUpperCase(qryOrigem.FieldByName('BASE').AsString));
  qryGrava.ParamByName('EUC_UNIDAD').AsString := qryOrigem.FieldByName('CODUNI').AsString;

  for intCont := 1 to 5 do
  begin
    if fEmptyStr(qryOrigem.FieldByName('CNT' + IntToStr(intCont)).AsString) then
      Break;

    if fStrToFloat(qryOrigem.FieldByName('QNT' + IntToStr(intCont)).AsString) <= 0 then
      Break;    

    qryGrava.ParamByName('EUC_FORM' + fStrZero(intCont, 2)).AsString := qryOrigem.FieldByName('CNT' + IntToStr(intCont)).AsString;
    qryGrava.ParamByName('EUC_QTDB' + fStrZero(intCont, 2)).AsFloat := fStrToFloat(qryOrigem.FieldByName('QNT' + IntToStr(intCont)).AsString) *
                                                    GetFator(qryOrigem.FieldByName('CODUNI').AsString) / GetFator(qryOrigem.FieldByName('CAN').AsString);
  end;

  qryGrava.ExecSQL;
end;

function TProcessadorGravandoExecucaoEucatexCores.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := False;
end;

procedure TProcessadorGravandoExecucaoEucatexCores.LimparTabelas;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text := 'TRUNCATE TABLE EUC_CADEUC';
      qryGen.ExecSQL;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;                              
end;

procedure TProcessadorGravandoExecucaoEucatexCores.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel cadastrar a cor [%s - %s - %s - %s - %s], [%s - %s]',
    [Trim(AnsiUpperCase(qryOrigem.FieldByName('Key1').AsString)),
    Trim(AnsiUpperCase(qryOrigem.FieldByName('Key2').AsString)),
    Trim(AnsiUpperCase(qryOrigem.FieldByName('BASE').AsString)),
    Trim(AnsiUpperCase(qryOrigem.FieldByName('SUBP').AsString)),
    Trim(AnsiUpperCase(qryOrigem.FieldByName('CODUNI').AsString)), E.ClassName, E.Message]);
end;

destructor TProcessadorGravandoExecucaoEucatexCores.Destroy;
begin
  pAtualizaProCodAutInc('EUC_CADEUC', intCodSeq);
  inherited;
end;

end.
