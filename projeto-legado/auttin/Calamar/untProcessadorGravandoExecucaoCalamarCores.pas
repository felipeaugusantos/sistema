unit untProcessadorGravandoExecucaoCalamarCores;

interface

uses
   Classes, DB, SysUtils, untIGravando,
   Variants, untAbstractProcessadorGravandoExecucaoCalamar, untIProcessadorGravandoExecucaoArquivosInsertGravando,
  Uni;

type
  TProcessadorGravandoExecucaoCalamarCores = class abstract(TAbstractProcessadorGravandoExecucaoCalamar,
    IProcessadorGravandoExecucaoArquivosInsertGravando)
  private
    qryBases: TDataSet;
    qryEmbalagens: TDataSet;
    qryColorantes: TDataSet;
    procedure GravarRegistroKey(const strPath: string; const qryKey: TDataSet; const qryOrigem: TDataSet;
      const qryDestino: TDataSet; const gravando: IGravando);
    procedure GravarRegistroFormulas(const strPath: string; const qryFormulas: TDataSet; const qryKey: TDataSet;
      const qryOrigem: TDataSet; const qryDestino: TDataSet; const gravando: IGravando);
    function GetBases(): TDataSet;
    function GetEmbalagems(): TDataSet;
    function GetColorantes(): TDataSet;
  protected
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
  public
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings); override;
    function GetSqlDestino(): string; override;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet; const gravando: IGravando); reintroduce; overload;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet); overload; override;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
      const qryOrigem, qryDestino: TDataSet); override;
    function fGetNomeGravacao(): string; override;
    procedure LimparTabelas; override;
    constructor Create(); override;
    destructor Destroy; override;
  end;

implementation

uses
   untDDLFactory, untADOFactory, ADODB, untStatusGravando, untFuncoesSimples, untAbstractAdoProcessadorGravandoExecucaoArquivos;

{ TProcessadorGravandoExecucaoCalamarEmbalagens }

constructor TProcessadorGravandoExecucaoCalamarCores.Create;
begin
  inherited;
  qryBases := nil;
  qryEmbalagens := nil;
  qryColorantes := nil;
end;

destructor TProcessadorGravandoExecucaoCalamarCores.Destroy;
begin
  if Assigned(qryBases) then FreeAndNil(qryBases);
  if Assigned(qryEmbalagens) then FreeAndNil(qryEmbalagens);
  if Assigned(qryColorantes) then FreeAndNil(qryColorantes);
  inherited;
end;

function TProcessadorGravandoExecucaoCalamarCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TProcessadorGravandoExecucaoCalamarCores.GetBases: TDataSet;
begin
  if not Assigned(qryBases) then
  begin
    qryBases := TADOFactory.GetAccessDataSet12(conf.fGet('CALPAT'));
    TADODataSet(qryBases).CommandType := cmdTable;
    TADODataSet(qryBases).CommandText := 'BASES';
    qryBases.Open;
    TADODataSet(qryBases).IndexFieldNames := 'ID';
  end;

  Result := qryBases;
end;

function TProcessadorGravandoExecucaoCalamarCores.GetColorantes: TDataSet;
begin
  if not Assigned(qryColorantes) then
  begin
    qryColorantes := TADOFactory.GetAccessDataSet12(conf.fGet('CALPAT'));
    TADODataSet(qryColorantes).CommandType := cmdTable;
    TADODataSet(qryColorantes).CommandText := 'COMPONENTS';
    qryColorantes.Open;
    TADODataSet(qryColorantes).IndexFieldNames := 'ID';
  end;

  Result := qryColorantes;
end;

function TProcessadorGravandoExecucaoCalamarCores.GetEmbalagems: TDataSet;
begin
  if not Assigned(qryEmbalagens) then
  begin
    qryEmbalagens := TADOFactory.GetAccessDataSet12(conf.fGet('CALPAT'));
    TADODataSet(qryEmbalagens).CommandType := cmdTable;
    TADODataSet(qryEmbalagens).CommandText := 'CANS';
    qryEmbalagens.Open;
    TADODataSet(qryEmbalagens).IndexFieldNames := 'ID';
  end;

  Result := qryEmbalagens;
