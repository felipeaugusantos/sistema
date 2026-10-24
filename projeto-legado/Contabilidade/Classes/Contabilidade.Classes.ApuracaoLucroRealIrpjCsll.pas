unit Contabilidade.Classes.ApuracaoLucroRealIrpjCsll;

interface

uses MemDS, DBAccess, Uni, Datasnap.DBClient, UniClientDataSet, System.SysUtils,
     Contabilidade.Interfaces, System.Generics.Collections, Data.DB, cxProgressBar,
     Classes;

type

   TApuracaoReceitasAcrecimos = class
   private
     FstrEmpresa: string ;
     FevtAfterEditCsll: TDataSetNotifyEvent ;
     FevtAfterPostCsll: TDataSetNotifyEvent ;
     FevtAfterEditIrpj: TDataSetNotifyEvent ;
     FevtAfterPostIrpj: TDataSetNotifyEvent ;
     FcdsApuRecAcrCsll: TUniClientDataSet ;
     FcdsApuRecAcrIrpj: TUniClientDataSet ;
     procedure pCreateCdsApuRecAcr(var AcdsApuRecAcr: TUniClientDataSet) ;
     function fCarregaDadosInformados(const AintExercicio: integer): TUniClientDataSet ;
     procedure pSincronizaDadosApuRecAcr(var AcdsApuRecAcr: TUniClientDataSet; const AcdsDados: TUniClientDataSet);
     function fGravaDadosDetalhe(const AcdsApuRecAcr: TUniClientDataSet; const AintCodigoAPREAC: integer): boolean;
   public
     constructor Create(); reintroduce ;
     destructor Destroy; override ;
     procedure pAfterEditCsll(AEvento: TDataSetNotifyEvent) ;
     procedure pAfterPostCsll(AEvento: TDataSetNotifyEvent) ;
     procedure pAfterEditIrpj(AEvento: TDataSetNotifyEvent) ;
     procedure pAfterPostIrpj(AEvento: TDataSetNotifyEvent) ;
     function fCarregaDados(const AintExercicio: integer): boolean;
     procedure pProcessaCalculos(AcdsApuRecAcr: TUniClientDataSet) ;
     procedure pLimpaDados;
     function fGravaDados(const AintExercicio: integer; ApgbProgresso: TcxProgressBar): boolean;
     procedure pSetEmpresa(const AstrEmpresa: String) ;
     property cdsApuRecAcrCsll: TUniClientDataSet read FcdsApuRecAcrCsll ;
     property cdsApuRecAcrIrpj: TUniClientDataSet read FcdsApuRecAcrIrpj ;
   end;

   TDeterminacaoEstimativaMensal = class
   private
     FstrEmpresa: string ;
     FintAPPEST: integer ;
     FcdsDadosCsll: TUniClientDataSet ;
     FcdsDadosIrpj: TUniClientDataSet ;
     FcdsDadosOpcao: TUniClientDataSet ;
     FcdsDadosRecolhimento: TUniClientDataSet ;
     procedure pCarregaFields(var AcdsDados: TUniClientDataSet) ;
     procedure pCarregaStringFields(var AcdsDados: TUniClientDataSet) ;
     procedure pCalculaValorApurado(const AstrExercicio: string) ;
     procedure pCalculaRecolhimentoRealizado(const AstrExercicio: string) ;
     function fValorRecolhimentoRealizado(const AstrExercicio, AstrContaContabil: string; const AiiTipo: TCsllIrpj): TDictionary<String, Double> ;
     function fIniciaDadosTabela(const AstrExercicio: string): integer ;
     procedure pIniciaOpcaoRecolhimento;
     procedure pCarregaOpcaoRecolhimentoCDS;
     function fCarregaDadosRealizado(const AstrExercicio: string; const AiiTipo: TCsllIrpj): TUniClientDataSet ;
     function fCarregaCfgPlancoRealizado(const AiiTipo: TCsllIrpj): string ;
     procedure pGravaLanconIgnoradoRealizado(const AcdsDados: TUniClientDataSet; const AiiTipo: TCsllIrpj) ;
     function fLanconIgnoradoRealizado(const AiiTipo: TCsllIrpj): TStringList ;
     procedure pCalculaRecolhimentoValorDevidoInterno(var AdictRecolhimento, AdictValorDevidoAcumulado: TDictionary<Integer,Double>; const AiiTipo: TCsllIrpj) ;
     procedure pGravaRecolhimentoValorDevidoCds(const AdictRecolhimento, AdictValorDevidoAcumulado: TDictionary<Integer,Double>; const AiiTipo: TCsllIrpj) ;
   public
     constructor Create(); reintroduce ;
     destructor Destroy; override ;
     procedure pCalculaValores(const AecEncerramento: TEncerramentoContabil; const AstrExercicio: string) ;
     function fManutencaoRecolhimentosRealizados(const AstrExercicio: string; const AiiTipo: TCsllIrpj):boolean ;
     procedure pGravaOpcaoRecolhimentoEscolhida(const AstrOpcao: string; const AintMes: integer) ;
     procedure pCalculaRecolhimentoValorDevido ;
     procedure pGravaApuracao(const AecEncerramento: TEncerramentoContabil) ;
     procedure pSetEmpresa(const AstrEmpresa: String) ;
     property cdsDadosCsll: TUniClientDataSet read FcdsDadosCsll ;
     property cdsDadosIrpj: TUniClientDataSet read FcdsDadosIrpj ;
     property cdsDadosRecolhimento: TUniClientDataSet read FcdsDadosRecolhimento ;
     property cdsDadosOpcao: TUniClientDataSet read FcdsDadosOpcao ;
   end;

   TDemonstrativoApuracao = class
   private
     FstrEmpresa: String ;
     FdictValoresCalculadosBalancete: TDictionary<String,Double> ;
     FdictValoresCalculadosReceita: TDictionary<String,Double> ;
     procedure pLimpaValores ;
     function fTrimestreByPeriodo(const AdtaDataInicial, AdtaDataFinal: TDateTime):integer ;
     function fCalculaValorDeducoes(const AdtaDataInicial, AdtaDataFinal: TDateTime; const AecEncerramento: TEncerramentoContabil; const AcdsDeducoes: TUniClientDataSet):double ;
     function fCalculaValorAdicionalIrpj(const AfltValorBaseAdicionalIrpj, AfltAliquotaAdicionalIrpj, AfltBaseCalculo: double; const AintMultiplicador: integer): double ;
     function fMultiplicador(const AecEncerramento: TEncerramentoContabil; const AdtaDataFinal: TDateTime; const AblnReceita: Boolean = False): integer ;
   public
     constructor Create(); reintroduce ;
     destructor Destroy; override;
     procedure pCalculaValores(const AecEncerramento: TEncerramentoContabil; const AdtaDataInicial, AdtaDataFinal: TDateTime; const AcdsDeducoesCsll, AcdsDeducoesIrpj, AcdsReceitasCsll, AcdsReceitasIrpj: TUniClientDataSet) ;
     function fGravaAlteracoes(const AecEncerramento: TEncerramentoContabil; const AintExercicio: integer; const AcdsDeducoesCsll, AcdsDeducoesIrpj, AcdsReceitasCsll, AcdsReceitasIrpj: TUniClientDataSet): boolean ;
     procedure pSetEmpresa(const AstrEmpresa: String) ;
     property ValoresCalculadosBalancete: TDictionary<String,Double> read FdictValoresCalculadosBalancete;
     property ValoresCalculadosReceita: TDictionary<String,Double> read FdictValoresCalculadosReceita;
   end;

   TLucroRealDeducoesRetencoes = class
   private
     FcdsDados: TUniClientDataSet ;
     FcdsDadosInicial: TUniClientDataSet ;
     FecEncerramento: TEncerramentoContabil ;
     FiiTipo: TCsllIrpj ;
     FintExercicio: integer ;
     FdictGrupo: TDictionary<Integer,String> ;
     FstrEmpresa: String ;
     procedure pCarregaGrupos ;
     procedure pCarregaDados(const AiiTipo: TCsllIrpj) ;
     procedure pCreateCds ;
     function fRetornaPeriodo:integer;
     function fCarregaDadosGravados: TUniClientDataSet;
     procedure pSincronizaDadosGravados ;
     procedure pAtualizaProgressBar(var AintPosicao: Integer ;ApgbProgresso: TcxProgressBar) ;
   public
     constructor Create(AEventoAfterPost, AEventoAfterEdit: TDataSetNotifyEvent); reintroduce ;
     destructor Destroy; override;
     procedure pSetEmpresa(const AstrEmpresa: String) ;
     procedure pPrepara(const AintExercicio: integer; const AiiTipo: TCsllIrpj) ;
     procedure pProcessaCalculos ;
     procedure pEmptyCds ;
     procedure pCancelaAlteracoes ;
     function fGravaAlteracoes(const AecEncerramento: TEncerramentoContabil; ApgbProgresso: TcxProgressBar): boolean ;
     function fTemDadosGravados: Boolean ;
     property Encerramento: TEncerramentoContabil read FecEncerramento write FecEncerramento ;
     property CdsDados: TUniClientDataSet read FcdsDados ;
   end;

const
   IDENTIFICADOR_TOTAL_DEDUCOES = -2 ;
   DESCRI_BALANCETE_SUSPENSAO_ACUMULADO_CSLL = 'CSLL – Balancete de Suspensão/Redução (Acumulado)' ;
   CODIGO_BALANCETE_SUSPENSAO_ACUMULADO_CSLL = 1 ;
   DESCRI_RECEITA_BRUTA_MENSAL_CSLL = 'CSLL – Receita Bruta e Acréscimos (Mensal)' ;
   CODIGO_RECEITA_BRUTA_MENSAL_CSLL = 2 ;
   DESCRI_RECOLHIMENTOS_REALIZADOS_CSLL = 'Recolhimentos Realizados' ;
   CODIGO_RECOLHIMENTOS_REALIZADOS_CSLL = 3 ;

   DESCRI_BALANCETE_SUSPENSAO_ACUMULADO_IRPJ = 'IRPJ – Balancete de Suspensão/Redução (Acumulado)' ;
   CODIGO_BALANCETE_SUSPENSAO_ACUMULADO_IRPJ = 1 ;
   DESCRI_RECEITA_BRUTA_MENSAL_IRPJ = 'IRPJ – Receita Bruta e Acréscimos (Mensal)' ;
   CODIGO_RECEITA_BRUTA_MENSAL_IRPJ = 2 ;
   DESCRI_RECOLHIMENTOS_REALIZADOS_IRPJ = 'Recolhimentos Realizados' ;
   CODIGO_RECOLHIMENTOS_REALIZADOS_IRPJ = 3 ;

   DESCRI_BALANCETE = 'Balancete' ;
   DESCRI_RECEITA = 'Receita' ;
   DESCRI_OPCAO_RECOLHIMENTO = 'Opção para Recolhimento' ;

   CODIGO_RECOLHIMENTO_SUSPENSAO_MES_CSLL = 1 ;
   DESCRI_RECOLHIMENTO_SUSPENSAO_MES_CSLL = 'Recolhimento/Suspensão CSLL no Mês' ;
   CODIGO_VALOR_DEVIDO_ACUMULADO_CSLL = 2 ;
   DESCRI_VALOR_DEVIDO_ACUMULADO_CSLL = 'Valor Devido – CSLL Acumulada' ;

   CODIGO_RECOLHIMENTO_SUSPENSAO_MES_IRPJ = 3 ;
   DESCRI_RECOLHIMENTO_SUSPENSAO_MES_IRPJ = 'Recolhimento/Suspensão IRPJ no Mês' ;
   CODIGO_VALOR_DEVIDO_ACUMULADO_IRPJ = 4 ;
   DESCRI_VALOR_DEVIDO_ACUMULADO_IRPJ = 'Valor Devido – IRPJ Acumulada' ;

   COD_TOTAL_RECEITA_BRUTA = -1 ;
   COD_BASE_CALCULO = -2 ;
   DES_TOTAL_RECEITA_BRUTA = 'TOTAL – RECEITA BRUTA' ;
   DES_BASE_CALCULO = 'BASE DE CÁLCULO' ;

implementation

uses untFuncoesSimples, Variants, Vcl.Forms, DateUtils,
     Contabilidade.Classes.ApuracaoLucroRealLalurLacs ,
  Contabilidade.View.ApuracaoLucroRealIrpjCsllManRecolhimento, VCL.Controls;

{ TLucroRealDeducoesRetencoes }

constructor TLucroRealDeducoesRetencoes.Create(AEventoAfterPost, AEventoAfterEdit: TDataSetNotifyEvent);
begin
  inherited Create ;
  FcdsDados := TUniClientDataSet.Create(Nil) ;
  FcdsDadosInicial := TUniClientDataSet.Create(Nil) ;
  FcdsDados.AfterPost := AEventoAfterPost ;
  FcdsDados.AfterEdit := AEventoAfterEdit ;
  FdictGrupo := TDictionary<Integer,String>.Create();
  pCarregaGrupos ;
  FecEncerramento := ecTrimestral ;
  FstrEmpresa := '' ;
end;

destructor TLucroRealDeducoesRetencoes.Destroy;
begin
  FreeAndNil(FcdsDados) ;
  FreeAndNil(FcdsDadosInicial) ;
  FreeAndNil(FdictGrupo) ;
  inherited;
end;

function TLucroRealDeducoesRetencoes.fRetornaPeriodo: integer;
begin
  result := iif( FecEncerramento = ecTrimestral, 4, 12) ;
end;

function TLucroRealDeducoesRetencoes.fTemDadosGravados: Boolean;
var
  LcdsVerifica: TUniClientDataSet ;
begin
  LcdsVerifica := fCarregaDadosGravados ;
  try
    Result := not LcdsVerifica.IsEmpty ;
  finally
    FreeAndNil(LcdsVerifica) ;
  end ;
end;

procedure TLucroRealDeducoesRetencoes.pAtualizaProgressBar(
  var AintPosicao: Integer; ApgbProgresso: TcxProgressBar);
begin
  inc(AintPosicao) ;
  if Assigned(ApgbProgresso) then
    ApgbProgresso.Position := AintPosicao;
  Application.ProcessMessages;
end;

procedure TLucroRealDeducoesRetencoes.pCancelaAlteracoes;
begin
  FcdsDados.Data := FcdsDadosInicial.Data ;
end;

procedure TLucroRealDeducoesRetencoes.pCarregaDados(const AiiTipo: TCsllIrpj);
var
  LqryDados: TUniQuery ;
  LpairItem: TPair<Integer,String> ;
  LEventoAfterPost: TDataSetNotifyEvent ;
