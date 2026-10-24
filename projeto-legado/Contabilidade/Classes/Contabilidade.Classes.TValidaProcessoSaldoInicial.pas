unit Contabilidade.Classes.TValidaProcessoSaldoInicial;

interface

uses
  System.Generics.Collections, System.SysUtils, System.Classes,
  Data.DB, Uni, UniClientDataset,
  Contabilidade.Interfaces;

type
  TDictPendenciasSaldoInicial = TDictionary<String, TList<String>> ;
  TDictTabelasSaldoInicial = TDictionary<String, String> ;
  TDictSaldos = TDictionary<String, Double>;

  TDadosValidacaoSaldoInicial = record
    AConta: string;
    AEmpresa: string;
    AExercicio: string;
    AValor: Double;
    ACreDeb: Char;
    ACCusto: string;
  end;

  TValidaProcessoSaldoInicial = class
  private
    class function fGetChave(const AConta, AEmpresa: string; AExerci: string = ''): string; overload;
    class function fGetChave(const ADado: TDadosValidacaoSaldoInicial): string; overload;
    class function fGetFiltroEmpresas(AEmps: TStrings): string;

    class function fRetornaArrayMensagens(const ADadosValidacao: TDadosValidacaoSaldoInicial; ARegistrosDuplicados: TList<string> = nil; AcdsPlanco: TUniClientDataSet = nil; const ATplaco: string = ''): TList<string> ;
    class function fRetornaRegistrosDuplicadosBloco(const  ADadosValidacao: TList<TDadosValidacaoSaldoInicial>): TList<string>;
    class function fRetornaCdsDet(const AstrExercicio: string; var AEmps: TStrings): TUniClientDataSet;
    class function fRetornaSaldos(ADados: TList<TDadosValidacaoSaldoInicial>): TDictSaldos;
    class function fRetornaCdsPlanco(const AstrTplaco: string): TUniClientDataSet;
    class function fRetornaTplaco(const AstrCodEmp: string): string;

    class function fValidaNaturezaConta(var AMensagemValidacao: string; const AConta, ANature: string): boolean;
    class function fValidaPatrimonialConta(var AMensagemValidacao: string; const AConta, APatrim: String): boolean;

    class procedure pAcumulaMsgVetor(var AMensagemValidacao: string; var AArrMensagens: TList<string>) ;
    class procedure pMostraMensagens(const AArrMensagens: TDictPendenciasSaldoInicial; const AprocErros: TErroContabilProc) ;
    class function fRetornaEmpresasEmUso: TStrings;
    class procedure fVerificaVariosExerciciosArquivo(var ADictDadosMostrar: TDictPendenciasSaldoInicial; const ADadosValidacao: TList<TDadosValidacaoSaldoInicial>) ;
    class function fVerificaVariasEmpresasArquivo(var ADictDadosMostrar: TDictPendenciasSaldoInicial; const ADadosValidacao: TList<TDadosValidacaoSaldoInicial>): Boolean ;
    class function fValidaPlainiPosteriorAoExercicio(const AstrEmpresa, AstrExercicio: String; var ADictDadosMostrar: TDictPendenciasSaldoInicial): Boolean ;
  public
    class function fValidaSaldoInicialBloco(const ADadosValidacao: TList<TDadosValidacaoSaldoInicial>; const AprocErros: TErroContabilProc): boolean;
    class function fValidaPladet(const ADadosValidacao: TList<TDadosValidacaoSaldoInicial>; const AprocErros: TErroContabilProc; const AstrExerci: string; AlstEmps: TStrings): Boolean;
  end;

implementation

uses
  untFuncoesSimples, MaskUtils, StrUtils,
  Contabilidade.Funcoes, System.DateUtils, System.Types, Contabilidade.Classes.TValidaContasContabeis ;

{ TValidaProcessoSaldoInicial }

class function TValidaProcessoSaldoInicial.fGetChave(const AConta,
  AEmpresa: string; AExerci: string = ''): string;
begin
  Result := AConta + ';' + AEmpresa;

  if not fEmptyStr(AExerci) then
    Result := Result + ';' + AExerci;
end;

