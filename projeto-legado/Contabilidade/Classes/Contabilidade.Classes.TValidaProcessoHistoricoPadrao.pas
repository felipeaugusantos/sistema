unit Contabilidade.Classes.TValidaProcessoHistoricoPadrao;

interface

uses System.Generics.Collections, Contabilidade.Interfaces,
     Contabilidade.Classes.CfgContabil ;

type
  TDictPendenciasHistoricoPadrao = TDictionary<Integer, TList<String>> ;
  TDictTabelasHistoricoPadrao = TDictionary<Integer, string> ;

  TDadosValidacaoHistoricoPadrao = record
    ACodigo: Integer;
    ADescricao: string;
  end;

  TValidaProcessoHistoricoPadrao = class
  private
    class function fCfg: ICfgContabil;
    class function fRetornaArrayMensagens(const ADadosValidacao: TDadosValidacaoHistoricoPadrao; ACodigoDuplicado: TList<Integer> = Nil): TList<string> ;
    class function fRetornaCodigoDuplicadoBloco(const  ADadosValidacao: TList<TDadosValidacaoHistoricoPadrao>): TList<Integer>;
    class function fRetornaCodigosEmUso: TDictTabelasHistoricoPadrao;
    class function fRetornaMensagemCodigoEmUso(ACodigo: Integer; ATabelasStr: string): string;

    class procedure pAcumulaMsgVetor(var AMensagemValidacao: string; var AArrMensagens: TList<string>) ;
    class procedure pMostraMensagens(const AArrMensagens: TDictPendenciasHistoricoPadrao; const AprocErros: TErroContabilProc) ;
  public
    class function fValidaCodigo(var AMensagemValidacao: string; const ACodigo: Integer): boolean;
    class function fValidaDescricao(var AMensagemValidacao: string; const ADescricao: String): boolean;

    class function fValidaHistoricoPadraoBloco(const ADadosValidacao: TList<TDadosValidacaoHistoricoPadrao>; const AprocErros: TErroContabilProc; ACfgContabil: ICfgContabil = nil): boolean;
  class var
    FCfgAtivo: ICfgContabil;
  end;

implementation

uses UntFuncoesSimples, SysUtils, MaskUtils, StrUtils,
  Uni, DB, Contabilidade.Funcoes, System.DateUtils, System.Types, Contabilidade.Classes.TValidaContasContabeis ;

{ TValidaProcessoHistoricoPadrao }

class function TValidaProcessoHistoricoPadrao.fCfg: ICfgContabil;
begin
  if not Assigned(FCfgAtivo) then
    FCfgAtivo := TCfgContabilDefault.New;
  Result := FCfgAtivo;
end;

class function TValidaProcessoHistoricoPadrao.fRetornaArrayMensagens(
  const ADadosValidacao: TDadosValidacaoHistoricoPadrao;
  ACodigoDuplicado: TList<Integer>): TList<string>;
var
  strMsg: string;
begin
  Result := TList<string>.Create;

  if Assigned(ACodigoDuplicado) then
  begin
    if ACodigoDuplicado.IndexOf(ADadosValidacao.ACodigo) <> -1 then
    begin
      strMsg := 'Código ['+ADadosValidacao.ACodigo.ToString+'] duplicado na planilha!' ;
      pAcumulaMsgVetor(strMsg, Result) ;
    end;
  end;

  strMsg := '';

  fValidaCodigo(strMsg, ADadosValidacao.ACodigo) ;
  pAcumulaMsgVetor(strMsg, Result) ;

  fValidaDescricao(strMsg, ADadosValidacao.ADescricao) ;
  pAcumulaMsgVetor(strMsg, Result) ;
end;

class function TValidaProcessoHistoricoPadrao.fRetornaCodigoDuplicadoBloco(
  const ADadosValidacao: TList<TDadosValidacaoHistoricoPadrao>): TList<Integer>;
var
  LItem: TDadosValidacaoHistoricoPadrao ;
  lstControle: TList<Integer> ;
