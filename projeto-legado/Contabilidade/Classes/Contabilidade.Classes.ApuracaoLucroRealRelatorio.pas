unit Contabilidade.Classes.ApuracaoLucroRealRelatorio;

interface
  uses Contabilidade.Interfaces, Classes, Data.DB, MemDS, Uni,
       Datasnap.DBClient, UniClientDataSet, System.Generics.Collections,
       cxProgressBar;

  type
    TTipoLucroRealRelatorio = (tlrrLacsParteA, tlrrLacsParteB, tlrrLacsApuracao, tlrrLalurParteA, tlrrLalurParteB, tlrrLalurApuracao) ;
    TTipoLucroRealRelatorios = set of TTipoLucroRealRelatorio ;

    TdictSubGrupoItens = TDictionary<String, Double> ;
    TdictGrupoItens = TObjectDictionary<String, TdictSubGrupoItens> ;

    TValoresApuracao = class
      balancete: double ;
      receita_bruta: double ;
    end ;

    TinfoSomaAdicaoExclusao = class
      adicao: double ;
      exclusao: double ;
      descricao: String ;
    end ;

    TdictColunaApuracao = TObjectDictionary<string, TValoresApuracao> ;
    TdictPeriodoApuracao = TObjectDictionary<TDateTime, TdictColunaApuracao> ;

    TValoresDeducaoRetencao = class
      balancete: double ;
      receita_bruta: double ;
      tipo: string ;
      descricao: string ;
    end ;
    TdictColunaDeducaoRetencao = TObjectDictionary<string, TValoresDeducaoRetencao> ;
    TdictPeriodoDeducaoRetencao = TObjectDictionary<TDateTime, TdictColunaDeducaoRetencao> ;

    TdictPeriodoImpostoRecolhido = TDictionary<TDateTime, double> ;

    TdictColunaApuracaoMensal = TDictionary<string, double> ;
    TdictPeriodoApuracaoMensal = TObjectDictionary<TDateTime, TdictColunaApuracaoMensal> ;

    TdictPeriodoTipoApuracaoMensal = TObjectDictionary<TDateTime, string> ;

    TdictValorAdicionalIRPJ = TDictionary<string, double> ;

    TApuracaoLucroRealRelatorio = class
    private
      FecEncerramento: TEncerramentoContabil;
      FstrEmpresa: string ;
      FtlrrTipos: TTipoLucroRealRelatorios ;
      FintExercicio: integer ;
      FdtaPeriodoInicial: TDateTime ;
      FdtaPeriodoFinal: TDateTime ;
      FcdsAjustesLacsParteA: TUniClientDataset ;
      FcdsDemonstrativoLacsParteA: TUniClientDataset ;
      FcdsAjustesLalurParteA: TUniClientDataset ;
      FcdsDemonstrativoLalurParteA: TUniClientDataset ;
      FcdsLancamentosCtaConLacsParteB: TUniClientDataset ;
      FcdsLancamentosCtaConLalurParteB: TUniClientDataset ;
      FcdsMestreLacsApuracao: TUniClientDataset ;
      FcdsDetalheLacsApuracao: TUniClientDataset ;
      FcdsMestreLalurApuracao: TUniClientDataset ;
      FcdsDetalheLalurApuracao: TUniClientDataset ;
      FdsMestreLacsApuracao: TDataSource ;
      FdsMestreLalurApuracao: TDataSource ;
      function fRetornaCondicaoQueryVazia(const AtlrrTipoRelatorio: TTipoLucroRealRelatorio):string ;
      function fValidaEntradaDados:boolean ;
      ///parte A
      procedure pCarregaAjustesParteA(var AcdsDados: TUniClientDataSet; const AllTipo: TLacsLalur; const AtlrrTipoRelatorio: TTipoLucroRealRelatorio) ;
      procedure pCarregaDemonstrativoParteA(var AcdsDados: TUniClientDataSet; const AllTipo: TLacsLalur; const AtlrrTipoRelatorio: TTipoLucroRealRelatorio) ;
      function fCriaCdsDemonstrativoParteA: TUniClientDataSet ;
      procedure pDesmembraAdicaoExclusao(const AcdsDados: TUniClientDataset; var AdictAdicoes, AdictExclusoes: TdictGrupoItens) ;
      function fCarregaDadosParteA(const AllTipo: TLacsLalur; const AtlrrTipoRelatorio: TTipoLucroRealRelatorio; var AcdsAjuste, AcdsDemonstrativo: TUniClientDataSet):boolean ;
      ///parte B
      procedure pCarregaContaControladaParteB(var AcdsDados: TUniClientDataSet; const AllTipo: TLacsLalur; const AtlrrTipoRelatorio: TTipoLucroRealRelatorio) ;
      function fRetornaFiltroContaControlada(const AllTipo: TLacsLalur): string ;
      function fProcessaSaldoAnterior(const AqryLanctos: TUniquery): TDictionary<string, double> ;
      function fCriaCdsContasControladasParteB: TUniClientDataSet ;
      function fRetornaSaldoContaControlada(const AdictSaldoAnterior: TDictionary<string, double>; const AstrChave: String): Double ;
      procedure pCalculaSaldoContaControlada(const AdictSaldoAnterior: TDictionary<string, double>; const AcdsDadosAProc: TUniClientDataSet; var AcdsDados: TUniClientDataSet) ;
      function fCredDeb(const AfltValor: double):string ;
      function fValorByCreDeb(const AfltValor: double; AstrCredDeb: string): double ;
      function fCarregaDadosParteB(const AllTipo: TLacsLalur; const AtlrrTipoRelatorio: TTipoLucroRealRelatorio; var AcdsLancamentosCtaCon: TUniClientDataSet):boolean ;
      ///Apuração
      procedure pCarregaApuracao(var AcdsMestre, AcdsDetalhe: TUniClientDataSet; const AiiTipo: TCsllIrpj; const AtlrrTipoRelatorio: TTipoLucroRealRelatorio; var AdsMestre: TDataSource) ;
      function fCriaCdsDetalheApuracao: TUniClientDataSet ;
      procedure pCalculaPeriodoData(var AdtaIni, AdtaFin: TDateTime; const AstrTipo: string; const AintPeriodo, AintExercicio: integer) ;
      function fCarregaCfgPlancoRealizado(const AiiTipo: TCsllIrpj): string;
      function fCalculaDetalheApuracao(AcdsMestre, AcdsDeducoesRetencoes, AcdsApuracoes, AcdsRecolhido, AcdsApuracaoMensal, AcdsTipoApuracaoMensal: TUniClientDataSet; const AiiTipo: TCsllIrpj):TUniClientDataSet ;
      function fCriaDictAgrupadoApuracao(AcdsApuracoes: TUniClientDataSet):TdictPeriodoApuracao ;
      function fCriaDictDeducaoRetencaoApuracao(AcdsDeducoesRetencoes: TuniClientDataset): TdictPeriodoDeducaoRetencao ;
      function fCriaDictImpostoRecolhidoApuracao(AcdsRecolhido: TUniClientDataSet): TdictPeriodoImpostoRecolhido ;
      function fCriaDictMensalApuracao(AcdsApuracaoMensal: TUniClientDataSet): TdictPeriodoApuracaoMensal ;
      function fCriaDictTipoMensalApuracao(AcdsTipoApuracaoMensal: TUniClientDataSet): TdictPeriodoTipoApuracaoMensal ;
      function fCarregaDadosApuracao(const AiiTipo: TCsllIrpj; const AtlrrTipoRelatorio: TTipoLucroRealRelatorio; var AcdsMestre, AcdsDetalhe: TUniClientDataSet; var AdsMestre: TDataSource):boolean ;
      procedure pCalculaValorAdicionalIRPJ(const AintPeriodo: integer; const AdictBaseCalculo: TValoresApuracao; var AdictValAdReceita, AdictValAdBalancete: TdictValorAdicionalIRPJ) ;
      procedure pFreeAndNil(var AptObj: Pointer);
      procedure pChaveDictParaLstOrdenada(const AdictColunaDeducaoRetencao: TdictColunaDeducaoRetencao; const AstrTipoDedRet: string; const AiiTipo: TCsllIrpj; var AlstOrdenada: TStringList);
      procedure pAcumulaAdicaoExclusao(var AcdsAdicaoExclusao: TUniClientDataSet) ;
      function fZeraValorNegativo(const AfltValor: Double): Double ;
      function fStrTipoDedRet(const AiiTipo: TCsllIrpj; const AStrCodigo: string): string;
    public
      procedure pSetEmpresa(const AstrEmpresa: String) ;
      property Tipos: TTipoLucroRealRelatorios read FtlrrTipos write FtlrrTipos ;
      property Exercicio: integer read FintExercicio write FintExercicio ;
      property PeriodoInicial: TDateTime read FdtaPeriodoInicial write FdtaPeriodoInicial ;
      property PeriodoFinal: TDateTime read FdtaPeriodoFinal write FdtaPeriodoFinal ;
      property Encerramento: TEncerramentoContabil read FecEncerramento write FecEncerramento ;

      property AjustesLacsParteA: TUniClientDataset read FcdsAjustesLacsParteA ;
      property DemonstrativoLacsParteA: TUniClientDataset read FcdsDemonstrativoLacsParteA ;
      property AjustesLalurParteA: TUniClientDataset read FcdsAjustesLalurParteA ;
      property DemonstrativoLalurParteA: TUniClientDataset read FcdsDemonstrativoLalurParteA ;
      property LancamentosCtaConLacsParteB: TUniClientDataset read FcdsLancamentosCtaConLacsParteB ;
      property LancamentosCtaConLalurParteB: TUniClientDataset read FcdsLancamentosCtaConLalurParteB ;
      property MestreLacsApuracao: TUniClientDataset read FcdsMestreLacsApuracao ;
      property DetalheLacsApuracao: TUniClientDataset read FcdsDetalheLacsApuracao ;
      property MestreLalurApuracao: TUniClientDataset read FcdsMestreLalurApuracao ;
      property DetalheLalurApuracao: TUniClientDataset read FcdsDetalheLalurApuracao ;

      constructor Create(); reintroduce ;
      destructor Destroy; override ;
      function fCarregaDados(ApgbProgresso: TcxProgressBar):boolean ;
    end ;

implementation

uses untFuncoesSimples, sysUtils, DateUtils, Vcl.Forms, Vcl.StdCtrls, strUtils, Contabilidade.Funcoes ;

const
  DESCR_LUCRO_LIQUIDO : Array[TLacsLalur] Of String = ('', 'LUCRO LÍQUIDO ANTES DA CSLL:', 'LUCRO LÍQUIDO ANTES DO IRPJ:') ;
  DESCR_BASE_CALCULO_ANTES_COMPENSACAO : Array[TLacsLalur] Of String = ('', 'BASE DE CÁLCULO DA CSLL ANTES DA COMPENSAÇÃO DA BASE DE CÁLCULO NEGATIVA:', 'BASE DE CÁLCULO DO IRPJ ANTES DA COMPENSAÇÃO DOS PREJUÍZOS ACUMULADOS:') ;
  DESCR_COMPENSACAO : Array[TLacsLalur] Of String = ('', 'COMPENSAÇÃO DA BASE DE CÁLCULO NEGATIVA DA CSLL:', 'COMPENSAÇÃO DOS PREJUÍZOS ACUMULADOS:') ;
  DESCR_BASE_CALCULO : Array[TLacsLalur] Of String = ('', 'BASE DE CÁLCULO DA CONTRIBUIÇÃO SOCIAL SOBRE O LUCRO LÍQUIDO:', 'BASE DE CÁLCULO DO IMPOSTO DE RENDA: ') ;

  DESCR_BASE_CALCULO_AP : Array[TCsllIrpj] Of String = ('BASE DE CÁLCULO DO IRPJ', 'BASE DE CÁLCULO DA CSLL') ;
  DESCR_VALOR_ANTES_DED_AP : Array[TCsllIrpj] Of String = ('(=) IRPJ', '(=) CSLL') ;
  DESCR_VALOR_AP : Array[TCsllIrpj] Of String = ('(=) VALOR DO IRPJ', '(=) VALOR DA CSLL') ;
  DESCR_RECOLHIMENTOS_REALIZADOS_AP : Array[TCsllIrpj] Of String = ('(-) RECOLHIMENTOS DO IRPJ REALIZADOS', '(-) RECOLHIMENTOS DA CSLL REALIZADOS') ;
  DESCR_VALOR_APURADO_AP : Array[TCsllIrpj] Of String = ('(=) VALOR DO IMPOSTO DE RENDA', '(=) VALOR DA CONTRIBUIÇÃO SOCIAL') ;
  DESCR_VALOR_RECOLHER_CONFORME_OPCAO_AP : Array[TCsllIrpj] Of String = ('VALOR DO IMPOSTO DE RENDA A SER RECOLHIDO, CONFORME APURAÇÃO', 'VALOR DA CONTRIBUIÇÃO SOCIAL A SER RECOLHIDA, CONFORME APURAÇÃO') ;

  FIELD_BC : Array[TCsllIrpj] Of String = ('DET_BCIRPJ', 'DET_BCCSLL') ;
  FIELD_VL : Array[TCsllIrpj] Of String = ('DET_VLIRPJ', 'DET_VLCSLL') ;
  FIELD_VLDED : Array[TCsllIrpj] Of String = ('DET_VLDEDI', 'DET_VLDEDC') ;
  FIELD_VLREC : Array[TCsllIrpj] Of String = ('DET_RCIRPJ', 'DET_RCCSLL') ;

  DESCR_VALOR_PARCELA_ISENTA = 'VALOR DA PARCELA ISENTA' ;
  DESCR_VALOR_EXCEDENTE = 'VALOR DO EXCEDENTE PARA CÁLCULO DO ADICIONAL' ;
  DESCR_VALOR_ADICIONAL = '(+) VALOR DO ADICIONAL DO IRPJ' ;

  ESPACO_IDENTACAO = '    ' ;

  CODIGOS_CSLL_DED: Array[0..8] of string  = ('8', '9', '10', '11', '12', '6', '7', '13.01', '13.02');
  CODIGOS_CSLL_RET: Array[0..6] of string  = ('14', '15', '16', '17', '18', '14.03', '14.04');
  CODIGOS_IRPJ_DED: Array[0..14] of string = ('6', '8', '9', '10', '11', '12', '13', '14', '15', '16', '16.01', '16.06', '16.07', '17', '18');
  CODIGOS_IRPJ_RET: Array[0..6] of string  = ('20', '19',  '21', '22', '23', '16.04', '16.05');

function fIsAssignedProgresso(ApgbProgresso: TcxProgressBar): boolean;
begin
  result := false ;
  if not Assigned(ApgbProgresso) then
    exit ;

  if not Assigned(GetParentForm(ApgbProgresso).FindComponent('lblGravando')) then
    exit ;

  result := true ;
end;

procedure pSetaTextoProgresso(ApgbProgresso: TcxProgressBar; AstrTexto: String);
begin
  if fIsAssignedProgresso(ApgbProgresso) then
  Begin
    TLabel(GetParentForm(ApgbProgresso).FindComponent('lblGravando')).Caption := AstrTexto;
    Application.ProcessMessages;
  End;
end;

{ TApuracaoLucroRealRelatorio }

constructor TApuracaoLucroRealRelatorio.Create();
begin
  inherited Create ;
  FstrEmpresa := '' ;
  FintExercicio := 0 ;
  FtlrrTipos := [] ;

  FcdsAjustesLacsParteA := Nil ;
  FcdsDemonstrativoLacsParteA := Nil ;
  FcdsAjustesLalurParteA := Nil ;
  FcdsDemonstrativoLalurParteA := Nil ;
  FcdsLancamentosCtaConLacsParteB := Nil ;
  FcdsLancamentosCtaConLalurParteB := Nil ;

  FcdsMestreLacsApuracao := Nil ;
  FcdsDetalheLacsApuracao := Nil ;
  FcdsMestreLalurApuracao := Nil ;
  FcdsDetalheLalurApuracao := Nil ;

  FdsMestreLacsApuracao  := TDataSource.Create(Nil) ;
  FdsMestreLalurApuracao := TDataSource.Create(Nil) ;
end;

destructor TApuracaoLucroRealRelatorio.Destroy;
begin
  self.pFreeAndNil(Pointer(FcdsAjustesLacsParteA)) ;
  self.pFreeAndNil(Pointer(FcdsDemonstrativoLacsParteA)) ;
  self.pFreeAndNil(Pointer(FcdsAjustesLalurParteA)) ;
  self.pFreeAndNil(Pointer(FcdsDemonstrativoLalurParteA)) ;
  self.pFreeAndNil(Pointer(FcdsLancamentosCtaConLacsParteB)) ;
  self.pFreeAndNil(Pointer(FcdsLancamentosCtaConLalurParteB)) ;
  self.pFreeAndNil(Pointer(FcdsMestreLacsApuracao)) ;
  self.pFreeAndNil(Pointer(FcdsDetalheLacsApuracao)) ;
  self.pFreeAndNil(Pointer(FcdsMestreLalurApuracao)) ;
  self.pFreeAndNil(Pointer(FcdsDetalheLalurApuracao)) ;
  FreeAndNil(FdsMestreLacsApuracao) ;
  FreeAndNil(FdsMestreLalurApuracao) ;
  inherited;
end;

function TApuracaoLucroRealRelatorio.fCalculaDetalheApuracao(AcdsMestre,
  AcdsDeducoesRetencoes, AcdsApuracoes, AcdsRecolhido, AcdsApuracaoMensal,
  AcdsTipoApuracaoMensal: TUniClientDataSet;
  const AiiTipo: TCsllIrpj): TUniClientDataSet;