class function TValidaProcessoSaldoInicial.fGetChave(
  const ADado: TDadosValidacaoSaldoInicial): string;
begin
  Result := fGetChave(ADado.AConta, ADado.AEmpresa, ADado.AExercicio);
end;

class function TValidaProcessoSaldoInicial.fGetFiltroEmpresas(
  AEmps: TStrings): string;
var
  Lstr: string;
begin
  Result := '';

  if AEmps.Count = 0 then
    Exit;

  if AEmps.Count = 1 then
  begin
    Result := ' AND EMP_CODEMP = "' + AEmps[0] + '" ';
    Exit;
  end;

  for Lstr in AEmps do
  begin
    if Result <> '' then
      Result := Result + ', ';

    Result := Result + '"' + Lstr + '"';
  end;

  Result := ' AND EMP_CODEMP IN (' + Result + ') ';
end;

class function TValidaProcessoSaldoInicial.fRetornaArrayMensagens(
  const ADadosValidacao: TDadosValidacaoSaldoInicial;
  ARegistrosDuplicados: TList<string> = nil;
  AcdsPlanco: TUniClientDataSet = nil;
  const ATplaco: string = ''): TList<string> ;
var
  strMsg, strChave: string;
begin
  Result := TList<string>.Create;
  strMsg := '';

  if Assigned(AcdsPlanco) then
  begin
    if not AcdsPlanco.FindKey([ADadosValidacao.AConta]) then
    begin
      strMsg := Format('Conta contábil %s não cadastrada para o Tipo de Plano Contábil %s', [ADadosValidacao.AConta, ATplaco]);
      pAcumulaMsgVetor(strMsg, Result) ;
    end
    else
    begin
      fValidaNaturezaConta(strMsg, ADadosValidacao.AConta, AcdsPlanco.FieldByName('NCO_NATURE').AsString);
      pAcumulaMsgVetor(strMsg, Result) ;

      fValidaPatrimonialConta(strMsg, ADadosValidacao.AConta, AcdsPlanco.FieldByName('NCO_PATRIM').AsString);
      pAcumulaMsgVetor(strMsg, Result) ;
    end;
  end;

  if Assigned(ARegistrosDuplicados) then
  begin
    strChave := fGetChave(ADadosValidacao.AConta, ADadosValidacao.AEmpresa, ADadosValidacao.AExercicio);
    if ARegistrosDuplicados.IndexOf(strChave) <> -1 then
    begin
      strMsg := 'Exercício ['+ADadosValidacao.AExercicio+'] duplicado na planilha.';
      pAcumulaMsgVetor(strMsg, Result) ;
    end;
  end;
end;

class function TValidaProcessoSaldoInicial.fRetornaCdsDet(
  const AstrExercicio: string; var AEmps: TStrings): TUniClientDataSet;
var
  qryAux: TUniQuery;
begin
  Result := nil;

  if not fTabelaExiste('PLADET') then
    Exit;

  qryAux := fCriaQuery();
  try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT INI_CODCON, INI_CODEMP, INI_EXERCI, ');

    qryAux.SQL.Add('  SUM(IF(DET_CREDEB = "C", -DET_SALINI, DET_SALINI)) AS SALINI ');
    qryAux.SQL.Add('FROM PLAINI ');
    qryAux.SQL.Add('INNER JOIN PLADET ON PLAINI.AUTOINCREM = DET_PLAINC');
    qryAux.SQL.Add('INNER JOIN CADEMP ON EMP_CODEMP = INI_CODEMP ');
    qryAux.SQL.Add('INNER JOIN PLANCO ON NCO_CODCON = INI_CODCON ');
    qryAux.SQL.Add('  AND NCO_TPLACO = EMP_TPLACO  ');
    qryAux.SQL.Add('WHERE NCO_NATURE = "A" ');
    qryAux.SQL.Add(fFiltroSQLAtvPas('INI_CODCON', True));
    qryAux.SQL.Add(fGetFiltroEmpresas(AEmps));
    if AstrExercicio <> '' then
      qryAux.SQL.Add('  AND INI_EXERCI = ' + quotedstr(AstrExercicio));
    qryAux.SQL.Add('GROUP BY DET_PLAINC ');
    qryAux.Open;

    Result := fCriaClientDatset(qryAux);
    Result.IndexFieldNames := 'INI_CODCON;INI_CODEMP;INI_EXERCI';
    Result.Open;
  finally
    FreeAndNil(qryAux);
  end;