begin
  Result := TList<Integer>.Create ;
  lstControle := TList<Integer>.Create ;
  try
    for LItem in ADadosValidacao do
    begin
      if lstControle.IndexOf(LItem.ACodigo) = -1 then
      begin
        lstControle.Add(LItem.ACodigo) ;
      end
      else
      begin
        if Result.IndexOf(LItem.ACodigo) = -1 then
        begin
          Result.Add(LItem.ACodigo) ;
        end ;
      end;
    end;
  finally
    FreeAndNil(lstControle) ;
  end;
end;

class function TValidaProcessoHistoricoPadrao.fRetornaCodigosEmUso: TDictTabelasHistoricoPadrao;
var
  qryHispad: TUniQuery;
  LTabelas: string;
  LblnHisTpl: Boolean;
  LstrTplaco: string;
begin
  LblnHisTpl := fCfg.fCfgSisBoolean('HISTPL');
  LstrTplaco := fRetTplacoEmpresaLogada('', True);
  qryHispad := fCriaQuery() ;
  try
    try
      Result := TDictTabelasHistoricoPadrao.Create;

      qryHispad.Close;
      qryHispad.SQL.Clear;
      qryHispad.SQL.Add('SELECT HISPAD, ORIGEM FROM ( ');

      qryHispad.SQL.Add('SELECT DISTINCT CON_HISCRE AS HISPAD, "PARCON.CON_HISCRE" AS ORIGEM FROM PARCON ');
      qryHispad.SQL.Add('JOIN HISPAD ON PAD_CODIGO = CON_HISCRE ');
      qryHispad.SQL.Add('WHERE TRUE ');
      if LblnHisTpl then
        qryHispad.SQL.Add(' AND PAD_TPLACO = ' + LstrTplaco.QuotedString)
      else
        qryHispad.SQL.Add(' AND IFNULL(PAD_TPLACO, "") = "" ');

      qryHispad.SQL.Add('UNION ALL ');

      qryHispad.SQL.Add('SELECT DISTINCT CON_HISDEB AS HISPAD, "PARCON.CON_HISDEB" AS ORIGEM FROM PARCON ');
      qryHispad.SQL.Add('JOIN HISPAD ON PAD_CODIGO = CON_HISDEB ');
      qryHispad.SQL.Add('WHERE TRUE ');
      if LblnHisTpl then
        qryHispad.SQL.Add(' AND PAD_TPLACO = ' + LstrTplaco.QuotedString)
      else
        qryHispad.SQL.Add(' AND IFNULL(PAD_TPLACO, "") = ""');

      qryHispad.SQL.Add('UNION ALL ');

      qryHispad.SQL.Add('SELECT DISTINCT CON_HISPAD AS HISPAD, "LANCON.CON_HISPAD" AS ORIGEM FROM LANCON ');
      qryHispad.SQL.Add('JOIN HISPAD ON PAD_CODIGO = CON_HISPAD ');
      qryHispad.SQL.Add('WHERE TRUE ');
      if LblnHisTpl then
        qryHispad.SQL.Add(' AND PAD_TPLACO = ' + LstrTplaco.QuotedString)
      else
        qryHispad.SQL.Add(' AND IFNULL(PAD_TPLACO, "") = ""');

      qryHispad.SQL.Add(' ) SEL ORDER BY HISPAD, ORIGEM ');
      qryHispad.Open;

      while not qryHispad.Eof do
      begin
        if Result.TryGetValue(qryHispad.FieldByName('HISPAD').AsInteger, LTabelas) then
          Result.AddOrSetValue(qryHispad.FieldByName('HISPAD').AsInteger, LTabelas + ', ' + qryHispad.FieldByName('ORIGEM').AsString)
        else
          Result.Add(qryHispad.FieldByName('HISPAD').AsInteger, qryHispad.FieldByName('ORIGEM').AsString);

        qryHispad.Next;
      end;

    except
      if Assigned(Result) then
        FreeAndNil(Result);

      raise;
    end;
  finally
    FreeAndNil(qryHispad);
  end;
end;

class function TValidaProcessoHistoricoPadrao.fRetornaMensagemCodigoEmUso(
  ACodigo: Integer; ATabelasStr: string): string;
begin
  Result := 'Código ['+ ACodigo.ToString +'] não pode ser sobrescrito pois está em uso: '+ ATabelasStr;
end;

class function TValidaProcessoHistoricoPadrao.fValidaCodigo(
  var AMensagemValidacao: string; const ACodigo: Integer): boolean;
