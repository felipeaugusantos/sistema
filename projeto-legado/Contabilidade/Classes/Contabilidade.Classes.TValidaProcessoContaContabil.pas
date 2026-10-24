unit Contabilidade.Classes.TValidaProcessoContaContabil;

interface

uses System.Generics.Collections, Contabilidade.Interfaces,
     Contabilidade.Classes.CfgContabil ;

type
  TDictPendenciasContaContabil = TDictionary<String, TList<String>> ;
  TDictContasTabela = TDictionary<String, String> ;

  TDadosValidacaoContaContabil = record
    AContaContabil: String ;
    ATpLaco: String ;
    AInicio: TDateTime ;
    AFinal: TDateTime ;
    AAutoInc: String ;
    AApurac: String ;
    AContaRef: string ;
    ADescricaoConta: string ;
    ANatureza: string ;
    AFinalidade: string ;
    ARedutora: string ;
    ANatAju: string ;
    AAjuLiq: string ;
    APatrimonial: string ;
    AContaReduzida: string ;
  end;

  TDadosCamposConta = record
    Finali: Char;
    FinaliFixo: Boolean;
    Reduto: Char;
    RedutoFixo: Boolean;
    Patrim: Char;
    PatrimFixo: Boolean;
    Nature: Char;
    NatureFixo: Boolean;
  end;

  TValidaProcessoContaContabilBase = class
  protected
    class function fValidacaoDesligada: Boolean ;
  end ;

  TValidaProcessoContaContabil = class(TValidaProcessoContaContabilBase)
  private
    class function fContaReferencialObrigatoria(const AContaContabil:String): boolean;
    class function fEhContaPatrimonial(const APatrimonial: string): boolean;
    class function fEhContaAtivo(const AContaContabil: string): boolean;
    class function fEhContaPassivo(const AContaContabil: string): boolean;
    class function fEhContaCompensacao(const AContaContabil: string): boolean;
    class function fGetInformativoConta(const AContaContabil: string): string;

    class function fValidaGrauAnteriorConta(var AMensagemValidacao: string; const AContaContabil, ATpLaco: String; AContaTpLaco: TList<String> = Nil): boolean;
    class function fValidaVigenciaConta(var AMensagemValidacao: string; const AInicio, AFinal: TDateTime): boolean;
    class function fValidaDuplicidadeConta(var AMensagemValidacao: string; const AContaContabil, ATpLaco, AAutoInc: String): boolean;
    class function fValidaApuracConta(var AMensagemValidacao: string; const AApurac, AContaContabil: String): boolean;
    class function fValidaUltimoGrauConta(var AMensagemValidacao: string; const AConta: String): boolean;

    class procedure pAcumulaMsgVetor(var AMensagemValidacao: string; var AArrMensagens: TList<string>) ;
    class procedure pMostraMensagens(const AArrMensagens: TDictPendenciasContaContabil; const AprocErros: TErroContabilProc) ;

    class function fRetornaArrayMensagens(const ADadosValidacao: TDadosValidacaoContaContabil; AContaDuplicada: TList<string> = Nil; AContaReduzidaDuplicada: TList<string> = Nil; AContaTpLaco: TList<string> = Nil; const AstrEXPCTB: string = ''; ATplacoEmpLog: string = ''):TList<string> ;
    class function fRetornaContaDuplicadaBloco(const ADadosValidacao: TList<TDadosValidacaoContaContabil>):TList<string> ;
    class function fRetornaContaReduzidaDuplicadaBloco(const ADadosValidacao: TList<TDadosValidacaoContaContabil>):TList<string> ;
    class function fRetornaNaturezaExtenso(const ANature: string): string;
    class function fValidaNaturezaPelaContaContabil(const AstrContaContabil, AstrNatureza: String; var AstrMensagemValidacao: String): boolean ;
    class function fComMascaraPlaNco(const AstrContaContabil, AstrMascara: String): String ;
    class procedure pSomenteNumerosNaContaContabil(var AarrContaContabilComMascara: TArray<String>) ;
  public
    class function fCarregaDescricaoDaCtaRef(const AContaRef: String): string;
    class function fCarregaDescricaoDoTipoDePlanoDeContaContabil(const ATplaco: string): string;
    class function fCarregaDescricaoDaNatAjuste(const ANatAju: string): string ;
    class function fCarregaNatureDaCtaRef(const AContaRef: String): string;

    class function fValidaContaReferencial(var AMensagemValidacao: string; const AContaRef, AContaContabil, ANatureza: String; var ADescricaoCtaRef: string): boolean;
    class function fValidaTplaco(var AMensagemValidacao: string; const ATplaco: String; var ADescTpLaco: string): boolean;
    class function fValidaDescricaoConta(var AMensagemValidacao: string; const ADescricaoConta: String): boolean;
    class function fValidaConta(var AMensagemValidacao: string; const AContaContabil: String): boolean;
    class function fValidaNatureza(var AMensagemValidacao: string; const ANatureza: String; const AContaContabil: String): boolean;
    class function fValidaFinalidade(var AMensagemValidacao: string; const AFinalidade: String): boolean;
    class function fValidaRedutora(var AMensagemValidacao: string; const ARedutora: String): boolean;
    class function fValidaNaturezaAjuste(var AMensagemValidacao: string; const ANatAju, AAjuLiq: String; var ADescNatAju: string): boolean;
    class function fValidaPatrimonial(var AMensagemValidacao: string; const APatrimonial, AContaContabil: String): boolean;
    class function fValidaContaReduzida(var AMensagemValidacao: string; const AContaReduzida, ANatureza, AAutoIncContaContabil: String): boolean;
    class function fValidaTplacoEmpLog(var AMensagemValidacao: string; const ATplaco, ATplacoEmpLog: string): boolean;

    class function fRetornaNaturezaPrevista(const AConta: string): Char;
    class function fRetornaCamposConta(const AConta: string): TDadosCamposConta;

    class function fValidaPlanoContas(const ADadosValidacao: TDadosValidacaoContaContabil; const AprocErros: TErroContabilProc): boolean;
    class function fValidaPlanoContasBloco(const ADadosValidacao: TList<TDadosValidacaoContaContabil>; const AprocErros: TErroContabilProc; const AstrEXPCTB: string = ''; AResetTabela: Boolean = False; ACfgContabil: ICfgContabil = nil): boolean;

    class function fCfg: ICfgContabil;
    class var FCfgAtivo: ICfgContabil;
  end;