begin
  LqryDados  := fCriaQuery ;
  try

    LqryDados.Close ;
    LqryDados.SQL.Clear ;
    LqryDados.SQL.Add(' SELECT DED_CODIGO, DED_DESCRI, DED_GRUPO_ ') ;
    LqryDados.SQL.Add(' FROM DEDRET ') ;
    LqryDados.SQL.Add(' WHERE DED_TIPIMP = :TIPIMP ') ;
    LqryDados.SQL.Add(' ORDER BY DED_CODIGO ') ;
    LqryDados.ParamByName('TIPIMP').AsString := COD_IRPJ_CSLL[AiiTipo] ;
    LqryDados.Open ;

    FcdsDados.DisableControls ;
    LqryDados.DisableControls ;
    LEventoAfterPost := FcdsDados.AfterPost ;
    FcdsDados.AfterPost := Nil ;
    try
      for LpairItem in FdictGrupo do
      begin
        FcdsDados.Append ;
        FcdsDados.FieldByName('CONTRO').AsInteger := -3 ;
        FcdsDados.FieldByName('DESCRI').AsString := LpairItem.Value ;
        FcdsDados.Post ;

        ///adiciona os itens do agrupamento
        LqryDados.Filtered := False ;
        LqryDados.Filter := 'DED_GRUPO_ = '+QuotedStr(IntToStr(LpairItem.Key)) ;
        LqryDados.Filtered := True ;
        LqryDados.First ;
        while not LqryDados.Eof do
        begin
          FcdsDados.Append ;
          FcdsDados.FieldByName('CONTRO').AsInteger := 1 ;
          FcdsDados.FieldByName('CODAGR').AsInteger := LpairItem.Key ;
          FcdsDados.FieldByName('CODIGO').AsString := LqryDados.FieldByName('DED_CODIGO').AsString ;
          FcdsDados.FieldByName('DESCRI').AsString := LqryDados.FieldByName('DED_DESCRI').AsString ;
          FcdsDados.Post ;
          LqryDados.Next ;
        end;

        FcdsDados.Append ;
        FcdsDados.FieldByName('CODAGR').AsInteger := LpairItem.Key ;
        FcdsDados.FieldByName('CONTRO').AsInteger := -1 ;
        FcdsDados.FieldByName('DESCRI').AsString := 'TOTAL DAS ' + LpairItem.Value ;
        FcdsDados.Post ;

      end;

      FcdsDados.Append ;
      FcdsDados.FieldByName('CONTRO').AsInteger := IDENTIFICADOR_TOTAL_DEDUCOES ;
      FcdsDados.FieldByName('DESCRI').AsString := '(=) TOTAL DAS DEDUÇÕES, RETENÇÕES E PAGAMENTOS' ;
      FcdsDados.Post ;

      pSincronizaDadosGravados ;

    finally
      FcdsDados.EnableControls ;
      LqryDados.EnableControls ;
      FcdsDados.AfterPost := LEventoAfterPost ;
    end;

    FcdsDadosInicial.Data := FcdsDados.Data ;

  finally
    FreeAndNil(LqryDados) ;
  end;
end;

procedure TLucroRealDeducoesRetencoes.pCarregaGrupos;
var
  LqryGrupos: TUniQuery ;
begin
  LqryGrupos := fCriaQuery() ;
  try
    LqryGrupos.Close ;
    LqryGrupos.SQL.Clear ;
    LqryGrupos.SQL.Add(' SELECT AGR_CODIGO, AGR_DESCRI FROM DEREAG ORDER BY AGR_CODIGO ') ;
    LqryGrupos.Open ;
    LqryGrupos.First ;
    while not LqryGrupos.Eof do
    begin
      FdictGrupo.Add(LqryGrupos.FieldByName('AGR_CODIGO').AsInteger, LqryGrupos.FieldByName('AGR_DESCRI').AsString);
      LqryGrupos.Next ;
    end;
  finally
    FreeAndNil(LqryGrupos) ;
  end;
end;

procedure TLucroRealDeducoesRetencoes.pCreateCds;
var
  LintCnt: integer ;
  LintNumPeriodo: integer ;
begin
  LintNumPeriodo := fRetornaPeriodo ;

  FcdsDados.Close ;
  FcdsDados.FieldDefs.Clear ;
  FcdsDados.FieldDefs.Add('AUTOINCREM', ftAutoInc, 0, False) ;
  FcdsDados.FieldDefs.Add('CODIGO', ftString, 8, False) ;
  FcdsDados.FieldDefs.Add('CODAGR', ftInteger, 0, False) ;
  FcdsDados.FieldDefs.Add('CONTRO', ftInteger, 0, False) ;
  FcdsDados.FieldDefs.Add('DESCRI', ftString, 125, False) ;
  for LintCnt := 1 to LintNumPeriodo do
  begin
    FcdsDados.FieldDefs.Add('VVAL'+fStrZero(inttostr(LintCnt), 2), ftFloat, 0, False) ;
  end;
  FcdsDados.CreateDataSet ;
  FcdsDados.IndexFieldNames := 'AUTOINCREM' ;
  FcdsDados.Open ;
end;

procedure TLucroRealDeducoesRetencoes.pEmptyCds;
begin
  FcdsDados.EmptyDataSet ;
end;

function TLucroRealDeducoesRetencoes.fCarregaDadosGravados: TUniClientDataSet;
var
  LqryDados: TUniQuery ;
begin
  LqryDados := fCriaQuery() ;
  try
    LqryDados.Close ;
    LqryDados.SQL.Clear ;
    LqryDados.SQL.Add(' SELECT DDE_CODDED, EDE_PERAPU, EDE_VALLAN ') ;
    LqryDados.SQL.Add(' FROM APDERE ') ;
    LqryDados.SQL.Add('      INNER JOIN APDDED ON APDDED.DDE_CODAPD = APDERE.AUTOINCREM ') ;
    LqryDados.SQL.Add('      INNER JOIN APDEDE ON APDEDE.EDE_CODDDE = APDDED.AUTOINCREM ') ;
    LqryDados.SQL.Add(' WHERE APD_CODEMP = :CODEMP ') ;
    LqryDados.SQL.Add('       AND APD_EXERCI = :EXERCI ') ;
    LqryDados.SQL.Add('       AND DDE_TIPIMP = :TIPIMP ') ;
    LqryDados.ParamByName('CODEMP').AsString  := FstrEmpresa ;
    LqryDados.ParamByName('EXERCI').AsInteger := FintExercicio ;
    LqryDados.ParamByName('TIPIMP').AsString  := COD_IRPJ_CSLL[FiiTipo] ;
    LqryDados.Open ;

    result := fCriaClientDatset(LqryDados) ;
    result.IndexFieldNames := 'DDE_CODDED;EDE_PERAPU'   ;
  finally
    FreeAndNil(LqryDados) ;
  end;
end;

function TLucroRealDeducoesRetencoes.fGravaAlteracoes(const AecEncerramento: TEncerramentoContabil; ApgbProgresso: TcxProgressBar): boolean;
var
  LqryAPDERE: TUniQuery ;
  LqryExec: TUniQuery ;
  LintCodigoAPDERE: integer ;
  LintCodigoAPDDED: integer ;
  LintNumPeriodo: integer ;
  LintMes: integer ;
  LstrMes: String ;
  LstrFieldName: String ;
  LintPassos: integer ;
  LintPassosTotal: integer ;
begin
  LintNumPeriodo := fRetornaPeriodo ;

  LintPassosTotal := 3 ;
  LintPassos := 0 ;
  if Assigned(ApgbProgresso) then
    ApgbProgresso.Properties.Max := LintPassosTotal ;

  fStartTransaction;
  try
    LqryAPDERE := fCriaQuery() ;
    LqryExec := fCriaQuery() ;
    try
      LqryAPDERE.Close ;
      LqryAPDERE.SQL.Clear ;
      LqryAPDERE.SQL.Add('SELECT AUTOINCREM FROM APDERE WHERE APD_CODEMP = :CODEMP AND APD_EXERCI = :EXERCI ') ;
      LqryAPDERE.ParamByName('CODEMP').AsString := FstrEmpresa ;
      LqryAPDERE.ParamByName('EXERCI').AsInteger := FintExercicio ;
      LqryAPDERE.Open ;
      if LqryAPDERE.IsEmpty then
      begin
        LqryExec.Close ;
        LqryExec.SQL.Clear ;
        LqryExec.SQL.Add('INSERT INTO APDERE (APD_CODEMP, APD_EXERCI) VALUES (:CODEMP, :EXERCI) ;') ;
        LqryExec.ParamByName('CODEMP').AsString := FstrEmpresa ;
        LqryExec.ParamByName('EXERCI').AsInteger := FintExercicio ;
        LqryExec.ExecSQL ;

        LqryAPDERE.Close ;
        LqryAPDERE.SQL.Clear ;
        LqryAPDERE.SQL.Add('SELECT LAST_INSERT_ID() ') ;
        LqryAPDERE.Open ;
      end;
      LintCodigoAPDERE := LqryAPDERE.Fields.Fields[0].AsInteger ;

      pAtualizaProgressBar(LintPassos, ApgbProgresso) ;

      ///limpa a estrutura para relançar.
      LqryExec.Close ;
      LqryExec.SQL.Clear ;
      LqryExec.SQL.Add('DELETE FROM APDDED WHERE DDE_CODAPD = :CODAPD AND DDE_TIPIMP = :TIPIMP ') ;
      LqryExec.ParamByName('CODAPD').AsInteger := LintCodigoAPDERE ;
      LqryExec.ParamByName('TIPIMP').AsString := COD_IRPJ_CSLL[FiiTipo] ;
      LqryExec.ExecSQL ;

      pAtualizaProgressBar(LintPassos, ApgbProgresso) ;

      FcdsDados.First ;
      while not FcdsDados.Eof do
      begin
        if FcdsDados.FieldByName('CONTRO').AsInteger < 0 then
        begin
          FcdsDados.Next ;
          continue ;
        end;

        LqryExec.Close ;
        LqryExec.SQL.Clear ;
        LqryExec.SQL.Add('INSERT INTO APDDED (DDE_CODAPD, DDE_CODDED, DDE_ENCERR, DDE_TIPIMP) VALUES (:CODAPD, :CODDED, :ENCERR, :TIPIMP) ') ;
        LqryExec.ParamByName('CODAPD').AsInteger := LintCodigoAPDERE ;
        LqryExec.ParamByName('CODDED').AsString := FcdsDados.FieldByName('CODIGO').AsString ;
        LqryExec.ParamByName('ENCERR').AsString := COD_ENCERRAMENTO_CONTABIL[AecEncerramento] ;
        LqryExec.ParamByName('TIPIMP').AsString := COD_IRPJ_CSLL[FiiTipo] ;
        LqryExec.ExecSQL ;

        ///recupera o autoincrem
        LqryExec.Close ;
        LqryExec.SQL.Clear ;
        LqryExec.SQL.Add('SELECT LAST_INSERT_ID() ') ;
        LqryExec.Open ;
        LintCodigoAPDDED := LqryExec.Fields.Fields[0].AsInteger ;

        for LintMes := 1 to LintNumPeriodo do
        begin
          LstrMes := fStrZero(inttostr(LintMes), 2) ;
          LstrFieldName := 'VVAL' + LstrMes ;

          LqryExec.Close ;
          LqryExec.SQL.Clear ;
          LqryExec.SQL.Add('INSERT INTO APDEDE (EDE_CODDDE, EDE_PERAPU, EDE_VALLAN) VALUES (:CODDDE, :PERAPU, :VALLAN) ') ;
          LqryExec.ParamByName('CODDDE').AsInteger := LintCodigoAPDDED ;
          LqryExec.ParamByName('PERAPU').AsInteger := LintMes ;
          LqryExec.ParamByName('VALLAN').AsFloat := FcdsDados.FieldByName(LstrFieldName).AsFloat ;
          LqryExec.ExecSQL ;
        end;

        FcdsDados.Next ;
      end;

      pAtualizaProgressBar(LintPassos, ApgbProgresso) ;

    finally
      FreeAndNil(LqryAPDERE) ;
      FreeAndNil(LqryExec) ;
    end;
    fCommit;
    result := True ;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      raise E ;
    End;
  end;
end;

procedure TLucroRealDeducoesRetencoes.pPrepara(const AintExercicio: integer; const AiiTipo: TCsllIrpj);
begin
  FiiTipo := AiiTipo ;
  FintExercicio := AintExercicio ;
  pCreateCds ;
  pCarregaDados(AiiTipo) ;
end;

procedure TLucroRealDeducoesRetencoes.pProcessaCalculos;
var
  LcdsAux: TUniClientDataSet ;
  LstrMes: string ;
  LstrMesTotal: string ;
  LstrFieldName: string ;
  LintMes: integer ;
  LdictValor: TDictionary<string, double> ;
  LdictValorTotal: TDictionary<string, double> ;
  LstrBookMarkCodigo: string ;
  LEventoAfterPost: TDataSetNotifyEvent ;
  LEventoAfterEdit: TDataSetNotifyEvent ;
  LintNumPeriodo: integer ;
  LpairItem: TPair<Integer,String> ;
begin
  LintNumPeriodo := fRetornaPeriodo ;

  LcdsAux := TUniClientDataSet.Create(Nil);
  LdictValor := TDictionary<string, double>.Create ;
  LdictValorTotal := TDictionary<string, double>.Create ;
  try
    ///inicializa os dicts
    for LintMes := 1 to LintNumPeriodo do
    begin
      LstrMesTotal := fStrZero(inttostr(LintMes), 2) ;
      LdictValorTotal.Add(LstrMesTotal, 0.00) ;
      for LpairItem in FdictGrupo do
      begin
        LstrMes := LstrMesTotal + ';' + inttostr(LpairItem.Key) ;
        LdictValor.Add(LstrMes, 0.00);
      end;
    end;

    LcdsAux.Data := FcdsDados.Data;
    LcdsAux.DisableControls ;
    try
      LcdsAux.First ;
      while not LcdsAux.Eof do
      begin
        ///desconsidera os totalizadores
        if LcdsAux.FieldByName('CONTRO').AsInteger < 0 then
        begin
          LcdsAux.Next ;
          continue ;
        end;

        for LintMes := 1 to LintNumPeriodo do
        begin
          LstrMesTotal := fStrZero(inttostr(LintMes), 2) ;
          LstrFieldName := 'VVAL' + LstrMesTotal ;
          LstrMes := LstrMesTotal + ';' + LcdsAux.FieldByName('CODAGR').AsString ;
          if not LcdsAux.FieldByName(LstrFieldName).IsNull then
          begin
            LdictValor.Items[LstrMes] := LdictValor.Items[LstrMes] + fFormataFloat(LcdsAux.FieldByName(LstrFieldName).AsFloat, 2) ;
            LdictValorTotal.Items[LstrMesTotal] := LdictValorTotal.Items[LstrMesTotal] + fFormataFloat(LcdsAux.FieldByName(LstrFieldName).AsFloat, 2) ;
          end;
        end;
        LcdsAux.Next ;
      end;
    finally
      LcdsAux.EnableControls ;
    end;
    ///ajusta os totalizadores
    LEventoAfterPost := FcdsDados.AfterPost ;
    FcdsDados.AfterPost := Nil ;
    LEventoAfterEdit := FcdsDados.AfterEdit ;
    FcdsDados.AfterEdit := Nil ;
    FcdsDados.DisableControls ;
    try
      LstrBookMarkCodigo := FcdsDados.FieldByName('CODIGO').AsString ;
      for LpairItem in FdictGrupo do
      begin
        FcdsDados.Locate('CONTRO;CODAGR', VarArrayOf([-1,LpairItem.Key]), [loCaseInsensitive]) ;
        FcdsDados.Edit ;
        for LintMes := 1 to LintNumPeriodo do
        begin
          LstrMesTotal := fStrZero(inttostr(LintMes), 2) ;
          LstrFieldName := 'VVAL' + LstrMesTotal ;
          LstrMes := LstrMesTotal + ';' + inttostr(LpairItem.Key) ;
          FcdsDados.FieldByName(LstrFieldName).AsFloat := LdictValor.Items[LstrMes] ;
        end;
        FcdsDados.Post ;
      end ;

      ///total geral
      FcdsDados.Locate('CONTRO', -2, [loCaseInsensitive]) ;
      FcdsDados.Edit ;
      for LintMes := 1 to LintNumPeriodo do
      begin
        LstrMes := fStrZero(inttostr(LintMes), 2) ;
        LstrFieldName := 'VVAL' + LstrMes ;
        FcdsDados.FieldByName(LstrFieldName).AsFloat := LdictValorTotal.Items[LstrMes] ;
      end;
      FcdsDados.Post ;

      ///restaura
      FcdsDados.Locate('CODIGO', LstrBookMarkCodigo, [loCaseInsensitive]) ;
    finally
      FcdsDados.EnableControls ;
      FcdsDados.AfterPost := LEventoAfterPost ;
      FcdsDados.AfterEdit := LEventoAfterEdit ;
    end;
    ///
  finally
    FreeAndNil(LcdsAux) ;
    FreeAndNil(LdictValor) ;
    FreeAndNil(LdictValorTotal) ;
  end;