end;

class function TValidaProcessoSaldoInicial.fRetornaCdsPlanco(const AstrTplaco: string): TUniClientDataSet;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery();
  try
    qryAux.Close;
    qryAux.SQL.Text := 'SELECT NCO_CODCON, NCO_NATURE, NCO_PATRIM FROM PLANCO WHERE NCO_TPLACO = :TPLACO ';
    qryAux.ParamByName('TPLACO').AsString := AstrTplaco;
    qryAux.Open;

    Result := fCriaClientDatset(qryAux);
    Result.IndexFieldNames := 'NCO_CODCON';
    Result.Open;
  finally
    FreeAndNil(qryAux);
  end;
end;

class function TValidaProcessoSaldoInicial.fRetornaRegistrosDuplicadosBloco(
  const ADadosValidacao: TList<TDadosValidacaoSaldoInicial>): TList<string>;
var
  LItem: TDadosValidacaoSaldoInicial;
  lstControle: TList<string> ;
  LChave: string;
begin
  Result := TList<string>.Create ;
  lstControle := TList<string>.Create ;
  try
    for LItem in ADadosValidacao do
    begin
      LChave := Self.fGetChave(LItem.AConta, LItem.AEmpresa, LItem.AExercicio);
      if lstControle.IndexOf(LChave) = -1 then
      begin
        lstControle.Add(LChave) ;
      end
      else
      begin
        if Result.IndexOf(LChave) = -1 then
        begin
          Result.Add(LChave) ;
        end ;
      end;
    end;
  finally
    FreeAndNil(lstControle) ;
  end;
end;

class function TValidaProcessoSaldoInicial.fRetornaSaldos(
  ADados: TList<TDadosValidacaoSaldoInicial>): TDictSaldos;
var
  LDado: TDadosValidacaoSaldoInicial;
  LValor: Double;
begin
  Result := TDictSaldos.Create();
  for LDado in ADados do
  begin
    LValor := LDado.AValor;
    if LDado.ACreDeb <> #0 then
    begin
      LValor := Abs(LValor);

      if LDado.ACreDeb = 'C' then
        LValor := LValor * -1;
    end;

    Result.AddOrSetValue(fGetChave(LDado), LValor);
  end
end;

class function TValidaProcessoSaldoInicial.fRetornaTplaco(
  const AstrCodEmp: string): string;
begin
  Result := fCampoTabela('EMP_TPLACO', 'CADEMP', ['EMP_CODEMP'], [AstrCodEmp]);
end;

class function TValidaProcessoSaldoInicial.fRetornaEmpresasEmUso: TStrings;
var
  qryReg: TUniQuery;
  LStrs: TStringList;
begin
  qryReg := fCriaQuery() ;
  try
    try
      LStrs := TStringList.Create;

      qryReg.Close;
      qryReg.SQL.Clear;
      qryReg.SQL.Add('SELECT DISTINCT INI_CODEMP AS CODEMP FROM PLAINI WHERE INI_CODEMP IS NOT NULL ORDER BY INI_CODEMP ');
      qryReg.Open;

      while not qryReg.Eof do
      begin
        LStrs.Add(qryReg.FieldByName('CODEMP').AsString);
        qryReg.Next;
      end;
    except
      if Assigned(LStrs) then
        FreeAndNil(LStrs);

      raise;
    end;
  finally
    FreeandNil(qryReg);
  end;

  Result := LStrs;
end;

class function TValidaProcessoSaldoInicial.fValidaNaturezaConta(
  var AMensagemValidacao: string; const AConta, ANature: string): boolean;
begin
  Result := True;
  AMensagemValidacao := '';

  if ANature <> 'A' then
  begin
    Result := False;
    AMensagemValidacao := Format('Não é permitido a importação da Conta Contábil %s, em razão da mesma não estar classificada como uma Conta Contábil "Analítica".', [AConta]);
  end;
