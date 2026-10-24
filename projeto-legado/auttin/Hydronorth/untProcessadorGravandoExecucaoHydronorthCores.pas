unit untProcessadorGravandoExecucaoHydronorthCores;

interface

uses   Classes, DB, SysUtils, untIGravando,
  Variants, untAbstractProcessadorGravandoExecucaoHydronorth, StrUtils, Uni,
  untIProcessadorGravandoExecucaoArquivosInsert;

type
  TProcessadorGravandoExecucaoHydronorthCores = class abstract(TAbstractProcessadorGravandoExecucaoHydronorth,
    IProcessadorGravandoExecucaoArquivosInsert)
  private
    intAuto: Integer;
    function GetOncaMl(const strOnca: string): Double;
    function GetQuantidade(const fltQuantidade: Double; const strEmbOrigem, EmbDestino: string): Double;
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
  untDDLFactory, untProcessadorGravandoExecucaoHydronorthEmbalagens,untFuncoesSimples, untFuncTinta, untAbstractAdoProcessadorGravandoExecucaoArquivos;

{ TProcessadorGravandoExecucaoHydronorthCores }

constructor TProcessadorGravandoExecucaoHydronorthCores.Create;
begin
  inherited Create;
  intAuto := 1;
end;

destructor TProcessadorGravandoExecucaoHydronorthCores.Destroy;
begin
  pAtualizaProCodAutInc('HYD_CADHYD', intAuto);
  inherited;
end;

function TProcessadorGravandoExecucaoHydronorthCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TProcessadorGravandoExecucaoHydronorthCores.GetOncaMl(const strOnca: string): Double;
var
  stlOnca: TStringList;
begin
  Result := 0;
  stlOnca := nil;
  Try
    Try
      stlOnca := TStringList.Create;
      stlOnca.Text := StringReplace(strOnca, 'Y', sLineBreak, [rfReplaceAll]);
      Result := fStrToFloat(FormatFloat('0.0000', (StrToIntDef(StringReplace(stlOnca[0], '.', ',', [rfReplaceAll]), 0) * 29.5735295625) +
        (fStrToFloat(StringReplace(stlOnca[1], '.', ',', [rfReplaceAll])) * 0.61611520)));
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(stlOnca) then FreeAndNil(stlOnca);
  End;                              
end;

function TProcessadorGravandoExecucaoHydronorthCores.GetQuantidade(const fltQuantidade: Double; const strEmbOrigem,
  EmbDestino: string): Double;
begin
  Result := fltQuantidade * TProcessadorGravandoExecucaoHydronorthEmbalagens.GetTamanhoEmbalagem(EmbDestino) /
    TProcessadorGravandoExecucaoHydronorthEmbalagens.GetTamanhoEmbalagem(strEmbOrigem);
end;

function TProcessadorGravandoExecucaoHydronorthCores.GetSqlDestino: string;
begin
  Result := TDDLFactory.GetInsertDelayed('HYD_CADHYD');
end;

function TProcessadorGravandoExecucaoHydronorthCores.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
var
  intCont: Integer;
begin
  Result :=
    ' SELECT                                   ' +
    '   [COLEÇÃO]                              ' +
    '   , [PRODUTO]                            ' +
    '   , [COR]                                ' +
    '   , [COR NOME LONGO]                     ' +
    '   , [BASE]                               ' +
    '   , [TAMANHO]                            ' +
    '   , [EMBALAGENS]                         ' +
    '   , [EMB]                                ';

  for intCont := 1 to 6 do
  begin
    Result := Result +
      '   , MID([COR' + IntToStr(intCont) + '] , 1, 6) AS COL' + IntToStr(intCont) + '           ' +
      '   , MID([COR' + IntToStr(intCont) + '] , 8, LEN([COR' + IntToStr(intCont) + '])) AS QTD' + IntToStr(intCont) + ' ';
  end;

  Result := Result +
    ' FROM                                     ' +
    '   [Hydronorth$]                          ' +
    '   , (' + TProcessadorGravandoExecucaoHydronorthEmbalagens.GetSqlOrigem + ') AS T ' +
    ' WHERE EMBALAGENS <> ''''                 ' +
    '   AND EMBALAGENS LIKE ''%'' & T.EMB & ''%''';
end;

procedure TProcessadorGravandoExecucaoHydronorthCores.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'HYD_CADHYD';
end;