end;

procedure TLucroRealDeducoesRetencoes.pSetEmpresa(const AstrEmpresa: String);
begin
  FstrEmpresa := AstrEmpresa ;
end;

procedure TLucroRealDeducoesRetencoes.pSincronizaDadosGravados;
var
  LcdsDadosGravados: TUniClientDataSet ;

  LintMes: integer ;
  LstrMes: string ;
  LstrFieldName: string ;
  LEventoAfterEdit: TDataSetNotifyEvent ;
  LintNumPeriodo: integer ;
begin
  LintNumPeriodo := fRetornaPeriodo ;

  LcdsDadosGravados := fCarregaDadosGravados ;
  try

    FcdsDados.First ;
    LEventoAfterEdit := FcdsDados.AfterEdit ;
    FcdsDados.AfterEdit := Nil ;
    try
      while not FcdsDados.Eof  do
      begin
        for LintMes := 1 to LintNumPeriodo do
        begin
          if LcdsDadosGravados.FindKey([FcdsDados.FieldByName('CODIGO').AsString, LintMes]) then
          begin
            LstrMes := fStrZero(inttostr(LintMes), 2) ;
            LstrFieldName := 'VVAL' + LstrMes ;
            FcdsDados.Edit ;
            FcdsDados.FieldByName(LstrFieldName).AsFloat := LcdsDadosGravados.FieldByName('EDE_VALLAN').AsFloat ;
            FcdsDados.Post ;
          end;
        end;
        FcdsDados.Next ;
      end;
      ///calcula os totais
      pProcessaCalculos ;
    finally
      FcdsDados.AfterEdit := LEventoAfterEdit ;
    end;

  finally
    FreeAndNil(LcdsDadosGravados) ;
  end;
end;

{ TDemonstrativoApuracao }

constructor TDemonstrativoApuracao.Create();
begin
  inherited Create ;
  FstrEmpresa := '' ;
  FdictValoresCalculadosBalancete := TDictionary<String,Double>.Create ;
  FdictValoresCalculadosReceita := TDictionary<String,Double>.Create ;
  //Balancete
  FdictValoresCalculadosBalancete.Add('BaseCalculoCsll', 0.00);
  FdictValoresCalculadosBalancete.Add('Csll', 0.00);
  FdictValoresCalculadosBalancete.Add('DeducaoCsll', 0.00);
  FdictValoresCalculadosBalancete.Add('CsllRecolher', 0.00);

  FdictValoresCalculadosBalancete.Add('BaseCalculoIrpj', 0.00);
  FdictValoresCalculadosBalancete.Add('Irpj', 0.00);
  FdictValoresCalculadosBalancete.Add('AdicionalIrpj', 0.00);
  FdictValoresCalculadosBalancete.Add('DeducaoIrpj', 0.00);
  FdictValoresCalculadosBalancete.Add('IrpjRecolher', 0.00);
  //Receita
  FdictValoresCalculadosReceita.Add('BaseCalculoCsll', 0.00);
  FdictValoresCalculadosReceita.Add('Csll', 0.00);
  FdictValoresCalculadosReceita.Add('DeducaoCsll', 0.00);
  FdictValoresCalculadosReceita.Add('CsllRecolher', 0.00);

  FdictValoresCalculadosReceita.Add('BaseCalculoIrpj', 0.00);
  FdictValoresCalculadosReceita.Add('Irpj', 0.00);
  FdictValoresCalculadosReceita.Add('AdicionalIrpj', 0.00);
  FdictValoresCalculadosReceita.Add('DeducaoIrpj', 0.00);
  FdictValoresCalculadosReceita.Add('IrpjRecolher', 0.00);
end;

destructor TDemonstrativoApuracao.Destroy;
begin
  FreeAndNil(FdictValoresCalculadosBalancete) ;
  FreeAndNil(FdictValoresCalculadosReceita) ;
  inherited;
end;

function TDemonstrativoApuracao.fCalculaValorDeducoes(const AdtaDataInicial,
  AdtaDataFinal: TDateTime; const AecEncerramento: TEncerramentoContabil;
  const AcdsDeducoes: TUniClientDataSet): double;
var
  LfltSomaDeducoes: double ;
  LintMesFinalDeducoes: integer ;
  LintMes: integer ;
begin
  LfltSomaDeducoes := 0.00 ;
  if AecEncerramento = ecTrimestral then
  begin
    LintMesFinalDeducoes := fTrimestreByPeriodo(AdtaDataInicial, AdtaDataFinal) ;
    LfltSomaDeducoes := LfltSomaDeducoes + AcdsDeducoes.FieldByName('VVAL'+fStrZero(inttostr(LintMesFinalDeducoes), 2)).AsFloat ;
  end
  else /// anual/mensal
  begin
    LintMesFinalDeducoes := MonthOf(AdtaDataFinal) ;
    for LintMes := 1 to LintMesFinalDeducoes do
    begin
      LfltSomaDeducoes := LfltSomaDeducoes + AcdsDeducoes.FieldByName('VVAL'+fStrZero(inttostr(LintMes), 2)).AsFloat ;
    end;
  end;
  result := LfltSomaDeducoes ;
end;

function TDemonstrativoApuracao.fGravaAlteracoes(
  const AecEncerramento: TEncerramentoContabil;
  const AintExercicio: integer;
  const AcdsDeducoesCsll, AcdsDeducoesIrpj, AcdsReceitasCsll, AcdsReceitasIrpj: TUniClientDataSet): boolean;
var
  LlstPeriodo: TStrings ;
  LintCnt: integer ;

  LdtaDataInicioApuracao, LdtaDataFinalApuracao: TDateTime ;
  LdictSelecionado: TDictionary<string, TDateTime> ;

  LqryExec: TUniQuery ;
  LintAutoIncAPDEAP: integer ;
  LintPeriodo: integer ;
begin

  LlstPeriodo := TStringList.Create ;
  LqryExec := fCriaQuery ;
  try
    pPeriodoEncerramento(intTostr(AintExercicio), AecEncerramento, LlstPeriodo) ;
    fStartTransaction;
    try
      LqryExec.Close ;
      LqryExec.SQL.Clear ;
      LqryExec.SQL.Add('DELETE FROM APDEAP WHERE EAP_CODEMP = :CODEMP AND EAP_EXERCI = :EXERCI ') ;
      LqryExec.ParamByName('CODEMP').AsString := FstrEmpresa ;
      LqryExec.ParamByName('EXERCI').AsInteger := AintExercicio ;
      LqryExec.ExecSQL ;

      LqryExec.Close ;
      LqryExec.SQL.Clear ;
      LqryExec.SQL.Add('INSERT INTO APDEAP (EAP_CODEMP, EAP_EXERCI) VALUES (:CODEMP, :EXERCI); ') ;
      LqryExec.ParamByName('CODEMP').AsString := FstrEmpresa ;
      LqryExec.ParamByName('EXERCI').AsInteger := AintExercicio ;
      LqryExec.ExecSQL ;

      LqryExec.Close ;
      LqryExec.SQL.Clear ;
      LqryExec.SQL.Add('SELECT LAST_INSERT_ID() ') ;
      LqryExec.Open ;
      LintAutoIncAPDEAP := LqryExec.Fields.Fields[0].AsInteger ;

      for LintCnt := 0 to LlstPeriodo.Count-1 do
      begin
        LdictSelecionado := LlstPeriodo.Objects[LintCnt] as TDictionary<string, TDateTime> ;
        LdtaDataInicioApuracao := LdictSelecionado['inicio'] ;
        LdtaDataFinalApuracao := LdictSelecionado['final'] ;
        LintPeriodo := iif(AecEncerramento = ecTrimestral, fTrimestreByPeriodo(LdtaDataInicioApuracao, LdtaDataFinalApuracao), MonthOf(LdtaDataFinalApuracao) ) ;

        pCalculaValores(AecEncerramento, LdtaDataInicioApuracao, LdtaDataFinalApuracao, AcdsDeducoesCsll, AcdsDeducoesIrpj, AcdsReceitasCsll, AcdsReceitasIrpj ) ;
        ///depois de chamar a proc pCalculaValores usa as informações do dict de balancete e receita

        //// balancete
        LqryExec.Close ;
        LqryExec.SQL.Clear ;
        LqryExec.SQL.Add(' INSERT INTO APDDET (DET_CODEAP, DET_PERAPU, DET_TIPREG, DET_BCCSLL, DET_VLCSLL, DET_VLDEDC, DET_RCCSLL, DET_BCIRPJ, DET_VLIRPJ, DET_VLADIC, DET_VLDEDI, DET_RCIRPJ) ') ;
        LqryExec.SQL.Add(' VALUES (:CODEAP, :PERAPU, :TIPREG, :BCCSLL, :VLCSLL, :VLDEDC, :RCCSLL, :BCIRPJ, :VLIRPJ, :VLADIC, :VLDEDI, :RCIRPJ); ') ;
        LqryExec.ParamByName('CODEAP').AsInteger := LintAutoIncAPDEAP ;
        LqryExec.ParamByName('PERAPU').AsInteger := LintPeriodo ;
        LqryExec.ParamByName('TIPREG').AsString := COD_DEMONSTRATIVO_APURACAO[tdaBalancete] ;
        LqryExec.ParamByName('BCCSLL').AsFloat := FdictValoresCalculadosBalancete['BaseCalculoCsll'] ;
        LqryExec.ParamByName('VLCSLL').AsFloat := FdictValoresCalculadosBalancete['Csll'] ;
        LqryExec.ParamByName('VLDEDC').AsFloat := FdictValoresCalculadosBalancete['DeducaoCsll'] ;
        LqryExec.ParamByName('RCCSLL').AsFloat := FdictValoresCalculadosBalancete['CsllRecolher'] ;
        LqryExec.ParamByName('BCIRPJ').AsFloat := FdictValoresCalculadosBalancete['BaseCalculoIrpj'] ;
        LqryExec.ParamByName('VLIRPJ').AsFloat := FdictValoresCalculadosBalancete['Irpj'] ;
        LqryExec.ParamByName('VLADIC').AsFloat := FdictValoresCalculadosBalancete['AdicionalIrpj'] ;
        LqryExec.ParamByName('VLDEDI').AsFloat := FdictValoresCalculadosBalancete['DeducaoIrpj'] ;
        LqryExec.ParamByName('RCIRPJ').AsFloat := FdictValoresCalculadosBalancete['IrpjRecolher'] ;
        LqryExec.ExecSQL ;

        //// receita
        LqryExec.Close ;
        LqryExec.SQL.Clear ;
        LqryExec.SQL.Add(' INSERT INTO APDDET (DET_CODEAP, DET_PERAPU, DET_TIPREG, DET_BCCSLL, DET_VLCSLL, DET_VLDEDC, DET_RCCSLL, DET_BCIRPJ, DET_VLIRPJ, DET_VLADIC, DET_VLDEDI, DET_RCIRPJ) ') ;
        LqryExec.SQL.Add(' VALUES (:CODEAP, :PERAPU, :TIPREG, :BCCSLL, :VLCSLL, :VLDEDC, :RCCSLL, :BCIRPJ, :VLIRPJ, :VLADIC, :VLDEDI, :RCIRPJ); ') ;
        LqryExec.ParamByName('CODEAP').AsInteger := LintAutoIncAPDEAP ;
        LqryExec.ParamByName('PERAPU').AsInteger := LintPeriodo ;
        LqryExec.ParamByName('TIPREG').AsString := COD_DEMONSTRATIVO_APURACAO[tdaReceita] ;
        LqryExec.ParamByName('BCCSLL').AsFloat := FdictValoresCalculadosReceita['BaseCalculoCsll'] ;
        LqryExec.ParamByName('VLCSLL').AsFloat := FdictValoresCalculadosReceita['Csll'] ;
        LqryExec.ParamByName('VLDEDC').AsFloat := 0.00 ;
        LqryExec.ParamByName('RCCSLL').AsFloat := FdictValoresCalculadosReceita['CsllRecolher'] ;
        LqryExec.ParamByName('BCIRPJ').AsFloat := FdictValoresCalculadosReceita['BaseCalculoIrpj'] ;
        LqryExec.ParamByName('VLIRPJ').AsFloat := FdictValoresCalculadosReceita['Irpj'] ;
        LqryExec.ParamByName('VLADIC').AsFloat := FdictValoresCalculadosReceita['AdicionalIrpj'] ;
        LqryExec.ParamByName('VLDEDI').AsFloat := 0.00 ;
        LqryExec.ParamByName('RCIRPJ').AsFloat := FdictValoresCalculadosReceita['IrpjRecolher'] ;
        LqryExec.ExecSQL ;
      end;
      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        raise E ;
      End;
    end;
    pLimparInstanciasPeriodoEncerramento(LlstPeriodo) ;

  finally
    FreeAndNil(LlstPeriodo) ;
    FreeAndNil(LqryExec) ;
  end;

  result := True ;
end;

function TDemonstrativoApuracao.fMultiplicador(
  const AecEncerramento: TEncerramentoContabil; const AdtaDataFinal: TDateTime;
  const AblnReceita: Boolean): integer;
begin
  if AblnReceita then
  begin
    Result := 1 ;
    exit ;
  end;
  if AecEncerramento = ecTrimestral then
  begin
    Result := 3 ;
  end
  else
  begin
    Result := MonthOf(AdtaDataFinal) ;
  end;
end;

function TDemonstrativoApuracao.fTrimestreByPeriodo(const AdtaDataInicial,
  AdtaDataFinal: TDateTime): integer;
begin
  if (MonthOf(AdtaDataInicial) = 1) and  (MonthOf(AdtaDataFinal) = 3) then
  begin
    result := 1 ;
  end
  else if (MonthOf(AdtaDataInicial) = 4) and  (MonthOf(AdtaDataFinal) = 6) then
  begin
    result := 2 ;
  end
  else if (MonthOf(AdtaDataInicial) = 7) and  (MonthOf(AdtaDataFinal) = 9) then
  begin
    result := 3 ;
  end
  else // ultimo trimestre
  begin
    result := 4 ;
  end;
end;

function TDemonstrativoApuracao.fCalculaValorAdicionalIrpj(
  const AfltValorBaseAdicionalIrpj, AfltAliquotaAdicionalIrpj, AfltBaseCalculo: double;
  const AintMultiplicador: integer): double ;
var
  LfltBaseAdicionalCalculada: double ;
begin
  result := 0.00 ;
  LfltBaseAdicionalCalculada := AfltValorBaseAdicionalIrpj * AintMultiplicador ;

  if AfltBaseCalculo > LfltBaseAdicionalCalculada then
  begin
    result := fFormataFloat((AfltBaseCalculo - LfltBaseAdicionalCalculada) * (AfltAliquotaAdicionalIrpj/100), 2)  ;
  end;

end;

procedure TDemonstrativoApuracao.pCalculaValores(const AecEncerramento: TEncerramentoContabil;
                                                 const AdtaDataInicial, AdtaDataFinal: TDateTime;
                                                 const AcdsDeducoesCsll, AcdsDeducoesIrpj, AcdsReceitasCsll, AcdsReceitasIrpj: TUniClientDataSet);