implementation

uses UntFuncoesSimples, SysUtils, MaskUtils, StrUtils,
  Uni, DB, Contabilidade.Classes.TValidaContasContabeis,
  Contabilidade.Funcoes, Contabilidade.Model.Contabilizaveis,
  System.DateUtils, System.Types ;

{ TValidaProcessoContaContabil }

class function TValidaProcessoContaContabil.fCfg: ICfgContabil;
begin
  if not Assigned(FCfgAtivo) then
    FCfgAtivo := TCfgContabilDefault.New;
  Result := FCfgAtivo;
end;

class function TValidaProcessoContaContabil.fCarregaDescricaoDaNatAjuste(
  const ANatAju: string): string;
begin
  Result := '' ;
  if not fUtilizaNaturezaDoAjuste then
    exit;

  Result := fCampoTabela('NAT_DESCRI', 'NATAJU', ['NAT_CODIGO'], [ANatAju], False) ;
end;

class function TValidaProcessoContaContabil.fCarregaDescricaoDoTipoDePlanoDeContaContabil(
  const ATplaco: string): string;
begin
  result := fCampoTabela('ACO_DESCRI', 'TPLACO', ['ACO_CODIGO'], [ATplaco]);
end;

class function TValidaProcessoContaContabil.fComMascaraPlaNco(
  const AstrContaContabil, AstrMascara: String): String;
var
  LintCnt: Integer ;
  LblnFlag: Boolean ;
  LstrContaContabil: String ;
begin
  LstrContaContabil := Trim(FormatMaskText(AstrMascara, AstrContaContabil)) ;
  LblnFlag := False ;
  Result := '' ;
  for LintCnt := Length(LstrContaContabil) downto 1 do
  begin
    if CharInSet(LstrContaContabil[LintCnt], ['0'..'9']) then
      LblnFlag := True ;

    if LblnFlag then
      Result := LstrContaContabil[LintCnt] + Result ;

  end ;
end;

class function TValidaProcessoContaContabil.fContaReferencialObrigatoria(
  const AContaContabil: String): boolean;
var
  LDigApu, LDigCom: string;
begin
  result := False ;
  LDigApu := fCfg.fCfgSis('DIGAPU');
  LDigCom := fCfg.fCfgSis('DIGCOM');
  if copy(fSemMascaraPlaNco(AContaContabil),1,fLenDig(LDigApu)) = LDigApu then
  begin
    exit ;
  end;

  if copy(fSemMascaraPlaNco(AContaContabil),1,fLenDig(LDigCom)) = LDigCom then
  begin
    exit ;
  end;
  result := True ;
end;

class function TValidaProcessoContaContabil.fEhContaAtivo(
  const AContaContabil: string): boolean;
var
  LCfg: string;
begin
  LCfg := fCfg.fCfgSis('DIGATI');
  Result := LeftStr(AContaContabil, fLenDig(LCfg)) = LCfg;
end;

class function TValidaProcessoContaContabil.fEhContaCompensacao(
  const AContaContabil: string): boolean;
var
  LCfg: string;
begin
  LCfg := fCfg.fCfgSis('DIGCOM');
  Result := LeftStr(fSemMascaraPlaNco(AContaContabil), fLenDig(LCfg)) = LCfg;
end;

class function TValidaProcessoContaContabil.fEhContaPassivo(
  const AContaContabil: string): boolean;
var
  LCfg: string;
begin
  LCfg := fCfg.fCfgSis('DIGPAS');
  Result := LeftStr(AContaContabil, fLenDig(LCfg)) = LCfg;
end;

class function TValidaProcessoContaContabil.fEhContaPatrimonial(
  const APatrimonial: string): boolean;
begin
  Result := APatrimonial = 'S' ;
end;

class function TValidaProcessoContaContabil.fGetInformativoConta(
  const AContaContabil: string): string;
begin
  Result := '';
  if fEhContaAtivo(AContaContabil) then
    Result := 'Ativo: ' + fComMascaraPlaNco(fSemMascaraPlaNco(AContaContabil), fMskCon)
  else if fEhContaPassivo(AContaContabil) then
    Result := 'Passivo: ' + fComMascaraPlaNco(fSemMascaraPlaNco(AContaContabil), fMskCon)
  else
    Result := 'Conta Contábil: ' + fComMascaraPlaNco(fSemMascaraPlaNco(AContaContabil), fMskCon) ;
end;

class function TValidaProcessoContaContabil.fRetornaArrayMensagens(
  const ADadosValidacao: TDadosValidacaoContaContabil;
  AContaDuplicada: TList<string> = Nil;
  AContaReduzidaDuplicada: TList<string> = Nil;
  AContaTpLaco: TList<string> = Nil;
  const AstrEXPCTB: string = '';
  ATplacoEmpLog: string = ''): TList<string>;
var
  strMsg: string ;
  strVar: string ;