var
  LcdsDetalhe: TUniClientDataSet ;
  LdictPeriodoApuracao: TdictPeriodoApuracao ;
  LdictColunaApuracao: TdictColunaApuracao ;

  LdictPeriodoDeducaoRetencao: TdictPeriodoDeducaoRetencao ;
  LdictColunaDeducaoRetencao: TdictColunaDeducaoRetencao ;
  LpairDeducaoRetencao: TPair<string, TValoresDeducaoRetencao> ;

  LdictPeriodoImpostoRecolhido: TdictPeriodoImpostoRecolhido ;

  LdictPeriodoApuracaoMensal: TdictPeriodoApuracaoMensal ;
  LdictPeriodoTipoApuracaoMensal: TdictPeriodoTipoApuracaoMensal ;

  LfltSomaReceitaDeducao: double ;
  LfltSomaBalanceteDeducao: double ;
  LfltSomaReceitaRetencao: double ;
  LfltSomaBalanceteRetencao: double ;
  LfltValorRecolhido: double ;
  LfltValorBalanceteCalculado: double ;

  LdictValorAdicionalBal, LdictValorAdicionalRec: TdictValorAdicionalIRPJ ;
  LPairValorAdicional: TPair<string, double> ;

  LlstOrdenada: TStringList ;
  LintCnt: integer ;
  LfltValorARecolherConformeOpcao: Double ;
begin
  LcdsDetalhe := fCriaCdsDetalheApuracao ;

  LdictPeriodoApuracao := fCriaDictAgrupadoApuracao(AcdsApuracoes);
  LdictPeriodoDeducaoRetencao := fCriaDictDeducaoRetencaoApuracao(AcdsDeducoesRetencoes);
  LdictPeriodoImpostoRecolhido := fCriaDictImpostoRecolhidoApuracao(AcdsRecolhido);
  LdictPeriodoApuracaoMensal := fCriaDictMensalApuracao(AcdsApuracaoMensal) ;
  LdictPeriodoTipoApuracaoMensal := fCriaDictTipoMensalApuracao(AcdsTipoApuracaoMensal) ;
  LlstOrdenada := TStringList.Create ;
  try
    AcdsMestre.First ;
    while not AcdsMestre.Eof do
    begin
      if LdictPeriodoApuracao.ContainsKey(AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime) then
      begin
        LdictColunaApuracao := LdictPeriodoApuracao.Items[AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime] ;

        LcdsDetalhe.Append ;
        LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
        LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
        LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
        LcdsDetalhe.FieldByName('DESCRI').AsString := DESCR_BASE_CALCULO_AP[AiiTipo] ;
        LcdsDetalhe.FieldByName('VLRBAL').AsFloat := LdictColunaApuracao.Items[FIELD_BC[AiiTipo]].balancete ;
        LcdsDetalhe.FieldByName('VLRREC').AsFloat := LdictColunaApuracao.Items[FIELD_BC[AiiTipo]].receita_bruta ;
        LcdsDetalhe.Post ;

        LcdsDetalhe.Append ;
        LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
        LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
        LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
        LcdsDetalhe.FieldByName('DESCRI').AsString := DESCR_VALOR_ANTES_DED_AP[AiiTipo] ;
        LcdsDetalhe.FieldByName('VLRBAL').AsFloat := LdictColunaApuracao.Items[FIELD_VL[AiiTipo]].balancete ;
        LcdsDetalhe.FieldByName('VLRREC').AsFloat := LdictColunaApuracao.Items[FIELD_VL[AiiTipo]].receita_bruta ;
        LcdsDetalhe.Post ;

        ///linha em branco
        LcdsDetalhe.Append ;
        LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
        LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
        LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
        LcdsDetalhe.Post ;

        ///valor adicional somente para o IRPJ(somente)
        if AiiTipo = iiIRPJ then
        begin
          pCalculaValorAdicionalIRPJ(MonthOf(AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime), LdictColunaApuracao.Items[FIELD_BC[AiiTipo]], LdictValorAdicionalRec, LdictValorAdicionalBal) ;
          try
            LcdsDetalhe.Append ;
            LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
            LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
            LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
            LcdsDetalhe.FieldByName('DESCRI').AsString := 'ADICIONAL DO IRPJ' ;
            LcdsDetalhe.FieldByName('TITULO').AsInteger := 1 ;
            LcdsDetalhe.Post ;

            LcdsDetalhe.Append ;
            LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
            LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
            LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
            LPairValorAdicional := LdictValorAdicionalBal.ExtractPair(DESCR_VALOR_PARCELA_ISENTA) ;
            LcdsDetalhe.FieldByName('DESCRI').AsString := ESPACO_IDENTACAO + LPairValorAdicional.Key ;
            LcdsDetalhe.FieldByName('VLRBAL').AsFloat := LPairValorAdicional.Value ;
            LcdsDetalhe.FieldByName('VLRREC').AsFloat := LdictValorAdicionalRec[DESCR_VALOR_PARCELA_ISENTA] ;
            LcdsDetalhe.Post ;

            LcdsDetalhe.Append ;
            LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
            LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
            LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
            LPairValorAdicional := LdictValorAdicionalBal.ExtractPair(DESCR_VALOR_EXCEDENTE) ;
            LcdsDetalhe.FieldByName('DESCRI').AsString := ESPACO_IDENTACAO + LPairValorAdicional.Key ;
            LcdsDetalhe.FieldByName('VLRBAL').AsFloat := LPairValorAdicional.Value ;
            LcdsDetalhe.FieldByName('VLRREC').AsFloat := LdictValorAdicionalRec[DESCR_VALOR_EXCEDENTE] ;
            LcdsDetalhe.Post ;

            LcdsDetalhe.Append ;
            LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
            LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
            LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
            LPairValorAdicional := LdictValorAdicionalBal.ExtractPair(DESCR_VALOR_ADICIONAL) ;
            LcdsDetalhe.FieldByName('DESCRI').AsString := LPairValorAdicional.Key ;
            LcdsDetalhe.FieldByName('VLRBAL').AsFloat := LPairValorAdicional.Value ;
            LcdsDetalhe.FieldByName('VLRREC').AsFloat := LdictValorAdicionalRec[DESCR_VALOR_ADICIONAL] ;
            LcdsDetalhe.Post ;

            ///linha em branco
            LcdsDetalhe.Append ;
            LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
            LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
            LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
            LcdsDetalhe.Post ;

          finally
            FreeAndNil(LdictValorAdicionalBal) ;
            FreeAndNil(LdictValorAdicionalRec) ;
          end ;
        end ;

        ///deduções/retenções
        if LdictPeriodoDeducaoRetencao.ContainsKey(AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime) then
        begin
          LdictColunaDeducaoRetencao := LdictPeriodoDeducaoRetencao.Items[AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime] ;
          // deduções
          LcdsDetalhe.Append ;
          LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
          LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
          LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
          LcdsDetalhe.FieldByName('DESCRI').AsString := '(-) DEDUÇÕES' ;
          LcdsDetalhe.FieldByName('TITULO').AsInteger := 1 ;
          LcdsDetalhe.Post ;
          LfltSomaReceitaDeducao := 0.00  ;
          LfltSomaBalanceteDeducao := 0.00  ;
          ///alimenta uma lista ordenada
          pChaveDictParaLstOrdenada(LdictColunaDeducaoRetencao, 'D', AiiTipo, LlstOrdenada) ;
          for LintCnt := 0 to LlstOrdenada.Count-1 do
          begin
            LpairDeducaoRetencao := LdictColunaDeducaoRetencao.ExtractPair(LlstOrdenada.Strings[LintCnt]) ;
            LcdsDetalhe.Append ;
            LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
            LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
            LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
            LcdsDetalhe.FieldByName('DESCRI').AsString := ESPACO_IDENTACAO + LpairDeducaoRetencao.Key + '-' + LpairDeducaoRetencao.Value.descricao ;
            LcdsDetalhe.FieldByName('VLRBAL').AsFloat := LpairDeducaoRetencao.Value.balancete*-1 ;
            LcdsDetalhe.FieldByName('VLRREC').AsFloat := LpairDeducaoRetencao.Value.receita_bruta*-1 ;
            LcdsDetalhe.Post ;

            LfltSomaReceitaDeducao := LfltSomaReceitaDeducao + LpairDeducaoRetencao.Value.receita_bruta  ;
            LfltSomaBalanceteDeducao := LfltSomaBalanceteDeducao + LpairDeducaoRetencao.Value.balancete  ;
          end ;

          LcdsDetalhe.Append ;
          LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
          LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
          LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
          LcdsDetalhe.FieldByName('DESCRI').AsString := '(=) TOTAL DAS DEDUÇÕES' ;
          LcdsDetalhe.FieldByName('VLRBAL').AsFloat := LfltSomaBalanceteDeducao*-1 ;
          LcdsDetalhe.FieldByName('VLRREC').AsFloat := LfltSomaReceitaDeducao*-1 ;
          LcdsDetalhe.Post ;
          ///linha em branco
          LcdsDetalhe.Append ;
          LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
          LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
          LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
          LcdsDetalhe.Post ;

          // retenções
          LcdsDetalhe.Append ;
          LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
          LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
          LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
          LcdsDetalhe.FieldByName('DESCRI').AsString := '(-) RETENÇÕES' ;
          LcdsDetalhe.FieldByName('TITULO').AsInteger := 1 ;
          LcdsDetalhe.Post ;
          LfltSomaReceitaRetencao := 0.00  ;
          LfltSomaBalanceteRetencao := 0.00  ;
          ///alimenta uma lista ordenada
          pChaveDictParaLstOrdenada(LdictColunaDeducaoRetencao, 'R', AiiTipo, LlstOrdenada) ;
          for LintCnt := 0 to LlstOrdenada.Count-1 do
          begin
            LpairDeducaoRetencao := LdictColunaDeducaoRetencao.ExtractPair(LlstOrdenada.Strings[LintCnt]) ;
            LcdsDetalhe.Append ;
            LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
            LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
            LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
            LcdsDetalhe.FieldByName('DESCRI').AsString := ESPACO_IDENTACAO + LpairDeducaoRetencao.Key + '-' + LpairDeducaoRetencao.Value.descricao ;
            LcdsDetalhe.FieldByName('VLRBAL').AsFloat := LpairDeducaoRetencao.Value.balancete*-1 ;
            LcdsDetalhe.FieldByName('VLRREC').AsFloat := LpairDeducaoRetencao.Value.receita_bruta*-1 ;
            LcdsDetalhe.Post ;

            LfltSomaReceitaRetencao := LfltSomaReceitaRetencao + LpairDeducaoRetencao.Value.receita_bruta ;
            LfltSomaBalanceteRetencao := LfltSomaBalanceteRetencao + LpairDeducaoRetencao.Value.balancete ;
          end ;

          LcdsDetalhe.Append ;
          LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
          LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
          LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
          LcdsDetalhe.FieldByName('DESCRI').AsString := '(=) TOTAL DAS RETENÇÕES' ;
          LcdsDetalhe.FieldByName('VLRBAL').AsFloat := LfltSomaBalanceteRetencao*-1 ;
          LcdsDetalhe.FieldByName('VLRREC').AsFloat := LfltSomaReceitaRetencao*-1 ;
          LcdsDetalhe.Post ;
          ///linha em branco
          LcdsDetalhe.Append ;
          LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
          LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
          LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
          LcdsDetalhe.Post ;
        end ;

        LfltValorBalanceteCalculado := LdictColunaApuracao.Items[FIELD_VLREC[AiiTipo]].balancete ;
        LcdsDetalhe.Append ;
        LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
        LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
        LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
        LcdsDetalhe.FieldByName('DESCRI').AsString := DESCR_VALOR_AP[AiiTipo] ;
        LcdsDetalhe.FieldByName('VLRBAL').AsFloat := LfltValorBalanceteCalculado ;
        LcdsDetalhe.FieldByName('VLRREC').AsFloat := LdictColunaApuracao.Items[FIELD_VLREC[AiiTipo]].receita_bruta ;
        LcdsDetalhe.Post ;

        if FecEncerramento = ecTrimestral then
        begin
          ///recolhimento realizado
          LcdsDetalhe.Append ;
          LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
          LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
          LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
          LcdsDetalhe.FieldByName('DESCRI').AsString := DESCR_RECOLHIMENTOS_REALIZADOS_AP[AiiTipo] ;
          LcdsDetalhe.FieldByName('VLRBAL').AsFloat := 0.00 ;
          LcdsDetalhe.FieldByName('VLRREC').AsFloat := 0.00 ;
          LcdsDetalhe.Post ;

          ///linha em branco
          LcdsDetalhe.Append ;
          LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
          LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
          LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
          LcdsDetalhe.Post ;

          LcdsDetalhe.Append ;
          LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
          LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
          LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
          LcdsDetalhe.FieldByName('DESCRI').AsString := DESCR_VALOR_APURADO_AP[AiiTipo] ;
          LcdsDetalhe.FieldByName('VLRBAL').AsFloat := LfltValorBalanceteCalculado ;
          LcdsDetalhe.Post ;

          ///linha em branco
          LcdsDetalhe.Append ;
          LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
          LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
          LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
          LcdsDetalhe.Post ;

          LcdsDetalhe.Append ;
          LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
          LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
          LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
          LcdsDetalhe.FieldByName('DESCRI').AsString := DESCR_VALOR_RECOLHER_CONFORME_OPCAO_AP[AiiTipo] ;
          LcdsDetalhe.FieldByName('VLRBAL').AsFloat := LfltValorBalanceteCalculado ;
          LcdsDetalhe.Post ;
        end
        else if FecEncerramento = ecAnual then
        begin

          ///recolhimento realizado
          LfltValorRecolhido := LdictPeriodoImpostoRecolhido.Items[AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime] ;
          LcdsDetalhe.Append ;
          LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
          LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
          LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
          LcdsDetalhe.FieldByName('DESCRI').AsString := DESCR_RECOLHIMENTOS_REALIZADOS_AP[AiiTipo] ;
          LcdsDetalhe.FieldByName('VLRBAL').AsFloat := LfltValorRecolhido ;
          LcdsDetalhe.FieldByName('VLRREC').AsFloat := 0.00 ;
          LcdsDetalhe.Post ;

          ///linha em branco
          LcdsDetalhe.Append ;
          LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
          LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
          LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
          LcdsDetalhe.Post ;

          LcdsDetalhe.Append ;
          LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
          LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
          LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
          LcdsDetalhe.FieldByName('DESCRI').AsString := DESCR_VALOR_APURADO_AP[AiiTipo] ;
          LcdsDetalhe.FieldByName('VLRBAL').AsFloat := LfltValorBalanceteCalculado - LfltValorRecolhido ;
          LcdsDetalhe.FieldByName('VLRREC').AsFloat := LdictColunaApuracao.Items[FIELD_VLREC[AiiTipo]].receita_bruta ;
          LcdsDetalhe.Post ;

          ///linha em branco
          LcdsDetalhe.Append ;
          LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
          LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
          LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
          LcdsDetalhe.Post ;

          LcdsDetalhe.Append ;
          LcdsDetalhe.FieldByName('AUTOINCREM').AsString := AcdsMestre.FieldByName('AUTOINCREM').AsString ;
          LcdsDetalhe.FieldByName('DTAINI').AsDateTime := AcdsMestre.FieldByName('PRE_DTAINI').AsDateTime ;
          LcdsDetalhe.FieldByName('DTAFIN').AsDateTime := AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime ;
          LcdsDetalhe.FieldByName('DESCRI').AsString := DESCR_VALOR_RECOLHER_CONFORME_OPCAO_AP[AiiTipo] ;
          LcdsDetalhe.FieldByName('VLRREC').AsFloat := 0.00 ;
          LcdsDetalhe.FieldByName('VLRBAL').AsFloat := 0.00 ;
          if LdictPeriodoTipoApuracaoMensal.Items[AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime] = 'Receita' then
          begin
            LfltValorARecolherConformeOpcao := LdictColunaApuracao.Items[FIELD_VLREC[AiiTipo]].receita_bruta ;
            LcdsDetalhe.FieldByName('VLRREC').AsFloat := LfltValorARecolherConformeOpcao ;
          end
          else if LdictPeriodoTipoApuracaoMensal.Items[AcdsMestre.FieldByName('PRE_DTAFIN').AsDateTime] = 'Balancete' then
          begin
            LfltValorARecolherConformeOpcao := LfltValorBalanceteCalculado - LfltValorRecolhido ;
            LcdsDetalhe.FieldByName('VLRBAL').AsFloat := fZeraValorNegativo(LfltValorARecolherConformeOpcao) ;
          end ;
          LcdsDetalhe.Post ;
        end ;

      end ;

      AcdsMestre.Next ;
    end ;

  finally
    FreeAndNil(LlstOrdenada) ;
    FreeAndNil(LdictPeriodoApuracao) ;
    FreeAndNil(LdictPeriodoDeducaoRetencao) ;
    FreeAndNil(LdictPeriodoImpostoRecolhido) ;
    FreeAndNil(LdictPeriodoApuracaoMensal) ;
    FreeAndNil(LdictPeriodoTipoApuracaoMensal) ;
  end ;
  LcdsDetalhe.IndexFieldNames := 'AUTOINCREM;CODIGO' ;
  result := LcdsDetalhe ;
end;

procedure TApuracaoLucroRealRelatorio.pCalculaValorAdicionalIRPJ(const AintPeriodo: integer; const AdictBaseCalculo: TValoresApuracao; var AdictValAdReceita, AdictValAdBalancete: TdictValorAdicionalIRPJ);
var
  LqryParametros: TUniQuery ;
  LfltValorParcelaIsenta: double ;
  LfltValorExcedente: double ;
  LfltValorAdicional: double ;