end;

function TProcessadorGravandoExecucaoCalamarCores.GetSqlDestino: string;
begin
  Result := TDDLFactory.GetInsert('CAL_CADCAL');
end;

function TProcessadorGravandoExecucaoCalamarCores.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; 
begin
  Result := ' SELECT * FROM SF ';
end;

procedure TProcessadorGravandoExecucaoCalamarCores.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'CAL_CADCAL';
end;

procedure TProcessadorGravandoExecucaoCalamarCores.GravarRegistroKey(const strPath: string; const qryKey: TDataSet;
  const qryOrigem: TDataSet; const qryDestino: TDataSet; const gravando: IGravando);
var
  strNomeArquivo: string;
  qryFormulas: TADODataSet;
begin
  while (not qryKey.Eof) and (gravando.Status = sgGravando) do
  begin
    qryFormulas := nil;
    Try
      Try
        strNomeArquivo := strPath + '\' + qryKey.FieldByName('PATH').AsString + '\Formulas.mdb';
        gravando.Texto := Format('Processando arquivo [%s]', [strNomeArquivo]);

        qryFormulas := TADOFactory.GetAccessDataSet12(strNomeArquivo);
        qryFormulas.CommandType := cmdTable;
        qryFormulas.CommandText := 'Formulas';
        qryFormulas.Open;
        GravarRegistroFormulas(strPath + '\' + qryKey.FieldByName('PATH').AsString,
          qryFormulas,
          qryKey,
          qryOrigem,
          qryDestino,
          gravando);
      Except
        on E: Exception do
        begin
          gravando.Texto := Format('%s [%s]',
            [qryKey.FieldByName('DESCRIPTION').AsString,
            E.Message]);
        end;
      End;
    Finally
      if Assigned(qryFormulas) then FreeAndNil(qryFormulas);
      qryKey.Next;
    End;
  end;
end;

procedure TProcessadorGravandoExecucaoCalamarCores.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  //
end;

procedure TProcessadorGravandoExecucaoCalamarCores.GravarRegistroFormulas(const strPath: string; const qryFormulas, qryKey, qryOrigem,
  qryDestino: TDataSet; const gravando: IGravando);
var
  qryGrava: TUniQuery;
  stlFormula: TStringList;
  intCont: Integer;
  fltCapacidadeEmbalagemOriginal: Double;
