unit Contabilidade.Classes.ProximoCodigoTPlaco;

interface

uses
  System.SysUtils, System.Classes, System.StrUtils, Data.Db;

type
  TProximoCodigoTPlaco = class
  private
    class procedure pValidar(const AstrTabela, AstrTplaco: string);
    class function fEnsureTplaco(const AstrTplaco: string): string;
  public
    class function fObter(const AstrTabela: string; const AstrTplaco: string = ''): Integer;
    class procedure pGravar(const AintUltimoCodigo: Integer; const AstrTabela: string; const AstrTplaco: string = '');
    class function fObterEGravar(const AstrTabela: string; const AstrTplaco: string = ''): Integer;
  end;

implementation

uses
  untFuncoesSimples, Contabilidade.Funcoes, Uni;

const
  SQL_PROTPL = 'SELECT * FROM PROTPL WHERE PRO_TABELA = :TABELA AND PRO_TPLACO = :TPLACO';

{ TProximoCodigoTPlaco }

class function TProximoCodigoTPlaco.fEnsureTplaco(
  const AstrTplaco: string): string;
begin
  Result := AstrTplaco.Trim;

  if AstrTplaco.IsEmpty then
    Result := fRetTplacoEmpresaLogada();
end;

class function TProximoCodigoTPlaco.fObter(const AstrTabela,
  AstrTplaco: string): Integer;
var
  Lqry: TUniQuery;
  LstrTplaco: string;
begin
  Result := 1;

  LstrTplaco := fEnsureTplaco(AstrTplaco);
  pValidar(AstrTabela, LstrTplaco);
  Lqry := fCriaQuery();
  try
    Lqry.SQL.Text := SQL_PROTPL;
    Lqry.ParamByName('TABELA').AsString := AstrTabela.Trim;
    Lqry.ParamByName('TPLACO').AsString := LstrTplaco;

    Lqry.Open;

    if Lqry.IsEmpty then
      Exit;

    Result := Lqry.FieldByName('PRO_CODSEQ').AsInteger + 1;
  finally
    FreeAndNil(Lqry);
  end;
end;

class function TProximoCodigoTPlaco.fObterEGravar(const AstrTabela: string; const AstrTplaco: string = ''): Integer;
var
  LblnOwnsTransaction: Boolean;
begin
  LblnOwnsTransaction := not fInTransaction();
  if LblnOwnsTransaction then
    fStartTransaction();
  try
    Result := Self.fObter(AstrTabela, AstrTplaco);

    Self.pGravar(Result, AstrTabela, AstrTplaco);

    if LblnOwnsTransaction then
      fCommit;
  except
    if LblnOwnsTransaction then
      fRollBack();

    raise;
  end;
end;

class procedure TProximoCodigoTPlaco.pGravar(
  const AintUltimoCodigo: Integer; const AstrTabela, AstrTplaco: string);
var
  Lqry: TUniQuery;
  LstrTplaco: string;
begin
  if AintUltimoCodigo < 0 then
    raise Exception.Create('Código inválido');

  LstrTplaco := fEnsureTplaco(AstrTplaco);
  pValidar(AstrTabela, LstrTplaco);

  Lqry := fCriaQuery();
  try
    Lqry.SQL.Text := SQL_PROTPL;
    Lqry.ParamByName('TABELA').AsString := AstrTabela.Trim;
    Lqry.ParamByName('TPLACO').AsString := LstrTplaco;
    Lqry.Open;

    if Lqry.IsEmpty then
    begin
      Lqry.Append;
      Lqry.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PROTPL', VS_strCodEmp);
      Lqry.FieldByName('PRO_TABELA').AsString := AstrTabela.Trim;
      Lqry.FieldByName('PRO_TPLACO').AsString := LstrTplaco;
    end
    else
      Lqry.Edit;

    Lqry.FieldByName('PRO_CODSEQ').AsInteger := AintUltimoCodigo;

    Lqry.Post;
  finally
    FreeAndNil(Lqry);
  end;
end;

class procedure TProximoCodigoTPlaco.pValidar(const AstrTabela, AstrTplaco: string);
begin
  if AstrTabela.Trim.IsEmpty then
    raise Exception.Create('Tabela não informada.');

  if AstrTplaco.Trim.IsEmpty then
    raise Exception.Create('TPlaco não informado');
end;

end.