begin
  Result := TList<string>.Create() ;
  if Assigned(AContaDuplicada) then
  begin
    if AContaDuplicada.IndexOf(ADadosValidacao.AContaContabil) <> -1 then
    begin
      strMsg := 'Conta Contabil ['+ADadosValidacao.AContaContabil+'] duplicada na planilha!' ;
      pAcumulaMsgVetor(strMsg, Result) ;
    end;
  end;
  if Assigned(AContaReduzidaDuplicada) then
  begin
    if AContaReduzidaDuplicada.IndexOf(ADadosValidacao.AContaReduzida) <> -1 then
    begin
      strMsg := 'Conta Reduzida ['+ADadosValidacao.AContaReduzida+'] duplicada na planilha!' ;
      pAcumulaMsgVetor(strMsg, Result) ;
    end;
  end;
  fValidaContaReferencial(strMsg, ADadosValidacao.AContaRef, ADadosValidacao.AContaContabil, ADadosValidacao.ANatureza, strVar) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaTplaco(strMsg, ADadosValidacao.ATplaco, strVar) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaTplacoEmpLog(strMsg, ADadosValidacao.ATplaco, ATplacoEmpLog);
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaDescricaoConta(strMsg, ADadosValidacao.ADescricaoConta) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaConta(strMsg, ADadosValidacao.AContaContabil) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaNatureza(strMsg, ADadosValidacao.ANatureza, ADadosValidacao.AContaContabil) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaFinalidade(strMsg, ADadosValidacao.AFinalidade) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaRedutora(strMsg, ADadosValidacao.ARedutora) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaNaturezaAjuste(strMsg, ADadosValidacao.ANatAju, ADadosValidacao.AAjuLiq, strVar) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaPatrimonial(strMsg, ADadosValidacao.APatrimonial, ADadosValidacao.AContaContabil) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaContaReduzida(strMsg, ADadosValidacao.AContaReduzida, ADadosValidacao.ANatureza, ADadosValidacao.AAutoInc) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaGrauAnteriorConta(strMsg, ADadosValidacao.AContaContabil, ADadosValidacao.ATpLaco, AContaTpLaco) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaUltimoGrauConta(strMsg, ADadosValidacao.AContaContabil) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaVigenciaConta(strMsg, ADadosValidacao.AInicio, ADadosValidacao.AFinal) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaDuplicidadeConta(strMsg, ADadosValidacao.AContaContabil, ADadosValidacao.ATpLaco, ADadosValidacao.AAutoInc) ;
  pAcumulaMsgVetor(strMsg, Result) ;
  fValidaApuracConta(strMsg, ADadosValidacao.AApurac, ADadosValidacao.AContaContabil) ;
  pAcumulaMsgVetor(strMsg, Result) ;
end;

class function TValidaProcessoContaContabil.fRetornaCamposConta(
  const AConta: string): TDadosCamposConta;
var
  LContaSemMasc, LCfg: string;
begin
  LContaSemMasc := fSemMascaraPlaNco(AConta);

  Result.Nature := fRetornaNaturezaPrevista(LContaSemMasc);
  Result.NatureFixo := True;

  Result.Reduto := 'N';
  Result.RedutoFixo := False;

  LCfg := fCfg.fCfgSis('DIGATI');
  if (LCfg.Length > 0) and (copy(LContaSemMasc,1,fLenDig(LCfg)) = LCfg)  then
  begin
    Result.Finali := 'D';
    Result.FinaliFixo := False;
    Result.Patrim := 'S';
    Result.PatrimFixo := True;
    Exit;
  end;

  LCfg := fCfg.fCfgSis('DIGPAS');
  if (LCfg.Length > 0) and (copy(LContaSemMasc,1,fLenDig(LCfg)) = LCfg)  then
  begin
    Result.Finali := 'C';
    Result.FinaliFixo := False;
    Result.Patrim := 'S';
    Result.PatrimFixo := True;
    Exit;
  end;

  LCfg := fCfg.fCfgSis('DIGPLI');
  if (LCfg.Length > 0) and (copy(LContaSemMasc,1,fLenDig(LCfg)) = LCfg) then
  begin
    Result.Finali := 'C';
    Result.FinaliFixo := False;
    Result.Patrim := 'S';
    Result.PatrimFixo := True;
    Exit;
  end;

  LCfg := fCfg.fCfgSis('DIGREC');
  if (LCfg.Length > 0) and (copy(LContaSemMasc,1,fLenDig(LCfg)) = LCfg) then
  begin
    Result.Finali := 'C';
    Result.FinaliFixo := False;
    Result.Patrim := 'N';
    Result.PatrimFixo := True;
    Exit;
  end;

  LCfg := fCfg.fCfgSis('DIGCUS');
  if (LCfg.Length > 0) and (copy(LContaSemMasc,1,fLenDig(LCfg)) = LCfg) then
  begin
    Result.Finali := 'D';
    Result.FinaliFixo := False;
    Result.Patrim := 'N';
    Result.PatrimFixo := True;
    Exit;
  end;

  LCfg := fCfg.fCfgSis('DIGDES');
  if (LCfg.Length > 0) and (copy(LContaSemMasc,1,fLenDig(LCfg)) = LCfg) then
  begin
    Result.Finali := 'D';
    Result.FinaliFixo := False;
    Result.Patrim := 'N';
    Result.PatrimFixo := True;
    Exit;
  end;

  LCfg := fCfg.fCfgSis('DIGAPU');
  if (LCfg.Length > 0) and (copy(LContaSemMasc,1,fLenDig(LCfg)) = LCfg) then
  begin
    Result.Finali := 'D';
    Result.FinaliFixo := False;
    Result.Patrim := 'N';
    Result.PatrimFixo := False;
    Exit;
  end;

  LCfg := fCfg.fCfgSis('DIGCOM');
  if (LCfg.Length > 0) and (copy(LContaSemMasc,1,fLenDig(LCfg)) = LCfg) then
  begin
    Result.Finali := 'D';
    Result.FinaliFixo := False;
    Result.Patrim := 'N';
    Result.PatrimFixo := False;
    Exit;
  end;