begin
  Result := True;
end;

class function TValidaProcessoHistoricoPadrao.fValidaDescricao(
  var AMensagemValidacao: string; const ADescricao: String): boolean;
begin
  Result := False;

  if fEmptyStr(ADescricao) then
  begin
    AMensagemValidacao := 'A Descrição deve ser informada.';
    Exit;
  end;

  Result := True;
end;

class function TValidaProcessoHistoricoPadrao.fValidaHistoricoPadraoBloco(
  const ADadosValidacao: TList<TDadosValidacaoHistoricoPadrao>;
  const AprocErros: TErroContabilProc;
  ACfgContabil: ICfgContabil = nil): boolean;
var
  LDictDadosMostrar: TDictPendenciasHistoricoPadrao;
  LLstHistoricoDuplicado: TList<Integer>;
  LDictCodigosEmUso: TDictTabelasHistoricoPadrao;
  LDadoValidacao: TDadosValidacaoHistoricoPadrao;
  LArrMensagens: TList<string>;
  LPair: TPair<Integer, string> ;
begin
  FCfgAtivo := ACfgContabil;
  Result := False ;
  LDictDadosMostrar := TDictPendenciasHistoricoPadrao.Create ;
  LLstHistoricoDuplicado := fRetornaCodigoDuplicadoBloco(ADadosValidacao) ;
  LDictCodigosEmUso := fRetornaCodigosEmUso;
  try
    for LDadoValidacao in ADadosValidacao do
    begin
      LArrMensagens := fRetornaArrayMensagens(LDadoValidacao, LLstHistoricoDuplicado) ;

      if (LArrMensagens.Count > 0) and (not LDictDadosMostrar.ContainsKey(LDadoValidacao.ACodigo)) then
        LDictDadosMostrar.Add(LDadoValidacao.ACodigo, LArrMensagens)
      else
        FreeAndNil(LArrMensagens);
    end;

    for LPair in LDictCodigosEmUso do
    begin
      if LDictDadosMostrar.TryGetValue(LPair.Key, LArrMensagens) then
      begin
        LArrMensagens.Add(fRetornaMensagemCodigoEmUso(LPair.Key, LPair.Value));
      end
      else
      begin
        LArrMensagens := TList<string>.Create;
        LArrMensagens.Add(fRetornaMensagemCodigoEmUso(LPair.Key, LPair.Value));
        LDictDadosMostrar.Add(LPair.Key, LArrMensagens);
      end
    end;

    if LDictDadosMostrar.Count > 0 then
    begin
      pMostraMensagens(LDictDadosMostrar, AprocErros) ;
      exit ;
    end;
  finally
    FCfgAtivo := nil;
    FreeAndNil(LDictDadosMostrar);
    FreeAndNil(LLstHistoricoDuplicado);
    FreeAndNil(LDictCodigosEmUso);
  end;

  Result := True;
end;

class procedure TValidaProcessoHistoricoPadrao.pAcumulaMsgVetor(
  var AMensagemValidacao: string; var AArrMensagens: TList<string>);
begin
  if not fEmptyStr(AMensagemValidacao) then
  begin
    AArrMensagens.Add(AMensagemValidacao) ;
  end;
  AMensagemValidacao := '' ;
end;

class procedure TValidaProcessoHistoricoPadrao.pMostraMensagens(
  const AArrMensagens: TDictPendenciasHistoricoPadrao;
  const AprocErros: TErroContabilProc);
var
  objMensagens: TValidaContaContabil ;
  strItem: string ;
  regDoc: TContaErro ;
  LPair: TPair<Integer, TList<string>> ;
begin
  objMensagens := TValidaContaContabil.Create ;
  try
    for LPair in AArrMensagens do
    begin
      for strItem in LPair.Value do
      begin
        regDoc.strChaveDocumento := LPair.Key.ToString ;
        regDoc.strMotivo := strItem ;
        regDoc.strWarning := 'N' ;
        objMensagens.pAddErro(regDoc, Nil);
      end;
    end;

    if Assigned(AprocErros) then
      AprocErros(objMensagens.DataSet) ;

  finally
    FreeAndNil(objMensagens) ;
  end;
end;

end.