begin
  AdictValAdReceita := TdictValorAdicionalIRPJ.Create();
  AdictValAdBalancete := TdictValorAdicionalIRPJ.Create();

  LqryParametros := fCriaQuery() ;
  try
    LqryParametros.Close ;
    LqryParametros.SQL.Clear ;
    LqryParametros.SQL.Add(' SELECT TRI_VALBAS, TRI_ADIRPJ FROM EPREGT ') ;
    LqryParametros.SQL.Add(' WHERE TRI_ANOEXE = :ANOEXE ') ;
    LqryParametros.SQL.Add('       AND TRI_CODEMP = :CODEMP ') ;
    LqryParametros.ParamByName('ANOEXE').AsInteger := FintExercicio ;
    LqryParametros.ParamByName('CODEMP').AsString := FstrEmpresa ;
    LqryParametros.Open ;

    //balancete
    LfltValorParcelaIsenta := 0.00 ;
    if FecEncerramento = ecTrimestral then
    begin
      LfltValorParcelaIsenta := LqryParametros.FieldByName('TRI_VALBAS').AsFloat * 3 ;
    end
    else if FecEncerramento = ecAnual then
    begin
      LfltValorParcelaIsenta := LqryParametros.FieldByName('TRI_VALBAS').AsFloat * AintPeriodo ;
    end ;

    LfltValorExcedente := 0.00 ;
    LfltValorAdicional := 0.00 ;
    if AdictBaseCalculo.balancete > LfltValorParcelaIsenta then
    begin
      LfltValorExcedente := AdictBaseCalculo.balancete - LfltValorParcelaIsenta ;
      LfltValorAdicional := fFormataFloat(LfltValorExcedente * (LqryParametros.FieldByName('TRI_ADIRPJ').AsFloat/100), 2) ;
    end ;
    AdictValAdBalancete.Add(DESCR_VALOR_PARCELA_ISENTA, LfltValorParcelaIsenta) ;
    AdictValAdBalancete.Add(DESCR_VALOR_EXCEDENTE, LfltValorExcedente) ;
    AdictValAdBalancete.Add(DESCR_VALOR_ADICIONAL, LfltValorAdicional) ;

    //receita
    LfltValorParcelaIsenta := 0.00 ;
    LfltValorExcedente := 0.00 ;
    LfltValorAdicional := 0.00 ;
    if FecEncerramento = ecAnual then
    begin
      LfltValorParcelaIsenta := LqryParametros.FieldByName('TRI_VALBAS').AsFloat ;
      if AdictBaseCalculo.receita_bruta > LfltValorParcelaIsenta then
      begin
        LfltValorExcedente := AdictBaseCalculo.receita_bruta - LfltValorParcelaIsenta ;
        LfltValorAdicional := fFormataFloat(LfltValorExcedente * (LqryParametros.FieldByName('TRI_ADIRPJ').AsFloat/100), 2) ;
      end ;
    end ;
    AdictValAdReceita.Add(DESCR_VALOR_PARCELA_ISENTA, LfltValorParcelaIsenta) ;
    AdictValAdReceita.Add(DESCR_VALOR_EXCEDENTE, LfltValorExcedente) ;
    AdictValAdReceita.Add(DESCR_VALOR_ADICIONAL, LfltValorAdicional) ;

  finally
    FreeAndNil(LqryParametros) ;
  end ;
end;

function TApuracaoLucroRealRelatorio.fCarregaCfgPlancoRealizado(
  const AiiTipo: TCsllIrpj): string;
var
  LstrNomeCampo: string ;
begin
  LstrNomeCampo := iif(AiiTipo = iiCSLL, 'CFG_CONCSL', 'CFG_CONIRP') ;
  result := fCampoTabela(LstrNomeCampo, 'CFLALU', ['CFG_CODEMP'], [FstrEmpresa]) ;
end;

function TApuracaoLucroRealRelatorio.fCarregaDados(ApgbProgresso: TcxProgressBar): boolean;
var
  LintPassos : Integer ;
  LintPassosTotal : Integer ;
begin
  result := False ;
  if not fValidaEntradaDados then
  begin
    exit ;
  end ;

  LintPassos := 0 ;
  LintPassosTotal := 6 ;
  ApgbProgresso.Properties.Max := LintPassosTotal ;

  //lacs
  inc(LintPassos) ;
  ApgbProgresso.Position := LintPassos;
  Application.ProcessMessages;
  pSetaTextoProgresso(ApgbProgresso, 'Lacs Parte A' );

  if not fCarregaDadosParteA(llLacs, tlrrLacsParteA, FcdsAjustesLacsParteA, FcdsDemonstrativoLacsParteA) then
  begin
    exit ;
  end ;

  inc(LintPassos) ;
  ApgbProgresso.Position := LintPassos;
  Application.ProcessMessages;
  pSetaTextoProgresso(ApgbProgresso, 'Lacs Parte B' );

  if not fCarregaDadosParteB(llLacs, tlrrLacsParteB, FcdsLancamentosCtaConLacsParteB) then
  begin
    exit ;
  end ;

  inc(LintPassos) ;
  ApgbProgresso.Position := LintPassos;
  Application.ProcessMessages;
  pSetaTextoProgresso(ApgbProgresso, 'Lacs Apuração' );

  if not fCarregaDadosApuracao(iiCSLL, tlrrLacsApuracao, FcdsMestreLacsApuracao, FcdsDetalheLacsApuracao, FdsMestreLacsApuracao) then
  begin
    exit ;
  end ;

  //lalur
  inc(LintPassos) ;
  ApgbProgresso.Position := LintPassos;
  Application.ProcessMessages;
  pSetaTextoProgresso(ApgbProgresso, 'Lalur Parte A' );

  if not fCarregaDadosParteA(llLalur, tlrrLalurParteA, FcdsAjustesLalurParteA, FcdsDemonstrativoLalurParteA) then
  begin
    exit ;
  end ;

  inc(LintPassos) ;
  ApgbProgresso.Position := LintPassos;
  Application.ProcessMessages;
  pSetaTextoProgresso(ApgbProgresso, 'Lalur Parte B' );

  if not fCarregaDadosParteB(llLalur, tlrrLalurParteB, FcdsLancamentosCtaConLalurParteB) then
  begin
    exit ;
  end ;

  inc(LintPassos) ;
  ApgbProgresso.Position := LintPassos;
  Application.ProcessMessages;
  pSetaTextoProgresso(ApgbProgresso, 'Lalur Apuração' );

  if not fCarregaDadosApuracao(iiIRPJ, tlrrLalurApuracao, FcdsMestreLalurApuracao, FcdsDetalheLalurApuracao, FdsMestreLalurApuracao) then
  begin
    exit ;
  end ;

  result := True ;
end;

function TApuracaoLucroRealRelatorio.fCarregaDadosApuracao(
  const AiiTipo: TCsllIrpj;
  const AtlrrTipoRelatorio: TTipoLucroRealRelatorio;
  var AcdsMestre, AcdsDetalhe: TUniClientDataSet;
  var AdsMestre: TDataSource): boolean;
begin
  pCarregaApuracao(AcdsMestre, AcdsDetalhe, AiiTipo, AtlrrTipoRelatorio, AdsMestre);
  result := True ;
end;

function TApuracaoLucroRealRelatorio.fCarregaDadosParteA(const AllTipo: TLacsLalur; const AtlrrTipoRelatorio: TTipoLucroRealRelatorio; var AcdsAjuste, AcdsDemonstrativo: TUniClientDataSet): boolean;
begin
  pCarregaAjustesParteA(AcdsAjuste, AllTipo, AtlrrTipoRelatorio) ;
  pCarregaDemonstrativoParteA(AcdsDemonstrativo, AllTipo, AtlrrTipoRelatorio);
  result := True ;
end;

function TApuracaoLucroRealRelatorio.fCarregaDadosParteB(
  const AllTipo: TLacsLalur; const AtlrrTipoRelatorio: TTipoLucroRealRelatorio;
  var AcdsLancamentosCtaCon: TUniClientDataSet): boolean;
begin
  pCarregaContaControladaParteB(AcdsLancamentosCtaCon, AllTipo, AtlrrTipoRelatorio);
  result := True ;
end;

function TApuracaoLucroRealRelatorio.fStrTipoDedRet(const AiiTipo: TCsllIrpj; const AStrCodigo: string): string;
begin
  Result := '';

  if AiiTipo = iiCSLL then
  begin
    if IndexStr(AStrCodigo, CODIGOS_CSLL_DED) <> -1 then
      Result := 'D'
    else if IndexStr(AStrCodigo, CODIGOS_CSLL_RET) <> -1 then
      Result := 'R';
  end
  else if AiiTipo = iiIRPJ then
  begin
    if IndexStr(AStrCodigo, CODIGOS_IRPJ_DED) <> -1 then
      Result := 'D'
    else if IndexStr(AStrCodigo, CODIGOS_IRPJ_RET) <> -1 then
      Result := 'R';
  end;
end;

function TApuracaoLucroRealRelatorio.fCredDeb(const AfltValor: double): string;
begin
  if AfltValor >= 0.00 then
  begin
    result := 'D' ;
  end
  else
  begin
    result := 'C' ;
  end ;
end;

function TApuracaoLucroRealRelatorio.fCriaCdsContasControladasParteB: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil) ;
  Result.FieldDefs.Clear ;
  Result.FieldDefs.Add('CODIGO', ftAutoInc, 0, False) ;
  Result.FieldDefs.Add('CTACON', ftString, 5, False) ;
  Result.FieldDefs.Add('DESCRI', ftString, 100, False) ;
  Result.FieldDefs.Add('DTALAN', ftDate, 0, False) ;
  Result.FieldDefs.Add('HISTOR', ftString, 2048, False) ;
  Result.FieldDefs.Add('DEBITO', ftFloat, 0, False) ;
  Result.FieldDefs.Add('CREDIT', ftFloat, 0, False) ;
  Result.FieldDefs.Add('SALDO_', ftFloat, 0, False) ;
  Result.FieldDefs.Add('CREDEB', ftString, 1, False) ;
  Result.CreateDataSet ;
  Result.IndexFieldNames := 'CTACON;DTALAN' ;
  Result.Open ;
end;

function TApuracaoLucroRealRelatorio.fCriaCdsDemonstrativoParteA: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil) ;
  Result.FieldDefs.Clear ;
  Result.FieldDefs.Add('CODIGO', ftAutoInc, 0, False) ;
  Result.FieldDefs.Add('AUTOINCREM', ftString, 20, False) ;
  Result.FieldDefs.Add('DTAINI', ftDate, 0, False) ;
  Result.FieldDefs.Add('DTAFIN', ftDate, 0, False) ;
  Result.FieldDefs.Add('DESCRI', ftString, 125, False) ;
  Result.FieldDefs.Add('VALOR_', ftFloat, 0, False) ;
  Result.FieldDefs.Add('TOTAL_', ftFloat, 0, False) ;
  Result.CreateDataSet ;
  Result.IndexFieldNames := 'DTAFIN' ;
  Result.Open ;
end;

function TApuracaoLucroRealRelatorio.fCriaCdsDetalheApuracao: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil) ;
  Result.FieldDefs.Clear ;
  Result.FieldDefs.Add('CODIGO', ftAutoInc, 0, False) ;
  Result.FieldDefs.Add('AUTOINCREM', ftString, 20, False) ;
  Result.FieldDefs.Add('TITULO', ftInteger, 0, False) ;
  Result.FieldDefs.Add('DTAINI', ftDate, 0, False) ;
  Result.FieldDefs.Add('DTAFIN', ftDate, 0, False) ;

  Result.FieldDefs.Add('DESCRI', ftString, 125, False) ;
  Result.FieldDefs.Add('VLRBAL', ftFloat, 0, False) ;
  Result.FieldDefs.Add('VLRREC', ftFloat, 0, False) ;
  Result.CreateDataSet ;
  Result.IndexFieldNames := 'CODIGO' ;
  Result.Open ;
end;

function TApuracaoLucroRealRelatorio.fCriaDictAgrupadoApuracao(
  AcdsApuracoes: TUniClientDataSet): TdictPeriodoApuracao;
var
  LdictColunaApuracao: TdictColunaApuracao ;
  LobjValores: TValoresApuracao ;
  LdtaFinPeriodo: TDateTime ;
  LintCnt: integer ;
  LdictPeriodoApuracao: TdictPeriodoApuracao ;
begin
  LdictPeriodoApuracao := TdictPeriodoApuracao.Create([doOwnsValues]) ;
  AcdsApuracoes.First ;
  while not AcdsApuracoes.Eof do
  begin
    LdtaFinPeriodo := AcdsApuracoes.FieldByName('DTAFIN').AsDateTime ;
    if not LdictPeriodoApuracao.ContainsKey(LdtaFinPeriodo) then
    begin
      LdictColunaApuracao := TdictColunaApuracao.Create([doOwnsValues]) ;
      for LintCnt := 0 to AcdsApuracoes.Fields.Count-1 do
      begin
        if AcdsApuracoes.Fields.Fields[LintCnt].DataType = ftFloat then
        begin
          LobjValores := TValoresApuracao.Create ;
          LobjValores.balancete := 0.00 ;
          LobjValores.receita_bruta := 0.00 ;
          LdictColunaApuracao.Add(AcdsApuracoes.Fields.Fields[LintCnt].FieldName, LobjValores);
        end ;
      end ;
      LdictPeriodoApuracao.Add(LdtaFinPeriodo,LdictColunaApuracao);
    end ;
    LdictColunaApuracao := LdictPeriodoApuracao.Items[LdtaFinPeriodo] ;
    for LintCnt := 0 to AcdsApuracoes.Fields.Count-1 do
    begin
      if AcdsApuracoes.Fields.Fields[LintCnt].DataType = ftFloat then
      begin
        if AcdsApuracoes.FieldByName('DET_TIPREG').AsString = 'B' then
        begin
          LdictColunaApuracao.Items[AcdsApuracoes.Fields.Fields[LintCnt].FieldName].balancete := AcdsApuracoes.Fields.Fields[LintCnt].AsFloat ;
        end
        else if AcdsApuracoes.FieldByName('DET_TIPREG').AsString = 'R' then
        begin
          LdictColunaApuracao.Items[AcdsApuracoes.Fields.Fields[LintCnt].FieldName].receita_bruta := AcdsApuracoes.Fields.Fields[LintCnt].AsFloat ;
        end ;
      end ;
    end ;
    AcdsApuracoes.Next ;
  end ;
  result := LdictPeriodoApuracao ;
end;

function TApuracaoLucroRealRelatorio.fCriaDictDeducaoRetencaoApuracao(
  AcdsDeducoesRetencoes: TuniClientDataset): TdictPeriodoDeducaoRetencao;
var
  LdictPeriodo: TdictPeriodoDeducaoRetencao ;
  LdtaFinPeriodo: TDateTime ;
  LdictColuna : TdictColunaDeducaoRetencao ;
  LobjValores : TValoresDeducaoRetencao ;
  LdictAcumula : TDictionary<string, double> ;
  LstrCodDed : string ;
begin
  LdictPeriodo := TdictPeriodoDeducaoRetencao.Create([doOwnsValues]) ;

  LdictAcumula := TDictionary<string, double>.Create ;
  try
    AcdsDeducoesRetencoes.First ;
    while not AcdsDeducoesRetencoes.Eof do
    begin
      LdtaFinPeriodo := AcdsDeducoesRetencoes.FieldByName('DTAFIN').AsDateTime ;
      LstrCodDed := AcdsDeducoesRetencoes.FieldByName('DDE_CODDED').AsString ;
      if not LdictPeriodo.ContainsKey(LdtaFinPeriodo) then
      begin
        LdictColuna := TdictColunaDeducaoRetencao.Create([doOwnsValues]) ;
        LdictPeriodo.Add(LdtaFinPeriodo,LdictColuna);
      end ;
      LdictColuna := LdictPeriodo.Items[LdtaFinPeriodo] ;

      if not LdictColuna.ContainsKey(LstrCodDed) then
      begin
        LobjValores := TValoresDeducaoRetencao.Create ;
        LdictColuna.Add(LstrCodDed, LobjValores);
      end ;

      LobjValores := LdictColuna.Items[LstrCodDed] ;
      if FecEncerramento = ecTrimestral then
      begin
        LobjValores.balancete := AcdsDeducoesRetencoes.FieldByName('EDE_VALLAN').AsFloat ;
        LobjValores.receita_bruta := 0.00 ;
      end
      else if FecEncerramento = ecAnual then
      begin
        ///acumula de periodos anteriores
        if not LdictAcumula.ContainsKey(LstrCodDed) then
        begin
          LdictAcumula.Add(LstrCodDed, 0.00) ;
        end ;
        LdictAcumula.Items[LstrCodDed] := LdictAcumula.Items[LstrCodDed] + AcdsDeducoesRetencoes.FieldByName('EDE_VALLAN').AsFloat ;

        LobjValores.balancete := LdictAcumula.Items[LstrCodDed] ;
        LobjValores.receita_bruta := AcdsDeducoesRetencoes.FieldByName('EDE_VALLAN').AsFloat ;
      end ;
      LobjValores.tipo := AcdsDeducoesRetencoes.FieldByName('TIPO').AsString ;
      LobjValores.descricao := AcdsDeducoesRetencoes.FieldByName('DED_DESCRI').AsString ;

      AcdsDeducoesRetencoes.Next ;
    end ;
  finally
    FreeAndNil(LdictAcumula) ;
  end ;

  result := LdictPeriodo ;
end;

function TApuracaoLucroRealRelatorio.fCriaDictImpostoRecolhidoApuracao(
  AcdsRecolhido: TUniClientDataSet): TdictPeriodoImpostoRecolhido;
var
  LdictPeriodo: TdictPeriodoImpostoRecolhido ;
  LfltValorAcumulado: double ;
  LintPeriodos: integer ;
  LintTotalPeriodo: integer ;
  LstrTipoEncerramento: string ;
  LdtaIni, LdtaFin: TDateTime ;
  LfltValor: double ;
