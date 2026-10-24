unit untCfgGrids;

interface

uses
  Uni, untFuncoesGen, untFuncoesSimples, System.Generics.Collections,
  System.SysUtils, cxGridDBTableView;

type
  TConfiguracaoGrid = class
  strict private
    FNomeGrid: String;
    FNomeFormulario: String;
    FCodigoOperador: String;
    FConfiguracoesColunas: String;

    procedure SetCodigoOperador(const Value: String);
    procedure SetNomeFormulario(const Value: String);
    procedure SetNomeGrid(const Value: String);
    procedure SetConfiguracoesColunas(const Value: String);

  public
    property CodigoOperador: String read FCodigoOperador write SetCodigoOperador;
    property NomeFormulario: String read FNomeFormulario write SetNomeFormulario;
    property NomeGrid: String read FNomeGrid write SetNomeGrid;
    property ConfiguracoesColunas: String read FConfiguracoesColunas write SetConfiguracoesColunas;

  end;

  TCfgGrid = class
  public
    function fSalvar(const AConfiguracaoGrid: TConfiguracaoGrid): Boolean;
    function fDeletar(const AConfiguracaoGrid: TConfiguracaoGrid): Boolean;
    function fDadosConfiguracaoGrid(const ACodigoOperador, ANomeFormulario,
      ANomeGrid: String): TConfiguracaoGrid;

  end;

implementation

{ TCfgGrid }

function TCfgGrid.fDadosConfiguracaoGrid(const ACodigoOperador, ANomeFormulario,
  ANomeGrid: String): TConfiguracaoGrid;
var
  LQuery : TUniQuery;
begin
  LQuery := fCriaQuery(nil);
  Result := nil;
  Try
    LQuery.Close;
    LQuery.SQL.Text := 'SELECT * FROM GRDCFG '
                     + ' WHERE CFG_CODOPE = :CODOPE '
                     + '   AND CFG_NOMFRM = :NOMFRM '
                     + '   AND CFG_NOMGRD = :NOMGRD ';

    LQuery.ParamByName('CODOPE').AsString := ACodigoOperador;
    LQuery.ParamByName('NOMFRM').AsString := ANomeFormulario;
    LQuery.ParamByName('NOMGRD').AsString := ANomeGrid;
    LQuery.Open;

    If LQuery.IsEmpty Then
      Exit;

    Result := TConfiguracaoGrid.Create;

    Result.CodigoOperador       := LQuery.FieldByName('CFG_CODOPE').AsString;
    Result.NomeFormulario       := LQuery.FieldByName('CFG_NOMFRM').AsString;
    Result.NomeGrid             := LQuery.FieldByName('CFG_NOMGRD').AsString;
    Result.ConfiguracoesColunas := LQuery.FieldByName('CFG_CONFIG').AsString;
  Finally
    FreeAndNil(LQuery);
  End;
end;

function TCfgGrid.fSalvar(const AConfiguracaoGrid: TConfiguracaoGrid): Boolean;
var
  LQuery : TUniQuery;
begin
  Result := False;

  If Not Assigned(AConfiguracaoGrid) Then
    Exit;

  LQuery := fCriaQuery(nil);
  Try
    LQuery.Close;
    LQuery.SQL.Text := 'SELECT * FROM GRDCFG '
                     + ' WHERE CFG_CODOPE = :CODOPE '
                     + '   AND CFG_NOMFRM = :NOMFRM '
                     + '   AND CFG_NOMGRD = :NOMGRD ';

    LQuery.ParamByName('CODOPE').AsString := AConfiguracaoGrid.CodigoOperador;
    LQuery.ParamByName('NOMFRM').AsString := AConfiguracaoGrid.NomeFormulario;
    LQuery.ParamByName('NOMGRD').AsString := AConfiguracaoGrid.NomeGrid;
    LQuery.Open;

    If LQuery.IsEmpty Then
    Begin
      LQuery.Append;
      LQuery.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('GRDCFG', VS_strCodEmp);
      LQuery.FieldByName('CFG_CODOPE').AsString := AConfiguracaoGrid.CodigoOperador;
      LQuery.FieldByName('CFG_NOMFRM').AsString := AConfiguracaoGrid.NomeFormulario;
      LQuery.FieldByName('CFG_NOMGRD').AsString := AConfiguracaoGrid.NomeGrid;
    End
    Else
      LQuery.Edit;

    LQuery.FieldByName('CFG_CONFIG').AsString := AConfiguracaoGrid.ConfiguracoesColunas;
    LQuery.Post;

    Result := True;
  Finally
    FreeAndNil(LQuery);
  End;
end;

function TCfgGrid.fDeletar(const AConfiguracaoGrid: TConfiguracaoGrid): Boolean;
  Var
    qryDados: TUniQuery;
begin
  Result := False;

  If Not Assigned(AConfiguracaoGrid) Then
    Exit;

  qryDados := fCriaQuery(nil);

  Try
    fStartTransaction();

    Try
      qryDados.Close;
      qryDados.SQL.Text := 'DELETE FROM GRDCFG          '
                         + ' WHERE CFG_CODOPE = :CODOPE '
                         + '   AND CFG_NOMFRM = :NOMFRM '
                         + '   AND CFG_NOMGRD = :NOMGRD ';

      qryDados.ParamByName('CODOPE').AsString := AConfiguracaoGrid.CodigoOperador;
      qryDados.ParamByName('NOMFRM').AsString := AConfiguracaoGrid.NomeFormulario;
      qryDados.ParamByName('NOMGRD').AsString := AConfiguracaoGrid.NomeGrid;
      qryDados.ExecSQL;

      Result := fCommit();
    Except
      fRollBack();
    End;
  Finally
    FreeAndNil(qryDados);
  End;
end;

{ TConfiguracaoGrid }

procedure TConfiguracaoGrid.SetCodigoOperador(const Value: String);
begin
  FCodigoOperador := Value;
end;

procedure TConfiguracaoGrid.SetConfiguracoesColunas(const Value: String);
begin
  FConfiguracoesColunas := Value;
end;

procedure TConfiguracaoGrid.SetNomeFormulario(const Value: String);
begin
  FNomeFormulario := Value;
end;

procedure TConfiguracaoGrid.SetNomeGrid(const Value: String);
begin
  FNomeGrid := Value;
end;

end.