var
  LqryAPUVRE: TUniQuery ;
  LqryEPREGT: TUniQuery ;
  LstrBaseCalculo: string ;
  LcdsAuxDeducoesCsll: TUniClientDataSet ;
  LcdsAuxDeducoesIrpj: TUniClientDataSet ;
  LfltValorBaseAdicionalIrpj: double ;
  LfltAliquotaAdicionalIrpj: double ;
  LintMes: Integer ;
  LstrMes: String ;
  LstrFieldName: String ;
begin
  pLimpaValores ;

  LqryAPUVRE := fCriaQuery() ;
  LqryEPREGT := fCriaQuery() ;
  LcdsAuxDeducoesCsll := TUniClientDataSet.Create(nil) ;
  LcdsAuxDeducoesIrpj := TUniClientDataSet.Create(nil) ;
  try
    LqryAPUVRE.Close ;
    LqryAPUVRE.SQL.Clear ;
    LqryAPUVRE.SQL.Add(' SELECT VRE_VLRBAS, VRE_TIPLAN, PRE_DTAINI, PRE_DTAFIN ') ;
    LqryAPUVRE.SQL.Add(' FROM APUVRE INNER JOIN APUPRE ON APUVRE.VRE_CODPRE = APUPRE.PRE_CODPRE ') ;
    LqryAPUVRE.SQL.Add(' WHERE PRE_CODEMP = :CODEMP ') ;
    LqryAPUVRE.SQL.Add('       AND PRE_DTAFIN BETWEEN :DTAINI AND :DTAFIN ') ;
    LqryAPUVRE.SQL.Add(' ORDER BY VRE_TIPLAN, PRE_DTAINI, PRE_DTAFIN ') ;
    LqryAPUVRE.ParamByName('CODEMP').AsString := FstrEmpresa ;
    LqryAPUVRE.ParamByName('DTAINI').AsDateTime := AdtaDataInicial ;
    LqryAPUVRE.ParamByName('DTAFIN').AsDateTime := AdtaDataFinal ;
    LqryAPUVRE.Open ;
    LqryAPUVRE.First ;

    ///aliquotas
    LqryEPREGT.Close ;
    LqryEPREGT.SQL.Clear ;
    LqryEPREGT.SQL.Add(' SELECT TRI_VLIRPJ, TRI_VLCSLL, TRI_VALBAS, TRI_ADIRPJ ') ;
    LqryEPREGT.SQL.Add(' FROM EPREGT ') ;
    LqryEPREGT.SQL.Add(' WHERE TRI_CODEMP = :CODEMP ') ;
    LqryEPREGT.SQL.Add('       AND TRI_ANOEXE = :ANOEXE ') ;
    LqryEPREGT.ParamByName('CODEMP').AsString := FstrEmpresa ;
    LqryEPREGT.ParamByName('ANOEXE').AsInteger := YearOf(AdtaDataInicial) ;
    LqryEPREGT.Open ;
    LqryEPREGT.First ;

    ///deduções Csll
    LcdsAuxDeducoesCsll.Data := AcdsDeducoesCsll.Data ;
    LcdsAuxDeducoesCsll.Filtered := False ;
    LcdsAuxDeducoesCsll.Filter := 'CONTRO = ' + IntToStr(IDENTIFICADOR_TOTAL_DEDUCOES)   ;
    LcdsAuxDeducoesCsll.Filtered := True ;

    /// deduções Irpj
    LcdsAuxDeducoesIrpj.Data := AcdsDeducoesIrpj.Data ;
    LcdsAuxDeducoesIrpj.Filtered := False ;
    LcdsAuxDeducoesIrpj.Filter := 'CONTRO = ' + IntToStr(IDENTIFICADOR_TOTAL_DEDUCOES)   ;
    LcdsAuxDeducoesIrpj.Filtered := True ;

    // balancete
    while not LqryAPUVRE.Eof do
    begin
      LstrBaseCalculo := iif(LqryAPUVRE.FieldByName('VRE_TIPLAN').AsString = COD_LACS_LALUR[llLacs], 'BaseCalculoCsll', 'BaseCalculoIrpj') ;
      if LqryAPUVRE.FieldByName('PRE_DTAFIN').AsDateTime = AdtaDataFinal then
      begin
        FdictValoresCalculadosBalancete[LstrBaseCalculo] := LqryAPUVRE.FieldByName('VRE_VLRBAS').AsFloat ;
      end ;
      LqryAPUVRE.Next ;
    end;
    //receita
    LintMes := MonthOf(AdtaDataFinal) ;
    LstrMes := fStrZero(inttostr(LintMes), 2) ;
    LstrFieldName := 'BCAL' + LstrMes ;
    AcdsReceitasCsll.Locate('CODIGO', COD_BASE_CALCULO, [loCaseInsensitive]) ;
    LstrBaseCalculo := 'BaseCalculoCsll' ;
    FdictValoresCalculadosReceita[LstrBaseCalculo] := AcdsReceitasCsll.FieldByName(LstrFieldName).AsFloat ;
    AcdsReceitasIrpj.Locate('CODIGO', COD_BASE_CALCULO, [loCaseInsensitive]) ;
    LstrBaseCalculo := 'BaseCalculoIrpj' ;
    FdictValoresCalculadosReceita[LstrBaseCalculo] := AcdsReceitasIrpj.FieldByName(LstrFieldName).AsFloat ;

    FdictValoresCalculadosBalancete['Csll'] := fFormataFloat(FdictValoresCalculadosBalancete['BaseCalculoCsll'] * (LqryEPREGT.FieldByName('TRI_VLCSLL').AsFloat/100), 2) ;
    FdictValoresCalculadosReceita['Csll'] := fFormataFloat(FdictValoresCalculadosReceita['BaseCalculoCsll'] * (LqryEPREGT.FieldByName('TRI_VLCSLL').AsFloat/100), 2) ;
    FdictValoresCalculadosBalancete['Irpj'] := fFormataFloat(FdictValoresCalculadosBalancete['BaseCalculoIrpj'] * (LqryEPREGT.FieldByName('TRI_VLIRPJ').AsFloat/100), 2) ;
    FdictValoresCalculadosReceita['Irpj'] := fFormataFloat(FdictValoresCalculadosReceita['BaseCalculoIrpj'] * (LqryEPREGT.FieldByName('TRI_VLIRPJ').AsFloat/100), 2) ;

    //adicional Irpj
    LfltValorBaseAdicionalIrpj := LqryEPREGT.FieldByName('TRI_VALBAS').AsFloat ;
    LfltAliquotaAdicionalIrpj := LqryEPREGT.FieldByName('TRI_ADIRPJ').AsFloat ;
    FdictValoresCalculadosBalancete['AdicionalIrpj'] := fCalculaValorAdicionalIrpj(LfltValorBaseAdicionalIrpj, LfltAliquotaAdicionalIrpj, FdictValoresCalculadosBalancete['BaseCalculoIrpj'], fMultiplicador(AecEncerramento, AdtaDataFinal) ) ;
    FdictValoresCalculadosReceita['AdicionalIrpj'] := fCalculaValorAdicionalIrpj(LfltValorBaseAdicionalIrpj, LfltAliquotaAdicionalIrpj, FdictValoresCalculadosReceita['BaseCalculoIrpj'], fMultiplicador(AecEncerramento, AdtaDataFinal, True ) ) ;

    //deduções
    FdictValoresCalculadosBalancete['DeducaoCsll'] := fCalculaValorDeducoes(AdtaDataInicial, AdtaDataFinal, AecEncerramento, LcdsAuxDeducoesCsll) ;
    FdictValoresCalculadosBalancete['DeducaoIrpj'] := fCalculaValorDeducoes(AdtaDataInicial, AdtaDataFinal, AecEncerramento, LcdsAuxDeducoesIrpj) ;

    //imposto a recolher
    FdictValoresCalculadosBalancete['CsllRecolher'] := FdictValoresCalculadosBalancete['Csll'] - FdictValoresCalculadosBalancete['DeducaoCsll'] ;
    FdictValoresCalculadosReceita['CsllRecolher'] := FdictValoresCalculadosReceita['Csll'];
    FdictValoresCalculadosBalancete['IrpjRecolher'] := FdictValoresCalculadosBalancete['Irpj'] + FdictValoresCalculadosBalancete['AdicionalIrpj'] - FdictValoresCalculadosBalancete['DeducaoIrpj'] ;
    FdictValoresCalculadosReceita['IrpjRecolher'] := FdictValoresCalculadosReceita['Irpj'] + FdictValoresCalculadosReceita['AdicionalIrpj'] ;

  finally
    FreeAndNil(LqryAPUVRE) ;
    FreeAndNil(LqryEPREGT) ;
    FreeAndNil(LcdsAuxDeducoesCsll) ;
    FreeAndNil(LcdsAuxDeducoesIrpj) ;
  end;
end;

procedure TDemonstrativoApuracao.pLimpaValores;
begin
  //Balancete
  FdictValoresCalculadosBalancete['BaseCalculoCsll'] := 0.00;
  FdictValoresCalculadosBalancete['Csll'] := 0.00;
  FdictValoresCalculadosBalancete['DeducaoCsll'] := 0.00;
  FdictValoresCalculadosBalancete['CsllRecolher'] := 0.00;

  FdictValoresCalculadosBalancete['BaseCalculoIrpj'] := 0.00;
  FdictValoresCalculadosBalancete['Irpj'] := 0.00 ;
  FdictValoresCalculadosBalancete['AdicionalIrpj'] := 0.00;
  FdictValoresCalculadosBalancete['DeducaoIrpj'] := 0.00;
  FdictValoresCalculadosBalancete['IrpjRecolher'] := 0.00;
  //Receita
  FdictValoresCalculadosReceita['BaseCalculoCsll'] := 0.00;
  FdictValoresCalculadosReceita['Csll'] := 0.00;
  FdictValoresCalculadosReceita['DeducaoCsll'] := 0.00;
  FdictValoresCalculadosReceita['CsllRecolher'] := 0.00;

  FdictValoresCalculadosReceita['BaseCalculoIrpj'] := 0.00;
  FdictValoresCalculadosReceita['Irpj'] := 0.00;
  FdictValoresCalculadosReceita['AdicionalIrpj'] := 0.00;
  FdictValoresCalculadosReceita['DeducaoIrpj'] := 0.00;
  FdictValoresCalculadosReceita['IrpjRecolher'] := 0.00;
end;

procedure TDemonstrativoApuracao.pSetEmpresa(const AstrEmpresa: String);
begin
  FstrEmpresa := AstrEmpresa ;
end;

{ TDeterminacaoEstimativaMensal }

constructor TDeterminacaoEstimativaMensal.Create();
begin
  inherited Create ;
  FstrEmpresa := '' ;
  FintAPPEST := 0 ;

  FcdsDadosCsll  :=  TUniClientDataSet.Create(Nil) ;
  FcdsDadosIrpj  :=  TUniClientDataSet.Create(Nil) ;
  FcdsDadosOpcao :=  TUniClientDataSet.Create(Nil) ;
  FcdsDadosRecolhimento :=  TUniClientDataSet.Create(Nil) ;

  pCarregaFields(FcdsDadosCsll) ;
  pCarregaFields(FcdsDadosIrpj) ;
  pCarregaFields(FcdsDadosRecolhimento) ;
  pCarregaStringFields(FcdsDadosOpcao) ;

end;

destructor TDeterminacaoEstimativaMensal.Destroy;
begin
  FreeAndNil(FcdsDadosCsll) ;
  FreeAndNil(FcdsDadosIrpj) ;
  FreeAndNil(FcdsDadosOpcao) ;
  FreeAndNil(FcdsDadosRecolhimento) ;

  inherited;
end;

function TDeterminacaoEstimativaMensal.fCarregaCfgPlancoRealizado(
  const AiiTipo: TCsllIrpj): string;
var
  LstrNomeCampo: string ;
begin
  LstrNomeCampo := iif(AiiTipo = iiCSLL, 'CFG_CONCSL', 'CFG_CONIRP') ;
  result := fCampoTabela(LstrNomeCampo, 'CFLALU', ['CFG_CODEMP'], [FstrEmpresa]) ;
end;

function TDeterminacaoEstimativaMensal.fCarregaDadosRealizado(
  const AstrExercicio: string; const AiiTipo: TCsllIrpj): TUniClientDataSet;
var
  fQryDados: TUniQuery ;
  LstrValCfg: string ;
  LlstIgnorados: TStringList ;
begin

  LstrValCfg := fCarregaCfgPlancoRealizado(AiiTipo) ;

  fQryDados := fCriaQuery() ;
  try
    fQryDados.Close ;
    fQryDados.SQL.Clear ;
    fQryDados.SQL.Add(' SELECT * FROM ( ') ;
    fQryDados.SQL.Add(' SELECT FALSE AS SELECIONADO, AUTOINCREM, CON_DTALAN, CON_VALLAN, CON_HISTOR, CAST("Débito" AS CHAR(7)) AS TIPO ') ;
    fQryDados.SQL.Add(' FROM LANCON ') ;
    fQryDados.SQL.Add(' WHERE CON_CONDEB = :CONCON ') ;
    fQryDados.SQL.Add('       AND CON_EMPLAN = :EMPLAN ') ;
    fQryDados.SQL.Add('       and EXTRACT(YEAR FROM CON_DTALAN) = :DTALAN ') ;
    fQryDados.SQL.Add(' UNION ALL ') ;
    fQryDados.SQL.Add(' SELECT FALSE AS SELECIONADO, AUTOINCREM, CON_DTALAN, CON_VALLAN, CON_HISTOR, CAST("Crédito" AS CHAR(7)) AS TIPO ') ;
    fQryDados.SQL.Add(' FROM LANCON ') ;
    fQryDados.SQL.Add(' WHERE CON_CONCRE = :CONCON ') ;
    fQryDados.SQL.Add('       AND CON_EMPLAN = :EMPLAN ') ;
    fQryDados.SQL.Add('       and EXTRACT(YEAR FROM CON_DTALAN) = :DTALAN ') ;
    fQryDados.SQL.Add(' ) AS SEL ') ;
    fQryDados.SQL.Add(' ORDER BY CON_DTALAN, AUTOINCREM ') ;
    fQryDados.ParamByName('CONCON').AsString := LstrValCfg ;
    fQryDados.ParamByName('EMPLAN').AsString := FstrEmpresa ;
    fQryDados.ParamByName('DTALAN').AsInteger := strToInt(AstrExercicio) ;
    fQryDados.Open ;

    result := fCriaClientDatset(fQryDados) ;

    ///se tiver registros ignorados deixa selecionado
    LlstIgnorados := fLanconIgnoradoRealizado(AiiTipo) ;
    try
      result.First ;
      while not result.Eof do
      begin
        if LlstIgnorados.IndexOf(result.FieldByName('AUTOINCREM').AsString) <> -1 then
        begin
          result.Edit ;
          result.FieldByName('SELECIONADO').AsInteger := 1 ;
          result.Post ;
        end;
        result.Next ;
      end;

    finally
      FreeAndNil(LlstIgnorados) ;
    end;

  finally
    FreeAndNil(fQryDados) ;
  end;
end;

function TDeterminacaoEstimativaMensal.fIniciaDadosTabela(
  const AstrExercicio: string): integer;
var
  LqryExec: TUniQuery ;