end;

class function TValidaProcessoContaContabil.fRetornaContaDuplicadaBloco(
  const ADadosValidacao: TList<TDadosValidacaoContaContabil>): TList<string>;
var
  LItem: TDadosValidacaoContaContabil ;
  lstControle: TList<string> ;
begin
  Result := TList<string>.Create ;
  lstControle := TList<string>.Create ;
  try
    for LItem in ADadosValidacao do
    begin
      if lstControle.IndexOf(LItem.AContaContabil) = -1 then
      begin
        lstControle.Add(LItem.AContaContabil) ;
      end
      else
      begin
        if Result.IndexOf(LItem.AContaContabil) = -1 then
        begin
          Result.Add(LItem.AContaContabil) ;
        end ;
      end;
    end;
  finally
    FreeAndNil(lstControle) ;
  end;
end;

class function TValidaProcessoContaContabil.fRetornaContaReduzidaDuplicadaBloco(
  const ADadosValidacao: TList<TDadosValidacaoContaContabil>): TList<string>;
var
  LItem: TDadosValidacaoContaContabil ;
  lstControle: TList<string> ;
begin
  Result := TList<string>.Create ;
  lstControle := TList<string>.Create ;
  try
    for LItem in ADadosValidacao do
    begin
      if fEmptyStr(LItem.AContaReduzida) then
      begin
        continue ;
      end;
      if lstControle.IndexOf(LItem.AContaReduzida) = -1 then
      begin
        lstControle.Add(LItem.AContaReduzida) ;
      end
      else
      begin
        if Result.IndexOf(LItem.AContaReduzida) = -1 then
        begin
          Result.Add(LItem.AContaReduzida) ;
        end ;
      end;
    end;
  finally
    FreeAndNil(lstControle) ;
  end;
end;

class function TValidaProcessoContaContabil.fRetornaNaturezaExtenso(
  const ANature: string): string;
begin
  if ANature.ToUpper = 'A' then
    Result := 'Analítica'
  else
    Result := 'Sintética';
end;

class function TValidaProcessoContaContabil.fRetornaNaturezaPrevista(
  const AConta: string): Char;
var
  LstrContaContabilMasc, LstrMascara: string;
begin
  LstrMascara := fMskCon ;
  LstrContaContabilMasc := fComMascaraPlaNco(fSemMascaraPlaNco(AConta), LstrMascara) ;

  if Length(SplitString(LstrContaContabilMasc, '.')) = Length(SplitString(LstrMascara, '.')) then
    Result := 'A'
  else
    Result := 'S';
end;

class function TValidaProcessoContaContabil.fValidaApuracConta(var AMensagemValidacao: string; const AApurac, AContaContabil: String): boolean;
var
  strDigito: string ;
  LstrCfg: string;
begin
  Result := False ;
  AMensagemValidacao := '' ;

  if fValidacaoDesligada then
    Exit(True) ;

  if (fEmptyStr(AApurac)) or (not (CharInSet(AApurac[1], ['0','1']))) then
  begin
    AMensagemValidacao := '"Apuração após o lucro operacional?" [0/1] deve ser informada!';
    Result := False;
    exit ;
  end;

  if AApurac = '1' then
  begin
    strDigito := fSemMascaraPlaNco(AContaContabil);

    if (fEmptyStr(strDigito)) then
    begin
      AMensagemValidacao := 'O código da conta deve ser informado!' ;
      Exit;
    end;

    LstrCfg := fCfg.fCfgSis('DIGATI');
    if (copy(strDigito,1,fLenDig(LstrCfg)) = LstrCfg) then
    begin
      AMensagemValidacao := 'Para marcar a opção "Apuração após o lucro operacional?" a conta não pode ser do grupo "Ativo"!' ;
      Exit;
    end;

    LstrCfg := fCfg.fCfgSis('DIGPAS');
    if (copy(strDigito,1,fLenDig(LstrCfg)) = LstrCfg) then
    begin
      AMensagemValidacao := 'Para marcar a opção "Apuração após o lucro operacional?" a conta não pode ser do grupo "Passivo"!' ;
      Exit;
    end;

    LstrCfg := fCfg.fCfgSis('DIGREC');
    if (copy(strDigito,1,fLenDig(LstrCfg)) = LstrCfg) then
    begin
      AMensagemValidacao := 'Para marcar a opção "Apuração após o lucro operacional?" a conta não pode ser do grupo "Receita"!' ;
      Exit;
    end;

    LstrCfg := fCfg.fCfgSis('DIGDES');
    if (copy(strDigito,1,fLenDig(LstrCfg)) = LstrCfg) then
    begin
      AMensagemValidacao := 'Para marcar a opção "Apuração após o lucro operacional?" a conta não pode ser do grupo "Despesa"!' ;
      Exit;
    end;

    LstrCfg := fCfg.fCfgSis('DIGCUS');
    if (copy(strDigito,1,fLenDig(LstrCfg)) = LstrCfg) then
    begin
      AMensagemValidacao := 'Para marcar a opção "Apuração após o lucro operacional?" a conta não pode ser do grupo "Custo"!' ;
      Exit;
    end;

  end;
  Result := True ;
end;

class function TValidaProcessoContaContabil.fValidaConta(var AMensagemValidacao: string;
  const AContaContabil: String): boolean;
begin
  Result := True ;
  AMensagemValidacao := '' ;

  if fValidacaoDesligada then
    Exit ;

  If fEmptyStr(AContaContabil) Then
  Begin
    AMensagemValidacao := 'A Conta Contábil deve ser informada!' ;
    Result := False;
  End;