end;

class function TValidaProcessoSaldoInicial.fValidaPatrimonialConta(
  var AMensagemValidacao: string; const AConta, APatrim: String): boolean;
begin
  Result := True;
  AMensagemValidacao := '';

  if APatrim <> 'S' then
  begin
    Result := False;
    AMensagemValidacao := Format('Não é permitido a importação da Conta Contábil %s, em razão da mesma não estar classificada como uma Conta Contábil "Patrimonial".', [AConta]);
  end;
end;

class function TValidaProcessoSaldoInicial.fValidaPladet(
  const ADadosValidacao: TList<TDadosValidacaoSaldoInicial>;
  const AprocErros: TErroContabilProc; const AstrExerci: string;
  AlstEmps: TStrings): Boolean;
var
  LDictDadosMostrar: TDictPendenciasSaldoInicial;
  LDictSaldos: TDictSaldos;
  LcdsDet: TUniClientDataSet;
  LChave: string;
  LValor: Double;
  LlstMsg: TList<string>;
begin
  Result := False;
  LcdsDet := nil;
  LDictDadosMostrar := TDictPendenciasSaldoInicial.Create ;
  LDictSaldos := fRetornaSaldos(ADadosValidacao);
  try
    LcdsDet := fRetornaCdsDet(AstrExerci, AlstEmps);

    if not Assigned(LcdsDet) then
    begin
      Result := True;
      Exit;
    end;

    LcdsDet.First;
    while not LcdsDet.Eof do
    begin
      LChave := fGetChave(
        LcdsDet.FieldByName('INI_CODCON').AsString,
        LcdsDet.FieldByName('INI_CODEMP').AsString,
        LcdsDet.FieldByName('INI_EXERCI').AsString
      );

      if not LDictSaldos.TryGetValue(LChave, LValor) then
      begin
        LcdsDet.Next;
        Continue;
      end;

      if LValor = LcdsDet.FieldByName('SALINI').AsFloat then
      begin
        LcdsDet.Next;
        Continue;
      end;

      LlstMsg := TList<String>.Create;
      LlstMsg.Add('Registro possui PLADET, não pode ser ajustado.');

      LDictDadosMostrar.Add(LChave, LlstMsg);

      LcdsDet.Next;
    end;

    if LDictDadosMostrar.Count > 0 then
    begin
      pMostraMensagens(LDictDadosMostrar, AprocErros) ;
      exit ;
    end;

    Result := True;
  finally
    FreeandNil(LDictDadosMostrar);
    FreeAndNil(LDictSaldos);

    if Assigned(LcdsDet) then
      FreeAndNil(LcdsDet);
  end;
end;

class function TValidaProcessoSaldoInicial.fValidaPlainiPosteriorAoExercicio(
  const AstrEmpresa, AstrExercicio: String; var ADictDadosMostrar: TDictPendenciasSaldoInicial): Boolean;
var
  LqryVerif: TUniQuery ;
  LArrMensagens: TList<string>;
  LstrExercicios: String ;