begin
  result := 0 ;

  LqryExec := fCriaQuery() ;
  try
    fStartTransaction() ;
    try

      LqryExec.Close ;
      LqryExec.SQL.Clear ;
      LqryExec.SQL.Add('SELECT AUTOINCREM FROM APPEST WHERE EST_CODEMP = :CODEMP AND EST_EXERCI = :EXERCI ') ;
      LqryExec.ParamByName('CODEMP').AsString := FstrEmpresa ;
      LqryExec.ParamByName('EXERCI').AsInteger := StrToInt(AstrExercicio) ;
      LqryExec.Open ;
      if LqryExec.IsEmpty then
      begin
        LqryExec.Close ;
        LqryExec.SQL.Clear ;
        LqryExec.SQL.Add('INSERT INTO APPEST (EST_CODEMP, EST_EXERCI) VALUES (:CODEMP, :EXERCI) ; ') ;
        LqryExec.ParamByName('CODEMP').AsString := FstrEmpresa ;
        LqryExec.ParamByName('EXERCI').AsInteger := StrToInt(AstrExercicio) ;
        LqryExec.ExecSQL ;

        LqryExec.Close ;
        LqryExec.SQL.Clear ;
        LqryExec.SQL.Add('SELECT LAST_INSERT_ID() ') ;
        LqryExec.Open ;

        result := LqryExec.Fields.Fields[0].AsInteger ;
      end
      else
      begin
        result := LqryExec.Fields.Fields[0].AsInteger ;
      end;
      fCommit() ;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        raise E ;
      End;
    end;
  finally
    FreeAndNil(LqryExec) ;
  end;

end;

function TDeterminacaoEstimativaMensal.fLanconIgnoradoRealizado(
  const AiiTipo: TCsllIrpj): TStringList;
var
  LqryDados: TUniQuery ;
begin
  result := TStringList.Create ;
  result.Sorted := True ;

  LqryDados := fCriaQuery() ;
  try
    LqryDados.Close ;
    LqryDados.SQL.Clear ;
    LqryDados.SQL.Add(' SELECT SIG_LANCON FROM APESIG WHERE SIG_CODEST = :CODEST AND SIG_TIPREG = :TIPREG ') ;
    LqryDados.ParamByName('CODEST').AsInteger := FintAPPEST ;
    LqryDados.ParamByName('TIPREG').AsString := COD_IRPJ_CSLL[AiiTipo] ;
    LqryDados.Open ;
    LqryDados.First ;
    while not LqryDados.Eof do
    begin
      Result.Add(LqryDados.FieldByName('SIG_LANCON').AsString) ;
      LqryDados.Next ;
    end;

  finally
    FreeAndNil(LqryDados) ;
  end;
end;

function TDeterminacaoEstimativaMensal.fManutencaoRecolhimentosRealizados(
  const AstrExercicio: string; const AiiTipo: TCsllIrpj): boolean;
var
  LfrmApuracaoLucroRealIrpjCsllManRecolhimento: TfrmApuracaoLucroRealIrpjCsllManRecolhimento ;
  LcdsDados: TUniClientDataSet ;
begin
  result := False ;
  pCriarFormularios(TfrmApuracaoLucroRealIrpjCsllManRecolhimento, LfrmApuracaoLucroRealIrpjCsllManRecolhimento);
  try
    LcdsDados := fCarregaDadosRealizado(AstrExercicio, AiiTipo) ;
    if LcdsDados.IsEmpty then
    begin
      fMensagem('ATENÇÃO!', 'Nenhum lançamento encontrado!', ['&Ok']);
      exit ;
    end;
    LfrmApuracaoLucroRealIrpjCsllManRecolhimento.dsDados.DataSet := LcdsDados ;
    result := LfrmApuracaoLucroRealIrpjCsllManRecolhimento.ShowModal = mrOK ;
    if result then
    begin
      pGravaLanconIgnoradoRealizado(LcdsDados, AiiTipo) ;
      pCalculaRecolhimentoRealizado(AstrExercicio) ;
    end;
  finally
    pFreeAndNil(LfrmApuracaoLucroRealIrpjCsllManRecolhimento);
    FreeAndNil(LcdsDados) ;
  end;
end;

function TDeterminacaoEstimativaMensal.fValorRecolhimentoRealizado(
  const AstrExercicio, AstrContaContabil: string; const AiiTipo: TCsllIrpj): TDictionary<String, Double>;
var
  LqryDadosLanCon: TUniQuery ;
  LintMeses: integer ;
  LstrMes: string ;
  LfltSaldo: double ;
  LlstIgnorado: TStringList ;
begin
  result := TDictionary<String, Double>.Create();
  if fEmptyStr(AstrContaContabil) then
  begin
    exit ;
  end;

  //inicializa o dict com os meses zerados.
  for LintMeses := 1 to 12 do
  begin
    LstrMes := fStrZero(LintMeses,2) ;
    result.Add(LstrMes, 0.00);
  end;

  LqryDadosLanCon := fCriaQuery ;
  LlstIgnorado := fLanconIgnoradoRealizado(AiiTipo) ;
  try

    //debito
    LqryDadosLanCon.Close ;
    LqryDadosLanCon.SQL.Clear ;
    LqryDadosLanCon.SQL.Add(' SELECT AUTOINCREM, EXTRACT(MONTH FROM CON_DTALAN) AS MES, CON_VALLAN ') ;
    LqryDadosLanCon.SQL.Add(' FROM LANCON ') ;
    LqryDadosLanCon.SQL.Add(' WHERE CON_CONDEB = :CONDEB ') ;
    LqryDadosLanCon.SQL.Add('       AND CON_EMPLAN = :EMPLAN ') ;
    LqryDadosLanCon.SQL.Add('       AND EXTRACT(YEAR FROM CON_DTALAN) = :EXERCI ') ;
    LqryDadosLanCon.ParamByName('CONDEB').AsString := AstrContaContabil ;
    LqryDadosLanCon.ParamByName('EMPLAN').AsString := FstrEmpresa ;
    LqryDadosLanCon.ParamByName('EXERCI').AsInteger := strToInt(AstrExercicio) ;
    LqryDadosLanCon.Open ;
    LqryDadosLanCon.First ;
    while not LqryDadosLanCon.Eof do
    begin
      if LlstIgnorado.IndexOf(LqryDadosLanCon.FieldByName('AUTOINCREM').AsString) <> -1 then
      begin
        LqryDadosLanCon.Next ;
        Continue ;
      end;

      LstrMes := fStrZero(LqryDadosLanCon.FieldByName('MES').AsInteger,2) ;
      Result.Items[LstrMes] := Result.Items[LstrMes] + LqryDadosLanCon.FieldByName('CON_VALLAN').AsFloat ;
      LqryDadosLanCon.Next ;
    end;

    //credito
    LqryDadosLanCon.Close ;
    LqryDadosLanCon.SQL.Clear ;
    LqryDadosLanCon.SQL.Add(' SELECT AUTOINCREM, EXTRACT(MONTH FROM CON_DTALAN) AS MES, CON_VALLAN ') ;
    LqryDadosLanCon.SQL.Add(' FROM LANCON ') ;
    LqryDadosLanCon.SQL.Add(' WHERE CON_CONCRE = :CONCRE ') ;
    LqryDadosLanCon.SQL.Add('       AND CON_EMPLAN = :EMPLAN ') ;
    LqryDadosLanCon.SQL.Add('       AND EXTRACT(YEAR FROM CON_DTALAN) = :EXERCI ') ;
    LqryDadosLanCon.ParamByName('CONCRE').AsString := AstrContaContabil ;
    LqryDadosLanCon.ParamByName('EMPLAN').AsString := FstrEmpresa ;
    LqryDadosLanCon.ParamByName('EXERCI').AsInteger := strToInt(AstrExercicio) ;
    LqryDadosLanCon.Open ;
    LqryDadosLanCon.First ;
    while not LqryDadosLanCon.Eof do
    begin
      if LlstIgnorado.IndexOf(LqryDadosLanCon.FieldByName('AUTOINCREM').AsString) <> -1 then
      begin
        LqryDadosLanCon.Next ;
        Continue ;
      end;

      LstrMes := fStrZero(LqryDadosLanCon.FieldByName('MES').AsInteger,2) ;
      Result.Items[LstrMes] := Result.Items[LstrMes] - LqryDadosLanCon.FieldByName('CON_VALLAN').AsFloat ;
      LqryDadosLanCon.Next ;
    end;

    ///Acumula o saldo mes a mes
    LfltSaldo := 0.00 ;
    for LintMeses := 1 to 12 do
    begin
      LstrMes := fStrZero(LintMeses,2) ;
      LfltSaldo := LfltSaldo + result.Items[LstrMes] ;
      result.Items[LstrMes] := LfltSaldo ;
    end;

  finally
    FreeAndNil(LqryDadosLanCon) ;
    FreeAndNil(LlstIgnorado) ;
  end;

end;

procedure TDeterminacaoEstimativaMensal.pCalculaRecolhimentoRealizado(
  const AstrExercicio: string);
var
  LdictValoresCsll, LdictValoresIrpj: TDictionary<String, Double> ;
  LpairValores: TPair<String, Double> ;
  LstrValCfgCsll, LstrValCfgIrpj: string ;
begin

  try

    LstrValCfgCsll := fCarregaCfgPlancoRealizado(iiCSLL) ;
    LstrValCfgIrpj := fCarregaCfgPlancoRealizado(iiIRPJ) ;

    // csll
    LdictValoresCsll := fValorRecolhimentoRealizado(AstrExercicio, LstrValCfgCsll, iiCSLL) ;
    FcdsDadosCsll.Locate('CODIGO', CODIGO_RECOLHIMENTOS_REALIZADOS_CSLL, [loCaseInsensitive] ) ;
    FcdsDadosCsll.Edit ;
    for LpairValores in LdictValoresCsll do
    begin
      FcdsDadosCsll.FieldByName('EVLR'+LpairValores.Key).AsFloat := LpairValores.Value ;
    end;
    FcdsDadosCsll.Post ;

    // irpj
    LdictValoresIrpj := fValorRecolhimentoRealizado(AstrExercicio, LstrValCfgIrpj, iiIRPJ) ;
    FcdsDadosIrpj.Locate('CODIGO', CODIGO_RECOLHIMENTOS_REALIZADOS_IRPJ, [loCaseInsensitive] ) ;
    FcdsDadosIrpj.Edit ;
    for LpairValores in LdictValoresIrpj do
    begin
      FcdsDadosIrpj.FieldByName('EVLR'+LpairValores.Key).AsFloat := LpairValores.Value ;
    end;
    FcdsDadosIrpj.Post ;

  finally
    FreeAndNil(LdictValoresCsll) ;
    FreeAndNil(LdictValoresIrpj) ;
  end;

end;

procedure TDeterminacaoEstimativaMensal.pCalculaRecolhimentoValorDevido;
var
  LdictRecolhimentoCsll: TDictionary<Integer,Double> ;
  LdictValorDevidoAcumuladoCsll: TDictionary<Integer,Double> ;
  LdictRecolhimentoIrpj: TDictionary<Integer,Double> ;
  LdictValorDevidoAcumuladoIrpj: TDictionary<Integer,Double> ;
begin
  LdictRecolhimentoCsll := TDictionary<Integer,Double>.Create ;
  LdictValorDevidoAcumuladoCsll := TDictionary<Integer,Double>.Create ;
  LdictRecolhimentoIrpj := TDictionary<Integer,Double>.Create ;
  LdictValorDevidoAcumuladoIrpj := TDictionary<Integer,Double>.Create ;
  try

    pCalculaRecolhimentoValorDevidoInterno(LdictRecolhimentoCsll, LdictValorDevidoAcumuladoCsll, iiCSLL) ;
    pCalculaRecolhimentoValorDevidoInterno(LdictRecolhimentoIrpj, LdictValorDevidoAcumuladoIrpj, iiIRPJ) ;
    FcdsDadosRecolhimento.EmptyDataSet ;
    pGravaRecolhimentoValorDevidoCds(LdictRecolhimentoCsll, LdictValorDevidoAcumuladoCsll, iiCSLL) ;
    pGravaRecolhimentoValorDevidoCds(LdictRecolhimentoIrpj, LdictValorDevidoAcumuladoIrpj, iiIRPJ) ;

  finally
    FreeAndNil(LdictRecolhimentoCsll) ;
    FreeAndNil(LdictValorDevidoAcumuladoCsll) ;
    FreeAndNil(LdictRecolhimentoIrpj) ;
    FreeAndNil(LdictValorDevidoAcumuladoIrpj) ;
  end;
end;

procedure TDeterminacaoEstimativaMensal.pCalculaRecolhimentoValorDevidoInterno(
  var AdictRecolhimento,
  AdictValorDevidoAcumulado: TDictionary<Integer, Double>;
  const AiiTipo: TCsllIrpj);
var
  LintCnt: integer ;
  LcdsDados : TUniClientDataSet ;
  LstrMes: String ;
  LstrOpcaoRecolhimento: string ;

  LintBalanceteSuspensaoAcumulado: integer ;
  LintReceitaBrutaMensal: integer ;
  LintRecolhimentoRealizados: integer ;

  LfltValorRecolhidoRealizado: double ;
  LfltValorBalanceteSuspensao: double ;
begin
  //inicializa os dicts
  for LintCnt := 1 to 12 do
  begin
    AdictRecolhimento.Add(LintCnt, 0.00);
    AdictValorDevidoAcumulado.Add(LintCnt, 0.00);
  end;

  LcdsDados := TUniClientDataSet.Create(Nil) ;
  try
    if AiiTipo = iiCSLL then
    begin
      LcdsDados.Data := FcdsDadosCsll.Data ;
      LintBalanceteSuspensaoAcumulado := CODIGO_BALANCETE_SUSPENSAO_ACUMULADO_CSLL ;
      LintReceitaBrutaMensal := CODIGO_RECEITA_BRUTA_MENSAL_CSLL ;
      LintRecolhimentoRealizados := CODIGO_RECOLHIMENTOS_REALIZADOS_CSLL ;
    end
    else //IRPJ
    begin
      LcdsDados.Data := FcdsDadosIrpj.Data ;
      LintBalanceteSuspensaoAcumulado := CODIGO_BALANCETE_SUSPENSAO_ACUMULADO_IRPJ ;
      LintReceitaBrutaMensal := CODIGO_RECEITA_BRUTA_MENSAL_IRPJ ;
      LintRecolhimentoRealizados := CODIGO_RECOLHIMENTOS_REALIZADOS_IRPJ ;
    end;

    LcdsDados.DisableControls ;
    try
      for LintCnt := 1 to 12 do
      begin
        LstrMes := fStrZero(LintCnt, 2) ;
        LstrOpcaoRecolhimento := FcdsDadosOpcao.FieldByName('EVLR'+LstrMes).AsString ;
        if LstrOpcaoRecolhimento = DESCRI_RECEITA then
        begin
          ///recolhimento
          LcdsDados.Locate('CODIGO', LintReceitaBrutaMensal, [loCaseInsensitive] ) ;
          AdictRecolhimento.Items[LintCnt] := LcdsDados.FieldByName('EVLR'+LstrMes).AsFloat ;
        end
        else ///balancete
        begin
          ///recolhimento
          LcdsDados.Locate('CODIGO', LintBalanceteSuspensaoAcumulado, [loCaseInsensitive] ) ;
          LfltValorBalanceteSuspensao := LcdsDados.FieldByName('EVLR'+LstrMes).AsFloat ;

          if LintCnt > 1 then
          begin
            LfltValorRecolhidoRealizado := AdictRecolhimento.Items[LintCnt-1] ;
          end
          else
          begin
            LfltValorRecolhidoRealizado := 0.00 ;
          end;

          if fFormataFloat(LfltValorBalanceteSuspensao-LfltValorRecolhidoRealizado,2) < 0  then
          begin
            AdictRecolhimento.Items[LintCnt] := 0.00 ;
          end
          else
          begin
            LcdsDados.Locate('CODIGO', LintRecolhimentoRealizados, [loCaseInsensitive] ) ;
            LfltValorRecolhidoRealizado := LcdsDados.FieldByName('EVLR'+LstrMes).AsFloat ;
            AdictRecolhimento.Items[LintCnt] := fFormataFloat(LfltValorBalanceteSuspensao - LfltValorRecolhidoRealizado, 2) ;
          end;
        end;
        //// valor devido
        LcdsDados.Locate('CODIGO', LintBalanceteSuspensaoAcumulado, [loCaseInsensitive] ) ;
        LfltValorBalanceteSuspensao := LcdsDados.FieldByName('EVLR'+LstrMes).AsFloat ;
        LcdsDados.Locate('CODIGO', LintRecolhimentoRealizados, [loCaseInsensitive] ) ;
        LfltValorRecolhidoRealizado := LcdsDados.FieldByName('EVLR'+LstrMes).AsFloat ;
        AdictValorDevidoAcumulado.Items[LintCnt] := fFormataFloat(LfltValorBalanceteSuspensao - (LfltValorRecolhidoRealizado + AdictRecolhimento.Items[LintCnt]), 2) ;
      end;
    finally
      LcdsDados.EnableControls ;
    end;

  finally
    FreeAndNil(LcdsDados) ;
  end;