end;

class function TValidaProcessoContaContabil.fValidaContaReduzida(
  var AMensagemValidacao: string; const AContaReduzida, ANatureza,
  AAutoIncContaContabil: String): boolean;
var
  intCrdTam: Integer;
  qryPlanco: TUniQuery;
  strConRed: string;
begin
  Result := True ;
  AMensagemValidacao := '' ;

  if fValidacaoDesligada then
    Exit ;

  intCrdTam := fCfg.fCfgSis('CRDTAM', varInteger);

  if fEmptyStr(AContaReduzida) then
  begin
    if (ANatureza = 'A') then
    begin
      AMensagemValidacao := 'A Conta Reduzida deve ser informada!';
      Result := False;
    end;
  end
  else if (AContaReduzida.Length > intCrdTam) then
  begin
    AMensagemValidacao := 'A Conta Reduzida deve possuir até '+ intCrdTam.ToString +' dígito(s) conforme determinado pela CFG_CRDTAM.';
    Result := False;
  end
  else if (fCfgRpCtRd = 'N') then
  begin
    qryPlanco := fCriaQuery();
    try
      qryPlanco.Close;
      qryPlanco.SQL.Clear;
      qryPlanco.SQL.Add('SELECT PLANCO.AUTOINCREM FROM PLANCO ');
      qryPlanco.SQL.Add('INNER JOIN CADEMP ON EMP_TPLACO = NCO_TPLACO ');
      qryPlanco.SQL.Add('WHERE TRIM(LEADING "0" FROM NCO_CONRED) = :CONRED ');
      qryPlanco.SQL.Add('AND EMP_CODEMP = :CODEMP ');
      qryPlanco.SQL.Add('AND PLANCO.AUTOINCREM <> :INCREM ');

      strConRed := AContaReduzida;
      While (Length(strConRed) > 0) And (strConRed[1] = '0') Do
        Delete(strConRed, 1, 1);

      qryPlanco.ParamByName('CONRED').AsString := strConRed;
      qryPlanco.ParamByName('INCREM').AsString := AAutoIncContaContabil;
      qryPlanco.ParamByName('CODEMP').AsString := Vs_strCodEmp;

      qryPlanco.Open;

      if qryPlanco.RecordCount > 0 then
      begin
        AMensagemValidacao := 'Esta Conta Reduzida [' + AContaReduzida + '] já existe. Não é permitido repetir!' ;
        Result := False;
      end;
    finally
      FreeAndNil(qryPlanco);
    end;
  end;

end;

class function TValidaProcessoContaContabil.fValidaContaReferencial(
  var AMensagemValidacao: string; const AContaRef, AContaContabil, ANatureza: String; var ADescricaoCtaRef: string): boolean;
var
  strNatureRef: string;
begin
  Result := True ;
  ADescricaoCtaRef := '' ;

  if fValidacaoDesligada then
  begin
    if not fEmptyStr(AContaRef) then
    begin
      ADescricaoCtaRef := fCarregaDescricaoDaCtaRef(AContaRef);
      if (fEmptyStr(ADescricaoCtaRef)) then
      begin
        AMensagemValidacao := 'A Conta Referencial informada [' + AContaRef + '] não existe!' ;
        Result := False;
        Exit;
      end;
    end ;
    Exit ;
  end ;

  if fCfg.fCfgSis('EXPECD') = 'N' then
  begin
    exit ;
  end;
  if (fContaReferencialObrigatoria(AContaContabil)) and (fEmptyStr(AContaRef)) and (ANatureza = 'A') then
  begin
    AMensagemValidacao := 'A Conta Referencial deve ser informada!' ;
    Result := False;
  end
  else
  begin
    if not fEmptyStr(AContaRef) then
    begin
      ADescricaoCtaRef := fCarregaDescricaoDaCtaRef(AContaRef);
      if (fEmptyStr(ADescricaoCtaRef)) then
      begin
        AMensagemValidacao := 'A Conta Referencial informada [' + AContaRef + '] não existe!' ;
        Result := False;
        Exit;
      end;

      strNatureRef := fCarregaNatureDaCtaRef(AContaRef);
      if strNatureRef <> ANatureza then
      begin
        AMensagemValidacao := 'A Conta Referencial deve ser da mesma natureza que o Plano Contábil (' + fRetornaNaturezaExtenso(ANatureza) + ').' ;
        Result := False;
      end;
    end;
  end;
end;

class function TValidaProcessoContaContabil.fValidaDescricaoConta(
  var AMensagemValidacao: string; const ADescricaoConta: String): boolean;
begin
  Result := True ;

  If fEmptyStr(ADescricaoConta) Then
  Begin
    AMensagemValidacao := 'A Descrição Contábil deve ser informada!' ;
    Result := False;
  End;
end;

class function TValidaProcessoContaContabil.fValidaDuplicidadeConta(
  var AMensagemValidacao: string; const AContaContabil,
  ATpLaco, AAutoInc: String): boolean;
var
  qryVerifica: TUniQuery ;
begin
  Result := False ;
  qryVerifica := fCriaQuery() ;
  try
    qryVerifica.Close ;
    qryVerifica.SQL.Clear ;
    qryVerifica.SQL.Add('SELECT AUTOINCREM FROM PLANCO WHERE NCO_CODCON = :CODCON AND NCO_TPLACO = :TPLACO AND AUTOINCREM <> :AUTOINCREM') ;
    qryVerifica.ParamByName('CODCON').AsString := AContaContabil ;
    qryVerifica.ParamByName('TPLACO').AsString := ATpLaco ;
    qryVerifica.ParamByName('AUTOINCREM').AsString := AAutoInc ;
    qryVerifica.Open ;
    if not qryVerifica.IsEmpty then
    begin
      AMensagemValidacao := 'Conta/Tipo Plano de Contas Contábil [' + AContaContabil + '/' + ATpLaco + '] duplicado!' ;
      exit ;
    end;
  finally
    FreeAndNil(qryVerifica) ;
  end;
  Result := True ;
