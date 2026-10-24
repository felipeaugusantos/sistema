unit Contabilidade.Classes.TValidaProcessoSaldoInicialSubconta;

interface

uses System.Generics.Collections, System.SysUtils, System.Classes, Contabilidade.Interfaces,
    Uni, UniClientDataset, Data.DB;

type
  TDadosValidacaoSaldoInicialSub = record
    AConta: string;
    AEmpresa: string;
    AExercicio: string;
    AValor: Double;
    ACreDeb: Char;
    ATipFC: Char;
    ACliFor: string;
  end;

  TDadosSoma = record
    AExercicios: string;
    ATotal: Double;
  end;

  TDictSomaSaldosIniciaisSub = TDictionary<String, TDadosSoma>;
  TDictPendenciasSaldoInicialSub = TDictionary<String, TList<String>> ;
  TDictSaldosSubconta = TDictionary<String, Double>;

  TValidaProcessoSaldoInicialSubconta = class
  private
    class function fGetChave(const AConta, AEmpresa: string): string;
    class procedure pDesmembraChave(const AChave: string; var AConta, AEmpresa: string);
    class function fGetChaveDet(ADado: TDadosValidacaoSaldoInicialSub): string; overload;
    class function fGetChaveDet(const AConta, AEmpresa, AExercicio, ATipFC, ACliFor: string): string; overload;
    class function fGetFiltroEmpresas(AEmps: TStrings): string;

    class function fRetornaArrayMensagens(const AChave: string; const ADados: TDadosSoma; ACdsPlanco: TUniClientDataset; AEmpresas: TStrings): TList<string> ;
    class function fRetornaEmpresas: TStrings;
    class function fRetornaSomaSaldos(ADados: TList<TDadosValidacaoSaldoInicialSub>): TDictSomaSaldosIniciaisSub;
    class function fRetornaMsgSaldoPrevistoEImportado(const APrevisto, AImportado: Double): string;
    class function fRetornaMsgCliForInexistente(const ACodigo: string; const ACliFor: Char): string;
    class function fRetornaCliFor: TUniClientDataSet;
    class function fRetornaCdsDet(const AstrExercicio: string; var AEmps: TStrings): TUniClientDataSet;
    class function fRetornaSaldosSubconta(ADados: TList<TDadosValidacaoSaldoInicialSub>): TDictSaldosSubconta;

    class procedure pAcumulaMsgVetor(var AMensagemValidacao: string; var AArrMensagens: TList<string>) ;
    class procedure pMostraMensagens(const AArrMensagens: TDictPendenciasSaldoInicialSub; const AprocErros: TErroContabilProc) ;

  public
    class function fValidaSaldoInicialSubcontasBloco(const ADadosValidacao: TList<TDadosValidacaoSaldoInicialSub>; const AprocErros: TErroContabilProc; ACdsPlanco: TUniClientDataset = nil): boolean;
    class function fValidaDprDet(const ADadosValidacao: TList<TDadosValidacaoSaldoInicialSub>; const AprocErros: TErroContabilProc; const AstrExerci: string; AlstEmps: TStrings): Boolean;
  end;

  const EXERCICIO_VAZIO = 'EMPTY';

implementation

uses UntFuncoesSimples, MaskUtils, StrUtils, System.DateUtils, System.Types,
  Contabilidade.Funcoes, Contabilidade.Classes.TValidaContasContabeis ;

{ TValidaProcessoSaldoInicialSubconta }

class function TValidaProcessoSaldoInicialSubconta.fGetChave(const AConta,
  AEmpresa: string): string;
begin
  Result := AConta + ';' + AEmpresa;
end;

class function TValidaProcessoSaldoInicialSubconta.fGetChaveDet(
  ADado: TDadosValidacaoSaldoInicialSub): string;
begin
  Result := Self.fGetChaveDet(ADado.AConta, ADado.AEmpresa, ADado.AExercicio, ADado.ATipFC, ADado.ACliFor);
end;

class function TValidaProcessoSaldoInicialSubconta.fGetChaveDet(const AConta,
  AEmpresa, AExercicio, ATipFC, ACliFor: string): string;
begin
  Result := AConta + '|' + AEmpresa + '|' + AExercicio + '|' + ATipFC + '|' + ACliFor;