begin
  LdictPeriodo := TdictPeriodoImpostoRecolhido.Create() ;
  LfltValorAcumulado := 0.00 ;
  LintTotalPeriodo := iif(FecEncerramento = ecTrimestral, 4, 12) ;
  LstrTipoEncerramento := iif(FecEncerramento = ecTrimestral, 'T', 'A') ;
  AcdsRecolhido.First ;
  for LintPeriodos := 1 to LintTotalPeriodo do
  begin
    pCalculaPeriodoData(LdtaIni, LdtaFin, LstrTipoEncerramento, LintPeriodos, FintExercicio) ;

    LfltValor := 0.00 ;
    if AcdsRecolhido.FindKey([LdtaIni, LdtaFin]) then
    begin
      LfltValor := AcdsRecolhido.FieldByName('CON_VALLAN').AsFloat ;
    end ;

    if not LdictPeriodo.ContainsKey(LdtaFin) then
    begin
      LdictPeriodo.Add(LdtaFin,0.00);
    end ;

    if FecEncerramento = ecTrimestral then
    begin
      LdictPeriodo.Items[LdtaFin] := LdictPeriodo.Items[LdtaFin] + LfltValor ;
    end
    else if FecEncerramento = ecAnual then
    begin
      LfltValorAcumulado := LfltValorAcumulado + LfltValor ;
      LdictPeriodo.Items[LdtaFin] := LfltValorAcumulado ;
    end ;

  end ;
  result := LdictPeriodo ;
end;

function TApuracaoLucroRealRelatorio.fCriaDictMensalApuracao(
  AcdsApuracaoMensal: TUniClientDataSet): TdictPeriodoApuracaoMensal;
var
  LdictPeriodo: TdictPeriodoApuracaoMensal ;
  LdictColuna : TdictColunaApuracaoMensal ;
  LdtaFinPeriodo: TDateTime ;
  LstrRecBal: string ;
begin
  LdictPeriodo := TdictPeriodoApuracaoMensal.Create([doOwnsValues]) ;
  AcdsApuracaoMensal.First ;
  while not AcdsApuracaoMensal.Eof do
  begin
    LdtaFinPeriodo := AcdsApuracaoMensal.FieldByName('DTAFIN').AsDateTime ;
    LstrRecBal := AcdsApuracaoMensal.FieldByName('RDV_DESCRI').AsString ;

    if not LdictPeriodo.ContainsKey(LdtaFinPeriodo) then
    begin
      LdictColuna := TdictColunaApuracaoMensal.Create() ;
      LdictPeriodo.Add(LdtaFinPeriodo,LdictColuna);
    end ;
    LdictColuna := LdictPeriodo.Items[LdtaFinPeriodo] ;

    if not LdictColuna.ContainsKey(LstrRecBal) then
    begin
      LdictColuna.Add(LstrRecBal, AcdsApuracaoMensal.FieldByName('RDV_VLRAPU').AsFloat);
    end ;

    AcdsApuracaoMensal.Next ;
  end ;
  result := LdictPeriodo ;
end;

function TApuracaoLucroRealRelatorio.fCriaDictTipoMensalApuracao(
  AcdsTipoApuracaoMensal: TUniClientDataSet): TdictPeriodoTipoApuracaoMensal;
var
  LdictPeriodo: TdictPeriodoTipoApuracaoMensal ;
  LdtaFinPeriodo: TDateTime ;
  LstrRecBal: string ;
begin
  LdictPeriodo := TdictPeriodoTipoApuracaoMensal.Create() ;
  AcdsTipoApuracaoMensal.First ;
  while not AcdsTipoApuracaoMensal.Eof do
  begin
    LdtaFinPeriodo := AcdsTipoApuracaoMensal.FieldByName('DTAFIN').AsDateTime ;
    LstrRecBal := AcdsTipoApuracaoMensal.FieldByName('PRE_TPCONF').AsString ;

    if not LdictPeriodo.ContainsKey(LdtaFinPeriodo) then
    begin
      LdictPeriodo.Add(LdtaFinPeriodo,LstrRecBal);
    end ;

    AcdsTipoApuracaoMensal.Next ;
  end ;
  result := LdictPeriodo ;
end;

function TApuracaoLucroRealRelatorio.fProcessaSaldoAnterior(
  const AqryLanctos: TUniquery): TDictionary<string, double>;
var
  LstrCtaCon: string ;
begin
  result := TDictionary<string, double>.Create();
  AqryLanctos.First ;
  while not AqryLanctos.Eof do
  begin
    LstrCtaCon := AqryLanctos.FieldByName('SAL_CTACON').AsString ;
    if not result.ContainsKey(LstrCtaCon) then
    begin
      result.Add(LstrCtaCon, 0.00) ;
    end ;
    if AqryLanctos.FieldByName('SAL_CREDEB').AsString = 'D' then
    begin
      result.Items[LstrCtaCon] := result.Items[LstrCtaCon] + AqryLanctos.FieldByName('SAL_VALLAN').AsFloat ;
    end
    else if AqryLanctos.FieldByName('SAL_CREDEB').AsString = 'C' then
    begin
      result.Items[LstrCtaCon] := result.Items[LstrCtaCon] - AqryLanctos.FieldByName('SAL_VALLAN').AsFloat ;
    end ;
    AqryLanctos.Next ;
  end ;
end;

function TApuracaoLucroRealRelatorio.fRetornaCondicaoQueryVazia(
  const AtlrrTipoRelatorio: TTipoLucroRealRelatorio): string;
begin
  result := 'TRUE' ;
  if not (AtlrrTipoRelatorio in FtlrrTipos) then
  begin
    result := 'FALSE' ;
  end ;
end;

function TApuracaoLucroRealRelatorio.fRetornaFiltroContaControlada(
  const AllTipo: TLacsLalur): string;
begin
  if AllTipo = llLacs then
  begin
    result := 'AND CTACON.CTA_GRLACS = "S"' ;
  end
  else if AllTipo = llLalur then
  begin
    result := 'AND CTACON.CTA_GRLALU = "S"' ;
  end
  else
  begin
    result := '' ;
  end ;
end;

function TApuracaoLucroRealRelatorio.fRetornaSaldoContaControlada(
  const AdictSaldoAnterior: TDictionary<string, double>;
  const AstrChave: String): Double;
begin
  Result := 0 ;
  if AdictSaldoAnterior.ContainsKey(AstrChave) then
  begin
    Result := AdictSaldoAnterior[AstrChave] ;
  end ;
end;

function TApuracaoLucroRealRelatorio.fValidaEntradaDados: boolean;
begin
  result := False ;
  if FintExercicio <= 0 then
  begin
    fMensagem('ATENÇÃO!', 'Exercício inválido!', ['&Ok']);
    exit ;
  end ;

  if not fDataValida(FdtaPeriodoInicial) then
  begin
    fMensagem('ATENÇÃO!', 'Periodo inicial inválido!', ['&Ok']);
    exit ;
  end ;

  if not fDataValida(FdtaPeriodoFinal) then
  begin
    fMensagem('ATENÇÃO!', 'Periodo final inválido!', ['&Ok']);
    exit ;
  end ;

  if FdtaPeriodoInicial > FdtaPeriodoFinal then
  begin
    fMensagem('ATENÇÃO!', 'Periodo inicial maior que o periodo final!', ['&Ok']);
    exit ;
  end ;

  if FtlrrTipos = [] then
  begin
    fMensagem('ATENÇÃO!', 'Nenhum tipo informado!', ['&Ok']);
    exit ;
  end ;

  result := True ;
end;

function TApuracaoLucroRealRelatorio.fValorByCreDeb(const AfltValor: double;
  AstrCredDeb: string): double;
begin
  result := AfltValor ;
  if AstrCredDeb = 'C' then
  begin
    Result := Result*-1 ;
  end ;
end;

function TApuracaoLucroRealRelatorio.fZeraValorNegativo(
  const AfltValor: Double): Double;
begin
  Result := 0.00 ;
  if AfltValor > 0.00 then
    Result := AfltValor ;
end;

procedure TApuracaoLucroRealRelatorio.pAcumulaAdicaoExclusao(
  var AcdsAdicaoExclusao: TUniClientDataSet);
var
  LstrTipoEncerramento: String ;
  LcdsConsultaClone: TUniClientDataSet ;
  LarrDatas: array[0..11] of TDate ;
  LintCnt: Integer ;
  LdictNatAjuSoma: TObjectDictionary<String,TinfoSomaAdicaoExclusao> ;
  LobjInfoAdcExc: TinfoSomaAdicaoExclusao ;
  LpairAdcExc: TPair<String,TinfoSomaAdicaoExclusao> ;
  LstrAuxAutoInc: String ;
  LdtaAuxIni: TDate ;
  LdtaAuxFin: TDate ;
begin
  LstrTipoEncerramento := fCampoTabela('TRI_ENCERR', 'EPREGT', ['TRI_CODEMP','TRI_ANOEXE'], [FstrEmpresa, YearOf(FdtaPeriodoInicial)]) ;
  if LstrTipoEncerramento = 'A' then
  begin
    LcdsConsultaClone := TUniClientDataSet.Create(nil);
    LdictNatAjuSoma := TObjectDictionary<String,TinfoSomaAdicaoExclusao>.Create([doOwnsValues]);
    AcdsAdicaoExclusao.DisableControls ;
    try
      LcdsConsultaClone.Data := AcdsAdicaoExclusao.Data;
      for LintCnt := Low(LarrDatas) to High(LarrDatas) do
      begin
        LarrDatas[LintCnt] := TDate(EndOfAMonth(YearOf(FdtaPeriodoInicial), LintCnt+1)) ;

        if not DateInRange(LarrDatas[LintCnt], FdtaPeriodoInicial, FdtaPeriodoFinal) then
          continue ;

        LcdsConsultaClone.Filtered := False ;
        LcdsConsultaClone.Filter := 'PRE_DTAFIN < '+ QuotedStr(DateToStr(LarrDatas[LintCnt])) ;
        LcdsConsultaClone.Filtered := True ;
        LdictNatAjuSoma.Clear ;
        LcdsConsultaClone.First ;
        while not LcdsConsultaClone.Eof do
        begin
          if not LdictNatAjuSoma.ContainsKey(LcdsConsultaClone.FieldByName('NATAJU').AsString) then
          begin
            LobjInfoAdcExc := TinfoSomaAdicaoExclusao.Create ;
            LobjInfoAdcExc.adicao := LcdsConsultaClone.FieldByName('VAL_ADICAO').AsFloat ;
            LobjInfoAdcExc.exclusao := LcdsConsultaClone.FieldByName('VAL_EXCLUSAO').AsFloat ;
            LobjInfoAdcExc.descricao := LcdsConsultaClone.FieldByName('NAT_DESCRI').AsString ;
            LdictNatAjuSoma.Add(LcdsConsultaClone.FieldByName('NATAJU').AsString, LobjInfoAdcExc);
          end
          else
          begin
            LobjInfoAdcExc := LdictNatAjuSoma.Items[LcdsConsultaClone.FieldByName('NATAJU').AsString] ;
            LobjInfoAdcExc.adicao := LobjInfoAdcExc.adicao + LcdsConsultaClone.FieldByName('VAL_ADICAO').AsFloat ;
            LobjInfoAdcExc.exclusao := LobjInfoAdcExc.exclusao + LcdsConsultaClone.FieldByName('VAL_EXCLUSAO').AsFloat ;
          end ;
          LcdsConsultaClone.Next ;
        end ;
        if LdictNatAjuSoma.Count > 0 then
        begin
          AcdsAdicaoExclusao.Filtered := False ;
          AcdsAdicaoExclusao.Filter := 'PRE_DTAFIN = '+ QuotedStr(DateToStr(LarrDatas[LintCnt])) ;
          AcdsAdicaoExclusao.Filtered := True ;
          try
            LstrAuxAutoInc := AcdsAdicaoExclusao.FieldByName('AUTOINCREM').AsString ;
            LdtaAuxIni := AcdsAdicaoExclusao.FieldByName('PRE_DTAINI').AsDateTime ;
            LdtaAuxFin := AcdsAdicaoExclusao.FieldByName('PRE_DTAFIN').AsDateTime ;
            if (not AcdsAdicaoExclusao.IsEmpty) and (AcdsAdicaoExclusao.FieldByName('NATAJU').IsNull) then
              AcdsAdicaoExclusao.Delete ;

            for LpairAdcExc in LdictNatAjuSoma do
            begin
              if not AcdsAdicaoExclusao.Locate('NATAJU', LpairAdcExc.Key, [loCaseInsensitive]) then
              begin
                AcdsAdicaoExclusao.Append ;
                AcdsAdicaoExclusao.FieldByName('AUTOINCREM').AsString := LstrAuxAutoInc ;
                AcdsAdicaoExclusao.FieldByName('PRE_DTAINI').AsDateTime := LdtaAuxIni ;
                AcdsAdicaoExclusao.FieldByName('PRE_DTAFIN').AsDateTime := LdtaAuxFin ;
                AcdsAdicaoExclusao.FieldByName('NATAJU').AsString := LpairAdcExc.Key ;
                AcdsAdicaoExclusao.FieldByName('NAT_DESCRI').AsString := LpairAdcExc.Value.descricao ;
                AcdsAdicaoExclusao.Post ;
              end ;
              AcdsAdicaoExclusao.edit ;
              AcdsAdicaoExclusao.FieldByName('VAL_ADICAO').AsFloat := AcdsAdicaoExclusao.FieldByName('VAL_ADICAO').AsFloat + LpairAdcExc.Value.adicao ;
              AcdsAdicaoExclusao.FieldByName('VAL_EXCLUSAO').AsFloat := AcdsAdicaoExclusao.FieldByName('VAL_EXCLUSAO').AsFloat + LpairAdcExc.Value.exclusao ;
              AcdsAdicaoExclusao.Post ;
            end ;

          finally
            AcdsAdicaoExclusao.Filtered := False ;
          end ;
        end ;
      end ;
    finally
      FreeAndNil(LcdsConsultaClone) ;
      FreeAndNil(LdictNatAjuSoma) ;
      AcdsAdicaoExclusao.EnableControls ;
    end ;
  end ;
end;

procedure TApuracaoLucroRealRelatorio.pCalculaPeriodoData(var AdtaIni,
  AdtaFin: TDateTime; const AstrTipo: string; const AintPeriodo,
  AintExercicio: integer);
begin
  if AstrTipo = 'T' then
  begin
    Case AintPeriodo of
      1 :
        begin
          AdtaIni := EncodeDate(AintExercicio, 1, 1) ;
          AdtaFin := EncodeDate(AintExercicio, 3, 31) ;
        end ;
      2 :
        begin
          AdtaIni := EncodeDate(AintExercicio, 4, 1) ;
          AdtaFin := EncodeDate(AintExercicio, 6, 30) ;
        end ;
      3 :
        begin
          AdtaIni := EncodeDate(AintExercicio, 7, 1) ;
          AdtaFin := EncodeDate(AintExercicio, 9, 30) ;
        end ;
      4 :
        begin
          AdtaIni := EncodeDate(AintExercicio, 10, 1) ;
          AdtaFin := EncodeDate(AintExercicio, 12, 31) ;
        end ;
    end ;
  end
  else if AstrTipo = 'A' then
  begin
    AdtaIni := EncodeDate(AintExercicio, AintPeriodo, 1) ;
    AdtaFin := DateOf(EndOfTheMonth(AdtaIni)) ;
  end ;
end;

procedure TApuracaoLucroRealRelatorio.pCalculaSaldoContaControlada(
  const AdictSaldoAnterior: TDictionary<string, double>;
  const AcdsDadosAProc: TUniClientDataSet;
  var AcdsDados: TUniClientDataSet);
var
  LdictContasControladas: TDictionary<string, string> ;
  LPairCtaCon: TPair<string, string> ;
  LfltSaldo: double ;
  LPairSaldoAnterior: TPair<string, double> ;
  LstrDescri: string ;
