unit untFuncaoPortadores;


interface

uses
  System.SysUtils, System.Classes,  Data.DB,  Uni,

  untFuncoesSimples, untCfgRepositorio, dialogs;

  function fRetornarCfgsPortador(const ACamposCfg: TArrConfiguracoes): TArray<String>;
  function fMontarInCfgsPortador(const ACfgs: TArray<String>): String;
  function fListarCfgsVinculadasPortador(const ACodPor: String; const AInCfgsPortador: String): TStringList;
  function fPortadorPossuiVinculoEmCfg(const ACodPor: String;const ACfgsVinculadas: TStrings;out AMensagem: String): Boolean;
  procedure pValidarExclusaoPortadorAutcom(const ACodPor: String; const ACamposCfg: TArrConfiguracoes);
  procedure pValidarExclusaoPortadorDll(const ACodPor: String;const AInCfgsPortador: String);

implementation

uses
  untFuncoes,
  cxEdit;

type
  TTipoCfgExe = (
    tceNenhum,
    tceSimNao,
    tceSenha,
    tceConPortador,
    tceConPlanoDeContas,
    tceConFornecedor,
    tceConCentroDeCustos,
    tceTextoTam20,
    tceValorDecimal,
    tceTextoSemCase,
    tceConEmpresa,
    tceValorInteiro,
    tceConCartoesMultiSelecao
  );


function fGetTipoByProperties(
  ACfgRepositorio: TfrmCfgRepositorio;
  AProperties: TcxCustomEditProperties): TTipoCfgExe;
begin
  Result := tceNenhum;

  if not Assigned(AProperties) then
    Exit;

  if AProperties = ACfgRepositorio.btnConPortador.Properties then
    Exit(tceConPortador);

  if AProperties = ACfgRepositorio.btnConCta.Properties then
    Exit(tceConPlanoDeContas);

  if AProperties = ACfgRepositorio.btnConFornecedor.Properties then
    Exit(tceConFornecedor);

  if AProperties = ACfgRepositorio.btnConEvento.Properties then
    Exit(tceConCentroDeCustos);

  if AProperties = ACfgRepositorio.btnConCartaoMultiselecao.Properties then
    Exit(tceConCartoesMultiSelecao);

  if AProperties = ACfgRepositorio.edtSenha.Properties then
    Exit(tceSenha);

  if AProperties = ACfgRepositorio.edtTexto_Tam20.Properties then
    Exit(tceTextoTam20);

  if AProperties = ACfgRepositorio.edtTextoSemCase.Properties then
    Exit(tceTextoSemCase);

  if AProperties = ACfgRepositorio.edtValDin.Properties then
    Exit(tceValorDecimal);

  if AProperties = ACfgRepositorio.edtValPer.Properties then
    Exit(tceValorDecimal);

  if AProperties = ACfgRepositorio.spnValInt.Properties then
    Exit(tceValorInteiro);

  if AProperties = ACfgRepositorio.rdgSimNao_S_N.Properties then
    Exit(tceSimNao);
end;

function fGetPropertiesCfg(
  ACfgRepositorio: TfrmCfgRepositorio;
  const ACodCfg: String): TcxCustomEditProperties;
begin
  Result := nil;
  ACfgRepositorio.pRetProperties(ACodCfg, Result);
end;

function fRetornarCfgsPortador(const ACamposCfg: TArrConfiguracoes): TArray<String>;
var
  LCfgRepositorio: TfrmCfgRepositorio;
  LProps: TcxCustomEditProperties;
  LTipo: TTipoCfgExe;
  I: Integer;
begin
  SetLength(Result, 0);

  LCfgRepositorio := TfrmCfgRepositorio.Create(nil);

  try
    for I := Low(ACamposCfg) to High(ACamposCfg) do
    begin
      LProps := fGetPropertiesCfg(LCfgRepositorio, ACamposCfg[I].strCodCfg);
      LTipo := fGetTipoByProperties(LCfgRepositorio, LProps);

      if LTipo = tceConPortador then
      begin
        SetLength(Result, Length(Result) + 1);
        Result[High(Result)] := ACamposCfg[I].strCodCfg;
      end;
    end;
  finally
    LCfgRepositorio.Free;
  end;
end;

function fMontarInCfgsPortador(const ACfgs: TArray<String>): String;
var
  LContador: Integer;
begin
  Result := '';

  for LContador := Low(ACfgs) to High(ACfgs) do
  begin
    if Result <> '' then
      Result := Result + ',';

    Result := Result + QuotedStr(ACfgs[LContador]);
  end;

  if Trim(Result) = '' then
    raise Exception.Create('Não foi possível montar a lista de configurações de portador.');