end;

class function TValidaProcessoSaldoInicialSubconta.fGetFiltroEmpresas(
  AEmps: TStrings): string;
var
  Lstr: string;
begin
  Result := '';

  if AEmps.Count = 0 then
    Exit;

  if AEmps.Count = 1 then
  begin
    Result := ' AND INI_CODEMP = "' + AEmps[0] + '" ';
    Exit;
  end;

  for Lstr in AEmps do
  begin
    if Result <> '' then
      Result := Result + ', ';

    Result := Result + '"' + Lstr + '"';
  end;

  Result := ' AND INI_CODEMP IN (' + Result + ') ';
end;

class function TValidaProcessoSaldoInicialSubconta.fRetornaArrayMensagens(
  const AChave: string; const ADados: TDadosSoma; ACdsPlanco: TUniClientDataset;
  AEmpresas: TStrings): TList<string>;
var
  strMsg, strConta, strEmpresa, strExerci: string;
  lstExerci: TStringList;
  fltValor: Double;
begin
  Result := TList<string>.Create;

  pDesmembraChave(AChave, strConta, strEmpresa);

  if AEmpresas.IndexOf(strEmpresa) = -1 then
  begin
    strMsg := 'A Empresa [' + strEmpresa + '] não está cadastrada. ';
    pAcumulaMsgVetor(strMsg, Result);
    Exit;
  end;

  if ACdsPlanco.FindKey([strConta, strEmpresa]) then
  begin
    if fEmptyStr(ACdsPlanco.FieldByName('EXERCI').AsString) then
    begin
      strMsg := 'O Exercício não foi preenchido na tela de conferência. ';
      pAcumulaMsgVetor(strMsg, Result);
      Exit;
    end;

    lstExerci := TStringList.Create;
    try
      lstExerci.Delimiter := ';';
      lstExerci.DelimitedText := ADados.AExercicios;

      for strExerci in lstExerci do
      begin
        if strExerci = EXERCICIO_VAZIO then
        begin
          strMsg := 'Existe(m) registro(s) com exercício em branco na planilha. ';
          pAcumulaMsgVetor(strMsg, Result);
          Continue;
        end;

        if strExerci <> ACdsPlanco.FieldByName('EXERCI').AsString then
        begin
          strMsg := 'O Exercício [' + strExerci + '] não foi previsto na tela de conferência. ';
          pAcumulaMsgVetor(strMsg, Result);
          Continue;
        end;

        fltValor := fFormataFloat(ACdsPlanco.FieldByName('SALINI').AsFloat, 2);
        if ACdsPlanco.FieldByName('DEBCRE').AsString = 'C' then
          fltValor := fltValor * -1;

        if fFormataFloat(ADados.ATotal, 2) <> fltValor then
        begin
          strMsg := fRetornaMsgSaldoPrevistoEImportado(fltValor, ADados.ATotal);
          pAcumulaMsgVetor(strMsg, Result);
        end;
      end;
    finally
      FreeAndNil(lstExerci);
    end;
  end

  else
  begin
    strMsg := 'A Conta [' + strConta + '] não existe ou é ínválida. A Conta deve ser de natureza analítica e aceitar subcontas. ';
    pAcumulaMsgVetor(strMsg, Result);
  end;

end;

class function TValidaProcessoSaldoInicialSubconta.fRetornaCdsDet(const AstrExercicio: string; var AEmps: TStrings): TUniClientDataSet;
var
  qryAux: TUniQuery;