begin
  LdictContasControladas := TDictionary<string, string>.Create ;
  AcdsDadosAProc.DisableControls ;
  try
    AcdsDadosAProc.First ;
    while not AcdsDadosAProc.Eof do
    begin
      if not LdictContasControladas.ContainsKey(AcdsDadosAProc.FieldByName('SAL_CTACON').AsString) then
      begin
        LdictContasControladas.Add(AcdsDadosAProc.FieldByName('SAL_CTACON').AsString, AcdsDadosAProc.FieldByName('CTA_DESCRI').AsString) ;
      end ;
      AcdsDadosAProc.Next ;
    end ;

    // alimenta com o saldo anterior
    for LPairSaldoAnterior in AdictSaldoAnterior do
    begin
      if not LdictContasControladas.ContainsKey(LPairSaldoAnterior.Key) then
      begin
        LstrDescri := fCampoTabela('CTA_DESCRI', 'CTACON', ['CTA_CODCON'], [LPairSaldoAnterior.Key]) ;
        LdictContasControladas.Add(LPairSaldoAnterior.Key, LstrDescri) ;
      end ;
    end ;

    for LPairCtaCon in LdictContasControladas do
    begin
      LfltSaldo := fRetornaSaldoContaControlada(AdictSaldoAnterior, LPairCtaCon.Key) ;

      if (fFormataFloat(LfltSaldo, 2) = 0.00) and (not AcdsDadosAProc.FindKey([LPairCtaCon.Key])) then
        Continue ;

      AcdsDados.Append;
      AcdsDados.FieldByName('CTACON').AsString := LPairCtaCon.Key ;
      AcdsDados.FieldByName('DESCRI').AsString := LPairCtaCon.Value ;
      AcdsDados.FieldByName('DTALAN').AsDateTime := FdtaPeriodoInicial ;
      AcdsDados.FieldByName('HISTOR').AsString := 'SALDO ANTERIOR' ;
      AcdsDados.FieldByName('SALDO_').AsFloat := Abs(LfltSaldo) ;
      AcdsDados.FieldByName('CREDEB').AsString := fCredDeb(LfltSaldo) ;
      AcdsDados.Post;

      if AcdsDadosAProc.FindKey([LPairCtaCon.Key]) then
      begin
        while (AcdsDadosAProc.FieldByName('SAL_CTACON').AsString = LPairCtaCon.Key) and (not AcdsDadosAProc.Eof) do
        begin
          LfltSaldo := LfltSaldo + fValorByCreDeb(AcdsDadosAProc.FieldByName('SAL_VALLAN').AsFloat, AcdsDadosAProc.FieldByName('SAL_CREDEB').AsString) ;

          AcdsDados.Append;
          AcdsDados.FieldByName('CTACON').AsString := LPairCtaCon.Key ;
          AcdsDados.FieldByName('DESCRI').AsString := LPairCtaCon.Value ;
          AcdsDados.FieldByName('DTALAN').AsDateTime := AcdsDadosAProc.FieldByName('SAL_DTALAN').AsDateTime ;
          AcdsDados.FieldByName('HISTOR').AsString := AcdsDadosAProc.FieldByName('SAL_HISTOR').AsString ;
          AcdsDados.FieldByName('SALDO_').AsFloat := Abs(LfltSaldo) ;
          AcdsDados.FieldByName('CREDEB').AsString := fCredDeb(LfltSaldo) ;
          if AcdsDadosAProc.FieldByName('SAL_CREDEB').AsString = 'C' then
          begin
            AcdsDados.FieldByName('CREDIT').AsFloat := AcdsDadosAProc.FieldByName('SAL_VALLAN').AsFloat ;
          end ;
          if AcdsDadosAProc.FieldByName('SAL_CREDEB').AsString = 'D' then
          begin
            AcdsDados.FieldByName('DEBITO').AsFloat := AcdsDadosAProc.FieldByName('SAL_VALLAN').AsFloat ;
          end ;
          AcdsDados.Post;

          AcdsDadosAProc.Next ;
        end ;

      end ;
    end ;

  finally
    AcdsDadosAProc.EnableControls ;
    FreeAndNil(LdictContasControladas) ;
  end ;

end;

procedure TApuracaoLucroRealRelatorio.pCarregaAjustesParteA(
  var AcdsDados: TUniClientDataSet; const AllTipo: TLacsLalur;
  const AtlrrTipoRelatorio: TTipoLucroRealRelatorio);
var
  LqryConsulta: TUniQuery ;
  LstrTipoEncerramento: String ;
  LcdsConsultaClone: TUniClientDataSet ;
  LarrDatas: array[0..11] of TDate ;
  LintCnt: Integer ;
begin
  LqryConsulta := fCriaQuery() ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add(' SELECT * FROM ( ') ;
    LqryConsulta.SQL.Add(' 	SELECT APUPRE.AUTOINCREM, ') ;
    LqryConsulta.SQL.Add(' 	       APUPRE.PRE_DTAINI, ') ;
    LqryConsulta.SQL.Add(' 	       APUPRE.PRE_DTAFIN, ') ;
    LqryConsulta.SQL.Add(' 	       CASE WHEN APUARE.ARE_LANCON IS NULL THEN ARE_DTALAN ELSE LANCON.CON_DTALAN END AS ARE_DTALAN, ') ;
    LqryConsulta.SQL.Add(' 	       CASE WHEN APUARE.ARE_LANCON IS NULL THEN UPPER(TRIM(CONCAT(COALESCE(HP_MANUAL. PAD_DESCRI,""), " ", COALESCE(ARE_HISTOR, "")))) ELSE UPPER(TRIM(CONCAT(COALESCE(HP_LANCON.PAD_DESCRI,""), " ", COALESCE(CON_HISTOR, "")))) END AS HISTOR, ') ;
    LqryConsulta.SQL.Add(' 	       CASE WHEN APUARE.ARE_LANCON IS NULL THEN (CASE WHEN NA_MANUAL.NAT_TIPMOV = "A" THEN APUARE.ARE_VALLAN ELSE 0.00 END) ELSE (CASE WHEN NA_LANCON.NAT_TIPMOV = "A" THEN LANCON.CON_VALLAN ELSE 0.00 END) END AS VAL_ADICAO, ') ;
    LqryConsulta.SQL.Add(' 	       CASE WHEN APUARE.ARE_LANCON IS NULL THEN (CASE WHEN NA_MANUAL.NAT_TIPMOV = "A" THEN APUARE.ARE_CREDEB ELSE " " END) ELSE (CASE WHEN NA_LANCON.NAT_TIPMOV = "A" THEN APUARE.ARE_CREDEB ELSE " " END) END AS CREDEB_ADICAO, ') ;
    LqryConsulta.SQL.Add(' 	       CASE WHEN APUARE.ARE_LANCON IS NULL THEN (CASE WHEN NA_MANUAL.NAT_TIPMOV = "E" THEN APUARE.ARE_VALLAN ELSE 0.00 END) ELSE (CASE WHEN NA_LANCON.NAT_TIPMOV = "E" THEN LANCON.CON_VALLAN ELSE 0.00 END) END AS VAL_EXCLUSAO, ') ;
    LqryConsulta.SQL.Add(' 	       CASE WHEN APUARE.ARE_LANCON IS NULL THEN (CASE WHEN NA_MANUAL.NAT_TIPMOV = "E" THEN APUARE.ARE_CREDEB ELSE " " END) ELSE (CASE WHEN NA_LANCON.NAT_TIPMOV = "E" THEN APUARE.ARE_CREDEB ELSE " " END) END AS CREDEB_EXCLUSAO ') ;
    LqryConsulta.SQL.Add(' 	FROM APUARE ') ;
    LqryConsulta.SQL.Add(' 	     INNER JOIN APUVRE ON APUARE.ARE_CODVRE = APUVRE.AUTOINCREM ') ;
    LqryConsulta.SQL.Add(' 	     INNER JOIN APUPRE ON APUVRE.VRE_CODPRE = APUPRE.PRE_CODPRE ') ;
    LqryConsulta.SQL.Add(' 	     LEFT JOIN CADEMP AS EMP_APUPRE ON APUPRE.PRE_CODEMP = EMP_APUPRE.EMP_CODEMP ') ;
    LqryConsulta.SQL.Add(' 	     LEFT JOIN HISPAD AS HP_MANUAL ON APUARE.ARE_HISPAD = HP_MANUAL.PAD_CODIGO ') ;
    if fCfgHisTpl then
      LqryConsulta.SQL.Add(' 	       AND HP_MANUAL.PAD_TPLACO = EMP_APUPRE.EMP_TPLACO ')
    else
      LqryConsulta.SQL.Add(' 	       AND  IFNULL(HP_MANUAL.PAD_TPLACO, "") = "" ');
    LqryConsulta.SQL.Add(' 	     LEFT JOIN LANCON ON APUARE.ARE_LANCON = LANCON.AUTOINCREM ') ;
    LqryConsulta.SQL.Add(' 	     LEFT JOIN CADEMP ON LANCON.CON_EMPLAN = CADEMP.EMP_CODEMP ') ;
    LqryConsulta.SQL.Add(' 	     LEFT JOIN HISPAD AS HP_LANCON ON LANCON.CON_HISPAD = HP_LANCON.PAD_CODIGO ') ;
    if fCfgHisTpl then
      LqryConsulta.SQL.Add(' 	       AND HP_LANCON.PAD_TPLACO = CADEMP.EMP_TPLACO ')
    else
      LqryConsulta.SQL.Add(' 	       AND  IFNULL(HP_LANCON.PAD_TPLACO, "") = "" ');
    LqryConsulta.SQL.Add(' 	     LEFT JOIN PLANCO AS PL_MANUAL ON APUARE.ARE_CODCON = PL_MANUAL.NCO_CODCON AND APUARE.ARE_TPLACO = PL_MANUAL.NCO_TPLACO AND PL_MANUAL.NCO_AJULIQ = "S" ') ;
    LqryConsulta.SQL.Add(' 	     LEFT JOIN NATAJU AS NA_MANUAL ON PL_MANUAL.NCO_NATAJU = NA_MANUAL.NAT_CODIGO ') ;
    LqryConsulta.SQL.Add(' 	     LEFT JOIN PLANCO AS PL_LANCON ON CASE WHEN ARE_CREDEB = "D" THEN LANCON.CON_CONDEB ELSE LANCON.CON_CONCRE END = PL_LANCON.NCO_CODCON AND CADEMP.EMP_TPLACO = PL_LANCON.NCO_TPLACO AND PL_LANCON.NCO_AJULIQ = "S" ') ;
    LqryConsulta.SQL.Add(' 	     LEFT JOIN NATAJU AS NA_LANCON ON PL_LANCON.NCO_NATAJU = NA_LANCON.NAT_CODIGO ') ;
    LqryConsulta.SQL.Add(' 	WHERE ' + fRetornaCondicaoQueryVazia(AtlrrTipoRelatorio) + ' AND APUVRE.VRE_TIPLAN = :TIPLAN ') ;
    LqryConsulta.SQL.Add(' 	      AND APUPRE.PRE_DTAFIN BETWEEN :DTAINI AND :DTAFIN ') ;
    LqryConsulta.SQL.Add(' 	      AND APUPRE.PRE_CODEMP = :CODEMP ') ;
    LqryConsulta.SQL.Add(' ) AS REL ') ;
    LqryConsulta.SQL.Add(' WHERE ARE_DTALAN IS NOT NULL ') ;
    LqryConsulta.SQL.Add(' ORDER BY PRE_DTAFIN, ARE_DTALAN, AUTOINCREM ') ;
    LqryConsulta.ParamByName('TIPLAN').AsString := COD_LACS_LALUR[AllTipo] ;
    LqryConsulta.ParamByName('DTAINI').AsDateTime := FdtaPeriodoInicial ;
    LqryConsulta.ParamByName('DTAFIN').AsDateTime := FdtaPeriodoFinal ;
    LqryConsulta.ParamByName('CODEMP').AsString := FstrEmpresa ;
    LqryConsulta.Open ;

    if Assigned(AcdsDados) then
    begin
      AcdsDados.Close ;
      FreeAndNil(AcdsDados) ;
    end ;

    AcdsDados := fCriaClientDatset(LqryConsulta) ;
    AcdsDados.IndexFieldNames := 'PRE_DTAFIN;ARE_DTALAN' ;

    LstrTipoEncerramento := fCampoTabela('TRI_ENCERR', 'EPREGT', ['TRI_CODEMP','TRI_ANOEXE'], [FstrEmpresa, YearOf(FdtaPeriodoInicial)]) ;
    // se for anual deverá calcular o cds acumulando mês a mês
    if LstrTipoEncerramento = 'A' then
    begin
      LcdsConsultaClone := TUniClientDataSet.Create(nil);
      AcdsDados.DisableControls ;
      try
        LcdsConsultaClone.Data := AcdsDados.Data;
        for LintCnt := Low(LarrDatas) to High(LarrDatas) do
        begin
          LarrDatas[LintCnt] := TDate(EndOfAMonth(YearOf(FdtaPeriodoInicial), LintCnt+1)) ;

          if not DateInRange(LarrDatas[LintCnt], FdtaPeriodoInicial, FdtaPeriodoFinal) then
            continue ;

          LcdsConsultaClone.Filtered := False ;
          LcdsConsultaClone.Filter := 'PRE_DTAFIN < '+ QuotedStr(DateToStr(LarrDatas[LintCnt])) ;
          LcdsConsultaClone.Filtered := True ;
          LcdsConsultaClone.First ;
          while not LcdsConsultaClone.Eof do
          begin
            AcdsDados.Append ;
            AcdsDados.FieldByName('AUTOINCREM').AsString := LcdsConsultaClone.FieldByName('AUTOINCREM').AsString ;
            AcdsDados.FieldByName('PRE_DTAINI').AsDateTime := LcdsConsultaClone.FieldByName('PRE_DTAINI').AsDateTime ;
            AcdsDados.FieldByName('PRE_DTAFIN').AsDateTime := LarrDatas[LintCnt] ;
            AcdsDados.FieldByName('ARE_DTALAN').AsDateTime := LcdsConsultaClone.FieldByName('ARE_DTALAN').AsDateTime ;
            AcdsDados.FieldByName('HISTOR').AsString := LcdsConsultaClone.FieldByName('HISTOR').AsString ;
            AcdsDados.FieldByName('VAL_ADICAO').AsFloat := LcdsConsultaClone.FieldByName('VAL_ADICAO').AsFloat ;
            AcdsDados.FieldByName('CREDEB_ADICAO').AsString := LcdsConsultaClone.FieldByName('CREDEB_ADICAO').AsString ;
            AcdsDados.FieldByName('VAL_EXCLUSAO').AsFloat := LcdsConsultaClone.FieldByName('VAL_EXCLUSAO').AsFloat ;
            AcdsDados.FieldByName('CREDEB_EXCLUSAO').AsString := LcdsConsultaClone.FieldByName('CREDEB_EXCLUSAO').AsString ;
            AcdsDados.Post ;
            LcdsConsultaClone.Next ;
          end ;
        end ;
      finally
        FreeAndNil(LcdsConsultaClone) ;
        AcdsDados.EnableControls ;
      end ;
    end ;
  finally
    FreeAndNil(LqryConsulta) ;
  end ;
end;

procedure TApuracaoLucroRealRelatorio.pCarregaApuracao(var AcdsMestre,
  AcdsDetalhe: TUniClientDataSet; const AiiTipo: TCsllIrpj;
  const AtlrrTipoRelatorio: TTipoLucroRealRelatorio; var AdsMestre: TDataSource);
var
  LqryMestre: TUniQuery ;
  LqryDeducoesRetencoes: TUniQuery ;
  LcdsDeducoesRetencoes: TUniClientDataSet ;

  LqryApuracoes: TUniQuery ;
  LcdsApuracoes: TUniClientDataSet ;

  LqryRecolhido: TUniQuery ;
  LcdsRecolhido: TUniClientDataSet ;

  LqryApuracaoMensal: TuniQuery ;
  LcdsApuracaoMensal: TUniClientDataSet ;

  LqryTipoApuracaoMensal: TuniQuery ;
  LcdsTipoApuracaoMensal: TUniClientDataSet ;

  LdtaIni, LdtaFin: TDateTime ;
  LstrTipoEncerramento: string ;
  LstrCtaImpostoRecolhido: string ;