procedure TProcessadorGravandoExecucaoHydronorthCores.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
var
  qryGrava: TUniQuery;
  intCont: Integer;
  fltQuantidade: Double;
  stlEmbalagens: TStringList;
begin
  stlEmbalagens := nil;
  Try
    Try
      qryGrava := qryDestino as TUniQuery;
      qryGrava.Params.Clear;
      qryGrava.SQL.Clear;
      qryGrava.SQL.Text := GetSqlDestino();

      stlEmbalagens := TStringList.Create;
      stlEmbalagens.Text := StringReplace(LimpaTexto(qryOrigem.FieldByName('EMBALAGENS').AsString), ';', sLineBreak, [rfReplaceAll]);

      if stlEmbalagens.IndexOf(LimpaTexto(qryOrigem.FieldByName('EMB').AsString)) < 0 then
      begin
        Exit;
      end;

      qryGrava.ParamByName('AUTOINCREM').AsString := fFormataAutInc(fInc(intAuto), VS_strCodEmp);
      qryGrava.ParamByName('HYD_CODEMP').AsString := VS_strCodEmp;
      qryGrava.ParamByName('HYD_COLECA').AsString := LimpaTexto(qryOrigem.FieldByName('COLEÇÃO').AsString);
      qryGrava.ParamByName('HYD_PRODUT').AsString := LimpaTexto(qryOrigem.FieldByName('PRODUTO').AsString);
      qryGrava.ParamByName('HYD_C_O_R_').AsString := LimpaTexto(qryOrigem.FieldByName('COR').AsString);
      qryGrava.ParamByName('HYD_CORLON').AsString := LimpaTexto(qryOrigem.FieldByName('COR NOME LONGO').AsString);
      qryGrava.ParamByName('HYD_BASE__').AsString := LimpaTexto(qryOrigem.FieldByName('BASE').AsString);
      qryGrava.ParamByName('HYD_CODEMB').AsString :=
        TProcessadorGravandoExecucaoHydronorthEmbalagens.GetCodigoEmbalagem(qryOrigem.FieldByName('EMB').AsString);

      for intCont := 1 to 6 do
      begin
        if fEmptyStr(qryOrigem.FieldByName('COL' + IntToStr(intCont)).AsString) then
          Break;

        fltQuantidade := GetOncaMl(qryOrigem.FieldByName('QTD' + IntToStr(intCont)).AsString);

        if fltQuantidade <= 0 then
          Break;

        qryGrava.ParamByName('HYD_FORM' + fStrZero(intCont, 2)).AsString := LimpaTexto(qryOrigem.FieldByName('COL' + IntToStr(intCont)).AsString);
        qryGrava.ParamByName('HYD_QTDC' + fStrZero(intCont, 2)).AsFloat := GetQuantidade(fltQuantidade,
          qryOrigem.FieldByName('TAMANHO').AsString, qryOrigem.FieldByName('EMB').AsString);
      end;

      qryGrava.ParamByName('HYD_MD5KEY').AsString := GetMD5(qryGrava.ParamByName('HYD_COLECA').AsString +
              qryGrava.ParamByName('HYD_PRODUT').AsString +
              qryGrava.ParamByName('HYD_C_O_R_').AsString +
              qryGrava.ParamByName('HYD_CORLON').AsString +
              qryGrava.ParamByName('HYD_BASE__').AsString +
              qryGrava.ParamByName('HYD_CODEMB').AsString);

      qryGrava.ExecSQL;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(stlEmbalagens) then FreeAndNil(stlEmbalagens);
  End;

end;

function TProcessadorGravandoExecucaoHydronorthCores.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := False;
end;

procedure TProcessadorGravandoExecucaoHydronorthCores.LimparTabelas;
begin
  TruncateTable('HYD_CADHYD');
end;

procedure TProcessadorGravandoExecucaoHydronorthCores.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível gravar a cor: [%s - %s - %s - %s - %s - %s], [%s: %s]',
    [qryOrigem.FieldByName('COLEÇÃO').AsString,
    qryOrigem.FieldByName('PRODUTO').AsString,
    qryOrigem.FieldByName('COR').AsString,
    qryOrigem.FieldByName('COR NOME LONGO').AsString,
    qryOrigem.FieldByName('BASE').AsString,
    qryOrigem.FieldByName('EMB').AsString,
    E.ClassName,
    E.Message]);
end;

end.