begin
  Result := nil;

  if not fTabelaExiste('DPRDET') then
    Exit;

  qryAux := fCriaQuery();
  try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT DET_CODCON, DET_EXERCI, DET_CODEMP, DET_CLIFOR, DET_TIP_FC, ');
    qryAux.SQL.Add('  SUM(IF(DET_CREDEB = "C", -DET_SALINI, DET_SALINI)) AS SALINI ');
    qryAux.SQL.Add('FROM DPRINI ');
    qryAux.SQL.Add('INNER JOIN DPRDET ON DET_CODCON = INI_CODCON ');
    qryAux.SQL.Add('  AND DET_CLIFOR = INI_CLIFOR ');
    qryAux.SQL.Add('  AND DET_TIP_FC = INI_TIP_FC ');
    qryAux.SQL.Add('  AND DET_EXERCI = INI_EXERCI ');
    qryAux.SQL.Add('  AND DET_CODEMP = INI_CODEMP ');
    qryAux.SQL.Add('INNER JOIN CADEMP ON EMP_CODEMP = INI_CODEMP ');
    qryAux.SQL.Add('INNER JOIN PLANCO ON  NCO_CODCON = INI_CODCON ');
    qryAux.SQL.Add('  AND NCO_TPLACO = EMP_TPLACO ');
    qryAux.SQL.Add('WHERE NCO_NATURE = "A" ');
    qryAux.SQL.Add(fFiltroSQLAtvPas('INI_CODCON'));
    if AstrExercicio <> '' then
      qryAux.SQL.Add('  AND INI_EXERCI = ' + quotedstr(AstrExercicio));
    qryAux.SQL.Add(fGetFiltroEmpresas(AEmps));
    qryAux.SQL.Add('GROUP BY DET_CODCON, DET_EXERCI, DET_CODEMP, DET_CLIFOR, DET_TIP_FC ');

    qryAux.Open;

    Result := fCriaClientDatset(qryAux);
    Result.IndexFieldNames := 'DET_CODCON;DET_EXERCI;DET_CODEMP;DET_CLIFOR;DET_TIP_FC';
    Result.Open;
  finally
    FreeAndNil(qryAux);
  end;
end;

class function TValidaProcessoSaldoInicialSubconta.fRetornaCliFor: TUniClientDataSet;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery();
  try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT LPAD(CLI_CODCLI, 8, "0") AS CODIGO, "C" AS FORCLI FROM CADCLI ');
    qryAux.SQL.Add('UNION ');
    qryAux.SQL.Add('SELECT LPAD(FOR_CODFOR, 8, "0") AS CODIGO, "F" AS FORCLI FROM CADFOR ');

    qryAux.Open;

    Result := fCriaClientDatset(qryAux);
    Result.IndexFieldNames := 'CODIGO;FORCLI';
    Result.Open;
  finally
    FreeAndNil(qryAux);
  end;
end;

class function TValidaProcessoSaldoInicialSubconta.fRetornaEmpresas: TStrings;
var
  qryEmp : TUniQuery;
  strs: TStringList;
begin

  qryEmp := fCriaQuery();
  try
    try
      qryEmp.Close;
      qryEmp.SQL.Text := 'SELECT EMP_CODEMP AS CODEMP FROM CADEMP ';
      qryEmp.Open;
      strs:= TStringList.Create;

      while not qryEmp.Eof do
      begin
        strs.Add(qryEmp.FieldByName('CODEMP').AsString);
        qryEmp.Next;
      end;

    except
      if Assigned(strs) then
        FreeAndNil(strs);

        raise;
    end;
  finally
    FreeAndNil(qryEmp);
  end;

  Result := strs;
end;

class function TValidaProcessoSaldoInicialSubconta.fRetornaMsgCliForInexistente(
  const ACodigo: string; const ACliFor: Char): string;
var
  LCliForStr: string;
begin
  if ACliFor = 'F' then
    LCliForStr := 'Fornecedor'
  else
    LCliForStr := 'Cliente';

  Result := 'Não existe ' + LCliForStr + ' cadastrado com o código informado ['+ ACodigo +'].';
end;

class function TValidaProcessoSaldoInicialSubconta.fRetornaMsgSaldoPrevistoEImportado(
  const APrevisto, AImportado: Double): string;
begin
  Result := '';

  if APrevisto = AImportado then
    Exit;

  Result := 'Divergência entre o total de saldos previsto e importado. ';
  Result := Result + 'Previsto: ' + FormatFloat('#,##0.00', Abs(APrevisto)) + ' ('+ ifThen(APrevisto < 0, 'C', 'D') +') ';
  Result := Result + 'Importado: ' + FormatFloat('#,##0.00', Abs(AImportado)) + ' ('+ ifThen(AImportado < 0, 'C', 'D') +') ';
end;

class function TValidaProcessoSaldoInicialSubconta.fRetornaSaldosSubconta(
  ADados: TList<TDadosValidacaoSaldoInicialSub>): TDictSaldosSubconta;
var
  LDado: TDadosValidacaoSaldoInicialSub;
  LValor: Double;