end;

procedure TDeterminacaoEstimativaMensal.pCalculaValorApurado(const AstrExercicio: string);
var
  LqryDadosDemonstrativo: TuniQuery ;
  LdictRCCSLL, LdictRCIRPJ: TDictionary<string, double> ;
  LstrChaveDict: string ;
  LpairVl: TPair<string, double>;
begin
  LqryDadosDemonstrativo := fCriaQuery() ;
  LdictRCCSLL := TDictionary<string, double>.Create ;
  LdictRCIRPJ := TDictionary<string, double>.Create ;
  try
    LqryDadosDemonstrativo.Close ;
    LqryDadosDemonstrativo.SQL.Clear ;
    LqryDadosDemonstrativo.SQL.Add(' SELECT DET_PERAPU, DET_TIPREG, DET_RCCSLL, DET_RCIRPJ ') ;
    LqryDadosDemonstrativo.SQL.Add(' FROM APDDET INNER JOIN APDEAP ON APDDET.DET_CODEAP = APDEAP.AUTOINCREM ') ;
    LqryDadosDemonstrativo.SQL.Add(' WHERE APDEAP.EAP_CODEMP = :CODEMP  ') ;
    LqryDadosDemonstrativo.SQL.Add('       AND APDEAP.EAP_EXERCI = :EXERCI ') ;
    LqryDadosDemonstrativo.SQL.Add(' ORDER BY DET_PERAPU, DET_TIPREG ') ;
    LqryDadosDemonstrativo.ParamByName('CODEMP').AsString := FstrEmpresa ;
    LqryDadosDemonstrativo.ParamByName('EXERCI').AsInteger := strtoint(AstrExercicio) ;
    LqryDadosDemonstrativo.Open ;
    LqryDadosDemonstrativo.First ;

    while not LqryDadosDemonstrativo.Eof do
    begin
      LstrChaveDict := fStrZero(LqryDadosDemonstrativo.FieldByName('DET_PERAPU').AsString,2)+LqryDadosDemonstrativo.FieldByName('DET_TIPREG').AsString ;
      LdictRCCSLL.Add(LstrChaveDict,LqryDadosDemonstrativo.FieldByName('DET_RCCSLL').AsFloat) ;
      LdictRCIRPJ.Add(LstrChaveDict,LqryDadosDemonstrativo.FieldByName('DET_RCIRPJ').AsFloat) ;
      LqryDadosDemonstrativo.Next ;
    end;


    FcdsDadosCsll.DisableControls ;
    FcdsDadosIrpj.DisableControls ;
    try
      FcdsDadosCsll.Locate('CODIGO', CODIGO_BALANCETE_SUSPENSAO_ACUMULADO_CSLL, [loCaseInsensitive] ) ;
      FcdsDadosCsll.Edit ;
      for LpairVl in LdictRCCSLL do
      begin
        if copy(LpairVl.Key,3,1) = COD_DEMONSTRATIVO_APURACAO[tdaBalancete] then
        begin
          FcdsDadosCsll.FieldByName('EVLR'+copy(LpairVl.Key,1,2)).AsFloat := LpairVl.Value ;
        end;
      end;
      FcdsDadosCsll.Post ;

      FcdsDadosCsll.Locate('CODIGO', CODIGO_RECEITA_BRUTA_MENSAL_CSLL, [loCaseInsensitive] ) ;
      FcdsDadosCsll.Edit ;
      for LpairVl in LdictRCCSLL do
      begin
        if copy(LpairVl.Key,3,1) = COD_DEMONSTRATIVO_APURACAO[tdaReceita] then
        begin
          FcdsDadosCsll.FieldByName('EVLR'+copy(LpairVl.Key,1,2)).AsFloat := LpairVl.Value ;
        end;
      end;
      FcdsDadosCsll.Post ;

      FcdsDadosIrpj.Locate('CODIGO', CODIGO_BALANCETE_SUSPENSAO_ACUMULADO_CSLL, [loCaseInsensitive] ) ;
      FcdsDadosIrpj.Edit ;
      for LpairVl in LdictRCIRPJ do
      begin
        if copy(LpairVl.Key,3,1) = COD_DEMONSTRATIVO_APURACAO[tdaBalancete] then
        begin
          FcdsDadosIrpj.FieldByName('EVLR'+copy(LpairVl.Key,1,2)).AsFloat := LpairVl.Value ;
        end;
      end;
      FcdsDadosIrpj.Post ;

      FcdsDadosIrpj.Locate('CODIGO', CODIGO_RECEITA_BRUTA_MENSAL_CSLL, [loCaseInsensitive] ) ;
      FcdsDadosIrpj.Edit ;
      for LpairVl in LdictRCIRPJ do
      begin
        if copy(LpairVl.Key,3,1) = COD_DEMONSTRATIVO_APURACAO[tdaReceita] then
        begin
          FcdsDadosIrpj.FieldByName('EVLR'+copy(LpairVl.Key,1,2)).AsFloat := LpairVl.Value ;
        end;
      end;
      FcdsDadosIrpj.Post ;

    finally
      FcdsDadosCsll.EnableControls ;
      FcdsDadosIrpj.EnableControls ;
    end;

  finally
    FreeAndNil(LqryDadosDemonstrativo) ;
    FreeAndNil(LdictRCCSLL) ;
    FreeAndNil(LdictRCIRPJ) ;
  end;
end;

procedure TDeterminacaoEstimativaMensal.pCalculaValores(
  const AecEncerramento: TEncerramentoContabil; const AstrExercicio: string);
begin
  // limpa os dados
  FcdsDadosCsll.EmptyDataSet ;
  FcdsDadosIrpj.EmptyDataSet ;
  FcdsDadosOpcao.EmptyDataSet ;
  FcdsDadosRecolhimento.EmptyDataSet ;

  if AecEncerramento = ecTrimestral then
  begin
    exit ;
  end;

  FintAPPEST := fIniciaDadosTabela(AstrExercicio) ;

  // inicializa os dados
  FcdsDadosCsll.Append ;
  FcdsDadosCsll.FieldByName('DESCRI').AsString := DESCRI_BALANCETE_SUSPENSAO_ACUMULADO_CSLL ;
  FcdsDadosCsll.FieldByName('CODIGO').AsInteger := CODIGO_BALANCETE_SUSPENSAO_ACUMULADO_CSLL ;
  FcdsDadosCsll.Post ;

  FcdsDadosCsll.Append ;
  FcdsDadosCsll.FieldByName('DESCRI').AsString := DESCRI_RECEITA_BRUTA_MENSAL_CSLL ;
  FcdsDadosCsll.FieldByName('CODIGO').AsInteger := CODIGO_RECEITA_BRUTA_MENSAL_CSLL ;
  FcdsDadosCsll.Post ;

  FcdsDadosCsll.Append ;
  FcdsDadosCsll.FieldByName('DESCRI').AsString := DESCRI_RECOLHIMENTOS_REALIZADOS_CSLL ;
  FcdsDadosCsll.FieldByName('CODIGO').AsInteger := CODIGO_RECOLHIMENTOS_REALIZADOS_CSLL ;
  FcdsDadosCsll.Post ;

  FcdsDadosIrpj.Append ;
  FcdsDadosIrpj.FieldByName('DESCRI').AsString := DESCRI_BALANCETE_SUSPENSAO_ACUMULADO_IRPJ ;
  FcdsDadosIrpj.FieldByName('CODIGO').AsInteger := CODIGO_BALANCETE_SUSPENSAO_ACUMULADO_IRPJ ;
  FcdsDadosIrpj.Post ;

  FcdsDadosIrpj.Append ;
  FcdsDadosIrpj.FieldByName('DESCRI').AsString := DESCRI_RECEITA_BRUTA_MENSAL_IRPJ ;
  FcdsDadosIrpj.FieldByName('CODIGO').AsInteger := CODIGO_RECEITA_BRUTA_MENSAL_IRPJ ;
  FcdsDadosIrpj.Post ;

  FcdsDadosIrpj.Append ;
  FcdsDadosIrpj.FieldByName('DESCRI').AsString := DESCRI_RECOLHIMENTOS_REALIZADOS_IRPJ ;
  FcdsDadosIrpj.FieldByName('CODIGO').AsInteger := CODIGO_RECOLHIMENTOS_REALIZADOS_IRPJ ;
  FcdsDadosIrpj.Post ;

  // processa os dados.
  pCalculaValorApurado(AstrExercicio) ;
  pCalculaRecolhimentoRealizado(AstrExercicio) ;
  pCarregaOpcaoRecolhimentoCDS ;
  pCalculaRecolhimentoValorDevido ;
end;

procedure TDeterminacaoEstimativaMensal.pCarregaFields(
  var AcdsDados: TUniClientDataSet);
begin
  AcdsDados.FieldDefs.Add('CODIGO', ftInteger, 0, False) ;
  AcdsDados.FieldDefs.Add('DESCRI', ftString, 45, False) ;
  AcdsDados.FieldDefs.Add('EVLR01', ftFloat, 0, False) ;
  AcdsDados.FieldDefs.Add('EVLR02', ftFloat, 0, False) ;
  AcdsDados.FieldDefs.Add('EVLR03', ftFloat, 0, False) ;
  AcdsDados.FieldDefs.Add('EVLR04', ftFloat, 0, False) ;
  AcdsDados.FieldDefs.Add('EVLR05', ftFloat, 0, False) ;
  AcdsDados.FieldDefs.Add('EVLR06', ftFloat, 0, False) ;
  AcdsDados.FieldDefs.Add('EVLR07', ftFloat, 0, False) ;
  AcdsDados.FieldDefs.Add('EVLR08', ftFloat, 0, False) ;
  AcdsDados.FieldDefs.Add('EVLR09', ftFloat, 0, False) ;
  AcdsDados.FieldDefs.Add('EVLR10', ftFloat, 0, False) ;
  AcdsDados.FieldDefs.Add('EVLR11', ftFloat, 0, False) ;
  AcdsDados.FieldDefs.Add('EVLR12', ftFloat, 0, False) ;
  AcdsDados.CreateDataSet ;
  AcdsDados.Open ;
end;

procedure TDeterminacaoEstimativaMensal.pCarregaOpcaoRecolhimentoCDS;
var
  LqryDados: TUniQuery ;
begin
  pIniciaOpcaoRecolhimento ;
  FcdsDadosOpcao.EmptyDataSet ;

  LqryDados := fCriaQuery() ;
  try
    LqryDados.Close ;
    LqryDados.SQL.Clear ;
    LqryDados.SQL.Add('SELECT PRE_PERAPU, PRE_TPCONF FROM APOPRE WHERE PRE_CODEST = :CODEST') ;
    LqryDados.ParamByName('CODEST').AsInteger := FintAPPEST ;
    LqryDados.Open ;
    LqryDados.First ;
    FcdsDadosOpcao.Append ;
    FcdsDadosOpcao.FieldByName('DESCRI').AsString := DESCRI_OPCAO_RECOLHIMENTO ;
    while not LqryDados.Eof do
    begin
      FcdsDadosOpcao.FieldByName('EVLR' + fStrZero(LqryDados.FieldByName('PRE_PERAPU').AsString,2)).AsString := LqryDados.FieldByName('PRE_TPCONF').AsString ;
      LqryDados.Next ;
    end;
    FcdsDadosOpcao.Post ;
  finally
    FreeAndNil(LqryDados) ;
  end;

end;

procedure TDeterminacaoEstimativaMensal.pCarregaStringFields(
  var AcdsDados: TUniClientDataSet);
begin
  AcdsDados.FieldDefs.Add('CODIGO', ftInteger, 0, False) ;
  AcdsDados.FieldDefs.Add('DESCRI', ftString, 45, False) ;
  AcdsDados.FieldDefs.Add('EVLR01', ftString, 15, False) ;
  AcdsDados.FieldDefs.Add('EVLR02', ftString, 15, False) ;
  AcdsDados.FieldDefs.Add('EVLR03', ftString, 15, False) ;
  AcdsDados.FieldDefs.Add('EVLR04', ftString, 15, False) ;
  AcdsDados.FieldDefs.Add('EVLR05', ftString, 15, False) ;
  AcdsDados.FieldDefs.Add('EVLR06', ftString, 15, False) ;
  AcdsDados.FieldDefs.Add('EVLR07', ftString, 15, False) ;
  AcdsDados.FieldDefs.Add('EVLR08', ftString, 15, False) ;
  AcdsDados.FieldDefs.Add('EVLR09', ftString, 15, False) ;
  AcdsDados.FieldDefs.Add('EVLR10', ftString, 15, False) ;
  AcdsDados.FieldDefs.Add('EVLR11', ftString, 15, False) ;
  AcdsDados.FieldDefs.Add('EVLR12', ftString, 15, False) ;
  AcdsDados.CreateDataSet ;
  AcdsDados.Open ;
end;

procedure TDeterminacaoEstimativaMensal.pGravaApuracao(
  const AecEncerramento: TEncerramentoContabil);
var
  LqryExec: TUniQuery ;
  LcdsDados: TUniClientDataSet ;
  LintMes: integer ;
  LstrMes: string ;
begin
  LqryExec  := fCriaQuery() ;
  LcdsDados := TUniClientDataSet.Create(Nil) ;
  try
    fStartTransaction ;
    try
      LqryExec.Close ;
      LqryExec.SQL.Clear ;
      LqryExec.SQL.Add('DELETE FROM APVRDV WHERE RDV_CODEST = :CODEST ;') ;
      LqryExec.ParamByName('CODEST').AsInteger := FintAPPEST ;
      LqryExec.ExecSQL ;

      if AecEncerramento <> ecTrimestral then
      begin
        FcdsDadosRecolhimento.First ;
        while not FcdsDadosRecolhimento.Eof do
        begin
          for LintMes := 1 to 12 do
          begin
            LstrMes := fStrZero(LintMes, 2) ;

            LqryExec.Close ;
            LqryExec.SQL.Clear ;
            LqryExec.SQL.Add('INSERT INTO APVRDV (RDV_CODEST, RDV_PERAPU, RDV_TIPREG, RDV_DESCRI, RDV_VLRAPU) VALUES (:CODEST, :PERAPU, :TIPREG, :DESCRI, :VLRAPU) ;') ;
            LqryExec.ParamByName('CODEST').AsInteger := FintAPPEST ;
            LqryExec.ParamByName('PERAPU').AsInteger := LintMes ;
            LqryExec.ParamByName('TIPREG').AsString := iif(FcdsDadosRecolhimento.FieldByName('CODIGO').AsInteger in [CODIGO_RECOLHIMENTO_SUSPENSAO_MES_CSLL, CODIGO_VALOR_DEVIDO_ACUMULADO_CSLL], COD_IRPJ_CSLL[iiCSLL], COD_IRPJ_CSLL[iiIRPJ]) ;
            LqryExec.ParamByName('DESCRI').AsString := FcdsDadosRecolhimento.FieldByName('DESCRI').AsString ;
            LqryExec.ParamByName('VLRAPU').AsFloat := FcdsDadosRecolhimento.FieldByName('EVLR'+LstrMes).AsFloat ;
            LqryExec.ExecSQL ;

          end;
          FcdsDadosRecolhimento.Next ;
        end;
      end;

      fCommit ;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        raise E ;
      End;
    end;

  finally
    FreeAndNil(LqryExec) ;
    FreeAndNil(LcdsDados) ;
  end;