end;

class function TValidaProcessoContaContabil.fValidaFinalidade(
  var AMensagemValidacao: string; const AFinalidade: String): boolean;
begin
  Result := True ;

  if fValidacaoDesligada then
    Exit ;

  if (fEmptyStr(AFinalidade)) or (not (CharInSet(AFinalidade[1], ['C','D']))) then
  begin
    AMensagemValidacao := 'A Finalidade do Plano de Contas Contábil [C/D] deve ser informada!';
    Result := False;
  end;
end;

class function TValidaProcessoContaContabil.fValidaGrauAnteriorConta(
  var AMensagemValidacao: string; const AContaContabil,
  ATpLaco: String; AContaTpLaco: TList<String> = Nil): boolean;
var
  strMascara: string ;
  arrMascara: TArray<String> ;
  LContaContabil: string ;
  strContaContabilComMascara: string ;
  arrContaContabilComMascara: TArray<String> ;
  strGrau: string ;
  strContaContabilSintetica, strContaContabilAnalitica: string ;
  blnFlagSintetica: boolean ;
begin
  result := False ;

  if fValidacaoDesligada then
    exit(True) ;

  AMensagemValidacao := '' ;
  strMascara := fCfg.fCfgSis('MSKCON') ;
  if fEmptyStr(strMascara) then
  begin
    AMensagemValidacao := '[CFG_MSKCON - ' + fRetNomCfg('MSKCON') + '], não configurada!' ;
    exit ;
  end;

  LContaContabil := fSemMascaraPlaNco(AContaContabil) ;

  ///analisa somente se for acima do primeiro grau
  arrMascara := strMascara.Split(['.']) ;

  /// se a conta for grau 1 não valida
  if Length(LContaContabil) = Length(arrMascara[0]) then
  begin
    Result := True ;
    exit ;
  end;

  strContaContabilComMascara := FormatMaskText(StringReplace(strMascara,'.','\.',[rfReplaceAll])+';0;', LContaContabil ) ;
  arrContaContabilComMascara := strContaContabilComMascara.Split(['.']) ;
  pSomenteNumerosNaContaContabil(arrContaContabilComMascara) ;
  strContaContabilSintetica := '' ;
  strContaContabilAnalitica := '' ;
  blnFlagSintetica := False ;
  for strGRau in arrContaContabilComMascara do
  begin
    if fEmptyStr(strGRau) then
    begin
      continue ;
    end;
    if blnFlagSintetica then
    begin
      strContaContabilSintetica := strContaContabilAnalitica ;
    end;
    strContaContabilAnalitica := strContaContabilAnalitica + trim(strGRau) ;
    blnFlagSintetica := True ;
  end;
  /// verifica se a Conta Sintetica está cadastrada
  if fEmptyStr(fCampoTabela('NCO_CODCON', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [strContaContabilSintetica,ATpLaco])) then
  begin
    if Assigned(AContaTpLaco) then
    begin
      if AContaTpLaco.IndexOf(strContaContabilSintetica+ATpLaco) = -1 then
      begin
        AMensagemValidacao := 'Conta Contábil sintética [' + strContaContabilSintetica + '] não cadastrada!' ;
        exit ;
      end;
    end
    else
    begin
      AMensagemValidacao := 'Conta Contábil sintética [' + strContaContabilSintetica + '] não cadastrada!' ;
      exit ;
    end;
  end;
  Result := True ;
end;

class function TValidaProcessoContaContabil.fValidaUltimoGrauConta(
  var AMensagemValidacao: string; const AConta: String): boolean;
var
  LMasc: string;
  LArrConta, LArrMasc: TArray<string>;
  LIndexGrauMaxConta: Integer;
begin
  Result := False;

  if fValidacaoDesligada then
    Exit(True) ;

  LMasc := fCfg.fCfgSis('MSKCON') ;

  if fEmptyStr(LMasc) then
  begin
    Result := True;
    Exit;
  end;

  LArrConta := fComMascaraPlaNco(fSemMascaraPlaNco(AConta), fMskCon).Split(['.']);
  LArrMasc := LMasc.Split(['.']);

  if Length(LArrConta) > Length(LArrMasc) then
  begin
    AMensagemValidacao := 'O Código da conta informado é maior que o previsto pela máscara [CFG_MSKCON].';
    Exit;
  end;

  LIndexGrauMaxConta := Length(LArrConta) - 1;

  if LArrMasc[LIndexGrauMaxConta].Length <> LArrConta[LIndexGrauMaxConta].Length then
  begin
    AMensagemValidacao := 'A quantidade de dígitos no último grau da conta deve ser igual ao grau correspondente da máscara [CFG_MSKCON].';
    Exit;
  end;

  Result := True;
end;

class function TValidaProcessoContaContabil.fValidaNatureza(
  var AMensagemValidacao: string; const ANatureza: String; const AContaContabil: String): boolean;
begin
  Result := True ;

  if fValidacaoDesligada then
    Exit ;

  if (fEmptyStr(ANatureza)) or (not (CharInSet(ANatureza[1], ['A','S']))) then
  begin
    AMensagemValidacao := 'A Natureza do Plano de Contas Contábil [A/S] deve ser informada!';
    Result := False;
  end;
  if not fValidaNaturezaPelaContaContabil(AContaContabil, ANatureza, AMensagemValidacao) then
  begin
    Result := False;
  end ;
