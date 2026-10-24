unit untProcessadorGravandoBrasimixImobiliariaCores;

interface

uses
  untAbstractProcessadorGravandoBrasimixImobiliaria, Classes, DB, SysUtils, untIGravando,
  Variants, Uni, StrUtils, untIProcessadorGravandoExecucaoArquivosInsert;

type
  TProcessadorGravandoBrasimixImobiliariaCores = class(TAbstractProcessadorGravandoBrasimixImobiliaria,
    IProcessadorGravandoExecucaoArquivosInsert)
  private
    function GetFator(const strCodUni: string): Double;
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
  end;

implementation

uses
  untFuncoesSimples, untDDLFactory;

{ TProcessadorGravandoBrasimixImobiliariaCores }

function TProcessadorGravandoBrasimixImobiliariaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TProcessadorGravandoBrasimixImobiliariaCores.GetFator(const strCodUni: string): Double;
begin
  Result := 1;
  if strCodUni = 'LA' then
    Result := 1
  else if strCodUni = 'GL' then
    Result := 1 / 5
  else if strCodUni = 'LT' then
    Result := 1 / 20;
end;

function TProcessadorGravandoBrasimixImobiliariaCores.GetSqlDestino: string;
begin
  Result := TDDLFactory.GetInsert('BZI_CADBZI');
end;

function TProcessadorGravandoBrasimixImobiliariaCores.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
const
  arrUnidades: array[0..2] of string = ('LT', 'GL', 'LA');
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
      '   , ' + QuotedStr(arrUnidades[intCont]) + ' AS CODUNI ' +
      ' FROM                 ' +
      '   [%s] AS T          ',
      [StringReplace(ExtractFileName(strNomeArquivo), '.', '#', [rfReplaceAll])]);
  end;
  Result := Trim(Result);
  Result := Copy(Result, Length('UNION') + 1, Length(Result));
  Result := Trim(Result);
end;

procedure TProcessadorGravandoBrasimixImobiliariaCores.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'BZI_CADBZI';
end;

procedure TProcessadorGravandoBrasimixImobiliariaCores.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
var
  qryGrava: TUniQuery;
  intCont: Integer;
begin
  qryGrava := TUniQuery(qryDestino);
  qryGrava.Params.Clear;
  qryGrava.SQL.Clear;
  qryGrava.SQL.Text := GetSqlDestino;

  qryGrava.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('BZI_CADBZI', VS_strCodEmp);
  qryGrava.ParamByName('BZI_CODIGO').AsString := Trim(AnsiUpperCase(LeftStr(qryOrigem.FieldByName('IDREGISTRO').AsString, 10)));
  qryGrava.ParamByName('BZI_GRUPRO').AsString := Trim(AnsiUpperCase(RightStr(qryOrigem.FieldByName('IDREGISTRO').AsString, 3))) + '-' + Trim(AnsiUpperCase(qryOrigem.FieldByName('CATALOGO').AsString));
  qryGrava.ParamByName('BZI_DESCRI').AsString := Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('DESBAS').AsString)));
  qryGrava.ParamByName('BZI_REFERE').AsString := Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('REFERE').AsString)));
  qryGrava.ParamByName('BZI_UNIDAD').AsString := qryOrigem.FieldByName('CODUNI').AsString;
  qryGrava.ParamByName('BZI_CODEMP').AsString := VS_strCodEmp;
  qryGrava.ParamByName('BZI_CODITE').AsString := '';

  for intCont := 1 to 10 do
  begin
    if fEmptyStr(qryOrigem.FieldByName('FORM' + fStrZero(intCont, 2)).AsString) then
      Break;

    if fStrToFloat(qryOrigem.FieldByName('QTD' + fStrZero(intCont, 2)).AsString) <= 0 then
      Break;

    qryGrava.ParamByName('BZI_CODC' + fStrZero(intCont, 2)).AsString := qryOrigem.FieldByName('FORM' + fStrZero(intCont, 2)).AsString;
    qryGrava.ParamByName('BZI_QTDC' + fStrZero(intCont, 2)).AsFloat := fStrToFloat(qryOrigem.FieldByName('QTD' + fStrZero(intCont, 2)).AsString) *
                                                                          GetFator(qryOrigem.FieldByName('CODUNI').AsString) / 100;
  end;

  qryGrava.ParamByName('BZI_LINHA_').AsString := Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('LINHA').AsString)));
  qryGrava.ParamByName('BZI_CODBAS').AsString := Trim(AnsiUpperCase(fRemoveAcento(qryOrigem.FieldByName('BASE').AsString)));
  qryGrava.ParamByName('BZI_CODUNI').AsString := qryOrigem.FieldByName('CODUNI').AsString;
  qryGrava.ParamByName('BZI_MD5KEY').AsString := GetMD5(qryGrava.ParamByName('BZI_CODIGO').AsString +
                                                  qryGrava.ParamByName('BZI_DESCRI').AsString +
                                                  qryGrava.ParamByName('BZI_REFERE').AsString +
                                                  qryGrava.ParamByName('BZI_UNIDAD').AsString +
                                                  qryGrava.ParamByName('BZI_LINHA_').AsString +
                                                  qryGrava.ParamByName('BZI_CODBAS').AsString +
                                                  qryGrava.ParamByName('BZI_CODUNI').AsString);
  qryGrava.ExecSQL;
end;

function TProcessadorGravandoBrasimixImobiliariaCores.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := False;
end;

procedure TProcessadorGravandoBrasimixImobiliariaCores.LimparTabelas;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text := 'TRUNCATE TABLE BZI_CADBZI';
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

procedure TProcessadorGravandoBrasimixImobiliariaCores.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel cadastrar a cor [%s - %s - %s - %s - %s - %s - %s], [%s - %s]',
    [Trim(AnsiUpperCase(qryOrigem.FieldByName('IDREGISTRO').AsString)),
    Trim(AnsiUpperCase(qryOrigem.FieldByName('CATALOGO').AsString)),
    Trim(AnsiUpperCase(qryOrigem.FieldByName('LINHA').AsString)),
    Trim(AnsiUpperCase(qryOrigem.FieldByName('DESBAS').AsString)),
    Trim(AnsiUpperCase(qryOrigem.FieldByName('REFERE').AsString)),
    Trim(AnsiUpperCase(qryOrigem.FieldByName('BASE').AsString)),
    Trim(AnsiUpperCase(qryOrigem.FieldByName('CODUNI').AsString)), E.ClassName, E.Message]);
end;

end.