begin

  LqryMestre := fCriaQuery() ;
  LqryDeducoesRetencoes := fCriaQuery() ;
  LcdsDeducoesRetencoes := nil ;
  LqryApuracoes := fCriaQuery() ;
  LcdsApuracoes := nil ;
  LqryRecolhido := fCriaQuery() ;
  LcdsRecolhido := nil ;
  LqryApuracaoMensal := fCriaQuery() ;
  LcdsApuracaoMensal := nil ;
  LqryTipoApuracaoMensal := fCriaQuery() ;
  LcdsTipoApuracaoMensal := nil ;
  try

    LqryMestre.Close ;
    LqryMestre.SQL.Clear ;
    LqryMestre.SQL.Add(' SELECT ') ;
    LqryMestre.SQL.Add('   APUPRE.AUTOINCREM, ') ;
    LqryMestre.SQL.Add('   APUPRE.PRE_DTAINI, ') ;
    LqryMestre.SQL.Add('   APUPRE.PRE_DTAFIN, ') ;
    LqryMestre.SQL.Add('   CASE WHEN APUVRE.VRE_TIPLAN = "' + COD_LACS_LALUR[llLacs] + '" THEN APUPRE.PRE_VRANRE ELSE COALESCE(APUPRE.PRE_VRANRE, 0.00)-COALESCE(APUPRE.PRE_VRLAIR, 0.00) END AS LUCRO_LIQUIDO, ') ;
    LqryMestre.SQL.Add('   APUVRE.VRE_VLADIC , ') ;
    LqryMestre.SQL.Add('   APUVRE.VRE_VLEXCL , ') ;
    LqryMestre.SQL.Add('   APUVRE.VRE_VLBCNG , ') ;
    LqryMestre.SQL.Add('   APUVRE.VRE_VLCOMP , ') ;
    LqryMestre.SQL.Add('   APUVRE.VRE_VLRBAS ') ;
    LqryMestre.SQL.Add(' FROM APUVRE ') ;
    LqryMestre.SQL.Add('      INNER JOIN APUPRE ON APUVRE.VRE_CODPRE = APUPRE.PRE_CODPRE ') ;
    LqryMestre.SQL.Add(' WHERE ' + fRetornaCondicaoQueryVazia(AtlrrTipoRelatorio) + ' AND APUVRE.VRE_TIPLAN = :TIPLAN ') ;
    LqryMestre.SQL.Add('       AND APUPRE.PRE_DTAFIN BETWEEN :DTAINI AND :DTAFIN ') ;
    LqryMestre.SQL.Add('       AND APUPRE.PRE_CODEMP = :CODEMP ') ;
    LqryMestre.SQL.Add(' ORDER BY APUPRE.PRE_DTAFIN ') ;

    if AiiTipo = iiCSLL then
      LqryMestre.ParamByName('TIPLAN').AsString := COD_LACS_LALUR[llLacs]
    else if AiiTipo = iiIRPJ then
      LqryMestre.ParamByName('TIPLAN').AsString := COD_LACS_LALUR[llLalur]
    else
      LqryMestre.ParamByName('TIPLAN').AsString := COD_LACS_LALUR[llNada];

    LqryMestre.ParamByName('DTAINI').AsDateTime := FdtaPeriodoInicial ;
    LqryMestre.ParamByName('DTAFIN').AsDateTime := FdtaPeriodoFinal ;
    LqryMestre.ParamByName('CODEMP').AsString := FstrEmpresa ;
    LqryMestre.Open ;

    AcdsMestre := fCriaClientDatset(LqryMestre) ;

    AdsMestre.DataSet := AcdsMestre ;

    LqryDeducoesRetencoes.Close ;
    LqryDeducoesRetencoes.SQL.Clear ;
    LqryDeducoesRetencoes.SQL.Add(' SELECT CAST(NULL AS DATE) AS DTAINI, CAST(NULL AS DATE) AS DTAFIN, DDE_ENCERR, CAST(NULL AS CHAR(1)) AS TIPO, DDE_CODDED, DED_DESCRI, EDE_PERAPU, EDE_VALLAN ') ;
    LqryDeducoesRetencoes.SQL.Add('  FROM APDERE ') ;
    LqryDeducoesRetencoes.SQL.Add('       INNER JOIN APDDED ON APDDED.DDE_CODAPD = APDERE.AUTOINCREM ') ;
    LqryDeducoesRetencoes.SQL.Add('       INNER JOIN APDEDE ON APDEDE.EDE_CODDDE = APDDED.AUTOINCREM ') ;
    LqryDeducoesRetencoes.SQL.Add('       INNER JOIN DEDRET ON APDDED.DDE_CODDED = DEDRET.DED_CODIGO AND APDDED.DDE_TIPIMP = DEDRET.DED_TIPIMP ') ;
    LqryDeducoesRetencoes.SQL.Add('  WHERE ' + fRetornaCondicaoQueryVazia(AtlrrTipoRelatorio) + ' AND APD_CODEMP = :CODEMP ') ;
    LqryDeducoesRetencoes.SQL.Add('        AND APD_EXERCI = :EXERCI ') ;
    LqryDeducoesRetencoes.SQL.Add('        AND DDE_TIPIMP = :TIPLAN ') ;
    LqryDeducoesRetencoes.SQL.Add('  ORDER BY EDE_PERAPU, DDE_CODDED ') ;
    LqryDeducoesRetencoes.ParamByName('TIPLAN').AsString := COD_IRPJ_CSLL[AiiTipo] ;
    LqryDeducoesRetencoes.ParamByName('EXERCI').AsInteger := FintExercicio ;
    LqryDeducoesRetencoes.ParamByName('CODEMP').AsString := FstrEmpresa ;
    LqryDeducoesRetencoes.Open ;
    LcdsDeducoesRetencoes := fCriaClientDatset(LqryDeducoesRetencoes) ;

    LstrTipoEncerramento := fCampoTabela('TRI_ENCERR', 'EPREGT', ['TRI_CODEMP','TRI_ANOEXE'], [FstrEmpresa, FintExercicio]) ;

    ///ajusta os periodos de acordo com o tipo
    LcdsDeducoesRetencoes.First ;
    while not LcdsDeducoesRetencoes.Eof do
    begin
      pCalculaPeriodoData(LdtaIni, LdtaFin, LstrTipoEncerramento, LcdsDeducoesRetencoes.FieldByName('EDE_PERAPU').AsInteger, FintExercicio) ;
      LcdsDeducoesRetencoes.Edit ;
      LcdsDeducoesRetencoes.FieldByName('TIPO').AsString := fStrTipoDedRet(AiiTipo, LcdsDeducoesRetencoes.FieldByName('DDE_CODDED').AsString);
      LcdsDeducoesRetencoes.FieldByName('DTAINI').AsDateTime := LdtaIni ;
      LcdsDeducoesRetencoes.FieldByName('DTAFIN').AsDateTime := LdtaFin ;
      LcdsDeducoesRetencoes.Post ;
      LcdsDeducoesRetencoes.Next ;
    end ;
    LcdsDeducoesRetencoes.First ;
    LcdsDeducoesRetencoes.IndexFieldNames := 'EDE_PERAPU;DDE_CODDED' ;

    LqryApuracoes.Close ;
    LqryApuracoes.SQL.Clear ;
    LqryApuracoes.SQL.Add(' SELECT CAST(NULL AS DATE) AS DTAINI, CAST(NULL AS DATE) AS DTAFIN, DET_PERAPU, DET_TIPREG, DET_BCCSLL, DET_VLCSLL, DET_VLDEDC, DET_RCCSLL, DET_BCIRPJ, DET_VLIRPJ, DET_VLADIC, DET_VLDEDI, DET_RCIRPJ ') ;
    LqryApuracoes.SQL.Add(' FROM APDDET INNER JOIN APDEAP ON APDDET.DET_CODEAP = APDEAP.AUTOINCREM ') ;
    LqryApuracoes.SQL.Add(' WHERE ' + fRetornaCondicaoQueryVazia(AtlrrTipoRelatorio) + ' AND EAP_CODEMP = :CODEMP ') ;
    LqryApuracoes.SQL.Add('       AND EAP_EXERCI = :EXERCI ') ;
    LqryApuracoes.SQL.Add(' ORDER BY DET_PERAPU, DET_TIPREG ') ;
    LqryApuracoes.ParamByName('EXERCI').AsInteger := FintExercicio ;
    LqryApuracoes.ParamByName('CODEMP').AsString := FstrEmpresa ;
    LqryApuracoes.Open ;
    LcdsApuracoes := fCriaClientDatset(LqryApuracoes) ;

    ///ajusta os periodos de acordo com o tipo
    LcdsApuracoes.First ;
    while not LcdsApuracoes.Eof do
    begin
      pCalculaPeriodoData(LdtaIni, LdtaFin, LstrTipoEncerramento, LcdsApuracoes.FieldByName('DET_PERAPU').AsInteger, FintExercicio) ;
      LcdsApuracoes.Edit ;
      LcdsApuracoes.FieldByName('DTAINI').AsDateTime := LdtaIni ;
      LcdsApuracoes.FieldByName('DTAFIN').AsDateTime := LdtaFin ;
      LcdsApuracoes.Post ;
      LcdsApuracoes.Next ;
    end ;
    LcdsApuracoes.First ;
    LcdsApuracoes.IndexFieldNames := 'DTAINI;DTAFIN' ;

    LstrCtaImpostoRecolhido := fCarregaCfgPlancoRealizado(AiiTipo) ;

    LqryRecolhido.Close ;
    LqryRecolhido.SQL.Clear ;
    LqryRecolhido.SQL.Add(' SELECT DTAINI, DTAFIN, MES, SUM(CON_VALLAN) AS CON_VALLAN FROM ( ') ;
    LqryRecolhido.SQL.Add(' SELECT CAST(NULL AS DATE) AS DTAINI, CAST(NULL AS DATE) AS DTAFIN, EXTRACT(MONTH FROM CON_DTALAN) AS MES, CON_VALLAN ') ;
    LqryRecolhido.SQL.Add(' FROM LANCON ') ;
    LqryRecolhido.SQL.Add(' WHERE ' + fRetornaCondicaoQueryVazia(AtlrrTipoRelatorio) + ' AND CON_CONDEB = :CONREC ') ;
    LqryRecolhido.SQL.Add('        AND CON_EMPLAN = :CODEMP ') ;
    LqryRecolhido.SQL.Add('        AND EXTRACT(YEAR FROM CON_DTALAN) = :EXERCI ') ;
    LqryRecolhido.SQL.Add('        AND AUTOINCREM NOT IN ( ') ;
    LqryRecolhido.SQL.Add('            SELECT SIG_LANCON ') ;
    LqryRecolhido.SQL.Add(' 	   FROM APESIG INNER JOIN APPEST ON APESIG.SIG_CODEST = APPEST.AUTOINCREM ') ;
    LqryRecolhido.SQL.Add(' 	   WHERE SIG_TIPREG = :TIPLAN ') ;
    LqryRecolhido.SQL.Add(' 	         AND EST_CODEMP = :CODEMP ') ;
    LqryRecolhido.SQL.Add(' 	         AND EST_EXERCI = :EXERCI ') ;
    LqryRecolhido.SQL.Add('            ) ') ;
    LqryRecolhido.SQL.Add(' UNION ALL ') ;
    LqryRecolhido.SQL.Add(' SELECT CAST(NULL AS DATE) AS DTAINI, CAST(NULL AS DATE) AS DTAFIN, EXTRACT(MONTH FROM CON_DTALAN) AS MES, -CON_VALLAN AS CON_VALLAN ') ;
    LqryRecolhido.SQL.Add(' FROM LANCON ') ;
    LqryRecolhido.SQL.Add(' WHERE ' + fRetornaCondicaoQueryVazia(AtlrrTipoRelatorio) + ' AND CON_CONCRE = :CONREC ') ;
    LqryRecolhido.SQL.Add('        AND CON_EMPLAN = :CODEMP ') ;
    LqryRecolhido.SQL.Add('        AND EXTRACT(YEAR FROM CON_DTALAN) = :EXERCI ') ;
    LqryRecolhido.SQL.Add('        AND AUTOINCREM NOT IN ( ') ;
    LqryRecolhido.SQL.Add('            SELECT SIG_LANCON ') ;
    LqryRecolhido.SQL.Add(' 	   FROM APESIG INNER JOIN APPEST ON APESIG.SIG_CODEST = APPEST.AUTOINCREM ') ;
    LqryRecolhido.SQL.Add(' 	   WHERE SIG_TIPREG = :TIPLAN ') ;
    LqryRecolhido.SQL.Add(' 	         AND EST_CODEMP = :CODEMP ') ;
    LqryRecolhido.SQL.Add(' 	         AND EST_EXERCI = :EXERCI ') ;
    LqryRecolhido.SQL.Add('            ) ') ;
    LqryRecolhido.SQL.Add(' ) AS SEL GROUP BY DTAINI, DTAFIN, MES ') ;
    LqryRecolhido.ParamByName('CONREC').AsString := LstrCtaImpostoRecolhido ;
    LqryRecolhido.ParamByName('CODEMP').AsString := FstrEmpresa ;
    LqryRecolhido.ParamByName('EXERCI').AsInteger := FintExercicio ;
    LqryRecolhido.ParamByName('TIPLAN').AsString := COD_IRPJ_CSLL[AiiTipo] ;
    LqryRecolhido.Open ;
    LcdsRecolhido := fCriaClientDatset(LqryRecolhido) ;

    ///ajusta os periodos de acordo com o tipo
    LcdsRecolhido.First ;
    while not LcdsRecolhido.Eof do
    begin
      pCalculaPeriodoData(LdtaIni, LdtaFin, LstrTipoEncerramento, LcdsRecolhido.FieldByName('MES').AsInteger, FintExercicio) ;
      LcdsRecolhido.Edit ;
      LcdsRecolhido.FieldByName('DTAINI').AsDateTime := LdtaIni ;
      LcdsRecolhido.FieldByName('DTAFIN').AsDateTime := LdtaFin ;
      LcdsRecolhido.Post ;
      LcdsRecolhido.Next ;
    end ;
    LcdsRecolhido.First ;
    LcdsRecolhido.IndexFieldNames := 'DTAINI;DTAFIN' ;

    LqryApuracaoMensal.Close ;
    LqryApuracaoMensal.SQL.Clear ;
    LqryApuracaoMensal.SQL.Add(' SELECT CAST(NULL AS DATE) AS DTAINI, CAST(NULL AS DATE) AS DTAFIN, APVRDV.RDV_PERAPU, CASE WHEN (APVRDV.RDV_DESCRI = "Recolhimento/Suspensão CSLL no Mês") OR (APVRDV.RDV_DESCRI = "Recolhimento/Suspensão IRPJ no Mês")'+' THEN "Receita" ELSE "Balancete" END AS RDV_DESCRI, APVRDV.RDV_VLRAPU ') ;
    LqryApuracaoMensal.SQL.Add(' FROM APVRDV INNER JOIN APPEST ON APVRDV.RDV_CODEST = APPEST.AUTOINCREM  ') ;
    LqryApuracaoMensal.SQL.Add(' WHERE APVRDV.RDV_TIPREG = :TIPLAN ') ;
    LqryApuracaoMensal.SQL.Add('       AND APPEST.EST_CODEMP = :CODEMP ') ;
    LqryApuracaoMensal.SQL.Add('       AND APPEST.EST_EXERCI = :EXERCI ') ;
    LqryApuracaoMensal.SQL.Add(' ORDER BY APVRDV.RDV_PERAPU, APVRDV.RDV_DESCRI ') ;
    LqryApuracaoMensal.ParamByName('TIPLAN').AsString := COD_IRPJ_CSLL[AiiTipo] ;
    LqryApuracaoMensal.ParamByName('EXERCI').AsInteger := FintExercicio ;
    LqryApuracaoMensal.ParamByName('CODEMP').AsString := FstrEmpresa ;
    LqryApuracaoMensal.Open ;

    LcdsApuracaoMensal := fCriaClientDatset(LqryApuracaoMensal) ;

    ///ajusta os periodos de acordo com o tipo
    LcdsApuracaoMensal.First ;
    while not LcdsApuracaoMensal.Eof do
    begin
      pCalculaPeriodoData(LdtaIni, LdtaFin, LstrTipoEncerramento, LcdsApuracaoMensal.FieldByName('RDV_PERAPU').AsInteger, FintExercicio) ;
      LcdsApuracaoMensal.Edit ;
      LcdsApuracaoMensal.FieldByName('DTAINI').AsDateTime := LdtaIni ;
      LcdsApuracaoMensal.FieldByName('DTAFIN').AsDateTime := LdtaFin ;
      LcdsApuracaoMensal.Post ;
      LcdsApuracaoMensal.Next ;
    end ;
    LcdsApuracaoMensal.First ;
    LcdsApuracaoMensal.IndexFieldNames := 'DTAINI;DTAFIN' ;

    LqryTipoApuracaoMensal.Close ;
    LqryTipoApuracaoMensal.SQL.Clear ;
    LqryTipoApuracaoMensal.SQL.Add(' SELECT CAST(NULL AS DATE) AS DTAINI, CAST(NULL AS DATE) AS DTAFIN, PRE_PERAPU, PRE_TPCONF ') ;
    LqryTipoApuracaoMensal.SQL.Add(' FROM APOPRE  INNER JOIN APPEST ON APOPRE.PRE_CODEST = APPEST.AUTOINCREM ') ;
    LqryTipoApuracaoMensal.SQL.Add(' WHERE APPEST.EST_CODEMP = :CODEMP ') ;
    LqryTipoApuracaoMensal.SQL.Add('       AND APPEST.EST_EXERCI = :EXERCI ') ;
    LqryTipoApuracaoMensal.SQL.Add(' ORDER BY APOPRE.PRE_PERAPU ') ;
    LqryTipoApuracaoMensal.ParamByName('EXERCI').AsInteger := FintExercicio ;
    LqryTipoApuracaoMensal.ParamByName('CODEMP').AsString := FstrEmpresa ;
    LqryTipoApuracaoMensal.Open ;

    LcdsTipoApuracaoMensal := fCriaClientDatset(LqryTipoApuracaoMensal) ;

    ///ajusta os periodos de acordo com o tipo
    LcdsTipoApuracaoMensal.First ;
    while not LcdsTipoApuracaoMensal.Eof do
    begin
      pCalculaPeriodoData(LdtaIni, LdtaFin, LstrTipoEncerramento, LcdsTipoApuracaoMensal.FieldByName('PRE_PERAPU').AsInteger, FintExercicio) ;
      LcdsTipoApuracaoMensal.Edit ;
      LcdsTipoApuracaoMensal.FieldByName('DTAINI').AsDateTime := LdtaIni ;
      LcdsTipoApuracaoMensal.FieldByName('DTAFIN').AsDateTime := LdtaFin ;
      LcdsTipoApuracaoMensal.Post ;
      LcdsTipoApuracaoMensal.Next ;
    end ;
    LcdsTipoApuracaoMensal.First ;
    LcdsTipoApuracaoMensal.IndexFieldNames := 'DTAINI;DTAFIN' ;


    AcdsDetalhe := fCalculaDetalheApuracao(AcdsMestre, LcdsDeducoesRetencoes, LcdsApuracoes, LcdsRecolhido, LcdsApuracaoMensal, LcdsTipoApuracaoMensal, AiiTipo) ;
    AcdsDetalhe.MasterSource := AdsMestre ;
    AcdsDetalhe.MasterFields := 'AUTOINCREM' ;

  finally
    FreeAndNil(LqryMestre) ;
    FreeAndNil(LqryDeducoesRetencoes) ;
    if Assigned(LcdsDeducoesRetencoes) then
    begin
      FreeAndNil(LcdsDeducoesRetencoes) ;
    end ;
    FreeAndNil(LqryApuracoes) ;
    if Assigned(LcdsApuracoes) then
    begin
      FreeAndNil(LcdsApuracoes) ;
    end ;
    FreeAndNil(LqryRecolhido) ;
    if Assigned(LcdsRecolhido) then
    begin
      FreeAndNil(LcdsRecolhido) ;
    end ;
    FreeAndNil(LqryApuracaoMensal) ;
    if Assigned(LcdsApuracaoMensal) then
    begin
      FreeAndNil(LcdsApuracaoMensal) ;
    end ;
    FreeAndNil(LqryTipoApuracaoMensal) ;
    if Assigned(LcdsTipoApuracaoMensal) then
    begin
      FreeAndNil(LcdsTipoApuracaoMensal) ;
    end ;
  end ;

end;

procedure TApuracaoLucroRealRelatorio.pCarregaContaControladaParteB(
  var AcdsDados: TUniClientDataSet; const AllTipo: TLacsLalur;
  const AtlrrTipoRelatorio: TTipoLucroRealRelatorio);
var
  LqrySaldoAnterior: TUniQuery ;
  LqryPeriodo: TUniQuery ;
  LcdsPeriodo: TUniClientDataSet ;
  LdictSaldoAnterior: TDictionary<string, double> ;