begin
  Result := False ;
  LqryVerif := fCriaQuery ;
  try
    LqryVerif.Close ;
    LqryVerif.SQL.Clear ;
    LqryVerif.SQL.Add('SELECT DISTINCT INI_EXERCI FROM PLAINI WHERE INI_CODEMP = :CODEMP AND INI_EXERCI > :EXERCI') ;
    LqryVerif.ParamByName('CODEMP').AsString := AstrEmpresa ;
    LqryVerif.ParamByName('EXERCI').AsString := AstrExercicio ;
    LqryVerif.Open ;
    if LqryVerif.IsEmpty then
    begin
      LqryVerif.Close ;
      LqryVerif.SQL.Clear ;
      LqryVerif.SQL.Add('SELECT DISTINCT INI_EXERCI FROM PLAINI WHERE INI_CODEMP = :CODEMP AND INI_EXERCI = :EXERCI') ;
      LqryVerif.ParamByName('CODEMP').AsString := AstrEmpresa ;
      LqryVerif.ParamByName('EXERCI').AsString := AstrExercicio ;
      LqryVerif.Open ;
      if not LqryVerif.IsEmpty then
      begin
        if fMensagem('ATENÇÃO!', 'Já existe saldos iniciais para esse exercício['+AstrExercicio+'], desaja sobrepor?', ['&Sim', '&Não'], 1) = 2 then
          Exit;
      end ;
    end
    else
    begin
      LqryVerif.First ;
      LstrExercicios := '' ;
      while not LqryVerif.Eof do
      begin
        LstrExercicios := LstrExercicios + ifThen(fEmptyStr(LstrExercicios), '', ',') + LqryVerif.FieldByName('INI_EXERCI').AsString ;
        LqryVerif.Next ;
      end ;

      LArrMensagens := TList<string>.Create;
      LArrMensagens.Add('A importação não poderá ser executada, em razão da existência de registro em outros exercícios!');
      ADictDadosMostrar.Add(LstrExercicios, LArrMensagens);
    end ;
  finally
    FreeAndNil(LqryVerif) ;
  end ;
  Result := True ;
end;

class function TValidaProcessoSaldoInicial.fValidaSaldoInicialBloco(
  const ADadosValidacao: TList<TDadosValidacaoSaldoInicial>;
  const AprocErros: TErroContabilProc): boolean;
var
  LDictDadosMostrar: TDictPendenciasSaldoInicial;
  LLstRegistroDuplicado: TList<string>;
  LLstEmpresasEmUso: TStrings;
  LDadoValidacao: TDadosValidacaoSaldoInicial;
  LArrMensagens: TList<string>;
  LChave, LTplaco: string;
  LcdsPlanco: TUniClientDataSet;
begin
  Result := False ;
  LDictDadosMostrar := TDictPendenciasSaldoInicial.Create ;
  LLstRegistroDuplicado := fRetornaRegistrosDuplicadosBloco(ADadosValidacao) ;
  LLstEmpresasEmUso := fRetornaEmpresasEmUso;
  LcdsPlanco := nil;
  try
    if ADadosValidacao.Count = 0 then
    begin
      LArrMensagens := TList<string>.Create;
      LArrMensagens.Add('Nenhum registro encontrado!');
      LDictDadosMostrar.Add('', LArrMensagens);
      pMostraMensagens(LDictDadosMostrar, AprocErros) ;
      Exit;
    end;

    if Self.fVerificaVariasEmpresasArquivo(LDictDadosMostrar, ADadosValidacao) then
    begin
      pMostraMensagens(LDictDadosMostrar, AprocErros) ;
      Exit ;
    end;

    Self.fVerificaVariosExerciciosArquivo(LDictDadosMostrar, ADadosValidacao) ;

    if not Self.fValidaPlainiPosteriorAoExercicio(ADadosValidacao.Items[0].AEmpresa,
                                                  ADadosValidacao.Items[0].AExercicio,
                                                  LDictDadosMostrar) then
      Exit ;

    LTplaco := fRetornaTplaco(ADadosValidacao.Items[0].AEmpresa);
    if LTplaco.IsEmpty then
    begin
      LArrMensagens := TList<string>.Create;
      LArrMensagens.Add(Format('Empresa %s não está associada a um Tipo de Plano Contábil!', [ADadosValidacao.Items[0].AEmpresa]));
      LDictDadosMostrar.Add(ADadosValidacao.Items[0].AEmpresa, LArrMensagens);
    end
    else
      LcdsPlanco := fRetornaCdsPlanco(LTplaco);

    for LDadoValidacao in ADadosValidacao do
    begin
      LChave := fGetChave(LDadoValidacao.AConta, LDadoValidacao.AEmpresa);

      LArrMensagens := fRetornaArrayMensagens(LDadoValidacao, LLstRegistroDuplicado, LcdsPlanco, LTplaco) ;

      if (LArrMensagens.Count > 0) and (not LDictDadosMostrar.ContainsKey(LChave)) then
        LDictDadosMostrar.Add(LChave, LArrMensagens)
      else
        FreeAndNil(LArrMensagens);
    end;

    if LDictDadosMostrar.Count > 0 then
    begin
      pMostraMensagens(LDictDadosMostrar, AprocErros) ;
      exit ;
    end;
  finally
    FreeAndNil(LDictDadosMostrar);
    FreeAndNil(LLstRegistroDuplicado);
    FreeAndNil(LLstEmpresasEmUso);
    if assigned(LcdsPlanco) then
      FreeAndNil(LcdsPlanco);
  end;

  Result := True;