begin
  Result := TDictSaldosSubconta.Create();
  for LDado in ADados do
  begin
    LValor := Abs(LDado.AValor);

    if LDado.ACreDeb = 'C' then
      LValor := LValor * -1;

    Result.AddOrSetValue(fGetChaveDet(LDado), LValor);
  end
end;

class function TValidaProcessoSaldoInicialSubconta.fRetornaSomaSaldos(
  ADados: TList<TDadosValidacaoSaldoInicialSub>): TDictSomaSaldosIniciaisSub;
var
  LDado: TDadosValidacaoSaldoInicialSub;
  LDadoSoma: TDadosSoma;
  LChave: String;
  LExercicio: string;
begin
  Result := TDictSomaSaldosIniciaisSub.Create;

  for LDado in ADados do
  begin
    LChave := fGetChave(LDado.AConta, LDado.AEmpresa);

    if fEmptyStr(LDado.AExercicio) then
        LExercicio := EXERCICIO_VAZIO
    else
      LExercicio := LDado.AExercicio;

    if Result.TryGetValue(LChave, LDadoSoma) then
    begin
      if not LDadoSoma.AExercicios.Contains(LExercicio) then
        LDadoSoma.AExercicios := LDadoSoma.AExercicios + ';' + LExercicio;
    end
    else
    begin
      FillChar(LDadoSoma, sizeOf(LDadoSoma), #0);
      LDadoSoma.AExercicios := LExercicio;
      LDadoSoma.ATotal := 0;
    end;

    if LDado.ACreDeb = 'C' then
      LDadoSoma.ATotal := LDadoSoma.ATotal - LDado.AValor
    else
      LDadoSoma.ATotal := LDadoSoma.ATotal + LDado.AValor;

    Result.AddOrSetValue(LChave, LDadoSoma);
  end;
end;

class function TValidaProcessoSaldoInicialSubconta.fValidaDprDet(
  const ADadosValidacao: TList<TDadosValidacaoSaldoInicialSub>;
  const AprocErros: TErroContabilProc; const AstrExerci: string;
  AlstEmps: TStrings): Boolean;
var
  LDictDadosMostrar: TDictPendenciasSaldoInicialSub;
  LDictSaldos: TDictSaldosSubconta;
  LcdsDet: TUniClientDataSet;
  LChave: string;
  LValor: Double;
  LlstMsg: TList<string>;
begin
  Result := False;
  LcdsDet := nil;
  LDictDadosMostrar := TDictPendenciasSaldoInicialSub.Create ;
  LDictSaldos := fRetornaSaldosSubconta(ADadosValidacao);
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
      LChave := fGetChaveDet(
        LcdsDet.FieldByName('DET_CODCON').AsString,
        LcdsDet.FieldByName('DET_CODEMP').AsString,
        LcdsDet.FieldByName('DET_EXERCI').AsString,
        LcdsDet.FieldByName('DET_TIP_FC').AsString,
        LcdsDet.FieldByName('DET_CLIFOR').AsString
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
      LlstMsg.Add('Registro possui DPRDET, não pode ser ajustado.');

      LDictDadosMostrar.Add(LChave, LlstMsg);

      LcdsDet.Next;
    end;

    if LDictDadosMostrar.Count > 0 then
    begin
      pMostraMensagens(LDictDadosMostrar, AprocErros) ;
      Exit ;
    end;

    Result := True;
  finally
    FreeandNil(LDictDadosMostrar);
    FreeAndNil(LDictSaldos);

    if Assigned(LcdsDet) then
      FreeAndNil(LcdsDet);
  end;
end;

class function TValidaProcessoSaldoInicialSubconta.fValidaSaldoInicialSubcontasBloco(
  const ADadosValidacao: TList<TDadosValidacaoSaldoInicialSub>;
  const AprocErros: TErroContabilProc;
  ACdsPlanco: TUniClientDataset): boolean;
var
  LDictDadosMostrar: TDictPendenciasSaldoInicialSub;
  LDictSomaSaldos: TDictSomaSaldosIniciaisSub;
  LPair: TPair<string, TDadosSoma>;
  LArrMensagens: TList<string>;
  LEmpresas: TStrings;
  LChave: string;
  LTemMensagens: Boolean;
  LPrevisto: Double;
  LCdsCliFor: TUniClientDataSet;
  LDado: TDadosValidacaoSaldoInicialSub;
begin
  Result := False;
  LEmpresas := fRetornaEmpresas;
  LDictDadosMostrar := TDictPendenciasSaldoInicialSub.Create ;
  LDictSomaSaldos := fRetornaSomaSaldos(ADadosValidacao);
  LCdsCliFor := fRetornaCliFor;
  try
    for LPair in LDictSomaSaldos do
    begin
      LArrMensagens := fRetornaArrayMensagens(LPair.Key, LPair.Value, ACdsPlanco, LEmpresas);

      if (LArrMensagens.Count > 0) and (not LDictDadosMostrar.ContainsKey(LPair.Key)) then
        LDictDadosMostrar.Add(LPair.Key, LArrMensagens)
      else
        FreeAndNil(LArrMensagens);
    end;

    for LDado in ADadosValidacao do
    begin
      if not LCdsCliFor.FindKey([fPadL(LDado.ACliFor.Trim, 8, '0'), LDado.ATipFC]) then
      begin
        LChave := fGetChave(LDado.AConta, LDado.AEmpresa);
        LTemMensagens := LDictDadosMostrar.TryGetValue(LChave, LArrMensagens);
        if not LTemMensagens then
          LArrMensagens := TList<String>.Create;

        LArrMensagens.Add(fRetornaMsgCliForInexistente(LDado.ACliFor, LDado.ATipFC));

        if not LTemMensagens then
          LDictDadosMostrar.AddOrSetValue(LChave, LArrMensagens);
      end;
    end;

    ACdsPlanco.First;
    while not ACdsPlanco.Eof do
    begin
      if ACdsPlanco.FieldByName('SALINI').AsFloat = 0 then
      begin
        ACdsPlanco.Next;
        Continue;
      end;

      LChave := fGetChave(ACdsPlanco.FieldByName('CODCON').AsString, ACdsPlanco.FieldByName('CODEMP').AsString);
      if not LDictSomaSaldos.ContainsKey(LChave) then
      begin
        LTemMensagens := LDictDadosMostrar.TryGetValue(LChave, LArrMensagens);
        if not LTemMensagens then
          LArrMensagens := TList<String>.Create;

        LPrevisto := ACdsPlanco.FieldByName('SALINI').AsFloat;
        if ACdsPlanco.FieldByName('DEBCRE').AsString = 'C' then
          LPrevisto := LPrevisto * -1;

        LArrMensagens.Add(fRetornaMsgSaldoPrevistoEImportado(LPrevisto, 0));

        if not LTemMensagens then
          LDictDadosMostrar.AddOrSetValue(LChave, LArrMensagens);
      end;

      ACdsPlanco.Next;
    end;
    ACdsPlanco.First;

    if LDictDadosMostrar.Count > 0 then
    begin
      pMostraMensagens(LDictDadosMostrar, AprocErros) ;
      exit ;
    end;
  finally
    FreeAndNil(LCdsCliFor);
    FreeAndNil(LDictSomaSaldos);
    FreeandNil(LDictDadosMostrar);
    FreeandNil(LEmpresas);
  end;

  Result := True;
end;

class procedure TValidaProcessoSaldoInicialSubconta.pAcumulaMsgVetor(
  var AMensagemValidacao: string; var AArrMensagens: TList<string>);
begin
  if not fEmptyStr(AMensagemValidacao) then
  begin
    AArrMensagens.Add(AMensagemValidacao) ;
  end;
  AMensagemValidacao := '' ;
end;

class procedure TValidaProcessoSaldoInicialSubconta.pDesmembraChave(
  const AChave: string; var AConta, AEmpresa: string);
var
  LPos: Integer;
begin
  LPos := Pos(';', AChave);

  if LPos > 0 then
  begin
    AConta := Copy(AChave, 1, LPos -1);
    AEmpresa := Copy(AChave, LPos + 1, Length(AChave) - LPos);
  end
  else
  begin
    AConta := AChave;
    AEmpresa := '';
  end;
end;

class procedure TValidaProcessoSaldoInicialSubconta.pMostraMensagens(
  const AArrMensagens: TDictPendenciasSaldoInicialSub;
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
