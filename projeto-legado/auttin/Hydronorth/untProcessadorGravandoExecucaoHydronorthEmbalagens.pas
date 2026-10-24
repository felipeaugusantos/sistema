unit untProcessadorGravandoExecucaoHydronorthEmbalagens;

interface

uses
  Classes, DB, SysUtils, untIGravando,
  Variants, untAbstractProcessadorGravandoExecucaoHydronorth, StrUtils;

type
  TProcessadorGravandoExecucaoHydronorthEmbalagens = class abstract(TAbstractProcessadorGravandoExecucaoHydronorth)
  protected
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; overload; override; 
  public
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings); override;
    function GetSqlDestino(): string; override;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet); override;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
      const qryOrigem, qryDestino: TDataSet); override;
    function fGetNomeGravacao(): string; override;
  public
    class function GetCodigoEmbalagem(const strDesEmb: string): string;
    class function GetTamanhoEmbalagem(const strDesEmb: string): Double;
    class function GetSqlOrigem: string; reintroduce; overload; 
  end;

implementation

uses
  untFuncoesSimples,untAbstractAdoProcessadorGravandoExecucaoArquivos;

{ TProcessadorGravandoExecucaoHydronorthEmbalagens }

function TProcessadorGravandoExecucaoHydronorthEmbalagens.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Embalagens';
end;

class function TProcessadorGravandoExecucaoHydronorthEmbalagens.GetCodigoEmbalagem(const strDesEmb: string): string;
begin
  if CompareText(LimpaTexto(strDesEmb), LimpaTexto('Galão')) = 0 then
    Result := 'GAL'
  else if CompareText(LimpaTexto(strDesEmb), LimpaTexto('Quartinho')) = 0 then
    Result := 'QUA'
  else if CompareText(LimpaTexto(strDesEmb), LimpaTexto('Lata')) = 0 then
    Result := 'LAA'
  else if CompareText(LimpaTexto(strDesEmb), LimpaTexto('Lata(textura)')) = 0 then
    Result := 'LAT';
end;

function TProcessadorGravandoExecucaoHydronorthEmbalagens.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM HYD_CADEMB';
end;

class function TProcessadorGravandoExecucaoHydronorthEmbalagens.GetSqlOrigem: string;
var
  intCont: Integer;
  strPos: string;
  strNovoPos: string;
begin
  strPos := '1';
  Result := '';

  for intCont := 1 to 6 do
  begin
    strNovoPos := 'INSTR(' + strPos + ', EMBALAGENS, '';'') + 1';
    Result := Result +
      ' UNION                                               ' +
      ' SELECT DISTINCT                                     ' +
      ' EMBALAGENS                                          ' +
      ' , INSTR(' + strPos + ', EMBALAGENS, '';'') AS POS' + IntToStr(intCont) + '               ' +
      ' , IIF(POS' + IntToStr(intCont) + ' = 0, LEN(EMBALAGENS), POS' + IntToStr(intCont) + ' - 1) AS RPOS' + IntToStr(intCont) + ' ' +
      ' , MID(EMBALAGENS, ' + strPos + ', RPOS' + IntToStr(intCont) + ') AS EMB                 ' +
      ' FROM                                                ' +
      ' [Hydronorth$]                                       ' +
      ' WHERE EMBALAGENS <> ''''                            ';
    strPos := strNovoPos;
  end;

  Result := Trim(Result);
  Result := Copy(Result, Length('UNION') + 1, Length(Result));
  Result := Trim(Result);
  Result := 'SELECT DISTINCT EMB FROM (' + Result + ') AS T WHERE NOT EMB LIKE ''%;%''';
end;

function TProcessadorGravandoExecucaoHydronorthEmbalagens.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := GetSqlOrigem();
end;

procedure TProcessadorGravandoExecucaoHydronorthEmbalagens.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'HYD_CADEMB';
end;

class function TProcessadorGravandoExecucaoHydronorthEmbalagens.GetTamanhoEmbalagem(const strDesEmb: string): Double;
begin
  Result := 0;
  if CompareText(LimpaTexto(strDesEmb), LimpaTexto('Galão')) = 0 then
    Result := 3200
  else if CompareText(LimpaTexto(strDesEmb), LimpaTexto('Quartinho')) = 0 then
    Result := 800
  else if CompareText(LimpaTexto(strDesEmb), LimpaTexto('Lata')) = 0 then
    Result := 16000
  else if CompareText(LimpaTexto(strDesEmb), LimpaTexto('Lata(textura)')) = 0 then
    Result := 14000
end;

procedure TProcessadorGravandoExecucaoHydronorthEmbalagens.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('HYD_CADEMB', VS_strCodEmp);
  qryDestino.FieldByName('EMB_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('EMB_CODEMB').AsString := GetCodigoEmbalagem(qryOrigem.FieldByName('EMB').AsString);
  qryDestino.FieldByName('EMB_DESEMB').AsString := LimpaTexto(qryOrigem.FieldByName('EMB').AsString);
  qryDestino.FieldByName('EMB_TAMEMB').AsFloat := GetTamanhoEmbalagem(qryOrigem.FieldByName('EMB').AsString);
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoHydronorthEmbalagens.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('EMB_CODEMB;EMB_DESEMB;EMB_TAMEMB', VarArrayOf([
    GetCodigoEmbalagem(qryOrigem.FieldByName('EMB').AsString),
    LimpaTexto(qryOrigem.FieldByName('EMB').AsString),
    GetTamanhoEmbalagem(qryOrigem.FieldByName('EMB').AsString)
  ]), []);
end;

procedure TProcessadorGravandoExecucaoHydronorthEmbalagens.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível gravar a embalagem: [%s - %s 0 %.2f], [%s: %s]',
    [GetCodigoEmbalagem(qryOrigem.FieldByName('EMB').AsString),
    LimpaTexto(qryOrigem.FieldByName('EMB').AsString),
    GetTamanhoEmbalagem(qryOrigem.FieldByName('EMB').AsString),
    E.ClassName,
    E.Message]);
end;

end.