end;

class function TValidaProcessoSaldoInicial.fVerificaVariasEmpresasArquivo(
  var ADictDadosMostrar: TDictPendenciasSaldoInicial;
  const ADadosValidacao: TList<TDadosValidacaoSaldoInicial>): Boolean;
var
  LlstEmpresa : TStringList ;
  LDadoValidacao: TDadosValidacaoSaldoInicial;
  LArrMensagens: TList<string>;
begin
  Result := False;

  LlstEmpresa := TStringList.Create ;
  try
    LlstEmpresa.Sorted := True ;
    for LDadoValidacao in ADadosValidacao do
    begin
      if LlstEmpresa.IndexOf(LDadoValidacao.AEmpresa) < 0 then
        LlstEmpresa.Add(LDadoValidacao.AEmpresa) ;
    end ;

    if LlstEmpresa.Count > 1 then
    begin
      Result := True;
      LArrMensagens := TList<string>.Create;
      LArrMensagens.Add('Permitido apenas uma empresa por arquivo!');
      ADictDadosMostrar.Add(LlstEmpresa.DelimitedText, LArrMensagens);
    end ;

  finally
    FreeAndNil(LlstEmpresa) ;
  end ;
end;

class procedure TValidaProcessoSaldoInicial.fVerificaVariosExerciciosArquivo(
  var ADictDadosMostrar: TDictPendenciasSaldoInicial;
  const ADadosValidacao: TList<TDadosValidacaoSaldoInicial>);
var
  LlstExercicio : TStringList ;
  LDadoValidacao: TDadosValidacaoSaldoInicial;
  LArrMensagens: TList<string>;
begin
  LlstExercicio := TStringList.Create ;
  try
    LlstExercicio.Sorted := True ;
    for LDadoValidacao in ADadosValidacao do
    begin
      if LlstExercicio.IndexOf(LDadoValidacao.AExercicio) < 0 then
        LlstExercicio.Add(LDadoValidacao.AExercicio) ;
    end ;

    if LlstExercicio.Count > 1 then
    begin
      LArrMensagens := TList<string>.Create;
      LArrMensagens.Add('Permitido apenas uma exercício por arquivo!');
      ADictDadosMostrar.Add(LlstExercicio.DelimitedText, LArrMensagens);
    end ;

  finally
    FreeAndNil(LlstExercicio) ;
  end ;
end;

class procedure TValidaProcessoSaldoInicial.pAcumulaMsgVetor(
  var AMensagemValidacao: string; var AArrMensagens: TList<string>);
begin
  if not fEmptyStr(AMensagemValidacao) then
  begin
    AArrMensagens.Add(AMensagemValidacao) ;
  end;
  AMensagemValidacao := '' ;
end;

class procedure TValidaProcessoSaldoInicial.pMostraMensagens(
  const AArrMensagens: TDictPendenciasSaldoInicial;
  const AprocErros: TErroContabilProc);
var
  objMensagens: TValidaContaContabil ;
  strItem: string ;
  regDoc: TContaErro ;
  LPair: TPair<string, TList<string>> ;
begin
  objMensagens := TValidaContaContabil.Create ;
  try
    for LPair in AArrMensagens do
    begin
      for strItem in LPair.Value do
      begin
        regDoc.strChaveDocumento := LPair.Key ;
        regDoc.strMotivo := strItem ;
        regDoc.strWarning := 'N' ;
        objMensagens.pAddErro(regDoc, Nil);
      end;

      LPair.Value.Free;
    end;

    if Assigned(AprocErros) then
      AprocErros(objMensagens.DataSet) ;

  finally
    FreeAndNil(objMensagens) ;
  end;
end;

end.