end;

class function TValidaProcessoContaContabil.fValidaNaturezaAjuste(
  var AMensagemValidacao: string; const ANatAju, AAjuLiq: String;
  var ADescNatAju: string): boolean;
begin
  Result := True ;
  ADescNatAju := '' ;

  if fValidacaoDesligada then
  begin
    if not fEmptyStr(ANatAju) then
    begin
      ADescNatAju := fCarregaDescricaoDaNatAjuste(ANatAju);
      if (fEmptyStr(ADescNatAju)) then
      begin
        AMensagemValidacao := 'A Natureza do Ajuste ['+ANatAju+'] informada não existe!' ;
        Result := False;
        Exit ;
      end;
    end ;
    Exit ;
  end ;

  if not fUtilizaNaturezaDoAjuste then
  begin
    exit ;
  end;

  If AAjuLiq = 'Sempre' Then
  Begin
    if (fEmptyStr(ANatAju)) then
    begin
      AMensagemValidacao := 'A Natureza do Ajuste deve ser informada!' ;
      Result := False;
    end
    else
    begin
      ADescNatAju := fCarregaDescricaoDaNatAjuste(ANatAju);
      if (fEmptyStr(ADescNatAju)) then
      begin
        AMensagemValidacao := 'A Natureza do Ajuste ['+ANatAju+'] informada não existe!' ;
        Result := False;
      end;
    end;
  end;

end;

class function TValidaProcessoContaContabil.fValidaNaturezaPelaContaContabil(
  const AstrContaContabil, AstrNatureza: String; var AstrMensagemValidacao: String): boolean;
var
  LstrNaturezaPrevista : String ;
begin
  AstrMensagemValidacao := '' ;
  Result := False ;

  LstrNaturezaPrevista := fRetornaNaturezaPrevista(AstrContaContabil);
  if AstrNatureza <> LstrNaturezaPrevista then
  begin
    AstrMensagemValidacao := 'A Natureza do Plano de Contas Contábil deve ser ' + fRetornaNaturezaExtenso(LstrNaturezaPrevista) +'!' ;
    exit ;
  end ;

  Result := True ;
end;

class function TValidaProcessoContaContabil.fValidaPatrimonial(
  var AMensagemValidacao: string; const APatrimonial,
  AContaContabil: String): boolean;
begin
  Result := True ;
  AMensagemValidacao := '' ;

  if fValidacaoDesligada then
    Exit ;

  if (fEhContaAtivo(AContaContabil)) or (fEhContaPassivo(AContaContabil)) then
  begin
    if not fEhContaPatrimonial(APatrimonial) then
    begin
      AMensagemValidacao := fgetInformativoConta(AContaContabil) + ', informar plano de contas como patrimonial!' ;
      Result := False;
      exit ;
    end ;
  end
  else if not fEhContaCompensacao(AContaContabil) then
  begin
    if fEhContaPatrimonial(APatrimonial) then
    begin
      AMensagemValidacao := fgetInformativoConta(AContaContabil) + ', NÃO pode ser patrimonial!' ;
      Result := False;
      exit ;
    end ;
  end ;

end;

class function TValidaProcessoContaContabil.fValidaPlanoContas(const ADadosValidacao: TDadosValidacaoContaContabil; const AprocErros: TErroContabilProc): boolean;
var
  LArrMensagens: TList<string> ;
  LDictDadosMostrar: TDictPendenciasContaContabil ;
begin
  result := False ;
  LArrMensagens := TList<string>.Create() ;
  try
    LArrMensagens := fRetornaArrayMensagens(ADadosValidacao, nil, nil, nil, '', fRetTplacoEmpresaLogada('', True)) ;
    if LArrMensagens.Count > 0 then
    begin
      LDictDadosMostrar := TDictPendenciasContaContabil.Create ;
      try
        LDictDadosMostrar.Add(ADadosValidacao.AContaContabil, LArrMensagens);
        pMostraMensagens(LDictDadosMostrar, AprocErros) ;
      finally
        FreeAndNil(LDictDadosMostrar) ;
      end;
      exit ;
    end;
  finally
    FreeAndNil(LArrMensagens) ;
  end;
  result := True ;
end;

class function TValidaProcessoContaContabil.fValidaPlanoContasBloco(
  const ADadosValidacao: TList<TDadosValidacaoContaContabil>; const AprocErros: TErroContabilProc;
  const AstrEXPCTB: string = '';
  AResetTabela: Boolean = False; ACfgContabil: ICfgContabil = nil): boolean;
var
  LDadoValidacao: TDadosValidacaoContaContabil ;
  LArrMensagens : TList<string> ;
  LDictDadosMostrar : TDictPendenciasContaContabil ;
  LLstContaDuplicada : TList<string> ;
  LLstContaReduzidaDuplicada : TList<string> ;
  LLstContaTpLaco: TList<string> ;
  LTplacoEmpLog: string;