end;

function fListarCfgsVinculadasPortador(
  const ACodPor: String;
  const AInCfgsPortador: String): TStringList;
var
  qryGen: TUniQuery;
  LstrSQL: String;
  LstrCodPor: String;
begin
  Result := TStringList.Create;
  qryGen := nil;
  LstrCodPor := Trim(ACodPor);

  try
    qryGen := fCriaQuery;
    try

      LstrSQL := '';
      LstrSQL := LstrSQL + ' SELECT ' + sLineBreak;
      LstrSQL := LstrSQL + '   SIS_CODEMP, ' + sLineBreak;
      LstrSQL := LstrSQL + '   SIS_CODCFG, ' + sLineBreak;
      LstrSQL := LstrSQL + '   SIS_DESCRI, ' + sLineBreak;
      LstrSQL := LstrSQL + '   SIS_VALCFG ' + sLineBreak;
      LstrSQL := LstrSQL + ' FROM CFGSIS ' + sLineBreak;
      LstrSQL := LstrSQL + ' WHERE SIS_CODCFG IN (' + AInCfgsPortador + ') ' + sLineBreak;
      LstrSQL := LstrSQL + '   AND TRIM(SIS_VALCFG) = :CODPOR ' + sLineBreak;
      LstrSQL := LstrSQL + ' ORDER BY SIS_CODCFG, SIS_CODEMP ';

      qryGen.SQL.Text := LstrSQL;
      qryGen.ParamByName('CODPOR').AsString := LstrCodPor;
      qryGen.Open;

      while not qryGen.Eof do
      begin
        Result.Add(
          'Empresa: ' + qryGen.FieldByName('SIS_CODEMP').AsString +
          ' - CFG: ' + qryGen.FieldByName('SIS_CODCFG').AsString +
          ' - ' + qryGen.FieldByName('SIS_DESCRI').AsString
        );

        qryGen.Next;
      end;

    finally
      FreeAndNil(qryGen);
    end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function fPortadorPossuiVinculoEmCfg(
  const ACodPor: String;
  const ACfgsVinculadas: TStrings;
  out AMensagem: String): Boolean;
var
  LContador: Integer;
  LstrCodPor: String;
begin
  AMensagem := '';
  LstrCodPor := Trim(ACodPor);

  Result := Assigned(ACfgsVinculadas) and (ACfgsVinculadas.Count > 0);

  if Result then
  begin
    AMensagem := 'Não é permitido excluir o portador ' + LstrCodPor +
                 ', pois ele está vinculado nas seguintes configurações:' +
                 sLineBreak + sLineBreak;

    for LContador := 0 to ACfgsVinculadas.Count - 1 do
      AMensagem := AMensagem + '- ' + ACfgsVinculadas[LContador] + sLineBreak;
  end;
end;

procedure pValidarExclusaoPortadorAutcom(
  const ACodPor: String;
  const ACamposCfg: TArrConfiguracoes);
var
  LarrCfgsPortador: TArray<String>;
  LstrInCfgsPortador: String;
  LstlCfgsVinculadas: TStringList;
  LstrMensagem: String;
begin
  LarrCfgsPortador := fRetornarCfgsPortador(ACamposCfg);

  if Length(LarrCfgsPortador) = 0 then
    raise Exception.Create('Nenhuma configuração de portador encontrada.');

  LstrInCfgsPortador := fMontarInCfgsPortador(LarrCfgsPortador);

  LstlCfgsVinculadas := nil;
  try
    LstlCfgsVinculadas := fListarCfgsVinculadasPortador(
      ACodPor,
      LstrInCfgsPortador
    );

    if fPortadorPossuiVinculoEmCfg(ACodPor, LstlCfgsVinculadas, LstrMensagem) then
      raise Exception.Create(LstrMensagem);

  finally
    FreeAndNil(LstlCfgsVinculadas);
  end;
end;

procedure pValidarExclusaoPortadorDll(const ACodPor: String; const AInCfgsPortador: String);
var
  LstlCfgsVinculadas: TStringList;
  LstrMensagem: String;
begin
  LstlCfgsVinculadas := nil;

  try
    LstlCfgsVinculadas := fListarCfgsVinculadasPortador(ACodPor, AInCfgsPortador);

    if fPortadorPossuiVinculoEmCfg(ACodPor, LstlCfgsVinculadas, LstrMensagem) then
      raise Exception.Create(LstrMensagem);

  finally
    FreeAndNil(LstlCfgsVinculadas);
  end;
end;


end.