end;

procedure TDeterminacaoEstimativaMensal.pGravaLanconIgnoradoRealizado(
  const AcdsDados: TUniClientDataSet; const AiiTipo: TCsllIrpj);
var
  LlstDados: TStringList ;
  LqryExec: TUniQuery ;
  LintCnt: integer ;
begin
  AcdsDados.DisableControls ;
  LlstDados := TStringList.Create ;
  LqryExec := fCriaQuery() ;
  try
    AcdsDados.First ;
    while not AcdsDados.Eof do
    begin
      if AcdsDados.FieldByName('SELECIONADO').AsInteger = 1 then
      begin
        LlstDados.Add(AcdsDados.FieldByName('AUTOINCREM').AsString) ;
      end;
      AcdsDados.Next ;
    end;

    fStartTransaction ;
    try
      /// exclui para relançar
      LqryExec.Close ;
      LqryExec.SQL.Clear ;
      LqryExec.SQL.Add('DELETE FROM APESIG WHERE SIG_CODEST = :CODEST AND SIG_TIPREG = :TIPREG ;') ;
      LqryExec.ParamByName('CODEST').AsInteger := FintAPPEST ;
      LqryExec.ParamByName('TIPREG').AsString := COD_IRPJ_CSLL[AiiTipo] ;
      LqryExec.ExecSQL ;

      for LintCnt := 0 to LlstDados.Count-1 do
      begin
        LqryExec.Close ;
        LqryExec.SQL.Clear ;
        LqryExec.SQL.Add('INSERT INTO APESIG (SIG_CODEST, SIG_TIPREG, SIG_LANCON) VALUES (:CODEST, :TIPREG, :LANCON);') ;
        LqryExec.ParamByName('CODEST').AsInteger := FintAPPEST ;
        LqryExec.ParamByName('TIPREG').AsString := COD_IRPJ_CSLL[AiiTipo] ;
        LqryExec.ParamByName('LANCON').AsString := LlstDados.Strings[LintCnt] ;
        LqryExec.ExecSQL ;
      end;
      fCommit ;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        raise E ;
      End;
    end;

  finally
    AcdsDados.EnableControls ;
    FreeAndNil(LlstDados) ;
    FreeAndNil(LqryExec) ;
  end;
end;

procedure TDeterminacaoEstimativaMensal.pGravaOpcaoRecolhimentoEscolhida(
  const AstrOpcao: string; const AintMes: integer);
var
  LqryExec: TUniQuery ;
begin
  LqryExec := fCriaQuery() ;
  try
    fStartTransaction() ;
    try
      LqryExec.Close ;
      LqryExec.SQL.Clear ;
      LqryExec.SQL.Add('UPDATE APOPRE SET PRE_TPCONF = :TPCONF WHERE PRE_CODEST = :CODEST AND PRE_PERAPU = :PERAPU ; ') ;
      LqryExec.ParamByName('CODEST').AsInteger := FintAPPEST ;
      LqryExec.ParamByName('PERAPU').AsInteger := AintMes ;
      LqryExec.ParamByName('TPCONF').AsString := AstrOpcao ;
      LqryExec.ExecSQL ;
      fCommit() ;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        raise E ;
      End;
    end;

    pCalculaRecolhimentoValorDevido ;

  finally
    FreeAndNil(LqryExec) ;
  end;
end;

procedure TDeterminacaoEstimativaMensal.pGravaRecolhimentoValorDevidoCds(
  const AdictRecolhimento,
  AdictValorDevidoAcumulado: TDictionary<Integer, Double>;
  const AiiTipo: TCsllIrpj);
var
  LpairApuracao: TPair<Integer, Double> ;
  LintCodigoRecolhimento: Integer ;
  LstrDescriRecolhimento: String ;
  LintCodigoValorDevido: Integer ;
  LstrDescriValorDevido: String ;
begin

  if AiiTipo = iiCSLL then
  begin
    LintCodigoRecolhimento := CODIGO_RECOLHIMENTO_SUSPENSAO_MES_CSLL ;
    LstrDescriRecolhimento := DESCRI_RECOLHIMENTO_SUSPENSAO_MES_CSLL ;
    LintCodigoValorDevido := CODIGO_VALOR_DEVIDO_ACUMULADO_CSLL ;
    LstrDescriValorDevido := DESCRI_VALOR_DEVIDO_ACUMULADO_CSLL ;
  end
  else
  begin
    LintCodigoRecolhimento := CODIGO_RECOLHIMENTO_SUSPENSAO_MES_IRPJ ;
    LstrDescriRecolhimento := DESCRI_RECOLHIMENTO_SUSPENSAO_MES_IRPJ ;
    LintCodigoValorDevido := CODIGO_VALOR_DEVIDO_ACUMULADO_IRPJ ;
    LstrDescriValorDevido := DESCRI_VALOR_DEVIDO_ACUMULADO_IRPJ ;
  end;

  FcdsDadosRecolhimento.Append ;
  FcdsDadosRecolhimento.FieldByName('CODIGO').AsInteger := LintCodigoRecolhimento ;
  FcdsDadosRecolhimento.FieldByName('DESCRI').AsString := LstrDescriRecolhimento ;
  for LpairApuracao in AdictRecolhimento do
  begin
    FcdsDadosRecolhimento.FieldByName('EVLR'+fStrZero(LpairApuracao.Key,2)).AsFloat := LpairApuracao.Value ;
  end;
  FcdsDadosRecolhimento.Post ;

  FcdsDadosRecolhimento.Append ;
  FcdsDadosRecolhimento.FieldByName('CODIGO').AsInteger := LintCodigoValorDevido ;
  FcdsDadosRecolhimento.FieldByName('DESCRI').AsString := LstrDescriValorDevido ;
  for LpairApuracao in AdictValorDevidoAcumulado do
  begin
    FcdsDadosRecolhimento.FieldByName('EVLR'+fStrZero(LpairApuracao.Key,2)).AsFloat := LpairApuracao.Value ;
  end;
  FcdsDadosRecolhimento.Post ;
end;

procedure TDeterminacaoEstimativaMensal.pIniciaOpcaoRecolhimento;
var
  LqryExec: TUniQuery ;
  LintMeses: Integer ;
begin
  LqryExec := fCriaQuery() ;
  try

    LqryExec.Close ;
    LqryExec.SQL.Clear ;
    LqryExec.SQL.Add('SELECT AUTOINCREM FROM APOPRE WHERE PRE_CODEST = :CODEST ') ;
    LqryExec.ParamByName('CODEST').AsInteger := FintAPPEST ;
    LqryExec.Open ;
    if LqryExec.IsEmpty then
    begin
      fStartTransaction() ;
      try
        for LintMeses := 1 to 12 do
        begin
          LqryExec.Close ;
          LqryExec.SQL.Clear ;
          LqryExec.SQL.Add('INSERT INTO APOPRE (PRE_CODEST, PRE_PERAPU, PRE_TPCONF) VALUES (:CODEST, :PERAPU, :TPCONF) ; ') ;
          LqryExec.ParamByName('CODEST').AsInteger := FintAPPEST ;
          LqryExec.ParamByName('PERAPU').AsInteger := LintMeses ;
          LqryExec.ParamByName('TPCONF').AsString := DESCRI_BALANCETE ; // Default
          LqryExec.ExecSQL ;
        end;
        fCommit() ;
      Except
        On E: Exception Do
        Begin
          fRollBack;
          raise E ;
        End;
      end;
    end;

  finally
    FreeAndNil(LqryExec) ;
  end;

end;

procedure TDeterminacaoEstimativaMensal.pSetEmpresa(const AstrEmpresa: String);
begin
  FstrEmpresa := AstrEmpresa ;
end;

{ TApuracaoReceitasAcrecimos }

constructor TApuracaoReceitasAcrecimos.Create();
begin
  inherited Create ;
  FstrEmpresa := '' ;

  FcdsApuRecAcrCsll := TUniClientDataSet.Create(Nil) ;
  FcdsApuRecAcrIrpj := TUniClientDataSet.Create(Nil) ;

  pCreateCdsApuRecAcr(FcdsApuRecAcrCsll) ;
  pCreateCdsApuRecAcr(FcdsApuRecAcrIrpj) ;

end;

destructor TApuracaoReceitasAcrecimos.Destroy;
begin
  FreeAndNil(FcdsApuRecAcrCsll) ;
  FreeAndNil(FcdsApuRecAcrIrpj) ;
  inherited;
end;

function TApuracaoReceitasAcrecimos.fCarregaDados(
  const AintExercicio: integer): boolean;
var
  LqryConsulta: TUniQuery ;
  LcdsDados: TUniClientDataSet ;
begin
  LqryConsulta := fCriaQuery ;
  FcdsApuRecAcrCsll.AfterPost := Nil ;
  FcdsApuRecAcrIrpj.AfterPost := Nil ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add('SELECT AUTOINCREM, ADR_DESCRI, ADR_PERCEN, ADR_TIPIMP FROM ADREAC ORDER BY  ADR_TIPIMP, AUTOINCREM;') ;
    LqryConsulta.Open ;
    LqryConsulta.First ;
    while not LqryConsulta.Eof do
    begin
      if LqryConsulta.FieldByName('ADR_TIPIMP').AsString = COD_IRPJ_CSLL[iiIRPJ] then
      begin
        FcdsApuRecAcrIrpj.Append ;
        FcdsApuRecAcrIrpj.FieldByName('CODIGO').AsInteger := LqryConsulta.FieldByName('AUTOINCREM').AsInteger ;
        FcdsApuRecAcrIrpj.FieldByName('DESCRI').AsString := LqryConsulta.FieldByName('ADR_DESCRI').AsString ;
        FcdsApuRecAcrIrpj.FieldByName('PERCEN').AsString := LqryConsulta.FieldByName('ADR_PERCEN').AsString ;
        FcdsApuRecAcrIrpj.Post ;
      end;
      if LqryConsulta.FieldByName('ADR_TIPIMP').AsString = COD_IRPJ_CSLL[iiCSLL] then
      begin
        FcdsApuRecAcrCsll.Append ;
        FcdsApuRecAcrCsll.FieldByName('CODIGO').AsInteger := LqryConsulta.FieldByName('AUTOINCREM').AsInteger ;
        FcdsApuRecAcrCsll.FieldByName('DESCRI').AsString := LqryConsulta.FieldByName('ADR_DESCRI').AsString ;
        FcdsApuRecAcrCsll.FieldByName('PERCEN').AsString := LqryConsulta.FieldByName('ADR_PERCEN').AsString ;
        FcdsApuRecAcrCsll.Post ;
      end;
      LqryConsulta.Next ;
    end;
    ////Linhas de apuração
    FcdsApuRecAcrIrpj.Append ;
    FcdsApuRecAcrIrpj.FieldByName('CODIGO').AsInteger := COD_TOTAL_RECEITA_BRUTA ;
    FcdsApuRecAcrIrpj.FieldByName('DESCRI').AsString := DES_TOTAL_RECEITA_BRUTA ;
    FcdsApuRecAcrIrpj.Post ;

    FcdsApuRecAcrIrpj.Append ;
    FcdsApuRecAcrIrpj.FieldByName('CODIGO').AsInteger := COD_BASE_CALCULO ;
    FcdsApuRecAcrIrpj.FieldByName('DESCRI').AsString := DES_BASE_CALCULO ;
    FcdsApuRecAcrIrpj.Post ;

    FcdsApuRecAcrCsll.Append ;
    FcdsApuRecAcrCsll.FieldByName('CODIGO').AsInteger := COD_TOTAL_RECEITA_BRUTA ;
    FcdsApuRecAcrCsll.FieldByName('DESCRI').AsString := DES_TOTAL_RECEITA_BRUTA ;
    FcdsApuRecAcrCsll.Post ;

    FcdsApuRecAcrCsll.Append ;
    FcdsApuRecAcrCsll.FieldByName('CODIGO').AsInteger := COD_BASE_CALCULO ;
    FcdsApuRecAcrCsll.FieldByName('DESCRI').AsString := DES_BASE_CALCULO ;
    FcdsApuRecAcrCsll.Post ;

    ////carrega base de calculo
    LcdsDados := fCarregaDadosInformados(AintExercicio) ;
    pSincronizaDadosApuRecAcr(FcdsApuRecAcrCsll, LcdsDados) ;
    pSincronizaDadosApuRecAcr(FcdsApuRecAcrIrpj, LcdsDados) ;

    FcdsApuRecAcrCsll.First ;
    FcdsApuRecAcrIrpj.First ;
  finally
    FcdsApuRecAcrCsll.AfterPost := FevtAfterPostCsll ;
    FcdsApuRecAcrIrpj.AfterPost := FevtAfterPostIrpj ;
    FreeAndNil(LqryConsulta) ;
  end;

  result := True ;
end;

function TApuracaoReceitasAcrecimos.fCarregaDadosInformados(
  const AintExercicio: integer): TUniClientDataSet;
var
  LqryDados: TUniQuery ;
begin
  LqryDados := fCriaQuery() ;
  try
    LqryDados.Close ;
    LqryDados.SQL.Clear ;
    LqryDados.SQL.Add(' SELECT APDREA.APD_CODADR, APDMRA.APM_MESAPU, APDMRA.APM_VALBAS ') ;
    LqryDados.SQL.Add('   FROM APREAC  ') ;
    LqryDados.SQL.Add('        INNER JOIN APDREA ON APREAC.AUTOINCREM = APDREA.APD_CODAPR ') ;
    LqryDados.SQL.Add('        INNER JOIN APDMRA ON APDREA.AUTOINCREM = APDMRA.APM_CODAPD ') ;
    LqryDados.SQL.Add(' WHERE APREAC.APR_CODEMP = :CODEMP ') ;
    LqryDados.SQL.Add('       AND APREAC.ARR_EXERCI = :EXERCI ') ;
    LqryDados.ParamByName('CODEMP').AsString := FstrEmpresa ;
    LqryDados.ParamByName('EXERCI').AsInteger := AintExercicio ;
    LqryDados.Open ;

    result := fCriaClientDatset(LqryDados) ;
    result.IndexFieldNames := 'APD_CODADR;APM_MESAPU'   ;
  finally
    FreeAndNil(LqryDados) ;
  end;
end;

function TApuracaoReceitasAcrecimos.fGravaDados(
  const AintExercicio: integer; ApgbProgresso: TcxProgressBar): boolean;
var
  LqryAPREAC: TUniQuery ;
  LqryExec: TUniQuery ;
  LintCodigoAPREAC: integer ;
  LintPassos: integer ;
  LintPassosTotal: integer ;