begin
  FCfgAtivo := ACfgContabil;
  result := False ;
  LDictDadosMostrar := TDictPendenciasContaContabil.Create ;
  LLstContaDuplicada := fRetornaContaDuplicadaBloco(ADadosValidacao) ;
  LLstContaReduzidaDuplicada := fRetornaContaReduzidaDuplicadaBloco(ADadosValidacao) ;
  LLstContaTpLaco := TList<string>.Create ;
  LTplacoEmpLog := fRetTplacoEmpresaLogada('', True);

  try
    for LDadoValidacao in ADadosValidacao do
    begin
      LArrMensagens := fRetornaArrayMensagens(LDadoValidacao, LLstContaDuplicada, LLstContaReduzidaDuplicada, LLstContaTpLaco, AstrEXPCTB, LTplacoEmpLog) ;
      if LArrMensagens.Count > 0 then
      begin
        if not LDictDadosMostrar.ContainsKey(LDadoValidacao.AContaContabil) then
        begin
          LDictDadosMostrar.Add(LDadoValidacao.AContaContabil, LArrMensagens);
        end;
      end
      else
      begin
        LLstContaTpLaco.Add(LDadoValidacao.AContaContabil+LDadoValidacao.ATpLaco) ;
        FreeAndNil(LArrMensagens) ;
      end;
    end;

    if LDictDadosMostrar.Count > 0 then
    begin
      pMostraMensagens(LDictDadosMostrar, AprocErros) ;
      exit ;
    end;

  finally
    FCfgAtivo := nil;
    FreeAndNil(LDictDadosMostrar) ;
    FreeAndNil(LLstContaDuplicada) ;
    FreeAndNil(LLstContaReduzidaDuplicada) ;
    FreeAndNil(LLstContaTpLaco) ;
  end;

  result := True ;
end;

class function TValidaProcessoContaContabil.fValidaRedutora(
  var AMensagemValidacao: string; const ARedutora: String): boolean;
begin
  Result := True ;

  if fValidacaoDesligada then
    Exit ;

  if (fEmptyStr(ARedutora)) or (not (CharInSet(ARedutora[1], ['N','S']))) then
  begin
    AMensagemValidacao := 'A Conta Redutora [N/S] deve ser informada!';
    Result := False;
  end;
end;

class function TValidaProcessoContaContabil.fValidaTplaco(
  var AMensagemValidacao: string; const ATplaco: String; var ADescTpLaco: string): boolean;
begin
  Result := True ;
  ADescTpLaco := '' ;

  if (fEmptyStr(ATplaco)) then
  begin
    if fValidacaoDesligada then
      Exit ;

    AMensagemValidacao := 'O Tipo de Plano de Contas Contábil deve ser informado!' ;
    Result := False;
  end
  else
  begin
    ADescTpLaco := fCarregaDescricaoDoTipoDePlanoDeContaContabil(ATplaco);
    if (fEmptyStr(ADescTpLaco)) then
    begin
      AMensagemValidacao := 'O Tipo de Plano de Contas Contábil ['+ATplaco+'] informado não existe!' ;
      Result := False;
    end;
  end;
end;

class function TValidaProcessoContaContabil.fValidaTplacoEmpLog(
  var AMensagemValidacao: string; const ATplaco,
  ATplacoEmpLog: string): boolean;
begin
  Result := True ;

  if fEmptyStr(ATplacoEmpLog) then
    Exit;

  if fEmptyStr(ATplaco) then
    Exit;

  if ATplacoEmpLog <> ATplaco then
  begin
    AMensagemValidacao := 'O Tipo de Plano de Contas Contábil informado ['+ATplaco+'] deve ser igual ao Tipo de Plano de Contas Contábil da empresa logada ['+ATplacoEmpLog+'].';
    Result := False;
  end;
end;

class function TValidaProcessoContaContabil.fValidaVigenciaConta(
  var AMensagemValidacao: string; const AInicio, AFinal: TDateTime): boolean;
var
  LInicio, LFinal: TDateTime ;
begin
  Result := True ;
  LInicio := AInicio ;
  LFinal := AFinal ;

  if fTemVigencia then
  begin
    if LFinal <> Default(TDateTime) then
    begin
      if LInicio = Default(TDateTime) then
      begin
        AMensagemValidacao := 'Vigência inicial deve ser informada!' ;
        exit ;
      end;

      if CompareDate(LInicio, LFinal) = GreaterThanValue  then
      begin
        AMensagemValidacao := 'Vigência inicial deve ser menor ou igual à vigência final!' ;
        exit ;
      end;

    end;
  end;
end;

class procedure TValidaProcessoContaContabil.pAcumulaMsgVetor(
  var AMensagemValidacao: string; var AArrMensagens: TList<string>);
begin
  if not fEmptyStr(AMensagemValidacao) then
  begin
    AArrMensagens.Add(AMensagemValidacao) ;
  end;
  AMensagemValidacao := '' ;
end;

class procedure TValidaProcessoContaContabil.pMostraMensagens(const AArrMensagens: TDictPendenciasContaContabil; const AprocErros: TErroContabilProc);
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
    end;

    if Assigned(AprocErros) then
      AprocErros(objMensagens.DataSet) ;

  finally
    FreeAndNil(objMensagens) ;
  end;
end;

class procedure TValidaProcessoContaContabil.pSomenteNumerosNaContaContabil(
  var AarrContaContabilComMascara: TArray<String>);
var
  LintCnt: Integer ;
begin
  for LintCnt := Low(AarrContaContabilComMascara) to High(AarrContaContabilComMascara)  do
  begin
    AarrContaContabilComMascara[LintCnt] := fRetSomenteNumeros(AarrContaContabilComMascara[LintCnt]) ;
  end ;
end;

class function TValidaProcessoContaContabil.fCarregaDescricaoDaCtaRef(
  const AContaRef: String): string;
begin
  result := LeftStr(fCampoTabela('NRE_DESCRI', 'PLANRE', ['NRE_CODREF'], [AContaRef]), 42);
end;

class function TValidaProcessoContaContabil.fCarregaNatureDaCtaRef(
  const AContaRef: String): string;
begin
  result := fCampoTabela('NRE_TIPCTA', 'PLANRE', ['NRE_CODREF'], [AContaRef]) ;
end;

{ TValidaProcessoContaContabilBase }

class function TValidaProcessoContaContabilBase.fValidacaoDesligada: Boolean;
begin
  Result := TValidaProcessoContaContabil.fCfg.fCfgSisBoolean('EXPCTB');
end;

end.