begin
  LqrySaldoAnterior := fCriaQuery ;
  LqryPeriodo := fCriaQuery ;
  LdictSaldoAnterior := nil;
  LcdsPeriodo := nil;
  try
    LqrySaldoAnterior.Close ;
    LqrySaldoAnterior.SQL.Clear ;
    LqrySaldoAnterior.SQL.Add(' SELECT SALCCB.SAL_CTACON, SALCCB.AUTOINCREM, SAL_DTALAN, SAL_VALLAN, SAL_CREDEB ') ;
    LqrySaldoAnterior.SQL.Add(' FROM SALCCB INNER JOIN CTACON ON SALCCB.SAL_CTACON = CTACON.CTA_CODCON ') ;
    LqrySaldoAnterior.SQL.Add('             LEFT JOIN CADEMP ON SALCCB.SAL_CODEMP = EMP_CODEMP ') ;
    LqrySaldoAnterior.SQL.Add('             LEFT JOIN HISPAD ON SALCCB.SAL_HISPAD = HISPAD.PAD_CODIGO ') ;
    if fCfgHisTpl then
      LqrySaldoAnterior.SQL.Add('             AND PAD_TPLACO = EMP_TPLACO ')
    else
      LqrySaldoAnterior.SQL.Add('             AND IFNULL(PAD_TPLACO, "") = "" ');
    LqrySaldoAnterior.SQL.Add(' WHERE SALCCB.SAL_DTALAN < :DTAINI ') ;
    LqrySaldoAnterior.SQL.Add('       ' + fRetornaFiltroContaControlada(AllTipo) ) ;
    LqrySaldoAnterior.SQL.Add('       AND SALCCB.SAL_CODEMP = :CODEMP ') ;
    LqrySaldoAnterior.SQL.Add(' ORDER BY SALCCB.SAL_CTACON, SALCCB.SAL_DTALAN, SALCCB.AUTOINCREM ') ;
    LqrySaldoAnterior.ParamByName('DTAINI').AsDate := FdtaPeriodoInicial ;
    LqrySaldoAnterior.ParamByName('CODEMP').AsString := FstrEmpresa ;
    LqrySaldoAnterior.Open ;

    LdictSaldoAnterior := fProcessaSaldoAnterior(LqrySaldoAnterior) ;

    LqryPeriodo.Close ;
    LqryPeriodo.SQL.Clear ;
    LqryPeriodo.SQL.Add(' SELECT SALCCB.SAL_CTACON, CTACON.CTA_DESCRI, SALCCB.AUTOINCREM, SAL_DTALAN, UPPER(TRIM(CONCAT(COALESCE(HISPAD.PAD_DESCRI,""), " ", COALESCE(SAL_HISTOR, "")))) AS SAL_HISTOR, SAL_VALLAN, SAL_CREDEB ') ;
    LqryPeriodo.SQL.Add(' FROM SALCCB INNER JOIN CTACON ON SALCCB.SAL_CTACON = CTACON.CTA_CODCON ') ;
    LqryPeriodo.SQL.Add('             LEFT JOIN CADEMP ON SALCCB.SAL_CODEMP = EMP_CODEMP ') ;
    LqryPeriodo.SQL.Add('             LEFT JOIN HISPAD ON SALCCB.SAL_HISPAD = HISPAD.PAD_CODIGO ') ;
    if fCfgHisTpl then
      LqryPeriodo.SQL.Add('             AND PAD_TPLACO = EMP_TPLACO ')
    else
      LqryPeriodo.SQL.Add('             AND IFNULL(PAD_TPLACO, "") = "" ');
    LqryPeriodo.SQL.Add(' WHERE SALCCB.SAL_DTALAN BETWEEN :DTAINI AND :DTAFIN ') ;
    LqryPeriodo.SQL.Add('       ' + fRetornaFiltroContaControlada(AllTipo) ) ;
    LqryPeriodo.SQL.Add('       AND SALCCB.SAL_CODEMP = :CODEMP ') ;
    LqryPeriodo.SQL.Add(' ORDER BY SALCCB.SAL_CTACON, SALCCB.SAL_DTALAN, SALCCB.AUTOINCREM ') ;
    LqryPeriodo.ParamByName('DTAINI').AsDateTime := FdtaPeriodoInicial ;
    LqryPeriodo.ParamByName('DTAFIN').AsDateTime := FdtaPeriodoFinal ;
    LqryPeriodo.ParamByName('CODEMP').AsString := FstrEmpresa ;
    LqryPeriodo.Open ;

    LcdsPeriodo := fCriaClientDatset(LqryPeriodo);
    LcdsPeriodo.IndexFieldNames := 'SAL_CTACON;SAL_DTALAN' ;

    if Assigned(AcdsDados) then
    begin
      AcdsDados.Close ;
      FreeAndNil(AcdsDados) ;
    end ;

    AcdsDados := fCriaCdsContasControladasParteB ;

    pCalculaSaldoContaControlada(LdictSaldoAnterior, LcdsPeriodo, AcdsDados);

  finally
    FreeAndNil(LqrySaldoAnterior) ;
    FreeAndNil(LqryPeriodo) ;
    if Assigned(LdictSaldoAnterior) then
    begin
      FreeAndNil(LdictSaldoAnterior) ;
    end ;
    if Assigned(LcdsPeriodo) then
    begin
      FreeAndNil(LcdsPeriodo) ;
    end ;
  end ;
end;

procedure TApuracaoLucroRealRelatorio.pCarregaDemonstrativoParteA(
  var AcdsDados: TUniClientDataSet; const AllTipo: TLacsLalur;
  const AtlrrTipoRelatorio: TTipoLucroRealRelatorio);
var
  LqryTotal: TUniquery ;
  LqryDetAdicaoExclusao: TUniquery ;
  LqryDetCompensacao: TUniquery ;

  LcdsDetAdicaoExclusao: TUniClientDataSet ;
  LcdsDetCompensacao: TUniClientDataSet ;

  LdictAdicoes, LdictExclusoes: TdictGrupoItens ;
  LdictSubItem: TdictSubGrupoItens ;
  LpairSubGrupo: TPair<String, Double> ;
begin
  LqryTotal := fCriaQuery() ;
  LqryDetAdicaoExclusao := fCriaQuery() ;
  LqryDetCompensacao := fCriaQuery() ;
  try

    ///totais
    LqryTotal.Close ;
    LqryTotal.SQL.Clear ;
    LqryTotal.SQL.Add(' SELECT ') ;
    LqryTotal.SQL.Add('   APUPRE.AUTOINCREM, ') ;
    LqryTotal.SQL.Add('   APUPRE.PRE_DTAINI, ') ;
    LqryTotal.SQL.Add('   APUPRE.PRE_DTAFIN, ') ;
    LqryTotal.SQL.Add('   APUPRE.PRE_VRANRE AS LUCRO_LIQUIDO, ') ;
    LqryTotal.SQL.Add('   APUVRE.VRE_VLADIC , ') ;
    LqryTotal.SQL.Add('   APUVRE.VRE_VLEXCL , ') ;
    LqryTotal.SQL.Add('   APUVRE.VRE_VLBCNG , ') ;
    LqryTotal.SQL.Add('   APUVRE.VRE_VLCOMP , ') ;
    LqryTotal.SQL.Add('   APUVRE.VRE_VLRBAS ') ;
    LqryTotal.SQL.Add(' FROM APUVRE ') ;
    LqryTotal.SQL.Add('      INNER JOIN APUPRE ON APUVRE.VRE_CODPRE = APUPRE.PRE_CODPRE ') ;
    LqryTotal.SQL.Add(' WHERE ' + fRetornaCondicaoQueryVazia(AtlrrTipoRelatorio) + ' AND APUVRE.VRE_TIPLAN = :TIPLAN ') ;
    LqryTotal.SQL.Add('       AND APUPRE.PRE_DTAFIN BETWEEN :DTAINI AND :DTAFIN ') ;
    LqryTotal.SQL.Add('       AND APUPRE.PRE_CODEMP = :CODEMP ') ;
    LqryTotal.SQL.Add(' ORDER BY APUPRE.PRE_DTAINI ') ;
    LqryTotal.ParamByName('TIPLAN').AsString := COD_LACS_LALUR[AllTipo] ;
    LqryTotal.ParamByName('DTAINI').AsDateTime := FdtaPeriodoInicial ;
    LqryTotal.ParamByName('DTAFIN').AsDateTime := FdtaPeriodoFinal ;
    LqryTotal.ParamByName('CODEMP').AsString := FstrEmpresa ;
    LqryTotal.Open ;

    ///adição/exclusao
    LqryDetAdicaoExclusao.Close ;
    LqryDetAdicaoExclusao.SQL.Clear ;
    LqryDetAdicaoExclusao.SQL.Add(' SELECT REL.AUTOINCREM, REL.PRE_DTAINI, REL.PRE_DTAFIN, REL.NATAJU, NATAJU.NAT_DESCRI, ') ;
    LqryDetAdicaoExclusao.SQL.Add(' SUM(CASE WHEN REL.ARE_CREDEB = "C" THEN COALESCE(REL.VAL_ADICAO,0.00)*-1 ELSE COALESCE(REL.VAL_ADICAO,0.00) END) AS VAL_ADICAO, ') ;
    LqryDetAdicaoExclusao.SQL.Add(' SUM(CASE WHEN REL.ARE_CREDEB = "D" THEN COALESCE(REL.VAL_EXCLUSAO, 0.00)*-1 ELSE COALESCE(REL.VAL_EXCLUSAO, 0.00) END) AS VAL_EXCLUSAO  FROM ( ') ;
    LqryDetAdicaoExclusao.SQL.Add(' 	SELECT ') ;
    LqryDetAdicaoExclusao.SQL.Add(' 	       APUPRE.AUTOINCREM, ') ;
    LqryDetAdicaoExclusao.SQL.Add(' 	       APUPRE.PRE_DTAINI, ') ;
    LqryDetAdicaoExclusao.SQL.Add(' 	       APUPRE.PRE_DTAFIN, ') ;
    LqryDetAdicaoExclusao.SQL.Add(' 	       CASE WHEN APUARE.ARE_LANCON IS NULL THEN NA_MANUAL.NAT_CODIGO ELSE PL_LANCON.NCO_NATAJU END AS NATAJU, ') ;
    LqryDetAdicaoExclusao.SQL.Add(' 	       CASE WHEN APUARE.ARE_LANCON IS NULL THEN (CASE WHEN NA_MANUAL.NAT_TIPMOV = "A" THEN APUARE.ARE_VALLAN ELSE 0.00 END) ELSE (CASE WHEN NA_LANCON.NAT_TIPMOV = "A" THEN LANCON.CON_VALLAN ELSE 0.00 END) END AS VAL_ADICAO, ') ;
    LqryDetAdicaoExclusao.SQL.Add(' 	       CASE WHEN APUARE.ARE_LANCON IS NULL THEN (CASE WHEN NA_MANUAL.NAT_TIPMOV = "E" THEN APUARE.ARE_VALLAN ELSE 0.00 END) ELSE (CASE WHEN NA_LANCON.NAT_TIPMOV = "E" THEN LANCON.CON_VALLAN ELSE 0.00 END) END AS VAL_EXCLUSAO, ') ;
    LqryDetAdicaoExclusao.SQL.Add(' 	       APUARE.ARE_CREDEB ') ;
    LqryDetAdicaoExclusao.SQL.Add(' 	FROM APUPRE ') ;
    LqryDetAdicaoExclusao.SQL.Add(' 	     INNER JOIN APUVRE ON APUVRE.VRE_CODPRE = APUPRE.PRE_CODPRE ') ;
    LqryDetAdicaoExclusao.SQL.Add(' 	     LEFT JOIN APUARE ON APUARE.ARE_CODVRE = APUVRE.AUTOINCREM ') ;
    LqryDetAdicaoExclusao.SQL.Add(' 	     LEFT JOIN LANCON ON APUARE.ARE_LANCON = LANCON.AUTOINCREM ') ;
    LqryDetAdicaoExclusao.SQL.Add(' 	     LEFT JOIN PLANCO AS PL_MANUAL ON APUARE.ARE_CODCON = PL_MANUAL.NCO_CODCON AND APUARE.ARE_TPLACO = PL_MANUAL.NCO_TPLACO AND PL_MANUAL.NCO_AJULIQ = "S" ') ;
    LqryDetAdicaoExclusao.SQL.Add(' 	     LEFT JOIN NATAJU AS NA_MANUAL ON PL_MANUAL.NCO_NATAJU = NA_MANUAL.NAT_CODIGO ') ;
    LqryDetAdicaoExclusao.SQL.Add(' 	     LEFT JOIN CADEMP ON LANCON.CON_EMPLAN = CADEMP.EMP_CODEMP ') ;
    LqryDetAdicaoExclusao.SQL.Add(' 	     LEFT JOIN PLANCO AS PL_LANCON ON CASE WHEN ARE_CREDEB = "D" THEN LANCON.CON_CONDEB ELSE LANCON.CON_CONCRE END = PL_LANCON.NCO_CODCON AND CADEMP.EMP_TPLACO = PL_LANCON.NCO_TPLACO AND PL_LANCON.NCO_AJULIQ = "S" ') ;
    LqryDetAdicaoExclusao.SQL.Add(' 	     LEFT JOIN NATAJU AS NA_LANCON ON PL_LANCON.NCO_NATAJU = NA_LANCON.NAT_CODIGO ') ;
    LqryDetAdicaoExclusao.SQL.Add(' 	WHERE ' + fRetornaCondicaoQueryVazia(AtlrrTipoRelatorio) + ' AND APUVRE.VRE_TIPLAN = :TIPLAN ') ;
    LqryDetAdicaoExclusao.SQL.Add(' 	      AND APUPRE.PRE_DTAFIN BETWEEN :DTAINI AND :DTAFIN ') ;
    LqryDetAdicaoExclusao.SQL.Add(' 	      AND APUPRE.PRE_CODEMP = :CODEMP ') ;
    LqryDetAdicaoExclusao.SQL.Add(' ) AS REL LEFT JOIN NATAJU ON REL.NATAJU = NATAJU.NAT_CODIGO ') ;
    LqryDetAdicaoExclusao.SQL.Add(' GROUP BY REL.AUTOINCREM, REL.PRE_DTAINI, REL.PRE_DTAFIN, REL.NATAJU, NATAJU.NAT_DESCRI ') ;
    LqryDetAdicaoExclusao.SQL.Add(' ORDER BY REL.AUTOINCREM ') ;
    LqryDetAdicaoExclusao.ParamByName('TIPLAN').AsString := COD_LACS_LALUR[AllTipo] ;
    LqryDetAdicaoExclusao.ParamByName('DTAINI').AsDateTime := FdtaPeriodoInicial ;
    LqryDetAdicaoExclusao.ParamByName('DTAFIN').AsDateTime := FdtaPeriodoFinal ;
    LqryDetAdicaoExclusao.ParamByName('CODEMP').AsString := FstrEmpresa ;
    LqryDetAdicaoExclusao.Open ;

    LcdsDetAdicaoExclusao := fCriaClientDatset(LqryDetAdicaoExclusao) ;
    LcdsDetAdicaoExclusao.IndexFieldNames := 'AUTOINCREM' ;

    pAcumulaAdicaoExclusao(LcdsDetAdicaoExclusao) ;

    ///compensação
    LqryDetCompensacao.Close ;
    LqryDetCompensacao.SQL.Clear ;
    LqryDetCompensacao.SQL.Add(' SELECT APUPRE.AUTOINCREM, CDE_VALLAN, CDE_CTACON, CTACON.CTA_DESCRI ') ;
    LqryDetCompensacao.SQL.Add('   FROM APUPRE INNER JOIN APUVRE ON APUVRE.VRE_CODPRE = APUPRE.PRE_CODPRE ') ;
    LqryDetCompensacao.SQL.Add('               INNER JOIN APUCRE ON APUCRE.CRE_CODVRE = APUVRE.AUTOINCREM ') ;
    LqryDetCompensacao.SQL.Add('               INNER JOIN APUCDE ON APUCDE.CDE_CODCRE = APUCRE.AUTOINCREM ') ;
    LqryDetCompensacao.SQL.Add('               INNER JOIN CTACON ON APUCDE.CDE_CTACON = CTACON.CTA_CODCON ') ;
    LqryDetCompensacao.SQL.Add(' WHERE ' + fRetornaCondicaoQueryVazia(AtlrrTipoRelatorio) + ' AND APUVRE.VRE_TIPLAN = :TIPLAN ') ;
    LqryDetCompensacao.SQL.Add(' 	      AND APUPRE.PRE_DTAFIN BETWEEN :DTAINI AND :DTAFIN ') ;
    LqryDetCompensacao.SQL.Add(' 	      AND APUPRE.PRE_CODEMP = :CODEMP ') ;
    LqryDetCompensacao.SQL.Add(' 	      AND COALESCE(CDE_VALLAN, 0.00) <> 0.00 ') ;
    LqryDetCompensacao.ParamByName('TIPLAN').AsString := COD_LACS_LALUR[AllTipo] ;
    LqryDetCompensacao.ParamByName('DTAINI').AsDateTime := FdtaPeriodoInicial ;
    LqryDetCompensacao.ParamByName('DTAFIN').AsDateTime := FdtaPeriodoFinal ;
    LqryDetCompensacao.ParamByName('CODEMP').AsString := FstrEmpresa ;
    LqryDetCompensacao.Open ;

    LcdsDetCompensacao := fCriaClientDatset(LqryDetCompensacao) ;
    LcdsDetCompensacao.IndexFieldNames := 'AUTOINCREM' ;

    ///cria cds de agrupamento.
    if Assigned(AcdsDados) then
    begin
      AcdsDados.Close ;
      FreeAndNil(AcdsDados) ;
    end ;

    AcdsDados := fCriaCdsDemonstrativoParteA ;

    LqryTotal.DisableControls ;
    LcdsDetAdicaoExclusao.DisableControls ;
    LcdsDetCompensacao.DisableControls ;
    try
      pDesmembraAdicaoExclusao(LcdsDetAdicaoExclusao, LdictAdicoes, LdictExclusoes);

      LqryTotal.First ;
      while not LqryTotal.Eof do
      begin
        AcdsDados.Append ;
        AcdsDados.FieldByName('AUTOINCREM').AsString := LqryTotal.FieldByName('AUTOINCREM').AsString ;
        AcdsDados.FieldByName('DTAINI').AsDateTime := LqryTotal.FieldByName('PRE_DTAINI').AsDateTime ;
        AcdsDados.FieldByName('DTAFIN').AsDateTime := LqryTotal.FieldByName('PRE_DTAFIN').AsDateTime ;
        AcdsDados.FieldByName('DESCRI').AsString := DESCR_LUCRO_LIQUIDO[AllTipo] ;
        AcdsDados.FieldByName('TOTAL_').AsFloat := LqryTotal.FieldByName('LUCRO_LIQUIDO').AsFloat ;
        AcdsDados.Post ;

        ///linha em branco
        AcdsDados.Append ;
        AcdsDados.FieldByName('AUTOINCREM').AsString := LqryTotal.FieldByName('AUTOINCREM').AsString ;
        AcdsDados.FieldByName('DTAINI').AsDateTime := LqryTotal.FieldByName('PRE_DTAINI').AsDateTime ;
        AcdsDados.FieldByName('DTAFIN').AsDateTime := LqryTotal.FieldByName('PRE_DTAFIN').AsDateTime ;
        AcdsDados.Post ;

        if LdictAdicoes.ContainsKey(LqryTotal.FieldByName('AUTOINCREM').AsString) then
        begin
          AcdsDados.Append ;
          AcdsDados.FieldByName('AUTOINCREM').AsString := LqryTotal.FieldByName('AUTOINCREM').AsString ;
          AcdsDados.FieldByName('DTAINI').AsDateTime := LqryTotal.FieldByName('PRE_DTAINI').AsDateTime ;
          AcdsDados.FieldByName('DTAFIN').AsDateTime := LqryTotal.FieldByName('PRE_DTAFIN').AsDateTime ;
          AcdsDados.FieldByName('DESCRI').AsString := 'ADIÇÕES:' ;
          AcdsDados.Post ;

          LdictSubItem := LdictAdicoes.Items[LqryTotal.FieldByName('AUTOINCREM').AsString] ;
          for LpairSubGrupo in LdictSubItem do
          begin
            AcdsDados.Append ;
            AcdsDados.FieldByName('AUTOINCREM').AsString := LqryTotal.FieldByName('AUTOINCREM').AsString ;
            AcdsDados.FieldByName('DTAINI').AsDateTime := LqryTotal.FieldByName('PRE_DTAINI').AsDateTime ;
            AcdsDados.FieldByName('DTAFIN').AsDateTime := LqryTotal.FieldByName('PRE_DTAFIN').AsDateTime ;
            AcdsDados.FieldByName('DESCRI').AsString := ESPACO_IDENTACAO + LpairSubGrupo.Key ;
            AcdsDados.FieldByName('VALOR_').AsFloat := LpairSubGrupo.Value ;
            AcdsDados.Post ;
          end ;
          ///totaliza na ultima linha do grupo
          AcdsDados.Edit ;
          AcdsDados.FieldByName('TOTAL_').AsFloat := LqryTotal.FieldByName('VRE_VLADIC').AsFloat ;
          AcdsDados.Post ;

          ///linha em branco
          AcdsDados.Append ;
          AcdsDados.FieldByName('AUTOINCREM').AsString := LqryTotal.FieldByName('AUTOINCREM').AsString ;
          AcdsDados.FieldByName('DTAINI').AsDateTime := LqryTotal.FieldByName('PRE_DTAINI').AsDateTime ;
          AcdsDados.FieldByName('DTAFIN').AsDateTime := LqryTotal.FieldByName('PRE_DTAFIN').AsDateTime ;
          AcdsDados.Post ;
        end ;

        if LdictExclusoes.ContainsKey(LqryTotal.FieldByName('AUTOINCREM').AsString) then
        begin
          AcdsDados.Append ;
          AcdsDados.FieldByName('AUTOINCREM').AsString := LqryTotal.FieldByName('AUTOINCREM').AsString ;
          AcdsDados.FieldByName('DTAINI').AsDateTime := LqryTotal.FieldByName('PRE_DTAINI').AsDateTime ;
          AcdsDados.FieldByName('DTAFIN').AsDateTime := LqryTotal.FieldByName('PRE_DTAFIN').AsDateTime ;
          AcdsDados.FieldByName('DESCRI').AsString := 'EXCLUSÕES:' ;
          AcdsDados.Post ;

          LdictSubItem := LdictExclusoes.Items[LqryTotal.FieldByName('AUTOINCREM').AsString] ;
          for LpairSubGrupo in LdictSubItem do
          begin
            AcdsDados.Append ;
            AcdsDados.FieldByName('AUTOINCREM').AsString := LqryTotal.FieldByName('AUTOINCREM').AsString ;
            AcdsDados.FieldByName('DTAINI').AsDateTime := LqryTotal.FieldByName('PRE_DTAINI').AsDateTime ;
            AcdsDados.FieldByName('DTAFIN').AsDateTime := LqryTotal.FieldByName('PRE_DTAFIN').AsDateTime ;
            AcdsDados.FieldByName('DESCRI').AsString := ESPACO_IDENTACAO + LpairSubGrupo.Key ;
            AcdsDados.FieldByName('VALOR_').AsFloat := LpairSubGrupo.Value ;
            AcdsDados.Post ;
          end ;
          ///totaliza na ultima linha do grupo
          AcdsDados.Edit ;
          AcdsDados.FieldByName('TOTAL_').AsFloat := LqryTotal.FieldByName('VRE_VLEXCL').AsFloat ;
          AcdsDados.Post ;

          ///linha em branco
          AcdsDados.Append ;
          AcdsDados.FieldByName('AUTOINCREM').AsString := LqryTotal.FieldByName('AUTOINCREM').AsString ;
          AcdsDados.FieldByName('DTAINI').AsDateTime := LqryTotal.FieldByName('PRE_DTAINI').AsDateTime ;
          AcdsDados.FieldByName('DTAFIN').AsDateTime := LqryTotal.FieldByName('PRE_DTAFIN').AsDateTime ;
          AcdsDados.Post ;
        end ;

        AcdsDados.Append ;
        AcdsDados.FieldByName('AUTOINCREM').AsString := LqryTotal.FieldByName('AUTOINCREM').AsString ;
        AcdsDados.FieldByName('DTAINI').AsDateTime := LqryTotal.FieldByName('PRE_DTAINI').AsDateTime ;
        AcdsDados.FieldByName('DTAFIN').AsDateTime := LqryTotal.FieldByName('PRE_DTAFIN').AsDateTime ;
        AcdsDados.FieldByName('DESCRI').AsString := DESCR_BASE_CALCULO_ANTES_COMPENSACAO[AllTipo] ;
        AcdsDados.FieldByName('TOTAL_').AsFloat := LqryTotal.FieldByName('VRE_VLBCNG').AsFloat ;
        AcdsDados.Post ;

        ///linha em branco
        AcdsDados.Append ;
        AcdsDados.FieldByName('AUTOINCREM').AsString := LqryTotal.FieldByName('AUTOINCREM').AsString ;
        AcdsDados.FieldByName('DTAINI').AsDateTime := LqryTotal.FieldByName('PRE_DTAINI').AsDateTime ;
        AcdsDados.FieldByName('DTAFIN').AsDateTime := LqryTotal.FieldByName('PRE_DTAFIN').AsDateTime ;
        AcdsDados.Post ;

        if LcdsDetCompensacao.FindKey([LqryTotal.FieldByName('AUTOINCREM').AsString]) then
        begin

          AcdsDados.Append ;
          AcdsDados.FieldByName('AUTOINCREM').AsString := LqryTotal.FieldByName('AUTOINCREM').AsString ;
          AcdsDados.FieldByName('DTAINI').AsDateTime := LqryTotal.FieldByName('PRE_DTAINI').AsDateTime ;
          AcdsDados.FieldByName('DTAFIN').AsDateTime := LqryTotal.FieldByName('PRE_DTAFIN').AsDateTime ;
          AcdsDados.FieldByName('DESCRI').AsString := DESCR_COMPENSACAO[AllTipo] ;
          AcdsDados.Post ;

          while (LqryTotal.FieldByName('AUTOINCREM').AsString = LcdsDetCompensacao.FieldByName('AUTOINCREM').AsString)
                 and (not LcdsDetCompensacao.Eof) do
          begin

            AcdsDados.Append ;
            AcdsDados.FieldByName('AUTOINCREM').AsString := LqryTotal.FieldByName('AUTOINCREM').AsString ;
            AcdsDados.FieldByName('DTAINI').AsDateTime := LqryTotal.FieldByName('PRE_DTAINI').AsDateTime ;
            AcdsDados.FieldByName('DTAFIN').AsDateTime := LqryTotal.FieldByName('PRE_DTAFIN').AsDateTime ;
            AcdsDados.FieldByName('DESCRI').AsString := ESPACO_IDENTACAO + LcdsDetCompensacao.FieldByName('CDE_CTACON').AsString + '-' + LcdsDetCompensacao.FieldByName('CTA_DESCRI').AsString ;
            AcdsDados.FieldByName('VALOR_').AsFloat := LcdsDetCompensacao.FieldByName('CDE_VALLAN').AsFloat ;
            AcdsDados.Post ;

            LcdsDetCompensacao.Next ;
          end ;
          ///totaliza na ultima linha do grupo
          AcdsDados.Edit ;
          AcdsDados.FieldByName('TOTAL_').AsFloat := LqryTotal.FieldByName('VRE_VLCOMP').AsFloat ;
          AcdsDados.Post ;

          ///linha em branco
          AcdsDados.Append ;
          AcdsDados.FieldByName('AUTOINCREM').AsString := LqryTotal.FieldByName('AUTOINCREM').AsString ;
          AcdsDados.FieldByName('DTAINI').AsDateTime := LqryTotal.FieldByName('PRE_DTAINI').AsDateTime ;
          AcdsDados.FieldByName('DTAFIN').AsDateTime := LqryTotal.FieldByName('PRE_DTAFIN').AsDateTime ;
          AcdsDados.Post ;
        end ;

        AcdsDados.Append ;
        AcdsDados.FieldByName('AUTOINCREM').AsString := LqryTotal.FieldByName('AUTOINCREM').AsString ;
        AcdsDados.FieldByName('DTAINI').AsDateTime := LqryTotal.FieldByName('PRE_DTAINI').AsDateTime ;
        AcdsDados.FieldByName('DTAFIN').AsDateTime := LqryTotal.FieldByName('PRE_DTAFIN').AsDateTime ;
        AcdsDados.FieldByName('DESCRI').AsString := DESCR_BASE_CALCULO[AllTipo] ;
        AcdsDados.FieldByName('TOTAL_').AsFloat := LqryTotal.FieldByName('VRE_VLRBAS').AsFloat ;
        AcdsDados.Post ;

        LqryTotal.Next ;
      end ;
    finally
      LqryTotal.EnableControls ;
      LcdsDetAdicaoExclusao.EnableControls ;
      LcdsDetCompensacao.EnableControls ;
      ///free
      FreeAndNil(LdictAdicoes) ;
      FreeAndNil(LdictExclusoes) ;
    end ;

  finally
    FreeAndNil(LqryTotal) ;
    FreeAndNil(LqryDetAdicaoExclusao) ;
    FreeAndNil(LqryDetCompensacao) ;
  end ;

