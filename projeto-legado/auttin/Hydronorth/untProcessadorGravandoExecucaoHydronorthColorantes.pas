unit untProcessadorGravandoExecucaoHydronorthColorantes;

interface

uses
  Classes, DB, SysUtils, untIGravando,
   Variants, untAbstractProcessadorGravandoExecucaoHydronorth, StrUtils;

type
  TProcessadorGravandoExecucaoHydronorthColorantes = class abstract(TAbstractProcessadorGravandoExecucaoHydronorth)
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
  end;

implementation
uses untFuncoesSimples, untAbstractAdoProcessadorGravandoExecucaoArquivos;
{ TProcessadorGravandoExecucaoHydronorthColorantes }

function TProcessadorGravandoExecucaoHydronorthColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TProcessadorGravandoExecucaoHydronorthColorantes.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM HYD_CADCOL';
end;

function TProcessadorGravandoExecucaoHydronorthColorantes.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
var
  intCont: Integer;
begin
  Result := '';
  for intCont := 1 to 6 do
  begin
    Result := Result +
      ' UNION                    ' +
      ' SELECT DISTINCT          ' +
      '   MID(COR' + IntToStr(intCont) + ', 1, 6) AS COL ' +
      ' FROM                     ' +
      '   [Hydronorth$]          ' +
      ' WHERE COR' + IntToStr(intCont) + ' <> '''' ';
  end;

  Result := Trim(Result);
  Result := Copy(Result, Length('UNION') + 1, Length(Result));
  Result := Trim(Result);  
end;

procedure TProcessadorGravandoExecucaoHydronorthColorantes.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'HYD_CADCOL';
end;

procedure TProcessadorGravandoExecucaoHydronorthColorantes.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('HYD_CADCOL', VS_strCodEmp);
  qryDestino.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('COL_CODCOL').AsString := LimpaTexto(qryOrigem.FieldByName('COL').AsString);
  qryDestino.FieldByName('COL_EMBALA').AsFloat := 1000;
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoHydronorthColorantes.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('COL_CODCOL', LimpaTexto(qryOrigem.FieldByName('COL').AsString), []);
end;

procedure TProcessadorGravandoExecucaoHydronorthColorantes.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível gravar o colorante: [%s], [%s: %s]',
    [qryOrigem.FieldByName('COL').AsString,
    E.ClassName,
    E.Message]);
end;

end.