begin
  LintPassosTotal := 4 ;
  LintPassos := 0 ;
  ApgbProgresso.Properties.Max := LintPassosTotal ;

  fStartTransaction;
  try
    LqryAPREAC := fCriaQuery() ;
    LqryExec := fCriaQuery() ;
    try
      LqryAPREAC.Close ;
      LqryAPREAC.SQL.Clear ;
      LqryAPREAC.SQL.Add('SELECT AUTOINCREM FROM APREAC WHERE APR_CODEMP = :CODEMP AND ARR_EXERCI = :EXERCI ') ;
      LqryAPREAC.ParamByName('CODEMP').AsString := FstrEmpresa ;
      LqryAPREAC.ParamByName('EXERCI').AsInteger := AintExercicio ;
      LqryAPREAC.Open ;
      if LqryAPREAC.IsEmpty then
      begin
        LqryExec.Close ;
        LqryExec.SQL.Clear ;
        LqryExec.SQL.Add('INSERT INTO APREAC (APR_CODEMP, ARR_EXERCI) VALUES (:CODEMP, :EXERCI) ;') ;
        LqryExec.ParamByName('CODEMP').AsString := FstrEmpresa ;
        LqryExec.ParamByName('EXERCI').AsInteger := AintExercicio ;
        LqryExec.ExecSQL ;

        LqryAPREAC.Close ;
        LqryAPREAC.SQL.Clear ;
        LqryAPREAC.SQL.Add('SELECT LAST_INSERT_ID() ') ;
        LqryAPREAC.Open ;
      end;
      LintCodigoAPREAC := LqryAPREAC.Fields.Fields[0].AsInteger ;

      inc(LintPassos) ;
      ApgbProgresso.Position := LintPassos;
      Application.ProcessMessages;

      ///limpa a estrutura para relançar.
      LqryExec.Close ;
      LqryExec.SQL.Clear ;
      LqryExec.SQL.Add('DELETE FROM APDREA WHERE APD_CODAPR = :CODAPR') ;
      LqryExec.ParamByName('CODAPR').AsInteger := LintCodigoAPREAC ;
      LqryExec.ExecSQL ;

      inc(LintPassos) ;
      ApgbProgresso.Position := LintPassos;
      Application.ProcessMessages;

      fGravaDadosDetalhe(FcdsApuRecAcrCsll, LintCodigoAPREAC) ;

      inc(LintPassos) ;
      ApgbProgresso.Position := LintPassos;
      Application.ProcessMessages;

      fGravaDadosDetalhe(FcdsApuRecAcrIrpj, LintCodigoAPREAC) ;

      inc(LintPassos) ;
      ApgbProgresso.Position := LintPassos;
      Application.ProcessMessages;

    finally
      FreeAndNil(LqryAPREAC) ;
      FreeAndNil(LqryExec) ;
    end;
    fCommit;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      raise E ;
    End;
  end;
  result := True ;
end;

function TApuracaoReceitasAcrecimos.fGravaDadosDetalhe(
  const AcdsApuRecAcr: TUniClientDataSet;
  const AintCodigoAPREAC: integer): boolean;
var
  LqryExec: TUniQuery ;
  LintCodigoAPDREA: Integer ;
  LintMes: integer ;
  LstrMes, LstrFieldName: string ;
begin
  LqryExec := fCriaQuery() ;
  try
    AcdsApuRecAcr.First ;
    while not AcdsApuRecAcr.Eof do
    begin
      if AcdsApuRecAcr.FieldByName('CODIGO').AsInteger < 0 then
      begin
        AcdsApuRecAcr.Next ;
        continue ;
      end;

      LqryExec.Close ;
      LqryExec.SQL.Clear ;
      LqryExec.SQL.Add('INSERT INTO APDREA (APD_CODAPR, APD_CODADR) VALUES (:CODAPR, :CODADR) ') ;
      LqryExec.ParamByName('CODAPR').AsInteger := AintCodigoAPREAC ;
      LqryExec.ParamByName('CODADR').AsInteger := AcdsApuRecAcr.FieldByName('CODIGO').AsInteger ;
      LqryExec.ExecSQL ;

      ///recupera o autoincrem
      LqryExec.Close ;
      LqryExec.SQL.Clear ;
      LqryExec.SQL.Add('SELECT LAST_INSERT_ID() ') ;
      LqryExec.Open ;
      LintCodigoAPDREA := LqryExec.Fields.Fields[0].AsInteger ;

      for LintMes := 1 to 12 do
      begin
        LstrMes := fStrZero(inttostr(LintMes), 2) ;
        LstrFieldName := 'BCAL' + LstrMes ;

        LqryExec.Close ;
        LqryExec.SQL.Clear ;
        LqryExec.SQL.Add('INSERT INTO APDMRA (APM_CODAPD, APM_MESAPU, APM_VALBAS) VALUES (:CODAPD, :MESAPU, :VALBAS) ') ;
        LqryExec.ParamByName('CODAPD').AsInteger := LintCodigoAPDREA ;
        LqryExec.ParamByName('MESAPU').AsInteger := LintMes ;
        LqryExec.ParamByName('VALBAS').AsFloat := AcdsApuRecAcr.FieldByName(LstrFieldName).AsFloat ;
        LqryExec.ExecSQL ;
      end;

      AcdsApuRecAcr.Next ;
    end;
  finally
    FreeAndNil(LqryExec) ;
  end;
  result := True ;
end;

procedure TApuracaoReceitasAcrecimos.pAfterEditCsll(
  AEvento: TDataSetNotifyEvent);
begin
  FevtAfterEditCsll := AEvento ;
  FcdsApuRecAcrCsll.AfterEdit := AEvento ;
end;

procedure TApuracaoReceitasAcrecimos.pAfterEditIrpj(
  AEvento: TDataSetNotifyEvent);
begin
  FevtAfterEditIrpj := AEvento ;
  FcdsApuRecAcrIrpj.AfterEdit := AEvento ;
end;

procedure TApuracaoReceitasAcrecimos.pAfterPostCsll(
  AEvento: TDataSetNotifyEvent);
begin
  FevtAfterPostCsll := AEvento ;
  FcdsApuRecAcrCsll.AfterPost := AEvento ;
end;

procedure TApuracaoReceitasAcrecimos.pAfterPostIrpj(
  AEvento: TDataSetNotifyEvent);
begin
  FevtAfterPostIrpj := AEvento ;
  FcdsApuRecAcrIrpj.AfterPost := AEvento ;
end;

procedure TApuracaoReceitasAcrecimos.pCreateCdsApuRecAcr(
  var AcdsApuRecAcr: TUniClientDataSet);
begin
  AcdsApuRecAcr := TUniClientDataSet.Create(Nil) ;
  AcdsApuRecAcr.FieldDefs.Add('CODIGO', ftInteger, 0, False) ;
  AcdsApuRecAcr.FieldDefs.Add('DESCRI', ftString, 45, False) ;
  AcdsApuRecAcr.FieldDefs.Add('PERCEN', ftFloat, 0, False) ;
  AcdsApuRecAcr.FieldDefs.Add('BCAL01', ftFloat, 0, False) ;
  AcdsApuRecAcr.FieldDefs.Add('BCAL02', ftFloat, 0, False) ;
  AcdsApuRecAcr.FieldDefs.Add('BCAL03', ftFloat, 0, False) ;
  AcdsApuRecAcr.FieldDefs.Add('BCAL04', ftFloat, 0, False) ;
  AcdsApuRecAcr.FieldDefs.Add('BCAL05', ftFloat, 0, False) ;
  AcdsApuRecAcr.FieldDefs.Add('BCAL06', ftFloat, 0, False) ;
  AcdsApuRecAcr.FieldDefs.Add('BCAL07', ftFloat, 0, False) ;
  AcdsApuRecAcr.FieldDefs.Add('BCAL08', ftFloat, 0, False) ;
  AcdsApuRecAcr.FieldDefs.Add('BCAL09', ftFloat, 0, False) ;
  AcdsApuRecAcr.FieldDefs.Add('BCAL10', ftFloat, 0, False) ;
  AcdsApuRecAcr.FieldDefs.Add('BCAL11', ftFloat, 0, False) ;
  AcdsApuRecAcr.FieldDefs.Add('BCAL12', ftFloat, 0, False) ;
  AcdsApuRecAcr.FieldDefs.Add('BCALTT', ftFloat, 0, False) ;
  AcdsApuRecAcr.CreateDataSet ;
  AcdsApuRecAcr.Open ;
end;

procedure TApuracaoReceitasAcrecimos.pLimpaDados;
begin
  FcdsApuRecAcrCsll.EmptyDataSet ;
  FcdsApuRecAcrIrpj.EmptyDataSet ;
end;

procedure TApuracaoReceitasAcrecimos.pProcessaCalculos(AcdsApuRecAcr: TUniClientDataSet);
var
  LcdsAux: TUniClientDataSet ;
  LstrMes: string ;
  LstrFieldName: string ;
  LintMes: integer ;
  LdictReceitaBruta: TDictionary<string, double> ;
  LdictBaseCalculo: TDictionary<string, double> ;
  LfltTotLinhaBaseCalculo: Double ;
  LfltTotLinhaReceitaBruta: Double ;
  LintBookMarkCodigo: integer ;
  LEventoAfterPost: TDataSetNotifyEvent ;
begin
  LcdsAux := TUniClientDataSet.Create(Nil);
  LdictReceitaBruta := TDictionary<string, double>.Create ;
  LdictBaseCalculo := TDictionary<string, double>.Create ;
  try
    ///inicializa os dicts
    for LintMes := 1 to 12 do
    begin
      LstrMes := fStrZero(inttostr(LintMes), 2) ;
      LdictReceitaBruta.Add(LstrMes, 0.00);
      LdictBaseCalculo.Add(LstrMes, 0.00);
    end;

    LcdsAux.Data := AcdsApuRecAcr.Data;
    LcdsAux.DisableControls ;
    try
      LcdsAux.First ;
      while not LcdsAux.Eof do
      begin
        ///desconsidera os totalizadores
        if LcdsAux.FieldByName('CODIGO').AsInteger < 0 then
        begin
          LcdsAux.Next ;
          continue ;
        end;

        for LintMes := 1 to 12 do
        begin
          LstrMes := fStrZero(inttostr(LintMes), 2) ;
          LstrFieldName := 'BCAL' + LstrMes ;
          if not LcdsAux.FieldByName(LstrFieldName).IsNull then
          begin
            LdictReceitaBruta.Items[LstrMes] := LdictReceitaBruta.Items[LstrMes] + fFormataFloat(LcdsAux.FieldByName(LstrFieldName).AsFloat, 2) ;
            LdictBaseCalculo.Items[LstrMes] := LdictBaseCalculo.Items[LstrMes] + fFormataFloat(LcdsAux.FieldByName(LstrFieldName).AsFloat * (LcdsAux.FieldByName('PERCEN').AsFloat/100), 2) ;
          end;
        end;
        LcdsAux.Next ;
      end;
    finally
      LcdsAux.EnableControls ;
    end;
    ///ajusta os totalizadores
    LfltTotLinhaReceitaBruta := 0.00 ;
    LEventoAfterPost := AcdsApuRecAcr.AfterPost ;
    AcdsApuRecAcr.AfterPost := Nil ;
    AcdsApuRecAcr.DisableControls ;
    try
      LintBookMarkCodigo := AcdsApuRecAcr.FieldByName('CODIGO').AsInteger ;
      ////total de cada linha
      AcdsApuRecAcr.First ;
      while not AcdsApuRecAcr.Eof do
      begin
        ///desconsidera os totalizadores
        if AcdsApuRecAcr.FieldByName('CODIGO').AsInteger < 0 then
        begin
          AcdsApuRecAcr.Next ;
          continue ;
        end;
        for LintMes := 1 to 12 do
        begin
          LstrMes := fStrZero(inttostr(LintMes), 2) ;
          LstrFieldName := 'BCAL' + LstrMes ;
          LfltTotLinhaReceitaBruta := LfltTotLinhaReceitaBruta + AcdsApuRecAcr.FieldByName(LstrFieldName).AsFloat ;
        end;
        AcdsApuRecAcr.Edit ;
        AcdsApuRecAcr.FieldByName('BCALTT').AsFloat := LfltTotLinhaReceitaBruta ;
        AcdsApuRecAcr.Post ;
        LfltTotLinhaReceitaBruta := 0.00 ;
        AcdsApuRecAcr.Next ;
      end;
      LfltTotLinhaBaseCalculo  := 0.00 ;
      LfltTotLinhaReceitaBruta := 0.00 ;
      /// receita bruta
      AcdsApuRecAcr.Locate('CODIGO', COD_TOTAL_RECEITA_BRUTA, [loCaseInsensitive]) ;
      AcdsApuRecAcr.Edit ;
      for LintMes := 1 to 12 do
      begin
        LstrMes := fStrZero(inttostr(LintMes), 2) ;
        LstrFieldName := 'BCAL' + LstrMes ;
        AcdsApuRecAcr.FieldByName(LstrFieldName).AsFloat := LdictReceitaBruta.Items[LstrMes] ;
        LfltTotLinhaReceitaBruta := LfltTotLinhaReceitaBruta + LdictReceitaBruta.Items[LstrMes] ;
      end;
      AcdsApuRecAcr.FieldByName('BCALTT').AsFloat := LfltTotLinhaReceitaBruta ;
      AcdsApuRecAcr.Post ;
      /// Base de calculo
      AcdsApuRecAcr.Locate('CODIGO', COD_BASE_CALCULO, [loCaseInsensitive]) ;
      AcdsApuRecAcr.Edit ;
      for LintMes := 1 to 12 do
      begin
        LstrMes := fStrZero(inttostr(LintMes), 2) ;
        LstrFieldName := 'BCAL' + LstrMes ;
        AcdsApuRecAcr.FieldByName(LstrFieldName).AsFloat := LdictBaseCalculo.Items[LstrMes] ;
        LfltTotLinhaBaseCalculo  := LfltTotLinhaBaseCalculo + LdictBaseCalculo.Items[LstrMes] ;
      end;
      AcdsApuRecAcr.FieldByName('BCALTT').AsFloat := LfltTotLinhaBaseCalculo ;
      AcdsApuRecAcr.Post ;
      ///restaura
      AcdsApuRecAcr.Locate('CODIGO', LintBookMarkCodigo, [loCaseInsensitive]) ;
    finally
      AcdsApuRecAcr.EnableControls ;
      AcdsApuRecAcr.AfterPost := LEventoAfterPost ;
    end;
    ///
  finally
    FreeAndNil(LcdsAux) ;
    FreeAndNil(LdictReceitaBruta) ;
    FreeAndNil(LdictBaseCalculo) ;
  end;
end;

procedure TApuracaoReceitasAcrecimos.pSetEmpresa(const AstrEmpresa: String);
begin
  FstrEmpresa := AstrEmpresa ;
end;

procedure TApuracaoReceitasAcrecimos.pSincronizaDadosApuRecAcr(
  var AcdsApuRecAcr: TUniClientDataSet; const AcdsDados: TUniClientDataSet);
var
  LintMes: integer ;
  LstrMes: string ;
  LstrFieldName: string ;
  LEventoAfterEdit: TDataSetNotifyEvent ;
begin
  AcdsApuRecAcr.First ;
  LEventoAfterEdit := AcdsApuRecAcr.AfterEdit ;
  AcdsApuRecAcr.AfterEdit := Nil ;
  try
    while not AcdsApuRecAcr.Eof  do
    begin
      for LintMes := 1 to 12 do
      begin
        if AcdsDados.FindKey([AcdsApuRecAcr.FieldByName('CODIGO').AsInteger, LintMes]) then
        begin
          LstrMes := fStrZero(inttostr(LintMes), 2) ;
          LstrFieldName := 'BCAL' + LstrMes ;
          AcdsApuRecAcr.Edit ;
          AcdsApuRecAcr.FieldByName(LstrFieldName).AsFloat := AcdsDados.FieldByName('APM_VALBAS').AsFloat ;
          AcdsApuRecAcr.Post ;
        end;
      end;
      AcdsApuRecAcr.Next ;
    end;
    ///calcula os totais
    pProcessaCalculos(AcdsApuRecAcr) ;
  finally
    AcdsApuRecAcr.AfterEdit := LEventoAfterEdit ;
  end;
end;

end.