end;

procedure TApuracaoLucroRealRelatorio.pChaveDictParaLstOrdenada(
  const AdictColunaDeducaoRetencao: TdictColunaDeducaoRetencao;
  const AstrTipoDedRet: string; const AiiTipo: TCsllIrpj;
  var AlstOrdenada: TStringList);
var
  LpairDeducaoRetencao: TPair<string, TValoresDeducaoRetencao> ;
  LDictPosicoes: TDictionary<string, Integer>;
  LArrCodigos: TArray<string>;
  LAuxCodigo: string;
  I, J: Integer;
begin
  AlstOrdenada.Clear ;
  AlstOrdenada.Sorted := False;

  LDictPosicoes := TDictionary<string, Integer>.Create;
  try
    //identificando array de ordem a ser usado e mapeando as posições para um dict auxiliar
    if AiiTipo = iiCSLL then
    begin
      if AstrTipoDedRet = 'D' then
        for I := 0 to High(CODIGOS_CSLL_DED) do LDictPosicoes.Add(CODIGOS_CSLL_DED[I], I)
      else if AstrTipoDedRet = 'R' then
        for I := 0 to High(CODIGOS_CSLL_RET) do LDictPosicoes.Add(CODIGOS_CSLL_RET[I], I);
    end
    else if AiiTipo = iiIRPJ then
    begin
      if AstrTipoDedRet = 'D' then
        for I := 0 to High(CODIGOS_IRPJ_DED) do LDictPosicoes.Add(CODIGOS_IRPJ_DED[I], I)
      else if AstrTipoDedRet = 'R' then
        for I := 0 to High(CODIGOS_IRPJ_RET) do LDictPosicoes.Add(CODIGOS_IRPJ_RET[I], I);
    end;

    SetLength(LArrCodigos, 0);
    //extraindo chaves do dict principal (códigos) para array
    for LpairDeducaoRetencao in AdictColunaDeducaoRetencao do
    begin
      if (LpairDeducaoRetencao.Value.tipo = AstrTipoDedRet) and (LDictPosicoes.ContainsKey(LpairDeducaoRetencao.Key)) then
      begin
        SetLength(LArrCodigos, Length(LArrCodigos) + 1);
        LArrCodigos[High(LArrCodigos)] := LpairDeducaoRetencao.Key;
      end ;
    end ;

    //ordenar array de códigos de acordo com as posições mapeadas no dict auxiliar
    for I := 0 to High(LArrCodigos) - 1 do
    begin
      for J := I + 1 to High(LArrCodigos) do
      begin
        if LDictPosicoes[LArrCodigos[I]] > LDictPosicoes[LArrCodigos[J]] then
        begin
          LAuxCodigo := LArrCodigos[I];
          LArrCodigos[I] := LArrCodigos[J];
          LArrCodigos[J] := LAuxCodigo;
        end;
      end;
    end;

    //adicionar códigos ordenados na string list
    for I := 0 to High(LArrCodigos) do
      AlstOrdenada.Add(LArrCodigos[I]);

  finally
    FreeAndNil(LDictPosicoes);
  end;
end;

procedure TApuracaoLucroRealRelatorio.pDesmembraAdicaoExclusao(
  const AcdsDados: TUniClientDataset; var AdictAdicoes,
  AdictExclusoes: TdictGrupoItens);
var
  LdictSubItem: TdictSubGrupoItens ;
  LstrDescricao: string ;
begin
  AdictAdicoes := TdictGrupoItens.Create([doOwnsValues]);
  AdictExclusoes := TdictGrupoItens.Create([doOwnsValues]);

  AcdsDados.First ;
  while not AcdsDados.Eof do
  begin
    if AcdsDados.FieldByName('VAL_ADICAO').AsFloat <> 0.00 then
    begin
      if not AdictAdicoes.ContainsKey(AcdsDados.FieldByName('AUTOINCREM').AsString) then
      begin
        LdictSubItem := TdictSubGrupoItens.Create();
        AdictAdicoes.Add(AcdsDados.FieldByName('AUTOINCREM').AsString, LdictSubItem);
      end ;
      LstrDescricao := AcdsDados.FieldByName('NATAJU').AsString + '-' + AcdsDados.FieldByName('NAT_DESCRI').AsString  ;
      LdictSubItem := AdictAdicoes.Items[AcdsDados.FieldByName('AUTOINCREM').AsString] ;
      if LdictSubItem.ContainsKey(LstrDescricao) then
        LdictSubItem.Items[LstrDescricao] := LdictSubItem.Items[LstrDescricao] + AcdsDados.FieldByName('VAL_ADICAO').AsFloat
      else
        LdictSubItem.Add(LstrDescricao, AcdsDados.FieldByName('VAL_ADICAO').AsFloat);
    end ;

    if AcdsDados.FieldByName('VAL_EXCLUSAO').AsFloat <> 0.00 then
    begin
      if not AdictExclusoes.ContainsKey(AcdsDados.FieldByName('AUTOINCREM').AsString) then
      begin
        LdictSubItem := TdictSubGrupoItens.Create();
        AdictExclusoes.Add(AcdsDados.FieldByName('AUTOINCREM').AsString, LdictSubItem);
      end ;
      LstrDescricao := AcdsDados.FieldByName('NATAJU').AsString + '-' + AcdsDados.FieldByName('NAT_DESCRI').AsString  ;
      LdictSubItem := AdictExclusoes.Items[AcdsDados.FieldByName('AUTOINCREM').AsString] ;
      if LdictSubItem.ContainsKey(LstrDescricao) then
        LdictSubItem.Items[LstrDescricao] := LdictSubItem.Items[LstrDescricao] + AcdsDados.FieldByName('VAL_EXCLUSAO').AsFloat
      else
        LdictSubItem.Add(LstrDescricao, AcdsDados.FieldByName('VAL_EXCLUSAO').AsFloat);
    end ;

    AcdsDados.Next ;
  end ;

end;

procedure TApuracaoLucroRealRelatorio.pFreeAndNil(var AptObj: Pointer);
begin
  if Assigned(AptObj) then
  begin
    FreeAndNil(AptObj) ;
  end ;
end;

procedure TApuracaoLucroRealRelatorio.pSetEmpresa(const AstrEmpresa: String);
begin
  FstrEmpresa := AstrEmpresa ;
end;

end.