begin
  stlFormula := nil;
  Try
    Try
      stlFormula := TStringList.Create;
      while (not qryFormulas.Eof) and (gravando.Status = sgGravando) do
      begin
        Try
          Try
            if not GetBases.Locate('ID', qryFormulas.FieldByName('BASE_ID').AsString, []) then
            begin
              Continue;
            end;

            if not GetEmbalagems.Locate('ID', qryFormulas.FieldByName('CAN_ID').AsString, []) then
            begin
              Continue;
            end;

            fltCapacidadeEmbalagemOriginal := GetEmbalagems.FieldByName('CAPACITY').AsFloat;

            GetEmbalagems.First;
            while not GetEmbalagems.Eof do
            begin
              qryGrava := TUniQuery(qryDestino);
              qryGrava.SQL.Clear;
              qryGrava.Params.Clear;
              qryGrava.SQL.Text := GetSqlDestino;

              qryGrava.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CAL_CADCAL', VS_strCodEmp);
              qryGrava.ParamByName('CAL_CODEMP').AsString := VS_strCodEmp;
              qryGrava.ParamByName('CAL_CODBAS').AsString := GetBases.FieldByName('CODE').AsString;;
              qryGrava.ParamByName('CAL_CODEMB').AsString := fStrZero(LimpaTexto(GetEmbalagems.FieldByName('ID').AsString), 3);
              qryGrava.ParamByName('CAL_KEY1__').AsString := qryFormulas.FieldByName('KEY1').AsString;
              qryGrava.ParamByName('CAL_KEY2__').AsString := qryFormulas.FieldByName('KEY2').AsString;
              qryGrava.ParamByName('CAL_KEY3__').AsString := qryFormulas.FieldByName('KEY3').AsString;
              qryGrava.ParamByName('CAL_PRODUT').AsString := qryOrigem.FieldByName('DESCRIPTION').AsString;
              qryGrava.ParamByName('CAL_COLECA').AsString := qryKey.FieldByName('DESCRIPTION').AsString;

              stlFormula.Clear;
              if ExtractStrings([';'], [], PWideChar(qryFormulas.FieldByName('FORMULA').AsString), stlFormula) <= 0 then
                Exit;

              for intCont := 1 to stlFormula.Count div 2 do
              begin
                GetColorantes.Locate('ID', stlFormula[(intCont * 2) - 2], []);
                qryGrava.ParamByName('CAL_CODC' + fStrZero(intCont, 2)).AsString := GetColorantes.FieldByName('CODE').AsString;
                qryGrava.ParamByName('CAL_QTDC' + fStrZero(intCont, 2)).AsFloat := (3.0729839993857053122643682646301) *
                  fStrToFloat(StringReplace(stlFormula[(intCont * 2) - 1], '.', ',', [rfReplaceAll])) *
                  GetEmbalagems.FieldByName('CAPACITY').AsFloat / fltCapacidadeEmbalagemOriginal;
              end;

              qryGrava.ParamByName('CAL_MD5KEY').AsString := GetMD5(qryGrava.ParamByName('CAL_CODBAS').AsString +
                qryGrava.ParamByName('CAL_CODEMB').AsString +
                qryGrava.ParamByName('CAL_KEY1__').AsString +
                qryGrava.ParamByName('CAL_KEY2__').AsString +
                qryGrava.ParamByName('CAL_KEY3__').AsString +
                qryGrava.ParamByName('CAL_PRODUT').AsString +
                qryGrava.ParamByName('CAL_COLECA').AsString);

              qryGrava.ExecSQL;
              GetEmbalagems.Next;
            end;
          Except
            on E: Exception do
            begin
              gravando.Texto := Format('%s - %s - %s - %s - %s,[%s: %s]', [
              qryOrigem.FieldByName('DESCRIPTION').AsString,
              qryKey.FieldByName('DESCRIPTION').AsString,
              qryFormulas.FieldByName('Key1').AsString,
              qryFormulas.FieldByName('Key2').AsString,
              qryFormulas.FieldByName('Key3').AsString,
              E.ClassName, E.Message]);
            end;
          End;
        Finally
          gravando.RegistrarProgresso(0,
            qryFormulas.RecNo,
            qryFormulas.RecordCount);
          qryFormulas.Next;
        End;
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(stlFormula) then FreeAndNil(stlFormula);
  End;

end;

procedure TProcessadorGravandoExecucaoCalamarCores.GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet; const gravando: IGravando);
var
  qryKey: TADODataSet;
  strNomeArquivo: string;
begin
  qryKey := nil;
  Try
    Try
      strNomeArquivo := ExtractFilePath(conf.fGet('CALPAT')) + qryOrigem.FieldByName('PATH').AsString + '\Key.mdb';
      qryKey := TADOFactory.GetAccessDataSet12(strNomeArquivo);
      qryKey.CommandType := cmdTable;
      qryKey.CommandText := 'SF';
      qryKey.Open;
      gravando.Texto := Format('Processando arquivo [%s]', [strNomeArquivo]);
      GravarRegistroKey(ExtractFilePath(conf.fGet('CALPAT')) + qryOrigem.FieldByName('PATH').AsString,
        qryKey,
        qryOrigem,
        qryDestino,
        gravando);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryKey) then FreeAndNil(qryKey);
  End;

end;

function TProcessadorGravandoExecucaoCalamarCores.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := False;
end;

procedure TProcessadorGravandoExecucaoCalamarCores.LimparTabelas;
begin
  fExecutaSQL('TRUNCATE TABLE CAL_CADCAL');
end;

procedure TProcessadorGravandoExecucaoCalamarCores.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível gravar a Cor %s, [%s: %s]',
    [qryOrigem.FieldByName('DESCRIPTION').AsString,
    E.ClassName,
    E.Message]);
end;

end.

