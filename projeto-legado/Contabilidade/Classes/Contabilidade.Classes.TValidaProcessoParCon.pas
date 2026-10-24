unit Contabilidade.Classes.TValidaProcessoParCon;

interface

uses
  System.Generics.Collections, Contabilidade.Interfaces,
  Contabilidade.Classes.TImportacaoDadosContabeis;

type
  TDictPendenciasParCon = TDictionary<string, TList<string>>;

  TDadosValidacaoParCon = record
    ASeqPar: string;
    ACodemp: string;
  end;

  TValidaProcessoParCon = class
  private
    class function fMontaChaveDuplicidade(const ADadosValidacao: TDadosValidacaoParCon): string;
    class function fRetornaSeqParDuplicadoBloco(
      const ADadosValidacao: TList<TDadosValidacaoParCon>): TList<string>;
    class function fParConBaseEstaVazia(const ACodemp: string): Boolean;
    class procedure pMostraMensagens(const AArrMensagens: TDictPendenciasParCon;
      const AprocErros: TErroContabilProc);
  public
    class function fValidaParConBloco(
      const ADadosValidacao: TList<TDadosValidacaoParCon>;
      const AprocErros: TErroContabilProc): boolean;
  end;

implementation

uses
  UntFuncoesSimples, SysUtils, Uni, Data.DB,
  Contabilidade.Funcoes, Contabilidade.Classes.TValidaContasContabeis;

{ TValidaProcessoParCon }

class function TValidaProcessoParCon.fMontaChaveDuplicidade(
  const ADadosValidacao: TDadosValidacaoParCon): string;
begin
  Result := Trim(ADadosValidacao.ASeqPar);
end;

class function TValidaProcessoParCon.fParConBaseEstaVazia(
  const ACodemp: string): Boolean;
var
  LqryAux: TUniQuery;
begin

  LqryAux := fCriaQuery(nil);
  try
    LqryAux.SQL.Text :=
      'SELECT 1 ' +
      'FROM PARCON ' +
      'WHERE TRUE ';

    if Trim(ACodemp) <> '' then
    begin
      LqryAux.SQL.Text := LqryAux.SQL.Text +
        '  AND IFNULL(CON_CODEMP, "") = :CODEMP ';
      LqryAux.ParamByName('CODEMP').AsString := Trim(ACodemp);
    end
    else
    begin
      LqryAux.SQL.Text := LqryAux.SQL.Text +
        '  AND IFNULL(CON_CODEMP, "") = "" ';
    end;

    LqryAux.SQL.Text := LqryAux.SQL.Text + 'LIMIT 1';
    LqryAux.Open;

    Result := LqryAux.IsEmpty;
  finally
    FreeAndNil(LqryAux);
  end;
end;

class function TValidaProcessoParCon.fRetornaSeqParDuplicadoBloco(
  const ADadosValidacao: TList<TDadosValidacaoParCon>): TList<string>;
var
  LItem: TDadosValidacaoParCon;
  LLstControle: TList<string>;
  LstrChave: string;
begin
  Result := TList<string>.Create;
  LLstControle := TList<string>.Create;
  try
    for LItem in ADadosValidacao do
    begin
      LstrChave := fMontaChaveDuplicidade(LItem);
      if LstrChave = '' then
        Continue;

      if LLstControle.IndexOf(LstrChave) = -1 then
        LLstControle.Add(LstrChave)
      else if Result.IndexOf(LstrChave) = -1 then
        Result.Add(LstrChave);
    end;
  finally
    FreeAndNil(LLstControle);
  end;
end;

class function TValidaProcessoParCon.fValidaParConBloco(
  const ADadosValidacao: TList<TDadosValidacaoParCon>;
  const AprocErros: TErroContabilProc): boolean;
var
  LDictDadosMostrar: TDictPendenciasParCon;
  LLstSeqParDuplicado: TList<string>;
  LLstMensagens: TList<string>;
  LstrSeqParDuplicado: string;
  LArrMensagens: TList<string>;
  LstrChave: string;
  LstrCodempEscopo: string;
begin
  Result := False;

  if ADadosValidacao.Count = 0 then
  begin
    Result := True;
    Exit;
  end;

  LDictDadosMostrar := TDictPendenciasParCon.Create;
  LLstSeqParDuplicado := fRetornaSeqParDuplicadoBloco(ADadosValidacao);
  try
    for LstrSeqParDuplicado in LLstSeqParDuplicado do
    begin
      LArrMensagens := TList<string>.Create;
      LArrMensagens.Add('Parâmetro duplicado na planilha (SEQPAR repetido).');
      LDictDadosMostrar.AddOrSetValue(LstrSeqParDuplicado, LArrMensagens);
    end;

    LstrCodempEscopo := Trim(ADadosValidacao[0].ACodemp);
    if not fParConBaseEstaVazia(LstrCodempEscopo) then
    begin
      if Trim(ADadosValidacao[0].ASeqPar) <> '' then
        LstrChave := ADadosValidacao[0].ASeqPar
      else
        LstrChave := 'PARCON';

      if not LDictDadosMostrar.TryGetValue(LstrChave, LArrMensagens) then
      begin
        LArrMensagens := TList<string>.Create;
        LDictDadosMostrar.Add(LstrChave, LArrMensagens);
      end;

      LArrMensagens.Add('A importação de PARCON exige tabela vazia no escopo da empresa (CONEMP).');
    end;

    if LDictDadosMostrar.Count = 0 then
    begin
      Result := True;
      Exit;
    end;

    pMostraMensagens(LDictDadosMostrar, AprocErros);
  finally
    for LLstMensagens in LDictDadosMostrar.Values do
      LLstMensagens.Free;
    FreeAndNil(LDictDadosMostrar);
    FreeAndNil(LLstSeqParDuplicado);
  end;
end;

class procedure TValidaProcessoParCon.pMostraMensagens(
  const AArrMensagens: TDictPendenciasParCon;
  const AprocErros: TErroContabilProc);
var
  objMensagens: TValidaContaContabil;
  strItem: string;
  regDoc: TContaErro;
  LPair: TPair<string, TList<string>>;
begin
  objMensagens := TValidaContaContabil.Create;
  try
    for LPair in AArrMensagens do
    begin
      for strItem in LPair.Value do
      begin
        regDoc.strChaveDocumento := LPair.Key;
        regDoc.strMotivo := strItem;
        regDoc.strWarning := 'N';
        objMensagens.pAddErro(regDoc, nil);
      end;
    end;

    if Assigned(AprocErros) then
      AprocErros(objMensagens.DataSet);

  finally
    FreeAndNil(objMensagens);
  end;
end;

end.
